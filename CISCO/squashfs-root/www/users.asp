<html>
<head>
<title>Users</title>
<script type="text/javascript" src="/md5.js"></script>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var en_pwd = "<% nvram_get("en_pwd"); %>";
var pwd_len = "<% nvram_get("pwd_minlen"); %>";
var result=0;
var result_type="";
function init(){
	var F = document.frmuser;
	sel_user(F);
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		choose_disable(document.getElementById("fileTxtBox"));
		return;
	}
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("hidden_bg").style.display="none";
	default_nv = keep_val(document.frmuser,"");
}


function sel_url(obj)
{
        document.getElementById('txtUploadFile').value = getPath(obj);
}

function sel_user(F)
{
	if ( F.enadmin.checked == true ) 
		DISABLE_PART(F,"admin_start","admin_end",0);
	else
		DISABLE_PART(F,"admin_start","admin_end",1);
	if ( F.enguest.checked == true ) 
		DISABLE_PART(F,"guest_start","guest_end",0);
	else
		DISABLE_PART(F,"guest_start","guest_end",1);
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

function before_save(F)
{
	if ( F.enadmin.checked == true ) 
	{
		if ( !chk_val("admin") ) return false;
	}
	if ( F.enguest.checked == true ) 
	{
		if ( !chk_val("guest") ) return false;
	}
	return true;
}

function chk_val(username)
{
	var errflg = 0 ;
	var F = document.frmuser;
	var _name = new Array("_name","_old_pwd","_new_pwd","_cmp_pwd");
	for(var i=0; i<_name.length; i++)
	{
		tmpname = username+_name[i];
		if ( username == "admin" ) 
			clear_msg("admin"+_name[i],"msg_admin"+_name[i]);
		else
			clear_msg("guest"+_name[i],"msg_guest"+_name[i]);
		if ( _name[i] == "_old_pwd") continue;	
		if ( _name[i] == "_name" )
		{
			if ( !check_name(eval("F."+tmpname).value,tmpname) ) errflg = 1;
			if ( eval("F."+tmpname).value == "" ) 
			{
				my_alert(O_VAR,tmpname,__T(msg.notblank),0,"msg_"+tmpname);
				errlfg = 1;
			}else{
				var returnmsg = valid_meaning_id_name(MEANING_NAME,eval("F."+tmpname).value,ZERO_NO|SPACE_NO); 
				if ( returnmsg != "" ) 
				{
					my_alert(O_VAR,tmpname,returnmsg,0,"msg_"+tmpname);
					errlfg = 1;
				}
			}
		}
		if ( en_pwd == "1" && pwd_len >= 1 )
		{
			if (  eval("F."+tmpname).value == "" )  
			{
				if ( _name[i] == "_new_pwd" ) 
					my_alert(O_VAR,tmpname,__T(msg.notblank),0,"msg_"+tmpname,"down");
				else
					my_alert(O_VAR,tmpname,__T(msg.notblank),0,"msg_"+tmpname);
				errflg = 1 ; 
			}
		}
	}
	if ( !errflg )
	{
		if ( username == "admin" ) 
		{
			if ( F.admin_new_pwd.value != F.admin_cmp_pwd.value ) 
			{
				my_alert(O_VAR,"admin_cmp_pwd",__T(msg.pwdinvmatch),0,"msg_admin_cmp_pwd");
				errflg = 1 ; 
			}
		}else{
			if ( F.guest_new_pwd.value != F.guest_cmp_pwd.value ) 
			{
				my_alert(O_VAR,"guest_cmp_pwd",__T(msg.pwdinvmatch),0,"msg_guest_cmp_pwd");
				errflg = 1 ; 
			}
		}
	}
	if ( errflg ) return false;
	return true;
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


function valid_en_pwd(usertype,obj_val)
{
	var F = document.frmuser;
	if ( (en_pwd == "1") && (pwd_len >= 1) ) 
                var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,ZERO_NO|SPACE_NO);
        else
                var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,SPACE_NO);
	if ( returnmsg != "" ) 
        {
                if ( usertype == "admin" ) 
                        my_alert(O_VAR,"admin_new_pwd",returnmsg,0,"msg_admin_new_pwd","down");
                else
                        my_alert(O_VAR,"guest_new_pwd",returnmsg,0,"msg_guest_new_pwd","down");
                return false; 
        }
        if ( en_pwd == "1" && parseInt(pwd_len,10) >0 && result < 5 ) 
        {
                if ( result_type == "_admin" ) 
                        my_alert(O_VAR,"admin_new_pwd",__T(msg.pwdstreng),0,"msg_admin_new_pwd","down");
                else
                        my_alert(O_VAR,"guest_new_pwd",__T(msg.pwdstreng),0,"msg_guest_new_pwd","down");
                return false;   
                
        }
	if ( en_pwd == "1" )
	{
                if ( usertype == "admin" ) 
		{
			if ( F.admin_new_pwd.value == F.admin_name.value ) 
			{
                        	my_alert(O_VAR,"admin_new_pwd",__T(mang.chgpwdmsg4),0,"msg_admin_new_pwd","down");
				return false;
			}
			if ( F.admin_new_pwd.value == F.guest_name.value ) 
			{
                        	my_alert(O_VAR,"admin_new_pwd",__T(mang.chgpwdmsg2),0,"msg_admin_new_pwd","down");
				return false;
			}
		}else{
			if ( F.guest_new_pwd.value == F.guest_name.value ) 
			{
                        	my_alert(O_VAR,"guest_new_pwd",__T(mang.chgpwdmsg2),0,"msg_guest_new_pwd","down");
				return false;
			}
		}
		
	} 
	return true;

}
function uiDoSave(F)
{
	if ( !before_save(F) ) return false;
	if ( F._en_guest.checked == true ) 
                F.en_guest.value = 1;
        else
                F.en_guest.value = 0;
	if ( F.enadmin.checked == true ) 
	{
		if ( !valid_en_pwd("admin",F.admin_new_pwd.value) ) return false;
	}
	if ( F.enguest.checked == true ) 
	{
		if ( !valid_en_pwd("guest",F.guest_new_pwd.value) ) return false;
	}
	if ( ( F.enadmin.checked == true && F.admin_new_pwd.value.length == 0 ) ||
	     ( F.enguest.checked == true && F.guest_new_pwd.value.length == 0 ) )
                my_alert(O_GUI,WARNING,__T(share.info),__T(msg.userblankpwd),"wl_alert_result(1)","wl_alert_result(0)","","yesno");
	else
		wl_alert_result(1);
}

