<% web_include_file("wizard/wizard_filelink.asp"); %>
<script>
var settimes = "<% nvram_get("conn_time"); %>";
var nowst = <% detect_network_st(); %>;
if ( settimes == "" ) settimes = "0";
function init()
{
	//alert("times="+settimes+";nowst="+nowst);
	if ( nowst == "0" ) 
	{
		parent.conn_result(1);
		return;	
	}
	if ( nowst == "1" && parseInt(settimes,10) >= 3 ) 
	{
		parent.conn_result(0);
		return;
	}

	setTimeout('get_st()', 5000);
			
}

function get_st()
{
	var F = document.frmst;
	F.submit_button.value = "wizard/getwanst";
	F.conn_time.value = parseInt(settimes,10)+1;
	F.action = goto_link(F.action);
	//alert("get_st, before submit(),settimes="+F.conn_time.value);
	F.submit();
}
</script>
<BODY onload=init()>
<FORM name=frmst action=apply.cgi method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=conn_time>
</FORM>
</BODY>
