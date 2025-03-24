<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var lan_arr = new Array();
function LAN(vlan_id,ipaddr,netmask,proto,dhcprelay_ip,start_ip,user_num,lease_time,dns1,dns2,dns3,wins,dnsmode)
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
	this.dnsmode=dnsmode;
}
<% get_lan_data("lan_arr"); %>
var now_vlan_id = "<% nvram_gozila_get("vlan_selidx"); %>";
if ( now_vlan_id == "" || now_vlan_id >= lan_arr.length ) now_vlan_id="0";

var obj = lan_arr[now_vlan_id];
var tmpip = obj.ipaddr.split(".");
var prefix_ip = tmpip[0]+" . "+tmpip[1]+" . "+tmpip[2]+" . ";
//skip_name=new Array("vlan_id");

//============FOR INDEX - DHCP of IP RANGE ==================
var MAX_RANGE_COUNT;
var RANGE_SET;
var DHCP_START_IP = new Array();
var DHCP_END_IP = new Array();
var RANGE_COUNT;
var VALID_RANGE_START;
var VLAID_RANGE_END;
//============END OF FOR INDEX             ==================

function DHCP_IP_RANGE(submask,lanip3)
{
	var mask = new Array();
	var lainip3,iplen,iprange,i,st,et;
	var F = document.frmlan; 
		
	mask = submask.split(".");
	iprange = 256 - parseInt(mask[3]);
	iplen = 256/iprange;
	MAX_RANGE_COUNT = iprange-3 ; // RouterIP , broadcast IP, network IP
	var tmp = (parseInt(lanip3/iprange,10))*iprange;
	VALID_RANGE_START = tmp;
	VALID_RANGE_END = tmp+(iprange-2);
	//alert("VALID_RANGE_START="+VALID_RANGE_START+"\nVALID_RANGE_END="+VALID_RANGE_END);
	if ( iprange > 50 ) 
		RANGE_COUNT = 50;
	else
		RANGE_COUNT = iprange - 3 ; 
//	if ( parseInt(DHCP_START_IP[0],10)+RANGE_COUNT > MAX_RANGE_COUNT+1 ) 
//		RANGE_COUNT = (MAX_RANGE_COUNT+1)-parseInt(DHCP_START_IP[0],10);
//	alert("RANGE_COUNT="+RANGE_COUNT+";iprange="+iprange+"iplen="+iplen+";MAX_RANGE_COUNT="+MAX_RANGE_COUNT);
	for(i=0; i<iplen; i++)
	{
		if( iplen == 1 && lanip3 == 1 ) 
		{
			DHCP_START_IP[0] = "100" ;
			DHCP_END_IP[0] = parseInt(DHCP_START_IP[0])+parseInt(RANGE_COUNT)-1;
			RANGE_SET = 1 ; 
			return ""; 
		}
		else
	        {
			// IP set
			st = i*iprange ; 
			et = ((i+1)*iprange)-1;
			if ( lanip3 == st ) // dhcp start ip = router lan ip 
			{
				RANGE_SET = 0 ; 
				return __T(msg.invalidrip1);
			}
			if ( lanip3 == et ) // dhcp end ip = router lan ip
			{
				RANGE_SET = 0 ; 
				return __T(msg.invalidrip2);
			}
			if (( parseInt(st) < parseInt(lanip3) ) && ( parseInt(lanip3) < parseInt(et) ))
			{
				st = st + 1 ; //It cannot be the network IP
				if ( st == lanip3 ) 
 //Subnet of First IP
				{
					DHCP_START_IP[0] = st+1;
					DHCP_END_IP[0] = parseInt(DHCP_START_IP[0])+parseInt(RANGE_COUNT)-1;
					RANGE_SET = 1 ;
					return ""; 
				}
				else if ( parseInt(F.dhcp_start.value,10) > lanip3 ) 
				{
					DHCP_START_IP[0] = st ; 
					DHCP_END_IP[0] = parseInt(DHCP_START_IP[0]) + parseInt(RANGE_COUNT) -1 ; 
					RANGE_SET = 1; 
				}
				else
				{
					/*
					if ( lanip3 - st >= RANGE_COUNT ) 
					{
						DHCP_START_IP[0] = st ; 
						DHCP_END_IP[0] = parseInt(DHCP_START_IP[0]) + parseInt(RANGE_COUNT) -1 ; 
						RANGE_SET = 1; 
					}
					else
 */ 
					{
						DHCP_START_IP[0] = st ; 
						DHCP_END_IP[0] = parseInt(lanip3)-1;
						DHCP_START_IP[1] = parseInt(lanip3)+1;
						DHCP_END_IP[1] = parseInt(DHCP_START_IP[1])+parseInt(RANGE_COUNT)-(parseInt(DHCP_END_IP[0])-parseInt(DHCP_START_IP[0]))-2;
						RANGE_SET = 2 ; 
						return ""; 
					}
				}
			}
		}	
	}		
	return ""; 
}

