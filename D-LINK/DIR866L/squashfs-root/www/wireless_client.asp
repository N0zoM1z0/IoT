<html>
<head>
<title>D-LINK CORPORATION | WIRELESS AP | SETUP</title>
<meta http-equiv="REFRESH" content="200;URL=/wireless.asp">
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
	    
var wlan_idx= 0;
var check_push=0;
function loadSettings()
{
	var test_value = get_by_id("dhcp_list").value;
	set_selectIndex("<!--# echo wlan0_dot11_mode -->", get_by_id("dot11_mode"));
	set_selectIndex("<!--# echo wlan0_11n_protection -->", get_by_id("11n_protection"));
	set_selectIndex("<!--# echo wlan0_op_mode -->", get_by_id("tmp_mode"));	
	var wlan0_op_mode = "<!--# echo wlan0_op_mode -->";
	
	if(wlan0_op_mode=="AP")
	get_by_id("tmp_mode").selectedIndex==0;
	else
	get_by_id("tmp_mode").selectedIndex==1;
	
	//channel combo box status	
	if(get_by_id("wlan0_auto_channel_enable").value=="1")
		get_by_id("auto_channel_enable").checked=true;
	else
		get_by_id("auto_channel_enable").checked=false;
	set_disablechan();		
	
	//hidden ssid	
	if(get_by_id("wlan0_ssid_broadcast").value=="0")
		get_by_id("ssid_broadcast").checked=true;
	else
		get_by_id("ssid_broadcast").checked=false;
	
	// 2.4G/5G Mode
	set_checked("<!--# echo wlan0_radio_mode -->", get_by_name("wlan0_radio_mode"));

	var wlan0_security= get_by_id("wlan0_security").value;
	var authType=get_by_id("authType");
	var authType_t=get_by_id("authType_t");
	var length0=get_by_id("length0");
	var eap_type = get_by_id("eap_type");
	
	if(wlan0_security == "disable"){
		authType.selectedIndex=0;
	}else if(wlan0_security == "wep_open_64"){
		authType.selectedIndex=1;
		authType_t.selectedIndex=0;
		length0.selectedIndex=0;
	}else if(wlan0_security == "wep_open_128"){
		authType.selectedIndex=1;
		authType_t.selectedIndex=0;
		length0.selectedIndex=1;
	}else if(wlan0_security == "wep_share_64"){
		authType.selectedIndex=1;
		authType_t.selectedIndex=1;
		length0.selectedIndex=0;
	}else if(wlan0_security == "wep_share_128"){
		authType.selectedIndex=1;
		authType_t.selectedIndex=1;
		length0.selectedIndex=1;
	}else if(wlan0_security == "wpa_psk"){
		authType.selectedIndex=2;
		
	}else if(wlan0_security == "wpa_eap"){
		authType.selectedIndex=2;
		
	}else if(wlan0_security == "wpa2_psk"){
		authType.selectedIndex=3;
		
	}else if(wlan0_security == "wpa2_eap"){
		authType.selectedIndex=3;
		
	}else if(wlan0_security == "wpa2auto_psk"){
		authType.selectedIndex=4;
		
	}else if(wlan0_security == "wpa2auto_eap"){
		authType.selectedIndex=4;
		
	}
	//WEP type
	set_selectIndex("<!--# echo wlan0_wep_display -->", get_by_id("wlan0_wep_display"));
	
	set_selectIndex("<!--# echo wlan0_wep_default_key -->",get_by_id("wlan0_wep_default_key"));
	
	//wep key
	init_key_value(); 
	 //radius
	var temp_r0 = get_by_id("wlan0_eap_radius_server_0").value;
	var Dr0 = temp_r0.split("/");
	if(Dr0.length>1)
	{
		get_by_id("radiusIP0").value=Dr0[0];
		get_by_id("radiusPort0").value=Dr0[1];
		get_by_id("radiusPass0").value=Dr0[2];
	}

	var temp_r1 = get_by_id("wlan0_eap_radius_server_1").value;
	var Dr1 = temp_r1.split("/");
	if(Dr1.length>1)
	{
		get_by_id("radius2IP0").value=Dr1[0];
		get_by_id("radius2Port0").value=Dr1[1];
		get_by_id("radius2Pass0").value=Dr1[2];
	}
                  
	//wps state		
	if(get_by_id("wps_enable").value=="1")
		get_by_id("checkbox_wps_enable").checked=true;
	else
		get_by_id("checkbox_wps_enable").checked=false;
	
	if(get_by_id("wps_lock").value=="1")
		get_by_id("checkbox_wps_lock").checked=true;	
	else
	 	get_by_id("checkbox_wps_lock").checked=false;	
	checkWPSstate(1)
	set_channel();	 	
	
}
function init_key_value()
{
	var key_length = get_by_id("length0").value;
	var key_format = get_by_id("wlan0_wep_display").value;

	if(key_length=="64")
	{
		if(key_format=="ascii")
		{
			get_by_id("key1").value = "<!--# echo wlan0_wep64_key_1","ascii -->";
			get_by_id("key2").value = "<!--# echo wlan0_wep64_key_2","ascii -->";
			get_by_id("key3").value = "<!--# echo wlan0_wep64_key_3","ascii -->";
			get_by_id("key4").value = "<!--# echo wlan0_wep64_key_4","ascii -->";
		}
		else
		{
			get_by_id("key1").value = "<!--# echo wlan0_wep64_key_1","hex -->";
			get_by_id("key2").value = "<!--# echo wlan0_wep64_key_2","hex -->";
			get_by_id("key3").value = "<!--# echo wlan0_wep64_key_3","hex -->";
			get_by_id("key4").value = "<!--# echo wlan0_wep64_key_4","hex -->";
		}
	}
	else
	{
		if(key_format=="ascii")
		{
			get_by_id("key1").value = "<!--# echo wlan0_wep128_key_1","ascii -->";
			get_by_id("key2").value = "<!--# echo wlan0_wep128_key_2","ascii -->";
			get_by_id("key3").value = "<!--# echo wlan0_wep128_key_3","ascii -->";
			get_by_id("key4").value = "<!--# echo wlan0_wep128_key_4","ascii -->";
		}
		else
		{
			get_by_id("key1").value = "<!--# echo wlan0_wep128_key_1","hex -->";
			get_by_id("key2").value = "<!--# echo wlan0_wep128_key_2","hex -->";
			get_by_id("key3").value = "<!--# echo wlan0_wep128_key_3","hex -->";
			get_by_id("key4").value = "<!--# echo wlan0_wep128_key_4","hex -->";
		}
	}
}

