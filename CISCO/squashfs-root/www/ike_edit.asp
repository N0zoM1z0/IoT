<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var encrypt_val= new Array("des","3des","aes128","aes192","aes256");
//var auth_val= new Array("md5","sha1","sha2_256","sha2_384","sha2_512");
var auth_val= new Array("md5","sha1","sha2_256");
var dh_val= new Array("modp768","modp1024","modp1536");
//var auth_method_val= new Array("psk","cert");
var auth_method_val= new Array("0","1");
var sidx="<% nvram_gozila_get("ike_selidx"); %>";
if ( sidx == "" ) sidx="0";
if ( parseInt(sidx,10) > 0 ) sidx = parseInt(parseInt(sidx,10),10);
var change_cancel_bt="true";
var back_bt="true";

function AAA(kid,pname,lid_type,lid,rid_type,rid,emode,esp,ah,psk,dh,sa_life,dpden,dpddelay,dpdtimeout,auth_method,changeable)
{
	this.kid=kid;
	this.pname = pname;
	this.lid_type = lid_type;
	this.lid = lid;
	this.rid_type = rid_type;
	this.rid = rid;
	this.emode = emode;
	this.esp = esp;
	this.ah = ah;
	this.psk = psk;
	this.dh = dh;
	this.sa_life = sa_life;
	this.dpden = dpden;
	this.dpddelay = dpddelay;
	this.dpdtimeout = dpdtimeout;
	this.auth_method= auth_method;
	this.changeable=changeable;
}

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

var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","AAA"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>

