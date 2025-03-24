<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_portal_layout("all"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="portal_layouts.asp";
function refresh_page()
{
        alert_result(0);        
	var F = document.edit_portal;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "portal_layouts_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function init()
{
	var F = document.edit_portal;
	if ( stflg == "edit")
	{
		F.layout_name.value = datalist[selidx].real_name;
		F.layoutname.value = datalist[selidx].pname;
		F.site_title.value = datalist[selidx].stitle;
		F.banner_title.value = datalist[selidx].btitle;
		F.banner_msg.value = datalist[selidx].bmsg;
		if ( datalist[selidx].bmsg_flg == "1" ) 
			F.display_banner_msg.checked = true;		
		if ( datalist[selidx].chttp_flg == "1" ) 
			F.http_meta_tags.checked = true;
		if ( datalist[selidx].cactive_flg == "1" ) 
			F.activex_web_cache.checked = true;
		if ( datalist[selidx].vpn_flg == "1" ) 
			F.vpn_tunnel_page.checked = true;
		if ( datalist[selidx].port_flg == "1" ) 
			F.port_forwarding.checked = true;
		choose_disable(F.layoutname);
	}
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "portal_layouts.asp";
	uiDoCancel(F,"back");
}

function uiDoSave(F)
{
	if ( stflg == "add" ) 
		F.layout_name.value = F.layoutname.value;
	F.submit_button.value = "portal_layouts";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_portal method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=layout_name>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Portal Layout Configuration"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Portal Layout and Theme Name"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Portal Layout Name")+":");</script>
		<input size=51 name=layoutname id=layoutname maxlength=31>
		<span id=msg_layout_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Portal Site Title (Optional)")+":");</script>
		<input size=51 name=site_title id=site_title maxlength=64>
		<span id=msg_site_title></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Banner Title (Optional)")+":");</script>
		<input size=51 name=banner_title id=banner_title maxlength=64>
		<span id=msg_banner_title></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Banner Message (Optional)")+":");</script>
		<textarea size=51 name=banner_msg id=banner_msg></textarea>
		<span id=msg_banner_msg></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Display Banner Message on Log in Page")+":");</script>
		<input type=checkbox name=display_banner_msg id=display_banner_msg>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("HTTP Meta Tags for Cache Control (recommended)")+":");</script>
		<input type=checkbox name=http_meta_tags id=http_meta_tags>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("ActiveX Web Cache Cleaner")+":");</script>
		<input type=checkbox name=activex_web_cache id=activex_web_cache>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("SSL VPN Portal Pages to Display"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("VPN Tunnel Page")+":");</script>
		<input type=checkbox name=vpn_tunnel_page id=vpn_tunnel_page>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Port Forwarding")+":",SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=port_forwarding id=port_forwarding>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
