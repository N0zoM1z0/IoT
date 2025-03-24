<html>
<head>
<title>GUEST INFO</title>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<% js_link(0); %>
<!--LINK href="style.css" type=text/css rel=stylesheet-->
<script>
var url = "http://<% get_gnet_url(); %>";
function init()
{
	var status_url = document.location.href.substring(0, document.location.href.lastIndexOf("/"));
	status_url += "/guest_info.asp";
	document.getElementById("newwin").src = "get_redirect.asp";
	self.open(status_url,'helpwin','alwaysRaised=no,resizable=no,scrollbars=no,width=550,height=360',"_blank");
	document.location.href = url;
	return;
}

</script>
<body onresize=chg_win() onload=init()> 
<FORM autocomplete=off id=frm name=guestinfo method=<% get_http_method(); %> action=guest_logout.cgi>
<input type=hidden name=cmac>
<input type=hidden name=cip>
<input type=hidden name=gui_action>
<input type=hidden name=submit_button>
<iframe id=newwin height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<div align=center>
</div>
</FORM>
</body>
</html>
