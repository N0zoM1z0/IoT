<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var delay_time=0;
var data = new Array();
//data[0] = new Array('ips1','192.168.88.79','192.168.1.1/255.255.255.0','192.168.15.1/255.255.255.0','28097','85628','0','0','0','0','1');
<% get_site2site_status(); %>
function reload(){
	goto_page("status_sitetosite.asp");
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmwlst;
	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
}

function uiDoSave(F){
	F.submit_button.value="status_sitetosite";
	if ( F.chkunit.checked ) 
		F.show_unit.value = 1;
	else
		F.show_unit.value = 0;
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_clear(F){
	F.submit_button.value="status_sitetosite";
	F.submit_type.value="clear_count";
	F.change_action.value="gozila_cgi";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	
}

function to_conn(index,F)
{
	F.submit_button.value="status_sitetosite";
	F.data_index.value = index;
	F.submit_type.value="connect";
	F.change_action.value="gozila_cgi";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";

}

function to_disconn(index,F)
{
	F.submit_button.value="status_sitetosite";
	F.data_index.value = index;
	F.submit_type.value="disconnect";
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
<input type=hidden name=data_index>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.sitetositevpn));</script></TR>
  <TR><TD colspan=2>
		<input type=hidden name=wl_statistics_start>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
		<script>
		var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
                var _val = new Array("0","15","30","60");
		draw_object(O_GUI,SELBOX,"fresh_rate","",_name,_val,"<% nvram_get("fresh_rate_vpn"); %>");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.showunit));</script>
		<script>
		var selflg = "";
		var nv_unit = "<% nvram_get("vpn_show_unit"); %>";
		if ( nv_unit == "1" ) selflg = "checked";
		document.write("<input type=checkbox id=chkunit name=chkunit "+selflg+">");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=tb width=100% cellspacing=0 cellpadding=0>
		<col width=10%><col width=10%><col width=7%><col width=7%><col width=7%>
		<col width=7%><col width=7%><col width=7%><col width=7%><col width=10%><col width=10%><col width=10%>
		<TR><TD colspan=12 class=TABLETITLE><script>Capture(vpn.vpnst);</script></TR>	
		<TR height=20px>
		<TD rowspan=2 valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(filter.sname);</script></TD>
		<TD rowspan=2 valign=center align=center style="border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(ipv6.tunnel64_remote_ep);</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.subnet)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(vpn.satimeout)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(router.rx)</script></TD>
		<TD colspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(router.tx)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-right:1px solid #8499A2;border-bottom:1px solid #8499A2"><script>Capture(share.sts)</script></TD>
		<TD rowspan=2 valign=center align=center style="border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2"><script>Capture(filter.action)</script></TD>
		</TR><TR>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(vpn.local)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(vpn.remote)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(vpn.ikeonly)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(vpn.ipseconly)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.packets)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.bytes)</script></TD>
		<TD valign=center align=center style="border-bottom:1px solid #8499A2;border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-top:1px solid #FFFFFF"><script>Capture(share.packets)</script></TD><TD valign=center align=center style="border-right:1px solid #8499A2;border-left:1px solid #FFFFFF;border-bottom:1px solid #8499A2;border-top:1px solid #FFFFFF"><script>Capture(share.bytes)</script></TD>
		</TR>
		<script>
			document.write("<TR>");
			var f_cnt=0
			if ( data.length == 0 ) 
			{
                        	document.write("<tr class=TABLECONTENT_D id='d0'>");
	                        document.write("<TD class='TABLECONTENT_TD' colspan=12>"+__T(msg.nodata)+"</TD>");
			}
			for(var i=0; i<data.length; i++)
			{
				var tstyle, conn_flg=1;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<TR class="+tstyle+" id='d"+i+"'>");
				for(var j=0; j<data[i].length; j++)
				{
					if ( j>=4 && j!=data[i].length-1 ) 
					{
						document.write("<TD class=TABLECONTENT_TD_VM>");
						if ( nv_unit == "1" && j>=6 ) 
							document.write(transferunit(data[i][j]));
						else
							document.write(data[i][j]);
						document.write("</TD>");
					}else{
						if ( j==data[i].length-1 )
						{
							document.write("<TD class=TABLECONTENT_TD_MID>");
							if ( data[i][j] == "0" ) 
							{
								Capture(share.disconnected);
								conn_flg=0;
							}
							else  
								Capture(share.connected);
						}else{
							document.write("<TD class=TABLECONTENT_TD>");
							document.write(data[i][j]);
						}
						document.write("</TD>");
					}
				}
				document.write("<TD class=TABLECONTENT_TD_MID>");
				if ( conn_flg == 0 ) 
					draw_object(O_GUI,BT,__T(share.connect),"n1"+i,"BT","to_conn("+i+",this.form)");
				else if ( conn_flg == 1 ) 
					draw_object(O_GUI,BT,__T(share.disconnect),"n2"+i,"BT","to_disconn("+i+",this.form)");
				else
					document.write("-");	
				document.write("</TD>");
				document.write("</TR>");
				f_cnt++;
			}
			//document.write("<tr><td colspan=12 class=TABLECONTENT_CMD_TAIL>");
			//draw_object(O_GUI,BT,__T(share.clearcount),"t1","BT_L","to_clear(this.form)");
			//if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
		
                        document.write("</td></tr>"); 
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
