<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_guide()
{
	if ( Browser == "IE" ) 
		HelpDialog(goto_link("guide.asp"),188,410);
	else
		HelpDialog(goto_link("guide.asp"),168,410);
	//window.showModalDialog(goto_link('guide.asp'),'WizardHelp','dialogLeft:450px;dialogTop:200px;resizable:no;status:no; scroll:no;dialogWidth:430px;dialogHeight:168px;center:yes;');
	
}

function goto_next(F)
{
 	choose_disable(document.getElementById("w2"));
 	choose_disable(document.getElementById("w3"));
	if ( http_power == "rw" )
	{
		F.wizard_start.value="1";
	        if ( F.startup.checked )
        	        F.wizard_start.value = "0";
	        if ( "<% nvram_get("getting_wizard");%>" != F.wizard_start.value ) 
        	{
	                F.change_action.value="gozila_cgi";
        	        F.submit_button.value = "wizard/conn_1";
                	F.submit();
		}else
			setTimeout('redirect_page()',1000);
	}else
		setTimeout('redirect_page()',1000);
}

function redirect_page()
{
	document.location.href=goto_link("conn_1.asp");
}

function uiDoCancel(F)
{
	alert_result_GUI(1);
	/*
	if ( http_power == "r" )
		alert_result_GUI(1);
	else
	{
		change_nv = keep_val(F,"");
		if ( !wizard_before_leave(change_nv,def_nv) ) 
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
		else 
			alert_result_GUI(1);
	}*/
}

function alert_result_GUI(val)
{	
	var F = document.wz_welcome;
	alert_result(0);
	if ( val == 1 ) 
	{ 
		var getting_start = "<% nvram_get("getting_start"); %>";
 		choose_disable(document.getElementById("w2"));
	 	choose_disable(document.getElementById("w3"));
		F.wizard_start.value="1";
	        if ( F.startup.checked )
        	        F.wizard_start.value = "0";
		if ( ("<% nvram_get("getting_wizard");%>" != F.wizard_start.value) ) 
		{
        		F.change_action.value="gozila_cgi";
		        F.submit_button.value = "wizard/index";
        		F.submit();
		}else{
			var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
			go_page(aging_time,"<% nvram_get("getting_start"); %>");
		}
	}
}

