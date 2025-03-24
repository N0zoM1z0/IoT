var component = (function($, global){
	var rnumber = /\d/,
		rnumberOnly = /^\d+$/,
		rletter = /[a-zA-Z]/,
		rletterOnly = /^[a-zA-Z]+$/,
		rsymbol = /[\x21-\x2f\x3a-\x40\x5b-\x60\x7b-\x7e\s]/,
		/*
		*	x21 - x2f : !"#$%&'()*+,-./
		*   x3a - x40 : :;<=>?@
		*   x5b - x60 : [\]^_`
		*   x7b - x7e : {|}~
		*/
		rsymbolOnly = /^[\x21-\x2f\x3a-\x40\x5b-\x60\x7b-\x7e\s]+$/;

	/* ================================= Input Component  ================================== */
	function Input(options)
	{
		this.value = '';	// value of this input component
		this.input = null;	// dom object of input element
		this.label = null;	// dom object of label element
		this.tips = null;	// dom object of tips element
		this.dom = null;	// dom object of the whole component
		this.showEye = false;	// show eye icon
		this.qualified = true;	// is qualified to be saved
		this.disabled = false;
		this.state = Input.STATE.NORMAL;
		this.isMouseOver = false;

		this._ops = {
			type:Input.TYPE.PLAIN_TEXT,
			containerType:Input.CONTAINER.NORMAL,
			strength:{
				show:false
				/* critical: number(significant number to judge strength), */
				/* least: number(the least length to show strength) */
			},
			complexity: 0,
			label:{
				value:'',
				position:''
			},
			props:{},
			check:{/* blur:checkBlur, keyup:checkKeyup */},
			targetId:'',/* container id */
			tips:{/* value:str, onClick:onclick, className:str */},
			hint:{/* value:str, onClick:onclick, className:str */},
			isAllowBlank: true,
			isAllowBlankStr: errStr.inputNotAllowBlank,
			isAllowAllSpace: true,
			isAllowAllSpaceStr: errStr.inputNotAllowAllSpace,
			className: null,
			innerElement: {
				id: null,
				className: null
			},
			size:Input.SIZE.MEDIUM
		};

		for (var k in options)
		{
			var item = options[k];
			if (typeof this._ops[k] == 'undefined')
			{
				continue;
			}

			if (isObject(item))
			{
				for (var prop in item)
				{
					this._ops[k][prop] = item[prop];
				}
			}
			else
			{
				this._ops[k] = item;
			}
		}

		this._ops.props.autocomplete = 'off';
		this.showEye =
			(this._ops.type == Input.TYPE.CIPHER_TEXT) ||
			(this._ops.props.type == 'password');

		this._render();
		this._eventHandle();
	}
	Input.prototype._eyeClick = function(context){
		/*************************************************
		var $input = $(this).siblings('input');
		$input[0].focus();

		if ($input.attr('type') == 'password')
		{
			$input.attr('type', 'text');
			$(this)
				.removeClass('icon-ciphertext')
				.addClass('icon-plaintext');
		}
		else
		{
			$input.attr('type', 'password');
			$(this)
				.removeClass('icon-plaintext')
				.addClass('icon-ciphertext');
		}
		****************************************************/

		/** IE8 forbid to change the type of a input tag, so here is a hack **/
		var $inputLi = $(this).parent(),
			$input = $(this).siblings('input');
		var type = $input.attr('type');
		var value = $input.val();
		var htmlStr = $inputLi.html();

		if (type == 'password')
		{
			htmlStr = htmlStr.replace(/type=["]?password["]?/,/* ie8 hack */ 'type="text"').replace('icon-ciphertext', 'icon-plaintext');
		}
		else
		{
			htmlStr = htmlStr.replace(/type=["]?text["]?/,/* ie8 hack */ 'type="password"').replace('icon-plaintext', 'icon-ciphertext');
		}

		/* replace the original innerHTML */
		$inputLi.html(htmlStr);

		/* restore input */
		context.input = $inputLi.children("input").val(value)[0];
		setDomCursorPos(context.input, context.input.value.length);

		context._eventHandle();
	};
	Input.prototype._render = function(){
		this.input = $('<input />', this._ops.props)[0];
		this.dom = $(
			'<ul>'                          +
				'<li class="inputLi"></li>' +
				'<li class="note">'         +
					'<div class="noteCon">' +
						'<p></p>'           +
					'</div>'                +
				'</li>'                     +
				'<li class="strength">'     +
					'<div>'                 +
						'<span></span>'     +
					'</div>'                +
				'</li>'                     +
				'<li class="tableNote">'    +
					'<div class="noteCon">' +
						'<p></p>'           +
					'</div>'                +
				'</li>'                     +
			'</ul>'
		)[0];

		$(this.dom).attr('class', 'inputCMPT ' + this._ops.size + (this._ops.innerElement.id != null ? " innerElement" : "") + (this._ops.className ? " " + this._ops.className : ""));
		var $inputLi = $(this.dom).find('li.inputLi');

		/* Add label */
		if ('' != this._ops.label.value)
		{
			if (Input.LABEL.INNER == this._ops.label.position)
			{
				this.label = $('<label>' + this._ops.label.value + '</label>')[0];
				$inputLi.append(this.label);
				$(this.dom).addClass(Input.LABEL.INNER);
			}
			else
			{
				this.label = $('<label class="' + Input.LABEL.OUTER + '">' + this._ops.label.value + '</label>')[0];
				$(this.label).insertBefore($inputLi);
			}
		}

		$('#' + this._ops.targetId).append(this.dom);
		$inputLi.append(this.input);

		this.value = this.input.value;

		/* attach eye icon */
		if (this.showEye)
		{
			$('<i></i>', {
				'class':'eye iconfont'
			}).appendTo($inputLi).addClass((function(type){
					return type == 'password' ? 'icon-ciphertext' : 'icon-plaintext';
			})(this._ops.props.type));
		}
		else if (null != this._ops.tips.value)
		{
			this.tips = $('<span></span>',{
				'class':this._ops.tips.className || ''
			}).html(this._ops.tips.value).appendTo($inputLi)[0];

			if (null != this._ops.tips.onClick)
			{
				this.tips.onclick = this._ops.tips.onClick;
			}
		}

		if (null != this._ops.hint.value)
		{
			this.hint = $('<span></span>', {
				'class':(this._ops.hint.className || '') + ' hint'
			}).html(this._ops.hint.value).appendTo($inputLi)[0];

			if (null != this._ops.hint.onClick)
			{
				this.hint.onclick = this._ops.hint.onClick;
			}
		}

		if (null != this._ops.innerElement)
		{
			this.innerElm = $('<div></div>', {
				'class':(this._ops.innerElement.className || '') + ' innerElement',
				'id':this._ops.innerElement.id
			}).appendTo(this.dom)[0];
		}

		if (Input.TYPE.STATIC_TEXT == this._ops.type)
		{
			this.toggleStatic(true);
		}
	};
	Input.prototype.showNote = function(noteStr){
		var noteCon, conP, domWidth;

		if (this._ops.containerType == Input.CONTAINER.NORMAL)
		{
			noteCon = $(this.dom).find('li.note')[0];
			conP = $(this.dom).find('li.note p')[0];

			domWidth = $(this.dom).outerWidth(true);

			if (null != this._ops.innerElement)
			{
				domWidth = parseInt(domWidth) - $(this.innerElm).outerWidth(true);
			}

			$(this.dom).find('li.note').css('left', domWidth);
		}
		else
		{
			noteCon = $(this.dom).find('li.tableNote')[0];
			conP = $(this.dom).find('li.tableNote p')[0];
			$(this.dom).find('li.tableNote').css('top', parseInt($(this.dom).css('height')) + 3);
			$(this.dom).find('li.tableNote div.noteCon').css('width', $(this.dom).css('width'));
			$(this.dom).find('li.tableNote div.noteCon p').css('line-height', $(this.dom).css('height'));
		}

		if (undefined == noteCon)
		{
			return;
		}

		if (undefined != noteStr)
		{
			conP.innerHTML = noteStr;
		}

		noteCon.style.display = 'table-cell';
		$(this.dom)
			.find('li.inputLi')
			.removeClass('focus')
			.addClass('warn');

		if (this.hint)
		{
			$(this.hint).css("display", "none");
		}

		this.state = Input.STATE.ERROR;
	};
	Input.prototype.closeNote = function(){
		var noteCon;

		if (this._ops.containerType == Input.CONTAINER.NORMAL)
		{
			noteCon = $(this.dom).find('li.note')[0];
		}
		else
		{
			noteCon = $(this.dom).find('li.tableNote')[0];
		}

		$(noteCon).css('display', 'none');
		$(this.dom).find('li.inputLi').removeClass('warn');

		if (this.hint)
		{
			$(this.hint).css("display", "block");
		}

		this.state = Input.STATE.NORMAL;
	};
	Input.prototype._checkMixChars = function(){
		return (
			rnumber.test(this.input.value) &&
			rletter.test(this.input.value) &&
			rsymbol.test(this.input.value)
		);
	};
	Input.prototype._showStrength = function(){
		var $strength = $(this.dom).find('li.strength'),
			$div = $strength.find('div'),
			$span = $strength.find('span'),
			len = this.input.value.length,
			least = this._ops.strength.least || 0,
			critical = this._ops.strength.critical || 6,
			domWidth;

		domWidth = $(this.dom).outerWidth(true);

		if (null != this._ops.innerElement)
		{
			domWidth = parseInt(domWidth) - $(this.innerElm).outerWidth(true);
		}

		$strength.css('left', domWidth);

		if (len >= least)
		{
			$strength.css('display', 'table-cell');
		}
		else
		{
			$strength.css('display', 'none');
		}

		if (rnumberOnly.test(this.input.value) ||
			rsymbolOnly.test(this.input.value) ||
			rletterOnly.test(this.input.value))
		{
			if (this.input.value.length <= critical)
			{
				$div.attr('class', 'weak');
				$span.html(label.passwordWeak);
			}
			else
			{
				$div.attr('class', 'medium');
				$span.html(label.passwordMedium);
			}
		}
		else if (true == this._checkMixChars())
		{
			$div.attr('class', 'strong');
			$span.html(label.passwordStrong);
		}
		else
		{
			if (this.input.value.length <= critical)
			{
				$div.attr('class', 'medium');
				$span.html(label.passwordMedium);
			}
			else
			{
				$div.attr('class', 'strong');
				$span.html(label.passwordStrong);
			}
		}
	};
	Input.prototype._hideStrength = function(){
		$(this.dom).find('li.strength').css('display', 'none');
	};
	Input.prototype._eventHandle = function(){
		var self = this;
		var $inputLi = $(this.dom).find('li.inputLi');

		function onBlur(){
			if ($(this).parent().hasClass("static"))
			{
				return;
			}

			$(this).parent().removeClass('focus');
			self._hideStrength();

			var checkObj = self._ops.check;

			if (self.getValue() == "" && self._ops.isAllowBlank === false)
			{
				self.qualified = false;
				self.showNote(self._ops.isAllowBlankStr);
				return;
			}
			else if (String(self.getValue()).replace(/^\s+|\s+$/g, "") == "" && self._ops.isAllowAllSpace === false)
			{
				self.qualified = false;
				self.showNote(self._ops.isAllowAllSpaceStr);
				return;
			}
			else
			{
				self.qualified = true;
			}

			if (self.qualified && typeof checkObj.blur == 'function')
			{
				self.qualified = checkObj.blur.call(self);
			}

			if (self.qualified && typeof checkObj.keyup == 'function')
			{
				self.qualified = checkObj.keyup.call(self);
			}
		}

		if (OS.portable == true) {
			self.isMouseOver = false;
			$(this.input).bind('blur', onBlur);
		} else {
			$inputLi.on('mouseover', function(e){
				self.isMouseOver = true;
				$(self.input).unbind('blur', onBlur);
				$(self.input).addClass('mouseover');
			}).on('mouseout', function(){
				self.isMouseOver = false;
				$(self.input).bind('blur', onBlur);
				$(self.input).removeClass('mouseover');
			});
		}

		$(this.input).on('focus', function(e){
			$(this).parent().not('.warn').addClass('focus');
		});

		$(this.input).on('keyup', function(e){
			self.value = this.value;
			self.closeNote();
			self.qualified = true;

			var checkObj = self._ops.check;
			if (typeof checkObj.keyup == 'function')
			{
				self.qualified = checkObj.keyup.call(self, e);
			}

			if (self.qualified && self._ops.strength.show)
			{
				self._showStrength();
			}
			else
			{
				self._hideStrength();
			}

			if (self.qualified && self.value.length >= SYS_LOGIN_PWD_LENGTH_MIN && self._ops.complexity > 0)
			{
				var complexity = getPwdComplexity(self.value);
				if (complexity < self._ops.complexity)
				{
					self.showNote(errStr.pwdCharTypeNotEnough);
				}
			}

			$(this).parent().not('.warn').addClass('focus');
		});

		/* 给小眼睛绑定点击事件 */
		$(this.dom).find("i.eye").on("click", function(){
			self._eyeClick.call(this, self);
		});
	};
	Input.prototype.checkAll = function(){
		var checkObj = this._ops.check;
		this.qualified = true;

		if (this.input.value == "" && this._ops.isAllowBlank === false)
		{
			this.qualified = false;
			this.showNote(errStr.inputNotAllowBlank);
			return this.qualified;
		}
		else if (String(this.input.value).replace(/^\s+|\s+$/g, "") == "" && this._ops.isAllowAllSpace === false)
		{
			this.qualified = false;
			this.showNote(errStr.inputNotAllowAllSpace);
			return this.qualified;
		}

		if (typeof checkObj.keyup == 'function')
		{
			this.qualified = checkObj.keyup.call(this);
		}

		if (this.qualified && typeof checkObj.blur == 'function')
		{
			this.qualified = checkObj.blur.call(this);
		}

		if (this.qualified && this.input.value.length >= SYS_LOGIN_PWD_LENGTH_MIN && this._ops.complexity > 0)
		{
			var complexity = getPwdComplexity(this.input.value);
			if (complexity < this._ops.complexity)
			{
				this.qualified = false;
				this.showNote(errStr.pwdCharTypeNotEnough);
				return this.qualified;
			}
		}

		return this.qualified;
	};
	Input.prototype.disable = function(disabled){
		var self = this;

		self.disabled = disabled;
		if (disabled)
		{
			$(this.input)
				.attr('disabled', 'disabled')
				.css('cursor', 'default')
				.siblings('i.eye')
				.off('click');
			$(this.dom).find('li.inputLi').addClass('disabled');
			this.closeNote();
		}
		else
		{
			$(this.input)
				.removeAttr('disabled')
				.css('cursor', 'text')
				.siblings('i.eye')
				.off('click')
				.on('click', function(){
					self._eyeClick.call(this, self);
				});
			$(this.dom).find('li.inputLi').removeClass('disabled');
		}
	};
	Input.prototype.getValue = function(){
		this.value = this.input.value;
		return this.value;
	};
	Input.prototype.setValue = function(val, props){
		this.input.value = val;
		this.value = val;

		if (props != undefined)
		{
			for (var key in props)
			{
				$(this.input).css(key, props[key]);
			}
		}
	};
	Input.prototype.setLabel = function(label){
		this.label.innerHTML = label;
	};
	Input.prototype.setTips = function(options){
		if (null != options.value)
		{
			this.tips.innerHTML = options.value;
		}

		if (null != options.className)
		{
			this.tips.className = options.className;
		}

		if (null != options.onClick)
		{
			this.tips.onclick = options.onClick;
		}
	};
	Input.prototype.toggleStatic = function(bool){
		var $inputLi = $(this.dom).find('li.inputLi');
		if (bool)
		{
			$inputLi.addClass('static');
			if (!($(this.dom.parentNode).hasClass("deviceName") ||
				$(this.dom.parentNode).hasClass("deviceSpeedNum")))
			{
				$(this.input).attr('readonly', 'readonly');
			}
			$(this.input).css('cursor', 'default');
			$(this.tips).css('display', 'none');
			this.closeNote();
		}
		else
		{
			$inputLi.removeClass('static');
			if (!($(this.dom.parentNode).hasClass("deviceName") ||
				$(this.dom.parentNode).hasClass("deviceSpeedNum")))
			{
				$(this.input).removeAttr('readonly');
			}
			$(this.input).css('cursor', 'text');
			$(this.tips).css('display', 'table-cell');
		}
	};
	Input.TYPE = {
		PLAIN_TEXT:'plaintext',		// 普通文本
		CIPHER_TEXT:'ciphertext',	// 默认显示普通文本，点击小眼睛后隐藏
		STATIC_TEXT:'statictext'	// 静态文本，不能编辑
	};
	Input.LABEL = {
		INNER:'innerLbl',
		OUTER:'outerLbl'
	};
	Input.SIZE = {
		SMALL:'small',
		MEDIUM:'medium'
	}
	Input.CONTAINER = {
		NORMAL:'normal',
		TABLE:'table'
	}
	Input.STATE = {
		NORMAL:'normal',
		ERROR:'error'
	}
	/* ================================= Input  Component  ================================== */

	/* ================================= Button Component  ================================== */
	function Button(options){
		this.isLoading = false;
		this.loadIcon = null;
		this.btnText = null;
		this.disabled = false;
		this.btn = null
		this._ops = {
			type:Button.TYPE.PRIMARY,
			text:'按钮1',
			id:'',
			onClick:null,
			ev_trigger: null,		/* Event Name */
			props:{}
		};

		this._init(options);
	}
	Button.prototype._init = function(options){
		for (var k in options)
		{
			var item = options[k];
			if (typeof this._ops[k] == 'undefined')
			{
				continue;
			}

			this._ops[k] = item;
		}

		this._render();
	};
	Button.prototype._render = function(){
		var self = this;
		this.btn = id(this._ops.id);

		/* reset button state */
		emptyNodes(this.btn);

		this.btn.className = 'buttonCMPT ' + this._ops.type;
		this.btn.onclick = function(){
			if (self._ops.ev_trigger && typeof self._ops.ev_trigger == "string")
			{
				$(self).trigger(self._ops.ev_trigger);
			}

			if (!(self.isLoading) && typeof self._ops.onClick == 'function' && !self.disabled)
			{
				self._ops.onClick.call(self);
			}
		};

		this.btnText = document.createElement('span');
		this.btnText.innerHTML = this._ops.text;
		this.btn.appendChild(this.btnText);

		this.loadIcon = document.createElement('i');
		this.loadIcon.className = 'loading iconfont icon-loading';
		this.btn.appendChild(this.loadIcon);

		$(this.btn).css(this._ops.props);
	};
	Button.prototype.showLoading = function(){
		this.isLoading = true;
		this.loadIcon.style.display = 'inline-block';
		this.btnText.style.display = 'none';
		this.btn.style.cursor = "default";
		this.btn.style.pointerEvents = "none";
	};
	Button.prototype.closeLoading = function(){
		this.isLoading = false;
		this.loadIcon.style.display = 'none';
		this.btnText.style.display = 'inline';
		this.btn.style.cursor = "pointer";
		this.btn.style.pointerEvents = "auto";
	};
	Button.prototype.setState = function(state){
		if (this.isLoading)
		{
			return;
		}

		this._init(state);
	};
	Button.prototype.disable = function(disable){
		this.disabled = disable;
		if (disable)
		{
			$(this.btn).addClass('disabled');
		}
		else
		{
			$(this.btn).removeClass('disabled');
		}
	};
	Button.TYPE = {
		FUNCTIONAL:'functional',
		PRIMARY:'primary',
		SECONDARY:'secondary'
	};
	/* ================================= Button Component  ================================== */

	/* ================================= CheckBox Component  ================================== */
	function CheckBox(options)
	{
		this.checkbox = null;
		this.disabled = false;

		this._ops = {
			targetId:'', /* container id */
			label:'', /* can be a html string */
			checked:false,
			onClick:null,
			className: null
		};

		for (var k in options)
		{
			var item = options[k];
			if (typeof this._ops[k] == 'undefined')
			{
				continue;
			}

			this._ops[k] = item;
		}

		this._render();
	}
	CheckBox.prototype._render = function(){
		var label,
			con = id(this._ops.targetId),
			self = this;

		$(con).addClass(this._ops.className);
		this.checkbox = document.createElement('input');
		this.checkbox.id = this._ops.targetId + new Date().getTime();
		this.checkbox.type = 'checkbox';
		this.checkbox.checked = this._ops.checked;
		con.appendChild(this.checkbox);

		label = document.createElement('label');
		label.className = 'checkbox iconfont icon-tickinside'
			+ (this.checkbox.checked ? ' checked' : '');
		label.htmlFor = this.checkbox.id;
		label.innerHTML = '<span>' + this._ops.label + '</span>';
		label.onclick = function(event){
			if (self.disabled)
			{
				return;
			}

			if (self.checkbox.checked)
			{
				$(this).removeClass('checked');
			}
			else
			{
				$(this).addClass('checked');
			}

			/* wait untill click event propagated to real checkbox */
			global.setTimeout(function(){
				self._ops.onClick&&self._ops.onClick.call(self.checkbox);
			}, 0);
		};
		con.appendChild(label);
	};
	CheckBox.prototype.setValue = function(value, force, triggerEvent){
		if (typeof value != "boolean")
		{
			return;
		}

		if (!this.disabled || force)
		{
			if (value)
			{
				this.checkbox.checked = true;
				$(this.checkbox).parent().find("label").addClass('checked');
			}
			else
			{
				this.checkbox.checked = false;
				$(this.checkbox).parent().find("label").removeClass('checked');
			}
		}else
		{
			return;
		}

		if (triggerEvent != undefined && triggerEvent == true)
		{
			this._ops.onClick&&this._ops.onClick.call(this.checkbox);
		}
	}
	CheckBox.prototype.getValue = function(){
		if (this.checkbox != undefined)
		{
			return this.checkbox.checked;
		}
	}
	CheckBox.prototype.disable = function(value){
		if (value == undefined || typeof value != "boolean")
		{
			return;
		}
		else
		{
			if (value)
			{
				this.checkbox.checked = true;
				$(this.checkbox).parent().find("label").addClass('checked');
			}
			else
			{
				this.checkbox.checked = false;
				$(this.checkbox).parent().find("label").removeClass('checked');
			}
		}

		$(this.checkbox).parent().find("label").addClass('disabled');
		this.disabled = true;
	}
	CheckBox.prototype.enable = function(value){
		if (value != undefined || typeof value != "boolean")
		{
			return;
		}
		else
		{
			if (value)
			{
				this.checkbox.checked = true;
				$(this.checkbox).parent().find("label").addClass('checked');
			}
			else
			{
				this.checkbox.checked = false;
				$(this.checkbox).parent().find("label").removeClass('checked');
			}
		}

		$(this.checkbox).parent().find("label").removeClass('disabled');
		this.disabled = false;
	}
	/* ================================= Checkbox Component  ================================== */

	/* ================================= Radio Component  ================================== */
	function Radio(options){
		this.radio = null;
		this.checked = null;
		this.disabled = false;

		this._ops = {
			targetId: '',
			label: '',
			checked:false,
			name: '',
			value: '',
			onClick:null
		}

		for (var k in options)
		{
			var item = options[k];
			if (typeof this._ops[k] == 'undefined')
			{
				continue;
			}

			this._ops[k] = item;
		}

		this._render();
	}
	Radio.prototype._render = function(){
		var self = this,
			con = id(this._ops.targetId),
			label = this._ops.label,
			name = this._ops.name,
			value = this._ops.value,
			labelObj;

		if (con ==undefined)
		{
			return;
		}

		if (name == undefined && typeof name != "string" && name.length == 0)
		{
			name = "radio_" + new Date().getTime();
			this._ops.name = name;
		}

		this.checked = this._ops.checked;
		this.radio = document.createElement("i");
		this.radio.className = "radio" + (this._ops.checked == true ? " checked" : "");
		$(this.radio).attr("name", name);
		con.appendChild(this.radio);

		if (typeof label == "string" && label.length > 0)
		{
			labelObj = document.createElement("label");
			labelObj.className = "radioLabel";
			labelObj.innerHTML = label;
			con.appendChild(labelObj);
		}

		$(con).find("i.radio, label.radioLabel").on("click", function(){
			if (!$(this.parentNode).find("i.radio").hasClass("disabled"))
			{
				$("i.radio[name=" + name +"]").not($(this.parentNode).find("i.radio")).trigger("ev_cancel");
				$(this.parentNode).find("i.radio").trigger("ev_select");

				if (self._ops.onClick != null && typeof self._ops.onClick == "function")
				{
					self._ops.onClick.call(self, value);
				}
			}
		});

		$(this.radio).on("ev_cancel", function(){
			self.checked = false;
			$(this).removeClass("checked");
		}).on("ev_select", function(){
			self.checked = true;
			$(this).addClass("checked");
		});
	}
	Radio.prototype.setValue = function(value, force, isTriggerClick){
		var name = this._ops.name;
		if (this.disable == true && force != true)
		{
			return;
		}

		this.checked = value;
		value == true ? $(this.radio).addClass("checked") : $(this.radio).removeClass("checked");

		if (value)
		{
			$("i.radio[name=" + name +"]").not($(this.radio)).trigger("ev_cancel");
			$(this.radio).trigger("ev_select");

			if (isTriggerClick != undefined && isTriggerClick == true)
			{
				$(this.radio).trigger("click");
			}
		}
		else
		{
			$(this.radio).trigger("ev_cancel");/* 一般只允许设为true */
		}
	}
	Radio.prototype.getValue = function(){
		return this.checked;
	}
	Radio.prototype.disable = function(disabled){
		this.disabled == disabled;

		if (disabled)
		{
			$(this.radio).addClass("disabled");
		}
		else
		{
			$(this.radio).removeClass("disabled");
		}
	}
	/* ================================= Radio Component  ================================== */

	/* ================================= Toast Component  ================================== */
	function Toast(options){

	}
	/* ================================= Toast Component  ================================== */

	/* ================================= Tab Component  ================================== */
	function Tab(options){
		this.dom = null;
		this._ops = {
			list:[],
			targetId:'',
			defaultTab: null
		};

		for (var k in options)
		{
			var item = options[k];
			if (typeof this._ops[k] == 'undefined')
			{
				continue;
			}

			this._ops[k] = item;
		}

		this._render();
	}
	Tab.prototype._render = function(){
		var con = id(this._ops.targetId);
		var li, span, item;
		var self = this;

		this.dom = document.createElement('ul');
		this.dom.className = 'tabCPMT';

		li = document.createElement('li');
		li.className = 'underline';
		this.dom.appendChild(li);

		for (var i = 0; i < this._ops.list.length; i++)
		{
			item = this._ops.list[i];

			$("#" + item.contentId).css("display", "none");

			li = document.createElement('li');
			li.onclick = (function(o){
				return function(){
					var lastObj = self._ops.list[self.getCurrentIndex()];
					var liSelf = this;

					if (!$(this).hasClass('active'))
					{
						$(this).addClass('active').siblings().removeClass('active');
						$(this).siblings('li.underline').css({
							left: this.offsetLeft + 'px',
							left: this.offsetLeft + 'px',
							width: this.offsetWidth + 'px'
						});

						if (lastObj.contentId != undefined)
						{
							$("#" + lastObj.contentId).fadeOut(50, function(){
								$("#" + o.contentId).fadeIn();

								if (typeof o.onClick == "function")
								{
									o.onClick.call(liSelf, self);
								}
							});
						}
						else
						{
							if (typeof o.onClick == "function")
							{
								o.onClick.call(liSelf, self);
							}
						}
					}
				}
			})(item);
			this.dom.appendChild(li);

			span = document.createElement('span');
			span.innerHTML = item.name;
			li.appendChild(span);
		}

		con.appendChild(this.dom);

		$(this.dom).children(':last-child').css('margin-right', '0');

		if (this._ops.defaultTab == null)
		{
			this._ops.defaultTab = 0;
		}

		$(this.dom).children(':not(.underline)').eq(this._ops.defaultTab).click();
	};
	Tab.prototype.setTabNameByIndex = function(options){
		$(this.dom).find('li span').eq(options.index).html(options.name);
	};
	Tab.prototype.getCurrentIndex = function(){
		var index = 0;
		$(this.dom).children(':not(.underline)').each(function(i, li){
			if ($(li).hasClass('active'))
			{
				index = i;
			}
		});

		return index;
	};
	/* ================================= Tab Component  ================================== */

	/* ================================= Dialog Component  ================================== */
	function Dialog(options){
		this._ops = {
			hasTitle: true,
			title: "Dialog",		 				//string/object
			contentID : null,
			content: "This is example of Dialog",	//string/object
			size: Dialog.SIZE.SMALL, 				//SMALL/MEDIUM/LARGE
			hasCloseIcon: true,		 				//true/false
			closeIconHandle: null,
			bottom: null,							//
			renderCallBack: null,
			zIndexValue: 1000,
			isOffsetNeed: null,						/* {top: 0px, left: 0px} */
			isConstant: false,
			type: Dialog.TYPE.NORMAL,
			className: null
		}

		this.showing = false;
		this.status = "idle";

		for (var k in options)
		{
			var item = options[k];
			this._ops[k] = item;
		}

		this._render();
	}
	Dialog.prototype._render = function(){
		var self = this;
		self.container = null;
		var str = '';
		var container = id("Dialog"), box;

		if (self._ops['size'] != Dialog.SIZE.SMALL &&
		    self._ops['size'] != Dialog.SIZE.MEDIUM &&
			self._ops['size'] != Dialog.SIZE.LARGE)
		{
			self._ops['size'] = Dialog.SIZE.SMALL;
		}

		if (self._ops.type != Dialog.TYPE.NORMAL &&
		    self._ops.type != Dialog.TYPE.ALARM &&
			self._ops.type != Dialog.TYPE.LOADING &&
			self._ops.type != Dialog.TYPE.CUSTOM)
		{
			self._ops.type = Dialog.TYPE.NORMAL;
		}

		box = document.createElement("div");
		box.className = "dialogBox " + self._ops['size'] + (self._ops.isConstant == true ? " constant" : "") + (self._ops.className != null ? " " + self._ops.className : "");
		box.innerHTML = "";

		/* render title */
		if (self._ops.hasTitle == true && typeof self._ops.title == "string")
		{
			str +=
				'<div class="dialogTitle">'									+
					'<span>' + self._ops.title + '</span>';

			if (self._ops.hasCloseIcon)
			{
				str +=
					'<i class="dlgCloseBtn iconfont icon-close"></i>'	+
				'</div>';
			}
			else
			{
				str +=
				'</div>';
			}
		}

		/* render content */
		if (self._ops.type == Dialog.TYPE.NORMAL)
		{
			str +=
				'<div class="dialogContent ' + Dialog.TYPE.NORMAL + '">'	+
					'<span>' + self._ops.content + '</span>'				+
				'</div>';
		}
		else if (self._ops.type == Dialog.TYPE.LOADING)
		{
			str +=
				'<div class="dialogContent ' + Dialog.TYPE.LOADING + '">'	+
					'<i class="iconfont icon-loading"></i>';

			if (typeof self._ops.content == "string")
			{
				str +=
					'<span class="primary">' + self._ops.content + '</span>'				+
				'</div>';
			}
			else if (!$.isEmptyObject(self._ops.content))
			{
				if (typeof self._ops.content.primary == "string")
				{
					str +=
						'<span class="primary">' + self._ops.content.primary + '</span>';
				}

				if (typeof self._ops.content.secondary == "string")
				{
					str +=
						'<span class="secondary">' + self._ops.content.secondary + '</span>';
				}

				str +=
					'</div>';
			}
		}
		else if (self._ops.type == Dialog.TYPE.ALARM)
		{
			str +=
				'<div class="dialogContent ' + Dialog.TYPE.ALARM + '">'	+
					'<i></i>'											+
					'<div class="content">'								+
						'<span>' +  self._ops.content + '</span>'		+
					'</div>'											+
				'</div>';
		}
		else if (self._ops.type == Dialog.TYPE.CUSTOM)
		{
			str +=
				'<div class="dialogContent ' + Dialog.TYPE.CUSTOM + '">'	+
					self._ops.content										+
				'</div>';
		}

		/* render bottom */
		if (self._ops.bottom != null)
		{
			if (!$.isArray(self._ops.bottom))
			{
				self._ops.bottom = [self._ops.bottom];
			}

			str +=
				'<div class="dialogBottom">';

			for (var i = 0; i < self._ops.bottom.length; i++)
			{
				str +=
					'<div id="' + self._ops.bottom[i].id + '"></div>';
			}

			str +=
				'</div>';
		}

		box.innerHTML = str;
		self.container = box;
		container.appendChild(self.container);

		if (self._ops.type == Dialog.TYPE.ALARM)
		{
			var dialogContentWidth = parseInt($(self.container).find("div.dialogContent").actual('width'));
			var dialogContentPadding = parseInt($(self.container).find("div.dialogContent").css('padding'));
			var alarmLogoWidth = parseInt($(self.container).find("div.dialogContent.alarm i").css('width'));

			$(self.container).find("div.content").css("width", dialogContentWidth - dialogContentPadding - alarmLogoWidth);
		}

		/* Init Button */
		if (self._ops.bottom != null)
		{
			for (i = 0;i < self._ops.bottom.length; i++)
			{
				self._ops.bottom[i].obj = new Button(self._ops.bottom[i]);
			}
		}

		/* Bind Event */
		if (self._ops.hasTitle == true && self._ops.hasCloseIcon)
		{
			$(self.container).find(".dlgCloseBtn").on("click", function(event){
				if ($(this).hasClass("disabled"))
				{
					return;
				}

				self.hide(function(){
					if (self._ops.closeIconHandle)
					{
						typeof self._ops.closeIconHandle == "function" && self._ops.closeIconHandle();
					}
				});
			});
		}

		/* IF HAS ANY SPECIFIC INIT-RENDER FUNCTION, CALL IT */
		if (typeof self._ops.renderCallBack == "function")
		{
			self._ops.renderCallBack.call(self);
		}

		/* TODO: 此处之后必须要改 */
		$("body").resize(function(){
			/*
			var offsetWidth = this.offsetWidth;
			var offsetHeight = this.offsetHeight;

			var conOffsetWidth = id("Con").offsetWidth;
			var conOffsetHeight = id("Con").offsetHeight;

			var loginOffsetWidth = id("Login").offsetWidth;
			var loginOffsetHeight = id("Login").offsetHeight;

			offsetWidth = Math.max(offsetWidth, conOffsetWidth, loginOffsetWidth);
			offsetHeight = Math.max(offsetHeight, conOffsetHeight, loginOffsetHeight);*/
			//offsetWidth = offsetWidth > conOffsetWidth ? offsetWidth : conOffsetWidth;
			//offsetHeight = offsetHeight > conOffsetHeight ? offsetHeight : conOffsetHeight;

			var actualSize = getActualSize();
			$(box).trigger("ev_screen_resize", [actualSize.windowWidth, actualSize.windowHeight]);
		});

		$(box).on("ev_screen_resize", function(event, offsetWidth, offsetHeight){
			var boxWidth = $(box).actual('width');
			var boxHeight = $(box).actual('height');
			var absoluteWidth = parseInt(offsetWidth / 2) - parseInt(boxWidth / 2);
			var absoluteHeight = parseInt(offsetHeight / 2) - parseInt(boxHeight / 2);

			absoluteWidth = absoluteWidth > 0 ? absoluteWidth : 0;
			absoluteHeight = absoluteHeight > 0 ? absoluteHeight : 0;

			if(self.isOffsetNeed != null)
			{
				absoluteWidth += self.isOffsetNeed.left;
				absoluteHeight += self.isOffsetNeed.top;
			}

			$(box).css("top", absoluteHeight);
			$(box).css("left", absoluteWidth);
		});
	}
	Dialog.prototype.resetPosition = function(){

	}
	Dialog.prototype._resetContent = function(content){
		var dialogBox = this.container;
		if (this._ops.type == Dialog.TYPE.NORMAL || this._ops.type == Dialog.TYPE.ALARM)
		{
			$(dialogBox).find("div.dialogContent span").html(content);
		}
		else if (this._ops.type == Dialog.TYPE.LOADING)
		{
			if (typeof content == "string")
			{
				$(dialogBox).find("div.dialogContent span.primary").html(content);
			}
			else if (!$.isEmptyObject(content))
			{
				$(dialogBox).find("div.dialogContent span.primary").html(content.primary);
				$(dialogBox).find("div.dialogContent span.secondary").html(content.secondary);
			}
		}

		/* 暂时不考虑CUSTOM类型 */
	}
	Dialog.prototype.show = function(resetObj){
		/* showing */
		if (this.status == "showing")
		{
			return;
		}

		var container = id("Dialog"),
			dialogBox = this.container,
			dialogArr = this.state.dialogArr,
			self = this;
		var dialogObj, maskDiv, zIndexValue;

		if (resetObj && !$.isEmptyObject(resetObj))
		{
			if (resetObj.content)
			{
				this._resetContent(resetObj.content);
			}
		}

		/* Fix Problem Temporary, When Trigger the dialog show Fast, the opacity will set to 0 */
		if ($(dialogBox).css("opacity") == "0")
		{
			$(dialogBox).css("opacity", "");
		}

		this.status = "showing";
		if (this.state.count == 0)
		{
			$(dialogBox).css("z-index", this._ops.zIndexValue);
			dialogArr.push({size:this._ops.size, zIndexValue:this._ops.zIndexValue, obj:self});
		}
		else
		{
			dialogObj = dialogArr[dialogArr.length - 1];
			zIndexValue = dialogObj.zIndexValue + 1;

			maskDiv = document.createElement('div');
			maskDiv.className = "multiDialogMask";

			var actualSize = getActualSize();
			$(maskDiv).css("z-index", zIndexValue).css("width", actualSize.documentWidth).css("height", actualSize.documentHeight);
			container.insertBefore(maskDiv, dialogBox);

			zIndexValue += 1;
			dialogArr.push({size:this._ops.size, zIndexValue:zIndexValue, mask:maskDiv, obj:self});

			$(dialogBox).css("z-index", zIndexValue);

			if (dialogObj.size == this._ops.size)
			{
				this.isOffsetNeed = {top:24, left:24};
			}
		}
		this.state.count++;

		if (this.state.count == 1)
		{
			/* update offset */
			$("body").trigger("resize");	/* TODO:看以后有没有更好的办法 */

			$(dialogBox).css("display", "block");

			this.showing = true;
			showMask(function(){
				$(container).fadeIn(150, function(){self.showing = false;self.status = "showed";});
			});
		}
		else
		{
			$("body").trigger("resize");
			$(maskDiv).css("display", "block");
			this.showing = true;
			$(dialogBox).fadeIn(150, function(){self.showing = false;self.status = "showed";});
		}
	}
	Dialog.prototype.hide = function(func){
		if (this.status == "hiding")
		{
			$.setTimeout(function(){
				if (typeof func == "function")
				{
					func();
				}
			}, 450);
			return;
		}

		var container = id("Dialog");
		var dialogBox = this.container, dialogObj;
		var self = this;

		if (this.state.count == 1)
		{
			if ($(dialogBox).css("display") != "none")
			{
				self.status = "hiding";
				$.setTimeout(function(){
					$(container).fadeOut(250, function(){
						$(dialogBox).css("display", "none");
						hideMask(function(){
							self.status = "idle";
							if (typeof func == "function")
							{
								func();
							}
						});
					});
				}, self.showing == true ? 450 : 0);		/* 450 = 250(showMask's time) + 150(Dialog's show time) + 50(flexible) */
			}
			else
			{
				if (typeof func == "function")
				{
					func();
				}
				return;
			}
		}
		else
		{
			if ($(dialogBox).css("display") != "none")
			{
				self.status = "hiding";
				$.setTimeout(function(){
					$(dialogBox).fadeOut(250, function(){
						self.status = "idle";
						if (typeof func == "function")
						{
							func();
						}
					});
				}, self.showing == true ? 450 : 0);
			}
			else
			{
				if (typeof func == "function")
				{
					func();
				}
				return;
			}
		}

		dialogObj = this.state.dialogArr.pop();
		if (dialogObj.mask)
		{
			container.removeChild(dialogObj.mask);
		}

		this.state.count--;
		this.isOffsetNeed = null;
	}
	Dialog.prototype.state = {
		count: 0,
		dialogArr : [] 	/* {size:SMALL/MEDIUM/LARGE, zIndexValue: 1001} */
	};
	Dialog.prototype.resetBtnEvent = function(eventList){	/* [{id: "XX", func: function()}, ...] */
		var self = this,
			btnList = this._ops.bottom,
			i, j, btnObj, func, id;

		if (!$.isArray(eventList))
		{
			eventList = [eventList];
		}

		for (i = 0; i < eventList.length; i++)
		{
			id = eventList[i].id;
			func = eventList[i].func;

			for (j = 0; j < btnList.length; j++)
			{
				if (id != btnList[j].id)
				{
					continue;
				}

				btnObj = btnList[j].obj;
				//$(btnObj).off(ev_trigger).on(ev_trigger, function(){});
				btnObj._ops.onClick = func;
			}
		}
	}
	Dialog.SIZE = {
		SMALL: "small",
		MEDIUM: "medium",
		LARGE: "large"
	};
	Dialog.TYPE = {
		NORMAL: "normal",
		ALARM:	"alarm",
		LOADING:"loading",
		CUSTOM: "custom"
	};
	/* ================================= Dialog Component  ================================== */

	/* ================================= Table Component  ================================== */
	function Table(options){
		this.table = null;
		this.titleBtnContainer = null;
		this.loadingObj = null;
		this.isShowLoadingWorking = false;
		this.blankObj = null;
		this.fixedHeightObj = null;
		this.editTrObj = null;
		this.data = [];
		this.selAllCheckBoxObj = null;

		this._constant = {
			optionTdWidth: "130px",
			checkboxTdWidth: "40px",
			headPadding: "8px",
			normalTrHeight: "40px",
			deviceTrHeight: "80px"
		};

		this._ops = {
			targetId: '',
			title: null,	// string
			hasHead: true,
			head: null, 	//		[{field:"XXX", width:"X%"}, ...], allow blank
			column: null,	//		[{name:"XXX", type:"XXX", (option: XX, func: XX, )}, ...],
			operation: null,
			hasCheckBox: true, //	true|false
			editable: true,
			deletable: true,
			addable: true,
			delBtnIndex: "1",
			addBtnIndex: "2",
			deleteOption: {
				icon: "icon-delete",
				str: btn.deleteSel
			},
			addOption: {
				icon: "icon-add",
				str: btn.add
			},
			itemOptionTitle: label.operate,
			itemOptionTitleWidth: this._constant.optionTdWidth,
			itemOption: null,	//	{icon : icon-X, type : X , str: strName, func: function()}
			tableOption: null,	//	{icon : icon-X, type : X , str: strName, func: function(), selRelate: boolean}
			tableOptionShow: true,
			clickList:{			//	{func : function (), asyn : true/false}
				"click_add_item": null,
				"click_del_item": {
					icon: "icon-delete",
					str: btn.clear,
					asyn: null,
					func: null
				},
				"click_save": null,
				"click_cancel": null,
				"click_check": null
			},
			allCheckCallback: null,
			eventList:[
				"ev_default",
				"ev_edit",
				"ev_sel_none",
				"ev_none_item",
				"ev_has_item",
				"ev_max_item"
			],
			numPerPage : 10,
			currentPage: 1,
			max: 32,
			hasFixedHeight: null,
			clearAllTips: "",
			fillBlankRow: false,
			blankOptions:{
				firstRenderShow: false,
				str: label.nonItemTips,
				height: 1
			},
			loadingOptions:{
				str: label.loadingTips,
				icon: "icon-loading",
				height: 1
			},
			pageNumClickFunc: null,
			pageTurnCallback: null,
			type: Table.TYPE.NORMAL
		}

		this._state = Table.STATE.DEFAULT;

		for (var k in options)
		{
			var item = options[k];

			if (isObject(item))
			{
				for (var prop in item)
				{
					this._ops[k][prop] = item[prop];
				}
			}
			else
			{
				this._ops[k] = item;
			}
		}

		this._render();
	}
	Table.prototype._render = function(){
		var self = this,
			con = id(self._ops.targetId),
			hasHead = self._ops.hasHead,
			head = self._ops.head,
			container, btnContainer, tableOptionItem, div, span, tr, td, totalWidth, str, func;

		if (con === undefined)
		{
			return;
		}

		if ((self._ops.title != null && typeof self._ops.title == "string")
		   || (self._ops.tableOption != null && $.isArray(self._ops.tableOption) && self._ops.tableOption.length != 0)
		   || self._ops.deletable
		   || self._ops.addable)
		{
			container = document.createElement('div');
			container.id = self._ops.targetId + "TitleContainer";
			container.className = "tableTitleContainer";
			con.appendChild(container);

			if (self._ops.title != null && typeof self._ops.title == "string")
			{
				span = document.createElement('span');
				span.className = "tableTitleText";
				span.innerHTML = self._ops.title;
				container.appendChild(span);
			}

			btnContainer = document.createElement('div');
			btnContainer.className = "tableTitleBtnContainer";
			container.appendChild(btnContainer);

			if (self._ops.tableOptionShow)
			{
				if (self._ops.deletable)
				{
					div = document.createElement('div');
					div.className = "tableOption delete disabled selRelate";
					str = '<i class="iconfont ' + self._ops.deleteOption.icon + '"></i>' +
						  '<span>' + self._ops.deleteOption.str + '</span>';
					div.innerHTML = str;
					div.name = "tableOptionIndex-" + self._ops.delBtnIndex;
					div.onclick = function(){
						var rowArrObj = self._getSelectItem();
						self._delDataHandle(rowArrObj.selArrStr, rowArrObj.selArr);
					}
					btnContainer.appendChild(div);
				}

				if (self._ops.tableOption != null && $.isArray(self._ops.tableOption) && self._ops.tableOption.length != 0)
				{
					for (var i = 0; i < self._ops.tableOption.length; i++)
					{
						tableOptionItem = self._ops.tableOption[i];
						div = document.createElement('div');
						func = tableOptionItem.func;
						div.className = "tableOption " + tableOptionItem.type;

						if (tableOptionItem.selRelate && tableOptionItem.selRelate != false)
						{
							div.className += " selRelate";
						}

						str = '<i class="iconfont ' +tableOptionItem.icon + '"></i>' +
							  '<span>' + tableOptionItem.str + '</span>';
						div.innerHTML = str;
						if (tableOptionItem.index)
						{
							div.name = "tableOptionIndex-" + tableOptionItem.index;
						}
						else
						{
							div.name = "tableOptionIndex-" + (3 + i);
						}

						div.onclick = (function(func){
							return function(){
								if ($(this).hasClass('disabled'))
								{
									return;
								}

								var selObj = self._getSelectItem();

								if (tableOptionItem.selRelate && tableOptionItem.selRelate != false)
								{
									typeof func == "function" && func(selObj.selArrStr, selObj.selArr);
								}
								else
								{
									typeof func == "function" && func();
								}
							}
						})(func);

						btnContainer.appendChild(div);
					}
				}

				if (self._ops.addable)
				{
					div = document.createElement('div');
					div.className = "tableOption add";
					str = '<i class="iconfont ' + self._ops.addOption.icon + '"></i>' +
						  '<span>' + self._ops.addOption.str + '</span>';
					div.innerHTML = str;
					div.name = "tableOptionIndex-" + self._ops.addBtnIndex;
					div.onclick = function(){
						var table = self.table, length, tr;
						var data = {}, rowIndex = 0;

						if ($(this).hasClass('disabled'))
						{
							return;
						}

						if (self._setState(Table.STATE.ADD) != true)
						{
							return;
						}

						if (self.data.length == self._ops.max)
						{
							self._setState(Table.STATE.DEFAULT, true);
							self._updateEvent(Table.STATE.DEFAULT);
							return;
						}

						/* TODO: 此处以后要支持是否除去空行 */

						if (self._ops.hasHead == true)
						{
							rowIndex = 1;
						}

						tr = table.insertRow(rowIndex);
						tr.className = "TableItemTd";

						length = self._getTableDataRows();
						self._formatBlankData(data);
						self.closeBlankTips(null, true);
						self._fillEditRow("add", tr, data, rowIndex);

						function addHandle(result)
						{
							if (false == result)
							{
								return;
							}
	
							if (self._ops.hasCheckBox == true)
							{
								tr.cells[0].innerHTML = "";
							}
	
							self._updateEvent(Table.STATE.EDIT);
							self._pagingListInit(length, 1);
						}

						if (self._ops.clickList.click_add_item != null)
						{
							var func = self._ops.clickList.click_add_item.func;
							var asyn = self._ops.clickList.click_add_item.asyn;
	
							if (true == asyn)
							{
								func(addHandle);
							}
							else
							{
								addHandle(func());
							}
						}
						else
						{
							addHandle(true);
						}
					}
					btnContainer.appendChild(div);
				}

				/* SORT BY INDEX */
				var btnArr = $(btnContainer).find("div.tableOption");

				btnArr.sort(function(pre, next){
					var preIndex = parseInt(pre.name.substr(17));
					var nextIndex = parseInt(next.name.substr(17));

					if (preIndex > nextIndex)
					{
						return 1;
					}
					else if (preIndex < nextIndex)
					{
						return -1;
					}
					else
					{
						return 0;
					}
				});

				$(btnContainer).empty().append(btnArr);
				$(btnContainer).find(".tableOption").last().addClass("tableOptionLast");
				this.titleBtnContainer = btnContainer;
			}
		}

		container = $('<div></div>').attr("class", self._ops.targetId + "TableContainer")[0];

		con.appendChild(container);

		self.table = document.createElement('table');
		self.table.id = self._ops.targetId + new Date().getTime();
		self.table.className = "Table " + self._ops.type;
		if (self._ops.hasFixedHeight != null)
		{
			$("div." + self._ops.targetId + "TableContainer").css("height", parseInt(self._constant.normalTrHeight) * (parseInt(self._ops.hasFixedHeight) + (self._ops.hasHead ? 1 : 0)))
						 .css("border-bottom", "1px solid #E7E7E7");
		}
		container.appendChild(self.table);

		this.fixedHeightObj = $('<div></div>').attr("class", "tableFixedHeightCon");
		container.appendChild(this.fixedHeightObj[0]);

		/* Loading Object */
		this.loadingObj = $('<div></div>').attr("class", "tableLoadingCon");
		if (self._ops.hasFixedHeight != null)
		{
			this.loadingObj.css("height", parseInt(self._constant.normalTrHeight) * parseInt(self._ops.hasFixedHeight));
		}
		else
		{
			this.loadingObj.css("height", parseInt(self._constant.normalTrHeight) * parseInt(self._ops.loadingOptions.height))
						   .css("border-bottom", "1px solid #E7E7E7");
		}

		this.loadingObj.append($("<div class='loadingContent'><i class='iconfont loading " + self._ops.loadingOptions.icon + "'></i><span>" + self._ops.loadingOptions.str +"</span></div>"));
		container.appendChild(this.loadingObj[0]);

		this.loadingObj.find("div.loadingContent").css("margin-top", (parseInt(this.loadingObj.css("height")) / 2) - (parseInt(this.loadingObj.find("div.loadingContent").actual("height")) / 2));

		/* Blank Object */
		this.blankObj = $('<div></div>').attr("class", "tableBlankCon");
		if (self._ops.hasFixedHeight != null)
		{
			this.blankObj.css("height", parseInt(self._constant.normalTrHeight) * parseInt(self._ops.hasFixedHeight));
		}
		else
		{
			this.blankObj.css("height", parseInt(self._constant.normalTrHeight) * parseInt(self._ops.blankOptions.height))
						 .css("border-bottom", "1px solid #E7E7E7");
		}

		this.blankObj.append($("<span>" + self._ops.blankOptions.str +"</span>"));
		container.appendChild(this.blankObj[0]);

		this.blankObj.find("span").css("margin-top", (parseInt(this.blankObj.css("height")) / 2) - (parseInt(this.blankObj.find("span").actual("height") / 2)));

		/* HEAD */
		if (hasHead && head != null && $.isArray(head))
		{
			tr = self.table.insertRow(-1);
			tr.className = "TableHead " + self._ops.type;
			totalWidth = parseInt($(self.table).actual('width'));		//此处使用actual方法获取隐藏元素宽度

			if (self._ops.hasCheckBox)
			{
				totalWidth -= parseInt(self._constant.checkboxTdWidth);
			}

			if (self._ops.editable || self._ops.deletable || self._ops.itemOption)
			{
				totalWidth -= parseInt(self._ops.itemOptionTitleWidth);
			}

			if (self._ops.hasCheckBox)
			{
				td = tr.insertCell(-1);
				td.className = "TableHeadTd " + self._ops.type;
				td.id = self.table.id + "CheckboxHead";
				setStyle(td, {textAlign:"left"});

				cellWidth = parseInt(self._constant.checkboxTdWidth) - parseInt(self._constant.headPadding) * 2;
				setStyle(td, {width: cellWidth + "px"});

				self.selAllCheckBoxObj = new CheckBox({
					targetId:td.id,
					onClick:function(){
						var childNodes = self.table.rows;
						var childNum = childNodes.length;
						var isChecked = this.checked, isSel = false, start = 1;

						var isAddData = (self._getState() == Table.STATE.ADD) ? 1 : 0;
						start += isAddData;

						for (var index = start; index < childNum; index++)
						{
							if (childNodes[index].style.display != "none")
							{
								self.data[self.data.length - index + isAddData]["CHECK_BOX"].setValue(isChecked);
							}

							if (self.data[self.data.length - index + isAddData]["CHECK_BOX"].getValue() == true)
							{
								isSel = true;
							}
						}

						if (isChecked || isSel)
						{
							$(self).trigger("ev_sel_item");
						}
						else
						{
							$(self).trigger("ev_sel_none");
						}

						self._ops.allCheckCallback && self._ops.allCheckCallback(isChecked || isSel);
					}
				});
			}

			for (var prop = 0; prop < head.length; prop++)
			{
				var temp = head[prop];

				td = tr.insertCell(-1);
				td.className = "TableHeadTd " + self._ops.type;
				setStyle(td, {textAlign:"left"});

				if (typeof temp["width"] != "undefined")
				{
					cellWidth = parseInt(temp.width*totalWidth) - parseInt(self._constant.headPadding) * 2;
					setStyle(td, {width: cellWidth + "px"});
				}
				td.innerHTML = temp.field;

				if (temp["props"] != undefined)
				{
					$.each(temp["props"], function(k, v){
						$(td).css(k, v);
					})
				}
			}

			if (self._ops.editable || self._ops.deletable || self._ops.itemOption != null)
			{
				td = tr.insertCell(-1);
				td.className = "TableHeadTd " + self._ops.type;
				cellWidth = parseInt(self._ops.itemOptionTitleWidth) - parseInt(self._constant.headPadding) * 2;
				setStyle(td, {textAlign:"left", width:cellWidth + "px"});

				td.innerHTML = self._ops.itemOptionTitle;
			}
		}

		/* Event */
		$(self).on("ev_edit", function(){
			$(self.table).find("div.itemOption.edit").addClass("disabled");
		}).on("ev_default", function(){
			$(self.table).find("div.itemOption.edit").removeClass("disabled");
		}).on("ev_sel_none", function(){
			$(self.titleBtnContainer).find("div.tableOption.selRelate").addClass("disabled");
		}).on("ev_sel_item", function(){
			$(self.titleBtnContainer).find("div.tableOption.selRelate").removeClass("disabled");
		}).on("ev_max_item", function(){
			$(self.titleBtnContainer).find("div.tableOption.add").addClass("disabled");
		}).on("ev_has_item", function(){
			$(self.titleBtnContainer).find("div.tableOption.add").removeClass("disabled");
		}).on("ev_none_item", function(){
			$(self.titleBtnContainer).find("div.tableOption.add").removeClass("disabled");
			if (self._ops.blankOptions.firstRenderShow == true && self.isShowLoadingWorking != true)
			{
				self.showBlankTips();
			}

			self._ops.blankOptions.firstRenderShow = true;
		});

		self._updateEvent(Table.STATE.DEFAULT);
	}
	Table.prototype.setDataSource = function(data){
		if ($.isArray(data))
		{
			this.data = data;
		}
	}
	Table.prototype.loadData = function(pageNum, options){
		var table = this.table,
			index = this._ops.hasHead == true ? 1 : 0,
			data = this.data,
			len = data.length,
			column = this._ops.column,
			self = this,
			dataObj;

		if (pageNum == undefined)
		{
			pageNum = 1;
		}

		/* 重置表格状态 */
		self._setState(Table.STATE.DEFAULT, true);

		/* 清空表格 */
		for(var i = 0, tableLen = table.rows.length; i < tableLen; i++)
		{
			if (table.rows[index] != null)
			{
				table.deleteRow(index);
			}
		}

		if (this._ops.hasHead == false && this._ops.head == null)
		{
			return;
		}

		/* 先填充所有数据 */
		if (data == null || ($.isArray(data) && len == 0))
		{
			if (this.isShowLoadingWorking != true)		/* TODO : 此处需要评估需不需要 */
			{
				self.showBlankTips();
			}
		}
		else
		{
			self.closeBlankTips(null, true);
			for (var i = len - 1; i >= 0; i--)
			{
				dataObj = data[i];
				tr = table.insertRow(-1);
				tr.className = "TableItemTd";
				this._insertRowData(tr, i, dataObj);
			}
		}

		this._pagingListInit(len, pageNum);
		this._updateEvent(Table.STATE.DEFAULT);
	}
	Table.prototype.loadTargetPage = function(data, dataLen, pageNum){
		if (dataLen == undefined)
		{
			dataLen = 0;
		}

		if (pageNum == undefined)
		{
			pageNum = 1;
		}

		if (data instanceof Array && dataLen >= data.length)
		{
			var dataSource = new Array(dataLen);
			var num = this._ops.numPerPage;
			var shift = dataLen - (pageNum　- 1) * num - data.length;

			/* FILL NECESSARY DATA */
			for (var i = 0; i < dataLen; i++)
			{
				if (i >= shift && i - shift < data.length)
				{
					dataSource[i] = data[i - shift];
				}
				else
				{
					dataSource[i] = {};
					this._formatBlankData(dataSource[i]);
				}
			}

			this.setDataSource(dataSource);
		}

		this.loadData(pageNum);
	}
	Table.prototype.showLoading = function(Func){
		var self = this;
		if (this.loadingObj.css("display") == "block")
		{
			return;
		}

		this.isShowLoadingWorking = true;

		if (this.data.length != 0)
		{
			this.setDataSource([]);
			this.loadData(undefined, {isBlankShow: false});
			if (this.fixedHeightObj.css("display") == "block")
			{
				this.fixedHeightObj.css("display", "none");
			}

			this.loadingObj.fadeIn(150, function(){
				this.isShowLoadingWorking = false;
				typeof Func == "function" && Func();
			});
		}else
		{
			if (this.fixedHeightObj.css("display") == "block")
			{
				this.fixedHeightObj.css("display", "none");
			}

			if (this.blankObj.css("display") == "block")
			{
				this.closeBlankTips(function(){
					self.loadingObj.fadeIn(200, function(){
						self.isShowLoadingWorking = false;
						typeof Func == "function" && Func();
					});
				});
			}
			else
			{
				self.loadingObj.fadeIn(200, function(){
					self.isShowLoadingWorking = false;
					typeof Func == "function" && Func();
				});
			}
		}
	}
	Table.prototype.closeLoading = function(Func){
		this.loadingObj.fadeOut(200, function(){
			typeof Func == "function" && Func();
		});
	}
	Table.prototype.showBlankTips = function(Func){
		if (this.blankObj.css("display") == "block")
		{
			return;
		}
		this.blankObj.fadeIn(150, function(){
			typeof Func == "function" && Func();
		});
	}
	Table.prototype.closeBlankTips = function(Func, isImmediately){
		if (isImmediately != undefined && isImmediately == true)
		{
			this.blankObj.css("display", "none");
			typeof Func == "function" && Func();
		}
		else
		{
			this.blankObj.fadeOut(150, function(){
				typeof Func == "function" && Func();
			});
		}
	}
	Table.prototype.getCurrentPage = function(){
		return this._ops.currentPage;
	}
	Table.prototype.getNumPerPage = function(){
		return this._ops.numPerPage;
	}
	Table.prototype._insertRowData = function(tr, i, dataObj){
		var head = this._ops.head,
		    list = this._ops.column,
			self = this,
			td, type;

		/* TODO: 此处要加勾选框的相关操作 */
		if (self._ops.hasCheckBox)
		{
			td = tr.insertCell(-1);
			td.className = this._ops.type;
			td.id = self.table.id + "Checkbox_" + i;
			setStyle(td, {textAlign:"left"});

			/* TODO: 此次要加上当不存在表头时cell的宽度计算、以及自定义样式的支持(可选)
			cellWidth = parseInt(self._constant.checkboxTdWidth) - parseInt(self._constant.headPadding) * 2;
			setStyle(td, {width: cellWidth + "px"});
			*/

			checkBox = new CheckBox({
				targetId:td.id,
				onClick:function(){
					/* TODO: 此处以后应该要提炼成一个函数出来 */
					var rows, selAll, childNum, isAddData;
					var isSelAll = true, isSel = false;

					if (self._ops.hasHead == false)
					{
						return;
					}

					rows = self.table.rows;
					selAll = self.selAllCheckBoxObj;
					childNum = rows.length;
					isAddData = (self._getState() == Table.STATE.ADD) ? 1 : 0;
					childNum -= isAddData;

					if (selAll == null)
					{
						return;
					}

					for (var index = 1; index < childNum; index++)
					{
						checkbox = self.data[self.data.length - index]["CHECK_BOX"];

						if (rows[index].style.display != "none" &&
							!checkbox.disabled &&
							checkbox.getValue() == false)
						{
							isSelAll = false;
						}
						else if (checkbox.getValue() == true)
						{
							isSel = true;
						}
					}

					if (isSel)
					{
						$(self).trigger("ev_sel_item");
					}
					else
					{
						$(self).trigger("ev_sel_none");
					}

					selAll.setValue(isSelAll);

					if (self._ops.clickList.click_check &&
						typeof self._ops.clickList.click_check.func == "function")
					{
						self._ops.clickList.click_check.func(isSel, isSelAll);
					}
				}
			});

			/* 新增用于控制表格某行勾选框禁用及勾选状态 */
			if (dataObj.checkboxDisabled)
			{
				checkBox.disable(dataObj.checkboxDisabledChecked);
			}

			dataObj["CHECK_BOX"] = checkBox;
		}

		/* 根据list中的type进行数据填充 */
		for (var item = 0; item < list.length; item++)
		{
			var listObj = list[item];
			type = listObj.type;
			td = tr.insertCell(-1);
			td.className = this._ops.type;
			$(td).attr("data-index", i);

			/* TODO: 此次要加上当不存在表头时cell的宽度计算、以及自定义样式的支持(可选) */

			switch (type)
			{
			case "button":
				var options = listObj.options;
				var onRender = options.onRender, divCon, iconCon, spanCon;

				if (typeof onRender == "function")
				{
					if (!onRender(dataObj))
					{
						break;
					}
				}

				divCon = $("<div></div>").addClass("itemOption");
				iconCon = $("<i></i>").addClass("iconfont " + options.icon);
				divCon[0].appendChild(iconCon[0]);
				spanCon = $("<span></span>").html(options.str);
				divCon[0].appendChild(spanCon[0]);

				divCon.click((function(i, dataObj, listObj){
					return function(){
						listObj.options.onClick(i, dataObj);
					}
				})(i, dataObj, listObj));

				td.appendChild(divCon[0]);
				break;
			case "time":
				var time = dataObj[listObj.name];
				if (0xFFFFFFFF == time)
				{
					td.innerHTML = label.forever;
				}
				else
				{
					var dateTime = new Date();
					dateTime.setHours(parseInt(time/(60*60)), parseInt(time%(60*60)/60), parseInt(time%(60*60)%60), 0);
					td.innerHTML = dateTime.toTimeString().substring(0,8);
				}
				break;
			case "timeP":
				var time = dataObj[listObj.name];
				if( 0xFFFFFFFF == time)
				{
					td.innerHTML = label.forever;
				}
				else
				{
					var hour, minute, second;

					hour = parseInt(time/(60*60));
					minute = parseInt(time%(60*60)/60);
					second = parseInt(time%(60*60)%60);

					if (hour < 10)
					{
						hour = "0" + hour;
					}
					if (minute < 10)
					{
						minute = "0" + minute;
					}
					if (second < 10)
					{
						second = "0" + second;
					}

					td.innerHTML = hour + ":" + minute + ":" + second;
				}
				break;
			case "select":
				var options = listObj.options;
				var val = dataObj[listObj.name];
				var blankStr = listObj.blankStr;
				var str;

				if (options[0].value != undefined)
				{
					for (var n = 0, len = options.length; n < len; n++)
					{
						if (options[n].value == val)
						{
							str = options[n].str;
							td.innerHTML = (str == blankStr ? "" : htmlEscape(str));
							break;
						}
					}
				}
				else
				{
					str = options[val].str;
					td.innerHTML = (str == blankStr ? "" : htmlEscape(str));
				}

				break;
			case "switch":
				var val = dataObj[listObj.name];
				var str = "";
				if (val == listObj.valueInfo.on)
				{
					str = listObj.showStr.on;
				}
				else
				{
					str = listObj.showStr.off;
				}
				td.innerHTML = htmlEscape(str);
				break;
			case "checkbox":
				/* TODO: 这个先放着 */
				break;
			case "radio":
				var radioOps = listObj.options;

				td.id = self.table.id + radioOps.name + "Radio_" + i;
				var radioObj = new Radio({
					targetId: td.id,
					name: radioOps.name,
					onClick: function(){
						//return (function(n){radioOps.callback(n)})(i);	//此处待定
						typeof radioOps.callback == "function" && radioOps.callback(i, this);
					}
				});
				break;
			case "strSelect":
				var strOps = listObj.options, strItem;
				var value = parseInt(dataObj[listObj.name]), str = "";

				for (var ele = 0; ele < strOps.length; ele++)
				{
					strItem = strOps[ele];
					if (strItem.value != undefined)
					{
						if (value == parseInt(strItem.value))
						{
							str = strItem.str;
							break;
						}
					}
					else if (value == ele)
					{
						str = strItem.str;
						break;
					}
				}
				td.innerHTML = htmlEscape(str);
				break;
			case "ports":
				var names = listObj.name.split(" "), temp;

				if (dataObj[names[1]] != dataObj[names[0]])
				{
					td.innerHTML = dataObj[names[0]] + (dataObj[names[1]].length == 0 ? "" : " - " + dataObj[names[1]]);
				}
				else
				{
					td.innerHTML = dataObj[names[0]];
				}
				break;
			case "ips":
				var names = listObj.name.split(" "), temp;

				if (dataObj[names[1]] != dataObj[names[0]])
				{
					td.innerHTML = dataObj[names[0]] + (dataObj[names[1]].length == 0?"":" - "+dataObj[names[1]]);
				}
				else
				{
					td.innerHTML = dataObj[names[0]];
				}
				break;
			case "speed":
				var value = dataObj[listObj.name];

				td.innerHTML = (parseInt(value) == 0 ? label.disLimit : (value + label.unitKBs));
				break;
			case "signal":
				var signalVal = dataObj[listObj.name];
				var signalCon = $("<i></i>").addClass("signal");

				signalVal = isNaN(signalVal) == true ? 1 : signalVal;
				if (signalVal == 1)
				{
					signalVal = 2;			/* Fix Bug 281000 */
				}

				signalCon.addClass("signalStrength_" + signalVal);

				td.appendChild(signalCon[0]);
				break;
			case "auth":
				var authVal = dataObj[listObj.name];

				if (parseInt(authVal) != uciWireless.encryptionType.none)
				{
					var authCon = $("<i></i>").addClass("iconfont icon-password auth");
					td.appendChild(authCon[0]);
				}

				break;
			case "mac":
				str = dataObj[listObj.name];
				td.innerHTML = str = (str == undefined ? "" : str.toString().toUpperCase());

				td.title = str;
				break;
			/* DEVICE LIST */
			case "deviceBasicInfo":
				var logoCon, hostCon, hostnameCon, isCurHost, hostname, hostNameInput, ipMac;

				/* LOGO */
				macBrandTransition(dataObj);

				logoCon = $("<i></i>").addClass("deviceLogo");
				logoCon[0].style.background = "url(../web-static/images/basic.png) no-repeat scroll " + dataObj.logoPosX + "px " + dataObj.logoPosY + "px";
				td.appendChild(logoCon[0]);

				hostCon = $("<div></div>").addClass("deviceInfoCon")[0];
				td.appendChild(hostCon);

				hostnameCon = $("<div></div>").addClass("deviceNameCon")[0];
				hostCon.appendChild(hostnameCon);

				/* HOST NAME */
				if (dataObj.isCurHost && dataObj.isCurHost == "1")
				{
					isCurHost = $("<span></span>").addClass("isCurHost").html("[" + label.bHost + "]");
					hostnameCon.appendChild(isCurHost[0]);
				}

				hostname = $("<div></div>").addClass("deviceName").attr("id", self.table.id + "_deviceName_" + i);
				hostnameCon.appendChild(hostname[0]);

				hostNameInput = new Input({
					targetId: self.table.id + "_deviceName_" + i,
					type: Input.TYPE.STATIC_TEXT,	//PLAIN_TEXT  STATIC_TEXT
					props:{type: "text", maxLength: DEVICE_NAME_LEN_MAX,value: (dataObj.name == "" ? label.anonymousHost : dataObj.name)},
					size:Input.SIZE.SMALL,
					check:{
						blur: (function(listObj){
							return function(){
								var self = this;

								if (listObj.isEditable == undefined || listObj.isEditable == true)
								{
									typeof listObj.onSave == "function" && listObj.onSave(self, dataObj);
									self.toggleStatic(true);
									self.setValue(dataObj.name);
								}
							}
						})(listObj),
						keyup: (function(listObj){
							return function(event){
								var self = this;

								if (listObj.isEditable == undefined || listObj.isEditable == true)
								{
									event = event || window.event;
									if (event.keyCode == 13)
									{
										typeof listObj.onSave == "function" && listObj.onSave(self, dataObj);
										self.toggleStatic(true);
										self.setValue(dataObj.name);
									}
								}
							}
						})(listObj)
					},
					containerType:Input.CONTAINER.TABLE
				});

				if (listObj.isEditable == undefined || listObj.isEditable == true)
				{
					hostname.addClass("editable");
					$(hostNameInput.dom).click((function(listObj){
						return function(){
							if (!$(this).find("li.inputLi").hasClass('static'))
							{
								return;
							}

							typeof listObj.onClick == "function" && listObj.onClick();

							hostNameInput.toggleStatic(false);
							hostNameInput.input.select();
						}
					})(listObj));
				}

				/* IP、MAC */
				ipMac = $("<span></span>").addClass("deviceIpMac").html(dataObj.ip);
				hostCon.appendChild(ipMac[0]);

				ipMac = $("<span></span>").addClass("deviceIpMac").css("margin-left", "16px").html(dataObj.mac.toUpperCase());
				hostCon.appendChild(ipMac[0]);

				break;
			case "deviceLinkType":
				var str, inet_type = dataObj.type, wifi_type = dataObj.wifi_mode;

				if (inet_type == "1")
				{
					switch (wifi_type)
					{
					case uciHostsInfo.optValue.wifiMode.h2G:
						str = label.wirelessNet2G;
						break;
					case uciHostsInfo.optValue.wifiMode.h5G:
						str = label.wirelessNet5G;
						break;
					case uciHostsInfo.optValue.wifiMode.h5G1:
						str = label.wirelessNet5G1;
						break;
					case uciHostsInfo.optValue.wifiMode.h5G4:
						str = label.wirelessNet5G2;
						break;
					default:
						str = label.wirelessLink;
						break;
					}
				}
				else if (inet_type == "0")
				{
					str = label.inetLink;
				}
				else if (inet_type == "2")
				{
					str = label.wirelessLink;
				}
				else
				{
					str = "- - -";
				}

				/* TODO: 此处需加上离线设备支持 */
				if (dataObj.blocked == "1")
				{
					str = "- - -";
				}

				td.innerHTML = str;
				break;
			case "deviceSpeed":
				var unLimitCon, speedCon, iconCon, numCon, upLimitInput, downLimitInput;
				var upSpeed = dataObj.up, downSpeed = dataObj.down;

				if (typeof listObj.onTrans == "function")
				{
					upSpeed = listObj.onTrans(upSpeed);
					downSpeed = listObj.onTrans(downSpeed);
				}

				/* TODO: 此处需加上离线设备支持 */
				if (dataObj.blocked == "1")
				{
					upSpeed = "- - -";
					downSpeed = "- - -";
				}

				/* UP_SPEED */
				speedCon = $("<span></span>").addClass("deviceSpeed")[0];
				iconCon = $("<i></i>").addClass("iconfont icon-upstream");
				speedCon.appendChild(iconCon[0]);
				numCon = $("<span></span>").addClass("deviceSpeedNum").html(upSpeed);
				speedCon.appendChild(numCon[0]);
				td.appendChild(speedCon);

				/* DOWN_SPEED*/
				speedCon = $("<span></span>").addClass("deviceSpeed").css("margin-top", "6px")[0];
				iconCon = $("<i></i>").addClass("iconfont icon-downstream");
				speedCon.appendChild(iconCon[0]);
				numCon = $("<span></span>").addClass("deviceSpeedNum").html(downSpeed);
				speedCon.appendChild(numCon[0]);
				td.appendChild(speedCon);

				break;
			case "deviceSpeedLimit":
				var speedLimitCon, iconCon, numCon, speedInputCon;
				var upLimitSpeed = dataObj.upLimit, downLimitSpeed = dataObj.downLimit;

				/* Tips: 此处只能获取表头TD长度来了解当前td宽度 */
				var tdLength = $($(this.table).find("tr.TableHead").find("td")[item]).css("width");

				/* UP_SPEED */
				speedLimitCon = $("<span></span>").addClass("deviceSpeed").css("width", tdLength)[0];
				td.appendChild(speedLimitCon);
				iconCon = $("<i></i>").addClass("iconfont icon-upstreamlimit");
				speedLimitCon.appendChild(iconCon[0]);
				numCon = $("<div></div>").addClass("deviceSpeedNum").attr("id", self.table.id + "_upLimit_" + i)
								.css("width", parseInt(tdLength) - 16 - 4);	// TODO: 这里的16 和 4要再优化
				speedLimitCon.appendChild(numCon[0]);

				upLimitInput = new Input({
					targetId: self.table.id + "_upLimit_" + i,
					type: Input.TYPE.STATIC_TEXT,
					props:{type: "text", value: upLimitSpeed + label.unitKBs, maxLength: 6, placeholder:label.noSpeedLimit},
					size:Input.SIZE.SMALL,
					tips:{value:label.unitKBs, className: "unit"},
					check:{
						blur: (function(td){
							return function(){
								var self = this;
								$.setTimeout(function(){
									$(td).trigger("ev_save", [self, "MouseOut"]);
								}, 50);
							}
						})(td),
						keyup: (function(td){
							return function(event){
								var self = this;

								event = event || window.event;
								if (event.keyCode == 13)
								{
									$(td).trigger("ev_save", [self, "KeyUp"]);
								}
							}
						})(td)
					},
					containerType:Input.CONTAINER.TABLE
				});

				$(upLimitInput.dom).click((function(listObj){
					return function(){
						if (!$(this).find("li.inputLi").hasClass('static'))
						{
							return;
						}

						typeof listObj.onClick == "function" && listObj.onClick(callback);

						function callback(state)
						{
							if (state)
							{
								upLimitInput.toggleStatic(false);
								if (upLimitInput.getValue() == label.noSpeedLimit)
								{
									upLimitInput.setValue(0);
								}
								else if (upLimitInput.getValue().indexOf(label.unitKBs) != -1)
								{
									upLimitInput.setValue(upLimitInput.getValue().replace(label.unitKBs, ""));
								}
								upLimitInput.input.select();
							}
						}
					}
				})(listObj));

				/* DOWN_SPEED*/
				speedLimitCon = $("<span></span>").addClass("deviceSpeed").css("width", tdLength).css("margin-top", "6px")[0];
				td.appendChild(speedLimitCon);
				iconCon = $("<i></i>").addClass("iconfont icon-downstreamlimit");
				speedLimitCon.appendChild(iconCon[0]);
				numCon = $("<div></div>").addClass("deviceSpeedNum").attr("id", self.table.id + "_downLimit_" + i)
								.css("width", parseInt(tdLength) - 16 - 4);
				speedLimitCon.appendChild(numCon[0]);

				downLimitInput = new Input({
					targetId: self.table.id + "_downLimit_" + i,
					type: Input.TYPE.STATIC_TEXT,	//PLAIN_TEXT  STATIC_TEXT
					props:{type: "text", value: downLimitSpeed + label.unitKBs, maxLength: 6, placeholder:label.noSpeedLimit},
					size:Input.SIZE.SMALL,
					tips:{value:label.unitKBs, className: "unit"},
					check:{
						blur: (function(td){
							return function(){
								var self = this;

								$.setTimeout(function(){
									$(td).trigger("ev_save", [self, "MouseOut"]);
								}, 50);
							}
						})(td),
						keyup: (function(td){
							return function(event){
								var self = this;

								event = event || window.event;
								if (event.keyCode == 13)
								{
									$(td).trigger("ev_save", [self, "KeyUp"]);
								}
							}
						})(td)
					},
					containerType:Input.CONTAINER.TABLE
				});

				$(downLimitInput.dom).click((function(listObj){
					return function(){
						if (!$(this).find("li.inputLi").hasClass('static'))
						{
							return;
						}

						typeof listObj.onClick == "function" && listObj.onClick(callback);

						function callback(state){
							if (state)
							{
								downLimitInput.toggleStatic(false);
								if (downLimitInput.getValue() == label.noSpeedLimit)
								{
									downLimitInput.setValue(0);
								}
								else if (downLimitInput.getValue().indexOf(label.unitKBs) != -1)
								{
									downLimitInput.setValue(downLimitInput.getValue().replace(label.unitKBs, ""));
								}

								downLimitInput.input.select();
							}
						}
					}
				})(listObj));

				$(td).find("span.deviceSpeed").css("display", "none");

				unLimitCon = $("<div></div>").addClass("itemOption")[0];
				iconCon = $("<i></i>").addClass("iconfont icon-speedlimit");
				unLimitCon.appendChild(iconCon[0]);
				unLimitCon.appendChild($("<span></span>").html(label.speedLimit)[0]);

				td.appendChild(unLimitCon);

				$(unLimitCon).click((function(td, listObj){
					return function(){
						typeof listObj.onClick == "function" && listObj.onClick(callback);

						function callback(state)
						{
							if (state)
							{
								$(td).trigger("ev_switchLimit");
							}
						}
					}
				})(td, listObj));

				if (upLimitSpeed == "0" && downLimitSpeed == "0")
				{
					$(unLimitCon).css("display", "block");
					$(td).find("span.deviceSpeed").css("display", "none");
				}
				else
				{
					$(unLimitCon).css("display", "none");
					$(td).find("span.deviceSpeed").css("display", "block");

					if (upLimitSpeed == "0")
					{
						upLimitInput.setValue(label.noSpeedLimit);
					}

					if (downLimitSpeed == "0")
					{
						downLimitInput.setValue(label.noSpeedLimit);
					}
				}

				$(td).on("ev_switchUnlimit", (function(td){
					return function(params){
						$(td).find("div.itemOption").css("display", "block");
						$(td).find("span.deviceSpeed").css("display", "none");
					}
				})(td));

				$(td).on("ev_switchLimit", (function(td, upLimitSpeed, downLimitSpeed){
					return function(params){
						$(td).find("div.itemOption").css("display", "none");
						$(td).find("span.deviceSpeed").css("display", "block");

						upLimitInput.toggleStatic(false);
						upLimitInput.setValue("");
						downLimitInput.toggleStatic(false);
						downLimitInput.setValue("");

						$(upLimitInput.dom).find('li.inputLi').trigger("mouseout");
						$(upLimitInput.input).trigger("select");
					}
				})(td, upLimitInput, downLimitInput));

				$(td).on("ev_save", (function(listObj, upLimitInput, downLimitInput, td){
					return function(event, param, type){
						var key = param == upLimitInput ? "upLimit" : "downLimit", str, anotherInput, anotherKey;

						if (type == "KeyUp" || (upLimitInput.isMouseOver == false && downLimitInput.isMouseOver == false))
						{
							if (typeof listObj.onSave == "function")
							{
								listObj.onSave(upLimitInput, downLimitInput, dataObj, param);
							};

							param.toggleStatic(true);
							param.setValue(dataObj[key] == "0" ? label.noSpeedLimit : dataObj[key] + label.unitKBs);

							anotherInput = key == "upLimit" ? downLimitInput : upLimitInput;
							anotherKey = key == "upLimit" ? "downLimit" : "upLimit";

							if (!$(anotherInput.dom).find('li.inputLi').hasClass('static'))
							{
								anotherInput.toggleStatic(true);
								anotherInput.setValue(dataObj[anotherKey] == "0" ? label.noSpeedLimit : dataObj[anotherKey] + label.unitKBs);
							}

							if (dataObj.upLimit == "0" && dataObj.downLimit == "0")
							{
								$(td).trigger("ev_switchUnlimit");
							}
						}
					}
				})(listObj, upLimitInput, downLimitInput, td));
				break;
			case "str":
			default:
				//showSize = this._calcShowSize(td, listObj);
				var fontSize = parseInt($(td).css("font-size"));
				var cellWidth = parseInt($($(this.table).find("tr.TableHead").find("td")[item + (this._ops.hasCheckBox ? 1 : 0)]).css("width"));
				//var cellWidth = parseInt($(td).actual("width"));
				var str;

				str = dataObj[listObj.name];
				str = (str == undefined ? "" : str.toString());

				td.title = str;

				if (true == listObj.igHTMLEscape)
				{
					str = getStrInMaxWithPixel(str, fontSize, cellWidth);
				}
				else
				{
					str = htmlEscape(getStrInMaxWithPixel(str, fontSize, cellWidth));
				}

				if (listObj.onRender != undefined && typeof listObj.onRender == "function")
				{
					str = listObj.onRender(dataObj, str);
				}

				$(td).html(str);

				if (listObj.className != undefined)
				{
					td.className += " " + listObj.className;
				}
				break;
			}

			if (listObj["props"] != undefined)
			{
				$.each(listObj["props"], function(k, v){
					$(td).css(k, v);
				})
			}

			/* TODO: 此处需要添加可点击的Cell操作 */
		}

		/* Edit Column Init*/
		if (this._ops.editable || this._ops.deletable || this._ops.itemOption != null)
		{
			var str = "", item, renderResult;

			td = tr.insertCell(-1);
			td.className = this._ops.type;

			if (this._ops.itemOption != null)
			{
				for (var itemIndex = 0; itemIndex < this._ops.itemOption.length; itemIndex++)
				{
					item = this._ops.itemOption[itemIndex];

					if (item.onRender && typeof item.onRender == "function")
					{
						renderResult = item.onRender(dataObj);
					}
					else
					{
						renderResult = {result:false};
					}

					if (!renderResult.result)
					{
						str +=  '<div class="itemOption ' + item.type + '">'	+
							'<i class="iconfont ' + item.icon + '"></i>'	+
							'<span>' + item.str + '</span>'					+
						'</div>';
					}
					else
					{
						str += renderResult.str;
					}

				}
			}

			if (this._ops.editable)
			{
				str +=  '<div class="itemOption edit">' 				+
							'<i class="iconfont icon-edit"></i>'		+
							'<span>' + btn.edit + '</span>'				+
						'</div>';
			}

			if (this._ops.deletable)
			{
				var delItemIcon = self._ops.clickList.click_del_item.icon || "icon-delete";
				var delItemStr = self._ops.clickList.click_del_item.str || btn.clear;
				var onRender = self._ops.clickList.click_del_item.onRender || function(){return true;}

				if (onRender(dataObj))
				{
					str +=  '<div class="itemOption delete">' 				+
								'<i class="iconfont ' + delItemIcon + '"></i>'		+
								'<span>' + delItemStr + '</span>'				+
							'</div>';
				}
			}

			td.innerHTML = str;

			/* TODO: 此次要加上当不存在表头时cell的宽度计算、以及自定义样式的支持(可选) */

			$(td).find("div").last().addClass("itemOptionLast");

			/* Event Add */
			if (this._ops.editable)
			{
				$(td).find('div.edit').on("click", function(event){
					var state = self._getState();

					switch (state)
					{
					case Table.STATE.EDIT:
						/* TODO: 此处需要看是否支持强制切换编辑行 */
						return;
					case Table.STATE.DEFAULT:
						break;
					default:
						return;
					}

					self._setState(Table.STATE.EDIT);
					self.closeBlankTips(null, true);
					self._fillEditRow("edit", tr, dataObj, i);
					self._updateEvent(Table.STATE.EDIT);
				});
			}

			if (this._ops.deletable)
			{
				$(td).find('div.delete').on("click", function(event){

					/* 若置灰，则直接返回 */
					if ($(this).hasClass('disabled'))
					{
						return;
					}

					var indexTable = self._getTrIndexInTable(tr);
					var indexData = self._getTrIndexInDataObj(tr).toString();
					self._delDataHandle(indexData, [indexTable]);
				})
			}
			if (this._ops.itemOption != null)
			{
				for (var itemIndex = 0; itemIndex < this._ops.itemOption.length; itemIndex++)
				{
					var item = this._ops.itemOption[itemIndex];
					$(td).find('div.' + item.type).on("click",function(event){
						var indexTable = self._getTrIndexInTable(tr);
						var indexData = self._getTrIndexInDataObj(tr).toString();
						if (item.func != undefined && typeof item.func == "function")
						{
							item.func(indexData, indexTable);
						}
					});
				}
			}
		}
	}
	Table.prototype._fillEditRow = function(option, tr, dataObj, i){
		var list = this._ops.column,
			self = this,
			td, item, checkBox;

		if (option == Table.STATE.EDIT)
		{
			/* TODO: 此处的清空TR看能否简化 */
			var len = tr.cells.length;

			try
			{
				tr.innerHTML = "";
			}
			catch(ex)
			{
				while(len > 0)
				{
					tr.deleteCell(0);
					len = tr.cells.length;
				}
			}
		}
		else if (option == Table.STATE.ADD)
		{

		}

		this.editTrObj = [];

		if (self._ops.hasCheckBox)
		{
			td = tr.insertCell(-1);
			td.className = this._ops.type;
			td.id = "checkbox " + i;
			setStyle(td, {textAlign:"left"});

			/* TODO: 此次要加上当不存在表头时cell的宽度计算、以及自定义样式的支持(可选)
			cellWidth = parseInt(self._constant.checkboxTdWidth) - parseInt(self._constant.headPadding) * 2;
			setStyle(td, {width: cellWidth + "px"});
			*/

			checkBox = new CheckBox({
				targetId:td.id,
				onClick:function(){
					var rows, selAll, childNum;
					var isSelAll = true, isSel = false;

					if (self._ops.hasHead == false)
					{
						return;
					}

					rows = self.table.rows;
					selAll = self.selAllCheckBoxObj;
					childNum = rows.length;

					if (selAll == null)
					{
						return;
					}

					for(var index = 1; index < childNum; index++)
					{
						checkbox = self.data[self.data.length - index]["CHECK_BOX"];

						if (rows[index].style.display != "none" &&
							checkbox.getValue() == false)
						{
							isSelAll = false;
						}
						else if (checkbox.getValue() == true)
						{
							isSel = true;
						}
					}

					if (isSel)
					{
						$(self).trigger("ev_sel_item");
					}
					else
					{
						$(self).trigger("ev_sel_none");
					}

					selAll.setValue(isSelAll);

					if (self._ops.clickList.click_check &&
						typeof self._ops.clickList.click_check.func == "function")
					{
						self._ops.clickList.click_check.func(isSel, isSelAll);
					}
				}
			});

			dataObj["CHECK_BOX"] = checkBox;
		}

		for (var index = 0; index < list.length; index++)
		{
			td = tr.insertCell(-1);
			item = list[index];
			type = item.type;
			value = dataObj[item.name];

			/* 此处对ports类型做一下处理，之后看有没有更好的方法解决 */
			if (type == "ports")
			{
				value = "";
			}

			/* 不可编辑的列直接显示 */
			if (item.edit == false && option != Table.STATE.ADD)
			{
				td.innerHTML = value ? (item.type == "mac" ? value.toUpperCase() : value) : "";
				this.editTrObj.push({editable:false, name:item.name, value:value});
				continue;
			}

			switch (type)
			{
			case "btn":
				/* TODO: 此处为啥要break...先记录 */
				break;
			case "mask":
			case "dns":
			case "gateway":
			case "ip":
			case "mac":
			case "ports":
				/* 如果有值传入，则进行初始化赋值 */
				var blurFunc;
				td.id = type + "Addr" + i + this._ops.targetId + index;

				if (type == "mask")
				{
					blurFunc = checkMask;
				}
				else if (type == "mac")
				{
					blurFunc = checkMac;
				}
				else if (type == "ports")
				{
					blurFunc = checkPorts;
				}
				else
				{
					blurFunc = checkIp;
				}

				var options = {
					type:Input.TYPE.PLAIN_TEXT,
					targetId:td.id,
					props:{type: "text"},
					size:Input.SIZE.SMALL,
					containerType:Input.CONTAINER.TABLE,
					check:{blur:(function(func){
						return function(){
							var result, noteStr;
							if ((result = func.call(window, this.input.value.toString())) != ENONE)
							{
								switch (result)
								{
								case EINVNET:
									noteStr = errStr.ipAddrNetErr;
									break;
								case EINVIP:
									noteStr = errStr.ipAddrErr;
									break;
								case EINVIPFMT:
									noteStr = errStr.ipAddrFmtErr;
									break;
								case EINVGROUPIP:
									noteStr = errStr.ipAddrGroupErr;
									break;
								case EINVLOOPIP:
									noteStr = errStr.ipAddrLoopErr;
									break;
								case EINVMACFMT:
									noteStr = errStr.macFmtErr;
									break;
								case EINVMACZERO:
									noteStr = errStr.macZeroErr;
									break;
								case EINVMACBROAD:
									noteStr = errStr.macBroadErr;
									break;
								case EINVMACGROUP:
									noteStr = errStr.macGroupErr;
									break;
								case EINVMASK:
									noteStr = errStr.maskErr;
									break;
								case EINVPORTFMT:
									noteStr = errStr.portIllegalFmtErr;
									break;
								case EINVPORT:
									noteStr = errStr.invPortErr;
									break;
								case EILLEGALPORT:
									noteStr = errStr.inputEliegalChar;
									break;
								default:
									break;
								}

								this.showNote(noteStr);
								return false;
							}
							return true;
						}
					})(blurFunc)}
				};

				if (item.isAllowBlank != undefined)
				{
					options.isAllowBlank = item.isAllowBlank;
				}

				if (item.isAllowAllSpace != undefined)
				{
					options.isAllowAllSpace = item.isAllowAllSpace;
				}

				options.props.maxLength = item.maxLength ? item.maxLength : (type == "mac" ? 17 : 15);

				var inputObj = new Input(options);
				if (value != undefined)
				{
					if (type == "mac")
					{
						value = value.toUpperCase();
					}
					else if (type == "ports")
					{
						var names = item.name.split(" ");
						var tempValue = dataObj[names[0]];

						if (typeof tempValue != "undefined")
						{
							if (dataObj[names[1]] != tempValue)
							{
								value = tempValue + "-" + dataObj[names[1]];
							}
							else
							{
								value = tempValue;
							}
						}
					}

					inputObj.setValue(value);
				}
				this.editTrObj.push({editable:"true", name:item.name, type:type, container:inputObj});
				break;
			case "select":
				var gridSelUl = document.createElement('ul');
				var gridSelLi = document.createElement('li');
				var gridSelCon = document.createElement('span');
				var selCon = document.createElement('span');
				var selValCon = document.createElement('span');
				var arrow = document.createElement('i');

				gridSelUl.className = "inputCMPT small";
				td.appendChild(gridSelUl);

				gridSelLi.className = "inputLi";
				gridSelUl.appendChild(gridSelLi);

				gridSelCon.className = "table selectWrap";
				gridSelLi.appendChild(gridSelCon);

				selCon.id = item.name + "Select" + i;
				selCon.className = "select";
				gridSelCon.appendChild(selCon);

				selValCon.className = "value";
				selCon.appendChild(selValCon);

				arrow.className = "arrow iconfont icon-folddropdown";
				selCon.appendChild(arrow);

				if (undefined == value || value.length == 0)
				{
					value = (item.defaultValue == undefined ? 0 : item.defaultValue);
				}

				selectInit(selCon.id, item.options, value, item.func, item.maxSelSize);
				this.editTrObj.push({editable:"true", name:item.name, type:type, container:selCon});
				break;
			case "speed":
			case "str":
			default:
				/* Speed输入框暂时还没遇到，先放在这 */
				td.id = type + "Input" + i + this._ops.targetId + index;

				var options = {
					type:Input.TYPE.PLAIN_TEXT,
					targetId:td.id,
					props:{type: "text"},
					containerType:Input.CONTAINER.TABLE,
					size:Input.SIZE.SMALL
				};

				if (item.isAllowBlank != undefined)
				{
					options.isAllowBlank = item.isAllowBlank;
				}

				if (item.isAllowAllSpace != undefined)
				{
					options.isAllowAllSpace = item.isAllowAllSpace;
				}

				options.props.maxLength = item.maxLength ? item.maxLength : 15;

				var inputObj = new Input(options);
				if (value != undefined && value.length != 0)
				{
					inputObj.setValue(value);
				}
				this.editTrObj.push({editable:"true", name:item.name, type:type, container:inputObj});
				break;
			}
		}

		/* Edit Column Init*/
		var str = "";

		td = tr.insertCell(-1);
		td.className = this._ops.type;

		str +=  '<div class="itemOption cancel">' 				+
					'<i class="iconfont icon-close"></i>'		+
					'<span>' + btn.cancel + '</span>'				+
				'</div>'										+
				'<div class="itemOption save">' 				+
					'<i class="iconfont icon-ok"></i>'			+
					'<span>' + btn.save + '</span>'				+
				'</div>';

		td.innerHTML = str;

		$(td).find("div").last().addClass("itemOptionLast");

		/* Event Add */
		$(td).find('div.cancel').on("click", function(event){
			var len = tr.cells.length, state = self._getState(), table = self.table;
			var length;

			switch (state)
			{
			case Table.STATE.DEFAULT:
				break;
			case Table.STATE.EDIT:
				try
				{
					tr.innerHTML = "";
				}
				catch(ex)
				{
					while(len > 0)
					{
						tr.deleteCell(0);
						len = tr.cells.length;
					}
				}
				self._insertRowData(tr, i, dataObj);
				break;
			case Table.STATE.ADD:
				length = table.rows.length - 1;
				table.deleteRow((self._ops.hasHead == true ? 1:0));
				length = (self._ops.hasHead == true?(length - 1):length);

				/* TODO: 判断是否显示"空行" */
				if (length == 0)
				{

					break;
				}

				self._pagingListInit(length, 1);
				break;
			}

			self._setState(Table.STATE.DEFAULT, true);
			self._updateEvent(Table.STATE.DEFAULT);

			if (self._ops.clickList.click_cancel &&
				typeof self._ops.clickList.click_cancel.func == "function")
			{
				self._ops.clickList.click_cancel.func();
			}
		});
		$(td).find("div.save").on("click", function(event){
			var state = self._getState(),
				saveObj = self._ops.clickList.click_save,
				data = self.data;
			var mode, result, func, asyn, itemObj = {}, resultObj = {};

			switch(state)
			{
			case Table.STATE.DEFAULT: //默认情况下不作处理
				return;
			case Table.STATE.EDIT:
				mode = Table.STATE.EDIT;
				index = self._getTrIndexInDataObj(tr);
				itemObj = self.data[index];
				$.extend(resultObj, itemObj);
				result = self._saveDataCheckHandle(itemObj, resultObj);
				break;
			case Table.STATE.ADD:
				mode = Table.STATE.ADD;
				index = self._getTableDataRows() - 1;
				self._formatBlankData(itemObj);
				result = self._saveDataCheckHandle(itemObj, resultObj);
				break;
			}

			if (result.result != true)
			{
				return;
			}

			if (mode == Table.STATE.EDIT && result.isChange == false)
			{
				try
				{
					tr.innerHTML = "";
				}
				catch(ex)
				{
					while(len > 0)
					{
						tr.deleteCell(0);
						len = tr.cells.length;
					}
				}
				/* TODO:此处要更新按钮状态 */
				self._insertRowData(tr, i, dataObj);
				self._setState(Table.STATE.DEFAULT, true);
				self._updateEvent(Table.STATE.DEFAULT);
				return;
			}

			function saveHandle(successed)
			{
				if (successed != false)
				{
					/* TODO:此处要更新按钮状态 */
					try
					{
						tr.innerHTML = "";
					}
					catch(ex)
					{
						while(len > 0)
						{
							tr.deleteCell(0);
							len = tr.cells.length;
						}
					}
					$.extend(dataObj, resultObj);

					if (state == Table.STATE.ADD)
					{
						data[index] = dataObj;
					}

					self._insertRowData(tr, i, dataObj);
					self._setState(Table.STATE.DEFAULT, true);
					self._updateEvent(Table.STATE.DEFAULT);
				}
			}

			if (saveObj != undefined)
			{
				func = saveObj.func;
				asyn = saveObj.asyn;

				if (asyn)
				{
					func(mode, resultObj, index, saveHandle);
				}
				else
				{
					saveHandle(func(mode, resultObj, index));
				}
			}
			else
			{
				saveHandle(true);
			}
		});
	}
	Table.prototype._pagingListInit = function(len, startPage){
		/*
				  len: 数据总长度
			startPage: 指定的初始页
		*/

		var self = this, table = this.table, tableParentCon = id(this._ops.targetId),
			pagingListId = this._ops.targetId + "PagingList",
			numPerPage = this._ops.numPerPage,
			totalPage = parseInt(len/numPerPage + ((0 == len || len%numPerPage > 0) ? 1 : 0)),
			div, span, pageNum, length;

		if (id(pagingListId) == undefined)
		{
			div = document.createElement('div');
			div.id = pagingListId;
			div.className = "pagingList";
			div.style.display = "none";

			tableParentCon.appendChild(div);
		}

		id(pagingListId).innerHTML = "";

		/* 先看是否满足分页条件 */
		if (totalPage <= 1)
		{
			id(pagingListId).style.display = "none";
			self._ops.currentPage = 1;

			var tableRows = table.rows;

			for (i = 0, length = tableRows.length; i < length; i++)
			{
				tableRows[i].style.display = "table-row";
			}

			if (self._ops.hasFixedHeight != null)
			{
				var blankColumnCount = numPerPage - self._getTableDataRows();

				if (blankColumnCount == 0)
				{
					this.fixedHeightObj.css("display", "none");
				}
				else
				{
					this.fixedHeightObj.empty();
					var div;

					for (i = 0; i < blankColumnCount; i++)
					{
						div = $('<div></div>');
						div.css("height", parseInt(self._constant.normalTrHeight) - 1);

						if (i != blankColumnCount - 1)
						{
							div.css("border-bottom", "1px solid #E7E7E7");
						}

						this.fixedHeightObj.append(div);
					}

					this.fixedHeightObj.css("display", "block");
				}
			}
		}
		else
		{
			id(pagingListId).style.display = "block";

			span = document.createElement('span');
			span.className = "pagingListBtn arrow arrowPre";
			span.onclick = function()
			{
				if ($(this).hasClass('disabled'))
				{
					return;
				}

				self._ops.currentPage = 1;

				if (self._ops.pageNumClickFunc != null)
				{
					self._ops.pageNumClickFunc(1);
				}
				else
				{
					self._gotoPage(1, totalPage);
				}
			}
			span.innerHTML = '<i class="iconfont icon-firstpage"></i>';
			id(pagingListId).appendChild(span);

			span = document.createElement('span');
			span.className = "pagingListBtn arrow arrowPre";
			span.onclick = function()
			{
				if ($(this).hasClass('disabled'))
				{
					return;
				}

				self._ops.currentPage += self._ops.currentPage == 1 ? 0 : -1;

				if (self._ops.pageNumClickFunc != null)
				{
					self._ops.pageNumClickFunc(self._ops.currentPage);
				}
				else
				{
					self._gotoPage(self._ops.currentPage, totalPage);
				}
			}
			span.innerHTML = '<i class="iconfont icon-back"></i>';
			id(pagingListId).appendChild(span);

			div = document.createElement('div');
			div.className = "pagingListBtnContainer";
			id(pagingListId).appendChild(div);

			span = document.createElement('span');
			span.className = "pagingListBtn arrow arrowNext";
			span.onclick = function()
			{
				if ($(this).hasClass('disabled'))
				{
					return;
				}

				self._ops.currentPage += self._ops.currentPage == totalPage ? 0 : 1;

				if (self._ops.pageNumClickFunc != null)
				{
					self._ops.pageNumClickFunc(self._ops.currentPage);
				}
				else
				{
					self._gotoPage(self._ops.currentPage, totalPage);
				}
			}
			span.innerHTML = '<i class="iconfont icon-next"></i>';
			id(pagingListId).appendChild(span);

			span = document.createElement('span');
			span.className = "pagingListBtn arrow arrowNext last";
			span.onclick = function()
			{
				if ($(this).hasClass('disabled'))
				{
					return;
				}

				self._ops.currentPage = totalPage;

				if (self._ops.pageNumClickFunc != null)
				{
					self._ops.pageNumClickFunc(totalPage);
				}
				else
				{
					self._gotoPage(totalPage, totalPage);
				}
			}
			span.innerHTML = '<i class="iconfont icon-lastpage"></i>';
			id(pagingListId).appendChild(span);

			this._gotoPage(startPage, totalPage);
		}
	}
	Table.prototype._gotoPage = function(targetPage, totalPage){
		/* 1. 初始化页数选项 2. 对指定条目显隐 */
		var self = this, data = this.data,
			tableParentCon = id(this._ops.targetId),
			pagingListContainer = $(tableParentCon).find(".pagingListBtnContainer")[0],
			numPerPage =  this._ops.numPerPage,
			childNodes = this.table.rows,
			childNum = childNodes.length,
			span, len, i, startIndex, endIndex;

		if (targetPage > totalPage)
		{
			targetPage = totalPage;
			self._ops.currentPage = totalPage;
		}

		var pagingItemArr = this._pagingItemAlg(targetPage, totalPage);
		var pagingItemArrLength = pagingItemArr.length;
		pagingListContainer.innerHTML = "";

		for (i = 0; i < pagingItemArrLength; i++)
		{
			span = document.createElement('span');

			if (pagingItemArr[i] != "...")
			{
				if (i == 0 || i == pagingItemArrLength - 1)
				{
					span.className = (i == 0) ? "pagingListBtn digital first" : "pagingListBtn digital last";
				}
				else
				{
					span.className = "pagingListBtn digital";
				}

				if (targetPage == pagingItemArr[i])
				{
					span.className += " current";
				}

				span.onclick = function()
				{
					self._ops.currentPage = parseInt(this.innerHTML);

					/* TODO: 此处日后再加上对系统日志的支持 */
					if (self._ops.pageNumClickFunc != null)
					{
						self._ops.pageNumClickFunc(parseInt(this.innerHTML));
					}
					else
					{
						self._gotoPage(parseInt(this.innerHTML), totalPage);
					}
				}
			}
			else
			{
				span.className = "pagingListBtn nonDigital"
			}

			$(tableParentCon).find(".arrowPre").removeClass("disabled");
			$(tableParentCon).find(".arrowNext").removeClass("disabled");

			if (targetPage == 1)
			{
				$(tableParentCon).find(".arrowPre").addClass("disabled");
			}

			if (targetPage == totalPage)
			{
				$(tableParentCon).find(".arrowNext").addClass("disabled");
			}

			span.innerHTML = pagingItemArr[i];
			pagingListContainer.appendChild(span);
		}

		i = (this._ops.hasHead == true) ? 1 : 0;
		startIndex = (this._ops.hasHead == true) ? 1 : 0;
		startIndex += (targetPage - 1) * numPerPage;
		endIndex = (this._ops.hasHead == true) ? 0 : -1;
		endIndex += targetPage * numPerPage;

		for (i; i < childNum; i++)
		{
			var tr = childNodes[i];

			if (i < startIndex || i > endIndex)
			{
				tr.style.display = "none";
			}
			else
			{
				tr.style.display = "table-row";
			}
		}

		if (self._ops.hasFixedHeight != null)
		{
			if (targetPage == totalPage)
			{
				var blankColumnCount = numPerPage - (self.data.length % numPerPage);

				if (blankColumnCount == 0)
				{
					this.fixedHeightObj.css("display", "none");
				}
				else
				{
					this.fixedHeightObj.empty();
					var div;

					for (i = 0; i < blankColumnCount; i++)
					{
						div = $('<div></div>');
						div.css("height", parseInt(self._constant.normalTrHeight) - 1);

						if (i != blankColumnCount - 1)
						{
							div.css("border-bottom", "1px solid #E7E7E7");
						}

						this.fixedHeightObj.append(div);
					}

					this.fixedHeightObj.css("display", "block");
				}
			}
			else
			{
				this.fixedHeightObj.css("display", "none");
			}
		}

		if (this._ops.hasCheckBox == true)
		{
			var isSelAll = childNum > 1 ? true : false, tr;

			for (i = (this._ops.hasHead == true ? 1 : 0); i < childNum; i++)
			{
				tr = childNodes[i];

				if (tr.style.display != "none" && (tr.cells[0].childNodes[0] == null ||
					tr.cells[0].childNodes[0].checked == false))
				{
					isSelAll = false;
				}
			}

			if (this._ops.hasHead == true)
			{
				this.selAllCheckBoxObj.setValue(isSelAll);
			}
		}

		if (this._ops.pageTurnCallback != null)
		{
			typeof this._ops.pageTurnCallback == "function" && this._ops.pageTurnCallback();
		}
	}
	Table.prototype._pagingItemAlg = function(targetPage, totalPage){
		var str = [];
		if (totalPage < 9)
		{
			for (var i = 1; i <= totalPage; i++)
			{
				str.push(i);
			}
		}
		else
		{
			if (totalPage == 9 && targetPage == 5)
			{
				str = [1,2,3,4,5,6,"...",8,9];
			}
			else
			{
				if (1 <= targetPage && targetPage <= 4)
				{
					str = [1,2,3,4,5,6,"...",totalPage -1,totalPage];
				}
				else if (totalPage - 4 <= targetPage && targetPage <= totalPage)
				{
					str = [1,"...",totalPage -6,totalPage -5,totalPage -4,totalPage -3,totalPage -2,totalPage -1,totalPage];
				}
				else
				{
					str = [1,"...",targetPage - 2, targetPage - 1, targetPage, targetPage + 1, targetPage + 2, "...", totalPage -1,totalPage];
				}
			}
		}

		return str;
	}
	Table.prototype._calcShowSize = function(td, listObj){
		var showSize, cellWidth, fontSize;

		fontSize = parseInt($(td).css("font-size"));
		cellWidth = parseInt($(td).actual("width"));

		showSize = parseInt(cellWidth/(fontSize*0.65));
		showSize = listObj.maxSize != undefined ? listObj.maxSize : showSize;

		return showSize;
	}
	Table.prototype._formatBlankData = function(data){
		var list = this._ops.column;

		for (var item in list)
		{
			data[list[item].name] = "";
		}
	}
	Table.prototype._getTableDataRows = function(){
		return (this._ops.hasHead == true ? (this.table.rows.length - 1) : this.table.rows.length);
	}
	Table.prototype._saveDataCheckHandle = function(dataObj, resultObj){
		var editObj = this.editTrObj;
		var item, names, values, isChange = false, result = true;

		for (var index in editObj)
		{
			item = editObj[index];

			if (false == item.editable)
			{
				resultObj[item.name] = item.value;
				continue;
			}

			switch(item.type)
			{
			case "mask":
			case "dns":
			case "gateway":
			case "ip":
			case "mac":
			case "ports":
			case "str":
				if (item.container != null)
				{
					if (item.container.checkAll() != true)
					{
						result = false;
					}

					if (item.type == "ports")
					{
						/* 对于ports类型，要特殊处理一下 */
						names = item.name.split(" ");
						values = item.container.input.value.split("-");

						if (values.length == 2)
						{
							if (values[0].length != 0 && false == (/\D/g.test(values[0])))
							{
								values[0] = parseInt(values[0]);
							}
							else
							{
								values[0] = "";
							}

							if (values[1].length != 0 && false == (/\D/g.test(values[1])))
							{
								values[1] = parseInt(values[1]);
							}
							else
							{
								values[1] = "";
							}

							resultObj[names[0]] = values[0] > values[1]?values[1]:values[0];
							resultObj[names[1]] = values[0] > values[1]?values[0]:values[1];
						}
						else if (values.length == 1)
						{
							temp = values[0];

							if (temp.length != 0 && false == (/\D/g.test(temp)))
							{
								resultObj[names[0]] = parseInt(temp);
								resultObj[names[1]] = parseInt(temp);
							}
							else
							{
								resultObj[names[0]] = "";
								resultObj[names[1]] = "";
							}
						}
					}
					else
					{
						resultObj[item.name] = item.container.input.value;
					}
				}
				break;
			case "select":
				resultObj[item.name] = item.container.value;
				break;
			/* TODO:在此处添加其他情况 */
			default:
				resultObj[item.name] = item.container.input.value;
				break;
			}

			if (item.type == "ports")
			{
				/* TODO:此处后续应该要优化 */
				names = item.name.split(" ");
				values = item.container.input.value.split("-");

				if (values.length == 2)
				{
					values[0] = parseInt(values[0]);
					values[1] = parseInt(values[1]);

					if (values[0] != dataObj[names[0]]
							|| values[1] != dataObj[names[1]])
					{
						isChange = true;
					}
				}
				else if (values.length == 1)
				{
					temp = values[0];

					temp = parseInt(temp);

					if (temp != dataObj[names[0]] || temp != dataObj[names[1]])
					{
						isChange = true;
					}
				}
			}
			else if (item.type == "select")
			{
				value = item.container.value;
				if (value != dataObj[item.name])
				{
					isChange = true;
				}
			}
			else	/* 此处之后还需要加其他参数 */
			{
				value = item.container.input.value;
				if (value != dataObj[item.name])
				{
					isChange = true;
				}
			}
		}

		return {result:result, isChange:isChange};
	}
	Table.prototype._delDataHandle = function(selArrStr, selArray){
		var self = this,
			table = this.table,
			rows = table.rows,
			rowsLen = rows.length,
			data = this.data,
			delEditRow = false,
			tableState = this._getState(),
			rowArr = [], itemArr = [],
			clearAllTips = this._ops.clearAllTips,
			startIndex = 0, numPerPage = self._ops.numPerPage, currentPage = self._ops.currentPage,
			start, temp, len, checkBox, seleteLen, tempIndex, editTrLen;

			function delHandle(){
				var delObj = self._ops.clickList.click_del_item;

				function delCallback(result){
					var length, pageNum;

					if (false == result)
					{
						return;
					}

					itemArr = selArrStr.split("-");

					startIndex = selArray[0];
					if (len == itemArr.length + startIndex - 1)
					{
						startIndex--;
						startIndex = startIndex || 0;
					}
					else if (rows[startIndex].style.display == "none")
					{
						startIndex = selArray[0];
					}

					for (var i = 0, len = itemArr.length; i < len; i++)
					{
						tempIndex = itemArr[i];
						selArray[i] = selArray[i] - i;
						table.deleteRow(selArray[i]);
						data.splice(tempIndex, 1);
					}

					/* TODO:此处要看一下是否需要判断表格为空 */
					length = self._getTableDataRows();
					pageNum = parseInt(startIndex/numPerPage) + ((startIndex%numPerPage) > 0 ? 1 : 0);
					pageNum = pageNum < 1 ? 1 : pageNum;
					self._pagingListInit(length, pageNum);

					self._setState(Table.STATE.DEFAULT);
					self._updateEvent(Table.STATE.DEFAULT);
				}

				if (delObj.func != null && delObj.asyn != null)
				{
					var func = delObj.func;
					var asyn = delObj.asyn;

					if (true == asyn)
					{
						func(selArrStr, delCallback);
					}
					else
					{
						delCallback(func(selArrStr));
					}
				}
				else
				{
					delCallback(true);
				}
			}

			start = (this._ops.hasHead == true) ? 1 : 0;
			len = rows.length - start;
			editTrLen = (tableState == Table.STATE.ADD) ? -1 : 0;
			len += editTrLen;

			if(selArrStr.length == 0)
			{
				return;
			}

			/* TODO:删除全部时，若有指定提示语，则要弹窗提示 */
			if (undefined != clearAllTips && 0 != clearAllTips.length
				&& len == selArrStr.split("-").length)
			{
				delHandle(true);
			}
			else
			{
				delHandle(true);
			}
	}
	Table.prototype._getTrIndexInTable = function(tr){
		var rows = this.table.rows, index = -1;

		for (var i = (this._ops.hasHead == true ? 1 : 0), len = rows.length; i< len; i++)
		{
			if (tr === rows[i])
			{
				index = i;
				break;
			}
		}

		return index;
	}
	Table.prototype._getTrIndexInDataObj = function(tr){
		var rows = this.table.rows, index = -1;
		var dataLen = this._ops.hasHead ? rows.length - 2 : rows.length - 1;

		if (null == tr)
		{
			return index;
		}

		for (var i = (this._ops.hasHead == true ? 1 : 0), len = rows.length; i< len; i++)
		{
			if (tr === rows[i])
			{
				index = i;
				break;
			}
		}

		if (-1 == index)
		{
			return index;
		}

		index = this._ops.hasHead == true ? (index - 1) : index;
		index = dataLen - index;

		return index;
	}
	Table.prototype._setState = function(state, force){
		if (true != force && this._state != Table.STATE.DEFAULT)
		{
			return false;
		}

		this._state = state;
		return true;
	}
	Table.prototype._getState = function(){
		return this._state;
	}
	Table.prototype._updateEvent = function(state){
		var rows = this._getTableDataRows();
		var data = this.data, table = this.table, titleBtnContainer = this.titleBtnContainer;
		var isSel = false;

		if (state == Table.STATE.DEFAULT)
		{
			$(this).trigger("ev_default");
		}
		else if (state == Table.STATE.ADD || state == Table.STATE.EDIT)
		{
			$(this).trigger("ev_edit");
		}

		if (rows == 0)
		{
			$(this).trigger("ev_none_item");
		}
		else if (rows == this._ops.max)
		{
			$(this).trigger("ev_max_item");
		}
		else
		{
			$(this).trigger("ev_has_item");
		}

		if (this._ops.hasCheckBox)
		{
			if (this._getSelectItem().length != 0)
			{
				isSel == true;
			}

			if (isSel == true)
			{
				$(this).trigger("ev_sel_item");
			}
			else
			{
				$(this).trigger("ev_sel_none");
			}

			var isSelAll = rows > 0 ? true : false, tr;

			for (i = (this._ops.hasHead == true ? 1 : 0); i < table.rows.length; i++)
			{
				tr = table.rows[i];

				if (tr.style.display != "none" && (tr.cells[0].childNodes[0] == null ||
					tr.cells[0].childNodes[0].checked == false))
				{
					isSelAll = false;
					break;
				}
			}

			if (this._ops.hasHead == true)
			{
				this.selAllCheckBoxObj.setValue(isSelAll);
			}
		}
	}
	Table.prototype._getSelectItem = function(){
		var table = this.table,
			rows = table.rows,
			data = this.data,
			tableState = this._getState(),
			rowsLen = rows.length,
			start, len, editTrLen, tr, temp, checkBox, selArrStr = "", rowArr = [];

		if (!this._ops.hasCheckBox)
		{
			return {selArrStr: "", selArr: []};
		}

		start = (this._ops.hasHead == true) ? 1 : 0;
		len = rows.length - start;
		editTrLen = (tableState == Table.STATE.ADD) ? -1 : 0;
		len += editTrLen;

		for (var index = start; index < rowsLen; index++)
		{
			tr = rows[index];

			/* TODO:这个好像没啥用，之后去掉 */
			if (tr.cells.length == 1)
			{
				continue;
			}

			temp = tr.cells[0].childNodes[0];
			if (temp == null)
			{
				continue;
			}

			checkBox = data[len - index - editTrLen]["CHECK_BOX"];

			if (checkBox.getValue() == true)
			{
				rowArr.push(index);
			}
		}

		for (var index = 0; index < rowArr.length; index++)
		{
			selArrStr += (len - rowArr[index] - editTrLen + "-");
		}

		if(selArrStr.length != 0)
		{
			selArrStr = selArrStr.substring(0, selArrStr.length - 1);
		}

		return {selArrStr: selArrStr, selArr: rowArr};
	}
	Table.TYPE = {
		NORMAL: "normal",
		DEVICE:	"device"
	};
	Table.STATE = {
		DEFAULT: "default",
		ADD: "add",
		EDIT: "edit"
	}
	/* ================================= Table Component  ================================== */

	/* ================================= UpFile Component  ================================== */
	function UpFile(options){
		this.dom = null;
		this.form = null;
		this.text = null;
		this.button = null;
		this.iframe = null;
		this.iframeName = null;

		this._ops = {
			targetId:'',
			fileFilter: null,
			upLoadCallback: null,
			loadStr: null
		}

		for (var k in options)
		{
			var item = options[k];
			this._ops[k] = item;
		}

		this._render();
	}
	UpFile.prototype._render = function(){
		var self = this;
		this.iframeName = self._ops.targetId + "If";

		this.dom = $(
			'<form enctype="multipart/form-data" id="upFileForm" method="post" target="' + this.iframeName + '">' +
				'<div id="fileText" class="fileDiv"></div>' +
				'<div id="fileButton" class="fileDiv"></div>' +
				'<input type="file" name="fileName" id="fileName">' +
				'<iframe class="upFileIf" id="' + this.iframeName + '" name="' + this.iframeName + '"></iframe>' +
			'</form>'
		)[0];

		$('#' + this._ops.targetId).append(this.dom);

		this.form = $('#' + this._ops.targetId).find("form")[0];
		this.file = $(this.dom).find("input[type=file]")[0];
		this.iframe = $(this.dom).find("iframe")[0];

		/* Init Componment */
		this.text = new Input({
			targetId: 'fileText',
			type:Input.TYPE.PLAIN_TEXT,
			containerType: Input.CONTAINER.TABLE,
			props:{readonly: true, cursor: "pointer"}
		});

		this.button = new Button({
			type:Button.TYPE.SECONDARY,
			text:btn.browse,
			id: "fileButton",
			props:{width:"80px", marginLeft: "8px", cursor: "pointer"}
		});

		/* Event Bind */
		$(this.file).css("width", $(this.text.dom).find("li.inputLi").css("width"))
					.css("height", $(this.text.dom).find("li.inputLi").css("height"));

		this.button._ops.onClick = function(){
			self.file.click();
		};

		this.file.onchange = function(){
			var tempStr = this.value;

			tempStr = tempStr.substring(tempStr.lastIndexOf('\\') + 1);
			self.text.setValue(tempStr);
			self.checkFile();
		}
	}
	UpFile.prototype.submit = function(url, isJustSubmit){
		var self = this;
		if (typeof this._ops.upLoadCallback == "function" && (isJustSubmit == undefined || isJustSubmit != true))
		{
			$(this.iframe).one("load", function(){
				iFrmOnload(self.iframeName , function(code, result){
					if (self._ops.loadStr != null)
					{
						loadingDialog.hide(function(){
							self._ops.upLoadCallback(code, result);
						});
					}
					else
					{
						self._ops.upLoadCallback(code, result);
					}
				});
			});
		}

		if (url != undefined && typeof url == "string")
		{
			this.form.action = url;
		}

		if (this._ops.loadStr != null)
		{
			loadingDialog.show({
				title: self._ops.loadStr.title || label.confirmTitle,
				content: {primary: self._ops.loadStr.content}
			}, undefined, undefined, false, undefined);
		}

		this.form.submit();
		this.form.reset();
	}
	UpFile.prototype.setActionUrl = function(url){
		if (url != undefined && typeof url == "string")
		{
			this.form.action = url;
		}
	}
	UpFile.prototype.checkFile = function(){
		var resultObj;
		var fileName = this.text.getValue();

		if (fileName == "")
		{
			this.text.showNote(errStr.upFileNull);
			return false;
		}

		if (fileName.search(/\.bin$/) == -1)
		{
			this.text.showNote(errStr.fileFmttErr);
			return false;
		}

		if (this._ops.fileFilter != null && typeof this._ops.fileFilter == "function")
		{
			resultObj = this._ops.fileFilter(fileName);

			if (resultObj.result != true)
			{
				this.text.showNote(resultObj.errStr);
				return false;
			}
			else
			{
				this.text.closeNote();
				return true;
			}
		}

		this.text.closeNote();
		return true;
	}
	/* ================================= File Component  ================================== */

	return {
		Input: Input,
		Button: Button,
		Dialog: Dialog,
		CheckBox: CheckBox,
		Radio: Radio,
		Tab: Tab,
		Table: Table,
		UpFile: UpFile
	};
})(jQuery, window);
$.extend(window, component);

