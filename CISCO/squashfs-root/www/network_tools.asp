<html>
<head>
<title>Network Tools</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
}

function do_action(F,type)
{	
	if ( !valid_value(F,type) ) return;
	F.submit_button.value = "Diagnostics";
	if ( type == "ping" ) 
		F.submit_type.value = "start_ping";
	else if ( type == "trace" ) 
	{
		F.submit_type.value = "start_traceroute";
		F.traceroute_ip.value = F.ping_ip.value;
//		F.traceroute_iface.value = F.ping_iface.value;
	}
	else if ( type == "lookup")
		F.submit_type.value = "start_lookup";
	F.change_action.value = "gozila_cgi";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function valid_value(F,type)
{
	if ( type == "lookup" ) 
	{
		document.getElementById("lookuptr").style.display="";
		clear_msg("lookup_name","msg_lookup");
		if ( F.lookup_name.value == "" )
		{
			my_alert(O_VAR,"lookup_name",__T(msg.notblank),"0","msg_lookup","down");
                        return false;
		}
                if ( !check_domain(F.lookup_name.value) )
		{
			my_alert(O_VAR,"lookup_name",__T(msg.validname),"0","msg_lookup","down");
			return false;
		}
		
	}else{
		document.getElementById("pingtr").style.display="";
		clear_msg("ping_ip","msg_ip");
		if ( F.ping_ip.value == "" )
		{
			my_alert(O_VAR,"ping_ip",__T(msg.notblank),"0","msg_ip","down");
			return false;
		}
		if ( test_ipv6(F.ping_ip.value) ) return true;
		if ( !check_ip_domain(F.ping_ip.value) )
		{
			my_alert(O_VAR,"ping_ip",__T(msg.ivalidipdomainformat),"0","msg_ip","down");
			return false;
		}
		if ( !lan_subnet_mask(F.ping_ip.value) ) 
		{
			my_alert(O_VAR,"ping_ip",__T(msg.illegalipformat),"0","msg_ip","down");
			return false;
		}
			
	}
	return true;
}

function clearmsg(td_id,obj_id,span_id)
{
	document.getElementById(td_id).style.display="none";
	clear_msg(obj_id,span_id);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=traceroute_ip>
<!--input type=hidden name=traceroute_iface-->
<input type=hidden name=commit value=0>
<input type=hidden name=ping_times value=3>
<input type=hidden name=ping_size value=64>
<input type=hidden name=wait_time value=4>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.networktools));</script></TR>
  <TR><TD colspan=2>
	<TABLE class=CONTENT_GROUP cellspacing=0>
	    	<TR><script>draw_td(O_GUI,FUNTITLE,__TC(mang.pingortrace),"colspan=2");</script></TR>
		<TR id=pingtr style=display:none><script>draw_td(O_GUI,SUBTITLE,"");</script>
                <span id=msg_ip></span></TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.ipdomain));</script>
		<input size=50 maxlength=64 name=ping_ip id=ping_ip aonChange=clearmsg("pingtr","ping_ip","msg_ip");>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com "+__T(share.or)+" fec0::10"));</script>
		<!--span id=msg_ip></span-->
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
			draw_object(O_GUI,BT,__T(mang.ping),"t1","BT","do_action(this.form,\"ping\")");
			draw_object(O_GUI,BT,__T(mang.trace),"t2","BT","do_action(this.form,\"trace\")");
		</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
	    	<TR><script>draw_td(O_GUI,FUNTITLE,__TC(mang.performdnslookup));</script></TR>
	    	<TR id=lookuptr style=display:none><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<span id=msg_lookup></span>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.internetname));</script>
		<input size=50 maxlength=64 name=lookup_name id=lookup_name aonChange=clearmsg("lookuptr","lookup_name","msg_lookup");>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"yahoo.com"));</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		draw_object(O_GUI,BT,__T(mang.lookup),"t3","BT","do_action(this.form,\"lookup\")");
		chg_layout();
		if( http_power == "r" ){
			choose_disable(document.getElementById("t1"));
			choose_disable(document.getElementById("t2"));
			choose_disable(document.getElementById("t3"));
		}
		</script>
		</TD></TR>
	</TABLE>
  </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