function init(){
	if ( http_power == "r" ) return;
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmlan; 
	var sip = F.dhcp_start.value ; //'<% nvram_get("dhcp_start"); %>';
	var num = F.dhcp_num.value; //'<% nvram_get("dhcp_num");%>';
	var eip = parseInt(parseInt(num)+parseInt(sip)-1);
	var RANGSET;
	chg_server();
	//update_val2();
	default_nv = keep_val(F,"");
	if ((parseInt(sip)<parseInt(F.lanip_3.value)) && (parseInt(eip)>=parseInt(F.lanip_3.value)))
		RANGESET = 2 ; 	     
	else 
		RANGESET = 1; 
		
	if ( RANGESET == 1 ) 
	{
		document.getElementById("DymRange").innerHTML = prefix_ip+sip+" - "+eip;
	}
	else if ( RANGESET == 2 )
        {
                document.getElementById("DymRange").innerHTML = prefix_ip+sip+" - "+parseInt(parseInt(F.lanip_3.value)-1);
                //if ( parseInt(F.lanip_3.value)+1 > eip ) 
		eip = eip + 1 ;
                document.getElementById("DymRange").innerHTML += "<BR>"+prefix_ip+ parseInt(parseInt(F.lanip_3.value)+1) + " - " + eip;
        } 
}


function EN_DIS_OBJ(F,len,obj_name,flg){
	for(var i=0; i<len; i++)
	{
		if ( flg == true ) //DISABLE
		choose_disable(eval("F."+obj_name+"_"+i));
		else
		choose_enable(eval("F."+obj_name+"_"+i));
	}
}

function chg_server(){
	var F = document.frmlan;
	EN_DIS_OBJ(F,4,"_dhcprelay_ipaddr",false);
	DISABLE_PART(F,"dhcp_start_area","dhcp_end_area",0);
	if ( F._lan_proto[0].checked == true ) 
	{
		F.lan_proto.value = F._lan_proto[0].value;
		EN_DIS_OBJ(F,4,"_dhcprelay_ipaddr",true);
		chg_dnsmode(F);
	}
	else if ( F._lan_proto[1].checked == true ) 
	{
		F.lan_proto.value = F._lan_proto[1].value;
		DISABLE_PART(F,"dhcp_start_area","dhcp_end_area",1);
	}
	else if ( F._lan_proto[2].checked == true ) 
	{
		F.lan_proto.value = F._lan_proto[2].value;
		DISABLE_PART(F,"dhcp_start_area","dhcp_end_area",1);
		EN_DIS_OBJ(F,4,"_dhcprelay_ipaddr",false);
	}
}

function changed_ip_range(F)
{
        tmpip =  get_full_ip(F,"lanip").split(".");
        prefix_ip = tmpip[0]+" . "+tmpip[1]+" . "+tmpip[2]+" . ";
        Sel_SubMask(get_full_ip(F,"lanmask"),F,"");
        document.getElementById("show_sip").innerHTML = prefix_ip;
}

