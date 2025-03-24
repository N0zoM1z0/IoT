<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language=JavaScript>
var submit_button_flag = 0;
var kinds_array = new Array("Custom","Dynamic","Static");
var ddns_status = "<!--# exec cgi /bin/get_ddns_status ddns_status -->";
var ddns_ipv6 = "<!--# echo ddns_ipv6_enable -->";

// ref
var rule_max_num = 10;
var resert_rule = rule_max_num;
var DataArray = new Array();
var IPv6Client_DataArray = new Array();

var xmlhttp;
var do_xml = 1;

function Data(enable, name, ip, onList)
{
	this.Enable = enable;
	this.Name = name;
	this.IP = ip;
	this.OnList = onList;
}

function IPv6Client_Data(name,ip)
{
	this.Name = name;
	this.IP = ip;
}

function set_reservation()
{
	var index = 1;
	for (var i = 0; i < rule_max_num; i++) {
		var temp_dhcp;
		var k = i;
		if (parseInt(i) < 10) {
			k = "0" + i;
		}
		
		temp_dhcp = (get_by_id("ddns_ipv6_" + k).value).split("/");
		if (temp_dhcp.length > 1) {
			if (temp_dhcp[1].length > 0) {
				DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], index);
				index++;
			}
		}
	}
	get_by_id("max_row").value = index - 1;
}

function edit_row(idx)
{
	if (DataArray[idx].Enable == 1)
		get_by_id("reserved_enable").checked = true;
	else
		get_by_id("reserved_enable").checked = false;

	get_by_id("reserved_name").value = DataArray[idx].Name;
	get_by_id("reserved_ip").value = DataArray[idx].IP;
	get_by_id("edit").value = idx;
}

function delete_data()
{
	var num = parseInt(get_by_id("del").value);
	var DataArray_length = parseInt(DataArray.length) - 1;
	var newDataArray = new Array();
	newDataArray[0] = new Data("", "", "", "");
	nowIndex = 1;
	for (var i=1; i<=DataArray_length; i++) {
		if (i != num) {
			newDataArray[nowIndex] = new Data(DataArray[i].Enable, DataArray[i].Name, DataArray[i].IP, DataArray[i].OnList);
			nowIndex ++;
		}
	}
	DataArray = new Array();
	DataArray = newDataArray;
	--DataArray_length;
	get_by_id("max_row").value = parseInt(DataArray_length);
	clear_reserved();
}


function delete_row()
{
	var del_index = parseInt(get_by_id("del").value);
	var tb1 = get_by_id("table1");
	var DataArray_length = parseInt(DataArray.length) - 1;

	if (del_index >= DataArray_length) {
		tb1.deleteRow(del_index);
	}
	else {
		for (var i = del_index; i < DataArray_length; i++) {
			var is_checked = "";
			if (parseInt(DataArray[i+1].Enable)) {
				is_checked = " checked";
			}

			var edit = i + 1;
			get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + edit + ")' " + is_enable + "></center>"
			get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[edit].Name +"</center>"
			get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[edit].IP +"</center>"
			get_by_id("table1").rows[i].cells[3].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
			get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
		}
		tb1.deleteRow(DataArray_length);
	}
	delete_data();
}

function del_row(idx)
{
	edit_row(idx);
	if (confirm(aa_ACC_06 + DataArray[idx].IP)) {
		get_by_id("del").value = idx;
		delete_row();
	}
}


function set_reserved_enable(idx)
{
	if (get_by_id("r_enable" + idx).checked) {
		if (confirm(dynamic_dns_ipv6_enable + " " + DataArray[idx].IP + " ? ")) {
		DataArray[idx].Enable = 1;
		get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}
		else {
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}
	}
	else {
		if (confirm(dynamic_dns_ipv6_disable + " " + DataArray[idx].IP + " ? ")) {
			DataArray[idx].Enable = 0;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}
		else {
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}
	}
}