var back_bt = "true";
function refresh_page()
{
	alert_result(0);
	var F = document.frmike;
	choose_disable(F.next_page);
	F.submit_button.value = "ike_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}
function to_back(F)
{
	parent.document.getElementById("newpage").value = "vpn_adv.asp";
	uiDoCancel(F);
}
	
var idx = 0;

function init()
{
	var F = document.frmike;
	var idx = 0;

	choose_disable(F.ike_dpd_delay);
	choose_disable(F.ike_dpd_timeout);
	choose_disable(F.ike_xauth_name);
	choose_disable(F.ike_xauth_pass);
	//choose_disable(F.ike_local_id);
	//choose_disable(F.ike_remote_id);
	if ( F.stflg.value == "edit" ) 
	{
		for(var i=0; i<ike_entry.length; i++)
		{
			if(ike_entry[i].kid == sidx)
			{
				idx = i;
				break;
			}
			else
				idx = 0;
		}
		choose_disable(F.ike_policy_name);
		F.ike_policy_name.value = ike_entry[idx].pname;
		if ( ike_entry[idx].emode == "main" ) 
			F.ike_exchange_mode[0].selected = true;
		else
			F.ike_exchange_mode[1].selected = true;
		F.localtype.selectedIndex = parseInt(ike_entry[idx].lid_type,10);
		if ( ike_entry[idx].lid_type != "0" ) 
			F.local.value = ike_entry[idx].lid;
		F.remotetype.selectedIndex = parseInt(ike_entry[idx].rid_type,10);
		if ( ike_entry[idx].rid_type != "0" ) 
			F.remote.value = ike_entry[idx].rid;
		for(var i=0; i<encrypt_val.length; i++)
		{
			if ( ike_entry[idx].esp == encrypt_val[i] )
			{
				F.ike_encrypt_algo.selectedIndex = i;
				break;
			}
		}
		for(var i=0; i<auth_val.length; i++)
		{
			if ( ike_entry[idx].ah == auth_val[i] )
			{
				F.ike_auth_algo.selectedIndex = i;
				break;
			}
		}
		for(var i=0; i<auth_method_val.length; i++)
		{
			if ( ike_entry[idx].auth_method == auth_method_val[i] ){ 
				F.ike_auth_method.selectedIndex = i;
				break;
			}
		}
		if ( ike_entry[idx].psk == "" ){ 
			choose_disable(F.ike_psk);
		}else
			F.ike_psk.value = cy_speccode_decode(ike_entry[idx].psk);		
		
		F.ike_sa_life.value = ike_entry[idx].sa_life;
		if ( ike_entry[idx].dpden == "1" ) 
		{
			F.ike_dpd_enable.checked = true;
			F.ike_dpd_delay.value = ike_entry[idx].dpddelay;
			F.ike_dpd_timeout.value = ike_entry[idx].dpdtimeout;
		}
		/*
		//F.ike_xauth_type.selectedIndex =  parseInt(ike_entry[idx].xtype,10);
		if ( ike_entry[idx].xtype == "1" )
		{
			F._ike_xauth_type.checked = true;
			F._ike_xauth_type.value = "1";
		}
		else
		{
			F._ike_xauth_type.checked = false;
			F.ike_xauth_type.value = "0";
		}
		//if("<% nvram_match("ike_xauth_type", "1", "1");%>" == "1")
		//{
		//	F.ike_xauth_name.value = ike_entry[idx].xname;
		//	F.ike_xauth_pass.value = ike_entry[idx].xpass;
		//}
		
		F.ike_xauth_name.value = ike_entry[idx].xname;
		F.ike_xauth_pass.value = ike_entry[idx].xpass;

		sel_authtype(F);
		*/	
		for(var i=0; i<dh_val.length; i++)
		{
			if ( ike_entry[idx].dh == dh_val[i] )
			{
				F.ike_dh_group.selectedIndex = i;
				break;
			}
		}
		
	}
	else
	{
		F.ike_encrypt_algo.selectedIndex = 2;
		F.ike_auth_algo.selectedIndex = 1;
		F.ike_dpd_enable.checked = false;
	}
	chk_dpd(F);
	chg_local(F);
	chg_remote(F);
	default_nv = keep_val(F,"");
}

function sel_ltype(F)
{
	if ( F.ltype.selectedIndex == 0 ) 
		choose_disable(F.ike_local_id);
	else
		choose_enable(F.ike_local_id);
}

function sel_rtype(F)
{
	if ( F.rtype.selectedIndex == 0 ) 
		choose_disable(F.ike_remote_id);
	else
		choose_enable(F.ike_remote_id);
}
function sel_psk(F)
{
	if ( F.ike_auth_method.selectedIndex == 1 ) 
	{
		clear_msg("ike_psk","msg_ike_psk");
		choose_disable(F.ike_psk);
	}
	else
		choose_enable(F.ike_psk);
}
function chk_dpd(F)
{
	if ( F.ike_dpd_enable.checked ) 
	{
		choose_enable(F.ike_dpd_delay);
		choose_enable(F.ike_dpd_timeout);
	}else{
		choose_disable(F.ike_dpd_delay);
		choose_disable(F.ike_dpd_timeout);
	}
}
/*
function sel_authtype(F)
{
	//if ( F.ike_xauth_type.selectedIndex == 1 ) 
	if ( F._ike_xauth_type.checked == false ) 
	{
		choose_disable(F.ike_xauth_name);
		choose_disable(F.ike_xauth_pass);
	}else{
		choose_enable(F.ike_xauth_name);
		choose_enable(F.ike_xauth_pass);
	}
}
*/
function chk_ip(obj_id)
{
	var F = document.frmike;
	clear_msg(obj_id,"msg_"+obj_id);
	/*
	if ( F.localtype.selectedIndex == 4 ) 
	{
		if ( document.getElementById(obj_id).value.indexOf("\"") != -1 ||
		     document.getElementById(obj_id).value.indexOf("\'") != -1 ||
		     document.getElementById(obj_id).value.indexOf(" ") != -1 )
		{
			my_alert(O_VAR,obj_id,__T(msg.validname),"0","msg_"+obj_id);
			return false;
		}
	}*/
	var typeobj = document.getElementById(obj_id+'type');
	if ( typeobj && typeobj.selectedIndex == 1 && check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE7,MASK_NO) != PASS )
	{
		my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
		return false;
	}
	return true;
}

