<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var wl_radio = "<% nvram_get("wl_radio"); %>";
var lang = "<% nvram_get("language"); %>";
var ipsec_st = new Array();
<% get_ipsec_status(); %> 
if ( "<% nvram_gozila_get("backname"); %>" != "" ) 
{
        var back_bt="true";
        define_backname = "<% nvram_gozila_get("backname"); %>";
}
var status_name= new Array(__T(vpn.ipsecsanoest),__T(vpn.ipsecsaest));
var ipsec_entry = parseInt("<%nvram_get("ipsec_entry"); %>",10);
var delay_time=0;
function reload(){
	goto_page("status_ipsec.asp");
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "<% nvram_gozila_get("backname"); %>";
	uiDoCancel(F,"back");

}

function init(){
	//var errflg = 1;
	var F = document.vpnipsec;
	parent.document.getElementById("save_bg").style.display="none";

	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);

	if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
}

function DoConnect(i,idx, conn)
{
	var F = document.vpnipsec;

	if ( idx <= 0 ) return;
	F.ipsec_selidx.value = idx+":"+conn;
	F.submit_button.value="status_ipsec";
	F.submit_type.value="reconn";
	F.change_action.value="gozila_cgi";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function uiDoSave(F){
	F.submit_button.value="status_ipsec";
	F.gui_action.value = "Apply";
        if ( F.chkunit.checked ) 
                F.show_unit.value = 1;
        else
                F.show_unit.value = 0;
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=vpnipsec method=<% get_http_method(); %> action=apply.cgi style=margin:0px>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ipsec_selidx> 
<input type=hidden name=show_unit>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.ipsecst));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>

                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
                <script>
                var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
                var _val = new Array("0","15","30","60");
                draw_object(O_GUI,SELBOX,"fresh_rate","",_name,_val,"<% nvram_get("fresh_rate_ipsec"); %>");
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.showunit));</script>
                <script>
                var selflg = "";
                var nv_unit = "<% nvram_get("ipsec_show_unit"); %>";
                if ( nv_unit == "1" ) selflg = "checked";
                document.write("<input type=checkbox id=chkunit name=chkunit "+selflg+">");
                </script>
                </TD>

		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table width=100% cellspacing=0 cellpadding=0>
		<col width=10%><col width=10%><col width=10%><col width=8%><col width=8%>
		<col width=7%><col width=7%><col width=7%><col width=7%><col width=7%><!--col width=14%--><!--col width=12%-->
		<TR><TD colspan=12 class=TABLETITLE><script>Capture(vpn.stitle);</script></TR>	
		<TR height=20px>
		<TD rowspan=2 class=TABLECONTENT_TD style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.sfieldname);</script></TD>
		<TD rowspan=2 class=TABLECONTENT_TD style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.local);</script></TD>
		<TD rowspan=2 class=TABLECONTENT_TD style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.remote);</script></TD>
		<TD rowspan=2 class=TABLECONTENT_TD style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.stime);</script></TD>
		<TD rowspan=2 class=TABLECONTENT_TD style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.etime);</script></TD>
		<TD rowspan=2 valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.duration);</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.packets)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.bytes)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(router.state)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.sfieldaction)</script></TD>
		<!--TD rowspan=2 style="border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2">&nbsp;</TD-->
		</TR><TR>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(vpn.sfieldrx)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(vpn.sfieldtx)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(vpn.sfieldrx)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(vpn.sfieldtx)</script></TD>

		</TR>
		<script>
			var f_cnt=0;
			var disflg = "";
			var tstyle = "TABLECONTENT_D";

			if ( ipsec_st.length == 0 ) 
			{
                        	document.write("<tr class="+tstyle+" id='d"+i+"'>");
	                        document.write("<TD class='TABLECONTENT_TD' colspan=12>"+__T(msg.nodata)+"</TD>");
			}

			for(var i=0; i<ipsec_st.length; i++)
			{
				if(ipsec_st[i][13] == 0)
					continue;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<TR class="+tstyle+" id='d"+i+"'>");
				document.write("<TD class=TABLECONTENT_TD>"+cy_speccode_decode(ipsec_st[i][1])+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>"+ipsec_st[i][2]+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>"+ipsec_st[i][3]+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>"+ipsec_st[i][4]+"</TD>");
				if(ipsec_st[i][5] == "0")
					document.write("<TD class=TABLECONTENT_TD></TD>");
				else
					document.write("<TD class=TABLECONTENT_TD>"+ipsec_st[i][5]+"</TD>");
				
				document.write("<TD class=TABLECONTENT_TD_VM>"+ipsec_st[i][6]+"</TD>");
				
				for(var j=7; j<(ipsec_st[i].length-3); j++){
				{
					var len = parseInt(ipsec_st[i][j],10);
					var data = "";
					var nv_unit = "<% nvram_get("ipsec_show_unit"); %>";

					document.write("<TD class=TABLECONTENT_TD_VM>");
					transferunit(ipsec_st[i][j]);

					if ( nv_unit == "1" ) 
					{
						if ( j==7 || j==8 )
							data = transferunit(ipsec_st[i][j],"byte");
						else
							data = transferunit(ipsec_st[i][j]);
					}
					else
						data = formatNumByComma(ipsec_st[i][j]);
						document.write(data);
						document.write("</TD>");
					}
				}
				document.write("<TD class=TABLECONTENT_TD>"+status_name[ipsec_st[i][j]]+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>");

				disflg = "";	
				if(parseInt(ipsec_st[i][j+1],10) == 2) 
					disflg = "disabled";

				if ( http_power == "r" ) disflg = "disabled";
				if(parseInt(ipsec_st[i][j+2],10) == 0) 
					disflg = "disabled";
				
				if(parseInt(ipsec_st[i][j],10) == 1)
				{
                       	        	document.write("<input type=button class=BT onclick=\"DoConnect("+i+","+ipsec_st[i][0]+",'0')\" value="+__T(share.disconnect)+" "+disflg+" id=t"+i+" onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\">");
				}
				else //if(parseInt(ipsec_st[i][j],10) == 1)
				{
               	                	document.write("<input type=button class=BT onclick=\"DoConnect("+i+","+ipsec_st[i][0]+",'1')\" value="+__T(share.connect)+" "+disflg+" id=t"+i+" onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\">");
				}
				document.write("</TD>");
				document.write("<TD></TD>");
				document.write("</TR>");
				f_cnt++;
			}
			if (( f_cnt == 0 ) && ipsec_st.length > 0)
			{
                	       	document.write("<tr class="+tstyle+" id='d"+i+"'>");
		                document.write("<TD class='TABLECONTENT_TD' colspan=9>"+__T(msg.nodata)+"</TD>");
			}

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
