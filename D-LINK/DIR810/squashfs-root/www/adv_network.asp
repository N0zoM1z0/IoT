<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

var param = {
	url: 	"get_set.ccp",
	arg: 	"ccp_act=get&num_inst=3&"+
			"oid_1=IGD_AdvNetwork_&inst_1=11000&"+
			"oid_2=IGD_WANDevice_i_InboundFilter_i_&inst_2=11000&"+
			"oid_3=IGD_&inst_3=10000"
};
get_config_obj(param);
var dev_mode = config_val("igd_DeviceMode_");

var array_ib_inst 		= config_inst_multi("IGD_WANDevice_i_InboundFilter_i_");

var array_filter_name = config_str_multi("ibFilter_Name_");
var array_filter_act = config_str_multi("ibFilter_Action_");
var ib_filter_cnt = 0;
if(array_filter_name != null)
	ib_filter_cnt = array_filter_name.length;

var submit_button_flag = 0;
var rule_max_num = 10;
var inbound_used = 2;
var DataArray = new Array();
function onPageLoad(){
	if(config_val("advNetwork_UpnpEnable_"))
		set_checked(config_val("advNetwork_UpnpEnable_"), get_by_id("upnpEnable"));
	if(config_val("advNetwork_WanPingEnable_"))
		set_checked(config_val("advNetwork_WanPingEnable_"), get_by_id("wan_ping"));
	if(config_val("advNetwork_WanPortSpeed_"))
		get_by_id("wan_port_speed").value = config_val("advNetwork_WanPortSpeed_");
		//set_selectIndex(config_val("advNetwork_WanPortSpeed_"), get_by_id("wan_port_speed"));
	if(config_val("advNetwork_MulticastEnable_"))
		set_checked(config_val("advNetwork_MulticastEnable_"), get_by_id("multi_enable"));
	if(config_val("advNetwork_MulticastIPv6Enable_"))
		set_checked(config_val("advNetwork_MulticastIPv6Enable_"), get_by_id("multi_enable_v6"));

	get_by_id("wan_port_ping_response_inbound_filter").value = config_val("advNetwork_WanPingInboundFilter_");
	var show_selected = get_by_id("wan_port_ping_response_inbound_filter").value;
	get_by_id("filtext").value = config_val("advNetwork_WanPingDetail_");
	wan_ping_ingress_filter_name_selector(show_selected);
	
	set_selectIndex(show_selected, get_by_id("inbound_filter"));
	disable_wan();
	set_form_default_values("form1");
	
	var login_who= login_Info;
		if(login_who!= "w" || dev_mode == "1"){
		DisableEnableForm(form1,true);	
	} 
}

//name/action/used(vs/port/wan/remote)
function Data(name, action, used, onList) 
{
	this.Name = name;
	this.Show_W = "";
	this.Used = used;
	this.OnList = onList;
	var sActionW = "Allow All"
	if(action =="deny"){
		sActionW = "Deny";
	}
	this.sAction = sActionW;
}

function set_Inbound(){
	var index = 0;
	for (var i = 0; i < rule_max_num; i++){
		var temp_st;
		var temp_A;
		var temp_B;
		var k=i;
		if(parseInt(i,10)<10){
			k="0"+i;
		}
		temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
		if (temp_st.length > 1){
			if(temp_st[0] != ""){
				DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
				temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
				for(j=0;j<temp_A.length;j++){
					var temp_A_e = temp_A[j].split("/");
					var temp_A_ip = temp_A_e[1].split("-");
					if(temp_A_e[0] == "1"){
						var T_IP_R = temp_A_e[1];
						if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
							T_IP_R = "*";
						}else if(temp_A_ip[0] == temp_A_ip[1]){
							T_IP_R = temp_A_ip[0];
						}
						if(DataArray[index].Show_W !=""){
							DataArray[index].Show_W = DataArray[index].Show_W + ",";
						}
						DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
					}
				}
				temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
				for(j=0;j<temp_B.length;j++){
					var temp_B_e = temp_B[j].split("/");
					var temp_B_ip = temp_B_e[1].split("-");
					if(temp_B_e[0] == "1"){
						var T_IP_R = temp_B_e[1];
						if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
							T_IP_R = "*";
						}else if(temp_B_ip[0] == temp_B_ip[1]){
							T_IP_R = temp_B_ip[0];
						}
						if(DataArray[index].Show_W !=""){
							DataArray[index].Show_W = DataArray[index].Show_W + ",";
						}
						DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
					}
				}
				load_inbound_used(k, temp_st, inbound_used);
				index++;
			}
		}
	}
}

function show_option_value(){
	for(var i=0;i<ib_filter_cnt;i++){
		document.write("<option value=\""+ (i+1) +"\">"+ array_filter_name[i] +"</option>");
	}
}

