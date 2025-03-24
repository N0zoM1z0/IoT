function Basic()
{
	this.w = window;
	this.routerAlive = false;
	this.head = document.getElementsByTagName("head")[0];
	this.d = document;
	/* 如果是simulator页面，则$.local强制为true */
	if (typeof bWebUISimulator != "undefined" && bWebUISimulator === true)
	{
		this.local = true;
	}
	else
	{
	this.local = (location.protocol == "file:");
	}
	this.isIE = (navigator.userAgent.indexOf("IE") >= 0);
	this.domainUrl = "http://192.168.1.1";
	this.time = 1000;
	this.explorerTag = 0;
	this.hostip = "";
	this.session = "";
	this.pwd = "";
	this.httpTag = "http://";
	this.ajaxAsyn = true;
	this.ajaxSyn = false;

	this.isArray = function(obj)
	{
		return Object.prototype.toString.call(obj) === '[object Array]';
	};

	this.getExplorer = function ()
	{
		var nv = navigator.userAgent;

		if (nv.indexOf("IE 6.0") > 0)
		{
			this.explorerTag = 6;
		}
		else if (nv.indexOf("IE 7.0") > 0)
		{
			this.explorerTag = 7;
		}
	};

	this.transText = function(text)
	{
		if (text.length > 0)
		{
			text = text.substring(text.indexOf("\r\n") + 2);
			try
			{
				return eval("("+text+")");
			}catch(ex){return ""}
		}
	};

	this.id = function (idStr)
	{
		return document.getElementById(idStr);
	};

	this.changeDomain = function(domain)
	{
		var urlHeaderTag = this.httpTag;
		this.domainUrl = domain.indexOf(urlHeaderTag) >= 0?(domain):(urlHeaderTag+domain);
	};

	this.initUrl = function ()
	{
		if (!this.local)
		{
			var url = location.href;
			var pos = url.indexOf("?");

			if (pos > 0)
			{
				url = url.substring(0, pos);
			}

			this.domainUrl = url;
		}
	};

	this.objInitNull = function (obj)
	{
		for(var property in obj)
		{
			if (typeof obj[property] == "object")	//是对象
			{
				this.arguments.callee(obj[property]);
			}
			else	//不是对象,
			{
				obj[property] = "";
			}
		}
	};

	this.objSet = function(obj, val)
	{
		if (this.isArray(val))
		{
			var n = 0;
			for(var property in obj)
			{
				obj[property] = val[n++];
			}
		}
		else
		{
			for(var property in obj)
			{
				obj[property] = val;
			}
		}
	};

	this.objCopy = function(target, srcObj)
	{
		var temp;
		for(var porperty in target)
		{
			temp = srcObj[porperty];
			if (temp != undefined)
			{
				target[porperty] = temp;
			}
		}
	};

	this.encodePara = function(val)
	{
		val = encodeURL(val.toString());

		return val;
	};
}

