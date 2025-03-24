<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function AAA(id,pname,emode,lid,rid,encrypt,auth,dh,ikeidx)
{
	this.id=id;
	this.pname = pname;
	this.emode = emode;
	this.lid=lid;
	this.rid=rid;
	this.encrypt=encrypt;
	this.auth=auth;
	this.dh=dh;
	this.ikeidx=ikeidx;
}

function BBB(st,pname,ptype,ltype,rtype,i_int,enc,ipsec_ike,vpnidx)
{
	this.st=st;
	this.pname=pname;
	this.ptype=ptype;
	this.ltype=ltype;
	this.rtype=rtype;
	this.i_int=i_int;
	this.enc=enc;
	this.ipsec_ike=ipsec_ike;
	this.vpnidx=vpnidx;
}

var ike_idx=0;
//var ike_stflg="init";
var ipsec_idx=0;
//var ipsec_stflg="init";

var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","AAA"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>

//var back_bt = "true";
function to_back(F)
{
	parent.document.getElementById("newpage").value = "vpn_adv.asp";
	uiDoCancel(F);
}

function init()
{
	var F = document.frmvpn;
	parent.document.getElementById("save_bg").style.display="none";
	choose_disable(F.ike_local_ip);
	for(var i=0; i<ike_entry.length; i++)
	{
		ike_idx++;
	}
	for(var i=0; i<ipsec_entry.length; i++)
	{
		ipsec_idx++;
	}
}

function chk_ip(obj_id)
{
	var F = document.frmvpn;
	clear_msg(obj_id,"msg_"+obj_id);

	if ( obj_id.indexOf("subnet") != -1 ) 
	{
		if ( !valid_mask(F,obj_id,ZERO_NO,"msg_"+obj_id) ) return false;
	}else{
		if ( ( obj_id.indexOf("local")!= -1) || ( obj_id.indexOf("remote")!= -1))
		{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE3,MASK_OK) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
			
		}else{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE1,MASK_NO) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
		}
	}
	return true;
}

function chk_psk(F)
{
	clear_msg("ike_psk","msg_ike_psk");
	/*
	if ( chk_chartype(document.getElementById("ike_psk").value,ISCHAR) == FAIL ) 
	{
		my_alert(O_VAR,"ike_psk",__T(msg.hostnameformat1),"0","msg_ike_psk");
		return false;	
	}*/

	if ( F.ike_psk.value.length < 8 ) 
	{
		my_alert(O_VAR,"ike_psk",__T(vpn.errkeymsg),"0","msg_ike_psk");
		return false;
	}
	return true;
}

function chk_blank(obj_id)
{
	//var F = document.frmvpn;
	clear_msg(obj_id,"msg_"+obj_id);
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id).value,ZERO_NO,obj_id);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,obj_id,returnmsg,"0","msg_"+obj_id);
	        return false;	
	}
	return true;
}

function before_check(F)
{
	var errflg = 0;
	var i = 0;

	if ( !chk_blank("vpn_policy_name") ) errflg++;
	if (!chk_psk(F)) errflg++;

	if (!chk_fqdn_ip() ) errflg++;
	if(!chk_ip("ipsec_remote_start") || !chk_ip("ipsec_remote_subnet")) errflg++;
	if(!chk_ip("ipsec_local_start") || !chk_ip("ipsec_local_subnet")) errflg++;
	if ( F.ipsec_endpoint_type[1].selected == true )
	{
		if(!chk_ip("ike_rip") || !chk_ip("ike_lip")) errflg++;
	}
	
	for(var i=0; i<ike_entry.length; i++)
	{
		if (ike_entry[i].pname == F.vpn_policy_name.value ) 
		{
			my_alert(O_VAR,"vpn_policy_name",__T(msg.nameexist),"0","msg_vpn_policy_name");
			errflg++;
			return false;
		}
	}
	for(var i=0; i<ipsec_entry.length; i++)
        {
                if ( ipsec_entry[i].pname == F.vpn_policy_name.value )
                {
                        my_alert(O_VAR,"vpn_policy_name",__T(msg.nameexist),"0","msg_vpn_policy_name");
                        errflg++;
                }
	}
	if ( errflg > 0 ) return false;
	return true;
		
}

function uiDoSave(F)
{
	if( (ipsec_idx >= IPSEC_ENTRY) || (ike_idx >= IPSEC_ENTRY))
	{
		my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(vpn.savewarnmsg),"alert_vpnresult_GUI(1)","alert_vpnresult_GUI(0)","","yesno");	
	}
	else
		alert_vpnresult_GUI(1);

/*
	if ( ipsec_idx >= IPSEC_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,IPSEC_ENTRY,__T(vpn.policy)),"");
                return false;   
        }

	if ( ike_idx >= IKE_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,IKE_ENTRY,__T(vpn.ikepolicy)),"");
                return false;   
	}
*/ 
}

