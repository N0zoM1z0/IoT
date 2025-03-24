<input type=hidden name=wl_wpa_psk>
<script>
<% wl_multi_nvram_get("wl_wpa_psk"); %>
<% wl_multi_nvram_get("wl_crypto"); %>
<% web_include_file("security_pwd_count.js"); %>
var en_pwd = "<% nvram_get("en_pwd"); %>";
function chk_pwd(val)
{
	//var en_diff = "<% nvram_get("en_pwddiff"); %>";
	clear_msg("_wl_wpa_psk","_psk");
	/*
	if ( en_diff == "1" && en_pwd == "1" ) 
	{
		if ( eval("nv_wl_wpa_psk_"+now_idx) == val )  
		{
        		my_alert(O_VAR,"_wl_wpa_psk",__T(msg.differold),"0","_psk","down");
	                return false;
		}
			
	}*/
	var errmsg =  valid_meaning_id_name(MEANING_NAME,val,ZERO_NO);
        if ( errmsg != "" ) 
        {
        	my_alert(O_VAR,"_wl_wpa_psk",errmsg,"0","_psk","down");
                return false;
        }
	s_pwd(val,"");
	return true;

}


function s_pwd(obj_val,idx){
                var pwd_len = get_cpwd_wl_security(en_pwd,obj_val,"len");
                var pwd_class = get_cpwd_wl_security(en_pwd,obj_val,"class");
                removed_pwd_result(idx);        
                result = count_pwd(obj_val,pwd_len,pwd_class);
                document.getElementById("pwdtb"+idx).style.display="none";
                if ( result > 0 )
                        document.getElementById("pwdtb"+idx).style.display="";
                show_pwd_result(result,idx);
}

function s_pwd1(F)
{
	F._wl_wpa_psk.value = F._wl_wpa_psk2.value;
	s_pwd(F._wl_wpa_psk.value, "");
}

function chk_pwd1(F)
{
	F._wl_wpa_psk.value = F._wl_wpa_psk2.value;
	chk_pwd(F._wl_wpa_psk.value);
}


function Sel_unmaskpwd(F)
{
	if ( F.chk_unmaskpwd.checked == true ) 
	{
		F._wl_wpa_psk.value = F._wl_wpa_psk2.value;
		document.getElementById("_wl_wpa_psk").style.display="";
		document.getElementById("_wl_wpa_psk2").style.display="none";
	}else{
		F._wl_wpa_psk2.value = F._wl_wpa_psk.value;
		document.getElementById("_wl_wpa_psk").style.display="none";
		document.getElementById("_wl_wpa_psk2").style.display="";
	}
}
</script>
		<TR><script>
		     draw_td(O_GUI,SUBTITLE,__TC(wl.encryption));
		     var data,words,selflg;
			if(s_mode == "wpa_personal") {
				data = new Array("tkip+aes","aes");
				words = new Array(__T(wl.tkipaes1),__T(mang.aes));
				draw_object(O_GUI,SELBOX,"wl_crypto","",words,data,eval("nv_wl_crypto_"+now_idx));
			}else if ( s_mode == "wpa2_personal" ) {	// wpa2_enterprise
				document.write(__T(mang.aes));
			}else{ //wpa2-personal_mixed
				document.write(__T(wl.tkipaes));
			}
		</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wz.seckey));</script>
		<span id=_psk></span>
		<TABLE cellspacing=0 border=0>
		<TR><TD>
		<script>
		document.write("<INPUT size=32 type=password id=_wl_wpa_psk2 name=_wl_wpa_psk2 value='"+eval("nv_wl_wpa_psk_"+now_idx)+"' maxlength=64 onKeyUp=s_pwd1(this.form) onblur=chk_pwd1(this.form)>");
		document.write("<INPUT size=32 id=_wl_wpa_psk style='display:none' name=_wl_wpa_psk value='"+eval("nv_wl_wpa_psk_"+now_idx)+"' maxlength=64 onKeyUp=s_pwd(this.value,\"\") onblur=chk_pwd(this.value) onchange=s_pwd(this.value,\"\")>");
		</script>
		</TD><TD><script>draw_td(O_GUI,PWDLINE,"");</script></TD></TR>
		</TABLE>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.unmaskpwd));</script>
		<input type=checkbox name=chk_unmaskpwd onClick=Sel_unmaskpwd(this.form)>
		</TD></TR>
