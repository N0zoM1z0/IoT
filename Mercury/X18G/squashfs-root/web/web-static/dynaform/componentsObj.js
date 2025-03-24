var componentObj = function(){
	this.alarmDialog = new Dialog({
		title: label.confirmTitle,
		content: "",
		size: Dialog.SIZE.SMALL,
		hasCloseIcon: true,
		closeIconHandle: function(){
			if (alarmDialog.clickCallback != null)
			{
				typeof alarmDialog.clickCallback == "function" && alarmDialog.clickCallback();
			}
		},
		isConstant: true,
		type: Dialog.TYPE.ALARM,
		bottom: [
			{
				type: component.Button.TYPE.PRIMARY,
				text: btn.knowIt,
				id:'alarmSubmit',
				onClick: function(){
					$(alarmDialog.container).find(".dlgCloseBtn")[0].click();
				}
			}
		]
	});
	this.alarmDialog.clickCallback = null;
	this.alarmDialog.show = function(option){
		var self = this;

		if (option != undefined)
		{
			if (typeof option == "string")
			{
				self._resetContent(option);
				self.clickCallback = null;
				self._ops.bottom[0].obj._init({text: btn.knowIt});
			}
			else if ($.isPlainObject(option))
			{
				if (option.title != undefined && typeof option.title == "string")
				{
					$(self.container).find("div.dialogTitle span").html(option.title);
				}
				else
				{
					$(self.container).find("div.dialogTitle span").html(label.confirmTitle);
				}

				if (option.content != undefined && typeof option.content == "string")
				{
					self._resetContent(option.content);
				}
				else
				{
					self._resetContent("");
				}

				if (option.callback != undefined && typeof option.callback == "function")
				{
					self.clickCallback = option.callback;
				}
				else
				{
					self.clickCallback = null;
				}

				self._ops.bottom[0].obj._init({text: ((typeof option.buttonStr == "string") ? option.buttonStr : btn.knowIt)});
			}

			Dialog.prototype.show.call(this);
		}
	}

	this.confirmDialog = new Dialog({
		title: label.confirmTitle,
		content: "",
		size: Dialog.SIZE.SMALL,
		hasCloseIcon: true,
		type: Dialog.TYPE.NORMAL,
		isConstant: true,
		closeIconHandle: function(){
			confirmDialog.hide(function(){
				typeof confirmDialog.clickCallback == "function" && confirmDialog.clickCallback(confirmDialog.isCloseHandleBindSubmit);
			})
		},
		bottom: [
			{
				type:component.Button.TYPE.SECONDARY,
				text:btn.cancelTip,
				id:'confirmCancel',
				onClick:function(){
					confirmDialog.hide(function(){
						typeof confirmDialog.clickCallback == "function" && confirmDialog.clickCallback(false);
					});
				}
			},
			{
				type:component.Button.TYPE.PRIMARY,
				text:btn.confirmTip,
				id:'confirmSubmit',
				onClick:function(){
					confirmDialog.hide(function(){
						typeof confirmDialog.clickCallback == "function" && confirmDialog.clickCallback(true);
					});
				}
			}]
	});
	this.confirmDialog.clickCallback = null;
	this.confirmDialog.isCloseHandleBindSubmit = false;
	this.confirmDialog.show = function(option){
		var self = this;

		if (option != undefined && $.isPlainObject(option))
		{
			if (option.title != undefined && typeof option.title == "string")
			{
				$(self.container).find("div.dialogTitle span").html(option.title);
			}
			else
			{
				$(self.container).find("div.dialogTitle span").html(label.confirmTitle);
			}

			if (option.content != undefined && typeof option.content == "string")
			{
				$(self.container).find("div.dialogContent span").html(option.content);
			}

			if (option.button != undefined)
			{
				self._ops.bottom[0].obj._init({text: ((typeof option.button.cancelStr == "string") ? option.button.cancelStr : btn.cancelTip)});
				self._ops.bottom[1].obj._init({text: ((typeof option.button.confirmStr == "string") ? option.button.confirmStr : btn.confirmTip)});
			}
			else
			{
				self._ops.bottom[0].obj._init({text:btn.cancelTip});
				self._ops.bottom[1].obj._init({text:btn.confirmTip});
			}

			if (option.isCloseHandleBindSubmit != undefined)
			{
				self.isCloseHandleBindSubmit = option.isCloseHandleBindSubmit;
			}
			else
			{
				self.isCloseHandleBindSubmit = false;
			}

			if (option.callback != undefined)
			{
				self.clickCallback = option.callback;
			}
		}

		Dialog.prototype.show.call(this);
	}

	this.loadingDialog = new Dialog({
		title: label.confirmTitle,
		size: Dialog.SIZE.SMALL,
		hasCloseIcon: true,
		type: Dialog.TYPE.LOADING,
		isConstant: true,
		content: {
			primary: "",
			secondary: ""
		}
	});
	this.loadingDialog.timeHandler = null;
	this.loadingDialog.show = function(option, timeoutCallback, timeout, hasCloseIcon, closeCallback){
		var self = this;

		if (option != undefined && $.isPlainObject(option))
		{
			if (option.title != undefined && typeof option.title == "string")
			{
				$(self.container).find("div.dialogTitle span").html(option.title);
			}
			else
			{
				$(self.container).find("div.dialogTitle span").html(label.confirmTitle);
			}

			if (option.content != undefined && !$.isEmptyObject(option.content))
			{
				option.content.primary = option.content.primary == undefined ? "" : option.content.primary;
				option.content.secondary = option.content.secondary == undefined ? "" : option.content.secondary;
				$(self.container).find("div.dialogContent span.primary").html(option.content.primary);
				$(self.container).find("div.dialogContent span.secondary").html(option.content.secondary);
			}
		}

		if (hasCloseIcon != undefined && hasCloseIcon == true)
		{
			$(self.container).find(".dlgCloseBtn").css("display", "block");
		}
		else
		{
			$(self.container).find(".dlgCloseBtn").css("display", "none");
		}

		if (typeof closeCallback == "function")
		{
			self._ops.closeIconHandle = closeCallback;
		}
		else
		{
			self._ops.closeIconHandle = null;
		}

		clearTimeout(self.timeHandler);

		if (typeof timeoutCallback == "function" && timeout != undefined && timeout > 0)
		{
			self.timeHandler = $.setTimeout(timeoutCallback, timeout);
		}

		Dialog.prototype.show.call(this);
	}

	this.timePeriodDialog = new Dialog({
		title: label.addTimePeriod,
		content:'<div id="timeDescCon" class="timePeriodCon"></div>' +
				'<div id="timeStartCon" class="timePeriodCon timePeriodTimeInput"></div>' +
				'<div id="timeEndCon" class="timePeriodCon timePeriodTimeInput"></div>' +
				'<div class="timePeriodCon">' +
					'<ul class="inputCMPT medium">' +
						'<label class="outerLbl">' + label.everyWeek + label.repeat + '</label>' +
						'<div id="dayChoose">' +
							'<div id="mon" class="timePeriodDayChoose"></div>' +
							'<div id="tue" class="timePeriodDayChoose"></div>' +
							'<div id="wed" class="timePeriodDayChoose"></div>' +
							'<div id="thu" class="timePeriodDayChoose"></div>' +
							'<div id="fri" class="timePeriodDayChoose"></div>' +
							'<div id="sat" class="timePeriodDayChoose"></div>' +
							'<div id="sun" class="timePeriodDayChoose"></div>' +
						'</div>' +
					'</ul>' +
				'</div>',
		hasCloseIcon: true,
		size: Dialog.SIZE.SMALL,
		type: Dialog.TYPE.CUSTOM,
		isConstant: true,
		bottom: [
			{
				type:component.Button.TYPE.SECONDARY,
				text:btn.cancel,
				id:'timePeriodCancel',
				onClick:function(){
					timePeriodDialog.hide();
				}
			},
			{
				type:component.Button.TYPE.PRIMARY,
				text:'确定',
				id:'timePeriodSubmit',
				onClick:function(){
					/* TODO : 此处需要加上(当没有修改数据时，不执行保存操作) */
					/* VAILD CHECK */
					var checkRes = true;
					var inputArr = [timePeriodDialog.timeDesc,
									timePeriodDialog.timeStartHour,
									timePeriodDialog.timeStartMin,
									timePeriodDialog.timeEndHour,
									timePeriodDialog.timeEndMin];
					var data = {};

					inputArr.forEach(function(o){
						checkRes = o.checkAll() && checkRes;
					});

					if (!checkRes)
					{
						return;
					}

					var sHour = timePeriodDialog.timeStartHour.getValue();
					var sMin = timePeriodDialog.timeStartMin.getValue();
					var eHour = timePeriodDialog.timeEndHour.getValue();
					var eMin = timePeriodDialog.timeEndMin.getValue();

					/*
					if ((parseInt(sHour, 10) * 60 + parseInt(sMin, 10)) ==
						(parseInt(eHour, 10) * 60 + parseInt(eMin, 10)))
					{
						timePeriodDialog.timeEndMin.showNote(timePeriodDialog.errorStr.END_TIME_EQUAL_START_TIME);
					}
					else
					{
						timePeriodDialog.timeEndMin.closeNote();
					}*/

					data.mode = timePeriodDialog.mode;
					data.index = timePeriodDialog.timePeriodIndex;

					if (timePeriodDialog.timePeriodArrayIndex != null)
					{
						data.arrayIndex = timePeriodDialog.timePeriodArrayIndex;
					}

					if (timePeriodDialog.timePeriodItemName != null)
					{
						data.itemName = timePeriodDialog.timePeriodItemName;
					}

					data.name = timePeriodDialog.timeDesc.getValue();
					data.startHour = sHour;
					data.startMin = sMin;
					data.endHour = eHour;
					data.endMin = eMin;
					data.mon = timePeriodDialog.dayMon.getValue();
					data.tue = timePeriodDialog.dayTue.getValue();
					data.wed = timePeriodDialog.dayWed.getValue();
					data.thu = timePeriodDialog.dayThu.getValue();
					data.fri = timePeriodDialog.dayFri.getValue();
					data.sat = timePeriodDialog.daySat.getValue();
					data.sun = timePeriodDialog.daySun.getValue();

					if (data.mon == false &&
						data.tue == false &&
						data.wed == false &&
						data.thu == false &&
						data.fri == false &&
						data.sat == false &&
						data.sun == false)
					{
						showToast(errStr.timePeriodMustSelectDay);
						return;
					}

					$(timePeriodDialog).trigger("ev_timePeriodCommit", [data]);
				}
			}
		],
		renderCallBack: function(){
			var self = this, span, li, div, p;

			self.timeDesc = new Input({
				type:Input.TYPE.PLAIN_TEXT,
				targetId: 'timeDescCon',
				label: {value:label.periodDesc},
				check:{blur:checkDesc},
				props:{maxlength: '32', type: "text"}
			});

			self.timeStartHour = new Input({
				type:Input.TYPE.PLAIN_TEXT,
				targetId: 'timeStartCon',
				label: {value:label.beginTime},
				tips:{value:label.hour, className: "unit"},
				check:{blur:checkHour},
				props:{maxlength: '2', type: "text"}
			});

			self.timeStartMin = new Input({
				type:Input.TYPE.PLAIN_TEXT,
				targetId: 'timeStartCon',
				tips:{value:label.minute, className: "unit"},
				check:{blur:checkMin},
				props:{maxlength: '2', type: "text"}
			});
			$(self.timeStartMin.dom).css("marginLeft", "12px");

			self.timeEndHour = new Input({
				type:Input.TYPE.PLAIN_TEXT,
				targetId: 'timeEndCon',
				label: {value:label.endTime},
				check:{blur:checkHour},
				tips:{value:label.hour, className: "unit"},
				props:{maxlength: '2', type: "text"}
			});

			self.timeEndMin = new Input({
				type:Input.TYPE.PLAIN_TEXT,
				targetId: 'timeEndCon',
				tips:{value:label.minute, className: "unit"},
				check:{blur:checkMin},
				props:{maxlength: '2', type: "text"}
			});
			$(self.timeEndMin.dom).css("marginLeft", "12px");

			span = document.createElement("span");
			span.className = "timePeriodAcrossDay";
			span.id = "timePeriodAcrossDay";
			span.innerHTML = label.timePeriodNextDay;
			id("timeEndCon").appendChild(span);

			li = document.createElement("li");
			li.id = "timePeriodRuleTipsCon";
			li.className = "note";
			li.style.display = "none";
			self.timeEndMin.dom.appendChild(li);

			div = document.createElement("div");
			div.className = "noteCon";
			li.appendChild(div);

			p = document.createElement("p");
			p.id = "timePeriodRuleTips";
			div.appendChild(p);

			function checkDesc()
			{
				var MAX = 32;
				var MIN = 1;

				if (this.input.value.length == 0)
				{
					this.showNote(errStr.inputTimePeriodBlank);
					return false;
				}
				else if (checkInputName(this.input.value, MAX, MIN) != ENONE)
				{
					this.showNote(errStr.inputTimePeriodTooLong);
					return false;
				}

				return true;
			}

			function checkHour()
			{
				if (this.input.value == "" || !checkNum(this.input.value))
				{
					this.showNote(errStr.inputNum);
					return false;
				}

				if (!checkNumRange(this.input.value, 23, 0))
				{
					this.setValue(23);
				}

				if (this.input.value.length < 2)
				{
					this.setValue("0" + this.input.value);
				}

				return checkTimeRule.call(this);
			}

			function checkMin()
			{
				var options = {};
				if (this.input.value == "" || !checkNum(this.input.value))
				{
					this.showNote(errStr.inputNum);
					return false;
				}

				if (!checkNumRange(this.input.value, 59, 0))
				{
					this.setValue(59);
				}

				if (this.input.value.length < 2)
				{
					this.setValue("0" + this.input.value);
				}

				return checkTimeRule();
			}

			function checkTimeRule()
			{
				if (self.timeType == self.TIME_TYPE.POINT)
				{
					return true;
				}

				var sHour = parseInt(self.timeStartHour.getValue(), 10);
				var sMin = parseInt(self.timeStartMin.getValue(), 10);
				var eHour = parseInt(self.timeEndHour.getValue(), 10);
				var eMin = parseInt(self.timeEndMin.getValue(), 10);

				var result = (sHour * 60 + sMin) - (eHour * 60 + eMin);
				if (self.acrossDay)
				{
					if (result > 0)
					{
						$("#timePeriodAcrossDay").css("display", "inline-block");
						$("#timePeriodRuleTipsCon").css("display", "none");
					}
					else if (result == 0)
					{
						if (self.timeEndMin.state != Input.STATE.ERROR)
						{
							id("timePeriodRuleTips").innerHTML = self.errorStr.END_TIME_EQUAL_START_TIME;
							$("#timePeriodRuleTipsCon").css("left", $(self.timeEndMin.dom).css("width"));
							$("#timePeriodRuleTipsCon").css("display", "table-cell");
						}
						return false;
					}
					else
					{
						$("#timePeriodAcrossDay").css("display", "none");
						$("#timePeriodRuleTipsCon").css("display", "none");
					}
				}
				else
				{
					$("#timePeriodAcrossDay").css("display", "none");

					if (result > 0)
					{
						if (self.timeEndMin.state != Input.STATE.ERROR)
						{
							id("timePeriodRuleTips").innerHTML = self.errorStr.END_TIME_SHOULD_EARLY_START_TIME;
							$("#timePeriodRuleTipsCon").css("left", $(self.timeEndMin.dom).css("width"));
							$("#timePeriodRuleTipsCon").css("display", "table-cell");
						}
						return false;
					}
					else if (result == 0)
					{
						if (self.timeEndMin.state != Input.STATE.ERROR)
						{
							id("timePeriodRuleTips").innerHTML = self.errorStr.END_TIME_EQUAL_START_TIME;
							$("#timePeriodRuleTipsCon").css("left", $(self.timeEndMin.dom).css("width"));
							$("#timePeriodRuleTipsCon").css("display", "table-cell");
						}
						return false;
					}
					else
					{
						$("#timePeriodRuleTipsCon").css("display", "none");
					}
				}

				return true;
			}

			this.dayMon = new CheckBox({
				targetId: 'mon',
				label: label.one
			});
			this.dayTue = new CheckBox({
				targetId: 'tue',
				label: label.two
			});
			this.dayWed = new CheckBox({
				targetId: 'wed',
				label: label.three
			});
			this.dayThu = new CheckBox({
				targetId: 'thu',
				label: label.four
			});
			this.dayFri = new CheckBox({
				targetId: 'fri',
				label: label.five
			});
			this.daySat = new CheckBox({
				targetId: 'sat',
				label: label.six
			});
			this.daySun = new CheckBox({
				targetId: 'sun',
				label: label.day
			});
		}
	});
	this.timePeriodDialog.timePeriodIndex = null;
	this.timePeriodDialog.timePeriodArrayIndex = null;
	this.timePeriodDialog.timePeriodItemName = null;
	this.timePeriodDialog.mode = null;
	this.timePeriodDialog.timeType = null;
	this.timePeriodDialog.show = function(data){
		var inputArr = [this.timeDesc,
						this.timeStartHour,
						this.timeStartMin,
						this.timeEndHour,
						this.timeEndMin];

		if (data == undefined)
		{
			return;
		}

		for (var i = 0; i < inputArr.length; i++)
		{
			inputArr[i].closeNote();
		}
		$("#timePeriodRuleTipsCon").css("display", "none");

		this.mode = data.mode;
		this.timePeriodIndex = data.index;
		this.timePeriodArrayIndex = data.arrayIndex ? data.arrayIndex : null;
		this.timePeriodItemName = data.itemName ? data.itemName : null;
		this.timeDesc.setValue(data.name || "");
		this.timeStartHour.setValue(data.startHour || "00");
		this.timeStartMin.setValue(data.startMin || "00");
		this.timeEndHour.setValue(data.endHour || "00");
		this.timeEndMin.setValue(data.endMin || "00");
		this.dayMon.setValue(data.mon);
		this.dayTue.setValue(data.tue);
		this.dayWed.setValue(data.wed);
		this.dayThu.setValue(data.thu);
		this.dayFri.setValue(data.fri);
		this.daySat.setValue(data.sat);
		this.daySun.setValue(data.sun);

		if (this.acrossDay)
		{
			if ((parseInt(data.startHour, 10) * 60 + parseInt(data.startMin, 10) >
			parseInt(data.endHour, 10) * 60 + parseInt(data.endMin, 10)))
			{
				$("#timePeriodAcrossDay").css("display", "inline-block");
			}
			else
			{
				$("#timePeriodAcrossDay").css("display", "none");
			}
		}
		else
		{
			$("#timePeriodAcrossDay").css("display", "none");
		}

		Dialog.prototype.show.call(this);
	}
	this.timePeriodDialog.resetCommit = function(func){
		if (typeof func != "function")
		{
			return;
		}

		$(this).off("ev_timePeriodCommit").on("ev_timePeriodCommit", function(event, data){
			func(data);
		});
	}
	this.timePeriodDialog.resetTpType = function(TYPE){
		switch (TYPE)
		{
		case this.tpType.TIME_SWITCH:
			this.timeType = this.TIME_TYPE.PERIOD;
			this.timeEndHour.disable(false);
			this.timeEndHour.dom.style.display = "inline-table";
			this.timeEndMin.disable(false);
			this.timeEndMin.dom.style.display = "inline-table";
			this.timeDesc.setLabel(label.periodDesc);
			this.timeStartHour.setLabel(label.closeTime);
			this.timeEndHour.setLabel(label.openTime);
			this.errorStr.END_TIME_SHOULD_EARLY_START_TIME = errStr.inputOpenTimeShouldEarlyClose;
			this.errorStr.END_TIME_EQUAL_START_TIME = errStr.inputOpenTimeEqualToClose;
			this.acrossDay = true;
			break;
		case this.tpType.GUEST_NET:
			this.timeType = this.TIME_TYPE.PERIOD;
			this.timeEndHour.disable(false);
			this.timeEndHour.dom.style.display = "inline-table";
			this.timeEndMin.disable(false);
			this.timeEndMin.dom.style.display = "inline-table";
			this.timeDesc.setLabel(label.periodDesc);
			this.timeStartHour.setLabel(label.beginTime);
			this.timeEndHour.setLabel(label.endTime);
			this.errorStr.END_TIME_SHOULD_EARLY_START_TIME = errStr.inputEndTimeShouldEarlyStart;
			this.errorStr.END_TIME_EQUAL_START_TIME = errStr.inputEndTimeEqualToStart;
			this.acrossDay = false;
			break;
		case this.tpType.REBOOT_TIMER:
			this.timeType = this.TIME_TYPE.POINT;
			this.timeEndHour.disable(true);
			this.timeEndHour.dom.style.display = "none";
			this.timeEndMin.disable(true);
			this.timeEndMin.dom.style.display = "none";
			this.timeDesc.setLabel(label.pointDesc);
			this.timeStartHour.setLabel(label.rebootTime);
			this.acrossDay = false;
			break;
		case this.tpType.PARENT_CONTROL:
			this.timeType = this.TIME_TYPE.PERIOD;
			this.timeEndHour.disable(false);
			this.timeEndHour.dom.style.display = "inline-table";
			this.timeEndMin.disable(false);
			this.timeEndMin.dom.style.display = "inline-table";
			this.timeDesc.setLabel(label.periodDesc);
			this.timeStartHour.setLabel(label.beginTime);
			this.timeEndHour.setLabel(label.endTime);
			this.errorStr.END_TIME_SHOULD_EARLY_START_TIME = errStr.inputEndTimeShouldEarlyStart;
			this.errorStr.END_TIME_EQUAL_START_TIME = errStr.inputEndTimeEqualToStart;
			this.acrossDay = true;
			break;
		default:
			break;
		}
	}
	this.timePeriodDialog.errorStr = {
		END_TIME_SHOULD_EARLY_START_TIME: errStr.inputEndTimeShouldEarlyStart,
		END_TIME_EQUAL_START_TIME: errStr.inputEndTimeEqualToStart
	}
	this.timePeriodDialog.tpType = {
		TIME_SWITCH: "time_switch",
		GUEST_NET: "guest_net",
		REBOOT_TIMER: "reboot_timer",
		PARENT_CONTROL: "parent_control"
	}
	this.timePeriodDialog.TIME_TYPE = {
		PERIOD: "period",
		POINT: "point"
	}

	this.showNewSoftVerDialog = new Dialog({
		title: label.upgradeOnline,
		content: '<div class="newSoftVerTitle">' +
					'<span>' + label.hasNewSoftVer + '</span>' +
					'<span id="newSoftVer"></span>' +
				 '</div>' +
				 '<div class="newSoftVerContent">' +
					'<span>' + label.newSoftContent + label.colon + '</span><br />' +
					'<span id="newSoftContent"></span>' +
				 '</div>' +
				 '<div id="showNewSoftVerNoShow"></div>',
		size: Dialog.SIZE.SMALL,
		hasCloseIcon: true,
		closeIconHandle: function(){
			var data = {};

			if (true == showNewSoftVerDialog.noReDisplay.getValue())
			{
				data[uciCloudConfig.fileName] = {};
				data[uciCloudConfig.fileName][uciCloudConfig.secName.newFirmware] = {};
				data[uciCloudConfig.fileName][uciCloudConfig.secName.newFirmware][uciCloudConfig.optName.noShow] = uciCloudConfig.optValue.noShow.yes;

				$.modify(data, undefined, undefined, true);
			}
		},
		type: Dialog.TYPE.NORMAL,
		isConstant: true,
		bottom: [
			{
				type:component.Button.TYPE.SECONDARY,
				text:btn.laterSays,
				id:'showNewSoftVerCancel',
				onClick:function(){
					$(showNewSoftVerDialog.container).find(".dlgCloseBtn")[0].click();
				}
			},
			{
				type:component.Button.TYPE.PRIMARY,
				text:btn.upgradeRightNow,
				id:'showNewSoftVerSubmit'
			}],
		renderCallBack: function(){
			this.noReDisplay = new CheckBox({
				targetId: 'showNewSoftVerNoShow',
				label: label.noReDisplay
			});
		}
	});
	this.showNewSoftVerDialog.isCloudUpgradePush = false;
	this.showNewSoftVerDialog.show = function(option){
		var self = this;

		if (option != undefined && $.isPlainObject(option)){
			if (option.isCloudUpgradePush != undefined)
			{
				this.isCloudUpgradePush = option.isCloudUpgradePush;
			}
			else
			{
				this.isCloudUpgradePush = false;
			}

			$("#showNewSoftVerNoShow").css("display", self.isCloudUpgradePush ? "block" : "none");

			if (option.newSoftVer != undefined)
			{
				$("#newSoftVer").html(option.newSoftVer);
			}
			else
			{
				$("#newSoftVer").html("---");
			}

			if (option.newSoftContent != undefined)
			{
				$("#newSoftContent").html(option.newSoftContent);
			}
			else
			{
				$("#newSoftContent").html("---");
			}

			if (option.upgradeClick != undefined)
			{
				this._ops.bottom[1].obj._ops.onClick = option.upgradeClick;
			}
			else
			{
				this._ops.bottom[1].obj._ops.onClick = null;
			}
		}
		else
		{
			$("#newSoftVer").html("---");
			$("#newSoftContent").html("---");
			this._ops.bottom[1].obj._ops.onClick = null;
		}

		Dialog.prototype.show.call(this);
	};

	this.cloudPageDialog = new Dialog({
		hasTitle: false,
		content: '<div class="cloudPageTop"><span id="cloudPageBack"><i class="iconfont icon-back"></i><span class="cloudPageBackText">' + btn.back +'</span></span><i class="dlgCloseBtn iconfont icon-close"></i></div>' +
				 '<div class="cloudPageCon" id="cloudPageCon"></div>',
		size: Dialog.SIZE.LARGE,
		hasCloseIcon: false,
		type: Dialog.TYPE.CUSTOM,
		isConstant: true,
		className: "cloudPage",
		renderCallBack: function(){
			$("div.cloudPageTop i.dlgCloseBtn").on("click", function(){
				cloudPageDialog.hide(function(){
					id("cloudPageCon").innerHTML = "";
				});
			});
		}
	});

	this.cloudIDSuggestDialog = new Dialog({
		title: label.bindMercuryId,
		content: '<span class="cloudIDSuggestTitle">' + label.cloudIDNoteTitle + '</span>' +
		         '<span class="cloudIDSuggestContent">' + label.cloudIDNoteS + '</span>' +
				 '<ul class="cloudIDSuggestContent">' +
					'<li>' + label.cloudIDNoteT + '</li>' +
					'<li>' + label.cloudIDNoteFo + '</li>' +
					'<li>' + label.cloudIDNoteFi + '</li>' +
				 '</ul>' +
				 '<div id="cloudIDSuggestNoShow"></div>',
		hasCloseIcon: true,
		size: Dialog.SIZE.MEDIUM,
		type: Dialog.TYPE.CUSTOM,
		isConstant: true,
		closeIconHandle: function(){
			var data = {};

			if (true == cloudIDSuggestDialog.noReDisplay.getValue())
			{
				data[uciCloudConfig.fileName] = {};
				data[uciCloudConfig.fileName][uciCloudConfig.secName.bindTip] = {};
				data[uciCloudConfig.fileName][uciCloudConfig.secName.bindTip][uciCloudConfig.optName.noShow] = uciCloudConfig.optValue.noShow.yes;

				$.modify(data, undefined, undefined, true);
			}
		},
		bottom: [
			{
				type:component.Button.TYPE.SECONDARY,
				text:btn.ignore,
				id:"cloudIDSuggestCancel",
				onClick:function(){
					$(cloudIDSuggestDialog.container).find(".dlgCloseBtn")[0].click();
				}
			},
			{
				type:component.Button.TYPE.PRIMARY,
				text:btn.goAndBind,
				id:"cloudIDSuggestSubmit",
				onClick:function(){
					cloudIDSuggestDialog.hide(function(){
						cloudHistory.cursor = 0;
						cloudHistory.go(0);
						cloudPageDialog.show();
					});
				}
			}
		],
		renderCallBack: function(){
			this.noReDisplay = new CheckBox({
				targetId: 'cloudIDSuggestNoShow',
				label: label.noReDisplay
			});
		}
	});

	this.mercuryAppDialog = new Dialog({
		title: '<i class="appIcon"></i><span class="appTitle">' + label.appName + '</span>',
		isConstant: true,
		closeIconHandle: function(){
			document.body.style.overflow = "auto";
		},
		size: Dialog.SIZE.SMALL,
		type: Dialog.TYPE.CUSTOM,
		content: '<p class="cloudAppSuggesstionTitle">' + label.scanDownloadAppAndManage +'</p>' +
				 '<i class="cloudAppSuggesstionQRCode"></i>' +
				 '<div class="cloudAppSuggesstionLogoCon">' +
					'<div class="cloudAppSuggesstionLogo"><i class="iconfont icon-android"></i><span>Android</span></div>' +
					'<div class="cloudAppSuggesstionLogo"><i class="iconfont icon-ios"></i><span>IOS</span></div>' +
				 '</div>',
		renderCallBack: function(){
			var self = this;
			attachEvnt(self.container, "click", function(e){
				stopProp(e);
			});
		}
	});
	this.mercuryAppDialog.bodyClickHandle = function(e){
		detachEvnt(document.body, "click", mercuryAppDialog.bodyClickHandle);

		mercuryAppDialog.hide(function(){
			//document.body.style.overflow = "auto";
		});
	}
	this.mercuryAppDialog.show = function(event){
		var self = this;

		attachEvnt(document.body, "click", this.bodyClickHandle);

		//document.body.style.overflow = "hidden";

		Dialog.prototype.show.call(this);
		stopProp(event);
	};

	this.initMeshDialog = function(){
		if (this.meshTopoDialog != undefined) {
			$(this.meshTopoDialog.horizontalScroll.sb).remove();
			$(this.meshTopoDialog.verticalScroll.sb).remove();
			$(this.meshTopoDialog.container).remove();
			this.meshTopoDialog = undefined;
		}

		this.meshTopoDialog = new Dialog({
			title: btn.meshNetworkingTopo,
			size: Dialog.SIZE.LARGE,
			type: Dialog.TYPE.CUSTOM,
			isConstant: true,
			content: '<div class="meshTopoPageCon" id="meshTopoPageCon"><div class="meshTopoCanvasCon"><div id="meshTopoCanvas"></div></div></div>',
			className: "meshTopoPage",
			bottom: [
				{
					type: component.Button.TYPE.PRIMARY,
					text: btn.meshAddRouter,
					id:'meshAddSubmit',
					props:{width:"160px"},
					onClick: function(){
						meshAddDialog.isFromTopo = true;
						meshTopoDialog.hide(function(){
							meshAddDialog.show();
						});
					}
				}
			],
			renderCallBack: function(){
				var horizontalScroll = new NiceScroll({targetId:"meshTopoPageCon", vertical: false, zIndex: 1006});
				horizontalScroll.scrollTipOpacity(1);
				horizontalScroll.init();
				this.horizontalScroll = horizontalScroll;

				var verticalScroll = new NiceScroll({targetId:"meshTopoPageCon", zIndex: 1006});
				verticalScroll.scrollTipOpacity(1);
				verticalScroll.init();
				this.verticalScroll = verticalScroll;
			}
		});

		if (this.meshAddDialog != undefined) {
			$(this.meshAddDialog.container).remove();
			this.meshAddDialog = undefined;
		}

		this.meshAddDialog = new Dialog({
			title: btn.meshAddRouter,
			size: Dialog.SIZE.LARGE,
			type: Dialog.TYPE.CUSTOM,
			isConstant: true,
			content: '<div class="meshAddTitle"></div>' +
					 '<div class="meshAddContent" id="meshAddContent"></div>',
			className: "meshAddPage",
			renderCallBack: function(){
				var self = this;

				loadDialogRenderPage("meshAddProcess.htm", "meshAddContent", function(){
					$("div.meshAddStep").css("display", "none");

					/* Mesh-Add Ready */
					$("#support_num").text(TECHNICAL_SUPPORT_NUMBER);
					new Button({
						type:Button.TYPE.PRIMARY,
						text:btn.pushedMeshBtn,
						id: "meshAddReadySub",
						props:{width:"280px"},
						onClick: function(){
							self.startScan();
						}
					});

					/* Mesh-Add No Result */
					new Button({
						type:Button.TYPE.PRIMARY,
						text:btn.reDiscovery,
						id: "meshAddNoResultRescan",
						props:{width:"280px"},
						onClick: function(){
							self.startScan();
						}
					});

					/* Mesh-Add Listed */
					self.extListTable = new Table({
						targetId:'extListTable',
						head:[
							{field:label.deviceName, width:"0.60"},
							{field:label.mac, width:"0.40"}
						],
						column:[
							{name:uciPlc.optName.name, type: "str"},
							{name:uciPlc.optName.mac, type:"str"}
						],
						itemOption:[
							{
								icon: "icon-add",
								type: "add",
								str: btn.add,
								func: function(indexData, indexTable){
									var data = {}, parentNode;

									self.tagData.isAddExt = true;
									clearTimeout(self.scanResultHandler);

									data[uciPlc.fileName] = {};
									data[uciPlc.fileName][uciPlc.actionName.addExt] = {};
									data[uciPlc.fileName][uciPlc.actionName.addExt][uciPlc.optName.mac] = self.scanedExtList[indexData].mac;

									$.action(data, function(result){
										self.tagData.isAddExt = false;

										parentNode = $(self.extListTable.table.rows[indexTable]).find("div.itemOption")[0].parentNode;
										$(parentNode).empty().append('<i class="meshAddTableLoading spin"></i>');

										self.scanResultHandler =  $.setTimeout(function(){
											self.scanResultCb.call(self);
										}, 2000);
									});
								},
								onRender: function(dataObj){
									var result, str = "";
									switch (dataObj.status)
									{
									case uciPlc.optValue.extStatus.idle:
										result = false;
										break;
									case uciPlc.optValue.extStatus.waitingToAdd:
										result = true;
										str = '<span style="color:#999999">' + label.meshWaitToAdd + '</span>';
										break;
									case uciPlc.optValue.extStatus.adding:
										result = true;
										str = '<div class="meshAddItemStatus"><i class="meshAddTableLoading spinOnce"></i><span style="vertical-aligh:middle">' + label.meshAdding + '</span></div>';
										break;
									case uciPlc.optValue.extStatus.success:
										result = true;
										str = '<span style="color:#24B353">' + label.meshAddSuccess + '</span>';
										break;
									case uciPlc.optValue.extStatus.fail:
										result = true;
										str = '<div class="meshAddItemStatus error"><i class="iconfont icon-error"></i><span>' + label.meshAddFail + '</span></div>';
										break;
									case uciPlc.optValue.extStatus.timeout:
										result = true;
										str = '<div class="meshAddItemStatus error" title=' + label.plzClickRouterMeshBtn + '><i class="iconfont icon-error"></i><span>' + label.meshAddTimeout + '</span></div>';
										break;
									}

									return {result: result, str: str};
								}
							}
						],
						tableOption:[
							{icon: "icon-refresh", str: btn.refresh, type:"refresh", func:function(){
								var isAdding = false;

								for (var i = 0; i < self.scanedExtList.length; i++)
								{
									if (self.scanedExtList[i].status == uciPlc.optValue.extStatus.waitingToAdd ||
										self.scanedExtList[i].status == uciPlc.optValue.extStatus.adding)
									{
										isAdding = true;
										break;
									}
								}

								if (isAdding)
								{
									confirmDialog.show({
										content: label.refreshMeshAddConfirm,
										callback: function(result){
											if (result)
											{
												self.stopScan();
												self.startScan();
											}
										}
									});
								}
								else
								{
									self.stopScan();
									self.startScan();
								}
							}}
						],
						deletable:false,
						editable:false,
						addable:false,
						hasCheckBox: false,
						hasFixedHeight: 8,
						numPerPage: 8
					});

					new Button({
						type:Button.TYPE.SECONDARY,
						text:btn.addAll,
						id: "meshAddAll",
						props:{width:"200px"},
						onClick: function(){
							var macArr = [], data = {}, parentNode;

							self.tagData.isAddExt = true;
							clearTimeout(self.scanResultHandler);

							for (var i = 0; i < self.scanedExtList.length; i++)
							{
								if (self.scanedExtList[i].status == uciPlc.optValue.extStatus.idle)
								{
									macArr.push(self.scanedExtList[i].mac);
								}
							}

							data[uciPlc.fileName] = {};
							data[uciPlc.fileName][uciPlc.actionName.addExt] = {};
							data[uciPlc.fileName][uciPlc.actionName.addExt][uciPlc.optName.mac] = macArr;

							$.action(data, function(){
								self.tagData.isAddExt = false;

								inputArr = $(self.extListTable.table).find("div.itemOption");

								for (i = 0; i < inputArr.length; i++)
								{
									parentNode = inputArr[i].parentNode;
									$(parentNode).empty().append('<i class="meshAddTableLoading spin"></i>');
								}

								self.scanResultHandler =  $.setTimeout(function(){
									self.scanResultCb.call(self);
								}, 2000);
							});
						}
					});

					new Button({
						type:Button.TYPE.PRIMARY,
						text:btn.finish,
						id: "meshAddcomplete",
						props:{width:"200px"},
						onClick: function(){
							self.finishHandle();
						}
					});

					$("#meshAddNotFoundBtn").click(function(){
						self.stopScan(true);
						self.switchPage(self.page.NOT_FOUND);
					});

					/* Mesh-Add NotFound */
					new Button({
						type:Button.TYPE.PRIMARY,
						text:btn.reDiscovery,
						id: "meshAddNotFoundRescan",
						props:{width:"280px"},
						onClick: function(){
							self.startScan();
						}
					});

					/* Mesh-Add Reset */
					new Button({
						type:Button.TYPE.SECONDARY,
						text:btn.back,
						id: "meshAddResetBack",
						props:{width:"200px"},
						onClick: function(){
							self.switchPage(self.tagData.lastPage);
						}
					});

					new Button({
						type:Button.TYPE.PRIMARY,
						text:btn.alreadyResetRouter,
						id: "meshAddResetComplete",
						props:{width:"200px"},
						onClick: function(){
							self.switchPage(self.page.READY);
						}
					});

					/* Mesh-Add Common use*/
					$("span.meshAddReset").click(function(){
						self.switchPage(self.page.RESET);
					});

					/* RESET THE CLOSE-ICON CLICK EVENT */
					$(self.container).find(".dlgCloseBtn").off("click").on("click", function(){
						if (self.tagData.currentPage == self.page.LOADING)
						{
							confirmDialog.show({
								content: label.closeMeshAddConfirm,
								callback: function(result){
									if (result)
									{
										self.stopScan(true);
										self.hide();
									}
								}
							});
						}
						else if (self.tagData.currentPage == self.page.LISTED)
						{
							self.finishHandle();
						}
						else
						{
							self.hide();
						}
					});
				});
			}
		});
		this.meshAddDialog.isFromTopo = false;
		this.meshAddDialog.scanedExtList = [];
		this.meshAddDialog.scanStatusHandler = null;
		this.meshAddDialog.scanResultHandler = null;
		this.meshAddDialog.tagData = {
			notSuccessExtNum: 0,
			currentPage: null,
			lastPage: null,
			isAddExt: false
		};
		this.meshAddDialog.isAddingExt = false;
		this.meshAddDialog.show = function(){
			var titleCon = $(this.container).find("div.dialogTitle span"), self = this;
			if (this.isFromTopo)
			{
				titleCon.css("cursor", "pointer").html('<i class="meshDialogTitle iconfont icon-back"></i><span class="meshDialogTitle">' + btn.meshNetworkingTopo + '</span>');
				titleCon.off("click").on("click", function(){
					function readyToDo(){
						self.hide(function(){
							meshTopoDialog.show();
						});
					};

					if (self.tagData.currentPage == self.page.LOADING)
					{
						confirmDialog.show({
							content: label.closeMeshAddConfirm,
							callback: function(result){
								if (result)
								{
									self.stopScan(true);
									readyToDo();
								}
							}
						});
					}
					else if (self.tagData.currentPage == self.page.LISTED)
					{
						self.finishHandle();
					}
					else
					{
						readyToDo();
					}
				});
			}
			else
			{
				titleCon.css("cursor", "default").html(btn.meshAddRouter);
				titleCon.off("click");
			}

			this.switchPage(this.page.READY);
			Dialog.prototype.show.call(this);
		}
		this.meshAddDialog.switchPage = function(page, callback){
			var self = this;
			if (this.tagData.currentPage != null)
			{
				this.tagData.lastPage = this.tagData.currentPage;
				$("#" + this.tagData.currentPage).fadeOut(250, function(){
					self.tagData.currentPage = page;
					transTitle();
					$("#" + page).fadeIn(150, function(){
						typeof callback == "function" && callback();
					});
				});
			}
			else
			{
				this.tagData.currentPage = page;
				transTitle();
				$("#" + page).css("display", "block");
			}

			function transTitle(){
				var str = "";
				switch(page)
				{
				case self.page.READY:
					str = label.prepareRouter;
					break;
				case self.page.LOADING:
				case self.page.NO_RESULT:
				case self.page.LISTED:
					str = label.addRouter;
					break;
				case self.page.NOT_FOUND:
					str = label.noFoundRouter;
					break;
				case self.page.RESET:
					str = label.resetRouterConfig;
					break;
				}

				$("div.meshAddTitle").text(str);
			}
		};
		this.meshAddDialog.startScan = function(){
			var self = this, req = {};

			self.switchPage(self.page.LOADING);

			self.scanedExtList = [];

			req[uciPlc.fileName] = {};
			req[uciPlc.fileName][uciPlc.actionName.scanExt] = null;
			$.action(req, function(result){
				if (ENONE == result[ERR_CODE])
				{
					/* POLLING THE SCAN_STATUS */
					self.scanStatusHandler = $.setTimeout(function(){
						self.scanStatusCb.call(self);
					}, 2000);

					/* POLLING THE SCAN_RESULT_LIST */
					self.scanResultHandler =  $.setTimeout(function(){
						self.scanResultCb.call(self);
					}, 2000);
				}
				else
				{
					//此处需要double check
					self.scanOverHandle();
				}
			}, undefined, true);
		};
		this.meshAddDialog.stopScan = function(needSendReq){
			var self = this, data = {};

			clearTimeout(self.scanStatusHandler);
			clearTimeout(self.scanResultHandler);
			self.scanedExtList = [];

			if (needSendReq != undefined && needSendReq == true)
			{
				data[uciPlc.fileName] = {};
				data[uciPlc.fileName][uciPlc.actionName.stopScanExt] = null;
				$.action(data);
			}
		};
		this.meshAddDialog.scanStatusCb = function(){
			var self = this, arg = {};
			arg[uciPlc.fileName] = {};
			arg[uciPlc.fileName][KEY_NAME] = uciPlc.secName.scanExtStatus;
			$.query(arg, function(result){
				if (ENONE == result[ERR_CODE])
				{
					var status = result[uciPlc.fileName][uciPlc.secName.scanExtStatus][uciPlc.optName.status];

					if (status == uciPlc.optValue.status.doing)
					{
						self.scanStatusHandler = $.setTimeout(function(){
							self.scanStatusCb.call(self);
						}, 2000);
					}
					else if (status == uciPlc.optValue.status.idle)
					{
						self.scanOverHandle();
					}
					else
					{
						self.scanOverHandle();
					}
				}
				else
				{
					self.scanOverHandle();
				}
			});
		};
		this.meshAddDialog.scanResultCb = function(){
			var self = this;
			var arg = {};
			arg[uciPlc.fileName] = {};
			arg[uciPlc.fileName][KEY_TABLE] = uciPlc.secType.scannedExt;
			$.query(arg, function(result){
				if (self.isAddingExt)
				{
					return;
				}

				self.scanedExtList = formatTableData(result[uciPlc.fileName][uciPlc.secType.scannedExt]);
				$("#routerFoundCount").text(self.scanedExtList.length);

				if (self.scanedExtList.length > 0)
				{
					self.tagData.notSuccessExtNum = 0;

					for (var i = 0; i < self.scanedExtList.length; i++) {
						if (self.scanedExtList[i].status != uciPlc.optValue.extStatus.idle &&
						    self.scanedExtList[i].status != uciPlc.optValue.extStatus.success)
						{
							self.tagData.notSuccessExtNum += 1;
						}
					}

					self.scanedExtList.sort(function(x, y){
						if (x.mac > y.mac) {
							return 1;
						} else {
							return -1;
						}
					});

					self.extListTable.setDataSource(self.scanedExtList);
					self.extListTable.loadData();

					if (self.tagData.currentPage != self.page.LISTED)
					{
						self.switchPage(self.page.LISTED);
					}
				}

				self.scanResultHandler =  $.setTimeout(function(){
					self.scanResultCb.call(self);
				}, 2000);
			});
		};
		this.meshAddDialog.finishHandle = function(){
			var self= this, isAdding = false, notAddedNum = 0;

			for (var i = 0; i < self.scanedExtList.length; i++)
			{
				if (self.scanedExtList[i].status == uciPlc.optValue.extStatus.waitingToAdd ||
					self.scanedExtList[i].status == uciPlc.optValue.extStatus.adding)
				{
					isAdding = true;
					break;
				}

				if (self.scanedExtList[i].status == uciPlc.optValue.extStatus.idle)
				{
					notAddedNum++;
				}
			}

			if (isAdding)
			{
				confirmDialog.show({
					content: label.finishMeshAddConfirmOne,
					callback: function(result){
						if (result)
						{
							self.stopScan(true);
							self.hide(function(){
								meshTopoDialog.show();
							});
						}
					}
				});
			}
			else if (notAddedNum > 0)
			{
				confirmDialog.show({
					content: label.finishMeshAddConfirmTwo + notAddedNum + label.finishMeshAddConfirmThree,
					callback: function(result){
						if (result)
						{
							self.stopScan(true);
							self.hide(function(){
								meshTopoDialog.show();
							});
						}
					}
				});
			}
			else
			{
				self.stopScan(true);
				self.hide(function(){
					meshTopoDialog.show();
				});
			}
		}
		this.meshAddDialog.scanOverHandle = function(){
			var self = this, alretStr = "";

			self.stopScan();

			/* IF NOT GET EXT_LIST YET */
			if (self.tagData.currentPage == self.page.LOADING)
			{
				self.switchPage(self.page.NO_RESULT);
			}
			else
			{
				alretStr = label.addingTimeoutOne;

				if (self.tagData.notSuccessExtNum == 0)
				{
					alretStr += label.addingTimeoutTwo + label.addingTimeoutFive;
				}
				else
				{
					alretStr += label.addingTimeoutThree + self.tagData.notSuccessExtNum +
								label.addingTimeoutFour + label.addingTimeoutFive;
				}

				if (confirmDialog.status == "showed")
				{
					confirmDialog.hide(function(){
						showCb();
					});
				}
				else
				{
					showCb();
				}
			}

			function showCb(){
				alarmDialog.show({
					title: label.meshAddTimeout,
					content: alretStr,
					callback: function(){
						if (self.isFromTopo)
						{
							self.hide(function(){
								meshTopoDialog.show();
							});
						}
						else
						{
							self.hide();
						}
					}
				});
			}
		}
		this.meshAddDialog.page = {
			READY: "meshAddReady",
			LOADING: "meshAddLoading",
			NO_RESULT: "meshAddNoResult",
			LISTED: "meshAddListed",
			NOT_FOUND: "meshAddNotFound",
			RESET: "meshAddReset"
		};
	}
};

componentObj.call(window);