function alert_vpnresult_GUI(val)
{
	var F = document.forms[0];
        alert_result(0);
	if( http_power == "r") return;
	if(val == 0)
	{
		change_cancel_bt="true";
		get_position("vpn_adv.asp",1);
		goto_page("vpn_adv.asp");
	}
	else
	{
		if ( !before_check(F) ) return false;
	
		get_position("vpn_adv.asp",1);
		F.ike_selidx.value = ike_idx;
		F.ipsec_selidx.value = ipsec_idx;
		F.gui_action.value = "Apply";
		F.submit_button.value="vpn_adv";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
	
}

function chk_fqdn_ip()
{
	clear_msg("ipsec_endpoint_value","msg_ipsec_endpoint_value");
	if ( document.getElementById("ipsec_endpoint_type").selectedIndex == 0 ) 
	{
		if ( check_ipv4(document.getElementById("ipsec_endpoint_value").value,VALID_IP_RULE7,MASK_OK) != PASS )
		{
			my_alert(O_VAR,"ipsec_endpoint_value",__T(msg.ivalidipformat),"0","msg_ipsec_endpoint_value");
			return false;
		}
		return true;
	}
	else
	{
		return chk_fqdn(document.getElementById("ipsec_endpoint_value").value,"ipsec_endpoint_value");	
	}
}

function sel_endport_type(F)
{
	if ( F.ipsec_endpoint_type[0].selected == true ) 
	{
		HIDDEN_PART("TR","trlip","trrip",1);
	}else{
		HIDDEN_PART("TR","trlip","trrip",0);
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmvpn method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ike_selidx> 
<!--input type=hidden name=ike_stflg--> 
<input type=hidden name=ipsec_selidx> 
<!--input type=hidden name=ipsec_stflg--> 
<input type=hidden name=page value=vpn_basic> 
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.basicvpnsetup),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.abvpnsetup),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(vpn.basicmsg),"colspan=2");</script>
		</TR>	
		<TR><TD class=SUBTITLE colspan=2>
		<script>
	        draw_object(O_GUI,BT,__T(vpn.viewdfset),"t1","BT","goto_page(\"vpn_basic_view.asp\")");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.connnamerip),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.newconnname));</script>
		<input name=vpn_policy_name id=vpn_policy_name size=20 maxlength=32 onblur=chk_blank("vpn_policy_name")>
		<span id=msg_vpn_policy_name></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.preskey));</script>
                <input name=ike_psk id=ike_psk size=20 maxlength=49 onblur=chk_psk(this.form)>
		<span id=msg_ike_psk></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.endpoinginfo),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteep));</script>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
                var _val = new Array("0","1");
                draw_object(O_GUI,SELBOX,"ipsec_endpoint_type","id=ipsec_endpoint_type onchange=sel_endport_type(this.form)",_name,_val);
                </script>
                </TD></TR>
		<TR id=trlip style="display:none"><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.localident));</script>
                <input name=ike_lip id=ike_lip size=20 maxlength=15 onblur=chk_ip("ike_lip")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "));</script>
		<span id=msg_ike_lip></span>
		</TD></TR>
		<TR id=trrip style="display:none"><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteident));</script>
                <input name=ike_rip id=ike_rip size=20 maxlength=15 onblur=chk_ip("ike_rip")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "));</script>
		<span id=msg_ike_rip></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remotewanip));</script>
                <input name=ipsec_endpoint_value id=ipsec_endpoint_value size=20 maxlength=255 onblur=chk_fqdn_ip()>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com"));</script>
		<span id=msg_ipsec_endpoint_value></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.secureconnracc),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remotelanip));</script>
		<input name=ipsec_remote_start id=ipsec_remote_start size=20 maxlength=15 onblur=chk_ip("ipsec_remote_start");cal_submask(this.from,"ipsec_remote_start","ipsec_remote_subnet","4");>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
		<span id=msg_ipsec_remote_start></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remotelanmask));</script>
		<input name=ipsec_remote_subnet id=ipsec_remote_subnet size=20 maxlength=15 onblur=chk_ip("ipsec_remote_subnet")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));</script>
		<span id=msg_ipsec_remote_subnet></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.locallanip));</script>
		<input name=ipsec_local_start id=ipsec_local_start size=20 maxlength=15 onblur=chk_ip("ipsec_local_start");cal_submask(this.from,"ipsec_local_start","ipsec_local_subnet","4");>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
		<span id=msg_ipsec_local_start></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.locallanmask),SPACE_DOWN,SPACE_DOWN);</script>
		<input name=ipsec_local_subnet id=ipsec_local_subnet size=20 maxlength=15 onblur=chk_ip("ipsec_local_subnet")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));</script>
		<span id=msg_ipsec_local_subnet></span>
		</TD></TR>	
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
