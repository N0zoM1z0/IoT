<html>
<head>
<% no_cache(); %>
<script>
var port_arr = new Array();
<% get_port_mib(); %>

function init()
{
	var nowidx = parent.document.getElementById("now_idx").value ;
	parent.document.getElementById("tx").innerHTML = port_arr[nowidx][0];	
	parent.document.getElementById("rx").innerHTML = port_arr[nowidx][1];	
}
</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=frmport method=<% get_http_method(); %> action=apply.cgi>
</form>
</body></HTML>
