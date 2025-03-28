﻿var uciAppInfo =
{
	fileName:		"app_info",

	secType:
	{
		app :		"app"
	},
	optName:
	{
		installed:	"installed"
	},
	listName :
	{
		depends:	"depends",
		init:		"init"
	},
	optValue:
	{
		installed:
		{
			yes:	"1",
			no:	"0"
		}
	},
	dynData:
	{
		appInfo:	"app_info"
	},
	dynOptName:
	{
		id:		"id",
		name:		"name",
		version:	"version",
		desc:		"desc",
		icon:		"icon",
		installed:	"installed"
	},
	dynOptValue:
	{
		installed:
		{
			yes: 	1,
			no: 	0
		}
	},
	actionName: {
		install:	"install_app",
		uninstall:	"uninstall_app"
	}
};

var uciNetwork =
{
	fileName:	"network",
	secType:
	{
		iface:		"interface",
		user_route:	"user_route",
		sys_route:	"sys_route"
	},
	secName:
	{
		lan:		"lan",
		wan:		"wan",

		/*IPv6*/
		lanv6:		"lanv6",
		wanv6:		"wanv6",
		ipv6SwitchStatus:	"ipv6_switch_status"
	},
	optName:
	{
		ifName:		"ifname",
		proto:		"proto",
		ip:		"ipaddr",
		pppoeUsr:	"username",
		pppoePass:	"password",
		netmask:	"netmask",
		ipMode:		"ip_mode",
		gateway:	"gateway",
		dns:		"dns",
		priDns:		"pri_dns",
		sndDns:		"snd_dns",
		mtu:		"mtu",
		speed:		"speed_duplex",
		mac:		"macaddr",
		facMac:		"fac_macaddr",
		target:		"target",
		iface:		"interface",
		facIp:		"fac_ipaddr",
		phyStatus:	"phy_status",
		wanStatus:	"link_status",
		code:		"error_code",
		upSpeed:	"up_speed",
		downSpeed:	"down_speed",
		enable: 	"enable",
		status:		"status",
		operate: 	"operate",

		/* IPv6 */
		ipv6: "ip6addr",
		gatewayv6: "ip6gw",
		prefix: "prefix",
		prefixLen: "prefixLen",
		sharev4: "sharev4",
		ipv6Local: "local_ip6addr"
	},
	optValue:
	{
		proto:
		{
			dynIp:"dhcp",
			staticIp:"static",
			pppoe:"pppoe",

			/* IPv6 Wan */
			dynIpv6:"dhcpcv6",
			staticIpv6:"staticv6",
			pppoev6:"pppoev6",
			bridgeIpv6:"bridgev6",

			/* IPv6 Lan */
			dhcpsv6:"dhcpsv6",
			slaac:"slaac",
			rdnss:"rdnss",

			none:"none"
		},
		operate:{
			release: "release",
			renew: "renew",
			connect: "connect",
			disconnect: "disconnect"
		},
		ifname:
		{
			wan:"eth0",
			lan:"br-lan",
			host:"host",
			factory:"factory"
		},
		ipMode:
		{
			dynamic:	"dynamic",
			manual:		"manual"
		},
		DFT_LAN_IP:["192.168.1.1", "192.168.0.1"],
		ipv6SwitchStatus:{
			success: "0",
			switching:	"1",
			fail:	"2"
		},
		ipv6LanProto:{
			dhcp: "dhcpsv6",
			slaac: "slaac",
			rdnss: "rdnss"
		}
	},
	dynData:
	{
		wanStatus:	"wan_status",
		wanProto:	"wan_proto",
		ifaceMac:	"iface_mac",
		bridgestatus: "bridge_status",

		/* IPv6 */
		lanv6Status: "lanv6_status",
		wanv6Status: "wanv6_status"
	},
	action:
	{
		changeWanStatus: "change_wan_status",
		changeWanv6Status: "change_wanv6_status",
		wanDetect:	"detect_wan_proto"
	}
};

