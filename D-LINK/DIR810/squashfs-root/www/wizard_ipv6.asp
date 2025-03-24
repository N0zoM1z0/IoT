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
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var pageNameArray = new Array('p0'	, 'p1a', 'p1b'  , 'p1c'	, 'p2a'  , 'p2b'   , 'p2c'  , 'p3');
	var pageDescArray = new Array('main', 'time', 'fail', 'ipv6type' , 'pppoe', 'static', '6rd', 'save');
	var ret_auto_detect=0;
	var wz_curr_page=0;
	var wz_prev_page=0;
	var wz_next_page=1;
	var probe_count  = 0;
	var try_again = 0;
	var progressBarMaxWidth = 620;
	var	param = {
		url: "get_set.ccp",
		arg: "ccp_act=get&num_inst=9"+
			"&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100"+
			"&oid_2=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_PPPoE_i_&inst_2=11110"+ //
			"&oid_3=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_StaticIP_i_&inst_3=11110"+ //
			"&oid_4=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_6RD_i_&inst_4=11110"+ //
			"&oid_5=IGD_LANDevice_i_IPv6ConfigManagement_&inst_5=11100"+
			"&oid_6=IGD_Status_IPv6Status_&inst_6=11100"+
			"&oid_7=IGD_Status_WANStatus_&inst_7=11100"+
			"&oid_8=IGD_Status_LANStatus_&inst_8=11100"+
			"&oid_9=IGD_WANDevice_i_WANConnectionDevice_i_&inst_9=11100"
	};
	get_config_obj(param);

	var wan_ipv6_linklocal_addr = config_val("igdIPv6Status_IPv6WanLinkLocalAddress_");
	var wan_ipv6_linklocal_prefix_length = config_val("wanIPv6ConnDev_SubnetPrefixLength_");
	var wan_ipv4_conn_type = config_val("wanConnDev_CurrentConnObjType_");
	
	var ipv6Cfg = {
		'ipv6Mode':					config_val('wanIPv6ConnDev_CurrentConnObjType_'),
		'PppoeSessionType':		config_val('ipv6PPPoEConn_SessionType_'),
		'PppoeName':			config_val('ipv6PPPoEConn_Username_')? config_val('ipv6PPPoEConn_Username_'):"",
		'PppoePwd':				config_val('ipv6PPPoEConn_Password_'),
		'PppoeServicename':		config_val('ipv6PPPoEConn_ServiceName_'),

		'StaticUseLink':		config_val('ipv6StaticConn_UseLinkLocalAddress_'),
		'StaticIp':				filter_ipv6_addr(config_val('ipv6StaticConn_ExternalIPAddress_')),
		'StaticPrefixLength':	config_val('ipv6StaticConn_SubnetPrefixLength_'),
		'StaticGateway':		config_val('ipv6StaticConn_DefaultGateway_'),
		'StaticPriDns':			filter_ipv6_addr(config_val('ipv6StaticConn_PrimaryDNSAddress_')),
		'StaticSecDns':			filter_ipv6_addr(config_val('ipv6StaticConn_SecondaryDNSAddress_')),

		'LanIp':				filter_ipv6_addr(config_val('lanIPv6Cfg_StatictLanAddress_')),

		'SixrdPrefix':			config_val('ipv66rdConn_IPv6Prefix_'),
		'SixrdPrefixLength':		config_val('ipv66rdConn_IPv6PrefixLength_'),
		'SixrdMaskLength':		config_val('ipv66rdConn_IPMaskLength_'),
		'SixrdIpv4Addr':			config_val('igdWanStatus_IPAddress_'),
		'SixrdLinklocalPrefix':	config_val('ipv66rdConn_TunnelLinkLocalPrefix_'),
		'SixrdLinklocalAddr':		filter_ipv6_addr(config_val('ipv66rdConn_TunnelLinkLocalAddress_')),
		'SixrdRelayType':			config_val('ipv66rdConn_TunnalRelayType_'),
		'SixrdRelayAddr':			config_val('ipv66rdConn_Tunnel6rdRelayV4Address_'),
		'SixrdRelayDomain':		config_val('ipv66rdConn_Tunnel6rdRelayV4Domain_'),
		'SixrdPriDns':			filter_ipv6_addr(config_val('ipv66rdConn_PrimaryDNSAddress_'))
	};
	/**
	**    Date:		2013-10-11
	**    Author:	Silvia Chang
	**    Reason:	Fixed TSD bug 25910, 25915 IPv6 Internet Setup wizard issue
	**    Note:		verify relay type is addr or domain
	**/
	var tunnel_relay_type = ipv6Cfg.SixrdRelayType;
	function onPageLoad()
	{
		switch(ipv6Cfg.ipv6Mode)
		{
			case "3":
				set_checked("pppoe", get_by_name("ipv6_type"));
			break;
			
			case "1":
				set_checked("static", get_by_name("ipv6_type"));
			break;
			
			case "6":
				set_checked("6rd", get_by_name("ipv6_type"));
			break;
		}
		
		set_checked(ipv6Cfg.PppoeSessionType, get_by_name("ipv6_pppoe_share"));	//ipv6_pppoe_share
		$('#ipv6_pppoe_username').val(ipv6Cfg.PppoeName);
		$('#ipv6_pppoe_password_s').val(ipv6Cfg.PppoePwd); 
		$('#ipv6_pppoe_password_v').val(ipv6Cfg.PppoePwd);
		$('#ipv6_pppoe_service').val(ipv6Cfg.PppoeServicename);
		
		clone_ipv4_pppoe();
		
		set_checked(ipv6Cfg.StaticUseLink, get_by_name("ipv6_use_link_local_sel")[0]);
		$('#ipv6_static_wan_ip').val(ipv6Cfg.StaticIp);
		$('#ipv6_static_prefix_length').val(ipv6Cfg.StaticPrefixLength);
		$('#ipv6_static_default_gw').val(ipv6Cfg.StaticGateway);
		$('#ipv6_static_primary_dns').val(ipv6Cfg.StaticPriDns);
		$('#ipv6_static_secondary_dns').val(ipv6Cfg.StaticSecDns);
		use_wan_link_local_selector(ipv6Cfg.StaticUseLink);
		$('#ipv6_static_lan_ip').val(ipv6Cfg.LanIp);
		
		$('#ipv6_6rd_prefix').val(filter_ipv6_addr(ipv6Cfg.SixrdPrefix));
		$('#ipv6_6rd_prefix_length').val(ipv6Cfg.SixrdPrefixLength);
		$('#wan_ip').html(ipv6Cfg.SixrdIpv4Addr);
		$('#ipv6_6rd_ipv4_mask_length').val(ipv6Cfg.SixrdMaskLength);
		$('#ipv6_6rd_assigned_prefix').html(ipv6Cfg.SixrdLinklocalPrefix);		
		$('#ipv6_6rd_addr').val(ipv6Cfg.SixrdLinklocalAddr);
		if(ipv6Cfg.SixrdRelayType == 0)
			$('#ipv6_6rd_relay').val(ipv6Cfg.SixrdRelayAddr);
		else
			$('#ipv6_6rd_relay').val(ipv6Cfg.SixrdRelayDomain);
		$('#ipv6_6rd_primary_dns').val(ipv6Cfg.SixrdPriDns);
		ipv6_6rd_prefix_onchange();
		
	}

	function do_probe()
	{
		ret_auto_detect = 0;
		probe_count = 0;
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	'easy_setup.ccp',
			data: 	'ccp_act=do_probe6&es_step=0'+"&"+time+"="+time
		};
		$.ajax(ajax_param);
	}

	function do_probe_try_again()
	{
		ret_auto_detect = 0;
		probe_count = 0;
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	'easy_setup.ccp',
			data: 	'ccp_act=do_probe6_again&es_step=0'+"&"+time+"="+time
		};
		$.ajax(ajax_param);
	}	

	function get_probe_state_hldr(data)
	{
		wz_probe_wan = get_node_value(data, 'probe_status');

		if (wz_probe_wan == '10' || probe_count++ >= 12) {		//probe finished: 10
			$('#next_b_p1b').attr('disabled', false);
			$('#progressbar').width(progressBarMaxWidth);
			if(probe_count >= 12){
				if(pageNameArray[wz_curr_page] == 'p1a') {
					next_page();
				}
			}
			return;
		}

		if (wz_probe_wan != '' && wz_probe_wan != '0') {
			$('#next_b_p1b').attr('disabled', false);
			$('#progressbar').width(progressBarMaxWidth);
			if(wz_probe_wan=='10')
				ret_auto_detect = 0;
			else 
				ret_auto_detect = parseInt(wz_probe_wan);
				//ret_auto_detect = 0;
			if(pageNameArray[wz_curr_page] == 'p1a') {
				next_page();
			}
			return;
		}
		if(probe_count<14)
			setTimeout('get_probe_state()', 5000);
	}

	function stopautodetect()
	{
		ret_auto_detect = 0;
		probe_count = 10;
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	'easy_setup.ccp',
			data: 	'ccp_act=wzcancel6&es_step=0'+"&"+time+"="+time
		};
		$.ajax(ajax_param);
	}

	function get_probe_state()
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	'easy_setup.ccp',
			data: 	'ccp_act=get_probe_state6&es_step=0'+"&"+time+"="+time,
			success: function(data) {
				get_probe_state_hldr(data);
			},
			error: function(xhr, ajaxOptions, thrownError){
				if (xhr.status == 200) {
					try {
						setTimeout(function() {
							document.write(xhr.responseText);
						}, 0);
					} catch (e) {
					}
				} else {
				}
			}
		};
		$.ajax(ajax_param);
	}

	var submit_button_flag = 0;
	function send_request()
	{
		var login_who=dev_info.login_info;

		if(login_who!= "w")
		{
			window.location.href ="user_page.asp";
			return false;
		}
		else
		{
			var paramStr = "";
			if(ret_auto_detect!=0)
			{
				paramStr += "&ccpSubEvent=CCP_SUB_WIZARD6";
				paramStr += "&nextPage=sel_ipv6.asp";
				paramStr += constructParamAutoDetect();
			}
			else
			{
				paramStr += "&ccpSubEvent=CCP_SUB_IPV6";
				paramStr += "&nextPage=sel_ipv6.asp";
				switch(get_checked_value(get_by_name('ipv6_type')))
				{
					case "pppoe":
						paramStr += constructParamPPPoE();
						break;
					case "static":
						paramStr += constructParamStaticIP();
						break;
					case "6rd":
						if(!verify_6rd())
							return;
						paramStr += constructParam6rd();
						break;
				}
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

	function verify_6rd()
	{
		var v6_6rd_relay = $('#ipv6_6rd_relay').val();
		var ipv6_addr_msg = replace_msg(all_ip_addr_msg,get_words('_ipaddr'));
		var v6_6rd_relay_obj = new addr_obj(v6_6rd_relay.split("."), ipv6_addr_msg, false, false);

		if (trim(v6_6rd_relay)==""){
			alert(get_words(IPv6_6rd_relay));
			return false;
		}
		if(Find_word(v6_6rd_relay,":")){
			alert(get_words(LS46));
			return false;
		}

		tunnel_relay_type = is_ipv4_valid(v6_6rd_relay)? 0 : 1;
		return true;
	}

	function wizard_cancel()
	{
		if (is_form_modified("formAll")){
			if(!confirm(get_words('_wizquit')))
				return false;
		}
		window.location.href="setup_ipv6.asp";
	}

	function displayPage(page)
	{
		for(var i=0; i < pageNameArray.length; i++)
		{
			if(pageNameArray[i] == page)
			{
				$('#'+pageNameArray[i]).show();
				if(i==1)
				{
					if(try_again==0)
					{
						probe_count = 0;
						$('#next_b_p4').attr('disabled', true);
						do_probe();
						get_probe_state();
						$('#progressbar').width(0);
						draw_progress_bar();
					}
					else
					{
						probe_count = 0;
						$('#next_b_p4').attr('disabled', true);
						do_probe_try_again();
						get_probe_state();
						$('#progressbar').width(0);
						draw_progress_bar();
						try_again=0;
					}
				}
				if((i >= 4) && (i <=6))
					show_static_ip(mapPage2WanType(page));
				if(i==7)
					$('#cancel_b_p3').attr('disabled', true);
			}
			else
				$('#'+pageNameArray[i]).hide();
		}
	}

	function mapPage2WanType(pageId)
	{
		switch(pageId)
		{
			case "p2a":
				return "pppoe";
			case "p2b":
				return "static";
			case "p2c":
				return "6rd";
		}
	}

	function mapWanType2Page(wan)
	{
		switch(wan)
		{
			case "pppoe":
				return "p2a";
			case "static":
				return "p2b";
			case "6rd":
				return "p2c";
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
		if (wz_curr_page != 0)
		{
			try {
				if(eval("verify_wz_page_"+pageNameArray[wz_curr_page])() == false)
					return;

			} catch (e) {
				// the verify function is not exist
			}
		}
		
		wz_prev_page = wz_curr_page;
		switch(wz_curr_page)
		{
			case 3:
				wz_curr_page = findIndexOfArrayByValue(pageNameArray, mapWanType2Page(get_checked_value(get_by_name('ipv6_type'))));
				break;
			case 1:
				if(ret_auto_detect == 0)
					wz_curr_page ++;
				else
					wz_curr_page = 7;
				break;
			case 0:
				ret_auto_detect == 0;
				wz_curr_page ++;
				break;
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
		displayPage(pageNameArray[wz_curr_page]);
	}
	
	function prev_page(page)
	{
		wz_curr_page = wz_prev_page;		
		if(wz_curr_page <= 3)
			wz_prev_page = 0;
		else if((wz_curr_page > 3)&&(wz_curr_page <= 6))
			wz_prev_page = 3;
		else if(wz_curr_page == 7)
			wz_curr_page = pageNameArray.indexOf(mapWanType2Page(get_checked_value(get_by_name('ipv6_type'))));
		displayPage(pageNameArray[wz_curr_page]);
	}

	function show_static_ip(objname)
	{	
		var ppp_type = get_by_name(objname + "_type");	
		if(ppp_type == null)
			return;
	}	

	function constructParamAutoDetect()
	{
		var paramStr = "";
		if(ret_auto_detect==1)
		{			
			paramStr += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=2";
			paramStr += "&ipv6AutoConfConn_AutomaticDNSServer_1.1.1.1.0=0";
			paramStr += "&lanIPv6Cfg_DHCPPDEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoDHCPPDEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0=1";
		}
		else if(ret_auto_detect==2)
		{
			paramStr += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=3";
			paramStr += "&ipv6PPPoEConn_SessionType_1.1.1.1.0=0";
			paramStr += "&ipv6PPPoEConn_IPAddressType_1.1.1.1.0=0";
			paramStr += "&ipv6PPPoEConn_AutomaticDNSServer_1.1.1.1.0=0";
			paramStr += "&lanIPv6Cfg_DHCPPDEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoDHCPPDEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0=1";
			paramStr += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0=1";
		}
		return paramStr;
	}

	function constructParamPPPoE()
	{
		var paramStr = "";
		paramStr += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=3";			//ipv6_pppoe_dynamic
		paramStr += "&ipv6PPPoEConn_SessionType_1.1.1.1.0=" + get_checked_value(get_by_name("ipv6_pppoe_share"));
		paramStr += "&ipv6PPPoEConn_Username_1.1.1.1.0=" + $('#ipv6_pppoe_username').val();
		paramStr += "&ipv6PPPoEConn_Password_1.1.1.1.0=" + $('#ipv6_pppoe_password_s').val();
		paramStr += "&ipv6PPPoEConn_ServiceName_1.1.1.1.0=" + urlencode($('#ipv6_pppoe_service').val());
		paramStr += "&ipv6PPPoEConn_AutomaticDNSServer_1.1.1.1.0=0";
		paramStr += "&lanIPv6Cfg_DHCPPDEnable_1.1.1.0.0=1";
		paramStr += "&lanIPv6Cfg_AutoDHCPPDEnable_1.1.1.0.0=1";
		paramStr += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0=1";
		paramStr += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0=1";
		return paramStr;
	}

	function constructParamStaticIP()
	{
		var paramStr = "";
		paramStr += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=1"
		paramStr += "&ipv6StaticConn_ExternalIPAddress_1.1.1.1.0=" + $('#ipv6_static_wan_ip').val();
		paramStr += "&ipv6StaticConn_UseLinkLocalAddress_1.1.1.1.0=" + get_checked_value($('#ipv6_use_link_local_sel')[0]);
		paramStr += "&ipv6StaticConn_SubnetPrefixLength_1.1.1.1.0=" + $('#ipv6_static_prefix_length').val();
		paramStr += "&ipv6StaticConn_DefaultGateway_1.1.1.1.0=" + $('#ipv6_static_default_gw').val();
		paramStr += "&ipv6StaticConn_PrimaryDNSAddress_1.1.1.1.0=" + $('#ipv6_static_primary_dns').val();
		paramStr += "&ipv6StaticConn_SecondaryDNSAddress_1.1.1.1.0="+ $('#ipv6_static_secondary_dns').val();
		paramStr += "&lanIPv6Cfg_StatictLanAddress_1.1.1.0.0=" + $('#ipv6_static_lan_ip').val();
		paramStr += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0=1";
		paramStr += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0=1";
		return paramStr;
	}

	function constructParam6rd()
	{
		var paramStr = "";
		paramStr += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=6";
		paramStr += "&ipv66rdConn_ConfigurationType_1.1.1.1.0=1";
		paramStr += "&ipv66rdConn_IPv6Prefix_1.1.1.1.0=" + $('#ipv6_6rd_prefix').val();
		paramStr += "&ipv66rdConn_IPv6PrefixLength_1.1.1.1.0=" + $('#ipv6_6rd_prefix_length').val();
		paramStr += "&ipv66rdConn_IPMaskLength_1.1.1.1.0=" + $('#ipv6_6rd_ipv4_mask_length').val();
		if($('#ipv6_6rd_assigned_prefix').html()!="None")
		{
			var tmpprefix = $('#ipv6_6rd_assigned_prefix').html();
			var assign_prefix = tmpprefix.split("/");
			paramStr += "&ipv66rdConn_AssignedIPv6Prefix_1.1.1.1.0=" + assign_prefix[0];
			paramStr += "&ipv66rdConn_TunnelLinkLocalPrefix_1.1.1.1.0=" + assign_prefix[1];
		}

		paramStr += "&ipv66rdConn_TunnalRelayType_1.1.1.1.0="+tunnel_relay_type;
		if(tunnel_relay_type == 0)
			paramStr += "&ipv66rdConn_Tunnel6rdRelayV4Address_1.1.1.1.0=" + $('#ipv6_6rd_relay').val();
		else
			paramStr += "&ipv66rdConn_Tunnel6rdRelayV4Domain_1.1.1.1.0=" + $('#ipv6_6rd_relay').val();

		if($('#lan_ipv6_ip_lan_ip').val()!=get_words(_none))
		{
			tmpprefix = $('#lan_ipv6_ip_lan_ip').val();
			assign_prefix = tmpprefix.split("/");
			paramStr += "&lanIPv6Cfg_Tunnel6rdLanAddress_1.1.1.0.0=" + assign_prefix[0];
		}
		paramStr += "&ipv66rdConn_PrimaryDNSAddress_1.1.1.1.0=" + $('#ipv6_6rd_primary_dns').val();
		paramStr += "&lanIPv6Cfg_AutoV6AddressAssignEnable_1.1.1.0.0=1";
		paramStr += "&lanIPv6Cfg_AutoConfigurationType_1.1.1.0.0=1";
		return paramStr;
	}

	function clone_ipv4_pppoe()
	{
		if(get_by_name("ipv6_pppoe_share")[0].checked){
			$('#ipv6_pppoe_username').attr('disabled',true);
			$('#ipv6_pppoe_password_s').attr('disabled',true);
			$('#ipv6_pppoe_password_v').attr('disabled',true);
			$('#ipv6_pppoe_service').attr('disabled',true);
		}
		else
		{
			$('#ipv6_pppoe_username').attr('disabled',false);
			$('#ipv6_pppoe_password_s').attr('disabled',false);
			$('#ipv6_pppoe_password_v').attr('disabled',false);
			$('#ipv6_pppoe_service').attr('disabled',false);
		}
	}

	function draw_progress_bar()
	{
		var curWidth = $('#progressbar').width();
		var fieldWidth = curWidth + (progressBarMaxWidth-curWidth)/5;
		if (progressBarMaxWidth-curWidth <= 5) {
			$('#progressbar').width(progressBarMaxWidth);
			return;
		}
		if ($('#progressbar').width() < progressBarMaxWidth) {
			$('#progressbar').width(fieldWidth);
			setTimeout('draw_progress_bar()', 600);
		}
	}

	function use_wan_link_local_selector(value)
	{
		var link_local_w;
		var static_prefix_length;
		if(value == true){
			link_local_w = $('#ipv6_static_wan_ip').val();
			static_prefix_length = $('#ipv6_static_prefix_length').val();
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
			$('#ipv6_static_wan_ip').val(link_local_w);
			$('#ipv6_static_prefix_length').val(static_prefix_length);
			$('#ipv6_static_wan_ip').attr('disabled','');
			$('#ipv6_static_prefix_length').attr('disabled','');
		}
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

	String.prototype.lpad = function(padString, length){
		var str = this;
		while (str.length < length)
		str = padString + str;
		return str;
	}

	function ipv6_6rd_prefix_onchange()
	{
		var pf = $('#ipv6_6rd_prefix').val();
		var pf_len = $('#ipv6_6rd_prefix_length').val();
		var v4_masklen = $('#ipv6_6rd_ipv4_mask_length').val();
		var v4_uselen;
		var wan_mac = config_val("igdWanStatus_MACAddress_");
		var lan_mac = config_val("igdLanStatus_MACAddress_");
		var eui64;
		var ary_ip4 = ipv6Cfg.SixrdIpv4Addr.split(".");

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
			} 
			else
				IsValid = false;
		}
		if (pf_len <= 32) {
			$('#ipv6_6rd_ipv4_mask_length').attr('disabled',true);
			$('#ipv6_6rd_ipv4_mask_length').val("0");
		} 
		else {
			if(ipv6_6rd_dhcp[0].checked)
				$('#ipv6_6rd_ipv4_mask_length').attr('disabled',true);
			else
				$('#ipv6_6rd_ipv4_mask_length').attr('disabled','');
		}

		if (IsValid && pf_len >32) {
			if ( (v4_masklen-0)==v4_masklen && v4_masklen.length>0 )
			{
				v4_masklen = parseInt(v4_masklen);
				v4_uselen = 32 - v4_masklen;
				if (v4_masklen<1 || v4_masklen>31 || v4_uselen+pf_len > 64)
					IsValid = false;
			}
			else
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
				}
				else 
				{
					IsValid = false;
					break;
				}
			}
			if (ary_pf.length<2) ary_pf[1] = "0";
			if (ary_pf.length<3) ary_pf[2] = "0";
			if (ary_pf.length<4) ary_pf[3] = "0";
		}
		if (!IsValid) {
			$('#ipv6_6rd_assigned_prefix').html(get_words(_none));
			$('#lan_ipv6_ip_lan_ip').val(get_words(_none));
			return;
		}
		if (ary_pf.length >=1 ) {
			u32_pf[0] = parseInt( ary_pf[0].lpad("0",4) + ary_pf[1].lpad("0",4), 16);
			if (pf_len == 32) {
				u32_pf[1] = parseInt(u32_ip4);
			}else if (pf_len < 32) {
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
			$('#lan_ipv6_ip_lan_ip').val(filter_ipv6_addr(str_tmp).toUpperCase() + "/64");
		}
		else {
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
			$('#lan_ipv6_ip_lan_ip').val(filter_ipv6_addr(str_tmp).toUpperCase() + "/64");
		}
	}
	
	function verify_wz_page_p2a()
	{
		if(get_by_name("ipv6_pppoe_share")[0].checked){
			if(wan_ipv4_conn_type != 2)
			{
				alert(get_words(IPV6_TEXT161));
				return false;
			}
			
			return true;
		}
		else{
			if($('#ipv6_pppoe_username').val()=="")
			{
				alert(get_words(GW_WAN_PPPOE_USERNAME_INVALID));
				return false;
			}
		
			if (get_by_id("ipv6_pppoe_password_s").value == "" || get_by_id("ipv6_pppoe_password_v").value == ""){
				alert(get_words('GW_WAN_PPPOE_PASSWORD_INVALID'));
				return false;
			}
			//check the password match
			if (!check_pwd("ipv6_pppoe_password_s", "ipv6_pppoe_password_v"))
				return false;
			
			return true;
		}
	}
	
	function verify_wz_page_p2b()
	{
		var ipv6_static = $('#ipv6_static_wan_ip').val();
		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg, get_words(IPV6_TEXT0));

		var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
		var prefix_length_msg = replace_msg(check_num_msg, get_words(IPV6_TEXT74), 0, 128);
		var prefix_length_obj = new varible_obj($('#ipv6_static_prefix_length').val(), prefix_length_msg, 0, 128, false);
		var ipv6_static_gw = $('#ipv6_static_default_gw').val();
		var ipv6_static_gw_msg = replace_msg(all_ipv6_addr_msg,get_words(_defgw));
		var temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
		var primary_dns = $('#ipv6_static_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_pdns));
		var secondary_dns = $('#ipv6_static_secondary_dns').val();
		var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_sdns));
		var ipv6_lan = $('#ipv6_static_lan_ip').val();
		var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,get_words(IPV6_TEXT46));
		var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);

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
			
			//check the Subnet Prefix Length
			if (!check_varible(prefix_length_obj))
			return false;

		}

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

		return true;
	}
	
	function verify_wz_page_p2c()
	{
		var primary_dns = $('#ipv6_6rd_primary_dns').val();
		var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,get_words(wwa_pdns));
		var v6_6rd_relay = $('#ipv6_6rd_relay').val();
		var temp_ipv6_primary_dns;
		var v6_6rd_addr;
		var	temp_v6_6rd_addr;
		
		//20130326 Moa add check ipv6 6rd prefix
		var ipv6_prefix = $('#ipv6_6rd_prefix').val();
		var ipv6_msg = replace_msg(all_ipv6_addr_msg,get_words('IPV6_TEXT132'));
		temp_ipv6 = new ipv6_addr_obj(ipv6_prefix.split("::"), ipv6_msg, false, false);
		if (!check_ipv6_route_address(temp_ipv6 ,"::"))
			return false;
		
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
	
		if (trim(v6_6rd_relay)==""){
			alert(get_words(IPv6_6rd_relay));
			return false;
		}
		
		if(Find_word(v6_6rd_relay,":")){
			alert(get_words(LS46));
			return false;
		}
		
		v6_6rd_addr = $('#lan_ipv6_ip_lan_ip').val().split("/")[0];
		temp_v6_6rd_addr = new ipv6_addr_obj(v6_6rd_addr.split(":"), replace_msg(all_ipv6_addr_msg,get_words(IPV6_TEXT133)), false, false);
			if (!check_ipv6_address(temp_v6_6rd_addr,":"))
				return false;

		return true;
	}
	
	function trim(stringToTrim) {
		return stringToTrim.replace(/^\s+|\s+$/g,"");
	}
