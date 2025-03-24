<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<script>
	var funcWinOpen = window.open;
</script>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
			url: "get_set.ccp",
			arg: "ccp_act=get&num_inst=3&oid_1=IGD_&inst_1=10000"+
			"&oid_2=IGD_MyDLink_&inst_2=11000"+
			"&oid_3=IGD_MyDlinkEmail_&inst_3=11000"
	};

	get_config_obj(param);

	var submit_button_flag = 0;
	var isReg = (config_val("igd_Register_st_")? config_val("igd_Register_st_"):"");

	var objEmail = {
		'enable':		config_val('igdMyDlinkEmail_Enable_'),
		'emailFrom':	config_val('igdMyDlinkEmail_EmailFrom_'),
		'emailTo':		config_val('igdMyDlinkEmail_EmailTo_'),
		'smtpAddr':		config_val('igdMyDlinkEmail_SMTPServerAddress_'),
		'smtpPort':		config_val('igdMyDlinkEmail_SMTPServerPort_'),
		'secEnable':	config_val('igdMyDlinkEmail_SecurityEnable_'),
		'authEnable':	config_val('igdMyDlinkEmail_AuthenticationEnable_'),
		'username':		config_val('igdMyDlinkEmail_AccountName_'),
		'password':		config_val('igdMyDlinkEmail_AccountPassword_')
	};

	var MyDLink = {
		Account:	config_val("igdMyDLink_EmailAccount_"),
		//Passwd:		config_val("igdMyDLink_AccountPassword_"),
		History: 	config_val("igdMyDLink_RealtimeBrowsingHistory_"),
		Logging: 	config_val("igdMyDLink_OnlineUserLogging_"),
		Upgrade: 	config_val("igdMyDLink_FirmwareUpgrade_"),
		Intrusion: 	config_val("igdMyDLink_WirelessIntrusion_")
	};

	function onPageLoad()
	{	//isReg = 0;
		$('#mdl_st').html( (isReg == 1 ? get_words('mydlink_reg'):get_words('mydlink_nonreg')));
		$('#mdl_acc').html( (isReg == 1 ? MyDLink.Account:get_words('wwl_NONE')));
		isReg == 1 ? $('#myaccount').show() : $('#myaccount').hide();
		$('#register_MDL').attr('disabled',(isReg == 1 ? true:''));
		$('#History_MDL').attr('disabled',(isReg == 0 ? true:''));
		$('#email_enable').attr('disabled',(isReg == 0 ? true:''));
		$('#button_s_m').attr('disabled',(isReg == 0 ? true:''));

		if (objEmail != null) {
			$('#email_enable').attr('checked', parseInt(objEmail.enable));
			$('#Security_MDL').attr('checked', parseInt(objEmail.secEnable));
			$('#email_auth').attr('checked', parseInt(objEmail.authEnable));

			$('#log_email_sender').val(objEmail.emailFrom);
			//$('#log_email_recipien').val(objEmail.emailTo);
			$('#log_email_server').val(objEmail.smtpAddr);
			$('#log_email_port').val((objEmail.smtpPort == 0)?'':objEmail.smtpPort);
			$('#log_email_username').val(objEmail.username);
			$('#log_email_password').val(objEmail.password);
			$('#email_pw2').val(objEmail.password);
		}

		$('#log_email_recipien').attr('disabled',true);
		$('#log_email_recipien').val(MyDLink.Account);
		set_checked(MyDLink.History, get_by_id("History_MDL"));
		set_checked(MyDLink.Logging, get_by_id("Logging_MDL"));
		set_checked(MyDLink.Upgrade, get_by_id("Upgrade_MDL"));
		set_checked(MyDLink.Intrusion, get_by_id("Intrusion_MDL"));

		var login_who= login_Info;
		if(login_who!= "w")
			DisableEnableForm(form1,true);
		else
			disable_notifcation();
	}

	function check_mail(){
		var sender_m = $('#log_email_sender').val();
		//var recipien_m = $('#log_email_recipien').val();
		var srv_m = $('#log_email_server').val();

		if (sender_m == ""){
			alert(get_words('_blankfromemailaddr'));
			return false;	
		}else if (!mail_addr_test(sender_m)){
			alert(get_words('te_FromEm')+' "'+ sender_m +'" '+get_words('mydlink_pop_04'));
			return false;
/*		}else if(recipien_m == ""){
			alert(get_words('_blanktomemailaddr'));
			return false;
		}else if (!mail_addr_test(recipien_m)){
			alert(get_words('te_ToEm')+' "'+ recipien_m +'" '+get_words('mydlink_pop_04'));
			return false;
*/		}else if (srv_m == ""){
			alert(get_words('_blanksmtpmailaddr'));
			return false;
/*		}else if (!mail_addr_test(srv_m)){
			alert(get_words('te_SMTPSv')+' "'+ srv_m +'" '+get_words('mydlink_pop_04'));
			return false;
*/		}else if (!check_integer($('#log_email_port').val(), 1, 65535)) {
			alert(get_words('te_SMTPSv_Port_alert'));
			return false;
		}
		return true;
	}

	function disable_emai_auth()
	{
		var isdis = (isReg == 1)?!$('#email_enable')[0].checked:true;
		//var isdis = !$('#email_auth')[0].checked;
		if($('#email_enable')[0].checked){
			$('#log_email_username').attr('disabled',isdis);
			$('#log_email_password').attr('disabled',isdis);
			$('#email_pw2').attr('disabled',isdis);
		}
	}
	
	function disable_notifcation()
	{
		var isdis = (isReg == 1)?!$('#email_enable')[0].checked:true;
		//var isdis = !$('#email_enable')[0].checked;

		$('#Logging_MDL').attr('disabled',isdis);
		$('#Upgrade_MDL').attr('disabled',isdis);
		$('#Intrusion_MDL').attr('disabled',isdis);
		$('#Security_MDL').attr('disabled',isdis);
	  	$('#log_email_sender').attr('disabled',isdis);
	  	//$('#log_email_recipien').attr('disabled',isdis);
	  	$('#log_email_server').attr('disabled',isdis);
		$('#log_email_port').attr('disabled',isdis);
	  	$('#email_auth').attr('disabled',isdis);
	  	$('#log_email_username').attr('disabled',isdis);
	  	$('#log_email_password').attr('disabled',isdis);
	  	$('#email_pw2').attr('disabled',isdis);

		disable_emai_auth();
	}

	function wopen()
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	"mdl_check.ccp",
			data: 	"act=getpass"+"&"+time+"="+time,
			success: function(data) {
			if (data.indexOf('0') != -1)
				alert(get_words('mydlink_pop_07'));
			else
				location.replace('wizard_mydlink.asp');
			}
