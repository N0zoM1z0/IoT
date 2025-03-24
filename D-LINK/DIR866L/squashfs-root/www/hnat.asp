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
    set_checked(get_by_id("hnat_enable").value, get_by_id("hnat_enable_sel"));	
	set_checked(get_by_id("hnat_udp").value, get_by_id("hnat_udp_sel"));
	
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 

}

function send_dhcp_request(){
       
	var lan_ip = get_by_id("hnat_lan_ip").value;
	var wan_ip = get_by_id("hnat_wan_ip").value;
	
	var lan_ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);	
	
	var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), lan_ip_addr_msg, false, false);
	var temp_wan_ip_obj = new addr_obj(wan_ip.split("."), wan_ip_addr_msg, false, false);
	
	


	get_by_id("dhcpc_use_ucast").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
	get_by_id("classless_static_route").value = get_checked_value(get_by_id("classless_static_route_sel"));
	get_by_id("hnat_enable").value = get_checked_value(get_by_id("hnatEnable"));
	
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
		
    </table>
    <table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
            <td valign="top" width="125" align="right">&nbsp;          </td>
			<td valign="top" id="maincontent_container">	
				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="hnat.asp">
				<input type="hidden" id="action" name="action" value="hnat_udp">		
				<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
				<input type="hidden" id="reboot_type" name="reboot_type" value="reboot">
				<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <p></p>
				<input id="button" name="button" type="submit" class=button_submit value="" onClick="return send_hnat_request()">
				<input id="button2" name="button2" type="button" class=button_submit value="" onClick="return page_cancel('form1', 'hnat.asp');">
				<script>check_reboot();</script>
				<script>get_by_id("button").value = _savesettings;</script>
				<script>get_by_id("button2").value = _dontsavesettings;</script>
              </div>
             
              
              <div class=box>
               	<table cellSpacing=1 cellPadding=1 width=525 border=0>
                <tr>
				<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
				<input type="hidden" id="hnat_udp" name="hnat_udp" value="<!--# echo hnat_udp -->">
                <td width="185" class="duple">Hardware NAT :</td>
                <td width="331">&nbsp;<input type="checkbox" id="hnat_enable_sel" name="hnat_enable_sel" value="1"></td>				
                </tr>
				<tr>
                <td width="185" class="duple">Hardware NAT for UDP :</td>
				<td width="331">&nbsp;<input type="checkbox" id="hnat_udp_sel" name="hnat_udp_sel" value="1"></td>
				 </tr>
				 <tr>
                <td width="185" class="duple">LAN PC ip :</td>
				<td width="331">&nbsp;<input type="text" id="hnat_lan_pc_ip" name="hnat_lan_pc_ip" value='<!--# echo hnat_lan_pc_ip -->'></td>
				 </tr>
<!--
				 <tr>
                <td width="185" class="duple">WAN PC ip :</td>
				<td width="331">&nbsp;<input type="text" id="hnat_wan_pc_ip" name="hnat_wan_pc_ip" value='<!--# echo hnat_wan_pc_ip -->'></td>
				 </tr>
-->
                </table>
				
                
				
                </div>
			
		 
			</form>
           </td>
            <td valign="top" width="150" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                   
              </table></td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;</td>
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
