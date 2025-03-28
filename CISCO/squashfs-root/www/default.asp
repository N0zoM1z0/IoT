<% no_cache(); %>
<input type=hidden name="privilege_str">
<script type="text/javascript" src="P.js"></script>
<script type="text/javascript" src="func.js"></script>
<LINK href="cues_taglib.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="cues_taglib_layout.js"></script>
<script type="text/javascript" src="cues_taglib.js"></script>
<script src="cues_drawn.js" language="JavaScript"></script>
<% js_link(); %>
<script type="text/javascript" src="position.js"></script>
<script type="text/javascript" src="common.js"></script>
<LINK href="style.css" type=text/css rel=stylesheet>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<script>

<% support_invmatch("BSD_SUPPORT","1","/*");%>
var bsd_first_login="<% nvram_get("bsd_first_login");%>";
var bsd_ver_detected="<%get_bsd_fw_time("detected");%>".split(",");//XX:XX,dd/mm/yyyy
var bsd_ver_updated="<%get_bsd_fw_time("updated");%>".split(",");
var bsd_ver_state="<% get_bsd_ver_state(); %>";
var bsd_admin_enable="<% nvram_get("bsd_admin_enable");%>";
var pop_status="";
<% support_invmatch("BSD_SUPPORT","1","*/");%>
var sbt = "<% nvram_get("submit_button"); %>";

var wps_result = "<% nvram_get("wl_wps_result"); %>" ; 
function get_url(page)
{
        var path="";
        if ( close_session != "1" )
        {
		if ( document.getElementById("session_key").value != "" ) 
	                path=page+";session_id="+document.getElementById("session_key").value;
		else
			path=page+get_url_key(1);			
        }else
                path=page;
	//alert("path="+path);
        return path;
        
}

function getlink(F,a)
{
	F.openwin.value=a;
	document.getElementById("newwin").src = get_url("check_session.asp");
}


function get_about()
{
	var about_win;
	var url = get_url('about.asp');
	about_win = self.open(url,'aboutTable','toolbar=no,memubar=no,resizable=no,scrollbars=no,directories=no,status=no,location=no,width=480,height=425',"_blank");
}

