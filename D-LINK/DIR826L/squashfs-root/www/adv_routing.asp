<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
var dev_info = get_router_info();
document.title = get_words('TEXT000');

var hw_version 	= dev_info.hw_ver;
var version 	= dev_info.fw_ver;
var model		= dev_info.model;
var login_Info 	= dev_info.login_info;
var cli_mac 	= dev_info.cli_mac;

var param = {
	url: "get_set.ccp",
	arg: "ccp_act="
};

param.arg = "ccp_act=get&num_inst=1";
param.arg +="&oid_1=IGD_Layer3Forwarding_Forwarding_i_&inst_1=11000";
get_config_obj(param);

var route_obj = {
	'enable':	config_str_multi("fwdRule_Enable_"),
	'name':		config_str_multi("fwdRule_Name_"),
	'ip':		config_str_multi("fwdRule_DestIPAddress_"),
	'mask':		config_str_multi("fwdRule_DestSubnetMask_"),
	'gw':		config_str_multi("fwdRule_GatewayIPAddress_"),
	'metric':	config_str_multi("fwdRule_ForwardingMetric_"),
	'iface':	config_str_multi("fwdRule_SourceInterface_")
};

var current_rules = 0;
if(route_obj.ip != null)
	current_rules = route_obj.ip.length;

