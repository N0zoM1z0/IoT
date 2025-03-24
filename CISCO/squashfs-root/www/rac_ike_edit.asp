<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var encrypt_val= new Array("des","3des","aes128","aes192","aes256");
//var auth_val= new Array("md5","sha1","sha2_256","sha2_384","sha2_512");
//var auth_val= new Array("md5","sha1","sha2_256");
var auth_val= new Array("md5","sha1");
var dh_val= new Array("modp768","modp1024","modp1536");
var auth_method_val= new Array("psk","cert");
var sidx="<% nvram_gozila_get("ike_selidx"); %>";
var mode_name = new Array(__T(mang.main),__T(mang.agg));
var mode_val = new Array("main","aggressive");
if ( sidx == "" ) sidx="0";
if ( parseInt(sidx,10) > 0 ) sidx = parseInt(parseInt(sidx,10),10);
if ( "<% nvram_gozila_get("backname"); %>" != "" ) 
{
	var change_cancel_bt="true";
	var back_bt="true";
}
function AAA(kid,pname,emode,rep_type,rep_val,en_algo,auth_algo,dh,psk,en_dpd,dpd_delay,dpd_timeout)
{
	this.kid=kid;
	this.pname = pname;
	this.emode = emode;
	this.rep_type = rep_type;
	this.rep_val = rep_val
	this.en_algo = en_algo;
	this.auth_algo=auth_algo;
	this.dh=dh;
	this.psk=psk;
	this.en_dpd=en_dpd;
	this.dpd_delay=dpd_delay;
	this.dpd_timeout=dpd_timeout;
}
var ike_entry = new Array();
<% get_rac_ike_policy("all"); %>
var back_bt = "true";
function refresh_page()
{
	alert_result(0);
	var F = document.frmike;
	F.submit_button.value = "rac_ike_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}
function to_back(F)
{
	parent.document.getElementById("newpage").value = "rac_vpn_adv.asp";
	uiDoCancel(F);
}

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
		choose_disable(F.rac_ike_policy_name);
		F.rac_ike_policy_name.value = ike_entry[idx].pname;
		for(var i=0; i<mode_val.length; i++)
		{
			if ( ike_entry[idx].emode == mode_val[i]) 
			{
				F.ike_exchange_mode.selectedIndex = i;
				break;
			}
		}
		F.remote_endpoint_type.selectedIndex = parseInt(ike_entry[idx].rep_type,10);
		F.remote_endpoint_value.value = ike_entry[idx].rep_val;	
		for(var i=0; i<encrypt_val.length; i++)
		{
			if ( ike_entry[idx].en_algo == encrypt_val[i] )
			{
				F.ike_encrypt_algo.selectedIndex = i;
				break;
			}
		}
		for(var i=0; i<auth_val.length; i++)
		{
			if ( ike_entry[idx].auth_algo == auth_val[i] )
			{
				F.ike_auth_algo.selectedIndex = i;
				break;
			}
		}
		/*
		for(var i=0; i<auth_method_val.length; i++)
		{
			if ( ike_entry[idx].auth == auth_method_val[i] ){ 
				F.ike_auth_method.selectedIndex = i;
				break;
			}
		}*/
		if ( ike_entry[idx].psk == "" ){ 
			choose_disable(F.ike_psk);
		}else
			F.ike_psk.value = ike_entry[idx].psk;		
		
		//F.ike_sa_life.value = ike_entry[idx].salife;
		if ( ike_entry[idx].en_dpd == "1" ) 
		{
			F.ike_dpd_enable.checked = true;
			F.ike_dpd_delay.value = ike_entry[idx].dpd_delay;
			F.ike_dpd_timeout.value = ike_entry[idx].dpd_timeout;
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
		F.ike_dpd_enable.checked = true;
	}
	chk_dpd(F);
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
/*
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
*/
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
function chk_fqdn_ip(obj_id)
{
	var F = document.frmike;
	clear_msg(obj_id,"msg_"+obj_id);
	if ( F.remote_endpoint_type.selectedIndex == 0 ) 
	{
		if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE1,MASK_NO) <= 0 )
		{
			my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),0,"msg_"+obj_id);
			return false;
		}
	}else{
		return chk_fqdn(document.getElementById(obj_id).value);
	}
	return true;
}

function chk_psk(F)
{
	clear_msg("ike_psk","msg_ike_psk");
	if ( chk_chartype(F.ike_psk.value,ISCHAR) == FAIL ) 
	{
		my_alert(O_VAR,"ike_psk",__T(msg.hostnameformat1),"0","msg_ike_psk");
		return false;	
	}

	if ( F.ike_psk.value.length < 8 ) 
	{
		my_alert(O_VAR,"ike_psk",__T(vpn.errkeymsg),"0","msg_ike_psk");
		return false;
	}
	return true;
}

