<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
var submit_button_flag = 0;
	function onPageLoad(){
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		} 

		var show_selected = get_by_id("usb_type").value;
		if(show_selected == "3" || show_selected == "4" || show_selected == "5"){
			set_selectIndex("3", get_by_id("usb"));
		}else{
		set_selectIndex(show_selected, get_by_id("usb"));
		}
		set_checked("<!--# echo netusb_guest_zone -->", get_by_id("shareport"));
		
	}
	
	function send_request(){		
		var mode = get_by_id("wanmode").value;
		var usb_type = get_by_id("usb").value;
		var share_value = get_checked_value(get_by_id("shareport"));
		
		if ((usb_type == get_by_id("usb_type").value) && !confirm(_ask_nochange)) {
			return false;
		}
		if(mode == "usb3g" && usb_type == "0"){
			get_by_id("asp_temp_72").value = "0"; //usb_type = Network USB 
			send_submit("form2");
			return false;
		}else if(usb_type == "2"){ 
			get_by_id("asp_temp_72").value = "2"; //usb_type = 3G USB 
			send_submit("form2");
			return false;
		}else if(mode == "usb3g" && usb_type == "1"){ 
			get_by_id("asp_temp_72").value = "1"; //usb_type = 3G USB 
			send_submit("form2");
			return false;
		}else if(usb_type == "3"){
			get_by_id("asp_temp_72").value = "3"; //usb_type = 3G USB Phone
			send_submit("form3");
			return false;
		}else if(usb_type == "4"){
			get_by_id("asp_temp_72").value = "4"; //usb_type = 3G USB Phone 
			send_submit("form3");
			return false;
		}else{
			get_by_id("asp_temp_72").value= get_by_id("usb").value;
			send_submit("form2");
		}
		get_by_id("usb_type").value = get_by_id("usb").value;
		get_by_id("netusb_guest_zone").value = get_checked_value(get_by_id("shareport"));
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;			
			send_submit("form1");
		}
		
	}	
</script>



</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
        
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
			<script>show_top("setup");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 4);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<form id="form3" name="form3" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="wan_usb3G_phone.asp">
			<input type="hidden" id="asp_temp_72" name="asp_temp_72" value="<!--# echo asp_temp_72 -->"> 
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">
			</form>
			<form id="form2" name="form2" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="wan_usb3G.asp">
			<input type="hidden" id="asp_temp_72" name="asp_temp_72" value="<!--# echo asp_temp_72 -->"> 
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">
			</form>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="usb_setting.asp">
			<input type="hidden" id="wanmode" name="wanmode" value="<!--# echo wan_proto -->"> 
			<input type="hidden" id="action" name="action" value="usb_setting">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				 
                  <div id=box_header>
                    <h1><script>show_words(bln_title_usb)</script></h1>
                  <p><script>show_words(bwn_intro_usb)</script></p>
				   <p><script>show_words(usb_3g_help_support_help)</script> </p>
				   
				   
		         
                  <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                  <input name="button2" id="button2" type="reset" class=button_submit value="" onclick="return page_cancel('form1', 'usb_setting.asp');">
				  <script>get_by_id("button").value = _savesettings</script>
				  <script>get_by_id("button2").value = _dontsavesettings</script>
                                                     
				  </div>
                  <div class=box>
                    <h2><script>show_words(bln_title_usb)</script></h2>
                    <P><script>show_words(bwn_msg_usb)</script> </P>
                    
          <table cellSpacing=1 cellPadding=1 width=525 border=0>
            <tr> 
              <td width=155 align=right class="duple"><script>show_words(new_bwn_mici_usb)</script>:</td>
              <td width="360">&nbsp; <select name="usb" id="usb">
                  <script>
                  	 check_usb();
                  </script>
                </select> 
                <input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->"> 
              </td>
            </tr>
          </table>
          
                  </div>
			<div class=box style="display:none">
				<h2><script>show_words(SharePort)</script></h2>
						
			<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr> 
					<td width=155 align=right class="duple"><script>show_words(Enable_SharePort)</script>:</td>
					<td width="360">&nbsp;
					<input name="shareport" type=checkbox id="shareport" value="1">
					<input type="hidden" id="netusb_guest_zone" name="netusb_guest_zone" value="<!--# echo netusb_guest_zone -->">
					 </td>
				</tr>
			</table>
			
			</div>
                  <div class=box style="display:none">
                    <h2><script>show_words(usb_network)</script></h2>
                    
          <P><script>show_words(_info_netowrk)</script>
            <label class="duple" for="network_usb_enable_select"></label>
          </P>
          <P> 
            <label class="duple" for="network_usb_enable_select"><script>show_words(_network_usb_auto)</script>:</label>
            <input type="hidden" id="network_usb_enable" name="config.usb_kcode_enable" value="1"/>
            <input name="checkbox" type="checkbox" id="network_usb_enable_select" onclick="network_usb_enable_selector(this.checked);"/>
          </P>
          <P>
            <label class="duple" for="usb_kcode_timer"><script>show_words(bwn_usb_time)</script>:</label>
            <input type="text" name="usb_intervalr" id="usb_interval" size="10" maxlength="5" value="10" >
            <script>show_words(bwn_bytes_usb)</script> </P>
         
                  </div>              
			  </div></td>
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                          <p><script>show_words(usb_network_support_help)</script> </p>
                          <p><script>show_words(usb_3g_help_support_help)</script></p>
                          <p style="display:none"><script>show_words(hhan_ping)</script></p>
                          <p style="display:none"><script>show_words(hhan_mc)</script></p>
                                                                                
						  <p class="more"><a href="support_internet.asp#USB"><script>show_words(_more)</script>;</a></p>
                      </td>
                    </tr>
			  </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			
    <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
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
