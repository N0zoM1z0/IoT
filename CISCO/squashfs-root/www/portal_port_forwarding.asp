<html>
<head>
<title>SSL VPN</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init()
{

}
</script>
<body onload="init();">
<FORM autocomplete=off id=frm method=<% get_http_method(); %> name=portal_info action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Port Forwarding"));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("SSL VPN Port Forwarding Client Installer / Launcher"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<img src=image/iconSslPfInstall.png>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN);</script>
		<script>
		Capture("Click the Icon to connect to the remote servers.");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		Capture("<B>Note:</B><BR>* The active connections can still persist even when browser is closed without uninstalling the Port Forwarding client");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<Script>
		Capture("<B>Recommendations:</B><BR>* Always follow this sequence: Uninstall any active clients, logout, and close the browser. If recommended steps are followed, it will mask the connection safer, easire to maintain, and avoid possible errors.");
		</script>
		</TD></TR>
		<script>
			// For firefox layout
			chg_layout();
		
		</script>
		</TD></TR>
        </TABLE>
<input type=hidden name=all_page_end>
</TABLE>
</form>
</body></HTML>
