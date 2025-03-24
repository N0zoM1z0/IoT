<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var cmp_arr = new Array();
<% get_vlan_list("cmp_arr"); %>
var BT_ON = "image/BT_S_ON_1.gif";
var BT_OFF = "image/BT_S_OFF_1.gif";
CHK_VALUE_AUTO=0;
var smode_val = new Array("disabled","wep","wpa_personal","wpa_enterprise","wpa2_personal","wpa2_personal_mixed","wpa2_enterprise","wpa2_enterprise_mixed");
var smode_name = new Array(__T(share.disabled),__T(wl.wep),__T(wl.wpap),__T(wl.wpae),__T(wl.wpa2p),__T(wl.wpa2mixed),__T(wl.wpa2e),__T(wl.wpa2emixed));
var en_uapsd=0;
var _vlan = new Array("1","1","1","1");
var nv_wps_bt = "<% nvram_get("wl_wps_btn_index"); %>" ;
var country = "<% nvram_get("wl_country_code"); %>";
<% wl_multi_nvram_get("wl_bss_enabled"); %>
<% wl_multi_nvram_get("wl_closed"); %>
<% wl_multi_nvram_get("wl_ap_isolate"); %>
<% wl_multi_nvram_get("wl_wme_bss_disable"); %>
<% wl_multi_nvram_get("wl_vlan_id"); %>
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_security_mode"); %>
<% wl_multi_nvram_get("wl_macfilter_enable"); %>
<% wl_multi_nvram_get("wl_wps_mode"); %>
<% wl_multi_nvram_get("wl_bss_maxassoc"); %>
<% wl_multi_nvram_get("wl_ap_vlan_id"); %>
var nv_gn_profile_0 = "<% nvram_get("gn_profile_0"); %>";
var nv_gn_profile_1 = "<% nvram_get("gn_profile_1"); %>";
var nv_gn_profile_2 = "<% nvram_get("gn_profile_2"); %>";
var nv_gn_profile_3 = "<% nvram_get("gn_profile_3"); %>";
var nv_gn_enable_0 = "<% nvram_get("gn_0_enable"); %>";
var nv_gn_enable_1 = "<% nvram_get("gn_1_enable"); %>";
var nv_gn_enable_2 = "<% nvram_get("gn_2_enable"); %>";
var nv_gn_enable_3 = "<% nvram_get("gn_3_enable"); %>";
var nv_guest_vlan = "<% nvram_get("guest_vlan_id"); %>";
var nv_guest_ssid = "<% nvram_get("guest_ssid"); %>";
var tmp = "<% nvram_get("vlan_group"); %>".replace(/\s*$/,"");
var tmp1 = tmp.split(" ");
var tmp2 ="";
var define_backname="Wireless_Manual.asp";
var change_canecl_bt="false";
var gnet=3;
for(var i=0; i<tmp1.length; i++)
{
	if ( tmp2 != "" ) tmp2 += " ";
	tmp2 += tmp1[i];
}
var vlan_entry = tmp2.split(" ");
var vlan_entry2 = tmp2.split(" ");
if ( GUESTNET_SUPPORT == 1 ) 
	vlan_entry[vlan_entry.length]=__T(wl.addnewvlan);
var stflg="init";
function chk_wme(F)
{
        en_uapsd=0;
	for(var i=0; i<4; i++)
	{
		if ( eval("F.wme_bss_disable_"+i).checked )
		{
        	        en_uapsd=1;
		}
	}
	if ( en_uapsd == 0 ) choose_disable(F.wmebss_enabled__apsd);
	else choose_enable(F.wme_apsd);
}
function chk_radio(F)
{
	var _name = new Array("closed_","ap_isolate_","wme_bss_disable_","bss_maxassoc_","wps_mode_","gn_profile_","gn_enable_");
	if ( F.wlradio.checked == true ) 
	{
		DISABLE_PART(F,"all_page_start","all_page_end",0);
		init_obj(F);
		Sel_WL();
		Sel_BW();	
		to_sel(0);
		chk_wme(F);
		for(i=0; i<_name.length; i++)
		{
			for(j=0; j<4; j++)
				choose_disable(document.getElementById(_name[i]+j));
		}
	}else{
	
		DISABLE_PART(F,"all_page_start","all_page_end",1);
	}
}

function init(){
	var F = document.wireless;
	parent.document.getElementById("save_bg").style.display="none";
	chk_radio(F);	
	for(var i=0; i<4; i++)
	{
        	if ( eval("nv_wl_wme_bss_disable_"+i) == '0' )
	        {
        	        en_uapsd=1;
                	break;
	        }
	}
	if ( en_uapsd == 0 ) choose_disable(F.wme_apsd);
	default_nv = get_data(F);
}

function get_data(F)
{
	var data = keep_val(F,"");
	data+= ","+F.wl_channel.value;
	return data;
}

function Sel_WL(){
	var F = document.wireless;
	var net_mode = F.wl_net_mode.value;
	var dlist = new Array("mixed","b-only","g-only","n-only","bg-mixed","gn-mixed");
	for(var i=0; i<4; i++)
	{
		if ( net_mode == "n-only" && (eval("nv_wl_security_mode_"+i) == "wep" ||  
		     eval("nv_wl_security_mode_"+i) == "wpa_personal" ||
		     eval("nv_wl_security_mode_"+i) == "wpa_enterprise" ) )
		{
                	my_alert(O_GUI,INFO,__T(share.info),__T(msg.wldroprule),"alert_result(0)");
			for(var j=0; j<dlist.length; j++)
			{
				if ( dlist[j] == "<% nvram_get("wl_net_mode");%>" ) 
				{
					F.wl_net_mode[j].selected = true;
					break;
				}
			}
			return;
		}
	}	
	if ( net_mode != "mixed" && net_mode != "n-only" && net_mode != "gn-mixed"){
		F.wl_nbw.value = "20";
		F.wl_nbw[0].checked = true;
		choose_disable(F.wl_nbw[0]);
		choose_disable(F.wl_nbw[1]);
	}else{
		choose_enable(F.wl_nbw[0]);
		choose_enable(F.wl_nbw[1]);
	}
	Sel_BW();
}

