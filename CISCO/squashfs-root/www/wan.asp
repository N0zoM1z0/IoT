<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% load_nv("wan_hostname|wan_domain|wan_mtu|mtu_enable|wan_proto|ppp_idletime|ppp_redialperiod|ppp_demand|wan_ipaddr|wan_netmask|wan_gateway|wan_dns|ppp_username|pptp_server_ip|l2tp_server_ip|wan_isp_dns|ap_wan_proto|ap_mtu_enable|ap_wan_mtu|ap_wan_untag_vlan_enable|ap_wan_untag_vlan_id|ap_wan_mgt_vlan_id|ap_wan_ipaddr|ap_wan_netmask|ap_wan_gateway|ap_wan_dns|wan_dns_mode|wan_static_dns_mode|ap_wan_dns_mode|ap_wan_static_dns_mode"); %>
var now_proto="";

var vlan_group = "<% nvram_get("vlan_group"); %>";

if ( ('<% nvram_gozila_get("chg_flg"); %>' != '1') && ap_mode == "1" ){ 
	now_proto = nv_ap_wan_proto;
}else{
	now_proto = '<% nvram_gozila_get("wan_proto"); %>';
}
<% web_include_file("encode_data.js"); %>
if ( nv_pptp_server_ip == "") nv_pptp_server_ip = "0.0.0.0";
if ( nv_l2tp_server_ip == "") nv_l2tp_server_ip = "0.0.0.0";

if ( now_proto != "static" )
{
	if ( ap_mode == "1" )
		nv_wan_dns = "<% nvram_get("ap_wan_primary_dns"); %> <% nvram_get("ap_wan_secondary_dns"); %>";
	else
		nv_wan_dns = "<% nvram_get("wan_primary_dns"); %> <% nvram_get("wan_secondary_dns"); %>";
}
if ( nv_wan_dns == "" ) nv_wan_dns="0.0.0.0 0.0.0.0";

var nv_ppp_passwd = "";
if ( <% nvram_else_match("ppp_passwd","","0","1"); %> ) 
	nv_ppp_passwd = TMP_PASSWD;
var _proto_val = new Array("dhcp","static","pppoe","pptp","l2tp");
var tmp_proto;
var stflg="";
var change_canecl_bt="false";
var def_opendns1="208.67.222.222";
var def_opendns2="208.67.220.220";

if ( ap_mode == "1" ) 
{
	nv_mtu_enable = nv_ap_mtu_enable;
	nv_wan_mtu = nv_ap_wan_mtu;
}
//skip_name = new Array("wan_proto");
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
}
function get_default_mtu(wan_type)
{
	if ( wan_type == "pppoe" ) 
		return DEF_PPPOE_MTU;
	else if ( wan_type == "pptp" || wan_type == "l2tp") 
		return DEF_PPTP_MTU;
	else
		return DEF_DHCP_MTU;
}

var start_range=0;
var end_range=0;
var def_range= get_default_mtu(now_proto);
var F = document.frmwan;
if ( now_proto == "pppoe" ){
	start_range = PPPOE_MTU_START;
	end_range = PPPOE_MTU_TO;
}else if ( now_proto == "pptp" || now_proto == "l2tp"){
	start_range = PPTP_MTU_START;
	end_range = PPTP_MTU_TO;
	def_range = PPTP_MTU_TO;
}else{
	start_range = DHCP_MTU_START;
	end_range = DHCP_MTU_TO;
	def_range = DHCP_MTU_TO;
}

function valid_mtu(wan_type)
{
	var F = document.frmwan;
	if ( !msg_chk_range(F.wan_mtu.value,"wan_mtu",start_range,end_range,10,IS_FIELD,0,"_mtu") ) return false;	
	return true;
}
function chk_tag_id(F)
{
	if ( F._wantag_enable.checked == false ) return true;
	if ( !msg_chk_range(F.wantag_vid.value,"wantag_vid",2,4094,10,IS_FIELD,0,"_vid") ) return false;	
	var vlan_id = vlan_group.split(" ");
	for(var i=0; i<vlan_id.length; i++)
	{
		if ( F.wantag_vid.value == vlan_id[i] ) 
		{
			my_alert(O_VAR,"wantag_vid", __T(msg.videxist),"0","_vid");
			return false;
			
		}	
	}
	return true;
	
}

function chk_tag(F)
{
	if ( F._wantag_enable.checked == true ) 
		choose_enable(F.wantag_vid);
	else
		choose_disable(F.wantag_vid);
}

