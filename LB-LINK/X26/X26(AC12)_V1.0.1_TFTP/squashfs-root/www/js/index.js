var i18n = new VueI18n({
	locale: 'zh', // 设置地区
	messages: messages, // 设置地区信息
})

// 请求拦截
axios.interceptors.request.use(function(config) {
	var token = sessionStorage.getItem('token');
	if (token) {
		config.headers.Authorization = token;
	}
	return config;
}, function(err) {})

// 响应拦截
axios.interceptors.response.use(function(req) {
	vm.failNum = 0;
	vm.layerShow = false;
	if ((typeof(req.data)) == "string") {
		var req = JSON.parse(req.data)
	}
	return req.data;
}, function(err) {
	vm.layerShow = false;
	return Promise.reject(err);
})

function request(data){
	return axios({
		url: "/cgi-bin/lighttpd.cgi",
		method: 'post',
		data: JSON.stringify(data)
	})
}

var vm = new Vue({
	i18n: i18n,
	data: function() {
		return {
			softwareType:'common',     //common代表普通的，neutral代表中性
			tabType: 'main',
			failNum: 0, //接口调用失败次数
			loginStatusTimer: '',
			loading: false,
			layerShow: false,
			frameShow:false,
			countdown: null,
			tips: '',
			isCount: 0,
			adminForm: {
				password: ""
			},
			forgetPwdShow:false,
			pwdShow:false,
			showLoading: false,
			clientList: [], //终端列表
			// 首页
			diagnosisDialog: false, //网络诊断弹框
			outNetDialog: false, //外网设置弹框
			wifiSetDialog: false, //wifi设置弹框
			localNetDialog: false, //局域网设置弹框
			resetDialog: false, //复位弹框
			dualSwitch: true, //双频开关
			routerMsgTimer: '', //首页信息定时器
			deviceNumTimer: '', //首页设备数定时器
			deviceNum: { //连接设备数
				cable: null,
				_2g: null,
				_5g: null
			},
			rssiMsg: {
				rssi: null,
				serviceinfo: null,
				simcardstatus: null
			},
			//网络诊断
			isDiagnosisEnd:false,   //是否诊断结束
			netstatusLoading: false,
			wanstatusLoading: false,
			wanmodeequalLoading: false,
			ipstatusLoading: false,
			dnstatusLoading: false,
			dianosisForm: {
				netstatus:'',    //检测外网连接状态
				wanstatus:'',    //检测wan口网线连接状态
				wanmodeequal:'',  //检测上网方式是否正确
				ipstatus:'',      //检测外网是否获取到IP地址
				dnstatus:''      // 检测DNS服务器状态
			},
			twoWifiMsg: {
				enable: true,
				wlanssid: '',
				ssidhide: true,
				wlanpsw: '',
				wlanpswmode: '',
				wlanpswencry: '',
				power: null
			},
			fiveWifiMsg: {
				enable: true,
				wlanssid: '',
				ssidhide: true,
				wlanpsw: '',
				wlanpswmode: '',
				wlanpswencry: '',
				power:null
			},
			wifiModeForm: {
				twoWifiMode: 0,
				fiveWifiMode: 0
			},
			// 访客网络
			twoVisNetMsg: {
				Switch: 0,
				ssid: "",
				ssid_hide: "0",
				pwd: "",
				encryption: "open",
			},
			fiveVisNetMsg: {
				Switch: 0,
				ssid: "",
				ssid_hide: "0",
				pwd: "",
				encryption: "open"
			},
			routerMsg: {
				connetype: '',
				cpu: '',
				downspeed: '',
				hardwareversion: '',
				key: '',
				lanip: '',
				lanmac: '',
				operationmode: '',
				producttype: '',
				ramfree: '',
				ramtotal: '',
				server_type: '',
				type: '',
				upspeed: '',
				uptime: '',
				ver: '',
				netlink: 1, //能否上网
				wan: 0,
				lan1: 0,
				lan2: 0,
				lan3: 0,
				lan4: 0
			},
			wanType: null,
			pppoeForm: {
				mtu: '1480',
				pppoename: '',
				pppoepsw: '',
				server_name: ''
			},
			staticForm: {
				wanip: '',
				wanmsk: '',
				wangw: '',
				dns1: '',
				dns2: '',
			},
			wanMsg: {
				connetype: '',
				dns1: '',
				dns2: '',
				gateway: '',
				ip: '',
				type: '',
				wan_mac: '',
				wanmsk: ''
			},
			apnSetDialog: false, //apn设置弹框
			// more页
			activeName: 'first',
			featureIndex: 0,
			featureItem: '',
			isDouble: false, //是否有5g wifi设置
			lanFlag: 0, //lan设置输入框标记
			lanMsg: {
				landhcp: 'on',
				lanip: '',
				lanmsk: '',
				startip: '',
				endip: ''
			},
			qosMsg: {
				MAC: null,
				Up_Speed: null,
				Dl_Speed: null
			},
			isSpeedLimit: false,
			pppoeserverType: 0,
			pppoeserverMsg: {
				pswitch: 1,
				saddr: '',
				sname: '',
				startip: '',
				endip: '',
				sauth: 1,
				ldpcktime: '', //链路维护周期
				ldpcount: '', //链路检测超时次数
				spap: false,
				schap: false,
				sms_chap: false,
				sms_chapv2: false
			},
			pppoeuserList: [], //用户列表
			pppoeClientList: [], //拨号终端列表
			pppoeUserAdd: {
				userAddres: null,
				serverpwd: null
			},
			apnMsg: {
				simcardstatus: "0",
				serviceinfo: null,
				modlever: "",
 				nettype: '0',
				enable: true,
				profileName: null,
				apn: null,
				authtype: "0",
				username: "",
				passwd: "",
				iptype: "IP",
			},
			macListShow: false,
			macIndex: 0,
			cloneMacMsg: {
				clonemac: "",
				list: [],
				self: ""
			},
			dnsMsg: {
				status: '1',
				dns1: "",
				dns2: ""
			},
			iptvMsg: {
				Switch: 1,
				tag: null
			},
			iptvCheckList: [],
			ipv6Msg: {
				lantype: "1",
				ipv6_passthrough:"1",
				globaladdr: "",
				localaddr: ""
			},
			dfsChannelShow:false,
			twoChannel: {
				countrycode: "NONE",
				channel: 0,
				htbw: 0,
				curbw: 0,
				curchannel: 0
			},
			fiveChannel: {
				countrycode: "NONE",
				channel: 0,
				htbw: 0,
				curbw: 0,
				curchannel: 0
			},
			channelqualityMsg: { //信道优化信息
				channel: 0,
				quality: 0
			},
			channelPercent: '25',
			bindList: [], //绑定列表
			// wifi定时
			wifiTimerIndex: 0,
			wifiTimerMsg: {
				Switch: '1',
				list: []
			},
			wifiPeriod1: '00',
			wifiPeriod2: '00',
			wifiPeriod3: '00',
			wifiPeriod4: '00',
			weekList: [0, 1, 2, 3, 4, 5, 6],
			dateIndex: 0,
			// 定时重启
			restartTimerIndex:0,
			scheduleRestartMsg:{
				Switch:'1',
				list:[]
			},
			restartPeriod1:'00',
			restartPeriod2:'00',
			ledswitchMsg: { //面板灯开关信息
				status: 1,
				ledeasysw: 0,
				ledsh: null,
				ledsm: null,
				ledeh: null,
				ledem: null,
			},
			timeZoneMsg: {
				systemtime: null,
				ntpserver: null,
				ntptz: null,
				ntpsync: null
			},
			parentControl: {
				Switch: true,
				list: []
			},
			blackType: 0,
			parentIndex: 0,
			parOperation: '',
			parentRow: null,
			parentForm: {
				alias: "",
				dayList: [],
				devname: "",
			},
			clientIndex: 0,
			accesstime1: "00",
			accesstime2: "00",
			accesstime3: "00",
			accesstime4: "00",
			macRange1: '',
			macRange2: '',
			macRange3: '',
			macRange4: '',
			macRange5: '',
			macRange6: '',
			crrLoginPwdMsg: {
				routeusr: "admin",
				routepwd: "admin"
			},
			loginPwd: {
				oldPwd: '',
				newPwd: ''
			},
			upnpMsg: { //upnp
				enable: 0,
				list: []
			},
			cwmpMsg:{
				enable: '0',
				url: '',
				username: '',
				password: '',
				manufacturer: '',
				oui: '',
				serial: ''
			},
			hardware_status: '1', //硬件加速
			// usb
			usbType: 'ftp',
			usbenable: 'disable',
			usbIndex: 0,
			usbMsg: {
				Switch: 'on',
				username: '',
				password: ''
			},
			usbSharedList: [],
			ftpSharedList: [],
			diskList: [], //磁盘路径列表
			usbCheckRow: {},
			vpnType: 'pptp',
			vpnMsg: {
				Switch: false,
				domain: "",
				username: "",
				password: "",
				netmode: "DHCP",
				MTU: "1440",
				staticip: '',
				staticmask: '',
				staticgateway: ''
			},
			webadminMsg: { //远程web访问
				Switch: '1',
				remote_manage_port: ''
			},
			dmzMsg: {
				enable: '1',
				ip: ''
			},
			portIndex: 0,
			portForward: { //端口转发
				list: []
			},
			portSubRow: { //当前端口详情信息
				name: '',
				ip: '',
				sublist: [], //端口信息
			},
			portForm: {
				name: "",
				ip: "",
				protocol: "TCP"
			},
			portEditIndex: 0,
			portNameIndex: 0, //端口转发自动添加列表索引
			portOperaType: 0,
			lanPort1: '',
			lanPort2: '',
			wanPort1: '',
			wanPort2: '',
			portAddEditDialog: false, //端口转发新增编辑弹框
			portSubListIndex: 0,
			// 流量控制
			flowPercent: 10, //流量百分比
			MonthlyPackage: null,
			flowMsg: {
				MonDown: "0",
				MonUp: "0",
				MonthlyPackage: "0",
				Switch: 0
			},
			vserverType: 0,
			vserverForm: {
				enable: 1,
				ip: null,
				pu_port: null,
				pr_port: null,
				protocol: 'TCP'
			},
			vserverList: [],
			pluginRadio: '1', //购物比价开关
			shareMsg: {
				status: '1',
				sharewifissid: null
			},
			// setup页面
			previousMsg:{
				wanmode:'',
				netlink:''
			},
			isNetStatusTimer:false,
			setupTimer: '',
			helpDialog: false,
			loginSetForm: {
				password: '',
				userProtocol: true,
			},
			routerStatusMsg: {
				jumpflag: "",
				netstatus: "",
				operationmode: "",
				password: "",
				version: "",
				wanstatus: ""
			},
			selectModeShow:false,
			setupPage: 'modePage',
			modeType: 'router',
			pppoeShow: false,
			wispLoading: false,
			wispCurPage: 1, //wisp模式当前页数
			wispList: [], //中继模式wifi列表
			curPagewispData: [],
			wispData: [],
			wispPwdDialog: false, //wisp模式密码设置弹框
			wispPwdShow: false,
			wispForm: {
				ssid: '',
				password: ''
			},
			wispWifiRow: {
				bssid: "",
				channel: "",
				ext_ch: "",
				security: "",
				signal: "",
				ssid: "",
			},
			curWispWifiMsg: { //当前wisp连接的wifi信息
				mac: "",
				ssid: ""
			},
			// 终端列表页
			terTimer: '', //设备列表定时器
			blackTimer: '', //黑名单定时器
			terListType: 0,
			terManDialog: false,
			ternameEdit: false,
			wiredTerlist: [], //有线设备列表
			twoTerlist: [], //2.4g设备列表
			fiveTerlist: [], //5g设备列表
			blackList: [], //黑名单列表
			terminaForm: {
				name: '',
				mac: '',
				ip: '',
				totaldl: "",
				totalup: ""
			},
			terminalShow: sessionStorage.getItem('defmode') != 'AP' && sessionStorage.getItem('defmode') !='repeater',
			// 固件升级
			fileList: [],
			versionMsg: {
				curver: '',
				lastver: ''
			},
			onlineDisable: true,
			upgradeTimer: '',
			verisionTimer: '',
			upgradeType:0,
			// 手机端
			navIndex: 0,
			featureTitle: '',
			mobileIndex: null,
			statusTimer: '', //手机端路由器信息获取定时器
			routerStatus: {
				cpu: "",
				downspeed: "0",
				netstatus: "link",
				operationmode: "",
				ternum: 0,
				upspeed: "0",
				uptime: "",
				ver: "",
				wanstatus: ""
			}
		}
	},
	created: function() {
		var jsSrc = (navigator.language || navigator.browserLanguage).toLowerCase();
		if (jsSrc.indexOf('zh') >= 0) { // 假如浏览器语言是中文
			this.$i18n.locale = 'zh';
			ELEMENT.locale(ELEMENT.lang.zh);
		} else { // 假如浏览器语言是英文
			this.$i18n.locale = 'en';
			ELEMENT.locale(ELEMENT.lang.en);
		}
		document.title = this.softwareType=='neutral' ? this.$t('routerManage') : this.$t('routerName');
		if (!sessionStorage.getItem('token') && location.pathname != '/' && location.pathname !=
			'/login.htm') {
			window.location = "../login.htm";
		}
	},
	computed: {
		netDiagnosisMsg:function(){ //网络诊断信息
			if(this.dianosisForm.wanstatus!='1') return this.$t('wanstatusError');
			if(this.dianosisForm.wanmodeequal!='1'){
				if(this.dianosisForm.wanmodeequal=='2') return this.$t('wanmodeequaError_pppoe');
				if(this.dianosisForm.wanmodeequal=='3') return this.$t('wanmodeequaError_dhcp');
				if(this.dianosisForm.wanmodeequal=='4') return this.$t('wanmodeequaError_static');
				return this.$t('wanmodeequaError');
			}
			if(this.dianosisForm.ipstatus!='1') return this.$t('ipstatusError');
			if(this.dianosisForm.dnstatus!='1') return this.$t('dnstatusError');
			if(this.dianosisForm.netstatus!='1') return this.$t('netstatusError');
			return this.$t('nd_noError');
		},
		specialBandwidthShow:function(){
			var fiveChannel = this.fiveChannel.channel;
			var fiveCountrycode = this.fiveChannel.countrycode;
			if((fiveCountrycode=='IE'&&(fiveChannel==132||fiveChannel==136||fiveChannel==140))||fiveChannel==165) return true;
			return false;
		},
		fiveBandwidthList:function(){
			var fiveBandwidthList = [{
				value:0,
				label:this.$t('auto')
			},
			{
				value:1,
				label:'20M'
			},
			{
				value:2,
				label:'40M'
			},
			{
				value:3,
				label:'80M'
			}];
			if(this.fiveChannel.channel==165){
				fiveBandwidthList = [{value:1,label:'20M'}];
			}
			if(this.fiveChannel.countrycode=='IE'){
				if(this.fiveChannel.channel==132||this.fiveChannel.channel==136){
					fiveBandwidthList = [{value:1,label:'20M'},{value:2,label:'40M'}];
				}
				if(this.fiveChannel.channel==140){
					fiveBandwidthList = [{value:1,label:'20M'}];
				}
			}
			return fiveBandwidthList;
		}
	},
	methods: {
		tabClick: function(index) {
			this.tabType = index;
			this.clearTimers();
			if (this.tabType == 'main') {
				this.getRouterInfo();
				this.getDeviceNum();
				this.routerMsgTimer = setInterval(this.getRouterInfo, 5000);
				if(this.terminalShow){
					this.deviceNumTimer = setInterval(this.getDeviceNum, 5000);
				}
			} else if (this.tabType == 'more') {
				this.activeName = 'first';
				this.featureIndex = 0;
				this.showMorePage();
				this.isDualFrequency();
				var tabFirst = document.querySelector('#tab-first');
				var tabFourth = document.querySelector('#tab-fourth');
				if (sessionStorage.getItem('defmode') == 'AP' || sessionStorage.getItem('defmode') ==
					'repeater') {
					tabFirst.style.display = 'none';
					tabFourth.style.display = 'none';
					this.activeName = 'second';
				} else {
					tabFirst.style.display = 'inline-block';
					tabFourth.style.display = 'inline-block';
					this.activeName = 'first';
				}
			} else if (this.tabType == 'setup') {
				this.getModeMsg();
				var first_login = window.sessionStorage.getItem('first_login');
				if (first_login==0) {
					this.getPreviousWanMode();
					this.setupPage = 'wanPage';
					this.modeType = 'router';
					window.sessionStorage.removeItem('first_login');
				} else {
					this.setupPage = 'modePage';
				}
			} else if (this.tabType == 'terminal') {
				this.terListType = 0;
				this.getTerminalList();
				this.terTimer = setInterval(this.getTerminalList, 6000);
			} else {
				this.upgradeTypeTab(0);
			}
		},
		submitForm: function() { //登录
			var that = this;
			if (!that.adminForm.password) return frameHstip(1, that.$t('pwd_notNull'));
			that.layerShow = true;
			request({
				type: 'loginauth',
				platform: '0',
				user: 'admin',
				pass: that.adminForm.password
			}).then(function(data) {
				if (data.result == 0) {
					// frameHstip(1, that.$t('loginSuccess'));
					sessionStorage.setItem('token', data.token);
					sessionStorage.setItem('defmode', data.defmode);
					if (data.defmode == 'wisp' || data.defmode == 'repeater') {
						sessionStorage.setItem('wifiType', data.wifiType);
					}
					document.cookie = 'user=admin';
					sessionStorage.setItem('first_login',data.first_login);
					var path = location.protocol + "//" + location.hostname + (location.port ? ':'+location.port : '');
					setTimeout(function(){
						if (!isMobile()) { //pc端
							window.location =  path + '/html/index.html';
						} else { //手机端
							if (data.first_login == 0) {
								window.location = path + '/html/mobWizard.html';
							} else {
								window.location = path + '/html/mobile.html';
							}
						}
						that.adminForm.password = '';
					},500)
				} else {
					frameHstip(1, that.$t('loginPwd_error'));
				}
			}).catch(function() {})
		},
		setLoginTimer: function() { //开启登录状态定时器
			this.loginStatusTimer = setInterval(this.getLoginStatus, 8000);
		},
		clearLoginTimer: function() { //关闭登录状态定时器
			clearInterval(this.loginStatusTimer);
		},
		clearTimers:function(){ //清除所有定时器
			this.isNetStatusTimer = false;
			clearInterval(this.routerMsgTimer);
			clearInterval(this.deviceNumTimer);
			clearInterval(this.terTimer);
			clearInterval(this.blackTimer);
			clearInterval(this.verisionTimer);
		},
		getLoginStatus: function() { //获取登录状态
			var that = this;
			request({type: 'getheartbeat'}).then(function(data) {
				if (data.result == 8) {
					window.location = "../login.htm";
				}
			}).catch(function() {
				that.failNum++;
				if (that.failNum == 2) {
					window.location = "../login.htm";
				}
			})
		},
		// 首页
		getWanMsg: function() {
			var that = this;
			request({type: 'getwaninfo'}).then(function(data) {
				that.wanMsg = data;
			}).catch(function() {})
		},
		getRouterInfo: function() { //获取路由信息
			var that = this;
			request({type: 'getrouterinfo'}).then(function(data) {
				that.routerMsg = data;
				var remain = that.routerMsg.ramfree;
				var total = that.routerMsg.ramtotal;
				that.routerMsg.ramfree = remain > 1024 ? (remain / 1024).toFixed(2) + 'MB' :
					remain + 'KB';
				that.routerMsg.ramtotal = total > 1024 ? (total / 1024).toFixed(2) + 'MB' : total +
					'KB';
				that.routerMsg.ver = that.routerMsg.ver.split(',')[1];
			}).catch(function() {})
		},
		rediagnostics:function(){ //重新诊断
			for(var i in this.dianosisForm){
				this.dianosisForm[i] = '';
			}
			this.get_diagnosis_info();
		},
		get_diagnosis_info: function() { //网络诊断
			var that = this;
			that.isDiagnosisEnd = false;
			that.netstatusLoading = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getnetworkdiagnosisinfo'
			})).then(function(data) {
				setTimeout(function() { //检测外网连接状态
					that.netstatusLoading = false;
					that.dianosisForm.netstatus = data.netstatus;
					that.wanstatusLoading = true;
					setTimeout(function() { //检测wan口网线连接状态
						that.wanstatusLoading = false;
						that.dianosisForm.wanstatus = data.wanstatus;
						if (that.dianosisForm.wanstatus != '1'){
							 that.isDiagnosisEnd = true;
							return false;
						}
						that.wanmodeequalLoading = true;
						setTimeout(function() { //检测上网方式是否正确
							that.wanmodeequalLoading = false;
							that.dianosisForm.wanmodeequal = data.wanmodeequal;
							if (that.dianosisForm.wanmodeequal != '1'){
								that.isDiagnosisEnd = true;
								return false;
							}
							that.ipstatusLoading = true;
							setTimeout(function() { //检测外网是否获取到IP地址
								that.ipstatusLoading = false;
								that.dianosisForm.ipstatus = data.ipstatus;
								if (that.dianosisForm.ipstatus != '1'){
									that.isDiagnosisEnd = true;
									return false;
								}
								that.dnstatusLoading = true;
								setTimeout(function() { //检测DNS服务器状态
									that.dnstatusLoading = false;
									that.dianosisForm.dnstatus = data.dnstatus;
									that.isDiagnosisEnd = true;
								}, 2000)
							}, 2000)
						}, 2000)
					}, 2000)
				}, 2000)
			}).catch(function() {})
		},
		getDeviceNum: function() { //获取设备数
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getclientnum'
			})).then(function(data) {
				that.deviceNum = data;
			}).catch(function() {})
		},
		get5g_mainRssi: function() { //获取5g信号强度等信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'get4gbasicinfo'
			})).then(function(data) {
				that.rssiMsg = data;
			}).catch(function() {})
		},
		getWanSet: function() { //获取外网设置
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getwancfg'
			})).then(function(data) {
				that.wanType = data.wanmode;
				if(that.wanType=='pppoe'){
					that.pppoeForm = data;
				}else if(that.wanType=='static'){
					that.staticForm = data;
				}
			}).catch(function() {})
		},
		setWanSet: function() { //外网设置保存
			var that = this;
			var msg = {
				type: 'setwancfg',
				wanmode: that.wanType,
			}
			if (that.wanType == 'pppoe') {
				if (!checkAlias(that.pppoeForm.pppoename)) return frameHstip(1, that.$t(
					'account_verify'));
				if (!checkAlias(that.pppoeForm.pppoepsw)) return frameHstip(1, that.$t('pwd_verify'));
				if (that.pppoeForm.server_name) {
					if (that.pppoeForm.server_name.length < 1 || that.pppoeForm.server_name.length > 64)
						return frameHstip(1, that.$t('servername_verify'));
				}
				if (!checkMtu(that.pppoeForm.mtu)) return frameHstip(1, that.$t('mtu_verify'));
				msg.pppoename = that.pppoeForm.pppoename;
				msg.pppoepsw = that.pppoeForm.pppoepsw;
				msg.server_name = that.pppoeForm.server_name;
				msg.mtu = that.pppoeForm.mtu
			} else if (that.wanType == 'static') {
				if (!checkStaticIp(that.staticForm.wanip)) return frameHstip(1, that.$t('ip_verify'));
				if (!checkMask(that.staticForm.wanmsk)) return frameHstip(1, that.$t('mask_verify'));
				if (!checkIp(that.staticForm.wangw)) return frameHstip(1, that.$t('gateway_verify'));
				var ipRangle = that.staticForm.wanip.split('.');
				var gatewayRangle = that.staticForm.wangw.split('.');
				var maskRangle = that.staticForm.wanmsk.split('.');
				for (var i = 0; i < 3; i++) {
					if (bitOperation(ipRangle[i], maskRangle[i]) != bitOperation(gatewayRangle[i],
							maskRangle[i])) return frameHstip(1, that.$t('ip_gateway_same'));
				}
				if (!checkIp(that.staticForm.dns1)) return frameHstip(1, that.$t('dns1_verify'));
				if (!checkIp(that.staticForm.dns2)) return frameHstip(1, that.$t('dns2_verify'));
				msg.wanip = that.staticForm.wanip;
				msg.wanmsk = that.staticForm.wanmsk;
				msg.wangw = that.staticForm.wangw;
				msg.dns1 = that.staticForm.dns1;
				msg.dns2 = that.staticForm.dns2;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getWanSet();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		dualSwitchChange:function(){
			this.getWifiMsg('change');
		},
		getWifiMsg: function(type) {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getwlancfgall'
			})).then(function(data) {
				if(!type){
					that.dualSwitch = data.dualSwitch == '1' ? true : false;
				}
				data.configurations.map(function(item) {
					if (item.radio == '2.4G') {
						that.twoWifiMsg = item;
						that.twoWifiMsg.enable = item.enable == 1 ? true : false;
						that.twoWifiMsg.ssidhide = item.ssidhide == 1 ? true : false;
					} else {
						that.fiveWifiMsg = item;
						that.fiveWifiMsg.enable = item.enable == 1 ? true : false;
						that.fiveWifiMsg.ssidhide = item.ssidhide == 1 ? true : false;
					}
				})
			}).catch(function() {})
		},
		setWifiMsg: function() {
			var that = this;
			if (!checkSsid(that.twoWifiMsg.wlanssid)) return frameHstip(1, that.$t('ssid_verify'));
			if (that.twoWifiMsg.wlanpswmode != 'open') {
				if (!checkPassword(that.twoWifiMsg.wlanpsw)) return frameHstip(1, that.$t(
					'wifiPwd_verify'));
			}
			if (!that.dualSwitch) {
				if (!checkSsid(that.fiveWifiMsg.wlanssid)) return frameHstip(1, that.$t('fiveSsid_verify'));
				if (that.fiveWifiMsg.wlanpswmode != 'open') {
					if (!checkPassword(that.fiveWifiMsg.wlanpsw)) return frameHstip(1, that.$t(
						'fiveWifiPwd_verify'));
				}
			}
			var msg = {
				type: 'setwlancfgall',
				dualSwitch: that.dualSwitch ? '1' : '0',
				wlanssid: that.twoWifiMsg.wlanssid,
				wlanpsw: that.twoWifiMsg.wlanpswmode == 'open' ? '' : that.twoWifiMsg.wlanpsw,
				wlanpswmode: that.twoWifiMsg.wlanpswmode,
				wlanpswencry: that.twoWifiMsg.wlanpswmode == 'open' ? '' : 'aes',
				power: that.twoWifiMsg.power
			}
			if (that.dualSwitch) {
				msg.wlanssid_5 = that.twoWifiMsg.wlanssid;
				msg.wlanpsw_5 = that.twoWifiMsg.wlanpswmode == 'open' ? '' : that.twoWifiMsg.wlanpsw;
				msg.wlanpswmode_5 = that.twoWifiMsg.wlanpswmode;
				msg.wlanpswencry_5 = that.twoWifiMsg.wlanpswmode == 'open' ? '' : 'aes';
				msg.power_5 = that.twoWifiMsg.power;
			} else {
				msg.wlanssid_5 = that.fiveWifiMsg.wlanssid;
				msg.wlanpsw_5 = that.fiveWifiMsg.wlanpswmode == 'open' ? '' : that.fiveWifiMsg.wlanpsw;
				msg.wlanpswmode_5 = that.fiveWifiMsg.wlanpswmode;
				msg.wlanpswencry_5 = that.fiveWifiMsg.wlanpswmode == 'open' ? '' : 'aes';
				msg.power_5 = that.fiveWifiMsg.power;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getWifiMsg();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		setSsidHide: function(value, type) {
			var that = this;
			var ssidType;
			if (!that.dualSwitch) {
				ssidType = type == 2 ? 'sethide2' : 'sethide5'
			} else {
				ssidType = 'sethideall';
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: ssidType,
				enable: value ? 1 : 0
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		setWifiSwitch: function(value, type) { //设置wifi开关
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				radioon: value ? 1 : 0,
				type: type
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getWifiMode: function() { //获取wifi模式
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getWifiMode'
			})).then(function(data) {
				that.wifiModeForm = data;
			}).catch(function() {})
		},
		setWifiMode: function() { //保存wifi模式
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setWifiMode',
				twoWifiMode: that.wifiModeForm.twoWifiMode,
				fiveWifiMode: that.wifiModeForm.fiveWifiMode
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getWifiMode();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getVisNetMsg: function() { //获取访客网络信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'multi_ssid'
			})).then(function(data) {
				data.list.map(function(item) {
					if (item.type == '2.4g') {
						that.twoVisNetMsg = item;
						that.twoVisNetMsg.ssid_hide = that.twoVisNetMsg.ssid_hide == '1' ?
							true : false;
					} else {
						that.fiveVisNetMsg = item;
						that.fiveVisNetMsg.ssid_hide = that.fiveVisNetMsg.ssid_hide == '1' ?
							true : false;
					}
				})
			}).catch(function() {})
		},
		setVisNetMsg: function() { //访客网络信息保存
			var that = this;
			if (!checkSsid(that.twoVisNetMsg.ssid)) return frameHstip(1, that.$t('ssid_verify'));
			if (that.twoVisNetMsg.encryption != 'open') {
				if (!checkPassword(that.twoVisNetMsg.pwd)) return frameHstip(1, that.$t(
					'wifiPwd_verify'));
			}
			if (!checkSsid(that.fiveVisNetMsg.ssid)) return frameHstip(1, that.$t('fiveSsid_verify'));
			if (that.fiveVisNetMsg.encryption != 'open') {
				if (!checkPassword(that.fiveVisNetMsg.pwd)) return frameHstip(1, that.$t(
					'fiveWifiPwd_verify'));
			}
			that.layerShow = true;
			var msg = {
				type: 'multi_ssid_apply',
				list: [{
					type: '2.4g',
					Switch: that.twoVisNetMsg.Switch,
					ssid: that.twoVisNetMsg.ssid,
					ssid_hide: that.twoVisNetMsg.ssid_hide ? '1' : '0',
					encryption: that.twoVisNetMsg.encryption,
					pwd: that.twoVisNetMsg.encryption == 'open' ? '' : that.twoVisNetMsg.pwd,
					encry_alg: that.twoVisNetMsg.encryption == 'open' ? '' : 'aes'
				}, {
					type: '5g',
					Switch: that.fiveVisNetMsg.Switch,
					ssid: that.fiveVisNetMsg.ssid,
					ssid_hide: that.fiveVisNetMsg.ssid_hide ? '1' : '0',
					encryption: that.fiveVisNetMsg.encryption,
					pwd: that.fiveVisNetMsg.encryption == 'open' ? '' : that.fiveVisNetMsg.pwd,
					encry_alg: that.fiveVisNetMsg.encryption == 'open' ? '' : 'aes'
				}]
			}
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getLanMsg: function() { //获取lan信息/局域网设置
			var that = this;
			that.lanFlag = 0;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getlancfg'
			})).then(function(data) {
				that.lanMsg = data;
			}).catch(function() {})
		},
		setLanMsg: function() { //保存lan信息
			var that = this;
			that.lanFlag = 0;
			var lanMsg = that.lanMsg;
			if (!lanSetVerify(lanMsg.landhcp, lanMsg.lanip, lanMsg.lanmsk, lanMsg.startip, lanMsg.endip))
				return false;
			var msg = {
				type: 'setlancfg',
				landhcp: lanMsg.landhcp,
				lanip: lanMsg.lanip,
				lanmsk: lanMsg.lanmsk,
			}
			if (lanMsg.landhcp == 'on') {
				msg.startip = lanMsg.startip;
				msg.endip = lanMsg.endip;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(2, that.$t('configuring'), 30, 'login_lan');
				} else if (data.result == 2) {
					frameHstip(1, that.$t('lanIp_notSegment'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getLanDialog: function() { //打开LAN弹框
			if (this.routerMsg.operationmode != 'repeater') {
				this.localNetDialog = true;
				this.getLanMsg();
				this.clearLoginTimer();
			}
		},
		getLanIpFocus: function() {
			if (this.lanFlag == 1) {
				var pool_startIp = getPoolAddress(this.lanMsg.lanip, this.lanMsg.lanmsk)[0]; //地址池开始IP
				var pool_endIp = getPoolAddress(this.lanMsg.lanip, this.lanMsg.lanmsk)[1]; //地址池结束IP
				if (ipCompareSize(this.lanMsg.lanip, pool_startIp) == 'equal') {
					var pool_startIpRange = pool_startIp.split('.');
					this.lanMsg.startip = pool_startIpRange[0] + '.' + pool_startIpRange[1] + '.' +
						pool_startIpRange[2] + '.' + (Number(pool_startIpRange[3]) + 1);
				} else {
					this.lanMsg.startip = pool_startIp;
				}
				if (ipCompareSize(this.lanMsg.lanip, pool_endIp) == 'equal') {
					var pool_endIpRange = pool_endIp.split('.');
					this.lanMsg.endip = pool_endIpRange[0] + '.' + pool_endIpRange[1] + '.' +
						pool_endIpRange[2] + '.' + (Number(pool_endIpRange[3]) - 1);
				} else {
					this.lanMsg.endip = pool_endIp;
				}
			}
			this.lanFlag = 0;
		},
		lanIpChange: function() { //ip变化,起始ip和结束ip跟着变化
			var ipRanle = this.lanMsg.lanip.split('.');
			var startipRanle = this.lanMsg.startip.split('.');
			var endipRanle = this.lanMsg.endip.split('.');
			var startipRanle3 = startipRanle[3] ? startipRanle[3] : '100';
			var endipRanle3 = endipRanle[3] ? endipRanle[3] : '200';
			var bool = true;
			if (ipRanle.length == 4) {
				for (var i = 0; i < ipRanle.length; i++) {
					if (isNaN(Number(ipRanle[i]))) {
						bool = false;
						break;
					}
				}
				if (bool) {
					this.lanMsg.startip = ipRanle[0] + '.' + ipRanle[1] + '.' + ipRanle[2] + '.' +
						startipRanle3;
					this.lanMsg.endip = ipRanle[0] + '.' + ipRanle[1] + '.' + ipRanle[2] + '.' +
						endipRanle3;
				}
			}
		},
		getApnMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getapninfo'
			})).then(function(data) {
				that.apnMsg = data;
				that.apnMsg.enable = that.apnMsg.enable == '1' ? true : false;
			}).catch(function() {})
		},
		setApnMsg: function() { //5g上网设置/apn设置
			var that = this;
			if (that.apnMsg.enable) {
				if (!that.apnMsg.profileName) return frameHstip(1, that.$t('profileName_notNull'));
				if (!that.apnMsg.apn || !checkChinese(that.apnMsg.apn)) return frameHstip(1, that.$t(
					'apn_verify'));
				if (that.apnMsg.authtype != 0) {
					if (!that.apnMsg.username) return frameHstip(1, that.$t('account_notNull'));
					if (!that.apnMsg.passwd) return frameHstip(1, that.$t('pwd_notNull'));
				}
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: "setapninfo",
				nettype: that.apnMsg.nettype,
				enable: that.apnMsg.enable ? 1 : 0,
				profileName: that.apnMsg.profileName,
				apn: that.apnMsg.apn,
				authtype: that.apnMsg.authtype,
				username: that.apnMsg.username,
				passwd: that.apnMsg.passwd,
				iptype: that.apnMsg.iptype
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		// more页
		showMorePage: function() { //获取more页面选项显隐
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getfunlist'
			})).then(function(data) {
				data.list.map(function(item) {
					var fun = document.getElementById(item.fun);
					if (fun) {
						fun.style.display = 'block';
					}
				})
			}).catch(function() {})
		},
		isDualFrequency: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getversion'
			})).then(function(data) {
				that.isDouble = data.version.split('-')[4] == 'D' ? true : false;
			}).catch(function() {})
		},
		advancedChange: function() {},
		checkSpeed: function() { //测速
			var that = this;
			axios.get('/goform/set_bandwidth_check?type=wdCheck').then(function(data) {}).catch(
			function() {})
		},
		get_pppoeserver: function() { //pppoe服务器
			var that = this;
			axios.get('/goform/get_pppoe_server?type=getpppoeserver').then(function(data) {
				that.pppoeserverMsg = data;
				that.pppoeserverMsg.spap = that.pppoeserverMsg.spap == '1' ? true : false;
				that.pppoeserverMsg.schap = that.pppoeserverMsg.schap == '1' ? true : false;
				that.pppoeserverMsg.sms_chap = that.pppoeserverMsg.sms_chap == '1' ? true : false;
				that.pppoeserverMsg.sms_chapv2 = that.pppoeserverMsg.sms_chapv2 == '1' ? true :
					false;
			}).catch(function() {})
		},
		setpppoeServer: function() { //pppoe服务器保存
			var that = this;
			if (!checkServer(that.pppoeserverMsg.saddr)) return frameHstip(1, that.$t('servername_verify'));
			if (!checkServer(that.pppoeserverMsg.startip)) return frameHstip(1, that.$t('startip_verify'));
			if (!checkServer(that.pppoeserverMsg.endip)) return frameHstip(1, that.$t('endip_verify'));
			if (!checkNum(that.pppoeserverMsg.ldpcktime) || Number(that.pppoeserverMsg.ldpcktime) > 65535 ||
				Number(that.pppoeserverMsg
					.ldpcktime) < 0) return
			frameHstip(1, that.$t('ldpcktime_verify'));
			if (!checkNum(that.pppoeserverMsg.ldpcount) || Number(that.pppoeserverMsg.ldpcount) > 65535 ||
				Number(that.pppoeserverMsg
					.ldpcount) < 0) return
			frameHstip(1, that.$t('ldpcount_verify'));
			var msg = {
				type: "setpppoeserver",
				pppoeRadio: that.pppoeserverMsg.pswitch,
				pppoeAdres: that.pppoeserverMsg.saddr,
				pppoeName: that.pppoeserverMsg.sname,
				startAddres: that.pppoeserverMsg.startip,
				endAddres: that.pppoeserverMsg.endip,
				pppoesauth: that.pppoeserverMsg.sauth,
				ldpcktime: that.pppoeserverMsg.ldpcktime,
				ldpcount: that.pppoeserverMsg.ldpcount,
			}
			if (that.pppoeserverMsg.sauth == '1') {
				msg.spap = that.pppoeserverMsg.spap ? '1' : '0';
				msg.schap = that.pppoeserverMsg.schap ? '1' : '0';
				msg.sms_chap = that.pppoeserverMsg.sms_chap ? '1' : '0';
				msg.sms_chapv2 = that.pppoeserverMsg.sms_chapv2 ? '1' : '0';
			}
			that.layerShow = true;
			axios.post('/goform/set_pppoe_server', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		setadduser: function() { //pppoe添加用户
			var that = this;
			if (!checkAlias(that.pppoeUserAdd.userAddres)) return frameHstip(1, that.$t('pppoe_Error'));
			if (!checkAlias(that.pppoeUserAdd.serverpwd)) return frameHstip(1, that.$t('pppoe_Error'));
			that.layerShow = true;
			axios.post('/goform/set_pppoe_account', JSON.stringify({
				userAddres: that.pppoeUserAdd.userAddres,
				serverpwd: that.pppoeUserAdd.serverpwd
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getpppoeuserList: function() { //获取pppoe用户列表
			var that = this;
			axios.get('/goform/get_pppoe_account?type=getpppoeaccount').then(function() {
				that.pppoeuserList = data.list;
			})
		},
		get_pppoeclient: function() { //获取拨号终端列表
			var that = this;
			axios.get('/goform/get_pppoe_client_info?type=getpppoeclient').then(function() {
				that.pppoeClientList = data.list;
			})
		},
		getMacClone: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getsubmaclist'
			})).then(function(data) {
				that.macIndex = 0;
				that.cloneMacMsg = data;
			}).catch(function() {})
		},
		setMacClone: function() {
			var that = this;
			var msg = {
				type: "setclonemac"
			}
			if (that.macIndex == 0) {
				if (!checkMac(that.cloneMacMsg.clonemac)) return frameHstip(1, that.$t('mac_verify'));
				if (isMulticastMac(that.cloneMacMsg.clonemac)) return frameHstip(1, that.$t('multicastMac_error'));
				msg.mac = that.cloneMacMsg.clonemac;
			} else {
				msg.mac = that.cloneMacMsg.list[that.macIndex - 1].mac;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getDNSMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getdnsinfo'
			})).then(function(data) {
				that.dnsMsg = data;
			}).catch(function() {})
		},
		setDNSMsg: function() {
			var that = this;
			var msg = {
				status: that.dnsMsg.status,
				type: 'setdnsinfo',
			}
			if (that.dnsMsg.status == '1') {
				if (!checkIp(that.dnsMsg.dns1)) return frameHstip(1, that.$t('dns1_verify'));
				if (that.dnsMsg.dns2) {
					if (!checkIp(that.dnsMsg.dns2)) return frameHstip(1, that.$t('dns2_verify'));
				}
				msg.dns1 = that.dnsMsg.dns1;
				msg.dns2 = that.dnsMsg.dns2;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getIptvMsg: function() { //获取iptv信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getiptvinfo'
			})).then(function(data) {
				var res = data;
				that.iptvMsg = res;
				var list = [res.lan1, res.lan2, res.lan3, res.lan4];
				that.iptvCheckList = [];
				list.map(function(item, index) {
					if (item == 1) {
						that.iptvCheckList.push('lan' + (index + 1));
					}
				})
			}).catch(function() {})
		},
		setIptvMsg: function() { // 保存iptv信息
			var that = this;
			var msg = {
				type: 'setiptvinfo',
				enable: that.iptvMsg.enable
			}
			if (that.iptvMsg.enable == 1) {
				if (!that.iptvCheckList.length) return frameHstip(1, that.$t('lan_notNull'));
				if (that.iptvCheckList.length == 4) return frameHstip(1, that.$t('lanPortLength_verify'));
				var tag = Number(that.iptvMsg.tag);
				if (tag < 3 || tag > 4094) return frameHstip(1, that.$t('iptvVLANID_verify'));
				msg.tag = that.iptvMsg.tag;
				msg.lan1 = 0;
				msg.lan2 = 0;
				msg.lan3 = 0;
				msg.lan4 = 0;
				that.iptvCheckList.map(function(item, index) {
					msg[item] = 1;
				})
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(2, that.$t('configuring'), 25);
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getIPv6Msg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getipv6info'
			})).then(function(data) {
				that.ipv6Msg = data;
			}).catch(function() {})
		},
		setIPv6Msg: function() {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setipv6info',
				ipv6_passthrough:that.ipv6Msg.ipv6_passthrough,
				lantype: that.ipv6Msg.lantype
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getIPv6Msg();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getUpnpMsg: function() { //获取upnp信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'get_upnp_info'
			})).then(function(data) {
				that.upnpMsg = data;
			}).catch(function() {})
		},
		setUpnpMsg: function() { //设置upnp信息
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'set_upnp_info',
				enable: that.upnpMsg.enable
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getUpnpMsg();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getCwmpMsg:function(){ //获取tr069信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getcwmpcfg'
			})).then(function(data) {
				that.cwmpMsg = data;
			}).catch(function() {})
		},
		setCwmpMsg:function(){ //设置tr069信息
			var that = this;
			if(!checkAcsUrl(that.cwmpMsg.url)) return frameHstip(1, that.$t('acsUrl_verify'));
			if(!checkAcsStr(that.cwmpMsg.username)) return frameHstip(1, that.$t('username') + that.$t('acs_verify'));
			if(!checkAcsStr(that.cwmpMsg.password)) return frameHstip(1, that.$t('password') + that.$t('acs_verify'));
			if(!checkAcsStr(that.cwmpMsg.manufacturer)) return frameHstip(1, that.$t('manufacturer') + that.$t('acs_verify'));
			if(!checkAcsStr(that.cwmpMsg.oui)) return frameHstip(1, 'oui' + that.$t('acs_verify'));
			if(!checkAcsStr(that.cwmpMsg.serial)) return frameHstip(1, that.$t('serialNumber') + that.$t('acs_verify'));
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setcwmpcfg',
				enable: that.cwmpMsg.enable,
				url: that.cwmpMsg.url,
				username: that.cwmpMsg.username,
				password: that.cwmpMsg.password,
				manufacturer: that.cwmpMsg.manufacturer,
				oui: that.cwmpMsg.oui,
				serial: that.cwmpMsg.serial
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getCwmpMsg();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getFlowMsg: function() { //获取流量控制信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'get4gflowassistant'
			})).then(function(data) {
				that.flowMsg = data;
				that.flowMsg.Switch = data.Switch == 1 ? true : false;
				that.MonthlyPackage = data.MonthlyPackage;
				if (that.MonthlyPackage == '0') {
					that.flowPercent = 0;
				} else {
					that.flowPercent = ((Number(data.MonDown) + Number(data.MonUp)) / (
						Number(data.MonthlyPackage) *
						1024 * 1024 * 1024 / 100)).toFixed(2);
				}
			}).catch(function() {})
		},
		setFlowMsg: function() { //流量信息保存
			var that = this;
			that.layerShow = true;
			if (Number(that.flowMsg.MonthlyPackage) < 1 || Number(that.flowMsg.MonthlyPackage) > 4096 || !(
					/(^[1-9]\d*$)/.test(
						that.flowMsg.MonthlyPackage))) {
				frameHstip(1, that.$t('mPackage_verify'));
				return false;
			}
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'set4gflowassistant',
				Switch: that.flowMsg.Switch ? 1 : 0,
				MonthlyPackage: that.flowMsg.MonthlyPackage,
				MonUp: that.flowMsg.MonUp,
				MonDown: that.flowMsg.MonDown
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getFlowMsg();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getChannelMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getchannelall'
			})).then(function(data) {
				data.configurations.map(function(item) {
					if (item.radio == '2.4G') {
						that.twoChannel = item;
					} else {
						that.fiveChannel = item;
					}
				})
			}).catch(function() {})
		},
		setChannelMsg:function(type){
			var that = this;
			var list = [];
			for(var i=52;i<65;i+=4){
				list.push(i);
			}
			for(var i=100;i<141;i+=4){
				list.push(i);
			}
			var bool = false;
			list.map(function(item){
				if(that.fiveChannel.channel==item){
					bool = true;
				}
			})
			if(bool){
				if(type=='pc'){
					that.openDFSBox();
				}else{
					that.dfsChannelShow = true;
				}
			}else{
				that.setChannelCfg();
			}
		},
		setChannelCfg:function(){
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setchannelall',
				countrycode: that.twoChannel.countrycode,
				channel: String(that.twoChannel.channel),
				htbw: String(that.twoChannel.htbw),
				countrycode_5: that.fiveChannel.countrycode,
				channel_5: String(that.fiveChannel.channel),
				htbw_5: String(that.fiveChannel.htbw)
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.dfsChannelShow = false;
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		openDFSBox:function(){
			var that = this;
			that.$confirm(that.$t('fiveChannel_dfsTip'), that.$t('tips'), {
				  confirmButtonText: that.$t('apply'),
				  cancelButtonText: that.$t('cancel'),
				  type: 'warning'
			}).then(function(){
			  that.setChannelCfg();
			}).catch()
		},
		fiveCountrycodeChange:function(){
			this.fiveChannel.channel = 0;
			if(this.specialBandwidthShow){
				this.fiveChannel.htbw = 1;
			}else{
				this.fiveChannel.htbw = 0;
			}
		},
		fiveChannelChange:function(){
			if(this.specialBandwidthShow){
				this.fiveChannel.htbw = 1;
			}
		},
		onform_postchannel: function() { //2.4g信道优化
			var that = this;
			that.layerShow = true;
			axios.post('/goform/set_scanon_cfg', JSON.stringify({
				type: 'channel'
			})).then(function(data) {
				if (data.result != 0) {
					frameHstip(1, that.$t('channelError'));
				}
			}).catch(function() {})
		},
		getchannelqualityMsg: function() {
			var that = this;
			axios.get('/goform/get_channelquality_info').then(function(data) {
				that.channelqualityMsg = data;
				if (data.quality == 0) {
					that.channelPercent = '25';
				} else if (data.quality == 1) {
					that.channelPercent = '65';
				} else {
					that.channelPercent = '100';
				}
			}).catch(function() {})
		},
		setchannelOptimiza: function() { //信道优化
			var that = this;
			that.layerShow = true;
			axios.post('/goform/set_scanon_cfg', JSON.stringify({
				mode: 'refinechannel'
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getBindList: function() { //获取绑定列表信息
			var that = this;
			axios.get('/goform/get_staticlist_info').then(function(data) {
				that.bindList = data.list;
			}).catch(function() {})
		},
		lostBind: function(row) { //解绑
			var that = this;
			that.layerShow = true;
			axios.get('/goform/set_staticlist', JSON.stringify({
				type: " setarpbind",
				mac: row.mac,
				ip: row.ip,
				bind: "0"
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getBindList();
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getWifiSchedule: function() { //获取wifi定时信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'wifi_schedule'
			})).then(function(data) {
				that.wifiTimerMsg = data;
			}).catch(function() {})
		},
		setWifiTimerSwitch: function(Switch) { // wifi定时开关切换
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'wifi_schedule_switch',
				Switch: Switch
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		wifiTimerAdd: function() { //wifi定时新增
			this.wifiTimerIndex = 1;
			this.dateIndex = 0;
			this.weekList = [0, 1, 2, 3, 4, 5, 6];
			this.wifiPeriod1 = '00';
			this.wifiPeriod2 = '00';
			this.wifiPeriod3 = '00';
			this.wifiPeriod4 = '00';
		},
		dateChange: function() {
			if (this.dateIndex == 0) {
				this.weekList = [0, 1, 2, 3, 4, 5, 6];
			} else {
				this.weekList = [];
			}
		},
		setWifiSchedule: function(action, row) { //wifi定时关闭保存
			var that = this;
			var msg = {
				type: "wifi_schedule_apply",
				action: action
			}
			that.weekList.sort(function(a, b) {
				return a - b;
			})
			if (action == 'add') {
				if (!checkTimeManage(that.wifiPeriod1, that.wifiPeriod2, that.wifiPeriod3, that
					.wifiPeriod4))
					return frameHstip(1, that.$t('accesstime_verify'));
				if (!that.weekList.length) return frameHstip(1, that.$t('week_notNull'));
				msg.period = that.wifiPeriod1 + ':' + that.wifiPeriod2 + '-' + that.wifiPeriod3 + ':' + that
					.wifiPeriod4;
				msg.week = that.weekList.join(',');
			} else {
				msg.period = row.period;
				msg.week = row.week;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				var type = action == 'add' ? that.$t('add') : that.$t('Delete');
				if (data.result == 0) {
					that.getWifiSchedule();
					frameHstip(1, type + that.$t('success'));
					if (action == 'add') {
						that.wifiTimerIndex = 0;
					}
				} else {
					frameHstip(1, type + that.$t('fail'));
				}
			}).catch(function() {})
		},
		// 定时重启
		getRestartSchedule: function() {
			var that = this;
			// var data = {"type":"get_periodic_restart","Switch":"1","list":[{"timing":"00:10","week":"0,1,2,3,4,5,6"},{"timing":"15:03","week":"3,4"}]}
			// that.scheduleRestartMsg = data;
			// return;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'get_periodic_restart'
			})).then(function(data) {
				that.scheduleRestartMsg = data;
			}).catch(function() {})
		},
		setRestartTimerSwitch: function(Switch) {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'periodic_restart_switch',
				Switch: Switch
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		restartTimerAdd: function() { //restart定时新增
			this.restartTimerIndex = 1;
			this.dateIndex = 0;
			this.weekList = [0, 1, 2, 3, 4, 5, 6];
			this.restartPeriod1 = '00';
			this.restartPeriod2 = '00';
		},
		setRestartSchedule: function(action, row) { //设置定时重启
			var that = this;
			var msg = {
				type: "periodic_restart_apply",
				action: action
			}
			that.weekList.sort(function(a, b) {
				return a - b;
			})
			if (action == 'add') {
				if (!that.weekList.length) return frameHstip(1, that.$t('week_notNull'));
				msg.timing = that.restartPeriod1 + ':' + that.restartPeriod2;
				msg.week = that.weekList.join(',');
			} else {
				msg.timing = row.timing;
				msg.week = row.week;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				var type = action == 'add' ? that.$t('add') : that.$t('Delete');
				if (data.result == 0) {
					that.getRestartSchedule();
					frameHstip(1, type + that.$t('success'));
					if (action == 'add') {
						that.restartTimerIndex = 0;
					}
				} else {
					frameHstip(1, type + that.$t('fail'));
				}
			}).catch(function() {})
		},
		getledswitchMsg: function() { //获取面板灯开关信息
			var that = this;
			axios.get('/goform/get_led_status?type=getledstatus').then(function(data) {
				that.ledswitchMsg = data;
			})
		},
		setledswitchMsg: function() { //保存面板灯开关信息
			var that = this;
			var msg = {
				LEDval: that.ledswitchMsg.status
			}
			if (that.ledswitchMsg.status == 1) {
				msg.ledeasysw = that.ledswitchMsg.ledeasysw;
				if (that.ledswitchMsg.ledeasysw == 0) {
					if (!checkHour(that.ledswitchMsg.startHour) || !checkHour(that.ledswitchMsg.endHour))
						return frameHstip(1,
							that.$t('hour_verify'));
					if (!checkMinute(that.ledswitchMsg.startMin) || !checkMinute(that.ledswitchMsg.endMin))
						return frameHstip(1,
							that.$t('minute_verify'));
					if (!checkTimeManage(that.ledswitchMsg.startHour, that.ledswitchMsg.startMin, that
							.ledswitchMsg.endHour, that.ledswitchMsg
							.endMin))
						return frameHstip(1, that.$t('accesstime_verify'));
					msg.startHour = that.ledswitchMsg.startHour;
					msg.startMin = that.ledswitchMsg.startMin;
					msg.endHour = that.ledswitchMsg.endHour;
					msg.endMin = that.ledswitchMsg.endMin;
				}
			}
			that.layerShow = true;
			axios.post('/goform/set_led_status', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			})
		},
		get_timeZone_info: function() { //获取世界时间信息
			var that = this;
			axios.get('/goform/get_time_zone').then(function(data) {
				that.timeZoneMsg = data;
			})
		},
		set_timeZone_info: function() { //设置世界时间信息
			var that = this;
			if (!checkServer(that.timeZoneMsg.ntpserver)) return frameHstip(1, '请输入且保证时间服务器地址格式正确！');
			that.layerShow = true;
			axios.post('/goform/set_time_zone', JSON.stringify({
				ntpserver: that.timeZoneMsg.ntpserver,
				ntptz: that.timeZoneMsg.ntptz,
				ntpsync: that.timeZoneMsg.ntpsync
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			})
		},
		setParentSwitch: function(Switch) {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setparentalswitch',
				Switch: Switch ? 'on' : 'off'
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		parentAdd: function() {
			this.parentIndex = 1;
			this.clientIndex = 0;
			this.parentForm.alias = null;
			for (var i = 1; i < 7; i++) {
				this['macRange' + i] = null;
			}
			for (var i = 1; i < 5; i++) {
				this['accesstime' + i] = "00";
			}
			this.parentForm.dayList = [];
			this.parOperation = this.$t('add');
		},
		parentEdit: function(row) {
			this.parentIndex = 1;
			this.parentRow = row;
			for (var i in row) {
				this.$set(this.parentForm, i, row[i]);
			}
			var accesstime = row.accesstime.split('-');
			this.accesstime1 = accesstime[0].split(':')[0];
			this.accesstime2 = accesstime[0].split(':')[1];
			this.accesstime3 = accesstime[1].split(':')[0];
			this.accesstime4 = accesstime[1].split(':')[1];
			this.parentForm.dayList = row.day.split(',');
			this.parOperation = this.$t('edit');
			this.clientIndex = 0;
			for (var i = 0; i < this.clientList.length; i++) {
				if (row.mac == this.clientList[i].mac) {
					this.clientIndex = i + 1;
				}
			}
			if (this.clientIndex == 0) {
				var mac = this.parentForm.mac.split(':');
				for (var i = 0; i < 6; i++) {
					this['macRange' + (i + 1)] = mac[i];
				}
			}
		},
		getParControl: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getparentalinfo'
			})).then(function(data) {
				that.parentControl = data;
				that.parentControl.Switch = data.Switch == 'on' ? true : false;
			}).catch(function() {})
		},
		parAddEdit: function() {
			var accesstime = this.accesstime1 + ':' + this.accesstime2 + '-' + this.accesstime3 + ':' + this
				.accesstime4;
			var mac = this.macRange1 + ':' + this.macRange2 + ':' + this.macRange3 + ':' + this.macRange4 +
				':' + this.macRange5 +
				':' + this.macRange6;
			if (!checkAlias(this.parentForm.alias)) return frameHstip(1, this.$t('alias_verify'));
			if (this.clientIndex == 0) {
				if (!checkMac(mac)) return frameHstip(1, this.$t('mac_verify'));
				if (isMulticastMac(mac)) return frameHstip(1, this.$t('multicastMac_error'));
			}
			if (!checkTimeManage(this.accesstime1, this.accesstime2, this.accesstime3, this.accesstime4))
				return frameHstip(1,
					this.$t('accesstime_verify'));
			if (!this.parentForm.dayList.length) return frameHstip(1, this.$t('date_notNull'));
			this.parentForm.dayList.sort(function(a, b) {
				return a - b;
			})
			var msg = {
				type: "setparentalinfo",
				cfg_type: 'add',
				alias: this.parentForm.alias,
				devname: this.clientIndex == 0 ? 'unknow' : this.clientList[this.clientIndex - 1].name,
				mac: this.clientIndex == 0 ? mac : this.clientList[this.clientIndex - 1].mac,
				accesstime: accesstime,
				day: this.parentForm.dayList.join(',')
			};
			if (this.parOperation == this.$t('add')) {
				msg.mac_old = this.clientIndex == 0 ? mac : this.clientList[this.clientIndex - 1].mac;
				msg.alias_old = this.parentForm.alias;
			} else if (this.parOperation == this.$t('edit')) {
				msg.mac_old = this.parentRow.mac;
				msg.alias_old = this.parentRow.alias;
			}
			this.setParControl(msg, this.parOperation);
		},
		parentDelete: function(row) {
			var msg = {
				type: 'setparentalinfo',
				cfg_type: 'del',
				alias: row.alias,
				alias_old: row.alias,
				devname: row.name,
				mac: row.mac,
				mac_old: row.mac,
				accesstime: row.accesstime,
				day: row.day
			}
			this.setParControl(msg, this.$t('Delete'));
		},
		setParControl: function(msg, type) {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, type + that.$t('success'));
					that.getParControl();
					that.parentIndex = 0;
				} else {
					frameHstip(1, type + that.$t('fail'));
				}
			}).catch(function() {})
		},
		macfocus: function(a, b, c) {
			if (a.length == 2) {
				this.$refs[b].blur();
				this.$refs[c].focus();
			}
		},
		getLoginPwd: function() { //获取原登录密码
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getmanpwd'
			})).then(function(data) {
				that.crrLoginPwdMsg = data;
			}).catch(function() {})
		},
		setLoginPwd: function() {
			var that = this;
			if (!that.loginPwd.oldPwd) return frameHstip(1, that.$t('oldPwd_notNull'));
			if (that.loginPwd.oldPwd != that.crrLoginPwdMsg.routepwd) return frameHstip(1, that.$t(
				'passError'));
			if (!checkLoginPwd(that.loginPwd.newPwd)) return frameHstip(1, that.$t('loginPwd_verify'));
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'setmanpwd',
				routepwd: that.loginPwd.newPwd
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					window.location = 'http://' + window.location.host;
				}
			}).catch(function() {})
		},
		toReset: function() { //复位
			var that = this;
			clearInterval(that.routerMsgTimer);
			clearInterval(that.deviceNumTimer);
			that.resetDialog = false;
			that.loading = true;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'restore'
			})).then(function(data) {
				if (data.result == 0) {
					that.loading = false;
					frameHstip(2, that.$t('configuring'), 70, 'login');
				}
			}).catch(function() {})
		},
		toReboot: function() { //重启
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'reboot'
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(2, that.$t('configuring'), 70, 'login');
				}
			}).catch(function() {})
		},
		getHardwareSwitch: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'gethwnat'
			})).then(function(data) {
				that.hardware_status = data.status;
			}).catch(function() {})
		},
		toHardwareSpeed: function() { //硬件加速
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				"type": "sethwnat",
				"status": that.hardware_status
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'))
				}
			}).catch(function() {})
		},
		// usb
		usbUninstall: function() {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'umountusb'
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('uninstallSuccess'));
					that.getUsbEnable(that.usbType);
				} else {
					frameHstip(1, that.$t('uninstallFail'));
				}
			}).catch(function() {})
		},
		getUsbEnable: function(type) { //获取是否有可用的usb设备
			var that = this;
			// var data = {
			// 	usbenable:'enable'
			// }
			// that.usbType = type;
			// if(data.result&&data.result==1){
			// 	that.usbenable = 'disable';
			// }else{
			// 	that.usbenable = data.usbenable;
			//   if(that.usbenable=='enable'){
			//     var usbType = that.usbType == 'ftp' ? 'getftpcfg' : 'getsambacfg';
			//      that.getUsbMsg(usbType);
			//   }
			// }
			// return;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getusbenable'
			})).then(function(data) {
				that.usbType = type;
				if (data.result && data.result == 1) {
					that.usbenable = 'disable';
				} else {
					that.usbenable = data.usbenable;
					if (that.usbenable == 'enable') {
						var usbType = that.usbType == 'ftp' ? 'getftpcfg' : 'getsambacfg';
						that.getUsbMsg(usbType);
					}
				}
			}).catch(function() {})
		},
		setUsbSwitch: function(Switch) { //切换开关
			var that = this;
			var type = that.usbType == 'ftp' ? 'setftpswitch' : 'setsambaswitch';
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: type,
				Switch: Switch
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getUsbMsg: function(type) {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: type
			})).then(function(data) {
				var response = data;
				that.usbMsg.Switch = response.Switch;
				that.usbMsg.username = that.usbType == 'ftp' ? response.ftpuser : response
				.sambauser;
				that.usbMsg.password = that.usbType == 'ftp' ? response.ftppasswd : response
					.sambapasswd;
				that.usbMsg.path = response.path;
				that.usbSharedList = [];
				if (that.usbType == 'ftp') {
					if (response.path) {
						that.usbSharedList.push({
						path: response.path
					})
					}
				} else {
					that.usbSharedList = response.list;
				}
			}).catch(function() {})
		},
		setUsbMsg: function() { //设置ftp信息
			var that = this;
			if (!checkUsbStr(that.usbMsg.username)) return frameHstip(1, that.$t('usbUsername_verify'));
			var bool = false;
			var disabledList = ['daemon','network','nobody','dnsmasq'];
			disabledList.map(function(item){
				if(that.usbMsg.username==item){
					bool = true;
				}
			})
			if(bool) return frameHstip(1, that.$t('username')+that.usbMsg.username+that.$t('usbUsername_repeat'))
			if (!checkUsbStr(that.usbMsg.password)) return frameHstip(1, that.$t('usbPwd_verify'));
			var msg = {};
			if (that.usbType == 'ftp') {
				msg = {
					type: 'setftpcfg',
					ftpuser: that.usbMsg.username,
					ftppasswd: that.usbMsg.password
				}
			} else {
				msg = {
					type: 'setsambacfg',
					sambauser: that.usbMsg.username,
					sambapasswd: that.usbMsg.password
				}
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		usbSharedDel: function(row) { //共享目录删除
			var that = this;
			var msg = {};
			if (that.usbType == 'ftp') {
				msg = {
					type: 'delftppath',
					ftppath: row.path
				}
			} else {
				msg = {
					type: 'delsambapath',
					sambapath: row.path
				}
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('delSuccess'));
					var usbType = that.usbType == 'ftp' ? 'getftpcfg' : 'getsambacfg';
					that.getUsbMsg(usbType);
				} else {
					frameHstip(1, that.$t('delFail'));
				}
			}).catch(function() {})
		},
		usbSharedAdd: function() {
			this.getDiskPath();
			this.usbIndex = 1;
		},
		getDiskPath: function() { //获取磁盘路径
			var that = this;
			// var data = {
			// 	data:{
			// 		list:[{
			// 			usbpath:'/bcd'
			// 		},{
			// 			usbpath:'/abc'
			// 		},{
			// 			usbpath:'/1234'
			// 		}]
			// 	}
			// }
			// that.diskList = data.list;
			// return;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getusballpath'
			})).then(function(data) {
				that.diskList = data.list;
				if (that.usbType == 'ftp') {
					that.diskList.map(function(item) {
						if (that.usbMsg.path == item.usbpath) {
							that.usbCheckRow = item;
							item.checked = true;
						}
					})
				} else {
					that.diskList.map(function(item) {
						that.usbSharedList.map(function(sItem) {
							if (item.usbpath == sItem.path) {
								item.checked = true;
							}
						})
					})
				}
			}).catch(function() {})
		},
		setUsbPath: function() { //设置共享目录
			var that = this;
			var bool = false;
			var list = [];
			that.diskList.map(function(item) {
				if (item.checked) {
					bool = true;
					list.push({
						sambapath: item.usbpath
					})
				}
			})
			var msg = {};
			if (that.usbType == 'ftp') {
				if (!bool) return frameHstip(1, that.$t('ftp_diskPath_notNull'));
				msg = {
					type: 'setftppath',
					ftppath: that.usbCheckRow.usbpath
				}
			} else {
				if (!bool) return frameHstip(1, that.$t('samba_diskPath_notNull'));
				msg = {
					type: 'setsambapath',
					list: list
				}
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.usbIndex = 0;
					var usbType = that.usbType == 'ftp' ? 'getftpcfg' : 'getsambacfg';
					that.getUsbMsg(usbType);
				} else if (data.result == 2) {
					if (that.usbType == 'samba') {
						frameHstip(1, that.$t('sambaNum_verify'));
					}
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getVpnMsg: function(type) {
			var that = this;
			if (type == 'getpptpinfo') {
				that.vpnType = 'pptp';
			} else {
				that.vpnType = 'l2tp';
			}
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: type
			})).then(function(data) {
				that.vpnMsg = data;
				that.vpnMsg.Switch = data.Switch == 'on' ? true : false;
			}).catch(function() {})
		},
		setVpnMsg: function() {
			var that = this;
			var msg = {};
			if (that.vpnMsg.Switch) {
				if (!checkServer(that.vpnMsg.domain)) return frameHstip(1, that.$t('domain_verify'));
				if (!checkAlias(that.vpnMsg.username)) return frameHstip(1, that.$t('account_verify'));
				if (!checkAlias(that.vpnMsg.password)) return frameHstip(1, that.$t('pwd_verify'));
				if (that.vpnMsg.netmode == 'Static') {
					if (!checkIp(that.vpnMsg.staticip)) return frameHstip(1, that.$t('ip_verify'));
					if (!checkMask(that.vpnMsg.staticmask)) return frameHstip(1, that.$t('mask_verify'));
					if (!checkIp(that.vpnMsg.staticgateway)) return frameHstip(1, that.$t(
					'gateway_verify'));
					var ipRangle = that.vpnMsg.staticip.split('.');
					var gatewayRangle = that.vpnMsg.staticgateway.split('.');
					var maskRangle = that.vpnMsg.staticmask.split('.');
					for (var i = 0; i < 3; i++) {
						if (bitOperation(gatewayRangle[i], maskRangle[i]) != bitOperation(ipRangle[i],
								maskRangle[i])) return frameHstip(1, that.$t('ip_gateway_same'));
					}
				}
				if (!checkMtu(that.vpnMsg.MTU)) return frameHstip(1, that.$t('mtu_verify'));
				msg = {
					type: that.vpnType == 'pptp' ? 'setpptpinfo' : 'setl2tpinfo',
					Switch: 'on',
					domain: that.vpnMsg.domain,
					username: that.vpnMsg.username,
					password: that.vpnMsg.password,
					netmode: that.vpnMsg.netmode,
					MTU: that.vpnMsg.MTU
				}
				if (that.vpnMsg.netmode == 'Static') {
					msg.staticip = that.vpnMsg.staticip;
					msg.staticmask = that.vpnMsg.staticmask;
					msg.staticgateway = that.vpnMsg.staticgateway;
				}
			} else {
				msg = {
					type: that.vpnType == 'pptp' ? 'setpptpinfo' : 'setl2tpinfo',
					Switch: 'off'
				}
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getDMZMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getdmz'
			})).then(function(data) {
				that.dmzMsg = data;
			}).catch(function() {})
		},
		setDMZMsg: function() {
			var that = this;
			var msg = {
				type: 'setdmz',
				enable: String(that.dmzMsg.enable),
				port: '8080'
			}
			if (that.dmzMsg.enable == '1') {
				if (!checkIp(that.dmzMsg.ip)) return frameHstip(1, that.$t('ip_verify'));
				msg.ip = that.dmzMsg.ip;
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				}else{
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getwebadminMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'get_remote_manage'
			})).then(function(data) {
				that.webadminMsg = data;
			}).catch(function() {})
		},
		setWebadminSwitch: function(Switch){
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type:'remote_manage_switch',
				Switch:Switch
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				}else{
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		setwebadminMsg: function() {
			var that = this;
			var msg = {
				type: 'set_remote_manage',
				remote_manage_port: that.webadminMsg.remote_manage_port 
			}
			if (!checkPort(that.webadminMsg.remote_manage_port)) return frameHstip(1, that.$t('port_verify'));
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				}else{
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getPortForward: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getforwarding'
			})).then(function(data) {
				that.portForward = data;
			}).catch(function() {})
		},
		portAdd: function() {
			this.portIndex = 1;
			this.portOperaType = 0;
			for (var i in this.portForm) {
				this.portForm[i] = null;
			}
			this.lanPort1 = null;
			this.lanPort2 = null;
			this.wanPort1 = null;
			this.wanPort2 = null;
			this.portForm.protocol = 'TCP';
			this.clientIndex = 0;
		},
		portEdit: function(index) {
			this.portIndex = 1;
			this.portOperaType = 1;
			this.portEditIndex = index;
			this.portForm.name = this.portForward.list[index].name;
			var that = this;
			that.clientIndex = that.clientList.length;
			that.portForm.ip = that.portForward.list[index].ip;
			if (that.clientList.length) {
				that.clientList.map(function(aItem, aIndex) {
					if (that.portForward.list[index].ip == aItem.ip) {
						that.clientIndex = aIndex;
					}
				})
			}
		},
		portFormat:function(str){
			if(!str) return '';
			str = str.trim();
			str = str.replace(/^[0]+/,'');
			return str;
		},
		portAddEdit: function() { //端口手动添加编辑
			if (!checkAlias(this.portForm.name)) return frameHstip(1, this.$t('alias_verify'));
			if (this.clientIndex == this.clientList.length) {
				if (!checkIp(this.portForm.ip)) return frameHstip(1, this.$t('ip_verify'));
			}
			this.wanPort1 = this.portFormat(this.wanPort1);
			this.wanPort2 = this.portFormat(this.wanPort2);
			this.lanPort1 = this.portFormat(this.lanPort1);
			this.lanPort2 = this.portFormat(this.lanPort2);
			if (this.portOperaType == 0) {
				if (!checkPorts(this.wanPort1, this.wanPort2)) return frameHstip(1, this.$t(
					'wanport_verify'));
				if (!checkPorts(this.lanPort1, this.lanPort2)) return frameHstip(1, this.$t(
					'lanport_verify'));
			}
			var msg = {
				type: 'setforwarding',
				enable: 1,
				name: this.portForm.name,
				ip: this.clientIndex == this.clientList.length ? this.portForm.ip : this.clientList[this
					.clientIndex].ip
			};
			if (this.portOperaType == 0) { //新增
				msg.name_old = this.portForm.name;
				var wanport = this.wanPort1 == this.wanPort2 ? this.wanPort1 : this.wanPort1 + '-' + this
					.wanPort2;
				var lanport = this.lanPort1 == this.lanPort2 ? this.lanPort1 : this.lanPort1 + '-' + this
					.lanPort2;
				msg.list0 = wanport + ',' + lanport + ',' + this.portForm.protocol;
				this.setPortForward(msg, this.$t('add'));
			} else { //编辑
				msg.name_old = this.portForward.list[this.portEditIndex].name;
				var sublist = this.portForward.list[this.portEditIndex].sublist;
				for (var i = 0; i < sublist.length; i++) {
					msg['list' + i] = sublist[i].wanport + ',' + sublist[i].lanport + ',' + sublist[i]
						.protocol;
				}
				this.setPortForward(msg, this.$t('save'));
			}
		},
		portDelete: function(row) { //端口转发删除
			var msg = {
				type: 'setforwarding',
				enable: 0,
				name: row.name,
				name_old: row.name,
				ip: row.ip
			}
			var sublist = row.sublist;
			for (var i = 0; i < sublist.length; i++) {
				msg['list' + i] = '';
			}
			this.setPortForward(msg, this.$t('Delete'));
		},
		portAutoAdd: function() { //端口转发自动添加
			var msg = {
				type: 'setforwarding',
				enable: 1,
				ip: this.clientIndex == this.clientList.length ? this.portForm.ip : this.clientList[this
					.clientIndex].ip,
				name: portNameList[this.portNameIndex].name,
				name_old: portNameList[this.portNameIndex].name
			}
			var portList = portNameList[this.portNameIndex].list;
			for (var i = 0; i < portList.length; i++) {
				msg['list' + i] = portList[i].wanport + ',' + portList[i].lanport + ',' + portList[i]
					.protocol;
			}
			this.setPortForward(msg, this.$t('add'));
		},
		portDetail: function(row) { //端口信息
			this.portIndex = 3;
			this.portSubRow = row;
		},
		portAdd2: function() {
			this.portOperaType = 0;
			this.portAddEditDialog = true;
			this.lanPort1 = null;
			this.lanPort2 = null;
			this.wanPort1 = null;
			this.wanPort2 = null;
			this.portForm.protocol = 'TCP';
		},
		portEdit2: function(index) {
			this.portOperaType = 1;
			this.portAddEditDialog = true;
			this.portSubListIndex = index;
			var portMsg = this.portSubRow.sublist[index];
			this.wanPort1 = portMsg.wanport.split('-')[0];
			if (portMsg.wanport.split('-').length == 1) {
				this.wanPort2 = portMsg.wanport.split('-')[0];
			} else {
				this.wanPort2 = portMsg.wanport.split('-')[1];
			}
			this.lanPort1 = portMsg.lanport.split('-')[0];
			if (portMsg.lanport.split('-').length == 1) {
				this.lanPort2 = portMsg.lanport.split('-')[0];
			} else {
				this.lanPort2 = portMsg.lanport.split('-')[1];
			}
			this.portForm.protocol = portMsg.protocol;
		},
		portQueryAddEdit: function() { //端口转发新增编辑
			this.wanPort1 = this.portFormat(this.wanPort1);
			this.wanPort2 = this.portFormat(this.wanPort2);
			this.lanPort1 = this.portFormat(this.lanPort1);
			this.lanPort2 = this.portFormat(this.lanPort2);
			if (!checkPorts(this.wanPort1, this.wanPort2)) return frameHstip(1, this.$t('wanport_verify'));
			if (!checkPorts(this.lanPort1, this.lanPort2)) return frameHstip(1, this.$t('lanport_verify'));
			var wanport = this.wanPort1 == this.wanPort2 ? this.wanPort1 : this.wanPort1 + '-' + this
				.wanPort2;
			var lanport = this.lanPort1 == this.lanPort2 ? this.lanPort1 : this.lanPort1 + '-' + this
				.lanPort2;
			if (this.portOperaType == 0) {
				this.portSubRow.sublist.push({
					wanport: wanport,
					lanport: lanport,
					protocol: this.portForm.protocol
				})
			} else {
				this.portSubRow.sublist[this.portSubListIndex].wanport = wanport;
				this.portSubRow.sublist[this.portSubListIndex].lanport = lanport;
				this.portSubRow.sublist[this.portSubListIndex].protocol = this.portForm.protocol;
			}
			this.portAddEditDialog = false;
		},
		portSublistSave: function() {
			var msg = {
				type: 'setforwarding',
				enable: 1,
				ip: this.portSubRow.ip,
				name: this.portSubRow.name,
				name_old: this.portSubRow.name
			}
			var portList = this.portSubRow.sublist;
			for (var i = 0; i < portList.length; i++) {
				msg['list' + i] = portList[i].wanport + ',' + portList[i].lanport + ',' + portList[i]
					.protocol;
			}
			this.setPortForward(msg, this.$t('add'));
		},
		setPortForward: function(msg, type) {
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, type + that.$t('success'));
					that.getPortForward();
					that.portIndex = 0;
				} else {
					frameHstip(1, type + that.$t('fail'));
				}
			}).catch(function() {})
		},
		setvserverMsg: function() { // 虚拟服务器信息保存
			var that = this;
			if (!checkIp(that.vserverForm.ip)) return frameHstip(1, that.$t('ip_verify'));
			if (!checkPort(that.vserverForm.pu_port)) return frameHstip(1, that.$t('port_verify'));
			if (!checkPort(that.vserverForm.pr_port)) return frameHstip(1, that.$t('port_verify'));
			that.layerShow = true;
			axios.post('/goform/set_virtual_cfg', JSON.stringify({
				enable: '1',
				ip: that.vserverForm.ip,
				pu_port: that.vserverForm.pu_port,
				pr_port: that.vserverForm.pr_port,
				protocol: that.vserverForm.protocol
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.getvserverMsg();
					that.vserverType = 1;
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getvserverMsg: function() { //获取虚拟服务器信息
			var that = this;
			axios.get('/goform/get_virtual_cfg?type=getvserver').then(function(data) {
				that.vserverList = data.list;
			}).catch(function() {})
		},
		vserverDelete: function(row) { //虚拟服务器信息删除
			var that = this;
			that.layerShow = true;
			axios.post('/goform/set_virtual_cfg', JSON.stringify({
				type: "setvserver",
				enable: 0,
				ip: row.ip,
				pu_port: row.pu_port,
				pr_port: row.pr_port,
				protocol: row.protocol
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getpluginMsg: function() { //获取第三方插件信息
			var that = this;
			axios.get('/goform/get_plugins_cfg?type=getmarketcfg').then(function(data) {
				if (data.fun & (0x01) == 1) {
					that.pluginRadio = '1'
				} else {
					that.pluginRadio = '0';
				}
			}).catch(function() {})
		},
		setpluginMsg: function() { //设置第三方插件开关
			var that = this;
			that.layerShow = true;
			axios.get('/goform/set_plugins_cfg', JSON.stringify({
				type: 'setmarketcfg',
				fun: that.pluginRadio
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		getShareMsg: function() { //获取共享wifi信息
			var that = this;
			axios.get('/goform/get_shared_info?type=getsharewifiswitch').then(function(data) {
				that.shareMsg = data;
			}).catch(function() {})
		},
		setShareMsg: function() { // 保存共享wifi信息
			var that = this;
			that.layerShow = true;
			axios.post('/goform/set_sharewifi_switch', JSON.stringify({
				type: "setwifilimitinfo",
				status: that.shareMsg.sharewifissid
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
				} else {
					frameHstip(1, that.$t('setFail'));
				}
			}).catch(function() {})
		},
		// setup页面
		getModeMsg: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'geteasycfg'
			})).then(function(data) {
				that.routerStatusMsg = data;
				if (data.result == 8) {
					that.getModeMsg();
				}
				that.isDouble = (data.version).split('-')[4] == "D" ? true : false;
				that.modeType = that.routerStatusMsg.operationmode;
			}).catch(function() {})
		},
		getPreviousWanMode: function() { // 获取上一级wan模式
			var that = this;
			that.setupPage='wanPage';
			that.loading = true;
			that.previousMsg.netlink = '';
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getwanmode'
			})).then(function(data) {
				that.loading = false;
				that.previousMsg = data;
				that.wanType = data.wanmode;
				if (that.previousMsg.wanmode == 'unlink') {
					that.wanType = "";
					frameHstip(1, that.$t('nd_wan'));
				}
				for(var i in that.staticForm){
					that.staticForm[i] = "";
				}
				that.isNetStatusTimer = true;
				that.getNetStatus();
			}).catch(function() {})
		},
		getNetStatus:function(){
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getwanmode'
			})).then(function(data) {
				that.previousMsg = data;
				if (that.wanType == '' || that.wanType=='unlink') {
					that.wanType = data.wanmode;
				}
				if(that.isNetStatusTimer){
					setTimeout(that.getNetStatus,3000);
				}
			}).catch(function() {})
		},
		wispPageChange: function(page) { // wisp模式页数切换
			this.curPagewispData = this.wispData[page - 1];
		},
		wispRowClick: function(row, type) { //0代表pc端，1代表手机端
			if (type == 0) {
				this.wispPwdDialog = true
			} else {
				this.setupPage = 'wispPwdPage';
			}
			this.wispWifiRow = row;
			this.wispForm.ssid = row.ssid;
		},
		getCurWispWifi: function() { //获取当前wisp模式连接的wifi
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getconnetsta'
			})).then(function(data) {
				that.curWispWifiMsg = data;
			}).catch(function() {})
		},
		getwispWifiList: function() { //获取wisp模式wifi列表
			var that = this;
			that.wispLoading = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getrepeaterinfo'
			})).then(function(data) {
				that.wispLoading = false;
				that.wispList = data.list;
				that.wispList.map(function(item, index) {
					item.checked = false;
					if (item.bssid.toLowerCase() == that.curWispWifiMsg.mac.toLowerCase()) {
						item.checked = true;
						that.wispList.unshift(item);
						that.wispList.splice(index + 1, 1);
					}
				})
				that.wispData = [];
				for (var i = 0, len = data.list.length; i < len; i += 6) {
					that.wispData.push(data.list.slice(i, Math.min(i + 6, len)));
				}
				that.wispCurPage = 1;
				that.curPagewispData = that.wispData[0];
			}).catch(function() {})
		},
		wispPwdSet: function() {
			if (this.wispWifiRow.security.toUpperCase().indexOf('NONE')==-1) {
				if (!checkPassword(this.wispForm.password)) return frameHstip(1, this.$t('wifiPwd_verify'));
			}
			this.wispPwdDialog = false;
			this.setupPage = 'wifiPage';
			this.getWifiMsg();
		},
		backStep: function(type) { //上一步
			this.isNetStatusTimer = false;
			switch (type) {
				case 'wanPage':
					this.setupPage = 'modePage';
					break;
				case 'wifiPage':
					if (this.modeType == 'router') {
						this.setupPage = 'wanPage';
					} else {
						this.setupPage = 'modePage';
					}
					break;
			}
		},
		nextStep: function(type) { //下一步
			this.isNetStatusTimer = false;
			switch (type) {
				case 'adminPage': //管理密码到模式选择
					if (this.loginSetForm.password != this.routerStatusMsg.password) return frameHstip(1,
						this.$t('loginPwd_error'));
					if (!this.loginSetForm.userProtocol) return frameHstip(1, this.$t('user_protocol'));
					this.setupPage = 'modePage';
					break;
				case 'wanPage': //到wifi设置
					if (!this.wanType || this.wanType=='unlink') return frameHstip(1, this.$t('wanMode_notNull'));
					if (this.wanType == 'pppoe') {
						if (!checkAlias(this.pppoeForm.pppoename)) return frameHstip(1, this.$t(
							'account_verify'));
						if (!checkAlias(this.pppoeForm.pppoepsw)) return frameHstip(1, this.$t(
							'pwd_verify'));
						if (this.pppoeForm.server_name) {
							if (this.pppoeForm.server_name.length < 1 || this.pppoeForm.server_name
								.length > 64)
								return frameHstip(1, this.$t('servername_verify'));
						}
						if (!checkMtu(this.pppoeForm.mtu)) return frameHstip(1, this.$t('mtu_verify'));
					} else if (this.wanType == 'static') {
						if (!checkIp(this.staticForm.wanip)) return frameHstip(1, this.$t('ip_verify'));
						if (!checkMask(this.staticForm.wanmsk)) return frameHstip(1, this.$t(
							'mask_verify'));
						if (!checkIp(this.staticForm.wangw)) return frameHstip(1, this.$t(
							'gateway_verify'));
						var ipRangle = this.staticForm.wanip.split('.');
						var gatewayRangle = this.staticForm.wangw.split('.');
						var maskRangle = this.staticForm.wanmsk.split('.');
						for (var i = 0; i < 3; i++) {
							if (bitOperation(ipRangle[i], maskRangle[i]) != bitOperation(gatewayRangle[i],
									maskRangle[i])) return frameHstip(1, this.$t('ip_gateway_same'));
						}
						if (!checkIp(this.staticForm.dns1)) return frameHstip(1, this.$t('dns_verify'));
					}
					this.getWifiMsg();
					this.setupPage = 'wifiPage';
					break;
			}
		},
		setRouter: function() {
			var that = this;
			if (!checkSsid(that.twoWifiMsg.wlanssid)) return frameHstip(1, that.$t('ssid_verify'));
			if (!checkPassword(that.twoWifiMsg.wlanpsw)) return frameHstip(1, that.$t('wifiPwd_verify'));
			var msg = {
				type: "seteasycfg",
				opermode: that.modeType,
				wlan2ssid: that.twoWifiMsg.wlanssid,
				wlan2psw: that.twoWifiMsg.wlanpsw
			}
			if (that.modeType == 'router') {
				msg.wanmode = that.wanType;
				if (that.wanType == "pppoe") { //pppoe
					msg.pppoename = that.pppoeForm.pppoename;
					msg.pppoepsw = that.pppoeForm.pppoepsw;
					msg.server_name = that.pppoeForm.server_name;
					msg.mtu = that.pppoeForm.mtu;
				} else if (that.wanType == "static") {
					msg.wanip = that.staticForm.wanip;
					msg.wanmsk = that.staticForm.wanmsk;
					msg.wangw = that.staticForm.wangw;
					msg.dns1 = that.staticForm.dns1;
				}
			}
			if (that.modeType == 'wisp' || that.modeType == 'repeater') {
				msg.wifi_type = that.wispWifiRow.wifi_type;
				msg.channel = that.wispWifiRow.channel;
				msg.bssid = that.wispWifiRow.bssid;
				msg.ssid = that.wispWifiRow.ssid;
				msg.security = that.wispWifiRow.security;
				msg.ext_ch = that.wispWifiRow.ext_ch;
				msg.arithmetic = 'AES';
				msg.key = that.wispForm.password;
			}
			if (that.isDouble) {
				if (!checkSsid(that.fiveWifiMsg.wlanssid)) return frameHstip(1, that.$t('fiveSsid_verify'));
				if (!checkPassword(that.fiveWifiMsg.wlanpsw)) return frameHstip(1, that.$t(
					'fiveWifiPwd_verify'));
				msg.wlan5ssid = that.fiveWifiMsg.wlanssid;
				msg.wlan5psw = that.fiveWifiMsg.wlanpsw;
			}
			msg.routepwd = that.routerStatusMsg.jumpflag == '1' ? that.loginSetForm.password : that
				.crrLoginPwdMsg.routepwd;
			that.loading = true;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify(msg)).then(function(data) {
				that.loading = false;
				that.setupPage = 'settingPage';
				countdownFun(35,'login');
			}).catch(function() {})
		},
		// 终端列表页
		getTerminalList: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				"type": "getterminallist"
			})).then(function(data) {
				that.clientList = data.list;
				that.wiredTerlist = [];
				that.twoTerlist = [];
				that.fiveTerlist = [];
				data.list.map(function(item) {
					if (item.link_type == '0') {
						that.wiredTerlist.push(item);
					} else if (item.link_type == '1') {
						that.twoTerlist.push(item);
					} else {
						that.fiveTerlist.push(item);
					}
				})
			}).catch(function() {})
		},
		terTab: function(type) { //终端列表切换
			this.terListType = type;
			if (type == 0) {
				this.getTerminalList();
				this.terTimer = setInterval(this.getTerminalList, 6000);
				clearInterval(this.blackTimer);
			} else if (type == 1) {
				this.getBlackList();
				clearInterval(this.terTimer);
				this.blackTimer = setInterval(this.getBlackList, 6000);
			}
		},
		terManage: function(item) {
			for (var i in item) {
				this.$set(this.terminaForm, i, item[i]);
			}
			this.terManDialog = true;
			this.getQosMsg();
		},
		ternameQueryEdit: function() { //设备列表名称编辑
			var that = this;
			if (!checkAlias(that.terminaForm.name)) return frameHstip(1, that.$t('devicename_verify'));
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				"type": "setalias",
				mac: that.terminaForm.mac,
				alias: that.terminaForm.name
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'))
					that.ternameEdit = false;
				} else {
					frameHstip(1, that.$t('setFail'))
				}
			}).catch(function() {})
		},
		getQosMsg: function() { //获取qos信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: "getqos",
				MAC: that.terminaForm.mac
			})).then(function(data) {
				that.qosMsg = data;
				that.isSpeedLimit = Boolean(that.qosMsg.Up_Speed);
			}).catch(function() {})
		},
		setQosMsg: function(value) { //设置qos信息
			var that = this;
			if (value != 'unlimitedSpeed') {
				var upSpeed = that.qosMsg.Up_Speed;
				var dlSpeed = that.qosMsg.Dl_Speed;
				if (!upSpeed && upSpeed !== 0) return frameHstip(1, that.$t('upSpeed_notNull'));
				if (!checkPositiveInteger(Number(upSpeed))) return frameHstip(1, that.$t('upSpeed_verify'));
				if (!dlSpeed && dlSpeed !== 0) return frameHstip(1, that.$t('dlSpeed_notNull'));
				if (!checkPositiveInteger(Number(dlSpeed))) return frameHstip(1, that.$t('dlSpeed_verify'));
			}
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				"type": "setqos",
				MAC: that.terminaForm.mac,
				IP: that.terminaForm.ip,
				Up_Speed: value == 'unlimitedSpeed' ? '0' : upSpeed,
				Dl_Speed: value == 'unlimitedSpeed' ? '0' : dlSpeed
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setSuccess'));
					that.terManDialog = false;
				} else {
					frameHstip(1, that.$t('setFail'))
				}
			}).catch(function() {})
		},
		setBlack: function() { //拉黑
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: "setmacblack",
				mac: that.terminaForm.mac,
				enable: "1",
				devname: that.terminaForm.name
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('setBlackSuccess'));
					that.terManDialog = false;
				} else {
					frameHstip(1, that.$t('setBlackFail'));
				}
			}).catch(function() {})
		},
		lostBlack: function(item) { // 解禁
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: "setmacblack",
				mac: item.mac,
				enable: "0",
				devname: item.name
			})).then(function(data) {
				if (data.result == 0) {
					frameHstip(1, that.$t('forbidSuccess'));
					that.getBlackList();
				} else {
					frameHstip(1, that.$t('forbidFail'));
				}
			}).catch(function() {})
		},
		getBlackList: function() { //获取黑名单列表
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getblacklist'
			})).then(function(data) {
				that.blackList = data.list;
			}).catch(function() {})
		},
		// 固件升级
		upgradeTypeTab:function(type){
			this.upgradeType = type;
			if(this.upgradeType==0){
				this.getVersionMsg();
				this.verisionTimer = setInterval(this.getVersionMsg, 5000);
				if (this.versionMsg.lastver) {
					clearInterval(this.verisionTimer);
					this.verisionTimer = setInterval(this.getVersionMsg, 8000);
				}
			}
		},
		getVersionMsg: function() { //获取版本号信息
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getfirmver'
			})).then(function(data) {
				that.versionMsg = data;
				that.onlineDisable = !compVer(that.versionMsg.curver, that.versionMsg.lastver);
				// if (data.result == 1) return frameHstip(1, that.$t('system_error'));
				// if (data.result == 4) return frameHstip(1, that.$t('net_error'));
				// if (data.result == 5) return frameHstip(1, that.$t('model_error'));
			}).catch(function() {})
		},
    	uploadChange:function(files, fileList){
			if (fileList.length > 1) {
				fileList.splice(0, 1);
			}
		},
		beforeUpload:function(file){
			var size = parseInt(file.size/1024);
			if(size<10||size>2048){
				frameHstip(1, this.$t('fileFormatError'));
				return false;
			}
			return true;
		},
		submitSuccess: function(response, file, fileList,type) { //升级
			if (response.result == 0) {
				if(type=='upgrade'){
					frameHstip(2, this.$t('upgrading'), 140, 'login');
				}else{
					frameHstip(2, this.$t('rebooting'), 100, 'login');
				}
			} else {
				frameHstip(1, this.$t('fileFormatError'));
			}
		},
		fileSubmit: function() {
			if(this.upgradeType==0){
				this.$refs.upgrade.submit();
			}else{
				this.$refs.recover.submit();
			}
		},
		upgradeOnline: function() { //在线升级
			var that = this;
			that.layerShow = true;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'upgrade'
			})).then(function(data) {
				if (data.result == 0) {
					clearInterval(that.verisionTimer);
					that.onlineDisable = false;
					setTimeout(function() {
						that.getUpgradeStatus();
						that.upgradeTimer = setInterval(that.getUpgradeStatus, 5000);
					}, 3000)
				} else {
					frameHstip(1, that.$t('upgradeFail'));
				}
			}).catch(function() {})
		},
		getUpgradeStatus: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getupgradestatus'
			})).then(function(data) {
				if (data.result == 0) {
					if (data.status == 'downing') {
						frameHstip(10, that.$t('downingTip'));
					} else {
						clearInterval(that.upgradeTimer);
						that.verisionTimer = setInterval(that.getVersionMsg, 8000);
						that.onlineDisable = !compVer(that.versionMsg.curver,that.versionMsg.lastver);
						if (data.status == 'burning') {
							frameHstip(2, that.$t('burningTip'), 140, 'login');
						} else if (data.status == 'md5_Fail') {
							frameHstip(1, that.$t('md5_Fail_tip'));
						} else if (data.status == 'down_Fail') {
							frameHstip(1, that.$t('down_Fail_tip'));
						} else if (data.status == 'timeout') {
							frameHstip(1, that.$t('downloadTimeout'));
						}
					}
				} else {
					frameHstip(1, that.$t('upgradeFail'));
				}
			}).catch(function() {})
		},
		backup:function(){ //备份
			window.open('/cgi-bin/backup.cgi','_self');
		},
		// 手机端
		featurePage: function(index, title) {
			this.mobileIndex = index;
			this.featureTitle = title;
			this.navIndex = 2;
		},
		callBack: function() { // 返回
			if (this.mobileIndex == 'terminallist' && this.terManDialog) {
				this.terManDialog = false;
				this.getTerminalList();
			} else {
				this.navIndex = 1;
				this.mobileIndex = null;
			}
			if (this.terTimer) {
				clearInterval(this.terTimer);
			}
			if (this.blackTimer) {
				clearInterval(this.blackTimer);
			}
		},
		get_Router_status: function() { //获取路由器信息
			var that = this;
			// var data = {
			// 	cpu: "",
			// 	downspeed: "0",
			// 	netstatus: "unlink",
			// 	operationmode: "router",
			// 	ternum: 0,
			// 	upspeed: "0",
			// 	uptime: "",
			// 	ver: "",
			// 	wanstatus: "",
			// 	wanip:"111"
			// }
			// that.routerStatus = data;
			// return;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getrouterstatus'
			})).then(function(data) {
				that.routerStatus = data;
			}).catch(function() {})
		},
		mobilePage: function() {
			var that = this;
			axios.post('/cgi-bin/lighttpd.cgi', JSON.stringify({
				type: 'getmobilefunlist'
			})).then(function(data) {
				data.list.map(function(item) {
					var fun = document.getElementById(item.fun);
					if (fun) {
						fun.style.display = 'block';
					}
				})
			}).catch(function() {})
		}
	}
}).$mount('#container')