function Sel_BW(){
	return;
	var F = document.wireless;
	if ( F.wl_nbw[1].checked ) 
		choose_disable(F.wl_channel);
	else
		choose_enable(F.wl_channel);
}

function goto_act(act)
{
	var F = document.wireless;
	choose_disable(F.next_page);
	F.change_action.value="gozila_cgi";
	if ( act == "security" ) 
		F.submit_button.value = "WL_WPATable";
	else if ( act == "mac" ) 
		F.submit_button.value = "Wireless_MAC";
	else if ( act == "time" ) 
		F.submit_button.value = "access_time";
	else if ( GUESTNET_SUPPORT == 1 && act == "guestnet" )
	{
		get_position("Wireless_captive.asp");
		//F.submit_button.value = "Wireless_captive";
	}
	get_extra_help(F.submit_button.value);
	F.submit();
}

function chk_now_ssid(i)
{
	clear_table_msg("tmsg","img_ssid"+i,"ssid_"+i,i);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById("ssid_"+i).value,ZERO_NO);
	if ( returnmsg != "" ) 
	{
               table_msg("img_ssid"+i,"ssid_"+i,"div_ssid"+i,i,returnmsg);     
	       return false;	
	}
	return true;
}

function to_edit(){
	choose_disable(document.getElementById("t3"));
	choose_disable(document.getElementById("t4"));
	choose_disable(document.getElementById("t5"));
	//choose_disable(document.getElementById("t6"));
	stflg = "edit";
	var F = document.wireless;
	var objs_name = new Array("bss_enabled","closed","ap_isolate","wme_bss_disable","bss_maxassoc","wps_mode");
	if ( GUESTNET_SUPPORT == 1 && ap_mode == "0" ) 
	{
		objs_name[objs_name.length+1] = "gn_profile";
		objs_name[objs_name.length+1] = "gn_enable";
	}
	for(var i=0; i<4; i++)
	{
		if ( eval("F.sel_"+i).checked == true ) 
		{
			document.getElementById("ssid_name_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img_ssid"+i,"<input size=20 maxlength=32 id='ssid_"+i+"' name='ssid_"+i+"' value='"+ eval("nv_wl_ssid_"+i)+"' onMouseMove=showHint('img_ssid"+i+"','div_ssid"+i+"',event) onMouseOut=hideHint('div_ssid"+i+"') onblur=chk_now_ssid("+i+")>","div_ssid"+i);
			for(var j=0; j<objs_name.length; j++)
				choose_enable(eval("F."+objs_name[j]+"_"+i));
			if ( ap_mode == "0" ) 
			{
				document.getElementById("wl_vlan_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img_vlan"+i,draw_object(O_VAR,SELBOX,"vlan_id_"+i," id=vlan_id_"+i+" onchange=chg_vlanid(this.form,'"+i+"') onMouseMove=showHint('img_vlan"+i+"','div_vlan"+i+"',event) onMouseOut=hideHint('div_vlan"+i+"')",vlan_entry,vlan_entry,eval("nv_wl_vlan_id_"+i)),"div_vlan"+i);
			}else{
				document.getElementById("wl_vlan_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img_vlan"+i,"<input size=10 maxlength=4 id='_wl_ap_vlan_id_"+i+"' name='_wl_ap_vlan_id_"+i+"' value='"+ eval("nv_wl_ap_vlan_id_"+i)+"' onMouseMove=showHint('img_vlan"+i+"','div_vlan"+i+"',event) onMouseOut=hideHint('div_vlan"+i+"') onblur=msg_chk_range(this.value,'_wl_ap_vlan_id_"+i+"',1,VLAN_ID_TO,10,IS_TABLE,'tmsg','img_vlan"+i+"','div_vlan"+i+"',"+i+")>","div_vlan"+i);
				
			}
			document.getElementById("td_bss_maxassoc"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img_bss_maxassoc"+i,"<input size=10 id='bss_maxassoc_"+i+"' name='bss_maxassoc_"+i+"' value='"+eval("nv_wl_bss_maxassoc_"+i)+"' onMouseMove=showHint('img_bss_maxassoc"+i+"','div_bss_maxassoc"+i+"',event) onMouseOut=hideHint('div_bss_maxassoc"+i+"') onblur=msg_chk_range(this.value,'bss_maxassoc_"+i+"',1,WL_MAX_CLIENT,10,IS_TABLE,'tmsg','img_bss_maxassoc"+i+"','div_bss_maxassoc"+i+"',"+i+")>","div_bss_maxassoc"+i,"","align=right");
			if ( ap_mode == "0" )
			  gn_chk(i);
		}
	}
}
function sel_profile(F,index)
{
	clear_table_msg("tmsg","img_profile"+index,"gn_profile_"+index,index);
	if ( document.getElementById("gn_profile_"+index).value == "-1" )
	{
		choose_disable(F.next_page);
		change_cancel_bt="true";
		get_position("Wireless_Manual.asp",1);
		goto_page("Wireless_welcome.asp");
	}
	
}

function chg_vlanid(F,index)
{
	if ( ap_mode == "0" ) 
	{
		clear_table_msg("tmsg","img_vlan"+index,"vlan_id_"+index,index);
		if ( IS_GUEST(index) )
		{
			if ( document.getElementById("vlan_id_"+index).value == "1" ) 
			{
               			table_msg("img_vlan"+index,"vlan_id_"+index,"div_vlan"+index,index,__T(wl.guesterr1));     
				return false;
			}
                }
		for(var i=0; i<4; i++)
                {
                	if ( i == index ) continue;
			if ( document.getElementById("bss_enabled_"+i).src.indexOf("BT_S_OFF") != -1 ) continue;
			if ( document.getElementById("bss_enabled_"+index).src.indexOf("BT_S_OFF") != -1 ) continue;
                        if ( document.getElementById("vlan_id_"+i) ) 
                        	var vid = document.getElementById("vlan_id_"+i).value;
                        else
                                var vid = document.getElementById("wl_vlan_"+i).innerHTML;
                        if ((IS_GUEST(index) || IS_GUEST(i)) && (vid == document.getElementById("vlan_id_"+index).value) )
                        {
                            table_msg("img_vlan"+index,"vlan_id_"+index,"div_vlan"+index,index,__T(wl.guesterr2));     
                            return false;
                        }
                }

	}
	
	if ( document.getElementById("vlan_id_"+index).value == __T(wl.addnewvlan) )
	{
		choose_disable(F.next_page);
		change_cancel_bt="true";
		get_position("Wireless_Manual.asp",1);
		goto_page("vlan_membership.asp");
	}
}

/*
function guest_result(val)
{
	alert_result(0);
	var F = document.wireless;
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	if ( val == 1 ) 
	{
		if ( need_chg == 1 ) F.submit_button.value = "Wireless_Manual";
		init_obj(F);
		F.submit();
		if ( http_from == "wan" ) 
                {
                        F.wait_time.value = "30";
                        setTimeout("chk_st()", 30000);
                        
                }
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
	}
}*/

function chk_maxclient(F)
{
	for(var i=0; i<SSID_COUNT; i++)
			clear_table_msg("tmsg","img_bss_maxassoc"+i,"bss_maxassoc_"+i,i);
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( eval("F.bss_maxassoc_"+i) == null ) continue;
		if ( !msg_chk_range(eval("F.bss_maxassoc_"+i).value,"bss_maxassoc_"+i,1,WL_MAX_CLIENT,10,IS_TABLE,'tmsg',"img_bss_maxassoc"+i,"div_bss_maxassoc"+i,i) )	return false;
	}
	return true;
	
}
function chk_vid(F){
	for(var i=0; i<SSID_COUNT; i++)
			clear_table_msg("tmsg","img_vlan"+i,"_wl_ap_vlan_id_"+i,i);
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( eval("F.ssid_"+i) == null ) continue;
		if ( !msg_chk_range(eval("F._wl_ap_vlan_id_"+i).value,"_wl_ap_vlan_id_"+i,1,VLAN_ID_TO,10,IS_TABLE,'tmsg',"img_vlan"+i,"div_vlan"+i,i) )	return false;
	}
	return true;
}
function chk_ssid(F){
	var cmpdata = "";
	var errflg=0;
	for(var i=0; i<SSID_COUNT; i++)
			clear_table_msg("tmsg","img_ssid"+i,"ssid_"+i,i);
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( eval("F.ssid_"+i) == null ) continue;
		var returnmsg = valid_meaning_id_name(MEANING_NAME,eval("F.ssid_"+i).value,ZERO_NO);
		if ( returnmsg != "" ) 
                {
                	table_msg("img_ssid"+i,"ssid_"+i,"div_ssid"+i,i,returnmsg);     
			errflg = 1;
                }
		for(var j=0; j<SSID_COUNT; j++)
		{	
			if ( j == i ) continue;
			if ( eval("F.ssid_"+j) ) 
				cmpdata = eval("F.ssid_"+j).value;
			else
				cmpdata = document.getElementById("ssid_name_"+j).innerHTML;
			if ( eval("F.ssid_"+i).value == cmpdata )
			{
				table_msg("img_ssid"+i,"ssid_"+i,"div_ssid"+i,i,__T(msg.ssid));	
				errflg = 1;
			}
		}

	}
	if ( errflg == 1 ) return false;
	return true;
}

