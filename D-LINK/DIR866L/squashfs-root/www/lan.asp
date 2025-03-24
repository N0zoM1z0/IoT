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
<script language="JavaScript">
var submit_button_flag = 0;	
var rule_max_num = 25;
var resert_rule = rule_max_num;
var DataArray = new Array();
var DHCPL_DataArray = new Array();
//var DHCPList_word = "";
var login_who= checksessionStorage();

//1/dddd/192.168.55.55/112255448877
function Data(enable, name, ip, mac, onList, index)
{
	this.Enable = enable;
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.OnList = onList;
	this.INDEX = index;
}

function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}

function set_reservation(){
	var index = 1;
	for (var i = 0; i < rule_max_num; i++){
		var temp_dhcp;
		var k = i;
		if(parseInt(i) < 10){
			k = "0" + i;
		}
		temp_dhcp = (get_by_id("dhcpd_reserve_" + k).value).split("/");
		if (temp_dhcp.length > 1){
			if(temp_dhcp[1].length > 0){
				DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], temp_dhcp[3], index);
				index++;
			}
		}
	}
	get_by_id("max_row").value = index - 1;
}

function set_lan_dhcp_list(){
	var index = 0;
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){
			DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
			//DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
			index++;
		}
	}
	get_by_id("dhcp_num").innerHTML = DHCPL_DataArray.length;
	//set_reservation();
}

function get_static_wins_server(){
	var dhcpd_static_wins_server = "<!--# echo dhcpd_static_wins_server -->";
	var wins_server = dhcpd_static_wins_server.split("/");
	if(wins_server.length != "")
		get_by_id("wins_ip1").value = wins_server[0];
	if(wins_server.length > 1)
		get_by_id("wins_ip2").value = wins_server[1];
}

function onPageLoad(){
	
	set_checked("<!--# echo dhcpd_enable -->", get_by_id("dhcpsvr"));
	set_checked("<!--# echo dns_relay -->", get_by_id("DNSrelay"));
	set_checked("<!--# echo dhcpd_always_bcast -->", get_by_id("always_broadcast"));
	set_checked("<!--# echo dhcpd_netbios_enable -->", get_by_id("netbios_announcement"));
	set_checked("<!--# echo dhcpd_netbios_learn -->", get_by_id("netbios_learn"));
	set_checked("<!--# echo dhcpd_static_node_type -->", get_by_name("netbios_node"));
	get_by_id("DHCPrelay").checked = ("<!--# echo dhcp_relay -->" == "1")? true: false;
	get_by_id("dhcp_relay_input").style.display = get_by_id("DHCPrelay").checked? "": "none";
	get_static_wins_server();
	show_reserved_list();
	get_by_id("DNSrelay").disabled = (get_by_id("opendns_enable").value==1)	? true: false;	
	disable_ip();
	disable_netbios();
        if(login_who== "user"){
                DisableEnableForm(document.form1, true);
        }
}

function clone_mac_action(){
	get_by_id("reserved_mac").value = get_by_id("mac_clone_addr").value;
}

function set_reserved(){
	var idx = parseInt(get_by_id("reserved_list").selectedIndex);
	
	if (typeof (DHCPL_DataArray[idx - 1]) !== "undefined") {
		get_by_id("reserved_enable").checked = true;
		get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
		get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
		get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
	}
}

function set_reserved_enable(idx){
	if(get_by_id("r_enable" + idx).checked){
		if(confirm(YM92 + DataArray[idx].IP)){
			DataArray[idx].Enable = 1;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}
	}else{
		if(confirm(YM93 + DataArray[idx].IP)){
			DataArray[idx].Enable = 0;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}
	}
}

function edit_dhcp_client(idx){
	get_by_id("reserved_enable").checked = true;
	get_by_id("reserved_name").value = DHCPL_DataArray[idx].Name;
	get_by_id("reserved_ip").value = DHCPL_DataArray[idx].IP;
	get_by_id("reserved_mac").value = DHCPL_DataArray[idx].MAC;
}

function edit_row(idx){
	if(DataArray[idx].Enable == 1)
		get_by_id("reserved_enable").checked = true;
	else
		get_by_id("reserved_enable").checked = false;
		
	get_by_id("reserved_name").value = DataArray[idx].Name;
	get_by_id("reserved_ip").value = DataArray[idx].IP;
	get_by_id("reserved_mac").value = DataArray[idx].MAC;
	get_by_id("edit").value = idx;
}

function delete_data(){
	var num = parseInt(get_by_id("del").value);
	var DataArray_length = parseInt(DataArray.length) - 1;

	for(var i = num ; i < DataArray_length; i++){
		DataArray[i].Enable = DataArray[i+1].Enable;
		DataArray[i].Name = DataArray[i+1].Name;
		DataArray[i].IP = DataArray[i+1].IP;
		DataArray[i].MAC = DataArray[i+1].MAC;
		DataArray[i].OnList = DataArray[i+1].OnList-1;
	}
	DataArray[DataArray_length].Enable = false;
	DataArray[DataArray_length].Name = "";
	DataArray[DataArray_length].IP = "";
	DataArray[DataArray_length].MAC = "";
	if (DataArray.length != -1)
		DataArray.length -= 1;

	--DataArray_length;
	get_by_id("max_row").value = parseInt(DataArray_length);
	clear_reserved();
}

function delete_row(){
	var del_index = parseInt(get_by_id("del").value);
	var tb1 = get_by_id("table1");
	var DataArray_length = parseInt(DataArray.length) - 1;
	if (del_index >= DataArray_length){
		var oTr = tb1.deleteRow(del_index);
	}else{
		for(var i = del_index; i < DataArray_length; i++){
			var is_enable = "";
			if(parseInt(DataArray[i+1].Enable)){
				is_enable = " checked";
			}
			var edit = i + 1;
			get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + edit + ")' " + is_enable + "></center>"
			get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[edit].Name +"</center>"
			get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[edit].MAC +"</center>"
			get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[edit].IP +"</center>"
			get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
			get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
		}
		var oTr = tb1.deleteRow(DataArray_length);
	}
	delete_data();
}

