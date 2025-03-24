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

	param.arg = "ccp_act=get&num_inst=5";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_6to4Tunnel_i_&inst_2=11110";	
	param.arg +="&oid_3=IGD_LANDevice_i_IPv6ConfigManagement_&inst_3=11100";
	param.arg +="&oid_4=IGD_Status_WANStatus_&inst_4=11100";
	param.arg +="&oid_5=IGD_Status_IPv6Status_&inst_5=11100";
	get_config_obj(param);

	var wan_addr4 = config_val("igdWanStatus_IPAddress_");	//IPv4 address
	var ipv6_type = config_val("wanIPv6ConnDev_CurrentConnObjType_");	//IPv6 connection type
	//6to4 settings
	var ipv6_6to4_tunnel_addr = filter_ipv6_addr(config_val("ipv66to4Conn_Tunne6to4Address_"));
	var ipv6_6to4_tunnel_addr_type = config_val("ipv66to4Conn_TunnelRelayType_");
	//LAN IPv6 address settings
	var lan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanLinkLocalAddress_"));
	var lan_ipv6_static_addr = filter_ipv6_addr(config_val("lanIPv6Cfg_Tunnel6to4LanAddress_"));
	//Address autoconfiguration settings
	var enable_address_assignment = config_val("lanIPv6Cfg_AutoV6AddressAssignEnable_");
	var ipv6_dhcpd_start_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeStart_"));
	var ipv6_dhcpd_end_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeEnd_"));

	var ipv6_6to4_wan_addr;
	var ipv6_6to4_lan_prefix;
	var ipv6_6to4_lan_subnet;

	function onPageLoad()
	{
		if(ipv6_6to4_tunnel_addr_type == "0")
			$('#ipv6_6to4_relay').val(config_val("ipv66to4Conn_Tunnel6to4RelayAddress_"));
		else
			$('#ipv6_6to4_relay').val(config_val("ipv66to4Conn_Tunnel6to4RelayDomain_"));
		$('#ipv6_6to4_primary_dns').val(filter_ipv6_addr(config_val("ipv66to4Conn_PrimaryDNSAddress_")));
		$('#ipv6_6to4_secondary_dns').val(filter_ipv6_addr(config_val("ipv66to4Conn_SecondaryDNSAddress_")));

		//LAN IPv6 address settings
		set_6to4_ipv6_wan_addr();
		set_6to4_ipv6_lan_addr();

		$('#lan_link_local_ip').html(lan_ipv6_linklocal_addr.toUpperCase()+"/64");
		$('#lan_ipv6_ip_prefix').html(ipv6_6to4_lan_prefix.toUpperCase());
		$('#ipv6_6to4_lan_ip').val(lan_ipv6_static_addr);//config_val("lanIPv6Cfg_Tunnel6to4LanAddress_");
		$('#ipv6_6to4_lan_ip_subnet').val(ipv6_6to4_lan_subnet);
		//Address autoconfiguration settings
		set_checked(enable_address_assignment, $('#ipv6_autoconfig_sel')[0]);
		$('#ipv6_autoconfig_type')[0].selectedIndex = config_val("lanIPv6Cfg_AutoConfigurationType_"); 

		if(config_val('igdIPv6Status_IPv4LifeTime_')=="0")
			$('#ipv6_6to4_adver_lifetime').val("10080");
		else
			$('#ipv6_6to4_adver_lifetime').val(config_val('igdIPv6Status_IPv4LifeTime_'));

		if(config_val('igdIPv6Status_IPv4LifeTime_')=="0")
			$('#ipv6_dhcpd_lifetime').val("10080");
		else
			$('#ipv6_dhcpd_lifetime').val(config_val('igdIPv6Status_IPv4LifeTime_'));

		set_ipv6_autoconf_range();
		set_ipv6_autoconfiguration_type();
		//  set_ipv6_stateful_range();
		disable_autoconfig();
		set_form_default_values("form1");
	}

	function dec2hex(dec)
	{
		var hex_array0, hex_array1;
		hex_array0 = dec/16;
		hex_array1 = dec%16;
		hex_array0 = hex_array0 - hex_array1/16;
		return hexchar(hex_array0)+hexchar(hex_array1);
	}

	function hexchar(c)
	{
		return c.toString(16);
	}

	function set_6to4_ipv6_wan_addr()
	{
		if(wan_addr4=="")
			wan_addr4 = "0.0.0.0";
		var array_addr4 = wan_addr4.split(".");
		var k = 15;

		ipv6_6to4_wan_addr	= "2002:"+dec2hex(array_addr4[0])+dec2hex(array_addr4[1])+":"
		+dec2hex(array_addr4[2])+dec2hex(array_addr4[3])+"::"
		+dec2hex(array_addr4[0])+dec2hex(array_addr4[1])+":"
		+dec2hex(array_addr4[2])+dec2hex(array_addr4[3]);
		$('#ipv6_6to4_addr').html(filter_ipv6_addr(ipv6_6to4_wan_addr).toUpperCase());
	}

	function set_6to4_ipv6_lan_addr()
	{
		if(wan_addr4=="")
			wan_addr4 = "0.0.0.0";
		var array_addr4 = wan_addr4.split(".");
		var k = 15;

		ipv6_6to4_lan_prefix = "2002:"+dec2hex(array_addr4[0])+dec2hex(array_addr4[1])+":"
		+dec2hex(array_addr4[2])+dec2hex(array_addr4[3])+":";
		if(lan_ipv6_static_addr==""){
			ipv6_6to4_lan_subnet = "";
		}else{
			var array_addr = lan_ipv6_static_addr.split(":");
			ipv6_6to4_lan_subnet = array_addr[3];
		}
		var array_start = ipv6_dhcpd_start_range.split(":");
		var array_end = ipv6_dhcpd_end_range.split(":");
		$('#ipv6_addr_range_start_suffix').val(array_start[array_start.length-1]);
		$('#ipv6_addr_range_end_suffix').val(array_end[array_end.length-1]);
	}

	function disable_autoconfig()
	{
		var disable = $('#ipv6_autoconfig_sel')[0].checked;
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
		$('#ipv6_autoconfig_type').attr('disabled',!disable);
		$('#ipv6_addr_range_start_suffix').attr('disabled',!disable);
		$('#ipv6_addr_range_end_suffix').attr('disabled',!disable);
		$('#ipv6_dhcpd_lifetime').attr('disabled',true);
		$('#ipv6_6to4_adver_lifetime').attr('disabled',true);
	}

	function set_ipv6_autoconf_range()
	{
		var ipv6_6to4_lan_ip_subnet = $('#ipv6_6to4_lan_ip_subnet').val();
		if (ipv6_6to4_lan_ip_subnet != "") {
			$('#ipv6_addr_range_start_prefix').val(ipv6_6to4_lan_prefix.toUpperCase()+ ipv6_6to4_lan_ip_subnet);
			$('#ipv6_addr_range_end_prefix').val(ipv6_6to4_lan_prefix.toUpperCase()+ ipv6_6to4_lan_ip_subnet);
		}
	}

	function set_ipv6_stateful_range()
	{
		var prefix_length = 64;
		var ipv6_lan_ip = $('#ipv6_6to4_lan_ip').val();
		var correct_ipv6="";
		if (ipv6_lan_ip != "") {
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
	}
	
	function trim(stringToTrim) {
		return stringToTrim.replace(/^\s+|\s+$/g,"");
	}

	function send_request()
	{
		var primary_dns = $('#ipv6_6to4_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_pdns));
		var secondary_dns = $('#ipv6_6to4_secondary_dns').val();
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_sdns));
		var ipv6_lan_ip_subnet = $('#ipv6_6to4_lan_ip_subnet').val();
		var check_mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		var enable_autoconfig = $('#ipv6_autoconfig').val();
		var addr_lifetime_msg = replace_msg(check_num_msg, get_words(IPV6_TEXT68), 1, 999999);
		var addr_lifetime_obj = new varible_obj($('#ipv6_dhcpd_lifetime').val(), addr_lifetime_msg, 1, 999999, false);
		var adver_lifetime_msg = replace_msg(check_num_msg, get_words(IPV6_TEXT69), 1, 999999);
		var adver_lifetime_obj = new varible_obj($('#ipv6_6to4_adver_lifetime').val(), adver_lifetime_msg , 1, 999999, false);
		var ipv6_addr_s_suffix = $('#ipv6_addr_range_start_suffix').val();
		var ipv6_addr_e_suffix = $('#ipv6_addr_range_end_suffix').val();
		var v6_6to4_relay = $('#ipv6_6to4_relay').val();
		var ipv6_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
		var v6_6to4_relay_obj = new addr_obj(v6_6to4_relay.split("."), ipv6_addr_msg, false, false);
		
		if(trim(v6_6to4_relay)=="")
		{
			alert(get_words(IPv6_6to4_relay));
			return false;
		}
			if(is_ipv4_valid(v6_6to4_relay))
				ipv6_6to4_tunnel_addr_type = 0;
			//if (!check_address(v6_6to4_relay_obj)) {
			//	return false;
			//}
			else{
				ipv6_6to4_tunnel_addr_type = 1;
			}

			if ($('#ipv6_wan_proto').val() == $('#ipv6_w_proto').val()) {
				if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange')))
					return false;
			}

			$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
			$('#ipv6_wan_proto').val($('#ipv6_w_proto').val());
			//set the LAN IPv6
			$('#ipv6_6to4_lan_ip').val(ipv6_6to4_lan_prefix + $('#ipv6_6to4_lan_ip_subnet').val() + "::1");

			//check DNS Address
			if (primary_dns != ""){
				if(primary_dns != "0:0:0:0:0:0:0:0"){
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
				}
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

			//check the subnet of LAN IPv6
			if (!check_lan_ipv6_subnet(ipv6_lan_ip_subnet,get_words(IPV6_TEXT46)))
				return false;
			if(check_mode == 2 && enable_autoconfig == 1){
				//check the suffix of Address Range(Start)
				if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,get_words(IPv6_addrSr)))
					return false;
				//check the suffix of Address Range(End)
				if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,get_words(IPv6_addrEr)))
					return false;
				//compare the suffix of start and the suffix of end
				if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix))
					return false;
				//check the IPv6 Address Lifetime
				if (!check_varible(addr_lifetime_obj))
					return false;
				//set autoconfiguration range value
				$('#ipv6_dhcpd_start').val($('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val());
				$('#ipv6_dhcpd_end').val($('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val());
			}
			else if(enable_autoconfig == 1 ){
				//check the Router Advertisement Lifetime
				if (!check_varible(adver_lifetime_obj))
					return false;
			}

			if (submit_button_flag == 0) {
				submit_button_flag = 1;
				submit_6to4();
				return true;
			}
			return false;
		
	}

	function submit_6to4()
	{
		var param6to4 = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6&nextPage=sel_ipv6.asp'
		};

		param6to4.arg += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=5";
		param6to4.arg += "&ipv66to4Conn_TunnelRelayType_1.1.1.1.0="+ipv6_6to4_tunnel_addr_type;
		if(ipv6_6to4_tunnel_addr_type == 0)
			param6to4.arg += "&ipv66to4Conn_Tunnel6to4RelayAddress_1.1.1.1.0="+$('#ipv6_6to4_relay').val();
		else
			param6to4.arg += "&ipv66to4Conn_Tunnel6to4RelayDomain_1.1.1.1.0="+$('#ipv6_6to4_relay').val();
		param6to4.arg += "&ipv66to4Conn_PrimaryDNSAddress_1.1.1.1.0="+$('#ipv6_6to4_primary_dns').val();
		param6to4.arg += "&ipv66to4Conn_SecondaryDNSAddress_1.1.1.1.0="+$('#ipv6_6to4_secondary_dns').val();
		param6to4.arg += "&lanIPv6Cfg_Tunnel6to4LanAddress_1.1.1.0.0="+ipv6_6to4_lan_prefix + $('#ipv6_6to4_lan_ip_subnet').val() + "::1";
		param6to4.arg += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0="+get_checked_value($('#ipv6_autoconfig_sel')[0]);
		param6to4.arg += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0="+$('#ipv6_autoconfig_type')[0].selectedIndex;
		param6to4.arg += "&lanIPv6Cfg_AdvertisementLifetime_1.1.1.0.0="+$('#ipv6_6to4_adver_lifetime').val();
		param6to4.arg += "&lanIPv6Cfg_DHCPv6AddressRangeStart_1.1.1.0.0="+$('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val();
		param6to4.arg += "&lanIPv6Cfg_DHCPv6AddressRangeEnd_1.1.1.0.0="+$('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val();
		param6to4.arg += "&lanIPv6Cfg_IPv6AddressLifeTime_1.1.1.0.0="+$('#ipv6_dhcpd_lifetime').val();
		get_config_obj(param6to4);
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
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6to4.asp">
			<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value=''>
			<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value=''>
			<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value=''>
			<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value=''>
			<input type="hidden" maxLength=80 size=80 name="ipv6_6to4_tunnel_address" id="ipv6_6to4_tunnel_address" value=''>
			<input type="hidden" maxLength=80 size=80 name="ipv6_6to4_lan_addr" id="ipv6_6to4_lan_addr" value=''>
			<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value=''>
			<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value=''>
			<input type="hidden" id="ipv6_6to4_lan_ip" name="ipv6_6to4_lan_ip" value=''>
			<input type="hidden" id="page_type" name="page_type" value="IPv6">

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
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_6to4.asp');">                      
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
						<option value="5" selected><script>show_words(IPV6_TEXT36)</script></option>
						<option value="6"><script>show_words(IPV6_TEXT139)</script></option>
						<option value="7"><script>show_words(IPV6_TEXT37)</script></option>
					</select></td>
				</tr>
				</table>
			</div>
			<div class=box id=wan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_TEXT60)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT61)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT62)</script> :</td>
					<td width="331">&nbsp;<b><span id="ipv6_6to4_addr"></span></b></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_6to4RELAY)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6to4_relay" name="ipv6_6to4_relay" size="30" maxlength="39" value=''></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_dns1_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6to4_primary_dns" name="ipv6_6to4_primary_dns" size="30" maxlength="39" value=''></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(_dns2_v6)</script> :</td>
					<td width="331">&nbsp;<input type=text id="ipv6_6to4_secondary_dns" name="ipv6_6to4_secondary_dns" size="30" maxlength="39" value=''></td>
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
						<b><span id=lan_ipv6_ip_prefix></span></b>
						<input type=text id="ipv6_6to4_lan_ip_subnet" name="ipv6_6to4_lan_ip_subnet" size="8" maxlength="4" value='' onChange="set_6to4_ipv6_lan_addr();set_ipv6_autoconf_range()">
						<b>::1/64</b>
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
				<p align="justify" class="style1"><script>show_words(IPV6_TEXT49)</script></p>
				<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT105)</script> :</td>
					<td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig();"></td>
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
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="15" value="">
						<script>show_words(_minutes)</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
					<td class="duple"><script>show_words(IPV6_TEXT57)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_6to4_adver_lifetime" name="ipv6_6to4_adver_lifetime" size="20" maxlength="15" value="">
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