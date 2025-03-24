<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var wl_radio = "<% nvram_get("wl_radio"); %>";
var lang = "<% nvram_get("language"); %>";
var wl_st = new Array();
<% iface_status_table("wireless"); %>

var maclist = new Array();
<% WDS_translate(); %>


<% wl_multi_nvram_get("wl_bss_enabled"); %>
var delay_time=0;
function reload(){
	goto_page("status_wireless.asp");
}

function init(){
	var errflg = 1;
	var F = document.frmwlst;
	parent.document.getElementById("save_bg").style.display="none";
	if ( http_power == "r" ) return;
	DISABLE_PART(F,"wl_statistics_start","wl_statistics_end",1);
	if( wl_radio != "1")
		return;
	for(var i=0;i<4;i++)
	{
		if(eval("nv_wl_bss_enabled_"+i) == "1")
		{	
			DISABLE_PART(F,"wl_statistics_start","wl_statistics_end",0);
			errflg = 0;
			break;
		}
	}
	if(errflg == 1) return;

	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
	if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
}

function uiDoSave(F){
	F.submit_button.value="status_wireless";
	F.gui_action.value = "Apply";
        if ( F.chkunit.checked ) 
                F.show_unit.value = 1;
        else
                F.show_unit.value = 0;
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_clear(F){
        F.submit_button.value="status_wireless";
        F.submit_type.value="clear_count";
	F.change_action.value="gozila_cgi";
        F.submit();         
	parent.document.getElementById("save_bg").style.display="";

}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmwlst method=<% get_http_method(); %> action=apply.cgi style=margin:0px>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=show_unit>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.T1));</script></TR>
  <TR><TD colspan=2>
		<input type=hidden name=wl_statistics_start>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
		<script>
		var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
    var _val = new Array("0","15","30","60");
		draw_object(O_GUI,SELBOX,"fresh_rate","",_name,_val,"<% nvram_get("fresh_rate_wl"); %>");
		</script>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.showunit));</script>
		<script>
		var selflg = "";
		var nv_unit = "<% nvram_get("wl_show_unit"); %>";
		if ( nv_unit == "1" ) selflg = "checked";
		document.write("<input type=checkbox id=chkunit name=chkunit "+selflg+">");
		</script>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table width=100% cellspacing=0 cellpadding=0>
		<col width=16%><col width=8%><col width=8%><col width=8%><col width=8%>
		<col width=8%><col width=8%><col width=8%><col width=8%><col width=10%><col width=10%>
		<TR><TD colspan=11 class=TABLETITLE><script>Capture(wl.T1);</script></TR>
		<TR height=20px>
		<TD rowspan=2 valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(wl.ssidname);</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.packets)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.bytes)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.errors)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.dropped)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.multicast)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2"><script>Capture(share.collisions)</script></TD>
		</TR>
		<TR>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		</TR>
		<script>
			<% wl_multi_nvram_get("wl_ssid"); %>
			var datalist = new Array(nv_wl_ssid_0,nv_wl_ssid_1,nv_wl_ssid_2,nv_wl_ssid_3,__T(mang.total));
			var f_cnt=0;
			var tmp = "";
			var tmptotal=0
			var nv_unit = "<% nvram_get("wl_show_unit"); %>";
			for(var i=0; i<datalist.length; i++)
			{
				var tstyle;
				if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
				else tstyle = "TABLECONTENT_D";
				document.write("<TR class="+tstyle+" id='d"+i+"'>");
				document.write("<TD class=TABLECONTENT_TD>"+datalist[i]+"</TD>");
				if((i < datalist.length-1) && eval("nv_wl_bss_enabled_"+i) != "1")
					wl_st[i] = new Array('eth1',0,0,0,0,0,0,0,0,0,0);
				else if ( wl_radio == "0" )
					wl_st[i] = new Array('eth1',0,0,0,0,0,0,0,0,0,0);
				
				if ( i == 4 )
				{
					if ( typeof wl_st[0] != "undefined" ) 
					{
						for(var k=1; k<wl_st[0].length; k++)
						{
							tmp = "";
							tmptotal = 0;
							for(var j=0; j<4; j++)
							{
								tmptotal += parseInt(wl_st[j][k],10);
							}
							if ( nv_unit == "1" )
							{
								if ( k==3 || k==4 )
								tmp = transferunit(tmptotal,"byte");
								else
								tmp = transferunit(tmptotal);
							}
							else
								tmp = formatNumByComma(tmptotal);
							document.write("<TD class=TABLECONTENT_TD_VM>"+tmp+"</TD>");
						}
					}
				}
				else
				{
					if ( typeof wl_st[i] != "undefined" ) 
					{
						for(var j=1; j<wl_st[i].length; j++)
						{
							tmp = "";
							if ( nv_unit == "1" )
							{
								if ( j==3 || j==4 )
									tmp = transferunit(wl_st[i][j],"byte");
								else
									tmp = transferunit(wl_st[i][j]);
							}
							else
								tmp = formatNumByComma(wl_st[i][j]);
							document.write("<TD class=TABLECONTENT_TD_VM>"+tmp+"</TD>");
						}
					}
				}
				document.write("</TR>");
				f_cnt++;
			}
			document.write("<tr><td colspan=11 class=TABLECONTENT_CMD_TAIL>");
			draw_object(O_GUI,BT,__T(share.clearcount),"t1","BT_L","to_clear(this.form)");
			if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
				document.write("</td></tr>");
		</script>
		</TABLE>
		</TR>

		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=WDSstatus width=100% cellspacing=0 cellpadding=0>
		<script>
