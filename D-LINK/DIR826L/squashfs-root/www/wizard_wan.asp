<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<style type="text/css">
/*
 * Styles used only on this page.
 * WAN mode radio buttons
 */
#wan_modes p {
	margin-bottom: 1px;
}
#wan_modes input {
	float: left;
	margin-right: 1em;
}
#wan_modes label.duple {
	float: none;
	width: auto;
	text-align: left;
}
#wan_modes .itemhelp {
	margin: 0 0 1em 2em;
}

/*
 * Wizard buttons at bottom wizard "page".
 */
#wz_buttons {
	margin-top: 1em;
	border: none;
}
</style>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	
	var pageNameArray = new Array('p0'	, 'p1', 'p2'  , 'p3'	  , 'p4a'  , 'p4b'   , 'p4c'  , 'p4d' , 'p4e' , 'p4f'	 , 'p4g'	 , 'p5');
	var pageDescArray = new Array('main', 'pw', 'time', 'wantype' , 'dhcpc', 'static', 'pppoe', 'pptp', 'l2tp', 'bigpond', 'dhcpplus', 'save');
	var wz_curr_page=0;
	var wz_prev_page=0;
	var wz_next_page=1;
	
	var	param = {
		url: "get_set.ccp",
		arg: "ccp_act=get&num_inst=13"+
			"&oid_1=IGD_&inst_1=10000"+
			"&oid_2=IGD_Time_&inst_2=11000"+
			"&oid_3=IGD_LANDevice_i_LANHostConfigManagement_&inst_3=11100"+
			"&oid_4=IGD_LANDevice_i_LANHostConfigManagement_DHCPDynamicAddress_i_&inst_4=11100"+
			"&oid_5=IGD_WANDevice_i_WANConnectionDevice_i_&inst_5=11100"+
			"&oid_6=IGD_WANDevice_i_WANConnectionDevice_i_StaticIP_i_&inst_6=11110"+
			"&oid_7=IGD_WANDevice_i_WANConnectionDevice_i_DHCP_i_&inst_7=11110"+
			"&oid_8=IGD_WANDevice_i_WANConnectionDevice_i_PPPoE_i_&inst_8=11110"+
			"&oid_9=IGD_LANDevice_i_WLANConfiguration_i_&inst_9=11100"+
			"&oid_10=IGD_WANDevice_i_WANConnectionDevice_i_PPTP_i_&inst_10=11110"+
			"&oid_11=IGD_WANDevice_i_WANConnectionDevice_i_PPTP_i_ConnectionCfg_i_&inst_11=11111"+
			"&oid_12=IGD_WANDevice_i_WANConnectionDevice_i_L2TP_i_&inst_12=11110"+
			"&oid_13=IGD_WANDevice_i_WANConnectionDevice_i_L2TP_i_ConnectionCfg_i_&inst_13=11111"
	};
	get_config_obj(param);
	
	var already_clone = config_val("wanConnDev_MACAddressOverride_");
	var hw_mac = config_val("wanConnDev_MACAddress_");	
	var hw_mac_org = hw_mac;
	var cli_mac 	= dev_info.cli_mac;

var gTimezoneIdx = config_val("sysTime_LocalTimeZoneIndex_");
var lanCfg = {
	'lanIp':		config_val('lanHostCfg_IPAddress_'),
	'lanSubnet':	config_val('lanHostCfg_SubnetMask_'),
	'lanDhcp':		config_val('lanHostCfg_DHCPServerEnable_'),
	'lanMinAddr':	config_val('lanHostCfg_MinAddress_'),
	'lanMaxAddr':	config_val('lanHostCfg_MaxAddress_'),
	'lanHostName':	config_val('lanHostCfg_HostName_')
};
var wanCfg = {
	'wanMode':			config_val('wanConnDev_CurrentConnObjType_'),
	'wanMac':			config_val('wanConnDev_MACAddress_'),
	'wanMacCloned':		config_val('wanConnDev_MACAddressOverride_'),

	'wanStaticIp':		config_val('staticIPCfg_ExternalIPAddress_'),
	'wanStaticSubnet':	config_val('staticIPCfg_SubnetMask_'),
	'wanStaticGw':		config_val('staticIPCfg_DefaultGateway_'),
	'wanStaticDns':		config_val('staticIPCfg_DNSServers_'),
	
	'wanPppoeType':		config_val('pppoeCfg_IPAddressType_'),
	'wanPppoeAddr':		config_val('pppoeCfg_ExternalIPAddress_'),
	'wanPppoeName':		config_val('pppoeCfg_Username_')? config_val('pppoeCfg_Username_'):"",
	'wanPppoePass':		config_val('pppoeCfg_Password_'),
	'wanPppoeServ':		config_val('pppoeCfg_ServiceName_')? config_val('pppoeCfg_ServiceName_'):"",
	'wanPppoePlus':		config_val('pppoeCfg_PPPoEPlusDialEnable_'),
	
	'wanDhcpHost':		config_val('dhcpCfg_Name_')? config_val('dhcpCfg_Name_'):"",
	
	'wanDhcpplusHost':	config_val('dhcpplusCfg_Name_')? config_val('dhcpplusCfg_Name_'):"",
	'wanDhcpplusUser':	config_val('dhcpplusCfg_Username_')? config_val('dhcpplusCfg_Username_'):"",
	
	'wanPPTPType':		config_val('pptpCfg_IPAddressType_'),
	'wanPPTPAddr':		config_val('pptpCfg_ExternalIPAddress_'),
	'wanPPTPMask':		config_val('pptpCfg_SubnetMask_'),
	'wanPPTPGw':		config_val('pptpCfg_DefaultGateway_'),
	'wanPPTPServ':		config_val('pptpConn_ServerIP_'),
	'wanPPTPName':		config_val('pptpConn_Username_'),
	'wanPPTPPass':		config_val('pptpConn_Password'),
	
	'wanL2TPType':		config_val('l2tpCfg_IPAddressType_'),
	'wanL2TPAddr':		config_val('l2tpCfg_ExternalIPAddress_'),
	'wanL2TPMask':		config_val('l2tpCfg_SubnetMask_'),
	'wanL2TPGw':		config_val('l2tpCfg_DefaultGateway_'),
	'wanL2TPServ':		config_val('l2tpConn_ServerIP_'),
	'wanL2TPName':		config_val('l2tpConn_Username_'),
	'wanL2TPPass':		config_val('l2tpConn_Password')
};

//if(config_val('dhcpCfg_Name_'))	wanCfg.wanDhcpHost = config_val('dhcpCfg_Name_');
//if(config_val('dhcpplusCfg_Name_'))	wanCfg.wanDhcpplusHost = config_val('dhcpplusCfg_Name_');
//if(config_val('dhcpplusCfg_Username_'))	wanCfg.wanDhcpplusUser = config_val('dhcpplusCfg_Username_');