function logout(F)
{
	F.submit_button.value="login";
	F.submit_type.value="logout";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function get_help(help_name)
{
	var about_win;
	var tmp;
	var nowlang = document.getElementById("NOW_LANG").value;
	if ( nowlang  == "EN" ) 
		tmp = 'help/EN_help/'+help_name;//document.getElementById("now_help").value;
	else
		tmp = 'help/'+nowlang+'/'+help_name;//document.getElementById("now_help").value;
	var url = get_url(tmp);
	about_win = self.open(url,'helpwin','alwaysRaised,resizable,scrollbars,width=800,height=400');
//	document.helpwin.getElementById("contentiframe").href = get_url("help/EN_help/wireless01.html");        	
}

//START PANE............................................2010/3/17 By EMILY
var ResizeBox=null;
var ResizeLayer=null;
function resize()
{
    myExtendHeight("layout");
//    if ( Browser != "IE" ) 
    {
	    myExtendHeight("rightframe");
	    myExtendHeight("contentarea");
	    myExtendHeight("leftarea");
	    myExtendHeight("lefttree");
    }
}

function MouseOverGripper(evt,obj)
{
	obj.style.cursor="col-resize";
	document.getElementById("MMoveArea").style.backgroundColor="#0088C2";
}

function MouseOutGripper(evt,obj)
{
	document.getElementById("MMoveArea").style.backgroundColor="";
}

function init(){
	var F = document.deffrm;
	choose_disable(F.next_page);
	// For changed LAN IP , status_upgrade page cannot load lang pack issue
	if ( sbt != "bsd_upgrade_cisco")  
                parent.document.getElementById("hidden_bg").style.display="none";
        else
                parent.document.getElementById("hidden_bg").style.display="";
	document.getElementById("get_prefix_url").value = __T(msg.cbt);
	document.getElementById("status_reboot_msg").value = __T(msg.rebootingdev);
	// If set iframe of style to display=none in IE. It will have javascript error and cannot 
	// redirect to login page. 
	if ( Browser != "IE" ) 
		document.getElementById("newwin").style.display="none";	
	// Notes by Emily 2010.12.30

	document.getElementById("deffrm").action = "apply.cgi;session_id=<% nvram_get("session_key"); %>";
        document.getElementById("save_bg").style.display="none";
	if ( Browser == "FireFox" ){
                document.getElementById("logo").background = "url(image/Cisco_Logo_RGB_67x40-black.png)";
                document.getElementById("process").background = "url(image/ProgressBar_indeterminate.gif)";                 
		document.getElementById("img_logo").style.display="none";
                document.getElementById("img_process").style.display="none";
        }
        else{   
	        document.getElementById("logo").background = "";
                document.getElementById("img_logo").style.display="";
                document.getElementById("img_process").style.display="";                 
		document.getElementById("process").background = "";
        }
	chg_win();
	get_page(frames['fun'],frames['content_area'],frames["wizard"]);
	<% support_invmatch("BSD_SUPPORT","1","/*");%>
	if ( "<% nvram_get("http_power"); %>" == "rw" )  
	{
		if ( (bsd_admin_enable=="1") && (bsd_first_login == "1"))
		{
			var bsdver = "<%nvram_get("bsd_rel_ver");%>";
			var str="";
			if(bsd_ver_state == "1" && bsdver !="" && bsd_ver_detected[0] != "0")
			{
				pop_status="detect";
				var relurl = "<%nvram_get("bsd_release_doc_url");%>";
				str=get_spell_words(BSD, bsd_fw_detected, bsdver, bsd_ver_detected[0],bsd_ver_detected[1]);
				if(relurl != "")
					str=str+". "+__T(bsd.releasenote)+"<A href="+relurl+" target=_new "+"> "+__T(bsd.here)+".</A>";
				my_alert(O_GUI,WARNING,__T(share.info),str,"bsd_alert_result(1)","bsd_alert_result(0)","","bsd");	
			}
			else if(bsdver != "" && bsd_ver_updated[0] != "0")
			{
				pop_status="update";
				str=spell_words(bsd_fw_updated, bsdver, bsd_ver_updated[0],bsd_ver_updated[1]);
//				str=get_spell_words(BSD, bsd_fw_updated, bsdver, bsd_ver_updated[0],bsd_ver_updated[1]);
				my_alert(O_GUI,INFO,__T(share.info),str,"bsd_alert_result(0)","bsd");	
			}

		}

	}
	setTimeout("blank_words(1)",1000);
	<% support_invmatch("BSD_SUPPORT","1","*/");%>

	
}

function get_page(fun_obj,content_obj,wizard_obj){
	var start_url = "getstart.asp";
	var tree_url = "tree.asp";
	var getting_wizard = "<% nvram_get("getting_wizard"); %>";
	var getting_start = "<% nvram_get("getting_start"); %>";
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	var auth_st = "<% nvram_match("auth_st","1","1"); %>";
	document.getElementById("now_page").value = Menu[0][0][PAGE_NAME];
	document.getElementById("now_help").value = Menu[0][0][PAGE_HELP];
	
	// If upgrade fail , redirect to upgrade page.
	var F = document.deffrm;
	if(auth_st != "1")
	{
		content_obj.location.href = get_url("login.asp");
	}else if ( document.getElementById("gui_changed_page") != null )
	{
		F.newpage.value = document.getElementById("gui_changed_page").value;
		fun_obj.location.href = get_url(tree_url);
		content_obj.location.href = get_url(document.getElementById("gui_changed_page").value);
	}else if ( sbt == "bsd_upgrade_cisco" )  
        {
                F.newpage.value = "upgrade.asp" ;
                fun_obj.location.href = get_url(tree_url);
                content_obj.location.href = get_url("upgrade.asp");	
	}else{
			/*if ( window.opener != null ) 
			{
				start_url = "portal_info.asp";
				tree_url = "tree_portal.asp";
			}
			else */
			if ( getting_start == "0" || ap_mode == "1" ) 
			{
				start_url = "dashboard.asp";
				document.getElementById("now_page").value = Menu[1][0][PAGE_NAME];
				document.getElementById("now_help").value = Menu[1][0][PAGE_HELP];
			}

			if((getting_wizard == "1"))//else if( (get_url_filename(0) == 1) &&  (getting_wizard == "1"))
			{
				wizard_obj.location.href = get_url("wizard/index.asp");
				document.getElementById("wizard_bg").style.display="";
			}else{
				if ( http_power == "rw" && aging_time == "1" )//&& (get_url_filename(1) == 1))
				{
					start_url = "change_password.asp";
					tree_url = "change_password_tree.asp";
				}
			}
		document.getElementById("fun").src = get_url(tree_url);
		document.getElementById("rightframe").src = get_url(start_url);

	}
}

var resizeTimer = null;

function onresizeHandler()
{
        if(resizeTimer!=null)
                clearTimeout(resizeTimer);
        resizeTimer = setTimeout("resize()",300);
}
function Sel_Lang(F)
{
	F.submit_button.value = "default";
	F.change_action.value = "gozila_cgi";
	F.submit_type.value = "set_lang";
	F.submit();
}

function to_ok()
{
	document.getElementById("wps_bg").style.display="none";
}

function savebg_init()
{
	document.getElementById("save_flg").value = "0";
	setTimeout('regetstatus()',5000);
}

function regetstatus()
{
	if ( document.getElementById("save_flg").value != "1" ) 
	{
		frames["frm_save"].location.href = goto_link("getconnst_1.asp");
		setTimeout('regetstatus()', 5000);		
	}
}

function redirect_page()
{
	var F = document.deffrm;
	document.getElementById("reboot_msg").innerHTML = __T(msg.trytoconnect);
	document.getElementById("hidden_bg_bt").style.display="none";
	document.getElementById("hidden_bg_bar").style.display="";
	top.location.href = get_url(document.getElementById("get_prefix_url").value);
}

// FOR MY_ALERT USED
// END FOR MY_ALERT_USED

document.onkeydown=disableKey;
<% support_invmatch("BSD_SUPPORT","1","/*");%>
var timerID = null;

function stop_blink()
{
	if ( timerID ) 
		clearTimeout(timerID);
	blank_words(0);
}

function start_blink()
{
	blank_words(1);
}

function blank_words(blink_flg)
{
	var flg=0;
	if ( document.getElementById("alertimg") ) 
	{
		if ( blink_flg == 0 )
		{
			document.getElementById("alertimg").src = "image/none.gif";
//			document.getElementById("bsd_img").style.display = "";
			return;
		}else{
			if ( Browser == "IE" )
			{
				if ( document.getElementById("alertimg").style.display == "" ) 
				{
					document.getElementById("alertimg").style.display = "none";
					document.getElementById("bsda").innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					document.getElementById("bsda").className = "Header_re_a";
				}
				else
				{	
					document.getElementById("alertimg").style.display = "";
					document.getElementById("bsda").innerHTML = __T(syslog.event_alert);
					document.getElementById("bsda").className = "Header_a";
				}
				
			}else{
				if ( document.getElementById("alertimg").src.indexOf("image/alert_critical_24.png") != -1 ) 
				{
					document.getElementById("alertimg").src = "image/none.gif";
					document.getElementById("bsda").innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					document.getElementById("bsda").className = "Header_re_a";
				}
				else
				{
					document.getElementById("alertimg").src = "image/alert_critical_24.png";
					document.getElementById("bsda").innerHTML = __T(syslog.event_alert);
					document.getElementById("bsda").className = "Header_a";
				}
			}

			/*
			if ( document.getElementById("bsd_img").style.display == "none" ) 
				document.getElementById("bsd_img").style.display = "";
			else
				document.getElementById("bsd_img").style.display = "none";
			*/
			timerID=setTimeout("blank_words(1)",1000);
		}
	}
}


//Must keep this session behind init(). Because BSD must show warning message first then clear first login information.
function bsd_alert_result(val)
{
	var F = document.deffrm;
	alert_result(0);
	choose_enable(F.next_page);
	F.next_page.value = "default";

	if ( val == 1 )	//upgrade  
	{
		F.submit_button.value = "bsd_upgrade_cisco";
		F.gui_action.value = "Apply";
		F.submit();
		document.getElementById("wizard_bg").style.display="none";
		document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg1);
		document.getElementById("hidden_bg").style.display="";

	}else		//cancel 
	{
		F.submit_button.value = "bsd_clear_msg";
		F.change_action.value = pop_status;
		F.gui_action.value = "Apply";
		F.submit();
	}

}
function count_waittime()
{
	//now_wait_time+=5000;
	//if ( now_wait_time >= wait_time ) 
	//{
	//	top.location.href = "<% get_http_prefix(""); %>";	
		//top.location.href = "<% get_http_prefix(""); %>default.asp;session_id=<% nvram_get("session_key"); %>";
	//}
	setTimeout("count_waittime()", 3000);
		
}

