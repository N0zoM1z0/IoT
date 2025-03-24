<html>
<head>
<title>Time of Date Access</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% wl_multi_nvram_get("wl_tda_enable"); %>
<% wl_multi_nvram_get("wl_tda_start"); %>
<% wl_multi_nvram_get("wl_tda_stop"); %>
var now_idx = "<% nvram_gozila_get("wl_vap_idx"); %>";
if ( now_idx == "" ) now_idx = "0";

var back_bt = "true";
var change_cancel_bt="true";
var sdata = eval("nv_wl_tda_start_"+now_idx).split(":");
var edata = eval("nv_wl_tda_stop_"+now_idx).split(":");
var _hour_name12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
var _hour_name24 = new Array("ISRANGE","0","23","1",2);
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmtime;
	chk_active(F);
	if ( flg_24 == 0 ) 
	{
		var sh,eh;
		if ( parseInt(sdata[0],10) >= 12 ) 
		{
			F.s_2[1].selected = true;
			sh = parseInt(sdata[0],10)-12;			
		}else
			sh = parseInt(sdata[0],10);
		if ( parseInt(edata,10) >= 12 ) 
		{
			F.e_2[1].selected = true;
			eh = parseInt(edata[0],10)-12;			
		}else
			eh = parseInt(edata[0],10);
		for(var i=0; i<_hour_name12.length; i++)
		{
			if ( parseInt(_hour_name12[i],10) == sh ) 
				F.s_0[i].selected = true;
			if ( parseInt(_hour_name12[i],10) == eh ) 
				F.e_0[i].selected = true;
		}
	}else{
		F.s_0[parseInt(sdata[0],10)].selected = true;
		F.e_0[parseInt(edata[0],10)].selected = true;
		
	}
	default_nv = keep_val(F,"");
}

function chk_active(F)
{
	if ( F._wl_tda_enable.checked == false ) 
		DISABLE_PART(F,"dis_start","dis_end",1);	
	else
		DISABLE_PART(F,"dis_start","dis_end",0);	
}

function uiDoSave(F)
{
	F.wl_tda_enable.value=0;
	if ( F._wl_tda_enable.checked == true ) 
		F.wl_tda_enable.value=1;
	if ( flg_24 == 0 ){
		F.wl_tda_start.value = trans_time_format(F.s_0.value,F.s_1.value,F.s_2.value);
		F.wl_tda_stop.value = trans_time_format(F.e_0.value,F.e_1.value,F.e_2.value);
	}else{
		F.wl_tda_start.value = F.s_0.value+":"+F.s_1.value;
		F.wl_tda_stop.value = F.e_0.value+":"+F.e_1.value;
	}
	var sdata=new Array();
	var edata=new Array();
	var start,end;
	sdata = F.wl_tda_start.value.split(":");
	edata = F.wl_tda_stop.value.split(":");
	start = parseInt(sdata[0],10)*60 + parseInt(sdata[1],10);
	end = parseInt(edata[0],10)*60 + parseInt(edata[1],10);
	if ( end <= start ) 
	{
		parent.document.getElementById("obj_id").value = "msg_time";
		my_alert(O_VAR,"e",__T(msg.timechk),"3","msg_time");
		return false;	
	}
	F.submit_button.value="Wireless_TDA";
	F.next_page.value="Wireless_Manual";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_back(F){
	parent.document.getElementById("newpage").value = "Wireless_Manual.asp";
	uiDoCancel(F,"back");
}

function refresh_page()
{
	alert_result(0);	
	var F = document.frmtime;
	F.submit_button.value = "access_time";
	F.change_action.value = "gozila_cgi";
	F.next_page.value="access_time.asp";
	F.submit();
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtime method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=next_page>
<input type=hidden name=wl_tda_enable>
<input type=hidden name=wl_tda_start>
<input type=hidden name=wl_tda_stop>
<input type=hidden name=wl_vap_idx value="<% nvram_gozila_get("wl_vap_idx"); %>">
<input type=hidden name=basic_idx value="<% nvram_gozila_get("basic_idx"); %>">
<input type=hidden name=nvset_cgi value=wireless>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.timeofdateacc),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.addeditconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.activetime));</script>
		<script>
		var chkflg = "";
		if ( eval("nv_wl_tda_enable_"+now_idx) == "1" ) chkflg = "checked";
		document.write("<input type=checkbox name=_wl_tda_enable "+chkflg+" onClick=chk_active(this.form)> "+__T(share.enable));
		</script>
                </TD></TR>
		<input type=hidden name=dis_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.stime));
		if ( flg_24 == 0 ) 
		{
			draw_object(O_GUI,SELBOX,"s_0","id=s_0",_hour_name12,_hour_name12); 
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			var _name = new Array("ISRANGE","0","55","5");
			draw_object(O_GUI,SELBOX,"s_1","id=s_1",_name,_name,sdata[1]); 
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("am","pm");
			draw_object(O_GUI,SELBOX,"s_2","id=s_2",_name,_val);
		}else{
			draw_object(O_GUI,SELBOX,"s_0","id=s_0",_hour_name24,_hour_name24); 
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			var _name = new Array("ISRANGE","0","55","5");
			draw_object(O_GUI,SELBOX,"s_1","id=s_1",_name,_name,sdata[1]); 
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}
		</script>
		</TD></TR>
		<TR><script>
		draw_td(O_GUI,SUBTITLE,__TC(mang.stoptime),SPACE_DOWN,SPACE_DOWN);
		if ( flg_24 == 0 ) 
		{
			draw_object(O_GUI,SELBOX,"e_0","id=e_0",_hour_name12,_hour_name12); 
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			var _name = new Array("ISRANGE","0","55","5");
			draw_object(O_GUI,SELBOX,"e_1","id=e_1",_name,_name,edata[1]); 
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("am","pm");
			draw_object(O_GUI,SELBOX,"e_2","id=e_2",_name,_val);
		}else{
			draw_object(O_GUI,SELBOX,"e_0","id=e_0",_hour_name24,_hour_name24); 
			document.write("&nbsp;"+__T(mang.hours)+"&nbsp;");
			var _name = new Array("ISRANGE","0","55","5");
			draw_object(O_GUI,SELBOX,"e_1","id=e_1",_name,_name,edata[1]); 
			document.write("&nbsp;"+__T(unit.minutes)+"&nbsp;");
		}
		</script>
		<span id=msg_time></span>
		</TD></TR>
		<input type=hidden name=dis_end>
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