var uciProto =
{
	fileName:		"protocol",
	secType:
	{
		iface:		"interface",
		proto:		"proto"
	},
	secName:
	{
		wan:		"wan",
		dhcp:		"dhcp",
		sta:		"static",
		pppoe:		"pppoe",
		bridge:		"bridge",

		/* IPv6 */
		wanv6:		"wanv6",
		lanv6:		"lanv6",
		dhcpv6:		"dhcpcv6",
		stav6:		"staticv6",
		pppoev6:	"pppoev6",
		bridgev6:	"bridgev6",
		ipv6Info:	"ipv6_info",
		dhcpsv6:	"dhcpsv6"
	},
	optName:
	{
		type:		"wan_type",
		rate:		"wan_rate",
		proto:		"proto",
		ip:		"ipaddr",
		pppoeUsr:	"username",
		pppoePwd:	"password",
		netmask:	"netmask",
		gateway:	"gateway",
		dnsMode:	"dns_mode",
		priDns:		"pri_dns",
		sndDns:		"snd_dns",
		mtu:		"mtu",
		speed:		"wan_rate",
		dialMode:	"dial_mode",
		connMode:	"conn_mode",
		demand:		"demand_idle",
		manual:		"manual_idle",
		ipMode:		"ip_mode",
		ISPIp:		"specific_ip",
		connect:	"connect",
		hostName:	"hostname",
		acName:		"access",
		broadcast:	"broadcast",
		broadcast_en:	"enable_broadcast",
		svcName:	"server",
		facMac:		"fac_macaddr",
		macaddr:	"macaddr",
		enable:		"enable",

		/* IPv6 */
		ipConfig: "ip_config",
		pdMode: "pd_mode",
		sharev4: "sharev4",
		specIp: "specific_ip",
		ipv6: "ip6addr",
		gatewayv6: "ip6gw",
		prefix: "prefix",
		prefixLen: "prefixLen",
		leaseTime:	"lease_time",
		startIp: "start_ip",
		endIp: "end_ip"
	},
	optValue:
	{
		proto:
		{
			none:"none",
			dynIp:"dhcp",
			staticIp:"static",
			pppoe:"pppoe",
			bridge:"bridge",

			/* IPv6 */
			dynIpv6:"dhcpcv6",
			staticIpv6:"staticv6",
			pppoev6:"pppoev6",
			bridgev6:"bridgev6",
			dynsIpv6:"dhcpsv6"
		},
		wanSpeed:["auto", "10F", "10H", "100F", "100H", "1000F"],
		dnsMode:
		{
			dynamic:	"dynamic",
			manual:		"manual"
		},
		connMode:
		{
			auto:		"auto",
			demand:		"demand",
			manual:		"manual"
		},
		ispMode:
		{
			dhcp:		"dynamic",
			sta:		"static"
		},
		diagMode:
		{
			auto:		"auto",
			normal:		"normal",
			special1:	"special1",
			special2:	"special2",
			special3:	"special3",
			special4:	"special4",
			special5:	"special5",
			special6:	"special6",
			special7:	"special7"
		},
		ipv6Enable:
		{
			on:  "on",
			off:	"off"
		},
		ipv6Allot:
		{
			auto:	"auto",
			dhcpv6:	"dhcpv6",
			slaac:	"slaac",
			static:	"static"
		},
		ipv6Prefix:
		{
			nonTemp:	"non_temp",
			prefix:		"prefix"
		}
	},
	action:
	{
		switchIpv6: "switch_ipv6"
	}
};

var uciMs =
{
	fileName:		"media_server",
	secType:
	{
		share:		"ms_dir"
	},
	secName:
	{
		user:		"user",
		sys:		"sys"
	},
	optName:
	{
		svrName:	"name",
		enableMs:	"enable",
		autoScan:	"auto_scan",
		interval:	"scan_interval",
		shrName:	"display_name",
		dir:		"directory"
	}
};

var uciDhcpd =
{
	fileName:		"dhcpd",
	secName:
	{
		udhcpd:		"udhcpd"
	},
	optName:
	{
		enable:		"enable",
		poolStart:	"pool_start",
		poolEnd:	"pool_end",
		leaseTime:	"lease_time",
		leaseFile:	"lease_file",
		gateway:	"gateway",
		priDns:		"pri_dns",
		sndDns:		"snd_dns",
		hostName:	"hostname",
		mac:		"mac",
		ip:		"ip",
		expires:	"expires",
		auto:	"auto"
	},
	dynData:
	{
		dhcpClient:	"dhcp_clients"
	}
};

var uciArp =
{
	fileName:		"ip_mac_bind",
	secType:
	{
		arp:		"user_bind"
	},
	optName:
	{
		ipAddr:		"ip",
		mac:		"mac",
		status:		"status",
		hostname:	"hostname"
	},
	dynData:
	{
		sysArp:		"sys_arp"
	}
};

var uciGuestNet =
{
	fileName:		"guest_network",
	secType:
	{
		guest:		"guest"
	},
	secName:
	{
		wireless2G:	"guest_2g",
		wireless5G:	"guest_5g",
		dynEncrypt2G: "dynamic_encrypt_2g"
	},
	optName:
	{
		enable:		"enable",
		ssid:		"ssid",
		encrypt:	"encrypt",
		key:		"key",
		accright:	"accright",
		upload:		"upload",
		download:	"download",
		timelimit:	"time_limit",
		duration:	"duration",
		timetype:	"limit_type",
		ifname:		"ifname",
		mon:		"mon",
		tue:		"tue",
		wed:		"wed",
		thu:		"thu",
		fri:		"fri",
		sat:		"sat",
		sun:		"sun",
		updateMode: "update_mode",
		name:		"name",
		startTime:	"start_time",
		endTime:	"end_time",
		timeLeft:	"time_left"
	},
	optValue:
	{
		timetype:
		{
			timeout:	"timeout",
			schedule:	"schedule"
		},
		enable:
		{
			yes: "1",
			no: "0"
		}
	},
	dynData:
	{
		timeLeft2G:	"guest_left_2g",
		timeLeft5G:	"guest_left_5g",
		guestRule2G: "guest_rule_2g",
		guestRule5G: "guest_rule_5g"
	}
};

var uciUpnp =
{
	fileName:		"upnpd",
	secType:
	{
		upnpd:		"upnpd"
	},
	secName:
	{
		upnpCfg:	"config"
	},
	optName:
	{
		uatPmp:		"enable_natpmp",
		upnp:		"enable_upnp"
	},
	dynData:
	{
		upnpLease:	"upnp_lease"
	}
};

var uciDdns =
{
	fileName:		"ddns",
	secType:
	{
		ddns:		"ddns"
	},
	secName:
	{
		phDdns:		"phddns"
	},
	optName:
	{
		autologin:	"auto_login",
		username:	"username",
		password:	 "password"
	},
	dynData:
	{
		ddnsStatus:	"ddns_status"
	}
};