function del_row(idx){
	edit_row(idx);
	if(confirm(YM25 + " " + DataArray[idx].IP)){
		get_by_id("del").value = idx;
		delete_row();
	}
}

function update_DataArray(){
	var index = parseInt(get_by_id("edit").value);
	var insert = false;
	var is_enable = "0";

	if(index == "-1"){      //save
		if(get_by_id("max_row").value == rule_max_num){
			alert(YM88);
		}else{
			index = parseInt(get_by_id("max_row").value) + 1;
			get_by_id("max_row").value = index;
			insert = true;
		}
	}

	if(get_by_id("reserved_enable").checked){
		is_enable = "1";
	}else{
		is_enable = "0";
	}
	
	if(insert){
		DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, get_by_id("reserved_mac").value, index, index+1);			
	}else if (index != -1){
		DataArray[index].Enable = is_enable;
		DataArray[index].Name = get_by_id("reserved_name").value;
		DataArray[index].IP = get_by_id("reserved_ip").value;
		DataArray[index].MAC = get_by_id("reserved_mac").value;
		DataArray[index].OnList = index;
	}
}

function save_reserved(){
	var index = 0;
	var ip = get_by_id("lan_ipaddr").value;
	var mask = get_by_id("lan_netmask").value;
	var reserved_name = get_by_id("reserved_name").value;
	var reserved_ip = get_by_id("reserved_ip").value;
	var reserved_mac = get_by_id("reserved_mac").value;
	var start_ip = get_by_id("dhcpd_start").value;
	var end_ip = get_by_id("dhcpd_end").value;

	var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
	var Res_ip_addr_msg = replace_msg(all_ip_addr_msg, _res_ipaddr);
	var start_ip_addr_msg = replace_msg(all_ip_addr_msg, STATIC_IP_ADDRESS);
	var end_ip_addr_msg = replace_msg(all_ip_addr_msg, END_IP_ADDRESS);

	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
	var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

	var re = /[^A-Za-z0-9_.-]/;
	
	if(reserved_name == ""){
		alert(GW_INET_ACL_NAME_INVALID);
		return false;
	}else if(re.test(reserved_name)){
		alert(check_name_invalid);
		return false;
	}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, TEXT033)){
		return false;
	}else if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		return false;
	}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		alert(TEXT033+" " + reserved_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);
		return false;
	}else if (!check_mac(reserved_mac)){
		alert(KR3);
		return false;
	}

	if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)){
		alert(TEXT033+" " + reserved_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
		return false;
	}
	//check same ip/mac start	
	var index = parseInt(get_by_id("edit").value);
	var edit_tmp = get_by_id("edit").value;
	for(m = 1; m < DataArray.length; m++){
		if (m==index){
			continue;
		}else{
			if(get_by_id("reserved_name").value.length > 0){
				if((get_by_id("reserved_name").value == DataArray[m].Name)){
					alert(sp_name+" ("+ get_by_id("reserved_name").value +") "+sp_alreadyused);	
					return false;
				}
			}
			if(reserved_ip.length > 0){
				if((reserved_ip == DataArray[m].IP)){
					alert(TEXT033+" ("+ reserved_ip +") "+sp_alreadyused);	
					return false;
				}
			}
			if(reserved_mac.length > 0){
				if(reserved_mac.toUpperCase() == DataArray[m].MAC.toUpperCase()){
					alert(GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID_a+" "+ reserved_mac +" "+GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID_b);
					return false;
				}
			}

		}
	}
	//check same ip/mac end

	update_DataArray();

	var is_enable = "";
	if(get_by_id("edit").value == "-1"){     //add
		var i = get_by_id("max_row").value;
		var tb1 = get_by_id("table1"); 
		var oTr = tb1.insertRow(-1);
		var oTd1 = oTr.insertCell(-1);
		var oTd2 = oTr.insertCell(-1);
		var oTd3 = oTr.insertCell(-1);
		var oTd4 = oTr.insertCell(-1);
		var oTd5 = oTr.insertCell(-1);
		var oTd6 = oTr.insertCell(-1);

		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		oTd1.innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
			oTd2.innerHTML = "<center>" + DataArray[i].Name +"</center>"
			oTd3.innerHTML = "<center>" + DataArray[i].MAC +"</center>"
			oTd4.innerHTML = "<center>" + DataArray[i].IP +"</center>"
			oTd5.innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
		oTd6.innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
	}else{                                      //update		
		var i = parseInt(get_by_id("edit").value);
		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
			get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[i].Name +"</center>"
			get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[i].MAC +"</center>"
			get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[i].IP +"</center>"
			get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center>";
		get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center>";
	}
	clear_reserved();
}

function clear_reserved(){
	get_by_id("reserved_enable").checked = false;
	get_by_id("reserved_name").value = "";
	get_by_id("reserved_ip").value = "";
	get_by_id("reserved_mac").value = "";
	get_by_id("edit").value = -1;
}

/*
function change_ip(){
		var ip = get_by_id("lan_ipaddr").value;
		var start_ip = get_by_id("dhcpd_start");
		var end_ip = get_by_id("dhcpd_end");		
		var start_ip_4 = get_by_id("start_ip4").value;
		var end_ip4 = get_by_id("end_ip4").value;
		start_ip.value = ip.substring(0, ip.lastIndexOf(".")) +"." + start_ip_4;
		end_ip.value = ip.substring(0, ip.lastIndexOf(".")) + "." + end_ip4;		
}


function print_dhcp_sel(obj_value){
	var print_sel = get_by_id("d_dhcp"+ obj_value).value;
	if(print_sel > -1){
		get_by_id("d_host"+ obj_value).value = DHCPL_DataArray[print_sel].Name;
		get_by_id("d_ip"+ obj_value).value = DHCPL_DataArray[print_sel].IP;
		get_by_id("d_mac"+ obj_value).value = DHCPL_DataArray[print_sel].MAC;
	}
}
*/

