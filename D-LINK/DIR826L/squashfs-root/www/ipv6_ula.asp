<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script>
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=2";
	param.arg +="&oid_1=IGD_ULA_&inst_1=10000";
	param.arg +="&oid_2=IGD_Status_IPv6Status_&inst_2=11100";
	get_config_obj(param);

	var enable_ula = config_val("igdULASetup_ULAEnable_");
	var defulaprefix = config_val("igdULASetup_DefaultULAPrefix_");
	var lan_ula_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanULAAddress_"));
	var currect_ulaprefix = config_val("igdIPv6Status_IPv6ULACurrPrefix_");
	var ulaprefix =config_val("igdULASetup_ULAPrefix_");
	var def_ulaprefix =  config_val("igdIPv6Status_IPv6ULADefPrefix_");
	var submit_button_flag = 0;

    function onPageLoad()
	{
    	set_checked(enable_ula, $('#ulaEnable')[0]);
		set_checked(defulaprefix, $('#usedefault')[0]);
		default_ula();
		disable_ula();
		$('#ula_prefix').val(ulaprefix);
		if(enable_ula == 1)
		{
			$('#currect_ula_prefix').html(currect_ulaprefix.toUpperCase()+" /64");
	        $('#current_ula_lan').html(lan_ula_addr.toUpperCase()+" /64");
	    }else
	    {
	      	$('#currect_ula_prefix').html("");
	        $('#current_ula_lan').html("");
	    }
		if(defulaprefix == 1)
			$('#ula_prefix').val(def_ulaprefix);
    }

	function disable_ula()
	{
		if($('#ulaEnable')[0].checked){
			$('#usedefault').attr('disabled','');
			if($('#usedefault')[0].checked)
				$('#ula_prefix').attr('disabled',true);
			else
				$('#ula_prefix').attr('disabled','');
		}else{
			$('#usedefault').attr('disabled',true);
			$('#ula_prefix').attr('disabled',true);
		}
	}

	function default_ula()
	{
		if($('#usedefault')[0].checked){
			$('#ula_prefix').val(def_ulaprefix);
			$('#ula_prefix').attr('disabled',true);
		}else{
			$('#ula_prefix').val(ulaprefix);
			$('#ula_prefix').attr('disabled','');
		}
	}

	function send_request()
	{
		var ula_prefix = $('#ula_prefix').val();
		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,"ULA Prefix");
		var temp_ula_prefix = new ipv6_addr_obj(ula_prefix.split(":"), ipv6_static_msg, false, false);
		var colon_count = ula_prefix.split(":");
 
		if($('#ula_prefix').val() == "" && $('#ulaEnable')[0].checked){
			if(!confirm(get_words('MSG048')+"\n("+def_ulaprefix+"/64)"))
				return false;
			else
				$('#ula_prefix').val(def_ulaprefix);

		}else if($('#ulaEnable')[0].checked){
			if(check_ipv6_symbol(ula_prefix,"::") == 2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(ula_prefix,"::") == 1){    // find one '::' symbol
				if(ula_prefix.substr(0,1) != "f" && ula_prefix.substr(0,1) != "F"){
					alert(get_words('MSG047'));
					return false;
				}
				if(ula_prefix.substr(1,1) != "d" && ula_prefix.substr(1,1) != "D" && 
				   ula_prefix.substr(1,1) != "c" && ula_prefix.substr(1,1) != "C"){
						alert(get_words('MSG047'));
					return false;
				}
				if(ula_prefix.substr(2,1) == ":" || ula_prefix.substr(3,1) == ":"){ 
					alert(get_words('MSG047'));
					return false;
				}
				if(colon_count.length > 6){
						alert(get_words('MSG047'));
					return false;
				}
				temp_ula_prefix = new ipv6_addr_obj(ula_prefix.split("::"), ipv6_static_msg, false, false);
				if(temp_ula_prefix.addr[temp_ula_prefix.addr.length-1].length != 0){
						alert(get_words('MSG047'));
					return false;
				}
				else
					temp_ula_prefix.addr[temp_ula_prefix.addr.length-1] = "1111";
				if (!check_ipv6_address(temp_ula_prefix,"::"))
					return false;
			}else{  //not find '::' symbol
				alert(get_words(MSG047));
				return false;
			}
		}

		if (submit_button_flag == 0)
		{
			submit_button_flag = 1;
			submitula();
			return true;
        }
        return false;
    }

	function submitula()
	{
		var param1 = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6_ULA&nextPage=ipv6_ula.asp'
		};
		param1.arg += "&igdULASetup_ULAEnable_1.1.0.0.0="+get_checked_value($('#ulaEnable')[0]);
		param1.arg += "&igdULASetup_DefaultULAPrefix_1.1.0.0.0="+get_checked_value($('#usedefault')[0]);
		param1.arg += "&igdULASetup_ULAPrefix_1.1.0.0.0="+$('#ula_prefix').val();				
		get_config_obj(param1);
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><script>document.write(dev_info.model);</script></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
	<td>&nbsp;</td>
	</tr>
	</table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
	</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
	<tr id="topnav_container">
		<td><img src="short_modnum.gif" width="125" height="25"></td>
		<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table cellSpacing=0 cellPadding=0 border=0>
			<tbody>
			<tr>
				<td id=sidenav_container>
				<div id=sidenav>
					<ul>
						<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
						<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
						<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
						<li><div id="sidenavon"><a href="storage_setup.asp" onclick="return jump_if();"><script>show_words(storage)</script></a></div></li>
						<li><div id="sidenavoff"><script>show_words(IPV6_TEXT137)</script></a></div></li>
						<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
					</ul>
				</div>
				</td>
			</tr>
			</tbody>
		</table></td>

	<form id="form1" name="form1" method="post" action="apply.cgi">
		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id="maincontent">
			<div id=box_header>
			<h1><script>show_words(IPV6_ULA_TEXT14)</script></h1>
			<script>show_words(IPV6_ULA_TEXT11)</script><br>
			<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_link_local.asp');">
				<script>$('#button').val(get_words('_savesettings'));</script>
				<script>$('#button2').val(get_words('_dontsavesettings'));</script>
			</div>
			<div class=box>
				<h2 style=" text-transform:none">
				<script>show_words(IPV6_ULA_TEXT01)</script></h2>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="185" align=right class="duple">
						<script>show_words(IPV6_ULA_TEXT02)</script>
					:</td>
					<td width="333" colSpan=3>&nbsp;&nbsp;
						<input name="ulaEnable" type=checkbox id="ulaEnable" value="1" onClick="disable_ula();">
						<input type="hidden" id="ula_enable" name="ula_enable" value="">
					</td>
				</tr>
				<tr>
					<td width="185" align=right class="duple">
						<script>show_words(IPV6_ULA_TEXT03)</script>
					:</td>
					<td width="333" colSpan=3>&nbsp;&nbsp;
						<input name="usedefault" id="usedefault" type="checkbox" value="1" onClick="default_ula();">
						<input type="hidden" id="use_default" name="use_default" value="">
					</td>
				</tr>
				<tr>
					<td width="185" align=right class="duple">
						<script>show_words(IPV6_ULA_TEXT04)</script>
					:</td>
					<td width="333" colSpan=3>&nbsp;&nbsp;
						<input type=text id="ula_prefix" name="ula_prefix" size="25" maxlength="40" value="">
					<b>/64</b>
					</td>
				</tr>
				</table>
			</div>
			<div class=box >
				<h2 style=" text-transform:none"><script>show_words(IPV6_ULA_TEXT05)</script></h2>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="206" align=right class="duple"><script>show_words(IPV6_ULA_TEXT06)</script> :</td>
					<td width="331">&nbsp;&nbsp;<b><span id="currect_ula_prefix" name="currect_ula_prefix"></span></b></td>
				</tr>
				<tr>
					<td width="206" align=right class="duple"><script>show_words(IPV6_ULA_TEXT07)</script> :</td>
					<td width="331">&nbsp;&nbsp;<b><span id="current_ula_lan" name="current_ula_lan"></span></b></td>
				</tr>
				</table>
			</div>
		</td>
	</form>
		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
			<tbody>
			<tr>
				<td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
					<p><script>show_words(IPV6_ULA_TEXT13)</script></p>
					<p><a href="support_internet.asp#ipv6_ULA" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
				</td>
			</tr>
			</tbody>
		</table>
		</td>
	</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td><td>&nbsp;</td>
	</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>