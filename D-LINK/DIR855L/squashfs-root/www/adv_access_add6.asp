<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_12").value == "yes"){
			get_by_name("log")[1].checked = true;
		}else{
			get_by_name("log")[0].checked = true;
		}
	}
	
	function save_info(){
		if(get_by_name("log")[0].checked){
			get_by_id("asp_temp_12").value = "no";
		}else{
			get_by_id("asp_temp_12").value = "yes";
		}
	}

	function  send_previous(){
		save_info();
		document.form1.html_response_page.value = get_by_id("asp_temp_15").value;
		document.form1.html_response_return_page.value = get_by_id("asp_temp_15").value;
		return true;
	}

	function send_next(){
		save_info();
		send_submit("form1");
		return true;
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
			<td height="29"><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
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
                            <script>show_left("Advance", 5);</script>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_save.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_save.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">

			<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<!--# echo asp_temp_00 -->">	<!-- Policy Name -->
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<!--# echo asp_temp_02 -->">	<!-- Machine -->
			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<!--# echo asp_temp_03 -->">	<!-- filter method -->
			<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<!--# echo asp_temp_04 -->">	<!-- firewall rule 1 -->
			<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<!--# echo asp_temp_05 -->">	<!-- firewall rule 2 -->
			<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<!--# echo asp_temp_06 -->">	<!-- firewall rule 3 -->
			<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<!--# echo asp_temp_07 -->">	<!-- firewall rule 4 -->
			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<!--# echo asp_temp_08 -->">	<!-- firewall rule 5 -->
			<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<!--# echo asp_temp_09 -->">	<!-- firewall rule 6 -->
			<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">	<!-- firewall rule 7 -->
			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<!--# echo asp_temp_11 -->">	<!-- firewall rule 8 -->
			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<!--# echo asp_temp_12 -->">	<!-- logging -->
			<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<!--# echo asp_temp_13 -->">	<!-- Policy Name list -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<!--# echo asp_temp_14 -->">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<!--# echo asp_temp_15 -->">	<!-- prev_page -->
			<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<!--# echo asp_temp_16 -->">	<!-- max_row -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2><script>show_words(_aa_wiz_s8_title);</script></h2>
				<table width="525" class=formarea>
				  <tbody>
					  <tr>
						<td class="duple"><script>show_words(_aa_logging);</script> :</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log" checked> <script>show_words(_disabled);</script>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log"> <script>show_words(_enable);</script>
						</td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="submit" id="prev" value="Prev" onClick="return send_previous();">
                                                        <script>get_by_id("prev").value=_prev;</script>
						&nbsp; 
						<input name="next" type="submit" id="next" value="Next" disabled>
                                                        <script>get_by_id("next").value=_next;</script>
						&nbsp;
						<input name="save" type="submit" id="save" value="Save" onClick="return send_next();">                  
                                                        <script>get_by_id("save").value=_save;</script>
						&nbsp; 
						<input name="cancel" type="button" id="cancel" value="Cancel" onClick="exit_access()">
                                                        <script>get_by_id("cancel").value=_cancel;</script>
					</div>
				  </td>
				</table>
            </div>
			</div>
	  		</td>
	  		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                          <p><script>show_words(hhac_en);</script></p>
						  <p><script>show_words(hhac_add);</script></p>
						  <p><script>show_words(hhac_edit);</script></p>
						  <p><script>show_words(hhac_delete);</script></p>
						  <p><a href="support_adv.asp#Access_Control" onclick="return jump_if()"><script>show_words(_more);</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
			</td>
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
<script>onPageLoad();</script>
</html>
