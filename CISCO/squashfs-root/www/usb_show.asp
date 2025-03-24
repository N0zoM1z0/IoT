<% no_cahce(); %>
<% js_link(); %>
<LINK href="style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="position.js"></script>
<script type="text/javascript" src="common.js"></script>
<script>
var datalist = new Array();
<% get_usb_content_table(); %>
function init(){
	if(parent.document.getElementById("guipage").value == "upgrade")
	{
		var F = parent.document.frmupgrade;
		F.usbfname.value="";
	}
	else if(parent.document.getElementById("guipage").value == "backup")
	{
		var F = parent.document.frmbackup;
		F.usbfname.value="";
	}
}
function to_chk(idx)
{
	if(parent.document.getElementById("guipage").value == "upgrade")
	{
		var F = parent.document.frmupgrade;

<% support_invmatch("BSD_SUPPORT","1","/*");%>
		if((F._upgrade_from[2].checked == true))
<% support_invmatch("BSD_SUPPORT","1","*/");%>
<% support_match("BSD_SUPPORT","1","/*");%>
		if((F._upgrade_from[1].checked == true))
<% support_match("BSD_SUPPORT","1","*/");%>
		{
			F.usbfname.value=datalist[idx];
			choose_enable(F.t1);
			choose_enable(F.chk_restore);
		}
		else 
		{
			choose_disable(F.chk_restore);
			choose_disable(F.t1);
		}
		if ( http_power == "r" ) choose_disable(F.t1);
	}
	else if(parent.document.getElementById("guipage").value == "backup")
	{
		var F = parent.document.frmbackup;
		if((F._upgrade_from[1].checked == true))
		{
			F.usbfname.value=datalist[idx];
			choose_enable(F.t4);
		}
		else 
		{
			choose_disable(F.t4);
		}
		if ( http_power == "r" ) choose_disable(F.t4);
	}

}

function to_refresh(F){
	document.location.reload();
}
</script>
<body onload="init();">
<FORM name=frmusbcontent id=frm action=apply.cgi>
<TABLE class=CONTENT_TABLE>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=3%><col width=93%>
		<TR><TD colspan=3 class=TABLETITLE><script>Capture("USB Content Table");</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,"&nbsp;");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T("Name"));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");

			if(datalist.length != 0)
			{
				document.write("<TR height=20px><td colspan=3>");
				document.write("<div style='overflow:auto;height:60px;position:relative'>");
				document.write("<TABLE class=aCONTENT_GROUP cellspacing=0 width=100%>");
				document.write("<col width=3%><col width=95%>");
				var f_cnt=0;
				for(var i=0; i<datalist.length; i++)
				{
					var tstyle;
					if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
					else tstyle = "TABLECONTENT_D";
					document.write("<tr class="+tstyle+" id='d"+i+"'>");
					document.write("<TD class='TABLECONTENT_TD_MID' abgcolor=red>");
					document.write("<input type=radio name=usb_radio value="+f_cnt+" onClick=to_chk('"+f_cnt+"')></TD>");
					document.write("<TD class='TABLECONTENT_TD' abgcolor=blue>"+datalist[i]+"</TD>");
					document.write("<TD class='TABLECONTENT_TD'></TD>");
					document.write("</tr>");
					f_cnt++;
				}
				document.write("</TABLE></div></TD></TR>");
			}
			document.write("<tr><td colspan=3 class=TABLECONTENT_CMD_TAIL>");
			draw_object(O_GUI,BT,__T(share.refresh),"usbt3","BT","to_refresh(this.form)");
			document.write("</td></tr>");	
		</script>
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
