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
<script language="JavaScript" src="public_ipv6.js"></script>
<script>
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var paramHost={
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=2&oid_1=IGD_Status_LANStatus_Host_i_&inst_1=11110'+
				'&oid_2=IGD_LANDevice_i_LANHostConfigManagement_&inst_2=11100'
	};
	get_config_obj(paramHost);

	// to save connect delay time 
	var t_diff = 0;
	var proc_st = false;


// 20120313 ignore filter ip range by silvia
//	var startaddr = config_val('lanHostCfg_MinAddress_');
//	var endaddr = config_val('lanHostCfg_MaxAddress_');

	var temp_wlan_enable = 1;
	function set_mac_info(){
/*
		var lan_start = startaddr.split(".");
		var lan_end = endaddr.split(".");
		var i_start = parseInt(lan_start[3]);
		var i_end = parseInt(lan_end[3]);
*/		
		var allHostName = config_val("igdLanHostStatus_HostName_").split("/");
		var allHostIp = config_val("igdLanHostStatus_HostIPv4Address_").split("/");
		var allHostMac = config_val("igdLanHostStatus_HostMACAddress_").split("/");
		var allHostType = config_val("igdLanHostStatus_HostAddressType_").split("/");
		var allHostExpire = config_val("igdLanHostStatus_HostExpireTime_").split("/");
	
		var content="";
		content+="<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>";
		content+="<tr>";
		content+="<td>"+get_words(_ipaddr)+"</td>";
		content+="<td>"+get_words(YM187)+"</td>";
		content+="<td>"+get_words(aa_AT_1)+"</td>";
		content+="</tr>";
		for(var i=0; i<allHostIp.length; i++)
		{
			if((parseInt(allHostExpire[i]) <= 0) && ((parseInt(allHostType[i]) < 2)))
				continue;

			//document.write("<tr><td>" + allHostIp[i] + "</td><td>" + allHostName[i] + "</td><td>" + allHostMac[i].toUpperCase() + "</td></tr>");
			content+="<tr><td>" + allHostIp[i] + "</td><td>" + allHostName[i] + "</td><td>" + allHostMac[i].toUpperCase() + "</td></tr>"
		}
		content+="</table>";
		$("#lanInfo").html(content);
/*
			var chk_add = allHostIp[i].split(".");
			var i_add = parseInt(chk_add[3]);
			
			if ((chk_add[0] == lan_start[0]) && (chk_add[1] == lan_start[1]) && (chk_add[2] == lan_start[2])){
				if((i_start <= i_add) && (i_add <= i_end))
					document.write("<tr><td>" + allHostIp[i] + "</td><td>" + allHostName[i] + "</td><td>" + allHostMac[i].toUpperCase() + "</td></tr>");
			}

		var temp_dhcp_list = '';
		
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length != 0){		
				if(temp_data.length > 1){
					document.write("<tr><td>" + temp_data[0] + "</td><td>" + temp_data[1] + "</td><td>" + temp_data[2] + "</td></tr>")
				}
			}
		}
	*/
	}

	function set_igmp_info(){	
		var temp_igmp = config_val("igdWanStatus_IgmpGroupMember_").split("/");
		var content = "";
		content += '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>';
		content += '<tr>';
		content += '<td>'+ get_words('YM186') +'</td>';
		content += '</tr>';	

		for (var i = 0; i < temp_igmp.length; i++){	
			if(temp_igmp.length > 0){
				content += "<tr><td>" + temp_igmp[i] + "</td></tr>";
			}
		}
		content += '</table>';
		$("#igmpInfo").html(content);
	}

	function dhcp_renew(){
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form2");
		}
	}
	
	function dhcp_release(){
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form3");
		}
	}
	
	function pppoe_connect(){
		get_by_id("connect").disabled = "true"
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form4");
		}
	}
	
	function pppoe_disconnect(){
		get_by_id("disconnect").disabled = "true";
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form5");
		}
	}
	
	function pptp_connect(){
		get_by_id("pptpconnect").disabled = "true";
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form6");
		}
	}
	
	function pptp_disconnect(){
		get_by_id("pptpdisconnect").disabled = "true";
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form7");
		}
	}
	
	function l2tp_connect(){
		get_by_id("l2tpconnect").disabled = "true";
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form8");
		}
	}
	
	function l2tp_disconnect(){
		get_by_id("l2tpdisconnect").disabled = "true";
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form9");
		}
	}
	
	function bigpond_connect(){
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form10");
		}
	}
	
	function bigpond_disconnect(){
		if(dev_info.login_info != "w"){
			window.location.href ="back.asp";
		}else{
			send_submit("form11");
		}
	}
	
	var nNow,gTime;
	function get_time(){
		if (gTime)
			return;
		var gTime = config_val('sysTime_CurrentLocalTime_');
		var time = gTime.split(",");
		gTime = month_device[time[1]-1] + " " + time[2] + ", " + time[0] + " " + time[3] + ":" + time[4] + ":" + time[5];		
		nNow = new Date(gTime);
	}

	function STime(){
		nNow.setTime(nNow.getTime() + 1000);
		//var date = new Date();
		var fulldate = ' '+change_week(nNow.getDay()) +' '+change_mon(nNow.getMonth()) +', '+nNow.getDate() +', '+nNow.getFullYear()
					+ ' ' +len_checked(nNow.getHours())+ ':' +len_checked(nNow.getMinutes())+ ':' +len_checked(nNow.getSeconds());

		$("#show_time").html(fulldate);
		//$("#show_time").html(nNow.toLocaleString());
		setTimeout('STime()', 1000);
	}
	function padout(number) {
		return (number < 10) ? '0' + number : number;
	}

	var wTimesec, wan_time;
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	function caculate_time(){
	
		var wTime = Math.floor(wTimesec);
		var days = Math.floor(wTime / 86400);
			wTime %= 86400;
			var hours = Math.floor(wTime / 3600);
			wTime %= 3600;
			var mins = Math.floor(wTime / 60);
			wTime %= 60;

			wan_time = days + " " + 
				((days <= 1) 
					? get_words('tt_Day')
					: get_words('gw_days'))
				+ ", ";
			wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
		
	}
	
	function get_wan_time(_t, st){
		wTimesec = parseInt(_t);
		if(wTimesec == 0)
			//wan_time = "N/A";
			wan_time = get_words('_na');
		else{
			if(st == "Connecting"){
				wTimesec = 0;
				wan_time = get_words('_na');
			}
			else if(st == "Disconnecting"){
				wTimesec = wTimesec/250;
				caculate_time();
			}
			else if(st == "Connected"){
				if(proc_st){
					proc_st = false;
					t_diff = wTimesec;
					wTimesec = 1;
					caculate_time();
				}
				else{
					wTimesec = (wTimesec-t_diff)/250;
					caculate_time();
				}

			}
		}
	}
	
	function WTime(){
		$("#show_uptime").html(wan_time);
		if(wTimesec != 0){
			wTimesec++;
			caculate_time();
		}
		setTimeout('WTime()', 1000);
	}

	function createRequest() {
		var XMLhttpObject = null;
		try {
			XMLhttpObject = new XMLHttpRequest();
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {
			return null;
		}
		}
	}
		return XMLhttpObject;
	}


	function getDeviceStatus() {
		var start_time = new Date();
		start_time= start_time.getTime();
		var param = {
			'url': 	'get_set.ccp',
			'arg': 	'oid_1=IGD_Status_General_&inst_1=11000'+
					'&oid_2=IGD_Status_WANStatus_&inst_2=11000'+
					'&oid_3=IGD_Status_LANStatus_&inst_3=11000'+
					'&oid_4=IGD_Status_LANStatus_Host_i_&inst_4=11110'+
					'&oid_5=IGD_Status_WLANStatus_i_&inst_5=11000'+
					'&oid_6=IGD_Time_&inst_6=11000'+
					'&oid_7=IGD_LANDevice_i_WLANConfiguration_i_&inst_7=11000'+
					'&oid_8=IGD_LANDevice_i_LANHostConfigManagement_&inst_8=11100'+
					'&oid_9=IGD_&inst_9=10000'+
					'&oid_10=IGD_MyDLinkRegister_&inst_10=11000'+
					'&oid_11=IGD_MyDLink_&inst_11=11000'
		};
		var j = 11;
		for (i=1;i<=4;i++){
			//param.arg +='&oid_'+(j+1)+'=IGD_LANDevice_i_WLANConfiguration_i_&inst_'+(j+1)+'=11'+i+'00';
			param.arg +='&oid_'+(j+1)+'=IGD_LANDevice_i_WLANConfiguration_i_WEP_&inst_'+(j+1)+'=11'+i+'10';
			param.arg +='&oid_'+(j+2)+'=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_'+(j+2)+'=11'+i+'10';
			param.arg +='&oid_'+(j+3)+'=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_'+(j+3)+'=11'+i+'10';
			//param.arg +='&oid_'+(j+4)+'=IGD_Status_WLANStatus_i_&inst_'+(j+4)+'=11'+i+'00';
			j+=3;
		}

		param.arg +='&ccp_act=get&num_inst='+j;
		get_config_obj(param);

		var isReg = (config_val("igd_Register_st_")? config_val("igd_Register_st_"):"");
		var isaccount = config_val("igdMyDLink_EmailAccount_");	//20120430 silvia add for spec
		$('#mdl_st').html( (isReg == 1 ? get_words('mydlink_reg'):get_words('mydlink_nonreg')));
		$('#mdl_acc').html( (isReg == 1 ? isaccount:get_words('wwl_NONE')));
		isReg == 1 ? $('#myaccount').show() : $('#myaccount').hide();
		var devMode = (config_val("igd_DeviceMode_")? config_val("igd_DeviceMode_"):"0");
		if(devMode == '1')	//ap mode, hide wan st
		{
			$('#st_wan').hide();
			$('#st_igmp').hide();
			$('#st_router_lan').hide();
			$('#st_ap_lan').show();
		}
		else
		{
			$('#st_wan').show();	//show
			$('#st_igmp').show();
			$('#st_router_lan').show();	//show
			$('#st_ap_lan').hide();
		}
		get_time();
		
		// WAN
		var wanProto = '';
		switch(config_val('igdWanStatus_WanProto_'))
		{
			case "0":
				wanProto =  get_words('_sdi_staticip');
				break;
			case "1":
				wanProto =  get_words('bwn_Mode_DHCP');
				break;
			case "2":
				wanProto =  get_words('_PPPoE');
				break;
			case "3":
				wanProto =  get_words('_PPTP');
				break;
			case "4":
				wanProto =  get_words('_L2TP');
				break;
			case "9":
				wanProto =  get_words('bwn_Mode_DHCPPLUS');
				break;
			case "10":
				wanProto = 	get_words(IPV6_TEXT140);
				break;
		}
		
		$('#connection_type').html(wanProto);
		if(config_val('igdWanStatus_CableStatus_') == 'Connected')
			$('#cable_status').html(get_words('CONNECTED'));
		else
			$('#cable_status').html(get_words('DISCONNECTED'));
			
		get_wan_time(config_val('igdWanStatus_WanUpTime_'), config_val("igdWanStatus_NetworkStatus_"));
		$('#show_uptime').html();
		$('#show_mac').html(config_val('igdWanStatus_MACAddress_'));
		
		var conn_st = config_val("igdWanStatus_NetworkStatus_");
		
		if(conn_st == "Disconnected")
		{
			$('#wan_ip').html("0.0.0.0");
			$('#wan_netmask').html("0.0.0.0");
			$('#wan_gateway').html("0.0.0.0");
			$('#wan_dns1').html("0.0.0.0");
			$('#wan_dns2').html("0.0.0.0");
			$('#aftr').html("None");
			$('#ds_dhcp').html(config_val('igdWanStatus_DsLiteDHCP_'));
		}
		else if(conn_st == "Connected")
		{
			$('#wan_ip').html(config_val('igdWanStatus_IPAddress_'));
			$('#wan_netmask').html(config_val('igdWanStatus_SubnetMask_'));
			$('#wan_gateway').html(config_val('igdWanStatus_DefaultGateway_'));
			$('#wan_dns1').html(config_val('igdWanStatus_PrimaryDNSAddress_'));
			$('#wan_dns2').html(config_val('igdWanStatus_SecondaryDNSAddress_'));
			$('#aftr').html(filter_ipv6_addr(config_val('igdWanStatus_DsLiteAFTR_')));
			$('#ds_dhcp').html(config_val('igdWanStatus_DsLiteDHCP_'));
		}
		$('#opendns_enable').html(
			(config_val('igdWanStatus_AdvancedDNSEnable_') == '0'? get_words('_disabled'): get_words('_enabled'))
		);
		
		// LAN
		$('#lan_mac').html(config_val('igdLanStatus_MACAddress_'));
		$('#lan_ip').html(config_val('igdLanStatus_IPAddress_'));
		$('#lan_netmask').html(config_val('igdLanStatus_SubnetMask_'));
		$('#lan_dhcpd_enable').html(
			(config_val('lanHostCfg_DHCPServerEnable_') == '0'? get_words('_disabled'): get_words('_enabled'))
		);
		
		$('#ap_lan_mac').html(config_val('igdLanStatus_MACAddress_'));
		$('#ap_lan_ip').html(config_val('lanHostCfg_APIPAddress_'));
		$('#ap_lan_netmask').html(config_val('lanHostCfg_APSubnetMask_'));
		$('#ap_lan_gw').html(config_val('lanHostCfg_APGateway_'));
		$('#ap_lan_dns1').html(config_val('lanHostCfg_APPrimaryDNSAddress_'));
		$('#ap_lan_dns2').html(config_val('lanHostCfg_APSecondaryDNSAddress_'));
		
		// WLAN
		var wifiCfg = 
		{
			'enable': 		config_str_multi("igdWlanStatus_WlanEnable_"),
			'wlanMac': 		config_str_multi("igdWlanStatus_WlanMAC_"),
			'ssid':			config_str_multi("lanWlanCfg_SSID_"),
			'standard':		config_str_multi("lanWlanCfg_Standard_"),
			'standard5G':	config_str_multi("lanWlanCfg_Standard5G_"),
			'channelWidth':	config_str_multi("lanWlanCfg_ChannelWidth_"),
			'channellan':	config_str_multi("lanWlanCfg_Channel_"),
			'channel':		config_str_multi("igdWlanStatus_Channel_"),
			'security':		config_str_multi("lanWlanCfg_SecurityMode_")
		};
		
		var wepCfg = 
		{
			'keyLength':	config_str_multi("wepInfo_KeyLength_"),
			'authType':		config_str_multi("wepInfo_AuthenticationMode_")
		};

		var wpaCfg = 
		{
			'wpamode' :		config_str_multi("wpaInfo_WPAMode_"),
			'wpacipher' :   config_str_multi("wpaInfo_EncryptionMode_")
		};

		var wps_enable = config_str_multi('wpsCfg_Enable_');
		var wps_config = config_str_multi('wpsCfg_Status_');

		// 2011.11.05 silvia add 5G

		for (var i=0;i<4;i++){
			var wlanEnable = wifiCfg.enable[i];
			var j = ((i==0)?0:1);
			//var wlanEnable = 1;
			if ( wlanEnable != null && wlanEnable == '1')
			{
				$('#show_wlan'+j+'_dot11_mode').show();
				$('#show_wlan'+j+'_11n_protection').show();
				$('#show_wlan'+j+'_channel').show();
				$('#show_wps_enable'+j).show();
				$('#show_ssid_lst'+j).show();
				$('#show_ssid_table'+j).show();	
				$('#show_wlan'+j).html(get_words('_enable'));
				$('#wlan'+j+'_mac').html(wifiCfg.wlanMac[i]);
				$('#wlan'+j+'_ssid').html(sp_words(wifiCfg.ssid[i]));
				//$('#wlan'+j+'_channel').html(wifiCfg.channellan[i]);
				$('#wlan'+j+'_channel').html(wifiCfg.channel[i]);
				if(wps_enable[i] == "0"){
					$('#wlan'+j+'_wps_st').html((get_words(_disabled)));
				}else{
					if(wps_config[i] != '0') {
						$('#wlan'+j+'_wps_st').html((get_words(LW66)));
					}else {
						$('#wlan'+j+'_wps_st').html((get_words(LW67)));
					}
				}

				if(wifiCfg.channelWidth[i] == "0")
					$('#wlan'+j+'_11n_prot').html('20');
				else if(wifiCfg.channelWidth[i] == "1")
					$('#wlan'+j+'_11n_prot').html('20/40');
				else if(wifiCfg.channelWidth[i] == "2")
					$('#wlan'+j+'_11n_prot').html('20/40/80');

				var security = (wifiCfg.security[i]? wifiCfg.security[i]:"0");
				switch(security)
				{
					case "1":
					{
						var keyLenStr = "";
						var authTypeStr = "";
						if(wepCfg.keyLength[i] == "0")
							keyLenStr = "64";
						else
							keyLenStr = "128";
							
/*						if(wepCfg.authType[i] == "0")
							authTypeStr = "Open";
						else if(wepCfg.authType[i] == "1")
							authTypeStr = "Share";
						else if(wepCfg.authType[i] == "2")
							authTypeStr = "Both";
*/						//$('#wlan'+j+'_security').html("wep_auto_"+keyLenStr);
						$('#wlan'+j+'_security').html(get_words('_WEP'));//+ " " +authTypeStr+" "+keyLenStr);
					}
					break;
					case "2":
						//$('#wlan'+j+'_security').html(get_words('_WPApersonal'));
						var wpamode = "";
						//var ciphermode = "";
						if(wpaCfg.wpamode[i] == "0")
							//wpamode = get_words('bws_WPAM_2') + " - PSK";
							wpamode = get_words('bws_WPAM_2');
						else if(wpaCfg.wpamode[i] == "1")
							//wpamode = 'wpa2_psk';
							wpamode = get_words('bws_WPAM_3');
						else
							//wpamode = 'wpa_psk';
							wpamode = get_words('bws_WPAM_1');
/*						if(wpaCfg.wpacipher[i] == "0")
							ciphermode = get_words('bws_CT_1');
						else if(wpaCfg.wpacipher[i] == "1")
							ciphermode = get_words('bws_CT_2');
						else
							ciphermode = get_words('bws_CT_3');
*/						//$('#wlan'+j+'_security').html(wpamode);
						$('#wlan'+j+'_security').html(wpamode+ " - PSK"); //+ " / " + ciphermode);
					break;
					case "3":
						//$('#wlan'+j+'_security').html(get_words('_WPAenterprise'));
					var wpamode = "";
					//var ciphermode = "";
					if(wpaCfg.wpamode[i] == "0")
						wpamode = get_words('bws_WPAM_2'); //+ " - EAP";
					else if(wpaCfg.wpamode[i] == "1")
						//wpamode = 'wpa2_eap';
						wpamode = get_words('bws_WPAM_3');
					else
						//wpamode = 'wpa_eap';
						wpamode = get_words('bws_WPAM_1');
/*					if(wpaCfg.wpacipher[i] == "0")
						ciphermode = get_words('bws_CT_1');
					else if(wpaCfg.wpacipher[i] == "1")
						ciphermode = get_words('bws_CT_2');
					else
						ciphermode = get_words('bws_CT_3');
*/					$('#wlan'+j+'_security').html(wpamode+ " - EAP"); //+ "/" + ciphermode);
					//$('#wlan'+j+'_security').html(wpamode);
					break;
					case "0":
					default:
						$('#wlan'+j+'_security').html(get_words('_disable_s'));
					break;
				}

				var wlanMode = wifiCfg.standard[0];
				switch(wlanMode)
				{
					case "0":
						$('#wlan_mode').html(get_words('bwl_Mode_1'));
						break;
					case "1":
						$('#wlan_mode').html(get_words('bwl_Mode_2'));
						break;
					case "2":
						$('#wlan_mode').html(get_words('bwl_Mode_8'));
						break;
					case "3":
						$('#wlan_mode').html(get_words('bwl_Mode_3'));
						break;
					case "4":
						$('#wlan_mode').html(get_words('bwl_Mode_10'));
						break;
					case "5":
						$('#wlan_mode').html(get_words('bwl_Mode_11'));
						break;
				}
			
				var wlanMode1 = wifiCfg.standard5G[2];
				switch(wlanMode1)
				{
					case "0":
						$('#wlan1_mode').html(get_words('bwl_Mode_n'));
						break;
					case "1":
						$('#wlan1_mode').html(get_words('bwl_Mode_a'));
						break;
					case "2":
						$('#wlan1_mode').html(get_words('bwl_Mode_5'));
						break;
					case "3":
						$('#wlan1_mode').html(get_words('bwl_Mode_acna'));
						break;
					case "4":
						$('#wlan1_mode').html(get_words('bwl_Mode_acn'));
						break;
					case "5":
						$('#wlan1_mode').html(get_words('bwl_Mode_ac'));
						break;
				}

				i+=1;
				var wlanEnableGz = wifiCfg.enable[i];
				if(wlanEnableGz == "1")
				{
					$('#wlan'+j+'_mac_gz').html(wifiCfg.wlanMac[i]);
					$('#wlan'+j+'_ssid_gz').html(sp_words(wifiCfg.ssid[i])); 
					var securityGz = (wifiCfg.security[i]? wifiCfg.security[i]:"0");
					switch(securityGz)
					{
						case "1":
						{
							var keyLenStr = "";
							var authTypeStr = "";
							if(wepCfg.keyLength[i] == "0")
								keyLenStr = "64";
							else
								keyLenStr = "128";

/*							if(wepCfg.authType[i] == "0")
								authTypeStr = "Open";
							else if(wepCfg.authType[i] == "1")
								authTypeStr = "Share";
							else if(wepCfg.authType[i] == "2")
								authTypeStr = "Both";
*/						$('#wlan'+j+'_security_gz').html(get_words('_WEP'));//+ " " +authTypeStr+" "+keyLenStr);
						//$('#wlan'+j+'_security_gz').html("wep_auto_"+keyLenStr);
						}
						break;
						case "2":
							var wpamode = "";
							if(wpaCfg.wpamode[i] == "0")
								wpamode = get_words('bws_WPAM_2');//+ "-PSK";
							else if(wpaCfg.wpamode[i] == "1")
								//wpamode = 'wpa2_psk';
								wpamode = get_words('bws_WPAM_3');
							else
								//wpamode = 'wpa_psk';
								wpamode = get_words('bws_WPAM_1');
							$('#wlan'+j+'_security_gz').html(wpamode+ " - PSK");
						break;
						case "3":
							var wpamode = "";
							if(wpaCfg.wpamode[i] == "0")
								wpamode = get_words('bws_WPAM_2');//+ "-EAP";
							else if(wpaCfg.wpamode[i] == "1")
								//wpamode = 'wpa2_eap';
								wpamode = get_words('bws_WPAM_3');
							else
								//wpamode = 'wpa_eap';
								wpamode = get_words('bws_WPAM_1');
						$('#wlan'+j+'_security_gz').html(wpamode+ " - EAP");
						break;
						case "0":
						default:
							$('#wlan'+j+'_security_gz').html(get_words('_disable_s'));
						break;
					}
					$('#gz_row'+j).show();
				}
				else
					$('#gz_row'+j).hide();
			}
			else
			{
				i+=1;
				$('#show_wlan'+j).html(get_words('_off'));
				$('#show_wlan'+j+'_dot11_mode').hide();
				$('#show_wlan'+j+'_11n_protection').hide();
				$('#show_wlan'+j+'_channel').hide();
				$('#show_wps_enable'+j).hide();
				$('#show_ssid_lst'+j).hide();
				$('#show_ssid_table'+j).hide();	
				// end of silvia add
			}
		}
		set_control_button();
		set_mac_info();
		set_igmp_info();
		set_dslite();
		var end_time = new Date();
		end_time= end_time.getTime();
		var cal_time = (end_time-start_time)/1000 ;
		if (cal_time<=3)
			setTimeout("getDeviceStatus()",3000);
		else
			setTimeout("getDeviceStatus()",cal_time*1000);
	}
	
	function set_dslite()
	{
		var wan_type = config_val("igdWanStatus_WanProto_");
		if(wan_type == "10")
		{
			
			$('#tr_wan_ip').hide();
			$('#tr_wan_netmask').hide();
			$('#tr_wan_gateway').hide();
			$('#tr_wan_dns1').hide();
			$('#tr_wan_dns2').hide();
			$('#tr_wan_ip').hide();
			$('#tr_opendns_enable').hide();
			$('#ctrl_buttons').hide();
				
		}else
		{
			$('#tr_aftr').hide();
			$('#tr_ds_dhcp').hide();
		}
	}
	function set_control_button()
	{
		var wan_type = config_val("igdWanStatus_WanProto_");
		var button_position = $('#show_button')[0];
		if(wan_type != "0")
		{
			var commonAction1 = "do_connect()";
			var commonAction2 = "do_disconnect()";

			var button1_name = get_words("_connect");
			var button2_name = get_words("LS315");
			var button1_action = commonAction1;
			var button2_action = commonAction2;

			if(wan_type=="1"){
				button1_name = get_words("LS312");	
				button2_name = get_words("LS313");
			}

			$("#ctrl_buttons").html("<input type=\"button\" value=\""+button1_name+"\" name=\"connect\" id=\"connect\" onClick=\""+button1_action+"\">&nbsp;<input type=\"button\" value=\""+button2_name+"\" name=\"disconnect\" id=\"disconnect\" onClick=\""+button2_action+"\"></td>");
			if(dev_info.login_info == "w")
			{
				if(config_val("igdWanStatus_CableStatus_") == 'Connected')
				{
					var conn_st = config_val("igdWanStatus_NetworkStatus_");
					if(conn_st == "Disconnected")
					{
						$('#network_status').html(get_words('DISCONNECTED'));
						$("#connect").attr("disabled",false);
						$("#disconnect").attr("disabled",true);
					}
					else if(conn_st == "Connected")
					{
						$('#network_status').html(get_words('CONNECTED'));
						$("#connect").attr("disabled",true);
						$("#disconnect").attr("disabled",false);
					}
					else if(conn_st == "Connecting"){
						$("#network_status").html(get_words('ddns_connecting'));
						$("#disconnect").attr("disabled",false);
						$("#connect").attr("disabled",true);
					}
					else if(conn_st == "Disconnecting"){
						$("#network_status").html(get_words('ddns_disconnecting'));
						$("#disconnect").attr("disabled",true);
						$("#connect").attr("disabled",true);
					}
				}
				else{
					$('#network_status').html(get_words('DISCONNECTED'));
					$("#disconnect").attr("disabled",true);
					$("#connect").attr("disabled",true);
				}
			}
			else
			{
				var conn_st = config_val("igdWanStatus_NetworkStatus_");
				if(conn_st == "Disconnected")
					$('#network_status').html(get_words('DISCONNECTED'));
				else
					$('#network_status').html(get_words('CONNECTED'));
				$("#connect").attr("disabled",true);
				$("#disconnect").attr("disabled",true);
			}
		}
		else
		{
			var conn_st = config_val("igdWanStatus_NetworkStatus_");
			if(conn_st == "Disconnected")
				$('#network_status').html(get_words('DISCONNECTED'));
			else
				$('#network_status').html(get_words('CONNECTED'));
		}
	}

	function do_connect()
	{
		proc_st = true;
		//$("#network_status").html(get_words('ddns_connecting'));
		$("#connect").attr("disabled",true);
		$("#disconnect").attr("disabled",false);
		var paramConnect = {
			url: "get_set.ccp",
			arg: "ccp_act=doEvent&ccpSubEvent=CCP_SUB_DOWANCONNECT"
		};
		get_config_obj(paramConnect);
	}

	function do_disconnect()
	{
		//proc_st = false;
		//$("#network_status").html(get_words('ddns_disconnecting'));
		$("#disconnect").attr("disabled",true);
		$("#connect").attr("disabled",true);
		var paramDisconnect = {
			url: "get_set.ccp",
			arg: "ccp_act=doEvent&ccpSubEvent=CCP_SUB_DOWANDISCONNECT"
		};
		get_config_obj(paramDisconnect);
	}