function update_DataArray()
{
	var index = parseInt(get_by_id("edit").value);
	var insert = false;
	var is_enable = "0";

	if (index == "-1") {      //save
		if (get_by_id("max_row").value == rule_max_num) {
			alert("Schedule rules is Full! Please Delete an Entry.");
		}
		else {
			index = parseInt(get_by_id("max_row").value) + 1;
			get_by_id("max_row").value = index;
			insert = true;
		}
	}

	if (get_by_id("reserved_enable").checked)
		is_enable = "1";
	else
		is_enable = "0";

	if (insert) {
		DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, index);
	}
	else if (index != -1) {
		DataArray[index].Enable = is_enable;
		DataArray[index].Name = get_by_id("reserved_name").value;
		DataArray[index].IP = get_by_id("reserved_ip").value;
		DataArray[index].OnList = index;
	}

	return true;
}

function save_reserved(bufferSaveFlag)
{
	var index = 0;
	var reserved_name = get_by_id("reserved_name").value;
	var reserved_ip = get_by_id("reserved_ip").value;

	if (reserved_name == "") {
		alert(ipv6_ip_illegal_arr);
		return false;
	}

	//check DNS Address
	var primary_dns;
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,"IPv6 address");
	primary_dns = reserved_ip;
	if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol
		return false;
	}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol
		temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
		if (!check_ipv6_address(temp_ipv6_primary_dns ,"::")){
			return false;
		}
	}else{	//not find '::' symbol
		temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
		if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
			return false;
		}
	}

	//check same ip/mac start
	var index = parseInt(get_by_id("edit").value);
	var edit_tmp = get_by_id("edit").value;

	for (m=1; m < DataArray.length; m++) {
		if (m == index) {
			continue;
		}
		else {
			if (get_by_id("reserved_name").value.length > 0) {
				if ((get_by_id("reserved_name").value == DataArray[m].Name)) {
					alert(" name '" + reserved_name + "' is already used.");
					return false;
				}
			}

			if (reserved_ip.length > 0) {
				if ((reserved_ip == DataArray[m].IP)) {
					alert(" IP Address '" + reserved_ip + "' is already used.");
					return false;
				}
			}
		}
	}

	update_DataArray();

	var is_enable = "";
	if (get_by_id("edit").value == "-1") {     //add
		var i = get_by_id("max_row").value;
		var tb1 = get_by_id("table1");
		var oTr = tb1.insertRow(-1);
		var oTd1 = oTr.insertCell(-1);
		var oTd2 = oTr.insertCell(-1);
		var oTd3 = oTr.insertCell(-1);
		var oTd4 = oTr.insertCell(-1);
		var oTd5 = oTr.insertCell(-1);

		if (parseInt(DataArray[i].Enable))
			is_enable = "checked";
		else
			is_enable = "";

		oTd1.innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
		oTd2.innerHTML = "<center>" + DataArray[i].Name +"</center>"
		oTd3.innerHTML = "<center>" + DataArray[i].IP +"</center>"
		oTd4.innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
		oTd5.innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
	}
	else {    //update
		var i = parseInt(get_by_id("edit").value);
		if (parseInt(DataArray[i].Enable))
			is_enable = "checked";
		else
			is_enable = "";

		get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
		get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[i].Name +"</center>"
		get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[i].IP +"</center>"
		get_by_id("table1").rows[i].cells[3].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
		get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
	}

	clear_reserved();
	return true;
}

function clear_reserved()
{
	get_by_id("reserved_enable").checked = false;
	get_by_id("reserved_name").value = "";
	get_by_id("reserved_ip").value = "";
	get_by_id("edit").value = -1;
}


