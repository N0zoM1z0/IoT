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
	if ( typeof verify == "undefined" )
	{
		setTimeout('get_st()', 1000);
	}else{
		if ( verify == '0' ) //PASS
		{
			parent.logout();
	
		}
		else
			parent.show_err(verify);
	}
	
}

function get_st()
{
	var F = document.frmst;
	F.submit_button.value = "config_change_pwd";
	F.admin_old_pwd.value = "enc="+en_value(parent.document.getElementById("admin_old_pwd").value);
	F.admin_new_pwd.value = "enc="+en_value(parent.document.getElementById("admin_new_pwd").value);
	F.en_pwd.value = parent.document.getElementById("en_pwd").value;
	F.action = F.action+";session_id=<% nvram_get("session_key"); %>";
	//alert(F.action);
	F.submit();
}
</script>
<BODY onload=init()>
<FORM name=frmst action=apply.cgi method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=web_type value="changpwd">
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=admin_old_pwd>
<input type=hidden name=admin_new_pwd>
<input type=hidden name=en_pwd>
<input type=hidden name=commit value=0>
</FORM>
</BODY>
