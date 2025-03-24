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
	
	//query traffic statistics
	var param = {
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=6'+
				'&oid_1=IGD_Statistic_LANStatistic_&inst_1=11000'+
				'&oid_2=IGD_Statistic_WANStatistic_&inst_2=11000'+
				'&oid_3=IGD_Statistic_WLANStatistic_i_&inst_3=11100'+
				'&oid_4=IGD_Statistic_WLANStatistic_i_&inst_4=11200'+
				'&oid_5=IGD_Statistic_WLANStatistic_i_&inst_5=11300'+
				'&oid_6=IGD_Statistic_WLANStatistic_i_&inst_6=11400'
	};
	get_config_obj(param);
	
	//IGD_Statistic_LANStatistic_
	var stLan = {
		'sent':			config_val('igdLanStatistic_PacketsSent_'),
		'received':		config_val('igdLanStatistic_PacketsReceived_'),
		'tx':			config_val('igdLanStatistic_PacketsDropTx_'),
		'rx':			config_val('igdLanStatistic_PacketsDropRx_'),
		'collision':	config_val('igdLanStatistic_Collisions_'),
		'error':		config_val('igdLanStatistic_Errors_')
	};
	
	var stWan = {
		'sent':			config_val('igdWanStatistic_PacketsSent_'),
		'received':		config_val('igdWanStatistic_PacketsReceived_'),
		'tx':			config_val('igdWanStatistic_PacketsDropTx_'),
		'rx':			config_val('igdWanStatistic_PacketsDropRx_'),
		'collision':	config_val('igdWanStatistic_Collisions_'),
		'error':		config_val('igdWanStatistic_Errors_')
	};

	var stWlan = {
		'sent':			config_str_multi('igdWlanStatistic_PacketsSent_'),
		'received':		config_str_multi('igdWlanStatistic_PacketsReceived_'),
		'tx':			config_str_multi('igdWlanStatistic_PacketsDropTx_'),
		'rx':			config_str_multi('igdWlanStatistic_PacketsDropRx_'),
		'collision':	config_str_multi('igdWlanStatistic_Collisions_'),
		'error':		config_str_multi('igdWlanStatistic_Errors_')
	};

	function reset_packets()
	{
		var param = {
			'url': 	'statistic.ccp',
			'arg': 	'ccp_act=reset'
		};
		get_config_obj(param);
	}

	var stats_string1, wlan_string;
	function show_stats(status)
	{
		var sent, received, tx, rx, collision, error;
		var lan_stats = (get_by_id("lan_stats").value).split("/");
		var wan_stats = (get_by_id("wan_stats").value).split("/");
		var wlan_stats = (get_by_id("wlan_stats").value).split("/");

		if(status == "lan"){
			sent = stLan.sent;
			received = stLan.received;
			tx = stLan.tx;
			rx = stLan.rx;
			collision = stLan.collision;
			error = stLan.error;
		}else if(status == "wan"){
			sent = stWan.sent;
			received = stWan.received;
			tx = stWan.tx;
			rx = stWan.rx;
			collision = stWan.collision;
			error = stWan.error;
		}else if(status == "wlan1"){
			sent = parseInt(stWlan.sent[0])+parseInt(stWlan.sent[1]);
			received = parseInt(stWlan.received[0])+parseInt(stWlan.received[1]);
			tx = parseInt(stWlan.tx[0])+parseInt(stWlan.tx[1]);
			rx = parseInt(stWlan.rx[0])+parseInt(stWlan.rx[1]);
			error = parseInt(stWlan.error[0])+parseInt(stWlan.error[1]);
		}else if(status == "wlan2"){
			sent = parseInt(stWlan.sent[2])+parseInt(stWlan.sent[3]);
			received = parseInt(stWlan.received[2])+parseInt(stWlan.received[3]);
			tx = parseInt(stWlan.tx[2])+parseInt(stWlan.tx[3]);
			rx = parseInt(stWlan.rx[2])+parseInt(stWlan.rx[3]);
			error = parseInt(stWlan.error[2])+parseInt(stWlan.error[3]);
		}

		////////////////////////////////////
		stats_string1 = "<tr>";
		stats_string1 += '<td class=duple>'+get_words('ss_Sent')+' :</td>';
		stats_string1 += "<td width=340>&nbsp;" + sent + "</td>";
		stats_string1 += '<td class=duple>'+get_words('ss_Received')+' :</td>';
		stats_string1 += "<td width=340>&nbsp;" + received + "</td>";
		stats_string1 += "</tr>";
		stats_string1 += "<tr>";
		stats_string1 += '<td class=duple>'+get_words('ss_TXPD')+' :</td>';
		stats_string1 += "<td width=340>&nbsp;" + tx + "</td>";
		stats_string1 += '<td class=duple>'+get_words('ss_RXPD')+' :</td>';
		stats_string1 += "<td width=340>&nbsp;" + rx + "</td>"
		stats_string1 += "</tr>";
		
		stats_string2 = "<tr>";
		stats_string2 += '<td class=duple>'+get_words('ss_Collisions')+' :</td>';
		stats_string2 += "<td width=340>&nbsp;" + collision + "</td>";
		stats_string2 += '<td class=duple>'+get_words('ss_Errors')+' :</td>';
		stats_string2 += "<td width=340>&nbsp;" + error + "</td>";
		stats_string2 += "</tr>";

		wlan_string = "<tr>";
		wlan_string += "<td class=duple>&nbsp;</td>";
		wlan_string += "<td width=340>&nbsp;</td>";
		wlan_string += '<td class=duple>'+get_words('ss_Errors')+' :</td>';
		wlan_string += "<td width=340>&nbsp;" + error + "</td>";
		wlan_string += "</tr>";
	}
	
	$(document).ready( function () {
		if(dev_info.login_info != "w"){
			$('#refresh').attr('disabled',true);
			$('#reset').attr('disabled',true);
		}
	});

