<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var mirror_port = "<% nvram_get("mirror_port"); %>";
	if ( mirror_port == "") mirror_port = "1";
	var F = document.frmport;
	eval("F.m"+mirror_port).checked = false;
	choose_disable(eval("F.m"+mirror_port));
	default_nv = keep_val(document.frmport,"");

}

function chg_port()
{
	var F = document.frmport;
	for(var i=1; i<5; i++)
	{
		if ( i == F.mirror_port[F.mirror_port.selectedIndex].value ) 
		{
			choose_disable(eval("F.m"+i));
			eval("F.m"+i).checked = false;
		}else
			choose_enable(eval("F.m"+i));
		
	}
}

function uiDoSave(F){
	F.mirror_source.value = "";
	for(var i=0; i<5; i++)
	{
		if ( eval("F.m"+i).checked == true ) 
		{
			if ( F.mirror_source.value != "" ) F.mirror_source.value += " ";
			F.mirror_source.value += i;
		}
	}
	F.submit_button.value="port_mirror";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmport method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=mirror_source>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.portmirror));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=100px><col width=100px>
		<TR><TD colspan=3 class=TABLETITLE><script>Capture(mang.mirrorconfig);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST_R,__T(share.port));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(mang.mirrorsource));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			var datalist = new Array("0 ("+__T(mang.wanport)+")","1","2","3","4",__T(mang.mirrorport));
			var mirror_source = "<% nvram_get("mirror_source"); %>";
			var tmp = "";
			if ( mirror_source != "" ) 
				tmp = mirror_source.split(" ");
			
			for(var i=0; i<datalist.length; i++)
			{
				var chkflg="";
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
				
                                document.write("<TD class='TABLECONTENT_TD_VM'>"+datalist[i]+"</TD>");
				
				if ( i == datalist.length-1 ) 
				{
        	                	document.write("<TD class='TABLECONTENT_TD_MID' style=padding-bottom:10px>");
					var _name = new Array("ISRANGE","1","4","1");
					draw_object(O_GUI,SELBOX,"mirror_port","onchange=chg_port()",_name,_name,"<% nvram_get("mirror_port"); %>");
				}else
				{
        	                	document.write("<TD class='TABLECONTENT_TD_MID'>");
					for(var j=0; j<tmp.length; j++)
					{
						if ( i == tmp[j] ) 
						{
							chkflg="checked";
							break;
						}
					}
					document.write("<input type=checkbox name=m"+i+" "+chkflg+">");
				}
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'></TD>");
                                document.write("</tr>");
				f_cnt++;
			}
		</script>
			
		</TABLE>
		
      </TD>
  </TR>
			<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
