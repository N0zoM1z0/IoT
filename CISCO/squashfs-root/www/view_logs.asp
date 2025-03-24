<html>
<head>
<title>View Logs</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var start_line = 0;
var end_line = 0;
var total_line = 0;
var data_cnt = 0;
var stflg="init";
var datalist = new Array();
<% dump_syslog_ng(); %>

var log_level = new Array("all","emergency","alert","critical","error","warning","notification","infomation","debugging");
var log_alias = new Array("","","","","","","notice","","");
var _service_list = new Array(__T(syslog.event_all),__T(syslog.event_emer),__T(syslog.event_alert),__T(syslog.event_crit),__T(syslog.event_err),__T(syslog.event_warn),__T(syslog.event_noti),__T(syslog.event_info),__T(syslog.event_debug));
var _service_val = new Array('0','1','2','3','4','5','6','7','8');
var _logevent_setval = new Array('0','1','2','4','8','16','32','64','128');
<% show_syslog_ng_service(); %>

//var facility = parseInt("< nvram_gozila_get("log_page_facility"); >",10);
if(facility == undefined) var facility=255;
else if(facility == 0) facility = 255;

var start_line = (data_page * page_cnt - page_cnt+1);
var end_line = (data_page * page_cnt);
var data_len = datalist.length;
var total_page = 0;
var count_entry = 0;

var total_line = parseInt("<% nvram_get("log_limit_count");%>",10);

if(end_line > total_line)
	end_line = total_line;

if(facility == 0)
	count_entry = data_len;
else
{	
	var logevent_str = "";
	for(var i=1; i< _logevent_setval.length; i++)
	{
		if((facility | parseInt(_logevent_setval[i],10)) == facility)
			logevent_str += (log_level[i]+",");
		if((i == 6) && (facility | parseInt(_logevent_setval[i],10)) == facility)
			logevent_str += (log_alias[i]+",");
	}
	
        for(var i=0; i < data_len; i++)    
	{
		if(logevent_str.lastIndexOf(datalist[i][2]) < 0) 
			continue;
		count_entry++;			
	}
}
total_page = parseInt((count_entry / page_cnt),10);
if((total_page == 0) || ((count_entry % page_cnt) != 0))
	total_page += 1;
	
