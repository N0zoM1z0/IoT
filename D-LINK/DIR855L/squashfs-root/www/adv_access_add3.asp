<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
var rule_max_num = 8;
var DataArray = new Array();

	function onPageLoad(){
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "none";
			get_by_id("full_msg").style.display = "";
		}else{
			click_type();
		}
	}

	function set_machine_list(){
		if(get_by_id("asp_temp_14").value != "-1" || get_by_id("asp_temp_02").value != ""){
			var temp_Machine = (get_by_id("asp_temp_02").value).split(",");
			for (var i = 0; i < temp_Machine.length; i++){
				var type;
				var Machine = temp_Machine[i].split(".");
				var Machine_name = temp_Machine[i];
				if(Machine.length == 4){
					type = "0";
				}else{
					if(temp_Machine[i] == "other"){
						type = "2";
						Machine_name = _aa_other_machines;
					}else{
						type = "1";
					}
				}
				DataArray[i+1] = new Data(type, Machine_name, i+1);
			}
			get_by_id("max_row").value = temp_Machine.length;
		}
	}

	function Data(type, Machine, onList){
		this.Type = type;
		this.Machine = Machine;
		this.OnList = onList;
	}

	function show_save_button(){
		get_by_id("save").disabled = !(get_by_id("asp_temp_14").value != "-1");
	}

	function clone_mac_action(){
		get_by_id("mac").value = get_by_id("mac_clone_addr").value;
	}
	
	function clear_info(){
		get_by_name("type")[0].checked = true;
		get_by_id("ip").value = "";
		get_by_id("mac").value = "";
		get_by_id("ip_list").selectedIndex = 0;
		get_by_id("mac_list").selectedIndex = 0;
		get_by_id("edit").value = "-1";
		click_type();
	}
	
	function click_type(){
		var type = get_by_name("type");
		get_by_id("ip").disabled = !type[0].checked || type[2].checked;
		get_by_id("ip_list").disabled = !type[0].checked || type[2].checked;
		get_by_id("mac").disabled = !type[1].checked || type[2].checked;
		get_by_id("mac_list").disabled = !type[1].checked || type[2].checked;
		get_by_id("clone").disabled = !type[1].checked || type[2].checked;
	}

	function edit_row(idx){
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "";
			get_by_id("full_msg").style.display = "none";
		}
		get_by_name("type")[DataArray[idx].Type].checked = true;
		if(DataArray[idx].Type == 0){
			get_by_id("ip").value = DataArray[idx].Machine;
		}else if(DataArray[idx].Type == 1){
			get_by_id("mac").value = DataArray[idx].Machine;
		}
		get_by_id("edit").value = idx;
		click_type();
	}

	function del_row(idx){
		if(get_by_id("max_row").value < rule_max_num)
			edit_row(idx);

		if(confirm(aa_ACC_06)){
			get_by_id("del").value = idx;
			delete_row();
		}
	}

	function delete_row(){
		var del_index = parseInt(get_by_id("del").value);
		var tb1 = get_by_id("table1");
		var DataArray_length = parseInt(DataArray.length) - 1;
		if (del_index >= DataArray_length){
			var oTr = tb1.deleteRow(del_index);
		}else{
			for(var i = del_index; i < DataArray_length; i++){
				var edit = i + 1;
				get_by_id("table1").rows[i].cells[0].innerHTML = DataArray[edit].Machine;
				get_by_id("table1").rows[i].cells[1].innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a>";
				get_by_id("table1").rows[i].cells[2].innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a>";
			}
			var oTr = tb1.deleteRow(DataArray_length);
		}
		delete_data();
	}

	function delete_data(){
		var num = parseInt(get_by_id("del").value);
		var DataArray_length = parseInt(DataArray.length) - 2;
	
		for(var i = num ; i <= DataArray_length; i++){
			DataArray[i].Type = DataArray[i+1].Type;
			DataArray[i].Machine = DataArray[i+1].Machine;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}
		--DataArray.length;
		get_by_id("max_row").value = parseInt(DataArray.length)- 1;
		
		if(get_by_id("max_row").value < rule_max_num){
			get_by_id("add_table").style.display = "";
			get_by_id("full_msg").style.display = "none";
			clear_info();
		}
		
	}
	
	function check_duplicate(obj){
		for(var i = 1; i < DataArray.length; i++){
			if(obj == DataArray[i].Machine && i != get_by_id("edit").value){
				alert(aa_alert_7);
				return false;
			}
		}
		return true;
	}
			
	function add_row(){
		var temp_dhcp_list = (get_by_id("dhcp_list").value).split(",");
		var type = get_by_name("type");
		if(type[0].checked){
			var ip = get_by_id("ip").value;
			var lan_ip = "<!--# echo lan_ipaddr -->";
			var mask ="<!--# echo lan_netmask -->";

			var ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_lan_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
			var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
			
			for (var i = 0; i < temp_dhcp_list.length; i++){	
				var temp_data = temp_dhcp_list[i].split("/");
				if (ip==temp_data[1]){
					for(var j = 1; j < DataArray.length; j++){
						if(temp_data[2] == DataArray[j].Machine){
							alert(at_alert12);
							return false;
						}
					}
				}
			}			
			
			if (!check_address(temp_ip_obj, temp_mask_obj, temp_lan_obj)){
				return;
			}
			//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(temp_lan_obj.addr, temp_ip_obj.addr, _ipaddr)){
					return false;
				}

			if(!check_domain(temp_ip_obj, temp_mask_obj, temp_lan_obj)) {
				alert(ip + aa_ACC_05);
				return;
			}
			if(!check_duplicate(ip)){
				return;
			}
		}else if(type[1].checked){
			var mac = get_by_id("mac").value;
			var lan_mac = "<!--# echo lan_mac -->";
			var lower_mac = mac.toLowerCase();
			for (var i = 0; i < temp_dhcp_list.length; i++){	
				var temp_data = temp_dhcp_list[i].split("/");
				var tmp_mac = temp_data[2];
				if (temp_data === "")
					break;
				if (typeof tmp_mac === "undefined")
					break;
				if (lower_mac == tmp_mac.toLowerCase()){
					for(var j = 1; j < DataArray.length; j++){
						if(lower_mac == DataArray[j].Machine.toLowerCase()){
							alert(at_alert12);
							return false;
						}
					}
				}
			}
			
			if (!check_mac(mac)){
				alert(_clone_error);
				return;
			}
			if (mac.toLowerCase() == lan_mac.toLowerCase()){
				alert(_clone_error);
				return false;
			}
			if(!check_duplicate(mac)){
				return;
			}
		}else{
			if(!check_duplicate(_aa_other_machines)){
				return;
			}
		}

		update_DataArray();

		var i;
		if(get_by_id("edit").value == "-1"){     //add
			i = get_by_id("max_row").value;
			var tb1 = get_by_id("table1"); 
			var oTr = tb1.insertRow(-1);
			var oTd1 = oTr.insertCell(-1);
			var oTd2 = oTr.insertCell(-1);
			var oTd3 = oTr.insertCell(-1);

			oTd1.innerHTML = DataArray[i].Machine;
			oTd2.innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a>";
			oTd3.innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a>";
		}else{                                      //update		
			i = parseInt(get_by_id("edit").value);

			get_by_id("table1").rows[i].cells[0].innerHTML = DataArray[i].Machine;
			get_by_id("table1").rows[i].cells[1].innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a>";
			get_by_id("table1").rows[i].cells[2].innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a>";
		}
		
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "none";
			get_by_id("full_msg").style.display = "";
		}else{
			clear_info();
		}
	}
	
	function update_DataArray(){
		var index = parseInt(get_by_id("edit").value);
		var insert = false;
		var type, Machine;
	
		if(index == "-1"){      //save
			index = parseInt(get_by_id("max_row").value) + 1;
			get_by_id("max_row").value = index;
			insert = true;
		}
	
		if(get_by_name("type")[0].checked){
			type = "0";
			Machine = get_by_id("ip").value;
		}else if(get_by_name("type")[1].checked){
			type = "1";
			Machine = get_by_id("mac").value;
		}else if(get_by_name("type")[2].checked){
			type = "2";
			Machine = _aa_other_machines;
		}
		
		if(insert){
			DataArray[index] = new Data(type, Machine, index);			
		}else if (index != -1){
			DataArray[index].Type = type;
			DataArray[index].Machine = Machine;
			DataArray[index].OnList = index;
		}
	}

	function check_info(){
		if(DataArray.length < 2){
			alert(aa_alert_10);
			return false;
		}
		return true;	
	}

	function save_info(){
		var Machine_list = "";
		var max_row = get_by_id("max_row").value;
		for(var i = 1; i <= max_row; i++){
			var Machine_name = DataArray[i].Machine;
			if(DataArray[i].Machine == _aa_other_machines){
				Machine_name = "other";
			}
			if(i == 1){
				Machine_list = Machine_name;
			}else{
				Machine_list = Machine_list + "," + Machine_name;
			}
		}
		get_by_id("asp_temp_02").value = Machine_list;
	}

	function send_previous(){
		get_by_id("html_response_page").value = "adv_access_add2.asp";
		get_by_id("html_response_return_page").value = "adv_access_add2.asp";
		return true;
	}
		
	function send_next(){
		if(!check_info())
			return false;
			
		save_info();
		return true;
	}

	function send_request(){
		if(!check_info())
			return false;
			
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		return true;
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td height="29"><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 5);</script>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
			<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
		   <input type="hidden" id="del" name="del" value="-1">
		   <input type="hidden" id="edit" name="edit" value="-1">
		   <input type="hidden" id="max_row" name="max_row" value="0">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add4.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add4.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">

			<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<!--# echo asp_temp_00 -->">	<!-- Policy Name -->
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<!--# echo asp_temp_02 -->">	<!-- Machine -->
			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<!--# echo asp_temp_03 -->">	<!-- filter method -->
			<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<!--# echo asp_temp_04 -->">	<!-- firewall rule 1 -->
			<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<!--# echo asp_temp_05 -->">	<!-- firewall rule 2 -->
			<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<!--# echo asp_temp_06 -->">	<!-- firewall rule 3 -->
			<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<!--# echo asp_temp_07 -->">	<!-- firewall rule 4 -->
			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<!--# echo asp_temp_08 -->">	<!-- firewall rule 5 -->
			<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<!--# echo asp_temp_09 -->">	<!-- firewall rule 6 -->
			<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">	<!-- firewall rule 7 -->
			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<!--# echo asp_temp_11 -->">	<!-- firewall rule 8 -->
			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<!--# echo asp_temp_12 -->">	<!-- logging -->
			<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<!--# echo asp_temp_13 -->">	<!-- Policy Name list -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<!--# echo asp_temp_14 -->">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<!--# echo asp_temp_15 -->">	<!-- prev_page -->
			<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<!--# echo asp_temp_16 -->">	<!-- max_row -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2><script>show_words(_aa_wiz_s4_title);</script></h2>
				<table width="525" id="add_table">
				  <tbody>
				  	  <tr>
					  	<td colspan="2" height="30"><P class="box_msg"><script>show_words(_aa_wiz_s4_msg);</script></P></td>
					  </tr>
				  	  <tr>
					  	<td colspan="2" height="30"><p><script>show_words(_aa_wiz_s4_help);</script></p></td>
					  </tr>
					  <tr>
						<td class="duple"><script>show_words(aa_AT);</script> :</td>
						<td width="485">&nbsp;
							<input type="radio" id="type" name="type" checked onClick="click_type()"><script>show_words(_ip);</script>
							<input type="radio" id="type" name="type" onClick="click_type()"> <script>show_words(_mac);</script>
							<input type="radio" id="type" name="type" onClick="click_type()"> <script>show_words(_aa_other_machines);</script>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple"><script>show_words(_ipaddr);</script> :</td>
						<td width="485">&nbsp;
							<input type="text" id="ip" name="ip" maxlength="15" size="20">
							&lt;&lt;
							<select id="ip_list" name="ip_list" onChange="key_word(this,'ip');">
								<option value=""><script>show_words(bd_CName);</script></option>
								<script>
								set_mac_list("ip");
								</script>
							</select>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple"><script>show_words(aa_MAC);</script> :</td>
						<td width="485">&nbsp;
							<input type="text" id="mac" name="mac" size="20">
							&lt;&lt;
							<select id="mac_list" name="mac_list" onChange="key_word(this,'mac');">
								<option value=""><script>show_words(bd_CName);</script></option>
								<script>
								set_mac_list("mac");
								</script>
							</select>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
							<input type="button" id="clone" name="clone" value="" onClick="clone_mac_action()">
									<script>get_by_id("clone").value= _clone;</script>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">
							&nbsp; 
							<input type="button" id="ok" name="ok" value="" onClick="add_row()">
								<script>get_by_id("ok").value= _ok;</script>
							&nbsp;
							<input type="button" id="clear" name="clear" value="" onClick="clear_info()">                  
								<script>get_by_id("clear").value= _clear;</script>
						</td>
					  </tr>
				  </tbody>
				</table>
				<table width="525" id="full_msg" style="display:none">
					<tr>
						<td height="30"><script>show_words(aa_alert_17);</script></td>
					</tr>
				</table>
				<table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
					<tr>
						<td width="70%"><strong><script>show_words(aa_Machine);</script></strong></td>
						<td width="15%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
					</tr>
					<script>
						set_machine_list();
						for(i = 1; i < DataArray.length; i++){
							document.write("<tr><td>" + DataArray[i].Machine +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></td></tr>");
						}
						
					</script>
				</table>
				<hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="submit" id="prev" value="" onClick="return send_previous();">
							<script>get_by_id("prev").value=_prev;</script>
						&nbsp; 
						<input name="next" type="submit" id="next" value="" onClick="return send_next();">
							<script>get_by_id("next").value=_next;</script>
						&nbsp;
						<input name="save" type="submit" id="save" value="" onClick="return send_request();">                  
							<script>get_by_id("save").value=_save;</script>
						&nbsp; 
						<input name="cancel" type="button" id="cancel" value="" onClick="exit_access()">
							<script>get_by_id("cancel").value=_cancel;</script>
					</div>
				  </td>
				</table>
            </div>
			</div>
	  		</td>
	  		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                          <p><script>show_words(hhac_en);</script></p>
						  <p><script>show_words(hhac_add);</script></p>
						  <p><script>show_words(hhac_edit);</script></p>
						  <p><script>show_words(hhac_delete);</script></p>
						  <p><a href="support_adv.asp#Access_Control" onclick="return jump_if()"><script>show_words(_more);</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
show_save_button();
onPageLoad();
</script>
</html>
