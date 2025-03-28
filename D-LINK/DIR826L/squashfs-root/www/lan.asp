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
	
	document.title = get_words('TEXT000');
	
	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=12";
	param.arg +="&oid_1=IGD_&inst_1=10000";
	param.arg +="&oid_2=IGD_LANDevice_i_LANHostConfigManagement_&inst_2=11100";
	param.arg +="&oid_3=IGD_LANDevice_i_LANHostConfigManagement_DHCPStaticAddress_i_&inst_3=11100";
	param.arg +="&oid_4=IGD_LANDevice_i_LANHostConfigManagement_DHCPDynamicAddress_i_&inst_4=11100";
	param.arg +="&oid_5=IGD_Status_WANStatus_&inst_5=11100";
	param.arg +="&oid_6=IGD_Status_LANStatus_Host_i_&inst_6=11110";
	param.arg +="&oid_7=IGD_WANDevice_i_WANConnectionDevice_i_StaticIP_i_&inst_7=11110";
	param.arg +="&oid_8=IGD_WANDevice_i_WANConnectionDevice_i_DHCP_i_&inst_8=11110";
	param.arg +="&oid_9=IGD_WANDevice_i_WANConnectionDevice_i_PPPoE_i_&inst_9=11110";
	param.arg +="&oid_10=IGD_WANDevice_i_WANConnectionDevice_i_PPTP_i_&inst_10=11110";
	param.arg +="&oid_11=IGD_WANDevice_i_WANConnectionDevice_i_L2TP_i_&inst_11=11110";
	param.arg +="&oid_12=IGD_WANDevice_i_WANConnectionDevice_i_&inst_12=11100";

	get_config_obj(param);

	var advdns = {	//20120111 silvia add for Enable DNS Relay
		'static':	config_val('staticIPCfg_AdvancedDNSEnable_'),
		'dhcp':		config_val('dhcpCfg_AdvancedDNSEnable_'),
		'pppoe':	config_val('pppoeCfg_AdvancedDNSEnable_'),
		'pptp':		config_val('pptpCfg_AdvancedDNSEnable_'),
		'l2tp':		config_val('l2tpCfg_AdvancedDNSEnable_')
	}
	var CurrentType = config_val('wanConnDev_CurrentConnObjType_');

	var lanCfg = {
		'lanIp':			config_val('lanHostCfg_IPAddress_'),
		'lanSubnet':		config_val('lanHostCfg_SubnetMask_'),
		'lanDomain':		config_val('lanHostCfg_DomainName_'),
		'lanDeviceName':	config_val('lanHostCfg_DeviceName_'),
		'lanDnsRelay':		config_val('lanHostCfg_DNSRelay_'),
		'lanDhcp':			config_val('lanHostCfg_DHCPServerEnable_'),
		'lanMinAddr':		config_val('lanHostCfg_MinAddress_'),
		'lanMaxAddr':		config_val('lanHostCfg_MaxAddress_'),
		'lanDhcpLease':		config_val('lanHostCfg_DHCPLeaseTime_'),
		'lanAntiARP':		config_val('lanHostCfg_AntiARPAttack_'),
		'lanAPIp':			config_val('lanHostCfg_APIPAddress_'),
		'lanAPSubnet':		config_val('lanHostCfg_APSubnetMask_'),
		'lanAPGateway':		config_val('lanHostCfg_APGateway_'),
		'lanAPDeviceName':	config_val('lanHostCfg_APDeviceName_'),
		'lanAPDNS1':		config_val('lanHostCfg_APPrimaryDNSAddress_'),
		'lanAPDNS2':		config_val('lanHostCfg_APSecondaryDNSAddress_'),
		'dhcpBroadcast':	config_val('lanHostCfg_AlwaysBroadcast_'),
		'netBIOSAnnounce':	config_val('lanHostCfg_NetBIOSAnnouncement_'),
		'netBIOSLearn':		config_val('lanHostCfg_NetBIOSLearn_'),
		'netBIOSScope':		config_val('lanHostCfg_NetBIOSScope_'),
		'netBIOSNodeType':	config_val('lanHostCfg_NetBIOSNodeType_'),
		'primaryWINS':		config_val('lanHostCfg_PrimaryWINSAddress_'),
		'secondaryWINS':	config_val('lanHostCfg_SecondaryWINSAddress_')
	};	
	
	var dev_mode = config_val("igd_DeviceMode_");
	
	var reservedHost = {
		'enable':			config_str_multi("reserveDHCP_Enable_"),
		'name':				config_str_multi("reserveDHCP_HostName_"),
		'ipaddr':			config_str_multi("reserveDHCP_Yiaddr_"),
		'mac':				config_str_multi("reserveDHCP_Chaddr_")
	};

	var reserveCnt 	= 0;
	if(reservedHost.name != null)
		reserveCnt = reservedHost.name.length;
		
	//var array_rules_inst 		= config_inst_multi("IGD_LANDevice_i_LANHostConfigManagement_DHCPStaticAddress_i_");

	var lanHostInfo = {
		'name':				config_val("igdLanHostStatus_HostName_").split("/"),
		'ipaddr':			config_val("igdLanHostStatus_HostIPv4Address_").split("/"),
		'mac':				config_val("igdLanHostStatus_HostMACAddress_").split("/"),
		'type':				config_val("igdLanHostStatus_HostAddressType_").split("/"),
		'expire':			config_val("igdLanHostStatus_HostExpireTime_").split("/")
	};
	
	var wanCfg = {
		'proto':		config_val("igdWanStatus_WanProto_"),
		'networkSt':	config_val("igdWanStatus_NetworkStatus_"),
		'ipaddr':		config_val("igdWanStatus_IPAddress_")
	};	
	
    var submit_button_flag = 0;
    var rule_max_num = 25;
    var resert_rule = rule_max_num;
    var DataArray = new Array();		//reserved host
    var DHCPL_DataArray = new Array();	//lan host

	//20120111 silvia add
	function chk_DNSrelay(val)
	{
		switch(val){
			case '0' :
				set_checked(advdns.static, get_by_id("DNSrelay"));
				break;
			case '1' :
				set_checked(advdns.dhcp, get_by_id("DNSrelay"));
				break;
			case '2' :
				set_checked(advdns.pppoe, get_by_id("DNSrelay"));
				break;
			case '3' :
				set_checked(advdns.pptp, get_by_id("DNSrelay"));
				break;
			case '4' :
				set_checked(advdns.l2tp, get_by_id("DNSrelay"));
				break;
			 default:
				break;
		}
		if (get_by_id("DNSrelay").checked)
		{
			get_by_id("DNSrelay").disabled = true;
			return true;
		}else{
			return false;
		}
	}

	function onPageLoad()
	{
		if(!chk_DNSrelay(CurrentType))
			set_checked(lanCfg.lanDnsRelay, get_by_id("DNSrelay"));

		set_checked(lanCfg.lanDhcp, get_by_id("dhcpsvr"));
		get_by_id("lan_ipaddr").value = lanCfg.lanIp;
		get_by_id("lan_netmask").value = lanCfg.lanSubnet;
		get_by_id("dhcpd_domain_name").value = lanCfg.lanDomain;
		get_by_id("dhcpd_start").value = lanCfg.lanMinAddr;
		get_by_id("dhcpd_end").value = lanCfg.lanMaxAddr;
		get_by_id("dhcpd_lease_time").value = lanCfg.lanDhcpLease;
		get_by_id("lan_device_name").value = lanCfg.lanDeviceName;
		
		set_checked(lanCfg.dhcpBroadcast, get_by_id("always_broadcast"));
		set_checked(lanCfg.netBIOSAnnounce, get_by_id("netbios_announcement"));
		set_checked(lanCfg.netBIOSLearn, get_by_id("netbios_learn"));
		get_by_id("dhcpd_static_scope").value = lanCfg.netBIOSScope;
		set_checked(lanCfg.netBIOSNodeType, get_by_name("netbios_node"));
		get_by_id("wins_ip1").value = lanCfg.primaryWINS;
		get_by_id("wins_ip2").value = lanCfg.secondaryWINS;
	
		var login_who= login_Info;
		if(login_who!= "w"){
			DisableEnableForm(form1,true);	
		} 
		else{	
			disable_ip();
		}
		set_form_default_values("form1");
	}
	
	function padout(number) {
		return (number < 10) ? '0' + number : number;
	}
	
	function Data(enable, name, ip, mac, onList)
    {
        this.Enable = enable;
        this.Name = name;
        this.IP = ip;
        this.MAC = mac;
        this.OnList = onList;
    }
	
	function DHCP_Data(name, ip, mac, Exp_time, onList)
    {
        this.Name = name;
        this.IP = ip;
        this.MAC = mac;
        this.EXP_T = Exp_time;
        this.OnList = onList;
    }
	
	function set_reservation(){
		var index = 1;
		for (var i = 0; i < reserveCnt; i++)
		{
			if(reservedHost.ipaddr[i].length > 0){
				DataArray[DataArray.length++] = new Data(reservedHost.enable[i],reservedHost.name[i],reservedHost.ipaddr[i], reservedHost.mac[i], i);
				index ++;
			}
		}
		
		get_by_id("max_row").value = index - 1;
	}
	
	function set_reserved_enable(index)
	{
		//alert(index+ ", "+get_by_id("r_enable"+index).checked);
		DataArray[index].Enable = get_checked_value(get_by_id("r_enable"+index));
		get_by_id("modified").value = "true";
		//paintReservedTable();
	}

	function set_lan_dhcp_list(){
		var index = 0;
		for (var i = 0; i < lanHostInfo.name.length; i++){	
			var obj = get_by_id("reserved_list");
			if(lanHostInfo.type[i] == "0" || lanHostInfo.type[i] == "1"){
				var exp_str = "";
				if(lanHostInfo.type[i] == "1")
				{
					exp_str=get_words('_never');
				}
				else
				{
					var wTime = parseInt(lanHostInfo.expire[i]);
					var days = Math.floor(wTime / 86400);
						wTime %= 86400;
					var hours = Math.floor(wTime / 3600);
						wTime %= 3600;
					var mins = Math.floor(wTime / 60);
						wTime %= 60;

					exp_str = days + " " + 
						((days <= 1) 
							? get_words('tt_Day')
							: get_words('gw_days'))
						+ ", " + hours + ":" + padout(mins) + ":" + padout(wTime);
				}
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(lanHostInfo.name[i], lanHostInfo.ipaddr[i], lanHostInfo.mac[i], exp_str, index);
				
				var ooption = document.createElement("option");
				ooption.text = lanHostInfo.name[i];
				ooption.value = index;
				obj.options[index+1] = ooption;
				
				index++;
			}
		}
		get_by_id("dhcp_num").innerHTML = DHCPL_DataArray.length;
	}
	
	function disable_ip()
    {
        var dhcpsvr = get_by_id("dhcpsvr");
        var is_hidden = "";

        if (dhcpsvr.checked)
            is_hidden = "";
        else
            is_hidden = "none";

        get_by_id("dhcpd_start").disabled = !dhcpsvr.checked;
        get_by_id("dhcpd_end").disabled = !dhcpsvr.checked;
        get_by_id("dhcpd_lease_time").disabled = !dhcpsvr.checked;
        get_by_id("always_broadcast").disabled = !dhcpsvr.checked;
        get_by_id("netbios_announcement").disabled = !dhcpsvr.checked;
        get_by_id("add_reserved").style.display = is_hidden;
        get_by_id("reservation_list").style.display = is_hidden;
        get_by_id("dhcpd_list").style.display = is_hidden;
		disable_netbios();
    }

	//20120426 silvia add, follow NetBIOS SPEC
    function disable_netbios_WINS()
    {
		var flag = (get_checked_value(get_by_name('netbios_node')) == 0)?1:0;
		if (($('#dhcpsvr')[0].checked) && ($('#netbios_announcement')[0].checked))
		{
			get_by_id("wins_ip1").disabled = flag;
			get_by_id("wins_ip2").disabled = flag;
		}
    }
	
    function disable_netbios()
    {
        if (get_by_id("dhcpsvr").checked) {
            get_by_id("netbios_learn").disabled = !get_by_id("netbios_announcement").checked;
            disable_netbios_option(get_by_id("netbios_learn").disabled);
            if (get_by_id("netbios_announcement").checked) {
                disable_netbios_option(get_by_id("netbios_learn").checked);
            }
        }
        else {
            get_by_id("netbios_learn").disabled = true;
            disable_netbios_option(get_by_id("netbios_learn").disabled);
        }
    }
	
	function clone_mac_action(){
		get_by_id("reserved_mac").value = cli_mac;
	}

    function disable_netbios_option(flag)
    {
        get_by_id("dhcpd_static_scope").disabled = flag;
        for (var i = 0; i < 4; i++) {
            get_by_name("netbios_node")[i].disabled = flag;
        }
        get_by_id("wins_ip1").disabled = flag;
        get_by_id("wins_ip2").disabled = flag;
		disable_netbios_WINS();
    }

    function check_dhcp_range()
    {
        var lan_ip = get_by_id("lan_ipaddr").value.split(".");
        var start_ip3 = get_by_id("dhcpd_start").value.split(".");
        var end_ip3 = get_by_id("dhcpd_end").value.split(".");
        var enrty_IP = lan_ip[2];
        get_by_id("dhcpd_start").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + start_ip3[3];
        get_by_id("dhcpd_end").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + end_ip3[3];
    }

	function check_dev_name(devName)
	{
		if (devName == null)
			return false;

		var all_num = true;

		for (var i=0; i<devName.length; i++) {
			var data = devName.substring(i, i+1);

			// check if at least one char is not an number
			if ((data >= 'A' && data <= 'Z') || (data >= 'a' && data <= 'z')) {
				all_num = false;
			}

			// first bit must be a-z or A-Z
			if ((i == 0) && !(data >= 'A' && data <= 'Z') && !(data >= 'a' && data <= 'z')) {
				return false;
			}

			if ((data >= 'A' && data <= 'Z') || (data >= '0' && data <= '9') || (data >= 'a' && data <= 'z') || data == '-' || data == '_') {
				continue;
			}

			return false;
		}

		if (all_num == true) {
			return false;
		}

		return true;
	}

	function update_DataArray(){
		var index = parseInt(get_by_id("edit").value);
		var insert = false;
		var is_enable = "0";

		//alert(DataArray.length);
		if(index == "-1"){      //save
			//if(get_by_id("max_row").value == rule_max_num){
			if(DataArray.length == rule_max_num){
				alert(get_words('TEXT015'));
			}else{
				index = DataArray.length;
				get_by_id("max_row").value = index;
				insert = true;
			}
		}

		if(get_by_id("reserved_enable").checked){
			is_enable = "1";
		}else{
			is_enable = "0";
		}
	
		//alert(index);
		if(insert){
			DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, get_by_id("reserved_mac").value, index);			
		}else if (index != -1){
			DataArray[index].Enable = is_enable;
			DataArray[index].Name = get_by_id("reserved_name").value;
			DataArray[index].IP = get_by_id("reserved_ip").value;
			DataArray[index].MAC = get_by_id("reserved_mac").value;
			DataArray[index].OnList = index;
		}
		return true; //grace yang added 2009.07.01
	}	

	function edit_row(idx)
    {
        if (DataArray[idx].Enable == 1)
            get_by_id("reserved_enable").checked = true;
        else
            get_by_id("reserved_enable").checked = false;

        get_by_id("reserved_name").value = DataArray[idx].Name;
        get_by_id("reserved_ip").value = DataArray[idx].IP;
        get_by_id("reserved_mac").value = DataArray[idx].MAC;
        get_by_id("edit").value = idx;
    }
	
	function del_row(idx)
	{
		if(!confirm(get_words('YM25') + DataArray[idx].IP))
			return;
			
		for(var i=idx; i<(DataArray.length-1); i++)
		{
			DataArray[i].Enable = DataArray[i+1].Enable
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].IP = DataArray[i+1].IP;
			DataArray[i].MAC = DataArray[i+1].MAC;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}
		
		if(DataArray.length > 0)
			DataArray.length -- ;
		
		//alert(DataArray.length);
		paintReservedTable();
		get_by_id("modified").value = "true";
	}
	
	function revoke(idx){
		if (login_Info != "w")
			return;
		
		var paramRevoke = {
			url: "get_set.ccp",
			arg: "ccp_act=revokeHost" +
				 "&ip=" +DHCPL_DataArray[idx].IP+
				 "&mac=" +DHCPL_DataArray[idx].MAC
		};
		
		ajax_submit(paramRevoke);
		setTimeout("reloadPage()",1*1000);
	}

	function reloadPage()
	{
		if (!is_form_modified("form1") ||
			(is_form_modified("form1") && confirm (get_words('up_fm_dc_1'))))
			window.location.href = "lan.asp";
	}

	function edit_dhcp_client(idx){

		if (login_Info != "w")
			return;
		
		get_by_id("reserved_enable").checked = true;
		get_by_id("reserved_name").value = DHCPL_DataArray[idx].Name;
		get_by_id("reserved_ip").value = DHCPL_DataArray[idx].IP;
		get_by_id("reserved_mac").value = DHCPL_DataArray[idx].MAC;
		get_by_id("modified").value = "true";
	}

	function set_reserved(){
		var idx = parseInt(get_by_id("reserved_list").selectedIndex);

		get_by_id("reserved_enable").checked = true;
		if (idx > 0){	
			get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
			get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
			get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
		}
	}	
	
	function clear_reserved()
    {
        get_by_id("reserved_enable").checked = false;
        get_by_id("reserved_name").value = "";
        get_by_id("reserved_ip").value = "";
        get_by_id("reserved_mac").value = "";
        get_by_id("edit").value = -1;
    }
	
	function save_reserved(bufferSaveFlag){ //grace yang added 2009.07.01
		//alert("save_reserved");
		var index = 0;
		var ip = get_by_id("lan_ipaddr").value;
		var mask = get_by_id("lan_netmask").value;
		var reserved_enable = get_checked_value(get_by_id("reserved_enable"));
		var reserved_name = get_by_id("reserved_name").value;
		var reserved_ip = get_by_id("reserved_ip").value;
		var reserved_mac = get_by_id("reserved_mac").value;
		var start_ip = get_by_id("dhcpd_start").value;
		var end_ip = get_by_id("dhcpd_end").value;

		var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('lan_reserveIP')); 
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035')); 
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));

		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
		
		//graceyang 20090818 check "lan ip" & "reservation dhcp list ip" domain
		if(bufferSaveFlag == 'Y')
		{
			var temp_res_ip2_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
			if(reserved_enable == "1"){
				if (!check_domain(temp_res_ip2_obj, temp_mask_obj, temp_ip_obj)){
					alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
					return false;
				}	
			}
		}
		else
		{
			for(j=0;j<DataArray.length;j++){  // get reservation DHCP list rule value
				
				/*var rule_value;
				temp_reserv =reserve_ip_enable[j]+"/"
							+reserve_ip_name[j]+"/"
							+reserve_ip[j]+"/"
							+reserve_ip_mac[j];
							*/
				//var temp_res_ip2_obj = new addr_obj(temp_reserv[2].split("."), Res_ip_addr_msg, false, false);
				var temp_res_ip2_obj = new addr_obj(DataArray[j].IP.split("."), Res_ip_addr_msg, false, false);
				if(DataArray[j].Enable == "1"){
					if (!check_domain(temp_res_ip2_obj, temp_mask_obj, temp_ip_obj)){
						alert(get_words('TEXT033')+" " + DataArray[j].IP + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
						return false;
					}	
				}				
			}
		}

	// grace yang added 2009.07.01
		if(bufferSaveFlag == "N" && reserved_name == ""){
			clear_reserved();
			return true;
		}
		else{
			if(reserved_name == ""){
				//alert(msg[STATIC_DHCP_NAME]);
				alert(get_words('GW_INET_ACL_NAME_INVALID'));
				return false;
			}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, get_words('TEXT033'))){
				return false;
			}else if (!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)) {
				return false;
			}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
				alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
				return false;
			}else if (!check_mac(reserved_mac)){
				alert(get_words('KR3'));
				return false;
			}
		}

        if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)) {
			alert(get_words('TEXT033')+" " + reserved_ip + " "+get_words('GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a'));
            return false;
        }

        //check same ip/mac start
        var index = parseInt(get_by_id("edit").value);
        var edit_tmp = get_by_id("edit").value;
		if (DataArray != null) {
			for(var m = 0; m < DataArray.length; m++){
				if (m == index) {
					continue;
				}
				
				if (get_by_id("reserved_name").value.length > 0) {
					if((get_by_id("reserved_name").value == DataArray[m].Name)){
						var alt_msg = addstr1(get_words('GW_QOS_RULES_NAME_ALREADY_USED'), get_by_id("reserved_name").value);
						alert(alt_msg);					
						return false;
					}
				}

				if (reserved_ip.length > 0) {
					if((reserved_ip == DataArray[m].IP)){
						var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID'), " ("+ reserved_ip +") ");
						alert(alt_msg);
						return false;
					}
				}
				if (reserved_mac.length > 0) {
					if((reserved_mac == DataArray[m].MAC)){
						var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID'), reserved_mac);
						alert(alt_msg);
						return false;
					}
				}
			}
		}
        //check same ip/mac end

        update_DataArray();

        var is_enable = "";
        if (get_by_id("edit").value == "-1") {     //add
            var i = get_by_id("max_row").value;
            var tb1 = get_by_id("table1");
            var oTr = tb1.insertRow(-1);
            var oTd1 = oTr.insertCell(-1);
            var oTd2 = oTr.insertCell(-1);
            var oTd3 = oTr.insertCell(-1);
            var oTd4 = oTr.insertCell(-1);
            var oTd5 = oTr.insertCell(-1);
            var oTd6 = oTr.insertCell(-1);

            if (parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
			
			//add_filter();
		}else{                                        //update		
			var i = parseInt(get_by_id("edit").value);
			if(parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
			//update_filter(i);
		}
		paintReservedTable();
		clear_reserved();
		// grace yang added 2009.07.01
		return true;
	}	
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
            return false;
        }
		var dhcpsvr = get_by_id("dhcpsvr");
		var start_obj, end_obj;
		var temp_mac = "";
		var ip = (dev_mode=="0") ? get_by_id("lan_ipaddr").value: get_by_id("ap_lan_ipaddr").value;
		var mask = (dev_mode=="0") ? get_by_id("lan_netmask").value: get_by_id("ap_lan_netmask").value;
		var winsip1 = get_by_id("wins_ip1").value;
		var winsip2 = get_by_id("wins_ip2").value;
		var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var dhcp_les = get_by_id("dhcpd_lease_time").value;
		var dhcpd_domain_name = get_by_id("dhcpd_domain_name").value;
		var lan_device_name = null;
		
		if (dev_mode == '0')
			lan_device_name = get_by_id("lan_device_name").value;
		else
			lan_device_name = get_by_id("ap_lan_device_name").value;
		if (check_dev_name(lan_device_name) == false) {
			alert(get_words('GW_LAN_DEVICE_NAME_INVALID'));
			return false;
		}		
					
		var wan_proto 			= wanCfg.proto;
		var wan_port_status 	= wanCfg.networkSt;
		var wan_ip_addr 		= wanCfg.ipaddr;
		var temp_wins_ip1_obj 	= new addr_obj(winsip1.split("."), all_ip_addr_msg, false, false);
		var temp_wins_ip2_obj 	= new addr_obj(winsip2.split("."), all_ip_addr_msg, false, false);
		var wan_ip_addr_obj 	= new addr_obj(wan_ip_addr.split("."), wan_ip_addr_msg, false, false); 

		var netbios_scope = get_by_id("dhcpd_static_scope").value;
		
		if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj)) {
			return false;
		}

	   if(wan_proto == "static" && wan_ip_addr != "0.0.0.0"){ // when wan static ip doesn't empty
			if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
				//alert("LAN and WAN IP Address cann't be set to the same subnet.");
				alert(get_words('bln_alert_3'));
				return false;
			}
			
		/*}else if(wan_proto != "static" && get_by_id("wan_current_ipaddr").value != "0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0"){ // /PPTP/L2TP/PPPoE plug in WAN port
			if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
				//alert("LAN and WAN IP Address cann't be set to the same subnet.");
				alert(get_words('bln_alert_3'));
				return false;
			}*/
		}else if(wan_proto == "pppoe" && wan_ip_addr != "0.0.0.0"){ // when wan pppoe ip doesn't empty
			if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
				//alert("LAN and WAN IP Address cann't be set to the same subnet.");
				alert(get_words('bln_alert_3'));
				return false;
			}
		}else if(wan_proto == "pptp" && wan_ip_addr != "0.0.0.0"){ // when wan pptp ip doesn't empty
			if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
				//alert("LAN and WAN IP Address cann't be set to the same subnet.");
				alert(get_words('bln_alert_3'));
				
				return false;
			}
		}else if(wan_proto == "l2tp" && wan_ip_addr != "0.0.0.0"){ // when wan l2tp ip doesn't empty
			if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
				//alert("LAN and WAN IP Address cann't be set to the same subnet.");
				alert(get_words('bln_alert_3'));
				return false;
			}
		}

		if ((dhcpsvr.checked) && (dev_mode == "0")){			//add dev_mode check by vic, 2010/11/08
			var start_ip = get_by_id("dhcpd_start").value;
			var end_ip = get_by_id("dhcpd_end").value;
			
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('TEXT035'));
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('end_ip'));

			var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
			var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

			//check dhcp ip range equal to lan-ip or not?
			if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, "Start IP address")){
				return false;
			}

			if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, "End IP Address")){
				return false;
			}
			
			if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip1_obj.addr, "Primary WINS IP address")){
				return false;
			}
			
			if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip2_obj.addr, "Secondary WINS IP address")){
				return false;
			}

			//check dhcp ip range and lan ip the same mask or not?
			if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj)){
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
				//alert(msg[START_INVALID_DOMAIN]);
				alert(get_words('TEXT037'));
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
				//alert(msg[END_INVALID_DOMAIN]);
				alert(get_words('TEXT038'));
				return false;
			}
			
			if (!check_ip_order(start_obj, end_obj)){
				//alert(msg[IP_RANGE_ERROR]);
				alert(get_words('TEXT039'));
				return false;
			}
			
			if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
				alert(get_words('network_dhcp_ip_in_server'));
				//alert(msg[NETWORK_DHCP_IP_IN_SERVER]);
				return false;
			}
			var less_msg = replace_msg(check_num_msg, get_words('bd_DLT'), 1, 999999);
			var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
			if (!check_varible(temp_less)){
				return false;
			}
			if(get_by_id("netbios_announcement").checked && !get_by_id("netbios_learn").checked){
				var wins_ip1 = get_by_id("wins_ip1").value;
				var wins_ip2 = get_by_id("wins_ip2").value;
				var wins_ip1_addr_msg = replace_msg(all_ip_addr_msg,get_words('bd_NETBIOS_PRI_WINS'));
				var wins_ip2_addr_msg = replace_msg(all_ip_addr_msg,get_words('bd_NETBIOS_SEC_WINS'));
				var wins_ip1_obj = new addr_obj(wins_ip1.split("."), wins_ip1_addr_msg, false, false);
				var wins_ip2_obj = new addr_obj(wins_ip2.split("."), wins_ip2_addr_msg, false, false);

			//if(!get_by_name("netbios_node")[0].checked && (!check_address(wins_ip1_obj) || !check_address(wins_ip2_obj))){
			//2009.9.10 from 825NA removed check wins_ip2 when netbios_node = [1],[2],[3]
			if(!get_by_name("netbios_node")[0].checked && (!check_address(wins_ip1_obj))){
					return false;
				}else if(get_by_name("netbios_node")[0].checked){					
					if(((wins_ip1 !="") && (wins_ip1!="0.0.0.0")) && !check_address(wins_ip1_obj)){
						return false;
					}
					if(((wins_ip2 !="") && (wins_ip2!="0.0.0.0")) && !check_address(wins_ip2_obj)){
						return false;
					}
				}
			}
		}		
		
		//if(check_reservation() == false)
		//to submit reservation and lan setting at the same time
		var tmp_reserv_enable 	= get_checked_value(get_by_id("reserved_enable"));
		var tmp_reserv_name		= get_by_id("reserved_name").value;
		var tmp_reserv_ip		= get_by_id("reserved_ip").value;
		var tmp_reserv_mac		= get_by_id("reserved_mac").value;
		
		if((tmp_reserv_enable!=0) || (tmp_reserv_name!="") || (tmp_reserv_ip!="") || (tmp_reserv_mac!=""))
		{
			if(save_reserved() == false)
				return false;
		}
		else
		{
			if(save_reserved("N") == false)
				return false;
		}
				
		if(check_address(temp_ip_obj, temp_mask_obj) && check_mask(temp_mask_obj)){
			//change_ip();
			//update_data();

			get_by_id("dhcpd_enable").value = get_checked_value(get_by_id("dhcpsvr"));
			get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));

			get_by_id("dhcpd_always_bcast").value = get_checked_value(get_by_id("always_broadcast"));
			get_by_id("dhcpd_netbios_enable").value = get_checked_value(get_by_id("netbios_announcement"));
			get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));
			get_by_id("dhcpd_netbios_learn").value = get_checked_value(get_by_id("netbios_learn"));
			get_by_id("dhcpd_static_node_type").value = get_checked_value(get_by_name("netbios_node"));

			get_by_id("dhcpd_static_wins_server").value = get_by_id("wins_ip1").value + "/" + get_by_id("wins_ip2").value;

			if(submit_button_flag == 0){
				submit_button_flag = 1;
				/*var restoreStr
				for(var i=0; i<25; i++)
				{
				}*/
				deleteRedundentDatamodel();
				var submitParam = {
					url: "get_set.ccp",
					arg: ""
				};
				
				var submitStr = copyDataToDataModelFormat();

				submitParam.arg = submitStr;
				submitParam.url = "get_set.ccp";
				get_config_obj(submitParam);
				//send_submit("form3");
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}			
	}
	
	function paintReservedTable()
	{
		var contain = ""
		//contain +='<h2>'+show_words(bd_title_clients)+'<span id="dhcp_num"></span></h2>';
		contain +='<table id="table2" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">';
		contain +='<tr>';
		contain +='<td>'+get_words(_enable)+'</td>';
		contain +='<td>'+get_words(help260)+'</td>';
		contain +='<td>'+get_words(_macaddr)+'</td>';
		contain +='<td>'+get_words(_ipaddr)+'</td>';
		contain +='<td></td>';
		contain +='<td></td>';
		contain +='</tr>';
		
		var is_enable = "";
		for(var i = 0; i < DataArray.length; i++){
			if(parseInt(DataArray[i].Enable)){
				is_enable = "checked";
			}else{
				is_enable = "";
			}
			//document.write("<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center></td></tr>");
			contain += "<tr><td><center><input type=checkbox value=1 id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" title=\""+get_words('_edit')+"\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" title=\""+get_words('_delete')+"\"></a></center></td></tr>";
		}
		contain += '</table>';
		get_by_id("reservedTable").innerHTML = contain;
	}
	
	function paintLanHostTable()
	{
		var contain = ""
		//contain +='<h2>'+show_words(bd_title_clients)+'<span id="dhcp_num"></span></h2>';
		contain +='<table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">';
		contain +='<tr>';
		contain +='<td>'+get_words(LS422)+'</td>';
		contain +='<td>'+get_words(LS423)+'</td>';
		contain +='<td>'+get_words(LS424)+'</td>';
		contain +='<td>'+get_words(LS425)+'</td>';
		contain +='<td></td>';
		contain +='<td></td>';
		contain +='</tr>';
		for(var i=0;i<DHCPL_DataArray.length;i++){
			if(DHCPL_DataArray[i].EXP_T == "0 Day, 0:00:00")
				continue;
			//document.write("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].Name +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td><td><center><a href='javascript:revoke(" + i + ")'>Revoke</a></center></td><td><center><a href='javascript:edit_dhcp_client(" + i + ")'>Reserve</a></center></td></tr>");
			contain += ("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].Name +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td><td><center><a href='javascript:revoke(" + i + ")'>"+get_words('bd_Revoke')+"</a></center></td><td><center><a href='javascript:edit_dhcp_client(" + i + ")'>"+get_words('bd_Reserve')+"</a></center></td></tr>");
		}
		contain += '</table>';
		get_by_id("lanHostTable").innerHTML = contain;
	}
	
	function copyDataToDataModelFormat()
	{
		get_by_id("old_ip").value	= (dev_mode == "0")? lanCfg.lanIp: lanCfg.lanAPIp;
		get_by_id("old_mask").value = (dev_mode == "0")? lanCfg.lanSubnet: lanCfg.lanAPSubnet;
		get_by_id("new_ip").value	= (dev_mode == "0")? get_by_id("lan_ipaddr").value: get_by_id("ap_lan_ipaddr").value;
		get_by_id("new_mask").value = (dev_mode == "0")? get_by_id("lan_netmask").value: get_by_id("ap_lan_netmask").value;		

		var paramStr = "";
		paramStr += 'ccp_act=set';
		paramStr += '&ccpSubEvent=CCP_SUB_LAN';
		paramStr += '&old_ip=' + get_by_id("old_ip").value;
		paramStr += '&old_mask=' + get_by_id("old_mask").value;
		paramStr += '&new_ip=' + get_by_id("new_ip").value;
		paramStr += '&new_mask=' + get_by_id("new_mask").value;
		
		if((get_by_id("old_ip").value != get_by_id("new_ip").value) ||
			(get_by_id("old_mask").value != get_by_id("new_mask").value))
		{
			paramStr += '&nextPage=back.asp';
		}
		else
			paramStr += '&nextPage=lan.asp';
			
		if(dev_mode == "0")
		{
			paramStr += '&lanHostCfg_IPAddress_1.1.1.0.0=' + get_by_id("lan_ipaddr").value;
			paramStr += '&lanHostCfg_SubnetMask_1.1.1.0.0=' + get_by_id("lan_netmask").value;
			paramStr += '&lanHostCfg_DomainName_1.1.1.0.0=' + get_by_id("dhcpd_domain_name").value;
			paramStr += '&lanHostCfg_DNSRelay_1.1.1.0.0=' + get_checked_value(get_by_id("DNSrelay"));
			paramStr += '&lanHostCfg_DHCPServerEnable_1.1.1.0.0=' + get_checked_value(get_by_id("dhcpsvr"));
			paramStr += '&lanHostCfg_MinAddress_1.1.1.0.0=' + get_by_id("dhcpd_start").value;
			paramStr += '&lanHostCfg_MaxAddress_1.1.1.0.0=' + get_by_id("dhcpd_end").value;
			paramStr += '&lanHostCfg_DHCPLeaseTime_1.1.1.0.0=' + get_by_id("dhcpd_lease_time").value;
			paramStr += '&lanHostCfg_DeviceName_1.1.1.0.0=' + get_by_id("lan_device_name").value;
		}
		else
		{
			paramStr += '&lanHostCfg_APIPAddress_1.1.1.0.0=' + get_by_id("ap_lan_ipaddr").value;
			paramStr += '&lanHostCfg_APSubnetMask_1.1.1.0.0=' + get_by_id("ap_lan_netmask").value;
			paramStr += '&lanHostCfg_APGateway_1.1.1.0.0=' + get_by_id("ap_gw").value;
			paramStr += '&lanHostCfg_APDeviceName_1.1.1.0.0=' + get_by_id("ap_lan_device_name").value;
			paramStr += '&lanHostCfg_APPrimaryDNSAddress_1.1.1.0.0=' + get_by_id("ap_dns1").value;
			paramStr += '&lanHostCfg_APSecondaryDNSAddress_1.1.1.0.0=' + get_by_id("ap_dns2").value;
		}
		
		paramStr += '&lanHostCfg_AlwaysBroadcast_1.1.1.0.0=' + get_checked_value(get_by_id("always_broadcast"));
		paramStr += '&lanHostCfg_NetBIOSAnnouncement_1.1.1.0.0=' + get_checked_value(get_by_id("netbios_announcement"));
		paramStr += '&lanHostCfg_NetBIOSLearn_1.1.1.0.0=' + get_checked_value(get_by_id("netbios_learn"));
		paramStr += '&lanHostCfg_NetBIOSScope_1.1.1.0.0=' + get_by_id("dhcpd_static_scope").value;
		paramStr += '&lanHostCfg_NetBIOSNodeType_1.1.1.0.0=' + get_checked_value(get_by_name("netbios_node"));
		paramStr += '&lanHostCfg_PrimaryWINSAddress_1.1.1.0.0=' + get_by_id("wins_ip1").value;
		paramStr += '&lanHostCfg_SecondaryWINSAddress_1.1.1.0.0=' + get_by_id("wins_ip2").value;
		
		/*construct reservation*/
		for(var i=0; i<DataArray.length; i++)
		{
			var instStr = "1.1.1."+ (i+1) +".0";
			paramStr += "&reserveDHCP_Enable_"+instStr+"="+DataArray[i].Enable;
			paramStr += "&reserveDHCP_HostName_"+instStr+"="+DataArray[i].Name;
			paramStr += "&reserveDHCP_Chaddr_"+instStr+"="+DataArray[i].MAC;
			paramStr += "&reserveDHCP_Yiaddr_"+instStr+"="+DataArray[i].IP;
		}
		
		return paramStr;
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
	
	function deleteRedundentDatamodel()
	{
		var delCnt = 0;
		var idx = reserveCnt;
		if(reserveCnt > DataArray.length)
			delCnt = reserveCnt - DataArray.length;
		
		if(delCnt == 0)
			return;
		
		var paramDel = {
			url: 'get_set.ccp',
			arg: 'ccp_act=del&ccpSubEvent=CCP_SUB_LAN&num_inst=' + delCnt
		};
		
		while(delCnt > 0)
		{
			paramDel.arg += '&oid_'+delCnt+'=IGD_LANDevice_i_LANHostConfigManagement_DHCPStaticAddress_i_&inst_'+delCnt+'=' + '1.1.1.'+ idx +'.0';
			delCnt --;
			idx --;
		}
		
		ajax_submit(paramDel);
	}
</script>
</head>

<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
		<tr>
			<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(model);</script></a></td>
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
								<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
								<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
								<li><div id="sidenavoff"><script>show_words(bln_title_NetSt)</script></div></li>
								<li><div id="sidenavon"><a href="storage_setup.asp" onclick="return jump_if();"><script>show_words(storage)</script></a></div></li>
								<li><div id="sidenavon"><a href="setup_ipv6.asp" onclick="return jump_if();"><script>show_words(IPV6_TEXT137)</script></a></div></li>
								<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
							</ul>
						</div>
					</td>
				</tr>
			</table>
		</td>


		<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back_lan.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="lan">
			<input type="hidden" id="del" name="del" value="-1">
			<input type="hidden" id="edit" name="edit" value="-1">
			<input type="hidden" id="max_row" name="max_row" value="-1">
			<input type="hidden" id="opendns_enable" name="opendns_enable" value=''>
			<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value=''>
			<input type="hidden" id="dhcp_list" name="dhcp_list" value=''>
			<input type="hidden" name="old_ip" id="old_ip" value="">
			<input type="hidden" name="old_mask" id="old_mask" value="">
			<input type="hidden" name="new_ip" id="new_ip" value="">
			<input type="hidden" name="new_mask" id="new_mask" value="">
			<input type="hidden" name="modified" id="modified" value="0">

			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<div id="box_header">
						<h1>
							<script>show_words(bln_title_NetSt)</script>
						</h1>
						<script>show_words(ns_intro_)</script>
						<br>
						<br>
						<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
						<input name="button2" id="button2" type="button" class=button_submit value="" onclick="reloadPage();">
						<script>get_by_id("button").value = get_words('_savesettings');</script>
						<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
					</div>
					<div class="box">
						<h2>
							<script>show_words(bln_title_Rtrset)</script>
						</h2>

						<p>
							<script>show_words(YM97)</script>
						</p>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td class="duple">
								<script>show_words(_ripaddr)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;&nbsp;
									<input name="lan_ipaddr" type="text" id="lan_ipaddr" size="20" maxlength="15" onChange="check_dhcp_range()" value=''>
								</td>
							</tr>
							
							<tr>
								<td class="duple">
									<script>show_words(_subnet)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;&nbsp;
									<input name="lan_netmask" type="text" id="lan_netmask" size="20" maxlength="15" value=''>
								</td>
							</tr>
							
							<tr>
								<td class="duple">
									<script>show_words(DEVICE_NAME)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;&nbsp;
									<input name="lan_device_name" type="text" id="lan_device_name" size="20" maxlength="15" value=''>
								</td>
							</tr>
							
							<tr>
								<td class="duple">
									<script>show_words(_262)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;
									<input name="dhcpd_domain_name" type="text" id="dhcpd_domain_name" size="40" maxlength="30" value=''>
								</td>
							</tr>

							<tr>
								<td class="duple">
									<script>show_words(bln_EnDNSRelay)</script>:
								</td>
								<td width="340">&nbsp;
									<input name="DNSrelay" type=checkbox id="DNSrelay" value="1">
									<input type="hidden" id="dns_relay" name="dns_relay" value=''>
								</td>
							</tr>

						</table>
					</div>
					
					<div class="box">
						<h2>
							<script>show_words(bd_title_DHCPSSt)</script>
						</h2>
						<p>
							<script>show_words(bd_intro_)</script>
						</p>
						
						<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
							<tr>
								<input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value=''>
								<td class="duple">
									<script>show_words(bd_EDSv)</script>:
								</td>						
								<td width="340">&nbsp;
									<input name="dhcpsvr" type=checkbox id="dhcpsvr" onClick="disable_ip()" value="1">
								</td>
							</tr>

							<tr>
								<td class="duple">
									<script>show_words(bd_DIPAR)</script>:
								</td>
								<td width="340">&nbsp;
									<input type="text" id="dhcpd_start" name="dhcpd_start" value='' size="20" maxlength="15">
									&nbsp;
									<script>show_words(_to)</script>
									<input type="text" id="dhcpd_end" name="dhcpd_end" value='' size="20" maxlength="15">
								</td>
							</tr>
							
							<tr>
								<td class="duple">
									<script>show_words(bd_DLT)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type="text" id="dhcpd_lease_time" name="dhcpd_lease_time" size="6" maxlength="6" value=''>
									&nbsp;&nbsp;
									<script>show_words(_minutes)</script>
								</td>
							</tr>

							<tr>
								<input type="hidden" id="dhcpd_always_bcast" name="dhcpd_always_bcast" value=''>
								<td class="duple">
									<script>show_words(bd_DAB)</script>:
								</td>
								<td width="340">&nbsp;
									<input name="always_broadcast" type=checkbox id="always_broadcast" value="1">
									<script>show_words(bd_DAB_note)</script>
								</td>
							</tr>
								
							<tr>
								<input type="hidden" id="dhcpd_netbios_enable" name="dhcpd_netbios_enable" value=''>
								<td class="duple">
									<script>show_words(bd_NETBIOS_ENABLE)</script>:
								</td>
								<td width="340">&nbsp;
									<input type=checkbox id="netbios_announcement" name="netbios_announcement" value="1" onClick="disable_netbios();">
								</td>
							</tr>
								
							<tr>
								<input type="hidden" id="dhcpd_netbios_learn" name="dhcpd_netbios_learn" value=''>
								<td class="duple">
									<script>show_words(bd_NETBIOS_LEARN_FROM_WAN_ENABLE)</script>:
								</td>
								<td width="340">&nbsp;
									<input type=checkbox id="netbios_learn" name="netbios_learn" value="1" onClick="disable_netbios();">
								</td>
							</tr>

							<tr>
								<td class="duple">
									<script>show_words(bd_NETBIOS_SCOPE)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type="text" id="dhcpd_static_scope"  name="dhcpd_static_scope" maxlength="30" value=''>
									(<script>show_words(LT124)</script>)
								</td>
							</tr>

							<tr>
								<input type="hidden" id="dhcpd_static_node_type" name="dhcpd_static_node_type" value=''>
								<td class="duple" valign="top">
									<script>show_words(bd_NETBIOS_REG_TYPE)</script>:
								</td>
								<td width="340">&nbsp;
									<input type="radio" id="netbios_node"  name="netbios_node" value="0" onClick="disable_netbios_WINS();">
									<script>show_words(bd_NETBIOS_REG_TYPE_B)</script>
									<br>&nbsp;
									<input type="radio" name="netbios_node" value="1" onClick="disable_netbios_WINS();">
									<script>show_words(bd_NETBIOS_REG_TYPE_P)</script>
									<br>&nbsp;
									<input type="radio" name="netbios_node" value="2" onClick="disable_netbios_WINS();">
									<script>show_words(bd_NETBIOS_REG_TYPE_M)</script>
									<br>&nbsp;
									<input type="radio" name="netbios_node" value="3" onClick="disable_netbios_WINS();">
									<script>show_words(bd_NETBIOS_REG_TYPE_H)</script>
								</td>
							</tr>

							<tr>
								<td class="duple">
									<script>show_words(bd_NETBIOS_PRI_WINS)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type="text" id="wins_ip1"  name="wins_ip1" size="20" maxlength="15">
								</td>
							</tr>

							<tr>
								<input type="hidden" id="dhcpd_static_wins_server" name="dhcpd_static_wins_server" value=''>
								<td class="duple">
									<script>show_words(bd_NETBIOS_SEC_WINS)</script>:
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type="text" id="wins_ip2"  name="wins_ip2" size="20" maxlength="15">
								</td>
							</tr>
								
						</table>
					</div>
					
					<div class="box" id="add_reserved">
						<h2>
							<script>show_words(_add)</script> 
							<script>show_words(bd_title_SDC)</script>
						</h2>
						<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
							<tr>
								<td class="duple">
									<script>show_words(_enable)</script> :
								</td>
								<td width="340">&nbsp;
									<input type=checkbox id="reserved_enable" name="reserved_enable" value="1">
								</td>
							</tr>
							<tr>
								<td class="duple">
									<script>show_words(bd_CName)</script> :
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type=text id="reserved_name" name="reserved_name" size="20">
									&lt;&lt;
									<select id="reserved_list" name="reserved_list" onChange="set_reserved()">
										<option value=-1>
											<script>show_words(bd_CName)</script>
										</option>
										<script>
											set_mac_list("name");
										</script>
									</select>
								</td>
							</tr>
							<tr>
								<td class="duple">
									<script>show_words(_ipaddr)</script> :
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type=text id="reserved_ip" name="reserved_ip" size="20" maxlength="15">
								</td>
							</tr>
							<tr>
								<td class="duple">
									<script>show_words(_macaddr)</script> :
								</td>
								<td width="340">&nbsp;&nbsp;
									<input type=text id="reserved_mac" name="reserved_mac" size="20" maxlength="17">
								</td>
							</tr>
							<tr>
								<td class="duple">&nbsp;
								</td>
								<td width="340">&nbsp;
									<script>document.write('<input id="clone" name="clone" type="button" class=button_submit value="'+get_words('_clone')+'" onClick="clone_mac_action();">')</script>
								</td>
							</tr>
							<tr>
								<td class="duple">&nbsp;
								</td>
								<td width="340">&nbsp;
									<input id="save" name="save" type="button" class=button_submit value="" onClick="save_reserved('Y');">
									<input id="clear" name="clear" type="button" class=button_submit value="" onClick="clear_reserved();">
									<script>get_by_id("save").value = get_words('_save');</script>
									<script>get_by_id("clear").value = get_words('_clear');</script>
								</td>
							</tr>
						</table>
					</div>
					
					<div class=box id="reservation_list">
					<h2>
						<script>show_words(bd_title_list)</script>
					</h2>
					<span id="reservedTable"></span>
					<script>
						set_reservation();
						paintReservedTable();
					</script>
				</div>
				<div class=box id="dhcpd_list">
					<h2><script>show_words(bd_title_clients)</script> <span id="dhcp_num"></span></h2>
					<span id="lanHostTable"></span>
				</div>
				<script>
					set_lan_dhcp_list();
					paintLanHostTable();
				</script>
            </div>
		</td>
		</form>
		
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
				<tr>
					<td id=help_text>
						<strong>
							<script>show_words(_hints)</script>
						&hellip;</strong> 
						<p>
							<script>show_words(TA7)</script>
						</p>

						<p>
							<script>show_words(TA8)</script>
						</p>
						<p>
							<a href="support_internet.asp#Network" onclick="return jump_if();">
								<script>show_words(_more)</script>&hellip;
							</a>
						</p>
					</td>
				</tr>
			</table>
		</td>
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
	set_form_default_values("form1");
</script>
</html>
