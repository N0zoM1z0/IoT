<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript"> 
var submit_button_flag = 0;
var radius_button_flag = 0;
	function set_cipher_option (obj) {
		//var idx = get_by_id("dot11_mode").selectedIndex;
		var wpa_idx = get_by_id("wpa_mode").selectedIndex;
		var cipher_text = new Array();
		var cipher_value = new Array();
		switch(wpa_idx) {
			case 0:
				cipher_text[0] = "TKIP";
				cipher_value[0] = "tkip";
				break;
			case 1:
				cipher_text[0] = "AES";
				cipher_value[0] = "aes";
				break;
			case 2:
				cipher_text[0] = "AES or TKIP";
				cipher_value[0] = "both";
				break;
		}

		for (var i = 0; i < 3; i++)obj.options[i] = null;
		
		for (var i = 0; cipher_text[i]; i++) {
			var _option = document.createElement('option');
			_option.text = cipher_text[i];
            _option.value = cipher_value[i];
            obj.options[i] = _option;
        }
		obj.disabled = true;
	}

	function set_wpa_option (obj) {
		var idx = get_by_id("dot11_mode").selectedIndex; 
		var wpa_text = new Array('WPA only', 'WPA2 only', 'Auto (WPA or WPA2)');
		var wpa_value = new Array('wpa' , 'wpa2', 'auto');

		for (var i = 0; i < 3; i++)obj.options[i] = null;

		for (var i = 0; wpa_text[i]; i++) {
			var _option = document.createElement('option');
            _option.text = wpa_text[i];
            _option.value = wpa_value[i];
            obj.options[i] = _option;
    	}
    }

	function onPageLoad(){
		set_checked("<!--# echo wps_enable -->", get_by_id("wpsEnable"));

		set_checked(get_by_id("wlan1_enable").value, get_by_id("w_enable"));
		get_by_id("show_ssid").value = get_by_id("wlan1_ssid").value;
		set_checked(get_by_id("wlan1_auto_channel_enable").value, get_by_id("auto_channel"));
		set_checked("<!--# echo wlan1_ssid_broadcast -->", get_by_name("wlan1_ssid_broadcast"));
		get_by_id("sel_wlan1_channel").disabled = true;
		set_selectIndex("<!--# echo wlan1_dot11_mode -->", get_by_id("dot11_mode"));
		//set_selectIndex("<!--# echo wlan1_channel_bandwidth -->", get_by_id("11n_protection"));
		
 	        var temp_sch_0 = get_by_id("wlan1_schedule").value;
		var temp_data_0 = temp_sch_0.split("/");	
	  	//2009/4/20 Tina modify:Fixed schedule can't selected.
		if((temp_sch_0 == "Always") || (temp_sch_0 == "Never") || (temp_sch_0 == "")){
   			set_selectIndex(temp_data_0[0], get_by_id("wlan1_schedule_select"));
   		}else{
     			var temp_index_0 = get_schedule_index(temp_data_0[0]);
	      		get_by_id("wlan1_schedule_select").selectedIndex=temp_index_0+2;
     	}
		
	    var wlan1_psk_cipher_type= "<!--# echo wlan1_psk_cipher_type -->";
		var temp_r0 = get_by_id("wlan1_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		if(Dr0.length > 1){
			get_by_id("radius_ip1").value=Dr0[0];
			get_by_id("radius_port1").value=Dr0[1];
			get_by_id("radius_pass1").value=Dr0[2];
		}
		
		var temp_r1 = get_by_id("wlan1_eap_radius_server_1").value;
		var Dr1 = temp_r1.split("/");
		if(Dr1.length > 1){
			get_by_id("radius_ip2").value=Dr1[0];
			get_by_id("radius_port2").value=Dr1[1];
			get_by_id("radius_pass2").value=Dr1[2];
		}
		
		var wlan1_eap_mac_auth = get_by_id("wlan1_eap_mac_auth").value;
		if(wlan1_eap_mac_auth == 0){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan1_eap_mac_auth == 1){
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan1_eap_mac_auth == 2){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = true;
		}else{
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = true;
		}
		
		set_selectIndex(get_by_id("wlan1_wep_default_key").value, get_by_id("wep_def_key"));

		var wlan1_security= "<!--# echo wlan1_security -->";
		var security = wlan1_security.split("_");
		
		//show_chan_width();
		//disable_wireless();
		set_selectIndex("<!--# echo wlan1_channel_bandwidth -->", get_by_id("11n_protection"));
		if(wlan1_security == "disable"){				//Disabled
			set_selectIndex(0, get_by_id("wep_type"));
		}else if(security[0] == "wep"){					//WEP
			get_by_id("show_wep").style.display = "";
			set_selectIndex(1, get_by_id("wep_type"));
			set_selectIndex(security[1], get_by_id("auth_type"));
			if(security[2] == "64"){
				set_selectIndex(5, get_by_id("wep_key_len"));
			}else{
				set_selectIndex(13, get_by_id("wep_key_len"));
			}
		}else{
			if(security[1] == "psk"){					//PSK
			    get_by_id("show_wpa_psk").style.display = "";
				set_selectIndex(2, get_by_id("wep_type"));
			}else if(security[1] == "eap"){				//EAP
			    get_by_id("show_wpa_eap").style.display = "";
				set_selectIndex(3, get_by_id("wep_type"));
			}
			//set wpa_mode
			if(security[0] == "wpa2auto"){
				get_by_id("show_wpa").style.display = "";	
				set_selectIndex("auto", get_by_id("wpa_mode"));
			}else{
				set_selectIndex(security[0], get_by_id("wpa_mode"));
				get_by_id("show_wpa").style.display = "";	
			}
		}

		set_cipher_option(get_by_id("c_type"));
		change_wep_key_fun();
		show_buttons();
		//disable_channel();
		set_selectIndex("<!--# echo wlan1_psk_cipher_type -->",get_by_id("c_type"));
		 var login_who= checksessionStorage();
                if(login_who== "user"){
                        DisableEnableForm(document.form1,true);
                }else{
                        disable_wireless();
                        disable_channel();
                        show_chan_width();
                }
                set_form_default_values("form1");
	}

	function change_wep_key_fun(){
		var length = parseInt(get_by_id("wep_key_len").value) * 2;
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var key_type = get_by_id("wlan1_wep_display").value;
		var key1 = get_by_id("wlan1_wep" + key_num_array[key_length] + "_key_1").value;
		var key2 = get_by_id("wlan1_wep" + key_num_array[key_length] + "_key_2").value;
		var key3 = get_by_id("wlan1_wep" + key_num_array[key_length] + "_key_3").value;
		var key4 = get_by_id("wlan1_wep" + key_num_array[key_length] + "_key_4").value;
		
		get_by_id("show_resert1").innerHTML = "<input type=\"password\" id=\"key1\" name=\"key1\" maxlength=" + length + " size=\"31\" value=" + key1 + " >"
		get_by_id("show_resert2").innerHTML = "<input type=\"password\" id=\"key2\" name=\"key2\" maxlength=" + length + " size=\"31\" value=" + key2 + " >"
		get_by_id("show_resert3").innerHTML = "<input type=\"password\" id=\"key3\" name=\"key3\" maxlength=" + length + " size=\"31\" value=" + key3 + " >"
		get_by_id("show_resert4").innerHTML = "<input type=\"password\" id=\"key4\" name=\"key4\" maxlength=" + length + " size=\"31\" value=" + key4 + " >"		
	}

    function check_8021x(){
    	var ip1 = get_by_id("radius_ip1").value;
    	var ip2 = get_by_id("radius_ip2").value;
        
        var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
        
        var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
        var temp_radius1 = new raidus_obj(temp_ip1, get_by_id("radius_port1").value, get_by_id("radius_pass1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, get_by_id("radius_port2").value, get_by_id("radius_pass2").value);
        
        if (!check_radius(temp_radius1)){
    		return false;        	               
    	}else if (ip2 != "" && ip2 != "0.0.0.0"){
    		if (!check_radius(temp_radius2)){
    			return false;        	               
    		}
    	}	
    	return true;	    
    }
	    
    function check_psk(){
		var psk_value = get_by_id("wlan1_psk_pass_phrase").value;
		if (psk_value.length < 8){                   
			alert(PSK_ERROR);
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(PSK_ERROR_1);
				return false;
			}
        }
        return true;         
    }
   
	function check_wep() {
		var wps_status = get_by_id("wpsEnable").checked;
		var widx = get_by_id("wep_type").selectedIndex;
		if (wps_status && widx == 1){
			alert("When WPS Enable, Wireless Security mode can't set wep.");
			return false;
		}
		return true;
	}

	function show_wpa_wep(){			
		var wep_type = get_by_id("wep_type").value;	
		
		get_by_id("show_wep").style.display = "none";
		get_by_id("show_wpa").style.display = "none";	
		get_by_id("show_wpa_psk").style.display = "none";
	    	get_by_id("show_wpa_eap").style.display = "none";
			
		if (wep_type == 1){			//WEP
			get_by_id("show_wep").style.display = "";
		}else if(wep_type == 2){	//WPA-Personal
			if (check_wps_psk_eap()){
				get_by_id("show_wpa").style.display = "";	
				get_by_id("show_wpa_psk").style.display = "";	
			}
		}else if(wep_type == 3){	//WPA-Enterprise
			if(check_wps_psk_eap()){
				get_by_id("show_wpa").style.display = "";	
				get_by_id("show_wpa_eap").style.display = "";
			}
    		}
		set_wpa_option(get_by_id("wpa_mode"));
		set_cipher_option(get_by_id("c_type"));
	}

       function show_chan_width(){
 		var mode = get_by_id("dot11_mode").selectedIndex;	
		
		switch(mode){
		case 0: /* 802.11a only */
			get_by_id("show_channel_width").style.display = "none";
			get_by_id("11n_protection").value ="20";
			break;
		default:
			get_by_id("show_channel_width").style.display = "";
			break;	
		}
		show_wpa_wep();
       }

	function disable_channel(){		
		if(get_by_id("w_enable").checked)
		get_by_id("sel_wlan1_channel").disabled = get_by_id("auto_channel").checked;
	}

	function disable_wireless(){
		var is_display = "";
		get_by_id("auto_channel").disabled = !get_by_id("w_enable").checked;
		get_by_id("show_ssid").disabled = !get_by_id("w_enable").checked;
		get_by_id("dot11_mode").disabled = !get_by_id("w_enable").checked;
		get_by_id("sel_wlan1_channel").disabled = !get_by_id("w_enable").checked;
		get_by_id("11n_protection").disabled = !get_by_id("w_enable").checked;
		get_by_name("wlan1_ssid_broadcast")[0].disabled = !get_by_id("w_enable").checked;
		get_by_name("wlan1_ssid_broadcast")[1].disabled = !get_by_id("w_enable").checked;
		get_by_id("add_new_schedule").disabled = !get_by_id("w_enable").checked;
		get_by_id("wlan1_schedule_select").disabled = !get_by_id("w_enable").checked;
		disable_channel();
		if(!get_by_id("w_enable").checked){
			get_by_id("wpsEnable").checked = false;
			show_buttons();
			get_by_id("show_security").style.display = "none";
			get_by_id("show_wep").style.display = "none";;
			get_by_id("show_wpa").style.display = "none";;	
			get_by_id("show_wpa_psk").style.display = "none";;
			get_by_id("show_wpa_eap").style.display = "none";;		
		}else{
			get_by_id("show_security").style.display = "";
			show_wpa_wep();
		}
	}

	function show_radius(){
		get_by_id("radius2").style.display = "none";
		get_by_id("none_radius2").style.display = "none";
		get_by_id("show_radius2").style.display = "none";
		if(radius_button_flag){
			get_by_id("radius2").style.display = "";
			radius_button_flag = 0;
		}else{
			get_by_id("none_radius2").style.display = "";
			get_by_id("show_radius2").style.display = "";
			radius_button_flag = 1;
		}
	}

	function send_key_value(key_length){
		var key_type = get_by_id("wlan1_wep_display").value;

		for(var i = 1; i < 5; i++){
			get_by_id("wlan1_wep" + key_length + "_key_" + i).value = get_by_id("key" + i).value;
		}
		
		get_by_id("asp_temp_37").value = get_by_id("wlan1_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_38").value = get_by_id("wlan1_wep"+ key_length +"_key_2").value;
		get_by_id("asp_temp_39").value = get_by_id("wlan1_wep"+ key_length +"_key_3").value;
		get_by_id("asp_temp_40").value = get_by_id("wlan1_wep"+ key_length +"_key_4").value;
	}
	
	function send_cipher_value(){
		var cIdx = get_by_id("c_type").selectedIndex;
		get_by_id("wlan1_psk_cipher_type").value = get_by_id("c_type").options[cIdx].value;
	}

   	function check_HT_with_TKIP() {
		var idx = get_by_id("dot11_mode").selectedIndex;
		var wpa_idx = get_by_id("wpa_mode").selectedIndex;
		var cipher_idx = get_by_id("c_type").selectedIndex;
		var dot11_text = get_by_id("dot11_mode")[idx].text;
		var cipher_text = get_by_id("c_type")[cipher_idx].value;

 		switch(idx) {
			case 0: /* 802.11a */
				return false;
			case 1: /* 802.11n */
			case 2: /* Mixed 802.11a and 802.11n */
				if (wpa_idx == 0 && cipher_text == "tkip") { /* WPA-TKIP*/
					alert( dot11_text + ' cannot support WPA-TKIP');
					return true;
				} else {
					break;
				}
		}
		return false;
	}

	function send_request(){				

		if(!check_wep()){
			return false;
		}

		if (!is_form_modified("form1") && get_by_id("wlan0_radio_mode").value == "1" && !confirm(LS3)) {
			return false;
		}
		var wlan0_op_mode = get_by_id("wlan0_op_mode").value;
		var wlan_ssid = get_by_id("show_ssid").value
		var wep_type_value = get_by_id("wep_type").value;
		var key_length =get_by_id("wep_key_len").selectedIndex;

		var rekey_msg = replace_msg(check_num_msg, "Group Key Update Interval", 30, 65535);
		var temp_rekey = new varible_obj(get_by_id("wlan1_gkey_rekey_time").value, rekey_msg, 30, 65535, false);
		var dot11_mode_value = get_by_id("dot11_mode").value;
		var c_type_value = get_by_id("c_type").value;
		
		if(!(check_ssid("show_ssid"))){
				return false;
		}

		if(!(ischeck_wps("auto"))){
				return false;
		}

		if(wep_type_value == 1){		//WEP
			if (dot11_mode_value == "11n"){
				alert("802.11n only can't support WEP.");
				return false;
			}else{
				if(!check_5g_key()){
					return false;
				}
			}
		}else if(wep_type_value == 2){	//PSK
			if (check_HT_with_TKIP()) {
				return false;
			}else{
				if (!check_varible(temp_rekey)){
					return false;
				}
				if(!check_psk()){
					return false;
				}
			}
		}else if(wep_type_value == 3){	//EAP
			if (!check_varible(temp_rekey)){
				return false;
			}
			if(!check_8021x()){
				return false;
			}
		}
		
		//save wireless network setting
		get_by_id("wlan1_enable").value = get_checked_value(get_by_id("w_enable"));
		get_by_id("wlan0_enable").value = get_checked_value(get_by_id("w_enable"));
		get_by_id("wlan1_auto_channel_enable").value = get_checked_value(get_by_id("auto_channel"));
		get_by_id("wlan1_channel").value = get_by_id("sel_wlan1_channel").value;
		get_by_id("wlan1_dot11_mode").value = get_by_id("dot11_mode").value;
		//get_by_id("wlan1_11n_protection").value = get_by_id("11n_protection").value;
		get_by_id("wlan1_channel_bandwidth").value = get_by_id("11n_protection").value;
						
		get_by_id("wlan1_wep_default_key").value = get_by_id("wep_def_key").value;
		var wpa_mode = get_by_id("wpa_mode").value;

		//save security
		if(wep_type_value == 1){			//WEP
			get_by_id("wlan1_security").value = "wep_"+ get_by_id("auth_type").value +"_"+ key_num_array[key_length];
			//save wep key
			send_key_value(key_num_array[key_length]);
		}else if(wep_type_value == 2){		//PSK
			if(wpa_mode == "auto"){
				get_by_id("wlan1_security").value = "wpa2auto_psk";
			}else{
				get_by_id("wlan1_security").value = wpa_mode + "_psk";
			}
			send_cipher_value();
			//save psk value
			get_by_id("asp_temp_37").value = get_by_id("wlan1_psk_pass_phrase").value;
		}else if(wep_type_value == 3){		//EAP
			if(wpa_mode == "auto"){
				get_by_id("wlan1_security").value = "wpa2auto_eap";
			}else{
				get_by_id("wlan1_security").value = wpa_mode + "_eap";
			}
			send_cipher_value();
			//save radius server
			var r_ip_0 = get_by_id("radius_ip1").value;
			var r_port_0 = get_by_id("radius_port1").value;
			var r_pass_0 = get_by_id("radius_pass1").value;
			var dat0 =r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
			get_by_id("wlan1_eap_radius_server_0").value = dat0;
			
			if(radius_button_flag){
				var r_ip_1 = get_by_id("radius_ip2").value;
				var r_port_1 = get_by_id("radius_port2").value;
				var r_pass_1 = get_by_id("radius_pass2").value;
				var dat1 =r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
				get_by_id("wlan1_eap_radius_server_1").value = dat1;
			}

			if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = false))
				get_by_id("wlan1_eap_mac_auth").value = 0;
			else if((get_by_id("radius_auth_mac1").checked == true) && (get_by_id("radius_auth_mac2").checked = false))
				get_by_id("wlan1_eap_mac_auth").value = 1;
			else if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = true))
				get_by_id("wlan1_eap_mac_auth").value = 2;
			else
				get_by_id("wlan1_eap_mac_auth").value = 3;

		}else{								//DISABLED
			get_by_id("wlan1_security").value = "disable";
		}
		
		//save Wi-Fi value		
		if(get_by_id("wps_enable").value != get_checked_value(get_by_id("wpsEnable"))){
		get_by_id("wps_enable").value = get_checked_value(get_by_id("wpsEnable"));
			get_by_id("reboot_type").value = "wlanapp";
		}
		//save wps_configured_mode
		//when just chainge wps pin value don't modify the configured mode.
		if (is_wps_modified()){
			get_by_id("wps_configured_mode").value = 5; /* 5: wps configured */
		} else {
			get_by_id("wps_configured_mode").value = 1; /* 1: wps unconfigured */
		}
		
		//get_by_id("wps_configured_mode").value = 5;	//save wps_configured_mode when setting wireless
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("wlan1_ssid").value = get_by_id("show_ssid").value;
			get_by_id("wlan0_radio_mode").value = "1";
			//get_by_id("wlan0_enable").value = "0";
			return true;
		}else{
			return false;
		}
	}

	function is_wps_modified(){ //check wps change or not, false:not change, true:change
		if((get_by_id("wps_enable").value == "<!--# echo wps_enable -->") && 
//		   (get_by_id("wps_pin").value == "<!--# echo wps_pin -->")){
		   (get_by_id("show_ssid").value != "dlink_media" || get_by_id("wep_type").value != "0")) { 
			return true;
		}else{
			return false;
		}
	}

	function set_channel(){
		var channel_list = "<!--# echo wlan1_channel_list -->";
		//var channel_list = "<!--# echo wlan1_channel_list -->";
		var current_channel = "<!--# echo wlan1_channel -->";
		var ch = channel_list.split(",");
		var ch_text = new Array("5.180","5.200","5.220","5.240",/*"5.260","5.280","5.300","5.320",*/"5.745","5.765","5.785","5.805","5.825");
		var obj = get_by_id("sel_wlan1_channel");
		var count = 0;
		
		for (var i = 0; i < ch.length; i++){			
			var ooption = document.createElement("option");						
			ooption.text = ch_text[i] + " GHz - CH " + ch[i];
			ooption.value = ch[i];				
			obj.options[count++] = ooption;
								
			if (ch[i] == current_channel){
				ooption.selected = true;
			}        		
		}
	}


