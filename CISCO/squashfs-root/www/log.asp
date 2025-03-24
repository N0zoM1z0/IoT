<html>
<head>
<title>Log</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var viewlog_bt = "true";
CHK_VALUE_AUTO=0;
var td_id=new Array("td_service","td_server","td_logevent","td_ram","td_email","td_item");
var obj_id=new Array("_service","_server","logevent","ram","email","item");
var div_id=new Array("div_service","div_server","div_logevent","div_ram","div_email","div_item");
var img_id=new Array("img_service","img_server","img_logevent","img_ram","img_email","img_item");
var stflg="init";
var idx = 0;
var datalist = new Array();
<% show_syslog_ng(); %>

var _service_list = new Array(__T(share.all),__T(syslog.kernel),__T(viewlog.ssystem),__T(wl.wl));
var _service_val = new Array("0","1","2","3");

var _logevent_list = new Array(__T(syslog.event_all),__T(syslog.event_emer),__T(syslog.event_alert),__T(syslog.event_crit),__T(syslog.event_err),__T(syslog.event_warn),__T(syslog.event_noti),__T(syslog.event_info),__T(syslog.event_debug));
var _logevent_val = new Array('0','1','2','3','4','5','6','7','8');
var _logevent_setval = new Array('0','1','2','4','8','16','32','64','128');
var m_arr = new Array(__T(share.disabled),__T(share.enabled));

function chk_enable()
{
	var F = document.log;
	var mode;
	var pri_name = "";
	F.log_enable.value=0;

        if ( F._log_enable.checked == true ) 
        {
		mode = "enable";
		F.log_enable.value=1;

		opensubitem();

		if(idx > 0)
	                DISABLE_PART(F,"all_page_start","all_page_end",0);
        }else{
		mode = "disable";
                DISABLE_PART(F,"all_page_start","all_page_end",1);
        }
        
	if(mode == "enable")
	{
		choose_enable(document.getElementById("_email_alert_enable"));
		choose_enable(document.getElementById("t2"));
                choose_disable(document.getElementById("t3"));
                choose_disable(document.getElementById("t4"));
		
		for(var i=1; i< _logevent_val.length; i++)
		{
			pri_name = "log_pri_"+i;
			choose_enable(document.getElementById(pri_name));
		}
	}
	else
	{
		choose_disable(document.getElementById("_email_alert_enable"));
		choose_disable(document.getElementById("t2"));
                choose_disable(document.getElementById("t3"));
                choose_disable(document.getElementById("t4"));
		for(var i=1; i< _logevent_val.length; i++)
		{
			pri_name = "log_pri_"+i;
			choose_disable(document.getElementById(pri_name));
		}
	}
	//init(F);
}