var need_chg=0;

var gn_enable="<% nvram_get("gn_enable"); %>";
var nv_gn_enable_0 = "<% nvram_get("gn_0_enable"); %>";
var nv_gn_enable_1 = "<% nvram_get("gn_1_enable"); %>";
var nv_gn_enable_2 = "<% nvram_get("gn_2_enable"); %>";
var nv_gn_enable_3 = "<% nvram_get("gn_3_enable"); %>";

function IS_GUEST(i)
{
	if ( GUESTNET_SUPPORT == 0 || ap_mode == "1" ) return false;
	if ( document.getElementById("gn_enable_"+i).checked == true ) 
	{
			return true;
	}	
	return false;
}

function uiDoSave(F)
{
	var wps_gnet=0;
	var en_wps=0;
	if ( ap_mode == "0" ) 
	{
		for(var i=0; i<SSID_COUNT; i++)
                {
                       	if ( document.getElementById("bss_enabled_"+i).src.indexOf("BT_S_OFF") != -1 ) continue;
	                if ( document.getElementById("vlan_id_"+i) ) 
        	                var vid = document.getElementById("vlan_id_"+i).value;
	                else
        	        	var vid = document.getElementById("wl_vlan_"+i).innerHTML;
			for(var j=i+1; j<SSID_COUNT; j++)
			{
	                        if ( document.getElementById("bss_enabled_"+j).src.indexOf("BT_S_OFF") != -1 ) continue;
	                        if ( document.getElementById("vlan_id_"+j) ) 
        	                        var vid2 = document.getElementById("vlan_id_"+j).value;
	                        else
        	                        var vid2 = document.getElementById("wl_vlan_"+j).innerHTML;
	                        if ((IS_GUEST(i) || IS_GUEST(j)) && (vid == vid2) )
        	                {
             				my_alert(O_GUI,INFO,__T(share.info),__T(wl.guesterr2),"alert_result(0)");
                        	    	return false;
	                        }
			}
                }

		for(var i=0; i<SSID_COUNT; i++)
		{
			if ( document.getElementById("vlan_id_"+i) ) 
			{
				clear_table_msg("tmsg","img_vlan"+i,"vlan_id_"+i,i);
				clear_table_msg("tmsg","img_profile"+i,"gn_profile_"+i,i);
				if ( IS_GUEST(i) )
				{
					if ( document.getElementById("vlan_id_"+i).value == "1" )
					{
        			       		table_msg("img_vlan"+i,"vlan_id_"+i,"div_vlan"+i,i,__T(wl.guesterr1));
						document.getElementById("gn_enable_"+i).checked = false;
        					return false;
					}else if ( parseInt(document.getElementById("gn_profile_"+i).value,10) < 0 )
					{
        			       		table_msg("img_profile"+i,"gn_profile_"+i,"div_profile"+i,i,__T(wl.selprofile));
        					return false;
					}
					for(var j=0; j<4; j++)
		                        {
                		                if ( i == j ) continue;
						if ( document.getElementById("bss_enabled_"+j).src.indexOf("BT_S_OFF") != -1 ) continue;
						if ( document.getElementById("bss_enabled_"+i).src.indexOf("BT_S_OFF") != -1 ) continue;
						if ( document.getElementById("vlan_id_"+j) ) 
							var vid = document.getElementById("vlan_id_"+j).value;
						else
							var vid = document.getElementById("wl_vlan_"+j).innerHTML;
                                		if ( vid == document.getElementById("vlan_id_"+i).value )
                		                {
		                                table_msg("img_vlan"+i,"vlan_id_"+i,"div_vlan"+i,i,__T(wl.guesterr2));     
                		                return false;
                                		}
		                        }

					
				}
				
			}
		}
	}
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( document.getElementById("wps_mode_"+i).checked == true ) 
		{
			F.wps_active_vap.value = i;
		}
	}
