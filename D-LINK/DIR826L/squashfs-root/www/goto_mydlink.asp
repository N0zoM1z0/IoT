<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta http-equiv="pragma" content="no-cache">
<script type="text/javascript" src="uk_w.js"></script>
<link rel="stylesheet" href="js/jquery-ui.css" type="text/css"/>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var count =0;

	function get_conn_st()	//20120423 chk wan function OK?
	{
		var conn_st = query_wan_connection();
		//conn_st ='true';
		if(conn_st == "true")
			get_wan_st();
		else
			setTimeout('get_conn_st()',500);
	}

	function get_wan_st()
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	"mdl_check.ccp",
			data: 	"act=getwanst"+"&"+time+"="+time,
			success: function(data) {
				if (data.indexOf('false') != -1)
				{
					count++;
					if ((count % 2) ==0)
						do_fakeping();
					setTimeout('get_wan_st()', 1000);
				}
				else{
					setTimeout('gotopage()', 1000*5);
				}
			}
		};
		try {
				$.ajax(ajax_param);
		} catch (e) {
		}
	}

	function gotopage()
	{
		location.replace('http://www.mydlink.com/entrance');
	}

	function query_wan_connection()
	{
		var paramQuery = {
			url: "ping.ccp",
			arg: "ccp_act=queryWanConnect"
		};

		get_config_obj(paramQuery);
		var ret = config_val("WANisReady");
		return ret;
	}

	function do_fakeping()
	{
		
		var paramPing = {
			url: "ping.ccp",
			arg: 'ccp_act=fakeping&fakeping=1'
		};
		ping_wan(paramPing);
	}

	function ping_wan(p)
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	p.url,
			data: 	p.arg+"&"+time+"="+time
		};

		$.ajax(ajax_param);
	}
</script>
</head>
<body onLoad='get_conn_st()';></body>
</html>