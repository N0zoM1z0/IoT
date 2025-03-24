<html>
<head>
<TITLE>Setup Wizard</TITLE>
<% web_include_file("wizard/wizard_guide.asp"); %>
</head>
<BODY bgcolor=#4279B5 onresize=chg_win()>
<FORM>
<!--div id=div_bg style='position:absolute;z-index:0;top:0px;left:0px;overflow:hidden;'>
<img id=bg src='../image/pg.jpg' width=330px height=100% style="position:absolute; z-index:-1"-->
<div id=bg>
<TABLE cellspacing=0 bgcolor=#4279B5>
<TR><TD class=PAD><TABLE class=TB>
<TR><TD class=FUNTITLE>
<P><script>Capture(wz.securitymsg);</script></P>
<P><script>Capture(wz.securitymsg1);</script></P>
<P><script>Capture(wz.securitymsg2);</script></P>
<P><B><script>Capture(wz.red);</script> - </B><script>Capture(wz.securitymsg3);</script></P>
<P><B><script>Capture(wz.yellow);</script> - </B><script>Capture(wz.securitymsg4);</script></P>
<P><B><script>Capture(wz.green);</script> - </B><script>Capture(wz.securitymsg5);</script></P>
</TD></TR></TABLE>
</TD></TR>
<TR><TD class=COPYRIGHT><script>Capture(router.copyright);</script></TD></TR>
</TABLE>
</form>
</body></HTML>
<script>
chg_win();
function chg_win()
{
        self.moveTo(0,0);
        self.resizeTo(370,480);
        document.getElementById("bg").style.height= document.body.clientHeight+"px";
}
</script>
