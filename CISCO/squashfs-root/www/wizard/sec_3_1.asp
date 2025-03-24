<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_auth"); %>
<% wl_multi_nvram_get("wl_crypto"); %>
<% wl_multi_nvram_get("wl_wpa_gtk_rekey"); %>
var vlist = new Array("disabled","wep","wpa_personal","wpa_enterprise","wpa2_personal","wpa2_personal_mixed","wpa2_enterprise","wpa2_enterprise_mixed");
var result=0;
var now_idx = "0";
var s_mode = "<% nvram_gozila_get("wl_security_mode"); %>";
if ( s_mode == "(null)" ) s_mode = parse_data("security_mode");
var net_mode = "<% nvram_get("wl_net_mode"); %>";
function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide_security.asp"),395,370);
	else
		HelpDialog(goto_link("guide_security.asp"),355,370);
}

function init()
{
        var F = document.wz_sec;
	for(var i=0; i<vlist.length; i++)
	{
		if ( s_mode == vlist[i] ) 
		{
			F.wl_security_mode.selectedIndex = i;
			break;
		}
	}
	if ( s_mode == "wep" ) 
	{
		F.wl_auth.value = parse_data("wlauth");	
		F.wl_key1.value = parse_data("key1");
		F.wl_key2.value = parse_data("key2");
		F.wl_key3.value = parse_data("key3");
		F.wl_key4.value = parse_data("key4");
		if ( parse_data("sel_key") != "" ) 
		{
			for(var i=0; i<4; i++)
			{
				if ( parse_data("sel_key") == (i+1) ) 
				F.wl_key.selectedIndex = i;
			}
		}
		F.wl_passphrase.value = parse_data("passphrase");
	}else if ( s_mode == "wpa_personal" || s_mode == "wpa2_personal" || s_mode == "wpa2_personal_mixed" )
	{
		if ( s_mode == "wpa_personal" ) 
		{
			if ( parse_data("crypto") == "tkip+aes" )
				F.wl_crypto.selectedIndex = 0;
			else
				F.wl_crypto.selectedIndex = 1;
		}
	        F.wl_wpa_psk.value = parse_data("wpa_psk");
		F.wl_wpa_gtk_rekey.value = parse_data("wpa_gtk_rekey");
	}else if ( s_mode == "wpa_enterprise" || s_mode == "wpa2_enterprise" || s_mode == "wpa2_enterprise_mixed" ) 
	{
		if ( s_mode == "wpa_enterprise" ){
			if ( parse_data("crypto") == "tkip+aes" )
				F.wl_crypto.selectedIndex = 0;
			else
				F.wl_crypto.selectedIndex = 1;
		}
		var tmpip = parse_data("radius_ipaddr").split(".");
		if ( tmpip.length == 4 ) 
		{
			for(var i=0; i<4; i++)
				eval("F.wl_radius_ipaddr_"+i).value = tmpip[i];

		}
		F.wl_radius_port.value = parse_data("radius_port");
		F.wl_radius_key.value = parse_data("radius_key");
		F.wl_wpa_gtk_rekey.value = parse_data("wpa_gtk_rekey");
	}
	if (( s_mode == "wpa_personal") || ( s_mode == "wpa2_personal" ) || ( s_mode == "wpa2_personal_mixed" ))
		s_pwd(F.wl_wpa_psk.value,"");
	def_nv = keep_val(F,""); 

}

function valid_psk(F)
{
	document.getElementById("_psk").innerHTML = "";
	document.getElementById("wl_wpa_psk").style.backgroundColor="";
	if ( F.wl_wpa_psk.value == "" )
        {
                parent.document.getElementById("obj_id").value = "_psk";
		w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.wlsharesecret),"down");
                return false;
        }
        
        if ( F.wl_wpa_psk.value.length == 64 ){
		if(!chk_chartype(F.wl_wpa_psk.value,XDIGIT))
                { 
			w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.wlwpapsksecurity),"down");
                        return false;
                }
	}
        else if(F.wl_wpa_psk.value.length >=8 && F.wl_wpa_psk.value.length <= 63 ){
               	if(!chk_chartype(F.wl_wpa_psk.value,ASCII))
		{
			w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.wlwpapsksecurity),"down");
			return false;
		}	
        }else{
                parent.document.getElementById("obj_id").value = "_psk";
		w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.wlwpapsksecurity),"down");
                return false;
	}
	return true;
}