function init()
{
	var F = document.frmlog;
	var enlog = "<% nvram_get("log_enable"); %>";
	var startc = 0;
	var endc = 0;
	var record_cnt = 0;
	var tempc = 0;
	var pri_name = "";
	var pri_val = 0;
	var logevent_str = "";
	var tmp = new Array();

	if( enlog == "1")
	{
                DISABLE_PART(F,"all_page_start","all_page_end",0);
	}
	else
	{
		DISABLE_PART(F,"all_page_start","all_page_end",1);
		for(var i=4; i<8; i++)
			chk_action("t"+i,"disabled");
		F.txt_page.value = 0;
		document.getElementById("page").innerHTML = 0;
		return;
	}

	if(end_line < 1) //no data
	{
		if(data_len == 0)
		{
			for(var i=4; i<8; i++) 	chk_action("t"+i,"disabled");
			DISABLE_PART(F,"all_page_start","all_page_end",1);
		}
		else
		{
			F.txt_page.value = 0;
			chk_action("a5","disabled");
			chk_action("a6","disabled");
			chk_action("a7","disabled");
		}
	}
	else
	{
		if(data_page == 1)
		{
			chk_action("a5","disabled");
			chk_action("a4","disabled");
			if(data_page == data_cnt)
				choose_disable(document.getElementById("t8"));
		}
		else if(data_page == data_cnt)
		{
			chk_action("a6","disabled");
			chk_action("a7","disabled");
		}
	}
	
	F.txt_page.value = data_page;
	document.getElementById("page").innerHTML = total_page;

	if(page_cnt == 20)
		F.selcnt.selectedIndex = 0;
	else if(page_cnt == 50)
		F.selcnt.selectedIndex = 1;
	else if(page_cnt == 100)
		F.selcnt.selectedIndex = 2;
	F.sel_count.value = F.selcnt[F.selcnt.selectedIndex].value;

	for(var i=1; i< _logevent_setval.length; i++)
	{
		if((facility | parseInt(_logevent_setval[i],10)) == facility)
		{
			pri_name = eval("F.log_pri_"+i);
			pri_name.checked = true;
			logevent_str += (log_level[i]+",");
			if((i == 6) && (facility | parseInt(_logevent_setval[i],10)) == facility)
				logevent_str += (log_alias[i]+",");
			pri_val |= facility;
		}
	}
	F.sel_type.value = pri_val;

	startc = (data_page * page_cnt) - page_cnt;
	endc = (data_page * page_cnt)+1;
	for(var i=(data_len-1); i>=0; i--)    
        {
		var gettime = datalist[i][1].split(" ");
		var df = gettime[0].split("-");
		var tf = gettime[1].split(":");
		var tmp_time="";
		
		if(logevent_str.lastIndexOf(datalist[i][2]) < 0) 
			continue;
		
		record_cnt += 1;
		
		if(record_cnt > endc)
		{
			break;
		}
		if(!((startc < record_cnt) && (record_cnt < endc)))
		{
			continue;
		}
		tempc += 1;

        	tmp[0] = new Array("id"+record_cnt,record_cnt,2);

		if ( flg_24 == 1 ) 
	                tmp_time = spell_words(datetime2_rule,df[0],df[1],df[2],tf[0],tf[1],tf[2]);
		else{
			var tmp_hour = parseInt(tf[0],10);
			var tmp_noon = "AM";
			if ( tmp_hour >= 12 ) 
			{
				if ( tmp_hour > 12 )
					tmp_hour-=12;
				tmp_noon="PM";
			}

			if (tmp_hour == 0)
				tmp_hour= 12;

	                tmp_time = spell_words(datetime2_rule,df[0],df[1],df[2],tmp_hour,tf[1],tf[2]+" "+tmp_noon);
		}
                tmp[1] = new Array("time"+record_cnt,tmp_time,0);
                tmp[2] = new Array("sec"+record_cnt,datalist[i][2],3);
                tmp[3] = new Array("desc"+record_cnt,datalist[i][3],4);
                tmp[4] = new Array("","&nbsp;");
                add_row(tempc,tmp,"",stflg,3);
        }
	if ( http_power == "r" )
	{
		choose_disable(document.getElementById("a2"));
		choose_disable(document.getElementById("a3"));
	}
}
	
function to_next(obj,flag)
{
	var F = document.frmlog;
	var set_page;

	 if( (	obj == "a6" && document.getElementById("cmdnext").src.indexOf("image/Next-D.gif")!=-1 ) ||
	     (  obj == "a7" && document.getElementById("cmdlast").src.indexOf("image/Last-D.gif")!=-1 ))
		return;

	if(flag)
		set_page = total_page;
	else
		set_page = parseInt(F.txt_page.value,10)+1;
	if(set_page > total_page) return;
	F.txt_page.value = set_page;
	set_gozila(F);
}

function to_prev(obj,flag)
{
	
	var F = document.frmlog;
	var set_page;
	
	if ( (  obj == "a4" && document.getElementById("cmdfirst").src.indexOf("image/First-D.gif")!=-1 ) ||
	     (  obj == "a5" && document.getElementById("cmdprev").src.indexOf("image/Previous-D.gif")!=-1 ) )
		return;
 
	if(flag)
		set_page = 1;
	else
		set_page = parseInt(F.txt_page.value,10)-1;

	if(set_page < 1) return;
	F.txt_page.value = set_page;
	set_gozila(F);
}

function to_page_enter(e)
{
	if(window.event)
	{
		e = event;
		e.which = e.keyCode;
	}
	else if(!e.which)
		e.which = e.keyCode;

	//var key = e.which;
	if(e.which == 13) //enter
		to_page();
}

