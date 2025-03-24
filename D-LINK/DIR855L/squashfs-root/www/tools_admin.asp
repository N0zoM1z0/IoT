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
var rule_max_num = 10;
var vs_rule_max = 24;
var inbound_used = 3;
var DataArray = new Array();
var ori_inbound_filter="";
var ori_management_port="";
var ori_hostname="";
/* add HTTPS function */
var https_enable = "", remote_https_enable="", remote_https_port="", remote_http_port="";

	function onPageLoad()
	{
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1, true);
		}
		/* HTTPS function start */
		var https_value;

		https_value = (get_by_id("https_config").value).split("/");
		https_enable = https_value[0];
		remote_https_enable = https_value[1];
		remote_https_port = https_value[2];
		remote_http_port = https_value[3];

		if ("<!--# echo support_https -->" == "1") {
			document.getElementById("https_1").style.display = "block";
			document.getElementById("https_2").style.display = "block";
			document.getElementById("https_3").style.display = "block";
		}
		set_checked(https_enable, get_by_id("box_https_enable"));
		set_checked(get_by_id("remote_ssl").value, get_by_id("box_remote_https_enable"));
		/* HTTPS function end */

//		get_by_id("admin_password").value=ssid_decode("admin_password_tmp");
//		get_by_id("user_password").value=ssid_decode("user_password_tmp");
		var graph_enable = "<!--# echo graph_enable -->";
		set_checked("<!--# echo remote_http_management_enable -->", get_by_id("remote_enable"));
		get_by_id("remote_http_management_port").disabled = !get_by_id("remote_enable").checked;
		get_by_id("remote_inbound_filter").disabled = !get_by_id("remote_enable").checked;
		get_by_id("graphical_enable_check").checked = (graph_enable == "none")? false: true;
		var show_selected = get_by_id("remote_http_management_inbound_filter").value;
		ori_inbound_filter = get_by_id("remote_http_management_inbound_filter").value;
		ori_management_port = get_by_id("remote_http_management_port").value;
		ori_hostname = get_by_id("hostname").value;