function chk_blank(obj_id)
{
	clear_msg(obj_id,"msg_"+obj_id);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_id).value,ZERO_NO|SPACE_NO);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,obj_id,returnmsg,"0","msg_"+obj_id);
	        return false;	
	}
	if ( chk_chartype(document.getElementById(obj_id).value,ISCHAR) == FAIL ) 
	{
		my_alert(O_VAR,obj_id,__T(msg.hostnameformat1),"0","msg_"+obj_id);
		return false;	
	}
	
	return true;
}

function before_check(F)
{
	var errflg = 0 ;
	if ( !chk_blank("rac_ike_policy_name") ) errflg++;
	//if ( F.ltype.selectedIndex == 1 && !chk_ip("ike_local_id") ) errflg++;
	//if ( F.rtype.selectedIndex == 1 && !chk_ip("ike_remote_id") ) errflg++;
	//if ( F.ike_auth_method.selectedIndex == 0 && !chk_psk(F) ) errflg++;
	if (!chk_psk(F)) errflg++;
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
	for(var i=0; i<ike_entry.length; i++)
	{
		if ( F.stflg.value=="edit" && i == sidx ) continue;
		if ((F.stflg.value!="edit") && (ike_entry[i].pname == F.rac_ike_policy_name.value )) 
		{
			my_alert(O_VAR,"rac_ike_policy_name",__T(msg.nameexist),"0","msg_rac_ike_policy_name");
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

function uiDoSave(F)
{
	if ( !before_check(F) ) return false;
	choose_enable(F.rac_ike_policy_name);
	F.gui_action.value = "Apply";
	F.submit_button.value="rac_vpn_adv";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
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
<input type=hidden name=ike_auth_method value="psk">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.ipsecpolicy),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.editconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.policyname));</script>
		<input name=rac_ike_policy_name id=rac_ike_policy_name size=20 maxlength=32 onblur=chk_blank("rac_ike_policy_name")>
		<span id=msg_rac_ike_policy_name></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.exmode));</script>
		<script>
		draw_object(O_GUI,SELBOX,"ike_exchange_mode","",mode_name,mode_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteep));</script>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
                var _val = new Array("0","1");
                draw_object(O_GUI,SELBOX,"remote_endpoint_type","id=remote_endpoint_type",_name,_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input name=remote_endpoint_value id=remote_endpoint_value size=20 maxlength=255 onblur=chk_fqdn_ip("remote_endpoint_value")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com"));</script>
		<span id=msg_remote_endpoint_value></span>
		</TD></TR>	
		
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T("Local"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Identifier Type")+":");</script>
		<script>
	        var _name= new Array(__T("Local WAN IP"));//,__T("FQDN"));
	        var _val= new Array("0");//,"1");
		draw_object(O_GUI,SELBOX,"ltype","onChange=sel_ltype(this.form)",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Identifier")+":");</script>
		<input name=ike_local_id id=ike_local_id size=20 maxlength=15 onblur=chk_ip("ike_local_id")>
		<span id=msg_ike_local_id></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Remote"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Identifier Type")+":");</script>
                <script>
                var _name= new Array(__T("Remote WAN IP"));//,__T("FQDN"));
                var _val= new Array("0");//,"1");
                draw_object(O_GUI,SELBOX,"rtype","onChange=sel_rtype(this.form)",_name,_val);
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T("Identifier")+":");</script>
                <input name=ike_remote_id id=ike_remote_id size=20 maxlength=15 onblur=chk_ip("ike_remote_id")>
                <span id=msg_ike_remote_id></span>
                </TD></TR-->
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
                //var _name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
                var _name= new Array(__T(mang.md5),__T(mang.sha1));
                draw_object(O_GUI,SELBOX,"ike_auth_algo","id=ike_auth_algo ",_name,auth_val);
                </script>
                </TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__T("Authentication Method")+":");</script>
                <script>
                var _name= new Array(__T("Pre-Shared Key"),__T("RSA-Signature"));
                draw_object(O_GUI,SELBOX,"ike_auth_method","id=ike_auth_method onChange=sel_psk(this.form)",_name,auth_method_val);
                </script>
                </TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.preskey));</script>
                <input size=20 maxlength=49 name=ike_psk id=ike_psk onblur=chk_psk(this.form)>
		<span id=msg_ike_psk></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.diffgroup));</script>
		<script>
	        var _name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
		draw_object(O_GUI,SELBOX,"ike_dh_group","id=ike_dh_group ",_name,dh_val);
		</script>
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
