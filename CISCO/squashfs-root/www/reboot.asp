<html>
<head>
<title>Reboot</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function to_save(F){
	var http = document.location.href.substring(0,document.location.href.indexOf(":"));
	F.gui_action.value = "Apply";
	if ( F.chkrestore.checked == true ) 
	{
		//If http changed to https and changed LAN IP
		if ( http == "http" || document.location.href.indexOf("192.168.1.1") == -1 )
			F.submit_button.value = "Factory_Changed_IP";
		else
			F.submit_button.value = "Factory_Defaults";
		F.gui_action.value='Restore';
	}
	else
	{
		F.submit_button.value = "reboot";
		F.gui_action.value='Apply';
	}
	chg_win_height("hidden_bg");
	parent.document.getElementById("reboot_msg").innerHTML=__T(msg.rebootingdev);
	parent.document.getElementById("hidden_bg").style.display="";
	F.submit();
}

</script>
<body>
<FORM autocomplete=off id="frm" name=frmsetup method=<% get_http_method(); %> action=apply.cgi>
<iframe id=loadstatus height=0 width=0 src="" name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=need_reboot value=1>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.reboot));</script></TR>
  <TR><TD class=MI_TITLE_1><input type=checkbox name=chkrestore>&nbsp;&nbsp;<script>Capture(mang.rebootmsg1);</script></TD></TR>
  <TR><TD class=MI_TITLE_1>
  <script>
		document.write(spell_words(reboot_msg, draw_object(O_VAR,BT,__T(mang.reboot),"t1","BT","to_save(this.form)")));
		chg_layout();
		if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
  </script></TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
