<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var max_ib_len = 10;
	var RULES_IN_IFLTER = 8;
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var ibStParam = {
		url: "used_check.ccp",
		arg: "ccp_act=getStOfIbfilter"
	}
	get_config_obj(ibStParam);
	
	var usedIbfilter = config_val("usedIbfilter");
	
	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=3&"+
				"oid_1=IGD_WANDevice_i_InboundFilter_i_&inst_1=11000&"+
				"oid_2=IGD_&inst_2=10000&"+
				"oid_3=IGD_&inst_3=10000"
	};
	get_config_obj(param);
	var dev_mode = config_val("igd_DeviceMode_");

	var array_rule_inst = config_inst_multi("IGD_WANDevice_i_InboundFilter_i_");
	var array_name = config_str_multi("ibFilter_Name_");
	var array_action = config_str_multi("ibFilter_Action_");
	
	if (array_rule_inst != null) {
		var param = {
			url: 	"get_set.ccp",
			arg: 	"ccp_act=get&num_inst="+array_rule_inst.length+"&"
		};
		for (var i=1; i<=array_rule_inst.length; i++) {
			var p_inst = new String(array_rule_inst[i-1]);
			param.arg += "&oid_"+i+"=IGD_WANDevice_i_InboundFilter_i_IPRange_i_&inst_"+i+"=11"+p_inst.substr(4, 1)+"00"
		}

		get_config_obj(param);
	}
	var array_ip_inst = config_inst_multi("IGD_WANDevice_i_InboundFilter_i_IPRange_i_");

	var array_enable = config_str_multi("ipRange_Enable_");
	var array_ip_start = config_str_multi("ipRange_RemoteIPStart_");
	var array_ip_end = config_str_multi("ipRange_RemoteIPEnd_");

	var submit_button_flag = 0;
	var rule_max_num = 10;
	var DataArray = new Array();
	var DataArray_detail = new Array(10);
	function onPageLoad(){
		if (array_enable != null && array_rule_inst.length >= max_ib_len) {
			get_by_id('button1').disabled = true;
		}
		onReset();
		
		//var login_who= "<% CmoGetStatus("get_current_user"); %>";
		var login_who= login_Info;
		if(login_who!= "w" || dev_mode == "1"){
			DisableEnableForm(form1,true);	
		} 
	}
	
	function edit_row(obj){
		//if(login_Info != "w")
		//	return;
	
		get_by_id('button1').disabled = false;
		get_by_id("edit").value = obj;
		get_by_id("ingress_filter_name").value = array_name[obj];
		get_by_id("action_select").selectedIndex = array_action[obj];
		for(j=0;j<RULES_IN_IFLTER;j++){
			set_checked(array_enable[obj*RULES_IN_IFLTER+j], get_by_id("entry_enable_"+j));
			get_by_id("ip_start_"+j).value = array_ip_start[obj*RULES_IN_IFLTER+j];
			get_by_id("ip_end_"+j).value = array_ip_end[obj*RULES_IN_IFLTER+j];
		}
		get_by_id("button1").value = get_words(YM34);
		get_by_id("form_act").value = "edit";
		get_by_id("ibFilter_inst").value = inst_array_to_string(array_rule_inst[obj]);
	}
	
	function del_row(row){	
		//if(login_Info!= "w")
		//	return;
			
		var tmp = new String(inst_array_to_string(array_rule_inst[row]));
		var idx = parseInt(tmp.charAt(2));
		var used_str = new String(usedIbfilter);
		
		if(used_str.charAt(idx-1) == '1')
		{
			alert(array_name[row] +" "+ get_words(GW_SCHEDULES_IN_USE_INVALID_s2));	//GW_SCHEDULES_IN_USE_INVALID_s2, GW_SCHEDULES_IN_USE_INVALID
			return;
		}	
	
		if (confirm(get_words(YM35)+" "+ array_name[row] +"?")) {
			var inst = new String(array_rule_inst[row]);
			var delInst = '';
			var param = {
				url: "get_set.ccp",
				arg: "ccp_act=del&ccpSubEvent=CCP_SUB_IBFILTER&nextPage=Inbound_Filter.asp&"
			};
			
			if (inst.indexOf('.') != -1 || inst.indexOf(',') != -1) 
				delInst = '1.1.'+new String(array_rule_inst[row]).substr(4, 1)+'.0.0';
			else
				delInst = '1.1.'+new String(array_rule_inst[row]).substr(2, 1)+'.0.0';
			
			param.arg += "oid_1=IGD_WANDevice_i_InboundFilter_i_&inst_1="+delInst;
			get_config_obj(param);
			location.replace('Inbound_Filter.asp');
		}
		else
			return;
	}

	function do_submit() 
	{
		var inst = '';
		var param = {
			url: "get_set.ccp",
			arg: ''
		};
		
		if (get_by_id('form_act').value == 'add') {
			param.arg = "ccp_act=queryInst&num_inst=1";
			param.arg +="&oid_1=IGD_WANDevice_i_InboundFilter_i_&inst_1=11000";
			get_config_obj(param);
			inst = config_val("newInst");
		} else if (get_by_id('form_act').value == 'edit') {
			inst = 	get_by_id('ibFilter_inst').value;
		}

		param.arg = 'ccp_act=set&ccpSubEvent=CCP_SUB_IBFILTER&nextPage=Inbound_Filter.asp';
		param.arg += make_req_entry('&ibFilter_Name_', 			urlencode(get_by_id('ingress_filter_name').value), inst);
		param.arg += make_req_entry('&ibFilter_Action_', 		get_by_id('action_select').selectedIndex, inst);
		
		for (var i=0; i<8; i++) {
			var rangeInst = '';
			if (inst.indexOf('.') != -1) 
				rangeInst = new String(inst).substr(0, 6)+(i+1)+'.0';
			else
				rangeInst = '1.1.'+new String(inst).substr(2, 1)+'.'+(i+1)+'.0';
			param.arg += make_req_entry('&ipRange_Enable_', 		get_by_id('entry_enable_'+i).checked? '1': '0', rangeInst);
			param.arg += make_req_entry('&ipRange_RemoteIPStart_', 	get_by_id('ip_start_'+i).value, rangeInst);
			param.arg += make_req_entry('&ipRange_RemoteIPEnd_', 	get_by_id('ip_end_'+i).value, rangeInst);
		}
		//alert(param.arg);
		//return;
		get_config_obj(param);	
		location.replace('Inbound_Filter.asp');	// we have to add this line, otherwise, ie won't refresh page.
	}
	
	
	function send_request(){
		$('#button1').attr('disabled', true);
		setTimeout("$('#button1').attr('disabled', false)", 500);
		
		if(get_by_id("ingress_filter_name").value.length > 0){
			if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange))) {
				return false;
			}
			
			if(get_by_id('form_act').value == 'edit'){
				var edit_idx = get_by_id("edit").value;
				var tmp = new String(inst_array_to_string(array_rule_inst[edit_idx]));
				var idx = parseInt(tmp.charAt(2));
				
				var used_str = new String(usedIbfilter);
				if(used_str.charAt(idx-1) == '1')
				{
					//alert(array_name[edit_idx]+", "+get_by_id("ingress_filter_name").value);
					if(array_name[edit_idx] != get_by_id("ingress_filter_name").value)
					{
						alert(array_name[edit_idx] +" "+ get_words(GW_SCHEDULES_IN_USE_INVALID_s2));	//GW_SCHEDULES_IN_USE_INVALID_s2, GW_SCHEDULES_IN_USE_INVALID
						return false;
					}
				}
			
				//if(!confirm("Are you sure you want to update : " + get_by_id("ingress_filter_name").value)){
				if(!confirm(get_words(YM38)+" : " + get_by_id("ingress_filter_name").value)){
					return false;
				}
			}
			
			if(get_by_id("ingress_filter_name").value == "Allow All" || get_by_id("ingress_filter_name").value == "Deny All"){
				//alert("Name can not set to the same as default Inbound filter name 'Allow All' or 'Deny All'.");
				alert(get_words(TEXT014));
				return false;
			}
						
			var is_checked = false;
			for(var i=0;i<RULES_IN_IFLTER;i++){
				var start_ip = get_by_id("ip_start_"+i).value;
				var end_ip = get_by_id("ip_end_"+i).value;
				
				var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
				var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");
				var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
				var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
				if(array_name != null && array_name[i]==get_by_id("ingress_filter_name").value && edit_idx != i){
					//alert('Name "'+ get_by_id("ingress_filter_name").value +'" is already used!');	//GW_QOS_RULES_NAME_ALREADY_USED
					//alert("名? "+ get_by_id("ingress_filter_name").value +" 已?被使用。");
					alert(addstr(get_words(GW_QOS_RULES_NAME_ALREADY_USED), get_by_id("ingress_filter_name").value));
					return false;
				}
				
				if (!is_ipv4_valid(start_ip)) {
					//alert("Invalid IP address: " + start_ip + ".");
					alert(get_words(KR2) +" : " + start_ip + ".");
					get_by_id("ip_start_"+i).select();
					get_by_id("ip_start_"+i).focus();
					return false;
				}
				
				if (!is_ipv4_valid(end_ip)) {
					//alert("Invalid IP address: " + end_ip + ".");
					alert(get_words(KR2) +" : " + end_ip + ".");
					get_by_id("ip_end_"+i).select();
					get_by_id("ip_end_"+i).focus();
					return false;
				}
				
				if (!check_ip_order(start_obj, end_obj)){
					alert(get_words(IP_RANGE_ERROR,msg));
					//alert("Start IP address must be less than end IP address");
					return false;
				}

				if(get_by_id("entry_enable_"+i).checked){
					for(j=i+1;j<8;j++){
						if(get_by_id("entry_enable_"+j).checked && (start_ip == get_by_id("ip_start_"+j).value && end_ip == get_by_id("ip_end_"+j).value)){
							//alert("This IP Rang '"+ start_ip +"-"+ end_ip +"' is duplicated.");
							//alert("The inbound filter range '"+ start_ip +"-"+ end_ip +"'  is duplicated."); //ai_alert_7
						 	//alert("流入封包過濾器範圍"+ start_ip +"-"+ end_ip +"重複.");	//ai_alert_7
							alert(addstr(get_words(ai_alert_7), start_ip, end_ip));
							
							return false;
						}
					}
					is_checked = true;
				}
			}
			if(!is_checked){
				//alert("Enable at least one Source IP Rang for '"+ get_by_id("ingress_filter_name").value +"'.");
				//alert("Enable at least one Source IP Range for '"+ get_by_id("ingress_filter_name").value +"'.");	//ai_alert_5
				//alert("啟用至少一筆來源IP範圍"+ get_by_id("ingress_filter_name").value +"");	//ai_alert_5
				alert(addstr(get_words(ai_alert_5), get_by_id("ingress_filter_name").value));
				return false;
			}
		}else{
			//alert(msg[INBOUND_NAME_ERROR]);
			alert(get_words(GW_FIREWALL_RULE_NAME_INVALID));
			return false;
		}

		//get_by_id("form1").submit();
		do_submit();
		return false;
	}
	
