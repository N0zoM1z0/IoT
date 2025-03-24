<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
var rule_max_num = 25;
var DataArray = new Array();

	function onPageLoad(){
		set_checked("<!--# echo access_control_filter_type -->", get_by_id("access_enable"));
		show_policy();
		set_form_default_values("form1");
		set_form_default_values("form2");
		
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}
		if(get_by_id("access_control_" + (rule_max_num - 1 )).value != ""){
			get_by_id("add_policy").disabled = true;
		}
				
		
	}   	

	function Data(enable, name, machine, filter, logged, schedule, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Machine = machine;
		this.Filter = filter;
		this.Logged = logged;
		this.Schedule = schedule;
		this.OnList = onList;
	}

	function set_policy(){
		var temp_policy, name_list, count = 0;
		for (var i = 0; i < rule_max_num; i++){
			if(i < 10){
				temp_policy = (get_by_id("access_control_0" + i).value).split("/");
			}else{
				temp_policy = (get_by_id("access_control_" + i).value).split("/");
			}
			if (temp_policy.length > 1){
				DataArray[i] = new Data(temp_policy[0], temp_policy[1], temp_policy[2], temp_policy[3], temp_policy[4], temp_policy[5], i);
				if(i == 0){
					name_list = temp_policy[1];
				}else{
					name_list = name_list + "," + temp_policy[1];
				}
				count++;
			}
		}
		
		get_by_id("asp_temp_13").value = name_list;
		get_by_id("asp_temp_16").value = count;
	}

	function set_policy_enable(idx){
		if(confirm(aa_ACC_08)){
			var temp_policy, policy;
			if(parseInt(idx) < 10){
				temp_policy = get_by_id("access_control_0" + idx);
			}else{
				temp_policy = get_by_id("access_control_" + idx);
			}
			var filter_type = (temp_policy.value).substring(0, 1);
			
			if(filter_type == "0"){
				temp_policy.value = "1" + (temp_policy.value).substring(1);
			}else{
				temp_policy.value = "0" + (temp_policy.value).substring(1);
			}
			send_submit("form1");
		} else
			window.location.href="adv_access_control.asp";

	}

	function edit_row(idx){
		get_by_id("asp_temp_00").value = DataArray[idx].Name;
		get_by_id("asp_temp_01").value = DataArray[idx].Schedule;
		get_by_id("asp_temp_02").value = DataArray[idx].Machine;
		get_by_id("asp_temp_03").value = DataArray[idx].Filter;
		get_by_id("asp_temp_12").value = DataArray[idx].Logged;
		var start = idx * 8;
		var end = (idx + 1) * 8;
		var index = 4;
		for(var i = start; i < end; i++){
			if(i < 10){
				if(parseInt(index) < 10){
					get_by_id("asp_temp_0" + index).value = get_by_id("firewall_rule_0" + i).value
				}else{
					get_by_id("asp_temp_" + index).value = get_by_id("firewall_rule_0" + i).value
				}
			}else{
				if(parseInt(index) < 10){
					get_by_id("asp_temp_0" + index).value = get_by_id("firewall_rule_" + i).value
				}else{
					get_by_id("asp_temp_" + index).value = get_by_id("firewall_rule_" + i).value
				}
			}
			index++;
		}

		get_by_id("asp_temp_14").value = idx;
		get_by_id("html_response_page").value = "adv_access_add1.asp";
		get_by_id("html_response_return_page").value = "adv_access_add1.asp";
		send_submit("form2");
	}

	function del_row(idx){
		if(confirm(up_ae_de_1)){
			delete_data(idx);
			send_submit("form1");
		}
	}

	function delete_data(idx){
		var num_next = parseInt(idx) + 1;

		//delete access_control entry
		for(var i = num_next; i < rule_max_num; i++){
			var pre_name, next_name, pre_firewall, next_firewall;
			
			if (i - 1 < 10){
				pre_name = "access_control_0" + (i-1);
			}else{
				pre_name = "access_control_" +  (i-1);
			}

			if (i < 10){
				next_name = "access_control_0" + i;
			}else{
				next_name = "access_control_" +  i;
			}
			get_by_id(pre_name).value = get_by_id(next_name).value;

			//delete firewall_rule entry
			var start = (i-1) * 8;
			var end = i * 8;
			for (var j = start; j < end; j++){
				if (j < 10){
					pre_firewall = "firewall_rule_0" + j;
				}else{
					pre_firewall = "firewall_rule_" + j;
				}

				if ((j + 8) < 10){
					next_firewall = "firewall_rule_0" + (j + 8);
				}else{
					next_firewall = "firewall_rule_" + (j + 8);
				}
				get_by_id(pre_firewall).value = get_by_id(next_firewall).value;
			}
		}
		get_by_id("access_control_24").value = "";
		for(var j = ((rule_max_num - 1) * 8); j < (rule_max_num * 8); j++){
			get_by_id("firewall_rule_" + j).value = "";
		}
	}
		
	function show_policy(){
		get_by_id("show_policy").style.display = "none";		
		get_by_id("show_table").style.display = "none";	
		if (get_by_id("access_enable").checked){
			get_by_id("show_policy").style.display = "";		
			get_by_id("show_table").style.display = "";	
		}
		get_by_id("access_control_filter_type").value = get_checked_value(get_by_id("access_enable"));

	}
	
	function send_next(){
		for(var i = 0; i < 13; i++){
			if(i < 10){
				get_by_id("asp_temp_0" + i).value = "";
			}else{
				get_by_id("asp_temp_" + i).value = "";
			}
		}
		get_by_id("asp_temp_14").value = "-1";
		get_by_id("html_response_page").value = "adv_access_add.asp";
		get_by_id("html_response_return_page").value = "adv_access_add.asp";
		send_submit("form2");
	}

	function send_request(){
		if (!is_form_modified("form1") && !is_form_modified("form2") && !confirm(LS3)) {
			return false;
		}
		get_by_id("access_control_filter_type").value = get_checked_value(get_by_id("access_enable"));
			send_submit("form1");
	}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form2" name="form2" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page">
