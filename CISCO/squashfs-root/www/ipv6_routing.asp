<html>
<head>
<title>IPv6 Static Routing</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
CHK_VALUE_AUTO=0;
single_tb="true";
var td_id=new Array("td_name","td_dest","td_plen","td_gw","td_iface","td_metric","td_active");
var obj_id=new Array("name","dest","plen","gw","iface","metric","active");
var div_id=new Array("div_name","div_dest","div_plen","div_gw","div_iface","div_metric","div_active");
var img_id=new Array("img_name","img_dest","img_plen","img_gw","img_iface","img_metric","img_active");
var stflg="init";
var idx=0;
var datalist = new Array();
<% show_ipv6_routing(); %>
var m_arr = new Array(__T(share.disable),__T(share.enable));
var _name = new Array(__T(lan.lan),__T(wan.wan),__T(router.type6to4));

function get_data(F)
{
	var tmpstr = "";
	var tmpdelstr = "";
	for(var i=0; i<idx; i++)
	{
		if ( stflg == "del" && document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL") 
		{
			//if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
			//continue;
			if ( tmpdelstr != "" ) tmpdelstr+=" ";
			if( document.getElementById(obj_id[6]+i) ) 
			{
				if( document.getElementById(obj_id[6]+i).checked == true ) 
					tmpdelstr += "1,";
				else
					tmpdelstr += "0,";
			}else{
				for(var j=0; j<m_arr.length; j++)
				{
					if ( m_arr[j] == document.getElementById(td_id[6]+i).innerHTML ) 
					{
						tmpdelstr += j+",";
						break;
					}
				}
			}
			if( document.getElementById(obj_id[1]+i) ) 
				tmpdelstr += document.getElementById(obj_id[1]+i).value+",";
			else
				tmpdelstr += document.getElementById(td_id[1]+i).innerHTML+",";
			if( document.getElementById(obj_id[2]+i) ) 
				tmpdelstr += document.getElementById(obj_id[2]+i).value+",";
			else
				tmpdelstr += document.getElementById(td_id[2]+i).innerHTML+",";
			if( document.getElementById(obj_id[4]+i) ) 
				tmpdelstr += document.getElementById(obj_id[4]+i).value+",";
			else
			{
				for(var j=0; j<_name.length; j++)
				{
					if ( _name[j] == document.getElementById(td_id[4]+i).innerHTML ) 
					{
						tmpdelstr += j+",";
						break;
					}
				}
			}
			if( document.getElementById(obj_id[3]+i) ) 
				tmpdelstr += document.getElementById(obj_id[3]+i).value+",";
			else
				tmpdelstr += document.getElementById(td_id[3]+i).innerHTML+",";
			if( document.getElementById(obj_id[5]+i) ) 
				tmpdelstr += document.getElementById(obj_id[5]+i).value+";";
			else
				tmpdelstr += document.getElementById(td_id[5]+i).innerHTML+";";
			if( document.getElementById(obj_id[0]+i) ) 
				tmpdelstr += document.getElementById(obj_id[0]+i).value;
			else
				tmpdelstr += document.getElementById(td_id[0]+i).innerHTML;
		}else{
			if ( tmpstr != "" ) tmpstr+=" ";
			if( document.getElementById(obj_id[6]+i) ) 
			{
				if( document.getElementById(obj_id[6]+i).checked == true ) 
					tmpstr += "1,";
				else
					tmpstr += "0,";
			}else{
				for(var j=0; j<m_arr.length; j++)
				{
					if ( m_arr[j] == document.getElementById(td_id[6]+i).innerHTML ) 
					{
						tmpstr += j+",";
						break;
					}
				}
			}
			if( document.getElementById(obj_id[1]+i) ) 
				tmpstr += document.getElementById(obj_id[1]+i).value+",";
			else
				tmpstr += document.getElementById(td_id[1]+i).innerHTML+",";
			if( document.getElementById(obj_id[2]+i) ) 
				tmpstr += document.getElementById(obj_id[2]+i).value+",";
			else
				tmpstr += document.getElementById(td_id[2]+i).innerHTML+",";
			if( document.getElementById(obj_id[4]+i) ) 
				tmpstr += document.getElementById(obj_id[4]+i).value+",";
			else
			{
				for(var j=0; j<_name.length; j++)
				{
					if ( _name[j] == document.getElementById(td_id[4]+i).innerHTML ) 
					{
						tmpstr += j+",";
						break;
					}
				}
			}
			if( document.getElementById(obj_id[3]+i) ) 
				tmpstr += document.getElementById(obj_id[3]+i).value+",";
			else
				tmpstr += document.getElementById(td_id[3]+i).innerHTML+",";
			if( document.getElementById(obj_id[5]+i) ) 
				tmpstr += document.getElementById(obj_id[5]+i).value+";";
			else
				tmpstr += document.getElementById(td_id[5]+i).innerHTML+";";
			if( document.getElementById(obj_id[0]+i) ) 
				tmpstr += document.getElementById(obj_id[0]+i).value;
			else
				tmpstr += document.getElementById(td_id[0]+i).innerHTML;
		}
	}
	if (tmpdelstr == "")
		tmpdelstr = "NULL";
	if (tmpstr == "")
		tmpstr = "NULL";
	F.static_ipv6_route.value=tmpstr+'#'+tmpdelstr+'#';
	return tmpstr;
}

function uiDoSave(F){
	var errflg = 0 ;
	for(var i=0; i<idx; i++)
	{
		if ( !before_check(i) ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
	if ( !chk_duplicate())return false;
	get_data(F);
	F.submit_button.value = "ipv6_routing";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_del(){
	stflg="del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) 
			del_row(i);
	}
}
function to_edit()
{
	stflg="edit";
	var tmp = new Array();
	var _val = new Array("0","1","2");
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
		        tmp[0] = draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=10 maxlength=32 id="+obj_id[0]+i+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') onblur=chk_blank('0','"+i+"') value="+datalist[i].name+">",div_id[0]+i);
			tmp[1] = draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=10 maxlength=128 id="+obj_id[1]+i+" onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') onblur=chk_blank('1','"+i+"') value="+datalist[i].dest+">",div_id[1]+i);
		        tmp[2] = draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=5 maxlength=3 id="+obj_id[2]+i+" onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"')  onBlur=my_valid_range(IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO,'2','"+i+"') value="+datalist[i].plen+">",div_id[2]+i);
		        tmp[3] = draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input size=10 maxlength=128 id="+obj_id[3]+i+" onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') onblur=chk_blank('3','"+i+"') value="+datalist[i].gw+">",div_id[3]+i);
		        tmp[4] = draw_object(O_VAR,SELBOX,"sel_type id='"+obj_id[4]+i+"'","",_name,_val,datalist[i].iface);
		        tmp[5] = draw_td(O_VAR,ICONLINE,img_id[5]+i,"<input size=5 maxlength=2 id="+obj_id[5]+i+" onMouseMove=showHint('"+img_id[5]+i+"','"+div_id[5]+i+"',event) onMouseOut=hideHint('"+div_id[5]+i+"')  onBlur=my_valid_range(IPV6_METRIC_START,IPV6_METRIC_TO,'5','"+i+"') value="+datalist[i].metric+">",div_id[5]+i);
			var chkflg="";
			if ( datalist[i].active == "1" ) chkflg = "checked";
		        tmp[6] = "<input type=checkbox id="+obj_id[6]+i+" name="+obj_id[6]+i+" "+chkflg+">";
		        edit_row(td_id,tmp,i);
		}
	}
}