function valid_wep(F)
{
	var has_err=0;
	var selidx = parseInt(F.wl_key[F.wl_key.selectedIndex].value,10);
	var wepbit = parseInt(F.wl_wep_bit[F.wl_wep_bit.selectedIndex].value,10);
	var tmp="";
	for (var i=1; i<=4; i++)
	{
		tmp = document.getElementById("id_key"+i).value;
		if ( tmp == "" ){
			if ( i == selidx ) 
			{
				parent.document.getElementById("obj_id").value = "msg_key"+i;
				w_set_alert("msg_key"+i,0,"id_key"+i,__T(msg.wlkeylen));
                                has_err=1;

			}else
				continue;
		} 
	        if ( !chk_chartype(tmp,XDIGIT) )
                {
                        parent.document.getElementById("obj_id").value = "msg_key"+i;
			w_set_alert("msg_key"+i,0,"id_key"+i,spell_words(hex_rule,"Key"+i));
                        has_err=1;
                }
                if ( ( wepbit == 64 && tmp.length != 10 ) || ( wepbit == 128 && tmp.length != 26 ))
                {
                        parent.document.getElementById("obj_id").value = "msg_key"+i;
			w_set_alert("msg_key"+i,0,"id_key"+i,__T(msg.wlkeylen));
                        has_err=1;
                }
	}
	if ( has_err == 1 ) return false;
	return true;
}

function valid_radius(F){
	var has_err = 0 ;
	document.getElementById("_key").innerHTML="";
	document.getElementById("wl_radius_key").style.backgroundColor="";
	for(var i=0; i<4; i++)
		document.getElementById("wl_radius_ipaddr_"+i).style.backgroundColor="";
	if ( !chk_range("wl_radius_port",F.wl_radius_port.value,PORT_START,PORT_TO,10)) 
	{
		w_set_alert("_port",0,"wl_radius_port",spell_words(range_rule,PORT_START,PORT_TO),"down");
		has_err = 1;
	}
	if ( check_ipv4(get_full_ip(F,"wl_radius_ipaddr"),VALID_IP_RULE1,ZERO_NO) <=0 ) 
	{
		w_set_alert("_rip",4,"wl_radius_ipaddr",__T(msg.ivalidipformat),"down");
		has_err = 1;
	}
        if ( F.wl_radius_key.value == "" )
        {
                parent.document.getElementById("obj_id").value = "_key";
		w_set_alert("_key",0,"wl_radius_key",__T(msg.wlsharekey),"down");
		has_err=1;
        }
	if ( has_err == 1 ) return false;
	return true;
}

function goto_next(F)
{
	var showmsg=0;
//	var errflg=0;

        if ( s_mode == "wep" ) 
        {
        	if ( !valid_wep(F) ) return;
        }else if ( s_mode == "wpa_personal" || s_mode == "wpa2_personal" || s_mode == "wpa2_personal_mixed" ){
		if ( !chk_pwd(F.wl_wpa_psk.value) ) return;
                if ( !valid_psk(F) ) return;
		if ( result < 5 ) 
	        {
        	        w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.pwdstreng),"down");
                	return;
	        }
        }else if ( s_mode == "wpa_enterprise" || s_mode == "wpa2_enterprise" || s_mode == "wpa2_enterprise_mixed" ){ 
                if ( !valid_radius(F) ) return;
        }

	
	if ( s_mode != "wep" && s_mode != "disabled")
	{
		if ( !chk_range("wl_wpa_gtk_rekey",F.wl_wpa_gtk_rekey.value,KEY_RENEWAL_START,KEY_RENEWAL_TO,10)) 
		{
			w_set_alert("_rekey",0,"wl_wpa_gtk_rekey",spell_words(range_rule,KEY_RENEWAL_START,KEY_RENEWAL_TO),"down");
			showmsg=1;
			return;
		}
	}
	if ( s_mode == "wep" ||  s_mode == "wpa_personal" || s_mode == "wpa_enterprise" )
	{
		if ( net_mode == "mixed" || net_mode == "n-only" ) 
		{
                        //my_alert(O_GUI,WARNING,__T(share.info),__T(msg.wlsecurity),"wl_next_result(1)","wl_next_result(0)","wizard");
                        my_alert(O_GUI,INFO,__T(share.info),__T(msg.wlsecurity),"wl_next_result(1)","wizard");
                        showmsg=1;
		}
	}

	if ( s_mode == "disabled" )
	{
		my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(msg.nosecconfirm),"wl_next_result(1)","wl_next_result(0)","wizard","yesno");
		parent.document.getElementById("a2").focus();
		showmsg = 1 ;
	}
	if ( showmsg == 0 ) wl_next_result(1);
}

