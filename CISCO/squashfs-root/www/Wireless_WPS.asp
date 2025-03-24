<html>
<head>
<title>Wi-Fi Protected Setup</title>
<% web_include_file("filelink.asp"); %>
<SCRIPT language=JavaScript>
var wps_method = "<% nvram_get("wps_method"); %>";	
var wps_result = "<% nvram_get("wps_result"); %>" ; 
var wps_steps = parseInt("<% nvram_get("wps_steps"); %>",10); 
var wps_ap_role = "<% nvram_get("wps_ap_role"); %>" ; 
var wps_search_device_pc=0;
var wps_search_device_flag=false;
var wps_connect_device_pc=0;
var wps_connect_device_flag=false;
var wl_wps_steps=0; //connect step;
var wl_wps_result=0;
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_bss_enabled"); %>
<% wl_multi_nvram_get("wl_security_mode"); %>
<% wl_multi_nvram_get("wl_wps_mode"); %>
<% wl_multi_nvram_get("wl_wps_config_state"); %>
var nv_guest_vlan = "<% nvram_get("guest_vlan_id"); %>";
var nv_guest_ssid = "<% nvram_get("guest_ssid"); %>";
var now_idx = "<% nvram_get("wps_active_vap"); %>";
var wps_wer_mode = "<% nvram_get("wps_wer_mode"); %>";
var wps_aplockdown = "<% nvram_get("wps_aplockdown"); %>";
var sel_ssid_idx="<% nvram_gozila_get("wps_active_vap"); %>";
var chgflg=0, stopflg=1;
for(var i=0; i<4; i++)
{
	if ( eval("nv_wl_bss_enabled_"+i) == "1" && eval("nv_wl_wps_mode_"+i) == "enabled" ) 
	{
		stopflg=0;
		now_idx=i;
		chgflg=1;
		break;
	}
}
var F = document.wireless;
if ( stopflg == 0 ) 
{
	var wps_enabled= eval("nv_wl_wps_mode_"+sel_ssid_idx);
	var smode= eval("nv_wl_security_mode_"+sel_ssid_idx);
}
var wl_net_mode = "<% nvram_get("wl_net_mode"); %>";
var smode_e = 0;
if ( smode == "wpa_enterprise" || smode == "wpa2_enterprise" || smode == "wpa2_enterprise_mixed")  smode_e = 1;

function validChecksum(PIN)
{
        var accum = 0;
        accum += 3 * (parseInt(PIN / 10000000) % 10);
        accum += 1 * (parseInt(PIN / 1000000) % 10);
        accum += 3 * (parseInt(PIN / 100000) % 10);
        accum += 1 * (parseInt(PIN / 10000) % 10);
        accum += 3 * (parseInt(PIN / 1000) % 10);
        accum += 1 * (parseInt(PIN / 100) % 10);
        accum += 3 * (parseInt(PIN / 10) % 10);
        accum += 1 * (parseInt(PIN / 1) % 10);
    return (0 == (accum % 10));
}

function PushButton()
{
	var F=document.wireless;
	F.wl_vap_idx.value=now_idx;
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value ="wps_method1";
	F.change_action.value = "gozila_cgi";	
	F.submit();	
}

function HW_PushButton()
{
        var F=document.wireless;
        F.wl_vap_idx.value=now_idx;
        F.submit_button.value = "Wireless_WPS";
        F.submit_type.value ="wps_method4";
        F.change_action.value = "gozila_cgi";   
        F.submit();     
}


