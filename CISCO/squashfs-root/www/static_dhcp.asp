<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var datalist = new Array();
<% get_lan_host_data(); %>
function AAA(name,ip,mac,type,is_static,dev)
{
        this.name = name;
        this.ip = ip;
        this.mac = mac;
        this.type = type;
        this.is_static = is_static;
        this.dev = dev;
}
CHK_VALUE_AUTO=0;
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
var nv_vlan_id="<% dhcp_static_get("vlan_id"); %>";
var dhcp_static = new Array();
<% dhcp_static_get(); %>
 
idx=0;
var stflg="init";
var td_id=new Array("td_desc","td_ip","td_mac");
var obj_id=new Array("desc","ip","mac");
var img_id=new Array("img_desc","img_ip","img_mac");
var div_id=new Array("div_desc","div_ip","div_mac");
var current_ip = "";
var current_mask = "";
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
		var arr_nv=new Array();
		for(j=0; j<dhcp_static[i].length; j++)
		{
			if ( j == 1 ) 
				arr_nv[j] = prefix_ip(F)+dhcp_static[i][j];
			else
				arr_nv[j] = dhcp_static[i][j];
		}
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,arr_nv);
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
                                continue;
                        }
                }
		if ( data != "" ) data+=";";
		for(var j=0; j<2; j++)
		{
			if ( document.getElementById(obj_id[j+1]+i) == null ) 
			{
				if ( j == 0 ) 
					data += parseInt(document.getElementById(td_id[j+1]+i).innerHTML.split(".")[3].replace(/^\s*/,""),10);
				else 
					data += document.getElementById(td_id[j+1]+i).innerHTML;
			}
			else{
				if ( j == 1 ) 
					data += mac12to17(document.getElementById(obj_id[j+1]+i).value);
				else
					data += parseInt(document.getElementById(obj_id[j+1]+i).value,10);
			}
			data+=",";
		}
		var dname = "";
		if ( document.getElementById(obj_id[0]+i) == null )
			dname = cy_speccode_decode(document.getElementById(td_id[0]+i).innerHTML);
		else
			dname = cy_speccode_decode(document.getElementById(obj_id[0]+i).value);
		if ( dname.length < 10 ) 
			data+="0";
		data += dname.length;
		data += dname;
	}
	F.dhcp_statics.value = data;
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

function uiDoSave(F)
{
	
	for(var i=0; i<idx; i++)
		if ( !chk_before_data(i) ) return false;
	get_data(F);
	F.submit_button.value="static_dhcp";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	
}

function chk_before_data(index)
{
	var errflg =0;
	if ( document.getElementById(obj_id[0]+index) )
	{
		/*
		for( var i=0; i<datalist.length; i++)
		{
			var obj_ip = (datalist[i].ip).split(".");
                        if ( (document.getElementById(obj_id[1]+index).value == obj_ip[3]) &&
                             (document.getElementById(obj_id[2]+index).value != datalist[i].mac) )
			{
				table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,spell_words(ipused_rule,datalist[i].mac));
				return false;
			} 
		}*/
		if ( !chk_valid_mac(index) ) errflg = 1;
		if ( !chk_valid_ip(index,'save') ) errflg = 1;
		if ( !chk_valid_desc(index) ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
        return true;
}

function chk_valid_mac(index){
	clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
 	var cmpdata = new Array();
	var errmsg = valid_macs_all(document.getElementById(obj_id[2]+index).value);

	if ( errmsg != "" ) 
	{
		table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,errmsg);
		return false;
	}

	for(var i=0; i<idx; i++)
	{
                if (document.getElementById(obj_id[2]+i) == null && document.getElementById(td_id[2]+i) == null ) continue;
                if (document.getElementById(obj_id[2]+i) == null )
                        cmpdata[i] = document.getElementById(td_id[2]+i).innerHTML;
                else
                        cmpdata[i] = document.getElementById(obj_id[2]+i).value;
	}

        for(var j=0; j<cmpdata.length; j++)
        {
                clear_table_msg("tmsg",img_id[2]+j,obj_id[2]+j,j);
                if ( document.getElementById(obj_id[2]+j) )
                        document.getElementById(obj_id[2]+j).style.display="";
                if ( j == index ) continue;
                if ( mac12to17(cmpdata[index].toUpperCase()) == mac12to17(cmpdata[j].toUpperCase()) )
                {
			if ( document.getElementById(img_id[2]+index) != null )
                        table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,__T(msg.macexist));
			if ( document.getElementById(img_id[2]+j) != null)
                        table_msg(img_id[2]+j,obj_id[2]+j,div_id[2]+j,j, __T(msg.macexist));
                        return false;
                }
	}
	return true;	
}

