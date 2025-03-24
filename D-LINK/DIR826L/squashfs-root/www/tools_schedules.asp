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

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var schdStParam = {
		url: "used_check.ccp",
		arg: "ccp_act=getStOfSchedule"
	}
	get_config_obj(schdStParam);
	
	var usedSchd = config_val("usedSchd");
	
	var param = {
		url: "get_set.ccp",
		arg: "ccp_act=get&num_inst=1&"+
			"oid_1=IGD_ScheduleRule_i_&inst_1=10000"
	};
	get_config_obj(param);
	var array_id 		= config_str_multi("id");
	var array_name 		= config_str_multi("schRule_RuleName_");
	var array_allweek	= config_str_multi("schRule_AllWeekSelected_");
	var array_days		= config_str_multi("schRule_SelectedDays_");
	var array_allday	= config_str_multi("schRule_AllDayChecked_");
	var array_timeformat= config_str_multi("schRule_TimeFormat_");
	var array_start_h	= config_str_multi("schRule_StartHour_");
	var array_start_mi	= config_str_multi("schRule_StartMinute_");
	var array_start_me	= config_str_multi("schRule_StartMeridiem_");
	var array_end_h		= config_str_multi("schRule_EndHour_");
	var array_end_mi	= config_str_multi("schRule_EndMinute_");
	var array_end_me	= config_str_multi("schRule_EndMeridiem_");
	
	var array_inst = config_inst_multi("IGD_ScheduleRule_i_");
	var current_rule_cnt = 0;
	if(array_inst != null)
		current_rule_cnt = array_inst.length;

	var submit_button_flag = 0;
	var data_list = new Array();
	var rule_max_num = 32;
	var from_edit = 0;
	var non_update_name = "";	// GraceYang 2009.06.23 added
	
	var edit_index = -1;
	var arrayIdx = -1;
	
	function onPageLoad(){
		var login_who= login_Info;
		format_trans();
		if(login_who!= "w"){
			DisableEnableForm(document.form1,true);	
		}
	}

	function string_to_days(str) {
		for(var i=0; i<7; i++) {
			if(new String(str).substr(i, 1) == '1')
				get_by_id("day"+i).checked = true;
			else
				get_by_id("day"+i).checked = false;
		}
	}	

	function format_trans() {
		var tmp_format = get_by_id("time_format").selectedIndex;
		var tmp_start_hour = get_by_id("start_hour").value;
		var tmp_start_min = get_by_id("start_min").value;
		var tmp_end_hour = get_by_id("end_hour").value;
		var tmp_end_min = get_by_id("end_min").value;
		var st_min,en_hour,en_min;
		if(tmp_format =="0") 
		{
			/* 12hr start*/
			if(parseInt(tmp_start_hour,10) >= 11) //PM
			{
				if (check_integer(get_by_id("start_hour").value, 12, 23)){	
					tmp_start_hour = parseInt(tmp_start_hour,10)-12; 
					if(tmp_start_hour < 1){
						tmp_start_hour = parseInt(12);
					}
					get_by_id("start_time").selectedIndex = 1; 
				}
			} else if (tmp_start_hour < 1){	
				tmp_start_hour = parseInt(12);
				get_by_id("start_time").selectedIndex = 0; 
			}
			get_by_id("start_hour").value = tmp_start_hour;	
			/*12hr end*/
			if(parseInt(tmp_end_hour,10) >= 11) 
			{
				if (check_integer(get_by_id("end_hour").value, 12, 23)){	
					tmp_end_hour = parseInt(tmp_end_hour,10)-12; 
					if(tmp_end_hour < 1){
						tmp_end_hour = parseInt(12);
					}
					get_by_id("end_time").selectedIndex = 1; 
				}
			} else if(tmp_end_hour < 1){	
				tmp_end_hour = parseInt(12);
				get_by_id("end_time").selectedIndex = 0; 
			}
			get_by_id("end_hour").value = tmp_end_hour;	
		} else {
			/*24hr start*/
			//add by vic				
			/*if (check_integer(get_by_id("start_hour").value, 1, 11))
				get_by_id("start_time").selectedIndex = "0";
			else
				get_by_id("start_time").selectedIndex = "1";
				*/
				
			//add end
			if(get_by_id("start_time").selectedIndex == "1") 
			{
				if (check_integer(get_by_id("start_hour").value, 1, 11)){	
					tmp_start_hour = parseInt(tmp_start_hour,10)+12; 
				} else{// if (tmp_start_hour =="12"){	
					tmp_start_hour = parseInt(tmp_start_hour,10); 
				}	
			} else { 
				if (tmp_start_hour =="12"){	
					tmp_start_hour = "0"+parseInt(0); 
				}
			}
			get_by_id("start_hour").value = tmp_start_hour;
			/*24hr end*/
			if(get_by_id("end_time").selectedIndex == "1") 
			{
				if (check_integer(get_by_id("end_hour").value, 1, 11)){	
					tmp_end_hour = parseInt(tmp_end_hour,10)+12; 
				}else{// if(tmp_end_hour =="12"){	
					tmp_end_hour = parseInt(tmp_end_hour,10); 
				}	
			}
			else{ 
				if(tmp_end_hour =="12"){	
					tmp_end_hour = "0"+parseInt(0); 
				}	
			}
			get_by_id("end_hour").value = tmp_end_hour;
		}
		
		if (tmp_format == "1"){ //24hr
			get_by_id("start_time").disabled = true;
			get_by_id("end_time").disabled = true;	
			get_by_id("tf_str").innerHTML = get_words('tsc_hrmin1');
			get_by_id("tf_str1").innerHTML = get_words('tsc_hrmin1');
		}else{ 					//12hr
			get_by_id("start_time").disabled = false;
			get_by_id("end_time").disabled = false;	
			get_by_id("tf_str").innerHTML = get_words('tsc_hrmin');
			get_by_id("tf_str1").innerHTML = get_words('tsc_hrmin');
		}
	}
		
	function edit_row(index){
		if(login_Info!= "w")
			return;
			
		var i = 0;
		
		edit_index = index;
		for(i=0; i<current_rule_cnt; i++)
		{
			if(index == inst_array_to_string(array_inst[i]))
			{
				get_by_id("name").value = array_name[i];
				var allWeek = get_by_name("all_week");
				if(array_allweek[i] == '1')
					allWeek[0].checked = true;
				else
					allWeek[1].checked = true;
				
				string_to_days(array_days[i]);	
				
				if(array_allday[i] == '1')
					get_by_id("time_type").checked = true;
				else
					get_by_id("time_type").checked = false;
				
				get_by_id("time_format").selectedIndex = array_timeformat[i];

				get_by_id("start_hour").value = array_start_h[i];
				if(array_start_mi[i] < 10)
					get_by_id("start_min").value = "0"+array_start_mi[i];
				else
					get_by_id("start_min").value = array_start_mi[i];
				//alert(array_start_me[i]);
				get_by_id("start_time").selectedIndex = array_start_me[i];
				get_by_id("end_hour").value = array_end_h[i];
				if(array_end_mi[i] < 10)
					get_by_id("end_min").value = "0"+array_end_mi[i];
				else
					get_by_id("end_min").value = array_end_mi[i];
				get_by_id("end_time").value = array_end_me[i];	

				get_by_id("form_act").value = 'edit';
				get_by_id('schRule_inst_').value = index;
				change_color("table1", i+1);
				from_edit = 1;
				show_day();
				show_time();
				format_trans();
				
				arrayIdx = i;
				//change_timeformat();

				/* for CGI to determine the operation */
				//get_by_id("action").value = "update";	
				//get_by_id("inst").value = index;
				
				break;	
			}
		}
	}
	
	function del_row(row, i){
		if(login_Info!= "w")
			return;
			
		var row_str = new String(row);
		var idx = parseInt(row_str.charAt(1));
		var used_str = new String(usedSchd);	
		//alert("idx="+idx +", "+ used_str.charAt(idx-1));	
		if(used_str.charAt(idx-1) == '1')
		{
			
			alert(addstr(get_words('GW_SCHEDULES_IN_USE_INVALID'), array_name[i]));	//GW_SCHEDULES_IN_USE_INVALID_s2, GW_SCHEDULES_IN_USE_INVALID
			return;
		}
	
		if (confirm(get_words('YM35')+"?")){
			var inst = new String(row);
			var param = {
				url: "get_set.ccp",
				arg: "ccp_act=del&num_inst=1&"+
					"ccpSubEvent=CCP_SUB_SCHEDULE&nextPage=tools_schedules.asp&"+
					"oid_1=IGD_ScheduleRule_i_&inst_1=1."+inst.substr(1,1)+".0.0.0"
			};
			get_config_obj(param);
			location.replace('tools_schedules.asp');
		}
		else
			return;
	}
	
	
	function show_day(){
		var all_week = get_by_name("all_week");
	
		for (var i = 0; i < 7; i++){
			get_by_id("day" + i).disabled = all_week[0].checked;
		}
	}
	
	function show_time(){
		var time_type = get_by_id("time_type");
		
		get_by_id("start_hour").disabled = time_type.checked;
		get_by_id("start_min").disabled = time_type.checked;
		get_by_id("start_time").disabled = time_type.checked;
		get_by_id("end_hour").disabled = time_type.checked;
		get_by_id("end_min").disabled = time_type.checked;
		get_by_id("end_time").disabled = time_type.checked;
		get_by_id("time_format").disabled =time_type.checked;	
//*
		if (get_by_id("time_format").value == "1" ||time_type.checked){ //24hr
			get_by_id("start_time").disabled = true;
			get_by_id("end_time").disabled = true;
					
		}else{ //12hr
			get_by_id("start_time").disabled = false;
			get_by_id("end_time").disabled = false;	
		}
//*/
	}

	function update_data(){
		// GraceYang 2009.06.23 added
		if(non_update_name != "" && non_update_name != get_by_id("name").value){
			alert(get_by_id("name").value +" is already used.");
			return false;
		}
		if(get_by_id("edit").value != -1){
			var days_in_week="";
			var start_time_total,end_time_total;
			var p_all_week = get_by_name("all_week");
			if(p_all_week[0].checked == true){
				days_in_week = "1111111"
			}else{
				for(var i=0;i<7;i++){
					if(get_by_id("day"+ i).checked== true){
						days_in_week += "1";
					}else{
						days_in_week += "0"
					}
				}	
			}
			var p_all_day=get_by_id("time_type");

			if (p_all_day.checked==true){			
				start_time_total= "00:00";
				end_time_total="24:00";
			}else{
				var s_hour,s_min;
				var e_hour,e_min;
				
				//start time
				if(parseInt(get_by_id("start_min").value,10)<10){
					s_min= "0" + parseInt(get_by_id("start_min").value,10);
				}else{
					s_min= get_by_id("start_min").value;
				}
				
				if(get_by_id("start_time").selectedIndex ==1){	//pm
					s_hour = time_hour(parseInt(get_by_id("start_hour").value,10)) +12;
				}else{											//am
					if(time_hour(parseInt(get_by_id("start_hour").value,10))<10){
						s_hour ="0" + time_hour(parseInt(get_by_id("start_hour").value,10));
					}else{
						s_hour = get_by_id("start_hour").value;
					}
				}
				start_time_total =s_hour + ":" + s_min;
				
				//end time		
				if(parseInt(get_by_id("end_min").value,10)<10){
					e_min= "0" + parseInt(get_by_id("end_min").value,10);
				}else{
					e_min= get_by_id("end_min").value;
				}
				
				if(get_by_id("end_time").selectedIndex ==1){	//pm
					e_hour = time_hour(parseInt(get_by_id("end_hour").value,10)) +12;
				}else{											//am
					if(time_hour(parseInt(get_by_id("end_hour").value,10))<10){
						e_hour ="0" + time_hour(parseInt(get_by_id("end_hour").value,10));
					}else{
						e_hour = get_by_id("end_hour").value;
					}
				}
				end_time_total =e_hour + ":" + e_min;
			}
			
			
			
			var dat =get_by_id("name").value +"/"+ days_in_week +"/"+ start_time_total +"/"+ end_time_total;
			var num= parseInt(get_by_id("edit").value,10);
			
			/*2009.10.22 Tina Tsao added
			* Fixed when modify schedule, wlan schedule and accesll control schedule can't update on time.
			*/
			var control_list = "";

			if (num < 10){
				var temp_rule = get_by_id("schedule_rule_0" + num).value;
			}else{
				var temp_rule = get_by_id("schedule_rule_" + num).value;
			}		
			var rule = temp_rule.split("/");
			
			for (var l=0 ;l <15 ;l++){
				if(l<10){
					var temp_access_rule = get_by_id("access_control_0" + l).value;
				}else{
					var temp_access_rule = get_by_id("access_control_" + l).value;
				}
				
				var access_rule = temp_access_rule.split("/");
				var access_rule_schedule = access_rule[5];			

				if (rule[0] == access_rule_schedule){
					control_list = access_rule[0] +  "/" + access_rule[1] + "/" + access_rule[2]  + "/"
						 + access_rule[3]  + "/" + access_rule[4]  + "/" + dat;
		
					if (l < 10){
						get_by_id("access_control_0" + l).value = control_list;
					}else{
						get_by_id("access_control_" + l).value = control_list;
					}	
				}			
			}		
					
			var temp_wlan0_rule = get_by_id("wlan0_schedule").value;		
			var wlan0_rule = temp_wlan0_rule.split("/");
			var wlan0_rule_schedule = wlan0_rule[0];			
					
			if (num < 10){
				get_by_id("schedule_rule_0" + num).value = dat;
			}else{
				get_by_id("schedule_rule_" + num).value = dat;
			}
			if (rule[0] == wlan0_rule_schedule){
				get_by_id("wlan0_schedule").value = dat;
			}
			get_by_id("asp_temp_01").value = dat;	
			//2009.10.22 Tina Tsao added
			
		}else{
			if(get_by_id("max_row").value >= parseInt(rule_max_num-1)){
				//alert("Schedule rules Full! Please Delete an Entry.");
				alert(get_words('TEXT015'));
			}
				
			var days_in_week="";
			var start_time_total,end_time_total;
			var p_all_week = get_by_name("all_week");
			if(p_all_week[0].checked == true){
				days_in_week = "1111111"
			}else{
				for(var i=0;i<7;i++){
					if(get_by_id("day"+ i).checked== true){
						days_in_week += "1";
					}else{
						days_in_week += "0"
					}
				}	
			}
			
			var p_all_day=get_by_id("time_type");
			if (p_all_day.checked==true){			
				start_time_total= "00:00";
				end_time_total="24:00";
			}else{
				var s_hour,s_min;
				var e_hour,e_min;
				
				//start time
				if(parseInt(get_by_id("start_min").value,10)<10){
					s_min= "0" + parseInt(get_by_id("start_min").value,10);
				}else{
					s_min= get_by_id("start_min").value;
				}
				
				if(get_by_id("start_time").selectedIndex ==1){	//pm
					s_hour = time_hour(parseInt(get_by_id("start_hour").value,10)) +12;	
				}else{											//am
					if(time_hour(parseInt(get_by_id("start_hour").value,10))<10){
						s_hour ="0" + time_hour(parseInt(get_by_id("start_hour").value,10));
					}else{
						s_hour = get_by_id("start_hour").value;
					}
				}
				start_time_total =s_hour + ":" + s_min;
				
				//end time		
				if(parseInt(get_by_id("end_min").value,10)<10){
					e_min= "0" + parseInt(get_by_id("end_min").value,10);
				}else{
					e_min= get_by_id("end_min").value;
				}
				
				if(get_by_id("end_time").selectedIndex ==1){	//pm
					e_hour = time_hour(parseInt(get_by_id("end_hour").value,10)) +12;
				}else{											//am
					if(time_hour(parseInt(get_by_id("end_hour").value,10))<10){
						e_hour ="0" + time_hour(parseInt(get_by_id("end_hour").value,10));
					}else{
						e_hour = get_by_id("end_hour").value;
					}
				}
				end_time_total =e_hour + ":" + e_min;
			}
			
			
			
			var dat =get_by_id("name").value +"/"+ days_in_week +"/"+ start_time_total +"/"+ end_time_total;
			var num = parseInt(get_by_id("max_row").value) +1;
			
			/*2009.10.22 Tina Tsao added
			* Fixed when modify schedule, wlan schedule and accesll control schedule can't update on time.
			*/
			var control_list = "";

			if (num < 10){
				var temp_rule = get_by_id("schedule_rule_0" + num).value;
			}else{
				var temp_rule = get_by_id("schedule_rule_" + num).value;
			}		
			var rule = temp_rule.split("/");
			
			for (var l=0 ;l <15 ;l++){
				if(l<10){
					var temp_access_rule = get_by_id("access_control_0" + l).value;
				}else{
					var temp_access_rule = get_by_id("access_control_" + l).value;
				}
				
				var access_rule = temp_access_rule.split("/");
				var access_rule_schedule = access_rule[5];			

				if (rule[0] == access_rule_schedule){
					control_list = access_rule[0] +  "/" + access_rule[1] + "/" + access_rule[2]  + "/"
						 + access_rule[3]  + "/" + access_rule[4]  + "/" + dat;
		
					if (l < 10){
						get_by_id("access_control_0" + l).value = control_list;
					}else{
						get_by_id("access_control_" + l).value = control_list;
					}	
				}			
			}
					
			var temp_wlan0_rule = get_by_id("wlan0_schedule").value;		
			var wlan0_rule = temp_wlan0_rule.split("/");
			var wlan0_rule_schedule = wlan0_rule[0];			
					
			if (num < 10){
				get_by_id("schedule_rule_0" + num).value = dat;
			}else{
				get_by_id("schedule_rule_" + num).value = dat;
			}	
			if ((rule[0] == wlan0_rule_schedule) && (wlan0_rule_schedule != "")){
				get_by_id("wlan0_schedule").value = dat;
			}
			get_by_id("asp_temp_01").value = dat;	
			//2009.10.22 Tina Tsao added
		}
		return true;  // GraceYang 2009.06.23 added
	}

	function time_hour(hour){
		var hour_c = hour;
		var time_format = get_by_id("schedule_time_format").selectedIndex;
		if ((parseInt(hour,10) >= 12) && (time_format == "1")){
			hour_c = 00;
		}
		return hour_c;
	}

	function check_day()
	{
		var dayString="";
		for(var i=0; i<7; i++)
		{
			
			//var tmp = get_by_id("day"+i);
			if(get_by_id("day"+i).checked == true)
				dayString += "1";
			else
				dayString += "0";
			

			//dayString += get_by_id("day"+i).checked;
		}

		//alert("dayString = " + dayString);
		return dayString;
	}
	
	function check_time()
	{
		var timeFmt = get_by_id("time_format").selectedIndex;
		var start_h = get_by_id('start_hour').value;
		var start_m = get_by_id('start_min').value;
		var start_f = get_by_id('start_time').value; //0:am, 1:pm
		var end_h = get_by_id('end_hour').value;
		var end_m = get_by_id('end_min').value;
		var end_f = get_by_id('end_time').value; //0:am, 1:pm
		
		if (timeFmt == 0) {		//12hr
			if (!check_integer(start_h, 1, 12) || !check_integer(end_h, 1, 12) ||
				!check_integer(start_m, 0, 59) || !check_integer(end_m, 0, 59)){
				return false;
			}
			
			start_h = parseInt(start_h);
			start_m = parseInt(start_m);
			end_h = parseInt(end_h);
			end_m = parseInt(end_m);

			if (start_f == '1')	//pm
				start_h += 12;
			
			if (end_f == '1')	//pm
				end_h += 12;

			if ((start_h == 24 && start_m != 0) ||
				(end_h == 24 && end_m != 0)) {
				return false;
			}
			
			if ((start_f == 1 && start_h == 24 && start_m != 0) || 
				(end_f == 1 && end_h == 24 && end_m != 0)) {
				return false;
			}
			
		} else {				//24hr
			if (!check_integer(start_h, 0, 23) || !check_integer(end_h, 0, 23) ||
				!check_integer(start_m, 0, 59) || !check_integer(end_m, 0, 59)){
				return false;
			}
		}
		

		// all day??
		if (start_h == end_h && start_m == end_m && start_f == end_f) {
			return false;
		}
		
		//var start_num = start_h*60+start_m+(start_f==0? 0: 720);
		//var end_num = end_h*60+end_m+(end_f==0? 0: 720);
		
		//if (start_num >= end_num) {
		//	return false;
		//}
		
		return true;
	}
	
	function do_submit() {
		var inst = '';
		var param = {
			url: "get_set.ccp",
			arg: ""
		};
		
		if (get_by_id('form_act').value == 'add') {
			param.arg = "ccp_act=queryInst&num_inst=1";
			param.arg +="&oid_1=IGD_ScheduleRule_i_&inst_1=11000";
			get_config_obj(param);
			inst = config_val("newInst");
		} else if (get_by_id('form_act').value == 'edit') {
			inst = 	get_by_id('schRule_inst_').value;
		}

		param.arg = 'ccp_act=set&ccpSubEvent=CCP_SUB_SCHEDULE&nextPage=tools_schedules.asp';
		param.arg += make_req_entry('&schRule_RuleName_', 			get_by_id('schRule_RuleName_').value, inst);
		param.arg += make_req_entry('&schRule_AllWeekSelected_', 	get_by_id('schRule_AllWeekSelected_').value, inst);
		param.arg += make_req_entry('&schRule_SelectedDays_', 		get_by_id('schRule_SelectedDays_').value, inst);
		param.arg += make_req_entry('&schRule_AllDayChecked_', 		get_by_id('schRule_AllDayChecked_').value, inst);
		param.arg += make_req_entry('&schRule_TimeFormat_', 		get_by_id('schRule_TimeFormat_').value, inst);
		param.arg += make_req_entry('&schRule_StartHour_', 			get_by_id('schRule_StartHour_').value, inst);
		param.arg += make_req_entry('&schRule_StartMinute_', 		get_by_id('schRule_StartMinute_').value, inst);
		param.arg += make_req_entry('&schRule_StartMeridiem_', 		get_by_id('schRule_StartMeridiem_').value, inst);
		param.arg += make_req_entry('&schRule_EndHour_', 			get_by_id('schRule_EndHour_').value, inst);
		param.arg += make_req_entry('&schRule_EndMinute_', 			get_by_id('schRule_EndMinute_').value, inst);
		param.arg += make_req_entry('&schRule_EndMeridiem_', 		get_by_id('schRule_EndMeridiem_').value, inst);
		param.arg += make_req_entry('&schRule_TimeFormatReal_', 	"0", inst);
		
		get_config_obj(param);
		location.replace('tools_schedules.asp');	// we have to add this line, otherwise, ie won't refresh page.
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}

		/* Process data for send back to CGI, exclude delete operation*/
			if (get_by_id("name").value.length <= 0){
				alert(get_words('GW_SCHEDULES_NAME_INVALID'));
				return false;
			}
		
			var temp_obj = get_by_id("name").value;
			var space_num = 0;
			for (i=0;i<temp_obj.length;i++){
				if (temp_obj.charAt(i)==" "){	
					space_num++
				}
			}

			//from edit, check if this schd is in used
			if(from_edit != 0)
			{
				var row_str = new String(edit_index);
				var idx = parseInt(row_str.charAt(1));
				var used_str = new String(usedSchd);	
				//alert("idx="+idx +", "+ used_str.charAt(idx-1));	
				if(used_str.charAt(idx-1) == '1')
				{
					//alert(array_name[idx-1]+", "+temp_obj);
					if(array_name[idx-1] != temp_obj)
					{
						alert(addstr(get_words('GW_SCHEDULES_IN_USE_INVALID'), array_name[arrayIdx]));	//GW_SCHEDULES_IN_USE_INVALID_s2, GW_SCHEDULES_IN_USE_INVALID
						return;
					}
				}
			}
			
			//check the same name
			for(var n=0; n<current_rule_cnt; n++)
			{
				if(temp_obj == array_name[n])
				{
					if(from_edit == 0)
					{
						alert(addstr(get_words('GW_SCHEDULES_NAME_CONFLICT_INVALID'), temp_obj));
						return;
					}
					else
					{					
						if(edit_index != inst_array_to_string(array_inst[n]))
						{
							alert(addstr(get_words('GW_SCHEDULES_NAME_CONFLICT_INVALID'), temp_obj));
							return;
						}
					}
				}
					//alert("edit="+edit_index+", map="+inst_array_to_string(array_inst[n]));
			}
			
			/* check name if all space or not */
			//if(parseInt(space_num) >= parseInt(temp_obj.length)){
			//	alert(which_lang[GW_INET_ACL_SCHEDULE_NAME_INVALID]);
			//	return false;
			//}
			
			/* check if the name equals to "ALWAYS" of "NEVER"*/
			//if((temp_obj == which_lang[_always])||(temp_obj == which_lang[_never]) ){
			//	alert(which_lang[GW_SCHEDULES_NAME_RESERVED_INVALID]);
			//	return false;
			//}
			
			var time_type = get_by_id("time_type");
			var time_format_value= get_by_id("time_format").selectedIndex;		
			//alert("time_format_value:"+time_format_value);	
			if (!get_by_id("time_type").checked){
				if(time_format_value == "0"){  //12hr
					if (!check_integer(get_by_id("start_hour").value, 1, 12) || !check_integer(get_by_id("end_hour").value, 1, 12)){
						alert(get_words('YM184'));
						return false;
					}
			
				}else if (!check_integer(get_by_id("start_hour").value, 0, 23) || !check_integer(get_by_id("end_hour").value, 0, 23)){
					alert(get_words('YM184'));
					return false;
				}
				if(!check_integer(get_by_id("start_min").value, 0, 59)||!check_integer(get_by_id("end_min").value, 0, 59)){
						alert(get_words('YM184'));
						return false;
				}				
			}
			//*/
			//if(!update_data())
				//return false;

			//get_by_id("action").value = "setpar";
			//get_by_id("inst").value = "00000";
			get_by_id("schRule_RuleName_").value = get_by_id("name").value;	

			var allWeek = get_by_name("all_week");
			var selected_day = check_day();
			
			if (allWeek[0].checked == true)
				get_by_id("schRule_AllWeekSelected_").value = "1";
			else
			{
				get_by_id("schRule_AllWeekSelected_").value = "0";
				if(selected_day == "0000000")
				{
					alert(get_words("GW_SCHEDULES_DAY_INVALID"));
					return;
				}
			}
				
			get_by_id("schRule_SelectedDays_").value = selected_day;

			if (get_by_id("time_type").checked == true)
				get_by_id("schRule_AllDayChecked_").value = "1";
			else
				get_by_id("schRule_AllDayChecked_").value = "0";
			
			get_by_id("schRule_TimeFormat_").value = get_by_id("time_format").selectedIndex;
			
			// we store 24hr format in data model
			//add by Vic
			if(get_by_id("time_format").value == 1)
			{
				if (check_integer(get_by_id("start_hour").value, 1, 11))
					get_by_id("start_time").selectedIndex = "0";
				else
					get_by_id("start_time").selectedIndex = "1";
				
				if (check_integer(get_by_id("end_hour").value, 1, 11))
					get_by_id("end_time").selectedIndex = "0";
				else
					get_by_id("end_time").selectedIndex = "1";
			}
			//add by Vic end
				
			get_by_id("time_format").value = 1;	
			format_trans();
			
			if (get_by_id("time_type").checked == false && check_time() == false) {
				alert(get_words('YM184'));
				return false;
			}
			get_by_id("schRule_StartHour_").value = get_by_id("start_hour").value;
			get_by_id("schRule_StartMinute_").value = get_by_id("start_min").value;
			get_by_id("schRule_StartMeridiem_").value = get_by_id("start_time").value;
			get_by_id("schRule_EndHour_").value = get_by_id("end_hour").value;
			get_by_id("schRule_EndMinute_").value = get_by_id("end_min").value;
			get_by_id("schRule_EndMeridiem_").value = get_by_id("end_time").value;
			
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			do_submit();
			return false;
		}else{
			return false;
		}

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
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_scheds)</script></div></li>
									<!--<li><div id="sidenavon"><a href="logout.asp" onclick="do_logout();"><script>show_words(logout_caption)</script></a></div></li>
									-->
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action="get_set.ccp">
				<input type="hidden" name="ccp_act" value="set">
				<input type="hidden" name="ccpSubEvent" value="CCP_SUB_SCHEDULE">
				<input type="hidden" name="nextPage" value="tools_schedules.asp">	
				<input type="hidden" id="form_act" value="add">
	
				<input type="hidden" id="schRule_inst_" name="schRule_RuleName_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_RuleName_" name="schRule_RuleName_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_AllWeekSelected_" name="schRule_AllWeekSelected_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_SelectedDays_" name="schRule_SelectedDays_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_AllDayChecked_" name="schRule_AllDayChecked_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_TimeFormat_" name="schRule_TimeFormat_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_StartHour_" name="schRule_StartHour_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_StartMinute_" name="schRule_StartMinute_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_StartMeridiem_" name="schRule_StartMeridiem_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_EndHour_" name="schRule_EndHour_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_EndMinute_" name="schRule_EndMinute_1.0.0.0.0" value="">
				<input type="hidden" id="schRule_EndMeridiem_" name="schRule_EndMeridiem_1.0.0.0.0" value="">

			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					
				  <div id="box_header"> 
          <h1> 
            <script>show_words(_scheds)</script>
          </h1>
						
          <p> 
            <script>show_words(tsc_intro_Sch)</script>
          </p>
						<br>
	                      <input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
                          <input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'tools_schedules.asp');">
                  			<script>get_by_id("button").value = get_words('_savesettings');</script>
							<script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
				  </div>
				  
        <div class=box> 
          <h2>10 &ndash; <span id="sched_title0"> 
            <script>show_words(_add)</script>
            </span> 
            <script>show_words(tsc_SchRu)</script>
          </h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                      <tr>
                        <td width="150"><div align="right"><strong> 
                  <script>show_words(_name)</script>
                  :</strong>&nbsp;</div></td>
                        <td width="384" height="20" valign="top">&nbsp;&nbsp;<input id="name" name="name" type="text" size="20" maxlength="16"></td>
                      </tr>
                      <tr>
                        <td width="150">
                          <div align="right"><strong> 
                  <script>show_words(tsc_Days)</script>&nbsp;:</strong>&nbsp;</div></td>
                        <td height="20" valign="top">&nbsp;<input type="radio" name="all_week" value="1" onClick="show_day()" checked>
                <script>show_words(tsc_AllWk)</script>
                &nbsp;