/* 扩展方法，之后可再决定放在哪里 */

/* 扩展jQuery的resize函数 */
(function($, h, c){
	var a = $([]), e = $.resize = $.extend($.resize, {}), i, k = "setTimeout", j = "resize", d = j
					+ "-special-event", b = "delay", f = "throttleWindow";
	e[b] = 350;
	e[f] = true;
	$.event.special[j] = {
		setup : function(){
			if (!e[f] && this[k])
			{
				return false;
			}
			var l = $(this);
			a= a.add(l);
			$.data(this, d, {
					w : l.width(),
					h : l.height()
			});
			if (a.length === 1){
				g();
			}
		},
		teardown : function(){
			if (!e[f] && this[k])
			{
				return false;
			}
			var l = $(this);
			a = a.not(l);
			l.removeData(d);
			if (!a.length){
				clearTimeout(i)
			}
		},
		add : function(l){
			if (!e[f] && this[k])
			{
				return false;
			}
			var n;
			function m(s, o, p){
				var q = $(this), r = $.data(this, d);
				r.w = o !== c ? o : q.width();
				r.h = p !== c ? p : q.height();
				n.apply(this, arguments);
			}
			if ($.isFunction(l))
			{
				n = l;
				return m;
			}
			else
			{
				n = l.handler;
				l.handler = m;
			}
		}
	};
	function g(){
		i = h[k](function(){
			a.each(function(){
				var n = $(this), m = n.width(), l = n.height(), o = $.data(this, d);
				if (m !== o.w || l !== o.h)
				{
					n.trigger(j, [o.w = m, o.h =l]);
				}
			});
			g();
		}, e[b]);
	}
})(jQuery, this);

