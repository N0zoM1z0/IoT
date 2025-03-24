<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
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

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	var cli_mac 	= dev_info.cli_mac;
	var wan_mac		= mac_format(dev_info.wan_mac);
		
	document.title = get_words('TEXT000');
	//var lanHostIp 	= dev_info.lan_ip;
	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=8";
	param.arg +="&oid_1=IGD_&inst_1=10000";
	param.arg +="&oid_2=IGD_WANDevice_i_WANConnectionDevice_i_&inst_2=11100";
	param.arg +="&oid_3=IGD_WANDevice_i_WANConnectionDevice_i_DHCP_i_&inst_3=11110";
	param.arg +="&oid_4=IGD_LANDevice_i_LANHostConfigManagement_&inst_4=11100";
	param.arg +="&oid_5=IGD_WANDevice_i_TrafficControl_&inst_5=11100";
	param.arg +="&oid_6=IGD_Firewall_&inst_6=11000";
	param.arg +="&oid_7=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_7=11100";
	param.arg +="&oid_8=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_PPPoE_i_&inst_8=11110";	
	get_config_obj(param);
	
	var ipv6_wan_proto = config_val("wanIPv6ConnDev_CurrentConnObjType_");
	var ipv6_pppoe_share = config_val("ipv6PPPoEConn_SessionType_"); 
	var hw_nat_enable = config_val("wanConnDev_HardwareNatEnable_");
	var spi_enable = config_val("firewallSetting_SPIEnable_");
	var trafficshap_enable = config_val('wanTrafficShp_EnableTrafficShaping_');
	var adv_dns_en = config_val('dhcpCfg_AdvancedDNSEnable_');
	
	var lanCfg = {
		'lanIp':			config_val('lanHostCfg_IPAddress_'),
		'lanAPIp':			config_val('lanHostCfg_APIPAddress_')
	};	

	var dynamicIPDNS = config_val("dhcpCfg_DNSServers_").split(",");
	var devMode = (config_val("igd_DeviceMode_")? config_val("igd_DeviceMode_"):"0");
	var devLanIP = "";

    var submit_button_flag = 0;

    function opendns_enable_selector(value)
    {
        if (value == true) {
            get_by_id("wan_specify_dns").value ="1";
            get_by_id("wan_primary_dns").value ="204.194.232.200";
            get_by_id("wan_secondary_dns").value="204.194.234.200";
            get_by_id("wan_primary_dns").disabled = true;
            get_by_id("wan_secondary_dns").disabled = true;
        }
        else {
            get_by_id("wan_specify_dns").value ="0";
            get_by_id("wan_primary_dns").disabled = false;
            get_by_id("wan_secondary_dns").disabled = false;
            get_by_id("wan_primary_dns").value = "0.0.0.0";
            get_by_id("wan_secondary_dns").value =  "0.0.0.0";
        }
    }

function onPageLoad(){
	set_checked(devMode, get_by_name("dev_mode"))

	get_by_id("asp_temp_52").value = config_val("wanConnDev_CurrentConnObjType_"); 

	set_checked(config_val("dhcpCfg_UnicastUsed_"), get_by_id("dhcpc_use_ucast_sel"));
	set_checked(hw_nat_enable, get_by_id('HW_NAT_Enable'));
	set_checked(adv_dns_en, get_by_id('opendns_enable_sel'));
	if (adv_dns_en == '1') {
		opendns_enable_selector(true);
	}
	
	get_by_id("hostname").value = config_val("dhcpCfg_Name_");
	get_by_id("wan_primary_dns").value = dynamicIPDNS[0];
	if(dynamicIPDNS[1])
		get_by_id("wan_secondary_dns").value = dynamicIPDNS[1];
	else
		get_by_id("wan_secondary_dns").value = "0.0.0.0";
		
	get_by_id("wan_mtu").value = config_val("dhcpCfg_MaxMTUSize_");
	
	get_by_id("wan_mac").value = config_val("wanConnDev_MACAddress_");
	get_by_id("wanConnDev_MACAddressOverride_1.1.1.0.0").value = config_val("wanConnDev_MACAddressOverride_");

	set_form_default_values("form1");
	var login_who= login_Info;
	if(login_who!= "w"){
		DisableEnableForm(form1,true);	
	}
	else
	{
		changeDeviceMode();
	}
}