var txrate_11n = new Array('MCS 15 - 130 [270]', 'MCS 14 - 117 [243]', 'MCS 13 - 104 [216]', 'MCS 12 - 78 [162]', 'MCS 11 - 52 [108]', 'MCS 10 - 39 [81]', 'MCS 9 - 26 [54]', 'MCS 8 - 13 [27]', 'MCS 7 - 65 [135]', 'MCS 6 - 58.5 [121.5]', 'MCS 5 - 52 [108]', 'MCS 4 - 39 [81]', 'MCS 3 - 26 [54]', 'MCS 2 - 19.5 [40.5]', 'MCS 1 - 13 [27]', 'MCS 0 - 6.5 [13.5]');

var txrate_11a = new Array(54, 48, 36, 24, 18, 12, 9, 6);
var txrate_11n_value = new Array(150,140,130,120,110,100,90,80,70,60,50,40,30,20,10,0);

	 function set_11a_txrate(obj){
                for(var i = 0; i < txrate_11a.length + 1 - 5; i++){
                        var ooption = document.createElement("option");
                        obj.options[i] = null;
                        if ( i == 0){
                                ooption.text = "Best(automatic)";
                                ooption.value = 33;                                             
                        }       
                        else{                   
                        
                                ooption.text = txrate_11a[i-1];
                                ooption.value = txrate_11a[i-1];
                        }                               
                        obj.options[i] = ooption;       
                }
        }

        function set_11n_txrate(obj){
                for(var i = 0; i < txrate_11n.length+1; i++){
                        var ooption = document.createElement("option");
                        
                        obj.options[i] = null;
                        if ( i == 0){
                                ooption.text = "Best(automatic)";
                                ooption.value = 33;                                             
                        }       
                        else{                           
                                ooption.text = txrate_11n[i-1];
                                ooption.value = txrate_11n_value[i-1];
                        }                               
                        obj.options[i] = ooption;       
                }
        }


        function set_11an_txrate(obj){
                var count = 0;
                var legth = txrate_11a.length + txrate_11n.length
                for(var i = 0; i < legth+1; i++){
                        var ooption = document.createElement("option");
                        obj.options[i] = null;
                        if ( i == 0){
                                ooption.text = "Best(automatic)";
                                ooption.value = 33;                                             
                        }       
                        else{                           
                                if(i > txrate_11n.length){
                                        ooption.text = txrate_11a[count];
                                        ooption.value = txrate_11a[count];
                                        count++;                
                                }else{
                                        ooption.text = txrate_11n[i-1];
                                        ooption.value = txrate_11n_value[i-1];                          
                                }
                        }       
                        obj.options[i] = ooption;       
                }
        }


