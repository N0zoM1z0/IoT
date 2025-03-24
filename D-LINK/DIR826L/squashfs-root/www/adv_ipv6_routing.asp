<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script src="uk.js" type="text/javascript"></script> 
<script language="JavaScript" src="public.js"></script> 
<script language="JavaScript" src="public_msg.js"></script> 
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script> 
<script language="Javascript" src="js/xml.js"></script> 
<script language="Javascript" src="js/object.js"></script> 
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=1&"+
				"oid_1=IGD_Layer3Forwarding_ForwardingV6_i_&inst_1=11000"
	};
	get_config_obj(param);

	var array_enable 		 	= config_str_multi("fwdV6Rule_Enable_");
	var array_name 			 	= config_str_multi("fwdV6Rule_Name_");
	var array_destipv6ip	 	= config_str_multi("fwdV6Rule_DestIPv6Address_");
	var array_destipv6prefix 	= config_str_multi("fwdV6Rule_DestIPv6AddressPrefixLength_");
	var array_sourceinterface	= config_str_multi("fwdV6Rule_SourceInterface_");
	var array_gatewayip	 	 	= config_str_multi("fwdV6Rule_GatewayIPAddress_");
	var array_metric		 	= config_str_multi("fwdV6Rule_ForwardingMetric_");

	var submit_button_flag = 0;
	var rule_max_num = 10;
	var inbound_used = 0;
	
	function onPageLoad()
	{
		var login_who=login_Info;
		if(login_who!= "w")// || dev_mode == "1"){
			DisableEnableForm(form2,true);
		setTimeout("paint_table()", 5);
	}

	function set_vs_protocol(i, which_value, obj)
	{
		set_selectIndex(which_value,obj);
		$('#protocol'+i).attr('disabled',true);
		if(which_value != obj.options[obj.selectedIndex].value){
			$('#protocol'+i).attr('disabled',false);
			$('#protocol_select'+i)[0].selectedIndex = 3;
		}
		$('#protocol'+i).val(which_value);
	}

    function protocol_change(i)
	{
		var sel = $('#protocol_select'+i).attr("selectedIndex");
		if(sel < 3){ //TCP, UDP, Both, Other
			$("#protocol"+i).attr('disabled', 'disabled');
			$("#public_portS"+i).attr('disabled', '');
			$("#private_portS"+i).attr('disabled', '');
			$("#protocol"+i).val($('#protocol_select'+i).val());
		}else if($('#protocol_select'+i)[0].selectedIndex == 3){ // Other
			$("#public_portS"+i).val('0');
			$("#private_portS"+i).val('0');
			$("#protocol"+i).attr('disabled', '');
		}
		if(login_Info != "w")
		{
			$("#protocol"+i).attr('disabled', 'disabled');
			$("#public_portS"+i).attr('disabled', 'disabled');
			$("#private_portS"+i).attr('disabled', 'disabled');
		}
	}

	function detect_protocol_change_port(proto,i)
	{
		if((proto == 0)||(proto == 1)||(proto == 2)){
			$('#protocol'+i).attr('disabled',true);
			$('#public_portS'+i).attr('disabled',false);
			$('#private_portS'+i).attr('disabled',false);
		}else{
			$('#public_portS'+i).attr('disabled',true);
			$('#private_portS'+i).attr('disabled',true);
		}
		if(login_Info != "w")
		{
			$('#protocol'+i).attr('disabled',true);
			$('#public_portS'+i).attr('disabled',true);
			$('#private_port'+i).attr('disabled',true);
		}
	}

	function send_request()
	{
		var tcp_timeline = '';
		var udp_timeline = '';
		var dest_ip = '';
		var ipv6_msg = replace_msg(all_ipv6_addr_msg,"IPv6 address");

		if (!is_form_modified("form3") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			if ($('#enable'+i)[0].checked == true)
			{
				//20120503 silvia add
				dest_ip = $('#dest_ipv6_addr'+i).val();
			
				if(check_ipv6_symbol(dest_ip,"::")==2){ // find two '::' symbol
					return false;
				}else if(check_ipv6_symbol(dest_ip,"::")==1){    // find one '::' symbol
					temp_ipv6 = new ipv6_addr_obj(dest_ip.split("::"), ipv6_msg, false, false);
					if (!check_ipv6_route_address(temp_ipv6 ,"::"))
						return false;
				}else{  //not find '::' symbol
				
					temp_ipv6  = new ipv6_addr_obj(dest_ip.split(":"), ipv6_msg, false, false);
					if (!check_ipv6_route_address(temp_ipv6,":"))
						return false;
				}
			
				if($('#dest_ipv6_addr'+i).val()=="")
				{
					alert(which_lang[MSG042]);
					return false;
				}
				if($('#dest_ipv6_addr'+i).val()=="")
				{
					alert(which_lang[ZERO_IPV6_ADDRESS]);
					return false;
				}
				if(($('#interface_list'+i)[0].selectedIndex==1)||($('#interface_list'+i)[0].selectedIndex==2))
				{
					if($('#gateway'+i).val()=="")
					{
						alert(which_lang[MSG042]);
						return false;
					}
					if($('#gateway'+i).val()=="")
					{
						alert(addstr(which_lang[MSG007],which_lang[wwa_gw]));
						return false;
					}
				}
				if($('#interface_list'+i)[0].selectedIndex!=3)
				{
					if($('#metric'+i).val()=="")
					{
						alert(which_lang[metric_empty]);
						return false;
					}
				}
			}
			var temp_port_name = $('#name'+i).val();
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == $('#name'+j).val()){
						alert(addstr(which_lang[av_alert_16], $('#name'+j).val()));
						return false;
					}
				}
			}
		}

		for (var i = 0; i < rule_max_num; i++)
		{
			var check_name = $('#name'+i).val();
			var temp_vs;

			if ($('#name'+i).val() != ""){
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert(addstr(which_lang[TEXT002], $('#name'+i).val()));
					return false;
				}

				var name_string = $('#name'+i).val().toUpperCase();
		        count++;
			} else {
				if ($('#enable'+i)[0].checked == true) {
					alert(which_lang[r6_name_empty]);
					return false;
				}
			}
		}

		if (submit_button_flag == 0) {
			submit_setting();
			submit_button_flag = 1;
		}
	}

	function submit_setting()
	{
		var param = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_ROUTING6&nextPage=adv_ipv6_routing.asp'
		};
		for(var i=0; i<rule_max_num; i++)
		{
			var inst = '1.1.'+(i+1)+'.0.0';
			param.arg += "&fwdV6Rule_Enable_"+inst+"="+get_checked_value($('#enable'+i)[0]);
			param.arg += "&fwdV6Rule_Name_"+inst+"="+$('#name'+i).val();
			param.arg += "&fwdV6Rule_DestIPv6Address_"+inst+"="+$('#dest_ipv6_addr'+i).val();
			param.arg += "&fwdV6Rule_DestIPv6AddressPrefixLength_"+inst+"="+ $('#prefix_length'+i).val();
			param.arg += "&fwdV6Rule_SourceInterface_"+inst+"="+$('#interface_list'+i)[0].selectedIndex;
			param.arg += "&fwdV6Rule_GatewayIPAddress_"+inst+"="+$('#gateway'+i).val();
			param.arg += "&fwdV6Rule_ForwardingMetric_"+inst+"="+$('#metric'+i).val();
		}
		get_config_obj(param);
	}

	function add_option(id, def_val)
	{
		var obj = null;
		var arr = null;
		var nam = null;
		var str = '';

		if (id == 'Schedule') {
			obj = schedule_cnt;
			arr = array_sch_inst;
			nam = array_schedule_name;
		} else if (id == 'Inbound') {
			obj = inbound_cnt;
			arr = array_ib_inst;
			nam = array_ib_name;
		}

		if (obj == null)
			return;

		for (var i = 0; i < obj; i++){
			var str_sel = '';

			if (id == 'Schedule') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(1))
					str_sel = 'selected';
				str += ("<option value=" + inst.charAt(1) + " " + str_sel + ">" + nam[i] + "</option>");
			} else if (id == 'Inbound') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(2))
					str_sel = 'selected';
				str += ("<option value=" + inst.charAt(2) + " " + str_sel + ">" + nam[i] + "</option>");
			}
		}
		return str;
	}

	function do_select(id, type, value)
	{
		var obj = null;
		if (type == 'idx')
			obj = $('#'+id+' option:eq('+value+')')
		else if (type == 'val')
			obj = $('#'+id+' option[value='+value+']');

		if (obj == null)
			return;
		obj.attr("selected", true);
	}

	function disable_check()
	{
		for(var i=0 ; i<rule_max_num ; i++)
		{
			var tmp_iface = $('#interface_list'+i)[0].selectedIndex;
			if(tmp_iface==0)
			{
				$('#gateway'+i).attr('disabled',true);
				$('#metric'+i).attr('disabled',false);
			}
			else if(tmp_iface==3)
			{
				$('#gateway'+i).attr('disabled',true);
				$('#metric'+i).attr('disabled',true);
			}
			else
			{
				$('#gateway'+i).attr('disabled',false);
				$('#metric'+i).attr('disabled',false);
			}
		}
	}

	function paint_table()
	{
		var table_str = '<form id="form3"><h2>' + rule_max_num + ' &ndash;&ndash;' + which_lang[r_rlist] + '</h2>';
			table_str += '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1><tbody>';

		var Inbound_list = '';
		var disabledStr = "";
		if(login_Info!= "w"){// || dev_mode == "1"){
			disabledStr = "disabled";
		}
		for(var i=0 ; i<rule_max_num ; i++)
		{
			var obj_enable = "";
			var obj_name = "";
			var obj_destipv6ip = "";
			var obj_destipv6prefix = "";
			var obj_sourceinterface = "";
			var obj_gatewayip = "";
			var obj_metric = "";

			try {
				if(array_enable[i]!=null)
					obj_enable = array_enable[i];
				if(array_name[i]!=null)
					obj_name = array_name[i];
				if(array_destipv6ip[i]!=null)
					obj_destipv6ip = filter_ipv6_addr(array_destipv6ip[i]);
				if(array_destipv6prefix[i]!=null)
					obj_destipv6prefix = array_destipv6prefix[i];
				if(array_sourceinterface[i]!=null)
					obj_sourceinterface = array_sourceinterface[i];
				if(array_gatewayip[i]!=null)
					obj_gatewayip = filter_ipv6_addr(array_gatewayip[i]);
				if(array_metric[i]!=null)
					obj_metric = array_metric[i];
			} catch (e) {
			}

			table_str += "<tr>";
			if (obj_enable == '1')
				table_str += "<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>";
			else
				table_str += "<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>";
			table_str += '<td valign=bottom colspan=2>'+which_lang[_name]+'<br><input '+disabledStr+' type=text class=flatL id=\"name' + i + '\" name=\"name'+ i +'\" size=20 maxlength=15 value="'+ obj_name +'"></td>';
			table_str += '<td align=left valign=bottom>'+which_lang[IPV6_TEXT158]+'<br><input '+disabledStr+' type=text class=flatL id=dest_ipv6_addr'+ i + ' name=dest_ipv6_addr' + i +' size=43 maxlength=40 value="'+obj_destipv6ip+'">/';
			table_str += '<input '+disabledStr+' type=text class=flatL id=prefix_length'+ i + ' name=prefix_length' + i +' size=5 maxlength=3 value="'+obj_destipv6prefix+'"></td>';
			table_str += "</tr>";
			table_str += "<tr>";
			table_str += '<td valign=bottom>'+which_lang[_metric]+'<br><input '+disabledStr+' type=text class=flatL  id=metric'+i+' name=metric'+i+' size=5 maxlength=2 value="'+obj_metric+'"></td>';
			table_str += "<td align=left valign=bottom>"+which_lang[_interface]+'<br>';
			table_str += "<select "+disabledStr+" style='width:110' id=interface_list" + i +" name=interface_list" + i +"  onchange=\"disable_check()\">";
			table_str += '<option value=-1>'+get_words('_NULL')+'</option>';
			table_str += '<option value=0>'+get_words('WAN')+'</option><option value=1>'+get_words('_LAN')+'</option><option value=2>'+get_words('_LAN')+"("+get_words('DHCP_PD')+")"+'</option>';
			table_str += "</select></td>";
			table_str += '<td align=left valign=bottom>'+which_lang[_gateway]+'<br><input '+disabledStr+' type=text class=flatL id=gateway' + i + ' name=gateway' + i +' size=43 maxlength=42 value="'+obj_gatewayip+'"></td>';
			table_str += "</tr>";
		}

		table_str += '</tbody></table></form>';	
		$('#contant_table').html(table_str);
		if(array_sourceinterface!=null){
			for(var i=0 ; i<rule_max_num ; i++){
				do_select('interface_list'+i, 'idx',  array_sourceinterface[i]);
			}
		}
		disable_check();
		set_form_default_values("form3");
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words('TA2')</script>: 
			<a href="http://support.dlink.com.tw/" onclick="return jump_if();"><script>document.write(model);</script></a></td>
		<td align="right" nowrap><script>show_words('TA3')</script>: 
			<script>document.write(hw_version);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words('sd_FWV')</script>: 
			<script>document.write(version);</script></td>
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
		<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
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
					<UL>
						<LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
						<LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
						<LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
						<LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
						<LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
						<LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
						<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
						<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
						<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
						<LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
						<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
						<LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
						<LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
						<LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
						<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
						<LI><div id=sidenavoff><script>show_words(v6_routing)</script></a></div></LI>
					</UL>
				</div>
				</td>
			</tr>
			</tbody>
		</table>
		</td>

		<form id="form2" method="post" name="form2">
			<input id="html_response_page" name="html_response_page" type="hidden" value="back.asp"> 
			<input id="html_response_message" name="html_response_message" type="hidden" value=""> 
			<script>$('#html_response_message').val(which_lang[sc_intro_sv]);</script> 
			<input id="html_response_return_page" name="html_response_return_page" type="hidden" value="adv_virtual.asp"> 
			<input id="reboot_type" name="reboot_type" type="hidden" value="filter"> 

		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
			<div id="maincontent">
				<div id=box_header>
					<h1><script>show_words(_routing)</script></h1>
					<p><script>show_words(av_intro_r)</script></p>
					<br>
					<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
					<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form3', 'adv_virtual.asp');">
					<script>$('#button').val(get_words(_savesettings));</script>
					<script>$('#button2').val(get_words(_dontsavesettings));</script>
				</div>
		</form>
				<div class=box id="contant_table"></div>
			</div>
		</td>

		<form id="form1" name="form1" method="post" action="get_set.ccp">
			<input type="hidden" id="action" name="action" value="setpar">
			<input type="hidden" name="ccpSubEvent" value="CCP_SUB_VIRTUALSERVER">
			<input type="hidden" name="nextPage" value="adv_virtual.asp">
			<script>$('#html_response_message').val(sc_intro_sv);</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_virtual.asp">
			<input type="hidden" name="ccp_act" value="set">
			<input type="hidden" name="num_inst" value="1">
			<input type="hidden" name="oid_1" value="IGD_WANDevice_i_VirServRule_i_">
			<input type="hidden" name="inst_1" value="11100">
			<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
		</form>
  			<!-- ######################### -->
			<!--      end of main part     -->
			<!-- ######################### -->

		<!-- user tips -->
		<td align="left" id="sidehelp_container" valign="top" width="150"> 
			<table bgcolor="#ffffff" border="0" bordercolor="#ffffff" bordercolordark="#ffffff" bordercolorlight="#ffffff" cellpadding="2" cellspacing="0">
			<tbody>
			<tr>
				<td id="help_text"><b><strong>
					<script>show_words(_hints)</script>
					</strong>&hellip;</b> 
					<p><script>show_words(hhav_name)</script></p>
					<p><script>show_words(hhav_ip)</script></p>
					<p><script>show_words(hhav_sch)</script></p>
					<p><script>show_words(hhav_filt)</script></p>
					<p><a href="support_adv.asp#IPv6_Routing" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html> 