function init(){
	if ( http_power == "r" ) return;
	var F = document.frmwan;
	stflg="init";
	//INITIAL MTU
	if ( F.wan_mtu.value == "" || (F.wan_mtu.value > end_range) ) 
		F.wan_mtu.value = get_default_mtu(F.wan_proto[F.wan_proto.selectedIndex].value);
	CHG_MTUMode(F);
	tmp_proto = F.wan_proto.selectedIndex;
	<% support_invmatch("PPTP_SERVER_SUPPORT","1","/*"); %>
	if ( F.wan_proto[F.wan_proto.selectedIndex].value == "l2tp" )
		SEL_VER(F);
	<% support_invmatch("PPTP_SERVER_SUPPORT","1","*/"); %>
	if ( F.wan_proto[F.wan_proto.selectedIndex].value == "pptp" || 
             F.wan_proto[F.wan_proto.selectedIndex].value == "l2tp")
		chg_demand(F,parseInt(nv_ppp_demand,10));
        if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" || 
             F.wan_proto[F.wan_proto.selectedIndex].value == "pptp" || 
             F.wan_proto[F.wan_proto.selectedIndex].value == "l2tp")
		update_val2();
        if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" || 
             F.wan_proto[F.wan_proto.selectedIndex].value == "dhcp" || 
             F.wan_proto[F.wan_proto.selectedIndex].value == "pppoe")
		chk_tag(F);

	if ( ap_mode == "0" ) 
	{
		choose_disable(F.ap_wan_proto);
		choose_disable(F.ap_mtu_enable);
		choose_disable(F.ap_wan_mtu);
		choose_disable(F.ap_wan_untag_vlan_enable);
	}else
		chk_vlan(F);
	if ( F.wan_proto[F.wan_proto.selectedIndex].value != "pppoe" )
	{
	    if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" )
	    {
		if ( ap_mode == "1" )
	    		SelDNS(nv_ap_wan_static_dns_mode,F);
		else
		    	SelDNS(nv_wan_static_dns_mode,F);
	    }else{
		if ( ap_mode == "1" )
	    		SelDNS(nv_ap_wan_dns_mode,F);
		else
	    		SelDNS(nv_wan_dns_mode,F);
	    }
	}
	if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" ||
	     F.wan_proto[F.wan_proto.selectedIndex].value == "dhcp" )
		chk_tag(F);
	default_nv = keep_val(F,skip_name);
	parent.document.getElementById("save_bg").style.display="none";
}
function SelDNS(num,F){
	var def_dns1 = def_opendns1.split(".");
	var def_dns2 = def_opendns2.split(".");
	for(var i=0; i<4; i++)
	{
		//eval("F._dns1_"+i).value = "0";
		//eval("F._dns2_"+i).value = "0";
		choose_disable(eval("F._dns1_"+i));
		choose_disable(eval("F._dns2_"+i));
		if ( num == 1 ) //OPENDNS
		{
			eval("F._dns1_"+i).value = def_dns1[i];
			eval("F._dns2_"+i).value = def_dns2[i];
		}
		if ( num == 2 ) 
		{
			choose_enable(eval("F._dns1_"+i));
			choose_enable(eval("F._dns2_"+i));
		}
	}
}

function SelWAN(num,F){
        var wan_name=F.wan_proto.options[num].value;
	F.submit_button.value = "wan";
	F.change_action.value = "gozila_cgi";
	F.chg_flg.value = "1";
	F.wan_proto.value=wan_name;
	F.submit();
}

function CHG_CID(F){
	if ( F._l2tpv3_cisco[0].checked == true ) 
		choose_disable(F.l2tpv3_cisco_vcid);
	else
		choose_enable(F.l2tpv3_cisco_vcid);
}

function CHG_AUTH(F)
{
	if ( F._l2tpv3_auth[0].checked || F.l2tp_version[0].selected == true ) 
	{
		choose_enable(F.ppp_username);
		choose_enable(F._ppp_passwd);
	}else{
		choose_disable(F._ppp_passwd);
		choose_disable(F.ppp_username);
	}
} 

function SEL_VER(F){
	if ( F.l2tp_version[0].selected == true ) //2
	{
		choose_disable(F.l2tpv3_cookie_len);
		choose_disable(F._l2tpv3_cisco[0]);
		choose_disable(F._l2tpv3_cisco[1]);
		choose_disable(F.l2tpv3_cisco_vcid);
		choose_disable(F._l2tpv3_auth[0]);
		choose_disable(F._l2tpv3_auth[1]);
		choose_enable(F.ppp_auth);
		choose_enable(F._ppp_mppe);
	}
	else 
	{
		choose_enable(F.l2tpv3_cookie_len);
		choose_enable(F._l2tpv3_cisco[0]);
		choose_enable(F._l2tpv3_cisco[1]);
		choose_enable(F._l2tpv3_auth[0]);
		choose_enable(F._l2tpv3_auth[1]);
		choose_disable(F.ppp_auth);
		choose_disable(F._ppp_mppe);
		CHG_CID(F);
	}
	CHG_AUTH(F);
}

function CHG_MTUMode(F){
	if ( F.mtu_enable[0].checked ) //Auto
		choose_disable(F.wan_mtu);
	else
		choose_enable(F.wan_mtu);
}

function chk_hostname(obj)
{
	var errmsg = valid_hostname(obj);
	if ( errmsg != "" )
	{
		my_alert(O_VAR,"wan_hostname", errmsg,"0","_wan_hostname");
		return false;
	}
	return true;
}