function init(){
	//Log setting table
	var F = document.log;
	var tmp = new Array();
	var flag;
	var logevent = 0;
	var logevent_str = "";
	var pri_name = "";
	
	parent.document.getElementById("save_bg").style.display = "none";
	//chk_enable();
	//if(idx >= datalist.length)
	//	return;

        if ((datalist.length == 0) && (F._log_enable.checked != true) ) 
	{
		chk_enable();
		return;
	}

	logevent = parseInt(datalist[0].logevent,10);
	if(logevent == 0)
	{
		for(var i = 1; i< _logevent_val.length; i++)
		{
			pri_name = eval("F.log_pri_"+i);
			pri_name.checked = true;
		}
	}
	else
	{
		for(var i=1; i< _logevent_setval.length; i++)
		{
			if((logevent | parseInt(_logevent_setval[i],10)) == logevent)
			{
				pri_name = eval("F.log_pri_"+i);
				if(pri_name != undefined)
					pri_name.checked = true;
			}
		}
	}
	
	default_nv = get_data(document.log);
	for(var i=1; i<datalist.length; i++)
	{
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		if(datalist[i]._server=="\"\"")
			tmp[1] = new Array(td_id[1]+idx,"0.0.0.0");
			//tmp[1] = new Array(td_id[1]+idx,"");
		else
			tmp[1] = new Array(td_id[1]+idx,datalist[i]._server);
	
		logevent_str = "";
		logevent = parseInt(datalist[i].logevent,10);
		for(var j = 1; j<_logevent_val.length;j++)
		{
			if((logevent == 0) ||
			   ((logevent | parseInt(_logevent_setval[j],10)) == logevent))
			{
				if(logevent_str != "")
					logevent_str += ", ";
				logevent_str += _logevent_list[j];
			}
		}
		tmp[2] = new Array(td_id[2]+idx,logevent_str,3);
		tmp[3] = new Array(td_id[5]+idx,m_arr[datalist[i].item],3);
		tmp[4] = new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	chk_enable();
}

function chkall()
{
	if ( stflg == "add" ){
		document.getElementById("chk_all").checked = false;
		choose_disable(document.getElementById("chk_all"));
		return;
	} 
	for(var i=0; i<idx; i++)
	{	
		if ( document.getElementById("chk_"+i) ) 
		{
			if ( document.getElementById("chk_all").checked == true ) 
				document.getElementById("chk_"+i).checked = true;
			else
				document.getElementById("chk_"+i).checked = false;
		}
		var nv_arr = new Array();
		for(var j=0; j<datalist[i].length; j++)
		{
			if(j == 0)
				nv_arr[j] = _service_list[datalist[i][j]];
			else if(i == 1)
				nv_arr[j] = datalist[i][j];
			else if(i == 2)
				nv_arr[j] = _logevent_list[datalist[i][j]];
			else
				nv_arr[j] = datalist[i][j];
		}
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,nv_arr);
	}	
		
}

function chk_click(index){
	var nv_arr = new Array();
	for(var i=0; i<datalist[index].length; i++)
	{
		if(i == 0)
			nv_arr[i] = _service_list[datalist[index][i]];
		else if(i == 1)
			nv_arr[i] = datalist[index][i];
		else if(i == 2)
			nv_arr[i] = _logevent_list[datalist[index][i]];
		else
			nv_arr[i] = datalist[index][i];
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,nv_arr);
}

function clear_all_msg(){
	document.getElementById("page_msg_td").style.display="none";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById(obj_id[1]+i) != null ) 
		{
			clear_table_msg("page_msg_td",img_id[1]+i,obj_id[1]+i,i);
			//clear_table_msg("page_msg_td",img_id[2]+i,obj_id[2]+i,i);
		}
	}
}

function chk_valid_server(index)
{
	var errflg = 0;
	var server;

	if( document.getElementById(obj_id[1]+index) ) //server
		server = document.getElementById(obj_id[1]+index).value;
	else
		server = document.getElementById(td_id[1]+index).innerHTML;

	if((server != "") && !check_ip_domain(server))
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index, index,__T(msg.illegal));
		errflg = 1;
	}
	if ((server != "") && !lan_subnet_mask(server) ) 
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index, index,__T(msg.illegalipformat));
		errflg = 1;
	}
	
	if(errflg == 1) return false;
	return true;
}

