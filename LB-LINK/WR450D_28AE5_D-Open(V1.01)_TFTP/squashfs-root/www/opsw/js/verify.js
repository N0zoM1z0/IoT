// function checkSsid(a) { //校验wifi名
// 	var reg = /^(([a-zA-Z])|(\d)|([~!@#$%^&\-_*])|([\u4e00-\u9fa5]))+$/;
// 	if (a.indexOf(" ") != -1 || a.length < 1 || a.length > 32 || !reg.test(a)) return false;
// 	return true;
// }

// function checkPassword(a) { //校验wifi密码
// 	var reg = /^(([a-zA-Z])|(\d)|([~!@#$%^&\-_*]))+$/;
// 	if (a.indexOf(" ") != -1 || a.length < 8 || a.length > 32 || !reg.test(a)) return false;
// 	return true;
// }

function checkSsid(a) { //校验wifi名
	if (a.length < 1 || a.length > 32) return false;
	var reg = /[^\u4E00-\u9FA5]/;
	for (var i = 0; i < a.length; i++) {
		if (!reg.test(a[i])) return false;
	}
	var str = "'\"\\";
	for (var i = 0; i < str.length; i++) {
	   if(a.indexOf(str[i]) != -1) return false;
	}
	return true;
}

function checkPassword(a) { //校验wifi密码
	if (a.length < 8 || a.length > 64) return false;
	var reg = /[^\u4E00-\u9FA5]/;
	for (var i = 0; i < a.length; i++) {
		if (!reg.test(a[i])) return false;
	}
	var str = "'\"\\";
	for (var i = 0; i < str.length; i++) {
	   if(a.indexOf(str[i]) != -1) return false;
	}
	return true;
}

function checkStr(a){  //校验类似username的字符串
	var reg = /[^\u4E00-\u9FA5]/;
	for (var i = 0; i < a.length; i++) {
		if (!reg.test(a[i])) return false;
	}
	var str = "'\"\\";
	for (var i = 0; i < str.length; i++) {
	   if(a.indexOf(str[i]) != -1) return false;
	}
	if (a.length < 1) return false;
	return true;
}

function checkLoginPwd(a) { //校验登录密码
	if (!a) return false;
	var reg =
		/^(?![a-z]+$)(?![0-9]+$)(?![a-z0-9 ]+$)(?![a-z\W_!@#$%^&*`~()-+= ]+$)(?![0-9\W_!@#$%^&*`~()-+= ]+$)[a-zA-Z0-9!@#$%^&*()-_.]{8,32}$/gi;
	return reg.test(a) ? false : true;
}

function checkIp(ip) { //ip校验 | 网关校验 | dns校验
	var reg =
		/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if (reg.test(ip)) {
		if (ip.split('.')[3] == '0' || ip.split('.')[3] == '255') {
			return false;
		}
		return true;
	} else {
		return false;
	}
}

function checkNetwork(network){
	var reg =
		/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if(!reg.test(network)) return false;
	return true;
}

function checkMask(mask) { //子网掩码校验
	var reg =
		/^(254|252|248|240|224|192|128|0)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0\.0|255\.255\.(254|252|248|240|224|192|128|0)\.0|255\.255\.255\.(254|252|248|240|224|192|128|0)$/;
	return reg.test(mask) ? true : false;
}

function checkRouteMask(mask) {
	var reg =
		/^(254|252|248|240|224|192|128|0)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0\.0|255\.255\.(254|252|248|240|224|192|128|0)\.0|255\.255\.255\.(255|254|252|248|240|224|192|128|0)$/;
	return reg.test(mask) ? true : false;
}

function checkMac(mac) { //mac地址校验
	var reg = /^[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}$/;
	return reg.test(mac) ? true : false;
}

function checkMtu(a) { //校验MTU值
	if (typeof(a) != 'number' || !a) return false;
	return true;
}

function checkPppoeUsername(a) { //校验pppoe用户名
	var reg1 = /^[\u4e00-\u9fa5]{0,}$/;
	var reg2 = "`~+={}[];:' \"|\\<>,/?";
	if (!a.length) return false;
	for (var i = 0; i < reg1.length; i++) {
		if (reg1.test(a[i])) return false;
	}
	for (var j = 0; j < reg2.length; j++) {
		if (a.indexOf(reg2[j]) != -1) return false;
	}
	return true;
}

function checkPppoePwd(a) { //校验pppoe密码
	var reg1 = /^[\u4e00-\u9fa5]{0,}$/;
	var reg2 = "`~+={}[];:'\"|\\<>,/?";
	if (!a.length) return false;
	for (var i = 0; i < reg1.length; i++) {
		if (reg1.test(a[i])) return false;
	}
	for (var j = 0; j < reg2.length; j++) {
		if (a.indexOf(reg2[j]) != -1) return false;
	}
	return true;
}

function checkAlias(a) { //校验防火墙/静态路由等的名字
	if (!a || a.indexOf(" ") != -1) return false;
	return true;
}

function checkUrl(a) { //校验url
	// var reg = /^((https|http|ftp|rtsp|mms){0,1}(:\/\/){0,1})www\.(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/i;
	var reg = /^((https|http|ftp|rtsp|mms){0,1}(:\/\/){0,1})(www\.){0,1}(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/i;
	if (reg.test(a)) return true;
	return false;
}

function checkServer(sUrl) { //校验域名
	var sRegex = '^((https|http|ftp|rtsp|mms)?://)' + '?(([0-9a-z_!~*\'().&=+$%-]+: )?[0-9a-z_!~*\'().&=+$%-]+@)?' //ftp的user@ 
		+
		'(([0-9]{1,3}.){3}[0-9]{1,3}' // IP形式的URL- 199.194.52.184 
		+
		'|' // 允许IP和DOMAIN（域名） 
		+
		'([0-9a-zA-Z_!~*\'()-]+.)*' // 域名- www. 
		+
		'([0-9a-zA-Z][0-9a-z-]{0,61})?[0-9a-zA-Z].' // 二级域名 
		+
		'[a-zA-Z]{2,6})' // first level domain- .com or .museum 
		+
		'(:[0-9]{1,4})?' // 端口- :80 
		+
		'((/?)|' // a slash isn't required if there is no file name 
		+
		'(/[0-9a-z_!~*\'().;?:@&=+$,%#-]+)+/?)$';
	var re = new RegExp(sRegex);
	if (re.test(sUrl)) {
		return true;
	}
	return false;
}

function checkPort(a) {
	var numRangLen = a.split('.').length;
	if (numRangLen > 1) {
		return false;
	} else {
		if (a < 1 || a > 65535) return false;
	}
	return true;
}

function checkInteger(a) { //校验正整数
	var numRangLen = a.split('.').length;
	if (numRangLen > 1) {
		return false;
	} else {
		if (a < 1) return false;
	}
	return true;
}
