<% js_link(); %>
<script type="text/javascript" src="position.js"></script>
<script>
function before_leave(){
//For Changed without save alert message
	parent.document.getElementById("GUI_FUN").value = 1 ;
}
//	parent.frames["wizard"].location.href = goto_link("wizard_vpn/index.asp");
	parent.frames["wizard"].location.href = goto_link("wizard/index.asp");
	parent.document.getElementById("wizard_bg").style.display="";
</script>
