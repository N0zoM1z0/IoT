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
	function onPageLoad(){
		var link_local ;
		var ipv4_wan_ip,ipv4_wan_ip_s;
		var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_valid_lifetime_l_one").value;
		get_by_id("ipv6_6in4_adver_lifetime").value = ipv6_advert_lifetime/60;
		link_local = get_by_id("link_local_ip_l").value;
	  	get_by_id("lan_link_local_ip").innerHTML= link_local.toUpperCase();
		ipv4_wan_ip = get_by_id("wan_current_ipaddr").value;
		if(ipv4_wan_ip.toUpperCase() == "(NULL)"){
			ipv4_wan_ip_s = '(' + _none + ')';
		}else{
			ipv4_wan_ip_s = ipv4_wan_ip.toUpperCase();
		}
		get_by_id("ipv4_6in4_wan_ip").innerHTML = ipv4_wan_ip_s;
		set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
		set_checked(get_by_id("ipv6_dhcp_pd_enable_l").value, get_by_id("ipv6_dhcp_pd_lan"));
		set_checked(get_by_id("ipv6_dhcp_pd_hint_enable").value, get_by_id("ipv6_dhcp_pd_hint_chk"));
		set_selectIndex("<!--# echo ipv6_autoconfig_type -->", get_by_id("ipv6_autoconfig_type"));
		set_ipv6_autoconfiguration_type();
		set_checked("<!--# echo ipv6_6in4_dns_enable -->", get_by_name("ipv6_dns_6in4_enable"));
		set_checked("<!--# echo ipv6_dhcp_pd_enable -->", get_by_id("ipv6_dhcp_pd_chk"));
		
		/*var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
		if (ipv6_wan_proto == get_by_id("ipv6_w_proto").value){
			set_checked("<!--# echo ipv6_6in4_dns_enable -->", get_by_name("ipv6_dns_6in4_enable"));
			set_checked("<!--# echo ipv6_dhcp_pd_enable -->", get_by_id("ipv6_dhcp_pd_chk"));
		}else{	
			set_checked("1", get_by_name("ipv6_dns_6in4_enable"));
			set_checked("0", get_by_id("ipv6_dhcp_pd_chk"));
		}*/
		disable_autoconfig();
		disable_ipv6_6in4_auto_dns();
		//disable_ipv6_dhcp_pd_chk();//spec 1.06
		disable_ipv6_dhcp_pd_nochkDNS(); //spec 1.08
		set_ipv6_stateful_range();	
		set_form_default_values("form1");
		
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}
	}

        function disable_autoconfig(){
                var disable = get_by_id("ipv6_autoconfig_sel").checked;
                get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
                get_by_id("ipv6_autoconfig_type").disabled = !disable;
                get_by_id("ipv6_addr_range_start_suffix").disabled = !disable;
                get_by_id("ipv6_addr_range_end_suffix").disabled = !disable;
                if(get_by_id("ipv6_dhcp_pd_chk").checked){
                        get_by_id("ipv6_dhcpd_lifetime").disabled = true;
                        get_by_id("ipv6_6in4_adver_lifetime").disabled = true;
			get_by_id("ipv6_dhcp_pd_lan").disabled = !disable;
                }else{
                        get_by_id("ipv6_dhcpd_lifetime").disabled = !disable;
                        get_by_id("ipv6_6in4_adver_lifetime").disabled = !disable;
			get_by_id("ipv6_dhcp_pd_lan").disabled = true;
                }
        }
	
	function disable_ipv6_6in4_auto_dns(){
	    var fixIP = get_by_name("ipv6_dns_6in4_enable");
	    var is_disabled;
	    if (fixIP[0].checked){
	    	is_disabled = true;
	    }else{
	    	is_disabled = false;
	    }
	    get_by_id("ipv6_6in4_primary_dns").disabled = is_disabled;
	    get_by_id("ipv6_6in4_secondary_dns").disabled = is_disabled;
	}
	function disable_ipv6_dhcp_pd_chk(){
		get_by_id("ipv6_6in4_lan_ip").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
		var is_checked = "1";
		var is_disabled;
	    if (get_by_id("ipv6_dhcp_pd_chk").checked){
	    	is_checked = "0";
	    	is_disabled = true;
		}else{
	    	is_checked = "1";
	    	is_disabled = false;
	    }
		set_checked(is_checked, get_by_name("ipv6_dns_6in4_enable"));
	    get_by_id("ipv6_6in4_primary_dns").disabled = is_disabled;
	    get_by_id("ipv6_6in4_secondary_dns").disabled = is_disabled;
		
		}

	function disable_ipv6_dhcp_pd_nochkDNS(){
		get_by_id("ipv6_6in4_lan_ip").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
		if(get_by_id("ipv6_autoconfig_sel").checked){
                        get_by_id("ipv6_dhcp_pd_lan").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcpd_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_6in4_adver_lifetime").disabled = get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_chk").disabled = !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_prefix").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_length").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_pltime").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                        get_by_id("ipv6_dhcp_pd_hint_vltime").disabled = 
                                !get_by_id("ipv6_dhcp_pd_hint_chk").checked || !get_by_id("ipv6_dhcp_pd_chk").checked;
                }
	}
		
	function set_ipv6_autoconf_range(){
		var ipv6_lan_ip = get_by_id("ipv6_6in4_lan_ip").value;
		var prefix_length = 64;
		var correct_ipv6="";		
		if(ipv6_lan_ip != ""){
			correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
			get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);										
		}		
	}
	function set_ipv6_stateful_range()
	{
			var prefix_length = 64;
			var ipv6_lan_ip = get_by_id("ipv6_6in4_lan_ip").value;
			var ipv6_dhcpd_start_range = get_by_id("ipv6_dhcpd_start").value;
			var ipv6_dhcpd_end_range = get_by_id("ipv6_dhcpd_end").value;
			var correct_ipv6="";	
			if(ipv6_lan_ip != ""){
					correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
					get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
					//get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);					
		    	get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);	
					//get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);					
      }
			get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);					
			get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);					
	}
	function set_ipv6_autoconfiguration_type(){
 		var mode = get_by_id("ipv6_autoconfig_type").selectedIndex;	
		switch(mode){
		case 0:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		case 1:
			set_ipv6_autoconf_range();
			get_by_id("ipv6_addr_range_start_prefix").disabled = true;
			get_by_id("ipv6_addr_range_end_prefix").disabled = true;
			get_by_id("show_ipv6_addr_range_start").style.display = "";
			get_by_id("show_ipv6_addr_range_end").style.display = "";
			get_by_id("show_ipv6_addr_lifetime").style.display ="";
			get_by_id("show_router_advert_lifetime").style.display = "none";
			break;
		default:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;	
		}  	
       }
