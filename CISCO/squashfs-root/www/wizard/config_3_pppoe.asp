<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
function goto_guide()
{
	window.showModalDialog(goto_link('guide_conn_type.asp'),'Wizard','dialogLeft:450px;dialogTop:200px;resizable:no;status:no;scroll:no;dialogWidth:360px;dialogHeight:385px;center:yes;');
	
}

function uiDoCancel(F)
{
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	go_page(aging_time,"<% nvram_get("getting_start"); %>");
}

function init()
{
	var F = document.wz_cfg;
	var pname = parse_data("ppp_username");
	var ppwd=parse_data("ppp_passwd");
	F.accname.value = pname;
	F.pwd.value = ppwd;
}

function before_valid(F)
{
	var errflg=0;
	if ( !chk_name(F) ) errflg++;
	if ( !chk_pwd(F) ) errflg++;
	if ( errflg ) return false;
	return true;
}

function chk_name(F)
{
	w_clear_alert("msg_accname",0,"accname");
	w_clear_alert("msg_pwd",0,"pwd");
	if ( F.accname.value == "" ) 
	{
		w_set_alert("msg_accname",0,"accname",__T(msg.notblank));
		return false;
	}
	return true;
}

function chk_pwd(F)
{
	if ( F.pwd.value == "" ) 
	{
		w_set_alert("msg_pwd",0,"pwd",__T(msg.notblank));
		return false;
	}else{
		if ( F.pwd.value != F.cf_pwd.value ) 
		{
			w_set_alert("msg_pwd",0,"pwd",__T(wz.cmppwdnotmatch));
			return false;
		}
	}
	return true;
}

function goto_next(F)
{
	if ( !before_valid(F) ) return false;
	save_data("ppp_username",F.accname.value);
	save_data("ppp_passwd",F.pwd.value);
        document.location.href=goto_link("config_4.asp");
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_cfg" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(2,3);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setpppoe);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.setpppoemsg);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM><script>Capture(wz.ispnet);</script></TD></TR>
    <TR><TD valign=top class=DATA_ITEM2>
    <TABLE>
           <TR><TD><script>Capture(wz.accountname);</script></TD><TD><input size=40 name=accname id=accname maxlength=63 onblur=chk_name(this.form)>
	   <span id=msg_accname></span> 
	   </TD></TR>
           <TR><TD><script>Capture(share.password);</script></TD><TD><input size=40 name=pwd type=password maxlength=63 id=pwd onblur=chk_name(this.form)>
	   <span id=msg_pwd></span> 
	   </TD></TR>
           <TR><TD><script>Capture(wz.confirmpwd);</script></TD><TD><input size=40 name=cf_pwd type=password maxlength=63 id=cf_pwd onblur=chk_name(this.form)>
	   </TD></TR>
    </TABLE>
    </TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=goto_link(\"config_2.asp\")","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