function valid_value(F)
{
	var wan_type = F.wan_proto[F.wan_proto.selectedIndex].value;
	var errflg=0;
	if ( wan_type == "static" )
	{
                var _name2 = new Array("_ip","_mask","_gw","_dns1","_dns2");
	}
        else if ( wan_type == "pptp" )
	{
                var _name2 = new Array("_ip","_mask","_gw","_server");         
	}
	else if ( wan_type == "l2tp" )    
	{             
                var _name2 = new Array("_ip","_mask","_gw","_server");
        }
		
	//if ( wan_type == "pppoe" || 
	if ( wan_type == "pptp" || wan_type == "l2tp" ){
		if ( F.ppp_username.disabled == false && !chk_idpwd("ppp_username") ) errflg=1;
		if ( F._ppp_passwd.disabled == false && !chk_idpwd("_ppp_passwd") ) errflg=1;
	}
	<% support_invmatch("PPTP_SERVER_SUPPORT","1","/*"); %>
	if ( wan_type == "l2tp" ) 
	{
		if ( F.l2tp_version[1].selected == true ) //3
		{
			if ( F._l2tpv3_cisco[0].checked ) 
				F.l2tpv3_cisco.value = "0";
			else{
				F.l2tpv3_cisco.value = "9";
				if ( !msg_chk_range(F.l2tpv3_cisco_vcid.value,'l2tpv3_cisco_vcid',VIRTUAL_CID_START,VIRTUAL_CID_TO,10,IS_FIELD,0,'msg_l2tpv3_cisco_vcid')) errflg=1;
			}
			if ( F._l2tpv3_auth[0].checked )	
				F.l2tpv3_auth.value = "1";
			else
				F.l2tpv3_auth.value = "0";
		}
	}
	<% support_invmatch("PPTP_SERVER_SUPPORT","1","*/"); %>
	
	if ( wan_type == "static" || wan_type == "pptp" || wan_type == "l2tp" )
	{
		for(var i=0; i<_name2.length; i++)
		{
			
			parent.document.getElementById("obj_id").value = "msg"+_name2[i];
			if ( _name2[i].indexOf("dns") != -1 )
			{
			    if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE7,ZERO_OK,"msg"+_name2[i])) 
				errflg = 1;
				
			}
			else if ( _name2[i].indexOf("mask") != -1 )
			{
			    if ( my_valid_m_value("MASK",F,_name2[i],ZERO_NO|BCST_NO,"msg"+_name2[i]) == FAIL )
					errflg = 1;
			}
			else
			{
			    if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE7,ZERO_NO,"msg"+_name2[i])) 
				errflg = 1;
			}
		}
		if ( ap_mode == "0" ) 
		{
			var tmp_ip = "", tmp_mask="";
			for(var i=0; i<4; i++){
				if ( tmp_ip != "" ) tmp_ip+=".";
					tmp_ip += eval("F._ip_"+i).value;
				if ( tmp_mask != "" ) tmp_mask+=".";
					tmp_mask += eval("F._mask_"+i).value;
			}
			//Server IP cannot be the same with LAN subnet.
			if ( valid_subnet(tmp_ip,tmp_mask,F.lan_ipaddr.value) ){
				my_alert(O_VAR,"_ip",__T(msg.subnet1),"4","msg_ip");
				return false;
			}
			var vlan_arr=new Array();
				
			<% get_lan_data("vlan_arr"); %>
			for(var j=0; j<vlan_arr.length; j++)
			{
				if ( valid_subnet(tmp_ip,tmp_mask,vlan_arr[j].ipaddr) ){
					my_alert(O_VAR,"_ip",__T(msg.subnet11),"4","msg_ip");
					return false;
				}
			}
			// LAN IP cannot be the same with WAN IP
			if ( F.wan_ipaddr.value == F.lan_ipaddr.value ) 
			{
				my_alert(O_VAR,"_ip",__T(msg.subnet3),"4","msg_ip");
				return false;
			}
			// IP cannot be subnet ID or broadcast IP 
			document.getElementById("msg_ip").innerHTML = "";
			document.getElementById("msg_gw").innerHTML = "";
	                if ( !valid_ip_in_subnet(get_full_ip(F,"_ip"),get_full_ip(F,"_mask")) )
			{
				my_alert(O_VAR,"_ip",__T(msg.illegalipformat),"4","msg_ip");
				return false;
			}
        	        if ( !valid_ip_in_subnet(get_full_ip(F,"_gw"),get_full_ip(F,"_mask")) )
			{
				my_alert(O_VAR,"_gw",__T(msg.illegalipformat),"4","msg_gw");
				return false;
			}
		}
		if ( !valid_ip_gw(F,"F._ip","F._mask","F._gw") ){ 
			my_alert(O_VAR,"_ip",__T(msg.subnet2),"4","msg_ip");
			my_alert(O_VAR,"_gw",__T(msg.subnet2),"4","msg_gw");
			return false;
		}

	}
	//if (( wan_type == "pppoe")||( wan_type == "pptp")||( wan_type == "l2tp"))
	if (( wan_type == "pptp")||( wan_type == "l2tp"))
	{
		if (F.ppp_demand.value == 0)
		{
			if(!valid_ppp_redial(F.ppp_redialperiod,"ppp_redialperiod","_ppp_redialperiod"))
					errflg = 1;
		}
		else
		{
			if(!valid_ppp_idletime(F.ppp_idletime,"ppp_idletime","_ppp_idletime"))
					errflg = 1;
		}
	}
	if (( wan_type == "pptp")||( wan_type == "l2tp"))
	{
		if ( F._ppp_mppe.checked == true ) 
			F.ppp_mppe.value = 1;
		else
			F.ppp_mppe.value = 0;
	}
	if ( wan_type == "pppoe" )
	{
		if ( F._pppoe_select_profile.value == -1 ) 
		{
			my_alert(O_VAR,"_pppoe_select_profile",__T(wl.selprofile),"1","msg_pppoe_select_profile");
			return;
		}
		F.pppoe_select_profile.value = F._pppoe_select_profile.value;
	}else
		F.pppoe_select_profile.value = "";
	if ( wan_type != "pppoe" )
	{
		//if ( F._wan_isp_dns.checked == true ) F.wan_isp_dns.value = 1;
		//else F.wan_isp_dns.value = 0;
		if ( !my_valid_m_value("IP",F,"_dns1","",VALID_IP_RULE7,ZERO_OK,"msg_dns1")) 
			errflg = 1;
		if ( !my_valid_m_value("IP",F,"_dns2","",VALID_IP_RULE7,ZERO_OK,"msg_dns2")) 
			errflg = 1;
		if ( errflg != 1 ) 
		{
			if ( wan_type == "static" ) 
			{
                	        F.wan_dns.value = get_full_ip(F,"_dns1")+" "+get_full_ip(F,"_dns2");
			}else{
				F.wan_primary_dns.value = get_full_ip(F,"_dns1");
				F.wan_secondary_dns.value = get_full_ip(F,"_dns2");
				choose_enable(F.wan_primary_dns);
				choose_enable(F.wan_secondary_dns);
			}
		}
		
	}
	
