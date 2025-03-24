<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script type="text/JavaScript" src="/jquery-1.6.1.min.js"></script>
<script type="text/Javascript" src="/jquery-DOMWindow.js"></script>
<style>
.treeTable {
  margin: 0;
  padding: 0;
  border: 0px;
  vertical-align: top;
  z-index: 1;
}

#ltable{
  width: 100%;
  background-color: #FFFFFF;
  border: 0px solid #2F4F4F;
  padding: 0 0 0 0;
  margin: 0 0 0 0;
}

.selected {
  background-color: #3875d7;
  color: #fff;
}

#loading{
	position: relative;
	margin: 0px auto; /* firefox */
	margin: 0px auto !important; /* IE7 */
	_margin: 0px auto; /* IE6 */
	width:500px;
	height:20px;
	background:#ffffff;
}
#loading div{
	width:4px;
	height:20px;
	background:#ff6600;
}
</style>
</head>
<script language="Javascript">

	var page_index = 0;
	// define for select folder
	var submit_button_flag = 0;
	var device_link = "";
	var totalID=0;
	var user_list = new Array();
	var access_list = new Array();
	var treeTable = new Array();
	var bar_timer;
	var count=1;
	var ddns_fail = 0;
	var storage_account_tmp = "";
	var storage_access_tmp = "";

	function onPageLoad() {
		var salt = "<!--# echo login_salt -->";
		var login_who= checksessionStorage();
		
		get_by_id("loading").style.display="none";
		
		disable_all_btn(false);	

		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		} 

		if (get_by_id("asp_temp_02").value == "") {
			storage_account_tmp = "<!--# echo storage_account -->";
			storage_access_tmp = "<!--# echo storage_access -->";
                        storage_access_tmp = storage_access_tmp.replace(/\r/g, "\\r"); 
		} else {
			storage_account_tmp = get_by_id("asp_temp_02").value;
			storage_access_tmp = get_by_id("asp_temp_03").value;
		}

		get_user_list();
		show_account();
		get_access_list();
		show_access();

		if (get_by_id("asp_temp_01").value != "") {
			//copy value
			get_by_id("username").value = "<!--# echo asp_temp_04 -->";
			get_by_id("user_pw").value = "<!--# echo asp_temp_05 -->";
			get_by_id("verify_pw").value = "<!--# echo asp_temp_05 -->";
			get_by_id("show_acc_name").innerHTML = "<!--# echo asp_temp_04 -->";
			get_by_id("show_acc_pd").innerHTML = "<!--# echo asp_temp_05 -->";
				
			get_by_id("ddns_type").value = "<!--# echo ddns_type -->";
			get_by_id("ddns_hostname").value = "<!--# echo ddns_hostname -->";
			get_by_id("ddns_username").value = "<!--# echo ddns_username -->";
			get_by_id("ddns_password").value = "<!--# echo ddns_password -->";
		}

		if (get_by_id("asp_temp_01").value == 1) {
			get_by_id("sp_wz_1").style.display="none";
			get_by_id("loading_bar").style.display = "";
			get_by_id("loading").style.display = "";
			get_by_id("prev_b").style.display = "";
			get_by_id("next_b2").style.display = "";
			get_by_id("cancel_b").style.display = "";
			get_by_id("next_b2").disabled = true;
			get_by_id("prev_b").disabled = true;
			check_ddns();
			page_index = 4;
		} else if (get_by_id("asp_temp_01").value == 2) {
			disable_all_page();
			get_by_id("next_b2").disabled = false;
			get_by_id("prev_b").disabled = false;
			var ddns_ip_check = "<!--# exec cgi /bin/get_ddns_status ddns_ip_check -->";
			page_index = 4;
			if (ddns_ip_check == 1)
				next_page();
			else {
				get_by_id("ddns_detect_fail").style.display = "";
				get_by_id("prev_b").style.display = "";
				get_by_id("cancel_b").style.display = "";
				ddns_fail = 1;
				page_index = 4;
			}
		} else {
			get_by_id("asp_temp_06").value = "<!--# echo ddns_enable -->";
			get_by_id("asp_temp_07").value = "<!--# echo ddns_type -->";
			get_by_id("asp_temp_08").value = "<!--# echo ddns_hostname -->";
			get_by_id("asp_temp_09").value = "<!--# echo ddns_username -->";
			get_by_id("asp_temp_10").value = "<!--# echo ddns_password -->";
		}
	}
	
	function check_ddns(){
		if (count == 11) {          
			clearTimeout(bar_timer);
			get_by_id("asp_temp_01").value = 2;
			get_by_id("ddns_wizard_check").value = 0;
			send_submit("form3");
			count=0;
			return;
		}

		_width = 50 * count + "px";
		$("#loading div").animate({
		width:_width
		});
		count++;
		bar_timer = setTimeout('check_ddns()',500);
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
	
	function enable_remote_chk(){
//		get_by_id("file_access_remote_port").disabled = !get_by_id("EnableRemote").checked;
		show_link();
	}

	function enable_https_chk(){
//		get_by_id("file_access_ssl_port").disabled = !get_by_id("EnableHttps").checked;
		show_link();
	}
	
	function get_user_list(){
		if (storage_account_tmp == "" && get_by_id("asp_temp_02").value == "") {
			user_list = new Array();
			return;
		} else if (get_by_id("asp_temp_02").value != "")
			user_list = get_by_id("asp_temp_02").value.split("|");
		else
			user_list = storage_account_tmp.split("|");

		for(var i = 0; i < user_list.length; i++)
			user_list[i] = user_list[i].split("/");
	}

	function show_account(){
		var account_list = "<select id=\"username_sel\" onchange=\"show_account_info(this);\">";
		account_list += "<option value=\"0\" selected=\"selected\">" + _username + "</option>";
		for(var i = 0; i < user_list.length; i++)
			account_list += "<option value=\"" + (i + 1) + "\">" + user_list[i][0] + "</option>";
		account_list += "</select>";
		get_by_id("show_user").innerHTML = get_by_id("username").value;
		
	}

	function show_account_info(obj){
		if (obj.selectedIndex == 0) {
			get_by_id("username").value = "";
			get_by_id("user_pw").value = "";
			get_by_id("verify_pw").value = "";
			get_by_id("del_user").disabled = true;
		} else {
			get_by_id("username").value = user_list[obj.selectedIndex - 1][0];
			get_by_id("user_pw").value = user_list[obj.selectedIndex - 1][1];
			get_by_id("verify_pw").value = user_list[obj.selectedIndex - 1][1];
			get_by_id("del_user").disabled = false;
		}
	}

	function merge_user_list(){
		var list_tmp = "";
		for (var i = 0; i < user_list.length; i++){
			if(user_list[i] == "")
				continue;
			else if(i > 0 && list_tmp != "")
				list_tmp += "|";

			list_tmp += user_list[i][0] + "/" + user_list[i][1];
		}
		storage_account_tmp = list_tmp;
		get_by_id("asp_temp_02").value = list_tmp;
	}

	function set_user_list(){
//		var i = get_by_id("username_sel").value;
		var i=0;
		var username = get_by_id("username").value;
		var password = get_by_id("user_pw").value;
		if(i == 0 && user_list.length >= 8){
			alert(STORAGE_max_account);
			return false;
		}

		if (username == ""){
			alert(FMT_INVALID_USERNAME);
			return false;
		}
		for (var k = 0; k < username.length; k++){
			if (!check_name_key_fun(username.substring(k, k+1))) {
				alert(_username + " " + check_name_invalid);
				return false;
			}
		}
		if (Find_word(username,"\\") || Find_word(username,"|")){
			alert(_username + " " + check_name_invalid);
			return false;
		}
		
		if (username.toLowerCase() == "admin" || username.toLowerCase() == "guest") {
			alert(_duplicate_user);
			return false;
		}

		var list_len = user_list.length;
		for (var j = 0; j < list_len; j++ ) {
			if (i > 0){
				if (username.toLowerCase() == "admin" || username.toLowerCase() == "guest"){
					alert(_duplicate_user);
					return false;
				}

			} else {
				if (user_list[j][0].toLowerCase() == username.toLowerCase() || username.toLowerCase() == "admin" || username.toLowerCase() == "guest") {
					alert(_duplicate_user);
					return false;
				}
			}
		}

		if (password == "" ||  get_by_id("verify_pw").value == ""){
			alert(INVALID_PASSWORD);
			return false;
		} else if (password != get_by_id("verify_pw").value){
			alert(_pwsame);
			return false;
		}
		for (k = 0; k < password.length; k++){
			if (!check_name_key_fun(password.substring(k, k+1))){
				alert(_password + " " + check_name_invalid);
				return false;
			}
		}
		if (Find_word(password,"\\") || Find_word(password,"|")){
			alert(_password + " " + check_name_invalid);
			return false
		}


//		var i = get_by_id("username_sel").value;
		if(i == 0) {
			var list_tmp = [username, password];
			user_list.push(list_tmp);
			var access_tmp = new Array();
			access_tmp[0] = "none";
			access_list.push(access_tmp);
			merge_access_list();
			get_access_list();
			show_access();
		} else {
			user_list[i - 1][0] = username;
			user_list[i - 1][1] = password;
		}

//		show_account();
		merge_user_list();
//		show_access();
		return true;
	}

	function get_access_list(){

		if (get_by_id("asp_temp_03").value == "")
			access_list = storage_access_tmp.split("|");
		else
			access_list = get_by_id("asp_temp_03").value.split("|");

		for (var i = 0; i < access_list.length; i++) {
			access_list[i] = access_list[i].split("/");
			for (var j = 0; j < access_list[i].length; j++) {
				var access_tmp = access_list[i][j].split("\\");
				access_list[i][j] = access_tmp;
			}
		}
	}

	function show_access(){
		var access_tmp = "";

		for (var i = 0; i < access_list.length; i++) {
			var num = 2 + i;
			for (var j = 0; j < access_list[i].length; j++) {
				var path_num = 1 + j;
				if (access_list[i][j] == "none")
					access_tmp = _none;
				else 
					access_tmp = decodeURIComponent(access_list[i][j][0]);
			}
		}
		get_by_id("show_select_folder").value = access_tmp;
	}

	function add_a_path() {
		var user_list = storage_account_tmp.split("|");
		edit_append(user_list.length, 0);
	}
	
	function del_user_list(){
		var tmp_str = storage_account_tmp.split("|");
		var i = tmp_str.length;
		user_list[i - 1] = "";
		access_list[i] = "";

		merge_user_list();
		merge_access_list();
		get_user_list();
//		show_account();
		get_access_list();
//		show_access();
	}
	
	function edit_append(i, j){
		if (i == null)
			return false;

		$.openDOMWindow({ 
			modal:1,
			overlay:1,
			height:220, 
			width:535, 	
			windowSourceID:'#show_box'
		}); 

		get_by_id("append").style.display = "";
		get_by_id("tree").style.display = "none";
		
		get_by_id("j_show_append_new").innerHTML = STORAGE_append_folder;
		get_by_id("j_show_username").innerHTML = _username;

		get_by_id("append_username").value = get_by_id("username").value;

		get_by_id("j_show_folder").innerHTML = _folder;
		var browse_tmp = "<input type=\"button\" id=\"Browse\" name=\"Browse\" value=\"Browse\"";
		browse_tmp += " onClick=\"call_show_tree("+i+", "+j+");\">";
		get_by_id("show_browse").innerHTML = browse_tmp;
		if (j == "9")
			get_by_id("append_folder").value = "/";
		else if (access_list[i][j] == "none")
			get_by_id("append_folder").value = _none;
		else
			get_by_id("append_folder").value = decodeURIComponent(access_list[i][j][0]);
		get_by_id("j_show_permission").innerHTML = STORAGE_permission;
		var select_tmp = "<select id=\"permission_sel\" disabled><option value=\"1\">" + STORAGE_rw + "</option>";
		get_by_id("show_permission_sel").innerHTML = select_tmp;
		get_by_id("permission_sel").value = 1;
		var append_tmp = "<input type=\"hidden\" id=\"new_append\" name=\"new_append\" value=\"" + STORAGE_append + "\"";
		append_tmp += " onClick=\"save_and_append_new("+i+", "+j+");\">";
		get_by_id("show_append_btn").innerHTML = append_tmp;
		if(access_list[i][j] == "none"){ //if edit the first access path
			get_by_id("new_append").disabled = true;
		}else{
			get_by_id("new_append").disabled = false;
		}
		var ok_tmp = "<input type=\"submit\" id=\"OK\" name=\"OK\" value=\"&nbsp;" + _ok + "&nbsp;\"";
		ok_tmp += " onClick=\"save_append("+i+", "+j+");\">";
		get_by_id("show_ok_btn").innerHTML = ok_tmp;
	}

	function call_show_tree(i, j){
		var title = '<div style=float:right><input type="button" id="new_append" name="new_append" value="' + _cancel + '"';
		title += ' onClick=call_show_append("");></div>';
		title += '<h2>' + STORAGE_select_folder + '</h2>';
		get_by_id("j_show_select_folder").innerHTML = title;
		treeTable = new Array();
		$.ajax({
       			type: "GET",
			url: "file_tree.js?left=/&0=0",
			dataType: "script",
			cache: false,
			complete: function(xml) {
				var tmp = eval(xml.responseText);
				if (typeof(tmp) === "undefined") {
					return;
				}
				var tbody = "";
				tbody += '<tr id="0">';
				tbody += '<td><span class="collapse" style="padding-left:19px;margin-left:-19px;">';
				tbody += '<img src="expand.png" /></span>';
				tbody += '<a onClick=call_show_append("/");><img src="directory.png"/>&nbsp;/&nbsp;</a>';
				tbody += '</td></tr>';
				var len = tmp.length;
				if (len < 2) {
					tbody += '<tr id="1">';
					tbody += '<td>';
					tbody += '<span class="expand" style="padding-left:39px;margin-left:-19px;">';
					tbody += '<img src="warning.png" /></span></a>';
					tbody += '<span>None USB Storage Insert.</span></a>';
					tbody += '</td></tr>';
					$("#ltable>tbody").append(tbody);
				}

				/* Add tbody content */
				for (var i = 0; i < len-1; i++) {
					var element = tmp[i]['id'] + "/" + tmp[i]['path'] + "/" + tmp[i]['name']+ "/" + tmp[i]['child'];
					var cnode = tmp[i]['id'].split("-");
					var c = cnode[1], f = cnode[0];
					tbody += '<tr id="' + f + '">';
					tbody += '<td>';
					if(tmp[i]['child'] == "1") {
						tbody += '<a onClick="expander('+f+');" >';
						tbody += '<span class="expand" style="padding-left:39px;margin-left:-19px">';
						tbody += '<img src="collapse.png" /></span></a>';
					}else {
						tbody += '<a onClick="expander('+c+');" style="text-decoration:none;">';
						tbody += '<span style="padding-left:51px;margin-left:-19px;">&nbsp;';
						tbody += '</span></a>';
					}

					tbody += '<a onClick=call_show_append("'+tmp[i]['path']+'");>';
					tbody += '<img src="directory.png" /><span>' + tmp[i]['name'] + '</span></a>';
					tbody += '</td></tr>';
					treeTable.push(element);
					totalID++;
				}
				$("#ltable>tbody").empty();
				$("#ltable>tbody").append(tbody);

				get_by_id("append").style.display = "none";
				get_by_id("tree").style.display = "";
			}	
		});
	}

	function getFolder(id)
	{
		var path = "";
		for (var i = 0; i < treeTable.length; i++)
		{
		        var tmp = treeTable[i].split("/");
		        var t = tmp[0].split("-");
		        if (t[t.length-1] == id) {
		                path = tmp[1];
		                break;
		        }
		}

		$.ajax({
		        type: "GET",
		        url: "file_tree.js?left="+path+"&"+id+"="+totalID,
		        dataType: "script",
		        cache: false,
		        complete: function(xml) {
		                var tmp = eval(xml.responseText);
		                if (typeof tmp === "undefined")
		                        return;
		                var len = tmp.length;
		                if (len < 2) 
		                        return;

		                var space = ($("#"+id).find('span').eq(0).attr('style')).split(";");
		                var padding = "", margin = "", new_space = "";

		                if (space.length >= 2) {
		                        padding = (space[0].split(":"))[1].split("px");
		                        if (space[1] !== "")
		                                margin = (space[1].split(":"))[1].split("px");
		                }else {
		                        padding = (space[0].split(":"))[1].split("px");
		                }

		                if (margin[0] != "") {
		                        new_space = parseInt(padding[0]) + parseInt(margin[0]) + 30;
		                } else {
		                        new_space = parseInt(padding[0]) + 30;
		                }
		                
		                /* Remove nodes that already exists and rebuild the tree . */
		                var pattern = "child-of-"+id;
		                var newbody = "";
		                $('#ltable>tbody tr').each(function(i){
		                        var t = $(this).html();
		                        var patt = new RegExp(pattern);
		                        var nid = $(this).attr('id');
		                        if (!patt.test(t)){
		                                newbody += '<tr id="'+ nid + '">' + $(this).html() + '</tr>';
		                        }
		                });
		                $("#ltable>tbody").empty();
		                $("#ltable>tbody").append(newbody);

		                /* Add tbody content */
		                var tbody = "";
		                for (var i = 0; i < len-1; i++) {
		                        var cnode = tmp[i]['id'].split("-");
		                        var c = cnode[1], f = cnode[0];
		                        tbody += '<tr id="' + c + '">';
		                        tbody += '<td class="child-of-'+ f +'">';
		                        if (tmp[i]['child'] == "1") {
		                                tbody += '<a onClick="expander('+c+');" style="text-decoration:none;">';
		                                tbody += '<span class="expand" style="padding-left:'+new_space+'px;margin-left:-19px;">&nbsp;';
		                                tbody += '<img src="collapse.png"/></span></a>';
		                        }else {
		                                tbody += '<a onClick="expander('+c+');" style="text-decoration:none;">';
		                                tbody += '<span style="padding-left:'+ ( new_space+ 16 )+'px;margin-left:-19px;">&nbsp;';
		                                tbody += '</span></a>';
		                        }
		                        tbody += '<a onClick=call_show_append("'+tmp[i]['path']+'");>';
		                        tbody += '<img src="directory.png"/><span>' + tmp[i]['name'] + '</span></a>';
		                        tbody += '</td></tr>';
		                        totalID++;
		                        var flag = 1, index = 0;
		                        for (var  j = 0; j < treeTable.length; j++) {
		                                var odata = treeTable[j];
		                                var opath = (odata.split("/"))[1];
		                                if (opath == tmp[i]['path']) {
		                                        flag = 0; index = j;
		                                }
		                        }
		                        var element = tmp[i]['id'] + "/" + tmp[i]['path'] + "/" + tmp[i]['name']+ "/" + tmp[i]['child'];
		                        if (flag)
		                                treeTable.push(element);
		                        else {
		                                if (index != 0)
		                                        treeTable[index] = element;
		                        }
		                }
		                $(tbody).insertAfter($("#"+id));
		                $("#ltable>tbody>tr").each(function(i){
		                        if($(this).find('span').eq(1).hasClass("selected")){
		                                $(this).find('span').eq(1).removeClass("selected");
		                        }
		                });
		                $("#"+id).find('span').eq(1).addClass("selected");
		        }
		});
	}

	function expander(id, path)
	{
		if(($("#"+id).find('span').hasClass('expand') == false && $("#"+id).find('span').hasClass("collapse") == false)) {
		        return;
		}

		if ($("#"+id).find('span').hasClass('expand')) {
		        $("#"+id).find('span').removeClass('expand').addClass('collapse');
		        $("#"+id+">td>a>span>img").attr('src', 'expand.png');
		        getFolder(id);
		}else{
		        $("#"+id).find('span').removeClass('collapse').addClass('expand');
		        $("#"+id+">td>a>span>img").attr('src', 'collapse.png');
		        var pattern = "child-of-"+id;
		        var newbody = "";
		        var tmp = new Array();
		        $('#ltable>tbody tr').each(function(i){
		                var t = $(this).html();
		                var patt = new RegExp(pattern);
		                var nid = $(this).attr('id');

		                /* Be sure to remove the nodes that has still child nodes */
		                if (tmp.length != 0) {
		                        var cflag = 0;
		                        for(var i = 0; i < tmp.length; i++) {
		                                var newpattern = 'child-of-'+tmp[i];
		                                var newpatt = new RegExp(newpattern);
		                                if (newpatt.test(t)) {
		                                        cflag = 1;
		                                        break;
		                                }
		                        }
		                        if (cflag) {
		                                tmp.push(nid);
		                                return;
		                        }
		                }

		                if (!patt.test(t)){
		                        newbody += '<tr id="'+ nid + '">' + $(this).html() + '</tr>';
		                }else {
		                        tmp.push(nid);
		                }
		        });
		        $("#ltable>tbody").empty();
		        $("#ltable>tbody").append(newbody);
		        
		        $("#ltable>tbody>tr").each(function(i){
		                if($(this).find('span').eq(1).hasClass("selected")){
		                        $(this).find('span').eq(1).removeClass("selected");
		                }
		        });
		        $("#"+id).find('span').eq(1).addClass("selected");
		}
	}

	function call_show_append(path){
		if (path != ""){
			get_by_id("append_folder").value = decodeURIComponent(path);
		}
		get_by_id("append").style.display = "";
		get_by_id("tree").style.display = "none";
	}

	function save_append(i, j){
		if (i == null){
			return false;
		}	
		
		if(get_by_id("append_folder").value != _none){
			for (var k=0; k < access_list[i].length; k++){
				if (k == j){
					continue;
				}
			
				if (access_list[i][k][0] == encodeURIComponent(get_by_id("append_folder").value)){
					alert(STORAGE_exist);
					return false;
				}				
			}
			
			access_list[i][j][0] = encodeURIComponent(get_by_id("append_folder").value);
			access_list[i][j][1] = "rw";
		}
		
		$.closeDOMWindow({ 
			windowSourceID: '#show_box'
		});
		
		show_access();
		merge_access_list();
	}

	function save_and_append_new(i, j){
		if (i == null)
			return false;

		if (i == 0 && access_list[i].length >= 5) { //the maximum path is 5
			alert(STORAGE_account_paths_max);
			return false;
		} else {
			for (var k=0; k < access_list[i].length; k++){
				if (access_list[i][k][0] == encodeURIComponent(get_by_id("append_folder").value)){
					alert(STORAGE_exist);
					return false;
				}				
			}
			
			var access_tmp = new Array();
			access_tmp[0] = encodeURIComponent(get_by_id("append_folder").value);
			access_tmp[1] = (get_by_id("permission_sel").value == 0) ? "ro" : "rw";
			access_list[i].push(access_tmp);

			get_by_id("append_folder").value = "/";
		}
		
		$.closeDOMWindow({
			windowSourceID: '#show_box'
		});
		
		show_access();
		merge_access_list();
	}

	function merge_access_list(){
		var access_tmp = "";
		for (var i = 0; i < access_list.length; i++){
			if(access_list[i] == "")
				continue;
			else if(i > 0 && access_tmp != "")
				access_tmp += "|";

			for (var j = 0; j < access_list[i].length; j++){
				if (access_list[i][j] == "none")
					access_tmp += "none";
				else
					access_tmp += access_list[i][j][0] + "\\" + access_list[i][j][1];
				if ((access_list[i].length != 1) && (j != (access_list[i].length - 1)))
					access_tmp += "/";
			}
		}

		storage_access_tmp = access_tmp;
		get_by_id("asp_temp_03").value = access_tmp;
	}

	function show_link(){
		var ddns_enable = "<!--# echo ddns_enable -->";
		var ddns_hostname = "<!--# echo ddns_hostname -->";
		var access_enable = (get_by_id("EnableWeb").checked) ? 1 : 0;
		var remote_enable = (get_by_id("EnableRemote").checked) ? 1 : 0;
		var remote_port = get_by_id("file_access_remote_port").value;
		var ssl_enable = (get_by_id("EnableHttps").checked) ? 1 : 0;
		var ssl_port = get_by_id("file_access_ssl_port").value;
		var lan_ip = "<!--# exec cgi /bin/file_access wan_ip -->";
		var href = "";
		var link = "";
		var port = "";
		var dev_link = "";
		var link_query = "";
		var remote_port_msg = replace_msg(check_num_msg, STORAGE_http_port, 1, 65535);
		var ssl_port_msg = replace_msg(check_num_msg, STORAGE_https_port, 1, 65535);
		var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
		var ssl_port_obj = new varible_obj(ssl_port, ssl_port_msg, 1, 65535, false);

		if (access_enable != 1)
			;
		else {
			if (!check_varible(remote_port_obj)){
				return false;
			}
			if (!check_varible(ssl_port_obj)){
				return false;
			}

			if (ddns_enable == 1) {
				link = ddns_hostname;
			} else {
				link = lan_ip;
			}
			
			device_link = "";
			dev_link = "<table width=\"500\"><tr><td>";
			if (remote_enable == 1 && ssl_port.length != 0) {
				href = "https";
				port = ssl_port;
				dev_link += "<p><a href=\"" + href + "://" + link + ":" + port + "/\" target=\"_blank\">";
				dev_link += href + "://" + link + ":" + port + "/</a></p>";
				device_link = "https://" + link + ":" + port + "/";
				link_query = "https=" + encodeURIComponent("https://" + link + ":" + port + "/");
			}
			if (remote_enable == 1 && remote_port.length != 0) {
				href = "http";
				port = remote_port;
				dev_link += "<p><a href=\"" + href + "://" + link + ":" + port + "/\" target=\"_blank\">";
				dev_link += href + "://" + link + ":" + port + "/</a></p>";
				if (device_link == "")
					device_link = "http://" + link + ":" + port + "/";
				if (link_query != "")
					link_query += "&";
				link_query += "http=" + encodeURIComponent("http://" + link + ":" + port + "/");
			}
			if (href != "" && link != "" && port != "") {
				dev_link += "</td><td><input name=\"mailnow\" id=\"mailnow\" type=\"button\"";
				dev_link += "value=\"Email Now\" onClick=pre_send_mail(\"" + link_query + "\");";
				if ("<!--# echo log_email_enable -->" == "0")
					dev_link += " disabled=true";
				dev_link += "><span id=\"mail_msg\"></span></td></tr></table>";
			} else
				dev_link = "";
		}
		get_by_id("show_device_link").innerHTML = dev_link;
	}

	function next_page() {
		var detect_usb = "<!--# exec cgi /bin/file_access usb_count -->";
		var server_name_err = "";
	
		if (page_index == 0) {
			disable_all_page();
			if (detect_usb < 1) {
				get_by_id("no_usb_detect").style.display = "";
				get_by_id("retry_b").style.display = "";
				get_by_id("cancel_b").style.display = "";
				page_index = 0;
			} else {
				get_by_id("sp_wz_2").style.display = "";
				get_by_id("prev_b").style.display = "";
				get_by_id("next_b2").style.display = "";
				get_by_id("cancel_b").style.display = "";
				page_index = 1;
			}
		} else if (page_index == 1) {
			var pd = get_by_id("user_pw").value;
			var pd_ver = get_by_id("verify_pw").value;

			if (get_by_id("username").value == "") {
				alert(FMT_INVALID_USERNAME);
				return false;
			}

			if (pd == "") {
				alert(vpn_ipsec_pwd_empty);
				return false;
			}

			if (pd != pd_ver) {
				alert(_pwsame);
				return false;
			}
			get_by_id("show_acc_name").innerHTML = get_by_id("username").value;
			get_by_id("show_acc_pd").innerHTML = get_by_id("user_pw").value;
			
			if (!set_user_list())
				return false;
				
			disable_all_page();
			get_by_id("sp_wz_3").style.display = "";
			get_by_id("prev_b").style.display = "";
			get_by_id("next_b2").style.display = "";
			get_by_id("cancel_b").style.display = "";
			page_index = 2;
		} else if (page_index == 2) {
			if (get_by_id("show_select_folder").value == _none) {
				alert(shareport_wizard_select_folder);
				return false;
			}	
			disable_all_page();
			get_by_id("sp_wz_4").style.display = "";
			get_by_id("prev_b").style.display = "";
			get_by_id("next_b2").style.display = "";
			get_by_id("cancel_b").style.display = "";
			page_index = 3;
		} else if (page_index == 3) {
			if (get_by_id("ddns_host").value != "") {
				get_by_id("ddns_type").value = "<!--# echo ddns_type -->";
				if (get_by_id("ddns_type").value == "")
					get_by_id("ddns_type").value = "www.dlinkddns.com";

				if (get_by_id("ddns_user").value == "") {
					alert(FMT_INVALID_USERNAME);
					return false;
				} else if (get_by_id("ddns_pass").value == "") {
					alert(vpn_ipsec_pwd_empty);
					return false;
				}
			} else {
				disable_all_page();
				get_by_id("sp_wz_complete").style.display = "";
				get_by_id("prev_b").style.display = "";
				get_by_id("save_b").style.display = "";
				get_by_id("cancel_b").style.display = "";
				page_index = 4;
				return true;
			}
			get_by_id("ddns_hostname").value = get_by_id("ddns_host").value;
			get_by_id("ddns_username").value = get_by_id("ddns_user").value;
			get_by_id("ddns_password").value = get_by_id("ddns_pass").value;
			
			get_by_id("asp_temp_04").value = get_by_id("username").value;
			get_by_id("asp_temp_05").value = get_by_id("user_pw").value;
			
			get_by_id("asp_temp_01").value = 1;
			get_by_id("ddns_wizard_check").value = 1;
			send_submit("form3");
		} else if (page_index == 4) {
			disable_all_page();
			get_by_id("sp_wz_complete").style.display = "";
			
			get_by_id("prev_b").style.display = "";
			get_by_id("save_b").style.display = "";
			get_by_id("cancel_b").style.display = "";
			
			if (get_by_id("ddns_hostname").value != "" && get_by_id("ddns_type").value != "") {
				get_by_id("show_remote").innerHTML = _remote_access + ": ";
				remote_url = "http://" + get_by_id("ddns_hostname").value + ":8181";
				remote_url = "<a href=\"" + remote_url + "\" target=\"_new\">" + remote_url;
				get_by_id("show_remote_url").innerHTML = remote_url;
			}
			get_by_id("show_acc_name").innerHTML = get_by_id("asp_temp_04").value;
			get_by_id("show_acc_pd").innerHTML = get_by_id("asp_temp_05").value;
				
			page_index = 5;
		}

	}
	
	function disable_all_page() {
		//page
		get_by_id("sp_wz_1").style.display = "none";
		get_by_id("sp_wz_2").style.display = "none";
		get_by_id("sp_wz_3").style.display = "none";
		get_by_id("sp_wz_4").style.display = "none";
		get_by_id("loading_bar").style.display = "none";
		get_by_id("no_usb_detect").style.display = "none";
		get_by_id("sp_wz_complete").style.display = "none";
		get_by_id("ddns_detect_fail").style.display = "none";
		//button
		get_by_id("prev_b").style.display = "none";
		get_by_id("next_b2").style.display = "none";
		get_by_id("retry_b").style.display = "none";
		get_by_id("save_b").style.display = "none";
		get_by_id("cancel_b").style.display = "none";
	}

	function prev_page() {
		disable_all_page();
		get_by_id("prev_b").style.display = "";
		get_by_id("next_b2").style.display = "";
		get_by_id("cancel_b").style.display = "";
		if (page_index == 1) {
			get_by_id("sp_wz_1").style.display = "";
			get_by_id("prev_b").style.display = "none";
			page_index = 0;
		} else if (page_index == 2) {
			del_user_list();
			get_by_id("sp_wz_2").style.display = "";
			page_index = 1;
		} else if (page_index == 3) {
			get_by_id("sp_wz_3").style.display = "";
			page_index = 2;
		} else if (page_index == 4) {
			get_by_id("sp_wz_4").style.display = "";
			page_index = 3;
		} else if (page_index == 5) {
			get_by_id("sp_wz_4").style.display = "";
			page_index = 3;
		}
			 

	}

	function show_folder() {
		 $.openDOMWindow({ 
                        modal:1,
                        overlay:1,
                        height:220, 
                        width:535,      
                        windowSourceID:'#show_box'
                }); 
	}

	function send_request() {
		get_by_id("storage_account").value = get_by_id("asp_temp_02").value;
		get_by_id("storage_access").value = get_by_id("asp_temp_03").value;
		disable_all_btn(true);
		send_submit("form1");
	}

	function wz_cancel() {
		if (ddns_fail == 1) {
			ddns_fail = 0;
			get_by_id("ddns_hostname").value = "";
			get_by_id("ddns_password").value = "";
			next_page();
			return;
		}
		if(confirm(_setup_wizard_17)) {
			//restore ddns setting
			get_by_id("asp_temp_11").value = get_by_id("asp_temp_06").value;
			get_by_id("asp_temp_12").value = get_by_id("asp_temp_07").value;
			get_by_id("asp_temp_13").value = get_by_id("asp_temp_08").value;
			get_by_id("asp_temp_14").value = get_by_id("asp_temp_09").value;
			get_by_id("asp_temp_15").value = get_by_id("asp_temp_10").value;
			disable_all_btn(true);
			send_submit("form2");
		}
	}
</script>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
	<tr>
		<td bgcolor="#FFFFFF">
		<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
			<tr>
				<td bgcolor="#FFFFFF">
					<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
						<tr>
							<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
							<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
							<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
							<td>&nbsp;</td>
						</tr>
					</table>
					<img src="/wlan_masthead.gif" width="836" height="92" align="middle">
				</td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF"><p>&nbsp;</p>
		<table width="550" border="0" align="center">
			<tr>
				<td>
				<div class=box>
					<div id=w1>
						<div align="center"></div>
						<form id="form1" name="form1" method="post" action="apply.cgi">
							<input type="hidden" name="html_response_page" id="html_response_page" value="count_down.asp">
							<input type="hidden" name="html_response_message" value="">
							<input type="hidden" name="html_response_return_page" value="http_storage.asp">
							<input type="hidden" name="reboot_type" value="none">
							<input type="hidden" id="action" name="action" value="http_storage">
							<input type="hidden" id="storage_account" name="storage_account" value="<!--# echo storage_account -->"> 
							<input type="hidden" id="storage_access" name="storage_access" value="<!--# echo storage_access -->"> 
		        				<input type="hidden" name="file_access_enable" id="file_access_enable" value="1">
							<input type="hidden" name="file_access_ssl" id="file_access_ssl" value="<!--# echo file_access_ssl -->">
							<input type="hidden" name="file_access_ssl_port" id="file_access_ssl_port" value="4433">
							<input type="hidden" name="file_access_remote" id="file_access_remote" value="1">
							<input type="hidden" name="file_access_remote_port" id="file_access_remote_port" value="8181">
							<!-- sp_wz_01-->
							<div id="sp_wz_1">
								<h2 align="left">&nbsp;</h2>
								<div align="left">
									<center><script>show_words(shareport_wizard_info_1);</script></center>
									<table class=formarea>
										<tr>
											<center><img src="file_access/webfile_images/shareport_usb.png"></center>
										</tr>
									</table>
								</div>
							</div>
							<!-- sp_wz_01 check usb exist-->
							<!-- sp_wz_02 create a account -->
							<div id="sp_wz_2" style="display:none">
								<h2 align="left">&nbsp;</h2>
								<div align="left">
								<center><script>show_words(shareport_wizard_info_2);</script></center>
								<table class=formarea>
								<tr><td class="duple">
								<script>show_words(_account_name + ":");</script>
								</td>
								<td><input type="text" id="username" name="username" maxlength="15" value=""></td></tr>
								<tr><td class="duple">
								<script>show_words(_password + ":");</script>
								</td>
								<td><input type="password" id="user_pw" name="user_pw" maxlength="15" value=""></td></tr>
								<tr><td class="duple">
								<script>show_words(_verifypw + ":");</script>
								</td>
								<td><input type="password" id="verify_pw" name="verify_pw" maxlength="15" value=""></td></tr>
								<br>
									
								</table>
								</div>
							</div>
							<!-- sp_wz_02 -->
							<!-- sp_wz_03 select/create a folder-->
							<div id="sp_wz_3" style="display:none">
								<h2 align="left">&nbsp;</h2>
								<div align="left">
									<center><script>show_words(shareport_wizard_info_3);</script></center>
							<br>
							<span id="show_user"></span>
							<span id="show_user_path"></span>
							<center><input id="show_select_folder" name="show_select_folder" type="text" size="40" value="" disabled>
							<input type="button" id="Browse" name="Browse" value="Browse" onClick="add_a_path()"></div></center>
							<br>
									<table class=formarea>
									</table>
								</div>
							</div>
							<!-- sp_wz_03 -->
							<!-- sp_wz_04 set ddns domain and user/password-->
							<div id="sp_wz_4" style="display:none">
								<h2 align="left">&nbsp;</h2>
								<div align="left">
									<script>show_words(shareport_wizard_info_4);</script> <a href="http://www.DlinkDDNS.com\" target="_blank">www.DlinkDDNS.com</a></br>
									<table class=formarea>
									<tr><td class="duple">
									<script>show_words(_hostname + ":");</script>
									</td>
									<td><input type="text" id="ddns_host" name="ddns_host" value=""></td></tr>
									<tr><td class="duple">
									<script>show_words(shareport_wizard_username + ":");</script>
									</td>
									<td><input type="text" id="ddns_user" name="ddns_user" value=""></td></tr>
									<tr><td class="duple">
									<script>show_words(shareport_wizard_password + ":");</script>
									</td>
									<td><input type="password" id="ddns_pass" name="ddns_pass" value=""></td></tr>
									<br>
									</table>
								</div>
							</div>
							<!-- sp_wz_04 -->
							<!-- loading bar-->
							<div id="loading_bar" style="display:none">
								<h2 align="left"><script>show_words(_process_setting);</script></h2>
								<div align="left">
									<script>show_words(shareport_wizard_wait_check);</script>
									<br>
									<table class=formarea>
									<br>
									<div id="loading"><div></div></div>
									</table>
								</div>
							</div>
							<!-- loading bar -->
							<!-- sp_wz_complete -->
							<div id="sp_wz_complete" style="display:none">
								<h2 align="left">&nbsp;</h2>
								<div align="left">
									<script>show_words(shareport_wizard_info_5);</script>
									<table class=formarea>
									<br>
									<tr><td class="duple">
									<script>show_words(_localaccess + ":");</script>
									</td>
									<td><a href="http://dlinkrouter:8181" target="_new">http://dlinkrouter:8181</a> or <a href="http://dlinkrouter.local:8181" target="_new">http://dlinkrouter.local:8181</a></td></tr>
									<tr><td class="duple">
									<span id="show_remote"></td>
									<td><span id="show_remote_url"></span></td>
									</tr>
									<tr><td class="duple">
									<script>show_words(_account_name + ":");</script>
									</td>
									<td><span id="show_acc_name"></span></td></tr>	
									<tr><td class="duple">
									<script>show_words(_password + ":");</script>
									</td>
									<td><span id="show_acc_pd"></span></td></tr>	
									<br>
									</table>
									<script>show_words(shareport_wizard_info_6);</script>
								</div>
							</div>
							<!-- sp_wz_complete -->
							<!-- no_detect_usb -->
							<div id="no_usb_detect" style="display:none">
								<h2 align="left"><script>show_words(_error);</script></h2>
								<div align="left">
									<center><script>show_words(no_usb_detect);</script></center>
									<table class=formarea>
									</table>
								</div>
							</div>
							<!-- no_detect_usb -->
							<!-- ddns_detect_fail -->
							<div id="ddns_detect_fail" style="display:none">
								<h2 align="left"><script>show_words(_process_setting);</script></h2>
								<div align="left">
									<center><script>show_words(_not_found_ddns);</script></center>
									<table class=formarea>
									</table>
								</div>
							</div>
							<!-- ddns_detect_fail -->
						</form>
						<form id="form2" name="form2" method="post" action="apply_sec.cgi">
							<input type="hidden" id="action" name="action" value="ddns_wizard">
							<input type="hidden" id="html_response_page" name="html_response_page" value="http_storage.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="shareport_wizard.asp">
							<input type="hidden" name="ddns_wizard_cancel" id="ddns_wizard_cancel" value="1">
							<input type="hidden" name="asp_temp_11" id="asp_temp_11" value="<!--# echo asp_temp_11 -->">
							<input type="hidden" name="asp_temp_12" id="asp_temp_12" value="<!--# echo asp_temp_12 -->">
							<input type="hidden" name="asp_temp_13" id="asp_temp_13" value="<!--# echo asp_temp_13 -->">
							<input type="hidden" name="asp_temp_14" id="asp_temp_14" value="<!--# echo asp_temp_14 -->">
							<input type="hidden" name="asp_temp_15" id="asp_temp_15" value="<!--# echo asp_temp_15 -->">
						</form>
						<form id="form3" name="form3" method="post" action="apply.cgi">
							<input type="hidden" id="action" name="action" value="ddns_wizard">
							<input type="hidden" id="html_response_page" name="html_response_page" value="shareport_wizard.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="shareport_wizard.asp">
							<input type="hidden" name="ddns_wizard_check" id="ddns_wizard_check" value="1">
							<input type="hidden" id="ddns_type" name="ddns_type" value="">
							<input type="hidden" id="ddns_hostname" name="ddns_hostname" value="">
							<input type="hidden" id="ddns_username" name="ddns_username" value="">
							<input type="hidden" id="ddns_password" name="ddns_password" value="">
							<input type="hidden" name="asp_temp_01" id="asp_temp_01" value="<!--# echo asp_temp_01 -->">
							<input type="hidden" name="asp_temp_02" id="asp_temp_02" value="<!--# echo asp_temp_02 -->">
							<input type="hidden" name="asp_temp_03" id="asp_temp_03" value="<!--# echo asp_temp_03 -->">
							<input type="hidden" name="asp_temp_04" id="asp_temp_04" value="<!--# echo asp_temp_04 -->">
							<input type="hidden" name="asp_temp_05" id="asp_temp_05" value="<!--# echo asp_temp_05 -->">
							<input type="hidden" name="asp_temp_06" id="asp_temp_06" value="<!--# echo asp_temp_06 -->">
							<input type="hidden" name="asp_temp_07" id="asp_temp_07" value="<!--# echo asp_temp_07 -->">
							<input type="hidden" name="asp_temp_08" id="asp_temp_08" value="<!--# echo asp_temp_08 -->">
							<input type="hidden" name="asp_temp_09" id="asp_temp_09" value="<!--# echo asp_temp_09 -->">
							<input type="hidden" name="asp_temp_10" id="asp_temp_10" value="<!--# echo asp_temp_10 -->">
						</form>
						<table align="center" class="formarea">
							<tr>
								<td>
									<input type="button" class="button_submit" id="prev_b" name="prev_b" style="display:none" value="Prev" onclick="prev_page()">
									<input type="button" class="button_submit" id="next_b2" name="next_b2" value="Next" onclick="next_page()">
									<input type="button" class="button_submit" id="retry_b" name="retry_b" style="display:none" value="Retry" onclick="window.location.reload();">
									<input type="button" class="button_submit" id="save_b" name="save_b" style="display:none" value="Save" onclick="send_request()">
									<input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wz_cancel()">
									<script>
										get_by_id("prev_b").value = _prev;
										get_by_id("next_b2").value = _next;
										get_by_id("retry_b").value = TEXT073;
										get_by_id("save_b").value = _save;
										get_by_id("cancel_b").value = _cancel;
									</script>
								</td>
							</tr>
						</table>
					</div>
				</div></td>
			</tr>
		</table><p>&nbsp;</p></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
			<tr>
				<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
				<td width="10">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
	</tr>
</table>

<div id="copyright" align="center"><script>show_words(_copyright);</script></div>
<!-- ////////// -->
<div id="show_box" style=" display:none;" >
<div id="append" style=" display:none;" >
<h2><span id="j_show_append_new"></span></h2>
<table cellSpacing=1 cellPadding=1 width=525 border=0>
  <tr>
    <td class="duple"><span id="j_show_username"></span> :</td>
    <td width="340">
    &nbsp;&nbsp;&nbsp;<input name="append_username" type="text" id="append_username" size="20" maxlength="15" value="" disabled="true">
    </td>
  </tr>
  <tr>
    <td class="duple"><span id="j_show_folder"></span> :</td>
    <td width="340">
    &nbsp;&nbsp;&nbsp;<input name="append_folder" type="text" id="append_folder" size="30" value="" readonly="true">
    &nbsp;&nbsp;&nbsp;<span id="show_browse"></span>
    </td>
  </tr>
  <tr id="show_premission_bar" style=" display:none;" >
    <td class="duple"><span id="j_show_permission"></span> :</td>
    <td width="340">&nbsp;&nbsp;
    <span id="show_permission_sel"></span>
    </td>
  </tr>
</table>

<p align=center>
  <span id="show_append_btn"></span>
</p>
<center>
  <span id="show_ok_btn"></span>
  &nbsp;<input type="button" id="Cancel" name="Cancel" value="Cancel" class="closeDOMWindow">
</center>
</div>

<div id="tree" style="display:none;">
<span id="j_show_select_folder"></span>
<div class="treeTable">
<table id="ltable" cellspacing="0" width="100%">
  <tbody>
  </tbody>
</table>
</div>
</div>
</div>
<!-- ////////// -->
</body>
<script>
	onPageLoad();
</script>
</html>