// for WPS function 		
	function show_buttons(){
		var enable = get_by_id("wpsEnable");
		var show_wps_word = "Enabled / ";
		if(ischeck_wps("wps")){
			if(!enable.checked){
				get_by_id("wps_pin").value = "00000000";
				show_wps_word = "Disabled / ";
			}else if(get_by_id("wps_pin").value == "00000000" && get_by_id("wpsEnable").checked){
			//	alert("In current Wireless not support WPS function.");
				get_by_id("wps_pin").value = get_by_id("wps_default_pin").value;
				get_by_id("show_wps_pin").innerHTML = get_by_id("wps_pin").value;
			}
			get_by_id("reset_pin").disabled = !enable.checked;
			get_by_id("generate_pin").disabled = !enable.checked;
			//get_by_id("reset_to_unconfigured").disabled = !enable.checked;
			if(get_by_id("wps_configured_mode").value == "1"){
				show_wps_word += "Not Configured";
				get_by_id("reset_to_unconfigured").disabled = true;
			}else{
				show_wps_word += "Configured";
				get_by_id("reset_to_unconfigured").disabled = false;
			}
			get_by_id("wps_word").innerHTML = show_wps_word;
		}
	}

	function set_pinvalue(obj_value){
		get_by_id("wps_pin").value = obj_value;
		get_by_id("show_wps_pin").innerHTML = obj_value;
	}
	
	function compute_pin_checksum(val)
	{
 		var accum = 0; 
 		var code = parseInt(val)*10;
 
 		accum += 3 * (parseInt(code / 10000000) % 10); 
 		accum += 1 * (parseInt(code / 1000000) % 10); 
 		accum += 3 * (parseInt(code / 100000) % 10); 
 		accum += 1 * (parseInt(code / 10000) % 10);
 		accum += 3 * (parseInt(code / 1000) % 10);
 		accum += 1 * (parseInt(code / 100) % 10);
 		accum += 3 * (parseInt(code / 10) % 10); 
 		accum += 1 * (parseInt(code / 1) % 10); 
 		var digit = (parseInt(accum) % 10);
 		return ((10 - digit) % 10);
	}

	function genPinClicked()
	{
 		var num_str="1";
 		var rand_no;
 		var num;
 
 		while (num_str.length != 7) {
  			rand_no = Math.random()*1000000000; 
  			num = parseInt(rand_no, 10);
  			num = num%10000000;
  			num_str = num.toString();
 		}
 
 		num = num*10 + compute_pin_checksum(num);
 		num = parseInt(num, 10); 
 		get_by_id("wps_pin").innerHTML = num; 
 		get_by_id("localPin").value = num;
	}
	
	function genPinClicked()
	{
 		var num_str="1";
 		var rand_no;
 		var num;
 
 		while (num_str.length != 7) {
  			rand_no = Math.random()*1000000000; 
  			num = parseInt(rand_no, 10);
  			num = num%10000000;
  			num_str = num.toString();
 		} 
 		num = num*10 + compute_pin_checksum(num);
 		num = parseInt(num, 10);  		 
 		get_by_id("wps_pin").value = num;
 		get_by_id("show_wps_pin").innerHTML = num;
	}

	function Unconfigured_button(){
		get_by_id("form1").action = "restore_default_wireless.cgi";
		get_by_id("form1").submit();
	}

	function check_wps_psk_eap(){
		var wlan1_security= "<!--# echo wlan1_security -->";
		var security = wlan1_security.split("_");

		if(get_by_id("wpsEnable").checked){
			if((get_by_id("wep_type").value == "1") && (get_by_id("wep_def_key").value != "1")){
				get_by_id("show_wep").style.display = "none";
				get_by_id("show_wpa").style.display = "none";	
		    	get_by_id("show_wpa_psk").style.display = "none";
		    	get_by_id("show_wpa_eap").style.display = "none";

				if(wlan1_security == "disable"){				//Disabled
					set_selectIndex(0, get_by_id("wep_type"));
				}else if(security[0] == "wep"){					//WEP
					set_selectIndex(1, get_by_id("wep_type"));
					get_by_id("show_wep").style.display = "";
				}else{
					if(security[1] == "psk"){					//PSK
						set_selectIndex(2, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_psk").style.display = "";	
					}else if(security[1] == "eap"){				//EAP
						set_selectIndex(3, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_eap").style.display = "";
					}
				}
				set_selectIndex(get_by_id("wlan1_wep_default_key").value, get_by_id("wep_def_key"));
				alert("Can't choose WEP key 2, 3, 4 when WPS is enable!!");
				return false;
			}
/*			if((get_by_id("wep_type").value == "2") && (get_by_id("c_type").value == "both")){
				get_by_id("show_wep").style.display = "none";
				get_by_id("show_wpa").style.display = "none";	
		    	get_by_id("show_wpa_psk").style.display = "none";
		    	get_by_id("show_wpa_eap").style.display = "none";

				if(wlan1_security == "disable"){				//Disabled
					set_selectIndex(0, get_by_id("wep_type"));
				}else if(security[0] == "wep"){					//WEP
					set_selectIndex(1, get_by_id("wep_type"));
					get_by_id("show_wep").style.display = "";
				}else{
					if(security[1] == "psk"){					//PSK
						set_selectIndex(2, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_psk").style.display = "";	
					}else if(security[1] == "eap"){				//EAP
						set_selectIndex(3, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_eap").style.display = "";
					}
				}
				set_selectIndex("<!--# echo wlan1_psk_cipher_type -->",get_by_id("c_type"));
				alert("Can't choose WPA-Personal/TKIP and AES when WPS is enable!!");
				//set_selectIndex("tkip", get_by_id("c_type"));
				return false;
			}
*/			
			if(get_by_id("wep_type").value == "3"){
				get_by_id("show_wep").style.display = "none";
				get_by_id("show_wpa").style.display = "none";	
		    	get_by_id("show_wpa_psk").style.display = "none";
		    	get_by_id("show_wpa_eap").style.display = "none";

				if(wlan1_security == "disable"){				//Disabled
					set_selectIndex(0, get_by_id("wep_type"));
				}else if(security[0] == "wep"){					//WEP
					set_selectIndex(1, get_by_id("wep_type"));
					get_by_id("show_wep").style.display = "";
				}else{
					if(security[1] == "psk"){					//PSK
						set_selectIndex(2, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_psk").style.display = "";	
					}else if(security[1] == "eap"){				//EAP
						set_selectIndex(3, get_by_id("wep_type"));
						get_by_id("show_wpa").style.display = "";	
						get_by_id("show_wpa_eap").style.display = "";
					}
				}
				alert("Can't choose WPA-Enterprise when WPS is enable!!");
				//set_selectIndex("0", get_by_id("wep_type"));
				return false;
			}
			
		}
		return true;
	}
	
	function ischeck_wps(obj){
		var is_true = false;
		if(get_by_id("wpsEnable").checked){
			if(!get_by_id("w_enable").checked){
				alert("Please Enable Wireless first.");
				is_true = true;
			}else if(!check_wps_psk_eap()){
				is_true = true;
			}else if(get_by_id("auth_type").value == "share"){
				alert("Can't choose shared key when WPS is enable!!");
				is_true = true;
				if(obj == "auto"){
					set_selectIndex("open", get_by_id("auth_type"));
				}
			}
		}
		if(is_true){
			if(obj == "wps"){
				get_by_id("wpsEnable").checked = false;
			}
			return false;
		}
		return true;
	}
	
	 function do_add_new_schedule(){
            window.location.href = "tools_schedules.asp";
     }
	
	
    function get_wlan1_schedule(obj){
	  	var tmp_schedule = obj.options[obj.selectedIndex].value;
	  	var schedule_val;
  	 	var tmp_schedule_index = obj.selectedIndex;

	  	//2009/4/10 Tina modify:Fixed can't save space char.
/*	  	for (var i = 0; i < 32; i++){
		var temp_sch = get_by_id("schedule_rule_" + i).value;
		var temp_data = temp_sch.split("/");
		
		  
		  if(tmp_schedule == temp_data[0]){
			  schedule_val = get_by_id("schedule_rule_" + i).value;
	}
	   }	
*/	       
	     if(tmp_schedule == "Always"){
		  		schedule_val = "Always";
		 }else if(tmp_schedule == "Never"){
			  	schedule_val = "Never";
		 }else{
			  schedule_val = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value;
		 }
		 
		 get_by_id("wlan1_schedule").value = schedule_val;
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
			<script>show_top("setup");</script>
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
									<script>show_left("Setup", 1);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			<input type="hidden" id="wps_default_pin" name="wps_default_pin" value="<!--# echo wps_generate_default_pin -->">
			<input type="hidden" id="wps_generate_pin" name="wps_generate_pin" value="<!--# echo wps_generate_pin -->">
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless_5g.asp">
				<input type="hidden" id="action" name="action" value="wireless_5g">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
				<input type="hidden" id="wlan0_op_mode" name="wlan0_op_mode" value="AP">
				<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" value="<!--# echo wlan1_ssid -->">
				<input type="hidden" id="wps_pin" name="wps_pin" value="<!--# echo wps_pin -->">
				<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">
				<input type="hidden" id="wlan1_wep_display" name="wlan1_wep_display" value="<!--# echo wlan1_wep_display -->">
				<input type="hidden" id="wlan1_auto_txrate" name="wlan1_auto_txrate" value="<!--# echo wlan1_auto_txrate -->">
				<input type="hidden" id="wlan1_channel_bandwidth" name="wlan1_channel_bandwidth" value="<!--# echo wlan1_channel_bandwidth -->">
				
				<input type="hidden" id="wlan1_schedule" name="wlan1_schedule" value="<!--# echo wlan1_schedule -->">
				
				<input type="hidden" id="apply" name="apply" value="0">   
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
		                                                                 
              
              <td valign="top" id="maincontent_container">
				<div id="maincontent">
				  <div id="box_header"> 
						<h1><script>show_words(_wireless_net);</script> : </h1>
						<p><script>show_words(bwl_Intro_1);</script></p>
						<input name="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
                        <input name="button2" type=reset class=button_submit value="Don't Save Settings" onclick="return page_cancel('form1', 'wireless_5g.asp');">
					</div>
					<div class="box"> 
						<h2><script>show_words(wwl_wcn_title);</script> :</h2>
							<table cellSpacing=1 cellPadding=1 width=525 border=0>
		                        <tr>
		                          <td class="duple"><script>show_words(_enable);</script> :</td>
		                          <td width="340">&nbsp;
								  <input name="wpsEnable" type=checkbox id="wpsEnable" value="1" onClick="show_buttons();" >
								  <input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
								  </td>
		                        </tr>
								<tr>
		                          <td class="duple"><script>show_words(LW9);</script> :</td>
		                          <td width="340">&nbsp;
								  	<span id="show_wps_pin"><!--# echo wps_pin --></span>
								  </td>
		                        </tr>
		                        <tr>
		                          <td class="duple">&nbsp;</td>
		                          <td width="340">&nbsp;
									  <!--input type="button" name="generate_pin" id="generate_pin" value="Generate New PIN" onclick='set_pinvalue(get_by_id("wps_generate_pin").value);'-->
									  <input type="button" name="generate_pin" id="generate_pin" value="Generate New PIN" onclick='genPinClicked();'>
									  <input type="button" name="reset_pin" id="reset_pin" value="Reset PIN to Default" onclick='set_pinvalue(get_by_id("wps_default_pin").value);'>
								  </td>
		                        </tr>
		                        <tr>
		                          <td class="duple"><script>show_words(wwl_wcn_status);</script> :</td>
		                          <td width="340">&nbsp;
								  	<span id="wps_word"></span>
								  </td>
		                        </tr>
		                        <tr>
		                          <td class="duple">&nbsp;</td>
		                          <td width="340">&nbsp;
			                      	<input type="button" name="reset_to_unconfigured" id="reset_to_unconfigured" value="Reset to Unconfigured" onClick="Unconfigured_button();"><br>
								  </td>
								</tr>
		                    </table>
					</div>
					<div class="box"> 
						<h2><script>show_words(bwl_title_1);</script></h2>
						<input type="hidden" id="wlan0_radio_mode" name="wlan0_radio_mode" value="<!--# echo wlan0_radio_mode -->">
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
        		                                        	<td class="duple"><script>show_words(wwz_wwl_rmode);</script> :</td>
		                	                                <td width="340">&nbsp;
        	                        	                        <input type="radio" value="0" name="radio_mode"  onclick="location.href='wireless.asp'"><script>show_words(wwz_wwl_mode_0);</script>&nbsp;
                	                        	                <input type="radio" value="1" name="radio_mode" checked ><script>show_words(wwz_wwl_mode_1);</script>&nbsp;
                                                		</td>
                                       				</tr>

								<tr>
									<td class="duple"><script>show_words(bwl_EW);</script> :</td>
									<td width="340">&nbsp;
                                      <input id="w_enable" name="w_enable" type="checkbox" value="1" onClick="disable_wireless();" checked>									
                                      <input type="hidden" id="wlan1_enable" name="wlan1_enable" value="<!--# echo wlan1_enable -->">
                                      <input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<!--# echo wlan0_enable -->">
                                    <select id="wlan1_schedule_select" name="wlan1_schedule_select" onChange="get_wlan1_schedule(this);">
					                 <option value="Always" selected><script>show_words(_always);</script></option>
									 <option value="Never"><script>show_words(_never);</script></option>
										<script>document.write(set_schedule_option());</script>
					               </select>
               					  <input name="add_new_schedule" type="button" class="button_submit" id="add_new_schedule" onclick="do_add_new_schedule(true)" value="Add New">								  </td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(bwl_NN);</script> :</td>
									<td width="340">&nbsp;&nbsp;&nbsp;<input name="show_ssid" type="text" id="show_ssid" size="20" maxlength="32" value=""><script>show_words(bwl_AS);</script> 
									</td>
								</tr>
							    <tr>
                                  	<td class="duple"><script>show_words(bwl_Mode);</script> :</td>
                              	  	<td width="340">&nbsp;&nbsp; 
									<select id="dot11_mode" name="dot11_mode" onClick="show_chan_width();">
										<option value="11a"><script>show_words(bwl_Mode_a );</script></option>
                                        <option value="11n"><script>show_words(bwl_Mode_n);</script></option>
                                        <option value="11an"><script>show_words(bwl_Mode_5);</script></option>
									</select>
									<input type="hidden" id="wlan1_dot11_mode" name="wlan1_dot11_mode" value="<!--# echo wlan1_dot11_mode -->">
									</td>
							  	</tr>
								<tr>
									<td class="duple"><script>show_words(ebwl_AChan);</script> :</td>
									<td width="340">&nbsp;
									<input type="checkbox" id="auto_channel" name="auto_channel" value="1" onClick="disable_channel();">
									<input type="hidden" id="wlan1_auto_channel_enable" name="wlan1_auto_channel_enable" value="<!--# echo wlan1_auto_channel_enable -->">
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(_wchannel);</script> :</td>
									<td width="340">&nbsp;&nbsp; 
									<select name="sel_wlan1_channel" id="sel_wlan1_channel">
                                    <script>
										set_channel();
									</script>
									</select>
									<input type="hidden" id="wlan1_channel" name="wlan1_channel" value="<!--# echo wlan1_channel -->">
									</td>
								</tr>
 								<!-- 11a txrate -->
                                                                <tr id="show_11a_txrate" style="display:none">
                                                                        <td class="duple"><script>show_words(bwl_TxR);</script>:</td>
                                                                        <td width="340">&nbsp;&nbsp;
                                                                        <select id="wlan1_11a_txrate" name="wlan1_11a_txrate">
                                                                                <script>set_11a_txrate(get_by_id("wlan1_11a_txrate"));</script>
                                                                        </select>
                                                                        </td>
                                                                </tr>
                                                                <!-- 11n txrate -->
                                                                <tr id="show_11n_txrate" style="display:none">
                                                                        <td class="duple"><script>show_words(bwl_TxR);</script>:</td>
                                                                        <td width="340">&nbsp;&nbsp;
                                                                        <select id="wlan1_11n_txrate" name="wlan1_11n_txrate">
                                                                                <script>set_11n_txrate(get_by_id("wlan1_11n_txrate"));</script>
                                                                        </select>
                                                                        </td>
                                                                </tr>
                                                                <!-- 11a/n txrate -->
                                                                <tr id="show_11an_txrate" style="display:none">
                                                                        <td class="duple"><script>show_words(bwl_TxR);</script>:</td>
                                                                        <td width="340">&nbsp;&nbsp;
                                                                        <select id="wlan1_11an_txrate" name="wlan1_11an_txrate">

                                                                                <script>set_11an_txrate(get_by_id("wlan1_11an_txrate"));</script>
                                                                        </select>
                                                                        </td>
                                                                </tr>
							    <tr  id="show_channel_width">
                                  	<td class="duple"><script>show_words(bwl_CWM);</script> :</td>
                              	  	<td width="340">&nbsp;&nbsp; 
									<select id="11n_protection" name="11n_protection">
										<option value="20"><script>show_words(bwl_ht20);</script></option>
										<option value="auto"><script>show_words(bwl_ht2040);</script></option>
									</select>
									<input type="hidden" id="wlan1_11n_protection" name="wlan1_11n_protection" value="<!--# echo wlan1_11n_protection -->">
									</td>
							  	</tr>
								<tr>
									<td class="duple"><script>show_words(bwl_VS);</script>:</td>
									<td width="340">&nbsp;
									<input type="radio" id="wlan1_ssid_broadcast" name="wlan1_ssid_broadcast" value="1"> <script>show_words(bwl_VS_0);</script>
									<input type="radio" id="wlan1_ssid_broadcast" name="wlan1_ssid_broadcast" value="0"> <script>show_words(bwl_VS_1);</script>
									</td>
							  </tr>														
							</table>
					</div>
							<input type="hidden" id="wlan1_security" name="wlan1_security" value="<!--# echo wlan1_security -->">
							<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<!--# echo asp_temp_37","hex -->">
							<input type="hidden" id="asp_temp_38" name="asp_temp_38" value="<!--# echo asp_temp_38","hex -->">
							<input type="hidden" id="asp_temp_39" name="asp_temp_39" value="<!--# echo asp_temp_39","hex -->">
							<input type="hidden" id="asp_temp_40" name="asp_temp_40" value="<!--# echo asp_temp_40","hex -->">
					<div class="box" id="show_security"> 
						<h2><script>show_words(bws_WSMode);</script></h2>
						<script>show_words(bws_intro_WlsSec);</script>
						<br><br>
				            <table cellpadding="1" cellspacing="1" border="0" width="525">
                              <tr>
                                <td class="duple"><script>show_words(bws_SM);</script> :</td>
                                <td width="340">&nbsp;
                                    <select id="wep_type" name="wep_type" onChange="show_wpa_wep()">
                                      <option value="0" selected><script>show_words(_none);</script></option>
                                      <option value="1"><script>show_words(_WEP);</script></option>
                                      <option value="2"><script>show_words(_WPApersonal);</script></option>
                                      <option value="3"><script>show_words(_WPAenterprise);</script></option>
                                    </select>
                                </td>
                              </tr>
                            </table>
				</div>
					<div class="box" id="show_wep" style="display:none"> 
						<h2><script>show_words(_WEP);</script></h2>
						<p><script>show_words(bws_msg_WEP_1);</script></p>
	              	    <p><script>show_words(bws_msg_WEP_2);</script></p>
						<p><script>show_words(bws_msg_WEP_3);</script></p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
							<input type="hidden" id="wlan1_wep64_key_1" name="wlan1_wep64_key_1" value="<!--# echo wlan1_wep64_key_1","hex -->">
							<input type="hidden" id="wlan1_wep128_key_1" name="wlan1_wep128_key_1" value="<!--# echo wlan1_wep128_key_1","hex -->">
							<input type="hidden" id="wlan1_wep64_key_2" name="wlan1_wep64_key_2" value="<!--# echo wlan1_wep64_key_2","hex -->">
							<input type="hidden" id="wlan1_wep128_key_2" name="wlan1_wep128_key_2" value="<!--# echo wlan1_wep128_key_2","hex -->">
							<input type="hidden" id="wlan1_wep64_key_3" name="wlan1_wep64_key_3" value="<!--# echo wlan1_wep64_key_3","hex -->">
							<input type="hidden" id="wlan1_wep128_key_3" name="wlan1_wep128_key_3" value="<!--# echo wlan1_wep128_key_3","hex -->">
							<input type="hidden" id="wlan1_wep64_key_4" name="wlan1_wep64_key_4" value="<!--# echo wlan1_wep64_key_4","hex -->">
							<input type="hidden" id="wlan1_wep128_key_4" name="wlan1_wep128_key_4" value="<!--# echo wlan1_wep128_key_4","hex -->">
								<tr> 
									<td class="duple"><script>show_words(wwl_WKL);</script> :</td>
									<td width="340">&nbsp; 
									  <select id="wep_key_len" name="wep_key_len" size=1 onChange="change_wep_key_fun();">
										<option value="5"><script>show_words(bws_WKL_0);</script></option>
										<option value="13"><script>show_words(bws_WKL_1);</script></option>
									  </select> <script>show_words(bws_length);</script>
									</td>
							  	</tr>
								<tr>
									<td class="duple"><script>show_words(bws_DFWK);</script> :</td>
									<td width="340">&nbsp;
										<select id="wep_def_key" name="wep_def_key" onChange="ischeck_wps('wep');">
											<option value="1"><script>show_words(wepkey1);</script></option>
											<option value="2"><script>show_words(wepkey2);</script></option>
											<option value="3"><script>show_words(wepkey3);</script></option>
											<option value="4"><script>show_words(wepkey4);</script></option>
									  	</select>
										<input type="hidden" id="wlan1_wep_default_key" name="wlan1_wep_default_key" value="<!--# echo wlan1_wep_default_key -->">
									</td>
					  			</tr>
								<tr>
									<td class="duple"><script>show_words(_auth);</script> :</td>
									<td width="340">&nbsp;
										<select name="auth_type" id="auth_type" onChange="ischeck_wps('auto');">
											<option value="open"><script>show_words(_open);</script></option>
											<option value="share"><script>show_words(bws_Auth_2);</script></option>
									  </select>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(wepkey1);</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert1"></span>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(wepkey2);</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert2"></span>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(wepkey3);</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert3"></span>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(wepkey4);</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert4"></span>
									</td>
								</tr>
                  			</table>
					</div>
					<div class="box" id="show_wpa"  style="display:none"> 
						<h2><script>show_words(_WPA);</script></h2>
						<p><script>show_words( bws_msg_WPA);</script></p>
						<p><script>show_words( bws_msg_WPA_2);</script></p>
							<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="<!--# echo wlan1_psk_cipher_type -->">
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple"><script>show_words(bws_WPAM);</script> :</td>
									<td width="340">&nbsp;
										<select id="wpa_mode" name="wpa_mode" onchange="set_cipher_option(get_by_id('c_type'))">
										   <script>set_wpa_option(get_by_id("wpa_mode"));</script>
									  	</select>
									</td>
					  			</tr>
								<tr>
									<td class="duple"><script>show_words(bws_CT);</script> :</td>
									<td width="340">&nbsp;
										<select id="c_type" name="c_type">
										   <script>set_cipher_option(get_by_id("c_type"));</script>
										</select>
									</td>
					  			</tr>
								<tr>
									<td class="duple"><script>show_words(bws_GKUI);</script> :</td>
									<td width="340">&nbsp;
										<input type="text" id="wlan1_gkey_rekey_time" name="wlan1_gkey_rekey_time" size="8" maxlength="5" value="<!--# echo wlan1_gkey_rekey_time -->"> <script>show_words(bws_secs);</script>
									</td>
								</tr>
                  			</table>
					</div>
					<div class="box" id="show_wpa_psk" style="display:none"> 
						<h2><script>show_words(LW25);</script></h2>
						<p class="box_msg"><script>show_words(KR100);</script></p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple"><script>show_words(LW25);</script> :</td>
									<td width="340">&nbsp;<input type="password" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" size="40" maxlength="64" value="<!--# echo wlan1_psk_pass_phrase -->"></td>
					  			</tr>
							</table>
					</div>
					<div class="box" id="show_wpa_eap" style="display:none"> 
						<h2><script>show_words(bws_EAPx);</script></h2>
						<p class="box_msg"><script>show_words(bws_msg_EAP);</script> </p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<input type="hidden" id="wlan1_eap_radius_server_0" name="wlan1_eap_radius_server_0" value="<!--# echo wlan1_eap_radius_server_0 -->">
									<input type="hidden" id="wlan1_eap_mac_auth" name="wlan1_eap_mac_auth" value="<!--# echo wlan1_eap_mac_auth -->">
							  		<td class="duple"><script>show_words(bwsAT_);</script> :</td>
							  		<td width="340">&nbsp;<input id="wlan1_eap_reauth_period" name="wlan1_eap_reauth_period" size=10 value="<!--# echo wlan1_eap_reauth_period -->"><script>show_words(_minutes);</script></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_RIPA);</script> :</td>
							  		<td width="340">&nbsp;<input id="radius_ip1" name="radius_ip1" maxlength=15 size=15></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_RSP);</script> :</td>
							  		<td width="340">&nbsp;<input type="text" id="radius_port1" name="radius_port1" size="8" maxlength="5" value="1812"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_RSSs);</script> :</td>
							  		<td width="340">&nbsp;<input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_RMAA);</script> :</td>
							  		<td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac1" name="radius_auth_mac1"></td>
					  			</tr>
								<tr id="radius2">
									<td colspan="2"><input type="button" id="advanced" name="advanced" value="Advanced >>" onClick="show_radius();"></td>
								</tr>
								<tr id="none_radius2" style="display:none">
									<td colspan="2"><input type="button" id="advanced" name="advanced" value="<< Advanced" onClick="show_radius();"></td>
								</tr>
							</table>
                  			<table id="show_radius2" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
								<tr>
									<input type="hidden" id="wlan1_eap_radius_server_1" name="wlan1_eap_radius_server_1" value="<!--# echo wlan1_eap_radius_server_1 -->">
							  		<td class="box_msg" colspan="2"><script>show_words(bws_ORAD);</script> :</td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_2RIPA);</script> :</td>
							  		<td width="340">&nbsp;<input id="radius_ip2" name="radius_ip2" maxlength=15 size=15></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_2RSP);</script> :</td>
							  		<td width="340">&nbsp;<input type="text" id="radius_port2" name="radius_port2" size="8" maxlength="5" value="1812"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_2RSSS);</script> :</td>
							  		<td width="340">&nbsp;<input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_2RMAA);</script> :</td>
							  		<td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac2" name="radius_auth_mac2"></td>
					  			</tr>
							</table>
					</div>
			</form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                     	<td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>                        
                          <p><script>show_words(TA9);</script></p>
						  <p><script>show_words(YM124);</script></p>
						  <p><script>show_words(YM125);</script></p>
						  <p><script>show_words(YM126);</script></p>
						  <p><a href="support_internet.asp#Wireless" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
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
<script>
//set_wpa_option(get_by_id("wpa_mode"));
//set_cipher_option(get_by_id("c_type"));
onPageLoad();
</script>    
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<!-- insert name=restore_cfg -->
</html>
