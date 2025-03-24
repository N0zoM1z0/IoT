<TR>
	<TD colspan=2 id=BTTD class=BTTD>
	<script>
		if ( single_tb == "true" ) document.getElementById("BTTD").className = "";
		// Adject the content width for Firefox and IE.
		chg_layout();
		// RE-BUILD GUI object value for compare
		<% web_include_file("BT_common.js"); %>
		draw_object(O_GUI,BT,__T(share.save),"c1");
		if ( factory_bt == "true" ) 
			draw_object(O_GUI,BT,__T(share.restoredef),"c2","BT_L","to_restore(this.form)");
		if ( change_cancel_bt == "true" )  
			draw_object(O_GUI,BT,__T(share.cancel),"c3","BT","define_cancel(this.form)");
		else
			draw_object(O_GUI,BT,__T(share.cancel),"c3");
		if ( back_bt == "true" ) 
			draw_object(O_GUI,BT,__T(share.back),"c4","BT","to_back(this.form)");
		if ( viewlog_bt == "true" ) 
			draw_object(O_GUI,BT,__T(viewlog.title),"t1","BT","goto_viewlog()");
		if ( http_power == "r" )
		{
			choose_disable(document.getElementById("c1"));
			if ( factory_bt == "true" ) 
				choose_disable(document.getElementById("c2"));
			choose_disable(document.getElementById("c3"));
			if ( back_bt == "true" ) 
				choose_disable(document.getElementById("c4"));
		}

	if(("<% nvram_match("aging_time_true","1","1"); %>" == "1") && (get_url_filename(1) != 1))
	{
		//if("<% nvram_match("http_power","rw","1"); %>" == "1")
		if("<% nvram_match("http_power","rw","1"); %>" == "1")
			url = "default.asp";
		else
			url = "login.asp";

		top.location.href = url;
	}

	var wps_ap_role = "<% nvram_get("wps_ap_role"); %>" ; 
	var wps_result = "<% nvram_get("wps_result"); %>";
	//if ( wps_result == "3" || wps_result == "4" ) 
	if ( (wps_result == "3" || wps_result == "4") && wps_ap_role == "withReg" )
		get_position("Wireless_WPS.asp");

	// initial mode , edit and delete button is gray out
	choose_disable(document.getElementById("t3"));
	choose_disable(document.getElementById("t4"));

	function define_cancel(F)
	{
		if ( http_power == "r" || default_nv == "default_nv" )
        	        refresh_page();
		else
			valid_before_leave(F);
	}

	function valid_before_leave(F)
	{
		parent.document.getElementById("GUI_FUN").value = 0;
		parent.document.getElementById("GUI_LOCK").value = 0; 
		if ( CHK_VALUE_AUTO ) 
			change_nv= keep_val(F,skip_name);
		else
			change_nv = get_data(F);
		chk_change(default_nv,change_nv);
		if ( parent.document.getElementById("GUI_LOCK").value == 1 )
		{
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"refresh_page()","alert_result(0)","","yesno");	
		}else{
			refresh_page();
		}
	}


	</script>
	</TD>
</TR>
<input type=hidden name=webpage_end>
<script>
if ( ap_mode == "0" ) 
{
	var wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>"; //1:IPv4 2:IPv6
	var lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>"; //1:IPv4 2:IPv6 3:IPv4&IPv6
	//Case 1: LAN:IPv4 WAN:IPv4,
	//Case 2: LAN:IPv6 WAN:IPv4,
	//Case 3: LAN:IPv6 WAN:IPv6, 
	//Case 4: LAN:IPv4+IPv6 WAN:IPv4, 
	//Case 5: LAN:IPv4+IPv6 WAN:IPv4+IPv6
	//Case 6: LAN:IPv4, WAN:IPv6
	var tmp_ipmode = parent.document.getElementById("now_ipmode").value;
	if ( (lan_ip_mode == "1" && wan_ip_mode == "1" &&  parseInt(tmp_ipmode.charAt(0),10) == 0) ||
	     (lan_ip_mode == "2" && wan_ip_mode == "1" &&  parseInt(tmp_ipmode.charAt(1),10) == 0) ||
	     (lan_ip_mode == "2" && wan_ip_mode == "2" &&  parseInt(tmp_ipmode.charAt(2),10) == 0) ||
	     (lan_ip_mode == "3" && wan_ip_mode == "1" &&  parseInt(tmp_ipmode.charAt(3),10) == 0) ||
	     (lan_ip_mode == "3" && wan_ip_mode == "3" &&  parseInt(tmp_ipmode.charAt(4),10) == 0) ||
	     (lan_ip_mode == "1" && wan_ip_mode == "2" &&  parseInt(tmp_ipmode.charAt(5),10) == 0))
	{
        	my_alert(O_GUI,INFO,__T(share.info),__T(msg.ipmodesupport),"alert_result(0)");
	        DISABLE_ALL(document.getElementById("frm"),1);
		window.onload=function(){
			window.stop?window.stop():document.execCommand("Stop");
		}
	} 
}
</script>


