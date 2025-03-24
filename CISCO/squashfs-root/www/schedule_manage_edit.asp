<html>
<head>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var datalist = new Array();
<% get_schedule_list(); %>
var back_bt="true";
var change_cancel_bt="true";
var _hour_name12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
var _hour_name24 = new Array("ISRANGE","0","23","1",2);
function init()
{
	var F = document.frmschedule;
	var index = F.now_idx.value;
	var ch;
	if ( F.stflg.value == "edit" ) 
	{
		F.schname.value = cy_speccode_decode(datalist[index][0]);
		choose_disable(F.schname);
		if ( datalist[index][1] == "1111111" ) 
		{
			F.selday.selectedIndex = 0;
		}else{
			F.selday.selectedIndex = 1;
			for(var j=0; j<7; j++)
			{
				ch = datalist[index][1].charAt(j);
				if ( ch == "1" ) 
				{
					eval("F.week"+j).checked = true;
				}
			}
		}
		if ( datalist[index][2] == "0" && datalist[index][3] == "0" && datalist[index][4] == "23" && datalist[index][5] == "59" ) 
		{
			F.seltime.selectedIndex = 0;
		}else{
			F.seltime.selectedIndex = 1;
			var tmp_s_hour = 0, tmp_e_hour=0;
			if ( flg_24 == 0 ) 
			{
				if ( parseInt(datalist[index][2],10) >= 12 ) 
				{
					F.stime.selectedIndex = 1;
					tmp_s_hour = parseInt(datalist[index][2],10)-12;
				}else{
					F.stime.selectedIndex = 0;
					tmp_s_hour = parseInt(datalist[index][2],10);
				}
			
				if ( parseInt(datalist[index][4],10) >= 12 )
	                	{
        	                	F.etime.selectedIndex = 1;
	                	        tmp_e_hour = parseInt(datalist[index][4],10)-12;
		                }else{
        		                F.etime.selectedIndex = 0;
                	        	tmp_e_hour = parseInt(datalist[index][4],10);
	                	}
			}else{
				tmp_s_hour = parseInt(datalist[index][2],10);
                	        tmp_e_hour = parseInt(datalist[index][4],10);
			}
			F.stime_min.selectedIndex = parseInt(datalist[index][3],10);
        	        F.etime_min.selectedIndex = parseInt(datalist[index][5],10);
			if ( flg_24 == 0 )
			{
				for(var k=0; k<_hour_name12.length; k++)
				{
					if ( parseInt(_hour_name12[k],10) == tmp_s_hour ) 
						F.stime_hour[k].selected = true;
					if ( parseInt(_hour_name12[k],10) == tmp_e_hour ) 
						F.etime_hour[k].selected = true;
				}
			}else{
				F.stime_hour[parseInt(tmp_s_hour,10)].selected = true;
				F.etime_hour[parseInt(tmp_e_hour,10)].selected = true;
			}
		}
	}
	sel_day(F);
	sel_time(F);
	default_nv = keep_val(F,"");
}

function sel_day(F)
{
	if ( F.selday.value == "0" ) //All Days
		DISABLE_PART(F,"day_start","day_end",1);
	else
		DISABLE_PART(F,"day_start","day_end",0);
}

function sel_time(F)
{
        if ( F.seltime.value == "0" ) //All Days
                DISABLE_PART(F,"time_start","time_end",1);
        else
                DISABLE_PART(F,"time_start","time_end",0);
}