function disable_ip(){
	var dhcpsvr = get_by_id("dhcpsvr");
	var is_hidden = "";
	
	if(dhcpsvr.checked) {
		is_hidden = "";
		get_by_id("DHCPrelay").checked = false;
		dhcp_relay_onClick();
	} else {
		is_hidden = "none";
	}
	
	//get_by_id("dhcpd_start").disabled = !dhcpsvr.checked;
	//get_by_id("dhcpd_end").disabled = !dhcpsvr.checked;
	get_by_id("dhcpd_lease_time").disabled = !dhcpsvr.checked;
	get_by_id("always_broadcast").disabled = !dhcpsvr.checked;
	get_by_id("netbios_announcement").disabled = !dhcpsvr.checked;
	get_by_id("add_reserved").style.display = is_hidden;
	get_by_id("reservation_list").style.display = is_hidden;
	get_by_id("dhcpd_list").style.display = is_hidden;
}

function disable_netbios(){
	if(get_by_id("dhcpsvr").checked){
		get_by_id("netbios_learn").disabled = !get_by_id("netbios_announcement").checked;
		disable_netbios_option(get_by_id("netbios_learn").disabled);
		if(get_by_id("netbios_announcement").checked){
			disable_netbios_option(get_by_id("netbios_learn").checked);
		}
	}else{
		get_by_id("netbios_learn").disabled = true;
		disable_netbios_option(get_by_id("netbios_learn").disabled);
	}
	chk_netbios();
}

function chk_netbios(){
	if(get_by_id("netbios_announcement").checked && !get_by_id("netbios_learn").checked){
		if(get_by_name("netbios_node")[0].checked){
			get_by_id("wins_ip1").disabled = true;
			get_by_id("wins_ip2").disabled = true;
		}else{
			get_by_id("wins_ip1").disabled = false;
			get_by_id("wins_ip2").disabled = false;
		}
	} else {
		get_by_id("wins_ip1").disabled = true;
		get_by_id("wins_ip2").disabled = true;
	}
}

function check_netbios(){
	var netbios_name = get_by_id("dhcpd_static_scope").value;

	if (netbios_name.length > 32){
		alert(bd_NETBIOS_LIMIT);
		return false;
	}

	for (var i = 0; i < netbios_name.length ; i++){
		if (!check_name_key_fun(netbios_name.substring(i, i+1))){
			alert(GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID);
			return false;
		}
		/*switch (netbios_name.substring(i, i+1)){
			case '\\':
			case '\'':
			case '~':
			case '!':
			case '@':
			case '
			case '*':
			case '+':
			case '=':
			case '|':
			case ':':
			case ';':
			case '"':
			case '?':
			case '<':
			case '>':
			case ',':
			case ' ':
				//alert("NetBIOS names must not include special characters. ex:\\ * + = | : ; \" ? < > , and space.");
				alert(GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID);
				return false;
			default:

		}*/
	}
	return true;
}

function disable_netbios_option(flag){
	get_by_id("dhcpd_static_scope").disabled = flag;
	for(var i = 0; i < 4; i++){
		get_by_name("netbios_node")[i].disabled = flag;
	}
	get_by_id("wins_ip1").disabled = flag;
	get_by_id("wins_ip2").disabled = flag;
}

function update_data(){
	var max_row = parseInt(get_by_id("max_row").value) + 1;
	for(var ii = 0; ii < rule_max_num; ii++){
		if (ii < 10){
			get_by_id("dhcpd_reserve_0" + ii).value = "";
		}else{
			get_by_id("dhcpd_reserve_" + ii).value = "";
		}
	}
	for(var ii = 1; ii < max_row; ii++){
		if(DataArray[ii].Name != ""){
			var dat = DataArray[ii].Enable +"/"+ DataArray[ii].Name +"/"+ DataArray[ii].IP +"/"+ DataArray[ii].MAC;
			var tmp_ip = (DataArray[ii].IP).toString();
			var ip = get_by_id("lan_ipaddr").value;

			var tmp2_ip = tmp_ip.split(".");
			var ip2 = ip.split(".");
			var mask = get_by_id("lan_netmask").value;
		        var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);

			tmp_ip="";
			for(var i =0; i< 4;i++) {
				if (( parseInt(tmp2_ip[i]) & parseInt(temp_mask_obj.addr[i])) != 
					(parseInt(ip2[i]) & parseInt(temp_mask_obj.addr[i])))

					tmp_ip +=ip2[i];
				else
					tmp_ip +=tmp2_ip[i];

				if(i < 3)
					tmp_ip += ".";
			}
			dat = DataArray[ii].Enable +"/"+ DataArray[ii].Name +"/"+ tmp_ip +"/"+ DataArray[ii].MAC;
	
				
			var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
			var Res_ip_addr_msg = replace_msg(all_ip_addr_msg, _res_ipaddr);
			var temp_res_ip_obj = new addr_obj(tmp_ip.split("."), Res_ip_addr_msg, false, false);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);

			if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
				return false;
			}


			if (parseInt(ii-1) < 10){
				get_by_id("dhcpd_reserve_0" + (ii-1).toString()).value = dat;
			}else{
				get_by_id("dhcpd_reserve_" + (ii-1)).value = dat;
			}
		}
	}
	return true;
}

function show_reserved_list(){
	var reserved_list = "";

	reserved_list = "<table id='table1' width=525 border=1 cellPadding=1 cellSpacing=1 bgcolor='#DFDFDF' bordercolor='#FFFFFF'>";
	reserved_list += "<tr><td>"+_enable+"</td><td>"+_hostname+"</td><td>"+_macaddr+"</td><td>"+_ipaddr+"</td><td></td><td></td></tr>";

	set_reservation();
	var is_enable = "";
	for(i = 1; i < DataArray.length; i++){
		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		reserved_list += "<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td>";
		if(login_who== "user"){
			reserved_list += "<td></td>";
		}else{
			reserved_list += "<td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center></td>";
		}
		if(login_who== "user"){
			reserved_list += "<td></td>";
		}else{
			reserved_list += "<td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center></td></tr>";
		}
	}
	reserved_list += "</table>";

	get_by_id("show_reserved_list").innerHTML = reserved_list;
}

