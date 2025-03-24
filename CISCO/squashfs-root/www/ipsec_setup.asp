<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function AAA(kid,pname,lid_type,lid,rid_type,rid,emode,esp,ah,psk,dh,sa_life,dpden,dpddelay,dpdtimeout,auth_method)
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

var encrypt_val= new Array("des","3des","aes128","aes192","aes256");
//var auth_val= new Array("md5","sha1","sha2_256","sha2_384","sha2_512");
var auth_val= new Array("md5","sha1","sha2_256");
var dh_val= new Array("modp768","modp1024","modp1536");
var lr_val= new Array("0","1");
var data = new Array();
<% get_vpnserver_setup("data"); %>

var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","AAA"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmsetup;
	if ( data[0][0] == '1' ) F.enser.checked = true;
	else F.enser.checked = false;
	if ( data[0][5] != '' ) F.ike_sa_life.value = data[0][5];
	F.ipsec_local_start.value = data[0][7];
	F.ipsec_local_subnet.value = data[0][8];
	if ( data[0][9] != '' ) 
		F.ipsec_sa_lifetime.value = data[0][9];
	if ( data[0][12] == '1' ) F.ipsec_pfs_enable.checked = true;
	else F.ipsec_pfs_enable.checked = false;
	F.ike_psk.value = data[0][14];
	en_server(F);
	default_nv = keep_val(F,"");
}

function sel_ltype(val)
{
	var F = document.frmsetup;
	if ( val == "0" ) //SINGLE
	{
		choose_enable(F.ipsec_local_start);
		choose_disable(F.ipsec_local_subnet);
	}else{
		choose_enable(F.ipsec_local_start);
		choose_enable(F.ipsec_local_subnet);
	}
}

function chk_enpfs(F)
{
	if ( F.ipsec_pfs_enable.checked == true )
		choose_enable(F.ipsec_pfs_group);
	else
		choose_disable(F.ipsec_pfs_group);
}

function chk_subnet(I,N1,G,N2)
{
	var IP = new Array(4);
	var NM = new Array(4);
	var GW = new Array(4);
	var NM2 = new Array(4);
	var tmp1 =0 ,tmp2 =0;
	
	IP = I.split(".");
	NM = N1.split(".");
	GW = G.split(".");
	NM2 = N2.split(".");
	
	for(i=0;i<4;i++){
		tmp1 = IP[i] & NM[i];
		tmp2 = GW[i] & NM2[i];
		if( ( tmp1 != tmp2 ) && 
                    ( tmp1 != 0 && tmp2 != 0 ) )
		{
			return true;
		}
		
	}
	return false;
}

