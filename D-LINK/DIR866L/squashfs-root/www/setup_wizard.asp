<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/public.js"></script>
<script>
	$().ready(function(){
		var loc = $(location).attr('href');
		var host = ""+loc.match(/^http:\/\/[^/]+/); //convert it to string
		var def_domain1 = "http://<!--# echo lan_device_name -->";
		var def_domain2 = "http://<!--# echo lan_ipaddr -->";
		var def_domain3 = "http://<!--# echo lan_device_name -->.local";
		if (host != def_domain1 && host != def_domain2 && host != def_domain3) {
			location.href = def_domain3;
		}
	});
	var time=new Date().getTime();
	var i= "<script language=\"JavaScript\" "+ 
	" src=\"\/wizard_lang.js?wizard_lang_time=" + time + "\" type=\"text/JavaScript\"><\/script>"
	document.write(i)
</script>

		<style type="text/css">
			#loading{
				position: relative;
				margin:0px auto;
				width:300px;
				height:15px;
				background:#ffffff;
				border:2px solid black;
			}
			
			#loading div{
				width:15px;
				height:15px;
				background:#ff6600;
			}
			.langmenu{
			position: absolute;
			right:10%;
			display: none;
			background: white;
			border: 1px solid #f06b24;
			border-width: 3px 0px 3px 0px;
			padding: 10px;
			font: normal 12px Verdana;
			z-index: 100;

			}

			.langmenu .column{
			text-align: left;
			float: left;
			width: 100px; /*width of each menu column*/
			margin-right: 5px;
			}

			.langmenu .column ul{
			margin: 0;
			padding: 0;
			list-style-type: none;
			}

			.langmenu .column ul li{
			padding-bottom: 8px;
			}

			.langmenu .column ul li a{
			text-decoration: none;
			}
		</style>
		