var wlanCfg = {
	'wlanEnable':		config_val('lanWlanCfg_Enable_'),
	'wlanSSID':			config_val('lanWlanCfg_SSID_'),
	'wlanCh':			config_val('lanWlanCfg_Channel_')
};
	
	function clone_mac_action(obj){
		get_by_id(obj).value = cli_mac;
		already_clone = 1;
	}
	
	function onPageLoad()
	{
		get_by_id("wan_mac").value = wanCfg.wanMac;
	}
	
	var submit_button_flag = 0;
	function send_request(){
		var login_who=dev_info.login_info;
		
		if(login_who!= "w")
		{
			//window.location.href ="index.asp";
			window.location.href ="user_page.asp";
			return false;
		}
		else
		{	
			var paramStr = "";
			paramStr += "&ccpSubEvent=CCP_SUB_WIZARD";
			paramStr += "&nextPage=sel_wan.asp";
			paramStr += "&loginInfo_Username_1.1.1.0.0=admin&loginInfo_Password_1.1.1.0.0=" + urlencode(get_by_id("pwd1").value);
			paramStr += "&sysTime_LocalTimeZone_1.1.0.0.0=" + get_by_id("tzone").value;
			paramStr += "&sysTime_LocalTimeZoneName_1.1.0.0.0=" + get_by_id("tzone").options[get_by_id("tzone").selectedIndex].text
			paramStr += "&sysTime_LocalTimeZoneIndex_1.1.0.0.0=" + get_by_id("tzone").selectedIndex;
			
			switch(get_checked_value(get_by_name('wan_type')))
			{
				case "dhcpc":
					paramStr += constructParamDHCPC();
					break;
				case "static":
					paramStr += constructParamStaticIP();
					break;
				case "pppoe":
					paramStr += constructParamPPPoE();
					break;
				case "pptp":
					paramStr += constructParamPPTP();
					break;
				case "l2tp":
					paramStr += constructParamL2TP();
					break;
				case "dhcpplus":
					paramStr += constructParamDHCPPlus();
					break;
			}
			
			var paramSubmit = {
				url: "get_set.ccp",
				arg: 'ccp_act=set'
			};	
			paramSubmit.arg += paramStr;
			if(submit_button_flag == 0){
				get_config_obj(paramSubmit);
				submit_button_flag = 1;
				return true;
			}else{
				return false;
			}
		}
	}
	
	function wizard_cancel(){
		if (is_form_modified("formAll")){
			if(!confirm(get_words('_wizquit'))) {
				return false;
			}
		}
		window.location.href="index.asp";
	}

	function select_wan_type(){
		set_checked(get_by_id("select_isp").value, get_by_name("wan_type"));
	}
	
	function displayPage(page)
	{
		for(var i=0; i < pageNameArray.length; i++)
		{
			if(pageNameArray[i] == page)
			{
				get_by_id(pageNameArray[i]).style.display = "";
				if((i >= 6) && (i <=8))
				{
					show_static_ip(mapPage2WanType(page));
				}
			}
			else
				get_by_id(pageNameArray[i]).style.display = "none";
		}
		
		//var indexPage = pageNameArray.indexOf(page);
		/*
		var indexPage = pageNameArray.indexOf(searchElement[, 0]);
		if((indexPage >= 6) && (indexPage <=8))
		{
			show_static_ip(mapPage2WanType(page));
		}
		*/
	}
	
	function mapPage2WanType(pageId)
	{
		switch(pageId)
		{
			case "p4a":
				return "dhcpc";
			case "p4b":
				return "static";
			case "p4c":
				return "pppoe";
			case "p4d":
				return "pptp";
			case "p4e":
				return "l2tp";
			case "p4f":
				return "bigpond";
			case "p4g":	
				return "dhcpplus";
		}
	}
	
	function mapWanType2Page(wan)
	{
		switch(wan)
		{
			case "dhcpc":
				return "p4a";
			case "pppoe":
				return "p4c";
			case "pptp":
				return "p4d";
			case "l2tp":
				return "p4e";
			case "static":
				return "p4b";
			case "bigpond":
				return "p4f";
			case "dhcpplus":
				return "p4g";
		}
	}
	
	function findIndexOfArrayByValue(array, value)
	{
		for (var i=0; i<array.length; i++)
		{
			if(array[i] == value)
				return i;
		}
		return -1;
	}
	
	function next_page()
	{
		if(	(wz_curr_page != 0) &&
			(wz_curr_page != 3))
		{
			if(eval("verify_wz_page_"+pageNameArray[wz_curr_page])() == false)
				return;
		}
			
		wz_prev_page = wz_curr_page;
		
		switch(wz_curr_page)
		{
			case 3:
				//wz_curr_page = pageNameArray.indexOf(mapWanType2Page(get_checked_value(get_by_name('wan_type'))));
				wz_curr_page = findIndexOfArrayByValue(pageNameArray, mapWanType2Page(get_checked_value(get_by_name('wan_type'))));
				break;
			case 0:
			case 1:
			case 2:		
				wz_curr_page ++;
				break;
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
				wz_curr_page = (pageNameArray.length - 1);
				break;
		}
		
		if(wz_curr_page == 4)
			get_by_id("wan_mac").value =wanCfg.wanMac;
		if(wz_curr_page == 10)
			get_by_id("dhcpplus_wan_mac").value = wanCfg.wanMac;
		
		if((wz_curr_page == 10)	|| (wz_curr_page == 4)	)
		{
			already_clone = wanCfg.wanMacCloned;
			hw_mac = wanCfg.wanMac;
		}
			
		displayPage(pageNameArray[wz_curr_page]);
	}
	
	function prev_page(page)
	{
		wz_curr_page = wz_prev_page;		
		if( (wz_curr_page >= 4) &&
			(wz_curr_page <= 10))
			wz_prev_page = 3;
		else 
			wz_prev_page --;
		displayPage(pageNameArray[wz_curr_page]);
	}
	
	function show_static_ip(objname){	
		var ppp_type = get_by_name(objname + "_type");	
		if(ppp_type == null)
			return;

		get_by_id(objname+"_ip").disabled = ppp_type[0].checked;
		
		var mask_obj = get_by_id(objname + "_mask");
		var gw_obj = get_by_id(objname + "_gw");
		
		if(mask_obj)
			mask_obj.disabled = ppp_type[0].checked;
		if(gw_obj)
			gw_obj.disabled = ppp_type[0].checked;
	}	
	
	// verify password
	function verify_wz_page_p1()
	{
		if (get_by_id("pwd1").value != get_by_id("pwd2").value){
			//alert(msg[MATCH_WIZARD_PWD_ERROR]);
			alert(get_words('_pwsame'));
			return false;
		}
		
		if((get_by_id("pwd1").value!="") && (is_ascii(get_by_id("pwd1").value)==false))
		{
			alert(get_words('S493'));
			return false;
		}
		
		return true;
	}
	
	function verify_wz_page_p2()
	{
		return true;
	}
	
	function verify_wz_page_p3()
	{
		return true;
	}
	
	function verify_wz_page_p4a()
	{
		var c_host = get_by_id("host").value
		if(c_host=="") {
			alert (get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false;
		}
		/*
		 * Validate MAC and activate cloning if necessary
		 */		
		 
		var mac = get_by_id("wan_mac").value; 
		if (!check_mac(mac)){
			//alert(msg[MAC_ADDRESS_ERROR]);
			alert (get_words('KR3'));
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			//alert ("Invalid MAC address:" + mac + ".");
			alert (get_words('KR3'));
			return false;
		}
		
		if(Find_word(c_host,"'") || Find_word(c_host,'"') || Find_word(c_host,"/") || _isNumeric(c_host)){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false
		}
		
		if(mac.toLowerCase() != hw_mac_org.toLowerCase())
			already_clone = "1";
			
		return true;
	}
	
	function verify_wz_page_p4b()
	{
	    var ip = get_by_id("ip").value;
    	var mask = get_by_id("mask").value;
    	var gateway = get_by_id("gateway").value;
    	var dns1 = get_by_id("dns1").value;
        var dns2 = get_by_id("dns2").value;       
        
		var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
		var dns1_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_pdns'));
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_sdns'));
        
        var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
                
        if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
        	return false;
        }	     
                
		if (!check_address(temp_dns1_obj)){
			return false;
		}
    	
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2_obj)){
    			return false;
    		}
    	}
		return true;
	}
	
	function verify_wz_page_p4c()
	{
		var pppoe_type = get_by_name("pppoe_type");
		var ip = get_by_id("pppoe_ip").value;
		
		if (pppoe_type[1].checked){
			var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			
			if (!check_address(temp_ip_obj)){
        		return false;
	    	}
		}
		if(get_by_id("pppoe_user_name").value == ""){
    		alert(get_words('GW_WAN_PPPOE_USERNAME_INVALID'));
    		return false;
	     }
	     
	      if (get_by_id("pppoe_pwd1").value == "" || get_by_id("pppoe_pwd2").value == ""){
		 	//alert("A PPPoE password MUST be specified");	
		 	alert(get_words('GW_WAN_PPPOE_PASSWORD_INVALID'));
			return false;
		}
		
		if (!check_pwd("pppoe_pwd1", "pppoe_pwd2")){
			return false;
        }

		return true;
	}
	
	function verify_wz_page_p4d()
	{
		var pptp_type = get_by_name("pptp_type");
    	var ip = get_by_id("pptp_ip").value;
    	var mask = get_by_id("pptp_mask").value;  
    	var gateway = get_by_id("pptp_gw").value;
		var server_ip = get_by_id("pptp_server_ip").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
                
		if (pptp_type[1].checked){    	      
        	if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
        		return false;
        	}
        }
    	
    	if(server_ip == ""){
    		//alert(msg[ZERO_SERVER_IP]);
    		alert(get_words('YM108'));
    		return false;
       	}
       	if(get_by_id("pptpuserid").value == ""){
       		alert(get_words('GW_WAN_PPTP_USERNAME_INVALID'));
    		return false;
	     }
       	if (get_by_id("pptppwd").value == "" || get_by_id("pptppwd2").value == ""){
		 	//alert("A PPTP password MUST be specified");	//GW_WAN_PPTP_PASSWORD_INVALID
		 	alert(get_words('GW_WAN_PPTP_PASSWORD_INVALID'));
			return false;
		}
       	if (!check_pwd("pptppwd", "pptppwd2")){
       		return false;
       	}

		return true;
	}
	
	function verify_wz_page_p4e()
	{
		var l2tp_type = get_by_name("l2tp_type");
    	var ip = get_by_id("l2tp_ip").value;
    	var mask = get_by_id("l2tp_mask").value;  
    	var gateway = get_by_id("l2tp_gw").value;    	
		var server_ip = get_by_id("l2tp_server_ip").value;
    	
    	var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));
    	
    	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
    	
    	if (l2tp_type[1].checked){        
	        if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
	    		return false;
	    	}
       	}
       	
    	if(server_ip == ""){
    		//alert(msg[ZERO_SERVER_IP]);
    		alert(get_words('bwn_alert_17'));
    		return false;
       	}
        if(get_by_id("l2tpuserid").value == ""){
    		//alert(msg[PPP_USERNAME_EMPTY]);
    		alert(get_words('GW_WAN_L2TP_USERNAME_INVALID'));
    		return false;
	    }
	     
	    if (get_by_id("l2tppwd").value == "" || get_by_id("l2tppwd2").value == ""){
		 	//alert("A L2TP password MUST be specified");	//
		 	alert(get_words('GW_WAN_L2TP_PASSWORD_INVALID'));
			return false;
		}
       	
       	if (!check_pwd("l2tppwd", "l2tppwd2")){
       		return false;
       	}
		
		return true;
	}
	
	function verify_wz_page_p4f()
	{
		if (!check_pwd("bigpond_pwd", "bigpond_pwd2")){
       		return false;
       	}
		return true;
	}
	
	function verify_wz_page_p4g()
	{
		var c_host = get_by_id("dhcpplus_host").value
		/*
		 * Validate MAC and activate cloning if necessary
		 */		
		 
		var mac = get_by_id("dhcpplus_wan_mac").value; 
		if (!check_mac(mac)){
			//alert(msg[MAC_ADDRESS_ERROR]);
			alert (which_lang[KR3]+":" + mac + ".");
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("dhcpplus_wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			//alert ("Invalid MAC address:" + mac + ".");
			alert (get_words('KR3')+":" + mac + ".");
			return false;
		}
		
		if(Find_word(c_host,"'") || Find_word(c_host,'"') || Find_word(c_host,"/") || _isNumeric(c_host)){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false
		}
		
		if(mac.toLowerCase() != hw_mac_org.toLowerCase())
			already_clone = "1";
		
		if(get_by_id("dhcpplus_userid").value == ""){
    		//alert(msg[PPP_USERNAME_EMPTY]);
    		alert(get_words('GW_WAN_DHCPPLUS_USERNAME_INVALID'));
    		return false;
	    }
	     
	    if (get_by_id("dhcpplus_pwd").value == "" || get_by_id("dhcpplus_pwd2").value == ""){
		 	//alert("A L2TP password MUST be specified");	//
		 	alert(get_words('GW_WAN_DHCPPLUS_PASSWORD_INVALID'));
			return false;
		}
       	
       	if (!check_pwd("dhcpplus_pwd", "dhcpplus_pwd2")){
       		return false;
       	}
		
		return true;
	}
	
	function constructParamDHCPC()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=1";
		paramStr += "&wanConnDev_MACAddress_1.1.1.0.0=" + get_by_id("wan_mac").value;
		paramStr += "&wanConnDev_MACAddressOverride_1.1.1.0.0=" + already_clone;
		paramStr += "&dhcpCfg_Name_1.1.1.1.0=" + get_by_id("host").value;
		paramStr += "&dhcpCfg_UnicastUsed_1.1.1.1.0=0";
		//paramStr += "&dhcpCfg_DNSServers_1.1.1.1.0=0.0.0.0,0.0.0.0";
		paramStr += "&dhcpCfg_MaxMTUSize_1.1.1.1.0=1500";
		return paramStr;
	}
	
	function constructParamDHCPPlus()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=9";
		paramStr += "&wanConnDev_MACAddress_1.1.1.0.0=" + get_by_id("dhcpplus_wan_mac").value;
		paramStr += "&wanConnDev_MACAddressOverride_1.1.1.0.0=" + already_clone;
		paramStr += "&dhcpplusCfg_Name_1.1.1.1.0=" + urlencode(get_by_id("dhcpplus_host").value);
		paramStr += "&dhcpplusCfg_Username_1.1.1.1.0=" + urlencode(get_by_id("dhcpplus_userid").value);
		paramStr += "&dhcpplusCfg_Password_1.1.1.1.0=" + urlencode(get_by_id("dhcpplus_pwd").value);
		paramStr += "&dhcpplusCfg_UnicastUsed_1.1.1.1.0=0";
		//paramStr += "&dhcpplusCfg_DNSServers_1.1.1.1.0=0.0.0.0,0.0.0.0";
		paramStr += "&dhcpplusCfg_MaxMTUSize_1.1.1.1.0=1500";
		return paramStr;
	}
	
	function constructParamPPPoE()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=2";
		paramStr += "&pppoeCfg_IPAddressType_1.1.1.1.0=" + get_checked_value(get_by_name("pppoe_type"));
		paramStr += "&pppoeCfg_ExternalIPAddress_1.1.1.1.0=" + get_by_id("pppoe_ip").value;
		paramStr += "&pppoeCfg_ServiceName_1.1.1.1.0=" + get_by_id("pppoe_service").value;
		paramStr += "&pppoeCfg_Username_1.1.1.1.0=" + urlencode(get_by_id("pppoe_user_name").value);
		paramStr += "&pppoeCfg_Password_1.1.1.1.0=" + urlencode(get_by_id("pppoe_pwd1").value);
		//paramStr += "&pppoeCfg_DNSServers_1.1.1.1.0=0.0.0.0,0.0.0.0";
		//paramStr += "&pppoeCfg_ConnectionTrigger_1.1.1.1.0=2";
		//paramStr += "&pppoeCfg_IdleDisconnectTime_1.1.1.1.0=5";
		//paramStr += "&pppoeCfg_MaxMTUSize_1.1.1.1.0=1492";
		paramStr += "&pppoeCfg_NetSniperSupport_1.1.1.1.0=0";
		paramStr += "&pppoeCfg_SpecialDialMode_1.1.1.1.0=0";
		paramStr += "&pppoeCfg_PPPoEPlusDialEnable_1.1.1.1.0=" + get_checked_value(get_by_id("pppoe_plus_support"));
		return paramStr;
	}
	
	function constructParamStaticIP()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=0";
		paramStr += "&staticIPCfg_ExternalIPAddress_1.1.1.1.0=" + get_by_id("ip").value;
		paramStr += "&staticIPCfg_SubnetMask_1.1.1.1.0=" + get_by_id("mask").value;
		paramStr += "&staticIPCfg_DefaultGateway_1.1.1.1.0=" + get_by_id("gateway").value;
		paramStr += "&staticIPCfg_DNSServers_1.1.1.1.0=" + get_by_id("dns1").value +","+ get_by_id("dns2").value;
		paramStr += "&staticIPCfg_MaxMTUSize_1.1.1.1.0=1500";
		paramStr += "&dhcpCfg_AdvancedDNSEnable_1.1.1.1.0=0";
		return paramStr;
	}
	
	function constructParamPPTP()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=3";
		paramStr += "&pptpCfg_IPAddressType_1.1.1.1.0=" + get_checked_value(get_by_name("pptp_type"));
		paramStr += "&pptpCfg_ExternalIPAddress_1.1.1.1.0=" + get_by_id("pptp_ip").value;
		paramStr += "&pptpCfg_SubnetMask_1.1.1.1.0=" + get_by_id("pptp_mask").value;
		paramStr += "&pptpCfg_DefaultGateway_1.1.1.1.0=" + get_by_id("pptp_gw").value;
		paramStr += "&pptpConn_ServerIP_1.1.1.1.1=" + get_by_id("pptp_server_ip").value;
		paramStr += "&pptpConn_Username_1.1.1.1.1=" + urlencode(get_by_id("pptpuserid").value);
		paramStr += "&pptpConn_Password_1.1.1.1.1=" + urlencode(get_by_id("pptppwd").value);
		return paramStr;
	}
	
	function constructParamL2TP()
	{
		var paramStr = "";
		paramStr += "&wanConnDev_CurrentConnObjType_1.1.1.0.0=4";
		paramStr += "&l2tpCfg_IPAddressType_1.1.1.1.0=" + get_checked_value(get_by_name("l2tp_type"));
		paramStr += "&l2tpCfg_ExternalIPAddress_1.1.1.1.0=" + get_by_id("l2tp_ip").value;
		paramStr += "&l2tpCfg_SubnetMask_1.1.1.1.0=" + get_by_id("l2tp_mask").value;
		paramStr += "&l2tpCfg_DefaultGateway_1.1.1.1.0=" + get_by_id("l2tp_gw").value;
		paramStr += "&l2tpConn_ServerIP_1.1.1.1.1=" + get_by_id("l2tp_server_ip").value;
		paramStr += "&l2tpConn_Username_1.1.1.1.1=" + urlencode(get_by_id("l2tpuserid").value);
		paramStr += "&l2tpConn_Password_1.1.1.1.1=" + urlencode(get_by_id("l2tppwd").value);
		return paramStr;		
	}
	
	$(document).ready( function () {
		get_by_id("tzone").selectedIndex = gTimezoneIdx;
		/*
		var d = new Date();
		var tz = -d.getTimezoneOffset()/60
		for (var i=0; i<$('#tzone').get(0).options.length; i++)
		{
			if (i<$('#tzone').get(0).options.length-1) {		
				if (parseInt($('#tzone option').eq(i).val()) == tz*16) {
					get_by_id("tzone").selectedIndex = i;
					break;
				}
			} else {
					get_by_id("tzone").selectedIndex = i;
			}
		}
		*/
		switch(wanCfg.wanMode)
		{
			case "0":
				set_checked("static", get_by_name("wan_type"));
			break;
			
			case "1":
				set_checked("dhcpc", get_by_name("wan_type"));
			break;
			
			case "2":
				set_checked("pppoe", get_by_name("wan_type"));
			break;
			
			case "3":
				set_checked("pptp", get_by_name("wan_type"));
			break;
			
			case "4":
				set_checked("l2tp", get_by_name("wan_type"));
			break;
			
			case "9":
				set_checked("dhcpplus", get_by_name("wan_type"));
			break;
		}
		
		get_by_id("wan_mac").value = wanCfg.wanMac;
		get_by_id("host").value = wanCfg.wanDhcpHost; 
		get_by_id("dhcpplus_host").value = wanCfg.wanDhcpplusHost;
		get_by_id("dhcpplus_userid").value = wanCfg.wanDhcpplusUser;
		
		set_checked(wanCfg.wanPppoeType, get_by_name("pppoe_type"));
		get_by_id("pppoe_ip").value = wanCfg.wanPppoeAddr;
		get_by_id("pppoe_user_name").value = wanCfg.wanPppoeName;
		get_by_id("pppoe_service").value = wanCfg.wanPppoeServ;
		set_checked(wanCfg.wanPppoePlus, get_by_id("pppoe_plus_support"));
		
		set_checked(wanCfg.wanPPTPType, get_by_name("pptp_type"));
		get_by_id("pptp_ip").value = wanCfg.wanPPTPAddr;
		get_by_id("pptp_mask").value = wanCfg.wanPPTPMask;
		get_by_id("pptp_gw").value = wanCfg.wanPPTPGw;
		get_by_id("pptp_server_ip").value = wanCfg.wanPPTPServ;
		get_by_id("pptpuserid").value = wanCfg.wanPPTPName;
		//get_by_id("pptppwd").value = wanCfg.wanPPTPPass;		

		set_checked(wanCfg.wanL2TPType, get_by_name("l2tp_type"));
		get_by_id("l2tp_ip").value = wanCfg.wanL2TPAddr;
		get_by_id("l2tp_mask").value = wanCfg.wanL2TPMask;
		get_by_id("l2tp_gw").value = wanCfg.wanL2TPGw;
		get_by_id("l2tp_server_ip").value = wanCfg.wanL2TPServ;
		get_by_id("l2tpuserid").value = wanCfg.wanL2TPName;
		
		get_by_id("ip").value = wanCfg.wanStaticIp;
		get_by_id("mask").value = wanCfg.wanStaticSubnet;
		get_by_id("gateway").value = wanCfg.wanStaticGw;
		get_by_id("dns1").value = wanCfg.wanStaticDns.split(",")[0];
		
		if(wanCfg.wanStaticDns.split(",")[1])
			get_by_id("dns2").value = wanCfg.wanStaticDns.split(",")[1];
		else
			get_by_id("dns2").value = "0.0.0.0";
	});
	
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td bgcolor="#FFFFFF">
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
<div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <img src="wlan_masthead.gif" width="836" height="92" align="middle"> 
     </div>
   </div></td>
