<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language=JavaScript>
var submit_button_flag = 0;
var rule_max_num = 10;
var inbound_used = 2;
var DataArray = new Array();
function onPageLoad(){
	set_checked("<!--# echo upnp_enable -->", get_by_id("upnpEnable"));
	set_checked("<!--# echo wan_port_ping_response_enable -->", get_by_id("wan_ping"));
	set_selectIndex_forwan("<!--# echo wan_port_speed -->", get_by_id("wan_port_speed"));
	set_checked("<!--# echo multicast_stream_enable -->", get_by_id("multi_enable"));
	set_checked("<!--# echo ipv6_multicast_stream_enable -->", get_by_id("ipv6_multi_enable"));
    wan_ping_click(get_by_id("wan_ping").checked);
	var show_selected = get_by_id("wan_port_ping_response_inbound_filter").value;
	if(get_by_id("wan_port_ping_response_inbound_filter").value == "Allow_All")
		get_by_id("filtext").value = _allowall;
	else
		get_by_id("filtext").value = _denyall;
	if(get_by_id("wan_port_ping_response_inbound_filter").value !="Allow_All" && get_by_id("wan_port_ping_response_inbound_filter").value !="Deny_All"){
		for(i=0;i<DataArray.length;i++){
			if(DataArray[i].Name == get_by_id("wan_port_ping_response_inbound_filter").value){
				get_by_id("filtext").value = DataArray[i].sAction +","+ DataArray[i].Show_W;
				show_selected = i;
				break;
			}
		}
	}
	if("<!--# echo feature_ipv6 -->" == "1")
		get_by_id("ipv6_multicast").style.display ="";
	else
		get_by_id("ipv6_multicast").style.display ="none";
	set_selectIndex(show_selected, get_by_id("inbound_filter"));
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 

}

//name/action/used(vs/port/wan/remote)
function Data(name, action, used, onList) 
{
	this.Name = name;
	this.Show_W = "";
	this.Used = used;
	this.OnList = onList;
	var sActionW = "Allow All"
	if(action =="deny"){
		sActionW = "Deny";
	}else if(action =="allow"){
			sActionW = "Allow";
	}
	this.sAction = sActionW;
}

function set_Inbound(){
	var index = 0;
	for (var i = 0; i < rule_max_num; i++){
		var temp_st;
		var temp_A;
		var temp_B;
		var k=i;
		if(parseInt(i,10)<10){
			k="0"+i;
		}
		temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
		if (temp_st.length > 1){
			if(temp_st[0] != ""){
				DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
				temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
				for(j=0;j<temp_A.length;j++){
					var temp_A_e = temp_A[j].split("/");
					var temp_A_ip = temp_A_e[1].split("-");
					if(temp_A_e[0] == "1"){
						var T_IP_R = temp_A_e[1];
						if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
							T_IP_R = "*";
						}else if(temp_A_ip[0] == temp_A_ip[1]){
							T_IP_R = temp_A_ip[0];
						}
						if(DataArray[index].Show_W !=""){
							DataArray[index].Show_W = DataArray[index].Show_W + ",";
						}
						DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
					}
				}
				temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
				for(j=0;j<temp_B.length;j++){
					var temp_B_e = temp_B[j].split("/");
					var temp_B_ip = temp_B_e[1].split("-");
					if(temp_B_e[0] == "1"){
						var T_IP_R = temp_B_e[1];
						if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
							T_IP_R = "*";
						}else if(temp_B_ip[0] == temp_B_ip[1]){
							T_IP_R = temp_B_ip[0];
						}
						if(DataArray[index].Show_W !=""){
							DataArray[index].Show_W = DataArray[index].Show_W + ",";
						}
						DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
					}
				}
				load_inbound_used(k, temp_st, inbound_used);
				index++;
			}
		}
	}
}

function show_option_value(){
	for(i=0;i<DataArray.length;i++){
		document.write("<option value=\""+ DataArray[i].OnList +"\">"+ DataArray[i].Name +"</option>");
	}
}

