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
	function onPageLoad(){
		set_checked(get_by_id("wish_engine_enabled").value, get_by_id("wish_engine"));
		set_checked(get_by_id("wish_http_enabled").value, get_by_id("wish_http"));
		set_checked(get_by_id("wish_media_enabled").value, get_by_id("wish_media"));
		set_checked(get_by_id("wish_auto_enabled").value, get_by_id("wish_auto"));
		
		for (var i = 0; i < rule_max_num; i++){
			var temp_qos;
			if (i > 9){
				temp_qos = get_by_id("wish_rule_" + i).value;
			}else{
				temp_qos = get_by_id("wish_rule_0" + i).value;				
			}

			if(temp_qos ==""){
				if (i > 9){
					 get_by_id("wish_rule_" + i).value = "0//1/0/0/6/0.0.0.0/255.255.255.255/0/65535/0.0.0.0/255.255.255.255/0/65535";
				}else{
					 get_by_id("wish_rule_0" + i).value = "0//1/0/0/6/0.0.0.0/255.255.255.255/0/65535/0.0.0.0/255.255.255.255/0/65535";
				}
			}
			//protocol_change(i);
		}
		wish_enable_click(get_by_id("wish_engine").checked);
		set_qos_rule();
		var login_who= checksessionStorage();
                if(login_who== "user"){
                        DisableEnableForm(document.form1,true); 
                } 
	}
	
	function wish_enable_click(obj_chk){
		var is_disabled = !obj_chk;
		get_by_id("wish_http").disabled = is_disabled;
		get_by_id("wish_media").disabled = is_disabled;
		get_by_id("wish_auto").disabled = is_disabled;
				
		for(var i=0;i<rule_max_num;i++){
			get_by_id("wish_rule_enabled"+i).disabled = is_disabled;
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
		
	function set_qos_rule(){

		for (var i = 0; i < rule_max_num; i++){
			var temp_qos;
			
			if (i > 9){
				temp_qos = (get_by_id("wish_rule_" + i).value).split("/");
			}else{
				temp_qos = (get_by_id("wish_rule_0" + i).value).split("/");				
			}
			
			if (temp_qos.length > 1){
				
				if (temp_qos[0] == "1"){
					get_by_id("wish_rule_enabled" + i).checked = true;
				}
				
				get_by_id("name" + i).value = temp_qos[1];
				set_selectIndex(temp_qos[2], get_by_id("priority" + i));
				set_protocol(i, temp_qos[5], get_by_id("protocol_select" + i));
				get_by_id("local_start_ip" + i).value = temp_qos[6];
				get_by_id("local_end_ip" + i).value = temp_qos[7];
				get_by_id("local_start_port" + i).value = temp_qos[8];
				get_by_id("local_end_port" + i).value = temp_qos[9];
				get_by_id("remote_start_ip" + i).value = temp_qos[10];
				get_by_id("remote_end_ip" + i).value = temp_qos[11];
				get_by_id("remote_start_port" + i).value = temp_qos[12];
				get_by_id("remote_end_port" + i).value = temp_qos[13];
				
				if(get_by_id("wish_engine").checked){
					 detect_protocol_change_port(get_by_id("protocol_select"+i).selectedIndex, i);
				}
			}
		}
	}
	
	function set_protocol(i, which_value, obj){
		set_selectIndex(which_value,obj);
		get_by_id("protocol"+i).disabled=true;
		if(which_value != obj.options[obj.selectedIndex].value){
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol_select"+i).selectedIndex = 5;
		}
		get_by_id("protocol"+i).value=which_value;
	}	
	
	function protocol_change(i){
		var obj_name = get_by_id("protocol_select"+i);
		if(obj_name.selectedIndex < 5){ //Any, TCP, UDP, Both, ICMP, Other
			get_by_id("protocol"+i).disabled=true;
			get_by_id("protocol"+i).value=obj_name.options[obj_name.selectedIndex].value;
		}else if(get_by_id("protocol_select"+i).selectedIndex == 5){ // Other
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol"+i).value="";
		}
	}

	function detect_protocol_change_port(proto,i){
		//var proto = get_by_id("protocol_select"+i).selectedIndex;
		if((proto == 0)||(proto == 4)||(proto == 5)){
			get_by_id("local_start_port"+i).disabled=true;
			get_by_id("local_end_port"+i).disabled=true;
			get_by_id("remote_start_port"+i).disabled=true;
			get_by_id("remote_end_port"+i).disabled=true;
		}else{
			get_by_id("local_start_port"+i).disabled=false;
			get_by_id("local_end_port"+i).disabled=false;
			get_by_id("remote_start_port"+i).disabled=false;
			get_by_id("remote_end_port"+i).disabled=false;
		}
	}

	function send_request(){
		
		get_by_id("wish_engine_enabled").value = get_checked_value(get_by_id("wish_engine"));
		get_by_id("wish_http_enabled").value = get_checked_value(get_by_id("wish_http"));
		get_by_id("wish_media_enabled").value = get_checked_value(get_by_id("wish_media"));
		get_by_id("wish_auto_enabled").value = get_checked_value(get_by_id("wish_auto"));
				
		//check rule				
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){		
			var local_start_ip = get_by_id("local_start_ip" + i).value;
			var local_end_ip = get_by_id("local_end_ip" + i).value;
			var remote_start_ip = get_by_id("remote_start_ip" + i).value;
			var remote_end_ip = get_by_id("remote_end_ip" + i).value;
			var local_start_port = parseInt(get_by_id("local_start_port" + i).value);
			var local_end_port = parseInt(get_by_id("local_end_port" + i).value);
			var remote_start_port = parseInt(get_by_id("remote_start_port" + i).value);
			var remote_end_port = parseInt(get_by_id("remote_end_port" + i).value);			
			var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP Address");
			var remote_ip_addr_msg = replace_msg(all_ip_addr_msg,"IP Address");
			var temp_local_start_ip_obj = new addr_obj(local_start_ip.split("."), ip_addr_msg, false, false);
			var temp_local_end_ip_obj = new addr_obj(local_end_ip.split("."), ip_addr_msg, false, false);
			var temp_remote_start_ip_obj = new addr_obj(remote_start_ip.split("."), remote_ip_addr_msg, false, false);
			var temp_remote_end_ip_obj = new addr_obj(remote_end_ip.split("."), remote_ip_addr_msg, false, false);
			var temp_qos;
			var check_name = "";
			
			if (i > 9){
				get_by_id("wish_rule_" + i).value = "";
			}else{
				get_by_id("wish_rule_0" + i).value = "";
			}
			
			//check protocol
				if(get_by_id("protocol_select" + i).selectedIndex == 5){
				
					temp_obj = 	get_by_id("protocol" + i);
	   				var protocol_msg = replace_msg(check_num_msg, _protocol, 0, 255);
	   				obj = new varible_obj(temp_obj.value, protocol_msg, 0, 255, false);
	   				if(!check_varible(obj)){
	    				return false;
	    			}	
    			}
			
			if(get_by_id("name" + i).value != ""){
				// check name				
				check_name = get_by_id("name" + i).value;
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert(TEXT003a + " " + i + " " + illegal_characters + " " + check_name);
					get_by_id("name"+i).focus();
					get_by_id("name"+i).select();
					return false;
				}	
				
				
				//check Priority
				temp_obj = 	get_by_id("priority" + i);
   				var priority_msg = replace_msg(check_num_msg, _priority, 1, 4);
   				obj = new varible_obj(temp_obj.value, priority_msg, 1, 4, false);
   				if(!check_varible(obj)){
    				return false;
    			}
				
				//check ip 
				if(local_start_ip != "0.0.0.0" && !check_address(temp_local_start_ip_obj)){
					return false;
				}
				if(local_end_ip != "255.255.255.255" && !check_address(temp_local_end_ip_obj)){
					return false;
				}
				if(remote_start_ip != "0.0.0.0" && !check_address(temp_remote_start_ip_obj)){
					return false;
				}
				if(remote_end_ip != "255.255.255.255" && !check_address(temp_remote_end_ip_obj)){
					return false;
				}

				//check port
				if((get_by_id("protocol_select"+i).selectedIndex ==1) || (get_by_id("protocol_select"+i).selectedIndex ==2) || (get_by_id("protocol_select"+i).selectedIndex ==3)){
					if(local_start_port < 0 || local_start_port > 65535){
							alert(YM59);
						get_by_id("local_start_port"+i).focus();
						get_by_id("local_start_port"+i).select();
							return false;
					}else if(local_end_port < 0 || local_end_port > 65535){
							alert(YM60);
						get_by_id("local_end_port"+i).focus();
						get_by_id("local_end_port"+i).select();
							return false;
					}else if(local_start_port > local_end_port){							
							alert(YM60_1);
						get_by_id("local_start_port"+i).focus();
						get_by_id("local_start_port"+i).select();
							return false;
					}			
						
					if(remote_start_port < 0 || remote_start_port > 65535){
							alert(YM61);
						get_by_id("remote_start_port"+i).focus();
						get_by_id("remote_start_port"+i).select();
							return false;
					}else if(remote_end_port < 0 || remote_end_port > 65535){
							alert(YM62);
						get_by_id("remote_end_port"+i).focus();
						get_by_id("remote_end_port"+i).select();
							return false;
					}else if(remote_start_port > remote_end_port){
							alert(YM62_1);
						get_by_id("remote_start_port"+i).focus();
						get_by_id("remote_start_port"+i).select();
							return false;
					}
				}
			}
			else{
				if(get_by_id("wish_rule_enabled" + i).checked == true){
					alert(TEXT008a + " "+ i +" " + _name_emipt);
					return false;
				}	
			}			

			if (count > 9){
				temp_qos = get_by_id("wish_rule_" + count);
			}else{
				temp_qos = get_by_id("wish_rule_0" + count);
			}

			//enable/name/priority/uplink/downlink/protocol/local_start_ip/local_end_ip/local_start_port/local_end_port/remote_start_ip/remote_end_ip/remote_start_port/remote_end_port
			temp_qos.value = get_checked_value(get_by_id("wish_rule_enabled" + i)) + "/" + get_by_id("name" + i).value + "/" + get_by_id("priority" + i).value	+ "/" 
							+ "0/0/" 
							+ get_by_id("protocol" + i).value + "/" 
							+ get_by_id("local_start_ip" + i).value + "/" + get_by_id("local_end_ip" + i).value + "/" + get_by_id("local_start_port" + i).value + "/" 
							+ get_by_id("local_end_port" + i).value+ "/" + get_by_id("remote_start_ip" + i).value + "/" 
							+ get_by_id("remote_end_ip" + i).value + "/" + get_by_id("remote_start_port" + i).value + "/" + get_by_id("remote_end_port" + i).value;

			count++;
		}
		
		//check same as rule
		for (var i = 0; i < rule_max_num; i++){		
			var local_start_ip = get_by_id("local_start_ip" + i).value;
			var local_end_ip = get_by_id("local_end_ip" + i).value;
			var remote_start_ip = get_by_id("remote_start_ip" + i).value;
			var remote_end_ip = get_by_id("remote_end_ip" + i).value;
			var local_start_port = parseInt(get_by_id("local_start_port" + i).value);
			var local_end_port = parseInt(get_by_id("local_end_port" + i).value);
			var remote_start_port = parseInt(get_by_id("remote_start_port" + i).value);
			var remote_end_port = parseInt(get_by_id("remote_end_port" + i).value);			
			var rule_protocol = get_by_id("protocol_select"+i).selectedIndex;
			//alert("i"+i);
			//alert(rule_protocol);					
			for (var j = 0; j < rule_max_num; j++){
				//alert("j"+j);	
				if(j!=i){
					var local_start_ip_chk = get_by_id("local_start_ip" + j).value;
					var local_end_ip_chk = get_by_id("local_end_ip" + j).value;
					var remote_start_ip_chk = get_by_id("remote_start_ip" + j).value;
					var remote_end_ip_chk = get_by_id("remote_end_ip" + j).value;
					var local_start_port_chk = parseInt(get_by_id("local_start_port" + j).value);
					var local_end_port_chk = parseInt(get_by_id("local_end_port" + j).value);
					var remote_start_port_chk = parseInt(get_by_id("remote_start_port" + j).value);
					var remote_end_port_chk = parseInt(get_by_id("remote_end_port" + j).value);											
					var rule_protocol_chk = get_by_id("protocol_select"+j).selectedIndex;
					//alert(rule_protocol_chk);
					
					//check enable
					if(get_by_id("wish_rule_enabled" + i).checked != true){
						//alert("continei"+i);
						continue;						
					}
					
					//check enable
					if(get_by_id("wish_rule_enabled" + j).checked != true){
						//alert("continej"+j);
						continue;						
					}
						
					//check protocol
					if(rule_protocol_chk != rule_protocol){
						//alert(rule_protocol);
						//alert(rule_protocol_chk);
						continue;	
					}
						
					//check ip 
					if(local_start_ip_chk != local_start_ip){
						//alert(local_start_ip_chk);
						//alert(local_start_ip);
						continue;	
					}
					if(local_end_ip_chk != local_end_ip){
						//alert(local_end_ip_chk);
						//alert(local_end_ip);
						continue;	
					}
					if(remote_start_ip_chk != remote_start_ip){
						//alert(remote_start_ip_chk);
						//alert(remote_start_ip);
						continue;
					}
					if(remote_end_ip_chk != remote_end_ip){
						//alert(remote_end_ip_chk);
						//alert(remote_end_ip);
						continue;
					}
					            		
					//check port
					if( (rule_protocol ==1) || (rule_protocol ==2) || (rule_protocol ==3)){
						if(local_start_port_chk != local_start_port){
							//alert(local_start_port_chk);
							//alert(local_start_port);
							continue;
						}else if(local_end_port_chk != local_end_port){
							//alert(local_end_port_chk);
							//alert(local_end_port);
							continue;
						}
						
						if(remote_start_port_chk != remote_start_port){
							//alert(remote_start_port_chk);
							//alert(remote_start_port);
							continue;
						}else if(remote_end_port_chk != remote_end_port){
							//alert(remote_end_port_chk);
							//alert(remote_end_port);
							continue;							
						}
						// same as rule				
						alert(TEXT008);
						return false;													
					}						
				}		
			}					
		}
				
		if(submit_button_flag == 0){
			submit_button_flag = 1;
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
		<tr><td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td></tr>
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
            <tr>
              <td id=sidenav_container>
                <div id=sidenav>                          
                  <UL>
                    <script>show_left("Advance", 13);</script>
                  </UL>
              	</div>
              </td>
            </tr>
        </table></td>
				
                <form id="form1" name="form1" method="post" action="apply.cgi">
                	<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wish.asp">
					<input type="hidden" id="action" name="action" value="adv_wish">
					<input type="hidden" id="reboot_type" name="reboot_type" value="wireless">
					<input type="hidden" id="wish_rule_00" name="wish_rule_00" value="<!--# echo wish_rule_00 -->">
					<input type="hidden" id="wish_rule_01" name="wish_rule_01" value="<!--# echo wish_rule_01 -->">
					<input type="hidden" id="wish_rule_02" name="wish_rule_02" value="<!--# echo wish_rule_02 -->">
					<input type="hidden" id="wish_rule_03" name="wish_rule_03" value="<!--# echo wish_rule_03 -->">
					<input type="hidden" id="wish_rule_04" name="wish_rule_04" value="<!--# echo wish_rule_04 -->">
					<input type="hidden" id="wish_rule_05" name="wish_rule_05" value="<!--# echo wish_rule_05 -->">
					<input type="hidden" id="wish_rule_06" name="wish_rule_06" value="<!--# echo wish_rule_06 -->">
					<input type="hidden" id="wish_rule_07" name="wish_rule_07" value="<!--# echo wish_rule_07 -->">
					<input type="hidden" id="wish_rule_08" name="wish_rule_08" value="<!--# echo wish_rule_08 -->">
					<input type="hidden" id="wish_rule_09" name="wish_rule_09" value="<!--# echo wish_rule_09 -->">
					<input type="hidden" id="wish_rule_10" name="wish_rule_10" value="<!--# echo wish_rule_10 -->">
					<input type="hidden" id="wish_rule_11" name="wish_rule_11" value="<!--# echo wish_rule_11 -->">
					<input type="hidden" id="wish_rule_12" name="wish_rule_12" value="<!--# echo wish_rule_12 -->">	
					<input type="hidden" id="wish_rule_13" name="wish_rule_13" value="<!--# echo wish_rule_13 -->">
					<input type="hidden" id="wish_rule_14" name="wish_rule_14" value="<!--# echo wish_rule_14 -->">
					<input type="hidden" id="wish_rule_15" name="wish_rule_15" value="<!--# echo wish_rule_15 -->">
					<input type="hidden" id="wish_rule_16" name="wish_rule_16" value="<!--# echo wish_rule_16 -->">
					<input type="hidden" id="wish_rule_17" name="wish_rule_17" value="<!--# echo wish_rule_17 -->">
					<input type="hidden" id="wish_rule_18" name="wish_rule_18" value="<!--# echo wish_rule_18 -->">
					<input type="hidden" id="wish_rule_19" name="wish_rule_19" value="<!--# echo wish_rule_19 -->">
					<input type="hidden" id="wish_rule_20" name="wish_rule_20" value="<!--# echo wish_rule_20 -->">	
					<input type="hidden" id="wish_rule_21" name="wish_rule_21" value="<!--# echo wish_rule_21 -->">
					<input type="hidden" id="wish_rule_22" name="wish_rule_22" value="<!--# echo wish_rule_22 -->">
					<input type="hidden" id="wish_rule_23" name="wish_rule_23" value="<!--# echo wish_rule_23 -->">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
                    <h1><script>show_words(YM63)</script></h1>
                     <script>show_words(YM72);</script>
                    <br><br>
                    <input name="button" id="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="Don't Save Settings"  onClick="window.location.href='adv_qos.asp'">
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(YM63)</script></h2>
                  	<table width=525>
						<tr>
							<td width="185" align=right class="duple"><script>show_words(YM73);</script> :</td>
                        	<td width="333">&nbsp;
					  			<input type="checkbox" id="wish_engine" name="wish_engine" value="1" onClick="wish_enable_click(this.checked)">
								<input type="hidden" id="wish_engine_enabled" name="wish_engine_enabled" value="<!--# echo wish_engine_enabled -->">
					  		</td>
						</tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(YM74);</script></h2>
                  	<table width=525>
						<tr>
							<td width="185" align=right class="duple"><script>show_words(gw_vs_1);</script> :</td>
							<td width="333">&nbsp;
					  			<input type="checkbox" id="wish_http" name="wish_http" value="1">
								<input type="hidden" id="wish_http_enabled" name="wish_http_enabled" value="<!--# echo wish_http_enabled -->">
					  		</td>
						</tr>
						<tr>
							<td align=right class="duple"><script>show_words(YM75);</script> :</td>
							<td>&nbsp;
					  			<input type="checkbox" id="wish_media" name="wish_media" value="1">
								<input type="hidden" id="wish_media_enabled" name="wish_media_enabled" value="<!--# echo wish_media_enabled -->">
					  		</td>
						</tr>
						<tr>
							<td align=right class="duple"><script>show_words(YM76);</script> : </td>
							<td>&nbsp;
								<input type="checkbox" id="wish_auto" name="wish_auto" value="1">
								<input type="hidden" id="wish_auto_enabled" name="wish_auto_enabled" value="<!--# echo wish_auto_enabled -->">
									<script>show_words(ZM2);</script>
					  		</td>
						</tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2>24 -- <script>show_words(YM77);</script></h2>
                    <table bordercolor=#ffffff cellspacing=1 cellpadding=2 width=525 bgcolor=#dfdfdf border=1>
						<script>
								for(var i=0; i <rule_max_num ; i++){
										document.write("<tr>");
										document.write("<td rowspan=3><input type=checkbox id=wish_rule_enabled"+ i + " name=wish_rule_enabled"+ i + "\" value=\"1\"></td>");
										document.write("<td>Name<br><input id=name" + i + " name=name" + i +" type=text size=16 maxlength=31></td>");
										document.write("<td>"+_priority+"<br>");
										document.write("<select id=priority"+ i + " name=priority"+ i + ">");
										document.write("<option value=2>"+YM78+"</option>");
										document.write("<option value=1>"+YM79+"</option>");
										document.write("<option value=3>"+YM80+"</option>");
										document.write("<option value=4>"+YM81+"</option>");
										document.write("</select>");
										document.write("</td>");
										document.write("<td>"+_protocol+"<br>");
										document.write("<input id=protocol"+ i + " name=protocol"+ i + " maxlength=3 size=2 type=text>");
										document.write("  <<  ");
										document.write("<select id=\"protocol_select"+ i + "\" name=\"protocol_select"+ i + "\" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex,'" + i + "');\">");
										document.write("<option value=256>Any</option>");
										document.write("<option value=6>TCP</option>");
										document.write("<option value=17>UDP</option>");
										document.write("<option value=257>Both</option>");
										document.write("<option value=1>ICMP</option>");
										document.write("<option value=-1>Other</option>");
										document.write("</select></td>");
										document.write("</tr>");
										document.write("<tr>");
										document.write("<td colspan=2 width=60%>"+YM82+"<br>");
										document.write("<input id=local_start_ip"+ i + " name=local_start_ip"+ i + " type=text size=14 maxlength=15>"+_to+"<input id=local_end_ip"+ i + " name=local_end_ip"+ i + " type=text size=14 maxlength=15>");
										document.write("</td>");
										document.write("<td>"+YM83+"<br>");
										document.write("<input id=local_start_port"+ i + " name=local_start_port"+ i + " type=text size=4 maxlength=5>"+_to+"<input id=local_end_port"+ i + " name=local_end_port"+ i + " type=text size=4 maxlength=5>");
										document.write("</td>");
										document.write("</tr>");
										document.write("<tr>");
										document.write("<td colspan=2 width=60%>"+YM84+"<br>");
										document.write("<input id=remote_start_ip"+ i + " name=remote_start_ip"+ i + " type=text size=14 maxlength=15>"+_to+"<input id=remote_end_ip"+ i + " name=remote_end_ip"+ i + " type=text size=14 maxlength=15>");
										document.write("</td>");
										document.write("<td>"+YM85+"<br>");
										document.write("<input id=remote_start_port"+ i + " name=remote_start_port"+ i + " type=text size=4 maxlength=5 >"+_to+"<input id=remote_end_port"+ i + " name=remote_end_port"+ i + " type=text size=4 maxlength=5>");
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
	                   <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
	                   <p><script>show_words(YM86);</script></p>
	                   <p><script>show_words(YM87);</script></p>
	                   <p class="more"><a href="support_adv.asp#WISH" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div align="center"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	onPageLoad();	
</script>
</html>
