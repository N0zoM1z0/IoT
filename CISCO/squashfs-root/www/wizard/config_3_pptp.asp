<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">

function uiDoCancel(F)
{
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	go_page(aging_time,"<% nvram_get("getting_start"); %>");
}

function init()
{
	var F = document.wz_cfg;
	var pptp_name = parse_data("ppp_username");
	var pptp_pwd = parse_data("ppp_passwd");
	var pptp_ip = parse_data("wan_ipaddr").split(".");
	var pptp_mask = parse_data("wan_netmask").split(".");
	var pptp_gw = parse_data("wan_gateway").split(".");
	var pptp_sip = parse_data("pptp_server_ip").split(".");
	F.accname.value = pptp_name;
	F.pwd.value = pptp_pwd;
	for(var i=0; i<pptp_ip.length; i++)
		eval("F.ip_"+i).value = pptp_ip[i];
	for(var i=0; i<pptp_mask.length; i++)
		eval("F.mask_"+i).value = pptp_mask[i];
	for(var i=0; i<pptp_gw.length; i++)
		eval("F.gw_"+i).value = pptp_gw[i];
	for(var i=0; i<pptp_sip.length; i++)
		eval("F.sip_"+i).value = pptp_sip[i];
}

function w_chk_name(F)
{
        w_clear_alert("msg_accname",0,"accname");
        if ( F.accname.value == "" ) 
        {
                w_set_alert("msg_accname",0,"accname",__T(msg.notblank),"down");        
		return false;
        }
	return true;
}

function w_chk_pwd(F)
{
        w_clear_alert("msg_pwd",0,"pwd");
        if ( F.pwd.value == "" )
        {
                w_set_alert("msg_pwd",0,"pwd",__T(msg.notblank),"down");        
		return false;
        }
	return true;
}

function w_chk_ip_type(type_id)
{
	if ( type_id == "ip" )  
	{
        	w_clear_alert("msg_ip",4,"ip");
	        if ( !w_valid_ip("IP","ip",VALID_IP_RULE7,"msg_ip",ZERO_NO,"down") )
			return false;
	}else if ( type_id == "gw" ) 
	{
        	w_clear_alert("msg_gw",4,"gw");
        	if ( !w_valid_ip("IP","gw",VALID_IP_RULE7,"msg_gw",ZERO_NO,"down") )
			return false;
	}else if ( type_id == "sip" ) 
	{
        	w_clear_alert("msg_sip",4,"sip");
        	if ( !w_valid_ip("IP","sip",VALID_IP_RULE7,"msg_sip",ZERO_NO,"down") ) 
			return false;
	}else if ( type_id == "mask") 
	{
        	w_clear_alert("msg_mask",4,"mask");
        	if ( !w_valid_mask("mask",ZERO_NO|BCST_NO,"msg_mask","down"))
			return false;
	}
	return true;
}

function goto_next(F)
{
	if ( !pptp_l2tp_valid(F))return false;
	save_data("ppp_username",F.accname.value);
	save_data("ppp_passwd",F.pwd.value);
	var ip="",mask="",gw="",sip="";
	for(var i=0; i<4; i++)
	{
		if ( i > 0 ) ip+=".";
		ip+=eval("F.ip_"+i).value;
		if ( i > 0 ) mask+=".";
		mask+=eval("F.mask_"+i).value;
		if ( i > 0 ) gw+=".";
		gw+=eval("F.gw_"+i).value;
		if ( i > 0 ) sip+=".";
		sip+=eval("F.sip_"+i).value;
	}
	save_data("wan_ipaddr",ip);
	save_data("wan_netmask", mask);
	save_data("wan_gateway", gw);
	save_data("pptp_server_ip", sip);
	document.location.href=goto_link("config_4.asp");
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
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setpptp);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.setpptpmsg);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM><script>Capture(wz.ispnet);</script></TD></TR>
    <TR><TD valign=top class=DATA_ITEM>
    <TABLE width=100% height=100%>
	   <col width=17%><col width=33%><col width=17%><col width=33%>
           <TR><TD><script>Capture(wz.accountname);</script></TD><TD><span id=msg_accname></span><input size=19 name=accname id=accname maxlength=63 onblur=w_chk_name(this.form)></TD>
		<TD><script>Capture(wan.stipaddr);</script></TD>
           <TD>
	   <span id=msg_ip></span>
           <input size=1 maxlength=3 name=ip_0 id=ip_0>
           <input size=1 maxlength=3 name=ip_1 id=ip_1>
           <input size=1 maxlength=3 name=ip_2 id=ip_2>
           <input size=1 maxlength=3 name=ip_3 id=ip_3 onblur=w_chk_ip_type("ip")>
           </TD>
           </TR>
           <TR><TD><script>Capture(share.password);</script></TD><TD><span id=msg_pwd></span><input size=19 name=pwd id=pwd type=password maxlength=63 onblur=w_chk_pwd(this.form)></TD>
           <TD><script>Capture(wan.mask);</script></TD>
           <TD>
	   <div><span id=msg_mask></span></div>
           <input size=1 maxlength=3 name=mask_0 id=mask_0>
           <input size=1 maxlength=3 name=mask_1 id=mask_1>
           <input size=1 maxlength=3 name=mask_2 id=mask_2>
           <input size=1 maxlength=3 name=mask_3 id=mask_3 onblur=w_chk_ip_type("mask")>
           </TD>
           </TR>
           <TR><TD><script>Capture(wz.confirmpwd);</script></TD><TD><input size=19 name=cf_pwd type=password maxlength=63></TD>
           <TD><script>Capture(wz.gwip);</script></TD>
           <TD>
	   <span id=msg_gw></span>
           <input size=1 maxlength=3 name=gw_0 id=gw_0>
           <input size=1 maxlength=3 name=gw_1 id=gw_1>
           <input size=1 maxlength=3 name=gw_2 id=gw_2>
           <input size=1 maxlength=3 name=gw_3 id=gw_3 onblur=w_chk_ip_type("gw")>
           </TD> 
           </TR>
	   
           <TR><TD colspan=2></TD>
	   <TD><script>Capture(wz.serveripaddr);</script></TD><TD>
	   <span id=msg_sip></span>
	   <input size=1 maxlength=3 name=sip_0 id=sip_0>
           <input size=1 maxlength=3 name=sip_1 id=sip_1>
           <input size=1 maxlength=3 name=sip_2 id=sip_2>
           <input size=1 maxlength=3 name=sip_3 id=sip_3 onblur=w_chk_ip_type("sip")>
           </TD>
           </TR>
    </TABLE>
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
