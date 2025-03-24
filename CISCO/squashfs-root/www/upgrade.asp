<html>
<head>
<title>Upgrade</title>
<% web_include_file("filelink.asp"); %>
</head>
<style fprolloverstyle>
a.content_link:link{COLOR: #0000FF; text-decoration:none;};
a.content_link:visited{COLOR: #0000FF; text-decoration:none;};
a.content_link:hover{COLOR: #0000FF; text-decoration:none;};
</style>
<script>
<% support_invmatch("BSD_SUPPORT","1","/*");%>
var nv_bsd_interval = "<% nvram_get("bsd_interval"); %>";
var _hour_name12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
var _hour_name24 = new Array("ISRANGE","0","23","1",2);
var nv_sel_time= "<% nvram_get("bsd_sel_time");%>";
var bsd_ver_state="<% get_bsd_ver_state(); %>";
var nv_logmail_enable="<% nvram_get("bsd_logmail_enable");%>";
var bsd_type="upgrade";
var sbt = "<% get_clear_value("submit_button"); %>";
function check_timerange(F) 
{
	var shour=0;
	if ( flg_24 == 0 ) 
	{
		if( F.stime.value == "pm") 
		{
			shour = parseInt(F.stime_hour.value,10);
			if(shour != 12)
				shour = shour+12;
		}
		else 
		{
			shour = parseInt(F.stime_hour.value,10);
			if(shour == 12)
				shour=24;
		}
	}else{
		shour = parseInt(F.stime_hour.value,10);
	}
	F.bsd_sel_time.value = shour;
	return true;
}

function bsd_sel_interval(value)
{
	var F = document.frmupgrade;
	if(value == "never")	
	{
		DISABLE_PART(F, "bsd_start1","bsd_end",1);
		choose_enable(F.mailbt);
	}
	else
	{
		DISABLE_PART(F, "bsd_start1","bsd_end",0);
		chg_act(F._bsd_action.value);
		if( nv_logmail_enable == "1" )
			choose_enable(F._via_mail);
		else
			choose_disable(F._via_mail);
	}	


}
function chg_act(value)
{
	var F = document.frmupgrade;
	
	if ( value == "2" ) 
	{
		choose_enable(F.stime);
		choose_enable(F.stime_hour);
	}
	else
	{
		choose_disable(F.stime);
		choose_disable(F.stime_hour);
	}

}
function mail_bt(F)
{
	get_position('log_email.asp');
}
function _via_mail_chg(F)
{
	if ( F._via_mail.checked )
		choose_enable(F.mailbt);
	else 
		choose_disable(F.mailbt);

}
function show_continue_bt()
{
	top.location.href = "<% get_http_prefix(""); %>default.asp;session_id=<% nvram_get("session_key"); %>";
}
<% support_invmatch("BSD_SUPPORT","1","*/");%>

var Timer = null;
function stop_count()
{
        if (Timer)
                clearTimeout(Timer);
}

/*below is added for BSD and USB_UPGRADE +++*/
function uiDoSave(F)
{
	F.bsd_st.value = "";
	DISABLE_PART(F,"all_start","all_end",1);
        F.submit_button.value = "upgrade_fun";

<% support_invmatch("BSD_SUPPORT","1","/*");%>

	F.bsd_interval.value=F._bsd_interval.value;
	if(F.bsd_interval.value != "never")
	{
		F.bsd_action.value=F._bsd_action.value;
		if ( F._via_mail.checked )
			F.bsd_mail_enable.value = 1; 
		else 
			F.bsd_mail_enable.value = 0; 

		if ( F._via_admin.checked )
			F.bsd_admin_enable.value = 1; 
		else 
			F.bsd_admin_enable.value = 0; 

		if(!check_timerange(F)) return;

	}
<% support_invmatch("BSD_SUPPORT","1","*/");%>
<% support_invmatch("USB_UPGRADE_SUPPORT","1","/*"); %>
	if(F._usb_upgrade_enable[0].checked==true)
		F.usb_upgrade_enable.value=1;
	else
		F.usb_upgrade_enable.value=0;
<% support_invmatch("USB_UPGRADE_SUPPORT","1","*/"); %>
	F.wait_time.value = 1;
	F.gui_action.value = "Apply";
	F.next_page.value = "upgrade";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

//val = 0 from cisco, val =1 from PC, val =2 from usb
function _upgrade_from_cisco(val)
{
	var F = document.frmupgrade;
	if((val == 0))
	{
		choose_enable(F.t1);
		choose_enable(F.chk_restore);
	}
	else if(val == 1)
	{
		if( document.getElementById('txtUploadFile').value != '' ) 
			choose_enable(F.t1);
		else
			choose_disable(F.t1);
		choose_enable(F.chk_restore);
	}
	else 
	{
		choose_disable(F.chk_restore);
		choose_disable(F.t1);
	}
	if( val == 1)
	{
		choose_enable(F.t6);
		choose_enable(F.fileTxtBox);
		choose_enable(F.txtUploadFile);
	}
	else 
	{
		choose_disable(F.t6);
		choose_disable(F.fileTxtBox);
		choose_disable(F.txtUploadFile);
	}
<% support_invmatch("USB_UPGRADE_SUPPORT","1","/*");%>
	if(val != 2)	//from USB
	{
		document.getElementById("usbtb_img").src="image/show.gif";
		document.getElementById("usbcontenttd").style.display="none";
		document.getElementById("usbtable_title").innerHTML = __T(usbupgrade.showusb);
	}
<% support_invmatch("USB_UPGRADE_SUPPORT","1","*/");%>
	if ( http_power == "r" ) choose_disable(document.getElementById("t1"));

}


/*above is added for BSD and USB_UPGRADE ---*/
var wait_time = 280*1000;
var now_wait_time=0;
var max_len = 260;
var now_width=0;
var interval=5;

function ciscolink()
{
	var about_win;
	var url = "http://www.cisco.com/support";
	about_win = window.open(url,'HelpTable','toolbar,menubar,scrollbar,resizable,location,directories,width=800,height=400');
}

function to_upgrade(F)
{
	F.bsd_st.value = "";
	frames['usbcontenttd'].location.href = goto_link("bsd_show_step.asp");
	setTimeout('save_script()', 3000);
}

function save_script()
{
	var F = document.frmupgrade;
	/*below is added for BSD and USB_UPGRADE +++*/
<% support_invmatch("BSD_SUPPORT","1","/*");%>
	if(F._upgrade_from[0].checked == true)		//from cisco.com
	{
		if ( F.file_type[0].checked ) 
			my_alert(O_GUI,INFO,__T(share.info),__T(router.langinfo),"upgrade_alert_result(2)");	
		else
			upgrade_alert_result(2);
	}
	else //upgrade from PC
	{
		var len = F.file.value.length;
		var ext = new Array('.','b','i','n');
		if (F.file.value == '') {
			if ( document.frmupgrade.file_type[0].checked ) //code
				my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradefile));	
			else
				my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradelang));	
			return false;
		}
		var IMAGE = F.file.value.toLowerCase();
		for (var i=0; i < 4; i++)   {
			if (ext[i] != IMAGE.charAt(len-4+i)){
				if ( document.frmupgrade.file_type[0].checked ) //code
					my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradefile));	
				else
					my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradelang));	
				return false;
			}
		}
		if ( F.file_type[0].checked ) 
			my_alert(O_GUI,INFO,__T(share.info),__T(router.langinfo),"upgrade_alert_result(1)");	
		else
			upgrade_alert_result(1);
	}
