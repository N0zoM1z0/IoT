<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var proto_list = new Array(__T(mang.tcp),__T(mang.udp),__T(mang.both),__T(mang.icmp),"",__T(share.all));
var data = new Array();
<% get_nat_data(); %>
CHK_VALUE_AUTO=0; 
idx=0;
var stflg="init";
var td_id=new Array("td_priv","td_public","td_len","td_service");
var obj_id=new Array("priv","public","plen","pservice");
var img_id=new Array("img_priv","img_public","img_plen","img_pservice");
var div_id=new Array("div_priv","div_public","div_plen","div_pservice");
function chk_all()
{
	var F = document.sdhcp;
	if ( stflg == "add" ){
		document.getElementById("chkall").checked = false;
		choose_disable(document.getElementById("chkall"));
		return;
	} 
	for(var i=0; i<idx; i++)	
	{
		if ( document.getElementById("chk_"+i) == null ) continue;
		if ( document.getElementById("chkall").checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		/*
		var arr_nv=new Array();
		for(j=0; j<data[i].length; j++)
		{
			if ( j == 1 ) 
				arr_nv[j] = prefix_ip(F)+data[i][j];
			else
				arr_nv[j] = [i][j];
		}*/
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,data[i]);
	}
}
function get_data(F)
{
	var str,data="";
	for(var i=0; i<idx; i++)
	{
        	if (document.getElementById("tr_table"+i) == null ) continue;
		if ( stflg == "del" )
                {
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
                        {
				if ( data != "" ) data +=" ";
				data+=(i+1);
                        }
                }else{ //EDIT or ADD
			if ( document.getElementById(obj_id[0]+i) )
			{
				if ( data != "" ) data += ";";
				data += (i+1);
				for(var j=0; j<obj_id.length; j++)
				{
					data += ",";
					data += document.getElementById(obj_id[j]+i).value;
				}
			}
		}
	}
	F.natdata_entry.value = data;
	return data;
}

function to_del(){
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
			del_row(i);
	}
}