function chk_psk(F)
{
	clear_msg("ike_psk","msg_ike_psk");
	/*
	if ( chk_chartype(document.getElementById("ike_psk").value, ISCHAR) == FAIL ) 
	{
		my_alert(O_VAR,"ike_psk",__T(msg.hostnameformat1),"0","msg_ike_psk");
		return false;	
	}*/
	if ( F.ike_auth_method.selectedIndex == 1 ) return true;
	if ( F.ike_psk.value.length < 8 ) 
	{
		my_alert(O_VAR,"ike_psk",__T(vpn.errkeymsg),"0","msg_ike_psk");
		return false;
	}
	return true;
}

function chk_name(obj_id)
{
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
	var errflg = 0 ;
	if ( !chk_name("ike_policy_name") ) errflg++;
	if ( !chk_ip("local") ) errflg++;
	if ( !chk_ip("remote") ) errflg++;
	if ( F.ike_auth_method.selectedIndex == 0 && !chk_psk(F) ) errflg++;
	if (!chk_psk(F)) errflg++;
	if ( !msg_chk_range(F.ike_sa_life.value,"ike_sa_life",30,86400,10,IS_FIELD,0,"msg_ike_sa_life")) errflg++;
	if ( F.ike_dpd_enable.checked )
	{
		if ( !msg_chk_range(F.ike_dpd_delay.value,"ike_dpd_delay",10,999,10,IS_FIELD,0,"msg_ike_dpd_delay")) errflg++;
		if ( !msg_chk_range(F.ike_dpd_timeout.value,"ike_dpd_timeout",30,1000,10,IS_FIELD,0,"msg_ike_dpd_timeout")) errflg++;
		if ( parseInt(F.ike_dpd_timeout.value,10) < parseInt(F.ike_dpd_delay.value,10) )
		{
			my_alert(O_VAR,"ike_dpd_timeout",__T(vpn.dpdmsg),"0","msg_ike_dpd_timeout");
			errflg++;
		}
	}
	if (  F.stflg.value=="edit" && ike_entry[idx].changeable == "0" && 
	     ( F.localtype.selectedIndex == 0 || F.remotetype.selectedIndex == 0 ) ) 
	{
                my_alert(O_GUI,INFO,__T(share.info),__T(vpn.ikemsg),"alert_result(0)");
		errflg++;	
	}
	if ( F.ike_exchange_mode.selectedIndex == 1 ) //Aggressive mode
	{
		if ( F.ike_auth_method.selectedIndex == 1 ) //RSA-Signature
		{
			my_alert(O_VAR,"ike_auth_method",__T(vpn.notsupportrsa),"0","msg_ike_auth_method");
			errflg++;
		}
	}
	var tmplist = new Array("remote","local");
	for(var i=0; i<2; i++)
	{
		if ( F.ike_auth_method.selectedIndex == 0 && eval("F."+tmplist[i]+"type").selectedIndex == 4 ) 
		{
			if ( eval("F."+tmplist[i]).value.indexOf("\"") != -1 || 
                             eval("F."+tmplist[i]).value.indexOf("\'") != -1 || 
			     eval("F."+tmplist[i]).value.indexOf(" ") != -1 )
			{
				my_alert(O_VAR,tmplist[i],__T(msg.validname),"0","msg_"+tmplist[i]);
				errflg++;
			}
		} 
		else if ( F.ike_auth_method.selectedIndex == 1 && eval("F."+tmplist[i]+"type").selectedIndex == 4 ) 
		{
			if ( eval("F."+tmplist[i]).value.indexOf("\"") != -1 || 
                             eval("F."+tmplist[i]).value.indexOf("\'") != -1 )
			{
				my_alert(O_VAR,tmplist[i],__T(msg.validname),"0","msg_"+tmplist[i]);
				errflg++;
			}
		} 
	}
	for(var i=0; i<ike_entry.length; i++)
	{
		if ( F.stflg.value=="edit" && i == sidx ) continue;
		if ((F.stflg.value!="edit") && (ike_entry[i].pname == F.ike_policy_name.value )) 
		{
			my_alert(O_VAR,"ike_policy_name",__T(msg.nameexist),"0","msg_ike_policy_name");
			errflg++;
		}
	}
	/*
	if ( F._ike_xauth_type.checked == true ) 
	{
		if ( !chk_blank("ike_xauth_name") ) errflg++;
		if ( !chk_blank("ike_xauth_pass") ) errflg++;
		F.ike_xauth_type.value = "1";
	}
	else
		F.ike_xauth_type.value = "0";
	*/
	if ( errflg > 0 ) return false;
	return true;
		
}

