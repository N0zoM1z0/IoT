<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language=JavaScript>
var submit_button_flag = 0;
var data_list = new Array();
var rule_max_num = 10;
var from_edit = 0;

function onPageLoad(){
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}
}

function edit_row(index){
	if (index < 10){
		var temp_rule = get_by_id("schedule_rule_0" + index).value;
	}else{
		var temp_rule = get_by_id("schedule_rule_" + index).value;
	}

	var rule = temp_rule.split("/");					
	var is_related = 0;

	for (var l=0 ;l <=rule_max_num ;l++){
		if(l<10){
			var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
			var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
			var temp_application_rule = get_by_id("application_0"+l).value;
			var temp_access_control_rule = get_by_id("access_control_0"+l).value;
		}else{
			if(l<24){
				var temp_rule = get_by_id("schedule_rule_" + l).value;
				var temp_vs_rule = get_by_id("vs_rule_" + l).value;
				var temp_port_rule = get_by_id("port_forward_both_" + l).value;
				var temp_application_rule = get_by_id("application_"+l).value;	
				var temp_access_control_rule = get_by_id("access_control_"+l).value;
			}
		}

		var vs_rule = temp_vs_rule.split("/");	
		var port_rule = temp_port_rule.split("/");
		var application_rule = temp_application_rule.split("/");
		var access_control_rule = temp_access_control_rule.split("/");

		var email_rule = get_by_id("log_email_schedule").value.split("/");
		var access_rule = get_by_id("asp_temp_01").value;

		var vs_rule_schedule = vs_rule[6];			
		var port_rule_schedule = port_rule[5];
		var application_rule_schedule = application_rule[6];
		var access_control_rule_schedule = access_control_rule[5];

		var email_rule_schedule = email_rule[3];
		var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
		var temp_wlan0_vap1_rule = get_by_id("wlan0_vap1_schedule").value; 
		var wlan0_rule = temp_wlan0_rule.split("/");	
		var wlan0_vap1_rule = temp_wlan0_vap1_rule.split("/");	
		var wlan0_rule_schedule = wlan0_rule[0];
		var wlan0_vap1_rule_schedule = wlan0_vap1_rule[0];

		if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)||(rule[0] == wlan0_vap1_rule_schedule)||(rule[0] == access_control_rule_schedule)){
			is_related = 1;
		}
	}

	if(is_related == 1){
		get_by_id("name").disabled = true;	
	}else{
		get_by_id("name").disabled = false;		
	}

	var week_str = new Array(7);
	var num=0;

	get_by_id("name").value=rule[0] ;

	for (var i = 0; i < 7; i++){
		if (rule[1].charAt(i) == "1"){
			week_str[i] = 1;
		}else{
			week_str[i] = 0;
		}
	}


	var p_all_week = get_by_name("all_week");
	if(rule[1] == "1111111"){
		p_all_week[0].checked = true;
		for(var j=0;j<7;j++){
			var temp_check = get_by_id("day" + j);
			temp_check.checked= false;	
		}
	}else{
		p_all_week[1].checked = true;

		for(var j=0;j<7;j++){
			if(week_str[j]== 1){
				var temp_check = get_by_id("day" + j);
				temp_check.checked= true;	
			}else{
				var temp_check = get_by_id("day" + j);
				temp_check.checked= false;
			}
		}

	}

	var time_format = rule[4];
	get_by_id("time_format").value = time_format;

	var all_day = 0;
	var st_hour, st_min, en_hour, en_min;

	if(rule[2] == "00:00" && rule[3] == "24:00") {
		all_day = 1;
	} else {
		var temp_s = rule[2].split(":");
		var temp_e = rule[3].split(":");
		st_hour = temp_s[0];
		en_hour = temp_e[0];
		
		if (parseInt(time_format,10) == 12){								
			if (parseInt(st_hour,10) >= 12){
				get_by_id("start_time").selectedIndex = 1;
				if (parseInt(st_hour,10) == 12){
					get_by_id("start_hour").value = get_digit_number(parseInt(st_hour,10));
				}else
					get_by_id("start_hour").value = get_digit_number(parseInt(st_hour,10)-12);
			}else{
				get_by_id("start_time").selectedIndex = 0;
				if (parseInt(st_hour,10) == 0){
					get_by_id("start_hour").value = get_digit_number(parseInt(st_hour,10)+12);
				}else
					get_by_id("start_hour").value = get_digit_number(parseInt(st_hour,10));
			}
			
			if (parseInt(en_hour,10) >= 12){
				get_by_id("end_time").selectedIndex = 1;
				if (parseInt(en_hour,10) == 12){
					get_by_id("end_hour").value = get_digit_number(parseInt(en_hour,10));
				}else
					get_by_id("end_hour").value = get_digit_number(parseInt(en_hour,10)-12);
			}else{
				get_by_id("end_time").selectedIndex = 0;
				if (parseInt(en_hour,10) == 0){
					get_by_id("end_hour").value = get_digit_number(parseInt(en_hour,10)+12);
				}else
					get_by_id("end_hour").value = get_digit_number(parseInt(en_hour,10));
			}
		}else{
			get_by_id("start_time").selectedIndex = 0;		
			get_by_id("end_time").selectedIndex = 0;
		get_by_id("start_hour").value = st_hour;
		get_by_id("end_hour").value = en_hour;
		}	

		st_min= temp_s[1];
		en_min= temp_e[1];
		get_by_id("start_min").value = st_min;
		get_by_id("end_min").value = en_min;

	}

	var p_time_type = get_by_id("time_type");
	if(all_day == 1){
		p_time_type.checked =true;
		get_by_id("start_hour").value = "00";
		get_by_id("start_min").value = "00";
		set_selectIndex(0,get_by_id("start_time"));
		get_by_id("end_hour").value = "00";
		get_by_id("end_min").value = "00";
		set_selectIndex(0,get_by_id("end_time"));
	}else{
		p_time_type.checked =false;
	}

	get_by_id("edit").value = index;
	change_color("table1", index+1);
	from_edit = 1;
	show_day();
	show_time();
	//show_ampm();
}

