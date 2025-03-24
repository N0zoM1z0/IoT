<html>
<head>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript"> 
var submit_button_flag = 0;
var radius_button_flag = 0;
var radius_button_flag_1 = 0;

	function onPageLoad(){					
		set_checked(get_by_id("gzone_dhcpd_enable").value, get_by_id("dhcpsvr"));
		set_checked(get_by_id("wlan0_vap1_enable").value, get_by_id("guest_zone_enable0"));
		set_checked(get_by_id("wlan1_vap1_enable").value, get_by_id("guest_zone_enable1"));
		set_checked(get_by_id("asp_temp_65").value, get_by_id("guest_select_0"));	
		
		get_by_id("show_ssid").value = ssid_decode("wlan0_vap1_ssid");
		get_by_id("show_ssid_1").value = ssid_decode("wlan1_vap1_ssid");
		
	
		var temp_sch_0 = get_by_id("wlan0_vap1_schedule").value;
	    var temp_sch_1 = get_by_id("wlan1_vap1_schedule").value;
		var temp_data_0 = temp_sch_0.split("/");	
		var temp_data_1 = temp_sch_1.split("/");
		
	  	//2009/4/17 Tina modify:Fixed schedule can't selected.
		//set_selectIndex(temp_data_0[0], get_by_id("wlan0_vap1_schedule_select"));
		//set_selectIndex(temp_data_1[0], get_by_id("wlan1_vap1_schedule_select"));
	  		   
	    if((temp_sch_0 == "Always") || (temp_sch_0 == "Never") || (temp_sch_0 == "")){
	   		set_selectIndex(temp_data_0[0], get_by_id("wlan0_vap1_schedule_select"));
	    }else{
	  	var temp_index_0 = get_schedule_index(temp_data_0[0]);
	   get_by_id("wlan0_vap1_schedule_select").selectedIndex=temp_index_0+2;
	     }
  
		  if((temp_sch_1 == "Always") || (temp_sch_1 == "Never")|| (temp_sch_1 == "")){
		   	set_selectIndex(temp_data_1[0], get_by_id("wlan1_vap1_schedule_select"));
		  }else{
		     var temp_index_1 = get_schedule_index(temp_data_1[0]);
	   get_by_id("wlan1_vap1_schedule_select").selectedIndex=temp_index_1+2;		
		  }		
				
		var wlan0_vap1_psk_cipher_type= "<!--# echo wlan0_vap1_psk_cipher_type -->";
		var wlan1_vap1_psk_cipher_type= "<!--# echo wlan1_vap1_psk_cipher_type -->";
		var temp_r0 = get_by_id("wlan0_vap1_eap_radius_server_0").value;
		var temp_r00 = get_by_id("wlan1_vap1_eap_radius_server_0").value;
		var Dr0 = temp_r0.split("/");
		var Dr00 = temp_r00.split("/");
		if(Dr0.length > 1){
			get_by_id("radius_ip1").value=Dr0[0];
			get_by_id("radius_port1").value=Dr0[1];
			get_by_id("radius_pass1").value=Dr0[2];
		}
		if(Dr00.length > 1){
			get_by_id("radius_ip1_1").value=Dr00[0];
			get_by_id("radius_port1_1").value=Dr00[1];
			get_by_id("radius_pass1_1").value=Dr00[2];
		}
		
		var temp_r1 = get_by_id("wlan0_vap1_eap_radius_server_1").value;
		var temp_r11 = get_by_id("wlan1_vap1_eap_radius_server_1").value;
		var Dr1 = temp_r1.split("/");
		var Dr11 = temp_r11.split("/");
		if(Dr1.length > 1){
			get_by_id("radius_ip2").value=Dr1[0];
			get_by_id("radius_port2").value=Dr1[1];
			get_by_id("radius_pass2").value=Dr1[2];
		}
		if(Dr11.length > 1){
			get_by_id("radius_ip2_1").value=Dr11[0];
			get_by_id("radius_port2_1").value=Dr11[1];
			get_by_id("radius_pass2_1").value=Dr11[2];
		}
		
		var wlan0_vap1_eap_mac_auth = get_by_id("wlan0_vap1_eap_mac_auth").value;
		var wlan1_vap1_eap_mac_auth = get_by_id("wlan1_vap1_eap_mac_auth").value;
		if(wlan0_vap1_eap_mac_auth == 0){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan0_vap1_eap_mac_auth == 1){
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = false;
		}else if(wlan0_vap1_eap_mac_auth == 2){
			get_by_id("radius_auth_mac1").checked = false;
			get_by_id("radius_auth_mac2").checked = true;
		}else{
			get_by_id("radius_auth_mac1").checked = true;
			get_by_id("radius_auth_mac2").checked = true;
		}
		
		if(wlan1_vap1_eap_mac_auth == 0){
			get_by_id("radius_auth_mac1_1").checked = false;
			get_by_id("radius_auth_mac2_1").checked = false;
		}else if(wlan1_vap1_eap_mac_auth == 1){
			get_by_id("radius_auth_mac1_1").checked = true;
			get_by_id("radius_auth_mac2_1").checked = false;
		}else if(wlan1_vap1_eap_mac_auth == 2){
			get_by_id("radius_auth_mac1_1").checked = false;
			get_by_id("radius_auth_mac2_1").checked = true;
		}else{
			get_by_id("radius_auth_mac1_1").checked = true;
			get_by_id("radius_auth_mac2_1").checked = true;
		}
		
		set_selectIndex(get_by_id("wlan0_vap1_wep_default_key").value, get_by_id("wep_def_key"));
		set_selectIndex(get_by_id("wlan1_vap1_wep_default_key").value, get_by_id("wep_def_key_1"));

		var wlan0_vap1_security= "<!--# echo wlan0_vap1_security -->";
		var wlan1_vap1_security= "<!--# echo wlan1_vap1_security -->";
		var security = wlan0_vap1_security.split("_");
		var security1 = wlan1_vap1_security.split("_");
		
		//2.4G
		if(wlan0_vap1_security == "disable"){				//Disabled
			set_selectIndex(0, get_by_id("wep_type"));
		}else if(security[0] == "wep"){					//WEP
			get_by_id("show_wep").style.display = "";
			set_selectIndex(1, get_by_id("wep_type"));
			//check auth_type is open
			if (security[1] == "open"||security[1] =="auto"){
				security[1] = "auto";	
			set_selectIndex(security[1], get_by_id("auth_type"));
			}else{
			        set_selectIndex(security[1], get_by_id("auth_type"));
			}
			if(security[2] == "64"){
				set_selectIndex(5, get_by_id("wep_key_len"));
			}else{
				set_selectIndex(13, get_by_id("wep_key_len"));
			}
		}else{
			if(security[1] == "psk"){					//PSK
			    get_by_id("show_wpa_psk").style.display = "";
			    get_by_id("show_wpa").style.display = "";
				set_selectIndex(2, get_by_id("wep_type"));
			}else if(security[1] == "eap"){				//EAP
			    get_by_id("show_wpa_eap").style.display = "";
			    get_by_id("show_wpa").style.display = "";
				set_selectIndex(3, get_by_id("wep_type"));
			}
			//set wpa_mode
			if(security[0] == "wpa2auto"){
				get_by_id("show_wpa").style.display = "";	
				set_selectIndex(2, get_by_id("wpa_mode"));
			}else{
				get_by_id("wpa_mode").value = security[0];
			}
		}
		//5G
		if(wlan1_vap1_security == "disable"){				//Disabled
			set_selectIndex(0, get_by_id("wep_type_1"));
		}else if(security1[0] == "wep"){					//WEP
			get_by_id("show_wep_1").style.display = "";
			set_selectIndex(1, get_by_id("wep_type_1"));
                        //check auth_type is open
			if (security1[1] == "open"||security1[1] =="auto"){
				security[1] = "auto";	
			set_selectIndex(security1[1], get_by_id("auth_type_1"));
			}else{
			set_selectIndex(security1[1], get_by_id("auth_type_1"));
			}
			
			if(security1[2] == "64"){
				set_selectIndex(5, get_by_id("wep_key_len_1"));
			}else{
				set_selectIndex(13, get_by_id("wep_key_len_1"));
			}
		}else{
			if(security1[1] == "psk"){					//PSK
				get_by_id("show_wpa_psk_1").style.display = "";
				get_by_id("show_wpa_1").style.display = "";
				set_selectIndex(2, get_by_id("wep_type_1"));
			}else if(security1[1] == "eap"){				//EAP
				get_by_id("show_wpa_eap_1").style.display = "";
				get_by_id("show_wpa_1").style.display = "";	
				set_selectIndex(3, get_by_id("wep_type_1"));
			}
			//set wpa_mode
			if(security1[0] == "wpa2auto"){
				get_by_id("show_wpa_1").style.display = "";	
				set_selectIndex(2, get_by_id("wpa_mode_1"));
			}else{
				get_by_id("wpa_mode_1").value = security1[0];
			}
		}

		change_wep_key_fun();
		change_wep_key_fun_1();
		set_selectIndex("<!--# echo wlan0_vap1_psk_cipher_type -->",get_by_id("c_type"));
		set_selectIndex("<!--# echo wlan1_vap1_psk_cipher_type -->",get_by_id("c_type_1"));
		
		show_router_dhcp();

		set_form_default_values("form1");
	
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		} 
	}

	function change_wep_key_fun(){
		var length = parseInt(get_by_id("wep_key_len").value) * 2;
		var key_length = get_by_id("wep_key_len").selectedIndex;
		var key_type = get_by_id("wlan0_vap1_wep_display").value;
		var key1 = get_by_id("wlan0_vap1_wep" + key_num_array[key_length] + "_key_1").value;
		var key2 = get_by_id("wlan0_vap1_wep" + key_num_array[key_length] + "_key_1").value;
		var key3 = get_by_id("wlan0_vap1_wep" + key_num_array[key_length] + "_key_1").value;
		var key4 = get_by_id("wlan0_vap1_wep" + key_num_array[key_length] + "_key_1").value;
		
		get_by_id("show_resert1").innerHTML = "<input type=\"password\" id=\"key1\" name=\"key1\" maxlength=" + length + " size=\"31\" value=" + key1 + " >"
		get_by_id("show_resert2").innerHTML = "<input type=\"hidden\" id=\"key2\" name=\"key2\" maxlength=" + length + " size=\"31\" value=" + key2 + " >"
		get_by_id("show_resert3").innerHTML = "<input type=\"hidden\" id=\"key3\" name=\"key3\" maxlength=" + length + " size=\"31\" value=" + key3 + " >"
		get_by_id("show_resert4").innerHTML = "<input type=\"hidden\" id=\"key4\" name=\"key4\" maxlength=" + length + " size=\"31\" value=" + key4 + " >"		
	}
	function change_wep_key_fun_1(){
		var length_1 = parseInt(get_by_id("wep_key_len_1").value) * 2;
		var key_length_1 = get_by_id("wep_key_len_1").selectedIndex;
		var key_type_1 = get_by_id("wlan1_vap1_wep_display").value;
		var key5 = get_by_id("wlan1_vap1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key6 = get_by_id("wlan1_vap1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key7 = get_by_id("wlan1_vap1_wep" + key_num_array[key_length_1] + "_key_1").value;
		var key8 = get_by_id("wlan1_vap1_wep" + key_num_array[key_length_1] + "_key_1").value;
		
		get_by_id("show_resert5").innerHTML = "<input type=\"password\" id=\"key5\" name=\"key5\" maxlength=" + length_1 + " size=\"31\" value=" + key5 + " >"
		get_by_id("show_resert6").innerHTML = "<input type=\"hidden\" id=\"key6\" name=\"key6\" maxlength=" + length_1 + " size=\"31\" value=" + key6 + " >"
		get_by_id("show_resert7").innerHTML = "<input type=\"hidden\" id=\"key7\" name=\"key7\" maxlength=" + length_1 + " size=\"31\" value=" + key7 + " >"
		get_by_id("show_resert8").innerHTML = "<input type=\"hidden\" id=\"key8\" name=\"key8\" maxlength=" + length_1 + " size=\"31\" value=" + key8 + " >"		
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
    function check_8021x_1(){
    	var ip1 = get_by_id("radius_ip1_1").value;
    	var ip2 = get_by_id("radius_ip2_1").value;
        
        var radius1_msg = replace_msg(all_ip_addr_msg,"Radius Server 1");
    	var radius2_msg = replace_msg(all_ip_addr_msg,"Radius Server 2");
        
        var temp_ip1 = new addr_obj(ip1.split("."), radius1_msg, false, false);
        var temp_ip2 = new addr_obj(ip2.split("."), radius2_msg, true, false);
        var temp_radius1 = new raidus_obj(temp_ip1, get_by_id("radius_port1_1").value, get_by_id("radius_pass1_1").value);
        var temp_radius2 = new raidus_obj(temp_ip2, get_by_id("radius_port2_1").value, get_by_id("radius_pass2_1").value);
         
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
		var psk_value = get_by_id("wlan0_vap1_psk_pass_phrase").value;
		if (psk_value.length < 8){                   
			alert(YM116);
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(GW_WLAN_WPA_PSK_HEX_STRING_INVALID);
				return false;
			}
        }
        return true;         
    }
    function check_psk_1(){
		var psk_value = get_by_id("wlan1_vap1_psk_pass_phrase").value;
		if (psk_value.length < 8){                   
			alert(YM116);
				return false;
		}else if (psk_value.length > 63){
			if(!isHex(psk_value)){
				alert(GW_WLAN_WPA_PSK_HEX_STRING_INVALID);
				return false;
			}
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
		check_wps_psk_eap();
		get_by_id("show_wpa").style.display = "";	
		get_by_id("show_wpa_psk").style.display = "";	
	}else if(wep_type == 3){	//WPA-Enterprise
		if(check_wps_psk_eap()){
			get_by_id("show_wpa").style.display = "";	
			get_by_id("show_wpa_eap").style.display = "";
		}
	}
}

function show_wpa_wep_1(){			
	var wep_type = get_by_id("wep_type_1").value;	

	get_by_id("show_wep_1").style.display = "none";
	get_by_id("show_wpa_1").style.display = "none";	
	get_by_id("show_wpa_psk_1").style.display = "none";
	get_by_id("show_wpa_eap_1").style.display = "none";

	if (wep_type == 1){			//WEP
		get_by_id("show_wep_1").style.display = "";
	}else if(wep_type == 2){	//WPA-Personal
		check_wps_psk_eap_1();
		get_by_id("show_wpa_1").style.display = "";	
		get_by_id("show_wpa_psk_1").style.display = "";	
	}else if(wep_type == 3){	//WPA-Enterprise
		if(check_wps_psk_eap_1()){
			get_by_id("show_wpa_1").style.display = "";	
			get_by_id("show_wpa_eap_1").style.display = "";
		}
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
function show_radius_1(){
	get_by_id("radius2_1").style.display = "none";
	get_by_id("none_radius2_1").style.display = "none";
	get_by_id("show_radius2_1").style.display = "none";
	if(radius_button_flag_1){
			get_by_id("radius2_1").style.display = "";
			radius_button_flag_1 = 0;
		}else{
			get_by_id("none_radius2_1").style.display = "";
			get_by_id("show_radius2_1").style.display = "";
			radius_button_flag_1 = 1;
		}
	}

	function send_key_value(key_length){
		var key_type = get_by_id("wlan0_vap1_wep_display").value;

		for(var i = 1; i < 5; i++){
			get_by_id("wlan0_vap1_wep" + key_length + "_key_" + i).value = get_by_id("key" + i).value;
		}
		
		get_by_id("asp_temp_57").value = get_by_id("wlan0_vap1_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_58").value = get_by_id("wlan0_vap1_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_59").value = get_by_id("wlan0_vap1_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_60").value = get_by_id("wlan0_vap1_wep"+ key_length +"_key_1").value;
                
                get_by_id("wlan0_vap1_wep"+ key_length +"_key_1").value = get_by_id("asp_temp_57").value;
		get_by_id("wlan0_vap1_wep"+ key_length +"_key_2").value = get_by_id("asp_temp_57").value;
		get_by_id("wlan0_vap1_wep"+ key_length +"_key_3").value = get_by_id("asp_temp_57").value;
		get_by_id("wlan0_vap1_wep"+ key_length +"_key_4").value = get_by_id("asp_temp_57").value;  	
	}
	function send_key_value_1(key_length_1){
		var key_type_1 = get_by_id("wlan1_vap1_wep_display").value;

		for(var i = 1; i < 5; i++){
				get_by_id("wlan1_vap1_wep" + key_length_1 + "_key_" + i).value = get_by_id("key" + (i+4)).value;
		}
		
		get_by_id("asp_temp_61").value = get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_62").value = get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_63").value = get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_1").value;
		get_by_id("asp_temp_64").value = get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_1").value;

                get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_1").value = get_by_id("asp_temp_61").value;
		get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_2").value = get_by_id("asp_temp_61").value;
		get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_3").value = get_by_id("asp_temp_61").value;
		get_by_id("wlan1_vap1_wep"+ key_length_1 +"_key_4").value = get_by_id("asp_temp_61").value;  
	}
	
	
	function send_cipher_value(){
		if(get_by_id("c_type").selectedIndex == 0){
			get_by_id("wlan0_vap1_psk_cipher_type").value = "tkip";
		}else if(get_by_id("c_type").selectedIndex == 1){
			get_by_id("wlan0_vap1_psk_cipher_type").value = "aes";
		}else{
			get_by_id("wlan0_vap1_psk_cipher_type").value = "both";
		}
	}
	function send_cipher_value_1(){
		if(get_by_id("c_type_1").selectedIndex == 0){
			get_by_id("wlan1_vap1_psk_cipher_type").value = "tkip";
		}else if(get_by_id("c_type_1").selectedIndex == 1){
			get_by_id("wlan1_vap1_psk_cipher_type").value = "aes";
		}else{
			get_by_id("wlan1_vap1_psk_cipher_type").value = "both";
		}
	}
        
        /* wep conflict */
        function isWepConflict()
        {
                var wlan0_sec = "<!--# echo wlan0_security -->";
                var wlan0_gsec = get_by_id("wlan0_vap1_security").value;
                var wlan1_sec = "<!--# echo wlan1_security -->";
                var wlan1_gsec = get_by_id("wlan1_vap1_security").value;

		if (get_by_id("guest_zone_enable0").checked)
		{		 
                	if (wlan0_sec.match(/wep/g) && wlan0_gsec.match(/wep/g)) {
                        	alert(WIFI_WEP_CONFLICT);
                        	return false;
                	}
		}

                if (get_by_id("guest_zone_enable1").checked){
 	               if (wlan1_sec.match(/wep/g) && wlan1_gsec.match(/wep/g)) {
        	                alert(WIFI_WEP_CONFLICT);
                	        return false;
                	}
		}

                return true;
        }

	function disable_ip()
	{
		var dhcpsvr = get_by_id("dhcpsvr");
		get_by_id("gzone_dhcpd_start").disabled = !dhcpsvr.checked;
		get_by_id("gzone_dhcpd_end").disabled = !dhcpsvr.checked;
		get_by_id("gzone_dhcpd_lease_time").disabled = !dhcpsvr.checked;
	}

	function check_dhcp_range()
	{
		var lan_ip = get_by_id("gzone_ipaddr").value.split(".");
		var lan_netmask = get_by_id("gzone_netmask").value.split(".");
		var start_ip3 = get_by_id("gzone_dhcpd_start").value.split(".");
		var end_ip3 = get_by_id("gzone_dhcpd_end").value.split(".");
		var start_ip="", end_ip="";
		for(var i =0; i< 4;i++) {
			if ( ( parseInt(lan_ip[i]) & parseInt(lan_netmask[i])) != (parseInt(start_ip3[i]) & parseInt(lan_netmask[i]))) {
				start_ip +=lan_ip[i];
				end_ip +=lan_ip[i];

			} else {
				start_ip +=start_ip3[i];
				end_ip +=end_ip3[i];
			}

			if(i < 3) {
				start_ip += ".";
				end_ip += ".";
			}
		}
		get_by_id("gzone_dhcpd_start").value = start_ip;
		get_by_id("gzone_dhcpd_end").value = end_ip;
	}

	function show_router_dhcp()
	{
		if (get_by_id("guest_zone_enable0").checked == false &&
			get_by_id("guest_zone_enable1").checked == false) {

			get_by_id("gzone_ipaddr").disabled = true;
			get_by_id("gzone_netmask").disabled = true;
			get_by_id("dhcpsvr").disabled = true;
			get_by_id("gzone_dhcpd_start").disabled = true;
			get_by_id("gzone_dhcpd_end").disabled = true;
			get_by_id("gzone_dhcpd_lease_time").disabled = true;
			get_by_id("guest_select_0").disabled = true;
		} else {
			get_by_id("gzone_ipaddr").disabled = false;
			get_by_id("gzone_netmask").disabled = false;
			get_by_id("dhcpsvr").disabled = false;
			get_by_id("guest_select_0").disabled = false;
			disable_ip();
		}
	}

	function check_host_zone()
	{
		if (get_by_id("wlan0_enable").value == "0" && 
		    get_by_id("guest_zone_enable0").checked) {
			alert(TEXT028);
			get_by_id("guest_zone_enable0").checked = false;
			return false;
		}
		show_router_dhcp();
	}

	function check_host_zone1()
	{
		if (get_by_id("wlan1_enable").value == "0" && 
		    get_by_id("guest_zone_enable1").checked) {
			alert(TEXT028);
			get_by_id("guest_zone_enable1").checked = false;
			return false;
		}
		show_router_dhcp();
	}

	function send_request(){				
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
		var ip = get_by_id("gzone_ipaddr").value;
		var mask = get_by_id("gzone_netmask").value;
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		//2.4G
		var wlan_ssid = get_by_id("show_ssid").value
		var wep_type_value = get_by_id("wep_type").value;
		var key_length =get_by_id("wep_key_len").selectedIndex;
		var rekey_msg = replace_msg(check_num_msg, bws_GKUI, 30, 65535);
		var temp_rekey = new varible_obj(get_by_id("wlan0_vap1_gkey_rekey_time").value, rekey_msg, 30, 65535, false);
		var wlan0_dot11_mode = "<!--# echo wlan0_dot11_mode -->";
		var c_type_value = get_by_id("c_type").value;
		
		//5G
		var wlan_ssid_1 = get_by_id("show_ssid_1").value
		var wep_type_value_1 = get_by_id("wep_type_1").value;
		var key_length_1 =get_by_id("wep_key_len_1").selectedIndex;		
		var rekey_msg_1 = replace_msg(check_num_msg, bws_GKUI, 30, 65535);
		var temp_rekey_1 = new varible_obj(get_by_id("wlan1_vap1_gkey_rekey_time").value, rekey_msg, 30, 65535, false);
		var wlan1_dot11_mode = "<!--# echo wlan1_dot11_mode -->";
		var c_type_1_value = get_by_id("c_type_1").value;

		var lanip = get_by_id("lan_ipaddr").value;
		var lanmask = get_by_id("lan_netmask").value;
		var wlan0_enable = get_by_id("wlan0_enable").value;
		var wlan1_enable = get_by_id("wlan1_enable").value;

		var temp_lanip_obj = new addr_obj(lanip.split("."), ip_addr_msg, false, false);
		var temp_lanmask_obj = new addr_obj(lanmask.split("."), subnet_mask_msg, false, false);
		
		if(!(check_ssid("show_ssid"))){
				return false;
		}
		if(!(check_ssid("show_ssid_1"))){
				return false;
		}
		if(!(ischeck_wps("auto"))){
				return false;
		}
		if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj))
			return false;

		/*Always check host zone and guest zone subnet even if wireless or guest zone is disabled*/
//		if ((wlan0_enable == 1 && get_by_id("guest_zone_enable0").checked) ||
//			(wlan1_enable == 1 && get_by_id("guest_zone_enable1").checked)) {
			if (temp_lanip_obj && temp_lanmask_obj) {
				var ipaddr = temp_ip_obj.addr;
				var maskaddr = temp_mask_obj.addr;
				var lanipaddr = temp_lanip_obj.addr;
				var lanmaskaddr = temp_lanmask_obj.addr;
				var count = 0;                  
				for (var i = 0; i < ipaddr.length; i++) {
					if ((ipaddr[i] & lanmaskaddr[i]) == (lanipaddr[i] & lanmaskaddr[i]))
						count++;                        
				}
				if (count == ipaddr.length) {
					alert(guestzone_conflict);
					return false;
				}       
			}
//		}


		
		/* 2.4G */
		if(get_by_id("guest_zone_enable0").checked){
			if(wep_type_value == 1){		//WEP
				if (wlan0_dot11_mode == "11n"){
						alert(MSG044);
					return false;
				}else{
				if(!check_vap1_key()){
					return false;
				}
				}
				
			}else if(wep_type_value == 2){	//PSK
				if ((wlan0_dot11_mode == "11n") && (c_type_value == "tkip")){
					alert(MSG045);
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
				if ((wlan0_dot11_mode == "11n") && (c_type_value == "tkip")){
					alert(MSG045);
					return false;
				}
				if (!check_varible(temp_rekey)){
					return false;
				}
				if(!check_8021x()){
					return false;
				}
			}
			
		}	
		/* 5G */
		if(get_by_id("guest_zone_enable1").checked){
			if(wep_type_value_1 == 1){		//WEP
				if (wlan1_dot11_mode == "11n"){
					alert(MSG044);
					return false;
				}else{
				if(!check_vap1_key_1()){
					return false;
				}
				}
			}else if(wep_type_value_1 == 2){	//PSK
				if ((wlan1_dot11_mode == "11n") && (c_type_1_value == "tkip")){
					alert(MSG045);
					return false;
				}else{
				if (!check_varible(temp_rekey_1)){
					return false;
				}
				
				if(!check_psk_1()){
					return false;
				}
				}
				
			}else if(wep_type_value_1 == 3){	//EAP
				if ((wlan1_dot11_mode == "11n") && (c_type_1_value == "tkip")){
					alert(MSG045);
					return false;
				}
				if (!check_varible(temp_rekey_1)){
					return false;
				}
				
				if(!check_8021x_1()){
					return false;
				}
			}
		}			
		<!--save wireless network setting-2.4G-->
		get_by_id("wlan0_vap1_enable").value = get_checked_value(get_by_id("guest_zone_enable0"));
		get_by_id("asp_temp_65").value = get_checked_value(get_by_id("guest_select_0"));
		if(get_checked_value(get_by_id("guest_select_0"))== "0"){
			get_by_id("wlan0_vap_guest_zone").value = 1;
		}else{
			get_by_id("wlan0_vap_guest_zone").value = 0;
		}
	
		get_by_id("wlan0_vap1_wep_default_key").value = get_by_id("wep_def_key").value;
		var wpa_mode = get_by_id("wpa_mode").value;
				
		<!--save wireless network setting-5G-->
		get_by_id("wlan1_vap1_enable").value = get_checked_value(get_by_id("guest_zone_enable1"));
		
		get_by_id("wlan1_vap1_wep_default_key").value = get_by_id("wep_def_key_1").value;
		var wpa_mode_1 = get_by_id("wpa_mode_1").value;
		
		<!--save security -2.4G-->
		if(wep_type_value == 1){			//WEP
			get_by_id("wlan0_vap1_security").value = "wep_"+ get_by_id("auth_type").value +"_"+ key_num_array[key_length];
			//save wep key
			send_key_value(key_num_array[key_length]);
		}else if(wep_type_value == 2){		//PSK
			if(wpa_mode == "auto"){
				get_by_id("wlan0_vap1_security").value = "wpa2auto_psk";
			}else{
				get_by_id("wlan0_vap1_security").value = wpa_mode + "_psk";
			}
			send_cipher_value();
			//save psk value
			get_by_id("asp_temp_57").value = get_by_id("wlan0_vap1_psk_pass_phrase").value;
		}else if(wep_type_value == 3){		//EAP
			if(wpa_mode == "auto"){
				get_by_id("wlan0_vap1_security").value = "wpa2auto_eap";
			}else{
				get_by_id("wlan0_vap1_security").value = wpa_mode + "_eap";
			}
			send_cipher_value();
			//save radius server
			var r_ip_0 = get_by_id("radius_ip1").value;
			var r_port_0 = get_by_id("radius_port1").value;
			var r_pass_0 = get_by_id("radius_pass1").value;
			var dat0 =r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
			get_by_id("wlan0_vap1_eap_radius_server_0").value = dat0;
			
			if(radius_button_flag){
				var r_ip_1 = get_by_id("radius_ip2").value;
				var r_port_1 = get_by_id("radius_port2").value;
				var r_pass_1 = get_by_id("radius_pass2").value;
				var dat1 =r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
				get_by_id("wlan0_vap1_eap_radius_server_1").value = dat1;
			}

			if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = false))
				get_by_id("wlan0_vap1_eap_mac_auth").value = 0;
			else if((get_by_id("radius_auth_mac1").checked == true) && (get_by_id("radius_auth_mac2").checked = false))
				get_by_id("wlan0_vap1_eap_mac_auth").value = 1;
			else if((get_by_id("radius_auth_mac1").checked == false) && (get_by_id("radius_auth_mac2").checked = true))
				get_by_id("wlan0_vap1_eap_mac_auth").value = 2;
			else
				get_by_id("wlan0_vap1_eap_mac_auth").value = 3;

		}else{								//DISABLED
			get_by_id("wlan0_vap1_security").value = "disable";
		}
		
		<!--save security -5G-->
		if(wep_type_value_1 == 1){			//WEP
			get_by_id("wlan1_vap1_security").value = "wep_"+ get_by_id("auth_type_1").value +"_"+ key_num_array[key_length_1];
			//save wep key
			send_key_value_1(key_num_array[key_length_1]);
		}else if(wep_type_value_1 == 2){		//PSK
			if(wpa_mode_1 == "auto"){
				get_by_id("wlan1_vap1_security").value = "wpa2auto_psk";
			}else{
				get_by_id("wlan1_vap1_security").value = wpa_mode_1 + "_psk";
			}
			send_cipher_value_1();
			//save psk value
			get_by_id("asp_temp_61").value = get_by_id("wlan1_vap1_psk_pass_phrase").value;
		}else if(wep_type_value_1 == 3){		//EAP
			if(wpa_mode_1 == "auto"){
				get_by_id("wlan1_vap1_security").value = "wpa2auto_eap";
			}else{
				get_by_id("wlan1_vap1_security").value = wpa_mode_1 + "_eap";
			}
			send_cipher_value_1();
			//save radius server
			var r_ip_00 = get_by_id("radius_ip1_1").value;
			var r_port_00 = get_by_id("radius_port1_1").value;
			var r_pass_00 = get_by_id("radius_pass1_1").value;
			var dat00 =r_ip_00 +"/"+ r_port_00 +"/"+ r_pass_00;
			get_by_id("wlan1_vap1_eap_radius_server_0").value = dat00;
			
			if(radius_button_flag_1){
				var r_ip_11 = get_by_id("radius_ip2_1").value;
				var r_port_11 = get_by_id("radius_port2_1").value;
				var r_pass_11 = get_by_id("radius_pass2_1").value;
				var dat11 =r_ip_11 +"/"+ r_port_11 +"/"+ r_pass_11;
				get_by_id("wlan1_vap1_eap_radius_server_1").value = dat11;
			}

			if((get_by_id("radius_auth_mac1_1").checked == false) && (get_by_id("radius_auth_mac2_1").checked = false))
				get_by_id("wlan1_vap1_eap_mac_auth").value = 0;
			else if((get_by_id("radius_auth_mac1_1").checked == true) && (get_by_id("radius_auth_mac2_1").checked = false))
				get_by_id("wlan1_vap1_eap_mac_auth").value = 1;
			else if((get_by_id("radius_auth_mac1_1").checked == false) && (get_by_id("radius_auth_mac2_1").checked = true))
				get_by_id("wlan1_vap1_eap_mac_auth").value = 2;
			else
				get_by_id("wlan1_vap1_eap_mac_auth").value = 3;

		}else{								//DISABLED
			get_by_id("wlan1_vap1_security").value = "disable";
		}
		
		
		<!--save Wi-Fi value-->		
		//if(get_by_id("wps_enable").value != get_checked_value(get_by_id("wpsEnable"))){
		//get_by_id("wps_enable").value = get_checked_value(get_by_id("wpsEnable"));
			//get_by_id("reboot_type").value = "wlanapp";
		//}
		//save wps_configured_mode
		//if (get_by_id("wps_configured_mode").value == "1" && is_form_modified("form1") && !is_wps_modified()){
		//	get_by_id("wps_configured_mode").value = 5;
		//}
		
		//get_by_id("wps_configured_mode").value = 5;	//save wps_configured_mode when setting wireless
		if (get_by_id("dhcpsvr").checked){
			var start_ip = get_by_id("gzone_dhcpd_start").value;
			var end_ip = get_by_id("gzone_dhcpd_end").value;
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP Address");
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP Address");
			var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
			var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
			var dhcp_les = get_by_id("gzone_dhcpd_lease_time").value;		
			var less_msg = replace_msg(check_num_msg, bd_DLT, 1, 999999);
			var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
			var guest_ip = ip;

			if(guest_ip == lanip){
				alert(LW1);
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
				alert(TEXT037);
				return false;
			}

			if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
				alert(TEXT038);
				return false;
			}

			if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, TEXT035))
				return false;
			
			if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, TEXT036))
				return false;

			if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj))
				return false;

			if (!check_ip_order(start_obj, end_obj)){
				alert(TEXT039);
				return false;
			}

			if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
				alert(network_dhcp_ip_in_server);
				return false;
			}

			if (!check_varible(temp_less))
				return false;
		
			get_by_id("gzone_dhcpd_enable").value = 1;
		}else{
			get_by_id("gzone_dhcpd_enable").value = 0;
		}

		if (!isWepConflict())
			return false;		