function send_request(){
	if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange))) {
		return false;
	}
	get_by_id("upnp_enable").value = get_checked_value(get_by_id("upnpEnable"));
	get_by_id("wan_port_ping_response_enable").value = get_checked_value(get_by_id("wan_ping"));
	get_by_id("multicast_stream_enable").value = get_checked_value(get_by_id("multi_enable"));
	get_by_id("multicast_stream_enable_v6").value = get_checked_value(get_by_id("multi_enable_v6"));
	//save_inbound_used(get_by_id("wan_port_ping_response_inbound_filter").value, inbound_used);
	if(submit_button_flag == 0){
			submit_button_flag = 1;
			copy_data_to_cgi_struct();
			get_by_id('form2').submit();
			return false;
		}else{
			return false;
		}
}

function wan_ping_ingress_filter_name_selector(obj_value){
	if (obj_value < 1)
		return;
	if(obj_value !="255" && obj_value !="254"){
		get_by_id("wan_port_ping_response_inbound_filter").value = obj_value;
		if (array_ib_inst != null) {
			var count=0;
			var aStr = new String(array_ib_inst[obj_value-1]);
			param.arg = 'ccp_act=get&num_inst=1';
			param.arg += '&oid_1=IGD_WANDevice_i_InboundFilter_i_IPRange_i_&inst_1='+aStr.replace(/,/g, '');
		}
		get_config_obj(param);
		
		var arr_enable  = config_str_multi('ipRange_Enable_');
		var arr_range_s = config_str_multi('ipRange_RemoteIPStart_');
		var arr_range_e = config_str_multi('ipRange_RemoteIPEnd_');

		var str = '';
		if (arr_enable != null) {
			str += ((array_filter_act[obj_value-1] == 0)? get_words('_allow'): get_words('_deny'));
			for (var i=0; i<arr_enable.length; i++) {
				if (arr_enable[i] == '0')
					continue;
				str += ', '+arr_range_s[i]+'-'+arr_range_e[i];
			}
		}
/*
		if (str.length != 0) {
			str = str.substring(1, str.length);
		}
*/
		get_by_id("filtext").value = str;
	}else{
		get_by_id("wan_port_ping_response_inbound_filter").value = obj_value;
		if(obj_value == "255")
			get_by_id("filtext").value = get_words('_allowall');
		else if(obj_value == "254")
			get_by_id("filtext").value = get_words('_denyall');
	}
}

function copy_data_to_cgi_struct()
{
	get_by_id("advNetwork_UpnpEnable_").value = get_by_id("upnp_enable").value;
	get_by_id("advNetwork_WanPingEnable_").value = get_by_id("wan_port_ping_response_enable").value;
	get_by_id("advNetwork_WanPingInboundFilter_").value = get_by_id("inbound_filter").value;
	//get_by_id("advNetwork_WanPingFilterName_").value = get_by_id("").value;
	get_by_id("advNetwork_WanPingDetail_").value = get_by_id("filtext").value;
	get_by_id("advNetwork_WanPortSpeed_").value = get_by_id("wan_port_speed").value;
	get_by_id("advNetwork_MulticastEnable_").value = get_by_id("multicast_stream_enable").value;
	get_by_id("advNetwork_MulticastIPv6Enable_").value = get_by_id("multicast_stream_enable_v6").value;
}

