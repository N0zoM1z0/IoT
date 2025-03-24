<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<script language="JavaScript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="/jquery-1.6.1.min.js"></script>
<script language="JavaScript">
    var txrate_11b = new Array('Best (automatic)',11, 5.5, 2, 1);
    var txrate_11g = new Array('Best (automatic)',54, 48, 36, 24, 18, 12, 9, 6);
    var txrate_11bg = new Array('Best (automatic)',54, 48, 36, 24, 18, 12, 9, 6, 11, 5.5, 2, 1);
    var txrate_11n = new Array('Best (automatic)','MCS 15 - 130 [270]', 'MCS 14 - 117 [243]', 'MCS 13 - 104 [216]', 'MCS 12 - 78 [162]', 'MCS 11 - 52 [108]', 'MCS 10 - 39 [81]', 'MCS 9 - 26 [54]', 'MCS 8 - 13 [27]', 'MCS 7 - 65 [135]', 'MCS 6 - 58.5 [121.5]', 'MCS 5 - 52 [108]', 'MCS 4 - 39 [81]', 'MCS 3 - 26 [54]', 'MCS 2 - 19.5 [40.5]', 'MCS 1 - 13 [27]', 'MCS 0 - 6.5 [13.5]');
    var txrate_11gn = new Array('Best (automatic)','MCS 15 - 130 [270]', 'MCS 14 - 117 [243]', 'MCS 13 - 104 [216]', 'MCS 12 - 78 [162]', 'MCS 11 - 52 [108]', 'MCS 10 - 39 [81]', 'MCS 9 - 26 [54]', 'MCS 8 - 13 [27]', 'MCS 7 - 65 [135]', 'MCS 6 - 58.5 [121.5]', 'MCS 5 - 52 [108]', 'MCS 4 - 39 [81]', 'MCS 3 - 26 [54]', 'MCS 2 - 19.5 [40.5]', 'MCS 1 - 13 [27]', 'MCS 0 - 6.5 [13.5]', 54, 48, 36, 24, 18, 12, 9, 6);
    var txrate_11bgn = new Array('Best (automatic)','MCS 15 - 130 [270]', 'MCS 14 - 117 [243]', 'MCS 13 - 104 [216]', 'MCS 12 - 78 [162]', 'MCS 11 - 52 [108]', 'MCS 10 - 39 [81]', 'MCS 9 - 26 [54]', 'MCS 8 - 13 [27]', 'MCS 7 - 65 [135]', 'MCS 6 - 58.5 [121.5]', 'MCS 5 - 52 [108]', 'MCS 4 - 39 [81]', 'MCS 3 - 26 [54]', 'MCS 2 - 19.5 [40.5]', 'MCS 1 - 13 [27]', 'MCS 0 - 6.5 [13.5]', 54, 48, 36, 24, 18, 12, 9, 6, 11, 5.5, 2, 1);
    function set_channel()
    {
        var channel_list = "<!--# exec cgi /bin/wlan channel list wlan0 -->";
        var current_channel = "<!--# echo wlan0_channel -->";
        var ch = channel_list.split(",");
        var ch_text = new Array("2.412","2.417","2.422","2.427","2.432","2.437","2.442","2.447","2.452","2.457","2.462","2.467","2.472");
        var obj = get_by_id("sel_wlan0_channel");
        var count = 0;

        for (var i = 0; i < ch.length; i++) {
            var ooption = document.createElement("option");
            ooption.text = ch_text[i] + " GHz - CH " + ch[i];
            ooption.value = ch[i];
            obj.options[count++] = ooption;

            if (ch[i] == current_channel) {
                ooption.selected = true;
            }
        }
    }

    function set_11b_txrate(obj)
    {
        for (var i = 0; i < txrate_11b.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11b[i];
            ooption.value = txrate_11b[i];
            obj.options[i] = ooption;
        }
    }

    function set_11g_txrate(obj)
    {
        for (var i = 0; i < txrate_11g.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11g[i];
            ooption.value = txrate_11g[i];
            obj.options[i] = ooption;
        }
    }

    function set_11n_txrate(obj)
    {
        for (var i = 0; i < txrate_11n.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11n[i];
            ooption.value = txrate_11n[i];
            obj.options[i] = ooption;
        }
    }

    function set_11bg_txrate(obj)
    {
        for (var i = 0; i < txrate_11bg.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11bg[i];
            ooption.value = txrate_11bg[i];
            obj.options[i] = ooption;
        }
    }

    function set_11gn_txrate(obj)
    {
        for (var i = 0; i < txrate_11gn.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11gn[i];
            ooption.value = txrate_11gn[i];
            obj.options[i] = ooption;
        }
    }

    function set_11bgn_txrate(obj)
    {
        for (var i = 0; i < txrate_11bgn.length; i++) {
            var ooption = document.createElement("option");

            obj.options[i] = null;
            ooption.text = txrate_11bgn[i];
            ooption.value = txrate_11bgn[i];
            obj.options[i] = ooption;
        }
    }

    function change_mode()
    {
        var mode = get_by_id("dot11_mode").selectedIndex;

        get_by_id("show_11b_txrate").style.display = "none";
        get_by_id("show_11g_txrate").style.display = "none";
        get_by_id("show_11n_txrate").style.display = "none";
        get_by_id("show_11bg_txrate").style.display = "none";
        get_by_id("show_11gn_txrate").style.display = "none";
        get_by_id("show_11bgn_txrate").style.display = "none";

        switch (mode) {
        case 0:
            get_by_id("show_11b_txrate").style.display = "";
            break;
        case 1:
            get_by_id("show_11g_txrate").style.display = "";
            break;
        case 2:
            get_by_id("show_11n_txrate").style.display = "";
            break;
        case 3:
            get_by_id("show_11bg_txrate").style.display = "";
            break;
        case 4:
            get_by_id("show_11gn_txrate").style.display = "";
            break;
        case 5:
            get_by_id("show_11bgn_txrate").style.display = "";
            break;
        }
    }

    function show_chan_width()
    {
        var mode = get_by_id("dot11_mode").selectedIndex;
        change_mode();

        switch (mode) {
        case 0:
            get_by_id("show_channel_width").style.display = "none";
            get_by_id("11n_protection").value ="20";
            break;
        case 1:
            get_by_id("show_channel_width").style.display = "none";
            get_by_id("11n_protection").value ="20";
            break;
        case 3:
            get_by_id("show_channel_width").style.display = "none";
            get_by_id("11n_protection").value ="20";
            break;
        default:
            get_by_id("show_channel_width").style.display = "";
            break;
        }
    }

    function disable_channel()
    {
        if (get_by_id("w_enable").checked)
            get_by_id("sel_wlan0_channel").disabled = get_by_id("auto_channel").checked;
    }


    function disable_wireless()
    {
        var is_display = "";
        get_by_id("auto_channel").disabled = !get_by_id("w_enable").checked;
        get_by_id("dot11_mode").disabled = !get_by_id("w_enable").checked;
        get_by_id("sel_wlan0_channel").disabled = !get_by_id("w_enable").checked;
        get_by_id("11n_protection").disabled = !get_by_id("w_enable").checked;
        get_by_id("11b_txrate").disabled = !get_by_id("w_enable").checked;
        get_by_id("11g_txrate").disabled = !get_by_id("w_enable").checked;
        get_by_id("11n_txrate").disabled = !get_by_id("w_enable").checked;
        get_by_id("11bg_txrate").disabled = !get_by_id("w_enable").checked;
        get_by_id("11gn_txrate").disabled = !get_by_id("w_enable").checked;
        get_by_id("11bgn_txrate").disabled = !get_by_id("w_enable").checked;
	get_by_id("mbssid_enable").disabled = !get_by_id("w_enable").checked;
	get_by_id("multi_index").disabled = !get_by_id("w_enable").checked;
	if (get_by_id("w_enable").checked == true) {
		if (get_by_id("mbssid_enable").checked == true)
			enable_all();
		else
			disable_all();
	} else {
		disable_all();
	}
        disable_channel();
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
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td id="sidenav_container">
                            <div id="sidenav">
                                <UL>
					<script>show_left("Advance", 17);</script>
                                </UL>
                            </div>
                        </td>
                    </tr>
                </table>
          </td>

            <input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<!--# echo schedule_rule_00 -->">
            <input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<!--# echo schedule_rule_01 -->">
            <input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<!--# echo schedule_rule_02 -->">
            <input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<!--# echo schedule_rule_03 -->">
            <input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<!--# echo schedule_rule_04 -->">
            <input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<!--# echo schedule_rule_05 -->">
            <input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<!--# echo schedule_rule_06 -->">
            <input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<!--# echo schedule_rule_07 -->">
            <input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<!--# echo schedule_rule_08 -->">
            <input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<!--# echo schedule_rule_09 -->">
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

            <input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">

            <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value="">
                <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
                <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_mbssid.asp">
                <input type="hidden" id="reboot_type" name="reboot_type" value="wireless">

                <input type="hidden" id="wps_pin" name="wps_pin" value="<!--# echo wps_pin -->">
                <input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">
                <input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
		<input type="hidden" id="action" name="action" value="multi_ssid">

		<input type="hidden" id="mbssid_idx" name="mbssid_idx" value="<!--# echo mbssid_idx -->">
		<input type="hidden" id="multi_ssid_lan1" name="multi_ssid_lan1" value="<!--# echo multi_ssid_lan1 -->">
		<input type="hidden" id="multi_ssid_lan2" name="multi_ssid_lan2" value="<!--# echo multi_ssid_lan2 -->">
		<input type="hidden" id="multi_ssid_lan3" name="multi_ssid_lan3" value="<!--# echo multi_ssid_lan3 -->">
		<input type="hidden" id="multi_ssid_lan4" name="multi_ssid_lan4" value="<!--# echo multi_ssid_lan4 -->">
<!-- MBSSID 1 -->
                <input type="hidden" id="wlan0_vap1_lan" name="wlan0_vap1_lan" value="<!--# echo wlan0_vap1_lan -->">
                <input type="hidden" id="wlan0_vap1_enable" name="wlan0_vap1_enable" value="<!--# echo wlan0_vap1_enable -->">
                <input type="hidden" id="wlan0_vap1_guest_zone" name="wlan0_vap1_guest_zone" value="<!--# echo wlan0_vap1_guest_zone -->">
		<input type="hidden" id="wlan0_vap1_ssid" name="wlan0_vap1_ssid" value="<!--# echot wlan0_vap1_ssid -->">
		<input type="hidden" id="wlan0_vap1_security" name="wlan0_vap1_security" value="<!--# echo wlan0_vap1_security -->">
                <input type="hidden" id="wlan0_vap1_wep_display" name="wlan0_vap1_wep_display" value="<!--# echo wlan0_vap1_wep_display -->">
	        <input type="hidden" id="wlan0_vap1_wep64_key_1" name="wlan0_vap1_wep64_key_1" value="<!--# echot wlan0_vap1_wep64_key_1 -->">
		<input type="hidden" id="wlan0_vap1_wep128_key_1" name="wlan0_vap1_wep128_key_1" value="<!--# echot wlan0_vap1_wep128_key_1 -->">
		<input type="hidden" id="wlan0_vap1_wep64_key_2" name="wlan0_vap1_wep64_key_2" value="<!--# echot wlan0_vap1_wep64_key_2 -->">
		<input type="hidden" id="wlan0_vap1_wep128_key_2" name="wlan0_vap1_wep128_key_2" value="<!--# echot wlan0_vap1_wep128_key_2 -->">
		<input type="hidden" id="wlan0_vap1_wep64_key_3" name="wlan0_vap1_wep64_key_3" value="<!--# echot wlan0_vap1_wep64_key_3 -->">
		<input type="hidden" id="wlan0_vap1_wep128_key_3" name="wlan0_vap1_wep128_key_3" value="<!--# echot wlan0_vap1_wep128_key_3 -->">
		<input type="hidden" id="wlan0_vap1_wep64_key_4" name="wlan0_vap1_wep64_key_4" value="<!--# echot wlan0_vap1_wep64_key_4 -->">
		<input type="hidden" id="wlan0_vap1_wep128_key_4" name="wlan0_vap1_wep128_key_4" value="<!--# echot wlan0_vap1_wep128_key_4 -->">
		<input type="hidden" id="wlan0_vap1_wep_default_key" name="wlan0_vap1_wep_default_key" value="<!--# echot wlan0_vap1_wep_default_key -->">
		<input type="hidden" id="wlan0_vap1_psk_pass_phrase" name="wlan0_vap1_psk_pass_phrase" value="<!--# echot wlan0_vap1_psk_pass_phrase -->">
		<input type="hidden" id="wlan0_vap1_psk_cipher_type" name="wlan0_vap1_psk_cipher_type" value="<!--# echo wlan0_vap1_psk_cipher_type -->">
		<input type="hidden" id="wlan0_vap1_eap_radius_server_0" name="wlan0_vap1_eap_radius_server_0" value="<!--# echo wlan0_vap1_eap_radius_server_0 -->">
		<input type="hidden" id="wlan0_vap1_eap_mac_auth" name="wlan0_vap1_eap_mac_auth" value="<!--# echo wlan0_vap1_eap_mac_auth -->">
		<input type="hidden" id="wlan0_vap1_eap_radius_server_1" name="wlan0_vap1_eap_radius_server_1" value="<!--# echo wlan0_vap1_eap_radius_server_1 -->">
		<input type="hidden" id="wlan0_vap1_gkey_rekey_time" name="wlan0_vap1_gkey_rekey_time" value="<!--# echo wlan0_vap1_gkey_rekey_time -->">
                <input type="hidden" id="wlan0_vap1_schedule" name="wlan0_vap1_schedule" value="<!--# echo wlan0_vap1_schedule -->">
		<input type="hidden" id="wlan0_vap1_eap_reauth_period" name="wlan0_vap1_eap_reauth_period" value="<!--# echo wlan0_vap1_eap_reauth_period -->">
		<input type="hidden" id="wlan0_vap1_broadcast" name="wlan0_vap1_broadcast" value="<!--# echo wlan0_vap1_broadcast -->">
		<input type="hidden" id="wlan0_vap1_partition" name="wlan0_vap1_partition" value="<!--# echo wlan0_vap1_partition -->">
		<input type="hidden" id="wlan0_vap1_route_btw_zone" name="wlan0_vap1_route_btw_zone" value="<!--# echo wlan0_vap1_route_btw_zone -->">
		<input type="hidden" id="wlan0_vap1_relay_ip" name="wlan0_vap1_relay_ip" value="<!--# echo wlan0_vap1_relay_ip -->">
		<input type="hidden" id="wlan0_vap1_relay" name="wlan0_vap1_relay" value="<!--# echo wlan0_vap1_relay -->">
		
<!-- MBSSID 2 -->
                <input type="hidden" id="wlan0_vap2_lan" name="wlan0_vap2_lan" value="<!--# echo wlan0_vap2_lan -->">
                <input type="hidden" id="wlan0_vap2_enable" name="wlan0_vap2_enable" value="<!--# echo wlan0_vap2_enable -->">
                <input type="hidden" id="wlan0_vap2_guest_zone" name="wlan0_vap2_guest_zone" value="<!--# echo wlan0_vap2_guest_zone -->">
		<input type="hidden" id="wlan0_vap2_ssid" name="wlan0_vap2_ssid" value="<!--# echot wlan0_vap2_ssid -->">
		<input type="hidden" id="wlan0_vap2_security" name="wlan0_vap2_security" value="<!--# echo wlan0_vap2_security -->">
                <input type="hidden" id="wlan0_vap2_wep_display" name="wlan0_vap2_wep_display" value="<!--# echo wlan0_vap2_wep_display -->">
	        <input type="hidden" id="wlan0_vap2_wep64_key_1" name="wlan0_vap2_wep64_key_1" value="<!--# echot wlan0_vap2_wep64_key_1 -->">
		<input type="hidden" id="wlan0_vap2_wep128_key_1" name="wlan0_vap2_wep128_key_1" value="<!--# echot wlan0_vap2_wep128_key_1 -->">
		<input type="hidden" id="wlan0_vap2_wep64_key_2" name="wlan0_vap2_wep64_key_2" value="<!--# echot wlan0_vap2_wep64_key_2 -->">
		<input type="hidden" id="wlan0_vap2_wep128_key_2" name="wlan0_vap2_wep128_key_2" value="<!--# echot wlan0_vap2_wep128_key_2 -->">
		<input type="hidden" id="wlan0_vap2_wep64_key_3" name="wlan0_vap2_wep64_key_3" value="<!--# echot wlan0_vap2_wep64_key_3 -->">
		<input type="hidden" id="wlan0_vap2_wep128_key_3" name="wlan0_vap2_wep128_key_3" value="<!--# echot wlan0_vap2_wep128_key_3 -->">
		<input type="hidden" id="wlan0_vap2_wep64_key_4" name="wlan0_vap2_wep64_key_4" value="<!--# echot wlan0_vap2_wep64_key_4 -->">
		<input type="hidden" id="wlan0_vap2_wep128_key_4" name="wlan0_vap2_wep128_key_4" value="<!--# echot wlan0_vap2_wep128_key_4 -->">
		<input type="hidden" id="wlan0_vap2_wep_default_key" name="wlan0_vap2_wep_default_key" value="<!--# echot wlan0_vap2_wep_default_key -->">
		<input type="hidden" id="wlan0_vap2_psk_pass_phrase" name="wlan0_vap2_psk_pass_phrase" value="<!--# echot wlan0_vap2_psk_pass_phrase -->">
		<input type="hidden" id="wlan0_vap2_psk_cipher_type" name="wlan0_vap2_psk_cipher_type" value="<!--# echo wlan0_vap2_psk_cipher_type -->">
		<input type="hidden" id="wlan0_vap2_eap_radius_server_0" name="wlan0_vap2_eap_radius_server_0" value="<!--# echo wlan0_vap2_eap_radius_server_0 -->">
		<input type="hidden" id="wlan0_vap2_eap_mac_auth" name="wlan0_vap2_eap_mac_auth" value="<!--# echo wlan0_vap2_eap_mac_auth -->">
		<input type="hidden" id="wlan0_vap2_eap_radius_server_1" name="wlan0_vap2_eap_radius_server_1" value="<!--# echo wlan0_vap2_eap_radius_server_1 -->">
		<input type="hidden" id="wlan0_vap2_gkey_rekey_time" name="wlan0_vap2_gkey_rekey_time" value="<!--# echo wlan0_vap2_gkey_rekey_time -->">
                <input type="hidden" id="wlan0_vap2_schedule" name="wlan0_vap2_schedule" value="<!--# echo wlan0_vap2_schedule -->">
		<input type="hidden" id="wlan0_vap2_eap_reauth_period" name="wlan0_vap2_eap_reauth_period" value="<!--# echo wlan0_vap2_eap_reauth_period -->">
		<input type="hidden" id="wlan0_vap2_broadcast" name="wlan0_vap2_broadcast" value="<!--# echo wlan0_vap2_broadcast -->">
		<input type="hidden" id="wlan0_vap2_partition" name="wlan0_vap2_partition" value="<!--# echo wlan0_vap2_partition -->">
		<input type="hidden" id="wlan0_vap2_route_btw_zone" name="wlan0_vap2_route_btw_zone" value="<!--# echo wlan0_vap2_route_btw_zone -->">
		<input type="hidden" id="wlan0_vap2_relay_ip" name="wlan0_vap2_relay_ip" value="<!--# echo wlan0_vap2_relay_ip -->">
		<input type="hidden" id="wlan0_vap2_relay" name="wlan0_vap2_relay" value="<!--# echo wlan0_vap2_relay -->">

<!-- MBSSID 3 -->
                <input type="hidden" id="wlan0_vap3_lan" name="wlan0_vap3_lan" value="<!--# echo wlan0_vap3_lan -->">
                <input type="hidden" id="wlan0_vap3_enable" name="wlan0_vap3_enable" value="<!--# echo wlan0_vap3_enable -->">
                <input type="hidden" id="wlan0_vap3_guest_zone" name="wlan0_vap3_guest_zone" value="<!--# echo wlan0_vap3_guest_zone -->">
		<input type="hidden" id="wlan0_vap3_ssid" name="wlan0_vap3_ssid" value="<!--# echot wlan0_vap3_ssid -->">
		<input type="hidden" id="wlan0_vap3_security" name="wlan0_vap3_security" value="<!--# echo wlan0_vap3_security -->">
                <input type="hidden" id="wlan0_vap3_wep_display" name="wlan0_vap3_wep_display" value="<!--# echo wlan0_vap3_wep_display -->">
	        <input type="hidden" id="wlan0_vap3_wep64_key_1" name="wlan0_vap3_wep64_key_1" value="<!--# echot wlan0_vap3_wep64_key_1 -->">
		<input type="hidden" id="wlan0_vap3_wep128_key_1" name="wlan0_vap3_wep128_key_1" value="<!--# echot wlan0_vap3_wep128_key_1 -->">
		<input type="hidden" id="wlan0_vap3_wep64_key_2" name="wlan0_vap3_wep64_key_2" value="<!--# echot wlan0_vap3_wep64_key_2 -->">
		<input type="hidden" id="wlan0_vap3_wep128_key_2" name="wlan0_vap3_wep128_key_2" value="<!--# echot wlan0_vap3_wep128_key_2 -->">
		<input type="hidden" id="wlan0_vap3_wep64_key_3" name="wlan0_vap3_wep64_key_3" value="<!--# echot wlan0_vap3_wep64_key_3 -->">
		<input type="hidden" id="wlan0_vap3_wep128_key_3" name="wlan0_vap3_wep128_key_3" value="<!--# echot wlan0_vap3_wep128_key_3 -->">
		<input type="hidden" id="wlan0_vap3_wep64_key_4" name="wlan0_vap3_wep64_key_4" value="<!--# echot wlan0_vap3_wep64_key_4 -->">
		<input type="hidden" id="wlan0_vap3_wep128_key_4" name="wlan0_vap3_wep128_key_4" value="<!--# echot wlan0_vap3_wep128_key_4 -->">
		<input type="hidden" id="wlan0_vap3_wep_default_key" name="wlan0_vap3_wep_default_key" value="<!--# echot wlan0_vap3_wep_default_key -->">
		<input type="hidden" id="wlan0_vap3_psk_pass_phrase" name="wlan0_vap3_psk_pass_phrase" value="<!--# echot wlan0_vap3_psk_pass_phrase -->">
		<input type="hidden" id="wlan0_vap3_psk_cipher_type" name="wlan0_vap3_psk_cipher_type" value="<!--# echo wlan0_vap3_psk_cipher_type -->">
		<input type="hidden" id="wlan0_vap3_eap_radius_server_0" name="wlan0_vap3_eap_radius_server_0" value="<!--# echo wlan0_vap3_eap_radius_server_0 -->">
		<input type="hidden" id="wlan0_vap3_eap_mac_auth" name="wlan0_vap3_eap_mac_auth" value="<!--# echo wlan0_vap3_eap_mac_auth -->">
		<input type="hidden" id="wlan0_vap3_eap_radius_server_1" name="wlan0_vap3_eap_radius_server_1" value="<!--# echo wlan0_vap3_eap_radius_server_1 -->">
		<input type="hidden" id="wlan0_vap3_gkey_rekey_time" name="wlan0_vap3_gkey_rekey_time" value="<!--# echo wlan0_vap3_gkey_rekey_time -->">
                <input type="hidden" id="wlan0_vap3_schedule" name="wlan0_vap3_schedule" value="<!--# echo wlan0_vap3_schedule -->">
		<input type="hidden" id="wlan0_vap3_eap_reauth_period" name="wlan0_vap3_eap_reauth_period" value="<!--# echo wlan0_vap3_eap_reauth_period -->">
		<input type="hidden" id="wlan0_vap3_broadcast" name="wlan0_vap3_broadcast" value="<!--# echo wlan0_vap3_broadcast -->">
		<input type="hidden" id="wlan0_vap3_partition" name="wlan0_vap3_partition" value="<!--# echo wlan0_vap3_partition -->">
		<input type="hidden" id="wlan0_vap3_route_btw_zone" name="wlan0_vap3_route_btw_zone" value="<!--# echo wlan0_vap3_route_btw_zone -->">
		<input type="hidden" id="wlan0_vap3_relay_ip" name="wlan0_vap3_relay_ip" value="<!--# echo wlan0_vap3_relay_ip -->">
		<input type="hidden" id="wlan0_vap3_relay" name="wlan0_vap3_relay" value="<!--# echo wlan0_vap3_relay -->">

<!-- MBSSID 4 -->
                <input type="hidden" id="wlan0_vap4_lan" name="wlan0_vap4_lan" value="<!--# echo wlan0_vap4_lan -->">
                <input type="hidden" id="wlan0_vap4_enable" name="wlan0_vap4_enable" value="<!--# echo wlan0_vap4_enable -->">
                <input type="hidden" id="wlan0_vap4_guest_zone" name="wlan0_vap4_guest_zone" value="<!--# echo wlan0_vap4_guest_zone -->">
		<input type="hidden" id="wlan0_vap4_ssid" name="wlan0_vap4_ssid" value="<!--# echot wlan0_vap4_ssid -->">
		<input type="hidden" id="wlan0_vap4_security" name="wlan0_vap4_security" value="<!--# echo wlan0_vap4_security -->">
                <input type="hidden" id="wlan0_vap4_wep_display" name="wlan0_vap4_wep_display" value="<!--# echo wlan0_vap4_wep_display -->">
	        <input type="hidden" id="wlan0_vap4_wep64_key_1" name="wlan0_vap4_wep64_key_1" value="<!--# echot wlan0_vap4_wep64_key_1 -->">
		<input type="hidden" id="wlan0_vap4_wep128_key_1" name="wlan0_vap4_wep128_key_1" value="<!--# echot wlan0_vap4_wep128_key_1 -->">
		<input type="hidden" id="wlan0_vap4_wep64_key_2" name="wlan0_vap4_wep64_key_2" value="<!--# echot wlan0_vap4_wep64_key_2 -->">
		<input type="hidden" id="wlan0_vap4_wep128_key_2" name="wlan0_vap4_wep128_key_2" value="<!--# echot wlan0_vap4_wep128_key_2 -->">
		<input type="hidden" id="wlan0_vap4_wep64_key_3" name="wlan0_vap4_wep64_key_3" value="<!--# echot wlan0_vap4_wep64_key_3 -->">
		<input type="hidden" id="wlan0_vap4_wep128_key_3" name="wlan0_vap4_wep128_key_3" value="<!--# echot wlan0_vap4_wep128_key_3 -->">
		<input type="hidden" id="wlan0_vap4_wep64_key_4" name="wlan0_vap4_wep64_key_4" value="<!--# echot wlan0_vap4_wep64_key_4 -->">
		<input type="hidden" id="wlan0_vap4_wep128_key_4" name="wlan0_vap4_wep128_key_4" value="<!--# echot wlan0_vap4_wep128_key_4 -->">
		<input type="hidden" id="wlan0_vap4_wep_default_key" name="wlan0_vap4_wep_default_key" value="<!--# echot wlan0_vap4_wep_default_key -->">
		<input type="hidden" id="wlan0_vap4_psk_pass_phrase" name="wlan0_vap4_psk_pass_phrase" value="<!--# echot wlan0_vap4_psk_pass_phrase -->">
		<input type="hidden" id="wlan0_vap4_psk_cipher_type" name="wlan0_vap4_psk_cipher_type" value="<!--# echo wlan0_vap4_psk_cipher_type -->">
		<input type="hidden" id="wlan0_vap4_eap_radius_server_0" name="wlan0_vap4_eap_radius_server_0" value="<!--# echo wlan0_vap4_eap_radius_server_0 -->">
		<input type="hidden" id="wlan0_vap4_eap_mac_auth" name="wlan0_vap4_eap_mac_auth" value="<!--# echo wlan0_vap4_eap_mac_auth -->">
		<input type="hidden" id="wlan0_vap4_eap_radius_server_1" name="wlan0_vap4_eap_radius_server_1" value="<!--# echo wlan0_vap4_eap_radius_server_1 -->">
		<input type="hidden" id="wlan0_vap4_gkey_rekey_time" name="wlan0_vap4_gkey_rekey_time" value="<!--# echo wlan0_vap4_gkey_rekey_time -->">
                <input type="hidden" id="wlan0_vap4_schedule" name="wlan0_vap4_schedule" value="<!--# echo wlan0_vap4_schedule -->">
		<input type="hidden" id="wlan0_vap4_eap_reauth_period" name="wlan0_vap4_eap_reauth_period" value="<!--# echo wlan0_vap4_eap_reauth_period -->">
		<input type="hidden" id="wlan0_vap4_broadcast" name="wlan0_vap4_broadcast" value="<!--# echo wlan0_vap4_broadcast -->">
		<input type="hidden" id="wlan0_vap4_partition" name="wlan0_vap4_partition" value="<!--# echo wlan0_vap4_partition -->">
		<input type="hidden" id="wlan0_vap4_route_btw_zone" name="wlan0_vap4_route_btw_zone" value="<!--# echo wlan0_vap4_route_btw_zone -->">
		<input type="hidden" id="wlan0_vap4_relay_ip" name="wlan0_vap4_relay_ip" value="<!--# echo wlan0_vap4_relay_ip -->">
		<input type="hidden" id="wlan0_vap4_relay" name="wlan0_vap4_relay" value="<!--# echo wlan0_vap4_relay -->">

<!-- Wireless Basic Setting -->
		<input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<!--# echo wlan0_enable -->">
		<input type="hidden" id="wlan0_dot11_mode" name="wlan0_dot11_mode" value="<!--# echo wlan0_dot11_mode -->">
		<input type="hidden" id="wlan0_auto_channel_enable" name="wlan0_auto_channel_enable" value="<!--# echo wlan0_auto_channel_enable -->">
		<input type="hidden" id="wlan0_channel" name="wlan0_channel" value="<!--# echo wlan0_channel -->">
		<input type="hidden" id="wlan0_11g_txrate" name="wlan0_11g_txrate" value="<!--# echo wlan0_11g_txrate -->">
		<input type="hidden" id="wlan0_11b_txrate" name="wlan0_11b_txrate" value="<!--# echo wlan0_11b_txrate -->">
		<input type="hidden" id="wlan0_11n_txrate" name="wlan0_11n_txrate" value="<!--# echo wlan0_11n_txrate -->">
		<input type="hidden" id="wlan0_11bg_txrate" name="wlan0_11bg_txrate" value="<!--# echo wlan0_11bg_txrate -->">
		<input type="hidden" id="wlan0_11gn_txrate" name="wlan0_11gn_txrate" value="<!--# echo wlan0_11gn_txrate -->">
		<input type="hidden" id="wlan0_11bgn_txrate" name="wlan0_11bgn_txrate" value="<!--# echo wlan0_11bgn_txrate -->">
		<input type="hidden" id="wlan0_11n_protection" name="wlan0_11n_protection" value="<!--# echo wlan0_11n_protection -->">
		<input type="hidden" id="wlan0_txpower" name="wlan0_txpower" value="<!--# echo wlan0_txpower -->">

              <td valign="top" id="maincontent_container">
                <div id="maincontent"> <!-- maincontent -->
                  <div id="box_header"> <!-- box_header -->
                    <h1><script>show_words(mbssid)</script></h1>
                    <script>show_words(guestzone_Intro_1)</script><br><br>
                    <input name="button" id="button" type="submit" class=button_submit onClick="return send_request()">
                    <input name="button2" id="button2"type="button" class=button_submit onclick="return page_cancel('form1', 'adv_mbssid.asp');">
                    <script>get_by_id("button").value = _savesettings;</script>
                    <script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <br>

		  <div class="box">
                  <h2><script>show_words(bwl_title_1)</script></h2>
                    <table cellpadding="1" cellspacing="1" border="0" width="525">
                      <tr>
              		<td class="duple"><script>show_words(bwl_EW)</script> :</td>
		        <td width="340">&nbsp; <input id="w_enable" name="w_enable" type="checkbox" value="1" onClick="disable_wireless();" checked>
              		</td>
                      </tr>
                      <tr>
	                <td class="duple"><script>show_words(bwl_Mode)</script> :</td>
                        <td width="340">&nbsp;&nbsp;
                        <select id="dot11_mode" name="dot11_mode" onClick="show_chan_width();">
				<option value="11b"><script>show_words(bwl_Mode_1)</script></option>
				<option value="11g"><script>show_words(bwl_Mode_2)</script></option>
				<option value="11n"><script>show_words(bwl_Mode_n)</script></option>
				<option value="11bg"><script>show_words(bwl_Mode_3)</script></option>
				<option value="11gn"><script>show_words(bwl_Mode_10)</script></option>
				<option value="11bgn"><script>show_words(bwl_Mode_11)</script></option>
			</select>
			</td>
		      </tr>
                      <tr>
			<td class="duple"><script>show_words(ebwl_AChan)</script> :</td>
			<td width="340">&nbsp;
			<input type="checkbox" id="auto_channel" name="auto_channel" value="1" onClick="disable_channel();">
			</td>
		      </tr>
                      <tr>
			<td class="duple"><script>show_words(_wchannel)</script> :</td>
			<td width="340">&nbsp;&nbsp; 
			<select name="sel_wlan0_channel" id="sel_wlan0_channel">
			  <script>set_channel();</script>
			</select>
			</td>
		      </tr>
			<!-- 11b txrate -->
			<tr id="show_11b_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11b_txrate" name="11b_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11b_txrate(get_by_id("11b_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<!-- 11g txrate -->
			<tr id="show_11g_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11g_txrate" name="11g_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11g_txrate(get_by_id("11g_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<!-- 11n txrate -->
			<tr id="show_11n_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11n_txrate" name="11n_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11n_txrate(get_by_id("11n_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<!-- 11b/g txrate -->
			<tr id="show_11bg_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11bg_txrate" name="11bg_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11bg_txrate(get_by_id("11bg_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<!-- 11g/n txrate -->
			<tr id="show_11gn_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11gn_txrate" name="11gn_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11gn_txrate(get_by_id("11gn_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<!-- 11b/g/n txrate -->
			<tr id="show_11bgn_txrate" style="display:none">
			    <td class="duple"><script>show_words(bwl_TxR)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11bgn_txrate" name="11bgn_txrate">
				<option value="" selected>Best(automatic)</option>
				<script>set_11bgn_txrate(get_by_id("11bgn_txrate"));</script>
			    </select>
			    </td>
			</tr>
			<tr id="show_channel_width">
			    <td class="duple"><script>show_words(bwl_CWM)</script> :</td>
			    <td width="340">&nbsp;&nbsp;
			    <select id="11n_protection" name="11n_protection">
				<option value="20"><script>show_words(bwl_ht20)</script></option>
				<option value="auto"><script>show_words(bwl_ht2040)</script></option>
			    </select>
			    </td>
			</tr>
			<tr style="display:none">
			  <td class="duple"><script>show_words(aw_TP);</script> :</td>
			  <td width="340">&nbsp;&nbsp;
			    <select id="wlan_txpower" name="wlan_txpower" size="1">
			      <option value="high"><script>show_words(aw_TP_0);</script></option>
			      <option value="medium"><script>show_words(aw_TP_1);</script></option>
			      <option value="low"><script>show_words(aw_TP_2);</script></option>
			    </select>
			  </td>
			</tr>
		    </table>
	  </div>
	  <br>
                  <div class="box">
                  <h2><script>show_words(mbssid+" "+mbssid_setting)</script></h2>
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"><script>show_words(_enable+" "+mbssid)</script> :</td>
              <td>&nbsp;&nbsp;<input name="mbssid_enable" id="mbssid_enable" type="checkbox" onclick="enable_mbssid()" value="0">
                <select id="mbssid_schedule_select" name="mbssid_schedule_select" onChange="get_mbssid_schedule(this);">
                  <option value="Always" selected><script>show_words(_always)</script></option>
                  <option value="Never"><script>show_words(_never)</script></option>
                    <script>document.write(set_schedule_option());</script>
                </select>
                <input name="add_new_schedule" type="button" class="button_submit" id="add_new_schedule" onclick="do_add_new_schedule(true)" value="">
                <script>get_by_id("add_new_schedule").value = dlink_1_add_new;</script>
                </td>
            </tr>
	    <tr>
	      <td class="duple"><script>show_words("SSID")</script> :</td>
              <td width="340">&nbsp;&nbsp;
		<select id="multi_index" name="multi_index" onChange="select_mbssid(this)">
		  <option value="1"><script>show_words(mbssid)</script>1</option>
		  <option value="2"><script>show_words(mbssid)</script>2</option>
		  <option value="3"><script>show_words(mbssid)</script>3</option>
		  <option value="4"><script>show_words(mbssid)</script>4</option>
		</select>
              </td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(wwl_band)</script> :</td>
              <td width="340">&nbsp;&nbsp;&nbsp;<strong><script>show_words(GW_WLAN_RADIO_0_NAME)</script></strong></td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(bwl_NN)</script> :</td>
              <td width="340">&nbsp;&nbsp;&nbsp;<input name="mbssid_ssid" type="text" id="mbssid_ssid" size="20" maxlength="32" value="">
                <script>show_words(bwl_AS)</script>
	      </td>
            </tr>
	    <tr>
              <td class="duple"><script>show_words(bwl_VS)</script> :</td>
	      <td width="340">&nbsp;&nbsp;
		<input type="radio" id="mbssid_broadcast" name="mbssid_broadcast" value="1"><script>show_words(bwl_VS_0)</script>
	        <input type="radio" id="mbssid_broadcast" name="mbssid_broadcast" value="0"><script>show_words(bwl_VS_1)</script>
              </td>
            </tr>
	    <tr>
              <td class="duple"><script>show_words(KR4)</script> :</td>
	      <td width="340">&nbsp;&nbsp;<input type="checkbox" id="mbssid_partition" name="mbssid_partition" value="0"></td>
            </tr>
            <tr>
              <td class="duple"><script>show_words(S473)</script> :</td>
              <td width="340">&nbsp;&nbsp;<input name="mbssid_route_btw_zone" id="mbssid_route_btw_zone" type="checkbox"  value="0"></td>
            </tr>
          </table>

          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr id="show_wlan0_wep">
              <td class="duple"><script>show_words(bws_SM)</script> :</td>
              <td width="340">&nbsp;&nbsp;
		<select id="security_type" name="security_type" onChange="select_security(this)">
                <option value="0" selected><script>show_words(_none)</script></option>
                <option value="1"><script>show_words(_WEP)</script></option>
                <option value="2"><script>show_words(_WPApersonal)</script></option>
                <option value="3"><script>show_words(_WPAenterprise)</script></option>
                </select>
	      </td>
            </tr>
          </table>
        </div> <!-- End box_header -->

        <div class="box" id="show_wep" style="display:none"> <!-- show_wep -->
	<h2><script>show_words(_WEP)</script></h2>
	<p><script>show_words(bws_msg_WEP_1)</script></p>
	<p><script>show_words(bws_msg_WEP_2)</script></p>
	<p><script>show_words(bws_msg_WEP_3)</script></p>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		    <td class="duple"><script>show_words(bws_WKL)</script> :</td>
		    <td width="340">&nbsp;
		      <select id="wep_key_len" name="wep_key_len" size=1>
			<option value="5"><script>show_words(bws_WKL_0)</script></option>
			<option value="13"><script>show_words(bws_WKL_1)</script></option>
		      </select>
		      <script>show_words(bws_length)</script></td>
		</tr>
		<tr style="display:none">
		    <td class="duple"><script>show_words(bws_DFWK)</script> :</td>
		    <td width="340">&nbsp;
			<select id="wep_def_key" name="wep_def_key">
			    <option value="1"><script>show_words(wepkey1)</script></option>
			    <option value="2"><script>show_words(wepkey2)</script></option>
			    <option value="3"><script>show_words(wepkey3)</script></option>
			    <option value="4"><script>show_words(wepkey4)</script></option>
			</select>
		    </td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(auth)</script> :</td>
		    <td width="340">&nbsp;
			<select name="auth_type" id="auth_type">
			    <option value="open"><script>show_words(_both)</script></option>
			    <option value="share"><script>show_words(bws_Auth_2)</script></option>
		      </select>
		    </td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(_wepkey1)</script> :</td>
		    <td width="340">&nbsp;
			<span id="show_resert1"></span>
		    </td>
		</tr>
		<tr style="display:none">
		    <td class="duple"><script>show_words(_wepkey2)</script> :</td>
		    <td width="340">&nbsp;
			<span id="show_resert2"></span>
		    </td>
		</tr>
		<tr style="display:none">
		    <td class="duple"><script>show_words(_wepkey3)</script> :</td>
		    <td width="340">&nbsp;
			<span id="show_resert3"></span>
		    </td>
		</tr>
		<tr style="display:none">
		    <td class="duple"><script>show_words(_wepkey4)</script> :</td>
		    <td width="340">&nbsp;
			<span id="show_resert4"></span>
		    </td>
		</tr>
	    </table>
    </div> <!-- End show_wep -->

    <div class="box" id="show_wpa" style="display:none"> <!-- show_wpa -->
	<h2><script>show_words(_WPA)</script></h2>
	<p><script>show_words(bws_msg_WPA)</script></p>
	<p><script>show_words(bws_msg_WPA_2)</script></p>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		    <td class="duple"> <script>show_words(bws_WPAM)</script> :</td>
		    <td width="340">&nbsp;
			<select id="wpa_mode" name="wpa_mode">
			    <option value="auto"><script>show_words(bws_WPAM_2)</script></option>
			    <option value="wpa2"><script>show_words(bws_WPAM_3)</script></option>
			    <option value="wpa"><script>show_words(bws_WPAM_1)</script></option>
			</select>
		    </td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_CT)</script> :</td>
		    <td width="340">&nbsp;
			<select id="c_type" name="c_type" >
			    <option value="tkip"><script>show_words(bws_CT_1)</script></option>
			    <option value="aes"><script>show_words(bws_CT_2)</script></option>
			    <option value="both"><script>show_words(bws_CT_3)</script></option>
			</select>
		    </td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_GKUI)</script> :</td>
		    <td width="340">&nbsp;
			<input type="text" id="mbssid_gkey_rekey_time" name="mbssid_gkey_rekey_time" size="8" maxlength="5" value="">
			<script>show_words(bws_secs)</script>
		    </td>
		</tr>
	    </table>
    </div> <!-- End show_wpa -->

    <div class="box" id="show_wpa_psk" style="display:none"> <!-- show_wpa_psk -->
	<h2><script>show_words(_psk)</script></h2>
	<p class="box_msg">
	<script>show_words(KR18)</script>
	<script>show_words(KR19)</script>
	</p>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		    <td class="duple"><script>show_words(_psk)</script> :</td>
		    <td width="340">&nbsp;<input type="password" id="mbssid_psk_pass_phrase" name="mbssid_psk_pass_phrase" size="40" maxlength="64" onfocus="select()"></td>
		</tr>
	    </table>
    </div> <!-- End show_wpa_psk -->

    <div class="box" id="show_wpa_eap" style="display:none"> <!-- show_wpa_eap -->
	<h2><script>show_words(bws_EAPx)</script></h2>
	<p class="box_msg"><script>show_words(bws_msg_EAP)</script>  </p>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		    <td class="duple"><script>show_words(bwsAT_)</script> :</td>
		    <td width="340">&nbsp;<input id="mbssid_eap_reauth_period" name="mbssid_eap_reauth_period" size=10 value="">
		    <script>show_words(_minutes)</script></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_RIPA)</script> :</td>
		    <td width="340">&nbsp;<input id="radius_ip1" name="radius_ip1" maxlength=15 size=15></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_RSP)</script> :</td>
		    <td width="340">&nbsp;<input type="text" id="radius_port1" name="radius_port1" size="8" maxlength="5" value="1812"></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_RSSs)</script> :</td>
		    <td width="340">&nbsp;<input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64" onfocus="select();"></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_RMAA)</script> :</td>
		    <td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac1" name="radius_auth_mac1"></td>
		</tr>
		<tr id="radius2">
		    <td colspan="2">
		    <input type="button" id="advanced" name="advanced" value="">
		    <script>get_by_id("advanced").value = _advanced+">>";</script> </td>
		</tr>
	    </table>
	    <table id="show_radius2" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
		<tr>
		    <td class="box_msg" colspan="2"><script>show_words(bws_ORAD)</script> :</td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_2RIPA)</script> :</td>
		    <td width="340">&nbsp;<input id="radius_ip2" name="radius_ip2" maxlength=15 size=15></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_2RSP)</script> :</td>
		    <td width="340">&nbsp;<input type="text" id="radius_port2" name="radius_port2" size="8" maxlength="5" value="1812"></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_2RSSS)</script> :</td>
		    <td width="340">&nbsp;<input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64" onfocus="select();"></td>
		</tr>
		<tr>
		    <td class="duple"><script>show_words(bws_2RMAA)</script> :</td>
		    <td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac2" name="radius_auth_mac2"></td>
		</tr>
	    </table>
    </div> <!-- End show_wpa_eap -->
    <div class="box" id="show_routing"> <!-- routing setting -->
	<h2><script>show_words(bln_title_Rtrset +" "+ mbssid_for_gzone)</script></h2>
	<script>show_words(mbssid_route_info);</script>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		  <td class="duple"><script>show_words(_ripaddr);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_ipaddr" type="text" id="lan_ipaddr" size="20" maxlength="15" value=""></td>
		</tr>
		<tr>
		  <td class="duple"><script>show_words(_subnet);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_netmask" type="text" id="lan_netmask" size="20" maxlength="15" value=""></td>
		</tr>
		<tr>
		  <td class="duple"><script>show_words(bln_EnDHCPRelay);</script> :</td>
		  <td width="340">&nbsp;
		  <input name="dhcprelay" type="checkbox" id="dhcprelay" value="0"><br>
		  &nbsp;&nbsp;&nbsp;<input name="relay_ipaddr" type="text" id="relay_ipaddr" size="20" maxlength="15" value="">
		  </td>
		</tr>														
	  </table>
    </div> <!-- End routing_setting -->
    <div class="box" id="show_dhcp"> <!-- dhcp server setting -->
	<h2><script>show_words(dhcp_set_for + mbssid_for_gzone)</script></h2>
	<script>show_words(mbssid_dhcp_info);</script>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		  <td class="duple"><script>show_words(bd_EDSv);</script> :</td>
		  <td width="340">&nbsp;
		  <input name="dhcpserver" type="checkbox" id="dhcpserver" value="0">
		  </td>
		</tr>														
		<tr>
		  <td class="duple"><script>show_words(bd_DIPAR);</script> :</td>
		  <td width="340">&nbsp;&nbsp;
			<input name="dhcp_start" type="text" id="dhcp_start" size="20" maxlength="15" value="">
			&nbsp;to&nbsp;
			<input name="dhcp_end" type="text" id="dhcp_end" size="20" maxlength="15" value="">
		  </td>
		</tr>
		<tr>
		  <td class="duple"><script>show_words(bd_DLT);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="dhcp_leasetime" type="text" id="dhcp_leasetime" size="20" maxlength="15" value="">(<script>show_words(gw_mins);</script>)</td>
		</tr>
	  </table>
    </div> <!-- End routing_setting -->
   
    <div class="box" > <!-- List -->
      <h2><script>show_words(mbssid+" "+mbssid_list);</script></h2>
	<span id="show_table"></span>
    </div> <!-- End List -->
    </div> <!-- End maninconter -->
    </td>
    </form> 
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                        <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
                          <p><script>show_words(guestzone_Intro_1)</script></p>
                          <p><a href="support_adv.asp#GuestZone" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                        </td>
                    </tr>
                  </tbody>
                </table>
            </td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
