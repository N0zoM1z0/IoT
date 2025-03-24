<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
	var submit_button_flag = 0;
	var mode = "<!--# echo wlan0_radio_mode -->";
	function onPageLoad(){
		if(mode == 1){
			set_selectIndex("<!--# echo wlan1_11n_protection -->", get_by_id("wlan_n_protect"));
			set_selectIndex("<!--# echo wlan1_11g_protection -->", get_by_id("wlan_g_protect"));
			set_selectIndex("<!--# echo wlan1_guard_interval -->", get_by_id("wlan_guard_int"));
		}else{
			set_selectIndex("<!--# echo wlan0_11n_protection -->", get_by_id("wlan_n_protect"));
			set_selectIndex("<!--# echo wlan0_11g_protection -->", get_by_id("wlan_g_protect"));
			set_selectIndex("<!--# echo wlan0_guard_interval -->", get_by_id("wlan_guard_int"));
		}
	}

/*	function check_perform(which_one){		
    	var obj;
    	var temp_obj;
   
    	switch(which_one){
    		case 0 :
			if(mode == "1")
	    			temp_obj = get_by_id("wlan1_beacon_interval");
			else
	    			temp_obj = get_by_id("wlan0_beacon_interval");
    			var beacon_msg = replace_msg(check_num_msg, aw_BI, 20, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 20, 1000, false);
    			break;
    		case 1 :
			if(mode == "1")
	    			temp_obj = get_by_id("wlan1_rts_threshold");
			else
	    			temp_obj = get_by_id("wlan0_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, aw_RT, 0, 2347);
    			obj = new varible_obj(temp_obj.value, rts_msg, 0, 2347, false);
    			break;
    		case 2 :
			if(mode == "1")
    				temp_obj = get_by_id("wlan1_fragmentation");
			else
	    			temp_obj = get_by_id("wlan0_fragmentation");
    			var dtim_msg = replace_msg(check_num_msg, help526,256 ,2346);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 256, 2346, true);
    			break;
    		case 3 :
			if(mode == "1")
	    			temp_obj = get_by_id("wlan1_dtim");
			else
	    			temp_obj = get_by_id("wlan0_dtim");
    			var dtim_msg = replace_msg(check_num_msg, aw_DI,1 ,255);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 1, 255, false);
    			break;
    			
    			
    	}
    	
    	if (check_varible(obj)){
    		return true;
    	}else {
        	temp_obj.value = temp_obj.defaultValue;
        	return false;
    	}         
    }*/
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(LS3)) {
			return false;
		}
//		var is_submit = false;
//		for (var i = 0; i < 4; i++){
//			is_submit = check_perform(i);
//			if (!is_submit){			
//				break;
//    		} 
//		}
		
		//get_by_id("wlan0_11d_enable").value = get_checked_value(get_by_id("wlan0_11d_enable_sel"));
		
		var n_protect = get_by_id("wlan_n_protect");
		var g_protect = get_by_id("wlan_g_protect");
		var gi = get_by_id("wlan_guard_int");

		if(mode == 1){

			get_by_id("wlan1_11n_protection").value = n_protect[n_protect.selectedIndex].value;
			get_by_id("wlan1_11g_protection").value = g_protect[g_protect.selectedIndex].value;
			get_by_id("wlan1_guard_interval").value = gi[gi.selectedIndex].value;
		}else{
			get_by_id("wlan0_11n_protection").value = n_protect[n_protect.selectedIndex].value;
			get_by_id("wlan0_11g_protection").value = g_protect[g_protect.selectedIndex].value;
			get_by_id("wlan0_guard_interval").value = gi[gi.selectedIndex].value;
		}

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
<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 10);</script>
                          </UL>
                       </div>
                      </td>
                    </tr>
                </table>
			</td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wlan_perform2.asp">
		<input type="hidden" id="action" name="action" value="adv_wlan_perform">
		<input type="hidden" id="wlan0_11n_protection" name="wlan0_11n_protection" value="<!--# echo wlan0_11n_protection -->">
		<input type="hidden" id="wlan1_11n_protection" name="wlan1_11n_protection" value="<!--# echo wlan1_11n_protection -->">
		<input type="hidden" id="wlan0_11g_protection" name="wlan0_11g_protection" value="<!--# echo wlan0_11g_protection -->">
		<input type="hidden" id="wlan1_11g_protection" name="wlan1_11g_protection" value="<!--# echo wlan1_11g_protection -->">
		<input type="hidden" id="wlan0_guard_interval" name="wlan0_guard_interval" value="<!--# echo wlan0_guard_interval -->">
		<input type="hidden" id="wlan1_guard_interval" name="wlan1_guard_interval" value="<!--# echo wlan1_guard_interval -->">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
                    <h1><script>show_words(_advwls);</script></h1>
                    <p><script>show_words(aw_intro);</script></p>
                    <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                    <input name="button2" id="button2" type="reset" class=button_submit value="" onclick="return page_cancel('form1', 'adv_wlan_perform.asp');">
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(aw_title_2);</script></h2>
                  <TABLE width=525>
						<tr> 
							<td width="183" align=right class="duple"><script>show_words(_ht_pretection);</script> :</td>
							<td width="330"> 
								<select id="wlan_n_protect" name="wlan_n_protect" size="1" >
									  <option value="disable"><script>show_words(_disableoff);</script></option>
				                      <option value="20"><script>show_words(_only);</script> 20MHz</option>
				                      <option value="20_40"><script>show_words(_both);</script> 20/40MHz</option>
				                      <option value="auto"><script>show_words(_ht_pretection);</script></option>
								</select>
							</td>
						</tr>
						<tr> 
							<td width="183" align=right class="duple"><script>show_words(_gprotrction);</script> :</td>
							<td width="330"> 
								<select id="wlan_g_protect" name="wlan_g_protect" size="1" >
									  <option value="off"><script>show_words(_off);</script></option>
				                      <option value="auto"><script>show_words(_ht_pretection);</script></option>
								</select>
							</td>
						</tr>
						<tr> 
							<td width="183" align=right class="duple"><script>show_words(aw_GI);</script> :</td>
							<td width="330"> 
								<select id="wlan_guard_int" name="wlan_guard_int" size="1" >
									  <option value="auto"><script>show_words(_ht_pretection);</script></option>
				                      <option value="short"><script>show_words(_short);</script></option>
				                      <option value="long"><script>show_words(_long);</script></option>
								</select>
							</td>
						</tr>
				</TABLE>
			</DIV>
			<!-- ________________________________  Main Content End _______________________________ -->
			</TD>
			</form>
<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
	                   <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
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
	set_form_default_values("form1");
</script>
</html>
