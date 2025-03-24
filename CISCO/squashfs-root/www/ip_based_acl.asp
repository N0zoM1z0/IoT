<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_acl_list(); %>
if ( "<% nvram_gozila_get("backname"); %>" != "" && "<% nvram_gozila_get("backname"); %>" != "ip_based_acl.asp") 
{
        var change_cancel_bt="true";
        var back_bt="true";
}

CHK_VALUE_AUTO=0;
var action_name= new Array(__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
var conn_name= new Array(__T(filter.outbound_lan_wan),__T(filter.inbound_wan_lan),__T(filter.inbound_wan_dmz));
var log_name = new Array(__T(mang.never),__T(filter.always));
var pri_name = new Array(__T(def.low),__T(def.normal),__T(def.medium),__T(def.high));
var td_id = new Array("tdact","tdservice","tdst","tdconntype","tdsip","tddip","tdlog","tdpri");
var stflg="init";
var idx=0;
var wanipmode="<% nvram_get("wan_ip_mode"); %>";
var lanipmode="<% nvram_get("lan_ip_mode"); %>";
function to_edit(F)
{
	F.submit_button.value = "ip_based_acl_edit";
	F.stflg.value="edit";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) 
		{
			F.selidx.value = document.getElementById("list_"+i).value;
			break;
		}
	}
	F.change_action.value="gozila_cgi";
	F.submit();
}

function to_back(F)
{
        define_backname = "<% nvram_gozila_get("backname"); %>";
        parent.document.getElementById("newpage").value = "<% nvram_gozila_get("backname"); %>";
        uiDoCancel(F,"back");
}

function to_del(F)
{
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
                                del_row(i);
	}
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	choose_disable(document.getElementById("e4"));
}

function to_en(F)
{
	stflg = "enable";
	var dislist = "";
	if ( disflg != "" ) dislist = disflg.split(",");
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
		{
			for(var j=0; j<dislist.length; j++)
			{
				if ( i == dislist[j] ) 
				{
					my_alert(O_GUI,ERROR,__T(share.errmsg),__T(msg.enivalidipformat));	
					return;
				}		
			}
			document.getElementById(td_id[2]+i).innerHTML = __T(share.enabled);
		}
		else{
			document.getElementById(td_id[2]+i).innerHTML = datalist[document.getElementById("list_"+i).value].st=="1"?__T(share.enabled):__T(share.disabled);
		}
	} 
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e6"));
}

function to_dis(F)
{
        stflg = "disable";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                        document.getElementById(td_id[2]+i).innerHTML = __T(share.disabled);
                else
                        document.getElementById(td_id[2]+i).innerHTML = datalist[document.getElementById("list_"+i).value].st=="1"?__T(share.enabled):__T(share.disabled);
        }
        choose_disable(document.getElementById("e1"));
        choose_disable(document.getElementById("e2"));
        choose_disable(document.getElementById("e6"));
}

function to_add(F)
{
	if ( idx >= ACL_ENTRY || datalist.length >= ACL_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,ACL_ENTRY,__T(filter.accessrules)),"");
                return false;
        }	
	F.submit_button.value="ip_based_acl_edit";
	F.stflg.value="add";
	F.change_action.value="gozila_cgi";
	F.selidx.value = datalist.length;
	F.submit();
}