<% support_invmatch("BSD_SUPPORT","1","*/");%> 
	/*above supports BSD and USB upgrade end */

	/*below supports BSD and USB upgrade start */
<% support_match("BSD_SUPPORT","1","/*");%> 
	var len = F.file.value.length;
        var ext = new Array('.','b','i','n');
        if (F.file.value == '') {
		if ( document.frmupgrade.file_type[0].checked ) //code
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradefile));	
		else
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradelang));	
                return false;
        }
        var IMAGE = F.file.value.toLowerCase();
        for (var i=0; i < 4; i++)   {
                if (ext[i] != IMAGE.charAt(len-4+i)){
			if ( document.frmupgrade.file_type[0].checked ) //code
				my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradefile));	
			else
				my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.upgradelang));	
                        return false;
                }
        }
	if ( F.file_type[0].checked ) 
		my_alert(O_GUI,INFO,__T(share.info),__T(router.langinfo),"upgrade_alert_result(1)");	
	else
		upgrade_alert_result(1);
<% support_match("BSD_SUPPORT","1","*/");%> 
	/*above supports BSD and USB upgrade end */
}
function upgrade_alert_result(val)
{
<% support_invmatch("BSD_SUPPORT","1","/*");%>
	var F = document.frmupgrade;
	alert_result(0);
	if ( val == 0 ) return;	
	if ( F.bsd_st.value != "" && F.bsd_st.value != "5" && F.bsd_st.value != "6" ) 
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(msg.bsdmsg4),"alert_result(0)");
		return false;
	}
	if ( F.restore.checked == false )
		document.getElementById("factory_default").disabled = true;
	if ( F.file_type[0].checked ) 
		choose_disable(document.getElementById("Is_lang_file"));
	else
		choose_enable(document.getElementById("Is_lang_file"));
	choose_disable(document.getElementById("t1"));
	bsd_type = 'upgrade';
        F.submit_button.value = "upgrade";
	if ( val == 2) 
	{
		F.submit_button.value = "bsd_upgrade_cisco";
		F.gui_action.value = "Apply";
		F.next_page.value = "upgrade";
		parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg1);
	}
	else 
	if ( val == 3) 
	{
		F.action=goto_link("usbupgrade.cgi");
		F.encoding="multipart/form-data";
		parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
	}
	else
	{
		F.action=goto_link("upgrade.cgi");
		F.encoding="multipart/form-data";
		parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
	}
        F.submit();
	if ( (val == 2)	|| (val == 3))
	{
		F.bsd_st.value = "";
		if ( val == 3 )
			parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg3);
		setTimeout("count_waittime()", 5000);
	}
	parent.document.getElementById("hidden_bg").style.display="";