function show_err(admin_err, guest_err)
{
	clear_msg("admin_name","msg_admin_name");
	clear_msg("admin_new_pwd","msg_admin_new_pwd");
	clear_msg("admin_old_pwd","msg_admin_old_pwd");
	clear_msg("guest_name","msg_guest_name");
	clear_msg("guest_new_pwd","msg_guest_new_pwd");
	clear_msg("guest_old_pwd","msg_guest_old_pwd");
	parent.document.getElementById("save_bg").style.display="none";
	if ( admin_err != "0" )
	{
		if ( admin_err == "1" ) 
	       		my_alert(O_VAR,"admin_new_pwd",__T(msg.differold),0,"msg_admin_new_pwd","down");
		else if ( admin_err == "4" ) 
	       		my_alert(O_VAR,"admin_old_pwd",__T(msg.oldpwdinvmatch),0,"msg_admin_old_pwd");
		else if ( admin_err == "6" ) 
	       		my_alert(O_VAR,"admin_name",__T(mang.chgpwdmsg2),0,"msg_admin_name");
		else if ( admin_err == "2" ) 
	       		my_alert(O_VAR,"admin_new_pwd",__T(mang.chgpwdmsg4),0,"msg_admin_new_pwd","down");
	}
	if ( guest_err != "0" ) 
	{
		if ( guest_err == "1" ) 
	       		my_alert(O_VAR,"guest_new_pwd",__T(msg.differold),0,"msg_guest_new_pwd","down");
		else if ( guest_err == "4" ) 
	       		my_alert(O_VAR,"guest_old_pwd",__T(msg.oldpwdinvmatch),0,"msg_guest_old_pwd");
		else if ( guest_err == "5" ) 
	       		my_alert(O_VAR,"guest_name",__T(mang.chgpwdmsg4),0,"msg_guest_name");
		else if ( guest_err == "2" ) 
	       		my_alert(O_VAR,"guest_new_pwd",__T(mang.chgpwdmsg2),0,"msg_guest_new_pwd","down");
	} 
}

