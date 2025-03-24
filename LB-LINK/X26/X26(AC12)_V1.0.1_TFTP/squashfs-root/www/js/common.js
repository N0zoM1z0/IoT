function format(value) { //时间转换
	var theTime = parseInt(value); // 秒
	var day = 0;
	var middle = 0; // 分
	var hour = 0; // 小时
	if (theTime > 60) {
		middle = parseInt(theTime / 60);
		theTime = parseInt(theTime % 60);
		if (middle > 60) {
			hour = parseInt(middle / 60);
			middle = parseInt(middle % 60);
		}
		if (hour > 24) {
			day = parseInt(hour / 24);
			hour = parseInt(hour % 24);
		}
	}
	var result = "" + parseInt(theTime) + "seconds";
	if (middle > 0) {
		result = "" + parseInt(middle) + "minutes " + result;
	}
	if (hour > 0) {
		result = "" + parseInt(hour) + "hours " + result;
	}
	if (day > 0) {
		result = "" + parseInt(day) + 'days ' + result;
	}
	return result;
}

function frameHstip(type, tips, time, page) { //弹框
	var that = vm;
	that.isCount = type;
	that.layerShow = true;
	that.frameShow = true;
	that.tips = tips;
	if(type==1){  //type: 0 代表 校验需点击按钮； 1代表返回信息，不需点击按钮；2代表 倒计时，3代表倒计时没有弹框
		setTimeout(function() {
			that.layerShow = false;
			that.frameShow = false;
		}, 3000)
	}else if(type==2){
		countdownFun(time,page);
	}
}

function countdownFun(time,page){
	var that = vm;
	that.clearLoginTimer();
	that.clearTimers();
	that.layerShow = true;
	that.countdown = time;
	var timer = setInterval(function() {
		that.countdown--;
		if (that.countdown == 0) {
			clearInterval(timer);
			that.layerShow = false;
			that.frameShow = false;
			var path = location.protocol + "//blinkwifi.cn" + (location.port ? ':'+location.port : '');
			var path_home = isMobile() ? (path + '/html/mobile.html') : (path + '/html/index.html');
			switch (page) {
				case 'login': // 跳转到登录页
					sessionStorage.clear();
					window.location = path;
					break;
				case 'index': // 跳转到首页
					window.location = path_home;
					break;
				case 'login_lan': // 根据ip变化重新跳转到登录页
					window.location = path_home;
					break;
				default: // 不跳转
					break;
			}
		}
	}, 1000)
}

function strChange(a, b) {
	var a1 = a.split('.');
	var b1 = b.split('.');
	var b2 = a1[0] + '.' + a1[1] + '.' + a1[2] + '.' + b1[3];
	return b2;
}

// 流量转换
function flowTransition(limit) {
	var limit = Number(limit);
	var size = "";
	if (limit < 1024) { //1KB，则转化成B
		size = limit.toFixed(2) + "B"
	} else if (limit < 1024 * 1024) { //1MB，则转化成KB
		size = (limit / 1024).toFixed(2) + "KB"
	} else if (limit < 1024 * 1024 * 1024) { //小于1GB，则转化成MB
		size = (limit / (1024 * 1024)).toFixed(2) + "MB"
	} else { //其他转化成GB
		size = (limit / (1024 * 1024 * 1024)).toFixed(2) + "GB"
	}
	var sizeStr = size + ""; //转成字符串
	var index = sizeStr.indexOf("."); //获取小数点处的索引
	var dou = sizeStr.substr(index + 1, 2) //获取小数点后两位的值
	if (dou == "00") { //判断后两位是否为00，如果是则删除00                
		return sizeStr.substring(0, index) + sizeStr.substr(index + 3, 2)
	}
	return size;
}

// 版本比较
function compVer(curVer, newVer) {
	if (!curVer || !newVer) return false;
	var curVerList = curVer.split('.');
	var newVerList = newVer.split('.');
	if (Number(newVerList[0]) < Number(curVerList[0])) return false;
	if (Number(newVerList[0]) == Number(curVerList[0])) {
		if (Number(newVerList[1]) < Number(curVerList[1])) return false;
		if (Number(newVerList[1]) == Number(curVerList[1])) {
			if (Number(newVerList[2]) <= Number(curVerList[2])) return false;
		}
	}
	return true;
}

function netSpeedChange(value) { //网速转换
	if (isNaN(Number(value))) return '0kB/s';
	var flow = parseInt(Number(value));
	if (flow < (1024 * 1024)) return (flow / 1024).toFixed(2) + 'KB/s';
	if (flow < (1024 * 1024 * 1024)) return (flow / (1024 * 1024)).toFixed(2) + 'MB/s';
	if (flow >= (1024 * 1024 * 1024)) return (flow / (1024 * 1024 * 1024)).toFixed(2) + 'GB/s';
}

function bitOperation(a1, b1) { // 位运算
	var a = Number(a1),
		b = Number(b1);
	if (isNaN(a) || isNaN(b)) return 0;
	return a & b;
}


// lan设置校验

// 验证IP的正则
var ip_reg =
	/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;

// 验证子网掩码的正则
var mask_reg =
	/^(254|252|248|240|224|192|128|0)\.0\.0\.0|255\.(254|252|248|240|224|192|128|0)\.0\.0|255\.255\.(254|252|248|240|224|192|128|0)\.0|255\.255\.255\.(254|252|248|240|224|192|128|0)$/;

function ip_to_binary(ip) { //ip转成二进制
	if (ip_reg.test(ip)) {
		var ip_str = "",
			ip_arr = ip.split(".");

		for (var i = 0; i < 4; i++) {
			var number_bin = parseInt(ip_arr[i]).toString(2);
			var count = 8 - number_bin.length;
			for (var j = 0; j < count; j++) {
				number_bin = "0" + number_bin;
			}
			ip_str += number_bin;
		}
		return ip_str;
	}
	return '';
}

