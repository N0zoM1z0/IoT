<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var param = {
		url: "get_set.ccp",
		arg: "ccp_act=getMisc"
	};
	
	param.arg = "ccp_act=get&num_inst=1";
	param.arg +="&oid_1=IGD_WANDevice_i_WANConnectionDevice_i_&inst_1=11100";
	//param.arg +="&oid_2=IGD_WANDevice_i_WANConnectionDevice_i_PPPoE_i_&inst_2=11110";
	get_config_obj(param);
	
function select_wan_page(){
	var html_file;
	var sel_wan = config_val("wanConnDev_CurrentConnObjType_"); 

	switch(sel_wan)
	{
		case "0":
			html_file = "wan_static.asp";
			break;
		case "1":
			html_file = "wan_dhcp.asp";
			break;
		case "2":
			html_file = "wan_poe.asp";
			break;
		case "3":
			html_file = "wan_pptp.asp";
			break;
		case "4":
			html_file = "wan_l2tp.asp";
			break;
		case "10":
			html_file = "wan_dslite.asp";
			break;
		case '6' :
			html_file = "rus_wan_poe.asp";
	    	break;
		case '7' :
			html_file = "rus_wan_pptp.asp";
	    	break;
		case '8' :
			html_file = "rus_wan_l2tp.asp";
	    	break;
		default:
			html_file = "wan_dhcp.asp";
			break;
	}

	location.href = html_file;
}

</script>
</head>

<body>
</body>
<script>
	select_wan_page();
</script>
</html>
