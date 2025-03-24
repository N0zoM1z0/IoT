<% web_include_file("filelink.asp"); %>
<HTML><HEAD><TITLE>GET WSC STATUS</TITLE>
</HEAD>
<script language=javascript>
var delay_time = 2500;
var width=0;
var wpsresult = "<% nvram_get("wps_result"); %>";

/*
1: Successful Connected
2: Fail Connect
3.Search
4.Connecting
*/
function progress(){
	if ( wpsresult == "0" ) 
	{
		top.document.getElementById("wps_bg").style.display="none";
		return;
	}
        var per;
       	if ( wpsresult != 0 )  
		top.document.getElementById("wps_bg").style.display="";
        if ( wpsresult == "3" )
	{
		var barwidth = "<% nvram_get("wps_barwidth"); %>";
		if ( barwidth == "" || barwidth=="NaN" ) barwidth = "0";
                width=parseInt(barwidth);
		top.document.getElementById("statusbar").style.display="";
	}
        else if ( wpsresult == "4" ) 
	{
	//	top.document.getElementById("wps_msg").innerHTML = "Connecting your client device to your network";
		var steps = "<% nvram_get("wps_steps"); %>";
		if ( steps == "" ) steps = "1";
                width=parseInt((parseInt(steps,10)+1)*30);
		top.document.getElementById("statusbar").style.display="";
	}
        
	if( wpsresult == "2")
        {
		top.document.getElementById("statusbar").style.display="none";
		top.document.getElementById("wps_msg").innerHTML = "<TABLE width=100%><TR><TD><img src=image/Status_ciriticalerror_icon.png></TD><TD>"+__T(msg.connfail)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.wpsfail)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.wpsfail2)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.pressok)+"</TD></TR><TR align=center><TD colspan=2 align=center style=padding-top:10px>";
		top.document.getElementById("wps_msg").innerHTML += draw_object(O_VAR,BT,__T(share.sok),"c1","BT","to_ok()");
		top.document.getElementById("wps_msg").innerHTML += "</TD></TR></TABLE>";
        }else if ( wpsresult == "1" ){
		top.document.getElementById("statusbar").style.display="none";
		top.document.getElementById("wps_msg").innerHTML = "<TABLE width=100%><TR><TD><img src=image/Status_success_icon.png></TD><TD>"+__T(msg.congs)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.wpspass)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.wpsfail2)+"</TD></TR><TR><TD></TD><TD>"+__T(msg.pressok)+"</TD></TR><TR align=center><TD colspan=2 align=center style=padding-top:10px>";
		top.document.getElementById("wps_msg").innerHTML += draw_object(O_VAR,BT,__T(share.sok),"c1","BT","to_ok()");
		top.document.getElementById("wps_msg").innerHTML += "</TD></TR></TABLE>";
	}
	else
	{
		if(width >= 300) width = 299;
        	top.document.getElementById("left").style.width=width;
	        top.document.getElementById("right").style.width=300-width;
		var tmp = (width*100)/300;
	        per = parseInt(tmp);
        	//document.getElementById("percent").innerHTML= "&nbsp;&nbsp;" + per + "%";
	        top.document.getElementById("percent").innerHTML= per + "%";

        	if(per >= 50 )delay_time = 3500;

	        if (per == 98)
                	width = 294;
        	else
	        {
        	        if(wpsresult == "3")
                	        width = parseInt(width) + 12;
	        }	
        	if(wpsresult == "4")
                	iTimerID = window.setTimeout(wn_reload,500);
		else
        	        iTimerID = window.setTimeout(wn_reload,delay_time);
	}
}

function wn_reload()
{
		document.form1.wps_barwidth.value = width ; 
		document.form1.submit_button.value="wps_search_device";
		document.form1.submit_type.value="wps_search";
		document.form1.change_action.value = "gozila_cgi";
		document.form1.next_page.value="getstatus.asp";
		document.form1.action = parent.document.getElementById("get_session_key").value;
		document.form1.submit();
	
}
</script>
<BODY onload="progress()">
<FORM name=form1 method="<% get_http_method(); %>" action=apply.cgi >
<input type=hidden name=submit_button value="wps_search_device">
<input type=hidden name=submit_type >
<input type=hidden name=change_action >
<input type=hidden name=next_page >
<input type=hidden name=wps_barwidth>
<TABLE cellspacing=0>
<!--TR><TD class=wpsfont style='padding-top:20px'>
                <TABLE>
                    <TR>
                        <TD id=left class=PROC_STATUS></TD>
                        <TD id=right class=PROC_STATUS1></TD>
                        <TD id=percent></TD>
                    </TR>
                </TABLE>
</TD></TR-->
</TABLE>
</FORM>
</BODY>
</HTML>
