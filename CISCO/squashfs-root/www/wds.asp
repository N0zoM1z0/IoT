<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% wl_multi_nvram_get("wl_bss_enabled"); %>
var radio = "<% nvram_get("wl_radio"); %>";
var mac_cnt=1;
function init(){
	var disflg=1;
	var F = document.frmwds;
	parent.document.getElementById("save_bg").style.display="none";
	//frames['clienttd'].location.href = goto_link("site_survey.asp");
	
	if ( eval("nv_wl_bss_enabled_0") != "0" ){
		for(var j=0; j<4; j++)
		{
			if ( eval("nv_wl_bss_enabled_"+j) == "1" ){
				disflg = 0;
				break;
			}
		}
	}
	if ( radio == "0" || disflg == 1 ) 
	{
		default_nv = keep_val(F,"");
		DISABLE_PART(F,"all_page_start","all_page_end",1);
		return;
	}
	chkenwds(F);
		
	var r_mac_list = "<% nvram_get("wl_wds_repeater_other_maclist"); %>".split(",");
	var b_mac_list = "<% nvram_get("wl_wds_bridge_maclist"); %>".split(",");
	for(var i=0; i<r_mac_list.length; i++)
		document.getElementById("rmac"+i).value = r_mac_list[i]; 
		//document.getElementById("rmac"+i).value = mac12to17(r_mac_list[i]); 
	for(var i=0; i<b_mac_list.length; i++)
		document.getElementById("bmac"+i).value = b_mac_list[i]; 
		//document.getElementById("bmac"+i).value = mac12to17(b_mac_list[i]); 
	default_nv = keep_val(F,"");
}

function ViewClient(){
	var F = document.frmwds;
	if ( F._wl_wds_enable.checked == false || F.wl_wds_repeater_mode[0].checked == true || F.wl_wds_mode[0].checked == true || radio == "0" ) return;
	frames['clienttd'].location.href = goto_link("site_survey.asp");
	document.getElementById("clienttd").style.display="";
	available_count(F);
        SHOW_HIDDEN_TABLE("table_title","clienttd","tb_img",__T(wl.showsitesurvey),__T(wl.hidesitesurvey));
}

function available_count(F){
	if ( typeof frames['clienttd'].document.frmsite == "undefined" ) return;
	var tmpval= frames['clienttd'].document.frmsite.allow_count;
	var cnt=0;
	for(var i=0; i<mac_cnt; i++)
	{
		
		if ( F.mac0.value == "" ) 
		{
			if ( tmpval.value != "" ) tmpval.value +=",";
			tmpval.value+=i;
			cnt++;
		}
	}
	document.getElementById("clienttd").contentWindow.init();
	document.getElementById("clienttd").contentWindow.init_cnt(cnt);
} 

function chk_mac(val,idx,obj_id,span_id)
{
	var F = document.frmwds;
	//available_count(F);
	clear_msg(obj_id+idx,span_id+idx);
	if ( eval("F."+obj_id+idx).value == "" ) return true;
	var errmsg = valid_macs_all(val);
	if ( errmsg != "" )
	{
		my_alert(O_VAR,obj_id+idx,errmsg,"0",span_id+idx);
		return false;
	}
	else{ 
		errmsg = valid_meaning_id_name(MEANING_NAME,val,SPACE_NO);
		if ( errmsg != "" )
		{
			my_alert(O_VAR,obj_id+idx,errmsg,"0",span_id+idx);
			return false;
		}
	}
	return true;
}

function same_mac_addr(m1,m2)
{
	if ( m1 == "" || m2 == "" ) return false;
	var t1 = mac12to17(m1).toUpperCase(); 
	var t2 = mac12to17(m2).toUpperCase(); 
	if ( t1 == t2 ) return true;
	return false;
}

function valid_check(F)
{
	var errflg = 0 ;
	for(var i=0; i<mac_cnt; i++)
	{ 
		if ( !chk_mac(eval("F.mac"+i).value,i,"mac","msg_mac") ) errflg = 1;
	}
	for(var i=0; i<4; i++)
	{
		if ( !chk_mac(eval("F.rmac"+i).value,i,"rmac","msg_rmac") ) errflg = 1;
		if ( eval("F.rmac"+i).value == "" ) continue;
		for(var j=i+1; j<4; j++)
		{
			if ( same_mac_addr(eval("F.rmac"+i).value,eval("F.rmac"+j).value) )
			{
				//my_alert(O_VAR,"rmac"+i,__T(msg.macexist),"0","msg_rmac"+i);
				my_alert(O_VAR,"rmac"+j,__T(msg.macexist),"0","msg_rmac"+j);
				errflg = 1;
				break;
				
			}
		}
		if ( errflg == 1 ) break;
	}
	for(var i=0; i<4; i++)
	{
		if ( !chk_mac(eval("F.bmac"+i).value,i,"bmac","msg_bmac") ) errflg = 1;
		if ( eval("F.bmac"+i).value == "" ) continue;
		for(var j=i+1; j<4; j++)
		{
			if ( same_mac_addr(eval("F.bmac"+i).value,eval("F.bmac"+j).value) )
			{
				//my_alert(O_VAR,"bmac"+i,__T(msg.macexist),"0","msg_bmac"+i);
				my_alert(O_VAR,"bmac"+j,__T(msg.macexist),"0","msg_bmac"+j);
				errflg=1;
				break;
			}
		}
		if ( errflg == 1 ) break;
	}
	if ( errflg == 1 ) return false;
	return true;
	
}

