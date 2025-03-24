<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
CHK_VALUE_AUTO=0;
idx=0;
single_tb="true";
var stflg="init";
var datalist = new Array();
<% get_ipv6adv_data("datalist"); %>
var obj_idx=new Array("_sel_","_sid_","_prefix_","_plen_","_plt_");
var img_idx=new Array("img_sel_","img_sid_","img_prefix_","img_plen_","img_plt_");
var div_idx=new Array("div_sel_","div_sid_","div_prefix_","div_plen_","div_plt_");
var tdid = new Array("tdseltype_","tdsid_","tdprefix_","tdplen_","tdplt_");
var ptype= new Array(__T(router.glblocal),__T(router.type6to4));
var wan_ipv4 = "<% nvram_get("wan_ipaddr"); %>"

function get_data(F)
{
	var data = "";
	for(var i=0; i<idx; i++)
	{
		for(j=1; j<obj_idx.length; j++)
		{
			if ( document.getElementById(obj_idx[j]+i) ) 
				data += document.getElementById(obj_idx[j]+i).value; 
			else
				data += document.getElementById(tdid[j]+i).innerHTML;
			if ( j != obj_idx.length-1 )
				data += ",";
		}
	}
	return data;
}

function to_del(){
	stflg="del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i) )
		{
			if ( document.getElementById("chk_"+i).checked == true ) 
				del_row(i);
		}
	}		
}
function to_edit()
{
	stflg="edit";
	var _name = new Array(__T(router.type6to4),__T(router.glblocal));
	var _val = new Array("1","0");
	var tmp="";
	var fieldlist= new Array();
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i) )
		{
			if ( document.getElementById("chk_"+i).checked == true && document.getElementById("_sel_"+i) == null)
			{
				tmp = "";
				tmp = document.getElementById(tdid[0]+i).innerHTML;		
				if ( tmp == __T(router.type6to4) ) tmp = "1" ; 
				else tmp = "0";
			
				fieldlist[0] = draw_object(O_VAR,SELBOX,"sel_type id='"+obj_idx[0]+i+"'","onChange=chgtype("+i+")",_name,_val,tmp);
				tmp = "";
				tmp = document.getElementById(tdid[1]+i).innerHTML;
				fieldlist[1] = fun_create_obj(1,i,"<input size=5 maxlegth=4 id='"+obj_idx[1]+i+"' name=sid_"+i+" onBlur=SLAID_blur('"+obj_idx[1]+i+"','"+IPV6_SLAID_START+"','"+IPV6_SLAID_TO+"','"+div_idx[1]+i+"','"+img_idx[1]+i+"','"+i+"') onMouseMove=showHint('"+img_idx[1]+i+"','"+div_idx[1]+i+"',event) onMouseOut=hideHint('"+div_idx[1]+i+"') value="+tmp+">");
				tmp = "";
				tmp = document.getElementById(tdid[2]+i).innerHTML;
				fieldlist[2] = fun_create_obj(2,i,"<input size=30 id="+obj_idx[2]+i+" name=prefix_"+i+" onMouseMove=showHint('"+img_idx[2]+i+"','"+div_idx[2]+i+"',event) onMouseOut=hideHint('"+div_idx[2]+i+"') value="+tmp+">");

				tmp = "";
				//tmp = parseInt(parseInt(document.getElementById(tdid[3]+i).innerHTML,10)/60);
				tmp = document.getElementById(tdid[3]+i).innerHTML;
				fieldlist[3] = fun_create_obj(3,i,"<input size=10 value='"+tmp+"' id="+obj_idx[3]+i+" name=plen_"+i+" onBlur=my_valid_range('"+obj_idx[3]+i+"','"+IPV6_PREFIXLEN_START+"','"+IPV6_PREFIXLEN_TO+"','"+div_idx[3]+i+"','"+img_idx[3]+i+"','"+i+"') onMouseMove=showHint('"+img_idx[3]+i+"','"+div_idx[3]+i+"',event) onMouseOut=hideHint('"+div_idx[3]+i+"') value="+tmp+">");
				tmp = "";
				tmp = document.getElementById(tdid[4]+i).innerHTML;
				fieldlist[4] = fun_create_obj(4,i,"<input size=10 id="+obj_idx[4]+i+" name=plt_"+i+" onBlur=my_valid_range('"+obj_idx[4]+i+"','"+IPV6_PREFIX_LIFETIME_START+"','"+IPV6_PREFIX_LIFETIME_TO+"','"+div_idx[4]+i+"','"+img_idx[4]+i+"','"+i+"') onMouseMove=showHint('"+img_idx[4]+i+"','"+div_idx[4]+i+"',event) onMouseOut=hideHint('"+div_idx[4]+i+"') value="+tmp+">");
				edit_row(tdid,fieldlist,i);
				if ( document.getElementById(obj_idx[0]+i).value == "1" ){
					choose_disable(document.getElementById(obj_idx[2]+i));
					choose_disable(document.getElementById(obj_idx[3]+i));
					auto_fill_prefix(obj_idx[1]+i,i,"object");
				}else{
					choose_disable(document.getElementById(obj_idx[1]+i));
				}
			}
		}
			
	}
}

