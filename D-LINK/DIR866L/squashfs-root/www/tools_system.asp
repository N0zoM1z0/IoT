<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style2 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
	var submit_button_flag = 0;
	
	 function onPageLoad(){
                var login_who = checksessionStorage();
                if(login_who == "user"){
                        DisableEnableForm(document.form1,true); 
                        DisableEnableForm(document.form2,true); 
                        DisableEnableForm(document.form6,true); 
                        DisableEnableForm(document.form17,true);        
                }
        }
	
	function restoreConfirm(){
			var login_who=checksessionStorage();
			var lan_ip = "<!--# echo lan_ipaddr -->";
			if(login_who== "user"){
				window.location.href ="count_down.asp";
			}else{
				if(lan_ip != "192.168.0.1")	
					get_by_id("change_lan_ip").value = "default";
				if(confirm(up_rb_4+"\n"+up_rb_5)) {
					document.form2.html_response_message.value=_restore;
				    	send_submit("form2");
			   	}
			}
	}
	
	function restore_js(){
		if(confirm(tool_system_0)){		
	    	send_submit("form4");
	   	}
	}
	
	function loadConfirm(){
		var btn_restore = get_by_id("load");
		if (btn_restore.disabled) {
			alert (ta_alert_4);
			return false;
		}
		if (get_by_id("file").value == "") {
			alert(ta_alert_5);
			return false;
		}
		
		var file_name=get_by_id("file").value;
		var ext_file_name=file_name.substring(file_name.lastIndexOf('.')+1,file_name.length);
		if (ext_file_name!="bin"){
			 alert(rs_intro_1);
			 return false;
		}
		
		btn_restore.disabled = true;
		var inf = get_by_id("restore_info");
		if(confirm(tool_system_1)){
			inf.innerHTML = tool_system_2;
			try {
				send_submit("form1");
			} catch (e) {
				alert("Error: " + e.message);
				inf.innerHTML = "&nbsp;";
				btn_restore.disabled = false;
			}
		}else{
			inf.innerHTML = "&nbsp;";
			btn_restore.disabled = false;
		}
	}

	function confirm_reboot(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="count_down.asp";
		}else{
			if(confirm(up_rb_1+"\n"+up_rb_2)){
			document.form6.html_response_message.value=_reboot_running;
	    		send_submit("form6");
	   		}
		}
	}

	function save_conf(){
		send_submit("form17");
	}

</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<script>show_left("tools", 4);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
		  <td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
						<h1><script>show_words(tss_SysSt)</script></h1>
						<p><script>show_words(tss_intro)</script></p>
						<p><script>show_words(tss_intro2)</script></p>
					</div>
					<div class="box">
						<h2><script>show_words(tss_SysSt)</script></h2>
						<table width="525" border=0 cellpadding=2 cellspacing="2">
							<form id="form17" name="form17" method="GET" action="save_configure.cgi">
								<tr valign="top">
									<td width="183" height="48" align=right class="duple"><script>show_words(help_ts_ss);</script>:</td>
									<td width="328">&nbsp;
										<input type=button value="" id="save" name="save" onClick="save_conf()">
										<script>get_by_id("save").value = ta_SavConf;</script>
									</td>
								</tr>
							</form>
						
							<form id="form1" name="form1" method="post" action="upload_configure.cgi" enctype="multipart/form-data">
							<input type="hidden" id="result_timer" name="result_timer" value="50">
								<input type="hidden" id="html_response_page" name="html_response_page" value="restore_succeeded.asp">
								<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">
							
								<tr>
									<td height="72" align=right valign="top" class="duple"><script>show_words(help_ts_ls);</script>:</td>
									<td valign="top">&nbsp;
										<input type=file id=file name=file size=20><br>&nbsp;
										<input type="button" value="" id="load" name="load" onclick="loadConfirm()"><br>
										<script>get_by_id("load").value = ta_ResConf;</script>
										<span class="msg_inprogress" id="restore_info">&nbsp;</span>
									</td>
								</tr>
							</form>
						
							<form id="form2" name="form2" method="post" action="apply.cgi">
								<input type="hidden" name="html_response_return_page" value="tools_system.asp">
								<input type="hidden" name="html_response_page" value="count_down.asp">
								<input type="hidden" id="html_response_message" name="html_response_message" value="">
								<script>get_by_id("html_response_message").value = _restore;</script>
								<input type="hidden" name="result_timer" value="50">
								<input type="hidden" name="action" value="restore_defaults">
								<input type="hidden" id="change_lan_ip" name="change_lan_ip" value="<!--# echo change_lan_ip -->">
								<tr valign="top">
									<td height="66" align=right class="duple"><script>show_words(ts_rfd);</script>:</td>
									<td>&nbsp;
									<input type="button" value="" id="restore" name="restore" onclick="restoreConfirm()"><br>
									<script>get_by_id("restore").value = tss_RestAll_b;</script>
									&nbsp;&nbsp;<script>show_words(tss_RestAll);</script>
								</td>
								</tr>
							</form>
						
							<form id="form6" name="form6" method="post" action="reboot.cgi">
								<input type="hidden" name="html_response_page" value="count_down.asp">
								<input type="hidden" name="html_response_return_page" value="tools_system.asp">
								<input type="hidden" id="html_response_message" name="html_response_message" value="">
								<script>get_by_id("html_response_message").value = _reboot_running;</script>
								<input type="hidden" name="result_timer" value="50">
								<input type="hidden" name="action" value="reboot">
							
								<tr valign="top">
									<td height="39" align=right class="duple"><script>show_words(_reboot);</script>:</td>
									<td>&nbsp;
										<input type="button" value="" id="restart" name="restart" onclick="confirm_reboot()">
										<script>get_by_id("restart").value = _reboot;</script>
									</td>
								</tr>
							</form>
						</table>
					</div>
					<!-- === END MAINCONTENT === -->
				</div>
		  </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text"><strong><script>show_words(_hints);</script>&hellip;</strong>
					  	<p><script>show_words(ZM18)</script></p>
					  	<p><script>show_words(ZM19)</script></p>
					  	<p><script>show_words(ZM20)</script></p>
						<p class="more"><a href="support_tools.asp#System" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
        onPageLoad();
</script>
</html>
