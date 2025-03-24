<html>
<head>
<title>Session Timeout</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var stflg="init";
var idx=0;
var start_line=0, end_line=0, count_entry=0,total_page=0;
var per_page = new Array("5","10");
var td_id = new Array("td_en","td_name","td_desc","td_sun","td_mon","td_tue","td_wed","td_thu","td_fri","td_sat","td_start","td_end","td_act");
var obj_id = new Array("chk_","sch_name","sch_desc","sch_sun","sch_mon","sch_tue","sch_wed","sch_thu","sch_fri","sch_sat","sch_start","sch_end","sch_act");
var sch_data = new Array();
var sch_arr = new Array();
<% get_sch_data(); %>

count_entry = sch_arr.length;
var now_count = "<% nvram_gozila_get("sel_count"); %>";
var now_page = "<% nvram_gozila_get("txt_page"); %>";
var selflg = "<% nvram_gozila_get("selflg"); %>";
if ( now_count == "(null)" ) now_count = "";
if ( now_page == "(null)") now_page = "";
if ( stflg == "(null)" ) stfflg = "init";
//alert("now_count="+now_count+";now_page="+now_page);
if ( now_count == "" && now_page == "" ) 
{
	start_line = 1;
	end_line=5;
	total_page = parseInt(sch_arr.length/5,10)+((sch_arr.length%5)!=0?1:0);
}else
	total_page = parseInt(sch_arr.length/now_count,10)+((sch_arr.length%now_count)!=0?1:0);

if ( now_count != "" ) 
{
	if ( now_count > sch_arr.length ) 
		end_line = sch_arr.length;
	else 
		end_line = now_count;
	start_line = 1;	
}

if ( now_page != "" ) 
{
	if ( now_count == "" ) 
	{
		now_count = 5;
		total_page = parseInt(sch_arr.length/now_count,10)+((sch_arr.length%now_count)!=0?1:0);
	}
	start_line = (now_page-1)*now_count+1;	
	end_line =  now_page * now_count;
	if ( sch_arr.length < end_line ) end_line = sch_arr.length;
}
if ( selflg == "1" ) now_page = "1";

function fill_nvdata(i)
{
	sch_data[i] = new Array();
	sch_data[i][0] = "<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>";
	sch_data[i][1] = sch_arr[i][0];
	sch_data[i][2] = sch_arr[i][1];
	for(var j=0; j<7; j++){
		var chkflg = sch_arr[i][2].charAt(j)=="1"?"checked":"";
		sch_data[i][3+j] = "<input type=checkbox id="+obj_id[3+j]+i+" name="+obj_id[3+j]+i+" "+chkflg+" disabled>";
	}
	sch_data[i][10] = sch_arr[i][3];
	sch_data[i][11] = sch_arr[i][4];
	sch_data[i][12] = sch_arr[i][5]=="1"?__T(share.enabled):__T(share.disabled);
}

function show_data()
{
	idx = 0;
	for(var i=start_line-1; i<end_line; i++)
        {
                if ( i == sch_arr.length ) break; 
                fill_nvdata(i);
                var data = new Array();
                data[0] = new Array(td_id[0]+idx, sch_data[i][0],3);
                for(var j=0; j<12; j++)
                {
                        if ( j==0 || j==1 || j==9 || j==10 ) 
                                data[1+j] = new Array(td_id[1+j]+idx, sch_data[i][1+j]);
                        else
                                data[1+j] = new Array(td_id[1+j]+idx, sch_data[i][1+j],3);
                }
                add_row(idx,data,"chk_",stflg,2);
                idx++;
        }
}

function init(){
	var F = document.frmweb;
	parent.document.getElementById("save_bg").style.display="none";
	chg_type(document.frmweb);
	F.txt_page.value = now_page==""?1:now_page;
	document.getElementById("page").innerHTML = total_page;
	if ( now_count != "") 
	{
		for(k=0; k<per_page.length; k++)
		{
			if ( now_count == per_page[k] ) 
			{
				F.selcnt[k].selected = true;
				break;
			}
		}
	}
	show_data(idx);
	default_nv = keep_val(document.frmweb,"");
}

