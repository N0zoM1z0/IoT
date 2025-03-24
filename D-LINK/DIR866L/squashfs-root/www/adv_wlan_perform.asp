<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function onPageLoad(){
		set_selectIndex("<!--# echo wlan0_txpower -->", get_by_id("wlan0_txpower"));
		set_selectIndex("<!--# echo wlan1_txpower -->", get_by_id("wlan1_txpower"));
		//set_checked("<!--# echo wlan0_11d_enable -->", get_by_id("wlan0_11d_enable_sel"));
		set_checked("<!--# echo wlan0_partition -->", get_by_id("wlan0_partition_sel"));
		set_checked("<!--# echo wlan1_partition -->", get_by_id("wlan1_partition_sel"));
		set_checked("<!--# echo wlan0_wmm_enable -->", get_by_id("wlan0_wmm_enable_sel"));
		set_checked("<!--# echo wlan1_wmm_enable -->", get_by_id("wlan1_wmm_enable_sel"));
		//set_checked("<!--# echo wlan0_short_gi -->", get_by_id("wlan0_short_gi_sel"));
	    //set_checked("<!--# echo wlan1_short_gi -->", get_by_id("wlan1_short_gi_sel"));		
		set_checked("<!--# echo wlan0_disablecoext -->", get_by_name("wlan0_disablecoext"));
		//DFS Function
		set_checked("<!--# echo wlan1_dfs_channel_enable -->", get_by_id("wlan1_dfschannel_sel"));
		var dfs_status = "<!--# exec cgi /bin/wlan channel DFS_status -->";
		if ( dfs_status == "0" || dfs_status.length == 0)
			get_by_id("show_dfs_enable").style.display = "none";
		else
			show_dfs();
			
		
		var wlan0_enable = <!--# echo wlan0_enable -->;
		var wlan1_enable = <!--# echo wlan1_enable -->;		
		if(wlan0_enable =="0" && wlan1_enable =="0"){
			DisableEnableForm(document.form1,true);
		}     
		var login_who= checksessionStorage();
		if(login_who== "user"){
		//	DisableEnableForm(document.form1,true);	
			get_by_id("wlan0_txpower").disabled = true;
			get_by_id("wlan0_partition_sel").disabled = true;
			get_by_id("wlan0_wmm_enable_sel").disabled = true;
			get_by_id("wlan0_short_gi_sel").disabled = true;
			get_by_id("wlan1_txpower").disabled = true;
			get_by_id("wlan1_partition_sel").disabled = true;
			get_by_id("wlan1_wmm_enable_sel").disabled = true;
			get_by_id("wlan1_short_gi_sel").disabled = true;
		} 
		
		disable_coext();   
	}

	
	function disable_coext(){
		var mode = "<!--# echo wlan0_11n_protection -->";	
		if (mode == "20"){
			get_by_name("wlan0_disablecoext")[0].disabled = true;	
			get_by_name("wlan0_disablecoext")[1].disabled = true;		
		}else{
			get_by_name("wlan0_disablecoext")[0].disabled = false;	
			//get_by_name("wlan0_disablecoext")[0].checked = true;
			get_by_name("wlan0_disablecoext")[1].disabled = false;			
		}
		
	}
	function check_perform(which_one){		
    	var obj;
    	var temp_obj;
   
    	switch(which_one){
    		case 0 :
    			temp_obj = get_by_id("wlan0_beacon_interval");
    			var beacon_msg = replace_msg(check_num_msg, help438, 20, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 20, 1000, false);
    			break;
    		case 1 :
    			temp_obj = get_by_id("wlan0_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, aw_RT, 0, 2347);
    			obj = new varible_obj(temp_obj.value, rts_msg, 0, 2347, false);
    			break;
    		case 2 :
    			temp_obj = get_by_id("wlan0_fragmentation");
    			var frag_msg = replace_msg(check_num_msg, aw_FT,256 ,2346);
    			obj = new varible_obj(temp_obj.value, frag_msg, 256, 2346, true);
    			break;
    		case 3 :
    			temp_obj = get_by_id("wlan1_dtim");
    			var dtim_msg = replace_msg(check_num_msg, aw_DI,1 ,255);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 1, 255, false);
    			break;
			case 4 :
    			temp_obj = get_by_id("wlan1_beacon_interval");
    			var beacon_msg = replace_msg(check_num_msg, help438, 20, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 20, 1000, false);
    			break;
    		case 5 :
    			temp_obj = get_by_id("wlan1_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, aw_RT, 0, 2347);
    			obj = new varible_obj(temp_obj.value, rts_msg, 0, 2347, false);
    			break;
    		case 6 :
    			temp_obj = get_by_id("wlan1_fragmentation");
    			var dtim_msg = replace_msg(check_num_msg, aw_FT,256 ,2346);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 256, 2346, true);
    			break;
    		case 7 :
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
    }
	
	//Show DFS channel enable
	/* FCC*/
	//{ 0x14, "CA"},{ 0x10, "US"},{ 0x3A, "US"}
	//{ 0x23, "AU"},{ 0x52, "CN"},{ 0x50, "TW"},{ 0x3B, "BR"},	
	/*ETSI*/
	//{ 0x5B, "SG"},{ 0x37, "EU"},{ 0x07, "IL"},{ 0x5E, "KR"},{ 0x41, "JP"},{ 0x36, "EG"},{ 0x32, "FR"}
	/*none*/
	// { 0x51, "CL"},{ 0x3C, "RU"},{ 0x00, NULL},
	
	function show_dfs(){
		var domain = get_by_id("sys_wlan0_domain").value;
		var fcc =  get_by_id("sys_wlan1_fcc_dfs").value;
		var ce =  get_by_id("sys_wlan1_ce_dfs").value;
		var telec =  get_by_id("sys_wlan1_telec_dfs").value;
	
		if (domain == "0x14"||domain =="0x10"||domain =="0x3A"){ //FCC certified 
			get_by_id("show_dfs_enable").style.display ="";
		}else if(domain == "0x5B"||domain =="0x37"||domain =="0x07"||domain =="0x5E"||domain =="0x41"||domain =="0x36"||domain =="0x32"){ //ETSI
			get_by_id("show_dfs_enable").style.display ="";
	//	}else if(domain == "0x23"||domain =="0x52"||domain =="0x50"||domain =="0x3B"){ //FCC no certified
	//		get_by_id("show_dfs_enable").style.display ="";
	//		get_by_id("wlan1_dfschannel_sel").disabled = true;
	//		get_by_id("wlan1_dfschannel_sel").checked = false;
		}else{
			get_by_id("show_dfs_enable").style.display ="none";
			get_by_id("wlan1_dfschannel_sel").disabled = true;
			get_by_id("wlan1_dfschannel_sel").checked = false;
		}	
	}
	function send_request(){
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
		var is_submit = false;
		for (var i = 0; i < 7; i++){
			is_submit = check_perform(i);
			if (!is_submit){			
				break;
    		} 
		}
		
		//get_by_id("wlan0_11d_enable").value = get_checked_value(get_by_id("wlan0_11d_enable_sel"));
		get_by_id("wlan0_partition").value = get_checked_value(get_by_id("wlan0_partition_sel"));
		get_by_id("wlan0_wmm_enable").value = get_checked_value(get_by_id("wlan0_wmm_enable_sel"));
		//get_by_id("wlan0_short_gi").value = get_checked_value(get_by_id("wlan0_short_gi_sel"));

		get_by_id("wlan1_partition").value = get_checked_value(get_by_id("wlan1_partition_sel"));
		get_by_id("wlan1_wmm_enable").value = get_checked_value(get_by_id("wlan1_wmm_enable_sel"));
		//get_by_id("wlan1_short_gi").value = get_checked_value(get_by_id("wlan1_short_gi_sel"));
		
		//DFS Function
		get_by_id("wlan1_dfs_channel_enable").value = get_checked_value(get_by_id("wlan1_dfschannel_sel"));
		
		if (get_by_id("wlan1_dfschannel_sel").checked) {
			alert(WLAN_DFS_MESSAGE_1+"\n\n"+WLAN_DFS_MESSAGE_2);
		}

		if (is_submit){
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
</script>

<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
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
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
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
				<script>show_left("Advance", 12);</script>
			  </UL>
                       </div>
                      </td>
                    </tr>
                </table>
			</td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value="">
		<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wlan_perform.asp">
		<input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
		<input type="hidden" id="action" name="action" value="adv_wlan_perform">
		<input type="hidden" id="wlan0_auto_txrate" name="wlan0_auto_txrate" value="<!--# echo wlan0_auto_txrate -->">
		<input type="hidden" id="wlan0_wmm_enable" name="wlan0_wmm_enable" value="<!--# echo wlan0_wmm_enable -->">
		<input type="hidden" id="wlan0_11d_enable" name="wlan0_11d_enable" value="<!--# echo wlan0_11d_enable -->">
		<input type="hidden" id="wlan0_partition" name="wlan0_partition" value="<!--# echo wlan0_partition -->">
		<input type="hidden" id="wlan0_short_gi" name="wlan0_short_gi" value="<!--# echo wlan0_short_gi -->">
		
		<input type="hidden" id="wlan1_auto_txrate" name="wlan1_auto_txrate" value="<!--# echo wlan1_auto_txrate -->">
		<input type="hidden" id="wlan1_wmm_enable" name="wlan1_wmm_enable" value="<!--# echo wlan1_wmm_enable -->">
		<input type="hidden" id="wlan1_11d_enable" name="wlan1_11d_enable" value="<!--# echo wlan1_11d_enable -->">
		<input type="hidden" id="wlan1_partition" name="wlan1_partition" value="<!--# echo wlan1_partition -->">
		<input type="hidden" id="wlan1_short_gi" name="wlan1_short_gi" value="<!--# echo wlan1_short_gi -->">
		<!-- DFS Function -->
		<input type="hidden" id="sys_wlan1_fcc_dfs" name="sys_wlan1_fcc_dfs" value="<!--# echo sys_wlan1_fcc_dfs -->">
		<input type="hidden" id="sys_wlan1_ce_dfs" name="sys_wlan1_ce_dfs" value="<!--# echo sys_wlan1_ce_dfs -->">
		<input type="hidden" id="sys_wlan1_telec_dfs" name="sys_wlan1_telec_dfs" value="<!--# echo sys_wlan1_telec_dfs -->">
		<input type="hidden" id="wlan0_domain" name="wlan0_domain" value="<!--# echo wlan0_domain -->">
		<input type="hidden" id="sys_wlan0_domain" name="sys_wlan0_domain" value="<!--# echo sys_wlan0_domain -->">
		<input type="hidden" id="wlan1_dfs_channel_enable" name="wlan1_dfs_channel_enable" value="<!--# echo wlan1_dfs_channel_enable -->">
		
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
          <h1>
            <script>show_words(_advwls)</script>
          </h1>
                    
          <p>
            <script>show_words(aw_intro)</script>
          </p>
        <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
		<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_wlan_perform.asp');">
		<script>check_reboot();</script>
        <script>get_by_id("button").value = _savesettings;</script>
		<script>get_by_id("button2").value = _dontsavesettings;</script>
		
                  </div>
                  <div class=box>
                    <h2><script>show_words(aw_title_2)</script></h2>
                  
          <TABLE width=525>
            <tr>
              <td align=right class="duple"><script>show_words(wwl_band)</script> :</td>
              <td>&nbsp;<b><script>show_words(KR16)</script></b></td>
            </tr>
            <tr> 
              <td width="183" align=right class="duple"><script>show_words(aw_TP)</script> :</td>
              <td width="330"> <select id="wlan0_txpower" name="wlan0_txpower" size="1" >
                  <option value="19"><script>show_words(aw_TP_0)</script></option>
				  <option value="15"><script>show_words(aw_TP_1)</script></option>
				  <option value="3"><script>show_words(aw_TP_2)</script></option>
                </select> </td>
            </tr>
            <TR style="display:none"> 
              <TD align=right class="duple"><script>show_words(aw_BP)</script> :</TD>
              <TD> <input maxlength=4 id="wlan0_beacon_interval" name="wlan0_beacon_interval" size=6 value="<!--# echo wlan0_beacon_interval -->">
                (20..1000) </TD>
            </TR>
            <tr style="display:none"> 
              <td align=right class="duple"><script>show_words(aw_RT)</script> :</td>
              <td><input maxlength=4 id="wlan0_rts_threshold" name="wlan0_rts_threshold" size=6 value="<!--# echo wlan0_rts_threshold -->">
                (0..2347) </td>
            </tr>
            <tr style="display:none"> 
              <td align=right class="duple"><script>show_words(aw_FT)</script> :</td>
              <td><input maxlength=4 id="wlan0_fragmentation" name="wlan0_fragmentation" size=6 value="<!--# echo wlan0_fragmentation -->">
                (256..2346) </td>
            </tr>
            <TR style="display:none"> 
              <TD align=right class="duple"><script>show_words(aw_DI)</script> :</TD>
              <TD><input maxlength=3 id="wlan0_dtim" name="wlan0_dtim" size=6 value="<!--# echo wlan0_dtim -->">
                (1..255) </TD>
            </TR>
            <!--TR>
						  <TD align=right class="duple">802.11d Enable :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_11d_enable_sel" name="wlan0_11d_enable_sel" value="1"> 
						  </TD>
						</TR-->
            <TR> 
              <TD align=right class="duple"><script>show_words(KR4)</script> :</TD>
              <TD> <INPUT type="checkbox" id="wlan0_partition_sel" name="wlan0_partition_sel" value="1"> 
              </TD>
            </TR>
            <TR> 
              <TD align=right class="duple"><script>show_words(aw_WE)</script> :</TD>
              <TD> <INPUT name="wlan0_wmm_enable_sel" type="checkbox" id="wlan0_wmm_enable_sel" value="1" disabled> 
              </TD>
            </TR>
            <!--TR> 
              <TD align=right class="duple"><script>show_words(aw_sgi)</script> :</TD>
              <TD> <INPUT type="checkbox" id="wlan0_short_gi_sel" name="wlan0_short_gi_sel" value="1"> 
              </TD>
            </TR-->
	
            <tr> 
              <td class="duple"><script>show_words(bwl_CXT)</script> :</td>
              <td width="340"><input type="radio" name="wlan0_disablecoext" value="0">
                <script>show_words(bwl_CXT_0)</script> 
                <input type="radio" name="wlan0_disablecoext" value="1">
                <script>show_words(bwl_CXT_1)</script> </td>
            </tr>
          </TABLE><h2><script>show_words(aw_title_2)</script></h2>
<TABLE width=525>
  <tr> 
    <td align=right class="duple"><script>show_words(wwl_band)</script> :</td>
    <td>&nbsp;<b><script>show_words(KR17)</script></b></td>
  </tr>
  <tr> 
    <td width="183" align=right class="duple"><script>show_words(aw_TP)</script> :</td>
    <td width="330"> <select id="wlan1_txpower" name="wlan1_txpower" size="1" >
        <option value="19"><script>show_words(aw_TP_0)</script></option>
		<option value="15"><script>show_words(aw_TP_1)</script></option>
		<option value="3"><script>show_words(aw_TP_2)</script></option>
      </select> </td>
  </tr>
  <TR style="display:none"> 
    <TD align=right class="duple"><script>show_words(aw_BP)</script> :</TD>
    <TD> <input maxlength=4 id="wlan1_beacon_interval" name="wlan1_beacon_interval" size=6 value="<!--# echo wlan1_beacon_interval -->">
      (20..1000) </TD>
  </TR>
  <tr style="display:none"> 
    <td align=right class="duple"><script>show_words(aw_RT)</script> :</td>
    <td><input maxlength=4 id="wlan1_rts_threshold" name="wlan1_rts_threshold" size=6 value="<!--# echo wlan1_rts_threshold -->">
      (0..2347) </td>
  </tr>
  <tr style="display:none"> 
    <td align=right class="duple"><script>show_words(aw_FT)</script> :</td>
    <td><input maxlength=4 id="wlan1_fragmentation" name="wlan1_fragmentation" size=6 value="<!--# echo wlan1_fragmentation -->">
      (256..2346) </td>
  </tr>
  <TR style="display:none"> 
    <TD align=right class="duple"><script>show_words(aw_DI)</script> :</TD>
    <TD><input maxlength=3 id="wlan1_dtim" name="wlan1_dtim" size=6 value="<!--# echo wlan1_dtim -->">
      (1..255) </TD>
  </TR>
  <!--TR>
						  <TD align=right class="duple">802.11d Enable :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_11d_enable_sel" name="wlan0_11d_enable_sel" value="1"> 
						  </TD>
						</TR-->
  <TR> 
    <TD align=right class="duple"><script>show_words(KR4)</script> :</TD>
    <TD> <INPUT type="checkbox" id="wlan1_partition_sel" name="wlan1_partition_sel" value="1"> 
    </TD>
  </TR>
  <TR> 
    <TD align=right class="duple"><script>show_words(aw_WE)</script> :</TD>
    <TD> <INPUT name="wlan1_wmm_enable_sel" type="checkbox" id="wlan1_wmm_enable_sel" value="1" disabled> 
    </TD>
  </TR>
  <TR id="show_dfs_enable"> 
    <TD align=right class="duple"><script>show_words(dfs_enable)</script> :</TD>
    <TD> <INPUT name="wlan1_dfschannel_sel" type="checkbox" id="wlan1_dfschannel_sel" value="1"> 
    </TD>
  </TR>
  <!--TR> 
    <TD align=right class="duple"><script>show_words(aw_sgi)</script> :</TD>
    <TD> <INPUT type="checkbox" id="wlan1_short_gi_sel" name="wlan1_short_gi_sel" value="1"> 
    </TD>
  </TR-->
</TABLE>
			</DIV>
			<!-- ________________________________  Main Content End _______________________________ -->
			</TD>
			</form>
<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
	                   <td id=help_text><strong><b><strong><script>show_words(_hints)</script></strong></b>&hellip;</strong> 
					    <p><script>show_words(hhaw_1)</script></p>                   
            			<p><script>show_words(hhaw_11d)</script></p>
            			<p><script>show_words(hhaw_wmm)</script></p>
	                   <p class="more"><a href="support_adv.asp#Advanced_Wireless" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
	                   </TD>
                    </tr>
                </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	reboot_needed(left["Advance"].link[12]);
    onPageLoad();
	set_form_default_values("form1");
</script>
</html>
