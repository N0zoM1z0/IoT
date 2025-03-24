<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_domain("all"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ea_domain.asp";
var portal_name = new Array(<% get_portal_layout("name"); %>);
var auth_type=new Array(__T("Local User Database"),__T("Radius-PAP"),__T("Radius-CHAP"),__T("Radius_MSCHAP"),__T("Radius-MSCHAPV2"),__T("NT Domain"),__T("Acive Directory"),__T("LDAP"));
function refresh_page()
{
        alert_result(0);        
	var F = document.edit_domain;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "ea_domain_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ea_domain.asp";
	uiDoCancel(F,"back");
}
function init()
{
	var F = document.edit_domain;
	
	choose_disable(document.getElementById("auth_server"));
	choose_disable(document.getElementById("auth_secret"));
	choose_disable(document.getElementById("work_group"));
	choose_disable(document.getElementById("ldap_base"));
	choose_disable(document.getElementById("act_domain"));

	if ( stflg == "edit")
	{
		F.domain_name.value = datalist[selidx].dname;
		F.sel_authtype.selectedIndex = parseInt(datalist[selidx].authtype,10)-1;
		for(var i=0; i<portal_name.length; i++)
		{
			if ( portal_name[i] == datalist[selidx].pname )
			{
				F.sel_portal.selectedIndex = i ;
				break;
			}
		}
		F.auth_server.value = datalist[selidx].auth_server;
		F.auth_secret.value = datalist[selidx].auth_secret;
		F.work_group.value = datalist[selidx].workgroup;
		F.ldap_base.value = datalist[selidx].ldap;
		F.act_domain.value = datalist[selidx].act_domain;
		Selauthtype(F);
		choose_disable(document.getElementById("domain_name"));
		choose_disable(document.getElementById("sel_authtype"));
	}
}

function Selauthtype(F)
{
	choose_disable(document.getElementById("auth_server"));
	choose_disable(document.getElementById("auth_secret"));
	choose_disable(document.getElementById("work_group"));
	choose_disable(document.getElementById("ldap_base"));
	choose_disable(document.getElementById("act_domain"));
	if ( F.sel_authtype[F.sel_authtype.selectedIndex].value == "2" ||
	     F.sel_authtype[F.sel_authtype.selectedIndex].value == "3" || 
	     F.sel_authtype[F.sel_authtype.selectedIndex].value == "4" ||
	     F.sel_authtype[F.sel_authtype.selectedIndex].value == "5" ) 
	{
		choose_enable(document.getElementById("auth_server"));
		choose_enable(document.getElementById("auth_secret"));
	}
	else if ( F.sel_authtype[F.sel_authtype.selectedIndex].value == "6" )
	{
		choose_enable(document.getElementById("auth_server"));
		choose_enable(document.getElementById("work_group"));
	}
	else if ( F.sel_authtype[F.sel_authtype.selectedIndex].value == "7" )
	{
		choose_enable(document.getElementById("auth_server"));
		choose_enable(document.getElementById("act_domain"));
	}
	else if ( F.sel_authtype[F.sel_authtype.selectedIndex].value == "8" )
	{
		choose_enable(document.getElementById("auth_server"));
	        choose_enable(document.getElementById("ldap_base"));
	}
		
}

function uiDoSave(F)
{
	choose_enable(document.getElementById("domain_name"));
	choose_enable(document.getElementById("sel_authtype"));
	choose_enable(document.getElementById("auth_server"));
	choose_enable(document.getElementById("auth_secret"));
	choose_enable(document.getElementById("work_group"));
	choose_enable(document.getElementById("ldap_base"));
	choose_enable(document.getElementById("act_domain"));
	F.submit_button.value = "ea_domain";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_domain method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Domains"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Domain Configuration"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Domain Name"));</script>
		<input size=20 name=domain_name id=domain_name maxlength=32>
		<span id=msg_domain_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Authentication Type"));</script>
		<script>
			var _val = new Array("1","2","3","4","5","6","7","8");
			draw_object(O_GUI,SELBOX,"sel_authtype","id=sel_authtype onChange=Selauthtype(this.form)",auth_type,_val,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Select Portal"));</script>
		<script>
			draw_object(O_GUI,SELBOX,"sel_portal","id=sel_portal onChange=Sel_portal()",portal_name,portal_name,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Authentication Server"));</script>
		<input size=20 name=auth_server id=auth_server maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Authentication Secret"));</script>
		<input size=20 name=auth_secret id=auth_secret maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Work Group"));</script>
		<input size=20 name=work_group id=work_group maxlength=32>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("LDAP Base DN"));</script>
		<input size=20 name=ldap_base id=ldap_base maxlength=255>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Active Directory Domain"),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 name=act_domain id=act_domain maxlength=32>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
