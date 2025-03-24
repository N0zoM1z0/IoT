<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
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
			"oid_1=IGD_MACFilter_&inst_1=11000&"+
			"oid_2=IGD_MACFilter_ClientList_i_&inst_2=11000&"+
			"oid_3=IGD_Status_LANStatus_Host_i_&inst_3=11110"
};
get_config_obj(param);

var array_rul_list = config_str_multi("macList_MACAddress_");

var submit_button_flag = 0;
var rule_max_num = 24;
var resert_rule = rule_max_num;
var DHCPL_DataArray = new Array();
function onPageLoad(){
	if(config_val("macFilter_Action_"))
		get_by_id("mac_filter_type").selectedIndex = config_val("macFilter_Action_");

	if(array_rul_list)
	{
		for(var i=0; i<rule_max_num; i++)
		{
			get_by_id("mac" + i).value = array_rul_list[i];
		}
	}
	
	var login_who= login_Info;
		if(login_who!= "w"){
		DisableEnableForm(form1,true);	
	}else{
		disable_mac_filter();
	}
}
function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}

	function disable_mac_filter(){
		var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
		for (var i = 0; i < rule_max_num; i++){
			get_by_id("mac" + i).disabled = !(mac_filter_type != 0);
			get_by_id("copy" + i).disabled = !(mac_filter_type != 0);
			get_by_id("dhcp_list" + i).disabled = !(mac_filter_type != 0);
			get_by_id("clear" + i).disabled = !(mac_filter_type != 0);
		}
	}

	function copy_mac(index){
		if (get_by_id("dhcp_list" + index).selectedIndex > 0){
			get_by_id("mac" + index).value = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		}else{
			//alert(msg[SELECT_MACHINE_ERROR]);
			alert(get_words(aa_alert_10));
		}
	}

	function clear_mac(index){
		get_by_id("mac" + index).value = "00:00:00:00:00:00";
	}
	
	function check_dhcp_ip(index){
		var index = 0;
		var mac = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
				//check selected mac equal to mac or not?
				index++;
				if(mac == temp_data[2]){
					//var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
					var lan_ip = "";
					
					var lan_ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
					var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), lan_ip_addr_msg, false, false);
					var ip = temp_data[1];
					var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
					var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
					if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, "IP address")){
						return false;
					}
					return true;
				}
			}
		}
		return true;
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange))) {
			return false;
		}
		var lan_mac = "";
		var i=0;
		var mac = 0;
		var flag = 0;
		for(var i=0; i < rule_max_num; i++){
			var mac = get_by_id("mac" + i).value;
			if (get_by_id("mac" + i).value != ""){			
				if (mac != "00:00:00:00:00:00" && mac !=""){
					if (!check_mac(mac)){
						//alert(msg[MAC_ADDRESS_ERROR]);
						alert(get_words(LS47));
						return false;
					}
                    if (mac.toLowerCase() == lan_mac.toLowerCase() ){
						//alert(msg[MAC_ADDRESS_ERROR]);
						alert(get_words(LS47));
						return false;
					}
                    if(!check_dhcp_ip()){
						return false;
					}
					
					for (var j = i+1; j < rule_max_num; j++){
						if (mac != "00:00:00:00:00:00" && mac !="" && mac.toLowerCase() == get_by_id("mac" + j).value.toLowerCase()){
							//alert("The Access Control mac address is already in the list");
							alert(addstr(get_words(GW_MAC_FILTER_MAC_UNIQUENESS_INVALID), mac));
							return false;
						}
					}
					
					flag = 1;
					continue;
				}
			}
		}
		if(flag == 0){ // Graceyang (2009.3.27) :when set mac is 00:00:00:00:00:00 should be saved  
			var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
			if(mac_filter_type !="1"){
				for(k=0; k < rule_max_num; k++){
					get_by_id("mac" + k).value = "00:00:00:00:00:00";
				}
			}else{
				//alert("MAC Filter settings will lockout all machines. This is not allowed.");
				alert(get_words(GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID));
				return false;
			}
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			copy_data_to_cgi_struct();
			//get_by_id("form1").submit();
			get_by_id("form2").submit();
		}
	}
	
	function copy_data_to_cgi_struct()
	{
		get_by_id("macFilter_Action_").value = get_by_id("mac_filter_type").selectedIndex;
		for(var i=0; i<rule_max_num; i++)
		{	
			var kk=i;
			if(i<10)
				kk="0"+i;
			get_by_id("macList_MACAddress_"+(i+1)).value = get_by_id("mac"+i).value;
		}
	}
	
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
						  <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(_netfilt)</script></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
                      </td>
                    </tr>
                </table></td>

                <input type="hidden" id="dhcp_list" name="dhcp_list" value="">

                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_mac.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="all">
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1><script>show_words(_macfilt)</script></h1>
                    <script>show_words(am_intro_1)</script>
                    <br><br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" type="button" id="button2" class=button_submit value="" onclick="page_cancel('form1', 'adv_filters_mac.asp');">
					<script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
					<script>get_by_id("button").value = get_words(_savesettings);</script>
                  </div>
                  <br>
                  <div class=box>
                    <h2><script>document.write(rule_max_num)</script> &ndash;&ndash; <script>show_words(am_MACFILT)</script></h2>
                    <table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tbody>
                        <tr>
                          <td><script>show_words(am_intro)</script></td>
                        </tr>
                        <tr>
                          <td>
                          <select id="mac_filter_type" name="mac_filter_type" onChange="disable_mac_filter();">
                              <option value="disable"><script>show_words(am_FM_2)</script></option>
                              <option value="list_allow"><script>show_words(am_FM_3)</script></option>
                              <option value="list_deny"><script>show_words(am_FM_4)</script></option>
                            </select>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td width="100" align=left><strong><script>show_words(_macaddr)</script></strong></td>
                          <td>&nbsp;</td>
                          <td width="250" align=left><strong><script>show_words(bd_DHCP)</script></strong></td>
                          <td>&nbsp;</td>
                        </tr>
                        <script>
							//var Schedule_list = set_schedule_option(Schedule_list);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>")
								//document.write("<td align=\"middle\"><INPUT type=\"checkbox\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
								document.write("<td><input type=text class=flatL id=mac" + i + " name=mac" + i + " size=20 maxlength=17><input type=hidden id=name" + i + " name=name" + i + " maxlength=31></td>")
								document.write("<td><input type=button id=copy" + i + " name=copy" + i + " value=<< class=btnForCopy onClick='copy_mac(" + i + ")'></td>");
                        	
								document.write("<td width=155> <select class=wordstyle width=140 id=dhcp_list" + i + " name=dhcp_list" + i + " modified=\"ignore\">")
								document.write("<option value=-1>")
								show_words(bd_CName)
								document.write("</option>")
								get_host_list( 'mac' );
								//document.write(set_mac_list("mac"))
								document.write("</select></td>")
								document.write("<td align=center>")
								document.write('<input type=button id=\"clear' + i + '\" name=\"clear' + i + '\" value="'+get_words(_clear)+'" onClick=\"clear_mac(' + i + ')\">')													
								document.write("</td>")
								document.write("</tr>")
							}
						  </script> 
                      </tbody>
                    </table>
                  </div>
              </div></td></form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
                        <p><script>show_words(hham_intro)</script></p>
                        <p><script>show_words(hham_add)</script></p>
                        <p><script>show_words(hham_del)</script></p>
						<p><a href="support_adv.asp#MAC_Address_Filter" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	<form id="form2" action="get_set.ccp">
		<input type="hidden" name="ccp_act" value="set">
		<input type="hidden" name="ccpSubEvent" value="CCP_SUB_MACFILTER">
		<input type="hidden" name="nextPage" value="adv_filters_mac.asp">	
		<input type="hidden" id="macFilter_Action_" name="macFilter_Action_1.1.0.0.0" value="">
		<script>
			for(var i=0; i<rule_max_num; i++)
			{
				document.write("<input type=\"hidden\" id=\"macList_MACAddress_"+(i+1)+"\" name=\"macList_MACAddress_1.1."+(i+1)+".0.0\" value=\"\">");
			}
		</script>
	</form>
<br>
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
 onPageLoad();
 set_form_default_values("form1");
</script>
</html>