function chk_valid_ip(index,type){
	var ipaddr;
 	var cmpdata = new Array();
	var F = document.sdhcp;
	for(var i=0; i<lan_arr.length; i++)
        {
                if ( lan_arr[i].vlan_id == F.vlan_id.value )
                {
                        var lanip = (lan_arr[i].ipaddr).split(".");
                        break;
                }
	}
	clear_table_msg("tmsg",img_id[1]+index,obj_id[1]+index,index);
	if (document.getElementById(obj_id[1]+index)) 
		ipaddr = document.getElementById(obj_id[1]+index).value;
	else 
		ipaddr = document.getElementById(obj_id[1]+index).innerHTML;
//	if((ipaddr == "") || !chk_range(ipaddr,"1","254"))
	if((ipaddr == "") || !chk_range(obj_id[1]+index,ipaddr,"1","254"))
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,spell_words(range_rule,"1","254"));
                return false;
	}
	if(ipaddr == lanip[3] ) 
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.subnet4));
                return false;
	}
	if ( type == "field" ) 
	{ 
	for( var i=0; i<datalist.length; i++)
	{
		var obj_ip = (datalist[i].ip).split(".");
		
                if ( (valid_subnet(current_ip,current_mask,datalist[i].ip)) &&
		     (parseInt(document.getElementById(obj_id[1]+index).value,10) == parseInt(obj_ip[3],10) ) &&
//                     (document.getElementById(obj_id[2]+index).value != datalist[i].mac) )
			(document.getElementById(obj_id[2]+index).value.toUpperCase() != datalist[i].mac.toUpperCase()) )
		{
			table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,spell_words(ipused_rule,datalist[i].mac));
			return false;
		} 
                if ( (parseInt(document.getElementById(obj_id[1]+index).value,10) != parseInt(obj_ip[3],10)) &&
                     (document.getElementById(obj_id[2]+index).value.toUpperCase() == datalist[i].mac.toUpperCase()) )
		{
                        my_alert(O_GUI,INFO,__T(share.info),__T(msg.ipused),"alert_result(0)");
		}
	}
	}
	
	for(var i=0; i<idx; i++)
	{
                if (document.getElementById(obj_id[1]+i) == null && document.getElementById(td_id[1]+i) == null ) continue;
                if (document.getElementById(obj_id[1]+i) == null )
                        cmpdata[i] = document.getElementById(td_id[1]+i).innerHTML;
                else
                        cmpdata[i] = prefix_ip(document.sdhcp)+parseInt(document.getElementById(obj_id[1]+i).value,10);
	}
	

        for(var j=0; j<cmpdata.length; j++)
        {
                clear_table_msg("tmsg",img_id[1]+j,obj_id[1]+j,j);
                if ( document.getElementById(obj_id[1]+j) )
                        document.getElementById(obj_id[1]+j).style.display="";
                if ( j == index ) continue;
                if ( cmpdata[index] == cmpdata[j] )
                {
			if ( document.getElementById(img_id[1]+index) != null )
                        	table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.ipexist));
			if ( document.getElementById(img_id[1]+j) != null )
                        	table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j,j, __T(msg.ipexist));
                        return false;
                }
	}
	return true;	

}

function chk_valid_desc(index)
{
	clear_table_msg("tmsg",img_id[0]+index,obj_id[0]+index,index);
 	var cmpdata = new Array();
	if ( document.getElementById(obj_id[0]+index) && document.getElementById(obj_id[0]+index).value==""){
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index, index,__T(msg.notblank));
                return false;	
	}
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id[0]+index).value,ZERO_NO,obj_id[0]+index);
	if ( returnmsg != "" )  
	{
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,returnmsg);
                return false;	
	}
	
	for(var i=0; i<idx; i++)
        {
                if (document.getElementById(obj_id[0]+i) == null && document.getElementById(td_id[0]+i) == null ) continue;
                if (document.getElementById(obj_id[0]+i) == null )
                        cmpdata[i] = document.getElementById(td_id[0]+i).innerHTML;
                else
                        cmpdata[i] = document.getElementById(obj_id[0]+i).value;
        }
        for(var j=0; j<cmpdata.length; j++)
        {
                clear_table_msg("tmsg",img_id[0]+j,obj_id[0]+j,j);
                if ( document.getElementById(obj_id[0]+j) )
                        document.getElementById(obj_id[0]+j).style.display="";
                if ( j == index ) continue;
                if ( cmpdata[index] == cmpdata[j] )
                {
                        table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,__T(msg.descexist));
                        table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j, __T(msg.descexist));
                        return false;
                }
	}
	return true;	
}

