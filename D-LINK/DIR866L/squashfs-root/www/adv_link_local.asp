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
	var link_local ;
	link_local = document.getElementById("link_local_ip_l").value;
	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
	if("<!--# echo ipv6_ula_enable -->" == 1){
		get_by_id("tr_ula_lan_ip").style.display="";
		get_by_id("ula_lan_ip").innerHTML= "<!--# exec cgi /bin/ipv6 get_ula -->".toUpperCase();
	}else
		get_by_id("tr_ula_lan_ip").style.display="none";
		
	set_form_default_values("form1");
 	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}
}
function send_request(){
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;

        var is_modify = is_form_modified("form1");
        if (!is_modify && !confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)) {
                        return false;
        }

	if(submit_button_flag == 0){
		submit_button_flag = 1;
		get_by_id("form1").submit();
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
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Setup", 9);</script>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
	       <form id="form1" name="form1" method="post" action="apply.cgi">
	      <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
		    <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_link_local.asp">
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<!--# exec cgi /bin/ipv6 link_local_ip_l -->">
		    <input type="hidden" id="action" name="action" value="adv_ipv6_link_local">
		    <input type="hidden" id="reboot_type" name="reboot_type" value="wan">
		    <input type="hidden" id="result_timer" name="result_timer" value="20">
		    <input type="hidden" id="page_type" name="page_type" value="IPv6">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
                    <script>show_words(IPV6_TEXT28);</script>
					<br>
                    <br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_link_local.asp');">
					<script>check_reboot();</script>
					<script>get_by_id("button").value = _savesettings;</script>
					<script>get_by_id("button2").value = _dontsavesettings;</script>
                 </div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   <script>show_words(IPV6_TEXT29)</script></h2>
				   <p class="box_msg"><script>show_words(IPV6_TEXT30)</script></p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple"><script>show_words(IPV6_TEXT31);</script> :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
			<option value="ipv6_autodetect"><script>show_words(IPV6_TEXT32b);</script></option>
                        <option value="ipv6_static" ><script>show_words(IPV6_TEXT32);</script></option>
                        <option value="ipv6_autoconfig"><script>show_words(IPV6_TEXT32a);</script></option>
                        <option value="ipv6_pppoe"><script>show_words(IPV6_TEXT34);</script></option>
                        <option value="ipv6_6in4"><script>show_words(IPV6_TEXT35);</script></option>
                        <option value="ipv6_6to4" ><script>show_words(IPV6_TEXT36);</script></option>
                        <option value="ipv6_6rd"><script>show_words(IPV6_TEXT36a);</script></option>
                        <option value="link_local" selected><script>show_words(IPV6_TEXT37a);</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44);</script></h2>
					<p class="box_msg"><script>show_words(IPV6_TEXT67);</script></p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
			    <tr>
			      <td width="225" align=right><b><script>show_words(IPV6_TEXT47);</script> :</b></td>
	                      <td width="300">&nbsp;<b><span id="lan_link_local_ip"></span></b>
	                      </td>
                      </tr>
			    <tr id="tr_ula_lan_ip" style="display:none">
			      <td width="225" align=right><b><script>show_words(IPv6_ULA_lan_1);</script> :</b></td>
	                      <td width="300">&nbsp;<b><span id="ula_lan_ip"></span></b>
	                      </td>
                      </tr>
			</table>
                 </div>
               </td>
          </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                      	<p><script>show_words(IPV6_TEXT58);</script></p>
              <p><script>show_words(IPV6_TEXT59);</script></p>
				<p><a href="support_internet.asp#IPV6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
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
	reboot_needed(left["Setup"].link[9]);
	onPageLoad();
</script>
</html>
