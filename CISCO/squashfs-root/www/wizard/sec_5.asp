<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
<% web_include_file("md5.js"); %>
<% web_include_file("encode_data.js"); %>
function goto_guide()
{
	window.showModalDialog(goto_link('guide_security.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:370px;dialogHeight:380px;center:yes;');
	
}

function init()
{
	var F = document.wz_sec;
	if ( http_power == "rw" ) 
		goto_next(F);
	def_nv = keep_val(F,""); 
}

function en_value(data)
{
        var pseed2="";
        var buffer1=data;
        var md5Str2="";
        var Length2 = data.length;
        if (Length2 < 10 )
        {
                buffer1 += "0";
                buffer1 += Length2;
        }else{
                buffer1 += Length2;
        }
        Length2 = Length2 +2;

        for(var p=0; p<64; p++) {
                var tempCount = p % Length2;
                pseed2 += buffer1.substring(tempCount, tempCount+1);
        }
        md5Str2 = hex_md5(pseed2);
        return md5Str2;
}

function goto_next(F){
        var admin_new_pwd = parse_data("admin_new_pwd");
        var ssid = parse_data("wl_ssid_0");
        var security_mode = parse_data("security_mode");
	F.goto_login.value = parse_data("goto_login");
	F.http_user0.value = "enc="+en_value(admin_new_pwd);
        if ( ssid != "" ) 
                F.wl_ssid_0.value = ssid;
	F.en_pwd.value = parse_data("en_pwd");
        if ( security_mode != "" && current_model_name == "RV130W" )
        {
		var nv_list = new Array("wl_auth","wl_key1","wl_key2","wl_key3","wl_key4","wl_key","wl_passphrase","wl_crypto","wl_wpa_psk","wl_wpa_gtk_rekey","wl_radius_ipaddr","wl_radius_port","wl_radius_key");
		for(var i=0; i<nv_list.length; i++)
		{
			choose_disable(eval("F."+nv_list[i]));
		}
                F.wl_security_mode.value = security_mode;
                if ( security_mode == "wep" ) 
                {
			choose_enable(F.wl_key1);
			choose_enable(F.wl_key2);
			choose_enable(F.wl_key3);
			choose_enable(F.wl_key4);
			choose_enable(F.wl_key);
			choose_enable(F.wl_passphrase);
			choose_enable(F.wl_auth);
			F.wl_key1.value = parse_data("key1");
			F.wl_key2.value = parse_data("key2");
			F.wl_key3.value = parse_data("key3");
			F.wl_key4.value = parse_data("key4");
			F.wl_key.value = parse_data("key");
			F.wl_wep_bit.value = parse_data("wepbit");
			F.wl_passphrase.value = parse_data("passphrase");
			F.wl_auth.value = parse_data("wlauth");
                }
                else if ( security_mode == "wpa_personal" || security_mode == "wpa2_personal" || security_mode == "wpa2_personal_mixed" ) 
		{
			choose_enable(F.wl_crypto);
			choose_enable(F.wl_wpa_psk);
			choose_enable(F.wl_wpa_gtk_rekey);
			F.wl_crypto.value = parse_data("crypto");
			F.wl_wpa_psk.value = encode_data(parse_data("wpa_psk"));
			F.wl_wpa_gtk_rekey.value = parse_data("wpa_gtk_rekey");
		}else if ( security_mode == "wpa_enterprise" || security_mode == "wpa2_enterprise" || security_mode == "wpa2_enterprise_mixed" ) 
		{
			choose_enable(F.wl_crypto);
			choose_enable(F.wl_radius_ipaddr);
			choose_enable(F.wl_radius_port);
			choose_enable(F.wl_radius_key);
			choose_enable(F.wl_wpa_gtk_rekey);
			F.wl_crypto.value = parse_data("crypto");
			var tmpip = parse_data("radius_ipaddr").split(".");	
			for(var j=0; j<tmpip.length; j++)
			{
				if ( tmpip.length != 4 ) break;
				eval("F.wl_radius_ipaddr_"+j).value = tmpip[j];
			}
			F.wl_radius_port.value = parse_data("radius_port");
			F.wl_radius_key.value = parse_data("radius_key");
			F.wl_wpa_gtk_rekey.value = parse_data("wpa_gtk_rekey");
		}
        } 
        F.submit_button.value = "wizard/complete_setup";
        F.gui_action.value = "Apply";
	//F.action = goto_link(F.action);
        F.submit();
        choose_disable(document.getElementById("w1"));
        choose_disable(document.getElementById("w2"));
        choose_disable(document.getElementById("w3"));
}

function uiDoCancel(F)
{
	change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv,2) ) 
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
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_sec" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wl_radio value=1>
<input type=hidden name=wl_ssid_0>
<input type=hidden name=http_user0>
<input type=hidden name=wl_security_mode>
<input type=hidden name=wl_crypto>
<input type=hidden name=wl_wpa_psk>
<input type=hidden name=wl_wpa_gtk_rekey>
<input type=hidden name=wl_auth>
<input type=hidden name=wl_key1>
<input type=hidden name=wl_key2>
<input type=hidden name=wl_key3>
<input type=hidden name=wl_key4>
<input type=hidden name=wl_key>
<input type=hidden name=wl_wep_bit>
<input type=hidden name=wl_passphrase>
<input type=hidden name=wl_radius_ipaddr value=4>
<input type=hidden name=wl_radius_ipaddr_0>
<input type=hidden name=wl_radius_ipaddr_1>
<input type=hidden name=wl_radius_ipaddr_2>
<input type=hidden name=wl_radius_ipaddr_3>
<input type=hidden name=wl_radius_port>
<input type=hidden name=wl_radius_key>
<input type=hidden name=goto_login>
<input type=hidden name=en_pwd>
<input type=hidden name=wait_time value=7>
<input type=hidden name=nvset_cgi value="wireless">

<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(3,4);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.descsec5of1);</script></TD></TR>
    <TR><TD colspan=4 valign=top width=100%>
    <TABLE width=100%>
    <TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.descsec5of2);</script>
    </TD></TR>
    <TR><TD valign=top align=center width=100%>
    <TABLE class=STATUS_LAYER>
    <TR><TD class=STATUS_TD>
    <script>Capture(wz.ensec);</script>
    </TD></TR>
    <TR><TD class=STATUS_TD2><img id=img_process src='/image/ProgressBar_indeterminate.gif'></TD></TR>
    </TABLE>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.takemoments);</script>
    </TD></TR> 
    </TABLE>
    </TD></TR>
    </TABLE>
    </TD></TR>
    <!--/TABLE></TD></TR-->
    <script>
	if ( http_power == "r" ) 
		create_button("onClick=document.location.href=goto_link(\"sec_4.asp\")","","onClick=document.location.href=goto_link(\"complete_setup.asp\")");
	else
		create_button("onClick=document.location.href=goto_link(\"sec_4.asp\")","","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
