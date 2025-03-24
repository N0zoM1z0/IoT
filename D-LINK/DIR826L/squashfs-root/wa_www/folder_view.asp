<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />	
<title></title>	
<link rel="stylesheet" type="text/css" href="reset.css" />
<link rel="stylesheet" type="text/css" href="web_file_access.css" />
<script type="text/javascript" src="js/webfile.js"></script>
<link rel="stylesheet" type="text/css" href="fancybox/style.css" />
<link rel="stylesheet" type="text/css" href="layout.css" />
<link rel="stylesheet" type="text/css" href="fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<script type="text/javascript" src="fancybox/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="fancybox/json2.js"></script>
<script language="JavaScript" src="js/object.js"></script>
<script language="JavaScript" src="js/xml.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="Javascript" src="md5.js"></script>
<script language="Javascript" src="jquery.cookie.pack.js"></script>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript">
	document.title = get_words('webf_title');
	var current_path;
	var current_volid;
	var usb_list = new Array();
	var storage_user = new HASH_TABLE();
	var root_info;
	var file_info;

	var session_id  = $.cookie('id');
	var session_tok = $.cookie('key');

	//load_lang_obj();	// you have to load language object for displaying words in each html page and load html object for the redirect or return page

	var images = {
					"file" 	:	"webfile_images/file.png",
					"3GP" 	:	"webfile_images/film.png",
					"AVI"	:	"webfile_images/film.png",
					"MOV"	:	"webfile_images/film.png",
					"MP4"	:	"webfile_images/film.png",
					"MPG"	:	"webfile_images/film.png",
					"MPEG"	:	"webfile_images/film.png",
					"WMV"	:	"webfile_images/film.png",
					"M4P"	:	"webfile_images/music.png",
					"MP3"	:	"webfile_images/music.png",
					"OGG"	:	"webfile_images/music.png",
					"WAV"	:	"webfile_images/music.png",
					"ASP"	:	"webfile_images/code.png",
					"ASPX"	:	"webfile_images/code.png",
					"C"		:	"webfile_images/code.png",
					"H"		:	"webfile_images/code.png",
					"CGI"	:	"webfile_images/code.png",
					"CPP"	:	"webfile_images/code.png",
					"VB"	:	"webfile_images/code.png",
					"XML"	:	"webfile_images/code.png",
					"CSS"	:	"webfile_images/css.png",
					"BAT"	:	"webfile_images/application.png",
					"COM"	:	"webfile_images/application.png",
					"EXE"	:	"webfile_images/application.png",
					"BMP"	:	"webfile_images/picture.png",
					"GIF"	:	"webfile_images/picture.png",
					"JPG"	:	"webfile_images/picture.png",
					"JPEG"	:	"webfile_images/picture.png",
					"PNG"	:	"webfile_images/picture.png",
					"PCX"	:	"webfile_images/picture.png",
					"TIF"	:	"webfile_images/picture.png",
					"TIFF"	:	"webfile_images/picture.png",
					"DOC"	:	"webfile_images/doc.png",
					"DOCX"	:	"webfile_images/doc.png",
					"PPT"	:	"webfile_images/ppt.png",
					"PPTX"	:	"webfile_images/ppt.png",
					"XLS"	:	"webfile_images/xls.png",
					"XLSX"	:	"webfile_images/xls.png",
					"HTM"	:	"webfile_images/html.png",
					"HTML"	:	"webfile_images/html.png",
					"PHP"	:	"webfile_images/php.png",
					"JAR"	:	"webfile_images/java.png",
					"JS"	:	"webfile_images/script.png",
					"PL"	:	"webfile_images/script.png",
					"PY"	:	"webfile_images/script.png",
					"RB"	:	"webfile_images/ruby.png",
					"RBX"	:	"webfile_images/ruby.png",
					"RUBY"	:	"webfile_images/ruby.png",
					"RHTML"	:	"webfile_images/ruby.png",
					"RPM"	:	"webfile_images/linux.png",
					"PDF"	:	"webfile_images/pdf.png",
					"PSD"	:	"webfile_images/psd.png",
					"SQL"	:	"webfile_images/db.png",
					"SWF"	:	"webfile_images/flash.png",
					"LOG"	:	"webfile_images/txt.png",
					"TXT"	:	"webfile_images/txt.png",
					"ZIP"	:	"webfile_images/zip.png",
					"RAR"	:	"webfile_images/zip.png",
					"7Z"	:	"webfile_images/zip.png",
					"GZ"	:	"webfile_images/zip.png",
					"BZ2"	:	"webfile_images/zip.png"
	};

	$(document).ready(function() {

		$("a[id=button1]").fancybox({
			'showCloseButton'	: false,
			'hideOnOverlayClick' : false,
			'overlayShow'		: true
		});

		$(".uploadtab>thead").css("background-color", "#808080");
		$(".uploadtab>tfoot").css("background-color", "#808080");
	});

	function close_fancybox(){
		$.fancybox.close();
	}

	function ctxClick(path, ulId, type)
	{
		var pId = ulId.substring(0, ulId.lastIndexOf('/'));

		try {
			var classes = $('#'+transUid(pId)).parent().find('div').attr('class').split(' ');
			if (classes != null) {
				for (var i=0; i<classes.length; i++) {
					if (classes[i] != 'expandable-hitarea')
						continue;
					$('#'+transUid(pId)).parent().find('div').click();
					break;
				}
			}
		} catch (e) {
			
		}
		$('#'+transUid(ulId)).parent().find('div').click();
		
		if (type == "2")	// add folder
			$('#'+transUid(ulId)).parent().find('div').click();

	}

	function delay_refresh_ctx()
	{
		ctxClick(current_path, current_volid, "2");
	}
	
	function delete_file_result(http_req)
	{
		var my_txt = http_req;			
		var result_info;
	
		try {
			result_info = my_txt;
		} catch(e) {				
			return;
		}
			
		if (result_info.status == "ok" && result_info.error == null){	
			get_sub_folder(current_path, current_volid);
		}
	}	
	
	function create_folder_result(http_req){
		var my_txt = http_req;
		var result_info;

		try {
			result_info = my_txt;
		} catch(e) {
			return;
		}

		close_fancybox();

		if (result_info.status == "ok" && result_info.error == null){
			get_sub_folder(current_path, current_volid);
		}
		$('#folder_name').val("");
	}

	function gen_rand_num(len)
	{
		var rand = '';
		for (var i=0; i<len; i++) {	
			var num = Math.round(Math.random()*10)%10;
			rand += new String(num);
		}
		return rand;
	}

	function create_folder()
	{
		var folder_name = $('#folder_name').val();
		var cur_path = current_path.split("%2F");
		if(cur_path.length>1)
			var dev_path = cur_path[0] + cur_path[1] + "/";
		else
			var dev_path = cur_path[0] + "/";
		var param = {
			url: '/dws/api/AddDir',
			arg: 'id='+session_id+'&path='+encodeURIComponent(dev_path)+'&volid='+1+'&dirname='+encodeURIComponent(folder_name)
		};
		var rand = gen_rand_num(32);//generate 32 bytes random number
		
		var arg1 = param.url+'?id='+session_id+rand;
			param.arg += ('&tok='+rand+hex_hmac_md5(session_tok, arg1));
			//param.arg += '&dirname=' + folder_name;

		var data = json_ajax(param);
		if (data == null)
			return;

		try {
			folders = data.dirs;
		} catch (e) {
			folders = null;
			return;
		}


		
		/*
		var xml_request = new XMLRequest(create_folder_result);
		var folder_name = $('#folder_name').val();

		if (!check_special_char(folder_name)){
			msg_obj.warning_msg('MSG143');
			return;
		}

		var para = "AddDir?id=" + storage_user.get("id") + "&tok=" + storage_user.get("tok") 
				 + "&volid=" + current_volid + "&path=" + current_path;

			para += "&dirname=" + encode_char(folder_name);
		xml_request.json_cgi(para);
		*/

		create_folder_result(data);
	}