var reboot_flg = "<% get_reboot_flag("vpn"); %>";

function uiDoSave(F)
{
	if ( !before_check(F) ) return false;
	choose_enable(F.ike_policy_name);
	F.submit_button.value="vpn_adv_refresh";
	for(var i=0; i<ipsec_entry.length; i++)
	{
		if ( ipsec_entry[i].ipsec_ike == ike_entry[idx].kid )
		{
			if ( ipsec_entry[i].st == "1" ) 
			{
				if ( reboot_flg == "1" ) 
					F.submit_button.value="vpn_adv_reboot";
				else
					F.submit_button.value="vpn_adv";
				break;
			}
			 
		} 
	}
	F.gui_action.value = "Apply";
	F.submit();
	if ( F.submit_button.value == "vpn_adv_reboot" ) 
		parent.document.getElementById("hidden_bg").style.display="";
	else
		parent.document.getElementById("save_bg").style.display="";
}

function chg_local(F)
{
	if ( F.localtype[0].selected == true ) 
		choose_disable(F.local);
	else
		choose_enable(F.local);
}

function chg_remote(F)
{
	if ( F.remotetype[0].selected == true ) 
		choose_disable(F.remote);
	else
		choose_enable(F.remote);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmike method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">
<input type=hidden name=stflg value="<% nvram_gozila_get("ike_stflg"); %>">
<input type=hidden name=selidx value="<% nvram_gozila_get("ike_selidx"); %>">
<input type=hidden name=ike_stflg value="<% nvram_gozila_get("ike_stflg"); %>">
<input type=hidden name=ike_selidx value="<% nvram_gozila_get("ike_selidx"); %>">
<input type=hidden name=ike_xauth_type>
<input type=hidden name=ltype value=0>
<input type=hidden name=rtype value=0>
<!--input type=hidden name=ike_auth_method value="psk"-->
<input type=hidden name=next_page value="vpn_adv">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.ipsecpolicy),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.editconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ikename));</script>
		<input name=ike_policy_name id=ike_policy_name size=20 maxlength=32 onblur=chk_name("ike_policy_name")>
		<span id=msg_ike_policy_name></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.exmode));</script>
		<script>
		var _name = new Array(__T(mang.main),__T(mang.agg));
		var _val = new Array("main","aggressive");
		draw_object(O_GUI,SELBOX,"ike_exchange_mode","",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.local),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.localidenttype));
		var _name = new Array(__T(vpn.localwanip1),__T(share.ipaddr),__T(vpn.fqdn),__T(vpn.userfqdn),__T(vpn.der));
		var _val = new Array("0","1","2","3","4");
		draw_object(O_GUI,SELBOX,"localtype"," onchange=chg_local(this.form)",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.localident));</script>
		<input size=20 name=local id=local maxlenght=64 onblur=chk_ip("local")>
		<span id=msg_local></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.remote),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteidenttype));
		var _name = new Array(__T(vpn.remotewanip1),__T(share.ipaddr),__T(vpn.fqdn),__T(vpn.userfqdn),__T(vpn.der));
		var _val = new Array("0","1","2","3","4");
		draw_object(O_GUI,SELBOX,"remotetype"," onchange=chg_remote(this.form)",_name,_val);
		</script>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteident));</script>
		<input size=20 name=remote id=remote maxlenght=64 onblur=chk_ip("remote")>
		<span id=msg_remote></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.ikesa),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
		<script>
	        var _name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
	        var _val= new Array("des","3des","aes128","aes192","aes256");
		draw_object(O_GUI,SELBOX,"ike_encrypt_algo","id=ike_encrypt_algo ",_name,encrypt_val);
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authalg));</script>
                <script>
                //var _name= new Array(__T(mang.md5),__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"));
                var _name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
                draw_object(O_GUI,SELBOX,"ike_auth_algo","id=ike_auth_algo ",_name,auth_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authmethod));</script>
                <script>
                var _name= new Array(__T(vpn.preskey),__T(vpn.rsasign));
                draw_object(O_GUI,SELBOX,"ike_auth_method","id=ike_auth_method onchange=sel_psk(this.form)",_name,auth_method_val);
                </script>
		<span id=msg_ike_auth_method></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.preskey));</script>
                <input size=20 maxlength=49 name=ike_psk id=ike_psk onblur=chk_psk(this.form)>
		<span id=msg_ike_psk></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dhgroup));</script>
		<script>
	        var _name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
		draw_object(O_GUI,SELBOX,"ike_dh_group","id=ike_dh_group ",_name,dh_val);
		</script>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.satime));</script>
                <input size=20 name=ike_sa_life id=ike_sa_life maxlength=5 value=28800 onblur=msg_chk_range(this.value,"ike_sa_life",30,86400,10,IS_FIELD,0,"msg_ike_sa_life")> <script>Capture(unit.seconds);</script><script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"30","86400","28800"));</script>
		<span id=msg_ike_sa_life></span>
                </td></tr>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dpd));</script>
		<input type=checkbox name=ike_dpd_enable id=ike_dpd_enable onclick=chk_dpd(this.form)> <script>Capture(share.enable)</script>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dpddelay));</script>
		<input size=20 name=ike_dpd_delay id=ike_dpd_delay value=10 maxlength=3 onblur=msg_chk_range(this.value,"ike_dpd_delay",10,999,10,IS_FIELD,0,"msg_ike_dpd_delay")><script>document.write(spell_words(range_def_rule,"10","999","10"));</script>
		<span id=msg_ike_dpd_delay></span>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dpdtimeout),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 name=ike_dpd_timeout id=ike_dpd_timeout value=30 maxlength=4 onblur=msg_chk_range(this.value,"ike_dpd_timeout",30,1000,10,IS_FIELD,0,"msg_ike_dpd_timeout")><script>document.write(spell_words(range_def_rule,"30","1000","30"));</script>
		<span id=msg_ike_dpd_timeout></span>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T("Extended Authentication"),"colspan=2");</script></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC("XAUTH Type"));</script>
		<input type=checkbox id=_ike_xauth_type name=_ike_xauth_type onclick=sel_authtype(this.form)> 
		</script>
		<script>Capture(share.enable);</script--> 		
		<!--script>
		var _name = new Array(__T(share.none),__T("User Database"),__T("IPsec Host"));
		var _val = new Array("0","1","2");
		draw_object(O_GUI,SELBOX,"ike_xauth_type","id=ike_xauth_type onchange=sel_authtype(this.form)",_name,_val);
		</script-->
                <!--/TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.username));</script>
		<input size=20 maxlength=64 name=ike_xauth_name id=ike_xauth_name>
		<span id=msg_ike_xauth_name></span>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.password),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 maxlength=64 name=ike_xauth_pass id=ike_xauth_pass>
		<span id=msg_ike_xauth_pass></span>
		</TD></TR-->
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