function WebAjax()
{
	/* 如果是simulator页面，则$.local强制为true */
	if (typeof bWebUISimulator != "undefined" && bWebUISimulator === true)
	{
		this.local = true;
	}
	else
	{
	this.local = (location.protocol == "file:");
	}
	this.isIE = (navigator.userAgent.indexOf("IE") >= 0);
	this.ajaxTimeout = 2000;
	this.sessionKey = "stok";
	this.externDataParseFunc = new Function();

	this.result =
	{
		errorno:0,
		data:"",
		timeout:true
	};

	this.initResult = function (result)
	{
		this.result.errorno = 0;
		this.result.data = "";
		this.result.timeout = true;
	};

	this.setDataParseFunc = function(func)
	{
		this.externDataParseFunc = func;
	};

	this.changeAsynTime = function(time)
	{
		this.ajaxTimeout = time;
	};

	this.getValueFromUrl = function(url, str)
	{
		var value = "", pos;

		str += "=";
		pos = url.indexOf(str);
		if (pos >= 0)
		{
			var substr = url.substring(pos+str.length);
			pos = substr.indexOf("&");
			pos = pos > 0?pos:substr.length;
			value = substr.substring(0, pos);
		}

		return value;
	};

	this.orgURL = function(url)
	{
		var index;

		if ($.session && $.session.length != 0)
		{
			index = url.indexOf("..");
			if (index >= 0)
			{
				url = url.substring(index + 2);
			}

			url = "/stok=" + encodeURIComponent($.session) + url;
		}

		return url;
	};

	this.request = function(url, data, method, asyn, callback, timeout, name, password)
	{
		var xhr = window.ActiveXObject?new ActiveXObject("Microsoft.XMLHTTP"):new XMLHttpRequest();
		var responseText, setTime, asynTime, isAjaxTimeout = false;
		var thisObj = this, response = false;

		this.initResult(thisObj.result);

		function getHandleCode(text)
		{
			var handleCode, data, obj;

			try
			{
				obj = JSON.parse(text,
					function(k, v){
						var val = v;

						if (typeof val === "string")
						{
							try
							{
								val = decodeURIComponent(val);
							}catch(ex){}
						}

						return val;
					}
				);
			}
			catch(ex)
			{
				obj = null;
			}

			if (obj == null)
			{
				handleCode = ENONE;
				data = text;
			}
			else
			{
				handleCode = obj[ERR_CODE];
				data = obj.data;
			}

			return [handleCode, data];
		}

		xhr.onreadystatechange = function ()
		{
			if (true == isAjaxTimeout)
			{
				return;
			}

			if ((xhr.readyState == 4) && (true === $.local || xhr.status >= 100))
			{
				response = true;
				thisObj.result.timeout = false;
				responseText = xhr.responseText;
				if (responseText)
				{
					thisObj.result.data = responseText;
				}

				var relArr = getHandleCode(responseText);

				thisObj.result.errorno = relArr[0];
				thisObj.result.data = relArr[1];

				/* 判断是否有回调函数 */
				if (callback != undefined)
				{
					callback(thisObj.result);
				}

				return true;
			}
		};

		try
		{
			if ((name != undefined) && (password != undefined))
			{
				xhr.open(method, url, asyn, name, password);
			}
			else
			{
				xhr.open(method, url, asyn);
			}

			if (this.isIE == true)
			{
				if (typeof bWebUISimulator == "undefined")
				{
				xhr.setRequestHeader("If-Modified-Since","0");
				}
			}

			if (data != undefined)
			{
				xhr.send(data);
			}
			else
			{
				xhr.send(null);
			}
		}catch(ex){}
	};
}