function SelSSID(num,F)
{
	F.wl_vap_idx.value=now_idx;
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value="wps_set_ssid";
	F.wl_unit.value=F.wl_unit.options[num].value;
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function EnterPIN(F)
{
	parent.document.getElementById("guiwpspush").value=0;
	F.wl_vap_idx.value=now_idx;
	clear_msg("wps_enrpin","msg_item2");
	var wps_enrpin = F.wps_enrpin.value;
	var pinerr=0;
	var ch;
	if ( wps_enrpin.length == 4 )
	{
		if ( chk_chartype(F.wps_enrpin.value,DIGIT) == FAIL )
			pinerr=1;
	}else if ( wps_enrpin.length == 9 )
	{
		if ( wps_enrpin.charAt(4) != ' ' && wps_enrpin.charAt(4) != '-' )
			pinerr = 1 ; 
		else{
			for(var i=0; i<wps_enrpin.length; i++)
			{
				if ( i == 4 ) continue;
				ch = wps_enrpin.charAt(i);
				if(ch < '0' || ch > '9')
				{
					pinerr=1;
					break;
				}
			}
			wps_enrpin = str_replace("-", "", wps_enrpin);
			wps_enrpin = str_replace(" ", "", wps_enrpin);
			if ( !validChecksum(wps_enrpin))
				pinerr = 1;
		}	
	}else if ( wps_enrpin.length == 8 )
	{
		if ( !validChecksum(wps_enrpin))
			pinerr = 1;
	}else
		pinerr = 1;
	if ( pinerr == 1 ) 
	{
		my_alert(O_VAR,"wps_enrpin",__T(msg.pinerror),"0","msg_item2","down");
		return false;
	}
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value ="wps_method2";
	F.change_action.value = "gozila_cgi";
	F.wps_enr_pin.value = wps_enrpin ; 
	F.submit();
}
function AcceptConfig(F)
{
	F.wl_vap_idx.value=now_idx;
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value ="wps_method3";
	F.change_action.value = "gozila_cgi";
	//F.commit.value = "0";
	F.submit();
}

function reset_security(F)
{
	F.wl_vap_idx.value=now_idx;
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value ="wps_reset";
	F.change_action.value = "gozila_cgi";
	//F.commit.value = "0";
	F.submit();
}

function init()
{
	var ssid_en = 0;
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("wps_bg").style.display="none";
	//parent.document.getElementById("wpspush").style.display="none";
		
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("wps_mode"));
		choose_disable(document.getElementById("e3")); //generateButton
		choose_disable(document.getElementById("wpspin_lifetime"));
		return;
	}
	var F = document.wireless;
	var radio = "<% nvram_get("wl_radio"); %>";
	if ( stopflg==0 && eval("nv_wl_bss_enabled_"+now_idx) == '1' ) 
        	ssid_en = 1;  
	if (  smode == "wpa_enterprise" || smode == "wpa2_enterprise" || smode == "wpa2_enterprise_mixed")
	{
		choose_disable(F.wps_mode);
		F.cmdreg.disabled = "ture" ;
		F.img_gif.disabled = "true";
		F.wps_enrpin.disabled = "hidden" ; 
                my_alert(O_GUI,INFO,__T(share.info),__T(wl.wpsmsg1));
		return;
	}
	
	if ( radio == "0" || wps_enabled == "disabled" ) 
	{
		DISABLE_PART(F,"dis_page_start","all_page_end",1);
                choose_disable(document.getElementById("wps_mode"));
                choose_disable("wps_active_vap");
		return;
	}
	if (wps_ap_role == "withReg") 
	{
		if (wps_result == '3' || wps_result == '4')
		{
			document.getElementById("get_session_key").value = goto_link("apply.cgi");
			frames['wwanstatus2'].location.href = goto_link("getstatus.asp");
			
			if ( wps_result == '3' ){
				parent.document.getElementById("wps_msg").innerHTML = "<P>"+__T(msg.searchdevice)+"</P><P>"+__T(msg.plswait)+"</P><P>"+__T(msg.wpsrunning)+"</P>";
			}else{
				parent.document.getElementById("wps_msg").innerHTML = __T(msg.wpsconnectclient);
			}
			parent.document.getElementById("wps_bg").style.display="";
			if ( (typeof gui_wpspush != "undefined" && gui_wpspush == "1") ||
			     (parent.document.getElementById("guiwpspush").value==1) )
			{ 
				parent.document.getElementById("guiwpspush").value=1;
				parent.document.getElementById("wpspush").style.display="";
			}
		}else
			parent.document.getElementById("guiwpspush").value=0;
	}else
		parent.document.getElementById("guiwpspush").value=0;
	if(ssid_en == 0)
	{
		DISABLE_PART(F,"dis_page_start","all_page_end",1);
                choose_disable(document.getElementById("wps_mode"));
                choose_disable("wps_active_vap");
	}
	else
	{
                choose_enable(document.getElementById("wps_mode"));
                choose_enable("wps_active_vap");

		if( wps_enabled == "enabled")
        		DISABLE_PART(document.wireless,"start_wl","end_wl",0);
		else
        		DISABLE_PART(document.wireless,"start_wl","end_wl",1);
	}
	choose_enable(document.getElementById("e1"));
	choose_disable(document.getElementById("device_pin"));
	if ( F.device_pin.value == "" || 
 	     (wps_aplockdown != "1" && wps_wer_mode != "allow") ) 
		choose_disable(F.wpspin_lifetime);
}
 
function generatePIN(F) 
{
        F.submit_button.value = "Wireless_WPS";
        F.change_action.value = "gozila_cgi";
	F.submit_type.value = "gen_ap_pin"; 
        F.submit();
}

