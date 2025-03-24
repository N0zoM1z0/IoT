<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>"; //1:IPv4 2:IPv6
var lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>"; //1:IPv4 2:IPv6 3:IPv4&IPv6
var datalist = new Array();
<% get_acl_list(); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var frmtitle="";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ip_based_acl.asp";
var tmpdata = new Array(<% get_service_list(); %>);
var service_list = new Array();
for(var i=0; i<tmpdata.length; i++)
{
	var tmp = tmpdata[i].split("[");
	service_list[i] = tmp[0];
}

var sch_name = new Array(<% get_schedule_list("data"); %>);
var direct_name= new Array(__T(filter.outbound_lan_wan),__T(filter.inbound_wan_lan),__T(filter.inbound_wan_dmz));
var direct_val = new Array("0","1","2");
var action_name= new Array(__T(filter.alwaysblock),__T(filter.alwaysallow),__T(filter.blockbysch),__T(filter.allowbysch));
var action_val = new Array("0","1","2","3");
var log_name = new Array(__T(mang.never),__T(filter.always));
var log_val = new Array("0","1");
var pri_name = new Array("1 ("+__T(filter.lowest)+")","2","3","4 ("+__T(filter.highest)+")");
var pri_val = new Array("1","2","3","4");

if ( stflg == "add" ) 
	frmtitle=__T(filter.addaccrules);	
else
	frmtitle=__T(filter.editaccrules);	

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

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ip_based_acl.asp";
	uiDoCancel(F,"back");
}

function refresh_page()
{
	alert_result(0);	
	var F = document.frmacl;
        F.submit_button.value = "ip_based_acl_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}


function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmacl;
	//choose_disable(F.dnat_ip);
	//choose_disable(F.dnat_port);
	if ( stflg == "edit" ) 
	{
		for(var i=0; i<direct_val.length; i++)
		{
			if ( direct_val[i] == datalist[selidx].conntype ) 
			{
				F.direct.selectedIndex = i ;
				break;
			}
		}
		sel_direct(F);
		for(var i=0; i<action_val.length; i++)
		{
			if (  F.acl_action[i].value == datalist[selidx].act ) 
			{
				F.acl_action.selectedIndex = i;
				break;
			}
		}	
		for(var i=0; i<sch_name.length; i++)
		{
			if ( sch_name[i] == datalist[selidx].sch_name ) 
			{
				F.sch.selectedIndex = i ;
				break;
			}
		}
		for(var i=0; i<service_list.length; i++)
		{
			if ( service_list[i] == datalist[selidx].service ) 
			{
				F.service.selectedIndex = i ; 
				break;
			}
		}
		if( datalist[selidx].stype == "2" ) 
			F.sip[0].selected = true;
		else if ( datalist[selidx].stype == "0" ) 
			F.sip[1].selected = true;
		else
			F.sip[2].selected = true;
		if( datalist[selidx].stype != "2" ) 
		{
			F.sip_start.value = datalist[selidx].s_src_ip;
			if ( datalist[selidx].stype == "1" ) F.sip_end.value = datalist[selidx].e_src_ip;
		}
		if( datalist[selidx].dtype == "2" )
                        F.dip[0].selected = true;
                else if ( datalist[selidx].dtype == "0" )
                        F.dip[1].selected = true;
                else
                        F.dip[2].selected = true;
                if( datalist[selidx].dtype != "2" && F.direct.selectedIndex != 2)
                {
                        F.dip_start.value = datalist[selidx].s_dst_ip;
                        if ( datalist[selidx].dtype == "1" ) F.dip_end.value = datalist[selidx].e_dst_ip;
                }
		for(var i=0; i<log_val.length; i++)
		{
			if ( log_val[i] == datalist[selidx].log )
			{
				F.log.selectedIndex = i;
				break;
			}
		}	
		if ( datalist[selidx].st == "1" ) F.state.checked = true;
		/*	
		for(var i=0; i<pri_val.length; i++)
		{
			if ( pri_val[i] == datalist[selidx].pri ) 
			{
				F.pri.selectedIndex = i ;
				break;
			}
		}	
		if ( datalist[selidx].dnat_port != "0" ) 
		{
			F.en_pf.checked = true;
			F.dnat_port.value = datalist[selidx].dnat_port;
			choose_enable(F.dnat_port);
		}
		if ( datalist[selidx].conntype == "1" ) 
		{
			choose_enable(F.dnat_ip);
			F.dnat_ip.value = datalist[selidx].dnat_ip;
		}*/
	}else
		sel_direct(F);
		
	sel_sip(F);
	sel_dip(F);
	sel_action(F);
	if ( F.direct.selectedIndex == 2 ) choose_disable(F.dip_start);
	default_nv = keep_val(F,"");
}

