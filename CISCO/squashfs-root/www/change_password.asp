<html>
<head>
<title>Users</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("md5.js"); %>
var en_diff = "<% nvram_get("en_pwddiff"); %>";
var pwd_len = "<% nvram_get("pwd_minlen"); %>";
var pwd_class = "<% nvram_get("pwd_minclass"); %>";
var result=0;
var saveflg=0;
parent.document.getElementById("newpage").value = "change_password.asp";
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("wizard_bg").style.display="none";
	var F = document.frmchpass;
	if ( (!F._en_pwd.checked && parseInt(pwd_len,10) == 0) ) 
		choose_enable(document.getElementById("c1"));
	else
		choose_disable(document.getElementById("c1"));
	default_nv = keep_val(F,"");
}

function logout()
{
	var F = document.frmchpass;
	saveflg=1;
	F.submit_button.value = "change_password";
	F.gui_action.value = "Apply";
	F.admin_old_pwd.value = en_value(F.admin_old_pwd.value);
	F.admin_new_pwd.value = en_value(F.admin_new_pwd.value);
  	F.admin_cmp_pwd.value = en_value(F.admin_cmp_pwd.value);
	if(F._en_pwd.checked == true)
		F.en_pwd.value = 0;
	else
		F.en_pwd.value = 1;
	F.next_page.value = "login";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function before_save(F)
{
	var errflg = 0 ;
	var _name = new Array("_new_pwd","_cmp_pwd");
	var tmpname="";
	
	if ( (!F._en_pwd.checked && (parseInt(pwd_len,10) > 0)) ) 
	{
		for(var i=0; i<_name.length; i++)
		{
			tmpname = "admin"+_name[i];
			clear_msg(tmpname,"msg_"+tmpname);
	
			if ( eval("F."+tmpname).value == "" ) 
			{	
				my_alert(O_VAR,tmpname,__T(msg.notblank),0,"msg_"+tmpname);
				errflg = 1 ; 
			}
		}
	}
	if ( !errflg )
	{
		if ( F.admin_new_pwd.value != F.admin_cmp_pwd.value ) 
		{
			my_alert(O_VAR,"admin_cmp_pwd",__T(msg.pwdinvmatch),0,"msg_admin_cmp_pwd");
			errflg = 1 ; 
		}
	}
	/*
	if ( en_value(F.admin_old_pwd.value) != old_pwd )
	{
		my_alert(O_VAR,"admin_old_pwd",__T(msg.oldpwdinvmatch),0,"msg_admin_old_pwd");
		errflg = 1;
	}
	if ( !errflg && !F._en_pwd.checked && en_diff == "1" )
	{
		if ( old_pwd == en_value(F.admin_new_pwd.value) ) 
		{
			my_alert(O_VAR,"admin_new_pwd",__T(msg.differold),0,"msg_admin_new_pwd");
			errflg = 1;
		}
		
	}*/ 
	if ( errflg ) return false;
	return true;
}

function show_err(return_value)
{
	clear_msg("admin_old_pwd","msg_admin_old_pwd");
	clear_msg("admin_new_pwd","msg_admin_new_pwd");
	parent.document.getElementById("save_bg").style.display="none";
	var errflg = 0;
	if ( return_value == 4 ) 
	{
		my_alert(O_VAR,"admin_old_pwd",__T(msg.oldpwdinvmatch),0,"msg_admin_old_pwd");
		errflg = 1;
	} 
	else if ( return_value == 1 )
	{
		my_alert(O_VAR,"admin_new_pwd",__T(msg.differold),0,"msg_admin_new_pwd");
		errflg = 1 ;
	} 
	else if ( return_value == 2 ) 
	{
		my_alert(O_VAR,"admin_new_pwd",__T(mang.chgpwdmsg4),0,"msg_admin_new_pwd");
		errflg = 1 ;
	}
	else if ( return_value == 6 ) 
	{
		my_alert(O_VAR,"admin_new_pwd",__T(mang.chgpwdmsg2),0,"msg_admin_new_pwd");
		errflg = 1 ;
	}
	return errflg;
}

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


function uiDoSave(F)
{
	if ( !before_save(F) ) return false;
	if ( !F._en_pwd.checked && parseInt(pwd_len,10)>0 ) 
                var returnmsg = valid_meaning_id_name(MEANING_NAME,F.admin_new_pwd.value,ZERO_NO|SPACE_NO);
        else
                var returnmsg = valid_meaning_id_name(MEANING_NAME,F.admin_new_pwd.value,SPACE_NO);
	if ( returnmsg != "" ) 
	{
                my_alert(O_VAR,"admin_new_pwd",returnmsg,0,"msg_admin_new_pwd");
		return false;
	}	
	if ( !F._en_pwd.checked ) 
	{
		check_pwd(F.admin_new_pwd.value,"_enforcementpwd");
		if ( result < 5 ) 
		{
			my_alert(O_VAR,"admin_new_pwd",__T(msg.pwdstreng),0,"msg_admin_new_pwd");
			return false;	
		}
	}

	if ( F.admin_new_pwd.value == "" ) 
                my_alert(O_GUI,WARNING,__T(share.info),__T(msg.userblankpwd),"wl_alert_result(1)","wl_alert_result(0)","","yesno");
        else
                wl_alert_result(1);
}


function wl_alert_result(val)
{
	alert_result(0);
	var F = document.frmchpass;
	if ( val == 1 ) 
	{
		/*
		saveflg=1;
		F.submit_button.value = "change_password";
		F.gui_action.value = "Apply";
	  	F.admin_old_pwd.value = en_value(F.admin_old_pwd.value);
	  	F.admin_new_pwd.value = en_value(F.admin_new_pwd.value);
  		F.admin_cmp_pwd.value = en_value(F.admin_cmp_pwd.value);
		if(F._en_pwd.checked == true)
			F.en_pwd.value = 0;
		else
			F.en_pwd.value = 1;
		F.next_page.value = "login";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
		*/
		if(F._en_pwd.checked == true)
			F.en_pwd.value = 0;
		else
			F.en_pwd.value = 1;
		document.getElementById("chkpwd").src = goto_link("config_change_pwd.asp");
		parent.document.getElementById("save_bg").style.display="";
		

	}	
}

function check_en_pwd(F)
{
	choose_disable(document.getElementById("c1"));
	if(F._en_pwd.checked == true)
	{
		my_alert(O_GUI,WARNING,__T(chpass.title),__T(chpass.enalertpwd),"chpwd_alert_result(1)","chpwd_alert_result(0)","","yesno");
		//choose_disable(document.getElementById("admin_new_pwd"));
	}else
		check_pwd(F.admin_new_pwd.value,"_enforcementpwd");
	
}

function chpwd_alert_result(idx)
{
	var F = document.frmchpass;
	if ( idx == 0 ) 
		F._en_pwd.checked = false;
	else
		choose_enable(document.getElementById("c1"));
	if ( result >= 5 ) 
		choose_enable(document.getElementById("c1"));
	alert_result(0);
	choose_enable(document.getElementById("admin_new_pwd"));
}

function check_pwd(obj_val,id)
{
	removed_pwd_result(id);	
	var F = document.frmchpass;
	document.getElementById("msg_pwd"+id).innerHTML="";
	document.getElementById("pwdtb"+id).style.display="none";
	//choose_enable(document.getElementById("c1"));

        clear_msg("admin_new_pwd","msg_admin_new_pwd");
	if ( F._en_pwd.checked == false && parseInt(pwd_len,10) > 0 ) 
                var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,ZERO_NO|SPACE_NO);
        else
                var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,SPACE_NO);
                
        if ( returnmsg != "" ) 
        {
                my_alert(O_VAR,"admin_new_pwd",returnmsg,0,"msg_admin_new_pwd");
                return false; 
        }	
	if ( F._en_pwd.checked == false ) 
	{
		result = count_pwd(obj_val,pwd_len,pwd_class);
		if ( result > 0 ) 
			document.getElementById("pwdtb"+id).style.display="";
		show_pwd_result(result,id);
		if ( result < 5 ) 
		{
			choose_disable(document.getElementById("c1"));
			my_alert(O_VAR,"admin_new_pwd",__T(msg.pwdstreng),0,"msg_admin_new_pwd");
			return false;
		}
	}
	choose_enable(document.getElementById("c1"));
	return true;
}

