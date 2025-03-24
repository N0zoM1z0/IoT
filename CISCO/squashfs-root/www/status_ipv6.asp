<html>
<head>
<title>IPv6 Static Routing</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
var nv_ipv6_6to4_mode="<% nvram_get("ipv6_6to4_mode"); %>";
var lanipmode="<% nvram_get("lan_ip_mode");%>";
var wanipmode="<% nvram_get("wan_ip_mode"); %>";
if( ((lanipmode =="2")|| (lanipmode == "3")) && (wanipmode=="1") ){
	if( nv_ipv6_6to4_mode == "6to4") {
		//datalist[0]=new Array("<% nvram_get("6to4_ifname"); %>","<% get_ipv6_info("6to4"); %>");
		datalist[0]=new Array("6to4","<% get_ipv6_info("6to4"); %>");
	
	}
	else if( nv_ipv6_6to4_mode == "isatap") {
		datalist[0]=new Array("ISATAP","<% get_ipv6_info("isatap"); %>");
	}
	else{
		
		datalist[0]=new Array("6RD","<% get_ipv6_info("6rd"); %>");
	}
}
else if( (lanipmode == "1") && (wanipmode == "2") ) 
{
	datalist[0]=new Array("4to6","<% get_ipv6_info("4to6"); %>");
}	

function init()
{
}

function split_ipv6_addr(addr,cnt,delim)
{
	if ( addr == "" ) return "";
	var arr = addr.split(delim);
	var new_list="";
	var tmpidx=0;
	for(var i=0; i<arr.length; i++)
	{
		if ( tmpidx == cnt ) 
		{
			new_list+="<BR>";
			tmpidx=0;
		}
		if ( tmpidx > 0 ) new_list += ",";
		new_list += full_ipv6(arr[i]);
		tmpidx++;
	}
	return new_list;
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmst_v6" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=stflg value=add> 
<input type=hidden name=selidx> 
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.tunnelst));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP width=100% cellspacing=0>
		<col width=100px><col width=400px>
		<TR><TD colspan=3 class=TABLETITLE><script>Capture(ipv6.tunnelsttb);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(ipv6.tunnelname));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.ipv6addr));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			for(var i=0; i<datalist.length; i++)
			{
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
	                        document.write("<TD class='TABLECONTENT_TD'>"+datalist[i][0]+"</TD>");
	                        document.write("<TD class='TABLECONTENT_TD'>"+split_ipv6_addr(datalist[i][1],1,",")+"</TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			if ( datalist.length == 0 ) 
			{
                                document.write("<tr class=TABLECONTENT_S id='no_data'>");
                                document.write("<TD colspan=3 class='TABLECONTENT_TD'>"+__T(msg.nodata)+"</TD>");
				document.write("</TR>");
			}
			document.write("<tr><td colspan=3 class=TABLECONTENT_CMD_TAIL>");
                        document.write("<input type=button class=BT value="+__T(share.refresh)+" id=t2 onMouseover=bt('t2','move') onMouseout=bt('t2','out') onMousedown=bt('t2','down') onclick='javascript:goto_page(\"status_ipv6.asp\")'>");
                        document.write("</td></tr>"); 
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