function copy_data_to_cgi_struct()
{
	get_by_id("ibFilter_Name_").value = get_by_id("ingress_filter_name").value;
	get_by_id("ibFilter_Action_").value = get_by_id("action_select").selectedIndex;
	
	for(var i=1; i<=8; i++)
	{
		get_by_id("ipRange_Enable_"+i).value = get_checked_value(get_by_id("entry_enable_"+(i-1)));
		get_by_id("ipRange_RemoteIPStart_"+i).value = get_by_id("ip_start_"+(i-1)).value;
		get_by_id("ipRange_RemoteIPEnd_"+i).value = get_by_id("ip_end_"+(i-1)).value;
	}
}

function onReset()
{
	get_by_id("ingress_filter_name").value = "";
	get_by_id("action_select").selectedIndex = 0;
	
	for(j=0;j<RULES_IN_IFLTER;j++){
		set_checked(0, get_by_id("entry_enable_"+j));
		get_by_id("ip_start_"+j).value = "0.0.0.0";
		get_by_id("ip_end_"+j).value = "255.255.255.255";
	}
	get_by_id("form_act").value = "add";
	get_by_id("ibFilter_inst").value = "";
	get_by_id("button1").value = get_words(_add);
	set_form_default_values("form1");
	
}

function print_ip_range(idx)
{
	var str = '';
	for (var i=0; i<RULES_IN_IFLTER; i++)
	{
		var id = idx*RULES_IN_IFLTER+i;
		
		if (array_enable[id] == 0)
			continue;
		
		if (str != '') 
			str += ',';
		
		if (array_ip_start[id] == '0.0.0.0' && array_ip_end[id] == '255.255.255.255')
			str += '*';
		else
			str += array_ip_start[id] + '-' + array_ip_end[id];
	}
	
	return str;
}
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
        </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                            <ul>
							<LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(_inboundfilter)</script></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
             </td>
                    </tr>
                </table></td>
				<input type="hidden" name="ccp_act" value="set">
				<input type="hidden" name="ccpSubEvent" value="CCP_SUB_VIRTUALSERVER">
				<input type="hidden" name="nextPage" value="Inbound_Filter.asp">	
				<input type="hidden" id="form_act" value="add">

				<input type="hidden" id="ibFilter_inst" value="">
				<input type="hidden" id="ibFilter_Name" name="ibFilter_Name_1.1.1.0.0" value="">
				<input type="hidden" id="ibFilter_Action" name="ibFilter_Action_1.1.1.0.0" value="">
				
				<script>
					for(var i=2; i<=DataArray.length; i++) {
						document.write("<input type=\"hidden\" id=\"ibFilter_Name_1.1."+i+".0.0\" name=\"ibFilter_Name_1.1."+i+".0.0\" value=\"\">");
						document.write("<input type=\"hidden\" id=\"ibFilter_Action_1.1."+i+".0.0\" name=\"ibFilter_Action_1.1."+i+".0.0\" value=\"\">");
					}
					for(var i=1; i<=8; i++){
						document.write("<input type=\"hidden\" id=\"ipRange_Enable_"+i+"\" name=\"ipRange_Enable_1.1.1."+i+".0\" value=\"\">");
						document.write("<input type=\"hidden\" id=\"ipRange_RemoteIPStart_"+i+"\" name=\"ipRange_RemoteIPStart_1.1.1."+i+".0\" value=\"\">");
						document.write("<input type=\"hidden\" id=\"ipRange_RemoteIPEnd_"+i+"\" name=\"ipRange_RemoteIPEnd_1.1.1."+i+".0\" value=\"\">");
					}
				</script>
				
                <input type="hidden" id="edit" name="edit" value="-1">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  
          <div id=box_header> 
				<h1><script>show_words(_inboundfilter)</script></h1>
				<p><script>show_words(ai_intro_1)</script></p>
				<p>
					<script>show_words(ai_intro_2)</script>
					<script>show_words(ai_intro_3)</script>
				</p><br>
			</div><br>
                <form id="form1" name="form1" method="post" action="get_set.ccp">
                  <div class=box>
                    <h2><span id="inbound_filter_name_rule_title"><script>show_words(_add)</script></span> <script>show_words(ai_title_IFR)</script></h2>
                    <table cellSpacing=1 cellPadding=2 width=500 border=0>
                        <tr>

                <td align=right class="duple">
                  <script>show_words(_name)</script>
                  :</td>
                          <td>
                            <input type="text" id="ingress_filter_name" size="20" maxlength="15">
                          </td>
                        </tr>
                        <tr>

                <td align=right class="duple">
                  <script>show_words(ai_Action)</script>
                  :</td>
                          <td>
                            <select id="action_select">
						  		<option value="allow"><script>show_words(_allow)</script></option>
						  		<option value="deny"><script>show_words(_deny)</script></option>
                            </select>
                          </td>
                        </tr>
                        <tr>

                <td align=right valign="top" class="duple">
                  <script>show_words(at_ReIPR)</script>
                  :</td>
                          <td>
                            <table cellSpacing=1 cellPadding=2 width=300 border=0>
                                <tr>

                      <td><b><script>show_words(_enable)</script></b></td>
			<td><b><script>show_words(KR5)</script></b></td>
			<td><b><script>show_words(KR6)</script></b></td>
                                </tr>
                                <script>
                                    for(i=0;i<8;i++){
                                        document.write("<tr>")
                                        document.write("<td align=\"middle\"><INPUT type=\"checkbox\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
                                        document.write("<td><input id=\"ip_start_" + i + "\" name=\"ip_start_" + i + "\" size=\"15\" maxlength=\"15\" value=\"0.0.0.0\"></td>")
                                        document.write("<td><input id=\"ip_end_" + i + "\" name=\"ip_end_" + i + "\" size=\"15\" maxlength=\"15\" value=\"255.255.255.255\"></td>")
                                        document.write("</tr>")
                                    }
                                </script>
                            </table>
                          </td>
                        </tr>
                        <tr>
                          <td></td>
                          
                <td> 
                  <input name="button1" id="button1" type="button" class=button_submit value="" onClick="send_request()"> 
                  <input name="button2" id="button2" type="button" class=button_submit value="" onClick="onReset()">
				  <script>get_by_id("button1").value = get_words(_add);</script>
				  <script>get_by_id("button2").value = get_words(_clear);</script>
                </td>
                        </tr>
                    </table>
                  </div>
        </form>
                  <div class=box>
            <h2>
              <script>show_words(ai_title_IFRL)</script>
            </h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                        <tr align=center>

                <td align=middle width=20>
                  <b><script>show_words(_name)</script></b>
                </td>

                <td align=middle width=20>
                  <b><script>show_words(ai_Action)</script></b>
                </td>

                <td width="255">
                  <b><script>show_words(at_ReIPR)</script></b>
                </td>
                          <td align=middle width=20><b>&nbsp;</b></td>
                          <td align=middle width=20><b>&nbsp;</b></td>
                        </tr>
                        <script>
						//set_Inbound();
					if(array_rule_inst!=null) {
						for(var i=0;i<array_rule_inst.length;i++){
							var act = array_action[i] == '0'? get_words(_allow): get_words(_deny);
							document.write("<tr>")
							document.write("<td>"+ array_name[i] +"</td>")
							document.write("<td>"+ act +"</td>")
							document.write("<td>"+ print_ip_range(i) +"</td>")
							document.write("<td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" title=\""+get_words('_edit')+"\"></a></td>")
							document.write("<td><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" title=\""+get_words('_delete')+"\"></a></td>")
							document.write("</tr>")
						}
					}
					  </script>
                    </table>
                  </div>
              </div>
            </td>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table width="125" border=0
      cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>

          <td id=help_text><strong>
            <script>show_words(_hints)</script>
					&hellip;</strong> <p><script>show_words(hhai_name)</script></p>
					<p><script>show_words(hhai_action)</script></p>
					<p><script>show_words(hhai_ipr)</script></p>
					<p><script>show_words(hhai_ip)</script></p>
					<p><script>show_words(hhai_save)</script></p>
					<p><script>show_words(hhai_edit)</script></p>
					<p><script>show_words(hhai_delete)</script></p>
						<p class="more"><a href="support_adv.asp#Inbound_Filter" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table></td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td><td>&nbsp;</td>
        </tr>
    </table>
<br>
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>
