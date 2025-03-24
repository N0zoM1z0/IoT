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
	var submit_button_flag = 0;
	document.title = get_words('TEXT000');

	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=7";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_6RD_i_&inst_2=11110";	
	param.arg +="&oid_3=IGD_LANDevice_i_IPv6ConfigManagement_&inst_3=11100";
	param.arg +="&oid_4=IGD_WANDevice_i_WANConnectionDevice_i_&inst_4=11100";
	param.arg +="&oid_5=IGD_Status_WANStatus_&inst_5=11100";
	param.arg +="&oid_6=IGD_Status_IPv6Status_&inst_6=11100";
	param.arg +="&oid_7=IGD_Status_LANStatus_&inst_7=11100";
	get_config_obj(param);

	//WAN Connection type
	var wan_addr4 = config_val("igdWanStatus_IPAddress_");
	var wan_type = config_val("wanConnDev_CurrentConnObjType_");
	var wan_mac = config_val("igdWanStatus_MACAddress_");
	var lan_mac = config_val("igdLanStatus_MACAddress_");
	//IPv6 connection type
	var ipv6_type = config_val("wanIPv6ConnDev_CurrentConnObjType_");

	//6rd settings
	var enable_hub_spoke_mode = config_val("ipv66rdConn_HubSpokeMode_");
	var config_type = config_val("ipv66rdConn_ConfigurationType_");
	var ipv4_Addr = config_val("ipv66rdConn_IPv4Adress_");
	var assigned_ipv6_prefix = config_val("ipv66rdConn_TunnelLinkLocalPrefix_");
	var tunnel_linklocal_addr = filter_ipv6_addr(config_val("ipv66rdConn_TunnelLinkLocalAddress_"));
	var tunnel_relay_type = config_val("ipv66rdConn_TunnalRelayType_");

	//LAN IPv6 address settings
	var lan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanLinkLocalAddress_"));
	var lan_ipv6_addr = filter_ipv6_addr(config_val("lanIPv6Cfg_Tunnel6rdLanAddress_"));

	//Address autoconfiguration settings
	var enable_address_assignment = config_val("lanIPv6Cfg_AutoV6AddressAssignEnable_");
	var ipv6_dhcpd_start_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeStart_"));
	var ipv6_dhcpd_end_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeEnd_"));

	var wan_ip;
	var last_6rd_dhcp = 1;

	function onPageLoad()
	{
		wan_ip = "172.21.69.17/255.255.240.0/172.21.64.254/172.21.1.1/172.21.1.2".split("/")[0];
		$('#wan_ip').html(wan_ip); //ipv4_Addr;
		$('#wan_ip').html(wan_addr4); //ipv4_Addr;
		ipv6_6rd_link_local();
		link_local = $('#link_local_ip_l').val();

		set_checked(enable_hub_spoke_mode, $('#hub_spoke_mode')[0]);
		set_checked(enable_address_assignment, $('#ipv6_autoconfig_sel')[0]);
		$('#ipv6_autoconfig_type')[0].selectedIndex = config_val("lanIPv6Cfg_AutoConfigurationType_");;
		set_ipv6_autoconfiguration_type();
		set_checked("1", get_by_name("ipv6_dhcp_auto_dns"));
		set_checked(config_type, get_by_name("ipv6_6rd_dhcp"));

		$('#ipv6_6rd_prefix').val(filter_ipv6_addr(config_val("ipv66rdConn_IPv6Prefix_")));
		$('#ipv6_6rd_prefix_length').val(config_val("ipv66rdConn_IPv6PrefixLength_"));
		$('#ipv6_6rd_ipv4_mask_length').val(config_val("ipv66rdConn_IPMaskLength_"));
		$('#ipv6_6rd_assigned_prefix').html(assigned_ipv6_prefix);
		$('#lan_link_local_ip').html(lan_ipv6_linklocal_addr.toUpperCase()+"/64");
		if(tunnel_relay_type == "0")
			$('#ipv6_6rd_relay').val(config_val("ipv66rdConn_Tunnel6rdRelayV4Address_"));
		else
			$('#ipv6_6rd_relay').val(config_val("ipv66rdConn_Tunnel6rdRelayV4Domain_"));
		$('#ipv6_6rd_primary_dns').val(filter_ipv6_addr(config_val("ipv66rdConn_PrimaryDNSAddress_")));
		$('#ipv6_6rd_secondary_dns').val(filter_ipv6_addr(config_val("ipv66rdConn_SecondaryDNSAddress_")));
		if(config_val('igdIPv6Status_IPv4LifeTime_')=="0")
			$('#ipv6_6rd_adver_lifetime').val("10080");
		else
			$('#ipv6_6rd_adver_lifetime').val(config_val('igdIPv6Status_IPv4LifeTime_'));
		if(config_val('igdIPv6Status_IPv4LifeTime_')=="0")
			$('#ipv6_dhcpd_lifetime').val("10080");
		else
			$('#ipv6_dhcpd_lifetime').val(config_val('igdIPv6Status_IPv4LifeTime_'));

		disable_autoconfig();
		dhcp_option();
		set_ipv6_stateful_range();
		set_form_default_values("form1");
	}

	function dhcp_option()
	{
		var ipv6_6rd_dhcp = get_by_name("ipv6_6rd_dhcp");
		if(ipv6_6rd_dhcp[0].checked){
			$('#ipv6_6rd_prefix').attr('disabled',true);
			$('#ipv6_6rd_prefix_length').attr('disabled',true);
			$('#ipv6_6rd_ipv4_mask_length').attr('disabled',true);
			$('#ipv6_6rd_relay').attr('disabled',true);
			$('#ipv6_6rd_adver_lifetime').attr('disabled',true);
			$('#ipv6_dhcpd_lifetime').attr('disabled',true);
			$('#lan_ipv6_ip_lan_ip').html(filter_ipv6_addr(config_val('igdIPv6Status_IPv6LanAddress_')));
			$('#ipv6_6rd_prefix').val(filter_ipv6_addr(config_val('igdIPv6Status_V6rdPrefix_')));
			$('#ipv6_6rd_prefix_length').val(config_val('igdIPv6Status_V6rdPrefixLen_'));
			$('#ipv6_6rd_ipv4_mask_length').val(config_val('igdIPv6Status_V6rdMaskLen_'));
			$('#ipv6_6rd_relay').val(config_val('igdIPv6Status_BorderRelay_'));
		}else{
			$('#ipv6_6rd_prefix').attr('disabled',false);
			$('#ipv6_6rd_prefix_length').attr('disabled',false);
			$('#ipv6_6rd_ipv4_mask_length').attr('disabled',false);
			$('#ipv6_6rd_relay').attr('disabled',false);
			$('#ipv6_6rd_adver_lifetime').attr('disabled',true);
			$('#ipv6_dhcpd_lifetime').attr('disabled',true);
			$('#ipv6_6rd_prefix').val(filter_ipv6_addr(config_val('ipv66rdConn_IPv6Prefix_')));
			$('#ipv6_6rd_prefix_length').val(config_val('ipv66rdConn_IPv6PrefixLength_'));
			$('#ipv6_6rd_ipv4_mask_length').val(config_val('ipv66rdConn_IPMaskLength_'));
			if(tunnel_relay_type == "0")
				$('#ipv6_6rd_relay').val(config_val("ipv66rdConn_Tunnel6rdRelayV4Address_"));
			else
				$('#ipv6_6rd_relay').val(config_val("ipv66rdConn_Tunnel6rdRelayV4Domain_"));
		}
		ipv6_6rd_prefix_onchange();
	}

	function disable_autoconfig()
	{
		var disable = $('#ipv6_autoconfig_sel')[0].checked;
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
		$('#ipv6_autoconfig_type').attr('disabled',!disable);
		$('#ipv6_addr_range_start_suffix').attr('disabled',!disable);
		$('#ipv6_addr_range_end_suffix').attr('disabled',!disable);
		$('#ipv6_dhcpd_lifetime').attr('disabled',true);
		$('#ipv6_6rd_adver_lifetime').attr('disabled',true);
	}

	function generate_eui64(mac)
	{
		var ary_mac = mac.split(":");
		var u8_mac = new Array();
		var eui64 = new Array();
		for (i=0; i<6; i++) {
			u8_mac[i] = parseInt(ary_mac[i],16);
		}
		eui64[0] = u8_mac[0] ^ 0x02;
		eui64[1] = u8_mac[1]
		eui64[2] = u8_mac[2]
		eui64[3] = 0xff;
		eui64[4] = 0xfe;
		eui64[5] = u8_mac[3];
		eui64[6] = u8_mac[4];
		eui64[7] = u8_mac[5];
		return parseInt(eui64[0].toString(16) + eui64[1].toString(16).lpad("0",2), 16).toString(16) + ":" +
		parseInt(eui64[2].toString(16) + eui64[3].toString(16).lpad("0",2), 16).toString(16) + ":" +
		parseInt(eui64[4].toString(16) + eui64[5].toString(16).lpad("0",2), 16).toString(16) + ":" +
		parseInt(eui64[6].toString(16) + eui64[7].toString(16).lpad("0",2), 16).toString(16) ;
	}

	function ipv6_6rd_link_local()
	{
		var u32_pf;
		var ary_ip6rd_pf = [0,0];
		var pf = $('#ipv6_6rd_prefix').val();
		var ary_ip4 = wan_addr4.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);
		u32_pf = parseInt(u32_ip4);
		str_tmp = u32_pf.toString(16).lpad("0",8);
		ary_ip6rd_pf[0] = str_tmp.substr(0,4);
		ary_ip6rd_pf[1] = str_tmp.substr(4,4);
		$('#ipv6_6rd_addr').html( ("FE80::"+ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+"/64").toUpperCase());
	}

	function ipv6_6rd_prefix_onchange()
	{
		var pf = $('#ipv6_6rd_prefix').val();
		var pf_len = $('#ipv6_6rd_prefix_length').val();
		var v4_masklen = $('#ipv6_6rd_ipv4_mask_length').val();
		var v4_uselen;
		var eui64;
		var ary_ip4 = wan_addr4.split(".");
		var u32_ip4 = (ary_ip4[0]*Math.pow(2,24)) + (ary_ip4[1]*Math.pow(2,16)) + (ary_ip4[2]*Math.pow(2,8)) + parseInt(ary_ip4[3]);

		var ary_pf = get_stateful_ipv6(pf).split(":");
		var u32_pf = [0,0];
		var mask_len;
		var ary_ip6rd_pf = [0,0,0,0];
		var str_tmp;
		var IsValid = true;
		var ipv6_6rd_dhcp = get_by_name("ipv6_6rd_dhcp");

		if (IsValid) {
			if ( (pf_len-0)==pf_len && pf_len.length>0 ) {
				pf_len = parseInt(pf_len);
				if (pf_len<1 || pf_len>63)
					IsValid = false;
			}else
				IsValid = false;
		}

		if (pf_len <= 32) {
			$('#ipv6_6rd_ipv4_mask_length').attr('disabled',true);
			$('#ipv6_6rd_ipv4_mask_length').val("0");
		}else{
			if(ipv6_6rd_dhcp[0].checked)
				$('#ipv6_6rd_ipv4_mask_length').attr('disabled',true);
			else
				$('#ipv6_6rd_ipv4_mask_length').attr('disabled',false);
		}

		if (IsValid && pf_len >32){
			if ( (v4_masklen-0)==v4_masklen && v4_masklen.length>0 ){
				v4_masklen = parseInt(v4_masklen);
				v4_uselen = 32 - v4_masklen;
				if (v4_masklen<1 || v4_masklen>31 || v4_uselen+pf_len > 64)
					IsValid = false;
			}else
				IsValid = false;
		}

		var c;
		var tmp_ary_pf = pf.split("::");
		if (IsValid && pf=="")
			IsValid = false;
		if (IsValid && ((tmp_ary_pf.length>1 && tmp_ary_pf[1]==":") || tmp_ary_pf.length>2))
			IsValid = false;
		if (IsValid)
		{
			for (var idx=0; idx < ary_pf.length; idx++) {
				if (idx>0 && ary_pf[idx]=="")
				ary_pf[idx] = "0";
				if (ary_pf[idx].length>=1 && ary_pf[idx].length<=4)
				{
					for(var pos=0; pos < ary_pf[idx].length; pos++) 
					{
						if( !check_hex(ary_pf[idx].charAt(pos)))
							IsValid = false;
					}
				}else{
					IsValid = false;
					break;
				}
			}
			if (ary_pf.length<2) ary_pf[1] = "0";
			if (ary_pf.length<3) ary_pf[2] = "0";
			if (ary_pf.length<4) ary_pf[3] = "0";
		}

		if (!IsValid){
			$('#ipv6_6rd_assigned_prefix').html(get_words(_none));
			$('#lan_ipv6_ip_lan_ip').html(get_words(_none));
			return;
		}
		if (ary_pf.length >=1 ){
			u32_pf[0] = parseInt( ary_pf[0].lpad("0",4) + ary_pf[1].lpad("0",4), 16);
			if (pf_len == 32){
				u32_pf[1] = parseInt(u32_ip4);
			}else if (pf_len < 32){
				mask_len = (32-pf_len);
				u32_pf[0] = (u32_pf[0] >>> mask_len) * Math.pow(2,mask_len);
				u32_pf[0] = parseInt(u32_pf[0]) + (u32_ip4 >>> pf_len);
				u32_pf[1] = (u32_ip4 - ((u32_ip4 >>> pf_len) * Math.pow(2,pf_len))) * Math.pow(2,mask_len);
			}else{
				u32_pf[1] = parseInt( ary_pf[2].lpad("0",4) + ary_pf[3].lpad("0",4), 16);
				mask_len = (64-pf_len);
				u32_pf[1] = (u32_pf[1] >>> mask_len) * Math.pow(2,mask_len);
				u32_ip4 = u32_ip4 % (1*Math.pow(2,v4_uselen));
				u32_pf[1] = parseInt(u32_pf[1]) + (u32_ip4*Math.pow(2,64-pf_len-v4_uselen));
			}
		}

		if (pf_len <= 32) {
			eui64 = generate_eui64(lan_mac);
			str_tmp = u32_pf[0].toString(16).lpad("0",8);
			ary_ip6rd_pf[0] = str_tmp.substr(0,4);
			ary_ip6rd_pf[1] = str_tmp.substr(4,4);
			str_tmp = u32_pf[1].toString(16).lpad("0",8);
			ary_ip6rd_pf[2] = str_tmp.substr(0,4);
			ary_ip6rd_pf[3] = str_tmp.substr(4,4);
			$('#ipv6_6rd_assigned_prefix').html(
			(ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]).toUpperCase()+"::/"+(pf_len + 32));
			str_tmp = ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]+":"+eui64;
			$('#lan_ipv6_ip_lan_ip').html(filter_ipv6_addr(str_tmp).toUpperCase() + "/64");
		}else{
			eui64 = generate_eui64(lan_mac);
			str_tmp = u32_pf[0].toString(16).lpad("0",8);
			ary_ip6rd_pf[0] = str_tmp.substr(0,4);
			ary_ip6rd_pf[1] = str_tmp.substr(4,4);
			str_tmp = u32_pf[1].toString(16).lpad("0",8);
			ary_ip6rd_pf[2] = str_tmp.substr(0,4);
			ary_ip6rd_pf[3] = str_tmp.substr(4,4);
			$('#ipv6_6rd_assigned_prefix').html(
			(ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]).toUpperCase()+"::/"+(pf_len + v4_uselen));
			str_tmp = ary_ip6rd_pf[0]+":"+ary_ip6rd_pf[1]+":"+ary_ip6rd_pf[2]+":"+ary_ip6rd_pf[3]+":"+eui64;
			$('#lan_ipv6_ip_lan_ip').html(filter_ipv6_addr(str_tmp).toUpperCase() + "/64");
		}
		set_ipv6_autoconf_range();
	}

	function set_ipv6_autoconf_range(){
		var ipv6_6rd_lan_prefix = get_stateful_prefix($('#lan_ipv6_ip_lan_ip').html(), 64);
		if(ipv6_6rd_lan_prefix != ""){
			$('#ipv6_addr_range_start_prefix').val(ipv6_6rd_lan_prefix.toUpperCase());
			$('#ipv6_addr_range_end_prefix').val(ipv6_6rd_lan_prefix.toUpperCase());
		}
	}

	function set_ipv6_stateful_range()
	{
		var prefix_length = 64;
		var ipv6_lan_ip = $('#lan_ipv6_ip_lan_ip').html();
		var correct_ipv6="";
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			$('#ipv6_addr_range_start_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
			$('#ipv6_addr_range_end_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));	
		}
		$('#ipv6_addr_range_start_suffix').val(get_stateful_suffix(ipv6_dhcpd_start_range));	
		$('#ipv6_addr_range_end_suffix').val(get_stateful_suffix(ipv6_dhcpd_end_range));	
	}

	function set_ipv6_autoconfiguration_type(){
		var mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		switch(mode){
		case 0:
			$('#show_ipv6_addr_range_start').hide();
			$('#show_ipv6_addr_range_end').hide();
			$('#show_ipv6_addr_lifetime').hide();
			$('#show_router_advert_lifetime').show();
			break;
		case 1:
			$('#show_ipv6_addr_range_start').hide();
			$('#show_ipv6_addr_range_end').hide();
			$('#show_ipv6_addr_lifetime').hide();
			$('#show_router_advert_lifetime').show();
			break;
		case 2:
			set_ipv6_autoconf_range();
			$('#ipv6_addr_range_start_prefix').attr('disabled',true);
			$('#ipv6_addr_range_end_prefix').attr('disabled',true);
			$('#show_ipv6_addr_range_start').show();
			$('#show_ipv6_addr_range_end').show();
			$('#show_ipv6_addr_lifetime').show();
			$('#show_router_advert_lifetime').hide();
			break;
		default:
			$('#show_ipv6_addr_range_start').hide();
			$('#show_ipv6_addr_range_end').hide();
			$('#show_ipv6_addr_lifetime').hide();
			$('#show_channel_width').show();
			break;
		} 
	}

	function trim(stringToTrim) {
		return stringToTrim.replace(/^\s+|\s+$/g,"");
	}

	function send_request()
	{
		var primary_dns = $('#ipv6_6rd_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_pdns));
		var secondary_dns = $('#ipv6_6rd_secondary_dns').val();
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_sdns));
		var check_mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		var enable_autoconfig = get_checked_value($('#ipv6_autoconfig_sel')[0]);
		var addr_lifetime_msg = replace_msg(check_num_msg, get_words(IPV6_TEXT68), 1, 999999);
		var addr_lifetime_obj = new varible_obj($('#ipv6_dhcpd_lifetime').val(), addr_lifetime_msg, 1, 999999, false);
		var adver_lifetime_msg = replace_msg(check_num_msg, get_words(IPV6_TEXT69), 1, 999999);
		var adver_lifetime_obj = new varible_obj($('#ipv6_6rd_adver_lifetime').val(), adver_lifetime_msg , 1, 999999, false);
		var ipv6_addr_s_suffix = $('#ipv6_addr_range_start_suffix').val();
		var ipv6_addr_e_suffix = $('#ipv6_addr_range_end_suffix').val();
		var v6_6rd_relay = $('#ipv6_6rd_relay').val();
		var ipv6_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
		var v6_6rd_relay_obj = new addr_obj(v6_6rd_relay.split("."), ipv6_addr_msg, false, false);
		var v6_6rd_addr;
		var temp_v6_6rd_addr;
		var ipv6_6rd_dhcp = get_by_name("ipv6_6rd_dhcp");

		if ($('#ipv6_wan_proto').val() == $('#ipv6_w_proto').val()) {
			if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange')))
				return false;
		}

		if (primary_dns != ""){
			if(primary_dns != "0:0:0:0:0:0:0:0"){
				if(check_ipv6_symbol(primary_dns,"::")==2)
					return false;
				else if(check_ipv6_symbol(primary_dns,"::")==1){
					temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
					if (!check_ipv6_address(temp_ipv6_primary_dns ,"::"))
						return false;
				}else{
					temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
					if (!check_ipv6_address(temp_ipv6_primary_dns,":"))
						return false;
					}
			}
		}

		if (secondary_dns != ""){
			if(secondary_dns != "0:0:0:0:0:0:0:0"){
				if(check_ipv6_symbol(secondary_dns,"::")==2){ 
					return false;
				}else if(check_ipv6_symbol(secondary_dns,"::")==1){ 
				temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::"))
					return false;
				}else{
					temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
					if (!check_ipv6_address(temp_ipv6_secondary_dns,":"))
						return false;
				}
			}
		}

		if (ipv6_6rd_dhcp[0].checked){
			if(wan_type != 1){
				alert(get_words(IPv6_6rd_wan));
				return false;
			}
		}else{
			if (trim(v6_6rd_relay)==""){
				alert(get_words(IPv6_6rd_relay));
				return false;
			}
			if(Find_word(v6_6rd_relay,":")){
				alert(get_words(LS46));
				return false;
			}
			if(is_ipv4_valid(v6_6rd_relay))
				tunnel_relay_type = 0;
			else
				tunnel_relay_type = 1;

			v6_6rd_addr = $('#lan_ipv6_ip_lan_ip').html().split("/")[0];
			temp_v6_6rd_addr = new ipv6_addr_obj(v6_6rd_addr.split(":"), replace_msg(all_ipv6_addr_msg,get_words(IPV6_TEXT46)), false, false);
			if (!check_ipv6_address(temp_v6_6rd_addr,":"))
				return false;
		}
		$('#ipv6_wan_proto').val($('#ipv6_w_proto').val());

		if((check_mode == 0 || check_mode == 1) && enable_autoconfig == 1){
			if (!check_varible(adver_lifetime_obj))
				return false;

		$('#ipv6_ra_adv_valid_lifetime_l_one').val($('#ipv6_6rd_adver_lifetime').val() * 60) ;
		$('#ipv6_ra_adv_prefer_lifetime_l_one').val($('#ipv6_6rd_adver_lifetime').val() * 60) ;
		}else if(check_mode == 2 && enable_autoconfig == 1){
			if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,get_words(IPv6_addrSr)))
				return false;
			if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,get_words(IPv6_addrEr)))
				return false;
			if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix))
				return false;
			if (!check_varible(addr_lifetime_obj))
				return false;

			$('#ipv6_dhcpd_start').val($('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val());
			$('#ipv6_dhcpd_end').val($('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val());	
		}

		if (submit_button_flag == 0) {
			submit_button_flag = 1;
			submit_6rd();
			return true;
		}else{
			return false;
		}
	}

	String.prototype.lpad = function(padString, length) {
		var str = this;
		while (str.length < length)
		str = padString + str;
		return str;
	}

	function submit_6rd()
	{
		var param6rd = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6&nextPage=sel_ipv6.asp'
		};

		param6rd.arg += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=6";
		param6rd.arg += "&ipv66rdConn_HubSpokeMode_1.1.1.1.0="+get_checked_value($('#hub_spoke_mode')[0]);
		param6rd.arg += "&ipv66rdConn_ConfigurationType_1.1.1.1.0="+ get_checked_value(get_by_name("ipv6_6rd_dhcp"));
		param6rd.arg += "&ipv66rdConn_IPv6Prefix_1.1.1.1.0="+$('#ipv6_6rd_prefix').val();
		param6rd.arg += "&ipv66rdConn_IPv6PrefixLength_1.1.1.1.0="+$('#ipv6_6rd_prefix_length').val();
		param6rd.arg += "&ipv66rdConn_IPMaskLength_1.1.1.1.0="+$('#ipv6_6rd_ipv4_mask_length').val();
		param6rd.arg += "&ipv66rdConn_PrimaryDNSAddress_1.1.1.1.0="+$('#ipv6_6rd_primary_dns').val();
		param6rd.arg += "&ipv66rdConn_SecondaryDNSAddress_1.1.1.1.0="+$('#ipv6_6rd_secondary_dns').val();
		if($('#ipv6_6rd_assigned_prefix').html() != get_words(_none))
		{
			var tmpprefix = $('#ipv6_6rd_assigned_prefix').html();
			var assign_prefix = tmpprefix.split("/");
			param6rd.arg += "&ipv66rdConn_AssignedIPv6Prefix_1.1.1.1.0="+assign_prefix[0];
			param6rd.arg += "&ipv66rdConn_TunnelLinkLocalPrefix_1.1.1.1.0="+assign_prefix[1];
		}

		param6rd.arg += "&ipv66rdConn_TunnalRelayType_1.1.1.1.0="+tunnel_relay_type;
		if(tunnel_relay_type == 0)
			param6rd.arg += "&ipv66rdConn_Tunnel6rdRelayV4Address_1.1.1.1.0="+$('#ipv6_6rd_relay').val();
		else
			param6rd.arg += "&ipv66rdConn_Tunnel6rdRelayV4Domain_1.1.1.1.0="+$('#ipv6_6rd_relay').val();

		if($('#lan_ipv6_ip_lan_ip').html()!=get_words(_none))
		{
			tmpprefix = $('#lan_ipv6_ip_lan_ip').html();
			assign_prefix = tmpprefix.split("/");
			param6rd.arg += "&lanIPv6Cfg_Tunnel6rdLanAddress_1.1.1.0.0="+assign_prefix[0];
		}

		param6rd.arg += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0="+get_checked_value($('#ipv6_autoconfig_sel')[0]);
		param6rd.arg += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0="+$('#ipv6_autoconfig_type')[0].selectedIndex;
		param6rd.arg += "&lanIPv6Cfg_AdvertisementLifetime_1.1.1.0.0="+$('#ipv6_6rd_adver_lifetime').val();
		param6rd.arg += "&lanIPv6Cfg_DHCPv6AddressRangeStart_1.1.1.0.0="+$('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val();
		param6rd.arg += "&lanIPv6Cfg_DHCPv6AddressRangeEnd_1.1.1.0.0="+$('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val();
		param6rd.arg += "&lanIPv6Cfg_IPv6AddressLifeTime_1.1.1.0.0="+$('#ipv6_dhcpd_lifetime').val();
		get_config_obj(param6rd);
	}

</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><script>document.write(dev_info.model);</script></a></td>
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
		<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table cellSpacing=0 cellPadding=0 border=0>
			<tbody>
			<tr>
				<td id=sidenav_container>
				<div id=sidenav>
					<ul>
						<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
						<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
						<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
						<li><div id="sidenavon"><a href="storage_setup.asp" onclick="return jump_if();"><script>show_words(storage)</script></a></div></li>
						<li><div id="sidenavoff"><script>show_words(IPV6_TEXT137)</script></a></div></li>
						<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
					</ul>
				</div>
				</td>
			</tr>
			</tbody>
		</table></td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>$('#html_response_message').val(sc_intro_sv);</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6rd.asp">
			<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="1">
			<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="2002:ac15:4511:9::99">
			<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="2002:ac15:4511:9::9999">
			<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto">
			<input type="hidden" maxLength=80 size=80 name="ipv6_6rd_tunnel_address" id="ipv6_6rd_tunnel_address" value="">
			<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="fe80::224:1ff:feff:423e/64">
			<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="60000">
			<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="60000">
			<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
			<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">

		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id="maincontent">
			<div id="box_header">
				<h1><script>show_words(ipv6)</script></h1>
				<script>show_words(IPV6_TEXT28)</script><br>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_6rd.asp');">
				<script>$('#button').val(get_words('_savesettings'));</script>
				<script>$('#button2').val(get_words('_dontsavesettings'));</script>
			</div>

			<div class=box>
				<h2 style=" text-transform:none"> 
				<script>show_words(IPV6_TEXT29)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT30)</script></p>	
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td align=right width="187" class="duple"><script>show_words(IPV6_TEXT31)</script> :</td>
					<td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange='change_ipv6_type()'>
						<option value="0"><script>show_words(IPV6_TEXT138)</script></option>
						<option value="1"><script>show_words(IPV6_TEXT32)</script></option>
						<option value="2"><script>show_words(IPV6_TEXT107)</script></option>
						<option value="3"><script>show_words(IPV6_TEXT34)</script></option>
						<option value="4"><script>show_words(IPV6_TEXT35)</script></option>
						<option value="5"><script>show_words(IPV6_TEXT36)</script></option>
						<option value="6" selected><script>show_words(IPV6_TEXT139)</script></option>
						<option value="7"><script>show_words(IPV6_TEXT37)</script></option>
					</select></td>
				</tr>
				</table>
			</div>
			<div class=box id=wan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(_6rd_settings)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT61)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>	
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT167)</script> :</td>
					<td width="331">&nbsp;<input name="hub_spoke_mode" type=checkbox id="hub_spoke_mode" value="1"></td>
				</tr>
				<tr>
					<td width="185" align=right class="duple"><script>show_words(IPV6_TEXT142)</script> :</td>
					<td width="331">&nbsp;
						<input type="radio" name="ipv6_6rd_dhcp" value="0" onClick="dhcp_option()" checked> <script>show_words(IPV6_TEXT143)</script>
						<input type="radio" name="ipv6_6rd_dhcp" value="1" onClick="dhcp_option()"> <script>show_words(IPV6_TEXT144)</script>
					</td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT132)</script> :</td>
					<td width="331">&nbsp;<b><input type=text id="ipv6_6rd_prefix" name="ipv6_6rd_prefix" size="22" maxlength="21" value="" onChange="ipv6_6rd_prefix_onchange()">/<input type=text id="ipv6_6rd_prefix_length" name="ipv6_6rd_prefix_length" size="5" maxlength="2" value="32" onChange="ipv6_6rd_prefix_onchange()">
					</b></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script></script> 
						<script>show_words(ipv4_addr)</script>:</td>
					<td width="331">&nbsp;<span id="wan_ip"></span>&nbsp;&nbsp;&nbsp;<b><script>show_words(mask_len)</script>:</b><input type=text id="ipv6_6rd_ipv4_mask_length" name="ipv6_6rd_ipv4_mask_length" size="5" maxlength="2" value="0" onChange="ipv6_6rd_prefix_onchange()"></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT133)</script> :</td>
					<td width="331">&nbsp;<b><span id="ipv6_6rd_assigned_prefix"></span></b></td>
				</tr>
				<tr style="display:none">
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT145)</script> :</td>
					<td width="331">&nbsp;<b><span id="ipv6_6rd_addr"></span></b></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT134)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6rd_relay" name="ipv6_6rd_relay" size="30" maxlength="39" value=""></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_dns1_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6rd_primary_dns" name="ipv6_6rd_primary_dns" size="30" maxlength="39" value=""></td>
				</tr>
				<tr> 
					<td width="187" align=right class="duple"><script>show_words(_dns2_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6rd_secondary_dns" name="ipv6_6rd_secondary_dns" size="30" maxlength="39" value=""></td>
				</tr>
				</table>
			</div>
			<div class=box id=lan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44)</script></h2>
				<p align="justify" class="style1"><script>show_words(IPV6_TEXT45)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT46)</script> :</td>
					<td width="331">&nbsp;
						<b><span id="lan_ipv6_ip_lan_ip"></span></b>
					</td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT47)</script> :</td>
					<td width="331">&nbsp;
						<b><span id="lan_link_local_ip"></span></b>
					</td>
				</tr>
				</table>
			</div>
			<div class="box" id=ipv6_autoconfiguration_settings> 
				<h2><script>show_words(IPV6_TEXT48)</script></h2>
				<p align="justify" class="style1"><script>show_words(IPV6_TEXT49)</script><script>show_words(IPV6_TEXT164)</script></p>
				<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT105)</script> :</td>
					<td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onclick="disable_autoconfig()"></td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(IPV6_TEXT51)</script> :</td>
					<td width="331">&nbsp;
						<select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
							<option value="rdnss"><script>show_words(IPV6_TEXT157)</script></option>
							<option value="stateless"><script>show_words(IPV6_TEXT106)</script></option>
							<option value="stateful"><script>show_words(IPV6_TEXT53)</script></option>
						</select>
					</td>
				</tr>
				<tr id="show_ipv6_addr_range_start" style="display:none">
					<td class="duple"><script>show_words(IPV6_TEXT54)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="20" maxlength="19">
						:: <input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
					</td>
				</tr>
				<tr id="show_ipv6_addr_range_end" style="display:none">
					<td class="duple"><script>show_words(IPV6_TEXT55)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
						:: <input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
					</td>
				</tr> 
				<tr id="show_ipv6_addr_lifetime" style="display:none"> 
					<td class="duple"><script>show_words(IPV6_TEXT56)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="6" value="1450">
						<script>show_words(_minutes)</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
					<td class="duple"><script>show_words(IPV6_TEXT57)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_6rd_adver_lifetime" name="ipv6_6rd_adver_lifetime" size="20" maxlength="6" value="">
						<script>show_words(_minutes)</script></td>
				</tr>
				</table>
			</div>
		</td>
		</form>
			<!-- ######################### -->
			<!--      end of main part     -->
			<!-- ######################### -->

		<!-- user tips -->
		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
		cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
			<tbody>
			<tr>
				<td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
					<p><script>show_words(IPV6_TEXT58)</script></p>
					<p><script>show_words(IPV6_TEXT59)</script></p>
					<p><a href="support_internet.asp#ipv6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
				</td>
			</tr>
			</tbody>
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
	onPageLoad();
</script>
</html>