function submit_data()
{
	var F = document.frmuser;
	F.submit_button.value = "users";
        F.gui_action.value = "Apply";
        F.next_page.value = "users";
        if ( F.enguest.checked == true ) 
        {
                F.guest_old_pwd.value = en_value(F.guest_old_pwd.value);
                F.guest_new_pwd.value = en_value(F.guest_new_pwd.value);
                F.guest_cmp_pwd.value = en_value(F.guest_cmp_pwd.value);
        }
        if ( F.enadmin.checked == true ) 
        {
        	F.admin_old_pwd.value = en_value(F.admin_old_pwd.value);
                F.admin_new_pwd.value = en_value(F.admin_new_pwd.value);
                F.admin_cmp_pwd.value = en_value(F.admin_cmp_pwd.value);
        	F.next_page.value = "login";
        }
        F.submit();
} 

function wl_alert_result(val)
{
	alert_result(0);
	var F = document.frmuser;
	if ( val == 1 ) 
	{
		document.getElementById("chkpwd").src = goto_link("config_user.asp");
		parent.document.getElementById("save_bg").style.display="";
	}
	
}

function check_name(obj_val,id)
{
	clear_msg(id,"msg_"+id);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,ZERO_NO|SPACE_NO); 
	if ( returnmsg != "" ) 
	{
       		my_alert(O_VAR,id,returnmsg,0,"msg_"+id);
		return false;
	}
	return true;
}

function check_pwd(obj_val,id)
{
	removed_pwd_result(id);	
	document.getElementById("pwdtb"+id).style.display="none";
	document.getElementById("msg_pwd"+id).innerHTML="";
        if ( id == "_admin" ) 
		clear_msg("admin_new_pwd","msg_admin_new_pwd");
	else
		clear_msg("guset_new_pwd","msg_guest_new_pwd");
	if ( (en_pwd == "1") && (pwd_len >= 1) ) 
               	var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,ZERO_NO|SPACE_NO);
	else
               	var returnmsg = valid_meaning_id_name(MEANING_NAME,obj_val,SPACE_NO);
		
        if ( returnmsg != "" ) 
        {
                if ( id == "_admin" ) 
        	        my_alert(O_VAR,"admin_new_pwd",returnmsg,0,"msg_admin_new_pwd","down");
                else
                        my_alert(O_VAR,"guest_new_pwd",returnmsg,0,"msg_guest_new_pwd","down");
                return; 
	}
	if ( (en_pwd == "1") && (pwd_len >= 1) ) 
	{
		var pwd_class = "<% nvram_get("pwd_minclass"); %>";
		result = count_pwd(obj_val,pwd_len,pwd_class);
		if ( result > 0 ) 
			document.getElementById("pwdtb"+id).style.display="";
		show_pwd_result(result,id);
	}
	if ( result < 5 ) result_type = id; 
}

function to_import(F)
{         var len = F.importusers.value.length;
        var ext = new Array('.','c','s','v');
        F.submit_button.value = "users";
        clear_msg("txtUploadFile","msg_file");
        if (F.importusers.value != '') {
                        var IMAGE = F.importusers.value.toLowerCase();
                        for (var i=0; i < 4; i++)   {
                                if (ext[i] != IMAGE.charAt(len-4+i)){
                                        my_alert(O_VAR,"txtUploadFile",__T(fwupgrade.wrimage),"0","msg_file");
                                        return false;
                                }
                        }
                        F.action = goto_link("import.cgi");
                        F.encoding="multipart/form-data";
                        F.submit();
                        parent.document.getElementById("hidden_bg").style.display="";
        }
}

function sel_url(obj)
{
        document.getElementById("txtUploadFile").value = getPath(obj);
}

