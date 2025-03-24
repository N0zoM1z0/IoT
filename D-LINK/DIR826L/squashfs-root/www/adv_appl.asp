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
	arg: 	"ccp_act=get&num_inst=7&"+
			"oid_1=IGD_WANDevice_i_PortTriggerRule_i_&inst_1=11000&"+
			"oid_2=IGD_ScheduleRule_i_&inst_2=10000&" +
			"oid_3=IGD_&inst_3=10000&"+
			"oid_4=IGD_WANDevice_i_PortFwd_i_&inst_4=11000&"+
			"oid_5=IGD_WANDevice_i_VirServRule_i_&inst_5=11000&"+
			"oid_6=IGD_AdministratorSettings_&inst_6=10000&"+
			"oid_7=IGD_Storage_&inst_7=11000"
};
get_config_obj(param);
var dev_mode = config_val("igd_DeviceMode_");

var array_enable 		= config_str_multi("ptRule_Enable_");
var array_name 			= config_str_multi("ptRule_ApplicationName_");
var array_tgport 		= config_str_multi("ptRule_TriggerPorts_");
var array_fwport 		= config_str_multi("ptRule_FirewallPorts_");
var array_tgprotocol 	= config_str_multi("ptRule_TriggerProtocol_");
var array_fwprotocol 	= config_str_multi("ptRule_FirewallProtocol_");
var array_Schdule 		= config_str_multi("ptRule_ScheduleIndex_");

var array_vs_enable		= config_str_multi("vsRule_Enable_");
var array_vs_proto	 	= config_str_multi("vsRule_Protocol_");
var array_vs_ports 		= config_str_multi("vsRule_PublicPort_");
var array_pf_enable		= config_str_multi("pfRule_Enable_");
var array_pf_ports_udp	= config_str_multi("pfRule_UDPOpenPorts_");
var array_pf_ports_tcp	= config_str_multi("pfRule_TCPOpenPorts_");

var array_sch_inst 		= config_inst_multi("IGD_ScheduleRule_i_");
var array_schedule_name	= config_str_multi("schRule_RuleName_");

var wa_http_en 			= config_val("igdStorage_Http_Remote_Access_Enable_");
var wa_https_en 		= config_val("igdStorage_Https_Remote_Access_Enable_");
var wa_http_port 		= config_val("igdStorage_Http_Remote_Access_Port_");
var wa_https_port		= config_val("igdStorage_Https_Remote_Access_Port_");

var schedule_cnt = 0;

