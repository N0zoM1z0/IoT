<html>
<head>
<title>Log</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("base64.js"); %>

var datalist = new Array();
<% show_syslog_ng(); %>

var _logevent_list = new Array(__T(syslog.event_all),__T(syslog.event_emer),__T(syslog.event_alert),__T(syslog.event_crit),__T(syslog.event_err),__T(syslog.event_warn),__T(syslog.event_noti),__T(syslog.event_info),__T(syslog.event_debug));
//var _logevent_val = new Array('0','1','2','3','4','5','6','7','8');
var _logevent_setval = new Array('0','1','2','4','8','16','32','64','128');

<% support_invmatch("BSD_SUPPORT","1","/*");%>
var _log_enable="<% nvram_get("log_enable"); %>";
var _log_bsdmail_enable="<% nvram_get("bsd_logmail_enable"); %>";
var _mailset_enable="0";
if((_log_bsdmail_enable == "1") )
	_mailset_enable="1";
<% support_invmatch("BSD_SUPPORT","1","*/");%>

function init()
{
	var get_auth = "<% get_auth_status(); %>";
	var time_nv = parseInt("<% nvram_get("log_email_time");%>",10);
	var F = document.frm_log_email;
	parent.document.getElementById("save_bg").style.display="none";
	if(get_auth == "1")
		my_alert(O_PAGE,SUCCESS,__T(logemail.testsuccess));
	else if(get_auth == "2")
		my_alert(O_PAGE,ERROR,__T(logemail.testfail));
	if ( flg_24 == 0 ) 
	{
		F.noon.selectedIndex = 0;
		F.hour.selectedIndex = 0;

		if(isNaN(time_nv) || (time_nv < 0))
			F.hour.selectedIndex = 0;
		else if(time_nv == 12)
		{
			F.hour.selectedIndex = 0;
			F.noon.selectedIndex = 1;
		}
		else if(time_nv == 24)
			F.hour.selectedIndex = 0;
		else if(time_nv > 12)
		{
			F.hour.selectedIndex = time_nv - 12;
			F.noon.selectedIndex = 1;
		}
		else
			F.hour.selectedIndex = time_nv;
	}else
		F.hour.selectedIndex = time_nv-1;
		

	if("<% nvram_gozila_get("log_email_server_port"); %>" == "")
		F.log_email_server_port.value = "25";
	else
		F.log_email_server_port.value = "<% nvram_gozila_get("log_email_server_port"); %>";

	if ( http_power == "r" ) return;	
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
	//support BSD+++
	if( _log_enable == "1" && "<% nvram_get("log_email_enable"); %>" == "on")
	{
		DISABLE_PART(F,"log_email_conf_start","log_email_conf_end",0);
	}
	else
	{
		DISABLE_PART(F,"log_email_conf_start","log_email_conf_end",1);
	}
	if(_log_enable != "1")
                choose_disable(document.getElementById("_log_email_enable"));
	else
                choose_enable(document.getElementById("_log_email_enable"));
	
	if(  _log_enable != "1" && _mailset_enable !="1")
	{
		DISABLE_PART(F,"email_setting_start","email_setting_end",1);
		return;
	}
	else
	{
		DISABLE_PART(F,"email_setting_start","email_setting_end",0);
	}
	//support BSD---
	<% support_invmatch("BSD_SUPPORT","1","*/");%>

	<% support_match("BSD_SUPPORT","1","/*");%>
	//don't support BSD +++
	if("<% nvram_invmatch("log_enable","1","1"); %>" == "1")
	{
		choose_disable(document.getElementById("c1"));
		choose_disable(document.getElementById("c3"));
                choose_disable(document.getElementById("email_enable"));
		DISABLE_PART(F,"log_email_start","log_email_end",1);
		return;
	}
	else
	{
                choose_enable(document.getElementById("email_enable"));
		DISABLE_PART(F,"log_email_start","log_email_end",0);
	}
	<% support_match("BSD_SUPPORT","1","*/");%>
	//don't support BSD --- 
	CHK_EN(F);
	default_nv = keep_val(F,"");
	
}

