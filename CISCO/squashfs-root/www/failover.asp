<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
var usb_st="<% get_cardinfo("status"); %>";
var portlist = new Array();
<% get_port_st("portlist"); %>
var wan_link = "<% misc_get("wan_link"); %>";
var wan_st = __T(share.disconnected);
var wan_pri = "eth";
var nv_connect_mode = "<% nvram_get("wwan_connect_mode"); %>";
var nv_cf_validgw= "<% nvram_get("wwan_cf_validgw"); %>";
var nv_cf_validsite = "<% nvram_get("wwan_cf_validsite"); %>";
//for time range selection
var nv_cf_sel_time = "<% nvram_get("wwan_cf_sel_time");%>";
var _hour_name12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
var _hour_name24 = new Array("ISRANGE","0","23","1",2);
var nv_cf_sel_time_start= "<% nvram_get("wwan_cf_sel_time_start");%>".split(",");
var nv_cf_sel_time_end= "<% nvram_get("wwan_cf_sel_time_end");%>".split(",");


var ip_mode="<% nvram_get("wan_ip_mode"); %>";
<% support_invmatch("IPV6_SUPPORT","1","/*");%>
var nv_cf_validsite6 = full_ipv6("<% nvram_get("wwan_cf_validsite6"); %>");
if ( nv_cf_validsite6 == "0" || nv_cf_validsite6 == "")
	nv_cf_validsite6=full_ipv6("0::0");
<% support_invmatch("IPV6_SUPPORT","1","*/");%>
if ( usb_st != "Connected" && (portlist[4] != __T(router.down)) && (wan_link != "0") )
	wan_st = __T(share.connected);
if ( usb_st != "Connected" ) 
	usb_st = __T(share.disconnected);

function datastruct(name,link,st)
{
	this.name=name;
	this.link=link;
	this.st=st;
} 
var usb_data = new datastruct(__T(wwan.usb),"system.asp",usb_st);
var eth_data = new datastruct(__T(wwan.ethernet),"status_wide.asp",wan_st);
var data1,data2;
if ( wan_pri == "usb" ) 
{
	data1 = usb_data;
	data2 = eth_data;
}else{
	data1 = eth_data;
	data2 = usb_data;
} 
datalist[0] = new Array(data1.name,data1.st,"");
datalist[1] = new Array(data2.name,data2.st,"");
function chg_pri()
{
	var F = document.frmwan;
	var tmp1,tmp2;
	if ( document.getElementById("td0_0").innerHTML == __T(wwan.ethernet) && F._wwan_connect_recovery[0].checked )
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(wwan.failovermsg),"pri_alert_result(1)","pri_alert_result(0)","","yesno");	
		
	}else
		pri_alert_result(1);
}

