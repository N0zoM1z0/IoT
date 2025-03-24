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
<script language="JavaScript">
	var hasBgGetDevStatus = false;
	var dev_info = get_router_info();
	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	document.title = get_words('TEXT000');
	var Show_ = get_words('_none');

	var wan_addr4;
	var use_linklocal_addr;
	var v6Status = {
		'connType':	0,
		'IPAddressType':	0,
		'netState':	'Disconnected',
		'connupTime': '0',
		'wanAddr':	'',
		'wanIANA':	'',
		'wanStaticIP':	'',
		'gw':		'',
		'priDNS':	'',
		'secDNS':	'',
		'wanLL':	'',
		'lanLL':	'',
		'lanAddr':	'',
		'dhcpPdEn':	0,
		'dhcpPdAddr':	'',
		'dhcpPdLen':	0,
		'WanPrefixLen': 0,
		'WanStaticPrefixLen': 0,
		'LanPrefixLen': 0
	};

	var lanHost = {
		'name':			'',
		'ip':			'',
		'prefix':		''
	};

	function reqStatus() {
		var param = {
			url: "get_set.ccp",
			arg: ""
		};
		param.arg = "ccp_act=get&num_inst=6";
		param.arg +="&oid_1=IGD_Status_IPv6Status_&inst_1=11100";	
		param.arg +="&oid_2=IGD_Status_LANStatus_HostV6_i_&inst_2=11100";
		param.arg +="&oid_3=IGD_LANDevice_i_IPv6ConfigManagement_&inst_3=11100";
		param.arg +="&oid_4=IGD_Status_WANStatus_&inst_4=11100";
		param.arg +="&oid_5=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_StaticIP_i_&inst_5=11110";
		param.arg +="&oid_6=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_PPPoE_i_&inst_6=11110"; //added by Derek 20120504
		get_config_obj(param);

		wan_addr4 = config_val("igdWanStatus_IPAddress_");
		use_linklocal_addr = filter_ipv6_addr(config_val("ipv6StaticConn_UseLinkLocalAddress_"));
		v6Status.connType = config_val('igdIPv6Status_CurrentConnObjType_');
		v6Status.IPAddressType =config_val('ipv6PPPoEConn_IPAddressType_');//added by Derek 20120504
		v6Status.netState = config_val('igdIPv6Status_NetworkStatus_');
		v6Status.connupTime = config_val('igdIPv6Status_WanUpTime_');
		v6Status.wanAddr = filter_ipv6_addr(config_val('igdIPv6Status_IPAddress_'));
		v6Status.wanIANA = filter_ipv6_addr(config_val('igdIPv6Status_IPAddressIANA_'));
		v6Status.gw = config_val('igdIPv6Status_DefaultGateway_');
		v6Status.priDNS = filter_ipv6_addr(config_val('igdIPv6Status_PrimaryDNSAddress_'));
		v6Status.secDNS = filter_ipv6_addr(config_val('igdIPv6Status_SecondaryDNSAddress_'));
		v6Status.wanLL = filter_ipv6_addr(config_val('igdIPv6Status_IPv6WanLinkLocalAddress_'));
		v6Status.lanLL = filter_ipv6_addr(config_val('igdIPv6Status_IPv6LanLinkLocalAddress_'));
		v6Status.lanAddr = filter_ipv6_addr(config_val('igdIPv6Status_IPv6LanAddress_'));
		v6Status.lanAddr2 = filter_ipv6_addr(config_val('igdIPv6Status_IPv6LanAddress2_'));
		v6Status.dhcpPdEn = config_val("lanIPv6Cfg_DHCPPDEnable_");
		v6Status.dhcpPdAddr = filter_ipv6_addr(config_val('igdIPv6Status_IPv6AddressAssignedByDHCPPD_'));
		v6Status.dhcpPdLen = config_val('igdIPv6Status_IPv6AddressLenAssignedByDHCPPD_');
		v6Status.tunnelAddr = filter_ipv6_addr(config_val('igdIPv6Status_IPv6TunnelAddress_'));
		v6Status.WanPrefixLen = config_val('igdIPv6Status_IPv6WanPrefixLen_');
		v6Status.WanIANAPrefixLen = config_val('igdIPv6Status_IANAPrefix_');
		v6Status.LanPrefixLen = config_val('igdIPv6Status_IPv6LanPrefixLen_');
		v6Status.LanPrefixLen2 = config_val('igdIPv6Status_IPv6LanPrefixLen2_');
		v6Status.wanStaticIP=config_val('igdIPv6Status_StaticIPAddress_');//added by Derek 20120504
		v6Status.WanStaticPrefixLen = config_val('igdIPv6Status_IPv6WanStaticPrefixLen_');
		lanHost.name = config_val("igdLanHostV6Status_HostName_").split("/");
		lanHost.ip = config_val("igdLanHostV6Status_HostIPv6Address_").split("/");
		lanHost.prefix = config_val("igdLanHostV6Status_HostIPv6Prefix_").split("/");
	}

	function onPageLoad()
	{
		reqStatus();
		var connection_type = '';
		var showNone = true;
		ipv6_link_local();
		tr_tunnel_ipv6_addr.style.display="none";
		//v6Status.connType = '5';
		switch(v6Status.connType)
		{
			case "0":   //autodetection
				connection_type = get_words('IPV6_TEXT138');
				show_dhcppd(1);
				get_v6_gw(0);
				if (v6Status.netState == "Disconnected")
					tr_ipv6_show_button.style.display="none";
				tr_ipv6_conn_time.style.display="none";
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "1":    //static
				connection_type = get_words('IPV6_TEXT32');
				show_dhcppd(0);
				get_v6_gw(0);
				tr_ipv6_conn_time.style.display="none";
				tr_ipv6_show_button.style.display="none";
				tr_dhcp_pd.style.display="none";
				tr_ipv6_addr_by_dhcppd.style.display="none";
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "2":   //autoconfiguration
				connection_type = get_words('IPV6_TEXT171');
				if (v6Status.netState != "Disconnected")
					tr_ipv6_show_button.style.display="";
				show_dhcppd(1);
				get_v6_gw(0);
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "3":  //pppoe
				connection_type = get_words('IPV6_TEXT34');
				if (v6Status.netState != "Disconnected")
					tr_ipv6_show_button.style.display="";
				show_dhcppd(1);
				get_v6_gw(0);
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "4": //6in4
				connection_type = get_words('IPV6_TEXT35');
				show_dhcppd(1);
				get_v6_gw(0);
				tr_ipv6_show_button.style.display="none";
				tr_ipv6_conn_time.style.display="none";
				tr_tunnel_ipv6_addr.style.display="none";
				//$('#tunnel_ipv6_addr')[0].html() += "/128";
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "5":  //6to4
				connection_type = get_words('IPV6_TEXT36');
				showNone = change_6to4_format();
				show_dhcppd(0);	
				get_v6_gw(1);
				tr_ipv6_show_button.style.display="none";
				tr_ipv6_conn_time.style.display="none";
				tr_dhcp_pd.style.display="none";
				tr_ipv6_addr_by_dhcppd.style.display="none";
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "6":   //6rd
				connection_type = get_words('IPV6_TEXT139');
				show_dhcppd(0);	
				get_v6_gw(1);
				tr_ipv6_show_button.style.display="none";
				tr_ipv6_conn_time.style.display="none";
				tr_tunnel_ipv6_addr.style.display="";
				tr_dhcp_pd.style.display="none";
				tr_ipv6_addr_by_dhcppd.style.display="none";
				//$('#tunnel_ipv6_addr')[0].html() += "/64";
				tr_wan_ipv6_addriana.style.display="none";
				break;
			case "7":  //link local
				connection_type = get_words('IPV6_TEXT37');
				tr_ipv6_show_button.style.display="none";
				tr_ipv6_conn_time.style.display="none";
				tr_network_ipv6_status.style.display="none";
				tr_lan_ipv6_addr.style.display="none";
				tr_primary_ipv6_dns.style.display="none";
				tr_secondary_ipv6_dns.style.display="none";
				tr_wan_ipv6_gw.style.display="none";
				tr_dhcp_pd.style.display="none";
				tr_ipv6_addr_by_dhcppd.style.display="none";
				tr_wan_ipv6_addriana.style.display="";
				show_dhcppd(0);	
				break;
			case "8":  //dslite
				connection_type = get_words('IPV6_TEXT140');
				lan_ip = "None";
				tr_wan_ipv6_addriana.style.display="";
				break;
			case "9":   //6rdAutoConfig
				connection_type = get_words('IPV6_TEXT172');
				if (v6Status.netState != "Disconnected")
					tr_ipv6_show_button.style.display="";
				show_dhcppd(1);
				get_v6_gw(0);
				tr_tunnel_ipv6_addr.style.display="";
				tr_wan_ipv6_addriana.style.display="";
				break;
			default:
				break;
		}
		
		$('#connection_ipv6_type').html(connection_type);
		$('#network_ipv6_status').html(v6Status.netState == "Disconnected" ? get_words('DISCONNECTED'):get_words('CONNECTED'));
		get_wan_time(v6Status.connupTime);
		

		if(v6Status.connType=="1" && use_linklocal_addr == "1"){
			if(v6Status.wanLL){
				$('#wan_ipv6_addr').html('&nbsp;&nbsp;'+v6Status.wanLL+"/"+v6Status.WanStaticPrefixLen);
				showNone = false;
			}
		}
		else if(v6Status.wanAddr){
			$('#wan_ipv6_addr').html('&nbsp;&nbsp;'+v6Status.wanAddr+"/"+v6Status.WanPrefixLen);
			showNone = false;
		}
		
		if(v6Status.IPAddressType=="0" && v6Status.connType!="5"){
			if(v6Status.wanIANA){
				$('#wan_ipv6_addriana').html('&nbsp;&nbsp;'+v6Status.wanIANA+"/"+v6Status.WanIANAPrefixLen);
				showNone = false;
			}
		}
		else if(v6Status.wanStaticIP){
			$('#wan_ipv6_StaticIP').html('&nbsp;&nbsp;'+filter_ipv6_addr(v6Status.wanStaticIP)+"/"+v6Status.WanStaticPrefixLen);
			showNone = false;
		}

		if(showNone){
			$('#wan_ipv6_addr').html('&nbsp;&nbsp;'+Show_);
		}
	

		$('#primary_ipv6_dns').html((v6Status.priDNS == "")? Show_ :v6Status.priDNS);
		$('#secondary_ipv6_dns').html((v6Status.secDNS == "")? Show_ :v6Status.secDNS);
		$('#lan_ipv6_addr').html((v6Status.lanAddr == "")? Show_ :(v6Status.lanAddr+"/"+v6Status.LanPrefixLen));
		//20120822 pascal add for 6rd two ipv6 address
		if(v6Status.lanAddr2 != "")
		{
			$("#count_ip").attr('rowspan',2);
			$("#tr_lan_ipv6_addr2").show();
			$('#lan_ipv6_addr2').html((v6Status.lanAddr2 == "")? Show_ :(v6Status.lanAddr2+"/"+v6Status.LanPrefixLen2));
		}
		else
		{
			$("#count_ip").attr('rowspan',1);
			$("#tr_lan_ipv6_addr2").hide();
			$('#lan_ipv6_addr2').html(Show_);
		}	
		$('#lan_link_local_ip').html((v6Status.lanLL == "")? Show_ :(v6Status.lanLL+"/64"));

		/*if(v6Status.netState == "Disconnected")
		{
			$('#wan_ipv6_addr').html("");
			$('#wan_ipv6_addriana').html("");
			$('#tunnel_ipv6_addr').html("");
			$('#wan_ipv6_gw').html("");
			$('#primary_ipv6_dns').html("");
			$('#secondary_ipv6_dns').html("");
			$('#lan_ipv6_addr').html("");
			$('#ipv6_addr_by_dhcppd').html("");
		}*/
		//$('#wan_ipv6_addr').html("1111:2222:3333:4444:5555:6666:7777:8888/128");
		//$('#wan_ipv6_addriana').html("2222:2222:2222:2222:2222:2222:2222:2222/128");
		
		print_hostv6();
		
		/*
		// request by Bernie
		if((v6Status.connType=="2")||(v6Status.connType=="9"))
		{
			if(v6Status.gw=="")
			{
				if((v6Status.wanAddr=="")&&(v6Status.wanIANA==""))
				{
					$('#network_ipv6_status').html(get_words('DISCONNECTED'));
					$('#primary_ipv6_dns').html("");
					$('#secondary_ipv6_dns').html("");
					get_by_id("ipv6_conn_time").innerHTML = get_words('_NA');
				}
			}
		}
		*/
		set_control_button();
		setTimeout("onPageLoad()",3000);
	}
	String.prototype.lpad = function(padString, length) {
	var str = this;
	while (str.length < length)
	str = padString + str;
	return str;
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
					? "Day"
					: "Days")
				+ ", ";
			wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
		
	}
	function padout(number) {
		return (number < 10) ? '0' + number : number;
	}	
	function get_wan_time(_t){
		wTimesec = parseInt(_t);
		if(wTimesec == 0){
			//wan_time = "N/A";
			wan_time = get_words('_na');
		}else{
			wTimesec = wTimesec/250;        //divide clock hz
			caculate_time();
			chk_typeAutoConf();
		}
		//get_by_id("network_ipv6_status").innerHTML = "+get_wan_time+"+wTimesec;
	}
	
	function WTime(){
		get_by_id("ipv6_conn_time").innerHTML = wan_time;
		if(wTimesec != 0){
			wTimesec++;
			caculate_time();
			chk_typeAutoConf();
			//get_by_id("network_ipv6_status").innerHTML = "+WTime()+"+wTimesec;
		}
		setTimeout('WTime()', 1000);
	}
	
	
	function h2d(h) {return parseInt(h,16);}

	function h2d2(a,b) {return parseInt(a,16)*16+parseInt(b,16);}

	function ipv6_link_local()
	{
		var u32_pf;
		var ary_ip6rd_pf = [0,0];
		var ary_ip4 = wan_addr4.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);
		u32_pf = parseInt(u32_ip4);
		str_tmp = u32_pf.toString(16).lpad("0",8);
		ary_ip6rd_pf[0] = str_tmp.substr(0,4);
		ary_ip6rd_pf[1] = str_tmp.substr(4,4);

		/*
		**    Date:		2013-02-26
		**    Author:	Silvia Chang, Vic Liu
		**    Reason:   update for 6rd link local addr when cable is unplug
		**    Note:		sync with DIR-820L
		**/
		if((v6Status.connType=="6")||(v6Status.connType=="9") )
		{
			if(v6Status.netState == "Connected")
				$('#tunnel_ipv6_addr').html("fe80::"+ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+"/64");
			else
				$('#tunnel_ipv6_addr').html(Show_);
		}
	}

	//20120906 pascal add 6to4 IANA adress
	function change_6to4_format()
	{
		var address = config_val('igdIPv6Status_IPAddressIANA_');
		var str="::";
		if(address != "")
		{
			var tmpv6ip =address.split(":");
			for(i=4;i<8;i++)
			{
				tmphex = "";
				tmphex = tmpv6ip[i].split("");
				if(tmphex.length == 1)
					str +=h2d(tmphex[0]);
				else
					str +=h2d2(tmphex[0], tmphex[1]);
				if(i<7)
					str +=".";
			}
			str +="/";
			str +=v6Status.WanIANAPrefixLen;
			$('#wan_ipv6_addriana').html('&nbsp;&nbsp;'+str);
			return false;
		}
		return true;
	}
	
	function get_v6_gw(is_v4_gw)
	{

		if(is_v4_gw == 0)
		{
			$('#wan_ipv6_gw').html((v6Status.gw == "")?Show_:filter_ipv6_addr(v6Status.gw));
		}
		else
		{
			var i, tmphex, decvalue;
			//v6Status.gw = '';
			if(v6Status.gw != ""){
				$('#wan_ipv6_gw').html("::");
				var tmpv6gw = v6Status.gw.split(":");
				for(i=4;i<8;i++)
				{
					//alert(tmpv6gw[i]);
					tmphex = "";
					tmphex = tmpv6gw[i].split("");
					if(tmphex.length == 1)
						$('#wan_ipv6_gw')[0].innerHTML +=h2d(tmphex[0]);
					else
						$('#wan_ipv6_gw')[0].innerHTML +=h2d2(tmphex[0], tmphex[1]);
					if(i<7)
						$('#wan_ipv6_gw')[0].innerHTML +=".";
				}
			}
			else{
				$('#wan_ipv6_gw').html(Show_);
			}
		}
	}

	function show_dhcppd(dhcppd_support)
	{	
		if(dhcppd_support){
			if(v6Status.dhcpPdEn == 1)
			{
				$('#dhcp_pd').html(get_words('_enabled'));
				$('#ipv6_addr_by_dhcppd').html((v6Status.dhcpPdAddr == "")?Show_:(v6Status.dhcpPdAddr+"/"+v6Status.dhcpPdLen));
			}	
			else
			{
				$('#dhcp_pd').html(get_words('_disabled'));
				$('#ipv6_addr_by_dhcppd').html(Show_);
			}
		}
		else
		{
			$('#dhcp_pd').html(get_words('_disabled'));
			$('#ipv6_addr_by_dhcppd').html(Show_);
		}
	}

	function set_control_button()
	{
		var wan_type = v6Status.connType;
		var commonAction1 = "do_connect()";
		var commonAction2 = "do_disconnect()";

		var button1_name = get_words('_connect');		//_connect;
		var button2_name = get_words('LS315');	//sd_Disconnect;
		var button1_action = commonAction1;
		var button2_action = commonAction2;
		//wan_type = '2';
		switch(wan_type)
		{
			case "0":	//is_autodetect
				break;

			case "1":	//is_static
			case "4":	//is_6in4
			case "5":	//is_6to4
			case "6":	//is_6rd
			case "7":	//is_linklocal
			case "8":	//is_dslite
				return;

			case "2":	//is_autoconf
			case "9":	//is_autoconf_6rd
				button1_name =  get_words('LS312');		//sd_Renew;
				button2_name = get_words('LS313');	//sd_Release;
				break;
				
			case "3":	//is_pppoe
				break;
		}

		$('#ctrl_buttons').html("<input type=\"button\" value=\""+button1_name+"\" name=\"connect\" id=\"connect\" onClick=\""+button1_action+"\">&nbsp;<input type=\"button\" value=\""+button2_name+"\" name=\"disconnect\" id=\"disconnect\" onClick=\""+button2_action+"\"></td>");
		if(v6Status.netState=="Disconnected")
			$('#disconnect').attr('disabled',true);
		else
			$('#connect').attr('disabled',true);

		//20120215 silvia add if wantype is autoconf renew always enable.
		if ((wan_type == '2')||(wan_type=='9'))
		{
			$('#connect').attr('disabled','');
			//if ((v6Status.wanIANA != "") || ((v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr != "")))
			if (((v6Status.wanIANA == "") && (v6Status.dhcpPdEn == 0))||
			((v6Status.WanIANAPrefixLen == "64") && (v6Status.dhcpPdEn == 0))||
			((v6Status.wanIANA == "") && (v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr == ""))||
			((v6Status.WanIANAPrefixLen == "64") && (v6Status.dhcpPdEn == 1) && (v6Status.dhcpPdAddr == "")))
				$('#disconnect').attr('disabled',true);
			else
				$('#disconnect').attr('disabled','');
		}

	/*	if(wan_type == '3')
		{
			if(v6Status.netState=="Disconnected")
			{
				if((v6Status.wanIANA != "0:0:0:0:0:0:0:0")||(v6Status.dhcpPdAddr != "0:0:0:0:0:0:0:0"))
				{
					$('#connect').attr('disabled',true);
					$('#disconnect').attr('disabled','');
				}
			}			
		}*/
		if (login_Info != "w") {
			$('#connect').attr('disabled',true);
			$('#disconnect').attr('disabled',true);
		}
	}

	function do_connect()
	{
		$('#network_ipv6_status').html(get_words('ddns_connecting'));
		$('#connect').attr('disabled',true);
		var paramConnect = {
			url: "get_set.ccp",
			arg: "ccp_act=doEvent&ccpSubEvent=CCP_SUB_DOWANCONNECT_V6"
		};
		get_config_obj(paramConnect);
	}

	function do_disconnect()
	{
		$('#network_ipv6_status').html(get_words('ddns_disconnecting'));
		$('#disconnect').attr('disabled',true);
		var paramDisconnect = {
			url: "get_set.ccp",
			arg: "ccp_act=doEvent&ccpSubEvent=CCP_SUB_DOWANDISCONNECT_V6"
		};
		get_config_obj(paramDisconnect);
	}

	function print_hostv6()
	{
		var str = 	'<tr><td>'+get_words(IPV6_TEXT0)+'</td>'+
					'<td>'+get_words(YM187)+'</td></tr>';

		if (lanHost != null && lanHost.name != null) {
			for(var i=0; i<lanHost.name.length; i++)
			{
				var lanHostip = filter_ipv6_addr(lanHost.ip[i]);
				str += "<tr><td>" + lanHostip+ "</td><td>" + lanHost.name[i] + "</td></tr>";
			}
		}
		$('#host6_table').html(str);
	}

	function replace_null_to_none(item){
		if(item=="(null)")
			item="none";
		return item;
	}

	//20120822 add by Silvia
	function chk_typeAutoConf()
	{
		if(v6Status.connType == "2")
		{
			if ((((v6Status.wanIANA) != '') || ((v6Status.wanAddr) != '')) && (v6Status.gw) != '')
				$('#network_ipv6_status').html(get_words('CONNECTED'));
			else{
				$('#network_ipv6_status').html(get_words('DISCONNECTED'));
				wan_time = get_words('_na');
			}
		}
		if(v6Status.connType == "9")
		{
			if ((((v6Status.wanIANA) != '') || ((v6Status.wanAddr) != '')) && (v6Status.gw) != '')
				$('#network_ipv6_status').html(get_words('CONNECTED'));
			else{
				$('#network_ipv6_status').html(get_words('DISCONNECTED'));
				wan_time = get_words('_na');
			}
		}
	}
