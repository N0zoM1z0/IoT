<html><head>
<title>Wireless Security</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var back_bt = "true";
var change_cancel_bt="true";
<% web_include_file("encode_data.js"); %>
<% wl_multi_nvram_get("wl_security_mode"); %>
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_auth"); %>
<% wl_multi_nvram_get("wl_crypto"); %>
<% wl_multi_nvram_get("wl_wpa_gtk_rekey"); %>
<% wl_multi_nvram_get("wl_wpa_psk"); %>
<% wl_multi_nvram_get("wl_wps_mode"); %>
var result=0;
var now_idx = "<% nvram_gozila_get("wl_vap_idx"); %>";
if ( now_idx == "" ) now_idx = "0";
var s_mode = "<% nvram_gozila_get("wl_security_mode"); %>";
if ( s_mode == "(null)" ) s_mode = eval("nv_wl_security_mode_"+now_idx);
var net_mode = "<% nvram_get("wl_net_mode"); %>";
function init(){
	var F = document.wpa;
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.wpa,"");
	if (( s_mode == "wpa_personal") || ( s_mode == "wpa2_personal" ) || ( s_mode == "wpa2_personal_mixed" ))
		s_pwd(F._wl_wpa_psk.value,"");
}

function SelMode(num,F)
{
    F.wl_security_mode.value=F.wl_security_mode.options[num].value;
    var smode = F.wl_security_mode.value;
    if ( net_mode == "n-only" && ( smode == "wep" || smode == "wpa_personal" || smode == "wpa_enterprise") ) 
    {
                my_alert(O_GUI,INFO,__T(share.info),__T(msg.wldroprule),"alert_result(0)");
                var vlist = new Array("disabled","wep","wpa_personal","wpa_enterprise","wpa2_personal","wpa2_personal_mixed","wpa2_enterprise","wpa2_enterprise_mixed");
		for(var i=0; i<vlist.length; i++)
		{
			if ( s_mode == vlist[i] ) 
			{
    				F.wl_security_mode[i].selected = true ;
				break;
			}
		}
		return;
    }
    F.submit_button.value = "WL_WPATable";
    F.change_action.value = "gozila_cgi";
    F.submit_type.value = "security_mode";
    choose_disable(F.next_page);
    F.submit();
}

function chg_wepbit(clear_flg){
	var F = document.wpa;
	var val = parseInt(F.wl_wep_bit[F.wl_wep_bit.selectedIndex].value,10);
        for(var i=1; i<=4; i++)
        {
		document.getElementById("id_key"+i).style.backgroundColor="";
		document.getElementById("msg_key"+i).innerHTML = "";
                if ( clear_flg )
                {
                        document.getElementById("id_key"+i).value="";
                        document.getElementById("sid_key"+i).value="";
                }
                if ( val == 64 )
                {
                        document.getElementById("id_key"+i).maxLength=10;
                        document.getElementById("sid_key"+i).maxLength=10;
                }
                else
                {
                        document.getElementById("id_key"+i).maxLength=26;
                        document.getElementById("sid_key"+i).maxLength=26;
                }
        }
}

function valid_wep(F){
	var has_err=0;
	var selidx = parseInt(F.wl_key[F.wl_key.selectedIndex].value,10);
	var wepbit = parseInt(F.wl_wep_bit[F.wl_wep_bit.selectedIndex].value,10);
	var tmp="";
	for (var i=1; i<=4; i++)
	{
		if ( F.chk_unmaskpwd.checked == false ) 
			document.getElementById("id_key"+i).value = document.getElementById("sid_key"+i).value;
		tmp = document.getElementById("id_key"+i).value;
		if ( tmp == "" ){
			if ( i == selidx ) 
			{
				parent.document.getElementById("obj_id").value = "msg_key"+i;
				if ( F.chk_unmaskpwd.checked == false ) 
					my_alert(O_VAR,"sid_key"+i,__T(msg.wlkeylen),"0","msg_key"+i);
				else
					my_alert(O_VAR,"id_key"+i,__T(msg.wlkeylen),"0","msg_key"+i);
				return false;
			}else
				continue;
		}
		if ( !chk_chartype(tmp,XDIGIT) )
		{
			parent.document.getElementById("obj_id").value = "msg_key"+i;
			if ( F.chk_unmaskpwd.checked == false ) 
				my_alert(O_VAR,"sid_key"+i,spell_words(hex_rule,"Key"+i),"0","msg_key"+i);
			else
				my_alert(O_VAR,"id_key"+i,spell_words(hex_rule,"Key"+i),"0","msg_key"+i);
			return false;
		}
		if ( ( wepbit == 64 && tmp.length != 10 ) || ( wepbit == 128 && tmp.length != 26 ))
		{
			parent.document.getElementById("obj_id").value = "msg_key"+i;
			my_alert(O_VAR,"id_key"+i,__T(msg.wlkeylen),"0","msg_key"+i);
			return false;
		}
		if ( !chk_key('id_key'+i,'msg_key'+i) ) return false;
	}
	return true;
}

