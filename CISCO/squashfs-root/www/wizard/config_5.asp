<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
<% web_include_file("encode_data.js"); %>
var mac_clone="1";
function init()
{
	var F = document.wz_cfg;
	var mac = parse_data("def_hwaddr");
	if ( mac == "" ) mac = "<% nvram_get("get_mac"); %>";
	var mac_en = parse_data("mac_clone_enable");
	var dut_mac = "<% nvram_get("wan_hwaddr"); %>";
	var http_client_mac = "<% nvram_get("http_client_mac"); %>";
	choose_disable(F.set_mac);
	//alert("mac_type="+mac_type+";dut_mac="+dut_mac+";http_client_mac="+http_client_mac);
	if ( mac_en == "0" ) 
	{
		F.mac_type[0].checked = true;
		F.set_mac.value = str_replace("-",":",dut_mac);
	}
	else{
		if ( mac == http_client_mac ) 
			F.mac_type[1].checked = true;
		else{
			F.mac_type[2].checked = true;
			choose_enable(F.set_mac);
		}
		F.set_mac.value = str_replace("-",":",mac);
	}
	def_nv = keep_val(F,""); 
}

function check_mac_val(F)
{
	mac_clone="1";
	w_clear_alert("_hwaddr",0,"set_mac");
	if ( F.mac_type[0].checked )
	{
		http_client_mac = "<% nvram_get("wan_hwaddr"); %>";
		mac_clone="0";
	}
	else if ( F.mac_type[1].checked )
		http_client_mac = "<% nvram_get("http_client_mac"); %>";
	else
	{
		var errmsg = "";
		http_client_mac = mac12to17(F.set_mac.value);
//		var client_mac = str_replace(":","",http_client_mac);
		errmsg = valid_macs_all(http_client_mac);
		if(errmsg != ""){
			w_set_alert("_hwaddr",0,"set_mac",errmsg);
			return false;
		}
		
	}
	return true;
}

function goto_next(F)
{
	var http_client_mac = "";
	if ( !check_mac_val(F) ) return;
	http_client_mac = mac12to17(F.set_mac.value);
	save_data("def_hwaddr",str_replace(":","-",http_client_mac));
	save_data("mac_clone_enable",mac_clone);
	set_wan_nv(F);
	F.submit_button.value = "wizard/submit_1";
	//F.action = goto_link(F.action);
        F.submit();
	choose_disable(document.getElementById("w2"));
}

function set_wan_nv(F)
{
        var nv_list = new Array("wan_proto","time_zone","ntp_mode","ntp_manual_time","def_hwaddr","mac_clone_enable");
        var ppp_nv = new Array("ppp_username","ppp_passwd");
        var ip_nv = new Array("wan_ipaddr","wan_netmask","wan_gateway","wan_dns");
        var server_nv = new Array("pptp_server_ip","l2tp_server_ip");
        var total_nv = new Array(nv_list,ppp_nv,ip_nv,server_nv);
        var wan_type = "";
        for(var i=0; i<nv_list.length; i++)
        {
                var tmp = parse_data(nv_list[i]);
                if ( nv_list[i] == "wan_proto" ) wan_type = tmp;
                if ( nv_list[i] == "def_hwaddr")
                {
                        var data = tmp.split("-");
                        for(var j=0; j<data.length; j++)
			{
                                eval("F.def_hwaddr_"+j).value = data[j];
			}
                }else{
                        if ( tmp != "" ) 
                                eval("F."+nv_list[i]).value = tmp;      
                }
        }
        if ( wan_type == "static" || wan_type == "pptp" || wan_type == "l2tp") 
        {
                var dns="";
                for(var i=0; i<ip_nv.length; i++)
                {
                        var tmp = parse_data(ip_nv[i]);
                        if ( ip_nv[i] == "wan_dns" ) 
                        {
                                var data = tmp.split(" ");
                                for(var j=0; j<data.length; j++)
                                {
                                        if ( dns != "" ) dns+=" ";
                                        if ( data[j] != "..." ) 
                                                dns += data[j];
                                }
				if ( wan_type != "static" ) choose_disable(F.wan_static_dns_mode);
				if ( wan_type == "dhcp" ||
				     wan_type == "l2tp" ||
				     wan_type == "pptp" ){
					F.wan_primary_dns.value = data[0];
					F.wan_secondary_dns.value = data[1];
					choose_disable(F.wan_dns);
				}
				if ( wan_type == "static" ) 
				{
					F.wan_dns.value = dns;
					choose_disable(F.wan_primary_dns);
					choose_disable(F.wan_secondary_dns);
				}
                                //eval("F."+ip_nv[i]).value = dns;
                        }else if ( tmp != "..." ) 
                                eval("F."+ip_nv[i]).value = tmp;
                }
        }
        if ( wan_type == "pppoe" || wan_type == "pptp" || wan_type == "l2tp"){
                for(var i=0; i<ppp_nv.length; i++)
                {
                        var tmp = parse_data(ppp_nv[i]);
                        if ( tmp != "" ) 
			{
				if ( ppp_nv[i] == "ppp_passwd" ) 
	                                eval("F."+ppp_nv[i]).value = encode_data(tmp);                       
				else
	                                eval("F."+ppp_nv[i]).value = tmp;                       
			}
                }
        }
        if ( wan_type == "pptp" )
        {
                var server = parse_data("pptp_server_ip");      
                if ( server != "" ) 
                F.pptp_server_ip.value = server;
        }
        if ( wan_type == "l2tp" ){
                var server = parse_data("l2tp_server_ip");      
                if ( server != "" ) 
                F.l2tp_server_ip.value = server;
        }
	if ( wan_type == "pppoe" )
	{
		F.wizard_pppoe_pname.value =  parse_data("ppp_username");
	}else
		choose_disable(F.wizard_pppoe_pname);

        // Disabled the hidden if unused.
        for(var i=0; i<total_nv.length; i++)
        {
                for(var j=0; j<total_nv[i].length; j++)
                {
                        if ( total_nv[i][j] == "def_hwaddr" ) 
                        {
                                if ( eval("F."+total_nv[i][j]+"_0").value == "" ) 
                                {
                                        for(var k=0; k<6; k++)
                                                choose_disable(eval("F."+total_nv[i][j]+"_"+k));
                                }
                                
                        }else{
                                if ( eval("F."+total_nv[i][j]).value == "" ) 
                                        choose_disable(eval("F."+total_nv[i][j]));
                        }
		}
	}

}