function del_row(row){	
	if (row < 10){
		var temp_rule = get_by_id("schedule_rule_0" + row).value;
	}else{
		var temp_rule = get_by_id("schedule_rule_" + row).value;
	}		
	var rule = temp_rule.split("/");

	for (var l=0 ;l <=rule_max_num ;l++){
		if(l<10){
			var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
			var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
			var temp_application_rule = get_by_id("application_0"+l).value;
			var temp_access_control_rule = get_by_id("access_control_0"+l).value;
		}else{
			if(l<24){
				var temp_rule = get_by_id("schedule_rule_" + l).value;
				var temp_vs_rule = get_by_id("vs_rule_" + l).value;
				var temp_port_rule = get_by_id("port_forward_both_" + l).value;
				var temp_application_rule = get_by_id("application_"+l).value;	
				var temp_access_control_rule = get_by_id("access_control_"+l).value;
			}
		}

		var vs_rule = temp_vs_rule.split("/");	
		var port_rule = temp_port_rule.split("/");
		var application_rule = temp_application_rule.split("/");
		var access_control_rule = temp_access_control_rule.split("/");

		var email_rule = get_by_id("log_email_schedule").value.split("/");
		var access_rule = get_by_id("asp_temp_01").value;

		var vs_rule_schedule = vs_rule[6];			
		var port_rule_schedule = port_rule[5];
		var application_rule_schedule = application_rule[6];
		var access_control_rule_schedule = access_control_rule[5];

		var email_rule_schedule = email_rule[3];
		var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
		var temp_wlan0_vap1_rule = get_by_id("wlan0_vap1_schedule").value; 
		var wlan0_rule = temp_wlan0_rule.split("/");	
		var wlan0_vap1_rule = temp_wlan0_vap1_rule.split("/");
		var wlan0_rule_schedule = wlan0_rule[0];
		var wlan0_vap1_rule_schedule = wlan0_vap1_rule[0];

		if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)||(rule[0] == wlan0_vap1_rule_schedule)||(rule[0] == access_control_rule_schedule) ){
			alert(TEXT063);
			return;
		}
	}
	//if (confirm(msg[DEL_SCHEDULE_MSG])){
	if (confirm(YM35)){
		get_by_id("del_row").value = row;
		delete_data();
		get_by_id("button").click();
	}else{
		return ;
	}

}

function delete_data(){
	var num =get_by_id("del_row").value;
	var num_next = parseInt(num,10)+1;

	for(var i = num_next ; i < rule_max_num; i++)
	{
		var pre_name = "", next_name = "";
		var j = i - 1;
		if (j < 10){
			pre_name = "schedule_rule_0" + j;
		}else{
			pre_name = "schedule_rule_" +  j;
		}

		if (i < 10){
			next_name = "schedule_rule_0" + i;
		}else{
			next_name = "schedule_rule_" +  i;
		}
		get_by_id(pre_name).value = get_by_id(next_name).value;

	}
	get_by_id("schedule_rule_09").value = "";
}

function set_text(which_text, which_value, set_default){
	var obj = get_by_id(which_text);

	if(obj == null){
		return;
	}
	obj.value = which_value;

	if (set_default){
		obj.defaultValue = which_value;
	}
}

function get_digit_number(num){
	var tmp_num = parseInt(num, 10);
	if (tmp_num <= 9){
		return "0" + tmp_num;
	}
	return tmp_num;
}