<% support_invmatch("BSD_SUPPORT","1","*/");%>

<% support_match("BSD_SUPPORT","1","/*");%>
	var F = document.frmupgrade;
	alert_result(0);
	if ( val == 0 ) return;	
	if ( F.restore.checked == false )
		document.getElementById("factory_default").disabled = true;
	if ( F.file_type[0].checked ) 
		choose_disable(document.getElementById("Is_lang_file"));
	else
		choose_enable(document.getElementById("Is_lang_file"));
	choose_disable(document.getElementById("t1"));
        F.submit_button.value = "upgrade";
        F.submit();
	setTimeout("count_waittime()", 5000);
	parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
	parent.document.getElementById("hidden_bg").style.display="";
<% support_match("BSD_SUPPORT","1","*/");%>
}

function chk_bt(F)
{
	F.bsd_st.value = "";
        F.submit_button.value = "bsd_chkver";
        F.gui_action.value = "Apply";
        F.next_page.value = "upgrade";
        F.submit();
	setTimeout("count_waittime()", 5000);
        parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg1);
        parent.document.getElementById("hidden_bg").style.display="";
}

function count_waittime()
{
<% support_invmatch("BSD_SUPPORT","1","/*");%>
	var F = document.frmupgrade;
	now_wait_time+=5000;
	if ( F.bsd_st.value != "4" )
		frames['usbcontenttd'].location.href = goto_link("bsd_show_step.asp");
	parent.document.getElementById("defproc").style.display="";
	parent.document.getElementById("procbar").style.display="none";
	if ( F.bsd_st.value == "6" ) 
	{
		if ( sbt == "bsd_chkver" )
		{
	                if ( F.bsd_err_msg.value == "" || F.bsd_err_msg.value == "3" )
        	                my_alert(O_PAGE,SUCCESS,__T(bsd.fw_st_ginfo_ok));
                	else
                        	my_alert(O_PAGE,ERROR,__T(bsd.fw_st_ginfo_fail));

		}else{
			my_alert(O_PAGE,SUCCESS,__T(usbupgrade.savesuccess));
		}
		F._upgrade_from[1].checked=true;
		parent.document.getElementById("hidden_bg").style.display="none";
		stop_count();
		return;
	}
	if ( F.bsd_st.value != "5" ){ 
		if ( sbt != "bsd_chkver" )
		{
		if ( F.bsd_st.value == "1" ) 
		{
			//bsdmsg1="Getting Firmware Information from Server";
	                parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg1);
		}
	        else if ( F.bsd_st.value == "2" ) 
		{
			//bsdmsg2="Downloading Firmware";
	                parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg2);
			parent.document.getElementById("defproc").style.display="none";
			parent.document.getElementById("procbar").style.display="";
			var tmplen = (300*parseInt(F.bsd_percentage.value,10))/100;
			parent.document.getElementById("proc_percent").innerHTML = parseInt(F.bsd_percentage.value,10)+"%";
        	        parent.document.getElementById("proc_left").style.width = tmplen+"px"; 
        	        parent.document.getElementById("proc_right").style.width = 300-parseInt(tmplen,10)+"px"; 
		}
	        else if ( F.bsd_st.value == "3" ) 
		{
			//bsdmsg3="Upgrading Firmware";
        	        parent.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg3);
		}
	        else if ( F.bsd_st.value == "4" )	//rebootingdev="Rebooting device..."; 
		{
        	        parent.document.getElementById("reboot_msg").innerHTML = __T(msg.rebootingdev);
			setTimeout('show_continue_bt()', 70000);
			return;
		}
		}
		Timer = setTimeout("count_waittime()", 3000);
	}else{
		if ( sbt == "bsd_chkver" )
		{
			my_alert(O_PAGE,ERROR,__T(bsd.fw_st_ginfo_fail));
		}else{
		F._upgrade_from[1].checked=true;
		if ( F.bsd_err_msg.value == 3 )
			my_alert(O_PAGE,INFO,get_result_msg('upgrade.asp',parseInt(F.bsd_err_msg.value,10)))
		else
			my_alert(O_PAGE,ERROR,get_result_msg('upgrade.asp',parseInt(F.bsd_err_msg.value,10)))
		}
		parent.document.getElementById("hidden_bg").style.display="none";
		stop_count();
	}