</tr>
</table>
</div></td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<p>&nbsp;</p>
	<table width="650" border="0" align="center">
	<tr>
		<td>
		<form id="formAll" name="formAll">
<!-------------------------------->
<!--     start of page main     -->
<!-------------------------------->
      	<div class=box id="p0" style="display:none"> 
            <h2 align="left">
				<script>show_words(wwa_title_wel)</script>
            </h2>
            <p class="box_msg">
                <script>show_words(wwa_intro_wel)</script>
            </p>
			<!--
        	<form id="form0" name="form0" method="post" action="apply.cgi">	
			-->
                <table class=formarea>
                    <tr>
                      <td width="334" height="81">
                        <UL>
                        <LI><script>show_words(wwa_title_s1)</script>
                        <LI><script>show_words(wwa_title_s2)</script>
                        <LI><script>show_words(wwa_title_s3)</script>
                        <LI><script>show_words(wwa_title_s4)</script>
                        </LI>
                      	</UL>
                      </TD>
                    </tr>
                </table>
                <table align="center" class="formarea">
                  <tr>
                    <td>
                    <fieldset id="wz_buttons">
					<input type="button" class="button_submit" id="wz_prev_b_p0" name="wz_prev_b_p0" value="" disabled>
					<input type="button" class="button_submit" id="next_b2_p0" name="next_b2_p0" value="" onClick="next_page();">
					<input type="button" class="button_submit" id="cancel_b2_p0" name="cancel_b2_p0" value="" onClick="wizard_cancel();">
					<input type="button" class="button_submit" id="wz_save_b_p0" name="wz_save_b_p0" value="" disabled>
					<script>get_by_id("wz_prev_b_p0").value = get_words('_prev');</script>
					<script>get_by_id("next_b2_p0").value = get_words('_next');</script>
					<script>get_by_id("cancel_b2_p0").value = get_words('_cancel');</script>
					<script>get_by_id("wz_save_b_p0").value = get_words('_connect');</script>
					  </fieldset>
                    </td>
                  </tr>
                </table>
            <!--</form>-->
        </div>
