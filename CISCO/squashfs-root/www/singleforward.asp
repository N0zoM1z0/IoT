<html>
<head>
<title>Getting Started</title>
<% no_cache(); %>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var iface_name = new Array(__T(mang.bboth),__T(wwan.ethernet),__T(wwan.i3g));
var iface_val = new Array("both","eth","3g")
<% web_include_file("vlan_valid_subnet.js"); %>
var wanport = "<% nvram_get("http_wanport"); %>";
single_tb="true";
var forward_single = new Array();
<% single_forward_table(); %>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frmsingleforward,"");
}

function chk_ip_format(idx)
{
	var F = document.frmsingleforward;
	var val = document.getElementById("ip"+idx).value;
	clear_table_msg("","img_ip"+idx,"ip"+idx,idx);
	if ( document.getElementById("enable"+idx).checked && val == "" ) 
	{
		table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
		return false;	
		
	}
	var is_ipv6 = (test_ipv6(val) == true)?1:0;
	var is_ipv4 = (check_ipv4(val,VALID_IP_RULE1) == PASS)?1:0;
	if ( val != "" && !is_ipv6 && !is_ipv4 )
	{
		table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
		return false;	
	}
	if ( is_ipv4 == 1 && check_ipv4(val,VALID_IP_RULE1) != PASS )
	{
		table_msg("img_ip"+idx,"ip"+idx,"div_ip"+idx,idx,__T(msg.ivalidipformat));
		return false;	
	}
	return true;
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
	for(var i=0; i<SINGLEFORWARD_ENTRY; i++)
	{
		 if ( eval("F.eport"+i).value != "" )
			 eval("F.eport"+i).value = parseInt(eval("F.eport"+i).value, 10);
		 if ( eval("F.iport"+i).value != "" )
			 eval("F.iport"+i).value = parseInt(eval("F.iport"+i).value, 10);
		 if ( eval("F.ip"+i).value != "" )
		 	 eval("F.ip"+i).value = parseIP(eval("F.ip"+i).value, 10);	
		//if ( eval("F.ip"+i).value == "" ) continue;
		//if ( eval("F.enable"+i).checked == false ) continue;
		if ( eval("F.name"+i).value == "" && eval("F.eport"+i).value == "" &&
                     eval("F.iport"+i).value == "" &&  eval("F.ip"+i).value == "" &&
		     eval("F.enable"+i).checked == false ) continue; 

		if ( eval("F.eport"+i).value != "" && !chk_valid_port("eport",i,0) ) errflg=1;
		if ( eval("F.iport"+i).value != "" && !chk_valid_port("iport",i,0) ) errflg=1;
		if ( eval("F.ip"+i).value != "" && !chk_ip_format(i) ) errflg=1;
		if ( !chkname(i) ) errflg = 1;
		if ( eval("F.enable"+i).checked == false ) continue;
		if ( eval("F.name"+i).value == "" )
                {
                        table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.notblank));
                        errflg = 1;
                }
		if ( !chk_ip_format(i) ) errflg=1;
		if ( eval("F.enable"+i).checked == false ) continue;
		if ( !chk_valid_port("eport",i,0) ) errflg=1;
		if ( !chk_valid_port("iport",i,0) ) errflg=1;
		if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
			var errmsg = valid_ipmode_check(F,"ip"+i,LANSUBNET_OK,"IPv6");
		else
		{
			var errmsg = valid_ipmode_check(F,"ip"+i,LANSUBNET_OK);
			//
			//if ( errmsg == "" ){ 
			//	if ( guestlan_subnet_ip(eval("F.ip"+i).value) )
			//		errmsg = __T(wl.guesterr5); 
			//}
		}
		/*
		if ( !chk_ip_format(i) ) errflg=1;
		var errmsg =  my_vlan_subnet_check(eval("F.ip"+i).value, CHK_LAN_IP); */
		if ( errmsg != "" )  
		{
			table_msg("img_ip"+i,"ip"+i,"div_ip"+i,i,errmsg);
			errflg = 1;
		}
		if ( errflg == 1 ) continue;
		if ( eval("F.pro"+i).value != "udp" && "<% nvram_get("remote_management"); %>" == "1" ) 
                {
                        if ( wanport == eval("F.eport"+i).value ) 
                        {
                        	table_msg("img_eport"+i,"eport"+i,"div_eport"+i,i,__T(filter.porterr));
                                return false;
                        }
                }
		for(var j=i+1; j<SINGLEFORWARD_ENTRY; j++)
		{
			if ( eval("F.name"+i).value == eval("F.name"+j).value) 
			{
				table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.nameexist));
				table_msg("img_name"+j,"name"+j,"div_name"+j,j,__T(msg.nameexist));
				errflg = 1;
			}
			if ( eval("F.eport"+i).value != "" && eval("F.eport"+j).value != "" ) 
			{
				if ( !chk_ip_format(i) ) errflg=1;
				if ( errflg == 1 ) continue;
				for(var j=i+1; j<SINGLEFORWARD_ENTRY; j++)
				{
					if ( eval("F.name"+i).value == eval("F.name"+j).value) 
					{
						table_msg("img_name"+i,"name"+i,"div_name"+i,i,__T(msg.nameexist));
						table_msg("img_name"+j,"name"+j,"div_name"+j,j,__T(msg.nameexist));
						errflg = 1;
					}
					if ( eval("F.eport"+i).value != "" && eval("F.eport"+j).value != "" ) 
					{
						if( eval("F.eport"+i).value == eval("F.eport"+j).value && 
						eval("F.iport"+i).value == eval("F.iport"+i).value && 
						( eval("F.pro"+i).value == "both" || eval("F.pro"+j).value == "both" || 
						( eval("F.pro"+i).value == eval("F.pro"+j).value ))){
						if ( eval("F.iface"+i).value != "both" && eval("F.iface"+j).value != "both" &&
						     (eval("F.iface"+i).value != eval("F.iface"+j).value) ) continue;
						table_msg("img_eport"+i,"eport"+i,"div_eport"+i,i,__T(msg.portoverlap));
						table_msg("img_eport"+j,"eport"+j,"div_eport"+j,j,__T(msg.portoverlap));
						table_msg("img_iport"+i,"iport"+i,"div_iport"+i,i,__T(msg.portoverlap));
						table_msg("img_iport"+j,"iport"+j,"div_iport"+j,j,__T(msg.portoverlap));
						errflg = 1;
					        }
					}
				}
			}
		}	
	}
	if ( errflg ) return false;
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("singleforward.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}


function uiDoSave(F)
{
	if ( !before_check(F) ) return false;	
	F.forward_single.value = SINGLEFORWARD_ENTRY;
	F.submit_button.value = "singleforward";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}
function chk_valid_port(obj_name,index,flg)
{
	var F = document.frmsingleforward;
	if ( flg ) clear_table_msg("","img_"+obj_name+index,obj_name+index,index);
	//if ( eval("F.enable"+index).checked == false ) return true;
	//if ( eval("F."+obj_name+index).value == "" ) return true;
	if ( !chk_range(obj_name+index,eval("F."+obj_name+index).value,PORT_START,PORT_TO) ) 
	{
		table_msg("img_"+obj_name+index,obj_name+index,"div_"+obj_name+index,index,spell_words(range_rule,PORT_START,PORT_TO));
		return false;
	}
	return true;
}
</script>
<BODY onload="init();">
<FORM autocomplete=off id="frm" name=frmsingleforward method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=forward_single>
<script>
var APPNAME=0,PORT=1,PROTO=2;
var def_app = new Array();
</script>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.singleforward));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=150px><col width=90px><col width=90px><col width=70px>
		<script>if ( support_3g == 1 ) document.write("<col width=70px>");</script>
		<col width=200px><col width=70px>
		<script>
                document.write("<TR><TD colspan=");
                if ( support_3g == 1 ) document.write("8 class=TABLETITLE>");
                else document.write("7 class=TABLETITLE>");
                Capture(filter.singleforwardtb);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(filter.app));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.eport));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(filter.iport));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.pl));
			if ( support_3g == 1 ) 
                        	draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.iface));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.ipaddr));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.enable));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			for(var i=0; i<SINGLEFORWARD_ENTRY; i++)
			{
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='tr_table"+i+"'>");
				
				var data = new Array(__T(mang.tcp),__T(mang.udp),__T(mang.both));
				var data_val = new Array("tcp","udp","both");
				var selflg="";
				var def_name,def_proto,def_ip,def_from,def_to,def_en;
				def_name=def_proto=def_from=def_ip=def_to=def_en="";
				if ( forward_single.length == 0 )
				{
					if (  i < def_app.length ) 
					{
					   def_name = def_app[i][APPNAME];
					   def_from = def_app[i][PORT];
					   def_to = def_app[i][PORT];
					   def_proto = def_app[i][PROTO];
					}
				}else{
					if ( i < forward_single.length ) 
					{
						def_name = forward_single[i][5];
						def_from = forward_single[i][0];
						def_to = forward_single[i][1];
						def_proto = forward_single[i][2];
						def_ip = full_ipv6(forward_single[i][3]);
						def_en = forward_single[i][4];
					}
				}
				if ( def_from == "0" ) def_from = "";
				if ( def_to == "0" ) def_to = "";
				if ( def_proto == "0" ) def_proto = "";
				if ( def_ip == "0" ) def_ip = "";
				
                                document.write("<TD class='TABLECONTENT_TD1'>");
				draw_td(O_GUI,ICONLINE,"img_name"+i,"<input size=20 maxlength=32 value='"+def_name+"' name=name"+i+" id=name"+i+" onMouseMove=showHint('img_name"+i+"','div_name"+i+"',event) onMouseOut=hideHint('div_name"+i+"') onblur=chkname("+i+")>","div_name"+i);
				document.write("</TD>");
	                        document.write("<TD class='TABLECONTENT_TD_VM'>");
				draw_td(O_GUI,ICONLINE,"img_eport"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_from)+"' name=from"+i+" id=eport"+i+" onMouseMove=showHint('img_eport"+i+"','div_eport"+i+"',event) onMouseOut=hideHint('div_eport"+i+"') onBlur=chk_valid_port('eport',"+i+",1)>","div_eport"+i,"","align=right");
				document.write("</TD>");
        	                document.write("<TD class='TABLECONTENT_TD_VM'>");
				draw_td(O_GUI,ICONLINE,"img_iport"+i,"<input size=5 maxlength=5 value='"+str_replace(" ","",def_to)+"' name=to"+i+" id=iport"+i+" onMouseMove=showHint('img_iport"+i+"','div_iport"+i+"',event) onMouseOut=hideHint('div_iport"+i+"') onBlur=chk_valid_port('iport',"+i+",1)>","div_iport"+i,"","align=right");
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>");
				draw_object(O_GUI,SELBOX,"pro"+i,"id=pro"+i,data,data_val,def_proto);
				document.write("</select></TD>");
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
				draw_td(O_GUI,ICONLINE,"img_ip"+i,"<input size=51 maxlength=39 name=ip"+i+" id=ip"+i+" onMouseMove=showHint('img_ip"+i+"','div_ip"+i+"',event) onMouseOut=hideHint('div_ip"+i+"') onBlur=chk_ip_format("+i+") value="+def_ip+">","div_ip"+i);
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