/* DUB-2540 */
/*
function set_channel(){
	var channel_list = "<!--# echo wlan0_channel_list -->";
	var current_channel = <!--# echo wlan0_channel -->;
	var ch = channel_list.split(",");
	var obj = get_by_id("wlan0_channel");
	var count = 0;

	if(current_channel="") {

	}	

	for (var i = 0; i < ch.length; i++){			
		var ooption = document.createElement("option");
		ooption.text = ch[i];
		ooption.value = ch[i];
		obj.options[count++] = ooption;
		if (ch[i] == current_channel){
			ooption.selected = true;
		}
	}
}
*/
	function set_channel(){
		var channel_list = "<!--# echo wlan0_channel_list -->";
		//var channel_list = "<!--# echo wlan0_channel_list -->";
		var current_channel = "<!--# echo wlan0_channel -->";
		var ch = channel_list.split(",");
		var ch_text = new Array("2.412","2.417","2.422","2.427","2.432","2.437","2.442","2.447","2.452","2.457","2.462","2.467","2.472");
//		var obj = get_by_id("sel_wlan0_channel");
		var obj = get_by_id("wlan0_channel");
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

function check_wpa(){
    var psk_value = get_by_id("wlan0_psk_pass_phrase").value;
    var eap_type = get_by_id("eap_type");
    var authType = get_by_id("authType");
    var mode = get_by_id("mode0");
    var radiusIP = get_by_id("radiusIP0");
    var radiusPort = get_by_id("radiusPort0");
    var radiusPass = get_by_id("radiusPass0");
	var ip = "<% getInfo("ip-rom -->";
	var gateway = "<% getInfo("gateway-rom -->";
	var mask = "<% getInfo("mask-rom -->";
	var radio1_ip = radiusIP.value;
	var tmp_ip = ip.split(".");
	var tmp_gateway = gateway.split(".");
	var tmp_mask = mask.split(".");
	var tmp_radio1_ip = radio1_ip.split(".");

    if((mode.selectedIndex!=2)&&((authType.selectedIndex!=0)&&(authType.selectedIndex!=1)))
	{
		if (eap_type.selectedIndex==0)
		{
			if (psk_value.length < 8)
			{                   
				alert("The length of PSK Key must be at least 8 characters.");
				return false;
			}
			else if (psk_value.length == 64)
			{
				for (var i=0; i<psk_value.length; i++) 
				{
					if ( (psk_value.charAt(i) >= '0' && psk_value.charAt(i) <= '9') ||
						(psk_value.charAt(i) >= 'a' && psk_value.charAt(i) <= 'f') ||
						(psk_value.charAt(i) >= 'A' && psk_value.charAt(i) <= 'F') )
						continue;
	
					alert("Invalid PSK key value. It should be in hex number (0-9 or a-f).");
					return false;
				}
			}
			else if(psk_value != get_by_id("pskValueCfm0").value) 
			{
				alert("The passphrase mismatch.");
				return false;
			}
			else if (psk_value.length > 63)
			{
				alert("We can only save 63 charachers"  );
				get_by_id("wlan0_psk_pass_phrase").value = psk_value.substring(0, 63);
			}
		}
		else if (eap_type.selectedIndex==1)
		{
			if(get_by_id("checkbox_wps_enable").checked)
			{
		    		if(authType.selectedIndex == 2)
		    		{
                    			alert("Can't choose WPA-Enterprise when WPS is enabled!");
                    		}
 		    		else if(authType.selectedIndex == 3)
		    		{
                    			alert("Can't choose WPA2-Enterprise when WPS is enabled!");
                    		}
		    		else if(authType.selectedIndex == 4)
		    		{
                    			alert("Can't choose WPA2-Auto-Enterprise when WPS is enabled!");
                    		}
                    		return false;
			}
           	if (radiusIP.value == "" || radiusIP.value == "0.0.0.0")
			{
				alert("The <script>show_words(_ipaddr);</script> of Radius Server 1 can not be empty or 0.0.0.0.");
				return false;
			}
			else if (radiusPort.value == "")
			{
				alert("The port of Radius Server 1 can not be empty.");
				return false;
			}
			else if (radiusPass.value == "")
			{
				alert("The Shared Secret of Radius Server 1 can not be empty.");
				return false;
			}        
                
			if(tmp_radio1_ip.length == 4)
			{
				for(var i = 0; i < 4; i++)
				{
					if((tmp_ip[i] & tmp_mask[i])!=(tmp_radio1_ip[i] & tmp_mask[i]))
					{
						if(gateway == "0.0.0.0")
						{
							alert("Please make sure the Gateway IP is configured properly!");
							return false;
						}
					}
				}
			}
			else
			{
				alert("The <script>show_words(_ipaddr);</script> of Radius Server 1 is error!");
				return false;
			}
		
		}
    }
    return true;     
}

function check_ssid()
{
   var ssid = get_by_id("wlan0_ssid");
   var mode = get_by_id("mode0");
  
  if ((mode.selectedIndex!=2)&&(ssid.value=="")) {
	alert('SSID cannot be empty!');
	ssid.value = ssid.defaultValue;
	ssid.focus();
	return false;
   }
   return true;
}

function validateKey_wep(idx, str, len)
{
	var defaultTxKeyId = get_by_id("wlan0_wep_default_key");
	var format = get_by_id("wlan0_wep_display");
 
	if (idx >= 0) {
		if (defaultTxKeyId.selectedIndex==idx && str.length==0) {
			alert('The encryption key you selected as the \'Tx Default Key\' cannot be blank.');
			return 0;
		}
		if (str.length !=0) {
			if ( str.length != len) {
				idx++;
				alert('Invalid length of Key ' + idx + ' value. It should be ' + len + ' characters.');
				return 0;
			}
		}
	}else {
		if ( str.length != len) {
			alert('Invalid length of WEP Key value. It should be ' + len + ' characters.');
			return 0;
		}
	}

	if (format.selectedIndex==0)
		return 1;

	for (var i=0; i<str.length; i++) {
		if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
		     (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
		     (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') ) {
			continue;
		}
		alert("Invalid key value. It should be in hex number (0-9 or a-f).");
		return 0;
	}

	return 1;
}

function saveChanges_wep()
{
	var keyLen;
	var mode = get_by_id("mode0");
	var length = get_by_id("length0");
	var format = get_by_id("wlan0_wep_display");
	var authType = get_by_id("authType");
	var key1 = get_by_id("key1");
	var key2 = get_by_id("key2");
	var key3 = get_by_id("key3");
	var key4 = get_by_id("key4");

	if ((mode.selectedIndex!=2) && (authType.selectedIndex==1)) {
		if (length.selectedIndex==0) {
			if ( format.selectedIndex == 0)
				keyLen = 5;
			else
				keyLen = 10;
		}else {
			if ( format.selectedIndex == 0)
				keyLen = 13;
			else
				keyLen = 26;
		}
		
		if (validateKey_wep(0,key1.value, keyLen)==0) {
			key1.focus();
			return false;
		}
		if (validateKey_wep(1,key2.value, keyLen)==0) {
			key2.focus();
			return false;
		}
		if (validateKey_wep(2,key3.value, keyLen)==0) {
			key3.focus();
			return false;
		}
		if (validateKey_wep(3,key4.value, keyLen)==0) {
			key4.focus();
			return false;
		}
	}
	return true;
}

function wds_validate_Passphrase(str)
{
  if (str.length < 8) {
	alert('Invalid length : length must be over 8 characters.');
  	return 0;
  }  
  if (str.length > 63) {
	alert('Invalid length : the max. length is 63 characters.');
  	return 0;
  }  
  return 1;
}

function wds_validateKey_wep(str, len)
{
  var format = get_by_id("wdsformat0");

  if (str.length ==0) {
	alert('Invalid length of Key value. It cannot be blank.');
  	return 0;
  }  
  if ( str.length != len) {
	alert('Invalid length of Key value. It should be ' + len + ' characters.');
	return 0;
  }

  if (format.selectedIndex==0)
       return 1;

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert("Invalid key value. It should be in hex number (0-9 or a-f).");
	return 0;
  }

  return 1;
}

function wds_saveChanges_wep()
{
  var keyLen;
  var mode = get_by_id("mode0");
  var encrypt = get_by_id("encrypt0");
  var format = get_by_id("wdsformat0");
  var wepKey = get_by_id("wepKey0");
  var wdspskValue = get_by_id("wdspskValue0");

  if(mode.selectedIndex==2 || mode.selectedIndex==3)
  {
    if (encrypt.selectedIndex == 1) {
  	    if ( format.selectedIndex == 0)
		    keyLen = 5;
	    else
		    keyLen = 10;
    }
    else if (encrypt.selectedIndex == 2) {
  	    if ( format.selectedIndex == 0)
		    keyLen = 13;
	    else
		    keyLen = 26;
    }
    else if (encrypt.selectedIndex == 0)
        return true;
    else
    {
        if(wds_validate_Passphrase(wdspskValue.value)==0)
	    {
	        wdspskValue.focus();
	        return false;
	    }
	    return true;
    }
        
    if (wds_validateKey_wep(wepKey.value, keyLen)==0) {
	    wepKey.focus();
	    return false;
    }
   }

  return true;
}

function wds_saveChanges_mac()
{
	var wlanWdsGetNum = 0;
	var mode = get_by_id("mode0");
	
	if(mode.selectedIndex==2 || mode.selectedIndex==3)
	{
		for (var i=1; i<=6; i++)
		{
			str_mac = "wdsMac"+i+wlan_idx;
			str = get_by_id(str_mac).value;
			if(str.length == 0) continue;
			if(str.length != 12) 
			{
				get_by_id(str_mac).focus();
				alert('Invalid length of MAC address.');
				return false;
			}
			for (var j=0; j<str.length; j++) {
				if ( (str.charAt(j) >= '0' && str.charAt(j) <= '9') ||
					(str.charAt(j) >= 'a' && str.charAt(j) <= 'f') ||
					(str.charAt(j) >= 'A' && str.charAt(j) <= 'F') )
					continue;
				get_by_id(str_mac).focus();
			alert("Invalid mac value. It should be in hex number (0-9 or a-f).");
			return false;
			}
		}
	}
	return true;
}

function bssid2join_mac()
{
  var wlanWdsGetNum = 0;
  var mode = get_by_id("mode0");

  if(mode.selectedIndex==1 || mode.selectedIndex==4)
  {
        str = get_by_id("Bssid2Join").value;
        if(str.length == 0) return true;
        if(str.length != 12) 
        {
            get_by_id("Bssid2Join").focus();
            alert('Invalid length of MAC address.');
            return false;
        }
        for (var j=0; j<str.length; j++) {
            if ( (str.charAt(j) >= '0' && str.charAt(j) <= '9') ||
        	(str.charAt(j) >= 'a' && str.charAt(j) <= 'f') ||
			(str.charAt(j) >= 'A' && str.charAt(j) <= 'F') )
				continue;
            get_by_id("Bssid2Join").focus();
	        alert("Invalid mac value. It should be in hex number (0-9 or a-f).");
	        return false;
        }
    }
    return true;
}

function send_request()
{
	if (check_ssid() && saveChanges_wep() && wds_saveChanges_wep() && wds_saveChanges_mac() && check_wpa() && bssid2join_mac() && check_wps())
	{
		//wireless mode
		if(get_by_id("tmp_mode").selectedIndex==0)
			get_by_id("wlan0_op_mode").value = "AP";
		if(get_by_id("tmp_mode").selectedIndex==1)
			get_by_id("wlan0_op_mode").value = "APC";
		//Mode
		var dot11_mode =get_by_id("dot11_mode");

		if(dot11_mode.selectedIndex==0)
			get_by_id("wlan0_dot11_mode").value = "11b";
		if(dot11_mode.selectedIndex==1)
			get_by_id("wlan0_dot11_mode").value = "11g";
		if(dot11_mode.selectedIndex==2)
			get_by_id("wlan0_dot11_mode").value = "11n";
		if(dot11_mode.selectedIndex==3)
			get_by_id("wlan0_dot11_mode").value ="11bg";
		if(dot11_mode.selectedIndex==4)
			get_by_id("wlan0_dot11_mode").value ="11gn";			
		if(get_by_id("dot11_mode").selectedIndex==5)
			get_by_id("wlan0_dot11_mode").value = "11bgn";		
		//var wlan0_dot11_mode = get_by_id("dot11_mode").value;
		
		// 2.4G / 5G
//		var wlan0_radio_mode = get_by_id("wlan0_radio_mode").value;

		//auto channel
		if(get_by_id("auto_channel_enable").checked)
			get_by_id("wlan0_auto_channel_enable").value="1";
		else
			get_by_id("wlan0_auto_channel_enable").value="0";

		//ssid brocast		
		if(get_by_id("ssid_broadcast").checked)
			get_by_id("wlan0_ssid_broadcast").value="0";
		else
			get_by_id("wlan0_ssid_broadcast").value="1";
		//security		
		var authType=get_by_id("authType");		
		if(authType.selectedIndex==0)
			get_by_id("wlan0_security").value="disable";
		else if(authType.selectedIndex==1)
			get_by_id("wlan0_security").value = "wep_"+ get_by_id("authType_t").value +"_"+ get_by_id("length0").value; 
		else if(authType.selectedIndex==2)
		{			
			if(get_by_id("eap_type").selectedIndex==0)
				get_by_id("wlan0_security").value = "wpa_psk";
			else 
				get_by_id("wlan0_security").value = "wpa_eap";
		}
		else if(authType.selectedIndex==3)
		{
			if(get_by_id("eap_type").selectedIndex==0)
				get_by_id("wlan0_security").value = "wpa2_psk";
			else if(eap_type.selectedIndex==1)
				get_by_id("wlan0_security").value = "wpa2_eap";
		}
		else if(authType.selectedIndex==4)
		{
			if(get_by_id("eap_type").selectedIndex==0)
				get_by_id("wlan0_security").value = "wpa2auto_psk";
			else if(get_by_id("eap_type").selectedIndex==1)
				get_by_id("wlan0_security").value = "wpa2auto_eap";
		}		
		
		//configure/ not configure
	if (get_by_id("wlan0_ssid").value != "dlink" || get_by_id("authType").value != "0"){

                        get_by_id("wps_configured_mode").value = 5;
                        <!--get_by_id("wps_lock").value = 1;-->
                }else{
                        get_by_id("wps_configured_mode").value = 1;

	
	  }
		
		
		
		//HT 20/40
		get_by_id("wlan0_11n_protection").value = get_by_id("11n_protection").value;
		
		//wep key
		var key_length = get_by_id("length0").selectedIndex;		
		send_key_value(key_num_array[key_length]);
		//cipher type
		send_cipher_value();
		
		//radius server
		if(get_by_id("eap_type").selectedIndex==1)
		{
			var r_ip_0 = get_by_id("radiusIP0").value;
			var r_port_0 = get_by_id("radiusPort0").value;
			var r_pass_0 = get_by_id("radiusPass0").value;
			var dat0 = r_ip_0 +"/"+ r_port_0 +"/"+ r_pass_0;
			get_by_id("wlan0_eap_radius_server_0").value = dat0;
	
			var r_ip_1 = get_by_id("radius2IP0").value;
			var r_port_1 = get_by_id("radius2Port0").value;
			var r_pass_1 = get_by_id("radius2Pass0").value;
			var dat1 = r_ip_1 +"/"+ r_port_1 +"/"+ r_pass_1;
			get_by_id("wlan0_eap_radius_server_1").value = dat1;
		}
		//wps enable
		if(get_by_id("checkbox_wps_enable").checked)
			get_by_id("wps_enable").value=1;
		else
			get_by_id("wps_enable").value=0;
			
		if(get_by_id("checkbox_wps_lock").checked)
			get_by_id("wps_lock").value=1;	
		else
	 		get_by_id("wps_lock").value=0;		
		
		return true;
	}
	else
	{
		return false;
	}
}
function send_key_value(key_length){
		
		get_by_id("wlan0_wep"+ key_length +"_key_1").value = get_by_id("key1").value;
		get_by_id("wlan0_wep"+ key_length +"_key_2").value = get_by_id("key2").value;
		get_by_id("wlan0_wep"+ key_length +"_key_3").value = get_by_id("key3").value;
		get_by_id("wlan0_wep"+ key_length +"_key_4").value = get_by_id("key4").value;
		/*
		get_by_id("asp_temp_37").value = get_by_id("wlan0_wep"+ key_length +"_key_1").value;
		get_by_id("asp_temp_38").value = get_by_id("wlan0_wep"+ key_length +"_key_2").value;
		get_by_id("asp_temp_39").value = get_by_id("wlan0_wep"+ key_length +"_key_3").value;
		get_by_id("asp_temp_40").value = get_by_id("wlan0_wep"+ key_length +"_key_4").value;
		*/
	}

	    function show_chan_width(){
 		var mode = get_by_id("dot11_mode").selectedIndex;	
		
		switch(mode){
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

function WdsMacList()
{
    var wlanWdsNum;// = <% getIndexValue("wlanWdsNum -->;
    var mode = get_by_id("mode0");
    var wdsMac1 = get_by_id("wdsMac10");
    var wdsMac2 = get_by_id("wdsMac20");
    var wdsMac3 = get_by_id("wdsMac30");
    var wdsMac4 = get_by_id("wdsMac40");
    var wdsMac5 = get_by_id("wdsMac50");
    var wdsMac6 = get_by_id("wdsMac60");
    //var wdsMac7 = get_by_id("wdsMac70");
    //var wdsMac8 = get_by_id("wdsMac80");
    
    if(wlanWdsNum==0) return 1;
    
    if((mode.selectedIndex == 2) || (mode.selectedIndex == 3))
    {
            var i=0;
            var str = "<% getInfo("wlanWdsMac -->";
            if(wlanWdsNum>=1) 
                wdsMac1.value = str.substring(12*i,12*i+12);
            i++;
            if(wlanWdsNum>=2) 
                wdsMac2.value = str.substring(12*i,12*i+12);
            i++;
            if(wlanWdsNum>=3) 
                wdsMac3.value = str.substring(12*i,12*i+12);
            i++;
            if(wlanWdsNum>=4) 
                wdsMac4.value = str.substring(12*i,12*i+12);
            i++;
            if(wlanWdsNum>=5) 
                wdsMac5.value = str.substring(12*i,12*i+12);
            i++;
            if(wlanWdsNum>=6) 
                wdsMac6.value = str.substring(12*i,12*i+12);
            i++;
            //if(wlanWdsNum>=7) 
            //    wdsMac7.value = str.substring(12*i,12*i+12);
            //i++;
            //if(wlanWdsNum>=8) 
            //    wdsMac8.value = str.substring(12*i,12*i+12);
            //i++;
    }
}

function setDefaultKeyValue()
{	
	var format = get_by_id("wlan0_wep_display");
	var length = get_by_id("length0");
	var key1 = get_by_id("key1");
	var key2 = get_by_id("key2");
	var key3 = get_by_id("key3");
	var key4 = get_by_id("key4");

	if (length.selectedIndex == 0) {
		if ( format.selectedIndex == 0) {
			key1.maxLength = 5;
			key2.maxLength = 5;
			key3.maxLength = 5;
			key4.maxLength = 5;

			key1.value = "<!--# echo wlan0_wep64_key_1","ascii -->";
			key2.value = "<!--# echo wlan0_wep64_key_2","ascii -->";
			key3.value = "<!--# echo wlan0_wep64_key_3","ascii -->";
			key4.value = "<!--# echo wlan0_wep64_key_4","ascii -->";
		}else {
			key1.maxLength = 10;
			key2.maxLength = 10;
			key3.maxLength = 10;
			key4.maxLength = 10;
			
			key1.value = "<!--# echo wlan0_wep64_key_1","hex -->";
			key2.value = "<!--# echo wlan0_wep64_key_2","hex -->";
			key3.value = "<!--# echo wlan0_wep64_key_3","hex -->";
			key4.value = "<!--# echo wlan0_wep64_key_4","hex -->";
		}
	}else {
		if ( format.selectedIndex == 0) {
			key1.maxLength = 13;
			key2.maxLength = 13;
			key3.maxLength = 13;
			key4.maxLength = 13;
			
			key1.value = "<!--# echo wlan0_wep128_key_1","ascii -->";
			key2.value = "<!--# echo wlan0_wep128_key_2","ascii -->";
			key3.value = "<!--# echo wlan0_wep128_key_3","ascii -->";
			key4.value = "<!--# echo wlan0_wep128_key_4","ascii -->";
		}else {
			key1.maxLength = 26;
			key2.maxLength = 26;
			key3.maxLength = 26;
			key4.maxLength = 26;

			key1.value = "<!--# echo wlan0_wep128_key_1","hex -->";
			key2.value = "<!--# echo wlan0_wep128_key_2","hex -->";
			key3.value = "<!--# echo wlan0_wep128_key_3","hex -->";
			key4.value = "<!--# echo wlan0_wep128_key_4","hex -->";
		}
	}
}

function updateFormat()
{
	var format = get_by_id("wlan0_wep_display");
	<% setKeyTypeSelect("keyType -->;
	setDefaultKeyValue();
}
      
function default_pskValue(){
    var pskValue = get_by_id("wlan0_psk_pass_phrase");
    var pskValueCfm = get_by_id("pskValueCfm0");

    pskValue.value = "<% getInfo("pskValue");%>";
    pskValueCfm.value = "<% getInfo("pskValue");%>";
}

function setWDSDefaultKeyValue() {
	var format = get_by_id("wdsformat0");
	var wepKey = get_by_id("wepKey0");
	var encrypt = get_by_id("encrypt0");
	var key_format;// = <% getIndexValue("wdsWepFormat -->;
	var wep_format;// = <% getIndexValue("wdsEncrypt -->;

	if(encrypt.selectedIndex == 1) {
		if(format.selectedIndex == 0) {
			wepKey.maxLength = 5;
			if(( key_format == 0)&&( wep_format != 2))
				wepKey.value = "<% getInfo("wds_wep64key_a -->";
			else
				wepKey.value = "";
		}else {
			wepKey.maxLength = 10;
			if(( key_format == 1)&&( wep_format != 2))
				wepKey.value = "<% getInfo("wds_wep64key -->";
			else
				wepKey.value = "";
		}
	}else {
		if (format.selectedIndex == 0) {
			wepKey.maxLength = 13;
			if(( key_format == 0)&&( wep_format != 1))
				wepKey.value = "<% getInfo("wds_wep128key_a -->";
			else
				wepKey.value = "";
		}else {
			wepKey.maxLength = 26;
			if(( key_format == 1)&&( wep_format != 1))
				wepKey.value = "<% getInfo("wds_wep128key -->";
			else
				wepKey.value = "";
		}
	}
}

function updateEncryptState() {
	var format = get_by_id("wdsformat0");
	var wepKey = get_by_id("wepKey0");
	var wdspskitem = get_by_id("wdspskValue0");
	var encrypt = get_by_id("encrypt0");

	if (encrypt.selectedIndex == 0) {
		format.disabled = true;
		wepKey.disabled = true;    
		wdspskitem.disabled = true;    
		wepKey.maxLength = 0;
		wepKey.value = "";
	}else if((encrypt.selectedIndex == 1) || (encrypt.selectedIndex == 2)) {
		format.disabled = false;
		wepKey.disabled = false;    
		wdspskitem.disabled = true;
		setWDSDefaultKeyValue();
	}else {
		format.disabled = true;
		wepKey.disabled = true;    
		wdspskitem.disabled = false;
	}
	//WdsMacList();temp cancel
}

function show_wpa_settings() {
	var eap_type = get_by_id("eap_type");

	get_by_id("show_wpa_psk").style.display = "none";
	get_by_id("show_wpa_eap").style.display = "none";

	if (eap_type.selectedIndex == 0) {
		get_by_id("show_wpa_psk").style.display = "";
	}else {
		get_by_id("show_wpa_eap").style.display = "";
	}
}

function set_disablechan()
{
	if(get_by_id("auto_channel_enable").checked)
		get_by_id("wlan0_channel").disabled = true;
	else
		get_by_id("wlan0_channel").disabled = false;	
}

function show_wpa() {
	var mode = get_by_id("mode0");
	var tmp_mode = get_by_id("tmp_mode");
	var authType = get_by_id("authType");
	var show_wep_setting = get_by_id("show_wep_setting");
	var show_wep = get_by_id("show_wep");
	var show_wpa = get_by_id("show_wpa");
	var wpa = get_by_id("wpa");
	var wpa2 = get_by_id("wpa2");
	var wpa2_auto = get_by_id("wpa2-auto");
	var site_survey = get_by_id("site_survey");
//	var type = get_by_id("type_d");
	var Bssid2Join = get_by_id("Bssid2Join");
	var show_wds = get_by_id("show_wds");
	var H_SSID_tmp = get_by_id("ssid_broadcast");

	Bssid2Join.style.display = "none";
	show_wep_setting.style.display = "";
	show_wep.style.display = "none";
	show_wpa.style.display = "none";
	wpa.style.display = "none";
	wpa2.style.display = "none";
	wpa2_auto.style.display = "none";
	show_wds.style.display = "none";
	H_SSID_tmp.disabled = true;

	get_by_id("wep_auth").style.display = "";
	get_by_id("wep_wauth").style.display = "none";
	get_by_id("tmp_mode").style.display = "";

	if(mode.selectedIndex == 0)
		get_by_id("mode_show").innerHTML = "";
	else if(mode.selectedIndex == 1)
		get_by_id("mode_show").innerHTML = "";
	else if(mode.selectedIndex == 2)
		get_by_id("mode_show").innerHTML = "";
	else if(mode.selectedIndex == 3)
		get_by_id("mode_show").innerHTML = "";
	else if(mode.selectedIndex == 4) {
		get_by_id("mode_show").innerHTML = "Repeater";
		get_by_id("tmp_mode").style.display = "none";
	}
	get_by_id("show_wps_setting").style.display = "";

	if ((mode.selectedIndex == 0) || (mode.selectedIndex == 1) || (mode.selectedIndex == 4)) {
		if (tmp_mode.selectedIndex==0) { //AP
			get_by_id("auto_channel_enable").disabled = false;
			site_survey.disabled = true;
//			type.style.display = "none";
			H_SSID_tmp.disabled = false;
		}else { //APC, or...
			get_by_id("auto_channel_enable").checked = true;
			get_by_id("auto_channel_enable").disabled = true;
//			type.style.display = "";
			site_survey.disabled = false;
			Bssid2Join.style.display = "none";
		}
		set_disablechan();

		if (authType.length == 4) {
			authType.length = 5;
			authType.options[4] = new Option("Enable WPA2-Auto Wireless Security (enhanced)", "wpa2-auto", false, false);
		}

		if (authType.selectedIndex==1) {
			show_wep.style.display = "";
			updateFormat();
		}else if (authType.selectedIndex==2) {
			show_wpa.style.display = "";
			wpa.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}else if (authType.selectedIndex==3) {
			show_wpa.style.display = "";
			wpa2.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}else if (authType.selectedIndex==4) {
			show_wpa.style.display = "";
			wpa2_auto.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}
		checkWPSstate(1);
	}else if(tmp_mode.selectedIndex == 2) {
//	else if(mode.selectedIndex == 2) {
		get_by_id("auto_channel_enable").disabled = true;
		get_by_id("auto_channel_enable").checked = false;
		site_survey.disabled = true;
//		type.style.display = "none";
		show_wep_setting.style.display = "none";
		show_wds.style.display = "";
		updateEncryptState();
		checkWPSstate(0);
		get_by_id("show_wps_setting").style.display = "none";
	}else if(mode.selectedIndex == 3) {
		get_by_id("auto_channel_enable").disabled = true;
		get_by_id("auto_channel_enable").checked = false;

		site_survey.disabled = true;
		H_SSID_tmp.disabled = false;
//		type.style.display = "none";

		if (authType.selectedIndex==1) {
			show_wep.style.display = "";
			updateFormat();
		}else if (authType.selectedIndex==2) {
			show_wpa.style.display = "";
			wpa.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}else if (authType.selectedIndex==3) {
			show_wpa.style.display = "";
			wpa2.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}else if (authType.selectedIndex==4) {
			show_wpa.style.display = "";
			wpa2_auto.style.display = "";
			update_eaptype();
			update_cipher();
			show_wpa_settings();
		}

		show_wds.style.display = "";
		updateEncryptState();
		if (authType.length == 4) {
			authType.length = 5;
			authType.options[4] = new Option("Enable WPA2-Auto Wireless Security (enhanced)", "wpa2-auto", false, false);
		}
		checkWPSstate(1);
    }
}

function show_scan(){
    window.open("sitesurvey.asp","scan","width=1000,height=500,resizable=1,scrollbars=1");
	check_push = 1;
	do_check();
}

function openScanPage() {
	window.open("list.asp");
}

function set_mac_info() {
	var dhcp_list_value =get_by_id("dhcp_list").value;
	var temp_dhcp_list = dhcp_list_value.split(",");

	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length != 0){		
			if(temp_data.length > 1){
				document.write("<tr><td>" + temp_data[0] + "</td><td>" + temp_data[1] + "</td><td>" + temp_data[2] + "</td></tr>")
			}
		}
	}
}

/*
function set_mac_info(){
var dhcp_list_value ="<!--# echo local_lan_ip -->";
	var temp_dhcp_list = dhcp_list_value.split(",");

	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length != 0){		
			if(temp_data.length > 1){
				document.write("<tr><td>" + temp_data[0] + "</td><td>" + temp_data[1] + "</td><td>" + temp_data[2] + "</td></tr>")
			}
		}
	}
}
*/

function do_check() {
	if(check_push == 1) {
		if(get_by_id("scan_sel").value != 0) {
			check_push = 0;
			get_by_id("scan_sel").value = 0;
			show_wpa();
		}else
			setTimeout('do_check()',500);
	}
}

function update_eaptype() {
	var mode = get_by_id("mode0");	
	var tmp_mode = get_by_id("tmp_mode");
	var eap_m = get_by_id("wlan0_security").value;
	var eap_type = get_by_id("eap_type");

	eap_type.length = 0;
	eap_type.options[0] = new Option("Personal", "0", false, false);

	if ((mode.selectedIndex == 0)||(mode.selectedIndex == 3)) {
		if(tmp_mode.selectedIndex == 0)
			eap_type.options[1] = new Option("Enterprise", "1", false, false);

		if(eap_m =="wpa_eap" || eap_m=="wpa2_eap" || eap_m=="wpa2auto_eap")
			eap_type.selectedIndex = 1;
		else
			eap_type.selectedIndex = 0;
	}else
		eap_type.selectedIndex = 0;
}

function update_cipher() {
	var mode = get_by_id("mode0");
	var cipher_m = "<!--# echo wlan0_psk_cipher_type"," -->";
	var authType = get_by_id("authType");
	var cipher_type = get_by_id("c_type");

//	cipher_type.length = 0;
	cipher_type.options[0] = new Option("TKIP", "1", false, false);
	cipher_type.options[1] = new Option("AES", "2", false, false);

	if ((mode.selectedIndex == 0)||(mode.selectedIndex == 3)) {
		cipher_type.options[2] = new Option("AUTO", "3", false, false);
		if(cipher_m =="tkip")
			cipher_type.selectedIndex = 0;
		else if(cipher_m =="aes")
			cipher_type.selectedIndex = 1;
		else if(cipher_m =="both")
			cipher_type.selectedIndex = 2;
	}else {
		if(cipher_m =="tkip")
			cipher_type.selectedIndex = 0;
		else if(cipher_m =="aes")
			cipher_type.selectedIndex = 1;
		else if(cipher_m =="both") {
			if (authType.selectedIndex==2)
				cipher_type.selectedIndex = 0;
			else
				cipher_type.selectedIndex = 1;
		}
	}
}

function onchange_authType() {
	var authType = get_by_id("authType");
	var cipher_type = get_by_id("c_type");

	show_wpa();
	if (2==authType.selectedIndex)//WPA
		cipher_type.selectedIndex = 0;
	else if (3==authType.selectedIndex)//WPA2
		cipher_type.selectedIndex = 1;
	else if (4==authType.selectedIndex)//AUTO
		cipher_type.selectedIndex = 2;
}

function send_cipher_value() {
	if(get_by_id("c_type").selectedIndex == 0) {
		get_by_id("wlan0_psk_cipher_type").value = "tkip";
	}else if(get_by_id("c_type").selectedIndex == 1) {
		get_by_id("wlan0_psk_cipher_type").value = "aes";
	}else {
		get_by_id("wlan0_psk_cipher_type").value = "both";
	}
}

function checkWPSstate(if_enable) {
	var mode = get_by_id("mode0");
	var tmp_mode = get_by_id("tmp_mode");

//	if((mode.selectedIndex == 0)||(mode.selectedIndex == 3))
	if(tmp_mode.selectedIndex == 0)
		get_by_id("show_wps_pin").style.display = "";
	else
		get_by_id("show_wps_pin").style.display = "none";

	if (if_enable &&
	    ((mode.selectedIndex == 0)||(mode.selectedIndex == 1)||(mode.selectedIndex == 3)||(mode.selectedIndex == 4)))
	{
		get_by_id("checkbox_wps_enable").disabled = false;
		if(get_by_id("checkbox_wps_enable").checked) {
			get_by_id("wps_lock").disabled = false;
			get_by_id("genPIN").disabled = false;
			get_by_id("resetPIN").disabled = false;
			get_by_id("localPin").innerHTML = get_by_id("wps_pin").value;
			var wps_config="<!--# echo wps_configured_mode -->";
			if((mode.selectedIndex == 0)||(mode.selectedIndex == 3)) {
				if(wps_config != 1) {
					get_by_id("reset_config").disabled = false;
					get_by_id("wps_status").innerHTML = "Enabled/Configured";
				}else {
					get_by_id("reset_config").disabled = true;
					get_by_id("wps_status").innerHTML = "Enabled/Not configured";
				}
			}else if((mode.selectedIndex == 1)||(mode.selectedIndex == 4)) {
				get_by_id("wps_status").innerHTML = "Enabled";
				if(wps_config)
					get_by_id("reset_config").disabled = false;
				else
					get_by_id("reset_config").disabled = true;
			}else {
				get_by_id("reset_config").disabled = false;
				get_by_id("wps_status").innerHTML = "Enabled";
			}
		}else {
			get_by_id("wps_lock").disabled = true;
			get_by_id("genPIN").disabled = true;
			get_by_id("resetPIN").disabled = true;
			get_by_id("reset_config").disabled = true;
			get_by_id("localPin").innerHTML = "";
			get_by_id("wps_status").innerHTML = "Disabled";
		}
	}else {
		get_by_id("checkbox_wps_enable").disabled = true;
		get_by_id("wps_lock").disabled = true;
		get_by_id("genPIN").disabled = true;
		get_by_id("resetPIN").disabled = true;
		get_by_id("reset_config").disabled = true;
		get_by_id("localPin").innerHTML = "";
		get_by_id("wps_status").innerHTML = "Disabled";
	}
}

function genPinClicked() {
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
	get_by_id("localPin").innerHTML = num; 
	get_by_id("wps_pin").value = num;
}

function resetPinClicked() {
	var num = "<!--# echo wps_generate_default_pin -->";
	get_by_id("localPin").innerHTML = num; 
	get_by_id("wps_pin").value = num;
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

function validate_pin_code(code)
{
	var accum=0;

	accum += 3 * (parseInt(code / 10000000) % 10); 
	accum += 1 * (parseInt(code / 1000000) % 10); 
	accum += 3 * (parseInt(code / 100000) % 10); 
	accum += 1 * (parseInt(code / 10000) % 10);
	accum += 3 * (parseInt(code / 1000) % 10);
	accum += 1 * (parseInt(code / 100) % 10);
	accum += 3 * (parseInt(code / 10) % 10); 
	accum += 1 * (parseInt(code / 1) % 10);
	return (0 == (accum % 10));	
}

function check_pin_code(str)
{
	var i;
	var code_len;
		
	code_len = str.length;
	if (code_len != 8 && code_len != 4)
		return 1;

	for (i=0; i<code_len; i++) {
		if ((str.charAt(i) < '0') || (str.charAt(i) > '9'))
			return 2;
	}

	if (code_len == 8) {
		var code = parseInt(str, 10);
		if (!validate_pin_code(code))
			return 3;
		else
			return 0;
	}
	else
		return 0;
}

function show_addwps(){
   	window.open("add_wps.asp","WPS","width=1000,height=700,resizable=1,scrollbars=1");
}

function check_wps()
{
	if(get_by_id("checkbox_wps_enable").checked)
	{
		if(get_by_id("authType").selectedIndex == 1)
		{
			if(get_by_id("authType_t").selectedIndex == 0 && get_by_id("wlan0_wep_default_key").selectedIndex !=0)
			{
				alert("Cannot choose WEP key 2,3,4 when WPS is enabled!!");
				return false;
			}
			else if(get_by_id("authType_t").selectedIndex ==1)
			{
				alert("Cannot choose shared key when WPS is enabled!!");
				return false;
			}
		}
		ret = check_pin_code(get_by_id("wps_pin").value);
		if(ret!=0)
		{
			alert("PIN error!!!");
			return false;
		}
	}
	return true;
}

function do_reboot() {
	if(confirm("Reboot DIR-665?"))
		return true;
	else
		return false;
}

function change_mode() {
	tmp_mode = get_by_id("tmp_mode");
	mode = get_by_id("mode0");
	var wlan0_op_mode = "<!--# echo wlan0_op_mode -->";

	if(tmp_mode.length == 0) {
		tmp_mode.options[0] = new Option("Access Point", "0", false, false);
		tmp_mode.options[1] = new Option("Access Point Client", "1", false, false);
		if(wlan0_op_mode=="AP")
			tmp_mode.selectedIndex = 0;
		if(wlan0_op_mode=="APC")
			tmp_mode.selectedIndex = 1;
	}
	show_wpa();
}

function Unconfigured_button() {	
	get_by_id("form1").action = "restore_default_wireless.cgi";	
}


</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%"><script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
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
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
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
									<li><div id="sidenavoon"><a href="index.asp">Setup Wizard</a></div>
									</li>
									<li><div id="sidenavoff">Wireless Setup</div>
									</li>
									<li><div id="sidenavon"><a href="lan.asp">LAN Setup</a></div>
									</li>
									<li><div id="sidenavon"><a href="i_logout.asp">Logout</a></div></li>
								</ul>
									<div id="sidenavon" align="center"><br><br>
										<form name="reboot" method="post" action="reboot.cgi">
											
											<input type="submit" value="Reboot" onClick="return do_reboot()">
											<input type="hidden" id="html_response_page" name="html_response_page" value="reboot_countdown.asp">
                							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_firmw.asp">	
										</form>
									</div>
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
    		<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="<!--# echo wps_configured_mode -->">										
              <td valign="top" id="maincontent_container">
				<div id="maincontent">
				  <div id="box_header"> 
						<h1>WIRELESS CONNECTION</h1>
						Use this section to configure the wireless settings for your D-Link Access Point.
						Please note that changes made on this section will also need to be duplicated to your wireless clients and PC.
						<p>
						To protect your privacy you can configure wireless security features.
						This device supports three wireless security modes including: WEP or WPA and WPA2.
					</div>
					<div class="box"> 
						<h2>Wireless Network Settings : </h2>
					  <div>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td width="200" align="right">Wireless Mode :</td>
									<td>&nbsp;
									<B><span id="mode_show"></span></B>
									<SELECT id="tmp_mode" name="tmp_mode" ONCHANGE="change_mode()" style="display:none">  
				  					</SELECT> 
									<SELECT id="mode0" name="mode0" ONCHANGE="show_wpa()" style="display:none">  
				  						<OPTION value=0 >Access Point</option> 
										<!--<OPTION	value=1 >Wireless Client</option>
				  						<OPTION value=2 >Bridge</option> 
										<OPTION	value=3 >Bridge with AP</option>
										<OPTION	value=4 >Repeater</option>
										-->
				  					</SELECT>
   							<input name="site_survey" type="button" id="site_survey" value="Site Survey" onClick="show_scan()">
									<input type="hidden" id="wlan0_op_mode" name="wlan0_op_mode" value="<!--# echo wlan0_op_mode -->">
									<input type="hidden" id="scan_sel" value=0>
                  					<INPUT maxLength=12 size=14 id="Bssid2Join" name="Bssid2Join" style="display:none" value="">
									</td>
								</tr>
							</table>
							</div>
							<div id="type_d" style="display:none">
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td width="200" align="right">Network Type :</td>
									<td>&nbsp;
                  					<SELECT id="type0" name="type0" ONCHANGE="show_wpa()">  
				  					<OPTION value=0 >Infrastructure</option> 
				  					<OPTION value=1 >Ad Hoc</option> 
				  					</SELECT>
									  
									</td>
								</tr>
							</table></div>
							<div>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td width="200" align="right">Wireless Network Name :</td>
								<td>&nbsp;
									<input name="wlan0_ssid" type="text" id="wlan0_ssid" size="20" maxlength="32" value="<!--# echo wlan0_ssid -->"> 
									(Also called the SSID)
								</td>
								</tr>
								<tr>
             					 <td width="200" align="right">802.11 Mode :</td>
           					 	<td>&nbsp; 
			  							<select id="dot11_mode" name="dot11_mode" onClick="show_chan_width();">
											<option value="11b">802.11b only</option>
											<option value="11g">802.11g only</option>
											<option value="11n">802.11n only</option>
											<option value="11bg">Mixed 802.11g and 802.11b</option>
											<option value="11gn">Mixed 802.11n and 802.11g</option>
											<option value="11bgn">Mixed 802.11n, 802.11g and 802.11b</option>
								 		</select> <input type="hidden" id="wlan0_dot11_mode" name="wlan0_dot11_mode" value="<!--# echo wlan0_dot11_mode -->"> 
             				     	</td>
                               </tr>
								<tr>
                                  					<td width="200" align="right">Radio Mode :</td>
                              						<td>&nbsp;  
        	                        	                        <input type="radio" value="0" name="wlan0_radio_mode">2.4G Mode&nbsp;
                	                        	                <input type="radio" value="1" name="wlan0_radio_mode">5G Mode&nbsp;
                	                        	                <input type="radio" value="2" name="wlan0_radio_mode">2.4/5G Auto Mode&nbsp;
                                                		</td>
                                       				</tr>

								<tr>
                                  <td width="200" align="right">Wireless Channel :</td>
                              <td>&nbsp;  
							  	<select name="wlan0_channel" size="1" class="edit" id="wlan0_channel"></select>
								( Domain :<script>
								var domain= "<!--# echo wlan0_domain -->";
								
								if(domain =="0x10"){
									document.write("NA/US");
								}else if(domain =="0x30"){
									document.write("EU");							
								}		
								</script>)
							  </td>
							  </tr>
							  <tr id="show_channel_width"> 
              					<td width="200" align="right">Channel Width :</td>
              					<td >&nbsp;
									    <select id="11n_protection" name="11n_protection">
                  						<option value="20">20 MHz</option>
                  						<option value="auto">Auto 20/40 MHz</option>
                						</select> <input type="hidden" id="wlan0_11n_protection" name="wlan0_11n_protection" value="<!--# echo wlan0_11n_protection -->"> 
             					 </td>
            				</tr>
								<tr>
                                  <td width="200" align="right">Enable Auto Channel Scan :</td>
                              	<td>&nbsp;<input name="auto_channel_enable" type="checkbox" id="auto_channel_enable" value="1" onClick="set_disablechan()">
								<input type="hidden" id="wlan0_auto_channel_enable" name="wlan0_auto_channel_enable" value="<!--# echo wlan0_auto_channel_enable -->">
								<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# echo local_lan_ip -->">

								</td>
							  </tr>
								<tr>
                                  <td width="200" align="right">Enable Hidden Wireless :</td>
                              	<td>&nbsp;<input name="ssid_broadcast" type="checkbox" id="ssid_broadcast" value="ON" >(Also called Disable SSID Broadcast)
								<input type="hidden" id="wlan0_ssid_broadcast" name="wlan0_ssid_broadcast" value="<!--# echo wlan0_ssid_broadcast -->">

      						  </tr>														
							</table></div>
					</div>
					<div class="box" id="show_wep_setting"> 
						<h2>Wireless Security Mode : </h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr><td width="200" align="right">Security Mode :</td>
								<td>&nbsp;
									<select id="authType" name="authType" onChange="onchange_authType()">
										<option value=0 >Disable Wireless Security (not recommended)</option>
										<option value=1 >Enable WEP Wireless Security (basic)</option>
										<option value=2 >Enable WPA Wireless Security (enhanced)</option>
										<option value=3 >Enable WPA2 Wireless Security (enhanced)</option>
										<option value=4 >Enable WPA2-Auto Wireless Security (enhanced)</option>
									</select>
									<input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">
								</td>
							</tr>
						</table>
					</div>
					<div class="box" id="show_wep" style="display:none"> 
						<h2>WEP : </h2>
						<p>WEP is the wireless encryption standard. To use it you must enter the same key(s) into the AP and the wireless stations. For 64 bit keys you must enter 10 hex digits into each key box. For 128 bit keys you must enter 26 hex digits into each key box. A hex digit is either a number from 0 to 9 or a letter from A to F. For the most secure use of WEP set the authentication type to &quot;Open Key&quot; when WEP is enabled. </p>
							
	              	    <p>You may also enter any text string into a WEP key box, in which case it will be converted into a hexadecimal key using the ASCII values of the characters. 5 text characters can be entered for 64 bit keys, and 13 characters for 128 bit keys.<br></p>
								<div id="wep_auth" style="display:none">
                  				<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td width="200" align="right">Authentication :</td>
									<td>&nbsp;
										<select name="authType_t" id="authType_t">
											<option value="open">Open</option>
											<option value="share" >Shared Key</option>
											<!--<option value="both" >Both</option>-->
									  </select>
									</td>
								</tr>
								</table>
								</div>
								<div id="wep_wauth" style="display:none">
                  				<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td width="200" align="right">Authentication :</td>
									<td>&nbsp;
									Open/Shared key
									</td>
								</tr>
								</table>
								</div>
                  				<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr> 
                        <td width="200"> 
                          <div align="right">WEP Encryption :</font></div>
                        </td>
                        <td>&nbsp; 
                          <select id="length0" name="length0" size=1 onChange="setDefaultKeyValue()">
                            <option value="64" >64Bit</option>
                            <option value="128" >128Bit</option>
                          </select>
                        </td>
                      </tr>
						<tr>
							<td width="200"> 
								<div align="right">Key Type :</font></div>
							</td>
							<td>&nbsp; 
								<select id="wlan0_wep_display" name="wlan0_wep_display" onChange="setDefaultKeyValue()">
									<option value="ascii">ASCII</option>
									<option value="hex">HEX</option>
								</select>
							</td>
						</tr>
						<tr>
									<td width="200" align="right">Default WEP Key :</td>
						  <td>&nbsp;
										<select name="wlan0_wep_default_key" id="wlan0_wep_default_key">
											<option value="1" >WEP Key 1</option>
											<option value="2" >WEP Key 2</option>
											<option value="3" >WEP Key 3</option>
											<option value="4" >WEP Key 4</option>
									  </select>
									</td>
					  </tr>
								<tr>
									<td width="200" align="right">WEP Key 1 :</td>
								<td>&nbsp;&nbsp;<INPUT type="text" maxLength=26 size=26 id="key1" name="key1">
                                  <input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1" value="<!--# echo wlan0_wep64_key_1","hex -->">                            	 
                                  <input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1" value="<!--# echo wlan0_wep128_key_1","hex -->">
								</td>
								</tr>
								<tr>
									<td width="200" align="right">WEP Key 2 :</td>
								<td>&nbsp;&nbsp;<INPUT type="text" maxLength=26 size=26 id="key2" name="key2">
								 	<input type="hidden" id="wlan0_wep64_key_2" name="wlan0_wep64_key_2" value="<!--# echo wlan0_wep64_key_2","hex -->">
                            		<input type="hidden" id="wlan0_wep128_key_2" name="wlan0_wep128_key_2" value="<!--# echo wlan0_wep128_key_2","hex -->">
								</td>
								</tr>
								<tr>
									<td width="200" align="right">WEP Key 3 :</td>
								<td>&nbsp;&nbsp;<INPUT type="text" maxLength=26 size=26 id="key3" name="key3">
									 <input type="hidden" id="wlan0_wep64_key_3" name="wlan0_wep64_key_3" value="<!--# echo wlan0_wep64_key_3","hex -->">
		                            <input type="hidden" id="wlan0_wep128_key_3" name="wlan0_wep128_key_3" value="<!--# echo wlan0_wep128_key_3","hex -->">
								</td>
								</tr>
								<tr>
									<td width="200" align="right">WEP Key 4 :</td>
								<td>&nbsp;&nbsp;<INPUT type="text" maxLength=26 size=26 id="key4" name="key4">
									 <input type="hidden" id="wlan0_wep64_key_4" name="wlan0_wep64_key_4" value="<!--# echo wlan0_wep64_key_4","hex -->">
		                            <input type="hidden" id="wlan0_wep128_key_4" name="wlan0_wep128_key_4" value="<!--# echo wlan0_wep128_key_4","hex -->">
								</td>
								</tr>
					  </table>
					</div>
				  <div class="box" id="show_wpa" style="display:none" > 
				  		<div id="wpa" style="display:">
						<h2>WPA : </h2>
						<p>WPA requires stations to use high grade encryption and authentication. </p>
						</div>
						<div id="wpa2" style="display:none">
							<h2>WPA2 : </h2>
							<p>WPA2 requires stations to use high grade encryption and authentication. </p>
						</div>
						<div id="wpa2-auto" style="display:none">
							<h2>WPA2-auto : </h2>
							<p>WPA2-Auto requires stations to use high grade encryption and authentication. </p>
						</div>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
						<tr>
							<td width="200" height="19" align="left"><div align="right">Cipher Type :</div></td>
							<td width="325">&nbsp;
								<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<!--# echo wlan0_psk_cipher_type -->">
								<select name="c_type" id="c_type">
								</select>
							</td>
							<SCRIPT>
							update_cipher();
							</SCRIPT>
						</tr>
						<tr>
							<td width="200" height="19" align="left"><div align="right">PSK / EAP :</div></td>
							<td height="19" colspan="2">&nbsp;
								<select name="eap_type" id="eap_type" onChange="show_wpa_settings()">
								</select>
							</td>
							<SCRIPT>
							update_eaptype();
							</SCRIPT>
						</tr>																		
						<tr id="show_wpa_psk" style="display:none">
                				<td colspan="3">
                					<table>
										<tr>							
						  <td width="200" align="right">Passphrase :</td>
						  <td colspan="2">&nbsp;<input id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase"type="password" size="40" maxlength="63" value="<!--# echo wlan0_psk_pass_phrase"," -->"></td>
					  </tr>
						<tr>
							<td width="200" align="right">Confirmed Passphrase : </td>
							<td colspan="2">&nbsp;<input id="pskValueCfm0" name="pskValueCfm0" type="password" size="40" maxlength="63" value="<!--# echo wlan0_psk_pass_phrase"," -->"></td>
									  </tr>
					</table>
							</td>
						</tr>
						<tr id="show_wpa_eap" style="display:none">
							<td colspan="3">
						  		<table width="525">
						  			<tr>
							  			<td align="right"><div align="left">802.1X</div></td>
							  			<td colspan="2">&nbsp;</td>
						  			</tr>
									<tr>
							  			<td width="200" align="right">RADIUS Server 1 :</td>
							  			<td width="21%">&nbsp;IP</td>
							  			<td>&nbsp;
							    			<input id="radiusIP0" name="radiusIP0" maxlength=15 size=15 >
											 <input type="hidden" id="wlan0_eap_radius_server_0" name="wlan0_eap_radius_server_0" value="<!--# echo wlan0_eap_radius_server_0 -->">

					
							  			</td>
						  			</tr>
									<tr>
							  			<td width="200" align="right">&nbsp;</td>
							  			<td width="21%"><div align="left">&nbsp;Port</div></td>
							  			<td>&nbsp;
							    			<input type="text" id="radiusPort0" name="radiusPort0" size="8" maxlength="5" value="">
							    		</td>
						  			</tr>
									<tr>
							  			<td width="200" align="right">&nbsp;</td>
							  			<td width="21%"><div align="left">&nbsp;Shared Secret</div></td>
							  			<td>&nbsp;
							    			<input id="radiusPass0" name="radiusPass0" size="32" maxlength="64" value="">
							  			</td>
						  			</tr>
									<tr>
							  			<td width="200" align="right">RADIUS Server 2 :</td>
										<td width="21%">&nbsp;IP</td>
										<td>&nbsp;
								    		<input id="radius2IP0" name="radius2IP0" maxlength=15 size=15 value="">
											<input type="hidden" id="wlan0_eap_radius_server_1" name="wlan0_eap_radius_server_1" value="<!--# echo wlan0_eap_radius_server_1"," -->">

	                            		</td>
									</tr>
									<tr>
							  			<td width="200" align="right">&nbsp;</td>
							  			<td width="21%"><div align="left">&nbsp;Port</div></td>
							  			<td>&nbsp;
							      			<input type="text" id="radius2Port0" name="radius2Port0" size="8" maxlength="5" value="">
	                          			</td>
						  			</tr>
									<tr>
							  			<td width="200" align="right">&nbsp;</td>
							  			<td width="21%"><div align="left">&nbsp;Shared Secret</div></td>
							  			<td>&nbsp;
							      			<input id="radius2Pass0" name="radius2Pass0" size="32" maxlength="64" value="">
	                          			</td>
						  			</tr>
						  		</table>
							</td>
						</tr>
				    </table>                            
		          </div>		
					<div class="box" id="show_wds" style="display:none"> 
						<h2>BRIDGE setting : </h2>
                    <table cellpadding="1" cellspacing="1" border="0" width="525">
                        <tr>
                            <td align=right width="200" height="19">
          			                Remote AP Mac:
                            </td>                          
                        <TD width="325"><div align="left">
                        &nbsp;
                         <--   1.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac1" name="wdsMac1">
                            2.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac2" name="wdsMac2">
                        </div></TD>
                        </tr>
                        <tr>
                            <td align=right "200" height="19">
                            </td>                          
                        <TD height=2><div align="left">
                        &nbsp;
                            3.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac3" name="wdsMac3">
                            4.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac4" name="wdsMac4">
                        </div></TD>
                        </tr>
                        <tr>
                            <td align=right "200" height="19">
                            </td>                          
                        <TD height=2><div align="left">
                        &nbsp;
                            5.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac5" name="wdsMac5">
                            6.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac6" name="wdsMac6">
                        </div></TD>
                        </tr>
                        <!-- tr>
                            <td align=right "200" height="19">
                            </td>                          
                        <TD height=2><div align="left">
                        &nbsp;
                            7.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac7<% getIndexValue("wlan_idx -->" name="wdsMac7<% getIndexValue("wlan_idx -->">
                            8.
                            <INPUT 
                        maxLength=12 size=14 id="wdsMac8<% getIndexValue("wlan_idx -->" name="wdsMac8<% getIndexValue("wlan_idx -->">
                        </div></TD>
                        </tr -->
                        <tr>
                            <td align=right "200" height="19">
          			                Bridge Security:
                            </td>                          
                            <td height=2 colspan="2">&nbsp;
                          <SELECT id="encrypt" name="encrypt" ONCHANGE="updateEncryptState()"> <OPTION 
                          value=0 >none</OPTION> <OPTION 
                          value=1 >WEP 64bits</OPTION> <OPTION 
                          value=2 >WEP 128bits</OPTION> <OPTION 
                          value=4 >WPA2-PSK (AES)</OPTION>
                          </SELECT>
                            </td>                           
                        </tr>
                        <tr>
                            <td align=right "200" height="19">
          			                WEP Key: 
                            </td>                          
                            <td height=2 colspan="2">&nbsp;
                    		<SELECT id="wdsformat" name="wdsformat" ONCHANGE="setWDSDefaultKeyValue()"> 
							<OPTION value=0 >ASCII</OPTION> 
							<OPTION value=1 >Hex</OPTION>
                          	</SELECT>
							<br>&nbsp;<input type="text" id="wepKey" name="wepKey" size=26 maxlength=26 >
                            </td>                           
                        </tr>
                        <tr>
                            <td align=right "200" height="19">
          			                Passphrase: <br>(8~63 char.)
                            </td>                          
                            <td height=2 colspan="2">&nbsp;
							<INPUT type="text" id="wdspskValue" name="wdspskValue" maxLength=63 size=26 value="">
                            </td>                           
                        </tr>
                    </table>
					</div>
				<div class="box" id="show_wps_setting"> 
					<h2>WIFI PROTECTED SETUP (ALSO CALLED WCN 2.0 IN WINDOWS VISTA) : </h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
						<tr><td width="200" align="right">Enable :</td>
							<td>&nbsp;&nbsp;
								<input type="checkbox" id="checkbox_wps_enable" name="checkbox_wps_enable" value="ON" onClick="checkWPSstate(1)">
								<input type="hidden" id="wps_enable" name="wps_enable" value="<!--# echo wps_enable -->">
							</td>
						</tr>
					</table>
					<div id="show_wps_pin" style="display:none">
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr><td width="200" align="right">Lock Wireless Security :</td>
								<td>&nbsp;
									<input type="checkbox" id="checkbox_wps_lock" name="wps_lock" value="ON" onClick="checkWPSstate(1)">
									<input type="hidden" id="wps_lock" name="wps_lock" value="<!--# echo wps_lock -->">
								</td>
							</tr>
							<tr><td width="200" align="right">Current PIN :</td>
								<td>&nbsp;
									<b><span id="localPin"></span></b>
									<input type="hidden" id="wps_pin" name="wps_pin" size="12" maxlength="10" value="<!--# echo wps_pin -->">
								</td>
							</tr>
							<tr><td width="200" align="right"></td>
								<td>&nbsp;
									<input type="button" value="Generate New PIN" id="genPIN" name="genPIN" onClick="return genPinClicked()">
									<input type="button" value="Reset PIN to Default" id="resetPIN" name="resetPIN" onClick="return resetPinClicked()">
								</td>
							</tr>
							<tr><td width="200" align="right">Wi-Fi Protected Status :</td>
								<td>&nbsp;<span id="wps_status"></span></td>
							</tr>
							<tr><td width="200" align="right"></td>
								<td>&nbsp;<input type="submit" value="Reset to Unconfigured" id="reset_config" name="reset_config" onClick="Unconfigured_button();"></td>
							</tr>
							<tr><td width="200" align="right"></td></tr>
						</table>
					</div>
				</div>
				<div id="check_apply"><br><br>
					<table cellpadding="1" cellspacing="1" border="0" width="540">
						<tr><td align="center">
							<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wireless.asp">
							<input type="submit" value="Apply Settings" name="apply" onClick="return send_request()">
							<input type="reset" value="Cancel" name="reset" onClick="location.reload()">
						</td></tr>
					</table>
				</div>
			</form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                   <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>..</strong><br><br>
                        <STRONG>Wireless Mode:</STRONG><br>
						Select a function mode from switch button to configure your wireless network. Function wireless modes include Access Point, 
						Wireless Client and Repeater. Function wireless modes are designed to support various wireless network topologies 
						and applications.<br><br>
                        <STRONG>Wireless Network Name:</STRONG><br>
						Changing your Wireless Network Name is the first step in securing your wireless network. We recommend that 
                          you change it to a familiar name that does not contain any personal information.<br><br>
						  <strong>Hidden Wireless:</strong><br>Enabling Hidden Mode is another way to 
                          secure your network. With this option enabled, no wireless clients 
                          will be able to see your wireless network when they perform scan to 
                          see what's available. In order for your wireless devices to connect 
                          to your AP, you will need to manually enter the Wireless Network 
                          Name on each device.<br><br>
						  <strong>Security Keys:</strong><br>If you have enabled Wireless Security, make 
                          sure you write down WEP Key or Passphrase that you have configured. 
                          You will need to enter this information on any wireless device that 
                      you connect to your wireless network.<br><br>
						  <strong>Wi-Fi Protected Setup (Also called WCN 2.0 in Windows Vista):</strong><br>
						  Wi-Fi Protected Setup provides a more intuitive way of setting up wireless security between the AP and the wireless client. 
						  Make sure the wireless card supports such feature or uses a certified Windows Vista driver in order to take advantage of this feature. 
						  You can configure WPS settings using setup wizard.
					  </td>
                    </tr>
                  </tbody>
			  </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_bottom.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<script>
show_wpa();
loadSettings();
change_mode();
show_chan_width();
</script>
<br>
<div align="center">Copyright &copy; 2009 D-Link Corporation.</div>
<br>
</body>
<!-- insert name=restore_cfg -->
</html>