function CHK_EN(F)
{
	var idx;
	if ( http_power == "r" ) return;	
	//support BSD +++
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
	if ( (_log_enable == "1" && F._log_email_enable.checked == true) 
             || ( F._bsd_mail.checked ==true)
           )
		DISABLE_PART(F,"email_setting_start","email_setting_end",0);
	
	else
		DISABLE_PART(F,"email_setting_start","email_setting_end",1);

	DISABLE_PART(F,"log_email_conf_start","log_email_conf_end",1);
	if ( (_log_enable == "1" && F._log_email_enable.checked == true))
	{
		DISABLE_PART(F,"log_email_conf_start","log_email_conf_end",0);
	}

	if(_log_enable != "1" && F._bsd_mail.checked !=true)
		return;
	<% support_invmatch("BSD_SUPPORT","1","*/");%>
	//support BSD ---

	//no support BSD +++
	<% support_match("BSD_SUPPORT","1","/*");%>
	if("<% nvram_invmatch("log_enable","1","1"); %>" == "1")
		return;
	DISABLE_PART(F,"log_email_start","log_email_end",1);
	if ( F._log_email_enable.checked == true )
		DISABLE_PART(F,"log_email_start","log_email_end",0);

	<% support_match("BSD_SUPPORT","1","*/");%>
	//no support BSD ---

	choose_enable(document.getElementById("c1"));
	choose_enable(document.getElementById("c3"));
	idx = F.log_email_auth.value;
	SelAuth(F,idx);

	idx = F.log_email_unit.value;
	SelUnit(F,idx);
}

function SelAuth(F,idx){
	if ( http_power == "r" ) return;
	
	if ( F._log_email_enable.checked != true )
		return;

	if(isNaN(idx) || ( idx == 0 )) //Auto
	{
		choose_disable(F.log_email_auth_user);
		choose_disable(F.log_email_auth_pass);
		choose_disable(document.getElementById("t1"));
	}
	else 
	{
		choose_enable(F.log_email_auth_user);
		choose_enable(F.log_email_auth_pass);
		choose_enable(document.getElementById("t1"));
	}
}

function SelUnit(F,idx){

	if ( F._log_email_enable.checked != true 
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
		&& F._bsd_mail.checked !=true 
	<% support_invmatch("BSD_SUPPORT","1","*/");%>
	   )
		return;

	if (isNaN(idx) || idx == 0 || idx == 1 ) //Auto
	{
		choose_disable(F.log_email_day);
		choose_disable(F.hour);
		choose_disable(F.noon);
	}
	else if(idx == 2)
	{
		choose_disable(F.log_email_day);
		choose_enable(F.hour);
		choose_enable(F.noon);
	}
	else
	{
		choose_enable(F.log_email_day);
		choose_enable(F.hour);
		choose_enable(F.noon);
	}
}