function chk_all(){
	if ( stflg == "add" ){
		document.getElementById("chkall").checked = false;
		choose_disable(document.getElementById("chkall"));
		return;
	} 
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i) ) 
		{
			if ( document.getElementById("chkall").checked == true ) 
				document.getElementById("chk_"+i).checked = true;
			else
				document.getElementById("chk_"+i).checked = false;
		}
		//to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,tdid,datalist[i]);
		var data = new Array();
		for(var j=0; j<datalist[i].length; j++)
	        {
        	        if( j == 0 ) 
                	        data[j] = ptype[datalist[i][j]];
	                else if ( j == 4 ) 
        	                data[j] = parseInt(parseInt(datalist[i][j],10)/60);
	                else
        	                data[j] = datalist[i][j];
	        }
        	to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,tdid,data);
		if ( datalist[i][0] == "1" ) 
			auto_fill_prefix(tdid[2]+i,i,"txt");
	}
}

function to_chk(index){
	document.getElementById("chkall").checked = false;
	var data = new Array();
	for(var i=0; i<datalist[index].length; i++)
	{
		if( i == 0 ) 
			data[i] = ptype[datalist[index][i]];
		else if ( i == 4 ) 
			data[i] = parseInt(parseInt(datalist[index][i],10)/60);
		else
			data[i] = datalist[index][i];
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,tdid,data);
	if ( datalist[index][0] == "1" ) 
		auto_fill_prefix(tdid[2]+index,index,"txt");
}

function chgtype(index){
	if ( document.getElementById("_sel_"+index).selectedIndex == "0" ){ //6to4
		choose_disable(document.getElementById("_prefix_"+index));
		choose_disable(document.getElementById("_plen_"+index));
		document.getElementById("_prefix_"+index).value = "";
		document.getElementById("_plen_"+index).value = "";
		choose_enable(document.getElementById("_sid_"+index));
	}else{
		choose_enable(document.getElementById("_prefix_"+index));
		choose_enable(document.getElementById("_plen_"+index));
		choose_disable(document.getElementById("_sid_"+index));
		document.getElementById("_sid_"+index).value = "";
	}
}

