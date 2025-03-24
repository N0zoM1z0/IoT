<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var factory_bt="true";
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frm_cos,"");
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("cos.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F){
	for(var i=0; i<8; i++)
		F.qos_cos_data.value += eval("F.sel_pri_"+i).value;
	F.submit_button.value="cos";
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
	F.submit_button.value = "cos";
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
<body onload=init()>
<FORM autocomplete=off id=frm name=frm_cos method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=qos_cos_data>
<input type=hidden name=filename value="qos_cos_data">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.cosset));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.cosqueue));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<script>
		Capture(spell_words(qos_cos_rule,"<A class=content_link href=javascript:get_position('qos_port.asp')>"));
		</script>
		</TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table style=table-layout:fixed cellspacing=0 width=100%>
		<col width=20%><col width=30%>
		<TR><TD colspan=3 class=TABLETITLE id=vlan_table><script>Capture(filter.cossettb);</script></TD></TR>
		<script>
                        var tstyle;
                        document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST_R,__T(filter.cospriority));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(filter.trafficqueue));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
                        document.write("</TR>");
			var qos_cos_data = "<% nvram_get("qos_cos_data"); %>";
			for(var i=7; i>=0; i--)
			{
				if ( i%2 ==0 ) tstyle = "TABLECONTENT_D";
                                else tstyle = "TABLECONTENT_S";
				document.write("<TR align=center class="+tstyle+">");
				document.write("<td class=TABLECONTENT_TD_VM>"+i+"</td>");
				document.write("<td class=TABLECONTENT_TD_MID>");
				//var _name = new Array("1 ("+__T(filter.lowest)+")","2","3","4 ("+__T(filter.highest)+")");
				//var _val = new Array("1","2","3","4");
				var _name = new Array("1 ("+__T(filter.lowest)+")","2","3 ("+__T(filter.highest)+")");
				var _val = new Array("1","3","4");
                                draw_object(O_GUI,SELBOX,"sel_pri_"+i,"",_name,_val,qos_cos_data.substring(i,i+1));	
				document.write("</td>");
				document.write("<td class=TABLECONTENT_TD></td>");
				document.write("</TR>");
			}
		</script>
		</TABLE>	
		</TR>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