<% support_invmatch("BSD_SUPPORT","1","*/");%>
//LPM must size these iframes as well
var resizeTimer = null;
function onresizeHandler()
{
  if(resizeTimer!=null)clearTimeout(resizeTimer);
  resizeTimer = setTimeout("resize()",200);
}
function resize()
{
  //cuesExpandHeight("naviframe1", 30);
    myExtendHeight("cuesLayout");
    if ( Browser != "IE" ) 
    {
	    myExtendHeight("rightframe");
	    myExtendHeight("contentarea");
	    myExtendHeight("navarea");
	    myExtendHeight("navcontainer");
    }
}

</script>
<BODY onresize=chg_win() onload=init()>
<form autocomplete=off id=deffrm name=deffrm method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=session_key id=session_key value="<% get_session_key("1"); %>">
<input type=hidden name=openwin>
<input type=hidden name=next_page>
<input type=hidden name=gui_action>
<!--For Support My_Alert used-->
<input type=hidden id=alert_type>
<input type=hidden id=GUI_LOCK value=0>
<input type=hidden id=GUI_FUN value="">
<input type=hidden id=keeppage value="#">
<input type=hidden id=newpage value="#">
<input type=hidden id=wizard_var>
<input type=hidden id=def_wizard_var>
<input type=hidden id=obj_id>
<input type=hidden id=close_ipv6>
<input type=hidden id=get_prefix_url>
<input type=hidden id=save_flg value=0>
<input type=hidden id=now_help>
<input type=hidden id=now_ipmode>
<input type=hidden id=now_page>
<input type=hidden id=status_reboot_msg>
<input type=hidden id=guiwpspush>
<input type=hidden id=NOW_LANG value="<% nvram_get("language"); %>">
<iframe id=newwin height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<!--For Support My_Alert used-->
<div id=div_bg class=BG_DIV><img id=bg src='image/small_bg.jpg' width=100% style="position:absolute; z-index:-1">
<TABLE cellspacing=0 width=100% class=TB>
<tr class=HEADER>
		<td class=LOGOTD><img src="/image/cisco_logo_header.png"></td>
		<td class=PRODTD>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr><td class=PRODNAME><script>Capture(router.productname);</script></td></tr>
				<tr><td class=APPNAME><script>
				if ( current_model_name == "RV130" ) 
					Capture(router.rv130_appname);
				else
					Capture(router.appname);
				</script></td></tr>
			</table>
		</td>
		<td class=HELP><span class=Header_re>
		<script>
		var tmp_power=__T(router.guest);
		if ( "<% nvram_get("http_power"); %>" == "rw" ) 
			tmp_power = __T(router.admin);	
		<% support_invmatch("BSD_SUPPORT","1","/*");%>
		var bsd_fail="<%get_bsd_fw_time("fail");%>".split(",");
		//if ( "<% nvram_get("http_power"); %>" == "rw" && (bsd_admin_enable=="1") && (bsd_ver_state == "1")&& (bsd_fail[0] != "0")) 
		if ( "<% nvram_get("http_power"); %>" == "rw" && (bsd_admin_enable=="1") && (bsd_fail[0] != "0")) 
		{
			//Add blink alert image and words.
			var str="";
	//		if(bsd_fail[0] == "3" || bsd_ver_state == "2")
	//			str=__T(bsd.fw_st_same);
			if(bsd_fail[0] == "4")
				str=__T(bsd.fw_st_invalid);
			else if(bsd_fail[0] == "5")
				str=__T(bsd.fw_st_nofw);
			else if(bsd_fail[0] == "9")
				str=__T(bsd.fw_st_ginfo_fail);
			else
				str=__T(msg.upgradefail);
			document.write("<span class=Header_re>");
                	document.write("<img src=image/alert_critical_24.png id=alertimg width=10px height=10px alt='"+str+"' title='"+str+"'>&nbsp;");
			document.write("<A id=bsda class='Header_a' href=\"javascript:get_position('view_logs.asp')\" title='"+str+"'>"+__T(syslog.event_alert)+"</A>");
			document.write("</span>");
		//	document.write(__T(syslog.event_alert)+"</A>");
		}
		else if ( "<% nvram_get("http_power"); %>" == "rw" && (bsd_admin_enable=="1") && (bsd_ver_state == "1")) 
		{
			//new firmware available.
			document.write("<span class=Header_re>");
                	document.write("<img src=image/Status_success_icon.png width=10px height=10px>&nbsp;");
			document.write( "<A id=bsda1 class='Header_re_a' href=\"javascript:get_position('upgrade.asp')\">");
			Capture(bsd.defmsg);
			document.write("</A></span>");		
		}
		<% support_invmatch("BSD_SUPPORT","1","*/");%>

		document.write("<% get_user_data("admin_guest_name"); %>"+" ("+tmp_power+")");
		</script>
		</span>
                <span class=Header_re><script>Capture(router.lang)</script>:
		<script>
			<% onload_lang(); %>
			draw_object(O_GUI,SELBOX,"sel_lang","width=165px onChange=Sel_Lang(this.form)",_name,_val,"<% nvram_get("language"); %>");
		</script>
		</span>
                <span class=Header_re><a class=Header_re_a href='javascript:logout(document.forms[0])'><script>Capture(router.logout);</script></a></span>
                <span class=Header_re><a class=Header_re_a href='javascript:getlink(document.forms[0],"about")'><script>Capture(router.about);</script></a></span>
                <span class=Header_re><a class=Header_re_a href='javascript:getlink(document.forms[0],"help")'><script>Capture(router.help);</script></a></span></td>