var uciWireless =
{
	fileName:		"wireless",
	secType:
	{
		wifiDevice:	"wifi-device",
		wifiIface:	"wifi-iface",
		wifiFreq:	"wifi-freq"
	},
	secName:
	{
		wifiDev0:	"wifi0",
		wifiIf0:	"ath0",
		wifiDev1:	"wifi1",
		wifiIf1:	"ath1",
		wdscli0:	"wdscli0",
		wdscli1:	"wdscli1",
		freq0:		"freq0",
		freq1:		"freq1",
		wlanBS:		"wlan_bs"
	},
	optName:
	{
		channel:	"channel",
		disabled:	"disabled",
		txPwr:		"txpower",
		country:	"country",
		wifiMode:	"mode",
		ssid:		"ssid",
		keyType:	"encryption",
		key:		"key",
		hidden:		"hidden",
		wmm:		"wmm",
		apIsolate:	"isolate",
		bssid:		"bssid",
		beaconInterval:	"beacon_int",
		hwmode:		"hwmode",
		htmode:		"htmode",
		freqenable:	"freqenable",
		wdsenable:	"wdsenable",
		device:		"device",
		network:	"network",
		ifname:		"ifname",
		type:		"type",
		macaddr:	"macaddr",
		wds:		"wds",
		enable :    "enable",
		bsEnable:		"bs_enable",
		wifiEnable:		"wifi_enable",
		auth: 		"auth",
		cipher:		"cipher",
		assocThreshold: "assoc_threshold",
		kickThreshold: "kick_threshold",
		weakKick:	"weak_kick",
		weakForbidAssoc: "weak_forbid_assoc",
		twt:		"twt",
		ofdma:		"ofdma"
	},
	optValue:
	{
		keyType:
		{
			none:		"none",
			psk:		"psk",
			psk2:		"psk2",
			pskMixed:	"mixed-psk",
			tkip:		"tkip",
			ccmp:		"ccmp"
		},
		wifiMode:
		{
			ap:		"ap"
		},
		wifiSwitch:
		{
			on:		"1",
			off:	"0"
		},
		hwMode:
		{
			auto:		"auto",
			mode11b:	"11b",
			mode11g:	"11g",
			mode11n:	"11n",
			mode11bg:	"11bg",
			mode11bgn:	"11ng",
			mode11an:	"11na",
			mode11ac:	"11ac"
		},
		htMode:
		{
			auto:		"auto",
			bw20:		"HT20",
			bw40:		"HT40",
			bw80:		"HT80"
		},
		txPower:
		{
			high:		"1",
			middle:		"2",
			low:		"3"
		},
		bsEnable:
		{
			enable:		"1",
			disable:	"0"
		},
		auth:
		{
			wpaPsk: "1",
			wpa2Psk: "2",
			wpaWpa2Psk: "0"
		},
		cipher:
		{
			auto: "0",
			aes: "1",
			tkip: "2"
		},
		wps:
		{
			button: 0,
			pin: 1
		}
	},
	dynOptName:
	{
		enable:		"enable",
		ssidbrd:	"ssidbrd",
		ssid:		"ssid",
		encryption:	"encryption",
		key:		"key",
		channel:	"channel",
		mode:		"mode",
		bandwidth:	"bandwidth",
		power:		"power",
		isolate:	"isolate",
		bssid:		"bssid",
		addrform:	"address_form",
		rssi:		"rssi",
		status:		"status",
		result:		"result",
		vhtmubfer:	"vhtmubfer",
		auth: 		"auth",
		cipher:		"cipher",
		twt:		"twt",
		ofdma:		"ofdma"
	},
	dynOptValue:
	{
		enable:
		{
			off:		"0",
			on:		"1"
		},
		ssidbrd:
		{
			off:		"0",
			on:		"1"
		},
		encryption:
		{
			off:		"0",
			on:		"1"
		},
		encrypttype:
		{
			none:	"0",
			psk:	"1",
			wep:	"2",
			wpa:	"3",
			unknow:	"4"
		},
		auth:
		{
			psk:		1,
			psk2:		2,
			pskMixed:	0,
			psk2_sae3:	3,
			sae3:		4
		},
		cipher:
		{
			aes:		1,
			tkip:		2,
			auto:		0
		},
		mode:
		{
			m_11b:		"0",
			m_11g:		"1",
			m_11bg:		"2",
			m_11n:		"3",
			m_11bgn:	"4",
			m_11a:		"5",
			m_11n_5g:	"6",
			m_11an:		"7",
			m_11ac:		"8",
			m_11bgn_ax: "9",
			m_11ac_ax:  "10"
		},
		bandwidth:
		{
			auto:		"0",
			bw20:		"1",
			bw40:		"2",
			bw80:		"3"
		},
		power:
		{
			high:		"0",
			mid:		"1",
			low:		"2"
		},
		isolate:
		{
			off:		"0",
			on:		"1"
		},
		addrform:
		{
			addr3:		"0",
			addr4:		"1",
			detect:		"2"
		},
		status:
		{
			notconnect:	"0",
			connecting:	"1",
			connected:	"2"
		},
		scanStatus:
		{
			scanning:0,
			finish:1
		},
		lanIpDhcpsStatus:
		{
			detecting:0,
			finish:1
		},
		lanIpDhcpsResult:
		{
			nonConflict:0,
			conflict:1
		},
		muMimo:
		{
			off:0,
			on:1
		}
	},
	dynData:
	{
		host_2g:		"wlan_host_2g",
		wds_2g:			"wlan_wds_2g",
		scan_2g:		"wlan_scan_2g",
		scan_status_2g:	"wlan_scan_2g_status",
		wds_2g_status:	"wlan_wds_2g_status",
		host_5g:		"wlan_host_5g",
		wds_5g:			"wlan_wds_5g",
		scan_5g:		"wlan_scan_5g",
		wds_5g_status:	"wlan_wds_5g_status",
		host_5g1:		"wlan_host_5g_1",
		host_5g2:		"wlan_host_5g_4",
		wds_5g1:		"wlan_wds_5g_1",
		wds_5g2:		"wlan_wds_5g_4",
		wds_lanIp:		"wlan_wds_2g_lanip",
		wds_dhcps:		"wlan_wds_2g_dhcps",
		wifi_switch:	"wifi_switch"
	},
	actionName:
	{
		scanStart: "scanStart",
		wdsStart:  "wdsStart"
	},
	encryptionType:
	{
		none:0,
		psk2_psk:1,
		wep:2,
		wpa2_wpa:3,
		unkonw:4,
		psk2_sae3:5,
		sae3:6,
		wpa3:7
	}
};

