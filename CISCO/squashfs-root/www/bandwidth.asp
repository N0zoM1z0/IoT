<html>
<head>
<title></title>
<% web_include_file("filelink.asp"); %>
<script>
var qos_wan_speed = "<% nvram_get("qos_wan_speed"); %>";
var qos_lan_speed = "<% nvram_get("qos_lan_speed"); %>";
var wwan_in_used = "<% nvram_get("wwan_in_used"); %>";

var support_3g=1;
var tmpdata = new Array(<% get_service_list(); %>);
var proto_list = new Array(__T(mang.tcp),__T(mang.udp),__T(mang.both),__T(mang.icmp),"",__T(share.all));
var define_backname="bandwidth.asp";
var service_list = new Array();
var service_value = new Array();
for(var i=0; i<tmpdata.length; i++)
{
	var dataidx = tmpdata[i].lastIndexOf("[");
	service_value[i] = tmpdata[i].substring(0, dataidx);
	var proto = tmpdata[i].substring(dataidx+1,dataidx+2);
	if ( dataidx != -1 ) 
	{
		if ( proto == "3" || proto == "5" ) 
			service_list[i] = tmpdata[i].substring(0,dataidx)+" ["+proto_list[proto]+"]";
		else
		service_list[i] = tmpdata[i].substring(0,dataidx)+" ["+proto_list[proto]+tmpdata[i].substring(dataidx+2,tmpdata[i].length);
	}
	
}
var iface_name = new Array(__T(wwan.ethernet),__T(wwan.i3g));
var iface_val = new Array("0","3","2")
var single_iface_name = new Array(__T(wwan.ethernet));
var single_iface_val = new Array("3")
var dire_name = new Array(__T(filter.outbound),__T(filter.inbound));
var dire_val = new Array("0","1");
var pri_name = new Array(__T(def.low),__T(def.medium),__T(def.high));
var pri_val = new Array("1","3","4");
var cat_name = new Array(__T(filter.service),__T(filter.vlanssid),__T(filter.sip),__T(filter.dip));
var cat_val = new Array("0","1' id='vid","2' id='sip","3' id='dip");
var interface_name = new Array(<%get_qos_interface();%>);

var datalist = new Array();
<% get_qos_smt("datalist"); %>
var td_id = new Array("td_en","td_direct","td_cat","td_service","td_interface","td_ip","td_mask","td_pri","td_remaking","td_textre");
var obj_id = new Array("en","direct","cat","service","interface","ip","mask","pri","remaking","textre");
var img_id = new Array("img_en","img_direct","img_cat","img_service","img_interface","img_ip","img_mask","img_pri","img_remaking","img_textre");
var div_id = new Array("div_en","div_direct","div_cat","div_service","div_interface","div_ip","div_mask","div_pri","div_remaking","div_textre");
var idx=0;
var stflg="init";
var change_canecl_bt="false";
var datalist_show = new Array();
function to_mang()
{
	change_cancel_bt="true";
	goto_page("service_manage.asp");
}

