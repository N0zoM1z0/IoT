<html>
<head>
<title>Time of Date Access</title>
<script type="text/javascript" src="/md5.js"></script>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
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

function chk_value(F)
{
	var errflg = 0 ;
	clear_msg("guestpwd","msg_guestpwd");
	clear_msg("guest_leasetime","msg_leasetime");
	if ( F.guestpwd.value == "" ) 
	{
		my_alert(O_VAR,"guestpwd",__T(msg.notblank),0,"msg_guestpwd");
		return false;
		
	}
	if ( F.guest_leasetime.value == "" ) 
	{
		my_alert(O_VAR,"guest_leasetime",__T(msg.notblank),0,"msg_guest_leasetime");
		return false;
	}
	if ( F.guestpwd.value != F.guestpwd_v.value ) 
	{
		my_alert(O_VAR,"guestpwd",__T(msg.pwdinvmatch),0,"msg_guestpwd");
		errflg = 1;
	}
	if ( !msg_chk_range(F.guest_leasetime.value,"guest_leasetime",1,9999,10,IS_FIELD,0,"msg_leasetime") )
	{
		errflg = 1;
	}
	if ( errflg ) return false;
	return true;
	
}

function uiDoSave(F)
{
	if ( !chk_value(F) ) return;
	F.guestpwd.value = en_value(F.guestpwd.value);
	F.submit_button.value="access_gnet";
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
	F.submit_button.value = "access_gnet";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtime method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=nvset_cgi value=wireless>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.gnetsetting),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.gnetname));</script>
		guest
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.gnetpwd));</script>
		<input size=20 maxlength=64 name=guestpwd id=guestpwd type=password>
		<SPAN id=msg_guestpwd></SPAN>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.retypegnetpwd));</script>
		<input size=20 maxlength=64 name=guestpwd_v id=guestpwd_v type=password>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.leasetime),SPACE_DOWN,SPACE_DOWN);</script>
		<input size=20 maxlength=4 name=guest_leasetime id=guest_leasetime value=120>&nbsp;<script>Capture(unit.minutes);</script><SPAN id=msg_guest_leasetime></SPAN>
		</TD></TR>	
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