function send_request(){ 
	var remote_ipv4 = get_by_id("ipv4_6in4_remote_ip").value;
	var remote_ipv4_msg = replace_msg(all_ip_addr_msg,IPV6_TEXT40);
	var temp_remote_ipv4 = new addr_obj(remote_ipv4.split("."), remote_ipv4_msg, false, false);
	var remote_ipv6 = get_by_id("ipv6_6in4_remote_ip").value;
	var remote_ipv6_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT41);
	var temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split(":"), remote_ipv6_msg, false, false);
	var local_ipv6 = get_by_id("ipv6_6in4_wan_ip").value;
	var local_ipv6_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT43);
	var temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split(":"), local_ipv6_msg, false, false);
	var primary_dns = get_by_id("ipv6_6in4_primary_dns").value;
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,_dns1);
	var secondary_dns = get_by_id("ipv6_6in4_secondary_dns").value;
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,_dns2);
	var ipv6_lan = get_by_id("ipv6_6in4_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,IPV6_TEXT46);
	var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
	var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
	var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var addr_lifetime_msg = replace_msg(check_num_msg, IPV6_TEXT68, 1, 999999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 1, 999999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, IPV6_TEXT69, 1, 35791395);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_6in4_adver_lifetime").value, adver_lifetime_msg , 1, 35791395, false);
	var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
	var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,IPV6_HINT_PREFIX);
	var hint_prefix = get_by_id("ipv6_dhcp_pd_hint_prefix").value;
        var temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split(":"), ipv6_static_msg, false, false);
        var prefix_length_msg = replace_msg(check_num_msg, IPV6_HINT_LENGTH, 0, 64);
        var prefix_length_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_length").value, prefix_length_msg, 0, 64, false);
        var pltime_msg = replace_msg(check_num_msg, IPV6_HINT_PLTIME, 1, 999999);
        var pltime_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_pltime").value, pltime_msg, 1, 999999, false);
        var vltime_msg = replace_msg(check_num_msg, IPV6_HINT_VLTIME, 1, 999999);
        var vltime_obj = new varible_obj(get_by_id("ipv6_dhcp_pd_hint_vltime").value, vltime_msg, 1, 999999, false);
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;

        var is_modify = is_form_modified("form1");
        if (!is_modify && !confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)) {
                        return false;
        }
	get_by_id("ipv6_dhcp_pd_enable").value = get_checked_value(get_by_id("ipv6_dhcp_pd_chk"));
	get_by_id("ipv6_dhcp_pd_hint_enable").value = get_checked_value(get_by_id("ipv6_dhcp_pd_hint_chk"));
	get_by_id("ipv6_dhcp_pd_enable_l").value = get_checked_value(get_by_id("ipv6_dhcp_pd_lan"));
	get_by_id("ipv6_6in4_dns_enable").value = get_checked_value(get_by_name("ipv6_dns_6in4_enable"));
	get_by_id("ipv6_wan_specify_dns").value= get_by_id("ipv6_6in4_dns_enable").value;

	// check the remote ipv4 address 
	if (!check_address(temp_remote_ipv4)){
		return false;
	}
	// check the remote ipv6 address
	if(check_ipv6_symbol(remote_ipv6,"::")==2){ // find two '::' symbol 
		return false;
	}else if(check_ipv6_symbol(remote_ipv6,"::")==1){    // find one '::' symbol	
		temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split("::"), remote_ipv6_msg, false, false);
		if (!check_ipv6_address(temp_remote_ipv6,"::")){
			return false;
		}
	}else{	//not find '::' symbol			
		temp_remote_ipv6 = new ipv6_addr_obj(remote_ipv6.split(":"), remote_ipv6_msg, false, false);
		if (!check_ipv6_address(temp_remote_ipv6,":")){
			return false;
		}
		}
		// check the local ipv6 address
		if(check_ipv6_symbol(local_ipv6,"::")==2){ // find two '::' symbol 
			return false;
		}else if(check_ipv6_symbol(local_ipv6,"::")==1){    // find one '::' symbol	
			temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split("::"), local_ipv6_msg, false, false);
			if (!check_ipv6_address(temp_local_ipv6,"::")){
				return false;
			}
		}else{	//not find '::' symbol			
			temp_local_ipv6 = new ipv6_addr_obj(local_ipv6.split(":"), local_ipv6_msg, false, false);
			if (!check_ipv6_address(temp_local_ipv6,":")){
				return false;
			}
		}
    //check DNS Address
	if(!get_by_name("ipv6_dns_6in4_enable")[0].checked){
//		if (primary_dns != ""){
			if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol 
				return false;
			}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol	
				temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns ,"::")){
					return false;
				} 
			}else{	//not find '::' symbol			
				temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
					return false;
				}
			}