<!-------------------------------->
<!--     End of page main       -->
<!-------------------------------->

<!-------------------------------->
<!--     Start of page 1       -->
<!-------------------------------->
		<div class=box id="p1"> 
			<h2 align="left">
				<script>show_words(wwa_title_s1)</script>
			</h2>
			<p class="box_msg">
				<script>show_words(wwa_intro_s1)</script>
			</p>
			<!--
			<form id="form1" name="form1" method="post" action="apply.cgi">		
			-->
				<table class=formarea>
				<tr>
					<td align=right class="duple">
						<script>show_words(_password)</script>
					:</td>
					<td>&nbsp;
						<input type="password" id=pwd1 name=pwd1 size=20 maxlength=15 value='WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG'>
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(_verifypw)</script> 
					:</td>
					<td>&nbsp;
						<input type="password" id=pwd2 name=pwd2 size=20 maxlength=15 value='WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG'>
					</td>
				</tr>
				</table>
				<br>
				<table align="center" class="formarea">
				<tr>
					<td>
						<input type="button" class="button_submit" id="wz_prev_b_p1" name="wz_prev_b_p1" value="" onclick="prev_page();"> 
						<input type="button" class="button_submit" id="next_b_p1" name="next_b_p1" value="" onClick="next_page();"> 
						<input type="button" class="button_submit" id="cancel_b_p1" name="cancel_b_p1" value="" onclick="wizard_cancel();"> 
						<input type="button" class="button_submit" id="wz_save_b_p1" name="wz_save_b_p1" value="" disabled> 
						<script>get_by_id("wz_prev_b_p1").value = get_words('_prev');</script>
						<script>get_by_id("next_b_p1").value = get_words('_next');</script>
						<script>get_by_id("cancel_b_p1").value = get_words('_cancel');</script>
						<script>get_by_id("wz_save_b_p1").value = get_words('_connect');</script>
					</td>
				</tr>
				</table>
			<!--</form>-->
		</div>