</script>
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
				<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
				<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
				<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
				<td>&nbsp;</td>
			</tr>
			</table>
			<img src="wlan_masthead.gif" width="836" height="92" align="middle"> 
			</div>
			</td>
		</tr>
		</table>
		</td>
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
			<h2 align="left"><script>show_words(IPV6_TEXT115)</script></h2>
			<p class="box_msg"><script>show_words(IPV6_TEXT116)</script></p>
			<table class=formarea>
			<tr>
				<td width="334" height="81">
					<UL>
						<LI><script>show_words(IPV6_TEXT117)</script>
						<LI><script>show_words(IPV6_TEXT118)</script>
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
					<script>$('#wz_prev_b_p0').val(get_words('_prev'));</script>
					<script>$('#next_b2_p0').val(get_words('_next'));</script>
					<script>$('#cancel_b2_p0').val(get_words('_cancel'));</script>
					<script>$('#wz_save_b_p0').val(get_words('_connect'));</script>
				</fieldset>
				</td>
			</tr>
			</table>
			</div>
<!-------------------------------->
<!--     End of page main       -->
<!-------------------------------->

<!-------------------------------->
<!--     Start of page 1a  -->
<!-------------------------------->

<!--Loading and detect ipv6-->
			<div class=box id="p1a"> 
			<h2 align="left"><script>show_words(IPV6_TEXT117)</script></h2>
			<p class="box_msg"><script>show_words(IPV6_TEXT119)</script></p>
			<table class=formarea>
			<tr align="center">
				<div align="left" style="width:620;border:3px solid #000000">
					<div id="progressbar" style="background-color: #FF6F00">&nbsp;</div>
				</div>
			</tr>
			</table>
			<table align="center" class="formarea">
			<tr>
			<div>
				<td>
				<fieldset id="wz_buttons">
					<input type="button" class="button_submit" id="wz_prev_b_p1a" name="wz_prev_b_p1a" onClick="prev_page();">
					<input type="button" class="button_submit" id="next_b2_p1a" name="next_b2_p1a" value="" onClick="next_page();stopautodetect()">
					<input type="button" class="button_submit" id="cancel_b2_p1a" name="cancel_b2_p1a" value="" onClick="wizard_cancel();stopautodetect()">
					<input type="button" class="button_submit" id="wz_save_b_p1a" name="wz_save_b_p1a" value="" disabled>
					<script>$('#wz_prev_b_p1a').val(get_words('_prev'));</script>
					<script>$('#next_b2_p1a').val(get_words('_next'));</script>
					<script>$('#cancel_b2_p1a').val(get_words('_cancel'));</script>
					<script>$('#wz_save_b_p1a').val(get_words('_connect'));</script>
				</fieldset>
				</td>
			</div>
			</tr>
			</table>
			</div>
