<html>
<head>
<% web_include_file("wizard_vpn/wizard_filelink.asp"); %>
<script language="JavaScript">
function init()
{
	var F = document.wz_welcome;
	if ( parse_data("local_type") != "" ) 
	{
		F.local_type[parse_data("local_type")].selected = true;
		F.local_ip.value = parse_data("local_ip");
		if ( document.getElementById("local_type").selectedIndex == 1 ) 
			F.local_mask.value = parse_data("local_mask");
		F.remote_type[parse_data("remote_type")].selected = true;
		F.remote_ip.value = parse_data("remote_ip"); 
		if ( document.getElementById("remote_type").selectedIndex == 1 )
			F.remote_mask.value = parse_data("remote_mask"); 
	}
	sel_type(F,"local");
	sel_type(F,"remote");
	
}
function uiDoCancel(F)
{
        my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
		top.location.href = goto_link("/default.asp");
}

function goto_prev(F)
{
	document.location.href=goto_link("vpn_peer.asp");
}

function chk_mask(obj_id,span_id)
{
	var F = document.wz_welcome;
	if ( !w_valid_mask(obj_id,ZERO_NO,span_id) )
	{
		w_set_alert(span_id,0,obj_id,__T(msg.maskillegal));
		return false;
	}
	return true;
}

function chk_ip(obj_id,span_id)
{
	var flg = ZERO_NO;
	if ( ( obj_id.indexOf("local") != -1 && document.getElementById("local_type").selectedIndex == 1 ) ||  
	     ( obj_id.indexOf("remote") != -1 && document.getElementById("remote_type").selectedIndex == 1 )) 
		flg = ZERO_NO | MASK_OK;
	else
		flg = ZERO_NO | MASK_NO;
	if ( obj_id.indexOf("local") != -1 )  
		w_clear_alert("msg_lip",0,"local_ip");
	else
		w_clear_alert("msg_rip",0,"remote_ip");
	if ( check_ipv4(document.getElementById(obj_id).value, VALID_IP_RULE3,flg ) != PASS )  
	{
		w_set_alert(span_id,0,obj_id,__T(msg.ivalidipformat));
		return false;
	}
	return true;
}

function valid_value(F)
{
	var errflg = 0 ;
	if ( !chk_ip("local_ip","msg_lip") ) errflg = 1;
	if ( document.getElementById("local_type").selectedIndex == 1 ) 
	{
		if ( !chk_mask("local_mask","msg_lmask") ) errflg = 1;
	}
	if ( !chk_ip("remote_ip","msg_rip") ) errflg = 1;
	if ( document.getElementById("remote_type").selectedIndex == 1 )
	{
		if ( !chk_mask("remote_mask","msg_rmask") ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function goto_next(F)
{
	if ( !valid_value(F) ) return;
	save_data("local_type", F.local_type.value); 
	save_data("local_ip", F.local_ip.value); 
	if ( document.getElementById("local_type").selectedIndex == 1 ) 
		save_data("local_mask", F.local_mask.value); 
	save_data("remote_type", F.remote_type.value); 
	save_data("remote_ip", F.remote_ip.value); 
	if ( document.getElementById("remote_type").selectedIndex == 1 )
		save_data("remote_mask", F.remote_mask.value); 
	document.location.href=goto_link("trans.asp");
}

function sel_type(F,seltype)
{
	if ( document.getElementById(seltype+"_type").selectedIndex == 0 ) 
		choose_disable(eval("F."+seltype+"_mask"));
	else
		choose_enable(eval("F."+seltype+"_mask"));
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
    	 <script>create_process_title(2,3);</script>
	 <TR><TD class=DATA_TITLE colspan=4><script>Capture(g_start.lrnetwork);</script></TD></TR>
    	 <TR><TD colspan=4 valign=top>
    	 <TABLE><TR><TD valign=top class=DATA_ITEM><script>Capture(vpn.localtraffic);</script></TD></TR>
    	 	<TR><TD valign=top class=DATA_ITEM2>
	 <TABLE><TR><TD><script>CaptureC(vpn.lip);</script></TD><TD>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.subnet));
                var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"local_type","onchange=sel_type(this.form,'local')",_name,_val,"");
		</script>
		</TD></TR>
		<TR><TD><script>CaptureC(router.ipaddr);</script></TD><TD><input size=32 name=local_ip id=local_ip onblur=chk_ip("local_ip","msg_lip")><span id=msg_lip></span></TD></TR>
		<TR><TD><script>CaptureC(wan.mask);</script></TD><TD><input size=32 name=local_mask id=local_mask onblur=chk_mask("local_mask","msg_lmask")><span id=msg_lmask></span></TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE>
    	 <TABLE><TR><TD valign=top class=DATA_ITEM><script>Capture(vpn.remotetraffic);</script></TD></TR>
    	 	<TR><TD valign=top class=DATA_ITEM2>
	 <TABLE><TR><TD><script>CaptureC(vpn.remoteip);</script></TD><TD>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.subnet));
                var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"remote_type","onchange=sel_type(this.form,'remote')",_name,_val,"");
		</script>
		</TD></TR>
		<TR><TD><script>CaptureC(router.ipaddr);</script></TD><TD><input size=32 name=remote_ip id=remote_ip onblur=chk_ip("remote_ip","msg_rip")><span id=msg_rip></span></TD></TR>
		<TR><TD><script>CaptureC(wan.mask);</script></TD><TD><input size=32 name=remote_mask id=remote_mask><span id=msg_rmask onblur=chk_mask("remote_mask","msg_rmask")></span></TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE>
	 </TD></TR>
         <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>
	create_button("goto_prev(this.form)","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