function clone_mac_action(){
	get_by_id("wan_mac").value = cli_mac;
	get_by_id("wanConnDev_MACAddressOverride_1.1.1.0.0").value = "1";
}

    function send_dhcp_request()
    {
			if (ipv6_wan_proto == "3" && ipv6_pppoe_share == "0"){
			alert(which_lang[IPV6_TEXT161a]);
			return false;
		}
		
		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
		var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(get_words('_ask_nochange'))) {
            return false;
        }
		
		//add by Vic for check hw nat enable
		if(!check_hw_nat_enable())
			return false;

        var dns1 = get_by_id("wan_primary_dns").value;
        var dns2 = get_by_id("wan_secondary_dns").value;
        var mtu = get_by_id("wan_mtu").value;
        var c_hostname=get_by_id("hostname").value;

	    var dns1_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_pdns'));
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,get_words('wwa_sdns'));
		var mtu_msg = replace_msg(check_num_msg, get_words('bwn_MTU'), 1300, 1500);

        var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
        var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
        var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1500, false);

		if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/") || _isNumeric(c_hostname)){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false;
		}
		
		//Tina Tsao add 2009/10/28
		//Check Host name cannot entry  ~!@#$%^&*()_+}{[]\|"?></-
		var re = /[^A-Za-z0-9_\-]/;
		if(re.test(c_hostname)){
			alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
			return false;
		}
		//Tina Tsao add 2009/11/19
		//Host name cannot empty
		var data_tmp;
		for (var i = 0; i < c_hostname.length; i++){ 
        	data_tmp = c_hostname.substring(i,i+1); 
            if(data_tmp == " "){ 
				alert(get_words('GW_DHCP_CLIENT_CLIENT_NAME_INVALID'));
				return false;
			}
         } 
		
		/*
		 * Validate MAC and activate cloning if necessary
		 */		
		var clonemac = get_by_id("wan_mac").value; 
		if (!check_mac_00(clonemac)){
			//alert(msg[MAC_ADDRESS_ERROR]);
			alert(get_words('KR3'));
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			//alert ("Invalid MAC address:" + mac + ".");
			alert (get_words('KR3')+":" + mac + ".");
			return false;
		}else{
			get_by_id("wan_mac").value = mac;
		}

	    if (dns1 != "" && dns1 != "0.0.0.0"){
    		if (!check_address(temp_dns1_obj)){
    			return false;
    		}
    	}
    	
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2_obj)){
    			return false;
    		}
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
		
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		if($("#wan_mac").val() == "00:00:00:00:00:00")
			$("#wan_mac").val(wan_mac);
		else
			$("#wan_mac").val(mac);
    	
    	get_by_id("dhcpc_use_ucast").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			copyDataToDataModelFormat();
			
			if(devMode != get_checked_value(get_by_name("dev_mode")))
			{
				//alert(translateFormObjToAJAXArg("form2"));
				var paramSubmit = {
					url: "get_set.ccp",
					arg: "ccp_act=set" + translateFormObjToAJAXArg("form2")
				};
				
				ajax_submit(paramSubmit);
				window.location.href = "back.asp?event=devModeChange&new_ip="+devLanIP;
				return true;
			}
			send_submit("form2");
			return true;
		}else{
			return false;
		}
	}
	
	function copyDataToDataModelFormat()
	{
		get_by_id("dhcpCfg_Name_1.1.1.1.0").value = get_by_id("hostname").value;
		get_by_id("dhcpplusCfg_Name_1.1.1.1.0").value = get_by_id("hostname").value;
		get_by_id("adminCfg_SystemName_1.1.0.0.0").value = get_by_id("hostname").value;

		get_by_id("dhcpCfg_UnicastUsed_1.1.1.1.0").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
		get_by_id("dhcpCfg_DNSServers_1.1.1.1.0").value = get_by_id("wan_primary_dns").value;
		if(get_by_id("wan_secondary_dns").value != "")
			get_by_id("dhcpCfg_DNSServers_1.1.1.1.0").value += ","+get_by_id("wan_secondary_dns").value;
			
		get_by_id("dhcpCfg_MaxMTUSize_1.1.1.1.0").value = get_by_id("wan_mtu").value;

		if(get_by_id("wanConnDev_MACAddressOverride_1.1.1.0.0").value == "0")
		{
			if(get_by_id("wanConnDev_MACAddress_1.1.1.0.0").value != get_by_id("wan_mac").value)
				get_by_id("wanConnDev_MACAddressOverride_1.1.1.0.0").value = "1";
		}
		
		if(get_by_id("wanConnDev_MACAddressOverride_1.1.1.0.0").value == "1")
			get_by_id("wanConnDev_MACAddress_1.1.1.0.0").value = get_by_id("wan_mac").value;
			
		get_by_id("igd_DeviceMode_1.0.0.0.0").value = get_checked_value(get_by_name("dev_mode"));
		
		get_by_id("dhcpCfg_AdvancedDNSEnable_1.1.1.1.0").value = get_checked_value(get_by_id("opendns_enable_sel"));
		var hw_nat_enable = get_checked_value(get_by_id('HW_NAT_Enable'));
		if(hw_nat_enable)
		{
			spi_enable = "0";
			trafficshap_enable = "0";
		}
		
		get_by_id("wanConnDev_HardwareNatEnable_1.1.1.0.0").value = hw_nat_enable;
		get_by_id("firewallSetting_SPIEnable_1.1.0.0.0").value = spi_enable;
		get_by_id("wanTrafficShp_EnableTrafficShaping_1.1.1.0.0").value = trafficshap_enable;
	}
	
	function reload_page()
	{
		if (is_form_modified("form1") && confirm (get_words('up_fm_dc_1'))) {
			onPageLoad();
		}
	}
	
	function changeDeviceMode()
	{
		switch(get_checked_value(get_by_name("dev_mode")))
		{
			case "0":
				get_by_id("wan_proto").disabled = false;	
				disableDiv("show_dhcp", false);
				devLanIP = lanCfg.lanIp;
			break;
			
			case "1":
				get_by_id("wan_proto").disabled = true;
				disableDiv("show_dhcp", true);
				devLanIP = lanCfg.lanAPIp;
			break;
		}
	}
	
	function ajax_submit(p)
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	p.url,
			data: 	p.arg+"&"+time+"="+time
		};

		$.ajax(ajax_param);
	}