<!-------------------------------->
<!--       End of page 1        -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 2       -->
<!-------------------------------->
		<div class=box id="p2"> 
			<h2 align="left">
				<script>show_words(wwa_title_s2)</script>
			</h2>
			<p class="box_msg"> 
				<script>show_words(wwa_intro_s2)</script>
			</p>
			<!--
			<form id="form2" name="form2" method="post" action="apply.cgi">		
			-->
				<P align="center">
				<select size=1 id="tzone" name="tzone">
					<option value="-192"><font face=Arial><script>show_words(up_tz_00)</script></font></option>
					<option value="-176"><font face=Arial><script>show_words(up_tz_01)</script></font></option>
					<option value="-160"><font face=Arial><script>show_words(up_tz_02)</script></font></option>
					<option value="-144"><font face=Arial><script>show_words(up_tz_03)</script></font></option>
					<option value="-128"><font face=Arial><script>show_words(up_tz_04)</script></font></option>
					<option value="-112"><font face=Arial><script>show_words(up_tz_05)</script></font></option>
					<option value="-112"><font face=Arial><script>show_words(up_tz_06)</script></font></option>
					<option value="-96"><font face=Arial><script>show_words(up_tz_07)</script></font></option>
					<option value="-96"><font face=Arial><script>show_words(up_tz_08)</script></font></option>
					<option value="-96"><font face=Arial><script>show_words(up_tz_09)</script></font></option>
					<option value="-96"><font face=Arial><script>show_words(up_tz_10)</script></font></option>
					<option value="-80"><font face=Arial><script>show_words(up_tz_11)</script></font></option>                  
					<option value="-80"><font face=Arial><script>show_words(up_tz_12)</script></font></option>
					<option value="-80"><font face=Arial><script>show_words(up_tz_13)</script></font></option>
					<option value="-64"><font face=Arial><script>show_words(up_tz_14)</script></font></option>
					<option value="-64"><font face=Arial><script>show_words(up_tz_15)</script></font></option>
					<option value="-64"><font face=Arial><script>show_words(up_tz_16)</script></font></option>
					<option value="-56"><font face=Arial><script>show_words(up_tz_17)</script></font></option>
					<option value="-48"><font face=Arial><script>show_words(up_tz_18)</script></font></option>
					<option value="-48"><font face=Arial><script>show_words(up_tz_19)</script></font></option>
					<option value="-48"><font face=Arial><script>show_words(up_tz_20)</script></font></option>
					<option value="-32"><font face=Arial><script>show_words(up_tz_21)</script></font></option>
					<option value="-16"><font face=Arial><script>show_words(up_tz_22)</script></font></option>
					<option value="-16"><font face=Arial><script>show_words(up_tz_23)</script></font></option>
					<option value="0"><font face=Arial><script>show_words(up_tz_24)</script></font></option>
					<option value="0"><font face=Arial><script>show_words(up_tz_25)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_26)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_27)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_28)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_29)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_29b)</script></font></option>
					<option value="16"><font face=Arial><script>show_words(up_tz_30)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_31)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_32)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_33)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_34)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_35)</script></font></option>
					<option value="32"><font face=Arial><script>show_words(up_tz_36)</script></font></option>
					<option value="48"><font face=Arial><script>show_words(up_tz_37)</script></font></option>
					<option value="48"><font face=Arial><script>show_words(up_tz_38)</script></font></option>
					<option value="48"><font face=Arial><script>show_words(up_tz_40)</script></font></option>
					<option value="48"><font face=Arial><script>show_words(up_tz_41)</script></font></option>
					<option value="64"><font face=Arial><script>show_words(up_tz_39)</script></font></option>
					<option value="64"><font face=Arial><script>show_words(up_tz_42)</script></font></option>
					<option value="64"><font face=Arial><script>show_words(up_tz_43)</script></font></option>
					<option value="72"><font face=Arial><script>show_words(up_tz_44)</script></font></option>
					<option value="80"><font face=Arial><script>show_words(up_tz_46)</script></font></option>
					<option value="88"><font face=Arial><script>show_words(up_tz_47)</script></font></option>
					<option value="92"><font face=Arial><script>show_words(up_tz_48)</script></font></option>
					<option value="96"><font face=Arial><script>show_words(up_tz_45)</script></font></option>
					<option value="96"><font face=Arial><script>show_words(up_tz_50)</script></font></option>
					<option value="96"><font face=Arial><script>show_words(up_tz_51)</script></font></option>
					<option value="96"><font face=Arial><script>show_words(up_tz_49)</script></font></option>
					<option value="104"><font face=Arial><script>show_words(up_tz_52)</script></font></option>
					<option value="112"><font face=Arial><script>show_words(up_tz_74)</script></font></option>
					<option value="112"><font face=Arial><script>show_words(up_tz_53)</script></font></option>
					<option value="128"><font face=Arial><script>show_words(up_tz_59)</script></font></option>
					<option value="128"><font face=Arial><script>show_words(up_tz_55)</script></font></option>
					<option value="128"><font face=Arial><script>show_words(up_tz_57)</script></font></option>
					<option value="128"><font face=Arial><script>show_words(up_tz_54)</script></font></option>
					<option value="128"><font face=Arial><script>show_words(up_tz_58)</script></font></option>
					<option value="144"><font face=Arial><script>show_words(up_tz_56)</script></font></option>
					<option value="144"><font face=Arial><script>show_words(up_tz_60)</script></font></option>
					<option value="144"><font face=Arial><script>show_words(up_tz_61)</script></font></option>
					<option value="152"><font face=Arial><script>show_words(up_tz_63)</script></font></option>
					<option value="152"><font face=Arial><script>show_words(up_tz_64)</script></font></option>
					<option value="160"><font face=Arial><script>show_words(up_tz_62)</script></font></option>
					<option value="160"><font face=Arial><script>show_words(up_tz_65)</script></font></option>
					<option value="160"><font face=Arial><script>show_words(up_tz_66)</script></font></option>
					<option value="160"><font face=Arial><script>show_words(up_tz_67)</script></font></option>
					<option value="160"><font face=Arial><script>show_words(up_tz_68)</script></font></option>
					<option value="176"><font face=Arial><script>show_words(up_tz_69)</script></font></option>
					<option value="176"><font face=Arial><script>show_words(up_tz_70)</script></font></option>
					<option value="192"><font face=Arial><script>show_words(up_tz_75)</script></font></option>
					<option value="192"><font face=Arial><script>show_words(up_tz_71)</script></font></option>
					<option value="192"><font face=Arial><script>show_words(up_tz_72)</script></font></option>
					<option value="208"><font face=Arial><script>show_words(up_tz_73)</script></font></option>
				</select>
				</p>
				<br>
				<table align="center" class="formarea">
				<tr>
					<td>
						<input type="button" class="button_submit" id="wz_prev_b_p2" name="wz_prev_b_p2" value="" onclick="prev_page();"> 
						<input type="button" class="button_submit" id="next_b_p2" name="next_b_p2" value="" onClick="next_page();"> 
						<input type="button" class="button_submit" id="cancel_b_p2" name="cancel_b_p2" value="" onclick="wizard_cancel();"> 
						<input type="button" class="button_submit" id="wz_save_b_p2" name="wz_save_b_p2" value="" disabled>
						<script>get_by_id("wz_prev_b_p2").value = get_words('_prev');</script>
						<script>get_by_id("next_b_p2").value = get_words('_next');</script>
						<script>get_by_id("cancel_b_p2").value = get_words('_cancel');</script>
						<script>get_by_id("wz_save_b_p2").value = get_words('_connect');</script>
					</td>
				</tr>
				</table>
			<!--</form>-->
		</div>