function dynamic_reserved_list(){
	var lan_ip = get_by_id("lan_ipaddr").value.split(".");
	var lan_netmask = get_by_id("lan_netmask").value.split(".");
	var temp_data;
	var temp_ip;
	var temp_list = "";
	var index = 1;
	var k = i;
	for(i = 0; i < rule_max_num; i++){	
		if(parseInt(i) < 10){
			k = "0" + i;
		}

		temp_data = (get_by_id("dhcpd_reserve_" + k).value).split("/");
		if (temp_data.length > 1){
			if(temp_data[2].length > 0){
				temp_ip = temp_data[2].split(".");

				temp_list = lan_ip[0] + "." + lan_ip[1] + "." + lan_ip[2] + "." + temp_ip[3];
			}
			get_by_id("dhcpd_reserve_" + k).value = temp_data[0] + "/" + temp_data[1] + "/" + temp_list + "/" + temp_data[3];
		} else	
			break;
	}
}

function check_dhcp_range(){
		var lan_ip = get_by_id("lan_ipaddr").value.split(".");
		var lan_netmask = get_by_id("lan_netmask").value.split(".");
		var start_ip3 = get_by_id("dhcpd_start").value.split(".");
		var end_ip3 = get_by_id("dhcpd_end").value.split(".");
		var start_ip="", end_ip="";

		for(var i =0; i< 4;i++) {
				if ( ( parseInt(lan_ip[i]) & parseInt(lan_netmask[i])) != 
					(parseInt(start_ip3[i]) & parseInt(lan_netmask[i]))) {
					start_ip +=lan_ip[i];
					end_ip +=lan_ip[i];

				} else if ( ( parseInt(lan_ip[i]) & parseInt(lan_netmask[i])) != 
					(parseInt(end_ip3[i]) & parseInt(lan_netmask[i]))) {
					start_ip +=lan_ip[i];
					end_ip +=lan_ip[i];

				} else {
					start_ip +=start_ip3[i];
					end_ip +=end_ip3[i];
				}

				if(i < 3) {
					start_ip += ".";
					end_ip += ".";
				}
		}
		get_by_id("dhcpd_start").value = start_ip;
		get_by_id("dhcpd_end").value = end_ip;
}

function excute_dynamic_change(){
	check_dhcp_range();
	dynamic_reserved_list();
	show_reserved_list();
}