function send_request(){
	if (!is_form_modified("form1") && !confirm(LS3)) {
		return false;
	}
	get_by_id("upnp_enable").value = get_checked_value(get_by_id("upnpEnable"));
	get_by_id("wan_port_ping_response_enable").value = get_checked_value(get_by_id("wan_ping"));
	get_by_id("multicast_stream_enable").value = get_checked_value(get_by_id("multi_enable"));
	get_by_id("ipv6_multicast_stream_enable").value = get_checked_value(get_by_id("ipv6_multi_enable"));
	save_inbound_used(get_by_id("wan_port_ping_response_inbound_filter").value, inbound_used);
	if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
}

function wan_ping_ingress_filter_name_selector(obj_value){
	if(obj_value !="Allow_All" && obj_value !="Deny_All"){
		get_by_id("wan_port_ping_response_inbound_filter").value = DataArray[obj_value].Name;
		get_by_id("filtext").value = DataArray[obj_value].sAction +","+ DataArray[obj_value].Show_W;
	}else{
		get_by_id("wan_port_ping_response_inbound_filter").value = obj_value;
		
		if(obj_value == "Allow_All"){
			get_by_id("filtext").value = _allowall;
		}else{ //Deny_All
			get_by_id("filtext").value = _denyall;
		}
	}
}

