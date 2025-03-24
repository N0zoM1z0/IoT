<html>
<head>
<title>SNMP</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("base64.js"); %>
//var chg_en = 0;
var snmp_en = "<% nvram_get("snmp_enable"); %>";

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmsnmp;
	chk_usr( "<% nvram_snmp_get("snmpv3_0_user"); %>",F);
        Sel_AUTH(F);
	if ( snmp_en == "1" )
		Sel_User("<% nvram_get("snmpv3_user"); %>",F);
	CHG_ST(F);
	if ( snmp_en == "1" ) 
	{
		chk_com();
		Sel_Mode(F);
	}
	default_nv = keep_val(F,"");
}

function Sel_User(num,F)
{
	chk_usr(num,F);
        Sel_AUTH(F);
}

var autherr=0, priverr=0;
function valid_pwd_value(F,I,J)
{
	if( F.snmpv3_seclevel.selectedIndex == 0 ) return true;
	if( F.snmpv3_seclevel.selectedIndex == 1 ) clear_msg("smmpv3_authpwd","_auth");
	if( F.snmpv3_seclevel.selectedIndex == 2 ) clear_msg("smmpv3_privpwd","_priv");
        if( I.value.length >= 8 && I.value.length <= 64 ){
		if ( J == 1 ) autherr = 0;
		if ( J == 2 ) priverr = 0;
		if ( autherr == 0 && !chk_value(F,"snmpv3_authpwd","_auth") ) return false;
		if ( priverr == 0 && F.snmpv3_seclevel.selectedIndex == 2 ){
			if ( !chk_value(F,"snmpv3_privpwd","_priv") ) return false;
		}
        }
        else
	{
		if ( J == 1 ) autherr = 1;
		if ( J == 2 ) priverr = 1;
		if ( J == 1 ) 
		 	my_alert(O_VAR,"snmpv3_authpwd",spell_words(ipsec_key_rule,"8-64"),"0","_auth");
		if ( F.snmpv3_seclevel.selectedIndex == 2 && J == 2 )
 	                my_alert(O_VAR,"snmpv3_privpwd",spell_words(ipsec_key_rule,"8-64"),"0","_priv");
                return false;
	}
        return true;    
}
function chk_com(){
        var F = document.frmsnmp;
        var ver = F.trap_ver.value;
        if ( ver == "v3"){
		F.trap_com.value = "<% nvram_get("trap_com"); %>"; 		
                choose_disable(F._trap_com);
        }else{
		F.trap_com.value = F._trap_com.value;
                choose_enable(F._trap_com);
	}
}
function chk_usr(num,F){
	if (num == "admin")
	{	
		var tmp_auth = "<% nvram_get("snmpv3_0_auth"); %>";
		var tmp_priv = "<% nvram_get("snmpv3_0_priv"); %>";
		F.snmpv3_user[1].checked = true;
		if (tmp_auth == "MD5")	F.snmpv3_auth[0].checked = true;
		else	F.snmpv3_auth[1].checked = true;

		if (tmp_priv == "DES")	F.snmpv3_priv[0].checked = true;
		else	F.snmpv3_priv[1].checked = true;

		document.getElementById("power").innerHTML = __T(mang.rwuser);
		F.snmpv3_seclevel.value = "<% nvram_get("snmpv3_0_seclevel"); %>";
		F.snmpv3_authpwd.value = "<% nvram_get("snmpv3_0_authpwd"); %>";
		F.snmpv3_privpwd.value = "<% nvram_get("snmpv3_0_privpwd"); %>";
        }else{
		var tmp_auth = "<% nvram_get("snmpv3_1_auth"); %>";
		var tmp_priv = "<% nvram_get("snmpv3_1_priv"); %>";
		F.snmpv3_user[0].checked = true;
		if (tmp_auth == "MD5")	F.snmpv3_auth[0].checked = true;
		else	F.snmpv3_auth[1].checked = true;

		if (tmp_priv == "DES")	F.snmpv3_priv[0].checked = true;
		else	F.snmpv3_priv[1].checked = true;

		document.getElementById("power").innerHTML = __T(mang.readonlyuser);
                F.snmpv3_seclevel.value = "<% nvram_get("snmpv3_1_seclevel"); %>";
		F.snmpv3_auth.checked = "<% nvram_get("snmpv3_1_auth"); %>";
                F.snmpv3_authpwd.value = "<% nvram_get("snmpv3_1_authpwd"); %>";
                F.snmpv3_privpwd.value = "<% nvram_get("snmpv3_1_privpwd"); %>";
	}
}