function init_iface(type,val)
{
	if ( support_3g == 0 ) return val;
	if ( type == "en" ) 
	{
		if ( parseInt(val,10) > 0 ) return "1";
		return "0";
	}else if ( type == "iface" ) 
	{
		if ( val == "-2" || val == "3" ) return 1;
		else if ( val == "-1" || val == "2" ) return 2;
		return 0;	
	}else if ( type == "map_iface" ) 
	{
                if ( val == "-2" || val == "3" ) return 3;
                else if ( val == "-1" || val == "2" ) return 2;
                return 0;
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

function getdata_fromnv(index)
{
	datalist_show[index] = new Array();
	if ( init_iface("en",datalist[index][0]) == "1" ) datalist_show[index][0] = __T(filter.yes);
	else datalist_show[index][0] = __T(filter.no);
	datalist_show[index][1] = dire_name[datalist[index][1]];
	datalist_show[index][2] = cat_name[datalist[index][2]];
	var flg=0;
	for(var j=0; j<service_value.length; j++)
	{
		if ( str_replace(" ","",service_value[j]) == str_replace(" ","",datalist[index][3]) ) 
		{
			flg=j;
			break;
		}
	}
	datalist_show[index][3] = service_list[flg];
	for(var j=0; j<interface_name.length; j++)
	{
        	if ( datalist[index][4] == interface_name[j] )  
                {
                	flg=j
                        break;
                }
        }
	datalist_show[index][4] = interface_name[flg];
	if ( datalist[index][5] == "NULL" ) 
		datalist_show[index][5] = "";
	else 
		datalist_show[index][5] = datalist[index][5];
	if ( datalist[index][6] == "NULL" ) 
		datalist_show[index][6] = "";
	else 
		datalist_show[index][6] = datalist[index][6];
	for(var j=0; j<pri_val.length; j++)
        {
	        if ( datalist[index][7] == pri_val[j] ) 
                {
	                flg=j
                        break;
                }
        }
	datalist_show[index][7] = pri_name[flg];
        if ( datalist[index][8] == '1' ) datalist_show[index][8] = __T(filter.yes);
	else datalist_show[index][8] = __T(filter.no);
        if ( datalist[index][8] == '1' )
		datalist_show[index][9] = datalist[index][9];
	else
		datalist_show[index][9] ="";
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	document.getElementById("tmsgstream").style.display="none";
	var F = document.frmqos;
	var tmp = new Array();
	for(var i=0; i<datalist.length; i++)
	{
		getdata_fromnv(i);
		var y=0;
		tmp[y++] = new Array("tdchk_"+idx,"<input type=checkbox onclick=to_chk("+idx+") name=chk"+idx+" id=chk"+idx+">",3);
		tmp[y++] = new Array(td_id[0]+idx,datalist_show[i][0],3);
		tmp[y++] = new Array(td_id[1]+idx,datalist_show[i][1],3);
		tmp[y++] = new Array(td_id[2]+idx,datalist_show[i][2],3);
		tmp[y++] = new Array(td_id[3]+idx,datalist_show[i][3],3);
		tmp[y++] = new Array(td_id[4]+idx,datalist_show[i][4],3);
		tmp[y++] = new Array(td_id[5]+idx,datalist_show[i][5],0);
		tmp[y++] = new Array(td_id[6]+idx,datalist_show[i][6],0);
		tmp[y++] = new Array(td_id[7]+idx,datalist_show[i][7],3);
		tmp[y++] = new Array(td_id[8]+idx,datalist_show[i][8],3);
		tmp[y++] = new Array(td_id[9]+idx,datalist_show[i][9],3);
		add_row(idx,tmp,"chk",stflg,2);
		idx++;
		
	}
	en_qos(F);
	choose_disable(document.getElementById("t3"));
	default_nv = keep_val(F,"");
}

function to_chk(index)
{
        var F = document.frmqos;
	F.chk_all.checked = false;
	var flg=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk"+i).checked == true ) 
		{
			choose_disable(document.getElementById("t1"));
			flg=1;
		}
	}	
	if ( flg == 0 ) 
		choose_enable(document.getElementById("t1"));
	to_check("chk",document.getElementById("chk"+index).checked,index,idx,stflg,td_id,datalist_show[index]);
}

function all_chk()
{
        var F = document.frmqos;
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk"+i) == null ) continue;
                if ( F.chk_all.checked == true )
		{
                        document.getElementById("chk"+i).checked = true;
			choose_disable(document.getElementById("t1"));
		}
                else
		{
                        document.getElementById("chk"+i).checked = false;
			choose_enable(document.getElementById("t1"));
		}
		 var tmp = new Array();
		 if ( datalist[i][0] == "1" )
                	tmp[0] = __T(filter.yes);
	        else
        	        tmp[0] = __T(filter.no);
	        var flg="";
        	for(var j=0; j<service_list.length; j++)
	        {
        	        var tmpname = service_list[j].split("[");
                	if ( tmpname[0] == datalist[i][3] )
	                {	
        	                flg = service_list[j];
                	        break;
	                }
        	}
	        tmp[1] = flg;
        	tmp[2] = dire_name[datalist[i][1]];
	        tmp[3] = pri_name[parseInt(datalist[i][2],10)-1];
		to_check("chk",document.getElementById("chk"+i).checked,i,idx,stflg,td_id,tmp);
        }
}

function my_valid_range(obj_id,start,end,div_id,img_id,index)
{
	var show_start=start;
	var show_end=end;
	var th=10;
	if ( obj_id.substring(0,5) == "_sid_" )
	{
		var show_end=end.toString(16);
		th=16;
	}
	if ( !msg_chk_range(document.getElementById(obj_id).value,obj_id,start,end,th,IS_TABLE,"tmsg",img_id,div_id,index) )  
		return false;
	return true;
}

