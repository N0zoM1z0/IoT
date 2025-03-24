<% js_link(2); %>
<style fprolloverstyle>
.ALERT_FORM
{
      	abackground-image:url("/image/block_50.png");
        position:absolute;
        z-index:0;
        width:100%;
        left:0;
        top:0;
}

.BT_S
{
 height:22px;
 width:50px;
 background-image:url("../../image/BT_Normal.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_S_Hover
{
 height:22px;
 width:50px;
 background-image:url("../../image/BT_Hover.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_S_Press{
 height:22px;
 width:50px;
 background-image:url("../../image/BT_Press.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

BODY,TD,SELECT,INPUT,P{
  font-size:12px;
  font-family:Arial;
  color:#000000;
}
</style>
<input type=hidden id=alert_type>
<input type=hidden id=GUI_LOCK value=0>
<!-- Alert message -->
<div id=div_alert class=ALERT_FORM style=display:none>
<TABLE width=100% height=100%>
<TR align=center valign=center><TD>
<TABLE style="border:1px solid #000000;background-color:#ffffff" width=400px cellspacing=0>
<TR bgcolor=#adc7e7>
<TD colspan=2 style=padding:5px><font style="cursor:default"><SPAN id=alert_title></SPAN></font></TD>
<TD width=16px style=padding:5px height=16px><img src=../../image/AlertCritical16Wht.gif align=right valign=top onclick="javascript:closehelp()"></TD></TR>
<TR bgcolor=#ffffff><TD style=padding:15px width=32 valign=top>
<script>
var src_icon = "Status_criticalerror_icon.gif";
document.write("<img src=../../image/"+src_icon+" id=alert_logo>");
</script>
</TD>
<TD style="padding-top:15px;padding-bottom:20px; padding-right:20px" align=left valign=top>
<font style="cursor:default"><SPAN id=alert_content></SPAN></font>
</TD><TD></TD></TR>
<TR bgcolor=#ffffff><TD colspan=3 align=center style=padding-bottom:15px>
<SPAN id=alert_bt></SPAN>
</TD></TR>
</TABLE>
</TD></TR></TABLE>
</div>
<script>
function __T(obj){
	return obj;
}

function show_alert()
{
	document.getElementById("GUI_LOCK").value = 1;
	document.getElementById("alert_title").innerHTML = "";
	document.getElementById("alert_content").innerHTML = "";
	document.getElementById("alert_title").innerHTML = __T(share.info);
	document.getElementById("alert_content").innerHTML = "";
	document.getElementById("div_alert").style.display="";
	document.getElementById("alert_logo").src="../../image/Status_information_icon.png";
	document.getElementById("alert_content").innerHTML = __T(msg.hto_drop);
	document.getElementById("alert_bt").innerHTML = "<input type=button class='BT_S' onclick=closehelp() value='"+__T(share.sok)+"' id='a1' onMouseover=\"this.className='BT_S_Hover'\" onMouseout=\"this.className='BT_S'\" onMousedown=\"this.className='BT_S_Press'\">";

	document.body.style.overflow="hidden";
        document.getElementById("div_alert").style.height = document.body.clientHeight+"px";
        document.getElementById("div_alert").style.Width = document.body.clientWidth+"px";
	document.body.style.overflow="auto";

}

function closehelp()
{
	top.window.close();
	document.getElementById("GUI_LOCK").value = 0;
	document.getElementById("div_alert").style.display="none";
}
</script>