var submit_button_flag = 0;
var rule_max_num = 32;
var resert_rule = rule_max_num;
var DataArray = new Array();

	function onPageLoad()
	{
		if (login_Info != "w") {
			DisableEnableForm(form1,true);
		}
		set_form_default_values("form1");
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

	function set_routes()
	{
		var index = 0;
		for (var i = 0; i < rule_max_num; i++) {
			/*
			var temp_st;
			var k = i;
			if (parseInt(i, 10) < 10) {
				k = "0" + i;
			}

			temp_st = (get_by_id("static_routing_" + k).value).split("/");
			if (temp_st.length > 1) {
				if (temp_st[1] != "name" && temp_st[0] != "") {
					DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], temp_st[3], temp_st[4], temp_st[5], temp_st[6], temp_st[7], index);
					index++;
				}
			}
			*/
			//if(current_rules != 0)
				DataArray[DataArray.length++] = new Data(route_obj.enable[i], route_obj.name[i], route_obj.ip[i], route_obj.mask[i], route_obj.gw[i], route_obj.iface[i], route_obj.metric[i], i);
			//else
				//DataArray[DataArray.length++] = new Data("0", "", "0.0.0.0", "0.0.0.0", "0.0.0.0", "1", "1", i);
		}
	}

	function my_chk_addr(addrObj, maskObj)
	{
		var mask = new Array(255,255,255,0);
		if (addrObj == null || addrObj.addr.length != 4) {
			alert(addrObj.e_msg[INVALID_IP]);
			return false;
		}
		
		if((addrObj.addr[0] == "127") || ((addrObj.addr[0] >= 224) && (addrObj.addr[0] <= 239))){
			alert(addrObj.e_msg[MULTICASE_IP_ERROR]);
			return false;
		}
		
		// check the ip is "0.0.0.0"
		if (!addrObj.allow_zero && addrObj.addr[0] == '0' && addrObj.addr[1] == '0' && addrObj.addr[2] == '0' && addrObj.addr[3] == '0') {
			alert(addrObj.e_msg[ZERO_IP]);
			return false;
		}
		
		if (maskObj != null){
			mask = maskObj.addr;
		}
					
		var ip = addrObj.addr;
		var count_zero = 0;
		var count_bcast = 0;
		for (var i = 0; i < 4; i++){	// check the IP address is a network address or a broadcast address																							
			if (((~mask[i] + 256) & ip[i]) == 0){	// (~mask[i] + 256) = reverse mask[i]
				count_zero++;						
			}
			
			if ((mask[i] | ip[i]) == 255){
				count_bcast++;
			}							
		}
	
		if ((count_zero == 4 && !addrObj.is_network) || (count_bcast == 4)){
			alert(addrObj.e_msg[INVALID_IP]);
			return false;
		}
		return true;
	}
	
	function send_request()
	{
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++) {
			var temp_mac;

			/*if (i > 9)
				get_by_id("static_routing_" + i).value = "0//0.0.0.0/0.0.0.0/0.0.0.0/WAN/1";
			else
				get_by_id("static_routing_0" + i).value = "0//0.0.0.0/0.0.0.0/0.0.0.0/WAN/1";
			*/
			if (get_by_id("Destination" + i).value == "" )
					get_by_id("Destination" + i).value="0.0.0.0";
			if (get_by_id("Sub_Mask" + i).value == "" )
					get_by_id("Sub_Mask" + i).value="0.0.0.0";
			if (get_by_id("Sub_gateway" + i).value == "")
					get_by_id("Sub_gateway" + i).value="0.0.0.0";

					var static_ip = get_by_id("Destination" + i).value;
					var static_mask = get_by_id("Sub_Mask" + i).value;
					var static_gateway = get_by_id("Sub_gateway" + i).value;
					var metric = get_by_id("metric"+ i).value;
    			
					var ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('help256'));
					var gateway_msg = replace_msg(all_ip_addr_msg,get_words('wwa_gw'));

					var static_ip_obj = new addr_obj(static_ip.split("."), ip_addr_msg, false, true);
					var static_mask_obj = new addr_obj(static_mask.split("."), subnet_mask_msg, false, false);
					var static_gateway_obj = new addr_obj(static_gateway.split("."), gateway_msg, false, true);
					var temp_metric = new varible_obj(metric, metric_msg, 1, 16, false);
					var check_name = get_by_id("name"+i).value;
				
					if (get_by_id("enable" + i).checked) {
						if (!check_route_address(static_ip_obj))
							return false;
						if(!check_route_mask(static_mask_obj))
							return false;
						//if (my_chk_addr(static_ip_obj, static_mask_obj) == false)
						//	return false;
						if (!check_address(static_gateway_obj))
							return false;	// when gateway is invalid
						if (!check_varible(temp_metric))
							return false;
						//if(!check_network_address(static_ip_obj, static_mask_obj))
						//	return false;
					}
					if(get_checked_value(get_by_id("enable"+i))=="1"){
						if(trim_string(get_by_id("name"+i).value) == ""){
							alert(get_words('aa_alert_9'));
							return false;
						}else {
							if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
							alert(get_words('TEXT003').replace("+ i +","'" + check_name + "'"));
						return false;
					}
						}
					for (jj=i+1; jj<rule_max_num; jj++) {
						if (get_by_id("Destination" + jj).value != "0.0.0.0") {
							if ((get_by_id("Destination" + jj).value == static_ip) && (get_by_id("interface" + jj).value == get_by_id("interface" + i).value)) {
								alert(get_words('_r_alert_new1')+", '"+ get_by_id("name" + jj).value + "'" + get_words('help264') +" '" + get_by_id("name" + i).value + "'." );
								return false;
							}
						}
							    if(get_by_id("name" +i).value == get_by_id("name" +jj).value){
							        alert(get_words('av_alert_16').replace("+ data.virtual_servers[j].entry_name +",get_by_id("name"+i).value));
							        return false;
							    }
							}
					}
					
					/*
					if (count > 9)
						temp_mac = get_by_id("static_routing_" + count);
					else
						temp_mac = get_by_id("static_routing_0" + count);

					temp_mac.value = get_checked_value(get_by_id("enable"+i))+"/"+ get_by_id("name" + i).value +"/"
								+ get_by_id("Destination" + i).value + "/"+ get_by_id("Sub_Mask" + i).value +"/"
								+ get_by_id("Sub_gateway" + i).value +"/"+ get_by_id("interface" + i).value + "/"+get_by_id("metric" + i).value;
					*/
					count++;
				
			
		}

		if (submit_button_flag == 0) {
			copyDataToDataModelFormat();
			send_submit("form2");
			
			submit_button_flag = 1;
			return true;
		}

		return false;
	}
	
	function copyDataToDataModelFormat()
	{
		for(var i=0; i<rule_max_num; i++)
		{	
			var inst = '1.1.'+(i+1)+'.0.0';
			if (get_by_id('enable'+i).checked == false && get_by_id('name'+i).value == '') {
				get_by_id("fwdRule_Enable_"+inst).value = '0';
				get_by_id("fwdRule_Name_"+inst).value = '';
				get_by_id("fwdRule_DestIPAddress_"+inst).value = '0.0.0.0';
				get_by_id("fwdRule_DestSubnetMask_"+inst).value = '0.0.0.0';
				get_by_id("fwdRule_SourceInterface_"+inst).value = '0';
				get_by_id("fwdRule_GatewayIPAddress_"+inst).value = '0.0.0.0';
				get_by_id("fwdRule_ForwardingMetric_"+inst).value = '1';
			} else {
				get_by_id("fwdRule_Enable_"+inst).value = get_checked_value(get_by_id("enable"+i));
				get_by_id("fwdRule_Name_"+inst).value = get_by_id("name"+i).value;
				get_by_id("fwdRule_DestIPAddress_"+inst).value = get_by_id("Destination"+i).value;
				get_by_id("fwdRule_DestSubnetMask_"+inst).value = get_by_id("Sub_Mask"+i).value;
				get_by_id("fwdRule_SourceInterface_"+inst).value = get_by_id("interface"+i).value;
				get_by_id("fwdRule_GatewayIPAddress_"+inst).value = get_by_id("Sub_gateway"+i).value;
				get_by_id("fwdRule_ForwardingMetric_"+inst).value = get_by_id("metric"+i).value;
			}
		}
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
     <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(model);</script></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
                            <LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
                            <LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
                            <LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_routing)</script></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
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

                <input type="hidden" id="dhcp_list" name="dhcp_list" value=''>

                <form id="form2" name="form2" method="post" action="get_set.ccp">
					<input type="hidden" name="ccp_act" value="set">
					<input type="hidden" name="ccpSubEvent" value="CCP_SUB_ROUTING">
					<input type="hidden" name="nextPage" value="adv_routing.asp">
					<script>
						var str = "";
						for(var i=1; i<=rule_max_num; i++)
						{
							var inst = '1.1.'+i+'.0.0';
							str += '<input type="hidden" name="fwdRule_Enable_'+inst+'" id="fwdRule_Enable_'+inst+'" value="">';
							str += '<input type="hidden" name="fwdRule_Name_'+inst+'" id="fwdRule_Name_'+inst+'" value="">';
							str += '<input type="hidden" name="fwdRule_DestIPAddress_'+inst+'" id="fwdRule_DestIPAddress_'+inst+'" value="">';
							str += '<input type="hidden" name="fwdRule_DestSubnetMask_'+inst+'" id="fwdRule_DestSubnetMask_'+inst+'" value="">';
							str += '<input type="hidden" name="fwdRule_SourceInterface_'+inst+'" id="fwdRule_SourceInterface_'+inst+'" value="1">';
							str += '<input type="hidden" name="fwdRule_GatewayIPAddress_'+inst+'" id="fwdRule_GatewayIPAddress_'+inst+'" value="">';
							str += '<input type="hidden" name="fwdRule_ForwardingMetric_'+inst+'" id="fwdRule_ForwardingMetric_'+inst+'" value="">';
						}
						document.write(str);
					</script>
				</form>
				
                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_routing.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">

			<td valign="top" id="maincontent_container">
				<div id="maincontent">
                  <div id=box_header>
                    <h1><script>show_words(_routing)</script></h1>
                    <p><script>show_words(av_intro_r)</script></p>
				  <br>
                    <input name="button" id="button" type="button" class="button_submit" value="" onClick="send_request()">
           		    <input name="button2" id="button2" type="button" class="button_submit" value="" onclick="page_cancel('form1', 'adv_routing.asp');">
                    <script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
                    <script>get_by_id("button").value = get_words('_savesettings');</script>
				  </div>
                  <a name="show_list"></a>
                  <div class=box>
                    <h2>32 --<script>show_words(r_rlist)</script></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=center width=20>&nbsp;</td>
                          <td align=center>&nbsp;</td>
                  		  <td align=center>&nbsp;</td>
                          <td align=center><script>show_words(_metric)</script></td>
						  <td align=center><script>show_words(_interface)</script></td>
						</tr>

                        <script>
							set_routes();
							for(var i=0 ; i<rule_max_num ; i++){
								var is_checked = "";
								var obj_Name = "";
								var obj_IP = "";
								var obj_Mask = "";
								var obj_gateway = "";
								var obj_interface = "1";
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
								document.write('<td>'+get_words('_name')+'<br><input type=text class=flatL id=name' + i + ' name=name'+ i +' size=16 maxlength=15 value='+ obj_Name +'></td>')
								document.write('<td>'+get_words('_destip')+'<br><input type=text class=flatL id=Destination' + i + ' name=Destination' + i + ' size=16 maxlength=15 value='+ obj_IP +'></td>')
								document.write('<td align=center rowspan=2><input type=text class=flatL id=metric' + i + ' name=metric' + i + ' size=16 maxlength=15 value='+ obj_metric +'></td>')
								document.write("<td align=center rowspan=2>&nbsp;");
								document.write("<select style='width:90' id=\"interface" + i +"\" name=\"interface" + i +"\">");
								document.write("<option value=\"1\">WAN</option>");
								//document.write("<option value=\"WAN_PHY\">WAN(Physical Port)</option>");
								document.write("</select></td>");
								document.write("</tr>")

								document.write("<tr>")
								document.write('<td>'+get_words('_netmask')+'<br><input type=text class=flatL id=Sub_Mask' + i + ' name=Sub_Mask' + i + ' size=16 maxlength=15 value='+ obj_Mask +'></td>')
								document.write('<td>'+get_words('_gateway')+'<br><input type=text class=flatL id=Sub_gateway' + i + ' name=Sub_gateway' + i + ' size=16 maxlength=15 value='+ obj_gateway +'></td>')

								document.write("</tr>")


								if(i < DataArray.length){
									//alert("enble "+i+": "+ DataArray[i].Enable);
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
                      <td id=help_text><b><script>show_words(_hints)</script>&hellip;</b><br>
                          <br><script>show_words(hhav_enable)</script></p>
						  <p><script>show_words(hhav_r_name)</script></p>
						  <p><script>show_words(hhav_r_dest_ip)</script></p>
						  <p><script>show_words(hhav_r_netmask)</script></p>
						  <p><script>show_words(hhav_r_gateway)</script></p>
						  <p><a href="support_adv.asp#Routing" onclick="return jump_if();">
						  <script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>
