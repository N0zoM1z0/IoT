function checkSsid(a) {
	if(typeof a !='string') return false;
	var str = a.trim();
	if(!str) return false;
	if (getCNStrLen(str) > 32) return false;
	return true;
}

function checkPassword(a) { //校验wifi密码
	if(typeof a !='string') return false;
	var str = a.trim();
	if (/\W/g.test(str)) return false;
	if (getCNStrLen(str) < 8 || getCNStrLen(str) > 64) return false;
	return true;
}

function getCNStrLen(a) { //获取字节数
    return a.replace(/[^\x00-\xFF]/g, 'xxx').length;
  }

// function isHaveChina(str) {  //是否包含中文及中文字符
// 	if (escape(str).indexOf("%u") < 0) {
// 		return false;
// 	} else {
// 		return true;
// 	}
// }

function checkLoginPwd(a) { //校验登录密码
	var reg = /^(([a-zA-Z])|(\d)|([~!@#\$%\^&\*()\-_+=]))+$/;
	if (!reg.test(a) || a.length > 64 || a.length < 8) return false;
	return true;
}

function checkIp(ip) { //ip校验 | 网关校验 | dns校验
	var reg =
		/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	if(!reg.test(ip)) return false;
	if (ip.split('.')[3] == '0' || ip.split('.')[3] == '255') return false;
	return true;
}
function checkStaticIp(ip){ //静态ip校验
	var ipRangle = ip.split('.');
	var reg =
		/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/; 
	if(!reg.test(ip)) return false;
	if (parseInt(ipRangle[0]) == 0 || parseInt(ipRangle[0]) == 224 || parseInt(ipRangle[0]) == 225 || parseInt(ipRangle[
			3]) == 0 || parseInt(ipRangle[3]) == 255 ||
	(parseInt(ipRangle[0])==127 && parseInt(ipRangle[3])==127)) return false;
	return true;
}

function checkMask(mask) { //子网掩码校验
	// var reg = /^((128|192)|2(24|4[08]|5[245]))(\.(0|(128|192)|2((24)|(4[08])|(5[245])))){3}$/;
	var reg = /^(254|252|248|240|224|192|128|0).0.0.0|255.(254|252|248|240|224|192|128|0).0.0|255.255.(254|252|248|240|224|192|128|0).0|255.255.255.(254|252|248|240|224|192|128|0)$/;
	// if (mask == '0.0.0.0'||mask=='255.255.255.255'||mask=='255.0.255.0') return false;
	return reg.test(mask) ? true : false;
}

function checkRouteMask(mask) {
	var reg =
		/^(254|252|248|240|224|192|128|0)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0\.0|255\.255\.(254|252|248|240|224|192|128|0)\.0|255\.255\.255\.(255|254|252|248|240|224|192|128|0)$/;
	return reg.test(mask) ? true : false;
}

function checkMac(a) { //mac地址校验
	if(!a) return false;
	var mac = a.toLowerCase();
	var macRangle = mac.split(':');
	var reg = /^[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}:[A-Fa-f\d]{2}$/;
	if(macRangle[5] == "00" || macRangle[1] == "ff" || !reg.test(mac)) return false;
	if(mac=='ff:ff:ff:ff:ff:ff'||mac=='00:00:00:00:00:00'|| mac=='11:11:11:11:11:11') return false;
	return true;
}
 
// 是否是组播mac
function isMulticastMac(mac) {
    if (!checkMac(mac)) return false;
    var h = parseInt(mac.slice(0, 2), 16); //前2个字符串，转16进制
    var b = h.toString(2); // 16转2进制
    return b % 2 === 1;
}

function checkMtu(a) { //校验MTU值
	if (!checkNum(a) || Number(a) < 576 || Number(a) > 1492) return false;
	return true;
}

function checkChinese(a) { //校验中文
	var reg = /[\u4e00-\u9fa5]/;
	if (reg.test(a)) return false;
	return true;
}

function checkNum(a) { //校验整数
	var reg = /^[0-9]\d*$/;
	if (!reg.test(a)) return false;
	return true;
}
function checkPositiveInteger(a) { //校验正整数
	var reg = /^[1-9]\d*$/;
	if (!reg.test(a)) return false;
	return true;
}

function checkPPPOEName(a) { //校验pppoe用户名
	if (!a || a.length>64) return false;
	return true;
}

function checkPPPOEPwd(a) { //校验pppoe密码
	if (!a || a.length>64) return false;
	return true;
}

function checkAlias(a) { //校验别名
	if(!a) return false;
	var reg = /[\u4e00-\u9fa5]/;
	var strLength = 0;
	for (var i = 0; i < a.length; i++) {
		if (reg.test(a.charAt(i))) {
			strLength += 4;
		} else {
			strLength++;
		}
	}
	if (strLength > 64) return false;
	return true;
}

function checkUrl(a) { //校验url
	// var reg = /^((https|http|ftp|rtsp|mms){0,1}(:\/\/){0,1})www\.(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/i;
	var reg = /^((https|http|ftp|rtsp|mms){0,1}(:\/\/){0,1})(www\.){0,1}(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/i;
	if (reg.test(a)) return true;
	return false;
}

function checkServer(sUrl) { //校验域名
	var sRegex = '^((https|http|ftp|rtsp|mms)?://)' +
		'?(([0-9a-z_!~*\'().&=+$%-]+: )?[0-9a-z_!~*\'().&=+$%-]+@)?' //ftp的user@ 
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

function checkPort(a) { //校验端口号
	if (!checkNum(a)) return false;
	if (Number(a) < 1 || Number(a) > 65535) return false;
	return true;
}

function checkPorts(a, b) { //端口转发端口校验
	if (!checkNum(a) || Number(a) < 1 || Number(a) > 65535) return false;
	if (!checkNum(b) || Number(b) < 1 || Number(b) > 65535) return false;
	if (Number(a) > Number(b)) return false;
	return true;
}

function checkTimeManage(a1, b1, a2, b2) { //家长控制时间管理校验
    if(!a1||!b1||!a2||!b2) return false;
	if (Number(a1) > Number(a2)) return false;
	if (Number(a1) == Number(a2)) {
		if (Number(b1) >= Number(b2)) return false;
	}
	return true;
}

function checkHour(a) { //校验时钟
	var reg = /^[0-9]{1,2}$/;
	if (!reg.test(a) || a > 23 || a < 0) return false;
	return true;
}

function checkMinute(a) { //校验分钟
	var reg = /^[0-9]{1,2}$/;
	if (!reg.test(a) || a > 59 || a < 0) return false;
	return true;
}
function checkUsbStr(a,type){ //校验usb功能用户密码
	var reg = /^[0-9a-zA-Z_]{6,16}$/
	if(!reg.test(a)) return false;
	return true;
}

function checkAcsUrl(a){
	if(!a) return false;
	if(a.indexOf(' ')!=-1) return false;
	return true;
}

function checkAcsStr(a){ //校验acs用户名密码
	if(!a) return false;
	var reg = /^[a-z0-9_]{1,32}$/i;
	if(!reg.test(a)) return false;
	return true;
}
