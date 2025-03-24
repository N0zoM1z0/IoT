<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	function onPageLoad(){
		get_by_id("connect_b2").disabled = true;
		var ipv4_wan_proto = "<!--# echo wan_proto -->";
		if (ipv4_wan_proto == "pppoe")
			set_checked(1, get_by_name("ipv6_pppoe_share"));
		else
                	set_checked(0, get_by_name("ipv6_pppoe_share"));
		clone_ipv4_pppoe();
	}

	function send_request(){
		var ipv6_pppoe_share = get_by_name("ipv6_pppoe_share");
		get_by_id("ipv6_wan_proto").value ="ipv6_pppoe";
		if (ipv6_pppoe_share[0].checked){
			var ipv4_wan_proto = "<!--# echo wan_proto -->";

			if( ipv4_wan_proto != "pppoe" ){
				alert(IPV6_PPPoE_v4wan);
				return false;
			}
		}

		if(!check_username(get_by_id("ipv6_pppoe_username").value)){
			alert(GW_WAN_PPPOE_USERNAME_INVALID);
			return false;
		}

		if (get_by_id("ipv6_pppoe_password_s").value == "") {
			alert(GW_WAN_PPPOE_PASSWORD_INVALID);
			return false;
		}

 		if (!check_pwd("ipv6_pppoe_password_s", "ipv6_pppoe_password_v")){
 			return false;
 		}
  
 		if (!check_pwd("ipv6_pppoe_password_s", "ipv6_pppoe_password_v"))
 			return false;
 
 		if(submit_button_flag == 0){
 			submit_button_flag = 1;
 			return true;
 		}else{
 			return false;
 		}
 	}

	function clone_ipv4_pppoe(){
		if(get_by_name("ipv6_pppoe_share")[0].checked) {
			get_by_id("ipv6_pppoe_username").value = "<!--# echo wan_pppoe_username_00 -->";
			get_by_id("ipv6_pppoe_password_s").value = "<!--# echo wan_pppoe_password_00 -->";
			get_by_id("ipv6_pppoe_password_v").value = "<!--# echo wan_pppoe_password_00 -->";
			get_by_id("ipv6_pppoe_service").value = "<!--# echo wan_pppoe_service_00 -->";

                        get_by_id("ipv6_pppoe_username").disabled = true;
                        get_by_id("ipv6_pppoe_password_s").disabled = true;
                        get_by_id("ipv6_pppoe_password_v").disabled = true;
                        get_by_id("ipv6_pppoe_service").disabled = true;
			
		} else {
			get_by_id("ipv6_pppoe_username").value = "<!--# echo ipv6_pppoe_username -->";
			get_by_id("ipv6_pppoe_password_s").value = "<!--# echo ipv6_pppoe_password -->";
                        get_by_id("ipv6_pppoe_password_v").value = "<!--# echo ipv6_pppoe_password -->";
                        get_by_id("ipv6_pppoe_service").value = "<!--# echo ipv6_pppoe_service -->";

                        get_by_id("ipv6_pppoe_username").disabled = false;
                        get_by_id("ipv6_pppoe_password_s").disabled = false;
                        get_by_id("ipv6_pppoe_password_v").disabled = false;
                        get_by_id("ipv6_pppoe_service").disabled = false;
		}	
	}
	
	function go_back() {
		get_by_id("html_response_page").value = "wizard_ipv6_3.asp";
	}

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onload="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
	<td bgcolor="#FFFFFF">
	<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
	<tr>
		<td bgcolor="#FFFFFF">
			<div align=center>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
	    <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
			<img src="/wlan_masthead.gif" width="836" height="92" align="middle"> 
			</div>
		</td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<p>&nbsp;</p>
	<table width="650" border="0" align="center">
	<tr>
		<td>
			<div class=box>
			<h2 align="left"><script>show_words(IPv6_wizard_10);</script></h2>
			<div align="left">
			<p class="box_msg"><script>show_words(IPV6_wizard_info_10);</script></p>
			<div>
			<div id=w1>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" name="html_response_page" id="html_response_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="html_response_message" value="">
				<input type="hidden" name="html_response_return_page" value="wizard_ipv6_4.asp">
				<input type="hidden" name="reboot_type" value="none">
				<input type="hidden" id="action" name="action" value="response_page">
				<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
				<input type="hidden" id="wizard_ipv6_pre_page" name="wizard_ipv6_pre_page" value ="wizard_ipv6_pppoe.asp">
				<input type="hidden" id="wizard_ipv6_action" name="wizard_ipv6_action" value="adv_ipv6_poe">
				<input type="hidden" id="wizard_ipv6_return_page" name="wizard_ipv6_return_page" value="adv_ipv6_pppoe.asp">
			<table  class=formarea border="0">
			<tbody>
			<tr>
				<td width="30%" class="duple"><script>show_words(IPV6_PPPoE_session);</script></td>
				<td width="70%">&nbsp;
					<input type="radio" name="ipv6_pppoe_share" value="1" onClick="clone_ipv4_pppoe()" checked>
						<script>show_words(IPV6_PPPoE_share);</script>
					<input type="radio" name="ipv6_pppoe_share" value="0" onClick="clone_ipv4_pppoe()">
						<script>show_words(IPV6_PPPoE_create);</script>
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(bwn_UN);</script> :</td>
				<td>&nbsp;
					<input type=text id="ipv6_pppoe_username" name="ipv6_pppoe_username" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_username -->">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(_password);</script> :</td>
				<td>&nbsp;
					<input type="password" id="ipv6_pppoe_password_s" name="ipv6_pppoe_password_s" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_password -->">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(_verifypw);</script> :</td>
				<td>&nbsp;
					<input type="password" id="ipv6_pppoe_password_v" name="ipv6_pppoe_password_v" size="20" maxlength="63" value="<!--# echo ipv6_pppoe_password -->">
				</td>
			</tr>
			<tr>
				<td align=right class="duple"><script>show_words(_srvname);</script> :</td>
				<td>&nbsp;
					<input type="text" id="ipv6_pppoe_service" name="ipv6_pppoe_service" size="30" maxlength="39" value="<!--# echo ipv6_pppoe_service -->"><script>show_words(_optional);</script>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<script>show_words(wwa_note_svcn);</script>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;<BR>
					<input type="submit" id="prev_b2" class="button_submit" name="prev_b2" value="Prev" onclick="return go_back()">
					<input type="submit" id="next_b2" class="button_submit" name="next_b2" value="Next" onclick="return send_request()">
					<input type="button" id="cancel_b2" class="button_submit" name="cancel_b2" value="Cancel" onclick="window.location.href='ipv6.asp'">
					<input type="button" class="button_submit" id="connect_b2" name="connect_b2" value="connect">
						<script>
                                                	get_by_id("prev_b2").value = _prev;
                                                	get_by_id("next_b2").value = _next;
	                                                get_by_id("cancel_b2").value = _cancel;
							get_by_id("connect_b2").value = _connect;
        	                                </script>
				</td>
			</tr>
			</tbody>
			</table>

			<br>&nbsp;
			</form>
			</div><!--w1-->
			</div>
			</div><!--left-->
			</div><!--header-->
		</td>
	</tr>
	</table>
	<p>&nbsp;</p>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	</table>
	</td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
</html>