if(array_schedule_name != null)
	schedule_cnt = array_schedule_name.length;

	var submit_button_flag = 0;
	var rule_max_num = 24;
	var resert_rule = rule_max_num;
	function onPageLoad(){
		var login_who= login_Info;
		if(login_who!= "w" || dev_mode == "1"){
			DisableEnableForm(form1,true);	
		} 
		
		setTimeout("paint_table()", 2);
	}
	
	
	function set_application(){
	/*
		for (var i = 0; i < rule_max_num; i++){
			var temp_appl;
			
			if (i > 9){
				temp_appl = (get_by_id("application_" + i).value).split("/");
			}else{
				temp_appl = (get_by_id("application_0" + i).value).split("/");				
			}
			
			if (temp_appl.length > 1){
				
				if (temp_appl[0] == "1"){
					get_by_id("enable" + i).checked = true;
				}
				
				get_by_id("name" + i).value = temp_appl[1];								
				set_protocol(temp_appl[2], get_by_id("trigger" + i));	
				get_by_id("trigger_port" + i).value = temp_appl[3];
				set_protocol(temp_appl[4], get_by_id("public" + i));
				get_by_id("public_port" + i).value = temp_appl[5];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
 				if((temp_appl[6] == "Always") || (temp_appl[6] == "Never") || (temp_appl[6] == "")){
					set_selectIndex(temp_appl[6], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_appl[6]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}
			}
		}
		//get_by_id("show_resert").innerHTML = "<font color=\"red\">"+ resert_rule +"</font>";
	*/
	}
	
	function do_submit()
	{
		var param = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_PORTTRIGGER&nextPage=adv_appl.asp'
		};
		
		for (var i=1; i<=rule_max_num; i++) {
			if (get_by_id('enable'+(i-1)).checked == false && get_by_id('name'+(i-1)).value == '') {
				param.arg += '&ptRule_Enable_1.1.'+i+'.0.0=0';
				param.arg += '&ptRule_ApplicationName_1.1.'+i+'.0.0=';
				param.arg += '&ptRule_TriggerPorts_1.1.'+i+'.0.0=0';
				param.arg += '&ptRule_FirewallPorts_1.1.'+i+'.0.0=0';
				param.arg += '&ptRule_TriggerProtocol_1.1.'+i+'.0.0=0';
				param.arg += '&ptRule_FirewallProtocol_1.1.'+i+'.0.0=0';
				param.arg += '&ptRule_ScheduleIndex_1.1.'+i+'.0.0=255';
			} else {
				param.arg += '&ptRule_Enable_1.1.'+i+'.0.0=' + (get_by_id('enable'+(i-1)).checked? '1' : '0');
				param.arg += '&ptRule_ApplicationName_1.1.'+i+'.0.0=' + get_by_id('name'+(i-1)).value;
				param.arg += '&ptRule_TriggerPorts_1.1.'+i+'.0.0=' + get_by_id('trigger_port'+(i-1)).value;
				param.arg += '&ptRule_FirewallPorts_1.1.'+i+'.0.0=' + get_by_id('public_port'+(i-1)).value;
				param.arg += '&ptRule_TriggerProtocol_1.1.'+i+'.0.0=' + get_by_id('trigger'+(i-1)).value;
				param.arg += '&ptRule_FirewallProtocol_1.1.'+i+'.0.0=' + get_by_id('public'+(i-1)).value;
				param.arg += '&ptRule_ScheduleIndex_1.1.'+i+'.0.0=' + get_by_id('schedule'+(i-1)).value;
			}
		}
		get_config_obj(param);
		//location.replace('adv_appl.asp');
	}

	function send_request(){
		var tcp_timeline = null;
		var udp_timeline = null;

		if (!is_form_modified("form3") && !confirm(get_words(_ask_nochange))) {
			return false;
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
		}
		
		if(wa_https_en == 1)
		{
			tcp_timeline = add_into_timeline(tcp_timeline, wa_https_port, null);
		}
		
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var name = get_by_id("name" + i);
			var proto_type = get_by_id("public" + i).selectedIndex;
			var trigger_port = (get_by_id("trigger_port" + i).value).split("-");
			var public_port = (get_by_id("public_port" + i).value).split(",");			
			var is_enable = 0;
			var temp_appl;

			if (name.value != ""){
				var chk_trigger_port="";
				if (get_by_id("trigger_port" + i).value == ""){
		     		alert(get_words(TRIGGER_PORT_ERROR, msg));
		     		return false;
		     	}else if (get_by_id("public_port" + i).value == ""){
		     		alert(get_words(PUBLIC_PORT_ERROR, msg));
		     		return false;
		     	}
				
				if(is_number(get_by_id("trigger_port" + i).value))
					get_by_id("trigger_port" + i).value = parseInt(get_by_id("trigger_port" + i).value,10);
				if(is_number(get_by_id("public_port" + i).value))
					get_by_id("public_port" + i).value = parseInt(get_by_id("public_port" + i).value,10);
					
		     	if (!check_port(trigger_port[0])){
	 				alert(get_words(TRIGGER_PORT_ERROR, msg));
	 				return false;
	 			}		  
	 			   	chk_trigger_port += parseInt(trigger_port[0],10);
		     	if (trigger_port.length > 1){
		     		if (!check_port(trigger_port[1])){
		 				alert(get_words(PUBLIC_PORT_ERROR, msg));
		 				return false;
		 			}	
					chk_trigger_port += "-" + parseInt(trigger_port[1],10);
		     	}
				get_by_id("trigger_port" + i).value=chk_trigger_port;
				
				var tmp_public = get_by_id("public_port" + i).value.split("-");
				if (tmp_public.length ==2 && tmp_public[0] == ""){
	 				alert(get_words(PUBLIC_PORT_ERROR, msg));
	 				return false;
	 			}
				
		     	if(get_by_id("enable" + i).checked == true){
					var chk_public_port="";
					for (var j = 0; j < public_port.length; j++){
						var port = public_port[j].split("-");
						for(var k=0; k<port.length; k++)
						{
							if(port[k]=="")
							{
								alert(get_words(ac_alert_invalid_port));									
								return false;
							}
						}
						
						var temp_port1 = "";
						var temp_port2 = "";
						temp_port1 = port[0];
						
						if (port.length > 1)
							temp_port2 = port[1];					
						
						if (temp_port1 != ""){
							if (!check_port(temp_port1)){
								alert(get_words(PUBLIC_PORT_ERROR, msg));
								return false;
							}
							chk_public_port += parseInt(temp_port1,10);
						}					
						if (temp_port2 != ""){
							if (!check_port(temp_port2)){
								alert(get_words(PUBLIC_PORT_ERROR, msg));
								return false;
							}
							chk_public_port += "-" + parseInt(temp_port2,10);
						}
						if(public_port.length>1 && j<public_port.length-1)
							chk_public_port += ",";
					}
					
					get_by_id("public_port" + i).value=chk_public_port;

					//check application firewall port and remote management port conflict problem
					var remote_port = "";
					var remote_port_enable = "";
					if(get_by_id("enable" + i).checked == true){
						if (proto_type == 0) {
							var tcp_ports = get_by_id('public_port'+i).value.split(',');
							for (var j=0; j<tcp_ports.length; j++) {
								var range = tcp_ports[j].split('-');
								tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
							}
						} else if (proto_type == 1) {
							var udp_ports = get_by_id('public_port'+i).value.split(',');
							for (var j=0; j<udp_ports.length; j++) {
								var range = udp_ports[j].split('-');
								udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
							}
						} else {
							var tcp_ports = get_by_id('public_port'+i).value.split(',');
							for (var j=0; j<tcp_ports.length; j++) {
								var range = tcp_ports[j].split('-');
								tcp_timeline = add_into_timeline(tcp_timeline, range[0], range[1]);
							}
							var udp_ports = get_by_id('public_port'+i).value.split(',');
							for (var j=0; j<udp_ports.length; j++) {
								var range = udp_ports[j].split('-');
								udp_timeline = add_into_timeline(udp_timeline, range[0], range[1]);
							}
						}
					}
					
				}
				
				
				for(jj=i+1;jj<rule_max_num;jj++){
					if(get_by_id("name" + jj).value==get_by_id("name" + i).value){
						//alert("The Application table has the same rules.\n");
						alert(get_words(ag_inuse));
						return false;
						break;
					}
					if(get_by_id("trigger" + jj).value == get_by_id("trigger" + i).value){
						if(get_by_id("trigger_port" + jj).value==get_by_id("trigger_port" + i).value){
							alert(get_words(TEXT057));	
							return false;
						}
					}
					if(get_by_id("public" + jj).value == get_by_id("public" + i).value){
						if(get_by_id("public_port" + jj).value == get_by_id("public_port" + i).value){
							alert(get_words(TEXT057));	
							return false;
						}
					}
				}

				//if(remote_port_enable == 1 || remote_https_en == 1)
				//{
	
					if (check_timeline(tcp_timeline) == false) {
						alert(addstr(get_words(ag_conflict5), 'Firewall', get_by_id("public_port" + i).value));
						return false;
					}
				
					if (check_timeline(udp_timeline) == false) {
			  			alert(addstr(get_words(ag_conflict5), 'Trigger', get_by_id("public_port" + i).value));
						return false;
					}
			//	}
		        count++;		     	
			}  else {
				if (get_by_id('enable'+i).checked == true) {
					alert(get_words(pf_name_empty));
					return false;
				}
			}
		}
		
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			//get_by_id("form2").submit();
			do_submit();
			//return true;
		}
		
		return false;
	}