/* 扩展获取元素大小方法，使其支持获取隐藏元素大小 */
( function ( $ ){
$.fn.addBack = $.fn.addBack || $.fn.andSelf;

$.fn.extend({
	actual : function ( method, options ){
		// check if the jQuery method exist
		if( !this[ method ]){
			throw '$.actual => The jQuery method "' + method + '" you called does not exist';
		}

		var defaults = {
			absolute      : false,
			clone         : false,
			includeMargin : false
		};

		var configs = $.extend( defaults, options );

		var $target = this.eq( 0 );
		var fix, restore;

		if( configs.clone === true ){
			fix = function (){
				var style = 'position: absolute !important; top: -1000 !important; ';

				// this is useful with css3pie
				$target = $target.
				clone().
				attr( 'style', style ).
				appendTo( 'body' );
			};

			restore = function (){
				// remove DOM element after getting the width
				$target.remove();
			};
		}else{
			var tmp   = [];
			var style = '';
			var $hidden;

			fix = function (){
				// get all hidden parents
				$hidden = $target.parents().addBack().filter( ':hidden' );
				style   += 'visibility: hidden !important; display: block !important; ';

				if( configs.absolute === true ) style += 'position: absolute !important; ';

				// save the origin style props
				// set the hidden el css to be got the actual value later
				$hidden.each( function (){
					var $this = $( this );

					// Save original style. If no style was set, attr() returns undefined
					tmp.push( $this.attr( 'style' ));
					$this.attr( 'style', style );
				});
			};

			restore = function (){
				// restore origin style values
				$hidden.each( function ( i ){
					var $this = $( this );
					var _tmp  = tmp[ i ];

					if( _tmp === undefined ){
						$this.removeAttr( 'style' );
					}else{
						$this.attr( 'style', _tmp );
					}
				});
			};
		}

		fix();
		 // get the actual value with user specific methed
		 // it can be 'width', 'height', 'outerWidth', 'innerWidth'... etc
		 // configs.includeMargin only works for 'outerWidth' and 'outerHeight'
		var actual = /(outer)/.test( method ) ?
			$target[ method ]( configs.includeMargin ) :
			$target[ method ]();

		restore();
			// IMPORTANT, this plugin only return the value of the first element
			return actual;
		}
	});
})( jQuery );