function wl_next_result(val)
{
	alert_result(0);
	var F = document.wz_sec;
	if(val == 1){
		
		save_data("security_mode",  F.wl_security_mode.value);
		if ( s_mode == "disabled" ) // Disabled
	        {
	                save_data("security_mode","disabled");
		}else if ( s_mode == "wep" ) // WEP
		{
			save_data("wlauth",F.wl_auth.value);
			save_data("key1",F.wl_key1.value);
			save_data("key2",F.wl_key2.value);
			save_data("key3",F.wl_key3.value);
			save_data("key4",F.wl_key4.value);
			save_data("key",F.wl_key.value);
			save_data("passphrase",F.wl_passphrase.value);
			save_data("wepbit",F.wl_wep_bit[F.wl_wep_bit.selectedIndex].value);
		}else if ( s_mode == "wpa_personal" || s_mode == "wpa2_personal" || s_mode == "wpa2_personal_mixed" )
		{
			if ( s_mode == "wpa_personal") save_data("crypto", F.wl_crypto.value);
	                save_data("wpa_psk", F.wl_wpa_psk.value);
			save_data("wpa_gtk_rekey",F.wl_wpa_gtk_rekey.value);
		}else if ( s_mode == "wpa_enterprise" || s_mode == "wpa2_enterprise" || s_mode == "wpa2_enterprise_mixed" ) 
		{
			if ( s_mode == "wpa_enterprise" ) save_data("crypto", F.wl_crypto.value);
			save_data("radius_ipaddr",get_full_ip(F,"wl_radius_ipaddr"));
			save_data("radius_port", F.wl_radius_port.value);
			save_data("radius_key", F.wl_radius_key.value);	
			save_data("wpa_gtk_rekey", F.wl_wpa_gtk_rekey.value);
		}
		parent.frames["wizard"].location.href = goto_link("/wizard/sec_4.asp");
	}
}

function sel_sectype(val)
{
	var F = document.wz_sec;
	if ( val == 2 ) 
		choose_disable(F.key);
	else
		choose_enable(F.key);
}

function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv,2) ) 
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

function SelMode(num,F)
{
    F.wl_security_mode.value=F.wl_security_mode.options[num].value;
    var smode = F.wl_security_mode.value;
    if ( net_mode == "n-only" && ( smode == "wep" || smode == "wpa_personal" || smode == "wpa_enterprise") ) 
    {
                my_alert(O_GUI,INFO,__T(share.info),__T(msg.wldroprule),"alert_result(0)","wizard");
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
    F.submit_button.value = "wizard/sec_3_1";
    F.change_action.value = "gozila_cgi";
    F.submit_type.value = "security_mode";
    choose_disable(F.next_page);
    F.submit();
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_sec" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wizard_start>
<input type=hidden name=wl_vap_idx value="0">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setwlnet);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE>
     <TR><TD valign=top class=DATA_ITEM><script>Capture(wz.selsec);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM2_NOTOP>
     <TABLE>
     <TR><TD><TABLE><script>
     	var data = new Array(__T(share.disabled),__T(wl.wep),__T(wl.wpap),__T(wl.wpae),__T(wl.wpa2p),__T(wl.wpa2mixed),__T(wl.wpa2e),__T(wl.wpa2emixed));
	if ( s_mode == "" ) s_mode = eval("nv_wl_security_mode_"+now_idx);
	draw_td(O_GUI,SUBTITLE,__T(wl.securitymode)+":");
	draw_object(O_GUI,SELBOX,"wl_security_mode","onChange=SelMode(this.form.wl_security_mode.selectedIndex,this.form);",data,vlist,s_mode);
	
	if ( s_mode == "wep" ) 
	{
		document.write("<TR>");
                draw_td(O_GUI,SUBTITLE,__T(wan.authtype)+":");
                var dlist = new Array(__T(wl.opensystem),__T(wl.sharedkey));
                var val = new Array("0","1");
                draw_object(O_GUI,SELBOX,"wl_auth","",dlist,val,eval("nv_wl_auth_"+now_idx));
                document.write(" ("+__T(wl.defopensystem)+")</TR>");
	}
     </script>
     <% show_wpa_setting2("wizard"); %>        
     <script>
     if ( s_mode != "wep" && s_mode != "disabled" ){
               document.write("<TR>");
               draw_td(O_GUI,SUBTITLE,__T(wl.keyrenewal)+":","style=padding-bottom:10px","style=padding-bottom:10px");
               document.write("<span id=_rekey></span>");
	       document.write("<TABLE cellspacing=0 border=0><TR><TD>");
               document.write("<INPUT maxLength=4 id=wl_wpa_gtk_rekey name=wl_wpa_gtk_rekey size=10 value='"+eval("nv_wl_wpa_gtk_rekey_"+now_idx)+"'>&nbsp;"+__T(unit.seconds)+"&nbsp;&nbsp;"+spell_words(range_def_rule,"600","7200","3600"));
                        
                document.write("</TD></TR></TABLE></td></tr>");
     }
     </script>
   </TABLE></TD></TR>
    </TABLE>
    </TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD class=DATA_ITEM2_NOTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"sec_2.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