function to_cate(F)
{
	F.submit_button.value = "category";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function to_except(F)
{
	F.submit_button.value = "except";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function get_sch_data(F)
{
	var real_idx = 0,cnt=0;
	var tmp="", returnval="";
	if ( stflg == "add" || stflg == "edit" ) 
	{
		for(var i=0; i<WEBSCHEDULE_ENTRY; i++)
		{
			if( document.getElementById(obj_id[1]+i) != null ) 
			{
				if ( !chk_before_data(i) ) return "";
				var real_idx = parseInt(F.selcnt.value,10)*(parseInt(F.txt_page.value,10)-1)+i+1;
				//if ( tmp != "" ) tmp = ";";
//				if ( stflg == "edit" ) tmp += real_idx+",";
				tmp = document.getElementById(obj_id[12]+i).checked == true?"1":"0";
				var tmp_time = document.getElementById(obj_id[10]+i).value.split(":");
				tmp += ","+tmp_time[0]+","+tmp_time[1];
				var tmp_time = document.getElementById(obj_id[11]+i).value.split(":");
				tmp += ","+tmp_time[0]+","+tmp_time[1];
				var week_time = "";
				for(var j=0; j<7; j++)
					week_time += document.getElementById(obj_id[3+j]+i).checked == true?"1":"0";
				tmp += ","+week_time;
				tmp += ","+ document.getElementById(obj_id[1]+i).value.length;
				tmp += ","+ document.getElementById(obj_id[1]+i).value;
				tmp += ","+ document.getElementById(obj_id[2]+i).value.length;
				tmp += ","+ document.getElementById(obj_id[2]+i).value;
				if ( cnt > 0 ) returnval += ";";
				if ( stflg == "edit" ) returnval += real_idx+","; 
				returnval += tmp.length+","+tmp;
				cnt++;
			}
		}
		return returnval;
	}else if ( stflg == "del" ) 
	{
		for(var i=0; i<WEBSCHEDULE_ENTRY; i++)
		{
		 	if (document.getElementById("tr_table"+i) == null ) continue;
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
			{
				var real_idx = parseInt(F.selcnt.value,10)*(parseInt(F.txt_page.value,10)-1)+i+1;
				if ( tmp != "" ) tmp += " ";
				tmp+=real_idx;
				
			}
		}
		return tmp;
	}
	return "";
}

function uiDoSave(F)
{
	F.stflg.value = stflg;
	if ( F._webrep.checked == true ) F.wf_reputation.value = 1;
	else F.wf_reputation.value = 0;
	if ( F.enhttps.checked == true ) F.wf_https_enable.value = 1;
	else F.wf_https_enable.value = 0;
	F.wf_schtb.value = get_sch_data(F);
	//alert(F.wf_schtb.value);
	//if ( F.wf_schtb.value == "" ) return;
	F.submit_button.value = "webfilter";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function is_check_domain(val)
{
        clear_msg("wan_domain","_wan_domain");
        if ( val != "" && !check_domain(val) ) 
        {       
                my_alert(O_VAR,"wan_domain",__T(msg.validname),"0","_wan_domain");
                return false;
                
        }
        return true;
}

var keep_st = 2;

function chg_type(F)
{
	
	if ( "<% nvram_get("webfilter_first_enable"); %>" == "1" && F.wf_enable[2].checked == false ) 
	{
		var url = goto_link('license.asp');
		var license_win = self.open(url,'aboutTable','toolbars=no,memubar=no,resizable=no,scrollbars=yes,directories=no,status=no,location=no,width=600,height=540',"_blank");
		for(var i=0; i<3; i++)
		{
			if ( F.wf_enable[i].checked == true ) 
				keep_st = i;
		}
		F.wf_enable[2].checked = true;
		parent.document.getElementById("save_bg").style.display="";
		
	}else{
		if ( F.wf_enable[0].checked == true ) 
		{
			HIDDEN_PART("TR","starton","endon", 0);	 
			document.getElementById("sch").style.display="none";
			
		}else if ( F.wf_enable[1].checked == true ){
			HIDDEN_PART("TR","starton","endon", 0);	 
			document.getElementById("sch").style.display="";
		}else{
			HIDDEN_PART("TR","starton","endon", 1);	 
			document.getElementById("sch").style.display="none";
		}
	}
}

var running=0;

function agreelicense(st)
{
	if ( running == 0 ) 
	{
		running=1;
		var F = document.frmweb;
		if ( st != 1 ) 
		{
			parent.document.getElementById("save_bg").style.display="none";
			F.wf_enable[2].checked = true;
			running=0;
		}else{
			F.wf_enable[keep_st].checked = true;
			F.webfilter_first_enable.value = "0";
			F.submit_button.value = "webfilter";
			F.gui_action.value = "Apply";
			F.submit();
		}
	}
}

function chk_time_format(data)
{
	if ( data == "" ) return -1;
	var time_data = data.split(":");
	if ( (time_data[0] && chk_chartype(time_data[0],DIGIT)) &&
	     (time_data[1] && chk_chartype(time_data[1],DIGIT))){
		if ( time_data[0] > 24 || time_data[1] > 59 ) return -1;
		return parseInt(time_data[0],10)*60+parseInt(time_data[1],10);
	}
	return -1;
}

function chk_before_data(index)
{
	var errflg = 0 ;
	if ( index < 0 ) return true;
	if ( document.getElementById(obj_id[1]+index) ) 
	{
		clear_table_msg("tmsg","img_name"+index,obj_id[1]+index,index);
		if ( document.getElementById(obj_id[1]+index).value == "" ) 
		{
			table_msg("img_name"+index,obj_id[1]+index,"div_name"+index,index,__T(msg.notblank));
			errflg++;
		}
		clear_table_msg("tmsg","img_desc"+index,obj_id[2]+index,index);
		if ( document.getElementById(obj_id[2]+index).value == "" ) 
		{
			table_msg("img_desc"+index,obj_id[2]+index,"div_desc"+index,index,__T(msg.notblank));
			errflg++;
		}
		clear_table_msg("tmsg","img_start"+index,obj_id[10]+index,index);
		var stime = chk_time_format(document.getElementById(obj_id[10]+index).value);
		if ( stime < 0 ) 
		{
			table_msg("img_start"+index,obj_id[2]+index,"div_start"+index,index,__T(msg.illegal));
			errflg++;
		}
		clear_table_msg("tmsg","img_end"+index,obj_id[11]+index,index);
		var etime = chk_time_format(document.getElementById(obj_id[11]+index).value);
		//alert("stime="+stime+";etime="+etime);
		if ( etime < 0 ) 
		{
			table_msg("img_end"+index,obj_id[2]+index,"div_end"+index,index,__T(msg.illegal));
			errflg++;
		}
		if ( stime > 0 && etime > 0 && stime > etime ) 
		{
			table_msg("img_start"+index,obj_id[2]+index,"div_start"+index,index,__T(msg.timechk));
			errflg++;
		}
		if ( errflg != 0 ) return false;
	}
	return true; 
}

function to_del()
{
	stflg="del";
	disable_page();
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
			document.getElementById("tr_table"+i).className = "TABLECONTENT_DEL";	
	}
	choose_disable(document.getElementById("a2"));
	choose_disable(document.getElementById("a3"));
}

function to_edit()
{
	var F = document.frmweb;
	stflg = "edit";
	var real_idx = 0;
	disable_page();
	for(var i=0; i<F.selcnt.value; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null ) 
		{
			var real_idx = parseInt(F.selcnt.value,10)*(parseInt(F.txt_page.value,10)-1)+i;
			var data = new Array();
	      		data[0] = "<input type=checkbox id="+obj_id[0]+i+" name="+obj_id[0]+i+" onclick=chk_click('"+i+"') checked>";
			data[1]=draw_td(O_VAR,ICONLINE,"img_name"+i,"<input size=51 maxlength=64 id="+obj_id[1]+i+" onMouseMove=showHint('img_name"+i+"','div_name"+i+"',event) onMouseOut=hideHint('div_name"+i+"') value="+sch_arr[real_idx][0]+">","div_name"+i);
			data[2]=draw_td(O_VAR,ICONLINE,"img_desc"+i,"<input size=51 maxlength=64 id="+obj_id[2]+i+" onMouseMove=showHint('img_desc"+i+"','div_desc"+i+"',event) onMouseOut=hideHint('div_desc"+i+"') value="+sch_arr[real_idx][1]+">","div_desc"+i);
			for(var j=0; j<7; j++)
			{
				var chkflg = sch_arr[real_idx][2].charAt(j)=="1"?"checked":"";
				data[3+j]="<input type=checkbox id="+obj_id[3+j]+i+" name="+obj_id[3+j]+i+" "+chkflg+">";
			}
			data[10]=draw_td(O_VAR,ICONLINE,"img_start"+i,"<input size=10 maxlength=5 id="+obj_id[10]+i+" onMouseMove=showHint('img_start"+i+"','div_start"+i+"',event) onMouseOut=hideHint('div_start"+i+"') value="+sch_arr[real_idx][3]+">","div_start"+i);
			data[11]=draw_td(O_VAR,ICONLINE,"img_end"+i,"<input size=10 maxlength=5 id="+obj_id[11]+i+" onMouseMove=showHint('img_end"+i+"','div_end"+i+"',event) onMouseOut=hideHint('div_end"+i+"') value="+sch_arr[real_idx][4]+">","div_end"+i);
			var chkflg = sch_arr[real_idx][5]=="1"?"checked":"";
			data[12]="<input type=checkbox id="+obj_id[12]+i+" name="+obj_id[12]+i+" "+chkflg+">";
			edit_row(td_id,data,i);
		}
	}
}

function chk_click(index)
{
	
	var newidx = parseInt(index + ( (now_page-1)*now_count),10);
	var count=0;
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,sch_data[newidx]);
	for(var i=0; i<idx; i++){
                if ( document.getElementById("chk_"+i).checked == true ) count++;
        }
	if ( count > 0 ){
		choose_disable(document.getElementById("a2"));
		choose_enable(document.getElementById("a4"));
		choose_enable(document.getElementById("a3"));
	}else{
		choose_enable(document.getElementById("a2"));
		choose_disable(document.getElementById("a4"));
		choose_disable(document.getElementById("a3"));
	}
}

