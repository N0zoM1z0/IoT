<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<body>
<FORM autocomplete=off id="frm" name=rdt_log method=<% get_http_method(); %> action=apply.cgi>
<iframe id=loadstatus height=0 width=0 src="" name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type value='<% nvram_gozila_get("submit_type");%>'>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, "RDT Download Log");</script></TR>
  <TR><TD class=MI_TITLE_1>Download file</TD></TR>
  <TR><TD class=MI_TITLE_1>
	RDT Item Result:<a href="<% get_rdt_item(""); %>"><% get_rdt_item(""); %></a><br><br>
	RDT Console Log:<a href="<% get_rdt_detail(""); %>"><% get_rdt_detail(""); %></a>
<!--	<script>document.write("<INPUT onclick=window.location.href=\"<% get_rdt_item(""); %>\" type=button name=load_rdt value=\"RDT Item Result\">");</script>&nbsp;&nbsp;  
	<script>document.write("<INPUT onclick=window.location.href=\"<% get_rdt_detail(""); %>\" type=button name=load_rdt value=\"RDT Console Log\">");</script>-->
   </TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
