<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
var rule_max_num = 10;
var DataArray = new Array();

	function onPageLoad(){
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}
	}   	

	function Data(enable, policy, mac, primary_dns, secondary_dns) 
	{
		this.Enable = enable;
		this.Policy = policy;
		this.Mac = mac;
		this.Primary_dns = primary_dns;
		this.Secondary_dns = secondary_dns;
	}

	function set_policy(){
		var temp_policy, name_list, count = 0;
		
		for (var i = 0; i < rule_max_num; i++){
			temp_policy = (get_by_id("opendns_client_rule_0" + i).value).split("/");
			if (temp_policy.length > 1){
				DataArray[i] = new Data(temp_policy[0], temp_policy[1], temp_policy[2], temp_policy[3], temp_policy[4], i);
				count++;
			}
		}
	}

	function set_policy_enable(idx){
		if(confirm(aa_ACC_08)){
			var temp_policy, policy;
				temp_policy = get_by_id("opendns_client_rule_0" + idx);
			var filter_type = (temp_policy.value).substring(0, 1);
			
			if(filter_type == "0"){
				temp_policy.value = "1" + (temp_policy.value).substring(1);
			}else{
				temp_policy.value = "0" + (temp_policy.value).substring(1);
			}
			send_submit("form1");
		} else
			window.location.href="adv_opendns_client.asp";

	}


	function del_row(idx){
		if(confirm(up_ae_de_1)){
			delete_data(idx);
			send_submit("form1");
		}
	}

	function delete_data(idx){
		var num = parseInt(idx);
		get_by_id("opendns_client_rule_0" + num).value = "0/0/00:00:00:00:00:00/0.0.0.0/0.0.0.0";

		//delete access_control entry
	}

	function check_ip(){
		if (get_by_id("ping_ipaddr").value == "" || get_by_id("ping_ipaddr").value =="0.0.0.0"){
			alert(tsc_pingt_msg2);
			return false;
		}else{
			return true;
			//send_submit("form5");
		}
	}

	function send_request(){
		//if (!is_form_modified("form1") && !confirm(_ask_nochange))
		//	return false;
		var primary_dns;
		var secondary_dns;
		var mac_name = get_by_id("mac").value;
		var dns_rule = get_by_id("apply_policy").selectedIndex;
		var _enable;

		if( get_by_id("opendns_client_enable").checked)
			_enable = 1;
		else
			_enable = 0;

		if (dns_rule == "0") {
			primary_dns = "<!--# echo wan_primary_dns -->";
			secondary_dns = "<!--# echo wan_secondary_dns -->";
		}else if (dns_rule == "1") {
			primary_dns = "204.194.232.200";
			secondary_dns = "204.194.232.200";
		}else if (dns_rule == "2") {
			primary_dns = "208.67.222.123";
			secondary_dns = "208.67.222.123";
		}

		var temp_policy;
		for (var i = 0; i < rule_max_num; i++){
			temp_policy = (get_by_id("opendns_client_rule_0" + i).value).split("/");
			if (!check_mac(mac_name)){
                		alert(KR3);
                		return false;
			}
			if(mac_name == temp_policy[2]) {
				alert(adv_filter_mac_msg);
				return false;
			}
	
			if (temp_policy[2] == "00:00:00:00:00:00") {
				get_by_id("opendns_client_rule_0" + i).value = _enable+"/"+dns_rule+"/"+mac_name+"/"+primary_dns+"/"+secondary_dns;
				break;
			}
		}                      
		get_by_id("form1").submit();
		
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
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 21);</script>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                </table>
			</td>

		<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
			
        <form id="form1" name="form1" method="post" action="apply.cgi">
	    <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
	    <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
	    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_opendns_client.asp">
	    <input type="hidden" id="reboot_type" name="reboot_type" value="filter">
	    <input type="hidden" id="action" name="action" value="adv_opendns_client">

		<input type="hidden" id="opendns_client_rule_00" name="opendns_client_rule_00" value="<!--# echo opendns_client_rule_00 -->">
		<input type="hidden" id="opendns_client_rule_01" name="opendns_client_rule_01" value="<!--# echo opendns_client_rule_01 -->">
		<input type="hidden" id="opendns_client_rule_02" name="opendns_client_rule_02" value="<!--# echo opendns_client_rule_02 -->">
		<input type="hidden" id="opendns_client_rule_03" name="opendns_client_rule_03" value="<!--# echo opendns_client_rule_03 -->">
		<input type="hidden" id="opendns_client_rule_04" name="opendns_client_rule_04" value="<!--# echo opendns_client_rule_04 -->">
		<input type="hidden" id="opendns_client_rule_05" name="opendns_client_rule_05" value="<!--# echo opendns_client_rule_05 -->">
		<input type="hidden" id="opendns_client_rule_06" name="opendns_client_rule_06" value="<!--# echo opendns_client_rule_06 -->">
		<input type="hidden" id="opendns_client_rule_07" name="opendns_client_rule_07" value="<!--# echo opendns_client_rule_07 -->">
		<input type="hidden" id="opendns_client_rule_08" name="opendns_client_rule_08" value="<!--# echo opendns_client_rule_08 -->">
		<input type="hidden" id="opendns_client_rule_09" name="opendns_client_rule_09" value="<!--# echo opendns_client_rule_09 -->">

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
			  <div id=box_header> 
				<h1><script>show_words(adv_opendns_client);</script></h1>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
				<input name="button2" id="button2" type="reset" class=button_submit value="" onClick="window.location.href='adv_opendns_client.asp'">
				<script>check_reboot();</script>
					<script>get_by_id("button").value = _savesettings;</script>
					<script>get_by_id("button2").value = _dontsavesettings;</script>
			  </div>
			  <div class=box>
			  <h2><script>show_words(adv_opendns_client);</script></h2>
				<table width="525">
						<input type="hidden" id="del_row" name="del_row" value="0">  
					<tr>
