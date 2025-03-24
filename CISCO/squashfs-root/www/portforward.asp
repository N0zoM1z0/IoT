<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("vlan_valid_subnet.js"); %>
var wanport = "<% nvram_get("http_wanport"); %>";
var 
single_tb="true";
var iface_name = new Array(__T(mang.bboth),__T(wwan.ethernet),__T(wwan.i3g));
var iface_val = new Array("both","eth","3g")
var forward_port = new Array();
<% port_forward_table(); %>

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("portforward.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	if ( !before_check(F) ) return;
	F.forward_port.value = FORWARD_ENTRY;
	F.submit_button.value = "portforward";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
	
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frmforward,"");
}

function chkname(i)
{
	clear_table_msg("","img_name"+i,"name"+i,i);
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById("name"+i).value,0,"name"+i);
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
	for(var i=0; i<FORWARD_ENTRY; i++)
	{
		if ( eval("F.name"+i).value == "" && eval("F.from"+i).value == "" &&
                     eval("F.to"+i).value == "" &&  eval("F.ip"+i).value == "" &&
		     eval("F.enable"+i).checked == false ) continue; 
			
		if ( eval("F.from"+i).value != "" && !chk_valid_port("from",i,0) ) errflg=1;
		if ( eval("F.to"+i).value != "" && !chk_valid_port("to",i,0) ) errflg=1;
		if ( eval("F.ip"+i).value != "" && !chk_ip_format(i) ) errflg=1;
		if ( errflg == 1 ) continue;
		if (  eval("F.from"+i).value != "" && eval("F.to"+i).value != "" ) 
		{
	                if ( parseInt(eval("F.from"+i).value,10) > parseInt(eval("F.to"+i).value,10) )
        	        {
                	        table_msg("img_to"+i,"to"+i,"div_to"+i,i,__T(msg.errstartend));
                        	errflg=1;
	                }
		}
		if ( !chkname(i) ) errflg=1;
		if ( eval("F.enable"+i).checked == false ) continue;
		if ( eval("F.pro"+i+".value") != "udp" && "<% nvram_get("remote_management"); %>" == "1" ) 
		{
			if ( chk_range("", wanport, eval("F.from"+i+".value"),  eval("F.to"+i+".value"), "nochg") ) 
			{
				table_msg("img_from"+i,"from"+i,"div_from"+i,i,__T(filter.porterr));
  				table_msg("img_to"+i,"to"+i,"div_to"+i,i,__T(filter.porterr));
				return false;	
			}	
		}
		if ( eval("F.name"+i).value == "" )
		{
                        table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.notblank));
			errflg=1;
		}
		if ( !chk_valid_port("from",i,0) ) errflg=1;
		if ( !chk_valid_port("to",i,0) ) errflg=1;
		if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
			var errmsg = valid_ipmode_check(F,"ip"+i,LANSUBNET_OK,"IPv6");
		else{
			var errmsg = valid_ipmode_check(F,"ip"+i,LANSUBNET_OK);
/*
			if ( errmsg == "" ){ 
				if ( guestlan_subnet_ip(eval("F.ip"+i).value) )
					errmsg = __T(wl.guesterr5); 
			}
*/
		}
                if ( errmsg != "" )  
                {
                        table_msg("img_ip"+i,"ip"+i,"div_ip"+i,i,errmsg);
                        errflg = 1;
                }
		if ( errflg == 1 ) continue;
		for(var j=i+1; j<FORWARD_ENTRY; j++)
		{
			if ( eval("F.enable"+j).checked == false ) continue;
       			clear_table_msg("","img_name"+i,"name"+i,i);
			if ( eval("F.name"+i).value == eval("F.name"+j).value )
                        {
               	                table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.nameexist));
                       	        table_msg("img_name"+j,"name"+j,"div_name"+j,j,__T(msg.nameexist));
                               	errflg = 1;
       	                }
			if( ( eval("F.from"+i+".value") > 0 || eval("F.to"+i+".value") > 0 ) && 
			    ( eval("F.from"+j+".value") > 0 || eval("F.to"+j+".value") > 0 ))
			{
         			if(!check_port(parseInt(eval("F.from"+i+".value")),
				       parseInt(eval("F.to"+i+".value")),
		                       parseInt(eval("F.from"+j+".value")),
                        	       parseInt(eval("F.to"+j+".value"))))
				{
					if((eval("F.pro"+i+".value") == eval("F.pro"+j+".value")) ||
		                           (eval("F.pro"+i+".value") == "both") ||
                   		           (eval("F.pro"+j+".value") == "both"))
					{
						if ( eval("F.iface"+i).value != "both" && eval("F.iface"+j).value != "both" &&
						     (eval("F.iface"+i).value != eval("F.iface"+j).value) ) continue;
						
					        table_msg("img_from"+i,"from"+i,"div_from"+i,i,__T(msg.portoverlap));
  						table_msg("img_to"+i,"to"+i,"div_to"+i,i,__T(msg.portoverlap));
						table_msg("img_from"+j,"from"+j,"div_from"+j,j,__T(msg.portoverlap));
						table_msg("img_to"+j,"to"+j,"div_to"+j,j,__T(msg.portoverlap));
						errflg=1;
					}
				}
			}
		}
				
	}	
	if ( errflg == 1 ) return false;
	return true;
}

