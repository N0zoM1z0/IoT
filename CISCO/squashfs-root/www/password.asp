<html>
<head>
<title>Password Strength</title>
<!--meta http-equiv="X-UA-Compatible" content="IE=8"/-->
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	var F = document.frmpwd;
	parent.document.getElementById("save_bg").style.display="none";
	chk_pwd(F);
	default_nv = keep_val(document.frmpwd,"");
}

function chk_pwd(F)
{
	if ( F._en_pwd.checked == false ) 
		DISABLE_PART(F,"all_start","all_end",1);
	else
		DISABLE_PART(F,"all_start","all_end",0);
	chk_aging(F);
}

function chk_aging(F)
{
	if (( F._en_aging.checked == true ) && ( F._en_pwd.checked == true )) 
		choose_enable(F.aging);
	else
		choose_disable(F.aging);
}

function _check_range(obj_val,start,to,span_id,obj_id,tr_id)
{
	document.getElementById(tr_id).style.display="none";
	if ( !msg_chk_range(obj_val,obj_id,start,to,10,IS_FIELD,0,span_id,"down") ) 
	{
		document.getElementById(tr_id).style.display="";
		return false;
	}
	return true;
}

function valid_value(F){
	var error_flg=0;
	var showmsg=0;
	if ( F._en_pwd.checked == false ) 
	{
		wl_alert_result(1);
		return true;
	}
	if ( !_check_range(F.pwd_minlen.value,0,64,"msg_min_pwd","pwd_minlen","tr_min_pwd") ) error_flg = 1;
	if ( !_check_range(F.pwd_minclass.value,0,4,"msg_min_class","pwd_minclass","tr_minclass") ) error_flg = 1;
	if ( parseInt(F.pwd_minlen.value,10) < parseInt(F.pwd_minclass.value,10) ) 
        {
		document.getElementById("tr_min_pwd").style.display="";
                my_alert(O_VAR,"pwd_minlen",__T(msg.pwdclasslen),"0","msg_min_pwd","down");
                error_flg = 1;
        }

	if ( F._en_aging.checked == true ) 
	{
		if ( !_check_range(F.aging.value,1,365,"msg_aging","aging","tr_aging") ) error_flg = 1;
	}
	if ( error_flg == 0 && F.pwd_minlen.value == "0" ) 
	{
                my_alert(O_GUI,WARNING,__T(share.info),__T(msg.pwdlenisblank),"wl_alert_result(1)","wl_alert_result(0)","","yesno");                     showmsg=1;
	}
	if ( showmsg == 0 && error_flg==0 ) wl_alert_result(1);
	if ( error_flg == 1 ) return false;
	return true;
}

function wl_alert_result(val)
{
	alert_result(0);
	var F = document.frmpwd;
	var errflg=0;
	if( val == 1 )
	{
		if ( F._en_pwd.checked == true ) 
        	        F.en_pwd.value = 1;
	        else
                	F.en_pwd.value = 0;
	        if ( F._en_pwddiff.checked == true )
        	        F.en_pwddiff.value = 1;
	        else
        	        F.en_pwddiff.value = 0;
		if ( F._en_aging.checked == true ) 
			F.en_aging.value = 1;
		else
			F.en_aging.value = 0;
		F.submit_button.value = "password";
		F.gui_action.value = "Apply";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}

function uiDoSave(F)
{
	if ( !valid_value(F) ) return;
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmpwd method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=en_pwd>
<input type=hidden name=en_pwddiff>
<input type=hidden name=en_aging>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.pwdcomplex),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.pwdset));</script>
		<input type=checkbox name=_en_pwd <% nvram_match("en_pwd","1","checked"); %> onclick=chk_pwd(this.form)>
		<script>Capture(share.enable);</script>
                </TD></TR>
		<input type=hidden name=all_start>
		<TR><Script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR id=tr_min_pwd style=display:none><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<SPAN id=msg_min_pwd></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.minpwdlen));</script>
		<input size=20 maxlength=2 id=pwd_minlen name=pwd_minlen onblur=_check_range(this.value,0,64,"msg_min_pwd","pwd_minlen","tr_min_pwd") value="<% nvram_get("pwd_minlen"); %>"> <script>document.write(spell_words(range_def_rule,"0","64","8"));</script>
		</TD></TR>
		<TR id=tr_minclass style=display:none><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<SPAN id=msg_min_class></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.minclass));</script>
		<input size=20 maxlength=1 id=pwd_minclass name=pwd_minclass onblur=_check_range(this.value,0,4,"msg_min_class","pwd_minclass","tr_minclass"); value="<% nvram_get("pwd_minclass"); %>">  <script>document.write(spell_words(range_def_rule,"0","4","3"));</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		document.write(__T(mang.pwdmsg));
		</script>
		</TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.newpwddiff));</script>
		<input type=checkbox name=_en_pwddiff <% nvram_match("en_pwddiff","1","checked"); %>> <script>Capture(share.enable);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.pwdaging));</script>
		<input type=checkbox name=_en_aging onClick=chk_aging(this.form) <% nvram_match("en_aging","1","checked"); %>> <script>Capture(share.enable);</script>
                </TD></TR>
		<TR id=tr_aging style=display:none><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<SPAN id=msg_aging></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.pwdagingtime),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 maxlength=3 name=aging id=aging onblur=_check_range(this.value,1,365,"msg_aging","aging","tr_aging") value="<% nvram_get("aging"); %>"> <script>document.write(__T(mang.sdays)+" "+spell_words(range_def_rule,"1","365","180"));</script>
		</TD></TR>
		<input type=hidden name=all_end>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