/* IE8不支持placeholder属性,在此polyfill */
( function ( global ) {

  'use strict';

  var test = document.createElement('input');
  var nativeSupport = test.placeholder !== void 0;

  global.Placeholders = {
    nativeSupport: nativeSupport,
    disable: nativeSupport ? noop : disablePlaceholders,
    enable: nativeSupport ? noop : enablePlaceholders
  };

  if ( nativeSupport ) {
    return;
  }

  var validTypes = [
    'text',
    'search',
    'url',
    'tel',
    'email',
    'password',
    'number',
    'textarea'
  ];

  var badKeys = [27, 33, 34,35,36,37,38,39,40,8,46];

  var placeholderStyleColor = '#ccc !important';
  var placeholderClassName = 'placeholdersjs';
  var classNameRegExp = new RegExp('(?:^|\\s)' + placeholderClassName + '(?!\\S)');

  var ATTR_CURRENT_VAL = 'data-placeholder-value';
  var ATTR_ACTIVE = 'data-placeholder-active';
  var ATTR_INPUT_TYPE = 'data-placeholder-type';
  var ATTR_FORM_HANDLED = 'data-placeholder-submit';
  var ATTR_EVENTS_BOUND = 'data-placeholder-bound';
  var ATTR_OPTION_FOCUS = 'data-placeholder-focus';
  var ATTR_OPTION_LIVE = 'data-placeholder-live';
  var ATTR_MAXLENGTH = 'data-placeholder-maxlength';

  var UPDATE_INTERVAL = 100;
  var head = document.getElementsByTagName('head')[ 0 ];
  var root = document.documentElement;
  var Placeholders = global.Placeholders;
  var keydownVal;

  var inputs = document.getElementsByTagName('input');
  var textareas = document.getElementsByTagName('textarea');

  var hideOnInput = root.getAttribute(ATTR_OPTION_FOCUS) === 'false';
  var liveUpdates = root.getAttribute(ATTR_OPTION_LIVE) !== 'false';

  var styleElem = document.createElement('style');
  styleElem.type = 'text/css';

  var styleRules = document.createTextNode(
    '.' + placeholderClassName + ' {' +
      'color:' + placeholderStyleColor + ';' +
    '}'
  );

  if ( styleElem.styleSheet ) {
    styleElem.styleSheet.cssText = styleRules.nodeValue;
  } else {
    styleElem.appendChild(styleRules);
  }

  head.insertBefore(styleElem, head.firstChild);

  var placeholder;
  var elem;

  for ( var i = 0, len = inputs.length + textareas.length; i < len; i++ ) {

    elem = i < inputs.length ? inputs[ i ] : textareas[ i - inputs.length ];

    placeholder = elem.attributes.placeholder;

    if ( placeholder ) {

      placeholder = placeholder.nodeValue;

      if ( placeholder && inArray(validTypes, elem.type) ) {
        newElement(elem);
      }
    }
  }

  var timer = setInterval(function () {
    for ( var i = 0, len = inputs.length + textareas.length; i < len; i++ ) {
      elem = i < inputs.length ? inputs[ i ] : textareas[ i - inputs.length ];

      placeholder = elem.attributes.placeholder;

      if ( placeholder ) {

        placeholder = placeholder.nodeValue;

        if ( placeholder && inArray(validTypes, elem.type) ) {

          if ( !elem.getAttribute(ATTR_EVENTS_BOUND) ) {
            newElement(elem);
          }

          if (
            placeholder !== elem.getAttribute(ATTR_CURRENT_VAL) ||
            ( elem.type === 'password' && !elem.getAttribute(ATTR_INPUT_TYPE) )
          ) {

            if (
              elem.type === 'password' &&
              !elem.getAttribute(ATTR_INPUT_TYPE) &&
              changeType(elem, 'text')
            ) {
              elem.setAttribute(ATTR_INPUT_TYPE, 'password');
            }

            if ( elem.value === elem.getAttribute(ATTR_CURRENT_VAL) ) {
              elem.value = placeholder;
            }

            elem.setAttribute(ATTR_CURRENT_VAL, placeholder);
          }
        }
      } else if ( elem.getAttribute(ATTR_ACTIVE) ) {
        hidePlaceholder(elem);
        elem.removeAttribute(ATTR_CURRENT_VAL);
      }
    }

    if ( !liveUpdates ) {
      clearInterval(timer);
    }
  }, UPDATE_INTERVAL);

  addEventListener(global, 'beforeunload', function () {
    Placeholders.disable();
  });

  function noop() {}

  function safeActiveElement() {
    try {
      return document.activeElement;
    } catch ( err ) {}
  }

  function inArray( arr, item ) {
    for ( var i = 0, len = arr.length; i < len; i++ ) {
      if ( arr[ i ] === item ) {
        return true;
      }
    }
    return false;
  }

  function addEventListener( elem, event, fn ) {
    if ( elem.addEventListener ) {
      return elem.addEventListener(event, fn, false);
    }
    if ( elem.attachEvent ) {
      return elem.attachEvent('on' + event, fn);
    }
  }

  function moveCaret( elem, index ) {
    var range;
    if ( elem.createTextRange ) {
      range = elem.createTextRange();
      range.move('character', index);
      range.select();
    } else if ( elem.selectionStart ) {
      elem.focus();
      elem.setSelectionRange(index, index);
    }
  }

  function changeType( elem, type ) {
    try {
      elem.type = type;
      return true;
    } catch ( e ) {
      return false;
    }
  }

  function handleElem( node, callback ) {

    if ( node && node.getAttribute(ATTR_CURRENT_VAL) ) {
      callback(node);
    } else {

      var handleInputs = node ? node.getElementsByTagName('input') : inputs;
      var handleTextareas = node ? node.getElementsByTagName('textarea') : textareas;

      var handleInputsLength = handleInputs ? handleInputs.length : 0;
      var handleTextareasLength = handleTextareas ? handleTextareas.length : 0;

      var len = handleInputsLength + handleTextareasLength;
      var elem;
      for ( var i = 0; i < len; i++ ) {

        elem = i < handleInputsLength ?
          handleInputs[ i ] :
          handleTextareas[ i - handleInputsLength ];

        callback(elem);
      }
    }
  }

  function disablePlaceholders( node ) {
    handleElem(node, hidePlaceholder);
  }

  function enablePlaceholders( node ) {
    handleElem(node, showPlaceholder);
  }

  function hidePlaceholder( elem, keydownValue ) {

    var valueChanged = !!keydownValue && elem.value !== keydownValue;
    var isPlaceholderValue = elem.value === elem.getAttribute(ATTR_CURRENT_VAL);

    if (
      ( valueChanged || isPlaceholderValue ) &&
      elem.getAttribute(ATTR_ACTIVE) === 'true'
    ) {

      elem.removeAttribute(ATTR_ACTIVE);
      elem.value = elem.value.replace(elem.getAttribute(ATTR_CURRENT_VAL), '');
      elem.className = elem.className.replace(classNameRegExp, '');

      var maxLength = elem.getAttribute(ATTR_MAXLENGTH);
      if ( parseInt(maxLength, 10) >= 0 ) {
        elem.setAttribute('maxLength', maxLength);
        elem.removeAttribute(ATTR_MAXLENGTH);
      }

      var type = elem.getAttribute(ATTR_INPUT_TYPE);
      if ( type ) {
        elem.type = type;
      }

      return true;
    }

    return false;
  }

  function showPlaceholder( elem ) {

    var val = elem.getAttribute(ATTR_CURRENT_VAL);

    if ( elem.value === '' && val ) {

      elem.setAttribute(ATTR_ACTIVE, 'true');
      elem.value = val;
      elem.className += ' ' + placeholderClassName;

      var maxLength = elem.getAttribute(ATTR_MAXLENGTH);
      if ( !maxLength ) {
        elem.setAttribute(ATTR_MAXLENGTH, elem.maxLength);
        elem.removeAttribute('maxLength');
      }

      var type = elem.getAttribute(ATTR_INPUT_TYPE);
      if ( type ) {
        elem.type = 'text';
      } else if ( elem.type === 'password' && changeType(elem, 'text') ) {
        elem.setAttribute(ATTR_INPUT_TYPE, 'password');
      }

      return true;
    }

    return false;
  }

  function makeFocusHandler( elem ) {
    return function () {

      if (
        hideOnInput &&
        elem.value === elem.getAttribute(ATTR_CURRENT_VAL) &&
        elem.getAttribute(ATTR_ACTIVE) === 'true'
      ) {

        moveCaret(elem, 0);
      } else {

        hidePlaceholder(elem);
      }
    };
  }

  function makeBlurHandler( elem ) {
    return function () {
      showPlaceholder(elem);
    };
  }

  function makeSubmitHandler( form ) {
    return function () {

        disablePlaceholders(form);
    };
  }

  function makeKeydownHandler( elem ) {
    return function ( e ) {
      keydownVal = elem.value;

      if (
        elem.getAttribute(ATTR_ACTIVE) === 'true' &&
        keydownVal === elem.getAttribute(ATTR_CURRENT_VAL) &&
        inArray(badKeys, e.keyCode)
      ) {
        if ( e.preventDefault ) {
            e.preventDefault();
        }
        return false;
      }
    };
  }

  function makeKeyupHandler(elem) {
    return function () {
      hidePlaceholder(elem, keydownVal);

      if ( elem.value === '' ) {
        elem.blur();
        moveCaret(elem, 0);
      }
    };
  }

  function makeClickHandler(elem) {
    return function () {
      if (
        elem === safeActiveElement() &&
        elem.value === elem.getAttribute(ATTR_CURRENT_VAL) &&
        elem.getAttribute(ATTR_ACTIVE) === 'true'
      ) {
        moveCaret(elem, 0);
      }
    };
  }

  function newElement( elem ) {

    var form = elem.form;
    if ( form && typeof form === 'string' ) {

      form = document.getElementById(form);

      if ( !form.getAttribute(ATTR_FORM_HANDLED) ) {
        addEventListener(form, 'submit', makeSubmitHandler(form));
        form.setAttribute(ATTR_FORM_HANDLED, 'true');
      }
    }

    addEventListener(elem, 'focus', makeFocusHandler(elem));
    addEventListener(elem, 'blur', makeBlurHandler(elem));

    if (hideOnInput) {
      addEventListener(elem, 'keydown', makeKeydownHandler(elem));
      addEventListener(elem, 'keyup', makeKeyupHandler(elem));
      addEventListener(elem, 'click', makeClickHandler(elem));
    }

    elem.setAttribute(ATTR_EVENTS_BOUND, 'true');
    elem.setAttribute(ATTR_CURRENT_VAL, placeholder);

    if ( hideOnInput || elem !== safeActiveElement() ) {
      showPlaceholder(elem);
    }
  }

}(this) );
( function ( $, global ) {

  'use strict';

  var originalValFn = $.fn.val;
  var originalPropFn = $.fn.prop;

  if ( !global.Placeholders.nativeSupport ) {

    $.fn.val = function ( val ) {
      var originalValue = originalValFn.apply(this, arguments);
      var placeholder = this.eq(0).data('placeholder-value');
      if (
        val === undefined &&
        this.eq(0).data('placeholder-active') &&
        originalValue === placeholder
      ) {
        return '';
      }
      return originalValue;
    };

    $.fn.prop = function ( name, val ) {
      if (
        val === undefined &&
        this.eq(0).data('placeholder-active') &&
        name === 'value'
      ) {
        return '';
      }
      return originalPropFn.apply(this, arguments);
    };
  }
}(jQuery, this) );