function to_test(F)
{
	time_trans(F);
	if(F._log_email_enable.checked == true)
		F.log_email_enable.value = "on";
	else
		F.log_email_enable.value = "off";

	F.change_action.value="gozila_cgi";
	F.submit_type.value="test_mail";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function uiDoSave(F)
{
	var errflg = 0;
	/*	if((F._log_email_enable.checked == false) &&
	   ((F.log_email_server_addr.value =="") || (F.log_email_server_port.value=="") || 
	   (F.log_email_return_addr.value == "") || (F.log_email_sendto_addr_0.value=="")))
	{
		return;
	}*/
	if ( F.log_email_auth.value != "0" ) 
	{
		if ( !chk_auth_name(F) ) errflg = 1;
		if ( !chk_auth_pwd(F) ) errflg = 1;
	}

	if((F._log_email_enable.checked == true) && check_value(F) == false) 
		return;
	if ( errflg == 1 ) return;

	if ( F.log_email_auth_pass.disabled == false && F.log_email_auth_pass.value != "" ) 
		F.log_email_auth_pass.value = encode64(F.log_email_auth_pass.value);

	if(F._log_email_enable.checked == true)
		F.log_email_enable.value = "on";
	else
		F.log_email_enable.value = "off";
	
	time_trans(F);
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
	if ( F._bsd_mail.checked )
		F.bsd_logmail_enable.value = 1; 
	else 
		F.bsd_logmail_enable.value = 0; 
	<% support_invmatch("BSD_SUPPORT","1","*/");%>

	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function check_value(F)
{
	if(F._log_email_enable.checked != true 
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
		&& F._bsd_mail.checked !=true
	<% support_invmatch("BSD_SUPPORT","1","*/");%>
	)
		return true;

	if(!msg_chk_range(F.log_email_server_port.value,"log_email_server_port",1,65535,10,IS_FIELD,0,"_log_email_server_port"))
		return false;
        if(!my_valid_email(F.log_email_return_addr.value,"log_email_return_addr","_log_email_return_addr"))
                return false;
        if(!my_valid_email(F.log_email_sendto_addr_0.value,"log_email_sendto_addr_0","_log_email_sendto_addr_0"))
                return false;
        if(!option_valid_email(F.log_email_sendto_addr_1.value,"log_email_sendto_addr_1","_log_email_sendto_addr_1"))
                return false;
        if(!option_valid_email(F.log_email_sendto_addr_2.value,"log_email_sendto_addr_2","_log_email_sendto_addr_2"))
                return false;
	if(!check_email_server(F.log_email_server_addr.value,"log_email_server_addr","_log_email_server_addr"))
		return false;
}

function option_valid_email(val,obj_id,span_id)
{
	clear_msg(obj_id,span_id);

	if(!isNaN(val))
		return true;
	
        if(!my_valid_email(val,obj_id,span_id))
		return false;
	return true;
}

function time_trans(F)
{
	var time_nv = parseInt(F.hour[F.hour.selectedIndex].value,10);

	if( flg_24  == 0 ) 
	{
		var noon_nv = F.noon[F.noon.selectedIndex].value;
		if(noon_nv == "PM")
		{
			if(time_nv != 12)
				time_nv += 12;
		}
		else if((noon_nv == "AM") && (time_nv == 12))
		{
			time_nv = 24;
		}
	}
	//alert("Save time="+time_nv);
	F.log_email_time.value = time_nv;
}

function check_email_server(val,obj_id,span_id)
{
	clear_msg(obj_id,span_id);
	if( valid_email_server(val) == false)
	{
                parent.document.getElementById("obj_id").value = span_id;
		my_alert(O_VAR,obj_id,__T(syslog.emailserverfail),"0",span_id);
		return false;
	}
	return true;
}

function chk_auth_name(F)
{
	clear_msg("log_email_auth_user","_auth_user");
	var returnmsg = valid_meaning_id_name(MEANING_NAME,F.log_email_auth_user.value,ZERO_NO|SPACE_NO);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,"log_email_auth_user",returnmsg,"0","_auth_user");
		return false;
	}	
	return true;
}

