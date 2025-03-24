<html>
<head>
<title>DMZ Host</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init()
{
	if ( document.getElementById("gn_profile_name").value != -1 ) 
	{
		document.getElementById("frmprev").src = goto_link("captive_login.asp");
		document.getElementById("frmprev").style.display="";
		document.getElementById("ctr").style.display="";
	}
	top.document.body.style.overflow="hidden";
	document.getElementById("frmprev").style.height = parseInt(top.document.body.clientHeight,10)-100+"px";
	top.document.body.style.overflow="auto";
}

function sel_profile()
{
	var F = document.frmw;
	if ( document.getElementById("gn_profile_name").value != -1 ) 
	{
		F.submit_button.value = "Wireless_welcome_prev";
		F.change_action.value = "gozila_cgi";
		F.now_idx.value = document.getElementById("gn_profile_name").value;
		F.submit();
		
	}else{
		document.getElementById("frmprev").style.display="none";
		document.getElementById("ctr").style.display="none";
	}
	top.document.body.style.overflow="hidden";
	document.getElementById("frmprev").style.height = parseInt(top.document.body.clientHeight,10)-100+"px";
	top.document.body.style.overflow="auto";
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmw method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=dmz_enable>
<input type=hidden name=stflg value=edit>
<input type=hidden name=now_idx value="<% nvram_gozila_get("now_idx"); %>">
<input type=hidden name=gn_bg id=gn_bg value="<% gnet_get("gn_bg"); %>">
<input type=hidden name=gn_logo id=gn_logo value="<% gnet_get("gn_logo"); %>">
<input type=hidden name=gn_company id=gn_company value="<% gnet_get("gn_company_title"); %>">
<input type=hidden name=gn_welcome id=gn_welcome value="<% gnet_get("gn_welcome_title"); %>">
<input type=hidden name=gn_en_dec id=gn_en_dec value="<% gnet_get("gn_declaration_enable"); %>">
<input type=hidden name=gn_err1 id=gn_err1 value="<% gnet_get("gn_error_1_title"); %>">
<input type=hidden name=gn_err2 id=gn_err2 value="<% gnet_get("gn_error_2_title"); %>">
<input type=hidden name=gn_uname id=gn_uname value="<% gnet_get("gn_username_title"); %>">
<input type=hidden name=gn_upwd id=gn_upwd value="<% gnet_get("gn_password_title"); %>">
<input type=hidden name=gn_login id=gn_login value="<% gnet_get("gn_login_title"); %>">
<input type=hidden name=gn_agree id=gn_agree value="<% gnet_get("gn_agree_title"); %>">
<input type=hidden name=gn_copyright id=gn_copyright value="<% gnet_get("gn_copyright_title"); %>">
<input type=hidden name=gn_fcolor id=gn_fcolor value="<% gnet_get("gn_font_color"); %>">
<input type=hidden name=gn_verif id=gn_verif value="<% gnet_get("gn_verification"); %>">
<textarea id=dec style="display:none"><% gnet_get("gn_declaration"); %></textarea>

<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE id=contenttb>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.portalprofilerev),"colspan=2");</script></TR>
  <TR><script>draw_td(O_GUI,SUBTITLE, __TC(wl.profilename));
	var _name = new Array(__T(wl.selprofile)<% get_profile("name"); %>);
	var _val = new Array("-1"<% get_profile("value"); %>);
	draw_object(O_GUI,SELBOX,"gn_profile_name","onchange=sel_profile()",_name,_val,"<% nvram_gozila_get("gn_profile_name"); %>");
  </script>
  </TD></TR>
  <TR id=ctr style=display:none><TD colspan=2 id=ctd valign=top>
  <iframe name=frmprev width=100% height=100% id=frmprev frameborder=0 allowtransparency=true></iframe>
  </TD></TR>
</TABLE>
		<script>chg_layout("divcontent","content_layer_f","content_layer");</script>
</div>
</form>

<!--Start of Connect Successful div --> 
</body></HTML>