function valid_rule(F)
{
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById(obj_id[0]+i) )
		{ 
			var pri_ip = document.getElementById(obj_id[0]+i).value.split(".");
			var ip_pri = document.getElementById(obj_id[0]+i).value;
		}
		else
		{
			var pri_ip = document.getElementById(td_id[0]+i).innerHTML.split(".");
			var ip_pri = document.getElementById(td_id[0]+i).innerHTML;
		}
		if ( document.getElementById(obj_id[1]+i) ) 
			var pub_ip_all = document.getElementById(obj_id[1]+i).value;
		else
			var pub_ip_all = document.getElementById(td_id[1]+i).innerHTML;
		if ( document.getElementById(obj_id[2]+i) ) 
			var range_len = document.getElementById(obj_id[2]+i).value;
		else
			var range_len = document.getElementById(td_id[2]+i).innerHTML;
		var pub_ip = pub_ip_all.split(".");
		var data = new Array();
		for(var k=0; k<parseInt(range_len,10); k++)
		{
			data[k] = parseInt(parseInt(pri_ip[3],10)+k,10)+","+pub_ip[0]+"."+pub_ip[1]+"."+pub_ip[2]+"."+parseInt(parseInt(pub_ip[3],10)+k,10);
		}
		//CHK IF THE SAME AS DUT IP
		for(var h=0; h<lan_arr.length; h++)
		{
			for(var g=0; g<data.length; g++)
			{
				var lanip3 = lan_arr[h].ipaddr.split(".");
				if ( valid_subnet(lan_arr[h].ipaddr,lan_arr[h].netmask,ip_pri))
				{
					var tmp = data[g].split(",");
					if ( tmp[0] == lanip3[3] ) 
					{
						if ( document.getElementById(obj_id[0]+i) ) 
                        				table_msg(img_id[0]+i,obj_id[0]+i,div_id[0]+i,i, __T(msg.subnet4));
						return false;
					}
				}
			}
		}
		for (var j=i+1; j<idx; j++)
		{
			if ( document.getElementById(obj_id[0]+j) ) 
			{
				var pri_ip2 = document.getElementById(obj_id[0]+j).value.split(".");
				var ip2_pri = document.getElementById(obj_id[0]+j).value;
			}
			else{
				var pri_ip2 = document.getElementById(td_id[0]+j).innerHTML.split(".");
				var ip2_pri = document.getElementById(td_id[0]+j).innerHTML;
			}
			if ( document.getElementById(obj_id[1]+j) ) 
				var pub_ip_all2 = document.getElementById(obj_id[1]+j).value;
			else
				var pub_ip_all2 = document.getElementById(td_id[1]+j).innerHTML;
			if ( document.getElementById(obj_id[2]+j) ) 
				var range_len2 = document.getElementById(obj_id[2]+j).value;
			else
				var range_len2 = document.getElementById(td_id[2]+j).innerHTML;
			var pub_ip2 = pub_ip_all2.split(".");
			/*
			if ( pub_ip_all == pub_ip_all2 ) 
			{
                		table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j,j, __T(msg.ipexist));
				return false;	
			}*/
			var data2 = new Array();
			for(var k=0; k<parseInt(range_len2,10); k++)
			{
				data2[k] = parseInt(parseInt(pri_ip2[3],10)+k,10)+","+pub_ip2[0]+"."+pub_ip2[1]+"."+pub_ip2[2]+"."+parseInt(parseInt(pub_ip2[3],10)+k,10);
			}
			//CHECK IN the same subnet or not
			var same_subnet=0;
			for(var h=0; h<lan_arr.length; h++)
			{
				if ( valid_subnet(ip_pri,lan_arr[h].netmask,ip2_pri))
				{
					same_subnet = 1;
					break;
				}
			}
//			if ( same_subnet == 0 ) continue;
			for(var g=0; g<data.length; g++)
			{
				var tmp = data[g].split(",");
				for(var k=0; k<data2.length; k++)
				{
					var tmp2 = data2[k].split(",");
					//alert("tmp="+tmp+";tmp2="+tmp2);
					if ( tmp[0] == tmp2[0] && same_subnet == 1) 
					{
						if ( tmp[1] != tmp2[1] ) 
						{
							if ( document.getElementById(obj_id[0]+j) ) 
                	        				table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j, __T(msg.iporverlap));
							return false;
							
						}
					}
					if ( tmp2[1] == tmp[1] ) 
					{
						//if ( tmp[0] != tmp2[0] ) 
						{
							if ( document.getElementById(obj_id[1]+j) ) 
                	        				table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j,j, __T(msg.iporverlap));
							return false;
						}
					}
				}
			}	
		}
	}
	return true;
	
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("nat_1to1.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	
	for(var i=0; i<idx; i++)
		if ( !chk_before_data(i) ) return false;
	get_data(F);
	F.stflg.value = stflg;
	F.submit_button.value="nat_1to1";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
	
}
var wanip = "<% nvram_get("wan_ipaddr"); %>";
var wangw = "<% nvram_get("wan_gateway"); %>";
var wanmask = "<% nvram_get("wan_netmask"); %>";
function chk_ip(index, type)
{
	var result;
	if ( type == "private" ) 
	{
		clear_table_msg("tmsg",img_id[0]+index,obj_id[0]+index,index);
		result = check_ipv4(document.getElementById(obj_id[0]+index).value,
			VALID_IP_RULE1,ZERO_NO|MASK_NO|LANSUBNET_OK);
		if ( result != PASS )
		{
			if ( result == IPV4_LANSUBNET_ERR )
				table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index, __T(msg.subnet8));
			else
				table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index, __T(ddnsm.tzo_notip));			      }
	}else if ( type == "public" ) 
	{
		clear_table_msg("tmsg",img_id[1]+index,obj_id[1]+index,index);
                result = check_ipv4(document.getElementById(obj_id[1]+index).value,
                         VALID_IP_RULE1,ZERO_NO|MASK_NO|LANSUBNET_NO);
                if ( result != PASS )
                {
                        if ( result == IPV4_NOLANSUBNET_ERR )
                	        table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(msg.subnet12));
                        else
                                table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(ddnsm.tzo_notip));                       }else{
			if ( wanip != "0.0.0.0" && document.getElementById(obj_id[1]+index).value == wanip ) 
			{
                                table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(msg.subnet13));                       		      result = FAIL;
				
			}
			if ( wangw != "0.0.0.0" && document.getElementById(obj_id[1]+index).value == wangw ) 
			{
                                table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(msg.subnet14));                       		      result = FAIL;
				
			}
		}
		
	}
	if ( result != PASS ) return false;
	return true;
}