function update_data()
{
	var max_row = parseInt(get_by_id("max_row").value) + 1;
	for (var ii = 0; ii < rule_max_num; ii++) {
		if (ii < 10)
			get_by_id("ddns_ipv6_0" + ii).value = "";
		else
			get_by_id("ddns_ipv6_" + ii).value = "";
	}

	for (var ii = 1; ii < max_row; ii++) {
		if (DataArray[ii].Name != "") {
			var dat = DataArray[ii].Enable +"/"+ DataArray[ii].Name +"/"+ DataArray[ii].IP;
			//                alert(dat);
			if ((ii-1) < 10)
				get_by_id("ddns_ipv6_0" + (ii-1)).value = dat;
			else
				get_by_id("ddns_ipv6_" + (ii-1)).value = dat;
		}
	}
}

var xmlhttp;
var do_xml = 1;

// xml
function xmldoc(){
	var status;

	if ( !(xmlhttp.readyState == 4 && xmlhttp.status == 200) ) {
		return;
	}

	var v4_status;
	var v6_status;

	v4_status = ddns_disconnect;
	try {
		status = xmlhttp.responseXML.getElementsByTagName("ddns_status")[0].firstChild.nodeValue;
	} catch(e){
		status = "fail";
	}

	v4_status = status;
	v6_status = ddns_disconnect;

	var pass = 1;
	var index = 1;
	for (var i = 0; i < rule_max_num; i++) {
		var temp_dhcp;
		var k = i;
		if (parseInt(i) < 10) {
			k = "0" + i;
		}

		temp_dhcp = (get_by_id("ddns_ipv6_" + k).value).split("/");
		if (temp_dhcp.length > 1) {
			if (temp_dhcp[1].length > 0) {
				index++;
				if( (temp_dhcp[0]*1) == 1) {
					// only get enable
					try {
						status = xmlhttp.responseXML.getElementsByTagName("ddns_ipv6_" + k)[0].firstChild.nodeValue;
					} catch(e){
						status = "fail";
					}

					if( status == "success" || status == ddns_connecting ) {
					}
					else if( status == "update") {
						v6_status = status;
						pass = 0;
						break;
					}
					else {
						//alert(status);   
						if( status == "hostname")
							s = "hostName";
						else
							s = "auth";

						s =  s + ":" + temp_dhcp[1];
						//get_by_id("ipv6_status").innerHTML = "ipv6 fail: " + s;
						v6_status = status;
						pass = 0; // fail
						break;
					}
				}
			}
		}
	}

	if( pass )
		v6_status = ddns_connected;

	if( ddns_ipv6 == "1") {
		if( v4_status == "update" || v6_status == "update")
			ddns_status = ddns_connecting;
		else if( v4_status == "success" && v6_status == ddns_connected)
			ddns_status = ddns_connected;
		else
			ddns_status = ddns_disconnect;
		} else {
		if( v4_status == "update" )
			ddns_status = ddns_connecting;
			else if(v4_status == "success")
			ddns_status = ddns_connected;
			else
				ddns_status = ddns_disconnect;
	}

	get_by_id("ipv6_status").innerHTML = ddns_status;
}

function get_File() {
	if( !do_xml) 
		return;

	xmlhttp = createRequest();
	if(xmlhttp){
		var url = "";
		var temp_cURL = document.URL.split("/");
		
		for (var i = 0; i < temp_cURL.length-1; i++) {
			if (i == 1) continue;
			if (i ==0)
				url += temp_cURL[i] + "//";
			else
				url += temp_cURL[i] + "/";
		}
		url += "ddns_status.xml";
		xmlhttp.onreadystatechange = xmldoc;
		xmlhttp.open("GET", url, true);
		xmlhttp.send(null);
	}
	setTimeout("get_File()",5000);
}


function createRequest() {
	var XMLhttpObject = null;
	try {
		XMLhttpObject = new XMLHttpRequest();
	} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				return null;
			}
		}
	}
	return XMLhttpObject;
}