<!-------------------------------->
<!--     End of page 1a    -->
<!-------------------------------->

<!-------------------------------->
<!--     Start of page 1b     -->
<!-------------------------------->
			<div class=box id="p1b"> 
				<h2 align="left"><script>show_words(IPV6_TEXT117)</script></h2>
				<div align="left">
				<div> 
					<P align="left" class=box_msg><script>show_words(IPV6_TEXT120)</script></P>
					<br><br>
					<table align="center" class=formarea >
					<tr>
						<td><br></td>
						<td>
							<input type="button" class="button_submit" id="cancel_b_p1b" name="cancel_b_p1b" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="prev_b_p1b" name="prev_b_p1b" value="" onClick="try_again=1;prev_page();">
							<input type="button" class="button_submit" id="next_b_p1b" name="next_b_p1b" value="" onclick="next_page();"> 
							<script>$('#cancel_b_p1b').val(get_words('_cancel'));</script>
							<script>$('#prev_b_p1b').val(get_words('TEXT076'));</script>
							<script>$('#next_b_p1b').val(get_words('IPV6_TEXT121'));</script><br>
						</td>
					</tr>
					</table>
					<br>
					<div align="center"></div>
				</div>
				</div>
			</div>
<!-------------------------------->
<!--     End of page 1b       -->
<!-------------------------------->

