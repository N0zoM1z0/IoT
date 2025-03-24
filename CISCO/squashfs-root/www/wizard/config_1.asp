<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
var portlist = new Array();
<% get_port_st("portlist"); %>
var conn_fail="none";
function init()
{
	var F = document.wz_cfg;
	var stype = parse_data("service_type");
	if ( stype != "" ) 
		F.service_type[stype].checked = true;
}


function goto_next(F)
{
	if ( conn_fail == "none" ) 
	{
		if ( F.service_type[0].checked || F.service_type[1].checked ) 	
			document.getElementById("td_st").innerHTML = "<TABLE><TR><TD><img src=../image/inProgress.gif></TD><TD>Determining network configuration...</TD></TR></TABLE>";
		choose_disable(document.getElementById("w2"));
		setTimeout('get_status()', 2000);		
	}else
		get_page();		
}

function get_status()
{
	if ( portlist[4] != __T(router.down) )//UP
		conn_fail=0;
	else conn_fail=1;
	if ( conn_fail != "none" ) 
	{
		document.getElementById("td_st").innerHTML = "<TABLE><TR><TD colspan=2>If you are not sure what the correct internet connection type should be, call your Internet Service Provider.</TD></TR></TABLE>";
	}
	choose_enable(document.getElementById("w2"));
}

function get_page()
{
	var F = document.wz_cfg;
	var str="";
	if ( F.service_type[0].checked ) 
		str="0";
	else if ( F.service_type[1].checked )
		str="1";
	else if ( F.service_type[2].checked )
		str="2";
	save_data("service_type",str);
        document.location.href=goto_link("config_2.asp");
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
    <TR><TD class=DATA_TITLE2 colspan=4>Configure Router - Internet Service Provider Information (step 1 of 5)</TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    Cisco Setup Wizard is trying to determine your Internet connection type.</TD></TR>
    <TR><TD valign=top class=DATA_ITEM>How do you get your Internet service?</TD></TR>
    <TR><TD valign=top class=DATA_ITEM2><input type=radio name=service_type value=0 checked >Cable broadband<BR>
    <input type=radio name=service_type value=1 >Telephone (DSL)<BR>
    <input type=radio name=service_type value=2 >I don't know</TD></TR>
    <TR><TD valign=top class=DATA_ITEM id=td_st>
    </TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4>Click Next to continue.</TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("onClick=document.location.href=\"conn_1.asp\"","onClick=goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