function before_check()
{
	var F = document.log;
	var pri_nam = "";
	//var event_idx = 0;
	var errflg=0;
	var server1=0,server2=0,logevent1=0,logevent2=0;
	var ui_logevent = "";
	//var ram1, email1;

	clear_all_msg();
	
	for(var i=0; i<idx;i++)
	{
		if( document.getElementById(obj_id[1]+i) ) //server
			server1 = document.getElementById(obj_id[1]+i).value;
		else
			server1 = document.getElementById(td_id[1]+i).innerHTML;
				
		logevent1 = 0;
		if( document.getElementById(obj_id[2]+i) ) //logevent
			logevent1 = _logevent_list[document.getElementById(obj_id[2]+i).value];
		else
		{
			for(var k=1; k<_logevent_list.length; k++)
			{
				pri_name = eval("F.log_pri_"+i+"_"+k);
				if(pri_name == undefined)
				{
					ui_logevent = document.getElementById(td_id[2]+i).innerHTML;
					if(ui_logevent.indexOf(_logevent_list[k]) != -1)
						logevent1 |= parseInt(_logevent_setval[k]);
				}
				else
				{	
					if(pri_name.checked == true)
						logevent1 |= _logevent_setval[k];
				}
			}
		}

		if((server1 == "") || (server1 == "0.0.0.0"))
		{
			if ( document.getElementById(obj_id[1]+i) )
				table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i, i,__T(msg.illegal));
			else
			{
				if ( document.getElementById("tmsg") ) 
				{
					document.getElementById("tmsg").innerHTML = server1+" "+__T(msg.illegal);
					document.getElementById("tmsg").style.display="";
				}

			}
			errflg = 1;
		}

		if((server1 != "") && !check_ip_domain(server1))
		{
			if ( document.getElementById(obj_id[1]+i) )
				table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i, i,__T(msg.illegal));
			errflg = 1;
		}
		if ((server1 != "") && !lan_subnet_mask(server1) ) 
		{
			if ( document.getElementById(obj_id[1]+i) )
				table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i, i,__T(msg.illegalipformat));
			errflg = 1;
		}

		if(logevent1 <= 0)
		{
			if ( document.getElementById(obj_id[1]+i) )
				table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i, i,__T(msg.setpri));
			errflg = 1;
		}

	
		for(var j=i+1; j<idx; j++)
		{

			if( document.getElementById(obj_id[1]+j) ) //server
				server2 = document.getElementById(obj_id[1]+j).value;
			else
				server2 = document.getElementById(td_id[1]+j).innerHTML;

			if( document.getElementById(obj_id[2]+i) ) //logevent
			{
				logevent2 = _logevent_list[document.getElementById(obj_id[2]+j).value];
			}
			else
			{	
				logevent2 = 0;
				for(var k=1; k<_logevent_list.length; k++)
				{
					pri_name = eval("F.log_pri_"+j+"_"+k);
					if(pri_name == undefined)
					{
						ui_logevent = document.getElementById(td_id[2]+j).innerHTML;;
						if(ui_logevent.indexOf(_logevent_list[k]) != -1)
							logevent2 |= parseInt(_logevent_setval[k]);
					}
					else
					{	
						if(pri_name.checked == true)
							logevent2 |= _logevent_setval[k];
					}
				}
				if(logevent2 <= 0)
				{
					table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j, j,__T(msg.setpri));
					errflg = 1;
				}
			}

			if(server1 == server2)
			{
				//if (logevent1 == logevent2)
				//{
				if( document.getElementById(obj_id[1]+i) ) //server
					table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i, i,__T(msg.valueexist));
				else
					table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j, j,__T(msg.valueexist));
				errflg = 1;				
				//}
			}
		}
	}

	if (document.getElementById("_email_alert_enable").checked == true)
	{
		if ((document.getElementById("_email_alert_wan").checked != true) && (document.getElementById("_email_alert_vpn").checked != true) &&
(document.getElementById("_email_alert_cpu").checked != true) && (document.getElementById("_email_alert_system").checked != true))
		{
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(msg.setent));
			errflg = 1;
		}
	}

	if ( errflg == 1 ) return false;
	return true;
}

function check_pri(table_pri_s,pri_s)
{
	var i=0;
	var pri_name = ""

	if(table_pri_s < 0)
		pri_name = "log_pri_";
	else
		pri_name = "log_pri_"+table_pri_s+"_";
	
	/*if(document.getElementById(pri_name+pri_s).checked == false)
	{
		for( i = 1; i<_logevent_setval.length; i++)
		{
			document.getElementById(pri_name+i).checked = false;
		}
	}
	else
	{*/
		var end_en = pri_s;
		var start_dn = pri_s+1;

		for(i = 1; i <= end_en; i++)
		{
			document.getElementById(pri_name+i).checked = true;
		}
		for(i=start_dn; i < _logevent_setval.length; i++)
		{
			document.getElementById(pri_name+i).checked = false;
		}
		
	//}
}