function valid_psk(F){
	document.getElementById("_psk").innerHTML="";
	document.getElementById("_wl_wpa_psk").style.backgroundColor="";
	if ( F._wl_wpa_psk.value == "" )
	{
		my_alert(O_VAR,"_wl_wpa_psk",__T(msg.wlkeylen),"0","_psk","down");
		return false;
	}
	
	if ( F._wl_wpa_psk.value.length == 64 ){
        	if(!chk_chartype(F._wl_wpa_psk.value,XDIGIT))
		{ 
			my_alert(O_VAR,"_wl_wpa_psk",__T(msg.wlwpapsksecurity),"0","_psk","down");
			return false;
		}
	}
        else if(F._wl_wpa_psk.value.length >=8 && F._wl_wpa_psk.value.length <= 63 ){
		if(!chk_chartype(F._wl_wpa_psk.value,ASCII)){
			my_alert(O_VAR,"_wl_wpa_psk",__T(msg.wlwpapsksecurity),"0","_psk","down");
			 return false;
		}
        }
        else{
		parent.document.getElementById("obj_id").value = "_psk";
		my_alert(O_VAR,"_wl_wpa_psk",__T(msg.wlwpapsksecurity),"0","_psk","down");
		return false;
        }
	F.wl_wpa_psk.value = encode_data(F._wl_wpa_psk.value);
	return true;	
}

function chk_radius_key(F)
{
	clear_msg("wl_radius_key","_key");
	var errmsg =  valid_meaning_id_name(MEANING_NAME,F.wl_radius_key.value,ZERO_NO);
        if ( errmsg != "" ) 
        {
                my_alert(O_VAR,"wl_radius_key",errmsg,"0","_key");
                return false;
        }
	return true;	
}

function valid_radius(F){
	var has_err = 0 ;
//	for(var i=0; i<4; i++)
//		document.getElementById("wl_radius_ipaddr_"+i).style.backgroundColor="";
        if ( !chk_radius_key(F) ) has_err=1;
	if ( !msg_chk_range(F.wl_radius_port.value,"wl_radius_port",PORT_START,PORT_TO,10,IS_FIELD,0,"_port")) has_err = 1;
	if ( !my_valid_m_value("IP",F,"wl_radius_ipaddr","",VALID_IP_RULE1,ZERO_NO,F)) has_err=1;
	if ( has_err == 1 ) return false;
	return true;
}

function enwps_result(val)
{
	var F = document.wpa;
	alert_result(0);
	if ( val == 1 ) 
	{
		for(var i=0; i<4; i++)
		{
			if ( i == F.wl_unit.selectedIndex ) 
				eval("F.wl_wps_mode_"+F.wl_unit.selectedIndex).value = "disabled"; 
			else
				eval("F.wl_wps_mode_"+i).value =  eval("nv_wl_wps_mode_"+i);
			choose_enable(eval("F.wl_wps_mode_"+i));
		}
		chk_sec_mode(F);
	}
}

function uiDoSave(F){
	if ( eval("nv_wl_wps_mode_"+F.wl_unit.selectedIndex) == "enabled" &&
	     s_mode != "wpa2_personal" && s_mode != "wpa2_personal_mixed"  && s_mode != "disabled" )
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wldiswps),"enwps_result(1)","enwps_result(0)","","yesno");
	}else
		chk_sec_mode(F);
}

