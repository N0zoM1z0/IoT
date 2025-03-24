<html>
<head>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
function init()
{
	if ( parent.document.getElementById("hidden_bg").style.display == "" ) 
	{
		top.location.href = goto_link("default.asp");
	}else
		parent.document.getElementById("save_bg").style.display="none";
	var F = document.frm_work;
	default_nv = keep_val(F,"");
}

function WL_result(val)
{
	alert_result(0);
	var F = document.frm_work;
	if ( val == 1 ) 
	{
		F.submit_button.value="workmode";
		F.gui_action.value="Apply";
		F.submit();
		parent.document.getElementById("hidden_bg").style.display="";
	}
}

function uiDoSave(F){
	var nv_val = "<% nvram_get("access_point_enable"); %>";
	
	if ( F.access_point_enable[0].checked ) 
	{
		if ( nv_val == "1" ) 
		{
			WL_result(1);
			return;
		}
	}
	else
	{
		if ( nv_val == "0" ) 
		{
			my_alert(O_GUI,WARNING,__T(share.info),__T(wl.msgapmode),"WL_result(1)","WL_result(0)","","yesno");
			return;
		}
		
	}
        my_alert(O_GUI,INFO,__T(share.info),__T(msg.nochange),"WL_result(0)");
	
	/*
	F.submit_button.value="workmode";
	F.gui_action.value="Apply";
	F.submit();
	if ( F.ap_mode.value != apmode ) 
	{
		parent.document.getElementById("hidden_bg").style.display="";
	}
	else
	{
		parent.document.getElementById("save_bg").style.display="";
	}*/
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_work" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<input type=hidden name=all_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.workmode));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.workmode),SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		var _name = new Array(__T(share.router),__T(router.ap));
		var _val = new Array("0","1");
		draw_object(O_GUI,RADIO,"access_point_enable",_val,_name,"<% nvram_get("access_point_enable"); %>");
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
