<html>
<head>
<title></title>
<% web_include_file("filelink.asp"); %>
<script>
CHK_VALUE_AUTO=0;
single_tb="true";
var proto_list = new Array(__T(mang.tcp),__T(mang.udp),__T(mang.both),__T(mang.icmp));
var datalist = new Array();
var td_id = new Array("td_sname","td_proto","td_sport","td_eport");
var obj_id = new Array("sname","proto","sport","eport");
var div_id = new Array("div_sname","div_proto","div_sport","div_eport");
var img_id = new Array("img_sname","img_proto","img_sport","img_eport");
<% get_service_list("get"); %>
if ( "<% nvram_gozila_get("backname"); %>" != "" ) 
{
	var change_cancel_bt="true";
	var back_bt="true";
}

var idx=0;
var stflg="init";

function refresh_page()
{
	alert_result(0);	
	var F = document.frmqos;
	F.submit_button.value = "service_manage";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function to_back(F)
{
	//get_position("<% nvram_gozila_get("backname"); %>",1);
	parent.document.getElementById("newpage").value = "<% nvram_gozila_get("backname"); %>";
	uiDoCancel(F,"back");
}
function MAPWORD(xname,xvalue)
{
        this.name = xname;
        this.val = xvalue;
}

var map_str = new Array();
map_str[0] = new MAPWORD("All Traffic", __T(mang.alltraffic));
map_str[1] = new MAPWORD("HTTP Secondary", __T(mang.httpsec));
map_str[2] = new MAPWORD("HTTPS Secondary", __T(mang.httpssec));
map_str[3] = new MAPWORD("TELNET Secondary", __T(mang.telnetsec));
map_str[4] = new MAPWORD("Voice(SIP)",__T(mang.voicesip));

function replace_transfer(str)
{
	for(var i=0; i<map_str.length; i++)
	{
		if ( str == map_str[i].name ) 
			return map_str[i].val;
	}		
	return str;
}
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		if ( i < 17 ) 
			tmp[0] = new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') style=display:none>",3);
		else
		{
			tmp[0] = new Array("tdchk_"+idx,draw_td(O_VAR,ICONLINE,"img"+i,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>","div"+i),3);
		}
		tmp[1] = new Array(td_id[0]+idx,replace_transfer(datalist[i][0]),0);
		var proto="";
		if ( datalist[i][1] == "4" )
			proto = __T(mang.icmp);
		else if ( datalist[i][1] == "5" ) 
			proto = __T(share.all); 
		else{
			proto = proto_list[datalist[i][1]];
		}
		tmp[2] = new Array(td_id[1]+idx,proto,3);
		if ( proto != __T(mang.icmp) && proto != __T(share.all) ) 
		{
			tmp[3] = new Array(td_id[2]+idx,datalist[i][2],2);
			tmp[4] = new Array(td_id[3]+idx,datalist[i][3],2);
		}else{
			tmp[3] = new Array(td_id[2]+idx,"",2);
			tmp[4] = new Array(td_id[3]+idx,"",2);
		}
		tmp[5] = new Array("","&nbsp;",0);
		/*
		if ( i < 17 ) 
			add_row(idx,tmp,"chk_",stflg,2);
		else*/
			add_row(idx,tmp,"chk_",stflg,2);
			//add_row(idx,tmp,"chk_",stflg,"showHint('img"+idx+"','div"+idx+"',event)","hideHint('div"+idx+"')",2);
		idx++;
	}
	default_nv = get_data(document.frmqos);
}

function chk_click(index){
        var nv_arr=new Array();
        for(var i=0; i<datalist[index].length; i++)
        {
                if( i == 1 )
                        nv_arr[i] = proto_list[datalist[index][i]];
                else{
			if ( datalist[index][i] == "0" ) 
				nv_arr[i] =  "";
			else
	                        nv_arr[i] = datalist[index][i];
		}
        }
        to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,nv_arr);
}


function all_chk()
{
	var F = document.frmqos;
        for(var i=17; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i) == null ) continue;
                if ( F.chk_all.checked == true )
                        document.getElementById("chk_"+i).checked = true;
                else
                        document.getElementById("chk_"+i).checked = false;
		var arr_nv = new Array();
		for(var j=0; j<datalist[i].length; j++)
		{
			if ( j == 1 ) 
				arr_nv[j] = proto_list[datalist[i][j]];
			else{
				if ( datalist[i][j] == "0" ) 
					arr_nv[j] = "";
				else
					arr_nv[j] = datalist[i][j];
			}
		}
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,arr_nv);
        }
}

function to_del()
{
	stflg = "del";
	for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                                del_row(i);
        }
}

