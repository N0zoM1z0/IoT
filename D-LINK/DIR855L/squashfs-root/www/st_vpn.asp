<html>
<head>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style3 {font-size: 12px}
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
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
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
									<script>show_left("Status", 6);</script>
                                </ul>
                                <!-- === END SIDENAV === -->
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top" id="maincontent_container" width="567">
		<div id="maincontent">
			<!-- === BEGIN MAINCONTENT === -->
			<div id="box_header"> 
			<h1><script>show_words(st_vpn_list);</script></h1>
			<script>show_words(st_vpn_info);</script>
			</div>
			<div class="box"> 
			<h2>&nbsp;</h2>
			<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width="525" bgColor=#dfdfdf border=1>
			   <tbody>
                              <tr>
                                <td height=2><strong><script>show_words(_type);</script></strong></td>
                                <td height=2><strong><script>show_words(st_vpn_table_local_info);</script></strong></td>
                                <td height=2><strong><script>show_words(st_vpn_table_remote_info);</script></strong></td>
                                <td height=2><strong> <script>show_words(_other);</script> </strong></td>
				<td height=2><strong> <script>show_words(st_vpn_table_encode);</script> </strong></td>
				<td height=2><strong> <script>show_words(_dh_gp);</script> </strong></td>
				<!-- <td height=2><strong> Initial Time </strong></td> -->
				<td height=2><strong> <script>show_words(st_vpn_table_duration_time);</script></strong></td>
			     </tr>

								<script>
								var vpn_time = "<!--# exec cgi /bin/cli utility time -->";
								var vpn_tunnel_list = vpn_time.split("#");
								var vpn_ipsec_sta = "<!--# exec cgi /bin/cli utility ipsec -->";
								var tmp_ipsec_list = vpn_ipsec_sta.split("#");

								for(var i = 0; i < tmp_ipsec_list.length-1 ;i++) {
									
									var ipsec_data = tmp_ipsec_list[i].split(",");
									var ipsec_init_timer = "";
									var ipsec_dur_timer = "";
									for(var j = 0; j < vpn_tunnel_list.length; j++){
									var tmp = vpn_tunnel_list[j].split(",");
									var t_ip = tmp[0].split("-");
									var cmp_ip = ipsec_data[0].split("/");
									if(t_ip[t_ip.length-1] == cmp_ip[0]){
										ipsec_init_timer = tmp[1];
										ipsec_dur_timer = tmp[2];
										break;
									}
}
									document.write("<tr>");
									document.write("<td height=2>" + _ipsec + "</td>");
									document.write("<td height=2>"+ ipsec_data[1] +"</td>");
									document.write("<td height=2>"+ ipsec_data[0] +"</td>");
									document.write("<td height=2>"+ ipsec_data[4] +"</td>");
									document.write("<td height=2>" + ipsec_data[5] + ipsec_data[6] + "</td>");
									document.write("<td height=2>" + ipsec_data[7] + "</td>");
									document.write("<td height=2>"+ ipsec_dur_timer +"</td>");
									document.write("</tr>");
								}
/* pptp/l2tp */							

								var vpn_pppd_sta = "<!--# exec cgi /bin/cli utility pppd -->";
								var tmp_pppd_list = vpn_pppd_sta.split("#");
								for(var i = 0; i <tmp_pppd_list.length-1 ; i++){
									var pppd_data = tmp_pppd_list[i].split(",");
									var pppd_init_timer = "";
									var pppd_dur_timer = "";
									for(var j = 0; j < vpn_tunnel_list.length; j++){
										var tmp = vpn_tunnel_list[j].split(",");
										var t_ip = tmp[0].split("-");
										var cmp_ip = pppd_data[2].split("/");
										if(t_ip[t_ip.length-1] == cmp_ip[0]){
											pppd_init_timer = tmp[1];
											pppd_dur_timer = tmp[2];
											break;
										}
									}

									document.write("<tr>");
									document.write("<td height=2>"+pppd_data[0]+"</td>");
									document.write("<td height=2>"+pppd_data[1]+"</td>");
									document.write("<td height=2>"+pppd_data[2]+"</td>");
									document.write("<td height=2>" + support_vpn_tunnel + "</td>");
									document.write("<td height=2>" + _none + "</td>");
									document.write("<td height=2>" + _none + "</td>");
									//document.write("<td height=2><font size=2>" + pppd_init_timer + "</font></td>");
									document.write("<td height=2>"+ pppd_dur_timer + "</td>");
									document.write("</tr>");
								}
/* openvpn */
/*
 * @openvpn format : sslvpn,192.168.0.0/24,172.21.33.83,00:02:07#
 */
								var vpn_op_sta = "<!--# exec cgi /bin/cli utility openvpn -->";
								var tmp_op_list = vpn_op_sta.split("#");
								for(var i = 0; i <tmp_op_list.length-1 ; i++){
									var op_data = tmp_op_list[i].split(",");
									var op_init_timer = "";
									var op_dur_timer = "";
									for(var j = 0; j < vpn_tunnel_list.length; j++){
										var tmp = vpn_tunnel_list[j].split(",");
										var t_ip = tmp[0].split("-");
										var cmp_ip = op_data[2].split("/");
										op_dur_timer = op_data[3];
									}
									document.write("<tr>");
									document.write("<td height=2>"+op_data[0]+"</td>");
									document.write("<td height=2>"+op_data[1]+"</td>");
									document.write("<td height=2>"+op_data[2]+"</td>");
									document.write("<td height=2>" + support_vpn_tunnel + "</td>");
									document.write("<td height=2>" + _none + "</td>");
									document.write("<td height=2>" + _none + "</td>");
									document.write("<td height=2>"+ op_dur_timer +"</td>");
									document.write("</tr>");
								}
								</script>
							</tbody>
						</table>
					</div>
					<!-- === END MAINCONTENT === -->
                </div>

		</td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                    <tr>
                      <td id="help_text">
                        <strong><script>show_words(_hints)</script>&hellip;</strong>
                        <p><script>show_words(st_vpn_table_help_info);</script></p>
                        <p><a href="support_status.asp#VPN"><script>show_words(_more);</script>&hellip;</a></p>
                      </td>
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
    </table></form>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>
