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
<script>
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var cli_list = {
		'mac': 		'',
		'ip': 		'',
		'mode':		'',
		'rate':		'',
		'rssi':		''
	};

	var cli_list_gz = {
		'mac': 		'',
		'ip': 		'',
		'mode':		'',
		'rate':		'',
		'rssi':		''
	};

	var cli_list_5 = {	//silvia add 5g
		'mac': 		'',
		'ip': 		'',
		'mode':		'',
		'rate':		'',
		'rssi':		''
	};

	var cli_list_gz_5 = {
		'mac': 		'',
		'ip': 		'',
		'mode':		'',
		'rate':		'',
		'rssi':		''
	};

	function paintList() {
		if (cli_list.mac == '' && cli_list_gz.mac == '')
			return ;

		var tb = $('#station_table > tbody:last');
		var content = '';

		for (var i=0; i<cli_list.mac.length; i++) {
			content += '<tr>';

			if (cli_list.mac[i] != null && cli_list.mac[i] != '')	// mac
				content += '<td>'+cli_list.mac[i]+'</td>';
			else
				content += '<td>&nbsp;</td>';

			if (cli_list.ip[i] != null && cli_list.ip[i] != '')	// ip
				content += '<td>'+cli_list.ip[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list.mode[i] != null && cli_list.mode[i] != '')	// mode
				content += '<td>'+cli_list.mode[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list.rate[i] != null && cli_list.rate[i] != '')	// rate
				content += '<td>'+cli_list.rate[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list.rssi[i] != null && cli_list.rssi[i] != '')	// rssi
				content += '<td>'+cli_list.rssi[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			content += '</tr>';
		}
		
		//guest zone client
		for (var i=0; i<cli_list_gz.mac.length; i++) {
			content += '<tr>';

			if (cli_list_gz.mac[i] != null && cli_list_gz.mac[i] != '')	// mac
				content += '<td>'+cli_list_gz.mac[i]+'</td>';
			else
				content += '<td>&nbsp;</td>';

			if (cli_list_gz.ip[i] != null && cli_list_gz.ip[i] != '')	// ip
				content += '<td>'+cli_list_gz.ip[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_gz.mode[i] != null && cli_list_gz.mode[i] != '')	// mode
				content += '<td>'+cli_list_gz.mode[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_gz.rate[i] != null && cli_list_gz.rate[i] != '')	// rate
				content += '<td>'+cli_list_gz.rate[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';
			
			if (cli_list_gz.rssi[i] != null && cli_list_gz.rssi[i] != '')	// rssi
				content += '<td>'+cli_list_gz.rssi[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			content += '</tr>';
		}
		tb.append(content);
	}

	function paintList_5() {	//silvia add 5g
		if (cli_list_5.mac == '' && cli_list_gz_5.mac == '')
			return ;

		var tb = $('#station_table_1 > tbody:last');
		var content = '';

		for (var i=0; i<cli_list_5.mac.length; i++) {
			content += '<tr>';

			if (cli_list_5.mac[i] != null && cli_list_5.mac[i] != '')	// mac
				content += '<td>'+cli_list_5.mac[i]+'</td>';
			else
				content += '<td>&nbsp;</td>';

			if (cli_list_5.ip[i] != null && cli_list_5.ip[i] != '')	// ip
				content += '<td>'+cli_list_5.ip[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_5.mode[i] != null && cli_list_5.mode[i] != '')	// mode
				content += '<td>'+cli_list_5.mode[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_5.rate[i] != null && cli_list_5.rate[i] != '')	// rate
				content += '<td>'+cli_list_5.rate[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_5.rssi[i] != null && cli_list_5.rssi[i] != '')	// rssi
				content += '<td>'+cli_list_5.rssi[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			content += '</tr>';
		}
		
		//guest zone client
		for (var i=0; i<cli_list_gz_5.mac.length; i++) {
			content += '<tr>';

			if (cli_list_gz_5.mac[i] != null && cli_list_gz_5.mac[i] != '')	// mac
				content += '<td>'+cli_list_gz_5.mac[i]+'</td>';
			else
				content += '<td>&nbsp;</td>';

			if (cli_list_gz_5.ip[i] != null && cli_list_gz_5.ip[i] != '')	// ip
				content += '<td>'+cli_list_gz_5.ip[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_gz_5.mode[i] != null && cli_list_gz_5.mode[i] != '')	// mode
				content += '<td>'+cli_list_gz_5.mode[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			if (cli_list_gz_5.rate[i] != null && cli_list_gz_5.rate[i] != '')	// rate
				content += '<td>'+cli_list_gz_5.rate[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';
			
			if (cli_list_gz_5.rssi[i] != null && cli_list_gz_5.rssi[i] != '')	// rssi
				content += '<td>'+cli_list_gz_5.rssi[i]+'</td>';
			else
				content += '<td>'+ get_words('UNKNOWN') +'</td>';

			content += '</tr>';
		}
		tb.append(content);
	}

	function loadWifiClientList() {
		var param = {
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=4'+
				'&oid_1=IGD_Status_WLANStatus_i_Client_i_&inst_1=11110' +
				'&oid_2=IGD_Status_WLANStatus_i_Client_i_&inst_2=11120' +
				'&oid_3=IGD_Status_WLANStatus_i_Client_i_&inst_3=11130' +
				'&oid_4=IGD_Status_WLANStatus_i_Client_i_&inst_4=11140'
		};
		get_config_obj(param);

		var tmp_mac  	= config_str_multi('igdWlanHostStatus_MACAddress_');
		var tmp_ip   	= config_str_multi('igdWlanHostStatus_IPAddress_');
		var tmp_mode 	= config_str_multi('igdWlanHostStatus_Mode_');
		var tmp_rate 	= config_str_multi('igdWlanHostStatus_Rate_');
		var tmp_rssi 	= config_str_multi('igdWlanHostStatus_Signal_');

		if(tmp_mac[0])
		{
			cli_list.mac 	= tmp_mac[0].split("/");
			cli_list.ip  	= tmp_ip[0].split("/");
			cli_list.mode 	= tmp_mode[0].split("/");
			cli_list.rate 	= tmp_rate[0].split("/");
			cli_list.rssi 	= tmp_rssi[0].split("/");
		}

		if(tmp_mac[1])
		{
			cli_list_gz.mac 	= tmp_mac[1].split("/");
			cli_list_gz.ip  	= tmp_ip[1].split("/");
			cli_list_gz.mode 	= tmp_mode[1].split("/");
			cli_list_gz.rate 	= tmp_rate[1].split("/");
			cli_list_gz.rssi 	= tmp_rssi[1].split("/");
		}

		if(tmp_mac[2])
		{
			cli_list_5.mac 	= tmp_mac[2].split("/");
			cli_list_5.ip  	= tmp_ip[2].split("/");
			cli_list_5.mode 	= tmp_mode[2].split("/");
			cli_list_5.rate 	= tmp_rate[2].split("/");
			cli_list_5.rssi 	= tmp_rssi[2].split("/");
		}

		if(tmp_mac[3])
		{
			cli_list_gz_5.mac 	= tmp_mac[3].split("/");
			cli_list_gz_5.ip  	= tmp_ip[3].split("/");
			cli_list_gz_5.mode 	= tmp_mode[3].split("/");
			cli_list_gz_5.rate 	= tmp_rate[3].split("/");
			cli_list_gz_5.rssi 	= tmp_rssi[3].split("/");
		}

		paintList();
		paintList_5();

		//20120110 silvia add, calculate the number of connected devices
		var wir=(cli_list.mac)?cli_list.mac.length:0;
		var gz=(cli_list_gz.mac)?cli_list_gz.mac.length:0;
		var wir_5=(cli_list_5.mac)?cli_list_5.mac.length:0;
		var gz_5=(cli_list_gz_5.mac)?cli_list_gz_5.mac.length:0;
		$('#show_resert').html(wir+gz);
		$('#show_resert_1').html(wir_5+gz_5);
	}
	$(document).ready( function () {
		loadWifiClientList();
	});

</script>
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
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
		<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
		<td id="topnavon"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td id="sidenav_container">
				<div id="sidenav">
				<!-- === BEGIN SIDENAV === -->
					<ul>
						<li><div><a href="st_device.asp"><script>show_words(_devinfo)</script></a></div></li>
						<li><div><a href="st_log.asp"><script>show_words(_logs)</script></a></div></li>
						<li><div><a href="st_stats.asp"><script>show_words(_stats)</script></a></div></li>
						<li><div><a href="internet_sessions.asp"><script>show_words(YM157)</script></a></div></li>
						<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
						<li><div id="sidenavoff"><script>show_words(_wireless)</script></div></li>
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
		<form id="form1" name="form1" method="post">
		<div id="maincontent">
			<!-- === BEGIN MAINCONTENT === -->
			<div id="box_header"> 
				<h1><script>show_words(_wireless)</script></h1>
				<p><script>show_words(sw_intro)</script></p>
			</div>
			<div class="box"> 
				<h2><script>show_words(sw_title_list)</script>  - <script>show_words(GW_WLAN_RADIO_0_NAME)</script>:&nbsp;
					<span id="show_resert"></span></h2>
				<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1  id="station_table">
				<tbody>
				<tr id="box_header">
					<TD><b><script>show_words(sd_macaddr)</script></b></TD>
					<TD><b><script>show_words(_ipaddr)</script></b></TD>
					<TD><b><script>show_words(_mode)</script></b></TD>
					<TD><b><script>show_words(_rate)</script></b></TD>
					<TD><b><script>show_words(_rssi)</script></b></TD>
				</tr>
				</tbody>
				</table>
			</div>
			<div class="box"> 
				<h2><script>show_words(sw_title_list)</script> - <script>show_words(GW_WLAN_RADIO_1_NAME)</script>:&nbsp;
					<span id="show_resert_1"></span></h2>
				<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1 id="station_table_1">
				<tr id="box_header">
					<TD><b><script>show_words(sd_macaddr)</script></b></TD>
					<TD><b><script>show_words(_ipaddr)</script></b></TD>
					<TD><b><script>show_words(_mode)</script></b></TD>
					<TD><b><script>show_words(_rate)</script></b></TD>
					<TD><b><script>show_words(_rssi)</script></b></TD>
				</tr>
				</table>
			</div>
		</div>
		</form>
		</td>
		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
			<tr>
			  <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
				<p><script>show_words(hhsw_intro)</script></p>
				<p class="more"><a href="support_status.asp#Wireless"><script>show_words(_more)</script>&hellip;</a></p>
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
