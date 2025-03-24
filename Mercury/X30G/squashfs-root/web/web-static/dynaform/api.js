function SLP()
{
	this.moduleSpec;                   // 设备规格信息
	this.bandsProvided = this.DOUBLE;  // 支持的频段数
	this.bandSteeringProvided = false; // 支持多频合一
	this.guest5GSupport = false; // 支持访客5G
	this.wifiSwitchSupport = false; // 支持无线总开关
	this.wifiSwitchSplitSupport = false; // 支持无线总开关分离
	this.authSupport = false; // 支持无线认证类型设置
	this.authSupport2g = false; // 支持2g无线认证类型设置
	this.authSupport5g = false; // 支持5g无线认证类型设置
	this.authSupport5g1 = false; // 支持5g1无线认证类型设置
	this.authSupport5g4 = false; // 支持5g4无线认证类型设置
	this.cipherSupport = false; // 支持无线加密方式设置
	this.cipherSupport2g = false; // 支持2g无线加密方式设置
	this.cipherSupport5g = false; // 支持5g无线加密方式设置
	this.cipherSupport5g1 = false; // 支持5g1无线加密方式设置
	this.cipherSupport5g4 = false; // 支持5g4无线加密方式设置
	this.multiSsidSupport = false; // 支持多SSID
	this.wpsSupport = false; // 支持WPS
	this.macFilterSupport = false; // 支持黑白名单
	this.modeSwitchSupport = false; // 支持路由模式和桥模式切换
	this.usernameSupport = false;		// 支持用户名
	this.elinkSupport = false; // 支持elink
	this.wolinkSupport = false; // 支持wolink
	this.alinkTestSupport = false; // 支持alinkTest
	this.hnatSupport = false; // 支持hnat
	this.customLedSupport = false; // 支持customLed
	this.ipv6Support = false; // 支持IPv6
	this.g11AXSupport = {}; // 支持11ax
	this.muMimoSupport2g = false; // 2G频段支持MU-MIMO
	this.muMimoSupport5g = false; // 5G频段支持MU-MIMO
	this.muMimoSupport5g1 = false; // 5G1频段支持MU-MIMO
	this.muMimoSupport5g4 = false; // 5G4频段支持MU-MIMO
	this.twtSupport = false; // 全频段支持twt
	this.ofdmaSupport = false; // 全频段支持ofdma
	this.twtSupport2g = false; // 2G频段支持twt
	this.twtSupport5g = false; // 5G频段支持twt
	this.twtSupport5g1 = false; // 5G1频段支持twt
	this.twtSupport5g4 = false; // 5G4频段支持twt
	this.ofdmaSupport2g = false; // 2G频段支持ofdma
	this.ofdmaSupport5g = false; // 5G频段支持ofdma
	this.ofdmaSupport5g1 = false; // 5G1频段支持ofdma
	this.ofdmaSupport5g4 = false; // 5G4频段支持ofdma
	this.wpa3Support = false;	// 是否支持WPA3
	this.wlanHost5gSupport160MBandWidth = false;	// 无线频宽是否支持160MHz
	this.gSupportPortManage = false; // 支持端口功能自定义
	this.gMulWanSupport = false; // 支持双WAN口设置
	this.gIptvSupport = false; // 支持IPTV口设置
	this.gLagSupport = false; // 支持端口聚合设置
	this.gGameSupport = false; // 支持游戏专用口设置
	this.gSfpRateSupport = false; // 支持SFP口速率设置
	this.gMWanLoadBalanceSupport = false; // 端口管理双WAN设置是否支持均衡模式
	this.gSysModeSupport = false;	// 是否支持多模式相关

	this.hostnameMaxLen = 31; // 主机名最大长度

	this.SINGLE = 1;
	this.DOUBLE = 2;
	this.TRIPLE = 3;

	this.error = {

	}

	// WDS相关接口
	this.wds = {
		context: this,
		getData: function(options){
			this.getOptions = options;
			var
			ctx = this.context,
			self = this,
			dynData = uciWireless.dynData,
			request = {};

			request[uciWireless.fileName] = {};
			request[uciWireless.fileName][KEY_NAME] = [dynData.wds_2g];

			if (ctx.bandsProvided == ctx.TRIPLE)
			{
				request[uciWireless.fileName][KEY_NAME].push(dynData.wds_5g1, dynData.wds_5g2);
			}
			else if (ctx.bandsProvided == ctx.DOUBLE)
			{
				request[uciWireless.fileName][KEY_NAME].push(dynData.wds_5g);
			}

			$.query(request, function(result){
				if (ENONE == result[ERR_CODE])
				{
					self.getOptions.success&&self.getOptions.success(result);
				}
				else
				{
					self.getOptions.fail&&self.getOptions.fail(result);
				}
			}, undefined, true);
		},
		setData: function(sectionName, para){

		}
	};

	// 主人网络相关接口
	this.host = {
		context: this,
		getData: function(options){
			this.getOptions = options;
			var ctx  = this.context,
				self = this,
				data = {};

			data[uciWireless.fileName] = {};
			data[uciWireless.fileName][KEY_NAME] = [uciWireless.dynData.host_2g];

			if (ctx.bandsProvided == ctx.TRIPLE)
			{
				data[uciWireless.fileName][KEY_NAME].push(uciWireless.dynData.host_5g1, uciWireless.dynData.host_5g2);
			}
			else if (ctx.bandsProvided == ctx.DOUBLE)
			{
				data[uciWireless.fileName][KEY_NAME].push(uciWireless.dynData.host_5g);
			}

			if (this.context.bandSteeringProvided)
			{
				data[uciWireless.fileName][KEY_NAME].push(uciWireless.secName.wlanBS);
			}

			if (slp.moduleSpec["wifi_switch"] && slp.moduleSpec["wifi_switch"] == 1)
			{
				data[uciWireless.fileName][KEY_NAME].push(uciWireless.dynData.wifi_switch);
			}

			$.query(data, function(result){
				if (ENONE == result[ERR_CODE])
				{
					self.getOptions.success&&self.getOptions.success(result);
				}
				else
				{
					self.getOptions.fail&&self.getOptions.fail(result);
				}
			}, undefined, true);
		},
		// 需要保证data中都是差异数据，且修改一个频段
		setData: function(options){
			this.setOptions = options;
			this.stateChanged = false;
			this.timerSwtichOn = false;
			this.state = 0;

			var data = this.setOptions.data;
			var self = this;

			if (this.setOptions.name != undefined)	/* BS字段的isolate需要联动修改2.4G和5G的数据，故在此适配 */
			{
				self.name = name;
			}
			else
			{
				self.name = undefined;
			}

			Object.keys(data).forEach(function(name){
				if (self.name == undefined)
				{
					self.name = name;
				}

				if (self.name == name)	/* 只比较Target Name 数据 */
				{
					if ((name == uciWireless.dynData.wifi_switch && null != data[name][uciWireless.dynOptName.enable]) ||
						(name != uciWireless.secName.wlanBS && null != data[name][uciWireless.dynOptName.enable]) ||
						(name == uciWireless.secName.wlanBS && null != data[name][uciWireless.optName.wifiEnable]))
					{
						self.stateChanged = true;

						if (0 == data[name][uciWireless.dynOptName.enable] ||
							0 == data[name][uciWireless.optName.wifiEnable])
						{
							self.state = 0;
						}
						else
						{
							self.state = 1;
						}
					}
					else
					{
						self.stateChanged = false;
					}
				}
			});

			this._checkWDS();
		},
		//检查是否和WDS冲突
		_checkWDS: function(){
			var wdsName,
				self = this,
				name = this.name,
				para = this.setOptions.data[name],
				WDS_ALL = "all",
				ctx = this.context;

			var isSupportWifiAllSwitch = ctx.moduleSpec["wifi_switch"] && ctx.moduleSpec["wifi_switch"] == 1;

			switch(name)
			{
			case uciWireless.dynData.host_2g:
				wdsName = uciWireless.dynData.wds_2g;
				break;
			case uciWireless.dynData.host_5g:
				wdsName = uciWireless.dynData.wds_5g;
				break;
			case uciWireless.dynData.host_5g1:
				wdsName = uciWireless.dynData.wds_5g1;
				break;
			case uciWireless.dynData.host_5g2:
				wdsName = uciWireless.dynData.wds_5g2;
				break;
			case uciWireless.secName.wlanBS:
			default:
				wdsName = WDS_ALL;
				break;
			}

			self.context.wds.getData({
				success: function(res){
					var wdsOn = false;

					if (WDS_ALL == wdsName)
					{
						for (var name in res[uciWireless.fileName])
						{
							if (!res[uciWireless.fileName].hasOwnProperty(name)){
								continue;
							}
							if (1 == res[uciWireless.fileName][name][uciWireless.dynOptName.enable])
							{
								wdsOn = true;
								break;
							}
						}
					}
					else
					{
						wdsOn = (1 == res[uciWireless.fileName][wdsName][uciWireless.dynOptName.enable]);
					}

					/* WDS功能开启 */
					if (wdsOn)
					{
						if (WDS_ALL != wdsName)
						{
							// 不允许修改信道、模式、带宽
							if (null != para[uciWireless.dynOptName.channel] ||
								null != para[uciWireless.dynOptName.mode] ||
								null != para[uciWireless.dynOptName.bandwidth])
							{
								alarmDialog.show({content:errStr.wlanInvalidOptionWithWDSEnabled});

								self.setOptions.resetPhyConfig&&self.setOptions.resetPhyConfig();
								self.setOptions.fail&&self.setOptions.fail(res);
								return;
							}
						}

						if (self.stateChanged && 0 == self.state)
						{
							confirmDialog.show({
								title:label.confirmTitle,
								content:label.wirelessSwitchTipForWDS,
								callback:function(result){
									if (true == result)
									{
										!isSupportWifiAllSwitch ? self._checkWlanTimer() : self._checkWPS();
									}
									else
									{
										self.setOptions.fail&&self.setOptions.fail();
									}
								}
							});
						}
						else
						{
							!isSupportWifiAllSwitch ? self._checkWlanTimer() : self._checkWPS();
						}
					}
					else
					{
						!isSupportWifiAllSwitch ? self._checkWlanTimer() : self._checkWPS();
					}

				},
				fail: function(){
					!isSupportWifiAllSwitch ? self._checkWlanTimer() : self._checkWPS();
				}
			});
		},
		//检查是否和无线定时开关冲突
		_checkWlanTimer: function(){
			var data = {},
				self = this;

			data[uciTimeSwitch.fileName] = {};
			data[uciTimeSwitch.fileName][KEY_NAME] = [uciTimeSwitch.secName.general];

			if (self.stateChanged)
			{
				$.query(data, function(res){
					var wlanTimerData = res[uciTimeSwitch.fileName];

					if (null != wlanTimerData &&
						wlanTimerData[uciTimeSwitch.secName.general].enable == uciTimeSwitch.optValue.enable.on)
					{
						self.timerSwtichOn = true;
						confirmDialog.show({
							title:label.confirmTitle,
							content:label.timerSwitchTip,
							callback:function(result){
								if (true == result)
								{
									self._checkWPS();
								}
								else
								{
									self.setOptions.fail&&self.setOptions.fail();
								}
							}
						});
					}
					else
					{
						self.timerSwtichOn = false;
						self._checkWPS();
					}
				});
			}
			else
			{
				self._checkWPS();
			}
		},
		// 检查当前是否在进行WPS
		_checkWPS: function(){
			var data = {},
				self = this,
				wpsName,

				WPS_STATUS_2G = "wps_status_2g",
				WPS_STATUS_5G = "wps_status_5g",
				WPS_STATUS_5G1 = "wps_status_5g1",
				WPS_STATUS_5G2 = "wps_status_5g4",
				WPS_ALL = "all";

			/* TODO: 此处以后需要看支不支持BS */
			switch (this.name)
			{
			case uciWireless.dynData.host_2g:
				wpsName = WPS_STATUS_2G;
				break;
			case uciWireless.dynData.host_5g:
				wpsName = WPS_STATUS_5G;
				break;
			case uciWireless.dynData.host_5g1:
				wpsName = WPS_STATUS_5G1;
				break;
			case uciWireless.dynData.host_5g2:
				wpsName = WPS_STATUS_5G2;
				break;
			default:
				wpsName = WPS_ALL;
				break;
			}

			data[uciWireless.fileName] = {};
			data[uciWireless.fileName][KEY_NAME] = "wps_status";

			$.query(data, function(res){
				var wpsStatus = 0;

				if (ENONE == res[ERR_CODE])
				{
					if (wpsName == WPS_ALL)
					{
						for (var name in res[uciWireless.fileName]["wps_status"])
						{
							if (!res[uciWireless.fileName]["wps_status"].hasOwnProperty(name)){
								continue;
							}
							if (1 == res[uciWireless.fileName]["wps_status"][name])
							{
								wpsStatus = 1;
								break;
							}
						}
					}
					else
					{
						wpsStatus = res[uciWireless.fileName]["wps_status"][wpsName];
					}
				}
				else if (EUNAUTH == res[ERR_CODE])
				{
					wpsStatus = 0;
				}

				if (1 == wpsStatus)
				{
					confirmDialog.show({
						title:label.confirmTitle,
						content:label.wpsConfigShowTip,
						callback:function(result){
							if (result)
							{
								self._checkCurHost();
							}
							else
							{
								self.setOptions.fail&&self.setOptions.fail();
							}
						}
					});
				}
				else
				{
					self._checkCurHost();
				}
			});
		},
		// 如果是关闭无线，检查本机是否通过该无线连接
		_checkCurHost: function(){
			var data = {},
				self = this,
				name = this.name,
				ctx  = this.context,
				dynData = uciWireless.dynData;

			data[uciHostsInfo.fileName] = {};
			data[uciHostsInfo.fileName][KEY_TABLE] = [uciHostsInfo.dynData.online_host];

			if (self.stateChanged && self.state == 0)
			{
				$.query(data, function(res){
					var onlineHost = formatTableData(res[uciHostsInfo.fileName][uciHostsInfo.dynData.online_host]);
					var item;

					for (var i = 0, len = onlineHost.length; i < len; i++)
					{
						item = onlineHost[i];
						if (item["is_cur_host"] == 1)
						{
							// 设备已连接到主人网络
							if (item["type"] == 1)
							{
								if (name == uciWireless.dynData.wifi_switch ||
								    name == uciWireless.secName.wlanBS ||
								   (name == dynData.host_2g  && item["wifi_mode"] == "0") ||
								   (name == dynData.host_5g  && item["wifi_mode"] == "1") ||
								   (name == dynData.host_5g1 && item["wifi_mode"] == "2") ||
								   (name == dynData.host_5g2 && item["wifi_mode"] == "3"))
								{
									var confirmStr = label.wirelessSwitchTip;

									if (ctx.moduleSpec["wifi_switch"] && ctx.moduleSpec["wifi_switch"] == 1
										&& name == uciWireless.dynData.wifi_switch)
									{
										confirmStr = label.wifiAllSwitchCloseConfirm
									}

									confirmDialog.show({
										title:label.confirmTitle,
										content:confirmStr,
										callback:function(result){
											if (true == result)
											{
												self._send();
											}
											else
											{
												self.setOptions.fail&&self.setOptions.fail();
											}
										}
									});
								}
								else
								{
									self._send();
								}
							}
							else
							{
								self._send();
							}

							break;
						}
					}
				});
			}
			else
			{
				self._send();
			}
		},
		_send: function(){
			var data = {}, self = this;
			data[uciWireless.fileName] = this.setOptions.data;

			if (self.timerSwtichOn)
			{
				data[uciTimeSwitch.fileName] = {};
				data[uciTimeSwitch.fileName][uciTimeSwitch.secName.general] = {};
				data[uciTimeSwitch.fileName][uciTimeSwitch.secName.general][uciTimeSwitch.optName.enable] = uciTimeSwitch.optValue.enable.off;
			}

			$.modify(data, function(res){
				if (ENONE == res[ERR_CODE])
				{
					if (res["dfs_wait_time"] && res["dfs_wait_time"] != 0)
					{
						dfsDialog.show(res["dfs_wait_time"], function(){
							self.setOptions.success&&self.setOptions.success();
						});
					}
					else
					{
						self.setOptions.success&&self.setOptions.success();
					}
				}
				else
				{
					self.setOptions.fail&&self.setOptions.fail(res);
				}
			});
		}
	};

	// 上网参数相关接口
	this.protocol = {
		context: this,
		getData: function(options,wanIdx){
			this.getOptions = options;

			var data = {},
				secName = uciProto.secName,
				self = this;
			data[uciProto.fileName] = {};
			if (this.getOptions.type && this.getOptions.type == "IPv6")
			{
				if(typeof wanIdx != "undefined" && wanIdx == 2){
					data[uciProto.fileName][KEY_NAME] = [
						secName.wanv62,
						secName.dhcpv62,
						secName.pppoev62,
						secName.stav62
					];
				}else{
					data[uciProto.fileName][KEY_NAME] = [
						secName.wanv6,
						secName.dhcpv6,
						secName.pppoev6,
						secName.stav6
					];
				}
			}
			else
			{
				if(typeof wanIdx != "undefined" && wanIdx == 2){
					data[uciProto.fileName][KEY_NAME] = [
						secName.wan2,
						secName.dhcp2,
						secName.pppoe2,
						secName.sta2
					];
				} else {
					data[uciProto.fileName][KEY_NAME] = [
						secName.wan,
						secName.dhcp,
						secName.pppoe,
						secName.sta
					];
				}
			}

			$.query(data, function(res){
				if (ENONE == res[ERR_CODE])
				{
					self.getOptions.success&&self.getOptions.success(res);
				}
			}, undefined, true);
		},
		/* options格式为 */
		setData: function(options,wanIdx){
			this.setOptions = options;

			var wan;
			if(typeof wanIdx != "undefined" && wanIdx == 2){
				wan = this.setOptions.data[uciProto.secName.wan2];
			} else {
				wan = this.setOptions.data[uciProto.secName.wan];
			}

			if (wan && null != wan[uciProto.optName.type])
			{
				this.type = wan[uciProto.optName.type];
			}

			this._checkWDS();
		},
		// 检查WDS是否开启
		_checkWDS: function(){
			var self = this;

			this.context.wds.getData({
				success: function(res){

					var item,
						wdsOn = false;

					for (var name in res[uciWireless.fileName])
					{
						if (!res[uciWireless.fileName].hasOwnProperty(name)){
							continue;
						}
						item = res[uciWireless.fileName][name];
						if (item[uciWireless.dynOptName.enable] == 1)
						{
							wdsOn = true;
							break;
						}
					}

					if (wdsOn)
					{
						alarmDialog.show({content:label.wanWDSTip});
						self.setOptions.fail&&self.setOptions.fail(res);
					}
					else
					{
						self._checkBridgeMode();
					}
				},
				fail: function(){
					self._checkBridgeMode();
				}
			});
		},
		// 如果是运营商定制机型，检查是否处于桥模式
		_checkBridgeMode: function(){
			var self = this;
			var data = {};

			if (this.context.moduleSpec["elink"] != undefined && 1 == this.context.moduleSpec["elink"])
			{
				data[uciNetwork.fileName] = {};
				data[uciNetwork.fileName][KEY_NAME] = [uciNetwork.dynData.bridgestatus];
				$.query(data, function(res){
					if (ENONE == res[ERR_CODE])
					{
						if (res.network.bridge_status.enable == 1)
						{
							alarmDialog.show({content:"设备工作在桥模式，宽带拨号上网功能禁用。"});
							self.setOptions.fail&&self.setOptions.fail(res);
							return;
						}
						else
						{
							self._send();
						}
					}
					else
					{
						self._send();
					}
				});
			}
			else
			{
				this._send();
			}
		},
		_send: function(){
			var data = {},
				self = this;

			data[uciProto.fileName] = this.setOptions.data;
			$.modify(data, function(res){
				if (ENONE == res[ERR_CODE])
				{
					self.setOptions.success&&self.setOptions.success(res);
				}
				else
				{
					self.setOptions.fail&&self.setOptions.fail(res);
				}
			});
		}
	};

	// 访客网络相关接口
	this.guest = {
		context: this,
		getData: function(options){
			this.getOptions = options;

			var data = {},
				self = this;
			data[uciGuestNet.fileName] = {};
			data[uciGuestNet.fileName][KEY_NAME] = [uciGuestNet.secName.wireless2G];

			/* 是否支持5G访客网络 */
			if (this.context.moduleSpec.guest5g != undefined && 1 == this.context.moduleSpec.guest5g)
			{
				data[uciGuestNet.fileName][KEY_NAME].push(uciGuestNet.secName.wireless5G);
			}

			$.query(data, function(res){
				if (ENONE == res[ERR_CODE])
				{
					self.getOptions.success&&self.getOptions.success(res);
				}
			}, undefined, true);
		},
		setData: function(options){
			this.setOptions = options;

			this._send();
		},
		_send: function(){
			var data = {},
				self = this;

			data[uciGuestNet.fileName] = this.setOptions.data;
			$.modify(data, function(res){
				if (ENONE == res[ERR_CODE])
				{
					if (res["dfs_wait_time"] && res["dfs_wait_time"] != 0)
					{
						dfsDialog.show(res["dfs_wait_time"], function(){
							self.setOptions.success&&self.setOptions.success();
						});
					}
					else
					{
						self.setOptions.success&&self.setOptions.success();
					}
				}
				else
				{
					self.setOptions.fail&&self.setOptions.fail(res);
				}
			});
		}
	};

	/* 防止页面多处获取wan_status，而使请求频繁发送	*/
	this.timeStamp = null;
	this.expire = 1*1000;//过期时间暂定为1秒钟
	this.wanStatus = {};
	this.wanIdx = 1;

	this.latestWanStatus = function(callback, isImmediately,wanIdx){
		var self = this;
		var timeStamp = new Date().getTime();

		if ((isImmediately == undefined || isImmediately == false) && (null != this.timeStamp) &&
			(timeStamp - this.timeStamp < this.expire) && ((typeof wanIdx == "undefined" && this.wanIdx == 1) || (typeof wanIdx != "undefined" && this.wanIdx == wanIdx)))
		{
			callback&&callback(this.wanStatus);
			return;
		}

		var data = {};
		data[uciNetwork.fileName] = {};
		if (typeof wanIdx != "undefined" && wanIdx == 2)
		{
			data[uciNetwork.fileName][KEY_NAME] = uciNetwork.dynData.wanStatus2;
		}
		else 
		{
			data[uciNetwork.fileName][KEY_NAME] = uciNetwork.dynData.wanStatus;
		}
		/* 若支持硬件NAT，则判断是否开启 */
		if (this.moduleSpec["hnat"] != undefined && 1 == this.moduleSpec["hnat"])
		{
			data[uciHNat.fileName] = {};
			data[uciHNat.fileName][KEY_NAME] = uciHNat.secName.main;
		}

		$.query(data, function(res){
			if (ENONE == res[ERR_CODE])
			{
				self.timeStamp = new Date().getTime();
				if (typeof wanIdx != "undefined" && wanIdx == 2){
					self.wanStatus = res[uciNetwork.fileName][uciNetwork.dynData.wanStatus2];
					self.wanIdx = wanIdx;
				}
				else 
				{
					self.wanStatus = res[uciNetwork.fileName][uciNetwork.dynData.wanStatus];
					self.wanIdx = 1;
				}
				if (res[uciHNat.fileName] &&
					res[uciHNat.fileName][uciHNat.secName.main][uciHNat.optName.enable] == 1)
				{
					/* 若硬件NAT开启，则不再提供上下行速率 */
					self.wanStatus[uciNetwork.optName.upSpeed] = null;
					self.wanStatus[uciNetwork.optName.downSpeed] = null;
				}
			}

			callback&&callback(self.wanStatus);
		}, undefined, true);
	};

	this.getWiFiStatus = function(callback){
		var dfdHost  = $.Deferred(),
			dfdGuest = $.Deferred(),
			data = {};

		slp.host.getData({success: function(result){
			data[uciWireless.fileName] = result[uciWireless.fileName];
			dfdHost.resolve();
		}});
		slp.guest.getData({success: function(result){
			data[uciGuestNet.fileName] = result[uciGuestNet.fileName];
			dfdGuest.resolve();
		}});

		$.when(dfdHost, dfdGuest).done(function(){
			typeof callback == "function" && callback(data);
		});
	}

	/* 初始化规格参数 */
	this.init = function(callback){
		var self = this, data = {};
		data[uciFunction.fileName] = {};
		data[uciFunction.fileName][KEY_NAME] = uciFunction.secName.newModuleSpec;

		$.query(data, function(result){
			if (ENONE == result[ERR_CODE])
			{
				self.moduleSpec = result[uciFunction.fileName][uciFunction.secName.newModuleSpec];
				self.bandSteeringProvided = self.moduleSpec[uciFunction.optName.wlanBS] == 1;
				self.guest5GSupport = self.moduleSpec[uciFunction.optName.guest5g] == 1;
				self.wifiSwitchSupport = self.moduleSpec[uciFunction.optName.wifiSwitch] == 1;
				self.wifiSwitchSplitSupport = self.moduleSpec[uciFunction.optName.wifiSwitchSplit] == 1;
				self.multiSsidSupport = self.moduleSpec[uciFunction.optName.supportMultiSsid] == 1;
				self.wpsSupport = self.moduleSpec[uciFunction.optName.supportPinWps] == 1;
				self.macFilterSupport = self.moduleSpec[uciFunction.optName.macFilterSupport] == 1;
				self.modeSwitchSupport = self.moduleSpec[uciFunction.optName.modeSwitchSupport] == 1;
				self.elinkSupport = self.moduleSpec[uciFunction.optName.elink] == 1;
				self.wolinkSupport = self.moduleSpec[uciFunction.optName.wolink] == 1;
				self.alinkTestSupport = self.moduleSpec[uciFunction.optName.alinkTest] == 1;
				self.hnatSupport = self.moduleSpec[uciFunction.optName.hnat] == 1;
				self.customLedSupport = self.moduleSpec[uciFunction.optName.customLed] == 1;
				self.ipv6Support = self.moduleSpec[uciFunction.optName.ipv6] == 1;
				self.muMimoSupport2g = self.moduleSpec[uciFunction.optName.mumimo2g] == 1;
				self.muMimoSupport5g = self.moduleSpec[uciFunction.optName.mumimo5g] == 1;
				self.muMimoSupport5g1 = self.moduleSpec[uciFunction.optName.mumimo5g1] == 1;
				self.muMimoSupport5g4 = self.moduleSpec[uciFunction.optName.mumimo5g4] == 1;
				self.usernameSupport = usernameSupport;
				self.gSfpRateSupport = self.moduleSpec[uciFunction.optName.sfpRate] == uciFunction.optValue.enable;
				self.gSupportPortManage = self.moduleSpec[uciFunction.optName.portManage] == uciFunction.optValue.enable;
				self.gMulWanSupport = ($.inArray(uciPortConfig.secType.mwan,self.moduleSpec[uciFunction.optName.portSubFunc])) != -1;
				self.gIptvSupport = ($.inArray(uciPortConfig.secType.iptv,self.moduleSpec[uciFunction.optName.portSubFunc])) != -1;
				self.gLagSupport = ($.inArray(uciPortConfig.secType.lag,self.moduleSpec[uciFunction.optName.portSubFunc])) != -1;
				self.gGameSupport = ($.inArray(uciPortConfig.secType.game,self.moduleSpec[uciFunction.optName.portSubFunc])) != -1;
				if (self.moduleSpec[uciFunction.optName.loadBalanceMode] != undefined)
				{
					self.gMWanLoadBalanceSupport = true;
				}
				if (self.moduleSpec[uciSystem.secName.sysMode] != undefined)
				{
					self.gSysModeSupport = true;
				}
				if (self.moduleSpec[uciFunction.optName.wanPortIndexList] != undefined)
				{
					self.ethLayoutList = self.moduleSpec[uciFunction.optName.ethLayout];
					self.devicePowerPos = self.moduleSpec[uciFunction.optName.powerPos];
					self.wanPortRateList = {};
					self.wanPortRateDescList = {};
					var wanPortRateListData = self.moduleSpec[uciFunction.optName.wanPortRateList];
					var wanPortRateDescListData = self.moduleSpec[uciFunction.optName.wanPortRateDescList];
					var wanPortIndexListData = self.moduleSpec[uciFunction.optName.wanPortIndexList];
					for (var i = 0; i < wanPortIndexListData.length; i++)
					{
						self.wanPortRateList[wanPortIndexListData[i]] = wanPortRateListData[i].split("_");
						self.wanPortRateDescList[wanPortIndexListData[i]] = wanPortRateDescListData[i].split("_");
					}
				}
				if (self.moduleSpec[uciFunction.optName.wlanServiceAttr] != undefined)
				{
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr].indexOf("auth") != -1)
					{
						self.authSupport = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr].indexOf("cipher") != -1)
					{
						self.cipherSupport = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr].indexOf("twt") != -1)
					{
						self.twtSupport = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr].indexOf("ofdma") != -1)
					{
						self.ofdmaSupport = true;
					}
				}

				if (self.moduleSpec[uciFunction.optName.wlanServiceAttr2g] != undefined)
				{
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr2g].indexOf("auth") != -1)
					{
						self.authSupport2g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr2g].indexOf("cipher") != -1)
					{
						self.cipherSupport2g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr2g].indexOf("twt") != -1)
					{
						self.twtSupport2g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr2g].indexOf("ofdma") != -1)
					{
						self.ofdmaSupport2g = true;
					}
				}

				if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g] != undefined)
				{
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g].indexOf("auth") != -1)
					{
						self.authSupport5g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g].indexOf("cipher") != -1)
					{
						self.cipherSupport5g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g].indexOf("twt") != -1)
					{
						self.twtSupport5g = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g].indexOf("ofdma") != -1)
					{
						self.ofdmaSupport5g = true;
					}
				}

				if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g1] != undefined)
				{
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g1].indexOf("auth") != -1)
					{
						self.authSupport5g1 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g1].indexOf("cipher") != -1)
					{
						self.cipherSupport5g1 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g1].indexOf("twt") != -1)
					{
						self.twtSupport5g1 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g1].indexOf("ofdma") != -1)
					{
						self.ofdmaSupport5g1 = true;
					}
				}

				if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g4] != undefined)
				{
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g4].indexOf("auth") != -1)
					{
						self.authSupport5g4 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g4].indexOf("cipher") != -1)
					{
						self.cipherSupport5g4 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g4].indexOf("twt") != -1)
					{
						self.twtSupport5g4 = true;
					}
					if (self.moduleSpec[uciFunction.optName.wlanServiceAttr5g4].indexOf("ofdma") != -1)
					{
						self.ofdmaSupport5g4 = true;
					}
				}

				if (null != self.moduleSpec[uciFunction.optName.channel5g1])
				{
					self.bandsProvided = self.TRIPLE;
					for (var i = 0; i < self.moduleSpec[uciFunction.optName.mode5g1].length; i++)
					{
						if (self.moduleSpec[uciFunction.optName.mode5g1][i].search("ax") != -1)
						{
							self.g11AXSupport["wlan5g1"] = true;
							break;
						}
					}

					for (var i = 0; i < self.moduleSpec[uciFunction.optName.mode5g4].length; i++)
					{
						if (self.moduleSpec[uciFunction.optName.mode5g4][i].search("ax") != -1)
						{
							self.g11AXSupport["wlan5g4"] = true;
							break;
						}
					}
				}
				else if (null != self.moduleSpec[uciFunction.optName.channel5g])
				{
					self.bandsProvided = self.DOUBLE;
					for (var i = 0; i < self.moduleSpec[uciFunction.optName.mode5g].length; i++)
					{
						if (self.moduleSpec[uciFunction.optName.mode5g][i].search("ax") != -1)
						{
							self.g11AXSupport["wlan5g"] = true;
							break;
						}
					}
					if ($.inArray("80MHz", self.moduleSpec[uciFunction.optName.bandWidth5g]) != -1) {
						self.wlanHost5gSupport160MBandWidth = true;
					}
				}
				else
				{
					self.bandsProvided = self.SINGLE;
				}

				for (var i = 0; i < self.moduleSpec[uciFunction.optName.mode2g].length; i++)
				{

					if (self.moduleSpec[uciFunction.optName.mode2g][i].search("ax") != -1)
					{
						self.g11AXSupport["wlan2g"] = true;
						break;
					}
				}

				//对于当前的WPA3设计，一般都是全频段行为统一，要么都支持WPA3，要么都不支持
				//故此处仅获取2.4G频段相关即可
				if (self.moduleSpec[uciFunction.optName.supportWlanAuthType2g] != undefined)
				{
					for (i = 0; i < self.moduleSpec[uciFunction.optName.supportWlanAuthType2g].length; i++)
					{
						if (parseInt(self.moduleSpec[uciFunction.optName.supportWlanAuthType2g][i]) == uciWireless.dynOptValue.auth.psk2_sae3 ||
						    parseInt(self.moduleSpec[uciFunction.optName.supportWlanAuthType2g][i]) == uciWireless.dynOptValue.auth.sae3)
						{
							self.wpa3Support = true;
						}
					}
				}

				self.hostnameMaxLen = self.moduleSpec[uciFunction.optName.hostnameMaxLen] || 31;
			}

			typeof callback == "function" && callback();
		}, undefined, true);
	};

	//this.init();
}

