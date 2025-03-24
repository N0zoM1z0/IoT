<html>
<head>
<title>Port Range Triggering</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
single_tb="true";
var iface_name = new Array(__T(mang.bboth),__T(wwan.ethernet),__T(wwan.i3g));
var iface_val = new Array("both","eth","3g")
var wanport = "<% nvram_get("http_wanport"); %>";
var port_trigger = new Array();
<% port_trigger_table(); %>
function init(){
        parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frmtrigger,"");
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("triggering.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
        if ( !before_check(F) ) return false;
        F.port_trigger.value = TRIGGER_ENTRY;
        F.submit_button.value = "triggering";
        F.gui_action.value="Apply";
        F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
        parent.document.getElementById("save_bg").style.display="";
}

function chkname(i)
{
        var F = document.frmtrigger;
	clear_table_msg("","img_name"+i,"name"+i,i);
	var returnmsg = valid_meaning_id_name(ID_NAME,eval("F.name"+i).value,0,"name"+i);
        if ( returnmsg != "" ) 
        {
        	table_msg("img_name"+i,"name"+i,"div_name"+i,i,returnmsg);
		return false;
        }	
	return true;
}

function before_check(F)
{
	var errflg=0;
	for(var i=0; i<TRIGGER_ENTRY; i++)
	{
		if ( eval("F.i_from"+i).value != "" && !chk_valid_port("i_from","i",i,0) ) errflg=1;
		if ( eval("F.i_to"+i).value != "" && !chk_valid_port("i_to","i",i,0) ) errflg=1;
		if ( eval("F.o_from"+i).value != "" && !chk_valid_port("o_from","o",i,0) ) errflg=1;
		if ( eval("F.o_to"+i).value != "" && !chk_valid_port("o_to","o",i,0) ) errflg=1;
		if (  eval("F.i_from"+i).value != "" && eval("F.i_to"+i).value != "" ) 
		{
			if ( parseInt(eval("F.i_from"+i).value,10) > parseInt(eval("F.i_to"+i).value,10) )
			{
				table_msg("img_i"+i,"i_to"+i,"div_i"+i,i,__T(msg.errstartend));
				errflg=1;
				continue;
			}
		}
		if ( eval("F.o_from"+i).value != "" && eval("F.o_to"+i).value != "" ) 
		{
			if ( parseInt(eval("F.o_from"+i).value,10) > parseInt(eval("F.o_to"+i).value,10) )
			{
				table_msg("img_o"+i,"o_to"+i,"div_o"+i,i,__T(msg.errstartend));
				errflg=1;
				continue;
			}
		}
                if ( eval("F.enable"+i).checked == false ) continue;
		if ( !chkname(i) ) errflg = 1;
		if ( !chk_valid_port("i_from","i",i,0) ) errflg=1;
		if ( !chk_valid_port("i_to","i",i,0) ) errflg=1;
		if ( !chk_valid_port("o_from","o",i,0) ) errflg=1;
		if ( !chk_valid_port("o_to","o",i,0) ) errflg=1;
		if ( errflg == 1 ) continue;	
		if ( eval("F.iface"+i).value != "udp" && "<% nvram_get("remote_management"); %>" == "1" )
		{
			if ( chk_range("", wanport, eval("F.o_from"+i+".value"),  eval("F.o_to"+i+".value"), "nochg") ) 
			{
				table_msg("img_o"+i,"o_from"+i,"div_o"+i,i,__T(filter.porterr));
                                table_msg("img_o"+i,"o_to"+i,"div_o"+i,i,__T(filter.porterr));
				return false;
			}
			
		}
		for(var j=i+1; j<TRIGGER_ENTRY; j++)
		{
			/*
			clear_table_msg("","img_name"+i,"name"+i,i);
			clear_table_msg("","img_name"+j,"name"+j,i);
			clear_table_msg("","img_i"+i,"i_from"+i,i);
			clear_table_msg("","img_o"+j,"o_from"+j,i);
			clear_table_msg("","img_i"+i,"i_to"+i,i);
			clear_table_msg("","img_o"+j,"o_to"+j,i);*/
                        if ( eval("F.enable"+j).checked == false ) continue;
                        if ( eval("F.name"+i).value != "" && (eval("F.name"+i).value == eval("F.name"+j).value))
                        {
	                         table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.nameexist));
                                 table_msg("img_name"+j,"name"+j,"div_name"+j,j,__T(msg.nameexist));
				 errflg = 1;
                        }
			
			if(((eval("F.i_from"+i+".value") > 0) ||
	                   (eval("F.i_to"+i+".value") > 0)) &&
           		   ((eval("F.i_from"+j+".value") > 0) ||
		           (eval("F.i_to"+j+".value") > 0)))
			{
				if ( eval("F.iface"+i).value != "both" && eval("F.iface"+j).value != "both" &&
				     (eval("F.iface"+i).value != eval("F.iface"+j).value) ) continue;
				if(!check_port(parseInt(eval("F.i_from"+i+".value")),
                                parseInt(eval("F.i_to"+i+".value")),
                                parseInt(eval("F.i_from"+j+".value")),
                                parseInt(eval("F.i_to"+j+".value"))))
                        	{
					table_msg("img_i"+i,"i_from"+i,"div_i"+i,i,__T(msg.portoverlap));
                                        table_msg("img_i"+i,"i_to"+i,"div_i"+i,i,__T(msg.portoverlap));
					table_msg("img_i"+j,"i_from"+j,"div_i"+j,j,__T(msg.portoverlap));
                                        table_msg("img_i"+j,"i_to"+j,"div_i"+j,j,__T(msg.portoverlap));
                                        errflg=1;
                            	}
			}
			if(((eval("F.o_from"+i+".value") > 0) ||
		           (eval("F.o_to"+i+".value") > 0)) &&
                	   ((eval("F.o_from"+j+".value") > 0) ||
		           (eval("F.o_to"+j+".value") > 0)))
                	{
				if ( eval("F.iface"+i).value != "both" && eval("F.iface"+j).value != "both" &&
				     (eval("F.iface"+i).value != eval("F.iface"+j).value) ) continue;
		        	if(!check_port(parseInt(eval("F.o_from"+i+".value")),
                		parseInt(eval("F.o_to"+i+".value")),
                                parseInt(eval("F.o_from"+j+".value")),
                                parseInt(eval("F.o_to"+j+".value"))))
                        	{
					table_msg("img_o"+i,"o_from"+i,"div_o"+i,i,__T(msg.portoverlap));
                                        table_msg("img_o"+i,"o_to"+i,"div_o"+i,i,__T(msg.portoverlap));
					table_msg("img_o"+j,"o_from"+j,"div_o"+j,j,__T(msg.portoverlap));
                                        table_msg("img_o"+j,"o_to"+j,"div_o"+j,j,__T(msg.portoverlap));
                                        errflg=1;
                            	}
			}
		}
		if((eval("F.o_from"+i+".value") + eval("F.o_to"+i+".value") + eval("F.i_from"+i+".value") + eval("F.i_to"+i+".value")) != 0) {  // Some fields are set
			if ( !chk_valid_port("i_from","i",i,0) ) errflg=1;
			if ( !chk_valid_port("i_to","i",i,0) ) errflg=1;
			if ( !chk_valid_port("o_from","o",i,0) ) errflg=1;
			if ( !chk_valid_port("o_to","o",i,0) ) errflg=1;
			if ( eval("F.name"+i).value == "" ) 
			{
                                 table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.notblank));
				 errflg = 1;
			}
		}
	}
	if ( errflg ) return false;
	return true;	
}