function init()
{
 	choose_disable(document.getElementById("w1"));
	// Load nvram value 
	var wan_proto="<% nvram_get("wan_proto"); %>";
	if ( wan_proto != "" ) save_data("wan_proto", wan_proto,1);
	var time_zone="<% nvram_get("time_zone"); %>";
	if ( time_zone != "" ) save_data("time_zone", time_zone,1);
	var ntp_mode="<% nvram_get("ntp_mode"); %>";
	if ( ntp_mode != "" ) save_data("ntp_mode", ntp_mode,1);
	var def_hwaddr="<% nvram_get("def_hwaddr"); %>";
	if ( def_hwaddr != "" ) save_data("def_hwaddr",str_replace(":","-",def_hwaddr),1);
	save_data("en_pwd", "<% nvram_get("en_pwd"); %>",1);
	var mac_clone_enable="<% nvram_get("mac_clone_enable"); %>"; 
	if ( mac_clone_enable != "" ) save_data("mac_clone_enable", mac_clone_enable,1);
	if ( ntp_mode == "manual" ) 
	{
		var ntp_manual_time = "<% nvram_get("ntp_manual_time"); %>"; 
		if ( ntp_manual_time != "" ) save_data("ntp_manual_time", ntp_manual_time,1);
	}
	if ( wan_proto != "dhcp" && wan_proto != "static" ) 
	{
		var ppp_username = "<% nvram_get("ppp_username"); %>"; 
		var ppp_passwd = "<% nvram_get("ppp_passwd"); %>"; 
		if ( ppp_username != "" ) save_data("ppp_username", ppp_username,1);
		if ( ppp_passwd != "" ) save_data("ppp_passwd", ppp_passwd,1);
	}
	if ( wan_proto != "dhcp" ) 
	{
		var wan_ipaddr = "<% nvram_get("wan_ipaddr"); %>";
		if ( wan_ipaddr != "" ) save_data("wan_ipaddr", wan_ipaddr,1);
		var wan_netmask = "<% nvram_get("wan_netmask"); %>";
		if ( wan_netmask != "" ) save_data("wan_netmask", wan_netmask,1);
		var wan_gateway = "<% nvram_get("wan_gateway"); %>";
		if ( wan_gateway != "" ) save_data("wan_gateway", wan_gateway,1);
		var wan_dns = "<% nvram_get("wan_dns"); %>";
		if ( wan_dns != "" ) save_data("wan_dns", wan_dns,1);
	}
	if ( wan_proto == "l2tp" ) 
	{
		var l2tp_server_ip = "<% nvram_get("l2tp_server_ip"); %>";
		if ( l2tp_server_ip != "" ) save_data("l2tp_server_ip", l2tp_server_ip,1);
	}else if ( wan_proto == "pptp" ){
		var pptp_server_ip = "<% nvram_get("pptp_server_ip"); %>";
		if ( pptp_server_ip != "" ) save_data("pptp_server_ip", pptp_server_ip,1);
	}
	<% wl_multi_nvram_get("wl_ssid"); %>
	<% wl_multi_nvram_get("wl_security_mode"); %>
	<% wl_multi_nvram_get("wl_crypto"); %>
	<% wl_multi_nvram_get("wl_wpa_psk"); %>
	// For WEP START
	<% wl_multi_nvram_get("wl_wep_bit"); %>
	<% wl_multi_nvram_get("wl_passphrase"); %>
	<% wl_multi_nvram_get("wl_key1"); %>
	<% wl_multi_nvram_get("wl_key2"); %>
	<% wl_multi_nvram_get("wl_key3"); %>
	<% wl_multi_nvram_get("wl_key4"); %>
	<% wl_multi_nvram_get("wl_key"); %>
	<% wl_multi_nvram_get("wl_auth"); %>
	// For WEP END
	<% wl_multi_nvram_get("wl_radius_ipaddr"); %>
	<% wl_multi_nvram_get("wl_radius_port"); %>
	<% wl_multi_nvram_get("wl_radius_key"); %>
	<% wl_multi_nvram_get("wl_wpa_gtk_rekey"); %>
	
	if ( nv_wl_ssid_0 != "" ) save_data("wl_ssid_0", cy_speccode_decode(nv_wl_ssid_0),1);
	if ( nv_wl_security_mode_0 != "" ) save_data("security_mode", nv_wl_security_mode_0,1);
	if ( nv_wl_crypto_0 != "" ) save_data("crypto", nv_wl_crypto_0,1);
	if ( nv_wl_wpa_psk_0 != "" ) save_data("wpa_psk", nv_wl_wpa_psk_0,1);
	if ( nv_wl_wep_bit_0 != "" ) save_data("wep_bit", nv_wl_wep_bit_0,1); 
	if ( nv_wl_passphrase_0 != "" ) save_data("passphrase", nv_wl_passphrase_0,1); 
	if ( nv_wl_key1_0 != "" ) save_data("key1", nv_wl_key1_0,1);
	if ( nv_wl_key2_0 != "" ) save_data("key2", nv_wl_key2_0,1); 
	if ( nv_wl_key3_0 != "" ) save_data("key3", nv_wl_key3_0,1); 
	if ( nv_wl_key4_0 != "" ) save_data("key4", nv_wl_key4_0,1); 
	if ( nv_wl_key_0 != "" ) save_data("sel_key", nv_wl_key_0,1); 
	if ( nv_wl_auth_0 != "" ) save_data("wlauth", nv_wl_auth_0,1); 
	if ( nv_wl_radius_ipaddr_0 != "" ) save_data("radius_ipaddr",nv_wl_radius_ipaddr_0,1);
	if ( nv_wl_radius_port_0 != "" ) save_data("radius_port",nv_wl_radius_port_0,1);
	if ( nv_wl_radius_key_0 != "" ) save_data("radius_key",nv_wl_radius_key_0,1);
	if ( nv_wl_wpa_gtk_rekey_0 != "" ) save_data("wpa_gtk_rekey",nv_wl_wpa_gtk_rekey_0,1);
	def_nv = keep_val(document.wz_welcome,""); 
}

function Sel_Lang(F)
{
        F.submit_button.value = "default";
	F.change_action.value = "gozila_cgi";
        F.submit_type.value = "set_lang";
	F.next_page.value="wizard/index.asp";
        F.submit();
}  


</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=bt_type>
<input type=hidden name=next_page>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <TR><TD class=CONTENT_TITLE_L><script>Capture(wz.title);</script></TD>
    <TD class=CONTENT_TITLE_R><script>Capture(router.lang);</script>:
    <script>
	<% onload_lang(); %>
        draw_object(O_GUI,SELBOX,"sel_lang","width=165px onChange=Sel_Lang(this.form)",_name,_val,"<% nvram_get("language"); %>");
    </script>
    </TD></TR>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(0,1);</script>
    <TR>
    <TD class=DATA_TITLE colspan=4><script>Capture(wz.welcome)</script></TD>
    </TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_DETAIL>
    <P><script>Capture(wz.welcomemsg1);</script></P><P><script>Capture(wz.welcomemsg2);</script></P>
    <P><script>document.write(spell_words(__T(wz.welcomemsg3),'<a href="javascript:void(0)" onclick="javascript:goto_guide()">'+__T(wz.welcomelink)+'</a>'));</script></P></TD>
    <TD align=right rowspan=2>
    <script>
	if ( current_model_name == "RV130W" ) 
		document.write("<img src=\"../image/Router.jpg\" width=250px>");
	else
		document.write("<img src=\"../image/RV130_Rear_panel.png\" width=250px>");
    </script>
    </TD></TR>
    <TR><TD class=DATA_TAIL><script>Capture(wz.clicknext);</script></TD></TR>
    <TR><TD class=ST_HINT colspan=4><input type=checkbox name=startup <% nvram_match("getting_wizard","0","checked"); %>><script>Capture(g_start.chkshow);</script></TD></TR>
    </TABLE></TD></TR>
    </TABLE></TD></TR>
    <script>
    	create_button("","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
