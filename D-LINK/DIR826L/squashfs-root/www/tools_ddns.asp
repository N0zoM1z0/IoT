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
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	var Region 		= dev_info.region;

	var param = {
		url: "get_set.ccp",
		arg: "ccp_act=get&num_inst=5"+
			"&oid_1=IGD_DynamicDNS_&inst_1=11000"+
			"&oid_2=IGD_Status_LANStatus_HostV6_i_&inst_2=11110"+
			"&oid_3=IGD_DynamicDNSList_&inst_3=10000"+
			"&oid_4=IGD_Status_WANStatus_&inst_4=11000"+
			"&oid_5=IGD_Storage_&inst_5=11000"
	};
	get_config_obj(param);

	var lanHostInfo = {
		'name':				config_val("igdLanHostV6Status_HostName_").split("/"),
		'ipaddr':			config_val("igdLanHostV6Status_HostIPv6Address_").split("/")
	};

	var reservedHost = {
		'enable':			config_str_multi("ddnsListCfg_Enable_"),
		'name':				config_str_multi("ddnsListCfg_HostName_"),
		'ipaddr':			config_str_multi("ddnsListCfg_Yiaddr_")
	};

	var ddnsCfg = {
		'enable':	config_val("ddnsCfg_DDNSEnable_"),
		'serv':		config_val("ddnsCfg_DDNSServer_"),
		'hostname':	config_val('ddnsCfg_HostName_'),
		'username':	config_val('ddnsCfg_Username_'),
		'pass':		config_val('ddnsCfg_Password_'),
		'timeout':	config_val('ddnsCfg_Timeout_')
	}

	var wanIp = config_val('igdWanStatus_IPAddress_');
	var wa_http_port = config_val('igdStorage_Http_Remote_Access_Port_');
	var wa_https_port = config_val('igdStorage_Https_Remote_Access_Port_');
	
	var reserveCnt 	= 0;
	if(reservedHost.name != null)
		reserveCnt = reservedHost.name.length;

	var submit_button_flag = 0;
	var query_times = 0;
    var rule_max_num = 24;
    var resert_rule = rule_max_num;
    var DataArray = new Array();		//reserved host
    var DHCPL_DataArray = new Array();	//lan host

	function Data(enable, name, ip, onList)
    {
        this.Enable = enable;
        this.Name = name;
        this.IP = ip;
        this.OnList = onList;
    }
	
	function DHCP_Data(name, ip, onList)
    {
        this.Name = name;
        this.IP = ip;
        this.OnList = onList;
    }

	function set_lan_dhcp_list(){
		var index = 0;
		if (lanHostInfo.name[0])
		{
		for (var i = 0; i < lanHostInfo.name.length; i++){
			var obj = get_by_id("v6PC_sel");
			var fsipaddr = lanHostInfo.ipaddr[i].split(':');
			if (fsipaddr[0] != 'fe80')
			{
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(lanHostInfo.name[i], lanHostInfo.ipaddr[i], index);
				var ooption = document.createElement("option");
				ooption.text = lanHostInfo.name[i];
				ooption.value = index;
				obj.options[index+1] = ooption;
				index++;
				}
			}
		}
	}

	function clear_reserved()
    {
        $('#v6_enable').attr('checked',false);
        $('#hostnamev6').val("");
        $('#addr_v6').val("");
        $('#edit').val(-1);
    }

	function set_reservation(){
		var index = 1;
		for (var i = 0; i < reserveCnt; i++)
		{
			if(reservedHost.ipaddr[i].length > 0){
				DataArray[DataArray.length++] = new Data(reservedHost.enable[i],reservedHost.name[i],reservedHost.ipaddr[i], i);
				index ++;
			}
		}
		$('#max_row').val(index-1);
	}

	function copy_v6PC()
	{
		var idx = parseInt($('#v6PC_sel')[0].selectedIndex);
		
		if (idx > 0){
			$('#v6_enable').attr('checked',true);
			$('#addr_v6').val(DHCPL_DataArray[idx - 1].IP);
			//$('#hostnamev6').val(DHCPL_DataArray[idx - 1].Name);
		}
	}

	function update_DataArray(){
		var index = parseInt($('#edit').val());
		var insert = false;
		var is_enable = "0";

		if(index == "-1"){      //save
			if(DataArray.length == rule_max_num){
				alert(get_words('TEXT015'));
			}else{
				index = DataArray.length;
				$('#max_row').val(index);
				insert = true;
			}
		}
		is_enable = ($('#v6_enable')[0].checked)?1:0;

		if(insert){
			DataArray[index] = new Data(is_enable, $('#hostnamev6').val(), $('#addr_v6').val(), index);			
		}else if (index != -1){
			DataArray[index].Enable = is_enable;
			DataArray[index].Name = $('#hostnamev6').val();
			DataArray[index].IP = $('#addr_v6').val();
			DataArray[index].OnList = index;
		}
		return true;
	}

	function edit_row(idx)
    {
        if (DataArray[idx].Enable == 1)
            $('#v6_enable').attr('checked',true);
        else
            $('#v6_enable').attr('checked',false);

        $('#hostnamev6').val(DataArray[idx].Name);
        $('#addr_v6').val(DataArray[idx].IP);
        //$('#edit').val(idx);
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
			DataArray[i].OnList = DataArray[i+1].OnList;
		}
		
		if(DataArray.length > 0)
			DataArray.length -- ;

		paintDNSTable();
		$('#modified').val("true");
	}

	function paintDNSTable()
	{
		var contain = ""
		contain +='<table id="table2" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">';
		contain +='<tr>';
		contain +='<td>'+get_words(_enable)+'</td>';
		contain +='<td>'+get_words(_hostname)+'</td>';
		contain +='<td>'+get_words(IPV6_TEXT0)+'</td>';
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
			contain += "<tr><td><center><input type=checkbox value=1 id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></center></td></tr>";
		}
		contain += '</table>';
		$('#DNSTable').html(contain);
	}

	function set_DNSList(){
		var index = 1;
		for (var i = 0; i < reserveCnt; i++)
		{
			if(reservedHost.ipaddr[i].length > 0){
				DataArray[DataArray.length++] = new Data(reservedHost.enable[i],reservedHost.name[i],reservedHost.ipaddr[i], i);
				index ++;
			}
		}
		$('#max_row').val(index-1);
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
			arg: 'ccp_act=del&ccpSubEvent=CCP_SUB_DDNS&num_inst=' + delCnt
		};
		
		while(delCnt > 0)
		{
			paramDel.arg += '&oid_'+delCnt+'=IGD_DynamicDNSList_&inst_'+delCnt+'=' + '1.'+ idx +'.0.0.0';
			delCnt --;
			idx --;
		}
		
		ajax_submit(paramDel);
	}

	//20120926 Silvia add SUPPORT ORAY
	function paintDDNSlist()
	{
		var contain = ""
		contain +=  '<select id="ddns_type_sel" name="ddns_type_sel" tabindex=2>'+
					'<option value="def_selection">'+ get_words("KR99") +'</option>'+
					'<option value="dlinkddns.com(Free)">dlinkddns.com(Free)</option>'+
					'<option value="dyndns.com(Custom)">dyndns.com(Custom)</option>'+
					'<option value="dyndns.com(Free)">dyndns.com(Free)</option>';

		if (Region == 'CN')
			contain +='<option value="oray.com.cn">oray.com.cn</option>';

		contain +='</select>';	

		$('#DDNS_list').html(contain);
	}
