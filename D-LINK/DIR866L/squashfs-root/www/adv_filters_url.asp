<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
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
<script language="JavaScript">
var submit_button_flag = 0;
var rule_max_num = 40;
function onPageLoad() {
	set_selectIndex("<!--# echo url_domain_filter_type -->", get_by_id("url_domain_filter_type"));
	var login_who = checksessionStorage();
	if(login_who == "user" || "<!--# echo wan_proto -->" == "dslite") {
		DisableEnableForm(document.form1, true);
	}
}

function set_virtual_server(){
	for (var i = 0; i < rule_max_num; i++){
		var temp_mf;

		if (i > 9){
			temp_mf = get_by_id("url_domain_filter_" + i).value;
		}else{
			temp_mf = get_by_id("url_domain_filter_0" + i).value;
		}

		if (temp_mf.length > 1){
			get_by_id("url_" + i).value = temp_mf;
		}
	}
}

function check_webUrl(){
	var regex = /http\:\/\/|https\:\/\/|\/\/|\:/;

	for (var i = 0; i < rule_max_num; i++){
		var url_filter = get_by_id("url_" + i).value;
		var strGet_url = "";
		var tmp_strGet_url = "";

		url_filter = url_filter.toLowerCase();

		if (url_filter.match(regex)) {
			url_filter = url_filter.replace(regex, "");
		}

		var lpos = url_filter.lastIndexOf("/");

		if (url_filter != "" ){

				if (lpos != -1){
					strGet_url = url_filter.substring(0,lpos);
				} else{	    
					strGet_url = url_filter; 
				}

			for (var j = 0; j < i; j++){
				var tmp_url = get_by_id("url_" + j).value;
				
				tmp_url = tmp_url.toLowerCase();

				if (tmp_url.match(regex)) {
					tmp_url = tmp_url.replace(regex, "");
				}

				var tmp_lpos = tmp_url.lastIndexOf("/");

				if (tmp_url !=""){
						if (tmp_lpos != -1){
							tmp_strGet_url = tmp_url.substring(0,lpos);
						} else{	    
							tmp_strGet_url = tmp_url; 
						}

					if (strGet_url == tmp_strGet_url){
						alert(aa_FILTER_03.replace('%v',tmp_url));
						return false;
					}
				}
			}
		}
		get_by_id("url_" + i).value = strGet_url.toLowerCase();
	}

	return true;
}

function send_request(){
	if (!is_form_modified("form1") && !confirm(LS3)) {
		return false;
	}

	if(!check_webUrl()){
		return false;
	}

	var count = 0;
	for (var i = 0; i < rule_max_num; i++){
		var temp_url = get_by_id("url_" + i).value;			
		if (temp_url != ""){
			for (var j = i+1; j < rule_max_num; j++){
				if (temp_url == get_by_id("url_" + j).value){
					alert(aa_FILTER_03.replace('%v',tmp_url));
					return false;
				}
			}		
		}
	}

	count = 0;

	for (var i = 0; i < rule_max_num; i++){
		if (i > 9){
			get_by_id("url_domain_filter_" + i).value = "";	
		}else{
			get_by_id("url_domain_filter_0" + i).value = "";
		}

		if (get_by_id("url_" + i).value != "" ){
			/* check http:// and / */
			var tmp_url = get_by_id("url_" + i).value;
			var pos = tmp_url.indexOf("http://");   
			var lpos = tmp_url.lastIndexOf("/"); 
			var strGet_url;
			if(pos != -1){     
				if(lpos < 7){
					strGet_url = tmp_url.substring(pos+7);
				} else{	    
					strGet_url = tmp_url.substring(pos+7,lpos);  
				}
			}else{
				if(lpos != -1){
					strGet_url = tmp_url.substring(0,lpos);
				} else{	    
					strGet_url = tmp_url; 
				}
			}
			var kk=i;
			if(count<10){
				kk="0"+count;
			}
			var kk = i;
			if(count < 10) {
				kk = "0" + count;
			}
			get_by_id("url_domain_filter_" + kk).value = strGet_url;
			count++;			
		}
	}		

	if(submit_button_flag == 0){
		submit_button_flag = 1;
		get_by_id("form1").submit();
	}
}