function SelMode(F)
{
	F.wl_vap_idx.value=now_idx;
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value="Wireless_Option";
        F.change_action.value = "gozila_cgi";
	F.wps_enrpin.disabled = "hidden" ; 
	F.cmdreg.disabled = "ture" ; 
	F.wl_unit.value=F.wl_unit.options[F.wl_unit.selectedIndex].value;
	F.submit();	
}

function to_en_wps(F)
{
	F.wl_vap_idx.value=now_idx;
	if ( F.wps_mode.checked == true ) 
		F.wl_wps_mode.value = "enabled";
	else
		F.wl_wps_mode.value = "disabled";
        F.submit_button.value = "Wireless_WPS";
        F.submit_type.value = "wps_change_mode";
	
        F.submit();
	parent.document.getElementById("save_bg").style.display="";
	
}
function wps_alert_result(val)
{
	var F = document.wireless;
	alert_result(0);
	for(var i=0; i<4; i++)
        {
        	if ( F.wps_active_vap[i].value == now_idx )
                {
                 	F.wps_active_vap.selectedIndex = i;
                        break;
                }
        }
}
function sel_ssid(F)
{
	F.submit_button.value = "Wireless_WPS";
	F.submit_type.value =  "wps_change_lifetime";
	F.change_action.value = "gozila_cgi";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function edit_wps(F)
{
	get_position("Wireless_Manual.asp");
	goto_page("Wireless_Manual.asp");
	
}
</SCRIPT>
</head>
<body onload="init()">
<FORM autocomplete=off id=frm name=wireless method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=wps_enr_pin>
<input type=hidden name=gui_action value="Apply">
<input type=hidden id=get_session_key>
<input type=hidden name=change_action>
<input type=hidden name=wl_wps_mode>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=wl_vap_idx value="<% nvram_get("wps_active_vap"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.wps),"colspan=2");</script></TR>
<input type="hidden" name=all_page_start>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.wifiprotectsetup)+" &trade;","colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"<b style='font-size:14px'>1.</b> "+__TC(wl.ssid));</script>
		<script>
			var _name = new Array();
			var _val = new Array();
			var count=0;
			for(i=0; i<4; i++)
			{
				if ( eval("nv_wl_bss_enabled_"+i) == "1" ) 
				{
					_name[count] = eval("nv_wl_ssid_"+i);
					_val[count]=i;
					count++;
				}
			}
			draw_object(O_GUI,SELBOX,"wps_active_vap","onChange=sel_ssid(this.form)",_name,_val,sel_ssid_idx);
		</script>
		</TD></TR>
		<input type="hidden" name=dis_page_start>
		<!--TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.wps));</script>
		<script>
		for(i=0; i<4; i++)
                {
                	if ( eval("nv_wl_wps_mode_"+i) == "enabled" ) 
                        {
                            document.write(eval("nv_wl_ssid_"+i));
			    break;
                        }
                }
		document.write("<SPAN style='padding-left:30px'>");
		draw_object(O_GUI,BT,__T(share.edit),"e1","BT","edit_wps(this.form)");
		</script>
		</TD></TR-->
		<input type=hidden name=start_wl>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
                <b style='font-size:14px;'>2. </b><script>CaptureC(wl.wpsmsg);</script></b>
                </td></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<table style="height:85px;width:450;padding-left:20px;padding-top:20px;" border="0" cellpadding="0" cellspacing="0">
		<tr valign=top>
		<TD><b>a.</b>&nbsp;&nbsp;</TD>
		<td><script>Capture(wl.wpsmethod1);</script></td>
		<!--td width=20>&nbsp;</td-->
		<td colspan="2" rowspan=4444 align="right" valign=top>&nbsp;&nbsp;&nbsp;
		<script>
		if (smode_e == 1 || wps_enabled == "disabled" ) 
		{
			document.write("<img name=\"img_gif\" border=0 src=image/WFA_WPS_Solo1.gif style=\"filter:Alpha(Style=2)\">"); 
		}
		else if ( http_power == "rw" && "<% nvram_get("wl_radio"); %>" == "1" && wps_enabled == "enabled" && (wl_net_mode != "disabled" && (wps_steps < 2 || wps_steps > 8))){
			document.write("<img name=\"img_gif\" id=\"wps_logo\" border=0 src=image/WFA_WPS_Solo.gif onMouseOver=\"this.src='image/WFA_WPS_Solo2.gif'\" onMouseOut=\"this.src='image/WFA_WPS_Solo.gif'\" style=\"cursor:pointer;\" onclick=\"PushButton();\">");
		}
		else
		{
			document.write("<img name=\"img_gif\" border=0 src=image/WFA_WPS_Solo1.gif style=\"filter:Alpha(Style=2)\">"); 
		}
		</script>
		</TD>
		</tr>
		<TR><td colspan=3 style="padding:20px;font-size:20px"><b><script>Capture(wl.or);</script></b></TD></TD>
		</table>		
		</td></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<table style="width:450;padding-left:20px" border="0" cellpadding="0" cellspacing="0">
		<tr valign=top>
		<TD><b>b. </b>&nbsp;&nbsp;</TD>
		<td><div id=msg_item2></div><script>Capture(wl.wpsmethod2);</script> <input maxlength=9 type="text" id="wps_enrpin" name="wps_enrpin" style="width:87 "> <script>Capture(wl.andthenclick); document.write("<input type=button id='t3' class=BT onMouseover=bt('t3','move') onMouseout=bt('t3','out') onMousedown=bt('t3','down') value="+__T(wl.register)+" name=cmdreg onclick=EnterPIN(this.form)>");
		if ( http_power == "r" ) choose_disable(document.getElementById("t3"));
		</script>
		</TD>
		</tr>
		<tr>
		<td colspan=3 style='padding:20px;font-size:20px;'><b><script>Capture(wl.or);</script></b></TD>
		</tr>
		</table>
		</td></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<table style="width:450;padding-left:20px" border="0" cellpadding="0" cellspacing="0">
		<TR valign=top>
		<TD><b>c. </b>&nbsp;&nbsp;</TD>
	  	<td><script>
		var _name = new Array(__T(wl.pinnum0),__T(wl.pinnum20min),__T(wl.pinnum1hour),__T(wl.pinnum2hour),__T(wl.pinnum4hour),__T(wl.pinnum8hour),__T(wl.pinnum24hour));
		var _val = new Array(0,20,60,120,240,480,1440);
		document.write(spell_words(wps_method3_rule,"<INPUT type=hidden value=Null name=generateButton><INPUT type=button class=BT id=e3 onMouseover=bt(\"e3\",\"move\") onMouseout=bt(\"e3\",\"out\") onMousedown=bt(\"e3\",\"down\")  onclick=generatePIN(this.form) name=wepGenerate value="+__T(wl.generate)+">","<input name=device_pin id=device_pin value=\"<% nvram_get("get_wps_pin"); %>\" disabled>",draw_object(O_VAR,SELBOX,"wpspin_lifetime","id='wpspin_lifetime' onChange=sel_ssid(this.form)",_name,_val,"<% nvram_get("wpspin_lifetime"); %>")));</script></td></tr>
		</TD></TR></TABLE></TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.wpsstatus));</script>
		<script>
		if ( stopflg == 0 ) 
		{
			var wps_state = eval("nv_wl_wps_config_state_"+sel_ssid_idx);
			if ( wps_state == "1") Capture(def.configured);
			else Capture(def.unconfigured);
		}
		</script>	
		</td></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.networkname));</script>
		<script>
		if ( stopflg == 0 ) 
			document.write(eval("nv_wl_ssid_"+now_idx));
		</script>
		</td></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.security),SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		
		if ( smode == "disabled" ) Capture(share.disabled);
		else if ( smode == "wep" ) Capture(wl.wep);
		else if ( smode == "wpa_personal")  Capture(wl.wpap);
		else if ( smode == "wpa2_personal") Capture(wl.wpa2p);
		else if ( smode == "wpa2_personal_mixed") Capture(wl.wpa2mixed);
		else if ( smode == "wpa_enterprise" ) Capture(wl.wpae);
		else if ( smode == "wpa2_enterprise" ) Capture(wl.wpa2e);
		else if ( smode == "wpa2_enterprise_mixed" ) Capture(wl.wpa2emixed); 
		</script>
		</td></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.sessionst),SPACE_DOWN,SPACE_DOWN);
		Capture(share.na);
		</script>
		</TD></TR-->
		<script>chg_layout("divcontent","content_layer_f","content_layer");</script>
         </TABLE>
	 <input type=hidden name=end_wl>
</TABLE>
<input type="hidden" name=all_page_end>
</div>
</form>
</body></HTML>
<!--IFRAME name="wwanstatus2" id="wwanstatus2" src=wps_getval.asp style="display:none"></iframe-->
<script>document.write("<IFRAME name=\"wwanstatus2\" id=\"wwanstatus2\" src='' style=\"display:none\"></iframe>");
</script>
