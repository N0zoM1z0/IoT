<HTML>
<% no_cache(); %>
<% js_link(); %>
<LINK href="style.css" type=text/css rel=stylesheet>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<style fprolloverstyle>
.TOPMENU_CH TD{
  	white-space:nowrap;
	background-color:#8DB71F;
	padding-top:3px;
	padding-bottom:5px;
	padding-left:5px;
  	border-top:1px #8499A2;
  	border-bottom:1px solid #8499A2;
  	vertical-align:middle;
	color:#FFFFFF;
  	font-weight:bold;
}
</style>

<script>
var i=0,j=0;
var submenu=__T(chpass.title);
var L1="topmenu";
var L2_IMG="subimg";
var TOPMENU_IMG_URL='image/drawerTriangleCollapsedT.gif'; 
var SECMENU_IMG_URL='image/drawerTriangleCollapsedT.gif';
var TOPMENU_BT_NORMAL='TOPMENU';
var TOPMENU_BT_SEL='TOPMENU_CH';

function __T(obj){
	return obj;
}

function init()
{
	document.getElementById(L1+i).className = TOPMENU_BT_SEL;
	
}
</script>
<BODY onload=init()>
<FORM>
<script>
	/* tree */
	document.write("<table cellspacing=0 width=100% >");
	var img="", row_style="";
	
	row_style = TOPMENU_BT_NORMAL;
	document.write("<TR class="+row_style+" id=topmenu"+i+"><TD>");
	//document.write("<img src='"+TOPMENU_IMG_URL+"' class=TOPMENU_IMG id=topimg"+i+"><span style='padding-left:3px'>");
	document.write("<span style='padding-left:3px'>");
	document.write(__T(chpass.title)+"</SPNA></TD></TR>");
	document.write("<TR><TD><TABLE border=0 cellspacing=0 width=100% id='l2tr_"+i+"' style=display:none>");
	document.write('<TR class='+row_style+'><TD>');
	document.write("<img id=subimg"+i+"_"+j+" src='"+SECMENU_IMG_URL+"' class=L2_IMG><span style='padding-left:3px'>");
	document.write("</table></TD><TR>");

</script>
</form>
</body></HTML>