function chk_sec_mode(F)
{ 
	var showmsg=0;
//	var errflg=0;
	if ( net_mode == "n-only" && ( s_mode == "wep" || s_mode == "wpa_personal" || s_mode == "wpa_enterprise") ) 
	{
                my_alert(O_GUI,INFO,__T(share.info),__T(msg.wldroprule),"alert_result(0)");
		return;
	}
        if ( s_mode == "wpa_personal" || s_mode == "wpa2_personal" || s_mode == "wpa2_personal_mixed" ){
		if ( !chk_pwd(F._wl_wpa_psk.value) ) return;
		if ( !valid_psk(F)) return;
		if ( result < 5 ) 
	        {
			my_alert(O_VAR,"_wl_wpa_psk", __T(msg.pwdstreng),"0","_psk","down");
                	return;
	        }
		
	}
	if ( s_mode != "wep" && s_mode != "disabled")
	{
		if ( !msg_chk_range(F.wl_wpa_gtk_rekey.value,"wl_wpa_gtk_rekey",KEY_RENEWAL_START,KEY_RENEWAL_TO,10,IS_FIELD,0,"_rekey") ) 
		{	
			showmsg=1;
			return;
		}
	}

	if ( s_mode == "wep")
	{
		//my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wlwepsecurity)+"<BR><BR>"+__T(msg.wlsecurity),"wl_alert_result(1)","wl_alert_result(0)");	
		/*
		if ( !chk_key('id_key1','msg_key1') ) return;
		if ( !chk_key('id_key1','msg_key1') ) return;
		if ( !chk_key('id_key1','msg_key1') ) return;
		if ( !chk_key('id_key1','msg_key1') ) return;
		if ( !chk_key('id_key1','msg_key1') ) return; */
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wlwepsecurity)+"<BR><BR>"+__T(msg.wlsecurity),"wl_alert_result(1)","wl_alert_result(0)","","yesno");
		showmsg=1;
	}
	else if ( s_mode == "disabled")
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wldiablesecurity),"wl_alert_result(1)","wl_alert_result(0)","","yesno");	
		showmsg=1;
	}
	if ( showmsg == 0 ) wl_alert_result(1);
}

function wl_alert_result(val)
{
	alert_result(0);
	var F = document.wpa;
	var errflg=0;
	if(val == 1)
	{
		if ( s_mode == "wep" )
		{
			if ( !valid_wep(F) ) errflg = 1;
		}else if (( s_mode == "wpa_personal") || ( s_mode == "wpa2_personal" ) || ( s_mode == "wpa2_personal_mixed" ))
		{
			if ( !valid_psk(F) ) errflg = 1;
		}else if ( s_mode == "wpa_enterprise" || s_mode == "wpa2_enterprise" || s_mode == "wpa2_enterprise_mixed" ) 
		{
			if ( !valid_radius(F) ) errflg = 1;
		}
		if ( errflg == 1 ) return;
		if ( s_mode == "wpa_personal" || s_mode == "wpa_enterprise" )
	        {
			if ( net_mode == "mixed" || net_mode == "n-only" || net_mode == "gn-mixed" )
                	{
	                        //my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wlsecurity),"wl_alert_result(1)","wl_alert_result(0)");
        	                my_alert(O_GUI,INFO,__T(share.info),__T(msg.wlsecurity),"wl_save_result(1)");
				
	                }else
				wl_save_result(1);
				
        	}else
			wl_save_result(1);
	}
}