/* find & findIndex Polyfill , Witch unsupport in IE12 or below*/
/*
* USAGE: 
* arr.find(callback[, thisArg])
*		callback(element, index, array)
*		return first-target-element-value or undefined 
*
* arr.findIndex(callback[, thisArg])
*		callback(element, index, array)
*		return first-target-element-index or -1
*/
if (!Array.prototype.find) {
	Object.defineProperty(Array.prototype, 'find', {
		value: function(predicate) {
			// 1. Let O be ? ToObject(this value).
			if (this == null) {
				throw new TypeError('"this" is null or not defined');
			}

			var o = Object(this);

			// 2. Let len be ? ToLength(? Get(O, "length")).
			var len = o.length >>> 0;

			// 3. If IsCallable(predicate) is false, throw a TypeError exception.
			if (typeof predicate !== 'function') {
				throw new TypeError('predicate must be a function');
			}

			// 4. If thisArg was supplied, let T be thisArg; else let T be undefined.
			var thisArg = arguments[1];

			// 5. Let k be 0.
			var k = 0;

			// 6. Repeat, while k < len
			while (k < len) {
				// a. Let Pk be ! ToString(k).
				// b. Let kValue be ? Get(O, Pk).
				// c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
				// d. If testResult is true, return kValue.
				var kValue = o[k];
				if (predicate.call(thisArg, kValue, k, o)) {
					return kValue;
				}
				// e. Increase k by 1.
				k++;
			}

			// 7. Return undefined.
			return undefined;
		}
	});
}
if (!Array.prototype.findIndex) {
	Object.defineProperty(Array.prototype, 'findIndex', {
		value: function(predicate) {
			// 1. Let O be ? ToObject(this value).
			if (this == null) {
				throw new TypeError('"this" is null or not defined');
			}

			var o = Object(this);

			// 2. Let len be ? ToLength(? Get(O, "length")).
			var len = o.length >>> 0;

			// 3. If IsCallable(predicate) is false, throw a TypeError exception.
			if (typeof predicate !== 'function') {
				throw new TypeError('predicate must be a function');
			}

			// 4. If thisArg was supplied, let T be thisArg; else let T be undefined.
			var thisArg = arguments[1];

			// 5. Let k be 0.
			var k = 0;

			// 6. Repeat, while k < len
			while (k < len) {
				// a. Let Pk be ! ToString(k).
				// b. Let kValue be ? Get(O, Pk).
				// c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
				// d. If testResult is true, return k.
				var kValue = o[k];
				if (predicate.call(thisArg, kValue, k, o)) {
					return k;
				}
				// e. Increase k by 1.
				k++;
			}

			// 7. Return -1.
			return -1;
		}
	});
}