<!-------------------------------->
<!--     Start of page 1c       -->
<!-------------------------------->

			<div class=box id="p1c"> 
				<h2><script>show_words(IPV6_TEXT117)</script></h2>
				<div><p class="box_msg"><script>show_words(IPV6_TEXT154)</script></p></div>
				<div> 
				<table class=formarea >
				<tr>
					<td class=form_label>&nbsp;</td>
					<td><input name="ipv6_type" type="radio" value="pppoe" checked>
					<STRONG><script>show_words(IPV6_TEXT122)</script></STRONG>
					<div class=itemhelp><script>show_words(IPV6_TEXT123)</script></div></td>
				</tr>
				<tr>
					<td class=form_label>&nbsp;</td>
					<td><input name="ipv6_type" type="radio" value="static">
					<STRONG><script>show_words(IPV6_TEXT124)</script></STRONG>
					<div class=itemhelp><script>show_words(IPV6_TEXT125)</script> </div></td>
				</tr>
				<tr>
					<td class=form_label>&nbsp;</td>
					<td><input name="ipv6_type" type="radio" value="6rd">
					<STRONG><script>show_words(IPV6_TEXT126)</script></STRONG>
					<div class=itemhelp><script>show_words(IPV6_TEXT127)</script> </div></td>
				</tr>
				</table>
				<br>
				<table align="center" class="formarea">
				<tr>
					<td>
						<input type="button" class="button_submit" id="wz_prev_b_p1c" name="wz_prev_b_p1c" value="" onclick="prev_page();"> 
						<input type="button" class="button_submit" id="next_b_p1c" name="next_b_p1c" value="" onClick="next_page();"> 
						<input type="button" class="button_submit" id="cancel_b_p1c" name="cancel_b_p1c" value="" onclick="wizard_cancel();"> 
						<input type="button" class="button_submit" id="wz_save_b_p1c" name="wz_save_b_p1c" value="" disabled>
						<script>$('#wz_prev_b_p1c').val(get_words('_prev'));</script>
						<script>$('#next_b_p1c').val(get_words('_next'));</script>
						<script>$('#cancel_b_p1c').val(get_words('_cancel'));</script>
						<script>$('#wz_save_b_p1c').val(get_words('_connect'));</script>
					</td>
				</tr>
				</table>
				</div>
			</div>
