<html>
<head>
<title>Available LAN Host</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var timerID=null;
var timerRunning = false ; 
var value=0;
var idx=0;
var datalist = new Array(
<% get_diag_data(); %>
);
function to_add(list)
{
	document.getElementById("_nodata").style.display="none";
	var tbody = document.getElementById("_table").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
        row.setAttribute("id","tr_table"+idx);
	if (idx%2 == 0){
                row.setAttribute("class", "TABLECONTENT_S");
                row.setAttribute("className", "TABLECONTENT_S");
        }else{
                row.setAttribute("class", "TABLECONTENT_D");
                row.setAttribute("className", "TABLECONTENT_D");
        }

	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_result"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = list;
        row.appendChild(tdArray);

	tdArray = document.createElement("td");
        tdArray.setAttribute("id","");
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = "&nbsp;";
        row.appendChild(tdArray);
	
        tbody.appendChild(row);
        idx++;
}

function init1(){
	parent.document.getElementById("save_bg").style.display="none";
	choose_disable(document.getElementById("t1"));
	for(var i=0; i<datalist.length; i++)
		to_add(datalist[i])
	if ( "<% nvram_gozila_get("submit_type"); %>" == "start_ping" || "<% nvram_gozila_get("submit_type"); %>" == "start_traceroute" || "<% nvram_gozila_get("submit_type"); %>" == "start_lookup"){ 
			Refresh();	
	}else if ( "<% nvram_gozila_get("submit_type"); %>" == "ping" ){
			<% onload("Ping", "Refresh();"); %>
		        window.location.href = "#";
	}else if ( "<% nvram_gozila_get("submit_type"); %>" == "traceroute" ){
			<% onload("Traceroute", "Refresh();"); %>
		        window.location.href = "#";
	}else if ( "<% nvram_gozila_get("submit_type"); %>" == "lookup" ){
			<% onload("Lookup", "Refresh();"); %>
		        window.location.href = "#";
	}
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	choose_disable(document.getElementById("t1"));
	for(var i=0; i<datalist.length; i++)
		to_add(datalist[i])
	if( "<% nvram_gozila_get("submit_type"); %>" == "ping" || "<% nvram_gozila_get("submit_type"); %>" == "start_ping"){
			<% onload("Ping", "Refresh();"); %>
		        window.location.href = "#";
	}else if ( "<% nvram_gozila_get("submit_type"); %>" == "traceroute" || "<% nvram_gozila_get("submit_type"); %>" == "start_traceroute"){
			<% onload("Traceroute", "Refresh();"); %>
		        window.location.href = "#";
	}else if ( "<% nvram_gozila_get("submit_type"); %>" == "lookup" || "<% nvram_gozila_get("submit_type"); %>" == "start_lookup"){
			<% onload("Lookup", "Refresh();"); %>
		        window.location.href = "#";
	}
}

function to_stop(F)
{
        if ( timerRunning ) clearTimeout(timerID);
        timerRunning = false ;
        F.submit_button.value = "Diagnostics";
	if ( "<% nvram_gozila_get("submit_type"); %>" == "start_ping" || "<% nvram_gozila_get("submit_type"); %>" == "ping" )
	        F.submit_type.value = "ping_stop"
	else if ( "<% nvram_gozila_get("submit_type"); %>" == "start_traceroute" || "<% nvram_gozila_get("submit_type"); %>" == "traceroute" )
	        F.submit_type.value = "traceroute_stop"
	else if ( "<% nvram_gozila_get("submit_type"); %>" == "start_lookup" || "<% nvram_gozila_get("submit_type"); %>" == "lookup" )
	        F.submit_type.value = "lookup_stop"
        F.change_action.value = "gozila_cgi";
        F.submit();
}


function to_close(F){
	goto_page("network_tools.asp");
}

function Refresh()
{
	choose_enable(document.getElementById("t1"));
	var F =  document.setup;
        refresh_time = 4000;
        if (value>=1)
        {
        	F.submit_button.value = "Diagnostics";
		if ( "<% nvram_gozila_get("submit_type"); %>" == "start_ping" || "<% nvram_gozila_get("submit_type"); %>" == "ping" ) 
        		F.submit_type.value = "ping";
		else if ( "<% nvram_gozila_get("submit_type"); %>" == "start_traceroute" || "<% nvram_gozila_get("submit_type"); %>" == "traceroute" ) 
                        F.submit_type.value = "traceroute";
		else
        		F.submit_type.value = "lookup";
        	F.change_action.value = "gozila_cgi";
		F.submit();
               //window.location.replace("Diagnostics.asp");
        }
        value++;
        timerID=setTimeout("Refresh()",refresh_time);
        timerRunning = true ;
}


</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type value="<% nvram_gozila_get("submit_type"); %>">
<input type=hidden name=gui_action>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.networktools));</script></TR>
  <TR><TD colspan=2>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=80%>
		<TR><TD colspan=3 class=TABLETITLE><script>
		if ( "<% nvram_gozila_get("submit_type"); %>" == "start_ping" || "<% nvram_gozila_get("submit_type"); %>" == "ping" ) 
		Capture(mang.ping);
		else if ( "<% nvram_gozila_get("submit_type"); %>" == "start_traceroute" || "<% nvram_gozila_get("submit_type"); %>" == "traceroute")		
		Capture(mang.trace);
		else
		Capture(mang.lookup);
		</script></TR>	
		<script>
			document.write("<TR height=20px>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(router.result));
                        draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");                         
		        document.write("</tr>");
                        document.write("<tr class=TABLECONTENT_S><TD colspan=3>");
			document.write("<TABLE id=_table cellspacing=0 width=100% cellspacing=0 cellpadding=0>");
			document.write("<col width=80%>");
			document.write("<TR id=_nodata><TD class=TABLECONTENT_TD>"+__T(msg.nodata));
                        document.write("</TD></TR></TABLE></TD></TR>");
			// For firefox layout
			chg_layout();
		</script>
		
		</TABLE>
      </TD>
  </TR>
  <TR><TD colspan=2>
		<script>
			draw_object(O_GUI,BT,__T(mang.stop),"t1","BT","to_stop(this.form)");
			draw_object(O_GUI,BT,__T(mang.close),"t2","BT","to_close(this.form)");
		</script>	
  </TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