function uiDoSave(F)
{
	if ( !valid_check(F) ) return;
	if ( F._wl_wds_enable.checked && F.wl_wds_mode[0].checked == true ) 
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(wl.wdsmsg),"wds_result(1)","wds_result(0)","","yesno");
	}else
		wds_result(1);
}

function wds_result(val)
{
	var F = document.frmwds;
	alert_result(0);
	if ( val == 1 ) 
	{
		var mac_tmp="";
		var errflg=0;
		var errmsg="";
		var rmac_list = "",bmac_list="";
		if ( !valid_check(F) ) return;
		if ( F._wl_wds_enable.checked ) F.wl_wds_enable.value = 1;
		else F.wl_wds_enable.value = 0;
		for(var i=0; i<4; i++)
		{
			if ( eval("F.rmac"+i).value != "" ) 
			{
				if ( rmac_list != "" ) rmac_list += ",";
				//rmac_list += eval("F.rmac"+i).value;
				rmac_list += mac12to17(eval("F.rmac"+i).value);
			}
		}
		for(var i=0; i<4; i++)
		{
			if ( eval("F.bmac"+i).value != "" ) 
			{
				if ( bmac_list != "" ) bmac_list += ",";
				//bmac_list += eval("F.bmac"+i).value;
				bmac_list += mac12to17(eval("F.bmac"+i).value);
			}
		}
		F.wl_wds_repeater_other_maclist.value = rmac_list;
		F.wl_wds_bridge_maclist.value = bmac_list;
		F.wl_wds_repeater_self_maclist.value = mac12to17(F.mac0.value);
		F.submit_button.value="Wireless_WDS";
		F.gui_action.value="Apply";
		F.next_page.value = "wds";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}

function chgmode(F)
{
	if ( F.wl_wds_mode[1].checked == true ) 
	{
		DISABLE_PART(F,"repeater_start","repeater_end",0);
		DISABLE_PART(F,"bridge_start","bridge_end",1);
		chgrepmode(F);
	}else{
		DISABLE_PART(F,"repeater_start","repeater_end",1);
		DISABLE_PART(F,"bridge_start","bridge_end",0);
	}
//	chgrepmode(F);
}

function chgrepmode(F)
{
	if ( F.wl_wds_repeater_mode[0].checked == true ){ 
		DISABLE_PART(F,"auto_start","auto_end",0);
		DISABLE_PART(F,"auto_end","repeater_end",1);
	}else{
		DISABLE_PART(F,"auto_start","auto_end",1);
		DISABLE_PART(F,"auto_end","repeater_end",0);
	}
	choose_enable(F.wl_wds_repeater_mode[1]);
}

function en_wds(F)
{
	chkenwds(F);
	
}

function chkenwds(F)
{
	if ( F._wl_wds_enable.checked == false ) 
	{
		DISABLE_PART(F,"all_page_start","all_page_end",1);
		if ( http_power == "rw" )
		{
			choose_enable(document.getElementById("c1"));
			choose_enable(document.getElementById("c2"));
		}
		choose_enable(F._wl_wds_enable);
	}else{
                //my_alert(O_GUI,INFO,__T(share.info),__T(wl.wdsmsg),"alert_result(0)");
		DISABLE_PART(F,"all_page_start","all_page_end",0);
		chgmode(F);
	}
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmwds method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=next_page>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=wl_wds_enable>
<input type=hidden name=wl_wds_repeater_other_maclist>
<input type=hidden name=wl_wds_repeater_self_maclist>
<input type=hidden name=wl_wds_bridge_maclist>
<input type=hidden name=wl_mac>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=all_page_start>
<div class=content_layer id=divcontent>
<input type=hidden name=all_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.wds),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=4");
		Capture(wl.wdsmacaddr)</script>:&nbsp;<% nvram_get("wl0_hwaddr"); %></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"width=10%");
		document.write(wl.wds);
		</script>
		</TD><TD colspan=3 class=SUBTITLE_M>
		<input type=checkbox name=_wl_wds_enable id=_wl_wds_enable onclick=en_wds(this.form) <% nvram_match("wl_wds_enable", "1", "checked"); %>><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"")
		document.write(router.mode);
		</script></TD><TD colspan=3 class=SUBTITLE_M>
		<script>
		//var _name = new Array(__T(wl.wdsrepeater),__T(wl.wdsbridge));
		//var _val = new Array("repeater","bridge");
		var _name = new Array(__T(wl.wdsbridge));
		var _val = new Array("bridge");
		draw_object(O_GUI,RADIO,"wl_wds_mode",_val,_name,"<% nvram_get("wl_wds_mode"); %>","onclick=chgmode(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=bridge_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 width=20%");</script>
		</TD><TD colspan=2 class=SUBTITLE_M>
		<script>Capture(wl.remotewlbridge);</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"1"));</script></TD><TD class=SUBTITLE_M>
		<input size=30 id=bmac0 name=bmac0 maxlength=17 onblur=chk_mac(this.value,"0","bmac","msg_bmac")>
                <script>document.write("&nbsp;&nbsp;"+spell_words(hint_or_rule,"00:11:22:33:44:55","001122334455"));</script>
		<span id=msg_bmac0></SPAN>
		</TD></TR> 
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"2"));</script></TD><TD class=SUBTITLE_M>
		<input size=30 id=bmac1 name=bmac1 maxlength=17 onblur=chk_mac(this.value,"1","bmac","msg_bmac")>
		<span id=msg_bmac1></SPAN>
		</TD></TR> 
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"3"));</script>
		</TD><TD class=SUBTITLE_M>
		<input size=30 id=bmac2 name=bmac2 maxlength=17 onblur=chk_mac(this.value,"2","bmac","msg_bmac")>
		<span id=msg_bmac2></SPAN>
		</TD></TR> 
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"4"));</script>
		</TD><TD class=SUBTITLE_M>
		<input size=30 id=bmac3 name=bmac3 maxlength=17 onblur=chk_mac(this.value,"3","bmac","msg_bmac")>
		<span id=msg_bmac3></SPAN>
		</TD></TR>
		<input type=hidden name=bridge_end>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"")</script>
		</TD><TD colspan=3 class=SUBTITLE_M>
		<script>
		var _name = new Array(__T(wl.wdsrepeater));
		var _val = new Array("repeater");
		draw_object(O_GUI,RADIO,"wl_wds_mode",_val,_name,"<% nvram_get("wl_wds_mode"); %>","onclick=chgmode(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=repeater_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD colspan=2 class=SUBTITLE_M>
		<script>
		var _name = new Array(__T(wl.allowwlsignal));
		var _val = new Array("signal_repeated_by_other");
		draw_object(O_GUI,RADIO,"wl_wds_repeater_mode",_val,_name,"<% nvram_get("wl_wds_repeater_mode"); %>","onclick=chgrepmode(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=auto_start>
                <TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"1"));</script>
		</TD><TD class=SUBTITLE_M>
                <input size=30 id=rmac0 name=rmac0 maxlength=17 onblur=chk_mac(this.value,"0","rmac","msg_rmac")>
                <span id=msg_rmac0></SPAN>
                </TD></TR> 
                <TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"2"));</script>
		</TD><TD class=SUBTITLE_M>
                <input size=30 id=rmac1 name=rmac1 maxlength=17 onblur=chk_mac(this.value,"1","rmac","msg_rmac")>
                <span id=msg_rmac1></SPAN>
                </TD></TR> 
                <TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"3"));</script>
		</TD><TD class=SUBTITLE_M>
                <input size=30 id=rmac2 name=rmac2 maxlength=17 onblur=chk_mac(this.value,"2","rmac","msg_rmac")>
                <span id=msg_rmac2></SPAN>
                </TD></TR> 
                <TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M>
		<script>document.write(spell_words(mac_rule,"4"));</script>
		</TD><TD class=SUBTITLE_M>
                <input size=30 id=rmac3 name=rmac3 maxlength=17 onblur=chk_mac(this.value,"3","rmac","msg_rmac")>
                <span id=msg_rmac3></SPAN>
                </TD></TR> 
                <input type=hidden name=auto_end>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD colspan=2 class=SUBTITLE_M>
		<script>
		var _name = new Array(__T(wl.allowwlsignalself));
		var _val = new Array("signal_repeated_by_self");
		draw_object(O_GUI,RADIO,"wl_wds_repeater_mode",_val,_name,"<% nvram_get("wl_wds_repeater_mode"); %>","onclick=chgrepmode(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD colspan=2 class=SUBTITLE_M>
		<script>
		document.write(__TC(wl.remoteacc));
		draw_object(O_GUI,TABLE_BT,"tb_img","ViewClient()","table_title",__T(wl.showsitesurvey));
		</script>
		<TR id=clientTB><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD colspan=2 class=SUBTITLE_M>
		<iframe frameborder=0 width=750px height=250px style="overflow:hidden;display:none" allowtransparency=true id=clienttd name=clienttd>
		</iframe>
		<!--% web_include_file("site_survery.asp"); %-->
		</TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		</TD><TD class=SUBTITLE_M style="padding-bottom:10px" ><script>document.write(spell_words(mac_rule,""));</script></TD>
		<TD class=SUBTITLE_M style="padding-bottom:10px">
		<input size=30 name=mac0 id=mac0 maxlength=17 value="<% nvram_get("wl_wds_repeater_self_maclist"); %>" onblur=chk_mac(this.value,"0","mac","msg_mac")>
		<span id=msg_mac0></SPAN>
		</TD></TR> 
		<input type=hidden name=repeater_end>
	        </TABLE>
<input type=hidden name=all_page_end>
		<% web_include_file("BT.asp"); %>
<input type=hidden name=all_end>
</TD></TR>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
