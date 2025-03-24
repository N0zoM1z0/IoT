<html>
<head>
<TITLE>Setup Wizard</TITLE>
<% web_include_file("wizard/wizard_guide.asp"); %>
</head>
<script>
function __T(obj)
{
	return obj;
}

function __TC(obj)
{
	if ( now_lang == "FR" ) 
		return obj+" :";
	else
		return obj+":";
}

</script>
<BODY bgcolor=#4279B5 onresize=chg_win()>
<div id=bg>
<TABLE cellspacing=0 bgcolor=#4279B5 height=auto>
<TR><TD class=PAD><TABLE class=TB>
<TR><TD class=FUNTITLE><B><script>document.write(spell_words(__T(wz.installguidetitle),current_model_name));</script></B><P>
<script>document.write(spell_words(__TC(wz.installguide),current_model_name));</script></P><P>
<script>
document.write("<A href='javascript:void(0)' onclick='javascript:window.open(\"http://www.cisco.com/en/US/products/ps9923/prod_installation_guides_list.html\",\"_blank\")'>http://www.cisco.com/en/US/products/ps9923/<BR>prod_installation_guides_list.html");
chg_win();
function chg_win()
{
        self.moveTo(0,0);
	self.resizeTo(410,278);
	document.getElementById("bg").style.height= document.body.clientHeight+"px";
}

</script>
</A></P>
</TD></TR>
</TD></TR></TABLE>
<TR><TD class=COPYRIGHT><script>Capture(router.copyright);</script></TD></TR>
</TABLE>
</body></HTML>
