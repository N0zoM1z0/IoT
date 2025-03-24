<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var block_arr = new Array();
block_arr[0]= new Array("URL Address","yahoo");
block_arr[1]= new Array("Keyword","Games");
CHK_VALUE_AUTO=0;
var pc_arr = new Array();
var idx_web=0;
var idx_pc=0;
var web_stflg="initweb";
var pc_stflg="initpc";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="filter.asp";
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx = "<% nvram_gozila_get("selidx"); %>"; 
var pc_name = new Array(__T(share.macaddr),__T(share.ipaddr),__T(share.iprange));
var pc_val = new Array("3","4","5");
var web_name = new Array(__T(lan.domainname),__T(share.keyword));
var web_val = new Array("1","2");
var all_name = new Array(__T(lan.domainname),__T(share.keyword),__T(share.macaddr),__T(share.ipaddr),__T(share.iprange),__T(share.ipaddr),__T(share.iprange));
var sch_name = new Array(<% get_schedule_list("data"); %>);
var pc_td_id = new Array("pctdtype","pctdval");
var web_td_id = new Array("webtdtype","webtdval");
var iap_list = new Array();
var web_list = new Array();
var iap_list_val = new Array();
var web_list_val = new Array();
var addr_list = new Array();
var web_disflg=0;
<% get_iap_list("all"); %>
function to_back(F)
{
	parent.document.getElementById("newpage").value = "filter.asp";
	uiDoCancel(F,"back");
}

function m_schedule()
{
	get_position("schedule_manage.asp");
	/*	
	var F = document.frmfilter;
	F.backname.value = "filter.asp";
	F.submit_button.value = "schedule_manage";
	F.change_action.value = "gozila_cgi";
	F.submit(); */
}

