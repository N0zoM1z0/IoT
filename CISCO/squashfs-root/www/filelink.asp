<script>
var SPACE_DOWN = "style=padding-bottom:10px";
var factory_bt="",back_bt="",single_tb="",change_cancel_bt="",viewlog_bt="";
</script>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="pngfix.js"></script>
<![endif]--> 
<% no_cache(); %>
<LINK href="/style.css" type=text/css rel=stylesheet>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="/define.js"></script>
<% js_link(0); %>
<script type="text/javascript" src="/position.js"></script>
<script type="text/javascript" src="/common.js"></script>
<script>
var cmp_arr = new Array();
var skip_name=new Array();
var default_nv="default_nv", change_nv="";
var define_backname="";
var GUESTNET_SUPPORT=0;
<% support_match("GUESTNET_SUPPORT", "1", "GUESTNET_SUPPORT=1;");%>
function before_leave(){
	parent.document.getElementById("GUI_FUN").value = 1;
}
function update_val(){
}

document.onkeydown=disableKey;

</script>
