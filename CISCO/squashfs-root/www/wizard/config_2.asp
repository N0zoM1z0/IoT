<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
var portlist = new Array();
<% get_port_st("portlist"); %>
function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide_conn_type.asp"),410,360);
	else
		HelpDialog(goto_link("guide_conn_type.asp"),355,360);
	
	//window.showModalDialog(goto_link('guide_conn_type.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:360px;dialogHeight:385px;center:yes;');
	
}

function init()
{
	var F = document.wz_cfg;
	var ctype = parse_data("wan_proto");
	var name_list = new Array("dhcp","static","pppoe","pptp","l2tp");
	if ( ctype != "" )
	{
		for(var i=0; i<name_list.length; i++)
		{
			if ( name_list[i] == ctype ) 
			{
				F.conn_type[i].checked = true;
				break;
			}
		}
	}
	if ( portlist[4] != __T(router.down) )//UP
		document.getElementById("msg").innerHTML = __T(wz.detectconnectmsg);
	else
    		document.getElementById("msg").innerHTML = __T(wz.notdetectconnectmsg);
	def_nv = keep_val(F,""); 
}


function goto_next(F)
{
	var type = "";
	if ( F.conn_type[0].checked )
		type="dhcp";
	else if ( F.conn_type[1].checked )
		type="static";
	else if ( F.conn_type[2].checked )
		type="pppoe";
	else if ( F.conn_type[3].checked )
		type="pptp";
	else if ( F.conn_type[4].checked )
		type="l2tp";

	save_data("wan_proto",type);	
	if ( type == "dhcp")
		document.location.href=goto_link("config_4.asp");
	else if ( type == "static" ) 
		document.location.href=goto_link("config_3.asp");
	else if ( type == "pppoe" )
		document.location.href=goto_link("config_3_pppoe.asp");
	else if ( type == "pptp" )
		document.location.href=goto_link("config_3_pptp.asp");
	else if ( type == "l2tp" ) 
		document.location.href=goto_link("config_3_l2tp.asp");
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
<FORM autocomplete=off id=frm action=apply.cgi name="wz_cfg" method=<% get_http_method(); %>>
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
     <script>create_process_title(2,3);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.selcontype);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM><span id=msg></span></TD></TR>
    <TR><TD valign=top class=DATA_ITEM2>
    <input type=radio name=conn_type value=0 checked ><script>Capture(wz.dhcp);</script><BR>
    <input type=radio name=conn_type value=1 ><script>Capture(wan.stipaddr);</script><BR>
    <input type=radio name=conn_type value=2 ><script>Capture(wan.pppoe);</script><BR>
    <input type=radio name=conn_type value=3 ><script>Capture(wz.pptp);</script><BR>
    <input type=radio name=conn_type value=4 ><script>Capture(wz.l2tp);</script><BR>
    </TD></TR>
    <TR><TD class=DATA_ITEM><TABLE><TR><TD width=12px><img src="../image/wizardHelp.png"></TD><TD align=left valign=center>
    <A href="javascript:void(0)" onclick="javascript:goto_guide()"><script>Capture(wz.learnconntype);</script></A> 
    </TD></TR></TABLE></TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"conn_1.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
