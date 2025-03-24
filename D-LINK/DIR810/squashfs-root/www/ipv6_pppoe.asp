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
	var ipv6_pppoe_lan_prefix;
	document.title = get_words('TEXT000');

	var param = {
	url: "get_set.ccp",
	arg: ""
	};
	param.arg = "ccp_act=get&num_inst=6";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_PPPoE_i_&inst_2=11110";	
	param.arg +="&oid_3=IGD_LANDevice_i_IPv6ConfigManagement_&inst_3=11100";
	param.arg +="&oid_4=IGD_Status_IPv6Status_&inst_4=11100";
	param.arg +="&oid_5=IGD_WANDevice_i_WANConnectionDevice_i_&inst_5=11100";
	param.arg +="&oid_6=IGD_WANDevice_i_WANConnectionDevice_i_PPPoE_i_&inst_6=11110";
	get_config_obj(param);

	var wan_type = config_val("wanConnDev_CurrentConnObjType_");
	//IPv6 connection type
	var ipv6_type = config_val("wanIPv6ConnDev_CurrentConnObjType_");

	//PPPoE
	var session_type = config_val("ipv6PPPoEConn_SessionType_");
	var address_typr = config_val("ipv6PPPoEConn_IPAddressType_");
	var reconnect_mode = config_val("ipv6PPPoEConn_ConnectionTrigger_");
	var static_ip = filter_ipv6_addr(config_val("ipv6PPPoEConn_ExternalIPAddress_"));
	//IPv6 DNS settings
	var auto_dns_enable = config_val("ipv6PPPoEConn_AutomaticDNSServer_");

	//LAN IPv6 address settings
	var lan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanLinkLocalAddress_"));
	var dhcppd_enable = config_val("lanIPv6Cfg_DHCPPDEnable_");

	//Address autoconfiguration settings  
	var enable_address_assignment = config_val("lanIPv6Cfg_AutoV6AddressAssignEnable_");
	var auto_dhcppd_enable = config_val("lanIPv6Cfg_AutoDHCPPDEnable_");
	var ipv6_dhcpd_start_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeStart_"));
	var ipv6_dhcpd_end_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeEnd_"));

	function onPageLoad()
	{
		//PPPoE
		set_checked(session_type, get_by_name("ipv6_pppoe_share"));
		set_checked(address_typr, get_by_name("ipv6_pppoe_dynamic"));
//		set_checked(reconnect_mode, get_by_name("ipv6_pppoe_connect_mode"));
		
		$('#ipv6_pppoe_ipaddr').val(static_ip);

		check_v4v6_mode();

		/*
		**    Date:		2013-05-05
		**    Author:	Silvia Chang
		**    Reason:   rm dial-on-demand, follow IPv6 spec 2.06.
		**				rm idle disconnect time on the same time.
		**/

		disable_ipv6_poe_ip();
		//IPv6 DNS settings

		set_checked(auto_dns_enable, get_by_name("ipv6_dns_pppoe_enable"));
		$('#ipv6_pppoe_primary_dns').val(filter_ipv6_addr(config_val("ipv6PPPoEConn_PrimaryDNSAddress_")));
		$('#ipv6_pppoe_secondary_dns').val(filter_ipv6_addr(config_val("ipv6PPPoEConn_SecondaryDNSAddress_")));
		disable_ipv6_pppoe_auto_dns();

		//LAN IPv6 address settings
		$('#ipv6_pppoe_lan_ip').val(filter_ipv6_addr(config_val("lanIPv6Cfg_PPPoELanAddress_")));
		$('#lan_link_local_ip').html(lan_ipv6_linklocal_addr.toUpperCase()+"/64");
		set_checked(dhcppd_enable, $('#ipv6_dhcp_pd_chk')[0]);
		disable_ipv6_dhcp_pd_chk();

		//Address autoconfiguration settings
		set_checked(enable_address_assignment, $('#ipv6_autoconfig_sel')[0]);
		set_checked(auto_dhcppd_enable, $('#ipv6_dhcp_pd_lan')[0]);
		$('#ipv6_autoconfig_type')[0].selectedIndex = config_val("lanIPv6Cfg_AutoConfigurationType_"); 
		$('#ipv6_pppoe_adver_lifetime').val(config_val("lanIPv6Cfg_AdvertisementLifetime_"));
		$('#ipv6_dhcpd_lifetime').val(config_val("lanIPv6Cfg_IPv6AddressLifeTime_"));
		set_ipv6_autoconfiguration_type();
		set_ipv6_stateful_range();
		disable_ipv6_dhcp_pd_chk();
		disable_autoconfig();
		set_form_default_values("form1");
	}

	function disable_autoconfig()	//20120207 fix with 835
	{
		var selchk = $('#ipv6_autoconfig_sel')[0].checked;
		var pdchk = $('#ipv6_dhcp_pd_chk')[0].checked;
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
		disabled_field('ipv6_addr_range_start_suffix',!selchk);
		disabled_field('ipv6_addr_range_end_suffix',!selchk);
		disabled_field('ipv6_autoconfig_type',!selchk);
		disabled_field('ipv6_dhcp_pd_lan',true);
		disabled_field('ipv6_pppoe_adver_lifetime',true);
		disabled_field('ipv6_dhcpd_lifetime',true);

		if (selchk == true)
		{
			if (pdchk == false)
			{
				disabled_field('ipv6_dhcpd_lifetime',false);
				disabled_field('ipv6_pppoe_adver_lifetime',false);
			}else
				disabled_field('ipv6_dhcp_pd_lan',false);
		}
	}

	function check_v4v6_mode()
	{
		var disable = get_by_name("ipv6_pppoe_share")[1].checked;
		$('#ipv6_pppoe_username').attr('disabled',!disable);
		$('#ipv6_pppoe_password_s').attr('disabled',!disable);
		$('#ipv6_pppoe_password_v').attr('disabled',!disable);
		$('#ipv6_pppoe_service').attr('disabled',!disable);
		get_by_name("ipv6_pppoe_connect_mode")[0].disabled = !disable;
//		get_by_name("ipv6_pppoe_connect_mode")[1].disabled = !disable;
		get_by_name("ipv6_pppoe_connect_mode")[2].disabled = !disable;
//		$('#ipv6_pppoe_idle_time').attr('disabled',!disable);
		$('#ipv6_pppoe_mtu').attr('disabled',!disable);
		if(disable == 0)
			print_ipv4_pppoe();
		else
			print_ipv6_pppoe();
	}

	function print_ipv4_pppoe()
	{
		$('#ipv6_pppoe_username').val(config_val('pppoeCfg_Username_'));
		$('#ipv6_pppoe_password_s').val('WDB8WvbXdH');
		$('#ipv6_pppoe_password_v').val('WDB8WvbXdH');
		$('#ipv6_pppoe_service').val(unescape(config_val('pppoeCfg_ServiceName_')));
		$('#ipv6_pppoe_mtu').val(config_val('pppoeCfg_MaxMTUSize_'));
		$('#ipv6_pppoe_idle_time').val(config_val("pppoeCfg_IdleDisconnectTime_"));
		set_checked(config_val('pppoeCfg_ConnectionTrigger_'), get_by_name("ipv6_pppoe_connect_mode"));
	}

	function print_ipv6_pppoe()
	{
		$('#ipv6_pppoe_username').val(config_val("ipv6PPPoEConn_Username_"));
		$('#ipv6_pppoe_password_s').val(config_val("ipv6PPPoEConn_Password_")!=''?'HlacJghQyG':'');
		$('#ipv6_pppoe_password_v').val(config_val("ipv6PPPoEConn_Password_")!=''?'HlacJghQyG':'');
		$('#ipv6_pppoe_service').val(config_val("ipv6PPPoEConn_ServiceName_"));
		$('#ipv6_pppoe_mtu').val(config_val("ipv6PPPoEConn_MaxMTUSize_"));
		$('#ipv6_pppoe_idle_time').val(config_val("ipv6PPPoEConn_IdleDisconnectTime_"));
		set_checked(reconnect_mode, get_by_name("ipv6_pppoe_connect_mode"));
	}

	function disable_ipv6_poe_ip(){
		var fixIP = get_by_name("ipv6_pppoe_dynamic");
		$('#ipv6_pppoe_ipaddr').attr('disabled',fixIP[0].checked).val(fixIP[0].checked?'':static_ip);
	}

