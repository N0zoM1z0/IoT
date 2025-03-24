<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_guide()
{
	window.showModalDialog(goto_link('guide_conn_type.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:360px;dialogHeight:385px;center:yes;');
	
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

function init()
{
	var F = document.wz_cfg;
	var static_ip = parse_data("wan_ipaddr").split(".");
	var static_mask = parse_data("wan_netmask").split(".");
	var static_gw = parse_data("wan_gateway").split(".");
	var static_dns = parse_data("wan_dns").split(" ");
	var dns1="",dns2="";
	//alert("static_dns="+static_dns+";wan_dns="+parse_data("wan_dns"));
	for(var i=0; i<static_dns.length; i++)
	{
		if ( static_dns[i] != "..." )
		{
			if ( i == 0 )  
				dns1 = static_dns[0].split(".");
			else
				dns2 = static_dns[1].split(".");
		}
	}
	for(var i=0; i<static_ip.length; i++)
		eval("F.ip_"+i).value = static_ip[i];
	for(var i=0; i<static_mask.length; i++)
		eval("F.mask_"+i).value = static_mask[i];
	for(var i=0; i<static_gw.length; i++)
		eval("F.gw_"+i).value = static_gw[i];
	if ( static_dns.length >= 1 ) 
	{
		for(var i=0; i<dns1.length; i++)
			eval("F.dns_"+i).value = dns1[i];
	}
	if ( static_dns.length == 2 ) 
	{
		for(var i=0; i<dns2.length; i++)
			eval("F.dns2_"+i).value = dns2[i];
	}
	def_nv = keep_val(F,"");
}

function goto_next(F)
{
	if ( !before_valid(F) ) return false;
	var ip="",mask="",gw="",dns="",dns2="",alldns="";
	for(var i=0; i<4; i++)
	{
		if ( i > 0 ) ip+=".";
		ip += eval("F.ip_"+i).value;
		if ( i > 0 ) mask+=".";
		mask += eval("F.mask_"+i).value;
		if ( i > 0 ) gw+=".";
		gw += eval("F.gw_"+i).value;
		if ( i > 0 ) dns+=".";
		dns += eval("F.dns_"+i).value;
		if ( i > 0 ) dns2+=".";
		dns2 += eval("F.dns2_"+i).value;
	}
	alldns=dns+" "+dns2;	
	save_data("wan_ipaddr",ip);
	save_data("wan_netmask",mask);
	save_data("wan_gateway",gw);
	save_data("wan_dns",alldns);
	
        document.location.href=goto_link("config_4.asp");
}

function before_valid(F)
{
	var errflg=0;
	var tmp_ip, tmp_mask;
	var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
	if ( !w_valid_ip("IP","ip",VALID_IP_RULE7,"msg_ip",ZERO_NO) ) errflg=1;
	if ( !w_valid_ip("IP","gw",VALID_IP_RULE7,"msg_gw",ZERO_NO) )errflg=1;
	if ( !w_valid_ip("IP","dns",VALID_IP_RULE7,"msg_dns",ZERO_OK) )errflg=1;
	if ( !w_valid_ip("IP","dns2",VALID_IP_RULE7,"msg_dns2",ZERO_OK) )errflg=1;
	if ( !w_valid_mask("mask",ZERO_NO|BCST_NO,"msg_mask"))errflg=1;
	if ( errflg == 0 ) 
	{
		for(var i=0; i<4; i++)
		{
			if ( i > 0 ) tmp_ip+=".";
			tmp_ip+=document.getElementById("ip_"+i).value;
			if ( i > 0 ) tmp_mask+=".";
			tmp_mask+=document.getElementById("mask_"+i).value;
		}	
		if ( valid_subnet(tmp_ip,tmp_mask,lan_ip) )
		{
			w_set_alert("msg_ip",4,"ip",__T(msg.subnet1));	
			errflg=1;
		} 
		if ( errflg==0 && !valid_ip_gw(F,"F.ip","F.mask","F.gw") ){ 
			w_set_alert("msg_ip",4,"ip",__T(msg.subnet2));	
			w_set_alert("msg_gw",4,"gw","");	
//			w_set_alert("msg_gw",4,"gw",__T(msg.subnet2));	
			errflg=1;
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function w_chk_ip_type(ip_type)
{
	if ( ip_type == "ip" ) 
	{
		w_clear_alert("msg_ip",4,"ip");
		if ( !w_valid_ip("IP","ip",VALID_IP_RULE7,"msg_ip",ZERO_NO) ) return false;
	}else if ( ip_type == "gw" )
	{	
		w_clear_alert("msg_gw",4,"gw");
		if ( !w_valid_ip("IP","gw",VALID_IP_RULE7,"msg_gw",ZERO_NO) ) return false;
	}else if ( ip_type == "dns" ) 
	{
		w_clear_alert("msg_dns",4,"dns");
		if ( !w_valid_ip("IP","dns",VALID_IP_RULE7,"msg_dns",ZERO_OK) ) return false;
	}else if ( ip_type == "dns2" )
	{ 
		w_clear_alert("msg_dns2",4,"dns2");
		if ( !w_valid_ip("IP","dns2",VALID_IP_RULE7,"msg_dns2",ZERO_OK) ) return false;
	}else if ( ip_type == "mask" ) 
	{
		w_clear_alert("msg_mask",4,"mask");
		if ( !w_valid_mask("mask",ZERO_NO|BCST_NO,"msg_mask")) return false;
	}
	return true;
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
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setstatic);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.setupinfo);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM2>
    <TABLE>
           <TR><TD><script>Capture(wan.stipaddr);</script></TD>
           <TD><input size=1 maxlength=3 name=ip_0 id=ip_0>
           <input size=1 maxlength=3 name=ip_1 id=ip_1>
           <input size=1 maxlength=3 name=ip_2 id=ip_2>
           <input size=1 maxlength=3 name=ip_3 id=ip_3 onblur=w_chk_ip_type("ip")>
	   <SPAN id=msg_ip></SPAN>
	   </TD></TR>
	   <TR><TD><script>Capture(wan.mask);</script></TD>
           <TD><input size=1 maxlength=3 name=mask_0 id=mask_0>
           <input size=1 maxlength=3 name=mask_1 id=mask_1>
           <input size=1 maxlength=3 name=mask_2 id=mask_2>
           <input size=1 maxlength=3 name=mask_3 id=mask_3 onblur=w_chk_ip_type("mask")>
	   <SPAN id=msg_mask></SPAN>
           </TD></TR>
           <TR><TD><script>Capture(wz.gwip);</script></TD>
           <TD><input size=1 maxlength=3 name=gw_0 id=gw_0>
           <input size=1 maxlength=3 name=gw_1 id=gw_1>
           <input size=1 maxlength=3 name=gw_2 id=gw_2>
           <input size=1 maxlength=3 name=gw_3 id=gw_3 onblur=w_chk_ip_type("gw")>
	   <SPAN id=msg_gw></SPAN>
           </TD></TR>
           <TR><TD><script>Capture(wz.dns);</script></TD>
           <TD><input size=1 maxlength=3 name=dns_0 id=dns_0>
           <input size=1 maxlength=3 name=dns_1 id=dns_1>
           <input size=1 maxlength=3 name=dns_2 id=dns_2>
           <input size=1 maxlength=3 name=dns_3 id=dns_3 onblur=w_chk_ip_type("dns")>
	   <SPAN id=msg_dns></SPAN>
           </TD></TR>
	   <TR><TD><script>Capture(wz.dns2);</script></TD>
           <TD><input size=1 maxlength=3 name=dns2_0 id=dns2_0>
           <input size=1 maxlength=3 name=dns2_1 id=dns2_1>
           <input size=1 maxlength=3 name=dns2_2 id=dns2_2>
           <input size=1 maxlength=3 name=dns2_3 id=dns2_3 onblur=w_chk_ip_type("dns2")>
	   <SPAN id=msg_dns2></SPAN>
           </TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD class=DATA_ITEM>
    <script>Capture(wz.contactisp);</script>
    </TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"config_2.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