<input type="radio" name="all_week" value="0" onClick="show_day()">
                <script>show_words(tsc_sel_days)</script>
              </td>
                      </tr>
                      <tr>
                        <td width="150">
                          <div align="right"></div></td>
                        <td height="20" valign="top">&nbsp;<input type="checkbox" id="day0" name="day0" value="1">&nbsp;<script>show_words(_Sun)</script>
                        	<input type="checkbox" id="day1" name="day1" value="1">&nbsp;<script>show_words(_Mon)</script>
                        	<input type="checkbox" id="day2" name="day2" value="1">&nbsp;<script>show_words(_Tue)</script>
                        	<input type="checkbox" id="day3" name="day3" value="1">&nbsp;<script>show_words(_Wed)</script>
                        	<input type="checkbox" id="day4" name="day4" value="1">&nbsp;<script>show_words(_Thu)</script>
                        	<input type="checkbox" id="day5" name="day5" value="1">&nbsp;<script>show_words(_Fri)</script>
                        	<input type="checkbox" id="day6" name="day6" value="1">&nbsp;<script>show_words(_Sat)</script>
                        </td>
                      </tr>
                          <tr>
                            <td width="150">
                              <div align="right"><strong><script>show_words(tsc_24hrs)</script>&nbsp;:</strong>&nbsp;</div></td>
                            <td height="20" valign="middle">&nbsp;<input id="time_type"  name="time_type" type="checkbox" value="1" onClick="show_time()">
                            	<input type="hidden" id="h0" name="h0">
								<input type="hidden" id="h1" name="h1">
								<input type="hidden" id="h2" name="h2">
								<input type="hidden" id="h3" name="h3">
								<input type="hidden" id="h4" name="h4">
								<input type="hidden" id="h5" name="h5">
								<input type="hidden" id="h6" name="h6">
							</td>
                           
                          </tr>
						  <tr>
							<td width="150">
								<div align="right">
									<strong><script>show_words(sch_timeformat)</script>&nbsp;:</strong>&nbsp;
								</div>
							</td>
							<td height="20" valign="middle">
								<select id="time_format" onchange="format_trans()">
									<option value="0"><script>show_words(sch_hourfmt_12)</script></option>
									<option value="1"><script>show_words(sch_hourfmt_24)</script></option>
								</select>
							</td>
						  </tr>
                          <tr>
                            <td width="150"><div align="right"><strong>
                  <script>show_words(tsc_start_time)</script>&nbsp;:</strong>&nbsp;</div></td>
                            <td height="20" valign="top">&nbsp;&nbsp;<input id="start_hour" name="start_hour" type="text" style="width: 40px" maxlength="2" value="12">:
                            <input id="start_min" name="start_min" type="text" style="width: 40px" maxlength="2" value="00">
                            <select style="width: 50px" id="start_time" name="start_time" value="00">
                            	<option value="0"><script>show_words(_AM)</script></option>
						    	<option value="1"><script>show_words(_PM)</script></option>
						    </select>
                &nbsp;
                <!-- <script>show_words(tsc_hrmin)</script> Tin Modify-->
					<span id="tf_str"></span>
              </td>
                          </tr>
                          <tr>
                            <td width="150">
                            <div align="right"><span class="form_label"><strong> 
                  <script>show_words(tsc_EndTime)</script>
                  :&nbsp;</strong></span></div></td>
                            <td height="20" valign="top">&nbsp;&nbsp;<input id="end_hour" name="end_hour" type="text" style="width: 40px" maxlength="2" value="12">:
                            <input id="end_min" name="end_min" type="text" style="width: 40px" maxlength="2" value="00">
                            <select style="width: 50px" id="end_time" name="end_time">
                            	<option value="0"><script>show_words('_AM')</script></option>
                            	<option value="1"><script>show_words('_PM')</script></option>
                            </select>
                &nbsp;
                <span id="tf_str1"></span>
              </td>
                          </tr>
                    </table>
                  </div>
				  <div class=box>
        <h2> 
          <script>show_words('tsc_SchRuLs')</script>
          </h2>
                    <table id="table1" cellSpacing=1 cellPadding=1 width=524 border=0>
                      <tr>
                        <td width="165">
                          <div align="center"><strong>
                <script>show_words(_name)</script>
                :</strong>&nbsp;</div></td>
                        <td width="190"><div align="center"><strong> 
                <script>show_words(_days)</script>
                :</strong>&nbsp;</div></td>
                        <td width="135"><div align="center"><strong> 
                <script>show_words(sch_time)</script>
                :</strong></div></td>                      
                        <td width="15" valign="top">&nbsp;</td>
                        <td width="15" valign="top">&nbsp;</td>
                      </tr>
					  <script>	
						
				for(i=0;i<current_rule_cnt;i++){
					var temp_time_start = ((array_start_h[i].length <=1)? ("0"+array_start_h[i]): (array_start_h[i]))+":"+ 
										((array_start_mi[i].length <=1)? ("0"+array_start_mi[i]):(array_start_mi[i]));
					var temp_time_end = ((array_end_h[i].length <=1)? ("0"+array_end_h[i]): (array_end_h[i]))+":"+ 
										((array_end_mi[i].length <=1)? ("0"+array_end_mi[i]):(array_end_mi[i]));
					
					var temp_time_array = temp_time_start + "~" + temp_time_end;
					//alert(temp_time_array);
					if((temp_time_start=="00:00" && temp_time_end=="24:00") || (array_allday[i] == "1")){
						temp_time_array = get_words('tsc_AllDay');
					}
					
					var s_day = "";
					if(array_allweek[i] == "1")
						s_day = get_words('tsc_AllWk');
					else
					{
						var count = 0;
						for(var j=0; j<7; j++)
						{
							if(new String(array_days[i]).substr(j, 1) == "1") {
								s_day = s_day +" " + Week[j];
								count++;
							}
						}
						
						if (count == 7)
							s_day = "All week";
					}
					document.write('<tr><td align=center>'+ array_name[i] +'</td><td align=center>'+ s_day +'</td><td align=center>'+ temp_time_array +'</td><td><a href=javascript:edit_row('+ inst_array_to_string(array_inst[i]) +')><img src=edit.jpg width=15 height=17 border=0 title='+get_words('_edit')+'></a></td><td><a href=javascript:del_row('+ inst_array_to_string(array_inst[i]) +','+ i +')><img src=delete.jpg width=15 height=18 border=0 title='+get_words('_delete')+'></a></td></tr>');
				}
				</script>
					                                      
                    </table>
                    </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  
          <td id=help_text><strong> 
            <script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(hhts_intro)</script>
            </p>
						
            <p> 
              <script>show_words(hhts_name)</script>
            </p>
						
            <p>
              <script>show_words(hhts_save)</script>
            </p>
						
            <p>
              <script>show_words(hhts_edit)</script>
            </p>
						
            <p>
              <script>show_words(hhts_del)</script>
            </p>
						<p class="more"><a href="support_tools.asp#Schedules" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
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
<script>
	show_day();
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
