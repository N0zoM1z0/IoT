<html>
<head>
<title>VPN Status</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function AAA(name,ip,mac,type,is_static,dev)
{
        this.name = name;
        this.ip = ip;
        this.mac = mac;
        this.type = type;
        this.is_static = is_static;
        this.dev = dev;
}

var guestlist = new Array();
<% guest_info("all"); %>

var datalist = new Array();
<% get_lan_host_data(); %>

function count_time(obj_time,now_time)
{
	var time = new Date();
	
	return parseInt(obj_time,10) - parseInt(now_time,10);
}
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	setTimeout('show_leasetime()', 1000); //Every Minutes
}

var keepflg=0;
function show_leasetime()
{
	keepflg=0;
	for(var i=0; i<guestlist.length; i++)
	{
		if ( parseInt(guestlist[i][2],10) <= 0 || guestlist[i][2]== "" ) continue;
        	if ( parseInt(guestlist[i][2],10) <= parseInt(guestlist[i][3],10) ) 
		{
			choose_disable(document.getElementById("d"+i));
			continue;
		}
		guestlist[i][3] = parseInt(parseInt(guestlist[i][3],10)+1,10);
	        var cnttime = count_time(guestlist[i][2],guestlist[i][3]);
	        var tmphr, tmpmin, tmpsec, tmpmin2;
	        time = parseInt(parseInt(cnttime,10)/3600,10);
        	if ( time < 10 ) tmphr = "0"+time;
	        else tmphr = time;
        	tmpmin2 = parseInt(parseInt(cnttime,10)%3600,10);
	        time = parseInt(tmpmin2/60,10);
        	if ( time < 10 ) tmpmin = "0"+time;
	        else tmpmin = time;
        	time = parseInt(tmpmin2%60,10);
	        if ( time < 10 ) tmpsec = "0"+time;
        	else tmpsec = time;
	        document.getElementById("td_time"+i).innerHTML = tmphr+":"+tmpmin+":"+tmpsec;
        	if ( parseInt(guestlist[i][2],10) > parseInt(guestlist[i][3],10) ) keepflg=1;
	}
        setTimeout('show_leasetime()', 1000); //Every Minutes
}

function disable_rule(idx)
{
	var F = document.gnetst;
	F.cip.value = guestlist[idx][0];
	F.cmac.value = guestlist[idx][1];
	F.submit_button.value = "status_guestnet.asp";
	F.submit();
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=gnetst method=<% get_http_method(); %> action=guest_logout.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=cip>
<input type=hidden name=cmac>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.gnetst));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=200px><col width=150px><col width=150px><col width=100px><col width=150px>
		<TR><TD colspan=6 class=TABLETITLE><script>Capture(wl.gnetst);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(wan.hostname));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(router.ipaddr));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.macaddr));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(wl.timeleft));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(filter.action));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			var hostname="";
			var tstyle = "TABLECONTENT_S";
			if ( guestlist.length == 0 ) 
                        {
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
                                document.write("<TD class='TABLECONTENT_TD' colspan=5>"+__T(msg.nodata)+"</TD>");
                        }

			for(var i=0; i<guestlist.length; i++)
			{
				hostname = "";
                        	if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
	                        else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
				for(var j=0; j<datalist.length; j++)
				{
					if ( datalist[j].ip == guestlist[i][0] && 
					     datalist[j].mac == guestlist[i][1] )
					{
						hostname = datalist[j].name;
						break;
					}
				}
                                document.write("<TD class='TABLECONTENT_TD'>"+hostname+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>"+guestlist[i][0]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>"+guestlist[i][1]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID' id=td_time"+i+"></TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID'>"+draw_object(O_VAR,BT,__T(share.disconnect),"d"+i,"BT","disable_rule("+i+")")+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>&nbsp;</TD>");
                                document.write("</tr>");
			}
			// For firefox layout
			chg_layout();
		</script>
		
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