var keep_ip_type="";
function update_val(obj)
{
	var F = document.frmlan;
	if ( !msg_chk_range(document.getElementById(obj).value,obj,0,255,10,IS_FIELD,0,"msg_"+obj.split("_")[0] ) )
	{
		return;
	}
	if ( keep_ip_type == "" || ( keep_ip_type != "" && (obj.indexOf(keep_ip_type) != -1)) ) 
	{
		
		if( obj.indexOf("dhcprelay") != -1 ) 
			keep_ip_type = "dhcprelay"
		else
			keep_ip_type = obj.split("_")[0];
		return;
		
	}
	if ( keep_ip_type.indexOf("wins")!=-1 ){
		if ( !my_valid_m_value("IP",F,"wins","",VALID_IP_RULE1,ZERO_OK,"msg_wins")) 
			errflg = 1;
		else
			document.getElementById("msg_wins").innerHTML = "";
	}else if ( keep_ip_type.indexOf("dns0")!=-1 ){
		if ( !my_valid_m_value("IP",F,"dns0","",VALID_IP_RULE1,ZERO_OK,"msg_dns0")) 
			errflg = 1;
		else
			document.getElementById("msg_dns0").innerHTML = "";
	}else if ( keep_ip_type.indexOf("dns1")!=-1 ){
		if ( !my_valid_m_value("IP",F,"dns1","",VALID_IP_RULE1,ZERO_OK,"msg_dns1")) 
			errflg = 1;
		else
			document.getElementById("msg_dns1").innerHTML = "";
	}else if ( keep_ip_type.indexOf("dns2")!=-1 ){
		if ( !my_valid_m_value("IP",F,"dns2","",VALID_IP_RULE1,ZERO_OK,"msg_dns2")) 
			errflg = 1;
		else
			document.getElementById("msg_dns2").innerHTML = "";
	}else if ( keep_ip_type.indexOf("lanip")!=-1 ){
		if ( !my_valid_m_value("IP",F,"lanip","",VALID_IP_RULE1,ZERO_OK,"msg_lanip")) 
			errflg = 1;
		else
			document.getElementById("msg_lanip").innerHTML = "";
     	}else{
		if ( !my_valid_m_value("IP",F,"_dhcprelay_ipaddr","",VALID_IP_RULE1,ZERO_NO,"msg__dhcprelay_ipaddr"))
			errflg = 1;
		else
			document.getElementById("msg__dhcprelay_ipaddr").innerHTML = "";
	}
	if( obj.indexOf("dhcprelay") != -1 ) 
                keep_ip_type = "dhcprelay"
        else
                keep_ip_type = obj.split("_")[0];	
}

function update_val2()
{
	var _name = new Array("lan_ipaddr","lan_netmask","lan_dhcp_dns","lan_dhcp_wins","dhcprelay_ipaddr");
	var _name2 = new Array("lanip","lanmask","dns","wins","_dhcprelay_ipaddr");
	var tmp="";
	var F = document.frmlan;
	for(var i=0; i<_name.length; i++)
	{
		if ( _name[i] == "lan_ipaddr" ) 
		{
			changed_ip_range(F);		
		}
		//if ( _name[i] == "lan_dhcp_dns" ) continue;
		if ( _name[i] == "lan_dhcp_dns" )
		{
			for(var j=0; j<3; j++)
			{
				if ( !my_valid_m_value("IP",F,_name2[i]+j,"",VALID_IP_RULE1,ZERO_OK,"msg_"+_name2[i]+j)) continue;
				if ( tmp != "" ) tmp += " ";
                        	tmp += get_full_ip(F,_name2[i]+j);
			}
                        eval("F."+_name[i]).value = tmp;                 
			
		}else{
			if ( _name[i] == "dhcprelay_ipaddr" && F._lan_proto[2].checked == false ) continue;
			if ( _name2[i] == "lanmask" ){
				if ( valid_mask(F,"lanmask",ZERO_NO&BCST_NO,"msg_lanmask") == false ) continue;
			}
			else if ( _name2[i] == "wins" ){ 
				if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE1,ZERO_OK,"msg_"+_name2[i])) continue;			     
			}else{
				if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE1,ZERO_NO,"msg_"+_name2[i])) continue;