function to_edit()
{
	stflg = "edit";
	for(var i=0; i<idx; i++)
	{
		if( document.getElementById("chk"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
	    var tmp = new Array();
			var chkflg="";
			if ( init_iface("en",datalist[i][0]) == "1" ) chkflg = "checked";
	      tmp[0] = "<input type=checkbox id="+obj_id[0]+i+" name="+obj_id[0]+i+" "+chkflg+">";
			tmp[1] =draw_td(O_VAR,ICONLINE,img_id[1]+i,draw_object(O_VAR,SELBOX,obj_id[1]+i," onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') onclick=sel_dire('"+i+"')",dire_name,dire_val,datalist[i][1]),div_id[1]+i);
			var cat_val = new Array("0","1' id='vid"+i,"2' id='sip"+i,"3' id='dip"+i);
			tmp[2] = draw_td(O_VAR,ICONLINE,img_id[2]+i,draw_object(O_VAR,SELBOX,obj_id[2]+i," onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') onclick=sel_cat('"+i+"')  onblur=valid_dire("+i+")",cat_name,cat_val,datalist[i][2]),div_id[2]+i);
	    tmp[3] = draw_td(O_VAR,ICONLINE,img_id[3]+i,draw_object(O_VAR,SELBOX,obj_id[3]+i," onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"')",service_list,service_value,datalist[i][3]),div_id[3]+i);
			tmp[4] = draw_td(O_VAR,ICONLINE,img_id[4]+i,draw_object(O_VAR,SELBOX,obj_id[4]+i," onMouseMove=showHint('"+img_id[4]+i+"','"+div_id[4]+i+"',event) onMouseOut=hideHint('"+div_id[4]+i+"')",interface_name,interface_name,datalist[i][4]),div_id[4]+i);
			tmp[5] = draw_td(O_VAR,ICONLINE,img_id[5]+i,"<input size=10 id="+obj_id[5]+i+" name="+obj_id[5]+i+" onMouseMove=showHint('"+img_id[5]+i+"','"+div_id[5]+i+"',event) onMouseOut=hideHint('"+div_id[5]+i+"') value="+datalist[i][5]+">",div_id[5]+i);
			tmp[6] = draw_td(O_VAR,ICONLINE,img_id[6]+i,"<input size=10 id="+obj_id[6]+i+" name="+obj_id[6]+i+" onMouseMove=showHint('"+img_id[6]+i+"','"+div_id[6]+i+"',event) onMouseOut=hideHint('"+div_id[6]+i+"') value="+datalist[i][6]+">",div_id[6]+i);
			tmp[7] = draw_td(O_VAR,ICONLINE,img_id[7]+i,draw_object(O_VAR,SELBOX,obj_id[7]+i," onMouseMove=showHint('"+img_id[7]+i+"','"+div_id[7]+i+"',event) onMouseOut=hideHint('"+div_id[7]+i+"')",pri_name,pri_val,datalist[i][7]),div_id[7]+i);
			var chkflg = "";
			if ( datalist[i][8] == '1' ) chkflg = "checked";
			tmp[8] = "<input type=checkbox id="+obj_id[8]+i+" name="+obj_id[8]+i+" onclick=chk_remark("+i+") "+chkflg+">";
			tmp[9] = draw_td(O_VAR,ICONLINE,img_id[9]+i,"<input size=10 id="+obj_id[9]+i+" name="+obj_id[9]+i+" maxlength=2 onblur=my_valid_range('"+obj_id[9]+i+"','0','63','"+div_id[9]+i+"','"+img_id[9]+i+"','"+i+"') onMouseMove=showHint('"+img_id[9]+i+"','"+div_id[9]+i+"',event) onMouseOut=hideHint('"+div_id[9]+i+"') value="+datalist[i][9]+" >",div_id[9]+i);
	    edit_row(td_id,tmp,i);
			eval("document.frmqos."+obj_id[2]+i).selectedIndex = parseInt(datalist[i][2],10);
			sel_dire(i);
			sel_cat(i);
		}
	}
}

function to_add()
{
	if( idx >= QOS_ENTRY)
	{
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,QOS_ENTRY,__T(filter.bandwidthmang)));
		return;
	}
	stflg = "add";
	var j=0,x=0;
	var tmp = new Array();
	tmp[j++] = new Array("tdchk_"+idx,"<input type=checkbox id=chk"+idx+" name=chk"+idx+" disabled>",3);
	tmp[j++] = new Array(td_id[x]+idx,"<input type=checkbox id="+obj_id[x]+idx+" name="+obj_id[x++]+idx+">",3);
	tmp[j++] = new Array(td_id[x]+idx,draw_object(O_VAR,SELBOX,obj_id[x++]+idx," onclick=sel_dire('"+idx+"')",dire_name,dire_val),3);
	var cat_val = new Array("0","1' id='vid"+idx,"2' id='sip"+idx,"3' id='dip"+idx);
	tmp[j++] = new Array(td_id[x]+idx,draw_object(O_VAR,SELBOX,obj_id[x++]+idx,"onclick=sel_cat('"+idx+"')",cat_name,cat_val),3);
	var obj=draw_object(O_VAR,SELBOX,obj_id[x++]+idx," onMouseMove=showHint('img_service"+idx+"','"+"div_service"+idx+"',event) onMouseOut=hideHint('div_service"+idx+"')",service_list,service_value);
	tmp[j++] = new Array(td_id[x]+idx,draw_td(O_VAR,ICONLINE,"img_service"+idx,obj,"div_service"+idx,"","align=center"),1);
	var obj=draw_object(O_VAR,SELBOX,obj_id[x++]+idx," onMouseMove=showHint('img_interface"+idx+"','"+"div_interface"+idx+"',event) onMouseOut=hideHint('div_interface"+idx+"') disabled",interface_name,interface_name);
	tmp[j++] = new Array(td_id[x]+idx,draw_td(O_VAR,ICONLINE,"img_interface"+idx,obj,"div_interface"+idx,"","align=center"),3);
	tmp[j++] = new Array(td_id[x]+idx,draw_td(O_VAR,ICONLINE,"img_ip"+idx,"<input size=10 id="+obj_id[x]+idx+" name="+obj_id[x++]+idx+" disabled onMouseMove=showHint('img_ip"+idx+"','"+"div_ip"+idx+"',event) onMouseOut=hideHint('div_ip"+idx+"')>","div_ip"+idx,"",""),1);
	tmp[j++] = new Array(td_id[x]+idx,draw_td(O_VAR,ICONLINE,"img_mask"+idx,"<input size=10 id="+obj_id[x]+idx+" name="+obj_id[x++]+idx+" disabled onMouseMove=showHint('img_mask"+idx+"','"+"div_mask"+idx+"',event) onMouseOut=hideHint('div_mask"+idx+"')>","div_mask"+idx,"",""),1);
	tmp[j++] = new Array(td_id[x]+idx,draw_object(O_VAR,SELBOX,obj_id[x++]+idx,"",pri_name,pri_val),3);
	tmp[j++] = new Array(td_id[x]+idx,"<input type=checkbox id="+obj_id[x]+idx+" name="+obj_id[x++]+idx+" onclick=chk_remark("+idx+")>",3);
  tmp[j++] = new Array(td_id[x]+idx,draw_td(O_VAR,ICONLINE,"img_textre"+idx,"<input size=10 id="+obj_id[x]+idx+" name="+obj_id[x]+idx+" maxlength='2' onblur=my_valid_range('"+obj_id[x]+idx+"','0','63','"+div_id[x]+idx+"','"+img_id[x]+idx+"','"+idx+"') onMouseMove=showHint('"+img_id[x]+idx+"','"+div_id[x]+idx+"',event) onMouseOut=hideHint('"+div_id[x]+idx+"') disabled>",div_id[x]+idx,"",""),3);
	add_row(idx,tmp,"chk",stflg,2);
	sel_dire(idx);
	sel_cat(idx);
	idx++;
}

function chk_remark(sel_idx)
{
	choose_disable(document.getElementById(obj_id[9]+sel_idx));
	if ( document.getElementById(obj_id[8]+sel_idx).checked == true ) 
		choose_enable(document.getElementById(obj_id[9]+sel_idx));
}

function sel_cat(sel_idx)
{
	choose_enable(document.getElementById("service"+sel_idx));
	choose_enable(document.getElementById("ip"+sel_idx));
	choose_enable(document.getElementById("mask"+sel_idx));
	choose_enable(document.getElementById("interface"+sel_idx));
	if ( document.getElementById("cat"+sel_idx)[0].selected == true ) 
	{
		choose_disable(document.getElementById("ip"+sel_idx));
		choose_disable(document.getElementById("mask"+sel_idx));
		choose_disable(document.getElementById("interface"+sel_idx));
	}else if ( document.getElementById("cat"+sel_idx)[1].selected == true ) 
	{
		document.getElementById("service"+sel_idx)[0].selected = true;
		choose_disable(document.getElementById("service"+sel_idx));
		choose_disable(document.getElementById("ip"+sel_idx));
		choose_disable(document.getElementById("mask"+sel_idx));
	}else if ( document.getElementById("sip"+sel_idx).selected == true ||  
	           document.getElementById("dip"+sel_idx).selected == true ) 
	{
		document.getElementById("service"+sel_idx)[0].selected = true;
		choose_disable(document.getElementById("service"+sel_idx));
		choose_enable(document.getElementById("ip"+sel_idx));
		choose_enable(document.getElementById("mask"+sel_idx));
		choose_disable(document.getElementById("interface"+sel_idx));
	}
}

function sel_dire(sel_idx)
{
	if ( document.getElementById(obj_id[1]+sel_idx).selectedIndex == 1 ) //Inbound
	{
		choose_disable(document.getElementById(obj_id[4]+sel_idx));
		choose_disable(document.getElementById(obj_id[8]+sel_idx));
		choose_disable(document.getElementById("dip"+sel_idx));
		choose_disable(document.getElementById("vid"+sel_idx));
		choose_enable(document.getElementById("sip"+sel_idx));
	}else{
		choose_enable(document.getElementById(obj_id[2]+sel_idx));
		choose_enable(document.getElementById(obj_id[4]+sel_idx));
		choose_enable(document.getElementById(obj_id[8]+sel_idx));
		choose_enable(document.getElementById("dip"+sel_idx));
		choose_enable(document.getElementById("vid"+sel_idx));
		choose_disable(document.getElementById("sip"+sel_idx));
	}
	chk_remark(sel_idx);
}

function to_del(){         
	stflg = "del";
	choose_disable(document.getElementById("t1"));
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk"+i).checked == true )
                                del_row(i);
        }
}