//		if (!wps_guestzone_WarrMsg(get_by_id("guest_zone_enable0").checked , get_by_id("guest_zone_enable1").checked))
//			return false;

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("wlan0_vap1_ssid").value = get_by_id("show_ssid").value;
			get_by_id("wlan1_vap1_ssid").value = get_by_id("show_ssid_1").value;
			return true;
		}else{
			return false;
		}
		
	}

	function is_wps_modified(){ //check wps change or not, false:not change, true:change
		if((get_by_id("wps_enable").value == "<!--# echo wps_enable -->") && 
		   (get_by_id("wps_pin").value == "<!--# echo wps_pin -->")){
			return false;
		}else{
			return true;
		}
	}
	



	function Unconfigured_button(){
		get_by_id("form1").action = "restore_default_wireless.cgi";
		get_by_id("form1").submit();
	}

	function check_wps_psk_eap(){
		if(get_by_id("wps_enable").value =="1"){
			if((get_by_id("wep_type").value == "1") && (get_by_id("wep_def_key").value != "1")){
				alert(TEXT024);//Can't choose WEP key 2, 3, 4 when WPS is enable
				return false;
			}
			/*if((get_by_id("wep_type").value == "2") && (get_by_id("c_type").value == "both")){
				alert(TEXT025); //Can't choose WPA-Personal/TKIP and AES when WPS is enable
				set_selectIndex("tkip", get_by_id("c_type"));
				return false;
			}*/
			if(get_by_id("wep_type").value == "3"){
				//alert(TEXT026); //Can't choose WPA-Enterprise when WPS is enable!!
				//set_selectIndex("0", get_by_id("wep_type"));
				//return false;
				//get_by_id("wps_enable").value = "0";
			}
			}
		return true;
		}
	
	function check_wps_psk_eap_1(){
		if(get_by_id("wps_enable").value =="1"){
				if((get_by_id("wep_type_1").value == "1") && (get_by_id("wep_def_key_1").value != "1")){
					alert(TEXT024);//Can't choose WEP key 2, 3, 4 when WPS is enable
					return false;
			}
			/*if((get_by_id("wep_type_1").value == "2") && (get_by_id("c_type_1").value == "both")){
					alert(TEXT025); //Can't choose WPA-Personal/TKIP and AES when WPS is enable
					set_selectIndex("tkip", get_by_id("c_type_1"));
					return false;
			}*/
			if(get_by_id("wep_type_1").value == "3"){
				//alert(TEXT026);
				//set_selectIndex("0", get_by_id("wep_type_1"));
				//return false;
				//get_by_id("wps_enable").value = "0";
			}
			}
		return true;
	}
	
	function ischeck_wps(obj){
/*
		var is_true = false;
		if(get_by_id("wps_enable").value =="1"){
			//if(!get_by_id("w_enable").checked){
				//alert("Please Enable Wireless first.");
				//is_true = true;
			//}else 
			if(!check_wps_psk_eap()){
				is_true = true;
			}else if(get_by_id("auth_type").value == "share"){
				alert(TEXT027);	//Can't choose shared key when WPS is enable
				is_true = true;
				if(obj == "auto"){
					set_selectIndex("auto", get_by_id("auth_type"));
				}
			}
			if(!check_wps_psk_eap_1()){
				is_true = true;
			}else if(get_by_id("auth_type_1").value == "share"){
				alert(TEXT027);	//Can't choose shared key when WPS is enable
				is_true = true;
				if(obj == "auto"){
					set_selectIndex("auto", get_by_id("auth_type_1"));
				}
			}
		}
		if(is_true){
			if(obj == "wps"){
				get_by_id("wps_enable").value =="0";
			}
			return false;
		}
*/
		return true;
		
	}
	
	 function do_add_new_schedule(){
            window.location.href = "tools_schedules.asp";
     }
	
	function get_wlan0_vap1_schedule(obj){
		var tmp_schedule = obj.options[obj.selectedIndex].value;
		var schedule_val;
		var tmp_schedule_index = obj.selectedIndex;
		if(tmp_schedule == "Always"){
			schedule_val = "Always";
		}else if(tmp_schedule == "Never"){
			schedule_val = "Never";
		}else{
			var tmp_sch = (get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value).split("/");
                        schedule_val = tmp_sch[0];
		}
		get_by_id("wlan0_vap1_schedule").value = schedule_val;
	}
	
	function get_wlan1_vap1_schedule(obj){
		var tmp_schedule = obj.options[obj.selectedIndex].value;
		var schedule_val;
		var tmp_schedule_index = obj.selectedIndex;
		if(tmp_schedule == "Always"){
			schedule_val = "Always";
		}else if(tmp_schedule == "Never"){
			schedule_val = "Never";
		}else{
			var tmp_sch = (get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value).split("/");
                        schedule_val = tmp_sch[0];
		}

		get_by_id("wlan1_vap1_schedule").value = schedule_val;
	}
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
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
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
			<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
				<script>show_top("adv");</script>
			</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
		  <td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<UL>
									<script>show_left("Advance", 16);</script>
								</UL>
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			<input type="hidden" id="wps_default_pin" name="wps_default_pin" value="<!--# echo wps_generate_default_pin -->">
			<input type="hidden" id="wps_generate_pin" name="wps_generate_pin" value="<!--# echo wps_generate_pin -->">
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="guest_zone.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter+wireless">
				<input type="hidden" id="result_timer" name="result_timer" value="30">
				<input type="hidden" id="action" name="action" value="gzone_concurrent">
				<input type="hidden" id="wlan0_vap1_ssid" name="wlan0_vap1_ssid" value="<!--# echot wlan0_vap1_ssid -->">
				<input type="hidden" id="wlan1_vap1_ssid" name="wlan1_vap1_ssid" value="<!--# echot wlan1_vap1_ssid -->">
				<input type="hidden" id="wps_pin" name="wps_pin" value="<!--# echo wps_pin -->">
				<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">
				<input type="hidden" id="wlan0_vap1_wep_display" name="wlan0_vap1_wep_display" value="<!--# echo wlan0_vap1_wep_display -->">
				<input type="hidden" id="wlan1_vap1_wep_display" name="wlan1_vap1_wep_display" value="<!--# echo wlan1_vap1_wep_display -->">
				<input type="hidden" id="wlan0_vap1_schedule" name="wlan0_vap1_schedule" value="<!--# echo wlan0_vap1_schedule -->">
				<input type="hidden" id="wlan1_vap1_schedule" name="wlan1_vap1_schedule" value="<!--# echo wlan1_vap1_schedule -->">
				<input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
				
				<input type="hidden" id="apply" name="apply" value="0">                                    
				<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<!--# echo schedule_rule_00 -->">
				<input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<!--# echo schedule_rule_01 -->">
				<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<!--# echo lan_ipaddr -->">
				<input type="hidden" id="lan_netmask" name="lan_netmask" value="<!--# echo lan_netmask -->">
				<input type="hidden" id="wlan0_enable" name="wlan0_enable" value="<!--# echo wlan0_enable -->">
				<input type="hidden" id="wlan1_enable" name="wlan1_enable" value="<!--# echo wlan1_enable -->">

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
				  <div id="box_header"> 
						<h1><script>show_words(_guestzone)</script></h1>
						<p><script>show_words(guestzone_Intro_1)</script></p>
						<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2"type="button" class=button_submit value="" onclick="page_cancel('form1', 'guest_zone.asp');">
					    <script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
						<script>check_reboot();</script>
					</div>
					
					<div class="box"> 
						<h2><script>show_words(guestzone_title_1)</script></h2>
							
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr> 
              <td class="duple"><script>show_words(guestzone_enable)</script> :</td>
              <td>&nbsp; <input name="guest_zone_enable0" id="guest_zone_enable0" type="checkbox" onclick="check_host_zone()"  value="1"> 
                <input type="hidden" id="wlan0_vap1_enable" name="wlan0_vap1_enable" value="<!--# echo wlan0_vap1_enable -->">
                <select id="wlan0_vap1_schedule_select" name="wlan0_vap1_schedule_select" onChange="get_wlan0_vap1_schedule(this);">
                  <option value="Always" selected><script>show_words(_always)</script></option>
				 <option value="Never"><script>show_words(_never)</script></option>
					<script>document.write(set_schedule_option());</script>
                </select> 
				<input name="add_new_schedule" type="button" class="button_submit" id="add_new_schedule" onclick="do_add_new_schedule(true)" value="">
				<script>get_by_id("add_new_schedule").value = dlink_1_add_new;</script>
				</td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(wwl_band)</script> :</td>
              <td>&nbsp;&nbsp;<strong><script>show_words(GW_WLAN_RADIO_0_NAME)</script></strong></td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_NN)</script> :</td>
              <td width="340">&nbsp;&nbsp;&nbsp; <input name="show_ssid" type="text" id="show_ssid" size="20" maxlength="32" value="">
                <script>show_words(bwl_AS)</script> </td>
            </tr>
            <tr> 
          </table>
					
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr id="show_wlan0_wep"> 
              <td class="duple"><script>show_words(bws_SM)</script> :</td>
              <td width="340">&nbsp; <select id="wep_type" name="wep_type" onChange="show_wpa_wep()">
				<option value="0" selected><script>show_words(_none)</script></option>
				<option value="1"><script>show_words(_WEP)</script></option>
				<option value="2"><script>show_words(_WPApersonal)</script></option>
				<option value="3"><script>show_words(_WPAenterprise)</script></option>
                </select> </td>
            </tr>
          </table>
        </div>
							<input type="hidden" id="wlan0_vap1_security" name="wlan0_vap1_security" value="<!--# echo wlan0_vap1_security -->">
							<input type="hidden" id="asp_temp_57" name="asp_temp_57" value="<!--# echo asp_temp_57 -->">
							  <input type="hidden" id="asp_temp_58" name="asp_temp_58" value="<!--# echo asp_temp_58 -->">
							  <input type="hidden" id="asp_temp_59" name="asp_temp_59" value="<!--# echo asp_temp_59 -->">
							  <input type="hidden" id="asp_temp_60" name="asp_temp_60" value="<!--# echo asp_temp_60 -->">
					
					<div class="box" id="show_wep" style="display:none"> 
						<h2><script>show_words(_WEP)</script></h2>
						<p><script>show_words(bws_msg_WEP_1)</script></p>
						<p><script>show_words(bws_msg_WEP_2)</script></p>
						<p><script>show_words(bws_msg_WEP_3)</script></p>
			<table cellpadding="1" cellspacing="1" border="0" width="525">
							<input type="hidden" id="wlan0_vap1_wep64_key_1" name="wlan0_vap1_wep64_key_1" value="<!--# echot wlan0_vap1_wep64_key_1 -->">
							<input type="hidden" id="wlan0_vap1_wep128_key_1" name="wlan0_vap1_wep128_key_1" value="<!--# echot wlan0_vap1_wep128_key_1 -->">
							<input type="hidden" id="wlan0_vap1_wep64_key_2" name="wlan0_vap1_wep64_key_2" value="<!--# echot wlan0_vap1_wep64_key_2 -->">
							<input type="hidden" id="wlan0_vap1_wep128_key_2" name="wlan0_vap1_wep128_key_2" value="<!--# echot wlan0_vap1_wep128_key_2 -->">
							<input type="hidden" id="wlan0_vap1_wep64_key_3" name="wlan0_vap1_wep64_key_3" value="<!--# echot wlan0_vap1_wep64_key_3 -->">
							<input type="hidden" id="wlan0_vap1_wep128_key_3" name="wlan0_vap1_wep128_key_3" value="<!--# echot wlan0_vap1_wep128_key_3 -->">
							<input type="hidden" id="wlan0_vap1_wep64_key_4" name="wlan0_vap1_wep64_key_4" value="<!--# echot wlan0_vap1_wep64_key_4 -->">
							<input type="hidden" id="wlan0_vap1_wep128_key_4" name="wlan0_vap1_wep128_key_4" value="<!--# echot wlan0_vap1_wep128_key_4 -->">
								<tr> 
									<td class="duple"><script>show_words(bws_WKL)</script> :</td>
									<td width="340">&nbsp; 
									  <select id="wep_key_len" name="wep_key_len" size=1 onChange="change_wep_key_fun();">
										<option value="5"><script>show_words(bws_WKL_0)</script></option>
										<option value="13"><script>show_words(bws_WKL_1)</script></option>
									  </select> <script>show_words(bws_length)</script>
									</td>
							  	</tr>
								<tr id=show_wlan0_wep style="display:none">
									<td class="duple"><script>show_words(bws_DFWK)</script> :</td>
									<td width="340">&nbsp;
										<select id="wep_def_key" name="wep_def_key" onChange="ischeck_wps('wep');">
											<option value="1"><script>show_words(wepkey1)</script></option>
											<option value="2"><script>show_words(wepkey2)</script></option>
											<option value="3"><script>show_words(wepkey3)</script></option>
											<option value="4"><script>show_words(wepkey4)</script></option>
									  	</select>
										<input type="hidden" id="wlan0_vap1_wep_default_key" name="wlan0_vap1_wep_default_key" value="<!--# echot wlan0_vap1_wep_default_key -->">
									</td>
					  			</tr>
								<tr>
									<td class="duple"><script>show_words(auth)</script> :</td>
									<td width="340">&nbsp;
										<select name="auth_type" id="auth_type" onChange="ischeck_wps('auto');">
											<option value="auto"><script>show_words(_both)</script></option>
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
								<span id="show_resert2"></span>
								<span id="show_resert3"></span>
								<span id="show_resert4"></span>
								<!--tr>
									<td class="duple"><script>show_words(_wepkey2)</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert2"></span>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(_wepkey3)</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert3"></span>
									</td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(_wepkey4)</script> :</td>
									<td width="340">&nbsp;
										<span id="show_resert4"></span>
									</td>
								</tr-->
                  			</table>
					</div>
					<div class="box" id="show_wpa" style="display:none"> 
						<h2><script>show_words(_WPA)</script></h2>
          				<p><script>show_words(bws_msg_WPA)</script></p>
          				<p><script>show_words(bws_msg_WPA_2)</script></p>
						<input type="hidden" id="wlan0_vap1_psk_cipher_type" name="wlan0_vap1_psk_cipher_type" value="<!--# echo wlan0_vap1_psk_cipher_type -->">
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
										<select id="c_type" name="c_type" onChange="check_wps_psk_eap()">
											<option value="tkip"><script>show_words(bws_CT_1)</script></option>
											<option value="aes"><script>show_words(bws_CT_2)</script></option>
											<option value="both"><script>show_words(bws_CT_3)</script></option>
									  	</select>
									</td>
					  			</tr>
								<tr>
									<td class="duple"><script>show_words(bws_GKUI)</script> :</td>
									<td width="340">&nbsp;
										<input type="text" id="wlan0_vap1_gkey_rekey_time" name="wlan0_vap1_gkey_rekey_time" size="8" maxlength="5" value="<!--# echo wlan0_vap1_gkey_rekey_time -->"> <script>show_words(bws_secs)</script>
									</td>
								</tr>
                  			</table>
					</div>
					<div class="box" id="show_wpa_psk" style="display:none"> 
						<h2><script>show_words(_psk)</script></h2>
						<p class="box_msg"> 
						<script>show_words(KR18)</script>
						<script>show_words(KR19)</script>
					 	</p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple"><script>show_words(_psk)</script> :</td>
									<td width="340">&nbsp;<input type="password" id="wlan0_vap1_psk_pass_phrase" name="wlan0_vap1_psk_pass_phrase" size="40" maxlength="64" value="<!--# echot wlan0_vap1_psk_pass_phrase -->"></td>
					  			</tr>
							</table>
					</div>
					<div class="box" id="show_wpa_eap" style="display:none"> 
						<h2><script>show_words(bws_EAPx)</script></h2>
						<p class="box_msg"><script>show_words(bws_msg_EAP)</script>  </p>
                  			<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<input type="hidden" id="wlan0_vap1_eap_radius_server_0" name="wlan0_vap1_eap_radius_server_0" value="<!--# echo wlan0_vap1_eap_radius_server_0 -->">
									<input type="hidden" id="wlan0_vap1_eap_mac_auth" name="wlan0_vap1_eap_mac_auth" value="<!--# echo wlan0_vap1_eap_mac_auth -->">
							  		<td class="duple"><script>show_words(bwsAT_)</script> :</td>
							  		<td width="340">&nbsp;<input id="wlan0_vap1_eap_reauth_period" name="wlan0_vap1_eap_reauth_period" size=10 value="<!--# echo wlan0_vap1_eap_reauth_period -->"> <script>show_words(_minutes)</script></td>
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
							  		<td width="340">&nbsp;<input type="password" id="radius_pass1" name="radius_pass1" size="32" maxlength="64"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_RMAA)</script> :</td>
							  		<td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac1" name="radius_auth_mac1"></td>
					  			</tr>
								<tr id="radius2">
									<td colspan="2">
									<input type="button" id="advanced" name="advanced" value="" onClick="show_radius();">
									<script>get_by_id("advanced").value = _advanced+">>";</script> </td>
								</tr>
								<tr id="none_radius2" style="display:none">
									<td colspan="2"><input type="button" id="advanced_0" name="advanced_0" value="" onClick="show_radius();">
									<script>get_by_id("advanced_0").value = "<<"+_advanced;</script></td>
								</tr>
							</table>
                  			<table id="show_radius2" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
								<tr>
									<input type="hidden" id="wlan0_vap1_eap_radius_server_1" name="wlan0_vap1_eap_radius_server_1" value="<!--# echo wlan0_vap1_eap_radius_server_1 -->">
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
							  		<td width="340">&nbsp;<input type="password" id="radius_pass2" name="radius_pass2" size="32" maxlength="64"></td>
					  			</tr>
								<tr>
							  		<td class="duple"><script>show_words(bws_2RMAA)</script> :</td>
							  		<td width="340">&nbsp;<input type="checkbox" id="radius_auth_mac2" name="radius_auth_mac2"></td>
					  			</tr>
							</table>         
			</div>
			
			 <div class="box">
            <h2><script>show_words(guestzone_title_1)</script></h2>
            
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr> 
              <td class="duple"><script>show_words(guestzone_enable)</script> :</td>
              <td>&nbsp; <input name="guest_zone_enable1" id="guest_zone_enable1" type="checkbox" onclick="check_host_zone1()" value="1"> 
                <input type="hidden" id="wlan1_vap1_enable" name="wlan1_vap1_enable" value="<!--# echo wlan1_vap1_enable -->">
                <select id="wlan1_vap1_schedule_select" name="wlan1_vap1_schedule_select" onChange="get_wlan1_vap1_schedule(this);">
                  <option value="Always" selected><script>show_words(_always)</script></option>
				  <option value="Never"><script>show_words(_never)</script></option>
					<script>document.write(set_schedule_option());</script>
                </select> 
				<input name="add_new_schedule2" type="button" class="button_submit" id="add_new_schedule2" onclick="do_add_new_schedule(true)" value="">
				<script>get_by_id("add_new_schedule2").value = dlink_1_add_new;</script>
				</td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(wwl_band)</script> :</td>
              <td><strong>&nbsp;&nbsp;<script>show_words(GW_WLAN_RADIO_1_NAME)</script></strong></td>
            </tr>
            <tr> 
              <td class="duple"><script>show_words(bwl_NN)</script> :</td>
              <td width="340">&nbsp;&nbsp;&nbsp; <input name="show_ssid_1" type="text" id="show_ssid_1" size="20" maxlength="32" value="">
                <script>show_words(bwl_AS)</script> </td>
            </tr>
          </table>
          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr id="show_wlan1_wep"> 
              <td class="duple"><script>show_words(bws_SM)</script> :</td>
              <td width="340">&nbsp; <select id="wep_type_1" name="wep_type_1" onChange="show_wpa_wep_1()">
				<option value="0" selected><script>show_words(_none)</script></option>
				<option value="1"><script>show_words(_WEP)</script></option>
				<option value="2"><script>show_words(_WPApersonal)</script></option>
				<option value="3"><script>show_words(_WPAenterprise)</script></option>
                </select> </td>
            </tr>
          </table>
        </div>
          <input type="hidden" id="wlan1_vap1_security" name="wlan1_vap1_security" value="<!--# echo wlan1_vap1_security -->">
          <input type="hidden" id="asp_temp_61" name="asp_temp_61" value="<!--# echo asp_temp_61 -->">
          <input type="hidden" id="asp_temp_62" name="asp_temp_62" value="<!--# echo asp_temp_62 -->">
          <input type="hidden" id="asp_temp_63" name="asp_temp_63" value="<!--# echo asp_temp_63 -->">
          <input type="hidden" id="asp_temp_64" name="asp_temp_64" value="<!--# echo asp_temp_64 -->">
          
          <div class="box" id="show_wep_1" style="display:none"> 
            <h2><script>show_words(_WEP)</script></h2>
            <p><script>show_words(bws_msg_WEP_1)</script></p>
            <p><script>show_words(bws_msg_WEP_2)</script></p>
            <p><script>show_words(bws_msg_WEP_3)</script></p>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <input type="hidden" id="wlan1_vap1_wep64_key_1" name="wlan1_vap1_wep64_key_1" value="<!--# echo wlan1_vap1_wep64_key_1 -->">
              <input type="hidden" id="wlan1_vap1_wep128_key_1" name="wlan1_vap1_wep128_key_1" value="<!--# echo wlan1_vap1_wep128_key_1 -->">
              <input type="hidden" id="wlan1_vap1_wep64_key_2" name="wlan1_vap1_wep64_key_2" value="<!--# echo wlan1_vap1_wep64_key_2 -->">
              <input type="hidden" id="wlan1_vap1_wep128_key_2" name="wlan1_vap1_wep128_key_2" value="<!--# echo wlan1_vap1_wep128_key_2 -->">
              <input type="hidden" id="wlan1_vap1_wep64_key_3" name="wlan1_vap1_wep64_key_3" value="<!--# echo wlan1_vap1_wep64_key_3 -->">
              <input type="hidden" id="wlan1_vap1_wep128_key_3" name="wlan1_vap1_wep128_key_3" value="<!--# echo wlan1_vap1_wep128_key_3 -->">
              <input type="hidden" id="wlan1_vap1_wep64_key_4" name="wlan1_vap1_wep64_key_4" value="<!--# echo wlan1_vap1_wep64_key_4 -->">
              <input type="hidden" id="wlan1_vap1_wep128_key_4" name="wlan1_vap1_wep128_key_4" value="<!--# echo wlan1_vap1_wep128_key_4 -->">
              <tr> 
                <td class="duple"><script>show_words(bws_WKL)</script> :</td>
                <td width="340">&nbsp; 
				<select id="wep_key_len_1" name="wep_key_len_1" size=1 onChange="change_wep_key_fun_1();">
				<option value="5"><script>show_words(bws_WKL_0)</script></option>
				<option value="13"><script>show_words(bws_WKL_1)</script></option>
				</select> <script>show_words(bws_length)</script>
              </tr>
              <tr id=show_wlan1_wep style="display:none"> 
                <td class="duple"><script>show_words(bws_DFWK)</script> :</td>
                <td width="340">&nbsp; 
		<select id="wep_def_key_1" name="wep_def_key_1" onChange="ischeck_wps('wep');">
                    <option value="1"><script>show_words(wepkey1)</script></option>
		    <option value="2"><script>show_words(wepkey2)</script></option>
		    <option value="3"><script>show_words(wepkey3)</script></option>
		    <option value="4"><script>show_words(wepkey4)</script></option>
		</select> 
		<input type="hidden" id="wlan1_vap1_wep_default_key" name="wlan1_vap1_wep_default_key" value="<!--# echot wlan1_vap1_wep_default_key -->"> 
                </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(auth)</script> :</td>
                <td width="340">&nbsp; 
				   <select name="auth_type_1" id="auth_type_1" onChange="ischeck_wps('auto');">
					   <option value="auto"><script>show_words(_both)</script></option>
					   <option value="share"><script>show_words(bws_Auth_2)</script></option>
					</select> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(_wepkey1)</script> :</td>
                <td width="340">&nbsp; <span id="show_resert5"></span> </td>
              </tr>
              <span id="show_resert6"></span>
			<span id="show_resert7"></span>
			<span id="show_resert8"></span>
              <!--tr> 
                <td class="duple"><script>show_words(_wepkey2)</script> :</td>
                <td width="340">&nbsp; <span id="show_resert6"></span> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(_wepkey3)</script> :</td>
                <td width="340">&nbsp; <span id="show_resert7"></span> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(_wepkey4)</script> :</td>
                <td width="340">&nbsp; <span id="show_resert8"></span> </td>
              </tr-->
            </table>
          </div>
          <div class="box" id="show_wpa_1" style="display:none"> 
            <h2><script>show_words(_WPA)</script></h2>
          				<p><script>show_words(bws_msg_WPA)</script></p>
          				<p><script>show_words(bws_msg_WPA_2)</script></p>
            <input type="hidden" id="wlan1_vap1_psk_cipher_type" name="wlan1_vap1_psk_cipher_type" value="<!--# echo wlan1_vap1_psk_cipher_type -->">
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <td class="duple"><script>show_words(bws_WPAM)</script> :</td>
                <td width="340">&nbsp; <select id="wpa_mode_1" name="wpa_mode_1">
				<option value="auto"><script>show_words(bws_WPAM_2)</script></option>
				<option value="wpa2"><script>show_words(bws_WPAM_3)</script></option>
				<option value="wpa"><script>show_words(bws_WPAM_1)</script></option>
				</select> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_CT)</script> :</td>
                <td width="340">&nbsp; <select id="c_type_1" name="c_type_1" onChange="check_wps_psk_eap_1()">
					<option value="tkip"><script>show_words(bws_CT_1)</script></option>
					<option value="aes"><script>show_words(bws_CT_2)</script></option>
					<option value="both"><script>show_words(bws_CT_3)</script></option>
					</select> </td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_GKUI)</script> :</td>
                <td width="340">&nbsp; <input type="text" id="wlan1_vap1_gkey_rekey_time" name="wlan1_vap1_gkey_rekey_time" size="8" maxlength="5" value="<!--# echo wlan1_vap1_gkey_rekey_time -->">
                  <script>show_words(bws_secs)</script> </td>
              </tr>
            </table>
          </div>
          <div class="box" id="show_wpa_psk_1" style="display:none"> 
            <h2><script>show_words(_psk)</script></h2>
            <p class="box_msg"> 
			<script>show_words(KR18)</script>
			<script>show_words(KR19)</script>
			</p>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <td class="duple"><script>show_words(_psk)</script> :</td>
                <td width="340">&nbsp;
                  <input type="password" id="wlan1_vap1_psk_pass_phrase" name="wlan1_vap1_psk_pass_phrase" size="40" maxlength="64" value="<!--# echo wlan1_vap1_psk_pass_phrase -->"></td>
              </tr>
            </table>
          </div>
          <div class="box" id="show_wpa_eap_1" style="display:none"> 
            <h2><script>show_words(bws_EAPx)</script></h2>
            <p class="box_msg"><script>show_words(bws_msg_EAP)</script> </p>
            <table cellpadding="1" cellspacing="1" border="0" width="525">
              <tr> 
                <input type="hidden" id="wlan1_vap1_eap_radius_server_0" name="wlan1_vap1_eap_radius_server_0" value="<!--# echo wlan1_vap1_eap_radius_server_0 -->">
                <input type="hidden" id="wlan1_vap1_eap_mac_auth" name="wlan1_vap1_eap_mac_auth" value="<!--# echo wlan1_vap1_eap_mac_auth -->">
                <td class="duple"><script>show_words(bwsAT_)</script> :</td>
                <td width="340">&nbsp;
                  <input id="wlan1_vap1_eap_reauth_period" name="wlan1_vap1_eap_reauth_period" size=10 value="<!--# echo wlan1_vap1_eap_reauth_period -->">
                  <script>show_words(_minutes)</script></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_RIPA)</script> :</td>
                <td width="340">&nbsp;
                  <input id="radius_ip1_1" name="radius_ip1_1" maxlength=15 size=15></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_RSP)</script> :</td>
                <td width="340">&nbsp;
                  <input type="text" id="radius_port1_1" name="radius_port1_1" size="8" maxlength="5" value="1812"></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_RSSs)</script> :</td>
                <td width="340">&nbsp;
                  <input type="password" id="radius_pass1_1" name="radius_pass1_1" size="32" maxlength="64"></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_RMAA)</script> :</td>
                <td width="340">&nbsp;
                  <input type="checkbox" id="radius_auth_mac1_1" name="radius_auth_mac1_1"></td>
              </tr>
              <tr id="radius2_1"> 
                <td colspan="2"><input type="button" id="advanced_1" name="advanced_1" value="" onClick="show_radius_1();">
				<script>get_by_id("advanced_1").value = _advanced+">>";</script></td>
              </tr>
              <tr id="none_radius2_1" style="display:none"> 
                <td colspan="2"><input type="button" id="advanced_2" name="advanced_2" value="" onClick="show_radius_1();">
				<script>get_by_id("advanced_2").value = "<<"+_advanced;</script></td>
              </tr>
            </table>
            <table id="show_radius2_1" cellpadding="1" cellspacing="1" border="0" width="525" style="display:none">
              <tr> 
                <input type="hidden" id="wlan1_vap1_eap_radius_server_1" name="wlan1_vap1_eap_radius_server_1" value="<!--# echo wlan1_vap1_eap_radius_server_1 -->">
                <td class="box_msg" colspan="2"><script>show_words(bws_ORAD)</script> 
                  :</td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_2RIPA)</script> :</td>
                <td width="340">&nbsp;
                  <input id="radius_ip2_1" name="radius_ip2_1" maxlength=15 size=15></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_2RSP)</script> :</td>
                <td width="340">&nbsp;
                  <input type="text" id="radius_port2_1" name="radius_port2_1" size="8" maxlength="5" value="1812"></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_2RSSS)</script> :</td>
                <td width="340">&nbsp;
                  <input type="password" id="radius_pass2_1" name="radius_pass2_1" size="32" maxlength="64"></td>
              </tr>
              <tr> 
                <td class="duple"><script>show_words(bws_2RMAA)</script> :</td>
                <td width="340">&nbsp;
                  <input type="checkbox" id="radius_auth_mac2_1" name="radius_auth_mac2_1"></td>
              </tr>
            </table>
          </div>
    <div class="box" id="show_routing"> <!-- routing setting -->
	<h2><script>show_words(bln_title_Rtrset +" "+ mbssid_for_gzone)</script></h2>
	<script>show_words(mbssid_route_info);</script>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
	    <tr>
              <td class="duple"><script>show_words(S473)</script> :</td>
              <td>&nbsp; <input name="guest_select_0" id="guest_select_0" type="checkbox"  value="1"> 
            </tr>
                <input type="hidden" id="wlan0_vap_guest_zone" name="wlan0_vap_guest_zone" value="<!--# echo wlan0_vap_guest_zone -->">
                <input type="hidden" id="asp_temp_65" name="asp_temp_65" value="<!--# echo asp_temp_65 -->"></td>
		<tr>
		  <td class="duple"><script>show_words(_ripaddr);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="gzone_ipaddr" type="text" id="gzone_ipaddr" size="20" maxlength="15" onChange="check_dhcp_range()" value="<!--# echo gzone_ipaddr -->"></td>
		</tr>
		<tr>
		  <td class="duple"><script>show_words(_subnet);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="gzone_netmask" type="text" id="gzone_netmask" size="20" maxlength="15" onChange="check_dhcp_range()" value="<!--# echo gzone_netmask -->"></td>
		</tr>
	  </table>
    </div> <!-- End routing_setting -->
    <div class="box" id="show_dhcp"> <!-- dhcp server setting -->
	<h2><script>show_words(dhcp_set_for +" "+  mbssid_for_gzone)</script></h2>
	<script>show_words(mbssid_dhcp_info);</script>
	    <table cellpadding="1" cellspacing="1" border="0" width="525">
		<tr>
		  <td class="duple"><script>show_words(bd_EDSv);</script> :</td>
		  <td width="340">&nbsp;
			<input name="dhcpsvr" type=checkbox id="dhcpsvr" onClick="disable_ip()" value="1">
			<input type="hidden" id="gzone_dhcpd_enable" name="gzone_dhcpd_enable" value="<!--# echo gzone_dhcpd_enable -->">
		  </td>
		</tr>														
		<tr>
		  <td class="duple"><script>show_words(bd_DIPAR);</script> :</td>
		  <td width="340">&nbsp;&nbsp;
			<input name="gzone_dhcpd_start" type="text" id="gzone_dhcpd_start" size="20" maxlength="15" value="<!--# echo gzone_dhcpd_start -->">
			&nbsp;to&nbsp;
			<input name="gzone_dhcpd_end" type="text" id="gzone_dhcpd_end" size="20" maxlength="15" value="<!--# echo gzone_dhcpd_end -->">
		  </td>
		</tr>
		<tr>
		  <td class="duple"><script>show_words(bd_DLT);</script> :</td>
		  <td width="340">&nbsp;&nbsp;&nbsp;<input name="gzone_dhcpd_lease_time" type="text" id="gzone_dhcpd_lease_time" size="20" maxlength="15" value="<!--# echo gzone_dhcpd_lease_time -->">(<script>show_words(gw_mins);</script>)</td>
		</tr>
	  </table>
    </div> <!-- End dhcp server setting -->
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
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<script>
onPageLoad();
</script>    
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>reboot_needed(left["Setup"].link[1]);</script>
</html>