function set_mac_info()
{
	// 00:0c:29:66:82:f6/UNKNOWN/2000::20c:29ff:fe66:82f6@
	var temp_list = get_by_id("ipv6_client_list").value.split("@");
	var index = 0;

	for (var i = 0; i < temp_list.length; i++)
	{
		var temp_data = temp_list[i].split("/");
		if(temp_data.length != 0)
		{
			if(temp_data.length > 1)
			{
				var temp_ipv6_address = temp_data[2].split(",");
				if(temp_ipv6_address.length > 1)
				{
					for(var j = 0; j < temp_ipv6_address.length;j++)
					{
						document.write("<option value='" + temp_ipv6_address[j] + "'>" + temp_data[1] + "</option>");
						IPv6Client_DataArray[IPv6Client_DataArray.length++] = new IPv6Client_Data(temp_data[1], temp_ipv6_address[j]);
						index++;
					}
				}
				else {
					document.write("<option value='" + temp_data[2] + "'>" + temp_data[1] + "</option>");
					IPv6Client_DataArray[IPv6Client_DataArray.length++] = new IPv6Client_Data(temp_data[1], temp_data[2]);
					index++;
				}
			}
		}
	}
}


function set_reserved()
{
	var idx = parseInt(get_by_id("reserved_list").selectedIndex);
	if (idx > 0) {
		get_by_id("reserved_ip").value = IPv6Client_DataArray[idx - 1].IP;
	}
}


function onPageLoad(){
	set_checked("<!--# echo ddns_enable -->", get_by_id("d_enable"));
	if (get_by_id("d_enable").checked) {
		get_by_id("copy_app5").disabled = false;
	} else {
		get_by_id("copy_app5").disabled = true;
	}
	var ddns_type = get_by_id("ddns_type").value;
	get_by_id("ddns_type_value").value = ddns_type;
	var ddns_dyndns_kinds = get_by_id("ddns_dyndns_kinds").value

	if(ddns_type == "dyndns.com"){
		for(i=0;i<kinds_array.length;i++){
			if(ddns_dyndns_kinds == kinds_array[i]){
				get_by_id("ddns_type_value").value = get_by_id("ddns_type_sel").options[i+2].text;
				break;
			}
		}
	}else{
		for (var pp=0; pp<get_by_id("ddns_type_sel").options.length; pp++){
	        if (get_by_id("ddns_type").value == get_by_id("ddns_type_sel").options[pp].value){
	            get_by_id("ddns_type_value").value = get_by_id("ddns_type_sel").options[pp].text;
	            break;
	        }
	    }
	}

// ipv6 
	if( ddns_ipv6 == "1") { 
		document.getElementById("ipv6_dyndns_list").style.display = "block";
		document.getElementById("ipv6_dyndns_edit").style.display = "block";
	}

	if (ddns_type =="www.dlinkddns.com" & ddns_dyndns_kinds =="Dynamic"){
		get_by_id("ddns_type_value").value = "www.dlinkddns.com";
	}else if (ddns_type =="www.dyndns.com" & ddns_dyndns_kinds =="Custom"){
		get_by_id("ddns_type_value").value = "www.dyndns.com";
	}else if (ddns_type =="www.dyndns.com" & ddns_dyndns_kinds =="Dynamic"){
		get_by_id("ddns_type_value").value = "www.dyndns.com";
	}else{
		get_by_id("ddns_type_value").value = ddns_type;
	}

	if(get_by_id("d_enable").checked == false){
		do_xml = 0;
		get_by_id("ipv6_status").innerHTML = ddns_disconnect;
	}
	get_File();
	if("<!--# echo feature_ipv6 -->" == "1"){
		get_by_id("ipv6_dyndns_list").style.display ="";
		get_by_id("ipv6_dyndns_edit").style.display ="";
	} else {
		get_by_id("ipv6_dyndns_list").style.display ="none";
		get_by_id("ipv6_dyndns_edit").style.display ="none";
	}

	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true); 
	}else{ 
		disable_obj();
	}
}

