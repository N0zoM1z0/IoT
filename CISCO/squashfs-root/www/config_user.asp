<% web_include_file("filelink.asp"); %>
<script>
<% web_include_file("md5.js"); %>
<% web_include_file("encode_data.js"); %>
function en_value(data)
{
        var pseed2="";
        var buffer1=data;
        var md5Str2="";
        var Length2 = data.length;
        if (Length2 < 10 )
        {
                buffer1 += "0";
                buffer1 += Length2;
        }else{
                buffer1 += Length2;
        }
        Length2 = Length2 +2;

        for(var p=0; p<64; p++) {
                var tempCount = p % Length2;
                pseed2 += buffer1.substring(tempCount, tempCount+1);
        }
        md5Str2 = hex_md5(pseed2);
        return md5Str2;
}

function init()
{
	if ( typeof admin_verify == "undefined" && typeof guest_verify == "undefined" )
	{
		setTimeout('get_st()', 1000);
	}else{
	//	alert("admin_verify="+admin_verify+";guest_verify="+guest_verify);
		if ( admin_verify == '0' && guest_verify == '0' ) //PASS
		{
			parent.submit_data();
		}
		else
		{
			parent.show_err(admin_verify, guest_verify);
		}
	}
	
}

function get_st()
{
	var F = document.frmst;
	F.submit_button.value = "config_user";
	if ( parent.document.getElementById("enadmin").checked == true ) 
	{
		F.en_admin.value = 1;
		F.admin_old_pwd.value = "enc="+en_value(parent.document.getElementById("admin_old_pwd").value);
		F.admin_new_pwd.value = "enc="+en_value(parent.document.getElementById("admin_new_pwd").value);
		F.admin_new_name.value = parent.document.getElementById("admin_name").value;
	}
	if ( parent.document.getElementById("enguest").checked == true ) 
	{
		F.en_guest.value = 1;
		F.guest_old_pwd.value = "enc="+en_value(parent.document.getElementById("guest_old_pwd").value);
		F.guest_new_pwd.value = "enc="+en_value(parent.document.getElementById("guest_new_pwd").value);
		F.guest_new_name.value = parent.document.getElementById("guest_name").value;
		
	}
	F.action = F.action+";session_id=<% nvram_get("session_key"); %>";
	F.submit();
}
</script>
<BODY onload=init()>
<FORM name=frmst action=apply.cgi method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=web_type value="user">
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=admin_old_pwd>
<input type=hidden name=admin_new_pwd>
<input type=hidden name=admin_new_name>
<input type=hidden name=guest_old_pwd>
<input type=hidden name=guest_new_pwd>
<input type=hidden name=guest_new_name>
<input type=hidden name=en_admin value=0>
<input type=hidden name=en_guest value=0>
<input type=hidden name=commit value=0>
</FORM>
</BODY>