//				if ( _name2[i] == "lanip" ) Sel_SubMask(F.lan_netmask.value,F);
			} 
				
	        	eval("F."+_name[i]).value = get_full_ip(F,_name2[i]);
		}
	}
}

function chg_vid(F)
{
	F.vlan_selidx.value = F.vlan_id.selectedIndex;
	F.submit_button.value="lan";
	F.submit_type.value="change_vid";
	F.change_action.value = "gozila_cgi";
	F.submit();
}
function Sel_SubMask(I,F,flg){
	var _name = new Array("dhcp_num","dhcp_start","lanip");
	for(var i=0; i<_name.length; i++)
	{
		if ( _name[i] == "lanip" ) 
			clear_msg(_name[i]+"_3","msg_"+_name[i]);	
		else
			clear_msg(_name[i],"msg_"+_name[i]);	
	}
	if ( F._lan_proto[0].checked == false ) return true; 
	var msg = DHCP_IP_RANGE(I,F.lanip_3.value);
	if ( msg != "" )
	{
		my_alert(O_VAR,"lanip_3", msg,"0","msg_lanip");
		return false;
	}
	if ( flg == "save" ) return true;
	if ( (parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10) ) >= 255 ) return false;
	if ( (parseInt(F.lanip_3.value,10) > parseInt(F.dhcp_start.value,10)) &&
	     (parseInt(F.lanip_3.value,10) < (parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10))))
	{
		RANGE_SET = 2;
		DHCP_START_IP[0] = F.dhcp_start.value;
		DHCP_END_IP[0] = parseInt(F.lanip_3.value,10)-1;
		DHCP_START_IP[1] = parseInt(F.lanip_3.value,10)+1;
		DHCP_END_IP[1] = parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10);
	}else{
		RANGE_SET = 1;
		DHCP_START_IP[0] = F.dhcp_start.value;
		DHCP_END_IP[0] = parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10)-1;
	}
	if ( RANGE_SET == 1 ) 
	{
		document.getElementById("DymRange").innerHTML = prefix_ip + DHCP_START_IP[0] + " - " + DHCP_END_IP[0];
	}else if ( RANGE_SET == 2 ){ 
		document.getElementById("DymRange").innerHTML = prefix_ip + DHCP_START_IP[0] + " - "+ DHCP_END_IP[0];
                document.getElementById("DymRange").innerHTML +="<BR>"+prefix_ip + DHCP_START_IP[1] + " - "+DHCP_END_IP[1];
	}
}