//		}		
		if (secondary_dns != ""){
			if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol 
				return false;
			}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol	
				temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
  				if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::")){
					return false;
				}	 
								}else{	//not find '::' symbol			
											temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
											if (!check_ipv6_address(temp_ipv6_secondary_dns,":")){
												return false;
											}
								}					
			}	
		}

	if(get_by_id("ipv6_dhcp_pd_hint_chk").checked){
		if(check_ipv6_symbol(hint_prefix,"::") == 2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(hint_prefix,"::") == 1){    // find one '::' symbol
			temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split("::"), ipv6_static_msg, false, false);
			if(temp_hint_prefix.addr[temp_hint_prefix.addr.length-1].length == 0)
			temp_hint_prefix.addr[temp_hint_prefix.addr.length-1] = "1111";
			if (!check_ipv6_address(temp_hint_prefix,"::")){
				return false;
			}
		}else{  //not find '::' symbol
			temp_hint_prefix = new ipv6_addr_obj(hint_prefix.split(":"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_hint_prefix,":")){
				return false;
			}
		}
		if (!check_varible(prefix_length_obj))
			return false;
		if (!check_varible(pltime_obj))
			return false;
		if (get_by_id("ipv6_dhcp_pd_hint_vltime").value != "" && !check_varible(vltime_obj))
			return false;
	}
	
		//check LAN IP Address
		if(!get_by_id("ipv6_6in4_lan_ip").disabled) {
		if(check_ipv6_symbol(ipv6_lan,"::")==2){ // find two '::' symbol 
			return false;
		}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol	
			temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan ,"::")){
				return false;
			} 
		}else{	//not find '::' symbol			
			temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan,":")){
				return false;
			}
		}        
		}
		if((check_mode == 0 || check_mode == 2) && enable_autoconfig == 1){
    			//check the Router Advertisement Lifetime
    			if (!check_varible(adver_lifetime_obj)){
    				return false;
    			}  
    		  //set Advertisement Lifetime		
			get_by_id("ipv6_ra_adv_valid_lifetime_l_one").value = get_by_id("ipv6_6in4_adver_lifetime").value * 60 ;
                        get_by_id("ipv6_ra_adv_prefer_lifetime_l_one").value = get_by_id("ipv6_6in4_adver_lifetime").value * 60 ;		 		
    }else if(check_mode == 1 && enable_autoconfig == 1){
    		  //check the suffix of Address Range(Start)
    		  if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,IPV6_TEXT70)){
							return false;
					}
					//check the suffix of Address Range(End)
					if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,IPV6_TEXT71)){
							return false;
					}
					//compare the suffix of start and the suffix of end
					if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix)){
    				return false;
    			}    			    
    			//check the IPv6 Address Lifetime
    			if (!check_varible(addr_lifetime_obj)){
    				return false;
    			}
  				//set autoconfiguration range value
					get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + ":" +	get_by_id("ipv6_addr_range_start_suffix").value;
					get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + ":" + get_by_id("ipv6_addr_range_end_suffix").value;  			
    }		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
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
<script>show_top("setup");</script>
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
                         <script>show_left("Setup", 9);</script>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td> 
	       <form id="form1" name="form1" method="post" action="apply.cgi">
	       	    <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
		    <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6in4.asp">
		    <input type="hidden" id="action" name="action" value="adv_ipv6_6in4">
		    <input type="hidden" id="reboot_type" name="reboot_type" value="wan">
		    <input type="hidden" id="result_timer" name="result_timer" value="20">
		    <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<!--# echo ipv6_autoconfig -->">
		    <input type="hidden" id="ipv6_dhcp_pd_enable" name="ipv6_dhcp_pd_enable" value="<!--# echo ipv6_dhcp_pd_enable -->">
		    <input type="hidden" id="ipv6_dhcp_pd_hint_enable" name="ipv6_dhcp_pd_hint_enable" value="<!--# echo ipv6_dhcp_pd_hint_enable -->">
		    <input type="hidden" id="ipv6_dhcp_pd_enable_l" name="ipv6_dhcp_pd_enable_l" value="<!--# echo ipv6_dhcp_pd_enable_l -->">
		    <input type="hidden" id="ipv6_6in4_dns_enable" name="ipv6_6in4_dns_enable" value="<!--# echo ipv6_6in4_dns_enable -->">
		    <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<!--# echo ipv6_dhcpd_start -->">
		    <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<!--# echo ipv6_dhcpd_end -->"> 							
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<!--# echo ipv6_wan_proto -->">
                    <input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value="<!--# echo ipv6_ra_adv_valid_lifetime_l_one -->">
                    <input type="hidden" id="ipv6_ra_adv_prefer_lifetime_l_one" name="ipv6_ra_adv_prefer_lifetime_l_one" value="<!--# echo ipv6_ra_adv_prefer_lifetime_l_one -->">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<!--# exec cgi /bin/ipv6 link_local_ip_l -->">
		    <input type="hidden" maxLength=80 size=80 name="wan_current_ipaddr" id="wan_current_ipaddr" value="<!--# exec cgi /bin/ipv6 wan_current_ipaddr_00 -->">
		     <input type="hidden" id="page_type" name="page_type" value="IPv6">	
				<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
                    <script>show_words(IPV6_TEXT28)</script>
					<br>
                    <br> 
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" id="button2" type=button class=button_submit value="" onclick="return page_cancel('form1', 'adv_ipv6_6in4.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                 </div>
                  <div class=box>
                    <h2 style=" text-transform:none"> 
                   <script>show_words(IPV6_TEXT29)</script></h2>
				   <p class="box_msg"><script>show_words(IPV6_TEXT30)</script></p>				    
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple"><script>show_words(IPV6_TEXT31)</script> :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
			<option value="ipv6_autodetect"><script>show_words(IPV6_TEXT32b);</script></option>
                        <option value="ipv6_static" ><script>show_words(IPV6_TEXT32);</script></option>
                        <option value="ipv6_autoconfig"><script>show_words(IPV6_TEXT32a);</script></option>
                        <option value="ipv6_pppoe"><script>show_words(IPV6_TEXT34);</script></option>
                        <option value="ipv6_6in4" selected><script>show_words(IPV6_TEXT35);</script></option>
                        <option value="ipv6_6to4" ><script>show_words(IPV6_TEXT36);</script></option>
                        <option value="ipv6_6rd"><script>show_words(IPV6_TEXT36a);</script></option>
                        <option value="link_local"><script>show_words(IPV6_TEXT37a);</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
	         <div class=box id=wan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT38);</script></h2> 
					<p class="box_msg"><script>show_words(IPV6_TEXT39);</script> </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
						<tr>
							 <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT40);</script> :</td>
							 <td width="331">&nbsp;<input type=text id="ipv4_6in4_remote_ip" name="ipv4_6in4_remote_ip" size="16" maxlength="15" value="<!--# echo ipv4_6in4_remote_ip -->"></td>
						</tr>
						<tr>
							<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT41);</script> :</td>
							<td width="331">&nbsp;<input type=text id="ipv6_6in4_remote_ip" name="ipv6_6in4_remote_ip" size="30" maxlength="39" value="<!--# echo ipv6_6in4_remote_ip -->"></td>
						</tr>
						<tr>
							 <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT42);</script> :</td>
				                              <td width="331">&nbsp;
                                				<b><span id="ipv4_6in4_wan_ip"></span></b>
                         				</td>
						</tr>
						<tr>
							<td width="187" align=right class="duple"><script>show_words(IPV6_TEXT43);</script> :</td>
							<td width="331">&nbsp;<input type=text id="ipv6_6in4_wan_ip" name="ipv6_6in4_wan_ip" size="30" maxlength="39" value="<!--# echo ipv6_6in4_wan_ip -->"></td>
						</tr>	
	                </table>
                 </div>
	         <div class=box id=wan_ipv6_dns_settings>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT63);</script></script></h2>
					<p class="box_msg"><script>show_words(IPV6_TEXT64);</script> </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
						<tr>
							<td width="187" align=right><input type="radio" name="ipv6_dns_6in4_enable" value="0" onClick="disable_ipv6_6in4_auto_dns()" checked></td>
							<td width="331">&nbsp;<script>show_words(IPV6_TEXT65);</script></td>
						</tr>
						<tr>
							<td width="187" align=right><input type="radio" name="ipv6_dns_6in4_enable" value="1" onClick="disable_ipv6_6in4_auto_dns()"></td>
							<td width="331">&nbsp;<script>show_words(IPV6_TEXT66);</script></td>
						</tr>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(_dns1);</script> :</td>
	                      <td width="331">&nbsp;<input type=text id="ipv6_6in4_primary_dns" name="ipv6_6in4_primary_dns" size="30" maxlength="39" value="<!--# echo ipv6_6in4_primary_dns -->"></td>
	                    </tr>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(_dns2);</script> :</td>
	                      <td width="331">&nbsp;<input type=text id="ipv6_6in4_secondary_dns" name="ipv6_6in4_secondary_dns" size="30" maxlength="39" value="<!--# echo ipv6_6in4_secondary_dns -->"></td>
	                    </tr>
	                </table>
                 </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44);</script></h2>
					<p align="justify" class="box_msg"><script>show_words(IPV6_TEXT45);</script> </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT45a);</script> :</td>
	                      <td width="331">&nbsp;<input type=checkbox id="ipv6_dhcp_pd_chk" name="ipv6_dhcp_pd_chk" value="1" onclick="disable_ipv6_dhcp_pd_nochkDNS();"></td>
	                    </tr>
			    <tr id="tr_dhcp_pd_hint_chk" style="display:none ">
                                        <td width="187" align=right class="duple"><script>show_words(IPV6_HINT_CONF);</script> :</td>
                                        <td width="331">&nbsp;<input type=checkbox id="ipv6_dhcp_pd_hint_chk" name="ipv6_dhcp_pd_hint_chk" value="1" onclick="disable_ipv6_dhcp_pd_nochkDNS();"></td>
                            </tr>
			    <tr id="tr_dhcp_pd_hint_prefix" style="display:none ">
                        <td width="187" align=right><b><script>show_words(IPV6_HINT_PREFIX);</script> :</b></td>
                        <td width="331" align=left>&nbsp;<b>
                                <input type=text id="ipv6_dhcp_pd_hint_prefix" name="ipv6_dhcp_pd_hint_prefix" size="39" maxlength="39" value="<!--# echo ipv6_dhcp_pd_hint_prefix -->">/
                                <input type=text id="ipv6_dhcp_pd_hint_length" name="ipv6_dhcp_pd_hint_length" size="3" maxlength="3" value="<!--# echo ipv6_dhcp_pd_hint_length -->">
                              </b></td>
                            </tr>
			    <tr id="tr_dhcp_pd_hint_pltime" style="display:none ">
                        <td width="187" align=right><b><script>show_words(IPV6_HINT_PLTIME);</script> :</b></td>
                        <td width="331" align=left>&nbsp;<b>
                                <input type=text id="ipv6_dhcp_pd_hint_pltime" name="ipv6_dhcp_pd_hint_pltime" size="10" maxlength="15" value="<!--# echo ipv6_dhcp_pd_hint_pltime -->">
                                <script>show_words(_minutes);</script></td>
                        </b></td>
			    <tr id="tr_dhcp_pd_hint_vltime" style="display:none ">
                        <td width="187" align=right><b><script>show_words(IPV6_HINT_VLTIME);</script> :</b></td>
                        <td width="331" align=left>&nbsp;<b>
                                <input type=text id="ipv6_dhcp_pd_hint_vltime" name="ipv6_dhcp_pd_hint_vltime" size="10" maxlength="15" value="<!--# echo ipv6_dhcp_pd_hint_vltime -->">
                                <script>show_words(_minutes);</script><script>show_words(_optional);</script>
                              </b></td>
                            </tr>

	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT46);</script> :</td>
	                      <td width="331">&nbsp;
	                      	<input type=text id="ipv6_6in4_lan_ip" name="ipv6_6in4_lan_ip" size="30" maxlength="63" value="<!--# echo ipv6_6in4_lan_ip -->" onChange="set_ipv6_autoconf_range()">
	                      	<b>/64</b>
	                      </td>
			    </tr> 
			    <tr> 
			      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT47);</script> :</td>
	                      <td width="331">&nbsp;
	                      	<b><span id="lan_link_local_ip"></span></b>
	                      </td>
                      </tr>
			</table>  
                 </div>
		 <div class="box" id=ipv6_autoconfiguration_settings> 
			 <h2><script>show_words(IPV6_TEXT48);</script></h2>
 <p align="justify" class="box_msg"><script>show_words(IPV6_TEXT49);show_words(IPV6_TEXT49a);</script></p>
                         <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td width="187" class="duple"><script>show_words(IPV6_TEXT50);</script> :</td>
                                  <td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1" onClick="disable_autoconfig()"></td>
                                </tr>
				<tr>
                                  <td width="187" class="duple"><script>show_words(IPV6_TEXT50a);</script> :</td>
                                  <td width="331">&nbsp;<input name="ipv6_dhcp_pd_lan" type=checkbox id="ipv6_dhcp_pd_lan" value="1"></td>
                                </tr>
                                <tr>
                                <td class="duple"><script>show_words(IPV6_TEXT51);</script> :</td>
                                  <td width="331">&nbsp;
				   <select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
				      <option value="stateless"><script>show_words(IPV6_TEXT52);</script></option>
				      <option value="stateful"><script>show_words(IPV6_TEXT53);</script></option>
				      <option value="stateless_dhcp"><script>show_words(IPV6_TEXT53a);</script></option>
				   </select>
				  </td>
                                </tr>
                                <tr id="show_ipv6_addr_range_start" style="display:none">
				     <td class="duple"><script>show_words(IPV6_TEXT54);</script>:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="20" maxlength="19">
				     ::<input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
				     </td>
				</tr>
				<tr id="show_ipv6_addr_range_end" style="display:none">
				     <td class="duple"><script>show_words(IPV6_TEXT55);</script>:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
				     ::<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
				     </td>
				</tr> 
				<tr id="show_ipv6_addr_lifetime" style="display:none">
				     <td class="duple"><script>show_words(IPV6_TEXT56);</script>:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="15" value="<!--# echo ipv6_dhcpd_lifetime -->">
				     <script>show_words(_minutes);</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
				     <td class="duple"><script>show_words(IPV6_TEXT57);</script>:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_6in4_adver_lifetime" name="ipv6_6in4_adver_lifetime" size="20" maxlength="15" value="">
				     <script>show_words(_minutes);</script></td>
				</tr>
           </table>
		 </div>
               </td>
               </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                      	<p><script>show_words(IPV6_TEXT58);</script></p>
              <p><script>show_words(IPV6_TEXT59);</script></p>
				<p><a href="support_internet.asp#IPV6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
			  </table></td>
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
	reboot_needed(left["Setup"].link[9]);
	onPageLoad();
</script>
</html>