function show_ampm(){
	var format_time = parseInt(get_by_id("time_format").value,10);
	var start_hour = parseInt(get_by_id("start_hour").value,10);
	var end_hour = parseInt(get_by_id("end_hour").value,10);

	if(format_time == 24){
		get_by_id("start_time").disabled = true;
		get_by_id("end_time").disabled = true;
		if (get_by_id("start_time").selectedIndex == 0){
			if (start_hour == 12){
				set_text("start_hour", get_digit_number(start_hour-12), true);
			}else{
				set_text("start_hour", get_digit_number(start_hour), true);
			}
		} else {
			if(start_hour >= 12) {
				set_text("start_hour", get_digit_number(start_hour), true);
			}else{
				set_text("start_hour", get_digit_number(start_hour+12), true);
			}
		}

		if(get_by_id("end_time").selectedIndex == 0) {
			if(end_hour == 12) {
				set_text("end_hour", get_digit_number(end_hour - 12), true);
			} else {
				set_text("end_hour", get_digit_number(end_hour), true);
			}
		} else {
			if(end_hour >= 12) {
				set_text("end_hour", get_digit_number(end_hour), true);
			}else{
				set_text("end_hour", get_digit_number(end_hour+12), true);
			}
		}
		get_by_id("start_time").selectedIndex = 0;		
		get_by_id("end_time").selectedIndex = 0;
	}
	if(format_time == 12){
		get_by_id("start_time").disabled = false;
		get_by_id("end_time").disabled = false;
		if (start_hour < 12){
			get_by_id("start_time").selectedIndex = 0;
			set_text("start_hour", get_digit_number(start_hour), true);
			if (start_hour == 0){
				set_text("start_hour", get_digit_number(start_hour+12), true);
			}
		}else{
			get_by_id("start_time").selectedIndex = 1;
			set_text("start_hour", get_digit_number(start_hour-12), true);
			if (start_hour == 12){
				set_text("start_hour", get_digit_number(start_hour), true);
			}
		}

		if (end_hour < 12){
			get_by_id("end_time").selectedIndex = 0;
			set_text("end_hour", get_digit_number(end_hour), true);
			if (end_hour == 0){
				set_text("end_hour", get_digit_number(end_hour+12), true);
			}
		}else{
			get_by_id("end_time").selectedIndex = 1;
			set_text("end_hour", get_digit_number(end_hour-12), true);
			if (end_hour == 12){
				set_text("end_hour", get_digit_number(end_hour), true);
			}

		}
	}
}

function show_day(){
	var all_week = get_by_name("all_week");

	for (var i = 0; i < 7; i++){
		get_by_id("day" + i).disabled = all_week[0].checked;
	}
}

function show_time(){
	var time_type = get_by_id("time_type");
	var format_time = parseInt(get_by_id("time_format").value,10);
	var is_true = time_type.checked;

		if (format_time == 12){
			get_by_id("start_time").disabled = is_true;
			get_by_id("end_time").disabled = is_true;
	}else{
		get_by_id("start_time").disabled = true;
		get_by_id("end_time").disabled = true;
	}

	get_by_id("time_format").disabled = is_true;
	get_by_id("start_hour").disabled = is_true;
	get_by_id("start_min").disabled = is_true;

	get_by_id("end_hour").disabled = is_true;
	get_by_id("end_min").disabled = is_true;
} 