function CHK_DHCP_RANGE(F){
	var I = get_full_ip(F,"lanmask");
	if ( F._lan_proto[0].checked == false ) return true; 
	DHCP_IP_RANGE(I,F.lanip_3.value);
	var sip = parseInt(DHCP_START_IP[0],10);
	if ( sip == 100 ) sip = 0 ;
	var num = sip+parseInt(F.dhcp_num.value,10);
	var xnum = sip+parseInt(MAX_RANGE_COUNT,10);
	//alert("num="+num+";xnum="+xnum+";max_range="+MAX_RANGE_COUNT);
	clear_msg("dhcp_num","msg_dhcp_num");
	clear_msg("dhcp_start","msg_dhcp_start");
	if (document.getElementById("dhcp_num").value=="" )
	{
		my_alert(O_VAR,"dhcp_num",__T(msg.notblank),"0","msg_dhcp_num");
		return false;	
	}
	if (document.getElementById("dhcp_start").value=="")
	{
		my_alert(O_VAR,"dhcp_start",__T(msg.notblank),"0","msg_dhcp_start");
		return false;	
	}
	if (!chk_chartype(document.getElementById("dhcp_num").value,DIGIT))
	{
		my_alert(O_VAR,"dhcp_num",__T(msg.illegal),"0","msg_dhcp_num");
		return false;	
	}
	if (!chk_chartype(document.getElementById("dhcp_start").value,DIGIT))
	{
		my_alert(O_VAR,"dhcp_start",__T(msg.illegal),"0","msg_dhcp_start");
		return false;	
	}
	document.getElementById("dhcp_num").value=parseInt(F.dhcp_num.value,10);
	document.getElementById("dhcp_start").value=parseInt(F.dhcp_start.value,10);
	if ( parseInt(F.dhcp_num.value,10) <= 0 ) 
	{
		my_alert(O_VAR,"dhcp_num",__T(msg.invalidip2),"0","msg_dhcp_num");
		return false;
	}
	//1--> start ip
	//if ( !my_chk_range(1+parseInt(F.dhcp_num.value,10),"dhcp_start",F.dhcp_start.value,MAX_RANGE_COUNT+1,"msg_dhcp_start","nochg")){
	//alert("F.dhcp_start.value="+F.dhcp_start.value+";F.dhcp_num.value="+F.dhcp_num.value+"\nRANGE_SET="+RANGE_SET+";MAX_RANGE_COUNT="+MAX_RANGE_COUNT+";VALID_RANGE_START="+VALID_RANGE_START+";VALID_RANGE_END="+VALID_RANGE_END);
	//parseInt(F.lanip_3.value,10);
	if ( RANGE_SET == 1 && !msg_chk_range(parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10)-1,"dhcp_start",VALID_RANGE_START,VALID_RANGE_END,10,IS_FIELD,0,"msg_dhcp_start")){
		my_alert(O_VAR,"dhcp_num",__T(msg.invalidip2),"0","msg_dhcp_num");
		my_alert(O_VAR,"dhcp_start",__T(msg.invalidip2),"0","msg_dhcp_start");
                return false;
	}
	if ( RANGE_SET == 2 && !msg_chk_range(parseInt(F.dhcp_start.value,10)+parseInt(F.dhcp_num.value,10),"dhcp_start",VALID_RANGE_START,VALID_RANGE_END,10,IS_FIELD,0,"msg_dhcp_start")){
		my_alert(O_VAR,"dhcp_num",__T(msg.invalidip2),"0","msg_dhcp_num");
		my_alert(O_VAR,"dhcp_start",__T(msg.invalidip2),"0","msg_dhcp_start");
                return false;
	}
	if ( F.lanip_3.value == F.dhcp_start.value ) 
	{
		my_alert(O_VAR,"dhcp_num",__T(msg.invalidip1),"0","msg_dhcp_num");
		return false; 		
	}
	if ( (parseInt(F.dhcp_start.value,10) == parseInt(MAX_RANGE_COUNT,10)+2) ) 
	{
		my_alert(O_VAR,"dhcp_start",__T(msg.invalidip1),"0","msg_dhcp_start");
		return false; 		
	}
	if ( parseInt(F.dhcp_start.value,10) < parseInt(sip,10) || parseInt(F.dhcp_start.value,10) > xnum ) 
        {
		my_alert(O_VAR,"dhcp_start",__T(msg.invalidip2),"0","msg_dhcp_start");
		return false; 		
	}
	if ( parseInt(F.dhcp_start.value) == 0 )
	{
		my_alert(O_VAR,"dhcp_start",__T(msg.illegal),"0","msg_dhcp_start");
		return false; 		
	} 
	//alert("sip="+sip+";num="+num+";xnum="+xnum+",RANGE_SET="+RANGE_SET);
	if ( RANGE_SET == 1 )
        {	
                if ( (sip > num) || (xnum < num) )
                {
			my_alert(O_VAR,"dhcp_num",__T(msg.invalidip2),"0","msg_dhcp_num");
			my_alert(O_VAR,"dhcp_start",__T(msg.invalidip2),"0","msg_dhcp_start");
                        return false;
                }
        }
	else if ( RANGE_SET == 2 )
        {
                if ( (num < sip) || (num == parseInt(F.lanip_3.value,10)) || (num > xnum) )
                {
			my_alert(O_VAR,"dhcp_num",__T(msg.invalidip2),"0","msg_dhcp_num");
			my_alert(O_VAR,"dhcp_start",__T(msg.invalidip2),"0","msg_dhcp_start");
                        return false;
                }

        }
	return true;
}