function chk_iprange(index)
{
	clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
	var pri_ip = document.getElementById(obj_id[0]+index).value.split(".");
	var pub_ip = document.getElementById(obj_id[1]+index).value.split(".");
	var range_len = document.getElementById(obj_id[2]+index).value;
	if ( ((parseInt(pri_ip[3],10)+parseInt(range_len,10)) > 255) ||
	     ((parseInt(pub_ip[3],10)+parseInt(range_len,10)) > 255) )
	{
                  table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index, __T(msg.invalidip4));
		  return false;
	}
	if ( valid_subnet( document.getElementById(obj_id[1]+index).value, wanmask, wanip) ) 
	{
		var tmpwan = wanip.split(".");
		for(var i=0; i<range_len; i++)
		{
			if ( parseInt(pub_ip[3],10)+i == tmpwan[3] ) 
			{
                                table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(msg.subnet13));
			        return false;
			}
		}
	}
	var tmpwangw = wangw.split(".");
	for(var i=0; i<range_len; i++)
	{
		if ( parseInt(pub_ip[3],10)+i == tmpwangw[3]) 
		{
                        table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index, __T(msg.subnet14));
		        return false;
		}
	}
	return true;
}

function chk_before_data(index)
{
	var errflg =0;
	if ( document.getElementById(obj_id[0]+index) )
	{
		if ( !chk_ip(index,"private") ) errflg = 1;
		if ( !chk_ip(index,"public") ) errflg = 1;
		if ( !my_valid_range(1,254,index) ) errflg = 1;
		if ( errflg == 0 && !chk_iprange(index) ) errflg = 1;
		if ( errflg == 0 && valid_rule() == false ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
        return true;
}

function chk_click(index){
	var F = document.sdhcp;
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,data[index]);
}

function skipstr(data)
{
	var dataidx = data.lastIndexOf("[");
	return data.substring(0, dataidx-1);
}

function init(){
	var F = document.sdhcp;
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<data.length; i++)
	{
		var tmp = new Array();
		var tmpflg="";
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array(td_id[0]+idx,data[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,data[i][1],0);
		tmp[3]=new Array(td_id[2]+idx,data[i][2],2);
		for(var j=0; j<service_list.length; j++)
		{
			if ( cy_speccode_decode(skipstr(str_replace(" ","",service_list[j]))) == 
						skipstr(str_replace(" ","",data[i][3])) ) 
			{
				tmpflg = j;
				break;
			}
		}
		tmp[4]=new Array(td_id[3]+idx,service_list[tmpflg],3);
		tmp[5]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	//For change without save 
	default_nv = get_data(document.sdhcp);
}

function to_redirect(F)
{
	get_position("service_manage.asp",0);
}

var tmpdata = new Array(<% get_service_list(); %>);
var service_list = new Array();
for(var i=0; i<tmpdata.length; i++)
{
	var dataidx = tmpdata[i].lastIndexOf("[");
	var proto = tmpdata[i].substring(dataidx+1,dataidx+2);
	if ( dataidx != -1 ) 
	{
		if ( proto == "3" || proto == "5" ) 
			service_list[i] = tmpdata[i].substring(0,dataidx)+" ["+proto_list[proto]+"]";
		else
		service_list[i] = tmpdata[i].substring(0,dataidx)+" ["+proto_list[proto]+tmpdata[i].substring(dataidx+2,tmpdata[i].length);
	}
	
}

function my_valid_range(start,to,index)
{
	if ( !msg_chk_range(document.getElementById(obj_id[2]+index).value,obj_id[2]+index,start,to,10,IS_TABLE,"tmsg",img_id[2]+index,div_id[2]+index,index) ) 
		return false;
	return true;
}

function to_add()
{
	stflg = "add";
	var j=0,x=0;
	var F = document.frmqos;
	if ( idx >= NAT_1to1_ENTRY  )
        {
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,NAT_1to1_ENTRY,__T(filter.nat1to1)));
                return false;
	}
	if ( !chk_before_data(idx-1) ) return false;
	var tmp = new Array();
	tmp[j++] = new Array("tdchk_"+idx,"<input type=checkbox id=chk"+idx+" name=chk"+idx+" disabled>",3);
	tmp[j++] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=15 id="+obj_id[0]+idx+" name="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"') onblur=chk_ip("+idx+",'private')>",div_id[0]+idx),1);
	tmp[j++] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=20 maxlength=15 id="+obj_id[1]+idx+" name="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"') onblur=chk_ip("+idx+",'public')>",div_id[1]+idx),1);
	tmp[j++] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=20 id="+obj_id[2]+idx+" name="+obj_id[2]+idx+" maxlength=3 onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"') onblur=my_valid_range(1,254,"+idx+")>",div_id[2]+idx),2);
	var obj=draw_object(O_VAR,SELBOX,obj_id[3]+idx," onMouseMove=showHint('img_pservice"+idx+"','"+"div_pservice"+idx+"',event) onMouseOut=hideHint('div_pservice"+idx+"')",service_list,service_list);
	tmp[j++] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,"img_pservice"+idx,obj,"div_pservice"+idx,"","align=center"),1);
	add_row(idx,tmp,"chk",stflg,2);
	idx++;

}

