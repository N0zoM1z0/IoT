<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("vlan_valid_subnet.js"); %>
var idx=0;
var datalist = new Array();
var wan_netmask="<% nvram_get("wan_netmask"); %>";
var wanip = "<% nvram_get("wan_ipaddr"); %>";
var stflg = "init";
var obj_id = new Array("rname","rip","rmask","rgw","iface");
var td_id = new Array("td_rname","td_rip","td_rmask","td_rgw","td_iface");
var img_id = new Array("img_rname","img_rip","img_rmask","img_rgw","img_iface");
var div_id = new Array("div_rname","div_rip","div_rmask","div_rgw","div_iface");
var iface_val = new Array("lan", "wan");
var iface_name = new Array(__T(router.lanwireless), __T(router.waninternet));
var datalist = new Array();
var datalist_name = new Array();
<% get_static_route(); %>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.setup;
	if ( "<% nvram_get("dr_lan_tx"); %>" == "1" &&  "<% nvram_get("dr_wan_tx"); %>" == "1" ) 
		F.tx_ver[0].checked = true;
	else
		F.tx_ver[1].checked = true;
	if ( "<% nvram_get("dr_lan_rx"); %>" == "1" &&  "<% nvram_get("dr_wan_rx"); %>" == "1" ) 
		F.rx_ver[0].checked = true;
	else
		F.rx_ver[1].checked = true;
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist_name[i],0);
		tmp[2]=new Array(td_id[1]+idx,datalist[i][0],0);
		tmp[3]=new Array(td_id[2]+idx,datalist[i][1],0);
		tmp[4]=new Array(td_id[3]+idx,datalist[i][2],0);
		for(var j=0; j<iface_val.length; j++)
		{
			if ( datalist[i][3] == iface_val[j] )
			{
				tmp[5]=new Array(td_id[4]+idx,iface_name[j],3);
				break;
			}
		}
		tmp[6]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
		
	}	
	chk_RIP(F);
	default_nv = keep_val(F,"");
}

function valid_subnet1(I1,M1,I2,M2)
{
	var IP1 = new Array;
	var IP2 = new Array;
	var MASK1 = new Array;
	var MASK2 = new Array;
	var RANGE1 = new Array;
	var RANGE2 = new Array;
	var tmp,range1=0,range2=0,tmp_range=0,i;
	IP1 = I1.split(".");
	IP2 = I2.split(".");
	MASK1 = M1.split(".");
	MASK2 = M2.split(".");
	for(var j=1; j<=2; j++){
		for(var i=0; i<4; i++)
		{
			if ( eval("MASK"+j)[i] == 255 && eval("IP"+j)[i] == 0 ) 
				tmp = 255;
			else
				tmp = eval("IP"+j)[i] & eval("MASK"+j)[i];  
			
			if ( j == 1 )
				RANGE1[i] = tmp;
			else
				RANGE2[i] = tmp;
		}
	}
	
	for(var j=1; j<=2; j++){
		for(var i=0; i<4; i++)
		{
			if (eval("RANGE"+j)[i] == 0 ){
				if ( i == 1 ){
					if ( eval("RANGE"+j)[2] == 0 && eval("RANGE"+j)[3] == 0 ) tmp_range = 3;
					break;
				}else if ( i == 2 ){
					if ( eval("RANGE"+j)[3] == 0 ) tmp_range = 2;
					break;
				}else if ( i == 3 ){
					tmp_range=1;
					break;
				}
			}
		}
		if ( j == 1 ) range1 = tmp_range;
		else range2=tmp_range;
	}
	if ( range1 == 3 || range2 == 3 ) 
	{
		if ( RANGE1[0] != RANGE2[0] ) return true;	
	}else if ( range1 == 2 || range2 == 2 )
	{ 
		for(i=0; i<2; i++)
			if ( RANGE1[i] != RANGE2[i] ) return true;	
	}else if ( range1 == 1 || range2 == 1 ) 
	{
		for(i=0; i<3; i++)
			if ( RANGE1[i] != RANGE2[i] ) return true;	
	}else{
		for(i=0; i<4; i++)
			if ( RANGE1[i] != RANGE2[i] ) return true;	
	}
	return false;
}

