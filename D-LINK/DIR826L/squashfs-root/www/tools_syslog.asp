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
	
	/* get time information */
	var param = {
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=2'+
				'&oid_1=IGD_SystemLogInfo_&inst_1=11000'+
				'&oid_2=IGD_Status_LANStatus_Host_i_&inst_2=11110'
	};
	get_config_obj(param);
	
	var objSysLog = {
		'enable':	config_val('sysLog_SysLogServerEnable_'),
		'servAddr':	config_val('sysLog_SysLogServerAddress_')
	};
	
	var DHCPList_word = "";
	var DHCPL_DataArray = new Array();
	
	function DHCP_Data(name, ip, mac, Exp_time, onList){
		this.Name = name;
		this.IP = ip;
		this.MAC = mac;
		this.EXP_T = Exp_time;
		this.OnList = onList ;
	}
	
	function set_lan_dhcp_list(){
		var index = 0;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3],index);
				DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
				index++;
			}
		}
	}
	
	function print_dhcp_sel(){
		var print_sel = get_by_id("sys_dhcp").selectedIndex;
		if(print_sel > 0){
			get_by_id("sys_server").value = get_by_id("sys_dhcp").options[get_by_id("sys_dhcp").selectedIndex].value;
		}
	}
	
	function onPageLoad(){
		//Syslog settings
		//var syslog_ser = get_by_id("syslog_server").value.split("/");
		set_checked(objSysLog.enable, get_by_id("sel_sys_enable"));
		get_by_id("sys_server").value = objSysLog.servAddr;

		if(dev_info.login_info != "w"){
			DisableEnableForm(document.form1,true);	
		}else{
			disable_log();
		}
	}

	function do_submit() 
	{
		var param = {
			'url':	'get_set.ccp',
			'arg':	'ccp_act=set'
		};
		
		param.arg += '&ccpSubEvent=CCP_SUB_SYSLOG&nextPage=tools_syslog.asp'+
					'&sysLog_SysLogServerEnable_1.1.0.0.0='+($('#sel_sys_enable').attr('checked')? '1': '0')+
					'&sysLog_SysLogServerAddress_1.1.0.0.0='+$('#sys_server').val();
		get_config_obj(param);
	}
	
	function send_request(){
		//if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
		if (!is_form_modified("form1") && !confirm(get_words('_ask_nochange'))) {
			return false;
		}
		
		if(get_by_id("sel_sys_enable").checked){
                        var lan_ip = dev_info.lanIP;
			var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), sys_ip_addr_msg, false, false);
			var sys_ip_addr_msg = replace_msg(all_ip_addr_msg,get_words('tsl_SLSIPA'));
    		var temp_sys_ip_obj = new addr_obj(get_by_id("sys_server").value.split("."), sys_ip_addr_msg, false, false);
    		if(!check_address(temp_sys_ip_obj)){
	            return false;
        	}
        	//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_sys_ip_obj.addr, "IP address")){
					return false;
				}
        }else{
        	get_by_id("sys_server").value = "0.0.0.0";
        }

		//save Syslog settings
		get_by_id("syslog_server").value = get_checked_value(get_by_id("sel_sys_enable")) +"/"+ get_by_id("sys_server").value;
		
		do_submit();
		//get_by_id("form1").submit();
	}
	
	function disable_log(){
		get_by_id("show_sysip").style.display = "none";
	  	if (get_by_id("sel_sys_enable").checked){
	    	get_by_id("show_sysip").style.display = "";
	  	}
	}		
</script>	
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>

</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
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
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_syslog)</script></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li>
									<!--li><div id="sidenavon"><a href="logout.asp" onclick="do_logout();"><script>show_words(logout_caption)</script></a></div></li-->
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_syslog.asp">
			
			<input type="hidden" id="syslog_server" name="syslog_server" value="">
			<input type="hidden" id="dhcp_list" name="dhcp_list" value="">
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  
          <div id="box_header"> 
            <h1>
              <script>show_words(_syslog)</script>
            </h1>
            <script>show_words(tsl_intro)</script>
            <br>
            <br>
                        <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
						<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'tools_syslog.asp');">
						<script>get_by_id("button").value = get_words('_savesettings');</script>
						<script>get_by_id("button2").value = get_words('_dontsavesettings');</script> 
				  </div>
			 	  
          <div class="box"> 
            <h2> 
              <script>show_words(tsl_SLSt)</script>
            </h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple1"><script>show_words(tsl_EnLog)</script>:</td>
                        <td width=57%><input type="Checkbox" id="sel_sys_enable" name="sel_sys_enable" value="1" onClick="disable_log();"></td>
                      </tr>
                      <tr id="show_sysip" style="display:none">
                        <td class="duple1"><script>show_words(tsl_SLSIPA)</script>:</td>
                        <td width=57%> 
							<input type=text id="sys_server" name="sys_server" size=16 maxlength=15>
							&lt;&lt;
                            <select id="sys_dhcp" name="sys_dhcp" size=1 onChange="print_dhcp_sel()">
                              <option value="-1"><script>show_words(bd_CName)</script></option>
                              <script>
                              	//set_lan_dhcp_list();
                              	//document.write(DHCPList_word);
								get_host_list( 'ip' );
                              </script>
                            </select>
						</td>
                      </tr>
            		</table>
			 	  </div>
				</div>
			</td>
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    
          <td id="help_text"><strong> 
            <script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(hhts_def)</script>
            </p>
					  	<p><a href="support_tools.asp#SysLog" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                    </td>
                  </tr>
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
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