function chk_before_data(index){
	var errflg=0;
	if ( document.getElementById(obj_idx[0]+index)  )
	{
		if ( document.getElementById(obj_idx[0]+index).selectedIndex == 1 ) // Globa/Local 
		{
			clear_table_msg("tmsg",img_idx[2]+index,obj_idx[2]+index,index);
			if ( my_valid_range(obj_idx[3]+index,IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO,div_idx[3]+index,img_idx[3]+index,index) == false ) errflg=1;
			var errmsg = valid_ipv6(document.getElementById(obj_idx[2]+index).value);
			if ( errmsg != "" ) 
			{
				table_msg(img_idx[2]+index,obj_idx[2]+index,div_idx[2]+index,index,errmsg);
				errflg=1;
			}
		}else{
			if ( my_valid_range(obj_idx[1]+index,IPV6_SLAID_START,IPV6_SLAID_TO,div_idx[1]+index,img_idx[1]+index,index) == false ) errflg=1
		}
		if ( my_valid_range(obj_idx[4]+index,IPV6_PREFIX_LIFETIME_START,IPV6_PREFIX_LIFETIME_TO,div_idx[4]+index,img_idx[4]+index,index) == false ) errflg = 1 ;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function SLAID_blur(obj_id,start,end,div_id,img_id,index)
{
	
	if ( my_valid_range(obj_id,start,end,div_id,img_id,index) && 
	     document.getElementById("_sel_"+index).selectedIndex == "0" )
		auto_fill_prefix(obj_id,index,"object");
}

function auto_fill_prefix(obj_id,index,flg)
{
	var tmp = wan_ipv4.split(".");
	var tmpstr="";
		tmpstr = "2002:";
		tmpstr+=parseInt(tmp[0],10).toString(16);
		if ( parseInt(tmp[1],10).toString(16) < 10 ) 
			tmpstr+="0"+parseInt(tmp[1],10).toString(16);
		else
			tmpstr+=parseInt(tmp[1],10).toString(16);
		tmpstr+=":";
		tmpstr+=parseInt(tmp[2],10).toString(16);
		if ( parseInt(tmp[3],10).toString(16) < 10 ) 
			tmpstr+="0"+parseInt(tmp[3],10).toString(16);
		else
			tmpstr+=parseInt(tmp[3],10).toString(16);
		if ( flg == "object" ) 
		{
			tmpstr+=":"+document.getElementById(obj_id).value+"::";
			document.getElementById(obj_idx[2]+index).value = tmpstr;
			document.getElementById(obj_idx[3]+index).value = "64";
		}else{
			tmpstr+=":"+document.getElementById(tdid[1]+index).innerHTML+"::";
			document.getElementById(tdid[2]+index).innerHTML = tmpstr;
			document.getElementById(tdid[3]+index).innerHTML = "64";
		}
}

function my_valid_range(obj_id,start,end,div_id,img_id,index)
{
	var show_start=start;
	var show_end=end;
	var reval,th=10;
	if ( obj_id.substring(0,5) == "_sid_" )
	{
		var show_end=end.toString(16);
		th=16;
	}
	if ( !msg_chk_range(document.getElementById(obj_id).value,obj_id,start,end,th,IS_TABLE,"tmsg",img_id,div_id,index) ) 
		return false;
	return true;
}

function fun_create_obj(itemid,index,data,textalign){
	if (typeof textalign != "undefined" )
		return draw_td(O_VAR,ICONLINE,img_idx[itemid]+index,data,div_idx[itemid]+index,"",textalign);
	else
		return draw_td(O_VAR,ICONLINE,img_idx[itemid]+index,data,div_idx[itemid]+index);
}

function to_add()
{
	if ( idx >= IPV6_ADVPREFIX_ENTRY ){
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,IPV6_ADVPREFIX_ENTRY,__T(ipv6.advprefixes)));
		return;	
	}
	stflg = "add";
	if ( !chk_before_data(idx-1)) return false;
	var tmp=new Array();
	var _name = new Array(__T(router.type6to4),__T(router.glblocal));
	var _val = new Array("1","0");
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" name=chk_"+idx+" disabled onClick=to_chk('"+idx+"')>",3);
	tmp[1]=new Array(tdid[0]+idx,draw_object(O_VAR,SELBOX,"sel_type id='"+obj_idx[0]+idx+"'","onChange=chgtype("+idx+")",_name,_val),3);
	tmp[2]=new Array(tdid[1]+idx,fun_create_obj('1',idx,"<input size=5 maxlegth=4 id="+obj_idx[1]+idx+" maxlength=4 name=sid_"+idx+" onBlur=SLAID_blur('"+obj_idx[1]+idx+"','"+IPV6_SLAID_START+"',IPV6_SLAID_TO,'"+div_idx[1]+idx+"','"+img_idx[1]+idx+"','"+idx+"') onMouseMove=showHint('"+img_idx[1]+idx+"','"+div_idx[1]+idx+"',event) onMouseOut=hideHint('"+div_idx[1]+idx+"')>","align=right"),2);
	tmp[3]=new Array(tdid[2]+idx,fun_create_obj('2',idx,"<input size=51 maxlength=39 id="+obj_idx[2]+idx+" name=prefix_"+idx+" onMouseMove=showHint('"+img_idx[2]+idx+"','"+div_idx[2]+idx+"',event) onMouseOut=hideHint('"+div_idx[2]+idx+"')>"),1);
	tmp[4]=new Array(tdid[3]+idx,fun_create_obj('3',idx,"<input size=10 id="+obj_idx[3]+idx+" name=plen_"+idx+" onBlur=my_valid_range('"+obj_idx[3]+idx+"','"+IPV6_PREFIXLEN_START+"','"+IPV6_PREFIXLEN_TO+"','"+div_idx[3]+idx+"','"+img_idx[3]+idx+"','"+idx+"') onMouseMove=showHint('"+img_idx[3]+idx+"','"+div_idx[3]+idx+"',event) onMouseOut=hideHint('"+div_idx[3]+idx+"')>","align=right"),2);
	tmp[5]=new Array(tdid[4]+idx,fun_create_obj('4',idx,"<input size=10 id="+obj_idx[4]+idx+" name=plt_"+idx+" onBlur=my_valid_range('"+obj_idx[4]+idx+"','"+IPV6_PREFIX_LIFETIME_START+"','"+IPV6_PREFIX_LIFETIME_TO+"','"+div_idx[4]+idx+"','"+img_idx[4]+idx+"','"+idx+"') onMouseMove=showHint('"+img_idx[4]+idx+"','"+div_idx[4]+idx+"',event) onMouseOut=hideHint('"+div_idx[4]+idx+"')>","align=right"),0);
	tmp[6] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	chgtype(idx);		
	idx++;
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var tmpdata = new Array();
	for(var i=0; i<datalist.length; i++)
	{
		for(var j=0; j<6; j++)
		{
			if ( j == 0 ) 
			{
				tmpdata[j] = new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" name=chk_"+idx+" onClick=to_chk('"+idx+"')>",3);
			}
			else
			{
				if ( j == 1 ) 
					tmpdata[j] = new Array(tdid[j-1]+idx,ptype[datalist[i][j-1]],3);
				else if ( j == 5 ) 
					tmpdata[j] = new Array(tdid[j-1]+idx,parseInt(parseInt(datalist[i][j-1],10)/60),2);
				else
				{
					if ( j == 2 || j == 4) 		
						tmpdata[j] = new Array(tdid[j-1]+idx,datalist[i][j-1],2);
					else
						tmpdata[j] = new Array(tdid[j-1]+idx,datalist[i][j-1]);
				}
			}
		}
		tmpdata[6] = new Array("","&nbsp;");
		add_row(idx,tmpdata,"chk_",stflg,2);		
		if ( document.getElementById(tdid[0]+idx).innerHTML == __T(router.type6to4) )
			auto_fill_prefix(obj_idx[1]+idx,idx,"txt");
		idx++;
	}
	default_nv = get_data(document.frmadv);
}