function check_date(){
	var is_change = false;
	var check_domain_type = "<!--# echo url_domain_filter_type -->";
	if (get_by_id("url_domain_filter_type").value != check_domain_type){
		is_change = true;
	}else if(!is_change){
		for(i=0;i<rule_max_num;i++){
			var kk = i;
			if(i<10){
				kk = "0"+i;
			}
			if(get_by_id("url_domain_filter_"+ kk).value != get_by_id("url_"+ i).value){
				is_change = true;
				break;
			}

		}
	}
	if(is_change){
		if (!confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)){
			return false;
		}
	}
	location.href="tools_schedules.asp";
}
function clear_list_URL(){
	for (var i = 0; i < rule_max_num; i++) {
		get_by_id("url_"+ i).value = "";
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
<ul>
<script>show_left("Advance", 6);</script>
</ul>
</div>
</td>
</tr>
</table></td>
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_url.asp">
<input type="hidden" id="action" name="action" value="adv_filters_url">
<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
<input type="hidden" id="result_timer" name="result_timer" value="20">
<input type="hidden" id="url_domain_filter_00" name="url_domain_filter_00" value="<!--# echo url_domain_filter_00 -->">
<input type="hidden" id="url_domain_filter_01" name="url_domain_filter_01" value="<!--# echo url_domain_filter_01 -->">
<input type="hidden" id="url_domain_filter_02" name="url_domain_filter_02" value="<!--# echo url_domain_filter_02 -->">
<input type="hidden" id="url_domain_filter_03" name="url_domain_filter_03" value="<!--# echo url_domain_filter_03 -->">
<input type="hidden" id="url_domain_filter_04" name="url_domain_filter_04" value="<!--# echo url_domain_filter_04 -->">
<input type="hidden" id="url_domain_filter_05" name="url_domain_filter_05" value="<!--# echo url_domain_filter_05 -->">
<input type="hidden" id="url_domain_filter_06" name="url_domain_filter_06" value="<!--# echo url_domain_filter_06 -->">
<input type="hidden" id="url_domain_filter_07" name="url_domain_filter_07" value="<!--# echo url_domain_filter_07 -->">
<input type="hidden" id="url_domain_filter_08" name="url_domain_filter_08" value="<!--# echo url_domain_filter_08 -->">
<input type="hidden" id="url_domain_filter_09" name="url_domain_filter_09" value="<!--# echo url_domain_filter_09 -->">
<input type="hidden" id="url_domain_filter_10" name="url_domain_filter_10" value="<!--# echo url_domain_filter_10 -->">
<input type="hidden" id="url_domain_filter_11" name="url_domain_filter_11" value="<!--# echo url_domain_filter_11 -->">
<input type="hidden" id="url_domain_filter_12" name="url_domain_filter_12" value="<!--# echo url_domain_filter_12 -->">
<input type="hidden" id="url_domain_filter_13" name="url_domain_filter_13" value="<!--# echo url_domain_filter_13 -->">
<input type="hidden" id="url_domain_filter_14" name="url_domain_filter_14" value="<!--# echo url_domain_filter_14 -->">
<input type="hidden" id="url_domain_filter_15" name="url_domain_filter_15" value="<!--# echo url_domain_filter_15 -->">
<input type="hidden" id="url_domain_filter_16" name="url_domain_filter_16" value="<!--# echo url_domain_filter_16 -->">
<input type="hidden" id="url_domain_filter_17" name="url_domain_filter_17" value="<!--# echo url_domain_filter_17 -->">
<input type="hidden" id="url_domain_filter_18" name="url_domain_filter_18" value="<!--# echo url_domain_filter_18 -->">
<input type="hidden" id="url_domain_filter_19" name="url_domain_filter_19" value="<!--# echo url_domain_filter_19 -->">
<input type="hidden" id="url_domain_filter_20" name="url_domain_filter_20" value="<!--# echo url_domain_filter_20 -->">
<input type="hidden" id="url_domain_filter_21" name="url_domain_filter_21" value="<!--# echo url_domain_filter_21 -->">
<input type="hidden" id="url_domain_filter_22" name="url_domain_filter_22" value="<!--# echo url_domain_filter_22 -->">
<input type="hidden" id="url_domain_filter_23" name="url_domain_filter_23" value="<!--# echo url_domain_filter_23 -->">
<input type="hidden" id="url_domain_filter_24" name="url_domain_filter_24" value="<!--# echo url_domain_filter_24 -->">
<input type="hidden" id="url_domain_filter_25" name="url_domain_filter_25" value="<!--# echo url_domain_filter_25 -->">
<input type="hidden" id="url_domain_filter_26" name="url_domain_filter_26" value="<!--# echo url_domain_filter_26 -->">
<input type="hidden" id="url_domain_filter_27" name="url_domain_filter_27" value="<!--# echo url_domain_filter_27 -->">
<input type="hidden" id="url_domain_filter_28" name="url_domain_filter_28" value="<!--# echo url_domain_filter_28 -->">
<input type="hidden" id="url_domain_filter_29" name="url_domain_filter_29" value="<!--# echo url_domain_filter_29 -->">
<input type="hidden" id="url_domain_filter_30" name="url_domain_filter_30" value="<!--# echo url_domain_filter_30 -->">
<input type="hidden" id="url_domain_filter_31" name="url_domain_filter_31" value="<!--# echo url_domain_filter_31 -->">
<input type="hidden" id="url_domain_filter_32" name="url_domain_filter_32" value="<!--# echo url_domain_filter_32 -->">
<input type="hidden" id="url_domain_filter_33" name="url_domain_filter_33" value="<!--# echo url_domain_filter_33 -->">
<input type="hidden" id="url_domain_filter_34" name="url_domain_filter_34" value="<!--# echo url_domain_filter_34 -->">
<input type="hidden" id="url_domain_filter_35" name="url_domain_filter_35" value="<!--# echo url_domain_filter_35 -->">
<input type="hidden" id="url_domain_filter_36" name="url_domain_filter_36" value="<!--# echo url_domain_filter_36 -->">
<input type="hidden" id="url_domain_filter_37" name="url_domain_filter_37" value="<!--# echo url_domain_filter_37 -->">
<input type="hidden" id="url_domain_filter_38" name="url_domain_filter_38" value="<!--# echo url_domain_filter_38 -->">
<input type="hidden" id="url_domain_filter_39" name="url_domain_filter_39" value="<!--# echo url_domain_filter_39 -->">
<td valign="top" id="maincontent_container">
<div id=maincontent>				  
<div id=box_header>
<h1><script>show_words(_websfilter);</script></h1>
<p><script>show_words(dlink_awf_intro_WF);</script><p>
<input id="apply" name="apply" type="button" class=button_submit value="Save Settings" onClick="send_request()">
<input id="cancel" name="cancel" type=button class=button_submit value="Don't Save Settings" onclick="return page_cancel('form1', 'adv_filters_url.asp');">
<script>check_reboot();</script>
<script>
get_by_id("apply").value = _savesettings;
get_by_id("cancel").value = _dontsavesettings;
</script>
</div>
<div class=box>
<h2><script>show_words(awf_title_WSFR);</script></h2>
<table cellSpacing=1 cellPadding=2 width=500 border=0>
<tr>
<td><script>show_words(dlink_wf_intro);</script>:</td>
</tr>
<tr>
<td>
<select id="url_domain_filter_type" name="url_domain_filter_type">
<!--option value="disable">Turn Parental Control OFF</option-->
<option value="list_deny"><script>show_words(dlink_wf_op_0);</script></option>
<option value="list_allow"><script>show_words(dlink_wf_op_1);</script></option>
</select>
</td>
</tr>
<tr>
<td>
<br>
<input class="button_submit" type="button" id="clear" value="Clear the list below..." onclick="clear_list_URL();">
<script>get_by_id("clear").value = awf_clearlist; </script>
</td>
</tr>
</table>
<br>
<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=0>
<tr align=center>
<td width="100%" colspan="2"><b><script>show_words(aa_WebSite_Domain);</script></b></td>
</tr>
<tr align=center>
<td colspan="2"></td>
</tr>
<script>
for(var i=0 ; i<rule_max_num ; i++){
	document.write("<tr align=center>")
		document.write("<td><input id=\"url_" + i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>")
		document.write("<td><input id=\"url_" + ++i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>")
		document.write("</tr>")
}
</script>
</table>
</div>
</div>
</td>
</form>
<td valign="top" width="150" id="sidehelp_container" align="left">
<table width="125" border=0 cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
<tr>
<td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
<p><script>show_words(dlink_hhwf_intro);</script></p>
<p><script>show_words(hhwf_xref);</script></p>
<p class="more"><a href="support_adv.asp#Web_Filter" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
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
reboot_needed(left["Advance"].link[6]);
onPageLoad();
set_virtual_server();
set_form_default_values("form1");
</script>
</html>