function chk_click(index){
	var F = document.sdhcp;
	var nv_arr=new Array();
	for(var i=0; i<dhcp_static[index].length; i++)
	{
		if( i == 1 ) 
			nv_arr[i] = prefix_ip(F)+dhcp_static[index][i];
		else
			nv_arr[i] = dhcp_static[index][i];
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,nv_arr);
}

function to_add()
{
	if ( idx >= STATIC_DHCP_ENTRY )
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,STATIC_DHCP_ENTRY,__T(lan.staticdhcp)),"");
		return false;	
	}	
	if ( !chk_before_data(idx-1) ) return false;
	var F = document.sdhcp;
	var tmp = new Array();
	stflg="add";
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
//	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=32 id="+obj_id[0]+idx+" onBlur=chk_valid_desc("+idx+") onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=32 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	tmp[2]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,prefix_ip(F)+"<input size=4 maxlength=3 id="+obj_id[1]+idx+" onBlur=chk_valid_ip("+idx+",'field') onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx),1);
	tmp[3]=new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=20 maxlength=17 id="+obj_id[2]+idx+" onBlur=chk_valid_mac("+idx+") onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"')>",div_id[2]+idx),1);
	tmp[4]=new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function to_delete()
{
        var table_id="_table";
        var tbody = document.getElementById(table_id).getElementsByTagName("TBODY")[0];
	var len=0;
	for(var i=0; i<idx; i++)
	{
		chkst = document.getElementById("chk"+i).checked ;
		if ( chkst == true ) 
		{
			len++;
        		if (document.getElementById("tr"+table_id+i) != 'undefined')
			{
		                tbody.removeChild(document.getElementById("tr"+table_id+i));
			}
		}
	}
	//alert("len="+len+";idx="+idx);
	if ( len == idx ) // Delete all
		document.getElementById("_nodata").style.display="";

}

function to_edit(){
	stflg = "edit";
	var F = document.sdhcp;
	for(var i=0; i<idx; i++){
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var data = new Array();
//			data[0]= draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=32 id="+obj_id[0]+i+" onBlur=chk_valid_desc("+i+") onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value='"+cy_speccode_decode(dhcp_static[i][0])+"'>",div_id[0]+i);
			data[0]= draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=32 id="+obj_id[0]+i+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value='"+cy_speccode_decode(dhcp_static[i][0])+"'>",div_id[0]+i);
			data[1]= draw_td(O_VAR,ICONLINE,img_id[1]+i,prefix_ip(F)+"<input size=4 maxlength=3 id="+obj_id[1]+i+" onBlur=chk_valid_ip("+i+",'field') onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value="+dhcp_static[i][1]+">",div_id[1]+i);
			data[2]= draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=20 maxlength=17 id="+obj_id[2]+i+" onBlur=chk_valid_mac("+i+") onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+dhcp_static[i][2]+">",div_id[2]+i);
			edit_row(td_id,data,i);
		}
	}
}

function init(){
	var F = document.sdhcp;
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<dhcp_static.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array(td_id[0]+idx,dhcp_static[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,prefix_ip(F)+dhcp_static[i][1],0);
		tmp[3]=new Array(td_id[2]+idx,mac12to17(dhcp_static[i][2]),0);
		tmp[4]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	//For change without save 
	default_nv = get_data(document.sdhcp);
}

function prefix_ip(F){
	var str;
	for(var i=0; i<lan_arr.length; i++)
        {
                if ( lan_arr[i].vlan_id == F.vlan_id.value )
                {
                        str = (lan_arr[i].ipaddr).split(".");
                        break;
                }
        }
	current_ip = lan_arr[i].ipaddr;
	current_mask = lan_arr[i].netmask;
	return str[0]+" . "+str[1]+" . "+str[2]+" . ";
}

function chg_vid(F)
{
	F.vlan_id.value = F.vlan_id[F.vlan_id.selectedIndex].value;
	//alert("vlan_id="+F.vlan_id.value);
	F.submit_button.value="static_dhcp";
	F.change_action.value="gozila_cgi";
	F.submit();
}
</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=sdhcp method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name="dhcp_statics">
<input type=hidden name="dhcp_statics_desc">
<input type=hidden name=wait_time value=15>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.staticdhcp));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.vlan));</script>
                <script>                 
		var tmp = "<% nvram_get("vlan_group"); %>".replace(/\s*$/,"");
                var _name = tmp.split(" ");                 
		draw_object(O_GUI,SELBOX,"vlan_id","onChange=chg_vid(this.form)",_name,_name,nv_vlan_id);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,25,25,25",__T(lan.statictb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(lan.vlandesc)+","+__T(share.ipaddr)+","+__T(share.macaddr)+"","add,edit,del","","","","2,0,0,0");
		</script>
		</TR>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
