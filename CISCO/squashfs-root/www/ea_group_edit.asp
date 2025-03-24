<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_group("edit"); %>


var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ea_group.asp";
var portal_name = new Array(<% get_portal_layout("name"); %>);
var auth_type=new Array(__T("Local User Database"),__T("Radius-PAP"),__T("Radius-CHAP"),__T("Radius_MSCHAP"),__T("Radius-MSCHAPV2"),__T("NT Domain"),__T("Acive Directory"),__T("LDAP"));
function refresh_page()
{
        alert_result(0);        
	var F = document.edit_group;
	F.selidx.value = selidx;
	F.stflg.value = stflg;
        F.submit_button.value = "ea_group_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ea_group.asp";
	uiDoCancel(F,"back");
}
function init()
{
	var F = document.edit_group;
	if ( auth_type[parseInt(datalist[selidx][1],10)-1] != __T("LDAP") )
	{
		choose_disable(document.getElementById("ldap1"));
		choose_disable(document.getElementById("ldap2"));
		choose_disable(document.getElementById("ldap3"));
		choose_disable(document.getElementById("ldap4"));
	}else{
		F.ldap1.value = datalist[selidx][3];
		F.ldap2.value = datalist[selidx][4];
		F.ldap3.value = datalist[selidx][5];
		F.ldap4.value = datalist[selidx][6];
	}
	F.timeout.value = datalist[selidx][2];	
}

function uiDoSave(F)
{
	F.eagroup_name.value = datalist[selidx][0];
	F.submit_button.value = "ea_group";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_group method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=eagroup_name>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Group Configuration"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Group Name"));</script>
		<script>document.write(datalist[selidx][0]);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Group Auth Type"));</script>
		<script>Capture(auth_type[parseInt(datalist[selidx][1],10)-1]);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("LDAP attribute 1"));</script>
		<input size=20 name=ldap1 id=ldap1 maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("LDAP attribute 2"));</script>
		<input size=20 name=ldap2 id=ldap2 maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("LDAP attribute 3"));</script>
		<input size=20 name=ldap3 id=ldap3 maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("LDAP attribute 4"));</script>
		<input size=20 name=ldap4 id=ldap4 maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Idle Timeout"),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 name=timeout id=timeout maxlength=32>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