/*function add_option(id)
{
	var obj = null;
	var arr = null;
	var nam = null;
	var str = "";
	
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
			var inst = inst_array_to_string(arr[i]);
			str += ("<option value=" + inst.charAt(1) + ">" + nam[i] + "</option>");
	}	
	return str;
}*/
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
	var table_str = '<form id="form3"><h2>'+rule_max_num+'&ndash;&ndash; '+get_words(APP_RULES)+'</h2>';
        table_str +='<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1><tbody>';
        table_str +='<tr>';
        table_str +='<td align=middle width=20>&nbsp;</td>';
        table_str +='<td width="75">&nbsp;</td>';
        table_str +='<td align=middle><div align="left">&nbsp;</div></td>';
        table_str +='<td align=middle><div align="left"><strong>'+get_words(sps_port)+'</strong></div></td>';
        table_str +='<td align=middle><div align="left"><strong>'+get_words(av_traftype)+'</strong></div></td>';
        table_str +='<td align=middle><div align="left"><strong>'+get_words(_sched)+'</strong></div></td>';
        table_str +='</tr>';
		
	var Application_list = set_application_option(Application_list, default_appl);
	var disabledStr = "";
	if(login_Info!= "w" || dev_mode == "1"){
		disabledStr = "disabled";
	}
	for(var i=0 ; i< rule_max_num ; i++){
		var obj_enable = "";
		var obj_name = "";
		var obj_tgport = "";
		var obj_fwport = "";
		var obj_tgprotocol = "";
		var obj_fwprototol = "";
		var obj_Schdule = "";

		if(array_enable!=null)
			obj_enable = array_enable[i];
		if(array_name!=null)
		{
			obj_name = array_name[i].replace("+"," ");
			obj_name = obj_name.replace("+"," ");
		}
		if(array_tgport!=null)
			obj_tgport = array_tgport[i];
		if(array_fwport!=null)
			obj_fwport = array_fwport[i];
		if(array_tgprotocol!=null)
			obj_tgprotocol = array_tgprotocol[i];
		if(array_fwprotocol!=null)
			obj_fwprototol = array_fwprotocol[i];
		if(array_Schdule!=null)
			obj_Schdule = array_Schdule[i];
			
	table_str +=("<tr>");
	if(obj_enable == '1')
		table_str+=("<td align=center rowspan=2><input "+disabledStr+" type=checkbox id=enable" + i + " name=enable" + i + " value=1 checked></td>");
	else
		table_str+=("<td align=center rowspan=2><input "+disabledStr+" type=checkbox id=enable" + i + " name=enable" + i + " value=1></td>");
	table_str+=('<td rowspan=2 align=center valign=middle>'+get_words(_name)+'<br><input '+disabledStr+' type=text class=flatL id=name' + i + ' name=name' + i + ' size=15 maxlength=31 value="'+obj_name+'"></td>');
	table_str+=('<td rowspan=2 align=center valign=middle>'+get_words(_app)+'<br>');
	table_str+=("<input "+disabledStr+" id=copy_app" + i + " name=copy_app" + i + " type=button value=<< class=btnForCopy onClick='copy_special_appl(" + i + ")'>");
	table_str+=("<select "+disabledStr+" class=wordstyle style='width:108' id=application" + i +" name=application" + i +" modified=\"ignore\">");
	table_str+=('<option>'+get_words(gw_SelVS)+'</option>');
	table_str+=(Application_list);
	table_str+=("</select></td>");
	
	table_str+=('<td align=center valign=bottom>'+get_words(_trigger)+'<br><input '+disabledStr+' type=text class=flatL id=trigger_port' + i +' name=trigger_port' + i +' maxLength=31 size=5 value="'+obj_tgport+'"></td>');
	table_str+=("<td align=center valign=middle>");
	table_str+=("<select "+disabledStr+" class=wordstyle id=trigger" + i + " name=trigger" + i +" >");
	table_str+=('<option value=\"0\" '+ (obj_tgprotocol == '0'? 'selected' : '') + '>'+get_words(_TCP)+'</option>');
	table_str+=('<option value=\"1\" '+ (obj_tgprotocol == '1'? 'selected' : '') + '>'+get_words(_UDP)+'</option>');
	table_str+=('<option value=\"2\" '+ (obj_tgprotocol == '2'? 'selected' : '') + '>'+get_words(at_Any)+'</option>');
	table_str+=("</select></td>");
	table_str+=("<td rowspan=2 align=center valign=middle>");
	table_str+=("<select "+disabledStr+" width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
	table_str+=('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+get_words(_always)+'</option>');
	table_str+=('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+get_words(_never)+'</option>');
	//table_str+=(set_schedule_option());
	table_str+=(add_option('Schedule', obj_Schdule));
	
	table_str+=("</select>");
	table_str+=("</td>");
	table_str+=("</tr>");
	
	table_str+=("<tr>");
	table_str+=('<td align=center valign=bottom>'+get_words(_firewall)+'<br><input '+disabledStr+' type=text class=flatL id=public_port' + i + ' name=public_port'+ i +' maxLength=31 size=5 value="'+obj_fwport+'"></td>');
	table_str+=("<td align=center valign=middle>");
	table_str+=("<select "+disabledStr+" class=wordstyle id=public" + i + " name=public" + i +" >");
	table_str+=('<option value=\"0\" '+ (obj_fwprototol == '0'? 'selected' : '') + '>'+get_words(_TCP)+'</option>');
	table_str+=('<option value=\"1\" '+ (obj_fwprototol == '1'? 'selected' : '') + '>'+get_words(_UDP)+'</option>');
	table_str+=('<option value=\"2\" '+ (obj_fwprototol == '2'? 'selected' : '') + '>'+get_words(at_Any)+'</option>');
	table_str+=("</select></td>");			
	table_str+=("</tr>");
	//do_select('schedule'+i, 'val', obj_Schdule);
	//do_select('trigger'+i, 'val', obj_tgprotocol);
	//do_select('public'+i, 'val', obj_fwprototol);
	}
	
	table_str += '</tbody></table></form>';

	get_by_id("contant_table").innerHTML = table_str;
	
	if(login_Info!= "w" || dev_mode == "1"){
		DisableEnableForm(form3,true);	
	}
	set_form_default_values("form3");
}
</script>    
<title>D-Link公司 | ??路由器 | 主?</title>
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
<table id="footer_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
						   <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_specappsr)</script></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <!--<LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI>-->
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <!--LI><div><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI-->
							<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
                
                <form id="form1" name="form1" method="post" action="get_set.ccp">
				<input type="hidden" name="ccp_act" value="set">
				<input type="hidden" name="ccpSubEvent" value="CCP_SUB_PORTTRIGGER">
				<input type="hidden" name="nextPage" value="adv_appl.asp">	
				
                
                
			<td valign="top" id="maincontent_container">
				<div id=maincontent>			
                  <div id=box_header>
                    <h1><script>show_words(_specappsr)</script></h1>
                    <script>show_words(as_intro_SA)</script><br><br>
                              	<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
            <input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form3', 'adv_appl.asp');">
            <script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
            <script>get_by_id("button").value = get_words(_savesettings);</script>
                  </div>
				</form>
                  <div class=box id="contant_table">
                    <!--<h2><script>document.write(rule_max_num)</script> &ndash;&ndash; <script>show_words(APP_RULES)</script></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="75">&nbsp;</td>
                          <td align=middle><div align="left">&nbsp;</div></td>
                          <td align=middle><div align="left"><strong><script>show_words(sps_port)</script></strong></div></td>
                          <td align=middle><div align="left"><strong><script>show_words(av_traftype)</script></strong></div></td>
                          <td align=middle><div align="left"><strong><script>show_words(_sched)</script></strong></div></td>
                        </tr>
						<script>
							var Application_list = set_application_option(Application_list, default_appl);
							for(var i=0 ; i< rule_max_num ; i++){
								var obj_enable = "";
								var obj_name = "";
								var obj_tgport = "";
								var obj_fwport = "";
								var obj_tgprotocol = "";
								var obj_fwprototol = "";
								var obj_Schdule = "";

								if(array_enable!=null)
									obj_enable = array_enable[i];
								if(array_name!=null)
								{
									obj_name = array_name[i].replace("+"," ");
									obj_name = obj_name.replace("+"," ");
								}
								if(array_tgport!=null)
									obj_tgport = array_tgport[i];
								if(array_fwport!=null)
									obj_fwport = array_fwport[i];
								if(array_tgprotocol!=null)
									obj_tgprotocol = array_tgprotocol[i];
								if(array_fwprotocol!=null)
									obj_fwprototol = array_fwprotocol[i];
								if(array_Schdule!=null)
									obj_Schdule = array_Schdule[i];
									
							document.write("<tr>");
							if(obj_enable == '1')
								document.write("<td align=center rowspan=2><input type=checkbox id=enable" + i + " name=enable" + i + " value=1 checked></td>");
							else
								document.write("<td align=center rowspan=2><input type=checkbox id=enable" + i + " name=enable" + i + " value=1></td>");
							document.write('<td rowspan=2 align=center valign=middle>'+get_words(_name)+'<br><input type=text class=flatL id=name' + i + ' name=name' + i + ' size=15 maxlength=31 value="'+obj_name+'"></td>');
							document.write('<td rowspan=2 align=center valign=middle>'+get_words(_app)+'<br>');
							document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< class=btnForCopy onClick='copy_special_appl(" + i + ")'>");
							document.write("<select class=wordstyle style='width:108' id=application" + i +" name=application" + i +" modified=\"ignore\">");
							document.write('<option>'+get_words(gw_SelVS)+'</option>');
							document.write(Application_list);
							document.write("</select></td>");
							
							document.write('<td align=center valign=bottom>'+get_words(_trigger)+'<br><input type=text class=flatL id=trigger_port' + i +' name=trigger_port' + i +' maxLength=31 size=5 value="'+obj_tgport+'"></td>');
							document.write("<td align=center valign=middle>");
							document.write("<select class=wordstyle id=trigger" + i + " name=trigger" + i +" >");
							document.write('<option value=\"0\" '+ (obj_tgprotocol == '0'? 'selected' : '') + '>'+get_words(_TCP)+'</option>');
							document.write('<option value=\"1\" '+ (obj_tgprotocol == '1'? 'selected' : '') + '>'+get_words(_UDP)+'</option>');
							document.write('<option value=\"2\" '+ (obj_tgprotocol == '2'? 'selected' : '') + '>'+get_words(at_Any)+'</option>');
							document.write("</select></td>");
							document.write("<td rowspan=2 align=center valign=middle>");
							document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
							document.write('<option value=\"255\" '+ ((obj_Schdule==255) ? 'selected' : '' )+'>'+get_words(_always)+'</option>');
							document.write('<option value=\"254\" '+ ((obj_Schdule==254) ? 'selected' : '' )+'>'+get_words(_never)+'</option>');
							//document.write(set_schedule_option());
							document.write(add_option('Schedule', obj_Schdule));
							
							document.write("</select>");
							document.write("</td>");
							document.write("</tr>");
							
							document.write("<tr>");
							document.write('<td align=center valign=bottom>'+get_words(_firewall)+'<br><input type=text class=flatL id=public_port' + i + ' name=public_port'+ i +' maxLength=31 size=5 value="'+obj_fwport+'"></td>');
							document.write("<td align=center valign=middle>");
							document.write("<select class=wordstyle id=public" + i + " name=public" + i +" >");
							document.write('<option value=\"0\" '+ (obj_fwprototol == '0'? 'selected' : '') + '>'+get_words(_TCP)+'</option>');
							document.write('<option value=\"1\" '+ (obj_fwprototol == '1'? 'selected' : '') + '>'+get_words(_UDP)+'</option>');
							document.write('<option value=\"2\" '+ (obj_fwprototol == '2'? 'selected' : '') + '>'+get_words(at_Any)+'</option>');
							document.write("</select></td>");			
							document.write("</tr>");
 							//do_select('schedule'+i, 'val', obj_Schdule);
							//do_select('trigger'+i, 'val', obj_tgprotocol);
							//do_select('public'+i, 'val', obj_fwprototol);
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
                      <td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
                      	<p><script>show_words(hhpt_intro)</script></p>
						<p><script>show_words(hhpt_app)</script></p>
						<p><script>show_words(hhpt_sch)</script></p>
						<p><a href="support_adv.asp#Special_Applications" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	//set_application();
	//paint_table();
	//set_form_default_values("form1");
</script>
</html>