function to_add()
{
	if ( idx >= SYSLOG_ENTRY )
	{
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,SYSLOG_ENTRY,__T(syslog.entries)));
		return;
	} 
	if ( !before_check() ) return false;
	stflg="add";
	var tmp = new Array();
	tmp[0] = new Array("td_chk"+idx,"<input type=checkbox id=chk_"+idx+" name=chk_"+idx+" disabled onClick=to_chk('"+idx+"')>",3);

	tmp[1] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=15 maxlength=32 id="+obj_id[1]+idx+" onBlur=chk_valid_server('"+idx+"') onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx));
	
	tmp[2] = new Array(td_id[2]+idx,"<input type=checkbox id=log_pri_"+idx+"_1 name=log_pri_"+idx+"_1 onClick=check_pri("+idx+",1)>"+__T(syslog.event_emer)+"<input type=checkbox id=log_pri_"+idx+"_2 name=log_pri_"+idx+"_2 onClick=check_pri("+idx+",2)>"+__T(syslog.event_alert)+"<input type=checkbox id=log_pri_"+idx+"_3 name=log_pri_"+idx+"_3 onClick=check_pri("+idx+",3)>"+__T(syslog.event_crit)+"<input type=checkbox id=log_pri_"+idx+"_4 name=log_pri_"+idx+"_4 onClick=check_pri("+idx+",4)>"+__T(syslog.event_err)+"<input type=checkbox id=log_pri_"+idx+"_5 name=log_pri_"+idx+"_5 onClick=check_pri("+idx+",5)>"+__T(syslog.event_warn)+"<input type=checkbox id=log_pri_"+idx+"_6 name=log_pri_"+idx+"_6 onClick=check_pri("+idx+",6)>"+__T(syslog.event_noti)+"<input type=checkbox id=log_pri_"+idx+"_7 name=log_pri_"+idx+"_7 onClick=check_pri("+idx+",7)>"+__T(syslog.event_info)+"<input type=checkbox id=log_pri_"+idx+"_8 name=log_pri_"+idx+"_8 onClick=check_pri("+idx+",8)>"+__T(syslog.event_debug));

	tmp[3] = new Array(td_id[5]+idx,"<input type=checkbox id="+obj_id[5]+idx+" name="+obj_id[5]+idx+">",3);
	tmp[4] = new Array("","&nbsp;");
	
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;	
}

function to_edit()
{
	var edit_td_id=new Array("td_server","td_logevent","td_item");
	var chkflg="";
	var logevent = 0;
	var logevent_1 = ""; var logevent_2 = ""; var logevent_3 = ""; var logevent_4 = ""; 
	var logevent_5 = ""; var logevent_6 = ""; var logevent_7 = ""; var logevent_8 = "";
	stflg="edit";

	for(var i=0; i<idx; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var tmp = new Array();
			tmp[0] = draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=15 maxlength=32 id="+obj_id[1]+i+" onBlur=chk_valid_server('"+i+"') onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value="+datalist[i+1]._server+">",div_id[1]+i);
			
			logevent = parseInt(datalist[i+1].logevent,10);
			logevent_1 = ""; logevent_2 = ""; logevent_3 = ""; logevent_4 = ""; 
			logevent_5 = ""; logevent_6 = ""; logevent_7 = ""; logevent_8 = "";

			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[1],10)) == logevent))
				logevent_1 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[2],10)) == logevent))
				logevent_2 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[3],10)) == logevent))
				logevent_3 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[4],10)) == logevent))
				logevent_4 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[5],10)) == logevent))
				logevent_5 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[6],10)) == logevent))
				logevent_6 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[7],10)) == logevent))
				logevent_7 = "checked";
			if((logevent == 0) || 
			   ((logevent | parseInt(_logevent_setval[8],10)) == logevent))
				logevent_8 = "checked";

			tmp[1] = new Array("<input type=checkbox id=log_pri_"+i+"_1 name=log_pri_"+i+"_1 onClick=check_pri("+i+",1) "+logevent_1+">"+__T(syslog.event_emer)+"<input type=checkbox id=log_pri_"+i+"_2 name=log_pri_"+i+"_2 onClick=check_pri("+i+",2) "+logevent_2+">"+__T(syslog.event_alert)+"<input type=checkbox id=log_pri_"+i+"_3 name=log_pri_"+i+"_3 onClick=check_pri("+i+",3) "+logevent_3+">"+__T(syslog.event_crit)+"<input type=checkbox id=log_pri_"+i+"_4 name=log_pri_"+i+"_4 onClick=check_pri("+i+",4) "+logevent_4+">"+__T(syslog.event_err)+"<input type=checkbox id=log_pri_"+i+"_5 name=log_pri_"+i+"_5 onClick=check_pri("+i+",5) "+logevent_5+">"+__T(syslog.event_warn)+"<input type=checkbox id=log_pri_"+i+"_6 name=log_pri_"+i+"_6 onClick=check_pri("+i+",6) "+logevent_6+">"+__T(syslog.event_noti)+"<input type=checkbox id=log_pri_"+i+"_7 name=log_pri_"+i+"_7 onClick=check_pri("+i+",7) "+logevent_7+">"+__T(syslog.event_info)+"<input type=checkbox id=log_pri_"+i+"_8 name=log_pri_"+i+"_8 onClick=check_pri("+i+",8) "+logevent_8+">"+__T(syslog.event_debug));
			
			if ( datalist[i+1].item == "1" ) chkflg = "checked";
			tmp[2] = new Array("<input type=checkbox id="+obj_id[5]+i+" name="+obj_id[5]+i+" "+chkflg+">");
			edit_row(edit_td_id,tmp,i);
		}
	}
}