/*
	function check_ipv6_pppoe_connectmode(){
		var conn_mode = get_by_name("ipv6_pppoe_connect_mode");
		$('#ipv6_pppoe_idle_time').attr('disabled',!conn_mode[1].checked);
	}
*/

	function disable_ipv6_pppoe_auto_dns(){
		var fixIP = get_by_name("ipv6_dns_pppoe_enable");
		$('#ipv6_pppoe_primary_dns').attr('disabled',fixIP[0].checked);
		$('#ipv6_pppoe_secondary_dns').attr('disabled',fixIP[0].checked);
		if(fixIP[0].checked)
		{
			$('#ipv6_pppoe_primary_dns').val(filter_ipv6_addr(config_val('igdIPv6Status_PrimaryDNSAddress_')));
			$('#ipv6_pppoe_secondary_dns').val(filter_ipv6_addr(config_val('igdIPv6Status_SecondaryDNSAddress_')));
		}
		else
		{
			$('#ipv6_pppoe_primary_dns').val(filter_ipv6_addr(config_val("ipv6PPPoEConn_PrimaryDNSAddress_")));
			$('#ipv6_pppoe_secondary_dns').val(filter_ipv6_addr(config_val("ipv6PPPoEConn_SecondaryDNSAddress_")));
		}
	}

	function disabled_field(fe_name, act)
	{
		$('#'+fe_name).attr('disabled',act);
	}

	function disable_ipv6_dhcp_pd_chk(){	//20120207 fix with 835
		var pdchk = $('#ipv6_dhcp_pd_chk')[0].checked;
		var selchk = $('#ipv6_autoconfig_sel')[0].checked;
		disabled_field('ipv6_pppoe_lan_ip',pdchk);
		disabled_field('ipv6_dhcpd_lifetime',pdchk);
		disabled_field('ipv6_dhcp_pd_lan',true);
		disabled_field('ipv6_pppoe_adver_lifetime',true);

		if (pdchk == true)
		{
			if (selchk == true)
				disabled_field('ipv6_dhcp_pd_lan',false);
		}else{
			if (selchk == true)
				disabled_field('ipv6_pppoe_adver_lifetime',false);
		}

		if($('#ipv6_dhcp_pd_chk')[0].checked)
		{
			$('#ipv6_pppoe_lan_ip').val(filter_ipv6_addr(config_val('igdIPv6Status_IPv6LanAddress_')));
			set_ipv6_autoconf_range();
			$('#ipv6_pppoe_adver_lifetime').val(config_val("igdIPv6Status_IPv6LifeTime_"));
			$('#ipv6_dhcpd_lifetime').val(config_val("igdIPv6Status_IPv6LifeTime_"));
		}
		else
		{
			$('#ipv6_pppoe_adver_lifetime').val(config_val("lanIPv6Cfg_AdvertisementLifetime_"));
			$('#ipv6_dhcpd_lifetime').val(config_val("lanIPv6Cfg_IPv6AddressLifeTime_"));
		}
	}

	function set_ipv6_autoconf_range(){
		var ipv6_lan_ip = $('#ipv6_pppoe_lan_ip').val();
		var prefix_length = 64;
		var correct_ipv6="";
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			$('#ipv6_addr_range_start_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
			$('#ipv6_addr_range_end_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
		}
	}

	function set_ipv6_stateful_range()
	{
		var prefix_length = 64;
		var ipv6_lan_ip = $('#ipv6_pppoe_lan_ip').val();
		var correct_ipv6="";
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			$('#ipv6_addr_range_start_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
			$('#ipv6_addr_range_end_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
		}
		$('#ipv6_addr_range_start_suffix').val(get_stateful_suffix(ipv6_dhcpd_start_range));
		$('#ipv6_addr_range_end_suffix').val(get_stateful_suffix(ipv6_dhcpd_end_range));
	}

	function set_ipv6_autoconfiguration_type()
	{
		var mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		switch(mode){
			case 1: //Stateless
				$('#show_ipv6_addr_range_start').hide();
				$('#show_ipv6_addr_range_end').hide();
				$('#show_ipv6_addr_lifetime').hide();
				$('#show_router_advert_lifetime').show();
				break;
			case 2: //Stateful DHCPv6
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
				$('#show_router_advert_lifetime').show();
				//$('#show_channel_width').show();
				break;
		}
		disable_ipv6_dhcp_pd_chk();
	}

	function send_request(){
		var fixDNSIP = get_by_name("ipv6_dns_pppoe_enable");
		var pppoe_share = get_by_name("ipv6_pppoe_share");
		var pppoe_dynamic = get_by_name("ipv6_pppoe_dynamic");
		var pppoe_srv_name = $('#ipv6_pppoe_service').val();
		var pppoe_ip = $('#ipv6_pppoe_ipaddr').val();
		var pppoe_ip_msg = replace_msg(all_ip_addr_msg,get_words('IPV6_TEXT43'));
		var temp_pppoe_ip = new ipv6_addr_obj(pppoe_ip.split(":"), pppoe_ip_msg, false, false);
//		var conn_mode = get_by_name("ipv6_pppoe_connect_mode");
		var check_mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		var enable_autoconfig = $('#ipv6_autoconfig').val();
//		var idle_time_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT73'), 0, 9999);
//		var idle_time_obj = new varible_obj($('#ipv6_pppoe_idle_time').val(), idle_time_msg , 0, 9999, false);
		var mtu_msg = replace_msg(check_num_msg, "MTU", 1300, 1492);
		var mtu_obj = new varible_obj($('#ipv6_pppoe_mtu').val(), mtu_msg , 1300, 1492, false);
		var primary_dns = $('#ipv6_pppoe_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns1_v6'));
		var secondary_dns = $('#ipv6_pppoe_secondary_dns').val();
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns2_v6'));
		var ipv6_lan = $('#ipv6_pppoe_lan_ip').val();
		var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,get_words('IPV6_TEXT46'));
		var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
		var addr_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT68'), 1, 999999);
		var addr_lifetime_obj = new varible_obj($('#ipv6_dhcpd_lifetime').val(), addr_lifetime_msg, 1, 999999, false);
		var adver_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT69'), 1, 999999);
		var adver_lifetime_obj = new varible_obj($('#ipv6_pppoe_adver_lifetime').val(), adver_lifetime_msg , 1, 999999, false);
		var ipv6_addr_s_suffix = $('#ipv6_addr_range_start_suffix').val();
		var ipv6_addr_e_suffix = $('#ipv6_addr_range_end_suffix').val();

		if ($('#ipv6_wan_proto').val() == $('#ipv6_w_proto').val()) {
			if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange')))
				return false;
		}
		if (pppoe_share[0].checked){
			if(wan_type != 2){
				alert(get_words('IPV6_TEXT161'));
				return false;
			}
		}
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
		$('#ipv6_dhcp_pd_enable').val(get_checked_value($('#ipv6_dhcp_pd_chk')[0]));
		$('#ipv6_wan_proto').val($('#ipv6_w_proto').val());
		$('#ipv6_pppoe_dns_enable').val(get_checked_value(get_by_name("ipv6_dns_pppoe_enable")));
		$('#ipv6_wan_specify_dns').val($('#ipv6_pppoe_dns_enable').val());
		//check the PPPoE IP Address
		if (!pppoe_dynamic[0].checked){
			if(check_ipv6_symbol(pppoe_ip,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(pppoe_ip,"::")==1){    // find one '::' symbol
				temp_pppoe_ip = new ipv6_addr_obj(pppoe_ip.split("::"), pppoe_ip_msg, false, false);
				if (!check_ipv6_address(temp_pppoe_ip ,"::"))
					return false;
			}else{	//not find '::' symbol
				temp_pppoe_ip  = new ipv6_addr_obj(pppoe_ip.split(":"), pppoe_ip_msg, false, false);
				if (!check_ipv6_address(temp_pppoe_ip,":")){
					return false;
				}
			}
		}
		if(!pppoe_share[0].checked)
		{
			// 2013-04-11 Silvia add, Check service name entry
			// 2013-10-9  accept '\' in name entry
			if (!check_service_name(pppoe_srv_name))
			{
				alert(get_words('_srvname') + " " + get_words('mydlink_pop_04'));
				return false;
			}
			if ($('#ipv6_pppoe_username').val() == "") {
				alert(get_words('PPP_USERNAME_EMPTY', msg));
				return false;
			}
			if (get_by_id("ipv6_pppoe_password_s").value == "" || get_by_id("ipv6_pppoe_password_v").value == ""){
				alert(get_words('GW_WAN_PPPOE_PASSWORD_INVALID'));
				return false;
			}
			//check the password match
			if (!check_pwd("ipv6_pppoe_password_s", "ipv6_pppoe_password_v"))
				return false;

/*
			if(conn_mode[1].checked){
				//check Maximum Idle Time
				if (!check_varible(idle_time_obj))
					return false;
			}
*/
			//check the MTU value
			if (!check_varible(mtu_obj))
				return false;
		}

		//check DNS Address
		if(fixDNSIP[1].checked){
			if((primary_dns == "") && (secondary_dns == ""))
			{
				alert(addstr(get_words('up_ai_se_2'),get_words('_dns1_v6')));
				return false;
			}
			if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol
				temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns ,"::"))
					return false;
			}else{	//not find '::' symbol
				temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns,":"))
					return false;
			}
			if (secondary_dns != ""){
				if(secondary_dns != "0:0:0:0:0:0:0:0"){
					if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol
						return false;
					}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol
						temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
						if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::"))
							return false;
					}else{	//not find '::' symbol
						temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
						if (!check_ipv6_address(temp_ipv6_secondary_dns,":"))
							return false;
					}
				}
			}
		}

		//fool-proof for LAN IP Address
		if(!$('#ipv6_dhcp_pd_chk')[0].checked) {
			if(check_ipv6_symbol(ipv6_lan,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol
				temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_lan ,"::"))
					return false;
			}else{  //not find '::' symbol
				temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_lan,":"))
					return false;
			}
		}
		if(check_mode == 2 && enable_autoconfig == 1){
			//check the suffix of Address Range(Start)
			if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,get_words('IPv6_addrSr')))
				return false;
			//check the suffix of Address Range(End)
			if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,get_words('IPv6_addrEr')))
				return false;
			//compare the suffix of start and the suffix of end
			if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix))
				return false;
			//check the IPv6 Address Lifetime
			if(!$('#ipv6_dhcp_pd_chk')[0].checked){
				if (!check_varible(addr_lifetime_obj))
					return false;
			}
			//set autoconfiguration range value
			$('#ipv6_dhcpd_start').val($('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val());
			$('#ipv6_dhcpd_end').val($('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val());
		}
		else if(enable_autoconfig == 1){
			//check the Router Advertisement Lifetime
			if(!$('#ipv6_dhcp_pd_chk')[0].checked){
				if (!check_varible(adver_lifetime_obj))
					return false;
			}
		}

		if (submit_button_flag == 0) {
			$('#ipv6_pppoe_password').val($('#ipv6_pppoe_password_s').val());
			submit_button_flag = 1;
			submit_pppoe();
			return true;
		}
		return false;
	}

	function submit_pppoe()
	{
		var paramPppoe = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6&nextPage=sel_ipv6.asp'
		};

		paramPppoe.arg += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=3";
		paramPppoe.arg += "&ipv6PPPoEConn_SessionType_1.1.1.1.0="+get_radio_value(get_by_name("ipv6_pppoe_share"));
		paramPppoe.arg += "&ipv6PPPoEConn_IPAddressType_1.1.1.1.0="+get_radio_value(get_by_name("ipv6_pppoe_dynamic"));

		if(get_by_name("ipv6_pppoe_dynamic")[0].checked)
			paramPppoe.arg += "&ipv6PPPoEConn_ExternalIPAddress_1.1.1.1.0="+static_ip;
		else
			paramPppoe.arg += "&ipv6PPPoEConn_ExternalIPAddress_1.1.1.1.0="+$('#ipv6_pppoe_ipaddr').val();

		if(get_by_name("ipv6_pppoe_share")[1].checked){	
			paramPppoe.arg += "&ipv6PPPoEConn_ConnectionTrigger_1.1.1.1.0="+get_radio_value(get_by_name("ipv6_pppoe_connect_mode"));
			paramPppoe.arg += "&ipv6PPPoEConn_Username_1.1.1.1.0="+$('#ipv6_pppoe_username').val();

			//
			if($('#ipv6_pppoe_password_s').val() == 'WDB8WvbXdH')
				paramPppoe.arg += "&ipv6PPPoEConn_Password_1.1.1.1.0="+config_val("pppoeCfg_Password_");
			else if($('#ipv6_pppoe_password_s').val() == 'HlacJghQyG')
				paramPppoe.arg += "&ipv6PPPoEConn_Password_1.1.1.1.0="+config_val("ipv6PPPoEConn_Password_");
			else
				paramPppoe.arg += "&ipv6PPPoEConn_Password_1.1.1.1.0="+$('#ipv6_pppoe_password_s').val();
			//

			paramPppoe.arg += "&ipv6PPPoEConn_ServiceName_1.1.1.1.0="+urlencode($('#ipv6_pppoe_service').val());
//			paramPppoe.arg += "&ipv6PPPoEConn_IdleDisconnectTime_1.1.1.1.0="+ $('#ipv6_pppoe_idle_time').val();
			paramPppoe.arg += "&ipv6PPPoEConn_MaxMTUSize_1.1.1.1.0="+$('#ipv6_pppoe_mtu').val();
		}
		paramPppoe.arg += "&ipv6PPPoEConn_AutomaticDNSServer_1.1.1.1.0="+get_radio_value(get_by_name("ipv6_dns_pppoe_enable"));
		paramPppoe.arg += "&ipv6PPPoEConn_PrimaryDNSAddress_1.1.1.1.0="+$('#ipv6_pppoe_primary_dns').val();
		paramPppoe.arg += "&ipv6PPPoEConn_SecondaryDNSAddress_1.1.1.1.0="+ $('#ipv6_pppoe_secondary_dns').val();

		paramPppoe.arg += "&lanIPv6Cfg_DHCPPDEnable_1.1.1.0.0="+get_checked_value($('#ipv6_dhcp_pd_chk')[0]);
		paramPppoe.arg += "&lanIPv6Cfg_AutoDHCPPDEnable_1.1.1.0.0="+get_checked_value($('#ipv6_dhcp_pd_lan')[0]);
		paramPppoe.arg += "&lanIPv6Cfg_PPPoELanAddress_1.1.1.0.0="+$('#ipv6_pppoe_lan_ip').val();
		paramPppoe.arg += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0="+ get_checked_value($('#ipv6_autoconfig_sel')[0]);
		paramPppoe.arg += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0="+$('#ipv6_autoconfig_type')[0].selectedIndex;
		paramPppoe.arg += "&lanIPv6Cfg_AdvertisementLifetime_1.1.1.0.0="+$('#ipv6_pppoe_adver_lifetime').val();
		paramPppoe.arg += "&lanIPv6Cfg_DHCPv6AddressRangeStart_1.1.1.0.0="+$('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val();
		paramPppoe.arg += "&lanIPv6Cfg_DHCPv6AddressRangeEnd_1.1.1.0.0="+$('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val();
		paramPppoe.arg += "&lanIPv6Cfg_IPv6AddressLifeTime_1.1.1.0.0="+$('#ipv6_dhcpd_lifetime').val();
		//paramPppoe.arg += "&lanIPv6Cfg_IPv6LinkLocalAddress_1.1.1.0.0="+$('#').val();

		get_config_obj(paramPppoe);
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
						<li><div id="sidenavoff"><script>show_words(IPV6_TEXT137)</script></a></div></li>
						<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
					</ul>
				</div>
				</td>
			</tr>
			</tbody>
		</table></td>

		<form id="form1" name="form1" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>$('#html_response_message').val(sc_intro_sv);</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_pppoe.asp">
			<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value=''>
			<input type="hidden" id="ipv6_dhcp_pd_enable" name="ipv6_dhcp_pd_enable" value=''>
			<input type="hidden" id="ipv6_pppoe_dns_enable" name="ipv6_pppoe_dns_enable" value=''>
			<input type="hidden" id="ipv6_pppoe_password" name="ipv6_pppoe_password" value="">
			<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value=''>
			<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value=''>
			<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value=''>
			<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value=''>
			<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value=''>
			<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value=''>
			<input type="hidden" id="wan_proto" name="wan_proto" value=''>
			<input type="hidden" id="page_type" name="page_type" value="IPv6">
			<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value=''>

		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id="maincontent">
			<div id="box_header">
				<h1><script>show_words(ipv6)</script></h1>
				<script>show_words(IPV6_TEXT28)</script><br>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_pppoe.asp');">
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
						<option value="3" selected><script>show_words(IPV6_TEXT34)</script></option>
						<option value="4"><script>show_words(IPV6_TEXT35)</script></option>
						<option value="5"><script>show_words(IPV6_TEXT36)</script></option>
						<option value="6"><script>show_words(IPV6_TEXT139)</script></option>
						<option value="7"><script>show_words(IPV6_TEXT37)</script></option>
					</select></td>
				</tr>
				</table>
			</div>
			<div class=box id=wan_ipv6_pppoe_settings>
				<h2><script>show_words(_PPPoE)</script></h2>
				<p class="box_msg"><script>show_words(_ispinfo)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="185" align=right class="duple"><script>show_words(TEXT077)</script> :</td>
					<td width="331">&nbsp;
						<input type="radio" name="ipv6_pppoe_share" value="0" onClick="check_v4v6_mode()" checked>
						<script>show_words(IPV6_TEXT129)</script>
						<input type="radio" name="ipv6_pppoe_share" value="1" onClick="check_v4v6_mode()">
						<script>show_words(TEXT078)</script>
					</td>
				</tr>
				<tr>
					<td width="185" align=right class="duple"><script>show_words(bwn_AM)</script> :</td>
					<td width="331">&nbsp;
						<input type="radio" name="ipv6_pppoe_dynamic" value="0" onClick="disable_ipv6_poe_ip()" checked>
						<script>show_words(carriertype_ct_0)</script>
						<input type="radio" name="ipv6_pppoe_dynamic" value="1" onClick="disable_ipv6_poe_ip()">
						<script>show_words(_sdi_staticip)</script>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_ipaddr)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_pppoe_ipaddr" name="ipv6_pppoe_ipaddr" size="40" maxlength="39" value=''>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_username)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_pppoe_username" name="ipv6_pppoe_username" size="20" maxlength="63" value=''>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_password)</script> :</td>
					<td>&nbsp;
						<input type=password id="ipv6_pppoe_password_s" name="ipv6_pppoe_password_00_s" size="20" maxlength="63" onfocus="select();">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_verifypw)</script> : </td>
					<td>&nbsp;
						<input type=password id="ipv6_pppoe_password_v" name="ipv6_pppoe_password_00_v" size="20" maxlength="63" onfocus="select();">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_srvname)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_pppoe_service" name="ipv6_pppoe_service" size="30" maxlength="39" value=''><script>show_words(_optional)</script>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(bwn_RM)</script> :</td>
					<td>&nbsp;
						<input type=radio name="ipv6_pppoe_connect_mode" value="0" checked>
						<script>show_words(bwn_RM_0)</script>
						<input type=radio name="ipv6_pppoe_connect_mode" value="2" onClick="check_ipv6_pppoe_connectmode()" disabled>
						<script>show_words('bwn_RM_1')</script>
						<input type=radio name="ipv6_pppoe_connect_mode" value="1">
						<script>show_words(bwn_RM_2)</script>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(bwn_MIT)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_pppoe_idle_time" name="ipv6_pppoe_idle_time" size="10" maxlength="5" value="" disabled>
						<script>show_words(bwn_min)</script>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(bwn_MTU)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_pppoe_mtu" name="ipv6_pppoe_mtu" size="10" maxlength="5" value=''>
						<script>show_words(bwn_bytes)</script>
						<script>show_words(_308)</script> 1492
					</td>
				</tr>
				</table>
			</div>
			<div class=box id=wan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_TEXT63)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT109)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="187" align=right><input type="radio" name="ipv6_dns_pppoe_enable" value="0" onClick="disable_ipv6_pppoe_auto_dns()" checked></td>
					<td width="331">&nbsp;<script>show_words(IPV6_TEXT65_v6)</script></td>
				</tr>
				<tr>
					<td width="187" align=right><input type="radio" name="ipv6_dns_pppoe_enable" value="1" onClick="disable_ipv6_pppoe_auto_dns()"></td>
					<td width="331">&nbsp;<script>show_words(IPV6_TEXT66)</script></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_dns1_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_pppoe_primary_dns" name="ipv6_pppoe_primary_dns" size="30" maxlength="39" value=''></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_dns2_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_pppoe_secondary_dns" name="ipv6_pppoe_secondary_dns" size="30" maxlength="39" value=''></td>
				</tr>
				</table>
			</div>
			<div class=box id=lan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44)</script></h2>
				<p align="justify" class="style1"><script>show_words(IPV6_TEXT45)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT147)</script> :</td>
					<td width="331">&nbsp;<input type=checkbox id="ipv6_dhcp_pd_chk" name="ipv6_dhcp_pd_chk" value="1" onClick="disable_ipv6_dhcp_pd_chk();"></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT46)</script> :</td>
					<td width="331">&nbsp;
						<input type=text id="ipv6_pppoe_lan_ip" name="ipv6_pppoe_lan_ip" size="30" maxlength="63" value='' onChange="set_ipv6_autoconf_range()">
						<b>/64</b>
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
				<p class="style1"><script>show_words(IPV6_TEXT49)</script><script>show_words(IPV6_TEXT164)</script></p>
				<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT105)</script> :</td>
					<td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig();"></td>
				</tr>
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT108)</script> :</td>
					<td width="331">&nbsp;<input name="ipv6_dhcp_pd_lan" type=checkbox id="ipv6_dhcp_pd_lan" value="1"></td>
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
						::<input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
					</td>
				</tr>
				<tr id="show_ipv6_addr_range_end" style="display:none">
					<td class="duple"><script>show_words(IPV6_TEXT55)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
						::<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
					</td>
				</tr>
				<tr id="show_ipv6_addr_lifetime" style="display:none">
					<td class="duple"><script>show_words(IPV6_TEXT56)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="6" value=''>
						<script>show_words(_minutes)</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
					<td class="duple"><script>show_words(IPV6_TEXT57)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_pppoe_adver_lifetime" name="ipv6_pppoe_adver_lifetime" size="20" maxlength="15" value="">
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
</html>