</tr>
</TABLE>
<!--TABLE style=padding-top:15px>&nbsp;</TABLE-->
<table class=MAINTABLE id=cuesLayout cellpadding=0 width=100% height=100%>
<TR>
	<TD id=leftspacea width=15px>&nbsp;</TD>
	<td class=FUNLIST id=leftarea width=170px height=100%>
	<!--div-->
	<div id=navcontainer style="position:relative"aclass=cuesDrawersContainer>
	      <script>
              document.write("<iframe name=fun id=fun frameborder=0 class=CONTENT_BG allowtransparency=true></iframe>")
	      </script>
	</div>
	</TD>
	<!--/div-->
	<td id=cuesLayoutTogglerArea onmousedown="return icuesResizeLayerMouseDown(event,this)" width=4>
		<div id="cuesResizeLayer"><div id="cuesResizeBox">&nbsp;</div>&nbsp;</div>
		<IMG id=cuesNavGripper onmouseover=cuesMouseOverGripper(event,this); title="Resize Pane" onmouseout=cuesMouseOutGripper(event,this); alt="Resize Navigation Pane" src="image/NavPaneGripperT_V.gif"></img>
	</TD>
	<td valign=top width=* id=iframetd>
      	<DIV style='position:relative' id=contentarea style="overflow:auto;position:relative;width:100%;height:100%">
	<script>
	document.write("<iframe name=content_area allowtransparency=true frameborder=0 class=CONTENTAREA id=rightframe title=''></iframe>");
	</script>
		</div>
                </TD>
		<TD width=15px>&nbsp;</TD>

