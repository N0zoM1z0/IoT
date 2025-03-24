<html>
<head>
<title> End User License Agreement</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
function init()
{
}

function to_agree(F)
{
	window.opener.agreelicense(1);
	window.close();
}

function to_decline(F)
{
	window.opener.agreelicense(0);
	window.close();
}

function before_leave()
{
	window.opener.agreelicense(-1);
	window.close();
}
</script>
</head>
<body onLoad="init();" onbeforeunload=before_leave()>
<FORM autocomplete=off id=frm action=apply.cgi name="vpn" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <!--TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.passthrough));</script></TR-->
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M);</script>
		<% include_license(); %>
		</td></tr>					
        </TABLE>
  <TR>
	<TD colspan=2 id=BTTD class=BTTD>
	<script>
	draw_object(O_GUI,BT,__T(filter.agree),"c5","BT","to_agree(this.form)");
	draw_object(O_GUI,BT,__T(filter.decline),"c6","BT","to_decline(this.form)");
        </script>
	</TD>
  </TR>
</TABLE>
</div>
</form>
</body></HTML>