function Load()
{
	Basic.call(this);
	WebAjax.call(this);
	this.asyn = true;
	this.syn = false;
	this.detectTime = 1000;
	this.div = document.createElement("div");
	this.externResizefunc = new Function();
	this.externJSP = new Function();
	this.externPageHandle = new Function();
	this.pageTickArray = [];
	this.scriptArray = [];
	this.unAuthCode = 401;
	this.httpOK = 200;

	this.setTimeout = function (func, time)
	{
		var handle = window.setTimeout(func, time);

		this.pageTickArray.push(handle);

		return handle;
	};
	function empty(node)
	{
		/* for the bug of MSIE 6.0 */
		if (node)
		{
			node.innerHTML = "";
			return;
		}
	};

	this.addScript = function (text)
	{
		if (text && /\S/.test(text))
		{
			var script = this.d.createElement("script");
			script.type = "text/javascript";

			if (script.text === undefined)
			{
				script.appendChild(this.d.createTextNode(text));
			}
			else
			{
				script.text = text;
			}
			this.head.insertBefore(script, this.head.firstChild);
			this.head.removeChild(script);
		}
	};

	this.getNodeArray = function (nodes, callBack)
	{
		var pArray = [];
		for (var i =0, j = nodes.length; i < j; i++)
		{
			pArray[i] = nodes[i];
		}
		callBack(pArray);
	};

	this.addDomNode = function(container, data, options)
	{
		var thisObj = this;
		var opts = options || {};

		this.div.innerHTML = "div" + data;
		this.div.removeChild(this.div.firstChild);
		this.getNodeArray(this.div.childNodes,
		function (nodeArray)
		{
			empty(container);
			if (opts.isNoClearTimeout !== true)
			{
				for(var i = 0, j = thisObj.pageTickArray.length; i < j; i++)
				{
					try
					{
						window.clearTimeout(thisObj.pageTickArray[i]);
					}catch(ex){}
				}
			}

			var scriptArray = [];
			for(var i =0, j = nodeArray.length; i < j; i++)
			{
				if ((nodeArray[i].nodeType == 1)&&(nodeArray[i].nodeName.toLowerCase() === "script"))
				{
					scriptArray.push(nodeArray[i]);
				}
				else
				{
					container.appendChild(nodeArray[i]);
				}
			}

			for(var i =0, j = scriptArray.length; i < j; i++)
			{
				thisObj.addScript(scriptArray[i].text || scriptArray[i].textContent || scriptArray[i].innerHTML || "");
			}
		});
	};

	this.pageResize = function()
	{
		this.externResizefunc();
	};

	this.setPageResize = function(func)
	{
		this.externResizefunc = func;
	};

	this.setexternJSP = function(func)
	{
		this.externJSP = func;
	};

	this.setExternPageHandle = function(func){
		this.externPageHandle = func;
	};

	this.append = function (container, data, options)
	{
		if (container&&(container.nodeType == 1)&&(typeof data === "string"))
		{
			this.addDomNode(container, data, options);
			this.pageResize();
		}
	};

	this.trimEndSlashes = function (urlStr)
	{
		return urlStr.replace(/\/+$/g,'');
	}

	this.detectWidthImg = function(callBack)
	{
		var img = new Image();

		img.onload = function(){
			callBack();
		};

		img.src = this.trimEndSlashes(this.domainUrl) + imgDetectPathStr + "?requence=" + Math.random();
	}

	this.detect = function (detectHandler)
	{
		if (true == isIETenLess)
		{
			this.detectWidthImg(detectHandler);
		}
		else
		{
			this.request((this.trimEndSlashes(this.domainUrl) + detectPathStr + "?requence=" + Math.random()), undefined, "get", this.asyn, detectHandler);
		}
	};

	this.loadHand = function(result, id, options){
		var dialogCount, dialogObj, self = this;
		var opts = options || {};

		/* replace JSP str */
		str = this.externJSP(result.data);
		if (str != undefined)
		{
			result.data = str;
		}

		/* added by WuWeier 2013-12-26, when session is out of date, jump to login page.*/
		if (this.unAuthCode == result.errorno)
		{
			return;
		}

		/* TODO: 之后需要改进 */
		function closeDialog(){
			if (dialogCount != 0)
			{
				dialogObj = Dialog.prototype.state.dialogArr[Dialog.prototype.state.dialogArr.length - 1].obj;
				dialogObj.hide(function(){
					dialogCount = Dialog.prototype.state.count;
					closeDialog();
				});
			}
			else
			{
				callback();
			}
		}

		function callback(){
			if (opts.isDialogRender !== true)
			{
				$("div.dialogBox").not(".constant").remove();
			}
			self.append(self.id(id), result.data, options);

			/* 此处进行页面集中的扩展处理 */
			try
			{
				self.externPageHandle();
			}catch(ex){};
		}

		/* added by ZhangWenhao 2019-01-27, clear up all unconstant-dialog */
		if (opts.isDialogRender !== true &&(dialogCount = Dialog.prototype.state.count) != 0)
		{
			closeDialog();
		}else
		{
			callback();
		}
	};

	this.getLgResult = function(result){
		var tagStr = result.data;

		if (/\r\n<!--(\d{3})-->\r\n/gi.test(tagStr) && RegExp["$1"] != this.httpOK)
		{
			result.errorno = RegExp["$1"];
			if (/var authInfo = new Array("([a-zA-Z])","(\d{1,})");/g.test(result.data))
			{
				result.data = RegExp["$1"] + " " + RegExp["$2"];
			}

			return true;
		}

		return false;
	};

	/* 刷新session */
	this.refreshSession = function(url)
	{
		this.request(url, undefined, "get", this.syn);

		/* 处理未通过认证的情况 */
		if (this.result.errorno == EUNAUTH)
		{
			$.parseAuthRlt(this.result.data);
		}
	};

	this.getUnAuthHandle = function(url, async, callBack)
	{
		if (EUNAUTH == $.result.errorno)
		{
			$.parseAuthRlt($.result.data);

			/* 如果没有密码或者是回复出厂设置，则直接显示登录页面 */
			if ((usernameSupport && (null == $.usr || 0 == $.usr.length)) ||
				null == $.pwd || 0 == $.pwd.length || ESYSRESET == $.authRltObj.code)
			{
				window.setTimeout(function()
				{
					$.loginErrHandle();
				}, 0);

				return;
			}

			function authHandle(err_code){
				if (ENONE == err_code)
				{
					/* 续约成功后再次发送中断的请求 */
					if (true == async)
					{
						$.request($.orgURL(url), undefined, "get", async, function(result){
							if (ENONE != result.errorno)
							{
								$.parseAuthRlt(result.data);
								$.loginErrHandle();
							}
							else
							{
								callBack(result);
							}
						});
					}
					else
					{
						$.request($.orgURL(url), undefined, "get", async, undefined);
						if (ENONE != $.result.errorno)
						{
							$.parseAuthRlt($.result.data);
							$.loginErrHandle();
						}
						else
						{
							callBack($.result);
						}

						return true;
					}
				}
				else
				{
					/* 再次认证出错后，弹出认证框 */
					window.setTimeout(function()
					{
						$.loginErrHandle();
					}, 0);
				}
			}

			if (usernameSupport)
			{
				$.authUsrPwd($.usr, $.pwd, authHandle);
			}
			else
			{
				$.auth($.pwd, authHandle);
			}
		}
	};

	/* 加载页面 */
	this.load = function (url, callback, id, options)
	{
		var timeout = false;
		var data, str;
		var thisObj = this;

		function handler(result)
		{
			timeout = result.timeout;
			if (!timeout)
			{
				/* replace JSP str */
				str = thisObj.externJSP(result.data);
				if (str != undefined)
				{
					result.data = str;
				}

				thisObj.loadHand(result, id, options);
			}

			if (callback)
			{
				callback(result);
			}
		}

		if (this.local || callback != undefined)
		{
			this.loadAsyn(url, this.ajaxTimeout, function(result){
				/* 处理未通过认证的情况 */
				if (result.errorno == EUNAUTH)
				{
					/* 设置上下文环境参数 */
					setLoadPage(url, id);

					/* 进入未认证错误处理流程 */
					thisObj.getUnAuthHandle(url, thisObj.asyn, handler);
				}
				else if (result.errorno == ENONE)
				{
					handler(result);
				}
			});
		}
		else
		{
			this.request(this.orgURL(url), undefined, "get", this.syn);

			/* 处理未通过认证的情况 */
			/* 判断错误类型 */
			if (this.result.errorno == EUNAUTH)
			{
				/* 设置上下文环境参数 */
				setLoadPage(url, id);

				/* 进入未认证错误处理流程 */
				this.getUnAuthHandle(url, this.syn, handler);
			}
			else if (this.result.errorno == ENONE)
			{
				handler(this.result);
			}
		}

		return timeout;
	};

	this.loadAsyn = function(url, timeoutPage, callback)
	{
		this.request(this.orgURL(url), undefined, "get", this.asyn, callback, timeoutPage);
	};
}
