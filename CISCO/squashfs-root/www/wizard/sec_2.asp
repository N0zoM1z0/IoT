<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide_networkname.asp"),280,330);
	else
		HelpDialog(goto_link("guide_networkname.asp"),250,330);
	
//	window.showModalDialog(goto_link('guide_networkname.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:330px;dialogHeight:250px;center:yes;');
	
}

function init()
{
	var F = wz_sec;
	var data = parse_data("wl_ssid_0");
	if ( data != "" ) 
		F.ssid1.value = data;
	def_nv = keep_val(F,""); 
}

function goto_next(F)
{
	if ( !before_valid(F) ) return false;
	if ( F.ssid1.value != "" ) 
		save_data("wl_ssid_0",F.ssid1.value);
	var s_mode = parse_data("security_mode");
	if ( s_mode == "disabled" || s_mode == "wpa_personal" || s_mode == "wpa2_personal" )
	        document.location.href=goto_link("sec_3.asp");
	else
	        document.location.href=goto_link("sec_3_1.asp");
}

function before_valid(F)
{
	var errflg=0;
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById("ssid1").value,ZERO_NO);
	if ( returnmsg != "" ) 
	{
		w_set_alert("msg_ssid",0,"ssid1",returnmsg);	
		errflg=1;
	}
	if ( errflg ) return false;
	return true;
}

function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv,2) ) 
                my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
        else 
                alert_result_GUI(1);
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
	{
		var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
		go_page(aging_time,"<% nvram_get("getting_start"); %>");
	}
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_sec" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.secstep2of4);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE>
     <TR><TD valign=top class=DATA_ITEM>
     <script>Capture(wz.descsec2of4_1);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM>
     <script>Capture(wz.descsec2of4_2);</script>:
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM2>
     <TABLE><TR><TD><script>Capture(wz.networkname);</script></TD><TD><input size=40 name=ssid1 id=ssid1 maxlength=32><span id=msg_ssid></span></TD></TR>
     <TR><TD></TD><TD><script>Capture(wz.descsec2of4_3);</script></TD></TR>
     </TABLE>
     </TD></TR>
     <TR><TD class=DATA_ITEM><TABLE><TR><TD width=12px><img src="../image/wizardHelp.png"></TD><TD align=left valign=center>
     <A href=javascript:void(0) onclick="javascript:goto_guide()"><script>Capture(wz.namehelplink);</script></A>
    </TD></TR>
    </TABLE>
    </TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"sec_1.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
