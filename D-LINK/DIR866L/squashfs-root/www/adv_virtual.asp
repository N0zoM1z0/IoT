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
	var rule_max_num = 24;
	var inbound_used = 0;

	function onPageLoad(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_vs;
			if (i > 9){
				temp_vs = get_by_id("vs_rule_" + i).value;
			}else{
				temp_vs = get_by_id("vs_rule_0" + i).value;				
			}
			
			if(temp_vs ==""){
				if (i > 9){
					 get_by_id("vs_rule_" + i).value = "0//6/0/0/0.0.0.0/Always/Allow_All";
				}else{
					get_by_id("vs_rule_0" + i).value = "0//6/0/0/0.0.0.0/Always/Allow_All";				
				}
			}
			protocol_change(i);
		}
	
		set_port_forwarding();
		set_form_default_values("form1");
		var login_who= checksessionStorage();
                if(login_who== "user" || "<!--# echo wan_proto -->" == "dslite"){
                        DisableEnableForm(document.form1,true); 
                } 

	}

	function set_port_forwarding(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_vs;
			
			if (i > 9){
				temp_vs = (get_by_id("vs_rule_" + i).value).split("/");
			}else{
				temp_vs = (get_by_id("vs_rule_0" + i).value).split("/");				
			}
			
			if (temp_vs.length > 1){
				set_checked(temp_vs[0], get_by_id("enable" + i));
				get_by_id("name" + i).value = temp_vs[1];
				set_vs_protocol(i, temp_vs[2], get_by_id("protocol_select"+i));
				get_by_id("public_portS" + i).value = temp_vs[3];
				get_by_id("private_portS" + i).value = temp_vs[4];
				get_by_id("ip" + i).value = temp_vs[5];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
				if((temp_vs[6] == "Always") || (temp_vs[6] == "Never") || (temp_vs[6] == "")){
					set_selectIndex(temp_vs[6], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_vs[6]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}
				set_selectIndex(temp_vs[7], get_by_id("inbound_filter" + i));
				
				if(get_by_id("enable"+ i).checked){
					 detect_protocol_change_port(get_by_id("protocol_select"+i).selectedIndex,i);
				}
			}
			}
		}
	
	function set_vs_protocol(i, which_value, obj){
		set_selectIndex(which_value,obj);
		get_by_id("protocol"+i).disabled=true;
		if(which_value != obj.options[obj.selectedIndex].value){
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol_select"+i).selectedIndex = 3;
			
		}
		
			get_by_id("protocol"+i).value=which_value;
	}
	
    function protocol_change(i){
		var obj_name = get_by_id("protocol_select"+i);
		if(obj_name.selectedIndex < 3){ //TCP, UDP, Both, Other
			get_by_id("protocol"+i).disabled =true;
			get_by_id("public_portS"+i).disabled =false;
			get_by_id("private_portS"+i).disabled =false;
			get_by_id("protocol"+i).value=obj_name.options[obj_name.selectedIndex].value;
		}else if(get_by_id("protocol_select"+i).selectedIndex == 3){ // Other
			get_by_id("public_portS"+i).value = 0;
			get_by_id("private_portS"+i).value = 0;
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol"+i).value="";
		}
	}

	function detect_protocol_change_port(proto,i){
		if((proto == 0)||(proto == 1)||(proto == 2)){
			get_by_id("protocol"+i).disabled=true;
			get_by_id("public_portS"+i).disabled =false;
			get_by_id("private_portS"+i).disabled =false;					
		}else{
			get_by_id("public_portS"+i).disabled=true;
			get_by_id("private_portS"+i).disabled=true;
			
		}
	}
		
	function check_forward_port(potocol,chk_port, obj_word){
			var chk_port_array = chk_port.split(",");				 
			var checkTimes = chk_port_array.length;	
			if(potocol == 0){
					 proto_type = "6";
				}else if(potocol == 1){
					 proto_type = "17";
				}else if(potocol == 2){
					 proto_type = "256";
				}
			  			  
		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_array[i].split("-");
				var port1 = "";
				var port2 = "";	
				port1 = port[0];
												
				if (port.length > 1){
					port2 = port[1];
				}
				
				for(j=0;j<rule_max_num;j++){  // get application rule value
					  var rule_value;
						if (j > 9){
								rule_value = (get_by_id("port_forward_both_" + j).value);
						}else{
								rule_value = (get_by_id("port_forward_both_0" + j).value);				
						}					  
						
						if (rule_value == ""){
							continue;
						}
						
						temp_pf = rule_value.split("/");
						var chk_tcpport_array = temp_pf[3].split(","); //pf tcp port
						var chk_udpport_array = temp_pf[4].split(","); //pf udp port
						var check_tTimes = chk_tcpport_array.length;
						var check_uTimes = chk_udpport_array.length;	
						for (var m = 0; m < check_tTimes; m++){ // split the port forward TCP port range
							var Aport = chk_tcpport_array[m].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}
						if(temp_pf[0]== "1"){	
					  	if(proto_type == "6" || proto_type == "256"){
					  			if (port2 == "" || Aport2 == ""){	//when PF is sigle port or vs is sigle port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + " " + TEXT054);
												return false;	
										}else if (port2 == ""){ //when PF is sogle port, vs is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
							  				alert(obj_word + " " + TEXT054);
												return false;							
												}											
										}else if (Aport2 == ""){ //when vs is sigle port, PF is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
							  				alert(obj_word + " " + TEXT054);
												return false;							
												}											
										}
										
									}else{//PF is range port, vs is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
										alert(obj_word + " " + TEXT055);
									 	    return false;							
										}									
								  }
							}	
						}
					  }
					  
					  for (var n = 0; n < check_uTimes; n++){ // split the port forward UDP port range
							var Aport = chk_udpport_array[n].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}
						if(temp_pf[0]== "1"){	
					  	if(proto_type == "17" || proto_type == "256"){
					  			if (port2 == "" || Aport2 == ""){	//when PF is single port or vs is sigle port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + " " + TEXT054);
												return false;	
										}else if (port2 == ""){ //when PF is sigle port,  vs is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
							  				alert(obj_word + " " + TEXT054);
												return false;							
												}											
										}else if (Aport2 == ""){ //when vs is sigle port, PF is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
							  				alert(obj_word + " " + TEXT054);
												return false;							
												}											
										}
										
									}else{//PF is range port, vs is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
										alert(obj_word + " " + TEXT055);
									 	    return false;							
										}									
								  }
							}	
						}
					  }
				}
				
				
				/*if(parseInt(temp_pf[0],10) > 0){
					if(!check_multi_port(chk_port, temp_pf[3])){
						alert(obj_word + " conflict with Port Forward port.");
						return false;
					}
					if(!check_multi_port(chk_port, temp_pf[4])){
						alert(obj_word + " conflict with Port Forward port.");
						return false;
					}
				}*/
		}	
		return true;
		}
	
	function check_app_port(potocol,chk_port, obj_word){
			var chk_port_array = chk_port.split(",");				 
			var checkTimes = chk_port_array.length;	

		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_array[i].split("-");
				var port1 = "";
				var port2 = "";	
				port1 = port[0];
												
				if (port.length > 1){
					port2 = port[1];
				}
				for(j=0;j<rule_max_num;j++){  // get application rule value
					  var rule_value;
						if (j > 9){
								rule_value = (get_by_id("application_" + j).value);
						}else{
								rule_value = (get_by_id("application_0" + j).value);				
						}					  
						
						if (rule_value == ""){
							continue;
						}
						
						temp_app = rule_value.split("/");
						var chk_appport_array = temp_app[5].split(",");
						var checkAppTimes = chk_appport_array.length;	
						for (var m = 0; m < checkAppTimes; m++){ // split the application port range
							var Aport = chk_appport_array[m].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}

						if(temp_app[0]== "1"){
					  	if(potocol == 0 && temp_app[4]== "TCP" || potocol == 1 && temp_app[4]== "UDP" ||temp_app[4]== "Any"){
					  			if (port2 == "" || Aport2 == ""){	//when vs is sigle port or APP is sigle port		  	
							  		if(port1 == Aport1){
											alert(obj_word + " " + TEXT055);
												return false;	
										}else if (port2 == ""){ //when vs sigle port, APP is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + " " + TEXT055);
												return false;							
												}											
										}else if (Aport2 == ""){ //when APPis sigle port, vs is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + " " + TEXT055);
												return false;							
												}											
										}
										
									}else{//vs is range port, APP is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
										alert(obj_word + " " + TEXT055);
									 	    return false;							
										}									
								  }
							}	
						}
					}
				}
		}	
		return true;
	}
	
	
	
	function check_public_virtual_port(index, chk_port, obj_word)
	{
		var protocol = get_by_id("protocol_select" +i).selectedIndex;
		for(ii=(index+1); ii<rule_max_num; ii++){
			if(get_by_id("enable" + ii).checked == true){
				if(get_by_id("public_portS" + ii).value == chk_port){
					alert(obj_word + " " + TEXT056b);
					return false;
				}
			}
		}
		return true;
	}

	function check_private_virtual_port(index, chk_port, chk_ip, obj_word)
	{
		var protocol = get_by_id("protocol_select" +i).selectedIndex;
		for(ii=(index+1); ii<rule_max_num; ii++){
			if(get_by_id("enable" + ii).checked == true){
				if(get_by_id("ip" + ii).value == chk_ip){	//check IP Address is different or not?
					if(get_by_id("private_portS" + ii).value == chk_port){
						alert(obj_word + " " + TEXT056c);
						return false;
					}
				}
			}
		}
		return true;
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(LS3)) {
			return false;
		}
		
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = get_by_id("name" + i).value;			
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == get_by_id("name" + j).value){
						alert(TEXT077);
						return false;
					}
				}
			}
		}
		
		var lan_ip = "<!--# echo lan_ipaddr -->";
		var mask ="<!--# echo lan_netmask -->";
		
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		
		for (var i = 0; i < rule_max_num; i++){		
			var ip = get_by_id("ip" + i).value;
			var protocol = get_by_id("protocol_select" +i).selectedIndex;
			var other = get_by_id("protocol"+i).value;
			var check_name = get_by_id("name" + i).value;
			
			var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);			
			var temp_vs;
			
			if (parseInt(i,10) >= 10){
				get_by_id("vs_rule_" + i).value = "";
			}else{
				get_by_id("vs_rule_0" + i).value = "";
			}
			
			if(get_by_id("enable" + i).checked == true && get_by_id("name" + i).value == ""){
				alert(GW_INET_ACL_NAME_INVALID);	
				return false;	
			}
			
			if (get_by_id("name" + i).value != ""){
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert(TEXT002.replace("'+ i +'", get_by_id("name" + i).value));
					return false;
				}
								
				//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, _ipaddr)){
					return false;
				}
	
				if(!check_domain(temp_ip_obj, temp_mask_obj, temp_lan_ip_obj)) {
					var temp_msg = av_alert_1;
					temp_msg = temp_msg.replace("' + data.virtual_servers[i].entry_name + '", "\"" + check_name + "\"");
					temp_msg = temp_msg.replace("('+lan_subnet+')", ".");
					alert(temp_msg);
					return false;
				}
				
				var name_string = get_by_id("name" + i).value.toUpperCase();
				//if (get_by_id("name" + i).value != "Wake-On-LAN"){
				if (name_string != "WAKE-ON-LAN"){
					if (!check_address(temp_ip_obj)){
			            return false;
					}
		    }
       
				//check virtual server public port and remote management port conflict problem
				var remote_port = "<!--# echo remote_http_management_port -->";
				var remote_port_enable = "<!--# echo remote_http_management_enable -->";
				if(get_by_id("enable" + i).checked == true){
					if(remote_port_enable == "1"){
						if (get_by_id("public_portS" + i).value == remote_port && protocol != 1){
							alert(TEXT078);
							return false;
						}
					}
				}

                //check virtual server public port and storage port conflict problem
                var file_access_remote_port = "<!--# echo file_access_remote_port -->";
                var file_access_ssl_port = "<!--# echo file_access_ssl_port -->";
                var file_access_enable = "<!--# echo file_access_enable -->";
				if(get_by_id("enable" + i).checked == true){
                    if(file_access_enable  == "1"){
                        if (get_by_id("public_portS" + i).value == file_access_remote_port || get_by_id("public_portS" + i).value == file_access_ssl_port ){
                            alert(TEXT056b);
                            return false;
                        }    
                    }
                }

				if(protocol != 3){
					if(get_by_id("enable" + i).checked == true){
						if(!check_forward_port(protocol, get_by_id("public_portS" + i).value, "Port")){
							return false;
						}
					
						if(!check_app_port(protocol,get_by_id("public_portS" + i).value, "Port")){
							return false;
						}
						
						if(!check_public_virtual_port(i, get_by_id("public_portS" + i).value, "Port")){
							return false;
						}
						/*if(!check_private_virtual_port(i, get_by_id("private_portS" + i).value, get_by_id("ip" + i).value,"Port")){
							return false;
						}*/
					}
						
						if (!check_pf_port(get_by_id("private_portS" + i).value)){
		            alert(TEXT079);
		            return false;
				    }
				    
				    if (!check_pf_port(get_by_id("public_portS" + i).value)){
		            alert(MSG001);
		            return false;
			      }
				       
				}else if(protocol == 3){
					if (isNaN(other) || other == "" || (parseInt(other) < 0 || parseInt(other) > 255)){
						alert(TEXT011);
				 		return false;
					}
				}
		        
        var is_enable = get_checked_value(get_by_id("enable" + i));
        if (count > 9){
					temp_vs = get_by_id("vs_rule_" + count);
				}else{
					temp_vs = get_by_id("vs_rule_0" + count);
				}
				
	  			//2009/4/10 Tina modify:Fixed can't save space char.
				var tmp_schedule = get_schedule_value(i);
				temp_vs.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("protocol" + i).value 
					+ "/" + get_by_id("public_portS" + i).value +"/"+ get_by_id("private_portS" + i).value 
					+ "/" + get_by_id("ip" + i).value + "/" + tmp_schedule + "/" + get_by_id("inbound_filter" + i).value;
				
				save_inbound_used(get_by_id("inbound_filter" + i).value, inbound_used);
				
        count++;
			}
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
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
                            <script>show_left("Advance", 0);</script>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
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
					<input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<!--# echo inbound_filter_name_00 -->">
					<input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<!--# echo inbound_filter_name_01 -->">
					<input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<!--# echo inbound_filter_name_02 -->">
					<input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<!--# echo inbound_filter_name_03 -->">
					<input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<!--# echo inbound_filter_name_04 -->">
					<input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<!--# echo inbound_filter_name_05 -->">
					<input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<!--# echo inbound_filter_name_06 -->">
					<input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<!--# echo inbound_filter_name_07 -->">
					<input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<!--# echo inbound_filter_name_08 -->">
					<input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<!--# echo inbound_filter_name_09 -->">
					<input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<!--# echo inbound_filter_name_10 -->">
					<input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<!--# echo inbound_filter_name_11 -->">
					<input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<!--# echo inbound_filter_name_12 -->">
					<input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<!--# echo inbound_filter_name_13 -->">
					<input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<!--# echo inbound_filter_name_14 -->">
					<input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<!--# echo inbound_filter_name_15 -->">
					<input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<!--# echo inbound_filter_name_16 -->">
					<input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<!--# echo inbound_filter_name_17 -->">
					<input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<!--# echo inbound_filter_name_18 -->">
					<input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<!--# echo inbound_filter_name_19 -->">
					<input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<!--# echo inbound_filter_name_20 -->">
					<input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<!--# echo inbound_filter_name_21 -->">
					<input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<!--# echo inbound_filter_name_22 -->">
					<input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<!--# echo inbound_filter_name_23 -->">
					<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
                <form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_virtual.asp">
					<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
					<input type="hidden" id="result_timer" name="result_timer" value="20">
					<input type="hidden" id="action" name="action" value="adv_virtual">
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
					
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
				  
                  <div id=box_header>
                    <h1><script>show_words(_virtserv);</script></h1>
					<script>show_words(av_intro_vs);</script>
                    <br><br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_virtual.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>document.write(rule_max_num)</script> &ndash;&ndash; <script>show_words(vs_vslist)</script></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="31">&nbsp;</td>
                          <td width="195">&nbsp;</td>
                          <td width="130" align=middle><div align="left"><strong><script>show_words(_vs_port)</script></strong></div></td>
                          <td width="125" align=middle><div align="left"><strong><script>show_words(_vs_traffictype)</script></strong></div></td>
                          <td width="100" align=middle><div align="center">&nbsp;</td>
                        </tr>
                        <script>
							var Application_list = set_application_option(Application_list, default_virtual);
							var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>");
								document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" value=\"1\"></td>");
								document.write("<td valign=bottom>"+_name+"<br><input type=text class=flatL id=\"name" + i +"\" size=16 maxlength=31></td>");
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_app" + i + " type=button value=<< onClick='copy_virtual(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=application" + i +" modified=\"ignore\">");
								document.write("<option>"+gw_SelVS+"</option>");
								document.write(Application_list);
								document.write("</select></td>");
								document.write("<td align=center valign=bottom>"+av_PubP+"<br><input type=text class=flatL id=public_portS" + i + " size=5 maxlength=5></td>");
								document.write("<td align=center>"+_protocol+"<br>");
								document.write("<select width=80 id=protocol_select" + i + " onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex,'" + i + "');\">");
								document.write("<option value=6 selected>TCP</option>");
								document.write("<option value=17>UDP</option>");
								document.write('<option value=256>'+_both+'</option>');
								document.write('<option value=-1> '+_other+'</option>');
								document.write("</select></td>");			
								document.write("<td align=center>"+GW_NAT_SCHEDULE+"<br>");
								document.write("<select width=30 id=schedule" + i + " style='width:70'>");
								document.write("<option value=\"Always\" selected>"+_always+"</option>");
								document.write("<option value=\"Never\">"+_never+"</option>");
								document.write(set_schedule_option());
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								document.write("<tr>");
								document.write("<td valign=bottom>"+_ipaddr+"<br><input type=text class=flatL  id=ip" + i +" size=16 maxlength=15></td>");
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=ip_list" + i +" modified=\"ignore\">");
								document.write("<option value=-1>"+bd_CName+"</option>");
								document.write(set_mac_list("ip"));			
								document.write("</select></td>");
								document.write("<td align=center valign=bottom>"+av_PriP+"<br><input type=text class=flatL id=private_portS" + i +" size=5 maxlength=5></td>");
								document.write("<td align=center><br>");
								document.write("<input type=text id=protocol" + i + " size=5 maxlength=3>");
								document.write("</td>");
								document.write("<td align=center>"+GW_NAT_INBOUND_FILTER+"<br>");
								document.write("<select width=30 id=inbound_filter" + i + " style='width:70'>");
								document.write("<option value=\"Allow_All\" selected>"+_allowall+"</option>");
								document.write("<option value=\"Deny_All\">"+_denyall+"</option>");
								document.write(Inbound_list);
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
							}
						</script>
                      </tbody>
                    </table>
                  </div>
                </div>
             </td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                      	<p><script>show_words(hhav_name)</script></p>
                        <p><script>show_words(hhav_ip)</script></p>
                        <p><script>show_words(hhav_sch)</script></p>
                        <p><script>show_words(hhav_filt)</script></p>
						<p><a href="support_adv.asp#Virtual_Server" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	reboot_needed(left["Advance"].link[0]);
	onPageLoad();
</script>
</html>
