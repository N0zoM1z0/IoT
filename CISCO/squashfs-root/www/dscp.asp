<html>
<head>
<title>Basic Setting</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var HIDE_COUNT=0;
var factory_bt="true";
var dscp_list = new Array();
dscp_list[0]=new Array("BE("+__T(def.words)+")","0","7");
dscp_list[1]=new Array("CS1","8","9");
dscp_list[2]=new Array("AF11","10","11");
dscp_list[3]=new Array("AF12","12","13");
dscp_list[4]=new Array("AF13","14","15");
dscp_list[5]=new Array("CS2","16","17");
dscp_list[6]=new Array("AF21","18","19");
dscp_list[7]=new Array("AF22","20","21");
dscp_list[8]=new Array("AF23","22","23");
dscp_list[9]=new Array("CS3","24","25");
dscp_list[10]=new Array("AF31","26","27");
dscp_list[11]=new Array("AF32","28","29");
dscp_list[12]=new Array("AF33","30","31");
dscp_list[13]=new Array("CS4","32","33");
dscp_list[14]=new Array("AF41","34","35");
dscp_list[15]=new Array("AF42","36","37");
dscp_list[16]=new Array("AF43","38","39");
dscp_list[17]=new Array("CS5","40","45");
dscp_list[18]=new Array("EF","46","47");
dscp_list[19]=new Array("CS6","48","55");
dscp_list[20]=new Array("CS7","56","63");
function ten2two(val,exp)
{
	var tmp = parseInt(val,10);
	var _re_val = "";
	var len=1;
	while(Math.floor(tmp/2)>0)
	{
		_re_val = tmp%2 + _re_val; 
		tmp = Math.floor(tmp/2);
		if ( tmp < 2 ) 
		{
			_re_val = tmp + _re_val;
			break;
		}
			
	}
	if ( val < 2 ) 	_re_val = val; 
	while( typeof(_re_val.length) == "undefined"?1:_re_val.length < exp )
		_re_val = "0"+_re_val; 	
	return _re_val;
}

function to_show(flg)
{
	if ( HIDE_COUNT == 0 ) return;
	for(var i=0; i<HIDE_COUNT; i++)
	{
		if ( flg == 0 ) 
		document.getElementById("no_name"+i).style.display = "none";
		else
		document.getElementById("no_name"+i).style.display = "";
	}
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	to_show(0);
	default_nv = keep_val(document.frm_dscp,"");
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("dscp.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	F.qos_dscp_data.value = "";
	for(var i=0; i<Math.pow(2,6); i++)
		F.qos_dscp_data.value += eval("F.sel_pri_"+i).value;
	F.submit_button.value = "dscp";
	F.submit_type.value="save_data";
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
	F.submit_button.value = "dscp";
	F.submit_type.value="restore_data";
	F.change_action.value="gozila_cgi";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
	
}
</script>
</head>
<body onLoad="init()">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_dscp" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=qos_dscp_data>
<input type=hidden name=filename value="qos_dscp_data">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.dscpset));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.dscpqueue),"colspan=3");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspn=3");
		document.write(spell_words(qos_dscp_rule,"<A class=content_link href=javascript:get_position('qos_port.asp')>"));
		</script>
		</td></tr>		
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspn=3");</script>
		<input type=radio name=showall value=0 checked onclick=to_show(0)><script>Capture(filter.dscpcollapse);</script><BR>
		<input type=radio name=showall value=1 onclick=to_show(1)><script>Capture(filter.dscpexpand);</script>
		</TD></TR>
		<TR>
		<TD colspan=2 style=padding-left:10px width=60%>
		<TABLE class=TABLELIST id=table cellspacing=0 width=100%>
                <!--col width=30px><col width=50px><col width=30px><col width=30px-->
                <TR><TD colspan=4 class=TABLETITLE id=dscp_table><script>Capture(filter.dscpsettb);</script></TD></TR>
                <script>
			var tstyle;
                        document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(filter.dscp));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.binary));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.decimal));
                        draw_td(O_GUI,TABLETD_TAIL_C,"",__T(filter.queue));
                        document.write("</TR>");	
			var _binary;
			var j=0,i=0,k=0;
			var next=0;
			var qos_dscp_data = "<% nvram_get("qos_dscp_data"); %>";
			for(i=0; i<Math.pow(2,6); i++)
			{
                                tstyle = "TABLECONTENT_D";
				if ( i == next && dscp_list[k][0].substring(0,2)=="CS" ) tstyle = "TABLECONTENT_S_1";
				next = dscp_list[k][1];
				if ( i == next ) 
				{
                       			document.write("<TR class="+tstyle+">");
					document.write("<td class=TABLECONTENT_TD>"+dscp_list[k][0]+"</td>");
					if ( (k+1) < dscp_list.length ) k++;
				}
				else
				{
                       			document.write("<TR class="+tstyle+" id=no_name"+j+">");
					document.write("<td class=TABLECONTENT_TD></td>");
					j++;
				}
				_binary = ten2two(i,6);
				document.write("<td class=TABLECONTENT_TD_VM>"+_binary+"</td>");
				document.write("<td class=TABLECONTENT_TD_VM>"+i+"</td>");
				document.write("<td class=TABLECONTENT_TD_MID>");
				//var _name = new Array("ISRANGE","1","4","1");
				var _name = new Array("1","2","3");
				var _val = new Array("1","3","4");
				draw_object(O_GUI,SELBOX,"sel_pri_"+i,"",_name,_val,qos_dscp_data.substring(i,i+1));
				document.write("</TD></TR>");
			}
			HIDE_COUNT=j;
		</script>
		</TABLE>	
		</TD>
		<TD valign=top style="padding-top:10px;padding-left:10px">&nbsp;</TD>
		<!--input type=radio name=showall value=0 checked onclick=to_show(0)><script>Capture(filter.dscpcollapse);</script><BR>
		<input type=radio name=showall value=1 onclick=to_show(1)><script>Capture(filter.dscpexpand);</script>
		</TD-->
		</TR>
	        </TABLE>
  </TD></TR>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
