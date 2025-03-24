<html>
<head>
<title>6 to 4 Tunneling</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist=new Array();
<% get_ipv6_routing(); %>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.setup,"");
}

function  uiDoSave(F){
	F.ripng_enable.value = 0 ; 
	if ( F._ripng_enable.checked == true ) 
		F.ripng_enable.value = 1 ; 
	F.submit_button.value = "ripng";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ripng_enable>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.rripng),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.ripconfig),"colspan=2");</script>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.ripng),SPACE_DOWN,SPACE_DOWN);</script>
		<input type=checkbox name=_ripng_enable <% nvram_match("ripng_enable","1","checked"); %>> <script>Capture(share.enable);</script>
                </TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
