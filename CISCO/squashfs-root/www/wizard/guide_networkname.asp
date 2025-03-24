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
<P><script>Capture(wz.network1);</script></P>
<P><script>Capture(wz.network2);</script></P>
<P><script>Capture(wz.network3);</script></P>
<P><script>Capture(wz.network4);</script></P>
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
        self.resizeTo(330,360);
        document.getElementById("bg").style.height= document.body.clientHeight+"px";
}
</script>
