<html>
<head>
<script>
function init(){
	about_win = self.open("guest1.asp",'aboutTable','toolbar=no,memubar=no,resizable=no,scrollbars=no,directories=no,status=no,location=no,width=200,height=200',"_self");
	setTimeout('reload();', 1000);
}
function reload()	
{
	document.location.href="about:blank";
}

</script>
<body onload=init()>
<FORM autocomplete=off id=frm name=about>
</FORM>
</body>
</html>