function update_data(){
	//check max row full
	if(get_by_id("edit").value == -1){ //add new row
		if(get_by_id("max_row").value >= parseInt(rule_max_num-1,10)){
			alert(TEXT015);
			return;
		}	
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
	var p_all_day = get_by_id("time_type");
	var time_format = parseInt(get_by_id("time_format").value,10);

	if (p_all_day.checked == true){			
		start_time_total = "00:00";
		end_time_total = "24:00";
		time_format = 24;
	}else{
		var s_hour,s_min;
		var e_hour,e_min;

		//start hour & end hour	
		if(time_format == 12){
			//12hr
			if(parseInt(get_by_id("start_time").value,10) == 1) {//pm
				s_hour = parseInt(time_hour(get_by_id("start_hour").value), 10) + 12;
			} else {//am
				s_hour = get_digit_number(time_hour(get_by_id("start_hour").value));
			}

			if(parseInt(get_by_id("end_time").value,10) == 1) {//pm
				e_hour = parseInt(time_hour(get_by_id("end_hour").value), 10) + 12;
			} else {//am
				e_hour = get_digit_number(time_hour(get_by_id("end_hour").value));
			}
		}else{
			//24hr
			s_hour = get_digit_number(get_by_id("start_hour").value);
			e_hour = get_digit_number(get_by_id("end_hour").value);
		}

		//start min
		s_min = get_digit_number(get_by_id("start_min").value);

		//end min	
		e_min = get_digit_number(get_by_id("end_min").value);

		start_time_total = s_hour + ":" + s_min;
		end_time_total = e_hour + ":" + e_min;
	}

	var dat = get_by_id("name").value +"/"+ days_in_week +"/"+ start_time_total +"/"+ end_time_total +"/"+ time_format;

	//alert(dat);

	var num;	
	if(get_by_id("edit").value != -1){	//edit row
		num = parseInt(get_by_id("edit").value,10);
	}else{ //add new row
		num = parseInt(get_by_id("max_row").value,10) + 1;
	}	

	if (num < 10){
		get_by_id("schedule_rule_0" + num).value = dat;
	}else{
		get_by_id("schedule_rule_" + num).value = dat;
	}
}

function time_hour(hour){
	var hour_c = hour;
	if (parseInt(hour,10) >= 12){
		hour_c = 0;
	}
	return hour_c;
}

function send_request(){
	if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		return false;
	}
	var time_type = get_by_id("time_type");
	var temp_obj = get_by_id("name").value;
	var time_format = parseInt(get_by_id("time_format").value,10);

	var all_week = get_by_name("all_week");

	if(!all_week[0].checked) {
		var check_day = 0;
		for (var i = 0; i < 7; i++){
			if(get_by_id("day"+ i).checked== true){
				check_day = 1
				break;
			}
		}

		if(check_day == 0) {
			alert(GW_SCHEDULES_DAY_INVALID);
			return false;
		}
				
	}
		
	if(get_by_id("del_row").value == "-1"){	
		if (get_by_id("name").value.length <= 0){
			alert(GW_SCHEDULES_NAME_INVALID);
			return false;

		}else if (Find_word(temp_obj,'"') || Find_word(temp_obj,"/")) {
			alert(tsc_SchRuLs_name + " " + illegal_characters + " " + temp_obj);
			return false;

		}else{
			//var temp_obj = get_by_id("name").value;
			var space_num = 0;
			for (i=0;i<temp_obj.length;i++){
				if (temp_obj.charAt(i)==" "){	
					space_num++
				}
			}
			if(parseInt(space_num,10) >= parseInt(temp_obj.length,10)){
				alert(GW_INET_ACL_SCHEDULE_NAME_INVALIDa);
				return false;
			}

			if((temp_obj == "Always")||(temp_obj == "Never") ){
				alert(GW_SCHEDULES_NAME_RESERVED_INVALIDa);
				return false;
			}
			for (i = 0; i < rule_max_num; i++){
				if (i < 10){
					var temp_rule = get_by_id("schedule_rule_0" + i).value;
				}else{
					var temp_rule = get_by_id("schedule_rule_" + i).value;
				}
				var rule = temp_rule.split("/");


				if (rule[0] != "" && !from_edit){			
					if (temp_obj == rule[0]){
						alert(TEXT066);
						return false;
					}						
				}
			}
		}
		if (!time_type.checked){
			if(time_format == 12){
				//12hr
				if (!check_integer(get_by_id("start_hour").value, 1, 12) || !check_integer(get_by_id("start_min").value, 0, 59)){
					alert(YM184);
					return false;
				}

				if (!check_integer(get_by_id("end_hour").value, 1, 12) || !check_integer(get_by_id("end_min").value, 0, 59)){
					alert(YM184);
					return false;
				}
			}else{
				//24hr
				if (!check_integer(get_by_id("start_hour").value, 0, 23) || !check_integer(get_by_id("start_min").value, 0, 59)){
					alert(YM184);
					return false;
				}

				if (!check_integer(get_by_id("end_hour").value, 0, 23) || !check_integer(get_by_id("end_min").value, 0, 59)){
					alert(YM184);
					return false;
				}
			}

		}
		update_data();
	}


	if(submit_button_flag == 0){
		submit_button_flag = 1;
		return true;
	}else{
		return false;
	}
}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
<tr>
<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
<td>&nbsp;</td>
</tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
</tr>
</table>
<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
<tr id="topnav_container">
<td><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("tools");</script>
</tr>
</table>
<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
<tr>
<td id="sidenav_container" valign="top" width="125" align="right">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td id="sidenav_container">
<div id="sidenav">
<ul>
<script>show_left("tools", 8);</script>
</ul>
</div>
</td>			
</tr>
</table>			
</td>
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_schedules.asp">
<!--input type="hidden" id="reboot_type" name="reboot_type" value="application"-->
<input type="hidden" id="action" name="action" value="tools_schedules">
<input type="hidden" id="edit" name="edit" value="-1">
<input type="hidden" id="del_row" name="del_row" value="-1">
<input type="hidden" id="max_row" name="max_row" value="-1">