//	if ( F.wan_hostname.value != "" && !chk_hostname(F.wan_hostname.value) ) errflg = 1;
//	if ( !is_check_domain(F.wan_domain.value) ) return false;
	if ( ap_mode == "1" ) 
	{
		if ( F._ap_wan_untag_vlan_enable.checked == true ) 
		{
			if ( !msg_chk_range(F.ap_wan_mgt_vlan_id.value,'ap_wan_mgt_vlan_id',1,VLAN_ID_TO,10,IS_FIELD,0,'msg_mgtid') ) 
				errflg = 1;
		}
		if ( !msg_chk_range(F.ap_wan_untag_vlan_id.value,'ap_wan_untag_vlan_id',1,VLAN_ID_TO,10,IS_FIELD,0,'msg_id') )    		      errflg = 1;
		
	}
	if ( wan_type == "static" || wan_type == "dhcp" ) 
	{
		if ( !chk_tag_id(F) ) return false;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function is_check_domain(val)
{
	clear_msg("wan_domain","_wan_domain");
	if ( val != "" && !check_domain(val) ) 
        {
                my_alert(O_VAR,"wan_domain",__T(msg.validname),"0","_wan_domain");
                return false;
                
        }
	return true;
}
function chk_idpwd(obj_name){
	var F = document.frmwan;
	document.getElementById(obj_name).style.backgroundColor="";
	document.getElementById("msg_"+obj_name).innerHTML = "";
	var return_msg = valid_meaning_id_name(MEANING_NAME,eval("F."+obj_name).value,ZERO_NO|SPACE_NO);
        if ( return_msg != "" ) 
        {
                if ( obj_name == "ppp_username" ) 
                        my_alert(O_VAR,"ppp_username",return_msg,"0","msg_ppp_username");
                else
                        my_alert(O_VAR,"_ppp_passwd",return_msg,"0","msg__ppp_passwd");
                return false;
        }
	if ( F.ppp_passwd.value != TMP_PASSWD )  
		F.ppp_passwd.value = encode_data(F._ppp_passwd.value); 
	return true;
}

function uiDoSave(F)
{
	var errflg = 0 ;
	F.submit_button.value = "wan";
	if ( !valid_value(F) ) errflg = 1 ; 
	if ( F.wan_proto[F.wan_proto.selectedIndex].value == "dhcp" ||
	     F.wan_proto[F.wan_proto.selectedIndex].value == "pppoe" ||
	     F.wan_proto[F.wan_proto.selectedIndex].value == "static" )
	{
		if ( F._wantag_enable.checked == true ) 
			F.wantag_enable.value = 1;
		else
			F.wantag_enable.value = 0;
	}
	if ( F.mtu_enable[1].checked ) 
	{
		if ( !valid_mtu(F.wan_proto[F.wan_proto.selectedIndex].value)) errflg = 1 ; 
		if ( ap_mode == "1" ) 
			F.ap_mtu_enable.value = 1;
	}
	if ( ap_mode == "1" ) 
	{
		F.ap_wan_proto.value = F.wan_proto.value;
		F.ap_wan_mtu.value = F.wan_mtu.value;
		F.ap_wan_untag_vlan_enable.value = 0;
		if ( F._ap_wan_untag_vlan_enable.checked == true ) 
			F.ap_wan_untag_vlan_enable.value = 1;
		choose_disable(F.wan_proto);
		choose_disable(F.mtu_enable);
		choose_disable(F.wan_mtu);
	       	if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" )
		{
			choose_enable(F.ap_wan_dns);
			choose_disable(F.wan_dns);
			F.ap_wan_static_dns_mode.value = F.wan_static_dns_mode.value;
			choose_enable(F.ap_wan_static_dns_mode);
			choose_disable(F.wan_static_dns_mode);
		}else{
			F.ap_wan_dns_mode.value = F.wan_dns_mode.value; 
			choose_enable(F.ap_wan_dns_mode);
			choose_disable(F.wan_dns_mode);
			F.ap_wan_primary_dns.value = F.wan_primary_dns.value;
			F.ap_wan_secondary_dns.value = F.wan_secondary_dns.value;
			choose_enable(F.ap_wan_primary_dns);
			choose_enable(F.ap_wan_secondary_dns);
			choose_disable(F.wan_primary_dns);
			choose_disable(F.wan_secondary_dns);
		}
	}
	if ( errflg == 1 ) return false;
	update_val2();
	F.submit_button.value = "wan";
	F.gui_action.value = "Apply";
	F.chg_flg.value = "0";
	//alert("primary="+F.wan_primary_dns.value+";secondary="+F.wan_secondary_dns.value+";wan_dns="+F.wan_dns.value);
	F.submit();	
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("wan.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

//function valid_ppp_redial(obj,obj_id,span_id,obj1,obj2){
function valid_ppp_redial(obj,obj_id,span_id){
	//clear_msg(ppp_idletime,span_id);
	if(!msg_chk_range(obj.value,obj_id,PPP_REDIALPERIOD_START,PPP_REDIALPERIOD_TO,10,IS_FIELD,0,span_id))
		return false;
	return true;
}

//function valid_ppp_idletime(obj,obj_id,span_id,obj1,obj2){ 
function valid_ppp_idletime(obj,obj_id,span_id){ 

	if(!msg_chk_range(obj.value,obj_id,PPP_IDLETIME_START,PPP_IDLETIME_TO,10,IS_FIELD,0,span_id))
		return false;
	return true;
}

function chg_demand(F,r1)
{
	clear_msg("ppp_redialperiod","_ppp_redialperiod");
	clear_msg("ppp_idletime","_ppp_idletime");
	if ( r1 == 0 ){
		choose_disable(F.ppp_idletime);
		choose_enable(F.ppp_redialperiod);
		F.ppp_demand.value=0;
                valid_ppp_redial(F.ppp_redialperiod,"ppp_redialperiod","_ppp_redialperiod")

	}else{
		choose_enable(F.ppp_idletime);
		choose_disable(F.ppp_redialperiod);
		F.ppp_demand.value=1;
		valid_ppp_idletime(F.ppp_idletime,"ppp_idletime","_ppp_idletime")
	}
}
var keep_ip_type="";
function update_val(obj)
{
	var F = document.frmwan;
	var returnflg=0;
        if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" ){
        	var _name2 = new Array("_ip","_mask","_gw","_dns1","_dns2");
	}else if ( F.wan_proto[F.wan_proto.selectedIndex].value == "pptp" ){
        	var _name2 = new Array("_ip","_mask","_gw","_server","_dns1","_dns2");
	}else if ( F.wan_proto[F.wan_proto.selectedIndex].value == "l2tp" ){
        	var _name2 = new Array("_ip","_mask","_gw","_server");
	}
	if ( !msg_chk_range(document.getElementById(obj).value,obj,0,255,10,IS_FIELD,0,"msg_"+obj.split("_")[1] ) )
	{
		return;
	}
	if ( keep_ip_type != "" && (obj.indexOf(keep_ip_type) != -1) ) 
	{
		keep_ip_type = obj.split("_")[1];
		return ;
	}
	if ( keep_ip_type == "" ) 
	{
		keep_ip_type = obj.split("_")[1];
		return;
	}
	//alert("]before_chk:obj=["+obj+"]\nvalue=["+document.getElementById(obj).value+"]\nmsg=[msg_"+keep_ip_type+"]\n"+obj.split("_")[2]);
	if ( keep_ip_type.indexOf("mask") != -1 ) 
	{
		if ( keep_ip_type != "" )
		{
			if ( my_valid_m_value("MASK",F,"_mask",ZERO_NO|BCST_NO,"msg_mask") == FAIL )
				errflg = 1;
			else
				document.getElementById("msg_mask").innerHTML = "";
		}
	}else if ( keep_ip_type.indexOf("dns") != -1 )
	{
		if ( keep_ip_type.indexOf("dns1") != -1 ) 
		{
			if ( keep_ip_type != "" )
			{
				if ( !my_valid_m_value("IP",F,"_dns1","",VALID_IP_RULE7,ZERO_OK,"msg_dns1")) 
					errflg = 1 ; 
				else
					document.getElementById("msg_dns1").innerHTML = "";
			}
		}else{
			if ( keep_ip_type != "" )
			{
				if ( !my_valid_m_value("IP",F,"_dns2","",VALID_IP_RULE7,ZERO_OK,"msg_dns2")) 
					errflg = 1 ;
				else 
					document.getElementById("msg_dns2").innerHTML = "";
			}
		}
	}
	else 
	{
		if ( keep_ip_type.indexOf("gw") != -1 ) 
		{
			if ( keep_ip_type != "" )
			{
				if ( !my_valid_m_value("IP",F,"_gw","",VALID_IP_RULE7,ZERO_NO,"msg_gw")) 
					errflg = 1 ; 
				else
					document.getElementById("msg_gw").innerHTML = "";
			}
		}else if ( keep_ip_type.indexOf("server") != -1 ) 
		{
			if ( keep_ip_type != "" )
			{
				if ( !my_valid_m_value("IP",F,"_server","",VALID_IP_RULE7,ZERO_NO,"msg_server")) 
					errflg = 1 ; 
				else
					document.getElementById("msg_server").innerHTML = "";
			}
		}else{
			if ( keep_ip_type != "" )
			{
				if ( !my_valid_m_value("IP",F,"_ip","",VALID_IP_RULE7,ZERO_NO,"msg_ip")) 
					errflg = 1 ;
				else
					document.getElementById("msg_ip").innerHTML = "";
			}
		}
	}
	keep_ip_type = obj.split("_")[1];
}

function update_val2()
{
	var F = document.frmwan;
        if ( F.wan_proto[F.wan_proto.selectedIndex].value == "static" ){
		var _name = new Array("wan_ipaddr","wan_netmask","wan_gateway","wan_dns","ap_wan_dns");
        	var _name2 = new Array("_ip","_mask","_gw","_dns1","_dns2");
	}else if ( F.wan_proto[F.wan_proto.selectedIndex].value == "pptp" ){
	        var _name = new Array("wan_ipaddr","wan_netmask","wan_gateway","pptp_server_ip");
        	var _name2 = new Array("_ip","_mask","_gw","_server","_dns1","_dns2");
	}else if ( F.wan_proto[F.wan_proto.selectedIndex].value == "l2tp" ){
	        var _name = new Array("wan_ipaddr","wan_netmask","wan_gateway","l2tp_server_ip");
        	var _name2 = new Array("_ip","_mask","_gw","_server","_dns1","_dns2");
	}
	else return;
        var tmp="";
	var errflg=0;
	for(var i=0; i<_name2.length; i++)
        {
		for(var j=0; j<4; j++)
			document.getElementById(_name2[i]+"_"+j).style.backgroundColor="";

		if ( document.getElementById("msg"+_name2[i]) != null ) 
			document.getElementById("msg"+_name2[i]).innerHTML = "";

		if ( stflg != "init" ){
			if ( _name2[i].indexOf("mask") != -1 )
			{
				if ( my_valid_m_value("MASK",F,_name2[i],ZERO_NO|BCST_NO,"msg"+_name2[i]) == FAIL )
					errflg = 1;
			}else if ( _name2[i].indexOf("dns") != -1 )
			{
				if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE7,ZERO_OK,"msg"+_name2[i])) 
					errflg = 1 ; 
			}
			else 
			{
				if ( !my_valid_m_value("IP",F,_name2[i],"",VALID_IP_RULE7,ZERO_NO,"msg"+_name2[i])) 
					errflg = 1 ; 
			}
			if ( errflg == 1 ) return; 
		}
		if ( typeof _name[i] == "undefined" ) 
		{
			stflg="uppdate";
			return;
		}
                if ( _name[i].indexOf("wan_dns") != -1 ) 
                {
                        tmp = get_full_ip(F,"_dns1")+" "+get_full_ip(F,"_dns2");
			//if ( tmp == "0.0.0.0 0.0.0.0") tmp = "";
                        eval("F."+_name[i]).value = tmp;                 
		}else{
                        eval("F."+_name[i]).value = get_full_ip(F,_name2[i]);
                }
	}
	stflg="uppdate";
}