<script language="JavaScript">
    var submit_button_flag = 0;

    $(document).ready(function() {
	/* advanced */
	var radius_flag = 0;

	$("#advanced").click(function(){
	  if (radius_flag == 0) {
		$("#show_radius2").show();
		$("#advanced").val(_advanced+"<<");
		radius_flag = 1;
	  } else {
		$("#show_radius2").hide();
		$("#advanced").val(_advanced+">>");
		radius_flag = 0;
	  }
	});

	$("#dhcprelay").click(function(){
		if (!$("#dhcprelay").attr('checked')) {
			$("#relay_ipaddr").hide();
		} else {
			//var relay_ip = "<!--# echo dhcp_relay_ip -->"
			$("#relay_ipaddr").show();
			//$("#relay_ipaddr").val(relay_ip);
			$("#dhcp_start").attr('disabled', 'disabled');
			$("#dhcp_end").attr('disabled', 'disabled');
			$("#dhcp_leasetime").attr('disabled', 'disabled');
			$("#dhcpserver").attr('checked', false);
		}
	});
	//multi_ssid_lanx = athx,ip,mask,ip_start,ip_end,dhcp_leasetime,dhcps_en
	var idx = $("#multi_index")[0].options[$("#multi_index")[0].selectedIndex].value;
	var lan = ($("#multi_ssid_lan"+idx).val()).split(",");
	$("#lan_ipaddr").val(lan[1]);
	$("#lan_netmask").val(lan[2]);
	var tmp_lan = (lan[1]).split(".");
	$("#dhcp_start").val(lan[3]);
	$("#dhcp_end").val(lan[4]);
	$("#dhcp_leasetime").val(lan[5]);
	if (lan[6] == "0") {
		$("#dhcpserver").attr('checked', false);
		$("#dhcp_start").attr('disabled', 'disabled');
		$("#dhcp_end").attr('disabled', 'disabled');
		$("#dhcp_leasetime").attr('disabled', 'disabled');
	} else {
		$("#dhcpserver").attr('checked', true);
		$("#relay_ipaddr").hide();
	}
	$("#dhcpserver").click(function(){
		if (!$("#dhcpserver").attr('checked')) {
			$("#dhcp_start").attr('disabled', 'disabled');
			$("#dhcp_end").attr('disabled', 'disabled');
			$("#dhcp_leasetime").attr('disabled', 'disabled');
		} else {
			$("#dhcp_start").attr('disabled', '');
			$("#dhcp_end").attr('disabled', '');
			$("#dhcp_leasetime").attr('disabled', '');
			$("#dhcprelay").attr('checked', false);
			$("#relay_ipaddr").hide();
		}
	});
    });

    function do_add_new_schedule()
    {
        window.location.href = "tools_schedules.asp";
    }

    function set_txpower(txpower, obj)
    {
	var len = obj.options.length;
	for (var i = 0; i < len; i++) {
		if (txpower == obj.options[i].value){
			obj.selectedIndex = i;
			break;
		}
	}
    }

    function onPageLoad() 
    {
	var mbssid = $("#mbssid_idx").val();
	set_selectIndex(mbssid, get_by_id("multi_index"));

	var security = $("#wlan0_vap"+ mbssid + "_security").val();
	init_security(security, mbssid);
	set_form_default_values("form1");
	if($("#wlan0_vap"+ mbssid + "_enable").val() == 0) {
		disable_all();
	}
	set_dhcprelay(mbssid);

        set_checked(get_by_id("wlan0_enable").value, get_by_id("w_enable"));
        set_checked(get_by_id("wlan0_auto_channel_enable").value, get_by_id("auto_channel"));
        get_by_id("sel_wlan0_channel").disabled = true;
        set_selectIndex("<!--# echo wlan0_dot11_mode -->", get_by_id("dot11_mode"));
        set_selectIndex("<!--# echo wlan0_11n_protection -->", get_by_id("11n_protection"));
        set_selectIndex("<!--# echo wlan0_11b_txrate -->", get_by_id("11b_txrate"));
        set_selectIndex("<!--# echo wlan0_11g_txrate -->", get_by_id("11g_txrate"));
        set_selectIndex("<!--# echo wlan0_11n_txrate -->", get_by_id("11n_txrate"));
        set_selectIndex("<!--# echo wlan0_11bg_txrate -->", get_by_id("11bg_txrate"));
        set_selectIndex("<!--# echo wlan0_11gn_txrate -->", get_by_id("11gn_txrate"));
        set_selectIndex("<!--# echo wlan0_11bgn_txrate -->", get_by_id("11bgn_txrate"));
	set_txpower("<!--# echo wlan0_txpower -->", get_by_id("wlan_txpower"));
        disable_wireless();
        disable_channel();
        show_chan_width();
	set_form_default_values("form1");
    }

    function disable_all()
    {
	    $("#mbssid_schedule_select").attr("disabled", "true");
	    $("#add_new_schedule").attr("disabled", "true");
	    $("#mbssid_ssid").attr("disabled", "true");
	    $(":radio").attr("disabled", "true");
	    $("#mbssid_partition").attr("disabled", "true");
	    $("#mbssid_route_btw_zone").attr("disabled", "true");
	    $("#security_type").attr("disabled", "true");
	    disable_div();
	    $("#show_routing").hide();
	    $("#show_dhcp").hide();
    }

    function enable_all()
    {
	    $("#mbssid_schedule_select").attr("disabled", "");
	    $("#add_new_schedule").attr("disabled", "");
	    $("#mbssid_ssid").attr("disabled", "");
	    $(":radio").attr("disabled", "");
	    $("#mbssid_partition").attr("disabled", "");
	    $("#mbssid_route_btw_zone").attr("disabled", "");
	    $("#security_type").attr("disabled", "");
	    $("#show_routing").show();
	    $("#show_dhcp").show();
    }

    function enable_mbssid()
    {
	var mbssid_idx = $("#multi_index")[0].selectedIndex; /* index */
	var idx = $("#multi_index")[0].options[mbssid_idx].value;
	if($("#mbssid_enable").attr('checked') == true) {
		var sec_idx = $("#security_type")[0].selectedIndex;
		var sec_value = $("#security_type")[0].options[sec_idx].value;
		if(sec_value == 1 && !check_wep_enabled(idx)) {
			$("#mbssid_enable").attr("checked", false);
		} else {
			enable_all();
			var security = $("#wlan0_vap"+idx+"_security").val();
			init_security(security, idx);
			$("#mbssid_enable").attr("checked", true);
		}
	} else {
		disable_all();
	}
    }

    function set_wep(idx)
    {
	if(!check_wep_enabled(idx)) {
		var security = $("#wlan0_vap"+idx+"_security").val();
		init_security(security, idx);
		return false;
	} else {
		$("#show_wep").show();
		var security = $("#wlan0_vap"+idx+"_security").val();
		init_wep(security, idx);
	}
	return true;
    }

    function set_wpa(idx)
    {
	$("#show_wpa").show();
	$("#show_wpa_psk").show();
	var security = $("#wlan0_vap"+idx+"_security").val();
	if (security.match(/auto/gi)) {
		get_by_id("wpa_mode").selectedIndex = 0;
	} else if (security.match(/wpa2/gi)) {
		get_by_id("wpa_mode").selectedIndex = 1;
	} else if (security.match(/wpa/gi)) {
		get_by_id("wpa_mode").selectedIndex = 2;
	} else {
		get_by_id("wpa_mode").selectedIndex = 0;
	}
	var psk = $("#wlan0_vap"+idx+"_psk_pass_phrase").val();
	var cipher = $("#wlan0_vap"+idx+"_psk_cipher_type").val();
	var rekey_time = $("#wlan0_vap"+idx+"_gkey_rekey_time").val();

	set_selectIndex(cipher, get_by_id("c_type"));
	$("#mbssid_gkey_rekey_time").val(rekey_time);
	$("#mbssid_psk_pass_phrase").val(psk);
    }

    function set_wpa_eap(idx)
    {
	$("#show_wpa_psk").hide();
	$("#show_wpa_eap").show();
	var reauth_period = $("#wlan0_vap"+idx+"_eap_reauth_period").val();
	var radius_server_0 = $("#wlan0_vap"+idx+"_eap_radius_server_0").val();
	var radius_server_1 = $("#wlan0_vap"+idx+"_eap_radius_server_1").val();
	var mac_auth = parseInt($("#wlan0_vap"+idx+"_eap_mac_auth").val(), 10);
	var radius0_arr = radius_server_0.split("/");
	var radius1_arr = radius_server_1.split("/");
	
	$("#mbssid_eap_reauth_period").val(reauth_period);
	$("#radius_ip1").val(radius0_arr[0]);
	$("#radius_port1").val(radius0_arr[1]);
	$("#radius_pass1").val(radius0_arr[2]);
	$("#radius_ip2").val(radius1_arr[0]);
	$("#radius_port2").val(radius1_arr[1]);
	$("#radius_pass2").val(radius1_arr[2]);

	switch(parseInt(mac_auth, 10)) {
		case 0:
			$("#radius_auth_mac1").attr("checked", false);
			$("#radius_auth_mac2").attr("checked", false);
			break;
		case 1:
			$("#radius_auth_mac1").attr("checked", true);
			$("#radius_auth_mac2").attr("checked", false);
			break;
		case 2:
			$("#radius_auth_mac1").attr("checked", false);
			$("#radius_auth_mac2").attr("checked", true);
			break;
		case 3:
			$("#radius_auth_mac1").attr("checked", true);
			$("#radius_auth_mac2").attr("checked", true);
			break;
	}
    }

    function disable_div()
    {
	$("#show_wep").hide();
	$("#show_wpa").hide();
	$("#show_wpa_psk").hide();
	$("#show_wpa_eap").hide();
    }

    function select_mbssid(obj)
    {
	var idx = parseInt(obj.options[obj.selectedIndex].value);
	var security = $("#wlan0_vap"+ idx + "_security").val();
	init_security(security, idx);
	if($("#wlan0_vap"+ idx + "_enable").val() == 0) {
		disable_all();
	} else {
		enable_all();
	}
    }

    function select_security(obj)
    {
	var idx = parseInt(obj.selectedIndex);
	var mobj = get_by_id("multi_index");
	var midx = parseInt(mobj.selectedIndex);
	var mvalue = mobj.options[midx].value;
	
	if(idx == 3 && $("#wps_enable").val() == 1) {
		/* Not support WPS, So it should not alert wps message */
		//alert(wps_disable);
	}

	disable_div();
	switch(idx) {
		case 0: //none
			//disable_div();
			break;
		case 1: //wep
			set_wep(mvalue);
			break;
		case 2: //wpa
			set_wpa(mvalue);
			break;
		case 3: //wpa_eap
			set_wpa(mvalue);
			set_wpa_eap(mvalue);
			break;
	}
    }

    function format_ssid()
    {
	for (var idx = 1; idx <= 4; idx++) {
		var ssid = $("#wlan0_vap"+ idx +"_ssid").val();
		var ssid_tmp = "";
		for (var i = 0; i < ssid.length; i++) {
			if (encodeURI(ssid.charAt(i)) === "%C2%A0") {
				ssid_tmp += decodeURI("%20");
			} else {
				ssid_tmp += ssid.charAt(i);
			}
		}
		get_by_id("wlan0_vap"+idx+"_ssid").value = ssid_tmp;
	}
    }
    function set_init_mbssid(idx)
    {
	format_ssid();
	var ssid = $("#wlan0_vap"+ idx +"_ssid").val();
	var en = parseInt($("#wlan0_vap"+ idx +"_enable").val());
	var partition = parseInt($("#wlan0_vap"+ idx + "_partition").val());
	var broadcast = parseInt($("#wlan0_vap"+ idx + "_broadcast").val());
	var route_btw_zone = parseInt($("#wlan0_vap"+ idx + "_route_btw_zone").val());

	var ssid_tmp = "";

	for (var i = 0; i < ssid.length; i++) {
		if (encodeURI(ssid.charAt(i)) === "%C2%A0") {
			ssid_tmp += decodeURI("%20");
		} else {
			ssid_tmp += ssid.charAt(i);
		}
	}
	$("#mbssid_ssid").val(ssid_tmp);

	$("#mbssid_enable").attr("checked", ((en === 0) ? false : true));
	$("#mbssid_partition").attr("checked", ((partition === 0) ? false : true));
	$("#mbssid_route_btw_zone").attr("checked", ((route_btw_zone === 0) ? false : true));

	if (broadcast == 1) {
		get_by_name("mbssid_broadcast")[0].checked = true;
		get_by_name("mbssid_broadcast")[1].checked = false;
	} else {
		get_by_name("mbssid_broadcast")[0].checked = false;
		get_by_name("mbssid_broadcast")[1].checked = true;
	}

	set_dhcprelay(idx);
	set_dhcpserver(idx);
    }
    
    function set_dhcprelay(idx)
    {
	var dhcp_relay = $("#wlan0_vap" + idx + "_relay").val();
	$("#dhcprelay").attr("checked", ((dhcp_relay === "0") ? false : true));
	$("#relay_ipaddr").val($("#wlan0_vap"+idx+"_relay_ip").val());
	if (dhcp_relay == "1") {
		$("#dhcpserver").attr('checked', false);
		$("#relay_ipaddr").show();
	}else {
		$("#relay_ipaddr").hide();
	}
    }

    function set_dhcpserver(idx)
    {
	var lan = ($("#multi_ssid_lan"+idx).val()).split(",");
	$("#lan_ipaddr").val(lan[1]);
	$("#lan_netmask").val(lan[2]);
	$("#dhcp_start").val(lan[3]);
	$("#dhcp_end").val(lan[4]);
	$("#dhcp_leasetime").val(lan[5]);
	if (lan[lan.length-1] == "0") {
		$("#dhcpserver").attr('checked', false);
	} else {
		$("#dhcpserver").attr('checked', true);
		$("#dhcp_start").attr('disabled', '');
		$("#dhcp_end").attr('disabled', '');
		$("#dhcp_leasetime").attr('disabled', '');
	}
    }

    function set_wlan_schedule(idx)
    {
	var temp_sch_0 = get_by_id("wlan0_vap" + idx + "_schedule").value;
        var temp_data_0 = temp_sch_0.split("/");
        if ((temp_sch_0 == "Always") || (temp_sch_0 == "Never") || (temp_sch_0 == "")) {
	    if (temp_sch_0 == "Always" || temp_sch_0 == "") {
		    get_by_id("mbssid_schedule_select").selectedIndex = 0;
	    } else if (temp_sch_0 == "Never") {
		    get_by_id("mbssid_schedule_select").selectedIndex = 1;
	    }
        } else {
            var temp_index_0 = get_schedule_index(temp_data_0[0]);
            get_by_id("mbssid_schedule_select").selectedIndex = temp_index_0 + 2;
        }
    }

    function init_security(security, idx)
    {
	set_init_mbssid(idx);
	var regwep = /wep/gi;
	var regwpa = /wpa/gi;
	var sec_obj = get_by_id("security_type");
	disable_div();
	if (security.match(regwep)) {
		$("#show_wep").show();
		init_wep(security, idx);
		set_selectIndex("1", sec_obj);
	} else if (security.match(regwpa)) {
		$("#show_wpa").show();
		$("#show_wpa_psk").show();
		init_wpa(security, idx);
		set_selectIndex("2", sec_obj);
		if (security.match(/eap/gi)) { 	//wpa/wpa2/wpa2auto_psk
			$("#show_wpa_eap").show();
			init_wpa_eap(idx);
			set_selectIndex("3", sec_obj);
		}
	} else {
		set_selectIndex("0", sec_obj);
	}
	
	set_wlan_schedule(idx);
    }

    function init_wep(security, idx)
    {
	var sec_arr = security.split("_");
	var type = sec_arr[1] , len = sec_arr[2];
	set_selectIndex(type, get_by_id("auth_type"));
	set_selectIndex(len === "64" ? "5" : "13" , get_by_id("wep_key_len"));
	init_wep_key(len, idx);
    }

    function init_wep_key(len, idx)
    {
	var key = $("#wlan0_vap"+idx+"_wep"+len+"_key_1").val();
	var length = parseInt(len) * 2;
	var key1 = "<input type=\"password\" id=\"key1\" name=\"key1\" maxlength=" + length + " size=\"31\" value=" + key + " >";
	$("#show_resert1").empty();
	$("#show_resert1").append(key1);
    }

    function check_wep_type(mbssid, klen, i)
    {
	if (($("#key1").val()).length == 0)
		return false;
        if (isascii(mbssid, klen, i)) {
                wep_convert(mbssid, "hex", klen, i);
	} else {
		if($("#key1").val() != "") {
			get_by_id("wlan0_"+mbssid+"_wep"+klen+"_key_"+i).value = $("#key1").val();
		}
	}
	return true;
    }

    function isascii(mbssid, klen, idx)
    {
        var key = $("#key1").val();
        if (key.length == 5 || key.length == 13) { // never start, default only use hex
		get_by_id("wlan0_"+mbssid+"_wep_display").value = "ascii";
                return true;
        } else {
		get_by_id("wlan0_"+mbssid+"_wep_display").value = "hex";
                return false;
        }
    }

    function wep_convert(mbssid, type, klen, idx)
    {
        var key = $("#key1").val();
        if (type == "hex"){
		get_by_id("wlan0_"+mbssid+"_wep"+klen+"_key_"+idx).value = a_to_hex(key);
        } else {
		get_by_id("wlan0_"+mbssid+"_wep"+klen+"_key_"+idx).value = hex_to_a(key);
	}
    }

    function init_wpa(security, idx)
    {
	set_wpa(idx);
    }

    function init_wpa_eap(idx)
    {
	set_wpa_eap(idx);
    }

    function get_mbssid_schedule(obj)
    {
        var tmp_schedule = obj.options[obj.selectedIndex].value;
        var schedule_val;
        var tmp_schedule_index = obj.selectedIndex;

        if (tmp_schedule == "Always") {
            schedule_val = "Always";
        } else if (tmp_schedule == "Never") {
            schedule_val = "Never";
        } else {
            schedule_val = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value;
        }
	var mbssid = get_by_id("multi_index");
	var idx = mbssid.options[mbssid.selectedIndex].value;
	get_by_id("wlan0_vap"+idx+"_schedule").value = schedule_val;
    }

    function send_none(idx)
    {
	get_by_id("wlan0_"+idx+"_security").value = "disable";
	return true;
    }

    function check_wep_key(klen)
    {
	var key = $("#key1").val();
	if (key == '') {
		alert(aw_wep_msg0);
		return false;
	}

	/* ascii : 5, 13, hex : 10, 26 (1~0, A-F)*/
	if (parseInt(klen, 10) == 64) {
		if (key.length != 5 && key.length != 10 ) {
			alert(bws_alert_16);
			return false;
		}
	} else {
		if ( key.length != 13 && key.length != 26) {
			alert(bws_alert_16);
			return false;
		}
	}
	
	if (key.length == 10 || key.length == 26) {
		for (var j = 0; j < key.length; j++) {
			var tmp_key = key.substring(j, j+1);
			if (!check_hex(tmp_key)){
				alert(bws_alert_16);
				return false;
			}
		}
	}
	return true;
    }

    function send_wep(idx)
    {
	var auth_tidx = $("#auth_type")[0].selectedIndex;
	var auth_type = (auth_tidx == 0) ? "open" : "share";
	var klen_idx = $("#wep_key_len")[0].selectedIndex;
	var klen = (klen_idx == 0) ? "64" : "128";
	get_by_id("wlan0_"+idx+"_security").value = "wep_" + auth_type + "_"+klen;
	get_by_id("wlan0_"+idx+"_wep_default_key").value = "1";
	if (!check_wep_key(klen))
		return false;
	if (!check_wep_type(idx, klen, 1))
		return false;
	return true;
    }

    function set_wpa_security(idx, type)
    {
	var wpa_idx = $("#wpa_mode")[0].selectedIndex;
	var wpa_mode = $("#wpa_mode")[0].options[wpa_idx].value;
	if (wpa_mode == "auto") {
		get_by_id("wlan0_"+idx+"_security").value = "wpa2auto_"+type;
	} else {
		get_by_id("wlan0_"+idx+"_security").value = wpa_mode+"_"+type;
	}
    }

    function set_cipher_type(idx)
    {
	var c_idx = $("#c_type")[0].selectedIndex;
	var c_type = $("#c_type")[0].options[c_idx].value;
	get_by_id("wlan0_"+idx+"_psk_cipher_type").value = c_type;
    }

    function send_wpa(idx)
    {
	set_wpa_security(idx, "psk");
	set_cipher_type(idx);
	//maybe we should check rekey or pass_phrase is or not equal to null
	var rekey = $("#mbssid_gkey_rekey_time").val();
	var psk = $("#mbssid_psk_pass_phrase").val();

	if (rekey.length == 0 || psk.length < 8 || psk.length > 64) {
		alert(INVALID_PRESHARED_KEY);
		return false;
	}

	if (psk.length == 64) {
		for (var j = 0; j < psk.length; j++) {
			var tmp_key = psk.substring(j, j+1);
			if (!check_hex(tmp_key)){
				alert(GW_WLAN_WPA_PSK_HEX_STRING_INVALID);
				return false;
			}
		}
	}

	get_by_id("wlan0_"+idx+"_gkey_rekey_time").value = rekey;
	get_by_id("wlan0_"+idx+"_psk_pass_phrase").value = psk;
	return true;
    }

    function set_radius(idx, s)
    {
	var ip = $("#radius_ip"+s).val();
	var port = $("#radius_port"+s).val();
	var pass = $("#radius_pass"+s).val();

	if (ip.length == 0 || port.length == 0 || port < 0 || port > 65535)
		return false;
	if (ip === "0.0.0.0") { // not to check by default value
		get_by_id("wlan0_"+idx+"_eap_radius_server_"+(parseInt(s)-1)).value = "0.0.0.0/1812/123";
		return true;
	}

	var ra_ip = new addr_obj(ip.split("."), ip_addr_msg, false, false);

	if (!check_address(ra_ip))
		return false;

	get_by_id("wlan0_"+idx+"_eap_radius_server_"+(parseInt(s)-1)).value = ip+"/"+port+"/"+pass;
	return true;
    }

    function send_wpa_eap(idx)
    {
	set_wpa_security(idx, "eap");
	set_cipher_type(idx);
	var mac_auth = 0;
	var auth_mac1 = $("#radius_auth_mac1").attr("checked");
	var auth_mac2 = $("#radius_auth_mac2").attr("checked");
	var rekey = $("#mbssid_gkey_rekey_time").val();

	if (rekey.length == 0)
		return false;

	get_by_id("wlan0_"+idx+"_gkey_rekey_time").value = rekey;

	if (!set_radius(idx, 1) || !set_radius(idx, 2))
		return false;

	if (auth_mac1 == false && auth_mac2 == false)
		mac_auth = 0;
	else if (auth_mac1 == true && auth_mac2 == false)
		mac_auth = 1;
	else if (auth_mac1 == false && auth_mac2 == true)
		mac_auth = 2;
	else
		mac_auth = 3;

	get_by_id("wlan0_"+idx+"_eap_mac_auth").value = mac_auth;
	return true;
    }

    function check_security(security_idx, idx)
    {
	var ret = true;
	switch(parseInt(security_idx)) {
	  case 0: ret = send_none(idx); break;
	  case 1: ret = send_wep(idx); break;
	  case 2: ret = send_wpa(idx); break;
	  case 3: ret = send_wpa_eap(idx); break;
	}
	return ret;
    }

    function chk_ip_addr(ip)
    {
	if (ip == "") {
		alert(INVALID_IP);
		return false;
	}
	return true;
    }

    function chk_submask(mask)
    {
	var mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	if (mask == "") {
		alert(LS202);
		return false;
	}
	if (!check_mask(mask_obj)) {
		return false;
	}
	return true;
    }

    function reset_iface()
    {
	var athx=1;
	for (var i = 1; i < 5; i++) {
		var mbssid_arr = (get_by_id("multi_ssid_lan"+i).value).split(",");
		if (get_by_id("wlan0_vap"+i+"_enable").value == "1") {
			get_by_id("multi_ssid_lan"+i).value = "ath"+athx+",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[1] + ",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[2] + ",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[3] + ",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[4] + ",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[5] + ",";
			get_by_id("multi_ssid_lan"+i).value += mbssid_arr[6];
			athx+=1;
		}
	}
    }

    function chk_dhcpserver_and_relay(mbssid_idx)
    {
	var i = $("#multi_index")[0].options[mbssid_idx].value;
	var ip = $("#lan_ipaddr").val();
	var submask = $("#lan_netmask").val();
	var ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var mask_obj = new addr_obj(submask.split("."), subnet_mask_msg, false, false);

	if (!chk_ip_addr(ip) || !chk_submask(submask)) {
		return false;
	}
	if (!check_address(ip_obj, mask_obj)) {
		return false;
	}

	if ($("#dhcpserver").attr('checked')) {
		var ip_arr = ip.split(".");
		var start_ip = $("#dhcp_start").val();
		var end_ip = $("#dhcp_end").val();
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg, TEXT035);
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg, TEXT036);
		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
		var dhcp_less = $("#dhcp_leasetime").val();
		if (!check_address(ip_obj, mask_obj)) {
			return false;
		}
                //check dhcp ip range equal to lan-ip or not?
                if(!check_LAN_ip(ip_obj.addr, start_obj.addr, TEXT035)){
                        return false;
                }
                if(!check_LAN_ip(ip_obj.addr, end_obj.addr, TEXT036)){
                        return false;
                }
                //check dhcp ip range and lan ip the same mask or not?
                if (!check_address(start_obj, mask_obj, ip_obj) || !check_address(end_obj, mask_obj, ip_obj)){
                        return false;
                }
                if (!check_domain(ip_obj, mask_obj, start_obj)){
                        alert(TEXT037);
                        return false;
                }
                if (!check_domain(ip_obj, mask_obj, end_obj)){
			alert(TEXT038);
                        return false;
                }
                if (!check_ip_order(start_obj, end_obj)){
                        alert(TEXT039);
                        return false;
                }

                if (check_lanip_order(ip_obj, start_obj, end_obj)){
                        alert(network_dhcp_ip_in_server);
                        return false;
                }

                var less_msg = replace_msg(check_num_msg, bd_DLT, 1, 999999);
                var temp_less = new varible_obj(dhcp_less, less_msg, 1, 999999, false);
                if (!check_varible(temp_less)){
                        return false;
                }
		var tmp_idx = 0;
		var athx = "ath";
		get_by_id("multi_ssid_lan"+i).value = athx + "," + ip + "," + submask + ",";
		get_by_id("multi_ssid_lan"+i).value += start_ip+ "," + end_ip + ",";
		get_by_id("multi_ssid_lan"+i).value += $("#dhcp_leasetime").val() + ",1";
		reset_iface();
	} else {
		var multi_value = get_by_id("multi_ssid_lan"+i).value;
		var multi_arr = multi_value.split(",");
		get_by_id("multi_ssid_lan"+i).value = multi_arr[0]+","+ip+","+submask+","+multi_arr[3]+","+multi_arr[4]+","+multi_arr[5]+",0";
	}

	if ($("#dhcprelay").attr('checked')) {
		var relay_ip = get_by_id("relay_ipaddr").value;
		var relay_ip_addr_msg = replace_msg(all_ip_addr_msg, bln_DHCPRelay_IP);
		var temp_relay_ip_obj = new addr_obj(relay_ip.split("."), relay_ip_addr_msg, false, false);

		if (!check_address(temp_relay_ip_obj)){
                        return false;
                }
		
		get_by_id("wlan0_vap"+i+"_relay_ip").value = relay_ip;
		get_by_id("wlan0_vap"+i+"_relay").value = "1";
		var multi_value = get_by_id("multi_ssid_lan"+i).value;
		var multi_arr = multi_value.split(",");
		get_by_id("multi_ssid_lan"+i).value = multi_arr[0]+","+multi_arr[1]+","+multi_arr[2]+","+multi_arr[3]+","+multi_arr[4]+","+multi_arr[5]+",0";
	} else {
		get_by_id("wlan0_vap"+i+"_relay").value = "0";
	}
	return true;
    }

        function toPrefix (bit, padchar, deflen) {
                if (bit.length >= parseInt(deflen))
                        return (bit);
                var out = bit
                for (var cnt = bit.length; cnt < parseInt(deflen); cnt++) {
                        out = padchar + out;
                }
                return (out);
        }
        
        function toConvert_IPAddr(num){
                var base = 2;
                var tmp = parseInt(num);
                var bitNum = tmp.toString(base);
                bitNum = toPrefix(bitNum, "0", 8);
                return bitNum;
        }
         
        function match_Ip_Mask(bit1, bit2){
                var res = "";

                for(var i = 0; i < bit1.length; i++)
                        res += (bit1.charAt(i) & bit2.charAt(i));
                return res;
        }

        function toConvertBit(ipaddr){
                var ip_obj = ipaddr.split(".");
                var ip_bit = "";
                
                for(var i = 0; i < 4; i++){
                        ip_bit += toConvert_IPAddr(ip_obj[i]) 
                }
                return ip_bit;
        }
        
	function toDetect_cover(idx)
	{
		var lan_ip_bits = toConvertBit("<!--# echo lan_ipaddr -->");
		var lan_mask_bits = toConvertBit("<!--# echo lan_netmask -->");
		var lan_bits = match_Ip_Mask(lan_ip_bits, lan_mask_bits);

		var tmp_ip_arr = new Array();
		var cur_idx = parseInt((idx.split('vap'))[1]);
		var cur_ip_bits = toConvertBit($("#lan_ipaddr").val());
		var cur_mask_bits = toConvertBit($("#lan_netmask").val());
		var cur_bits = match_Ip_Mask(cur_ip_bits, cur_mask_bits);
		tmp_ip_arr.push(lan_bits);
		for (var i = 1; i < 5; i++) {
			var en = $("#wlan0_vap"+i+"_enable").val();
			if  (cur_idx != i && en  === "1") {
				var multi_lan = ($("#multi_ssid_lan"+i).val()).split(",");
				tmp_ip_arr.push(match_Ip_Mask(toConvertBit(multi_lan[1]), toConvertBit(multi_lan[2])));
			}
		}
		for (var i = 0; i < tmp_ip_arr.length; i++) {
			var tmp = tmp_ip_arr.pop();
			if (tmp === cur_bits) { 
				$("#lan_ipaddr").focus().blur();
				return false;
			}
		}
		return true;
	}

    function send_request()
    {
	var mbssid_idx = $("#multi_index")[0].selectedIndex; /* index */
	var vidx = "vap"+$("#multi_index")[0].options[mbssid_idx].value;
	
	$("#wlan0_"+vidx+"_enable").val($("#mbssid_enable").attr('checked') == true ? "1" : "0");
	$("#wlan0_"+vidx+"_ssid").val($("#mbssid_ssid").val()); // set ssid to test, remeber to process special character
	$("#wlan0_"+vidx+"_partition").val($("#mbssid_partition").attr('checked') == true ? "1" : "0");
	$("#wlan0_"+vidx+"_route_btw_zone").val($("#mbssid_route_btw_zone").attr('checked') == true ? "1" : "0");
	$("#wlan0_"+vidx+"_guest_zone").val($("#wlan0_"+vidx+"_route_btw_zone").val());

	if (!toDetect_cover(vidx)) {
		alert(COVER_WARR);
		return false;
	}
	
	if ($("#dhcprelay").attr('checked')) {
		//get_by_id("dhcp_relay_ip").value = get_by_id("relay_ipaddr").value;
		get_by_id("wlan0_"+vidx+"_relay_ip").value = get_by_id("relay_ipaddr").value;
		get_by_id("wlan0_"+vidx+"_relay").value = "1";
	} else {
		get_by_id("wlan0_"+vidx+"_relay").value = "0";
	}
	get_mbssid_schedule(get_by_id("mbssid_schedule_select"));
	if (get_by_name("mbssid_broadcast")[0].checked) {
		$("#wlan0_"+vidx+"_broadcast").val("1");
	} else {
		$("#wlan0_"+vidx+"_broadcast").val("0");
	}

	var sec_idx = $("#security_type")[0].selectedIndex;
	var sec_value = $("#security_type")[0].options[sec_idx].value;

	if(sec_value == 3 && $("#wps_enable").val() == 1) {
			$("#wps_enable").val(0);
/*
		if(confirm(wps_disable)) {
			$("#wps_enable").val(0);
		} else {
			return false
		}
*/
	}

	if (!check_security(sec_value, vidx)) {
		return false;
	}
	if (!chk_dhcpserver_and_relay(mbssid_idx)) {
		return false;
	}

        //save wireless network setting
        get_by_id("wlan0_enable").value = get_checked_value(get_by_id("w_enable"));
        get_by_id("wlan0_auto_channel_enable").value = get_checked_value(get_by_id("auto_channel"));
        get_by_id("wlan0_channel").value = get_by_id("sel_wlan0_channel").value;
        get_by_id("wlan0_dot11_mode").value = get_by_id("dot11_mode").value;
        get_by_id("wlan0_11n_protection").value = get_by_id("11n_protection").value;
        get_by_id("wlan0_11b_txrate").value = get_by_id("11b_txrate").value;
        get_by_id("wlan0_11g_txrate").value = get_by_id("11g_txrate").value;
        get_by_id("wlan0_11n_txrate").value = get_by_id("11n_txrate").value;
        get_by_id("wlan0_11bg_txrate").value = get_by_id("11bg_txrate").value;
        get_by_id("wlan0_11gn_txrate").value = get_by_id("11gn_txrate").value;
        get_by_id("wlan0_11bgn_txrate").value = get_by_id("11bgn_txrate").value;
        get_by_id("wlan0_txpower").value = get_by_id("wlan_txpower")[get_by_id("wlan_txpower").selectedIndex].value;

	if (submit_button_flag == 0) {
		submit_button_flag = 1;
		return true;
	} else 
		return false;
    }


    function edit_row(i)
    {
	if (get_by_id("w_enable").checked) {
		var security = $("#wlan0_vap"+ i + "_security").val();
		get_by_id("multi_index").selectedIndex = i-1;
		init_security(security, i);
		set_dhcprelay(i);
		enable_all();
	}
    }

    function del_row(i)
    {
	if (get_by_id("w_enable").checked) {
	  if (confirm(YM25+" Multi-SSID"+i)) {
		get_by_id("wlan0_vap"+i+"_enable").value = "0";
		get_by_id("wlan0_vap"+i+"_guest_zone").value = "0";
		get_by_id("wlan0_vap"+i+"_ssid").value = "dlink_guest_"+i;
		get_by_id("wlan0_vap"+i+"_security").value = "disable";
		get_by_id("wlan0_vap"+i+"_wep_display").value = "hex";
		get_by_id("wlan0_vap"+i+"_wep64_key_1").value = "0000000000";
		get_by_id("wlan0_vap"+i+"_wep64_key_2").value = "0000000000";
		get_by_id("wlan0_vap"+i+"_wep64_key_3").value = "0000000000";
		get_by_id("wlan0_vap"+i+"_wep64_key_4").value = "0000000000";
		get_by_id("wlan0_vap"+i+"_wep128_key_1").value = "00000000000000000000000000";
		get_by_id("wlan0_vap"+i+"_wep128_key_2").value = "00000000000000000000000000";
		get_by_id("wlan0_vap"+i+"_wep128_key_3").value = "00000000000000000000000000";
		get_by_id("wlan0_vap"+i+"_wep128_key_4").value = "00000000000000000000000000";
		get_by_id("wlan0_vap"+i+"_wep_default_key").value = "1";
		get_by_id("wlan0_vap"+i+"_psk_pass_phrase").value = "1234567890";
		get_by_id("wlan0_vap"+i+"_psk_cipher_type").value = "both";
		get_by_id("wlan0_vap"+i+"_eap_radius_server_0").value = "0.0.0.0/1812/123";
		get_by_id("wlan0_vap"+i+"_eap_mac_auth").value = "3";
		get_by_id("wlan0_vap"+i+"_eap_radius_server_1").value = "0.0.0.0/1812/123";
		get_by_id("wlan0_vap"+i+"_gkey_rekey_time").value = "3600";
		get_by_id("wlan0_vap"+i+"_schedule").value = "";
		get_by_id("wlan0_vap"+i+"_eap_reauth_period").value = "60";
		get_by_id("wlan0_vap"+i+"_broadcast").value = "1";
		get_by_id("wlan0_vap"+i+"_partition").value = "1";
		get_by_id("wlan0_vap"+i+"_route_btw_zone").value = "1";
		send_submit("form1");
	  }
	}
    }

    function show_vap_table()
    {
	var table_info = "<table cellspacing=\"1\" cellpadding=\"2\" width=\"525\" border=\"0\" style=\"border-style:double\">";
	table_info += "<tr id=\"box_header\">";
        table_info += "<TD><b>" + _index + "</b></TD>";
        table_info += "<TD><b>"+ sd_NNSSID + "</b></TD>";
        table_info += "<TD><b>"+ bws_SM + "</b></TD>";
        table_info += "<TD><b>"+_ipaddr + "</b></TD>";
        table_info += "<TD>&nbsp;</TD>";
        table_info += "<TD>&nbsp;</TD>";
        table_info += "</tr>";
	for (var i = 1; i < 5; i++) {
		if ($("#wlan0_vap"+i+"_enable").val() == 1) {
			var col = "", sec = "";
			var security = $("#wlan0_vap"+i+"_security").val();
			var ip = ($("#multi_ssid_lan"+i).val()).split(",");
			if (security.match(/wep/gi)) {
				sec = _WEP;
			} else if (security.match(/psk/gi)) {
				sec = _WPApersonal;
			} else if (security.match(/eap/gi)) {
				sec = _WPAenterprise;
			} else {
				sec = _none;
			}
			col = "<tr id=box_header style=border-style:double><td>Multi-SSID"+i+"</td>";
			col += "<td>"+$("#wlan0_vap"+i+"_ssid").val()+"</td>";
			col += "<td>"+ sec + "</td>";
			if (ip[1].length != 0 && $("dhcp_relay").val() == "1")
				col += "<td>"+ip[1]+"</td>";
			else
				col += "<td>"+_none+"</td>";
			col += "<td><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></td>";
                        col += "<td><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"delete\"></a></td>";
			col += "</tr>";
			table_info += col;
		}
	}
	table_info += "</table>";
	$("#show_table").append(table_info);
    }
    onPageLoad();
    show_vap_table();
</script>

</body>
</html>