</TR></TABLE>
<DIV id=copyrightline class=copyrightTD colspan="5"><script>Capture(router.copyright);</script> </DIV>
</script>
<!-- Save with ready time DIV -->
<div id=save_bg class=DISABLE_FORM style=display:none>
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
	<TABLE style="background-color:#A2B9C9;" border=0 cellspacing=0>
		<TR><TD style="padding-top:10px; padding-bottom:8px;text-align:center" id=upload_msg><script>Capture(msg.upload);</script></TD></TR>
		<TR><TD style="padding-left:10px;padding-right:10px;padding-bottom:10px">
		<img src=image/ProgressBar_indeterminate.gif width=270px height=17px>
		</TD></TR>
        </TABLE>
</TD>
</TR>
</TABLE>
</div>
<!-- Save with ready time DIV -->
<div id=save_time_bg class=DISABLE_FORM style=display:none>
<iframe id=frm_save height=0 width=0 name=frm_save frameborder=0 scrolling=no style=display:none></iframe>
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
        <TABLE style="background-color:#A2B9C9;" border=0 cellspacing=0>
                <TR><TD style="padding-top:10px; ;text-align:center" id=save_bg_msg><script>Capture(msg.upload);</script></TD></TR>
                <TR><TD style="padding-top:10px; padding-bottom:8px;text-align:center"><script>Capture(msg.plswait1);</script></TD></TR>
                <TR><TD style="padding-left:10px;padding-right:10px;padding-bottom:10px">
                <img src=image/ProgressBar_indeterminate.gif width=270px height=17px>
                </TD></TR>
        </TABLE>