function chk_before_data(index)
{
	var F = document.frmqos;
	var errflg = 0;
	if ( document.getElementById(obj_id[3]+index ) ) 
	{
		if ( document.getElementById(obj_id[0]+index) ) 
		{

			if ( !chk_valid_desc(index) ) errflg = 1;
		}
		if ( document.getElementById(obj_id[1]+index).selectedIndex != 3 ) 
		{
			if ( !chk_valid_port('2',index)) errflg = 1;
			if ( !chk_valid_port('3',index)) errflg = 1;
			if ( !chk_dup_port(index) ) errflg = 1;
			if ( parseInt(eval("F.sport"+index).value,10) > parseInt(eval("F.eport"+index).value,10) ) 
			{
				table_msg("img_eport"+index,"eport"+index,"div_eport"+index,index,__T(msg.errstartend));
				errflg=1;
			}
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function chk_dup_port(index){
        //clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
        //clear_table_msg("tmsg",img_id[3]+index,obj_id[3]+index,index);
        for(var j=0; j<idx; j++)
	{
		var sport=0, eport=0,proto="";
		
		if ( j == index ) continue;
		if ( document.getElementById(obj_id[2]+j) == null ) 
		{
			sport = datalist[j][2];
			eport = datalist[j][3];
			if ( datalist[j][1] == "5" ) 
				proto = __T(share.all); 
			else
				proto = proto_list[datalist[j][1]];
		}else{
			sport = document.getElementById(obj_id[2]+j).value;
			eport = document.getElementById(obj_id[3]+j).value;
			proto = proto_list[document.getElementById(obj_id[1]+j).value];
		}
		if ( proto != __T(mang.both) && 
		     proto_list[document.getElementById(obj_id[1]+index).value] != __T(mang.both) && 
                     proto != proto_list[document.getElementById(obj_id[1]+index).value] ) continue;
		if ( ( sport == document.getElementById(obj_id[2]+index).value ) && 
		     ( eport == document.getElementById(obj_id[3]+index).value ) ) 
		{
                        table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,__T(msg.portexist));
                        table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.portexist));
			return false;	
		}
	}
	return true;
}

function get_data(F)
{
	var str,data="",data2="";
	var errflg=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("tr_table"+i) == null ) continue;
		if ( stflg == "del" ) 
		{
			if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
			{
				if ( parseInt(datalist[i][4],10) > 0 ) 
				{
					document.getElementById("tdchk_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"') checked onMouseMove=showHint('img"+i+"','div"+i+"',event) onMouseOut=hideHint('div"+i+"')>","div"+i);
					errflg=1;
					table_msg("img"+i,"","div"+i,i,__T(msg.rulereserved));
				}
				else
					continue;
			}
		}
		data2="";
		for(var j=1; j<4; j++)
		{
			if ( data2 != "" ) data2 += ",";
			if ( document.getElementById(obj_id[j]+i) == null ) 
			{
				if ( document.getElementById(td_id[j]+i).innerHTML == __T(share.all) ) 
				{
					data2+="5";
				}else{
					if ( j == 1 ) 
					{
						for(k=0; k<proto_list.length; k++)
						{
							if ( document.getElementById(td_id[j]+i).innerHTML == proto_list[k] )
							{
								data2+=k;
								break;
							} 
						}
					}else{
						if ( document.getElementById(td_id[j]+i).innerHTML == "" ) 
							data2 += "0";
						else
							data2 += document.getElementById(td_id[j]+i).innerHTML;
					}
				}
			}
			else
			{
				if ( document.getElementById(obj_id[j]+i).value != "" ) 
					data2 += document.getElementById(obj_id[j]+i).value;
				else
					data2 += "0";
			}
		}
		data2 += ",";
		if ( document.getElementById(obj_id[0]+i) == null ) 
			str = cy_speccode_decode(datalist[i][0]);
		else
			str = document.getElementById(obj_id[0]+i).value;
		if ( str.length < 10 ) 
			data2 += "0"+ str.length;
		else 
			data2 += str.length;	
		data2 += str;
		if ( data != "" ) data+=";";
		data += data2;
	}
	F.smtb.value = data;
	//alert(F.smtb.value);
	//return false;
	if ( errflg == 1 ) return "";
	return data;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("service_manage.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	var F = document.frmqos;
	for(var i=0; i<idx; i++) if ( !chk_before_data(i) ) return false;
	if ( !get_data(F) ) return false;
	F.submit_button.value="service_manage";
	F.gui_action.value = "Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}
function to_edit(){
	stflg = "edit";
	for(i=0; i<idx; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[2]+i) == null )
		{
			var data = new Array();
			var _val = new Array("0","1","2","3");
			var proto = "";
			if ( datalist[i][1] == "4" ) proto = "3";
			else proto = datalist[i][1];
			data[0] = draw_object(O_VAR,SELBOX,obj_id[1]+i,"id="+obj_id[1]+i+" onChange=sel_proto(this.form,"+i+")",proto_list,_val,proto);
			if ( proto == "3" ) 
			{
				data[1] = draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=8 maxlength=5 id="+obj_id[2]+i+" onblur=chk_valid_port('2',"+i+") onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') disabled>",div_id[2]+i); 
				data[2] = draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input size=8 maxlength=5 id="+obj_id[3]+i+" onblur=chk_valid_port('3',"+i+") onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') disabled>",div_id[3]+i);
			}else{
	  		        data[1] = draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=8 maxlength=5 id="+obj_id[2]+i+" onblur=chk_valid_port('2',"+i+") onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+datalist[i][2]+">",div_id[2]+i); 
				data[2] = draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input size=8 maxlength=5 id="+obj_id[3]+i+" onblur=chk_valid_port('3',"+i+") onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') value="+datalist[i][3]+">",div_id[3]+i);
			}
			var m_td_id = new Array("td_proto","td_sport","td_eport");
			edit_row(m_td_id,data,i);
		}
	}
}