/*
	if ( GUESTNET_SUPPORT == 1 )
	{ 
			if ( document.getElementById("wps_mode_"+gnet).checked == false) wps_gnet=1;
			if ( document.getElementById("wps_mode_"+i).checked == true ) 
			{
				en_wps=gnet;
				F.wps_active_vap.value = gnet;
			}
		if ( wps_gnet == 1 ) 
			my_alert(O_GUI,INFO,__T(share.info),spell_words(gnetwps_rule,eval("nv_wl_ssid_"+en_wps)),"WL_result(2)");
		else
			WL_result(1);
	}else*/
		WL_result(1);
	

}

function WL_result(val)
{
	alert_result(0);
	var F = document.wireless;
	if ( val > 0 ) 
	{
		adv_setting(F);
	}
}

function adv_setting(F)
{
	need_chg=0;
	if ( F.wlradio.checked ) F.wl_radio.value = "1";
	else F.wl_radio.value = "0";
	if ( F.wme_apsd.checked ) F.wl_wme_apsd.value = "on";
	else F.wl_wme_apsd.value = "off";
	var trans_name = new Array("wl_closed","wl_ap_isolate","wl_wme_bss_disable","wl_wps_mode");
	var objs_name = new Array("closed","ap_isolate","wme_bss_disable","wps_mode");
	if ( stflg == "edit" ) 
	{
		if ( !chk_ssid(F) ) return false;
		if ( !chk_maxclient(F) ) return false;	
		if ( ap_mode == "1" && !chk_vid(F) ) return false;
	}
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( document.getElementById("bss_maxassoc_"+i) )
		{
			eval("F.wl_bss_maxassoc_"+i).value = document.getElementById("bss_maxassoc_"+i).value;
		}else{
			eval("F.wl_bss_maxassoc_"+i).value = eval("nv_wl_bss_maxassoc_"+i);
		}
	}
	var totalcnt=0;
	for(var i=0; i<SSID_COUNT; i++)
	{
		if ( document.getElementById("bss_enabled_"+i).src.indexOf("BT_S_ON") != -1 ) 
		{
			eval("F.wl_bss_enabled_"+i).value = "1";
			totalcnt+=parseInt(eval("F.wl_bss_maxassoc_"+i).value,10);
		}
		else
		{
			eval("F.wl_bss_enabled_"+i).value = "0";
		}
	}
	if ( totalcnt > 64 ) 
	{
             my_alert(O_GUI,INFO,__T(share.info),__T(wl.msgssidcnt),"alert_result(0)");
             return;
		
	}
	for(var j=0; j<trans_name.length; j++)
	{
		for(var i=0; i<SSID_COUNT; i++)
		{
			if ( objs_name[j] == "closed" || objs_name[j] == "wme_bss_disable" ) 
				eval("F."+trans_name[j]+"_"+i).value = "1";
			else
				eval("F."+trans_name[j]+"_"+i).value = "0";
			if ( objs_name[j] == "wps_mode" ) 
				eval("F."+trans_name[j]+"_"+i).value = "disabled";
			if ( eval("F."+objs_name[j]+"_"+i).checked )
			{
				if ( objs_name[j] == "wps_mode" ) 
				{
					 eval("F."+trans_name[j]+"_"+i).value = "enabled";
					 //if ( current_model_name == "RV110W" ) 
					 F.wl_wps_btn_index.value = i;
				}else{
					if ( objs_name[j] == "closed" || objs_name[j] == "wme_bss_disable") 
						eval("F."+trans_name[j]+"_"+i).value = "0";
					else
						eval("F."+trans_name[j]+"_"+i).value = "1";
				}
			}
		}
	}
	if ( current_model_name != "RV110W" ) choose_disable(F.wl_wps_btn_index);
	if ( GUESTNET_SUPPORT == 1 ) gid=F.guest_vlan_id.value;
	if ( GUESTNET_SUPPORT == 0 ) 
	{
		guest_result(1);
	}
	else{
		need_chg=0;
		var tmp="";
		var tmp_vid="";
		for(var k=0; k<4; k++)
		{
			if ( IS_GUEST(k) )
			{
				if ( document.getElementById("vlan_id_"+k) )
					tmp_vid = document.getElementById("vlan_id_"+k).value;
				else
					tmp_vid = eval("nv_wl_vlan_id_"+k); 
				for(var i=0; i<cmp_arr.length; i++)
				{
					keepflg=0;
					if ( tmp_vid == cmp_arr[i][0] ) 
					{
						for(var j=2; j<6; j++)
						{
							if ( cmp_arr[i][j] != "2" ) 
							{
								need_chg=1;
								keepflg=1;
								break;
							}
						}
					}
					if ( keepflg == 1 ) 
						break;
				}
				if ( keepflg == 1 ) 
				{
					if ( tmp != "" ) tmp+= " ";
					tmp+=tmp_vid;
					keepflg = 0;
				}
				
			}
		}
		if ( need_chg == 1 ) 
		{
		  F.guest_vlan_id.value = tmp;
		  my_alert(O_GUI,WARNING,__T(share.info),__T(wl.portchgwarning),"guest_result(1)","guest_result(0)","","yesno");
		  return;
		}else
		  guest_result(1);
	}
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("Wireless_Manual.asp");
	}else{
		frames['iframe1'].location.href = goto_link("Wireless_Manual.asp");
		setTimeout("chk_st()", 15000);
	}
}