<!-------------------------------->
<!--       End of page 1c        -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 2a      -->
<!-------------------------------->
			<div class=box id="p2a"> 
				<h2 align="left"><script>show_words(wwa_title_set_pppoe)</script></h2>
				<div align="left">
					<p class="box_msg"><script>show_words(IPV6_TEXT128)</script></p>
					<div>
					<table width="536" align="center" class=formarea>
					<tr>
						<td width="235" align=right class="duple">
							<script>show_words(TEXT077)</script>
						&nbsp;:</td>
						<td width="331">&nbsp;
							<input type="radio" name="ipv6_pppoe_share" value="0" onClick="clone_ipv4_pppoe()" checked>
							<script>show_words(IPV6_TEXT129)</script>
							<input type="radio" name="ipv6_pppoe_share" value="1" onClick="clone_ipv4_pppoe()">
							<script>show_words(TEXT078)</script>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(bwn_UN)</script>
						&nbsp;:</td>
						<td>
							<input type=text id=ipv6_pppoe_username name=ipv6_pppoe_username size="20" maxlength="63" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple"> 
							<script>show_words(_password)</script>
						&nbsp;:</td>
						<td>
							<input type=password id=ipv6_pppoe_password_s name=ipv6_pppoe_password_s size="20" maxlength="63" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_verifypw)</script>
						&nbsp;:</td>
						<td>
							<input type=password id=ipv6_pppoe_password_v name=ipv6_pppoe_password_v size="20" maxlength="63" value=''>
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_srvname)</script>
						&nbsp;:</td>
						<td>
							<input type=text id=ipv6_pppoe_service name=ipv6_pppoe_service size="30" maxlength="39" value=''>
							<script>show_words(_optional)</script></td>
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
							<input type="button" class="button_submit" id="wz_prev_b_p2a" name="wz_prev_b_p2a" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p2a" name="next_b_p2a" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p2a" name="cancel_b_p2a" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="wz_save_b_p2a" name="wz_save_b_p2a" value="" disabled> 
							<script>$('#wz_prev_b_p2a').val(get_words('_prev'));</script>
							<script>$('#next_b_p2a').val(get_words('_next'));</script>
							<script>$('#cancel_b_p2a').val(get_words('_cancel'));</script>
							<script>$('#wz_save_b_p2a').val(get_words('_connect'));</script>
						</td>
					</tr>
					</table>
					</div>
				</div>
			</div>