<% support_invmatch("BSD_SUPPORT","1","/*");%>

<% support_match("BSD_SUPPORT","1","/*");%>
	now_wait_time+=5000;
	if ( now_wait_time >= wait_time ) 
	{
		top.location.href = "<% get_http_prefix(""); %>";	
	}
	setTimeout("count_waittime()", 5000);
<% support_match("BSD_SUPPORT","1","*/");%>
		
}

function init(){

/*below support BSD and USB start*/
<% support_invmatch("BSD_SUPPORT","1","/*");%>
	var F = document.frmupgrade;
	frames['usbcontenttd'].location.href = goto_link("bsd_show_step.asp");
	if ( sbt == "bsd_upgrade_cisco" || sbt == "bsd_saveusb" ||
 	     (sbt == "bsd_chkver" && F.bsd_st.value != "6" && F.bsd_st.value != "5") )
	{
		parent.document.getElementById("hidden_bg").style.display="";
		count_waittime();
		choose_disable(document.getElementById("chk_restore"));
		choose_disable(document.getElementById("t1"));
		return;
	}
	parent.document.getElementById("hidden_bg").style.display="none";
	parent.document.getElementById("save_bg").style.display="none";
	if ( parent.document.getElementById("upgrade_fail")) 
	{ 
		var fw_st=parent.document.getElementById("upgrade_fail").value;
		if(fw_st == 1)
		{
			parent.document.getElementById("upgrade_fail").value = 0;
			my_alert(O_PAGE,ERROR,__T(msg.upgradefail));	
		}
		else if(fw_st == 3)
		{
			parent.document.getElementById("upgrade_fail").value = 0;
			my_alert(O_PAGE,INFO,__T(bsd.fw_st_same),"");
		}
		else if(fw_st == 4)
		{
			parent.document.getElementById("upgrade_fail").value = 0;
			my_alert(O_PAGE,ERROR,__T(bsd.fw_st_invalid));	
		}
		else if(fw_st == 5)
		{
			parent.document.getElementById("upgrade_fail").value = 0;
			my_alert(O_PAGE,ERROR,__T(bsd.fw_st_nofw));	
		}

	}
        if("<% nvram_get("http_from"); %>" == "wan" && "<% nvram_get("remote_upgrade"); %>" == "0" ) 
		DISABLE_PART(F,"all_start","all_end",1);
	choose_disable(document.getElementById("chk_restore"));
	choose_disable(document.getElementById("t1"));
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("fileTxtBox"));
		choose_disable(document.getElementById("chkbt"));
	}
	F._upgrade_from[1].checked=true;
	chg_act("<%nvram_get("bsd_action");%>");
	bsd_sel_interval(nv_bsd_interval);
	//For time range selection +++
	var tmp_s_hour = 0;
	var inthour=parseInt(nv_sel_time,10);
	if ( flg_24 == 0 ) 
	{
		if( (inthour >= 12) && (inthour !=24))
		{
			F.stime.selectedIndex = 1;	//pm
			if(inthour !=12)
				tmp_s_hour = parseInt(nv_sel_time,10)-12;
			else
				tmp_s_hour = inthour;
		}
		else
		{
			F.stime.selectedIndex = 0;	//am
			if((inthour == 24))
				tmp_s_hour = 12;
			else
				tmp_s_hour = parseInt(nv_sel_time,10);
		}
		for(var k=0; k<_hour_name12.length; k++)
		{
			if ( parseInt(_hour_name12[k],10) == tmp_s_hour ) 
				F.stime_hour[k].selected = true;
		}
	}
	//For time range selection ---
	if ( sbt == "bsd_chkver" )
        {
                var chk_st = "<% nvram_get("usb_savefile_st"); %>";
                if ( chk_st == "" || chk_st == "3" )
                        my_alert(O_PAGE,SUCCESS,__T(bsd.fw_st_ginfo_ok));
                else
                        my_alert(O_PAGE,ERROR,__T(bsd.fw_st_ginfo_fail));
        }