function chk_port(){
        var F = document.frmsnmp;
	var obj = F.trap_port.value;
	clear_msg("trap_port","_port");	
	if ( chk_chartype(obj,DIGIT) ) 
	{
		if ( obj != "162" )
			if ( !msg_chk_range(obj,"trap_port",1025,65535,10,IS_FIELD,0,"_port")) return false;
	}else{
                my_alert(O_VAR,"trap_port",__T(msg.validname),"0","_port");
		return false;
	}
	return true;
}

function chk_lanip(F,val,itype)
{
	var ipv4_lanip="<% nvram_get("lan_ipaddr"); %>";
	var ipv6_lanip=full_ipv6("<% nvram_get("lan_ipv6_ipaddr"); %>");
	if ( itype == "4" ) 
	{
		if ( ipv4_lanip == val ) return __T(msg.invalidip1);
	}else{
		if ( ipv6_lanip == full_ipv6(val) ) return __T(msg.invalidip1);
	}
	return "";
}

function chk_trap_ip(F)
{
	var err, errmsg="";
	var ipv4_lanip="<% nvram_get("lan_ipaddr"); %>";
	var ipv6_lanip="<% nvram_get("lan_ipv6_ipaddr"); %>";
	var nv_wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>";
	var nv_lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>";
	F.trap_ip.value = parseIP(F.trap_ip.value);
	if ( nv_wan_ip_mode == "1" && nv_lan_ip_mode == "1" ) //IPv4 Only
	{
		err = check_ipv4(F.trap_ip.value,VALID_IP_RULE1);
		if ( err != PASS ) 
			errmsg = ddnsm.tzo_notip; 
		else
			errmsg = chk_lanip(F,F.trap_ip.value,"4");
	}
	else if ( nv_wan_ip_mode == "2" && nv_lan_ip_mode == "2" ) //IPv6 Only
	{
		errmsg = valid_ipv6(F.trap_ip.value);
		if ( errmsg == "" ) 
			errmsg = chk_lanip(F,F.trap_ip.value,"6");
	}
	else{
		err = check_ipv4(F.trap_ip.value,VALID_IP_RULE1);
		if ( err == PASS ) 
			errmsg = chk_lanip(F,F.trap_ip.value,"4");
		else
		{
			errmsg = valid_ipv6(F.trap_ip.value);
			if ( errmsg == "" ) 
				errmsg = chk_lanip(F,F.trap_ip.value,"6");
		}
	}
	clear_msg("trap_ip","msg_ip");
	if ( errmsg != "" ) 
	{
	        my_alert(O_VAR,"trap_ip", errmsg,"0","msg_ip");
		return false;
	}
	return true;
}

