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
	var maxACRule = 24;
	var total_page = 8;
	var pfRuleMax = 8;
	var editRow = -1;
	var editPageLoad = 0;
	var pPage = 1;
	var p5MachList = null;
	var is_modified = 0;
	var dev_info = get_router_info();
	
	/* get access control information */
	var param = {
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=5'+
				'&oid_1=IGD_AccessControl_&inst_1=11000'+
				'&oid_2=IGD_AccessControl_PolicyList_i_&inst_2=11000'+
				'&oid_3=IGD_ScheduleRule_i_&inst_3=10000'+
				'&oid_4=IGD_Status_LANStatus_Host_i_&inst_4=11100' +
				'&oid_5=IGD_&inst_5=10000'
	};
	get_config_obj(param);
	
	var host_list_opt_ip  = set_host_list_1('ip');
	var host_list_opt_mac = set_host_list_1('mac');

	var dev_mode = config_val("igd_DeviceMode_");
	
	//IGD_AccessControl_
	var acGlobalEnable 	= config_val('accessCtrl_GlobalEnable_');
	
	//IGD_AccessControl_PolicyList_i_
	var acPoListInst	= config_inst_multi("IGD_AccessControl_PolicyList_i_");
	var acPoListEnable 	= config_str_multi('accessPolicy_Enable_');
	var acPoListName	= config_str_multi('accessPolicy_Name_');
	var acPoListSchIdx	= config_str_multi('accessPolicy_ScheduleIndex_');
	var acPoListSelMach = config_str_multi('accessPolicy_SelectedMachines_');
	var acPoListMethod	= config_str_multi('accessPolicy_Method_');
	var acPoListWebFltr = config_str_multi('accessPolicy_ApplyWebFilter_');
	var acPoListWebLog	= config_str_multi('accessPolicy_EnableWebLog_');
	var acPoListPortFltr= config_str_multi('accessPolicy_ApplyAdvPortFilter_');
	var acPoListMachNum = config_str_multi('accessPolicy_MachineNumberOfEntries_');
	var acPoListPFNum   = config_str_multi('accessPolicy_PortFilterNumberOfEntries_');

	//IGD_ScheduleRule_i_
	var array_sch_inst 		= config_inst_multi("IGD_ScheduleRule_i_");
	var array_schedule_name	= config_str_multi("schRule_RuleName_");
	var schedule_cnt = 0;
	if(array_schedule_name != null) {
		schedule_cnt = array_schedule_name.length;
	}
	var sch_obj = {
		cnt:		schedule_cnt,
		inst: 		array_sch_inst,
		name:		array_schedule_name,
		allweek: 	config_str_multi("schRule_AllWeekSelected_"),
		days: 		config_str_multi("schRule_SelectedDays_"),
		allday: 	config_str_multi("schRule_AllDayChecked_"),
		timeformat: config_str_multi("schRule_TimeFormat_"),
		start_h: 	config_str_multi("schRule_StartHour_"),
		start_mi: 	config_str_multi("schRule_StartMinute_"),
		start_me: 	config_str_multi("schRule_StartMeridiem_"),
		end_h: 		config_str_multi("schRule_EndHour_"),
		end_mi: 	config_str_multi("schRule_EndMinute_"),
		end_me: 	config_str_multi("schRule_EndMeridiem_")
	};	
	
	//get each policy detail
	if (acPoListInst != null) {
		param.arg = 'ccp_act=get&num_inst='+(2*acPoListInst.length);
		for (var i=0; i<acPoListInst.length; i++) {
			//replace the first 0 to (i+1)
			var inst = new String(acPoListInst[i]).replace(/,/g, '.');	
			param.arg += '&oid_'+(i*2+1)+'=IGD_AccessControl_PolicyList_i_MachineList_i_&inst_'+(i*2+1)+'='+inst +
						'&oid_'+(i*2+2)+'=IGD_AccessControl_PolicyList_i_PortFilterRule_i_&inst_'+(i*2+2)+'='+inst;
		}
		get_config_obj(param);
	}
	//IGD_AccessControl_PolicyList_i_MachineList_i_
	var acPoMachInst	= config_inst_multi("IGD_AccessControl_PolicyList_i_MachineList_i_");
	var acPoMachAddrType= config_str_multi('machineList_AddressType_');
	var acPoMachAddr	= config_str_multi('machineList_Address_');
	
	//IGD_AccessControl_PolicyList_i_PortFilterRule_i_
	var acPoPortInst	= config_inst_multi("IGD_AccessControl_PolicyList_i_PortFilterRule_i_");
	var acPoPortEnable	= config_str_multi('portFilterRule_Enable_');
	var acPoPortName	= config_str_multi('portFilterRule_Name_');
	var acPoPortProtocol= config_str_multi('portFilterRule_Protocol_');
	var acPoPortDstIPs	= config_str_multi('portFilterRule_DestIPStart_');
	var acPoPortDstIPe	= config_str_multi('portFilterRule_DestIPEnd_');
	var acPoPortDstPorts= config_str_multi('portFilterRule_DestPortStart_');
	var acPoPortDstPorte= config_str_multi('portFilterRule_DestPortEnd_');
	
	/* function declaration for all */
	function add_option(cnt, arrInst, arrName)
	{
		if (cnt == null)
			return;

		for (var i = 0; i < cnt; i++){		
			var inst = inst_array_to_string(arrInst[i]);
			document.write("<option value=" + inst.charAt(1) + ">" + arrName[i] + "</option>");
		}	
	}

	function toggle_page(id)
	{
		pPage = id;
		for (var i=1; i<=total_page; i++) {
			var p = '#page'+i;
			if (id == i)
				$(p).show();
			else
				$(p).hide();
		}
		
		// edit policy
		switch (id) {
		case 1:
			editRow = -1;
			break;
		case 6:
			if (editRow == -1)
				$('#p'+id+'_save').attr('disabled', 'disabled');
			else
				$('#p'+id+'_save').attr('disabled', '');
			p6_methodOnClick();
			break;
		case 7:
			if (editRow != -1 || !$('#p6_url_filter').attr('checked')) {
				$('#p'+id+'_save').attr('disabled', '');
				break;
			}
			$('#p'+id+'_save').attr('disabled', 'disabled');
			break;
		case 8:
				$('#p'+id+'_save').attr('disabled', '');
			break;
		default:
			// do nothing
			if (editRow == -1)
				$('#p'+id+'_save').attr('disabled', 'disabled');
			else
				$('#p'+id+'_save').attr('disabled', '');
			break;
		}
	}

	function getSelValue(n)
	{
		var obj = get_by_name(n)
		if (obj == null)
			return;

		for (var i=0; i<obj.length; i++) {
			if (obj[i].checked == false)
				continue;
			
			if (obj[i].value == null)
				return i;
			else
				return obj[i].value;
		}
	}

	function checkPortFilter()
	{	//20120509 silvia add poolproof
		var ip_addr_msgs = replace_msg(all_ip_addr_msg,get_words(IPv6_addrSr));
		var ip_addr_msge = replace_msg(all_ip_addr_msg,get_words(IPv6_addrEr));
			for (var j=1; j<pfRuleMax+1; j++) {
				var start_ip = $("#p7_start_ip" + j).val();
				var end_ip = $("#p7_end_ip" + j).val();
				var temp_start_ip = new addr_obj(start_ip.split("."), ip_addr_msgs, true, false);
				var temp_end_ip = new addr_obj(end_ip.split("."), ip_addr_msge, false, false, true);

				if ($('#p7_enable'+j).attr('checked') == false)
					continue;
				if ($('#p7_name'+j).val() == '')
				{
					alert(get_words(GW_WISH_RULES_NAME_INVALID));
					return false;
				}

				//confilct name
				for (var i=j+1; i<pfRuleMax+1; i++) {
					if (($('#p7_name'+i).val() == $('#p7_name'+j).val()) &&
						($('#p7_enable'+i).attr('checked') == true && $('#p7_enable'+j).attr('checked') == true)){
						alert(get_words(ac_alert_dup_name)+$('#p7_name'+(i)).val());
						return false;
					}
				}

				//check ip
				if (!check_address(temp_start_ip)) {
					return false;
				}
				if (!check_address(temp_end_ip)) {
					return false;
				}

				//chk port range
				if ( $('#p7_protocol'+ j)[0].selectedIndex >=2){
					if (!check_integer($('#p7_start_port'+j).val(), 1, 65535)) {
						alert(get_words(ac_alert_invalid_port));
						return false;
					}
					
					if (!check_integer($('#p7_end_port'+j).val(), 1, 65535)) {
						alert(get_words(ac_alert_invalid_port));
						return false;
					}

					if ($('#p7_protocol'+i).val() == $('#p7_protocol'+j).val()) {
						if ($('#p7_start_port'+i).val() == $('#p7_start_port'+j).val()) {
							alert(get_words(ac_alert_port_conflit)+$('#p7_start_port'+i).val());
							return false;
						}
						
						if ($('#p7_end_port'+i).val() == $('#p7_end_port'+j).val()){
							alert(get_words(ac_alert_port_conflit)+$('#p7_end_port'+i).val());
							return false;
						}
					}
				}
				
				if (!check_ip_order(temp_start_ip, temp_end_ip)){
					alert(get_words('TEXT039'));
					return false;
				}
			}
		return true;
	}
	
	function checkSubmitData()
	{	
		if (editRow != -1) {
			var idx = 1;
			var param = {
				url:	'get_set.ccp',
				arg:	'ccp_act=del&ccpSubEvent=CCP_SUB_ACCESSCTL'
			}
			
			if (p5MachList.length < acPoListMachNum[editRow]) {
				var machInst = new String(p1_getMachList(editRow, 'inst')).split(', ');
				for (var i=p5MachList.length; i<acPoListMachNum[editRow]; i++) {
					param.arg += '&oid_'+idx+'=IGD_AccessControl_PolicyList_i_MachineList_i_&inst_'+idx+'='+machInst[i].replace(/,/g, '.');
					idx++;
				}
			}
			
			if (($('#p6_firewall_rule').attr('checked')==false && acPoListPortFltr[editRow] == 1)) {
				for (var i=1; i<=pfRuleMax; i++) {
					var pfInst = new String(acPoListInst[editRow]).replace('0', i);
					param.arg += '&oid_'+idx+'=IGD_AccessControl_PolicyList_i_PortFilterRule_i_&inst_'+idx+'='+pfInst.replace(/,/g, '.');
					idx++;
				}
			}
			
			if ((idx-1) > 0) {
				param.arg += '&num_inst='+(idx-1);
				ajax_submit(param);
			}
		}
		return true;
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
	
	/* function declaration for page 1 */
	function p1_prepare()
	{
		if (acGlobalEnable != null && acGlobalEnable == 1)
			$('#access_enable').attr('checked', true);
		else
			$('#access_enable').attr('checked', false);

		p1_onEnable();
	}
	
	function p1_onEnable()
	{
		is_modified=1;
		if ($('#access_enable').attr('checked')){
			$('#show_policy').show();
			$('#show_table').show();
			}
		else{
			$('#show_policy').hide();
			$('#show_table').hide();
			}
	}
	
	function p1_toggleRow()
	{
		if(confirm(get_words(YM24)) == false)
			return;
	
		p1_onSubmit();
	}
	
	function p1_getMachList(idx, field) 
	{
		var machList = '';
		var added = false;
		if (acPoMachInst == null)
			return machList;

		for (var i=0; i<acPoMachInst.length; i++) {
			var instPrefixPoList = new String(acPoListInst[idx]).substr(0, 6);
			var instPrefixPoMach = new String(acPoMachInst[i]).substr(0, 6);
			
			if (instPrefixPoList != instPrefixPoMach) {
				if (added)
					break;
				else
					continue;
			}
			
			
			added = true;
			if (machList != '')
				machList += ', ';
			
			if (field == 'inst')
				machList += acPoMachInst[i];
			else if (field == 'addr')
				machList += acPoMachAddr[i];
			else if (field == 'type')
				machList += acPoMachAddrType[i];
		}
		
		return machList;
	}
	
	function p1_getFilter(idx)
	{
		if (acPoListMethod[idx] == '0') {
			return get_words(_aa_allow_all);
		} else if (acPoListMethod[idx] == '1') {
			return get_words(_aa_block_all);
		} else if (acPoListMethod[idx] == '2') {
			return get_words(_aa_block_some);
		}
	}

	function p1_schDetail(idx)
	{
		// always or never
		var sch = acPoListSchIdx[idx];
		if (sch == '255') {
			return get_words(_always);
		} else if (sch == '254') {
			return get_words(_never);
		}
		
		// otherwise
		for (var i=0; i<sch_obj.cnt; i++) {
			var bit2 = new String(sch_obj.inst[i]).substr(2, 1);
			if (bit2 == acPoListSchIdx[idx])
				return p4_schDetail(i, sch_obj);
		}
		
		return "";
	}
	
	function p1_delRow(idx) 
	{
		if(dev_info.login_info != "w")
			return;
			
		if(confirm(get_words(up_ae_de_1)) == false)
			return;
			
		is_modified =1;
		var oid_idx = 1;
		var inst = new String(acPoListInst[idx]).replace(/,/g, '.')
		var p = {
			url:	'get_set.ccp',
			arg:	'ccp_act=del'+
					'&ccpSubEvent=CCP_SUB_ACCESSCTL&nextPage=adv_access_control.asp'
		};
		
		// delete IGD_AccessControl_PolicyList_i_MachineList_i_
		var machInst = new String(p1_getMachList(idx, 'inst')).split(', ');
		var numMach  = 0;
		if (machInst != null || machInst != '') {
			numMach = machInst.length;
			for (var i=0; i<machInst.length; i++) {
				p.arg += '&oid_'+oid_idx+'=IGD_AccessControl_PolicyList_i_MachineList_i_&inst_'+oid_idx+'='+new String(machInst[i]).replace(/,/g, '.');
				oid_idx++;
			}
		}
		
		// delete IGD_AccessControl_PolicyList_i_PortFilterRule_i_
		for (var i=1; i<=pfRuleMax; i++) {
			if (acPoPortInst == null)
				break;
			p.arg += '&oid_'+oid_idx+'=IGD_AccessControl_PolicyList_i_PortFilterRule_i_&inst_'+oid_idx+'='+new String(acPoListInst[idx]).replace(/,/g, '.').replace('.0', '.'+i);
			oid_idx++;
		}
		
		// delete IGD_AccessControl_PolicyList_i_
		p.arg += '&oid_'+oid_idx+'=IGD_AccessControl_PolicyList_i_&inst_'+oid_idx+'='+inst;
		oid_idx++;
		
		p.arg += '&num_inst='+(oid_idx-1);
		get_config_obj(p);
	}
	
	function p1_editRow(idx)
	{
		if(dev_info.login_info != "w")
			return;
			
		editRow = idx;
		toggle_page(3);
		p3_prepare();
		p4_prepare();
		p5_prepare();
		p6_prepare();
		p7_prepare();
		p8_prepare();
	}

	function p1_onSubmit()
	{
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return;
		}
		
		var param = {
			'url':	'get_set.ccp',
			'arg':	'ccp_act=set'
		};
		
		param.arg += '&ccpSubEvent=CCP_SUB_ACCESSCTL&nextPage=adv_access_control.asp'+
					'&accessCtrl_GlobalEnable_1.1.0.0.0='+($('#access_enable').attr('checked')? '1': '0');
		
		if(acPoListInst != null && acPoListInst != '') {
			for (var i=0; i<acPoListInst.length; i++) {
				var inst = new String(acPoListInst[i]).replace(/,/g, '.');
				var chkd = $('#enable'+i).attr('checked')? '1': '0';
				param.arg += '&accessPolicy_Enable_'+inst+'='+chkd;
			}
		}
		get_config_obj(param);
	}
	
	/* function declaration for page 2 */
	/* function declaration for page 3 */
	function p3_prepare()
	{
		if (((editPageLoad >> 3) & 1) == 1) 	//if this page is loaded
			return;
			
		$('#p3_name').val(acPoListName[editRow]);
		editPageLoad |= (1 << 3);
	}
	
	function p3_checkName_togglePage()
	{
		// check rule name
		if ($('#p3_name').val() == '') {
			alert(get_words(aa_alert_9));
			toggle_page(3);
			return;
		}
		if (acPoListName == null) {
			toggle_page(4);
			return;
		}

		// check duplicated rule name
		for (var i=0; i<acPoListName.length; i++) {
			if (i == editRow)
				continue;

			if ($('#p3_name').val() == acPoListName[i]) {
				alert(get_words(aa_alert_8));
				return false;
			}
		}
		
		toggle_page(4);
	}
	
	/* function declaration for page 4 */
	function p4_prepare()
	{
		if (((editPageLoad >> 4) & 1) == 1) 	//if this page is loaded
			return;
			
		$('#p4_schedule').val(acPoListSchIdx[editRow]);
		p4_onSchClick();
		
		editPageLoad |= (1 << 4);
	}
	
	function p4_schDetail(idx, obj)
	{
		var s = '';
		var s_day = "", count = 0;
		var s_time = '';
		var e_time = '';
		var days = obj.days[idx];
		
		for(var i=0; i < 8; i++){
			if(obj.days[idx].charAt(i) == "1"){
				s_day = s_day + " " + Week[i];
				count++;
			}
		}
		
		if(count == 7 || obj.allweek[idx] == 1){
			s_day = "All week";
		}
		
		/*	//currently, we stored 24-hr format
		if (obj.start_me[idx] == 1)
			s_time = parseInt(obj.start_h[idx]) + 12;
		else
		*/
			s_time = obj.start_h[idx];
		s_time = s_time + ':' + (parseInt(obj.start_mi[idx])<10? '0'+obj.start_mi[idx] : obj.start_mi[idx] );
		
		/* //currently, we stored 24-hr format
		if (obj.end_me[idx] == 1)
			e_time = parseInt(obj.end_h[idx]) + 12;
		else
		*/
			e_time = obj.end_h[idx];
		e_time = e_time + ':' + (parseInt(obj.end_mi[idx])<10? '0'+obj.end_mi[idx] : obj.end_mi[idx] );
		
		var temp_time_array = s_time + "~" + e_time;
		if(obj.allday[idx] == 1 || s_time == e_time ){
			temp_time_array = "All Day";
		}
		
		s = s_day + " " + temp_time_array;
		return s;		
	}
	
	function p4_onSchClick()
	{
		var schedule = get_by_id("p4_schedule");
		
		if(schedule.value == "-1"){
			if (confirm(get_words(aa_sched_conf_1)+"\n"+
				get_words(aa_sched_conf_2)+"\n"+get_words(up_ae_wic_3))){
				window.location.href = "tools_schedules.asp";
			}
			else{
				set_selectIndex(255,get_by_id("p4_schedule"));
				get_by_id("p4_detail").value = schedule[schedule.selectedIndex].text;
			}
		}else if(schedule.selectedIndex < 2){
			get_by_id("p4_detail").value = schedule[schedule.selectedIndex].text;
		}else if(schedule.selectedIndex > 1){
			var idx = parseInt(schedule.selectedIndex) - 2;
			get_by_id("p4_detail").value = p4_schDetail(idx, sch_obj);
		}
	}
	
	/* function declaration for page 5 */
	var p5_editRow = -1;
	function p5_prepare()
	{
		if (((editPageLoad >> 5) & 1) == 1) 	//if this page is loaded
			return;

		p5MachList = null;
		var inst = new String(p1_getMachList(editRow, 'inst')).split(', ');
		var type = new String(p1_getMachList(editRow, 'type')).split(', ');
		var addr = new String(p1_getMachList(editRow, 'addr')).split(', ');
		if (type == null || type == '')
			return;
			
		for (var i=0; i<type.length; i++) {
			 p5_updateData(type[i], addr[i], inst[i]);
		}
		
		p5_onClear();
		
		editPageLoad |= (1 << 5);
	}
	
	function p5_checkDevice_togglePage()
	{
		// check machine list
		if (p5MachList == null || p5MachList.length == 0) {
			alert(get_words(ac_alert_choose_dev));
			toggle_page(5);
			return false;
		}
		toggle_page(6);
	}
	
	function p5_typeOnClick()
	{
		var type = get_by_name("p5_type");
		get_by_id("p5_ip").disabled = !type[0].checked || type[2].checked;
		get_by_id("p5_ip_list").disabled = !type[0].checked || type[2].checked;
		get_by_id("p5_mac").disabled = !type[1].checked || type[2].checked;
		get_by_id("p5_mac_list").disabled = !type[1].checked || type[2].checked;
		get_by_id("p5_clone").disabled = !type[1].checked || type[2].checked;
	}
	
	function p5_selOnChange(obj, type)
	{
		if(obj.value != -1)
			get_by_id("p5_"+type).value = obj.value;
		else
			get_by_id("p5_"+type).value = "";
	}
	
	function p5_macCloneOnClick()
	{
		get_by_id("p5_mac").value = dev_info.cli_mac;
	}
	
	function p5_checkDuplicate(s)
	{
		if (p5MachList == null)
			return true;

		for (var i=0; i<p5MachList.length; i++) {
			if (s.toLowerCase() == p5MachList[i].machine.toLowerCase()) {
				alert(get_words(aa_alert_7));
				return false;
			}
		}
		
		return true;
	}
	
	function p5_verifyIP()
	{
		var ip 		= get_by_id("p5_ip").value;
		var lan_ip 	= '';
		var mask 	= '';

		var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words(help256));
		var obj_ip 		= new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var obj_lan 	= new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		var obj_mask 	= new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		if (!check_address(obj_ip, obj_mask, obj_lan)){
			return false;
		}
		
		//check dhcp ip range equal to lan-ip or not?
		if(!check_LAN_ip(obj_lan.addr, obj_ip.addr, get_words(help256))){
				return false;
		}
		
		if(!check_domain(obj_lan, obj_mask, obj_ip)){
			//alert(ip + " -- IP Address should be in LAN subnet.");
			alert(ip + " -- "+get_words(_ipaddr) + get_words(aa_alert_12));
			return false;
		}
		
		//check if this ip is duplicated.
		if(!p5_checkDuplicate(ip)){
			return false;
		}	
		
		return true;
	}
	
	function p5_verifyMAC()
	{
		var mac = get_by_id("p5_mac").value;
		var lan_mac = '';
		if (!check_mac(mac)){
			alert(get_words(LS47));
			return false;
		}
		
		if (mac.toLowerCase() == lan_mac.toLowerCase()){
			alert(get_words(LS47));
			return false;
		}
		
		if(!p5_checkDuplicate(mac)){
			return false;
		}
		
		return true;
	}
	
	function p5_setRow(idx)
	{
		var oTr;
		var oTd1;
		var oTd2;
		var oTd3;
		if (p5_editRow == -1) {	//add
			oTr = get_by_id("p5_table1").insertRow(-1);
			oTd1 = oTr.insertCell(-1);
			oTd2 = oTr.insertCell(-1);
			oTd3 = oTr.insertCell(-1);
		} else {			//edit
			oTr = get_by_id("p5_table1").rows[idx+1];
			oTd3 = oTr.cells[2];
			oTd2 = oTr.cells[1];
			oTd1 = oTr.cells[0];
		}
		oTd1.innerHTML = (p5MachList[idx].machine == '_aa_other_machines')? get_words(p5MachList[idx].machine) : p5MachList[idx].machine;
		//oTd1.innerHTML = get_words(p5MachList[idx].machine);
		oTd2.innerHTML = "<a href=\"javascript:p5_onEdit("+ p5MachList[idx].uId +")\"><img src=\"edit.jpg\" border=\"0\" title=\""+get_words('_edit')+"\"></a>";
		oTd3.innerHTML = "<a href=\"javascript:p5_onDel("+ p5MachList[idx].uId +")\"><img src=\"delete.jpg\"  border=\"0\" title=\""+get_words('_delete')+"\"></a>";
	}
	
	function p5_uniqid()
	{
		var newDate = new Date;
		return newDate.getTime()+(Math.random()*10000);
	}

	function p5_findRow(uid) 
	{
		for (var i=0; i<p5MachList.length; i++) {
			if (p5MachList[i].uId == uid)
				return i;
		}
		
		return -1;
	}
		
	function p5_updateData(type, machine, inst)
	{
		//add
		var len = 0;
		if (p5_editRow == -1) {
			len = (p5MachList == null? 0: p5MachList.length);
			if (p5MachList == null)
				p5MachList = new Array();
			else
				p5MachList[len] = new Array();
		} else {
			len = p5_editRow;
		}
		
		p5MachList[len] = {
			'uId':		p5_uniqid(),
			'inst':		inst,
			'type':		type,
			'machine':	machine
		};
		p5_setRow(len);
		p5_onClear();
	}
	
	function p5_onDel(uid)
	{
		if(confirm(get_words(up_ae_de_1)) == false)
			return;

		var idx = p5_findRow(uid);
		get_by_id('p5_table1').deleteRow(idx+1);
		p5MachList.splice(idx, 1);
		p5_onClear();
	}
	
	function p5_onEdit(uId)
	{
		p5_editRow = p5_findRow(uId);
		get_by_name('p5_type')[p5MachList[p5_editRow].type].checked = true;
		if (p5MachList[p5_editRow].type == 0) {
			get_by_id('p5_ip').value = p5MachList[p5_editRow].machine;
			get_by_id('p5_mac').value = '';
		} else if (p5MachList[p5_editRow].type == 1) {
			get_by_id('p5_ip').value = '';
			get_by_id('p5_mac').value = p5MachList[p5_editRow].machine;
		} else {
			get_by_id('p5_ip').value = '';
			get_by_id('p5_mac').value = '';
		}
		p5_typeOnClick();
	}
	
	function p5_onOk()
	{
		var type = get_by_name("p5_type");
		var c_type = '';
		var machine = '';
		
		if(type[0].checked){			// IP
			if (p5_verifyIP() == false)
				return;
			c_type = '0';
			machine = get_by_id("p5_ip").value;
		} else if (type[1].checked) {	// MAC
			if (p5_verifyMAC() == false)
				return;
			c_type = '1';
			machine = get_by_id("p5_mac").value;
		} else if (type[2].checked) {	// Other
			if(!p5_checkDuplicate('_aa_other_machines')){
				return;
			}
			c_type = '2';
			machine = '_aa_other_machines';
		}

		// add/update data model
		p5_updateData(c_type, machine, null);
	}
	
	function p5_onClear()
	{
		p5_editRow = -1;
		get_by_name("p5_type")[0].checked = true;
		get_by_id("p5_ip").value = "";
		get_by_id("p5_mac").value = "";
		get_by_id("p5_ip_list").selectedIndex = 0;
		get_by_id("p5_mac_list").selectedIndex = 0;
		get_by_id("p5_edit").value = "-1";
		p5_typeOnClick();
	}
	
	/* function declaration for page 6 */
	function p6_prepare()
	{
		if (((editPageLoad >> 6) & 1) == 1) 	//if this page is loaded
			return;
		
		$('input:radio[name="p6_method"]').filter('[value="'+ acPoListMethod[editRow] +'"]').attr('checked', true);
		$('#p6_url_filter').attr('checked', (acPoListWebFltr[editRow]=='1'? true: false));
		$('#p6_firewall_rule').attr('checked', (acPoListPortFltr[editRow]=='1'? true: false));
		p6_methodOnClick();

		editPageLoad |= (1 << 6);
	}
	
	function p6_methodOnClick()
	{
		get_by_id("p6_show_filter").style.display = "none";
		get_by_id("p6_next").disabled = !get_by_name("p6_method")[2].checked;
		get_by_id("p6_save").disabled = get_by_name("p6_method")[2].checked;
		if(get_by_name("p6_method")[2].checked){
			get_by_id("p6_show_filter").style.display = "";
		} else {
			$('#p6_url_filter').attr('checked', false);
			$('#p6_firewall_rule').attr('checked', false);
		}
	}
	
	function p6_chkbox() 
	{
		if (editRow == -1)
			return; 
			
		if(get_by_id("p6_firewall_rule").checked == false &&
			get_by_id("p6_url_filter").checked == false){
			get_by_id('p6_save').disabled = true;
		}
	}
	
	function p6_onNext()
	{
		if(get_by_name("p6_method")[2].checked){
			if(get_by_id("p6_firewall_rule").checked){
				toggle_page(7);
			} else if(get_by_id("p6_url_filter").checked){
				toggle_page(8);
			} else {
				alert(get_words(GW_INET_ACL_NO_FILTER_SELECTED_INVALID));
			}
			get_by_id('p7_next').disabled = !get_by_id("p6_url_filter").checked;
		}
	}
	
	function p6_onSave() 
	{
		p8_onSave();
	}
	
	/* function declaration for page 7 */
	function p7_prepare()
	{
		if (((editPageLoad >> 7) & 1) == 1) 	//if this page is loaded
			return;
		
		get_by_id('p7_next').disabled = get_by_id("p6_url_filter").checked;
		
		p7_fillRules();
		
		editPageLoad |= (1 << 7);
	}
	
	function p7_checkFilter_togglePage(chk)
	{
		// check port filter
		if ($('#p6_firewall_rule').attr('checked')==true) {
			if (checkPortFilter() == false){
				toggle_page(7);
				return false;
			}
		}
		//chk: 0=Next 1=Save
		if(chk==0)
			p7_onNext();
		else if(chk==1)
			p8_onSave();
	}
	
	function p7_fillRules()
	{
		if (acPoPortInst == null || acPoPortInst == '')
			return;

		var cnt = 0;
		for (var i=0; i<=acPoPortInst.length; i++)
		{
			if (cnt >= pfRuleMax)
				break;
				
			var inst_prefix = new String(acPoListInst[editRow]).substr(0, 6);
			var inst_prePf  = new String(acPoPortInst[i]).substr(0, 6);
			
			if (inst_prefix != inst_prePf)
				continue;
				
			cnt++;
				
			if (acPoPortEnable[i] == '1')
				$('#p7_enable'+cnt).attr('checked', true);
			else
				$('#p7_enable'+cnt).attr('checked', false);
			$('#p7_name'+cnt).val(acPoPortName[i]);
			$('#p7_protocol'+cnt).val(acPoPortProtocol[i]);
			$('#p7_start_ip'+cnt).val(acPoPortDstIPs[i]);
			$('#p7_end_ip'+cnt).val(acPoPortDstIPe[i]);
			$('#p7_start_port'+cnt).val(acPoPortDstPorts[i]);
			$('#p7_end_port'+cnt).val(acPoPortDstPorte[i]);
			p7_protoOnChange(cnt);
		}
	}

	function p7_protoOnChange(idx)
	{
		var protocol = get_by_id("p7_protocol" + idx).selectedIndex;
		get_by_id("p7_start_port" + idx).disabled = (protocol < 2);
		get_by_id("p7_end_port" + idx).disabled = (protocol < 2);
		if(get_by_id("p7_protocol" + idx).selectedIndex == 1){
			get_by_id("p7_start_port" + idx).value = 0;
			get_by_id("p7_end_port" + idx).value = 65535;
		}
	}
	
	function p7_onNext()
	{
		if(get_by_id("p6_firewall_rule").checked){
			toggle_page(8);
		} else {
			toggle_page(6);
		}
	
	}
	
	/* function declaration for page 8 */
	function p8_prepare()
	{
		if (((editPageLoad >> 8) & 1) == 1) 	//if this page is loaded
			return;
		
		if (acPoListWebLog[editRow] == '1')
			$('input:radio[name="p8_log"]').filter('[value=1]').attr('checked', true);
		else
			$('input:radio[name="p8_log"]').filter('[value=0]').attr('checked', true);

		editPageLoad |= (1 << 8);
	}
	
	function p8_onPrev()
	{
		if(get_by_id("p6_firewall_rule").checked){
			toggle_page(7);
		} else {
			toggle_page(6);
		}
	}
	
	function p8_onSubmit(inst)
	{
		var weblog_en = 0;
		
		if (getSelValue('p6_method')==0 || $('input[name=p8_log]:checked').val()==1)
			weblog_en = 1;

		// 20131018 Silvester 
		// change the way of saving rule into rule list
		// should be appending, not inserting 
		
		// 20131113 Silvester
		// remove ajax for 'delete all' because of the time out issue
		// replace ccp_act from 'set' to 'set_acctl'
		// c code will delete all before appending 
		
		/*
		// Clear all rules in datamodel	
		// if append new
		if(editRow == -1){
			var oid_idx = 1;
			var del_param = {
				url:	'get_set.ccp',
				arg:	''
			};
			del_param.arg = 'ccp_act=del&ccpSubEvent=CCP_SUB_ACCESSCTL';

			// delete all IGD_AccessControl_PolicyList_i_
			if(acPoListInst != null && acPoListInst != ''){
				$.each(acPoListInst, function(index, value){
					del_param.arg += '&oid_'+ oid_idx + '=IGD_AccessControl_PolicyList_i_&inst_'  + oid_idx + '=' + value.join('.');
					oid_idx++;
				});
			}

			// delete all IGD_AccessControl_PolicyList_i_MachineList_i_
			if(acPoMachInst != null && acPoMachInst != ''){
				$.each(acPoMachInst, function(index, value){
					del_param.arg += '&oid_'+ oid_idx + '=IGD_AccessControl_PolicyList_i_MachineList_i_&inst_'  + oid_idx + '=' + value.join('.');
					oid_idx++;
				});
			}

			// delete all IGD_AccessControl_PolicyList_i_PortFilterRule_i_
			if(acPoPortInst != null && acPoPortInst != ''){
				$.each(acPoPortInst, function(index, value){
					del_param.arg += '&oid_'+ oid_idx + '=IGD_AccessControl_PolicyList_i_PortFilterRule_i_&inst_'  + oid_idx + '=' + value.join('.');
					oid_idx++;
				});
			}

			del_param.arg += '&num_inst=' + oid_idx;
			ajax_submit_new(del_param, false);
		}
		*/

		// Append all old rules and the new one by sequence
		
		var param = {
			url:	'get_set.ccp',
			arg:	''
		};
		param.arg = 'ccp_act=set_acctl&ccpSubEvent=CCP_SUB_ACCESSCTL&nextPage=adv_access_control.asp';
		param.arg += '&accessCtrl_GlobalEnable_1.1.0.0.0='+($('#access_enable').attr('checked')? '1': '0');

		// Old rules

		var next_inst = 1;
		var inst = inst || '';

		if(editRow == -1 && acPoListInst != null && acPoListInst != ''){
			$.each(acPoListInst, function(index, value){
				inst = '1.1.' + next_inst + '.0.0';
				var cnt = value[2];

				//IGD_AccessControl_PolicyList_i_
				param.arg += '&accessPolicy_Enable_' + inst + '=' + acPoListEnable[index];
				param.arg += '&accessPolicy_Name_' + inst + '=' + acPoListName[index];
				param.arg += '&accessPolicy_ScheduleIndex_' + inst + '=' + acPoListSchIdx[index];
				param.arg += '&accessPolicy_SelectedMachines_' + inst + '=' + acPoListSelMach[index];
				param.arg += '&accessPolicy_Method_' + inst + '=' + acPoListMethod[index];
				param.arg += '&accessPolicy_ApplyWebFilter_' + inst + '=' + acPoListWebFltr[index];
				param.arg += '&accessPolicy_EnableWebLog_' + inst + '=' + acPoListWebLog[index];
				param.arg += '&accessPolicy_ApplyAdvPortFilter_' + inst + '=' + acPoListPortFltr[index];

				//IGD_AccessControl_PolicyList_i_MachineList_i_
				if(acPoMachInst != null && acPoMachInst != ''){
					var m_idx = 0;
					$.each(acPoMachInst, function(idx, val){
						if(val[2] == cnt){
							m_idx = m_idx + 1;
							var machInst = inst.replace('.0', '.' + m_idx);
							param.arg += '&machineList_AddressType_' + machInst + '=' + acPoMachAddrType[idx];
							param.arg += '&machineList_Address_' + machInst + '=' + acPoMachAddr[idx];
						}
						else
							m_idx = 0;
					});
				}

				//IGD_AccessControl_PolicyList_i_PortFilterRule_i_
				if(acPoPortInst != null && acPoPortInst != ''){
					var p_idx = 0;
					$.each(acPoPortInst, function(idx, val){
						if(val[2] == cnt){
							if(p_idx > 8)
								p_idx = 0;
							else
								p_idx = p_idx + 1;
							var pfInst = inst.replace('.0', '.' + p_idx);
							param.arg += '&portFilterRule_Enable_' + pfInst + '=' + acPoPortEnable[idx];
							param.arg += '&portFilterRule_Name_' + pfInst + '=' + acPoPortName[idx];
							param.arg += '&portFilterRule_Protocol_' + pfInst + '=' + acPoPortProtocol[idx];
							param.arg += '&portFilterRule_DestIPStart_' + pfInst + '=' + acPoPortDstIPs[idx];
							param.arg += '&portFilterRule_DestIPEnd_' + pfInst + '=' + acPoPortDstIPe[idx];
							param.arg += '&portFilterRule_DestPortStart_' + pfInst + '=' + acPoPortDstPorts[idx];
							param.arg += '&portFilterRule_DestPortEnd_' + pfInst + '=' + acPoPortDstPorte[idx];
						}
					});
				}

				next_inst++;
			});
		}
		
		// New rule

		//IGD_AccessControl_PolicyList_i_
		if (editRow == -1){	//add
			inst = '1.1.' + next_inst + '.0.0';
			param.arg += '&accessPolicy_Enable_'+inst+'=1';
		}	
		else{				//edit
			inst = inst.join('.');
			param.arg = 'ccp_act=set&ccpSubEvent=CCP_SUB_ACCESSCTL&nextPage=adv_access_control.asp';
			param.arg += '&accessCtrl_GlobalEnable_1.1.0.0.0='+($('#access_enable').attr('checked')? '1': '0');
			param.arg += '&accessPolicy_Enable_'+inst+'='+($('#access_enable').attr('checked')? '1' : '0');
		}				

		param.arg += '&accessPolicy_Name_'+inst+'='+urlencode($('#p3_name').val());
		param.arg += '&accessPolicy_ScheduleIndex_'+inst+'='+$('#p4_schedule').val();
		param.arg += '&accessPolicy_SelectedMachines_'+inst+'=0';
		param.arg += '&accessPolicy_Method_'+inst+'='+getSelValue('p6_method');
		param.arg += '&accessPolicy_ApplyWebFilter_'+inst+'='+($('#p6_url_filter').attr('checked')? '1' : '0') ;
		param.arg += '&accessPolicy_EnableWebLog_'+inst+'='+weblog_en;
		param.arg += '&accessPolicy_ApplyAdvPortFilter_'+inst+'='+($('#p6_firewall_rule').attr('checked')? '1' : '0');
	
		//IGD_AccessControl_PolicyList_i_MachineList_i_
		for (var i=0; i<p5MachList.length; i++) {
			var machInst = new String(inst).replace('.0', '.'+(i+1));
			
			param.arg += '&machineList_AddressType_'+machInst+'='+p5MachList[i].type;
			param.arg += '&machineList_Address_'+machInst+'='+p5MachList[i].machine;
		}
		
		//IGD_AccessControl_PolicyList_i_PortFilterRule_i_
		if ($('#p6_firewall_rule').attr('checked') == true) {
			for (var i=1; i<=pfRuleMax; i++) {
				var pfInst = new String(inst).replace('.0', '.' + i);
				param.arg += '&portFilterRule_Enable_'+pfInst+'='+($('#p7_enable'+i).attr('checked')? '1' : '0');
				param.arg += '&portFilterRule_Name_'+pfInst+'='+$('#p7_name'+i).val();
				param.arg += '&portFilterRule_Protocol_'+pfInst+'='+$('#p7_protocol'+i).val();
				param.arg += '&portFilterRule_DestIPStart_'+pfInst+'='+$('#p7_start_ip'+i).val();
				param.arg += '&portFilterRule_DestIPEnd_'+pfInst+'='+$('#p7_end_ip'+i).val();
				param.arg += '&portFilterRule_DestPortStart_'+pfInst+'='+$('#p7_start_port'+i).val();
				param.arg += '&portFilterRule_DestPortEnd_'+pfInst+'='+$('#p7_end_port'+i).val();
			}
		}
		get_config_obj(param);
	}
	
	function p8_onEdit()
	{
		p8_onSubmit(acPoListInst[editRow]);
	}
	
	function p8_onSave()
	{
		if (checkSubmitData() == false)
			return;
		
		/* edit policy */
		if (editRow != -1) {
			p8_onEdit();
			return;
		}
		
		/* add a new policy */
		/*
		var param = {
			url:	'get_set.ccp',
			arg:	'ccp_act=queryInst&num_inst=1'+
					'&oid_1=IGD_AccessControl_PolicyList_i_&inst_1=11000'
		};
		get_config_obj(param);
		
		inst = config_val('newInst');	
		*/

		p8_onSubmit();
	}

	
	$(document).ready( function () {
		// toggle all page
		toggle_page(1);
		
		if (acPoListInst != null && acPoListInst.length >= maxACRule) {
			$('#add_policy').attr('disabled', 'disabled');
		}
		
		
		// prepare page 1
		p1_prepare();
		
		if(dev_info.login_info != "w" /*|| dev_mode == "1"*/){
			DisableEnableForm(form1,true);	
		}
		
		set_form_default_values("form1");
	});
	
	function check_modified()
	{
		if ((is_modified==1) && is_form_modified("form1") && confirm (which_lang[up_fm_dc_1]))
			window.location.href='adv_access_control.asp';
	}
