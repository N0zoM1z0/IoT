<html>
<head>
<title>Getting Started</title>
<% show_status("init"); %>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_security_mode"); %>
var pptpd_used,quickvpn_used;
<% get_pptpd_user(); %>

var datalist = new Array();
<% get_vpn_account_data(); %>

var portlist = new Array();
<% get_port_st("portlist"); %>
var wan_link = "<% misc_get("wan_link"); %>";
var wwan_up = "<% nvram_get("wwan_in_used"); %>";
var wan_dns0 = "<% nvram_status_get("wan_dns0"); %>";
var wan_dns1 = "<% nvram_status_get("wan_dns1"); %>";
var lan_ip_mode="<% nvram_get("lan_ip_mode"); %>";
var wan_ip_mode="<% nvram_get("wan_ip_mode"); %>";

var access_point="<% nvram_get("access_point_enable"); %>";

var pptpd_count=0, quickvpn_count=0;
for(var i=0; i<datalist.length; i++)
{
	if ( datalist[i][4] == "0" )
        	pptpd_count++;
        else
                quickvpn_count++;
}

function systime()
{
	var sys_time = "<% misc_get("uptime"); %>";
        var tmpdata = sys_time.split(",");
        var newdata = new Array();
        var tmp;
        for(var i=0; i<tmpdata.length; i++)
        {
        	tmp = (tmpdata[i].replace(/^\s*/,"")).split(" ");
                newdata[i] = tmp[0];
        }
	document.write(spell_words(datetime1_rule,newdata[0],newdata[1],newdata[2],newdata[3]));

}

function get_local()
{
	var lang = "<% nvram_get("language"); %>";
	var tmp = "";
	if ( lang == "EN" ) 
		tmp = "en-US";
	else if ( lang == "FR" ) 
		tmp = "fr-FR";
	else if ( lang == "IT" ) 
		tmp = "it-IT";
	else if ( lang == "SP" ) 
		tmp = "es-ES";
	else if ( lang == "DE" ) 
		tmp = "de-DE";
	document.write(tmp);
}

function localtime()
{
	var current_time = "<% misc_get("get_current_time"); %>";
        var t_data = current_time.split(" "); 
        var date_data = t_data[0].split("/");
        var time_data = t_data[1].split(":");
	if ( flg_24 == 0 ) 
	{
		document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1],t_data[2]));
	}else{
		var tmp_hour = parseInt(time_data[0],10);
		if ( t_data[2] == "PM" ) tmp_hour+=12;
		document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],tmp_hour,time_data[1]));
	}
}
function wl_security(wl_sec)
{
	var smode_val = new Array("disabled","wep","wpa_personal","wpa_enterprise","wpa2_personal","wpa2_personal_mixed","wpa2_enterprise","wpa2_enterprise_mixed");
        var smode_name = new Array(__T(share.disabled),__T(wl.wep),__T(wl.wpap),__T(wl.wpae),__T(wl.wpa2p),__T(wl.wpa2mixed),__T(wl.wpa2e),__T(wl.wpa2emixed));
	for(var k=0; k<smode_val.length; k++)
	{
		if ( smode_val[k] == wl_sec)
		{
			document.write(smode_name[k]);
			break;
		}
	}
}
function init(){
	var F = document.setup;
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("t5"));
		choose_disable(document.getElementById("t6"));
	}
	if ( current_model_name == "RV130" ) 
	{
		HIDDEN_PART("TR","wl_start","wl_end",1);
	}
	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
}

function reload(){
	goto_page("system.asp");
}

function split_ipv6_addr(addr,cnt,delim)
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
                new_list += full_ipv6(arr[i]);
                tmpidx++;
        }
        return new_list;
}

