<html>
<head>
<% no_cache(); %>
<LINK href="wizard_style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="../lang.js"></script>
<script type="text/javascript" src="../common.js"></script>
<script type="text/javascript" src="wizard_cmd.js"></script>
<script language="JavaScript">
function init(){
	choose_disable(document.getElementById("w1"));
}

function uiDoCancel(F)
{
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	go_page(aging_time,"<% nvram_get("getting_start"); %>");
}
</script>
</head>
<BODY onLoad="init();">
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
    <TR>
    <TD class=DATA_TITLE colspan=4><script>Capture(wz.chkconn);</script></TD>
    </TR>
    <TR><TD colspan=4 valign=top>
    </TD></TR>	
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"conn_1.asp\")","onClick=document.location.href=goto_link(\"conn_2.asp\")");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