</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp"><script>show_words(_devinfo)</script></a></div></li>
									<li><div><a href="st_log.asp"><script>show_words(_logs)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_stats)</script></div></li>
									<li><div><a href="internet_sessions.asp"><script>show_words(YM157)</script></a></div></li>
									<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
									<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
									<li><div><a href="st_routing6.asp"><script>show_words(v6_routing)</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
			<form id="form1" name="form1" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = get_words('sc_intro_sv');</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
			<input type="hidden" id="lan_stats" name="lan_stats" value="">
			<input type="hidden" id="wan_stats" name="wan_stats" value="">
			<input type="hidden" id="wlan_stats" name="wlan_stats" value="">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(_tstats)</script></h1>
						<script>show_words(ss_intro)</script>
						<br><br>
						<input name="refresh" type="button" id="refresh" value="" onClick=window.location.href="st_stats.asp">
						<input name="reset" type="button" id="reset" value="" onclick="reset_packets()">
						<script>get_by_id("refresh").value = get_words('ss_reload');</script>
						<script>get_by_id("reset").value = get_words('ss_clear_stats');</script>
				  	</div>
					<div class="box"> 
						<h2><script>show_words(ss_LANStats)</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("lan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2><script>show_words(ss_WANStats)</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2><script>show_words(ss_Wstats_2)</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wlan1");
								document.write(stats_string1 + wlan_string);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2><script>show_words(ss_Wstats_5g)</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wlan2");
								document.write(stats_string1 + wlan_string);
								</script>
							</table>
					</div>
					<!-- === END MAINCONTENT === -->
                </div>
			</form>
			</td>
			<form id="form2" name="form2" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="st_stats.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
						<strong><script>show_words(_hints)</script>&hellip;</strong>
						<p><script>show_words(hhss_intro)</script></p>
						<p><a href="support_status.asp#Statistics"><script>show_words(_more)</script>&hellip;</a></p>
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
</html>
