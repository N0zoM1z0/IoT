﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<script> 
	var funcWinOpen = window.open;
</script>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
var dev_info = get_router_info();
document.title = get_words('TEXT000');
	var count = 120;
	var arr_page = [
		'err_checksum',
		'err_hwid',
		'err_file',
		'success'
	];
	
	var arr_fwupgrade_msg = [
		get_words('fw_checksum_err'),
		get_words('fw_bad_hwid'),
		get_words('fw_unknow_file_format'),
		get_words('fw_fw_upgrade_success')
	];

	var arr_lpupgrade_msg = [
		get_words('fw_checksum_err'),
		get_words('fw_bad_hwid'),
		get_words('fw_unknow_file_format'),
		get_words('fw_lp_upgrade_success')
	];

	var dev_info = get_router_info();
	var param = {
		url: "lang_upgrade.ccp",
		arg: "act=getLangInfo"
	};
	get_config_obj(param);
	
	var langInfo = {
		'has_lang_pack': config_val('has_lang_pack'),
		'lp_ver':		config_val('lang_ver'),
		'lp_date':		config_val('lang_date'),
		'lp_name':		config_val('lang_name')
	}
	
	var submit_button_flag = 0;
	
	function send_request(){
		//temporary disable fw upload button, Jerry 2010-08-09
		//return false;
		
		if (get_by_id("file").value === "") {
			//alert("You must enter the name of a firmware file first.");
			alert(which_lang[tf_FWF1]);
			return false;
		}
		//if (!confirm("Note: Some firmware upgrades reset the router's configuration options to the factory defaults.\n Before performing an upgrade, be sure to save the current configuration from the Tools-System screen.\n Do you still want to upgrade?")) {
		if (!confirm(get_words('tf_USSW'))) {
			return false;
		}
		//if (!confirm("Do you really want to reprogram the device using the firmware file \"" +
				//get_by_id("file").value + "\"?")) {
		if (!confirm(get_words('tf_really_FWF')+" \""+ $('#file').val() + " \"?" )) {
				return false;
		}
		
		var paramSubmit={
			url: "get_set.ccp",
			arg: "ccp_act=doEvent&ccpSubEvent=CCP_SUB_UPLOADFW"
		};
		//ajax_submit(paramSubmit);	//since dir-651 should have enough space, no need to send event to clear device.
		get_by_id("msg_upload").style.display = "";
		get_by_id("upgrade_button").disabled = true;
		
		//setTimeout("doUploadFile()",5*1000);
		doUploadFile();
	}
	
	function doUploadFile()
	{
		try {
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				$('#form1').submit();
			}
		} catch (e) {
			alert("%[.error:Error]%: " + e.message);
			//alert(which_lang[_error]+": " + e.message);
			get_by_id("msg_upload").style.display = "none";
			get_by_id("upgrade_button").disabled = false;
		}
	}

	function download_latest_fm(){
		for (var i = 0; i < get_by_id("sel_site").length; i++){
			if(get_by_id("sel_site").options[i].selected == true){
				var html = get_by_id("sel_site").options[i].value;
			}
		}
		window.open(""+html+"");
	}
	
	function toggle_page(id) {
		if (arr_page == null || (arr_page instanceof Array) == false)
			return;
		for (var i=0; i<arr_page.length; i++) {
			if (id == i) {
				//alert(arr_fwupgrade_msg[i]);
				return;
			} else if (parseInt(id/10) == 1 && (id%10) == i) {
				//alert(arr_lpupgrade_msg[i]);
				if (parent != null) {
					parent.window.location.reload();
				}
				return;
			}
		}
	}

	function back(){
		window.location.href ="login.asp";
	}
	
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;
		
		if (count == 0) {	       
	        back();
	        return;
	    }

		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }
	}
	
	function is_newer(major, minor)
	{
		if (major == null || minor == null)
			return false;

		var cur_fw_ver = dev_info.fw_ver;
		var cur_major = cur_fw_ver.substr(0, cur_fw_ver.indexOf('.'));
		var cur_minor = cur_fw_ver.substr(cur_fw_ver.indexOf('.')+1, cur_fw_ver.length);
		
		if (parseInt(major, 10) > parseInt(cur_major, 10))
		{
			return true;
		}
		
		if (parseInt(minor, 10) > parseInt(cur_minor, 10))
		{
			return true;
		}
			
		return false;
	}
	
	function prepare_download_site(target, info)
	{
		var sel_id = '';
		
		if (info == null)
			return;
		
		if (target == 'fw') {
			sel_id = 'fw_downloadsite';
		} else if (target == 'lp') {
			sel_id = 'lp_downloadsite';
		} else {
			return;
		}
		
		$(sel_id).children().remove();
		$(info).children().each( function(idx) {
			//var caption = (this).nodeName;
			var caption = $(this)[0].nodeName;
			var dlUrl = $(this).find('Firmware').text();
			//$(new Option(caption, dlUrl)).appendTo(sel_id);
			document.getElementById(sel_id).options[idx] = new Option(caption, dlUrl);
		});
	}
	
	function handle_update(target, response)
	{
		if (response == null)
			return;

		var fw_ver_major = $(response).find('FW_Version').find('Major').text();
		var fw_ver_minor = $(response).find('FW_Version').find('Minor').text();
		var fw_ver_date  = $(response).find('FW_Version').find('Date').text();
		
		if (is_newer(fw_ver_major, fw_ver_minor) == false) {
			if (langInfo.has_lang_pack == '0') {
				$('.lp_null').show();
				$('.lp_detail').hide();
			}
			$('#no_available_update').show();
			return;
		}
		
		if (target == 'lp')
		{
			$('.lp_row').show();
		}
		
		// display new fw information
		$('#new_fw_update_box').show();
		$('#'+target+'_latest_ver').html(fw_ver_major+'.'+fw_ver_minor);
		$('#'+target+'_latest_date').html(fw_ver_date);
		prepare_download_site(target, $(response).find('Download_Site'));
	}
			
	function request_update(target)
	{
		// since ajax cannot do cross-domain query, we query cgi on DUT and let DUT query the xml.
		var q_url  ='fw_check.ccp';
		var model  = dev_info.model;
		var fw_ver = dev_info.fw_ver;
		var hw_ver = dev_info.hw_ver;
		var lp_ver = langInfo.lp_ver;
		var lp_nam = langInfo.lp_name;
		var region =  dev_info.region;
		
		//var model  = 'DIR-615';
		//var fw_ver = '1.00';
		//var hw_ver = 'C1';
		//var lp_nam = 'TW';

		var query  = '';
		
		if (fw_ver == null || hw_ver == null) {
			alert('unknow fw_ver or hw_ver');
			return;
		}
		
		if (target == 'fw')
		{
			if(region=="WW")
				query = 'Model='+model+'_'+hw_ver.substr(0, 1)+'x_Default';
			else
				query = 'Model='+model+'_'+hw_ver.substr(0, 1)+'x_'+region;
		}
		else if (target == 'lp')
			query = 'Model='+model+'_'+hw_ver.substr(0, 1)+'x_'+lp_nam+'LP';
		else
			return;
		
		var time=new Date().getTime();
		var ajax_param = {
			url:	q_url,
			type:	'post',
			async:	true,
			data:	query+"&"+time+"="+time,
//			dataType: "xml",
			success: function(response){
				$('#checking_update').hide();
				handle_update(target, response);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				if (target == 'fw') {
					$('#checking_update').hide();
					$('#no_available_update').show();
				} else {
					if (langInfo.has_lang_pack == '0') {
						$('.lp_null').show();
						$('.lp_detail').hide();
					}
				}
			}
		}
		
		$.ajax(ajax_param);			
	}

	function check_update()
	{
		$('.lp_row').hide();
		$('#no_available_update').hide();
		$('#checking_update').show();
		request_update('fw');
		request_update('lp');
	}
	
	function show_save_window(name){
		funcWinOpen(name,"Save","width=500,height=600,scrollbar=yes");
	}

	function do_download(target)
	{
		var reqObj = $('#'+target+'_downloadsite :selected');
		
		if ($(reqObj) == null || $(reqObj).val() == '')
			return;

		try {
			show_save_window($(reqObj).val());
		} catch (e) {
			alert('cannot open:' + $(reqObj).val());
		}
	}
	
	function do_lp_Upgrade() {
		if ($("#lang_file").val() == "") {
			//alert("You must enter the name of a firmware file first.");
			alert(which_lang[tf_langf]);
			return false;
		}
		
		if (!confirm(which_lang[tf_really_langf]+" \""+ $("#lang_file").val() + " \"?" )) {
				return false;
		}
		
		//document.getElementById('form_lp').target = 'upload_target'; //'upload_target' is the name of the iframe
		$('#form_lp').submit();
	}
	function send_rm_lang_pack()
	{
		get_by_id("form5").submit();
	}	
	
	$(document).ready( function () {
		if(dev_info.login_info != "w"){
			DisableEnableForm(document.form1,true);	
			DisableEnableForm(document.formLP, true);
			$('#btn_rm_lang_pack').attr('disabled',true);
			$('#check_now_b').attr('disabled',true);
		}

		$('#new_fw_update_box').hide();
		$('#no_available_update').hide();
		$('#checking_update').hide();
		$('.lp_null').hide();
		$('.lp_detail').hide();

		$('.lp_row').show();
		if (langInfo.has_lang_pack == '0') {
			$('.lp_null').show();
			$('.lp_detail').hide();
		} else {
			$('.lp_null').hide();
			$('.lp_detail').show();
		}

		var ret = getUrlEntry('ret');
		toggle_page(ret);
		
	});
	
	function is_day(s)
	{
		var n = parseInt(s, 10);
		if (isNaN(n) != true && n != 0)
			return true;
		
		return false;
	}
	
	function is_mon(s)
	{
		var month = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
		for (var i=0; i<month.length; i++)
		{
			if (s == month[i])
				return true;
		}
		return false;
	}
	
	function parse_mon(s)
	{
		var month = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
		var ret = '0';
		for (var i=0; i<month.length; i++)
		{
			if (s == month[i])
				ret = i+1;
		}
		if (parseInt(ret, 10) < 10)
			ret = ('0'+ret);
		return ret;
	}
	
	function is_year(s)
	{
		var n = parseInt(s, 10);
		if (s.length == 4 && isNaN(n) != true && n > 0)
			return true;
			
		return false;
	}
	
	function parse_date(d)
	{
		if (d == null || d.length == 0)
			return d;
		
		var arr = d.split(', ');
		if (arr.length == 1)
			return d;
		
		var yy = '';
		var mm = '';
		var dd = '';
		for (var i=0; i<arr.length; i++)
		{
			if (yy == '' && is_year(arr[i]))
			{
				yy = arr[i];
				continue;
			}
			if (mm == '' && is_mon(arr[i]))
			{
				mm = arr[i];
				continue;
			}
			if (dd == '' && is_day(arr[i]))
			{
				dd = arr[i];
				continue;
			}
		}
		return (yy+'/'+parse_mon(mm)+'/'+dd);
	}
	
	function ajax_submit(p)
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

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
<tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
	<td>&nbsp;</td>
</tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
	<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
</tr>
</table>

<table id="fw_topmenu" border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
<tr id="topnav_container">
	<td><img src="short_modnum.gif" width="125" height="25"></td>
	<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
	<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
	<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
	<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
	<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
</tr>
</table>
<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF"><tr>
	<td id="sidenav_container" valign="top" width="125" align="right">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td id="sidenav_container">
		<div id="sidenav">
			<ul>
				<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
				<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
				<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
				<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
				<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
				<li><div id="sidenavoff"><script>show_words(_firmware)</script></div></li>
				<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
				<li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
				<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li>
			</ul>
		</div>
		</td>
	</tr>
	</table>
	</td>
	<td valign="top" id="maincontent_container">
	<div id="maincontent">
		<div id="box_header"> 
			<h1><script>show_words(_firmwareUpdate)</script></h1>
			<p>
				<script>show_words(tf_intro_FWU1)</script>
				<script>document.write(dev_info.model);</script>
				<script>show_words(tf_intro_FWU2)</script><br>
				<script>show_words(tf_intro_FWU3)</script>
			</p>
			<p><script>show_words(tf_intro_FWChB)</script></p>
			<p>
				<script>show_words(tf_intro_FWU4)</script>
				<script>document.write(dev_info.model);</script>
				<script>show_words(tf_intro_FWU5)</script>
			</p>
			<p>
				<script>show_words(lang_package_note2);</script>
			</p>
		</div>

		<div class="box"> 
		<h2><script>show_words(tf_FWInf)</script></h2>
		<table width=525 border=0 cellpadding=2 cellspacing="2">
		<tr>
			<td width=45% align=right class="duple">
				<b><script>show_words(tf_CFWV)</script>:</b>
			</td>
			<td width=10% class="output"> 
				<b><script>document.write(dev_info.fw_ver);</script></b>
			</td>
			<td width=10% align="right">
				<b><script>show_words(_date)</script>:</b>
			</td>
			<td width=35% class="output"> 
				<b><script>document.write(parse_date(dev_info.ver_date));</script></b>
			</td>
		</tr>
		<tr class="lp_null">
			<td align="right">
				<p><strong class="output"><script>show_words(current_lang_pack_version);</script>&nbsp;:</strong></p>
			</td>
			<td align="left" colspan="3">
				<script>show_words(no_lang_pack);</script>
			</td>
		</tr>
		<tr class="lp_detail">
			<td align="right" class="duple">
				<p><strong class="output"><script>show_words(current_lang_pack_version);</script>&nbsp;:</strong></p>
			</td>
			<td nowrap align="left">
				<b><span id="lp_ver" align="left"><script>document.write(langInfo.lp_ver.substr(0, 4)+' '+langInfo.lp_name);</script></span></b>
			</td>
			<td align="right">
				<strong class="output"><script>show_words(_date);</script>&nbsp;:</strong>
			</td>
			<td nowrap align="left">
				<b><span id="lp_date" align="left"><script>document.write(parse_date(langInfo.lp_date));</script></span></b>
			</td>
		</tr>
		<tr class="lp_detail">
			<form id="form5" name="form5" method="post" action="lang_upgrade.ccp" >
			<input type="hidden" id="which_action" name="act" value="removeLang">
				<td  align="right">
					<strong class="output"><script>show_words(clear_lang_pack);</script>&nbsp;:</strong>
				</td>
				<td colspan=3 align="left">
					<script>document.write("<input type=\"button\" id=\"btn_rm_lang_pack\" class=\"button_submit\" value=\"" + get_words('_remove_multi') + "\" onClick=\"send_rm_lang_pack()\" />");</script>
				</td>
			</form>
		</tr>
		<tr>
			<td colspan=4>
				<strong> 
					<script>show_words(tf_COLF)</script>: &nbsp;&nbsp;
					<input id="check_now_b" name="check_now_b" type="button" class=button_submit value="" onClick="check_update('fw');">
					<script>$('#check_now_b').val(get_words('tf_CKN'));</script>
				</strong>
			</td>
		</tr>
		<tr>
			<td colspan=3>
				<strong><div id="check_result"></div></strong>
			</td>
		</tr>
		<tr id="no_available_update">
			<td colspan="4" align="center">
				<strong class="output"><script>show_words(no_available_update);</script></strong>
			</td>
		</tr>
		<tr id="checking_update">
			<td colspan="4" align="center">
				<strong class="output"><script>show_words(KR65);</script>...</strong>
			</td>
		</tr>
		</table>
		</div>

		<div class="box" id="new_fw_update_box">
		<h2><script>show_words(tf_FWCheckInf)</script></h2>
		<table width="100%">
		<tr>
			<td width="40%" align="right" nowrap>
				<p><strong class="output"><script>show_words(YM182)</script> :</strong></p>
			</td>
			<td>
				<strong class="output"><span id="fw_latest_ver"></span></strong>
			</td>
		</tr>
		<tr>
			<td align="right" nowrap>
				<p><strong class="output"><script>show_words(tf_LFWD)</script> :</strong></p>
			</td>
			<td>
				<strong class="output"><span id="fw_latest_date"></span></strong>
			</td>
			</tr>
			<tr>
			<td align="right" nowrap>
				<p><strong class="output"><script>show_words(tf_ADS)</script> :</strong></p>
			</td>
			<td>
				<select id="fw_downloadsite" name="sel_site" size="1"></select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="button" name="download" id="download" value="" onClick="do_download('fw');"> 
				<script>$('#download').val(get_words('help501'));</script>
			</td>
		</tr>
		<tr class="lp_row">
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr class="lp_row">
			<td align="right" nowrap>
				<p><strong class="output">
				<script>show_words('latest_lang_package_ver')</script> :
				</strong></p>
			</td>
			<td>
				<strong class="output"><span id="lp_latest_ver"></span></strong>
			</td>
		</tr>
		<tr class="lp_row">
			<td align="right" nowrap>
				<p><strong class="output">
				<script>show_words('latest_lang_package_date')</script> :
				</strong></p>
			</td>
			<td>
				<strong class="output"><span id="lp_latest_date"></span></strong>
			</td>
		</tr>
		<tr class="lp_row">
			<td align="right" nowrap>
				<p><strong class="output"><script>show_words('tf_ADS')</script> :</strong></p>
			</td>
			<td>
				<select id="lp_downloadsite" name="lp_downloadsite" size="1"></select>
			</td>
		</tr>
		<tr class="lp_row">
			<td></td>
			<td>
				<input type="button" id="btn_lp_download" value="" onClick="do_download('lp');"> 
				<script>$('#btn_lp_download').val(get_words('help501'));</script>
			</td>
		</tr>
		</table>
		</div>	

	<form id="form1" name="form1" method=POST action="fwupgrade.ccp" enctype="multipart/form-data">
	<iframe id="upload_target" name="upload_target" src="" style="width:0;height:0;border:0px solid #fff;"></iframe>
	<input type="hidden" name="action" value="fwupgrade">
		<div class="box"> 
		<h2><script>show_words(tf_FWUg)</script></h2>
		<table width=525 border=0 cellpadding=2 cellspacing="2">
		<tr>
			<td colspan=3> 
			<p class="box_alert">
				<strong><script>show_words(_note)</script>:</strong> 
				<script>show_words(tf_msg_FWUgReset)</script>
			</p>
			<p class="box_msg"> 
				<script>show_words(tf_msg_wired)</script>
			</p>
			</td>
		</tr>
		<tr>
			<td align=right class="duple"></td>
			<td height="59" colspan=2>
				<script>show_words(tf_Upload)</script>:
				<input type=file id=file name=file size="30"><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="upgrade_button" name="upgrade_button" class=button_submit value="" onClick="send_request();">
				<script>$('#upgrade_button').val(get_words('tf_Upload'));</script>
			</td>
		</tr>
		<tr id="msg_upload" style="display:none" class="msg_inprogress">
			<td align=right class="duple"></td>
			<td colspan=2> 
				<script>show_words(tf_msg_Upping)</script>
			</td>
		</tr>
		</table>
		</div>
	</form>

	<div>
		<div class="box">
		<h2><script>show_words(lang_package_info);</script></h2>
		<table width=525 border=0 cellpadding=2 cellspacing="2">
		<tr>
			<td align=right class="duple"></td>
			<td height="59" colspan=2>
			<form id="form_lp" name="formLP" method="post" action="lang_upgrade.ccp" enctype="multipart/form-data">
				<input type="hidden" id="which_action" name="which_action" value="load_lang">
				<p>
					<script>show_words(tf_Upload)</script>:
					<input type="file" id="lang_file" name="lang_file" /><br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="upgrade_lp_button" name="upgrade_button" class=button_submit value="" onClick="do_lp_Upgrade();">
					<script>$('#upgrade_lp_button').val(get_words('tf_Upload'));</script>
				</p>
			</form>
			</td>
		</tr>
		</table>
		</div>
	</div>

	<div id="update_new_result" name="update_new_result"> 
		<table width=90% border=0 cellpadding=2 cellspacing="2">
		<tr>
			<td height=0 align="center">
				<IFRAME id="iframe_scan" name="iframe_scan" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no"></IFRAME>
			</td>
		</tr>
		</table>
	</div>
	</div>
	</td>
	<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
		<tr>
			<td id=help_text>
				<strong><script>show_words(_hints)</script></strong> 
				<p><script>show_words(ZM17)</script></p>
				<p class="more"><a href="support_tools.asp#Firmware" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
	<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
	<td width="10">&nbsp;</td>
	<td>&nbsp;</td>
</tr>
</table>
<br>
	<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>