</script>
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
        <td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
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
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td id="sidenav_container">
                            <div id="sidenav">
                                <ul>
									<li><div id="sidenavoff"><script>show_words(sa_Internet)</script></div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
									<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
									<li><div id="sidenavon"><a href="storage_setup.asp" onclick="return jump_if();"><script>show_words(storage)</script></a></div></li>
									<li><div id="sidenavon"><a href="setup_ipv6.asp" onclick="return jump_if();"><script>show_words(IPV6_TEXT137)</script></a></div></li>
									<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
								</ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
				<form id="form2" name="form2" method="post" action="get_set.ccp">
					<input type="hidden" name="ccp_act" value="set">
					<input type="hidden" name="ccpSubEvent" value="CCP_SUB_WAN">
					<input type="hidden" name="nextPage" value="sel_wan.asp">
					<input type="hidden" name="igd_DeviceMode_1.0.0.0.0" id="igd_DeviceMode_1.0.0.0.0" value="">
					<input type="hidden" name="wanConnDev_CurrentConnObjType_1.1.1.0.0" id="wanConnDev_CurrentConnObjType_1.1.1.0.0" value="1">
					<input type="hidden" name="wanConnDev_MACAddress_1.1.1.0.0" id="wanConnDev_MACAddress_1.1.1.0.0" value="">
					<input type="hidden" name="wanConnDev_MACAddressOverride_1.1.1.0.0" id="wanConnDev_MACAddressOverride_1.1.1.0.0" value="">
					<input type="hidden" name="dhcpCfg_Name_1.1.1.1.0" id="dhcpCfg_Name_1.1.1.1.0" value="">
					<input type="hidden" name="dhcpCfg_AdvancedDNSEnable_1.1.1.1.0" id="dhcpCfg_AdvancedDNSEnable_1.1.1.1.0" value="0">
					<input type="hidden" name="dhcpCfg_UnicastUsed_1.1.1.1.0" id="dhcpCfg_UnicastUsed_1.1.1.1.0" value="">
					<input type="hidden" name="dhcpCfg_DNSEnabled_1.1.1.1.0" id="dhcpCfg_DNSEnabled_1.1.1.1.0" value="1">
					<input type="hidden" name="dhcpCfg_DNSServers_1.1.1.1.0" id="dhcpCfg_DNSServers_1.1.1.1.0" value="">
					<input type="hidden" name="dhcpCfg_MaxMTUSize_1.1.1.1.0" id="dhcpCfg_MaxMTUSize_1.1.1.1.0" value="">
					<input type="hidden" name="dhcpplusCfg_Name_1.1.1.1.0" id="dhcpplusCfg_Name_1.1.1.1.0" value="">
					<input type="hidden" id="adminCfg_SystemName_1.1.0.0.0" name="adminCfg_SystemName_1.1.0.0.0" value="">
					
					<input type="hidden" id="wanConnDev_HardwareNatEnable_1.1.1.0.0" name="wanConnDev_HardwareNatEnable_1.1.1.0.0" value="">
					<input type="hidden" id="firewallSetting_SPIEnable_1.1.0.0.0" name="firewallSetting_SPIEnable_1.1.0.0.0" value="">
					<input type="hidden" id="wanTrafficShp_EnableTrafficShaping_1.1.1.0.0" name="wanTrafficShp_EnableTrafficShaping_1.1.1.0.0" value="">
					
					<span id="forAPMode"></span>
				</form>

                <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
                <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_dhcp.asp">

				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value='<% CmoGetStatus("mac_clone_addr"); %>'>			
				<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value='<% CmoGetCfg("wan_specify_dns","none"); %>'>
				<input type="hidden" id="dhcpc_use_ucast" name="dhcpc_use_ucast" value='<% CmoGetCfg("dhcpc_use_ucast","none"); %>'>
                <input type="hidden" id="classless_static_route" name="classless_static_route" value='<% CmoGetCfg("classless_static_route","none"); %>'>

				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value='<% CmoGetCfg("asp_temp_51","none"); %>'>
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value='<% CmoGetCfg("wan_proto","none"); %>'>
                <input type="hidden" id="reboot_type" name="reboot_type" value="shutdown">
                <input type="hidden" id="opendns_enable" name="opendns_enable" value='<% CmoGetCfg("opendns_enable","none"); %>'>
                <input type="hidden" id="dns_relay" name="dns_relay" value='<% CmoGetCfg("dns_relay","none"); %>'>

            <td valign="top" id="maincontent_container">
                <div id="maincontent">

              <div id=box_header>
                <h1><script>show_words(_WAN)</script></h1>

             <p>
              <script>show_words(bwn_intro_ICS_v6)</script>
            </p>

            <p><strong><b>
              <script>show_words(_note)</script>
              </b>:&nbsp;</strong>
              <script>show_words(bwn_note_clientSW)</script>
            </p>

            <input name="button" id="button" type="button" class=button_submit value="" onClick="return send_dhcp_request()">
            <input name="button2" id="button2" type="button" class=button_submit value="" onclick="reload_page();">
            <script>get_by_id("button").value = get_words('_savesettings');</script>
			<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
              </div>
              <br>
              <div class=box>
                <h2><script>show_words(bwn_ict)</script></h2>
                <p class="box_msg"><script>show_words(bwn_msg_Modes)</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="185" class="duple"><script>show_words(bwn_mici)</script> :</td>
                      <td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
                    	<option value="0"><script>show_words(_sdi_staticip)</script></option>
                        <option value="1" selected><script>show_words(bwn_Mode_DHCP)</script></option>
                        <option value="2"><script>show_words(bwn_Mode_PPPoE)</script></option>
                        <option value="3"><script>show_words(bwn_Mode_PPTP)</script></option>
                        <option value="4"><script>show_words(bwn_Mode_L2TP)</script></option>
			   <option value="10"><script>show_words(IPV6_TEXT140)</script></option>
                        <!--option value="bigpond">BigPond (Australia)</option-->
                      </select></td>
                    </tr>
                </table>
              </div>
              <div class=box>
                <h2><script>show_words(_title_AdvDns);</script></h2>
                <p class="box_msg"><script>show_words(_desc_AdvDns);</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                <tr>
                <td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(_en_AdvDns);</script> :</td>
                <td width="331">&nbsp;<input type="checkbox" id="opendns_enable_sel" name="opendns_enable_sel" value="1" onclick="opendns_enable_selector(this.checked);"></td>
                </tr>
                </table>
              </div>
			  <div class=box>
				<h2><script>show_words(HW_NAT_desc);</script></h2>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="185" align=right class="duple"><script>show_words('HW_NAT_enable');</script>:
					</td>
					<td width="331">&nbsp;
						<input type="checkbox" id="HW_NAT_Enable" name="HW_NAT_Enable" value="1">
					</td>
				</tr>
				</table>
			  </div>
              <div class=box id=show_dhcp>
                <h2><script>show_words(bwn_DIAICT)</script></h2>
                <p class="box_msg"><script>show_words(bwn_msg_DHCPDesc)</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>

                <td width="185" align=right class="duple">
                  <script>show_words(_hostname)</script>
                  :</td>
                      <td width="331">&nbsp;
                          <input type=text id="hostname" name="hostname" size="25" maxlength="39" value='<% CmoGetCfg("hostname","none"); %>'>
                      </td>
                    </tr>
                    <tr>

                <td align=right class="duple">
                  <script>show_words(_use_unicasting)</script>
                  :</td>
                      <td>&nbsp;
                          <input type="checkbox" id="dhcpc_use_ucast_sel" name="dhcpc_use_ucast_sel" value="1">
                  <script>show_words(bw_WDUU_note)</script>
                      </td>
                    </tr>
                    <tr>

                <td align=right class="duple">
                  <script>show_words(_dns1)</script>
                  :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value='<% CmoGetCfg("wan_primary_dns","none"); %>'>
                      </td>
                    </tr>
                    <tr>

                <td align=right class="duple">
                  <script>show_words(_dns2)</script>
                  :</td>
                      <td>&nbsp;
                        <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value='<% CmoGetCfg("wan_secondary_dns","none"); %>'>
                      </td>
                    </tr>
                    <tr>

                <td align=right class="duple">
                  <script>show_words(bwn_MTU)</script>
                  :</td>
                      <td>&nbsp;
                          <input type=text id="wan_mtu" name="wan_mtu" size="10" maxlength="5" value='<% CmoGetCfg("wan_mtu","none"); %>'>
                  <script>show_words(bwn_bytes)</script>
                  <script>show_words(_308)</script>
                  1500</td>
                    </tr>
                    <tr>

                <td align=right valign=top class="duple">
                  <script>show_words(_macaddr)</script>
                  :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value='<% CmoGetCfg("wan_mac","none"); %>'><br>
                        &nbsp;<input name="clone" id="clone" type=button class=button_submit value="" onClick="clone_mac_action()">
			      <script>get_by_id("clone").value = get_words('_clone');</script></td>
                      </td>
                    </tr>
                </table>
              </div>
            </div>
            </form>
           </td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong> <p>
              			<script>show_words(LW35)</script> </p>

            <p><script>show_words(LW36)</script></p>
            <!--IFDEF	OPENDNS-->
            <p><script>show_words(_sp_desc2_AdvDNS)</script></p>
			<p><script>show_words(_sp_desc3_AdvDNS)</script></p>
			<p><script>show_words(_sp_desc4_AdvDNS)</script></p>
			<!--END	OPENDNS-->
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
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
	onPageLoad();
</script>
</html>
