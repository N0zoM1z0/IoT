<html>
<head>
<TITLE>Setup Wizard</TITLE>
<% web_include_file("wizard/wizard_guide.asp"); %>
</head>
<script>document.title = __T(mang.setupwizard);</script>
<BODY bgcolor=#4279B5 onresize=chg_win()>
<FORM>
<div id=bg>
<TABLE cellspacing=0 bgcolor=#4279B5>
<TR><TD class=PAD><TABLE class=TB>
<TR><TD class=FUNTITLE>
<P><script>Capture(wz.pwdmsg);</script></P>
<P><script>Capture(wz.pwdmsg1);</script></P>
<P><B><script>Capture(wz.red);</script> - </B><script>Capture(wz.pwdmsg2);</script></P>
<P><B><script>Capture(wz.yellow);</script> - </B><script>Capture(wz.pwdmsg3);</script></P>
<P><B><script>Capture(wz.green);</script> - </B><script>Capture(wz.pwdmsg4);</script></P>
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
        self.resizeTo(330,430);
        document.getElementById("bg").style.height= document.body.clientHeight+"px";
}
</script>
