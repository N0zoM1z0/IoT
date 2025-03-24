<% no_cahce(); %>
<% js_link(); %>
<LINK href="style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="position.js"></script>
<script type="text/javascript" src="common.js"></script>
<script>
var datalist = new Array();
<% get_site_survey_table(); %>
var is_data_len=0;
var mac_cnt=1;
function init(){
	var cnt=1;
	for(var i=0; i<mac_cnt; i++)
	{
		//if ( parent.document.getElementById("mac"+i).value == "" || 
		//     parent.document.getElementById("mac"+i).value== "00:00:00:00:00:00" ) 
		//	continue;
		if ( parent.document.getElementById("mac"+i).value != "" ) cnt--;
		for(var j=0; j<datalist.length; j++)
		{
			if ( parent.document.getElementById("mac"+i).value == datalist[j][4] ) 
				document.getElementById("chk"+j).checked = true;
		}
	}
	init_cnt(cnt);	
}

function init_cnt(cnt){
       for(var i=0; i<datalist.length; i++)
       {
		if ( cnt == 0 )
		{
			if ( document.getElementById("chk"+i).checked == false )
	                	choose_disable(document.getElementById("chk"+i));
		}
		else 
		{
			if ( str_replace(" ","",datalist[i][2]) == "WPAEnterprise" ||  
			     str_replace(" ","",datalist[i][2]) == "WPA2Enterprise") 
				continue;
                      	choose_enable(document.getElementById("chk"+i));
		}
       }
       if ( cnt == 0 )
       {
                choose_disable(document.getElementById("t2"));
//                choose_disable(document.getElementById("t3"));
       }else{
                choose_enable(document.getElementById("t2"));
//                choose_enable(document.getElementById("t3"));
       }
}

function to_connect(F){
	var data = get_mac_id();
	var tmpdata = data.split(",");
	var cnt=0;
	for(var j=0; j<mac_cnt; j++)
		parent.document.getElementById("mac"+j).value = "";
	for(var j=0; j<tmpdata.length; j++)
	        parent.document.getElementById("mac"+j).value = tmpdata[j];

}

function get_mac_id()
{
	var data="", rmdata="";
	var F = document.frmsite;
	var flg=0;
	for(var j=0; j<datalist.length; j++)
	{
		if ( document.getElementById("chk"+j).checked == true )
		{
			flg=0;
			for(var i=0; i<mac_cnt; i++)
			{
				if ( parent.document.getElementById("mac"+i).value == datalist[j][4] ) 
				{
					flg=1;
					break;
				}
			}
			if ( flg ) continue;
			if ( data != "" ) data += ",";
			data+=datalist[j][4];
		}else{
			for(var i=0; i<mac_cnt; i++)
			{
				if ( parent.document.getElementById("mac"+i).value == datalist[j][4] ) 
				{
					if ( rmdata != "" ) rmdata +=",";
					rmdata+=datalist[j][4];
				}
			}
		}
	}
	var tmp = data.split(",");
	var rmtmp = rmdata.split(",");
	for(var i=0; i<mac_cnt; i++)
	{
		for(var j=0; j<tmp.length; j++)
		{
			if ( parent.document.getElementById("mac"+i).value == tmp[j] ) 
				continue;
			if ( j == tmp.length-1)
			{
				for(var k=0; k<rmtmp.length; k++)
				{
					if ( parent.document.getElementById("mac"+i).value == rmtmp[k] || 
					     parent.document.getElementById("mac"+i).value == "" ) break;
					if ( k == rmtmp.length-1)
					{	
						if ( data != "" ) data += ",";
						data+=parent.document.getElementById("mac"+i).value;
					}
				}
			}
		}
		
	}
	return data;	
}

function to_chk(idx)
{
	var F = document.frmsite;
	var data = get_mac_id();
	var tmp = data.split(",");
	var tmplen=0;
	if ( tmp != "" )
		tmplen = tmp.length;
	init_cnt(mac_cnt-tmplen);
        choose_enable(document.getElementById("t2"));
        choose_enable(document.getElementById("t3"));
}

function to_refresh(F){
	document.location.reload();
}
</script>
<body onload="init();">
<FORM name=frmsite id=frm action=apply.cgi>
<input type=hidden name=allow_count>
<TABLE class=CONTENT_TABLE>
  <TR><TD colspan=2>
		
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<!--col width=10px><col width=365px><col width=50px><col width=80px><col width=35px><col width=110px-->
		<col width=3%><col width=48%><col width=9%><col width=13%><col width=8%><col width=15%>
		<TR><TD colspan=7 class=TABLETITLE><script>Capture(wl.availablenetworkstb);</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,"&nbsp;");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(wl.networkname));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(wl.ch));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(wl.security));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_R,__T(wl.singal));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.macaddr));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
			document.write("<TR height=20px><td colspan=7>");
			document.write("<div style='overflow:auto;height:150px;position:relative'>");
                	document.write("<TABLE class=aCONTENT_GROUP cellspacing=0 width=100%>");
			//document.write("<col width=5px><col width=370px><col width=50px><col width=95px><col width=40px><col width=115px>");
			document.write("<col width=3%><col width=50%><col width=9%><col width=13%><col width=8%><col width=15%>");
			var f_cnt=0;
			var sec_mode="", disflg="";
			for(var i=0; i<datalist.length; i++)
			{
				sec_mode="";
				if ( str_replace(" ","",datalist[i][2]) == "Disabled" ) sec_mode = __T(share.disabled);
				else if ( str_replace(" ","",datalist[i][2]) == "WEP" ) sec_mode = __T(wl.wep);
				else if ( str_replace(" ","",datalist[i][2]) == "WPAPersonal" ) sec_mode = __T(wl.wpap); 
				else if ( str_replace(" ","",datalist[i][2]) == "WPA2Personal" ) sec_mode = __T(wl.wpa2p); 
				else if ( str_replace(" ","",datalist[i][2]) == "WPAEnterprise" ) sec_mode = __T(wl.wpae); 
				else if ( str_replace(" ","",datalist[i][2]) == "WPA2Enterprise" ) sec_mode = __T(wl.wpa2e); 
				var tstyle;
				disflg="";
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
                                document.write("<tr class="+tstyle+" id='d"+i+"'>");
				if ( sec_mode == __T(wl.wpae) || sec_mode ==  __T(wl.wpa2e) ) 
					disflg = "disabled";
                                document.write("<TD class='TABLECONTENT_TD_MID' abgcolor=red><input "+disflg+" type=checkbox id=chk"+f_cnt+" onClick=to_chk('"+f_cnt+"')></TD>");
                                document.write("<TD class='TABLECONTENT_TD' abgcolor=blue>"+datalist[i][0]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_VM' abgcolor=green>"+datalist[i][1]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_1' abgcolor=red>"+sec_mode+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_VM' abgcolor=green>"+datalist[i][3]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD_1' abgcolor=blue>"+datalist[i][4]+"</TD>");
                                document.write("<TD class='TABLECONTENT_TD'></TD>");
                                document.write("</tr>");
				f_cnt++;
			}
			document.write("</TABLE></TD></TR></div>");
			document.write("<tr><td colspan=7 class=TABLECONTENT_CMD_TAIL>");
			draw_object(O_GUI,BT,__T(share.connect),"t2","BT","to_connect(this.form)");
			draw_object(O_GUI,BT,__T(share.refresh),"t3","BT","to_refresh(this.form)");
                        document.write("</td></tr>");	
		</script>
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