function guest_result(val)
{
	alert_result(0);
	var F = document.wireless;
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	if ( val == 1 ) 
	{
		//if ( need_chg == 1 ) F.submit_button.value = "Wireless_Guest";
		//alert("submit_button="+F.submit_button.value);
		//return;
		init_obj(F);
		before_save_chg_obj(F);
		F.chg_ap_mgmt.value = 0;
		//alert("<% nvram_get("wl_ap_mgmt_vlan_id"); %> != "+F.wl_ap_mgmt_vlan_id[F.wl_ap_mgmt_vlan_id.selectedIndex].value);
		if ( ap_mode == "0" && "<% nvram_get("wl_ap_mgmt_vlan_id"); %>" != F.wl_ap_mgmt_vlan_id[F.wl_ap_mgmt_vlan_id.selectedIndex].value )
		{
			F.chg_ap_mgmt.value = 1;
		}
		//for(var i=0; i<cmp_arr.length; i++)
		//	alert(eval("F.vlan_"+i).value);
		if ( http_from == "wan" ) 
		{
			F.wait_time.value = "30";
			setTimeout("chk_st()", 30000);
			
		}
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
	}else{
		  F.guest_vlan_id.value = "";
	}
}

function init_obj(F)
{
	var trans_name = new Array("wl_vlan_id","wl_ssid","wl_ap_vlan_id");
	var objs_name = new Array("vlan_id","ssid","_wl_ap_vlan_id");
	for(var i=0; i<trans_name.length; i++)
	{
		for(var j=0; j<SSID_COUNT; j++)
		{
			if ( document.getElementById(objs_name[i]+"_"+j) == null )
				eval("F."+trans_name[i]+"_"+j).value = cy_speccode_decode(eval("nv_"+trans_name[i]+"_"+j));
			else
				eval("F."+trans_name[i]+"_"+j).value = document.getElementById(objs_name[i]+"_"+j).value;
		}
	}
}

function before_save_chg_obj(F)
{
	var en_obj = new Array("gn_enable_","gn_profile_");
	//choose_enable obj
	for (var i=0; i<SSID_COUNT; i++)
	{
		for(var j=0; j<en_obj.length; j++)
		{
			choose_enable(eval("F."+en_obj[j]+i));
		}
	}
}
function chk_all(F)
{
	for(var i=0; i<4; i++)
	{
		if ( F.chkall.checked == true ) 
			eval("F.sel_"+i).checked = true;
		else
			eval("F.sel_"+i).checked = false;
		to_sel(i);
	}
}

function sel_band(F)
{
	Sel_WL();
}

