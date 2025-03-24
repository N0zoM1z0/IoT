<html>
<head>
<% web_include_file("wizard_vpn/wizard_filelink.asp"); %>
<script language="JavaScript">

function BBB(st,pname,vpnidx,ptype,end_type,end_ip,nsen,ltype,lip,lmask,rtype,rip,rmask,spii,spio,mesp_type,mesp_in,mesp_out,mah_type,mah_in,mah_out,life_time,esp,ah,pfs_en,pfs_group,ipsec_ike)
{
	this.st=st;
	this.pname=pname;
	this.vpnidx=vpnidx;
	this.ptype=ptype;
	this.end_type=end_type;
	this.end_ip=end_ip;
	this.nsen=nsen;
	this.ltype=ltype;
	this.lip=lip;
	this.lmask=lmask;
	this.rtype=rtype;
	this.rip=rip;
	this.rmask=rmask;
	this.spii=spii;
	this.spio=spio;
	this.mesp_type=mesp_type;
	this.mesp_in=mesp_in;
	this.mesp_out=mesp_out;
	this.mah_type=mah_type;
	this.mah_in=mah_in;
	this.mah_out=mah_out;
	this.life_time=life_time;
	this.esp=esp;
	this.ah=ah;
	this.pfs_en=pfs_en;
	this.pfs_group=pfs_group;
	this.ipsec_ike=ipsec_ike;
}
var ike_name= new Array();
	<% get_ike_name(); %>
var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>

function init()
{
	var F = document.wz_welcome;
	def_nv = keep_val(F,""); 
	F.vpn_policy_name.value = parse_data("ipsec_name");
	F.remote_type[parse_data("ipsec_remote_etype")].selected = true;
	F.remote.value = parse_data("ipsec_remote_endpoint");
	
}
function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv, 2) ) 
	{
                my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
	}
        else 
                alert_result_GUI(1);
}

function chk_blank(F)
{
	w_clear_alert("msg_name",0,"vpn_policy_name");
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById("vpn_policy_name").value,0,"vpn_policy_name");
	if ( returnmsg != "" )   
	{
		w_set_alert("msg_name",0,"vpn_policy_name",returnmsg);
		return false;
	}
	for(var i=0; i<ipsec_entry.length; i++)
	{
		if ( document.getElementById("vpn_policy_name").value == ipsec_entry[i].pname ) 
		{
			w_set_alert("msg_name",0,"vpn_policy_name",__T(msg.nameexist));
			return false;
		}
	}
	for(var i=0; i<ike_name.length; i++)
	{
		if ( document.getElementById("vpn_policy_name").value == ike_name[i] )  
		{
			w_set_alert("msg_name",0,"vpn_policy_name",__T(msg.nameexist));
			return false;
		}
	}
	return true;
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
		top.location.href = goto_link("/default.asp");
}

function goto_prev(F)
{
	document.location.href=goto_link("index.asp");
}

function my_chk_fqdn(fqdn_val)
{
	w_clear_alert("msg_r",0,"remote");
	var ret_val = true;
	if ( fqdn_val.indexOf(".") == -1 ) 
	{
		var ret_msg = valid_hostname(fqdn_val);
	        if ( ret_msg != "" )
	        {
			w_set_alert("msg_r",0,"remote",__T(msg.validname));
	               	ret_val = false;
        	}
	}	
	else
	{
		if ( fqdn_val.indexOf("@") != -1 )
			fqdn_val = fqdn_val.replace("@",".");
		if(check_domain(fqdn_val) == false)
		{
			w_set_alert("msg_r",0,"remote",__T(msg.validname));
			ret_val = false;
		}
	}
	
	return ret_val;	
}


function chk_fqdn_ip(F)
{
	w_clear_alert("msg_r",0,"remote");
	if ( F.remote_type.value == "0" ) 
	{
		if ( check_ipv4(F.remote.value,VALID_IP_RULE1,ZERO_NO) != PASS )
		{
			w_set_alert("msg_r",0,"remote",__T(msg.ivalidipformat));
        		return false;
		}
	}else{
		return my_chk_fqdn(document.getElementById("remote").value);
	}
	return true;
}

function valid_value(F)
{
	if ( !chk_blank(F) ) return false;
	if ( !chk_fqdn_ip(F) ) return false;
	return true;
}

function goto_next(F)
{
	if ( !valid_value(F) ) return false;
	save_data("ipsec_name", F.vpn_policy_name.value); 
	save_data("ipsec_remote_etype", F.remote_type.value); 
	save_data("ipsec_remote_endpoint", F.remote.value); 
	document.location.href=goto_link("lr_network.asp");
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
	 <TR><TD class=DATA_TITLE colspan=6><script>Capture(g_start.vpnpeerset);</script></TD></TR>
    	 <TR><TD colspan=6 valign=top>
    	 <TABLE >
	 <TR><TD valign=top class=DATA_ITEM><script>Capture(vpn.policyconfig);</script></TD></TR>
	 <TR><TD valign=top class=DATA_ITEM>
	 <TABLE><TR><TD><script>CaptureC(wl.profilename);</script></TD><TD><input size=20 maxlength=32 id=vpn_policy_name name=vpn_policy_name onblur=chk_blank(this.form)><span id=msg_name></span></TD></TR>
		<TR><TD><script>CaptureC(vpn.remoteeptype);</script></TD><TD>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
                var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"remote_type","",_name,_val,"");
		</script>
		</TD></TR>
		<TR>
		<TD><script>CaptureC(vpn.remoteep);</script></TD>
		<TD><input size=20 maxlength=255 name=remote id=remote onblur=chk_fqdn_ip(this.form)><span id=msg_r></span></TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE></TD></TR>
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
