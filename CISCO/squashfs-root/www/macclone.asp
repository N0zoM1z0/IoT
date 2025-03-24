<html>
<head>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var http_client_mac = "<% nvram_get("http_client_mac"); %>";
function init()
{
	var F = document.frm_clone;
	parent.document.getElementById("save_bg").style.display="none";
	CloneMAC(F,"<% nvram_get("def_hwaddr"); %>");
	CHK_EN(F);
        if("<% nvram_get("http_from"); %>" == "wan" && ap_mode != "1" ) 
		DISABLE_PART(F,"all_start","all_end",1);
	default_nv = keep_val(F,"");
}

function uiDoSave(F){
	if ( F._mac_clone_enable.checked && !valid_value(F) )	
		return false;
	F.submit_button.value="macclone";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function CloneMAC(F,mac){
	if ( mac == "00:00:00:00:00:00" ) mac = "<% nvram_get("wan_hwaddr"); %>";
	var tmp = mac.split(":");
	for(var i=0; i<tmp.length; i++)
		eval("F.def_hwaddr_"+i).value = tmp[i];
}
function CHK_EN(F){
	F.mac_clone_enable.value=0;
	DISABLE_PART(F,"hwaddr_start","hwaddr_end",1);
	if ( F._mac_clone_enable.checked == true )
	{
		F.mac_clone_enable.value=1;
		DISABLE_PART(F,"hwaddr_start","hwaddr_end",0);
	}
}

function valid_value(F)
{
	var even_flg;
	var hwaddr="";
	for(var i=0; i<6; i++)
	{
		hwaddr += eval("F.def_hwaddr_"+i).value;
		even_flg=1;
		if ( i == 0 ) even_flg=0;
		if ( !chk_mac(eval("F.def_hwaddr_"+i).value,even_flg,i) ) 
			return false;
	}
	var errmsg = valid_macs_all(hwaddr);
	if ( errmsg != ""){
		document.getElementById("msgtr").style.display="";
		my_alert(O_VAR,"def_hwaddr",errmsg,"6","_hwaddr","down");
		return false;
		
	}
	return true;
	
}

function chk_mac(obj_val,must_even,item_id){
	var tmpmac="";
	for(var i=0; i<6; i++){
		clear_msg("def_hwaddr_"+i,"_hwaddr");
		tmpmac +=document.getElementById("def_hwaddr_"+i).value;
	}
	var returnmsg = valid_macs_all(tmpmac);
	document.getElementById("msgtr").style.display="none";
	if ( returnmsg != "" ){
		document.getElementById("msgtr").style.display="";
		my_alert(O_VAR,"def_hwaddr",returnmsg,"6","_hwaddr","down");
		return false;
	} 	
	return true;
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_clone" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=mac_clone_enable>
<div class=content_layer id=divcontent>
<input type=hidden name=all_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.macclone));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(lan.macclone),"","colspan=2");</script>
		<input type=checkbox name=_mac_clone_enable onclick=CHK_EN(this.form) <% nvram_match("mac_clone_enable","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>					
		<input type=hidden name=hwaddr_start>
		<TR id=msgtr style=display:none><script>draw_td(O_GUI,SUBTITLE,"","colspan=2");</script>
		<span id=_hwaddr></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.macaddr),"","colspan=2 "+SPACE_DOWN,SPACE_DOWN);</script>
		<input type=hidden name="def_hwaddr" value="6">
        	<input name="def_hwaddr_0" id="def_hwaddr_0" size=1 maxlength=2 onBlur=chk_mac(this.value,0,0)> : 
		<input name="def_hwaddr_1" id="def_hwaddr_1" size=1 maxlength=2 onBlur=chk_mac(this.value,1,1)> : 
		<input name="def_hwaddr_2" id="def_hwaddr_2" size=1 maxlength=2 onBlur=chk_mac(this.value,1,2)> : 
		<input name="def_hwaddr_3" id="def_hwaddr_3" size=1 maxlength=2 onBlur=chk_mac(this.value,1,3)> : 
		<input name="def_hwaddr_4" id="def_hwaddr_4" size=1 maxlength=2 onBlur=chk_mac(this.value,1,4)> : 
		<input name="def_hwaddr_5" id="def_hwaddr_5" size=1 maxlength=2 onBlur=chk_mac(this.value,1,5)> 
		<script>
		draw_object(O_GUI,BT,__T(lan.clonepcmac),"t1","BT_L","CloneMAC(this.form,\""+http_client_mac+"\")");
		</script>
		</td></tr>
		<input type=hidden name=hwaddr_end>
        </TABLE>
<% web_include_file("BT.asp"); %>
<input type=hidden name=all_end>
</TABLE>
</div>
</form>
</body></HTML>