<!-------------------------------->
<!--       End of page 2a       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 2b      -->
<!-------------------------------->
			<div class=box id="p2b"> 
				<h2 align="left"><script>show_words(IPV6_TEXT155)</script></h2>
				<div align="left"> 
					<p class="box_msg"><script>show_words(IPV6_TEXT130)</script></p>
					<div>
					<table width="536" align="center" class=formarea>
					<tr>
						<td width="187" class="duple"><script>show_words(IPV6_TEXT104)</script> :</td>
						<td width="331">&nbsp;<input name="ipv6_use_link_local_sel" type=checkbox id="ipv6_use_link_local_sel" value="1" onClick="use_wan_link_local_selector(this.checked);"></td>
					</tr>
					<tr>
					<td width="187" align=right class="duple">
						<script>show_words(IPV6_TEXT0)</script>
					&nbsp;:</td>
					<td width="331">
						<input type=text id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" size="30" maxlength="63" value="">
					</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(IPV6_TEXT74)</script>
						&nbsp;:</td>
						<td>
							<input type=text id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" size="5" maxlength="63" value="">
						</td>
					</tr>
					<tr>
						<td align=right class="duple"> 
							<script>show_words(_defgw)</script>
						&nbsp;:</td>
						<td>
							<input type=text id="ipv6_static_default_gw" name="ipv6_static_default_gw" size="30" maxlength="39" value="">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_dns1_v6)</script>
						&nbsp;:</td>
						<td>
							<input type=text id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" size="30" maxlength="39" value="">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_dns2_v6)</script>
						&nbsp;:</td>
						<td>
							<input type=text id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" size="30" maxlength="39" value="">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(IPV6_TEXT46)</script>
						&nbsp;:</td>
						<td>
							<input type=text id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" size="30" maxlength="63" value="">
						<b>/64</b>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>  
							<input type="button" class="button_submit" id="wz_prev_b_p2b" name="wz_prev_b_p2b" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p2b" name="next_b_p2b" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p2b" name="cancel_b_p2b" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="wz_save_b_p2b" name="wz_save_b_p2b" value="" disabled> 
							<script>$('#wz_prev_b_p2b').val(get_words('_prev'));</script>
							<script>$('#next_b_p2b').val(get_words('_next'));</script>
							<script>$('#cancel_b_p2b').val(get_words('_cancel'));</script>
							<script>$('#wz_save_b_p2b').val(get_words('_connect'));</script>
						</td>
					</tr>
					</table>
					</div>
				</div>
			</div>
