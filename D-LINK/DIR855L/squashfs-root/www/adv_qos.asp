<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="JavaScript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
    var submit_button_flag = 0;
    var rule_max_num = 10;

    function onPageLoad()
    {
        set_checked(get_by_id("traffic_shaping").value, get_by_id("qos_traffic_shaping"));
        set_checked(get_by_id("auto_uplink").value, get_by_id("qos_auto_uplink"));
        set_checked(get_by_id("qos_enable").value, get_by_id("qos_engine_enabled"));
        set_checked(get_by_id("auto_classification").value, get_by_id("qos_auto_classification"));
        set_checked(get_by_id("qos_dyn_fragmentation").value, get_by_id("qos_dyn_frag"));
				if (get_by_id("qos_uplink").value == "")
					get_by_id("qos_uplink").value = 128;
					
				//set_selectIndex(get_by_id("qos_uplink").value, get_by_id("qos_max_trans_rate_select"));

        for (var i = 0; i < rule_max_num; i++) {
            var temp_qos;
            if (i > 9)
                temp_qos = get_by_id("qos_rule_" + i);
            else
                temp_qos = get_by_id("qos_rule_0" + i);

            if (temp_qos.value == "") {
                temp_qos.value = "0//1/0/0/6/0.0.0.0/255.255.255.255/0/65535/0.0.0.0/255.255.255.255/0/65535";
            }
        }

        qos_traffic_shaping_click(get_by_id("qos_traffic_shaping").checked);
        set_qos_rule();

        if ("<!--# echo get_current_user -->" == "user") {
            DisableEnableForm(document.form1, true);
        }

        set_form_default_values("form1");
    }

    function set_qos_rule()
    {
        for (var i = 0; i < rule_max_num; i++) {
            var temp_qos;
            if (i > 9)
                temp_qos = (get_by_id("qos_rule_" + i).value).split("/");
            else
                temp_qos = (get_by_id("qos_rule_0" + i).value).split("/");

            if (temp_qos.length > 1) {
                if (temp_qos[0] == "1") {
                    get_by_id("qos_rule_enabled" + i).checked = true;
                }
                get_by_id("name" + i).value = temp_qos[1];
                get_by_id("priority" + i).value = temp_qos[2];
                set_protocol(i, temp_qos[5], get_by_id("protocol_select" + i));
                get_by_id("local_start_ip" + i).value = temp_qos[6];
                get_by_id("local_end_ip" + i).value = temp_qos[7];
                get_by_id("local_start_port" + i).value = temp_qos[8];
                get_by_id("local_end_port" + i).value = temp_qos[9];
                get_by_id("remote_start_ip" + i).value = temp_qos[10];
                get_by_id("remote_end_ip" + i).value = temp_qos[11];
                get_by_id("remote_start_port" + i).value = temp_qos[12];
                get_by_id("remote_end_port" + i).value = temp_qos[13];

                if (get_by_id("qos_engine_enabled").checked) {
                    detect_protocol_change_port(get_by_id("protocol_select"+i).selectedIndex,i);
                }
            }
        }
    }

    function set_protocol(i, which_value, obj)
    {
        set_selectIndex(which_value, obj);
        get_by_id("protocol" + i).disabled = true;
        get_by_id("protocol"+i).value = which_value;

        if (which_value != obj.options[obj.selectedIndex].value) {
            get_by_id("protocol" + i).disabled = false;
            get_by_id("protocol_select" + i).selectedIndex = 5;
        }
    }

    function qos_max_trans_rate_selector()
    {
        get_by_id("qos_uplink").value = get_by_id("qos_max_trans_rate_select").value;
        // Always go back to "Select"
        get_by_id("qos_max_trans_rate_select").value = 0;
    }

    function qos_traffic_shaping_click(obj_chk)
    {
        var is_disabled = !obj_chk;
        get_by_id("qos_auto_uplink").disabled = is_disabled;
        get_by_id("qos_uplink").disabled = is_disabled;
        get_by_id("qos_max_trans_rate_select").disabled = is_disabled;
        if (is_disabled == false) {
            qos_auto_uplink_click(get_by_id("qos_auto_uplink").checked);
        }
        get_by_id("qos_engine_enabled").disabled = is_disabled;
        qos_enable_click(get_by_id("qos_engine_enabled").checked);
    }

    function qos_auto_uplink_click(obj_chk)
    {
        var is_disabled = obj_chk;
        get_by_id("qos_uplink").disabled = is_disabled;
        get_by_id("qos_max_trans_rate_select").disabled = is_disabled;
    }

    function qos_enable_click(obj_chk)
    {
        var is_disabled = !(obj_chk && get_by_id("qos_traffic_shaping").checked);

        get_by_id("qos_auto_classification").disabled = is_disabled;
        get_by_id("qos_dyn_frag").disabled = is_disabled;

        for (var i=0;i<rule_max_num;i++) {
            get_by_id("qos_rule_enabled"+i).disabled = is_disabled;
            get_by_id("name"+i).disabled = is_disabled;
            get_by_id("priority"+i).disabled = is_disabled;
            get_by_id("protocol"+i).disabled = is_disabled;
            get_by_id("protocol_select"+i).disabled = is_disabled;
            get_by_id("local_start_ip"+i).disabled = is_disabled;
            get_by_id("local_end_ip"+i).disabled = is_disabled;
            get_by_id("local_start_port"+i).disabled = is_disabled;
            get_by_id("local_end_port"+i).disabled = is_disabled;
            get_by_id("remote_start_ip"+i).disabled = is_disabled;
            get_by_id("remote_end_ip"+i).disabled = is_disabled;
            get_by_id("remote_start_port"+i).disabled = is_disabled;
            get_by_id("remote_end_port"+i).disabled = is_disabled;
        }
    }

    function protocol_change(i)
    {
        var obj_name = get_by_id("protocol_select"+i);
        if (obj_name.selectedIndex < 5) { //Any, TCP, UDP, Both, ICMP, Other
            get_by_id("protocol"+i).disabled = true;
            get_by_id("protocol"+i).value=obj_name.options[obj_name.selectedIndex].value;
        }
        else if (get_by_id("protocol_select"+i).selectedIndex == 5) { // Other
            get_by_id("protocol"+i).disabled = false;
            get_by_id("protocol"+i).value="";
        }
    }

    function detect_protocol_change_port(proto,i)
    {
        //var proto = get_by_id("protocol_select"+i).selectedIndex;
        if ((proto == 0)||(proto == 4)||(proto == 5)) {
            get_by_id("local_start_port"+i).disabled = true;
            get_by_id("local_end_port"+i).disabled = true;
            get_by_id("remote_start_port"+i).disabled = true;
            get_by_id("remote_end_port"+i).disabled = true;
        }
        else {
            get_by_id("local_start_port"+i).disabled = false;
            get_by_id("local_end_port"+i).disabled = false;
            get_by_id("remote_start_port"+i).disabled = false;
            get_by_id("remote_end_port"+i).disabled = false;
        }
    }

    function send_request()
    {
    	var is_modify=is_form_modified("form1");
        if (!is_modify && !confirm(_ask_nochange)) {
            return false;
        }

        get_by_id("traffic_shaping").value = get_checked_value(get_by_id("qos_traffic_shaping"));
        get_by_id("auto_uplink").value = get_checked_value(get_by_id("qos_auto_uplink"));
        get_by_id("qos_enable").value = get_checked_value(get_by_id("qos_engine_enabled"));
        get_by_id("auto_classification").value = get_checked_value(get_by_id("qos_auto_classification"));
        get_by_id("qos_dyn_fragmentation").value = get_checked_value(get_by_id("qos_dyn_frag"));

        // check qos_uplink
        if (get_by_id("qos_traffic_shaping").checked && !get_by_id("qos_auto_uplink").checked) {
            var qos_uplink = get_by_id("qos_uplink").value;
            if (qos_uplink > 10240 || 20 > qos_uplink || isNaN(qos_uplink) || get_by_id("qos_uplink").value == "") {
								var m_msg=ReplaceAll(at_alert_1, "100", "10");
                alert(m_msg);
                return false;
            }
        }

        //check rule
        var count = 0;
        for (var i = 0; i < rule_max_num; i++) {
            var local_start_ip = get_by_id("local_start_ip" + i).value;
            var local_end_ip = get_by_id("local_end_ip" + i).value;
            var remote_start_ip = get_by_id("remote_start_ip" + i).value;
            var remote_end_ip = get_by_id("remote_end_ip" + i).value;
            var local_start_port = parseInt(get_by_id("local_start_port" + i).value);
            var local_end_port = parseInt(get_by_id("local_end_port" + i).value);
            var remote_start_port = parseInt(get_by_id("remote_start_port" + i).value);
            var remote_end_port = parseInt(get_by_id("remote_end_port" + i).value);
            var ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
            var remote_ip_addr_msg = replace_msg(all_ip_addr_msg,_rip);
            var temp_local_start_ip_obj = new addr_obj(local_start_ip.split("."), ip_addr_msg, false, false);
            var temp_local_end_ip_obj = new addr_obj(local_end_ip.split("."), ip_addr_msg, false, false);
            var temp_remote_start_ip_obj = new addr_obj(remote_start_ip.split("."), remote_ip_addr_msg, false, false);
            var temp_remote_end_ip_obj = new addr_obj(remote_end_ip.split("."), remote_ip_addr_msg, false, false);
            var temp_qos;
            var check_name = "";

            if (i > 9)
                get_by_id("qos_rule_" + i).value = "";
            else
                get_by_id("qos_rule_0" + i).value = "";

            //check protocol
            if (get_by_id("protocol_select" + i).selectedIndex == 5) {
                temp_obj = get_by_id("protocol" + i);
                var protocol_msg = replace_msg(check_num_msg, "protocol", 0, 255);
                obj = new varible_obj(temp_obj.value, protocol_msg, 0, 255, false);
                if (!check_varible(obj)) {
                    return false;
                }
            }

            if (get_by_id("name" + i).value != "") {
                // check name
                check_name = get_by_id("name" + i).value;
                if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
                    alert(TEXT003a+" "+ i +" "+TEXT007b);
                    get_by_id("name"+i).focus();
                    get_by_id("name"+i).select();
                    return false;
                }

                //check Priority
                temp_obj =  get_by_id("priority" + i);
                var priority_msg = replace_msg(check_num_msg, _priority, 1, 255);
                pro_obj = new varible_obj(temp_obj.value, priority_msg, 1, 255, false);
                //check Priority is decimal or not? GraceYang-20090407
                var priority_value = get_by_id("priority" + i).value;
                var str = new String(parseFloat(priority_value));

                if (!check_varible(pro_obj)) {
                    return false;
                }

                //check ip
                if (local_start_ip != "0.0.0.0" && !check_address(temp_local_start_ip_obj)) {
                    return false;
                }
                if (local_end_ip != "255.255.255.255" && !check_address(temp_local_end_ip_obj)) {
                    return false;
                }
                if (remote_start_ip != "0.0.0.0" && !check_address(temp_remote_start_ip_obj)) {
                    return false;
                }
                if (remote_end_ip != "255.255.255.255" && !check_address(temp_remote_end_ip_obj)) {
                    return false;
                }

                //check port
                if ((get_by_id("protocol_select"+i).selectedIndex ==1) || (get_by_id("protocol_select"+i).selectedIndex ==2) || (get_by_id("protocol_select"+i).selectedIndex ==3)){
                    if (!is_number(local_start_port) || local_start_port < 0 || local_start_port > 65535) {
                        alert(YM59);
                        get_by_id("local_start_port"+i).focus();
                        get_by_id("local_start_port"+i).select();
                        return false;
                    }
                    else if (!is_number(local_end_port) || local_end_port < 0 || local_end_port > 65535) {
                        alert(YM60);
                        get_by_id("local_end_port"+i).focus();
                        get_by_id("local_end_port"+i).select();
                        return false;
                    }
                    else if (local_start_port > local_end_port){
                        alert(get_by_id("name" + i).value + ": " + GW_QOS_RULES_LOCAL_PORT1 + ", " + local_start_port + ", " + GW_QOS_RULES_LOCAL_PORT2 + ", " + local_end_port);
                        get_by_id("local_start_port"+i).focus();
                        get_by_id("local_start_port"+i).select();
                        return false;
                    }

                    if (!is_number(remote_start_port) || remote_start_port < 0 || remote_start_port > 65535) {
                        alert(YM61);
                        get_by_id("remote_start_port"+i).focus();
                        get_by_id("remote_start_port"+i).select();
                        return false;
                    }
                    else if (!is_number(remote_end_port) || remote_end_port < 0 || remote_end_port > 65535) {
                        alert(YM62);
                        get_by_id("remote_end_port"+i).focus();
                        get_by_id("remote_end_port"+i).select();
                        return false;
                    }
                    else if (remote_start_port > remote_end_port) {
                        alert(get_by_id("name" + i).value + ": " + GW_QOS_RULES_REMOTE_PORT1 + ", " + remote_start_port + ", " + GW_QOS_RULES_REMOTE_PORT2 + ", " + remote_end_port);
                        get_by_id("remote_start_port"+i).focus();
                        get_by_id("remote_start_port"+i).select();
                        return false;
                    }
                }
            }
            else {
                if (get_by_id("qos_rule_enabled" + i).checked == true) {
                    alert(YM49+" "+i+".");
                    return false;
                }
            }

            if (count > 9)
                temp_qos = get_by_id("qos_rule_" + count);
            else
                temp_qos = get_by_id("qos_rule_0" + count);

            //enable/name/priority/uplink/downlink/protocol/local_start_ip/local_end_ip/local_start_port/local_end_port/remote_start_ip/remote_end_ip/remote_start_port/remote_end_port
            temp_qos.value = get_checked_value(get_by_id("qos_rule_enabled" + i)) + "/" + get_by_id("name" + i).value + "/" + get_by_id("priority" + i).value   + "/"
                            + "0/0/"
                            + get_by_id("protocol" + i).value + "/"
                            + get_by_id("local_start_ip" + i).value + "/" + get_by_id("local_end_ip" + i).value + "/" + get_by_id("local_start_port" + i).value + "/"
                            + get_by_id("local_end_port" + i).value+ "/" + get_by_id("remote_start_ip" + i).value + "/"
                            + get_by_id("remote_end_ip" + i).value + "/" + get_by_id("remote_start_port" + i).value + "/" + get_by_id("remote_end_port" + i).value;
            count++;
        }

        //check same as rule
        for (var i = 0; i < rule_max_num; i++) {
            var local_start_ip = get_by_id("local_start_ip" + i).value;
            var local_end_ip = get_by_id("local_end_ip" + i).value;
            var remote_start_ip = get_by_id("remote_start_ip" + i).value;
            var remote_end_ip = get_by_id("remote_end_ip" + i).value;
            var local_start_port = parseInt(get_by_id("local_start_port" + i).value);
            var local_end_port = parseInt(get_by_id("local_end_port" + i).value);
            var remote_start_port = parseInt(get_by_id("remote_start_port" + i).value);
            var remote_end_port = parseInt(get_by_id("remote_end_port" + i).value);
            var rule_protocol = get_by_id("protocol_select"+i).selectedIndex;

            for (var j = 0; j < rule_max_num; j++) {
                if (j != i) {
                    var local_start_ip_chk = get_by_id("local_start_ip" + j).value;
                    var local_end_ip_chk = get_by_id("local_end_ip" + j).value;
                    var remote_start_ip_chk = get_by_id("remote_start_ip" + j).value;
                    var remote_end_ip_chk = get_by_id("remote_end_ip" + j).value;
                    var local_start_port_chk = parseInt(get_by_id("local_start_port" + j).value);
                    var local_end_port_chk = parseInt(get_by_id("local_end_port" + j).value);
                    var remote_start_port_chk = parseInt(get_by_id("remote_start_port" + j).value);
                    var remote_end_port_chk = parseInt(get_by_id("remote_end_port" + j).value);
                    var rule_protocol_chk = get_by_id("protocol_select"+j).selectedIndex;

                    //check enable
                    if (get_by_id("qos_rule_enabled" + i).checked != true) {
                        continue;
                    }

                    //check enable
                    if (get_by_id("qos_rule_enabled" + j).checked != true) {
                        continue;
                    }

                    //check protocol
                    if (rule_protocol_chk != rule_protocol) {
                        continue;
                    }

                    //check ip
                    if (local_start_ip_chk != local_start_ip) {
                        continue;
                    }
                    if (local_end_ip_chk != local_end_ip) {
                        continue;
                    }
                    if (remote_start_ip_chk != remote_start_ip) {
                        continue;
                    }
                    if (remote_end_ip_chk != remote_end_ip) {
                        continue;
                    }

                    //check port
                    if ((rule_protocol ==1) || (rule_protocol ==2) || (rule_protocol ==3)) {
                        if (local_start_port_chk != local_start_port) {
                            continue;
                        }
                        else if (local_end_port_chk != local_end_port) {
                            continue;
                        }

                        if (remote_start_port_chk != remote_start_port) {
                            continue;
                        }
                        else if (remote_end_port_chk != remote_end_port) {
                            continue;
                        }

                        // same as rule
                        alert(TEXT008a+" "+i+" "+TEXT008b+" "+j+".");//TEXT008
                        return false;
                    }
                }
            }
        }
	if(is_modify && "<!--# echo hnat_enable -->" != ""){
		if(!check_hnat("traffic_shaping"))
			return false;
	}			
        if (submit_button_flag == 0) {
            submit_button_flag = 1;
            return true;
        }

        return false;
    }
