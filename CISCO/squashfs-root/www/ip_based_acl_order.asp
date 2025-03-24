<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var back_bt = "true"; 
var datalist = new Array();
<% get_acl_list(); %>
CHK_VALUE_AUTO=0;

var action_name= new Array(__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
var conn_name= new Array(__T(filter.outbound_lan_wan),__T(filter.inbound_wan_lan),__T(filter.inbound_wan_dmz));
var log_name = new Array(__T(mang.never),__T(filter.always));
var pri_name = new Array(__T(def.low),__T(def.normal),__T(def.medium),__T(def.high));
var td_id = new Array("tdpri","tdact","tdservice","tdst","tdconntype","tdsip","tddip","tdlog");

var stflg="init";
var idx=0;
var order_list;

function chk_click(index)
{
	if ( idx < 1 ) return;
	var count=0;
	for(i=0; i<idx; i++)
	{
		choose_enable(document.getElementById("chk_"+i));
		if ( document.getElementById("chk_"+i).checked )count++;	
	}
	if ( count > 0 ) 
	{
		for(i=0; i<idx; i++){
			if ( document.getElementById("chk_"+i).checked )
			{
				if ( i != 0 && i != idx-1 ){
					choose_enable(document.getElementById("e1"));
					choose_enable(document.getElementById("e3"));
				}
                                else if ( i != 0 )
					choose_enable(document.getElementById("e1"));
				else if ( i != idx-1 )
					choose_enable(document.getElementById("e3"));
			}else
				choose_disable(document.getElementById("chk_"+i));
		}
		choose_enable(document.getElementById("e2"));
	}else{
		choose_disable(document.getElementById("e1"));
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
	}
}

function init()
{
	order_list="";
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		/*
		if ( datalist[i].conntype == "0" ) 
                	tmp[1]=new Array(td_id[0]+idx,pri_name[parseInt(datalist[i].pri,10)],3);
		else
			tmp[1]=new Array(td_id[0]+idx,"",3);
		*/
		tmp[1]=new Array(td_id[1]+idx,action_name[datalist[i].act],3);
		tmp[2]=new Array(td_id[2]+idx,datalist[i].service,3);
		tmp[3]=new Array(td_id[3]+idx,datalist[i].st=="1"?__T(share.enabled):__T(share.disabled),3);
		tmp[4]=new Array(td_id[4]+idx,conn_name[datalist[i].conntype],0);
		var tmpstr = "";
                if ( datalist[i].stype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[i].s_src_ip;
                        if ( datalist[i].stype == "1" )
                                tmpstr += " - "+datalist[i].e_src_ip;
                }
                tmp[5]=new Array(td_id[5]+idx,tmpstr,0);
		if ( datalist[i].dtype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[i].s_dst_ip;
                        if ( datalist[i].dtype == "1" )
                                tmpstr += " - "+datalist[i].e_dst_ip;
                }
                tmp[6]=new Array(td_id[6]+idx,tmpstr,0);
                tmp[7]=new Array(td_id[7]+idx,log_name[datalist[i].log],3);
		tmp[8]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		if ( order_list != "" ) order_list+=",";
		order_list+=idx;
		idx++;
	}
	default_nv = get_data(document.frmacl);
}

function to_up()
{
	var tmp = order_list.split(",");
	var data="";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) 
		{
			data = tmp[i]
			tmp[i]=tmp[i-1];
			tmp[i-1]=data;		
		}else
			tmp[i] = tmp[i];
	}
	order_list="";
	for(var i=0; i<tmp.length; i++)
	{
		if ( order_list != "" ) order_list +=",";
		order_list+=tmp[i];
	}
	show_order();
}

function to_down()
{
        var tmp = order_list.split(",");
        var data="";
	var order_data=order_list;
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked )
                {
                        data = tmp[i]
                        tmp[i]=tmp[i+1];
                        tmp[i+1]=data;
                }else
                        tmp[i] = tmp[i];
        }
        order_list="";
        for(var i=0; i<tmp.length; i++)
        {
                if ( order_list != "" ) order_list +=",";
                order_list+=tmp[i];
        }
        show_order();
}

