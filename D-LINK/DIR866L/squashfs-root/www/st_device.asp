<html>
  <head>
    <title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
    <meta http-equiv=Content-Type content="text/html; charset=UTF-8">
    <link rel="STYLESHEET" type="text/css" href="/css_router.css">
    <script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
    <script type="text/javascript" src="/lang.js"></script>
    <script lang="JavaScript" src="public.js"></script>
    <script lang="javascript" src="/jquery-1.6.1.min.js"></script>
    <script lang="javascript" src="/jquery.sparkline.min.js"></script>
    <script>
	var browserName=navigator.userAgent.toLowerCase();
	var nNow = "", gTime = "<!--# exec cgi /bin/system_time get -->";
	var wTimesec = "", wan_time = "";
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	var con_status = "";
	var cnt = 0;
	var cpu_sys_status = "",cpu_usr_status = "" ,cpu_idle_status="" ,cpu_io_status="";
	var mem_total_status="",mem_free_status="",mem_used_status="";
	var logged="";
	var wlan0_exist="",wlan1_exist="";
	var wlan0_mode="",wlan1_mode="";
	var wlan0_channel = "", wlan1_channel = "";
	var wlan0_width="", wlan1_width="";
	var wlan0_ssid="", wlan0_security="",wlan0_guest_ssid="",wlan0_guest_security="";
	var wlan1_ssid="", wlan1_security="",wlan1_guest_ssid="",wlan1_guest_security="";
	var wps_enable="",wps_configured_mode="";
	var wan_connection_type = function(conn_type) 
	{
		get_by_id("connect").disabled=true;
		get_by_id("disconnect").disabled=true;
		wan_con = new createRequest();
                if(wan_con){
			var url = "";
			var temp_cURL = document.URL.split("/");
			for (var i = 0; i < temp_cURL.length-1; i++) {
				if ( i == 1) continue;
				if ( i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += conn_type + ".asp";
                        wan_con.open("GET", url, true);
                        wan_con.send(null);
			cnt = 2;
                }
	};
	function disable_wireless(wlan0_exist,wlan1_exist){
		var wlan0_enable = "<!--# echo wlan0_enable -->";
		var wlan1_enable = "<!--# echo wlan1_enable -->";
		//if wlan0 & wlan1 disable
		if(wlan0_enable =="0" || wlan0_exist == "0"){
			get_by_id("show_wlan0_dot11_mode").style.display = "none";
			get_by_id("show_wlan_channel").style.display = "none";
			get_by_id("show_wps_enable").style.display = "none";
			get_by_id("show_ssid_list0").style.display = "none";
			get_by_id("show_ssid_table0").style.display = "none";
		}else{
			get_by_id("show_wlan0_dot11_mode").style.display = "";
			get_by_id("show_wlan_channel").style.display = "";
			get_by_id("show_wps_enable").style.display = "";
			get_by_id("show_ssid_list0").style.display = "";
			get_by_id("show_ssid_table0").style.display = "";

		}

		if(wlan1_enable =="0" || wlan1_exist == "0" ){//if wlan1 disable
			get_by_id("show_wlan1_dot11_mode").style.display = "none";
			get_by_id("show_wlan1_channel").style.display = "none";
			get_by_id("show_wps_enable").style.display = "none";
			get_by_id("show_ssid_list1").style.display = "none";
			get_by_id("show_ssid_table1").style.display = "none";
		}else{
			get_by_id("show_wlan1_dot11_mode").style.display = "";
			get_by_id("show_wlan1_channel").style.display = "";
			get_by_id("show_wps_enable").style.display = "";
			get_by_id("show_ssid_list1").style.display = "";
			get_by_id("show_ssid_table1").style.display = "";
		}
	}

	function show_cpu_table() 
	{
		$('#cpu_show').empty();
		var table = "<table cellpadding=1 cellspacing=1 border=0 width=525>";
		table += "<tr>";
		table += "<td class=duple>" + _cpu_usr + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;"+ cpu_usr_status +"%</td>";
		table += "</tr>";
		table += "<tr>";
		table += "<td class=duple>" + _cpu_sys + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;"+ cpu_sys_status + "%</td>";
		table += "</tr>";
		table += "<tr>";
		table += "<td class=duple>" + _cpu_idle + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;" + cpu_idle_status + "%</td>";
		table += "</tr>";
		table += "<tr>";
		table += "<td class=duple>" + _cpu_io + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;" + cpu_io_status + "%</td>";
		table += "</tr>";
		table += "</table>";
		$('#cpu_show').append(table);
	}
	function show_ssid_status()
	{
	//wlan0
	$('#show_ssid_table0').empty();
	if (wlan0_exist != "NULL") {

		var td="<td colspan=2>";
		 td+="<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>";
		 td+="<tr>";
		 td+="<td>"+wwz_wwl_wnn+"</td>";
		 td+="<td>"+guest+"</td>";
		 td+="<td>"+_macaddr+"</td>";
		 td+="<td>"+bws_SM+"</td>";
		 td+="</tr>";
		 td+="<tr>";
		 td+="<td><span id='wlan0_ssid_name'></span></td>";
		 td+="<td>"+_no+"</td>";						
		 td+="<td><!--# echo wlan0_mac --></td>";
		 td+="<td>";
		 security_w = wlan0_security;
		 show_security = security_w;
		if(security_w == "wpa2auto_eap"){
			show_security = wlan_security_eap;
		}else if(security_w == "wpa2auto_psk"){
			show_security = wlan_security_psk;
		}else if(security_w == "disable"){
			show_security = _disabled;
		}
		
		 td+=show_security+"</td></tr>";
		 
		 //wlan0_guest
		 if (wlan0_guest_enable != "0") {
			td+="<tr>";
			td+="<td><span id='wlan0_guest_ssid_name'></span></td>";
			td+="<td>"+_yes+"</td>";
			
			td+="<td><!--# exec cgi /bin/wlan info mac guest 0 --></td>";
			td+="<td>";
			
			var security_w = wlan0_guest_security;
			var show_security = security_w;
			if(security_w == "wpa2auto_eap"){
			show_security = wlan_security_eap;
			}else if(security_w == "wpa2auto_psk"){
			show_security = wlan_security_psk;
			}else if(security_w == "disable"){
			show_security = _disabled;
			}
			td+=show_security;
			
			td+="</td></tr>";
		 }
		 td+="</table></td>";

		$('#show_ssid_table0').append(td);
		$('#wlan0_ssid_name').text(wlan0_ssid);
		$('#wlan0_guest_ssid_name').text(wlan0_guest_ssid);
	}
	}
	function show_ssid_status2()
	{
	//wlan1
	$('#show_ssid_table1').empty();
	if (wlan1_exist != "NULL") {
		var td="<td colspan=2>";
		 td+="<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>";
		 td+="<tr>";
		 td+="<td>"+wwz_wwl_wnn+"</td>";
		 td+="<td>"+guest+"</td>";
		 td+="<td>"+_macaddr+"</td>";
		 td+="<td>"+bws_SM+"</td>";
		 td+="</tr>";
		 td+="<tr>";
		 td+="<td><span id='wlan1_ssid_name'></span></td>";
		 td+="<td>"+_no+"</td>";						
		 td+="<td><!--# echo wlan1_mac --></td>";
		 td+="<td>";
		 security_w = wlan1_security;
		 show_security = security_w;
		if(security_w == "wpa2auto_eap"){
			show_security = wlan_security_eap;
		}else if(security_w == "wpa2auto_psk"){
			show_security = wlan_security_psk;
		}else if(security_w == "disable"){
			show_security = _disabled;
		}
		
		 td+=show_security+"</td></tr>";
		 
		 //wlan1_guest
		if (wlan1_guest_enable != "0") {
			td+="<tr>";
			td+="<td><span id='wlan1_guest_ssid_name'></span></td>";
			td+="<td>"+_yes+"</td>";
			
			td+="<td><!--# exec cgi /bin/wlan info mac guest 1 --></td>";
			td+="<td>";
			
			var security_w = wlan1_guest_security;
			var show_security = security_w;
			if(security_w == "wpa2auto_eap"){
			show_security = wlan_security_eap;
			}else if(security_w == "wpa2auto_psk"){
			show_security = wlan_security_psk;
			}else if(security_w == "disable"){
			show_security = _disabled;
			}
			td+=show_security;
			
			td+="</td></tr>";
		 }
		 td+="</table></td>";

		$('#show_ssid_table1').append(td);
		$('#wlan1_ssid_name').text(wlan1_ssid);
		$('#wlan1_guest_ssid_name').text(wlan1_guest_ssid);
	}
	}
	function show_wireless_status() 
	{
		$('#wireless_status').empty();		
		var table = "<table cellpadding=1 cellspacing=1 border=0 width=525>";
		if(wlan0_exist != "NULL"){
			table += "<tr>";
			table += "<td class=duple>" + wwl_band + " : </td>";
			table += "<td width=340>"+ GW_WLAN_RADIO_0_NAME+"</td>";
			table += "</tr>";
			table += "<tr>";
			table += "<td class=duple>" + sd_WRadio + " : </td>";
			if(wlan0_exist=="0"){
				table += "<td width=340>"+ _off +"</td>";
			}else{
				table += "<td width=340>"+ _enabled +"</td>";
			}
			table += "</tr>";
			if(wlan0_exist!="0"){
				table += "<tr>";
				table += "<td class=duple>" + bwl_Mode + " : </td>";
				table += "<td width=340>" + show_wlan_mode(wlan0_mode) + "</td>";
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>" + bwl_CWM + " : </td>";
				if(wlan0_width=="Auto 20/40 MHz"){
					table += "<td width=340>"+ bwl_ht2040 +"</td>";
				}else{
					table += "<td width=340>"+ wlan0_width +"</td>";
				}
				
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>" + sd_channel + " : </td>";
				table += "<td width=340>" + wlan0_channel + "</td>";
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>" + LW2 + " : </td>";
				if (wps_enable != "1")
					table += "<td width=340>"+_disabled+"</td>";
				else {
					if (wps_configured_mode == "1") {
						table += "<td width=340>"+LW67+"</td>"; 
					}else{
						table += "<td width=340>"+LW66+"</td>";
					}
				}
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>"+ssid_lst+" :</td>";
				table += "</tr>";
			}
		}//wlan0
		
		table += "</table>";
		
		$('#wireless_status').append(table);
	}
	function show_wireless_status2() 
	{
		$('#wireless_status2').empty();		
		var table = "<table cellpadding=1 cellspacing=1 border=0 width=525>";
		if(wlan1_exist != "NULL"){
			table += "<tr>";
			table += "<td class=duple>" + wwl_band + " : </td>";
			table += "<td width=340>"+ GW_WLAN_RADIO_1_NAME+"</td>";
			table += "</tr>";
			table += "<tr>";
			table += "<td class=duple>" + sd_WRadio + " : </td>";
			if(wlan1_exist=="0"){
				table += "<td width=340>"+ _off +"</td>";
			}else{
				table += "<td width=340>"+ _enabled +"</td>";
			}
			table += "</tr>";
			if(wlan1_exist!="0"){
				table += "<tr>";
				table += "<td class=duple>" + bwl_Mode + " : </td>";
				table += "<td width=340>" + show_wlan_mode(wlan1_mode) + "</td>";
				table += "</tr>";
				table += "<td class=duple>" + bwl_CWM + " : </td>";
				if(wlan1_width=="Auto 20/40 MHz"){
					table += "<td width=340>"+ bwl_ht2040 +"</td>";
				}else{
					table += "<td width=340>"+ wlan1_width +"</td>";
				}
				table += "<tr>";
				table += "<td class=duple>" + sd_channel + " : </td>";
				table += "<td width=340>" + wlan1_channel + "</td>";
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>" + LW2 + " : </td>";
				if (wps_enable != "1")
					table += "<td width=340>"+_disabled+"</td>";
				else {
					if (wps_configured_mode == "1") {
						table += "<td width=340>"+LW67+"</td>"; 
					}else{
						table += "<td width=340>"+LW66+"</td>";
					}
				}
				table += "</tr>";
				table += "<tr>";
				table += "<td class=duple>"+ssid_lst+" :</td>";
				table += "</tr>";
			}
		}//wlan1
		table += "</table>";
		$('#wireless_status2').append(table);
	}
	
	function show_mem_table() 
	{
		$('#mem_show').empty();
		var table = "<table cellpadding=1 cellspacing=1 border=0 width=525>";
		table += "<tr>";
		table += "<td class=duple>" + _memtotal + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;"+ mem_total_status +"MB</td>";
		table += "</tr>";
		table += "<tr>";
		table += "<td class=duple>" + _memused + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;"+ mem_used_status + "MB</td>";
		table += "</tr>";
		table += "<tr>";
		table += "<td class=duple>" + _memfree + " : </td>";
		table += "<td width=340>&nbsp;&nbsp;" + mem_free_status + "MB</td>";
		table += "</tr>";
		table += "</table>";
		$('#mem_show').append(table);
	}


	function set_mac_info()
	{
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		var tmp_lan_pc = new Array();
		for (var i = 0; i < temp_dhcp_list.length; i++) {
			if (tmp_lan_pc.length == 0) {
				tmp_lan_pc.push(temp_dhcp_list[i]);
			} else {
				var tdata = temp_dhcp_list[i].split("/");
				var tflag = 0;
				for (var j = 0; j < tmp_lan_pc.length; j++) {
					var pdata = tmp_lan_pc[j].split("/");
					if (pdata[0] == tdata[0]) {
						tflag = 1;
						break;
					}
				}
				if (tflag == 0)
					tmp_lan_pc.push(temp_dhcp_list[i]);
			}
		}

		for (var i = 0; i < tmp_lan_pc.length; i++){	
			var temp_data = tmp_lan_pc[i].split("/");
			if(temp_data.length != 0){		
				if(temp_data.length > 1){
					if(temp_data[1] == "")temp_data[1]="(null)";
					document.write("<tr><td>" + temp_data[0] + "</td><td>" + temp_data[1] + "</td><td>" + temp_data[2] + "</td></tr>");
				}
			}
		}
	}
	
	function set_igmp_info()
	{
		var temp_igmp = get_by_id("igmp_list").value.split(",");
		
		for (var i = 0; i < temp_igmp.length; i++){	
			if(temp_igmp.length > 1){
				document.write("<tr><td>" + temp_igmp[i] + "</td></tr>")
			}
		}
	}

	function get_time()
	{
		if (gTime == ""){
			return;
		}
		var time = gTime.split("/");
		nNow = new Date(time[0],time[1]-1,time[2],time[3],time[4],time[5]); // Date type's month define 0~11
	}
    
	function STime()
	{
		nNow.setTime(nNow.getTime() + 1000);
		if(/chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName))
		{
			get_by_id("show_time").innerHTML = nNow.toLocaleString().substring(0,24);
		}
		else
		{
			get_by_id("show_time").innerHTML = nNow.toLocaleString();
		}
		setTimeout('STime()', 1000);
	}

	function padout(number)
	{
		return (number < 10) ? '0' + number : number;
	}

	function caculate_time(){
		var wTime = wTimesec;
		var days = Math.floor(wTime / 86400);
		wTime %= 86400;
		var hours = Math.floor(wTime / 3600);
		wTime %= 3600;
		var mins = Math.floor(wTime / 60);
		wTime %= 60;

		wan_time = days + " " + 
			((days <= 1) ? "Day" : "Days")
			+ ", ";
		wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
	}
	
	function get_wan_time()
	{
		wTimesec = "<!--# exec cgi /bin/system_time get_wantime 1 -->";
		if(wTimesec == 0 || con_status == "Disconnected" || con_status == "" || con_status == "Connecting"){
			wan_time = "N/A";
			get_by_id("show_uptime").innerHTML = wan_time;
		}else{
			caculate_time();
		}
	}
	
	function WTime()
	{	
		if(con_status == "Disconnected" || con_status == "" || con_status == "Connecting") {
			wan_time = "N/A";
			wTimesec = 0;
		}
		
		get_by_id("show_uptime").innerHTML = wan_time;
		if(wTimesec != 0){
			wTimesec++;
			caculate_time();
		}
		setTimeout('WTime()', 1000);
	}
    	function get_mydlink_status() {
		var mydlink_ser = "<!--# echo register_st -->"; //nvram server key
		var mydlink_acc = "<!--# echo mydlink_EmailAccount -->"; //nvram server key
		var admin_password = "<!--# exec cgi /bin/stat_info mydlink_admin_check -->";
		if (mydlink_ser == 1 && admin_password.search("true") != -1){
			get_by_id("mydlink_status").innerHTML = _registered;
			get_by_id("mydlink_emailaccount").innerHTML = mydlink_acc;
		} else {
			get_by_id("mydlink_status").innerHTML = _n_registered;
			get_by_id("show_mydlink_account").style.display = "none";
		}
	}
	function set_wan_info(ip, netmask, gateway, dns1, dns2, net_status)
	{
		var russia_mode = 0;
		if (get_by_id("wan_pppoe_russia_enable").value == "1" || get_by_id("wan_pptp_russia_enable").value == "1"
			|| get_by_id("wan_l2tp_russia_enable").value == "1")
			russia_mode = 1;
		if(net_status == "Connecting" || net_status == "1" || (russia_mode == 1 && ip != "NULL")) {
			get_by_id("wan_ip").innerHTML = ip === "NULL" ? "0.0.0.0" : ip;
			get_by_id("wan_netmask").innerHTML = netmask === "NULL" ? "0.0.0.0" : netmask;
			get_by_id("wan_gateway").innerHTML = gateway === "NULL" ? "0.0.0.0" : gateway;
			get_by_id("wan_dns1").innerHTML = dns1 === "NULL" ? "0.0.0.0" : dns1;
	                get_by_id("wan_dns2").innerHTML = dns2 === "NULL" ? "0.0.0.0" : dns2;
		} else {
			get_by_id("wan_ip").innerHTML = ip = "0.0.0.0";
			get_by_id("wan_netmask").innerHTML = netmask = "0.0.0.0";
			get_by_id("wan_gateway").innerHTML = gateway = "0.0.0.0";
			get_by_id("wan_dns1").innerHTML = dns1 = "0.0.0.0";
	                get_by_id("wan_dns2").innerHTML = dns2 = "0.0.0.0";
		}

	}

	function connect_or_disconnect(net_status, con_status)
	{
		return (net_status === "1" && con_status !== "Disconnected") ? CONNECTED : DISCONNECTED;
	}

	function mbutton(type, net_status)
	{
		if (cnt != 0) {
			get_by_id("disconnect").disabled = true;
			get_by_id("connect").disabled = true;
			return;
		}

		if (type === "dhcp") {
			if (net_status === "1") {
				get_by_id("disconnect").disabled = false;
				get_by_id("connect").disabled = true;
			} else {
				get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = false;
			}
		} else if (type === "pptp" || type === "l2tp" || type === "pppoe"){
			if (net_status === "1" && con_status !== "Disconnected") {
				get_by_id("disconnect").disabled = false;
				get_by_id("connect").disabled = true;
			} else {
				get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = false;
			}
		} else if (type === "usb3g" || type === "3gphone"){
			if (net_status === "1" && gateway !== "NULL") {
				get_by_id("disconnect").disabled = false;
				get_by_id("connect").disabled = true;
			} else {
				get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = false;
			}
		}
		var login_who= checksessionStorage();
        if(login_who== "user"){
                get_by_id("disconnect").disabled = true;
				get_by_id("connect").disabled = true;
        }
	}
	
	function show_connection_button(net_status){
		
			if (get_by_id("wan_proto").value == "dhcpc") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + sd_Renew + "\" onclick=wan_connection_type(\"dhcp_renew\")>";
					get_by_id("show_connect_button").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + sd_Release + "\" onclick=wan_connection_type(\"dhcp_release\")>";
					mbutton("dhcp", net_status);
			}
			if (get_by_id("wan_proto").value == "pptp") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"pptp_connect\")>";
					get_by_id("show_connect_button").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"pptp_disconnect\")>";
					mbutton("pptp", net_status);
			}
			if (get_by_id("wan_proto").value == "l2tp") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"l2tp_connect\")>";
					get_by_id("show_connect_button").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"l2tp_disconnect\")>";
					mbutton("l2tp", net_status);
			}
			if (get_by_id("wan_proto").value == "pppoe") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"pppoe_connect\")>";
					get_by_id("show_connect_button").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"pppoe_disconnect\")>";
					mbutton("pppoe", net_status);
			}
			if (get_by_id("wan_proto").value == "usb3g") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"usb3g_connect\")>";
					get_by_id("show_connect_button").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"usb3g_disconnect\")>";
					mbutton("usb3g", net_status);
			}
			if (get_by_id("wan_proto").value == "usb3g_phone") {
					get_by_id("show_connect_button").innerHTML = "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"usb3g_phone_connect\")>";
					get_by_id("show_connect_button").innerHTML += "<input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"usb3g_phone_disconnect\")>";
					mbutton("3gphone", net_status);
			}		
	}
	
	function set_dhcp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		get_by_id("connection_type").innerHTML = ZM5;
		//get_by_id("connection_type").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + sd_Release + "\" onclick=wan_connection_type(\"dhcp_release\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + sd_Renew + "\" onclick=wan_connection_type(\"dhcp_renew\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = net_status == 1 ? _sdi_s4b : DISCONNECTED;
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("dhcp", net_status);
	}

	function set_static(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		get_by_id("connection_type").innerHTML = fixed_ip;
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = net_status == 1 ? _sdi_s4b : DISCONNECTED;
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
	}


	function set_pptp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		var conn_type = "";
		/*
		if(get_by_id("wan_pptp_dynamic").value == "0")
                	conn_type = fixed_ip;
		else
		*/
		if ("<!--# echo wan_pptp_russia_enable -->" == "1")
			conn_type = _RPPTP;
		else
			conn_type = _PPTP;
		get_by_id("connection_type").innerHTML = conn_type;
		//get_by_id("connection_type").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"pptp_disconnect\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"pptp_connect\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = connect_or_disconnect(net_status, con_status);
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("pptp", net_status);
	}
	
	function set_l2tp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		var conn_type = "";
		/*
		if(get_by_id("wan_l2tp_dynamic").value == "0")
                	conn_type = fixed_ip;
		else
		*/
		if ("<!--# echo wan_l2tp_russia_enable -->" == "1")
			conn_type = _RL2TP;
		else
			conn_type = _L2TP;
		get_by_id("connection_type").innerHTML = conn_type;
		//get_by_id("connection_type").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"l2tp_disconnect\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"l2tp_connect\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = connect_or_disconnect(net_status, con_status);
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("l2tp", net_status);
	}
	
	function set_poe(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		var conn_type = "";
		/*
		if(get_by_id("wan_pppoe_dynamic_00").value == "0")
                	conn_type = fixed_ip;
		else
		*/
		if ("<!--# echo wan_pppoe_russia_enable -->" == "1")
			conn_type = _RPPPoE;
		else
			conn_type = _PPPoE;
		get_by_id("connection_type").innerHTML = conn_type;
		//get_by_id("connection_type").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"pppoe_disconnect\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"pppoe_connect\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = connect_or_disconnect(net_status, con_status);
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("pppoe", net_status);
	}
	
	function set_usb3g(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		get_by_id("connection_type").innerHTML = usb_3g;
		//get_by_id("connection_type").innerHTML += " <input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"usb3g_disconnect\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"usb3g_connect\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = (net_status == 1 && gateway !== "NULL" ) ? _sdi_s4b : DISCONNECTED;
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("usb3g", net_status);
	}

	function set_usb3g_phone(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status)
	{
		get_by_id("connection_type").innerHTML = usb_3g_phone;
		//get_by_id("connection_type").innerHTML += "<input type=button id=disconnect name=disconnect value=\"" + LS315 + "\" onclick=wan_connection_type(\"usb3g_phone_disconnect\")>";
		//get_by_id("connection_type").innerHTML += "<input type=button id=connect name=connect value=\"" + _connect + "\" onclick=wan_connection_type(\"usb3g_phone_connect\")>";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = (net_status == 1 && gateway !== "NULL" ) ? _sdi_s4b : DISCONNECTED;
		set_wan_info(ip, netmask, gateway, dns1, dns2, net_status);
		//mbutton("3gphone", net_status);
	}

	function set_dslite(net_status, cab_status, con_status, aftr_address, aftr_enable)
	{
		get_by_id("connection_type").innerHTML = "DS-Lite";
		get_by_id("cable_status").innerHTML = cab_status === "connect" ? CONNECTED : DISCONNECTED;
		get_by_id("network_status").innerHTML = connect_or_disconnect(net_status, con_status);
		get_by_id("tr_aftr_address").style.display="";
		get_by_id("tr_dslite_dhcp").style.display="";
		get_by_id("net_status").style.display="none";
		for(i = 1 ; i <= 6 ; i++) {
			var obj = get_by_id("dslite_unuse"+i);
			if (obj) obj.style.display="none";
		}

		if(net_status == 1){
			if(aftr_enable == "1"){
				get_by_id("aftr_address").innerHTML = aftr_address;
				get_by_id("dslite_dhcp").innerHTML = "Enabled";
			}else{
				get_by_id("aftr_address").innerHTML = "<!--# echo wan_dslite_aftr -->";
				get_by_id("dslite_dhcp").innerHTML = "Disabled";
			}
		}else{
			get_by_id("aftr_address").innerHTML = "None";
			get_by_id("dslite_dhcp").innerHTML = "Disabled";
		}
	}

	function set_wlan_channel(wlan0_channel, wlan1_channel)
	{
		if("<!--# echo feature_wlan_mode -->" !== "concurrent") {
			var wlan0_status = "<!--# echo wlan0_radio_mode -->";
			if (wlan0_status === "0") {
				get_by_id("wlan0").style.display="";
				get_by_id("wlan1").style.display="none";
			} else {
				get_by_id("wlan0").style.display="none";
				get_by_id("wlan1").style.display="";
			}
		} else {
				get_by_id("wlan0").style.display="";
				get_by_id("wlan1").style.display="";
		}
	}

	function xmldoc()
	{ 
		var dns1 = "", dns2 = "", ip = "", netmask = "", gateway = "";
		var net_status = ""; cab_status = "";
		var uptime_status = "";
		var aftr_address = "", aftr_enable = "";
		
		
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			try{
				logged = xmlhttp.responseXML.getElementsByTagName("logged")[0].firstChild.nodeValue;
				ip = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue;
				netmask = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;
				gateway = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
				dns1 = xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
				dns2 = xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
				net_status = xmlhttp.responseXML.getElementsByTagName("wan_network_status")[0].firstChild.nodeValue;
				con_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue;
				cab_status = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
				//uptime_status = xmlhttp.responseXML.getElementsByTagName("uptime")[0].firstChild.nodeValue;
				cpu_usr_status = xmlhttp.responseXML.getElementsByTagName("cpu_usr")[0].firstChild.nodeValue;
				cpu_sys_status = xmlhttp.responseXML.getElementsByTagName("cpu_sys")[0].firstChild.nodeValue;
				cpu_idle_status = xmlhttp.responseXML.getElementsByTagName("cpu_idle")[0].firstChild.nodeValue;
				cpu_io_status = xmlhttp.responseXML.getElementsByTagName("cpu_io")[0].firstChild.nodeValue;
				
				mem_total_status = xmlhttp.responseXML.getElementsByTagName("mem_total")[0].firstChild.nodeValue;
				mem_used_status = xmlhttp.responseXML.getElementsByTagName("mem_used")[0].firstChild.nodeValue;
				mem_free_status = xmlhttp.responseXML.getElementsByTagName("mem_free")[0].firstChild.nodeValue;
				aftr_address = xmlhttp.responseXML.getElementsByTagName("aftr_address")[0].firstChild.nodeValue;
				aftr_enable = xmlhttp.responseXML.getElementsByTagName("aftr_enable")[0].firstChild.nodeValue;

				wps_enable=xmlhttp.responseXML.getElementsByTagName("wps_enable")[0].firstChild.nodeValue;
				wps_configured_mode=xmlhttp.responseXML.getElementsByTagName("wps_configured_mode")[0].firstChild.nodeValue;				
				
				wlan0_exist =xmlhttp.responseXML.getElementsByTagName("wlan0_enable")[0].firstChild.nodeValue;
				wlan0_mode=xmlhttp.responseXML.getElementsByTagName("wlan0_mode")[0].firstChild.nodeValue;
				wlan0_channel = xmlhttp.responseXML.getElementsByTagName("wlan_channel")[0].firstChild.nodeValue;
				wlan0_width= xmlhttp.responseXML.getElementsByTagName("wlan0_width")[0].firstChild.nodeValue;				
				wlan0_ssid= xmlhttp.responseXML.getElementsByTagName("wlan0_ssid")[0].firstChild.nodeValue;
				wlan0_security= xmlhttp.responseXML.getElementsByTagName("wlan0_security")[0].firstChild.nodeValue;
				wlan0_guest_ssid= xmlhttp.responseXML.getElementsByTagName("wlan0_guest_ssid")[0].firstChild.nodeValue;
				wlan0_guest_security= xmlhttp.responseXML.getElementsByTagName("wlan0_guest_security")[0].firstChild.nodeValue;
				wlan0_guest_enable= xmlhttp.responseXML.getElementsByTagName("wlan0_guest_enable")[0].firstChild.nodeValue;
				
				
				wlan1_exist =xmlhttp.responseXML.getElementsByTagName("wlan1_enable")[0].firstChild.nodeValue;
				wlan1_mode=xmlhttp.responseXML.getElementsByTagName("wlan1_mode")[0].firstChild.nodeValue;
				wlan1_channel = xmlhttp.responseXML.getElementsByTagName("wlan1_channel")[0].firstChild.nodeValue;
				wlan1_width= xmlhttp.responseXML.getElementsByTagName("wlan1_width")[0].firstChild.nodeValue;
				wlan1_ssid= xmlhttp.responseXML.getElementsByTagName("wlan1_ssid")[0].firstChild.nodeValue;
				wlan1_security= xmlhttp.responseXML.getElementsByTagName("wlan1_security")[0].firstChild.nodeValue;
				wlan1_guest_ssid= xmlhttp.responseXML.getElementsByTagName("wlan1_guest_ssid")[0].firstChild.nodeValue;
				wlan1_guest_security= xmlhttp.responseXML.getElementsByTagName("wlan1_guest_security")[0].firstChild.nodeValue;				
				wlan1_guest_enable= xmlhttp.responseXML.getElementsByTagName("wlan1_guest_enable")[0].firstChild.nodeValue;
				
				wTimesec = xmlhttp.responseXML.getElementsByTagName("wan_uptime")[0].firstChild.nodeValue;
				check_logout();
				show_cpu_table();
				show_mem_table();
				disable_wireless(wlan0_exist,wlan1_exist);
				show_wireless_status();
				show_wireless_status2();
				show_ssid_status();
				show_ssid_status2();
				time="<!--# echo session_timeout -->";
				clearTimeout("time_out()");
			}catch(e){
				dns1 = "0.0.0.0"; dns2 = "0.0.0.0"; ip = "0.0.0.0"; netmask = "0.0.0.0"; gateway = "0.0.0.0";
				con_status = ""; net_status = ""; cab_status = "";cpu_usr_status="N/A";cpu_sys_status="N/A";
				cpu_idle_status="N/A";cpu_io_status="N/A";uptime_status="N/A";
				mem_total_status="N/A";mem_used_status="N/A";mem_free_status = "N/A";
				aftr_address = "None"; aftr_enable = "0";
				wlan0_channel = "";
				wlan1_channel = "";
				wTimesec = 0;
				wlan0_exist="",wlan1_exist="";
				wlan0_mode="",wlan1_mode="";
				wlan0_channel = "", wlan1_channel = "";
				wlan0_width="", wlan1_width="";
				wlan0_ssid="", wlan0_security="",wlan0_guest_ssid="",wlan0_guest_security="";
				wlan1_ssid="", wlan1_security="",wlan1_guest_ssid="",wlan1_guest_security="";
				wps_enable="",wps_configured_mode="";
			}

			if (cnt != 0) {
				cnt--;
			}

			if(aftr_address !== "None" && aftr_address !== "NULL" && aftr_address !== "(null)" &&
				"<!--# echo ipv6_wan_proto -->" === "ipv6_autodetect") {
				get_by_id("wan_proto").value = "dslite";
			} else {
				get_by_id("wan_proto").value = "<!--# echo wan_proto_ori -->";
				for(var i = 1 ; i <= 6 ; i++) {
					var obj = get_by_id("dslite_unuse"+i);
					if (obj) obj.style.display="";
				}
		                get_by_id("tr_aftr_address").style.display="none";
		                get_by_id("tr_dslite_dhcp").style.display="none";
			}
			
			if (get_by_id("wan_proto").value == "static") {
				set_static(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "dhcpc") {
				set_dhcp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "pptp") {
				set_pptp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "l2tp") {
				set_l2tp(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "pppoe") {
				set_poe(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "usb3g") {
				set_usb3g(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "usb3g_phone") {
				set_usb3g_phone(ip, netmask, gateway, dns1, dns2, net_status, cab_status, con_status);
			}
			if (get_by_id("wan_proto").value == "dslite") {
				set_dslite(net_status, cab_status, con_status, aftr_address, aftr_enable);
			}
			set_wlan_channel(wlan0_channel, wlan1_channel);
			//get_by_id("uptime").innerHTML = uptime_status;
			show_connection_button(net_status);
			//show wan_up time
			if(wTimesec == 0 || con_status == "Disconnected"){
				wan_time = _NA;
			}else{
				caculate_time();
			}
		}
		if ("<!--# echo feature_mbssid -->" == "y") {
			get_by_id("wlan0").style.display="none";
		}
    	}
	function check_logout(){
		if(logged !="1"){
			window.location.href="login_pic.asp";
		}
	}
	function get_File() {
		xmlhttp = new createRequest();
		if(xmlhttp){
			var url = "";
			var temp_cURL = document.URL.split("/");
			for (var i = 0; i < temp_cURL.length-1; i++) {
				if (i == 1) continue;
				if ( i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += "device_status.xml";
			xmlhttp.onreadystatechange = xmldoc; 
			xmlhttp.open("GET", url, true); 
			xmlhttp.send(null); 
		}
		setTimeout("get_File()", 3000);
	}
	
	function createRequest() {
		var XMLhttpObject = false;
		if (window.XMLHttpRequest) {
			try {
				XMLhttpObject = new XMLHttpRequest();
			} catch (e) {
			}
		} else if (window.ActiveXObject) {
			try {
				XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					return null;
				}
			}
		}
		return XMLhttpObject;
	}

	function show_wlan_mode(mode)
	{
		
		var op = new Array("11b", "11g", "11n", "11bg", "11gn", "11bgn", "11na", "11a", "11ac", "11ac_only", "11ac_11n");
                var value = new Array(bwl_Mode_1, bwl_Mode_2, bwl_Mode_n, bwl_Mode_3, bwl_Mode_10, bwl_Mode_11, bwl_Mode_5, bwl_Mode_a, bwl_Mode_13, bwl_Mode_15, bwl_Mode_14);

		for (var i = 0; i < op.length; i++) {
			if (op[i] == mode) {
				return value[i];
				break;
			}
		}
	}
	</script>
    </head>
    <input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list local_lan_ip -->">
    <input type="hidden" id="igmp_list" name="igmp_list" value="<!--# exec cgi /bin/cmo_get_list igmp_table -->">
        <body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
            <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
                <tr>
                    <td width="100%">&nbsp;&nbsp;
			<script>show_words(TA2)</script>:
			<a href="http://support.dlink.com.tw/"><!--# echo model_number --></a>
                    </td>
                    <td align="right" nowrap>
			<script>show_words(TA3)</script>: <!--# echo sys_hw_version -->&nbsp;
                    </td>
                    <td align="right" nowrap>
			<script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA -->
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
                <tr>
                    <td align="center" valign="middle">
                        <img src="/wlan_masthead.gif" width="836" height="92">
                    </td>
                </tr>
            </table>
            <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
                <tr id="topnav_container">
                    <td><img src="/short_modnum.gif" width="125" height="25"></td>
                    <script>show_top("status");</script>
                </tr>
            </table>
            <table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
                <tr>
                    <td id="sidenav_container" valign="top" width="125" align="right">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td id="sidenav_container">
                                    <div id="sidenav">
                                        <!-- === BEGIN SIDENAV === -->
                                        <ul>
                                            <script>show_left("Status", 0);</script>
                                        </ul>
                                        <!-- === END SIDENAV === -->
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
    <form id="form1" name="form1" method="post" action="st_device.cgi">
        
	<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp">
	<input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<!--# echo wan_current_ipaddr_00 -->">
	<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto_ori -->">
	<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<!--# echo wan_pppoe_dynamic_00 -->">
	<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<!--# echo wan_pptp_dynamic -->">
	<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<!--# echo wan_l2tp_dynamic -->">
	<input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<!--# echo dhcpd_enable -->">
	<input type="hidden" id="dhcpc_connection_status" name="dhcpc_connection_status" value="<!--# echo dhcpc_connection_status -->">
	<input type="hidden" id="pppoe_00_connection_status" name="pppoe_00_connection_status" value="<!--# echo pppoe_00_connection_status -->">
	<input type="hidden" id="pptp_connection_status" name="pptp_connection_status" value="<!--# echo pptp_connection_status -->">
	<input type="hidden" id="l2tp_connection_status" name="l2tp_connection_status" value="<!--# echo l2tp_connection_status -->">
	<input type="hidden" id="bigpond_connection_status" name="bigpond_connection_status" value="<!--# echo bigpond_connection_status -->">
	<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
	<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
	<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
	<input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<!--# echo wan_pptp_ipaddr -->">
<input type="hidden" id="russia_wan_phy_ipaddr" name="russia_wan_phy_ipaddr" value="<!--# echo russia_wan_phy_ipaddr -->">

                    <td valign="top" id="maincontent_container">
                        <div id="maincontent">
                            <!-- === BEGIN MAINCONTENT === -->
                            <div id="box_header">
                                <h1><script>show_words(sd_title_Dev_Info)</script></h1>
                                <script>show_words(sd_intro)</script>
                            </div>
                            <div class="box">
                                <h2><script>show_words(sd_General)</script></h2>
                                <table cellpadding="1" cellspacing="1" border="0" width="525">
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(_time)</script> :
                                        </td>
                                        <td width="340">
                                            &nbsp;&nbsp;<span id="show_time"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(sd_FWV)</script> :
                                        </td>
                                        <td width="340">
                                            &nbsp;&nbsp;<strong><!--# echo sys_fw_version --><!--# echox sys_region NA --> , <!--# echo sys_fw_date --></strong>
                                        </td>
                                    </tr>                                    
                                    <tr id="show_mydlink_status">
                                        <td class="duple">
                                            <script>show_words(_mydlink_service)</script> :
                                        </td>
                                        <td width="340">
                                            &nbsp;&nbsp;<span id="mydlink_status"></span>
                                        </td>
                                    </tr>                                    
                                    <tr id="show_mydlink_account">
                                        <td class="duple">
                                            <script>show_words(_mydlink_account)</script> :
                                        </td>
                                        <td width="340">
                                            &nbsp;&nbsp;<span id="mydlink_emailaccount"></span>
                                        </td>
                                    </tr>                                    
                                </table>
                            </div>
			    <div class="box" style="display:none">
				<h2><script>show_words(sd_CPU_utli)</script></h2>
				<!-- <div id="cpu_action"><a href="#cpu"><script>show_words(_graph)</script></a></div> -->
				<div id="cpu_show"></div>
			    </div>
			   <div class="box" style="display:none">
				<h2><script>show_words(sd_Mem_utli)</script></h2>
				<!-- <div id="mem_action"><a href="#mem"><script>show_words(_graph)</script></a></div> -->
				<div id="mem_show"></div>
                            </div>
                            <div class="box">
                                <h2><script>show_words(_WAN)</script></h2>
                                <table cellpadding="1" cellspacing="1" border="0" width="525">
                                    <tr>
                                        <td class="duple"><script>show_words(_contype)</script> :</td>
                                        <td width="340"><span id="connection_type"></span></td>
                                    </tr>
                                    <tr>
                                        <td class="duple"><script>show_words(_cablestate)</script> :</td>
                                        <td width="340"><span id="cable_status"></span></td>
                                    </tr>
                                    <tr>
                                        <td class="duple"><script>show_words(_networkstate)</script> :</td>
                                        <td width="340"><span id="network_status"></span></td>
                                    </tr>
                                    <tr>
                                        <td class="duple"><script>show_words(_conuptime)</script> :</td>
                                        <td width="340"><span id="show_uptime"></span></td>
                                    </tr>
                                    <tr id="net_status" style="display:yes">
                                        <td class="duple">&nbsp;</td>
                                        <td width="340"><span id="show_connect_button"></span></td>
                                    </tr>
                                    <tr>
                                        <td class="duple"><script>show_words(_macaddr)</script> :</td>
                                        <td width="340"><!--# echo wan_mac --></td>
                                    </tr>
                                    <tr id="dslite_unuse1">
                                        <td class="duple"><script>show_words(_ipaddr);</script> :</td>
                                        <td width="340"><span id="wan_ip"></span></td>
                                    </tr>
                                    <tr id="dslite_unuse2">
                                        <td class="duple"><script>show_words(_subnet)</script> :</td>
                                        <td width="340"><span id="wan_netmask"></span></td>
                                    </tr>
                                    <tr id="dslite_unuse3">
                                        <td class="duple"><script>show_words(_defgw)</script> :</td>
                                        <td width="340"><span id="wan_gateway"></span></td>
                                    </tr>
                                    <tr id="dslite_unuse4">
                                        <td class="duple"><script>show_words(_dns1)</script> :</td>
                                        <td width="340"><span id="wan_dns1"></span></td>
                                    </tr>
                                    <tr id="dslite_unuse5">
                                    <td class="duple"><script>show_words(_dns2)</script> :</td>
                                    <td width="340"><span id="wan_dns2"></span></td>
                                    <!--//2009/4/29 Tina add OPENDNS-->
                                    <!--tr id="dslite_unuse6">
                                        <td class="duple"><script>show_words(_st_AdvDns)</script> :</td>
                                        <td width="340"><span id="opendns_enable"></span></td>
                                    </tr-->
                                    <tr id="tr_aftr_address" style="display:none">
                                        <td class="duple">AFTR Address :</td>
                                        <td width="340"><span id="aftr_address"></span></td>
                                    </tr>
                                    <tr id="tr_dslite_dhcp" style="display:none">
                                        <td class="duple">DS-Lite DHCPv6 option :</td>
                                        <td width="340"><span id="dslite_dhcp"></span></td>
                                    </tr>
				    <script>
                                        //var opendns ="<!--# echo opendns_enable -->";
                                        //get_by_id("opendns_enable").innerHTML = (opendns=="1") ? _enabled:_disabled;
                                    </script>
                                    <!--//OPENDNS-->
                                    </tr>
                                </table>
                            </div>
                            <div class="box">
                                <h2><script>show_words(_LAN)</script></h2>
                                <table cellpadding="1" cellspacing="1" border="0" width="525">
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(_macaddr)</script> :
                                        </td>
                                        <td width="340">
                                            <!--# echo lan_mac -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(_ipaddr);</script> :
                                        </td>
                                        <td width="340">
                                            <!--# echo lan_ipaddr -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(_subnet)</script> :
                                        </td>
                                        <td width="340">
                                            <!--# echo lan_netmask -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="duple">
                                            <script>show_words(_dhcpsrv)</script> :
                                        </td>
                                        <td width="340">
                                            <script>
                                                if (get_by_id("dhcpd_enable").value == "1") {
                                                    document.write(_enabled);
                                                }
                                                else {
                                                    document.write(_disabled);
                                                }
                                            </script>
                                            <!-- insert name=dhcp_enable -->
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="box" id="wlan0" style="display:none">
                                <h2><script>show_words(sd_WLAN)</script></h2>
								
								<div id="wireless_status"></div>
                                <table cellpadding="1" cellspacing="1" border="0" width="525">

				    <tr id="show_wlan0_dot11_mode">
					</tr>
                                    <tr id="show_wlan_channel">
                                    </tr>
				    <tr id="show_wps_enable">
				    </tr>
				    <tr id="show_ssid_list0">
				    </tr>
				    <tr id="show_ssid_table0"></tr>					
                                </table>
                            </div>
				<div class="box" id="wlan1" style="display:none">
                                <h2><script>show_words(sd_WLAN)</script></h2>
				<div id="wireless_status2"></div>
				<table cellpadding="1" cellspacing="1" border="0" width="525">
				<tr id="show_wlan1_dot11_mode"></tr>
				<tr id="show_wlan1_channel"></tr>
				<tr id="show_wps_enabl1e"></tr>
				<tr id="show_ssid_list1"></tr>
				<tr id="show_ssid_table1"></tr>
				</table>
				</div>
                            <div class="box">
                                <h2><script>show_words(_LANComputers)</script></h2>
                                <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                                    <tr>
                                        <td>
                                            <script>show_words(_ipaddr);</script>
                                        </td>
                                        <td>
                                            <script>show_words(YM187)</script>
                                        </td>
                                        <td>
                                            <script>show_words(_mac)</script>
                                        </td>
                                    </tr>
                                    <script>
                                        set_mac_info();
                                    </script>
                                </table>
                            </div>
                            <div class="box">
                                <h2><script>show_words(_bln_title_IGMPMemberships)</script></h2>
                                <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                                    <tr>
                                        <td>
                                            <script>show_words(YM186)</script>
                                        </td>
                                    </tr>
                                    <script>
                                        set_igmp_info();
                                    </script>
                                </table>
                            </div>
                            <div id="renew_result" name="renew_result" style="display:none">
                                <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#ffffff border=1>
                                    <tr>
                                        <td>
                                            <IFRAME id="iframe_result" name="iframe_result" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no">
                                            </IFRAME>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- === END MAINCONTENT === -->
                        </div>
                    </td>
                    <td valign="top" width="150" id="sidehelp_container" align="left">
                        <table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                            <tr>
                                <td id="help_text">
                                    <strong><script>show_words(_hints);</script>&hellip;</strong>
                                    <p>
                                        <script>show_words(hhsd_intro)</script>.
                                    </p>
                                    <p>
                                        <a href="support_status.asp#Device_Info"><script>show_words(_more)</script>&hellip;</a>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
                <tr>
                    <td width="125" align="center">
                        &nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35">
                    </td>
                    <td width="10">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            </form>
            <br>
            <div id="copyright">
                <script>show_words(_copyright);</script>
            </div>
            <br>
            <script>
                get_time();
                STime();
		get_wan_time();
                WTime();
                get_File();
		get_mydlink_status();
 		//disable_wireless();
	    </script>
        </body>
        </html>
