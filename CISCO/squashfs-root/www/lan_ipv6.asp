<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
CHK_VALUE_AUTO=0;
var idx=0; 
var stflg="init";
var td_id=new Array("td_start","td_end","td_plen");
var obj_id=new Array("ipv6_start","ipv6_end","prefix_len");
var img_id=new Array("img_start","img_end","img_plen");
var div_id=new Array("div_start","div_end","div_plen");
var nv_ipv6_ip = full_ipv6("<% nvram_get("lan_ipv6_ipaddr"); %>");
var pool = new Array();
<% get_ipv6_pool(); %>
var dns_rule=0;
function get_data(F)
{
	var data = keep_val(F,"");
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById(obj_id[i]+i) ) 
			data += document.getElementById(obj_id[i]+i).value;
		else
			data += document.getElementById(td_id[i]+i).innerHTML;
		if ( i != idx-1 ) data += ",";
	}
	return data;
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("hidden_bg").style.display="none";
	for(var i=0; i<pool.length; i++)
	{
		var tmp = new Array();
		tmp[0] = new Array("td_chk"+idx,"<input type=checkbox disable name=chk_"+idx+" id=chk_"+idx+" onclick=to_chk('"+idx+"')>",3);
		tmp[1] = new Array(td_id[0]+i, full_ipv6(pool[i][0]),0);
		tmp[2] = new Array(td_id[1]+i, full_ipv6(pool[i][1]),0);
		tmp[3] = new Array(td_id[2]+i, pool[i][2],2);
		tmp[4] = new Array("","&nbsp;",0);
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	
	chk_dhcp(document.setup);
	choose_disable(document.getElementById("t3"));
	choose_disable(document.getElementById("t4"));
	var wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>"; //1:IPv4 2:IPv6
	var lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>"; //1:IPv4 2:IPv6 3:IPv4&IPv6
	if ( wan_ip_mode == "1" && ( lan_ip_mode == "3" || lan_ip_mode == "2" ) )
	{
		choose_disable(document.getElementById("lan_ipv6_dns_mode")[1]);
	}
	default_nv = get_data(document.setup);
}

function valid_prefixlen(index){
	clear_table_msg("tmsg",img_id[2]+index,obj_id[2]+index,index);
	var errmsg="";
	if ( chk_range(obj_id[2]+index,document.getElementById(obj_id[2]+index).value,IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO) == FAIL ) 
        	errmsg=spell_words(range_rule,IPV6_PREFIXLEN_START,IPV6_PREFIXLEN_TO);
	if ( errmsg != "" ) 
	{
		table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,errmsg);
		return false;
	}
	return true;
}

