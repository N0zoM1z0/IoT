<html>
<head>
<title>VPN Passthrough</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var back_bt="true";
var change_cancel_bt="true";
var stflg = "<% nvram_gozila_get("stflg"); %>";

function to_back(F){
	parent.document.getElementById("newpage").value = "ssl_cert.asp";
	uiDoCancel(F,"back");
}
function init()
{
}

function sel_url(obj)
{
        document.getElementById("txtUploadFile").value = getPath(obj);
	if ( document.getElementById("txtUploadFile").value.length > 5 ) 
		choose_enable(document.getElementById("e1"));

}

function to_import(F)
{
	clear_msg("txtUploadFile","msg_file");
	if ( stflg == "trust" ) 
		choose_disable(F.signca);
	else
		choose_disable(F.trustca);
	F.action = goto_link("importca.cgi");
	F.encoding="multipart/form-data";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frmcert" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=backname value="ssl_cert">
<input type=hidden name=signca>
<input type=hidden name=trustca>
<input type=hidden name=next_page value="ssl_cert">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.certificates));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.certificates));</script></TR>
		<TR><script>
		if ( stflg == "trust" ) 
			draw_td(O_GUI,SUBTITLE,__TC(vpn.uploadtrustcert));
		else
			draw_td(O_GUI,SUBTITLE,__TC(vpn.uploadactivecert));
		</script>
		<div style="position:relative;">
		<input name=uploadcert id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<INPUT type=text id=txtUploadFile name=browser size=28 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
		<span id=msg_file style="position:absolute;left:250px"></span>
                <script>
                draw_object(O_GUI,BT,__T(router.browse),"e2 id=e2 style='position:absolute;left:175px;top:0px'","BT","");
		</script>
		</div>
		</td></tr>					
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>&nbsp;</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN, SPACE_DOWN);</script>
                <script>
                draw_object(O_GUI,BT,__T(mang.importbt),"e1","BT","to_import(this.form)");
		chg_layout();
		</script>
		</TD></TR>
        </TABLE>
<% aweb_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
