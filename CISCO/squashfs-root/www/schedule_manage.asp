<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
single_tb="true";
var datalist = new Array();
var sch_list = new Array();
<% get_schedule_list("get"); %>
var td_id = new Array("schname","week","stime","etime");
CHK_VALUE_AUTO=0;
var idx=0;
var stflg = "init";
if ( "<% nvram_gozila_get("backname"); %>" != "" ) 
{
	var back_bt="true";
	var change_cancel_bt="true";
}

function get_data(F)
{
	var data = "";
	for(var i=0; i<idx; i++)
	{
                if ( stflg == "del" )
		{
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
			{
				if ( data != "" ) data += ",";
				data += i;
			}
		}
				
	}
	return data;
}

function chk_click(index){
	var chkitem=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
			chkitem++;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,sch_list[index]);
	if ( chkitem > 1 ) 
		choose_disable(document.getElementById("t3"));
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var week_name = new Array(__T(filter.mon),__T(filter.tue),__T(filter.wed),__T(filter.thu),__T(filter.fri),__T(filter.sat),__T(filter.sun));
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0]);
		var get_days = "",get_stime="",get_etime="";
		if ( datalist[i][1] == "1111111" ) 
			get_days = __T(filter.alldays);
		else{
			for(var j=0; j<7; j++)
			{
				var ch = datalist[i][1].charAt(j);
				if ( ch == "1" )
				{
					if ( get_days != "" ) get_days += ", ";
					get_days+=week_name[j];
				}
				
			}
		}
		
		if ( datalist[i][2] == "0:0" && datalist[i][3] == "23:59" ) 
		{
			get_stime = get_etime = __T(filter.alltimes);
		}else{
			if ( flg_24 == 0 )
			{ 
				var stime = datalist[i][2].split(":");
				var sh,eh="";
				var type = __T(mang.am);
				if ( parseInt(stime[0],10) >= 12 ) 
				{
					type = __T(mang.pm);
					sh = parseInt(stime[0],10)-12;
				}else
					sh = parseInt(stime[0],10);
				if ( sh == 0 ) sh = "12";
				if ( parseInt(stime[1],10) < 10 ) 
					eh = "0"+ parseInt(stime[1],10);
				else
					eh = parseInt(stime[1],10);
				get_stime = sh+":"+eh+" "+type;
				var etime = datalist[i][3].split(":");
				type = __T(mang.am);
				if ( parseInt(etime[0],10) >= 12 ) 
				{
					type = __T(mang.pm);
					sh = parseInt(etime[0],10)-12;
				}else
					sh = parseInt(etime[0],10);
				if ( sh == 0 ) sh = "12";
				if ( parseInt(etime[1],10) < 10 ) 
					eh = "0"+ parseInt(etime[1],10);
				else
					eh = parseInt(etime[1],10);
				get_etime = sh+":"+eh+" "+type;
			}else{
				get_stime = datalist[i][2];
				get_etime = datalist[i][3];
			}
		}
		sch_list[i] = new Array(datalist[i][0],get_days,get_stime,get_etime);
		tmp[2]=new Array(td_id[1]+idx,get_days);
		tmp[3]=new Array(td_id[2]+idx,get_stime);
		tmp[4]=new Array(td_id[3]+idx,get_etime);
		tmp[5]=new Array("","&nbsp;",0);
		add_row(idx,tmp,"chk_",stflg,2);
		//add_row(idx,tmp,"chk_",stflg,"showHint('img"+idx+"','div"+idx+"',event)","hideHint('div"+idx+"')",2);
		idx++;
	}
	default_nv = get_data(document.frmsch);
}

function to_edit(index)
{
	var F = document.frmsch;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			F.now_idx.value = i;
			break;
		}
	}
	F.submit_button.value = "schedule_manage_edit";
	F.change_action.value = "gozila_cgi";
	F.stflg.value = "edit";
	F.submit();
	
}

function to_add()
{
	var F = document.frmsch;
	if ( idx >= FIREWALL_ENTRY )
	{
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,FIREWALL_ENTRY,__T(filter.schedules)));
		return;
	} 
	F.submit_button.value = "schedule_manage_edit";
	F.change_action.value = "gozila_cgi";
	F.now_idx.value = idx;
	F.stflg.value = "add";
	F.submit();
}

function to_del(){
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			del_row(i);
		}
	}
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("schedule_manage.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	var str,data="";
	var errflg = 0;
	for(var i=0; i<idx; i++)
	{
		if (document.getElementById("tr_table"+i) == null ) continue;
                if ( stflg == "del" )
                {
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
                        {
				if ( parseInt(datalist[i][4],10) > 0 ) 
				{
					document.getElementById("tdchk_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"') checked onMouseMove=showHint('img"+i+"','div"+i+"',event) onMouseOut=hideHint('div"+i+"')>","div"+i);
					errflg=1;
					table_msg("img"+i,"","div"+i,i,__T(msg.rulereserved));
				}else{
					if ( F.schtb_del.value != "" ) F.schtb_del.value+=",";
					F.schtb_del.value += i;
				}
                        }
                }
	}
	if ( errflg == 0 ) 
	{
		F.submit_button.value = "schedule_manage";
		F.gui_action.value="Apply";
		F.stflg.value = stflg;
		F.submit();
		if ( http_from == "wan" ) 
	        {
        		setTimeout("chk_st()", 15000);
	        }
		parent.document.getElementById("save_bg").style.display="";
	}
}

function chkall(F)
{
	for(var i=0; i<idx; i++)
	{
		if ( F.chk_all.checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,sch_list[i]);
		
	}
	choose_disable(document.getElementById("t3"));
 
}

function refresh_page(){
	var F = document.frmsch;
	alert_result(0);
	F.submit_button.value = "schedule_manage";
	F.change_action.value= "gozila_cgi";
	F.backname.value = "<% nvram_gozila_get("backname"); %>";
	F.submit();
}

function to_back(F)
{
	change_cancel_bt="false";
	//get_position("<% nvram_gozila_get("backname"); %>",1);
	parent.document.getElementById("newpage").value = "<% nvram_gozila_get("backname"); %>";
	uiDoCancel(F,"back");
	//document.location.replace(goto_link("<% nvram_gozila_get("backname"); %>"));
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmsch method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=now_idx>
<input type=hidden name=schtb_del>
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.schmang));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,45,10,10",__T(filter.scheduletb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(filter.sname)+","+__T(filter.sdays)+","+__T(vpn.stime)+","+__T(vpn.etime),"add,edit,del","","","","2,0,0,0,0");
		</script>
		
      </TD>
  </TR>
  <% web_include_file("BT.asp"); %>
</TABLE>
</form>
</div></TABLE></TD></TR>
</body></HTML>
