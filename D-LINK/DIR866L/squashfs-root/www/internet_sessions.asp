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
									<script>show_left("Status", 3);</script>
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
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(YM157);</script></h1>
						<p><script>show_words(sa_intro);</script></p>
					</div>
					<div class="box"> 
					<h2><script>show_words(YM157);</script></h2>
					<div id="session_table"></div>
					</div>
				</div>
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                      	<p><script>show_words(hhsa_intro);</script></p>
                      	<p class="more"><a href="support_status.asp#Internet_Sessions"><script>show_words(_more);</script>&hellip;</a></p>
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
<script type="text/javascript" src="/jquery-1.6.1.min.js"></script>
<script>
function getJson()
{
	$.ajax({
		type: "GET",
		url: "internet_session.js",
		async: true,
		cache: false,
		dataType: "json",
		complete : function(data){
			try{
			var obj = eval("(" + data.responseText + ")");
                        showTable(obj);
      }catch(e){
      	showNullTable();
      }
			setTimeout("getJson()", "1000");
		}
	});
}

/* Session Table
 * @value Protocol/timeout/STATE/DIRECTION/LOCAL/LOCAL_PORT/REMOTE/REMOTE_PORT/PUBLIC_PORT/PACKETS/BYTES 
 */
function showTable(obj)
{
	$('#session_table').empty();
        var len = parseInt(obj["len"]);
	var tmp_client = {"client": []};
        var table = "<table id=s_tab borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>" +
                    "<thead><tr>" +
                    "<td><b>" + sa_Local + "</b></td>" +
                    "<td><b>" + sa_NAT + "</b></td>" + 
                    "<td><b>" + sa_Internet + "</b></td>" + 
                    "<td><b>" + _protocol + "</b></td>" +
                    "<td><b>" + sa_State + "</b></td>" +
                    "<td><b>" + sa_Dir + "</b></td>" +
                    "<td><b>" + td_Timeout + "</b></td>" +
                    "</tr></thead><tbody>";
        for (var i = 0; i < len ; i++) {
                var session = (obj["session"+i]).split("/");
                 if(session.length > 1) {
                        var packets = (session[9].split("="))[1];
                        var bytes = parseInt(((session[10].split("="))[1])/1000+0.5, 10);
                        table += "<tr>";
                        table += "<td>" + session[4] + ":"+ session[5] +"</td>";
                        table += "<td>" + session[8] + "</td>";
                        table += "<td>" + session[6] + ":" + session[7] +"</td>";
                        table += "<td>" + session[0] + " </td>";
                        table += "<td>" + session[2] + "</td>";
                        table += "<td>" + session[3] + "</td>";
                        table += "<td>" + session[1] + "</td>";
			table += "</tr>";
                }
        }
        table += "</tbody></table>";
	$('#session_table').append(table);
}

function showNullTable()
{
	$('#session_table').empty();
        
        var table = "<table id=s_tab borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>" +
                    "<thead><tr>" +
                    "<td><b>" + sa_Local + "</b></td>" +
                    "<td><b>" + sa_NAT + "</b></td>" + 
                    "<td><b>" + sa_Internet + "</b></td>" + 
                    "<td><b>" + _protocol + "</b></td>" +
                    "<td><b>" + sa_State + "</b></td>" +
                    "<td><b>" + sa_Dir + "</b></td>" +
                    "<td><b>" + td_Timeout + "</b></td>" +
                    "</tr></thead><tbody></tbody></table>";       
	$('#session_table').append(table);
}
getJson();

</script>
</body>
</html>