function pri_alert_result(val)
{
	var F = document.frmwan;
	alert_result(0);
	if ( val == 1 ) 
	{		
		tmp1=document.getElementById("td0_0").innerHTML;
		tmp2=document.getElementById("td1_0").innerHTML;
		document.getElementById("td0_0").innerHTML = document.getElementById("td0_1").innerHTML;
		document.getElementById("td1_0").innerHTML = document.getElementById("td1_1").innerHTML;
		document.getElementById("td0_1").innerHTML = tmp1;
		document.getElementById("td1_1").innerHTML = tmp2;
		if ( document.getElementById("td0_0").innerHTML == __T(wwan.usb) )
			F._wwan_connect_recovery[1].checked = true;
	}
	chg_recovery(F);
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmwan;

	chg_failover(F);

	if(nv_connect_mode == "1")	//Manual Mode
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(wwan.chgconnectmode),"alert_result(0)");	
		DISABLE_PART(F,"failover_recovery_start","ip_3",1);
		return;
	}
	for(var i=0; i<datalist.length; i++)
		load_data(F,i);
	/*For time range selection +++*/
	var tmp_s_hour = 0, tmp_e_hour=0;
	if( parseInt(nv_cf_sel_time_start[0],10) >= 12 && flg_24 == 0 )
	{
			F.stime.selectedIndex = 1;
			tmp_s_hour = parseInt(nv_cf_sel_time_start[0],10)-12;
	}
	else
	{
		if ( flg_24 == 0 ) F.stime.selectedIndex = 0;
		tmp_s_hour = parseInt(nv_cf_sel_time_start[0],10);
	}
	if( parseInt(nv_cf_sel_time_end[0]) >= 12 && flg_24 == 0 )
	{
		F.etime.selectedIndex = 1;
		tmp_e_hour = parseInt(nv_cf_sel_time_end[0],10)-12;
	}
	else
	{
		if ( flg_24 == 0 ) F.etime.selectedIndex = 0;
		tmp_e_hour = parseInt(nv_cf_sel_time_end[0],10);
	}
	F.stime_min.selectedIndex = parseInt(nv_cf_sel_time_start[1],10);
	F.etime_min.selectedIndex = parseInt(nv_cf_sel_time_end[1],10);
	if ( flg_24 == 0 ) 
	{
		for(var k=0; k<_hour_name12.length; k++)
		{
			if ( parseInt(_hour_name12[k],10) == tmp_s_hour ) 
				F.stime_hour[k].selected = true;
			if ( parseInt(_hour_name12[k],10) == tmp_e_hour ) 
				F.etime_hour[k].selected = true;
		}
	}else{
                F.stime_hour[tmp_s_hour].selected = true;
                F.etime_hour[tmp_e_hour].selected = true;
	}
	chg_recovery_onclick(F);

	/*For time range selection ---*/

}
var idx=0;
function load_data(F,index)
{
	var tmp = new Array();
	tmp[0] = new Array("td0_"+index,datalist[index][0],0);
	tmp[1] = new Array("td1_"+index,datalist[index][1],0);
	tmp[2] = new Array("td2_"+index,datalist[index][2],0);
	add_row(index,tmp,"","init",2);
	idx++;
}
function chg_failover(F)
{
	DISABLE_PART(F, "wwan_cf_timeout","validgw_end",1);
	choose_enable(F._wwan_connect_recovery[0]);	
	choose_enable(F._wwan_connect_recovery[1]);	
	if ( F._wwan_connect_failover[1].checked == true ) 
	{
		choose_disable(F._wwan_connect_recovery[0]);	
		choose_disable(F._wwan_connect_recovery[1]);	
	}
	else if ( F._wwan_connect_failover[0].checked == true && F._wwan_connect_recovery[0].checked == true ) 
	{
		DISABLE_PART(F, "wwan_cf_timeout","validgw_end",0);
		chg_recovery(F);	
		sel_validgw(F);
	}else if ( F._wwan_connect_failover[0].checked == true && F._wwan_connect_recovery[1].checked == true ){ 
		choose_enable(F.wwan_cf_timeout);
		choose_enable(F._wwan_cf_validgw[0]); 
		choose_enable(F._wwan_cf_validgw[1]); 
		sel_validgw(F);
	}

}

function chg_recovery(F)
{    
	if ( F._wwan_connect_recovery[0].checked == true ) 
	{
		DISABLE_PART(F, "wwan_cr_timeout","time_end",0);
		sel_time();
	}else{
		DISABLE_PART(F, "wwan_cr_timeout","time_end",1);
	}
}

function chg_recovery_onclick(F)
{
	var wan_proto = "<% nvram_get("wan_proto"); %>";
	var ppp_demand = "<% nvram_get("ppp_demand"); %>";
	if ( (F._wwan_connect_recovery[0].checked == true) && 
		((wan_proto != "static") && (wan_proto != "dhcp")) && (ppp_demand == "1")
	   ) 
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(wwan.warncodmsgfr),"failover_alert_result()");	
		return;
	}	
	chg_failover(F);
}

function failover_alert_result()
{
	var F = document.frmwan;
	alert_result(0);
	F._wwan_connect_recovery[1].checked = true;
	chg_failover(F);

}


function sel_validgw(F){
	var F = document.frmwan;

	for(var i=0; i<4; i++)
	{
		clear_msg("ip_"+i,"msg_ip");
	}
	if (F._wwan_cf_validgw[0].checked == true ) 
	{
		for(var i=0; i<4; i++)
			choose_disable(eval("F.ip_"+i));
	}else{
		for(var i=0; i<4; i++)
			choose_enable(eval("F.ip_"+i));
	}
<% support_invmatch("IPV6_SUPPORT","1","/*");%>
	if( ip_mode != "1" ) {
		clear_msg("wwan_cf_validsite6","msg_ip6");
		if ( F._wwan_cf_validgw[0].checked == true )	
			DISABLE_PART(F, "ip_0","wwan_cf_validsite6",1);
		else
			DISABLE_PART(F, "ip_0","wwan_cf_validsite6",0);
	}
<% support_invmatch("IPV6_SUPPORT","1","*/");%>
}