function m_schedule()
{
	get_position("schedule_manage.asp");
	/*
	var F = document.frmacl;
        F.submit_button.value = "schedule_manage";
        F.backname.value = "ip_based_acl.asp";
        F.change_action.value="gozila_cgi";
        F.submit();*/
}
function m_service()
{
	get_position("service_manage.asp");
	/*
	var F = document.frmacl;
        F.submit_button.value = "service_manage";
        F.backname.value = "ip_based_acl.asp";
        F.change_action.value="gozila_cgi";
        F.submit();*/
}

function sel_dip(F)
{
        clear_msg("dip_start","msg_dip_start");
        clear_msg("dip_end","msg_dip_end");
        if ( F.dip.selectedIndex == 0 )
        {
                choose_disable(F.dip_start);
                choose_disable(F.dip_end);
        }else if ( F.dip.selectedIndex == 1 )
        {
                choose_enable(F.dip_start);
                choose_disable(F.dip_end);
        }else{
                choose_enable(F.dip_start);
                choose_enable(F.dip_end);
        }
}

function sel_sip(F)
{
        clear_msg("sip_start","msg_sip_start");
        clear_msg("sip_end","msg_sip_end");
	if ( F.sip.selectedIndex == 0 ) 
	{
		choose_disable(F.sip_start);
		choose_disable(F.sip_end);
	}else if ( F.sip.selectedIndex == 1 ) 
	{
		choose_enable(F.sip_start);
		choose_disable(F.sip_end);
	}else{
		choose_enable(F.sip_start);
		choose_enable(F.sip_end);
	}
}

function sel_action(F)
{
	if ( F.acl_action[F.acl_action.selectedIndex].value==0 || F.acl_action[F.acl_action.selectedIndex].value==1 )
		choose_disable(F.sch);
	else
		choose_enable(F.sch);
	/*
	if ( F.direct.selectedIndex == 1 &&
	     ( F.acl_action[F.acl_action.selectedIndex].value==1 || 
	       F.acl_action[F.acl_action.selectedIndex].value==3 ) ) 
	{
		choose_enable(F.en_pf);
		choose_enable(F.dnat_ip);
		choose_enable(F.dnat_port);
	}else{
		choose_disable(F.en_pf);
		choose_disable(F.dnat_ip);
		choose_disable(F.dnat_port);
	}

	if ( F.direct.selectedIndex == 1 && wan_ip_mode == "2" )
	{
		choose_disable(F.en_pf);
		choose_disable(F.dnat_ip);
		choose_disable(F.dnat_port);
	}*/
}