</TD>
</TR>
</TABLE>
</div>
<!-- upgrade status div -->
<div id=hidden_bg style="display:none;" class=UPGRADE_FORM>
<img id=bg src='image/small_bg.jpg' width=100% style="position:absolute; z-index:-1">
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
        <TABLE bgcolor=#A2B9C9>
        <TR><TD style="padding-top:18px;" align=center><TABLE align=center><TR><TD id=logo style='background-repeat:no-repeat;width:62px;height:33px'><img id=img_logo src=image/Cisco_Logo_RGB_67x40-black.png></TD></TR></TABLE></TD></TR>
        <TR><TD style="padding-top:18px;padding-bottom:8px" align=center id=reboot_msg><script>Capture(msg.upgrade);</script></TD></TR>
	<TR id=hidden_bg_bt style=display:none><TD align=center><script>
	draw_object(O_GUI,BT,__T(share.cont),"e1","BT_L","redirect_page()");
	</script>
	</TD></TR>
        <TR id=defproc><TD style="padding-left:10px; padding-right:10px; padding-bottom:10px">
                <TABLE border=0 style="width:260px; height:18px" cellspacing=0>
                <TR id=hidden_bg_bar><TD style="width:100%;" id=process>
                <img id=img_process src='image/ProgressBar_indeterminate.gif'></TD></TR>
                <TD></TR>
                </TABLE>
        </TD></TR>
	<TR id=procbar style=display:none><TD style="padding-left:15px;padding-right:15px;padding-bottom:15px;text-align:center" colspan=2>
		<TABLE border=0 cellspacing=0 align=center>
			<TR><TD id=proc_percent colspan=2 align=center style="padding-bottom:8px">0%</TD></TR>
			<TR><TD id=proc_left class=PROC_STATUS></TD><TD id=proc_right class=PROC_STATUS1></TD></TR>
		</TABLE>
	</TD></TR>
        </TABLE>
</TD>
</TR>
</TABLE>
</div>
<!--Wizard div -->
<div id=wizard_bg style="display:none;" class=DISABLE_FORM2 align=center>
<TABLE valign=center height=100%>
<TR><TD>
<iframe name=wizard scrolling=no id=wizard frameborder=0 style="overflow:hidden;background-image:url('image/wbg2.png')" width=720px height=500px allowtransparency=true></iframe>
</TD>
</TR>
</TABLE>
</div>
<!-- WPS Status div -->
<div id=wps_bg class=DISABLE_FORM style="display:none">
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
        <TABLE style="background-color:#A2B9C9;" border=0 cellspacing=0 width=400px height=100px>
                <TR><TD style="padding:15px;text-align:left" id=wps_msg>
		<P><script>Capture(msg.searchdevice);</script></P>
		<P><script>Capture(msg.plswait);</script></P>
		<P><script>Capture(msg.wpsrunning);</script></P>
		</TD></TR>
		<TR id=statusbar style=display:none><TD style="padding:15px;text-align:center">
		<TABLE cellspacing=0 align=center>
		<TR><TD id=percent colspan=2 align=center>0%</TD></TR>
		<TR><TD id=left class=PROC_STATUS></TD><TD id=right class=PROC_STATUS1></TD></TR>
		</TABLE>
                </TD></TR>
        </TABLE>
</TD>
</TR>
</TABLE>
</div>
<!-- Alert message -->
<div id=div_alert class=ALERT_FORM style=display:none>
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
<TABLE style="border:1px solid #000000;background-color:#ffffff" width=400px cellspacing=0>
<TR bgcolor=#adc7e7>
<TD colspan=2 style=padding:5px><font style="cursor:default"><SPAN id=alert_title></SPAN></font></TD>
<TD width=16px style=padding:5px height=16px><span id=close_icon></span><!--img src=image/AlertCritical16Wht.gif align=right valign=top onclick="javascript:alert_result(0)"--></TD></TR>
<TR bgcolor=#ffffff><TD style=padding:15px width=32 valign=top>
<script>
var src_icon = "Status_criticalerror_icon.gif";
document.write("<img src=image/"+src_icon+" id=alert_logo>");
function chg_win()
{
	chg_win_height("div_alert");
	chg_win_height("save_bg");
	chg_win_height("save_time_bg");
	chg_win_height("wps_bg");
	chg_win_height("wizard_bg");
	chg_win_height("div_bg");
	resize();

}
</script>
</TD>
<TD style="padding-top:15px;padding-bottom:20px; padding-right:20px" align=left valign=top>
<font style="cursor:default"><SPAN id=alert_content></SPAN></font>
</TD><TD></TD></TR>
<TR bgcolor=#ffffff><TD colspan=3 align=center style=padding-bottom:15px>
<SPAN id=alert_bt></SPAN>
</TD></TR>
</TABLE>
</TD></TR></TABLE>
</div>
</FORM></BODY></HTML>