function update_val()
{
	var F = document.frmwan;
	document.getElementById("msg_ip").innerHTML = "";
	if ( F._wwan_cf_validgw[1].checked == true ) 
	{
		if ( !my_valid_m_value("IP",F,"ip","",VALID_IP_RULE7,ZERO_OK,"msg_ip")) return false;
	}
	return true;
}

function valid_value(F)
{
	var errflg = 0;
	if ( !update_val()) errflg = 1;
	if ( F._wwan_connect_failover[0].checked == true ) 
	{
		if ( !msg_chk_range(F.wwan_cf_timeout.value,"wwan_cf_timeout",WWAN_CF_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,10,IS_FIELD,0,"msg_cf_timeout")) errflg = 1;	
	}
	if ( F._wwan_connect_recovery[0].checked == true ) 
	{
		if ( !msg_chk_range(F.wwan_cr_timeout.value,"wwan_cr_timeout",WWAN_CR_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,10,IS_FIELD,0,"msg_cr_timeout")) errflg = 1;
	}
	if ( (ip_mode != "1") && !chk_ipv6(F.wwan_cf_validsite6.value)) errflg=1;
	if ( errflg == 1 ) return false;
	return true;
		
}
<% support_invmatch("IPV6_SUPPORT","1","/*");%>
function chk_ipv6(val)
{
	clear_msg("wwan_cf_validsite6","msg_ip6");
	if(val == "")
		return true;
	var errmsg = valid_ipv6(val);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,"wwan_cf_validsite6",errmsg,"0","msg_ip6");
		return false;
	}
	return true;
}
<% support_invmatch("IPV6_SUPPORT","1","*/");%>

function sel_time()
{
	var F = document.frmwan;
        if ( (F._wwan_connect_recovery[0].checked == true) && (F.wwan_cf_sel_time[1].checked == true))
	{
                DISABLE_PART(F,"time_start","time_end",0);
	}
        else
	{
	
                DISABLE_PART(F,"time_start","time_end",1);
	}
}

function check_timerange(F) 
{
	var errflg = 0 ;
	var start=0, end=0;
	var shour=0, ehour=0;
	if( F.wwan_cf_sel_time[1].checked ) {
		if ( flg_24 == 0 ) 
		{
			if( F.stime.value == "pm") 
			{
				shour = parseInt(F.stime_hour.value,10);
				if(shour != 12)
					shour = shour+12;
			}
			else 
			{
				shour = parseInt(F.stime_hour.value,10);
				if(shour == 12)
					shour=0;
			}
			start = shour*60 + parseInt(F.stime_min.value,10);
			if( F.etime.value == "pm") 
			{
				//ehour = parseInt(F.etime_hour.value,10)+12;
				ehour = parseInt(F.etime_hour.value,10);
				if(ehour != 12)
					ehour=ehour+12;
			}
			else
			{
				ehour = parseInt(F.etime_hour.value,10);
				if(ehour == 12)
					ehour=0;
			}
			end = ehour*60 + parseInt(F.etime_min.value,10);
			//if(!( (F.stime.value == "pm") && ( F.etime.value == "am")) && ( end < start))
			/*
			if(( end < start))
			{
		                my_alert(O_VAR,"etime_hour",__T(msg.timechk),"0","msg_time");
        		        my_alert(O_VAR,"etime_min",__T(msg.timechk),"0","msg_time");
                		my_alert(O_VAR,"etime",__T(msg.timechk),"0","msg_time");
				errflg=1;
			}
			*/
		}else{
			shour = parseInt(F.stime_hour.value,10);
			ehour = parseInt(F.etime_hour.value,10);
		}
		if ( errflg == 1 ) return false;
		F.wwan_cf_sel_time_start.value = shour+","+F.stime_min.value;
		F.wwan_cf_sel_time_end.value = ehour+","+F.etime_min.value;
	}
	return true;
}