var uciFirewall =
{
	fileName:		"firewall",
	secType:
	{
		fwRule:		"rule",
		fwRedirect:	"redirect",
		fwDMZ:		"dmz",
		parentMac: 	"parent_mac",
		parentConfig:	"parent_config",
		parentRule: "parent_control_rule",
		accessRule:	"access_rule",
		accessConfig:	"access_config",
		lanManage:	"lan_manage",
		wanManage:	"wan_manage"
	},
	secName:
	{
		inputRuleSuffix:	"Input",
		fowardRuleSuffix:	"Forward",
		lanManage:			"lan_manage",
		wanManage:			"wan_manage",
		dmz:				"dmz",
		parentConfig:		"parent_config",
		accessConfig:		"access_config"
	},
	optName:
	{
		target:			"target",
		src:			"src",
		dest:			"dest",
		proto:			"proto",
		srcMac:			"src_mac",
		srcIP:			"src_ip",
		srcIpStart:		"src_ip_start",
		srcIpEnd:		"src_ip_end",
		srcDport:		"src_dport",
		srcDportStart:	"src_dport_start",
		srcDportEnd:	"src_dport_end",
		destPort:	"dest_port",
		destPortStart:	"dst_port_start",
		destPortEnd:	"dst_port_end",
		port:			"port",
		destIP:			"dest_ip",
		destIpStart:	"dst_ip_start",
		destIpEnd:		"dst_ip_end",
		enable:			"enable",
		mon:			"mon",
		tue:			"tue",
		wed:			"wed",
		thu:			"thu",
		fri:			"fri",
		sat:			"sat",
		sun:			"sun",
		name:			"name",
		hostIndex:		"host_index",
		objIndex:		"obj_index",
		planIndex:		"plan_index",
		mode:			"mode",
		hostMode:		"host_mode",
		objMode:		"obj_mode",
		domain:			"domain",
		mac:			"mac",
		enableAll:		"enable_all"
	},
	listName:
	{
		srcMac:		"src_mac",
		domain:		"domain"
	},
	optValue:
	{
		target:
		{
			accept:		"ACCEPT",
			reject:		"REJECT",
			dnat:		"DNAT"
		},
		src:
		{
			lan:		"lan",
			wan:		"wan",
			any:		"*"
		},
		dest:
		{
			any:		"*",
			lan:		"lan"
		},
		proto:
		{
			all:		"all",
			tcp:		"tcp",
			udp:		"udp",
			both:		"tcp udp",
			icmp:		"icmp"
		},
		parentCtrl:
		{
			enable:		"1",
			disable:	"0"
		},
		dmzSwitch:
		{
			on:		"1",
			off:		"0"
		},
		bHavEnable:
		{
			enable:		"1",
			disable:	"0"
		},
		bHavFilter:
		{
			allow:		"1",
			forbid:		"0"
		},
		lanManage:
		{
			all:		"1",
			some:		"0"
		},
		wanManage:
		{
			none:		"0",
			all:		"1",
			one:		"2"
		},
		hostMode:
		{
			ip:			"0",
			mac:		"1"
		},
		objMode:
		{
			ip:			"0",
			domain:		"1"
		}
	}
};

var uciAccessCtrl =
{
	fileName:		"access_ctrl_info",
	secType:
	{
		hostRule:	"host_rule",
		objRule:	"obj_rule",
		planRule:	"plan_rule"
	},
	secName:
	{
	},
	listName:
	{
		domain:		"domain"
	},
	optName:
	{
		name:		"name",
		mode:		"mode",
		ipStart:	"ip_start",
		ipEnd:		"ip_end",
		macAddr:	"macaddr",
		portStart:	"port_start",
		portEnd:	"port_end",
		ctrlPort:	"control_port",
		proto:		"proto",
		mon:		"mon",
		tue:		"tue",
		wed:		"wed",
		thu:		"thu",
		fri:		"fri",
		sat:		"sat",
		sun:		"sun",
		domain:		"domain"
	},
	optValue:
	{
		hostMode:
		{
			ip:		"0",
			mac:		"1"
		},
		objMode:
		{
			ip:		"0",
			domain:		"1"
		},
		proto:
		{
			tcp:	"tcp",
			udp:	"udp",
			icmp:	"icmp",
			all:	"all"
		}
	}
}