function check_ddns(){		
	var ddnsEnable = get_by_id("d_enable");
	
	if (ddnsEnable.checked){
		temp_obj = get_by_id("ddns_sync_interval");
		var timeout_msg = replace_msg(check_num_msg, td_Timeout, 1, 8760);
		obj = new varible_obj(temp_obj.value, timeout_msg, 1, 8760, false);
		
		if (get_by_id("ddns_type_value").value == ""){
			alert(GW_DYNDNS_SERVER_INDEX_VALUE_INVALID);
			return false;
		}else if (get_by_id("ddns_hostname").value == ''){
			alert(GW_DYNDNS_HOST_NAME_INVALID);
			return false;
		}else if (get_by_id("ddns_username").value == ''){
			alert(GW_DYNDNS_USER_NAME_INVALID);
			return false;
		}else if (get_by_id("ddns_password1").value == ''){
			alert(GW_DYNDNS_PASSWORD_INVALID);
			return false;
		}/*else if (get_by_id("ddns_password1").value != get_by_id("ddns_password2").value){
			alert(YM177);
			return false;
		}*/
              else if(!check_varible(obj)){
    			return false;
    		}
	}
	
	return true;
}

function send_request(){
	update_data();
	if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		return false;
	}
	if (check_ddns()){
		get_by_id("ddns_enable").value = get_checked_value(get_by_id("d_enable"));
		get_by_id("ddns_type").value = get_by_id("ddns_type_value").value;		
		if(submit_button_flag == 0){
			update_data();
			submit_button_flag = 1;
			send_submit("form1");
		}
	}
}

function disable_obj(){
	var re_enable = get_by_id("d_enable");
	var is_disable = true;
	if (re_enable.checked){
		is_disable = false;
	}
	get_by_id("ddns_type_value").disabled= is_disable;
	get_by_id("ddns_type_sel").disabled = is_disable;
	get_by_id("ddns_hostname").disabled = is_disable;
	get_by_id("ddns_username").disabled = is_disable;
	get_by_id("ddns_password1").disabled = is_disable;
	//get_by_id("ddns_password2").disabled = is_disable;
	get_by_id("ddns_sync_interval").disabled = is_disable;
	get_by_id("copy_app5").disabled = is_disable;
}

