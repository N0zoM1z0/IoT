<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var ipv4_list = new Array();
<% get_ipv4_active_svr(); %>
var ipv6_list = new Array();
<% get_ipv6_active_svr(); %>

function init(){
        document.getElementById("ipv4_active_table").style.display="none";
	document.getElementById("ipv6_active_table").style.display="none";
	if ( "<% nvram_get("lan_ip_mode"); %>" == "1" ) 
		document.getElementById("ipv6_option").style.display="none";
	else
		ipv6_ViewFilter();
	ipv4_ViewFilter();
	 
}

function ipv4_ViewFilter(){
        SHOW_HIDDEN_TABLE("ipv4_table_title","ipv4_active_table","ipv4_tb_img",__T(router.showipv4active),__T(router.hideipv4active));
}

function ipv6_ViewFilter(){
        SHOW_HIDDEN_TABLE("ipv6_table_title","ipv6_active_table","ipv6_tb_img",__T(router.showipv6active),__T(router.hideipv6active));
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.activeservice),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 ");
		draw_object(O_GUI,TABLE_BT,"ipv4_tb_img","ipv4_ViewFilter()","ipv4_table_title",__T(router.showipv4active));
		</script>
		</td></tr>					
		<INPUT type=hidden value=0 name=login_status>
		<TR id=ipv4_active_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table style=table-layout:fixed cellspacing=0>
		<col width=20%><col width=8%><col width=18%><col width=12%><col width=18%><col width=12%><col width=12%>
		<TR><TD colspan=7 class=TABLETITLE><script>Capture(router.activeservicelist);</script></TD></TR>
		<script>
          document.write("<TR>");
          draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(share.servicename));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.stype));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.localipaddress));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.localport));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.remipaddress));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.remport));
          draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.sts));
          document.write("</TR>");
				for(var i=0; i<ipv4_list.length; i++)
				{
					if ( i%2 ==0 ) tstyle = "TABLECONTENT_D";
        	else tstyle = "TABLECONTENT_S";
					document.write("<TR class="+tstyle+">");
					document.write("<TD class=TABLECONTENT_TD_MID>"+ipv4_list[i][0]+"</TD>");
					document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][1]+"</TD>");
          document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][2]+"</TD>");
					document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][3]+"</TD>");
          document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][4]+"</TD>");
					document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][5]+"</TD>");
          document.write("<TD class=TABLECONTENT_TD>"+ipv4_list[i][6]+"</TD>");
					document.write("</TR>");
				}
			chg_layout();
			
		</script>
		</TABLE>
		</TR>

		<TR id=ipv6_option><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 ");
		draw_object(O_GUI,TABLE_BT,"ipv6_tb_img","ipv6_ViewFilter()","ipv6_table_title",__T(router.showipv6active));
		</script>
		</td></tr>

		<TR id=ipv6_active_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var field_width="20,8,30,12,30,12,12";
		draw_td(O_GUI,CREATE_EDIT_TABLE,field_width,__T(router.activeservicelist),__T(share.servicename)+","+__T(share.stype)+","+__T(share.localipaddress)+","+__T(share.localport)+","+__T(share.remipaddress)+","+__T(share.remport)+","+__T(share.sts)+"","","","","","0,0,0,0,0,0,0,0,0");

		var tmp = new Array();
		for(var i=0; i<ipv6_list.length; i++)
		{
			tmp[0] = new Array("",ipv6_list[i][0],3);
			tmp[1] = new Array("",ipv6_list[i][1],1);
			tmp[2] = new Array("",ipv6_list[i][2],1);
			tmp[3] = new Array("",ipv6_list[i][3],1);
			tmp[4] = new Array("",ipv6_list[i][4],1);
			tmp[5] = new Array("",ipv6_list[i][5],1);
			tmp[6] = new Array("",ipv6_list[i][6],1);
			add_row(i,tmp,"","show",2);
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