</script>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
        <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
                <td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr><td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td></tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td><img src="/short_modnum.gif" width="125" height="25"></td>
		<script>show_top("adv");</script>
        </tr>
    </table>
    <table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
            <tr>
              <td id=sidenav_container>
                <div id=sidenav>
                  <UL>
										<script>show_left("Advance", 3);</script>
                  </UL>
                </div>
              </td>
            </tr>
        </table></td>

            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_qos.asp">
	    			<input type="hidden" id="action" name="action" value="adv_qos">
            <input type="hidden" id="reboot_type" name="reboot_type" value="qos">

						<input type="hidden" id="measured_uplink_speed" name="measured_uplink_speed" value="<!--# exec cgi /bin/tc_measure measured_uplink_speed -->">
						
            <input type="hidden" id="qos_rule_00" name="qos_rule_00" value="<!--# echo qos_rule_00 -->">
            <input type="hidden" id="qos_rule_01" name="qos_rule_01" value="<!--# echo qos_rule_01 -->">
            <input type="hidden" id="qos_rule_02" name="qos_rule_02" value="<!--# echo qos_rule_02 -->">
            <input type="hidden" id="qos_rule_03" name="qos_rule_03" value="<!--# echo qos_rule_03 -->">
            <input type="hidden" id="qos_rule_04" name="qos_rule_04" value="<!--# echo qos_rule_04 -->">
            <input type="hidden" id="qos_rule_05" name="qos_rule_05" value="<!--# echo qos_rule_05 -->">
            <input type="hidden" id="qos_rule_06" name="qos_rule_06" value="<!--# echo qos_rule_06 -->">
            <input type="hidden" id="qos_rule_07" name="qos_rule_07" value="<!--# echo qos_rule_07 -->">
            <input type="hidden" id="qos_rule_08" name="qos_rule_08" value="<!--# echo qos_rule_08 -->">
            <input type="hidden" id="qos_rule_09" name="qos_rule_09" value="<!--# echo qos_rule_09 -->">

            <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id=box_header>
                    <h1><script>show_words(YM48)</script></h1>
                      <script>show_words(at_intro)</script><script>show_words(at_intro_2)</script><br><br>
                      <input name="button" id="button" type="submit" class=button_submit value="" onClick=" return send_request()">
                      <input name="button1" id="button1" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_qos.asp');">
					  <script>check_reboot();</script>
                      <script>get_by_id("button").value = _savesettings;</script>
                      <script>get_by_id("button1").value = _dontsavesettings;</script>
                  </div>
                  <br>
                  <div class=box>
                    <h2><script>show_words(at_title_Traff)</script></h2>
                    <table width=525>

                    <tr>
                        <td width="185" align=right class="duple"><script>show_words(at_ETS)</script> :</td>
                        <td width="333">&nbsp;
	                        <input type="checkbox" id="qos_traffic_shaping" name="qos_traffic_shaping" value="1" onClick="qos_traffic_shaping_click(this.checked);">
	                        <input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<!--# echo traffic_shaping -->">
	                        <input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
													<input type="hidden" id="spi_enable" name="spi_enable" value="<!--# echo spi_enable -->">			
                        </td>
                    </tr>
										<tr>
											<td align=right class="duple"><script>show_words(at_AUS)</script> :</td>
											<td>&nbsp;
												<input type="checkbox" id="qos_auto_uplink" name="qos_auto_uplink" value="1" onClick="qos_auto_uplink_click(this.checked);">
												<input type="hidden" id="auto_uplink" name="auto_uplink" value="<!--# echo auto_uplink -->">
											</td>
										</tr>
										<tr>
											<td align=right class="duple"><script>show_words(at_MUS)</script> :</td>
											<td>&nbsp;
												<span id="span_measured_uplink_speed"></span>
											</td>
										</tr>
										<tr>
											<td align=right class="duple"><script>show_words(at_UpSp)</script> :</td>
											<td>&nbsp;
												<input type="text" id="qos_uplink" name="qos_uplink" maxlength="6" size="6"  value="<!--# echo qos_uplink -->">&nbsp;
												<script>show_words(at_kbps)</script>
												<span>&nbsp;&lt;&lt;&nbsp;</span>
												<select id="qos_max_trans_rate_select" name="qos_max_trans_rate_select" onchange="qos_max_trans_rate_selector();">
													<option value="0"><script>show_words(at_STR)</script></option>
													<option value="128">128 <script>show_words(at_kbps)</script></option>
													<option value="256">256 <script>show_words(at_kbps)</script></option>
													<option value="384">384 <script>show_words(at_kbps)</script></option>
													<option value="512">512 <script>show_words(at_kbps)</script></option>
													<option value="1024">1 <script>show_words(at_mbps)</script></option>
													<option value="2048">2 <script>show_words(at_mbps)</script></option>
													<option value="3072">3 <script>show_words(at_mbps)</script></option>
													<option value="5120">5 <script>show_words(at_mbps)</script></option>
													<option value="10240">10 <script>show_words(at_mbps)</script></option>
												</select>
											</td>
										</tr>
                    </table>
                  </div>
                  <div class=box id="qos_engine">
                    <h2><script>show_words(at_title_SESet)</script></h2>
                    <table width=525>
                                <tr>
                                                <td width="185" align=right class="duple"><script>show_words(at_ESE)</script> :</td>
                    <td width="333">&nbsp;
                        <input type="checkbox" id="qos_engine_enabled" name="qos_engine_enabled" value="1" onClick="qos_enable_click(this.checked)">
                        <input type="hidden" id="qos_enable" name="qos_enable" value="<!--# echo qos_enable -->">
                    </td>
                    </tr>
                                            <tr>
                                              <td align=right class="duple"><script>show_words(at_AC)</script> :</td>
                        <td>&nbsp;
                                                <input type="checkbox" id="qos_auto_classification" name="qos_auto_classification" value="1">
                                                    <input type="hidden" id="auto_classification" name="auto_classification" value="<!--# echo auto_classification -->">
                                            </td>
                                            </tr>
                                            <tr>
                                              <td align=right class="duple"><script>show_words(at_DF)</script> :</td>
                        <td>&nbsp;
                                                <input type="checkbox" id="qos_dyn_frag" name="qos_dyn_frag" value="1">
                                                    <input type="hidden" id="qos_dyn_fragmentation" name="qos_dyn_fragmentation" value="<!--# echo qos_dyn_fragmentation -->">
                                            </td>
                                            </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(at_title_SERules)</script></h2>
                    <table bordercolor=#ffffff cellspacing=1 cellpadding=2 width=525 bgcolor=#dfdfdf border=1>
                        <script>
                                for(var i=0; i <rule_max_num ; i++){
                                        document.write("<tr>");
                                        document.write("<td rowspan=3><input type=checkbox id=\"qos_rule_enabled"+ i + "\" name=\"qos_rule_enabled"+ i + "\" value=\"1\"></td>");
                                        document.write('<td>'+_name+'<br><input id=name' + i + ' name=name' + i +' type=text size=16 maxlength=31></td>');
                                        document.write('<td> '+_priority+'<br><input id=priority' + i + ' name=priority' + i +' type=text size=16 maxlength=31>(1..255)</td>');
                                        document.write('<td>'+_protocol+'<br>');
                                        document.write("<input id=\"protocol"+ i + "\" name=\"protocol"+ i + "\" maxlength=3 size=2 type=text>");
                                        document.write("  <<  ");
                                        document.write("<select id=\"protocol_select"+ i + "\" name=\"protocol_select"+ i + "\" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex,'" + i + "');\">");
                                        document.write('<option value=256>'+at_Any+'</option>');
                                        document.write('<option value=6>'+_TCP+'</option>');
                                        document.write('<option value=17>'+_UDP+'</option>');
                                        document.write('<option value=257>'+_both+'</option>');
                                        document.write('<option value=1>'+_ICMP+'</option>');
                                        document.write('<option value=-1>'+_other+'</option>');
                                        document.write("</select></td>");
                                        document.write("</tr>");
                                        document.write("<tr>");
                                        document.write('<td colspan=2 width=60%>'+at_LoIPR+'<br>');
                                        document.write('<input id=local_start_ip'+ i + ' name=local_start_ip'+ i + ' type=text size=14 maxlength=15>'+_to+'<input id=local_end_ip'+ i + ' name=local_end_ip'+ i + ' type=text size=14 maxlength=15>');
                                        document.write("</td>");
                                        document.write('<td>'+at_LoPortR+'<br>');
                                        document.write('<input id=local_start_port'+ i + ' name=local_start_port'+ i + ' type=text size=4 maxlength=5>'+_to+'<input id=local_end_port'+ i + ' name=local_end_port'+ i + ' type=text size=4 maxlength=5>');
                                        document.write("</td>");
                                        document.write("</tr>");
                                        document.write("<tr>");
                                        document.write('<td colspan=2 width=60%>'+at_ReIPR+'<br>');
                                        document.write('<input id=remote_start_ip'+ i + ' name=remote_start_ip'+ i + ' type=text size=14 maxlength=15>'+_to+'<input id=remote_end_ip'+ i + ' name=remote_end_ip'+ i + ' type=text size=14 maxlength=15>');
                                        document.write("</td>");
                                        document.write('<td>'+at_RePortR+'<br>');
                                        document.write('<input id=remote_start_port'+ i + ' name=remote_start_port'+ i + ' type=text size=4 maxlength=5 >'+_to+'<input id=remote_end_port'+ i + ' name=remote_end_port'+ i + ' type=text size=4 maxlength=5>');
                                        document.write("</td>");
                                        document.write("</tr>");
                                }
                        </script>
                    </table>
                  </div>
                </div>
             </td></form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff  cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tr>

          <td id=help_text><strong><b><strong>
            <script>show_words(_hints)</script>
            </strong></b>&hellip;</strong>
            <p><script>show_words(hhase_intro)</script>
                       <p class="more"><a href="support_adv.asp#Traffic_Shaping" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                       </TD>
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
	if(get_by_id("measured_uplink_speed").value == "Not Estimated"){
		get_by_id("span_measured_uplink_speed").innerHTML = at_NEst;	
	}else{
		get_by_id("span_measured_uplink_speed").innerHTML = get_by_id("measured_uplink_speed").value;	
	}
	
	reboot_needed(left["Advance"].link[3]);
</script>
</html>
