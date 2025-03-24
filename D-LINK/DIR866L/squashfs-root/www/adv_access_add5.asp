<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
var rule_max_num = 8;
	function onPageLoad(){
		var idx = 1;
		for(var i = 4; i < 12; i++){
			if(i < 10){
				var temp_firewall = (get_by_id("asp_temp_0" + i).value).split("/");
			}else{
				var temp_firewall = (get_by_id("asp_temp_" + i).value).split("/");
			}
			if (temp_firewall.length > 1){
				set_checked(temp_firewall[0], get_by_id("enable" + idx));
				get_by_id("name" + idx).value = temp_firewall[1];
				get_by_id("start_ip" + idx).value = temp_firewall[7];
				get_by_id("end_ip" + idx).value = temp_firewall[8];
				get_by_id("protocol" + idx).value = temp_firewall[3];
				get_by_id("start_port" + idx).value = temp_firewall[9];
				get_by_id("end_port" + idx).value = temp_firewall[10];
				click_protocol(idx);
				idx++;
			}
		}
	}
	
	function show_save_button(){
		get_by_id("save").disabled = !((get_by_id("asp_temp_14").value != "-1") || (get_by_id("asp_temp_03").value == "firewall_rule"));
		get_by_id("next").disabled = !(get_by_id("asp_temp_03").value == "url_firewall");
	}
	
	function click_protocol(idx){
		var protocol = get_by_id("protocol" + idx).selectedIndex;
		if (protocol == 0 || protocol == 1) {
			get_by_id("start_port" + idx).value = 0;
			get_by_id("end_port" + idx).value = 65535;
		}
		get_by_id("start_port" + idx).disabled = (protocol < 2);
		get_by_id("end_port" + idx).disabled = (protocol < 2);
	}

	function check_info(){
		var temp_ip_obj = new addr_obj(get_by_id("lan_ipaddr").value.split("."), all_ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(get_by_id("lan_netmask").value.split("."), subnet_mask_msg, false, false);
		for (var i = 1; i < rule_max_num-1; i++) {
			var i_name = get_by_id("name"+i).value;
			if (i_name === "") 
				break;
			for (j = i+1; j < rule_max_num; j++) {
				var j_name = get_by_id("name"+j).value;
				if (i_name == j_name) {
					alert(at_alert11);
					return false;
				}
			}
		}

		for(var i = 1; i <= rule_max_num; i++){
			var enable = get_by_id("enable" + i);
			var name = get_by_id("name" + i).value;
			var start_ip = get_by_id("start_ip" + i).value;
			var end_ip = get_by_id("end_ip" + i).value;
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg, aa_ACC_01);
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg, aa_ACC_02);
			var temp_start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, true, false);
			var temp_end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, true, false);
			var re = /[^A-Za-z0-9_. -]/;
			
			if(enable.checked && name == ""){
				alert(TEXT034);
				return false;
			}

			if(re.test(name)){
				alert(TEXT034);
				return false;
			}
			
			if(enable.checked || name != ""){
				if(Find_word(name,"'") || Find_word(name,'"') || Find_word(name,"/")){
					alert(KR1a);
					return false
				}
				
				if(start_ip != "255.255.255.255"){
					if(!check_address(temp_start_obj)){
						return false;
					}else if (check_domain(temp_start_obj, temp_mask_obj, temp_ip_obj)){
						alert(aa_ACC_03);
						return false;
					}
				}

				if(end_ip != "255.255.255.255"){
					if(!check_address(temp_end_obj)){
						return false;
					}else if (check_domain(temp_end_obj, temp_mask_obj, temp_ip_obj)){
						alert(aa_ACC_04);
						return false;
					}
				}
				
				if (!check_ip_order(temp_start_obj, temp_end_obj)){
					alert(TEXT039);
					return false;
				}
				
				if(get_by_id("protocol" + i).selectedIndex > 1){
					var start_port = get_by_id("start_port" + i).value;
					var end_port = get_by_id("end_port" + i).value;
					if(!check_pf_port(start_port)){
						alert(YM21);
						return false;
					}else if(end_port != ""){
						if(!check_pf_port(end_port)){
							alert(YM22);
							return false;
						}else if(parseInt(end_port) < parseInt(start_port)){
							alert(YM23);
							return false;
						}
					}else{
						get_by_id("end_port" + i).value = get_by_id("start_port" + i).value;
					}
				}
			}
		}
		return true;
	}
	
	function save_info(){
		var idx, enable, firewall_rull = "";
		for(var i = 1; i <= rule_max_num; i++){
			idx = i + 3;
			if(parseInt(idx) < 10){
				get_by_id("asp_temp_0" + idx).value = "";
			}else{
				get_by_id("asp_temp_" + idx).value = "";
			}
			
			if(get_by_id("enable" + i).checked || get_by_id("name" + i).value != ""){
				if(get_by_id("enable" + i).checked){
					enable = "1";
				}else{
					enable = "0";
				}
				
				firewall_rull = enable + "/" + get_by_id("name" + i).value + "/0/" + get_by_id("protocol" + i).value + "/0/0/0/" 
							  + get_by_id("start_ip" + i).value + "/" + get_by_id("end_ip" + i).value + "/" 
							  + get_by_id("start_port" + i).value + "/" + get_by_id("end_port" + i).value + "/0/deny" 
				
				if(parseInt(idx) < 10){
					get_by_id("asp_temp_0" + idx).value = firewall_rull;
				}else{
					get_by_id("asp_temp_" + idx).value = firewall_rull;
				}
			}
		}
	}

	function send_previous(){
		save_info();
		document.form1.html_response_page.value = "adv_access_add4.asp";
		document.form1.html_response_return_page.value = "adv_access_add4.asp";
		return true;
	}
		
	function send_next(){
		if(!check_info())
			return false;

		save_info();
		get_by_id("asp_temp_15").value = "adv_access_add5.asp";
		return true;
	}

	function send_request(){
		if(!check_info())
			return false;
		save_info();
		document.form1.html_response_page.value = "adv_access_save.asp";
		document.form1.html_response_return_page.value = "adv_access_save.asp";
		return true;
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 5);</script>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<input type="hidden" id="firewall_rule_0" name="firewall_rule_0" value="<!--# echo firewall_rule_00 -->">
			<input type="hidden" id="firewall_rule_1" name="firewall_rule_1" value="<!--# echo firewall_rule_01 -->">
			<input type="hidden" id="firewall_rule_2" name="firewall_rule_2" value="<!--# echo firewall_rule_02 -->">
			<input type="hidden" id="firewall_rule_3" name="firewall_rule_3" value="<!--# echo firewall_rule_03 -->">
			<input type="hidden" id="firewall_rule_4" name="firewall_rule_4" value="<!--# echo firewall_rule_04 -->">
			<input type="hidden" id="firewall_rule_5" name="firewall_rule_5" value="<!--# echo firewall_rule_05 -->">
			<input type="hidden" id="firewall_rule_6" name="firewall_rule_6" value="<!--# echo firewall_rule_06 -->">
			<input type="hidden" id="firewall_rule_7" name="firewall_rule_7" value="<!--# echo firewall_rule_07 -->">
			
			<input type="hidden" id="firewall_rule_8" name="firewall_rule_8" value="<!--# echo firewall_rule_08 -->">
			<input type="hidden" id="firewall_rule_9" name="firewall_rule_9" value="<!--# echo firewall_rule_09 -->">
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

			<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<!--# echo lan_ipaddr -->">
			<input type="hidden" id="lan_netmask" name="lan_netmask" value="<!--# echo lan_netmask -->">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add6.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add6.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">
			
			
						<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<!--# echo asp_temp_00 -->">	<!-- Policy Name -->
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<!--# echo asp_temp_02 -->">	<!-- Machine -->
			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<!--# echo asp_temp_03 -->">	<!-- filter method -->
			<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<!--# echo asp_temp_04 -->">	<!-- firewall rule 1 -->
			<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<!--# echo asp_temp_05 -->">	<!-- firewall rule 2 -->
			<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<!--# echo asp_temp_06 -->">	<!-- firewall rule 3 -->
			<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<!--# echo asp_temp_07 -->">	<!-- firewall rule 4 -->
			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<!--# echo asp_temp_08 -->">	<!-- firewall rule 5 -->
			<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<!--# echo asp_temp_09 -->">	<!-- firewall rule 6 -->
			<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">	<!-- firewall rule 7 -->
			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<!--# echo asp_temp_11 -->">	<!-- firewall rule 8 -->
			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<!--# echo asp_temp_12 -->">	<!-- logging -->
			<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<!--# echo asp_temp_13 -->">	<!-- Policy Name list -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<!--# echo asp_temp_14 -->">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<!--# echo asp_temp_15 -->">	<!-- prev_page -->
			<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<!--# echo asp_temp_16 -->">	<!-- max_row -->

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2><script>show_words(_aa_wiz_s7_title);</script></h2>
		 	 <P class="box_msg"><script>show_words(_aa_wiz_s7_msg);</script></P>
			 <p><script>show_words(_aa_wiz_s7_help);</script></p>
				<table width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
				  <tbody>
					  <tr>
						<td><script>show_words(_enable);</script></td>
						<td><script>show_words(_name);</script></td>
						<td><script>show_words(aa_FPR_c3);</script></td>
						<td><script>show_words(aa_FPR_c4);</script></td>
						<td><script>show_words(_protocol);</script></td>
						<td><script>show_words(aa_FPR_c6);</script></td>
						<td><script>show_words(aa_FPR_c7);</script></td>
					  </tr>
					  <script>
					  	for(var i = 1; i <= rule_max_num; i++){
							document.write("<tr>");
							document.write("<td align=\"center\"><input type=checkbox id=enable" + i + " name=enable" + i + " value=1></td>");
							document.write("<td><input type=text id=name" + i + " name=name" + i + " maxlength=15 size=12></td>");
							document.write("<td><input type=text id=start_ip" + i + " name=start_ip" + i + " maxlength=15 size=16 value='0.0.0.0'></td>");
							document.write("<td><input type=text id=end_ip" + i + " name=end_ip" + i + " maxlength=15 size=16 value='255.255.255.255'></td>");
							document.write("<td><select id=protocol" + i + " name=protocol" + i + " onChange='click_protocol(" + i + ")'>");
							document.write("<option value=Any>" + at_Any + "</option>");
							document.write("<option value=ICMP>ICMP</option>");
							document.write("<option value=TCP>TCP</option>");
							document.write("<option value=UDP>UDP</option>");
							document.write("</select></td>");
							document.write("<td><input type=text id=start_port" + i + " name=start_port" + i + " maxlength=5 size=4 value='0'></td>");
							document.write("<td><input type=text id=end_port" + i + " name=end_port" + i + " maxlength=5 size=4 value='65535'></td>");
							document.write("</tr>");
							click_protocol(i);
						}
					  </script>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						 <input name="prev" type="submit" id="prev" value="" onClick="return send_previous();">
                                                        <script>get_by_id("prev").value=_prev;</script>
						&nbsp; 
                                                <input name="next" type="submit" id="next" value="" onClick="return send_next();">
                                                        <script>get_by_id("next").value=_next;</script>
						&nbsp;
                                                <input name="save" type="submit" id="save" value="" onClick="return send_request();">
                                                        <script>get_by_id("save").value=_save;</script>
						&nbsp; 
                                                <input name="cancel" type="button" id="cancel" value="" onClick="exit_access()">
                                                        <script>get_by_id("cancel").value=_cancel;</script>
					</div>
				  </td>
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
	onPageLoad();
	show_save_button();
</script>
</html>
