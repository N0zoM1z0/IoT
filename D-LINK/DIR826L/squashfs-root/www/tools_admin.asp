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
	document.title = get_words('TEXT000');
	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=8"+
				"&oid_1=IGD_AdministratorSettings_&inst_1=10000"+
				"&oid_2=IGD_AdministratorSettings_LoginInfo_i_&inst_2=11000"+
				"&oid_3=IGD_WANDevice_i_InboundFilter_i_&inst_3=11000"+
				"&oid_4=IGD_&inst_4=10000"+
				"&oid_5=IGD_WANDevice_i_VirServRule_i_&inst_5=11000"+
				"&oid_6=IGD_WANDevice_i_PortFwd_i_&inst_6=11000"+
				"&oid_7=IGD_WANDevice_i_PortTriggerRule_i_&inst_7=11000"+
				"&oid_8=IGD_Storage_&inst_8=11000"
	};
	get_config_obj(param);

	var dev_mode = config_val("igd_DeviceMode_");

	var array_rule_max_num = 24;

	var array_vs_inst = config_inst_multi("IGD_WANDevice_i_VirServRule_i_");
	var array_vs_enable	= config_str_multi("vsRule_Enable_");
	var array_vs_enable		= config_str_multi("vsRule_Enable_");
	var array_vs_proto	 	= config_str_multi("vsRule_Protocol_");
	var array_vs_ports 		= config_str_multi("vsRule_PublicPort_");
	var array_pf_enable		= config_str_multi("pfRule_Enable_");
	var array_pf_ports_udp	= config_str_multi("pfRule_UDPOpenPorts_");
	var array_pf_ports_tcp	= config_str_multi("pfRule_TCPOpenPorts_");

	var array_pf_name = config_str_multi("pfRule_ApplicationName_");
	var array_pf_port = config_str_multi("pfRule_TCPOpenPorts_");
	var array_pf_inst = config_inst_multi("IGD_WANDevice_i_PortFwd_i_");

	var array_pt_enable		= config_str_multi("ptRule_Enable_");
	var array_pt_name = config_str_multi("ptRule_ApplicationName_");
	var array_pt_ports = config_str_multi("ptRule_FirewallPorts_");
	var array_pt_proto = config_str_multi("ptRule_FirewallProtocol_");
	var array_pt_inst = config_inst_multi("IGD_WANDevice_i_PortTriggerRule_i_");
	
	var array_username 	= config_str_multi("loginInfo_Username_");
	var array_password 	= config_str_multi("loginInfo_Password_");
	var array_ib_inst 		= config_inst_multi("IGD_WANDevice_i_InboundFilter_i_");

	var array_filter_name = config_str_multi("ibFilter_Name_");
	var array_filter_act  = config_str_multi('ibFilter_Action_');
	var ib_filter_cnt = 0;
	var rmgr_en = config_val("adminCfg_RemoteManagementEnable_");
	var rmgr_port = config_val('adminCfg_RemoteAdminHttpPort_');
	var rmgr_ports = config_val('adminCfg_RemoteAdminHttpsPort_');
	var sys_name = config_val('adminCfg_SystemName_');
	var gauth_en = config_val("adminCfg_GraphAuthenticationEnable_");
	
	var httpsServer_en = config_val("adminCfg_HttpsServerEnable_");
	var Rm_httpsServer_en = config_val("adminCfg_RemoteAdminHttpsEnable_");
	
	var selectedIbfilter = config_val("adminCfg_RemoteAdminInboundFilter_");

	var wa_http_en = config_val("igdStorage_Enable_");
	var wa_https_en = config_val("igdStorage_Http_Remote_Access_Enable_");
	var wa_http_port = config_val("igdStorage_Http_Remote_Access_Port_");
	var wa_https_port = config_val("igdStorage_Https_Remote_Access_Port_");
	
	if(array_filter_name != null)
		ib_filter_cnt = array_filter_name.length;
	
	
	/*for inbound filter detail*/
	var RULES_IN_IFLTER = 8;
	if (array_ib_inst != null) {
		var paramRange = {
			url: 	"get_set.ccp",
			arg: 	"ccp_act=get&num_inst="+array_ib_inst.length
		};
		for (var i=1; i<=array_ib_inst.length; i++) {
			var p_inst = new String(array_ib_inst[i-1]);
			paramRange.arg += "&oid_"+i+"=IGD_WANDevice_i_InboundFilter_i_IPRange_i_&inst_"+i+"=11"+p_inst.substr(4, 1)+"00"
		}
		get_config_obj(paramRange);
	}
	
	var array_ip_inst = config_inst_multi("IGD_WANDevice_i_InboundFilter_i_IPRange_i_");
	var array_enable = config_str_multi("ipRange_Enable_");
	var array_ip_start = config_str_multi("ipRange_RemoteIPStart_");
	var array_ip_end = config_str_multi("ipRange_RemoteIPEnd_");
	var array_ib_detail = new Array();
	if (array_ib_inst != null) {
		for(var i=0; i<array_ib_inst.length; i++)
		{
			array_ib_detail[i] = '';
			for(var j=0;j<RULES_IN_IFLTER;j++){
				if(array_enable[i*RULES_IN_IFLTER+j] == "1"){
					//array_ib_detail[i] += array_ip_start[i*RULES_IN_IFLTER+j] + "-" + array_ip_end[i*RULES_IN_IFLTER+j] +", ";
					if(array_ib_detail[i] != '')
						array_ib_detail[i] += ", ";
						
					if (array_ip_start[i*RULES_IN_IFLTER+j] == '0.0.0.0' && array_ip_end[i*RULES_IN_IFLTER+j] == '255.255.255.255')
						array_ib_detail[i] += '*';
					else
						array_ib_detail[i] += array_ip_start[i*RULES_IN_IFLTER+j] + '-' + array_ip_end[i*RULES_IN_IFLTER+j];
				}
				//set_checked(array_enable[i*RULES_IN_IFLTER+j], get_by_id("entry_enable_"+j));
				//get_by_id("ip_start_"+j).value = array_ip_start[i*RULES_IN_IFLTER+j];
				//get_by_id("ip_end_"+j).value = array_ip_end[i*RULES_IN_IFLTER+j];
			}	
		}
	}

	var submit_button_flag = 0;
	var rule_max_num = 10;
	var vs_rule_max = 24;
	var inbound_used = 3;
		var rand_pass = "WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG";
	var DataArray = new Array();
	var ori_inbound_filter;
	var ori_management_port;
	var ori_hostname;

	/*  Date:   2009-05-11
	 *  Name:   Yufa Huang
	 *  Reason: add HTTPS function.
	 */
	var https_enable, remote_https_enable, remote_https_port, remote_http_port;

    function onPageLoad()
    {
		set_checked(rmgr_en, $('#remote_enable')[0]);
		set_checked(gauth_en, $('#graphical_enable')[0]);
		set_checked(httpsServer_en, get_by_id("HttpsServerEnable"));
		set_checked(Rm_httpsServer_en, get_by_id("RemoteAdminHttpsEnable"));
	
		$('#admin_password').val(array_password[0]);
		$('#admin_password1').val($('#admin_password2').val());
		$('#admPass2').val($('#admin_password2').val());
		$('#hostname').val(sys_name);
		
		$('#remote_http_management_port').val((rmgr_port!=0)?rmgr_port:rmgr_ports);
		
		$('#remote_inbound_filter').val(selectedIbfilter);
		disable_obj();
		onIbChange();
		chg_https();
		if(dev_mode == "1")
			get_by_id("rm_admin").style.display = "none";
	
		/*	Date:	2010-02-23
 		*	Name:	Tina Tsao
 		*	Reason: Fixed for when log in under "User", user access should be grayed out.
 		*/
		set_form_default_values("form1");
		var login_who= dev_info.login_info;
		if(login_who!= "w"){
			DisableEnableForm(form1,true);	
		} 
	}
	
	function onIbChange() 
	{
		var selIdx = $('#remote_inbound_filter').attr('selectedIndex');
		if (selIdx < 2) {
			get_by_id('remote_detail').value = get_by_id('remote_inbound_filter')[selIdx].text;
		} else {
			get_by_id('remote_detail').value = ((array_filter_act[selIdx-2] == 0)? get_words('_allow'): get_words('_deny')) + ", " + array_ib_detail[selIdx-2];
			//get_by_id('remote_detail').value += array_ib_detail[selIdx-2];
		}
	}
	function chg_rm_port()	//20120120 silvia modify
	{
		var chk_port = $('#remote_http_management_port').val(); 
		if (chk_port == "")
			alert(get_words('remote_port_msg'));

		if($('#remote_enable')[0].checked == true)
		{
		var bb =$('#RemoteAdminHttpsEnable')[0].checked;
			if ($('#RemoteAdminHttpsEnable')[0].checked == true){	//https
				if ((chk_port == '8080') || ((chk_port == rmgr_port) && (rmgr_port!='0')))
				{
					$('#remote_http_management_port').val("8090"); //20120918 pascal modify port to 8090
					if (rmgr_port =='0')
						$('#remote_http_management_port').val(rmgr_ports);
				}
			}else{
				if ((chk_port == '8090')|| ((chk_port == rmgr_ports) && (rmgr_ports!='0')))
				{
					$('#remote_http_management_port').val("8080");
					if (rmgr_ports =='0')
						$('#remote_http_management_port').val(rmgr_port);
				}
			}
		}else
			$('#remote_http_management_port').val("8080");
			//get_by_id("remote_http_management_port").disabled = get_by_id("RemoteAdminHttpsEnable").checked;
	}

	function disable_obj(){
		get_by_id("remote_http_management_port").disabled = !get_by_id("remote_enable").checked;
		get_by_id("remote_inbound_filter").disabled = !get_by_id("remote_enable").checked;
		chg_https();

	}
	function chg_https(){
		if((get_by_id("remote_enable").checked==false)&&(get_by_id("HttpsServerEnable").checked==false))
		{
			set_checked(0, get_by_id("RemoteAdminHttpsEnable"));
			get_by_id("RemoteAdminHttpsEnable").disabled = true;
		}else if ((get_by_id("remote_enable").checked==true)&&(get_by_id("HttpsServerEnable").checked==true))
		{
			get_by_id("RemoteAdminHttpsEnable").disabled = false;		
		}else if ((get_by_id("remote_enable").checked==true)&&(get_by_id("HttpsServerEnable").checked==false))
		{
			set_checked(0, get_by_id("RemoteAdminHttpsEnable"));
			get_by_id("RemoteAdminHttpsEnable").disabled = true;			
		}else if ((get_by_id("remote_enable").checked==false)&&(get_by_id("HttpsServerEnable").checked==true))
		{
			set_checked(0, get_by_id("RemoteAdminHttpsEnable"));
			get_by_id("RemoteAdminHttpsEnable").disabled = true;			
		}
		chg_rm_port();
	}	
	function add_option(id)
	{
		var	obj = ib_filter_cnt;
		var	arr = array_ib_inst;
		var	nam = array_filter_name;

		if (obj == null)
			return;

		for (var i = 0; i < obj; i++){
			var inst = inst_array_to_string(arr[i]);
			document.write("<option value=" + inst.charAt(2) + ">" + nam[i] + "</option>");
		}	
	}

	function do_select(id, type, value)
	{
		var i=0;
		var obj = document.getElementById(id);
		
		if (obj == null)
			return;

		if (type == 'idx')
		{
			if (obj.options[value] != null)
				obj.options[value].selected = true;
		}
		else if (type == 'val')
		{
			for (i=0; i<obj.options.length; i++)
			{
				if (obj.options[i].value == value)
					obj.options[i].selected = true;
			}
		}
	}
		
	//name/action/used(vs/port/wan/remote)
	function Data(name, action, used, onList) 
	{
		this.Name = name;
		this.Used = used;
		this.Show_W = "";
		this.OnList = onList;
		var sActionW = "Allow All"
		if(action =="deny"){
			sActionW = "Deny";
		}
		this.sAction = sActionW;
	}
	

	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		
		var remote_enable = $('#remote_enable')[0];
		var remote_port = $('#remote_http_management_port').val();
		var remote_port_enable = "";
		var tcp_timeline = null;
		var udp_timeline = null;
    	var remote_port_msg = replace_msg(check_num_msg, get_words('ta_RAP'), 1, 65535);
    	var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
	    var c_hostname=$('#hostname').val();
		if (c_hostname == "") {
			alert(get_words('GW_NAT_NAME_INVALID'));
			return false;
		}

		if(get_by_id("remote_enable").checked == true)
		{
			var tcp_ports = get_by_id("remote_http_management_port").value;
			tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
		}

		//add web access ports into timeline
		if(wa_http_en == 1)
		{
			tcp_timeline = add_into_timeline(tcp_timeline, wa_http_port, null);
			if (check_timeline(tcp_timeline) == false) 
			{				
				alert(addstr(get_words(ag_conflict5), "Remote management", $('#remote_http_management_port').val()));
				return false;
			}

			tcp_timeline = add_into_timeline(tcp_timeline, wa_https_port, null);
			if (check_timeline(tcp_timeline) == false) 
			{				
				alert(addstr(get_words(ag_conflict5), "Remote management", $('#remote_http_management_port').val()));
				return false;
			}
		}

		// add virtual server ports into timeline
		try {
			for (var i=0; i<array_vs_enable.length; i++) 
			{
				if (array_vs_enable[i] == '0')
					continue;
				
				var vs_ports = array_vs_ports[i].split(',');
				for (var j=0; j<vs_ports.length; j++) 
				{
					var range = vs_ports[j].split('-');
					if (array_vs_proto[i] == '0') 
					{
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						if (check_timeline(tcp_timeline) == false) 
						{
							//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
							//alert(addstr(get_words(ag_conflict4), 'Virtual Server TCP', get_by_id("remote_http_management_port").value));
							alert(get_words(vs_http_port));
							return false;
						}
					} 
					else if (array_vs_proto[i] == '1') 
					{
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
					} 
					else 
					{
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
					}
				}
			}
		} 
		catch (e) 
		{
			alert('error occur in adding port trigger ports into timeline');
		}
		
		// add port forward ports into timeline
		try 
		{
			for (var i=0; i<array_pf_enable.length; i++) 
			{
				if (array_pf_enable[i] == '0')
					continue;
				
				var pf_tcp_ports = array_pf_ports_tcp[i].split(',');
				for (var j=0; j<pf_tcp_ports.length; j++) 
				{
					var range = pf_tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					if (check_timeline(tcp_timeline) == false) 
					{
						//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
						alert(addstr(get_words(ag_conflict4), 'Port forwarding TCP', get_by_id("remote_http_management_port").value));
						return false;
					}
				}
				var pf_udp_ports = array_pf_ports_udp[i].split(',');
				for (var j=0; j<pf_udp_ports.length; j++) 
				{
					var range = pf_udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		} 
		catch (e) 
		{
			alert('error occur in adding port forward ports into timeline');
		}
		
		// add port trigger ports into timeline
		try {
			for (var i=0; i<array_pt_enable.length; i++) {
				if (array_pt_enable[i] == '0')
					continue;
				var pt_ports = array_pt_ports[i].split(',');
				for (var j=0; j<pt_ports.length; j++) {
					var range = pt_ports[j].split('-');
					if (array_pt_proto[i] == '0') {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						if (check_timeline(tcp_timeline) == false) 
						{
							//alert("TCP 通訊埠[" + get_by_id("public_port" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
							alert(addstr(get_words(ag_conflict4), 'Application Rule Firewall', get_by_id("remote_http_management_port").value));
							return false;
						}
					} else if (array_pt_proto[i] == '1') {
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
					} else {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
					}
				}
			}
		} catch (e) {
			alert('error occur in adding port trigger ports into timeline');
		}

		
		if ($('#admin_password1').val() != $('#admPass2').val()){
			alert(get_words('YM173'));
			return false;
		}else if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/") || _isNumeric(c_hostname)){
			alert(get_words('DDNS_HOST_ERROR'));
			return false;
		}else{
			if(get_by_id("remote_enable").checked)
			{
				if (!check_varible(remote_port_obj))
					return false;
			}
		}

		//check pasword is default/empty or not?
		if ($('#admin_password1').val() == ""){
			$('#blank_status').val(0);
		}else {
			if(is_quotes(get_by_id("admin_password1").value))
			{
				alert(get_words('S493'));
				return;
			}
			if(!is_ascii($('#admin_password1').val()))
			{
				alert(get_words('S493'));
				return
			}

			$('#blank_status').val(1);
			$('#admin_password1').val($('#admin_password2').val());
			$('#admPass2').val($('#admin_password2').val());
		}

		if($('#remote_http_management_enable').val() != get_checked_value(remote_enable))
		{
			$('#remote_http_management_enable').val(get_checked_value(remote_enable));
			$('#reboot_type').val('filter');
		}

		if(remote_port != ori_management_port || $('#remote_http_management_inbound_filter').val() != ori_inbound_filter)
		{
			$('#reboot_type').val('filter');
		}

		if($('#hostname').val() != ori_hostname)
		{
			$('#reboot_type').val('filter');
		}

			$('#remote_http_management_enable').val(get_checked_value(remote_enable));
			$('#graph_auth_enable').val(get_checked_value($('#graphical_enable')[0]));

			if ($('#admin_password').val() != rand_pass) {
				$('#html_response_return_page').val("login.asp");
			}
			
			//save_inbound_used(get_by_id("remote_http_management_inbound_filter").value, inbound_used);
			
			if(submit_button_flag == 0) {
				submit_button_flag = 1;

				var param = {
					url: 	"get_set.ccp",
					arg:	""
				};

				if ($('#admin_password').val() != array_password[0]) 
					param.arg = "ccp_act=set&ccpSubEvent=CCP_SUB_ADMIN&ccpSubEvent2=CCP_SUB_REMOTEMNGR&nextPage=login.asp";
				else
					param.arg = "ccp_act=set&ccpSubEvent2=CCP_SUB_REMOTEMNGR&nextPage=tools_admin.asp";

				param.arg += "&adminCfg_SystemName_1.1.0.0.0="+$('#hostname').val()+
							"&adminCfg_GraphAuthenticationEnable_1.1.0.0.0="+get_checked_value($('#graphical_enable')[0])+
							"&adminCfg_HttpsServerEnable_1.1.0.0.0="+get_checked_value($('#HttpsServerEnable')[0])+
							"&adminCfg_RemoteManagementEnable_1.1.0.0.0="+get_checked_value(remote_enable);

					if($('#remote_enable')[0].checked == true)
					{
						if ($('#RemoteAdminHttpsEnable')[0].checked == true){
							param.arg +="&adminCfg_RemoteAdminHttpsPort_1.1.0.0.0="+$('#remote_http_management_port').val()+
										"&adminCfg_RemoteAdminHttpPort_1.1.0.0.0="
						}else{
							param.arg +="&adminCfg_RemoteAdminHttpPort_1.1.0.0.0="+$('#remote_http_management_port').val()+
										"&adminCfg_RemoteAdminHttpsPort_1.1.0.0.0=";
						}
					}else
						param.arg +="&adminCfg_RemoteAdminHttpPort_1.1.0.0.0="+$('#remote_http_management_port').val();
							//"&adminCfg_RemoteAdminHttpsPort_1.1.0.0.0="+$('#adminCfg_RemoteAdminHttpsPort_').val()+
					param.arg +="&adminCfg_RemoteAdminHttpsEnable_1.1.0.0.0="+get_checked_value($('#RemoteAdminHttpsEnable')[0])+
							"&adminCfg_RemoteAdminInboundFilter_1.1.0.0.0="+$('#remote_inbound_filter').val()+
							"&adminCfg_Detail_1.1.0.0.0="+$('#remote_detail').val()+
							"&loginInfo_Username_1.1.1.0.0="+"admin"+
							"&loginInfo_Username_1.1.2.0.0="+"user"+
							"&loginInfo_Password_1.1.1.0.0="+urlencode($('#admin_password').val())+
							"&igdStorageAdmin_Password_1.1.1.0.0="+urlencode($('#admin_password').val())+
							"&dhcpCfg_Name_1.1.1.1.0="+$('#hostname').val()+
							"&dhcpplusCfg_Name_1.1.1.1.0="+$('#hostname').val();
				get_config_obj(param);	

				return false;
			} else {
				return false;
			}
		return false;
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>

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
		<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
		<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td id="sidenav_container">
			<div id="sidenav">
				<ul>
				<li><div id="sidenavoff"><script>show_words(_admin)</script></div></li>
				<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
				<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
				<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
				<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
				<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
				<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
				<li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
				<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li>
				</ul>
			</div>
			</td>
		</tr>
		</table>
		</td>

		<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_admin.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="blank_status" name="blank_status" value="">
			<input type="hidden" id="blank_state" name="blank_state" value="">		

		<td valign="top" id="maincontent_container">
			<div id="maincontent">
				<div id="box_header">
					<h1><script>show_words(ta_AdmSt)</script></h1>
					<script>show_words(ta_intro1)</script>
					<p><script>show_words(ta_intro_Adm2)</script></p>

					<input id="button" type="button" class=button_submit value="" onClick="return send_request();">
					<input id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'tools_admin.asp');">
					<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
					<script>get_by_id("button").value = get_words('_savesettings');</script>
				</div>
				<br>
				<div class="box">
					<h2><script>show_words(_password_admin)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td colspan="2" class="box_msg"><p><script>show_words(ta_msg_TW)</script></p></td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(_password)</script> :</td>
						<input type="hidden" id="admin_password" name="admin_password" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
						<input type="hidden" id="admin_password2" name="admin_password2" value="WDB8WvbXdH">
						<td width="340">
							<font face=Arial size=2>&nbsp;&nbsp;
							<input type=password id="admin_password1" name="admin_password1" onfocus="select();" size=20 maxlength=15 onChange="key_word(this,'admin_password');">
							</font>
						</td>
					</tr>
					<tr>
						<td class="duple"><script>show_words(_verifypw)</script> :</td>
						<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
							<input type=password id=admPass2 name=admPass2 onfocus="select();" size=20 maxlength=15 >
							</font>
						</td>
					</tr>
					</table>
				</div>
				<div class="box">
					<h2><script>show_words(ta_sn)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td class="duple"><script>show_words(ta_GWN)</script> :</td>
						<td width="340">
							<font face=Arial size=2>&nbsp;&nbsp;
							<input type="text" id="hostname" name="hostname" maxlength=32 value=''>
							</font>
						</td>
					</tr>
					</table>
				</div>

				<div class="box">
					<h2><script>show_words(ta_A12n)</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td class="duple1"><script>show_words(_graph_auth)</script> :</td>
						<td colspan="2">
						<div align="left">&nbsp;
							<input name="graphical_enable" type="checkbox" id="graphical_enable" value="1" checked>
							<input type="hidden" id="graph_auth_enable" name="graph_auth_enable" value=''>
						</div>
						</td>
					</tr>
					<tr>
						<td class="duple1"><script>show_words(LV2)</script> :</td>							
						<td colspan="2">
						<div align="left" id= "adm_https_en">&nbsp;
							<input name="HttpsServerEnable" type="checkbox" id="HttpsServerEnable" value="1" onClick="chg_https();">
						</div></td>		  
					</tr>					
					<tr>
						<td class="duple1"><script>show_words(ta_ERM)</script> :</td>
						<td colspan="2">
						<div align="left">&nbsp;
							<input name="remote_enable" type="checkbox" id="remote_enable" value="1" onClick="disable_obj();">
							<input type="hidden" id="remote_http_management_enable" name="remote_http_management_enable" value=''></div>
						</td>
					</tr>
					<tr>
						<td class="duple1"><script>show_words(ta_RAP)</script> :</td>
						<td  >
						<div align="left">&nbsp;&nbsp;
							<input type="text" id="remote_http_management_port" name="remote_http_management_port" value=''>
						</div>
						</td>
						<td  >
						<div align="left"><script>show_words(LV3)</script>
							<input name="RemoteAdminHttpsEnable" type="checkbox" id="RemoteAdminHttpsEnable" value="1" onClick="chg_rm_port();">
						</div>
						</td>						
					</tr>
					<tr>
						<td class="duple1"><script>show_words(ta_RAIF)</script> :</td>
						<td colspan="2">
						<div align="left">&nbsp;&nbsp;
							<select id="remote_inbound_filter" name="remote_inbound_filter" size="1" onChange="onIbChange(this.value);">
								<option value="255"><script>show_words(_allowall)</script></option>
								<option value="254"><script>show_words(_denyall)</script></option>
								<script>
									add_option();
									do_select('remote_inbound_filter', 'val', config_val('adminCfg_RemoteAdminInboundFilter_'));
								</script>
							</select>
							<input type="hidden" id="remote_http_management_inbound_filter" name="remote_http_management_inbound_filter" value=''>
						</div>
						</td>
					</tr>
					<tr>
						<td class="duple1"><script>show_words(_aa_details)</script> :</td>
						<td colspan="2">
						<div align="left">&nbsp;&nbsp;
							<input type=text id="remote_detail" name="remote_detail" size=48 maxlength=48 disabled>
						</div>
						</td>
					</tr>
					</table>
				</div>
			</div>
		</td>
		</form>
		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
		<tr>
			<td id="help_text"> 
				<strong><script>show_words(_hints)</script>&hellip;</strong> 
				<p>
					<script>show_words(hhta_pw)</script>
				</p>

				<p>
					<script>show_words(hhta_en)</script>
				</p>

				<p>
					<script>show_words(hhta_pt)</script>
				</p>

				<p>
					<script>show_words(hhta_831)</script>
				</p>

				<p><a href="support_tools.asp#Admin" onclick="return jump_if();">
				<script>show_words(_more)</script>
				&hellip;</a>
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
		<td width="10">&nbsp;</td>
		<td>&nbsp;</td>
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
