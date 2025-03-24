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
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Portal Information"));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Supported Features"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("SSL VPN Tunnel"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<img src=image/iconSslVpnTunnelInstall.png>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("'SSL VPN Tunnel' facilitates in creating an encrypted tunnel to the corporate network."));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script></TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("SSL Port Forwarding"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<img src=image/iconSslPfInstall.png>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("'Port Forwarding' facilitates creating an encrypted tunnel for pre-defined applications on the corporate network."));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		Capture("<B>Note:</B><BR>1.<B>'Change Password'</B> section is available ONLY for users belonging to local database.<BR>2. Please contact your administrator in case any/all of the above mentioned features are NOT enabled.<BR>3. <B>Jave,Jvascript,Active-X controls</B> MUST be <B>Enabled/Allowed</B> in your browser settings.");
			// For firefox layout
			chg_layout();
		
		</script>
		</TD></TR>
        </TABLE>
<input type=hidden name=all_page_end>
</TABLE>
</form>
</body></HTML>
