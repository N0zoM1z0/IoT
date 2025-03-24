<html>
<head>
<title>VPN Passthrough</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var back_bt="true";
var change_cancel_bt="true";

function to_back(F){
	parent.document.getElementById("newpage").value = "ssl_cert.asp";
	uiDoCancel(F,"back");
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
}

function uiDoSave(F)
{
	if ( !chk_subject(F) ) return;
	F.submit_button.value = "gen_cert";
	F.gui_action.value = "Apply";
	if ( F.ca_mgm_bits.value == "2048" ) 
		F.wait_time.value = "20";
	else  
		F.wait_time.value = "8";
	parent.document.getElementById("save_bg").style.display="";
	F.submit();
}

function chk_subject(F)
{
	clear_msg("ca_mgm_subject","msg_ca_mgm_subject");

	if ( F.ca_mgm_subject.value.indexOf("/") != -1 ||
	     F.ca_mgm_subject.value.indexOf("\"") != -1 ||
	     F.ca_mgm_subject.value.indexOf("\'") != -1 )
	{
		my_alert(O_VAR,"ca_mgm_subject",__T(msg.validname),"0","msg_ca_mgm_subject");
		return false;
	}
	return true;
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frmgenssl" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=ipsec_pass>
<input type=hidden name=l2tp_pass>
<input type=hidden name=pptp_pass>
<input type=hidden name=wait_time>
<input type=hidden name=next_page value="ssl_cert">
<input type=hidden name=backname value="ssl_cert">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.sslcert));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.name));</script>
		<input size=20 maxlength=64 name=ca_mgm_request_name>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.subject));</script>
		<input size=20 maxlength=256 name=ca_mgm_subject id=ca_mgm_subject onblur=chk_subject(this.form)>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,__T(vpn.subjecthint)));</script>
		<span id=msg_ca_mgm_subject></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.hashalg));</script>
		<script>
			var selname = new Array(__T(mang.md5),__T(mang.sha),__T(mang.sha2));
			var selval = new Array("md5","sha1","sha256");
			draw_object(O_GUI,SELBOX,"ca_mgm_hash_algorithm","",selname,selval,"");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.signalg));</script>
		<script>
			var selname = new Array(__T(mang.rsa));
			var selval = new Array("rsa");
			draw_object(O_GUI,SELBOX,"selsign","",selname,selval,"");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.signkeylen));</script>
		<script>
			var selname = new Array("512","1024","2048");
			draw_object(O_GUI,SELBOX,"ca_mgm_bits","",selname,selname,"");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
		<input size=20 maxlength=15 name=ca_mgm_san_ip>(<script>Capture(vpn.optional);</script>)
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.domainname));</script>
		<input size=20 maxlength=128 name=ca_mgm_san_dns>(<script>Capture(vpn.optional);</script>)
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(bsd.notify_mailbt),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 maxlength=128 name=ca_mgm_san_mail>(<script>Capture(vpn.optional);</script>)
		</TD></TR>
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