/*
		if ((get_by_id("admin_password").value).length == 0) {
			get_by_id("admin_password1").value = "";
			get_by_id("admPass2").value = "";
		}
*/
/*
		if ((get_by_id("user_password").value).length == 0) {
			get_by_id("user_password1").value = "";
			get_by_id("usrPass2").value = "";
		}
*/

		 var detail_value = get_by_id("remote_http_management_inbound_filter").value;
			if(detail_value=="Allow_All"){
				detail_value = "Allow All";
			}else if (detail_value=="Deny_All"){
				detail_value = "Deny All";
			}
		get_by_id("remote_detail").value = detail_value;
		
		if(get_by_id("remote_http_management_inbound_filter").value !="Allow_All" && get_by_id("remote_http_management_inbound_filter").value !="Deny_All"){
			for(i=0;i<DataArray.length;i++){
				if(DataArray[i].Name == get_by_id("remote_http_management_inbound_filter").value){
					get_by_id("remote_detail").value = DataArray[i].sAction +","+ DataArray[i].Show_W;
					show_selected = i;
					break;
				}
			}
		}
		set_selectIndex(show_selected, get_by_id("remote_inbound_filter"));
    
		/*HTTPS function start */
		disable_remote(get_by_id("remote_http_management_enable").value == "1");
		/*HTTPS function end */

		//disable_obj();
		/*SSL Remote Management*/
		if ("<!--# echo feature_vpn -->" !== "1")
			get_by_id("ssl_vpn").style.display="none";
		else {

			var temp_pem = get_by_id("https_pem").value;
			if (temp_pem != "") {
				var pem = temp_pem.split("_");
				get_by_id("certifi").value = pem[1];
			}
		}

		if ("<!--# echo remote_ssl -->" == "") {
			get_by_id("ssl_remote").style.display="none";
		} else if ("<!--# echo remote_ssl -->" == "1") {
			set_checked("<!--# echo remote_ssl -->", get_by_id("box_remote_https_enable")); 
			get_by_id("remote_http_management_port").value = remote_https_port;
			get_by_id("remote_ssl_ck").checked = true;
			get_by_id("certifi").disabled = false;
			get_by_id("ssl_remote_ipaddr").disabled = false;
			get_by_id("sslport").disabled = false;
		} else {
			get_by_id("remote_ssl_ck").checked = false;
			get_by_id("certifi").disabled = true;
			get_by_id("ssl_remote_ipaddr").disabled = true;
			get_by_id("sslport").disabled = true;
		}
		set_form_default_values("form1");
	}
  
	function disable_remote(checked){
		get_by_id("remote_http_management_port").disabled = !checked;
		get_by_id("remote_inbound_filter").disabled = !checked;

		if (checked && get_by_id("box_https_enable").checked) {
			get_by_id("box_remote_https_enable").disabled = false;
		}else {
			get_by_id("box_remote_https_enable").disabled = true;
		}
		disable_obj();
	}

	function disable_https(checked)
	{
		if (!checked) {
			get_by_id("box_remote_https_enable").checked = false;
			get_by_id("box_remote_https_enable").disabled = true;
			get_by_id("remote_http_management_port").value = remote_http_port;
		}
		else if (get_by_id("remote_enable").checked) {
			get_by_id("box_remote_https_enable").disabled = false;
		}
    
    
	}

	function remote_https_selector(checked)
	{
		if (checked) {
		    get_by_id("remote_http_management_port").value = remote_https_port;
		}
		else {
		    get_by_id("remote_http_management_port").value = remote_http_port;
	    }
	}
	function disable_obj(){
		get_by_id("remote_http_management_port").disabled = !get_by_id("remote_enable").checked;
		get_by_id("remote_inbound_filter").disabled = !get_by_id("remote_enable").checked;
		if(get_by_id("box_https_enable").checked){
			get_by_id("box_remote_https_enable").disabled = !get_by_id("remote_enable").checked; 
			get_by_id("box_remote_https_enable").checked = false; 
			get_by_id("remote_http_management_port").value = remote_http_port;
		}
	}
	
	//name/action/used(vs/port/wan/remote)
	function Data(name, action, used, onList) 
	{
		this.Name = name;
		this.Used = used;
		this.Show_W = "";
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

	function send_request()
	{
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
//		get_by_id("admin_password_tmp").value=get_by_id("admin_password").value;
//		get_by_id("user_password_tmp").value=get_by_id("user_password").value
		var remote_enable = get_by_id("remote_enable");
		var remote_port = get_by_id("remote_http_management_port").value;
    		var remote_port_msg = replace_msg(check_num_msg, ta_RAP, 1, 65535);
    		var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
	    	var c_hostname=get_by_id("hostname").value;
		var mydlink_register_st = "<!--# echo register_st -->";

	        re=/^\W/;       
	        if(re.test(c_hostname)){
        	        alert(GW_LAN_DEVICE_NAME_INVALID);
                	return false;
        	}
        
        	if (check_DeviceName(c_hostname)) {
        	    return false;
        	}
		if (mydlink_register_st == 1 && get_by_id("admin_password1").value.length < 6) {
			alert(wizard_check_passwd_length);
			return false;
		}
	
		if( !is_ascii(get_by_id("admin_password1").value) || !is_ascii(get_by_id("admPass2").value) ) {
			alert(MSG047);
			return false;
		}

/*
		if( !is_ascii(get_by_id("user_password1").value) || !is_ascii(get_by_id("usrPass2").value) ) {
			alert(MSG048);
			return false;
		}
*/

		if (get_by_id("admin_password1").value != get_by_id("admPass2").value){
			alert(YM173);
/*
		}else if (get_by_id("user_password1").value != get_by_id("usrPass2").value){
			alert(YM174);
*/
		}else if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/")){
			alert(TEXT004);
		}else{ 
			if(get_by_id("remote_enable").checked){
				if (!check_varible(remote_port_obj)){
					return false;
				}
			}
		//check pasword is default/empty or not?
		if (get_by_id("admin_password1").value !== "WDB8WvbXdH") {
			get_by_id("admin_password").value = get_by_id("admin_password1").value;
		} else
			get_by_id("admin_password").disabled = true;
/*
		if (get_by_id("user_password1").value !== "WDB8WvbXdH") {
			get_by_id("user_password").value = get_by_id("user_password1").value;
		}		
*/
	

		if(get_by_id("remote_http_management_enable").value != get_checked_value(get_by_id("remote_enable")))
		{
			get_by_id("remote_http_management_enable").value = get_checked_value(get_by_id("remote_enable"));
			get_by_id("reboot_type").value = "filter";
		}
				
		if(get_by_id("remote_http_management_port").value != ori_management_port)
		{
			get_by_id("reboot_type").value = "filter";
		}
		
		if(get_by_id("remote_http_management_inbound_filter").value != ori_inbound_filter)
		{
			get_by_id("reboot_type").value = "filter";
		}
		
		/*HTTPS function start */
		if (remote_https_enable != get_checked_value(get_by_id("box_remote_https_enable"))) {
			remote_https_enable = get_checked_value(get_by_id("box_remote_https_enable"));
			get_by_id("reboot_type").value = "filter";
		}

		if (https_enable != get_checked_value(get_by_id("box_https_enable"))) {
			https_enable = get_checked_value(get_by_id("box_https_enable"));
			get_by_id("reboot_type").value = "lan";
		}

		if (get_by_id("box_remote_https_enable").checked) {
			remote_https_port = get_by_id("remote_http_management_port").value;
		}
		else {
			remote_http_port = get_by_id("remote_http_management_port").value;
		}

		get_by_id("https_config").value = https_enable + "/" + remote_https_enable + "/" +
							remote_https_port + "/" + remote_http_port;
		get_by_id("remote_ssl").value = remote_https_enable;
		
		/*HTTPS function end */

		if(get_by_id("hostname").value != ori_hostname)
		{
			get_by_id("reboot_type").value = "all";
		}
	
		

/* SSL Remote Management */
/*
		if("<!--# echo remote_ssl -->" == "") {
			; // break
		} else if(get_by_id("remote_ssl_ck").checked == true) {
                        get_by_id("remote_ssl").value = "1";
			if ("<!--# echo feature_vpn -->" == "1") {
				//check  Certificate
				if(get_by_id("certifi").value == ""){
					alert(vpn_ssl_not_blank + vpn_ipsec_set_x509);
					return false;
				}       
				if (!check_cert_date())
					return false;
				get_by_id("https_pem").value = "x509_" + get_by_id("certifi").value;
			}
			var sslport = get_by_id("sslport").value; 
			if (sslport == "" || parseInt(sslport) < 1 || parseInt(sslport) > 65535) {
				alert(vpn_ssl_port + " " + GW_NAT_PORT_FORWARD_PORT_RANGE_INVALIDc);
				return false;
			}

			if (!iprange_fmt_check(get_by_id("ssl_remote_ipaddr").value))
				return false;
                }else
                        get_by_id("remote_ssl").value = "0";
*/

/*End SSL Remote Management */
		if (get_by_id("remote_enable").checked) {
			for(var i = 0; i < vs_rule_max; i++){
				//check virtual server public port and remote management port conflict problem
				if(get_by_id("vs_rule_" + i).value != ""){
					var vs_rule = (get_by_id("vs_rule_" + i).value).split("/");
					if(vs_rule[3] != "" && vs_rule[0] == "1" ){
						if(!check_multi_port(remote_port, vs_rule[3])){
							alert(tool_admin_portconflict_vs +" "+ tool_admin_check);	
							return false;
						}
					}
				}
				//check port forwarding tcp port and remote management port conflict problem
				if(get_by_id("port_forward_both_" + i).value != ""){
					var pf_rule = (get_by_id("port_forward_both_" + i).value).split("/");
					if(pf_rule[3] != "" && pf_rule[0] == "1" ){
						if(!check_multi_port(remote_port, pf_rule[3])){
							alert(tool_admin_portconflict+" "+tool_admin_pfname +" "+ pf_rule[1] +" "+ tool_admin_check);	
							return false;
						}
					}
				}
				//check application firewall port and remote management port conflict problem
				if (i > 9){
					temp_appl = get_by_id("application_" + i).value;
				}else{
					temp_appl = get_by_id("application_0" + i).value;				
				}
				if(temp_appl != ""){
					var app_rule = temp_appl.split("/");
					if(app_rule[5] != "" && app_rule[0] == "1" ){
						if(!check_multi_port(remote_port, app_rule[5])){
							alert(tool_admin_portconflict_app +" "+ tool_admin_check);	
							return false;
						}
					}
				}
			
			}
			//check storage port and management port conflict problem
			if ("<!--# echo file_access_enable -->" == 1) {
				if (remote_port == "<!--# echo file_access_remote_port-->" ) {
					alert(tool_admin_portconflict_st +" "+ tool_admin_check);	
					return false;
				}

				if (remote_port == "<!--# echo file_access_ssl_port -->" ) {
					alert(tool_admin_portconflict_sl +" "+ tool_admin_check);	
					return false;
				}
			}
		}	
		
		get_by_id("remote_http_management_enable").value = get_checked_value(get_by_id("remote_enable"));
		get_by_id("graph_enable").value = get_by_id("graphical_enable_check").checked? "open": "none";
		
//		if (get_by_id("admin_password_tmp").value != "<!--# echot admin_password_tmp -->" || get_by_id("user_password_tmp").value != "<!--# echot user_password_tmp -->") {
//		if (get_by_id("admin_password_tmp").value != "<!--# echot admin_password_tmp -->") {
//			get_by_id("html_response_return_page").value = "tools_admin.asp";
//		}
		
		save_inbound_used(get_by_id("remote_http_management_inbound_filter").value, inbound_used);
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
	return false;
}
	
	function inbound_filter_name_selector(obj_value){
		if(obj_value != "Allow_All" && obj_value != "Deny_All"){
			get_by_id("remote_http_management_inbound_filter").value = DataArray[obj_value].Name;
			get_by_id("remote_detail").value = DataArray[obj_value].sAction +","+ DataArray[obj_value].Show_W;
		}else{
			get_by_id("remote_http_management_inbound_filter").value = obj_value;
			get_by_id("remote_detail").value = obj_value;
		}
	}

	function set_certificate(type){
                for(var i = 1; i < 25; i++){
                        var ooption = document.createElement("option");
                        var temp_certifi = (get_by_id("x509_" + i).value).split(";");
                        if (temp_certifi != ""){
                                var temp_certifi_data = temp_certifi[0].split(",");
                                if (temp_certifi_data[1] == type){
                                        document.write("<option value='" + i + "'>" + temp_certifi_data[0] + "</option>");
                                }
                        }
                }
        }

	function check_ssl_ck()
	{
		if(get_by_id("remote_ssl_ck").checked == true) {
			get_by_id("certifi").disabled = false;
			get_by_id("ssl_remote_ipaddr").disabled = false;
			get_by_id("sslport").disabled = false;
		} else {
			get_by_id("certifi").disabled = true;
			get_by_id("ssl_remote_ipaddr").disabled = true;
			get_by_id("sslport").disabled = true;
		}
	}
//check Certificate Date
function check_cert_date()
{
        var index = parseInt(get_by_id("certifi").selectedIndex) + 1;
        var x509 = get_by_id("x509_" + index).value;
        var temp_certifi = x509.split(";");
        var temp_certifi_data = temp_certifi[0].split(",");
        var temp_issuer = temp_certifi[1].split("$");
        var temp_subject = temp_certifi[2].split("$");
        var temp_expire = temp_certifi[3].split("$");
        var temp_date = temp_expire[1].split("-");

        return check_validity(temp_date[0], temp_date[1]);
}

function check_validity(start_date, end_date){
        var sys_time = "<!--# exec cgi /bin/get_time -->";
        var nNow = new Date(sys_time);

        var tmp_start = start_date.split(" ");
        var tmp_end = end_date.split(" ");
        var tmp_start_time = tmp_start[1] + " " + tmp_start[2] + ", "  + tmp_start[4] + " " + tmp_start[3];
        var tmp_end_time =  tmp_end[0] + " " + tmp_end[1] + ", "  + tmp_end[3] + " " + tmp_end[2];

        var test1 = new Date(tmp_start_time);
        var test2 = new Date(tmp_end_time);

        if(nNow <= test2 && nNow >= test1){
                return true;
        }else{
                return confirm(vpn_ipsec_verify_check_info);
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
			<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("tools", 0);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
                <input type="hidden" id="vs_rule_0" name="vs_rule_0" value="<!--# echo vs_rule_00 -->">
                <input type="hidden" id="vs_rule_1" name="vs_rule_1" value="<!--# echo vs_rule_01 -->">
                <input type="hidden" id="vs_rule_2" name="vs_rule_2" value="<!--# echo vs_rule_02 -->">
                <input type="hidden" id="vs_rule_3" name="vs_rule_3" value="<!--# echo vs_rule_03 -->">
                <input type="hidden" id="vs_rule_4" name="vs_rule_4" value="<!--# echo vs_rule_04 -->">
                <input type="hidden" id="vs_rule_5" name="vs_rule_5" value="<!--# echo vs_rule_05 -->">
                <input type="hidden" id="vs_rule_6" name="vs_rule_6" value="<!--# echo vs_rule_06 -->">
                <input type="hidden" id="vs_rule_7" name="vs_rule_7" value="<!--# echo vs_rule_07 -->">
                <input type="hidden" id="vs_rule_8" name="vs_rule_8" value="<!--# echo vs_rule_08 -->">
                <input type="hidden" id="vs_rule_9" name="vs_rule_9" value="<!--# echo vs_rule_09 -->">
                <input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<!--# echo vs_rule_10 -->">
                <input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<!--# echo vs_rule_11 -->">
                <input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<!--# echo vs_rule_12 -->">
                <input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<!--# echo vs_rule_13 -->">
                <input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<!--# echo vs_rule_14 -->">
                <input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<!--# echo vs_rule_15 -->">
                <input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<!--# echo vs_rule_16 -->">
                <input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<!--# echo vs_rule_17 -->">
                <input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<!--# echo vs_rule_18 -->">
                <input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<!--# echo vs_rule_19 -->">
                <input type="hidden" id="vs_rule_20" name="vs_rule_20" value="<!--# echo vs_rule_20 -->">
				<input type="hidden" id="vs_rule_21" name="vs_rule_21" value="<!--# echo vs_rule_21 -->">
				<input type="hidden" id="vs_rule_22" name="vs_rule_22" value="<!--# echo vs_rule_22 -->">
				<input type="hidden" id="vs_rule_23" name="vs_rule_23" value="<!--# echo vs_rule_23 -->">
				<input type="hidden" id="vs_rule_24" name="vs_rule_24" value="<!--# echo vs_rule_24 -->">

            <input type="hidden" id="port_forward_both_0" name="port_forward_both_0" value="<!--# echo port_forward_both_00 -->">
            <input type="hidden" id="port_forward_both_1" name="port_forward_both_1" value="<!--# echo port_forward_both_01 -->">
            <input type="hidden" id="port_forward_both_2" name="port_forward_both_2" value="<!--# echo port_forward_both_02 -->">
            <input type="hidden" id="port_forward_both_3" name="port_forward_both_3" value="<!--# echo port_forward_both_03 -->">
            <input type="hidden" id="port_forward_both_4" name="port_forward_both_4" value="<!--# echo port_forward_both_04 -->">
            <input type="hidden" id="port_forward_both_5" name="port_forward_both_5" value="<!--# echo port_forward_both_05 -->">
            <input type="hidden" id="port_forward_both_6" name="port_forward_both_6" value="<!--# echo port_forward_both_06 -->">
            <input type="hidden" id="port_forward_both_7" name="port_forward_both_7" value="<!--# echo port_forward_both_07 -->">
            <input type="hidden" id="port_forward_both_8" name="port_forward_both_8" value="<!--# echo port_forward_both_08 -->">
            <input type="hidden" id="port_forward_both_9" name="port_forward_both_9" value="<!--# echo port_forward_both_09 -->">
            <input type="hidden" id="port_forward_both_10" name="port_forward_both_10" value="<!--# echo port_forward_both_10 -->">
            <input type="hidden" id="port_forward_both_11" name="port_forward_both_11" value="<!--# echo port_forward_both_11 -->">
            <input type="hidden" id="port_forward_both_12" name="port_forward_both_12" value="<!--# echo port_forward_both_12 -->">
            <input type="hidden" id="port_forward_both_13" name="port_forward_both_13" value="<!--# echo port_forward_both_13 -->">
            <input type="hidden" id="port_forward_both_14" name="port_forward_both_14" value="<!--# echo port_forward_both_14 -->">
            <input type="hidden" id="port_forward_both_15" name="port_forward_both_15" value="<!--# echo port_forward_both_15 -->">
            <input type="hidden" id="port_forward_both_16" name="port_forward_both_16" value="<!--# echo port_forward_both_16 -->">
            <input type="hidden" id="port_forward_both_17" name="port_forward_both_17" value="<!--# echo port_forward_both_17 -->">
            <input type="hidden" id="port_forward_both_18" name="port_forward_both_18" value="<!--# echo port_forward_both_18 -->">
            <input type="hidden" id="port_forward_both_19" name="port_forward_both_19" value="<!--# echo port_forward_both_19 -->">
            <input type="hidden" id="port_forward_both_20" name="port_forward_both_20" value="<!--# echo port_forward_both_20 -->">
			<input type="hidden" id="port_forward_both_21" name="port_forward_both_21" value="<!--# echo port_forward_both_21 -->">
			<input type="hidden" id="port_forward_both_22" name="port_forward_both_22" value="<!--# echo port_forward_both_22 -->">
			<input type="hidden" id="port_forward_both_23" name="port_forward_both_23" value="<!--# echo port_forward_both_23 -->">
			<input type="hidden" id="port_forward_both_24" name="port_forward_both_24" value="<!--# echo port_forward_both_24 -->">

			<input type="hidden" id="application_00" name="application_00" value="<!--# echo application_00 -->">
			<input type="hidden" id="application_01" name="application_01" value="<!--# echo application_01 -->">
			<input type="hidden" id="application_02" name="application_02" value="<!--# echo application_02 -->">
			<input type="hidden" id="application_03" name="application_03" value="<!--# echo application_03 -->">
			<input type="hidden" id="application_04" name="application_04" value="<!--# echo application_04 -->">
			<input type="hidden" id="application_05" name="application_05" value="<!--# echo application_05 -->">
			<input type="hidden" id="application_06" name="application_06" value="<!--# echo application_06 -->">
			<input type="hidden" id="application_07" name="application_07" value="<!--# echo application_07 -->">
			<input type="hidden" id="application_08" name="application_08" value="<!--# echo application_08 -->">
			<input type="hidden" id="application_09" name="application_09" value="<!--# echo application_09 -->">
			<input type="hidden" id="application_10" name="application_10" value="<!--# echo application_10 -->">
			<input type="hidden" id="application_11" name="application_11" value="<!--# echo application_11 -->">
			<input type="hidden" id="application_12" name="application_12" value="<!--# echo application_12 -->">
			<input type="hidden" id="application_13" name="application_13" value="<!--# echo application_13 -->">
			<input type="hidden" id="application_14" name="application_14" value="<!--# echo application_14 -->">
			<input type="hidden" id="application_15" name="application_15" value="<!--# echo application_15 -->">
			<input type="hidden" id="application_16" name="application_16" value="<!--# echo application_16 -->">
			<input type="hidden" id="application_17" name="application_17" value="<!--# echo application_17 -->">
			<input type="hidden" id="application_18" name="application_18" value="<!--# echo application_18 -->">
			<input type="hidden" id="application_19" name="application_19" value="<!--# echo application_19 -->">
			<input type="hidden" id="application_20" name="application_20" value="<!--# echo application_20 -->">
			<input type="hidden" id="application_21" name="application_21" value="<!--# echo application_21 -->">
			<input type="hidden" id="application_22" name="application_22" value="<!--# echo application_22 -->">
			<input type="hidden" id="application_23" name="application_23" value="<!--# echo application_23 -->">

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
	<input type="hidden" name="x509_1" id="x509_1" value="<!--# echo x509_1 -->">
	<input type="hidden" name="x509_2" id="x509_2" value="<!--# echo x509_2 -->">
	<input type="hidden" name="x509_3" id="x509_3" value="<!--# echo x509_3 -->">
	<input type="hidden" name="x509_4" id="x509_4" value="<!--# echo x509_4 -->">
	<input type="hidden" name="x509_5" id="x509_5" value="<!--# echo x509_5 -->">
	<input type="hidden" name="x509_6" id="x509_6" value="<!--# echo x509_6 -->">
	<input type="hidden" name="x509_7" id="x509_7" value="<!--# echo x509_7 -->">
	<input type="hidden" name="x509_8" id="x509_8" value="<!--# echo x509_8 -->">
	<input type="hidden" name="x509_9" id="x509_9" value="<!--# echo x509_9 -->">
	<input type="hidden" name="x509_10" id="x509_10" value="<!--# echo x509_10 -->">
	<input type="hidden" name="x509_11" id="x509_11" value="<!--# echo x509_11 -->">
	<input type="hidden" name="x509_12" id="x509_12" value="<!--# echo x509_12 -->">
	<input type="hidden" name="x509_13" id="x509_13" value="<!--# echo x509_13 -->">
	<input type="hidden" name="x509_14" id="x509_14" value="<!--# echo x509_14 -->">
	<input type="hidden" name="x509_15" id="x509_15" value="<!--# echo x509_15 -->">
	<input type="hidden" name="x509_16" id="x509_16" value="<!--# echo x509_16 -->">
	<input type="hidden" name="x509_17" id="x509_17" value="<!--# echo x509_17 -->">
	<input type="hidden" name="x509_18" id="x509_18" value="<!--# echo x509_18 -->">
	<input type="hidden" name="x509_19" id="x509_19" value="<!--# echo x509_19 -->">
	<input type="hidden" name="x509_20" id="x509_20" value="<!--# echo x509_20 -->">
	<input type="hidden" name="x509_21" id="x509_21" value="<!--# echo x509_21 -->">
	<input type="hidden" name="x509_22" id="x509_22" value="<!--# echo x509_22 -->">
	<input type="hidden" name="x509_23" id="x509_23" value="<!--# echo x509_23 -->">
	<input type="hidden" name="x509_24" id="x509_24" value="<!--# echo x509_24 -->">

			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_admin.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="all">
				<input type="hidden" id="action" name="action" value="tools_admin">
				<script>get_by_id("reboot_type").value = _none</script>
				<input type="hidden" name="https_pem" id="https_pem" value="<!--# echo https_pem -->">
				<input type="hidden" id="blank_status" name="blank_status" value="<!--# echo blank_status -->">
				<input type="hidden" id="blank_state" name="blank_state" value="<!--# echo blank_state -->">		
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
				
			<td valign="top" id="maincontent_container">
				<div id="maincontent">	
					<div id="box_header">
						<h1><script>show_words(ta_AdmSt);</script></h1>
						<p><script>show_words(ta_intro1)</script></p>
						<p><script>show_words(ta_intro_Adm2)</script></p>
						<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                        <input name="button1" id="button1" type=reset class=button_submit value="" onclick="return page_cancel('form1', 'tools_admin.asp');">
						<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings</script>
						<script>get_by_id("button1").value = _dontsavesettings</script>
					</div>
					<div class="box">
						<h2><script>show_words(_password_admin)</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td colspan="2" class="box_msg"><p><script>show_words(ta_msg_TW)</script></p></td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(_password)</script> :</td>
									<!--input type="hidden" id="admin_password_tmp" name="admin_password_tmp" value=""-->
									<input type="hidden" id="admin_password" name="admin_password" value="">
									<input type="hidden" id="session_timeout" name="session_timeout" maxlength=32 value="180">
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id="admin_password1" name="admin_password1" size=20 maxlength=32 value="WDB8WvbXdH" onChange="key_word(this,'admin_password');"></font>
								</td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(_verifypw)</script> :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id=admPass2 name=admPass2 size=20 maxlength=32 value="WDB8WvbXdH"></font>
								</td>
							</tr>														
					  </table>
					</div>
					<!--div class="box">
						<h2><script>show_words(_password_user)</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td colspan="2" class="box_msg"><p><script>show_words(ta_msg_TW)</script></p></td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(_password)</script> :</td>
									<input type="hidden" id="user_password_tmp" name="user_password_tmp" value="<!--# echot user_password -->">
									<input type="hidden" id="user_password" name="user_password" value="">
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id="user_password1" name="user_password1" size=20 maxlength=15 value="WDB8WvbXdH" onChange="key_word(this,'user_password');"></font>
								</td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(_verifypw)</script> :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type="password" id="usrPass2" name="usrPass2" size="20" maxlength="15" value="WDB8WvbXdH"></font>
								</td>
							</tr>														
					  </table>
					</div-->
					<div class="box">
						<h2><script>show_words(ta_sn)</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td class="duple"><script>show_words(ta_GWN)</script> :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type="text" id="hostname" name="hostname" maxlength=32 value="<!--# echo hostname -->"></font>
								</td>
							</tr>
					  </table>
					</div>
				  <div class="box"> 
						<h2><script>show_words(ta_A12n)</script></h2>
				        <table cellpadding="1" cellspacing="1" border="0" width="525">
                          <tr>
                            <td class="duple"><script>show_words(_graph_auth)</script> :</td>
                            <td width="340" colspan="2"><div align="left">&nbsp;
                                    <input name="graphical_enable_check" type="checkbox" id="graphical_enable_check" value="1" checked>
                                    <input type="hidden" id="graph_enable" name="graph_enable" value="<!--# echo graph_enable -->">
                            </div></td>
                          </tr>			
			<tr>
                	<td width="183" class="duple"><div id="https_1" style="display:none"><script>show_words(_enable_https)</script> :</div></td>
                	<td colspan="3">
                   	<div id="https_2" style="display:none">
                    	&nbsp;
                    		<input name="box_https_enable" type="checkbox" id="box_https_enable" value="1" onClick="disable_https(this.checked);">
                    		<input type="hidden" id="https_config" name="https_config" value="<!--# echo https_config -->">
                	</div></td>
            		</tr>
                          <tr>
                            <td class="duple"><script>show_words(ta_ERM)</script> :</td>
                            <td width="340" colspan="2"><div align="left">&nbsp;
                                    <input name="remote_enable" type="checkbox" id="remote_enable" value="1" onClick="disable_obj();">
                                    <input type="hidden" id="remote_http_management_enable" name="remote_http_management_enable" value="<!--# echo remote_http_management_enable -->">
                            </div></td>
                          </tr>
                          <tr>
                            <td class="duple"><script>show_words(ta_RAP)</script> :</td>
                            <td><div align="left">&nbsp;&nbsp;
                                    <input type="text" id="remote_http_management_port" name="remote_http_management_port" value="<!--# echo remote_http_management_port -->">
                            </div></td>
			    <td><div id= "https_3" style="display:none">
                                    <script>show_words(_use_https)</script>
                                    <input name="box_remote_https_enable" type="checkbox" id="box_remote_https_enable" value="1" onClick="remote_https_selector(this.checked);">
                            </div></td>			               
			                                       </tr>
                          <tr>
                            <td class="duple"><script>show_words(ta_RA);</script> <a href="Inbound_Filter.asp" onClick="return jump_if();"><script>show_words(_inboundfilter);</script></a> : </td>
                            <td width="340" colspan="2"><div align="left">&nbsp;&nbsp;
                                    <select id="remote_inbound_filter" name="remote_inbound_filter" size="1" onChange="inbound_filter_name_selector(this.value);">
                                      <option value="Allow_All"><script>show_words(_allowall)</script></option>
                                      <option value="Deny_All"><script>show_words(_denyall)</script></option>
                                      <script>
                                    set_Inbound();
                                    show_option_value();
                                    </script>
                                    </select>
                                    <input type="hidden" id="remote_http_management_inbound_filter" name="remote_http_management_inbound_filter" value="<!--# echo remote_http_management_inbound_filter -->">
                            </div></td>
                          </tr>
                          <tr>
                            <td class="duple"><script>show_words(_aa_details);</script> :</td>
                            <td width="340" colspan="2"><div align="left">&nbsp;&nbsp;
                                    <input type=text id="remote_detail" name="remote_detail" size=48 maxlength=48 disabled>
                            </div></td>
                          </tr>
                        </table>
				  </div>
                                        <div class="box" id="ssl_remote" style="display:none">
                                                <h2><script>show_words(_admin_ssl)</script></h2>
                                                <table cellpadding="1" cellspacing="1" border="0" width="525">
                          <tr>
                            <td class="duple"><script>show_words(_admin_ssl_enable)</script> : </td>
                            <td width="340"><div align="left">&nbsp;
                                                                <input name="remote_ssl_ck" id="remote_ssl_ck" type="checkbox" value="1" onclick="check_ssl_ck();">&nbsp; <script>show_words(_admin_ssl_port)</script>
                                                                <input type="hidden" id="remote_ssl" name="remote_ssl" value="<!--# echo remote_ssl -->">
                                                        </div></td>
                          </tr>
                          <tr id="ssl_vpn">
                                <td class="duple"><div align="right"><script>show_words(vpn_ssl_certi_sel);</script>: </div></td>
                                <td width="340"><div align="left">&nbsp;
                    <select id="certifi" name="certifi">
                                        <script>set_certificate("PKI");</script>
                    </select>&nbsp; <a href="adv_certificate.asp"><script>show_words(_new);</script></a></div></td>
                                  </tr>
                                <tr>
                            <td class="duple"><div align="right"><script>show_words(_ipaddr)</script>: </div></td>
                            <td width="340"><div align="left">&nbsp;
                                                <input type=text id="ssl_remote_ipaddr" name="ssl_remote_ipaddr" maxlength=100 value="<!--# echo ssl_remote_ipaddr -->">
                            </div></td>
                                </tr>
                                <tr>
                            <td class="duple"><div align="right"><script>show_words(_admin_ssl_port_select);</script>: </div></td>
                            <td width="340"><div align="left">&nbsp;
                                                <input type=text name="sslport" id="sslport" maxlength=5 value="<!--# echo sslport -->">
                            </div></td>
                                </tr>
                      </table>
                                </div>
				</div>				
			</td>
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
					  	<strong><script>show_words(_hints);</script>&hellip;</strong>
					  	<p><script>show_words(hhta_pw)</script></p>
					  	<p><script>show_words(hhta_en)</script></p>
						<p><script>show_words(hhta_pt)</script></p>
						<p><script>show_words(hhta_831)</script></p>
					  	<p><a href="support_tools.asp#Admin" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	reboot_needed(left["tools"].link[0]);
	onPageLoad();
</script>
</html>