<!-------------------------------->
<!--       End of page 2        -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 3       -->
<!-------------------------------->
		<div class=box id="p3"> 
			<h2>
				<script>show_words(wwa_title_s3)</script>
			</h2>
			<div> 
				<p class="box_msg">
					<script>show_words(wwa_intro_s3)</script>
				</p>
				<select id="select_isp" name="select_isp" onChange="select_wan_type()">
					<option value="dhcpc"><script>show_words(wwa_selectisp_not)</script></option>
					<option value="dhcpc">Adelphia Power Link</option>
					<option value="static">ALLTEL DSL</option>
					<option value="static">ATAT DSL Service</option>
					<option value="static">Bell Sympatico</option>
					<option value="static">Bellsouth</option>
					<option value="dhcpc">Charter High-Speed</option>
					<option value="dhcpc">Comcast</option>
					<option value="static">Covad</option>
					<option value="dhcpc">Cox Communications</option>
					<option value="dhcpc">Earthlink Cable</option>
					<option value="static">Earthlink DSL</option>
					<option value="static">FrontierNet</option>
					<option value="dhcpc">Optimum Online</option>
					<option value="dhcpc">RCN</option>
					<option value="dhcpc">Road Runner</option>
					<option value="dhcpc">Rogers Yahoo!</option>
					<option value="static">SBC Yahoo! DSL</option>
					<option value="dhcpc">Shaw</option>
					<option value="static">Speakeasy</option>
					<option value="static">Sprint FastConnect</option>
					<option value="static">Telus</option>
					<option value="dhcpc">Time Warner Cable</option>
					<option value="static">US West / Qwest</option>
					<option value="static">Verizon Online DSL</option>
					<option value="static">XO Communications</option>
				</select>
			</div>
			
			<div> 
				<P align="left" class=box_msg>
					<script>show_words(wwa_msg_ispnot)</script>
				</P>
				<!--
				<form id="form3" name="form3" method="post" action="apply.cgi">
				-->
					<table class=formarea >
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="dhcpc" checked>
						<STRONG><script>show_words(_dhcpconn)</script></STRONG>
						<div class=itemhelp><script>show_words(wwa_msg_dhcp)</script></div></td>
					</tr>	
					<!--
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="dhcpplus">
						<STRONG><script>show_words(bwn_Mode_DHCPPLUS)</script></STRONG>
						<div class=itemhelp><script>show_words(wwa_msg_dhcpplus)</script></div></td>
					</tr>
					-->
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="pppoe">
						<STRONG><script>show_words(wwa_wanmode_pppoe)</script></STRONG>
						<div class=itemhelp><script>show_words(wwa_msg_pppoe)</script></div></td>
					</tr>
					
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="pptp">
						<STRONG><script>show_words(wwa_wanmode_pptp)</script></STRONG>
						<div class=itemhelp><script>show_words(wwa_msg_pptp)</script> </div></td>
					</tr>
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="l2tp">
						<STRONG><script>show_words(wwa_wanmode_l2tp)</script></STRONG>
						<div class=itemhelp><script>show_words(wwa_msg_l2tp)</script> </div></td>
					</tr>
					<!--
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="bigpond">
						<STRONG><script>show_words('wwa_wanmode_bigpond'))</script></STRONG>
						<div class=itemhelp><script>show_words('wwa_msg_bigpond)</script> </div></td>
					</tr>
					-->
					<tr>
						<td class=form_label>&nbsp;</td>
						<td><input name="wan_type" type="radio" value="static">
						<STRONG><script>show_words('wwa_wanmode_sipa')</script></STRONG>
						<div class=itemhelp><script>show_words('wwa_msg_sipa')</script></div></td>
					</tr>
					</table>
					
					<br>
					<table align="center" class="formarea">
					<tr>
						<td>
							<input type="button" class="button_submit" id="wz_prev_b_p3" name="wz_prev_b_p3" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p3" name="next_b_p3" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p3" name="cancel_b_p3" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="wz_save_b_p3" name="wz_save_b_p3" value="" disabled>
							<script>get_by_id("wz_prev_b_p3").value = get_words('_prev');</script>
							<script>get_by_id("next_b_p3").value = get_words('_next');</script>
							<script>get_by_id("cancel_b_p3").value = get_words('_cancel');</script>
							<script>get_by_id("wz_save_b_p3").value = get_words('_connect');</script>
						</td>
					</tr>
					</table>
				<!--</form>-->
			</div>
		</div>
<!-------------------------------->
<!--       End of page 3        -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4a      -->
<!-------------------------------->
		<div class=box id="p4a"> 
			<h2 align="left">
				<script>show_words(_dhcpconn)</script>
			</h2>
			<div align="left"> 
				<p class="box_msg">
					<script>show_words(wwa_msg_set_dhcp)</script>
				</p>
				<!--
				<form id="form4a" name="form4a" method="post" action="apply.cgi">
				-->
					<div>
						<table align="center" class=formarea>
						<tr>
							<td width="137" align=right class="duple">
								<script>show_words(_macaddr)</script>
								&nbsp;:
							</td>
							<td width="473">
								<input type="text" id="wan_mac" name="wan_mac" maxlength="17" size="20" value=''>
								<script>show_words(_optional)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td> 
								<input name="clone" type="button" class="button_submit" id="clone_1" value="" onClick='clone_mac_action("wan_mac");'>
								<script>get_by_id("clone_1").value = get_words('_clone');</script>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_hostname)</script>
								&nbsp;:
							</td>
							<td>
								<input type=text id=host name=host size="25" maxlength="39" value='dlinkrouter'>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="itemhelp"> 
								<script>show_words(wwa_note_hostname)</script>
							</td>
						</tr>
						<tr>
							<td class=form_label>&nbsp;
							</td>
							<td>
								<input type="button" class="button_submit" id="wz_prev_b_p4a" name="wz_prev_b_p4a" value="" onclick="prev_page();"> 
								<input type="button" class="button_submit" id="next_b_p4a" name="next_b_p4a" value="" onClick="next_page();"> 
								<input type="button" class="button_submit" id="cancel_b_p4a" name="cancel_b_p4a" value="" onclick="wizard_cancel();"> 
								<input type="button" class="button_submit" id="wz_save_b_p4a" name="wz_save_b_p4a" value="" disabled> 
								<script>get_by_id("wz_prev_b_p4a").value = get_words('_prev');</script>
								<script>get_by_id("next_b_p4a").value = get_words('_next');</script>
								<script>get_by_id("cancel_b_p4a").value = get_words('_cancel');</script>
								<script>get_by_id("wz_save_b_p4a").value = get_words('_connect');</script>
							</td>
						</tr>
						</table>
					</div>
				<!--</form>-->
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4a       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4b      -->
<!-------------------------------->
		<div class=box id="p4b"> 
			<h2 align="left">
				<script>show_words(wwa_set_sipa_title)</script>
			</h2>
			<div align="left"> 
				<p class="box_msg">
					<script>show_words(wwa_set_sipa_msg)</script>
				</p>
				<div>
				<!--
				<form id="form4b" name="form4b" method="post" action="apply.cgi">
				-->
					<table width="536" align="center" class=formarea>
					<tr>
						<td width="235" align=right class="duple">
							<script>show_words(_ipaddr)</script>
							&nbsp;:</td>
						<td width="468">
							<input type=text id=ip name=ip size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_subnet)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=mask name=mask size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple"> 
							<script>show_words(wwa_gw)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=gateway name=gateway size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(wwa_pdns)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=dns1 name=dns1 size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(wwa_sdns)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=dns2 name=dns2 size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>  
							<input type="button" class="button_submit" id="wz_prev_b_p4b" name="wz_prev_b_p4b" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p4b" name="next_b_p4b" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p4b" name="cancel_b_p4b" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="wz_save_b_p4b" name="wz_save_b_p4b" value="" disabled> 
							<script>get_by_id("wz_prev_b_p4b").value = get_words('_prev');</script>
							<script>get_by_id("next_b_p4b").value = get_words('_next');</script>
							<script>get_by_id("cancel_b_p4b").value = get_words('_cancel');</script>
							<script>get_by_id("wz_save_b_p4b").value = get_words('_connect');</script>
						</td>
					</tr>
					</table>
				<!--</form>-->
				</div>
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4b       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4c      -->
<!-------------------------------->
		<div class=box id="p4c"> 
			<h2 align="left">
				<script>show_words(wwa_title_set_pppoe)</script>
			</h2>
			<p class="box_msg">
				<script>show_words(wwa_msg_set_pppoe)</script>
			</p>
			<div>
				<!--
				<form id="form4c" name="form4c" method="post" action="apply.cgi">
				-->
					<table class=formarea >
					<tr>
						<td width="167" align=right class="duple">
							<script>show_words(bwn_AM)</script>
							&nbsp;:</td>
						<td width="443">
							<input name="pppoe_type" type="radio" value="0" onClick="show_static_ip('pppoe')" checked>
							<script>show_words(Dynamic_PPPoE)</script>
							&nbsp;&nbsp; 
							<input name="pppoe_type" type="radio" value="1" onClick="show_static_ip('pppoe')">
							<script>show_words(static_PPPoE)</script>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_ipaddr)</script>
							&nbsp;:</td>
						<td>
							<input name="pppoe_ip" type="text" id="pppoe_ip" size="20" maxlength="15" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_username)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=pppoe_user_name name=pppoe_user_name size="20" maxlength="63" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_password)</script>
							&nbsp;:</td>
						<td>
							<input type=password id=pppoe_pwd1 name=pppoe_pwd1 size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_verifypw)</script>
							&nbsp;:</td>
						<td>
							<input type=password id=pppoe_pwd2 name=pppoe_pwd2 size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_srvname)</script>
							&nbsp;:</td>
						<td>
							<input type=text id=pppoe_service name=pppoe_service size="20" maxlength="39" value=''>
							<script>show_words(_optional)</script>
						</td>
					</tr>
					<tr style="display:none">
						<td align=right class="duple">
							<script>show_words(pppoe_plus_dail)</script>
							&nbsp;:</td>
						<td>
							<input type=checkbox id=pppoe_plus_support name=pppoe_plus_support value="1">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="itemhelp"> 
							<script>show_words(wwa_note_svcn)</script>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input type="button" class="button_submit" id="wz_prev_b_p4c" name="wz_prev_b_p4c" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p4c" name="next_b_p4c" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p4c" name="cancel_b_p4c" value="" onclick="wizard_cancel();">
							<input type="button" class="button_submit" id="wz_save_b_p4c" name="wz_save_b_p4c" value="" disabled> 
							<script>get_by_id("wz_prev_b_p4c").value = get_words('_prev');</script>
							<script>get_by_id("next_b_p4c").value = get_words('_next');</script>
							<script>get_by_id("cancel_b_p4c").value = get_words('_cancel');</script>
							<script>get_by_id("wz_save_b_p4c").value = get_words('_connect');</script>
						</td>
					</tr>
					</table>
				<!--</form>-->
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4c       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4d      -->
<!-------------------------------->
		<div class=box id="p4d"> 
			<h2 align="left">
				<script>show_words(wwa_title_set_pptp)</script>
			</h2>
			<div align="left"> 
				<p class="box_msg">
					<script>show_words(wwa_msg_set_pptp)</script>
				</p>
				<!--
				<form id="form4d" name="form4d" method="post" action="apply.cgi">
				-->
					<div>
						<table width="525" align="center" class=formarea >
						<tr>
							<td width="220" align=right class="duple">
								<script>show_words(bwn_AM)</script>
								&nbsp;:</td>
							<td width="304">
								<input name="pptp_type" type="radio" value="0" onClick="show_static_ip('pptp')" checked>
								<script>show_words(carriertype_ct_0)</script>
								&nbsp; 
								<input name="pptp_type" type="radio" value="1" onClick="show_static_ip('pptp')">
								<script>show_words(_sdi_staticip)</script>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_PPTPip)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=pptp_ip name=pptp_ip size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_PPTPsubnet)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=pptp_mask name=pptp_mask size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_PPTPgw)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=pptp_gw name=pptp_gw size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(wwa_pptp_svraddr)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=pptp_server_ip name=pptp_server_ip size="20" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_username)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=pptpuserid name=pptpuserid size="20" maxlength="63" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_password)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=pptppwd name=pptppwd size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_verifypw)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=pptppwd2 name=pptppwd2 size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input type="button" class="button_submit" id="wz_prev_b_p4d" name="wz_prev_b_p4d" value="" onclick="prev_page();"> 
								<input type="button" class="button_submit" id="next_b_p4d" name="next_b_p4d" value="" onClick="next_page();"> 
								<input type="button" class="button_submit" id="cancel_b_p4d" name="cancel_b_p4d" value="" onclick="wizard_cancel();">
								<input type="button" class="button_submit" id="wz_save_b_p4d" name="wz_save_b_p4d" value="" disabled> 
								<script>get_by_id("wz_prev_b_p4d").value = get_words('_prev');</script>
								<script>get_by_id("next_b_p4d").value = get_words('_next');</script>
								<script>get_by_id("cancel_b_p4d").value = get_words('_cancel');</script>
								<script>get_by_id("wz_save_b_p4d").value = get_words('_connect');</script>
							</td>
						</tr>
						</table>
					</div>
				<!--</form>-->
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4d       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4e      -->
<!-------------------------------->
		<div class=box id="p4e"> 
			<h2 align="left">
				<script>show_words(wwa_set_l2tp_title)</script>
			</h2>
			<div align="left"> 
				<p class="box_msg">
					<script>show_words(wwa_set_l2tp_msg)</script>
				</p>
				
				<div>
					<!--
					<form id="form4e" name="form4e" method="post" action="apply.cgi">	
					-->
						<table width="536" align="center" class=formarea>
						<tr>
							<td width="235" align=right class="duple">
								<script>show_words(bwn_AM)</script>
								&nbsp;:</td>
							<td width="468">
								<input name="l2tp_type" type="radio" value="0" onClick="show_static_ip('l2tp')" checked>
								<script>show_words(carriertype_ct_0)</script>
								&nbsp;&nbsp; 
								<input name="l2tp_type" type="radio" value="1" onClick="show_static_ip('l2tp')">
								<script>show_words(_sdi_staticip)</script>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_L2TPip)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=l2tp_ip name=l2tp_ip size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_L2TPsubnet)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=l2tp_mask name=l2tp_mask size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_L2TPgw)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=l2tp_gw name=l2tp_gw size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(wwa_l2tp_svra)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=l2tp_server_ip name=l2tp_server_ip size="20" maxlength="15" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_username)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=l2tpuserid name=l2tpuserid size="20" maxlength="63" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_password)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=l2tppwd name=l2tppwd size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_verifypw)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=l2tppwd2 name=l2tppwd2 size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input type="button" class="button_submit" id="wz_prev_b_p4e" name="wz_prev_b_p4e" value="" onclick="prev_page();"> 
								<input type="button" class="button_submit" id="next_b_p4e" name="next_b_p4e" value="" onClick="next_page();"> 
								<input type="button" class="button_submit" id="cancel_b_p4e" name="cancel_b_p4e" value="" onclick="wizard_cancel();">
								<input type="button" class="button_submit" id="wz_save_b_p4e" name="wz_save_b_p4e" value="" disabled> 
								<script>get_by_id("wz_prev_b_p4e").value = get_words('_prev');</script>
								<script>get_by_id("next_b_p4e").value = get_words('_next');</script>
								<script>get_by_id("cancel_b_p4e").value = get_words('_cancel');</script>
								<script>get_by_id("wz_save_b_p4e").value = get_words('_connect');</script>
							</td>
						</tr>
						</table>
					<!--</form>-->
				</div>
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4e       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4f      -->
<!-------------------------------->
		<div class=box ID="p4f"> 
			<h2 align="left">
				<script>show_words(wwa_title_set_bigpond)</script>
			</h2>
			<p class="box_msg">
				<script>show_words(wwa_msg_set_bigpond)</script>
			</p>
			<!--
			<form id="form4f" name="form4f" method="post" action="apply.cgi">
			-->
				<table width="536" align="center" class=formarea >
				<tr>
					<td width="181" align=right class="duple">
						<script>show_words(_username)</script>
						&nbsp;:</td>
					<td width="339">
						<input name=bigpond_userid type=text id=bigpond_userid size=32 maxlength=63 value=''>
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(_password)</script>
						&nbsp;:</td>
					<td>
						<input type=password id=bigpond_pwd name=bigpond_pwd size=32 maxlength=64 value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(_verifypw)</script>
						&nbsp;:</td>
					<td>
						<input type=password id=bigpond_pwd2 name=bigpond_pwd2 size=32 maxlength=64 value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(bwn_BPS)</script>
						&nbsp;:</td>
					<td>
						<input type=text id=srv_name name=srv_name size=32 maxlength=15 value=''>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="button" class="button_submit" id="wz_prev_b_p4f" name="wz_prev_b_p4f" value="" onclick="prev_page();"> 
						<input type="button" class="button_submit" id="next_b_p4f" name="next_b_p4f" value="" onClick="next_page();"> 
						<input type="button" class="button_submit" id="cancel_b_p4f" name="cancel_b_p4f" value="" onclick="wizard_cancel();">
						<input type="button" class="button_submit" id="wz_save_b_p4f" name="wz_save_b_p4f" value="" disabled> 
						<script>get_by_id("wz_prev_b_p4f").value = get_words('_prev');</script>
						<script>get_by_id("next_b_p4f").value = get_words('_next');</script>
						<script>get_by_id("cancel_b_p4f").value = get_words('_cancel');</script>
						<script>get_by_id("wz_save_b_p4f").value = get_words('_connect');</script>
					</td>
				</tr>
				</table>
			<!--</form>-->
		</div>