function uiDoSave(F)
{
	var local_subnet;
	//if ( !before_check(F) ) return false;
	if ( F.enser.checked == true ) F.en_setup_entry.value = 1;
	else F.en_setup_entry.value = 0;
	if ( F.ipsec_pfs_enable.checked == true ) F.en_pfs.value = 1;
	else  F.en_pfs.value = 0;
	if ( !chk_psk(F) ) return false;
	clear_msg("ipsec_local_start", "msg_ipsec_local_start");
	if ( !chk_ip("ipsec_local_start") ) return false;
	if ( F.ipsec_local_type.value == "1" ) 
		if ( !chk_ip("ipsec_local_subnet") ) return false;
	/*
	for(var i=0; i<ipsec_entry.length; i++)
	{
		//alert(ipsec_entry[0].lip+", "+ipsec_entry[0].lmask+", "+F.ipsec_local_start.value+", "+F.ipsec_local_subnet.value);
		
		if ( F.ipsec_local_type.value == "0" ) local_subnet = "255.255.255.255";
		else local_subnet = F.ipsec_local_subnet.value;
		if ( !chk_subnet(ipsec_entry[i].lip, ipsec_entry[i].lmask, 
                                 F.ipsec_local_start.value,local_subnet) )
		{
                       	my_alert(O_VAR,"ipsec_local_start",__T(msg.ruleexist),"0","msg_ipsec_local_start");
		        return false;
		}
	}*/
	F.gui_action.value = "Apply";
	F.submit_button.value="ipsec_setup";
	DISABLE_PART(F,"setup_start","setup_end",0);
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function en_server(F)
{
	if ( F.enser.checked == true ) 
	{
		DISABLE_PART(F,"setup_start","setup_end",0);
		sel_ltype(F.ipsec_local_type.value);
		chk_enpfs(F);
	}
	else
		DISABLE_PART(F,"setup_start","setup_end",1);
}

function chk_ip(obj_id)
{
	var F = document.frmsetup;
	clear_msg(obj_id,"msg_"+obj_id);
	if ( obj_id.indexOf("subnet") != -1 ) 
	{
		if ( !valid_mask(F,obj_id,ZERO_NO,"msg_"+obj_id) ) return false;
	}else{
		if ( ( obj_id.indexOf("local")!= -1 && 
		       F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1") )
		{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE7,MASK_OK) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
			
		}else{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE7,MASK_NO) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
		}
	}
	return true;
}

function m_natt(F)
{
	F.backname.value = "ipsec_setup.asp";
	F.submit_button.value = "vpn_adv";
	F.change_action.value = "gozila_cgi";
	F.submit(); 
//	get_position("vpn_adv.asp");	
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
        if ( F.ike_psk.value.length < 8 ) 
        {
                my_alert(O_VAR,"ike_psk",__T(vpn.errkeymsg),"0","msg_ike_psk");
                return false;
        }
	for(var i=0; i<ike_entry.length; i++)
	{
		if ( ike_entry[i].psk == F.ike_psk.value )
		{
                	my_alert(O_VAR,"ike_psk",__T(vpn.pskerr),"0","msg_ike_psk");
	                return false;
		}
	}
        return true;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmsetup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=backname>
<input type=hidden name=gui_action>
<input type=hidden name=en_setup_entry>
<input type=hidden name=en_pfs>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(filter.setup),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.enser));</script>
		<input type=checkbox id=enser name=enser onclick=en_server(this.form)>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.nattrav));
		var vpnnatt = "<% get_vpnnatt(); %>";
		if ( vpnnatt == "1" ) 
			Capture(share.enabled);
		else 
			Capture(share.disabled);
		document.write("&nbsp;&nbsp;&nbsp;");	
		draw_object(O_GUI,BT,__T(share.edit),"t1","BT","m_natt(this.form)");
		</script></TD></TR>
		<input type=hidden name=setup_start>	
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.phase1),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.preskey));</script>
                <input size=20 maxlength=49 name=ike_psk id=ike_psk onblur=chk_psk(this.form)>
		<span id=msg_ike_psk></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.exmode));</script>
		<script>
		var _name = new Array(__T(mang.main),__T(mang.agg));
		var _val = new Array("main","aggressive");
		draw_object(O_GUI,SELBOX,"ike_exchange_mode","",_name,_val,data[0][1]);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
		<script>
	        var _name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
	        var _val= new Array("des","3des","aes128","aes192","aes256");
		draw_object(O_GUI,SELBOX,"ike_encrypt_algo","id=ike_encrypt_algo ",_name,encrypt_val,data[0][2]);
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authalg));</script>
                <script>
                //var _name= new Array(__T(mang.md5),__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"));
                var _name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
                draw_object(O_GUI,SELBOX,"ike_auth_algo","id=ike_auth_algo ",_name,auth_val,data[0][3]);
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dhgroup));</script>
		<script>
	        var _name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
		draw_object(O_GUI,SELBOX,"ike_dh_group","id=ike_dh_group ",_name,dh_val,data[0][4]);
		</script>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ikesalife));</script>
                <input size=20 name=ike_sa_life id=ike_sa_life maxlength=5 value=3600 onblur=msg_chk_range(this.value,"ike_sa_life",30,86400,10,IS_FIELD,0,"msg_ike_sa_life") > <script>Capture(unit.seconds);</script><script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"30","86400","3600"));</script>
		<span id=msg_ike_sa_life></span>
                </td></tr>	
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.phase2),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.lip));</script>
		<script>
	        //var _name= new Array(__T(filter.any),__T(def.range),__T("Single"),__T("Subnet"));
	        var _name= new Array(__T(vpn.single),__T(vpn.subnet)); ;
		draw_object(O_GUI,SELBOX,"ipsec_local_type","id=ipsec_local_type onchange=sel_ltype(this.value)",_name,lr_val,data[0][6]);
		</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.startaddr)+":");</script-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
		<input name=ipsec_local_start id=ipsec_local_start size=20 maxlength=15 onblur=chk_ip("ipsec_local_start");cal_submask(this.from,"ipsec_local_start","ipsec_local_subnet",this.form.ipsec_local_type[this.form.ipsec_local_type.selectedIndex].value);>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
		<span id=msg_ipsec_local_start></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.mask));</script>
		<input name=ipsec_local_subnet id=ipsec_local_subnet size=20 maxlength=15 onblur=chk_ip("ipsec_local_subnet")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));</script>
		<span id=msg_ipsec_local_subnet></span>
		</TD></TR>	
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ipsecsatime));</script>
                <input name=ipsec_sa_lifetime id=ipsec_sa_lifetime size=20 value=28800 maxlength=5 onblur=msg_chk_range(this.value,"ipsec_sa_lifetime",30,86400,10,IS_FIELD,0,"msg_ipsec_sa_lifetime")> <script>Capture(unit.seconds);</script><script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"30","86400","28800"));</script>
                <span id=msg_ipsec_sa_lifetime></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
		<script>
	        var _name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
	        var _val= new Array("des","3des","aes128","aes192","aes256");
		draw_object(O_GUI,SELBOX,"ipsec_encrypt_algo","id=ipsec_encrypt_algo ",_name,encrypt_val, data[0][10]);
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authalg));</script>
                <script>
                //var _name= new Array(__T(mang.md5),__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"));
                var _name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
                draw_object(O_GUI,SELBOX,"ipsec_auth_algo","id=ipsec_auth_algo ",_name,auth_val, data[0][11]);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.pfskeygroup));</script>
		<input type=checkbox name=ipsec_pfs_enable id=ipsec_pfs_enable onclick=chk_enpfs(this.form)> <script>Capture(share.enable)</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dhgroup),SPACE_DOWN,SPACE_DOWN);</script>
                <script>
                var _name= new Array(__T(vpn.dhgroup1),__T(vpn.dhgroup2),__T(vpn.dhgroup5));
                draw_object(O_GUI,SELBOX,"ipsec_pfs_group","id=ipsec_pfs_group",_name,dh_val, data[0][13]);
                </script>
                </TD></TR>
		<input type=hidden name=setup_end>	
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