function chk_valid_port(obj_name,index,flg) {
        var F = document.frmforward;
        if ( flg ) clear_table_msg("","img_"+obj_name+index,obj_name+index,index);
	if ( !chk_range(obj_name+index,eval("F."+obj_name+index).value,PORT_START,PORT_TO) )
        {
                table_msg("img_"+obj_name+index,obj_name+index,"div_"+obj_name+index,index,spell_words(range_rule,PORT_START,PORT_TO));
                return false;
        }
        return true;
}

function chk_ip_format(idx)
{
        var val = document.getElementById("ip"+idx).value;
        clear_table_msg("","img_ip"+idx,"ip"+idx,idx);
	if ( document.getElementById("enable"+idx).checked == true &&  val == "" ) 
	{
                table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
                return false;   
	}
	var is_ipv6 = (test_ipv6(val)==true)?1:0;
	var is_ipv4 = (check_ipv4(val,VALID_IP_RULE1) == PASS)?1:0;
	if ( val != "" && !is_ipv6 && !is_ipv4 )
        {
                table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
                return false;   
        }
	if ( is_ipv4 && check_ipv4(val,VALID_IP_RULE1) != PASS )
        {
                table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
                return false;   
        }
        return true;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmforward method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=forward_port>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.portrangeforward));</script></TR>
  <TR><TD colspan=2 width=100%>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=150px><col width=70px><col width=70px><col width=70px>
		<script>if ( support_3g == 1 ) document.write("<col width=70px>");</script>
		<col width=200px><col width=70px>
		<script>
		document.write("<TR><TD colspan=");
		if ( support_3g == 1 ) document.write("8 class=TABLETITLE>");
		else document.write("7 class=TABLETITLE>");
		Capture(filter.portrangeforwardtb);</script></TR>	
		<script>
			document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(filter.app));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.start));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.end));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.pl));
			if ( support_3g == 1 ) 
                        	draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.iface));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.ipaddr));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.enable));                         
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			var data = new Array(__T(mang.tcp),__T(mang.udp),__T(mang.both));
			var data_val = new Array("tcp","udp","both");
			for(var i=0; i<FORWARD_ENTRY; i++)
			{
				var tstyle;
				var def_name,def_from,def_to,def_proto,def_ip,def_en;
				def_name=def_from=def_to=def_proto=def_ip=def_en="";
				if ( i < forward_port.length )
				{
					def_from = forward_port[i][0];
					def_to = forward_port[i][1];
					def_proto = forward_port[i][2];
					def_ip = full_ipv6(forward_port[i][3]);
					def_en = forward_port[i][4];
					def_name = forward_port[i][5];
				} 
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='tr_table"+i+"'>");
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_name"+i,"<input size=20 maxlength=32 value='"+def_name+"' name=name"+i+" id=name"+i+" onMouseMove=showHint('img_name"+i+"','div_name"+i+"',event) onMouseOut=hideHint('div_name"+i+"') onblur=chkname("+i+")>","div_name"+i);
                                document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_from"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_from)+"' name=from"+i+" id=from"+i+" onMouseMove=showHint('img_from"+i+"','div_from"+i+"',event) onMouseOut=hideHint('div_from"+i+"') onBlur=chk_valid_port('from',"+i+",1)>","div_from"+i);
                                document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_to"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_to)+"' name=to"+i+" id=to"+i+" onMouseMove=showHint('img_to"+i+"','div_to"+i+"',event) onMouseOut=hideHint('div_to"+i+"') onBlur=chk_valid_port('to',"+i+",1)>","div_to"+i);
                                document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>");
				draw_object(O_GUI,SELBOX,"pro"+i,"id=pro"+i,data,data_val,def_proto);
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
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_ip"+i,"<input size=51 maxlength=39 name=ip"+i+" onBlur=chk_ip_format("+i+") id=ip"+i+" onMouseMove=showHint('img_ip"+i+"','div_ip"+i+"',event) onMouseOut=hideHint('div_ip"+i+"') value="+def_ip+">","div_ip"+i);
				document.write("</TD>");
				var tmpchk="";
                                if ( def_en.indexOf("on")!=-1 ) tmpchk = "checked";
                                document.write("<TD class='TABLECONTENT_TD_MID'><input type=checkbox name=enable"+i+" id=enable"+i+" "+tmpchk+">");
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD1'></TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			document.write("<tr><td colspan=");
                        if ( support_3g == 1 ) document.write("8");
                        else document.write("7");
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