var dmz_enable = "<% nvram_get("dmz_enable"); %>";
var dmz_ipaddr = "<% nvram_get("dmz_ipaddr"); %>";
var dmz_vid = "<% nvram_get("dmz_vid"); %>";
function sel_direct(F)
{
	clear_msg("direct","msg_direct");
	//for(var i=0; i<4; i++)	F.acl_action.remove(i);
	
	if ( F.direct.selectedIndex != 0 )
	{
		F.dip.selectedIndex=0;
                choose_disable(F.dip);
                choose_disable(F.dip_start);
                choose_disable(F.dip_end);
                //choose_disable(F.dnat_ip);
		//choose_disable(F.pri);
		choose_enable(F.en_pf);
		//chk_enpf(F);
	}else{
		//choose_enable(F.pri);
		//choose_disable(F.en_pf);
		//choose_disable(F.dnat_port);
	}
	
	if ( F.direct.selectedIndex == 1 )
	{
                F.dip.selectedIndex = 1;
                choose_disable(F.dip);
		choose_enable(F.dip_start);
	} 
		
	
	if ( F.direct.selectedIndex == 2 ) 
	{
	        var _name= new Array(__T(filter.alwaysallow),__T(filter.alwaysblock),__T(filter.blockbysch),__T(filter.allowbysch));
		//F.acl_action.options[0] = new Option(__T(filter.alwaysallow),"1");
		//F.acl_action.options[1] = new Option(__T(filter.allowbysch),"3");
		if ( F.direct.selectedIndex == 2 ) 
		{
                	F.dip.selectedIndex = 1;
			if ( dmz_enable == "0" ){
        	                my_alert(O_VAR,"direct",__T(msg.setdmzfirst),"0","msg_direct");
			}else{
				for(var i=0; i<lan_arr.length; i++)
				{
					if( lan_arr[i].vlan_id == dmz_vid ) 
					{
						var tmp = lan_arr[i].ipaddr.split(".");
						F.dip_start.value = tmp[0]+"."+tmp[1]+"."+tmp[2]+"."+dmz_ipaddr;
						//F.dnat_ip.value = tmp[0]+"."+tmp[1]+"."+tmp[2]+"."+dmz_ipaddr;
						break;
					}	
				}
			}
                	choose_disable(F.dip);
	                choose_disable(F.dip_start);
		}else{
		     /*
		     if ( F.acl_action[F.acl_action.selectedIndex].value==1 ||
		          F.acl_action[F.acl_action.selectedIndex].value==3 )
			choose_enable(F.dnat_ip);
		     else
			choose_disable(F.dnat_ip);
		     */
		     if ( F.direct.selectedIndex == 0 ) choose_enable(F.dip);
    		     if ( F.direct.selectedIndex == 1 && wan_ip_mode == "2" ) choose_enable(F.dip);
		     sel_dip(F);
			
		}
	}else{
		//F.dnat_ip.value = "";
		F.acl_action.options[0] = new Option(__T(filter.alwaysblock),"0");
		F.acl_action.options[1] = new Option(__T(filter.alwaysallow),"1");
		F.acl_action.options[2] = new Option(__T(filter.blockbysch),"2");
		F.acl_action.options[3] = new Option(__T(filter.allowbysch),"3");
		/*
		if ( F.direct.selectedIndex == 1  && 
		     ( F.acl_action.selectedIndex==1 || F.acl_action.selectedIndex == 3 ) ) 
		{
			choose_enable(F.dnat_ip);
			choose_enable(F.en_pf);
		}
		else{
			choose_disable(F.dnat_ip);
			choose_disable(F.en_pf);
			choose_disable(F.dnat_port);
		}*/
		if ( F.direct.selectedIndex == 0 ) choose_enable(F.dip);
		if ( F.direct.selectedIndex == 1 && wan_ip_mode == "2" ) choose_enable(F.dip);
		sel_dip(F);
	}
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

function enter_ip(F,val)
{
        clear_msg("sip_start","msg_sip_start");
        clear_msg("sip_end","msg_sip_end");
        clear_msg("dip_start","msg_dip_start");
        clear_msg("dip_end","msg_dip_end");
	var name_list=new Array("sip","dip");
	return check_valid_rule(F,val);
	/*
	if ( F.state.checked == true ) 
	{
		return check_valid_rule(F,val);
	}else{
		if ( val == "" ) 
		{
			for(var i=0; i<name_list.length; i++)
			{
				if ( eval("F."+name_list[i]).selectedIndex == 1 ) //Single
				{
					if ( !test_ipv4(eval("F."+name_list[i]+"_start").value) &&
					     !test_ipv6(eval("F."+name_list[i]+"_start").value) )  
					{
						my_alert(O_VAR,name_list[i]+"_start",__T(msg.ivalidipformat),"0","msg_"+name_list[i]+"_start");
						return false;
					}
				}
				if ( eval("F."+name_list[i]).selectedIndex > 1 ) //Range
				{
					if ( !test_ipv4(eval("F."+name_list[i]+"_end").value) &&
					     !test_ipv6(eval("F."+name_list[i]+"_end").value) )  
					{
						my_alert(O_VAR,name_list[i]+"_end",__T(msg.ivalidipformat),"0","msg_"+name_list[i]+"_end");
						return false;
					}
				}
				
			}
			
		}else{
			if ( !test_ipv4(eval("F."+val).value) && !test_ipv6(eval("F."+val).value) ) 
			{
				my_alert(O_VAR,val,__T(msg.ivalidipformat),"0","msg_"+val);
				return false;
			}
		}
	}
	return true; */
}
function ipmode_check(obj_name,flg)
{
	var F = document.frmacl;
	clear_msg(obj_name,"msg_"+obj_name);
	var errmsg = valid_ipmode_check(F,obj_name,flg);
        if ( errmsg != "" ) 
        {
	        my_alert(O_VAR,obj_name,errmsg,"0","msg_"+obj_name);
		return false;
        }else{
		if ( ( F.direct.selectedIndex == 0 && obj_name.indexOf("sip") != -1) ||//LAN>WAN   
		     ( F.direct.selectedIndex == 1 && obj_name.indexOf("dip") != -1) ) //WAN>LAN
		{	
			if ( check_ipv4(eval("F."+obj_name).value,VALID_IP_RULE7) == PASS ) 
			{
				if ( !lan_subnet_mask(eval("F."+obj_name).value) )
				{
	        			my_alert(O_VAR,obj_name,__T(msg.illegalipformat),"0","msg_"+obj_name);
					return false;
				}
			}
		}
	}
	return true;

}

function chk_lansubnet(F,obj_name)
{
	var passflg=1;
	for(var k=0; k<lan_arr.length; k++)
	{
		if ( valid_subnet(eval("F."+obj_name+"_start").value,
                     lan_arr[k].netmask,lan_arr[k].ipaddr))
		{
			if ( !valid_subnet(document.getElementById(obj_name+"_start").value,
					   lan_arr[k].netmask,
		                           document.getElementById(obj_name+"_end").value))
			{
				my_alert(O_VAR,obj_name+"_start",__T(msg.subnet5),"0","msg_"+obj_name+"_start");
				my_alert(O_VAR,obj_name+"_end",__T(msg.subnet5),"0","msg_"+obj_name+"_end");
                                passflg = 0;
				break;
			}
		}else{
			continue;
		}
		var IPS = document.getElementById(obj_name+"_start").value.split(".");
		var IPE = document.getElementById(obj_name+"_end").value.split(".");
		var IPM = lan_arr[k].netmask.split(".");
		var start_ip, end_ip;
		var IP_CLASS=3;
		for(var j=0; j<4; j++)
		{
			if ( IPS[j] != IPE[j] )
			{
				IP_CLASS=j;
				break;
			}
		}
		if ( IPS[IP_CLASS] > IPE[IP_CLASS] )
		{
			my_alert(O_VAR,obj_name+"_start",__T(msg.ipchk),"0","msg_"+obj_name+"_start");
	       	        passflg = 0 ;
			break;
		}
	}
	return passflg;
}
	
function chk_valid_ip(sip,eip)	
{
	var lan_mask = "<% nvram_get("lan_mask"); %>";
}

function check_valid_rule(F,val)
{
        clear_msg("sip_start","msg_sip_start");
        clear_msg("sip_end","msg_sip_end");
        clear_msg("dip_start","msg_dip_start");
        clear_msg("dip_end","msg_dip_end");
	var errflg=0;
	if ( F.sip.selectedIndex > 0 )
	{
		if (  F.direct.selectedIndex == 0 ) //LAN>WAN
		{
			if ( !ipmode_check("sip_start",LANSUBNET_OK) ) errflg = 1;
		}else{
			if ( !ipmode_check("sip_start",LANSUBNET_NO) ) errflg = 1;
		}
	}
	if ( F.sip.selectedIndex == 2 ) //Address Range
	{
		if (  F.direct.selectedIndex == 0 ) //LAN>WAN
		{
			if ( !ipmode_check("sip_end",LANSUBNET_OK) ) errflg = 1;
			if ( errflg == 0  )
			{
				if ( check_ipv4(F.sip_start.value,VALID_IP_RULE1) == PASS && 
				     check_ipv4(F.sip_end.value,VALID_IP_RULE1) == PASS )
				{
					if ( !chk_lansubnet(F,"sip")) errflg = 1;
					/*
					var s = F.sip_start.value.split(".");
					var e = F.sip_end.value.split(".");
                        		if ( !errflg && parseInt(s[3],10) > parseInt(e[3],10) ) 
	                        	{
						my_alert(O_VAR,"sip_start",__T(msg.ipchk),"0","msg_sip_start");
                	                	errflg = 1;
                        		}*/
				}
			}
		}else{
			if ( !ipmode_check("sip_end",LANSUBNET_NO) ) errflg = 1;
		}
		
	}
	if ( F.dip.selectedIndex > 0 )
	{
		if (  F.direct.selectedIndex == 0 ) //LAN>WAN
		{
			if ( !ipmode_check("dip_start",LANSUBNET_NO) ) errflg = 1;
		}else{
			if ( !ipmode_check("dip_start",LANSUBNET_OK) ) errflg = 1;
		}
	}
	if ( F.dip.selectedIndex == 2 ) //Address Range
	{
		if (  F.direct.selectedIndex == 0 ) //LAN>WAN
		{
			if ( !ipmode_check("dip_end",LANSUBNET_NO) ) errflg = 1;
		}else{
			if ( !ipmode_check("dip_end",LANSUBNET_OK) ) errflg = 1;
			if ( errflg == 0  )
			{
				if ( check_ipv4(F.dip_start.value,VALID_IP_RULE1) == PASS && 
				     check_ipv4(F.dip_end.value,VALID_IP_RULE1) == PASS )
				{
					if ( !chk_lansubnet(F,"dip")) errflg = 1;
					/*
					var s = F.dip_start.value.split(".");
					var e = F.dip_end.value.split(".");
                        		if ( !errflg && parseInt(s[3],10) > parseInt(e[3],10) ) 
	                        	{
						alert("emily2");
						my_alert(O_VAR,"dip_start",__T(msg.ipchk),"0","msg_dip_start");
                	                	errflg = 1;
                        		}*/
				}
			}
		}

	}
	if ( errflg == 1 ) return false;
	return true;	
	
}

function check_valid_rule2(F,val)
{
        clear_msg("sip_start","msg_sip_start");
        clear_msg("sip_end","msg_sip_end");
        clear_msg("dip_start","msg_dip_start");
        clear_msg("dip_end","msg_dip_end");

	var errmsg = "";
	var errflg=0;
	var name_arr=new Array("sip","dip");
	var sip_start_type="",sip_finish_type="";
	var dip_start_type="",dip_finish_type="";
	for(var i=0; i<name_arr.length; i++)
	{
		if ( eval("F."+name_arr[i]).selectedIndex > 0 )
		{
			if ( validate_ip(F,name_arr[i]+"_start",VALID_IP_RULE1,ZERO_NO|MASK_NO)){
				if ( name_arr[i] == "sip" ) sip_start_type="ipv4";
				else dip_start_type="ipv4";
			}
			else if ( valid_ipv6(eval("F."+name_arr[i]+"_start").value) == ""){
				if ( name_arr[i] == "sip" ) sip_start_type="ipv6";
				else dip_start_type="ipv6";
			}
			if ( F.direct.selectedIndex == 0 )
			{
				if ( name_arr[i] == "sip" ) 
				{
					if ( lan_ip_mode == "2" && wan_ip_mode == "1" )
						errmsg = valid_ipmode_check(F,name_arr[i]+"_start",1,"IPv6");
					else
					{
						errmsg = valid_ipmode_check(F,name_arr[i]+"_start",1);
						
					}
				}
				else
				{
					if ( lan_ip_mode == "2" && wan_ip_mode == "1" && 
					     ( sip_start_type!="any" || F.service.selectedIndex!=0 ) )
						errmsg = valid_ipmode_check(F,name_arr[i]+"_start",0,"IPv6");
					else	
						errmsg = valid_ipmode_check(F,name_arr[i]+"_start",0);
				}
			}else if (  F.direct.selectedIndex == 1 ) 
			{
				if ( name_arr[i] == "sip" ) 
                                        errmsg = valid_ipmode_check(F,name_arr[i]+"_start",0);
                                else
                                        errmsg = valid_ipmode_check(F,name_arr[i]+"_start",1);
			}
			if ( errmsg != "" ){
				my_alert(O_VAR,name_arr[i]+"_start",errmsg,"0","msg_"+name_arr[i]+"_start");
				errflg = 1 ;
			}
		}else{
			if ( name_arr[i] == "sip" ) sip_start_type="any";
			else dip_start_type="any";
		}
		if ( eval("F."+name_arr[i]).selectedIndex == 2 )
		{
			if ( validate_ip(F,name_arr[i]+"_start",VALID_IP_RULE1,ZERO_NO|MASK_NO)){
				if ( name_arr[i] == "sip" ) sip_finish_type="ipv4";
				else dip_finish_type="ipv4";
			}
			else if ( valid_ipv6(eval("F."+name_arr[i]+"_start").value) == ""){
				if ( name_arr[i] == "sip" ) sip_finish_type="ipv6";
				else dip_finish_type="ipv6";
			}
			if ( F.direct.selectedIndex == 0 )
			{ 
				if ( name_arr[i] == "sip" ) 
				{
					if ( lan_ip_mode == "2" && wan_ip_mode == "1" )
						errmsg = valid_ipmode_check(F,name_arr[i]+"_end",1,"IPv6");
					else
						errmsg = valid_ipmode_check(F,name_arr[i]+"_end",1);
				}
				else{
					if ( lan_ip_mode == "2" && wan_ip_mode == "1" &&
					     ( sip_start_type!="any" || F.service.selectedIndex!=0 ) )
						errmsg = valid_ipmode_check(F,name_arr[i]+"_end",0,"IPv6");
					else
						errmsg = valid_ipmode_check(F,name_arr[i]+"_end",0);
				}
			}else if (  F.direct.selectedIndex == 1 ) 
			{
				if ( name_arr[i] == "sip" ) 
                                        errmsg = valid_ipmode_check(F,name_arr[i]+"_end",0);
                                else{
                                        errmsg = valid_ipmode_check(F,name_arr[i]+"_end",1);
				}
			}
			if ( errmsg != "" ){
				my_alert(O_VAR,name_arr[i]+"_end",errmsg,"0","msg_"+name_arr[i]+"_end");
				errflg = 1 ;
			}
			if ( !errflg && 
			     ((name_arr[i]=="sip" && sip_start_type=="ipv4") ||
			     (name_arr[i]=="dip" && dip_start_type=="ipv4")))
			{
				if ( !chk_lansubnet(F,name_arr[i]) ) errflg = 1 ;
				/*
				for(var k=0; k<lan_arr.length; k++)
				{
					if ( valid_subnet(eval("F."+name_arr[i]+"_start").value,
                                                          lan_arr[k].netmask,lan_arr[k].ipaddr))
					{
						if ( !valid_subnet(document.getElementById(name_arr[i]+"_start").value,
								   lan_arr[k].netmask,
			                                          document.getElementById(name_arr[i]+"_end").value))
						{
							my_alert(O_VAR,name_arr[i]+"_start",__T(msg.subnet5),"0","msg_"+name_arr[i]+"_start");
							my_alert(O_VAR,name_arr[i]+"_end",__T(msg.subnet5),"0","msg_"+name_arr[i]+"_end");
                        			        errflg = 1;
							break;
						}
					}
				}*/
			}
			if ( !errflg &&
			     (( name_arr[i] == "sip" && sip_start_type!="any" && sip_start_type!=sip_finish_type ) ||
			     ( name_arr[i] == "dip" && dip_start_type!="any" && dip_start_type!=dip_finish_type ) ))
			{
				
				my_alert(O_VAR,name_arr[i]+"_start",__T(msg.ivalidipformat),"0","msg_"+name_arr[i]+"_start");
				my_alert(O_VAR,name_arr[i]+"_end",__T(msg.ivalidipformat),"0","msg_"+name_arr[i]+"_end");
                                errflg = 1;
			}
			var s = document.getElementById(name_arr[i]+"_start").value.split(".");
                        var e = document.getElementById(name_arr[i]+"_end").value.split(".");
			if ( (name_arr[i]=="sip" && sip_start_type=="ipv4") ||
			     (name_arr[i]=="dip" && dip_start_type=="ipv4"))
			{
				if ( !chk_lansubnet(F,name_arr[i]) ) errflg = 1 ;
				/*
                        	if ( !errflg && parseInt(s[3],10) > parseInt(e[3],10) ) 
	                        {
					alert("emily3");
					my_alert(O_VAR,name_arr[i]+"_start",__T(msg.ipchk),"0","msg_"+name_arr[i]+"_start");
                	                errflg = 1;
                        	}*/
			}

		}
	}
	/*
	if ( !errflg && 
	     ( dip_start_type!="any" && sip_start_type!="any" && sip_start_type!=dip_start_type ) ||
	     ( dip_finish_type!="any" && sip_finish_type!="any" && sip_finish_type!=dip_finish_type ))
	{
		my_alert(O_VAR,"sip_start_type",__T(msg.ivalidipformat),"0","msg_sip_start");
		my_alert(O_VAR,"dip_start_type",__T(msg.ivalidipformat),"0","msg_dip_start");
                errflg = 1;
	}*/
	if ( errflg == 1 ) return false;
	return true;
	
}

function check_before_data(F)
{
	var errflg=0;
	clear_msg("sip_start","msg_sip_start");
	clear_msg("sip_end","msg_sip_end");
	clear_msg("dip_start","msg_dip_start");
	clear_msg("dip_end","msg_dip_end");
	var sip_err=0, dip_err=0;
	if ( !enter_ip(F,"") ) return false;
	if ( F.direct.selectedIndex == "2" ) 
	{
		if ( dmz_enable == "0" ){
                        my_alert(O_VAR,"direct",__T(msg.setdmzfirst),"0","msg_direct");
			errflg = 1;
		}
	}
	clear_msg("sch","msg_sch");
	if (F.acl_action[F.acl_action.selectedIndex].value==2 || 
              F.acl_action[F.acl_action.selectedIndex].value==3){
		if ( F.sch.value == "" ) 
		{
			my_alert(O_VAR,"sch",__T(msg.notblank),"0","msg_sch");
			errflg = 1;	
			
		}	
	}
	/*
	if ( F.direct.selectedIndex != 0 )
	{
                choose_enable(F.dip);
		choose_enable(F.dip_start);
	} */
	if ( errflg ) return false;
	return true;
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

function uiDoSave(F)
{
	if ( !check_before_data(F) ) return false;
	choose_enable(F.dip); // WAN > LAN , only allow single IP
	choose_enable(F.dip_start);
	F.submit_button.value="ip_based_acl";
	F.gui_action.value="Apply";
	F.stflg.value = stflg;
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function chk_enpf(F)
{
	if ( F.en_pf.checked == true ) 
		choose_enable(F.dnat_port);
	else
		choose_disable(F.dnat_port);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmacl method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=wait_time value=5>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,frmtitle,"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.conntype));</script>
		<script>
		draw_object(O_GUI,SELBOX,"direct","id=direct onChange=sel_direct(this.form)",direct_name,direct_val);</script>
		<span id=msg_direct></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.action));</script>
		<script>
		draw_object(O_GUI,SELBOX,"acl_action","onChange=sel_action(this.form)",action_name,action_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.schedule));</script>
		<script>
		draw_object(O_GUI,SELBOX,"sch","id=sch disabled",sch_name,sch_name);
		document.write("&nbsp;");
		draw_object(O_GUI,BT,__T(filter.confsch),"t1","BT_L","m_schedule()");
		</script>
		<span id=msg_sch></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.services));</script>
		<script>
		draw_object(O_GUI,SELBOX,"service","",service_list,service_list);
		document.write("&nbsp;");
		draw_object(O_GUI,BT,__T(filter.confservice),"t2","BT_L","m_service()");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.sip));</script>
		<script>
	        var _name= new Array(__T(filter.any),__T(filter.saddr),__T(filter.addrrange));
	        var _val= new Array("2","0","1");
		draw_object(O_GUI,SELBOX,"sip","onChange=sel_sip(this.form)",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.start));</script>
		<input size=51 name=sip_start id=sip_start maxlength=39 onblur=enter_ip(this.form,"sip_start")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"192.168.1.100","fec0::64"));</script>
		<span id=msg_sip_start></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.finish));</script>
		<input size=51 name=sip_end id=sip_end maxlength=39 onblur=enter_ip(this.form,"sip_end")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"192.168.1.200","fec0::c8"));</script>
		<span id=msg_sip_end></span>
                </td></tr>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(filter.dip),"","colspan=2");</script>
		<script>
	        var _name= new Array(__T(filter.any),__T(filter.saddr),__T(filter.addrrange));
	        var _val= new Array("2","0","1");
		draw_object(O_GUI,SELBOX,"dip","id=dip onChange=sel_dip(this.form)",_name,_val);
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.start));</script>
                <input size=51 name=dip_start id=dip_start maxlength=39 onblur=enter_ip(this.form,"dip_start")>
		<span id=msg_dip_start></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.finish));</script>
                <input size=51 name=dip_end id=dip_end maxlength=39 onblur=enter_ip(this.form,"dip_end")>
		<span id=msg_dip_end></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.log),"","colspan=2");</script>
                <script>
			draw_object(O_GUI,SELBOX,"log","",log_name,log_val);
                </script>
                </td></tr>	
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.qosprior));</script>
                <script>
		draw_object(O_GUI,SELBOX,"pri","",pri_name,pri_val);
                </script>
		</TD></TR-->
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.sendtolocalserver));</script>
		<input size=20 name=dnat_ip id=dnat_ip maxlength=64>
		<span id=msg_dnatip></span>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.portforwarding));</script>
		<input type=checkbox name=en_pf onClick=chk_enpf(this.form)> <script>Capture(share.enable);</script>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.dnatport));</script>
		<input name=dnat_port id=dnat_port disabled size=20 maxlength=5 onblur=my_chk_range(this.value,"dnat_port",1,65535,"msg_dnatport")> <script>document.write("("+__T(def.range)+" : 1 - 65535)");</script>
		<SPAN id=msg_dnatport></SPAN>
		</TD></TR-->	
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.rulest),SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=state> <script>Capture(share.enable);</script>
                </TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