<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<!--# echo log_email_schedule -->"> <!-- email -->
<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
<input type="hidden" id="schedule_rule_00" name="schedule_rule_00" value="<!--# echo schedule_rule_00 -->">
<input type="hidden" id="schedule_rule_01" name="schedule_rule_01" value="<!--# echo schedule_rule_01 -->">
<input type="hidden" id="schedule_rule_02" name="schedule_rule_02" value="<!--# echo schedule_rule_02 -->">
<input type="hidden" id="schedule_rule_03" name="schedule_rule_03" value="<!--# echo schedule_rule_03 -->">
<input type="hidden" id="schedule_rule_04" name="schedule_rule_04" value="<!--# echo schedule_rule_04 -->">
<input type="hidden" id="schedule_rule_05" name="schedule_rule_05" value="<!--# echo schedule_rule_05 -->">
<input type="hidden" id="schedule_rule_06" name="schedule_rule_06" value="<!--# echo schedule_rule_06 -->">
<input type="hidden" id="schedule_rule_07" name="schedule_rule_07" value="<!--# echo schedule_rule_07 -->">
<input type="hidden" id="schedule_rule_08" name="schedule_rule_08" value="<!--# echo schedule_rule_08 -->">
<input type="hidden" id="schedule_rule_09" name="schedule_rule_09" value="<!--# echo schedule_rule_09 -->">
<input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<!--# echo schedule_rule_10 -->">
<input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<!--# echo schedule_rule_11 -->">
<input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<!--# echo schedule_rule_12 -->">
<input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<!--# echo schedule_rule_13 -->">
<input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<!--# echo schedule_rule_14 -->">
<input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<!--# echo schedule_rule_15 -->">
<input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<!--# echo schedule_rule_16 -->">
<input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<!--# echo schedule_rule_17 -->">
<input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<!--# echo schedule_rule_18 -->">
<input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<!--# echo schedule_rule_19 -->">
<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<!--# echo schedule_rule_20 -->">
<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<!--# echo schedule_rule_21 -->">
<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<!--# echo schedule_rule_22 -->">
<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<!--# echo schedule_rule_23 -->">
<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<!--# echo schedule_rule_24 -->">
<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<!--# echo schedule_rule_25 -->">
<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<!--# echo schedule_rule_26 -->">
<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<!--# echo schedule_rule_27 -->">
<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<!--# echo schedule_rule_28 -->">
<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<!--# echo schedule_rule_29 -->">
<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<!--# echo schedule_rule_30 -->">
<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<!--# echo schedule_rule_31 -->">

<input type="hidden" id="port_forward_both_00" name="port_forward_both_00" value="<!--# echo port_forward_both_00 -->">
<input type="hidden" id="port_forward_both_01" name="port_forward_both_01" value="<!--# echo port_forward_both_01 -->">
<input type="hidden" id="port_forward_both_02" name="port_forward_both_02" value="<!--# echo port_forward_both_02 -->">
<input type="hidden" id="port_forward_both_03" name="port_forward_both_03" value="<!--# echo port_forward_both_03 -->">
<input type="hidden" id="port_forward_both_04" name="port_forward_both_04" value="<!--# echo port_forward_both_04 -->">
<input type="hidden" id="port_forward_both_05" name="port_forward_both_05" value="<!--# echo port_forward_both_05 -->">
<input type="hidden" id="port_forward_both_06" name="port_forward_both_06" value="<!--# echo port_forward_both_06 -->">
<input type="hidden" id="port_forward_both_07" name="port_forward_both_07" value="<!--# echo port_forward_both_07 -->">
<input type="hidden" id="port_forward_both_08" name="port_forward_both_08" value="<!--# echo port_forward_both_08 -->">
<input type="hidden" id="port_forward_both_09" name="port_forward_both_09" value="<!--# echo port_forward_both_09 -->">
<input type="hidden" id="port_forward_both_10" name="port_forward_both_10" value="<!--# echo port_forward_both_10 -->">
<input type="hidden" id="port_forward_both_11" name="port_forward_both_11" value="<!--# echo port_forward_both_11 -->">
<input type="hidden" id="port_forward_both_12" name="port_forward_both_12" value="<!--# echo port_forward_both_12 -->">
<input type="hidden" id="port_forward_both_13" name="port_forward_both_13" value="<!--# echo port_forward_both_13 -->">
<input type="hidden" id="port_forward_both_14" name="port_forward_both_14" value="<!--# echo port_forward_both_14 -->">
<input type="hidden" id="port_forward_both_15" name="port_forward_both_15" value="<!--# echo port_forward_both_15 -->">
<input type="hidden" id="port_forward_both_16" name="port_forward_both_16" value="<!--# echo port_forward_both_16 -->">
<input type="hidden" id="port_forward_both_17" name="port_forward_both_17" value="<!--# echo port_forward_both_17 -->">
<input type="hidden" id="port_forward_both_18" name="port_forward_both_18" value="<!--# echo port_forward_both_18 -->">
<input type="hidden" id="port_forward_both_19" name="port_forward_both_19" value="<!--# echo port_forward_both_19 -->">
<input type="hidden" id="port_forward_both_20" name="port_forward_both_20" value="<!--# echo port_forward_both_20 -->">
<input type="hidden" id="port_forward_both_21" name="port_forward_both_21" value="<!--# echo port_forward_both_21 -->">
<input type="hidden" id="port_forward_both_22" name="port_forward_both_22" value="<!--# echo port_forward_both_22 -->">
<input type="hidden" id="port_forward_both_23" name="port_forward_both_23" value="<!--# echo port_forward_both_23 -->">