/*	20120517 ignored by silvia
	function show_content_height(){
		var folder_h = get_by_id("left2").offsetHeight;
		var file_h = get_by_id("right").offsetHeight;
								
		if (folder_h < file_h){
			get_by_id("left2").style.position = "fixed";
		}else{
			get_by_id("left2").style.position = "";
		}
	}
*/
	/*
	function show_folder_content(which_info){
		var rtable = get_by_id('rtable');
		var sum = 0;

		if (rtable.rows.length > 0){
			for (var i = rtable.rows.length; i > 0; i--){
				rtable.deleteRow(i-1);
			}
		}

		for (var i = 0; i < which_info.count; i++){
			var obj = which_info.files[i];
			var desp = (obj.desp).toUpperCase();
			var file_name = obj.name;
			var file_path = obj.path;
			var dev_name = file_path;	// Tin Modify
			var row;

			if (file_name == ""){
				continue;
			}

			for (var j = 0; j < 1; j++){
				var insert_cell; // create a cell
				var cell_html;

				if (obj.type != 1){
					row = rtable.insertRow(sum);
					sum = sum + 1;
					insert_cell = row.insertCell(j);
					
					cell_html = "<a href=\"" + file_path + "\" target=\"_blank\">"
							  + "<div>"
							  + file_name + "<br>" + get_file_size(obj.size) + ", " + m_time
							  + "</div></a>"
				}else{
					break;
				}

				switch(j){
					case 0:	// Name
						insert_cell.id = "rname";
						insert_cell.className = "tdbg";
						insert_cell.innerHTML = cell_html;
						break;
				}
			}
		}
		show_content_height();
	}
	*/

	function show_folder_content(which_info)
	{			

		var rtable = get_by_id("rtable");			

		var sum = 0;

		if (rtable.rows.length > 0)
		{
			for (var i = rtable.rows.length; i > 0; i--)
			{
				rtable.deleteRow(i-1);
			}
		}

		for (var i = 0; i < which_info.count; i++)
		{			
			var obj = which_info.files[i];
			var desp = obj.desp.toUpperCase();
			var file_name = obj.name;				
			var file_path = current_path + "/" + file_name;
			var dev_name = file_path.split("%2F");	// to get the usb name
			var new_path = dev_name[0] + "/" + dev_name[1];
			var row;
		
			if (file_name == "")
			{
				continue;
			}

			for (var j = 0; j < 1; j++)
			{
				var insert_cell; // create a cell
				var cell_html;

				if (obj.type != 1)
				{
					row = rtable.insertRow(sum);
					sum = sum + 1;
					insert_cell = row.insertCell(j);

					//Tin add to convert time of last modification 20120514
					var isFirefox = navigator.userAgent.search("Firefox") > -1; 
					var isIE = navigator.userAgent.search("MSIE") > -1; 
					
					var file_mtime = (obj.mtime)*1000;
					var tmp = new Date();
					var m_time = tmp.setTime(file_mtime);
					m_time = tmp.toLocaleString();
					var ary = m_time.split(" ");
					if((isIE) || (isFirefox ))
						m_time = ary[0] +" "+ ary[1] + " " + ary[2];
					else
						m_time = ary[0] +" "+ ary[1] + " " + ary[2] + " " + ary[4] + " " + ary[3];
					
					cell_html = "<input type=\"checkbox\" id=\"" + i + "\" name=\"" + file_name + "\" value=\"1\"/>"
								+"<a href=\"" + encodeURIComponent(new_path) + "\" target=\"_blank\">"
								+ "<div>"
								+ file_name + "<br>" + get_file_size(obj.size) + ", " + m_time
								+ "</div></a>";

				}
				else
				{
					break;
				}

				switch(j)
				{

					case 0:	// Name
					insert_cell.id = "rname";							
					insert_cell.className = "tdbg";
					insert_cell.innerHTML = cell_html;
					break;

				}
			}
		}

		//show_content_height();

		}

	function get_sub_tree(which_info){
		var my_tree = "<ul class=\"jqueryFileTree\">";

		for (var i = 0; i < which_info.count; i++){
			var obj = which_info.files[i];
			var obj_path = current_path + "/" + obj.name;

			if (obj.name == ".." || obj.type != 1){	// when it's not a folder
				continue;
			}

			my_tree += "<li id=\"" + obj_path + "\" class=\"tocollapse\">"
					+  "<a href=\"#\" onClick=\"click_folder('" + obj_path + "', '" + current_volid + "', '" +obj.mode+ "')\">"
					+ obj.name + "</a></li>"
					+ "<li></li>"
					+ "<li><span id=\"" + obj_path + "-sub\"></span></li>";
		}
		my_tree += "</ul>";
		return my_tree;
	}

	function show_sub_folder(http_req){
		var my_txt = http_req;
		var parent_node = get_by_id(current_path);
		var current_node = get_by_id(current_path + "-sub");
		//var file_info;

		try {
			file_info = http_req;
		} catch(e) {
			return;
		}

		parent_node.className = "toexpanded";

		if (file_info.status == "ok" && file_info.error == null){
			current_node.innerHTML = get_sub_tree(file_info);
			show_folder_content(file_info);
		}
	}

	function get_sub_folder(which_path, which_volid)
	{
		/*
		var xml_request = new XMLRequest(show_sub_folder);
		var para = "ListFile?id=" + storage_user.get("id") + "&tok=" + storage_user.get("tok") 
				 + "&volid=" + which_volid + "&path=" + which_path;

		current_path = which_path;
		current_volid = which_volid;

		xml_request.json_cgi(para);
		*/
		
		current_path = which_path;
		current_volid = which_volid;

		var cur_path = which_path.split("%2F");
		if(cur_path.length>1)
			var new_path = cur_path[0] + cur_path[1];
		else
			var new_path = cur_path[0];

		var param = {
			url: '/dws/api/ListFile',
			arg: 'id='+session_id+'&volid=1'
		};
		var rand = gen_rand_num(32);//generate 32 bytes random number
		
		var arg1 = param.url+'?id='+session_id+rand;
		param.arg += ('&tok='+rand+hex_hmac_md5(session_tok, arg1));
		param.arg += '&path='+encodeURIComponent(new_path); //encodeURIComponent urlencode

		var data = json_ajax(param);
		if (data == null)
			return;
		else
			root_info = data;

		show_sub_folder(data);	
	}

	function delete_folder_content()
	{
		var rtable = get_by_id('rtable');
		if (rtable.rows.length > 0){
			for (var i = rtable.rows.length; i > 0; i--){
				rtable.deleteRow(i-1);
			}
		}
			//show_content_height();
	}
	function click_folder(path, volid, mode){
		var obj = get_by_id(path);
		
		close_fancybox();

		if (obj != undefined){
			if (mode < 2 || mode != 2){
				$('#disable_top').show();
				$('#enable_top').hide();				
			}else{
				$('#enable_top').show();
				$('#disable_top').hide();
				
			}
			if (obj.className == "toexpanded"){
				obj.className = "tocollapse";
				get_by_id(path + "-sub").innerHTML = "";
				delete_folder_content();
				current_path=path;
			}
			else{
				obj.className = "toexpanded";
				get_sub_folder(path, volid);
			}
		}
	}

	
	function check_upload_file(){
		var form1 = get_by_id("form1");
		var upload_name = get_by_id("upload_file").value;
		var file_name;

		if (window.ActiveXObject){	// code for IE
			file_name = upload_name.substring(upload_name.lastIndexOf("\\") + 1);
		}else{
			if (upload_name.indexOf("C:\\fakepath\\") != -1){
				file_name = upload_name.substring(upload_name.indexOf("C:\\fakepath\\") + 12);
			}else{
				file_name = upload_name;
			}
		}

		//form1.action = "/homecloud/api/UploadFile?" + Math.random();
		//form1.action = "webfile_cgi.cgi?" + Math.random();

		var rand = gen_rand_num(32);//generate 32 bytes random number
		var arg1 = '/dws/api/UploadFile?id='+session_id+rand;
		
		$('#id').val(session_id);
		$('#volid').val('1');
		$('#tok').val(rand+hex_hmac_md5(session_tok, arg1));
		var uploadPath = current_path.split("%2F");
		var truePath;
		if(uploadPath.length>1)
			truePath = uploadPath[1];
		else
			truePath = uploadPath[0];
		$('#path').val(encodeURIComponent(truePath));
		$('#filename').val(encodeURIComponent(file_name));

		document.getElementById('form1').action = '/dws/api/UploadFile';
		document.getElementById('form1').target = 'upload_target';	//'upload_target' is the name of the iframe
		
		$('#form1').submit();
		
		//setTimeout('refresh_current_path()', 1000);
	}

	function onPageload_dis()
	{
		$('#disable_top').show();
		$('#enable_top').hide();		
	}

	function delete_file()
	{
		var checked_flag=0;
		var str="";
		var cur_path = current_path.split("%2F");
		if(cur_path.length>1)
			var dev_path = cur_path[0] + cur_path[1];
		else
			var dev_path = cur_path[0];
		
		var param = {
			url: '/dws/api/DelFile',
			arg: 'id='+session_id
		};
		
			for (var i = 0; i < file_info.count; i++){
				var file_name = file_info.files[i].name;
				var type = file_info.files[i].type;
				if (type != 1){
					if (get_by_id(i).checked){
						checked_flag = 1;
						if (str != ""){
							str += ",\"" + file_name + "\"";
						}else{
							str += "[\"" + file_name + "\"";
						}
						
					}
				}
			}
			
			if (str != "")
				str += "]";

			if (checked_flag == 0){
				alert(get_words('file_acc_del_empty'));
				return;
			}
									
			if (!confirm(get_words('file_acc_del_file')))
				return;
			else{ 
				var rand = gen_rand_num(32);//generate 32 bytes random number
				var arg1 = param.url+'?id='+session_id+rand;
				param.arg += '&volid=1';
				param.arg += '&tok='+rand+hex_hmac_md5(session_tok, arg1);
				param.arg += '&path='+encodeURIComponent(dev_path);
				param.arg += '&filenames='+str;
			}
			
			var data = json_ajax(param);
			if (data == null)
				return;

			try {
				//folders = data.dirs;
			} catch (e) {
				//folders = null;
				return;
			}
			delete_file_result(data);
			
	}
	function get_root_info(which_info){
		var my_tree = "<ul class=\"jqueryFileTree\">";
		if (which_info.status == "ok" && which_info.error == null){	
			if (which_info.rootnode.length > 0){
				for (var i = 0; i < which_info.rootnode.length; i++){
					var obj = which_info.rootnode[i];
					var dev_name = obj.volname.split("%2F");	// to split usb_dev and usb name
					//var dev_name = obj.volname;  //Tin modify
					var usb_info = new HASH_TABLE();
					if (obj.volname == ".."){
						continue;
					}

					my_tree += "<li id=\"" + obj.volname + "\" class=\"tocollapse\">"
							+  "<a href=\"#\" onClick=\"click_folder('" + obj.volname + "', '" + obj.volid + "', '" + obj.mode + "')\">"
							+ dev_name[1] + "</a></li>"
							+ "<li></li>"
							+ "<li><span id=\"" + obj.volname + "-sub\"></span></li>";

					usb_info.put("volname", obj.volname);
					usb_info.put("volid", obj.volid);
					usb_info.put("status", obj.status);
					usb_info.put("nodename", obj.nodename);
					usb_list.push(usb_info);
				}
			}
		}else if (which_info.status == "fail"){
			if (which_info.error == 5002){
			my_tree += '<li class="warning">' + lang_obj.display('WS009') +'</li>';
			}else if (which_info.error == 5003){
				location.href = "login.asp";
			}
		}
		my_tree += "</ul>";
		return my_tree;
	}
	
	function show_menu_tree(which_info){
		var root_tree = get_by_id("root_tree");
		root_tree.innerHTML = get_root_info(which_info);
	}

	function get_settings_xml(http_req)
	{
		var my_txt = root_info.rootnode;

		/*
		var root_info;
		
		try {
			root_info = JSON.parse(my_txt);
		} catch(e) {
			load_webfile_settings();
			return;
		}

		*/
		
		show_menu_tree(root_info);
	}

	function load_webfile_settings()
	{
		//var xml_request = new XMLRequest(get_settings_xml);
		//var para = "ListRoot?id=" + storage_user.get("id") + "&tok=" + storage_user.get("tok");
		//xml_request.json_cgi(para);

		var param = {
			url: '/dws/api/ListRoot',
			arg: 'id='+session_id
		};
		var rand = gen_rand_num(32);//generate 32 bytes random number
		
		var arg1 = param.url+'?id='+session_id+rand;
		param.arg += ('&tok='+rand+hex_hmac_md5(session_tok, arg1));

		var data = json_ajax(param);
		if (data == null)
			return;
		else
			root_info = data;

		get_settings_xml();
	}

	function get_login_info_result()
	{
		/*
		var my_xml = http_req.responseXML;
		if (check_user_info(my_xml.getElementsByTagName("redirect_page")[0])){
			storage_user.put("id", get_node_value(my_xml, "user_name"));
			storage_user.put("tok", get_node_value(my_xml, "user_pwd"));
			load_webfile_settings();
		}
		*/

		load_webfile_settings();
	}

	function get_login_info()
	{
		/*
		var xml_request = new XMLRequest(get_login_info_result);
		var para = "request=get_login_info";
		xml_request.exec_webfile_cgi(para);
		*/
 
		get_by_id("Image6").style.zIndex = "999";

		if (session_id == null || session_tok == null)
			location.replace('wa_login.asp');

		get_login_info_result();
	}

	function refresh_current_path(){
		close_fancybox();

		$('#upload_file').val("");
		$('#folder_name').val("");
		get_sub_folder(current_path, current_volid);
	}
	
	document.oncontextmenu=function(){
		return false;
	}