var uciHostsInfo =
{
	fileName:		"hosts_info",
	secType:
	{
		device:		"device"
	},
	optName:
	{
		mac:		"mac",
		type : "type",
		blocked:	"blocked",
		isBlocked:	"is_blocked",
		downLimit:	"down_limit",
		downSpeed : "down_speed",
		upLimit:	"up_limit",
		upSpeed : "up_speed",
		ip : "ip",
		hostname : "hostname",
		isCurHost : "is_cur_host",
		ssid : "ssid",
		cfgValid : "cfg_valid",
		wifiMode : "wifi_mode",
		planRule : "plan_rule",
		name:		"name",
		mon : "mon",
		tue : "tue",
		wed : "wed",
		thu : "thu",
		fri : "fri",
		sat : "sat",
		sun : "sun",
		startTime : "start_time",
		endTime : "end_time",
		domain: "domain",
		limitTime: "limit_time",
		forbidDomain: "forbid_domain",
		forbidTime: "forbid_time",
		upLimit:	"up_limit",
		downLimit:	"down_limit",
		isBlocked:	"is_blocked"
	},
	optValue:
	{
		isBlocked:
		{
			yes:		"1",
			no:			"0"
		},
		linkType:
		{
			wired:	"0",
			hostWireless:	"1",
			guestWireless:	"2"
		},
		name:
		{
			defname:	"匿名主机"
		},
		isCurHost:
		{
			yes: true,
			no : false
		},
		cfgValid :
		{
			yes: true,
			no: false
		},
		online: {
			yes : "1",
			no : "0"
		},
		enable : {
			yes: "1",
			no : "0"
		},
		wifiMode: {
			h2G : "0",
			h5G : "1",
			h5G1 : "2",
			h5G4 : "3"
		}
	},
	dynData:
	{
		host_info:	"host_info",
		online_host:	"online_host",
		blocked_host:	"blocked_host",
		setBlockFlag : "set_block_flag",
		setName: "set_name",
		setFluxLimit: "set_flux_limit",
		limitTime: "limit_time",
		forbidDomain: "forbid_domain",
		setHostInfo:"set_host_info",
		capHostNum:"cap_host_num"
	},
	dynOptName:
	{
		mac:		"mac",
		type:		"type",
		hostName:	"hostname",
		blocked:	"blocked"
	}
};

var uciSystem =
{
	fileName:		"system",
	secType:
	{
		system:		"system"
	},
	secName:
	{
		sys:		"sys"
	},
	optName:
	{
		timezone:	"timezone",
		isFactory:  "is_factory",
		num: "num"
	},
	optValue:
	{
		timezone:
		{
			Eniwetok:		"TOT-13",
			MidwayIsland:		"SST11",
			Hawaii:			"HST10",
			Alaska:			"AKST9AKDT,M3.2.0,M11.1.0",
			PacificTime:		"PST8",
			MountainTime:		"MST7",
			CentralTime:		"CST6",
			EastTime:		"EST5",
			AtlanticTime:		"AST4",
			NewFoundLand:		"NST3:30NDT,M3.2.0/0:01,M11.1.0/0:01",
			Brasilia:		"ART3",
			MidAtlantic:		"FNT2",
			CapeVerder:		"CVT1",
			GreenwichMeanTime:	"GMT0",
			Amsterdam:		"CET-1CEST,M3.5.0,M10.5.0/3",
			Cairo:			"CAT-2",
			Baghdad:		"AST-3",
			Tehran:			"THT-3:30",
			AbuDhabi:		"AZT-4AZST,M3.5.0/4,M10.5.0/5",
			Kabul:			"AFT-4:30",
			Yekaterinburg:		"YEKT-5YEKST,M3.5.0,M10.5.0/3",
			Madras:			"IST-5:30",
			Kathmandu:		"NPT-5:45",
			AlmaAta:		"BDT-6",
			Rangoon:		"MMT-6:30",
			Bangkok:		"ICT-7",
			Beijing:		"CST-8",
			Tokyo:			"JST-9",
			Adelaide:		"CST-9:30CST,M10.1.0,M4.1.0/3",
			Brisbane:		"EST-10",
			Magadan:		"MAGT-11MAGST,M3.5.0,M10.5.0/3",
			Fiji:			"FJT-12",
			Nukualofa:		"PHOT-13"
		},
		isFactory:
		{
			yes: 		"1",
			no: 		"0"
		}
	},
	dynData:
	{
		clockStatus:	"clock_status",
		sysLog:		"sys_log",
		excLog:		"exc_log"
	},
	actionName:
	{
		downloadConf:	"download_conf",
		uploadConf:	"upload_conf",
		firmUpgrade:	"firmware_upgrade",
		downloadLogs:	"download_logs",
		syslogClean:	"syslog_clean"
	}
};

var uciUhttpd =
{
		fileName:		"uhttpd",

		secType:
		{
			uhttpd:		"uhttpd"
		},
		secName:
		{
			main:		"main"
		},
		optName:
		{
			listenHttpLan:	"listen_http_lan",
			listenHttpWan:	"listen_http_wan"
		},
		listName:
		{
			listenHttp:		"listen_http",
			listenHttpLan:	"listen_http_lan"
		},
		optValue:
		{
			http:
			{
				ip:		"0.0.0.0"
			}
		}
};

var uciDeviceInfo =
{
	fileName:		"device_info",
	secType:
	{
		info:		"info"
	},
	secName:
	{
		info:		"info"
	},
	optName:
	{
		productId:	"product_id",
		vendorId:	"vendor_id",
		sysSwRev:	"sys_software_revision",
		sysSwRevMin:	"sys_software_revision_minor",
		buildTime:	"build_time",
		language:	"language",
		deviceName:	"device_name",
		deviceInfo:	"device_info",
		deviceModel:	"device_model",
		hwVer:		"hw_version",
		swVer:		"sw_version",
		domainName:	"domain_name",
		mcuSwVersion: "mcu_sw_version"
	}
};