function dhcp_release(F)
{
	F.submit_button.value = "system";
	F.submit_type.value = "release";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function dhcp_renew(F)
{
	F.submit_button.value = "system";
	F.submit_type.value = "renew";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function wan_disconnect(F)
{
	var wan_proto = "<% nvram_get("wan_proto"); %>";
	F.submit_button.value = "system";
	if ( wan_proto == "pppoe" ) 
		F.submit_type.value = "disconnect_pppoe";
	else if ( wan_proto == "l2tp" ) 
		F.submit_type.value = "disconnect_l2tp";
	else //pptp
		F.submit_type.value = "disconnect_pptp";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function wan_connect(F)
{
	var wan_proto = "<% nvram_get("wan_proto"); %>";
	F.submit_button.value = "system";
	if ( wan_proto == "pppoe" ) 
		F.submit_type.value = "connect_pppoe";
	else if ( wan_proto == "l2tp" ) 
		F.submit_type.value = "connect_l2tp";
	else //pptp
		F.submit_type.value = "connect_pptp";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function ToRefresh(F)
{
        F.submit_button.value="system";
        F.submit_type.value="save_rate";
        F.change_action.value="gozila_cgi";
        F.submit();
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<div class=content_layer id=divcontent><TABLE class=CONTENT_TABLE border=0>
<!--  <col width=150px><col width=300px><col width=150px><col width=200px>-->
  <col width=150px><col width=300px><col width=150px><col width=80px><col width=120px>
  <TR><TD class=CONTENT_TITLE colspan=3><script>Capture(g_start.sys_summary);</script></TD><TD colspan=2 align=right>
  <script>
  //document.write("<input type=button class=BT value="+__T(share.refresh)+" id=t4 onMouseover=bt('t4','move') onMouseout=bt('t4','out') onMousedown=bt('t4','down') onclick='javascript:document.location.href=goto_link(\"system.asp\")'>");
  </script>
  <TABLE>
                <TR>
                <script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
                <script>
                        var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
                        var _val = new Array("0","15","30","60");
                        draw_object(O_GUI,SELBOX,"fresh_rate","onChange=ToRefresh(this.form)",_name,_val,"<% nvram_get("fresh_rate_system"); %>");</script>

                </script>
                </TD></TR>
        </TABLE>
  </TD></TR>
  <TR><TD class=MI_TOP_TITLE colspan=1><B><script>Capture(router.sysinfo);</script></B></TD></TR>
  <TR>
			<TD class=MI_TITLE_1><script>CaptureC(router.fwver);</script></TD><TD class=MI_TITLE_1><% nvram_get("fw_version"); %></TD>
      <TD class=MI_TITLE_2><script>CaptureC(router.cpumodel);</script></TD><TD class=MI_TITLE_1 colspan=2>Cavium CNS3410</TD>
	</TR>
  <TR>
			<TD class=MI_TITLE_1><script>CaptureC(router.fwmd5chksum);</script></TD><TD class=MI_TITLE_1><% misc_get("fw_md5sum"); %></TD>
      <TD class=MI_TITLE_2><script>CaptureC(router.serialnum);</script></TD><TD class=MI_TITLE_1 colspan=2><% nvram_get("sysinfo_sn"); %></TD>
	</TR>
  <TR>
			<TD class=MI_TITLE_1><script>CaptureC(router.locale);</script></TD><TD class=MI_TITLE_1><script>get_local();</script></TD>
      <TD class=MI_TITLE_2><script>CaptureC(router.sysuptime);</script></TD><TD class=MI_TITLE_1 colspan=2><script>systime();</script></TD>
	</TR>
  <TR>
			<TD class=MI_TITLE_1><script>CaptureC(router.langver);</script></TD><TD class=MI_TITLE_1><script>document.write("<% get_lang_ver("current_lang_version"); %>");</script></TD>
      <TD class=MI_TITLE_2><script>CaptureC(mang.currenttime);</script></TD><TD class=MI_TITLE_1 colspan=2><script>localtime();</script></TD>
	</TR>
  <TR>
			<TD class=MI_TITLE_1><script>CaptureC(router.md5lang);</script></TD><TD class=MI_TITLE_1><% misc_get("lang_md5sum"); %></TD>
      <TD class=MI_TITLE_2><script>CaptureC(router.pidvid);</script></TD><TD class=MI_TITLE_1 colspan=2><% nvram_get("dev_pid_short"); %>&nbsp;<% nvram_get("sysinfo_vid"); %></TD>
</TR>
 <TR><script>draw_td(O_GUI,ISHR,"colspan=5");</script></TR>
 <TR><TD class=MI_TOP_TITLE colspan=5><script>Capture(router.ipv4config);</script></TD></TR>
 <script>
 if ( ap_mode != "1" ) 
 {
	document.write("<TR><TD class=MI_TITLE_1><a href='javascript:get_position(\"lan.asp\")' class=content_link>"+__TC(router.lanip)+"</a></TD><TD class=MI_TITLE_1><% nvram_get("lan_ipaddr_1"); %></TD>");
 	document.write("<TD class=MI_TITLE_1><a href='javascript:get_position(\"lan.asp\")' class=content_link>"+__TC(router.dns1)+"</a></TD><TD class=MI_TITLE_1 colspan=2>"+wan_dns0+"</TD></TR>");
 }
 </script>
  <TR>
 <TD class=MI_TITLE_1><a href='javascript:get_position("wan.asp")' class='content_link'><script>
Capture(wan.wanip);</script>:</a></TD><TD class=MI_TITLE_1>
<script>
	if (ap_mode == "1")
		var wan_real_proto = "<% nvram_get("ap_wan_proto"); %>";
	else
		var wan_real_proto = "<% nvram_get("wan_proto"); %>";
if (( portlist[4] != "Down" && wan_link != "0" && wan_ip_mode != "2") || wwan_up == "1") 
	document.write("<% nvram_get("wan_real_ipaddr"); %>&nbsp;");
if ( wan_ip_mode != "2" && wan_real_proto == "dhcp" && wwan_up != "1" ) 
{
        document.write("<input type=button class=BT value='"+__T(wan.dhcprelease)+"' id=t5 onMouseover=bt('t5','move') onMouseout=bt('t5','out') onMousedown=bt('t5','down') onclick='dhcp_release(this.form)'><SPAN style=padding-left:5px>");
        document.write("<input type=button class=BT value='"+__T(wan.dhcprenew)+"' id=t6 onMouseover=bt('t6','move') onMouseout=bt('t6','out') onMousedown=bt('t6','down') onclick='dhcp_renew(this.form)'>");
} 
else if ( wan_ip_mode != "2" && wan_real_proto != "static" && wwan_up != "1") 
{
	if(wan_link == "0") //connect, disconnect gray out
	{
       		document.write("<input type=button class=BT_DISABLE value='"+__T(share.disconnect)+"' id=t5><SPAN style=padding-left:5px>");
        	document.write("<input type=button class=BT value='"+__T(share.connect)+"' id=t6 onMouseover=bt('t6','move') onMouseout=bt('t6','out') onMousedown=bt('t6','down') onclick='wan_connect(this.form)'>");
	}
	else
	{
       		document.write("<input type=button class=BT value='"+__T(share.disconnect)+"' id=t5 onMouseover=bt('t5','move') onMouseout=bt('t5','out') onMousedown=bt('t5','down') onclick='wan_disconnect(this.form)'><SPAN style=padding-left:5px>");
        	document.write("<input type=button class=BT_DISABLE value='"+__T(share.connect)+"' id=t6>");
	}
} 
</script></TD>
 <TD class=MI_TITLE_1><a href='javascript:get_position("wan.asp")' class=content_link>
 <script>
	if ( ap_mode == "1" ) 
		Capture(router.dns1);
	else
		Capture(router.dns2);
 </script>:</a></TD><TD class=MI_TITLE_1 colspan=2>
 <script>
	if ( ap_mode == "1" ) document.write(wan_dns0);
	else document.write(wan_dns1);
 </script>
 </TD>
  </TR>
  <TR>
 <TD class=MI_TITLE_1><a href='javascript:get_position("wan.asp")' class=content_link><script>Capture(wan.gw);</script>:</a></TD><TD class=MI_TITLE_1><script>if ( wan_ip_mode != "2" && (wan_link == "1" || wwan_up == "1")) document.write("<% nvram_get("wan_real_gateway"); %>");</script></TD>
 <TD class=MI_TITLE_1>
 <script>
	if ( ap_mode == "1" ) 
	{
		document.write("<a href='javascript:get_position(\"wan.asp\")' class=content_link>"+__TC(router.dns2)+"</a></TD><TD class=MI_TITLE_1 colspan=2>"+wan_dns1+"</TD>");
	}else{
//		document.write("<a href='javascript:get_position(\"ddns.asp\")' style='text-decoration:underline'>"+__TC(router.ddns)+"</a></TD><TD class=MI_TITLE_1>"+<% nvram_else_match("ddns_enable", "0", "__T(share.off)", "__T(share.on)"); %>);
		document.write("<a href='javascript:get_position(\"ddns.asp\")' class=content_link>"+__TC(router.ddns)+"</a></TD><td>"+__T(router.ddns1)+"</TD><TD class=MI_TITLE_1>"+<% nvram_else_match("ddns_enable_1", "0", "__T(share.off)", "__T(share.on)"); %>);
	}
 </script></TD>
  </TR>
  <TR>
	<script>
	if(access_point != "1")
		document.write("<TD class=MI_TITLE_1><a href='javascript:get_position(\"routing.asp\")' class=content_link>"+__TC(router.mode)+"</a></TD><TD class=MI_TITLE_1>"+<% nvram_else_match("wk_mode", "gateway"," __T(share.gateway)", "__T(share.router)"); %>+"</TD>");
	else
		document.write("<TD class=MI_TITLE_1>&nbsp;</TD><TD class=MI_TITLE_1>&nbsp;</TD>");
		document.write("<TD>&nbsp;</TD><td>"+__T(router.ddns2)+"</TD><TD class=MI_TITLE_1>"+<% nvram_else_match("ddns_enable_2", "0", "__T(share.off)", "__T(share.on)"); %>);
	</script>
 <TD class=MI_TITLE_1></TD><TD class=MI_TITLE_1></TD>
  </TR>
<script>
document.write("<TR>");
document.write("<TD class=MI_TITLE_1>&nbsp;</TD><TD class=MI_TITLE_1>&nbsp;</TD>");
document.write("<TD>&nbsp;</TD><td>"+__T(router.ddns3)+"</TD><TD class=MI_TITLE_1>"+<% nvram_else_match("ddns_enable_3", "0", "__T(share.off)", "__T(share.on)"); %>);
document.write("</TR>");
</script>
<script>
document.write("<TR>");
		document.write("<TD class=MI_TITLE_1>&nbsp;</TD><TD class=MI_TITLE_1>&nbsp;</TD>");
document.write("<TD>&nbsp;</TD><td>"+__T(router.ddns4)+"</TD><TD class=MI_TITLE_1>"+<% nvram_else_match("ddns_enable_4", "0", "__T(share.off)", "__T(share.on)"); %>);
document.write("</TR>");
</script>
<script>
if ( lan_ip_mode != "1" || wan_ip_mode != "1" )
{ 
 	document.write("<TR>");
	draw_td(O_GUI,ISHR,"colspan=5");
	document.write("</TR>");
	document.write("<TR><TD class=MI_TOP_TITLE colspan=5>"+__T(ipv6.config)+"</TD></TR>");
	/*
	var tmp = "<% nvram_get("wan_ipv6_dns"); %>".split(" ");
        var wan_ipv6_dns0 = "";
        var wan_ipv6_dns1 = "";
        if ( tmp.length == 2 ) 
        {*/
	if ( ap_mode == "0" ) 
	{
  		var wan_ipv6_dns0 = "<% nvram_get("wan_ipv6_dns_primary"); %>";
	        var wan_ipv6_dns1 = "<% nvram_get("wan_ipv6_dns_secondary"); %>";
	}else{
  		var wan_ipv6_dns0 = "<% nvram_get("ap_wan_ipv6_dns_primary"); %>";
	        var wan_ipv6_dns1 = "<% nvram_get("ap_wan_ipv6_dns_secondary"); %>";
	}
        //}
	if ( ap_mode != "1" ) 
	{
		document.write("<TR><TD class=MI_TITLE_1>");
		if ( lan_ip_mode != "1" )  
			document.write("<a href='javascript:get_position(\"lan_ipv6.asp\")' class=content_link>"+__T(router.lanip)+":</a>");
		document.write("</TD><TD class=MI_TITLE_1>");
		if ( lan_ip_mode != "1" )  
			document.write("<% get_ipv6_info("lan"); %>");
		document.write("</TD>");
	  	document.write("<TD class=MI_TITLE_1><a href='javascript:get_position(\"lan_ipv6.asp\")' class=content_link>"+__T(router.dns1)+":</a></TD><TD class=MI_TITLE_1 colspan=2>"+wan_ipv6_dns0+"</TD>");
		document.write("</TR>");
	}
	document.write("<TR>");
	document.write("<TD class=MI_TITLE_1>");
	document.write("<a href='javascript:get_position(\"wan_ipv6.asp\")' class=content_link>"+__T(wan.wanip)+":</a>");
	document.write("</TD><TD class=MI_TITLE_1>");
	if ( portlist[4] != "Down" ) document.write("<% get_ipv6_info("wan"); %>");
	document.write("</TD>");
  	document.write("<TD class=MI_TITLE_1><a href='javascript:get_position(\"lan_ipv6.asp\")' class=content_link>");
	if ( ap_mode == "1" )
		Capture(router.dns1);
	else
		Capture(router.dns2)
	document.write(":</a></TD><TD class=MI_TITLE_1 colspan=2>");
	if ( ap_mode == "1" )
		document.write(wan_ipv6_dns0);
	else
		document.write(wan_ipv6_dns1);
	document.write("</TD></TR>");
	document.write("<TR>");
	document.write("<TD class=MI_TITLE_1>");
	document.write("<a href='javascript:get_position(\"wan_ipv6.asp\")' class=content_link>"+__T(wan.gw)+":</a>");
	if ( ap_mode == "0" ) 
	{
		document.write("</TD><TD class=MI_TITLE_1>");
    if ( wan_ip_mode != "1" )
      document.write("<% nvram_get("wan_ipv6_gateway"); %>");
    document.write("</TD>");
//		document.write("</TD><TD class=MI_TITLE_1><% nvram_get("wan_ipv6_gateway"); %></TD>");
	}
	else
	{
		document.write("</TD><TD class=MI_TITLE_1><% nvram_get("ap_wan_ipv6_gateway"); %></TD>");
	}
	/*IPv6 Gateway -*/
	/*IPv6 PD +*/
	if ( ap_mode == "0" )
	{ 
	  	document.write("<TD class=MI_TITLE_1>"+__T(ipv6.pd)+":</TD><TD class=MI_TITLE_1 colspan=2>");
		if ( wan_ip_mode != "1" ) document.write(split_ipv6_addr("<% nvram_get("ipv6_dhcpc_pd_prefix"); %>",1,","));
		document.write("</TD>");
	}else{
  		document.write("<TD class=MI_TITLE_1><a href='javascript:get_position(\"lan_ipv6.asp\")' class=content_link>"+__TC(router.dns2)+"</TD><TD class=MI_TITLE_1 colspan=2>"+wan_ipv6_dns1+"</TD>");
	
	}
	document.write("</TR>");
	/*IPv6 PD -*/
}
</script>
</TD>
  </TR>
 <TR id=wl_start><script>draw_td(O_GUI,ISHR,"colspan=5");</script></TR>
  <TR><TD class=MI_TOP_TITLE colspan=5><script>Capture(router.wlsummary);</script></TD>
  <TR><TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(router.ssid1);</script></a></TD><TD class=MI_TITLE_1><script>document.write(nv_wl_ssid_0);</script></TD>	
  <TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(wl.security);</script></a></TD><TD class=MI_TITLE_1 colspan=2><script>wl_security(nv_wl_security_mode_0);</script></TD></TR>   
  <TR><TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(router.ssid2);</script></a></TD><TD class=MI_TITLE_1><script>document.write(nv_wl_ssid_1);</script></TD>	
  <TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(wl.security);</script></a></TD><TD class=MI_TITLE_1 colspan=2><script>wl_security(nv_wl_security_mode_1);</script></TD></TR>   
  <TR><TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(router.ssid3);</script></a></TD><TD class=MI_TITLE_1><script>document.write(nv_wl_ssid_2);</script></TD>	
  <TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(wl.security);</script></a></TD><TD class=MI_TITLE_1 colspan=2><script>wl_security(nv_wl_security_mode_2);</script></TD></TR>   
  <TR><TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(router.ssid4);</script></a></TD><TD class=MI_TITLE_1><script>document.write(nv_wl_ssid_3);</script></TD>	
  <TD class=MI_TITLE_1><a href='javascript:get_position("Wireless_Manual.asp")' class=content_link><script>CaptureC(wl.security);</script></a></TD><TD class=MI_TITLE_1 colspan=2><script>wl_security(nv_wl_security_mode_3);</script></TD></TR>   
  <TR id=wl_end></TR>
 <script>
 if ( ap_mode != "1" ) 
 {
var def_tunnel=0,en_tunnel=0,conn_tunnel=0,max_tunnel=0,ipsec_user=0;
<% get_ipsec_vpn_st(); %>
 	document.write("<TR>"+draw_td(O_VAR,ISHR,"colspan=5")+"</TR>");
	document.write("<TR><TD class=MI_TOP_TITLE colspan=2>"+__T(router.firewallsetst)+"</TD>");
	document.write("<TD class=MI_TOP_TITLE colspan=3>"+__T(router.vpnsersetst)+"</TD></TR>");
  	document.write("<TR><TD class=MI_TITLE_1><a href='javascript:get_position(\"firewall.asp\")' class=content_link>"+__TC(router.dos)+"</a></TD><TD class=MI_TITLE_1>");
	 var dos_protection = "<% nvram_get("dos_protection"); %>";
	 if ( dos_protection == "1" ) Capture(share.on);
	 else Capture(share.off);
 	document.write("</TD>");
//	document.write("<TD class=MI_TITLE_1 colspan=2><a href='javascript:get_position(\"vpn_client.asp\")' style='text-decoration:underline;padding-right:15px'>"+__TC(router.ipsecvpnconns)+"</a>"+__T(quickvpn_count)+"</TD></TR>");
	document.write("<TD class=MI_TITLE_1 colspan=3><a href='javascript:get_position(\"ipsec_user.asp\")' class=content_link>"+__TC(router.ipsecvpnconns)+"</a><span style='padding-left:5px'>10</span></TD></TR>");
  	document.write("<TR><TD class=MI_TITLE_1><a href='javascript:get_position(\"firewall.asp\")' class=content_link>"+__TC(filter.blockwan)+"</a></TD><TD class=MI_TITLE_1>");
	var block_wan = "<% nvram_get("block_wan"); %>";	
	if ( block_wan == "1" ) Capture(share.on);
	else Capture(share.off);
	document.write("</TD>");
//  	document.write("<TD class=MI_TITLE_1 colspan=2><a href='javascript:get_position(\"vpn_client.asp\")' style='text-decoration:underline'>"+__TC(router.pptpvpnconns)+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"+pptpd_count+"</TD></TR>");
  	document.write("<TD class=MI_TITLE_1 colspan=3><a href='javascript:get_position(\"vpn_client.asp\")' class=content_link>"+__TC(router.pptpvpnconns)+"</a><span style='padding-left:13px'>"+pptpd_count+"</span></TD></TR>");
  	document.write("<TR><TD class=MI_TITLE_1><a href='javascript:get_position(\"firewall.asp\")' class=content_link>"+__TC(filter.remotemang)+"</a></TD><TD class=MI_TITLE_1>");
	var remote_management = "<% nvram_get("remote_management");%>";
	if ( remote_management == "1" ) Capture(share.on);
        else Capture(share.off);
//	document.write("</TD><TD class=MI_TITLE_1 colspan=2><a href='javascript:get_position(\"vpn_client.asp\")' style='text-decoration:underline;padding-right:39px'>"+__TC(router.connectedipsecuser)+"</a>"+quickvpn_used+"</TD></TR>");
	document.write("</TD><TD class=MI_TITLE_1 colspan=3><a href='javascript:get_position(\"ipsec_user.asp\")' class=content_link>"+__TC(router.connectedipsecuser)+"</a><span style='padding-left:39px'>"+ipsec_user+"</span></TD></TR>");
//	document.write("<TR><TD class=MI_TITLE_1></TD><TD class=MI_TITLE_1></TD><TD class=MI_TITLE_1 colspan=2><a href='javascript:get_position(\"vpn_client.asp\")' style='text-decoration:underline'>"+__TC(router.connectpptpuser)+"</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+pptpd_used+"</TD></TR>");
	document.write("<TR><TD class=MI_TITLE_1></TD><TD class=MI_TITLE_1></TD><TD class=MI_TITLE_1 colspan=3><a href='javascript:get_position(\"vpn_client.asp\")' class=content_link>"+__TC(router.connectpptpuser)+"</a><span style='padding-left:39px'>"+pptpd_used+"</span></TD></TR>");
}
</script>
   
<script>chg_layout();</script> 
</TABLE>
</div>
</body></HTML>