<input type="hidden" id="html_response_return_page" name="html_response_return_page">
<input type="hidden" id="action" name="action" value="response_page">
<input type="hidden" id="reboot_type" name="reboot_type" value="none">

<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="">	<!-- Policy Name -->
<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="">	<!-- schedule -->
<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="">	<!-- Machine -->
<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="">	<!-- filter method -->
<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="">	<!-- firewall rule 1 -->
<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="">	<!-- firewall rule 2 -->
<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="">	<!-- firewall rule 3 -->
<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="">	<!-- firewall rule 4 -->
<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="">	<!-- firewall rule 5 -->
<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="">	<!-- firewall rule 6 -->
<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="">	<!-- firewall rule 7 -->
<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="">	<!-- firewall rule 8 -->
<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="">	<!-- logging -->
<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="">	<!-- Policy Name list -->
<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="">	<!-- edit_row -->
<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="">	<!-- prev_page -->
<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="">	<!-- max_row -->

</form>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
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
			<td height="29"><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 5);</script>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                </table>
			</td>

        <form id="form1" name="form1" method="post" action="apply.cgi">
	    <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
	    <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
	    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_control.asp">
	    <input type="hidden" id="reboot_type" name="reboot_type" value="filter">
	    <input type="hidden" id="action" name="action" value="adv_access_control">
		<input type="hidden" id="access_control_filter_type" name="access_control_filter_type" value="<!--# echo access_control_filter_type -->">

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
		<input type="hidden" id="access_control_24" name="access_control_24" value="<!--# echo access_control_24 -->">

		<input type="hidden" id="firewall_rule_00" name="firewall_rule_00" value="<!--# echo firewall_rule_00 -->">
		<input type="hidden" id="firewall_rule_01" name="firewall_rule_01" value="<!--# echo firewall_rule_01 -->">
		<input type="hidden" id="firewall_rule_02" name="firewall_rule_02" value="<!--# echo firewall_rule_02 -->">
		<input type="hidden" id="firewall_rule_03" name="firewall_rule_03" value="<!--# echo firewall_rule_03 -->">
		<input type="hidden" id="firewall_rule_04" name="firewall_rule_04" value="<!--# echo firewall_rule_04 -->">
		<input type="hidden" id="firewall_rule_05" name="firewall_rule_05" value="<!--# echo firewall_rule_05 -->">
		<input type="hidden" id="firewall_rule_06" name="firewall_rule_06" value="<!--# echo firewall_rule_06 -->">
		<input type="hidden" id="firewall_rule_07" name="firewall_rule_07" value="<!--# echo firewall_rule_07 -->">
		
		<input type="hidden" id="firewall_rule_08" name="firewall_rule_08" value="<!--# echo firewall_rule_08 -->">
		<input type="hidden" id="firewall_rule_09" name="firewall_rule_09" value="<!--# echo firewall_rule_09 -->">
		<input type="hidden" id="firewall_rule_10" name="firewall_rule_10" value="<!--# echo firewall_rule_10 -->">
		<input type="hidden" id="firewall_rule_11" name="firewall_rule_11" value="<!--# echo firewall_rule_11 -->">
		<input type="hidden" id="firewall_rule_12" name="firewall_rule_12" value="<!--# echo firewall_rule_12 -->">
		<input type="hidden" id="firewall_rule_13" name="firewall_rule_13" value="<!--# echo firewall_rule_13 -->">
		<input type="hidden" id="firewall_rule_14" name="firewall_rule_14" value="<!--# echo firewall_rule_14 -->">
		<input type="hidden" id="firewall_rule_15" name="firewall_rule_15" value="<!--# echo firewall_rule_15 -->">
		
		<input type="hidden" id="firewall_rule_16" name="firewall_rule_16" value="<!--# echo firewall_rule_16 -->">
		<input type="hidden" id="firewall_rule_17" name="firewall_rule_17" value="<!--# echo firewall_rule_17 -->">
		<input type="hidden" id="firewall_rule_18" name="firewall_rule_18" value="<!--# echo firewall_rule_18 -->">
		<input type="hidden" id="firewall_rule_19" name="firewall_rule_19" value="<!--# echo firewall_rule_19 -->">
		<input type="hidden" id="firewall_rule_20" name="firewall_rule_20" value="<!--# echo firewall_rule_20 -->">
		<input type="hidden" id="firewall_rule_21" name="firewall_rule_21" value="<!--# echo firewall_rule_21 -->">
		<input type="hidden" id="firewall_rule_22" name="firewall_rule_22" value="<!--# echo firewall_rule_22 -->">
		<input type="hidden" id="firewall_rule_23" name="firewall_rule_23" value="<!--# echo firewall_rule_23 -->">
		
		<input type="hidden" id="firewall_rule_24" name="firewall_rule_24" value="<!--# echo firewall_rule_24 -->">
		<input type="hidden" id="firewall_rule_25" name="firewall_rule_25" value="<!--# echo firewall_rule_25 -->">
		<input type="hidden" id="firewall_rule_26" name="firewall_rule_26" value="<!--# echo firewall_rule_26 -->">
		<input type="hidden" id="firewall_rule_27" name="firewall_rule_27" value="<!--# echo firewall_rule_27 -->">
		<input type="hidden" id="firewall_rule_28" name="firewall_rule_28" value="<!--# echo firewall_rule_28 -->">
		<input type="hidden" id="firewall_rule_29" name="firewall_rule_29" value="<!--# echo firewall_rule_29 -->">
		<input type="hidden" id="firewall_rule_30" name="firewall_rule_30" value="<!--# echo firewall_rule_30 -->">
		<input type="hidden" id="firewall_rule_31" name="firewall_rule_31" value="<!--# echo firewall_rule_31 -->">
		
		<input type="hidden" id="firewall_rule_32" name="firewall_rule_32" value="<!--# echo firewall_rule_32 -->">
		<input type="hidden" id="firewall_rule_33" name="firewall_rule_33" value="<!--# echo firewall_rule_33 -->">
		<input type="hidden" id="firewall_rule_34" name="firewall_rule_34" value="<!--# echo firewall_rule_34 -->">
		<input type="hidden" id="firewall_rule_35" name="firewall_rule_35" value="<!--# echo firewall_rule_35 -->">
		<input type="hidden" id="firewall_rule_36" name="firewall_rule_36" value="<!--# echo firewall_rule_36 -->">
		<input type="hidden" id="firewall_rule_37" name="firewall_rule_37" value="<!--# echo firewall_rule_37 -->">
		<input type="hidden" id="firewall_rule_38" name="firewall_rule_38" value="<!--# echo firewall_rule_38 -->">
		<input type="hidden" id="firewall_rule_39" name="firewall_rule_39" value="<!--# echo firewall_rule_39 -->">
		
		<input type="hidden" id="firewall_rule_40" name="firewall_rule_40" value="<!--# echo firewall_rule_40 -->">
		<input type="hidden" id="firewall_rule_41" name="firewall_rule_41" value="<!--# echo firewall_rule_41 -->">
		<input type="hidden" id="firewall_rule_42" name="firewall_rule_42" value="<!--# echo firewall_rule_42 -->">
		<input type="hidden" id="firewall_rule_43" name="firewall_rule_43" value="<!--# echo firewall_rule_43 -->">
		<input type="hidden" id="firewall_rule_44" name="firewall_rule_44" value="<!--# echo firewall_rule_44 -->">
		<input type="hidden" id="firewall_rule_45" name="firewall_rule_45" value="<!--# echo firewall_rule_45 -->">
		<input type="hidden" id="firewall_rule_46" name="firewall_rule_46" value="<!--# echo firewall_rule_46 -->">
		<input type="hidden" id="firewall_rule_47" name="firewall_rule_47" value="<!--# echo firewall_rule_47 -->">
		
		<input type="hidden" id="firewall_rule_48" name="firewall_rule_48" value="<!--# echo firewall_rule_48 -->">
		<input type="hidden" id="firewall_rule_49" name="firewall_rule_49" value="<!--# echo firewall_rule_49 -->">
		<input type="hidden" id="firewall_rule_50" name="firewall_rule_50" value="<!--# echo firewall_rule_50 -->">
		<input type="hidden" id="firewall_rule_51" name="firewall_rule_51" value="<!--# echo firewall_rule_51 -->">
		<input type="hidden" id="firewall_rule_52" name="firewall_rule_52" value="<!--# echo firewall_rule_52 -->">
		<input type="hidden" id="firewall_rule_53" name="firewall_rule_53" value="<!--# echo firewall_rule_53 -->">
		<input type="hidden" id="firewall_rule_54" name="firewall_rule_54" value="<!--# echo firewall_rule_54 -->">
		<input type="hidden" id="firewall_rule_55" name="firewall_rule_55" value="<!--# echo firewall_rule_55 -->">
		
		<input type="hidden" id="firewall_rule_56" name="firewall_rule_56" value="<!--# echo firewall_rule_56 -->">
		<input type="hidden" id="firewall_rule_57" name="firewall_rule_57" value="<!--# echo firewall_rule_57 -->">
		<input type="hidden" id="firewall_rule_58" name="firewall_rule_58" value="<!--# echo firewall_rule_58 -->">
		<input type="hidden" id="firewall_rule_59" name="firewall_rule_59" value="<!--# echo firewall_rule_59 -->">
		<input type="hidden" id="firewall_rule_60" name="firewall_rule_60" value="<!--# echo firewall_rule_60 -->">
		<input type="hidden" id="firewall_rule_61" name="firewall_rule_61" value="<!--# echo firewall_rule_61 -->">
		<input type="hidden" id="firewall_rule_62" name="firewall_rule_62" value="<!--# echo firewall_rule_62 -->">
		<input type="hidden" id="firewall_rule_63" name="firewall_rule_63" value="<!--# echo firewall_rule_63 -->">
		
		<input type="hidden" id="firewall_rule_64" name="firewall_rule_64" value="<!--# echo firewall_rule_64 -->">
		<input type="hidden" id="firewall_rule_65" name="firewall_rule_65" value="<!--# echo firewall_rule_65 -->">
		<input type="hidden" id="firewall_rule_66" name="firewall_rule_66" value="<!--# echo firewall_rule_66 -->">
		<input type="hidden" id="firewall_rule_67" name="firewall_rule_67" value="<!--# echo firewall_rule_67 -->">
		<input type="hidden" id="firewall_rule_68" name="firewall_rule_68" value="<!--# echo firewall_rule_68 -->">
		<input type="hidden" id="firewall_rule_69" name="firewall_rule_69" value="<!--# echo firewall_rule_69 -->">
		<input type="hidden" id="firewall_rule_70" name="firewall_rule_70" value="<!--# echo firewall_rule_70 -->">
		<input type="hidden" id="firewall_rule_71" name="firewall_rule_71" value="<!--# echo firewall_rule_71 -->">
		
		<input type="hidden" id="firewall_rule_72" name="firewall_rule_72" value="<!--# echo firewall_rule_72 -->">
		<input type="hidden" id="firewall_rule_73" name="firewall_rule_73" value="<!--# echo firewall_rule_73 -->">
		<input type="hidden" id="firewall_rule_74" name="firewall_rule_74" value="<!--# echo firewall_rule_74 -->">
		<input type="hidden" id="firewall_rule_75" name="firewall_rule_75" value="<!--# echo firewall_rule_75 -->">
		<input type="hidden" id="firewall_rule_76" name="firewall_rule_76" value="<!--# echo firewall_rule_76 -->">
		<input type="hidden" id="firewall_rule_77" name="firewall_rule_77" value="<!--# echo firewall_rule_77 -->">
		<input type="hidden" id="firewall_rule_78" name="firewall_rule_78" value="<!--# echo firewall_rule_78 -->">
		<input type="hidden" id="firewall_rule_79" name="firewall_rule_79" value="<!--# echo firewall_rule_79 -->">
		
		<input type="hidden" id="firewall_rule_80" name="firewall_rule_80" value="<!--# echo firewall_rule_80 -->">
		<input type="hidden" id="firewall_rule_81" name="firewall_rule_81" value="<!--# echo firewall_rule_81 -->">
		<input type="hidden" id="firewall_rule_82" name="firewall_rule_82" value="<!--# echo firewall_rule_82 -->">
		<input type="hidden" id="firewall_rule_83" name="firewall_rule_83" value="<!--# echo firewall_rule_83 -->">
		<input type="hidden" id="firewall_rule_84" name="firewall_rule_84" value="<!--# echo firewall_rule_84 -->">
		<input type="hidden" id="firewall_rule_85" name="firewall_rule_85" value="<!--# echo firewall_rule_85 -->">
		<input type="hidden" id="firewall_rule_86" name="firewall_rule_86" value="<!--# echo firewall_rule_86 -->">
		<input type="hidden" id="firewall_rule_87" name="firewall_rule_87" value="<!--# echo firewall_rule_87 -->">
		
		<input type="hidden" id="firewall_rule_88" name="firewall_rule_88" value="<!--# echo firewall_rule_88 -->">
		<input type="hidden" id="firewall_rule_89" name="firewall_rule_89" value="<!--# echo firewall_rule_89 -->">
		<input type="hidden" id="firewall_rule_90" name="firewall_rule_90" value="<!--# echo firewall_rule_90 -->">
		<input type="hidden" id="firewall_rule_91" name="firewall_rule_91" value="<!--# echo firewall_rule_91 -->">
		<input type="hidden" id="firewall_rule_92" name="firewall_rule_92" value="<!--# echo firewall_rule_92 -->">
		<input type="hidden" id="firewall_rule_93" name="firewall_rule_93" value="<!--# echo firewall_rule_93 -->">
		<input type="hidden" id="firewall_rule_94" name="firewall_rule_94" value="<!--# echo firewall_rule_94 -->">
		<input type="hidden" id="firewall_rule_95" name="firewall_rule_95" value="<!--# echo firewall_rule_95 -->">
		
		<input type="hidden" id="firewall_rule_96" name="firewall_rule_96" value="<!--# echo firewall_rule_96 -->">
		<input type="hidden" id="firewall_rule_97" name="firewall_rule_97" value="<!--# echo firewall_rule_97 -->">
		<input type="hidden" id="firewall_rule_98" name="firewall_rule_98" value="<!--# echo firewall_rule_98 -->">
		<input type="hidden" id="firewall_rule_99" name="firewall_rule_99" value="<!--# echo firewall_rule_99 -->">
		<input type="hidden" id="firewall_rule_100" name="firewall_rule_100" value="<!--# echo firewall_rule_100 -->">
		<input type="hidden" id="firewall_rule_101" name="firewall_rule_101" value="<!--# echo firewall_rule_101 -->">
		<input type="hidden" id="firewall_rule_102" name="firewall_rule_102" value="<!--# echo firewall_rule_102 -->">
		<input type="hidden" id="firewall_rule_103" name="firewall_rule_103" value="<!--# echo firewall_rule_103 -->">
		
		<input type="hidden" id="firewall_rule_104" name="firewall_rule_104" value="<!--# echo firewall_rule_104 -->">
		<input type="hidden" id="firewall_rule_105" name="firewall_rule_105" value="<!--# echo firewall_rule_105 -->">
		<input type="hidden" id="firewall_rule_106" name="firewall_rule_106" value="<!--# echo firewall_rule_106 -->">
		<input type="hidden" id="firewall_rule_107" name="firewall_rule_107" value="<!--# echo firewall_rule_107 -->">
		<input type="hidden" id="firewall_rule_108" name="firewall_rule_108" value="<!--# echo firewall_rule_108 -->">
		<input type="hidden" id="firewall_rule_109" name="firewall_rule_109" value="<!--# echo firewall_rule_109 -->">
		<input type="hidden" id="firewall_rule_110" name="firewall_rule_110" value="<!--# echo firewall_rule_110 -->">
		<input type="hidden" id="firewall_rule_111" name="firewall_rule_111" value="<!--# echo firewall_rule_111 -->">

		<input type="hidden" id="firewall_rule_112" name="firewall_rule_112" value="<!--# echo firewall_rule_112 -->">
		<input type="hidden" id="firewall_rule_113" name="firewall_rule_113" value="<!--# echo firewall_rule_113 -->">
		<input type="hidden" id="firewall_rule_114" name="firewall_rule_114" value="<!--# echo firewall_rule_114 -->">
		<input type="hidden" id="firewall_rule_115" name="firewall_rule_115" value="<!--# echo firewall_rule_115 -->">
		<input type="hidden" id="firewall_rule_116" name="firewall_rule_116" value="<!--# echo firewall_rule_116 -->">
		<input type="hidden" id="firewall_rule_117" name="firewall_rule_117" value="<!--# echo firewall_rule_117 -->">
		<input type="hidden" id="firewall_rule_118" name="firewall_rule_118" value="<!--# echo firewall_rule_118 -->">
		<input type="hidden" id="firewall_rule_119" name="firewall_rule_119" value="<!--# echo firewall_rule_119 -->">
		<input type="hidden" id="firewall_rule_120" name="firewall_rule_120" value="<!--# echo firewall_rule_120 -->">
		<input type="hidden" id="firewall_rule_121" name="firewall_rule_121" value="<!--# echo firewall_rule_121 -->">
		<input type="hidden" id="firewall_rule_122" name="firewall_rule_122" value="<!--# echo firewall_rule_122 -->">
		<input type="hidden" id="firewall_rule_123" name="firewall_rule_123" value="<!--# echo firewall_rule_123 -->">
		<input type="hidden" id="firewall_rule_124" name="firewall_rule_124" value="<!--# echo firewall_rule_124 -->">
		<input type="hidden" id="firewall_rule_125" name="firewall_rule_125" value="<!--# echo firewall_rule_125 -->">
		<input type="hidden" id="firewall_rule_126" name="firewall_rule_126" value="<!--# echo firewall_rule_126 -->">
		<input type="hidden" id="firewall_rule_127" name="firewall_rule_127" value="<!--# echo firewall_rule_127 -->">
		<input type="hidden" id="firewall_rule_128" name="firewall_rule_128" value="<!--# echo firewall_rule_128 -->">
		<input type="hidden" id="firewall_rule_129" name="firewall_rule_129" value="<!--# echo firewall_rule_129 -->">
		<input type="hidden" id="firewall_rule_130" name="firewall_rule_130" value="<!--# echo firewall_rule_130 -->">
		<input type="hidden" id="firewall_rule_131" name="firewall_rule_131" value="<!--# echo firewall_rule_131 -->">
		<input type="hidden" id="firewall_rule_132" name="firewall_rule_132" value="<!--# echo firewall_rule_132 -->">
		<input type="hidden" id="firewall_rule_133" name="firewall_rule_133" value="<!--# echo firewall_rule_133 -->">
		<input type="hidden" id="firewall_rule_134" name="firewall_rule_134" value="<!--# echo firewall_rule_134 -->">
		<input type="hidden" id="firewall_rule_135" name="firewall_rule_135" value="<!--# echo firewall_rule_135 -->">
		<input type="hidden" id="firewall_rule_136" name="firewall_rule_136" value="<!--# echo firewall_rule_136 -->">
		<input type="hidden" id="firewall_rule_137" name="firewall_rule_137" value="<!--# echo firewall_rule_137 -->">
		<input type="hidden" id="firewall_rule_138" name="firewall_rule_138" value="<!--# echo firewall_rule_138 -->">
		<input type="hidden" id="firewall_rule_139" name="firewall_rule_139" value="<!--# echo firewall_rule_139 -->">
		<input type="hidden" id="firewall_rule_140" name="firewall_rule_140" value="<!--# echo firewall_rule_140 -->">
		<input type="hidden" id="firewall_rule_141" name="firewall_rule_141" value="<!--# echo firewall_rule_141 -->">
		<input type="hidden" id="firewall_rule_142" name="firewall_rule_142" value="<!--# echo firewall_rule_142 -->">
		<input type="hidden" id="firewall_rule_143" name="firewall_rule_143" value="<!--# echo firewall_rule_143 -->">
		<input type="hidden" id="firewall_rule_144" name="firewall_rule_144" value="<!--# echo firewall_rule_144 -->">
		<input type="hidden" id="firewall_rule_145" name="firewall_rule_145" value="<!--# echo firewall_rule_145 -->">
		<input type="hidden" id="firewall_rule_146" name="firewall_rule_146" value="<!--# echo firewall_rule_146 -->">
		<input type="hidden" id="firewall_rule_147" name="firewall_rule_147" value="<!--# echo firewall_rule_147 -->">
		<input type="hidden" id="firewall_rule_148" name="firewall_rule_148" value="<!--# echo firewall_rule_148 -->">
		<input type="hidden" id="firewall_rule_149" name="firewall_rule_149" value="<!--# echo firewall_rule_149 -->">
		<input type="hidden" id="firewall_rule_150" name="firewall_rule_150" value="<!--# echo firewall_rule_150 -->">
		<input type="hidden" id="firewall_rule_151" name="firewall_rule_151" value="<!--# echo firewall_rule_151 -->">
		<input type="hidden" id="firewall_rule_152" name="firewall_rule_152" value="<!--# echo firewall_rule_152 -->">
		<input type="hidden" id="firewall_rule_153" name="firewall_rule_153" value="<!--# echo firewall_rule_153 -->">
		<input type="hidden" id="firewall_rule_154" name="firewall_rule_154" value="<!--# echo firewall_rule_154 -->">
		<input type="hidden" id="firewall_rule_155" name="firewall_rule_155" value="<!--# echo firewall_rule_155 -->">
		<input type="hidden" id="firewall_rule_156" name="firewall_rule_156" value="<!--# echo firewall_rule_156 -->">
		<input type="hidden" id="firewall_rule_157" name="firewall_rule_157" value="<!--# echo firewall_rule_157 -->">
		<input type="hidden" id="firewall_rule_158" name="firewall_rule_158" value="<!--# echo firewall_rule_158 -->">
		<input type="hidden" id="firewall_rule_159" name="firewall_rule_159" value="<!--# echo firewall_rule_159 -->">
		<input type="hidden" id="firewall_rule_160" name="firewall_rule_160" value="<!--# echo firewall_rule_160 -->">
		<input type="hidden" id="firewall_rule_161" name="firewall_rule_161" value="<!--# echo firewall_rule_161 -->">
		<input type="hidden" id="firewall_rule_162" name="firewall_rule_162" value="<!--# echo firewall_rule_162 -->">
		<input type="hidden" id="firewall_rule_163" name="firewall_rule_163" value="<!--# echo firewall_rule_163 -->">
		<input type="hidden" id="firewall_rule_164" name="firewall_rule_164" value="<!--# echo firewall_rule_164 -->">
		<input type="hidden" id="firewall_rule_165" name="firewall_rule_165" value="<!--# echo firewall_rule_165 -->">
		<input type="hidden" id="firewall_rule_166" name="firewall_rule_166" value="<!--# echo firewall_rule_166 -->">
		<input type="hidden" id="firewall_rule_167" name="firewall_rule_167" value="<!--# echo firewall_rule_167 -->">
		<input type="hidden" id="firewall_rule_168" name="firewall_rule_168" value="<!--# echo firewall_rule_168 -->">
		<input type="hidden" id="firewall_rule_169" name="firewall_rule_169" value="<!--# echo firewall_rule_169 -->">
		<input type="hidden" id="firewall_rule_170" name="firewall_rule_170" value="<!--# echo firewall_rule_170 -->">
		<input type="hidden" id="firewall_rule_171" name="firewall_rule_171" value="<!--# echo firewall_rule_171 -->">
		<input type="hidden" id="firewall_rule_172" name="firewall_rule_172" value="<!--# echo firewall_rule_172 -->">
		<input type="hidden" id="firewall_rule_173" name="firewall_rule_173" value="<!--# echo firewall_rule_173 -->">
		<input type="hidden" id="firewall_rule_174" name="firewall_rule_174" value="<!--# echo firewall_rule_174 -->">
		<input type="hidden" id="firewall_rule_175" name="firewall_rule_175" value="<!--# echo firewall_rule_175 -->">
		<input type="hidden" id="firewall_rule_176" name="firewall_rule_176" value="<!--# echo firewall_rule_176 -->">
		<input type="hidden" id="firewall_rule_177" name="firewall_rule_177" value="<!--# echo firewall_rule_177 -->">
		<input type="hidden" id="firewall_rule_178" name="firewall_rule_178" value="<!--# echo firewall_rule_178 -->">
		<input type="hidden" id="firewall_rule_179" name="firewall_rule_179" value="<!--# echo firewall_rule_179 -->">
		<input type="hidden" id="firewall_rule_180" name="firewall_rule_180" value="<!--# echo firewall_rule_180 -->">
		<input type="hidden" id="firewall_rule_181" name="firewall_rule_181" value="<!--# echo firewall_rule_181 -->">
		<input type="hidden" id="firewall_rule_182" name="firewall_rule_182" value="<!--# echo firewall_rule_182 -->">
		<input type="hidden" id="firewall_rule_183" name="firewall_rule_183" value="<!--# echo firewall_rule_183 -->">
		<input type="hidden" id="firewall_rule_184" name="firewall_rule_184" value="<!--# echo firewall_rule_184 -->">
		<input type="hidden" id="firewall_rule_185" name="firewall_rule_185" value="<!--# echo firewall_rule_185 -->">
		<input type="hidden" id="firewall_rule_186" name="firewall_rule_186" value="<!--# echo firewall_rule_186 -->">
		<input type="hidden" id="firewall_rule_187" name="firewall_rule_187" value="<!--# echo firewall_rule_187 -->">
		<input type="hidden" id="firewall_rule_188" name="firewall_rule_188" value="<!--# echo firewall_rule_188 -->">
		<input type="hidden" id="firewall_rule_189" name="firewall_rule_189" value="<!--# echo firewall_rule_189 -->">
		<input type="hidden" id="firewall_rule_190" name="firewall_rule_190" value="<!--# echo firewall_rule_190 -->">
		<input type="hidden" id="firewall_rule_191" name="firewall_rule_191" value="<!--# echo firewall_rule_191 -->">
		<input type="hidden" id="firewall_rule_192" name="firewall_rule_192" value="<!--# echo firewall_rule_192 -->">
		<input type="hidden" id="firewall_rule_193" name="firewall_rule_193" value="<!--# echo firewall_rule_193 -->">
		<input type="hidden" id="firewall_rule_194" name="firewall_rule_194" value="<!--# echo firewall_rule_194 -->">
		<input type="hidden" id="firewall_rule_195" name="firewall_rule_195" value="<!--# echo firewall_rule_195 -->">
		<input type="hidden" id="firewall_rule_196" name="firewall_rule_196" value="<!--# echo firewall_rule_196 -->">
		<input type="hidden" id="firewall_rule_197" name="firewall_rule_197" value="<!--# echo firewall_rule_197 -->">
		<input type="hidden" id="firewall_rule_198" name="firewall_rule_198" value="<!--# echo firewall_rule_198 -->">
		<input type="hidden" id="firewall_rule_199" name="firewall_rule_199" value="<!--# echo firewall_rule_199 -->">
		<input type="hidden" id="firewall_rule_200" name="firewall_rule_200" value="<!--# echo firewall_rule_200 -->">

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
			  <div id=box_header> 
				<h1><script>show_words(ACCESS_CONTROL);</script></h1>
				<script>show_words(aa_intro);</script>
				<br><br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
				<input name="button2" id="button2" type="reset" class=button_submit value="" onClick="window.location.href='adv_access_control.asp'">
				<script>check_reboot();</script>
					<script>get_by_id("button").value = _savesettings;</script>
					<script>get_by_id("button2").value = _dontsavesettings;</script>
			  </div>
			  <div class=box>
			  <h2><script>show_words(ACCESS_CONTROL);</script></h2>
				<table width="525">
					<tr> 
					  <td class="duple"><script>show_words(aa_EAC);</script> :</td>
						<input type=hidden id="edit_row" name="edit_row" value=-1>
						<input type="hidden" id="del_row" name="del_row" value="0">  
						<input type="hidden" id="serial" name="serial" value="0">
					  <td width="340">&nbsp;<input type=checkbox id="access_enable" name="access_enable" value="enable" onClick="show_policy()"></td>
					</tr>
					<tr id="show_policy" style="display:none">
						<td class="duple">&nbsp;</td>
						<td width="340">&nbsp;
						<input type=button id="add_policy" name="add_policy" value="Add Policy" onClick="send_next();">
						<script>get_by_id("add_policy").value = _aa_pol_add;</script>
						</td>
					</tr>
				</table>
			  </div>
			  <div class=box id="show_table">
			  <h2><script>show_words(aa_Policy_Table);</script></h2>
				<table width="525" id="table1" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
					<tr> 
					  <td width="20"><strong><script>show_words(_enable);</script></strong></td> 
					  <td width="80"><strong><script>show_words(aa_ACR_c2);</script></strong></td> 
					  <td width="130"><strong><script>show_words(aa_Machine);</script></strong></td> 
					  <td width="120"><strong><script>show_words(aa_ACR_c5);</script></strong></td> 
					  <td width="50"><strong><script>show_words(aa_ACR_c6);</script></strong></td> 
					  <td width="80"><strong><script>show_words(aa_ACR_c7);</script></strong></td> 
					  <td>&nbsp;</td>  
					  <td>&nbsp;</td>   
					</tr>
					<script>
						set_policy();
						var is_enable = "", filter, logged;
						for(i = 0; i < DataArray.length; i++){
							if(parseInt(DataArray[i].Enable)){
								is_enable = "checked";
							}else{
								is_enable = "";
							}
							// list
							var Machine = (DataArray[i].Machine).split(",");
							var Machine_list;
							for(var j = 0; j < Machine.length; j++){
								var Machine_name = Machine[j];
								if(Machine_name == "other")
									Machine_name = _aa_other_machines;
								if(j == 0){
									Machine_list = Machine_name;
								}else{
									Machine_list = Machine_list + ",<br>" + Machine_name;
								}
							}
							//filtering method
							if(DataArray[i].Filter == "log_only"){
								filter =_aa_allow_all;
							}else if(DataArray[i].Filter == "block_all"){
								filter = _aa_block_all;
							}else{
								filter = _aa_block_some;
							}
							//web access logging
							if(DataArray[i].Logged == "yes"){
								logged = _yes;
							}else{
								logged = _no;
							}
							var dName = DataArray[i].Name;
							trimName = trim_string(dName);
							var str=trimName;
							
							str=ReplaceAll(str, "<", "\&lt;");
							str=ReplaceAll(str, " ", "\&nbsp;");
							
							//document.write(str.replace(rep, "\&lt;"));
							document.write("<tr><td><input type=checkbox id=enable" + i + " name=enable" + i + " onClick='set_policy_enable(" + i + ")' " + is_enable + "></td><td>"+str+"</td><td>" + Machine_list +"</td><td>"+ filter +"</td><td>"+ logged +"</td><td>"+ DataArray[i].Schedule +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></td></tr>");
						}
					</script>
				</table>
			  </div>
		</div>
		</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                          <p><script>show_words(hhac_en);</script></p>
						  <p><script>show_words(hhac_add);</script></p>
						  <p><script>show_words(hhac_edit);</script></p>
						  <p><script>show_words(hhac_delete);</script></p>
						  <p><a href="support_adv.asp#Access_Control" onclick="return jump_if()"><script>show_words(_more);</script>&hellip;</a></p>
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
	reboot_needed(left["Advance"].link[5]);
	onPageLoad();
</script>
</html>