function get_data(F)
{
	var data="", name_data="";
	var del_route="";
	if ( stflg == "del" )
        {
		for(var i=0; i<idx; i++)
		{
			if ( del_route != "" ) del_route+=" ";	
        		if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
	                {
				for(var j=0; j<datalist[i].length; j++)
				{
					if ( j!=0 && data != "" ) del_route+=":";
					del_route+= datalist[i][j];
				}
        	        }
		}
		F.static_del.value = del_route;
        }

	for(var i=0; i<idx; i++)
	{
        	if ( stflg=="del" && document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
			continue;
		if ( data != "" ) data+=" ";
		if ( name_data != "" ) name_data+=" ";
		name_data+="$NAME:";
		if ( document.getElementById(obj_id[0]+i) )
		{
			name_data += document.getElementById(obj_id[0]+i).value;
			for(var j=1; j<obj_id.length; j++)
			{
				if ( j!=1 && data != "" ) data+=":";
				data += document.getElementById(obj_id[j]+i).value;	
				
			}
		}else{
			name_data += datalist_name[i];
			for(var j=0; j<datalist[i].length; j++)
			{
				if ( j!=0 && data != "" ) data+=":";
				data+= datalist[i][j];
			}
		}
		name_data+="$$";
	}
	//alert("data="+data+";name_data="+name_data);
	F.static_route.value = data;
	F.static_route_name.value = name_data;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("routing.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	if ( stflg != "del" ) 
	{
		for(var i=0; i<idx; i++)
		{
			if ( !chk_before_data(i) ) return false;
		}
		var ip_a,mask_a,ip_b,mask_b;
		for(var i=0; i<idx; i++)
		{
			for(var j=i+1; j<idx; j++)
			{
				if ( document.getElementById(obj_id[0]+i) )
				{
					ip_a = document.getElementById(obj_id[1]+i).value;
					mask_a = document.getElementById(obj_id[2]+i).value;	
				}else{
					ip_a = document.getElementById(td_id[1]+i).innerHTML;
					mask_a = document.getElementById(td_id[2]+i).innerHTML;	
				}
				if ( document.getElementById(obj_id[0]+j) )
				{
					ip_b = document.getElementById(obj_id[1]+j).value;
					mask_b = document.getElementById(obj_id[2]+j).value;	
				}else{
					ip_b = document.getElementById(td_id[1]+j).innerHTML;
					mask_b = document.getElementById(td_id[2]+j).innerHTML;	
				}
				if ( !valid_subnet1(ip_a,mask_a,ip_b,mask_b) ) 
				{
					if ( document.getElementById(obj_id[0]+i) )
					{
						table_msg(img_id[1]+i,obj_id[1]+i,div_id[1]+i,i,__T(msg.ruleexist));
					}
					if ( document.getElementById(obj_id[0]+j) )
					{
						table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j,j,__T(msg.ruleexist));
					}
					return false;
				}
			}
		}
	}
	get_data(F);
	F.dr_setting.value=0;
	if ( F._dr_setting.checked == true ) 
		F.dr_setting.value=3;
	if ( F.tx_ver[0].checked == true ) 
	{
		F.dr_lan_tx.value = 1 ; 
		F.dr_wan_tx.value = 1 ; 
	}else{
		F.dr_lan_tx.value = 2 ; 
		F.dr_wan_tx.value = 2 ; 
	}
	if ( F.rx_ver[0].checked == true ) 
        {
                F.dr_lan_rx.value = 1 ;
                F.dr_wan_rx.value = 1 ;
        }else{
                F.dr_lan_rx.value = 2 ;
                F.dr_wan_rx.value = 2 ;
        }
	F.inter_route.value = 0;
	if ( F._inter_route.checked == true ) 
		F.inter_route.value = 1;
        //F.route_name.value = F._route_name.value;
        F.submit_button.value = "routing";
        F.gui_action.value = "Apply";
	if ( http_from == "wan" ) 
	{
		F.wait_time.value = "15";	
		setTimeout("chk_st()", 15000);
	}	
        F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
function chk_RIP(F){
	if ( F._dr_setting.checked == true ) 
	{
		choose_enable(F.tx_ver[0]);
		choose_enable(F.tx_ver[1]);
		choose_enable(F.rx_ver[0]);
		choose_enable(F.rx_ver[1]);
	}else{
		choose_disable(F.tx_ver[0]);
		choose_disable(F.rx_ver[0]);
		choose_disable(F.tx_ver[1]);
		choose_disable(F.rx_ver[1]);
	}
}

function chk_ip(index)
{
	clear_table_msg("tmsg",img_id[1]+index,obj_id[1]+index,index);
	if ( check_ipv4(document.getElementById(obj_id[1]+index).value,VALID_IP_RULE7,ZERO_NO) != PASS )
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.ivalidipformat));
		return false;
	}
	// DESTs IP cannot in the LAN Subnet
	if ( lan_subnet_ip(document.getElementById(obj_id[1]+index).value) ) 
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.invalidroute1));
		return false;
	}
	return true;
}

function chk_mask(index)
{
	var F = document.setup;
	clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
	var errmsg = valid_mask_msg(F,"rmask"+index,ZERO_NO|BCST_OK);
	if ( errmsg != "" ) 
	{
		table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,errmsg);
		return false;
	}
	return true;
}