function goto_last_page(F)
{
	stflg = "add";
	var scnt = F.selcnt.value;
	if ( sch_arr.length != 0 && sch_arr.length > end_line ) 
	{
		var delcnt = end_line-start_line+1;
		for(var i=0; i<delcnt; i++)
			document.getElementById("_table").deleteRow(2);
		
		if ( end_line != sch_arr.length ) 
		{
			start_line = (total_page-1)*scnt+1;
			end_line = (total_page*scnt)>sch_arr.length?sch_arr.length:(total_page*scnt);
			show_data();
		}
		else{
			idx=0;
		}
	}
	add_new_row(F);
}

function get_real_idx()
{
	var cnt=sch_arr.length;
	for(var i=0; i<WEBSCHEDULE_ENTRY; i++)
	{
		if( document.getElementById(obj_id[1]+i) != null ) 
			cnt++;
	}
	return cnt;
}

function to_add()
{
	var F = document.frmweb;
	var keepidx = get_real_idx();
	if ( keepidx >= WEBSCHEDULE_ENTRY ) 
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,WEBSCHEDULE_ENTRY,__T(filter.schedules)),"");
		return false;
	}
	if ( stflg != "add" ) 
		goto_last_page(F);
	else
		add_new_row(F);
}

function disable_page()
{
	var F = document.frmweb;
	choose_disable(F.selcnt);
	choose_disable(F.txt_page);
}