function map_iface_val(iname)
{
	for(var k=0; k<iface_name.length; k++)
	{
		if ( iface_name[k] == iname ) return iface_val[k];
	}
}
function removed_service_words(str)
{
	var dataidx = str.lastIndexOf("[");
	return str.substring(0, dataidx);
	
}
function valid_value(F)
{
	var errflg=0;

	for(var k=0; k<=idx; k++)
  {
    if((document.getElementById(obj_id[8]+k)!=null) && (document.getElementById(obj_id[9]+k)!=null))
    {
      if(document.getElementById(obj_id[8]+k).checked == true)
      {
        if (!my_valid_range(obj_id[9]+k,'0','63',div_id[9]+k,img_id[9]+k,k))
          errflg = 1;
      }
    }
  }

	if(!chk_upstream(F)) errflg = 1;
	if(!chk_downstream(F)) errflg = 1;
	var namei="", namej="";
	var diri="", dirj="";
	var ifacei="", ifacej="";
	var ipi="", maski="", ipj="", maskj="";

	for(var i=0; i<idx; i++)
	{
    if(document.getElementById("service"+i) == null)
    {
      namei = removed_service_words(cy_speccode_decode(document.getElementById("td_service"+i).innerHTML));
      diri = document.getElementById("td_direct"+i).innerHTML;
      cati = str_replace(" ","",document.getElementById("td_cat"+i).innerHTML);
			document.getElementById("td_ip"+i).innerHTML = parseIP(document.getElementById("td_ip"+i).innerHTML);
      ipi = document.getElementById("td_ip"+i).innerHTML;
			document.getElementById("td_mask"+i).innerHTML = parseIP(document.getElementById("td_mask"+i).innerHTML);
			maski = document.getElementById("td_mask"+i).innerHTML;
			if ( support_3g == 1 ) 
        ifacei = document.getElementById("td_interface"+i).innerHTML.toLowerCase();
		}
    else
    {
      namei = eval("F.service"+i).value;
      diri = dire_name[eval("F.direct"+i).value];
			cati = str_replace(" ","",cat_name[eval("F.cat"+i).value]);
			eval("F.ip"+i).value = parseIP(eval("F.ip"+i).value);
      ipi = eval("F.ip"+i).value;
			eval("F.mask"+i).value = parseIP(eval("F.mask"+i).value);
      maski = eval("F.mask"+i).value;
			if ( support_3g == 1 ) 
        ifacei = eval("F.interface"+i).value;
		}

		if((cati == str_replace(" ","",__T(filter.sip))) || (cati == str_replace(" ","",__T(filter.dip))))
		{
			if((ipi == "") || (ipi == "NULL"))
			{
				table_msg(img_id[5]+i,obj_id[5]+i,div_id[5]+i,i,__T(msg.ipempty));
				errflg = 1;
			}
			else if(check_ipv4(ipi, VALID_IP_RULE7,ZERO_NO) != PASS)
			{
				table_msg(img_id[5]+i,obj_id[5]+i,div_id[5]+i,i,__T(ddnsm.tzo_notip));
				errflg = 1;
			}

			if((maski == "") || (maski == "NULL"))
			{
				table_msg(img_id[6]+i,obj_id[6]+i,div_id[6]+i,i,__T(msg.macempty));
				errflg = 1;
			}
			else if(check_ipv4(ipi, VALID_IP_RULE2,ZERO_NO) != PASS)
			{
				table_msg(img_id[6]+i,obj_id[6]+i,div_id[6]+i,i,__T(ddnsm.tzo_notip));
				errflg = 1;
			}
		}

		for(var j=i+1; j<idx; j++)
		{
			if(document.getElementById("service"+j) == null)
      {
        namej = removed_service_words(cy_speccode_decode(document.getElementById("td_service"+j).innerHTML));
        dirj = document.getElementById("td_direct"+j).innerHTML;
				catj = str_replace(" ","",document.getElementById("td_cat"+j).innerHTML);
				document.getElementById("td_ip"+j).innerHTML = parseIP(document.getElementById("td_ip"+j).innerHTML);
				ipj = document.getElementById("td_ip"+j).innerHTML;
				document.getElementById("td_mask"+j).innerHTML = parseIP(document.getElementById("td_mask"+j).innerHTML);
				maskj = document.getElementById("td_mask"+j).innerHTML;
				if(support_3g == 1)
          ifacej = document.getElementById("td_interface"+j).innerHTML.toLowerCase();
      }
      else
      {
        namej = eval("F.service"+j).value;
        dirj = dire_name[eval("F.direct"+j).value];
				catj = str_replace(" ","",cat_name[eval("F.cat"+j).value]);
				eval("F.ip"+j).value = parseIP(eval("F.ip"+j).value);
        ipj = eval("F.ip"+j).value;
				eval("F.mask"+j).value = parseIP(eval("F.mask"+j).value);
        maskj = eval("F.mask"+j).value;
				if(support_3g == 1)
          ifacej = eval("F.interface"+j).value;
			}

			if ( (diri == dirj) && (catj == cati) )
			{
//				if(support_3g == 1 && (ifacei != "0" && ifacej != "0" && ifacei != ifacej)) continue;
				if((catj == __T(filter.service)) && (str_replace(" ","",namei) == str_replace(" ","",namej)))
				{
					if(document.getElementById(obj_id[3]+j) != null)
						table_msg(img_id[3]+j,obj_id[3]+j,div_id[3]+j,j,__T(msg.nameexist));
					if(document.getElementById(obj_id[3]+i) != null)
						table_msg(img_id[3]+i,obj_id[3]+i,div_id[3]+i,i,__T(msg.nameexist));
					errflg = 1;
				}

				if((catj == __T(filter.vlanssid)) && (ifacei == ifacej))
				{
					if ( document.getElementById(obj_id[4]+i) != null )
						table_msg(img_id[4]+i,obj_id[4]+i,div_id[4]+i,i,__T(msg.valueexist));
					if ( document.getElementById(obj_id[4]+j) != null )
						table_msg(img_id[4]+j,obj_id[4]+j,div_id[4]+j,j,__T(msg.valueexist));
					errflg = 1;
				}

				if((catj == str_replace(" ","",__T(filter.sip))) || (catj == str_replace(" ","",__T(filter.dip))))
				{
					if((ipi == ipj) && (maski == maskj))
					{
						if(document.getElementById(obj_id[5]+j) != null)
						{
							table_msg(img_id[5]+j,obj_id[5]+j,div_id[5]+j,j,__T(msg.ipexist));
							table_msg(img_id[6]+j,obj_id[6]+j,div_id[6]+j,j,__T(msg.valueexist));
						}
						if(document.getElementById(obj_id[5]+i) != null)
						{
							table_msg(img_id[5]+i,obj_id[5]+i,div_id[5]+i,i,__T(msg.ipexist));
							table_msg(img_id[6]+i,obj_id[6]+i,div_id[6]+i,i,__T(msg.valueexist));
						}
						errflg = 1;
					}
				}
			}
		}
	}

	if(errflg == 1)
		return false;

	return true;
}