function chk_leave(e)
{
	if ( !e ) var e = window.event;
	if ( saveflg == 0 ) 
	{
		//top.location.href = "login.asp";
		//e.returnValue = false;
		//e.cancelBubble = true;
		/*
		if ( e.stopPropagation)
		{
			e.stopPropagation();
			e.preventDefault();
		}*/
		return false;
	} 
	return true;
}

document.onbeforeunload=chk_leave;

</script>
<body onload="init();" onbeforeunload="chk_leave(event)">
<FORM autocomplete=off id="frm" name=frmchpass method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=change_pwd>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=next_page>
<input type=hidden name=gui_action>
<input type=hidden name=en_pwd id=en_pwd>
<div class=content_layer id=divcontent>
<iframe id=chkpwd height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(chpass.title),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_MSG,"colspan=2;");
		Capture(mang.chgpwdmsg);
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_MSG,"colspan=2;");
		document.write(__T(mang.chgpwdmsg1)+"<li>"+__T(mang.chgpwdmsg2)+"</li>");
		if ( "<% nvram_get("en_pwddiff"); %>" == "1" ) 
			document.write("<li>"+__T(mang.chgpwdmsg3)+"</li>");
		document.write("<li>"+__T(mang.minpwdlen)+":&nbsp;&nbsp;<% nvram_get("pwd_minlen"); %></li><li>"+__T(mang.mincharlen)+":&nbsp;&nbsp;<% nvram_get("pwd_minclass"); %></li>");
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_MSG,"colspan=2;");
		Capture(mang.chgpwdenterpwd);
		</script></TD></TR>
		
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.oldpwd)+":");</script>
		<input size=20 maxlength=64 name=admin_old_pwd id=admin_old_pwd type=password>
		<SPAN id=msg_admin_old_pwd></SPAN>
                </TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.newpwd)+":");</script>
		<input size=20 maxlength=64 name=admin_new_pwd id=admin_new_pwd type=password onKeyUp=check_pwd(this.value,"_enforcementpwd") onblur=check_pwd(this.value,"_enforcementpwd")>
		<SPAN id=msg_admin_new_pwd></SPAN>
		</TD><TD><script>draw_td(O_GUI,PWDLINE,"_admin");</script></TD></TR>
                </TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__T(chpass.confirmpwd)+":");</script>
		<input size=20 maxlength=64 name=admin_cmp_pwd id=admin_cmp_pwd type=password>
		<SPAN id=msg_admin_cmp_pwd></SPAN>
                </TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__T(chpass.strengthpwd)+":");</script>
		<TABLE cellspacing=0 border=0>
		<TR><TD>
		</TD><TD><script>draw_td(O_GUI,PWDLINE,"_enforcementpwd");</script></TD></TR></TABLE>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=_en_pwd <% nvram_match("en_pwd","0","checked"); %> onClick=check_en_pwd(this.form);>
		<script>Capture(chpass.enforcmentpwd);</script>
		<SPAN id=msg_admin_cmp_pwd></SPAN>	
		</TD></TR>

        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