<input type="hidden" id="application_00" name="application_00" value="<!--# echo application_00 -->">
<input type="hidden" id="application_01" name="application_01" value="<!--# echo application_01 -->">
<input type="hidden" id="application_02" name="application_02" value="<!--# echo application_02 -->">
<input type="hidden" id="application_03" name="application_03" value="<!--# echo application_03 -->">
<input type="hidden" id="application_04" name="application_04" value="<!--# echo application_04 -->">
<input type="hidden" id="application_05" name="application_05" value="<!--# echo application_05 -->">
<input type="hidden" id="application_06" name="application_06" value="<!--# echo application_06 -->">
<input type="hidden" id="application_07" name="application_07" value="<!--# echo application_07 -->">
<input type="hidden" id="application_08" name="application_08" value="<!--# echo application_08 -->">
<input type="hidden" id="application_09" name="application_09" value="<!--# echo application_09 -->">
<input type="hidden" id="application_10" name="application_10" value="<!--# echo application_10 -->">
<input type="hidden" id="application_11" name="application_11" value="<!--# echo application_11 -->">
<input type="hidden" id="application_12" name="application_12" value="<!--# echo application_12 -->">
<input type="hidden" id="application_13" name="application_13" value="<!--# echo application_13 -->">
<input type="hidden" id="application_14" name="application_14" value="<!--# echo application_14 -->">
<input type="hidden" id="application_15" name="application_15" value="<!--# echo application_15 -->">
<input type="hidden" id="application_16" name="application_16" value="<!--# echo application_16 -->">
<input type="hidden" id="application_17" name="application_17" value="<!--# echo application_17 -->">
<input type="hidden" id="application_18" name="application_18" value="<!--# echo application_18 -->">
<input type="hidden" id="application_19" name="application_19" value="<!--# echo application_19 -->">
<input type="hidden" id="application_20" name="application_20" value="<!--# echo application_20 -->">
<input type="hidden" id="application_21" name="application_21" value="<!--# echo application_21 -->">
<input type="hidden" id="application_22" name="application_22" value="<!--# echo application_22 -->">
<input type="hidden" id="application_23" name="application_23" value="<!--# echo application_23 -->">

<input type="hidden" id="vs_rule_00" name="vs_rule_00" value="<!--# echo vs_rule_00 -->">
<input type="hidden" id="vs_rule_01" name="vs_rule_01" value="<!--# echo vs_rule_01 -->">
<input type="hidden" id="vs_rule_02" name="vs_rule_02" value="<!--# echo vs_rule_02 -->">
<input type="hidden" id="vs_rule_03" name="vs_rule_03" value="<!--# echo vs_rule_03 -->">
<input type="hidden" id="vs_rule_04" name="vs_rule_04" value="<!--# echo vs_rule_04 -->">
<input type="hidden" id="vs_rule_05" name="vs_rule_05" value="<!--# echo vs_rule_05 -->">
<input type="hidden" id="vs_rule_06" name="vs_rule_06" value="<!--# echo vs_rule_06 -->">
<input type="hidden" id="vs_rule_07" name="vs_rule_07" value="<!--# echo vs_rule_07 -->">
<input type="hidden" id="vs_rule_08" name="vs_rule_08" value="<!--# echo vs_rule_08 -->">
<input type="hidden" id="vs_rule_09" name="vs_rule_09" value="<!--# echo vs_rule_09 -->">
<input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<!--# echo vs_rule_10 -->">
<input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<!--# echo vs_rule_11 -->">
<input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<!--# echo vs_rule_12 -->">
<input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<!--# echo vs_rule_13 -->">
<input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<!--# echo vs_rule_14 -->">
<input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<!--# echo vs_rule_15 -->">
<input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<!--# echo vs_rule_16 -->">
<input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<!--# echo vs_rule_17 -->">
<input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<!--# echo vs_rule_18 -->">
<input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<!--# echo vs_rule_19 -->">
<input type="hidden" id="vs_rule_20" name="vs_rule_20" value="<!--# echo vs_rule_20 -->">
<input type="hidden" id="vs_rule_21" name="vs_rule_21" value="<!--# echo vs_rule_21 -->">
<input type="hidden" id="vs_rule_22" name="vs_rule_22" value="<!--# echo vs_rule_22 -->">
<input type="hidden" id="vs_rule_23" name="vs_rule_23" value="<!--# echo vs_rule_23 -->">
<input type="hidden" id="wlan0_schedule" name="wlan0_schedule" value="<!--# echo wlan0_schedule -->">
<input type="hidden" id="wlan0_vap1_schedule" name="wlan0_vap1_schedule" value="<!--# echo wlan0_vap1_schedule -->">

