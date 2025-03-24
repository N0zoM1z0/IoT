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
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 32;
	var resert_rule = rule_max_num;
	var DataArray = new Array();
	
	function onPageLoad(){
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}	 
        }
	
	//0/name/192.168.31.0/255.255.255.0/192.168.31.1/192.168.31.1/20
	function Data(enable, name, ip_addr, net_mask, gateway, interface, metric, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = interface;
		this.Metric = metric;
		this.OnList = onList ;
	}
	
	function set_routes(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("static_routing_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[1] != "name" && temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3],temp_st[4],temp_st[5],temp_st[6],temp_st[7], index);
					index++;
				}
			}
		}
		
		
	}

	function check_rule_name()
	{
		for (var i = 0; i < rule_max_num -1; i++){
			var c_name = get_by_id("name" + i).value;
			if (c_name === "")
				break;
			for (var j = i + 1; j < rule_max_num; j++) {
				var n_name = get_by_id("name"+j).value;
				if (n_name === "")
					break;

				if (c_name == n_name) {
					GW_FIREWALL_NAME_INVALID = ReplaceAll(GW_FIREWALL_NAME_INVALID, "%s", n_name);
					alert(GW_FIREWALL_NAME_INVALID);
					return false;
				}
			}
		}

		return true;
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
		if (!check_rule_name()) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_mac;
			var check_name = get_by_id("name" + i).value;
		
			if (i > 9){
				get_by_id("static_routing_" + i).value = "";
			}else{
				get_by_id("static_routing_0" + i).value = "";
			}
			
			if (get_by_id("Destination" + i).value == "" ){
				get_by_id("Destination" + i).value="0.0.0.0";
			}
			
			if (get_by_id("Sub_Mask" + i).value == "" ){
				get_by_id("Sub_Mask" + i).value="0.0.0.0";
			}

			if (get_by_id("Sub_gateway" + i).value == ""){
				get_by_id("Sub_gateway" + i).value="0.0.0.0";
			}
			
			if ( check_name == ""  && get_by_id("enable" + i).checked ) {
                                alert(GW_SCHEDULES_NAME_INVALID);
                                return false;
                
                        } else if (Find_word(check_name,'"') || Find_word(check_name,"/")) {
				alert(TEXT007c + " " + i + " " + illegal_characters + " " + check_name);
                                return false;
				
			} else {
			
			if (get_by_id("Destination" + i).value != "" && get_by_id("Sub_Mask" + i).value != "" && get_by_id("Sub_gateway" + i).value != "" && check_name != ""){
				var static_ip = get_by_id("Destination" + i).value;
				var static_mask = get_by_id("Sub_Mask" + i).value;
				var static_gateway = get_by_id("Sub_gateway" + i).value;
				var metric = get_by_id("metric"+ i).value;
    			
				var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
				var gateway_msg = replace_msg(all_ip_addr_msg, wwa_gw);
    			
				var static_ip_obj = new addr_obj(static_ip.split("."), ip_addr_msg, false, true);
				var static_mask_obj = new addr_obj(static_mask.split("."), subnet_mask_msg, false, false);
				var static_gateway_obj = new addr_obj(static_gateway.split("."), gateway_msg, false, true);
				var temp_metric = new varible_obj(metric, metric_msg, 1, 15, false);
				
				// Don't check subnet and ip
				/*
				if(!check_route_mask(static_mask_obj)){
					return false;   // when subnet mask is not in the subnet mask range
				}else if(!check_network_address(static_ip_obj, static_mask_obj)){
					return false;		// when ip is invalid
				}else if(!check_address(static_gateway_obj)){
					return false;	// when gateway is invalid
				}
				*/

				if (!is_ipv4_valid(static_ip)) {
					alert(_destip + " " + MSG037_1);
					return false;
				}

				if (!check_route_mask(static_mask_obj)) {
					return false;
				}

				if(get_by_id("enable" + i).checked){
					if (!check_address(static_gateway_obj)){
						return false;	// when gateway is invalid
					}
				}
					
				if (!check_varible(temp_metric)){
					return false;
				}
    			
				for(jj=i+1;jj<rule_max_num;jj++){
					if((get_by_id("Destination" + jj).value==static_ip) && (get_by_id("interface" + jj).value==static_gateway)){
						alert(TEXT081);;
						return false;
						break;
					}
				}
    			
				if (count > 9){
					temp_mac = get_by_id("static_routing_" + count);
				}else{
					temp_mac = get_by_id("static_routing_0" + count);
				}
				
				temp_mac.value = get_checked_value(get_by_id("enable"+i))+"/"+ get_by_id("name" + i).value +"/"
								+ get_by_id("Destination" + i).value + "/"+ get_by_id("Sub_Mask" + i).value +"/"
								+ get_by_id("Sub_gateway" + i).value +"/"+ get_by_id("interface" + i).value + "/"+get_by_id("metric" + i).value;
				count++;			
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
                            <script>show_left("Advance", 9);</script>
                            </UL>
                      	</div>
                      	<br>
						<div id="wan_online" style="display:none"> </div>
              <div id="wan_offline"> </div>
						<br>
            </td>
                    </tr>
                  </tbody>
                </table></td>

                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_routing.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
				<input type="hidden" id="action" name="action" value="static_route_edit">
                
                <input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
				<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
				<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
                <!-- New Variable -->
				<input type="hidden" id="static_routing_00" name="static_routing_00" value="<!--# echo static_routing_00 -->">
				<input type="hidden" id="static_routing_01" name="static_routing_01" value="<!--# echo static_routing_01 -->">
				<input type="hidden" id="static_routing_02" name="static_routing_02" value="<!--# echo static_routing_02 -->">
				<input type="hidden" id="static_routing_03" name="static_routing_03" value="<!--# echo static_routing_03 -->">
				<input type="hidden" id="static_routing_04" name="static_routing_04" value="<!--# echo static_routing_04 -->">
				<input type="hidden" id="static_routing_05" name="static_routing_05" value="<!--# echo static_routing_05 -->">
				<input type="hidden" id="static_routing_06" name="static_routing_06" value="<!--# echo static_routing_06 -->">
				<input type="hidden" id="static_routing_07" name="static_routing_07" value="<!--# echo static_routing_07 -->">
				<input type="hidden" id="static_routing_08" name="static_routing_08" value="<!--# echo static_routing_08 -->">
				<input type="hidden" id="static_routing_09" name="static_routing_09" value="<!--# echo static_routing_09 -->">
				<input type="hidden" id="static_routing_10" name="static_routing_10" value="<!--# echo static_routing_10 -->">
				<input type="hidden" id="static_routing_11" name="static_routing_11" value="<!--# echo static_routing_11 -->">
				<input type="hidden" id="static_routing_12" name="static_routing_12" value="<!--# echo static_routing_12 -->">
				<input type="hidden" id="static_routing_13" name="static_routing_13" value="<!--# echo static_routing_13 -->">
				<input type="hidden" id="static_routing_14" name="static_routing_14" value="<!--# echo static_routing_14 -->">
				<input type="hidden" id="static_routing_15" name="static_routing_15" value="<!--# echo static_routing_15 -->">
				<input type="hidden" id="static_routing_16" name="static_routing_16" value="<!--# echo static_routing_16 -->">
				<input type="hidden" id="static_routing_17" name="static_routing_17" value="<!--# echo static_routing_17 -->">
				<input type="hidden" id="static_routing_18" name="static_routing_18" value="<!--# echo static_routing_18 -->">
				<input type="hidden" id="static_routing_19" name="static_routing_19" value="<!--# echo static_routing_19 -->">
				<input type="hidden" id="static_routing_20" name="static_routing_20" value="<!--# echo static_routing_20 -->">
				<input type="hidden" id="static_routing_21" name="static_routing_21" value="<!--# echo static_routing_21 -->">
				<input type="hidden" id="static_routing_22" name="static_routing_22" value="<!--# echo static_routing_22 -->">
				<input type="hidden" id="static_routing_23" name="static_routing_23" value="<!--# echo static_routing_23 -->">
				<input type="hidden" id="static_routing_24" name="static_routing_24" value="<!--# echo static_routing_24 -->">
				<input type="hidden" id="static_routing_25" name="static_routing_25" value="<!--# echo static_routing_25 -->">
				<input type="hidden" id="static_routing_26" name="static_routing_26" value="<!--# echo static_routing_26 -->">
				<input type="hidden" id="static_routing_27" name="static_routing_27" value="<!--# echo static_routing_27 -->">
				<input type="hidden" id="static_routing_28" name="static_routing_28" value="<!--# echo static_routing_28 -->">
				<input type="hidden" id="static_routing_29" name="static_routing_29" value="<!--# echo static_routing_29 -->">
				<input type="hidden" id="static_routing_30" name="static_routing_30" value="<!--# echo static_routing_30 -->">
				<input type="hidden" id="static_routing_31" name="static_routing_31" value="<!--# echo static_routing_31 -->">
				<input type="hidden" id="static_routing_32" name="static_routing_32" value="<!--# echo static_routing_32 -->">
				<input type="hidden" id="static_routing_33" name="static_routing_33" value="<!--# echo static_routing_33 -->">
				<input type="hidden" id="static_routing_34" name="static_routing_34" value="<!--# echo static_routing_34 -->">
				<input type="hidden" id="static_routing_35" name="static_routing_35" value="<!--# echo static_routing_35 -->">
				<input type="hidden" id="static_routing_36" name="static_routing_36" value="<!--# echo static_routing_36 -->">
				<input type="hidden" id="static_routing_37" name="static_routing_37" value="<!--# echo static_routing_37 -->">
				<input type="hidden" id="static_routing_38" name="static_routing_38" value="<!--# echo static_routing_38 -->">
				<input type="hidden" id="static_routing_39" name="static_routing_39" value="<!--# echo static_routing_39 -->">
				<input type="hidden" id="static_routing_40" name="static_routing_40" value="<!--# echo static_routing_40 -->">
				<input type="hidden" id="static_routing_41" name="static_routing_41" value="<!--# echo static_routing_41 -->">
				<input type="hidden" id="static_routing_42" name="static_routing_42" value="<!--# echo static_routing_42 -->">
				<input type="hidden" id="static_routing_43" name="static_routing_43" value="<!--# echo static_routing_43 -->">
				<input type="hidden" id="static_routing_44" name="static_routing_44" value="<!--# echo static_routing_44 -->">
				<input type="hidden" id="static_routing_45" name="static_routing_45" value="<!--# echo static_routing_45 -->">
				<input type="hidden" id="static_routing_46" name="static_routing_46" value="<!--# echo static_routing_46 -->">
				<input type="hidden" id="static_routing_47" name="static_routing_47" value="<!--# echo static_routing_47 -->">
				<input type="hidden" id="static_routing_48" name="static_routing_48" value="<!--# echo static_routing_48 -->">
				<input type="hidden" id="static_routing_49" name="static_routing_49" value="<!--# echo static_routing_49 -->">

                
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1><!--#tr tag='.routing' --><script>show_words(_routing);</script></h1>
                    <p><!--#tr tag='av.intro.r' --><script>show_words(av_intro_r);</script><!--#endtr --></p>
                    <br>
                    <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                    <input name="button2" id="button2" type=button class=button_submit value="" onclick="return page_cancel('form1', 'adv_routing.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <a name="show_list"></a>
                  <div class=box>
                    <h2><!--#tr tag='r.rlist' --><script>show_words(r_rlist);</script><!--#endtr --></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=center width=20>&nbsp;</td>
                          <td align=center>&nbsp;</td>
                  		  <td align=center>&nbsp;</td>
                          <td align=center><!--#tr tag='.metric' --><script>show_words(_metric);</script><!--#endtr --></td>
						  <td align=center><!--#tr tag='.interface' --><script>show_words(_interface);</script><!--#endtr --></td>
						</tr>
						
                        <script>
							set_routes();
							for(var i=0 ; i<rule_max_num ; i++){
								var is_checked = "";
								var obj_Name = "";
								var obj_IP = "";
								var obj_Mask = "";
								var obj_gateway = "";
								var obj_interface = "WAN";
								var obj_metric = "";
								if(i < DataArray.length){
									obj_Name = DataArray[i].Name;
									obj_IP = DataArray[i].Ip_addr;
									obj_Mask = DataArray[i].Net_mask;
									obj_gateway = DataArray[i].Gateway;
									obj_interface = DataArray[i].Interface;
									obj_metric = DataArray[i].Metric;
								}
								document.write("<tr>")
								document.write("<td align=center rowspan=2><input type=\"checkbox\" id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>")
								document.write("<td>"+_name+"<br><input type=\"text\" class=flatL id=\"name" + i + "\" name=\"name" + i + "\" size=16 maxlength=15 value=\""+ obj_Name +"\"></td>")
								document.write("<td>"+_destip+"<br><input type=\"text\" class=flatL id=\"Destination" + i + "\" name=\"Destination" + i + "\" size=16 maxlength=15 value=\""+ obj_IP +"\"></td>")
								document.write("<td align=center rowspan=2><input type=\"text\" class=flatL id=\"metric" + i + "\" name=\"metric" + i + "\" size=16 maxlength=15 value=\""+ obj_metric +"\"></td>")
								document.write("<td align=center rowspan=2>&nbsp;");
								document.write("<select style='width:90' id=\"interface" + i +"\" name=\"interface" + i +"\">");
								document.write("<option value=\"WAN\">WAN</option>");
								if ("<!--# echo feature_russsia -->" == "1")
									if(get_by_id("wan_pptp_russia_enable").value == "1" ||get_by_id("wan_l2tp_russia_enable").value == "1" || get_by_id("wan_pppoe_russia_enable").value == "1"){
										document.write("<option value=\"WAN_PHY\">WAN(Physical Port)</option>");
								}	
								document.write("</select></td>");
								document.write("</tr>")
								
								document.write("<tr>")
								document.write("<td>"+_netmask+"<br><input type=\"text\" class=flatL id=\"Sub_Mask" + i + "\" name=\"Sub_Mask" + i + "\" size=16 maxlength=15 value=\""+ obj_Mask +"\"></td>")
								document.write("<td>"+_gateway+"<br><input type=\"text\" class=flatL id=\"Sub_gateway" + i + "\" name=\"Sub_gateway" + i + "\" size=16 maxlength=15 value=\""+ obj_gateway +"\"></td>")
								
								document.write("</tr>")
								
								
								if(i < DataArray.length){
									set_checked(DataArray[i].Enable, get_by_id("enable"+i));
									set_selectIndex(DataArray[i].Interface, get_by_id("interface"+i));
								}
							}
						  </script> 
                      </tbody>
                    </table>
                  </div>             
			  </div>
			 
      </td>
			  </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>..</b><br>
                          <p>
                <!--#tr tag='hhav.enable' -->
                <script>show_words(hhav_enable);</script>
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_name' -->
				<script>show_words(hhav_r_name);</script>
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_dest_ip' -->
				<script>show_words(hhav_r_dest_ip);</script>                
				<!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_netmask' -->
                <script>show_words(hhav_r_netmask);</script> 
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_gateway' -->
                <script>show_words(hhav_r_gateway);</script>
                <!--#endtr -->
              </p>
              <p class="more"><a href="support_adv.asp#Routing" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
              
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
<script>
reboot_needed(left["Advance"].link[9]);
set_form_default_values("form1");
onPageLoad();
</script>
</body>
</html>
