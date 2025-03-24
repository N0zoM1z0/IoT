<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function init()
{
	
}

function uiDoCancel(F)
{
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	go_page(aging_time,"<% nvram_get("aging_time_true"); %>");
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(1,2);</script>
    <TR><TD class=DATA_TITLE colspan=4><script>Capture(wz.chkconn);</script></TD></TR>
    <TR><TD colspan=4 valign=top align=center>
    <TABLE class=STATUS_LAYER>
    <TR>
    <TD class=STATUS_TD width=16px><img src=../image/acknowledge.png></TD><TD class=STATUS_TD_IMG>
    <script>Capture(wz.wandetect);</script></TD></TR>
    </TABLE>
    </TD></TR>	
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext2);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"index.asp\")","onClick=document.location.href=goto_link(\"config_2.asp\")");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
