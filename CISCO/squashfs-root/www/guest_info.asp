<html>
<head>
<title>GUEST INFO</title>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<% js_link(0); %>
<META http-equiv=Content-Type content="text/html"; charset=UTF-8>
<!--LINK href="style.css" type=text/css rel=stylesheet-->
<style type=text/css>
.ALERT_FORM
{
        abackground-image:url("/image/block_50.png");
        position:absolute;
        z-index:0;
        width:100%;
	height:100%;
        left:0;
        top:0;
}

.BT
{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Normal.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_Hover
{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Hover.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_Press{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Press.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_S
{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Normal.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_S_Hover
{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Hover.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_S_Press{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Press.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BG_HIDDEN_DIV{
  position:absolute;
  z-index:0;
  background-color:#407BB3;
  display:none;
}
.BG_DIV{
  position:absolute;
  z-index:0;
  background-color:#407BB3;
}

.INFO_TD{       
   height:100%; 
   width:500px; 
   background-image:url("/image/ToolbarMain.png");
}


.INFO_MSG{
  padding:10px;
  width:32px;
  height:32px;
}

.INFO_MSG1{     
  font-family:Arial;
  font-size:12px;
  color:#000000;
  vertical-align:middle;
  text-align:left;
}       

BODY
{
  font-family:Arial;
  position:absolute;z-index:0;top:0px;left:0px;
  background-color:transparent;
  background-repeat:no-repeat;
  width:100%;
  height:100%;
  padding:0px;
  margin:0px;
  overflow:auto;
}

TD{
  font-size:12px;
  font-family:Arial;
  color:#FFFFFF;
}

INPUT{
  font-size:12px;
  font-family:Arial;
}

</style>
<script>
var now_lang="<% nvram_get("language"); %>"; 
var verif = "<% get_verif(); %>";
var url = "http://<% get_gnet_url(); %>";
function __T(obj){
        return obj;
}

function Capture(obj){
        document.write(obj);
}

function CaptureC(obj)
{
	if ( now_lang == "FR" ) 
		document.write(obj+" :");
	else
		document.write(obj+":");
}

function show_alert(msg,type)
{
        document.getElementById("alert_title").innerHTML = "";
        document.getElementById("alert_content").innerHTML = "";
        document.getElementById("alert_title").innerHTML = __T(syslog.event_warn);
        document.getElementById("alert_content").innerHTML = "";
        document.getElementById("div_alert").style.display="";
        document.getElementById("alert_logo").src="/image/Status_warning_icon.gif";
        document.getElementById("alert_content").innerHTML = msg;
        document.getElementById("alert_bt").innerHTML = "<input type=button class='BT_S' onclick=closeinfo(1,'"+type+"') value='"+__T(filter.yes)+"' id='a1' onMouseover=\"this.className='BT_S_Hover'\" onMouseout=\"this.className='BT_S'\" onMousedown=\"this.className='BT_S_Press'\"><input type=button class='BT_S' onclick=closeinfo(0,'"+type+"') value='"+__T(filter.no)+"' id='a1' onMouseover=\"this.className='BT_S_Hover'\" onMouseout=\"this.className='BT_S'\" onMousedown=\"this.className='BT_S_Press'\">";
        document.body.style.overflow="hidden";
	document.getElementById("div_alert").style.height= document.body.clientHeight+"px";
	document.getElementById("div_alert").style.width= document.body.clientWidth+"px";
        document.body.style.overflow="auto";

}

function closeinfo(val,ctype)
{
	if ( ctype == "timeout" ) 
	{
		var F = document.guestinfo;
        	F.cmac.value = document.getElementById("td_mac").innerHTML;
                F.cip.value = document.getElementById("td_ip").innerHTML;
	        F.gui_action.value = "Apply";
		F.submit_button.value = "captive_login.asp";
               	F.submit(); 
	        if ( val == 0 ) 
		{
			window.open("captive_login.asp");
		}
		window.opener = null;
		window.close();
	}else if ( ctype == "logout" ) 
	{
		if ( val == 1 ) 
	        {
			var F = document.guestinfo;
        	        F.cmac.value = document.getElementById("td_mac").innerHTML;
                	F.cip.value = document.getElementById("td_ip").innerHTML;
	                F.gui_action.value = "Apply";
			F.submit_button.value = "captive_login.asp";
                	F.submit(); 
			window.opener = null;
			window.close();
        	}
	}
        document.getElementById("div_alert").style.display="none";
	//this.close();
}

function to_logout(F)
{
	show_alert(__T(msg.logout),"logout");
}

function init()
{
	chg_win();
        //var status_url = document.location.href.substring(0, document.location.href.lastIndexOf("/"));
	/*
	if ( window.opener == null )
	{
		document.getElementById("newwin").src = "get_redirect.asp";
		self.open(status_url,'helpwin','alwaysRaised=no,resizable=no,scrollbars=no,width=550,height=360',"_blank");
		return;
	}else{
	*/
	//	window.opener.document.location.href = url;
	//}
	
	document.getElementById("div_bg").className="BG_DIV";
	
	if ( document.getElementById("td_time").innerHTML != "none" ) 
		setTimeout('show_leasetime()', 1000); //Every Minutes
	else
		document.getElementById("td_time").innerHTML = __T(logemail.authnone);
}

function show_leasetime()
{
	var time = document.getElementById("td_time").innerHTML;
	var tmptime = time.split(":"); 
	var tmphr, tmpmin, tmpsec, tmpmin2;
	var mintime = (parseInt(tmptime[0],10)*3600+parseInt(tmptime[1],10)*60+parseInt(tmptime[2],10))-1;
	time = parseInt(parseInt(mintime,10)/3600,10);
	if ( time < 10 ) tmphr = "0"+time;
	else tmphr = time;
	tmpmin2 = parseInt(parseInt(mintime,10)%3600,10);
	time = parseInt(tmpmin2/60,10);
	if ( time < 10 ) tmpmin = "0"+time;
	else tmpmin = time;
	time = parseInt(tmpmin2%60,10);
	if ( time < 10 ) tmpsec = "0"+time;
	else tmpsec = time;
	document.getElementById("td_time").innerHTML = tmphr+":"+tmpmin+":"+tmpsec;
	if ( mintime > 0 ) 
		setTimeout('show_leasetime()', 1000); //Every Minutes
	else
	{
		show_alert(__T(msg.sessiontimeout),"timeout");
		document.getElementById("g1").className = "BT_DISABLE";
		document.getElementById("g1").disabled = true;
	
	}
}

</script>
<body onresize=chg_win() onload=init()> 
<FORM autocomplete=off id=frm name=guestinfo method=<% get_http_method(); %> action=guest_logout.cgi>
<input type=hidden name=cmac>
<input type=hidden name=cip>
<input type=hidden name=gui_action>
<input type=hidden name=submit_button>
<iframe id=newwin height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<div id=div_bg class=BG_HIDDEN_DIV><img id=bg src='/image/small_bg.jpg' width=100% style="position:absolute; z-index:-1">
<div align=center>
<TABLE cellspacing=0 style='table-style:fixed;padding:10px;margin:20px' id=istable>
       <TR><TD colspan=2 style='padding-top:50px;padding-bottom:20px'>
	<TABLE cellspacing=0 class=INFO_TD id=ifmsg>
<tr><td class=INFO_MSG><img src='/image/Status_information_icon.png'>
<TD class=INFO_MSG1 id=infomsg><script>Capture(wl.guestlogininfo);</script>
</TD></TR>
</TABLE>
       </TD></TR>
       <TR><TD colspan=2 style='font-size:20px; font-weight:bold; padding-bottom:15px'>
	   <script>Capture(wl.logininfo);</script>
       </TD></TR>
       <TR><TD style='font-size:12px; font-weight:bold; padding-bottom:10px; apadding-left:20px'>
	   <script>CaptureC(share.macaddr);</script></TD><TD id=td_mac><% nvram_get("http_client_mac"); %>
       </TD></TR>
       <TR><TD style='font-size:12px; font-weight:bold; padding-bottom:10px; apadding-left:20px'>
	   <script>CaptureC(share.ipaddr);</script></TD><TD id=td_ip><% nvram_get("http_client_ip"); %>
       </TD></TR>
       <TR><TD style='font-size:12px; font-weight:bold; padding-bottom:10px; apadding-left:20px'>
	   <script>CaptureC(wl.timeleft);</script></TD><TD id=td_time><% guest_info("time"); %></TD></TR>
       <TR><TD colspan=2 style='font-size:11px;font-weight:bold;padding-bottom:10px;'>
	<script>
	document.write("<input type=button id=g1 class=BT onclick=to_logout(this.form) onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\" value=");
	Capture(wl.logout);
	document.write(">");
	</script>
       </TD></TR>
       <TR><TD style='font-size:10px;vertical-align:bottom;padding-bottom:10px;'>
       <script>
		document.write("<% client_gnet_get("gn_copyright_title"); %>");
       </script>
       </TD><TD style='vertical-align:bottom;padding-bottom:10px' align=right><img src='image/cisco_logo_about.png'></TD></TR>
</TABLE>
<script>
chg_win();
function chg_win()
{
	document.body.style.overflow="hidden";
	document.getElementById("div_bg").style.height= document.body.clientHeight+"px";
	document.getElementById("div_bg").style.width= document.body.clientWidth+"px";
	document.body.style.overflow="auto";
}
</script>
<!-- Alert message -->
<div id=div_alert class=ALERT_FORM style="display:none;">
<TABLE width=100% height=100% id=ALERT_TB>
<TR align=center valign=center><TD>
<TABLE style="border:1px solid #000000;background-color:#ffffff" width=400px cellspacing=0>
<TR bgcolor=#adc7e7>
<TD colspan=2 style=padding:5px><font style="cursor:default"><SPAN id=alert_title></SPAN></font></TD>
<TD width=16px style=padding:5px height=16px><img src=/image/AlertCritical16Wht.gif align=right valign=top></TD></TR>
<TR bgcolor=#ffffff><TD style=padding:15px width=32 valign=top>
<script>
var src_icon = "Status_criticalerror_icon.gif";
document.write("<img src=/image/"+src_icon+" id=alert_logo>");
</script>
</TD>
<TD style="padding-top:15px;padding-bottom:20px; padding-right:20px" align=left valign=top>
<font style="cursor:default;color:#000000"><SPAN id=alert_content></SPAN></font>
</TD><TD></TD></TR>
<TR bgcolor=#ffffff><TD colspan=3 align=center style=padding-bottom:15px nowrap>
<SPAN id=alert_bt></SPAN>
</TD></TR>
</TABLE>
</div>
</TD></TR></TABLE>

</div>
</FORM>
</body>
</html>