</script>
</head>
<input type="hidden" id="dhcp_list" name="dhcp_list" value=''>
<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value=''>
<input type="hidden" id="ipv6_pppoe_dynamic" name="ipv6_pppoe_dynamic" value=''>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<input type="hidden" id="ipv6_6to4_tunnel_address" name="ipv6_6to4_tunnel_address" maxLength=80 size=80 value=''>
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
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td id="sidenav_container">
				<div id="sidenav">
				<!-- === BEGIN SIDENAV === -->
				<ul>
					<li><div><a href="st_device.asp"><script>show_words(_devinfo)</script></a></div></li>
					<li><div><a href="st_log.asp"><script>show_words(_logs)</script></a></div></li>
					<li><div><a href="st_stats.asp"><script>show_words(_stats)</script></a></div></li>
					<li><div><a href="internet_sessions.asp"><script>show_words(YM157)</script></a></div></li>
					<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
					<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
					<li><div id="sidenavoff" style="text-transform:none"><script>show_words(IPV6_TEXT137)</script></div></li>
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
			<div id="box_header">
				<h1 style=" text-transform:none"><script>show_words(TEXT068)</script></h1><br>
				<script>show_words(TEXT069)</script>
				<br><br>
			</div>
			<div class="box">
				<h2 style=" text-transform:none"><script>show_words(TEXT070)</script></h2>
				<table cellpadding="1" cellspacing="1" border="0" width="525">
				<tr>
					<td align=right  nowrap><b><script>show_words(IPV6_TEXT29a)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="connection_ipv6_type" nowrap></span>
					</td>
				</tr>
				<tr id="tr_network_ipv6_status">
					<td align=right  nowrap><b><script>show_words(_networkstate)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="network_ipv6_status" nowrap></span>
					</td>
				</tr>
				<tr id="tr_ipv6_conn_time">
					<td align=right  nowrap><b><script>show_words(_conuptime)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="ipv6_conn_time" nowrap></span>
					</td>
				</tr>
				<tr id="tr_ipv6_show_button">
					<td >&nbsp;</td>
					<td width="300">&nbsp;
						<span id="show_button"></span><span id="ctrl_buttons"></span>
					</td>
				</tr>
				<tr id="tr_wan_ipv6_addriana">
					<td align=right  nowrap><b><script>show_words(TEXT071)</script> :</b></td>
					<td width="300">
						<div id="wan_ipv6_addriana" nowrap></div>
						<div id="wan_ipv6_StaticIP" nowrap></div>
						<div id="wan_ipv6_addr" nowrap></div>
					</td>
				</tr>
				<tr id="tr_tunnel_ipv6_addr">
					<td align=right  nowrap><b><script>show_words(IPV6_TEXT145)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="tunnel_ipv6_addr" nowrap></span>
					</td>
				</tr>
				<tr id="tr_wan_ipv6_gw">
					<td align=right  nowrap><b><script>show_words(IPV6_TEXT75)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="wan_ipv6_gw" nowrap></span>
					</td>
				</tr>
				<tr id="tr_lan_ipv6_addr">
					<td align=right nowrap id="count_ip"><b><script>show_words(IPV6_TEXT46)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="lan_ipv6_addr" nowrap></span>
					</td>
				</tr>
				<tr id="tr_lan_ipv6_addr2" style="display:none">
					<td width="300">&nbsp;
						<span id="lan_ipv6_addr2" nowrap></span>
					</td>
				</tr>
				<tr id="tr_lan_link_local_ip">
					<td align=right  nowrap><b><script>show_words(IPV6_TEXT47)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="lan_link_local_ip" nowrap></span>
					</td>
				</tr>
				<tr id="tr_primary_ipv6_dns">
					<td align=right  nowrap><b><script>show_words(wwa_pdns)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="primary_ipv6_dns" nowrap></span>
					</td>
				</tr>
				<tr id="tr_secondary_ipv6_dns">
					<td align=right  nowrap><b><script>show_words(wwa_sdns)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="secondary_ipv6_dns" nowrap></span>
					</td>
				</tr>
				<tr id="tr_dhcp_pd">
					<td align=right  nowrap><b>DHCP-PD :</b></td>
					<td width="300">&nbsp;
						<span id="dhcp_pd" nowrap></span>
					</td>
				</tr>
				<tr id="tr_ipv6_addr_by_dhcppd">
					<td align=right ><b><script>show_words(IPV6_TEXT166)</script> :</b></td>
					<td width="300">&nbsp;
						<span id="ipv6_addr_by_dhcppd" nowrap></span>
					</td>
				</tr>
				</table>
			</div>

			<div class="box">
				<h2 style=" text-transform:none"><script>show_words(TEXT072)</script></h2>
				<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1 id='host6_table'>
				</table>
			</div>
		</div>
		</td>
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
			<tr>
				<td id="help_text"> <strong>
				<script>show_words(_hints)</script>
				&hellip;</strong>
				<p><script>show_words(IPV6_TEXT165)</script></p>
				<p><a href="support_status.asp#IPv6"><script>show_words(_more)</script>&hellip;</a></p>
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
	<form id="form1" name="form1" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_ipv6.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
	<form id="form2" name="form2" method="post" action=""><input type="hidden" id="html_response_page" name="html_response_page" value="st_ipv6.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_ipv6.asp"></form>

	<br>
	<div id="copyright"><script>show_words(_copyright);</script></div>
	<br>
<script>
	onPageLoad();
	WTime();
	hasBgGetDevStatus = true;
</script>
</body>
</html>