var uciCloudConfig =
{
	fileName:		"cloud_config",

	secType:
	{
		cloudReply : "cloud_reply"
	},
	secName:
	{
		bind : "bind",
		info : "info",
		register : "register",
		newFirmware : "new_firmware",
		deviceStatus : "device_status",
		upgradeInfo : "upgrade_info",
		resetPassword : "reset_password",
		modifyAccountPwd : "modify_account_pwd",
		cloudAccountStat: "cloudAccountStat",
		downloadFw: "download_fw",
		bindTip: "bind_tip",
		deviceLegality: "device_legality"
	},
	optName:
	{
		type 			: "type",
		accountType		: "account_type",
		username 		: "username",
		password 		: "password",
		newPassword 	: "new_pwd",
		oldPassword 	: "old_pwd",
		bindStatus 		: "bind_status",
		loginStatus 	: "login_status",
		accountStatus 	: "account_status",
		releaseDate 	: "release_date",
		downloadUrl 	: "download_url",
		location 		: "location",
		releaseLogUrl 	: "release_log_url",
		verifyCode      : "verify_code",
		cloudAccountStat: "cloudAccountStat",
		fwNewNotify		: "fw_new_notify",
		fwUpdateType	: "fw_update_type",
		version			: "version",
		releaseLog		: "release_log",
		reconnectTime	: "reconnect_time",
		noShow			: "not_show",
		illegal			: "illegal"
	},
	optValue:
	{
		cloudDownloading:"1",
		cloudComplete: "2",
		cloudOutline: "0",
		cloudIdle: "3",
		fwNewTrue: 1,
		fwNewFalse: 0,
		fwUpdateTypeNormal: "1",
		unRegestStatus:0,
		regestStatus:1,
		bindStatusBind:1,
		bindStatusUnbind:0,
		accountTypeEmail:0,
		accountTypePhoneNum:1,
		reconnectVal:1,
		noShow:
		{
			yes:"1",
			no:"0"
		},
		illegal:
		{
			yes:"1",
			no:"0"
		}
	},
	actionName:
	{
		bind : "bind",
		login : "login",
		unbind : "unbind",
		reconnect:"reconnect",
		register : "register",
		downloadFw: "fw_download",
		checkFwVer: "check_fw_version",
		fwDownload : "fw_download",
		getAccountStat : "get_account_stat",
		resetPassword : "reset_password",
		resetAccountPwd:"reset_account_pwd",
		resendRegisterEmail : "resend_register_email",
		checkFwVersion : "check_fw_version",
		cancelReg : "cancel_reg",
		getRegVerifyCode : "get_reg_verify_code",
		checkRegVerifyCode : "check_reg_verify_code",
		getResetPwdVerifyCode : "get_reset_pwd_verify_code",
		checkResetPwdVerifyCode : "check_reset_pwd_verify_code",
		modifyAccountPwd : "modify_account_pwd"
	}
};

var cloudClientStatus =
{
	fileName:		"cloud_status",

	secName:
	{
		bind : "bind",
		unbind : "unbind",
		login : "login",
		register : "register",
		checkFwVer : "check_fw_ver",
		downloadFw : "download_fw",
		clientInfo : "client_info",
		resendEmail : "resend_email",
		getAccountStat : "get_account_stat",
		resetPassword : "reset_account_pwd",
		fwDownloadProg : "fw_download_prog",
		getRegVerifyCode : "get_reg_verify_code",
		checkRegVerifyCode : "check_reg_verify_code",
		getResetPwdVerifyCode : "get_reset_pwd_verify_code",
		checkResetPwdVerifyCode : "check_reset_pwd_verify_code",
		modifyAccountPwd : "modify_account_pwd",
		getCanUpdateApps : "get_can_update_plugins",
		getNotInstalledApps: "get_not_installed_plugins",
		regVeriCodeTimer:"reg_veri_code_timer",
		resetVeriCodeTimer:"reset_veri_code_timer"
	},
	optName:
	{
		owner: "owner",
		errCode: "err_code",
		actionStatus: "action_status",
		connectStatus: "connect_status",
		dlProgress : "fw_download_progress",
		fwDownloadStatus: "fw_download_status",
		fwDownloadProgress: "fw_download_progress",
		regVeriCodeTimer:"reg_veri_code_timer",
		resetVeriCodeTimer:"reset_veri_code_timer"
	},
	optValue:
	{
		connectStatus:{
			connected:1,
			disconnected:0
		},
		queryStatus:{
			failed:0,
			idle:1,
			prepare:2,
			trying:3,
			success:4,
			timeout:5,
			max:6
		}
	}
};

var uciFunction =
{
	fileName:		"function",

	secName:
	{
		newModuleSpec: "new_module_spec",
		moduleSpec: "module_spec"
	},
	optName:
	{
		channel2g: "wireless2g_channel",
		channel5g: "wireless5g_channel",
		bandWidth5g:"wireless5g_bandwidth",
		channel5g1: "wireless5g_1_channel",
		bandWidth5g1:"wireless5g_1_bandwidth",
		channel5g4: "wireless5g_4_channel",
		bandWidth5g4:"wireless5g_4_bandwidth",
		mode2g: "wireless2g_mode",
		mode5g: "wireless5g_mode",
		moduleList: "module_list",
		wlanBS: "wlan_bs",
		powerList: "power_list",
		guest5g: "guest5g",
		wifiSwitch: "wifi_switch",
		wifiSwitchSplit: "wifi_switch_split",
		wlanServiceAttr:"wlan_service_attr",
		wlanServiceAttr2g:"wlan_service_attr_2g",
		wlanServiceAttr5g:"wlan_service_attr_5g",
		wlanServiceAttr5g1:"wlan_service_attr_5g_1",
		wlanServiceAttr5g4:"wlan_service_attr_5g_4",
		supportWlanAuthType2g:"support_wlan_auth_type_2g",
		supportWlanAuthType5g:"support_wlan_auth_type_5g",
		supportWlanAuthType5g1:"support_wlan_auth_type_5g_1",
		supportWlanAuthType5g4:"support_wlan_auth_type_5g_4",
		supportMultiSsid:"support_multi_ssid",
		supportPinWps:"support_pin_wps",
		macFilterSupport:"mac_filter_config",
		modeSwitchSupport: "mode_switch",
		elink:"elink",
		wolink:"wolink",
		alinkTest: "alink_test",
		customLed: "custom_led",
		hnat: "hnat",
		ipv6: "ipv6",
		mumimo2g: "wireless2g_vhtmubfer",
		mumimo5g: "wireless5g_vhtmubfer",
		mumimo5g1: "wireless5g1_vhtmubfer",
		mumimo5g4: "wireless5g_4vhtmubfer"
	},
	optValue:
	{
		moduleList:
		{
			cloud: "cloud",
			wlan_guest : "wlan_guest"
		},
		enable:"1",
		disable:"0"
	}
}