function chk_gw(index)
{
	clear_table_msg("tmsg",img_id[3]+index,obj_id[3]+index,index);
	if ( check_ipv4(document.getElementById(obj_id[3]+index).value,VALID_IP_RULE7,ZERO_NO) != PASS )
	{
		table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.ivalidipformat));
		return false;
	}
	if ( document.getElementById(obj_id[3]+index).value == wanip ) //GW==WANIP
	{
		table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.subnet7));
		return false;
	}
	return true;
}

function chk_name(index)
{
	clear_table_msg("tmsg",img_id[0]+index,obj_id[0]+index,index);
	var errmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id[0]+index).value,ZERO_NO,obj_id[0]+index);
	if ( errmsg != "" ) 
	{
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,errmsg);
		return false;
	}
	var obji, objj;
	for(var i=0; i<idx; i++)
	{
		for( j=i+1; j<idx; j++ )
		{
			if ( document.getElementById(obj_id[0]+i) ) 
				obji =  document.getElementById(obj_id[0]+i).value;
			else
				obji = document.getElementById(td_id[0]+i).innerHTML;
			if ( document.getElementById(obj_id[0]+j) ) 
				objj =  document.getElementById(obj_id[0]+j).value;
			else
				objj = document.getElementById(td_id[0]+j).innerHTML;
			
			if ( obji == objj ) 
			{
				if ( document.getElementById(obj_id[0]+i) ) 
					table_msg(img_id[0]+i,obj_id[0]+i,div_id[0]+i,i,__T(msg.nameexist));
				if ( document.getElementById(obj_id[0]+j) ) 
					table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j,__T(msg.nameexist));
				return false;
			}
		}
	}
	
	return true;
}

function valid_ip_mask(I,M)
{
        var IP = new Array(4);
        var NM = new Array(4);
        IP = I.split(".");
        NM = M.split(".");
        for(i=0;i<4;i++){
                if((IP[i] | NM[i]) != NM[i]){
                        return false;
                }
        }
        return true;
}


function chk_before_data(index)
{
	var F = document.setup;
	var iface = "lan";
	if ( document.getElementById(obj_id[0]+index) )
	{
		iface = document.getElementById(obj_id[4]+index).value;
		if ( !valid_ip_mask( document.getElementById(obj_id[1]+index).value,
				    document.getElementById(obj_id[2]+index).value) )
		{
			table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.invalidroute));
			table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,__T(msg.invalidroute));
			return false;
		}
		if ( !chk_name(index) ) return false;
		if ( !chk_mask(index) ) return false;
		if ( !chk_ip(index) ) return false;
		if ( !chk_gw(index) ) return false;
		if ( ( iface == "lan" && !lan_subnet_ip(document.getElementById(obj_id[3]+index).value) ) ||  
		     ( iface == "wan" && wanip == "0.0.0.0" && wan_netmask == "0.0.0.0" ) ||
		     ( iface == "wan" && !valid_subnet(document.getElementById(obj_id[3]+index).value,wan_netmask,wanip) ) )
		{
			table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.subnet6));
			return false;
		}
		if ( iface == "lan" ){
			if ( !lan_subnet_mask(document.getElementById(obj_id[3]+index).value) ) 
			{
				table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.illegalipformat));
				return false;
			}
		}else if ( iface == "wan" ){
			/* Should allow the 0 or 255 in the last field.
        		if ( !valid_ip_in_subnet(document.getElementById(obj_id[3]+index).value,wan_netmask) )
			{
				table_msg(img_id[3]+index,obj_id[3]+index,div_id[3]+index,index,__T(msg.illegalipformat));
				return false;
			}*/
			
		}
	}
	return true;	
}

function to_del(){
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
			del_row(i);
	}
}

function to_edit()
{
	stflg = "edit";
	for(var i=0; i<idx; i++){
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var data = new Array();
			data[0]= draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=32 id="+obj_id[0]+i+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value='"+datalist_name[i]+"' onblur=chk_name("+i+")>",div_id[0]+i);
			data[1]= draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=20 maxlength=32 id="+obj_id[1]+i+" onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value='"+datalist[i][0]+"' chk_ip("+i+")>",div_id[1]+i);
			data[2]= draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=20 maxlength=32 id="+obj_id[2]+i+" onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value='"+datalist[i][1]+"' chk_mask("+i+")>",div_id[2]+i);
			data[3]= draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input size=20 maxlength=32 id="+obj_id[3]+i+" onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') value='"+datalist[i][2]+"' chk_gw("+i+")>",div_id[3]+i);
			data[4]= draw_td(O_VAR,ICONLINE,img_id[4]+i,draw_object(O_VAR,SELBOX,obj_id[4]+i,"",iface_name,iface_val,datalist[i][3]),div_id[4]+i);
			edit_row(td_id,data,i);
		}
	}
	
}	