function send_request(){
	var mask = get_by_id("lan_netmask").value;
	var ip = get_by_id("lan_ipaddr").value;
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var gzone_ip = get_by_id("gzone_ipaddr").value;
	var gzone_mask = get_by_id("gzone_netmask").value;
	var temp_gzone_ip_obj = new addr_obj(gzone_ip.split("."), ip_addr_msg, false, false);
	var temp_gzone_mask_obj = new addr_obj(gzone_mask.split("."), subnet_mask_msg, false, false);

	if (check_address(temp_ip_obj, temp_mask_obj) && check_mask(temp_mask_obj)){
		if(!update_data()){
			return false;
		}
	}else{
		//if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj)){		
		return false;
	}


	if (!check_netbios()){
		return false;
	}

	if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		return false;
	}

	var form = get_by_id("form1");
	form.elements["html_response_message"].value = sc_intro_sv + "<count_down>" + rb_change;
	
	var lan_addr = "<!--# echo lan_ipaddr -->";

	var dhcpsvr = get_by_id("dhcpsvr");
	//var start_ip4 = get_by_id("start_ip4").value;
	//var end_ip4 = get_by_id("end_ip4").value;
	var start_obj, end_obj;
	var temp_mac = "";

	if(lan_addr != ip){
		var change_ip = ip.split("."), source_ip = lan_addr.split(".");
		if ((change_ip[0] != source_ip[0]) ||
		    (change_ip[1] != source_ip[1]) ||
		    (change_ip[2] != source_ip[2])){
			alert(_laninfo2);
		}
		get_by_id("change_lan_ip").value = "1";
	}

	var winsip1 = get_by_id("wins_ip1").value;
	var winsip2 = get_by_id("wins_ip2").value;
	var relay_ip = get_by_id("dhcp_relay_ip").value;
	
    	//var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);	
    	var relay_ip_addr_msg = replace_msg(all_ip_addr_msg,bln_DHCPRelay_IP);
	
	var dhcp_les = get_by_id("dhcpd_lease_time").value;		
	var dhcpd_domain_name = get_by_id("dhcpd_domain_name").value;
	var temp_relay_ip_obj = new addr_obj(relay_ip.split("."), relay_ip_addr_msg, false, false);

	var lan_device_name = get_by_id("lan_device_name").value;

	var wan_proto = "<!--# echo wan_proto -->";
	var wan_port_status = "<!--# echo wan_port_status -->";

	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg, "IP Address");
	var wan_proto = "<!--# echo wan_proto -->";
	var wan_ip_addr;
	
	var temp_wins_ip1_obj = new addr_obj(winsip1.split("."), all_ip_addr_msg, false, false);
	var temp_wins_ip2_obj = new addr_obj(winsip2.split("."), all_ip_addr_msg, false, false);
	
	if (get_checked_value(get_by_id("DHCPrelay"))) {
		if (!check_address(temp_relay_ip_obj)){		
			return false;
		}
		for (var idx = 1; idx < 4; idx++) {
			var multi_ssid = get_by_id("multi_ssid_lan"+idx).value;
			var multi_ssid_arr = multi_ssid.split(",");
			var new_multi_ssid = "";
			for (var i = 0; i < multi_ssid_arr.length-1; i++) {
				new_multi_ssid+=multi_ssid_arr[i]+",";
			}
			new_multi_ssid += "0";
			get_by_id("multi_ssid_lan"+idx).value = new_multi_ssid;
		}
	}
	//check lan and wan is same subnet    	  
	
	//get from nvram
	if(wan_proto == "static"){
		wan_ip_addr= "<!--# echo wan_static_ipaddr -->";
	}else if(wan_proto == "pppoe"){
		wan_ip_addr= "<!--# echo wan_pppoe_ipaddr_00 -->";
	}else if(wan_proto == "pptp"){
		wan_ip_addr= "<!--# echo wan_pptp_ipaddr -->";
	}else if(wan_proto == "l2tp"){
		wan_ip_addr= "<!--# echo wan_l2tp_ipaddr -->";
	}else{
		var wan_ip_addr1 = get_by_id("wan_current_ipaddr").value.split("/");
		wan_ip_addr = wan_ip_addr1[0];
	}	        
	var wan_ip_addr_obj = new addr_obj(wan_ip_addr.split("."), wan_ip_addr_msg, false, false); 
	     
   if(wan_proto == "static" && wan_ip_addr != "0.0.0.0"){ // when wan static ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			alert(bln_alert_3);
			return false;
		}
		
	}else if(wan_proto != "static" & get_by_id("wan_current_ipaddr").value != "0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0"){ // /PPTP/L2TP/PPPoE plug in WAN port
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			alert(bln_alert_3);
			return false;
		}
    }else if(wan_proto == "pppoe" && wan_ip_addr != "0.0.0.0"){ // when wan pppoe ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			alert(bln_alert_3);
			return false;
		}
    }else if(wan_proto == "pptp" && wan_ip_addr != "0.0.0.0"){ // when wan pptp ip doesn't empty
    	if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			alert(bln_alert_3);
			
			return false;
		}
    }else if(wan_proto == "l2tp" && wan_ip_addr != "0.0.0.0"){ // when wan l2tp ip doesn't empty
    	if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			alert(bln_alert_3);
			return false;
		}
    } 
    
    
	/*if(Find_word(dhcpd_domain_name,"'") || Find_word(dhcpd_domain_name,'"') || Find_word(dhcpd_domain_name,"/")){
		alert(GW_LAN_DOMAIN_NAME_INVALID);
		return false;
	}*/
	//Check Device Name / Domain Name cannot entry  ~!@#$%^&*()_+}{[]\|"?></
	var re = /[^A-Za-z0-9_.-]/;
	if(re.test(dhcpd_domain_name)){
		alert(GW_LAN_DOMAIN_NAME_INVALID);
		return false;
	}
	re=/^\W/;	
	if(re.test(lan_device_name)){
		alert(GW_LAN_DEVICE_NAME_INVALID);
		return false;
	}
	
	if (check_DeviceName(lan_device_name)) {
            return false;
        }


		var start_ip = get_by_id("dhcpd_start").value;
		var end_ip = get_by_id("dhcpd_end").value;
		
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP Address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP Address");

		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

		//check dhcp ip range equal to lan-ip or not?
		if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, TEXT035)){
			return false;
		}
		
		if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, TEXT036)){
			return false;
		}
	
		//check dhcp ip range and lan ip the same mask or not?
		if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj)){
			return false;
		}
		
		if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
			alert(TEXT037);
			return false;
		}
			
		if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
			alert(TEXT038);
			return false;
		}
			
		if (!check_ip_order(start_obj, end_obj)){
			alert(TEXT039);
			return false;
		}
		
		if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
			alert(network_dhcp_ip_in_server);
			return false;
		}
	
	if (dhcpsvr.checked){
		if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip1_obj.addr, bd_NETBIOS_PRI_WINS)){
			return false;
		}

		if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip2_obj.addr, bd_NETBIOS_SEC_WINS)){
			return false;
		}		
		for(var i = 1; i < DataArray.length; i++){
			var reserved_ip = DataArray[i].IP;
		var Res_ip_addr_msg = replace_msg(all_ip_addr_msg, _res_ipaddr);
		var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	
		if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)){
			alert(TEXT033+" " + reserved_ip + " "+GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a);	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
			return false;
		}
		}
		
		var less_msg = replace_msg(check_num_msg, bd_DLT, 1, 999999);
		var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
		if (!check_varible(temp_less)){
			return false;
		}

		if(get_by_id("netbios_announcement").checked && !get_by_id("netbios_learn").checked){
			var wins_ip1 = get_by_id("wins_ip1").value;
			var wins_ip2 = get_by_id("wins_ip2").value;
			var wins_ip1_addr_msg = replace_msg(all_ip_addr_msg,bd_NETBIOS_PRI_WINS);
			var wins_ip2_addr_msg = replace_msg(all_ip_addr_msg,bd_NETBIOS_SEC_WINS);
			var wins_ip1_obj = new addr_obj(wins_ip1.split("."), wins_ip1_addr_msg, false, false);
			var wins_ip2_obj = new addr_obj(wins_ip2.split("."), wins_ip2_addr_msg, false, false);

			if(!get_by_name("netbios_node")[0].checked && (!check_address(wins_ip1_obj))){
				return false;
			}else if(get_by_name("netbios_node")[0].checked){
                                if(wins_ip1 !="" && !check_address(wins_ip1_obj)){
					return false;
				}
				if(wins_ip2 !="" && !check_address(wins_ip2_obj)){
					return false;
				}
				get_static_wins_server();
			}
		} else {
			get_static_wins_server();
		}
	}

	//decide reboot type
	if((get_by_id("dhcpd_netbios_enable").value == 1) && (get_by_id("dhcpd_netbios_learn").value == 1))//It enables learn NETBIOS from WAN originally.
	{
		if( !(get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")))) //But, it disables learn NETBIOS from WAN now.
		{	
			get_by_id("reboot_type").value = "all";
			get_by_id("result_timer").value = "50";
		}
	}
	else	//It disables learn NETBIOS from WAN originally.
	{
		if( get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")) ) //But, it enables learn NETBIOS from WAN now.
		{	
			get_by_id("reboot_type").value = "all";
			get_by_id("result_timer").value = "50";
		}
	}

	/*Always check host zone and guest zone subnet even if wireless or guest zone is disabled*/
//	if (("<!--# echo wlan0_enable -->" == "1" && "<!--# echo wlan0_vap1_enable -->" == "1") ||
//		("<!--# echo wlan1_enable -->" == "1" &&"<!--# echo wlan1_vap1_enable -->" == "1")) {
		if (temp_ip_obj && temp_mask_obj) {
			var ipaddr = temp_gzone_ip_obj.addr;
			var maskaddr = temp_gzone_mask_obj.addr;
			var lanipaddr = temp_ip_obj.addr;
			var lanmaskaddr = temp_mask_obj.addr;
			var count = 0;                  
			for (var i = 0; i < ipaddr.length; i++) {
				if ((ipaddr[i] & lanmaskaddr[i]) == (lanipaddr[i] & lanmaskaddr[i]))
					count++;                        
			}
			if (count == ipaddr.length) {
				alert(guestzone_conflict);
				return false;
			}       
		}
//	}

	if (check_address(temp_ip_obj, temp_mask_obj) && check_mask(temp_mask_obj)){
		//change_ip();
		get_by_id("dhcpd_enable").value = get_checked_value(get_by_id("dhcpsvr"));
		get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));
		get_by_id("dhcp_relay").value = get_by_id("DHCPrelay").checked? "1": "0";
		get_by_id("dhcpd_always_bcast").value = get_checked_value(get_by_id("always_broadcast"));
		get_by_id("dhcpd_netbios_enable").value = get_checked_value(get_by_id("netbios_announcement"));
		get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));
		get_by_id("dhcpd_netbios_learn").value = get_checked_value(get_by_id("netbios_learn"));
		get_by_id("dhcpd_static_node_type").value = get_checked_value(get_by_name("netbios_node"));
		get_by_id("dhcpd_static_wins_server").value = get_by_id("wins_ip1").value + "/" + get_by_id("wins_ip2").value;
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}		
}