var uciPlc =
{
	fileName : "hyfi",

	actionName :
	{
		scanExt : "scan_ext",
		addExt  : "add_ext",
		setExtInfo: "set_ext_info",
		setPlcHostInfo:"set_plc_host_info",
		kickExt: "kick_ext",
		getLedStatus: "get_led_status",
		setLedStatus: "set_led_status",
		stopScanExt: "stop_scan_ext",
		plcDiagnose: "plc_diagnose",
		rebootExtWlan: "reboot_ext_wlan",
		upgExt:"upgrade_ext",
		startGetExtFwVer : "start_get_ext_fw_ver",
		rebootExt:"reboot_ext",
		resetExt:"reset_ext",
		localUpgradeExt:"local_upgrade_ext"
	},

	secType :
	{
		scannedExt: "scanned_ext",
		connectedExt: "connected_ext",
		connectedPlc: "connected_plc_host",
		ExtRate: 	"connected_ext_rate"
	},

	secName :
	{
		scanExtStatus : "scan_ext_status",
		plc : "plc",
		startGetExtFwVerStat :"start_get_ext_fw_ver_status",
		upgExtStat:"upgrade_ext_status"
	},

	optName :
	{
		status : "status",
		idx : "idx",
		name : "name",
		ip : "ip",
		mac : "mac",
		timeDiagnose: "time_diagnose",
		supportOlUp: "support_ol_upgrade",
		plcEnable: "plc_enable"
	},

	optValue :
	{
		status :
		{
			doing: "1",
			idle: "0"
		},
		extStatus :
		{
			idle: "0",
			waitingToAdd: "1",
			adding: "2",
			success: "3",
			fail: "4",
			timeout: "5"
		},
		ledStatus:
		{
			on: "1",
			off: "0"
		},
		plcDiagStatus:
		{
			off: "0",
			timer: "1",
			realTime:"2"
		},
		supportOlUp:
		{
			yes: "1",
			no: "0"
		},
		extOlStatus:
		{
			idle: "0",
			readyDownload: "1",
			downloading: "2",
			readyUpg: "3",
			upgrading: "4",
			upgSuccess: "5",
			timeout: "6",
			fail: "255"
		}
	}
}

var uciTimeSwitch =
{
	fileName : "time_switch",

	actionName :
	{

	},

	secType :
	{
		timeSwitch: "time_switch"
	},

	secName :
	{
		general: "general",
		clockSuccess: "clock_success"
	},

	optName :
	{
		name:		"name",
		mon:		"mon",
		tue:		"tue",
		wed:		"wed",
		thu:		"thu",
		fri:		"fri",
		sat:		"sat",
		sun:		"sun",
		enable:     "enable",
		startTime:  "start_time",
		endTime:    "end_time"
	},

	optValue :
	{
		enable:
		{
			on: "1",
			off: "0"
		}
	}
}

var uciRebootTimer =
{
	fileName:		"reboot_timer",

	secName:
	{
		rebootTimerStatus:	"reboot_timer_status",
		clockSuccess:		"clock_success"
	},

	secType:
	{
		rebootTimerRule: "reboot_timer_rule"
	},

	optName:
	{
		enable:		"enable",
		name:		"name",
		mon:		"mon",
		tue:		"tue",
		wed:		"wed",
		thu:		"thu",
		fri:		"fri",
		sat:		"sat",
		sun:		"sun",
		rebootTime:	"reboot_time"
	},

	optValue:
	{
		enable:
		{
			yes: "1",
			no: "0"
		}
	}
};

var uciElink =
{
	fileName:		"elink",
	secType:
	{
		elink:		"elink"
	},
	secName:
	{
		status:		"status"
	},
	optName:
	{
		elinkSwitch:  	"elink_switch",
		elinkSynEnable:	"elink_syn_enable",
		wanType:		"wan_type"
	},
	optValue:
	{
		elinkSwitch:
		{
			on:		"1",
			off:	"0"
		},
		elinkSynEnable:
		{
			on:		"1",
			off:	"0"
		}
	}
};

var uciHNat =
{
	fileName : "hnat",

	actionName :
	{

	},

	secType :
	{

	},

	secName :
	{
		main: "main"
	},

	optName :
	{
		enable:     "enable"
	},

	optValue :
	{
		enable:
		{
			on: "1",
			off: "0"
		}
	}
};

var uciLedTimeSwitch =
{
	fileName : "led_time_switch",

	actionName :
	{

	},

	secType :
	{
		ledTimeSwitch: "led_time_switch"
	},

	secName :
	{
		general: "general",
		clockSuccess: "clock_success"
	},

	optName :
	{
		name:		"name",
		mon:		"mon",
		tue:		"tue",
		wed:		"wed",
		thu:		"thu",
		fri:		"fri",
		sat:		"sat",
		sun:		"sun",
		enable:     "enable",
		startTime:  "start_time",
		endTime:    "end_time"
	},

	optValue :
	{
		enable:
		{
			on: "1",
			off: "0"
		}
	}
};