<!-------------------------------->
<!--       End of page 2b       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 2c      -->
<!-------------------------------->
			<div class=box id="p2c"> 
				<h2 align="left"><script>show_words(IPv6_Wizard_6rd_title)</script></h2>
				<div align="left"> 
					<p class="box_msg"><script>show_words(IPV6_TEXT131)</script></p>
					<div>
					<table width="536" align="center" class=formarea>
					<tr style="display:none">
						<td width="185" align=right class="duple"><script>show_words(IPV6_TEXT142)</script> :</td>
						<td width="331">&nbsp;
							<input type="radio" name="ipv6_6rd_dhcp" value="0" checked> <script>show_words(IPV6_TEXT143)</script>
							<input type="radio" name="ipv6_6rd_dhcp" value="1" checked> <script>show_words(IPV6_TEXT144)</script>
						</td>
					</tr>
					<tr>
						<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT132)</script> :</td>
						<td width="331">&nbsp;<b><input type=text id="ipv6_6rd_prefix" name="ipv6_6rd_prefix" size="22" maxlength="21" value="">
							<script>$('#ipv6_6rd_prefix').change(ipv6_6rd_prefix_onchange);</script>
							/<input type=text id="ipv6_6rd_prefix_length" name="ipv6_6rd_prefix_length" size="5" maxlength="2" value="32"></td>
							<script>$('#ipv6_6rd_prefix_length').change(ipv6_6rd_prefix_onchange);</script>
					</tr>
					<tr>
						<td width="187" align=right class="duple"><script>show_words(ipv4_addr)</script> :</td>
						<td width="331"><b><span id="wan_ip"></span></b>&nbsp;<script>show_words(mask_len)</script>:
							<input type=text id="ipv6_6rd_ipv4_mask_length" name="ipv6_6rd_ipv4_mask_length" size="5" maxlength="2" value="0">
							<script>$('#ipv6_6rd_ipv4_mask_length').change(ipv6_6rd_prefix_onchange);</script>
						</td>
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
						<td width="331">&nbsp;<input type=text id="ipv6_6rd_relay" name="ipv6_6rd_relay" size="30" maxlength="39" value=''></td>
					</tr>
					<tr>
						<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT135)</script> :</td>
						<td width="331">&nbsp;<input type=text id="ipv6_6rd_primary_dns" name="ipv6_6rd_primary_dns" size="30" maxlength="39" value=''></td>
					</tr>
					<tr style="display:none">
						<td width="187" align=right class="duple"><script>show_words(wwa_pdns)</script> :</td>
						<td width="331">&nbsp;<input type=text id="lan_ipv6_ip_lan_ip" name="lan_ipv6_ip_lan_ip" size="30" maxlength="39" value=''></td>
					</tr>
					<tr>
						<td></td>
						<td>  
							<input type="button" class="button_submit" id="wz_prev_b_p2c" name="wz_prev_b_p2c" value="" onclick="prev_page();"> 
							<input type="button" class="button_submit" id="next_b_p2c" name="next_b_p2c" value="" onClick="next_page();"> 
							<input type="button" class="button_submit" id="cancel_b_p2c" name="cancel_b_p2c" value="" onclick="wizard_cancel();"> 
							<input type="button" class="button_submit" id="wz_save_b_p2c" name="wz_save_b_p2c" value="" disabled> 
							<script>$('#wz_prev_b_p2c').val(get_words('_prev'));</script>
							<script>$('#next_b_p2c').val(get_words('_next'));</script>
							<script>$('#cancel_b_p2c').val(get_words('_cancel'));</script>
							<script>$('#wz_save_b_p2c').val(get_words('_connect'));</script>
						</td>
					</tr>
					</table>
					</div>
				</div>
			</div>