function get_iface(enflg, iface)
{
        if ( support_3g == 1 ) 
        {
                if ( parseInt(enflg,10) == 1 ) 
                {
                        if ( parseInt(iface,10) == 0 )  return 1;
                        if ( parseInt(iface,10) == 3 )  return 3;
                        if ( parseInt(iface,10) == 2 )  return 2;
                }else if ( parseInt(enflg,10) == 0 )
                {
                        if ( parseInt(iface,10) == 0 )  return 0;
                        if ( parseInt(iface,10) == 3 )  return -2;
                        if ( parseInt(iface,10) == 2 )  return -1;
                }
        }else{
                return enflg;
        }
}

function valid_dire(sel_idx)
{
	var ret = true;
	if(sel_idx != null)
	{
		if(((document.getElementById(obj_id[1]+sel_idx)!= null) && (document.getElementById(obj_id[1]+sel_idx).selectedIndex == 0)
	   && (document.getElementById("sip"+sel_idx).selected == true))
    || ((document.getElementById(obj_id[1]+sel_idx)!= null) && (document.getElementById(obj_id[1]+sel_idx).selectedIndex == 1)
	   && ((document.getElementById("vid"+sel_idx).selected == true) || (document.getElementById("dip"+sel_idx).selected == true))))
		{
			table_msg(img_id[2]+sel_idx,obj_id[2]+sel_idx,div_id[2]+sel_idx,sel_idx,__T(msg.valueexist));
			ret = false;
		}
		else
		{
			if((document.getElementById(img_id[2]+sel_idx)!= null) && (document.getElementById(obj_id[2]+sel_idx)!= null))
				clear_table_msg("",img_id[2]+sel_idx,obj_id[2]+sel_idx,sel_idx);
		}
	}
	else
	{
		for(var k=0; k<idx; k++)
		{
			if(((document.getElementById(obj_id[1]+k)!= null) && (document.getElementById(obj_id[1]+k).selectedIndex == 0)
	     && (document.getElementById("sip"+k).selected == true))
      || ((document.getElementById(obj_id[1]+k)!= null) && (document.getElementById(obj_id[1]+k).selectedIndex == 1)
	     && ((document.getElementById("vid"+k).selected == true) || (document.getElementById("dip"+k).selected == true))))
			{
				table_msg(img_id[2]+k,obj_id[2]+k,div_id[2]+k,k,__T(msg.valueexist));
				ret = false;
			}
			else
			{
				if((document.getElementById(img_id[2]+k)!= null) && (document.getElementById(obj_id[2]+k)!= null))
					clear_table_msg("",img_id[2]+k,obj_id[2]+k,k);
			}
		}
	}
	return ret;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("bandwidth.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	if ( stflg != "del" && !valid_dire() ) return;
	if ( stflg != "del" && !valid_value(F) ) return;

	if ( F._QoS.checked == true ) 
		F.qos.value = "1";
	else
		F.qos.value = "0";
	F.stflg.value = stflg;
	F.qos_smt.value = "";
	var tmp="",subtmp="",tmpname="";
	if ( stflg == "del" ) 
	{
		F.qos_smt.value = get_data(F);
	}else{
	
	for(var i=0; i<idx; i++)
	{
		tmp = "";
		if ( document.getElementById(obj_id[1]+i) )
		{
		if ( subtmp != "" ) subtmp +=";";
		for(var j=0; j<obj_id.length; j++)
		{
			if ( tmp != "" ) tmp += ",";
			else tmp += i+",";
			if ( j == 0 || j == 8 ) 
			{
				if ( document.getElementById(obj_id[j]+i).checked == true ) 
					tmp += "1";
				else{ 
					if ( j == 6 ) 
					{
						tmp += "0,0";
						break;
					}
					else tmp += "0";
				}
			}else if ( ( j == 5 || j == 6 || j == 9) && document.getElementById(obj_id[j]+i).value == "" )
			{
				tmp += "NULL";
			}else{
				tmp += document.getElementById(obj_id[j]+i).value;	
			}
		}
		subtmp += tmp;
		}
		
	}
	F.qos_smt.value = subtmp;
	}
	F.submit_button.value = "bandwidth";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}

function en_qos(F){
	if ( datalist.length > 0 ) 
	{
		if ( F._QoS.checked == false )
	    DISABLE_PART(F,"disable_start","disable_end",1);
    else
    {
      DISABLE_PART(F,"disable_start","disable_end",0);
		}
	}
  else
  {
    if ( F._QoS.checked == true )
    {
      choose_enable(F.qos_wan_manual_rate);
      choose_enable(F.qos_lan_manual_rate);
      choose_enable(F.qos_3g_wan_manual_rate);
      choose_enable(F.qos_3g_lan_manual_rate);
			choose_enable(document.getElementById("t2"));
			choose_enable(document.getElementById("t1"));
    }
    else
    {
      DISABLE_PART(F,"disable_start","disable_end",1);
    }
	}
	choose_disable(document.getElementById("t4"));
}

function chk_upstream(F)
{
	if ( F._QoS.checked == true )
	{
		if(wwan_in_used == "1")
		{
			if(F.qos_wan_manual_rate.value != "")
			{
				if ( !msg_chk_range(F.qos_wan_manual_rate.value,"qos_wan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
				{
					return false;
				}

				if ( !msg_chk_range(F.qos_lan_manual_rate.value,"qos_lan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
				{
					return false;
				}
			}
			else
			{
				if(F.qos_lan_manual_rate.value != "")
				{
					if ( !msg_chk_range(F.qos_wan_manual_rate.value,"qos_wan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
					{
						return false;
					}
				}
				else
				{
					clear_table_msg("","img_upstream","qos_wan_manual_rate","stream_0");
					clear_table_msg("","img_downstream","qos_lan_manual_rate","stream_1");
				}
			}

			if ( !msg_chk_range(F.qos_3g_wan_manual_rate.value,"qos_3g_wan_manual_rate",256,qos_wan_speed,10,IS_TABLE,"tmsgstream","img_3gup","div_3gup","stream_0") )
			{
				return false;
			}
		}
		else
		{
			if( F.qos_wan_manual_rate.value == "" )
			{
				document.getElementById("tmsgstream").innerHTML = __T(share.tableerrmsg);
				document.getElementById("tmsgstream").style.display="";
				table_msg("img_upstream","qos_wan_manual_rate","div_upstream","_stream",__T(msg.notblank));	
				table_msg("img_3gup","qos_3g_wan_manual_rate","div_3gup","_stream",__T(msg.notblank));	
				document.getElementById("tmsgstream").style.display="none";
				return false;
			}

			if ( !msg_chk_range(F.qos_wan_manual_rate.value,"qos_wan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
			{
				return false;
			}

			if( F.qos_3g_wan_manual_rate.value != "" )
			{
				if ( !msg_chk_range(F.qos_3g_wan_manual_rate.value,"qos_3g_wan_manual_rate",256,qos_wan_speed,10,IS_TABLE,"tmsgstream","img_3gup","div_3gup","stream_0") ) 
				{
					return false;
				}

				if ( !msg_chk_range(F.qos_3g_lan_manual_rate.value,"qos_3g_lan_manual_rate",256,qos_lan_speed,10,IS_TABLE,"tmsgstream","img_3gdown","div_3gdown","stream_1") ) 
				{
					return false;
				}
			}
			else
			{
				if( F.qos_3g_lan_manual_rate.value != "" )
				{
					if ( !msg_chk_range(F.qos_3g_wan_manual_rate.value,"qos_3g_wan_manual_rate",256,qos_wan_speed,10,IS_TABLE,"tmsgstream","img_3gup","div_3gup","stream_0") ) 
					{
						return false;
					}
				}
				else
				{
					clear_table_msg("","img_3gup","qos_3g_wan_manual_rate","stream_0");
					clear_table_msg("","img_3gdown","qos_3g_lan_manual_rate","stream_1");
				}
			}
		}
  }
	return true;
}

function chk_downstream(F)
{
	//document.getElementById("tmsg1").style.display="none";
	if ( F._QoS.checked == true )
  {
		if(wwan_in_used == "1")
		{
			if( F.qos_lan_manual_rate.value != "" )
			{
				if ( !msg_chk_range(F.qos_lan_manual_rate.value,"qos_lan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_downstream","div_downstream","stream_1") ) 
				{
					return false;
				}

				if ( !msg_chk_range(F.qos_wan_manual_rate.value,"qos_wan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
				{
					return false;
				}
			}
			else
			{
				if(F.qos_wan_manual_rate.value != "")
				{
					if ( !msg_chk_range(F.qos_lan_manual_rate.value,"qos_lan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_upstream","div_upstream","stream_0") ) 
					{
						return false;
					}
				}
				else
				{
					clear_table_msg("","img_downstream","qos_lan_manual_rate","stream_1");
					clear_table_msg("","img_upstream","qos_wan_manual_rate","stream_0");
				}
			}

			if ( !msg_chk_range(F.qos_3g_lan_manual_rate.value,"qos_3g_lan_manual_rate",256,qos_lan_speed,10,IS_TABLE,"tmsgstream","img_3gdown","div_3gdown","stream_1") ) 
			{
				return false;
			}
		}
		else
		{
			if( F.qos_lan_manual_rate.value == "" )
			{
				document.getElementById("tmsgstream").innerHTML = __T(share.tableerrmsg);
				document.getElementById("tmsgstream").style.display="";
				table_msg("img_downstream","qos_lan_manual_rate","div_downstream","_stream",__T(msg.notblank));	
				table_msg("img_3gdown","qos_3g_lan_manual_rate","div_3gdown","_stream",__T(msg.notblank));	
				document.getElementById("tmsgstream").style.display="none";
				return false;
			}

			if ( !msg_chk_range(F.qos_lan_manual_rate.value,"qos_lan_manual_rate",256,1000000,10,IS_TABLE,"tmsgstream","img_downstream","div_downstream","stream_1") ) 
			{
				return false;
			}

			if( F.qos_3g_lan_manual_rate.value != "" )
			{
				if ( !msg_chk_range(F.qos_3g_lan_manual_rate.value,"qos_3g_lan_manual_rate",256,qos_lan_speed,10,IS_TABLE,"tmsgstream","img_3gdown","div_3gdown","stream_1") ) 
				{
					return false;
				}

				if ( !msg_chk_range(F.qos_3g_wan_manual_rate.value,"qos_3g_wan_manual_rate",256,qos_wan_speed,10,IS_TABLE,"tmsgstream","img_3gup","div_3gup","stream_0") ) 
				{
					return false;
				}
			}
			else
			{
				if(F.qos_3g_wan_manual_rate.value != "")
				{
					if ( !msg_chk_range(F.qos_3g_lan_manual_rate.value,"qos_3g_lan_manual_rate",256,qos_lan_speed,10,IS_TABLE,"tmsgstream","img_3gdown","div_3gdown","stream_1") ) 
					{
						return false;
					}
				}
				else
				{
					clear_table_msg("","img_3gdown","qos_3g_lan_manual_rate","stream_1");
					clear_table_msg("","img_3gup","qos_3g_wan_manual_rate","stream_0");
				}
			}
		}
  }
	return true;
}

</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=frmqos method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action>
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=qos_smt>
<input type=hidden name=stflg>
<input type=hidden name=qos>
<input type=hidden name=backname>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.bandwidthmang));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.setup),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.bandwidthmang));</script>
		<input type=checkbox name=_QoS <% nvram_match("qos","1","checked"); %> onClick=en_qos(this.form)> <script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<input type=hidden name=disable_start>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.bandwidth),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>Capture(filter.bandwidthmsg);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,20,20",__T(filter.bandwidthtb),__T(share.iface)+","+__T(filter.upstream)+","+__T(filter.downstream),"","","","stream","0,0,0,0");
		var tmp = new Array();
		var show= __T(wan.wan);
		if ( support_3g == 1  ) show = __T(wwan.ethernet);
		tmp[0] = new Array("td_iface0",show);
		tmp[1] = new Array("td_up0",draw_td(O_VAR,ICONLINE,"img_upstream","<input size=10 id=qos_wan_manual_rate name=qos_wan_manual_rate value='<% nvram_get("qos_wan_manual_rate"); %>' onMouseMove=showHint('img_upstream','div_upstream',event) onMouseOut=hideHint('div_upstream') onblur=chk_upstream(this.form)>","div_upstream"));
		tmp[2] = new Array("td_down0",draw_td(O_VAR,ICONLINE,"img_downstream","<input size=10 id=qos_lan_manual_rate name=qos_lan_manual_rate value='<% nvram_get("qos_lan_manual_rate"); %>' onMouseMove=showHint('img_downstream','div_downstream',event) onMouseOut=hideHint('div_downstream') onblur=chk_downstream(this.form)>","div_downstream"));
		tmp[3] = new Array("","&nbsp;");
		add_row(0,tmp,"","addstream",2);
		if ( support_3g == 1 ) 
		{
			tmp[0] = new Array("td_iface1",__T(wwan.i3g));
			tmp[1] = new Array("tdup1",draw_td(O_VAR,ICONLINE,"img_3gup","<input size=10 id=qos_3g_wan_manual_rate name=qos_3g_wan_manual_rate value='<% nvram_get("qos_3g_wan_manual_rate"); %>' onMouseMove=showHint('img_3gup','div_3gup',event) onMouseOut=hideHint('div_3gup') onblur=chk_upstream(this.form)>","div_3gup"));
			tmp[2] = new Array("tddown1",draw_td(O_VAR,ICONLINE,"img_3gdown","<input size=10 id=qos_3g_lan_manual_rate name=qos_3g_lan_manual_rate value='<% nvram_get("qos_3g_lan_manual_rate"); %>' onMouseMove=showHint('img_3gdown','div_3gdown',event) onMouseOut=hideHint('div_3gdown') onblur=chk_downstream(this.form)>","div_3gdown"));
			tmp[3] = new Array("","&nbsp;");
			add_row(1,tmp,"","addstream",2);
		}
		</script>
		</TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		var obj_3g = "", width_3g="", align_3g="";
		if ( support_3g == 1 )
		{ 
			obj_3g =","+__T(share.iface);
			width_3g=",15";
			align_3g=",2";
		}
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(share.addrow),"to_add()");
		bt_list[1] = new Array("BT","t3",__T(share.edit),"to_edit()");
		bt_list[2] = new Array("BT","t4",__T(share.del),"to_del()");
		bt_list[3] = new Array("BT_L","t1",__T(filter.mangservice),"to_mang(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"3,8,10,8,20,8,9,9,9,8,8",__T(filter.bandwidthpriortb),"<input type=checkbox onclick=all_chk() name=chk_all id=chk_all disabled>,"+__T(share.enable)+","+__T(filter.direction)+","+__T(filter.category)+","+__T(filter.services)+","+__T(filter.vlanssid)+","+__T(router.ipaddr)+","+__T(wan.mask)+","+__T(filter.priority)+","+__T(filter.remarking)+","+__T(filter.dscp),"",bt_list,"","","2,2,2,2,2,2,0,0,2,2,2");
		</script>
		</TD></TR>
		<input type=hidden name=disable_end>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