function copy_name(){
	var obj = get_by_id("ddns_type_sel");
	var kinds = get_by_id("ddns_dyndns_kinds");
	if(obj.selectedIndex > 0 && obj.selectedIndex < 3){
		get_by_id("ddns_type_value").value = obj.options[obj.selectedIndex].text;
		get_by_id("ddns_type").value = obj.options[obj.selectedIndex].value;
		if(obj.selectedIndex > 1 && obj.selectedIndex < 5){
			get_by_id("ddns_dyndns_kinds").value = kinds_array[obj.selectedIndex-2];
		}
	}
}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onClick="return jump_if();"><!--# echo model_number --></a></td>
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
			<td><img src="/short_modnum.gif" width="125" height="25"></td>
			<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<script>show_left("tools", 6);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<form  name="form1" id="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_ddns.asp">
				<input type="hidden" id="ddns_password" name="ddns_password" value="<!--# echo ddns_password -->">
				<input type="hidden" id="ddns_dyndns_kinds" name="ddns_dyndns_kinds" value="<!--# echo ddns_dyndns_kinds -->">
				<input type="hidden" id="ddns_type" name="ddns_type" value="<!--# echo ddns_type -->">
				<input type="hidden" id="edit" name="edit" value="-1">
				<input type="hidden" id="del" name="del" value="-1">
				<input type="hidden" id="max_row" name="max_row" value="-1">
				<input type="hidden" id="ddns_ipv6_enable" name="ddns_ipv6_enable" value="<!--# echo ddns_ipv6_enable -->">
				<input type="hidden" id="ddns_ipv6_00" name="ddns_ipv6_00" value="<!--# echo ddns_ipv6_00 -->">
				<input type="hidden" id="ddns_ipv6_01" name="ddns_ipv6_01" value="<!--# echo ddns_ipv6_01 -->">
				<input type="hidden" id="ddns_ipv6_02" name="ddns_ipv6_02" value="<!--# echo ddns_ipv6_02 -->">
				<input type="hidden" id="ddns_ipv6_03" name="ddns_ipv6_03" value="<!--# echo ddns_ipv6_03 -->">
				<input type="hidden" id="ddns_ipv6_04" name="ddns_ipv6_04" value="<!--# echo ddns_ipv6_04 -->">
				<input type="hidden" id="ddns_ipv6_05" name="ddns_ipv6_05" value="<!--# echo ddns_ipv6_05 -->">
				<input type="hidden" id="ddns_ipv6_06" name="ddns_ipv6_06" value="<!--# echo ddns_ipv6_06 -->">
				<input type="hidden" id="ddns_ipv6_07" name="ddns_ipv6_07" value="<!--# echo ddns_ipv6_07 -->">
				<input type="hidden" id="ddns_ipv6_08" name="ddns_ipv6_08" value="<!--# echo ddns_ipv6_08 -->">
				<input type="hidden" id="ddns_ipv6_09" name="ddns_ipv6_09" value="<!--# echo ddns_ipv6_09 -->">
				<input type="hidden" id="ipv6_client_list" name="ipv6_client_list" value="<!--# exec cgi /bin/ipv6 ipv6_client_list -->">

				<input type="hidden" id="reboot_type" name="reboot_type" value="application">
				<input type="hidden" name="result_timer" value="10">
				<input type="hidden" id="action" name="action" value="tools_ddns">
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
						<h1><script>show_words(_dyndns)</script></h1>
						<p>
							<script>show_words(td_intro_DDNS)</script>
						</p>
						<br>
                    	<input name="button1" id="button1" type="button" class=button_submit value="" onClick="send_request();">
                    	<input name="button2" id="button2" type=reset class=button_submit value="" onClick="return page_cancel('form1', 'tools_ddns.asp');">
						<script>check_reboot();</script>						
						<script>get_by_id("button1").value = _savesettings</script>
						<script>get_by_id("button2").value = _dontsavesettings</script>
				    <br>           
				  </div>
				  <div class="box"> 
						<h2><script>show_words(td_DDNSSET);</script></h2>
							<table width=525 border=0 cellpadding=0>
                             
                                <tr>
                                  <td width=150 align=right class="duple"><script>show_words(td_EnDDNS)</script> :</td>
                                  <td height=20>&nbsp;
                                    <input name="d_enable" type="checkbox" id="d_enable" value="1" onClick="disable_obj();">
                                    <input type="hidden" id="ddns_enable" name="ddns_enable" value="<!--# echo ddns_enable -->">
                                  </td>
                                </tr>
                                <tr>
                                  <td align=right class="duple"><script>show_words(td_SvAd)</script> :</td>
                                  <td height=20 nowrap="nowrap">&nbsp;&nbsp;
                                    <input type="text" id="ddns_type_value" name="ddns_type_value" value="">
                                    <input id="copy_app5" name="copy_app5" type=button value="<<" class="button" onClick="copy_name();">
                                    <select id="ddns_type_sel" name="ddns_type_sel" tabindex=2>
									  <option><script>show_words(tt_SelDynDns)</script></option>
									  <option value="dlinkddns.com">dlinkddns.com</option>
									  <option value="dyndns.com">dyndns.com</option>
									  <!--option value="dyndns.com">www.DynDns.com(Free)</option-->
									  <option value="<!--# echo ddns_type -->">Manual</option>
                                    </select>
                                  </td>
                                </tr>
                                <tr>
                                  <td align=right class="duple"><script>show_words(_hostname)</script> :</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_hostname" name="ddns_hostname" size="40" maxlength="60" value="<!--# echo ddns_hostname -->">
                                  </td>
                                </tr>
                                <tr>
                                  <td align=right class="duple"><script>show_words(td_UNK)</script>&nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_username" name="ddns_username" size="40" maxlength="60" value="<!--# echo ddns_username -->">
                                  </td>
                                </tr>
                                <tr>
                                  <td align=right class="duple"><script>show_words(td_PWK)</script>&nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="password" id="ddns_password1" name="ddns_password1" size="40" maxlength="40" value="WDB8WvbXdH" onChange="key_word(this,'ddns_password');">
                                  </td>
                                </tr>
                                <!--tr>
                                  <td align=right class="duple"><script>show_words(td_VPWK)</script> &nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="password" id="ddns_password2" name="ddns_password2" size="40" maxlength="40" value="WDB8WvbXdH">
                                  </td>
                                </tr-->
                                <tr>
                                  <td align=right class="duple"><script>show_words(td_Timeout)</script> &nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;
                                    <input type="text" id="ddns_sync_interval" name="ddns_sync_interval" size="10" maxLength="4" value="<!--# echo ddns_sync_interval -->"> <script>show_words(td_)</script>
                                  </td>
                                </tr>
                                <tr>
                                  <td align=right class="duple"><script>show_words(_status)</script> &nbsp;:</td>
                                  <td height=20>&nbsp;&nbsp;<span id="ipv6_status"></span></td>
                                </tr>
				    </table>
				  </div>
	<div class="box" id="ipv6_dyndns_edit" style="display:none ">
		<h2><script>show_words(dynamic_dns_ipv6)</script></h2>
		<table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
			<tr>
				<td class="duple"><script>show_words(_enable)</script>:</td>
				<td width="450">&nbsp;<input type=checkbox id="reserved_enable" name="reserved_enable"></td>
			</tr>
			<tr>
				<td class="duple"><script>show_words(IPV6_TEXT0)</script>:</td>
				<td width="450">&nbsp;
					<input type=text id="reserved_ip" name="reserved_ip" size="30">
					<input name="copy_app5" type=button value="<<" class="button" onClick="set_reserved();">
					<select id="reserved_list" name="reserved_list" >
						<option value=-1><script>show_words(bd_CName)</script></option>
