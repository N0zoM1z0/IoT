<script>
<% wl_multi_nvram_get("wl_wpa_psk"); %>
<% wl_multi_nvram_get("wl_crypto"); %>
<% web_include_file("security_pwd_count.js"); %>
var en_pwd = parse_data("en_pwd");
function chk_pwd(val)
{
	clear_msg("wl_wpa_psk","_psk");
	/*
	var en_diff = "<% nvram_get("en_pwddiff"); %>";
	if ( en_diff == "1" && en_pwd == "1" ) 
        {
                if ( eval("nv_wl_wpa_psk_"+now_idx) == val )  
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

function s_pwd(obj_val,idx){
		var en_pwd = parse_data("en_pwd");
                var pwd_len = get_cpwd_wl_security(en_pwd,obj_val,"len");
                var pwd_class = get_cpwd_wl_security(en_pwd,obj_val,"class"); 
                result = count_pwd(obj_val,pwd_len,pwd_class);
                removed_pwd_result(idx);        
                document.getElementById("pwdtb"+idx).style.display="none";
                if ( result > 0 )
                        document.getElementById("pwdtb"+idx).style.display="";
                show_pwd_result(result,"");
}
</script>
		<TR><script>
		     draw_td(O_GUI,SUBTITLE,__T(wl.encryption)+":");
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
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(wz.seckey)+":");</script>
		<span id=_psk></span>
		<TABLE cellspacing=0 border=0><TR><TD>
		<!--TABLE cellspacing=0 border=0><TR><TD-->
		<script>
		document.write("<INPUT size=32 id=wl_wpa_psk name=wl_wpa_psk value='"+eval("nv_wl_wpa_psk_"+now_idx)+"' maxlength=64 onKeyUp=s_pwd(this.value,\"\") onblur=chk_pwd(this.value)>");
		</script>
		</TD><TD align=left><script>draw_td(O_GUI,PWDLINE,"");</script></TD></TR></TABLE></TD>
		</tr>					