function uiDoSave(F){
	var count=0;
	var errflg = 0 ; 
	F.prefix_list.value="";
	for(var i=0; i<idx; i++)
	{
		if ( stflg == "del" ) 
		{
			if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) continue; 
		}
		if ( !chk_before_data(i)) errflg = 1;
		if ( errflg == 0 ) fill_nv(F,i);
	}
	if ( errflg == 0 ) 
	{
		if ( F.prefix_list.value == "" ) F.prefix_list.value = "none";
		F.submit_button.value="adv_prefixes";
		F.gui_action.value="Apply";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}
	
function fill_nv(F,i)
{
	var stype="";
	if ( F.prefix_list.value != "" ) F.prefix_list.value+=";";
	for(k=0; k<obj_idx.length; k++)
	{
		if ( k>0 ) F.prefix_list.value+=",";
		if ( document.getElementById(obj_idx[k]+i) == null )
		{
			if ( tdid[k] == "tdseltype_" ) 
			{
				if ( document.getElementById(tdid[k]+i).innerHTML == __T(router.type6to4) ){
					stype="1";
					F.prefix_list.value += "1";
				}else{
					stype="0";
					F.prefix_list.value += "0";
				}
			}
			else if ( tdid[k] == "tdplt_" ) 
			{
				var tmp="0";
				if ( parseInt(document.getElementById(tdid[k]+i).innerHTML,10) > 0 ) 
					tmp =  parseInt(document.getElementById(tdid[k]+i).innerHTML,10)*60;
				if ( tmp == "" )
					F.prefix_list.value += " ";
				else
					F.prefix_list.value += tmp;
			}
			else
			{
				var tmp =  document.getElementById(tdid[k]+i).innerHTML;
				if ( stype == "1" && ( k==2 || k==3 ) ) tmp = "";
				if ( tmp == "" )
					F.prefix_list.value += " ";
				else
					F.prefix_list.value += tmp;
			}
		}
		else
		{
			
			var tmp =  document.getElementById(obj_idx[k]+i).value;
			if ( document.getElementById(obj_idx[0]+i).selectedIndex == 0 && ( k==2 || k==3 ) ) tmp = "";
			if ( k == 4 ) 
			{
				if ( parseInt(document.getElementById(obj_idx[k]+i).value,10) > 0 ) 
					tmp = parseInt(document.getElementById(obj_idx[k]+i).value,10)*60;
				else
					tmp = "0";
			}
			if ( tmp == "" )
				F.prefix_list.value += " ";
			else 
				F.prefix_list.value += tmp;
		}
	}
	for(var i=0; i<3; i++)//for hidden page 
	{
		F.prefix_list.value+=",";
		if (typeof datalist[0] != "undefined" ) 
			F.prefix_list.value += datalist[0][i+5];
		else
			F.prefix_list.value += " ";
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmadv" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=prefix_list> 
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.advprefixes));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,15,10,30,15,15",__T(ipv6.advprefixestb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(ipv6.prefixtype)+","+__T(ipv6.slaid)+","+__T(ipv6.prefix)+","+__T(ipv6.prefixlen)+","+__T(ipv6.prefixlifetime)+"","add,edit,del","","","","2,2,1,0,1,1");
		</script>
  </TD></TR>
  		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