//--------------------Some things need to change--------------------------------

	function save_reserved(bufferSaveFlag)
	{
		var index = 0;
		//$('#modified').val("true");
		var reserved_enable = get_checked_value($('#v6_enable')[0]);
		var reserved_name = $('#hostnamev6').val();
		var reserved_ip = $('#addr_v6').val();

		var Res_ip_addr_msg = replace_msg(all_ipv6_addr_msg,"Reservation IP");
		var temp_res_ip_obj = new addr_obj(reserved_ip.split(":"), Res_ip_addr_msg, false, false);
		
		//check the IP Address
		if(check_ipv6_symbol(reserved_ip,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(reserved_ip,"::")==1){    // find one '::' symbol
			temp_res_ip_obj = new ipv6_addr_obj(reserved_ip.split("::"), Res_ip_addr_msg, false, false);
			if (!check_ipv6_address(temp_res_ip_obj ,"::"))
				return false;
		}else{	//not find '::' symbol
			temp_res_ip_obj  = new ipv6_addr_obj(reserved_ip.split(":"), Res_ip_addr_msg, false, false);
			if (!check_ipv6_address(temp_res_ip_obj,":")){
				return false;
			}
		}

		if(bufferSaveFlag == "N" && reserved_name == ""){
			clear_reserved();
			return true;
		}else{
			if(reserved_name == ""){
				//alert(msg[STATIC_DHCP_NAME]);
				alert(get_words('GW_INET_ACL_NAME_INVALID'));
				return false;
/*			}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, get_words('TEXT033'))){
				return false;
*/			}
		}

        //check same ip
        var edit_tmp = $('#edit').val();
        var index = parseInt(edit_tmp);
		if (DataArray != null) {
			for(var m = 0; m < DataArray.length; m++){
				if (m == index) {
					continue;
				}
				
				if ($('#hostnamev6').val().length > 0) {
					if(($('#hostnamev6').val() == DataArray[m].Name)){
						var alt_msg = addstr1(get_words('GW_QOS_RULES_NAME_ALREADY_USED'), $('#hostnamev6').val());
						alert(alt_msg);					
						return false;
					}
				}

/*				if (reserved_ip.length > 0) {
					if((reserved_ip == DataArray[m].IP)){
						var alt_msg = addstr1(get_words('GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID'), " ("+ reserved_ip +") ");
						alert(alt_msg);
						return false;
					}
				}
*/			}
		}

        update_DataArray();
		paintDNSTable();
		clear_reserved();
		$('#modified').val("true");
		return true;
	}

	function set_reserved_enable(index)
	{
		DataArray[index].Enable = get_checked_value($('#r_enable'+index)[0]);
		$('#modified').val("true");
	}
	//end of silvia add

	function disable_obj(){
		var re_enable = get_by_id("d_enable");
		var is_disable = true;
		if (re_enable.checked){
			is_disable = false;
		}
		get_by_id("copy_serv").disabled = is_disable;
		get_by_id("ddns_server").disabled = is_disable;
		get_by_id("ddns_type_sel").disabled = is_disable;
		get_by_id("ddns_hostname").disabled = is_disable;
		get_by_id("ddns_username").disabled = is_disable;
		get_by_id("ddns_password1").disabled = is_disable;
		get_by_id("ddns_password2").disabled = is_disable;
		get_by_id("ddns_sync_interval").disabled = is_disable;
	}

	function onPageLoad()
	{
		if (ddnsCfg.enable == '1') 
			get_by_id('d_enable').checked = true;
		else 
			get_by_id('d_enable').checked = false;

		get_by_id('ddns_server').value = ddnsCfg.serv;
		get_by_id('ddns_hostname').value = ddnsCfg.hostname;
		get_by_id('ddns_username').value = ddnsCfg.username;
		get_by_id('ddns_password1').value = ddnsCfg.pass;
		get_by_id('ddns_password2').value = ddnsCfg.pass;
		get_by_id('ddns_sync_interval').value = ddnsCfg.timeout;
		
		if(login_Info != "w"){
			DisableEnableForm(document.form1,true);	
		}
		paintDDNSlist();
		disable_obj();
		set_form_default_values("form1");
	}

	function check_form()
	{
		if (get_by_id('d_enable').checked == false)
			return true;
		
		// server cannot be empty
		if (get_by_id('ddns_server').value == '') {
			alert(get_words('srv_name_empty'));
			//alert(addstr1(get_words('GW_DYNDNS_SERVER_INDEX_VALUE_INVALID'),$('#ddns_type_sel')[0].selectedIndex));
			return false;
		}

		// host name cannot be empty
		if (get_by_id('ddns_hostname').value == '') {
			alert(get_words('GW_DYNDNS_HOST_NAME_INVALID'));
			return false;
		}
		
		// user name cannot be empty
		if (get_by_id('ddns_username').value == '') {
			alert(get_words('GW_DYNDNS_USER_NAME_INVALID'));
			return false;
		}
		
		// password cannot be empty
		if (get_by_id('ddns_password1').value == '') {
			alert(get_words('GW_DYNDNS_PASSWORD_INVALID'));
			return false;
		}
		
		// two passwords are not equal
		if (get_by_id('ddns_password1').value != get_by_id('ddns_password2').value) {
			alert(get_words('YM177'));
			return false;
		}
		
		temp_obj = get_by_id("ddns_sync_interval");
		var timeout_msg = replace_msg(check_num_msg, "Timeout", 1, 8760);
		obj = new varible_obj(temp_obj.value, timeout_msg, 1, 8760, false);
		if(!check_varible(obj)){
    		return false;
    	}
	}
	
	function do_copy_serv()
	{
		if ($('#ddns_type_sel').val() != 'def_selection')
			$('#ddns_server').val($('#ddns_type_sel').val());
	}
	
	function send_request()
	{
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}

		if (check_form() == false)
		{
			return;
		}
		
		if (get_by_id('d_enable').checked)
			get_by_id('ddns_enable').value = '1';
		else
			get_by_id('ddns_enable').value = '0';


		if(submit_button_flag == 0){
			submit_button_flag = 1;
			deleteRedundentDatamodel();
			submit_all();
			//send_submit("form1");
		}
	}

	function submit_all()
	{
		var paramForm = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_DDNS&nextPage=tools_ddns.asp'
		};

		var http_stolink = '';
		var https_stolink = '';
		var ddns_en = get_checked_value($('#d_enable')[0]);
		if (ddns_en == 0)
		{
			http_stolink ='http://'+wanIp+':'+wa_http_port;
			https_stolink ='https://'+wanIp+':'+wa_https_port;
		}else{
			http_stolink = 'http://'+ddnsCfg.hostname+':'+wa_http_port;
			https_stolink = 'https://'+ddnsCfg.hostname+':'+wa_https_port;
		}
		paramForm.arg += "&igdStorage_Http_Storage_Link_1.1.1.0.0="+http_stolink;
		paramForm.arg += "&igdStorage_Https_Storage_Link_1.1.1.0.0="+https_stolink;
		paramForm.arg += "&ddnsCfg_DDNSEnable_1.1.0.0.0="+ddns_en;
		paramForm.arg += "&ddnsCfg_DDNSServer_1.1.0.0.0="+$('#ddns_server').val();
		//paramForm.arg += "&ddnsCfg_DDNSServer_1.1.0.0.0="+$('#ddns_type_sel').val();
		paramForm.arg += "&ddnsCfg_HostName_1.1.0.0.0="+$('#ddns_hostname').val();
		paramForm.arg += "&ddnsCfg_Username_1.1.0.0.0="+$('#ddns_username').val();		
		paramForm.arg += "&ddnsCfg_Password_1.1.0.0.0="+$('#ddns_password1').val();
		paramForm.arg += "&ddnsCfg_Timeout_1.1.0.0.0="+$('#ddns_sync_interval').val();
	
		/*construct reservation*/
		for(var i=0; i<DataArray.length; i++)
		{
			var instStr = "1."+ (i+1) +".0.0.0";
			paramForm.arg += "&ddnsListCfg_Enable_"+instStr+"="+DataArray[i].Enable;
			paramForm.arg += "&ddnsListCfg_HostName_"+instStr+"="+DataArray[i].Name;
			paramForm.arg += "&ddnsListCfg_Yiaddr_"+instStr+"="+DataArray[i].IP;
		}
		get_config_obj(paramForm);
	}
	
	function query_ddns_status()
	{
		var param = {
			'url': 	'get_set.ccp',
			'arg': 	'ccp_act=get&num_inst=1'+
					'&oid_1=IGD_Status_DDNSStatus_&inst_1=11000'
		};
		get_config_obj(param);
	
		var ddns_status = config_val("igdDdnsStatus_DDNSStatus_");
		var show_ddns_status = "Connecting";
		if (ddns_status == "1"){
			show_ddns_status = get_words('ddns_connected');
		}
		
		get_by_id("ddns_status").innerHTML = show_ddns_status;
		//document.write(show_ddns_status);
		if (ddns_status == "1")
			return;
	
		if(query_times >=5 )
		{
			get_by_id("ddns_status").innerHTML = get_words('ddns_disconnect');
			return;
		}
			
		query_times++;
		setTimeout("query_ddns_status()",1000);
	}

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
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
		<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
		<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td id="sidenav_container">
			<div id="sidenav">
				<!-- === BEGIN SIDENAV === -->
				<ul>
					<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
					<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
					<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
					<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
					<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
					<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
					<li><div id="sidenavoff"><script>show_words(_dyndns)</script></div></li>
					<li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
					<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li>
					<!--<li><div id="sidenavon"><a href="logout.asp" onclick="do_logout();"><script>show_words(logout_caption)</script></a></div></li>
					-->
				</ul>
			<!-- === END SIDENAV === -->
			</div>
			</td>			
		</tr>
		</table>			
		</td>
		<form  name="form1" id="form1">
			<input type="hidden" id="max_row" name="max_row" value="-1">
			<input type="hidden" id="del" name="del" value="-1">
			<input type="hidden" id="edit" name="edit" value="-1">
			<input type="hidden" name="modified" id="modified" value="0">
		<td valign="top" id="maincontent_container">
		<div id="maincontent">
			<!-- === BEGIN MAINCONTENT === -->

			<div id="box_header"> 
				<h1><script>show_words(_dyndns)</script></h1>
				<p><script>show_words(td_intro_DDNS)</script></p>
				<p><script>show_words(td_intro_DDNS_DLINK)</script> <a href="http://www.DLinkDDNS.com" target="_blank">www.DLinkDDNS.com</a></p>
				<input name="button1" id="button1" type="button" class=button_submit value="" onClick="send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1','tools_ddns.asp');">
				<script>get_by_id("button1").value = get_words('_savesettings');</script>
				<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>

			</div>
			<div class="box"> 
				<h2><script>show_words(_dyndns)</script></h2>
				<table width=525 border=0 cellpadding=0>
				<tr>
					<td width=150 align=right class="duple">
						<script>show_words(td_EnDDNS)</script>
					:</td>
					<td height=20>&nbsp;
						<input name="d_enable" type="checkbox" id="d_enable" value="1" onClick="disable_obj();">
						<input type="hidden" id="ddns_enable" name="ddns_enable" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(td_SvAd)</script>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="text" id="ddns_server" name="ddns_server">
						<input type="button" id="copy_serv" value="<<" onclick="do_copy_serv()" style="width:32">
						<span id='DDNS_list'></span>
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(_hostname)</script>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="text" id="ddns_hostname" name="" size="20" maxlength="60" value="">
						<script>show_words(_hostname_eg)</script>
					</td>
				</tr>
				<tr>
					<td align=right class="duple">
						<script>show_words(td_UNK)</script>
					:</td>
					<td height=21>&nbsp;&nbsp;
						<input type="text" id="ddns_username" name="ddns_username" size="20" maxlength="60" value="">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"> 
						<script>show_words(td_PWK)</script>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="password" id="ddns_password1" name="ddns_password1" size="20" maxlength="40" value="WDB8WvbXdH" onChange="key_word(this,'ddns_password1');">
					</td>
				</tr>
				<tr>
					<td align=right class="duple"> 
						<script>show_words(td_VPWK)</script>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="password" id="ddns_password2" name="password2" size="20" maxlength="40" value="WDB8WvbXdH" onChange="key_word(this,'ddns_password2');">
					</td>
				</tr>
				<tr style="display:none">
					<td align=right>&nbsp;</td>
					<td height=20>&nbsp;&nbsp;
						<input type="button" id="btn_do_test" value="" onclick="">
						<script>
						get_by_id('btn_do_test').value = get_words('ddns_account');
						</script>
					</td>
				</tr>
				
				<tr>
                <td align=right class="duple">
                  <script>show_words(td_Timeout)</script>
                  &nbsp;:</td>
					  <td height=20>&nbsp;&nbsp;
						<input type="text" id="ddns_sync_interval" name="ddns_sync_interval" size="10" maxLength="4" value="">
					  <script>show_words(td_)</script>
					  </td>
				</tr>

				<tr style="display:">
					<td align=right class="duple">
						<script>show_words(_status)</script>
					&nbsp;:</td>
					<td height=20>&nbsp;&nbsp;
						<span id="ddns_status"></span>
					</td>
				</tr>
				<tr style="display:none">
					<td align=right class="duple">
						<script>show_words(ddns_serv_type)</script>
					&nbsp;:</td>
					<td height=20>&nbsp;&nbsp;</td>
				</tr>
				<tr style="display:none">
					<td align=right class="duple">
						<script>show_words(ddns_domain)</script>
					&nbsp;:</td>
					<td height=20>&nbsp;&nbsp;</td>
				</tr>
				</table>
			</div>
		</form>
			<!-- 20120130 silvia add v6 -->
			<div class="box"> 
				<h2><script>show_words(IPv6_ddns_01)</script></h2>
				<table width=525 border=0 cellpadding=0>
				<tr><br>
					<td width=120 align=right>
						<b><script>show_words(_enable)</script></b>
					:</td>
					<td height=20>&nbsp;
						<input name="v6_enable" type="checkbox" id="v6_enable" value="0">
					</td>
				</tr>
				<tr>
					<td align=right>
						<b><script>show_words('IPV6_TEXT0')</script></b>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="text" id="addr_v6" name="addr_v6" size="36">
						<input type="button" id="copy_pc" value="<<" style="width:32" onclick='copy_v6PC();'>
						<select id="v6PC_sel" name="v6PC_sel" tabindex=2 >
							<option><script>show_words(bd_CName)</script></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align=right>
						<b><script>show_words(_hostname)</script></b>
					:</td>
					<td height=20>&nbsp;&nbsp;
						<input type="text" id="hostnamev6" name="hostnamev6" size="30" maxlength="60" value="">
						<script>show_words(_hostname_eg)</script>
					</td>
				</tr>
				<tr>
					<td colspan=2 align=center>&nbsp;<br>
						<input id="save" name="save" type="button" class=button_submit value="" onClick="save_reserved('Y');">
						<input id="clear" name="clear" type="button" class=button_submit value="" onClick="clear_reserved();">
						<script>$('#save').val(get_words('_save'));</script>
						<script>$('#clear').val(get_words('_clear'));</script>
					</td>
				</tr>
				</table>
			</div>

			<div class=box id="DNS_list">
				<h2><script>show_words(IPv6_ddns_02)</script></h2>
				<span id="DNSTable"></span>
					<script>
						set_lan_dhcp_list();
						set_DNSList();
						paintDNSTable();
					</script>
			</div>
			<!-- === END MAINCONTENT === -->
		</div>
		</td>

		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
		<tr>
			<td id=help_text>
			<strong> 
				<script>show_words(_hints)</script>&hellip;
			</strong> 
			<p><script>show_words(TA16)</script></p>
			<p class="more"><a href="support_tools.asp#Dynamic_DNS" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	if (ddnsCfg.enable == '1')
		query_ddns_status();
	else
		get_by_id("ddns_status").innerHTML = get_words('ddns_disconnect');
</script>
</html>