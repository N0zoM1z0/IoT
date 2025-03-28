<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
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
				"oid_1=IGD_WANDevice_i_PortFwd_i_&inst_1=11000&"+
				"oid_2=IGD_ScheduleRule_i_&inst_2=10000&"+
				"oid_3=IGD_WANDevice_i_InboundFilter_i_&inst_3=11000&"+
				"oid_4=IGD_Status_LANStatus_Host_i_&inst_4=11110&"+
				"oid_5=IGD_&inst_5=10000&"+
				"oid_6=IGD_WANDevice_i_VirServRule_i_&inst_6=11000&"+
				"oid_7=IGD_WANDevice_i_PortTriggerRule_i_&inst_7=11000&"+
				"oid_8=IGD_AdministratorSettings_&inst_8=10000&"+
				"oid_9=IGD_Storage_&inst_9=11000"
	};
	get_config_obj(param);
	var dev_mode = config_val("igd_DeviceMode_");
	
	var array_enable 		= config_str_multi("pfRule_Enable_");
	var array_name 			= config_str_multi("pfRule_ApplicationName_");
	var array_intnlip 		= config_str_multi("pfRule_InternalIPAddr_");
	var array_TCPPort 		= config_str_multi("pfRule_TCPOpenPorts_");
	var array_UDPPort 		= config_str_multi("pfRule_UDPOpenPorts_");
	var array_Schdule 		= config_str_multi("pfRule_ScheduleIndex_");
	var array_Policy 		= config_str_multi("pfRule_Policy_");

	var array_vs_enable		= config_str_multi("vsRule_Enable_");
	var array_vs_proto	 	= config_str_multi("vsRule_Protocol_");
	var array_vs_ports 		= config_str_multi("vsRule_PublicPort_");
	var array_pt_enable		= config_str_multi("ptRule_Enable_");
	var array_pt_proto		= config_str_multi("ptRule_FirewallProtocol_");
	var array_pt_ports		= config_str_multi("ptRule_FirewallPorts_");

	var array_sch_inst 		= config_inst_multi("IGD_ScheduleRule_i_");
	var array_schedule_name	= config_str_multi("schRule_RuleName_");
	var wa_http_en 			= config_val("igdStorage_Enable_");
	var wa_https_en 		= config_val("igdStorage_Https_Remote_Access_Enable_");
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
	var DHCPList_word = "";
	var is_chk_public_port = 0;
	var is_chk_private_port = 0;
	var inbound_used = 1;
		
	function onPageLoad(){
		var login_who= login_Info;
		if(login_who!= "w" || dev_mode == "1"){
			DisableEnableForm(form1,true);	
		} 
		
		setTimeout("paint_table()", 5);
	}

	function set_port_forwarding(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_pf;
			
			if (i > 9){
				temp_pf = (get_by_id("port_forward_both_" + i).value).split("/");
			}else{
				temp_pf = (get_by_id("port_forward_both_0" + i).value).split("/");				
			}
			
			if (temp_pf.length > 1){
				set_checked(temp_pf[0], get_by_id("enable" + i));
				get_by_id("name" + i).value = temp_pf[1];
				get_by_id("ip" + i).value = temp_pf[2];
				get_by_id("tcp_ports" + i).value = temp_pf[3];
				get_by_id("udp_ports" + i).value = temp_pf[4];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
				if((temp_pf[5] == "Always") || (temp_pf[5] == "Never") || (temp_pf[5] == "")){
					set_selectIndex(temp_pf[5], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_pf[5]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}			  	
				set_selectIndex(temp_pf[6], get_by_id("inbound_filter" + i));
			}
		}
	}

	function check_vistual_port(potocol,chk_port, obj_word){
		return true;
	}
	
	function check_app_port(potocol,chk_port, obj_word){
	
		return true;
	}
	
	
	function check_portforward_port(proto_type, check_index, check_ip, chk_port, obj_word){
	
		return true;
						
	}	
	function do_submit()
	{
		var param = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_PORTFORWARD&nextPage=adv_portforward.asp'
		};
		
		for (var i=1; i<=rule_max_num; i++) {
			if (get_by_id('enable'+(i-1)).checked == false && get_by_id('name'+(i-1)).value == '') {
				param.arg += '&pfRule_Enable_1.1.'+i+'.0.0=0';
				param.arg += '&pfRule_ApplicationName_1.1.'+i+'.0.0=';
				param.arg += '&pfRule_InternalIPAddr_1.1.'+i+'.0.0=0.0.0.0';
				param.arg += '&pfRule_TCPOpenPorts_1.1.'+i+'.0.0=0';
				param.arg += '&pfRule_UDPOpenPorts_1.1.'+i+'.0.0=0';
				param.arg += '&pfRule_ScheduleIndex_1.1.'+i+'.0.0=255';
				param.arg += '&pfRule_Policy_1.1.'+i+'.0.0=255';			
			} else {
				param.arg += '&pfRule_Enable_1.1.'+i+'.0.0=' + (get_by_id('enable'+(i-1)).checked? '1' : '0');
				param.arg += '&pfRule_ApplicationName_1.1.'+i+'.0.0=' + get_by_id('name'+(i-1)).value;
				param.arg += '&pfRule_InternalIPAddr_1.1.'+i+'.0.0=' + get_by_id('ip'+(i-1)).value;
				param.arg += '&pfRule_TCPOpenPorts_1.1.'+i+'.0.0=' + get_by_id('tcp_ports'+(i-1)).value;
				param.arg += '&pfRule_UDPOpenPorts_1.1.'+i+'.0.0=' + get_by_id('udp_ports'+(i-1)).value;
				param.arg += '&pfRule_ScheduleIndex_1.1.'+i+'.0.0=' + get_by_id('schedule'+(i-1)).value;
				param.arg += '&pfRule_Policy_1.1.'+i+'.0.0=' + get_by_id('inbound_filter'+(i-1)).value;
			}
		}
		//alert(param.arg);
		//return;
		get_config_obj(param);
		//location.replace('adv_portforward.asp');
	}

	
	function send_request(){
		var tcp_timeline = null;
		var udp_timeline = null;

		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form3") && !confirm(get_words(_ask_nochange))) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = get_by_id("name" + i).value;			
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == get_by_id("name" + j).value){
						//alert("端口??名已在表中");
						//alert("Name " + temp_port_name + " is already used.");
						alert(get_words(TEXT060));
						return false;
					}
				}
			}
		}
		
		// add virtual server ports into timeline
		try {
			for (var i=0; i<array_vs_enable.length; i++) {
				if (array_vs_enable[i] == '0')
					continue;
				var vs_ports = array_vs_ports[i].split(',');
				for (var j=0; j<vs_ports.length; j++) {
					var range = vs_ports[j].split('-');
					if (array_vs_proto[i] == '0') {
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
					} else if (array_vs_proto[i] == '1') {
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

		var remote_port=config_val("adminCfg_RemoteAdminHttpPort_");
		var remote_port_enable=config_val("adminCfg_RemoteManagementEnable_");
		var remote_https_en=config_val("adminCfg_RemoteAdminHttpsEnable_");
		var remote_https_port=config_val("adminCfg_RemoteAdminHttpsPort_");

		//add Remote management port to time line
		try
		{
			if(remote_port_enable == '1')
			{
				var tcp_ports = remote_port;
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
			}
			if(remote_https_en == '1')
			{
				var tcp_ports = remote_https_port;
				tcp_timeline = add_into_timeline(tcp_timeline, tcp_ports, null);
			}
		}
		catch (e)
		{
			alert('error occur in adding port trigger ports into timeline');
					
		}

		//add web access ports into timeline
		if(wa_http_en == 1)
		{
			tcp_timeline = add_into_timeline(tcp_timeline, wa_http_port, null);
			tcp_timeline = add_into_timeline(tcp_timeline, wa_https_port, null);
		}
		
		for (var i = 0; i < rule_max_num; i++){		
			var ip = get_by_id("ip" + i).value;
			
			var lan_ip = "";
			var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('ES_IP_ADDR'));
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
			
			var temp_pf;
			
			if (get_by_id("name" + i).value != ""){
				check_name = get_by_id("name" + i).value;
				//if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
				if(Find_word(check_name,'"') || Find_word(check_name,"/")){
					//alert("端口??名 "+ i +"?效。非法字符 ',/,''");
					alert(addstr(get_words(TEXT007), i));
					return false;
				}
				
				if (!check_address(temp_ip_obj)){
					return false;
				}
				        		        
				if (get_by_id("tcp_ports" + i).value == "0" && get_by_id("udp_ports" + i).value == "0"){
					//alert("??入一?TCP端口?或一?UDP端口?。");
					alert(get_words(TEXT061));
					return false;
				}
				
				//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(dev_info.lanIP.split('.'), temp_ip_obj.addr, get_words(help256))){
					return false;
				}
		      		
				//check port forwarding tcp port and remote management port conflict problem
				if (get_by_id('enable'+i).checked) {
				
				if(( get_by_id('tcp_ports'+i).value == "" || get_by_id('tcp_ports'+i).value == 0 ) &&
					( get_by_id('udp_ports'+i).value == ""|| get_by_id('udp_ports'+i).value == 0))
				{
					alert(get_words(TEXT061));
					return false;
				}
				else
				{
					if ( get_by_id('tcp_ports'+i).value != "" && get_by_id('tcp_ports'+i).value != 0){				
					var tcp_ports = get_by_id('tcp_ports'+i).value.split(',');					
					var chk_tcp_ports="";
					for (var j=0; j<tcp_ports.length; j++) {
						var range = tcp_ports[j].split('-');
						if(range[0] == "" || !check_port(range[0]))
						{
							alert(get_words(ac_alert_invalid_port));
							return false;
						}
						if(range.length>1 && !check_port(range[1],10))
						{
							alert(get_words(ac_alert_invalid_port));
							return false;
						}
						tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
						chk_tcp_ports += parseInt(range[0],10);
						if(range.length>1)
							chk_tcp_ports += "-" + parseInt(range[1],10);
						if(tcp_ports.length>1 && j<tcp_ports.length-1)
							chk_tcp_ports += ",";
					}
					get_by_id('tcp_ports'+i).value = chk_tcp_ports;
					}
					if (  get_by_id('udp_ports'+i).value != "" && get_by_id('udp_ports'+i).value != 0) {
					var udp_ports = get_by_id('udp_ports'+i).value.split(',');
					var chk_tcp_ports="";
					for (var j=0; j<udp_ports.length; j++) {						
						var range = udp_ports[j].split('-');
						if(range[0] == "" || !check_port(range[0]))
						{
							alert(get_words(ac_alert_invalid_port));							
							return false;
						}
						if(range.length>1 && !check_port(range[1],10))
						{
							alert(get_words(ac_alert_invalid_port));
							return false;
						}
						udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
						chk_tcp_ports += parseInt(range[0],10);
						if(range.length>1)
							chk_tcp_ports += "-" + parseInt(range[1],10);						
						if(udp_ports.length>1 && j<udp_ports.length-1)
							chk_tcp_ports += ","
					}
					get_by_id('udp_ports'+i).value = chk_tcp_ports;
					}
				}
				}
				
				if (check_timeline(tcp_timeline) == false) {
					//alert("TCP 通訊埠[" + get_by_id("tcp_ports" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
					alert(addstr(get_words(ag_conflict5), 'TCP', get_by_id("tcp_ports" + i).value));
					return false;
				}
				
				if (check_timeline(udp_timeline) == false) {
					//alert("UDP 通訊埠[" + get_by_id("tcp_ports" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
					alert(addstr(get_words(ag_conflict5), 'UDP', get_by_id("udp_ports" + i).value));
					return false;
				}
				
				//if port value have blank, replace to ""
				get_by_id("tcp_ports" + i).value = get_by_id("tcp_ports" + i).value.replace(/ /,"");
				get_by_id("udp_ports" + i).value = get_by_id("udp_ports" + i).value.replace(/ /,"");
			

				var is_enable = get_checked_value(get_by_id("enable" + i));
				if (count > 9){
					temp_pf = get_by_id("port_forward_both_" + count);
				}else{
					temp_pf = get_by_id("port_forward_both_0" + count);
				}
				
		        count++;
			} else {
				if (get_by_id('enable'+i).checked == true) {
					alert(get_words(pf_name_empty));
					return false;
				}
			}
			
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			do_submit();
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
					
				//document.write("<option value=" + inst.charAt(1) + " " + str_sel + ">" + nam[i] + "</option>");
				str += ("<option value=" + inst.charAt(1) + " " + str_sel + ">" + nam[i] + "</option>");

			} else if (id == 'Inbound') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(2))
					str_sel = 'selected';
					
				//document.write("<option value=" + inst.charAt(2) + " " + str_sel + ">" + nam[i] + "</option>");
				str +=("<option value=" + inst.charAt(2) + " " + str_sel + ">" + nam[i] + "</option>");
			}
		}

		return str;
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
			{
				obj.options[value].selected = true;
			}
		}
		else if (type == 'val')
		{
			for (i=0; i<obj.options.length; i++)
			{
				if (obj.options[i].value == value)
				{
					obj.options[i].selected = true;
				}
			}
		}
	}
	
	function paint_table()
	{
		var table_str = '<form id="form3"><h2>'+rule_max_num+'&ndash;&ndash;'+get_words(ag_title_4)+'</h2>';
            table_str+= '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1><tbody>';
            table_str+= '<tr>';
            table_str+= '<td align=middle width=20>&nbsp;</td>';
            table_str+= '<td width="36">&nbsp;</td>';
            table_str+= '<td width="200">&nbsp;</td>';
            table_str+= '<td width="120" align=middle><div align="center">'+get_words(sps_ports)+'</div></td>';
            table_str+= '<td width="120">&nbsp;</td>';
            table_str+= '</tr>';
		
		var Application_list = set_application_option(Application_list, default_rule);
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
			//var obj_Protcol = "";
			var obj_Schdule = "";
			var obj_Policy  = "";
			var obj_TCPPort = '';
			var obj_UDPPort = '';

			if(array_enable!=null)
				obj_enable = array_enable[i];
			if(array_name!=null)
			{
				obj_name = array_name[i];
				obj_name = obj_name.replace("+"," ");
			}
			if(array_intnlip!=null)
				obj_intnlip = array_intnlip[i];
			if(array_TCPPort!=null)
				obj_TCPPort = array_TCPPort[i];
			if(array_UDPPort!=null)
				obj_UDPPort = array_UDPPort[i];
			//if(array_Protcol!=null)
				//obj_Protcol = array_Protcol[i];
			if(array_Schdule!=null)
				obj_Schdule = array_Schdule[i];
			if(array_Policy!=null)
				obj_Policy = array_Policy[i];							
		
			table_str+="<tr>";
			if (obj_enable == '1')
				table_str+="<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>";
			else
				table_str+="<td align=center valign=middle rowspan=2><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>";
			table_str+='<td valign=bottom>'+get_words(_name)+'<br><input '+disabledStr+' type=text class=flatL id=\"name' + i + '\" name=\"name' + i +'\" size=16 maxlength=31 value="'+ obj_name +'"></td>';
			table_str+="<td align=left valign=bottom>";
			table_str+="<input "+disabledStr+" id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_portforward(" + i + ")' style=\"width: 23;\">";
			table_str+="<select "+disabledStr+" style='width:140' id=application" + i +" name=application" + i +" modified=\"ignore\">";
			table_str+='<option>'+get_words(gw_SelVS)+'</option>';
			table_str+=Application_list;
			table_str+="</select></td>";
			table_str+='<td align=center valign=bottom>'+get_words(_TCP)+'<br>';
			table_str+="<input "+disabledStr+" type=text class=flatL id=tcp_ports" + i + " name=tcp_ports" + i +" size=16 value=\""+ obj_TCPPort +"\"></td>";
			table_str+='<td align=center>'+get_words(_sched)+'<br>';
			table_str+="<select "+disabledStr+" width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>";
			table_str+='<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+get_words(_always)+'</option>';
			table_str+='<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+get_words(_never)+'</option>';
			//table_str+=set_schedule_option());
			table_str+=add_option('Schedule', obj_Schdule);
			table_str+="</select>";
			table_str+="</td>";
			table_str+="</tr>";
			
			table_str+="<tr>";
			table_str+='<td valign=bottom>'+get_words(_ipaddr)+'<br><input '+disabledStr+' type=text class=flatL  id=ip' + i + ' name=ip' + i +' size=16 maxlength=15 value="'+ obj_intnlip +'"></td>';
			table_str+="<td align=left valign=bottom>";
			table_str+="<input "+disabledStr+" id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">";
			table_str+="<select "+disabledStr+" style='width:140' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">";
			table_str+='<option value=-1>'+get_words(bd_CName)+'</option>';
			table_str+= set_host_list_1( 'ip' );
			//table_str+=set_mac_list("ip");			
			table_str+="</select></td>";
			table_str+='<td align=center valign=bottom>'+get_words(_UDP)+'<br>';
			table_str+="<input "+disabledStr+" type=text class=flatL id=udp_ports" + i + " name=udp_ports" + i +" size=16 value=\""+ obj_UDPPort +"\"></td>";
			table_str+='<td align=center>'+get_words(INBOUND_FILTER)+'<br>';
			table_str+="<select "+disabledStr+" width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>";
			table_str+='<option value=\"255\" '+ ((obj_Policy==255) ? 'selected' : '' )+'>'+get_words(_allowall)+'</option>';
			table_str+='<option value=\"254\" '+ ((obj_Policy==254) ? 'selected' : '' )+'>'+get_words(_denyall)+'</option>';
			//table_str+=Inbound_list);
			table_str+=add_option('Inbound', obj_Policy);
			table_str+="</select>";
			table_str+="</td>";
			table_str+="</tr>";
			
			//do_select('schedule'+i, 'val', obj_Schdule);
			//do_select('inbound_filter'+i, 'val', obj_Policy);
		}
		
		table_str += '</tbody></table></form>';

		get_by_id("contant_table").innerHTML = table_str;
		
		if(login_Info!= "w" || dev_mode == "1"){
			DisableEnableForm(form3,true);	
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
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
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
                          <UL>
						  <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_pf)</script></div></LI>
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
                </table></td>
							
				
                 <form id="form1" name="form1" method="post" action="apply.cgi">
		                <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
										<input type="hidden" id="html_response_message" name="html_response_message" value="">
										<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
										<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_portforward.asp">
										<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
		                
                
                <input type="hidden" id="dhcp_list" name="dhcp_list" value="">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
				  
                  
          <div id=box_header> 
            <h1> 
              <script>show_words(_pf)</script>
            </h1>
            <script>show_words(ag_intro)</script>
            <br>
            <br>
           	<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
			<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form3', 'adv_portforward.asp');">
			<script>get_by_id("button").value = get_words(_savesettings);</script>
			<script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
		  </div>
		  </form>
          <div class=box id="contant_table"> 
            <!--<h2>
              <script>document.write(rule_max_num)</script>
              &ndash;&ndash;
              <script>show_words(ag_title_4)</script>
            </h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="36">&nbsp;</td>
                          <td width="200">&nbsp;</td>
                          <td width="120" align=middle><div align="center"><script>show_words(sps_ports)</script></div></td>
                          <td width="120">&nbsp;</td>
                        </tr>
                        <script>
							var Application_list = set_application_option(Application_list, default_rule);
							//var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
							var Inbound_list = '';
							for(var i=0 ; i<rule_max_num ; i++){
								var obj_enable = "";
								var obj_name = "";
								var obj_intnlip = "";
								var obj_PubPort = "";
								var obj_PriPort = "";
								//var obj_Protcol = "";
								var obj_Schdule = "";
								var obj_Policy  = "";
								var obj_TCPPort = '';
								var obj_UDPPort = '';

								if(array_enable!=null)
									obj_enable = array_enable[i];
								if(array_name!=null)
								{
									obj_name = array_name[i];
									obj_name = obj_name.replace("+"," ");
								}
								if(array_intnlip!=null)
									obj_intnlip = array_intnlip[i];
								if(array_TCPPort!=null)
									obj_TCPPort = array_TCPPort[i];
								if(array_UDPPort!=null)
									obj_UDPPort = array_UDPPort[i];
								//if(array_Protcol!=null)
									//obj_Protcol = array_Protcol[i];
								if(array_Schdule!=null)
									obj_Schdule = array_Schdule[i];
								if(array_Policy!=null)
									obj_Policy = array_Policy[i];							
							
								document.write("<tr>");
								if (obj_enable == '1')
									document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>");
								else
									document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>");
								document.write('<td valign=bottom>'+get_words(_name)+'<br><input type=text class=flatL id=\"name' + i + '\" name=\"name' + i +'\" size=16 maxlength=31 value="'+ obj_name +'"></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_portforward(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:140' id=application" + i +" name=application" + i +" modified=\"ignore\">");
								document.write('<option>'+get_words(gw_SelVS)+'</option>');
								document.write(Application_list);
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+get_words(_TCP)+'<br>');
								document.write("<input type=text class=flatL id=tcp_ports" + i + " name=tcp_ports" + i +" size=16 value=\""+ obj_TCPPort +"\"></td>");
								document.write('<td align=center>'+get_words(_sched)+'<br>');
								document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
								document.write('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+get_words(_always)+'</option>');
								document.write('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+get_words(_never)+'</option>');
								//document.write(set_schedule_option());
								document.write(add_option('Schedule', obj_Schdule));
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								document.write("<tr>");
								document.write('<td valign=bottom>'+get_words(_ipaddr)+'<br><input type=text class=flatL  id=ip' + i + ' name=ip' + i +' size=16 maxlength=15 value="'+ obj_intnlip +'"></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:140' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">");
								document.write('<option value=-1>'+get_words(bd_CName)+'</option>');
								set_host_list( 'ip' );
								//document.write(set_mac_list("ip"));			
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+get_words(_UDP)+'<br>');
								document.write("<input type=text class=flatL id=udp_ports" + i + " name=udp_ports" + i +" size=16 value=\""+ obj_UDPPort +"\"></td>");
								document.write('<td align=center>'+get_words(INBOUND_FILTER)+'<br>');
								document.write("<select width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>");
								document.write('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+get_words(_allowall)+'</option>');
								document.write('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+get_words(_denyall)+'</option>');
								//document.write(Inbound_list);
								document.write(add_option('Inbound', obj_Policy));
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								//do_select('schedule'+i, 'val', obj_Schdule);
								//do_select('inbound_filter'+i, 'val', obj_Policy);
							}
						</script>
                      </tbody>
                    </table>-->
                  </div>
                </div>
             </td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>

            <td id=help_text><b><strong>
              <script>show_words(_hints)</script>
              </strong>&hellip;</b> <p>
                <script>show_words(hhag_10)</script>
              </p>

              <p>
                <script>show_words(hhag_20)</script>
              </p>

              <p>
                <script>show_words(hhag_30)</script>
              </p>

              <p>
                <script>show_words(hhag_40)</script>
              </p>

              <p>
                <script>show_words(help58)</script>
                <script>show_words(help59)</script>
                <script>show_words(help60)</script>
              </p>
						<p><a href="support_adv.asp#Gaming" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div id="copyright"><script>show_words(_copyright)</script></div>
<br>
</body>
<script>
	onPageLoad();
	//paint_table();
	//set_form_default_values("form3");

</script>
</html>
