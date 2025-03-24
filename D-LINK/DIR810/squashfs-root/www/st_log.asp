<html>
<head>
<script>
	var funcWinOpen = window.open;
</script>
<style>  
      #wrap{word-break:break-all;width:400px; overflow:auto; }  
</style>  
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
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	
	var curr_page = 1;
	var last_page = 1;
	var param = {
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=2'+
				'&oid_1=IGD_SystemLogInfo_&inst_1=11000'+
				'&oid_2=IGD_Email_&inst_2=11000'
	};
	get_config_obj(param);
	
	//IGD_Email_
	var objEmail = {
		'enable':		config_val('emailCfg_Enable_'),
		'emailFrom':	config_val('emailCfg_EmailFrom_'),
		'emailTo':		config_val('emailCfg_EmailTo_'),
		'subject':		config_val('emailCfg_Subject_'),
		'smtpAddr':		config_val('emailCfg_SMTPServerAddress_'),
		'authEnable':	config_val('emailCfg_AuthenticationEnable_'),
		'username':		config_val('emailCfg_AccountName_'),
		'password':		config_val('emailCfg_AccountPassword_'),
		'logOnFullEn':	config_val('emailCfg_LogOnFullEnable_'),
		'logOnSchEn':	config_val('emailCfg_LogOnScheduleEnable_'),
		'logSchIdx':	config_val('emailCfg_LogScheduleIndex_'),
		'logDetail':	config_val('emailCfg_LogDetail_')
	};
	
	var sysLogInfo = {
		'sysAct':		config_val('sysLog_OptionSystemActivity_'),
		'debugInfo':	config_val('sysLog_OptionDebugInfo_'),
		'attack':		config_val('sysLog_OptionAttack_'),
		'droppedPack':	config_val('sysLog_OptionDroppedPacket_'),
		'notice':		config_val('sysLog_OptionNotice_')
	};
	
	param.url = "log.ccp";
	param.arg = "ccp_act=doLogReflash";
	get_config_obj(param);
	
	var query_page = 1;
	
	param.url = "log.ccp"
	param.arg = "ccp_act=doLogQuery&queryPage="+query_page;
	get_config_obj(param);
	
	var zero_page = 0;
	var current_page = 0;
	var totle_page = 0;

	function send_action(act, page)
	{
		var paramQry = {
			url: "log.ccp",
			arg: "ccp_act="+act
		};
		
		if(page!=0)
			paramQry.arg += "&queryPage="+page;
			
		get_config_obj(paramQry);
		paint_page_info();
		paint_content();
		disable_log_button();
	}
	
	function onPageLoad(){
		set_checked(sysLogInfo.sysAct, get_by_id("type1"));
		set_checked(sysLogInfo.debugInfo, get_by_id("type2"));
		set_checked(sysLogInfo.attack, get_by_id("type3"));
		set_checked(sysLogInfo.droppedPack, get_by_id("type4"));
		set_checked(sysLogInfo.notice, get_by_id("type5"));
		set_form_default_values("form8");
		if(dev_info.login_info != "w"){
			DisableEnableForm(form8,true);	
			$('#Fp1').attr('disabled',true);
			$('#Lp1').attr('disabled',true);
			$('#Pp1').attr('disabled',true);
			$('#Np1').attr('disabled',true);
			$('#clear').attr('disabled',true);
			$('#email').attr('disabled',true);
			$('#refresh').attr('disabled',true);
			$('#backup').attr('disabled',true);
		}
		//else{
			//start_button();
		//} 
		//update_caption_page();
	}
	
	function update_caption_page()
	{
		$('#caption_page').html('页'+curr_page+'之'+last_page);
	}
	
	function send_request(){
		//if (!is_form_modified("form8") && !confirm("Nothing has changed, save anyway?")) {
		if (!is_form_modified("form8") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		
		var param = {
			'url':	'get_set.ccp',
			'arg':	'ccp_act=set'
		};
		
		param.arg += '&ccpSubEvent=CCP_SUB_ACCESSCTL&nextPage=st_log.asp'+
					'&sysLog_OptionSystemActivity_1.1.0.0.0='+($('#type1').attr('checked')? '1': '0')+
					'&sysLog_OptionDebugInfo_1.1.0.0.0='+($('#type2').attr('checked')? '1': '0')+
					'&sysLog_OptionAttack_1.1.0.0.0='+($('#type3').attr('checked')? '1': '0')+
					'&sysLog_OptionDroppedPacket_1.1.0.0.0='+($('#type4').attr('checked')? '1': '0')+
					'&sysLog_OptionNotice_1.1.0.0.0='+($('#type5').attr('checked')? '1': '0');
		get_config_obj(param);
	}
	
	
	function switch_page(which_page){	
		if (which_page >= 0 && which_page <= last_page){
			get_by_id("current_page").value = which_page;
			//send_submit("form1");
		}
	}

	function start_button(){
		get_by_id("Pp1").disabled = true;
		get_by_id("Np1").disabled = true;
		get_by_id("Fp1").disabled = true;
		get_by_id("Lp1").disabled = true;
		
		setTimeout('disable_button()',1000);
	}

	function disable_button(){
		get_by_id("Pp1").disabled = false;
		get_by_id("Np1").disabled = false;
		get_by_id("Fp1").disabled = false;
		get_by_id("Lp1").disabled = false;
		
		if (curr_page == "1"){
			get_by_id("Pp1").disabled = true;
		}
		
		if (curr_page == last_page){
			get_by_id("Np1").disabled = true;
		}
	}
	
	function disable_log_button(){
		get_by_id("Pp1").disabled = false;
		get_by_id("Np1").disabled = false;
		get_by_id("Fp1").disabled = false;
		get_by_id("Lp1").disabled = false;
		
		//var cur_page = <% CmoGetStatus("log_current_page"); %>;
		//var tot_page = <% CmoGetStatus("log_total_page"); %>;
		
		var cur_page = current_page;
		var tot_page = totle_page;
		
		if (cur_page == 1 || (cur_page==0 && tot_page==0)){
		    get_by_id("Pp1").disabled = true;
		}
		if ((cur_page == tot_page ) && cur_page!=0 && tot_page!=0 ){
		    get_by_id("Np1").disabled = true;
		}
		var login_who=dev_info.login_info;
    	if(login_who != "w")
			get_by_id("clear").disabled = "true";			
	}
	

	function to_first_page(){
		query_page = 1;
		send_action("doLogQuery", query_page);
		//send_submit("form2");
	}

	function to_last_page(){
		query_page = totle_page;
		send_action("doLogQuery", query_page);
		//send_submit("form3");
	}
	
	function to_next_page(){
		query_page += 1;
		send_action("doLogQuery", query_page);
		//send_submit("form4");
	}
	
	function to_pre_page(){
		query_page -= 1;
		send_action("doLogQuery", query_page);
		//send_submit("form5");
	}

	function clear_log(){
		//send_submit("form6");
		send_action("doLogClear", 0);
		location.href='st_log.asp';
	}

	function paint_page_info()
	{
		var logCnt = config_val("currLogCnt");
		if(logCnt == 0)
		{
			current_page = zero_page;
			totle_page = 0;			
		}
		else
		{
			if((logCnt%10) == 0)
				totle_page = Math.floor(logCnt/10)
			else
				totle_page = Math.floor(logCnt/10) + 1;
			current_page = query_page;
		}
		
		if(totle_page > 10)
			totle_page = 10;
		
		/* disable save button avoid save error*/
		/*if(totle_page == 0)
			get_by_id("backup").disabled = true;
		else			
			get_by_id("backup").disabled = false;
		*/
		
		$('#caption_page').html(current_page+'/'+totle_page);

		//get_by_id("log_total_page").innerHTML = totle_page;
		//get_by_id("log_current_page").innerHTML = current_page;
	}
	
	function paint_content()
	{
		var logCnt = config_val("currLogCnt");
		var loopMax = 0;
		
		if(logCnt == 0)
			return;
			
		if(logCnt>10)
			loopMax = 10;
		else
			loopMax = logCnt;
			
		var logTime = config_str_multi("logTime");
		var logType = config_str_multi("logType");
		var logMsg = config_str_multi("logMsg");
		
		var content = '';
		content = '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1 style="table-layout:fixed">'+
					'<tr>'+
					'<td width="20%">'+get_words('_time')+'</td>'+
					'<td>'+get_words('KR110')+'</td>'+
					'</tr>';
		
		for(var i=0; i<logTime.length; i++)
		{
			content +='<tr bgcolor=#FFFFFF>';
			content +='<td>' + logTime[i] + '</td>';
			content +='<td style="word-wrap : break-word;">' + logType[i] +': '+ logMsg[i] +'</td>';
			content +='</tr>';
		}
		
		content += '</table>';
		get_by_id("logContent").innerHTML = content;
	}	
	
	function save_log_fun(){
		//alert("here");
		//show_save_window('log.ccp?ccp_act=doLogSave');
		var paramSave = {
			url: "log.ccp",
			arg: "ccp_act=doLogSave"
		};
		//ajax_submit(paramSave);
		send_submit("form7");
	}

	function email_now(){
	/*
		if("<% CmoGetCfg("log_email_enable","none"); %>" == 0){
			//alert("Email address is not configured.");
			alert(which_lang[YM169]);
		}else{
			var add = "<% CmoGetCfg("log_email_recipien","none"); %>";
			//alert("The log will be sent to email address " + add);
			//alert("日志将会被发送到电子邮件地址 " + add);	//sl_alert_2
			alert(get_words('sl_alert_2')+" "+ add);
			send_submit("form9");
		}
	*/
		if(objEmail.enable == "0")
			alert(get_words('YM169'));
		else
		{
			var add = objEmail.emailTo;
			//alert("The log will be sent to email address " + add);
			alert(get_words('sl_alert_2') + " " + add);	//sl_alert_2
			//alert(get_words('sl_alert_2')+" "+ add);
			
			var paramSendMail = {
				url: "get_set.ccp",
				arg: 'ccp_act=doEvent&ccpSubEvent=CCP_SUB_EMAILNOW'
			};
			ajax_submit(paramSendMail);
		}
	}
	
	function ajax_submit(p)
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	p.url,
			data: 	p.arg+"&"+time+"="+time
		};

		$.ajax(ajax_param);
	}
	
	function show_save_window(name){
		funcWinOpen(name,"Save","width=500,height=600,scrollbar=yes");
	}
