<html>
<head>
<% no_cache(); %>
<SCRIPT language=JavaScript>
var submit_button = "<% nvram_get("submit_button");%>";
var submit_button2 = "<% get_web_page_name(); %>";
var wait_time=50;
var timerID;
var temp;
var url_flag=0,status=0;
var special_case=1;
var model_name="<% nvram_get("model_name"); %>"
temp = new Image(1, 1);

function init()
{
	setTimeout('regetstatus()',20000);
}
function regetstatus()
{
	frames['iframe1'].location.href = "<% get_http_prefix(""); %>getconnst.asp" ; //always refresh iframe code
	setTimeout('regetstatus()', 5000);		
}
function Capture(msg)
{
	document.write(msg);
}
</SCRIPT>
</head>
<body  bgcolor="#e5edf0" onload=init()>
<FORM autocomplete=off id=frm>
<iframe id=loadstatus height=0 width=0 src="" name=iframe1 frameborder=0 scrolling=no></iframe>
<br><br><br><br>
<TABLE cellspacing=0 width="100%">
  <TR><TD align="center"><font face="Verdana" size=4>
<script>
if (submit_button == "Upgrade")
Capture("Upgrade is successful.");
else if (submit_button == "Factory_Defaults")
Capture("Restore is successful.");
else if (submit_button == "Reboot")
Capture("Reboot is successful.");
else
{
special_case=0;
Capture("Configuration settings have been saved successfully");
}
</script>
<p><p>
<font face=Verdana size=2>
<script>
	if ( special_case == 1 ) 
		Capture(model_name+" is restarting...You will be returned to the Login page in few minutes.");
	else{
		Capture("You will be returned to the previous page after several seconds.");	
	}
</script>
</font>
</td></tr>
</TABLE>
</form>
</body></HTML>