function to_chk(index){
	var tmp = new Array();
	var obj_name = new Array("name","dest","plen","gw","iface","metric","active");
	for(var i=0; i<obj_name.length; i++)
	{
		if ( obj_name[i] == "iface" ) 
			tmp[i] = _name[eval("datalist[index]."+obj_name[i])] ;
		else if ( obj_name[i] == "active" ) 
			tmp[i] = m_arr[eval("datalist[index]."+obj_name[i])] ;
		else
			tmp[i] = eval("datalist[index]."+obj_name[i]) ;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,tmp);
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
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,datalist[i]);
	}	
		
}

function get_entry(index,getname)
{
	var getstr="";
	for(var i=1; i<=5; i++)
	{
		if ( getstr != "" ) getstr +=",";
		if ( document.getElementById(obj_id[1]+index) )
		{
			if ( getname == 1 ) return document.getElementById(obj_id[0]+index).value;
			getstr +=  document.getElementById(obj_id[i]+index).value;
		}
		else{
			if ( getname == 1 ) return document.getElementById(td_id[0]+index).innerHTML;
			if ( i == 4 ){
				if ( document.getElementById(td_id[i]+index).innerHTML == __T(lan.lan)) 
					getstr += "0";
				else if ( document.getElementById(td_id[i]+index).innerHTML == __T(wan.wan)) 
					getstr += "1";
				else if ( document.getElementById(td_id[i]+index).innerHTML == __T(router.type6to4)) 
					getstr += "2";
					
			}else
				getstr +=  document.getElementById(td_id[i]+index).innerHTML;
		}
	}
	return getstr;
}

