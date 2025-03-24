<html>
<head>
<title>Session Timeout</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frmtimeout,"");
	 
}

function uiDoSave(F)
{
	F.submit_button.value = "session_timeout";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtimeout method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.sessiontimeout),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.admintimeout));
		var _name = new Array("1","5","10","30",__T(mang.never));
		var _val = new Array("1","5","10","30","99");
		draw_object(O_GUI,SELBOX,"admin_timeout","",_name,_val,"<% nvram_get("admin_timeout"); %>"); 
		document.write("&nbsp;"+__T(unit.minutes));
		</script>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.guesttimeout),SPACE_DOWN,SPACE_DOWN);
                var _name = new Array("1","5","10","30",__T(mang.never));
                var _val = new Array("1","5","10","30","99");
                draw_object(O_GUI,SELBOX,"guest_timeout","",_name,_val,"<% nvram_get("guest_timeout"); %>");
		document.write("&nbsp;"+__T(unit.minutes));
                </script>
                </TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
