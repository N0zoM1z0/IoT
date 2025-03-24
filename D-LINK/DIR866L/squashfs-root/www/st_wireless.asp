<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="/jquery-1.6.1.min.js"></script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
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
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
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
							<script>show_left("Status", 5);</script>
							</ul>
							<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
                <td>
                
                </td>
				</table>			
			</td>

			<td valign="top" id="maincontent_container">
				<div id="maincontent">
				
					<div id="box_header"> 
						<h1><script>show_words(_wireless)</script></h1>
						<p><script>show_words(sw_intro)</script></p>
					</div>
					<div class="box"> 
						<h2><script>show_words(sw_title_list)</script> - <script>show_words(GW_WLAN_RADIO_0_NAME)</script>:&nbsp;<span id="w2g_cnt"></span></h2>
						<div id="WLAN_2G"></div>
					</div>
					<div class="box"> 
						<h2><script>show_words(sw_title_list)</script> - <script>show_words(GW_WLAN_RADIO_1_NAME)</script>:&nbsp;<span id="w5g_cnt"></span></h2>
					        <div id="WLAN_5G"></div>
					</div>
                </div></td></form>
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
<div id="copyright"><script type="text/javascript">show_words(_copyright);</script></div>
<br>
<script type="text/javascript">

function show_wlan_clients(clients, wifi_cnt_id)
{
	var table = "";
	var cnt = 0;
	if (clients.length == 0)
                return table;
        var data = clients.split(",");
	for (var i = 0; i < data.length-1; i++) {
                var drow = data[i].split("/");
                var mac = drow[0];
                var mode = drow[1];
                var time = drow[2];
                var rate = drow[3];
                var signal = drow[4];
		var addr = drow[5];
		if (addr.length == 0)
			continue;
		table += "<tr bgcolor=\"#FFFFFF\">";
		table += "<td><font face=\"Arial\" size=\"2\">"+ mac +"</font></td>";
		table += "<td><font face=\"Arial\" size=\"2\">"+ addr +"</font></td>";
		table += "<td><font face=\"Arial\" size=\"2\">"+ mode +"</font></td>";
		table += "<td><font face=\"Arial\" size=\"2\">"+ rate +"</font></td>";
		table += "<td><font face=\"Arial\" size=\"2\">"+ signal +"</font></td>";
		table +="</tr>";
		cnt++;
        }
	if (cnt != 0) {
		$(wifi_cnt_id).empty();
		$(wifi_cnt_id).append(cnt);
	}else
		$(wifi_cnt_id).empty();

	return table;
}

function show_clients(clients, wifi, wifi_cnt)
{
	$(wifi).empty();

       	var table = "";
	if (clients) {
		table += "<table cellpadding=\"1\" cellspacing=\"1\" border=\"1\" width=\"525\">";
		table += "<thead><tr id=\"box_header\">";
		table += "<td><b>"+ sd_macaddr+"</b></td>";
		table += "<td><b>"+_ipaddr+"</b></td>";
		table += "<td><b>"+_mode+"</b></td>";
		table += "<td><b>"+_rate+"</b></td>";
		table += "<td><b>"+_rssi+"</b></td>";
		table += "</tr>";
		table += show_wlan_clients(clients, wifi_cnt);
		table += "</table>";
	}
	$(wifi).append(table);
}

function getJson()
{
        $.ajax({
                type: "GET",
                url: "wlan_client_list.js",
                async: true,
                cache: false,
                dataType: "json",
                complete : function(data){
                        try{
				var obj = eval("(" + data.responseText + ")");
				var client2 = "Client2G";
				show_clients(obj[client2], "#WLAN_2G", "#w2g_cnt");
				var client5 = "Client5G";
				show_clients(obj[client5], "#WLAN_5G", "#w5g_cnt");
		        }catch(e){
			}
                }
        });
}
	//when the menu draws this is what gets called
//	fxMenuReady(function()
//	{
getJson();
//	});
</script>
</body>
</html>
