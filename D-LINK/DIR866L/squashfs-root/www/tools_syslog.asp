<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">	
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
		var print_sel = get_by_id("sys_dhcp").value;
		if(print_sel > -1){
			get_by_id("sys_server").value = DHCPL_DataArray[print_sel].IP;
		}
	}
	
	function onPageLoad(){
		//Syslog settings
		var syslog_ser = get_by_id("syslog_server").value.split("/");
		set_checked(syslog_ser[0], get_by_id("sel_sys_enable"));
		get_by_id("sys_server").value = syslog_ser[1];
		var login_who= checksessionStorage();
                if(login_who== "user"){
                        DisableEnableForm(document.form1,true); 
                }else{
			disable_log();
		}
	}

	function toPrefix (bit, padchar, deflen) {
		if (bit.length >= parseInt(deflen))
			return (bit);
		var out = bit
			for (var cnt = bit.length; cnt < parseInt(deflen); cnt++) {
				out = padchar + out;
			}
		return (out);
	}


	function toConvertBit(num){
                var base = 2;
                var tmp = parseInt(num);
                var bitNum = tmp.toString(base);
                bitNum = toPrefix(bitNum, "0", 8);
                return bitNum;
        }

	function convertIPToBit(ipaddr)
	{
		var ip_obj = ipaddr.split(".");
                var ip_bit = "";
                
                for(var i = 0; i < 4; i++){
                        ip_bit += toConvertBit(ip_obj[i]) 
                }
                return ip_bit;

	}
	
	function exclusiveCal(ip, mask)
	{
		var ip_bits = convertIPToBit(ip);
		var mask_bits = convertIPToBit(mask);
		var res = "";
		for(var i = 0; i <ip_bits.length; i++)
                        res += (ip_bits.charAt(i) & mask_bits.charAt(i));
                return res;
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}

		if(get_by_id("sel_sys_enable").checked){
			var lan_ip = "<!--# echo lan_ipaddr -->";
			var mask = "<!--# echo lan_netmask -->";
			var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
			var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), sys_ip_addr_msg, false, false);
			var sys_ip_addr_msg = replace_msg(all_ip_addr_msg,tsl_SLSIPA);
			var temp_sys_ip_obj = new addr_obj(get_by_id("sys_server").value.split("."), sys_ip_addr_msg, false, false);

			if(!check_address(temp_sys_ip_obj, temp_mask_obj)){
			    return false;
			}
			/* It just check conflict with lan ip */
			if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_sys_ip_obj.addr, _ipaddr)){
				return false;
			}

			var ip_segment = exclusiveCal(lan_ip, mask);
			var sysip_segment = exclusiveCal(get_by_id("sys_server").value, mask);
			if (ip_segment != sysip_segment) {
				alert(FMT_INVALID_IPRANGE);
				return false;
			}
		}else{
			get_by_id("sys_server").value = "0.0.0.0";
		}

		//save Syslog settings
		get_by_id("syslog_server").value = get_checked_value(get_by_id("sel_sys_enable")) +"/"+ get_by_id("sys_server").value;
		
		get_by_id("form1").submit();
	}
	
	function disable_log(){
		get_by_id("show_sysip").style.display = "none";
	  	if (get_by_id("sel_sys_enable").checked){
	    	get_by_id("show_sysip").style.display = "";
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
			<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<script>show_left("tools", 2);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_syslog.asp">
			<input type="hidden" id="syslog_server" name="syslog_server" value="<!--# echo syslog_server -->">
			<input type="hidden" id="reboot_type" name="reboot_type" value="application">
			<input type="hidden" id="result_timer" name="result_timer" value="20">
			<input type="hidden" id="action" name="action" value="tools_syslog">
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
						<h1><script>show_words(_syslog);</script></h1>
						<script>show_words(tsl_intro);</script><br><br>
						<input name="button3" id="button3" type="button" class=button_submit value="" onClick="send_request()">
                        			<input name="button2" id="button2" type="reset" class=button_submit value="" onclick="return page_cancel('form1', 'tools_syslog.asp');">
									<script>check_reboot();</script>
						<script>
							get_by_id("button3").value= _savesettings;
							get_by_id("button2").value= _dontsavesettings;
						</script>
				  </div>
			 	  <div class="box">
                    <h2><script>show_words(tsl_SLSt)</script></h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple"><script>show_words(tsl_EnLog)</script> :</td>
                        <td width=70%><input type="Checkbox" id="sel_sys_enable" value="1" onClick="disable_log();"></td>
                      </tr>
                      <tr id="show_sysip" style="display:none">
                        <td class="duple"><script>show_words(tsl_SLSIPA)</script>:</td>
                        <td width=70%> 
							<input type=text id="sys_server" size=16 maxlength=15>
							&lt;&lt;
                            <select id="sys_dhcp" size=1 onChange="print_dhcp_sel()">
                              <option value="-1"><script>show_words(bd_CName);</script></option>
                              <script>
                              	set_lan_dhcp_list();
                              	document.write(DHCPList_word);
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
                    <td id="help_text"><strong><script>show_words(_hints);</script>&hellip;</strong>
                      	<p><script>show_words(hhts_def)</script></p>
					  	<p><a href="support_tools.asp#SysLog" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                    </td>
                  </tr>
                </table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	reboot_needed(left["tools"].link[2]);
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
