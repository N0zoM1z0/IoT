<html>
<head>
<% web_include_file("wizard_vpn/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_next(F)
{
	setTimeout('redirect_page()',1000);
}

function redirect_page()
{
	document.location.href=goto_link("vpn_peer.asp");
}

function uiDoCancel(F)
{
	alert_result_GUI(1);
}

function alert_result_GUI(val)
{	
	var F = document.wz_welcome;
	alert_result(0);
	if ( val == 1 ) 
	{ 
 		choose_disable(document.getElementById("w2"));
	 	choose_disable(document.getElementById("w3"));
		top.location.href = goto_link("/default.asp");
	}
}

function init()
{
	choose_disable(document.getElementById("w1"));
	parent.document.getElementById("wizard_var").value="";
	parent.document.getElementById("def_wizard_var").value="";
}

function Sel_Lang(F)
{
	var err_lang = "<% nvram_get("lang_err"); %>";
	if ( err_lang == "1" ) 
	{
                my_alert(O_GUI,INFO,__T(share.info),spell_words(lang_rule,"<% get_lang_ver("support_lang_version"); %>"),"alert_result_GUI(0)","wizard");
		F.sel_lang[0].selected = true;			
	}else{
        	F.submit_button.value = "default";
	        F.change_action.value = "gozila_cgi";
        	F.submit_type.value = "set_lang";
		F.next_page.value="wizard_vpn/index.asp";
        	F.submit();
	}
}  


</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=bt_type>
<input type=hidden name=next_page>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <TR><TD class=CONTENT_TITLE_L><script>Capture(mang.vpnsetupwizard)</script></TD>
    <TD class=CONTENT_TITLE_R><script>Capture(router.lang);</script>:
    <script>
	<% onload_lang(); %>
        draw_object(O_GUI,SELBOX,"sel_lang","width=165px onChange=Sel_Lang(this.form)",_name,_val,"<% nvram_get("language"); %>");
    </script>
    </TD></TR>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(0,1);</script>
    <TR>
    <TD class=DATA_TITLE colspan=4><script>Capture(g_start.title)</script></TD>
    </TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_DETAIL>
    <P><script>Capture(wz.getstartmsg1);</script></P><P><script>Capture(wz.getstartmsg2);</script></P>
    <TR><TD class=DATA_TAIL><script>Capture(wz.clicknext3);</script></TD></TR>
    </TABLE></TD></TR>
    </TABLE></TD></TR>
    <script>
    	create_button("","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
