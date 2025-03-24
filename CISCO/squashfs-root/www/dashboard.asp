<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<style fprolloverstyle>
/*
a.content_link:link{COLOR: #0000FF; text-decoration:underline;};
a.content_link:visited{COLOR: #0000FF; text-decoration:underline;};
a.content_link:hover{COLOR: #0000FF; text-decoration:underline;};
*/
.SUBTITLE1{
  text-align:left;
  padding-right:10px;
  height:20px;
  width:200px;
  white-space:nowrap;
  vertical-align:center;
  background-color:#BDB6BD;
}

.SUBCONTENT1{
  text-align:center;
  vertical-align:center;
  border:1px solid #8499A2;
}
</style>
<script>
var port_num=0;
var portlist = new Array();
<% get_port_st("portlist"); %>
var portlist_name = new Array("1000Mbps Full Duplex","1000Mbps Half Duplex","100Mbps Full Duplex","100Mbps Half Duplex","10Mbps Full Duplex","10Mbps Half Duplex"); 
var portlist_val = new Array(__T(router.fullduplexT),__T(router.halfduplexT),__T(router.fullduplex),__T(router.halfduplex),__T(router.fullduplex10),__T(router.halfduplex10));
var port_0 = "<% nvram_get("port_manage_mode_0"); %>";
var port_1 = "<% nvram_get("port_manage_mode_1"); %>";
var port_2 = "<% nvram_get("port_manage_mode_2"); %>";
var port_3 = "<% nvram_get("port_manage_mode_3"); %>";
var port_4 = "<% nvram_get("port_manage_mode_4"); %>";
var wan_link = "<% misc_get("wan_link"); %>";
var wwan_up = "<% nvram_get("wwan_in_used"); %>";
var pptpd_used, quickvpn_used;
<% get_pptpd_user(); %>
var datalist = new Array();
<% get_vpn_account_data(); %>

function set_style(id)
{
	if ( Browser == "IE" ) 
	{
		if ( id < 3 )
			document.getElementById("td_lan"+id).style.paddingRight = "5px";
		else
			document.getElementById("td_lan"+id).style.paddingRight = "13px";
		document.getElementById("td_lan"+id).style.paddingLeft = "28px";
	}
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<portlist.length; i++)
        {
                if ( i < 4 )
                {
                        if ( portlist[i] != __T(router.down) )
                                document.getElementById("conn_lan"+i).style.display="";
			else
			{
				set_style(i);
			}
                }else{
                        if ( portlist[i] != __T(router.down) )
                                document.getElementById("conn_wan").style.display="";
                }
        }
	ViewRouter();
	var F = document.setup
	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
}

function reload(){
	goto_page("dashboard.asp");
}

