<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var lang = "<% nvram_get("language"); %>";
var wl_st = new Array();
<% iface_port_status_table("wide"); %>
//wl_st[2]=new Array("EMILY test",11111111111,1111111111,11111111111,1111111111,1111111111,11111111111,1111111111,11111111111,1111111111,1111111111);
var delay_time=0;

function reload(){
	goto_page("status_wide.asp");
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmwlst;
	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
}

function uiDoSave(F){
	F.submit_button.value="status_wide";
	if ( F.chkunit.checked ) 
		F.show_unit.value = 1;
	else
		F.show_unit.value = 0;
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_clear(F){
	F.submit_button.value="status_wide";
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
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.wiredst));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
		<script>
			var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
			var _val = new Array("0","15","30","60");
			draw_object(O_GUI,SELBOX,"fresh_rate","",_name,_val,"<% nvram_get("fresh_rate_wide"); %>");</script>
				
		</script>	
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.showunit));</script>
		<script>
		var selflg = "";
		var nv_unit = "<% nvram_get("wide_show_unit"); %>";
		if ( nv_unit == "1" ) selflg = "checked";
		document.write("<input type=checkbox id=chkunit name=chkunit "+selflg+" >");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table cellspacing=0 cellpadding=0 width=100%>
		<col width=10%><col width=8%><col width=8%><col width=8%><col width=8%>
		<col width=8%><col width=8%><col width=8%><col width=8%><col width=10%><col width=10%>
		<TR><TD colspan=12 class=TABLETITLE><script>Capture(wan.wiredst);</script></TR>	
		<TR height=20px>
		<TD rowspan=2 valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.iface);</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.packets)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.bytes)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.errors)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.dropped)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.multicast)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.collisions)</script></TD>
		<TD rowspan=2 style="border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2">&nbsp;</TD>
		</TR><TR>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.rec)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.sent)</script></TD>
		</TR>
		<script>

			var f_cnt=0;
			for(var i=0; i<wl_st.length; i++)
			{
if((ap_mode=="0") || ((ap_mode == "1") && (wl_st[i][0] == "wan")))
{
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                        	document.write("<TR class="+tstyle+" id='d"+i+"'>");
				if ( wl_st[i][0] == "eth1" )
					document.write("<TD class=TABLECONTENT_TD>"+__T(wwan.waneth)+"</TD>");
				<% support_invmatch("WWAN_SUPPORT","1","/*"); %>
				else if ( wl_st[i][0] == "wwan" )
					document.write("<TD class=TABLECONTENT_TD>"+__T(wwan.wan3g)+"</TD>");
				else if ( wl_st[i][0] == "wwan_eth" )
					document.write("<TD class=TABLECONTENT_TD>"+__T(wwan.waneth3g)+"</TD>");
				<% support_invmatch("WWAN_SUPPORT","1","*/"); %>
				else
					document.write("<TD class=TABLECONTENT_TD>"+wl_st[i][0].toUpperCase()+"</TD>");
				for(var j=1; j<wl_st[i].length; j++){
					document.write("<TD class=TABLECONTENT_TD_VM>");
					var len = parseInt(wl_st[i][j],10);
					var data = "";
					var nv_unit = "<% nvram_get("wide_show_unit"); %>";
					transferunit(wl_st[i][j]);
					if ( nv_unit == "1" ) 
					{
						if ( j==3 || j==4 )
							data = transferunit(wl_st[i][j],"byte");
						else
							data = transferunit(wl_st[i][j]);
					}
					else
						data = formatNumByComma(wl_st[i][j]);
					document.write(data);
					document.write("</TD>");
				}
				document.write("<TD></TD>");
				document.write("</TR>");
				f_cnt++;
}
			}
			document.write("<tr><td colspan=12 class=TABLECONTENT_CMD_TAIL>");
			draw_object(O_GUI,BT,__T(share.clearcount),"t1","BT_L","to_clear(this.form)");
			if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
                        document.write("</td></tr>"); 
		</script>
		
		</TABLE>
		</TR>
	</TABLE>
		<% web_include_file("BT.asp"); %>
	</TABLE>
		
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
