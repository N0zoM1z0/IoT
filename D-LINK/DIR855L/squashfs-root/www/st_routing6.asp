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
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript"> 
	var DataArray = new Array();
	var rule_max_num = 10;
	
	//  1/name/ip/netmask/gateway/WAN/metric
	function Data(enable, name, ip_addr, net_mask, gateway, show_inter , metric) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = show_inter;
		this.Metric = metric;
	}

	function DataShow(){
		if("<!--# echo ipv6_wan_proto -->" === "link_local")
			return;
		set_routes();
		metric_sort();
		for (var i=0; i<DataArray.length;i++){
			var iface = "";
			if (DataArray[i].Interface === "<!--# echo wan_eth -->" || 
			   DataArray[i].Interface === "sit2" ||
			   DataArray[i].Interface === "sit1" ||
			   DataArray[i].Interface === "tun6to4" ||
			   DataArray[i].Interface === "ppp0" ||
			   (DataArray[i].Interface === "ppp6" && "<!--# echo ipv6_wan_proto -->" === "ipv6_pppoe" &&
				 "<!--# echo ipv6_pppoe_share -->" === "0")
			){
				iface = _WAN;
			} else if(DataArray[i].Interface === "<!--# echo lan_bridge -->" ||
				DataArray[i].Interface === "<!--# echo gzone_bridge -->") {
				iface = _LAN;
			} else if(DataArray[i].Interface === "NULL"){
				iface = _locakloopback;
			} else if(DataArray[i].Interface === "DHCPPD"){
				continue;
			} else {
				iface = DataArray[i].Interface;
			}
			document.write("<tr bgcolor=\"#F0F0F0\">");
			document.write("<td>"+ DataArray[i].Ip_addr +"/"+ DataArray[i].Net_mask +"</td>");
			document.write("<td>"+ DataArray[i].Gateway +"</td>");
			document.write("<td>"+ DataArray[i].Metric +"</td>");
			document.write("<td>"+ iface +"</td>");
			document.write("</tr>\n");
		}
	}
	
	function metric_sort(){
		// sorting ascending first
		var i=0,j=0;
		DataArray_tmp = new Data(0, 0, 0, 0, 0, 0, 0);
		for (i=0; i<DataArray.length*2;i++){
			for(j=0; j < DataArray.length-1 ; j++){
				if(parseInt(DataArray[j].Metric) > parseInt(DataArray[j+1].Metric)){
					DataArray_tmp.Ip_addr = DataArray[j].Ip_addr;
					DataArray_tmp.Net_mask = DataArray[j].Net_mask;
					DataArray_tmp.Gateway = DataArray[j].Gateway;
					DataArray_tmp.Metric = DataArray[j].Metric;
					DataArray_tmp.Interface = DataArray[j].Interface;
					
					DataArray[j].Ip_addr = DataArray[j+1].Ip_addr;
					DataArray[j].Net_mask = DataArray[j+1].Net_mask;
					DataArray[j].Gateway = DataArray[j+1].Gateway;
					DataArray[j].Metric = DataArray[j+1].Metric;
					DataArray[j].Interface = DataArray[j+1].Interface;
					
					DataArray[j+1].Ip_addr = DataArray_tmp.Ip_addr;
					DataArray[j+1].Net_mask = DataArray_tmp.Net_mask;
					DataArray[j+1].Gateway = DataArray_tmp.Gateway;
					DataArray[j+1].Metric = DataArray_tmp.Metric;
					DataArray[j+1].Interface = DataArray_tmp.Interface;
				}
			}
		}
	}
	
	function set_routes(){
/*		XXX Joe.H : Only display the routing which is in the real routing table.
		//enable/name/dest_addr/prefix/gateway/interface/metric
		for (var i=0;i<rule_max_num;i++){
			var temp_st;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("static_routing_ipv6_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[1] != "" && temp_st[0] != "0"){ //only show enabled static routing rules
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3], temp_st[4], temp_st[5], temp_st[6]);
				}
			}
		}
*/
		//dest/pf_len/gw/metric/iface	
		var myData = get_by_id("routing_table").value.split(",");
		var temp_data;
		for (var i=0 ; i<myData.length;i++){
			temp_data = myData[i].split("/");
			if(temp_data.length > 1){				
				var is_not_check= true;
				for(var j=0;j<DataArray.length;j++){
					if(temp_data[0] == DataArray[j].Ip_addr && temp_data[1] == DataArray[j].Net_mask && temp_data[2] == DataArray[j].Gateway){
						is_not_check = false;
						break;
					}
				}
				if(is_not_check){
					DataArray[DataArray.length++] = new Data(0, i , temp_data[0], temp_data[1], temp_data[2], temp_data[4], temp_data[3]);
				}
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
									<script>show_left("Status", 8);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
                <td>
                 <!-- repeat name="extTab" -->
                </td>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action=apply.cgi>
				<input type="hidden" id="html_response_page" name="html_response_page" value="st_wireless.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_wireles.asp">
				<input type="hidden" id="static_routing_ipv6_00" name="static_routing_ipv6_00" value="<!--# echo static_routing_ipv6_00 -->">
				<input type="hidden" id="static_routing_ipv6_01" name="static_routing_ipv6_01" value="<!--# echo static_routing_ipv6_01 -->">
				<input type="hidden" id="static_routing_ipv6_02" name="static_routing_ipv6_02" value="<!--# echo static_routing_ipv6_02 -->">
				<input type="hidden" id="static_routing_ipv6_03" name="static_routing_ipv6_03" value="<!--# echo static_routing_ipv6_03 -->">
				<input type="hidden" id="static_routing_ipv6_04" name="static_routing_ipv6_04" value="<!--# echo static_routing_ipv6_04 -->">
				<input type="hidden" id="static_routing_ipv6_05" name="static_routing_ipv6_05" value="<!--# echo static_routing_ipv6_05 -->">
				<input type="hidden" id="static_routing_ipv6_06" name="static_routing_ipv6_06" value="<!--# echo static_routing_ipv6_06 -->">
				<input type="hidden" id="static_routing_ipv6_07" name="static_routing_ipv6-07" value="<!--# echo static_routing_ipv6_07 -->">
				<input type="hidden" id="static_routing_ipv6_08" name="static_routing_ipv6_08" value="<!--# echo static_routing_ipv6_08 -->">
				<input type="hidden" id="static_routing_ipv6_09" name="static_routing_ipv6_09" value="<!--# echo static_routing_ipv6_09 -->">
				<input type="hidden" id="routing_table" name="routing_table" value="<!--# exec cgi /bin/ipv6 routing_table -->">
				
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(IPV6_routing);</script></h1>
						<b><p><script>show_words(IPV6_ROUTING_TABLE);</script></p></b>
						<p><script>show_words(IPV6_ROUTING_TABLE_INFO);</script></p>
					</div>
					<div class="box"> 
						<h2 style=" text-transform:none"><script>show_words(IPV6_ROUTING_TABLE);</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                              <tr>
							    <TD><b><script>show_words(KR114);</script></b></TD>
							    <TD><b><script>show_words(_gateway);</script></b></TD>
							    <TD><b><script>show_words(_metric);</script></b></TD>
							    <TD><b><script>show_words(_interface);</script></b></TD>
                              </tr>
                              <script>
                              	DataShow(); 
							  </script>
                            </table>
					</div>
                </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                      	<p></p>
                      	<p class="more"><a href="support_status.asp#routing6"><script>show_words(_more);</script>&hellip;</a></p>
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
</html>