function add_new_row(F)
{
	disable_page();
	if ( !chk_before_data(idx-1) ) return;
	var tmp = new Array();
	tmp[0]=new Array(td_id[0]+idx,"<input type=checkbox id="+obj_id[0]+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,"img_name"+idx,"<input size=51 maxlength=64 id="+obj_id[1]+idx+" onMouseMove=showHint('img_name"+idx+"','div_name"+idx+"',event) onMouseOut=hideHint('div_name"+idx+"')>","div_name"+idx),1);
	tmp[2]=new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,"img_desc"+idx,"<input size=51 maxlength=64 id="+obj_id[2]+idx+" onMouseMove=showHint('img_desc"+idx+"','div_desc"+idx+"',event) onMouseOut=hideHint('div_desc"+idx+"')>","div_desc"+idx),1);
	tmp[3]=new Array(td_id[3]+idx,"<input type=checkbox id="+obj_id[3]+idx+">",3);
	tmp[4]=new Array(td_id[4]+idx,"<input type=checkbox id="+obj_id[4]+idx+">",3);
	tmp[5]=new Array(td_id[5]+idx,"<input type=checkbox id="+obj_id[5]+idx+">",3);
	tmp[6]=new Array(td_id[6]+idx,"<input type=checkbox id="+obj_id[6]+idx+">",3);
	tmp[7]=new Array(td_id[7]+idx,"<input type=checkbox id="+obj_id[7]+idx+">",3);
	tmp[8]=new Array(td_id[8]+idx,"<input type=checkbox id="+obj_id[8]+idx+">",3);
	tmp[9]=new Array(td_id[9]+idx,"<input type=checkbox id="+obj_id[9]+idx+">",3);
	tmp[10]=new Array(td_id[10]+idx,draw_td(O_VAR,ICONLINE,"img_start"+idx,"<input size=10 maxlength=5 id="+obj_id[10]+idx+" onMouseMove=showHint('img_start"+idx+"','div_start"+idx+"',event) onMouseOut=hideHint('div_start"+idx+"')>","div_start"+idx),1);
	tmp[11]=new Array(td_id[11]+idx,draw_td(O_VAR,ICONLINE,"img_end"+idx,"<input size=10 maxlength=5 id="+obj_id[11]+idx+" onMouseMove=showHint('img_end"+idx+"','div_end"+idx+"',event) onMouseOut=hideHint('div_end"+idx+"')>","div_end"+idx),1);
	tmp[12]=new Array(td_id[12]+idx,"<input type=checkbox id="+obj_id[12]+idx+">",3);
	add_row(idx,tmp,"chk_","add",2);
	idx++;
}

