<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
var goto_login = "<% goto_login(); %>";
function init()
{
	choose_disable(document.getElementById("w1"));
	choose_disable(document.getElementById("w3"));
	if ( current_model_name == "RV130" ) 
	{
		HIDDEN_PART("TD","wl_start","wl_end",1);
		document.getElementById("save_tb").style.display="none";
	}
}

function to_finish()
{
	//window.location.href="complete_setup.asp";
	//return;
	if ( http_power == "rw" )
	{
		var F = document.wz;
		F.wizard_start.value=0;
	        F.change_action.value="gozila_cgi";
		if ( goto_login == "1" ){ 
		        F.submit_button.value = "login";
	        	F.submit_type.value = "wizard_logout";
		}
		else
		        F.submit_button.value = "wizard/index";
	        F.submit();
		/*
		if ( goto_login != "1" ){ 
			var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
			go_page(aging_time,"<% nvram_get("getting_start"); %>");
		}*/
	}
	else
	{
		var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
		go_page(aging_time,"<% nvram_get("getting_start"); %>");
	}
}

function load_file()
{
	window.location.href = "<% get_http_prefix(""); %>wizard/security.txt";
}

</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz" method=<% get_http_method(); %>>
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
     <script>create_process_title(4,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.finishtitle);</script></TD></TR>
    <TR><TD colspan=4 valign=top width=100%>
    <TABLE width=100%>
        <TR><TD valign=top class=DATA_DETAIL>
    	<TABLE><TR><TD width=24px valign=top><img src=../image/msgIconSuccess.png></TD><TD><script>
	if ( current_model_name == "RV130W" ) 
		Capture(wz.finishdesc1);
	else
		Capture(wz.finishdesc2);
	</script>
</TD></TR></TABLE>
	</TD></TR>
        <TR><TD valign=top class=DATA_DEATIL align=center width=100%>
        <TABLE><TR><TD width=70% id=wl_start>
    <TABLE style="background-color:#c6d9e7;">
    <!--TR><TD><TABLE cellspacing=0 -->
    <TR><TD style="border-bottom:1px solid #FFFFFF">
    <script>Capture(wl.networkname);</script>:</TD><TD style="border-bottom:1px solid #FFFFFF">
    <script>
        var ssid = parse_data("wl_ssid_0");
        if ( ssid != "" ) document.write(ssid);
    </script>
    </TD></TR>
    <TR><TD style="border-bottom:1px solid #FFFFFF">
    <script>Capture(wz.netsectype);</script>:</TD><TD style="border-bottom:1px solid #FFFFFF">
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
    <TR><TD valign=top id=wl_end>
    <script>Capture(wz.seckey);</script>:</TD><TD>
    <script>
        var security_mode = parse_data("security_mode");
        var key = parse_data("wpa_psk");
        if ( security_mode == "wpa2_personal" || security_mode == "wpa2_personal_mixed" || security_mode == "wpa_personal")  
        {
                if ( key != "" ) document.write(string_break(32,key));
	}else if ( security_mode == "wep" ) 
	{
		var keyidx = parse_data("key");
		tmpkey = parse_data("key"+keyidx);
		if ( tmpkey != "" ) document.write(string_break(32,tmpkey));//string_break(32,key));
		 
	}
    </script>
    </TD></TR>
    </TABLE>  
    </TD><TD>
    <script>
        if ( current_model_name == "RV130W" ) 
                document.write("<img src=\"../image/Router.jpg\" width=230px>");
        else
                document.write("<img src=\"../image/RV130_Rear_panel.png\" width=230px>");
    </script>
    </TD></TR>
    </TABLE></TD><!--TD>
    <img src="../image/Router.jpg" width=230px></TD--></TR>
    <TR><TD class=DATA_DETAIL>
    <TABLE id=save_tb><TR><TD width=12px><img src="../image/save_0019_16.png"></TD><TD align=left valign=center>
    <A href="javascript:load_file()"><script>Capture(wz.exploreset);</script></A>
    </TD>
    <TD width=12px><img src="../image/printer.png"></TD><TD align=left valign=center>
    <A href="javascript:window.print()"><script>Capture(wz.printset);</script></A>
    </TD></TR></TABLE></TD></TR>
    <TR><TD class=DATA_DETAIL><script>Capture(wz.clickfinish);</script></TD></TR>
    </TABLE></TD></TR>
    </TABLE></TD></TR>
    <script>
    document.write("<TR><TD></TD><TD class=DATA_BT>");
    draw_object(O_GUI,BT,__T(share.back),"w1","BT","document.location.href=goto_link(\"sec_5.asp\")");
    document.write("&nbsp;&nbsp;");
    draw_object(O_GUI,BT,__T(filter.finish),"w2","BT","to_finish()");
    document.write("&nbsp;&nbsp;");
    draw_object(O_GUI,BT,__T(share.cancel),"w3","BT","");
    document.write("</TD></TR>");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