var slp = new SLP();

/* ====================================== polyfill ===================================== */
(function(){
	if (!Object.keys) {
	  Object.keys = (function () {
		var hasOwnProperty = Object.prototype.hasOwnProperty,
			hasDontEnumBug = !({toString: null}).propertyIsEnumerable('toString'),
			dontEnums = [
			  'toString',
			  'toLocaleString',
			  'valueOf',
			  'hasOwnProperty',
			  'isPrototypeOf',
			  'propertyIsEnumerable',
			  'constructor'
			],
			dontEnumsLength = dontEnums.length;

		return function (obj) {
		  if (typeof obj !== 'object' && typeof obj !== 'function' || obj === null) throw new TypeError('Object.keys called on non-object');

		  var result = [];

		  for (var prop in obj) {
			if (hasOwnProperty.call(obj, prop)) result.push(prop);
		  }

		  if (hasDontEnumBug) {
			for (var i=0; i < dontEnumsLength; i++) {
			  if (hasOwnProperty.call(obj, dontEnums[i])) result.push(dontEnums[i]);
			}
		  }
		  return result;
		}
	  })()
	}

	// Production steps of ECMA-262, Edition 5, 15.4.4.19
	// Reference: http://es5.github.io/#x15.4.4.19
	if (!Array.prototype.map) {

	  Array.prototype.map = function(callback/*, thisArg*/) {

		var T, A, k;

		if (this == null) {
		  throw new TypeError('this is null or not defined');
		}

		// 1. Let O be the result of calling ToObject passing the |this|
		//    value as the argument.
		var O = Object(this);

		// 2. Let lenValue be the result of calling the Get internal
		//    method of O with the argument "length".
		// 3. Let len be ToUint32(lenValue).
		var len = O.length >>> 0;

		// 4. If IsCallable(callback) is false, throw a TypeError exception.
		// See: http://es5.github.com/#x9.11
		if (typeof callback !== 'function') {
		  throw new TypeError(callback + ' is not a function');
		}

		// 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
		if (arguments.length > 1) {
		  T = arguments[1];
		}

		// 6. Let A be a new array created as if by the expression new Array(len)
		//    where Array is the standard built-in constructor with that name and
		//    len is the value of len.
		A = new Array(len);

		// 7. Let k be 0
		k = 0;

		// 8. Repeat, while k < len
		while (k < len) {

		  var kValue, mappedValue;

		  // a. Let Pk be ToString(k).
		  //   This is implicit for LHS operands of the in operator
		  // b. Let kPresent be the result of calling the HasProperty internal
		  //    method of O with argument Pk.
		  //   This step can be combined with c
		  // c. If kPresent is true, then
		  if (k in O) {

			// i. Let kValue be the result of calling the Get internal
			//    method of O with argument Pk.
			kValue = O[k];

			// ii. Let mappedValue be the result of calling the Call internal
			//     method of callback with T as the this value and argument
			//     list containing kValue, k, and O.
			mappedValue = callback.call(T, kValue, k, O);

			// iii. Call the DefineOwnProperty internal method of A with arguments
			// Pk, Property Descriptor
			// { Value: mappedValue,
			//   Writable: true,
			//   Enumerable: true,
			//   Configurable: true },
			// and false.

			// In browsers that support Object.defineProperty, use the following:
			// Object.defineProperty(A, k, {
			//   value: mappedValue,
			//   writable: true,
			//   enumerable: true,
			//   configurable: true
			// });

			// For best browser support, use the following:
			A[k] = mappedValue;
		  }
		  // d. Increase k by 1.
		  k++;
		}

		// 9. return A
		return A;
	  };
	}

	// Production steps of ECMA-262, Edition 5, 15.4.4.18
	// Reference: http://es5.github.io/#x15.4.4.18
	if (!Array.prototype.forEach) {

	  Array.prototype.forEach = function(callback, thisArg) {

		var T, k;

		if (this == null) {
		  throw new TypeError(' this is null or not defined');
		}

		// 1. Let O be the result of calling toObject() passing the
		// |this| value as the argument.
		var O = Object(this);

		// 2. Let lenValue be the result of calling the Get() internal
		// method of O with the argument "length".
		// 3. Let len be toUint32(lenValue).
		var len = O.length >>> 0;

		// 4. If isCallable(callback) is false, throw a TypeError exception.
		// See: http://es5.github.com/#x9.11
		if (typeof callback !== "function") {
		  throw new TypeError(callback + ' is not a function');
		}

		// 5. If thisArg was supplied, let T be thisArg; else let
		// T be undefined.
		if (arguments.length > 1) {
		  T = thisArg;
		}

		// 6. Let k be 0
		k = 0;

		// 7. Repeat, while k < len
		while (k < len) {

		  var kValue;

		  // a. Let Pk be ToString(k).
		  //    This is implicit for LHS operands of the in operator
		  // b. Let kPresent be the result of calling the HasProperty
		  //    internal method of O with argument Pk.
		  //    This step can be combined with c
		  // c. If kPresent is true, then
		  if (k in O) {

			// i. Let kValue be the result of calling the Get internal
			// method of O with argument Pk.
			kValue = O[k];

			// ii. Call the Call internal method of callback with T as
			// the this value and argument list containing kValue, k, and O.
			callback.call(T, kValue, k, O);
		  }
		  // d. Increase k by 1.
		  k++;
		}
		// 8. return undefined
	  };
	}

	if (!Array.prototype.filter)
	{
	  Array.prototype.filter = function(fun /* , thisArg*/)
	  {
		"use strict";

		if (this === void 0 || this === null)
		  throw new TypeError();

		var t = Object(this);
		var len = t.length >>> 0;
		if (typeof fun !== "function")
		  throw new TypeError();

		var res = [];
		var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
		for (var i = 0; i < len; i++)
		{
		  if (i in t)
		  {
			var val = t[i];

			// NOTE: Technically this should Object.defineProperty at
			//       the next index, as push can be affected by
			//       properties on Object.prototype and Array.prototype.
			//       But that method's new, and collisions should be
			//       rare, so use the more-compatible alternative.
			if (fun.call(thisArg, val, i, t))
			  res.push(val);
		  }
		}

		return res;
	  };
	}

	if (!Array.prototype.map) {
	  Array.prototype.map = function(callback, thisArg) {

		var T, A, k;

		if (this == null) {
		  throw new TypeError(" this is null or not defined");
		}

		// 1. 将O赋值为调用map方法的数组.
		var O = Object(this);

		// 2.将len赋值为数组O的长度.
		var len = O.length >>> 0;

		// 3.如果callback不是函数,则抛出TypeError异常.
		if (Object.prototype.toString.call(callback) != "[object Function]") {
		  throw new TypeError(callback + " is not a function");
		}

		// 4. 如果参数thisArg有值,则将T赋值为thisArg;否则T为undefined.
		if (thisArg) {
		  T = thisArg;
		}

		// 5. 创建新数组A,长度为原数组O长度len
		A = new Array(len);

		// 6. 将k赋值为0
		k = 0;

		// 7. 当 k < len 时,执行循环.
		while(k < len) {

		  var kValue, mappedValue;

		  //遍历O,k为原数组索引
		  if (k in O) {

			//kValue为索引k对应的值.
			kValue = O[ k ];

			// 执行callback,this指向T,参数有三个.分别是kValue:值,k:索引,O:原数组.
			mappedValue = callback.call(T, kValue, k, O);

			// 返回值添加到新数组A中.
			A[ k ] = mappedValue;
		  }
		  // k自增1
		  k++;
		}

		// 8. 返回新数组A
		return A;
	  };
	}
})();