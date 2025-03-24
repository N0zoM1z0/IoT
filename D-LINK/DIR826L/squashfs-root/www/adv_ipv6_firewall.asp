<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script src="uk.js" type="text/javascript"></script> 
<script language="JavaScript" src="public.js"></script> 
<script language="JavaScript" src="public_msg.js"></script> 
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script> 
<script language="Javascript" src="js/xml.js"></script> 
<script language="Javascript" src="js/object.js"></script> 
<script language="JavaScript" src="public_ipv6.js"></script>
<script>
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=3&"+
				"oid_1=IGD_Firewallv6_&inst_1=11000&"+
				"oid_2=IGD_Firewallv6_Rule_i_&inst_2=11000&"+
				"oid_3=IGD_ScheduleRule_i_&inst_3=10000&"
	};
	get_config_obj(param);

	var action = config_val("firewallv6Setting_Action_");

	var array_enable 		= config_str_multi("firewallv6Rule_Enable_");
	var array_name 			= config_str_multi("firewallv6Rule_Name_");
	var array_scheduleindex 	= config_str_multi("firewallv6Rule_ScheduleIndex_");
	var array_srcinterface 		= config_str_multi("firewallv6Rule_SourceInterface_");
	var array_dstinterface 		= config_str_multi("firewallv6Rule_DestinationInterface_");
	var array_srcipstart		= config_str_multi("firewallv6Rule_SourceIPRangeStart_");
	var array_srcipend		= config_str_multi("firewallv6Rule_SourceIPRangeEnd_");
	var array_dstipstart 		= config_str_multi("firewallv6Rule_DestinationIPRangeStart_");
	var array_dstipend		= config_str_multi("firewallv6Rule_DestinationIPRangeEnd_");
	var array_protocol 		= config_str_multi("firewallv6Rule_Protocol_");
	var array_portstart 		= config_str_multi("firewallv6Rule_PortRangeStart_");
	var array_portend		= config_str_multi("firewallv6Rule_PortRangeEnd_");	

	var array_sch_inst 		= config_inst_multi("IGD_ScheduleRule_i_");
	var array_schedule_name	= config_str_multi("schRule_RuleName_");
	var schedule_cnt = 0;

	if(array_schedule_name != null)
		schedule_cnt = array_schedule_name.length;

	var submit_button_flag = 0;
	var rule_max_num = 20;
	var tmpsrc;
	var tmpdst;
	var srcarray;
	var dstarray;
	var IPv6SimpSec_enable = config_val("firewallv6Setting_SimpSecEnable_");
	var IPv6IngreFil_enable = config_val("firewallv6Setting_IngreFilEnable_");
	function onPageLoad()
	{
		var login_who=login_Info;
		if(login_who!= "w"){
			DisableEnableForm(form2,true);
		}
		setTimeout("paint_table()", 5);
	}

	function set_vs_protocol(i, which_value, obj)
	{
		set_selectIndex(which_value,obj);
		$('#protocol'+i).attr('disabled',true);
		if(which_value != obj.options[obj.selectedIndex].value){
			$('#protocol'+i).attr('disabled','');
			$('#protocol_select'+i)[0].selectedIndex = 3;
		}
		$('#protocol'+i).val(which_value);
	}
    function protocol_change(i)
	{
		$("#port_start"+i).attr('disabled', '');
		$("#port_end"+i).attr('disabled', '');

		if($('#protocol_select'+i)[0].selectedIndex == 0 || $('#protocol_select'+i)[0].selectedIndex == 1){ // Other
			$("#port_start"+i).val('1');
			$("#port_end"+i).val('65535');
			$("#port_start"+i).attr('disabled', true);
			$("#port_end"+i).attr('disabled', true);
		}
		if(login_Info != "w")
		{
			$("#protocol"+i).attr('disabled', true);
			$("#public_portS"+i).attr('disabled', true);
			$("#private_portS"+i).attr('disabled', true);
		}
	}

	function detect_protocol_change_port(proto,i)
	{
		if((proto == 0)||(proto == 1)||(proto == 2)){
			$('#protocol'+i).attr('disabled',true);
			$('#public_portS'+i).attr('disabled','');
			$('#private_portS'+i).attr('disabled','');
		}else{
			$('#public_portS'+i).attr('disabled',true);
			$('#private_portS'+i).attr('disabled',true);
		}
		if(login_Info != "w")
		{
			$('#protocol'+i).attr('disabled',true);
			$('#public_portS'+i).attr('disabled',true);
			$('#private_portS'+i).attr('disabled',true);
		}
	}

	function send_request()
	{
		var tcp_timeline = '';
		var udp_timeline = '';
		var tmparray;
		var tmptmparray;

		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,"IPv6 address");
		if (!is_form_modified("form3") && !confirm(which_lang[_ask_nochange]))
			return false;
		var count = 0;

		//chk name is the same
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = $('#name' + i).val();
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == $('#name' + j).val()){
						alert(addstr(which_lang[av_alert_16], $('#name' + j).val()));
						return false;
					}
				}
			}
		}

		//src ip range and dst ip range check
		for (var i = 0; i < rule_max_num; i++)
		{
			if($('#name' + i).val()!="")
			{
				tmpsrc = $('#src_ip_range'+i).val();
				tmpdst = $('#dst_ip_range'+i).val();

				tmparray = tmpsrc.split("-");
				tmptmparray = tmpdst.split("-");
				tmparray[2] = tmptmparray[0];
				tmparray[3] = tmptmparray[1];

				for(var k=0;k<4;k++)
				{
					if (tmparray[k] == null || tmparray[k] == '')
						continue;
					if(check_ipv6_symbol(tmparray[k],"::")==2){ // find more than one '::' symbol
						return false;
					}else if(check_ipv6_symbol(tmparray[k],"::")==1){    // find one '::' symbol
						temp_ipv6_static = new ipv6_addr_obj(tmparray[k].split("::"), ipv6_static_msg, true, false);
						if (!check_ipv6_address(temp_ipv6_static,"::"))
							return false;
					}else{  //not find '::' symbol
						temp_ipv6_static = new ipv6_addr_obj(tmparray[k].split(":"), ipv6_static_msg, true, false);
						if (!check_ipv6_address(temp_ipv6_static,":"))
							return false;
					}
				}
			}
		}

		for (var i = 0; i < rule_max_num; i++) {
			var protocol = $('#protocol_select' +i)[0].selectedIndex;
			var other = $('#protocol_select'+i).val();
			var check_name = $('#name'+i).val();
			var tmp_port_start = $('#port_start'+i).val();
			var tmp_port_end = $('#port_end'+i).val();
			var temp_vs;

			if ($('#enable'+i)[0].checked == true)
			{
				if($('#src_ip_range'+i).val()=="")
				{
					alert(which_lang[MSG042]);
					return false;
				}
				if($('#dst_ip_range'+i).val()=="")
				{
					alert(which_lang[MSG042]);
					return false;
				}
				if($('#src_ip_range'+i).val()=="")
				{
					alert(which_lang[ZERO_IPV6_ADDRESS]);
					return false;
				}
				if($('#dst_ip_range'+i).val()=="")
				{
					alert(which_lang[ZERO_IPV6_ADDRESS]);
					return false;
				}
				if($('#port_start'+i).val()=="")
				{
					alert(which_lang[port_empty]);
					return false;
				}
				if($('#port_end'+i).val()=="")
				{
					alert(which_lang[port_empty]);
					return false;
				}
			}
			
			if ($('#name'+i).val() != ""){
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert(addstr(which_lang[TEXT002], $('#name'+i).val() ));
					return false;
				}

				var remote_port='';
				var remote_port_enable='0';
				if($('#enable' + i)[0].checked == true){
					if(remote_port_enable == "1"){
						if ($('#port_start'+i).val() == remote_port && protocol != 1){
							alert(which_lang[av_alert_12]);
							return false;
						}
					}
				}
				if(protocol>0)
				{
					// check port
					if (!check_integer(tmp_port_start, 1, 65535)) {
						alert(which_lang[virtual_pub_port_err]);
						return false;
					}
					if (!check_integer(tmp_port_end, 1, 65535)) {
						alert(which_lang[virtual_pri_port_err]);
						return false;
					}
					
					if(parseInt(tmp_port_start)>parseInt(tmp_port_end)){
						alert(msg[PORT_RANGE_ERROR]);
						return false;
					}
				}

				var is_enable = get_checked_value($('#enable'+i)[0]);
				// check port range
				if (is_enable == '1') {
					if ($('#protocol_select'+i).val() == '6') {			//tcp
						tcp_timeline = add_into_timeline(tcp_timeline, $('#port_start'+i).val(), null);
					} else if ($('#protocol_select'+i).val() == '17') {	//udp
						udp_timeline = add_into_timeline(udp_timeline, $('#port_start'+i).val(), null);
					} else if ($('#protocol_select'+i).val() == '256') {	//all
						tcp_timeline = add_into_timeline(tcp_timeline, $('#port_start'+i).val(), null);
						udp_timeline = add_into_timeline(udp_timeline, $('#port_start'+i).val(), null);
					}
					
					if (check_timeline(tcp_timeline) == false) {
						alert(addstr(which_lang[ag_conflict4], 'TCP', $('#port_start'+i).val()));
						return false;
					}
					
					if (check_timeline(udp_timeline) == false) {
						alert(addstr(which_lang[ag_conflict4], 'UDP', $('#port_start'+i).val()));
						return false;
					}
				}
		        count++;
			}else{
				if ($('#enable'+i)[0].checked == true) 
				{
					alert(which_lang[fr_name_empty]);
					return false;
				}
			}
		}
		if(submit_button_flag == 0)
		{
			submit_button_flag = 1;
			do_submit();
		}
	}

	function do_submit()
	{
		var param = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_FIREWALL6&nextPage=adv_ipv6_firewall.asp'
		};

		var tmpsrc;
		var tmpdst;
		var srcarray = new Array(2);
		var dstarray = new Array(2);

		param.arg += '&firewallv6Setting_Action_1.1.0.0.0='+$('#action_list')[0].selectedIndex;
		param.arg += '&firewallv6Setting_IngreFilEnable_1.1.0.0.0='+$('#IngreFil_Enable').val();
		param.arg += '&firewallv6Setting_SimpSecEnable_1.1.0.0.0='+$('#SimpSec_Enable').val();
		for(var i=0; i<rule_max_num; i++)
		{	
			var inst = '1.1.'+(i+1)+'.0.0';
			param.arg += '&firewallv6Rule_Enable_'+inst+'='+get_checked_value($('#enable'+i)[0]);
			param.arg += '&firewallv6Rule_Name_'+inst+'='+$('#name'+i).val();
			param.arg += '&firewallv6Rule_ScheduleIndex_'+inst+'='+$('#schedule'+i).val();
			param.arg += '&firewallv6Rule_SourceInterface_'+inst+'='+$('#src_interface'+i).val();
			param.arg += '&firewallv6Rule_DestinationInterface_'+inst+'='+$('#dst_interface'+i).val();

			if($('#src_ip_range'+i).val()==""){
				srcarray[0]="";srcarray[1]="";
			}else{
				tmpsrc = $('#src_ip_range'+i).val();
				srcarray = tmpsrc.split("-");
			}
			if($('#dst_ip_range'+i).val()==""){
				dstarray[0]="";dstarray[1]="";
			}else{
				tmpdst = $('#dst_ip_range'+i).val();
				dstarray = tmpdst.split("-");
			}
			param.arg += '&firewallv6Rule_SourceIPRangeStart_'+inst+'=' + srcarray[0];
			param.arg += '&firewallv6Rule_SourceIPRangeEnd_'+inst+'=' + srcarray[1];
			param.arg += '&firewallv6Rule_DestinationIPRangeStart_'+inst+'=' + dstarray[0];
			param.arg += '&firewallv6Rule_DestinationIPRangeEnd_'+inst+'=' + dstarray[1];
			param.arg += '&firewallv6Rule_Protocol_'+inst+'=' + $('#protocol_select'+i).val();
			param.arg += '&firewallv6Rule_PortRangeStart_'+inst+'=' + $('#port_start'+i).val();
			param.arg += '&firewallv6Rule_PortRangeEnd_'+inst+'=' + $('#port_end'+i).val();
		}
		get_config_obj(param);
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

		for (var i = 0; i < obj; i++)
		{
			var str_sel = '';

			if (id == 'Schedule') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(1))
					str_sel = 'selected';
				str += ("<option value=" + inst.charAt(1) + " " + str_sel + ">" + nam[i] + "</option>");
			} else if (id == 'Inbound') {
				var inst = inst_array_to_string(arr[i]);
				if (def_val == inst.charAt(2))
					str_sel = 'selected';
				str += ("<option value=" + inst.charAt(2) + " " + str_sel + ">" + nam[i] + "</option>");
			}
		}
		return str;
	}

	function do_select(id, type, value)
	{
		var obj = null;
		if (type == 'idx')
			obj = $('#'+id+' option:eq('+value+')')
		else if (type == 'val')
			obj = $('#'+id+' option[value='+value+']');

		if (obj == null)
			return;
			
		obj.attr("selected", true);
	}

	function disable_firewall_rule()
	{
		var disable = false;
		if($('#action_list')[0].selectedIndex == 0)
			disable = true;

		for(var i=0 ; i<rule_max_num ; i++){
			$('#schedule'+i).attr('disabled',disable);
			$('#src_interface'+i).attr('disabled',disable);
			$('#dst_interface'+i).attr('disabled',disable);
			$('#protocol_select'+i).attr('disabled',disable);
			$('#port_start'+i).attr('disabled',disable);
			$('#port_end'+i).attr('disabled',disable);
			$('#src_ip_range'+i).attr('disabled',disable);
			$('#dst_ip_range'+i).attr('disabled',disable);
			$('#enable'+i).attr('disabled',disable);
			$('#name'+i).attr('disabled',disable);
			if(!disable)
				protocol_change(i);
		}
	}

	function changeSimpSec(obj)
	{
		if(obj.checked)
			{
				$('#IngreFil_Enable').attr("checked", true);
				$('#IngreFil_Enable').attr('disabled', true);
				obj.value="1";
			}else{
				
				$('#IngreFil_Enable').attr('disabled', false);
				obj.value="0";
			}
	}
	
	function changeIngreFil(obj)
	{
		if(obj.checked)
			obj.value="1";
		else
			obj.value="0";
	}
	
	function paint_table()
	{
		var table_str = '<form id="form3"> <h2>' + get_words(IPv6_Simple_Security) + '</h2>';
			table_str += '<table cellSpacing=1 cellPadding=1 width=525 border=0 id=tbl_SimpSec>';
			table_str += '<tr><td width=175 align=right class=\"duple\">'+get_words(IPv6_Ingress_Filtering_enable)+':</td>';
			table_str += '<td width=\"300\">&nbsp';
			table_str += '<input type=\"checkbox\" id=IngreFil_Enable  name=\"IngreFil_Enable\" value=\"\" onClick=\" changeIngreFil(this); \"></td></tr>';
			table_str += '<tr><td width=175 align=right class=\"duple\">'+get_words(IPv6_Simple_Security_enable)+':</td>';
			table_str += '<td width=\"300\">&nbsp';
			table_str += '<input type=\"checkbox\" id=SimpSec_Enable  name=\"SimpSec_Enable\" value=\"\" onClick=\" changeSimpSec(this); \">';
			table_str += '</td></tr></table>';	
			table_str += '<h2>' + get_words(if_iflist) + '</h2>';
			table_str += "<br>" + get_words(IPv6_fw_01) + "<br><select "+disabledStr+" style='width:250' id=action_list name=action_list onChange=\"disable_firewall_rule();\">";
			table_str += '<option value=0>' + get_words(IPv6_fw_02) +'</option><option value=1>' + get_words(IPv6_fw_03) +'</option><option value=2>' + get_words(IPv6_fw_04) +'</option>';
			table_str += "</select><br><br><span>"+get_words(ipv6_firewall_info)+"</span>";
			table_str += '<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1><tbody>';

		var Application_list = set_application_option(Application_list, default_virtual);
		var Inbound_list = '';
		var disabledStr = "";
		if(login_Info!= "w"){
			disabledStr = "disabled";
		}
		for(var i=0 ; i<rule_max_num ; i++){
			var obj_enable = "";
			var obj_name = "";
			var obj_scheduleindex = "";
			var obj_srcinterface = "";
			var obj_dstinterface = "";
			var obj_srciprange = "";
			var obj_dstiprange  = "";
			var obj_protocol = "";
			var obj_portstart  = "";
			var obj_portend = "";

			try {
				if(array_enable[i]!=null)
					obj_enable = array_enable[i];
				if(array_name[i]!=null)
					obj_name = array_name[i];
				if(array_srcipstart[i]!=null && (obj_enable || array_srcipstart[i]!=''))
					obj_srciprange = filter_ipv6_addr(array_srcipstart[i]);
				if(array_srcipend[i]!=null && array_srcipend[i] != '')
					obj_srciprange += "-" + filter_ipv6_addr(array_srcipend[i]);
				if(array_dstipstart[i]!=null && (obj_enable || array_dstipstart[i]!=''))
					obj_dstiprange = filter_ipv6_addr(array_dstipstart[i]);
				if(array_dstipend[i]!=null && array_dstipend[i] != '')
					obj_dstiprange += "-" + filter_ipv6_addr(array_dstipend[i]);
				if(array_portstart[i]!=null && array_portstart[i] != 0)
					obj_portstart = array_portstart[i];
				else
					obj_portstart = 1;
				if(array_portend[i]!=null && array_portend[i] != 0)
					obj_portend = array_portend[i];
				else
					obj_portend = 65535;
			} catch (e) {
			}

			table_str += "<tr>";
			if (obj_enable == '1')
				table_str += "<td align=center valign=middle rowspan=3><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\" checked></td>";
			else
				table_str += "<td align=center valign=middle rowspan=3><input "+disabledStr+" type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>";
			table_str += '<td valign=bottom colspan=2>'+which_lang[_name]+'<br><input '+disabledStr+' type=text class=flatL id=\"name' + i + '\" name=\"name'+ i +'\" size=20 maxlength=15 value="'+ obj_name +'"></td>';
			table_str += '<td align=left>'+which_lang[_sched]+'<br>';
			table_str += "<select "+disabledStr+" width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>";
			table_str += '<option value=\"255\" '+ ((obj_scheduleindex=="255") ? 'selected' : '' )+'>'+which_lang[_always]+'</option>';
			table_str += '<option value=\"254\" '+ ((obj_scheduleindex=="254") ? 'selected' : '' )+'>'+which_lang[_never]+'</option>';
			table_str += add_option('Schedule', obj_scheduleindex);
			table_str += "</select></td><td>&nbsp;</td>";
			table_str += "</tr>";

			table_str += "<tr>";
			table_str += '<td>' + get_words(IPv6_fw_sr) + '</td>';
			table_str += "<td align=left valign=bottom>"+which_lang[_interface]+'<br>';
			table_str += "<select "+disabledStr+" style='width:50' id=src_interface" + i +" name=src_interface" + i +" modified=\"ignore\">";
			table_str += '<option value=0>*</option>';
			table_str += '<option value=2>WAN</option><option value=1>LAN</option>';
			table_str += "</select></td>";
			table_str += '<td align=left valign=bottom>' + get_words(IPv6_fw_ipr) + '<br><input '+disabledStr+' type=text class=flatL id=src_ip_range' + i + ' name=src_ip_range' + i +' size=43 maxlength=80 value="'+obj_srciprange+'"></td>';
			table_str += "<td align=left valign=bottom>"+which_lang[_vs_proto]+'<br>';
			table_str += "<select "+disabledStr+" width=80 id=protocol_select" + i + " name=protocol_select" + i +" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex," + i + ");\">";
			table_str += '<option value=2>'+get_words('_ICMP')+'</option>';
			table_str += '<option value=3>'+get_words('at_Any')+'</option>';
			table_str += '<option value=0 selected>'+get_words('_TCP')+'</option>';
			table_str += '<option value=1>'+get_words('_UDP')+'</option>';
			table_str += "</select></td>";
			table_str += "</tr>";

			table_str += "<tr>";
			table_str += '<td>' + get_words(IPv6_fw_dest) + '</td>';
			table_str += "<td align=left valign=bottom>"+which_lang[_interface]+'<br>';
			table_str += "<select "+disabledStr+" style='width:50' id=dst_interface" + i +" name=dst_interface" + i +" modified=\"ignore\">";
			table_str += '<option value=0>*</option>';
			table_str += '<option value=2>WAN</option><option value=1>LAN</option>';
			table_str += "</select></td>";
			table_str += '<td align=left valign=bottom>' + get_words(IPv6_fw_ipr) + '<br><input '+disabledStr+' type=text class=flatL id=dst_ip_range' + i + ' name=dst_ip_range' + i +' size=43 maxlength=80 value="'+obj_dstiprange+'"></td>';
			table_str += '<td align=left valign=bottom>' + get_words(IPv6_fw_pr) + '<br><input '+disabledStr+' type=text class=flatL id=port_start' + i + ' name=port_start' + i +' size=6 maxlength=5 value="'+obj_portstart+'">~';
			table_str += '<input '+disabledStr+' type=text class=flatL id=port_end' + i + ' name=port_end' + i +' size=6 maxlength=5 value="'+obj_portend+'"></td>'
			table_str += "</tr>";
		}

		table_str += '</tbody></table></form>';

		$('#contant_table').html(table_str);
		if (login_Info != "w") {
			$("#SimpSec_Enable").attr("disabled",true);
			$("#action_list").attr("disabled",true);
		}
		do_select('action_list', 'idx', action);
		for(var i=0 ; i<rule_max_num ; i++){
			if(array_scheduleindex!=null)
				do_select('schedule'+i, 'val', array_scheduleindex[i]);
			if(array_srcinterface!=null)
				do_select('src_interface'+i, 'val', array_srcinterface[i]);
			if(array_dstinterface!=null)
				do_select('dst_interface'+i, 'val', array_dstinterface[i]);
			if(array_protocol!=null)
				do_select('protocol_select'+i, 'val', array_protocol[i]);
		}
		$('#SimpSec_Enable').val(config_val("firewallv6Setting_SimpSecEnable_"));
		if($('#SimpSec_Enable').val()==1)
		{
			$('#SimpSec_Enable').attr('checked',true);
			$('#IngreFil_Enable').attr('disabled',true);
		}
		else
			$('#SimpSec_Enable').attr('checked',false);
			
		//20120822 pascal add ingress filtering
		$('#IngreFil_Enable').val(config_val("firewallv6Setting_IngreFilEnable_"));
		if($('#IngreFil_Enable').val()==1)
			$('#IngreFil_Enable').attr('checked',true);
		else
			$('#IngreFil_Enable').attr('checked',false);
			
		disable_firewall_rule();
		set_form_default_values("form3");
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words('TA2')</script>: 
			<a href="http://support.dlink.com.tw/" onclick="return jump_if();"><script>document.write(model);</script></a></td>
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
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table cellSpacing=0 cellPadding=0 border=0>
			<tbody>
			<tr>
				<td id=sidenav_container>
				<div id=sidenav>
					<UL>
						<LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
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
						<LI><div id=sidenavoff><script>show_words(if_iflist)</script></a></div></LI>
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
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
			<div id="maincontent">
				<div id=box_header>
					<h1><script>show_words(if_iflist)</script></h1>
					<script>show_words(av_intro_if)</script>
					<br><br>
					<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
					<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form3', 'adv_ipv6_firewall.asp');">
					<script>get_by_id("button").value = get_words(_savesettings);</script>
					<script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
				</div>
		</form>
				<div class=box id="contant_table"></div>
			</div>
		</td>
		<form id="form1" name="form1" method="post" action="get_set.ccp">
			<input type="hidden" id="action" name="action" value="setpar">
			<input type="hidden" name="ccpSubEvent" value="CCP_SUB_FIREWALL6">
			<input type="hidden" name="nextPage" value="adv_virtual.asp">	
			<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_virtual.asp">
			<input type="hidden" name="ccp_act" value="set">
			<input type="hidden" name="num_inst" value="1">
			<input type="hidden" name="oid_1" value="IGD_WANDevice_i_VirServRule_i_">
			<input type="hidden" name="inst_1" value="11100">
			<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
		</form>
  			<!-- ######################### -->
			<!--      end of main part     -->
			<!-- ######################### -->

		<!-- user tips -->
		<td align="left" id="sidehelp_container" valign="top" width="150"> 
			<table bgcolor="#ffffff" border="0" bordercolor="#ffffff" bordercolordark="#ffffff" bordercolorlight="#ffffff" cellpadding="2" cellspacing="0">
			<tbody>
			<tr>
				<td id="help_text"><b><strong> 
					<script>show_words(_hints)</script> 
					</strong>&hellip;</b> 
					<p><script>show_words(hhav_name)</script></p>
					<p><script>show_words(hhav_ip)</script></p>
					<p><script>show_words(hhav_sch)</script></p>
					<p><script>show_words(hhav_filt)</script></p>
					<p><a href="support_adv.asp#IPv6_Firewall" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
</script> 
</html> 