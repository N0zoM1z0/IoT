<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="md5.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="JavaScript">
	var current_time='';
	var secretID = 'db0840e01e424aa5b684c2e06b5c9075';	
	
	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=1&"+
				"oid_1=IGD_&inst_1=10000&"+
				"&oid_2=IGD_WANDevice_i_WANConnectionDevice_i_&inst_2=11100"
	};
	get_config_obj(param);
	var wanMac = config_val('wanConnDev_MACAddress_');

	function get_config_obj(param)
	{
		if (param == null || param.url == null)
			return;
			
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	param.url,
			data: 	param.arg+"&"+time+"="+time,
			dataType: "xml",
			success: function(data) {
				gConfig = data;
			},
			error: function(xhr, ajaxOptions, thrownError){
				if (xhr.status == 200) {
					try {
						setTimeout(function() {
							document.write(xhr.responseText);
						}, 0);
					} catch (e) {
					}
				} else {
				}
			}
		};
		
		try {
				$.ajax(ajax_param);
		} catch (e) {
		}
	}

	function config_val(name)
	{
		return get_node_value(gConfig, name);
	}

	/**
	 *	get_node_value() : obtain an element's value from a XML object
	 *
	 *	Parameter(s) :
	 *		which_doc : a XML object that you want to obtain an element's value from
	 *		which_id	 :	the element's name that you want to obtain its value
	 *
	 * Return : element's value
	 * 	
	 **/
	function get_node_value(which_doc, which_id){		
		var node = get_xml_node(which_doc, which_id);
		var node_value = "";
		
		if (node != null){
			if (node.nodeType != 3){	// NS6/Mozilla will treat space as an element, so we need to ingore it
				if (node.childNodes.length > 0){
					node_value = node.childNodes[0].nodeValue;	
				}
			}
		}
		
		return node_value;
	}

	/**
	 *	get_xml_node() : obtain an element from a XML object
	 *
	 *	Parameter(s) :
	 *		which_doc : a XML object that you want to obtain an element from
	 *		which_id	 :	the element's name that you want to obtain
	 *
	 * Return : element object
	 * 	
	 **/
	function get_xml_node(which_doc, which_id){
		if (which_doc == null)
			return null;
		return which_doc.getElementsByTagName(which_id)[0];
	}

	function send_mydlink()
	{
		var tmp_auth = '';
		var tmp_macs = '';
		var date = new Date(); 
		current_time = date.getTime();

		var tmp_mac = wanMac.split(":");
		for (var i = 0;i<tmp_mac.length;i++)
			tmp_macs += tmp_mac[i];
		tmp_auth = hex_md5(tmp_macs + current_time + secretID);

		$('#mac').val(wanMac);
		$('#time').val(current_time);
		$('#auth').val(tmp_auth);

		$('#form1').submit();
	}
</script>
</head>

<body onLoad='send_mydlink();'>

	<form name="form1" id="form1" method="post" action="https://api.mydlink.com/signup?lang=en" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="mac" name="mac">
		<input type="hidden" id="time" name="time">
		<input type="hidden" id="auth" name="auth">
	</form>

</body>
</html>