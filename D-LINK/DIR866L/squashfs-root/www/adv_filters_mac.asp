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
var rule_max_num = 24;
var resert_rule = rule_max_num;
var DHCPL_DataArray = new Array();
function onPageLoad(){
	set_selectIndex("<!--# echo mac_filter_type -->", get_by_id("mac_filter_type"));
	var login_who= checksessionStorage();
        if(login_who== "user"){
                DisableEnableForm(document.form1,true); 
        }else{
                disable_mac_filter();
        }

}
function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}

function set_mac_filter(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_mf;
			
			if (i > 9){
				temp_mf = (get_by_id("mac_filter_" + i).value).split("/");
			}else{
				temp_mf = (get_by_id("mac_filter_0" + i).value).split("/");		
			}
			
			if (temp_mf.length > 1){
				//set_checked(temp_mf[0],get_by_id("entry_enable_"+i));
				get_by_id("mac" + i).value = temp_mf[2];
				//set_selectIndex(temp_mf[3], get_by_id("schedule" + i));
				if(temp_mf[2].length > 0 && temp_mf[2] !="00:00:00:00:00:00"){
					resert_rule--;
				}
			}
		}
		//get_by_id("show_resert").innerHTML = "<font color=\"red\">"+ resert_rule +"</font>";
}

	function disable_mac_filter(){
		var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
		var wps_enable=get_by_id("wps_enable").value;
		if( wps_enable == "1" && mac_filter_type != "0")
			alert(amaf_alert_3);

		for (var i = 0; i < rule_max_num; i++){
			get_by_id("mac" + i).disabled = !(mac_filter_type != 0);
			get_by_id("copy" + i).disabled = !(mac_filter_type != 0);
			get_by_id("dhcp_list" + i).disabled = !(mac_filter_type != 0);
			get_by_id("clear" + i).disabled = !(mac_filter_type != 0);
		}
	}

	function copy_mac(index){
		if (get_by_id("dhcp_list" + index).selectedIndex > 0){
			get_by_id("mac" + index).value = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		}else{
			alert(aa_FILTER_01);
		}
	}

	function clear_mac(index){
		get_by_id("mac" + index).value = "00:00:00:00:00:00";
	}
	
	function check_dhcp_ip(index){
		var index = 0;
		var mac = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
				//check selected mac equal to mac or not?
				index++;
					if(mac == temp_data[2]){
						var lan_ip = "<!--# echo lan_ipaddr -->";
						var lan_ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
						var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), lan_ip_addr_msg, false, false);
						var ip = temp_data[1];
						var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
						var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
							if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, _ipaddr)){
			return false;
		}
						return true;
					}
			}					  
			
			}
			return true;
	}
			
	function send_request(){
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
					return false;
		}

		var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
		if(mac_filter_type != "0" )
			get_by_id("wps_enable").value = "0";


		var lan_mac = "<!--# echo lan_mac -->";
		var i=0;
		var mac = 0;
		var flag = 0;		
		
		for (var i = 0; i < rule_max_num; i++){
			var mac = get_by_id("mac" + i).value;
			
			if (mac != ""){			
				if (mac != "00:00:00:00:00:00" && mac !=""){
					if (!check_mac(get_by_id("mac" + i).value)){
						alert(_clone_error);
						return false;
					}
					if (get_by_id("mac" + i).value == lan_mac ){
						alert(_clone_error);
						return false;
					}
					if(!check_dhcp_ip()){
						return false;
					}
					flag = 1;
				}else{
					continue;
				}
		
				for (var j = parseInt(i+1); j < rule_max_num; j++){
					var next_mac = get_by_id("mac" + j).value;
					if (mac.toUpperCase() == next_mac.toUpperCase()){
						alert(adv_filter_mac_msg);
						return false;
					}
				}
			}
		}
		
		if(flag == 0){ // Graceyang (2009.3.27) :when set mac is 00:00:00:00:00:00 should be saved  
				var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
				if(mac_filter_type !="1"){
				for(k=0; k < rule_max_num; k++){
				get_by_id("mac" + k).value = "00:00:00:00:00:00";
			}
				}else{
					alert(adv_filter_mac_msg_1);
					return false;
				}
		}		
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			if (i > 9){
				get_by_id("mac_filter_" + i).value = "0/name/00:00:00:00:00:00/Always";
			}else{
				get_by_id("mac_filter_0" + i).value = "0/name/00:00:00:00:00:00/Always";
			}
			
			if (get_by_id("mac" + i).value != "" && get_by_id("mac" + i).value != "00:00:00:00:00:00"){
				var dat = "1/name/"+ get_by_id("mac" + i).value + "/Always";
				if (count > 9){
					get_by_id("mac_filter_" + count).value = dat;
				}else{
					get_by_id("mac_filter_0" + count).value = dat;
				}
				count++;			
			}		
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
/*	
	function check_date(){
		var is_change = false;
		var check_mac_filter_type = "<!--# echo mac_filter_type -->";
		if (get_by_id("mac_filter_type").value != check_mac_filter_type){
			is_change = true;
		}else if(!is_change){
			for(i=0;i<rule_max_num;i++){
				var temp_mac = "Name/00:00:00:00:00:00/Always";
				var kk = i;
				if(i<10){
					kk = "0"+i;
				}
				if (get_by_id("mac" + i).value != "" && get_by_id("mac" + i).value != "00:00:00:00:00:00"){
					temp_mac = get_checked_value(get_by_id("entry_enable_"+i)) +"/Name/"+ get_by_id("mac" + i).value + "/" + get_by_id("schedule" + i).value;
				}
				if(get_by_id("mac_filter_"+ kk).value != temp_mac){
					is_change = true;
					break;
				}
			}
		}
		if(is_change){
			if (!confirm(msg[IS_CHANGE_DATA])){
				return false;
			}
		}
		location.href="tools_schedules.asp";
	}
*/
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
                            <script>show_left("Advance", 4);</script>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                </table></td>
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_mac.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="shutdown">
				<input type="hidden" id="action" name="action" value="adv_filters_mac">
				
	    	<input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
                <input type="hidden" id="mac_filter_00" name="mac_filter_00" value="<!--# echo mac_filter_00 -->">
                <input type="hidden" id="mac_filter_01" name="mac_filter_01" value="<!--# echo mac_filter_01 -->">
                <input type="hidden" id="mac_filter_02" name="mac_filter_02" value="<!--# echo mac_filter_02 -->">
                <input type="hidden" id="mac_filter_03" name="mac_filter_03" value="<!--# echo mac_filter_03 -->">
                <input type="hidden" id="mac_filter_04" name="mac_filter_04" value="<!--# echo mac_filter_04 -->">
                <input type="hidden" id="mac_filter_05" name="mac_filter_05" value="<!--# echo mac_filter_05 -->">
                <input type="hidden" id="mac_filter_06" name="mac_filter_06" value="<!--# echo mac_filter_06 -->">
                <input type="hidden" id="mac_filter_07" name="mac_filter_07" value="<!--# echo mac_filter_07 -->">
                <input type="hidden" id="mac_filter_08" name="mac_filter_08" value="<!--# echo mac_filter_08 -->">
                <input type="hidden" id="mac_filter_09" name="mac_filter_09" value="<!--# echo mac_filter_09 -->">
                <input type="hidden" id="mac_filter_10" name="mac_filter_10" value="<!--# echo mac_filter_10 -->">
                <input type="hidden" id="mac_filter_11" name="mac_filter_11" value="<!--# echo mac_filter_11 -->">
                <input type="hidden" id="mac_filter_12" name="mac_filter_12" value="<!--# echo mac_filter_12 -->">
                <input type="hidden" id="mac_filter_13" name="mac_filter_13" value="<!--# echo mac_filter_13 -->">
                <input type="hidden" id="mac_filter_14" name="mac_filter_14" value="<!--# echo mac_filter_14 -->">
                <input type="hidden" id="mac_filter_15" name="mac_filter_15" value="<!--# echo mac_filter_15 -->">
                <input type="hidden" id="mac_filter_16" name="mac_filter_16" value="<!--# echo mac_filter_16 -->">
                <input type="hidden" id="mac_filter_17" name="mac_filter_17" value="<!--# echo mac_filter_17 -->">
                <input type="hidden" id="mac_filter_18" name="mac_filter_18" value="<!--# echo mac_filter_18 -->">
                <input type="hidden" id="mac_filter_19" name="mac_filter_19" value="<!--# echo mac_filter_19 -->">
                <input type="hidden" id="mac_filter_20" name="mac_filter_20" value="<!--# echo mac_filter_20 -->">
                <input type="hidden" id="mac_filter_21" name="mac_filter_21" value="<!--# echo mac_filter_21 -->">
                <input type="hidden" id="mac_filter_22" name="mac_filter_22" value="<!--# echo mac_filter_22 -->">
                <input type="hidden" id="mac_filter_23" name="mac_filter_23" value="<!--# echo mac_filter_23 -->">
                <input type="hidden" id="mac_filter_24" name="mac_filter_24" value="<!--# echo mac_filter_24 -->">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1><script>show_words(_macfilt);</script></h1>
                    <script>show_words(am_intro_1);</script>
                    <br><br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_filters_mac.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(am_MACFILT);</script></h2>
                    <table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tbody>
                        <tr>
                          <td><script>show_words(am_intro);</script>:</td>
                        </tr>
                        <tr>
                          <td>
						  <select id="mac_filter_type" name="mac_filter_type" onChange="disable_mac_filter();">
                              <option value="disable"><script>show_words(am_FM_2);</script></option>
                              <option value="list_allow"><script>show_words(am_FM_3);</script></option>
                              <option value="list_deny"><script>show_words(am_FM_4);</script></option>
                            </select>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td width="100" align=left><strong><script>show_words(_macaddr);</script></strong></td>
                          <td>&nbsp;</td>
                          <td width="250" align=left><strong><script>show_words(bd_DHCP);</script></strong></td>
                          <td>&nbsp;</td>
                        </tr>
                        <script>
							//var Schedule_list = set_schedule_option(Schedule_list);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>")
								//document.write("<td align=\"middle\"><INPUT type=\"checkbox\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
								document.write("<td><input type=text class=flatL id=mac" + i + " size=20 maxlength=17><input type=hidden id=name" + i + " maxlength=31></td>")
								document.write("<td><input type=button id=copy" + i + " name=copy" + i + " value=<< class=btnForCopy onClick='copy_mac(" + i + ")'></td>");
                        	
								document.write("<td width=155> <select class=wordstyle width=140 id=dhcp_list" + i + " modified=\"ignore\">")
								document.write("<option value=-1>"+bd_CName+"</option>")
								document.write(set_mac_list("mac"))
								document.write("</select></td>")
								document.write("<td align=center>");
								document.write("<input type=button id=clear" + i + " name=clear" + i + " value=Clear onClick='clear_mac(" + i + ")'>");
								document.write("</td>");
								document.write("</tr>")
							}
						  </script> 
                      </tbody>
                    </table>
                  </div>             
			  </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                        <p><script>show_words(hham_intro);</script></p>
                        <p><script>show_words(hham_add);</script></p>
                        <p><script>show_words(hham_del);</script></p>
						<p class="more"><a href="support_adv.asp#MAC_Address_Filter" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
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
 reboot_needed(left["Advance"].link[4]);
 onPageLoad();
 set_mac_filter();
 set_form_default_values("form1");
</script>
</html>