<% support_invmatch("BSD_SUPPORT","1","*/");%>
/*above support BSD and USB start*/

/*below not support BSD and USB start*/
<% support_match("BSD_SUPPORT","1","/*");%>
	parent.document.getElementById("hidden_bg").style.display="none";
	var F = document.frmupgrade;
	if ( parent.document.getElementById("upgrade_fail") && parent.document.getElementById("upgrade_fail").value == 1 ) 
	{
		parent.document.getElementById("upgrade_fail").value = 0;
		my_alert(O_PAGE,ERROR,__T(msg.invalidfw));	
	}
        if("<% nvram_get("http_from"); %>" == "wan" && "<% nvram_get("remote_upgrade"); %>" == "0" ) 
		DISABLE_PART(F,"all_start","all_end",1);
	choose_disable(document.getElementById("chk_restore"));
	choose_disable(document.getElementById("t1"));
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("fileTxtBox"));
	}
<% support_match("BSD_SUPPORT","1","*/");%>
/*above not support BSD and USB end*/
}

function sel_url(obj)
{
	document.getElementById("txtUploadFile").value = getPath(obj);
	if ( http_power == "r" ) return;
	if ( document.getElementById('txtUploadFile').value != "" ) 
	{
		choose_enable(document.getElementById("chk_restore"));
		choose_enable(document.getElementById("t1"));
	}else{
		choose_disable(document.getElementById("chk_restore"));
		choose_disable(document.getElementById("t1"));
	}
	if ( document.frmupgrade.file_type[0].checked ) 
		sel_type("code");
	else
		sel_type("lang");
}

