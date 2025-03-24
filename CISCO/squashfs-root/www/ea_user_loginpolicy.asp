<html>
<head>
<title>User Configuration</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_user("log"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ea_user.asp";
var group_name = new Array(<% get_user_group("name"); %>);
function refresh_page()
{
        alert_result(0);        
        var F = document.edit_user;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "ea_user_loginpolicy";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ea_user.asp";
	uiDoCancel(F,"back");
}
function init()
{
	var F = document.edit_user;
	if ( datalist[selidx][1] == "1" ) F.dis_login.checked = true;
	if ( datalist[selidx][2] == "1" ) F.deny_iface.checked = true;
}

function uiDoSave(F)
{
	F.ea_user_name.value = datalist[selidx][0];
	F.submit_button.value = "ea_user";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_user method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=ea_user_name>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Users"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__TC("User Log in Policies"));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Username"));</script>
		<script>Capture(datalist[selidx][0]);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Disable Log in"));</script>
		<input type=checkbox name=dis_login id=dis_login>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Deny Log in from WAN Interface"),SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=deny_iface id=deny_iface>
                </TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