<td width="150"><div align="right"><strong><script>show_words(_enable)</script>&nbsp;:</strong>&nbsp;</div></td>
<td width="340"><input type=checkbox id="opendns_client_enable" name="opendns_client_enable" value="enable" ></td>
</tr>
<tr>
<td width="150">
<div align="right"><strong><script>show_words(_mac)</script>&nbsp;:</strong>&nbsp;</div></td>
<td width="150">
<input type="text" id="mac" name="mac" size="20">
&lt;&lt;
<select id="mac_list" name="mac_list" onChange="key_word(this,'mac');">
<option value=""><script>show_words(bd_CName);</script></option>
<script>
set_mac_list("mac");
</script>
</select>
</td>
</tr>
<tr>
<td width="150">
<div align="right"><strong><script>show_words(aa_ACR_c2)</script>&nbsp;:</strong>&nbsp;</div></td>
<td width="340"><select id="apply_policy" name="apply_policy">
                              <option value="blocking">non-Blocking follow router's configuration</option>
                              <option value="adult">Adult query Advanced DNS server:204.194.232.200 204.194.234.200</option>
                              <option value="child">Child query Family Shield DNS server:208.67.222.123 208.67.220.123</option>
                            </select>
</td>
</tr>
</table>
			  </div>
			  <div class=box id="show_table">
			  <h2><script>show_words(aa_Policy_Table);</script></h2>
				<table width="525" id="table1" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
					<tr> 
					  <td width="20"><strong><script>show_words(_enable);</script></strong></td> 
					  <td width="50"><strong><script>show_words(aa_ACR_c2);</script></strong></td> 
					  <td width="120"><strong><script>show_words(_mac);</script></strong></td> 
					  <td width="150"><strong><script>show_words(_dns1);</script></strong></td> 
					  <td width="150"><strong><script>show_words(_dns2);</script></strong></td> 
					  <td>&nbsp;</td>  
					</tr>
					<script>
						set_policy();
						var is_enable = "";
						for(i = 0; i < DataArray.length; i++){
							if(parseInt(DataArray[i].Enable)){
								is_enable = "checked";
							}else{
								is_enable = "";
							}
							// list
							var policy_name
							var policy = (DataArray[i].Policy);
							if( policy == "0")
								policy_name = "non-Blocking";
							else if(policy == "1")
								policy_name = "Adult";
							else if(policy == "2")
								policy_name = "Child";
							
							var mac = DataArray[i].Mac;
							var primary_dns = DataArray[i].Primary_dns;
							var secondary_dns = DataArray[i].Secondary_dns;
							//document.write(str.replace(rep, "\&lt;"));
							if(mac != "00:00:00:00:00:00"){
								document.write("<tr><td><input type=checkbox id=enable" + i + " name=enable" + i + " onClick='set_policy_enable(" + i + ")' " + is_enable + "></td><td>" + policy_name +"</td><td>"+ mac +"</td><td>"+ primary_dns +"</td><td>"+ secondary_dns +"</td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></td></tr>");
							}
						}
					</script>
				</table>
			  </div>
		</form>
		<div class=box>
                    <h2>RESPONSE TIME</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>

                        <form id="form2" name="form2" method="post" action="apply.cgi">
                                        <input type="hidden" id="html_response_page" name="html_response_page" value="adv_opendns_client.asp">
                                        <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_opendns_client.asp">
                                        <input type="hidden" name="action" value="opendns_response">
                          <tr>
                            <td>
                              <strong><script>show_words(tsc_pingt_h)</script>&nbsp;:&nbsp;</strong></td>
                            <td height="20" valign="top">&nbsp;
                                                         <input type="text" id="ping_ipaddr" name="ping_ipaddr" size=30 maxlength=63 value="<!--# echo ping_ipaddr -->" >
                              <input type="submit" id="test" name="test" value="Test" onClick="return check_ip()"></td>
                          </tr>
			  <tr>
			    <td width="150">
			    <strong>non-Blocking&nbsp;:</strong>&nbsp;</td>
                            <td>
                              <!--# echo blocking_time -->
                              <!--# echo error_blocking -->
                            </td>
			  </tr>	
			  <tr>
			    <td width="150">
			    <strong>Adult&nbsp;:</strong>&nbsp;</td>
                            <td>
                              <!--# echo adult_time -->
                              <!--# echo error_adult -->
                            </td>
			  </tr>	
			  <tr>
			    <td width="150">
			    <strong>Child&nbsp;:</strong>&nbsp;</td>
                            <td>
                              <!--# echo child_time -->
                              <!--# echo error_child -->
                            </td>
			  </tr>
			</form>
                    </table>

                                  </div>
		</div>
		</td>
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
<script>
	reboot_needed(left["Advance"].link[20]);
	onPageLoad();
</script>
</html>