function sel_type(val)
{
<% support_invmatch("BSD_SUPPORT","1","/*");%>
	var F = document.frmupgrade;
	if ( http_power == "r" )  return;
	if ( val == "code" && document.getElementById('txtUploadFile').value != "" )
		choose_enable(document.getElementById("chk_restore"));
	else
		choose_disable(document.getElementById("chk_restore"));
	if( val == "lang" )
	{
		F._upgrade_from[1].checked=true;
		choose_enable(F.t6);
		choose_enable(F.fileTxtBox);
		choose_enable(F.txtUploadFile);
	}
	if ( val == "code")
	{
		choose_enable(F._upgrade_from[0]);	
<% support_invmatch("USB_UPGRADE_SUPPORT","1","//");%>	choose_enable(F._upgrade_from[2]);	
	}
	else
	{
		choose_disable(F._upgrade_from[0]);	
<% support_invmatch("USB_UPGRADE_SUPPORT","1","//");%>	choose_disable(F._upgrade_from[2]);	
	}
<% support_invmatch("BSD_SUPPORT","1","*/");%>

<% support_match("BSD_SUPPORT","1","/*");%>
	if ( http_power == "r" )  return;
	if ( val == "code" && document.getElementById('txtUploadFile').value != "" )
		choose_enable(document.getElementById("chk_restore"));
	else
		choose_disable(document.getElementById("chk_restore"));
<% support_match("BSD_SUPPORT","1","*/");%>
}

</script>
<body onload="init();">
<% support_invmatch("BSD_SUPPORT","1","<!--");%>
<FORM id=frm name="frmupgrade" method=post action="apply.cgi">
<% support_invmatch("BSD_SUPPORT","1","-->");%>
<% support_match("BSD_SUPPORT","1","<!--");%>
<FORM id=frm name="frmupgrade" method=post action=upgrade.cgi encType=multipart/form-data>
<% support_match("BSD_SUPPORT","1","-->");%>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=Is_lang_file id=Is_lang_file>
<input type=hidden name=gui_action>
<input type=hidden name=factory_default id=factory_default>
<% support_invmatch("BSD_SUPPORT","1","<!--");%>
<input type=hidden name=next_page value="upgrade">
<input type=hidden name=bsd_mail_enable value="<% nvram_get("bsd_mail_enable"); %>" >
<input type=hidden name=bsd_admin_enable value="<% nvram_get("bsd_admin_enable"); %>" >
<input type=hidden name=bsd_interval value="<% nvram_get("bsd_interval"); %>" >
<input type=hidden name=bsd_action value="<% nvram_get("bsd_action"); %>" >
<input type=hidden name=bsd_sel_time value="<%nvram_get("bsd_sel_time");%>">
<input type=hidden name=bsd_st id=bsd_st value="">
<input type=hidden name=bsd_err_msg id=bsd_err_msg value="">
<input type=hidden name=bsd_percentage id=bsd_percentage value="">
<input type=hidden name=wait_time value=10>
<% support_invmatch("BSD_SUPPORT","1","-->");%>
<div class=content_layer id=divcontent>
<input type=hidden name=all_start>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.fwupgrade));</script></TR>
  <TR><TD colspan=2>
	<TABLE class=CONTENT_GROUP cellspacing=0>
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(router.sysinfo),"colspan=2;");</script></TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.devmodel));</script>
		<script>document.write("<% nvram_get("model_name"); %>");</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.pidvid));</script>
		<script>document.write("<% nvram_get("dev_pid_short"); %> <% nvram_get("sysinfo_vid"); %>")</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.curfwver));</script>
		<script>document.write("<% nvram_get("fw_version"); %>")</script>
		</TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__T(bsd.newfwver)+":");</script>
		<script>
