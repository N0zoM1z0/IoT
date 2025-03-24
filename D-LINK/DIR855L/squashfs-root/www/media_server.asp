<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script>
var submit_button_flag = 0;

function onPageLoad(){
	set_checked(get_by_id("minidlna_enable").value, get_by_id("media_enable_sel"));
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 

}

function send_dhcp_request(){
	var is_modify = is_form_modified("form1");
	if (!is_modify && !confirm(_ask_nochange)) {
		return false;
	}
	
	//Media Server Name cannot entry  ~!@#$%^&*()_+}{[]\|"?></
	var re = /[^A-Za-z0-9_.-]/;
	var media_server_name = get_by_id("friendlyname").value;
	if(re.test(media_server_name)){
		alert(GW_MEDIA_SERVER_NAME_INVALID);
		return false;
	}

	if (media_server_name == ""){
	    alert(_bad_media_server_name);
	    return false;
	}
	
	get_by_id("minidlna_enable").value = get_checked_value(get_by_id("media_enable_sel"));
		
	if(submit_button_flag == 0){
		submit_button_flag = 1;		
		return true;
	}else{
		return false;
	}
}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_3g_if();"><!--# echo model_number --></a></td>
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
	    <script>show_left("Setup", 3);</script>
	    </ul>
	    </div>
	    </td>			
	    </tr>
	    </table>			
	    </td>
			<td valign="top" id="maincontent_container">	
				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="media_server.asp">
				<input type="hidden" id="action" name="action" value="http_media">						
				
				<input type="hidden" id="minidlna_enable" name="minidlna_enable" value="<!--# echo minidlna_enable -->">
				<input type="hidden" id="reboot_type" name="reboot_type" value="reboot">
				
				<div id=maincontent>
              <div id=box_header>
                <h1><script>show_words(MEDIA_SERVER)</script></h1>                
				<p><script>show_words(MEDIA_DESC)</script></p>
				<p><strong><b><script>show_words(_note)</script></b>:&nbsp;</strong>
				  <script>show_words(MEDIA_NOTE)</script>
				</p>
				<input id="button" name="button" type="submit" class=button_submit value="" onClick="return send_dhcp_request()">
				<input id="button2" name="button2" type="button" class=button_submit value="" onClick="return page_cancel('form1', 'media_server.asp');">
				<script>check_reboot();</script>
				<script>get_by_id("button").value = _savesettings;</script>
				<script>get_by_id("button2").value = _dontsavesettings;</script>
              </div>
              
              <div class=box>
                <h2><script>show_words(MEDIA_SERVER);</script></h2>
				<p class="box_msg"></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
                <tr>
                <td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(MEDIA_ENABLE);</script> :</td>
                <td width="331">&nbsp;<input type="checkbox" id="media_enable_sel" name="media_enable_sel" value="1"></td>
                </tr>
				<tr>
                <td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(MEDIA_NAME);</script> :</td>
                <td width="331">&nbsp;<input type="text" id="friendlyname" name="friendlyname" value="<!--# echo friendlyname -->"></td>
                </tr>
                </table>
                </div>
			
			</form>
           </td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong> <p>
              			
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_3g_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	reboot_needed(left["Setup"].link[0]);
	onPageLoad();
</script>
</html>