function valid_value(F){
	var errflg=0;
	//var _name = new Array("lanip","dns0","dns1","dns2","wins","_dhcprelay_ipaddr");
	var _name = new Array("lanip","_dhcprelay_ipaddr");
	var _dns_name = new Array("dns0","dns1","dns2","wins");
	var dnsflg=0;
	for(var i=0; i<_dns_name.length; i++)
	{
		if ( F._lan_proto[2].checked == true ) break; 
		if(F.lan_dns_mode.value != "3" ) break;
		parent.document.getElementById("obj_id").value = "msg_"+_dns_name[i];
		if( dnsflg == 0 )
		{
			if ( !my_valid_m_value("IP",F,_dns_name[i],"",VALID_IP_RULE1,ZERO_NO,"msg_"+_dns_name[i])) 
			{
				errflg = 1;
				break;
			}
			else
				dnsflg = 1;
		}
		else
		{
			if ( !my_valid_m_value("IP",F,_dns_name[i],"",VALID_IP_RULE1,ZERO_OK,"msg_"+_dns_name[i])) 
				errflg = 1;
		}
			
	}
	for(var i=0; i<_name.length; i++)
	{
		parent.document.getElementById("obj_id").value = "msg_"+_name[i];
		/*
		if ( _name[i].indexOf("dns") != -1 || _name[i].indexOf("wins") != -1)
		{
			if ( F._lan_proto[2].checked == true ) continue; 
			if ( !my_valid_m_value("IP",F,_name[i],"",VALID_IP_RULE1,ZERO_OK,"msg_"+_name[i])) 
			errflg = 1;
		}
		else 
		*/
		if ( _name[i].indexOf("mask") != -1 )
		{
			if ( my_valid_m_value("MASK",F,_name[i],ZERO_NO,"msg_"+_name[i]) == FAIL )
			errflg = 1;
		}else{
			if ( _name[i] == "_dhcprelay_ipaddr" ) 
			{
				if ( F._lan_proto[2].checked != true ) continue; 
			}
			if ( _name[i] == "lanip" ) 
			{
				var lanip = F.lanip_0.value+"."+F.lanip_1.value+"."+F.lanip_2.value+"."+F.lanip_3.value;
				// check with other LAN in the same subnet or not.
				for(var j=0; j<lan_arr.length; j++)
				{
					if ( j == now_vlan_id ) continue;	
					if ( valid_subnet(lanip,get_full_ip(F,"lanmask"),lan_arr[j].ipaddr) )
					{
						my_alert(O_VAR,"lanip",__T(msg.subnet11),"4","msg_lanip");
						errflg = 1; 
						return false;
					}
					
				}		
				// check with WAN in the same subnet or not.
				if (errflg != 1 && valid_subnet(lanip,get_full_ip(F,"lanmask"),"<% nvram_get("wan_ipaddr"); %>") )
				{
					my_alert(O_VAR,"lanip",__T(msg.subnet10),"4","msg_lanip");
					errflg = 1; 
					return false;
				}
				
			}
		        if (errflg!=1 && !my_valid_m_value("IP",F,_name[i],"",VALID_IP_RULE1,ZERO_NO,"msg_"+_name[i])) 
				errflg = 1;
		}
	}
	if ( errflg == 1 ) return false;
	return true;
	
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("lan.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}


function uiDoSave(F)
{
	var errflg = 0 ;
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	var _name = new Array("dhcp_num","dhcp_start","dns0","dns1","dns2","wins");
	for(var i=0; i<_name.length; i++)
		clear_msg(_name[i],"msg_"+_name[i]);	
	if( !valid_value(F) ) return;
	if ( valid_mask(F,"lanmask",ZERO_NO&BCST_NO,"msg_lanmask") == false ) errflg = 1;
	if( !Sel_SubMask(get_full_ip(F,"lanmask"),F,"save") ) errflg = 1;
	if( !CHK_DHCP_RANGE(F) ) errflg = 1;
	if( !msg_chk_range(F.dhcp_lease.value,'dhcp_lease',LEASE_TIME_START,LEASE_TIME_TO,10,IS_FIELD,0,'msg_dhcp_lease')) errflg = 1;
	if ( errflg == 0 ) 
	{
		var waitflg=0;
		update_val2();
		F.vlan_selidx.value = F.vlan_id.selectedIndex;
		if ( obj.netmask != get_full_ip(F,"lanmask") )
		{
                        F.submit_button.value = "lan_reboot";
                        parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
                        parent.document.getElementById("hidden_bg").style.display="";
		}
		else if ( !valid_subnet(get_full_ip(F,"lanip"),get_full_ip(F,"lanmask"),obj.ipaddr) )
		{
			if ( get_full_ip(F,"lanip") != obj.ipaddr && document.location.href.indexOf(obj.ipaddr) != -1 ) 
				F.submit_button.value = "lan_reboot";
			else
				F.submit_button.value = "lan_changed_subnet";
			parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
			parent.document.getElementById("hidden_bg").style.display="";
		}
		else
		{
			//Only changed LAN IP
			if ( get_full_ip(F,"lanip") != obj.ipaddr && document.location.href.indexOf(obj.ipaddr) != -1 ) 
				F.submit_button.value = "lan_changed_ip";
			else
				F.submit_button.value = "lan";
			for(var i=1; i<=4; i++)
			{
				if ( eval("rstp_port"+i+"_enable") == "1" && eval("rstp_port"+i+"_edge") == "0" ) 
		                {
        		                window.parent.savebg_init();
                		        parent.document.getElementById("save_time_bg").style.display="";
					waitflg = 1;
					break;
				}
			}
		}
		if( waitflg == 0 ) 
		{
			parent.document.getElementById("save_bg").style.display="";
		}
		if ( F.submit_button.value != "lan" )
		{ 
			my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"lan_alert_result(1)","lan_alert_result(0)","","yesno");	
		}
		else
		{
			parent.document.getElementById("save_bg").style.display="";
			F.gui_action.value = "Apply";
			F.submit();
			if ( http_from == "wan" ) 
			{
				setTimeout("chk_st()", 15000);
			}	
		}
	}
}

function lan_alert_result(val){
	alert_result(0);
	var F = document.frmlan;
	if ( val == 1 ) 
	{
		parent.document.getElementById("hidden_bg").style.display="";
		F.gui_action.value = "Apply";
		F.submit();
	}else
	{
		parent.document.getElementById("hidden_bg").style.display="none";
		parent.document.getElementById("save_bg").style.display="none";
	}
}

function chg_dnsmode(F){

	var _name = new Array("dns0","dns1","dns2","wins");
	for(var i=0;i<_name.length;i++)
		clear_msg(_name[i]+"_0","msg_"+_name[i]);
	if ( (F._lan_proto[0].checked == true) && (F.lan_dns_mode.value == "3"))
		DISABLE_PART(F,"dnsmode_start","dhcp_end_area",0);
	else
		DISABLE_PART(F,"dnsmode_start","dhcp_end_area",1);
		
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmlan method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=lan_ipaddr>
<input type=hidden name=lan_netmask>
<input type=hidden name=lan_dhcp_dns>
<input type=hidden name=lan_dhcp_wins>
<input type=hidden name=lan_proto>
<input type=hidden name=kill_httpd>
<input type=hidden name=dhcprelay_ipaddr>
<input type=hidden name=vlan_selidx>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.lanconfig),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(lan.ipv4));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.vlan));</script>
		<script>
		var tmp = "<% nvram_get("vlan_group"); %>".replace(/\s*$/,"");
		var _name = tmp.split(" ");
		draw_object(O_GUI,SELBOX,"vlan_id","onChange=chg_vid(this.form)",_name,_name,obj.vlan_id);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.localipaddr));</script>
		<script>draw_object(O_GUI,IP,"lanip",obj.ipaddr);</script>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"192.168.1.1"));</script>
		<span id="msg_lanip"></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.mask));</script>
		<script>
		//var _name=new Array("255.255.255.0","255.255.255.128","255.255.255.192","255.255.255.224","255.255.255.240","255.255.255.248","255.255.255.252");
		//draw_object(O_GUI,SELBOX,"lan_netmask","onChange=Sel_SubMask(this.form.lan_netmask.value,this.form,'select')",_name,_name,obj.netmask);
		draw_object(O_GUI,IP,"lanmask",obj.netmask);
		document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));
		</script>
		<span id=msg_lanmask></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(lan.setdhcp),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(lan.dhcpserver));</script>
                <script>
		var _name=new Array(__T(share.enable),__T(share.disable),__T(lan.dhcprelay));
		var _val=new Array("dhcp","static","dhcprelay");
		draw_object(O_GUI,RADIO,"_lan_proto",_val,_name,obj.proto,"onclick=chg_server()");
		</script>
		</TD></TR>
		<input type=hidden name=dhcp_start_area>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.remotedhcp));</script>
		<script>draw_object(O_GUI,IP,"_dhcprelay_ipaddr",obj.dhcprelay_ip);</script>
		<span id=msg__dhcprelay_ipaddr></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.startip));</script>
		<script>
		document.write("<span id=show_sip></span><input size=3 maxlength=3 name=dhcp_start id=dhcp_start value="+obj.start_ip+" onblur=CHK_DHCP_RANGE(this.form)>");
		</script>
		<span id=msg_dhcp_start></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.maxdhcpusers));</script>
		<script>
		document.write("<input size=3 maxlength=3 name=dhcp_num id=dhcp_num value="+obj.user_num+" onblur=CHK_DHCP_RANGE(this.form)>");
		</script>
		<span id=msg_dhcp_num></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.ipaddrrange));</script>
		<SPAN id=DymRange></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.clienttime));</script>
		<script>
		document.write("<input size=10 maxlength=4 id=dhcp_lease name=dhcp_lease value="+obj.lease_time+" onblur=msg_chk_range(this.value,'dhcp_lease',LEASE_TIME_START,LEASE_TIME_TO,10,IS_FIELD,0,'msg_dhcp_lease');>&nbsp;&nbsp;");
		Capture(unit.minutes);
		document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"1","9999","1440"));
		</script>
		<span id=msg_dhcp_lease></span>
		</TD></TR>
		<!--Added DNS Mode Selection start-->
                <TR><script>
                        draw_td(O_GUI,SUBTITLE,__TC(lan.dns));
                        var _name= new Array(__T(lan.usednsproxy),__T(lan.usednsisp),__T(lan.usednsbelow));
                        var _val= new Array("0","1","3");
                        draw_object(O_GUI,SELBOX,"lan_dns_mode","onChange=chg_dnsmode(this.form)",_name,_val,obj.dnsmode);
                </script>
                <span id=_dns_mode></span>
                </TD></TR>
                <!--Added DNS Mode Selection end-->
		<input type=hidden name=dnsmode_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(spell_words(static_dns_rule,"1")));</script>
		<script>draw_object(O_GUI,IP,"dns0",obj.dns1);</script>
		<span id=msg_dns0></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(spell_words(static_dns_rule,"2")));</script>
		<script>draw_object(O_GUI,IP,"dns1",obj.dns2);</script>
		<span id=msg_dns1></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(spell_words(static_dns_rule,"3")));</script>
		<script>draw_object(O_GUI,IP,"dns2",obj.dns3);</script>
		<span id=msg_dns2></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.wins),SPACE_DOWN,SPACE_DOWN);</script>
		<script>draw_object(O_GUI,IP,"wins",obj.wins);</script>
		<span id=msg_wins></span>
		</TD></TR>
		<input type=hidden name=dhcp_end_area>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