function to_sel(index){
	var tstyle;
	var F = document.wireless;
	var cnt=0;
	var objs_name = new Array("bss_enabled","closed","ap_isolate","wme_bss_disable","wps_mode");
	for(var i=0; i<4; i++)
	{
		if ( eval("F.sel_"+i).checked == true ) 
		{
			document.getElementById("tr_table"+index).className="TABLECONTENT_SEL";
			cnt++;
			index = i;
		}
		else
		{
			if ( i%2 ==0 ) tstyle = "TABLECONTENT_D_NOPAD";
                        else tstyle = "tABLECONTENT_S_NOPAD";
			document.getElementById("tr_table"+i).className=tstyle;
			if ( document.getElementById("ssid_"+i) ) 
			{
				document.getElementById("ssid_name_"+i).innerHTML = eval("nv_wl_ssid_"+i);
				document.getElementById("wl_vlan_"+i).innerHTML = eval("nv_wl_vlan_id_"+i);
				document.getElementById("td_bss_maxassoc"+i).innerHTML = eval("nv_wl_bss_maxassoc_"+i);
				for(var j=0; j<objs_name.length; j++)
					choose_disable(eval("F."+objs_name[j]+"_"+i));
			}
		}
	}
	if ( cnt == 0 ) 
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		choose_disable(document.getElementById("t5"));
		return;
	}
	choose_enable(document.getElementById("t2"));
	if ( cnt > 1 )
	{
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		choose_disable(document.getElementById("t5"));
	}else{
		F.wl_vap_idx.value=index;
		F.basic_idx.value=index;
		//if ( eval("nv_wl_bss_enabled_"+index) == "1" )
		{
//			choose_enable(document.getElementById("t6"));
			choose_enable(document.getElementById("t3"));
			choose_enable(document.getElementById("t4"));
			choose_enable(document.getElementById("t5"));
		}
	}
}

function chg_enable(objname,i)
{
	if ( document.getElementById(objname).src.indexOf(BT_ON) != -1 ) 
	{
		document.getElementById("td_bss_maxassoc"+i).innerHTML = "0";
		document.getElementById(objname).src = BT_OFF;
	}
	else if ( document.getElementById(objname).src.indexOf(BT_OFF) != -1 ) 
	{
		document.getElementById("td_bss_maxassoc"+i).innerHTML = eval("nv_wl_bss_maxassoc_"+i);
		document.getElementById(objname).src = BT_ON;
	}
}

function chk_mgnt(F)
{
	return true;
	var tmp="";
	clear_msg("wl_ap_mgmt_vlan_id","msg_mgnt");
	if ( document.getElementById("vlan_id_"+gnet) != null ) 
		tmp = document.getElementById("vlan_id_"+gnet).value;
	else
		tmp = document.getElementById("wl_vlan_"+gnet).innerHTML;
	if ( tmp == F.wl_ap_mgmt_vlan_id[F.wl_ap_mgmt_vlan_id.selectedIndex].value ) 
	{
		my_alert(O_VAR,"wl_ap_mgmt_vlan_id",__T(wl.guesterr3),"0","msg_mgnt");
		return false;
	}
	return true;
}

function goto_wps(F)
{
	get_position("Wireless_WPS.asp");
	goto_page("Wireless_WPS.asp");
}

function chk_wps(index)
{
	var F = document.wireless;
	for(var i=0; i<4; i++)
	{
		if ( i == index ) continue;
		eval("F.wps_mode_"+i).checked = false;
	}
	if ( eval("F.wps_mode_"+index).checked == true && 
	     eval("nv_wl_security_mode_"+index) != "wpa2_personal" && 
	     eval("nv_wl_security_mode_"+index) != "wpa2_personal_mixed" && 
	     eval("nv_wl_security_mode_"+index) != "disabled")
	{
             my_alert(O_GUI,INFO,__T(share.info),__T(msg.wldiswps1),"alert_result(0)");
	     eval("F.wps_mode_"+index).checked = false;	
             return;
	}
	chk_enwps(index,F);
	
}

function chk_enwps(index,F)
{
	if ( eval("F.closed_"+index).checked == false && 
	     eval("F.wps_mode_"+index).checked == true ) 
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(wl.broadcastwps),"bwps_result(1,"+index+")","bwps_result(0,"+index+")","","yesno");
		
	}
}

function bwps_result(val,index)
{
	alert_result(0);
	var F = document.wireless;
	if ( val == 1 ) 
	     eval("F.wps_mode_"+index).checked = false;
	else
	     eval("F.closed_"+index).checked = true;
}