function wan_ping_click(obj_chk)
{
    var is_disabled = !obj_chk;
    get_by_id("inbound_filter").disabled = is_disabled;
    get_by_id("filtext").disabled = is_disabled;
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
                          <!-- === BEGIN SIDENAV === -->
                          <UL>
                            <script>show_left("Advance", 15);</script>
                          </UL>
                          <!-- === END SIDENAV === -->
                      	</div>
                      </td>
                    </tr>
                </table></td>

<input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<!--# echo inbound_filter_ip_00_A -->">
<input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<!--# echo inbound_filter_ip_01_A -->">
<input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<!--# echo inbound_filter_ip_02_A -->">
<input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<!--# echo inbound_filter_ip_03_A -->">
<input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<!--# echo inbound_filter_ip_04_A -->">
<input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<!--# echo inbound_filter_ip_05_A -->">
<input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<!--# echo inbound_filter_ip_06_A -->">
<input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<!--# echo inbound_filter_ip_07_A -->">
<input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<!--# echo inbound_filter_ip_08_A -->">
<input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<!--# echo inbound_filter_ip_09_A -->">
<input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<!--# echo inbound_filter_ip_10_A -->">
<input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<!--# echo inbound_filter_ip_11_A -->">
<input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<!--# echo inbound_filter_ip_12_A -->">
<input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<!--# echo inbound_filter_ip_13_A -->">
<input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<!--# echo inbound_filter_ip_14_A -->">
<input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<!--# echo inbound_filter_ip_15_A -->">
<input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<!--# echo inbound_filter_ip_16_A -->">
<input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<!--# echo inbound_filter_ip_17_A -->">
<input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<!--# echo inbound_filter_ip_18_A -->">
<input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<!--# echo inbound_filter_ip_19_A -->">
<input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<!--# echo inbound_filter_ip_20_A -->">
<input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<!--# echo inbound_filter_ip_21_A -->">
<input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<!--# echo inbound_filter_ip_22_A -->">
<input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<!--# echo inbound_filter_ip_23_A -->">

<input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<!--# echo inbound_filter_ip_00_B -->">
<input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<!--# echo inbound_filter_ip_01_B -->">
<input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<!--# echo inbound_filter_ip_02_B -->">
<input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<!--# echo inbound_filter_ip_03_B -->">
<input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<!--# echo inbound_filter_ip_04_B -->">
<input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<!--# echo inbound_filter_ip_05_B -->">
<input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<!--# echo inbound_filter_ip_06_B -->">
<input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<!--# echo inbound_filter_ip_07_B -->">
<input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<!--# echo inbound_filter_ip_08_B -->">
<input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<!--# echo inbound_filter_ip_09_B -->">
<input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<!--# echo inbound_filter_ip_10_B -->">
<input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<!--# echo inbound_filter_ip_11_B -->">
<input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<!--# echo inbound_filter_ip_12_B -->">
<input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<!--# echo inbound_filter_ip_13_B -->">
<input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<!--# echo inbound_filter_ip_14_B -->">
<input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<!--# echo inbound_filter_ip_15_B -->">
<input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<!--# echo inbound_filter_ip_16_B -->">
<input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<!--# echo inbound_filter_ip_17_B -->">
<input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<!--# echo inbound_filter_ip_18_B -->">
<input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<!--# echo inbound_filter_ip_19_B -->">
<input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<!--# echo inbound_filter_ip_20_B -->">
<input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<!--# echo inbound_filter_ip_21_B -->">
<input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<!--# echo inbound_filter_ip_22_B -->">
<input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<!--# echo inbound_filter_ip_23_B -->">

<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_network.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="all">
<input type="hidden" id="action" name="action" value="adv_network">

<input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<!--# echo inbound_filter_name_00 -->">
<input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<!--# echo inbound_filter_name_01 -->">
<input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<!--# echo inbound_filter_name_02 -->">
<input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<!--# echo inbound_filter_name_03 -->">
<input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<!--# echo inbound_filter_name_04 -->">
<input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<!--# echo inbound_filter_name_05 -->">
<input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<!--# echo inbound_filter_name_06 -->">
<input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<!--# echo inbound_filter_name_07 -->">
<input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<!--# echo inbound_filter_name_08 -->">
<input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<!--# echo inbound_filter_name_09 -->">
<input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<!--# echo inbound_filter_name_10 -->">
<input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<!--# echo inbound_filter_name_11 -->">
<input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<!--# echo inbound_filter_name_12 -->">
<input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<!--# echo inbound_filter_name_13 -->">
<input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<!--# echo inbound_filter_name_14 -->">
<input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<!--# echo inbound_filter_name_15 -->">
<input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<!--# echo inbound_filter_name_16 -->">
<input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<!--# echo inbound_filter_name_17 -->">
<input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<!--# echo inbound_filter_name_18 -->">
<input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<!--# echo inbound_filter_name_19 -->">
<input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<!--# echo inbound_filter_name_20 -->">
<input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<!--# echo inbound_filter_name_21 -->">
<input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<!--# echo inbound_filter_name_22 -->">
<input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<!--# echo inbound_filter_name_23 -->">

			<td valign="top" id="maincontent_container">			  <div id=maincontent>
				  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(_advnetwork);</script></h1>
                    <p><script>show_words(anet_intro);</script></p>
                    <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                    <input name="button2" id="button2" type=button class=button_submit value="" onclick="return page_cancel('form1', 'adv_network.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(ta_upnp);</script></h2>
                    <P class="box_msg"><script>show_words(anet_msg_upnp);</script></P>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(ta_EUPNP);</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
						  <input name="upnpEnable" type=checkbox id="upnpEnable" value="1">
						  <input type="hidden" id="upnp_enable" name="upnp_enable" value="<!--# echo upnp_enable -->">
						  </td>
                        </tr>
                    </table>
                  </div>

		<div class=box style="display:none">
                    <h2>PPPoE PASS THROUGH</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple">Enable PPPoE Pass Through :</td>
                          <td width="333" colSpan=3>&nbsp;
                          <input name="pppoePassEnabled" type=checkbox id="pppoePassEnabled" value="1">
                          <input type="hidden" id="pppoe_pass_through" name="pppoe_pass_through" value="<!--# echopppoe_pass_through -->">
                          </td>
                        </tr>
                    </table>
                  </div>

                  <div class=box>
                    <h2><script>show_words(anet_wan_ping);</script></h2>
                    <P class="box_msg"><script>show_words(anet_msg_wan_ping);</script></P>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(bwn_RPing);</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
													  <input name="wan_ping" type="checkbox" id="wan_ping" value="1" onClick="wan_ping_click(this.checked);">
													  <input type="hidden" id="wan_port_ping_response_enable" name="wan_port_ping_response_enable" value="<!--# echo wan_port_ping_response_enable -->">
												  </td>
                        </tr>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(anet_wan_ping);</script> <a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter);</script></a> :</td>
                          <td width="333" colSpan=3>&nbsp;
												  <input type="hidden" id="wan_port_ping_response_inbound_filter" name="wan_port_ping_response_inbound_filter" value="<!--# echo wan_port_ping_response_inbound_filter -->">
												  <select id="inbound_filter" name="inbound_filter" onchange="wan_ping_ingress_filter_name_selector(this.value);">
												  	<option value="Allow_All"><script>show_words(_allowall);</script></option>
												  	<option value="Deny_All"><script>show_words(_denyall);</script></option>
												  	<script>
												  	set_Inbound();
												  	show_option_value();
												  	</script>
												  </select>
												  </td>
                        </tr>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(_aa_details);</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
						  <input type="text" id="filtext" name="filtext" size="48" maxlength="48" readonly="readonly">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(anet_wan_phyrate);</script></h2>
                    <table width="525" border=0 cellpadding=0>
                      <tr>
                          <td width="185" align=right class="duple"><script>show_words(anet_wan_phyrate);</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
				<select name="wan_port_speed" id="wan_port_speed">
					 
							 <script>
								if("<!--# echo feature_fast_ethernet -->" !="" || "<!--# echo feature_giga_ethernet -->" != ""){
									if ("<!--# echo feature_fast_ethernet -->" == "1") {
										var str="";
										str += "<option value=10half>"+anet_wp_0+"</option>";
										str += "<option value=100half>"+anet_wp_1+"</option>";
										if ("<!--# echo feature_giga_ethernet -->" == "1") {
											str += "<option value=giga>"+LW3+"</option>";
											str += "<option value=auto>"+anet_wp_auto2+"</option>";
										}else{
											str += "<option value=auto>"+anet_wp_auto3+"</option>";
										}
										show_words(str);
									}
								}else{
										
										var str="";
										str += "<option value=10half>"+anet_wp_0+"</option>";
										str += "<option value=100half>"+anet_wp_1+"</option>";
										str += "<option value=giga>"+LW3+"</option>";
										str += "<option value=auto>"+anet_wp_auto2+"</option>";
										show_words(str);
								}
							</script>
                          	</select>
			  </td>
                        </tr>
                    </table>
                  </div>
		  <div class=box>
                    <h2><script>show_words(anet_multicast);</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(anet_multicast_enable);</script> :</td>
                          <td width="333" colSpan=3>&nbsp;
						  <input name="multi_enable" type=checkbox id="multi_enable" value="1">
						  <input type="hidden" id="multicast_stream_enable" name="multicast_stream_enable" value="<!--# echo multicast_stream_enable -->">
						  </td>
                        </tr>
                    </table>
		  </div>
		  <div class=box id=ipv6_multicast>
			<h2><script>show_words(ipv6_anet_multicast);</script></h2>
			<table cellSpacing=1 cellPadding=1 width=525 border=0>
			  <tr>
			  <td width="185" align=right class="duple"><script>show_words(ipv6_anet_multicast_enable);</script> :</td>
			  <td width="333" colSpan=3>&nbsp;
					<input name="ipv6_multi_enable" type=checkbox id="ipv6_multi_enable" value="1">
					<input type="hidden" id="ipv6_multicast_stream_enable" name="ipv6_multicast_stream_enable" value="<!--# echo ipv6_multicast_stream_enable -->">
			</td>
                        </tr>
                    </table>
		 </div>
		</form>
              <!-- === END MAINCONTENT === -->
			 </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table width="125" border=0 
      cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                      	<p><script>show_words(hhan_upnp);</script></p>
                      	<p><script>show_words(hhan_ping);</script></p>
                      	<p><script>show_words(hhan_wans);</script></p>
                      	<p><script>show_words(hhan_mc);</script></p>
                      	<p class="more"><a href="support_adv.asp#Network" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	reboot_needed(left["Advance"].link[10]);
	onPageLoad();
</script>
</html>