//			if( bsd_ver_state == "1" ) 
				document.write("<% nvram_get("bsd_rel_ver");%>")
		</script>
		</TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>

	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.curlangver));</script>
		<script>document.write("<% get_lang_ver("current_lang_version"); %>")</script>
		</TD></TR>
	    	<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.suplangver));</script>
		<script>document.write("<% get_lang_ver("support_lang_version"); %>")</script>
		</TD></TR-->
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.fwlastup));</script>
		<script>
		var current_time = "<% misc_get("fw_upgrade_time"); %>";
	        var t_data = current_time.split(" "); 
        	var date_data = t_data[0].split("/");
	        var time_data = t_data[1].split(":");
		if ( flg_24 == 0 ) 
			document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1],t_data[2]));
		else{
			var tmp_hour = parseInt(time_data[0],10);
			if ( t_data[2] == "PM" ) tmp_hour+=12;
			document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],tmp_hour,time_data[1]));
		}
		</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.downloadfw));</script>
		<A class='content_link' href="javascript:ciscolink()"><script>Capture(mang.downloadlink);</script></a>
		</TD></TR>

		<!-- BSD support start -->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(bsd.bsd),"colspan=2;");</script></TD></TR>
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__T(bsd.interval));
			var _name= new Array(__T(mang.never),__T(mang.week),__T(def.smonth));
			var _val= new Array("never","week","month");
			draw_object(O_GUI,SELBOX,"_bsd_interval","onChange=bsd_sel_interval(this.value)",_name,_val, nv_bsd_interval);
			document.write("&nbsp;&nbsp;");
			draw_object(O_GUI,BT,__T(bsd.chknow),"chkbt","BT","onClick=chk_bt(this.form)");
		    </script>
		</TD></TR>
		<input type=hidden name=bsd_start1>
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__T(bsd.actautoup));
			var _auto_name = new Array(__T(bsd.auto_never),__T(bsd.auto_imm),__T(bsd.auto_spec));
			var _auto_val = new Array("0","1","2");
			draw_object(O_GUI,SELBOX,"_bsd_action","onChange=chg_act(this.value)",_auto_name,_auto_val,"<% nvram_get("bsd_action"); %>");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("am","pm");
			if ( flg_24 == 0 ) 
			{
				draw_object(O_GUI,SELBOX,"stime_hour","id=stime_hour",_hour_name12,_hour_name12);
				draw_object(O_GUI,SELBOX,"stime","id=stime",_name,_val);
			}else{
				draw_object(O_GUI,SELBOX,"stime_hour","id=stime_hour",_hour_name24,_hour_name24,nv_sel_time);
			}
		    </script>
		</TD></TR>
		<input type=hidden name=bsd_perform_start>
		<TR><script>
		    </script>	
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(bsd.notify)); </script>	
		    <input type=checkbox name=_via_admin <% nvram_match("bsd_admin_enable","1","checked"); %> >
		    <script>Capture(bsd.notify_admin);</script>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,""); </script>	
		    <input type=checkbox name=_via_mail <%nvram_match("bsd_mail_enable","1","checked");%> onClick=_via_mail_chg(this.form)>
		    <script>Capture(bsd.notify_mail);
			document.write("&nbsp;");
			draw_object(O_GUI,BT,__T(bsd.notify_mailbt),"mailbt","BT","onClick=mail_bt(this.form)");
		    </script>
		    <SPAN style=color:#8e8e8e><script>Capture(bsd.emailinfo);</script></SPAN>
		</TD></TR>	
		<input type=hidden name=bsd_end>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!-- BSD support end -->

		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>

		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(bsd.manual),"colspan=2;");</script></TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>

	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.filetype));</script>
		<script>
		var _val = new Array("code","lang");
		var _name = new Array(__T(router.fwimg),__T(router.langfile));
		draw_object(O_GUI,RADIO,"file_type",_val,_name,"code","onclick=sel_type(this.value)");
		</script>
		
		</TD></TR>
		
		<!-- BSD support start -->
		<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__T(bsd.upgrade_from)+":");</script>
			<input type=radio value=0 name=_upgrade_from onClick=_upgrade_from_cisco(0)>&nbsp;cisco.com
			<script>
			if( bsd_ver_state == "1" ) 
				document.write(spell_words(bsd_str, "<% nvram_get("bsd_rel_ver"); %>"));
			</script>
			</TD>
		</TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
			    <div style="position:relative">
			    <INPUT type=radio value=1 name=_upgrade_from onClick=_upgrade_from_cisco(1)>&nbsp;<script>Capture(bsd.pc)</script>&nbsp;
			    <input name=file id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
			    <INPUT type=text id=txtUploadFile name=browser size=23 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
			    <span id=msg_file style="position:absolute;left:200px"></span>
			    <script>
			    draw_object(O_GUI,BT,__T(router.browse),"t6 style='position:absolute;left:210px;top:0px'","BT","");
			    </script>
			</div>
			</TD>
		</TR>
		<TR><TD> 
		<iframe frameborder=0 width=500px height=100% style="overflow:hidden;display:none" allowtransparency=true id=usbcontenttd name=usbcontenttd>
		</iframe>
		</TD></TR>
		<% support_invmatch("BSD_SUPPORT","1","-->"); %>
		<!-- BSD support end -->

		<!-- BSD not support start -->
		<% support_match("BSD_SUPPORT","1","<!--"); %>
	    	<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.selfwfile),""," valign=top");</script>
		<div style="position:relative">
		<input name=file id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<script>
		if ( Browser != "Firefox" ) 
		{
			document.write("<INPUT type=text id=txtUploadFile name=browser size=28 style='position:absolute;background-color:#cecaca;margin:0; height:20px'>");
	                draw_object(O_GUI,BT,__T(router.browse),"t3 id=t3 style='position:absolute;left:175px;top:0px'","BT","");
		}
		else
		{
			document.write("<INPUT type=text id=txtUploadFile name=browser size=18 style='position:absolute;background-color:#cecaca;margin:0; height:20px'>");
	                draw_object(O_GUI,BT,__T(router.browse),"t3 id=t3 style='position:absolute;left:130px;top:0px'","BT","");
		}
		</script>
		
		</div>
		<% support_match("BSD_SUPPORT","1","-->"); %>
		<!-- BSD not support end -->
	    	<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"");</script>
		<input type=checkbox name=restore id=chk_restore><script>Capture(msg.resetall);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		draw_object(O_GUI,BT,__T(msg.startfw),"t1","BT_L","to_upgrade(this.form)");
		if ( http_power == "r" ) choose_disable(document.getElementById("t1"));

		<% support_match("BSD_SUPPORT","1","/*"); %>
		chg_layout();
		<% support_match("BSD_SUPPORT","1","*/"); %>
		</script>
		<SPAN style=color:#8e8e8e><script>Capture(msg.reboothint);</script></SPAN>
        </TD></TR>
	</TABLE>

  </TD>
  </TR>
<% support_invmatch("BSD_SUPPORT","1","<!--"); %>
<% web_include_file("BT.asp"); %>
<% support_invmatch("BSD_SUPPORT","1","-->"); %>
</TABLE>
<input type=hidden name=all_end>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
<!--script>my_alert(O_PAGE,INFO,"Detected language package doesn't match current firmware. You must update correct language package again.");</script-->