</script>

<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
#wrap {word-break:break-all;width:450px;}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
	<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_devinfo)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_logs)</script></div></li>
									<li><div><a href="st_stats.asp" onclick="return jump_if();"><script>show_words(_stats)</script></a></div></li>
									<li><div><a href="internet_sessions.asp" onclick="return jump_if();"><script>show_words(YM157)</script></a></div></li>
									<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
									<li><div><a href="st_wireless.asp" onclick="return jump_if();"><script>show_words(_wireless)</script></a></div></li>								
									<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
									<li><div><a href="st_routing6.asp"><script>show_words(v6_routing)</script></a></div></li>
									<!--<li><div id="sidenavon"><a href="logout.asp" onclick="do_logout();"><script>show_words(logout_caption)</script></a></div></li>
									-->
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(_logs)</script></h1>
						<p><script>show_words(sl_intro)</script></p>
			  		</div>
					<form id="form8" name="form8" method="post" action="">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="">
					<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">
					<div class="box">
                    <h2><script>show_words(sl_LogOps)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
						<tr>
							<td class="duple"><script>show_words(sl_LogOps)</script> :</td>
							<td width="340">
							<input type="hidden" id="log_system_activity" name="log_system_activity" value="">
							<input type=checkbox id=type1 name=type1 value="1"><script>show_words(TEXT019)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_debug_information" name="log_debug_information" value="">
							<input type=checkbox id=type2 name=type2 value="1"><script>show_words(TEXT020)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_attacks" name="log_attacks" value="">
							<input type=checkbox id=type3 name=type3 value="1"><script>show_words(TEXT021)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_dropped_packets" name="log_dropped_packets" value="">
							<input type=checkbox id=type4 name=type4 value="1"><script>show_words(TEXT022)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_notice" name="log_notice" value="">
							<input type=checkbox id=type5 name=type5 value="1"><script>show_words(TEXT023)</script>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<input name="button3" id="button3" type="button" class=button_submit value="" onClick="send_request()">
							<script>get_by_id("button3").value = get_words('sl_ApplySt');</script>
							</td>
						</tr>
					</table>
					</div>
					</form>
					<div class="box">
                    <h2><script>show_words(sl_LogDet)</script></h2>
					<form id="form1" name="form1" method="post" action="">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
					<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">

					<input type="hidden" name="total_log" id="total_log" value="">
					<input type=hidden id="current_page" name="current_page" value="">
					<input type=hidden id="total_page" name="total_page" value="">
                    <table cellpadding="1" cellspacing="1" border="0" width="525">
                      <tr>
                        <td><div align="center">
                          	<input id="Fp1" name="Fp1" type="button" class=button_submit value="" onclick="to_first_page()">
                			<input id="Lp1" name="Lp1" type="button" class=button_submit value="" onclick="to_last_page()">
							<input id="Pp1" name="Pp1" type="button" class=button_submit value="" onclick="to_pre_page()">
							<input id="Np1" name="Np1" type="button" class=button_submit value="" onclick="to_next_page()">
							<script>get_by_id("Fp1").value = get_words('TEXT016');</script>
							<script>get_by_id("Lp1").value = get_words('TEXT017');</script>
							<script>get_by_id("Pp1").value = get_words('TEXT018');</script>
							<script>get_by_id("Np1").value = get_words('TEXT074');</script>
						
						</div>
						</td>
                      </tr>
                      <tr>
                        <td><div align="center">
							<input id="refresh" name="refresh" type="button" class=button_submit value="" onClick='window.location.href="st_log.asp"'>
			                <input id="clear" name="clear" type="button" class=button_submit value="" onclick="clear_log()">
                			<input id="email" name="email" type="button" class=button_submit value="" onclick="email_now()">
							<input id="backup" name="backup" type="button" class=button_submit value="" onclick="save_log_fun()">
							<script>get_by_id("refresh").value = get_words('sl_reload');</script>
							<script>get_by_id("clear").value = get_words('_clear');</script>
							<script>get_by_id("email").value = get_words('sl_emailLog');</script>
							<script>get_by_id("backup").value = get_words('sl_saveLog');</script>
						
						</div>
						</td>
                      </tr>
                      <tr> 
                  		<td>
							<br>
							<font face="Tahoma" size="2">
							<span id='caption_page'></span>
							</font>
						</td>
                	  </tr>
                    </table>
                    <!--<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td width="120"><script>show_words(which_lang[_time])</script></td>
                          <td ><script>show_words(which_lang[KR110])</script></td>
                        </tr>
                        <tr><td>-->
							<span id="logContent"></span>
						<!--</td></tr>
							
                            <script>
									var temp_entry = get_by_id("total_log").value.split("|syslog|");
									for (var i = 0; i < temp_entry.length; i++){
										var entry = temp_entry[i].split("|");
										if(entry.length > 1){
											document.write("<tr bgcolor=#FFFFFF><td width=\"120\">" + entry[0] + "</td><td width=\"80\">" + entry[1] + "</td><td>" + entry[2] + "</td></tr>");
										}
									}
								</script>
							
                      </tbody>
                    </table>-->
					</form>
					</div>
					<!-- === END MAINCONTENT === -->
              <p>&nbsp;</p>
			</div>
			</td>
				<form id="form2" name="form2" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form3" name="form3" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form4" name="form4" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form5" name="form5" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form6" name="form6" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form7" name="form7" method=POST action="log.ccp" enctype=multipart/form-data>
				<input type="hidden" name="ccp_act" value="doLogSave">
				</form>
				<form id="form9" name="form9" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    <td id="help_text">
                      <strong><script>show_words(_hints)</script>&hellip;</strong>
                      <p><script>show_words(hhsl_intro)</script></p>
					  <p><script>show_words(hhsl_lmail)</script></a></p>
					  <p><a href="support_status.asp#Logs" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                    </td>
                  </tr>
                </table></td>
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
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
<script>
paint_page_info();
paint_content();
disable_log_button();
//start_button();
onPageLoad();
</script>
</body>
</html>
