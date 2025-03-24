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
	param.arg = "ccp_act=get&num_inst=4";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_StaticIP_i_&inst_2=11110";	
	param.arg +="&oid_3=IGD_LANDevice_i_IPv6ConfigManagement_&inst_3=11100";
	param.arg +="&oid_4=IGD_Status_IPv6Status_&inst_4=11100";	
	get_config_obj(param);

	//IPv6 connection type
	var ipv6_type = config_val("wanIPv6ConnDev_CurrentConnObjType_");

	//WAN IPv6 address settings
	var use_linklocal_addr = filter_ipv6_addr(config_val("ipv6StaticConn_UseLinkLocalAddress_"));
	var static_wan_ip = filter_ipv6_addr(config_val("ipv6StaticConn_ExternalIPAddress_"));
	var static_prefix_length = config_val("ipv6StaticConn_SubnetPrefixLength_");
	var wan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6WanLinkLocalAddress_"));
	var wan_ipv6_linklocal_prefix_length = config_val("wanIPv6ConnDev_SubnetPrefixLength_");

	//LAN IPv6 address settings
	var lan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanLinkLocalAddress_"));

	//Address autoconfiguration settings  
	var enable_address_assignment = config_val("lanIPv6Cfg_AutoV6AddressAssignEnable_");
	var ipv6_dhcpd_start_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeStart_"));
	var ipv6_dhcpd_end_range = filter_ipv6_addr(config_val("lanIPv6Cfg_DHCPv6AddressRangeEnd_"));

    function onPageLoad()
    {
		//WAN IPv6 address settings
		set_checked(use_linklocal_addr, $('#ipv6_use_link_local_sel')[0]);
		$('#ipv6_static_wan_ip').val(static_wan_ip);
		$('#ipv6_static_prefix_length').val(static_prefix_length);
		$('#ipv6_static_default_gw').val(filter_ipv6_addr(config_val("ipv6StaticConn_DefaultGateway_")));
		$('#ipv6_static_primary_dns').val(filter_ipv6_addr(config_val("ipv6StaticConn_PrimaryDNSAddress_")));
		$('#ipv6_static_secondary_dns').val(filter_ipv6_addr(config_val("ipv6StaticConn_SecondaryDNSAddress_")));
		use_wan_link_local_selector(use_linklocal_addr);

		//LAN IPv6 address settings
		$('#ipv6_static_lan_ip').val(filter_ipv6_addr(config_val("lanIPv6Cfg_StatictLanAddress_")));
		$('#lan_link_local_ip').html(lan_ipv6_linklocal_addr.toUpperCase()+"/64");

		//Address autoconfiguration settings
		set_checked(enable_address_assignment, $('#ipv6_autoconfig_sel')[0]);
        $('#ipv6_autoconfig_type')[0].selectedIndex = config_val("lanIPv6Cfg_AutoConfigurationType_"); 
		$('#ipv6_static_adver_lifetime').val(config_val("lanIPv6Cfg_AdvertisementLifetime_"));
		$('#ipv6_dhcpd_lifetime').val(config_val("lanIPv6Cfg_IPv6AddressLifeTime_"));
        set_ipv6_autoconfiguration_type();
        set_ipv6_stateful_range();
		disable_autoconfig();
		set_form_default_values("form1");
    }

	function use_wan_link_local_selector(value){
		var link_local_w;
		var ipv6_local_w_ip;
		if(value == true){
			static_wan_ip = $('#ipv6_static_wan_ip').val();
			static_prefix_length = $('#ipv6_static_prefix_length').val();
			ipv6_local_w_ip = $('#link_local_ip_w').val().split("/");
			if(wan_ipv6_linklocal_addr.length > 1)
			{
				$('#ipv6_static_wan_ip').val(wan_ipv6_linklocal_addr.toUpperCase());
				$('#ipv6_static_prefix_length').val(64);
			}
			else{
				$('#ipv6_static_wan_ip').val("");
				$('#ipv6_static_prefix_length').val("");
			}
			$('#ipv6_static_wan_ip').attr('disabled',true);
			$('#ipv6_static_prefix_length').attr('disabled',true);
		}
		else{
			$('#ipv6_static_wan_ip').val(static_wan_ip);
			$('#ipv6_static_prefix_length').val(static_prefix_length);//static_prefix_length;
			$('#ipv6_static_wan_ip').attr('disabled','');
			$('#ipv6_static_prefix_length').attr('disabled','');
		}
	}

	function disable_autoconfig()
	{
		var disable = $('#ipv6_autoconfig_sel')[0].checked;
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));
		$('#ipv6_autoconfig_type').attr('disabled',!disable);
		$('#ipv6_addr_range_start_suffix').attr('disabled',!disable);
		$('#ipv6_addr_range_end_suffix').attr('disabled',!disable);
		$('#ipv6_dhcpd_lifetime').attr('disabled',!disable);
		$('#ipv6_static_adver_lifetime').attr('disabled',!disable);
	}

    function set_ipv6_autoconf_range()
	{
		var ipv6_lan_ip = $('#ipv6_static_lan_ip').val();
		var prefix_length = 64;
		var correct_ipv6="";
		if (ipv6_lan_ip != "") {
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			$('#ipv6_addr_range_start_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
			$('#ipv6_addr_range_end_prefix').val(get_stateful_prefix(correct_ipv6,prefix_length));
		}
    }

    function set_ipv6_stateful_range()
    {
		var prefix_length = 64;
		var ipv6_lan_ip = $('#ipv6_static_lan_ip').val();
		var correct_ipv6="";
		if(ipv6_lan_ip != "")
		{
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
            break;
        }
	}

	function send_request()
	{
		var ipv6_static = $('#ipv6_static_wan_ip').val();
		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,get_words('IPV6_TEXT43'));

		var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
		var prefix_length_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT74'), 1, 128);
		var prefix_length_obj = new varible_obj($('#ipv6_static_prefix_length').val(), prefix_length_msg, 1, 128, false);
		var ipv6_static_gw = $('#ipv6_static_default_gw').val();
		var ipv6_static_gw_msg = replace_msg(all_ipv6_addr_msg,get_words('_defgw'));
		var temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
		var primary_dns = $('#ipv6_static_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns1_v6'));
		var secondary_dns = $('#ipv6_static_secondary_dns').val();
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words('_dns2_v6'));
		var ipv6_lan = $('#ipv6_static_lan_ip').val();
		var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,get_words('IPV6_TEXT46'));
		var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
		var check_mode = $('#ipv6_autoconfig_type')[0].selectedIndex;
		var enable_autoconfig = $('#ipv6_autoconfig').val();
		var addr_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT68'), 1, 999999);
		var addr_lifetime_obj = new varible_obj($('#ipv6_dhcpd_lifetime').val(), addr_lifetime_msg, 1, 999999, false);
		var adver_lifetime_msg = replace_msg(check_num_msg, get_words('IPV6_TEXT69'), 1, 999999);
		var adver_lifetime_obj = new varible_obj($('#ipv6_static_adver_lifetime').val(), adver_lifetime_msg , 1, 999999, false);
		var ipv6_addr_s_suffix = $('#ipv6_addr_range_start_suffix').val();
		var ipv6_addr_e_suffix = $('#ipv6_addr_range_end_suffix').val();

		if ($('#ipv6_wan_proto').val() == $('#ipv6_w_proto').val()) {
			if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange')))
				return false;
		}

		$('#ipv6_wan_proto').val($('#ipv6_w_proto').val());
		$('#ipv6_autoconfig').val(get_checked_value($('#ipv6_autoconfig_sel')[0]));

		if (get_checked_value($('#ipv6_use_link_local_sel')[0]) == 0)	//silvia add
		{
			// check the ipv6 address
			if(check_ipv6_symbol(ipv6_static,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(ipv6_static,"::")==1){    // find one '::' symbol
				temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split("::"), ipv6_static_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static,"::"))
					return false;
			}else{  //not find '::' symbol
				temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static,":"))
					return false;
			}
		}

		//check the Subnet Prefix Length
		if (!check_varible(prefix_length_obj))
			return false;

		//check Default Gateway
		if(check_ipv6_symbol(ipv6_static_gw,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_static_gw,"::")==1){    // find one '::' symbol
			temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split("::"), ipv6_static_gw_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static_gw,"::"))
				return false;
		}else{  //not find '::' symbol
			temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static_gw,":"))
				return false;
		}

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

		//check LAN IP Address
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
			if (!check_varible(addr_lifetime_obj))
				return false;
			//set autoconfiguration range value
			$('#ipv6_dhcpd_start').val($('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val());
			$('#ipv6_dhcpd_end').val($('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val());
		}
		else if(enable_autoconfig == 1 )
		{
			//check the Router Advertisement Lifetime
			if (!check_varible(adver_lifetime_obj))
				return false;
			//set Advertisement Lifetime
			$('#ipv6_ra_adv_valid_lifetime_l_one').val($('#ipv6_static_adver_lifetime').val() * 60) ;
			$('#ipv6_ra_adv_prefer_lifetime_l_one').val($('#ipv6_static_adver_lifetime').val() * 60) ;
		}
		if (submit_button_flag == 0) {
			submit_button_flag = 1;
			submit_static();
			return true;
		}
		else {
			return false;
		}
	}

	function submit_static()
	{
		var paramStatic = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6&nextPage=sel_ipv6.asp'
		};

		paramStatic.arg += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=1";

		paramStatic.arg += "&ipv6StaticConn_ExternalIPAddress_1.1.1.1.0="+$('#ipv6_static_wan_ip').val();
		paramStatic.arg += "&ipv6StaticConn_SubnetPrefixLength_1.1.1.1.0="+$('#ipv6_static_prefix_length').val();
		paramStatic.arg += "&ipv6StaticConn_UseLinkLocalAddress_1.1.1.1.0="+get_checked_value($('#ipv6_use_link_local_sel')[0]);
		paramStatic.arg += "&ipv6StaticConn_DefaultGateway_1.1.1.1.0="+ $('#ipv6_static_default_gw').val();
		paramStatic.arg += "&ipv6StaticConn_PrimaryDNSAddress_1.1.1.1.0="+$('#ipv6_static_primary_dns').val();
		paramStatic.arg += "&ipv6StaticConn_SecondaryDNSAddress_1.1.1.1.0="+$('#ipv6_static_secondary_dns').val();
		paramStatic.arg += "&lanIPv6Cfg_StatictLanAddress_1.1.1.0.0="+$('#ipv6_static_lan_ip').val();
		paramStatic.arg += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0="+$('#ipv6_autoconfig_type')[0].selectedIndex;
		paramStatic.arg += "&lanIPv6Cfg_AdvertisementLifetime_1.1.1.0.0="+$('#ipv6_static_adver_lifetime').val();
		paramStatic.arg += "&lanIPv6Cfg_DHCPv6AddressRangeStart_1.1.1.0.0="+$('#ipv6_addr_range_start_prefix').val() + "::" + $('#ipv6_addr_range_start_suffix').val();
		paramStatic.arg += "&lanIPv6Cfg_DHCPv6AddressRangeEnd_1.1.1.0.0="+$('#ipv6_addr_range_end_prefix').val() + "::" + $('#ipv6_addr_range_end_suffix').val();
		paramStatic.arg += "&lanIPv6Cfg_IPv6AddressLifeTime_1.1.1.0.0="+$('#ipv6_dhcpd_lifetime').val();
		paramStatic.arg += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0="+ get_checked_value($('#ipv6_autoconfig_sel')[0]);

		get_config_obj(paramStatic);
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
		<td id="topnavon"><a href="index.asp"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
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
			<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_static.asp">
			<input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="">
			<input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="">
			<input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="">
			<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="">
			<input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="">
			<input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="">
			<input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="">
			<input type="hidden" maxLength=80 size=80 name="link_local_ip_w" id="link_local_ip_w" value="">
			<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
			<input type="hidden" id="page_type" name="page_type" value="IPv6">

		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id="maincontent">
			<div id="box_header">
				<h1>IPv6</h1>
				<script>show_words(IPV6_TEXT28)</script><br>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_static.asp');">                      
				<script>get_by_id("button").value = get_words('_savesettings');</script>
				<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
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
						<option value="1" selected><script>show_words(IPV6_TEXT32)</script></option>
						<option value="2"><script>show_words(IPV6_TEXT107)</script></option>
						<option value="3"><script>show_words(IPV6_TEXT34)</script></option>
						<option value="4"><script>show_words(IPV6_TEXT35)</script></option>
						<option value="5"><script>show_words(IPV6_TEXT36)</script></option>
						<option value="6"><script>show_words(IPV6_TEXT139)</script></option>
						<option value="7"><script>show_words(IPV6_TEXT37)</script></option>
					</select></td>
				</tr>
				</table>
			</div>
			<div class=box id=wan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_WAN_IP)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT61)</script> </p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="187" class="duple"><script>show_words(IPV6_TEXT104)</script> :</td>
					<td width="331">&nbsp;<input name="ipv6_use_link_local_sel" type=checkbox id="ipv6_use_link_local_sel" value="1" onClick="use_wan_link_local_selector(this.checked);"></td>
				</tr>
				<tr>
					<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT0)</script> :</td>
					<td width="331">&nbsp;
						<input type=text id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" size="30" maxlength="63" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(IPV6_TEXT74)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" size="5" maxlength="63" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(IPV6_TEXT75)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_static_default_gw" name="ipv6_static_default_gw" size="30" maxlength="39" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_dns1_v6)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" size="30" maxlength="39" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(_dns2_v6)</script> :</td>
					<td>&nbsp;
						<input type=text id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" size="30" maxlength="39" value="">
					</td>
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
						<input type=text id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" size="30" maxlength="63" value="" onChange="set_ipv6_autoconf_range()">
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
					<td class="duple"> <script>show_words(IPV6_TEXT56)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="6" value="">
						<script>show_words(_minutes)</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
					<td class="duple"><script>show_words(IPV6_TEXT57)</script> :</td>
					<td width="331">&nbsp;&nbsp;<input type=text id="ipv6_static_adver_lifetime" name="ipv6_static_adver_lifetime" size="20" maxlength="6" value="">
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