function to_move(){
	var tmp = order_list.split(",");
        var data="";
	var F = document.frmacl; 
	var chkidx = -1;
        for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) 
		{
			chkidx = i;
			break;
		}
	}
	if ( chkidx != -1 ) 
	{
        	data = tmp[chkidx]
                tmp[chkidx]=tmp[F.selmove.selectedIndex];
                tmp[F.selmove.selectedIndex]=data;
        }
        order_list="";
        for(var i=0; i<tmp.length; i++)
        {
                if ( order_list != "" ) order_list +=",";
                order_list+=tmp[i];
        }
        show_order();
}

function to_back(F){
	parent.document.getElementById("newpage").value = "ip_based_acl.asp";
	uiDoCancel(F,"back");
}

function show_order()
{
	for(var i=0; i<idx; i++)
		document.getElementById("_table").deleteRow(2);
	idx=0;
	var tmpdata = order_list.split(",");
	for(var i=0; i<datalist.length; i++)
        {
                var tmp = new Array();
                tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		/*
		if ( datalist[tmpdata[i]].conntype == "0" ) 
                	tmp[1]=new Array(td_id[0]+idx,pri_name[parseInt(datalist[tmpdata[i]].pri,10)],3);
		else
			tmp[1]=new Array(td_id[0]+idx,"",3);
		*/
                tmp[1]=new Array(td_id[1]+idx,action_name[datalist[tmpdata[i]].act],3);
                tmp[2]=new Array(td_id[2]+idx,datalist[tmpdata[i]].service,3);
                tmp[3]=new Array(td_id[3]+idx,datalist[tmpdata[i]].st=="1"?__T(share.enabled):__T(share.disabled),3);
                tmp[4]=new Array(td_id[4]+idx,conn_name[datalist[tmpdata[i]].conntype],0);
                var tmpstr = "";
                if ( datalist[tmpdata[i]].stype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[tmpdata[i]].s_src_ip;
                        if ( datalist[tmpdata[i]].stype == "1" )
                                tmpstr += " - "+datalist[tmpdata[i]].e_src_ip;
                }
                tmp[5]=new Array(td_id[5]+idx,tmpstr,0);
                if ( datalist[tmpdata[i]].dtype == "2" ) tmpstr = __T(filter.any);
                else{
                        tmpstr = datalist[tmpdata[i]].s_dst_ip;
                        if ( datalist[tmpdata[i]].dtype == "1" )
                                tmpstr += " - "+datalist[tmpdata[i]].e_dst_ip;
                }
                tmp[6]=new Array(td_id[6]+idx,tmpstr,3);
                tmp[7]=new Array(td_id[7]+idx,log_name[datalist[tmpdata[i]].log],3);
		tmp[8]=new Array("","&nbsp;");
                add_row(idx,tmp,"chk_",stflg,2);
                idx++;
	}
	choose_disable(document.getElementById("e1"));	
	choose_disable(document.getElementById("e2"));	
	choose_disable(document.getElementById("e3"));	
}

function get_data(F)
{
	return order_list;
}

function uiDoSave(F)
{
	F.submit_button.value = "ip_based_acl";
	F.acl_orderlist.value=order_list;
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmacl" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=acl_orderlist> 
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.accessrules));</script></TR>
  <TR><TD colspan=2>
		<script>
//	        var _name= new Array("All","Inbound","Outbound");
		var bt_list = new Array();
		bt_list[0] = draw_object(O_VAR,BT,"","e1","BT_UP","to_up()");
		bt_list[1] = draw_object(O_VAR,BT,"","e3","BT_DOWN","to_down()");
		bt_list[2] = new Array("BT","e2",__T(filter.moveto),"to_move()");
		var move_name;
		if ( datalist.length > 0 ) 
			move_name = new Array("ISRANGE","1",datalist.length,1);
		bt_list[3] = draw_object(O_VAR,SELBOX,"selmove",move_name,move_name);
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,10,15,15,15,5,5",__T(filter.accessrulestb),"&nbsp;,"+__T(filter.action)+","+__T(filter.service)+","+__T(share.sts)+","+__T(filter.conntype)+","+__T(filter.sip)+","+__T(filter.dip)+","+__T(filter.log),"",bt_list,"","","2,2,2,2,0,0,2,2");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