function revoke(idx){
	get_by_id("revoke_ip").value = DHCPL_DataArray[idx].IP;
	get_by_id("revoke_mac").value = DHCPL_DataArray[idx].MAC;
	send_submit("form2");
}

function dhcp_relay_onClick()
{
	get_by_id("dhcp_relay_input").style.display = get_by_id("DHCPrelay").checked? "": "none";
	if (get_by_id("DHCPrelay").checked) {
		get_by_id("dhcpsvr").checked = false;
		disable_ip();
	}
}

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form2" name="form2" method="post" action="dhcp_revoke.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="lan.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
<input type="hidden" id="action" name="action" value="lan_revoke">
<input type="hidden" id="revoke_ip" name="revoke_ip">
<input type="hidden" id="revoke_mac" name="revoke_mac">
</form>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
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
			<script>show_top("setup");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 2);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
		<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
       <form id="form1" name="form1" method="post" action="apply.cgi">
	   <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
	   <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
	   <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
	   <input type="hidden" id="action" name="action" value="lan">
	   <input type="hidden" id="reboot_type" name="reboot_type" value="lan">
	   <input type="hidden" id="result_timer" name="result_timer" value="20">
	   <input type="hidden" id="del" name="del" value="-1">
	   <input type="hidden" id="edit" name="edit" value="-1">
	   <input type="hidden" id="max_row" name="max_row" value="-1">
	   <input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
	   <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
	   <input type="hidden" id="dhcpd_reserve_00" name="dhcpd_reserve_00" value="<!--# echo dhcpd_reserve_00 -->">				
	   <input type="hidden" id="dhcpd_reserve_01" name="dhcpd_reserve_01" value="<!--# echo dhcpd_reserve_01 -->">
	   <input type="hidden" id="dhcpd_reserve_02" name="dhcpd_reserve_02" value="<!--# echo dhcpd_reserve_02 -->">		
	   <input type="hidden" id="dhcpd_reserve_03" name="dhcpd_reserve_03" value="<!--# echo dhcpd_reserve_03 -->">				
	   <input type="hidden" id="dhcpd_reserve_04" name="dhcpd_reserve_04" value="<!--# echo dhcpd_reserve_04 -->">
	   <input type="hidden" id="dhcpd_reserve_05" name="dhcpd_reserve_05" value="<!--# echo dhcpd_reserve_05 -->">
	   <input type="hidden" id="dhcpd_reserve_06" name="dhcpd_reserve_06" value="<!--# echo dhcpd_reserve_06 -->">				
	   <input type="hidden" id="dhcpd_reserve_07" name="dhcpd_reserve_07" value="<!--# echo dhcpd_reserve_07 -->">
	   <input type="hidden" id="dhcpd_reserve_08" name="dhcpd_reserve_08" value="<!--# echo dhcpd_reserve_08 -->">	
	   <input type="hidden" id="dhcpd_reserve_09" name="dhcpd_reserve_09" value="<!--# echo dhcpd_reserve_09 -->">
	   <input type="hidden" id="dhcpd_reserve_10" name="dhcpd_reserve_10" value="<!--# echo dhcpd_reserve_10 -->">				
	   <input type="hidden" id="dhcpd_reserve_11" name="dhcpd_reserve_11" value="<!--# echo dhcpd_reserve_11 -->">
	   <input type="hidden" id="dhcpd_reserve_12" name="dhcpd_reserve_12" value="<!--# echo dhcpd_reserve_12 -->">		
	   <input type="hidden" id="dhcpd_reserve_13" name="dhcpd_reserve_13" value="<!--# echo dhcpd_reserve_13 -->">				
	   <input type="hidden" id="dhcpd_reserve_14" name="dhcpd_reserve_14" value="<!--# echo dhcpd_reserve_14 -->">
	   <input type="hidden" id="dhcpd_reserve_15" name="dhcpd_reserve_15" value="<!--# echo dhcpd_reserve_15 -->">
	   <input type="hidden" id="dhcpd_reserve_16" name="dhcpd_reserve_16" value="<!--# echo dhcpd_reserve_16 -->">				
	   <input type="hidden" id="dhcpd_reserve_17" name="dhcpd_reserve_17" value="<!--# echo dhcpd_reserve_17 -->">
	   <input type="hidden" id="dhcpd_reserve_18" name="dhcpd_reserve_18" value="<!--# echo dhcpd_reserve_18 -->">	
	   <input type="hidden" id="dhcpd_reserve_19" name="dhcpd_reserve_19" value="<!--# echo dhcpd_reserve_19 -->">
	   <input type="hidden" id="dhcpd_reserve_20" name="dhcpd_reserve_20" value="<!--# echo dhcpd_reserve_20 -->">
	   <input type="hidden" id="dhcpd_reserve_21" name="dhcpd_reserve_21" value="<!--# echo dhcpd_reserve_21 -->">				
	   <input type="hidden" id="dhcpd_reserve_22" name="dhcpd_reserve_22" value="<!--# echo dhcpd_reserve_22 -->">
	   <input type="hidden" id="dhcpd_reserve_23" name="dhcpd_reserve_23" value="<!--# echo dhcpd_reserve_23 -->">	
	   <input type="hidden" id="dhcpd_reserve_24" name="dhcpd_reserve_24" value="<!--# echo dhcpd_reserve_24 -->">	
	   <input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<!--# echo wan_current_ipaddr_00 -->">
	   <input type="hidden" id="multi_ssid_lan1" name="multi_ssid_lan1" value="<!--# echo multi_ssid_lan1 -->">
	   <input type="hidden" id="multi_ssid_lan2" name="multi_ssid_lan2" value="<!--# echo multi_ssid_lan2 -->">
	   <input type="hidden" id="multi_ssid_lan3" name="multi_ssid_lan3" value="<!--# echo multi_ssid_lan3 -->">
	   <input type="hidden" id="gzone_ipaddr" name="gzone_ipaddr" value="<!--# echo gzone_ipaddr -->">
	   <input type="hidden" id="gzone_netmask" name="gzone_netmask" value="<!--# echo gzone_netmask -->">
	   <input type="hidden" id="change_lan_ip" name="change_lan_ip" value="<!--# echo change_lan_ip -->">
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
				  <div id="box_header"> 
						<h1><script>show_words(bln_title);</script></h1>
				   		<script>show_words(ns_intro_);</script>
						<br><br>
                        <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2" type="reset" class=button_submit value="" onclick="return page_cancel('form1', 'lan.asp');">
						<script>check_reboot();</script>
							<script>get_by_id("button").value = _savesettings;</script>
							<script>get_by_id("button2").value = _dontsavesettings;</script>
		          </div>
				  <div class="box"> 
						<h2><script>show_words(bln_title_Rtrset);</script></h2>
							<p><script>show_words(YM97);</script></p>
                            <table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple"><script>show_words(_ripaddr);</script> :</td>
								  	<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_ipaddr" type="text" id="lan_ipaddr" size="20" maxlength="15" onChange="excute_dynamic_change()" value='<!--# echo lan_ipaddr -->'></td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(_subnet);</script> :</td>
									<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_netmask" type="text" id="lan_netmask" size="20" maxlength="15" value="<!--# echo lan_netmask -->" onChange="check_dhcp_range()"></td>
								</tr>
								<tr>
									<td class="duple"><script>show_words(DEVICE_NAME);</script> :</td>
									<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_device_name" type="text" id="lan_device_name" size="20" maxlength="15" value='<!--# echo lan_device_name -->'></td>
								</tr>
								<tr>
                                  <td class="duple"><script>show_words(_262);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;
                                  <input name="dhcpd_domain_name" type="text" id="dhcpd_domain_name" size="40" maxlength="30" value="<!--# echo dhcpd_domain_name -->"></td>
							  	</tr>
								<tr>
									<td class="duple"><script>show_words(bln_EnDNSRelay);</script> :</td>
									<td width="340">&nbsp;
									<input name="DNSrelay" type=checkbox id="DNSrelay" value="1">
									<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
									</td>
								</tr>														
						<tr style="display:none">
							<td class="duple"><script>show_words(bln_EnDHCPRelay);</script> :</td>
							<td width="340">&nbsp;
								<input name="DHCPrelay" type=checkbox id="DHCPrelay" onClick="dhcp_relay_onClick();">
								<input name="dhcp_relay" type=hidden id="dhcp_relay" value="<!--# echo dhcp_relay -->">
							</td>
						</tr>
						<tr id="dhcp_relay_input" style="display:none">
							<td class="duple"><script>show_words(bln_DHCPRelay_IP);</script> :</td>
							<td width="340">&nbsp;&nbsp;
								<input name="dhcp_relay_ip" id="dhcp_relay_ip" type="text" size=20 maxlenght=15 value="<!--# echo dhcp_relay_ip -->">
							</td>
						<tr>
					  </table>
				  </div>
				  <div class="box"> 
						<h2><script>show_words(bd_title_DHCPSSt);</script></h2>
							<p><script>show_words(bd_intro_);</script></p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td class="duple"><script>show_words(bd_EDSv);</script> :</td>
								  <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<!--# echo dhcpd_enable -->">
                                  <td width="340">&nbsp;<input name="dhcpsvr" type=checkbox id="dhcpsvr" onClick="disable_ip()" value="1"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_DIPAR);</script> :</td>
                                  <td width="340">&nbsp;
									<input type="text" id="dhcpd_start" name="dhcpd_start" value="<!--# echo dhcpd_start -->" size="20" maxlength="15">
								    &nbsp;<script>show_words( _to);</script>
									<input type="text" id="dhcpd_end" name="dhcpd_end" value="<!--# echo dhcpd_end -->" size="20" maxlength="15">
       						      </td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_DLT);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_lease_time" name="dhcpd_lease_time" size="6" maxlength="6" value="<!--# echo dhcpd_lease_time -->">&nbsp;&nbsp;<script>show_words(_minutes);</script></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_DAB);</script> :</td>
								  <input type="hidden" id="dhcpd_always_bcast" name="dhcpd_always_bcast" value="<!--# echo dhcpd_always_bcast -->">
                                  <td width="340">&nbsp;<input name="always_broadcast" type=checkbox id="always_broadcast" value="1"> <script>show_words(bd_DAB_note);</script></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_NETBIOS_ENABLE);</script> :</td>
								  <input type="hidden" id="dhcpd_netbios_enable" name="dhcpd_netbios_enable" value="<!--# echo dhcpd_netbios_enable -->">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_announcement" name="netbios_announcement" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_NETBIOS_LEARN_FROM_WAN_ENABLE);</script> :</td>
				  <input type="hidden" id="dhcpd_netbios_learn" name="dhcpd_netbios_learn" value="<!--# echo dhcpd_netbios_learn -->">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_learn" name="netbios_learn" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_NETBIOS_SCOPE);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_static_scope"  name="dhcpd_static_scope" maxlength="30" onChange="check_netbios()" value="<!--# echo dhcpd_static_scope -->"> <script>show_words(_optional);</script></td>
                                </tr>
                                <tr>
                                  <td class="duple" valign="top"><script>show_words(bd_NETBIOS_REG_TYPE);</script> :</td>
								  <input type="hidden" id="dhcpd_static_node_type" name="dhcpd_static_node_type" value="<!--# echo dhcpd_static_node_type -->">
                                  <td width="340">
								  &nbsp;<input type="radio" name="netbios_node" value="1" onClick="chk_netbios()"><script>show_words(bd_NETBIOS_REG_TYPE_B);</script><br>
								  &nbsp;<input type="radio" name="netbios_node" value="2" onClick="chk_netbios()"><script>show_words(bd_NETBIOS_REG_TYPE_P);</script><br>
								  &nbsp;<input type="radio" name="netbios_node" value="4" onClick="chk_netbios()"><script>show_words(bd_NETBIOS_REG_TYPE_M);</script><br>
								  &nbsp;<input type="radio" name="netbios_node" value="8" onClick="chk_netbios()"><script>show_words(bd_NETBIOS_REG_TYPE_H);</script>
								  </td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_NETBIOS_PRI_WINS);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip1"  name="wins_ip1" size="20" maxlength="15"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_NETBIOS_SEC_WINS);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip2"  name="wins_ip2" size="20" maxlength="15">
				  <input type="hidden" id="dhcpd_static_wins_server" name="dhcpd_static_wins_server" value="<!--# echo dhcpd_static_wins_server -->">
								  </td>
                                </tr>
                    </table>
				  </div>
				  <div class="box" id="add_reserved"> 
				<h2><script>show_words(_add + " ");</script><script>show_words(bd_title_SDC);</script></h2>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td class="duple"><script>show_words(_enable);</script> :</td>
                                  <td width="340">&nbsp;<input type=checkbox id="reserved_enable" name="reserved_enable"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(bd_CName);</script> :</td>
                                  <td width="340">&nbsp;
								  	<input type=text id="reserved_name" name="reserved_name" size="20" maxlength="32">
									&lt;&lt;
									<select id="reserved_list" name="reserved_list" onChange="set_reserved()">
										<option value=-1><script>show_words(bd_CName);</script></option>
										<script>
										set_mac_list("name");
										</script>
									</select>
								  </td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(_ipaddr);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_ip" name="reserved_ip" size="20" maxlength="15"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(_macaddr);</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_mac" name="reserved_mac" size="20" maxlength="17"></td>
                                </tr>
								<tr>
									<td class="duple">&nbsp;</td>
									<td width="340">&nbsp;
									<input type="button" id="clone" name="clone" value="" onClick="clone_mac_action()">
										<script>get_by_id("clone").value = _clone;</script>
									</td>
								</tr>
								<tr>
									<td class="duple">&nbsp;</td>
									<td width="340">&nbsp;
									<input type="button" id="save" name="save" value="Save" onClick="save_reserved();">&nbsp;&nbsp;
									<input type="button" id="clear" name="clear" value="Clear" onClick="clear_reserved();">
										<script>get_by_id("save").value = _add;</script>
										<script>get_by_id("clear").value = _clear;</script>
									</td>
								</tr>
                          </table>
				  </div>
			<div class=box id="reservation_list">
	                  <h2><script>show_words(bd_title_list);</script></h2>
			  <span id="show_reserved_list"></span>
	                  <!--table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
	                      <tr>
	                        <td><script>show_words(_enable);</script></td>
	                        <td><script>show_words(_hostname);</script></td>
	                        <td><script>show_words(_macaddr);</script></td>
	                        <td><script>show_words(_ipaddr);</script></td>
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
								document.write("<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td>");
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a></center></td>");
								}
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a></center></td></tr>");
								}
							}
						</script>
	                  </table-->
				  </div>
				  <div class=box id="dhcpd_list">
	                  <h2><script>show_words(bd_title_clients);</script> : <span id="dhcp_num"></span></h2>
	                  <table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
	                      <tr>
	                        <td><script>show_words(_macaddr);</script></td>
	                        <td><script>show_words(LS423);</script></td>
	                        <td><script>show_words(LS424);</script></td>
	                        <td><script>show_words(LS425);</script></td>
	                        <td></td>
	                        <td></td>
	                      </tr>
	                    <script>
							set_lan_dhcp_list();
							for(i=0;i<DHCPL_DataArray.length;i++){
								document.write("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].Name +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td>");
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href='javascript:revoke(" + i + ")'>" + bd_Revoke + "</a></center></td>");
								}
								if(login_who== "user"){
									document.write("<td></td>");
								}else{
									document.write("<td><center><a href='javascript:edit_dhcp_client(" + i + ")'>" + bd_Reserve + "</a></center></td></tr>");
								}
							}
						</script>
	                  </table>
				  </div>
			</div>
			</td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                         <p><script>show_words(TA7);</script></p>
                         <p><script>show_words(TA8);</script></p>
						 <p class="more"><a href="support_internet.asp#Network" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
					  </td>
                    </tr>
			  </table></td>
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
	reboot_needed(left["Setup"].link[2]);
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