function uiDoSave(F)
{
	var tmp_ip="";
	if ( nv_connect_mode == "1") {
		my_alert(O_GUI,INFO,__T(share.info),__T(wwan.chgconnectmode),"alert_result(0)");	
		return;
	}
	if ( !valid_value(F) ) return;
	if ( F._wwan_cf_validgw[1].checked == true ) 
	{
		for(var i=0; i<4; i++)
		{
			if ( tmp_ip != "" ) 
				tmp_ip +=".";
			if ( eval("F.ip_"+i).value == "" ) 
				tmp_ip += "0";
			else
				tmp_ip += eval("F.ip_"+i).value;
		}
	}
	if( (ip_mode == "1") && (tmp_ip == IPV4_DEFAULT_VALUE) ) {
		my_alert(O_VAR,"ip",ddnsm.tzo_notip,"4","msg_ip");
		return;
	}
	<% support_invmatch("IPV6_SUPPORT","1","/*");%>
	else if((tmp_ip == IPV4_DEFAULT_VALUE) && 
		(F.wwan_cf_validsite6.value== IPV6_DEFAULT_VALUE))
	{
		my_alert(O_VAR,"ip",__T(wwan.inputip),"4","msg_ip");
		my_alert(O_VAR,"wwan_cf_validsite6","","0","msg_ip6");
		return;
	}
	<% support_invmatch("IPV6_SUPPORT","1","*/");%>

	if(!check_timerange(F)) return;
	if ( F._wwan_connect_failover[0].checked == true ) 
		F.wwan_connect_failover.value = "1" ;
	else  
		F.wwan_connect_failover.value = "0" ;
	if(F._wwan_connect_recovery[0].checked == true)
		F.wwan_connect_recovery.value = "1" ;
	else
		F.wwan_connect_recovery.value = "0" ;

	if ( F._wwan_cf_validgw[0].checked == true ) 
	{
		F.wwan_cf_validgw.value = "1";
		F.wwan_cf_validsite.value=nv_cf_validsite;
	}
	else{
		F.wwan_cf_validgw.value = "0";
		F.wwan_cf_validsite.value=tmp_ip;
	}
	
	F.submit_button.value = "failover";
	parent.document.getElementById("save_bg").style.display="";
	F.gui_action.value = "Apply";
	F.submit();
}	
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmwan method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=submit_type>
<input type=hidden name=wwan_connect_recovery>
<input type=hidden name=wwan_connect_failover>
<input type=hidden name=wwan_cf_validgw>
<input type=hidden name=wwan_cf_validsite>
<input type=hidden name=wwan_cf_sel_time_start value="<%nvram_get("wwan_cf_sel_time_start");%>">
<input type=hidden name=wwan_cf_sel_time_end value="<% nvram_get("wwan_cf_sel_time_end"); %>">
<input type=hidden name=wait_time value=10>
<!--input type=hidden name=wwan_priority-->
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wwan.failover),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.connrecovery));</script>
		<input type=hidden name=failover_recovery_start>
		<script>
		var _name = new Array(__T(share.enable),__T(share.disable));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"_wwan_connect_failover",_val,_name,"<% nvram_get("wwan_connect_failover"); %>"," onclick='chg_failover(this.form)'");</script>
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.ifacefailover));</script>
		<script>
		var _name = new Array(__T(share.enable),__T(share.disable));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"_wwan_connect_recovery",_val,_name,"<% nvram_get("wwan_connect_recovery"); %>"," onclick='chg_recovery_onclick(this.form)'");</script>
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.failoverchk));</script>
		<input size=20 name=wwan_cf_timeout id=wwan_cf_timeout value="<% nvram_get("wwan_cf_timeout"); %>" onblur=msg_chk_range(this.value,"wwan_cf_timeout",WWAN_CF_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,10,IS_FIELD,0,"msg_cf_timeout")>&nbsp;<script>document.write(__T(unit.seconds)+" "+spell_words(range_def_rule,WWAN_CF_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,WWAN_CF_TIMEOUT_START));</script>
		<SPAN id=msg_cf_timeout></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.interval));</script>
		<input size=20 name=wwan_cr_timeout id=wwan_cr_timeout value="<% nvram_get("wwan_cr_timeout"); %>" onblur=msg_chk_range(this.value,"wwan_cr_timeout",WWAN_CR_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,10,IS_FIELD,0,"msg_cr_timeout")>&nbsp;<script>document.write(__T(unit.seconds)+" "+spell_words(range_def_rule,WWAN_CR_TIMEOUT_START,WWAN_CF_TIMEOUT_TO,WWAN_CR_TIMEOUT_START));</script>
		<SPAN id=msg_cr_timeout></SPAN>
		</TD></TR>

		<!--Switch to Ethernet WAN time selection start-->
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input type=radio value=1 name=wwan_cf_sel_time onclick=sel_time() <% nvram_match("wwan_cf_sel_time","1","checked");%>>
		<script>Capture(wwan.cf_s2eth_intime);</script> 
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input type=radio value=0 name=wwan_cf_sel_time onclick=sel_time() <% nvram_match("wwan_cf_sel_time","0","checked");%>>
		<script>Capture(wwan.cf_s2eth_rangetime);</script> 
		</TD></TR>
		<input type=hidden name=time_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.starttime));</script>
		<script>
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("am","pm");
			var _min_name = new Array("ISRANGE","0","59","1",2);
		if ( flg_24 == 1 ) 
		{
	                draw_object(O_GUI,SELBOX,"stime_hour","id=stime_hour",_hour_name24,_hour_name24);
        	        document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
	                draw_object(O_GUI,SELBOX,"stime_min","id=stime_min",_min_name,_min_name);
        	        document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}else{
			draw_object(O_GUI,SELBOX,"stime_hour","",_hour_name12,_hour_name12);
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			draw_object(O_GUI,SELBOX,"stime_min","",_min_name,_min_name);
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
			draw_object(O_GUI,SELBOX,"stime","",_name,_val);
		}
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.endtime),SPACE_DOWN,SPACE_DOWN);</script>
                <script>
		var _name = new Array(__T(mang.am),__T(mang.pm));
                var _val = new Array("am","pm");
                var _min_name = new Array("ISRANGE","0","59","1",2);
		if ( flg_24 == 1 ) 
		{
	                draw_object(O_GUI,SELBOX,"etime_hour","id=etime_hour",_hour_name24,_hour_name24);
        	        document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
	                draw_object(O_GUI,SELBOX,"etime_min","id=etime_min",_min_name,_min_name);
        	        document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}else{
	                draw_object(O_GUI,SELBOX,"etime_hour","id=etime_hour",_hour_name12,_hour_name12);
        	        document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
	                draw_object(O_GUI,SELBOX,"etime_min","id=etime_min",_min_name,_min_name);
        	        document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
                	draw_object(O_GUI,SELBOX,"etime","id=etime",_name,_val);
		}
                </script>
		<SPAN id=msg_time></SPAN>
                </TD></TR>
		<input type=hidden name=time_end>
		<!--Switch to Ethernet WAN time selection end-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.connvalidsite));</script>
		<input type=radio value=1 name=_wwan_cf_validgw onclick=sel_validgw() <% nvram_match("wwan_cf_validgw","1","checked");%>><script>Capture(share.gateway);</script> 
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input type=radio value=0 name=_wwan_cf_validgw onclick=sel_validgw() <% nvram_match("wwan_cf_validgw","0","checked");%>><script>Capture(wwan.customipv4);</script> 
		&nbsp;
		<script>draw_object(O_GUI,IP,"ip","<% nvram_get("wwan_cf_validsite"); %>");</script>
		<SPAN id=msg_ip></SPAN>
		</TD></TR>
		<!--IPv6 field start -->
		<% support_invmatch("IPV6_SUPPORT","1","<!--"); %>
		<TR><script>
			if(ip_mode != "1") {
				draw_td(O_GUI,SUBTITLE_NOSHIFT,"");
				document.write("<span style=padding-left:25px>");
				Capture(wwan.customipv6);
				document.write("<span style=padding-left:10px></span>");
				document.write("<input size=51 maxlength=39 id=wwan_cf_validsite6 name=wwan_cf_validsite6 value="+nv_cf_validsite6+" onblur=chk_ipv6(this.value)>");
			}
		</script> 
		<span id=msg_ip6></span>
		</span>
		</TD></TR>
		<% support_invmatch("IPV6_SUPPORT","1","-->"); %>
		<input type=hidden name=validgw_end>
		<!--IPv6 field end -->
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,20",__T(wan.waniface),""+__T(share.iface)+","+__T(share.sts),"","","","","0,0");
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
