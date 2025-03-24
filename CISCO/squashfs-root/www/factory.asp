<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function to_save(F)
{
	my_alert(O_GUI,WARNING,__T(share.info),__T(msg.startupconfirmclear),"reboot_result(1)","reboot_result(0)","","yesno");
}

function reboot_result(val)
{
	alert_result(0);
	if ( val == 1 ) 
	{	
		parent.document.getElementById("save_bg").style.display="";
		timerID = setTimeout('progress()', "2000");
	}
	
}

function progress()
{
	
	var F = document.setup;
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("reboot_msg").innerHTML=__T(msg.rebootingdev);
	parent.document.getElementById("hidden_bg").style.display="";
	var http = document.location.href.substring(0,document.location.href.indexOf(":"));
	//If http changed to https and changed LAN IP
	if ( http == "http" || document.location.href.indexOf("192.168.1.1") == -1 )
		F.submit_button.value = "Factory_Changed_IP";
	else
		F.submit_button.value = "Factory_Defaults";
	F.gui_action.value='Restore';
        F.submit();
	
}

</script>
<body>
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type value='<% nvram_gozila_get("submit_type");%>'>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.restoredef));</script></TR>
  <TR><TD class=MI_TITLE_1><script>Capture(mang.restoremsg);</script></TD></TR>
  <TR><TD class=MI_TITLE_1>
	    	<script>
		draw_object(O_GUI,BT,__T(def.words),"t1","BT","to_save(this.form)");
		chg_layout();
		if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
		</script>
   </TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
