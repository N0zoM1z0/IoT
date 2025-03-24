<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
var portlist = new Array();
<% get_port_st("portlist"); %>

function goto_guide()
{
	window.showModalDialog(goto_link('guide.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:330px;dialogHeight:190px;center:yes;');
	
}

function get_status()
{
	if ( portlist[4] != __T(router.down) )//UP
		document.location.href=goto_link("conn_pass.asp");
	else
		document.location.href=goto_link("conn_fail.asp");
	choose_enable(document.getElementById("w1"));
}

function init()
{
	choose_disable(document.getElementById("w1"));
	choose_disable(document.getElementById("w2"));
	var F = document.wz_welcome;
	setTimeout('get_status()', 2000);		
	def_nv = keep_val(F,""); 
	
}
function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv) ) 
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
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
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
    	 <script>create_process_title(1,2);</script>
	 <TR><TD class=DATA_TITLE colspan=4><script>Capture(wz.chkconn);</script></TD></TR>
	 <TR><TD colspan=4 valign=top align=center>
		 <TABLE class=STATUS_LAYER>
		   <TR><TD class=STATUS_TD><script>Capture(wz.chkwanconn);</script>
		   </TD></TR>
		    <TR><TD class=STATUS_TD2><img id=img_process src='/image/ProgressBar_indeterminate.gif'></TD></TR>
	 	</TABLE>
         </TD></TR>	
         <TR><TD colspan=4 class=ST_HINT><script>Capture(wz.takemoments);</script>
	 </TD></TR>
    </TABLE></TD></TR>
    <script>
	create_button("onClick=document.location.href=\"index.asp\"","onClick=document.location.href=\"conn_2.asp\"");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
