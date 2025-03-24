<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
<% web_include_file("security_pwd_count.js"); %>
var result=0;
var en_pwd = parseInt('<% nvram_get("en_pwd"); %>',10);
function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide_security.asp"),395,370);
	else
		HelpDialog(goto_link("guide_security.asp"),355,370);
}

function s_pwd(obj_val,idx){
		var en_pwd = parse_data("en_pwd");
                var pwd_len = get_cpwd_wl_security(en_pwd,obj_val,"len");
		var pwd_class = get_cpwd_wl_security(en_pwd,obj_val,"class"); 
                result = count_pwd(obj_val,pwd_len,pwd_class);
		var F = document.wz_sec;
                result = count_pwd(obj_val,pwd_len,pwd_class);
		removed_pwd_result(idx);	
		document.getElementById("pwdtb"+idx).style.display="none";
                if ( result > 0 )
                        document.getElementById("pwdtb"+idx).style.display="";
                show_pwd_result(result,"");
}
	
function init()
{
	var F = document.wz_sec;
	var sec_mode = parse_data("security_mode");
	if ( sec_mode == "wpa2_personal" ) 
	{
		F.sec_type[0].checked = true;
		sel_sectype(0);
	}
	else if ( sec_mode == "wpa_personal" )
	{
		F.sec_type[1].checked = true;
		sel_sectype(1);
	}
	else if ( sec_mode == "disabled" ) 
	{
		F.sec_type[2].checked = true;
		sel_sectype(2);
	}
	get_wpa_psk();
	s_pwd(F.wl_wpa_psk.value,"");
	def_nv = keep_val(F,""); 
}

function chk_pwd(val)
{
	var F = document.wz_sec;
	if ( F.sec_type[2].checked ) return true;
	<% wl_multi_nvram_get("wl_wpa_psk"); %>
	clear_msg("wl_wpa_psk","_psk");
	/*
	var en_diff = "<% nvram_get("en_pwddiff"); %>";
	if ( en_diff == "1" && en_pwd == "1" ) 
        {
                if ( nv_wl_wpa_psk_0 == val )  
                {
			w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.differold),"down");
                        return false;
                }
        }*/
	var errmsg =  valid_meaning_id_name(MEANING_NAME,val,ZERO_NO);
        if ( errmsg != "" ) 
        {
		w_set_alert("_psk",0,"wl_wpa_psk",errmsg,"down");
        	return false;
        }
	s_pwd(val,"");
	return true;

}

function goto_next(F)
{
	if ( http_power == "r" ) 
		wl_next_result(1);
	else
	{
		if ( !chk_pwd(F.wl_wpa_psk.value) ) return;
	        if ( !valid_psk(F) ) return;
		if ( F.sec_type[2].checked ) result = 5;
		if ( result < 5 ) 
		{
			w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.pwdstreng),"down");
			return;
		}
		if ( F.sec_type[2].checked )
		{
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(msg.nosecconfirm),"wl_next_result(1)","wl_next_result(0)","wizard","yesno");
			parent.document.getElementById("a2").focus();
		}else
			wl_next_result(1);
	}
}

function wl_next_result(val)
{
	alert_result(0);
	var F = document.wz_sec;
	if(val == 1){
		if ( F.sec_type[0].checked )
	        {
        		save_data("security_mode", "wpa2_personal");
	                save_data("crypto", "aes");
	                save_data("wpa_psk", F.wl_wpa_psk.value);
	        }else if ( F.sec_type[1].checked ){
        	        save_data("security_mode", "wpa_personal");
	                save_data("crypto", "tkip+aes");
	                save_data("wpa_psk", F.wl_wpa_psk.value);
	        }else if ( F.sec_type[2].checked ) 
        	{
	                save_data("security_mode","disabled");
	        }
		document.location.href = goto_link("/wizard/sec_4.asp");
	}
}

function sel_sectype(val)
{
	var F = document.wz_sec;
	if ( val == 2 ) 
		choose_disable(F.wl_wpa_psk);
	else
		choose_enable(F.wl_wpa_psk);
	valid_psk(F);
}

function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv,2) ) 
                my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard");
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

function get_wpa_psk()
{
	var nv_psk = parse_data("wpa_psk");
	var rnd, tmp="";
	if ( nv_psk == "" ) 
	{
		for(var i=0; i<26; i++)
		{
			while(1)
			{
				rnd = Math.ceil(Math.random()*122);
				// 48 - 57 : 0 - 9
                                // 65 - 90 : A - Z
                                // 97 - 122 : a - z
				if ( ( rnd < 48 ) || ( rnd >=58 && rnd <= 64 ) || (rnd >=91 && rnd <=96 ) ) 
					rnd = Math.ceil(Math.random()*122);
				else
					break;
			}
			tmp+=String.fromCharCode(rnd);
		}	
		document.getElementById("wl_wpa_psk").value = tmp;
	}else{
		document.getElementById("wl_wpa_psk").value = nv_psk;
	}	
}

function valid_psk(F)
{
	document.getElementById("_psk").innerHTML = "";
	document.getElementById("wl_wpa_psk").style.backgroundColor="";
	if ( F.sec_type[2].checked ) return true;
	if ( F.wl_wpa_psk.value == "" )
        {
                parent.document.getElementById("obj_id").value = "_psk";
		w_set_alert("_psk",0,"wl_wpa_psk",__T(msg.notblank),"down");
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

</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_sec" method=<% get_http_method(); %>>
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
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setwlnet);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE>
     <TR><TD valign=top class=DATA_ITEM><script>Capture(wz.selsec);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM2_NOTOP>
     <TABLE>
     <TR><TD><input type=radio name=sec_type value=0 checked onclick=sel_sectype(0)><script>Capture(wz.bestsec1);</script></TD></TR>
     <TR><TD style=padding-left:20px><script>Capture(wz.aesdesc);</script></TD></TR>
     <TR><TD><input type=radio name=sec_type value=1 onclick=sel_sectype(1)><script>Capture(wz.bestsec2);</script></TD></TR>
     <TR><TD style=padding-left:20px><script>Capture(wz.tkipdesc);</script></TD></TR>
     <TR><TD><input type=radio name=sec_type value=2 onclick=sel_sectype(2)><script>Capture(wz.nosec);</script></TD></TR>
     </TABLE>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM>
     <script>Capture(wz.enterseckey);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM2_NOTOP>
     <span id=_psk></span>
     <TABLE><TR><TD>
     <input size=50 maxlength=64 id=wl_wpa_psk name=wl_wpa_psk onKeyUp=s_pwd(this.value,"") onblur=chk_pwd(this.value) value=e471afE3a6FFa24B8fE01709e4></TD><TD align=left><script>draw_td(O_GUI,PWDLINE,"");</script></TD></TR></TABLE>
     </TD></TR>	
     <TR><TD class=DATA_ITEM2_NOTOP><TABLE><TR><TD width=12px><img src="../image/wizardHelp.png"></TD><TD align=left valign=center>
     <A href=javascript:void(0) onclick="javascript:goto_guide()"><script>Capture(wz.sechelplink);</script></A>
    </TD></TR>
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
