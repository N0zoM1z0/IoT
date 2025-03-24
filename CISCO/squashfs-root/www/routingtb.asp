<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist=new Array();
<% get_ipv6_routing(); %>
function init(){
        document.getElementById("ipv4_route_table").style.display="";
	if ( "<% nvram_get("lan_ip_mode"); %>" == "1" ) 
		document.getElementById("ipv6_option").style.display="none";
	document.getElementById("ipv6_route_table").style.display="";
	 
}

function ipv4_ViewFilter(){
        SHOW_HIDDEN_TABLE("ipv4_table_title","ipv4_route_table","ipv4_tb_img",__T(router.showipv4tb),__T(router.hideipv4tb));
}

function ipv6_ViewFilter(){
        SHOW_HIDDEN_TABLE("ipv6_table_title","ipv6_route_table","ipv6_tb_img",__T(router.showipv6tb),__T(router.hideipv6tb));
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=static_route>
<input type=hidden name=inter_route>
<input type=hidden name=dr_setting>
<input type=hidden name=dr_lan_tx>
<input type=hidden name=dr_wan_tx>
<input type=hidden name=dr_lan_rx>
<input type=hidden name=dr_wan_rx>
<input type=hidden name=del_static_route>
<input type=hidden name="route_ipaddr" value="4">
<input type=hidden name="route_netmask" value="4">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.routingtb),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 ");
		draw_object(O_GUI,TABLE_BT,"ipv4_tb_img","ipv4_ViewFilter()","ipv4_table_title",__T(router.hideipv4tb));
		</script>
		</td></tr>					
		<INPUT type=hidden value=0 name=login_status>
		<TR id=ipv4_route_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table style=table-layout:fixed cellspacing=0>
		<col width=20%><col width=15%><col width=15%><col width=10%>
		<TR><TD colspan=5 class=TABLETITLE><script>Capture(router.routinglist);</script></TD></TR>
		<script>
			var table = new Array(
			<% dump_route_table(""); %>
			);
                        document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(ipv6.destlanip));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(wan.mask));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(wan.gw));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.iface));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
                        document.write("</TR>");
			var i=0;
			var count=0;
			var wan_link = "<% misc_get("wan_link"); %>";
			var portlist = new Array();
			<% get_port_st("portlist"); %>
			var iface="";
			var wwan_status = "<% nvram_get("wwan_in_used"); %>"; 
			for(;;){
				iface="";
				if(!table[i]) break;
				if ( (( portlist[4] == __T(router.down)) || (wan_link == "0")) && table[i+3] == "WAN" ) 
				{
					if ((wwan_status != "1") && (wan_link == "0"))
					{
						i+=4;
						continue;
					}
				}
				if ( count%2 ==0 ) tstyle = "TABLECONTENT_D";
				else tstyle = "TABLECONTENT_S";
				document.write("<TR class="+tstyle+">");
				document.write("<TD class=TABLECONTENT_TD>"+table[i]+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>"+table[i+1]+"</TD>");
				document.write("<TD class=TABLECONTENT_TD>"+table[i+2]+"</TD>");
				if ( table[i+3] == "LAN" ) iface = __T(lan.lan);
				else if ( table[i+3] == "WAN" ) iface = __T(wan.wan);
				document.write("<TD class=TABLECONTENT_TD_MID>"+iface+"</TD>");
				document.write("<TD></TD>");
				document.write("</TR>");
				i+=4;	
				count++;
			}
			chg_layout();
			
		</script>
		</TABLE>
		</TR>
		<!--TR><TD colspan=2 class=SPACE_DOWN>&nbsp;</TD></TR-->
		<TR id=ipv6_option><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 ");
		draw_object(O_GUI,TABLE_BT,"ipv6_tb_img","ipv6_ViewFilter()","ipv6_table_title",__T(router.hideipv6tb));
		</script>
		</td></tr>					
		<TR id=ipv6_route_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table style=table-layout:fixed cellspacing=0>
		<col width=30%><col width=25%><col width=15%>
		<TR><TD colspan=4 class=TABLETITLE><script>Capture(router.routinglist);</script></TD></TR>
		<script>
                        document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(ipv6.dest));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(ipv6.nexthop));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.iface));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
                        document.write("</TR>");
				for(var i=0; i<datalist.length; i++)
				{
					var iface = "";
					if ( datalist[i][2] == "br0" ) iface = __T(lan.lan);
					else if ( datalist[i][2] == "vlan2" ) iface = __T(wan.wan);
					else if ( datalist[i][2] == "eth1" ) iface = __T(wan.wan);
					else if ( datalist[i][2] == "lo" ) iface = __T(ipv6.lo);
					else if ( datalist[i][2] == "sit1" ) iface = __T(ipv6.sit1);
					if ( iface != "" ) 
					{
						if ( i%2 ==0 ) tstyle = "TABLECONTENT_D";
        		                        else tstyle = "TABLECONTENT_S";
						document.write("<TR class="+tstyle+">");
						document.write("<TD class=TABLECONTENT_TD>"+datalist[i][0]+"</TD>");
						document.write("<TD class=TABLECONTENT_TD>"+datalist[i][1]+"</TD>");
						document.write("<TD class=TABLECONTENT_TD_MID>"+iface+"</TD>");
						document.write("<TD></TD>");
						document.write("</TR>");
					}
				}
			
		</script>
		</TABLE>
		</TR>
		<TR><TD colspan=2 class=SPACE_DOWN>&nbsp;</TD></TR>	
        </TABLE>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