function to_page()
{
	var F = document.frmlog;
	var set_page = parseInt(F.txt_page.value,10);
	
	if((set_page < 1) || (set_page > total_page))
		return;

	F.txt_page.value = set_page;
	set_gozila(F);
}

function seltype(F)
{
	var pri_val = 0;
	var pri_name = "";
	for(var i=1; i< _logevent_setval.length; i++)
	{
		var pri_name = eval("F.log_pri_"+i);
		if((pri_name != undefined) && (pri_name.checked == true))
			pri_val |= parseInt(_logevent_setval[i],10);
	}
	if(pri_val <= 0)
	{
		my_alert(O_GUI,ERROR,__T(share.errmsg),__T(msg.setpri));
		return 0;
	}
	F.sel_type.value = pri_val;
	F.txt_page.value = 1;
	set_gozila(F);
}

function select_count(obj,F)
{
	F.sel_count.value = F.selcnt[obj].value;
	F.txt_page.value = 1;
	set_gozila(F);
}

function to_refresh()
{
	var F = document.frmlog;
	F.log_refresh.value = 1;
	set_gozila(F);
}

function to_clear()
{
	var F = document.frmlog;
	F.txt_page.value = "1";
	F.sel_count.value = F.selcnt[0].value;
	F.change_action.value="gozila_cgi";
	F.submit_type.value="view_log_clear";
	F.submit();
}

function to_save()
{
	var F = document.frmlog;
	window.location.href="<% get_syslog_ng(""); %>";
}

function set_gozila(F)
{
	F.sel_init.value = 1;
	F.change_action.value="gozila_cgi";
	F.submit_type.value="view_log_setinfo";
	F.submit();
}

function chk_action(obj,st)
{
	if ( (  obj == "a4" && document.getElementById("cmdfirst").src.indexOf("image/First-D.gif")==-1 ) ||
	     (  obj == "a5" && document.getElementById("cmdprev").src.indexOf("image/Previous-D.gif")==-1 ) ||
	     (  obj == "a6" && document.getElementById("cmdnext").src.indexOf("image/Next-D.gif")==-1 ) ||
	     (  obj == "a7" && document.getElementById("cmdlast").src.indexOf("image/Last-D.gif")==-1 ))
		bt(obj,st);

	if ( st == "disabled" ) 
	{
		if ( obj == "a4" ) document.getElementById("cmdfirst").src = "image/First-D.gif";
		else if ( obj == "a5" ) document.getElementById("cmdprev").src = "image/Previous-D.gif";
		else if ( obj == "a6" ) document.getElementById("cmdnext").src = "image/Next-D.gif";
		else if ( obj == "a7" ) document.getElementById("cmdlast").src = "image/Last-D.gif";
	}

	document.getElementById("hidden_chkbox").style.display="none"; //
}

