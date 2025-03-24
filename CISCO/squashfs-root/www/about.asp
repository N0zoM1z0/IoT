<html>
<head>
<title>About Page</title>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="pragma" content="max-age=3600">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
<LINK href="style.css" type=text/css rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="define.js"></script>
<% js_link(); %>
<script type="text/javascript" src="/position.js"></script>
<script type="text/javascript" src="/common.js"></script>
<META http-equiv=Content-Type content="text/html"; charset=UTF-8>
<style fprolloverstyle>
BODY,TD,P,INPUT{
  font-size:12px;
  color:#ffffff;
  font-family:Arial;
  vertical-align:top;
}
</style>
<body onresize=chg_win()> 
<FORM autocomplete=off id=frm name=about>
<div id=bg class=BG_DIV><img src='/image/small_bg.jpg' width=100% style="position:absolute; z-index:-1">
<TABLE cellspacing=0 style='table-style:fixed;padding:20px;margin:20px;' id=istable>
       <TR><TD colspan=2 style='font-size:14px; padding-top:116px; apadding-left:20px; padding-bottom:9px'>
            <script>Capture(router.ciscosb);</script></TD>
       </TR>
       <TR><TD colspan=2 style='font-size:22px; padding-bottom:10px; apadding-left:20px'>
           <script>
		if ( "<% nvram_get("model_name"); %>" == "RV130W" ) 
			Capture(router.appname);
		else
			Capture(router.rv130_appname);
	   </script>
       </TD></TR>
       <TR><TD colspan=2 style='font-size:11px; font-weight:bold; padding-bottom:15px; apadding-left:20px'>
	   <script>Capture(share.version);</script> <% nvram_get("fw_version"); %>
       </TD></TR>
       <TR><TD colspan=2 style="padding-bottom:100px">&nbsp;</TD></TR>
       <TR><TD style='font-size:10px; ;vertical-align:bottom;'>
       <script>Capture(router.copyright);</script><BR><script>Capture(router.aboutcopyright);</script>
       </TD><TD style='vertical-align:bottom;'><img src='image/cisco_logo_about.png'></TD></TR>
</TABLE>
<script>
chg_win();
function chg_win()
{
	self.moveTo(0,0);
	self.resizeTo(480,520);
	document.getElementById("bg").style.height= document.body.clientHeight+"px";
}
</script>
</FORM>
</body>
</html>