function binary_to_ip(binary) { //二进制转成ip
	if (binary.length == 32) {
		a = parseInt(binary.substr(0, 8), 2);
		b = parseInt(binary.substr(8, 8), 2);
		c = parseInt(binary.substr(16, 8), 2);
		d = parseInt(binary.slice(-8), 2);
		return a + '.' + b + '.' + c + '.' + d;
	}
	return '';
}

function get_network_broadcast_addr(ip, mask) { //根据子网掩码和网关计算网络地址和广播地址
	var network_broadcast = [];
	var network_addr = "";
	var mask_arr = mask.split(".");
	var ip_arr = ip.split(".");
	// 计算IP的网络地址 与(&)运算
	for (var i = 0; i < 4; i++) {
		var number1 = parseInt(mask_arr[i]);
		var number2 = parseInt(ip_arr[i]);
		network_addr += number1 & number2;
		if (i < 3) {
			network_addr += ".";
		}
	}
	network_broadcast.push(network_addr);
	// 计算广播地址
	// 子掩码后面有几个0，就去掉IP地址后几位再补1
	var mask_binary = ip_to_binary(mask);
	var gateway_binary = ip_to_binary(ip);
	var mask_zero = mask_binary.split(0).length - 1;
	var one_number = new Array(mask_zero + 1).join('1'); // IP地址后位补1
	var gateway_hou_wei_bu_yi = gateway_binary.slice(0, -mask_zero) + one_number;
	network_broadcast.push(binary_to_ip(gateway_hou_wei_bu_yi));
	return network_broadcast;
}

function getPoolAddress(ip, mask) { //获取地址池起始IP和结束IP
	var list = get_network_broadcast_addr(ip, mask);
	var netSite = list[0]; //网络地址
	var broadcastSite = list[1]; //广播地址
	var pool_startIp = '',
		pool_endIp = '';
	if(netSite){
		for (var i = 0; i < 3; i++) {
			pool_startIp += netSite.split('.')[i] + '.';
		}
		pool_startIp += Number(netSite.split('.')[3]) + 1; //地址池起始IP
	}
	if(broadcastSite){
		for (var i = 0; i < 3; i++) {
			pool_endIp += broadcastSite.split('.')[i] + '.';
		}
		pool_endIp += Number(broadcastSite.split('.')[3]) - 1; //地址池结束IP
	}
	return [pool_startIp, pool_endIp];
}

function ipCompareStart(ip, pool_startIp) { //比较ip和地址池起始ip
	var ipRange = ip.split('.');
	for (var i = 0; i < 4; i++) {
		if (Number(ipRange[i]) < Number(pool_startIp.split('.')[i])) {
			return false;
		} else if (Number(ipRange[i]) == Number(pool_startIp.split('.')[i])) {
			if (i == 3) return true;
		} else {
			return true;
		}
	}
}

function ipCompareEnd(ip, pool_endIp) { //比较ip和地址池结束ip
	var ipRange = ip.split('.');
	for (var i = 0; i < 4; i++) {
		if (Number(ipRange[i]) > Number(pool_endIp.split('.')[i])) {
			return false;
		} else if (Number(ipRange[i]) == Number(pool_endIp.split('.')[i])) {
			if (i == 3) return true;
		} else {
			return true;
		}
	}
}

function ipCompareScope(ip,pool_startIp,pool_endIp){ //判断ip地址是否在地址池起始IP和结束IP之间
	if(ipCompareStart(ip,pool_startIp)&&ipCompareEnd(ip,pool_endIp)) return true;
	return false;
}

function ipCompareSize(a,b){ //判断ip之间大小关系
	var aRange = a.split('.');
	var bRange = b.split('.');
	for (var i = 0; i < 4; i++) {
		if (Number(aRange[i]) > Number(bRange[i])) {
			return 'more';
		} else if (Number(aRange[i]) == Number(bRange[i])) {
			if (i == 3) return 'equal';
		} else {
			return 'less';
		}
	}
}


function lanSetVerify(Switch, lanIp, mask, startIp, endIp) { //lan设置校验
    var that = vm;
	if (!checkIp(lanIp)){
		frameHstip(1, that.$t('lanip_verify'));
		return false;
	}
	if (!checkMask(mask)){
		frameHstip(1, that.$t('mask_verify'));
		return false;
	}
	var pool_startIp = getPoolAddress(lanIp, mask)[0];
	var pool_endIp = getPoolAddress(lanIp, mask)[1];
	if(!ipCompareScope(lanIp,pool_startIp,pool_endIp)){
		frameHstip(1, that.$t('lanIp_scope_verify'));
		return false;
	}
	if (Switch == 'on') {
		if(!checkIp(startIp)) return frameHstip(1, that.$t('startip_verify'));
		if(!checkIp(endIp)) return frameHstip(1, that.$t('endip_verify'));
		if(!ipCompareScope(startIp,pool_startIp,pool_endIp)){
			frameHstip(1, that.$t('startIp_scope_verify'));
			return false;
		}
		if(!ipCompareScope(endIp,pool_startIp,pool_endIp)){
			frameHstip(1, that.$t('endIp_scope_verify'));
			return false;
		}
		if(ipCompareSize(startIp,endIp)=='more'||ipCompareSize(startIp,endIp)=='equal'){
			frameHstip(1, that.$t('startEndIp_compare'));
			return false;
		}
		if(ipCompareSize(startIp,lanIp)=='equal'||ipCompareSize(endIp,lanIp)=='equal'){
			frameHstip(1, that.$t('startEndLan_notEqual'));
			return false;
		}
	}
    return true;
}

function isMobile() {
	let flag = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
	return flag;
}