function gn_chk(index)
{
	choose_disable(document.getElementById("gn_profile_"+index));
	if ( document.getElementById("gn_enable_"+index).checked == true ) 
		choose_enable(document.getElementById("gn_profile_"+index));
}
</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=wireless onSubmit="return false;" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button value="Wireless_Manual">
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=wl_wps_btn_index>
<input type=hidden name=wl_vap_idx>
<input type=hidden name=guest_vlan_id>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=wps_active_vap>
<input type=hidden name=wl_bss_enabled_0 value=0>
<input type=hidden name=wl_bss_enabled_1 value=0>
<input type=hidden name=wl_bss_enabled_2 value=0>
<input type=hidden name=wl_bss_enabled_3 value=0>
<input type=hidden name=wl_closed_0 value=1>
<input type=hidden name=wl_closed_1 value=1>
<input type=hidden name=wl_closed_2 value=1>
<input type=hidden name=wl_closed_3 value=1>
<input type=hidden name=wl_ap_isolate_0 value=0>
<input type=hidden name=wl_ap_isolate_1 value=0>
<input type=hidden name=wl_ap_isolate_2 value=0>
<input type=hidden name=wl_ap_isolate_3 value=0>
<input type=hidden name=wl_wme_bss_disable_0 value=0>
<input type=hidden name=wl_wme_bss_disable_1 value=0>
<input type=hidden name=wl_wme_bss_disable_2 value=0>
<input type=hidden name=wl_wme_bss_disable_3 value=0>
<input type=hidden name=wl_vlan_id_0 value=0>
<input type=hidden name=wl_vlan_id_1 value=0>
<input type=hidden name=wl_vlan_id_2 value=0>
<input type=hidden name=wl_vlan_id_3 value=0>
<input type=hidden name=wl_ap_vlan_id_0 value=0>
<input type=hidden name=wl_ap_vlan_id_1 value=0>
<input type=hidden name=wl_ap_vlan_id_2 value=0>
<input type=hidden name=wl_ap_vlan_id_3 value=0>
<input type=hidden name=vlan value=1>
<input type=hidden name=wl_ssid_0 value=0>
<input type=hidden name=wl_ssid_1 value=0>
<input type=hidden name=wl_ssid_2 value=0>
<input type=hidden name=wl_ssid_3 value=0>
<input type=hidden name=wl_wps_mode_0 value=0>
<input type=hidden name=wl_wps_mode_1 value=0>
<input type=hidden name=wl_wps_mode_2 value=0>
<input type=hidden name=wl_wps_mode_3 value=0>
<input type=hidden name=wl_bss_maxassoc_0 value=0>
<input type=hidden name=wl_bss_maxassoc_1 value=0>
<input type=hidden name=wl_bss_maxassoc_2 value=0>
<input type=hidden name=wl_bss_maxassoc_3 value=0>
<input type=hidden name=wl_guest_network value=0>
<input type=hidden name=chg_ap_mgmt value=0>
<input type=hidden name=gn_enable>
<input type=hidden name=wl_wme_apsd value=0>
<input type=hidden name=basic_idx value=0>
<input type=hidden name=wl_radio value=0>
<input type=hidden name=wait_time value=30>
<input type=hidden name=backname>
<input type=hidden name=guest_ssid>
<input type=hidden name=next_page value="Wireless_Manual">
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.basicset));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.radio));</script>
		<input type=checkbox name=wlradio <% nvram_match("wl_radio","1","checked"); %> onclick=chk_radio(this.form)>
		<script>Capture(share.enable);</script>
		</TD></TR>
		<input type=hidden name=all_page_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.networkmode));</script>
		<script>
			var vlist = new Array(__T(wl.bgn),__T(wl.bonly),__T(wl.gonly),__T(wl.nonly),__T(wl.bgmixed),__T(wl.gnmixed));
			var dlist = new Array("mixed","b-only","g-only","n-only","bg-mixed","gn-mixed");
			var selflg ="";
			draw_object(O_GUI,SELBOX,"wl_net_mode","onChange=Sel_WL()",vlist,dlist,"<% nvram_get("wl_net_mode");%>");</script>
		</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.bandsel));</script>
                <script>
                        var BNWNAME, BNWSTRING;
                        BNWNAME = new Array("20","0");
                        BNWSTRING = new Array("20"+__T(unit.mhz),"20/40"+__T(unit.mhz));
			draw_object(O_GUI,RADIO,"wl_nbw",BNWNAME,BNWSTRING,"<% nvram_get("wl_nbw"); %>","onClick=sel_band(this.form)");</script>
                </script>
        	</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.channel));
		var _name_len=11+1; // +1 -> Auto
		var _name = new Array(__T(share.auto),"2.412","2.417","2.422","2.427","2.432","2.437","2.442","2.447","2.452","2.457","2.462","2.467","2.472","2.477");
		var rname;
		for(var i=0; i<_name.length; i++)
		{
			if ( i > 0 )
				_name[i] = _name[i]+" "+__T(unit.ghz);
		}
		if ( country=="EU" ) _name_len = 13+1;

		var _val = new Array("ISRANGE",0,_name_len,1);
		var tmp_name = new Array();
		for(var i=0; i<_name_len; i++) 
		{
			if ( now_lang != "EN" ) 
				_name[i] = str_replace("\\.",",",_name[i]);
			if ( i == 0 ) tmp_name[i] = _name[i];
			else tmp_name[i] = i+"-"+_name[i];
		}
		draw_object(O_GUI,SELBOX,"wl_channel","",tmp_name,_val,"<% nvram_get("wl_channel"); %>");
		</script>
	        </TD></TR>
		<script>
		if ( ap_mode == "0" ) 
		{
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE,__TC(wl.apvlan));
			draw_object(O_GUI,SELBOX,"wl_ap_mgmt_vlan_id"," id=wl_ap_mgmt_vlan_id onchange=chk_mgnt(this.form)",vlan_entry2,vlan_entry2,"<% nvram_get("wl_ap_mgmt_vlan_id"); %>");
			document.write("<span id=msg_mgnt></span></TD></TR>");
		}
		</script>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.uapsd));</script>
		<input type=checkbox name=wme_apsd <% nvram_match("wl_wme_apsd","on","checked"); %>>
		<script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var cnt=0;
		var bt_list = new Array();
		bt_list[cnt++] = new Array("BT","t2",__T(share.edit),"to_edit()");
		bt_list[cnt++] = new Array("BT_L","t3",__T(wl.editsecuritymode),"goto_act(\"security\")");
		bt_list[cnt++] = new Array("BT_L","t4",__T(wl.editmacfilter),"goto_act(\"mac\")");
		bt_list[cnt++] = new Array("BT_L","t5",__T(wl.timeofdateacc),"goto_act(\"time\")");
		bt_list[cnt++] = new Array("BT_L","t7",__T(wl.editwps),"goto_wps(this.form)");
		var field_width="", gnet_obj="", field_align="";
		if ( ap_mode == "0" )
		{
			field_width="3,8,13,10,14,8,8,10,8,8,10,10,10";
			gnet_obj=","+__T(wl.captive)+","+__T(wl.portalprofile)+","+__T(share.enable);
			field_align="2,2,0,2,2,2,1,2,2,0,2,2,2,2,2";
			var row_span = "0,1,2,3,4,5,6,7,8,9,10";
			var col_span = "0,0,0,0,0,0,0,0,0,0,0,2,0";
		}else{
			field_width="3,8,13,10,14,8,8,10,8,8,10";
			gnet_obj = "";
			field_align="2,2,0,2,2,2,1,2,2,0,2";
			var row_span = "";
			var col_span = "";
		}
		draw_td(O_GUI,CREATE_EDIT_TABLE,field_width,__T(wl.tb),"<input type=checkbox name=chkall onClick=chk_all(this.form)>,"+__T(wl.enssid)+","+__T(wl.ssidname)+","+__T(wl.ssidbc)+","+__T(wl.securitymode)+","+__T(wl.macfilter)+","+__T(lan.vlan)+","+__T(wl.isolationwithssid)+","+__T(wl.wlwmm)+","+__T(wl.maxclient)+","+__T(wl.wps)+gnet_obj,"",bt_list,"","",field_align,"","",row_span,col_span);
		var tmpflg;
		var tmp = new Array();
		for(var i=0; i<SSID_COUNT; i++)
		{
			tmp[0] = new Array("td_chk"+i, "<input type=checkbox name=sel_"+i+" onClick=to_sel('"+i+"') value="+i+">",3);
			tmpflg = BT_OFF;
			if ( eval("nv_wl_bss_enabled_"+i) == "1" ) tmpflg = BT_ON;
			tmp[1] = new Array("td_enssid"+i, "<img onclick=chg_enable('bss_enabled_"+i+"',"+i+") id=bss_enabled_"+i+" name=bss_enabled_"+i+" src='"+tmpflg+"' width=60%>",3);
			tmp[2] = new Array("ssid_name_"+i,eval("nv_wl_ssid_"+i));
			tmpflg = "";
			if ( eval("nv_wl_closed_"+i) == "0" ) tmpflg = "checked";
			tmp[3] = new Array("td_bc"+i,"<input type=checkbox id=closed_"+i+" name=closed_"+i+" "+tmpflg+" disabled onclick=chk_enwps("+i+",this.form)>",3);
			tmpflg="";
			for(var k=0; k<smode_val.length; k++)
			{
				if ( smode_val[k] == eval("nv_wl_security_mode_"+i))
				{
					tmpflg = smode_name[k];
					break;
				}
			}
			tmp[4] = new Array("td_smode"+i,tmpflg,3);
			tmpflg=__T(share.disabled);
			if ( eval("nv_wl_macfilter_enable_"+i) == "1" ) tmpflg = __T(share.enabled);
			tmp[5] = new Array("td_filter"+i,tmpflg,3);
			if ( ap_mode == "0" ) 
				tmp[6] = new Array("wl_vlan_"+i,eval("nv_wl_vlan_id_"+i),2);
			else
				tmp[6] = new Array("wl_vlan_"+i,eval("nv_wl_ap_vlan_id_"+i),2);
			tmpflg = "";
			if ( eval("nv_wl_ap_isolate_"+i) == "1" ) tmpflg = "checked";
			tmp[7] = new Array("td_ap"+i,"<input type=checkbox id=ap_isolate_"+i+" name=ap_isolate_"+i+" "+tmpflg+" disabled>",3);
			tmpflg = "";
			if ( eval("nv_wl_wme_bss_disable_"+i) == "0" ) tmpflg = "checked";
			tmp[8] = new Array("td_bss"+i,"<input type=checkbox id=wme_bss_disable_"+i+" name=wme_bss_disable_"+i+" "+tmpflg+" disabled onClick=chk_wme(this.form)>",3);
			//bss_maxassoc
			if ( eval("nv_wl_bss_enabled_"+i) == "1" )
				tmp[9] = new Array("td_bss_maxassoc"+i,eval("nv_wl_bss_maxassoc_"+i),2);
			else
				tmp[9] = new Array("td_bss_maxassoc"+i,0,2);
			tmpflg = "";
			if ( eval("nv_wl_wps_mode_"+i) == "enabled" ) tmpflg = "checked";	
			tmp[10] = new Array("td_wps"+i,"<input type=checkbox id=wps_mode_"+i+" name=wps_mode_"+i+" "+tmpflg+" disabled onclick=chk_wps("+i+")>",3);
			if ( ap_mode == "0") 
			{
			var _name = new Array(__T(wl.selprofile)<% get_profile("name"); %>,__T(wl.newprofile));
			var _val = new Array("-3"<% get_profile("name"); %>,"-1");
			tmp[11] = new Array("tdpname"+i,draw_td(O_VAR,ICONLINE,"img_profile"+i, draw_object(O_VAR,SELBOX,"gn_profile_"+i," onMouseMove=showHint('img_profile"+i+"','div_profile"+i+"',event) onMouseOut=hideHint('div_profile"+i+"') onchange=sel_profile(this.form,"+i+") disabled",_name,_val,eval("nv_gn_profile_"+i)),"div_profile"+i),3);
			var tmpflg = "";
			if ( eval("nv_gn_enable_"+i) == "1" ) tmpflg = "checked";
			tmp[12] = new Array("tdchkgn"+i,draw_td(O_VAR,ICONLINE,"img_en"+i, "<input type=checkbox id=gn_enable_"+i+" name=gn_enable_"+i+" "+tmpflg+" disabled onclick=gn_chk("+i+") onMouseMove=showHint('img_en"+i+"','div_en"+i+"',event) onMouseOut=hideHint('div_en"+i+"')>","div_en"+i),3);
			}
			add_row(i,tmp,"","add",3);	
		}
		if ( document.getElementById("tmsg") )
			document.getElementById("tmsg").innerHTML = "";
		</script>
		</TR>
     </TABLE>
<input type=hidden name=all_page_end>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