function check_pri(table_pri_s,pri_s)
{
	var i=0;
	var end_en = pri_s;
	var start_dn = pri_s+1;

	for(i = 1; i <= end_en; i++)
	{
		document.getElementById("log_pri_"+i).checked = true;
	}
	for(i=start_dn; i < _logevent_setval.length; i++)
	{
		document.getElementById("log_pri_"+i).checked = false;
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmlog method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button value="view_logs">
<input type=hidden name=change_action>
<input type=hidden name=submit_type value='<% nvram_gozila_get("submit_type");%>'>
<input type=hidden name=gui_action>
<input type=hidden name=sel_count>
<input type=hidden name=sel_type>
<input type=hidden name=sel_init value=0>
<input type=hidden name=log_refresh>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(viewlog.title));</script></TR>
  <TR><TD colspan=2>
  <input type=hidden name=all_page_start>
  <script>
	var _name = new Array("20","50","100");
	var bt_list = new Array();
	bt_list[0] = new Array("BT_L","a1",__T(viewlog.refresh),"to_refresh()");
	bt_list[1] = new Array("BT_L","a2",__T(viewlog.clear),"to_clear()");
	bt_list[2] = new Array("BT_L","a3",__T(viewlog.save),"to_save()");

	var pagesel = "<TABLE><TR><TD class=BT_SMALL id=a4 onMouseover=chk_action('a4','move') onMouseout=chk_action('a4','out') onMousedown=chk_action('a4','down') onclick='to_prev(\"a4\",1)'><img src=image/First.gif id=cmdfirst></TD>";
        pagesel+="<TD class=BT_SMALL id=a5 onMouseover=chk_action('a5','move') onMouseout=chk_action('a5','out') onMousedown=chk_action('a5','down') onclick='to_prev(\"a5\",0)'><img src=image/Previous.gif id=cmdprev></TD><TD nowrap>";
        pagesel+=__T(share.page)+"&nbsp;<input size=3 id=t8 name=txt_page onBlur='to_page()' onKeyDown='to_page_enter(event)'>&nbsp;"+__T(share.of)+"&nbsp;<SPAN id=page></TD>";
	pagesel+="<TD class=BT_SMALL id=a6 onMouseover=chk_action('a6','move') onMouseout=chk_action('a6','out') onMousedown=chk_action('a6','down') onclick='to_next(\"a6\",0)'><img src=image/Next.gif id=cmdnext></TD>";
        pagesel+="<TD class=BT_SMALL id=a7 onMouseover=chk_action('a7','move') onMouseout=chk_action('a7','out') onMousedown=chk_action('a7','down') onclick='to_next(\"a7\",1)'><img src=image/Last.gif id=cmdlast></TD></TR></TABLE>";

	var pricheck = "<input type=checkbox id=log_pri_1 name=log_pri_1 onClick=check_pri(-1,1)>"+__T(syslog.event_emer)+"<input type=checkbox id=log_pri_2 name=log_pri_2 onClick=check_pri(-1,2)>"+__T(syslog.event_alert)+"<input type=checkbox id=log_pri_3 name=log_pri_3 onClick=check_pri(-1,3)>"+__T(syslog.event_crit)+"<input type=checkbox id=log_pri_4 name=log_pri_4 onClick=check_pri(-1,4)>"+__T(syslog.event_err)+"<input type=checkbox id=log_pri_5 name=log_pri_5 onClick=check_pri(-1,5)>"+__T(syslog.event_warn)+"<input type=checkbox id=log_pri_6 name=log_pri_6 onClick=check_pri(-1,6)>"+__T(syslog.event_noti)+"<input type=checkbox id=log_pri_7 name=log_pri_7 onClick=check_pri(-1,7)>"+__T(syslog.event_info)+"<input type=checkbox id=log_pri_8 name=log_pri_8 onClick=check_pri(-1,8)>"+__T(syslog.event_debug)+"&nbsp;&nbsp;"+draw_object(O_VAR,BT,__T(viewlog.go),"t1","BT","seltype(this.form)");
	
	draw_td(O_GUI,CREATE_EDIT_TABLE,"10,20,10,55",__T(viewlog.tabletitle),__T(viewlog.index)+","+__T(viewlog.time)+","+__T(viewlog.serverity)+","+__T(viewlog.desc),"",bt_list,spell_words(filter_rule,__T(syslog.tablepri))+"&nbsp;&nbsp;"+pricheck,"","1,0,2,0,0",__T(share.showing)+"&nbsp;<SPAN id=data_start> "+start_line+" </SPAN> - <SPAN id=data_end> "+end_line+" </SPAN> "+__T(share.of)+" "+count_entry+"&nbsp;&nbsp;"+draw_object(O_VAR,SELBOX,"selcnt","onChange=select_count(this.form.selcnt.selectedIndex,this.form)",_name,_name)+"&nbsp;&nbsp;"+__T(share.perpage),pagesel);
	// For firefox layout
	chg_layout();
  </script>
	<input type=hidden name=all_page_end>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