<!-------------------------------->
<!--       End of page 4f       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 4g      -->
<!-------------------------------->
		<div class=box id="p4g"> 
			<h2 align="left">
				<script>show_words(_dhcpconn)</script>
			</h2>
			<div align="left"> 
				<p class="box_msg">
					<script>show_words(wwa_msg_set_dhcp)</script>
				</p>
				<!--
				<form id="form4a" name="form4a" method="post" action="apply.cgi">
				-->
					<div>
						<table align="center" class=formarea>
						<tr>
							<td width="137" align=right class="duple">
								<script>show_words(_macaddr)</script>
								&nbsp;:
							</td>
							<td width="473">
								<input type="text" id="dhcpplus_wan_mac" name="dhcpplus_wan_mac" maxlength="17" size="20" value=''>
								<script>show_words(_optional)</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td> 
								<input name="clone" type="button" class="button_submit" id="clone_2" value="" onClick='clone_mac_action("dhcpplus_wan_mac");'>
								<script>get_by_id("clone_2").value = get_words('_clone');</script>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_hostname)</script>
								&nbsp;:
							</td>
							<td>
								<input type=text id=dhcpplus_host name=dhcpplus_host size="25" maxlength="39" value='dlinkrouter'>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_username)</script>
								&nbsp;:</td>
							<td>
								<input type=text id=dhcpplus_userid name=dhcpplus_userid size="20" maxlength="63" value=''>
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_password)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=dhcpplus_pwd name=dhcpplus_pwd size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td align=right class="duple">
								<script>show_words(_verifypw)</script>
								&nbsp;:</td>
							<td>
								<input type=password id=dhcpplus_pwd2 name=dhcpplus_pwd2 size="20" maxlength="64" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyGWDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
							</td>
						</tr>
						<tr>
							<td colspan="2" class="itemhelp"> 
								<script>show_words(wwa_note_hostname)</script>
							</td>
						</tr>
						<tr>
							<td class=form_label>&nbsp;
							</td>
							<td>
								<input type="button" class="button_submit" id="wz_prev_b_p4g" name="wz_prev_b_p4g" value="" onclick="prev_page();"> 
								<input type="button" class="button_submit" id="next_b_p4g" name="next_b_p4g" value="" onClick="next_page();"> 
								<input type="button" class="button_submit" id="cancel_b_p4g" name="cancel_b_p4g" value="" onclick="wizard_cancel();"> 
								<input type="button" class="button_submit" id="wz_save_b_p4g" name="wz_save_b_p4g" value="" disabled> 
								<script>get_by_id("wz_prev_b_p4g").value = get_words('_prev');</script>
								<script>get_by_id("next_b_p4g").value = get_words('_next');</script>
								<script>get_by_id("cancel_b_p4g").value = get_words('_cancel');</script>
								<script>get_by_id("wz_save_b_p4g").value = get_words('_connect');</script>
							</td>
						</tr>
						</table>
					</div>
				<!--</form>-->
			</div>
		</div>
