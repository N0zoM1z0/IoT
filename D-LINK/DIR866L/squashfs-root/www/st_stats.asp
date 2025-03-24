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
			var LAN = 0, WAN = 1, WLAN = 2, WLAN1 = 3;
			
			function onPageLoad(){
				var login_who= checksessionStorage();
				if(login_who== "user"){
					get_by_id("reset").disabled = true;
				}
				
				if ("<!--# echo wlan1_enable -->" === "") {
					get_by_id("wlan1").style.display = "none";
				}
			
				//show info
				show_stats(LAN, get_by_id("lan_stats").value);
				show_stats(WAN, get_by_id("wan_stats").value);
				show_stats(WLAN, get_by_id("wlan_stats").value);
				show_stats(WLAN1, get_by_id("wlan1_stats").value);
			}
			
			
			function reset_packets(){
				send_submit("form2");
			}
			
			function show_statitics(type, sent, received, tx, rx, collision, error){
				var out_put_str = "";
				var stats_string1 = "", wlan_string = "";
				//	var stats_string2 = "";
				
				stats_string1 = "<tr>";
				stats_string1 += "<td class=duple>" + ss_Sent + " :</td>";
				stats_string1 += "<td width=340>&nbsp;" + sent + "</td>";
				stats_string1 += "<td class=duple>" + ss_Received + " :</td>";
				stats_string1 += "<td width=340>&nbsp;" + received + "</td>";
				stats_string1 += "</tr>";
				stats_string1 += "<tr>";
				stats_string1 += "<td class=duple>" + ss_TXPD + " :</td>";
				stats_string1 += "<td width=340>&nbsp;" + tx + "</td>";
				stats_string1 += "<td class=duple>" + ss_RXPD + " :</td>"
				stats_string1 += "<td width=340>&nbsp;" + rx + "</td>"
				stats_string1 += "</tr>";
				
				//	stats_string2 = "<tr>";
				//	stats_string2 += "<td class=duple>" + ss_Collisions + " :</td>";
				//	stats_string2 += "<td width=340>&nbsp;" + collision + "</td>";
				//	stats_string2 += "<td class=duple>" + ss_Errors + " :</td>";
				//	stats_string2 += "<td width=340>&nbsp;" + error + "</td>";
				//	stats_string2 += "</tr>";
				
				wlan_string = "<tr>";
				wlan_string += "<td class=duple>&nbsp;</td>";
				wlan_string += "<td width=340>&nbsp;</td>";
				wlan_string += "<td class=duple>" + ss_Errors + " :</td>";
				wlan_string += "<td width=340>&nbsp;" + error + "</td>";
				wlan_string += "</tr>";
				
				out_put_str = "<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>"
				out_put_str += stats_string1 + wlan_string;
				out_put_str += "</table>";
				
				//alert(out_put_str);
				
				switch(type) {
					case LAN:
						get_by_id("span_lan_stats").innerHTML = out_put_str
						break;
					case WAN:
						get_by_id("span_wan_stats").innerHTML = out_put_str
						break;
					case WLAN:
						get_by_id("span_wlan_stats").innerHTML = out_put_str
						break;
					case WLAN1:
						get_by_id("span_wlan1_stats").innerHTML = out_put_str
						break;
				}
			}
			
			function show_stats(type, statics){
				var stats;
				
				if (statics === ""){
					show_statitics(type, 0, 0, 0, 0, 0, 0);
				}else{
					stats = statics.split("/");
				
					switch(type) {
						case LAN:
						case WAN:
							show_statitics(type, stats[1], stats[0], stats[3], stats[2], stats[4], stats[5]);
							break;
						case WLAN:
						case WLAN1:
							show_statitics(type, stats[1], stats[0], stats[3], stats[2], 0, stats[5]);
						break;
					}
				}
			}
			
		</script>
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
					<script>show_left("Status", 2);</script>
					</ul>
					<!-- === END SIDENAV === -->
					</div>
					</td>			
					</tr>
					</table>			
				</td>
				<td valign="top" id="maincontent_container">
					<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
						<input type="hidden" id="html_response_message" name="html_response_message" value="">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
						<input type="hidden" id="lan_stats" name="lan_stats" value="<!--# exec cgi /bin/statistics lan -->">
						<input type="hidden" id="wan_stats" name="wan_stats" value="<!--# exec cgi /bin/statistics wan -->">
						<input type="hidden" id="wlan_stats" name="wlan_stats" value="<!--# exec cgi /bin/statistics wlan -->">
						<input type="hidden" id="wlan1_stats" name="wlan1_stats" value="<!--# exec cgi /bin/statistics wlan1 -->">
						
						<div id="maincontent">
						<!-- === BEGIN MAINCONTENT === -->
							<div id="box_header"> 
								<h1><script>show_words(_tstats);</script></h1>
								<script>show_words(ss_intro);</script>
								<br><br>
								<input name=refresh type=button id="refresh" onClick="window.location.href='st_stats.asp'" value="">
								<script>get_by_id("refresh").value=ss_reload;</script>
								<input name=reset type=button id="reset" value="" onClick="reset_packets()">
								<script>get_by_id("reset").value=ss_clear_stats;</script>
							</div>
							<div class="box"> 
								<h2><script>show_words(ss_LANStats);</script></h2>
								<span id="span_lan_stats"></span>
							</div>
							<div class="box"> 
								<h2><script>show_words(ss_WANStats);</script></h2>
								<span id="span_wan_stats"></span>
							</div>
							<div class="box" id="wlan0"> 
								<h2><script>show_words(ss_WStats_0);</script></h2>
								<span id="span_wlan_stats"></span>
							</div>
							<div class="box" id="wlan1"> 
								<h2><script>show_words(ss_WStats_1);</script></h2>
								<span id="span_wlan1_stats"></span>
							</div>
						
						<!-- === END MAINCONTENT === -->
						</div>
					</form>
				</td>
				<form id="form2" name="form2" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="st_stats.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
					<input type="hidden" id="action" name="action" value="reset_ifconfig_packet_counter">
				
				</form>
				<td valign="top" width="150" id="sidehelp_container" align="left">
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					<td id="help_text">
					<strong><script>show_words(_hints);</script>&hellip;</strong>
					<p><script>show_words(hhss_intro);</script></p>
					<p class="more"><a href="support_status.asp#Statistics"><script>show_words(_more);</script>&hellip;</a></p>
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
		onPageLoad();
	</script>
</html>