function chk_duplicate()
{
	var tmpstri="", tmpstrj="";
	var tmpnamei="", tmpnamej="";
	var errflg=0;
	for(var i=0; i<idx; i++)
	{
		tmpnamei=get_entry(i,1);
		tmpstri = get_entry(i);
		for(var j=i+1; j<idx; j++)
		{
			tmpnamej=get_entry(j,1);
			tmpstrj = get_entry(j);
			if ( tmpnamei == tmpnamej ) 
			{
				if( document.getElementById(obj_id[0]+j) ) 
					table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j,__T(msg.nameexist));	
				if( document.getElementById(obj_id[0]+i) ) 
					table_msg(img_id[0]+i,obj_id[0]+i,div_id[0]+i,i,__T(msg.nameexist));	
				errflg=1;
			}
//			alert("tmpstri="+tmpstri+"\ntmpstrj="+tmpstrj);
			if ( !errflg && (tmpstri == tmpstrj) ) 
			{
				if( document.getElementById(obj_id[0]+j) ) 
					table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j,__T(msg.rulereserved));	
				if( document.getElementById(obj_id[0]+i) ) 
					table_msg(img_id[0]+i,obj_id[0]+i,div_id[0]+i,i,__T(msg.rulereserved));	
				errflg=1;
			}
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function before_check(index)
{
	var errflg=0;
	var errmsg = "";
	if ( document.getElementById(obj_id[0]+index) )
	{
		if ( !chk_name(index) ) errflg = 1;
		if ( !chk_blank(1,index) ) errflg = 1;
		errmsg =  valid_ipv6(document.getElementById(obj_id[1]+index).value);
		if ( errmsg != "" ) 
		{
			table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,errmsg);	
			errflg = 1;
		}
		errmsg = "";
		errmsg =  valid_ipv6(document.getElementById(obj_id[3]+index).value);
		if ( errmsg != "" ) 
		{
			table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,errmsg);	
			errflg = 1;
		}
		if ( !my_valid_range(IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO,2,index) ) errflg = 1;
		if ( !my_valid_range(IPV6_METRIC_START,IPV6_METRIC_TO,5,index) ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function my_valid_range(start,to,oid,index)
{
	if ( !msg_chk_range(document.getElementById(obj_id[oid]+index).value,obj_id[oid]+index,start,to,10,IS_TABLE,"tmsg",img_id[oid]+index,div_id[oid]+index,index) ) 
		return false;
	return true;
}

function chk_name(index)
{
	if ( !chk_blank(0,index) ) return false;
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id[0]+index).value,ZERO_NO|SPACE_NO,obj_id[0]+index);
	if ( returnmsg != "" ) 
	{
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,returnmsg);	
		return false;
	}
	return true;
}