/*
		switch(maclist[0])
*/
		switch(maclist[0][0])
		{
			case '1':
				document.write("<TR class=TABLECONTENT_S><TD colspan=11 class=TABLETITLE>"+__T(wl.wdsmodedisable)+"</TR>");
				break;
			case '2':
				document.write("<TR class=TABLECONTENT_S><TD colspan=11 class=TABLETITLE>"+__T(wl.wdsmodebridge)+"</TR>");
				break;
			case '3':
				document.write("<TR class=TABLECONTENT_S><TD colspan=11 class=TABLETITLE>"+__T(wl.wdsmoderepeater)+"</TR>");
				break;
			case '4':
				document.write("<TR class=TABLECONTENT_S><TD colspan=11 class=TABLETITLE>"+__T(wl.wdsmodeself)+"</TR>");
				break;
			case '0':
			default:
				document.write("<TR class=TABLECONTENT_S><TD colspan=11 class=TABLETITLE>"+__T(wl.wdsmodedisable)+"</TR>");
				break;
		}
		</script>

		<TR height=20px>
		<TD valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(wl.wdsName);</script></TD>
		<TD valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(wl.wdsMac);</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2"><script>Capture(wl.wdsStatus);</script></TD>
		</TR>

<script>
/*
		switch(maclist[0])
		{
			case '2':
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+" 1"+"</TD><TD valign=center align=center>"+maclist[1]+"</TD><TD valign=center align=center>"+maclist[2]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_D><TD valign=center align=center>"+__T(wl.wdsMac)+" 2"+"</TD><TD valign=center align=center>"+maclist[3]+"</TD><TD valign=center align=center>"+maclist[4]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+" 3"+"</TD><TD valign=center align=center>"+maclist[5]+"</TD><TD valign=center align=center>"+maclist[6]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_D><TD valign=center align=center>"+__T(wl.wdsMac)+" 4"+"</TD><TD valign=center align=center>"+maclist[7]+"</TD><TD valign=center align=center>"+maclist[8]+"</TD></TR>");
				break;
			case '3':
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+" 1"+"</TD><TD valign=center align=center>"+maclist[1]+"</TD><TD valign=center align=center>"+maclist[2]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_D><TD valign=center align=center>"+__T(wl.wdsMac)+" 2"+"</TD><TD valign=center align=center>"+maclist[3]+"</TD><TD valign=center align=center>"+maclist[4]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+" 3"+"</TD><TD valign=center align=center>"+maclist[5]+"</TD><TD valign=center align=center>"+maclist[6]+"</TD></TR>");
				document.write("<TR height=20px class=TABLECONTENT_D><TD valign=center align=center>"+__T(wl.wdsMac)+" 4"+"</TD><TD valign=center align=center>"+maclist[7]+"</TD><TD valign=center align=center>"+maclist[8]+"</TD></TR>");
				break;
			case '4':
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+"</TD><TD valign=center align=center>"+maclist[1]+"</TD><TD valign=center align=center>"+maclist[2]+"</TD></TR>");
				break;
			case '0':
			case '1':
			default:
				break;
		}
*/
		var len = 1;
		while(len<=maclist.length-1)
//		for(len=1;len<10;len++)
		{
//alert("maclist["+len+"][0]="+maclist[len][0]);
			if(len%2)
				document.write("<TR height=20px class=TABLECONTENT_S><TD valign=center align=center>"+__T(wl.wdsMac)+" "+(len)+"</TD><TD valign=center align=center>"+maclist[len][0]+"</TD><TD valign=center align=center>"+maclist[len][1]+"</TD></TR>");
			else
				document.write("<TR height=20px class=TABLECONTENT_D><TD valign=center align=center>"+__T(wl.wdsMac)+" "+(len)+"</TD><TD valign=center align=center>"+maclist[len][0]+"</TD><TD valign=center align=center>"+maclist[len][1]+"</TD></TR>");
			len++;
		}
</script>

		</TABLE>
		</TR>

	</TABLE>

		<% web_include_file("BT.asp"); %>
		<input type=hidden name=wl_statistics_end>
	</TABLE>
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