function sel_proto(F,index)
{
        //clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
        //clear_table_msg("tmsg",img_id[3]+index,obj_id[3]+index,index);
	if ( eval("F."+obj_id[1]+index).selectedIndex == 3 ) //ICMP
	{
		choose_disable(eval("F."+obj_id[2]+index));
		choose_disable(eval("F."+obj_id[3]+index));
	}else{
		choose_enable(eval("F."+obj_id[2]+index));
		choose_enable(eval("F."+obj_id[3]+index));
		
	}
}
function to_add(){
	var F = document.frmqos;
	if ( idx >= SERVICE_MAN_ENTRY  )
        {
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,SERVICE_MAN_ENTRY,__T(filter.mangservices)));
                return false;
        }
	if ( !chk_before_data(idx-1) ) return false;
	var tmp = new Array();
	stflg = "add";
	tmp[0] = new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=32 name="+obj_id[0]+idx+" id="+obj_id[0]+idx+" onblur=chk_valid_desc("+idx+") onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	var _val = new Array("0","1","2","3");
	tmp[2] = new Array(td_id[1]+idx,draw_object(O_VAR,SELBOX,obj_id[1]+idx,"id="+obj_id[1]+idx+" name="+obj_id[1]+idx+" onChange=sel_proto(this.form,"+idx+")",proto_list,_val),3);
	tmp[3] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=8 maxlength=5 id="+obj_id[2]+idx+" name="+obj_id[2]+idx+" onblur=chk_valid_port('2',"+idx+") onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"')>",div_id[2]+idx,"","align=right"),1);	
	tmp[4] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=8 maxlength=5 name="+obj_id[3]+idx+" id="+obj_id[3]+idx+" onblur=chk_valid_port('3',"+idx+") onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"')>",div_id[3]+idx,"","align=right"),1);	
	tmp[5] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function chk_valid_port(obj,index)
{
        clear_table_msg("tmsg",img_id[obj]+index,obj_id[obj]+index,index);
	var obj_val = document.getElementById(obj_id[obj]+index).value;
	if ( obj_val == "" ) 
	{
		table_msg(img_id[obj]+index,obj_id[obj]+index,div_id[obj]+index,index,__T(msg.notblank));
		return false;
		
	}
	if ( !msg_chk_range(obj_val,obj_id[obj]+index,PORT_START,PORT_TO,10,IS_TABLE,"tmsg",img_id[obj]+index,div_id[obj]+index,index) ) 
		return false;
	return true;
}

function chk_valid_desc(index){
        clear_table_msg("tmsg",img_id[0]+index,obj_id[0]+index,index);
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id[0]+index).value,ZERO_NO,obj_id[0]+index);
	if ( returnmsg != "" )
	{
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,returnmsg);
		return false;
	}
        for(var j=0; j<datalist.length; j++)
	{
        	clear_table_msg("tmsg",img_id[0]+j,obj_id[0]+j,j);
		if ( datalist[j][0] == document.getElementById(obj_id[0]+index).value ) 
		{
                        table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,__T(msg.descexist));
			return false;	
		}
	}
	if (document.getElementById(obj_id[0]+(index-1)) != null)
	{
		for (var i=1; i<=(index-16); i++)
		{
			if (document.getElementById(obj_id[0]+(index-i))!=null)	
			{
				if ( document.getElementById(obj_id[0]+index).value == document.getElementById(obj_id[0]+(index-i)).value ) 
				{
                        		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,__T(msg.descexist));
					return false;	
				}
			}
		}
	}

	return true;
	
}	

</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=frmqos onSubmit="return false;" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">
<input type=hidden name=smtb>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.mangservice));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,30,15,15,15",__T(filter.mangservicetb),"<input type=checkbox onclick=all_chk() name=chk_all>,"+__T(filter.servicename)+","+__T(share.pl)+","+__T(filter.startport)+","+__T(filter.endport),"add,edit,del","","","","2,0,2,1,1");
		</script>
  </TD></TR>	
  <% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
