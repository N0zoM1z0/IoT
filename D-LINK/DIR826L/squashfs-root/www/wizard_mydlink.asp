<html> 
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<script>
	var funcWinOpen = window.open;
</script>
<style type="text/css">
/*
 * Styles used only on this page.
 * WAN mode radio buttons
 */
#wan_modes p {
	margin-bottom: 1px;
}
#wan_modes input {
	float: left;
	margin-right: 1em;
}
#wan_modes label.duple {
	float: none;
	width: auto;
	text-align: left;
}
body{ font-size:12px}
.langmenu{
position: absolute;
display: none;
background: white;
border: 1px solid #f06b24;
border-width: 3px 0px 3px 0px;
padding: 10px;
font: normal 12px Verdana;
z-index: 100;

}

.langmenu .column{
float: left;
width: 120px; /*width of each menu column*/
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
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk_w.js"></script>
<link rel="stylesheet" href="js/jquery-ui.css" type="text/css"/>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="Javascript" src="js/jquery-ui.min.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	var count_myd =0;
	document.title = get_words('TEXT000');
	var pageNameArray = new Array('p12', 'p13','p13', 'p13a','p13b','p14', 'Unknown');
	var nextPageArray = new Array('p13','p13a','p13b', 'p14','p14','p14','Unknown');
	
	var langArray = new Array('English','Español','Deutsch','Français','Italiano','Русский','Português',
							'日本語','繁體中文','简体中文','한국어','Česky','Dansk','Ελληνικά','Suomi',
							'Hrvatski','Magyar','Nederlands','Norsk','Polski','Português do Brasil',
							'Română','Slovenščina','Svenska');
							
	var historyArray = new Array(20);//p10 3 12
	var historyIdx   = 0;
	var wz_curr_page = 0;
	var is_support = 0;
	var action = 0;	//0=>signup, 1=>signin, 2=>adddev
	var curr_lang = '';
	var currLindex  = '';
	var close=0;
	var imgclose=0;

	var param = {
		url: "get_set.ccp",
		arg: "ccp_act=get&num_inst=6"+
			'&oid_1=IGD_MyDLink_&inst_1=11000'+
			'&oid_2=IGD_&inst_2=10000'+
			'&oid_3=IGD_WANDevice_i_WANConnectionDevice_i_&inst_3=11100'+
			'&oid_4=IGD_WANDevice_i_WANConnectionDevice_i_PPPoE_i_&inst_4=11110'+
			'&oid_5=IGD_WANDevice_i_WANConnectionDevice_i_L2TP_i_ConnectionCfg_i_&inst_5=11111'+
			'&oid_6=IGD_WANDevice_i_WANConnectionDevice_i_PPTP_i_ConnectionCfg_i_&inst_6=11111'
	};
	get_config_obj(param);
	
	var isReg = (config_val("igd_Register_st_")? config_val("igd_Register_st_"):"");
	var br_lang = config_val('igd_CurrentLanguage_')? config_val('igd_CurrentLanguage_'):"0";
	var conn_type = config_val("wanConnDev_CurrentConnObjType_"); 
	var conn_mode = {
		'poe':	config_val("pppoeCfg_ConnectionTrigger_"),
		'l2tp':	config_val("l2tpConn_ConnectionTrigger_"),
		'pptp':	config_val("pptpConn_ConnectionTrigger_")
	}
	
	var ddnsCfg = {
		'account':	config_val("igdMyDLink_EmailAccount_"),
		'pass':		config_val("igdMyDLink_AccountPassword_"),
		'lastName':	config_val('igdMyDLink_LastName_'),
		'firstName': config_val('igdMyDLink_FirstName_')
	}

	function chk_browser_lang()
	{
		check_browser();
		if (is_support == 2)	// ie only
			curr_lang = window.navigator.userLanguage;
		else	// other browser
			curr_lang = window.navigator.language;

		currLindex = lang_compare(curr_lang);
		lang_change(currLindex);
		return currLindex;
	}
	
	function onPageload()
	{
		if (isReg == 1)
			location.replace('index.asp');
		chk_browser_lang();
		if (ddnsCfg.account)
		{
			$('#email_addra').val(ddnsCfg.account);
			$('#email_addr').val(ddnsCfg.account);
			$('#pass').val(ddnsCfg.pass);
			$('#passwd').val(ddnsCfg.pass);
			$('#pass_chk').val(ddnsCfg.pass);
			$('#lname').val(ddnsCfg.lastName);
			$('#fname').val(ddnsCfg.firstName);
			set_checked('yes', get_by_name("mdl_reg"));
		}
	}

	function OpenWindow(){
		funcWinOpen('goto_mydlink.asp',"",'location=1, resizable=1, scrollbars=1, top=0, left=0, height='+((screen.availHeight)-10)+',width='+((screen.availWidth)-10));
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
	
	function termsOfUse_page(){
		var lang = termsOfUse_link();
		var langlink = "http://eu.mydlink.com/termsOfUse?lang="+lang+"#";
		$('a#language_link').attr('href', langlink);
	}
	
	function mydlink_reg(param)
	{
		if (param == null || param.url == null)
			return;
		
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	param.url,
			data: 	param.arg+"&"+time+"="+time,
			success: function(data) {
				switch(action)
				{
					case 0:	//signup
					{
						$('#next_b_p14').attr('disabled','');
						$('#next_b_p13a').attr('disabled','');
						$('#next_b_p13b').attr('disabled','');
						if (data.indexOf('success') != -1)
						{
							send_request(3); //next_page();
							break;
						}
					}
					if(get_words(data)==null)
						alert(data);
					else
						alert(get_words(data));
					break;
					
					case 1:	//signin
						$('#next_b_p14').attr('disabled','');
						$('#next_b_p13a').attr('disabled','');
						$('#next_b_p13b').attr('disabled','');
						if (data.indexOf('success') != -1)
						{
							var paramStr={
								'url': 	'mdl_check.ccp',
								'arg': 	'act=adddev'
							};
							action = 2;
							mydlink_reg(paramStr);
							break;
						}
						if(get_words(data)==null)
							alert(data);
						else
							alert(get_words(data));
					break;
					
					case 2:	//adddev
						$('#next_b_p14').attr('disabled',true);
						$('#next_b_p13a').attr('disabled',true);
						$('#next_b_p13b').attr('disabled',true);
						if (data.indexOf(':'+dev_info.model) != -1)
						{
							alert(get_words('mydlink_pop_05'));
							
							var paramStr={
								'url': 	'easy_setup.ccp',
								'arg': 	'ccp_act=set'
							};
							if (conn_type == 2)
								paramStr.arg += '&pppoeCfg_ConnectionTrigger_1.1.1.1.0=0';
							if (conn_type == 3)
								paramStr.arg += '&pptpConn_ConnectionTrigger_1.1.1.1.1=0';
							if (conn_type == 4)
								paramStr.arg += '&l2tpConn_ConnectionTrigger_1.1.1.1.1=0';
							paramStr.arg += '&igdMyDLink_PushEventEnable_1.1.0.0.0=1';
							paramStr.arg += '&igd_AlreadyConfiguration_1.0.0.0.0=1&ccpSubEvent=CCP_SUB_WAN';	//Jerry, add sub event
							get_config_obj(paramStr);

							get_conn_st_mydlink();
							//OpenWindow();
							//location.replace('http://www.mydlink.com/entrance');
							break;
						}

						if (data.indexOf(']') == -1)
							alert(get_words(data));
						else
						{
							data = data.split(']');
							alert(data[1]);
						}
						$('#next_b_p14').attr('disabled',false);
						$('#next_b_p13a').attr('disabled',false);
						$('#next_b_p13b').attr('disabled',false);
					break;
				}
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
			//setTimeout(function() {
				$.ajax(ajax_param);
			//}, 0);
		} catch (e) {
		}	
	}
	
	function mydlink_save(param)
	{
		if (param == null || param.url == null)
			return;
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	param.url,
			data: 	param.arg+"&"+time+"="+time,
			success: function(data) {
			},
			error: function(xhr, ajaxOptions, thrownError){
			}
		};
		
		try {
			//setTimeout(function() {
				$.ajax(ajax_param);
			//}, 0);
		} catch (e) {
		}
	}

	/**
	 * vals: 1 => signin, 2 => signup
	 */
	function send_request(vals)
	{
		if (vals == 1)
		{
			if(verify_wz_page_p13a() == false)
				return false;
			$('#next_b_p13a').attr('disabled',true);
		}else{
			if (vals == 3)
				$('#next_b_p14').attr('disabled',true);
		}
		submit_regist(vals);
		return true;
	}

	function submit_regist(val)	//save data 
	{
		var paramStr={
			'url': 	'get_set.ccp',
			'arg': 	'ccp_act=set&ccpSubEvent=CCP_SUB_MYDLINK&nextPage=wizard_mydlink.asp'
		};

		if (val == 1)
		{
			paramStr.arg += '&igdMyDLink_EmailAccount_1.1.1.0.0='+$('#email_addra').val();
			paramStr.arg += '&igdMyDLink_AccountPassword_1.1.1.0.0='+urlencode($('#pass').val());
		}

		if (val == 2)
		{
			paramStr.arg += '&igdMyDLink_EmailAccount_1.1.1.0.0='+$('#email_addr').val();
			paramStr.arg += '&igdMyDLink_AccountPassword_1.1.1.0.0='+urlencode($('#passwd').val());
			paramStr.arg += '&igdMyDLink_LastName_1.1.1.0.0='+urlencode($('#lname').val());
			paramStr.arg += '&igdMyDLink_FirstName_1.1.1.0.0='+urlencode($('#fname').val());
		}
		if (val != 3)
			mydlink_save(paramStr);
		
		paramStr.url = 'mdl_check.ccp';
		if ((val == 1) || (val == 3))	//signin	登入
		{
			paramStr.arg = 'act=signin';
			action = 1;
		}
		else if (val == 2)		//signup	註冊
		{
			paramStr.arg = 'act=signup';
			action = 0;
		}
		mydlink_reg(paramStr);
	}

	function displayPage(page)
	{
		for(var i=0; i < pageNameArray.length; i++)
		{
			if (pageNameArray[i] == 'Unknown')
				break;

			if(pageNameArray[i] == page)
			{
				get_by_id(pageNameArray[i]).style.display = "";
				if (pageNameArray[i] == 'p13')
				{

					if (get_checked_value(get_by_name('mdl_reg')) == 'no')
					{
						next_page(findIndexOfArrayByValue(pageNameArray, 'p13b'));
					} else if (get_checked_value(get_by_name('mdl_reg')) == 'yes')
					{
						next_page(findIndexOfArrayByValue(pageNameArray, 'p13a'));
					}
					break;
				}
			}
			else
				get_by_id(pageNameArray[i]).style.display = "none";
		}
	}
	

	function findIndexOfArrayByValue(array, value)
	{
		for (var i=0; i<array.length; i++)
		{
			if(array[i] == value)
				return i;
		}
		return -1;
	}

	function next_page(page_idx)
	{
		historyArray[historyIdx++] = wz_curr_page;
		
		if (wz_curr_page != 0)
		{
			try {
				if (pageNameArray[wz_curr_page] != 'p13b')
				{
					if(eval("verify_wz_page_"+pageNameArray[wz_curr_page])() == false) {
						historyIdx--;
						return;
					}
				}
			} catch (e) {
				// the verify function is not exist
			}
		}
		
		if (page_idx != null)
			wz_curr_page = page_idx;
		else
			wz_curr_page = findIndexOfArrayByValue(pageNameArray, nextPageArray[wz_curr_page]);

		displayPage(pageNameArray[wz_curr_page]);
	}

	function verify_wz_page_p13b()
	{
		var showword = ' '+get_words('mydlink_pop_03');
		var mailaddr = $('#email_addr').val();

		if (mailaddr == ''){
			alert(get_words('mydlink_tx09')+showword);
			return false;
		}

		if (!mail_addr_test(mailaddr))
		{
			alert(get_words('mydlink_tx09')+' "'+ mailaddr+'" '+get_words('mydlink_pop_04'));
			return false;
		}

		if ($('#passwd').val() == ''){
			alert(get_words('_password')+showword);
			return false;
		}

		if (is_ascii($('#passwd').val()) == false)
		{
			alert(get_words('S493'));
			return false;
		}

		if ($('#passwd').val() != $('#pass_chk').val()){
			alert(get_words('_pwsame'));
			return false;
		}

		if ($('#passwd').val().length <= '5'){
			alert(get_words('limit_pass_msg'));
			return false;
		}

		if ($('#lname').val() == ''){
			alert(get_words('Lname')+showword);
			return false;
		}

		if ($('#fname').val() == ''){
			alert(get_words('Fname')+showword);
			return false;
		}

		if (get_checked_value($('#mdl_caption')[0]) == 0)
		{
			alert(get_words('mydlink_pop_02'));
			return false;
		}
		submit_regist(2);
		return true;	
	}

	function verify_wz_page_p13a()
	{
		var showword = ' '+get_words('mydlink_pop_03');
		var mailaddr = $('#email_addra').val();

		if (mailaddr == ''){
			alert(get_words('mydlink_tx09')+showword);
			return false;
		}

		if (!mail_addr_test(mailaddr))
		{
			alert(get_words('mydlink_tx09')+' "'+ mailaddr+'" '+get_words('mydlink_pop_04'));
			return false;
		}

		if ($('#pass').val() == ''){
			alert(get_words('_password')+showword);
			return false;
		}
		return true;
	}
	
	//20120530 pascal add
	function get_conn_st_mydlink()
	{
		var conn_st = query_wan_connection();
		if(conn_st == "true")
			get_wan_st_mydlink();
		else
			setTimeout('get_conn_st_mydlink()',500);
	}
	
	//20120530 pascal add
	function get_wan_st_mydlink()
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
					count_myd++;
					if ((count_myd % 2) ==0)
						do_fakeping();
					setTimeout('get_wan_st_mydlink()', 1000);
				}
				else{
					setTimeout('location.replace(\'http://www.mydlink.com\')', 1000*2);
				}
			}
		};
		try {
				$.ajax(ajax_param);
		} catch (e) {
		}
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
	
	function prev_page_mld(idx)
	{
		displayPage('idx');
		get_by_id('p12').style.display = "";
		wz_curr_page = 0;
		historyIdx--;
	}

	function mail_addr_test(str)
	{
		var rlt = 0;	
		var tmp = str.split("@");
		try{
	        if(tmp.length == 2 && /^([+]?)*([a-zA-Z0-9]*[_|\-|\.|\+|\%|\*|\?|\!|\\]?)*[a-zA-Z0-9]*([+]?)+$/.test(tmp[0]) && /^([a-zA-Z0-9]*[_|\-|\.|\+|\%|\*|\?|\!|\\]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,6}$/.test(tmp[1])){
	            rlt = 1
	        }
		}catch(e){}
		return rlt;
	}
	
	function copy_field(src, dst)
	{
		$('#'+dst).val($('#'+src).val());
	}

	function no_timeout()
	{
		get_config_obj(param);
		setInterval(no_timeout, 120000);
	}
	
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
	
	function show_lang()
	{
		close=1;
		imgclose=1;
		//$('#tlang').attr('disabled', true);
		$('#lang_menu').show();
		$('#lang_menu').focus();
	}
	
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
	
	function ajax_submit(Nlang)
	{
		var time=new Date().getTime();
		var temp_cURL = document.URL.split('#');
		var ajax_param = {
			type: 	"POST",
			async:	false,
			url: 	'curr_lang.ccp',
			data: 	'ccp_act=set&ccpSubEvent=CCP_SUB_WIZARDPOPCTRL&curr_language='+Nlang+
					'&igd_CurrentLanguage_1.0.0.0.0='+Nlang+"&"+time+"="+time,
			success: function(data) {
				window.location.href = temp_cURL[0] +'#'+Nlang;
				window.location.reload(true);
			}
		};
		$.ajax(ajax_param);
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

/*
	function pop()
	{
		alert(get_words('mydlink_pop_09'));
	}
*/
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
					<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
					<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
					<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<tr>
			<td background="wlan_masthead.gif" width="836" height="92" align="right" valign="bottom" style=padding:5>
			<table cellspacing="0" cellpadding="0" border="0">
				<td><strong><script>show_words(_Language)</script>&nbsp;:&nbsp;</strong></td>
				<td><input type="text" id="tlang" name="tlang" size="20" maxlength="15" value="" style=cursor:default onblur="close_lang(2);" readonly></td>
				<td><img src="lang_button1.png" width="18" height="20" id="lang_select" name="lang_select"  onmouseover="close_lang(3);" onmouseout="close_lang(2);"></td>

			</table>
			</td>
			</tr>
			</div>
			</td>
			<td  style=padding-left:437><form id='lang_menu_list' onmouseover="close_lang(3);" onmouseout="close_lang(2);"></form>
			</td>			
		</tr>
	</table>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF">
	<p>&nbsp;</p>
	<table width="650" border="0" align="center">
	<tr>
		<td>
		<form id="formAll" name="formAll">

<!-------------------------------->
<!--      Start of page 12(mydlink)     -->
<!-------------------------------->
		<div class=box id="p12" style="display:none"> 
		<h2 align="left"><script>show_words(ES_title_s6_myd)</script></h2>
		<p class="box_msg">
			<script>show_words(mydlink_reg_into_1)</script>
			<script>show_words(mydlink_reg_into_2)</script>
			<script>show_words(mydlink_reg_into_3)</script>
			<script>show_words(mydlink_reg_into_4)</script>
		</p>
			<table  align="center" class=formarea>
				<tr height="24">
					<td width="10%"></td>
					<td><script>show_words(mydlink_tx06)</script></td>
				</tr>
				<tr height="24">
					<td></td>
					<td>
						<input type="radio" id="mdl_reg" name="mdl_reg" value="yes">
						<script>show_words(mydlink_tx07)</script>
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td>
						<input type="radio" id="mdl_reg" name="mdl_reg" value="no" checked>
						<script>show_words(mydlink_tx08)</script>
					</td>
				</tr>
				</table><br>
				
				<table align="center" class=formarea>
				<tr>
					<td></td>
					<td>     
						<input type="button" class="button_submit" id="next_b_p12" name="next_b_p12" value="" onClick="next_page()">
						<input type="button" class="button_submit" id="cancel_b_p12" name="cancel_b_p12" value="" onclick="location.replace('mydlink.asp');"> 
						<script>$('#next_b_p12').val(get_words('_next'));</script>
						<script>$('#cancel_b_p12').val(get_words('_cancel'));</script>
			</td>
		</tr>
		</table>
		</div>
<!-------------------------------->
<!--       End of page 12       -->
<!-------------------------------->
		<div id="p13" style="display:none">
		</div>
<!-------------------------------->
<!--      Start of page 13a       -->
<!-------------------------------->
		<div class=box id="p13a" style="display:none"> 
		<h2 align="left"><script>show_words(ES_title_s6_myd)</script></h2>
			<table class=formarea>
				<tr height="24"><br>
					<td width="15%"></td>
					<td width="40%"><div align="right"><script>show_words(mydlink_tx09)</script>:&nbsp;</div></td>
					<td width="45%">
						<input type="text" id="email_addra" name="email_addra" value="" tabindex="120" onchange="copy_field('email_addra', 'email_addr')">
					</td>
				</tr>
				<tr height="24"><br>
					<td></td>
					<td><div align="right"><script>show_words(_password)</script>:&nbsp;</div></td>
					<td>
						<input type="password" id="pass" name="pass" value="" tabindex="120" onchange="copy_field('pass', 'passwd')">
					</td>
				</tr>
				</table><br>
				
				<table align="center" class=formarea>
				<tr>
					<td></td>
					<td>     
						<input type="button" class="button_submit" id="wz_prev_b_p13a" name="wz_prev_b_p13a" value="" onclick="prev_page_mld(p13a);"> 
						<input type="button" class="button_submit" id="next_b_p13a" name="next_b_p13a" value="" onClick="return send_request(1);">
						<input type="button" class="button_submit" id="cancel_b_p13a" name="cancel_b_p13a" value="" onclick="location.replace('mydlink.asp');"> 
						<script>$('#wz_prev_b_p13a').val(get_words('_prev'));</script>
						<script>$('#next_b_p13a').val(get_words('_login'));</script>
						<script>$('#cancel_b_p13a').val(get_words('_cancel'));</script>
					</td>
				</tr>
				</table>
		</div>
<!-------------------------------->
<!--       End of page 13a       -->
<!-------------------------------->
<!-------------------------------->
<!--      Start of page 13b       -->
<!-------------------------------->
		<div class=box id="p13b" style="display:none"> 
		<h2 align="left"><script>show_words(ES_title_s6_myd)</script></h2>
		<center><p class="box_msg"><script>show_words(mydlink_tx10)</script></p></center>
			<table class=formarea>
				<tr height="24"><br>
					<td width="8%"></td>
					<td width="40%"><div align="right"><script>show_words(mydlink_tx09)</script>&nbsp;:&nbsp</div></td>
					<td width="52%">
						<input type="text" id="email_addr" name="email_addr" value="" tabindex="120" onchange="copy_field('email_addr', 'email_addra')">
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td><div align="right"><script>show_words(_password)</script>&nbsp;:&nbsp;</div></td>
					<td>
						<input type="password" id="passwd" name="passwd" value="" tabindex="120" onchange="copy_field('passwd', 'pass')">
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td><div align="right"><script>show_words(chk_pass)</script>&nbsp;:&nbsp;</div></td>
					<td>
						<input type="password" id="pass_chk" name="pass_chk" value="" tabindex="120">
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td><div align="right"><script>show_words(Fname)</script>&nbsp;:&nbsp;</div></td>
					<td>
						<input type="text" id="fname" name="fname" value="" tabindex="120">
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td><div align="right"><script>show_words(Lname)</script>&nbsp;:&nbsp;</div></td>
					<td>
						<input type="text" id="lname" name="lname" value="" tabindex="120">
					</td>
				</tr>
				<tr height="24">
					<td></td>
					<td><div align="right">
						<input type="checkbox" id="mdl_caption" name="mdl_caption" value="1"></div></td>
					<td>
						<a id="language_link" href="" onclick="termsOfUse_page()"; target='_blank'>
						<script>show_words(mydlink_tx12)</script></a>
					</td>
				</tr>
				</table><br>
				
				<table align="center" class=formarea>
				<tr>
					<td></td>
					<td>
						<input type="button" class="button_submit" id="wz_prev_b_p13b" name="wz_prev_b_p13b" value="" onclick="prev_page_mld(p13b);"> 
						<input type="button" class="button_submit" id="next_b_p13b" name="next_b_p13b" value="" onClick="verify_wz_page_p13b();">
						<input type="button" class="button_submit" id="cancel_b_p13b" name="cancel_b_p13b" value="" onclick="location.replace('mydlink.asp');"> 
						<script>$('#wz_prev_b_p13b').val(get_words('_prev'));</script>
						<script>$('#next_b_p13b').val(get_words('_signup'));</script>
						<script>$('#cancel_b_p13b').val(get_words('_cancel'));</script>
					</td>
				</tr>
				</table>

		</div>
<!-------------------------------->
<!--       End of page 13b       -->
<!-------------------------------->
<!-------------------------------->
<!--      Start of page 14 (mydlink_finsh)       -->
<!-------------------------------->
		<div class=box id="p14" style="display:none"> 
		<h2 align="left"><script>show_words(ES_title_s6_myd)</script></h2>
		<p class="box_msg">
			<script>show_words(mydlink_tx13_1)</script>
			<script>show_words(mydlink_tx13_2)</script>
		</p>
		<br><br>
				<table align="center" class=formarea>
				<tr>
					<td></td>
					<td>     
						<input type="button" class="button_submit" id="next_b_p14" name="next_b_p14" value="" onClick="return send_request(3)">
						<input type="button" class="button_submit" id="cancel_b_p14" name="cancel_b_p14" value="" onclick="location.replace('mydlink.asp');"> 
						<script>$('#next_b_p14').val(get_words('_login'));</script>
						<script>$('#cancel_b_p14').val(get_words('_cancel'));</script>
					</td>
				</tr>
				</table>

		</div>
<!-------------------------------->
<!--       End of page 14       -->
<!-------------------------------->

		</form>
		</td>
	</tr>
	</table>
	<p>&nbsp;</p>
	</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
		<td width="125" align="center">&nbsp;<img src="wireless_tail.gif"></td>
		<td width="10">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
    </tr>
	</table></td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	set_form_default_values("formAll");
	onPageload();
	displayPage("p12");
	no_timeout();
	lang_set();
	show_txtlang(br_lang);

//20120430 ignored by silvia
/*
if (((conn_type ==2) && (conn_mode.poe ==2)) ||
	((conn_type ==3) && (conn_mode.pptp==2)) ||
	((conn_type ==4) && (conn_mode.l2tp ==2)))
		setTimeout('pop()',100);
*/
</script>
</html>