function wl_save_result(val)
{
	var F = document.wpa;
	alert_result(0);
	if ( val == 1 ){		
		F.submit_button.value = "Wireless_Security";
		F.gui_action.value = "Apply";
		F.next_page.value = "Wireless_Manual";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}

function refresh_page()
{
	var F = document.wpa;
	alert_result(0);
	SelSSID(F.basic_idx.value,F);	
}


function to_back(F){
	parent.document.getElementById("newpage").value = "Wireless_Manual.asp";
	uiDoCancel(F,"back");
	
}

function SelSSID(val,F)
{
	F.wl_vap_idx.value = val;
	F.submit_button.value = "WL_WPATable";
	F.change_action.value = "gozila_cgi";
    	choose_disable(F.next_page);
    	F.wl_security_mode.value = eval("nv_wl_security_mode_"+val);
	F.submit();
}
function check_rekey(value)
{
        if ( s_mode != "wep" && s_mode != "disabled")
        {
                if ( !msg_chk_range(value,"wl_wpa_gtk_rekey",KEY_RENEWAL_START,KEY_RENEWAL_TO,10,IS_FIELD,0,"_rekey") ) 
                {       
                        showmsg=1;
                        return;
                }
        }
}
</script>
</head>
<body onload="init();">
<FORM autocomplete=off id=frm name=wpa method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=next_page>
<input type=hidden name=wl_vap_idx value="<% nvram_gozila_get("wl_vap_idx"); %>">
<input type=hidden name=basic_idx value="<% nvram_gozila_get("basic_idx"); %>">
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=wl_wps_mode_0 value=0 disabled>
<input type=hidden name=wl_wps_mode_1 value=0 disabled>
<input type=hidden name=wl_wps_mode_2 value=0 disabled>
<input type=hidden name=wl_wps_mode_3 value=0 disabled>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.securityset),"colspan=2");</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.selssid));</script>
 		<select name="wl_unit" id="wl_unit" onChange="SelSSID(this.form.wl_unit.value,this.form);">
		<script>
		<% wl_multi_nvram_get("wl_ssid"); %>
		<% wl_multi_nvram_get("wl_bss_enabled"); %>
		var cnt=0;
		var selflg="";
		for(var i=0; i<4; i++)
		{
			//if ( eval("nv_wl_ssid_"+i) != "" && eval("nv_wl_bss_enabled_"+i) == "1" ) 
			{
				selflg="";
				if ( "<% nvram_gozila_get("wl_vap_idx"); %>" == i ) selflg = "selected";
				document.write("<option value="+i+" "+selflg+">"+eval("nv_wl_ssid_"+i)+"</option>");
			}
		}
		//document.write(eval("nv_wl_ssid_"+now_idx));
		</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>
			var TMP = "";
			if ( s_mode == "disabled" || s_mode == "(null)") TMP = SPACE_DOWN;
			draw_td(O_GUI,SUBTITLE,__TC(wl.securitymode),TMP,TMP);
		</script>
                <script>
                   var vlist = new Array("disabled","wep","wpa_personal","wpa_enterprise","wpa2_personal","wpa2_personal_mixed","wpa2_enterprise","wpa2_enterprise_mixed");
                   var data = new Array(__T(share.disabled),__T(wl.wep),__T(wl.wpap),__T(wl.wpae),__T(wl.wpa2p),__T(wl.wpa2mixed),__T(wl.wpa2e),__T(wl.wpa2emixed));
		   if ( s_mode == "" ) s_mode = eval("nv_wl_security_mode_"+now_idx);
		   draw_object(O_GUI,SELBOX,"wl_security_mode","onChange=SelMode(this.form.wl_security_mode.selectedIndex,this.form);",data,vlist,s_mode);
                </script>
                </td></tr>
		<script>
		if ( s_mode == "wep" ) 
		{
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wan.authtype));
                        var dlist = new Array(__T(wl.opensystem),__T(wl.sharedkey));
                        var val = new Array("0","1");
			draw_object(O_GUI,SELBOX,"wl_auth","",dlist,val,eval("nv_wl_auth_"+now_idx));
			document.write(" ("+__T(wl.defopensystem)+")</TR>");
		}
		</script>
		<!--TR><script>draw_td(ISHR);</script></TR-->
		<% show_wpa_setting2(); %>        
		<script>
		if ( s_mode != "wep" && s_mode != "disabled" ){
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wl.keyrenewal),"style=padding-bottom:10px","style=padding-bottom:10px");
                	document.write("<INPUT maxLength=4 id=wl_wpa_gtk_rekey name=wl_wpa_gtk_rekey size=10 onblur=check_rekey(this.value) value='"+eval("nv_wl_wpa_gtk_rekey_"+now_idx)+"'>&nbsp;"+__T(unit.seconds)+"&nbsp;&nbsp;"+spell_words(range_def_rule,"600","7200","3600"));
                	document.write("<span id=_rekey></span>");
	                document.write("</td></tr>");
		}
		</script>
        </TABLE>
	<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