</script>
</head>
<body onLoad="get_login_info();onPageload_dis();">
	<div id="wrapper">
	<div id="header">
		<div align="right">
		<table width="100%" border="0" cellspacing="0">
			<tr>
				<th width="224" rowspan="2" scope="row"><img src="webfile_images/index_01.png" width="220" height="55" /></th>
				<th width="715" height="30" scope="row"><a href="category_view.asp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image6','','webfile_images/btn_menu2_.png',1)"><img src="webfile_images/btn_menu2_.png" name="Image6" width="25" height="25" border="0" align="right" id="Image6" /></a></th>
				<th width="15" scope="row"></th>
			</tr>
			<tr>
				<th scope="row"></th>
				<th scope="row"></th>
			</tr>
		</table>
		<a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image6','','webfile_images/btn_home_.png',1)"></a>
		</div>
	</div>
	<div id="folder_top">
		<div id="left"></div>
		<div id="folder_view_right">
		<table width="670" height="29" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<th width="32" scope="row">&nbsp;</th>
			<td width="638">
			<div id="enable_top" style="">
				<a id="button1" href="#inline1"><script>document.write("<input type=\"button\" id=\"create_btn\" value=\"" + get_words(webf_folder) + "\" />");</script></a>					
				<a id="button1" href="#inline2"><script>document.write("<input type=\"button\" id=\"upload_btn\" value=\"" + get_words(tf_Upload) + "\" />");</script></a>				
				<input type="button" id="delete_btn" value='' onclick="delete_file();">
				<script>$('#delete_btn').val(get_words(_delete));</script>
			</div>
			<div id="disable_top" style="display:none;">
				<input type='button' id='create_btn1' value='' disabled />
				<input type='button' id='upload_btn1' value=''disabled />
				<input type="button" id="delete_btn1" value='' onclick="delete_file();" disabled>
				<script>
					$('#create_btn1').val(get_words(webf_folder));
					$('#upload_btn1').val(get_words(tf_Upload));
					$('#delete_btn1').val(get_words(_delete));
				</script>
			</div>
			</td>
		</tr>
		</table>
		</div>
	</div>
	<div id="lower2">
		<div id="left2">
			<div>
				<ul class="jqueryFileTree">
					<li class="toexpanded"><script>show_words(webf_hd)</script></li><!--<script>lang_obj.write('WS013');</script>-->
					<li><span id="root_tree"></span></li>
				</ul>
			</div>
		</div>
		<div id="right">
			<table id="rtable" width="670" border="0" cellspacing="0" cellpadding="0"></table>
		</div>
		<div id="footer"><img src="webfile_images/dlink.png" width="77" height="22" /></div>
	</div>
	<div style="display:none;">
		<div id="inline1" style="width:400px;height:120px;overflow:auto;">
		<table width="100%" height="100%" class="uploadtab">
			<thead><tr><th align="left"><span id="creat_fd_title"></th></tr></thead>
			<script>$('#creat_fd_title').html(get_words(webf_createfd));</script>
			<tr>
				<td align="left">
					<span id="creat_fd"><script>$('#creat_fd').html(get_words(webf_fd_name));</script>				
					<input type="text" id="folder_name" name="folder_name" size="32"></td>
			</tr>
			<tfoot align="right">
			<tr>
				<td>
					<input type="button" id="ok1" name="ok1" value="" onClick="create_folder()">&nbsp; 
					<input type="button" id="cancel1" onClick="close_fancybox()" value="">
					<script>
						$('#ok1').val(get_words(_ok));
						$('#cancel1').val(get_words(_cancel));
					</script>
				</td>
			</tr>
			</tfoot>
		</table>
		</div>
	</div>
	<div style="display: none;">
		<div id="inline2" style="width:400px;height:120px;overflow:auto;">
		<table width="100%" height="100%" class="uploadtab">
			<form id="form1" name="form1" method="post" enctype="multipart/form-data" target="upload_frame">
			<input type="hidden" id="id" name="id">
			<input type="hidden" id="tok" name="tok">
			<input type="hidden" id="volid" name="volid">
			<input type="hidden" id="path" name="path">
			<input type="hidden" id="filename" name="filename">
			<input type="hidden" id="upload_source" name="upload_source" value="gui">
			<thead><tr><th align="left"><span id="upload_fl_title"></th></tr></thead>
			<script>$('#upload_fl_title').html(get_words(webf_upload));</script>
			<tr>
				<td>
					<span id="upload_fl"><br><script>$('#upload_fl').html(get_words(webf_file_sel));</script>
					<input type="file" id="upload_file" name="upload_file" size="32">
				</td>
			</tr>
			<tfoot align="right">
			<tr>
				<td>
					<input type="button" id="ok2" name="ok2" value="" onClick="check_upload_file()">&nbsp; 
					<input type="button" id="cancel2" name="cancel2" onClick="close_fancybox()" value="">
					<script>
						$('#ok2').val(get_words(_ok));
						$('#cancel2').val(get_words(_cancel));
					</script>
				</td>
			</tr>
			</tfoot>
			</form>
		</table>
		<iframe id="upload_target" name="upload_target" src="" style="width:0;height:0;border:0px solid #fff;"></iframe>
		</div>
	</div>
	<iframe name="upload_frame" width="0%" height="0%"></iframe>
	</div>
</body>
</html>