function valid_value(F)
{
	var errflg=0;
	clear_msg("trap_ip","msg_ip");	
	clear_msg("trap_port","_port");	
	clear_msg("_trap_com","_com");	
	if ( F.trap_ip.value != "" || F.trap_port.value != "" || ( F.trap_ver.value != "v3" && F._trap_com.value != "") )
	{
		if ( !chk_port() ) errflg = 1;
		if ( !chk_trap_ip(F) )	errflg = 1;
		//if ( !my_valid_m_value("IP",F,"snmpv3_trap_ip","",VALID_IP_RULE1,ZERO_OK,"msg_ip") ) errflg=1;
		if ( F.trap_ver.value != "v3" ) 
		{
			if ( !chk_value(F,"_trap_com","_com") ) errflg = 1;
		}
	}
	if ( !chk_value_allow_blank(F,"snmp_contact","_snmp_contact") ) errflg = 1;
	if ( !chk_value_allow_blank(F,"snmp_location","_snmp_location") ) errflg = 1;
	if ( !valid_pwd_value(F,F.snmpv3_authpwd,1)) errflg=1;
	if( F.snmpv3_seclevel.selectedIndex == 2 ) 
		if ( !valid_pwd_value(F,F.snmpv3_privpwd,2)) errflg=1;
	if ( F._trap_com.value != "" && !chk_trapcom(F,"_trap_com","_com") ) errflg = 1;
	if ( F.wan_hostname.value != "" && !chk_hostname(F,"wan_hostname","_wan_hostname") ) errflg = 1;
	if ( errflg !=1 )
	{
		if ( F.snmpv3_authpwd.value != "" ) F.snmpv3_authpwd.value = encode64(F.snmpv3_authpwd.value);
		if ( F.snmpv3_privpwd.value != "" ) F.snmpv3_privpwd.value = encode64(F.snmpv3_privpwd.value);
	}
	if ( errflg == 1 ) return false;
	return true;
}

function chk_hostname(F,obj_name,img_name)
{
	if( eval("F."+obj_name).value == "" ) return true;
        var errmsg = valid_hostname(eval("F."+obj_name).value);
	clear_msg(obj_name,img_name);	
        if ( errmsg != "" )
        {
                my_alert(O_VAR,obj_name, errmsg,"0",img_name);
                return false;
        }
        return true;
}

function uiDoSave(F)
{
	if (F.snmp_getcom.value == F.snmp_setcom.value)
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(mang.diffcom),"chk_result(1)","chk_result(0)","","yesno");
	}
	else
	{
		chk_result(1);
	}
}

function chk_result(idx)
{
	var F = document.frmsnmp;

	alert_result(0);

	if ( idx == 1 )
	{
		if ( !valid_value(F) ) return;
		if ( F._snmp_vpn_access.checked ) F.snmp_vpn_access.value = "1";
		else F.snmp_vpn_access.value = "0";
		if ( F._snmp_internet_access.checked ) F.snmp_internet_access.value = "1";
		else F.snmp_internet_access.value = "0";
		F.trap_com.value = F._trap_com.value;
		if ( F._snmp_enable.checked ) F.snmp_enable.value = "1";
		else F.snmp_enable.value = "0";
		F.submit_button.value = "snmp";
		F.gui_action.value = "Apply";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}

function CHG_ST(F)
{
	if ( F._snmp_enable.checked ) F.snmp_enable.value = "1";
	else F.snmp_enable.value = "0";
//	if (snmp_en != F.snmp_enable.value)
//		chg_en = 1;
	if ( F._snmp_enable.checked == true ) 
	{
		DISABLE_PART(F,"disable_snmp_start","disable_snmp_end",0);
		Sel_AUTH(F);
		
	}else
		DISABLE_PART(F,"disable_snmp_start","disable_snmp_end",1);
		return true;
}

function SNMP_EN(F)
{
	CHG_ST(F);
}

function Sel_AUTH(F)
{
	clear_msg("snmpv3_authpwd","_auth");
	clear_msg("snmpv3_privpwd","_priv");
	if ( F.snmpv3_seclevel.value == "0" )
	{
		DISABLE_PART(F,"auth_start","auth_end",1);
		DISABLE_PART(F,"priv_start","priv_end",1);
	}else if ( F.snmpv3_seclevel.value == "1" ){ 	
		DISABLE_PART(F,"auth_start","auth_end",0);
		DISABLE_PART(F,"priv_start","priv_end",1);
	}else{
		DISABLE_PART(F,"auth_start","auth_end",0);
		DISABLE_PART(F,"priv_start","priv_end",0);
	}
}

function Sel_Mode(F)
{
	if ( F.snmp_mode.value == "3" ) 
	{
		choose_disable(F.snmp_setcom);
		choose_disable(F.snmp_getcom);
	}else{
		choose_enable(F.snmp_setcom);
		choose_enable(F.snmp_getcom);
	}
}

function USER_EN(F){
	CHG_ST(F);
} 

function chk_value_allow_blank(F,obj_name,img_name)
{
        clear_msg(obj_name,img_name);
        var returnmsg = valid_meaning_id_name(MEANING_NAME,eval("F."+obj_name).value,SPACE_OK);
        if ( returnmsg != "" ) 
        {
                my_alert(O_VAR,obj_name, returnmsg,"0",img_name);
                return false;
        }
        return true;    
}


function chk_value(F,obj_name,img_name)
{
	clear_msg(obj_name,img_name);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,eval("F."+obj_name).value,ZERO_NO|SPACE_OK);
	if ( returnmsg != "" ) 
	{
                my_alert(O_VAR,obj_name, returnmsg,"0",img_name);
		return false;
	}
	return true;	
}
function chk_trapcom(F,obj_name,img_name)
{
	clear_msg(obj_name,img_name);
        if(!preg_match('^[A-Za-z0-9]+$',eval("F."+obj_name).value))
	{
		my_alert(O_VAR,obj_name,__T(msg.nameformat),"0",img_name);
		return false;
	}
	return true;	
	
}


