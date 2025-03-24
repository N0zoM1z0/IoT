<html>
<head>
<title>Session Timeout</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.frmtimeout,"");
	 
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("device.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function chk_hostname(obj)
{
	clear_msg("wan_hostname","_wan_hostname");
        var errmsg = valid_hostname(obj);
        if ( errmsg != "" )
        {
                my_alert(O_VAR,"wan_hostname",__T(msg.hostnameformat2),"0","_wan_hostname");
                return false;
        }
        return true;
}


function uiDoSave(F)
{
	if ( !chk_hostname(F.wan_hostname.value) ) return false;
	if ( !is_check_domain(F.wan_domain.value)) return false;
	F.submit_button.value = "device";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function is_check_domain(val)
{
        clear_msg("wan_domain","_wan_domain");
        if ( val != "" && !check_domain(val) ) 
        {       
                my_alert(O_VAR,"wan_domain",__T(msg.validname),"0","_wan_domain");
                return false;
                
        }
        return true;
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtimeout method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.devicepro),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.hostname));</script>
		<TABLE><TR><TD><script>
		document.write("<input size=20 id=wan_hostname name=wan_hostname maxlength="+HOSTNAME_MAX_LEN+" value='<% nvram_get("wan_hostname"); %>' onblur=chk_hostname(this.value);>");
		</script></TD><TD>
		<span id=_wan_hostname></span></TD></TR></TABLE></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.domainname),SPACE_DOWN,SPACE_DOWN);
		document.write("<input size=20 id=wan_domain name=wan_domain maxlength="+DOMAINNAME_MAX_LEN+" value='<% nvram_get("wan_domain"); %>' onblur=is_check_domain(this.value)>");
		</script>
		<SPAN id=_wan_domain></SPAN></TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