<!-------------------------------->
<!--       End of page 2c       -->
<!-------------------------------->

<!-------------------------------->
<!--      Start of page 3       -->
<!-------------------------------->
			<div class=box id="p3">
				<h2 align="left"><script>show_words(_setupdone)</script></h2>
				<div align="left">
					<div>
					<br>
					<P align="left" class=box_msg>
						<script>show_words(IPV6_TEXT156)</script>
					</P>
					<table align="center" class=formarea >
					<tr>
						<td></td>
						<td>
							<input type="button" class="button_submit" id="prev_b_p3" name="prev_b_p3" value="" onclick="prev_page();">
							<input type="button" class="button_submit" id="next_b_p3" name="next_b_p3" value="" disabled>
							<input type="button" class="button_submit" id="cancel_b_p3" name="cancel_b_p3" value="" onclick="wizard_cancel();">
							<input type="button" class="button_submit" id="wz_save_b_p3" name="wz_save_b_p3" value="" onClick="return send_request()">
							<script>$('#prev_b_p3').val(get_words('_prev'));</script>
							<script>$('#next_b_p3').val(get_words('_next'));</script>
							<script>$('#cancel_b_p3').val(get_words('_cancel'));</script>
							<script>$('#wz_save_b_p3').val(get_words('_connect'));</script>
						</td>
					</tr>
					</table>
					<div align="center"></div>
					</div>
				</div>
			</div>
<!-------------------------------->
<!--       End of page 3        -->
<!-------------------------------->
			</form>
			</td>
		</tr>
		</table>
		<p>&nbsp;</p>
		</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
			<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
			<tr>
				<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
				<td width="10">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			</table>
		</td>
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