function to_add()
{
	if ( idx >= STATIC_ROUTE_MAX_ENTRY )
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,STATIC_ROUTE_MAX_ENTRY,__T(router.strouting)),"");
		return false;	
	}	
	if ( !chk_before_data(idx-1) ) return false;
	stflg="add";
	var tmp = new Array();
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=32 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"') onblur=chk_name("+idx+")>",div_id[0]+idx),1);
	tmp[2]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=20 maxlength=32 id="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"') onblur=chk_ip("+idx+")>",div_id[1]+idx),1);
	tmp[3]=new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=20 maxlength=32 id="+obj_id[2]+idx+" onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"') onblur=chk_mask("+idx+")>",div_id[2]+idx),1);
	tmp[4]=new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=20 maxlength=32 id="+obj_id[3]+idx+" onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"') onblur=chk_gw("+idx+")>",div_id[3]+idx),1);
	tmp[5]=new Array(td_id[4]+idx,draw_td(O_VAR,ICONLINE,img_id[4]+idx,draw_object(O_VAR,SELBOX,obj_id[4]+idx,"",iface_name,iface_val),div_id[4]+idx),1);
	tmp[6]=new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}
function chk_all()
{
	for(var i=0; i<idx; i++)	
	{
		if ( document.getElementById("chk_"+i) == null ) continue;
		if ( document.getElementById("chkall").checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		chk_click(i);
	}
}

function chk_click(index){
	var nv_arr = new Array();
	nv_arr[0] = datalist_name[index];
	for(var i=0; i<datalist[index].length; i++)
	{
		if ( i == datalist[index].length-1 ) 
		{ 
			for(var j=0; j<iface_val.length; j++)
			{
				if ( datalist[index][i] == iface_val[j] )
				{
					nv_arr[i+1] = iface_name[j];
					break;
				}
			}
		}else
			nv_arr[i+1] = datalist[index][i];
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,nv_arr);
}

function SelMode(mode,F)
{
	/*
        if(mode == "gateway")
        {
                choose_disable(document.getElementById("rip_enable"));
                DISABLE_PART(F,"dynamic_routing_start","dynamic_routing_end",1);
        }
        else
        {
                choose_enable(document.getElementById("rip_enable"));
                DISABLE_PART(F,"dynamic_routing_start","dynamic_routing_end",0);
        }*/
}


</script>
<body onload="init();" onresize=chgwin()>
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=static_route>
<input type=hidden name=static_route_name>
<input type=hidden name=static_del>
<input type=hidden name=inter_route>
<input type=hidden name=dr_setting>
<input type=hidden name=dr_lan_tx>
<input type=hidden name=dr_wan_tx>
<input type=hidden name=dr_lan_rx>
<input type=hidden name=dr_wan_rx>
<input type=hidden name=wait_time value=1>
<input type=hidden name="route_ipaddr" value="4">
<input type=hidden name="route_netmask" value="4">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.routing),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(router.operatingmode),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(router.operatingmode));
		var _name = new Array(__T(share.gateway),__T(share.router));
		var _val = new Array("gateway","router");
		draw_object(O_GUI,RADIO,"wk_mode",_val,_name,"<% nvram_get("wk_mode"); %>","onClick=SelMode(this.value,this.form)");
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>

		<input type=hidden name=dynamic_routing_start>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(router.drouting),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(router.rip));</script>
		<input type=checkbox id=rip_enable name=_dr_setting onClick=chk_RIP(this.form) <% nvram_match("dr_setting","3","checked"); %>> <script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(router.ripsendpver));</script>
		<input type=radio value=0 name=tx_ver><script>Capture(mang.ripv1);</script>  
		<input type=radio value=1 name=tx_ver><script>Capture(mang.ripv2);</script> 
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(router.riprecvpver));</script>
		<input type=radio value=0 name=rx_ver><script>Capture(mang.ripv1);</script>  
		<input type=radio value=1 name=rx_ver><script>Capture(mang.ripv2);</script> 
		</TD></TR>
		<input type=hidden name=dynamic_routing_end>
		<INPUT type=hidden value=0 name=login_status>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(router.intervlanrouting),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(router.intervlanrouting),SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=_inter_route <% nvram_match("inter_route","1","checked"); %>> <script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(router.strouting),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,15,15,15,15,15",__T(router.stroutingtb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(router.routename)+","+__T(ipv6.destlanip)+","+__T(wan.mask)+","+__T(wan.gw)+","+__T(share.iface)+"","add,edit,del","","","","2,0,0,0,0,2");
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