function to_order(F)
{
	goto_page("ip_based_acl_order.asp");
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("ip_based_acl.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
		
}

function uiDoSave(F){
	if ( stflg == "del" || stflg == "enable" || stflg == "disable" ) 
	{
        	F.item_list.value = "";
	        for(var i=0; i<datalist.length; i++)
        	{
			if ( document.getElementById("chk_"+i) != null && 
			     document.getElementById("chk_"+i).checked )
        	        {
                	        if ( F.item_list.value != "" )  F.item_list.value+=",";
                        	F.item_list.value+=document.getElementById("list_"+i).value;
	                }
        	}
	}
	F.stflg.value = stflg;
        F.submit_button.value="ip_based_acl";
        F.gui_action.value="Apply";
        F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) count++;
		else{
			if ( stflg == "enable" || stflg == "disable" ) 
			{
                        	document.getElementById(td_id[2]+i).innerHTML = datalist[i].st=="1"?__T(share.enabled):__T(share.disabled);
			}
		}
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,data[index]);
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		choose_disable(document.getElementById("e4"));
		choose_disable(document.getElementById("e6"));
	if ( count == 1 )
		choose_enable(document.getElementById("e2"));
	if ( count > 0 ){
		choose_enable(document.getElementById("e3"));
		choose_enable(document.getElementById("e4"));
		choose_enable(document.getElementById("e6"));
	}else	
		choose_enable(document.getElementById("e1"));
}
var disflg="";
function disable_rule(i)
{
	var ret=0;
	if ( wanipmode == "1" && lanipmode == "1" ) //LAN:IPv4,WAN:IPv4
	{
		if ( datalist[i].stype != "2" && check_ipv4(datalist[i].s_src_ip,VALID_IP_RULE1) == PASS ) ret = 1;
	}else if ( wanipmode == "1" && lanipmode == "2" ) //LAN:IPv6,WAN:IPv4
	{
		if ( datalist[i].conntype == "0" ) //Outbound ( LAN > WAN ) 
		{
			if ( datalist[i].stype != "2" && check_ipv4(datalist[i].s_src_ip,VALID_IP_RULE1) == PASS ) ret = 1;
			if ( datalist[i].stype != "2" && test_ipv6(datalist[i].s_src_ip) ){
				if ( datalist[i].dtype == "2" )  return "disabled";
				if ( datalist[i].dtype != "2" && check_ipv4(datalist[i].s_dst_ip,VALID_IP_RULE1) == PASS ) ret = 1;
			}
		}else if ( datalist[i].conntype == "1" ) //Inbound ( WAN > LAN )
		{
			if ( datalist[i].service != "All Traffic" && check_ipv4(datalist[i].s_src_ip,VALID_IP_RULE1)==PASS ) ret = 1;
		}
	}else if ( wanipmode == "2" && lanipmode == "2" ) //LAN:IPv6,WAN:IPv6
	{
		if ( datalist[i].stype != "2" && !test_ipv6(datalist[i].s_src_ip) ) ret = 1;
		if ( datalist[i].dtype != "2" && !test_ipv6(datalist[i].s_dst_ip) ) ret = 1;
	}
	if ( ret == 1 ) 
	{
		if ( disflg != "" ) disflg += ",";
		disflg += i;
	}
}

var data = new Array();

function fill_data_arr(index,i)
{
		data[index] = new Array();
		data[index][0] = action_name[datalist[i].act];
		data[index][1] = datalist[i].service;
		data[index][2] = datalist[i].st=="1"?__T(share.enabled):__T(share.disabled);
		data[index][3] = conn_name[datalist[i].conntype];
		var tmpstr = "";
                if ( datalist[i].stype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[i].s_src_ip;
                        if ( datalist[i].e_src_ip != "0" ) 
                        {
                                if ( datalist[i].stype == "1" && test_ipv6(tmpstr) ) 
                                        tmpstr += " ~ <BR>"+datalist[i].e_src_ip;
                                else
                                        tmpstr += " ~ "+datalist[i].e_src_ip;
                        }
                                
                }
		data[index][4] = tmpstr;
		if ( datalist[i].dtype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[i].s_dst_ip;
                        if ( datalist[i].e_dst_ip != "0" ) 
                        {
                                if ( datalist[i].dtype == "1" && test_ipv6(tmpstr) )
                                        tmpstr += " ~ <BR>"+datalist[i].e_dst_ip;
                                else
                                        tmpstr += " ~ "+datalist[i].e_dst_ip;
                        }
                }
		data[index][5] = tmpstr;
		data[index][6] = log_name[datalist[i].log];
}

var dmz_enable = "<% nvram_get("dmz_enable"); %>";
var dmz_ipaddr = "<% nvram_get("dmz_ipaddr"); %>";
var dmz_vid = "<% nvram_get("dmz_vid"); %>";
var lan_arr = new Array();
function LAN(vlan_id,ipaddr,netmask,proto,dhcprelay_ip,start_ip,user_num,lease_time,dns1,dns2,dns3,wins)
{
        this.vlan_id = vlan_id;
        this.ipaddr = ipaddr;
        this.netmask = netmask;
        this.proto = proto;
        this.dhcprelay_ip = dhcprelay_ip;
        this.start_ip = start_ip;
        this.user_num = user_num;
        this.lease_time = lease_time;
        this.dns1=dns1;
        this.dns2=dns2;         
        this.dns3=dns3;         
        this.wins=wins;
}
<% get_lan_data("lan_arr"); %>

