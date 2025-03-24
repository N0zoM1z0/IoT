<!doctype html>
<!--[if lt IE 7 ]>
<html class="ie6" lang="zh-cn"><![endif]-->
<!--[if IE 7 ]>
<html class="ie7" lang="zh-cn"><![endif]-->
<!--[if IE 8 ]>
<html class="ie8" lang="zh-cn"><![endif]-->
<!--[if IE 9 ]>
<html class="ie9" lang="zh-cn"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html class="w3c"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0" />
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT"/>
		<title></title>
		<link type="text/css" href="css/reset.css" rel="stylesheet"/>
		<link type="text/css" href="css/login.css" rel="stylesheet"/>
		<script type="text/javascript" src="admin/js/jquery.min.js"></script>
		<script type="text/javascript" src="admin/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="admin/js/new_lib.js"></script>
		<script type="text/javascript" src="admin/js/getinfo.js"></script>
		<script language=JavaScript>
			var browser = {
				versions: function() {
					var u = navigator.userAgent, app = navigator.appVersion;
					return {
						trident: u.indexOf('Trident') > -1, //IE内核 
						presto: u.indexOf('Presto') > -1, //opera内核 
						webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核 
						gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核 
						mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端 
						ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端 
						android: u.indexOf('Android') > -1, //android终端或uc浏览器 
						iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器 
						iPad: u.indexOf('iPad') > -1, //是否iPad 
						webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部 
					};
				}(),
				language: (navigator.browserLanguage || navigator.language).toLowerCase()
			}
			function getMobile() {
				var mob = 0;
				if (browser.versions.mobile || browser.versions.android || browser.versions.iPhone) {
					mob = 1;
				}
				return mob;
			}
		</script>	
	</head>
	<body>
		<div class="container">
			<div class="login-container">
				<div class="logo">
					<img src="" id="logo_img" width="230">
				</div>
				<form id="login_form" name="loginin" action="/login/auth" method="post">
					<input type="hidden" name="platform" value="0" id="platform"/>
					<input type="hidden" name="user" value="admin" id="user" />
					<div class="login-item">
						<div class="login-item-input" style="position: relative;">
							<input type="password" name="pass" id="login_pwd" maxlength="64"  onKeyDown="keydown(event)" />
							<img src="admin/images/pwd-icon2.png" alt="" id="loginPwd_icon" width="22">
						</div>
						<label id="loginPwd_tip" style="display: none;"></label>
					</div>
					<div class="login-item">
						<div class="login-button" id="loginin" onClick="gologin()"></div>
					</div>
				</form>
				<div class="forgetPwd">
					<span id="forgetPwd_show">
						<span id="forgetPwd"></span>
						<img src="admin/images/arrow-up.png" id="forgetPwd_arrow" width="22"> 
					</span>
				</div>
				<div class="forgetPwdTip" id="forgetPwdTip" style="display: none;">
					<p>
						> <span id="forgetPwdTip1"></span>
					</p>
					<p>
						> <span id="forgetPwdTip2"></span>
					</p>
				</div>
			</div>
			<div id="lock_div" style="display: none;">
				<div id="loadingbox">
					<img src="admin/images/loading.gif" />
					<p id="waitTips">...</p>
				</div>
			</div>
		</div>

		<script>
			var lang={
				'zhcn':{
					'B_Link':'必联路由器',
					'Select_Language':'选择语言',
					'welcome_info':'欢迎使用必联路由器',
					'wait':'登录中',
					'system_info1':'登录密码不能为空.',
					'Router_Login':'路由器登录',
					'username':'用户名',
					'Password':'登录密码',
					'Login':'登 录',
					'loginPwd_notNull':'请输入登录密码',
					'Cancel':'取消',
					'loginPwd_error':'密码错误',
					forgetPwd:'忘记密码',
					forgetPwdTip1:"忘记密码，您可以将路由器复位重置密码（路由器默认密码为admin）。",
					forgetPwdTip2:"方法：长按Reset键12秒后松开（此操作将还原路由器至出厂状态）。",
				},
				'en':{
					'B_Link':'LB-LINK Router',
					'Select_Language':'Select Language',
					'welcome_info':'Welcome to Use the LB-LINK Router',
					'wait':'Logging In',
					'system_info1':'Password cannot be empty.',
					'Router_Login':'Router Login',
					'username':'Username',
					'Password':'Password',
					'Login':'Login',
					'loginPwd_notNull':'Please enter the login password',
					'Cancel':'Cancel',
					'loginPwd_error':'Password Error',
					forgetPwd:'Forgot password',
					forgetPwdTip1:"If you forget the password, you can reset the router to reset the password (the default password of the router is admin).",
					forgetPwdTip2:"Method: Press and hold the Reset button for 12 seconds and release it (this operation will restore the router to the factory state).",
				}
		}
		var getLang=function(){
			var currentLang=navigator.language;   //判断除IE外其他浏览器使用语言
			if(!currentLang){//判断IE浏览器使用语言
				currentLang = navigator.browserLanguage;
			}
			function testIt(str){
				var pattern = /zh/;
				return pattern.test(str);
			}	
			if(testIt(currentLang)){
				curlang='zhcn';
				return curlang;
			}else{
				curlang='en';
				return curlang;
			}	
		}

		window.onload = function(){
			$("#login_pwd").focus();
			if(getMobile()==1){
				$("#platform").val("1");
				$.cookie('platform','1', { path: '/'});
			}else{
				$.cookie('platform','0', { path: '/'});
			}
			if(getLang()=='zhcn'){
				$('#logo_img').attr('src','admin/images/logo_zh.png');
			}else{
				$('#logo_img').attr('src','admin/images/logo_en.png');
			}
			var language = lang[getLang()];
			document.title = language.B_Link; 
			$("#slogan").html(language.welcome_info);
			$("#lbl_login_pwd").html(language.Password);
			$("#waitTips").html(language.wait);
			$('#login_pwd').attr("placeholder",language.loginPwd_notNull);
			$("#loginin").html(language.Login);
			$('#forgetPwd').html(language.forgetPwd+"?");
			$("#forgetPwdTip1").html(language.forgetPwdTip1);
			$("#forgetPwdTip2").html(language.forgetPwdTip2);
			geturl();
		}

		function gologin(){
			let data = {};
			let value = $('#login_form').serializeArray();
			$.each(value, function (index, item) {
            	data[item.name] = item.value;
       		});
			if(data.pass == ""){
				// $("#loginPwd_tip").show();
				// $("#loginPwd_tip").html(lang[getLang()].system_info1);

				alert(lang[getLang()].system_info1);
				return;
			}
			$('#login_form').submit();
			$("#lock_div").css("display","block");
			geturl();
		} 

		function geturl(){
			var plath=window.location.search;
			if(plath==""){
				return;
			}
			var buf=plath.split("?");
			if(buf.length>1){
				// $("#loginPwd_tip").show();
				// $("#loginPwd_tip").html(lang[getLang()].loginPwd_error);

				alert(lang[getLang()].loginPwd_error);
				window.location="login.asp";
			}		
		}

		function keydown(evt){
			var keyCode = evt.keyCode ? evt.keyCode : evt.which ? evt.which : evt.charCode;
			if (keyCode==13){
				gologin();
			}
		}

		$("#forgetPwd_show").click(function(){
			if($(this).find('#forgetPwd_arrow').attr('src')=="admin/images/arrow-up.png"){
				$('#forgetPwd_arrow').attr('src',"admin/images/arrow-down.png");
				$("#forgetPwdTip").css("display","block");
			}else{
				$('#forgetPwd_arrow').attr('src',"admin/images/arrow-up.png");
				$("#forgetPwdTip").css("display","none");
			}
		})

		$("#loginPwd_icon").click(function(){
			if($(this).attr('src')=="admin/images/pwd-icon2.png"){
				$(this).attr('src',"admin/images/pwd-icon.png");
				$("#login_pwd").attr('type',"text");
			}else{
				$(this).attr('src',"admin/images/pwd-icon2.png");
				$("#login_pwd").attr('type',"password");
			}
		})

		</script>
	</body>
</html>
