<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script>
	var param = {
		url: "get_set.ccp",
		arg: "ccp_act=getMisc"
	};
	
	param.arg = "ccp_act=get&num_inst=1";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	get_config_obj(param);
	
function select_ipv6_page(){
	var html_file;
	var sel_ipv6 = config_val("wanIPv6ConnDev_CurrentConnObjType_"); 
	switch(sel_ipv6)
	{
		case "0":
			html_file = "ipv6_autodetect.asp";
			break;
		case "1":
			html_file = "ipv6_static.asp";
			break;
		case "2":
			html_file = "ipv6_autoconfig.asp";
			break;
		case "3":
			html_file = "ipv6_pppoe.asp";
			break;
		case "4":
			html_file = "ipv6_6in4.asp";
			break;
		case "5":
			html_file = "ipv6_6to4.asp";
			break;	
		case "6":
			html_file = "ipv6_6rd.asp";
			break;
		case "7":
			html_file = "ipv6_link_local.asp";
			break;		
		default:
			html_file = "ipv6_link_local.asp";
			break;
	}

	location.href = html_file;
}

</script>
</head>

<body>
</body>
<script>
	select_ipv6_page();
</script>
</html>
