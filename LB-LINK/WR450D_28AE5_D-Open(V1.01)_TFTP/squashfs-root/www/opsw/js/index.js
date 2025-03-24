var i18n = new VueI18n({
	locale: 'TR',
	messages: messages
})
var vm = new Vue({
	i18n: i18n,
	data: function() {
		return {
			softwareType:'common',     //common代表普通的，neutral代表中性
			dhcpIpRange: '192.168.0',
			// isLanSave:false,
			skipPageType: 0, // 跳转到哪个页面
			layerShow: false,
			countdown: 0,
			tips: '',
			isCount: false,
			frameTips: '',
			setting_title: '', //设置页标题
			set_nav_title: '',
			setting_description: '', ////设置页描述
			setting_img: '', //设置图片
			feature_title: '', //feature页标题
			feature_description: '', ////feature页描述
			feature_img: '', //feature图片
			feature_nav_title: '',
			manage_title: '', //管理页标题
			manage_description: '', ////管理页描述
			manage_img: '', //管理图片
			manage_nav_title: '',
			// 登录页
			curLanguage: 'TR',
			selectIcon: false,
			loginPwd: null, //登录密码
			versionMsg: { //当前软件版本信息
				model: '',
				hwVer: '',
				softwareVer: ''
			},
			// 首页
			mainTimer: '',
			currentNetType: 5, // 当前的上网方式
			clientEditDialog: false,
			clientAddDialog: false,
			link_color: true,
			dns1: '',
			dns2: '',
			wanInfo: { //网络信息
				conn_uptime: 0,
				dns: "",
				gwaddr: "",
				ipaddr: "",
				ipv6addr_global: "",
				ipv6addr_local: "",
				ipv6addr_pd: "",
				linktype: "",
				netmask: "",
				networkStatus: null,
				wan_link_up: 1,
				wan_mac: ""
			},
			lanInfo: {
				ipv6addr_global: "",
				ipv6addr_pd: "",
				ipaddr: "",
				netmask: "",
				ipv6addr_local: "",
				lan_mac: ""
			},
			clientList: [],
			clientEditForm: {
				hostname: '',
				vendor: '',
				mac: '',
				ip: '',
				ReserveSwitch: true,
				ParentalSwitch: true
			},
			clientAddForm: {
				hostname: '',
				Vendor: '',
				mac: '',
				ip: '',
				ReserveSwitch: true,
				ParentalSwitch: true
			},
			tabIndex: 0,
			infoType: 0,
			info_title: 'Internet',
			// 设置
			settingType: 1, //设置类型
			staticAdvanced: false, //静态ip展开
			pppoeAdvanced: false, //pppoe拨号展开
			dhcpAdvanced: false, //dhcp展开
			pptpAdvanced: false, //pptp展开
			l2tpAdvanced: false, //l2tp展开
			netType: null, //网络类型
			staticMtuType: 0,
			pppoeMtuType: 0,
			dhcpMtuType: 0,
			vpnMtuType: 0,
			// l2tpMtuType: 0,
			staticForm: { //静态ip
				clone_mac: "",
				dns1: "",
				dns2: "",
				gateway: "",
				ip: "",
				mask: "",
				mtu: "",
				yourhost: "",
			},
			pppoeForm: { //pppoe
				account: "",
				clone_mac: "",
				dns1: "",
				dns2: "",
				mtu: "",
				password: "",
				yourhost: "",
				svcname:''
			},
			dhcpNetForm: { // dhcp
				clone_mac: "",
				dns1: "",
				dns2: "",
				mtu: "",
				yourhost: ""
			},
			vpnForm: { // vpn
				domain: '',
				username: '',
				password: '',
				netmode: 'DHCP',
				staticip: '',
				staticmask: '',
				staticgateway: '',
				MTU: '',
				dns1: '',
				dns2: ''
			},
			repeatDialog: false,
			repeatPwdShow: true,
			loading: true,
			repeatRadio: null,
			repeatCurPage: 1, //中继列表当前页数
			repeatPwd: '',
			curPageRepeatData: [], //中继模式当前页数据
			repeatData: [],
			repeatForm: {
				linkSecurity: "",
				linkSsid: "",
				linkStatus: "0",
				list: []
			},
			vlanForm: {
				Switch: false,
				ServiceMode: 1,
				prioritySwitch: false,
				internetId: 3,
				iptvId: 5,
				voipId: 4
			},
			modeItemShow: false,
			linkMode: 0, //当前上网类型
			title_set: 'Internet',
			img_set: '/opsw/img/internet_page.png',
			message: '',
			directions_set: this.$t('directions_internet'),
			internetType: 0,
			// wifi设置
			wirelessType: 0, //类型切换
			twoWifiAdvaced: false, //2.4g wifi高级信息
			fiveWifiAdvaced: false, //2.4g wifi高级信息
			twoWifiSwitch: true,
			fiveWifiSwitch: true,
			twoWifiMsg: {
				ssid: "",
				password: "",
				encryption: 5,
				hidden: "0",
				channel: '0',
				power: 2,
				wlanWidth: "1"
			},
			fiveWifiMsg: {
				ssid: "",
				password: "",
				encryption: 5,
				hidden: "0",
				channel: '0',
				power: 2,
				wlanWidth: "0"
			},
			wifiMsg: {
				pbcSwitch: true,
				pinSwitch: true
			},
			visForm: { //访客网络
				guest2g_disabled: true,
				guest2g_ssid: "",
				guest2g_password: "",
				guest5g_disabled: true,
				guest5g_ssid: "",
				guest5g_password: "",
				guest_isolated: true
			},
			networkForm: { //lan信息
				ip: "",
				mask: "",
				Switch: true,
				startip: "100",
				endip: '249',
				leasetime: 700,
				wanport_speed: '0',
				upnp_enable: true,
				upnp_portmap_list: []
			},
			twoGuestForm: { // 2.4G访客网络
				Switch: true,
				ssid: '',
				password: ''
			},
			fiveGuestForm: { // 5G访客网络
				Switch: true,
				ssid: '',
				password: ''
			},
			// 向导页
			wizardTopBar: true, //向导头部图片信息
			networkType: 0,
			wizard_page: 1, //向导页面
			frameShow: true,
			frame_title: null,
			// feature页
			qosSelectIndex: null, //qos当前选中行的索引
			advancedType: 0,
			QoSDialog: false, //QoS弹框
			ipv4AddDialog: false, //ipv4新增弹框
			ipv6AddDialog: false, //ipv6新增弹框
			qosAddDialog: false, //qos新增弹框
			qosEditDialog: false, //qos编辑弹框
			qosMsg: { //qos信息
				download: null,
				upload: null,
				qos_pri_list: []
			},
			qosAddForm: {
				ip: '',
				mac: '',
				qos_pri: 1
			},
			qosEditForm: {
				ip: '',
				mac: '',
				qos_pri: 1
			},
			// 防火墙
			firewallAddDialog_ipv4: false, //防火墙新增弹框
			firewallEditDialog_ipv4: false, //防火墙编辑弹框
			firewallSelectIndex: null,
			firewall_type: 0,
			firewall_advanced: {
				dmz_enabled: true,
				dmz_ip: ""
			},
			firewall_ipv4: {
				mode: '0',
				list: []
			},
			firewallList: [],
			filterType: 0, //过滤类型
			firewallAddForm_ipv4: {
				name: "",
				mac: "",
				srcifc: "wan",
				srcip: "",
				dstifc: "wan",
				dstip: "",
				protocol: "tcp",
				port: "",
			},
			firewallEditForm_ipv4: {
				name: "",
				mac: "",
				srcifc: "wan",
				srcip: "",
				dstifc: "wan",
				dstip: "",
				protocol: "tcp",
				port: "",
			},
			// 端口转发
			portType: 0,
			portAddDialog: false, //端口转发新增弹框
			portEditDialog: false, //端口转发编辑弹框
			portSelectIndex: null,
			portList: [], //端口列表
			portAddForm: {
				name: null,
				ip: null,
				wanport: null,
				lanport: null,
				protocol: null
			},
			portEditForm: {
				name: null,
				ip: null,
				wanport: null,
				lanport: null,
				protocol: null
			},
			// url过滤
			urlAddDialog: false, //url新增弹框
			urlEditDialog: false, //url编辑弹框
			urlSelectIndex: null, //当前编辑时选中的项的索引
			urlList: [],
			urlAddForm: {
				url: ''
			},
			urlEditForm: {
				url: ''
			},
			// 静态路由
			routeAddDialog: false, //新增弹框
			routeEditDialog: false, //编辑弹框
			routeList: [],
			routeSelectIndex: null,
			routeAddForm: {
				state: true,
				name: '',
				net: "",
				netmask: "",
				gateway: "",
				metric: "",
				dev: 'wan'
			},
			routeEditForm: {
				state: true,
				name: '',
				net: "",
				netmask: "",
				gateway: "",
				metric: "",
				dev: 'wan'
			},
			// 动态dns
			dnsMsg: {
				enabled: false,
				status: 0,
				domain: "",
				service_name: "",
				username: "",
				password: "",
			},
			// 管理
			manageType: 0,
			// 定时开关
			timeZoneIndex: null,
			time_type: 0, //定时开关类型
			systemTime: '',
			timeForm: {
				timezone: "",
				city: '',
				time: "",
				ntp_enabled: "1",
				ntp_server: "",
			},
			// 系统日志
			logForm: {
				syslogSwitch: true,
				ip: '',
				notificaSwitch: true,
				fromEmail: '',
				toEmail: '',
				smtpEmail: '',
				port: 25,
				authenticaSwitch: true,
				account: '',
				password: '',
				logFullSwitch: true,
				scheduleSwitch: false,
				schedule: ''
			},
			// 系统管理
			systemType: 0,
			syslog: '', //系统日志信息
			adminForm: {
				// oldPassword: '',
				newPassword: '',
				queryPassword: '',
				AuthenticaSwitch: false,
				authenticaSwitch: true,
				httpSwitch: false,
				remoteSwitch: false,
				useHttpSwitch: false
			},
			acsForm: {
				url: '',
				username: '',
				password: '',
				local_username: '',
				local_password: '',
				local_port: ''
			},
			// 升级
			inputFile: '',
			fileList: []
		}
	},
	created: function() {
		this.isTimeOut();
		this.getLanguage();
	},
	methods: {
		getHeadMsg: function(type, title, img, description) { //获取头部信息
			switch (type) {
				case 1:
					this.setting_img = img;
					this.setting_title = title;
					this.setting_description = description;
					break;
				case 2:
					this.feature_img = img;
					this.feature_title = title;
					this.feature_description = description;
					break;
				case 3:
					this.manage_img = img;
					this.manage_title = title;
					this.manage_description = description;
					break;
			}
		},
		startTimer: function() {
			var self = this;
			clearInterval(self.timeOut);
			self.timeOut = setInterval(function() {
				window.location = 'http://' + window.location.host;
			}, 1000 * 60 * 3)
		},
		isTimeOut: function() { //  三分钟页面没操作自动跳转到登录页
			this.startTimer();
			document.body.onmouseup = this.startTimer;
			document.body.onmousemove = this.startTimer;
			document.body.onkeyup = this.startTimer;
			document.body.onclick = this.startTimer;
			document.body.ontouchend = this.startTimer;
		},
		// 登录页
		getLanguage: function() { //获取当前语言
			var language = localStorage.getItem('language') || 'TR';
			this.curLanguage = language;
			this.$i18n.locale = language;
			if (language == 'EN') {
				ELEMENT.locale(ELEMENT.lang.en);
			} else {
				ELEMENT.locale(ELEMENT.lang.trTR);
			}
			if (language != 'EN' && language != 'TR') {
				this.curLanguage = 'TR';
				this.$i18n.locale = 'TR';
				ELEMENT.locale(ELEMENT.lang['trTR']);
			}
		},
		setLanguage: function(lang) { //保存当前语言
		    var that = this;
			axios.post(hostUrl + '/setLanguage', JSON.stringify({
				language: lang
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					window.localStorage.setItem('language',lang);
					that.getLanguage();
					getData();
				} else {
					frameHstip(1, that.$t('saveFail'));
				}
			}).catch(function() {})
		},
		getVersion: function() { //获取版本信息
			var self = this;
			axios.get(hostUrl + '/sysinfo').then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				self.versionMsg = data.data;
				self.versionMsg.model = 'BL-WR450D';
			})
		},
		loginIn: function() { //登录
			var self = this;
			if (!self.loginPwd) return self.$message(self.$t('pwd_notNull'));
			axios.post(hostUrl + '/login', JSON.stringify({
				username: 'CMCCAdmin',
				password: self.loginPwd
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					self.$message(self.$t('loginSuccess'));
					window.location = 'http://' + window.location.host + hostUrl + '/main.html';
				} else {
					if (data.data.err == 1) return self.$message(self.$t('wrongPwd'));
				}
			}).catch(function() {})
		},
		// 首页
		getWanInfo: function() { //获取wan信息
			var self = this;
			axios.get(hostUrl + '/wan_info').then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				self.wanInfo = data.data;
				if (self.wanInfo.networkStatus == 0) {
					self.link_color = true;
				} else if (self.wanInfo.networkStatus == 1) {
					self.link_color = false;
				} else {
					self.link_color = false;
				}
				var dnsRange = self.wanInfo.dns.split(' ');
				if (self.wanInfo.dns == '') {
					self.dns1 = '';
					self.dns2 = '';
				} else {
					self.dns1 = dnsRange[0]
					if (dnsRange.length == 2) {
						self.dns2 = dnsRange[1];
					}
				}
			})
		},
		getLanInfo: function() { //获取lan信息
			var self = this;
			axios.get(hostUrl + '/lan_info').then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				self.lanInfo = data.data;
			})
		},
		getIndexTabInfo: function(type) { //首页切换信息
			this.infoType = type;
			switch (type) {
				case 0:
					this.info_title = this.$t('internet');
					this.getWanInfo();
					this.mainTimer = setInterval(this.getWanInfo, 5000);
					break;
				case 1:
					clearInterval(this.mainTimer);
					this.info_title = this.versionMsg.model;
					this.getLanInfo();
					break;
				case 2:
					clearInterval(this.mainTimer);
					this.info_title = this.$t('connected_clients');
					this.getTerminalList();
					break;

			}
		},
		getTerminalList: function() { //获取终端列表
			var self = this;
			axios.get(hostUrl + '/associated_devs').then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.parse(data);
				}
				self.clientList = data.data.list;
			})
		},
		editClients: function(item) { //编辑终端信息
			this.clientEditDialog = true;
			for (var i in item) {
				this.$set(this.clientEditForm, i, item[i]);
			}
		},
		queryEditClients: function() { //确认编辑终端信息
			var self = this;
			axios.post(hostUrl + '/dev_rename', JSON.stringify({
				deviceName: self.clientEditForm.hostname,
				mac: self.clientEditForm.mac,
				ip: self.clientEditForm.ip,
				ReserveSwitch: self.clientEditForm.ReserveSwitch ? 1 : 0,
				ParentalSwitch: self.clientEditForm.ParentalSwitch ? 1 : 0
			})).then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				if (data.data.result == 0) {
					self.$message(self.$t('editSuccess'));
					self.getTerminalList();
					self.clientEditDialog = false;
				} else {
					self.$message(self.$t('editFail'));
				}
			})
		},
		queryAddClients: function() { //确认添加终端信息
			var self = this;
			axios.post(hostUrl + '/dev_rename', JSON.stringify({
				deviceName: self.clientAddForm.hostname,
				ReserveSwitch: self.clientAddForm.ReserveSwitch ? 1 : 0,
				ParentalSwitch: self.clientAddForm.ParentalSwitch ? 1 : 0
			})).then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				if (data.data.result == 0) {
					self.$message(self.$t('addSuccess'));
					self.getTerminalList();
					self.clientAddDialog = false;
				} else {
					self.$message(self.$t('addFail'));
				}
			})
		},
		// 设置
		// 设置页跳转
		getTitleData: function(title, img, directions) {
			this.title_set = title;
			this.img_set = img;
			this.directions_set = directions;
		},
		toSetup: function(type) {
			window.location = "http://" + window.location.host + hostUrl + "/setup.html?type=" + type;
		},
		radioChange: function(index) { //radio状态切换
			this.repeatDialog = true;
			var row = this.curPageRepeatData[this.repeatRadio];
			row.security == 'NONE' ? this.repeatPwdShow = false : this.repeatPwdShow = true;
		},
		repeatPageChange: function(curPage) { //中继列表页数切换
			this.curPageRepeatData = this.repeatData[curPage - 1];
		},
		getRepeatMsg: function() { //获取中继信息
			var self = this;
			axios.post(hostUrl + '/repeater_mode', JSON.stringify({
				wisptype: 0
			})).then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				self.loading = false;
				self.repeatForm = data.data;
				self.repeatData = [];
				for (var i = 0, len = data.data.list.length; i < len; i += 7) {
					self.repeatData.push(data.data.list.slice(i, Math.min(i + 7, len)));
				}
				console.log(self.repeatData);
				self.curPageRepeatData = self.repeatData[0];
			})
		},
		setRepeatMsg: function() { //设置中继信息
			var self = this;
			var row = self.curPageRepeatData[self.repeatRadio];
			if (row.security != 'NONE') {
				if (!checkPassword(self.repeatPwd)) return self.$message(self.$t("password_Format"));
			}
			var msg = {
				bssid: row.bssid,
				channel: row.channel,
				checked: 0,
				linkPwd: row.security == 'NONE' ? '' : self.repeatPwd,
				mode: 3,
				security: row.security,
				signal: row.signal,
				ssid: row.ssid,
				wisptype: "0"
			}
			axios.post(hostUrl + '/repeater_mode_apply', JSON.stringify(msg)).then(function(data) {
				if (typeof(data) == 'string') {
					var data = JSON.stringify(data);
				}
				if (data.data.result == 0) {
					self.repeatDialog = false;
					self.skipPageType = 0;
					frameHstip(2, self.$t('configuring'), 50);
				}
			})
		},
		// 静态ip保存
		staticSave: function() {
			var self = this;
			if (!checkIp(self.staticForm.ip)) return frameHstip(0, self.$t('ip_verify'));
			if (!checkMask(self.staticForm.mask)) return frameHstip(0, self.$t('mask_verify'));
			if (!checkIp(self.staticForm.gateway)) return frameHstip(0, self.$t('gateway_verify'));
			if (self.staticForm.ip == self.staticForm.gateway) return frameHstip(0, self.$t(
				'ipGateway_notSame'));
			if (!checkIp(self.staticForm.dns1)) return frameHstip(0, self.$t('dns_verify'));
			if (self.staticForm.dns2) {
				if (!checkIp(self.staticForm.dns2)) return frameHstip(0, self.$t('dns_verify'));
			}
			if (self.staticMtuType == 1) {
				if (Number(self.staticForm.mtu) < 576 || Number(self.staticForm.mtu) > 1500)
				return frameHstip(0, self.$t('mtu_verify'));
			}
			let msg = {
				netType: 1,
				ip: self.staticForm.ip,
				mask: self.staticForm.mask,
				gateway: self.staticForm.gateway,
				dns1: self.staticForm.dns1,
				dns2: self.staticForm.dns2 || '',
				mtu: self.staticMtuType == 0 ? '0' : self.staticForm.mtu,
				mac: self.staticForm.clone_mac,
			}
			axios.post(hostUrl + '/wan_static_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					setTimeout(function() {
						self.skipPageType = 1;
						frameHstip(2, self.$t('configuring'), 50);
						self.getWanMsg(0);
					}, 1000)
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			})
		},
		// pppoe保存
		pppoeSave: function() {
			var self = this;
			if (!checkPppoeUsername(self.pppoeForm.account)) return frameHstip(0, self.$t(
				'pppoe_username_verify'));
			if (!checkPppoePwd(self.pppoeForm.password)) return frameHstip(0, self.$t('pppoe_pwd_verify'));
			if (self.pppoeMtuType == 1) {
				if (Number(self.pppoeForm.mtu) < 576 || Number(self.pppoeForm.mtu) > 1500)
				return frameHstip(0, self.$t('mtu_verify'));
			}
			let msg = {
				netType: 2,
				account: self.pppoeForm.account,
				password: self.pppoeForm.password,
				svcname: self.pppoeForm.svcname,
				dns1: self.pppoeForm.dns1,
				dns2: self.pppoeForm.dns2,
				mtu: self.pppoeMtuType == 0 ? '0' : self.pppoeForm.mtu,
				clone_mac: self.pppoeForm.clone_mac
			}
			axios.post(hostUrl + '/wan_pppoe_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					setTimeout(function() {
						self.skipPageType = 1;
						frameHstip(2, self.$t('configuring'), 50);
						self.getWanMsg(0);
					}, 1000)
				} else {
					self.$message(self.$t('saveFail'));
				}
			})
		},
		// dhcp保存
		dhcpSave: function() {
			var self = this;
			if (self.dhcpMtuType == 1) {
				if (Number(self.dhcpNetForm.mtu) < 576 || Number(self.dhcpNetForm.mtu) > 1500)
				return frameHstip(0, self.$t('mtu_verify'));
			}
			let msg = {
				netType: 5,
				dns1: self.dhcpNetForm.dns1,
				dns2: self.dhcpNetForm.dns2,
				mtu: self.dhcpMtuType == 0 ? '0' : self.dhcpNetForm.mtu,
				mac: self.dhcpNetForm.clone_mac
			}
			axios.post(hostUrl + '/wan_dhcp_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					setTimeout(function() {
						self.skipPageType = 1;
						frameHstip(2, self.$t('configuring'), 50);
						self.getWanMsg(0);
					}, 1000)
				} else {
					frameHstip(0, self.$t('saveFail'));
				}
			})
		},
		// vpn保存
		vpnSave: function() {
			var self = this;
			let msg = {
				Switch: 'on',
				domain: self.vpnForm.domain,
				username: self.vpnForm.username,
				password: self.vpnForm.password,
				netmode: self.vpnForm.netmode,
				dns1: self.vpnForm.dns1,
				dns2: self.vpnForm.dns2
			};
			if (self.netType == 6) {
				msg.clientmode = 'pptp';
				msg.netType = 6;
				if (self.vpnForm.netmode == 'Static') {
					msg.staticip = self.vpnForm.staticip;
					msg.staticmask = self.vpnForm.staticmask;
					msg.staticgateway = self.vpnForm.staticgateway;
					msg.MTU = self.vpnMtuType == 0 ? '0' : self.vpnForm.MTU;
				}
			} else {
				msg.clientmode = 'l2tp';
				msg.netType = 7;
				if (self.vpnForm.netmode == 'Static') {
					msg.staticip = self.vpnForm.staticip;
					msg.staticmask = self.vpnForm.staticmask;
					msg.staticgateway = self.vpnForm.staticgateway;
					msg.MTU = self.vpnMtuType == 0 ? '0' : self.vpnForm.MTU;
				}
			}
			if (!checkIp(self.vpnForm.domain)) return frameHstip(0, self.$t('ip_verify'));
			if (!self.vpnForm.username) return frameHstip(0, self.$t('username_notNull'));
			if (!self.vpnForm.password) return frameHstip(0, self.$t('password_notNull'));
			if (self.vpnForm.netmode == 'Static') {
				if (!checkIp(self.vpnForm.staticip)) return frameHstip(0, self.$t('staticIp_verify'));
				if (!checkMask(self.vpnForm.staticmask)) return frameHstip(0, self.$t('mask_verify'));
				if (!checkIp(self.vpnForm.staticgateway)) return frameHstip(0, self.$t('gateway_verify'));
				if (self.vpnMtuType == 1) {
					if (Number(self.vpnForm.mtu) < 576 || Number(self.vpnForm.mtu) > 1500)
					return frameHstip(0,
							self.$t('mtu_verify'));
				}
				if (!checkIp(self.vpnForm.dns1)) return frameHstip(0, self.$t('dns_verify'));
				if (self.vpnForm.dns2) {
					if (!checkIp(self.vpnForm.dns2)) return frameHstip(0, self.$t('dns_verify'))
				}
			}
			axios.post(hostUrl + '/set_pptp_l2tp_data_cfg', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					setTimeout(function() {
						self.skipPageType = 1;
						frameHstip(2, self.$t('configuring'), 50);
						self.getWanMsg(0);
					}, 1000)
				} else {
					self.$message(self.$t('saveFail'));
				}
			})
		},
		netTypeChange: function(type) { //网络类型切换
			if (this.currentNetType == 6) {
				if (type == 7) {
					for (var i in this.vpnForm) {
						this.vpnForm[i] = null;
					}
					this.vpnForm.netmode = 'Static';
				} else if (type == 6) {
					this.getWanMsg(0);
				}
			} else if (this.currentNetType == 7) {
				if (type == 6) {
					for (var i in this.vpnForm) {
						this.vpnForm[i] = null;
					}
					this.vpnForm.netmode = 'Static';
				} else if (type == 7) {
					this.getWanMsg(0);
				}
			}
			if (type == 3) { //中继模式
				this.getRepeatMsg();
			}
		},
		getWanMsg: function(type) { // 获取wan信息
			var self = this;
			axios.get(hostUrl + '/wan_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				var wanMsg = data.data;
				self.netType = wanMsg.netType;
				self.currentNetType = wanMsg.netType;
				if (type == 0) { //0 代表首页信息,1代表易操作信息
					switch (wanMsg.netType) {
						case 1: //静态ip
							self.staticForm = wanMsg;
							self.staticForm.mtu == '0' ? self.staticMtuType = 0 : self
								.staticMtuType = 1;
							break;
						case 2: //pppoe拨号
							self.pppoeForm = wanMsg;
							self.pppoeForm.mtu == '0' ? self.pppoeMtuType = 0 : self.pppoeMtuType =
								1;
							break;
						case 3: //中继模式
							self.getRepeatMsg();
							break;
						case 5: // dhcp拨号
							self.dhcpNetForm = wanMsg;
							self.dhcpNetForm.mtu == '0' ? self.dhcpMtuType = 0 : self.dhcpMtuType =
								1;
							break;
						case 6: //pptp
							self.vpnForm = wanMsg.vpn_setting;
							self.vpnForm.mtu == '0' ? self.vpnMtuType = 0 : self.vpnMtuType = 1;
							break;
						case 7: // L2tp
							self.vpnForm = wanMsg.vpn_setting;
							self.vpnForm.mtu == '0' ? self.vpnMtuType = 0 : self.vpnMtuType = 1;
							break;
					}
				} else { // 向导页变化
					if (wanMsg.linkStatue == 0) {
						switch (wanMsg.netType) {
							case 1: //静态ip
								self.networkType = 2;
								self.wizardPageData(self.$t('staticIp'), 3.2);
								break;
							case 2: //pppoe
								self.networkType = 1;
								self.wizardPageData(self.$t('pppoe'), 3.1);
								break;
							case 5: // dhcp
								self.networkType = 0;
								self.getWifiMsg();
								self.wizardPageData(self.$t('wifiSet'), 4);
								break;
						}
					} else {
						self.wizardTopBar = false;
						self.wizardPageData(self.$t('install'), 1.1);
					}
				}
			})
		},
		wanSave: function() {
			var self = this;
			switch (self.netType) {
				case 1:
					self.staticSave();
					break;
				case 2:
					self.pppoeSave();
					break;
				case 5:
					self.dhcpSave();
					break;
				case 6:
					self.vpnSave();
					break;
				case 7:
					self.vpnSave();
					break;
			}
		},
		internetChange: function(type) { //internet类型切换
			this.internetType = type;
			switch (type) {
				case 0:
					getHeadMsg(1, this.$t("internet_set"), '/opsw/img/internet_page.png', this.$t(
						"directions_internet"));
					break;
				case 1:
					// getHeadMsg(1, this.$t("Triple_Play"), '/opsw/img/tripleplay_page.png', this.$t(
					// 	"directions_triple"));
					break;
			}
		},
		internetSave: function() { //internet保存
			switch (this.internetType) {
				case 0:
					this.wanSave();
					break;
			}
		},
		// wifi设置
		wirelessTab: function(type) { //无线类型模式切换
			this.wirelessType = type;
			var img;
			switch (type) {
				case 0:
					this.getWifiMsg();
					img = '/opsw/img/wifi_24.png';
					getHeadMsg(1, this.$t("wireless_set"), img, this.$t("directions_wireless"));
					break;
				case 1:
					this.getVisNet();
					img = '/opsw/img/Guest.png';
					getHeadMsg(1, this.$t("Guest_Zone"), img, this.$t("Guest_direction"));
					break;
			}
		},
		getWifiMsg: function() { //获取wifi信息
			var self = this;
			axios.get(hostUrl + '/total_wifi_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				let info = data.data;
				info.wifi_info.map(function(item, index) {
					if (item.wifi_band == 0) {
						self.twoWifiMsg = item;
						item.disabled == '0' ? self.twoWifiSwitch = true : self
							.twoWifiSwitch = false;
					} else {
						self.fiveWifiMsg = item;
						item.disabled == '0' ? self.fiveWifiSwitch = true : self
							.fiveWifiSwitch = false;
					}
				})
			}).catch()
		},
		setWifiMsg: function() { // wifi信息设置
			var self = this;
			if (!checkSsid(self.twoWifiMsg.ssid)) return frameHstip(0, self.$t('twoSsid_Format'));
			if (!checkPassword(self.twoWifiMsg.password)) return frameHstip(0, self.$t('twoPwd_Format'));
			if (model_type == 1) {
				if (!checkSsid(self.fiveWifiMsg.ssid)) return frameHstip(0, self.$t('fiveSsid_Format'));
				if (!checkPassword(self.fiveWifiMsg.password)) return frameHstip(0, self.$t(
					'fivePwd_Format'));
			}
			let msg = {
				wifi_info: [{ //wifi信息
					wifi_band: 0,
					disabled: self.twoWifiSwitch ? '0' : '1',
					ssid: self.twoWifiMsg.ssid,
					password: (self.twoWifiMsg.password),
					encryption: self.twoWifiMsg.encryption,
					channel: self.twoWifiMsg.channel,
					power: self.twoWifiMsg.power,
					wlanWidth: self.twoWifiMsg.wlanWidth,
					hidden: self.twoWifiMsg.hidden
				}],
				// pbcSwitch: self.wifiMsg.pbcSwitch ? 1 : 0,
				// pinSwitch: self.wifiMsg.pinSwitch ? 1 : 0
			}
			if (model_type == 1) { // 0 单频  1双频
				msg.wifi_info.push({
					wifi_band: 1,
					disabled: self.fiveWifiSwitch ? '0' : '1',
					ssid: self.fiveWifiMsg.ssid,
					password: self.fiveWifiMsg.password,
					encryption: self.fiveWifiMsg.encryption,
					channel: self.fiveWifiMsg.channel,
					power: self.fiveWifiMsg.power,
					wlanWidth: self.fiveWifiMsg.wlanWidth,
					hidden: self.fiveWifiMsg.hidden
				})
			}
			console.log(msg);
			axios.post(hostUrl + '/total_wifi_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					self.skipPageType = 3;
					frameHstip(2, self.$t('saveSuccess'), 15);
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		getVisNet: function() { //获取访客网络信息
			var self = this;
			axios.get(hostUrl + '/guest_wifi_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				self.visForm = data.data;
				self.visForm.guest2g_disabled == '1' ? self.visForm.guest2g_disabled = false : self
					.visForm.guest2g_disabled =
					true;
				self.visForm.guest5g_disabled == '1' ? self.visForm.guest5g_disabled = false : self
					.visForm.guest5g_disabled =
					true;
				self.visForm.guest_isolated == '1' ? self.visForm.guest_isolated = true : self
					.visForm.guest_isolated = false;
			}).catch()
		},
		setVisNet: function() { //设置访客网络信息
			var self = this;
			if (!checkSsid(self.visForm.guest2g_ssid)) return frameHstip(0, self.$t('twoSsid_Format'));
			if (!checkPassword(self.visForm.guest2g_password)) return frameHstip(0, self.$t(
				'twoPwd_Format'));
			if (model_type == 1) {
				if (!checkSsid(self.visForm.guest5g_ssid)) return frameHstip(0, self.$t('fiveSsid_Format'));
				if (!checkPassword(self.visForm.guest5g_password)) return frameHstip(0, self.$t(
					'fivePwd_Format'));
			}
			var msg = {
				guest2g_disabled: self.visForm.guest2g_disabled ? '0' : '1',
				guest2g_ssid: self.visForm.guest2g_ssid,
				guest2g_password: self.visForm.guest2g_password,
				guest_isolated: self.visForm.guest_isolated ? '1' : '0'
			}
			if (model_type == 1) {
				msg.guest5g_disabled = self.visForm.guest5g_disabled ? '0' : '1';
				msg.guest5g_ssid = self.visForm.guest5g_ssid;
				msg.guest5g_password = self.visForm.guest5g_password;
			}
			axios.post(hostUrl + '/guest_wifi_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					self.skipPageType = 3;
					frameHstip(2, self.$t('saveSuccess'), 15);
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		setWireless: function() { //无线保存
			if (this.wirelessType == 0) {
				this.setWifiMsg();
			} else if (this.wirelessType == 1) {
				this.setVisNet();
			}
		},
		lanIpChange: function(ip) {
			this.dhcpIpRange = ip.split('.')[0] + '.' + ip.split('.')[1] + '.' + ip.split('.')[2] + '.';
		},
		getNetwork: function() { // 获取lan网络信息
			var self = this;
			axios.get(hostUrl + '/network_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				self.networkForm = data.data;
				self.networkForm.Switch == 1 ? self.networkForm.Switch = true : self.networkForm
					.Switch = false;
				self.networkForm.upnp_enable == 1 ? self.networkForm.upnp_enable = true : self
					.networkForm.upnp_enable = false;
				if (JSON.stringify(self.networkForm.upnp_portmap_list) == '{}') {
					self.networkForm.upnp_portmap_list = [];
				}
				var ip = self.networkForm.ip;
				self.dhcpIpRange = ip.split('.')[0] + '.' + ip.split('.')[1] + '.' + ip.split('.')[
					2] + '.';
				console.log(self.dhcpIpRange);
			}).catch()
		},
		setNetwork: function() { // 保存lan网络信息
			var self = this;
			if (!checkIp(self.networkForm.ip)) return frameHstip(0, self.$t('ip_verify'));
			if (!checkMask(self.networkForm.mask)) return frameHstip(0, self.$t('mask_verify'));
			if (!checkInteger(self.networkForm.startip) || Number(self.networkForm.startip) > 254)
			return frameHstip(0, self.$t('startIpRange_verify'));
			if (!checkInteger(self.networkForm.endip) || Number(self.networkForm.endip) > 254)
			return frameHstip(0, self.$t('endIpRange_verify'));
			if (Number(self.networkForm.startip) > Number(self.networkForm.endip)) return frameHstip(0, self
				.$t('startEndIp_compare'));
			if (self.networkForm.leasetime < 1) return frameHstip(0, self.$t('leasetime_verify'));
			axios.post(hostUrl + '/network_setting_apply', JSON.stringify({
				ip: self.networkForm.ip,
				mask: self.networkForm.mask,
				Switch: self.networkForm.Switch ? 1 : 0,
				startip: self.networkForm.startip,
				endip: self.networkForm.endip,
				leasetime: self.networkForm.leasetime,
				// wanport_speed: self.networkForm.wanport_speed,
				wanport_speed: '0',
				upnp_enable: self.networkForm.upnp_enable ? 1 : 0
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data)
				}
				if (data.data.result == 0) {
					self.skipPageType = 2;
					frameHstip(2, self.$t('configuring'), 40);
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 向导页
		wizardClose: function() { //向导页取消
			window.location = 'http://' + window.location.host + hostUrl + '/main.html';
		},
		wizardPageData: function(title, page) {
			this.frame_title = title;
			this.wizard_page = page;
		},
		// feature页
		toFeatures: function(type) {
			this.tabIndex = 2;
			window.location = "http://" + window.location.host + hostUrl + "/features.html?type=" + type;
		},
		getQosMsg: function() { //获取qos信息
			var self = this;
			axios.get(hostUrl + '/qos_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.qosMsg = data.data;
				if (JSON.stringify(self.qosMsg.qos_pri_list) == '{}') {
					self.qosMsg.qos_pri_list = [];
				}
			}).catch()
		},
		qosIpChange: function(value) {
			var self = this;
			self.clientList.map(function(item, index) {
				if (item.ip == value) {
					self.qosAddForm.mac = item.mac;
				}
			})
			if (!self.qosAddForm.ip) {
				self.qosAddForm.mac = '';
			}
		},
		qosMacChange: function(value) {
			var self = this;
			self.clientList.map(function(item, index) {
				if (item.mac == value) {
					self.qosAddForm.ip = item.ip;
				}
			})
			if (!self.qosAddForm.mac) {
				self.qosAddForm.ip = '';
			}
		},
		qosQueryAdd: function() {
			if (!checkIp(this.qosAddForm.ip)) return this.$message(this.$t('ip_verify'));
			if (!checkMac(this.qosAddForm.mac)) return this.$message(this.$t('mask_verify'));
			this.qosMsg.qos_pri_list.unshift({
				ip: this.qosAddForm.ip,
				mac: this.qosAddForm.mac,
				qos_pri: this.qosAddForm.qos_pri
			});
			this.qosAddDialog = false;
			for (var i in this.qosAddForm) {
				this.qosAddForm[i] = null;
			}
		},
		qosEdit: function(row, index) { //qos编辑
			this.qosSelectIndex = index;
			this.getTerminalList();
			for (var i in row) {
				this.$set(this.qosEditForm, i, row[i]);
			}
			this.qosEditDialog = true;
		},
		qosQueryEdit: function() { //qos确认编辑
			if (!checkIp(this.qosEditForm.ip)) return this.$message(this.$t('ip_verify'));
			if (!checkMac(this.qosEditForm.mac)) return this.$message(this.$t('mac_verify'));
			this.qosEditDialog = false;
			for (var i in this.qosEditForm) {
				this.qosMsg.qos_pri_list[this.qosSelectIndex][i] = this.qosEditForm[i];
			}
		},
		qosDelete: function(index) { //qos删除
			this.qosMsg.qos_pri_list.splice(index, 1);
		},
		qosSave: function() { //qos保存
			var self = this;
			if (!self.qosMsg.download || self.qosMsg.download == 0) return frameHstip(0, self.$t(
				'Uplink_Speed_verify'));
			if (!self.qosMsg.upload || self.qosMsg.upload == 0) return frameHstip(0, self.$t(
				'Downlink_Speed_verify'));
			var msg = {
				enabled: "1",
				download: self.qosMsg.download,
				upload: self.qosMsg.upload,
				qos_pri_list: self.qosMsg.qos_pri_list
			}
			axios.post(hostUrl + '/qos_setting_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getQosMsg();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 防火墙
		getFirewall: function(type) { //获取防火墙信息
			this.firewall_type = type;
			this.getTerminalList();
			switch (type) {
				case 0:
					this.get_firewall_advanced();
					break;
				case 1:
					this.getFirewall_ipv4();
					break;
			}
		},
		firewallSave: function() { //防火墙信息保存
			switch (this.firewall_type) {
				case 0:
					this.set_firewall_advanced();
					break;
				case 1:
					this.setFirewall_ipv4();
					break;
			}
		},
		get_firewall_advanced: function() { //获取防火墙高级设置信息
			var self = this;
			axios.get(hostUrl + '/firewall_advance').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.firewall_advanced = data.data;
				self.firewall_advanced.dmz_enabled == 1 ? self.firewall_advanced.dmz_enabled =
					true : self.firewall_advanced.dmz_enabled =
					false;
			}).catch()
		},
		set_firewall_advanced: function() { //设置防火墙高级设置信息
			var self = this;
			var msg = {};
			if (self.firewall_advanced.dmz_enabled) {
				if (!checkIp(self.firewall_advanced.dmz_ip)) return frameHstip(0, self.$t('ip_Format'));
				var ipRange = self.firewall_advanced.dmz_ip.split('.');
				var networkIpRange = self.networkForm.ip.split('.');
				for (var i = 0; i < 3; i++) {
					if (ipRange[i] != networkIpRange[i]) return frameHstip(0, self.$t('DMZIp_same_lanIp'));
				}
				msg.dmz_enabled = 1;
				msg.dmz_ip = self.firewall_advanced.dmz_ip;
			} else {
				msg.dmz_enabled = 0;
			}
			axios.post(hostUrl + '/firewall_advance_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.get_firewall_advanced();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		filterTypeChange: function(value) {
			if (value == 0) {
				this.firewallEditForm_ipv4.srcifc = '';
				this.firewallEditForm_ipv4.srcip = '';
				this.firewallEditForm_ipv4.dstifc = '';
				this.firewallEditForm_ipv4.dstip = '';
				this.firewallEditForm_ipv4.protocol = '';
				this.firewallEditForm_ipv4.port = '';
			} else {
				this.firewallEditForm_ipv4.mac = '';
			}
		},
		getFirewall_ipv4: function() { //获取防火墙ipv4信息
			var self = this;
			axios.get(hostUrl + '/firewall_rule').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.firewall_ipv4 = data.data;
				if (JSON.stringify(data.data.list) == '{}') {
					self.firewall_ipv4.list = [];
				}
			}).catch()
		},
		setFirewall_ipv4: function() { //设置防火墙ipv4信息
			var self = this;
			axios.post(hostUrl + '/firewall_rule_apply', JSON.stringify(self.firewall_ipv4)).then(function(
				data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getFirewall_ipv4();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		firewallQueryAdd: function() { // 防火墙ipv4确认添加
			if (!checkAlias(this.firewallAddForm_ipv4.name)) return this.$message(this.$t('name_Format'));
			if (this.filterType == 0) {
				if (!checkMac(this.firewallAddForm_ipv4.mac)) return this.$message(this.$t('mac_Format'));
			} else {
				if (!checkIp(this.firewallAddForm_ipv4.srcip)) return this.$message(this.$t('ip_Format'));
				if (!checkIp(this.firewallAddForm_ipv4.dstip)) return this.$message(this.$t('ip_Format'));
				if (!checkPort(this.firewallAddForm_ipv4.port)) return this.$message(this.$t(
				'port_Format'));
				var srcipRange = this.firewallAddForm_ipv4.srcip.split('.');
				var dstipRange = this.firewallAddForm_ipv4.dstip.split('.');
				var networkIpRange = this.networkForm.ip.split('.');
				if (this.firewallAddForm_ipv4.srcifc == 'wan') {
					if (srcipRange[0] == networkIpRange[0] && srcipRange[1] == networkIpRange[1] &&
						srcipRange[2] == networkIpRange[2])
						return this.$message(this.$t('sourceIP_segments_same'));
				}
				if (this.firewallAddForm_ipv4.dstifc == 'lan') {
					for (var i = 0; i < 3; i++) {
						if (dstipRange[i] != networkIpRange[i]) return this.$message(this.$t(
							'destinationIP_segments_same'));
					}
				}
			}
			this.firewall_ipv4.list.push({
				name: this.firewallAddForm_ipv4.name,
				mac: this.filterType == 0 ? this.firewallAddForm_ipv4.mac : '',
				srcifc: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.srcifc,
				srcip: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.srcip,
				dstifc: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.dstifc,
				dstip: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.dstip,
				protocol: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.protocol,
				port: this.filterType == 0 ? '' : this.firewallAddForm_ipv4.port,
			});
			this.firewallAddDialog_ipv4 = false;
			for (var i in this.firewallAddForm_ipv4) {
				this.firewallAddForm_ipv4[i] = null;
			}
		},
		firewallEdit: function(row, index) { // 防火墙ipv4编辑
			this.firewallSelectIndex = index;
			for (var i in row) {
				this.$set(this.firewallEditForm_ipv4, i, row[i]);
			}
			this.firewallEditForm_ipv4.mac ? this.filterType = 0 : this.filterType = 1;
			this.firewallEditDialog_ipv4 = true;
		},
		firewallQueryEdit: function() { //防火墙ipv4确认编辑
			if (!checkAlias(this.firewallEditForm_ipv4.name)) return this.$message(this.$t('name_Format'));
			if (this.filterType == 0) {
				if (!checkMac(this.firewallEditForm_ipv4.mac)) return this.$message(this.$t('mac_Format'));
			} else {
				if (!this.firewallEditForm_ipv4.srcifc) return this.$message(this.$t('srcifc_notNull'));
				if (!checkIp(this.firewallEditForm_ipv4.srcip)) return this.$message(this.$t('ip_Format'));
				if (!this.firewallEditForm_ipv4.dstifc) return this.$message(this.$t('dstifc_notNull'));
				if (!checkIp(this.firewallEditForm_ipv4.dstip)) return this.$message(this.$t('ip_Format'));
				if (!this.firewallEditForm_ipv4.protocol) return this.$message(this.$t('protocol_notNull'));
				if (!checkPort(this.firewallEditForm_ipv4.port)) return this.$message(this.$t(
					'port_Format'));
				var srcipRange = this.firewallEditForm_ipv4.srcip.split('.');
				var dstipRange = this.firewallEditForm_ipv4.dstip.split('.');
				var networkIpRange = this.networkForm.ip.split('.');
				if (this.firewallEditForm_ipv4.srcifc == 'wan') {
					if (srcipRange[0] == networkIpRange[0] && srcipRange[1] == networkIpRange[1] &&
						srcipRange[2] == networkIpRange[2])
						return this.$message(this.$t('sourceIP_segments_same'));
				}
				if (this.firewallEditForm_ipv4.dstifc == 'lan') {
					for (var i = 0; i < 3; i++) {
						if (dstipRange[i] != networkIpRange[i]) return this.$message(this.$t(
							'destinationIP_segments_same'))
					}
				}
			}
			for (var i in this.firewallEditForm_ipv4) {
				this.firewall_ipv4.list[this.firewallSelectIndex][i] = this.firewallEditForm_ipv4[i];
			}
			this.firewallEditDialog_ipv4 = false;
		},
		// 端口转发
		getPortMsg: function() {
			var self = this;
			axios.get(hostUrl + '/get_forward_cfg').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.portList = data.data.list;
				if (JSON.stringify(data.data) == '{}') {
					self.portList = [];
				}
			}).catch()
		},
		portAdd: function() {
			this.portAddDialog = true;
			for (var i in this.portAddForm) {
				this.portAddForm[i] = null;
			}
			this.portAddForm.protocol = 'TCP'
		},
		portQueryAdd: function() { //端口转发确认新增
			if (!this.portAddForm.name) return this.$message(this.$t('portName_notNull'));
			if (!checkIp(this.portAddForm.ip)) return this.$message(this.$t('ip_Format'));
			if (!checkInteger(this.portAddForm.wanport) || Number(this.portAddForm.wanport) > 65535)
			return this.$message(
					this.$t('wanPort_verify'));
			if (!checkInteger(this.portAddForm.lanport) || Number(this.portAddForm.lanport) > 65535)
			return this.$message(
					this.$t('lanPort_verify'));
			var lanIpRange = this.portAddForm.ip.split('.');
			var networkIpRange = this.networkForm.ip.split('.');
			for (var i = 0; i < 3; i++) {
				if (lanIpRange[i] != networkIpRange[i]) return this.$message(this.$t('lanIp_same'));
			}
			this.portList.unshift({
				name: this.portAddForm.name,
				ip: this.portAddForm.ip,
				wanport: this.portAddForm.wanport,
				lanport: this.portAddForm.lanport,
				protocol: this.portAddForm['protocol']
			});
			this.portAddDialog = false;
		},
		portEdit: function(row, index) { //端口转发编辑
			this.portSelectIndex = index;
			for (var i in row) {
				this.$set(this.portEditForm, i, row[i]);
			}
			this.portEditDialog = true;
		},
		portQueryEdit: function() { //端口转发过滤确认编辑
			if (!this.portEditForm.name) return this.$message(this.$t('portName_notNull'));
			if (!checkIp(this.portEditForm.ip)) return this.$message(this.$t('ip_verify'));
			if (!checkInteger(this.portEditForm.wanport) || Number(this.portEditForm.wanport) > 65535)
				return this.$message(
					this.$t('wanPort_verify'));
			if (!checkInteger(this.portEditForm.lanport) || Number(this.portEditForm.lanport) > 65535)
				return this.$message(
					this.$t('lanPort_verify'));
			var lanIpRange = this.portEditForm.ip.split('.');
			var networkIpRange = this.networkForm.ip.split('.');
			for (var i = 0; i < 3; i++) {
				if (lanIpRange[i] != networkIpRange[i]) return this.$message(this.$t('lanIp_same'));
			}
			this.portEditDialog = false;
			for (var i in this.portEditForm) {
				this.portList[this.portSelectIndex][i] = this.portEditForm[i];
			}
		},
		portDelete: function(index) { //端口转发删除
			this.portList.splice(index, 1);
		},
		setPortMsg: function() { //端口转发保存
			var self = this;
			axios.post(hostUrl + '/set_forward_cfg', JSON.stringify({
				list: self.portList
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getPortMsg();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// url过滤
		getUrlFilter: function() {
			var self = this;
			axios.get(hostUrl + '/get_url_filter').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.urlList = data.data.list;
				if (JSON.stringify(data.data) == '{}') {
					self.urlList = [];
				}
			}).catch()
		},
		urlQueryAdd: function() { //url过滤确认新增
			if (!checkUrl(this.urlAddForm.url)) return this.$message(this.$t('url_verify'));
			this.urlList.unshift({
				url: this.urlAddForm.url
			});
			this.urlAddDialog = false;
			this.urlAddForm.url = null;
		},
		urlEdit: function(row, index) { //url过滤编辑
			this.urlSelectIndex = index;
			for (var i in row) {
				this.$set(this.urlEditForm, i, row[i]);
			}
			this.urlEditDialog = true;
		},
		urlQueryEdit: function() { //url过滤确认编辑
			if (!checkUrl(this.urlEditForm.url)) return this.$message(this.$t('url_verify'));
			this.urlEditDialog = false;
			this.urlList[this.urlSelectIndex].url = this.urlEditForm.url;
		},
		urlDelete: function(index) { //url过滤删除
			this.urlList.splice(index, 1);
		},
		urlSave: function() { //url过滤保存
			var self = this;
			axios.post(hostUrl + '/set_url_filter', JSON.stringify({
				list: self.urlList
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getUrlFilter();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 静态路由
		getStaticRoute: function() {
			var self = this;
			axios.get(hostUrl + '/static_route').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.routeList = data.data.list;
				self.routeList.map(function(item, index) {
					item.state == '1' ? item.state = true : item.state = false;
				})
				console.log(self.routeList);
				if (JSON.stringify(data.data) == '{}') {
					self.routeList = [];
				}
			}).catch()
		},
		routeAdd: function() {
			for (var i in this.routeAddForm) {
				this.routeAddForm[i] = null;
			}
			this.routeAddDialog = true;
		},
		routeQueryAdd: function() { //静态路由确认新增
			if (!checkAlias(this.routeAddForm.name)) return this.$message(this.$t('name_Format'));
			if (!checkNetwork(this.routeAddForm.net)) return this.$message(this.$t('network_Format'));
			if (!checkRouteMask(this.routeAddForm.netmask)) return this.$message(this.$t('mask_Format'));
			if (!checkIp(this.routeAddForm.gateway)) return this.$message(this.$t('gateway_Format'));
			if (this.routeAddForm.metric < 0 || Number(this.routeAddForm.metric) > 64 || !this.routeAddForm
				.metric) return this.$message(this.$t('metric_Format'));
			var net = [];
			var ipRangle = this.routeAddForm.net.split('.');
			var maskRangle = this.routeAddForm.netmask.split('.');
			for (var i = 0; i < 4; i++) {
				net.push(ipRangle[i] & maskRangle[i]);
			}
			var netIp = net[0] + '.' + net[1] + '.' + net[2] + '.' + net[3];
			this.routeList.unshift({
				state: this.routeAddForm.state,
				name: this.routeAddForm.name,
				net: netIp,
				netmask: this.routeAddForm.netmask,
				gateway: this.routeAddForm.gateway,
				metric: this.routeAddForm.metric
			});
			this.routeAddDialog = false;
		},
		routeEdit: function(row, index) { // 静态路由编辑
			this.routeSelectIndex = index;
			for (var i in row) {
				this.$set(this.routeEditForm, i, row[i]);
			}
			this.routeEditDialog = true;
		},
		routeQueryEdit: function() { //静态路由确认编辑
			if (!checkAlias(this.routeEditForm.name)) return this.$message(this.$t('name_Format'));
			if (!checkNetwork(this.routeEditForm.net)) return this.$message(this.$t('network_Format'));
			if (!checkRouteMask(this.routeEditForm.netmask)) return this.$message(this.$t('mask_Format'));
			if (!checkIp(this.routeEditForm.gateway)) return this.$message(this.$t('gateway_Format'));
			if (this.routeEditForm.metric < 0 || Number(this.routeEditForm.metric) > 64 || !this
				.routeEditForm.metric) return this
				.$message(this.$t('metric_Format'));
			var net = [];
			var ipRangle = this.routeEditForm.net.split('.');
			var maskRangle = this.routeEditForm.netmask.split('.');
			for (var i = 0; i < 4; i++) {
				net.push(ipRangle[i] & maskRangle[i]);
			}
			var netIp = net[0] + '.' + net[1] + '.' + net[2] + '.' + net[3];
			this.routeEditForm.net = netIp;
			for (var i in this.routeEditForm) {
				this.routeList[this.routeSelectIndex][i] = this.routeEditForm[i];
			}
			this.routeEditDialog = false;
		},
		routeDelete: function(index) { //静态路由删除
			this.routeList.splice(index, 1);
		},
		setStaticRoute: function() { //静态路由保存
			var self = this;
			self.routeList.map(function(item, index) {
				item.state ? item.state = '1' : item.state = '0';
				item.dev = 'wan';
			})
			console.log(self.routeList);
			axios.post(hostUrl + '/static_route_apply', JSON.stringify({
				list: self.routeList
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getStaticRoute();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// DNS
		getDNSMsg: function() {
			var self = this;
			axios.get(hostUrl + '/ddns').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.dnsMsg = data.data;
				self.dnsMsg.enabled == '1' ? self.dnsMsg.enabled = true : self.dnsMsg.enabled =
					false;
			}).catch()
		},
		setDNSMsg: function() { // DNS保存
			var self = this;
			var msg = {
				enabled: self.dnsMsg.enabled ? '1' : '0',
				status: self.dnsMsg.status
			}
			if (self.dnsMsg.enabled) {
				if (!checkServer(self.dnsMsg.service_name)) return frameHstip(0, self.$t('server_Format'));
				if (!checkServer(self.dnsMsg.domain)) return frameHstip(0, self.$t('hostname_Format'));
				if (!self.dnsMsg.username) return frameHstip(0, self.$t('username_notNull'));
				if (!self.dnsMsg.password) return frameHstip(0, self.$t('password_notNull'));
				msg.domain = self.dnsMsg.domain;
				msg.service_name = self.dnsMsg.service_name;
				msg.username = self.dnsMsg.username;
				msg.password = self.dnsMsg.password;
			}
			axios.post(hostUrl + '/ddns_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getDNSMsg();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 管理页
		toManage: function(type) {
			this.tabIndex = 3;
			this.manageType = type;
			window.location = "http://" + window.location.host + hostUrl + "/manage.html?type=" + type;
		},
		useHttpChange: function(value) {
			if (value) {
				this.adminForm.remoteSwitch = true;
				this.adminForm.port = 8081;
			} else {
				this.adminForm.port = 8080;
			}
		},
		// 定时开关
		getSystemTime: function() {
			var self = this;
			axios.get(hostUrl + '/time').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.timeForm = data.data;
				self.timeForm.ntp_enabled == '1' ? self.timeForm.ntp_enabled = true : self.timeForm
					.ntp_enabled = false;
				timeZoneList.map(function(item, index) {
					if (timeZoneList[index].zone_name == self.timeForm.city) {
						self.timeZoneIndex = index;
					}
				})
			}).catch()
		},
		setSystemTime: function() {
			var self = this;
			var msg = {
				timezone: timeZoneList[self.timeZoneIndex].code,
				city: timeZoneList[self.timeZoneIndex].zone_name
			}
			if (self.timeForm.ntp_enabled) {
				if (!checkServer(self.timeForm.ntp_server)) return frameHstip(0, self.$t('server_Format'));
				msg.ntp_enabled = '1';
				msg.ntp_server = self.timeForm.ntp_server;
			} else {
				if (!self.systemTime) return frameHstip(0, self.$t('time_notNull'));
				msg.ntp_enabled = '0';
				msg.time = self.systemTime;
			}
			axios.post(hostUrl + '/time_apply', JSON.stringify(msg)).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getSystemTime();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 系统 Admin
		adminSave: function() { // 修改登录密码保存
			if (this.systemType == 0) {
				this.adminPassSave();
			}
		},
		adminPassSave: function() {
			var self = this;
			if (!checkLoginPwd(self.adminForm.newPassword)) return frameHstip(0, self.$t('newPwd_verify'));
			if (self.adminForm.newPassword != self.adminForm.queryPassword) return frameHstip(0, self.$t(
				'adminPass_match'));
			axios.post(hostUrl + '/modify_password', JSON.stringify({
				username: "CMCCAdmin",
				newPassword: self.adminForm.newPassword
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					self.skipPageType = 0;
					frameHstip(2, self.$t('configuring'), 3);
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		getSystemLog: function() { //获取系统日志
			var self = this;
			axios.get(hostUrl + '/syslog').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.syslog = data.data.logInfo.split('<br>');
			}).catch()
		},
		toRestore: function() { // 恢复出厂设置
			var self = this;
			axios.post(hostUrl + '/restore_factory_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					self.skipPageType = 0;
					frameHstip(2, self.$t('Restoring'), 120);
				} else {
					frameHstip(1, self.$t('OperateFail'));
				}
			}).catch()
		},
		toReboot: function() { // 重启
			var self = this;
			axios.post(hostUrl + '/reboot').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					self.skipPageType = 0;
					frameHstip(2, self.$t('Rebooting'), 90);
				} else {
					frameHstip(1, self.$t('OperateFail'));
				}
			}).catch()
		},
		getAcsMsg: function() { //获取acs信息
			var self = this;
			axios.get(hostUrl + '/acs_setting').then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				self.acsForm = data.data;
			}).catch()
		},
		setAcsMsg: function() {
			var self = this;
			if (!checkServer(self.acsForm.url)) return frameHstip(0, self.$t('url_Format'));
			if (!checkStr(self.acsForm.username)) return frameHstip(0, self.$t('username_Format'));
			if (!checkStr(self.acsForm.password)) return frameHstip(0, self.$t('pwdStr_Format'));
			if (!checkStr(self.acsForm.local_username)) return frameHstip(0, self.$t('username_Format'));
			if (!checkStr(self.acsForm.local_password)) return frameHstip(0, self.$t('pwdStr_Format'));
			if (!checkPort(self.acsForm.local_port)) return frameHstip(0, self.$t('port_Format'));
			axios.post(hostUrl + '/acs_setting_apply', JSON.stringify({
				url: self.acsForm.url,
				username: self.acsForm.username,
				password: self.acsForm.password,
				local_username: self.acsForm.local_username,
				local_password: self.acsForm.local_password,
				local_port: self.acsForm.local_port
			})).then(function(data) {
				if ((typeof(data)) == "string") {
					var data = JSON.parse(data);
				}
				if (data.data.result == 0) {
					frameHstip(1, self.$t('saveSuccess'));
					self.getAcsMsg();
				} else {
					frameHstip(1, self.$t('saveFail'));
				}
			}).catch()
		},
		// 升级
		fileSubmit: function() {
			this.$refs.upload.submit();
		},
		uploadChange: function(file) { //文件上传前
			// if (!file) return this.$message('You have not selected a file');
		},
		submitSuccess: function(response, file, fileList) { //升级
			var self = this;
			if (response.result == 0) {
				self.skipPageType = 0;
				frameHstip(2, self.$t('Upgrading'), 100);
			} else {
				frameHstip(1, self.$t('upgradeFail'));
			}
		},
		upload: function() {

		},
	}
}).$mount('#container')
