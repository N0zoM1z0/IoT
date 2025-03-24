<html>
<head>
<title>VPN Passthrough</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var back_bt="true";
var change_cancel_bt="true";
var hashname = new Array(__T(mang.md5),__T(mang.sha),__T(mang.sha2));
var hashval = new Array("md5","sha1","sha256");

function to_back(F){
	parent.document.getElementById("newpage").value = "ssl_cert.asp";
	uiDoCancel(F,"back");
}
function init()
{
	chg_layout();
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="vpn" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=ipsec_pass>
<input type=hidden name=l2tp_pass>
<input type=hidden name=pptp_pass>
<input type=hidden name=backname value="ssl_cert">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.certreqdata));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.certdetail));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.sysname));</script>
		<% nvram_get("ca_mgm_request_name"); %>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.hashalg));</script>
		<script>
		for(var i=0; i<hashname.length; i++)
		{
			if ( "<% nvram_get("ca_mgm_hash_algorithm"); %>" == hashval[i] ) 
			{
				document.write(hashname[i]);
				break;
			}
		}
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.signalg));</script>
		RSA
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keylen));</script>
		<% nvram_get("ca_mgm_bits"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.cadata));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<textarea cols=100 rows=10><% get_request_data(); %></textarea>
		</TD></TR>
        </TABLE>
<% aweb_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