function to_edit()
{
	stflg = "edit";
	var F = document.sdhcp;
	for(var i=0; i<idx; i++){
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var tmp = new Array();
			tmp[0] = draw_td(O_VAR, ICONLINE, img_id[0]+i, "<input size=20 maxlength=15 id="+obj_id[0]+i+" name="+obj_id[0]+i+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value='"+data[i][0]+"' onblur=chk_ip("+i+",'private')>",div_id[0]+i);	
			tmp[1] = draw_td(O_VAR, ICONLINE, img_id[1]+i, "<input size=20 maxlength=15 id="+obj_id[1]+i+" name="+obj_id[1]+i+" onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value='"+data[i][1]+"' onblur=chk_ip("+i+",'public')>",div_id[1]+i);	
			tmp[2] = draw_td(O_VAR, ICONLINE, img_id[2]+i, "<input size=20 maxlength=3 id="+obj_id[2]+i+" name="+obj_id[2]+i+" onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value='"+data[i][2]+"' onblur=my_valid_range(1,254,"+i+")>",div_id[2]+i);	
			tmp[3] = draw_object(O_VAR, SELBOX, obj_id[3]+i," onMouseMove=showHint('img_pservice"+idx+"','"+"div_pservice"+idx+"',event) onMouseOut=hideHint('div_pservice"+idx+"')",service_list,service_list, data[i][3]);
			edit_row(td_id,tmp,i);
		}
	}
}
</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=sdhcp method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=natdata_entry>
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.nat1to1));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","t3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","t4",__T(share.del),"to_del(this.form)");
		bt_list[3] = new Array("BT_L","t5",__T(filter.confservice),"to_redirect(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20,20,20",__T(filter.nat1to1ruletb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(filter.privrangebegin)+","+__T(filter.pubrangebegin)+","+__T(filter.rangelen)+","+__T(filter.service)+"","",bt_list,"","","2,0,0,1,2");
		</script>
		</TR>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