function to_download(F)
{
	window.location.href="User_Import_Templete.csv";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmuser method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=next_page>
<input type=hidden name=en_guest id=en_guest>
<div class=content_layer id=divcontent>
<iframe id=chkpwd height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.users),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.usersel),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(mang.editadmin));</script>
		<input type=checkbox disabled name=seladmin checked> <script>Capture(router.active);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(mang.editguest));</script>
	        <input type=checkbox name=_en_guest id=_en_guest <% nvram_match("en_guest","1","checked"); %>> <script>Capture(router.active);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.adminset),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(mang.editadminset));</script>
		<input type=checkbox id=enadmin name=enadmin onclick=sel_user(this.form)>
		</TD></TR>
		<input type=hidden name=admin_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.newusername)+":");</script>
		<input size=20 maxlength=64 name=admin_name id=admin_name value="<% get_user_data("admin_name"); %>" onblur=check_name(this.value,"admin_name")>
		<SPAN id=msg_admin_name></SPAN>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.oldpwd)+":");</script>
		<input size=20 maxlength=64 name=admin_old_pwd id=admin_old_pwd type=password>
		<SPAN id=msg_admin_old_pwd></SPAN>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.newpwd)+":");</script>
		<SPAN id=msg_admin_new_pwd></SPAN>
		<TABLE cellspacing=0 border=0>
		<TR><TD>
		<input size=20 maxlength=64 name=admin_new_pwd id=admin_new_pwd type=password onKeyUp=check_pwd(this.value,"_admin") onblur=check_pwd(this.value,"_admin")>
		</TD><TD><script>draw_td(O_GUI,PWDLINE,"_admin");</script></TD></TR></TABLE>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.retypenewpwd)+":");</script>
		<input size=20 maxlength=64 name=admin_cmp_pwd id=admin_cmp_pwd type=password>
		<SPAN id=msg_admin_cmp_pwd></SPAN>
                </TD></TR>
		<input type=hidden name=admin_end>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.guestset),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(mang.editguestset));</script>
		<input type=checkbox id=enguest name=enguest onclick=sel_user(this.form)>
		</TD></TR>
		<input type=hidden name=guest_start>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.newusername)+":");</script>
                <input size=20 maxlength=64 id=guest_name name=guest_name value="<% get_user_data("guest_name"); %>" onblur=check_name(this.value,"guest_name")>
		<SPAN id=msg_guest_name></SPAN>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.oldpwd)+":");</script>
                <input size=20 maxlength=64 name=guest_old_pwd id=guest_old_pwd type=password>
		<SPAN id=msg_guest_old_pwd></SPAN>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.newpwd)+":");</script>
		<SPAN id=msg_guest_new_pwd></SPAN>
		<TABLE cellspacing=0 border=0><TR><TD>
                <input size=20 maxlength=64 name=guest_new_pwd id=guest_new_pwd type=password onKeyUp=check_pwd(this.value,"_guest") onblur=check_pwd(this.value,"_guest")></TD><TD><script>draw_td(O_GUI,PWDLINE,"_guest");</script></TD></TR></TABLE>

                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T(mang.retypenewpwd)+":");</script>
                <input size=20 maxlength=64 name=guest_cmp_pwd id=guest_cmp_pwd type=password>
		<SPAN id=msg_guest_cmp_pwd></SPAN>
                </TD></TR>
		<input type=hidden name=guest_end>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.importuser),"colspan=2");</script></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE_M," valign=top colspan=2 style=padding-bottom:10px");</script>
		<div style="position:relative">
                <input name=importusers id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
                <INPUT type=text id=txtUploadFile name=browser size=28 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
		<span id=msg_file style="position:absolute;left:250px"></span>
                <script>
                draw_object(O_GUI,BT,__T(router.browse),"e2 id=e2 style='position:absolute;left:175px;top:0px'","BT","");
		</script>
		</div>
		</TD></TR>
		<TR><TD colspan=2>&nbsp;</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
                <script>Capture(mang.importmsg);</script></TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<script>
		draw_object(O_GUI,BT,__T(mang.importbt),"t2","BT","to_import(this.form)");
		if ( http_power == "r" ) choose_disable(document.getElementById("t2"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.downloaduser),SPACE_DOWN,SPACE_DOWN);
                	draw_object(O_GUI,BT,__T(mang.downloadlink),"e3","BT","to_download(this.form)");
		</script>
		</TD></TR>
                </div>
		
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