</script>
<title>D-Link公司 | 无线路由器 | 主页</title>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
		
		</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div id="sidenavoff"><script>show_words(_devinfo)</script></div></li>
									<li><div><a href="st_log.asp"><script>show_words(_logs)</script></a></div></li>
									<li><div><a href="st_stats.asp"><script>show_words(_stats)</script></a></div></li>
									<li><div><a href="internet_sessions.asp"><script>show_words(YM157)</script></a></div></li>
									<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
									<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
									<li><div><a href="st_routing6.asp"><script>show_words(v6_routing)</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  	<div id="box_header"> 
						<h1><script>show_words(sd_title_Dev_Info)</script></h1>
						<script>show_words(sd_intro)</script>
						<br><br>
				  	</div>
				  	<div class="box">
						<h2><script>show_words(sd_General)</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td class="duple"><script>show_words(_time)</script> : </td>
								<td width="340"><span id="show_time"></span></td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(sd_FWV)</script> :</td>
								<td width="340">&nbsp;<strong><script>document.write(dev_info.fw_ver);</script> , <script>document.write(dev_info.ver_date);</script></strong></td>
							</tr>
							<tr>
								<td class="duple"><script>show_words(mydlink_srv)</script> : </td>
								<td width="340">&nbsp;<strong><span id='mdl_st'><span></strong></td>
							</tr>
							<tr id="myaccount" style="display:none">
								<td class="duple"><script>show_words(mydlink_acc)</script> : </td>
								<td width="340">&nbsp;<strong><span id='mdl_acc'><span></strong></td>
							</tr>
						</table>
				  	</div>
					<div class="box" id="st_wan"> 
						<h2><script>show_words(_WAN)</script></h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
							  	<tr>
                                  <td class="duple"><script>show_words(_contype)</script> :</td>
                                  <td width="340">&nbsp; 
								  <span id="connection_type"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple"><script>show_words(_cablestate)</script> :</td>
                                  <td width="340">&nbsp;
								  <span id="cable_status"></span>
								   </td>
							    </tr>
								<tr>
                                  <td class="duple"><script>show_words(_networkstate)</script> :</td>
                                  <td width="340">&nbsp;
								  <span id="network_status"></span>&nbsp;<span id="ctrl_buttons"></span>
								   </td>
							    </tr>
								<tr>
                                  <td class="duple"><script>show_words(_conuptime)</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<span id="show_uptime"></span></td>
							    </tr>
								<tr id="net_status" style="display:none">
                                  <td class="duple">&nbsp;</td>
                                  <td width="340">&nbsp;&nbsp;<span id="show_button"></span></td>
							    </tr>
								<tr>
                                  <td class="duple"><script>show_words(_macaddr)</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<span id="show_mac"></span></td>
							    </tr>
								<tr id=tr_wan_ip>
                                  <td class="duple"><script>show_words(_ipaddr)</script> :</td>
                                  <td width="340">&nbsp; 
								  <span id="wan_ip"></span>
								  </td>
							  	</tr>
								<tr id=tr_wan_netmask>
                                  <td class="duple"><script>show_words(_subnet)</script> :</td>
                                  <td width="340">&nbsp;  
								  <span id="wan_netmask"></span>
								  </td>
							  	</tr>
								<tr id=tr_wan_gateway>
                                  <td class="duple"><script>show_words(_defgw)</script> :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_gateway"></span>
								  </td>
							  	</tr>
								<tr id=tr_wan_dns1>
                                  <td class="duple"><script>show_words(_dns1)</script> :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_dns1"></span>
								  </td>
							  	</tr>
								<tr id=tr_wan_dns2>
                                  <td class="duple"><script>show_words(_dns2)</script> :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_dns2"></span>
								  </td>
								<!--//2009/4/29 Tina add OPENDNS-->
								<tr id="tr_opendns_enable" style="display:none">
								  <td class="duple"><script>show_words(_st_AdvDns);</script> :</td>
								  <td width="340">&nbsp;
								  <span id="opendns_enable"></span>
								</tr>
								<!--//OPENDNS-->								  
								<tr id=tr_aftr>
									 <td class="duple"><script>show_words(IPV6_TEXT160);</script> :</td>
									 <td width="340">&nbsp;
								  <span id="aftr"></span>
								</tr>
								<tr id=tr_ds_dhcp>
									<td class="duple"><script>show_words(IPV6_TEXT150);</script> :</td>
									<td width="340">&nbsp;
								  <span id="ds_dhcp"></span>
							  </tr>
								</tr>								  
							  	</tr>
							</table>
					</div>
					<div class="box" id="st_router_lan"> 
						<h2><script>show_words(_LAN)</script></h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
                                  <td class="duple"><script>show_words(_macaddr)</script> :</td>
                                  <td width="340">&nbsp; <span id="lan_mac"></span> </td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_ipaddr)</script> :</td>
                                  <td width="340">&nbsp; <span id="lan_ip"></span></td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_subnet)</script> :</td>
                                  <td width="340">&nbsp; <span id="lan_netmask"></span></td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_dhcpsrv)</script> :</td>
                                  <td width="340">&nbsp; <span id="lan_dhcpd_enable"></span></td>
							  </tr>
							</table>
					</div>
					
					<div class="box" id="st_ap_lan"> 
						<h2><script>show_words(_LAN)</script></h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
                                  <td class="duple"><script>show_words(_macaddr)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_mac"></span> </td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_ipaddr)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_ip"></span></td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_subnet)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_netmask"></span></td>
							  </tr>
								<tr>
                                  <td class="duple"><script>show_words(_defgw)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_gw"></span></td>
							  </tr>
							  <tr>
                                  <td class="duple"><script>show_words(_dns1)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_dns1"></span></td>
							  </tr>
							  <tr>
                                  <td class="duple"><script>show_words(_dns2)</script> :</td>
                                  <td width="340">&nbsp; <span id="ap_lan_dns2"></span></td>
							  </tr>
							</table>
					</div>
					
					<div class="box"> 
						<h2><script>show_words(sd_WLAN)</script></h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr> 
									<td class="duple"><script>show_words(wwl_band)</script> :</td>
									<td>&nbsp; <script>show_words(GW_WLAN_RADIO_0_NAME)</script></td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(sd_WRadio)</script> :</td>
									<td width="340">&nbsp; <span id="show_wlan0"></span>
									</td>
								</tr>
								<tr id="show_wlan0_dot11_mode">
									<td class="duple"><script>show_words(bwl_Mode)</script> :</td>
									<td width="340">&nbsp; <span id="wlan_mode"></span></td>
								</tr>
								<tr id="show_wlan0_11n_protection">
									<td class="duple"><script>show_words(bwl_CWM)</script> :</td>
									<td width="340">&nbsp; <span id="wlan0_11n_prot"></span> MHz</td>
								</tr>
								<tr id="show_wlan0_channel">
									<td class="duple"><script>show_words(sd_channel)</script> :</td>
									<td width="340">&nbsp; <span id="wlan0_channel"></span></td>
								</tr>
								<tr id="show_wps_enable0">
									<td class="duple"><script>show_words(LY2)</script> :</td>
									<td width="340">&nbsp; <span id="wlan0_wps_st"></span></td>
								</tr>
								<tr id="show_ssid_lst0">
									<td class="duple"><b><script>show_words(ssid_lst)</script> :</b></td>
									<td width="340">&nbsp;</td>
								</tr>
								
								<!--start of show ssid table-->
							
								<tr id="show_ssid_table0">
									<td colspan="2" class="duple">
										<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1 style="word-break:break-all;">
										<tr>
											<td width="185"><b><script>show_words(sd_NNSSID)</script></b></td>
											<td width="50"><b><script>show_words(guest)</script></b></td>
											<td width="130"><b><script>show_words(_macaddr)</script></b></td>
											<td width="160"><b><script>show_words(bws_SM)</script></b></td>
										</tr>
										<tr>
											<td width="123"><span id="wlan0_ssid"></span></td></td>
											<td width="47">&nbsp;<script>show_words(_no)</script></td>
											<td width="128"><span id="wlan0_mac"></span></td>
											<td width="196"><span id="wlan0_security"></span>
											</td>
										</tr>
										
										<tr id="gz_row0" style="display:none">
											<td width="123"><span id="wlan0_ssid_gz"></span></td></td>
											<td width="47">&nbsp;<script>show_words(_yes)</script></td>
											<td width="128"><span id="wlan0_mac_gz"></span></td>
											<td width="196"><span id="wlan0_security_gz"></span></td>
										</tr>
										</table>
									</td>
								</tr>								
							<!--end of show ssid table-->
								
							</table>
					</div>
					
					<div class="box">
						<h2><script>show_words(sd_WLAN)</script>2</h2>
						<table width="525" border="0" cellpadding="1" cellspacing="1">
						<tr> 
							<td class="duple"><script>show_words(wwl_band)</script> :</td>
							<td>&nbsp; <script>show_words(GW_WLAN_RADIO_1_NAME)</script></td>
						</tr>
						<tr> 
							<td class="duple"><script>show_words(sd_WRadio)</script> :</td>
							<td width="340">&nbsp; <span id="show_wlan1"></span></td>
						</tr>
						<tr id="show_wlan1_dot11_mode">
							<td class="duple"><script>show_words(bwl_Mode)</script> :</td>
							<td width="340">&nbsp; <span id="wlan1_mode"></span></td>
						</tr>
						<tr id="show_wlan1_11n_protection">
							<td class="duple"><script>show_words(bwl_CWM)</script> :</td>
							<td width="340">&nbsp; <span id="wlan1_11n_prot"></span> MHz</td>
						</tr>
						<tr id="show_wlan1_channel">
							<td class="duple"><script>show_words(_channel)</script> :</td>
							<td width="340">&nbsp; <span id="wlan1_channel"></span> </td>
						</tr>
						<tr id="show_wps_enable1">
							<td class="duple"><script>show_words(LY2)</script> :</td>
							<td width="340">&nbsp; <span id="wlan1_wps_st"></span></td>
						</tr>
						<tr id="show_ssid_lst1">
							<td class="duple"><script>show_words(ssid_lst)</script> :</td>
							<td width="340">&nbsp; </td>
						</tr>
						<tr id="show_ssid_table1"> 
							<td colspan="2" class="duple">
							<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1 style="word-break:break-all;">
								<tr> 
									<td width="185"><b><script>show_words(sd_NNSSID)</script></b></td>
									<td width="50"><b><script>show_words(guest)</script></b></td>
									<td width="130"><b><script>show_words(_macaddr)</script></b></td>
									<td width="160"><b><script>show_words(bws_SM)</script></b></td>
								</tr>
								<tr>
									<td width="123"><span id="wlan1_ssid"></span></td></td>
									<td width="47">&nbsp;<script>show_words(_no)</script></td>
									<td width="128"><span id="wlan1_mac"></span></td>
									<td width="196"><span id="wlan1_security"></span>
								</tr>
								<tr id="gz_row1" style="display:none">
									<td width="123"><span id="wlan1_ssid_gz"></span></td></td>
									<td width="47">&nbsp;<script>show_words(_yes)</script></td>
									<td width="128"><span id="wlan1_mac_gz"></span></td>
									<td width="196"><span id="wlan1_security_gz"></span></td>
								</tr>
							</table></td>
						</tr>
						</table>
					</div>

					  <div class="box">
						  <h2><script>show_words(_LANComputers)</script></h2>
								<span id="lanInfo"></span>
					  </div>
					  <div class="box" id="st_igmp">
						  <h2><script>show_words(_bln_title_IGMPMemberships)</script></h2>
								<span id="igmpInfo"></span>
					  </div>
					  
					  <div id="renew_result" name="renew_result" style="display:none">
							  <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#ffffff border=1>
								<tr><td>
										<IFRAME id="iframe_result" name="iframe_result" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no"></IFRAME>
									</td></tr>
							  </table>
					  </div>
					<!-- === END MAINCONTENT === -->
				</div>				
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
					  	<strong><script>show_words(_hints)</script>&hellip;</strong>
					  	<p><script>show_words(hhsd_intro)</script></p>
						<p><a href="support_status.asp#Device_Info"><script>show_words(_more)</script>&hellip;</a></p>
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
	</table></form>
<form id="form2" name="form2" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = which_lang[ddns_connecting];</script></form>
<form id="form3" name="form3" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form4" name="form4" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = which_lang[ddns_connecting];</script></form>
<form id="form5" name="form5" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form6" name="form6" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = which_lang[ddns_connecting];</script></form>
<form id="form7" name="form7" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form8" name="form8" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = which_lang[ddns_connecting];</script></form>
<form id="form9" name="form9" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form10" name="form10" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = which_lang[ddns_connecting];</script></form>
<form id="form11" name="form11" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	getDeviceStatus();
	WTime();
	STime();
</script>
</html>