</script>

<title></title>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<!-- dlink header -->
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
<!-- end of dlink header -->

<!-- top menu -->
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td height="29"><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
<!-- end of top menu -->

<!-- main content -->
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF"><tr>
	<!-- left menu -->
	<td id="sidenav_container" valign="top" width="125" align="right">
	<table cellSpacing=0 cellPadding=0 border=0>
	<tr>
		<td id="sidenav_container">
		<div id="sidenav">
			<UL>
						  <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_acccon)</script></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <!--<LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI>-->
							<LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>							
							<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
		</div>
		</td>
	</tr>
	</table>
	</td>
	<!-- end of left menu -->
	<td valign="top" id="maincontent_container">
	<div id="maincontent">
	<!--####################################-->
	<!--#########    main part    ##########-->
	<!--####################################-->
		<form id="form1" name="form1" method="post" action="">

		<!--########-->
		<!-- page 1 -->
		<div id="page1">
			<div id="box_header"> 
				<h1><script>show_words(_acccon)</script></h1>
				<script>show_words(aa_intro)</script>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="p1_onSubmit()">
				<input name="button2" id="button2"type="button" class=button_submit value="" onclick="check_modified()">
				<script>get_by_id("button").value = get_words(_savesettings);</script>
				<script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
			</div>

			<div class=box> 
				<h2><script>show_words(_acccon)</script></h2>
				<table width="525">
				<tr> 
					<td class="duple"><script>show_words(aa_EAC)</script>:</td>
					<td width="340">&nbsp;<input type=checkbox id="access_enable" name="access_enable" value="enable" onClick="p1_onEnable();"></td>
				</tr>
				<tr id="show_policy" style="display:none">
					<td class="duple">&nbsp;</td>
					<td width="340">&nbsp;
						<input name="add_policy" id="add_policy" type=button class=button_submit value="" onclick="toggle_page(2);">
						<script>get_by_id("add_policy").value = get_words(_aa_pol_add);</script>
					</td>
				</tr>
				</table>
			</div>
				  
			<div class=box id="show_table"> 
				<h2><script>show_words(aa_Policy_Table)</script></h2>
				<table width="525" id="table1" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
				<tr> 
					<td width="20"><strong><script>show_words(_enable)</script></strong></td> 
					<td width="80"><strong><script>show_words(aa_ACR_c2)</script></strong></td> 
					<td width="130"><strong><script>show_words(aa_Machine)</script></strong></td> 
					<td width="120"><strong><script>show_words(aa_ACR_c5)</script></strong></td> 
					<td width="50"><strong><script>show_words(aa_ACR_c6)</script></strong></td> 
					<td width="80"><strong><script>show_words(_sched)</script></strong></td> 
					<td>&nbsp;</td>  
					<td>&nbsp;</td>   
				</tr>
				<script>
					if (acPoListEnable != null) {
						for (var i=0; i<acPoListEnable.length; i++) {
							var is_enable = '';
							var filter = '';
							var logged = '_no';
							var str_machine='';
							var tmp_machine='';
							
							if (acPoListEnable[i] == '1')
								is_enable = 'checked';
							if (acPoListWebLog[i] == '1')
								logged = '_yes';
							tmp_machine= p1_getMachList(i, 'addr').split(", ");
							for(var j=0; j<tmp_machine.length; j++)
							{
								str_machine += (tmp_machine[j] == '_aa_other_machines')? get_words('_aa_other_machines'):tmp_machine[j];
								if(j!=tmp_machine.length-1)
									str_machine += ", ";
								
							}
							document.write("<tr>" +
								"<td><input type=checkbox id=enable" + i + " name=enable" + i + " " + is_enable + " onclick=\"p1_toggleRow()\"></td>"+
								"<td>"+sp_words(acPoListName[i])+"&nbsp;</td>"+
								"<td>" + str_machine +"&nbsp;</td>"+
								"<td>"+ p1_getFilter(i) +"&nbsp;</td>"+
								"<td>"+ get_words(logged) +"&nbsp;</td>"+
								"<td>"+ p1_schDetail(i) +"&nbsp;</td>"+
								"<td><a href=\"javascript:p1_editRow("+ i +")\"><img src=\"edit.jpg\" border=\"0\" title=\""+get_words('_edit')+"\"></a></td>"+
								"<td><a href=\"javascript:p1_delRow(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" title=\""+get_words('_delete')+"\"></a></td>"+
								//"<td><img src=\"edit.jpg\" border=\"0\" alt=\"edit\" onclick=p1_editRow("+ i +")></a></td>"+
								//"<td><img src=\"delete.jpg\" border=\"0\" alt=\"delete\" onclick=p1_delRow("+ i +")></a></td>"+								
								"</tr>");
						}
					}
				</script>
				</table>
			</div>
		</div>
		<!-- end of page 1 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 2 -->
		<div id="page2">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s1_title)</script></h2>
				<P class="box_msg"><script>show_words(_aa_wiz_s1_msg)</script></P>
				<table width="525" class=formarea>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg1)</script></td>
				</tr>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg2)</script></td>
				</tr>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg3)</script></td>
				</tr>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg4)</script></td>
				</tr>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg5)</script></td>
				</tr>
				<tr>
					<td><script>show_words(aa_wiz_s1_msg6)</script></td>
				</tr>
				</table><hr>
				
				<table width="362" align="center">
				<tr>
					<td>
					<div align="center"> 
						<input name="prev" type="button" id="p2_prev" value="" disabled>&nbsp; 
						<input name="next" type="button" id="p2_next" value="" onclick="toggle_page(3)">&nbsp; 
						<input name="save" type="button" id="p2_save" value="" disabled>&nbsp; 
						<input name="cancel" type="button" id="p2_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p2_prev").value = get_words(_prev);
							get_by_id("p2_next").value = get_words(_next);
							get_by_id("p2_save").value = get_words(_save);
							get_by_id("p2_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
			</div>
		</div>
		<!-- end of page 2 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 3 -->
		<div id="page3">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s2_title)</script></h2>
				<P class="box_msg"><script>show_words(_aa_wiz_s2_msg)</script></P>
				<table width="525" class=formarea>
				<tr>
					<td class="duple"><script>show_words(aa_PolName)</script>:</td>
					<td width="485">&nbsp;&nbsp;<input type="text" id="p3_name" name="name" maxlength="16" value=""></td>
				</tr>
				</table><hr>
				
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p3_prev" value="" onClick="toggle_page(2);">&nbsp; 
						<input name="next" type="button" id="p3_next" value="" onClick="p3_checkName_togglePage();">&nbsp; 
						<input name="save" type="button" id="p3_save" value="" onClick="p8_onSave();">&nbsp; 
						<input name="cancel" type="button" id="p3_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p3_prev").value = get_words(_prev);
							get_by_id("p3_next").value = get_words(_next);
							get_by_id("p3_save").value = get_words(_save);
							get_by_id("p3_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
			</div>
		</div>
		<!-- end of page 3 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 4 -->
		<div id="page4">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s3_title)</script></h2>
				<P class="box_msg"><script>show_words(_aa_wiz_s3_msg)</script></P>
				<table width="525" class=formarea>
				<tr>
					<td class="duple">&nbsp;</td>
					<td width="485">&nbsp;
						<select width="30" id="p4_schedule" name="schedule" onChange="p4_onSchClick();">
							<option value="255" selected><script>show_words(_always)</script></option>
							<option value="254"><script>show_words(_never)</script></option>
							<script>
								document.write(add_option(schedule_cnt, array_sch_inst, array_schedule_name));
							</script>
							<option value="-1"><script>show_words(aa_sched_new)</script></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(_aa_details)</script>:</td>
					<td width="485">&nbsp;&nbsp;<input type="text" id="p4_detail" name="detail" disabled size="48" maxlength="48"></td>
				</tr>
				</table><hr>
				
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p4_prev" value="" onClick="toggle_page(3);">&nbsp; 
						<input name="next" type="button" id="p4_next" value="" onClick="toggle_page(5);">&nbsp; 
						<input name="save" type="button" id="p4_save" value="" onClick="p8_onSave();">&nbsp; 
						<input name="cancel" type="button" id="p4_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p4_prev").value = get_words(_prev);
							get_by_id("p4_next").value = get_words(_next);
							get_by_id("p4_save").value = get_words(_save);
							get_by_id("p4_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
				<script>
					p4_onSchClick();
				</script>
			</div>
		</div>
		<!-- end of page 4 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 5 -->
		<input type="hidden" id="p5_edit" name="edit" value="-1">
		<div id="page5">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s4_title)</script></h2>
				<table width="525" id="add_table">
				<tr>
					<td colspan="2" height="30"><P class="box_msg"><script>show_words(_aa_wiz_s4_msg)</script></P></td>
				</tr>
				<tr>
					<td colspan="2" height="30"><p><script>show_words(_aa_wiz_s4_help)</script></p></td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(aa_AT)</script>:</td>
					<td width="485">
						<input type="radio" id="p5_type" name="p5_type" onClick="p5_typeOnClick()" checked>
						<script>show_words(aa_AT_0);</script>
						<input type="radio" id="p5_type" name="p5_type" onClick="p5_typeOnClick()">
						<script>show_words(aa_AT_1);</script>
						<input type="radio" id="p5_type" name="p5_type" onClick="p5_typeOnClick()">
						<script>show_words(_aa_other_machines);</script>
					</td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(_ipaddr)</script>:</td>
					<td width="485">
						<input type="text" id="p5_ip" name="ip" maxlength="15" size="20">&lt;&lt;
						<select id="p5_ip_list" name="ip_list" onChange="p5_selOnChange(this,'ip');" style="width:150px;">
							<option value=-1><script>show_words(bd_CName)</script></option>
							<script>
							//set_host_list( 'ip' );
							document.write(host_list_opt_ip);
							//set_mac_list("ip");
							</script>
						</select>
					</td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(aa_MAC)</script>:</td>
					<td width="485">
						<input type="text" id="p5_mac" name="mac" size="20">&lt;&lt;
						<select id="p5_mac_list" name="mac_list" onChange="p5_selOnChange(this,'mac');" style="width:150px;">
							<option value=-1><script>show_words(bd_CName)</script></option>
							<script>
							//set_host_list( 'mac' );
							document.write(host_list_opt_mac);
							//set_mac_list("mac");
							</script>
						</select>
					</td>
				</tr>
				<tr>
					<td class="duple">&nbsp;</td>
					<td width="485">
						<input name="clone" type="button" id="p5_clone" value="" onClick="p5_macCloneOnClick()">
						<script>get_by_id("p5_clone").value = get_words(_clone);</script>
					</td>
				</tr>
				<tr>
					<td class="duple">&nbsp;</td>
					<td width="485">
						<input name="ok" type="button" id="p5_ok" value="" onClick="p5_onOk()">
						<input name="clear" type="button" id="p5_clear" value="" onClick="p5_onClear()"> 
						<script>
							get_by_id("p5_ok").value = get_words(_ok);
							get_by_id("p5_clear").value = get_words(_cancel);
						</script>
					</td>
				</tr>
				</table>
				<table width="525" id="full_msg" style="display:none">
				<tr>
					<td height="30">You cannot add more machines because the table is full.</td>
				</tr>
				</table>
				<table id="p5_table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
				<tr>
					<td width="70%"><strong><script>show_words(aa_Machine)</script></strong></td>
					<td width="15%">&nbsp;</td>
					<td width="15%">&nbsp;</td>
				</tr>
				<script>
					//set_machine_list();
					//for(i = 1; i < DataArray.length; i++){
					//	document.write("<tr><td>" + DataArray[i].Machine +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></td></tr>");
					//}
				</script>
				</table>
				<hr>
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p5_prev" value="" onClick="toggle_page(4);">&nbsp; 
						<input name="next" type="button" id="p5_next" value="" onClick="p5_checkDevice_togglePage();">&nbsp; 
						<input name="save" type="button" id="p5_save" value="" onClick="p8_onSave();">&nbsp; 
						<input name="cancel" type="button" id="p5_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p5_prev").value = get_words(_prev);
							get_by_id("p5_next").value = get_words(_next);
							get_by_id("p5_save").value = get_words(_save);
							get_by_id("p5_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
				<script>
					p5_typeOnClick();
				</script>
			</div>		
		</div>
		<!-- end of page 5 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 6 -->
		<div id="page6">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s5_title)</script></h2>
				<P class="box_msg"><script>show_words(_aa_wiz_s5_msg1)</script></P>
				<table width="525" class=formarea>
				<tr>
					<td class="duple"><script>show_words(_aa_method)</script>:</td>
					<td width="485">
						<input type="radio" id="p6_method" name="p6_method" value='0' onClick="p6_methodOnClick()">
						<script>show_words(_aa_allow_all)</script>
						<input type="radio" id="p6_method" name="p6_method" value='1' onClick="p6_methodOnClick()">
						<script>show_words(_aa_block_all)</script>
						<input type="radio" id="p6_method" name="p6_method" value='2' onClick="p6_methodOnClick()" checked>
						<script>show_words(_aa_block_some)</script>
					</td>
					</tr>
				</table>
				<table width="525" id="p6_show_filter" style="display:none">
				<tr>
					<td class="duple"><script>show_words(_aa_apply_web_filter)</script>:</td>
					<td width="485"><input type="checkbox" id="p6_url_filter" name="url_filter" onclick="p6_chkbox()"></td>
				</tr>
				<tr>
					<td class="duple"><script>show_words(_aa_apply_port_filter)</script>:</td>
					<td width="485"><input type="checkbox" id="p6_firewall_rule" name="firewall_rule" onclick="p6_chkbox()"></td>
				</tr>
				</table><hr>
				
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p6_prev" value="" onClick="toggle_page(5);">&nbsp; 
						<input name="next" type="button" id="p6_next" value="" onClick="p6_onNext();">&nbsp; 
						<input name="save" type="button" id="p6_save" value="" onClick="p8_onSave();">&nbsp; 
						<input name="cancel" type="button" id="p6_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p6_prev").value = get_words(_prev);
							get_by_id("p6_next").value = get_words(_next);
							get_by_id("p6_save").value = get_words(_save);
							get_by_id("p6_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
				<script>
					p6_methodOnClick();
				</script>
			</div>
		</div>
		<!-- end of page 6 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 7 -->
		<div id="page7">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s7_title)</script></h2>
				<P class="box_msg"><script>show_words(_aa_wiz_s7_msg)</script></P>
				<p><script>show_words(_aa_wiz_s7_help)</script></p>
				<table width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
				<tr>					
					<td><script>show_words(_enable)</script></td>
					<td><script>show_words(_name)</script></td>
					<td><script>show_words(aa_FPR_c3)</script></td>
					<td><script>show_words(aa_FPR_c4)</script></td>
					<td><script>show_words(_protocol)</script></td>
					<td><script>show_words(aa_FPR_c6)</script></td>
					<td><script>show_words(aa_FPR_c7)</script></td>
				</tr>
				<script>
					for(var i = 1; i <= pfRuleMax; i++){
						document.write("<tr>");
						document.write("<td><input type=checkbox id=p7_enable" + i + " name=enable" + i + " value=1></td>");
						document.write("<td><input type=text style='width:100' id=p7_name" + i + " name=name" + i + " maxlength=15 size=20></td>");
						document.write("<td><input type=text style='width:100' id=p7_start_ip" + i + " name=p7_start_ip" + i + " maxlength=15 size=20 value='0.0.0.0'></td>");
						document.write("<td><input type=text style='width:100' id=p7_end_ip" + i + " name=p7_end_ip" + i + " maxlength=15 size=20 value='255.255.255.255'></td>");
						document.write("<td><select id=p7_protocol" + i + " name=protocol" + i + " onChange='p7_protoOnChange(" + i + ")'>");
						document.write("<option value=0>"+get_words(at_Prot_0)+"</option>");
						document.write("<option value=1>"+get_words(_ICMP)+"</option>");
						document.write("<option value=2>"+get_words(GW_NAT_TCP)+"</option>");
						document.write("<option value=3>"+get_words(GW_NAT_UDP)+"</option>");
						document.write("</select></td>");
						document.write("<td><input type=text id=p7_start_port" + i + " name=start_port" + i + " maxlength=5 size=8 value='0'></td>");
						document.write("<td><input type=text id=p7_end_port" + i + " name=end_port" + i + " maxlength=5 size=8 value='65535'></td>");
						document.write("</tr>");
						p7_protoOnChange(i);
					}
				</script>
				</table><hr>
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p7_prev" value="" onClick="toggle_page(6);">&nbsp; 
						<input name="next" type="button" id="p7_next" value="" onClick="p7_checkFilter_togglePage(0);">&nbsp; 
						<input name="save" type="button" id="p7_save" value="" onClick="p7_checkFilter_togglePage(1);">&nbsp; 
						<input name="cancel" type="button" id="p7_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p7_prev").value = get_words(_prev);
							get_by_id("p7_next").value = get_words(_next);
							get_by_id("p7_save").value = get_words(_save);
							get_by_id("p7_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
			</div>		
		</div>
		<!-- end of page 7 -->
		<!--###############-->
		
		<!--########-->
		<!-- page 8 -->
		<div id="page8">
			<div class=box> 
				<h2><script>show_words(_aa_wiz_s8_title)</script></h2>
				<table width="525" class=formarea>
				<tr>
					<td class="duple"><script>show_words(_aa_logging)</script>:</td>
					<td width="485">
						<input type="radio" id="p8_log" name="p8_log" value="0" checked>
						<script>show_words(_disabled)</script>
					</td>
				</tr>
				<tr>
					<td class="duple">&nbsp;</td>
					<td width="485">
						<input type="radio" id="p8_log" name="p8_log" value="1">
						<script>show_words(_enabled)</script>
					</td>
				</tr>
				</table><hr>
				
				<table width="362" align="center">
				<tr>
					<td> 
					<div align="center">
						<input name="prev" type="button" id="p8_prev" value="" onClick="p8_onPrev();">&nbsp; 
						<input name="next" type="button" id="p8_next" value="" onClick="" disabled>&nbsp; 
						<input name="save" type="button" id="p8_save" value="" onClick="p8_onSave();">&nbsp; 
						<input name="cancel" type="button" id="p8_cancel" value="" onClick="location.replace('adv_access_control.asp');">
						<script>
							get_by_id("p8_prev").value = get_words(_prev);
							get_by_id("p8_next").value = get_words(_next);
							get_by_id("p8_save").value = get_words(_save);
							get_by_id("p8_cancel").value = get_words(_cancel);
						</script>
					</div>
					</td>
				</tr>
				</table>
			</div>
		</div>
		<!-- end of page 8 -->
		<!--###############-->

		</form>
	<!--####################################-->
	<!--#######  end of main part   ########-->
	<!--####################################-->
	</div>
	</td>
	
	<!-- helper -->
	<td valign="top" width="150" id="sidehelp_container" align="left">
		<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
		<tr>
			<td id=help_text>
				<b><script>show_words(_hints)</script>&hellip;</b> 
				<p><script>show_words(hhac_en)</script></p>
				<p><script>show_words(hhac_add)</script></p>
				<p><script>show_words(hhac_edit)</script></p>
				<p><script>show_words(hhac_delete)</script></p>
				<p><a href="support_adv.asp#Access_Control" onclick="return jump_if()"><script>show_words(_more)</script>&hellip;</a></p>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<!-- end of main content -->

<!-- footer -->
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
	<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
	<td width="10">&nbsp;</td><td>&nbsp;</td>
</tr>
</table>	
<!-- end of footer -->
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
</html>
