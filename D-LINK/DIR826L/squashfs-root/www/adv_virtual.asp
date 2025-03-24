<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<link rel="STYLESHEET" type="text/css" href="css_router.css">
	<script src="uk.js" type="text/javascript"></script> 
	<script language="JavaScript" src="public.js"></script> 
	<script language="JavaScript" src="public_msg.js"></script> 
	<script language="JavaScript" src="pandoraBox.js"></script>
	<script language="Javascript" src="js/jquery-1.3.2.min.js"></script> 
	<script language="Javascript" src="js/xml.js"></script> 
	<script language="Javascript" src="js/object.js"></script> 
    <script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=9&"+
				"oid_1=IGD_WANDevice_i_VirServRule_i_&inst_1=11000&"+
				"oid_2=IGD_ScheduleRule_i_&inst_2=10000&"+
				"oid_3=IGD_WANDevice_i_InboundFilter_i_&inst_3=11000&"+
				"oid_4=IGD_Status_LANStatus_Host_i_&inst_4=11110&"+
				"oid_5=IGD_&inst_5=10000&"+
				"oid_6=IGD_WANDevice_i_PortFwd_i_&inst_6=11000&"+
				"oid_7=IGD_WANDevice_i_PortTriggerRule_i_&inst_7=11000&"+
				"oid_8=IGD_AdministratorSettings_&inst_8=10000&"+
				"oid_9=IGD_Storage_&inst_9=11000"
	};
	get_config_obj(param);
	var dev_mode = config_val("igd_DeviceMode_");
	
	var array_enable 		= config_str_multi("vsRule_Enable_");
	var array_name 			= config_str_multi("vsRule_VirtualServerName_");
	var array_intnlip 		= config_str_multi("vsRule_InternalIPAddr_");
	var array_PubPort 		= config_str_multi("vsRule_PublicPort_");
	var array_PriPort 		= config_str_multi("vsRule_PrivatePort_");
	var array_Protcol	 	= config_str_multi("vsRule_Protocol_");
	var array_Schdule 		= config_str_multi("vsRule_ScheduleIndex_");
	var array_Policy 		= config_str_multi("vsRule_Policy_");
	var array_Protcol_num	= config_str_multi("vsRule_ProtoNum_");
	
	var array_pf_enable		= config_str_multi("pfRule_Enable_");
	var array_pf_ports_udp	= config_str_multi("pfRule_UDPOpenPorts_");
	var array_pf_ports_tcp	= config_str_multi("pfRule_TCPOpenPorts_");
	var array_pt_enable		= config_str_multi("ptRule_Enable_");
	var array_pt_proto		= config_str_multi("ptRule_FirewallProtocol_");
	var array_pt_ports		= config_str_multi("ptRule_FirewallPorts_");

	var array_sch_inst 		= config_inst_multi("IGD_ScheduleRule_i_");
	var array_schedule_name	= config_str_multi("schRule_RuleName_");
	var wa_http_en 			= config_val("igdStorage_Http_Remote_Access_Enable_");
	var wa_http_port 		= config_val("igdStorage_Http_Remote_Access_Port_");
	var wa_https_port		= config_val("igdStorage_Https_Remote_Access_Port_");
	var schedule_cnt = 0;
	
	if(array_schedule_name != null)
		schedule_cnt = array_schedule_name.length;

	var inbound_cnt = 0;
	var array_ib_inst		= config_inst_multi("IGD_WANDevice_i_InboundFilter_i_");
	var array_ib_name		= config_str_multi("ibFilter_Name_");
	
	if(array_ib_name != null)
		inbound_cnt = array_ib_name.length;
	
	var submit_button_flag = 0;
	var rule_max_num = 24;
	var inbound_used = 0;
	
	function onPageLoad(){
		var login_who=login_Info;
		if(login_who!= "w" || dev_mode == "1"){
			DisableEnableForm(form2,true);	
		}
		
		setTimeout("paint_table()", 5);
	}

	function set_vs_protocol(i, which_value, obj){
		set_selectIndex(which_value,obj);
		get_by_id("protocol"+i).disabled=true;
		if(which_value != obj.options[obj.selectedIndex].value){
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol_select"+i).selectedIndex = 3;

		}

		get_by_id("protocol"+i).value=which_value;
	}
    function protocol_change(i){			
		var sel = $('#protocol_select'+i).attr("selectedIndex");
		if(sel < 3){ //TCP, UDP, Both, Other
			$("#protocol"+i).attr('disabled', 'disabled');
			$("#public_portS"+i).attr('disabled', '');
			$("#private_portS"+i).attr('disabled', '');
			$("#protocol"+i).val($('#protocol_select'+i).val());
		}else if(get_by_id("protocol_select"+i).selectedIndex == 3){ // Other
			$("#public_portS"+i).val('0');
			$("#private_portS"+i).val('0');
			$("#protocol"+i).attr('disabled', '');
			//$("#protocol"+i).val('');
		}
		
		if(login_Info != "w")
		{
			$("#protocol"+i).attr('disabled', 'disabled');
			$("#public_portS"+i).attr('disabled', 'disabled');
			$("#private_portS"+i).attr('disabled', 'disabled');
		}
	}

	function detect_protocol_change_port(proto,i){			
		if((proto == 0)||(proto == 1)||(proto == 2)){
			get_by_id("protocol"+i).disabled=true;
			get_by_id("public_portS"+i).disabled =false;
			get_by_id("private_portS"+i).disabled =false;
		}else{
			get_by_id("public_portS"+i).disabled=true;
			get_by_id("private_portS"+i).disabled=true;

		}
		
		if(login_Info != "w")
		{
			get_by_id("protocol"+i).disabled=true;
			get_by_id("public_portS"+i).disabled =true;
			get_by_id("private_portS"+i).disabled =true;
		}
	}

	function send_request(){
		var tcp_timeline = '';
		var udp_timeline = '';
		
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form3") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = get_by_id("name" + i).value;
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == get_by_id("name" + j).value){
						//alert("The virtual server name is already in the list");
						//alert("名稱"+ get_by_id("name" + j).value + "已被使用.");	//av_alert_16
						alert(addstr(which_lang[av_alert_16], get_by_id("name" + j).value));
						return false;
					}
				}
			}
		}
		
		// add port forward ports into timeline
		try {
			for (var i=0; i<array_pf_enable.length; i++) {
				if (array_pf_enable[i] == '0')
					continue;
				var pf_tcp_ports = array_pf_ports_tcp[i].split(',');
				for (var j=0; j<pf_tcp_ports.length; j++) {
					var range = pf_tcp_ports[j].split('-');
					tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
				}
				var pf_udp_ports = array_pf_ports_udp[i].split(',');
				for (var j=0; j<pf_udp_ports.length; j++) {
					var range = pf_udp_ports[j].split('-');
					udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
				}
			}
		} catch (e) {
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

		//add Remote management port to time line
		var remote_port=config_val("adminCfg_RemoteAdminHttpPort_");
		var remote_port_enable=config_val("adminCfg_RemoteManagementEnable_");
		var remote_https_port=config_val("adminCfg_RemoteAdminHttpsPort_");
		
		try
		{
			if(remote_port_enable == '1')
			{
				var tcp_ports = remote_port;
				var tcp_ports_https = remote_https_port;
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports_https, null);
			}
		}
		catch (e)
		{
			alert('error occur in adding port remote ports into timeline');
		}

		//add web access ports into timeline
		if(wa_http_en == 1)
		{
			tcp_timeline = add_into_timeline(tcp_timeline, wa_http_port, null);
			tcp_timeline = add_into_timeline(tcp_timeline, wa_https_port, null);
		}

		for (var i = 0; i < rule_max_num; i++) {
			var ip = get_by_id("ip" + i).value;
			var protocol = get_by_id("protocol_select" +i).selectedIndex;
			var other = get_by_id("protocol"+i).value;
			var check_name = get_by_id("name" + i).value;

			var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[help256]);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_vs;

			if (check_name != ""){
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					//alert("Port forwarding name "+ i +" invalid. the legal characters can not enter ',/,''");
					//alert("端口??名"+ i +"?效。非法字符 ',/,''");
					alert(addstr(which_lang[TEXT002], i));
					return false;
				}

				//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(dev_info.lanIP.split('.'), temp_ip_obj.addr, which_lang[help256])){
					return false;
				}

				var name_string = get_by_id("name" + i).value.toUpperCase();
				if (name_string != "WAKE-ON-LAN"){

					if (!check_address(temp_ip_obj)){
			            return false;
			        }
		        }

				// check port
				if (!check_port(get_by_id('public_portS'+i).value)) {
					alert(which_lang[virtual_pub_port_err]);
					return false;
				}else if (!check_port(get_by_id('private_portS'+i).value)) {
					alert(which_lang[virtual_pri_port_err]);
					return false;
				}
				
				// check protocol number 
				if (!check_integer(get_by_id('protocol'+i).value, 0, 256)) {
					alert(which_lang[virtual_proto_num_err]);
					return false;
				}

				var is_enable = get_checked_value(get_by_id("enable" + i));
				var protocol_type = 'Both';
				// check port range
				if (is_enable == '1') {
					if (get_by_id("protocol" + i).value == '6') {			//tcp
						tcp_timeline = add_into_timeline(tcp_timeline, get_by_id("public_portS" + i).value, null);
						protocol_type = "TCP";
					} else if (get_by_id("protocol" + i).value == '17') {	//udp
						udp_timeline = add_into_timeline(udp_timeline, get_by_id("public_portS" + i).value, null);
						protocol_type = "UDP";
					} else if (get_by_id("protocol" + i).value == '256') {	//all
						tcp_timeline = add_into_timeline(tcp_timeline, get_by_id("public_portS" + i).value, null);
						udp_timeline = add_into_timeline(udp_timeline, get_by_id("public_portS" + i).value, null);
					}
				}

				if ((check_timeline(tcp_timeline) == false) || (check_timeline(udp_timeline) == false)){
					alert(addstr(get_words(ag_conflict5), protocol_type, get_by_id("public_portS" + i).value));
					return false;
				}

				// For CGI real data
				get_by_id("vsRule_Enable_"+(i+1)).value = is_enable;
				get_by_id("vsRule_VirtualServerName_"+(i+1)).value = get_by_id("name" + i).value;
				get_by_id("vsRule_InternalIPAddr_"+(i+1)).value = get_by_id("ip" + i).value;
				get_by_id("vsRule_PublicPort_"+(i+1)).value = get_by_id("public_portS" + i).value;
				get_by_id("vsRule_PrivatePort_"+(i+1)).value = get_by_id("private_portS" + i).value;
				get_by_id("vsRule_Protocol_"+(i+1)).value = get_by_id("protocol_select"+i).selectedIndex;
				get_by_id("vsRule_ProtoNum_"+(i+1)).value = get_by_id("protocol" + i).value;
				get_by_id("vsRule_ScheduleIndex_"+(i+1)).value = get_by_id("schedule" + i).value;
				get_by_id("vsRule_Policy_"+(i+1)).value = get_by_id("inbound_filter" + i).value;

		        count++;
			} else {
				if (get_by_id('enable'+i).checked == true) {
					alert(which_lang[vs_name_empty]);
					return false;
				}
				else	// both disable and empty name, clear the form
				{
					get_by_id("vsRule_Enable_"+(i+1)).value = '0';
					get_by_id("vsRule_VirtualServerName_"+(i+1)).value = '';
					get_by_id("vsRule_InternalIPAddr_"+(i+1)).value = '0.0.0.0';
					get_by_id("vsRule_PublicPort_"+(i+1)).value = '0';
					get_by_id("vsRule_PrivatePort_"+(i+1)).value = '0';
					get_by_id("vsRule_Protocol_"+(i+1)).value = '0';
					get_by_id("vsRule_ProtoNum_"+(i+1)).value = '0';
					get_by_id("vsRule_ScheduleIndex_"+(i+1)).value = '0';
					get_by_id("vsRule_Policy_"+(i+1)).value = '0';
				}
			}
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}

	function add_option(id, def_val)
	{
		var obj = null;
		var arr = null;
		var nam = null;
		var str = '';
		
		if (id == 'Schedule') {
			obj = schedule_cnt;
			arr = array_sch_inst;
			nam = array_schedule_name;
		} else if (id == 'Inbound') {
			obj = inbound_cnt;
			arr = array_ib_inst;
			nam = array_ib_name;
		}
		
		if (obj == null)
			return;

		for (var i = 0; i < obj; i++){		
			var str_sel = '';
			
			if (id == 'Schedule') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(1))
					str_sel = 'selected';
					
				//document.write("<option value=" + inst.charAt(1) + ">" + nam[i] + "</option>");
				str += ("<option value=" + inst.charAt(1) + " " + str_sel + ">" + nam[i] + "</option>");
			} else if (id == 'Inbound') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(2))
					str_sel = 'selected';
					
				//document.write("<option value=" + inst.charAt(2) + ">" + nam[i] + "</option>");
				str += ("<option value=" + inst.charAt(2) + " " + str_sel + ">" + nam[i] + "</option>");
			}
		}
		return str;
	}

	function do_select(id, type, value)
	{
		var obj = null;
		
		if (type == 'idx') {
			obj = $('#'+id+' option:eq('+value+')')
		} else if (type == 'val') {
			obj = $('#'+id+' option[value='+value+']');
		}
		
		if (obj == null)
			return;
		obj.attr("selected", true);
	}

	function paint_table()
	{
		var table_str = '<form id="form3"><h2>' + rule_max_num + '&ndash;&ndash; ' + get_words(vs_vslist) + '</h2>';
			table_str += '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1><tbody>';
			table_str += '<tr>';
			table_str += '<td align=middle width=20>&nbsp;</td><td width="36">&nbsp;</td>';
			table_str += '<td width="200">&nbsp;</td>';
			table_str += '<td width="130" align=middle><div align="left"><strong>'+get_words(_vs_port)+'</strong></div></td>';
			table_str += '<td width="130" align=middle><div align="left"><strong>'+get_words(_vs_traffictype)+'</strong></div></td>';
			table_str += '<td width="120" align=middle><div align="center">&nbsp;</td>';
			table_str += '</tr>';
		//var table_str = "";	
		var Application_list = set_application_option(Application_list, default_virtual);
		//var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
		var Inbound_list = '';
		var disabledStr = "";
		if(login_Info!= "w" || dev_mode == "1"){
			disabledStr = "disabled";
		}
		for(var i=0 ; i<rule_max_num ; i++){
			var obj_enable = "";
			var obj_name = "";
			var obj_intnlip = "";
			var obj_PubPort = "";
			var obj_PriPort = "";
			var obj_Protcol = "";
			var obj_Schdule = "";
			var obj_Policy  = "";
			var obj_ProtcolNum = "";

			if(array_enable!=null)
				obj_enable = array_enable[i];
			if(array_name!=null)
				obj_name = array_name[i];
			if(array_intnlip!=null)
				obj_intnlip = array_intnlip[i];
			if(array_PubPort!=null)
				obj_PubPort = array_PubPort[i];
			if(array_PriPort!=null)
				obj_PriPort = array_PriPort[i];
			if(array_Protcol!=null)
				obj_Protcol = array_Protcol[i];
			if(obj_ProtcolNum!=null)
				obj_ProtcolNum = array_Protcol_num[i];
			if(array_Schdule!=null)
				obj_Schdule = array_Schdule[i];
			if(array_Policy!=null)
				obj_Policy = array_Policy[i];
		
			table_str += "<tr>";
			if (obj_enable == '1')
				table_str += "<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>";
			else
				table_str += "<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>";
			table_str += '<td valign=bottom>'+which_lang[_name]+'<br><input '+disabledStr+' type=text class=flatL id=\"name' + i + '\" name=\"name'+ i +'\" size=16 maxlength=31 value="'+ obj_name +'"></td>';
			table_str += "<td align=left valign=bottom>";
			table_str += "<input "+disabledStr+" id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_virtual(" + i + ")' style=\"width: 23;\">";
			table_str += "<select "+disabledStr+" style='width:110' id=application" + i +" name=application" + i +" modified=\"ignore\">";
			table_str += '<option>'+which_lang[gw_SelVS]+'</option>';
			table_str += Application_list;
			table_str += "</select></td>";
			table_str += '<td align=center valign=bottom>'+which_lang[av_PubP]+'<br><input '+disabledStr+' type=text class=flatL id=public_portS'+ i + ' name=public_portS' + i +' size=5 maxlength=5 value="'+obj_PubPort+'"></td>';
			table_str += '<td align=center>'+which_lang[_protocol]+'<br>';
			table_str += "<select "+disabledStr+" width=80 id=protocol_select" + i + " name=protocol_select" + i +" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex," + i + ");\">";
			table_str += '<option value=6 selected>'+which_lang[_TCP]+'</option>';
			table_str += '<option value=17>'+which_lang[_UDP]+'</option>';
			table_str += '<option value=256>'+which_lang[_both]+'</option>';
			table_str += '<option value=-1>'+which_lang[_other]+'</option>';
			table_str += "</select></td>";
			table_str += '<td align=center>'+which_lang[_sched]+'<br>';
			table_str += "<select "+disabledStr+" width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>";
			table_str += '<option value=\"255\" '+ ((obj_Schdule=="255") ? 'selected' : '' )+'>'+which_lang[_always]+'</option>';
			table_str += '<option value=\"254\" '+ ((obj_Schdule=="254") ? 'selected' : '' )+'>'+which_lang[_never]+'</option>';
			table_str += add_option('Schedule', obj_Schdule);
			table_str += "</select>";
			table_str += "</td>";
			table_str += "</tr>";

			table_str += "<tr>";
			table_str += '<td valign=bottom>'+which_lang[_ipaddr]+'<br><input '+disabledStr+' type=text class=flatL  id=ip'+i+' name=ip'+i+' size=16 maxlength=15 value="'+obj_intnlip+'"></td>';
			table_str += "<td align=left valign=bottom>";
			table_str += "<input "+disabledStr+" id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">";
			table_str += "<select "+disabledStr+" style='width:110' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">";
			table_str += '<option value=-1>'+which_lang[bd_CName]+'</option>';
			table_str += set_host_list_1( 'ip' );
			table_str += "</select></td>";
			table_str += '<td align=center valign=bottom>'+which_lang[av_PriP]+'<br><input '+disabledStr+' type=text class=flatL id=private_portS' + i + ' name=private_portS' + i +' size=5 maxlength=5 value="'+obj_PriPort+'"></td>';
			table_str += "<td align=center><br>";
			table_str += "<input "+disabledStr+" type=text id=protocol" + i + " name=protocol" + i + " size=5 maxlength=3 value=\""+obj_ProtcolNum + "\">";
			table_str += "</td>";
			table_str += '<td align=center>'+which_lang[INBOUND_FILTER]+'<br>';
			table_str += "<select "+disabledStr+" width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>";
			table_str += '<option value=\"255\" '+ ((obj_Policy=="255") ? 'selected' : '' )+'>'+which_lang[_allowall]+'</option>';
			table_str += '<option value=\"254\" '+ ((obj_Policy=="254") ? 'selected' : '' )+'>'+which_lang[_denyall]+'</option>';
			table_str += add_option('Inbound', obj_Policy);
			table_str += "</select>";
			table_str += "</td>";
			table_str += "</tr>";
			
			//do_select('protocol_select'+i, 'idx', obj_Protcol);
			//protocol_change(i);
			//detect_protocol_change_port(obj_Protcol,i);
		}
		
		table_str += '</tbody></table></form>';
		
		get_by_id("contant_table").innerHTML = table_str;
		
		for(var i=0 ; i<rule_max_num ; i++){
			do_select('protocol_select'+i, 'idx', array_Protcol[i]);
			protocol_change(i);
			detect_protocol_change_port(array_Protcol[i],i);
		}

		set_form_default_values("form3");
	}
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words('TA2')</script>: 
            <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
        <td align="right" nowrap><script>show_words('TA3')</script>: 
            <script>document.write(hw_version);</script> &nbsp;</td>
        <td align="right" nowrap><script>show_words('sd_FWV')</script>: 
            <script>document.write(version);</script></td>
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
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
						    <LI><div id=sidenavoff><script>show_words(_virtserv)</script></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </td>
        <form id="form2" method="post" name="form2">
        <input id="html_response_page" name="html_response_page" type="hidden" value="back.asp"> 
        <input id="html_response_message" name="html_response_message" type="hidden" value=""> 
        <script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script> 
        <input id="html_response_return_page" name="html_response_return_page" type="hidden" value="adv_virtual.asp"> 
        <input id="reboot_type" name="reboot_type" type="hidden" value="filter"> 
            <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id=box_header>
                              <h1>
              <script>show_words(_vs_title)</script>
            </h1>
            <script>show_words(av_intro_vs)</script>
            <br>
            <br>
            <input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
			<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form3', 'adv_virtual.asp');">
			<script>get_by_id("button").value = get_words(_savesettings);</script>
			<script>get_by_id("button2").value = get_words(_dontsavesettings);</script>

                  </div>
			</form>
                  <div class=box id="contant_table">
                    <!--<h2><script>document.write(rule_max_num)</script> &ndash;&ndash; <script>show_words(vs_vslist)</script></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="36">&nbsp;</td>
                          <td width="200">&nbsp;</td>
                          <td width="130" align=middle><div align="left"><strong><script>show_words(_vs_port)</script></strong></div></td>
                          <td width="130" align=middle><div align="left"><strong><script>show_words(_vs_traffictype)</script></strong></div></td>
                          <td width="120" align=middle><div align="center">&nbsp;</td>
                        </tr>
						<div id="contant_table">
						</div>-->
                        <!--<script>
							var Application_list = set_application_option(Application_list, default_virtual);
							//var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
							var Inbound_list = '';
							for(var i=0 ; i<rule_max_num ; i++){
								var obj_enable = "";
								var obj_name = "";
								var obj_intnlip = "";
								var obj_PubPort = "";
								var obj_PriPort = "";
								var obj_Protcol = "";
								var obj_Schdule = "";
								var obj_Policy  = "";
								var obj_ProtcolNum = "";

								if(array_enable!=null)
									obj_enable = array_enable[i];
								if(array_name!=null)
									obj_name = array_name[i];
								if(array_intnlip!=null)
									obj_intnlip = array_intnlip[i];
								if(array_PubPort!=null)
									obj_PubPort = array_PubPort[i];
								if(array_PriPort!=null)
									obj_PriPort = array_PriPort[i];
								if(array_Protcol!=null)
									obj_Protcol = array_Protcol[i];
								if(obj_ProtcolNum!=null)
									obj_ProtcolNum = array_Protcol_num[i];
								if(array_Schdule!=null)
									obj_Schdule = array_Schdule[i];
								if(array_Policy!=null)
									obj_Policy = array_Policy[i];
							
								document.write("<tr>");
								if (obj_enable == '1')
									document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>");
								else
									document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>");
								document.write('<td valign=bottom>'+which_lang[_name]+'<br><input type=text class=flatL id=\"name' + i + '\" name=\"name'+ i +'\" size=16 maxlength=31 value="'+ obj_name +'"></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_virtual(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=application" + i +" name=application" + i +" modified=\"ignore\">");
								document.write('<option>'+which_lang[gw_SelVS]+'</option>');
								document.write(Application_list);
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+which_lang[av_PubP]+'<br><input type=text class=flatL id=public_portS'+ i + ' name=public_portS' + i +' size=5 maxlength=5 value="'+obj_PubPort+'"></td>');
								document.write('<td align=center>'+which_lang[_protocol]+'<br>');
								document.write("<select width=80 id=protocol_select" + i + " name=protocol_select" + i +" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex," + i + ");\">");
								document.write('<option value=6 selected>'+which_lang[_TCP]+'</option>');
								document.write('<option value=17>'+which_lang[_UDP]+'</option>');
								document.write('<option value=256>'+which_lang[_both]+'</option>');
								document.write('<option value=-1>'+which_lang[_other]+'</option>');
								document.write("</select></td>");
								document.write('<td align=center>'+which_lang[_sched]+'<br>');
								document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
								document.write('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+which_lang[_always]+'</option>');
								document.write('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+which_lang[_never]+'</option>');
								document.write(add_option('Schedule', obj_Schdule));
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");

								document.write("<tr>");
								document.write('<td valign=bottom>'+which_lang[_ipaddr]+'<br><input type=text class=flatL  id=ip'+i+' name=ip'+i+' size=16 maxlength=15 value="'+obj_intnlip+'"></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">");
								document.write('<option value=-1>'+which_lang[bd_CName]+'</option>');
								set_host_list( 'ip' );
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+which_lang[av_PriP]+'<br><input type=text class=flatL id=private_portS' + i + ' name=private_portS' + i +' size=5 maxlength=5 value="'+obj_PriPort+'"></td>');
								document.write("<td align=center><br>");
								document.write("<input type=text id=protocol" + i + " name=protocol" + i + " size=5 maxlength=3 value=\""+obj_ProtcolNum + "\">");
								document.write("</td>");
								document.write('<td align=center>'+which_lang[INBOUND_FILTER]+'<br>');
								document.write("<select width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>");
								document.write('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+which_lang[_allowall]+'</option>');
								document.write('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+which_lang[_denyall]+'</option>');
								document.write(add_option('Inbound', obj_Policy));
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								do_select('protocol_select'+i, 'idx', obj_Protcol);
								protocol_change(i);
								detect_protocol_change_port(obj_Protcol,i);
								//do_select('schedule'+i, 'val', obj_Schdule);
								//do_select('inbound_filter'+i, 'val', obj_Policy);
							}
                        </script> -->
                        <!--</tbody>
                    </table>
					</form>-->
                                </div>
                </div>
        </td>
		<form id="form1" name="form1" method="post" action="get_set.ccp">
				<input type="hidden" id="action" name="action" value="setpar">
				<input type="hidden" name="ccpSubEvent" value="CCP_SUB_VIRTUALSERVER">
				<input type="hidden" name="nextPage" value="adv_virtual.asp">	
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_virtual.asp">
				<input type="hidden" name="ccp_act" value="set">
				<input type="hidden" name="num_inst" value="1">
				<input type="hidden" name="oid_1" value="IGD_WANDevice_i_VirServRule_i_">
				<input type="hidden" name="inst_1" value="11100">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
				<script>
				for(var i=1; i<=rule_max_num; i++)
				{
					document.write('<input type="hidden" id="vsRule_Enable_'+i+'" name="vsRule_Enable_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_VirtualServerName_'+i+'" name="vsRule_VirtualServerName_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_InternalIPAddr_'+i+'" name="vsRule_InternalIPAddr_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_PublicPort_'+i+'" name="vsRule_PublicPort_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_PrivatePort_'+i+'" name="vsRule_PrivatePort_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_Protocol_'+i+'" name="vsRule_Protocol_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_ProtoNum_'+i+'" name="vsRule_ProtoNum_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_ScheduleIndex_'+i+'" name="vsRule_ScheduleIndex_1.1.'+i+'.0.0" value="">');
					document.write('<input type="hidden" id="vsRule_Policy_'+i+'" name="vsRule_Policy_1.1.'+i+'.0.0" value="">');
				}
				</script>

        </form>
        <td align="left" id="sidehelp_container" valign="top" width="150"> 
            <table bgcolor="#ffffff" border="0" bordercolor="#ffffff" bordercolordark="#ffffff" bordercolorlight="#ffffff" cellpadding="2" cellspacing="0">
                <tbody>
                <tr>
                    <td id="help_text"><b><strong> 
                        <script>show_words(_hints)</script> 
                        </strong>&hellip;</b> 

                        <p>
                        <script>show_words(hhav_name)</script> </p>

              <p>
                <script>show_words(hhav_ip)</script>
              </p>

              <p>
                <script>show_words(hhav_sch)</script>
              </p>

              <p>
                <script>show_words(hhav_filt)</script>
              </p>
						<p><a href="support_adv.asp#Virtual_Server" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
	//paint_table();
	//set_form_default_values("form3");
</script> 
</html> 