<script language="Javascript">
	var page_index = 0;
	var wan_detect_id = 0;
	//muilt lang
	var tmpURL = document.URL.split('#');
	var imgclose=0;
	var close=0;
	var currLindex=' ';
	var is_support=0;
	var br_lang = "<!--# echo wizard_lang -->";
	
	function onPageLoad() {
		var salt = "<!--# echo login_salt -->";
		
		disable_all_btn(false);
		
		get_by_id("wz_setup").style.display = "";
		get_wan_info();
	}

	function createRequest() {
		var XMLhttpObject = false;
		if(window.XMLHttpRequest) {
			try {
				XMLhttpObject = new XMLHttpRequest();
			} catch (e) {
			}
		} else if(window.ActiveXObject) {
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

	function wan_info_xmldoc() {
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			try {
				get_by_id("wan_cable_status").value = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
				get_by_id("next_b2").disabled = false;
				clearTimeout(wan_detect_id);

			} catch(e) {
			}
		}
	}

	function get_wan_info() {
		xmlhttp = new createRequest();
		if(xmlhttp) {
			var url = "";
			var temp_cURL = document.URL.split("/");
			for(var i = 0; i < temp_cURL.length - 1; i++) {
				if(i == 1)
					continue;
				if(i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += "device_status.xml";
			xmlhttp.onreadystatechange = wan_info_xmldoc;
			xmlhttp.open("GET", url, true);
			xmlhttp.send(null);
		}
		wan_detect_id = setTimeout("get_wan_info()", 3000);
	}

	function send_request() {
		disable_all_btn(true);
		send_submit("form1");
	}

	function wz_cancel() {
		if(confirm(_setup_wizard_17)) {
			disable_all_btn(true);
			send_submit("form2");
		}
	}
	
//muilt-lang script

	function lang_set()
	{
		var str = '';
		var location_idx = '';
		var temp_cURL = document.URL.split('#');
		str += ("<div id=lang_menu class=langmenu style=position:absolute;>");			
		for(var i = 0,len = langArray.length; i<len; i+=j)
		{
			str += ("<div class=column>");
			str += ("<ul>");
			for (var j =0; j<8; j++)
			{
				location_idx = i+j+1;
				if ((i+j)<len){
					if ((i+j) == 20){
						i++;
						location_idx = i+j+1;
					}
					str += ("<li><a href='"+ temp_cURL[0] +"#"+ location_idx+"'onclick=lang_change('#"+location_idx+"')>"+langArray[(i+j)]+"</a></li>");
				}
			}
			str += ("<ul>");
			str += ("</div>");
		}
		str += ("</div>");
		$('#lang_menu_list').html(str);
	}
	function show_txtlang(br)
	{
		var num_index=parseInt(br);
		$('#tlang').val(langArray[num_index-1]);
	}
	function close_lang(clo){
		//clo 1:close  2:outside of lang_menu 3:inside of lang_menu
		if (clo==1){
			$('#lang_menu').hide();
			//$('#tlang').attr('disabled', false);
			imgclose=0;
		}
		else if(clo==2){
			close=-1;
		}
		else if(clo=3){
			close=1;
		}
	}
	$(document).click(function() { if(close==-1) close_lang(1);});
	function lang_change(Nlang)
	{
		var indexL =Nlang.split('#');
		var temp_cURL = document.URL.split('#');
		if (indexL.length>1)
		{
			Nlang = indexL[1];
			$('#curr_language').val(Nlang);
			if (indexL[1] != br_lang)
			{
				ajax_submit(Nlang);
				return;
			}
		}else if ((Nlang != br_lang) && (temp_cURL.length == 1))
		{
			ajax_submit(Nlang);
			return;
		}
	}
	function show_lang()
	{
		close=1;
		imgclose=1;
		//$('#tlang').attr('disabled', true);
		$('#lang_menu').show();
		$('#lang_menu').focus();
	}
	$(document).ready(function() {
		$('#lang_select').click(function() {
			if(imgclose==0)
				show_lang();
			else if(imgclose==1)
				close_lang(1);
		});
		
		$('#tlang').click(function() {
			if(imgclose==0)
				show_lang();
			else if(imgclose==1)
				close_lang(1);
		});

		$('#lang_menu').click(function(event) {
			close_lang(1);
		});
	});
	function chk_browser_lang()
	{
		check_browser();
		if (is_support == 2)	// ie only
			curr_lang = window.navigator.userLanguage;
		else	// other browser
			curr_lang = window.navigator.language;
		currLindex = lang_compare(curr_lang);
		if(currLindex!=br_lang){
			lang_change(currLindex);
		}
		return currLindex;
	}
	function lang_compare(tlang)
	{
		var lang;
		if(tlang.indexOf('en')==0)
				lang = '1';
		else if(tlang.indexOf('es')==0)
				lang = '2';
		else if(tlang.indexOf('de')==0)
				lang = '3';
		else if(tlang.indexOf('fr')==0)
				lang = '4';
		else if(tlang.indexOf('it')==0)
				lang = '5';
		else if(tlang.indexOf('ru')==0)
				lang = '6';
		else if(tlang.indexOf('pt-BR')==0)
				lang = '21';
		else if(tlang.indexOf('pt')==0)
				lang = '7';
		else if(tlang.indexOf('ja')==0)
				lang = '8';
		else if((tlang.indexOf('tw')!=-1) || (tlang.indexOf('TW')!=-1))
				lang = '9';
		else if((tlang.indexOf('cn')!=-1) || (tlang.indexOf('CN')!=-1))
				lang = '10';
		else if(tlang.indexOf('ko')==0)
				lang = '11';
		else if(tlang.indexOf('cs')==0)
				lang = '12';
		else if(tlang.indexOf('da')==0)
				lang = '13';
		else if(tlang.indexOf('el')==0)
				lang = '14';
		else if(tlang.indexOf('fi')==0)
				lang = '15';
		else if(tlang.indexOf('hr')==0)
				lang = '16';
		else if(tlang.indexOf('hu')==0)
				lang = '17';
		else if(tlang.indexOf('nl')==0)
				lang = '18';
		else if(tlang.indexOf('no')==0)
				lang = '19';
		else if(tlang.indexOf('pl')==0)
				lang = '20';
		else if(tlang.indexOf('ro')==0)
				lang = '22';
		else if(tlang.indexOf('sl')==0)
				lang = '23';
		else if(tlang.indexOf('sv')==0)
				lang = '24';
		else
				lang = '1';
		return lang;
	}


	function check_browser()	//chk support bookmark and lang
	{
		var isMSIE = (-[1,]) ? false : true;

		if(window.sidebar && window.sidebar.addPanel){ //Firefox
			is_support = 1;
		}else if (isMSIE && window.external) {  //IE favorite
			is_support = 2;
		}
		return is_support;
	}
	function ajax_submit(Nlang)
	{
		var temp_cURL = document.URL.split('#');
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	'apply_sec.cgi',
			data: 	'html_response_page=setup_wizard.asp&action=wizard_lang&changed=1&lang='+Nlang,
			success: function(data) {
				window.location.href = temp_cURL[0] +'#'+Nlang;
				window.location.reload(true);
			}
		};
		$.ajax(ajax_param);
	}
	var langArray = new Array('English','Español','Deutsch','Français','Italiano','Русский','Português',
							'日本語','繁體中文','简体中文','한국어','Česky','Dansk','Ελληνικά','Suomi',
							'Hrvatski','Magyar','Nederlands','Norsk','Polski','Português do Brasil',
							'Română','Slovenščina','Svenska');	
	
	
	
	
	
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
	<tr>
		<td bgcolor="#FFFFFF">
		<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
			<tr>
				<td bgcolor="#FFFFFF">
				<div align=center>
					<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
						<tr>
							<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
							<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
							<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
							<td>&nbsp;</td>
						</tr>
					</table>
					<!--<img src="/wlan_masthead.gif" width="836" height="92" align="middle">-->
					<table id="masthead_container" border="0" cellspacing="0">
						<tr>
							<td  background="/wlan_masthead.gif" width="834" height="92" align="middle" valign="bottom">
								<table id="table_lang_menu" align="right"cellspacing="0" cellpadding="0" border="0" style="">
								<td><strong><script>show_words(_Language)</script>&nbsp;:&nbsp;</strong></td>
								<td><input type="text" id="tlang" name="tlang" size="20" maxlength="15" value="" style=cursor:default onblur="close_lang(2);" readonly></td>
								<td><img src="/lang_button1.png" width="18" height="20" id="lang_select" name="lang_select"  onmouseover="close_lang(3);" onmouseout="close_lang(2);"></td>
								</table>
							</td>
						</tr>
						<tr>
							<td align="left" style=padding-left:437><form id='lang_menu_list' onmouseover="close_lang(3);" onmouseout="close_lang(2);"></form>
							</td>
						</tr>
					</table>
				</div></td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF"><p>&nbsp;</p>
		<table width="650" border="0" align="center">
			<tr>
				<td>
				<div class=box>
					<div id=w1>
						<div align="center"></div>
						<form id="form1" name="form1" method="post" action="apply_sec.cgi">
							<input type="hidden" name="html_response_page" id="html_response_page" value="setup_wizard_detect.asp">
							<input type="hidden" name="html_response_message" value="">
							<input type="hidden" name="html_response_return_page" value="setup_wizard_detect.asp">
							<input type="hidden" name="reboot_type" value="none">
							<input type="hidden" id="action" name="action" value="response_page">
							<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard.asp">
							<input type="hidden" id="wan_cable_status" name="wan_cable_status" value="">
							<!-- Welcome -->
							<div id="wz_setup" style="display:none">
								<h2 align="left"><script>show_words(_setup_wizard_1);</script></h2>
								<div align="left">
									<p class="box_msg"><script>show_words(_setup_wizard_2);</script></p>
									<table class=formarea>
										<tr>
											<td width="334" height="81">
											<UL>
												<LI><script>show_words(STEP1);show_words(": ");show_words(_setup_wizard_06);</script></LI>
												<LI><script>show_words(STEP2);show_words(": ");show_words(_setup_wizard_07);</script></LI>
												<LI><script>show_words(STEP3);show_words(": ");show_words(_setup_wizard_3);</script></LI>
												<LI><script>show_words(STEP4);show_words(": ");show_words(_setup_wizard_4);</script></LI>
												<LI><script>show_words(STEP5);show_words(": ");show_words(_setup_wizard_08);</script></LI>
												<LI><script>show_words(STEP6);show_words(": ");show_words(_setup_wizard_6);</script></LI>
											</UL>
											</td>
										</tr>
									</table>
								</div>
							</div><!-- wz_setup -->
							<!-- Welcome -->
							<br>
						</form>
						<form id="form2" name="form2" method="post" action="apply_sec.cgi">
							<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
							<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="login_pic.asp">
						</form>
						<table align="center" class="formarea">
							<tr>
								<td>
									<input type="button" class="button_submit" id="prev_b" name="prev_b" style="display:none" value="Prev" onclick="prev_page()">
									<input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wz_cancel()">
									<input type="button" class="button_submit" id="next_b2" name="next_b2" value="Next" onclick="send_request()">
                                    <script>
										get_by_id("prev_b").value = _prev;
										get_by_id("next_b2").value = _next;
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
</body>
<script>
	onPageLoad();	
	lang_set();
	show_txtlang(br_lang);
	chk_browser_lang();
</script>
</html>
