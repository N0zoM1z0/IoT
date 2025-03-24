<html>
<head></head>
<script>
var file_name = "<% get_file_exist(); %>";
document.write("file_name="+file_name);
function init()
{
	if ( file_name != "" ) 
		get_page();
	else
		check_file();
		
}

function check_file()
{
	var F = document.form1;
	F.submit_button.value="check_session";
	F.submit_type.value="get_help";
	F.change_action.value = "gozila_cgi";
	F.gui_action.value = "Apply";
	F.submit();
}

function get_page()
{
	if ( parent.document.forms[0].openwin.value == "help")
	{
		parent.get_help(file_name);
	}
	else 
	{
		parent.get_about();
	}
}


</script>
<body onload=init()>
<FORM name=form1 method="<% get_http_method(); %>" action="apply.cgi;session_id=<% nvram_get("session_key"); %>">
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=now_help>
<script>
document.form1.now_help.value = parent.document.getElementById("now_help").value;
</script>
</FORM>
</body></html>

