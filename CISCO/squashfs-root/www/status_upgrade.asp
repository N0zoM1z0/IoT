<html>
<head>
<% js_link(); %>
<SCRIPT language=JavaScript>
var timerID;
var temp;
var url_flag=0,status=0;
var special_case=1;
temp = new Image(1, 1);
var submit_button = "<% nvram_get("submit_button"); %>";
var prefix_ip = "<% get_http_prefix(""); %>";
function show_continue_bt()
{
	top.location.href = prefix_ip+"default.asp;session_id=<% nvram_get("session_key"); %>";
	//parent.document.getElementById("reboot_msg").innerHTML = parent.document.getElementById("get_prefix_url").value;
	//parent.document.getElementById("hidden_bg_bt").style.display="";
	//parent.document.getElementById("hidden_bg_bar").style.display="none";
}
function init()
{
	if ( typeof show_bt != "undefined" && show_bt == 1 ) 
	{
		if ( typeof action_reboot != "undefined" && action_reboot == 1 ) 
		{
			parent.document.getElementById("reboot_msg").innerHTML = parent.document.getElementById("status_reboot_msg").value;
			//if ( submit_button == "upgrade" ) 
		//		setTimeout('show_continue_bt()', 110000);
			//else
				setTimeout('show_continue_bt()', 90000);
		}else{
			regetstatus();
			//show_continue_bt();
		}	
	}else{
		if ( submit_button == "vlan_membership" ) 
		{
			setTimeout('regetstatus()',30000);
		}
		else if ( submit_button == "firewall" ) 
		{
			document.getElementById("frm").style.display="none";
			setTimeout('regetstatus()',5000);
		}
		else
			setTimeout('regetstatus()',5000);
			//setTimeout('regetstatus()',20000);
	}
}

function regetstatus()
{
	var close_session = '<% get_session_status(); %>';
	if ( close_session == "1" ) 
		frames['iframe1'].location.href = prefix_ip+"getconnst.asp" ; //always refresh iframe code
	else{
		frames['iframe1'].location.href = prefix_ip+"getconnst.asp;session_id=<% nvram_get("session_key"); %>"; //always refresh iframe code
		
	}	
	setTimeout('regetstatus()', 5000);		
}

function Capture(msg)
{
	document.write(msg);
}

</SCRIPT>
</head>
<body onload=init() style="position:absolute;z-index:0;top:0px;left:0px;width:100%;height:100%;padding:0px;margin:0px;overflow:hidden;background-color:#407BB3;">
<FORM autocomplete=off id=frm name=frm>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<div id=hidden_bg style="position:relative;z-index:0;left:0px;top:0px;width:100%;height:100%">
<img id=bg width=100% style="position:absolute;z-index:-1" src='image/small_bg.jpg'>
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
        <TABLE bgcolor=#A2B9C9>
        <TR><TD style="padding-top:18px;" align=center><TABLE align=center><TR><TD id=logo style='background-repeat:no-repeat;width:67px;height:40px'><img id=img_logo src=image/Cisco_Logo_RGB_67x40-black.png></TD></TR></TABLE></TD></TR>
        <TR><TD style="padding-top:18px;font-size:12px;font-family:Arial;" align=center id=msg><script>Capture(msg.rebootingdev);</script></TD></TR>
        <TR><TD style="padding-left:10px; padding-top:8px; padding-right:10px; padding-bottom:10px">
                <TABLE border=0 style="width:260px; height:18px" cellspacing=0>
                <TR><TD style="width:100%;" id=process>
                <img id=img_process src='image/ProgressBar_indeterminate.gif'>
		</TD></TR>
                <TD></TR>
                </TABLE>
        </TD></TR>
        </TABLE>
</TD>
</TR>
<!--/div-->
</form>
</body></HTML>