function disable_wan()
{
	if($('#wan_ping').attr('checked')==true)
	{
		$('#inbound_filter').attr('disabled', false);
		$('#filtext').attr('disabled', false);
		
	}
	else
	{
		$('#inbound_filter').attr('disabled', true);
		$('#filtext').attr('disabled', true);
	}
	
}
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support" onclick="return jump_if();"><script>document.write(model);</script></a></td>
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
	    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <!-- === BEGIN SIDENAV === -->
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
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_advnetwork)</script></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
                      </td>
                    </tr>
                </table></td>

			<form id="form1" name="form1" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_network.asp">

            <td valign="top" id="maincontent_container">
            	<div id="maincontent">
                  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(_advnetwork)</script></h1>
                    <p>
                       <script>show_words(anet_intro)</script>
                    </p>
						<input name="apply" id="apply" type="button" class=button_submit value="" onClick="return send_request()">
						<input name="cancel" id="cancel" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_network.asp');">
						<script>get_by_id("apply").value = get_words(_savesettings);</script>
						<script>get_by_id("cancel").value = get_words(_dontsavesettings);</script>

					</div>
					<br>
					<div class=box>
					  <h2>
						<script>show_words(ta_upnp)</script>
					  </h2>

					  <P class="box_msg">
						<script>show_words(anet_msg_upnp)</script>
					  </P>
						<table cellSpacing=1 cellPadding=1 width=525 border=0>
							<tr>

								<td width="185" align=right class="duple">
									<script>show_words(ta_EUPNP)</script>
									:</td>
									  <td width="333" colSpan=3>&nbsp;
									  <input name="upnpEnable" type=checkbox id="upnpEnable" value="1">
									  <input type="hidden" id="upnp_enable" name="upnp_enable" value="">
									  </td>
							</tr>
						</table>
					</div>
                  
					<div class=box> 
					  <h2> 
						<script>show_words(anet_wan_ping)</script>
					  </h2>
								
					  <P class="box_msg"> 
						<script>show_words(anet_msg_wan_ping)</script>
					  </P>
						<table cellSpacing=1 cellPadding=1 width=525 border=0>
							<tr>
							  
							  <td width="185" align=right class="duple"> 
								<script>show_words(bwn_RPing)</script>
								:</td>
										  <td width="333" colSpan=3>&nbsp;
										  <input name="wan_ping" type="checkbox" id="wan_ping" value="1" onclick="disable_wan();">
										  <input type="hidden" id="wan_port_ping_response_enable" name="wan_port_ping_response_enable" value="">
										  </td>
							</tr>
							<tr>

							  <td width="185" align=right class="duple">
								<script>show_words(bwn_IF)</script>
								:</td>
										  <td width="333" colSpan=3>&nbsp;
										  <input type="hidden" id="wan_port_ping_response_inbound_filter" name="wan_port_ping_response_inbound_filter" value="">
										  <select id="inbound_filter" name="inbound_filter" onchange="wan_ping_ingress_filter_name_selector(this.value);">
											<option value="255"><script>show_words(_allowall)</script></option>
											<option value="254"><script>show_words(_denyall)</script></option>
											<script>
											//set_Inbound();
											show_option_value();
											</script>
										  </select>
										  </td>
							</tr>
							<tr>

							  <td width="185" align=right class="duple">
								<script>show_words(_aa_details)</script>
								:</td>
										  <td width="333" colSpan=3>&nbsp;
										  <input type="text" id="filtext" name="filtext" size="48" maxlength="48" readonly="readonly">
										  </td>
							</tr>
						</table>
					</div>

					<div class=box>
					  <h2>
						<script>show_words(anet_wan_phyrate)</script>
					  </h2>
						<table width="525" border=0 cellpadding=0>
						  <tr>

							  <td width="185" align=right class="duple">
								<script>show_words(anet_wan_phyrate)</script>
								:</td>
										  <td width="333" colSpan=3>&nbsp;
										  <select name="wan_port_speed" id="wan_port_speed">
											 <option value="0"><script>show_words(anet_wp_0)</script></option>
											 <option value="1"><script>show_words(anet_wp_1)</script></option>
											 <option value="3"><script>show_words(anet_wp_auto2)</script></option>
										  </select>
										  </td>
							</tr>
						</table>
                  </div>
                  <div class=box>
					<h2>
					  <script>show_words(anet_multicast_v4)</script>
					</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>

							<td width="250" align=right class="duple">
							  <script>show_words(anet_multicast_enable_v4)</script>
							  :</td>
										  <td width="275" colSpan=2>&nbsp;
										  <input name="multi_enable" type=checkbox id="multi_enable" value="1">
										  <input type="hidden" id="multicast_stream_enable" name="multicast_stream_enable" value="">
										  </td>
                        </tr>
                    </table>
				</div>
				<div class=box> 
					<h2>
					  <script>show_words(anet_multicast_v6)</script>
					</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>

							<td width="250" align=right class="duple" >
							  <script>show_words(anet_multicast_enable_v6)</script>
							  :</td>
										  <td width="275" colSpan=2>&nbsp;
										  <input name="multi_enable_v6" type=checkbox id="multi_enable_v6" value="1">
										  <input type="hidden" id="multicast_stream_enable_v6" name="multicast_stream_enable_v6" value="">
										  </td>
                        </tr>
                    </table>
				</div>
			</form>
                  
              <!-- === END MAINCONTENT === -->
			 </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table width="125" border=0 
      cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
							<tr>

				  <td id=help_text><strong>
					<script>show_words(_hints)</script>
					&hellip;</strong> <p>
					  <script>show_words(hhan_upnp)</script>
					</p>

					<p>
					  <script>show_words(hhan_ping)</script>
					</p>

					<p>
					  <script>show_words(hhan_wans)</script>
					</p>

					<p>
					  <script>show_words(hhan_mc)</script>
					</p>
					<p class="more"><a href="support_adv.asp#Network" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
							</tr>
                </table>
			</td>
		</tr>
	</table>
	<form id="form2" action="get_set.ccp">
		<input type="hidden" name="ccp_act" value="set">
		<input type="hidden" name="ccpSubEvent" value="CCP_SUB_ADVNET">
		<input type="hidden" name="nextPage" value="adv_network.asp">	
		<input type="hidden" id="advNetwork_UpnpEnable_" name="advNetwork_UpnpEnable_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_WanPingEnable_" name="advNetwork_WanPingEnable_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_WanPingInboundFilter_" name="advNetwork_WanPingInboundFilter_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_WanPingFilterName_" name="advNetwork_WanPingFilterName_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_WanPingDetail_" name="advNetwork_WanPingDetail_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_WanPortSpeed_" name="advNetwork_WanPortSpeed_1.1.0.0.0" value="">
		<input type="hidden" id="advNetwork_MulticastEnable_" name="advNetwork_MulticastEnable_1.1.0.0.0" value="">	
		<input type="hidden" id="advNetwork_MulticastIPv6Enable_" name="advNetwork_MulticastIPv6Enable_1.1.0.0.0" value="">	
	</form>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>