function select_count(selidx,F)
{
	F.sel_count.value = F.selcnt[selidx].value;
	F.selflg.value = 1;
	F.change_action.value="gozila_cgi";
	F.submit_button.value="webfilter";
	F.submit();
}

function to_next(obj,flag)
{
        var F = document.frmweb;
        var set_page;

	if( F.txt_page.disabled == true ) return;
         
	if( (  obj == "a6" && document.getElementById("cmdnext").src.indexOf("image/Next-D.gif")!=-1 ) ||
            (  obj == "a7" && document.getElementById("cmdlast").src.indexOf("image/Last-D.gif")!=-1 ))
                return;
        
	if(flag)
                set_page = total_page;
        else
                set_page = parseInt(F.txt_page.value,10)+1;
        if(set_page > total_page) return;
        F.txt_page.value = set_page;
	F.change_action.value="gozila_cgi";
	F.submit_button.value="webfilter";
	F.submit();

}

function to_prev(obj,flag)
{
        var F = document.frmweb;
        var set_page;
	
	if( F.txt_page.disabled == true ) return;
        
	if ( (  obj == "a4" && document.getElementById("cmdfirst").src.indexOf("image/First-D.gif")!=-1 ) ||
             (  obj == "a5" && document.getElementById("cmdprev").src.indexOf("image/Previous-D.gif")!=-1 ) )
                return;
 
        if(flag)
                set_page = 1;
        else
                set_page = parseInt(F.txt_page.value,10)-1;

        if(set_page < 1) return;
        F.txt_page.value = set_page;
	F.change_action.value="gozila_cgi";
	F.submit_button.value="webfilter";
	F.submit();
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
	F.change_action.value="gozila_cgi";
	F.submit_button.value="webfilter";
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

        document.getElementById("hidden_chkbox").style.display="none"; 
}

function msghint(flg)
{
	if ( flg == 0 ) 
		document.getElementById("httpsmsg").style.display="none";
	else
		document.getElementById("httpsmsg").style.display="";
}