function chk_before_data(index)
{
	var errflg=0;
	if ( document.getElementById(obj_id[0]+index) ) 
	{
		var ipv6_saddr = document.getElementById(obj_id[0]+index).value;
		var ipv6_eaddr = document.getElementById(obj_id[1]+index).value;
		if(!chk_valid_ipv6(ipv6_saddr,0,index)) errflg = 1;
		if(!chk_valid_ipv6(ipv6_eaddr,1,index)) errflg = 1;
		if ( document.getElementById("prefix_len"+index) )
			if ( !valid_prefixlen(index) ) errflg=1;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function to_chk(index){
	document.getElementById("chkall").checked = false;
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,pool[index]);
}
	

function to_add(){
	stflg="add";
	if ( idx >= IPV6_DHCP_ENTRY ){
		my_alert(O_GUI,INFO,__T(share.info),spell_words(max_rule,IPV6_DHCP_ENTRY,__T(ipv6.dhcppools)));		     return;			
	}
	if ( !chk_before_data(idx-1) ) return false;	
	var tmp = new Array();
	tmp[0] = new Array("td_chk"+idx,"<input type=checkbox disabled name=chk_"+idx+" id=chk_"+idx+" onClick=to_chk('"+idx+"')>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input name="+obj_id[0]+idx+" id="+obj_id[0]+idx+" size=51 maxlength=39 onBlur=chk_valid_ipv6(this.value,0,"+idx+") onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"') value='"+get_prefix()+"'>",div_id[0]+idx),1);
	tmp[2] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input name="+obj_id[1]+idx+" id="+obj_id[1]+idx+" size=51 maxlength=39 onBlur=chk_valid_ipv6(this.value,1,"+idx+") onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"') value='"+get_prefix()+"'>",div_id[1]+idx),1);
	tmp[3] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input name="+obj_id[2]+idx+" id="+obj_id[2]+idx+" size=10 onBlur=valid_prefixlen('"+idx+"') onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"') value=64>",div_id[2]+idx,"","align=right"),1);		
	tmp[4] =new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function to_edit(){
	stflg="edit";
	for(i=0; i<idx; i++){
		if ( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[0]+i) == null) 
		{
			var tmp = new Array();
			tmp[0] = draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input name="+obj_id[0]+i+" id="+obj_id[0]+i+" size=51 onBlur=chk_valid_ipv6(this.value,0,"+i+") onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value="+full_ipv6(pool[i][0])+">",div_id[0]+i);
			tmp[1] = draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input name="+obj_id[1]+i+" id="+obj_id[1]+i+" size=51 onBlur=chk_valid_ipv6(this.value,1,"+i+") value="+full_ipv6(pool[i][1])+">",div_id[1]+i);
			tmp[2] = draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input name="+obj_id[2]+i+" id="+obj_id[2]+i+" size=20 onBlur=valid_prefixlen('"+i+"') onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+pool[i][2]+">",div_id[2]+i);
			edit_row(td_id,tmp,i);
		}
	}
}

function to_del(){
	stflg = "del";
	for(i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
			del_row(i);
	}
}

function valid_value(F)
{
	var errflg=0;
	var ipv6_saddr;
	var ipv6_eaddr;
	if ( !chk_ipv6(F.lan_ipv6_ipaddr.value) ) errflg = 1;
	if ( !msg_chk_range(F.lan_ipv6_prefixlen.value,"lan_ipv6_prefixlen",IPV6_PREFIX_LEN_START,IPV6_PREFIX_LEN_TO,10,IS_FIELD,1,"_prefix") ) errflg =1;
	if ( !msg_chk_range(F.lan_ipv6_dhcp_pref.value,"lan_ipv6_dhcp_pref",IPV6_SERVER_PREFERENCE_START,IPV6_SERVER_PREFERENCE_TO,10,IS_FIELD,1,"_pref") ) errflg=1;
	if ( !msg_chk_range(F._lan_ipv6_dhcp_rebind.value,"_lan_ipv6_dhcp_rebind",LEASE_TIME_START,LEASE_TIME_TO,10,IS_FIELD,1,"_rebind") ) errflg=1;
	if ( F._lan_ipv6_dhcp.checked == true && F.lan_ipv6_dns_mode.selectedIndex == 2 && 
             F.lan_ipv6_dns_primary.value == "" && 
             F.lan_ipv6_dns_secondary.value == "" )
	{
		 my_alert(O_VAR,"lan_ipv6_dns_primary",__T(msg.setadns),"0","_dns1");
		 return false;
	}
	if ( !chk_dns("lan_ipv6_dns_primary","_dns1") ) errflg = 1;
	if ( !chk_dns("lan_ipv6_dns_secondary","_dns2") ) errflg = 1;
	
	for(var i=0; i<idx; i++) 
	{
		
		if( document.getElementById(obj_id[0]+i) == null )
		{
			document.getElementById("chk_"+i).checked = true;
		}
	}
	to_edit();
	for(var i=0; i<idx; i++) 
	{
		ipv6_saddr = document.getElementById(obj_id[0]+i).value;
		ipv6_eaddr = document.getElementById(obj_id[1]+i).value;
		if(!chk_valid_ipv6(ipv6_saddr,0,i)) errflg = 1;
		if(!chk_valid_ipv6(ipv6_eaddr,1,i)) errflg = 1;
		if (!chk_before_data(i)) errflg=1;
	}
	if ( errflg==1 ) return false;
	return true;
}