<script>
	set_mac_info();
</script>
					</select>
				</td>
			</tr>
			<tr>
				<td class="duple"><script>show_words(help260)</script>:</td>
				<td width="450">&nbsp;&nbsp;<input type=text id="reserved_name" name="reserved_name" size="30" maxlength="60">(e.g.: <script>show_words(_ipv6_mydomain_net)</script>)</td>
			</tr>
			<tr>
				<td class="duple">&nbsp;</td>
				<td width="450">&nbsp;
				<input type="button" id="save" name="save" value="" onClick="save_reserved();">&nbsp;&nbsp;
				<input type="button" id="clear" name="clear" value="" onClick="clear_reserved();">
				<script>get_by_id("save").value = _save</script>
				<script>get_by_id("clear").value = _clear</script>			
				</td>
			</tr>
		</table>
	</div>

	<div class=box id="ipv6_dyndns_list" style="display:none ">
		<h2><script>show_words(dynamic_dns_ipv6_list)</script></h2>
		<table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
			<tr>
				<td><script>show_words(_enable)</script></td>
				<td><script>show_words(_hostname)</script></td>
				<td><script>show_words(IPV6_TEXT0)</script></td>
				<td></td>
				<td></td>
			</tr>
<script>
	set_reservation();
	var is_enable = "";

	for(i = 1; i < DataArray.length; i++){
		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		document.write("<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td>" +"<td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\" border=\"0\" alt=\"" + _delete + "\"></a></center></td></tr>");
	}
</script>
		</table>
	</div>
					<!-- === END MAINCONTENT === -->
                </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
					  	<p><script>show_words(TA16)</script></p>
					  	<p class="more"><a href="support_tools.asp#DDNS" onClick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	reboot_needed(left["tools"].link[6]);
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
