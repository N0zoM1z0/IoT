<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var datalist = new Array();
<% bonjour_vlan_list("datalist"); %>

function chk_en(){
	var F = document.frm_bonjour;
	if ( F.en_bon.checked == false ) gray_en(true);
	else gray_en(false);
}

function init(){
	chk_en();
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frm_bonjour,"");
	if (ap_mode == "1")
		document.getElementById("table").style.display="none";	
}

function gray_en(enflg)
{
	for(var i=0; i<datalist.length; i++)
	{
		document.getElementById("chk"+i).disabled = enflg;	
		document.getElementById("id"+i).disabled = enflg;	
		document.getElementById("name"+i).disabled = enflg;	
	}

}
function uiDoSave(F)
{
	if(F.en_bon.checked) F.bonjour_enable.value = "on";
	else F.bonjour_enable.value = "off";

	if (ap_mode == "0")
	{
		for(var i=0;i < datalist.length; i++)
		{
			if( eval("F.chk"+i).checked)
			{
				bonjour_disable = 0;
				if(F.bonjour_vlan.value == "")
					F.bonjour_vlan.value += datalist[i][0];
				else
					F.bonjour_vlan.value += " "+datalist[i][0];
			}
		}
	}

	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=frm_bonjour method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button value="bonjour">
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=bonjour_enable value="">
<input type=hidden name=bonjour_vlan value="">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(bonjour.title));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(bonjour.title));</script>
		<input type=checkbox onclick=chk_en() name=en_bon <% nvram_match("bonjour_enable", "on", "checked");%>> 
		<script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE class=TABLELIST id=table style=table-layout:auto cellspacing=0 width=100%>
		<col width=80px><col width=100px><col width=120>
		<TR><TD colspan=4 class=TABLETITLE id=_table><script>Capture(bonjour.desc);</script></TD></TR>
		<script>
                        var tstyle;
			var chkflg="";
                        document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST_R,__T(lan.vlanid));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(bonjour.vlanname));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(bonjour.enable));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
                        document.write("</TR>");
			var TdSLen = 0;
			var WidthS="";
			for(var i=0; i<datalist.length; i++)
			{
				var dataL = datalist[i][1];
				var TdLen = dataL.length*10;
				if(TdLen > TdSLen) TdSLen = TdLen;
				if(i+1>= datalist.length) 
					WidthS="width="+TdSLen; 
				if ( i%2 ==0 ) tstyle = "TABLECONTENT_D";
                                else tstyle = "TABLECONTENT_S";
				document.write("<TR align=center class="+tstyle+">");
				document.write("<td class=TABLECONTENT_TD_VM id=id"+i+">"+datalist[i][0]+"</td>");
				if ( i == 0 ) 
					document.write("<td class=TABLECONTENT_TD id=name"+i+" "+WidthS+">"+__T(def.words)+"</td>");
				else
					document.write("<td class=TABLECONTENT_TD id=name"+i+" "+WidthS+">"+cy_speccode_decode(datalist[i][1])+"</td>");
				document.write("<td class=TABLECONTENT_TD_MID>");
				chkflg="";
				if ( datalist[i][2] == "1" ) chkflg = "checked";
				document.write("<input type=checkbox "+chkflg+" id=chk"+i+" name=chk"+i+"></td>");
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
