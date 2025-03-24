<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
<% web_include_file("md5.js"); %>
var result=0;
var pwd_len = "<% nvram_get("pwd_minlen"); %>";
var pwd_class = "<% nvram_get("pwd_minclass"); %>";
var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
var new_admin_pwd = parse_data("admin_new_pwd");

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

function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide_pwd.asp"),350,330);
	else
		HelpDialog(goto_link("guide_pwd.asp"),310,330);
	
}

function s_pwd(obj_val,idx){
		var F = document.wz_sec;
		if ( (!F._en_pwd.checked) && (pwd_len >= 1) ) 
		{
	                result = count_pwd(obj_val,pwd_len,pwd_class);
        	        if ( result > 0 )
                	        document.getElementById("pwdtb"+idx).style.display="";
			else
        	                document.getElementById("pwdtb"+idx).style.display="none";
                	show_pwd_result(result,"");
		}
		if ( obj_val == "" ) document.getElementById("pwdtb"+idx).style.display="none";
}

function goto_next(F)
{
	if ( http_power == "rw" ) 
	{
		//if ( aging_time == "1" || F.pwd.value != "" ) 
		//{
		if ( !before_valid(F) ) return false;
		if ( F.pwd.value == "" ) 
		      my_alert(O_GUI,WARNING,__T(share.info),__T(msg.userblankpwd),"pwd_alert_result(1)","pwd_alert_result(0)","wizard","yesno");
		else
			pwd_alert_result(1);
	}else{
		if ( current_model_name == "RV130W" ) 
	        	document.location.href=goto_link("/wizard/sec_2.asp");
		else
	        	document.location.href=goto_link("/wizard/sec_5.asp");
			
	}
}

function pwd_alert_result(val)
{
	var F = document.wz_sec;
	alert_result(0)
	if ( val == 1 ) 
	{
		save_data("admin_new_pwd",F.pwd.value);
		if(F._en_pwd.checked == true)
			save_data("en_pwd","0");
		else
			save_data("en_pwd","1");
		document.getElementById("chkpwd").src = goto_link("checkpwd.asp");
		choose_disable(document.getElementById("w2"));
		choose_disable(document.getElementById("w3"));
		choose_disable(document.getElementById("w1"));
	}
}

function show_err(err)
{
	if ( err == 1 ) 
		w_set_alert("msg_dut_pwd",0,"pwd",__T(msg.differold),"down");
	else if ( err == 2 )
		w_set_alert("msg_dut_pwd",0,"pwd",__T(mang.chgpwdmsg4),"down");
	else if ( err == 6 ) 
		w_set_alert("msg_dut_pwd",0,"pwd",__T(mang.chgpwdmsg2),"down");
	  
	choose_enable(document.getElementById("w2"));
	choose_enable(document.getElementById("w3"));
	choose_enable(document.getElementById("w1"));
}

function pwd_check(F)
{
	w_clear_alert("msg_dut_pwd",0,"pwd");
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById("pwd").value,SPACE_NO); 
	if ( returnmsg != "" ) 
	{
		w_set_alert("msg_dut_pwd",0,"pwd",returnmsg,"down");
		return false;
	}
	s_pwd(F.pwd.value,"");
	return true;
}

function before_valid(F)
{
	var errflg = 0;
	if ( !pwd_check(F) ) 	errflg = 1;
	if ( (!F._en_pwd.checked) && (pwd_len >= 1) && F.pwd.value == "" ) 
	{
		w_set_alert("msg_dut_pwd",0,"pwd",__T(msg.notblank),"down");
		errflg=1;
	}else{
		if ( F.pwd.value != F.cf_pwd.value ) 
		{
			w_set_alert("msg_dut_pwd",0,"pwd",__T(wz.cmppwdnotmatch),"down");
			errflg=1;
		}
	}
	if ( errflg == 0 ) 
	{
		if ( (!F._en_pwd.checked) && (pwd_len >= 1) &&  result < 5 ) 
		{
			w_set_alert("msg_dut_pwd",0,"pwd",__T(msg.pwdstreng),"down");
			errflg=1;
			
		}
		
	}
	if ( errflg ) return false;
	return true;
}

function init()
{
	var F = document.wz_sec;
	var data = new_admin_pwd;
	var en_pwd = parse_data("en_pwd"); 
	if ( en_pwd == "0" ) F._en_pwd.checked = true;
	if ( data != "" ) 
	{
		F.pwd.value = data;
		F.cf_pwd.value = data;
		s_pwd(data,"");
	}
	def_nv = keep_val(F,""); 
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
	alert_result(0)
	if ( val == 1 ) 
	{
		go_page(aging_time,"<% nvram_get("getting_start"); %>");
	}
}

function check_en_pwd(F)
{               
        if(F._en_pwd.checked == true)
        {       
                my_alert(O_GUI,WARNING,__T(chpass.title),__T(chpass.enalertpwd),"chpwd_alert_result(1)","chpwd_alert_result(0)","wizard","yesno");
        }
        
}

function chpwd_alert_result(idx)
{
        var F = document.wz_sec;
        if ( idx == 0 ) 
                F._en_pwd.checked = false;
        alert_result(0);
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
<iframe id=chkpwd height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>
	if( current_model_name == "RV130W" ) 
		Capture(wz.securitytitle);
	else
		Capture(wz.securitytitle1);
    </script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
     <script>Capture(wz.setsecurity);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM>
     <script>Capture(wz.enternewpwd);</script>
     </TD></TR>
     <TR><TD valign=top class=DATA_ITEM2>
     <TABLE>
     <!--col width=30%><col width=40%><col width=30%-->
     <TR><TD></TD><TD colspan=2><span id=msg_dut_pwd></span></TD></TR>
     <TR><TD><script>Capture(wz.routerpwd);</script></TD><TD><input size=40 type=password name=pwd id=pwd maxlength=64 onKeyUp=s_pwd(this.value,"") onblur=pwd_check(this.form) maxlength=64></TD><TD align=left><script>draw_td(O_GUI,PWDLINE,"");</script></TD></TR>
     <TR><TD><script>Capture(wz.confirmpwd);</script></TD><TD colspan=2><input size=40 type=password name=cf_pwd id=cf_pwd maxlength=64></TD></TR>
     </TABLE>
     </TD></TR>
     <TR><TD class=DATA_ITEM>
     <TABLE>
     <TR><TD width=12px><img src="../image/wizardHelp.png"></TD><TD align=left valign=center>
     <A href=javascript:void(0) onclick="javascript:goto_guide()"><script>Capture(wz.pwdhelplink);</script></A>
     </TD></TR>
    </TABLE>
    </TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4>
     <input type=checkbox name=_en_pwd  id=_en_pwd onClick=check_en_pwd(this.form);>
     <script>Capture(chpass.enforcmentpwd);</script>
    </TD></TR> 
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"submit_1.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