function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv) ) 
                my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
        else 
                alert_result_GUI(1);
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
	{
		var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
		go_page(aging_time,"<% nvram_get("getting_start"); %>");
	}
}

function sel_mac_type(val)
{
	var F = document.wz_cfg;
   if ( val == 2 ) 
	choose_enable(F.set_mac);
   else
	choose_disable(F.set_mac);
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_cfg" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=wizard_start>

<input type=hidden name=wan_proto>
<input type=hidden name=time_zone>
<input type=hidden name=ntp_mode>
<input type=hidden name=ntp_manual_time>
<input type=hidden name=def_hwaddr value=6>
<input type=hidden name=def_hwaddr_0>
<input type=hidden name=def_hwaddr_1>
<input type=hidden name=def_hwaddr_2>
<input type=hidden name=def_hwaddr_3>
<input type=hidden name=def_hwaddr_4>
<input type=hidden name=def_hwaddr_5>
<input type=hidden name=wan_ipaddr>
<input type=hidden name=wan_netmask>
<input type=hidden name=wan_gateway>
<input type=hidden name=wan_dns>
<input type=hidden name=wan_primary_dns>
<input type=hidden name=wan_secondary_dns>
<input type=hidden name=wan_static_dns_mode value=2>
<input type=hidden name=wizard_pppoe_pname>
<input type=hidden name=ppp_username>
<input type=hidden name=ppp_passwd>
<input type=hidden name=mac_clone_enable>
<input type=hidden name=l2tp_server_ip>
<input type=hidden name=pptp_server_ip>

<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(2,3);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.descstep4of4_1);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.descstep4of4_2);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.descstep4of4_3);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM2>
    <input type=radio name=mac_type value=0 checked onclick=sel_mac_type(0)><script>Capture(wz.usedefaddr);</script><BR>
    <input type=radio name=mac_type value=1 onclick=sel_mac_type(1)><script>Capture(wz.usecomaddr);</script><BR>
    <input type=radio name=mac_type value=2 onclick=sel_mac_type(2)><script>Capture(wz.usethisaddr);</script>: <input value="<% nvram_get("get_mac"); %>" id=set_mac name=set_mac onblur=check_mac_val(this.form)>
    <span id=_hwaddr></span>
    </TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>
    if ( http_power == "r" )
    	Capture(wz.clicknext1);
    else
    	Capture(wz.clicksubmit1);
    </script></TD></TR> 
    </TABLE></TD></TR>
    <script>
    if ( http_power == "r" )
	create_button("onClick=document.location.href=goto_link(\"config_4.asp\")","onClick=document.location.href=goto_link(\"sec_1.asp\")","");
    else
	create_button("onClick=document.location.href=goto_link(\"config_4.asp\")","","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