<!-------------------------------->
<!--       End of page 4g       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 5       -->
<!-------------------------------->
		<div class=box id="p5"> 
			<h2 align="left">
				<script>show_words(_setupdone)</script>
			</h2>
			<div align="left">
				<div> 
					<P align="left" class=box_msg>
						<script>show_words(wwa_intro_s4)</script>
					</P>
						<table align="center" class=formarea >
						<tr>
							<td></td>
							<td>    
								<input type="button" class="button_submit" id="prev_b_p5" name="prev_b_p5" value="" onclick="prev_page();"> 
								<input type="button" class="button_submit" id="next_b_p5" name="next_b_p5" value="" disabled> 
								<input type="button" class="button_submit" id="cancel_b_p5" name="cancel_b_p5" value="" onclick="wizard_cancel();"> 
								<input type="button" class="button_submit" id="wz_save_b_p5" name="wz_save_b_p5" value="" onClick="return send_request()">

								<script>get_by_id("prev_b_p5").value = get_words('_prev');</script>
								<script>get_by_id("next_b_p5").value = get_words('_next');</script>
								<script>get_by_id("cancel_b_p5").value = get_words('_cancel');</script>
								<script>get_by_id("wz_save_b_p5").value = get_words('_connect');</script>
							</td>
						</tr>
						</table>
						<div align="center"></div>
					<!--</form>-->
				</div>
			</div>
		</div>
<!-------------------------------->
<!--       End of page 5        -->
<!-------------------------------->
	  </form>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
  </td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	onPageLoad();
	set_form_default_values("formAll");
	displayPage("p0");
</script>
</html>
