<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_guide()
{
	window.showModalDialog(goto_link('guide_security.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:370px;dialogHeight:380px;center:yes;');
	
}

function init()
{
	def_nv = keep_val(document.wz_sec,""); 
}

function goto_back(F)
{
	var s_mode = parse_data("security_mode");
	if ( s_mode == "disabled" || s_mode == "wpa_personal" || s_mode == "wpa2_personal" )
	        document.location.href=goto_link("sec_3.asp");
	else
	        document.location.href=goto_link("sec_3_1.asp");
}

function goto_next(F)
{
    document.location.href=goto_link("sec_5.asp");
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
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setsec);</script></TD></TR>
    <TR><TD colspan=4 valign=top width=100%>
    <TABLE width=100%>
    <TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.cmfinfo);</script>
    </TD></TR>
    <TR><TD valign=top align=center width=100%>
    <TABLE class=STATUS_LAYER>
    <TR><TD class=STATUS_TD><TABLE cellspacing=0 >
    <TR ><TD style="border-bottom:1px solid #FFFFFF">
    <script>Capture(wl.networkname);</script>:</TD><TD style="border-bottom:1px solid #FFFFFF">
    <script>
	var ssid = parse_data("wl_ssid_0");
	if ( ssid != "" ) document.write(ssid);
    </script>
    </TD></TR>
    <TR><TD style="border-bottom:1px solid #FFFFFF">
    <script>Capture(wz.netsectype);</script>:&nbsp;</TD><TD style="border-bottom:1px solid #FFFFFF">
    <script>
    var security_mode = parse_data("security_mode");
    if ( security_mode == "disabled" ) 
	Capture(wz.nosecurity);
    else if ( security_mode == "wpa2_personal" || security_mode == "wpa2_personal_mixed" )  
	Capture(wz.bestsec1);
    else if ( security_mode == "wpa_personal" )  
	Capture(wz.bestsec2);
    else if ( security_mode == "wpa_enterprise" ) 
	Capture(wl.wpae);
    else if ( security_mode == "wpa2_enterprise" ) 
	Capture(wl.wpa2e);
    else if ( security_mode == "wpa2_enterprise_mixed" ) 
	Capture(wl.wpa2emixed);
    else if ( security_mode == "wep" ) 
	Capture(wl.wep);
  </script>
    </TD></TR>
    <TR><TD valign=top>
    <script>Capture(wz.seckey);</script>:</TD><TD>
    <script>
    	var security_mode = parse_data("security_mode");
	var tmpkey = parse_data("wpa_psk");
    	if ( security_mode == "wpa2_personal" || security_mode == "wpa2_personal_mixed" || security_mode == "wpa_personal")  
	{
		if ( tmpkey != "" ) document.write(tmpkey);//string_break(32,key));
	}else if ( security_mode == "wep" ) 
	{
		var keyidx = parse_data("key");
		tmpkey = parse_data("key"+keyidx);
		if ( tmpkey != "" ) document.write(tmpkey);//string_break(32,key));
		 
	}
	
    </script>
    </TD></TR>
    </TABLE>
    </TD></TR></TABLE></TD></TR> 
    <!--TR><TD valign=top class=DATA_ITEM><TABLE><TR><TD width=12px><img src="../image/save_0019_16.png"></TD><TD align=left valign=center>
    <A href="javascript:window.print()">
    Save these settings in a text file on my desktop after the router is configured.
    </A>
    </TD></TR></TABLE></TD></TR-->
    <!--TR><TD class=DATA_ITEM><TABLE><TR><TD width=12px><img src="../image/printer.png"></TD><TD align=left valign=center>
    <A href="javascript:window.print()">Print security settings</A>
    </TD></TR>
    </TABLE>
    </TD></TR-->
    </TABLE>
    </TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>
	if ( http_power == "r" ) 
	    	Capture(wz.clicknext1);
    	else
		Capture(wz.clicksubmit);
    </script></TD></TR> 
    </TABLE></TD></TR>
    <script>
	if ( http_power == "r" ) 
		create_button("goto_back(this.form)","onClick=document.location.href=goto_link(\"complete_setup.asp\")","");
	else
		create_button("goto_back(this.form)","","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
