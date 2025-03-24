<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
CHK_VALUE_AUTO=0;
single_tb="true";
var idx=0;
var stflg="init";
var define_backname="filter.asp";
var datalist = new Array();
<% get_schedule_list("get"); %>
var iap_list = new Array();
<% get_iap_list("data"); %>
var newdatalist = new Array();
var td_id = new Array("tden","tdname","tdacc","tdday","tdtime");
var action_name= new Array(__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
function to_del(){
	stflg = "del";
        var error_flg = 0 ;
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                {
                                del_row(i);
                }
        }
}

function get_data(F)
{
	var data = "";
	for(var i=0; i<idx; i++)
	{
		 if (document.getElementById("tr_table"+i) == null ) continue;
	         if ( stflg == "del" ){
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
                        {
				if ( data != "" ) data +=",";
				data += i;
			}
		}
	}
	return data;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("filter.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	F.iap_del.value = get_data(F);
	F.submit_button.value = "filter";
	F.gui_action.value = "Apply";
	F.stflg.value=stflg;
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}

function to_edit()
{
	var selindex=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			selindex=i;
			break;
		}
	}
	var F = document.frmiap;
	F.selidx.value = selindex;
	F.stflg.value = "edit";
	F.submit_button.value = "filter_edit";
	F.change_action.value = "gozila_cgi";
	F.submit();
	
}
function to_add()
{
	if ( idx >= FILTER_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,FILTER_ENTRY,__T(filter.IAP)),"");
                return false;
        }
	var F = document.frmiap;
	F.selidx.value = idx;
	F.stflg.value = "add";
	F.submit_button.value = "filter_edit";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function init()
{
	var SKU="<% nvram_get("sysinfo_pid"); %>";
	parent.document.getElementById("save_bg").style.display="none";
	
	for(var i=0; i<iap_list.length; i++)
	{
		newdatalist[i] = new Array();
		newdatalist[i][0] = iap_list[i][0]=="1"?__T(filter.yes):__T(filter.no);
		newdatalist[i][1] = iap_list[i][3];
		newdatalist[i][2] = action_name[iap_list[i][1]];
		for(var j=0; j<datalist.length; j++)
		{
			if ( datalist[j][0] == iap_list[i][2] ) 
			{
			var tmpday = "", tmptime = "";
			var week_name = new Array(__T(filter.mon),__T(filter.tue),__T(filter.wed),__T(filter.thu),__T(filter.fri),__T(filter.sat),__T(filter.sun));
			if ( datalist[j][1] == "1111111" ) tmpday = __T(filter.alldays);
			else{
				for(var k=0; k<week_name.length; k++)
				{
					if ( datalist[j][1].charAt(k) == '1' ){
						if ( tmpday != "" ) tmpday +=", ";
						 tmpday+=week_name[k];
					}
				}
			} 
			if ( datalist[j][2] == "0:0" && datalist[j][3] == "23:59" ) tmptime = __T(filter.alltimes);
			else{
				if ( flg_24 == 0 ) 
				{
					var stime = datalist[j][2].split(":");
					var sh,eh="";
					var get_days = "",get_stime="",get_etime="";
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
					var etime = datalist[j][3].split(":");
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
					tmptime = get_stime+" ~ "+get_etime;
				}else{
					tmptime = datalist[j][2]+" ~ "+datalist[j][3];
				}
			}
			newdatalist[i][3] = tmpday;
			newdatalist[i][4] = tmptime;
			break;
			}
		}
		if (typeof newdatalist[i][3] == "undefined" ) newdatalist[i][3] = "-";
		if (typeof newdatalist[i][4] == "undefined" ) newdatalist[i][4] = "-";
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"')>",3);
		tmp[1]=new Array(td_id[0]+i,newdatalist[i][0],3);
		tmp[2]=new Array(td_id[1]+i,newdatalist[i][1],0);
		tmp[3]=new Array(td_id[2]+i,newdatalist[i][2],3);
		tmp[4]=new Array(td_id[3]+idx,newdatalist[i][3],0);
		tmp[5]=new Array(td_id[4]+idx,newdatalist[i][4],0);
		tmp[6]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_","init",2);
		idx++;
	}
	default_nv = get_data(document.frmiap);

	if ( "<% nvram_get("wf_enable"); %>" != "disable" && 
             (SKU == "RV130-WB-K9-NA" || SKU == "RV130-WB-K9-G5" || SKU == "RV130W-WB-A-K9-NA" || SKU == "RV130W-WB-E-K9-G5") ) 
		my_alert(O_GUI,INFO,__T(share.info),__T(filter.disiapmsg),"");
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) count++;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,newdatalist[index]);
	if ( count > 1 ) choose_disable(document.getElementById("t3"));
	if ( count == 0 ) choose_disable(document.getElementById("t4"));
		
}

function chkall(F)
{
	var cnt=0;
	for(var i=0; i<idx; i++){
		if ( document.getElementById("chk_"+i) == null ) continue;
		if ( document.getElementById("chk_all").checked == true )
		{
                        document.getElementById("chk_"+i).checked = true;
			cnt++;
		}
                else
                        document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,newdatalist[i]);
	}	
	if ( cnt > 1 ) choose_disable(document.getElementById("t3"));
	if ( count == 0 ) choose_disable(document.getElementById("t4"));
}

function edit_iap(F)
{
	change_cancel_bt="true";
	goto_page("ip_based_acl.asp");
	//get_position("ip_based_acl.asp",1);
	//goto_page("ip_based_acl.asp");
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmiap" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=stflg value=add> 
<input type=hidden name=selidx> 
<input type=hidden name=wait_time value=5> 
<input type=hidden name=iap_del> 
<input type=hidden name=backname>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.IAP));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
  		<TR><script>draw_td(O_GUI,SUBTITLE,__T(filter.cdefoutpolicy)+":");</script>
		  <script>
			var _name = new Array(__T(filter.allow),__T(filter.deny),__T(filter.reject));
                        var _val = new Array("1","0","2");
                        var nv_val = "<% nvram_get("fw_acl_def_policy"); %>";
                        for(var i=0; i<_name.length; i++)
                        {
                                if ( nv_val == _val[i] ) 
                                {
                                        document.write(_name[i]);  
                                        break;
                                }
                        }
		  document.write("<SPAN style='padding-left:30px'>");
		  draw_object(O_GUI,BT,__T(share.edit),"e1","BT","edit_iap(this.form)");
		
		  </script> 
	        </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,25,15,15,15",__T(filter.IAPtb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(share.enabled)+","+__T(filter.policyname)+","+__T(filter.action)+","+__T(def.sday)+","+__T(def.stime),"add,edit,del","","","","2,2,0,2,0,0");
		// For firefox disaled
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		</script>
      </TD>
  </TR>
  </TABLE>
<% web_include_file("BT.asp"); %>
</TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