function get_dmz_ip()
{
	for(var i=0; i<lan_arr.length; i++)
	{
		if ( lan_arr[i].vlan_id == dmz_vid ) 
		{
			var tmp=lan_arr[i].ipaddr.split("."); 
			return tmp[0]+"."+tmp[1]+"."+tmp[2]+"."+dmz_ipaddr;
		}
	}
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	choose_disable(document.getElementById("e4"));
	choose_disable(document.getElementById("e5"));
	choose_disable(document.getElementById("e6"));
	for(var i=0; i<datalist.length; i++)
	{
		fill_data_arr(i,i);
		var tmp = new Array();
		disable_rule(i);
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,data[i][0],3);
		tmp[2]=new Array(td_id[1]+idx,data[i][1],3);
		tmp[3]=new Array(td_id[2]+idx,data[i][2],3);
		tmp[4]=new Array(td_id[3]+idx,data[i][3],3);
		tmp[5]=new Array(td_id[4]+idx,data[i][4],0);
		if ( datalist[i].conntype == "2" ) 
			tmp[6]=new Array(td_id[5]+idx,get_dmz_ip(),0);
		else
	                tmp[6]=new Array(td_id[5]+idx,data[i][5],0);
		tmp[7]=new Array(td_id[6]+idx,data[i][6],3);
		tmp[8]=new Array("","&nbsp;");
		/*
		if ( datalist[i].conntype == "0" ) 
			tmp[8]=new Array(td_id[7]+idx,pri_name[parseInt(datalist[i].pri,10)-1],3);
		else
			tmp[8]=new Array(td_id[7]+idx,"",3);
		*/
		add_row(idx,tmp,"chk_",stflg,3);
		idx++;
	}
	if ( idx > 0 ) 
		choose_enable(document.getElementById("e5"));
	default_nv = get_data(document.frmacl);
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
                to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,data[i]);
        }       
        if ( cnt > 1 ) 
	{
		choose_enable(document.getElementById("e3"));
		choose_enable(document.getElementById("e4"));
		choose_enable(document.getElementById("e6"));
		choose_disable(document.getElementById("e1"));
	}
        if ( count == 0 ) 
	{
		choose_disable(document.getElementById("e3"));
		choose_disable(document.getElementById("e4"));
		choose_disable(document.getElementById("e6"));
		choose_enable(document.getElementById("e1"));
	}
}


function get_data(F)
{
	var data = "";
	if ( F.fw_acl_def_policy[0].checked ) data += "0,";
	else data += "1,";
	for(var i=0; i<idx; i++)
	{
		if ( stflg == "del" || stflg == "enable" || stflg == "disable" ) 
		{
	                if ( document.getElementById("chk_"+i).checked )
				data += ","+i;
			
		}	
	}
	return data;
}

function sel_type(F){
	// Delete All Rows
	for(var i=0; i<idx; i++)
		document.getElementById("_table").deleteRow(3);
	idx=0;
	for(var i=0; i<datalist.length; i++)
	{
	    if ( datalist[i].act == F.seltype.value || F.seltype.value == "-1" ) 
	    {
		fill_data_arr(idx,i);
		var tmp = new Array();
                tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",0);
                tmp[1]=new Array(td_id[0]+idx,data[idx][0],0);
                tmp[2]=new Array(td_id[1]+idx,data[idx][1],0);
                tmp[3]=new Array(td_id[2]+idx,data[idx][2],0);
                tmp[4]=new Array(td_id[3]+idx,data[idx][3],0);
                tmp[5]=new Array(td_id[4]+idx,data[idx][4],0);
                tmp[6]=new Array(td_id[5]+idx,data[idx][5],0);
                tmp[7]=new Array(td_id[6]+idx,data[idx][6],0);
		tmp[8]=new Array("","&nbsp;");
		/*
		if ( datalist[i].conntype == "0" ) 
	                tmp[8]=new Array(td_id[7]+idx,pri_name[parseInt(datalist[i].pri,10)-1],0);
		else
	                tmp[8]=new Array(td_id[7]+idx,"",0);
		*/
                add_row(idx,tmp,"chk_",stflg,3);
                idx++;		
	    }
	}
	if ( idx == 0 ) document.getElementById("_nodata").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmacl" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=stflg value=add> 
<input type=hidden name=selidx> 
<input type=hidden name=wait_time value=5> 
<input type=hidden name=item_list>
<input type=hidden name=backname>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.accessrules));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.defoutpolicy),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.policy));</script>
		<script>
			var _name = new Array(__T(filter.allow),__T(filter.deny),__T(filter.reject));
			var _val = new Array("1","0","2");
			draw_object(O_GUI,RADIO,"fw_acl_def_policy",_val,_name,"<% nvram_get("fw_acl_def_policy"); %>");
		</script>
		</TD></TR>		
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var filter_action_name= new Array(__T(syslog.event_all),__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
		var action_val = new Array("-1","0","1","2","3");
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","e3",__T(share.enable),"to_en(this.form)");
		bt_list[3] = new Array("BT","e4",__T(share.disable),"to_dis(this.form)");
		bt_list[4] = new Array("BT","e6",__T(share.del),"to_del(this.form)");
		bt_list[5] = new Array("BT","e5",__T(filter.reorder),"to_order(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,10,10,15,20,20,5",__T(filter.accessrulestb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(filter.action)+","+__T(filter.service)+","+__T(share.sts)+","+__T(filter.conntype)+","+__T(filter.sip)+","+__T(filter.dip)+","+__T(filter.log),"",bt_list,spell_words(filter_rule,__T(filter.action))+draw_object(O_VAR,SELBOX,"seltype","onChange=sel_type(this.form)",filter_action_name,action_val),"","2,2,2,2,2,0,0,2");
		</script>
		</TD></TR>
		</TABLE>
		<% web_include_file("BT.asp"); %>
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
