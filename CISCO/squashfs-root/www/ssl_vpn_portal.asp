<% js_link(); %>
<script type="text/javascript" src="position.js"></script>
<script>
function before_leave(){
//For Changed without save alert message
	parent.document.getElementById("GUI_FUN").value = 1 ;
}
	var about_win;
	var url = goto_link('default.asp');
	about_win = window.open(url,"_blank","fullscreen,scrollbars,menubar,location,directories,status,resizable");
</script>