function refresh_page()
{
	alert_result(0);
	var F = document.frmfilter;
	F.submit_button.value = "filter_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function fill_nv_value(type,index)
{
	if ( type == "PC" ) 
	{
		iap_list_val[index] = new Array();
		iap_list_val[index][0] = all_name[parseInt(addr_list[index][0],10)-1];
		if ( parseInt(addr_list[index][0],10) == 5 || parseInt(addr_list[index][0],10) == 7) 
	                iap_list_val[index][1] = addr_list[index][1]+"~"+addr_list[index][2];
                else{
                        if ( parseInt(addr_list[index][0],10) == 3 ) 
                         	iap_list_val[index][1] = mac12to17(addr_list[index][1],0);
                        else
                                iap_list_val[index][1] = addr_list[index][1];
		}
	}else{ //WEB
		web_list_val[index] = new Array();
	        web_list_val[index][0] = all_name[parseInt(web_list[index][0],10)-1];
	        web_list_val[index][1] = web_list[index][1];
	}
	
}

function init(){
	var F = document.frmfilter;
	var index="";
	var sel=0;
	var data="", tmp=""; 
	if ( stflg == "edit" ) 	
	{
		if (iap_list[selidx][0]=="1")
			F.st.checked = true;
		F.pname.value = cy_speccode_decode(iap_list[selidx][3]);
		F.acc_rest[iap_list[selidx][1]].selected = true;
		for(var j=0; j<sch_name.length; j++)
		{
			if ( sch_name[j] == iap_list[selidx][2] ) 
			{
				F.sel_sch.selectedIndex = j;
				break;
			}
		}
		var sel = parseInt(selidx,10)+1;
		if ( sel < 10 ) index="0"+sel;
		else index=sel;
		for(var i=0; i<web_list.length; i++)
		{ 
			fill_nv_value("WEB",i)
			var def = new Array();
			def[0] = new Array("tdwebchk"+i,"<input type=checkbox id=webchk_"+i+" onclick=web_chk_click('"+i+"')>",3);
			def[1] = new Array(web_td_id[0]+i,web_list_val[i][0],3);
			def[2] = new Array(web_td_id[1]+i,web_list_val[i][1],0);
			def[3] = new Array("","&nbsp;");
			add_row(i,def,"webchk_","initweb",2);
			idx_web++;	
		}
		for(var i=0; i<addr_list.length; i++)
		{
			fill_nv_value("PC",i)
			var def = new Array();
			def[0] = new Array("tdpcchk"+i,"<input type=checkbox id=pcchk_"+i+" onclick=pc_chk_click('"+i+"')>",3);
			def[1] = new Array(pc_td_id[0]+i,iap_list_val[i][0],3);		
			def[2] = new Array(pc_td_id[1]+i,iap_list_val[i][1],0);
			def[3] = new Array("","&nbsp;");
			add_row(i,def,"pcchk_","initpc",2);
			idx_pc++;	
		}
	}	
	sel_action(F);
	default_nv = get_data(F);
}

function sel_pctype(index,F)
{
	var obj="";
	var maxlen="";
	if ( eval("F.pc_seltype"+index).value == "3" || eval("F.pc_seltype"+index).value == "4" ) 
	{
		if ( eval("F.pc_seltype"+index).value == "3" ) maxlen = "17";
		else maxlen = "39";
		obj = draw_td(O_VAR,ICONLINE,"pcval_img"+index,"<input size=51 maxlength="+maxlen+" id=pc_val"+index+" onBlur='' onMouseMove=showHint('pcval_img"+index+"','pcval_div"+index+"',event) onMouseOut=hideHint('pcval_div"+index+"')>","pcval_div"+index);

	}else if ( eval("F.pc_seltype"+index).value == "5" ) //IP Range
	{
		obj = draw_td(O_VAR,ICONLINE,"pcval_img"+index,"<input size=51 maxlength=39 id=pc_val"+index+" onBlur='' onMouseMove=showHint('pcval_img"+index+"','pcval_div"+index+"',event) onMouseOut=hideHint('pcval_div"+index+"')> ~ <input size=51 maxlength=39 id=pc_val1"+index+" onBlur='' onMouseMove=showHint('pcval_img"+index+"','pcval_div"+index+"',event) onMouseOut=hideHint('pcval_div"+index+"')>","pcval_div"+index);
	}
	document.getElementById("pctdval"+index).innerHTML = obj;
}

function get_pc_type(index)
{
	var seltype = "";
	if ( document.getElementById("pc_seltype"+index) ){
		seltype = document.getElementById("pc_seltype"+index).value;
	}else{
		var tmp = document.getElementById(pc_td_id[0]+index).innerHTML;
                if ( tmp == pc_name[0] ) seltype = "3";
                else if ( tmp == pc_name[1] ) seltype = "4";
                else if ( tmp == pc_name[2] ) seltype = "5";
	}
	return seltype;
}

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

function chk_lansubnet(index)
{
	var passflg = 1;
	for(var k=0; k<lan_arr.length; k++)
	{
		if ( valid_subnet(document.getElementById("pc_val"+index).value,
		     lan_arr[k].netmask,lan_arr[k].ipaddr))
		{
			if ( !valid_subnet(document.getElementById("pc_val1"+index).value, 	
					   lan_arr[k].netmask, 
					   document.getElementById("pc_val"+index).value))
			{
				create_tbmsg(index,__T(msg.subnet5));
				passflg=0;
				break;
			}
		}
		var IPS = document.getElementById("pc_val"+index).value.split(".");
		var IPE = document.getElementById("pc_val1"+index).value.split(".");
		var IPM = lan_arr[k].netmask.split(".");
		var IP_CLASS=3;
		for(var j=0; j<4; j++)
		{	
			if ( (IPS[j] & IPM[j]) == 0 && (IPS[j] != IPE[j]) )
			{
				IP_CLASS=j;
				break;
			}
		}
	
		if ( IPS[IP_CLASS] > IPE[IP_CLASS] )
		{
			create_tbmsg(index,__T(msg.ipchk));
	       	        passflg = 0 ;
			break;
		}
	}
	return passflg;
}

function get_pc_val(index)
{
	var seltype = get_pc_type(index);
	var tmp="";
	if ( document.getElementById("pc_seltype"+index) ){
		if ( seltype == "3" ) 
			tmp =mac12to17(document.getElementById("pc_val"+index).value).toUpperCase();
		else
			tmp = parseIP(document.getElementById("pc_val"+index).value).toUpperCase();
		if ( seltype == "5" ) 
			tmp += "~"+parseIP(document.getElementById("pc_val1"+index).value);
	}
	else{
		tmp = parseIP(document.getElementById(pc_td_id[1]+index).innerHTML).toUpperCase();
	}
	return tmp;
}

function get_pc_iptype(index)
{
	var F = document.frmfilter;
	var tmptype="",tmptype2="";
	var seltype = parseInt(get_pc_type(index),10);
	var errmsg="",errflg=0;
	if ( document.getElementById("pc_seltype"+index) ){
		if ( seltype == 3 ){
			errmsg = valid_macs_all(document.getElementById("pc_val"+index).value);
			if ( errmsg != "" ) 
			{
				table_msg("pcval_img"+index,"pc_val"+index,"pcval_div"+index,"pc_"+index,errmsg);
				return "err";
			} 
			return "mac";
		}
		if ( F.st.checked == true ) 
		{
			if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
				errmsg = valid_ipmode_check(F,"pc_val"+index,LANSUBNET_OK,"IPv6");
			else
				errmsg = valid_ipmode_check(F,"pc_val"+index,LANSUBNET_OK);
		}
		if ( !errmsg ){ 
			if ( test_ipv6(document.getElementById("pc_val"+index).value) ) tmptype = "ipv6";
			else if ( check_ipv4(document.getElementById("pc_val"+index).value,VALID_IP_RULE1) == PASS  ) tmptype = "ipv4";
		}else{
			create_tbmsg(index,errmsg);
			return "err";
		}
		if ( seltype > 4 ) 
		{
			errmsg = "";
			if ( F.st.checked == true ) 
			{
				if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
					errmsg = valid_ipmode_check(F,"pc_val1"+index,LANSUBNET_OK,"IPv6");
				else
					errmsg = valid_ipmode_check(F,"pc_val1"+index,LANSUBNET_OK);
			}
			if ( !errmsg ) 
			{
				if ( test_ipv6(document.getElementById("pc_val1"+index).value) ) tmptype2 = "ipv6";
				else if ( check_ipv4(document.getElementById("pc_val1"+index).value,VALID_IP_RULE1) == PASS ) tmptype2 = "ipv4";
			}else{
				create_tbmsg(index,errmsg);
				errflg=1;
				return "err";
			}
			if ( tmptype2 == "" ) 
			{
				create_tbmsg(index,__T(msg.ivalidipformat));
				errflg=1;
			}
			if ( tmptype != tmptype2 ) 
			{
				create_tbmsg(index,__T(msg.ivalidipformat));
				errflg=1;
			}
			if ( tmptype == "ipv4" ) 
			{
				if ( !chk_lansubnet(index) ) errflg=1;
				/*
				var s = document.getElementById("pc_val"+index).value.split(".");
				var e = document.getElementById("pc_val1"+index).value.split(".");
				if ( parseInt(s[3],10) > parseInt(e[3],10) )
				{
					create_tbmsg(index,__T(msg.ipchk));
					errflg=1;
				}*/
			}
		}
	}else{
		if ( seltype == 3 ){
			return "mac";
		}
		if ( seltype == "5" ) 
		{
			var tmp = document.getElementById(pc_td_id[1]+index).innerHTML.split("~");
			var tmpip = tmp[0];
		}
		else
			var tmpip = document.getElementById(pc_td_id[1]+index).innerHTML;
		if ( test_ipv6(tmpip)) tmptype = "ipv6";
		else if ( check_ipv4(tmpip,VALID_IP_RULE1) == PASS) tmptype = "ipv4";
	}
	if ( errflg == 1 ) return "err";
	return tmptype;
}


function create_tbmsg(i,msg)
{
	var seltype = parseInt(get_pc_type(i),10);
	if ( document.getElementById("pc_seltype"+i) != null )
	{
		table_msg("pcval_img"+i,"pc_val"+i,"pcval_div"+i,"pc_"+i,msg);
		if ( seltype > 4 ) 
			table_msg("pcval_img"+i,"pc_val1"+i,"pcval_div"+i,"pc_"+i,msg);
	}
	
}

var kiptype="";
function chk_pc_before_data(index)
{
	//3:MAC, 4:IP, 5:IP Ragne
	var errflg=0;
	var seltype_a="",seltype_b="";
	var val_a="",val_b="";
	var iptype_a="",iptype_b="";
	if ( index < 0 ) return true;
	if ( document.getElementById("pc_seltype"+index) ){
		clear_table_msg("tmsgpc","pcval_img"+index,"pc_val"+index,"pc_"+index);
		if (  document.getElementById("pc_val"+index).value == "" ) 
		{
			table_msg("pcval_img"+index,"pc_val"+index,"pcval_div"+index,"pc_"+index,__T(msg.notblank));
			errflg = 1 ; 
		}
	
		if ( document.getElementById("pc_seltype"+index).value == "5" ) 
		{
			clear_table_msg("tmsgpc","pcval_img"+index,"pc_val1"+index,"pc_"+index);
			if (  document.getElementById("pc_val1"+index) == "" ){ 
		                table_msg("pcval_img"+index,"pc_val1"+index,"pcval_div"+index,"pc_"+index,__T(msg.notblank));
		        	errflg = 1 ; 
                        }
		}	
	}
	if ( errflg == 1 ) return false;
	seltype_b = get_pc_type(index);
	val_b = get_pc_val(index);
	iptype_b = get_pc_iptype(index);
	//alert(seltype_b+","+val_b+","+iptype_b);
	for(var i=0; i<idx_pc; i++)
	{
		if ( i==index ) continue;
		if ( document.getElementById("pc_seltype"+i) != null )
			clear_table_msg("tmsgpc","pcval_img"+i,"pc_val"+i,"pc_"+i);
		seltype_a = get_pc_type(i);
		val_a = get_pc_val(i);
		iptype_a = get_pc_iptype(i);
		//alert("iptype_b="+iptype_b+";iptype_a="+iptype_a);
		if ( iptype_a != "err" && iptype_b != "err" && ( seltype_a == seltype_b ) && ( val_a == val_b ) ) 
		{
                	    if ( seltype_a == "3" ){ 
				create_tbmsg(i,__T(msg.macexist));
				create_tbmsg(index,__T(msg.macexist));
			    }else{  
				create_tbmsg(i,__T(msg.ipexist));
				create_tbmsg(index,__T(msg.ipexist));
			    }
			    errflg=1;
		}
		if ( iptype_b != "mac" || iptype_a != "mac" ) 
		{
			if ( iptype_a == "" || iptype_b == "" || 
			     ( iptype_b != "mac" && iptype_a != "mac" && 
                               iptype_a !="err" && iptype_b != "err" && (iptype_a != iptype_b)))
			{
				if ( iptype_b != "mac") 
					create_tbmsg(index,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
				if ( iptype_a != "mac" ) 
					create_tbmsg(i,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
				errflg = 1;
			}
		}
	}
	if ( iptype_a =="err" || iptype_b =="err" || errflg == 1 ) return false; 
	if ( idx_pc == 1 ){
		if ( iptype_b != "ipv4" && iptype_b != "ipv6" &&
		     iptype_b != "mac" && iptype_a != "mac" ) 
		{
			create_tbmsg(index,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
			create_tbmsg(i,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
			errflg = 1;
			return false;
		}
	} 
	return true;
}

function to_edit()//pc_edit
{
	var args = new Array;
        args[0] = arguments[0];
	if (typeof args[0] == "undefined" ) pc_stflg = "editpc";
	var td_id = new Array("pctdchk","pctdtype","pctdval");
	document.getElementById("tmsgpc").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgpc").style.display="";
	choose_disable(document.getElementById("a2"));
	choose_disable(document.getElementById("a4"));
	for(var i=0; i<idx_pc; i++)
	{
		if( document.getElementById("pcchk_"+i).checked == true && document.getElementById("pc_seltype"+i) == null )
		{
			var data = new Array();
			//data[0]="<input type=checkbox id=tdpcchk_"+i+" onclick=pc_chk_click('"+i+"')>";
			for(var j=0; j<pc_name.length; j++)
			{
				if ( document.getElementById(pc_td_id[0]+i).innerHTML == pc_name[j] ) 
				{
					data[0]=draw_object(O_VAR,SELBOX,"pc_seltype"+i,"id=pc_seltype"+i+" onChange=sel_pctype("+i+",this.form)", pc_name,pc_val,pc_val[j]);		
					break;
				}
			}
			var val = document.getElementById(pc_td_id[1]+i).innerHTML;
			if ( document.getElementById(pc_td_id[0]+i).innerHTML == __T(share.iprange) )
			{
				tmpval = val.split("~");
				data[1]=draw_td(O_VAR,ICONLINE,"pcval_img"+i,"<input size=51 maxlength=39 id=pc_val"+i+" onBlur=chk_pc_before_data('"+i+"') onMouseMove=showHint('pcval_img"+i+"','pcval_div"+i+"',event) onMouseOut=hideHint('pcval_div"+i+"') value="+tmpval[0]+"> ~ <input size=51 maxlength=39 id=pc_val1"+i+" onBlur='' onMouseMove=showHint('pcval_img"+i+"','pcval_div"+i+"',event) onMouseOut=hideHint('pcval_div"+i+"') value="+tmpval[1]+">","pcval_div"+i);
			}else{
				data[1]=draw_td(O_VAR,ICONLINE,"pcval_img"+i,"<input size=51 maxlength=39 id=pc_val"+i+" onBlur=chk_pc_before_data('"+i+"') onMouseMove=showHint('pcval_img"+i+"','pcval_div"+i+"',event) onMouseOut=hideHint('pcval_div"+i+"') value="+val+">","pcval_div"+i);
			}
	        	edit_row(pc_td_id,data,i);
			/*
			for(var j=0; j<td_id.length; j++)
			{
				if ( typeof data[j] == 'undefined') continue;
				document.getElementById(td_id[j]+i).innerHTML = "";
				document.getElementById(td_id[j]+i).innerHTML = data[j];
			}*/
			
		}
			
	}
} 

function to_add() //pc_add
{
	//check_ip_data(F);
	if ( idx_pc >= PC_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,PC_ENTRY,__T(filter.pcspolicy)),"");
                return false;
        }
	pc_stflg="addpc";
	if ( !chk_pc_before_data(idx_pc-1) ) return;	
	var tmp = new Array();
	tmp[0]=new Array("tdpcchk"+idx_pc,"<input type=checkbox id=pcchk_"+idx_pc+" onclick=pc_chk_click('"+idx_pc+"') disabled>",3);
	tmp[1]=new Array(pc_td_id[0]+idx_pc,draw_object(O_VAR,SELBOX,"pc_seltype"+idx_pc,"id=pc_seltype"+idx_pc+" onChange=sel_pctype("+idx_pc+",this.form)",pc_name,pc_val),3);
	tmp[2]=new Array(pc_td_id[1]+idx_pc,draw_td(O_VAR,ICONLINE,"pcval_img"+idx_pc,"<input size=51 maxlength=39 id=pc_val"+idx_pc+" onBlur=chk_pc_before_data('"+idx_pc+"') onMouseMove=showHint('pcval_img"+idx_pc+"','pcval_div"+idx_pc+"',event) onMouseOut=hideHint('pcval_div"+idx_pc+"')>","pcval_div"+idx_pc),1);
	tmp[3]=new Array("","&nbsp;");
	add_row(idx_pc,tmp,"pcchk_","addpc",2);
	idx_pc++;
}

function chk_web_before_data(index){
	//1:URL, 2:Keyword
	var errflg = "";
	if ( document.getElementById("web_seltype"+index) == null ) return true; 
	var type= document.getElementById("web_seltype"+index).value;
	var obj = document.getElementById("web_val"+index);
	clear_table_msg("tmsgweb","webval_img"+index,"web_val"+index,"web_"+index);
	if ( obj.value == "" ) 
	{
		table_msg("webval_img"+index,"web_val"+index,"webval_div"+index,"web_"+index,__T(msg.notblank));
		errflg = 1 ; 
	}else{
		if ( type == "1" ) 
		{
			if ( !check_domain(obj.value) ) 
			{
				table_msg("webval_img"+index,"web_val"+index,"webval_div"+index,"web_"+index,__T(msg.validname));
		                errflg = 1 ;
				return false;
			}
			
		}
		/* 3/3 Fixed bug - CSCtn15514: The user is able to add ducplicate urls in internet access policy.
                   But need add a new message for it - msg.valueexist. Maybe need move to MR1 */
		var now_type="";
		var cmpdata = new Array();
	        for(var i=0; i<idx_web; i++)
	        {
               		if (document.getElementById("web_val"+i) == null ){
				if ( type=="1") now_type = __T(lan.domainname);
				else now_type = __T(share.keyword);
                       		if ( now_type == document.getElementById(web_td_id[0]+i).innerHTML )
				{
					//alert(document.getElementById(web_td_id[2]+i).innerHTML);
                        		cmpdata[i] = document.getElementById(web_td_id[1]+i).innerHTML;	
				}
			}else{
				if ( type == document.getElementById("web_seltype"+i).value ) 
				{
				//	alert(document.getElementById("web_val"+i).value);
        		                cmpdata[i] = document.getElementById("web_val"+i).value;
				}
	        	}
		}
	        for(var j=0; j<cmpdata.length; j++)
		{
				clear_table_msg("tmsgweb","webval_img"+index,"web_val"+index,"web_"+index);
	                	if ( document.getElementById("web_val"+j) )
        	                	document.getElementById("web_val"+j).style.display="";
	                	if ( j == index || cmpdata[j] == "undefined" ) continue;
		                if ( cmpdata[index] == cmpdata[j] )
        		        {
                		        table_msg("webval_img"+index,"web_val"+index,"webval_div"+index,"web_"+index,__T(msg.valueexist));
	                	        return false;
		                }
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function web_chk_click(index)
{
	if ( web_disflg == 1 ) return;
	var count=0;
	to_check("webchk_",document.getElementById("webchk_"+index).checked,index,idx_web,web_stflg,web_td_id,web_list_val[index]);
	for(var i=0; i<idx_web; i++){
		if ( document.getElementById("webchk_"+i).checked == true ) count++; 
	}
	if ( count > 0 ) 
	{
		choose_disable(document.getElementById("t5"));
		choose_enable(document.getElementById("t6"));
		choose_enable(document.getElementById("t7"));
	}else{
		choose_enable(document.getElementById("t5"));
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("t7"));
	}
}

function pc_all_chk(F)
{
	var count=0;
	for(var i=0; i<idx_pc; i++)
	{
		if ( F.pc_chkall.checked == true ) 
		{
			document.getElementById("pcchk_"+i).checked = true;
			count++;
		}
		else
			document.getElementById("pcchk_"+i).checked = false;
		to_check("pcchk_",document.getElementById("pcchk_"+i).checked,i,idx_pc,pc_stflg,pc_td_id,iap_list_val[i]);
	}
	if ( count > 0 ){
                choose_disable(document.getElementById("a2"));
                choose_enable(document.getElementById("a4"));
                choose_enable(document.getElementById("a3"));
        }else{
                choose_enable(document.getElementById("a2"));
                choose_disable(document.getElementById("a3"));
                choose_disable(document.getElementById("a4"));
        }
}

function web_all_chk(F)
{
	if ( web_disflg == 1 ) return;
	var count=0;
        for(var i=0; i<idx_web; i++)
        {
                if ( F.web_chkall.checked == true )
		{
                        document.getElementById("webchk_"+i).checked = true;
			count++;
		}
                else
                        document.getElementById("webchk_"+i).checked = false;
                to_check("webchk_",document.getElementById("webchk_"+i).checked,i,idx_pc,web_stflg,web_td_id,web_list_val[i]);
        }
	if ( count > 0 ){
                choose_disable(document.getElementById("t5"));
                choose_enable(document.getElementById("t6"));
                choose_enable(document.getElementById("t7"));
        }else{
                choose_enable(document.getElementById("t5"));
                choose_disable(document.getElementById("t6"));
                choose_disable(document.getElementById("t7"));
        }
}

function pc_chk_click(index)
{
	var count=0;
	to_check("pcchk_",document.getElementById("pcchk_"+index).checked,index,idx_pc,pc_stflg,pc_td_id,iap_list_val[index]);
	for(var i=0; i<idx_pc; i++){
                if ( document.getElementById("pcchk_"+i).checked == true ) count++;
        }
	if ( count > 0 ){
		choose_disable(document.getElementById("a2"));
		choose_enable(document.getElementById("a4"));
		choose_enable(document.getElementById("a3"));
	}else{
		choose_enable(document.getElementById("a2"));
		choose_disable(document.getElementById("a4"));
		choose_disable(document.getElementById("a3"));
	}
}

function to_edit_web(F){
	web_stflg = "editweb";
	document.getElementById("tmsgweb").innerHTML = __T(msg.tablemsg); 
        document.getElementById("tmsgweb").style.display="";
        choose_disable(document.getElementById("t5"));
        choose_disable(document.getElementById("t6"));
	for(var i=0; i<idx_web; i++){
		if( document.getElementById("webchk_"+i).checked == true && document.getElementById("web_seltype"+i) == null )
		{
			var data = new Array();
			//data[0]="<input type=checkbox id=webchk_"+i+" onclick=web_chk_click('"+i+"')>";
			for(var j=0; j<web_name.length; j++)
			{
				if ( document.getElementById(web_td_id[0]+i).innerHTML == web_name[j] ) 
				{
					data[0]=draw_object(O_VAR,SELBOX,"web_seltype"+i,"id=web_seltype"+i,web_name,web_val,web_val[j]);
					break;
				}
			}
			data[1]=draw_td(O_VAR,ICONLINE,"webval_img"+i,"<input size=20 maxlength=64 id=web_val"+i+" onBlur=chk_web_before_data('webval_div"+i+"') onMouseMove=showHint('webval_img"+i+"','webval_div"+i+"',event) onMouseOut=hideHint('webval_div"+i+"') value="+cy_speccode_encode(document.getElementById(web_td_id[1]+i).innerHTML)+">","webval_div"+i);
	        	edit_row(web_td_id,data,i);
			/*
			for(var j=0; j<web_td_id.length; j++)
        	        {
	        	        if ( typeof data[j] == 'undefined') continue;
                        	document.getElementById(web_td_id[j]+i).innerHTML = "";
	                        document.getElementById(web_td_id[j]+i).innerHTML = data[j];
        	        }*/
		}
	}
}

function to_add_web(F)
{
	if ( web_disflg == 1 ) return;
	web_stflg = "addweb";
	if ( idx_web >= WEB_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,WEB_ENTRY,__T(filter.websiteblock)),"");
                return false;
        }
	if ( !chk_web_before_data(idx_web-1)) return;
	var tmp = new Array();
	tmp[0]=new Array("tdwebchk"+idx_web,"<input type=checkbox id=webchk_"+idx_web+" onclick=web_chk_click('"+idx_web+"') disabled>",3);
        tmp[1]=new Array(web_td_id[0]+idx_web,draw_object(O_VAR,SELBOX,"web_seltype"+idx_web,"id=web_seltype"+idx_web,web_name,web_val),3);
        tmp[2]=new Array(web_td_id[1]+idx_web,draw_td(O_VAR,ICONLINE,"webval_img"+idx_web,"<input size=20 maxlength=64 id=web_val"+idx_web+" onBlur=chk_web_before_data('webval_div"+i+"') onMouseMove=showHint('webval_img"+idx_web+"','webval_div"+idx_web+"',event) onMouseOut=hideHint('webval_div"+idx_web+"')>","webval_div"+idx_web),1);
	tmp[3]=new Array("","&nbsp;");
        add_row(idx_web,tmp,"webchk_","addweb",2);
        idx_web++;
}

function chkname(F)
{
	clear_msg("pname","msg_pname");
        var returnmsg = valid_meaning_id_name(ID_NAME,F.pname.value,ZERO_NO,"pname");
        if ( returnmsg != "" )   
        {
                my_alert(O_VAR,"pname",returnmsg,"0","msg_pname");
		return false;
        }
	return true;
}


function valid_value(F)
{
	var errflg = 0 ;
	if ( !chkname(F) ) errflg = 1;
	clear_msg("sel_sch","msg_sch");
        if ( F.acc_rest.selectedIndex == 2 || F.acc_rest.selectedIndex == 3 )
	{
		if ( F.sel_sch.value == "" ) 
		{
			my_alert(O_VAR,"sel_sch",__T(msg.notblank),"0","msg_sch");
			errflg = 1;	
		}	
	}
	if ( errflg == 1 ) return false;
	return true;
}

function get_web_data(F)
{
	var tmp = "";
	var count=0;
	F.fw_iap_web.value = "";
	for(var i=0; i<idx_web; i++)
	{
		if ( web_stflg == "delweb" ) 
		{
			if ( document.getElementById("tr_tableweb_"+i).className == "TABLECONTENT_DEL")
			{
				continue;
			}
		}
		if ( !chk_web_before_data(i)) return false;
		count++;
		tmp = "";
		if ( document.getElementById("web_seltype"+i) == null ) 
		{
			for(var j=0; j<all_name.length; j++)
			{
				if ( document.getElementById(web_td_id[0]+i).innerHTML == all_name[j] )
				{
					tmp+=(j+1)+",";
					tmp+=document.getElementById(web_td_id[1]+i).innerHTML.length+",";
					tmp+=document.getElementById(web_td_id[1]+i).innerHTML+",4,NONE";
					break;
				}
			}
		}else{
			tmp+=document.getElementById("web_seltype"+i).value+","
			tmp+=document.getElementById("web_val"+i).value.length+",";
			tmp+=document.getElementById("web_val"+i).value+",4,NONE";
		}
		F.fw_iap_web.value += tmp;
		if ( i != idx_web ) F.fw_iap_web.value += ";";
	}
	if ( count == 0 ) F.fw_iap_web.value = "";
	else 
		F.fw_iap_web.value = count+","+F.fw_iap_web.value;
	return true;
	
}

function to_del_web(){
        web_stflg = "delweb";
        // table message
        document.getElementById("tmsgweb").innerHTML = __T(msg.tablemsg);
        document.getElementById("tmsgweb").style.display="";
        // disabled the add and edit button
        choose_disable(document.getElementById("t5"));
        for(var i=0; i<idx_web; i++)
        {
                if ( document.getElementById("webchk_"+i).checked == true )
                        document.getElementById("tr_tableweb_"+i).className= "TABLECONTENT_DEL";
        }
}


function to_del(){
	pc_stflg = "delpc";
	// table message
	document.getElementById("tmsgpc").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgpc").style.display="";
	for(var i=0; i<idx_pc; i++)
	{
		if ( document.getElementById("pcchk_"+i).checked == true ) 
			document.getElementById("tr_tablepc_"+i).className= "TABLECONTENT_DEL";
	}
	// disabled the add and edit button
	//alert(document.getElementById("a3").className);
	choose_disable(document.getElementById("a2"));
	choose_disable(document.getElementById("a3"));
}

function get_pc_data(F)
{
	var tmp = "";
	var count=0;
	F.fw_iap_addr.value = "";
	for(var i=0; i<idx_pc; i++)
	{
		if ( pc_stflg == "delpc" ) 
		{
			if ( document.getElementById("tr_tablepc_"+i).className == "TABLECONTENT_DEL")
				continue;
		}
		if ( !chk_pc_before_data(i)) return false;
		count++;
		tmp = "";
		if ( document.getElementById("pc_seltype"+i) == null )
		{
			for(var j=0; j<all_name.length; j++)
			{
				if ( document.getElementById(pc_td_id[0]+i).innerHTML == all_name[j] ) 
				{
					tmp+=(j+1)+",";
					if ( j == 4 )
					{
						var range = document.getElementById(pc_td_id[1]+i).innerHTML.split("~");
						tmp+=range[0].length+","+range[0]+",";
						tmp+=range[1].length+","+range[1];
					}else{
						tmp+=document.getElementById(pc_td_id[1]+i).innerHTML.length+",";
						tmp+=document.getElementById(pc_td_id[1]+i).innerHTML+",4,NONE";
					}
					break;
				}
			}
		}else{
			tmp+=document.getElementById("pc_seltype"+i).value+","
			if ( document.getElementById("pc_seltype"+i).value == "5" ) 
			{
				tmp+=document.getElementById("pc_val"+i).value.length+",";
				tmp+=document.getElementById("pc_val"+i).value+",";
				tmp+=document.getElementById("pc_val1"+i).value.length+",";
				tmp+=document.getElementById("pc_val1"+i).value;
			}
			else
			{
				if ( document.getElementById("pc_seltype"+i).value == "3" )
				{
					var newmac = mac12to17(document.getElementById("pc_val"+i).value);
					tmp+=newmac.length+",";
					tmp+=newmac+",4,NONE";
				}else{ 
					tmp+=parseIP(document.getElementById("pc_val"+i).value).length+",";
					tmp+=parseIP(document.getElementById("pc_val"+i).value)+",4,NONE";
				}
			}
		}
		F.fw_iap_addr.value += tmp;
		if ( i != idx_pc ) F.fw_iap_addr.value += ";";
	}
	if ( count == 0 ) F.fw_iap_addr.value = "";
	else
	   F.fw_iap_addr.value = count+","+F.fw_iap_addr.value;
	if ( F.fw_iap_addr.value == "" ) 
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(msg.setaweborpc),"");
		return false;
	}
	return true;
}

function get_data(F)
{
	var data = keep_val(F,"")+",";
	data += F.fw_iap_web.value+",";
	data += F.fw_iap_addr.value+",";
	return data;
}

function check_ip_data(F)
{
	if ( F.st.checked == true ) 
	{
		for(var i=0; i<idx_pc; i++)
			document.getElementById("pcchk_"+i).checked = true;
		if ( pc_stflg != "delpc" ) to_edit("chk");
	}
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


function uiDoSave(F){
	var SKU="<% nvram_get("sysinfo_pid"); %>";
	check_ip_data(F);
	if ( !valid_value(F) || !get_web_data(F) || !get_pc_data(F) ) return false;
	if ( idx_pc == 0 ) 
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(msg.setaweborpc),"");
		choose_enable(document.getElementById("a2"));
		return false;
	}
	if ( "<% nvram_get("wf_enable"); %>" != "disable" && 
             (SKU == "RV130-WB-K9-NA" || SKU == "RV130-WB-K9-G5" || SKU == "RV130W-WB-A-K9-NA" || SKU == "RV130W-WB-E-K9-G5") ) 
		my_alert(O_GUI,INFO,__T(share.info),__T(filter.disiapmsg),"");
	F.submit_button.value = "filter";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function sel_action(F)
{
	var web_name = "";
	web_disflg=0;
        if ( F.acc_rest.selectedIndex <= 1 )
                choose_disable(F.sel_sch);
        else
		choose_enable(F.sel_sch);
	
	return;
	if ( F.acc_rest[F.acc_rest.selectedIndex].value == 0 || 
	     F.acc_rest[F.acc_rest.selectedIndex].value == 2 )
	{
		web_disflg=1;
		choose_disable(document.getElementById("t5"));
		choose_disable(document.getElementById("web_chkall"));
		if ( typeof web_list[selidx] != "undefined" ) 
		{
			for(var i=0; i<web_list[selidx].length; i++)
			{
				web_name="webchk_"+i;
				choose_disable(document.getElementById(web_name));
			}
		}
	}
	else
	{
		choose_enable(document.getElementById("t5"));
		choose_enable(document.getElementById("web_chkall"));
		if ( typeof web_list[selidx] != "undefined" ) 
		{
			for(var i=0; i<web_list[selidx].length; i++)
			{
				web_name="webchk_"+i;
				choose_enable(document.getElementById(web_name));
			}
		}
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmfilter method=<% get_http_method(); %> action=apply.cgi onKeyDown="if (event.keyCode==13){return false}">
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=backname>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<input type=hidden name=fw_iap value=1>
<input type=hidden name=fw_iap_web>
<input type=hidden name=fw_iap_addr>
<input type=hidden name=wait_time value=5>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.add_edit_IAP),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(share.sts));</script>
		<input type=checkbox name=st id=st> <script>Capture(share.enable);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.enterpolicyname));</script>
		<input size=20 maxlength=32 name=pname id=pname onblur=chkname(this.form)>
		<span id=msg_pname></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.action));</script>
                <script>
		var action_name= new Array(__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
		var action_val = new Array("0","1","2","3");
		draw_object(O_GUI,SELBOX,"acc_rest","onChange=sel_action(this.form)",action_name,action_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>Capture(filter.msg);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.schedule));</script>
                <script>
		var show_name = new Array();
		for(var i=0; i<sch_name.length; i++)
		{
			if ( sch_name[i] == "NONE" ) show_name = __T(share.none);
			else show_name[i] = sch_name[i];
		}
		draw_object(O_GUI,SELBOX,"sel_sch","id=sel_sch",show_name,sch_name);
                document.write("&nbsp;");
                draw_object(O_GUI,BT,__T(filter.confsch),"a1","BT_L","m_schedule()");
                </script>
		<SPAN id=msg_sch></SPAN>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>	
		<script>		
		var bt_list = new Array();
		bt_list[0] = new Array("BT","a2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","a3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","a4",__T(share.del),"to_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,70",__T(filter.applyaccesstb),"<input type=checkbox name=pc_chkall id=pc_chkall onclick=pc_all_chk(this.form)>,"+__T(share.stype)+","+__T(share.svalue),"",bt_list,"","pc","2,2,0");
		choose_disable(document.getElementById("a3"));
		choose_disable(document.getElementById("a4"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>	
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t5",__T(share.addrow),"to_add_web(this.form)");
		bt_list[1] = new Array("BT","t7",__T(share.edit),"to_edit_web(this.form)");
		bt_list[2] = new Array("BT","t6",__T(share.del),"to_del_web(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,70",__T(filter.websitedomainnamekey),"<input type=checkbox name=web_chkall id=web_chkall onclick=web_all_chk(this.form)>,"+__T(share.stype)+","+__T(share.svalue),"",bt_list,"","web","2,2,0");
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("t7"));
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