function chk_blank(oid,index){
	var F = document.frmrouting_v6;
	if ( document.getElementById(obj_id[oid]+index) )
	{
		clear_table_msg("tmsg",img_id[oid]+index,obj_id[oid]+index,index);
		if ( document.getElementById(obj_id[oid]+index).value == "" )
		{
			table_msg(img_id[oid]+index,obj_id[oid]+index,div_id[oid]+index,index,__T(msg.notblank));	
			return false;
		}	
	}
	return true;
}

function to_add()
{
	if ( !chk_duplicate() ) return;
	if ( !before_check(idx-1) ) return ;
	if ( idx >= IPV6_STATIC_ROUTING_ENTRY )
	{
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,IPV6_STATIC_ROUTING_ENTRY,__T(ipv6.staticroutes)));
		return;
	} 
	stflg="add";
	var tmp = new Array();
	var _val = new Array("0","1","2");
	tmp[0] = new Array("td_chk"+idx,"<input type=checkbox id=chk_"+idx+" name=chk_"+idx+" disabled onClick=to_chk('"+idx+"')>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=10 maxlength=32 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"') onblur=chk_name('"+idx+"')>",div_id[0]+idx),1);
	tmp[2] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=51 maxlength=39 id="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"') onblur=chk_blank('1','"+idx+"')>",div_id[1]+idx),1);
	tmp[3] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=5 maxlength=3 id="+obj_id[2]+idx+" onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"')  onBlur=my_valid_range(IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO,'2','"+idx+"')>",div_id[2]+idx,"","align=right"),1);
	tmp[4] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=51 maxlength=39 id="+obj_id[3]+idx+" onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"') onblur=chk_blank('3','"+idx+"')>",div_id[3]+idx),1);
	tmp[5] = new Array(td_id[4]+idx,draw_object(O_VAR,SELBOX,"sel_type id='"+obj_id[4]+idx+"'","",_name,_val),3);
	tmp[6] = new Array(td_id[5]+idx,draw_td(O_VAR,ICONLINE,img_id[5]+idx,"<input size=5 maxlength=2 id="+obj_id[5]+idx+" onMouseMove=showHint('"+img_id[5]+idx+"','"+div_id[5]+idx+"',event) onMouseOut=hideHint('"+div_id[5]+idx+"')  onBlur=my_valid_range(IPV6_METRIC_START,IPV6_METRIC_TO,'5','"+idx+"')>",div_id[5]+idx,"","align=right"),1);
	tmp[7] = new Array(td_id[6]+idx,"<input type=checkbox id="+obj_id[6]+idx+" name="+obj_id[6]+idx+">",3);
	tmp[8] = new Array("","&nbsp",0);
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;	
}
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0] = new Array("td_chk"+idx,"<input type=checkbox id=chk_"+idx+" name=chk_"+idx+" onClick=to_chk('"+idx+"')>");
		tmp[1] = new Array(td_id[0]+idx,datalist[i].name,0);
		tmp[2] = new Array(td_id[1]+idx,datalist[i].dest,0);
		tmp[3] = new Array(td_id[2]+idx,datalist[i].plen,2);
		tmp[4] = new Array(td_id[3]+idx,datalist[i].gw,0);
		tmp[5] = new Array(td_id[4]+idx,_name[datalist[i].iface],3);
		tmp[6] = new Array(td_id[5]+idx,datalist[i].metric,2);
		tmp[7] = new Array(td_id[6]+idx,m_arr[datalist[i].active],3);
		tmp[8] = new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;	
	}
	default_nv = get_data(document.frmrouting_v6);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmrouting_v6" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=static_ipv6_route>
<input type=hidden name=static_ipv6_name>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.staticrouting));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,15,15,12,15,10,15,8",__T(ipv6.staticroutestb),"<input type=checkbox id=chk_all onclick=chkall()>,"+__T(share.name)+","+__T(ipv6.dest)+","+__T(ipv6.prefixlen2)+","+__T(share.gateway)+","+__T(share.iface)+","+__T(ipv6.metric)+","+__T(ipv6.active),"add,edit,del","","","","2,0,0,1,0,2,1,2");
		</script>
  </TD></TR>
  <% web_include_file("BT.asp"); %>
  </TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
