<html>
<head>
<% no_cache(); %>
<% js_link(0); %>
<script>
</script>
<script type="text/javascript" src="/position.js"></script>

<style fprolloverstyle>
BODY
{
  font-family:Arial;color:#000000;
  position:absolute;z-index:0;top:0px;left:0px;
  background-color:transparent;
  background-repeat:no-repeat;
  width:100%;
  height:100%;
  padding:0px;
  margin:0px;
  overflow:auto;
}

BODY,TD,SELECT,INPUT,P{
  font-size:12px;
  font-family:Arial;
  color:#000000;
}


.START_TABLE{
	width:100%;
}

.START_TITLE{
	background-color:#53636A;
	width:100%;
  	height:49px; 
	vertical-align:center; 
	text-left:right; 
	color:#FFFFFF; 
	font-size:18px;
	padding-left:10px;
}
.START_SUB_TITLE{
	padding-top:15px;
	padding-left:10px;
	padding-bottom:22px;
}

.START_SECTION{
	font-size:15px;
	color:#000000;	
	vertical-align:center; 
	text-align:left;
  	white-space:nowrap;
}

.START_SECTION1{
	width:5%;
	padding-left:10px;
	padding-right:13px;
	vertical-align:center; 
  	white-space:nowrap;
}

.START_SPACE{
	padding-top:10px;
}


.START_LINE{
	height:250px;
	width:1px;
        background-color:#8499A2;
	aborder-left:1px solid #8499A2;
}

.START_LINE1{
	height:250px;
        width:1px;
	aborder-right:1px solid #FFFFFF;
        background-color:#FFFFFF;
  	afilter:alpha(opacity:100);
}

.START_LINK_TD{
        height:39px;
  	filter:alpha(opacity:40);
  	-moz-opacity:0.4;
	background-color:#ffffff;
	padding-left:13px;
	vertical-align:center; 
}

.START_CHK{
	padding-left:20px;
	padding-top:5px;
}

.START_ITEM{padding-top:12px; padding-right:20px;}

.START_ITEM1{ padding-top:10px; padding-right:20px;} 
.link_split{ height:1px; width:1px; color:#8499A2;  }
a.item:link{color:#0088C2; white-space:nowrap; text-decoration:none;}
a.item:hover{color:#0088C2; white-space:nowrap; text-decoration:underline}
a.item:visited{color:#0088C2; white-space:nowrap; text-decoration:none}
</style>
</head>
<script>
var now_lang="<% nvram_get("language"); %>"; 

function before_leave(){
	parent.document.getElementById("GUI_FUN").value = 1;
}

function init(){
	var wps_result='<% nvram_get("wps_result"); %>';		
	if ( wps_result == '3' || wps_result == '4' ) 
		get_position("Wireless_WPS.asp");
	if ( "<% nvram_get("model_name"); %>" == "RV130" ) 
	{
		document.getElementById("wl_item1").style.display="none";	
		document.getElementById("wl_item2").style.display="none";	
	}
	parent.document.getElementById("save_bg").style.display="none";
	if ( "<% nvram_get("http_power"); %>" == "r" ) document.getElementById("startup").disabled = true; 
}

function chk_startup(F){
	F.start_up.value=1;
	if ( F.startup.checked ) 
		F.start_up.value = 0;
	F.change_action.value="gozila_cgi";
	F.submit_button.value = "getstart";
	if ( close_session != "1" ) 
		F.action = goto_link(F.action);
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function CaptureC(obj)
{
	if ( now_lang == "FR" ) 
		document.write(obj+" :");
	else
		document.write(obj+":");
}

function Capture(obj)
{
	document.write(obj);
}

document.onkeydown=disableKey;

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type value='<% nvram_gozila_get("submit_type");%>'>
<input type=hidden name=gui_action>
<input type=hidden name=start_up>
<TABLE cellspacing=0 class=START_TABLE>
  <TR><TD class=START_TITLE colspan=3><script>Capture(g_start.title);</script></TD></TR>
  <TR><TD class=START_SUB_TITLE colspan=3><script>Capture(g_start.desc);</script></TD></TR>
  <TR><TD style="padding-right:20px; vertical-align:top; ">
  <TABLE width=100%>
  <TR><TD class=START_SECTION1><SPAN style="vertical-align:center;"><img src='image/sbbu_router.gif'></SPAN></TD><TD class=START_SECTION><script>Capture(g_start.inital);</script></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('users.asp')"><script>Capture(g_start.chg_pwd);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('wizard.asp')"><script>Capture(g_start.launchwizard);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('wan.asp')"><script>Capture(g_start.config_wan);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('lan.asp')"><script>Capture(g_start.config_lan);</script></a></TD></TR>
  <TR id=wl_item1><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('Wireless_Manual.asp')"><script>Capture(g_start.config_wl);</script></a></TD></TR>
  </TABLE>
  </TD>
  <!-- spreate line -->
  <TD height=250px><TABLE cellspacing=0 cellpadding=0><TR><TD class=START_LINE></TD><TD class=START_LINE1></TD></TR></TABLE></TD>
  <TD style="vertical-align:top; padding-left:10px">
  <TABLE width=100%>
  <TR><TD class=START_SECTION1><SPAN style="vertical-align:center;"><img src='image/favorites.png'></SPAN></TD><TD class=START_SECTION><script>Capture(g_start.qaccess)</script></TD></TR>
  <TR><TD></TD><TD class=START_ITEM><a class=item href="javascript:get_position('upgrade.asp')"><script>Capture(g_start.upgradefw);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('vpn_client.asp')"><script>Capture(g_start.addvpn);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('firewall.asp')"><script>Capture(g_start.config_remote);</script></a></TD></TR>
  <TR><TD class=START_SPACE>&nbsp;</TD></TR>
  <TR><TD class=START_SECTION1><SPAN style="vertical-align:center;"><img src='image/barchart.png'></SPAN></TD><TD class=START_SECTION><script>Capture(g_start.devst);</script></TD></TR>
  <TR><TD></TD><TD class=START_ITEM><a class=item href="javascript:get_position('system.asp')"><script>Capture(g_start.sys_summary);</script></a></TD></TR>
  <TR id=wl_item2><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('status_wireless.asp')"><script>Capture(g_start.wl_st);</script></a></TD></TR>
  <TR><TD></TD><TD class=START_ITEM1><a class=item href="javascript:get_position('status_vpn.asp')"><script>Capture(g_start.vpn_st);</script></a></TD></TR>
  </TABLE>	
  </TD>
  <TR><TD class=START_SPACE>&nbsp;</TD></TR>
  <TR><TD style="padding-right:10px; padding-left:10px; width:100%; vertical-align:top; " colspan=3>
  <TABLE width=100%>
  <TR><TD class=START_LINK_TD><script>CaptureC(g_start.res);</script>&nbsp;&nbsp;<a class=item target=_blank href="http://www.cisco.com/en/US/products/ps9923/tsd_products_support_series_home.html"><script>Capture(share.supt);</script></a>&nbsp;&nbsp;<SPAN class=link_split>|</SPAN>&nbsp;&nbsp;
  <a class=item target=_blank href='https://supportforums.cisco.com/community/netpro/small-business'><script>Capture(g_start.forums);</script></a></TD></TR></TABLE>
  </TD></TR>
  <TR><TD class=START_CHK><input type=checkbox onClick=chk_startup(this.form) id=startup name=startup <% nvram_match("getting_start","0","checked"); %>><script>Capture(g_start.chkshow);</script></TD></TR>
</TABLE>
</form>
</div></TABLE></TD></TR>
</body></HTML>