function redirect_url()
{
	change_cancel_bt="true";
	get_position("pppoe_profile.asp");
}

/*
function chk_isp(F)
{
	if ( F._wan_isp_dns.checked == false ) 
	{
		for(var i=0; i<4; i++)
		{
			choose_enable(eval("F._dns1_"+i));
			choose_enable(eval("F._dns2_"+i));
		}
	}else{
		for(var i=0; i<4; i++)
		{
			choose_disable(eval("F._dns1_"+i));
			choose_disable(eval("F._dns2_"+i));
		}
	}
}*/

function chk_vlan(F)
{
	if ( F._ap_wan_untag_vlan_enable.checked == true ) 
	{
		choose_enable(F.ap_wan_untag_vlan_id);	
	}
	else
	{
		choose_disable(F.ap_wan_untag_vlan_id);	
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmwan method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=ppp_passwd>
<input type=hidden name=gui_action>
<input type=hidden name=pppoe_select_profile>
<input type=hidden name=wait_time value=20>
<input type=hidden name=ap_wan_proto>
<input type=hidden name=ap_mtu_enable value=0>
<input type=hidden name=ap_wan_untag_vlan_enable>
<input type=hidden name=ap_wan_mtu>
<input type=hidden name=ap_wan_ipaddr disabled>
<input type=hidden name=ap_wan_netmask disabled>
<input type=hidden name=ap_wan_gateway disabled>
<input type=hidden name=ap_wan_dns disabled>
<input type=hidden name=ap_wan_dns_mode disabled>
<input type=hidden name=ap_wan_static_dns_mode disabled>
<input type=hidden name=wan_primary_dns disabled>
<input type=hidden name=wan_secondary_dns disabled>
<input type=hidden name=ap_wan_primary_dns disabled>
<input type=hidden name=ap_wan_secondary_dns disabled>
<input type=hidden name=chg_flg>
<input type=hidden name=wantag_enable>
<input type=hidden name=lan_ipaddr value="<% nvram_get("lan_ipaddr"); %>">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.wanconfig),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.interconntype));</script>
		<script>
		if ( ap_mode != "1" ) 
		{
			var _name = new Array(__T(wan.dhcp),__T(wan.staticip),__T(wan.pppoe),__T(wan.pptp),__T(wan.l2tp));
			var _val = new Array("dhcp","static","pppoe","pptp","l2tp");
		}else{
			var _name = new Array(__T(wan.dhcp),__T(wan.staticip));
			var _val = new Array("dhcp","static");
		}
		draw_object(O_GUI,SELBOX,"wan_proto","onChange=SelWAN(this.form.wan_proto.selectedIndex,this.form)",_name,_val,now_proto);</script>
		</script>
                </TD></TR>
		<TR id=hr style=display:none><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR style=display:none><script>draw_td(O_GUI,FUNTITLE,__T(wan.sipset),"colspan=2");</script></TR>
		<% show_index_setting(); %>
		<script>
		var data = new Array();
		<% get_pppoe_data("data"); %>
		if ( now_proto=="pppoe" ) 
		{
			document.write("<TR>"+draw_td(O_VAR,SUBTITLE,__TC(wan.pppoepname)));
			var _name = new Array();
			var _val = new Array();
			_name[0] = __T(wan.pppoeselname);
			_val[0] = -1;
			for(var i=0; i<data.length; i++)
			{
				_name[i+1] = data[i][0];
				_val[i+1] = i;
			}
			draw_object(O_GUI,SELBOX,"_pppoe_select_profile","",_name,_val,"<% nvram_get("pppoe_select_profile"); %>"==""?'-1':'<% nvram_get("pppoe_select_profile"); %>');
			document.write("&nbsp;&nbsp;");
                	draw_object(O_GUI,BT,__T(wan.configfile),"t1","BT","redirect_url()");
				
			document.write("<span id=msg_pppoe_select_profile></span></TD></TR>");
			
		}
		else if ( now_proto=="pptp" || now_proto=="l2tp")
		{
			var titlename=new Array(__T(share.username),__T(share.password));
			var _val = new Array("user","pwd");
			var def_val = new Array(PPP_USER_NAME_MAX_LEN,PPP_USER_PWD_MAX_LEN);
			var _name = new Array("ppp_username","ppp_passwd");
			var _type = new Array("text","password");
			for(var i=0; i<_name.length; i++)
			{
			        document.write("<TR>");
			        draw_td(O_GUI,SUBTITLE,titlename[i]+":");
				if ( i == 1 ) 
				{
				        document.write("<input type="+_type[i]+" size=20 maxlength="+def_val[i]+" name='_"+_name[i]+"' id='_"+_name[i]+"' value='"+eval("nv_"+_name[i])+"' onblur=chk_idpwd('_"+_name[i]+"')>");           		
					document.write("<SPAN id=msg__"+_name[i]+"></SPAN></TD></TR>");
				}
				else
				{
				        document.write("<input type="+_type[i]+" size=20 maxlength="+def_val[i]+" name='"+_name[i]+"' id='"+_name[i]+"' value='"+eval("nv_"+_name[i])+"' onblur=chk_idpwd('"+_name[i]+"')>");           
					document.write("<SPAN id=msg_"+_name[i]+"></SPAN></TD></TR>");
				}
			}	
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE_M,"colspan=2");
			var selflg1="",selflg2="";
			if ( nv_ppp_demand == 1 ) selflg1="checked";
			else selflg2="checked";
			document.write("<input type=radio "+selflg1+" name=_ppp_demand value=1 onClick=chg_demand(this.form,1)>"+spell_words(connect_on_demand_rule,"<input id=ppp_idletime size=5 maxlength=4 name=ppp_idletime value="+nv_ppp_idletime+" onblur=valid_ppp_idletime(this,\"ppp_idletime\",\"_ppp_idletime\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"1","9999","5"));
			document.write("<SPAN id=_ppp_idletime></SPAN></TD></TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE_M,"colspan=2");
			document.write("<input type=radio "+selflg2+" name=_ppp_demand value=0 onClick=chg_demand(this.form,0)>"+spell_words(keep_alive_rule,"<input id=ppp_redialperiod size=5 maxlength=3 name=ppp_redialperiod value="+nv_ppp_redialperiod+" onblur=valid_ppp_redial(this,\"ppp_redialperiod\",\"_ppp_redialperiod\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"20","180","30"));
			document.write("<SPAN id=_ppp_redialperiod></SPAN></TD></TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__T(wan.authtype)+":");
			var _name = new Array(__T(wan.autonegotiation),__T(wan.pap),__T(wan.chap),__T(wan.mschap),__T(wan.mschap2));
			var _val = new Array("ISRANGE","0","4","1");
			draw_object(O_GUI,SELBOX,"ppp_auth","",_name,_val,"<% nvram_get("ppp_auth"); %>");
		}
		if ( now_proto=="pptp" || now_proto=="l2tp")
		{
			var nv_ppp_service="<% nvram_get("ppp_service");%>";
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(filter.servicename));
			document.write("<input type=text size=20 maxlength=63 name='ppp_service' id='ppp_service' value='"+nv_ppp_service+"'>");           		
			document.write("<SPAN id=msg_service_name></SPAN></TD></TR>");
			document.write("<TR>"+draw_td(O_VAR,SUBTITLE,__TC(vpn.mppeencry)));
                	document.write("<input type=checkbox name=_ppp_mppe <% nvram_match("ppp_mppe","1","checked");%>>");
			document.write(__T(share.enable)+"</TD></TR>");
		}
		if ( now_proto=="dhcp" || now_proto=="pptp" || now_proto=="l2tp" )
		{
			document.write("<TR>"+draw_td(O_VAR,ISHR,"colspan=2;")+"</TR>");
			//document.write("<TR>"+draw_td(O_VAR,FUNTITLE,__T(lan.dhcpsettings))+"</TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(lan.dnssource));
			var _name = new Array(__T(lan.getdnsisp),__T(lan.useopendns),__T(lan.usethesedns));
			var _val = new Array(0,1,2);
			if ( ap_mode == "1" ) 
				var dnsmode = "<% nvram_get("ap_wan_dns_mode"); %>";
			else
				var dnsmode = "<% nvram_get("wan_dns_mode"); %>";
			draw_object(O_GUI,SELBOX,"wan_dns_mode","onChange=SelDNS(this.form.wan_dns_mode.selectedIndex,this.form)",_name,_val,dnsmode);
			document.write("</TD></TR>");
			document.write("<TR>");
			var _nv_wan_dns = nv_wan_dns.split(" ");
			draw_td(O_GUI,SUBTITLE,__TC(lan.pridns));
			draw_object(O_GUI,IP,"_dns1",_nv_wan_dns[0],"disabled");
			document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));
			document.write("<SPAN id='msg_dns1'></SPAN></TD></TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(lan.secdns));
			draw_object(O_GUI,IP,"_dns2",_nv_wan_dns[1],"disabled");
			document.write("<SPAN id='msg_dns2'></SPAN></TD></TR>");
		}
		</script>
		<!-- optional settings start -->
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script>
		
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wan.optionset),"colspan=2;");</script></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.hostname),"","");
		document.write("<input size=20 id=wan_hostname name=wan_hostname maxlength="+HOSTNAME_MAX_LEN+" value='"+nv_wan_hostname+"'>");
		</script>
		<SPAN id=_wan_hostname></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.domainname));
		document.write("<input size=20 id=wan_domain name=wan_domain maxlength="+DOMAINNAME_MAX_LEN+" value='"+nv_wan_domain+"' onblur=is_check_domain(this.value)>");
		</script>
		<SPAN id=_wan_domain></SPAN></TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wan.mtu));</script>
		<script>
		var _name= new Array(__T(share.auto),__T(share.manual));
		var _val = new Array("0","1");
		draw_object(O_GUI,RADIO,"mtu_enable",_val,_name,nv_mtu_enable,"id=mtu_enable onclick=CHG_MTUMode(this.form)");</script>
		</script>
		</TD></TR>
		<TR><script>
		if ( now_proto=="dhcp" || now_proto=="static" )
			draw_td(O_GUI,SUBTITLE,__TC(share.size));
		else	
			draw_td(O_GUI,SUBTITLE,__TC(share.size),SPACE_DOWN,SPACE_DOWN);
		document.write("<input size=20 name=wan_mtu id=wan_mtu maxlength=4 value='"+nv_wan_mtu+"' onblur=valid_mtu(this.value)>&nbsp;&nbsp;"+__T(share.bytes2)+"&nbsp;"+spell_words(range_def_rule,start_range,end_range,def_range));
		</script>
		<SPAN id=_mtu></SPAN>
		</TD></TR>
		<script>
		if ( now_proto=="dhcp" || now_proto=="static" || now_proto=="pppoe" )
		{
			document.write("<TR>");
			draw_td(O_GUI,ISHR,"colspan=2;");
			document.write("<TR>");
			draw_td(O_GUI,FUNTITLE,__T(wan.tagoptionset),"colspan=2;");
			document.write("</TR><TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wan.tag));
			document.write("<input type=checkbox name=_wantag_enable onclick=chk_tag(this.form) <% nvram_match("wantag_enable", "1", "checked"); %>>");
			document.write("</TD></TR><TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wan.tagid),SPACE_DOWN,SPACE_DOWN);
			document.write("<input size=20 maxlength=4 name=wantag_vid value='<% nvram_get("wantag_vid"); %>' onblur=chk_tag_id(this.form)>");
			document.write("<SPAN id=_vid></SPAN></TD></TR>");
		}
		if ( ap_mode == "1" ) 
		{
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(lan.untagvlan));
			document.write("<input type=checkbox name=_ap_wan_untag_vlan_enable onclick=chk_vlan(this.form)");
			if ( nv_ap_wan_untag_vlan_enable == true ) document.write(" checked "); 
			document.write(">"+__T(share.enable)+"</TD></TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(lan.untagvlanid),"");	
			document.write("<input size=20 name=ap_wan_untag_vlan_id id=ap_wan_untag_vlan_id maxlength=4 value='"+nv_ap_wan_untag_vlan_id+"' disabled onblur=msg_chk_range(this.value,'ap_wan_untag_vlan_id',1,VLAN_ID_TO,10,IS_FIELD,0,'msg_id')>&nbsp;&nbsp;"+spell_words(range_def_rule,1,VLAN_ID_TO,1));
			document.write("<span id=msg_id></span></TD></TR><TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wl.apvlan),"style='padding-bottom:10px'","style='padding-bottom:10px'");				
			document.write("<input size=20 name=ap_wan_mgt_vlan_id id=ap_wan_mgt_vlan_id maxlength=4 value='"+nv_ap_wan_mgt_vlan_id+"' onblur=msg_chk_range(this.value,'ap_wan_mgt_vlan_id',1,VLAN_ID_TO,10,IS_FIELD,0,'msg_mgtid')>&nbsp;&nbsp;"+spell_words(range_def_rule,1,VLAN_ID_TO,1));
			document.write("<span id=msg_mgtid></span></TD></TR>");
			
		}
		</script>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
