<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
factory_bt="true";
single_tb="true";
var qos_perport_prio = "<% nvram_get("qos_perport_prio"); %>";
var type_name = new Array(__T(share.port),__T(filter.dscp),__T(filter.cos));
var type_val = new Array("0","1","2");
var port_name = new Array("1 ("+__T(filter.lowest)+")","2","3 ("+__T(filter.highest)+")");
var port_val = new Array("1","3","4");
function change_data_type(type,idx)
{
	var data="";
        if ( type == "0" )
        {
                //var _name = new Array("1 ("+__T(filter.lowest)+")","2","3","4 ("+__T(filter.highest)+")");
                //var _val = new Array("1","2","3","4");
                document.getElementById("data_type"+idx).innerHTML = draw_object(O_VAR,SELBOX,"sel_pri_"+idx,"",port_name,port_val);
        }else{
		var _name=new Array("0");
                document.getElementById("data_type"+idx).innerHTML = draw_object(O_VAR,SELBOX,"sel_pri_"+idx,"disabled",_name,_name);       
	}
	//else if ( type == "cos" ){
        //        var _name = new Array("ISRANGE","0","7","1");
        //        document.getElementById("data_type"+idx).innerHTML = draw_object(O_VAR,SELBOX,"sel_pri_"+idx,"",_name,_name);        }
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	if ( qos_perport_prio == "" ) return;
	var data = qos_perport_prio.split(";");
	var tmp = "";
	var F = document.frmport;
	for(var i=0; i<data.length; i++)
	{
		tmp = data[i].split(",");
		eval("F.sel_mode"+tmp[0]).selectedIndex = tmp[1];
		if ( tmp[1] != "0" ) 
			change_data_type(tmp[1],tmp[0]);
		else{
			for(var j=0; j<port_val.length; j++)
			{
				if ( tmp[2] == port_val[j] ) 
				{
					eval("F.sel_pri_"+tmp[0]).selectedIndex = j;
					break;
				}
			}
		}
	}
	default_nv = keep_val(F,"");
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("qos_port.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}


function uiDoSave(F)
{
	var tmp = "",subtmp="";
	for(var i=1; i<5; i++)
	{
		if ( tmp != "" ) tmp += ";";
		subtmp = "";
		subtmp += i+","+eval("F.sel_mode"+i).selectedIndex+","+eval("F.sel_pri_"+i).value;
		tmp += subtmp;
	}
	F.qos_perport_prio.value = tmp;
//	alert(tmp);
	F.submit_button.value = "qos_port";
	F.gui_action.value = "Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
	
}

function to_restore(F)
{
        F.submit_button.value = "qos_port";
        F.submit_type.value="restore_data";
        F.change_action.value="gozila_cgi";
        F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
        parent.document.getElementById("save_bg").style.display="";

}

function uiDoCancel(F)
{
	document.location.reload();
}

</script>

<body onload="init();">
<FORM autocomplete=off id="frm" name=frmport method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=qos_perport_prio>
<input type=hidden name=filename value="qos_perport_prio">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.qosportset));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=50px><col width=100px><col width=250px>
		<TR><TD colspan=4 class=TABLETITLE><script>Capture(filter.qosportsettb);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST_R,__T(filter.lanport));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(filter.trustmode));

                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(filter.deftrafficqueue));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			for(var i=1; i<5; i++)
			{
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
				
                                document.write("<TD class='TABLECONTENT_TD_VM'>"+i+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID'>");
				
				draw_object(O_GUI,SELBOX,"sel_mode"+i,"onChange=change_data_type(this.selectedIndex,"+i+")",type_name,type_val);
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID' id=data_type"+i+">");
				change_data_type("0",i);
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'></TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			document.write("<tr><td colspan=7 class=TABLECONTENT_CMD_TAIL><TABLE>");
			</script>
			<% web_include_file("BT.asp"); %>
			<script>
			document.write("</TABLE></TD></TR>");
		</script>
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