<input type="hidden" id="access_control_00" name="access_control_00" value="<!--# echo access_control_00 -->">
<input type="hidden" id="access_control_01" name="access_control_01" value="<!--# echo access_control_01 -->">
<input type="hidden" id="access_control_02" name="access_control_02" value="<!--# echo access_control_02 -->">
<input type="hidden" id="access_control_03" name="access_control_03" value="<!--# echo access_control_03 -->">
<input type="hidden" id="access_control_04" name="access_control_04" value="<!--# echo access_control_04 -->">
<input type="hidden" id="access_control_05" name="access_control_05" value="<!--# echo access_control_05 -->">
<input type="hidden" id="access_control_06" name="access_control_06" value="<!--# echo access_control_06 -->">
<input type="hidden" id="access_control_07" name="access_control_07" value="<!--# echo access_control_07 -->">
<input type="hidden" id="access_control_08" name="access_control_08" value="<!--# echo access_control_08 -->">
<input type="hidden" id="access_control_09" name="access_control_09" value="<!--# echo access_control_09 -->">
<input type="hidden" id="access_control_10" name="access_control_10" value="<!--# echo access_control_10 -->">
<input type="hidden" id="access_control_11" name="access_control_11" value="<!--# echo access_control_11 -->">
<input type="hidden" id="access_control_12" name="access_control_12" value="<!--# echo access_control_12 -->">
<input type="hidden" id="access_control_13" name="access_control_13" value="<!--# echo access_control_13 -->">
<input type="hidden" id="access_control_14" name="access_control_14" value="<!--# echo access_control_14 -->">
<input type="hidden" id="access_control_15" name="access_control_15" value="<!--# echo access_control_15 -->">
<input type="hidden" id="access_control_16" name="access_control_16" value="<!--# echo access_control_16 -->">
<input type="hidden" id="access_control_17" name="access_control_17" value="<!--# echo access_control_17 -->">
<input type="hidden" id="access_control_18" name="access_control_18" value="<!--# echo access_control_18 -->">
<input type="hidden" id="access_control_19" name="access_control_19" value="<!--# echo access_control_19 -->">
<input type="hidden" id="access_control_20" name="access_control_20" value="<!--# echo access_control_20 -->">
<input type="hidden" id="access_control_21" name="access_control_21" value="<!--# echo access_control_21 -->">
<input type="hidden" id="access_control_22" name="access_control_22" value="<!--# echo access_control_22 -->">
<input type="hidden" id="access_control_23" name="access_control_23" value="<!--# echo access_control_23 -->">

<td valign="top" id="maincontent_container">
<div id="maincontent">

<div id="box_header"> 
<h1><script>show_words(_scheds)</script></h1>
<p><script>show_words(tsc_intro_Sch)</script></p>
<br>
<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
<input name="button2" id="button2" type=button class=button_submit value="" onclick="return page_cancel('form1', 'tools_schedules.asp');">
<script>check_reboot();</script>
<script>get_by_id("button").value = _savesettings</script>
<script>get_by_id("button2").value = _dontsavesettings</script>
</div>
<div class=box>
<h2><script>show_words(tsc_AddSchRu);</script></h2>
<table cellSpacing=1 cellPadding=1 width=525 border=0>
<tr>
<td width="150"><div align="right"><strong><script>show_words(_name)</script>&nbsp;:</strong>&nbsp;</div></td>
<td width="384" height="20" valign="top">&nbsp;&nbsp;<input id="name" name="name" type="text" size="20" maxlength="16"></td>
</tr>
<tr>
<td width="150">
<div align="right"><strong><script>show_words(_days)</script>&nbsp;:</strong>&nbsp;</div></td>
<td height="20" valign="top">&nbsp;<input type="radio" name="all_week" value="1" onClick="show_day()" checked>
<script>show_words(tsc_AllWk)</script>
&nbsp;<input type="radio" name="all_week" value="0" onClick="show_day()">
<script>show_words(tsc_SelDays)</script>                     
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
<div align="right"><strong>&nbsp;<script>show_words(tsc_TimeFormat)</script>&nbsp;:</strong>&nbsp;</div>
</td>
<td>
<div>&nbsp;
<select style="width: 80px" id="time_format" name="time_format"onChange="show_ampm()" >
<option value="24" ><script>show_words(tsc_24hour)</script></option>
<option value="12" ><script>show_words(tsc_12hour)</script></option>
</select>
</div>
</td>
</tr>
<tr>
<td width="150"><div align="right"><strong><script>show_words(tsc_StrTime)</script>&nbsp;:</strong>&nbsp;</div></td>
<td height="20" valign="top">&nbsp;&nbsp;
<input id="start_hour" name="start_hour" type="text" style="width: 40px" maxlength="2" value="12">:
<input id="start_min" name="start_min" type="text" style="width: 40px" maxlength="2" value="00">
<select style="width: 50px" id="start_time" name="start_time">
<option value="0"><script>show_words(_AM)</script></option>
<option value="1"><script>show_words(_PM)</script></option>
</select>&nbsp;<script>show_words(tsc_hrmin)</script>
</td>
</tr>
<tr>
<td width="150">
<div align="right"><span class="form_label"><strong><script>show_words(tsc_EndTime)</script>&nbsp;:&nbsp;</strong></span></div></td>
<td height="20" valign="top">&nbsp;&nbsp;
<input id="end_hour" name="end_hour" type="text" style="width: 40px" maxlength="2" value="12">:
<input id="end_min" name="end_min" type="text" style="width: 40px" maxlength="2" value="00">
<select style="width: 50px" id="end_time" name="end_time">
<option value="0"><script>show_words(_AM)</script></option>
<option value="1"><script>show_words(_PM)</script></option>
</select>&nbsp;<script>show_words(tsc_hrmin)</script>
</td>
</tr>
</table>
</div>
<div class=box>
<h2><script>show_words(tsc_SchRuLs)</script></h2>
<table id="table1" bordercolor="#ffffff" cellSpacing=1 cellPadding=2 width=525 bgcolor="#dfdfdf" border=1>
<tr>
<td width="165">
<div align="center"><strong><script>show_words(_name)</script>&nbsp;</strong>&nbsp;</div></td>
<td width="190"><div align="center"><strong><script>show_words(_days)</script>&nbsp;</strong>&nbsp;</div></td>
<td width="135"><div align="center"><strong><script>show_words(tsc_SchRuLs)</script>&nbsp;</strong></div></td>                      
<td width="15" valign="top">&nbsp;</td>
<td width="15" valign="top">&nbsp;</td>
</tr>
<script>	

