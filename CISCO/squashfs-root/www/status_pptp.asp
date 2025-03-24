<html>
<head>
<title>VPN Status</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_vpn_account_data(); %>

var vpn_user = new Array();
<% get_pptpd_user("all"); %>

var ampm_name = new Array("AM","PM");
var ampm_val = new Array(__T(mang.am),__T(mang.pm));

var proto=new Array(__T(wan.pptp),__T(vpn.quickvpn));

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<datalist.length; i++)
	{
		if ( document.getElementById("st"+i).innerHTML == __T(vpn.offline) || http_power == "r" )
		{
			choose_disable(document.getElementById("t"+i));
		}
	}
}

function DoDisconnect(i,idx)
{
	var F = document.vpnst;
	F.submit_button.value="status_pptp";
	if ( idx == -1 ) return;
	if ( datalist[i][4] == "0" ) 
	{
		F.del_type.value = "pptp";
		F.vpn_del_id.value = vpn_user[idx][6];
	}
	else
	{
		F.del_type.value = "quickvpn";
		F.vpn_del_id.value = idx;
	}
	//alert("del_type="+F.del_type.value+";vpn_del_id="+F.vpn_del_id.value);
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=vpnst method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=vpn_del_id>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=del_type>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.pptpserver));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=150px><col width=100px><col width=60px><col width=110px><col width=110px><col width=120px><col width=80px><col width=100px>
		<TR><TD colspan=9 class=TABLETITLE><script>Capture(vpn.userconnst);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(share.username));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(vpn.remoteip));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.sts));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(vpn.stime));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(vpn.etime));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(vpn.duration)+" ("+__T(unit.seconds)+")");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(share.pl));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T(filter.action));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			var f_cnt=0;
			var disflg;
			var pptp_flg=0,vpn_flg=0;
			if ( datalist.length == 0 ) 
			{
                        	document.write("<tr class="+tstyle+" id='d"+i+"'>");
	                        document.write("<TD class='TABLECONTENT_TD' colspan=7>"+__T(msg.nodata)+"</TD>");
			}
			//datalist[0] = new Array("test2","192.168.99.100","ONLINE","03:00 PM","10:00 PM","0:1","1","QuickVPN");
			//datalist[1] = new Array("test1","","OFFLINE","--","--","0:1","0","PPTP");
			var match_vpn_id;
			for(var i=0; i<datalist.length; i++)
			{
				var tmp = new Array();
				for(var k=0; k<4; k++)
					tmp[k] = "";
				match_vpn_id=-1;
				for(var j=0; j<vpn_user.length; j++)
				{
					if ( (datalist[i][1] == vpn_user[j][0]) && (datalist[i][4] == vpn_user[j][1]) ) 
					{
						tmp[0] = vpn_user[j][2];//IP
						if ( vpn_user[j][3] != "0" ) 
						{
							var gettime = vpn_user[j][3].split(":");
							var gettime2 = gettime[1].split(" ");
							for(var k=0; k<ampm_name.length; k++)
							{
								if ( gettime2[1].toUpperCase() == ampm_name[k] )
								{
									tmp[1] = spell_words(datetime3_rule, gettime[0], gettime2[0],ampm_val[k]);
									break;
								}
							}
						}else
							tmp[1] = vpn_user[j][3];
						if ( vpn_user[j][4] != "0" ) 
						{
							var gettime = vpn_user[j][4].split(":");
							var gettime2 = gettime[1].split(" ");
							for(var k=0; k<ampm_name.length; k++)
							{
								if ( gettime2[1].toUpperCase() == ampm_name[k] )
								{ 
									tmp[2] = spell_words(datetime3_rule, gettime[0], gettime2[0],ampm_val[k]);
									break;
								}
							}
						}else
							tmp[2] = vpn_user[j][4];
						tmp[3] = vpn_user[j][5]; //CONNECT_TIME			
						if ( datalist[i][4] == "0" ) 
							match_vpn_id = j;
						else
							match_vpn_id = vpn_flg+1;
						break;
					}
				}
				if ( datalist[i][4] == "0" ) 
					pptp_flg ++;
				else
					vpn_flg++;
				var tstyle;
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
                                document.write("<TD class='TABLECONTENT_TD'>"+datalist[i][1]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>"+tmp[0]+"</TD>");
				var tmp_st="";
				//alert("tmp[1]="+tmp[1]+";tmp[2]="+tmp[2]);
				if ( tmp[1] != "0" && tmp[2] == "0" ) 
					tmp_st = __T(vpn.online);
				else
					tmp_st = __T(vpn.offline);
                                document.write("<TD class='TABLECONTENT_TD_MID' id=st"+i+">"+tmp_st+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>"+tmp[1]+"</TD>");
				if ( tmp[2] == "0" ) tmp[2] = "";
                                document.write("<TD class='TABLECONTENT_TD'>"+tmp[2]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>"+tmp[3]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID'>"+proto[datalist[i][4]]+"</TD>");
				disflg = "";
				if ( tmp_st == __T(vpn.offline)) disflg = "disabled";
				if ( http_power == "r" ) disflg = "disabled";
                                document.write("<TD class='TABLECONTENT_TD'>");
				
                                document.write("<input type=button class=BT onclick=\"DoDisconnect("+i+","+match_vpn_id+")\" value="+__T(share.disconnect)+" "+disflg+" id=t"+i+" onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\">");
                                document.write("</TD><TD class='TABLECONTENT_TD'>&nbsp;</TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			// For firefox layout
			chg_layout("divcontent","content_layer_f","content_layer");
		</script>
		
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
