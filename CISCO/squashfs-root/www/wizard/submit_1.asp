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
	var F = document.wz_cfg;
	if ( portlist[4] != __T(router.down))
		document.getElementById("getst").src = goto_link("getwanst.asp");
	else
		conn_result(0);
}
	
function conn_result(pass){
	document.getElementById("getst").src = "";
	if ( pass == 1 ) 
	{
		document.getElementById("st_msg").innerHTML = __T(wz.interconndet);
		document.getElementById("img_conn").src = "../image/acknowledge.png";
		document.getElementById("detail_msg").innerHTML = __T(wz.detectmsg); 
	}else{
		
		document.getElementById("st_msg").innerHTML = __T(wz.nointerconndet)
		document.getElementById("img_conn").src = "../image/alert_critical.png";
		document.getElementById("detail_msg").innerHTML = __T(wz.nodetectmsg); 
		
	}
	document.getElementById("img_process").style.display="none";
	//src = "../image/progressbar0.jpg";
        document.getElementById("img_conn").style.display="";
        document.getElementById("msg_next").style.display="";
	choose_enable(document.getElementById("w2"));
}

function init()
{
	choose_disable(document.getElementById("w2"));
	setTimeout("get_status()", 5000);		
	def_nv = keep_val(document.wz_cfg,""); 
	
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
<FORM autocomplete=off id=frm action=apply.cgi name="wz_cfg" method=<% get_http_method(); %>>
<iframe id=getst height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(2,3);</script>
    <TR><TD class=DATA_TITLE colspan=4><script>Capture(wz.updateset);</script></TD></TR>
    <TR><TD colspan=4 valign=top align=center>
    <TABLE class=STATUS_LAYER>
    <TR><TD class=STATUS_TD>
    <TABLE>
    <TR><TD class=aSTATUS_TD width=16px><img src=../image/acknowledge.png></TD>
        <TD class=aSTATUS_TD_IMG><script>Capture(wz.successconfig);</script></TD></TR>
    <TR><TD class=aSTATUS_TD width=16px><img src=../image/acknowledge.png style=display:none id=img_conn></TD>
        <TD class=aSTATUS_TD_IMG id=st_msg><script>Capture(wz.chkintconn);</script></TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD class=STATUS_TD2 colspan=2><img id=img_process src='/image/ProgressBar_indeterminate.gif'></TD></TR>
    </TABLE>
    <TR><TD valign=top class=DATA_ITEM colspan=4 id=detail_msg>
    </TD></TR>
    </TD></TR>	
    <TR><TD class=DATA_SHOWTOP colspan=4 id=msg_next style=display:none><script>Capture(wz.nexttoconfigsec);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>
	
	create_button("onClick=document.location.href=goto_link(\"config_5.asp\")","onClick=document.location.href=goto_link(\"sec_1.asp\")");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