function chk_all(){         
	if ( stflg == "add" ){
                document.getElementById("chkall").checked = false;
                choose_disable(document.getElementById("chkall"));
                return;
        }
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i) )
                {
                        if ( document.getElementById("chkall").checked == true )
                                document.getElementById("chk_"+i).checked = true;
                        else
                                document.getElementById("chk_"+i).checked = false;
                }
                to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,pool[i]);
        }
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("lan_ipv6.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F){
	var tmp="";
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	for(var i=0; i<idx; i++)
	{
        	if (document.getElementById("tr_table"+i) == null ) continue;
		if ( stflg == "del" ) 
		{
			if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
			continue;
		}
		if ( tmp != "" ) tmp += ";";
		var tmp2="";
		for(var j=0; j<3; j++)
		{
			if ( tmp2 != "" ) tmp2 += ",";
			if ( document.getElementById(obj_id[j]+i) == null ) 
				tmp2+=document.getElementById(td_id[j]+i).innerHTML;
			else
				tmp2+=document.getElementById(obj_id[j]+i).value;
		}	
		tmp+=tmp2;
	}
	if ( !valid_value(F) ) return false;
	var prefer_time=0;
	F.lan_ipv6_dhcp_rebind.value = parseInt(F._lan_ipv6_dhcp_rebind.value,10)*60;
	prefer_time = (parseInt(F._lan_ipv6_dhcp_rebind.value,10)*60)/0.8
	
	F.lan_ipv6_dhcp_valid.value = 2*prefer_time;
	F.lan_ipv6_dhcp_prefer.value = prefer_time;
	F.lan_ipv6_dhcp_renew.value = parseInt(prefer_time/2,10);

	F.ipv6_dhcpd_pool.value = tmp; 
	F.lan_ipv6_dhcp.value = "off";
	if ( F._lan_ipv6_dhcp.checked ) 
		F.lan_ipv6_dhcp.value = "on";
	if ( F.lan_ipv6_ipaddr.value != nv_ipv6_ip ) 
		F.submit_button.value="lan_ipv6_changed_ip";
	else
		F.submit_button.value="lan_ipv6";
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
	{
		if ( F.lan_ipv6_ipaddr.value != nv_ipv6_ip ) 
			parent.document.getElementById("hidden_bg").style.display="";
		else
			parent.document.getElementById("save_bg").style.display="";
	}
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function chk_valid_ipv6(ipaddr,id,index)
{
	var F = document.setup;
	clear_table_msg("tmsg",img_id[id]+index,obj_id[id]+index,index);
	var errmsg = valid_ipv6(ipaddr);
	if( errmsg != "" )
	{
		table_msg(img_id[id]+index,obj_id[id]+index,div_id[id]+index,index,errmsg);
		return false;
	}else{
		if ( !check_ipv6_subnet(F.lan_ipv6_ipaddr.value,F.lan_ipv6_prefixlen.value,ipaddr) )
		{
			table_msg(img_id[id]+index,obj_id[id]+index,div_id[id]+index,index,__T(msg.subnet8));
			return false;
		}
		if ( check_ipv6_subnet(F.lan_ipv6_ipaddr.value,F.lan_ipv6_prefixlen.value,"<% nvram_get("wan_ipv6_ipaddr"); %>") )
		{
			table_msg(img_id[id]+index,obj_id[id]+index,div_id[id]+index,index,__T(msg.subnet10));
			return false;
			
		}
	}	
	return true;

}

function chk_ipv6_domain(F)
{
	clear_msg("lan_ipv6_domain","_domain");
	if ( F.lan_ipv6_domain.value != "" )
	{
		if ( !check_domain(F.lan_ipv6_domain.value) )
		{
			my_alert(O_VAR,"lan_ipv6_domain",__T(msg.validname),"0","_domain");
			return false;
		} 
	}
	return true;
}

function chk_ipv6(val)
{
	var F = document.setup;
	clear_msg("lan_ipv6_ipaddr","_ipaddr");
	var errmsg = valid_ipv6(val);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,"lan_ipv6_ipaddr",errmsg,"0","_ipaddr");
		return false;
	}
	if ( check_ipv6_subnet(F.lan_ipv6_ipaddr.value,F.lan_ipv6_prefixlen.value,"<% nvram_get("wan_ipv6_ipaddr"); %>") )
	{
		my_alert(O_VAR,"lan_ipv6_ipaddr",__T(msg.subnet10),"0","_ipaddr");
		return false;
	}
	return true;
}