function chk_valid(F)
{
	var errflg = 0 ;
	F.week_time.value = "";
	if ( F.selday.value == 0 ) 
	{
		F.week_time.value = "1111111";
	}else{
		for(var i=0; i<7; i++)
		{
			if ( eval("F.week"+i).checked == true ) 
				F.week_time.value += "1";
			else
				F.week_time.value += "0";
		}
		if ( F.week_time.value == "0000000" )
		{
                	my_alert(O_VAR,"selday",__T(msg.selday),"1","msg_day");
			errflg = 1 ; 
		} 
	}
	if ( F.seltime.value == 0 ) 
	{
		F.start_time.value = "00:00"; 
		F.stop_time.value = "23:59";
	
	}else{
		if ( flg_24 == 0 ) 
		{
			F.start_time.value = trans_time_format(F.stime_hour.value,F.stime_min.value,F.stime.value);
			F.stop_time.value = trans_time_format(F.etime_hour.value,F.etime_min.value,F.etime.value);
		}else{
			F.start_time.value = F.stime_hour.value+":"+F.stime_min.value;
			F.stop_time.value = F.etime_hour.value+":"+F.etime_min.value;
		}
		var sdata=new Array();
        	var edata=new Array();
		var start,end;
	        sdata = F.start_time.value.split(":");
        	edata = F.stop_time.value.split(":");
	        start = parseInt(sdata[0],10)*60 + parseInt(sdata[1],10);
        	end = parseInt(edata[0],10)*60 + parseInt(edata[1],10);
		if ( end <= start )
        	{
                	parent.document.getElementById("obj_id").value = "msg_time";
		        my_alert(O_VAR,"etime_hour",__T(msg.timechk),"0","msg_time");
        	        my_alert(O_VAR,"etime_min",__T(msg.timechk),"0","msg_time");
                	my_alert(O_VAR,"etime",__T(msg.timechk),"0","msg_time");
			errflg = 1 ; 
	        }
	}
//	if ( flg_24 == 1 ) 
//	{
//		F.start_time.value = "0:"+F.stime_min.value;
//		F.stop_time.value = "0:"+F.etime_min.value;
//	}
	
	clear_msg("schname", "msg_name");
	if ( F.schname.value == "" ) 
	{
               	my_alert(O_VAR,"schname",__T(msg.notblank),"0","msg_name");
		errflg = 1 ; 	
	}
	if ( F.schname.value == "0" ) // API used.
	{
       		my_alert(O_VAR,"schname",__T(msg.nameexist),"0","msg_name");
		errflg=1;
	}
	var returnmsg = valid_meaning_id_name(ID_NAME,F.schname.value,ZERO_NO,"schname");
	if ( returnmsg != "" ) 
	{
       		my_alert(O_VAR,"schname",returnmsg,"0","msg_name");
		errflg=1;
	}
        for(var j=0; j<datalist.length; j++)
	{
		if ( "<% nvram_gozila_get("stflg"); %>" == "edit" && parseInt("<% nvram_gozila_get("now_idx"); %>",10) == j ) 				continue;
		
		if ( datalist[j][0] == F.schname.value ) 
		{
               		my_alert(O_VAR,"schname",__T(msg.nameexist),"0","msg_name");
			errflg=1;
			break;
		}
			
	}	
	if ( errflg == 1 ) return false;
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("Schedule_manage.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	if ( !chk_valid(F) ) return false;
	if ( F.stflg.value == "edit" ) choose_enable(F.schname);
	F.submit_button.value="schedule_manage";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
        {
        	setTimeout("chk_st()", 15000);
        }
	parent.document.getElementById("save_bg").style.display="";
}

function to_back(F){
	parent.document.getElementById("newpage").value = "schedule_manage.asp";
	uiDoCancel(F,"back");
}

function refresh_page()
{
	alert_result(0);	
	var F = document.frmschedule;
        F.submit_button.value = "schedule_manage_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}


</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frmschedule" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=now_idx value="<% nvram_gozila_get("now_idx"); %>">
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<input type=hidden name=start_time>
<input type=hidden name=stop_time>
<input type=hidden name=week_time>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.editsch));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.addschconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.name));</script>
		<input size=20 maxlength=32 name=schname id=schname>
		<span id=msg_name></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.schdays),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>Capture(filter.schspecdays);</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
		var _name = new Array(__T(filter.alldays),__T(filter.specdays));
		var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"selday","onChange=sel_day(this.form) id='selday' ",_name,_val);
		</script>
		<span id=msg_day></span>
		</TD></TR>
		<input type=hidden name=day_start>
		<script>
		var _name = new Array(__T(filter.mon),__T(filter.tue),__T(filter.wed),__T(filter.thu),__T(filter.fri),__T(filter.sat),__T(filter.sun));
		for(i=0; i<_name.length; i++)
		{
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE_NOSHIFT,_name[i]+":");
			document.write("<input type=checkbox name=week"+i+"></TD></TR>");
		}
		</script>
		<input type=hidden name=day_end>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.schtimeofday),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>Capture(filter.schspectimes);</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
		var _name = new Array(__T(filter.alltimes),__T(filter.spectimes));
		var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"seltime","onChange=sel_time(this.form)",_name,_val);
		</script>
		<input type=hidden name=time_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.starttime));</script>
		<script>
		var _name = new Array(__T(mang.am),__T(mang.pm));
		var _val = new Array("am","pm");
		var _min_name = new Array("ISRANGE","0","59","1",2);
		if ( flg_24 == 1 ) 
		{ 
			draw_object(O_GUI,SELBOX,"stime_hour","",_hour_name24,_hour_name24);
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			draw_object(O_GUI,SELBOX,"stime_min","",_min_name,_min_name);
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}else{
			draw_object(O_GUI,SELBOX,"stime_hour","",_hour_name12,_hour_name12);
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			draw_object(O_GUI,SELBOX,"stime_min","",_min_name,_min_name);
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
			draw_object(O_GUI,SELBOX,"stime","",_name,_val);
		}
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.endtime),SPACE_DOWN,SPACE_DOWN);</script>
                <script>
		var _name = new Array(__T(mang.am),__T(mang.pm));
                var _val = new Array("am","pm");
                var _min_name = new Array("ISRANGE","0","59","1",2);
		if ( flg_24 == 1 ) 
		{
	                draw_object(O_GUI,SELBOX,"etime_hour","id=etime_hour",_hour_name24,_hour_name24);
        	        document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
	                draw_object(O_GUI,SELBOX,"etime_min","id=etime_min",_min_name,_min_name);
        	        document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}else{
	                draw_object(O_GUI,SELBOX,"etime_hour","id=etime_hour",_hour_name12,_hour_name12);
        	        document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
	                draw_object(O_GUI,SELBOX,"etime_min","id=etime_min",_min_name,_min_name);
        	        document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
                	draw_object(O_GUI,SELBOX,"etime","id=etime",_name,_val);
		}
                </script>
		<SPAN id=msg_time></SPAN>
                </TD></TR>
		<input type=hidden name=time_end>
		
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
