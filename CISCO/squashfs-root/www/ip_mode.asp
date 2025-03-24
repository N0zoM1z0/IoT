<html>
<head>
<title></title>
<% web_include_file("filelink.asp"); %>
<script>
var dns0 = "<% nvram_get("dns_entry_6to40"); %>";
var dns1 = "<% nvram_get("dns_entry_6to41"); %>";
var dns2 = "<% nvram_get("dns_entry_6to42"); %>";
var dns3 = "<% nvram_get("dns_entry_6to43"); %>";
var dns4 = "<% nvram_get("dns_entry_6to44"); %>";
CHK_VALUE_AUTO=0;
var lan_mode = "<% nvram_get("lan_ip_mode"); %>"; 
var wan_mode = "<% nvram_get("wan_ip_mode"); %>"; 
function sel_mode(F)
{
	if ( F.ip_mode[F.ip_mode.selectedIndex].value == "0" || //LAN:IPv4,WAN:IPv4
	     F.ip_mode[F.ip_mode.selectedIndex].value == "2" || //LAN:IPv6,WAN:IPv6
	     F.ip_mode[F.ip_mode.selectedIndex].value == "4" || //LAN:IPv4+IPv6,WAN:IPv4+IPv6
	     F.ip_mode[F.ip_mode.selectedIndex].value == "5" ) //LAN:IPv4,WAN:IPv6 
	{
		document.getElementById("tb_img").src = "image/showDis.gif";
		document.getElementById("table_title").innerHTML = __T(router.showst6to4dns);
                document.getElementById("dns_table").style.display="none";
	}else{
		if ( document.getElementById("tb_img").src.indexOf("image/showDis") != -1 )
		{
			document.getElementById("table_title").innerHTML = __T(router.showst6to4dns);
			document.getElementById("tb_img").src = "image/show.gif";
                	document.getElementById("dns_table").style.display="none";
		}
	}
}
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmip;
	for(var i=0; i<5; i++)
	{
		if ( eval("dns"+i) == "" ) break;
		var tmp = eval("dns"+i).split(",");
		eval("F.domain"+i).value = tmp[0];
		eval("F.ip"+i).value = full_ipv6(tmp[1]);
	}
	if ( lan_mode == "1" && wan_mode == "1" ) //LAN is IPv4 Only
		F.ip_mode.selectedIndex = 0;
	else if ( lan_mode == "2" && wan_mode == "2")
		F.ip_mode.selectedIndex = 2;
	else if ( lan_mode == "2" && wan_mode == "1")
		F.ip_mode.selectedIndex = 1;
	else if ( lan_mode == "3" && wan_mode == "1" ) 
		F.ip_mode.selectedIndex = 3;
	else if ( lan_mode == "3" && wan_mode == "3" ) 
		F.ip_mode.selectedIndex = 4;
	else if ( lan_mode == "1" && wan_mode == "2" ) 
		F.ip_mode.selectedIndex = 5;
	sel_mode(F);
	default_nv = get_data(F);
        document.getElementById("dns_table").style.display="none";
}

function ViewTB()
{
	if ( document.getElementById("tb_img").src.indexOf("image/showDis") != -1 ) return;
        SHOW_HIDDEN_TABLE("table_title","dns_table","tb_img",__T(router.showst6to4dns),__T(router.hidest6to4dns));
}

function get_data(F){
	var data="";
	if ( F.ip_mode.selectedIndex == 0 ) 
		data += "1,";
	else if ( F.ip_mode.selectedIndex == 3 ) 
		data += "3,";
	else
		data += "2,";
	if ( F.ip_mode.selectedIndex == 2 ) 
		data += "1,";
	else
		data += "0,";
	for( var j=0; j<5; j++)
	{
		data += eval("F.domain"+j).value+",";
		data += eval("F.ip"+j).value+",";
	}	
	return data;

}