function chk_dns(objname,span_id)
{
	var F = document.setup;
	clear_msg(objname,span_id);
	if ( F._lan_ipv6_dhcp.checked == false || eval("F."+objname).value == "" ) return true;
	var errmsg = valid_ipv6(eval("F."+objname).value);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,objname,errmsg,"0",span_id);
		return false;
	}
	return true;
}

function chk_dhcp(F)
{
        if ( F._lan_ipv6_dhcp.checked == true )
                DISABLE_PART(F,"start_dhcp","end_dhcp",0);
        else
                DISABLE_PART(F,"start_dhcp","end_dhcp",1);
}

function get_prefix()
{
	var prefix_len = parseInt(document.getElementById("lan_ipv6_prefixlen").value,10);
        var arr = trans_ipv6_array(document.getElementById("lan_ipv6_ipaddr").value);
	var binary_str="";
	for(var i=0; i<8; i++)
	{
		binary_str += trans_16to2(arr[i]);
	}
        var prefix="";
	var tmp="";
	var cnt=0;
        for(var i=0; i<prefix_len; i+=4)
        {
		tmp = "";
		for(var j=0; j<4; j++)
			tmp += binary_str.charAt(i+j);
		if ( i>15 && i%16 == 0 ) prefix+=":";
		prefix+=trans_2to16(tmp);
        }
        return prefix;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=lan_ipv6_dhcp>
<input type=hidden name=ipv6_dhcpd_pool>
<input type=hidden name=lan_ipv6_dhcp_rebind>
<input type=hidden name=lan_ipv6_dhcp_valid>
<input type=hidden name=lan_ipv6_dhcp_prefer>
<input type=hidden name=lan_ipv6_dhcp_renew>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.lantitle),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.ipv6));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.addr));</script>
		<script>
		document.write("<input size=51 maxlength=39 id=lan_ipv6_ipaddr name=lan_ipv6_ipaddr value="+nv_ipv6_ip+" onblur=chk_ipv6(this.value)>");
		</script>
		<span id=_ipaddr></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefixlen));</script>
		<input size=10 id=lan_ipv6_prefixlen name=lan_ipv6_prefixlen value="<% nvram_get("lan_ipv6_prefixlen");%>" onblur=msg_chk_range(this.value,"lan_ipv6_prefixlen",IPV6_PREFIX_LEN_START,IPV6_PREFIX_LEN_TO,10,IS_FIELD,0,"_prefix")> (<script>document.write(__T(def.range)+": "+IPV6_PREFIX_LEN_START+"-"+IPV6_PREFIX_LEN_TO+", "+__T(def.words)+": "+DEF_IPV6_PREFIX_LEN);</script>)
		<span id=_prefix></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.dhcpserverset),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.dhcpst));</script>
		<input type=checkbox name="_lan_ipv6_dhcp" <% nvram_match("lan_ipv6_dhcp","on","checked"); %> onclick=chk_dhcp(this.form)>
		<script>Capture(share.enable);</script>
		</TD></TR>
		<input type=hidden name=start_dhcp>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.dhcpmode));</script>
		<script>
		var _val = new Array("off","on");
		var _name = new Array(__T(lan.stateless),__T(lan.stateful));
		draw_object(O_GUI,SELBOX,"lan_ipv6_stateful","",_name,_val,"<% nvram_get("lan_ipv6_stateful");%>");</script>
		</script>
		</TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.domainname));</script>
		<input size=30 maxlength=64 name=lan_ipv6_domain id=lan_ipv6_domain value="<% nvram_get("lan_ipv6_domain"); %>" onblur=chk_ipv6_domain(this.form)>
		<span id=_domain></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.spreference));</script>
		<input size=10 maxlength=3 name=lan_ipv6_dhcp_pref id=lan_ipv6_dhcp_pref value="<% nvram_get("lan_ipv6_dhcp_pref"); %>" onblur=msg_chk_range(this.value,"lan_ipv6_dhcp_pref",IPV6_SERVER_PREFERENCE_START,IPV6_SERVER_PREFERENCE_TO,10,IS_FIELD,0,"_pref")> (<script>document.write(__T(def.range)+": "+IPV6_SERVER_PREFERENCE_START+"-"+IPV6_SERVER_PREFERENCE_TO+", "+__T(def.words)+": "+DEF_IPV6_SERVER_PREFERENCE);</script>)
		<span id=_pref></span>
		</TD></TR>
		<!--Added DNS Mode Selection start-->
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__TC(lan.dns));
			var _name= new Array(__T(lan.usednsproxy),__T(lan.usednsisp),__T(lan.usednsbelow));
			var _val= new Array("0","1","3");
			var nv_dns_mode="<% nvram_get("lan_ipv6_dns_mode"); %>";
			draw_object(O_GUI,SELBOX,"lan_ipv6_dns_mode","",_name,_val,nv_dns_mode);
		</script>
		<span id=_dns_mode></span>
		</TD></TR>
		<!--Added DNS Mode Selection end-->

		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(spell_words(static_dns_rule,"1")));</script>
		<script>
		document.write("<input size=51 maxlength=39 id=lan_ipv6_dns_primary name=lan_ipv6_dns_primary value='"+full_ipv6("<% nvram_get("lan_ipv6_dns_primary"); %>")+"' onblur=chk_dns(\"lan_ipv6_dns_primary\",\"_dns1\")>");
		</script>
		<span id=_dns1></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(spell_words(static_dns_rule,"2")));</script>
		<script>
		document.write("<input size=51 maxlength=39 id=lan_ipv6_dns_secondary name=lan_ipv6_dns_secondary value='"+full_ipv6("<% nvram_get("lan_ipv6_dns_secondary"); %>")+"'  onblur=chk_dns(\"lan_ipv6_dns_secondary\",\"_dns2\")>");
		</script>
		<span id=_dns2></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.clienttime));</script>
		<script>document.write("<input maxlength=4 size=10 name=_lan_ipv6_dhcp_rebind id=_lan_ipv6_dhcp_rebind value="+parseInt(<% nvram_get("lan_ipv6_dhcp_rebind"); %>/60,10)+" onblur=msg_chk_range(this.value,'_lan_ipv6_dhcp_rebind',LEASE_TIME_START,LEASE_TIME_TO,10,IS_FIELD,0,'_rebind')>&nbsp;"+__T(unit.minutes));
		document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"1","9999","1440"));
		</script>
		<span id=_rebind></span>
		</TD></TR>	
		<TR><TD colspan=2>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN);</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,25,25,25",__T(ipv6.pooltable),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(ipv6.startaddr)+","+__T(ipv6.endaddr)+","+__T(ipv6.prefixlen)+"","add,edit,del","","","","2,0,0,1");
		</script>	
		</TD></TR>
		<input type=hidden name=end_dhcp>
        	</TABLE></TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
