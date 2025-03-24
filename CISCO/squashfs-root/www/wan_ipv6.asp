<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var nv_statefule = "<% nvram_get("wan_ipv6_stateful"); %>";
if ( ap_mode == "1" ) 
	var now_proto="<% nvram_get("ap_wan_ipv6_proto"); %>";
else
	var now_proto="<% nvram_get("wan_ipv6_proto"); %>";
var ipv4_wan_proto="<% nvram_get("wan_proto"); %>";
var nv_pppoe_addr_mode= "<% nvram_get("ipv6_pppoe_addr_mode"); %>";
var nv_wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>";
<% load_nv("wan_hostname|wan_domain|wan_mtu|mtu_enable|wan_proto|ppp_idletime|ppp_redialperiod|ppp_demand|wan_ipaddr|wan_netmask|wan_gateway|wan_dns|ppp_username"); %>
<% web_include_file("encode_data.js"); %>
var nv_ppp_passwd = "";

var start_range=0;
var end_range=0;
var def_range= DEF_PPPOE_MTU;
start_range = ROUTER_ADV_MTU_START;
end_range = PPPOE_MTU_TO;

if ( <% nvram_else_match("ppp_passwd","","0","1"); %> ) 
	nv_ppp_passwd = TMP_PASSWD;

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.wan_v6;
	if(nv_pppoe_addr_mode == "dhcp")
		F.ipv6_pppoe_addr_mode[0].checked=true;
	else
		F.ipv6_pppoe_addr_mode[0].checked=false;
	SelType(now_proto,F);
	if ( ap_mode == "1" && (F.wan_ipv6_proto[F.wan_ipv6_proto.selectedIndex].value == "static") )
	{
		F.wan_ipv6_ipaddr.value = "<% nvram_get("ap_wan_ipv6_ipaddr"); %>";
		F.wan_ipv6_prefixlen.value = "<% nvram_get("ap_wan_ipv6_prefixlen"); %>";
		F.wan_ipv6_gateway.value = "<% nvram_get("ap_wan_ipv6_gateway"); %>";
		F.wan_ipv6_dns_primary.value = "<% nvram_get("ap_wan_ipv6_dns_primary"); %>";
		F.wan_ipv6_dns_secondary.value = "<% nvram_get("ap_wan_ipv6_dns_secondary"); %>";
	}
	default_nv = keep_val(F,"");
}

function SelType(num,F)
{
	document.getElementById("trdhcp").style.display="none";
	if ( ap_mode == "0" && num == "dhcp" ) document.getElementById("trdhcp").style.display= "";
	if ( num == "dhcp" || num == "slaac" ) 
	{
		document.getElementById("space_row").className="SUBTITLE_TAIL";
		document.getElementById("space_row2").className="SUBITEM_TAIL";
		HIDDEN_PART("TR","static_start","static_end",1);
		HIDDEN_PART("TR","hr","static_end",1);
		//HIDDEN_PART(F,"dhcp_start","dhcp_end",0);
	}else if( num== "static" ){
		document.getElementById("space_row").className="SUBTITLE";
		document.getElementById("space_row2").className="SUBITEM";
		HIDDEN_PART("TR","hr","static_start",1);
		HIDDEN_PART("TR","static_start","static_end",0);
		DISABLE_PART(F,"wan_ipv6_ipaddr","wan_ipv6_dns_secondary",0);
	}
	else {
		document.getElementById("space_row").className="SUBTITLE";
		document.getElementById("space_row2").className="SUBITEM";
		//alert("nv_wan_ip_mode="+nv_wan_ip_mode+";ipv4_wan_proto="+ipv4_wan_proto);
		if( nv_wan_ip_mode != "2" && ipv4_wan_proto != "pppoe" ) {
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(ipv6.pppoewarnmsg),"wan_alert_result(1)","wan_alert_result(0)","","yesno");	
		}
		if ( parseInt(F.wan_mtu.value,10) > PPPOE_MTU_TO )
			F.wan_mtu.value = PPPOE_MTU_TO ; 
		//HIDDEN_PART("TR","hr","static_start",0);
		HIDDEN_PART("TR","hr","pppoe_addr_mode",0);
		HIDDEN_PART("TR","static_start2","static_end",0);
		if ( nv_wan_ip_mode != "2" ) 
			DISABLE_PART(F,"ppp_demand","ppp_mtu",1);
		chg_AddrMode(F);
		CHG_MTUMode(F);
		//HIDDEN_PART("TR","static_start2","static_end",0);
	}
}