function chk_startup(F){
	F.start_up.value=1;
	if ( F.startup.checked ) 
		F.start_up.value = 0;
	F.change_action.value="gozila_cgi";
	F.submit_button.value="getstart";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function ViewRouter(){
        SHOW_HIDDEN_TABLE("table_title","router_tb","tb_img",__T(router.showpanel),__T(router.hidepanel));
}

function sel_iface(idx,e)
{
	if ( portlist[idx] != __T(router.down) && document.getElementById("divport").style.display=="none" )  
	{
		if ( idx < 4 ) 
			document.getElementById("maintitle").innerHTML =  spell_words(lan_port_rule,parseInt(idx,10)+1);
		else
			document.getElementById("maintitle").innerHTML =  __T(mang.wanportinfo)
		document.getElementById("now_idx").value = idx;
		frames['iframe1'].location.href = goto_link("port_info.asp");
		if ( idx < 4 ) document.getElementById("iface").innerHTML = __T(lan.lan);
		else document.getElementById("iface").innerHTML = __T(wan.wan);
		var tmp = __T(router.down);
		if ( portlist[idx] != __T(router.down) ) tmp = __T(router.up);
		document.getElementById("linkst").innerHTML = tmp;
		for(var i=0; i<portlist_name.length; i++)
		{
			if ( portlist[idx] == portlist_name[i] ) 
			{
				document.getElementById("speed").innerHTML = portlist_val[i];
				break;
			}
		}	
		if ( document.getElementById("speed").innerHTML == "" ) 
				document.getElementById("speed").innerHTML = portlist[idx];
		if ( eval("port_"+idx) == "0" || eval("port_"+idx) == "" ) tmp = __T(share.enabled);
		else tmp = __T(share.disabled);
		document.getElementById("autoneg").innerHTML = tmp;
		var s = document.getElementById("divport");
		s.style.display="";
		if ( window.event ){
                	s.style.pixelTop = e.y+20;
	                s.style.pixelLeft = e.x+20;
        	}else{ 
        	        s.style.top = e.pageY+20+"px";
                	s.style.left = e.pageX+20+"px";
	        }	
	}
}

function to_refresh(F)
{
	frames['iframe1'].location.href = goto_link("port_info.asp");
}
function to_close()
{
	document.getElementById("divport").style.display="none";
}

function ToRefresh(F){
        F.submit_button.value="dashboard";
        F.submit_type.value="save_rate";
        F.change_action.value="gozila_cgi";
        F.submit();
}

function split_ipv6_addr(addr,cnt,delim,skip)
{
	if ( addr == "" ) return "";
	var arr = addr.split(delim);
	var new_list="";
	var tmpidx=0;
	for(var i=0; i<arr.length; i++)
	{
		if ( tmpidx == cnt ) 
		{
			new_list+="<BR>";
			tmpidx=0;
		}
		if ( tmpidx > 0 ) new_list += ",";
		if ( typeof skip != 'undefined' ) 
		{
			if ( full_ipv6(arr[i]) == "0000:0000:0000:0000:0000:0000:0000:0001/128" ) 
				continue;
		}
		new_list += full_ipv6(arr[i]);
		tmpidx++;
	}
	return new_list;
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<iframe id=loadstatus height=0 width=0 src="" name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<input type=hidden name=now_idx id=now_idx value=0>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  	<TR><script>draw_td(O_GUI,MAINFUN, __T(router.dashboard),"colspan=2");</script></TR>
  	<TR><TD width=65%>
	<script>
	draw_object(O_GUI,TABLE_BT,"tb_img","ViewRouter()","table_title",__T(router.showpanel));
	</script>
	</TD>
	<TD>
	<TABLE>
		<TR>
		<script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
                <script>
                        var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
                        var _val = new Array("0","15","30","60");
                        draw_object(O_GUI,SELBOX,"fresh_rate","onChange=ToRefresh(this.form)",_name,_val,"<% nvram_get("fresh_rate_dashboard"); %>");</script>

                </script>
                </TD></TR>
	</TABLE>
	</TD>
	</TR>
	<TR id=router_tb style=display:none><TD colspan=2 align=center width=100%>
	<TABLE cellspacing=0 width=398px style='padding:0;border:0;border-collapse:collapse;'>
	<TR>
	<script>
	document.write("<TD colspan=3 style='");
	var top_bg;
	if ( current_model_name == "RV130W" ) 
		top_bg = "background-image:url(image/top.png);height:209px;width:398px;background-repeat:no-repeat";
	else 
		top_bg = "background-image:url(image/top-rv130.png);height:21px;width:398px;background-repeat:no-repeat";
	document.write(top_bg+"'></TD>");
	</script>
	</TR>
	<TR>
	<script>
	if ( current_model_name == "RV130W" ) 
	{
		document.write("<TD style='background-image:url(image/left-1.png);width:76px;height:67px;background-repeat:no-repeat;'></TD>");
		document.write("<TD style='background-image:url(image/left-2.png);width:209px;height:65px;background-repeat:no-repeat;' valign=top>");
	}
	else        
	{
		document.write("<TD style='background-image:url(image/left1-rv130.png);width:79px;height:68px;background-repeat:no-repeat;'></TD>");
		document.write("<TD style='background-image:url(image/left2-rv130.png);width:204px;height:68px;background-repeat:no-repeat;' valign=top>");
	}
	</script>
	<div style='position:absolute;z-index:0;padding-left:8px;padding-top:5px;width:100%;'>
	<TABLE cellspacing=0 style='padding:0;border:0;border-collapse:collapse;'><TR>
	<TD width=28px id=td_lan0 style=padding-right:8px>
	<img id=conn_lan0 src='image/routerPortOn.gif' onMouseMove=sel_iface(0,event) width=28px style=display:none>
	</TD>
	<TD width=28px id=td_lan1 style=padding-right:8px>
	<img id=conn_lan1 src='image/routerPortOn.gif' onMouseMove=sel_iface(1,event) width=28px style=display:none>
	</TD><TD width=28px id=td_lan2 style='padding-right:8px'>
	<img id=conn_lan2 src='image/routerPortOn.gif' onMouseMove=sel_iface(2,event) width=28px style=display:none>
	</TD><TD width=28px id=td_lan3 style='padding-right:23px;'>
	<img id=conn_lan3 src='image/routerPortOn.gif' onMouseMove=sel_iface(3,event) width=28px style=display:none>
	</TD><TD width=67px id=td_wan>
	<img id=conn_wan src='image/routerPortOn.gif'onMouseMove=sel_iface(4,event) width=28px style=display:none>
	</TD></TR></TABLE>
	</div>
	</TD>
	<script>
	if ( current_model_name == "RV130W" ){
		document.write("<TD style='background-image:url(image/left-3.png);width:111px;height:67px;background-repeat:no-repeat;'></TD>");
	}else{
		document.write("<TD style='background-image:url(image/left3-rv130.png);width:114px;height:68px;background-repeat:no-repeat;'></TD>");
	}
	</script>
	</TR>
	</TABLE>
	<div id=divport style="z-index:0;overflow:hidden;position:absolute;cursor:pointer;width:400px;background-color:#ffffff;padding:10px;display:none">
        <TABLE style="width:100%">
        <TR><script>draw_td(O_GUI,MAINFUN, spell_words(lan_port_rule,parseInt(port_num,10)+1),"id=maintitle colspan=2");</script></TR>
        <TR><TD><B><script>CaptureC(router.summary)</script></B></TD><TD align=right><script>draw_object(O_GUI,BT,__T(share.refresh),"a1","BT_NOPADDING","to_refresh(this.form)");</script></TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(share.stype)</script></TD>
        <TD class=SUBCONTENT1>10/100/1000 Base-Tx</TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(share.iface)</script></TD><TD class=SUBCONTENT1 id=iface>LAN</TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(router.linkst)</script></TD><TD class=SUBCONTENT1 id=linkst>Up</TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(router.speedst)</script></TD><TD class=SUBCONTENT1 id=speed>1000Mbps</TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(router.autoneg)</script></TD><TD class=SUBCONTENT1 id=autoneg>Enabled</TD></TR>
        <TR><TD><B><script>CaptureC(wl.statistics)</script></B></TD><TD></TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(router.txframes)</script></TD><TD class=SUBCONTENT1 id=tx>5688</TD></TR>
        <TR><TD class=SUBTITLE1><script>CaptureC(router.rxframes)</script></TD><TD class=SUBCONTENT1 id=rx>4622</TD></TR>
        <TR><TD colspan=2 align=right>
        <script>draw_object(O_GUI,BT,__T(mang.close),"t6","BT_NOPADDING","to_close()");</script>
        </TD></TR>
        </TABLE>
        </div>
	</TD></TR>
	<TR><TD colspan=2>
	<TABLE class=CONTENT_TABLE width=100% valign=top>
	<TR><TD valign=top width=40%><TABLE cellspacing=0 width=100%>
	    <script>
		function AAA(name,val)
		{
			this.name=name;
			this.val=val;
		}
		var data = new Array();
		var data_title = new Array(__T(router.devinfo),__T(router.resourceutil),
//		__T(router.syslogsummary)+"&nbsp;&nbsp;<A class=content_link href='javascript:get_position(\"view_logs.asp\")'>"+__T(share.details)+"</A>&nbsp;&nbsp;&nbsp;&nbsp<A class='content_link' href='javascript:get_position(\"log.asp\");'>"+__T(router.manglog)+"</A>",__T(vpn.sitetositevpn));
		__T(router.syslogsummary)+"&nbsp;&nbsp;<A class=content_link href='javascript:get_position(\"log.asp\");'>"+__T(share.details)+"</A>&nbsp;&nbsp;&nbsp;&nbsp<A class='content_link' href='javascript:get_position(\"view_logs.asp\")'>"+__T(share.viewlog)+"</A>",__T(vpn.sitetositevpn));
		//Format time and date - 12/13/10 06:00 PM
		var current_time = "<% misc_get("get_current_time"); %>";
		var t_data = current_time.split(" "); 
		var date_data = t_data[0].split("/");
		var time_data = t_data[1].split(":");
		var tmp_current_time="";
		if ( flg_24 == 0 ) 
			tmp_current_time = spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1],t_data[2]);
		else{
			var tmp_hour = parseInt(time_data[0],10);
			if ( t_data[2] == "PM" ) 
				tmp_hour += 12;
			else if ( t_data[2] == "AM" && tmp_hour == 12 ) tmp_hour = "00" ;
			tmp_current_time = spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],tmp_hour,time_data[1]);
		
		}
		//alert(date_data+" "+time_data+" "+t_data[2]);
		//End for Format time and date 
		//Format time and date - 0 Days, 1 Hours, 8 Minutes, 2 Seconds
		var sys_time = "<% misc_get("uptime"); %>";
		var tmpdata = sys_time.split(",");
		var newdata = new Array();
		var tmp;
		for(var i=0; i<tmpdata.length; i++)
		{
			tmp = (tmpdata[i].replace(/^\s*/,"")).split(" ");
			newdata[i] = tmp[0];
		}
		var data_0 = new Array();
		data_0[0] = new AAA(__T(router.sysname),"<% nvram_get("wan_hostname"); %>");
		data_0[1] = new AAA(__T(router.fwver),"<% nvram_get("fw_version"); %>");
		data_0[2] = new AAA(__T(router.serialnum),"<% nvram_get("sysinfo_sn");%>");
		var data_1 = new Array();
		data_1[0] = new AAA(__T(router.cpu),"<% nvram_get("cpu_usage"); %>%");
		data_1[1] = new AAA(__T(router.memory),"<% misc_get("mem_usage"); %>% (<% misc_get("usedmem"); %>/<% misc_get("totalmem"); %> "+__T(unit.MB)+")");
		data_1[2] = new AAA(__T(mang.currenttime),tmp_current_time);
		data_1[3] = new AAA(__T(router.sysuptime),spell_words(datetime1_rule,newdata[0],newdata[1],newdata[2],newdata[3]));
		var data_2 = new Array();
		<% get_syslog_ng_detail(); %>
		var def_tunnel=0,en_tunnel=0,conn_tunnel=0,max_tunnel=0,ipsec_user=0;
		<% get_ipsec_vpn_st(); %>
		var data_3 = new Array();
		data_3[0] = new AAA(__T(vpn.numdeftun),def_tunnel);
		data_3[1] = new AAA(__T(vpn.numentun),en_tunnel);
		data_3[2] = new AAA(__T(vpn.numcontun),conn_tunnel);
		data_3[3] = new AAA(__T(vpn.nummaxtun),max_tunnel);

		var tstyle="";
		var logname="";
		var logval="";
		for(var i=0; i<data_title.length; i++)
		{
			if ( ap_mode == "1" && i == data_title.length -1 ) continue;
			if ( i > 0 ) document.write("<TR><TD colspan=2>&nbsp;</TD></TR>");
			document.write("<TR><TD colspan=2><B>");
			document.write(data_title[i]);
			document.write("</B></TD></TR>");
			for(var j=0; j<eval("data_"+i).length; j++)
			{
				logname="";
				logval="";
				if ( j%2 != 0 ) tstyle="TABLECONTENT_S_1";
				else tstyle="TABLECONTENT_TD";

				if ( eval("data_"+i)[j].name == "Emergency" ) logname = __T(syslog.event_emer);
				else if ( eval("data_"+i)[j].name == "Alert" ) logname = __T(syslog.event_alert);
				else if ( eval("data_"+i)[j].name == "Critical" ) logname = __T(syslog.event_crit);
				else if ( eval("data_"+i)[j].name == "Error" ) logname = __T(syslog.event_err);
				else if ( eval("data_"+i)[j].name == "Warning" ) logname = __T(syslog.event_warn);
				else if ( eval("data_"+i)[j].name == "Notification" ) logname = __T(syslog.event_noti);
				else if ( eval("data_"+i)[j].name == "Information" ) logname = __T(syslog.event_info);
				else if ( eval("data_"+i)[j].name == "Debugging" ) logname = __T(syslog.event_debug);
				else logname = eval("data_"+i)[j].name;
				if ( eval("data_"+i)[j].val == "Logging Disabled" ) 
					logval = __T(syslog.dislogging);
				else
					logval = eval("data_"+i)[j].val;
				document.write("<TR class="+tstyle+"><TD>"+logname+":</TD><TD>"+logval+"</TD></TR>");
			}
		}
		
	    </script>	
	    </TABLE></TD>
	    <TD width=20%>&nbsp;</TD>
	    <TD valign=top width=40%><TABLE cellspacing=0 width=100%>
	    <script>
                function AAA(name,val)
                {
                        this.name=name;
                        this.val=val;
                }
                var data = new Array();
		
                var data_title = new Array(
		__T(lan.localnetwork)+"&nbsp;&nbsp;<A class='content_link' href='javascript:get_position(\"lan.asp\")'>"+__T(share.details)+"</a>",
		__T(wan.internetinfo)+"&nbsp;&nbsp;<A class='content_link' href='javascript:get_position(\"wan.asp\")'>"+__T(share.details)+"</A>");
		if ( current_model_name == "RV130W" ) 
		{
			data_title[2] = __T(wl.network)+"&nbsp;&nbsp;<A class='content_link' href='javascript:get_position(\"status_wireless.asp\")'>"+__T(share.details)+"</A>";
		}else
			data_title[2] ="";
		data_title[3] = __T(vpn.ser);
		var lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>";
		var ipv6_lan_info = split_ipv6_addr("<% get_ipv6_info("lan"); %>",1,",");
		var ipv4_lan_info = "<% nvram_get("lan_ipaddr"); %>";
                var data_0 = new Array();
                data_0[0] = new AAA(__T(share.macaddr),"<% nvram_get("lan_hwaddr"); %>");
		if ( lan_ip_mode == "1" )
	                data_0[1] = new AAA(__T(lan.ipv4addr),ipv4_lan_info);
		else if ( lan_ip_mode == "2" )
	                data_0[1] = new AAA(__T(ipv6.addr),ipv6_lan_info);
		else if ( lan_ip_mode == "3" ) 
		{
	                data_0[1] = new AAA(__T(lan.ipv4addr),ipv4_lan_info);
	                data_0[2] = new AAA(__T(ipv6.addr),ipv6_lan_info);
		}
		/* hardcode, always get the information for defalut vlan 1 */
		var lan_proto = "<% nvram_get("lan_proto_1"); %>";
		var tmp = "";
		if ( lan_proto == "dhcp" ) tmp = __T(share.enabled);
		else if ( lan_proto == "static" ) tmp = __T(share.disabled);
		else if ( lan_proto == "dhcprelay" ) tmp = __T(lan.dhcprelay)  
		var lanv6_proto = "<% nvram_get("lan_ipv6_dhcp"); %>";
		var dhcpv6 = "";
		if ( lanv6_proto == "off" ) dhcpv6 = __T(share.disabled);
		else dhcpv6 = __T(share.enabled);
		if ( lan_ip_mode == "1" )
                	data_0[2] = new AAA(__T(lan.dhcpserver),tmp);
		else if ( lan_ip_mode == "2" )
                	data_0[2] = new AAA(__T(lan.dhcpv6server),dhcpv6);
		else if ( lan_ip_mode == "3" ) 
		{
                	data_0[3] = new AAA(__T(lan.dhcpserver),tmp);
                	data_0[4] = new AAA(__T(lan.dhcpv6server),dhcpv6);
		}
		var wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>";
		var ipv6_wan_info = split_ipv6_addr("<% get_ipv6_info("wan"); %>",1,",",1);
		var ipv6_wan_info = "<% get_ipv6_info("wan"); %>";
		var data_1 = new Array();
		var tmp1 = "";
		var tmp2 = __T(router.down);
		if ( wan_ip_mode == "1" || wan_ip_mode == "3" ){
			if ( ((portlist[4] == __T(router.down)) || (wan_link == "0")) && (wwan_up != "1"))
				tmp1 = "";
			else
				tmp1 = "<% nvram_get("wan_real_ipaddr"); %>";
               		data_1[0] = new AAA(__T(lan.ipv4addr),tmp1);
		}
	        if ( wan_ip_mode == "2" || wan_ip_mode == "3" ){
//alert("portlist[4]="+portlist[4]+", wan_link="+wan_link);
			if ( (portlist[4] == __T(router.down)) || (wan_link == "0") )
				tmp1 = "";
			else
				tmp1 = ipv6_wan_info;
			if ( wan_ip_mode == "3" ) 
	               		data_1[1] = new AAA(__T(ipv6.addr),tmp1);
			else
	               		data_1[0] = new AAA(__T(ipv6.addr),tmp1);
		}
		//if ( (portlist[4] != __T(router.down)) && (wan_link != "0") )
		tmp1 = "<% nvram_get("wan_real_ipaddr"); %>";
		if ((wan_link == "1") || ((wwan_up == 1) && (tmp1 != "0.0.0.0")))
			tmp2 = __T(router.up);
		if ( wan_ip_mode == "3" ) 
                	data_1[2] = new AAA(__T(router.state),tmp2);
		else
                	data_1[1] = new AAA(__T(router.state),tmp2);
		if ( current_model_name == "RV130W" ) 
		{
	                var data_2 = new Array();
			<% wl_multi_nvram_get("wl_ssid"); %>
			<% get_wl_bss_is_active(); %>
			var en_val = new Array(__T(share.disabled),__T(router.active));	
			if ( "<% nvram_get("wl_radio"); %>" == "0" ) 
			{
		                data_2[0] = new AAA(nv_wl_ssid_0,en_val[0]);
        		        data_2[1] = new AAA(nv_wl_ssid_1,en_val[0]);
                		data_2[2] = new AAA(nv_wl_ssid_2,en_val[0]);
		                data_2[3] = new AAA(nv_wl_ssid_3,en_val[0]);
			}
			else if(( "<% nvram_get("wl_wds_enable"); %>" == "1" ) && ("<% nvram_get("wl_wds_mode"); %>" == "bridge"))
			{
		                data_2[0] = new AAA(nv_wl_ssid_0,en_val[nv_wl_bss_is_active_0]);
        		        data_2[1] = new AAA(nv_wl_ssid_1,en_val[0]);
                		data_2[2] = new AAA(nv_wl_ssid_2,en_val[0]);
		                data_2[3] = new AAA(nv_wl_ssid_3,en_val[0]);
			}
			else
			{
		                data_2[0] = new AAA(nv_wl_ssid_0,en_val[nv_wl_bss_is_active_0]);
        		        data_2[1] = new AAA(nv_wl_ssid_1,en_val[nv_wl_bss_is_active_1]);
                		data_2[2] = new AAA(nv_wl_ssid_2,en_val[nv_wl_bss_is_active_2]);
	                	data_2[3] = new AAA(nv_wl_ssid_3,en_val[nv_wl_bss_is_active_3]);
			}
		}
                var data_3 = new Array();
		var pptpd_count=0, quickvpn_count=0;
		for(var i=0; i<datalist.length; i++)
		{
			if ( datalist[i][4] == "0" ) 
				pptpd_count++;
			else
				quickvpn_count++;
		}
		data_3[0] = new AAA(__T(vpn.vpnuser),ipsec_user+"/"+10);
		data_3[1] = new AAA(__T(router.pptpusers),pptpd_used+"/"+pptpd_count);
                var tstyle="";
		var initi=0;
                for(var i=0; i<data_title.length; i++)
                {
			if ( current_model_name == "RV130" && i == 2 ) continue; 
			if ( ap_mode == "1" && ( i==0 || i==data_title.length-1) ) continue;
                        if ( initi > 0 ) document.write("<TR><TD colspan=2>&nbsp;</TD></TR>");
                        document.write("<TR><TD colspan=2><B>"+data_title[i]+"</B></TD></TR>");
                        for(var j=0; j<eval("data_"+i).length; j++)
                        {
                                if ( j%2 != 0 ) tstyle="TABLECONTENT_S_1";
                                else tstyle="TABLECONTENT_TD";
				if ( i == 2 ) //FOr FR
	                                document.write("<TR class="+tstyle+"><TD>"+eval("data_"+i)[j].name+" :</TD><TD>"+eval("data_"+i)[j].val+"</TD></TR>");
				else
                                document.write("<TR class="+tstyle+"><TD>"+eval("data_"+i)[j].name+":</TD><TD>"+eval("data_"+i)[j].val+"</TD></TR>");
                        }
			initi++;
                }
            </script>    
	    </TABLE></TD></TR>
	</TABLE>
	</TD></TR>
	<script>chg_layout();</script>
</TABLE>
</form>
</div></TABLE></TD></TR>
</body></HTML>
