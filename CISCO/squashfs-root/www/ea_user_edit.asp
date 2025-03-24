<html>
<head>
<title>User Configuration</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_user("all"); %>
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
        F.submit_button.value = "ea_user_edit";
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
	if ( stflg == "edit")
	{	
		choose_disable(F.ea_user_name);
		F.ea_user_name.value = datalist[selidx].name;
		F.f_name.value = datalist[selidx].fname;
		F.l_name.value = datalist[selidx].lname;
		F.usertype.selectedIndex = parseInt(datalist[selidx].type,10)-1
		F.pwd.value = datalist[selidx].upwd;
		F.timeout.value = datalist[selidx].idle_timeout;
		for(var i=0; i<group_name.length; i++)
		{
			if ( datalist[selidx].group == group_name[i] ) 
			{
				F.sel_group.selectedIndex = i;
				break;
			}
		}
	}
}

function uiDoSave(F)
{
	if (F.pwd.value != F.cpwd.value)
	{
		my_alert(O_VAR,"pwd",__T(msg.pwdinvmatch),0,"msg_pwd");
		return;	
	} 
	choose_enable(F.ea_user_name);
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
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("User Configuration"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Username"));</script>
		<input size=20 name=ea_user_name id=ea_user_name maxlength=32>
		<span id=msg_ea_user_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("First name"));</script>
		<input size=20 name=f_name id=f_name maxlength=32>
		<span id=msg_f_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Last name"));</script>
		<input size=20 name=l_name id=l_name maxlength=32>
		<span id=msg_l_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("User Type"));</script>
		<script>
			var _name = new Array("SSL VPN User");//,"Administrator","Guest (Readonly)");
			var _val = new Array("1");//,"2","3");
			draw_object(O_GUI,SELBOX,"usertype","id=usertype ",_name,_val,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Select Group"));</script>
		<script>
			draw_object(O_GUI,SELBOX,"sel_group","id=sel_group",group_name,group_name,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Password"));</script>
		<input size=20 name=pwd id=pwd maxlength=32 type=password>
		<span id=msg_pwd></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Confirm Password"));</script>
		<input size=20 name=cpwd id=cpwd maxlength=32 type=password>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Idle Timeout"),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 name=timeout id=timeout maxlength=32>&nbsp;<script>Capture(unit.minutes);</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