function wan_alert_result(val)
{
	alert_result(0);
	if ( val == 1 ){ 
		get_position("wan.asp");
	}
}

function chg_AddrMode(F){
	if(F.ipv6_pppoe_addr_mode[0].checked == true)
	{
		DISABLE_PART(F,"wan_ipv6_ipaddr","wan_ipv6_dns_secondary",1);
	}
	else
	{
		DISABLE_PART(F,"wan_ipv6_ipaddr","wan_ipv6_dns_secondary",0);
	}
}


function before_check(F)
{
	var errflg = 0;
	var errmsg = "";
	clear_msg("wan_ipv6_ipaddr","msg_ip");
	
	errmsg = valid_ipv6(F.wan_ipv6_ipaddr.value);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,"wan_ipv6_ipaddr", errmsg,"0","msg_ip");
		errflg++;
	}
	if ( check_ipv6_subnet(F.wan_ipv6_ipaddr.value,F.wan_ipv6_prefixlen.value,"<% nvram_get("lan_ipv6_ipaddr"); %>") )
	{
		my_alert(O_VAR,"wan_ipv6_ipaddr",__T(msg.subnet10),"0","msg_ip");
		return false;
	}
	clear_msg("wan_ipv6_gateway","msg_gw");
	errmsg = valid_ipv6(F.wan_ipv6_gateway.value);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,"wan_ipv6_gateway", errmsg,"0","msg_gw");
		errflg++;
	}
	if ( F.wan_ipv6_dns_primary.value != "" ) 
	{
		clear_msg("wan_ipv6_dns_primary","msg_dns1");
		errmsg = valid_ipv6(F.wan_ipv6_dns_primary.value);
		if ( errmsg != "" ) 
		{
			my_alert(O_VAR,"wan_ipv6_dns_primary", errmsg,"0","msg_dns1");
			errflg++;
		}
	}
	if ( F.wan_ipv6_dns_secondary.value != "" ) 
	{
		clear_msg("wan_ipv6_dns_secondary","msg_dns2");
		errmsg = valid_ipv6(F.wan_ipv6_dns_secondary.value);
		if ( errmsg != "" ) 
		{
			my_alert(O_VAR,"wan_ipv6_dns_secondary", errmsg,"0","msg_dns2");
			errflg++;
		}
	}
	if ( !msg_chk_range(F.wan_ipv6_prefixlen.value,"wan_ipv6_prefixlen",IPV6_PREFIX_LEN_START,IPV6_PREFIX_LEN_TO,10,IS_FIELD,0,"_prefix") ) errflg =1;
	if ( errflg > 0 ) return false;
	return true;
	
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("wan_ipv6.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F){
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	if ( (F.wan_ipv6_proto[F.wan_ipv6_proto.selectedIndex].value == "static") && !before_check(F) ) 
		return;
	else if ( (F.ipv6_pppoe_addr_mode[1].checked == true) && !before_check(F))
		return;
	var errflg=0;
        if ( F.wan_ipv6_proto[F.wan_ipv6_proto.selectedIndex].value == "pppoe" && nv_wan_ip_mode == "2" ) 
        {
                var _name2 = new Array("_ip","_mask","_gw","_server");         
                if ( F.ppp_username.disabled == false && !chk_idpwd("ppp_username") ) errflg=1;
                if ( F._ppp_passwd.disabled == false && !chk_idpwd("_ppp_passwd") ) errflg=1;
                if (F.ppp_demand.value == 0)
                {
                        if(!valid_ppp_redial(F.ppp_redialperiod.value,"ppp_redialperiod","_ppp_redialperiod"))
                                        errflg = 1;
                }
                else
                {
                        if(!valid_ppp_idletime(F.ppp_idletime.value,"ppp_idletime","_ppp_idletime"))
                                        errflg = 1;
                }
		if ( F.mtu_enable[1].checked ) 
	        {
        	        if ( !valid_mtu("pppoe") ) errflg = 1 ; 
	        }
         	if ( errflg != 0 ) return;       
        }else
		choose_disable(F.ppp_passwd);

	if ( ap_mode == "1" )
	{
		F.ap_wan_ipv6_proto.value = F.wan_ipv6_proto.value;
		choose_enable(F.ap_wan_ipv6_proto);
		choose_disable(F.wan_ipv6_proto);
		if (F.wan_ipv6_proto[F.wan_ipv6_proto.selectedIndex].value == "static") 
		{
			F.ap_wan_ipv6_ipaddr.value = F.wan_ipv6_ipaddr.value;
			F.ap_wan_ipv6_prefixlen.value = F.wan_ipv6_prefixlen.value;
			F.ap_wan_ipv6_gateway.value = F.wan_ipv6_gateway.value;
			F.ap_wan_ipv6_dns_primary.value = F.wan_ipv6_dns_primary.value;
			F.ap_wan_ipv6_dns_secondary.value = F.wan_ipv6_dns_secondary.value;
			choose_enable(F.ap_wan_ipv6_ipaddr);
			choose_enable(F.ap_wan_ipv6_prefixlen);
			choose_enable(F.ap_wan_ipv6_gateway);
			choose_enable(F.ap_wan_ipv6_dns_primary);
			choose_enable(F.ap_wan_ipv6_dns_secondary);
			choose_disable(F.wan_ipv6_ipaddr);
			choose_disable(F.wan_ipv6_prefixlen);
			choose_disable(F.wan_ipv6_gateway);
			choose_disable(F.wan_ipv6_dns_primary);
			choose_disable(F.wan_ipv6_dns_secondary);
		}
	}
	F.submit_button.value="wan_ipv6";
	F.gui_action.value="Apply";
	F.submit();
	var waitflg=0;
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
        if( waitflg == 0 )
		parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function chk_idpwd(obj_name){
        var F = document.wan_v6;
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

function valid_ppp_idletime(obj,obj_id,span_id){ 

        clear_msg(obj_id,span_id);
        if(!msg_chk_range(obj,"ppp_idletime",PPP_IDLETIME_START,PPP_IDLETIME_TO,10,IS_FIELD,0,span_id))
        {
                return false;
        }
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
                valid_ppp_redial(F.ppp_redialperiod.value,"ppp_redialperiod","_ppp_redialperiod")

	}else{
		choose_enable(F.ppp_idletime);
		choose_disable(F.ppp_redialperiod);
		F.ppp_demand.value=1;
		valid_ppp_idletime(F.ppp_idletime.value,"ppp_idletime","_ppp_idletime")
	}
}


function valid_ppp_redial(obj,obj_id,span_id){
        clear_msg(obj_id,span_id);
        //clear_msg(ppp_idletime,span_id);
        if(!msg_chk_range(obj,"ppp_redialperiod",PPP_REDIALPERIOD_START,PPP_REDIALPERIOD_TO,10,IS_FIELD,0,span_id))
                return false;
        return true;
}

function CHG_MTUMode(F){
        if ( F.mtu_enable[0].checked ) //Auto
                choose_disable(F.wan_mtu);
        else
                choose_enable(F.wan_mtu);
}

function valid_mtu(wan_type)
{
        var F = document.wan_v6;
        if ( !msg_chk_range(F.wan_mtu.value,"wan_mtu",start_range,end_range,10,IS_FIELD,0,"_mtu") ) return false;      
        return true;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=wan_v6 method=POST action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=wait_time value=20>
<input type=hidden name=ap_wan_ipv6_proto disabled>
<input type=hidden name=ap_wan_ipv6_ipaddr disabled>
<input type=hidden name=ap_wan_ipv6_prefixlen disabled>
<input type=hidden name=ap_wan_ipv6_gateway disabled>
<input type=hidden name=ap_wan_ipv6_dns_primary disabled>
<input type=hidden name=ap_wan_ipv6_dns_secondary disabled>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.wantitle),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.ipaddr),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.conntype),"id=space_row","id=space_row2");</script>
		<script>
			if ( ap_mode == "1" ) 
			{
				var _name= new Array(__T(ipv6.slaac),__T(ipv6.dhcp),__T(ipv6.st));
				var _val= new Array("slaac","dhcp","static");
			}else{
				var _name= new Array(__T(ipv6.slaac),__T(ipv6.dhcp),__T(ipv6.st),__T(ipv6.pppoe));
				var _val= new Array("slaac","dhcp","static","pppoe");
			}
			draw_object(O_GUI,SELBOX,"wan_ipv6_proto","onChange=SelType(this.value,this.form)",_name,_val,now_proto);
			//draw_object(O_GUI,SELBOX,"wan_ipv6_proto","onChange=SelWAN(this.value,this.form)",_name,_val,now_proto);</script>
		</script>
		</TD></TR>
		<TR id=trdhcp style=display:none><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.pd),SPACE_DOWN,SPACE_DOWN);
		var _name = new Array(__T(share.enable),__T(share.disable));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"ipv6_dhcpc_pd",_val,_name,"<% nvram_get("ipv6_dhcpc_pd"); %>","");</script>
		</script></TD></TR>
			<!--pppoe start -->
				<TR id=hr style=display:none><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
				<input type=hidden name=ppp_demand>
				<input type=hidden name=ppp_passwd>
				<TR><script>draw_td(O_GUI,FUNTITLE,__T(wan.pppoeset),"colspan=2");</script></TR>
				<script>
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
				document.write("<input type=radio "+selflg1+" name=_ppp_demand value=1 onClick=chg_demand(this.form,1)>"+spell_words(connect_on_demand_rule,"<input id=ppp_idletime size=5 maxlength=4 name=ppp_idletime value="+nv_ppp_idletime+" onblur=valid_ppp_idletime(this.value,\"ppp_idletime\",\"_ppp_idletime\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"1","9999","5"));
				document.write("<SPAN id=_ppp_idletime></SPAN></TD></TR>");
				document.write("<TR>");
				draw_td(O_GUI,SUBTITLE_M,"colspan=2");
				document.write("<input type=radio "+selflg2+" name=_ppp_demand value=0 onClick=chg_demand(this.form,0)>"+spell_words(keep_alive_rule,"<input id=ppp_redialperiod size=5 maxlength=3 name=ppp_redialperiod value="+nv_ppp_redialperiod+" onblur=valid_ppp_redial(this.value,\"ppp_redialperiod\",\"_ppp_redialperiod\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"20","180","30"));
				document.write("<SPAN id=_ppp_redialperiod></SPAN></TD></TR>");
				document.write("<TR>");
				draw_td(O_GUI,SUBTITLE,__TC(wan.authtype));
				var _name = new Array(__T(wan.autonegotiation),__T(wan.pap),__T(wan.chap),__T(wan.mschap),__T(wan.mschap2));
				var _val = new Array("ISRANGE","0","4","1");
				draw_object(O_GUI,SELBOX,"ppp_auth","",_name,_val,"<% nvram_get("ppp_auth"); %>");
				var nv_ppp_service="<% nvram_get("ppp_service");%>";
				document.write("<TR>");
				draw_td(O_GUI,SUBTITLE,__TC(filter.servicename));
				document.write("<input type=text size=20 maxlength=63 name='ppp_service' id='ppp_service' value='"+nv_ppp_service+"'>");           		
				document.write("<SPAN id=msg_service_name></SPAN></TD></TR>");

			</script>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wan.mtu));</script>
		<script>
		var _name= new Array(__T(share.auto),__T(share.manual));
		var _val = new Array("0","1");
	draw_object(O_GUI,RADIO,"mtu_enable",_val,_name,nv_mtu_enable,"id=mtu_enable onclick=CHG_MTUMode(this.form)");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.size),"style='padding-bottom:10px'","style='padding-bottom:10px'");</script>	
		<input size=5 maxlength=4 value="<% nvram_get("wan_mtu"); %>" name=wan_mtu id=wan_mtu onblur=valid_mtu(this.value,"wan_mtu",ROUTER_ADV_MTU_START1,ROUTER_ADV_MTU_START,PPPOE_MTU_TO,"_mtu")> <script>document.write("("+__TC(def.range)+" "+ROUTER_ADV_MTU_START+" - "+PPPOE_MTU_TO+", "+__TC(def.words)+PPPOE_MTU_TO+")");</script>
		</script>
			
		<SPAN id=_mtu></SPAN>
		</TD></TR>
		<input type=hidden name=ppp_mtu>
		<!-- IP settings start -->
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.ipset),"colspan=2;");</script></TR>
		<TR id=pppoe_addr_mode>
		<script>
			draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.addrmode));
			var _name= new Array(__T(lan.dynamic),__T(lan.sstatic));
			var _val = new Array("dhcp","static");
			draw_object(O_GUI,RADIO,"ipv6_pppoe_addr_mode",_val,_name,nv_pppoe_addr_mode,"id=ipv6_pppoe_addr_mode onclick=chg_AddrMode(this.form)");</script>
		</script>
		</TD></TR>
		<!--pppoe end -->
		<TR id=static_start><script>draw_td(O_GUI,FUNTITLE,__T(wan.stipaddr));</script></TR>
		<TR id=static_start2><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.addr));</script>
		<script>
		document.write("<input size=51 maxlength=39 id=wan_ipv6_ipaddr name=wan_ipv6_ipaddr value="+full_ipv6("<% nvram_get("wan_ipv6_ipaddr"); %>")+">");
		</script>
		<SPAN id=msg_ip></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefixlen));</script>
		<input size=10 maxlength=3 id=wan_ipv6_prefixlen name=wan_ipv6_prefixlen onblur=msg_chk_range(this.value,"wan_ipv6_prefixlen",IPV6_PREFIX_LEN_START,IPV6_PREFIX_LEN_TO,10,IS_FIELD,0,"_prefix") value="<% nvram_get("wan_ipv6_prefixlen"); %>" > (<script>document.write(__TC(def.range)+IPV6_PREFIX_LEN_START+"-"+IPV6_PREFIX_LEN_TO);</script>)
                <span id=_prefix></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.defgw));</script>
		<script>
		document.write("<input size=51 maxlength=39 id=wan_ipv6_gateway name=wan_ipv6_gateway value="+full_ipv6("<% nvram_get("wan_ipv6_gateway"); %>")+">");
		</script>
		<SPAN id=msg_gw></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,spell_words(static_dns_rule,1)+":");</script>
		<script>
		document.write("<input size=51 maxlength=39 id=wan_ipv6_dns_primary name=wan_ipv6_dns_primary value="+full_ipv6("<% nvram_get("wan_ipv6_dns_primary"); %>")+">");
		</script>
		<SPAN id=msg_dns1></SPAN>
		</TD></TR>
		<TR id=static_end><script>draw_td(O_GUI,SUBTITLE,spell_words(static_dns_rule,2)+":",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		document.write("<input size=51 maxlength=39 id=wan_ipv6_dns_secondary name=wan_ipv6_dns_secondary value="+full_ipv6("<% nvram_get("wan_ipv6_dns_secondary"); %>")+">");
		</script>
		<SPAN id=msg_dns2></SPAN>
		</TD></TR>
        	</TABLE></TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