</script>
<body onload="init();" onresize=chgwin()>
<FORM autocomplete=off id="frm" name=frmsnmp method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=snmp_enable>
<input type=hidden name=trap_com>
<input type=hidden name=usr_num>
<input type=hidden name=snmp_vpn_access>
<input type=hidden name=snmp_internet_access>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.snmp),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.snmpsysteminfo),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.snmp));</script>
                <input type=checkbox name=_snmp_enable <% nvram_match("snmp_enable","1","checked"); %> onClick=SNMP_EN(this.form)> <script>Capture(share.enable);</script>
                </TD></TR>
		<input type=hidden name=disable_snmp_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.allowuseraccviaint));</script>
                <input type=checkbox name=_snmp_internet_access <% nvram_match("snmp_internet_access","1","checked"); %>><script>Capture(share.enable);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.allowuseraccviavpn));</script>
                <input type=checkbox name=_snmp_vpn_access <% nvram_match("snmp_vpn_access","1","checked"); %>><script>Capture(share.enable);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.mode));</script>
		<script>
		var _name=new Array("v1","v2c","v3");
		var _val=new Array("1","2","3");
		draw_object(O_GUI,SELBOX,"snmp_mode","onChange=Sel_Mode(this.form)",_name, _val,"<% nvram_get("snmp_mode"); %>");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.engineid));</script>
		<script>document.write("<% nvram_get("snmpv3_engineid"); %>");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.syscontact));</script>
		<input size=30 maxlength=32 name=snmp_contact value="<% nvram_get("snmp_contact"); %>" onblur=chk_value_allow_blank(this.form,"snmp_contact","_snmp_contact")>
		<SPAN id=_snmp_contact></SPAN>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.syslocation));</script>
		<input size=30 maxlength=32 name=snmp_location value="<% nvram_get("snmp_location"); %>" onblur=chk_value_allow_blank(this.form,"snmp_location","_snmp_location")>
		<SPAN id=_snmp_location></SPAN>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.sysname));</script>
		<input size=30 maxlength=63 id=wan_hostname name=wan_hostname onblur=chk_hostname(this.form,"wan_hostname","_wan_hostname") value="<% nvram_get("wan_hostname"); %>">
		<SPAN id=_wan_hostname></SPAN>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.getcom));</script>
		<input size=30 maxlength=32 name=snmp_getcom value="<% nvram_get("snmp_getcom"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.setcom));</script>
		<input size=30 maxlength=32 name=snmp_setcom value="<% nvram_get("snmp_setcom"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.snmpuserconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.username));</script>
		<script>
	        var _name= new Array(__T(mang.guest),__T(router.admin));
	        var _val= new Array("guest","admin");
		draw_object(O_GUI,RADIO,"snmpv3_user",_val,_name,"<% nvram_get("snmpv3_user"); %>","onClick=Sel_User(this.value,this.form)");
		</script>
                </TD></TR>
		<input type=hidden name=user_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.accpriv));</script>
		<SPAN id=power><script>Capture(mang.readonlyuser);</script></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.securitylevel));</script>
		<script>
		var _name=new Array(__T(mang.noauthnopriv),__T(mang.authnopriv),__T(mang.authpriv));
		var _val=new Array("0","1","2");
		draw_object(O_GUI,SELBOX,"snmpv3_seclevel","onChange=Sel_AUTH(this.form)",_name, _val,"");
		</script>
		<input type=hidden name=auth_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.authalgorithmserver));
		var _name=new Array(__T(mang.md5),__T(mang.sha));
		var _val=new Array("MD5","SHA");
		draw_object(O_GUI,RADIO,"snmpv3_auth",_val,_name,"","");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.authpwd));</script>
		<input type=password size=30 maxlength=64 name=snmpv3_authpwd id=snmpv3_authpwd onblur=chk_value(this.form,"snmpv3_authpwd","_auth")>
		<SPAN id=_auth></SPAN>
		</TD></TR>
		<input type=hidden name=auth_end>
		<input type=hidden name=priv_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.privalgorithm));
		var _name=new Array(__T(mang.des),__T(mang.aes));
		var _val=new Array("DES","AES");
		if ( frmsnmp.snmpv3_user.value == "admin")
			draw_object(O_GUI,RADIO,"snmpv3_priv",_val,_name,"<% nvram_get("snmpv3_0_priv"); %>","");
		else
			draw_object(O_GUI,RADIO,"snmpv3_priv",_val,_name,"<% nvram_get("snmpv3_1_priv"); %>","");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.privpwd));</script>
		<input type=password size=30 maxlength=64 name=snmpv3_privpwd id=snmpv3_privpwd onblur=chk_value(this.form,"snmpv3_privpwd","_priv")>
		<SPAN id=_priv></SPAN>
		</TD></TR>
		<input type=hidden name=priv_end>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.trapconfig));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.ipaddr));</script>
		<script>
		document.write("<input size=51 maxlength=39 name=trap_ip id=trap_ip value='"+full_ipv6("<% nvram_get("trap_ip"); %>")+"' maxlength=39 onblur=chk_trap_ip(this.form)>");
			//draw_object(O_GUI,IP,"snmpv3_trap_ip","<% nvram_get("trap_ip"); %>");
			document.write("&nbsp;&nbsp;"+spell_words(hint_or_rule,"192.168.1.100","fec0::64"));
		</script>
		<SPAN id=msg_ip></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.port));</script>
		<input size=30 maxlength=5 onBlur=chk_port() name=trap_port id=trap_port value="<% nvram_get("trap_port"); %>">
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_range_rule,"162","1025","65535"));</script>
		<span id=_port></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.community));</script>
		<input size=30 maxlength=32 name=_trap_com id=_trap_com value="<% nvram_get("trap_com"); %>" onblur=chk_trapcom(this.form,"_trap_com","_com")>
		<span id=_com></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.snmpver));</script>
                <script>
		var _name=new Array("v1","v2c","v3");
		draw_object(O_GUI,SELBOX,"trap_ver","onChange=chk_com()",_name,_name,"<% nvram_get("trap_ver"); %>");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.trapsevlevel),SPACE_DOWN,SPACE_DOWN);
		var _logevent_list = new Array(__T(syslog.event_emer),__T(syslog.event_alert),__T(syslog.event_crit),__T(syslog.event_err),__T(syslog.event_warn),__T(syslog.event_noti),__T(syslog.event_info),__T(syslog.event_debug));
		var _logevent_val = new Array('1','2','3','4','5','6','7','8');
		draw_object(O_GUI,SELBOX,"snmp_trap_log_level","onChange=chk_com()",_logevent_list,_logevent_val,"<% nvram_get("snmp_trap_log_level"); %>");
		</script>
		</TD></TR>
		<input type=hidden name=disable_snmp_end>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