function to_del()
{
	stflg="del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) 
			del_row(i);
	}
}

function get_data(F)
{
	var tmpstr = "";
	var ram_tmpstr = "";
	var pri_name = "";
	var logevent = 0;
	var old_logevent = 0;
	var ui_logevent = "";
	
	tmpstr = "0,\"\",";
	ram_tmpstr = tmpstr;

	logevent = 0;
	old_logevent = 0;
	for(var j=0; j<_logevent_list.length; j++)
	{
		pri_name = eval("F.log_pri_"+j);
		
		if(pri_name == undefined)
		{
			old_logevent = j;
			logevent = j;
		}
		else
		{
			if(j == 0) continue;
			if(pri_name.checked == true)
			{
				logevent |= _logevent_setval[j];
				if(old_logevent == 0)
					old_logevent = _logevent_val[j];
			}
		}
	}
	if((logevent <= 0) && (F._log_enable.checked == true ))
	{
		my_alert(O_GUI,ERROR,__T(share.errmsg),__T(msg.setpri));
		return false;
	}
		
	tmpstr += old_logevent;
	ram_tmpstr += logevent;

	tmpstr += ",1,";
	ram_tmpstr += ",1,";

	if("<% nvram_match("log_email_enable","on","1"); %>" == "1")
	{
		tmpstr += "1,1";
		ram_tmpstr += "1,1";
	}
	else
	{
		tmpstr += "0,1";
		ram_tmpstr += "0,1";
	}


	for(var i=0; i<idx; i++)
	{
		if ( stflg == "del" ) 
		{
			if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
			continue;
		}
		
		if ( tmpstr != "" ) tmpstr += " "; 
		if ( ram_tmpstr != "" ) ram_tmpstr += " ";

		//service all 
		tmpstr += "0,";
		ram_tmpstr += "0,";

		if( document.getElementById(obj_id[1]+i) ) //server
		{
			if(document.getElementById(obj_id[1]+i).value == "")
			{
				tmpstr += "\"\",";
				ram_tmpstr += "\"\",";
			}
			else
			{
				tmpstr += document.getElementById(obj_id[1]+i).value+",";
				ram_tmpstr += document.getElementById(obj_id[1]+i).value+",";
			}
		}
		else
		{
			if(document.getElementById(td_id[1]+i).innerHTML == "") 
			{
				tmpstr += "\"\",";
				ram_tmpstr += "\"\",";
			}
			else
			{
				tmpstr += document.getElementById(td_id[1]+i).innerHTML+",";
				ram_tmpstr += document.getElementById(td_id[1]+i).innerHTML+",";
			}
		}
		
		if( document.getElementById(obj_id[2]+i) ) //logevent
		{
			tmpstr += document.getElementById(obj_id[2]+i).value+",";
		}
		else
		{	
			logevent = 0;
			old_logevent = 0;
			for(var j=1; j<_logevent_list.length; j++)
			{
				pri_name = eval("F.log_pri_"+i+"_"+j);
				if(pri_name == undefined)
				{
					ui_logevent = document.getElementById(td_id[2]+i).innerHTML;
					if(ui_logevent.indexOf(_logevent_list[j]) != -1)
					{
						logevent |= parseInt(_logevent_setval[j]);
						if(old_logevent == 0)
							old_logevent = j;
					}
				}
				else
				{
					if(pri_name.checked == true)
					{
						logevent |= _logevent_setval[j];
						if(old_logevent == 0)
							old_logevent = _logevent_val[j];
					}
				}
			}
		}
		tmpstr += old_logevent;
		ram_tmpstr += logevent;

		//display ram, this setting for server
		tmpstr += ",0,";
		ram_tmpstr += ",0,";
		
		//send to email, this setting for server
		if("<% nvram_match("log_email_enable","on","1"); %>" == "1")
		{
			tmpstr += "1,";
			ram_tmpstr += "1,";
		}
		else 
		{
			tmpstr += "0,";
			ram_tmpstr += "1,";
		}

		//Setting value enable/disable
		//tmpstr += "1";
		//ram_tmpstr += "1";

                if( document.getElementById(obj_id[5]+i) ) //item
                {
                        if( document.getElementById(obj_id[5]+i).checked == true ) 
                        {
                                tmpstr += "1";
                                ram_tmpstr += "1";
                        }
                        else
                        {
                                tmpstr += "0";
                                ram_tmpstr += "0";
                        }
                }else{
                        for(var j=0; j<m_arr.length; j++)
                        {
                                if ( m_arr[j] == document.getElementById(td_id[5]+i).innerHTML ) 
                                {
                                        tmpstr += j;
                                        ram_tmpstr += j;
                                        break;
                                }
                        }
                }
	}
	F.syslog_group.value=tmpstr;
	F.syslog_ram_group.value=ram_tmpstr;
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("log.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	if ( !before_check() ) return false;
	if ( !get_data(F)) return false;
	if ( F._email_alert_enable.checked == true ) 
		F.email_alert_enable.value = "1";
	else
		F.email_alert_enable.value = "0";
	if ( F._email_alert_wan.checked == true ) 
		F.email_alert_wan.value = "1";
	else
		F.email_alert_wan.value = "0";
	if ( F._email_alert_vpn.checked == true ) 
		F.email_alert_vpn.value = "1";
	else
		F.email_alert_vpn.value = "0";
	if ( F._email_alert_cpu.checked == true ) 
		F.email_alert_cpu.value = "1";
	else
		F.email_alert_cpu.value = "0";
	if ( F._email_alert_system.checked == true ) 
		F.email_alert_system.value = "1";
	else
		F.email_alert_system.value = "0";
	F.submit_button.value = "log";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}

function opensubitem()
{
	var F = document.log;

	if(F._email_alert_enable.checked == true)
		DISABLE_PART(F,"sub_page_start","sub_page_end",0);
	else
		DISABLE_PART(F,"sub_page_start","sub_page_end",1);
}

function goto_viewlog()
{
	goto_page("view_logs.asp");
}

</script>
</head>
<body onload=init()>
<FORM id="frm" name=log method=<% get_http_method(); %> action=apply.cgi onsubmit="return false">
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=log_enable>
<input type=hidden name=email_alert_enable>
<input type=hidden name=email_alert_wan>
<input type=hidden name=email_alert_vpn>
<input type=hidden name=email_alert_cpu>
<input type=hidden name=email_alert_system>
<input type=hidden name=syslog_group>
<input type=hidden name=syslog_ram_group>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(syslog.title),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(syslog.conf),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(syslog.mode));</script>
		<input type=checkbox name=_log_enable <% nvram_match("log_enable","1","checked"); %> onclick=chk_enable()>
		<script>Capture(share.enable);</script>
                </TD></TR>
		<input type=hidden name=all_page_start>

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(syslog.logemail));</script>
		<!--input type=checkbox name=log_pri_0 onclick=chk_pri_all("log_pri_")><script>Capture(syslog.event_all);</script-->
		<input type=checkbox id=log_pri_1 name=log_pri_1 onClick=check_pri(-1,1)>
		<script>Capture(syslog.event_emer);</script>
		<input type=checkbox id=log_pri_2 name=log_pri_2 onClick=check_pri(-1,2)>
		<script>Capture(syslog.event_alert);</script>
		<input type=checkbox id=log_pri_3 name=log_pri_3 onClick=check_pri(-1,3)>
		<script>Capture(syslog.event_crit);</script>
		<input type=checkbox id=log_pri_4 name=log_pri_4 onClick=check_pri(-1,4)>
		<script>Capture(syslog.event_err);</script>
		<input type=checkbox id=log_pri_5 name=log_pri_5 onClick=check_pri(-1,5)>
		<script>Capture(syslog.event_warn);</script>
		<input type=checkbox id=log_pri_6 name=log_pri_6 onClick=check_pri(-1,6)>
		<script>Capture(syslog.event_noti);</script>
		<input type=checkbox id=log_pri_7 name=log_pri_7 onClick=check_pri(-1,7)>
		<script>Capture(syslog.event_info);</script>
		<input type=checkbox id=log_pri_8 name=log_pri_8 onClick=check_pri(-1,8)>
		<script>Capture(syslog.event_debug);</script>
                </TD></TR>
		
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(syslog.emailalert));</script>
		<script>
		/*
		var _name = new Array(__T(share.none),__T(syslog.event_emer),__T(syslog.event_alert),__T(syslog.event_crit),__T(syslog.event_err));
		var _val = new Array(0,1,2,3,4);
		draw_object(O_GUI,SELBOX,"email_alert_log_level","",_name,_val,"<% nvram_get("email_alert_log_level");%>");
		*/
		</script>
		<input type=checkbox name=_email_alert_enable id=_email_alert_enable onClick=opensubitem() <% nvram_match("email_alert_enable","1","checked"); %>>
		<script>Capture(share.enable);</script>
		</TD></TR>

		<TR><script>draw_td(O_GUI,SUBTITLE,__T(""));</script>
		<input type=hidden name=sub_page_start>
		<input type=checkbox id=_email_alert_wan name=_email_alert_wan <% nvram_match("email_alert_wan","1","checked"); %>>
		<script>Capture(syslog.emailwan);</script>
		<input type=checkbox id=_email_alert_vpn name=_email_alert_vpn <% nvram_match("email_alert_vpn","1","checked"); %>>
		<script>Capture(syslog.emailvpn);</script>
		<input type=checkbox id=_email_alert_cpu name=_email_alert_cpu <% nvram_match("email_alert_cpu","1","checked"); %>>
		<script>Capture(syslog.emailcpu);</script>
		<input type=checkbox id=_email_alert_system name=_email_alert_system <% nvram_match("email_alert_system","1","checked"); %>>
		<script>Capture(syslog.emailsystem);</script>
		<input type=hidden name=sub_page_end>
		</TD></TR>

	<!--- Log item table-->	
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"7,15,66,7",__T(syslog.tabletitle),"<input type=checkbox id=chk_all onclick=chkall()>,"+__T(syslog.tableserver)+","+__T(syslog.tablepri)+","+__T(share.enable)+"","add,edit,del","","","","2,2,0,2,2,2,2");
		</script>

		</TR>	
	<!--- Log item table-->	
        	</TABLE>
		<input type=hidden name=all_page_end>
		<% web_include_file("BT.asp"); %>
        </TABLE>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