function chk_auth_pwd(F)
{
	clear_msg("log_email_auth_pass","_auth_pwd");
	var returnmsg = valid_meaning_id_name(MEANING_NAME,F.log_email_auth_pass.value,ZERO_NO|SPACE_OK);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,"log_email_auth_pass",returnmsg,"0","_auth_pwd");
		return false;
	}
	return true;
}
</script>
</head>
<body onload=init()>
<FORM autocomplete=off id="frm" name="frm_log_email" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button value="log_email">
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=log_email_enable>
<input type=hidden name=log_email_time>
<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
<input type=hidden name=bsd_logmail_enable value="<%nvram_get("bsd_logmail_enable");%>">
<% support_invmatch("BSD_SUPPORT","1","-->"); %>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(logemail.set),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(logemail.emailalert),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(bsd.logmail2));	</script>
		<input type=checkbox name=_bsd_mail <% nvram_match("bsd_logmail_enable","1","checked"); %> onclick=CHK_EN(this.form) >
		<script>Capture(share.enable);</script>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(logemail.mode));
		if("<% nvram_gozila_get("log_email_enable");%>" == "on")
			document.write("<input type=checkbox id=email_enable name=_log_email_enable onclick=CHK_EN(this.form) checked>");
		else
			document.write("<input type=checkbox id=email_enable name=_log_email_enable onclick=CHK_EN(this.form)>");
		</script>
		<script>Capture(share.enable);</script>
		</TD></TR>

		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!-- Log E-mail Configuration start -->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(logemail.title),"colspan=2");</script></TR>
		<input type=hidden name=log_email_conf_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(syslog.minilog));</script>
		<script>
			var log_seveity = 0;

			if(datalist.length > 0)
			{
				var logevent = parseInt(datalist[0].logevent,10);
	
				for(var i=(_logevent_setval.length-1); i>=0; i--)
				{
					if((logevent | parseInt(_logevent_setval[i],10)) == logevent)
					{
						log_seveity = i;	
						break;	
					}
				}		
				if(i == 0)
				log_seveity = (_logevent_setval.length-1);	
			}

			document.write(_logevent_list[log_seveity]+"&nbsp;&nbsp;");
		        draw_object(O_GUI,BT,__T(logemail.cfgseverity),"g2","BT","goto_page(\"log.asp\");");
			if ( http_power == "r" ) choose_disable(document.getElementById("g2"));
		</script>
		</TD></TR>
		<input type=hidden name=log_email_conf_end>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!-- Log E-mail Configuration end -->
		<!--Send E-mail Logs by Schedule start -->	
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(logemail.sch),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.schunit));
	        var _name= new Array(__T(logemail.schnever),__T(logemail.schhour),__T(logemail.schdaily),__T(logemail.schweek));
	        var _val= new Array("0","1","2","3");
		draw_object(O_GUI,SELBOX,"log_email_unit","onChange=SelUnit(this.form,this.form.log_email_unit.selectedIndex)",_name,_val,"<% nvram_get("log_email_unit"); %>");
		</script>
                </TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.schday)); //Unit select weekly
	        var _name= new Array(__T(logemail.schsun),__T(logemail.schmon),__T(logemail.schtue),__T(logemail.schwed),__T(logemail.schthur),__T(logemail.schfri),__T(logemail.schsatur));
	        var _val= new Array("7","1","2","3","4","5","6");
		draw_object(O_GUI,SELBOX,"log_email_day","",_name,_val,"<% nvram_get("log_email_day"); %>");
		</script>
                </TD></TR>

		<TR><script>
			draw_td(O_GUI,SUBTITLE,__TC(logemail.schtime),SPACE_DOWN,SPACE_DOWN); 
			var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
			var hour_name_24 = new Array("ISRANGE","1","24","1",2);
			if ( flg_24 == 1 ) 
				draw_object(O_GUI,SELBOX,"hour","",hour_name_24,hour_name_24);
			else{
				draw_object(O_GUI,SELBOX,"hour","",hour_name_12,hour_name_12);
				document.write("&nbsp;");
				var meridia_name = new Array(__T(mang.am),__T(mang.pm));
				var meridia_val = new Array("AM","PM");
				draw_object(O_GUI,SELBOX,"noon","",meridia_name,meridia_val);
			}
		</script>
		
                </TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--Send E-mail Logs by Schedule end -->	
		<!--E-mail Settings start -->	
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TD></TR>
		<input type=hidden name=email_setting_start>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(logemail.set),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.smail));</script>
		<input id=log_email_server_addr size=30 maxlength=63 name=log_email_server_addr value="<% nvram_gozila_get("log_email_server_addr"); %>" onBlur=check_email_server(this.value,"log_email_server_addr","_log_email_server_addr")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"mail.abc.com"));</script>
		<span id=_log_email_server_addr></span>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.sport));</script>
		<input id=log_email_server_port size=10 maxlength=5 onBlur=msg_chk_range(this.value,"log_email_server_port",1,65535,10,IS_FIELD,0,"_log_email_server_port") name=log_email_server_port> 
		<script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"1","65535","25"));</script>
		<span id=_log_email_server_port></span>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.rmail));</script>
		<input id=log_email_return_addr size=30 maxlength=63 name=log_email_return_addr onBlur=my_valid_email(this.value,"log_email_return_addr","_log_email_return_addr") value="<% nvram_gozila_get("log_email_return_addr"); %>">
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"test@abc.com"));</script>
		<span id=_log_email_return_addr></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.smail1));</script>
		<input id=log_email_sendto_addr_0 size=30 maxlength=63 name=log_email_sendto_addr_0 onBlur=my_valid_email(this.value,"log_email_sendto_addr_0","_log_email_sendto_addr_0") value="<% nvram_gozila_get("log_email_sendto_addr_0"); %>">
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"test@abc.com"));</script>
		<span id=_log_email_sendto_addr_0></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.smail2));</script>
		<input id=log_email_sendto_addr_1 size=30 maxlength=63 name=log_email_sendto_addr_1 onBlur=option_valid_email(this.value,"log_email_sendto_addr_1","_log_email_sendto_addr_1") value="<% nvram_get("log_email_sendto_addr_1"); %>">
		<span id=_log_email_sendto_addr_1></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.smail3));</script>
		<input id=log_email_sendto_addr_2 size=30 maxlength=63 name=log_email_sendto_addr_2 onBlur=option_valid_email(this.value,"log_email_sendto_addr_2","_log_email_sendto_addr_2") value="<% nvram_get("log_email_sendto_addr_2"); %>">
		<span id=_log_email_sendto_addr_2></span>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.encry));
		var _name = new Array(__T(share.disable),__T(logemail.ssl),__T(logemail.tls));
		var _val = new Array("0","1","2");
		draw_object(O_GUI,SELBOX,"log_email_encrypt","onChange=SelAuth(this.form,this.form.log_email_auth.selectedIndex)",_name,_val,"<% nvram_gozila_get("log_email_encrypt"); %>");
		</script>
                </TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.auth));
		var _name = new Array(__T(logemail.authnone),__T(logemail.authlogin),__T(logemail.authplain),__T(logemail.authcram));
		var _val = new Array("0","3","1","2");
		draw_object(O_GUI,SELBOX,"log_email_auth","onChange=SelAuth(this.form,this.form.log_email_auth.selectedIndex)",_name,_val,"<% nvram_gozila_get("log_email_auth"); %>");
		</script>
		</TD></TR>

		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--E-mail Authentication != None-->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.authuser));</script>
		<input size=30 maxlength=63 id=log_email_auth_user name=log_email_auth_user value="<% nvram_gozila_get("log_email_auth_user"); %>" onblur=chk_auth_name(this.form)>
		<span id=_auth_user></span>
		</TD></TR>

		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--E-mail Authentication != None-->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.authpass));</script>
		<script>
		var nv_auth_passwd = "";
		if ( <% nvram_else_match("log_email_auth_pass","","0","1"); %> ) 
			nv_auth_passwd = TMP_PASSWD;
		document.write("<input type=password size=30 maxlength=63 id=log_email_auth_pass name=log_email_auth_pass value='"+nv_auth_passwd+"' onblur=chk_auth_pwd(this.form)>");
		</script>
		<span id=_auth_pwd></span>
		</TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--E-mail Authentication != None-->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(logemail.testbutton));
	        draw_object(O_GUI,BT,__T(share.test),"t1","BT","to_test(this.form)");
		if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
		
		</script></TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--E-mail Settings end -->	
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<input type=hidden name=email_setting_end>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!--end all of BSD_SUPPORT -->		
        	</TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