function chk_valid_port(obj_name,img_name,index,flg)
{
        var F = document.frmtrigger;
        if ( flg ) 
	{
		clear_table_msg("","img_"+img_name+index,obj_name+index,index);
        	//if ( eval("F.enable"+index).checked == false ) return true;
	}
        if ( !chk_range(obj_name+index,eval("F."+obj_name+index).value,PORT_START,PORT_TO) )
        {
                table_msg("img_"+img_name+index,obj_name+index,"div_"+img_name+index,index,spell_words(range_rule,PORT_START,PORT_TO));
                return false;
        }       
	return true;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtrigger method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=port_trigger>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.portrangetrigger));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP width=100% cellspacing=0>
		<col width=150px><col width=200px><col width=200px>
		<script>if ( support_3g == 1 ) document.write("<col width=70px>");</script>
		<col width=70px>
		<script>
                document.write("<TR><TD colspan=");
                if ( support_3g == 1 ) document.write("6 class=TABLETITLE>");
                else document.write("5 class=TABLETITLE>");
                Capture(filter.portrangetriggertb);</script></TR>
		<script>
			document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(filter.app));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.triggerrange));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.forwardrange));
			if ( support_3g == 1 ) 
                        	draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.iface));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.enable));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			for(var i=0; i<FORWARD_MAX; i++)
			{
				var tstyle;
				var def_name,def_i_from,def_i_to,def_o_from,def_o_to,def_en;
				def_name=def_i_from=def_i_to=def_o_from=def_o_to=def_en="";
				if ( i < port_trigger.length ) 
				{
					def_i_from = port_trigger[i][0];
					def_i_to = port_trigger[i][1];
					def_o_from = port_trigger[i][2];
					def_o_to = port_trigger[i][3];
					def_en = port_trigger[i][4];
					def_name = port_trigger[i][5];
				}
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='tr_table"+i+"'>");
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_name"+i,"<input size=20 maxlength=32 value='"+def_name+"' name=name"+i+" id=name"+i+" onMouseMove=showHint('img_name"+i+"','div_name"+i+"',event) onMouseOut=hideHint('div_name"+i+"') onblur=chkname("+i+")>","div_name"+i);
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD_VM'>");
				draw_td(O_GUI,ICONLINE,"img_i"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_i_from)+"' name=i_from"+i+" id=i_from"+i+" onMouseMove=showHint('img_i"+i+"','div_i"+i+"',event) onMouseOut=hideHint('div_i"+i+"') onBlur=chk_valid_port('i_from','i',"+i+",1)> ~ <input size=5 maxlength=5 value='"+str_replace(" ","",def_i_to)+"' name=i_to"+i+" id=i_to"+i+" onMouseMove=showHint('img_i"+i+"','div_i"+i+"',event) onMouseOut=hideHint('div_i"+i+"') onBlur=chk_valid_port('i_to','i',"+i+",1)>","div_i"+i,"","align=right");	
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD_VM'>");
				draw_td(O_GUI,ICONLINE,"img_o"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_o_from)+"' name=o_from"+i+" id=o_from"+i+" onMouseMove=showHint('img_o"+i+"','div_o"+i+"',event) onMouseOut=hideHint('div_o"+i+"') onBlur=chk_valid_port('o_from','o',"+i+",1)> ~ <input size=5 maxlength=5 value='"+str_replace(" ","",def_o_to)+"' name=o_to"+i+" id=o_to"+i+" onMouseMove=showHint('img_o"+i+"','div_o"+i+"',event) onMouseOut=hideHint('div_o"+i+"') onBlur=chk_valid_port('o_to','o',"+i+",1)>","div_o"+i,"","align=right");	
				document.write("</TD>");
				if ( support_3g == 1 ) 
                                {
					var tmpiface="";
                                        document.write("<TD class='TABLECONTENT_TD'>");
					if ( def_en.indexOf("eth")!=-1)tmpiface="eth";
					else if ( def_en.indexOf("3g")!=-1)tmpiface="3g";
					else tmpiface="both";
                                        draw_object(O_GUI,SELBOX,"iface"+i,"id=iface"+i,iface_name,iface_val,tmpiface);
                                        document.write("</TD>");
                                }
				var tmpchk="";
				if ( def_en.indexOf("on")!=-1 ) tmpchk = "checked";
                                document.write("<TD class='TABLECONTENT_TD_MID'><input type=checkbox name=enable"+i+" id=enable"+i+" "+tmpchk+">");
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD1'></TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			document.write("<tr><td colspan=");
                        if ( support_3g == 1 ) document.write("6");
                        else document.write("5");
                        document.write(" class=TABLECONTENT_CMD_TAIL><TABLE>");
			</script>
			<% web_include_file("BT.asp"); %>
                        <script>document.write("</TABLE></td></tr>");</script>
		
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
