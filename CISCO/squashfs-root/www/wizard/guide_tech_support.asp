<html>
<head>
<TITLE>Setup Wizard</TITLE>
<% web_include_file("wizard/wizard_guide.asp"); %>
</head>
<BODY onresize=chg_win()>
<FORM>
<div id=bg style='position:absolute;z-index:0;top:0px;left:0px;overflow:hidden;'>
<img id=imgbg src='../image/pg.jpg' width=330px height=100% style="position:absolute; z-index:-1">
<TABLE cellspacing=0 bgcolor=#4279B5>
<TR><TD class=PAD><TABLE class=TB>
<TR><TD class=FUNTITLE><B><script>Capture(wz.ciscotechsupport);</script></B>
<P><script>Capture(wz.supportlink);</script></P>
<script>Capture(wz.ciscobussiness);</script><BR>
<A href="http://www.cisco.com/go/smallbizsupport">www.cisco.com/go/smallbizsupport</A><BR>
<script>Capture(wz.onlinetech);</script><BR>
<A href="http://www.cisco.com/support">www.cisco.com/support</A><BR>
<script>Capture(wz.phonesupport);</script><BR>
<A href="http://www.cisco.com/en/US/support/tsd_cisco_small_business_support_center_contacts.html">www.cisco.com/en/US/support/<BR>tsd_cisco_small_business_support_center_contacts.html</A>
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
        self.resizeTo(300,430);
        document.getElementById("bg").style.height= document.body.clientHeight+"px";
}
</script>


