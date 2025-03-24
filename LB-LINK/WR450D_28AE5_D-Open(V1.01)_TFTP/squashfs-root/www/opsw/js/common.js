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

function frameHstip(type, tips, time) { //弹框
	const self = vm;
	self.layerShow = true;
	self.tips = tips;
	switch (type) { //type: 0 代表 校验需点击按钮； 1代表返回信息，不需点击按钮；2代表 倒计时
		case 0:
			self.isCount = 0;
			break;
		case 1:
			self.isCount = 1;
			setTimeout(function() {
				self.layerShow = false;
			}, 1000)
			break;
		case 2:
			self.countdown = time;
			self.isCount = 2;
			var timer = setInterval(function() {
				self.countdown--;
				if (self.countdown == 0) {
					clearInterval(timer);
					self.layerShow = false;
					switch (self.skipPageType) {
						case 0: // 跳转到登录页
							window.location = 'http://' + window.location.host;
							break;
						case 1: // 跳转到首页
							window.location = 'http://' + window.location.host + hostUrl + '/main.html';
							break;
						case 2: // 根据ip变化重新跳转到登录页
							window.location = 'http://' + self.networkForm.ip;
							break;
						case 3: // 不跳转
							break;
					}
				}
			}, 1000)
			break;
	}
}

function strChange(a, b) {
	var a1 = a.split('.');
	var b1 = b.split('.');
	var b2 = a1[0] + '.' + a1[1] + '.' + a1[2] + '.' + b1[3];
	return b2;
}

function changeChar(str) { //将特殊字符转义
	var arr = str.split('');
	for (var i = 0; i < arr.length; i++) {
		if (arr[i] == '$') {
			arr[i] = '\\$';
		}
		if (arr[i] == '`') {
			arr[i] = '\\`';
		}
	}
	return arr.join('');
}
