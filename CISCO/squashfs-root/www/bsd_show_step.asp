<HTML><HEAD><TITLE>GET BSD STATUS</TITLE>
<% js_link(); %>
<script type="text/javascript" src="position.js"></script>
<script>
	var bsd_step = "<% nvram_get("bsd_step"); %>";
	var bsd_err_msg ="<% nvram_get("usb_savefile_st"); %>";
	var percentage = "<% get_bsd_percentage(); %>";
	parent.document.getElementById("bsd_st").value=bsd_step;
	parent.document.getElementById("bsd_err_msg").value=bsd_err_msg;
	parent.document.getElementById("bsd_percentage").value = percentage;
	//alert("bsd_step="+bsd_step+";bsd_err_msg="+bsd_err_msg);
	/*
	if ( bsd_step == "1" ) 
		top.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg1);
	else if ( bsd_step == "2" ) 
		top.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg2);
	else if ( bsd_step == "3" ) 
		top.document.getElementById("reboot_msg").innerHTML = __T(msg.bsdmsg3);
	else if ( bsd_step == "4" ) 
		top.document.getElementById("reboot_msg").innerHTML = __T(msg.rebootingdev);
	alert("bsd_step="+bsd_step);
	*/
	
</script>
</BODY>
</HTML>
