<html>
<head>
<title>DBG Diag</title>
</head>
<script>
function bt_sppe(val)
{
    var F = document.debug_frm;
    F.submit_button.value = "dbg_diag"
    if ( val == 1 ) 
         F.en_sppe.value = "1";
    else
         F.en_sppe.value = "0";
    F.change_action.value="gozila_cgi";
    F.session_id.value = "<% nvram_get("session_key"); %>";
    F.submit();
}

function to_download()
{
	window.location.href="cbtdb.tar";
}

function to_download_wwan()
{
	window.location.href="cbtdb_wwan.tar";
}

</script>
<body>
<form name=debug_frm method=<% get_http_method(); %> action="apply.cgi;session_id=<% nvram_get("session_key"); %>">
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=session_id>
<input type=hidden name=en_sppe>
<H1>Diag</H1>
<TABLE>
	<TR>
		<TD width="200">SPPE</TD>
		<TD><input type=button name=ensppe value=Enable onclick=bt_sppe(1)>&nbsp;&nbsp;
			 <input type=button name=dissppe value=Disable onclick=bt_sppe(0)></TD>
	</TR>
	<TR>
		<TD width="200">VPN Debug Log</TD>
		<TD><input type=button name=save value=Save onclick=to_download()></TD>
	</TR>
	<TR>
		<TD width="200">Mobile Network Log</TD>
		<TD><input type=button name=save value=Save onclick=to_download_wwan()></TD>
	</TR>
	<TR><TD colspan=2>Information</TD></TR>
	<TR><TD colspan=2><textarea rows="10" cols="100" readonly><% get_debug_data(); %></textarea></TD></TR>
</TABLE>
</body>
</html>