function all_chk()
{
	var cnt=0;
	var newidx = 0;
        for(var i=0; i<idx; i++){
                if ( document.getElementById("chk_"+i) == null ) continue;
                if ( document.getElementById("chk_all").checked == true )
                {
                        document.getElementById("chk_"+i).checked = true;
                        cnt++;
                }
                else
                        document.getElementById("chk_"+i).checked = false;
		newidx = parseInt(i+( (now_page-1)*now_count),10);
                to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,sch_data[newidx]);
        }       
        if ( cnt > 1 ) choose_disable(document.getElementById("a2"));
        if ( count == 0 ) choose_disable(document.getElementById("a2"));
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmweb method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=wf_reputation>
<input type=hidden name=wf_schtb>
<input type=hidden name=wf_https_enable>
<input type=hidden name=stflg>
<input type=hidden name=selflg>
<input type=hidden name=wait_time value=5>
<input type=hidden name=webfilter_first_enable>
<input type=hidden name=sel_count value="<% nvram_gozila_get("sel_count"); %>">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.webfilter),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.webfilter));</script>
		<script>
		var _name=new Array(__T(filter.alwayson),__T(filter.scheduled),__T(filter.alwaysoff));
		var _val=new Array("enable","schedule","disable");
		draw_object(O_GUI,RADIO,"wf_enable",_val,_name,"<% nvram_get("wf_enable"); %>", "onclick=chg_type(this.form)");
		</script></TD></TR>
		<TR id=starton><script>draw_td(O_GUI,SUBTITLE,__TC(filter.webreputation));</script>
		<input type=checkbox name=_webrep <% nvram_match("wf_reputation","1","checked"); %>><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		draw_object(O_GUI,BT,__T(filter.categories),"c1","BT","to_cate(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<TABLE><TR><TD>
		<input type=checkbox name=enhttps <% nvram_match("wf_https_enable","1","checked"); %>><script>Capture(filter.enhttps);</script>
		</TD><TD valign=center><img src=image/question-mark-vs.png onmouseover=msghint(1) onmouseout=msghint(0)><div class=MSG-DIV id=httpsmsg style=display:none><script>Capture(filter.httpstext);</script></div></TD></TR></TABLE>
		</TD></TR>
		<TR id=sch><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		var pagesel = "<TABLE><TR><TD class=BT_SMALL id=a4 onMouseover=chk_action('a4','move') onMouseout=chk_action('a4','out') onMousedown=chk_action('a4','down') onclick='to_prev(\"a4\",1)'><img src=image/First.gif id=cmdfirst></TD>";
	        pagesel+="<TD class=BT_SMALL id=a5 onMouseover=chk_action('a5','move') onMouseout=chk_action('a5','out') onMousedown=chk_action('a5','down') onclick='to_prev(\"a5\",0)'><img src=image/Previous.gif id=cmdprev></TD><TD nowrap>";
	        pagesel+=__T(share.page)+"&nbsp;<input size=3 id=t8 name=txt_page value=1 onBlur='to_page()' onKeyDown='to_page_enter(event)'>&nbsp;"+__T(share.of)+"&nbsp;<SPAN id=page></TD>";
	        pagesel+="<TD class=BT_SMALL id=a6 onMouseover=chk_action('a6','move') onMouseout=chk_action('a6','out') onMousedown=chk_action('a6','down') onclick='to_next(\"a6\",0)'><img src=image/Next.gif id=cmdnext></TD>";
	        pagesel+="<TD class=BT_SMALL id=a7 onMouseover=chk_action('a7','move') onMouseout=chk_action('a7','out') onMousedown=chk_action('a7','down') onclick='to_next(\"a7\",1)'><img src=image/Last.gif id=cmdlast></TD></TR></TABLE>";
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,15,15,5,5,5,5,5,5,5,10,10,10",__T(filter.scheduletb),"<input type=checkbox onclick=all_chk() name=chk_all id=chk_all>,"+__T(filter.sname)+","+__T(viewlog.desc)+","+__T(filter.ssun)+","+__T(filter.smon)+","+__T(filter.stue)+","+__T(filter.swed)+","+__T(filter.sthu)+","+__T(filter.sfri)+","+__T(filter.ssat)+","+__T(filter.webstart)+","+__T(filter.webend)+","+__T(router.active),"add,edit,del","","","","2,0,0,2,2,2,2,2,2,2,0,0,2",__T(share.showing)+"&nbsp;<SPAN id=data_start> "+start_line+" </SPAN> - <SPAN id=data_end> "+end_line+" </SPAN> "+__T(share.of)+" "+count_entry+"&nbsp;&nbsp;"+draw_object(O_VAR,SELBOX,"selcnt","onChange=select_count(this.form.selcnt.selectedIndex,this.form)",per_page,per_page)+"&nbsp;&nbsp;"+__T(share.perpage),pagesel);
		</script>
		</TD></TR>
		<TR id=endon><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		draw_object(O_GUI,BT,__T(filter.exceptions),"c2","BT","to_except(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
		</TD></TR>
		</TABLE>
  </TD></TR>
  <% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