function valid_value(F){
	var errflg=0;
	var errmsg="";
	for(var j=0; j<5; j++)
	{
		errmsg = "";
		if ( eval("F.domain"+j).value == "" && eval("F.ip"+j).value == "" )  continue;
		if ( eval("F.domain"+j).value != "" && eval("F.ip"+j).value == "" ) 
		{
			parent.document.getElementById("obj_id").value = "msg_ip"+j;
			my_alert(O_VAR,"ip"+j,__T(msg.notblank),"0","msg_ip"+j,"down");
			errflg=1				
		}
		if ( eval("F.domain"+j).value == "" && eval("F.ip"+j).value != "" )
                {
                        parent.document.getElementById("obj_id").value = "msg_domain"+j;
                        my_alert(O_VAR,"domain"+j,__T(msg.notblank),"0","msg_domain"+j,"down");
                        errflg=1
                }
		if ( !check_domain(eval("F.domain"+j).value) ) 
		{
                        parent.document.getElementById("obj_id").value = "msg_domain"+j;
                        my_alert(O_VAR,"domain"+j,__T(msg.ivaliddomainformat),"0","msg_domain"+j,"down");
                        errflg=1
			
		}
		errmsg = valid_ipv6(eval("F.ip"+j).value);
		if ( errmsg != "" )
		{
			my_alert(O_VAR,"ip"+j,errmsg,"0","msg_ip"+j,"down");
			errflg = 1;
		}  
		for(var i=0; i<5; i++)
		{
			
			if ( eval("F.domain"+i).value == "" || i == j ) continue; 
			if ( eval("F.domain"+j).value == eval("F.domain"+i).value ) 
			{
                        	parent.document.getElementById("obj_id").value = "msg_domain"+i;
	                        my_alert(O_VAR,"domain"+i,__T(msg.domainexist),"0","msg_domain"+i,"down");
				errflg=1;
			}
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function uiDoSave(F){
	if ( !valid_value(F) ) return false;
	my_alert(O_GUI,INFO,__T(share.info),__T(msg.ipmode),"mode_alert_result(1)");
}

function mode_alert_result(val)
{
	var F = document.frmip;
	alert_result(0);
	if ( val == 1 ) 
	{
		if ( F.ip_mode.selectedIndex == 0 ) 
		{
			F.lan_ip_mode.value = "1";
			F.wan_ip_mode.value = "1";
		}else if ( F.ip_mode.selectedIndex == 1 ) 
		{
			F.lan_ip_mode.value = "2";
			F.wan_ip_mode.value = "1";
		}else if ( F.ip_mode.selectedIndex == 2 ) 
		{
			F.lan_ip_mode.value = "2";
			F.wan_ip_mode.value = "2";
		}else if ( F.ip_mode.selectedIndex == 3 ) 
		{
			F.lan_ip_mode.value = "3";
			F.wan_ip_mode.value = "1";
		}else if ( F.ip_mode.selectedIndex == 4 ) 
		{
			F.lan_ip_mode.value = "3";
			F.wan_ip_mode.value = "3";
		}else if ( F.ip_mode.selectedIndex == 5 ) 
		{
			F.lan_ip_mode.value = "1";
			F.wan_ip_mode.value = "2";
		}

		if ( F.lan_ip_mode.value == "1" ) 
			F.chg_lan_mode.value = "ipv4";
		else
			F.chg_lan_mode.value = "ipv6";
		 
		F.dns_entry_6to4.value = "";
		for(var i=0; i<5; i++)
		{
			if ( eval("F.domain"+i).value == "" ) continue;
			if ( F.dns_entry_6to4.value != "") F.dns_entry_6to4.value+=";";
			F.dns_entry_6to4.value += eval("F.domain"+i).value+","+eval("F.ip"+i).value;
		}
		F.submit_button.value = "ip_mode";
		F.submit();
		parent.document.getElementById("hidden_bg").style.display="";
	}
}

</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=frmip onSubmit="return false;" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=dns_entry_6to4>
<input type=hidden name=lan_ip_mode>
<input type=hidden name=wan_ip_mode>
<input type=hidden name=chg_lan_mode>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.ipmode));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipmode));
		var _name = new Array(__T(lan.l4w4),__T(lan.l6w4),__T(lan.l6w6),__T(lan.l46w4),__T(lan.l46w46),__T(lan.l4w6));
		var _val = new Array("0","1","2","3","4", "5");
		draw_object(O_GUI,SELBOX,"ip_mode","onChange=sel_mode(this.form)",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN);</script>
		<script>
		draw_object(O_GUI,TABLE_BT,"tb_img","ViewTB()","table_title",__T(router.showst6to4dns));
		</script>
		</TD></TR>
		<TR id=dns_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		document.write("<TABLE width=100%>");
		for(var j=0; j<5; j++)
		{
			tmpflg = "";
			tmpflg = SPACE_DOWN;
			document.write("<TR><TD id=msg_domain"+j+"></TD><TD id=msg_ip"+j+"></TD></TR>");
			document.write("<TR><TD width=40% "+tmpflg+">");
			document.write(spell_words(domain_rule,"0"+(j+1))+":&nbsp;&nbsp;<input size=30 name=domain"+j+" id=domain"+j+"></TD>");
			document.write("<TD "+tmpflg+">"+spell_words(ip_rule,"0"+(j+1))+":&nbsp;&nbsp;<input size=51 maxlength=39 name=ip"+j+" id=ip"+j+"></TD></TR>");
		}
		document.write("</TABLE></TD></TR>");
		</script>	
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