/*			error: function(xhr, ajaxOptions, thrownError){
				if (xhr.status == 200) {
					try {
						setTimeout(function() {
							document.write(xhr.responseText);
						}, 0);
					} catch (e) {
					}
				} else {
				}
			}*/
		};

		try {
			//setTimeout(function() {
				$.ajax(ajax_param);
			//}, 0);
		} catch (e) {
		}	
	}

	function confirm_field()
	{
		var showword = ' '+get_words('mydlink_pop_03');
		if(get_by_id("email_enable").checked)
		{
			if(!check_mail())
				return false;

			if ($('#email_auth')[0].checked)
			{
				if ($('#log_email_username').val() == ''){
					alert(get_words('te_Acct')+showword);
					return false;
				}else if ($('#log_email_password').val() == ''){
					alert(get_words('_password')+showword);
					return false;
				}else if ($('#email_pw2').val() == ''){
					alert(get_words('_verifypw')+showword);
					return false;
				}else if ($('#log_email_password').val() != $('#email_pw2').val()){
					alert(get_words('YM102'));
					return false;
				}
			}
		}
		return true;
	}

	function send_request()
	{
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange')))
			return false;

		if (!confirm_field())
			return false;

		var param = {
			'url':	'get_set.ccp',
			'arg':	'ccp_act=set'
		};

		param.arg += '&ccpSubEvent=CCP_SUB_EMAIL&nextPage=mydlink.asp'+
					'&igdMyDlinkEmail_Secret_1.1.0.0.0='+get_checked_value(get_by_id("Security_MDL"))+
					'&igdMyDlinkEmail_Enable_1.1.0.0.0='+($('#email_enable').attr('checked')? '1': '0')+
					'&igdMyDlinkEmail_EmailFrom_1.1.0.0.0='+$('#log_email_sender').val()+
					//'&igdMyDlinkEmail_EmailTo_1.1.0.0.0='+$('#log_email_recipien').val()+
					'&igdMyDlinkEmail_SMTPServerAddress_1.1.0.0.0='+$('#log_email_server').val()+
					'&igdMyDlinkEmail_SMTPServerPort_1.1.0.0.0='+$('#log_email_port').val()+
					'&igdMyDlinkEmail_SecurityEnable_1.1.0.0.0='+($('#Security_MDL').attr('checked')? '1': '0')+
					'&igdMyDlinkEmail_AuthenticationEnable_1.1.0.0.0='+($('#email_auth').attr('checked')? '1': '0')+
					'&igdMyDlinkEmail_AccountName_1.1.0.0.0='+urlencode($('#log_email_username').val())+
					'&igdMyDlinkEmail_AccountPassword_1.1.0.0.0='+urlencode($('#log_email_password').val())+
					'&igdMyDLink_RealtimeBrowsingHistory_1.1.1.0.0='+get_checked_value(get_by_id("History_MDL"))+
					'&igdMyDLink_OnlineUserLogging_1.1.1.0.0='+get_checked_value(get_by_id("Logging_MDL"))+
					'&igdMyDLink_FirmwareUpgrade_1.1.1.0.0='+get_checked_value(get_by_id("Upgrade_MDL"))+
					'&igdMyDLink_WirelessIntrusion_1.1.1.0.0='+get_checked_value(get_by_id("Intrusion_MDL"))
		get_config_obj(param);
	}

	function do_test_mail()
	{
		if(!confirm_field())
			return false;
			
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	'/goform/form_emailsetting',
			data: 	'settingsChanged=1'+
					'&config.smtp_email_from_email_addr='+$('#log_email_sender').val()+
					'&config.smtp_email_server_addr='+$('#log_email_server').val()+
					'&config.smtp_email_acc_name='+urlencode($('#log_email_username').val())+
					'&config.smtp_email_pass='+urlencode($('#log_email_password').val())+
					'&config.smtp_email_action=true'+
					'&config.smtp_email_port='+$('#log_email_port').val()+
					'&config.smtp_email_secret='+($('#Security_MDL').attr('checked')? '1': '0')+
					'&config.smtp_email_enable_smpt_auth='+($('#email_auth').attr('checked')? '1': '0')+
					"&"+time+"="+time,
					
			success: function(data) {
				alert(data);
				$('#button_s_m').attr('disabled',false);
			}
		};

		alert(addstr1(get_words(msg_wait_sec),15));
		$('#button_s_m').attr('disabled',true);

		setTimeout(function() {
			$.ajax(ajax_param);
		}, 500);
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(model);</script></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
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
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td id="sidenav_container">
						<div id="sidenav">
							<ul>
								<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
								<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
								<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
								<li><div id="sidenavon"><a href="storage_setup.asp" onclick="return jump_if();"><script>show_words(storage)</script></a></div></li>
								<li><div id="sidenavon"><a href="setup_ipv6.asp" onclick="return jump_if();"><script>show_words(IPV6_TEXT137)</script></a></div></li>
								<li><div id="sidenavoff"><script>show_words(mydlink_S01)</script></div></li>
							</ul>
						</div>
					</td>
				</tr>
			</table>
		</td>

		<form id='form1'>
			<td valign="top" id="maincontent_container">
			<div id="maincontent">
				<div id="box_header">
					<h1><script>show_words(mydlink_S01)</script> </h1>
					<p><script>show_words(mydlink_S02)</script></p>
					<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
					<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'mydlink.asp');">
					<script>$('#button').val(get_words(_savesettings));</script>
					<script>$('#button2').val(get_words(_dontsavesettings));</script>
				</div>
				<div class="box">
					<h2><script>show_words(mydlink_S03)</script></h2>
					<table cellSpacing=1 cellPadding=1 width=525 border=0>
					<tr>
						<td class="duple">
						<script>show_words(mydlink_srv)</script> :</td>
						<td width="340">&nbsp;
							<span id='mdl_st'><span>
						</td>
					</tr>				
					<tr id="myaccount" style="display:none">
						<td class="duple">
						<script>show_words(mydlink_acc)</script> :</td>
						<td width="340">&nbsp;
							<span id='mdl_acc'><span>
						</td>
					</tr>
					</table>
				</div>

				<div class="box">
					<h2><script>show_words(mydlink_S04)</script></h2>
					<table cellSpacing=1 cellPadding=1 width=525 border=0>
					<tr>
						<td class="duple">
						<td width="340">&nbsp;
							<input type="button" name="register_MDL" id="register_MDL" value=""onclick=wopen();></td>
							<script>$('#register_MDL').val(get_words(mydlink_S04));</script>
						</td>
					</tr>
					</table>
				</div>
				
			<!--20120504 Silvia add MyDLink 1.0 spec-->
			<div id="mydlink_event">
				<div class="box"> 
					<h2><script>show_words(mydlink_T01)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td class="duple"><script>show_words(_enable)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type="Checkbox" id="History_MDL" name="History_MDL" value="1">
						</td>
					</tr>
					</table>
				</div>

				<div class="box"> 
					<h2><script>show_words(mydlink_T02)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td class="duple"><script>show_words(_enable)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type="Checkbox" id="email_enable" name="email_enable" value="1" onClick="disable_notifcation();">
							<input name="button_s_m" id="button_s_m" type="button" style='font:bold 12px Arial' value="" onClick="do_test_mail();">
							<script>$('#button_s_m').val(get_words(mydlink_sendM));</script>
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(te_FromEm)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=text id="log_email_sender" name="log_email_sender" size=30 maxlength=99 value="">
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(te_ToEm)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=text id="log_email_recipien" name="log_email_recipien" size=30 maxlength=99 value="">
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(te_SMTPSv)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=text id="log_email_server" name="log_email_server" size=30 maxlength=99 value="">
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(te_SMTPPort)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=text id="log_email_port" name="log_email_port" size=5 maxlength=99 value="">
						</td>
					</tr>
					<tr>

						<td class="duple"><script>show_words(mydlink_sec)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type="Checkbox" id="Security_MDL" name="Security_MDL" value="1">
						</td>
					</tr>
					<td class="duple"><script>show_words(te_EnAuth)</script>&nbsp;:</td>
					<td width="340">&nbsp;
						<input type="Checkbox" id="email_auth" name="email_auth" value="1" onClick="disable_emai_auth();">
						<input type="hidden" id="log_email_auth" name="log_email_auth" value="">
					</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(te_Acct)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=text id="log_email_username" name="log_email_username" size=30 maxlength=99 value="">
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(_password)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=password id="log_email_password" name="log_email_password" size=30 maxlength=99 value="">
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(_verifypw)</script>&nbsp;:</td>
						<td width="340">&nbsp;
							<input type=password id="email_pw2" name="email_pw2" size=30 maxlength=99 value="">
						</td>
					</tr>
					
					<tr><td COLSPAN = 2 >
						<table>
							<tr height="10">
								<td width="50" ></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>&nbsp;
									<input type="Checkbox" id="Logging_MDL" name="Logging_MDL" value="1">
									<script>show_words(mydlink_T04)</script>
									<input type="Checkbox" id="Upgrade_MDL" name="Upgrade_MDL" value="1">
									<script>show_words(mydlink_T05)</script>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>&nbsp;
									<input type="Checkbox" id="Intrusion_MDL" name="Intrusion_MDL" value="1">
									<script>show_words(mydlink_T06)</script>
								</td>
							</tr>
						</table>
					</td></tr>

					</table>
				</div>
				</div>
			<!--end of Silvia add-->

			</div>
			</td>
		</form>

			<td valign="top" width="150" id="sidehelp_container" align="left">
			<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
				<tbody>
				<tr>
					<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
						<p><a href="support_internet.asp#MyDLink" onclick="return jump_if();">
						<script>show_words(_more)</script>&hellip;</a></p>
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
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<br>
	<div id="copyright"><script>show_words('_copyright');</script></div>
	<br>
</body>
<script>
	$('#mydlink_event').hide();
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>