var uciWanPortDetect = {
	fileName:		"wan_port_detect",
	secName:
	{
		config:		"config"
	},
	optName:{
		enable: 	"enable"
	},
	optValue:
	{
		enable:
		{
			on:	    "1",
			off:	"0"
		}
	}
};

var uciMesh = {
	fileName:		"mesh",
	secName:
	{
		config:		"config"
	},
	optName:{
		pbcEnable: 	"pbc_enable"
	},
	optValue:
	{
		enable:
		{
			on:	    "1",
			off:	"0"
		}
	}
};

var uciLed = {
	fileName:		"led",
	secName:
	{
		config:		"config"
	},
	optName:{
		sysLedEnable: 	"sys_led_enable",
		wlanStatus: "wlan_status_control"
	},
	optValue:
	{
		enable:
		{
			on:	    "on",
			off:	"off"
		}
	}
}

var uciCustomWireless = {
	fileName: "custom_wireless",

	secName:
	{
		wpsConfig: "wps_config"
	},
	optName:
	{
		pinEnable:		"pin_enable",
		pinCode:		"wsc_vendorpin",
		linkType:		"link_type",
		terminalPinCode:"terminal_pin_code",
		vendorPin:		"wsc_vendorpin",
		band:			"band"
	},
	optValue:
	{
		pinEnable:
		{
			on: "on",
			off: "off"
		},
		linkType:
		{
			button: "pbc",
			pin: "pin"
		}
	},
	dynOptName: {
		enable: "enable",
		enable_2g:    "enable_2g",
		enable_5g:    "enable_5g",
		enable_5g1:   "enable_5g1",
		enable_5g4:   "enable_5g4"
	},
	dynOptValue:
	{
		enable:
		{
			off:	"off",
			on:		"on"
		}
	},
	dynData: {
		wifi_switch: "wifi_switch"
	},
	actionName:
	{
		wpsLink: "wps_link",
		wpsGeneratePin: "wps_generate_pin"
	}
};

var uciMultiSsid =
{
	fileName:	"custom_multi_ssid",

	secType:
	{
		wifiWeb:		"wifi-web"
	},
	secName:
	{
		wlan_multi_ssid_2g_1:	"wlan_multi_ssid_2g_1",
		wlan_multi_ssid_2g_2:	"wlan_multi_ssid_2g_2",
		wlan_multi_ssid_5g_1:	"wlan_multi_ssid_5g_1",
		wlan_multi_ssid_5g_2:	"wlan_multi_ssid_5g_2",
		wlan_multi_ssid_5g_3:	"wlan_multi_ssid_5g_3"
	},
	optName:
	{
		enable:				"enable",
		ssid:				"ssid",
		ssidbrd:			"ssidbrd",
		encryption:			"encryption",
		key:				"key",
		seccheck:			"seccheck",
		auth:				"auth",
		cipher:				"cipher",
		maxStaNum:			"max_sta_num"
	},
	optValue:
	{
		keyType:
		{
			none:		"none",
			psk:		"psk",
			psk2:		"psk2",
			pskMixed:	"mixed-psk",
			tkip:		"tkip",
			ccmp:		"ccmp"
		},
		enable:
		{
			off:	0,
			on:		1
		},
		ssidbrd:
		{
			off:	0,
			on:		1
		},
		encryption:
		{
			off:	0,
			on:		1
		},
		auth:
		{
			psk:		1,
			psk2:		2,
			pskMixed:	0
		},
		cipher:
		{
			aes:		1,
			tkip:		2,
			auto:		0
		}
	}
};

var uciCustomNetwork =
{
	fileName:	"custom_network",
	secName:
	{
		macFilterConfig: "mac_filter_config"
	},
	optName:
	{
		mode: "mode",
		enable: "enable",
		policy: "policy",
		owner: "owner"
	},
	optValue:
	{
		mode:
		{
			route:	0,
			bridge:	1
		},
		owner:
		{
			web: "web",
			andlink: "andlink"
		},
		macFilterConfig:
		{
			on: 'on',
			off: 'off'
		}
	},
	dynData:
	{
		bridgeStatus: "bridge_status",
		macFilterConfig: "mac_filter_config",
		macFilterBlackEntry: "mac_filter_black_entry",
		macFilterWhiteEntry: "mac_filter_white_entry",
		macFilterWhiteBlockList: "mac_filter_white_block_list"
	}
};

var uciWlanAccess =
{
	fileName: "wlan_access",
	dynData:
	{
		blockList: "block_list"
	},
	optName:
	{
		config: "config",
		enable: "enable"
	}
};

var uciCustomElink =
{
	fileName:	"custom_elink",
	secName: {
		status: 'status'
	},
	optName:
	{
		wanType:	"wan_type",
		elinkSwitch: "elink_switch",
		elinkSynEnable:	"elink_syn_enable"
	},
	optValue:
	{
		wanType:
		{
			bridge:	'bridge',
			dhcp: 'dhcp'
		},
		elinkSwitch:
		{
			on:		"1",
			off:	"0"
		},
		elinkSynEnable:
		{
			on:		"1",
			off:	"0"
		}
	}
};

var uciCustomLed = {
	fileName: "custom_led",
	secName: {
		config: "config"
	},
	optName: {
		config: "config"
	},
	optValue: {
		enable: {
			on: "100",
			off: "222"
		}
	}
}

var SEC_NAME  = ".name";
var KEY_NAME  = "name";
var KEY_TABLE = "table";
var KEY_PARA  = "para";