for(i=0;i<rule_max_num;i++){

	if (i< 10){
		var temp_rule = get_by_id("schedule_rule_0" + i).value;
	}else{
		var temp_rule = get_by_id("schedule_rule_" + i).value;
	}
	if (temp_rule == ""){
		break;					
	}
	get_by_id("max_row").value = i;

	var rule = temp_rule.split("/");					
	var s = new Array();
	for(var j = 0; j < 8; j++){
		if(rule[1].charAt(j) == "1"){
			s[j] = "1";
		}else{
			s[j] = "0";
		}
	}

	var s_day = "", count = 0;
	for(var j = 0; j < 8; j++){			
		if(s[j] == "1"){
			s_day = s_day + " " + Week[j];
			count++;
		}
	}

	if(count == 7){
		s_day = tsc_AllWk;
	}

	var temp_time_array = rule[2]+ "~" + rule[3];
	if(rule[2]=="00:00" && rule[3]=="24:00"){
		temp_time_array = tsc_AllDay;
	}

	if(rule[4] == "12") {
		var hour_min = rule[2].split(":");
		if(hour_min[0] == 0)
			temp_time_array = 12 + ":" + hour_min[1] + " "+_AM+"~";	
		else if(hour_min[0] > 0 && hour_min[0] < 12)
			temp_time_array = rule[2] + " "+_AM+"~";
		else if(hour_min[0] == 12)
			temp_time_array = rule[2] + " "+_PM+"~";
		else if(hour_min[0] > 12 && hour_min[0] < 22)
			temp_time_array = "0" + (hour_min[0] - 12) + ":" + hour_min[1] + " "+_PM+"~";
		else
			temp_time_array = (hour_min[0] - 12) + ":" + hour_min[1] + " "+_PM+"~";

		var hour_min = rule[3].split(":");
		if(hour_min[0] == 0)
			temp_time_array += 12 + ":" + hour_min[1] + " "+_AM;	
		else if(hour_min[0] > 0 && hour_min[0] < 12)
			temp_time_array += rule[3] + " "+_AM;
		else if(hour_min[0] == 12)
			temp_time_array += rule[3] + " "+_PM;
		else if(hour_min[0] > 12 && hour_min[0] < 22)
			temp_time_array += "0" + (hour_min[0] - 12) + ":" + hour_min[1] + " "+_PM;
		else
			temp_time_array += (hour_min[0] - 12) + ":" + hour_min[1] + " "+_PM;
	}
	document.write("<tr><td align=\"center\">" + rule[0] + "</td><td align=\"center\">" + s_day + "</td><td align=\"center\">" + temp_time_array + "</td><td><a href=\"javascript:edit_row(" + i + ")\"><img src=\"/edit.jpg\" width=\"15\" height=\"17\" border=\"0\" alt=\"" + _edit +"\"></a></td><td><a href=\"javascript:del_row(" + i + ")\"><img src=\"/delete.jpg\" width=\"15\" height=\"18\" border=\"0\" alt=\"" + _delete + "\"></a></td></tr>");
}
</script>

</table>
</form>
<td valign="top" width="150" id="sidehelp_container" align="left">
<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
<tr>
<td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
<p><script>show_words(hhts_intro)</script></p>
<p><script>show_words(hhts_name)</script></p>
<p><script>show_words(hhts_save)</script></p>
<p><script>show_words(hhts_edit)</script></p>
<p><script>show_words(hhts_del)</script></p>
<p class="more"><a href="support_tools.asp#Schedules" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
</td>
</tr>
</table>
</td>
</tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
<td width="10">&nbsp;</td><td>&nbsp;</td>
</tr>
</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
reboot_needed(left["tools"].link[8]);
show_day();
show_ampm();
onPageLoad();
set_form_default_values("form1");
</script>
</html>
