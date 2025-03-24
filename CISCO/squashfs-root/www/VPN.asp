<html>
<head>
<title>VPN Passthrough</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("VPN.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	var _name = new Array("ipsec_pass","l2tp_pass","pptp_pass");
	for(var i=0; i<_name.length; i++)
	{
		eval("F."+_name[i]).value=0;
		if ( eval("F._"+_name[i]).checked == true ) 
			eval("F."+_name[i]).value=1;
	}
	F.submit_button.value = "VPN";
	F.gui_action.value = "Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	/* add by tina 071026 */
	var wk_mode='<% nvram_get("wk_mode");%>';
	
	if (wk_mode == "router")
	{
		choose_disable(document.vpn.ipsec_pass[0]);
		choose_disable(document.vpn.ipsec_pass[1]);
		choose_disable(document.vpn.pptp_pass[0]);
		choose_disable(document.vpn.pptp_pass[1]);
		choose_disable(document.vpn.l2tp_pass[0]);
		choose_disable(document.vpn.l2tp_pass[1]);
	}
	/* end by tina */
	default_nv = keep_val(document.vpn,"");
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="vpn" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=ipsec_pass>
<input type=hidden name=l2tp_pass>
<input type=hidden name=pptp_pass>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.passthrough));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ipsecph));</script>
		<input type=checkbox name=_ipsec_pass <% nvram_match("ipsec_pass","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.pptpph));</script>
		<input type=checkbox name=_pptp_pass <% nvram_match("pptp_pass","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.l2tpph),SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=_l2tp_pass <% nvram_match("l2tp_pass","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
