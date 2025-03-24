function NiceScroll(options)
{
	this.taId = options.targetId;
	this.hrzLine = options.hrzLine;	// 是否需要显示底线
	this.ta = id(this.taId);
	if (this.ta.nodeType != 1)
	{
		return null;
	}
	this.st = el("label");		// scroll tip
	this.sb = el("div");		// scroll bar

	/* vertical scroll options */
	this.sbH = 0;
	this.scH = 0;
	this.stH = 0;
	//this.avg = 0;
	this.sbcH = 0;
	//this.n = 20;

	/* horizontal scroll options */
	this.sbW = 0;
	this.scW = 0;
	this.stW = 0;
	this.sbcW = 0;

	this.enabled = true;
	this.mousePos = null;
	this.isScroll = false;
	this.onSb = false;
	this.show = false;
	this.checkTt = null;
	this.isVertical = typeof options.vertical != "undefined" ? options.vertical === true : true;

	/* 滚动条动画效果相关 */
	this.wtId = null;			//动画timer的ids
	this.wtCounter = 0;			//timer循环次数
	this.wSpeed = 0;			//timer执行一次滚动条移动的距离
	this.woSpeed = 0;			//用于检测是否反向滚动
	/* endof 滚动条动画效果相关 */

	if (this.isVertical)
	{
		/* scrollBar的相关样式 */
		this.sbStyle = {
			"position":"absolute",
			"zIndex":options.zIndex || 1001,
			"width":"8px",
			"padding":"4px"
		};

		/* scrollTip的相关样式 */
		this.stStyle = {
			"width":"8px",
			"display":"inline-block",
			"background":"#cacbcc",
			"borderRadius":"4px",
			"position":"relative",
			"cursor":"pointer"
		};
	}
	else
	{
		/* scrollBar的相关样式 */
		this.sbStyle = {
			"position":"absolute",
			"zIndex":options.zIndex || 1001,
			"height":"8px",
			"padding":"4px"
		};

		/* scrollTip的相关样式 */
		this.stStyle = {
			"height":"8px",
			"display":"inline-block",
			"background":"#cacbcc",
			"borderRadius":"4px",
			"position":"relative",
			"cursor":"pointer"
		};
	}

	this.hzStyle = {
		"borderBottom":"1px solid #fff",
		"borderImage":"-webkit-linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(230,230,230,0.56) 31%, rgba(230,230,230,0.85) 71%, rgba(255,255,255,0) 99%) 0",
		"borderImage":"-moz-linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(230,230,230,0.56) 31%, rgba(230,230,230,0.85) 71%, rgba(255,255,255,0) 99%) 0",
		"borderImage":"linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(230,230,230,0.56) 31%, rgba(230,230,230,0.85) 71%, rgba(255,255,255,0) 99%) 0"
	};

	/* scrollTip的opacity */
	this.stOpacity = 0.1;

	if (typeof this.init != "function")
	{
		NiceScroll.prototype.init = function(){
			var obj = this;
			this.sb.id = this.taId + "niceScrollSb" + new Date().getTime();

			setStyle(this.sb, {"backgroundColor":(this.sbStyle.background || "transparent")});

			/* 将scrollTip添加到scrollBar中 */
			this.sb.appendChild(this.st);

			/* 将scrollBar添加到body中 */
			document.body.appendChild(this.sb);

			/* 设置scrollBar和scrollTip的静态样式 */
			setStyle(this.sb, this.sbStyle);
			setStyle(this.st, this.stStyle);

			/* 设置scrollBar和scrollTip的动态样式 */
			this._reset(true);

			/* 添加底部分割线 */
			this.hrzLine&&setStyle(this.ta, this.hzStyle);

			/* 如果是PC浏览器设置target的overflow为hidden */
			if (false == OS.portable)
			{
				setStyle(this.ta, {"overflow":"hidden"});
			}
			else
			{
				setStyle(this.ta, {"overflow":"scroll"});
			}

			this._shSb();
			this._bind();
			window.setTimeout(function(){
				obj.checkTt = window.setTimeout(arguments.callee, 10);
				obj._check();
			}, 100);
		};

		/* 设置scrollBar的样式 */
		NiceScroll.prototype.scrollBarSet = function(styles){
			if (typeof styles == "object")
			{
				for(var propy in styles)
				{
					this.sbStyle[propy] = styles[propy];
				}
			}
		};

		/* 设置scrollTip的样式 */
		NiceScroll.prototype.scrollTipSet = function(styles){
			if (typeof styles == "object")
			{
				for(var propy in styles)
				{
					this.stStyle[propy] = styles[propy];
				}
			}
		};

		/* 设置scrollTip的opacity */
		NiceScroll.prototype.scrollTipOpacity = function(opacity){
			this.stOpacity = opacity;
		};

		/* 滚动到指定的位置 */
		NiceScroll.prototype.scrollTo = function(hPos){
			var scollTop = parseInt(hPos);

			if (true == isNaN(scollTop))
			{
				return false;
			}

			/* 设置scrollTip初始样式 */
			this.ta.scrollTop = scollTop;
		};

		/* 动态设置scrollBar和scrollTip的样式，主要是位置 */
		NiceScroll.prototype._reset = function(init){
			var pos = $(this.ta).offset();
			var width = this.ta.offsetWidth;
			var height = this.ta.offsetHeight;
			var sHeight = this.ta.scrollHeight;
			var sWidth = this.ta.scrollWidth;
			var bdTWidth = parseFloat(getNodeDefaultView(this.ta, "borderTopWidth")) || 0;
			var bdBWidth = parseFloat(getNodeDefaultView(this.ta, "borderBottomWidth")) || 0;
			var bdRWidth = parseFloat(getNodeDefaultView(this.ta, "borderRightWidth")) || 0;
			var bdLWidth = parseFloat(getNodeDefaultView(this.ta, "borderLeftWidth")) || 0;

			this.scH = sHeight - height + bdTWidth + bdBWidth;
			this.stH = parseInt(height/sHeight*height*0.7);
			this.sbcH = height - (this.stH + 2);
			//this.avg = this.scH/this.sbcH;

			this.scW = sWidth - width + bdLWidth + bdRWidth;
			this.stW = parseInt(width/sWidth*width*0.7);
			this.sbcW = width - (this.stW + 2);

			if (this.isVertical)
			{
				if (sHeight - height <= 0)
				{
					setStyle(this.sb, {"visibility":"hidden", "top":"-9999px"});
					this.show = false;
					this.hrzLine&&(this.ta.style.borderImageSlice = "0");

					return;
				}
				else
				{
					this.show = true;
					setStyle(this.sb, {"visibility":"visible"});
					this.hrzLine&&(this.ta.scrollTop == 0)&&(this.ta.style.borderImageSlice = "1");
				}

				/* 设置scrollBar初始样式 */
				setStyle(this.sb, {"top":pos.top + bdTWidth + "px",
								   "height":height - 8 + "px",
								   "left":pos.left + width - bdRWidth - parseInt(this.sb.offsetWidth) + "px"});

				/* 设置scrollTip初始样式 */
				setStyle(this.st, {"top":(this.ta.scrollTop/this.scH)*this.sbcH + "px",
								   "height":this.stH - 8 + "px"});
			}
			else
			{
				if (sWidth - width <= 0)
				{
					setStyle(this.sb, {"visibility":"hidden", "top":"-9999px"});
					this.show = false;

					return;
				}
				else
				{
					this.show = true;
					setStyle(this.sb, {"visibility":"visible"});
				}

				/* 设置scrollBar初始样式 */
				setStyle(this.sb, {"left":pos.left + bdLWidth + "px",
								   "width":width - 8 + "px",
								   "top":pos.top + height - bdBWidth - parseInt(this.sb.offsetHeight) + "px"});

				/* 设置scrollTip初始样式 */
				setStyle(this.st, {"left":(this.ta.scrollLeft/this.scW)*this.sbcW + "px",
								   "width":this.stW - 8 + "px"});
			}
			/* fadeTo在此处会导致内存泄漏 */
			/*if (this.isScroll == false)
			{
				$("#"+this.sb.id).fadeTo(1000, this.stOpacity);
			}*/
		};

		NiceScroll.prototype._bind = function(){
			var obj = this;
			if (document.attachEvent)
			{
				this.isVertical && this.ta.attachEvent("onmousewheel",  function(event){
					event = event || window.event;obj._scroll(event)});
				this.sb.attachEvent("onmousewheel",  function(event){
					event = event || window.event;obj._scroll(event)});
			}
			else
			{
				this.isVertical && this.ta.addEventListener("mousewheel",
					function(event){event = event || window.event;obj._scroll(event)}, false);
				this.isVertical && this.ta.addEventListener("DOMMouseScroll",
					function(event){event = event || window.event;obj._scroll(event)}, false);
				this.sb.addEventListener("mousewheel",
					function(event){event = event || window.event;obj._scroll(event)}, false);
				this.sb.addEventListener("DOMMouseScroll",
					function(event){event = event || window.event;obj._scroll(event)}, false);
			}

			/* 触屏移动的处理函数 */
			function touchMoveHd(event)
			{
				event = event || window.event;
				var mousePos = {x:event.touches[0].clientX, y:event.touches[0].clientY};

				if (obj.isVertical)
				{
					var len = mousePos.y - obj.mousePos.y;
					var top = parseFloat(obj.st.style.top) - len;
					if (top >= obj.sbcH)
					{
						top = obj.sbcH;
						obj.hrzLine&&(obj.ta.style.borderImageSlice = "0");
					}
					else
					{
						top = top <= 0?0:top;
						obj.hrzLine&&(obj.ta.style.borderImageSlice = "1");
					}
					obj.st.style.top = top + "px";
				}
				else
				{
					var len = mousePos.x - obj.mousePos.x;
					var left = parseFloat(obj.st.style.left) - len;
					if (left >= obj.sbcW)
					{
						left= obj.sbcW;
					}
					else
					{
						left = left <=0 ? 0 : left;
					}
					obj.st.style.left = left + "px";
				}

				obj.mousePos.x = mousePos.x;
				obj.mousePos.y = mousePos.y;
				obj.isScroll = true;

				if (false == OS.portable)
				{
					if (obj.isVertical)
					{
						obj.ta.scrollTop = obj.scH*(top/obj.sbcH);
					}
					else
					{
						obj.ta.scrollLeft = obj.scW*(left/obj.sbcW);
					}
					eventPreventDefault(event);
				}

				clearSelection(event);
			}

			/* 触屏结束移动的处理函数 */
			function touchEndHd(event)
			{
				detachEvnt(document, "touchmove", touchMoveHd);
				detachEvnt(document, "touchend", touchEndHd);

				if (obj.onSb == false)
				{
					obj.isScroll = false;
				}
			}

			/* 触屏移动开始的处理函数 */
			attachEvnt(this.ta, "touchstart", function(event){
				event = event || window.event;
				obj.mousePos = {x:event.touches[0].clientX, y:event.touches[0].clientY};
				attachEvnt(document, "touchmove", touchMoveHd);
				attachEvnt(document, "touchend", touchEndHd);
			});

			/* 对滑动块绑定鼠标函数 */
			this.st.onmousedown = function(event){
				obj.mousePos = getMousePos(event);
				document.onmouseup = function(event){
					document.onmousemove = null;
					document.onmouseup = null;
					if (obj.onSb == false)
					{
						obj.isScroll = false;
					}
				};
				document.onmousemove = function(event){
					var mousePos = getMousePos(event);

					if (obj.isVertical)
					{
						var len = mousePos.y - obj.mousePos.y;
						var top = parseFloat(obj.st.style.top) + len;
						if (top >= obj.sbcH)
						{
							top = obj.sbcH;
							obj.hrzLine&&(obj.ta.style.borderImageSlice = "0");
						}
						else
						{
							top = top <= 0?0:top;
							obj.hrzLine&&(obj.ta.style.borderImageSlice = "1");
						}
						obj.st.style.top = top + "px";

						obj.ta.scrollTop = obj.scH*(top/obj.sbcH);
					}
					else
					{
						var len = mousePos.x - obj.mousePos.x;
						var left = parseFloat(obj.st.style.left) + len;
						if (left >= obj.sbcW)
						{
							left = obj.sbcW;
						}
						else
						{
							left = left <= 0?0:left;
						}
						obj.st.style.left = left + "px";

						obj.ta.scrollLeft = obj.scW*(left/obj.sbcW);
					}

					obj.mousePos.x = mousePos.x;
					obj.mousePos.y = mousePos.y;
					obj.isScroll = true;
					clearSelection(event);
				};
			};

			/* 在scrollBar上绑定鼠标事件 */
			$("#"+this.sb.id)[0].onmouseover = function(event){
				event = event || window.event;
				obj.onSb = true;
				if (obj.show == true)
				{
					obj._scrollShow(event);
				}
			};
			$("#"+this.sb.id)[0].onmouseout = function(){
				obj.onSb = false;
				obj.isScroll = false;
			};
		};

		NiceScroll.prototype._close = function(){
			this.sb.style.visibility = "hidden";
			this.enabled = false;
		};

		NiceScroll.prototype._open = function(){
			this.enabled = true;
		};

		NiceScroll.prototype._shSb = function(){
			if (this.ta.style.display == "none" ||
				this.ta.visibility == "hidden")
			{
				this.sb.style.visibility = "hidden";
			}
			else
			{
				this.sb.style.visibility = "visible";
			}
		};

		NiceScroll.prototype._check = function(){
			if (id(this.taId) == null)
			{
				window.clearTimeout(this.checkTt);
				this.sb.parentNode.removeChild(this.sb);
				return;
			}
			if (this.enabled == false)
			{
				return;
			}

			if (checkInHorize(this.ta) == false)
			{
				this.sb.style.display = "none";
				return;
			}
			else
			{
				this.sb.style.display = "block";
			}

			if (this.isVertical)
			{
				if (parseInt(this.ta.offsetHeight) <= 0)
				{
					this.sb.style.visibility = "hidden";
				}
			}
			else
			{
				if (parseInt(this.ta.offsetWidth) <= 0)
				{
					this.sb.style.visibility = "hidden";
				}
			}
			this._reset();
		};

		NiceScroll.prototype._getWheelDelta = function(event){
			event = event || window.event;
			if (event.wheelDelta)
			{
				return window.opera&&window.opera.version < 9.5?-event.wheelDelta:event.wheelDelta;
			}
			else
			{
				return -event.detail*40;
			}
		};

		NiceScroll.prototype._wheelAnimate = function(speed, counter){
			var obj = this, oppsite = false;
			if (this.wtId)	/* 连续触发 */
			{
				oppsite = (this.woSpeed ^ speed) < 0;
				this.wtCounter = oppsite ? counter : (this.wtCounter + counter < 50 ? this.wtCounter + counter : 50);
				this.wSpeed = oppsite? speed : this.wSpeed*1.05;		/* 加速 */
				return;
			}
			this.wtCounter = counter;
			this.woSpeed = this.wSpeed = speed;

			(function(){
				var temp = 0;

				obj.wtId = window.setTimeout(arguments.callee, 5);
				if (obj.wtCounter < 0)
				{
					clearTimeout(obj.wtId);
					obj.wtId = null;
					if (obj.onSb == false)
					{
						obj.isScroll = false;
					}
					return;
				}

				if (obj.isVertical)
				{
					var newTop = parseFloat(obj.ta.scrollTop) + parseInt(obj.wSpeed);
					if (newTop >= obj.scH || newTop <= 0)
					{
						obj.wtCounter = 0;
						if (newTop >= obj.scH)
						{
							obj.hrzLine&&(obj.ta.style.borderImageSlice = "0");
						}
					}
					else
					{
						obj.hrzLine&&(obj.ta.style.borderImageSlice = "1");
					}
					obj.ta.scrollTop = newTop;
					temp = (obj.ta.scrollTop/obj.scH)*obj.sbcH;
					if (!isNaN(temp))
					{
						obj.st.style.top = temp + "px";	/* 同步滚动条 */
					}
				}
				else
				{
					var newLeft = parseFloat(obj.ta.scrollLeft) + parseInt(obj.wSpeed);
					if (newLeft >= obj.scW || newLeft <= 0)
					{
						obj.wtCounter = 0;
					}

					obj.ta.scrollLeft = newLeft;
					temp = (obj.ta.scrollLeft/obj.scW)*obj.sbcW;
					if (!isNaN(temp))
					{
						obj.st.style.left = temp + "px";	/* 同步滚动条 */
					}
				}

				obj.wtCounter--;
			})();
		};

		NiceScroll.prototype._scrollShow = function(event){
			$("#"+this.sb.id).stop(true).css("visibility", "visible").css("opacity", 1);
			this.isScroll = true;
			eventPreventDefault(event);
		};

		NiceScroll.prototype._scroll = function(event){
			event = event || window.event;
			var delta = this._getWheelDelta(event);
			//var st = this.ta.scrollTop;
			var result = delta > 0?-1:1;
			if (this.show == true && this.enabled == true)
			{
				this._scrollShow(event);
				this._wheelAnimate(5 * result, 7);
			}
		};
	}
}
function DateControl(dateConId, options)
{
	this.table;
	this.weekList;
	this.hourList;
	this.dateCon = id(dateConId);
	this.weekIsMouseDown = false;
	this.selDate = [0, 0, 0, 0, 0, 0, 0];
	this.dateArray = [0, 0, 0, 0, 0, 0, 0];
	this.cellHeight = 22;
	this.cellWidth = 22;
	this.cellSeColor = "#A0D468";
	this.cellDeColor = "#FAFAFA";
	this.cellPadding = 1;

	if (DateControl.prototype.init == undefined)
	{
		DateControl.prototype.hourStr = label.hour;
		DateControl.prototype.weekDayNum = 7;
		DateControl.prototype.lineStr = "-";
		DateControl.prototype.selTag = "selTag";
		DateControl.prototype.cellBorderWidth = 1;
		DateControl.prototype.iCellIndex = 0;
		DateControl.prototype.weekArray = [label.Mon, label.Tue, label.Wen,
										   label.Thu, label.Fri, label.Sta, label.Sun];

		/* Date的初始化 */
		DateControl.prototype._init = function()
		{
			this._initOptions();
			this._dateConInit();
			this._hourListInit();
			this._weekListInit();
			this._dateTableInit();
		};

		/* 重新设置显示的时间 */
		DateControl.prototype.reset = function(dateArray)
		{
			var dayMask, tr, td, iCell, iCellIndex = this.iCellIndex;
			var objThis = this;

			if (dateArray instanceof Array == false ||
				dateArray == undefined ||
				dateArray.length != this.weekDayNum)
			{
				return;
			}

			for(var j = 0; j < this.weekDayNum; j++)
			{
				tr = this.table.rows[j];
				dayMask = dateArray[j];

				for (var i = 0; i < 24; i++)
				{
					td = tr.cells[i];
					iCell = td.childNodes[iCellIndex];

					if (dayMask != undefined)
					{
						this._setSel(iCell, dayMask%2);
						dayMask = (dayMask >> 1);
					}
					else
					{
						this._setSel(iCell, 0);
					}
				}
			}
		};

		/* 初始化options */
		DateControl.prototype._initOptions = function()
		{
			for (var propty in options)
			{
				if (typeof this[propty] != "undefined")
				{
					this[propty] = options[propty];
				}
			}
		};

		/* 获取已选择的时间 */
		DateControl.prototype.getSelDate = function()
		{
			var cell, selectNum, row, iCell;
			var weekDayNum = this.weekDayNum;
			var rows = this.table.rows;
			this.selDate = [0, 0, 0, 0, 0, 0, 0];

			for(var j = 0; j < weekDayNum; j++)
			{
				row = rows[j];

				for (var i = 0; i < 24; i++)
				{
					cell = row.cells[i];
					iCell = cell.childNodes[0];
					selectNum = parseInt(iCell.getAttribute("sel"));

					if (selectNum == 1)
					{
						this.selDate[j] += Math.pow(2, i);
					}
				}
			}

			return this.selDate;
		};

		DateControl.prototype._dateConInit = function()
		{
			this.dateCon.style.overflow = "hidden";
		};

		/* 时刻列表初始化 */
		DateControl.prototype._hourListInit = function()
		{
			var hourList = document.createElement("ul");
			var li, iCell, thisObj = this;

			hourList.className = "hourList";

			for(var i = 0; i <= 24; i++)
			{
				li = document.createElement("li");
				if (i != 24)
				{
					iCell = document.createElement("i");
					iCell.innerHTML = i;
					li.appendChild(iCell);
					li.style.width = this.cellWidth + this.cellPadding*2 + this.cellBorderWidth + "px";
					iCell.onclick = (function(index){
						return function(){
							var rows = thisObj.table.rows;
							var len = rows.length;
							var iCellIndex = thisObj.iCellIndex;
							var selMask = 1;

							for (var j = 0; j < len; j++)
							{
								selMask = selMask&parseInt(rows[j].cells[index].childNodes[iCellIndex].getAttribute("sel"));
								if (0 == selMask)
								{
									break;
								}
							}

							selMask = 1 - selMask;

							for (var j = 0; j < len; j++)
							{
								thisObj._setSel(rows[j].cells[index].childNodes[iCellIndex], selMask);
							}

							clearSelection();
						};
					})(i);
				}
				else
				{
					li.innerHTML = "<i>" + this.hourStr + "</i>";
				}

				hourList.appendChild(li);
			}

			this.dateCon.appendChild(hourList);
			this.hourList = hourList;
		};

		/* 星期列表初始化 */
		DateControl.prototype._weekListInit = function()
		{
			var weekList = document.createElement("ul");
			var li, thisObj = this;

			weekList.className = "weekList";

			for(var i = 0, len = this.weekDayNum; i < len; i++)
			{
				li = document.createElement("li");
				li.style.height = this.cellHeight + this.cellPadding*2 + this.cellBorderWidth + "px";
				li.style.lineHeight = this.cellHeight + this.cellPadding*2 + this.cellBorderWidth + "px";
				li.innerHTML = this.weekArray[i];
				li.onclick = (function(index){
					return function(){
						var cells = thisObj.table.rows[index].cells;
						var iCellIndex = thisObj.iCellIndex;
						var selMask = 1;

						for (var j = 0, len = cells.length; j < len; j++)
						{
							selMask = selMask&parseInt(cells[j].childNodes[iCellIndex].getAttribute("sel"));
							if (0 == selMask)
							{
								break;
							}
						}

						selMask = 1 - selMask;

						for (var j = 0, len = cells.length; j < len; j++)
						{
							thisObj._setSel(cells[j].childNodes[iCellIndex], selMask);
						}

						clearSelection();
					};
				})(i);
				weekList.appendChild(li);
			}

			this.dateCon.appendChild(weekList);
			this.weekList = weekList;
		};

		/* 设置时间块是否被选择 */
		DateControl.prototype._setSel = function(obj, num){
			obj.setAttribute("sel", num);
			obj.style.backgroundColor = (num == 1 ? this.cellSeColor : this.cellDeColor);
		};

		/* 生成时间cell */
		DateControl.prototype._dateCellCreate = function()
		{
			var dayMask, tr, td, iCell, index;
			var objThis = this;

			for (var j = 0, len = this.weekDayNum; j < len; j++)
			{
				tr = this.table.insertRow(-1);

				if (this.dateArray != undefined)
				{
					dayMask = this.dateArray[j];
				}

				for (var i = 0; i < 24; i++)
				{
					td = tr.insertCell(-1);
					td.style.padding = this.cellPadding + "px";
					td.className = "weekTd";

					iCell = document.createElement("i");
					iCell.className = "tableICell";
					iCell.style.height = this.cellHeight + "px";
					iCell.style.width = this.cellWidth + "px";
					td.appendChild(iCell);

					this._setSel(iCell, 0);

					if (dayMask != undefined)
					{
						this._setSel(iCell, dayMask%2);
						dayMask = (dayMask >> 1);
					}
					else
					{
						this._setSel(iCell, 0);
					}

					iCell.onmouseover = function (event){
						if (objThis.weekIsMouseDown == true)
						{
							objThis._setSel(this, 1 - parseInt(this.getAttribute("sel")));
						}
					};

					iCell.onmousedown = function (event){
						objThis._setSel(this, 1 - parseInt(this.getAttribute("sel")));
					};
				}
			}

			if (this.table.rows[0].cells[0].nodeType == 3)
			{
				this.iCellIndex = 1;
			}
		};

		/* 添加处理函数 */
		DateControl.prototype._dateCellBind = function()
		{
			var objThis = this;
			this.table.onmousedown = function (event){
				objThis.weekIsMouseDown = true;
				document.onmouseup = function (event){
					objThis.weekIsMouseDown = false;
				}
			};

			this.table.onmouseup = function (event){
				objThis.weekIsMouseDown = false;
			};
		};

		/* 生成时间表 */
		DateControl.prototype._dateTableCreate = function()
		{
			this.table = document.createElement("table");
			this.table.className = "tableWeek";
			this.table.cellspacing = "0px";
			this.table.cellpadding = "0px";
			this.dateCon.appendChild(this.table);
		};

		/* 初始化具体的时间表格 */
		DateControl.prototype._dateTableInit = function()
		{
			this._dateTableCreate();
			this._dateCellCreate();
			this._dateCellBind();
		};
	}

	this._init();
}
function PageFunc()
{
	this.pathStr = "../";
	this.htmlPathStr = this.pathStr + "pc/";
	this.detectPathStr = "/web-static/images/logo.png";
	this.imgDetectPathStr = "/web-static/images/logo.png";
	this.loginId = "Login";
	this.coverId = "Cover";
	this.conId = "Con";
	this.helpId = "Help";
	this.cloudPageId = "CloudAccountPage";
	this.loadPageData = {url:"", id:""};
	this.isPostfunc;
	this.helpIdStr = "helpStr";
	this.LGUSRSTR = "lgUsr";
	this.LGKEYSTR = "lgKey";
	this.LGKEYTIMESTR = "lgKeyTime";
	this._gPageHeightLg = 0;
	/* this.RESETSIGN = "defaultSet"; */
	this.LOCAL = location.protocol == "file:";
	this.g_cur_host_mac = "00-00-00-00-00-00";
	this.gDomainDNS = "melogin.cn";
	this.gDomainDetectArr = null;
	this.showLoginHideNodesDelayHd;

	this.$Init = function()
	{
		Load.call(jQuery);
		$.getExplorer();
		$.initUrl();
	};

	/* 刷新session */
	this.refreshSession = function()
	{
		$.refreshSession(this.htmlPathStr + "Content.htm");
	};

	this.loadPageHandleBg = function()
	{
		var helpBtns = $("i.helpBtn");
		var idStr, helpBtn;

		/* bind help */
		for (var i = 0, len = helpBtns.length; i < len; i++)
		{
			helpBtn = helpBtns[i];
			idStr = "";
			idStr = helpBtn.getAttribute(helpIdStr);

			if (idStr != null)
			{
				helpBind(helpBtns[i], idStr);
			}
		}
	};

	this.loadLgLessPage = function(url, id, callBack, options)
	{
		var opts = (options == undefined ? {} : options);

		opts.htmlPathStr = this.pathStr + "loginLess/";
		this.loadPage(url, id, callBack, opts);
	};

	this.loadDialogRenderPage = function(url, id, callback)
	{
		var opts = {};
		opts.isDialogRender = true;
		opts.isNoClearTimeout = true;
		this.loadPage(url, id, callback, undefined, opts);
	}

	/* load page to the target container */
	this.loadPage = function(url, id, callBack, options, extOptions)
	{
		var obj = this;

		/* for the bug of IE6.0 ~ IE8.0 */
		window.setTimeout(function(){
			var htmlPathStr = obj.htmlPathStr;

			helpClose();

			options = options == undefined ? {} : options;
			htmlPathStr = options.htmlPathStr == undefined ? htmlPathStr : options.htmlPathStr;

			if (false !== options.bRecordLoadPage)
			{
				/* 设置上下文环境参数 */
				setLoadPage(url, id);
			}

			$.load(htmlPathStr + url, function(result){
				try
				{
					typeof pageOnloadMenuCallback == "function" && pageOnloadMenuCallback();
				}
				catch(ex)
				{
				}

				typeof callBack == "function" && callBack(result);
			}, id, extOptions);
		}, 0);
	};

	this.unloadDetail = function(canvasId)
	{
		var detail = id(canvasId);
		if (detail)
		{
			detail.innerHTML = "";
		}
	};

	this.detailShow = function(conId, callBack)
	{
		$("#"+conId).fadeIn(800, callBack);
	};

	this.detailHide = function(conId, canvasId)
	{
		$("#"+conId).fadeOut(800, function(){
			$("#"+conId).css("display", "none");
			window.unloadDetail(canvasId);
		});
	};

	this.selectChange = function(objId, obj)
	{
		id(objId).value = obj.options[obj.selectedIndex].text;
	};

	this.showCon = function(idStr){
		var con = id(idStr);
		var node, nodes = document.body.childNodes;
		var conDis, otherDis;

		for(var index in nodes)
		{
			node = nodes[index];
			if (node.nodeName != undefined
				&& node.nodeName.toUpperCase() == "DIV"
				&& node.id != idStr)
			{
				setStyle(node, {"display":"none"});
			}
		}

		setStyle(con, {"display":"block"});
	};
	this.loginChange = function(showTag)
	{
		var loginCon = this.id(this.loginId);
		var other = "block", login = "none";
		var node, nodes = document.body.childNodes;
		var obj = this;

		if (showTag == true)
		{
			other = "none";
			login = "block";
			//_gPageHeightLg = parseInt(document.body.offsetHeight);
		}

		/* loginCon.innerHTML = ""; */
		emptyNodes(loginCon);

		function hideNodes()
		{
			for(var index in nodes)
			{
				node = nodes[index];
				if (node.nodeName != undefined
					&& node.nodeName.toUpperCase() == "DIV"
					&& node.id != obj.loginId && node.id != obj.conId && node.id != obj.helpId)
				{
					obj.setStyle(node, {"display":"none"});
				}
			}

			obj.setStyle(id(conId), {"display":other});
			obj.setStyle(id(helpId), {"display":other});
			obj.setStyle(loginCon, {"display":login});

			typeof isPostfunc == "function" && isPostfunc();
		}

		if (showTag == true)
		{
			var chgPwdPage = "LoginChgPwd.htm";
			var loginPage = "Login.htm";
			var contentPage = "Content.htm";

			if (1 == phoneTip)
			{
				chgPwdPage = "PhoneLoginChgPwd.htm";
				loginPage = "PhoneLogin.htm";
				contentPage = "PhoneContent.htm";
			}

			if (ESYSRESET == $.authRltObj["code"])
			{
				if (phoneTip == 0 && OS.portable == true && OS.iPad == false)
				{
					this.loadLgLessPage("PhoneSetPwdWeb.htm", "Con", undefined, {bRecordLoadPage:false});	//手机端
				}else
				{
					this.loadPage(chgPwdPage, "Login", hideNodes, {bRecordLoadPage:false});	//PC端
				}

				emptyNodes(id("Con"));

				this.setLoadPage(contentPage, "Con");
			}
			else if (phoneTip == 0 && ESYSLOCKEDFOREVER == $.authRltObj["code"] || ESYSLOCKED == $.authRltObj["code"])	//登陆错误
			{
				//document.body.style.height = "auto";
				$.queryAuthLog(function(result){
					$.authRltObj["authLog"] = result["unauth_log_list"];
					$.authRltObj["client"] = result["curIP"];
					hideNodes();
					this.loadLgLessPage("LoginAuthLog.htm", "Login", undefined, {bRecordLoadPage:false});
				});
			}
			else
			{
				if (phoneTip == 0 && OS.portable == true && OS.iPad == false && phoneSet["bContinuePCSet"] == false)
				{
					this.loadLgLessPage("PhoneAppWeb.htm", "Con", undefined, {bRecordLoadPage:false});
				}
				else
				{
					this.loadPage(loginPage, "Login", hideNodes,  {bRecordLoadPage:false});
				}
			}
		}
		else
		{
			/*
			if (phoneTip == 0 && OS.portable == true && OS.iPad == false && phoneSet["bContinuePCSet"] == false)
			{
				document.body.style.height = "100%";
			}
			else
			{
				document.body.style.height = _gPageHeightLg + "px";
			}*/

			this.loadPage(this.loadPageData.url, this.loadPageData.id, hideNodes);
		}
	};

	this.setLoadPage = function(url, idStr)
	{
		this.loadPageData.url = url;
		this.loadPageData.id = idStr;
	};

	this.localSgInit = function()
	{
		try
		{
			this.sessionLS.init();
			if (true == isIE && false == isIENormal)
			{
				(function(){
					sessionLS.setExpire(3*1000);
					window.setTimeout(arguments.callee, 1*1000);
				})();
			}
		}catch(ex){}

		if (usernameSupport)
		{
			this.getLgUsr();
		}
		this.getLgPwd();
	};

	this.auth = function()
	{
		$.auth($.pwd);
	};

	this.getLgUsr = function()
	{
		try
		{
			$.usr = sessionLS.getItem(this.LGUSRSTR);
		}catch(ex){};
	}

	this.getLgPwd = function()
	{
		try
		{
			$.pwd = sessionLS.getItem(this.LGKEYSTR);
			if (gCloudAccountBR["pwdLen"] == 0)
			{
				gCloudAccountBR["pwdLen"] = parseInt(sessionLS.getItem(this.LGKEYLEN));
			}
		}catch(ex){};
	};

	this.showLogin = function(func)
	{
		this.isPostfunc = func;
		this.loginChange(true);
	};

	this.unloadLogin = function()
	{
		this.loginChange(false);
	};

	this.ifrmOrgUrl = function(code)
	{
		return ("/stok=" + encodeURIComponent($.session) + "?code=" + code);
	};

	this.iFrmOnload = function (idStr, callBack, unAuthHandle)
	{
		var data = {}, errorno = ENONE;
		var ifrm = id(idStr);
		var isNum = false, j, ret;

		try
		{
			if (ifrm.contentWindow)
			{
				data.responeText = ifrm.contentWindow.document.body ? ifrm.contentWindow.document.body.innerHTML : null;
				data.responeXML = ifrm.contentWindow.document.XMLDocument ? ifrm.contentWindow.document.XMLDocument : ifrm.contentWindow.document;
			}
			else
			{
				data.responeText = ifrm.contentDocument.document.body ? ifrm.contentDocument.document.body.innerHTML : null;
				data.responeXML = ifrm.contentDocument.document.XMLDocument ? ifrm.contentDocument.document.XMLDocument : ifrm.contentDocument.document;
			}

			if (/(<pre>)?(.+)(<\/pre>)+/.test(data.responeText) ||
				/(<pre>)?(.+)/.test(data.responeText))
			{
				j = RegExp["$2"];
			}

			ret = JSON.parse(j);
			errorno = ret[ERR_CODE];

			callBack(errorno, ret);
		}
		catch(ex)
		{
			callBack(EINVFMT);
		}
	};

	this.windowSleep = function(milliSeconds)
	{
		var now = new Date();
		var exitTime = now.getTime() + milliSeconds;
		while (true)
		{
			now = new Date();
			if (now.getTime() > exitTime)
			{
				return;
			}
		}
	};

	/* 获取log */
	this.logSave = function()
	{
		var reqData = {};
		reqData[uciSystem.fileName] = {};
		reqData[uciSystem.fileName][uciSystem.actionName.downloadLogs] = null;

		$.action(reqData, function(data){
			var url = $.orgURL(data["url"]);
			location.href = url;
		}, true, true);
	};

	/* check for dns redirect */
	this.pageRedirect = function()
	{
		var url = window.top.location.href;
		var ipv4Rex = /^((https?:\/\/)*(\d{1,3}\.){3}\d{1,3})/g;
		var ipv6Rex = /^((https?:\/\/)*\[\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*\])/g;

		/* 处理DNS重定向 */
		if (USER_GROUP_REMOTE != $.authRltObj["group"] &&
			false == ipv4Rex.test(url) &&
			false == ipv6Rex.test(url) &&
			url.indexOf(gDomainDNS) < 0 && false == $.local)
		{
			var protocol = window.top.location.protocol;
			window.top.location.href = protocol + "//" + gDomainDNS;
		}
	};

	this.pageOnload = function()
	{
		var links = [{tag:"link", url:"../web-static/dynaform/menu.css"},
					 {tag:"link", url:"../web-static/fonts/iconfont.css"}];

		var scripts = [{tag:"script", url:"../web-static/dynaform/menu.js"},
						{tag:"script", url:"../web-static/dynaform/componentsObj.js"},
						{tag:"script", url:"../web-static/dynaform/optionsSet.js"}];

		/*
		 * 由于componentObj.js文件中会创建Dialog实例，会计算Dialog中alarm类型的content宽度，
		 * 如果component.css后加载，会导致content宽度设置为1903px，从而导致弹窗显示文字和icon
		 * 换行显示，因此提前加载components.css文件
		 */
		var preLinks = [
			{tag:"link", url:"../web-static/dynaform/components.css"}
		];

		var delayscripts = [{tag:"script", url:"../web-static/lib/slp-ajax.js"},
							{tag:"script", url:"../web-static/lib/ajax.js"},
							{tag:"script", url:"../web-static/dynaform/uci.js"},
							{tag:"script", url:"../web-static/language/cn/str.js"},
							{tag:"script", url:"../web-static/language/cn/error.js"},
							{tag:"script", url:"../web-static/lib/verify.js"},
							{tag:"script", url:"../web-static/dynaform/macFactory.js"},
							{tag:"script", url:"../web-static/dynaform/components.js"}];

		var prescripts = [{tag:"script", url:"../web-static/dynaform/settings.js"},
						  {tag:"script", url:"../web-static/dynaform/api.js"},
						  {tag:"script", url:"../web-static/lib/jquery-1.10.1.min.js"},
						  {tag:"script", url:"../web-static/lib/json.js"}];

		if (typeof supportApp == "undefined")
		{
			supportApp = false;
		}

		/* 避免由protal进入时页面全红，先将body置为白色，待进入PC页面时再将其置为红色
		if (typeof phoneTip == "undefined" && OS.portable == true && OS.iPad == false)
		{
			document.getElementsByTagName("body")[0].style.backgroundColor = "#FFFFFF";
		} */

		this.loadExternResource({scripts:prescripts, callBack:function(){
			this.loadExternResource({scripts:delayscripts, links:preLinks, callBack:function(){
				this.loadExternResource({scripts:scripts, links:links, callBack:function(){
					var url = window.top.location.href;

					$Init();

					/* 注册相应处理函数 */
					$.setexternJSP(replaceJSP);
					$.setExternPageHandle(loadPageHandleBg);
					$.setLoginErrHandle(showLogin);
					$.setPRHandle(pageRedirect);

					//this.loadExternResource({scripts:scripts, links:links});
					this.localSgInit();
					titleStr.hardwareinfo = document.title;

					if (typeof phoneTip == "undefined")
					{
						phoneTip = 0;

						if (false == /^((https?:\/\/)*(\d{1,3}\.){3}\d{1,3})/g.test(url) &&
							url.indexOf(gDomainDNS) >= 0 && gBeInCNA == "NO")
						{
							var reqData = {"get_domain_array" : null};
							$.action(reqData, function(result){
								if (ENONE == result[ERR_CODE])
								{
									var dataArry = result["domain_array"];

									if (dataArry.length > 1)
									{
										this.gDomainDetectArr = dataArry;
										this.loadLgLessPage("RouterSelect.htm", "Con", undefined, {bRecordLoadPage:false});
									}
									else
									{
										this.loadPage("Content.htm", "Con");
									}
								}
								else
								{
									this.loadPage("Content.htm", "Con");
								}
							});
						}
						else
						{
							this.loadPage("Content.htm", "Con");
						}
					}
					else
					{
						this.htmlPathStr = this.pathStr + "common/";
						this.loadPage("PhoneContent.htm", "Con");
					}
				}});
			}});
		}});

		document.oncontextmenu = function(event){
			return false;
		};

		if (isIESix)
		{
			try{document.execCommand('BackgroundImageCache', false, true);}catch(e){};
		}
	};

	/* 异步加载资源 */
	this.loadExternResource = function(obj)
	{
		var elem, links, scripts, callBack, hasReadyState;
		var head = document.getElementsByTagName("head")[0];
		var ObjOrg = {links:null, scripts:null, callBack:null};

		/* 初始化参数列表 */
		for(var prop in obj)
		{
			ObjOrg[prop] = obj[prop];
		}

		links = ObjOrg.links;
		scripts = ObjOrg.scripts;
		callBack = ObjOrg.callBack;

		/* 加载CSS */
		if (links != undefined)
		{
			for (var i in links)
			{
				elem = document.createElement("link");
				elem.rel = "stylesheet";
				elem.href = links[i].url;
				head.appendChild(elem);
			}
		}

		/* 加载js */
		if (scripts != undefined)
		{
			var load, loadHandle, loadCallBack;

			elem = document.createElement("script");
			elem.type = "text/javascript";

			if (callBack != undefined)
			{
				hasReadyState = (elem.readyState != undefined);
				loadCallBack = function(index)
				{
					scripts[index].loadState = true;

					for (var j in scripts)
					{
						if (false == scripts[j].loadState)
						{
							return;
						}
					}

					callBack();
				};

				for (var i in scripts)
				{
					scripts[i].loadState = false;
				}
			}

			for (var i in scripts)
			{
				elem = document.createElement("script");
				elem.type = "text/javascript";

					if (callBack != undefined)
					{
						if (hasReadyState)
						{
							elem.onreadystatechange = (function(index){
								return function(){
									if (this.readyState == "loaded" || this.readyState == "complete")
									{
										this.onreadystatechange = null;
										loadCallBack(index);
									}
								};
							})(i);
						}
						else
						{
							elem.onload = (function(index){
								return function(){
									loadCallBack(index);
								};
							})(i);
						}
					}

				elem.src = scripts[i].url;
				head.appendChild(elem);
			}
		}
	};
}
function Cover()
{
	Style.call(this);
	this.CoverId = "Cover";

	this.getActualSize = function()
	{
		/*
		* documentHeight: the document's height
		* documentWidth: the document's width
		* windowHeight: the window's(screen) height
		* windowWidth: the window's(screen) height
		*/
		var documentHeight = $(document).height();
		var documentWidth = $(document).width();
		var windowHeight = $(window).height();
		var windowWidth = $(window).width();
		//var conHeight = id("Con").offsetHeight;
		//var conWidth = id("Con").offsetWidth;
		//var loginHeight = id("Login").offsetHeight;
		//var loginWidth = id("Login").offsetWidth;

		//var offsetWidth = Math.max(bodyWidth, conWidth, loginWidth);
		//var offsetHeight = Math.max(bodyHeight, conHeight, loginHeight);

		return {documentWidth: documentWidth,
				documentHeight: documentHeight,
				windowWidth: windowWidth,
				windowHeight: windowHeight};
	}

	this.hideCover = function(callBack, externStyles)
	{
		var cover = id(this.CoverId);

		this.setStyle(cover, {"display":"none", "visibility":"hidden"});
		this.setStyle(cover, externStyles);

		if (typeof callBack != "undefined")
		{
			callBack(cover);
		}

		cover.innerHTML = "";
	};

	this.showCover = function(callBack, externStyles)
	{
		var cover = id(this.CoverId);

		this.setStyle(cover, {"display":"block", "visibility":"visible"});
		this.setStyle(cover, externStyles);

		if (typeof callBack != "undefined")
		{
			callBack(cover);
		}
	};

	this.showMask = function(callBack, externStyles)
	{
		if ($("#Mask").css("display") != "block")
		{
			var actualSize = getActualSize();

			$("#Mask").css("opacity", "0").css("width", actualSize.documentWidth).css("height", actualSize.documentHeight);

			$("#Mask").fadeTo(250, 0.2, callBack);
		}
	}

	this.enableScroll = function(tag)
	{
		if (tag)
		{

		}
		else
		{

		}
	}

	this.hideMask = function(callBack, externStyles)
	{
		if ($("#Mask").css("display") != "none")
		{
			$("#Mask").fadeOut(250, function(){
				typeof callBack == "function" && callBack();
			});
		}
	}
}
function Style()
{
	this.disableCol = "#b2b2b2";

	/* set the element styles with the styles */
	this.setStyle = function (ele, styles)
	{
		if (ele == null || styles == null || ele.nodeType != 1)
		{
			return;
		}

		for (var property in styles)
		{
			try
			{
				ele.style[property] = styles[property];
			}catch(ex){}
		}
	};

	/* get the default style of the element*/
	this.getNodeDefaultView = function(element, cssProperty)
	{
		var dv = null;
		if (!(element))
		{
			return null;
		}

		try{
			if (element.currentStyle)
			{
				dv = element.currentStyle;
			}
			else
			{
				dv = document.defaultView.getComputedStyle(element, null);
			}

			if (cssProperty != undefined)
			{
				return dv[cssProperty];
			}
			else
			{
				return dv;
			}
		}catch(ex){}
	};
}
function LocalStorageSD()
{
	try
	{
		if (null == this.sessionStorage)
		{
			this.sessionLS = {
				file_name:"user_data_default_SD",
				dom:null,
				init:function()
				{
					var dom = document.createElement('input');

					dom.type = "hidden";
					dom.addBehavior("#default#userData");
					document.body.appendChild(dom);
					dom.save(this.file_name);
					this.dom = dom;
				},
				setItem:function(k, v)
				{
					this.dom.setAttribute(k,v);
					this.dom.save(this.file_name);
				},
				getItem:function(k, file_name)
				{
					this.dom.load(this.file_name);
					return this.dom.getAttribute(k);
				},
				removeItem:function(k)
				{
					this.dom.removeAttribute(k);
					this.dom.save(this.file_name);
				},
				setExpire:function(timeSecond)
				{
				   var now = new Date();

				   now = new Date(now.getTime() + timeSecond);
				   this.dom.load(this.file_name);
				   this.dom.expires = now.toUTCString();
				   this.dom.save(this.file_name);
				}
			};
		}
		else
		{
			this.sessionLS = sessionStorage;
		}
	}catch(ex){};
}
function Explorer()
{
	this.isIE = false;
	this.isEdge = false;
	this.isIEEleven = false;
	this.isIESix = false;
	this.isIESeven = false;
	this.isIEEight = false;
	this.isIENormal = false;
	this.isIETenLess = false;
	this.explorerInfo = navigator.userAgent;

	this.getIEInfo = function ()
	{
		//isIE = /msie ((\d+\.)+\d+)/i.test(explorerInfo)?(document.mode || RegExp["$1"]):false;
		isIE = explorerInfo.indexOf("compatible") > -1 && explorerInfo.indexOf("MSIE") > -1;
		isEdge = explorerInfo.indexOf("Edge") > -1 && !isIE;
		isIEEleven = explorerInfo.indexOf('Trident') > -1 && explorerInfo.indexOf("rv:11.0") > -1;

		if (isIE != false)
		{
			isIE = /msie ((\d+\.)+\d+)/i.test(explorerInfo)?(document.mode || RegExp["$1"]):false;

			if (isIE <= 6)
			{
				this.isIESix = true;
			}
			else if (isIE == 7)
			{
				this.isIESeven = true;
			}
			else if (isIE == 8)
			{
				this.isIEEight = true;
			}
			else if (isIE >= 9)
			{
				this.isIENormal = true;
			}

			if (isIE <= 10)
			{
				this.isIETenLess = true;
			}

			this.isIE = true;
		}
	};

	this.ieUnsupportCheck = function(callback){
		var closeKey = "ieSixClosed";

		if (document.cookie.indexOf(closeKey) >= 0)
		{
			typeof callback == "function" && callback();
			return;
		}

		if (isIE && !isIENormal)
		{
			alarmDialog.show({
				content: label.IENineLessUnsupportTip,
				callback: function(){
					document.cookie = closeKey + "=true";
					typeof callback == "function" && callback();
				}
			});
		}
		else
		{
			typeof callback == "function" && callback();
		}
	}

	this.compatibleShow = function(){
		/*
		if (true == this.isIESix)
		{
			var posDiv, conDiv, i, span, spanClose;
			var closeKey = "ieSixClosed";

			if (document.cookie.indexOf(closeKey) >= 0)
			{
				return;
			}

			posDiv = $("div.ieSixCompatible");
			if (undefined == posDiv[0])
			{
				posDiv = el("div");
				posDiv.className = "ieSixCompatible";

				conDiv = el("div");
				conDiv.className = "ieSixCpCon";

				i = el("i");

				span = el("span");
				span.className = "spanNote";
				span.innerHTML = label.IESixCpTip;

				spanClose = el("span");
				spanClose.className = "spanClose";
				spanClose.innerHTML = label.iknown;
				spanClose.onclick = function(){
					document.cookie = closeKey + "=true";
					posDiv.style.visibility = "hidden";
					posDiv.style.top = "-9999px";
				};

				conDiv.appendChild(i);
				conDiv.appendChild(span);
				conDiv.appendChild(spanClose);
				posDiv.appendChild(conDiv);
				document.body.appendChild(posDiv);
			}
		}
		*/
	};

	this.createGroupRadio = function(name){
		var raidoEl;

		if (undefined == name)
		{
			return raidoEl;
		}

		if (this.isIE == true && this.isIENormal == false)
		{
			raidoEl = document.createElement("<input name='"+ name +"' />");
		}
		else
		{
			raidoEl = document.createElement("input");
			raidoEl.name = name;
		}

		return raidoEl;
	};

	this.getIEInfo();
}
function Tool()
{
	Style.call(this);

	/* get element by id */
	this.id = function(idStr)
	{
		if (idStr != undefined)
		{
			return document.getElementById(idStr);
		}
	};

	/* create element */
	this.el = function(str)
	{
		try
		{
			return document.createElement(str);
		}catch(ex){return null;}
	};

	/* replace {%....%} to realize multi languages */
	this.replaceJSP = function(str)
	{
		var matches = null, strRepace;
		var tagL = "{%", tagR = "%}";
		var rp = /{%(\w+)\.(\w+)%}/i;

		matches = rp.exec(str);
		try
		{
			while(matches != null)
			{
				strRepace = language[matches[1]][matches[2]];
				str = str.replace(tagL + matches[1] + "." + matches[2] + tagR, strRepace);
				matches = rp.exec(str);
			}
		}catch(ex){}
		return str;
	};

	/* get the offsetLeft and offsetTop to the border of the container(default is browser) */
	this.getoffset = function(obj, container)
	{
		var tempObj = obj;
		var relPo = {
			top:0,
			left:0
		};

		while(true)
		{
			if (tempObj == container)
			{
				break;
			}

			relPo.left += parseInt(tempObj.offsetLeft);
			relPo.top += parseInt(tempObj.offsetTop);
			tempObj = tempObj.offsetParent;
		}

		return relPo;
	};

	this.attachEvnt = function(target, event, handle)
	{
		if (event.indexOf("on") == 0)
		{
			event = event.substring(2);
		}

		if (document.body.attachEvent)
		{
			target.attachEvent("on" + event, handle);
		}
		else
		{
			target.addEventListener(event, handle, false);
		}
	};

	this.detachEvnt = function(target, event, handle){
		if (event.indexOf("on") == 0)
		{
			event = event.substring(2);
		}

		if (document.body.attachEvent)
		{
			target.detachEvent("on" + event, handle);
		}
		else
		{
			target.removeEventListener(event, handle, false);
		}
	};

	/* stop propagation of event */
	this.stopProp = function (event)
	{
		event = event || window.event;

		if (event.stopPropagation)
		{
			event.stopPropagation();
		}
		else
		{
			event.cancelBubble = true;
		}
	};

	/* prevent defaut operation of event */
	this.eventPreventDefault = function (event)
	{
		event = event || window.event;
		if(event.preventDefault)
		{
			event.preventDefault();
		}
		else
		{
			event.returnValue = false;
		}
	};

	/* clear selection produced width mouse move */
	this.clearSelection = function ()
	{
		window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
	};

	/* 设置dom上range的光标位置 */
	this.setDomCursorPos = function (dom, pos)
	{
		if (dom.setSelectionRange)
		{
			dom.focus();
			dom.setSelectionRange(pos, pos);
		}
		else if (dom.createTextRange)
		{
			var range = dom.createTextRange()
			range.collapse(true);
			range.moveEnd('character', pos);
			range.moveStart('character', pos);
			range.select();
		}
	}

	/* get the pos of the mouse width the event */
	this.getMousePos = function (event)
	{
		event = event || window.event;
		var doc = document;
		var pos = (event.pageX || event.pageY) ? {x:event.pageX,y:event.pageY}:
				{x:event.clientX + doc.documentElement.scrollLeft - doc.documentElement.clientLeft,
				 y:event.clientY + doc.documentElement.scrollTop - doc.documentElement.clientTop};
		return pos;
	};

	/* 判断对象是否是数组 */
	this.isArray = function (obj)
	{
		return Object.prototype.toString.call(obj) === '[object Array]';
	};

	this.isObject = function (obj)
	{
		return Object.prototype.toString.call(obj) === '[object Object]';
	};

	/* create up down */
	this.upDown = function (con, taId, classNameUp, classNameDown, callBack)
	{
		if (classNameUp == undefined || classNameDown == undefined)
		{
			return;
		}

		var lbl = this.el("label");

		lbl.className = classNameDown;
		lbl.onclick = function(){
			$("#"+taId).slideToggle("normal", function(){
				lbl.className = (lbl.className == classNameUp?classNameDown:classNameUp);
				if (callBack)
				{
					try
					{
						callBack();
					}catch(ex){}
				}
			});
		};
		con.appendChild(lbl);

		return lbl;
	};

	this.arrowUpDown = function (con, taId, callBack){
		this.upDown(con, taId, "arrowUp", "arrowDown", callBack);
	};

	/* 获取dom节点下指定类型的节点，index可选, filter:"input checkbox" */
	this.getChildNode = function(parent, filter, index){
		var childs = parent.childNodes;
		var nodes = [], count = 0, tempNode;
		var paras = filter.split(" ");
		var nodeName = paras[0], type = paras[1];

		for(var i = 0, len = childs.length;i < len; i++)
		{
			tempNode = childs[i];
			if (tempNode.nodeType == 1 && tempNode.tagName.toLowerCase() == nodeName)
			{
				if (type != undefined && tempNode["type"] == type)
				{
					nodes[count] = tempNode;
					count++;
				}
				else if (type == undefined)
				{
					nodes[count] = tempNode;
					count++;
				}
			}
		}
		if (index != undefined)
		{
			return nodes[index];
		}

		return nodes[0];
	};

	/* 检查节点是否可见 */
	this.checkInHorize = function(ta){
		var node = ta;
		while(node != null && node.nodeName.toUpperCase() != "HTML")
		{
			if (this.getNodeDefaultView(node, "visibility") == "hidden" ||
				this.getNodeDefaultView(node, "display") == "none")
			{
				return false;
			}
			node = node.parentNode;
		}

		return true;
	};

	this.setUrlHash = function(key, value)
	{
		var strH, strT, pos, tag ="";
		var url = location.href;
		var hash = location.hash;

		if (key == undefined ||
			value == undefined ||
			key.length == 0)
		{
			return;
		}

		if (hash.length != 0)
		{
			pos = hash.indexOf(key);
			if (pos >= 0)
			{
				strH = hash.substring(0, pos);
				strT = hash.substring(pos);
				pos = strT.indexOf("#");
				if (pos > 0)
				{
					strT = strT.substring(pos);
					hash = strH + key + "=" + value + strT;
				}
				else
				{
					hash = strH + key + "=" + value;
				}
			}
			else
			{
				if (hash.substring(hash.length - 1) != "#")
				{
					tag = "#";
				}
				hash += (tag + key + "=" + value);
			}

			location.href = url.substring(0, url.indexOf("#")) + hash;
		}
		else
		{
			if (url.lastIndexOf("#") == (url.length - 1))
			{
				location.href += (key + "=" + value);
			}
			else
			{
				location.href += ("#" + key + "=" + value);
			}
		}
	};

	this.getUrlHash = function(key)
	{
		var hash = location.hash;
		var pos = hash.indexOf(key);
		var strArr, tempArr, value = "";

		if (pos > 0)
		{
			strArr = hash.substring(1).split("#");
			for(var index in strArr)
			{
				tempArr = strArr[index].split("=");
				if (tempArr[0] == key)
				{
					value = tempArr[1];
					break;
				}
			}
		}

		return value;
	};

	this.changeUrlHash = function(str)
	{
		var url = location.href;
		var pos = url.indexOf("#");

		if (str == undefined)
		{
			return;
		}

		if (pos > 0)
		{
			location.href = url.substring(0, pos + 1) + str;
		}
		else
		{
			location.href = url + "#" +str;
		}
	};

	/* 设置输入框的光标的位置 */
	this.setInputCursor = function(input){
		var len = input.value.length;

		this.setDomCursorPos(input, len);
	};

	/* 获取字符串的长度，采用UTF-8编码，汉字占3个字符 */
	this.getCNStrLen = function(str)
	{
		return str.replace(/[^\x00-\xFF]/g, "xxx").length;
	};

	/* 获取字符串在HTML中的长度 */
	this.getCNStrHTMLLen = function(str){
		return str.replace(/[^\x00-\xFF]/g, "xx").length;
	};

	/* 采用UTF-8编码，存储中文时每个中文占3个字节，但页面显示时，每个中文字符的宽度还是按2个字符计算 */
	this.getDisplayStrLen = function(str) {
		return str.replace(/[^\x00-\xFF]/g, "xx").length;
	};

	/* 截取字符串，如果超过maxNum则以...结束 */
	this.getStrInMax = function(value, maxNum){
		var str = "", strTemp, j = 0;
		var tmpStr = value.replace(/[A-Z]/g, "xx");

		if (getCNStrHTMLLen(tmpStr) <= maxNum)
		{
			return value;
		}

		for(var count = 1; count <= maxNum; count++)
		{
			strTemp = value.charAt(j);
			if (strTemp == "")
			{
				break;
			}

			if (getCNStrHTMLLen(strTemp) == 2 || /[A-Z]/g.test(strTemp) == true)
			{
				count++;
				str += strTemp;
				beCut = true;
			}
			else
			{
				str += strTemp;
			}

			j++;
		}
		return str + "...";
	};

	this.getStrInMaxWithPixel = function(value, fontSize, maxPixelLength)
	{
		var targetLen, ellipsisLen;

		targetLen = calStrLenPixel(value, fontSize);

		if (targetLen <= maxPixelLength)
		{
			return value;
		}
		else
		{
			ellipsisLen = calStrLenPixel("...", fontSize);

			return cutStrWithPixel(value, fontSize, maxPixelLength - ellipsisLen) + "...";
		}
	}

	this.cutStrWithPixel = function(str, fontSize, Pixel)
	{
		var resultStr = "", strPixelsLength = 0, strCharsCounts = str.length;;

		var elementPixelsLengthRuler = document.createElement("span");
		elementPixelsLengthRuler.style.fontSize = fontSize;
		elementPixelsLengthRuler.style.visibility = "hidden";
		elementPixelsLengthRuler.style.display = "inline-block";

		if (true == isIE && true == isIENormal)
		{
			elementPixelsLengthRuler.style.wordBreak = "break-all !important";
		}

		document.body.appendChild(elementPixelsLengthRuler);

		for (var i = 0; i < strCharsCounts; i++)
		{
			if (str[i] == " ")
			{
				elementPixelsLengthRuler.innerHTML = "&nbsp;";
			}
			else
			{
				elementPixelsLengthRuler.innerHTML = str[i];
			}

			strPixelsLength += elementPixelsLengthRuler.offsetWidth;

			if (strPixelsLength >= Pixel)
			{
				break;
			}
			else
			{
				resultStr += str[i];
			}
		}

		document.body.removeChild(elementPixelsLengthRuler);
		return resultStr;
	}

	this.calStrLenPixel = function(str, fontSize)
	{
		var strCharsCounts = str.length;
		var strPixelsLength = 0;

		var elementPixelsLengthRuler = document.createElement("span");
		elementPixelsLengthRuler.style.fontSize = fontSize + "px";
		elementPixelsLengthRuler.style.visibility = "hidden";
		elementPixelsLengthRuler.style.display = "inline-block";

		if (true == isIE && true == isIENormal)
		{
			elementPixelsLengthRuler.style.wordBreak = "break-all !important";
		}

		document.body.appendChild(elementPixelsLengthRuler);

		for (var i = 0; i < strCharsCounts; i++)
		{
			if (str[i] == " ")
			{
				elementPixelsLengthRuler.innerHTML = "&nbsp;";
			}
			else
			{
				elementPixelsLengthRuler.innerHTML = str[i];
			}

			strPixelsLength += elementPixelsLengthRuler.offsetWidth;
		}

		document.body.removeChild(elementPixelsLengthRuler);
		return strPixelsLength;
	}

	this.EncodeURLIMG = document.createElement("img");

	/* 对多字节字符编码 */
	this.escapeDBC = function(s)
	{
		var img = this.EncodeURLIMG;

		if (!s)
		{
			return "";
		}

		if (window.ActiveXObject)
		{
			/* 如果是IE, 使用vbscript */
			execScript('SetLocale "zh-cn"', 'vbscript');
			return s.replace(/[\d\D]/g, function($0) {
				window.vbsval = "";
				execScript('window.vbsval=Hex(Asc("' + $0 + '"))', "vbscript");
				return "%" + window.vbsval.slice(0,2) + "%" + window.vbsval.slice(-2);
			});
		}

		/* 其它浏览器利用浏览器对请求地址自动编码的特性 */
		img.src = "nothing.png?separator=" + s;

		return img.src.split("?separator=").pop();
	};

	/* 对URL的参数进行GBK或UTF-8编码 */
	this.encodeURL = function(s)
	{
		return encodeURIComponent(s);

		/* 把 多字节字符 与 单字节字符 分开，分别使用 escapeDBC 和 encodeURIComponent 进行编码 */
		/*return s.replace(/([^\x00-\xff]+)|([\x00-\xff]+)/g, function($0, $1, $2) {
			return escapeDBC($1) + encodeURIComponent($2 || '');
		});*/
	};

	this.doNothing = function()
	{
		return true;
	};

	/* 转换特殊的HTML标记 */
	this.htmlEscape = function(str)
	{
		var escapseStr = str;

		if (undefined != escapseStr)
		{
			escapseStr = escapseStr.toString().replace(/[<>&"]/g, function(match){
				switch(match)
				{
				case "<":
					return "&lt;";
				case ">":
					return "&gt;";
				case "&":
					return "&amp;";
				case "\"":
					return "&quot;";
				}
			});
		}

		return escapseStr;
	};

	this.orgAuthPwd = function(pwd)
	{
		var strDe = "RDpbLfCPsJZ7fiv";
		var dic = "yLwVl0zKqws7LgKPRQ84Mdt708T1qQ3Ha7xv3H7NyU84p21BriUWBU43odz3iP4rBL3cD02KZciX"+
				  "TysVXiV8ngg6vL48rPJyAUw0HurW20xqxv9aYb4M9wK1Ae0wlro510qXeU07kV57fQMc8L6aLgML"+
				  "wygtc0F10a0Dg70TOoouyFhdysuRMO51yY5ZlOZZLEal1h0t9YQW0Ko7oBwmCAHoic4HYbUyVeU3"+
				  "sfQ1xtXcPcf1aT303wAQhv66qzW";

		return this.securityEncode(pwd, strDe, dic);
	};

	this.securityEncode = function(input1, input2, input3)
	{
		var dictionary = input3;
		var output = "";
		var len, len1, len2, lenDict;
		var cl = 0xBB, cr = 0xBB;

		len1 = input1.length;
		len2 = input2.length;
		lenDict = dictionary.length;
		len = len1 > len2 ? len1 : len2;

		for (var index = 0; index < len; index++)
		{
			cl = 0xBB;
			cr = 0xBB;

			if (index >= len1)
			{
				cr = input2.charCodeAt(index);
			}
			else if (index >= len2)
			{
				cl = input1.charCodeAt(index);
			}
			else
			{
				cl = input1.charCodeAt(index);
				cr = input2.charCodeAt(index);
			}

			output += dictionary.charAt((cl ^ cr)%lenDict);
		}

		return output;
	};

	/* 模拟鼠标点击操作 */
	this.simulateMouseC = function (target)
	{
		if (true == isIE && false == isIENormal)
		{
			simulateMouseC = function(target){
				var event = document.createEventObject();

				event.sceenX = 100;
				event.sceenY = 0;
				event.clientX = 0;
				event.clientY = 0;
				event.ctrlKey = false;
				event.altKey = false;
				event.shiftKey = false;
				event.button = 0;

				target.fireEvent("onclick", event);
			};
		}
		else
		{
			simulateMouseC = function(){};
		}

		simulateMouseC(target);
	};

	this.emptyNodes = function(node)
	{
		/* for the bug of MSIE 6.0 */
		/*if (node)
		{
			node.innerHTML = "";
			return;
		}*/

		while(node && node.firstChild)
		{
			node.removeChild(node.firstChild);
		}
	};
	this.netSpeedTrans = function(speed)
	{
		var kSpeed = 1024;
		var mSpeed = kSpeed * 1024;
		var gSpeed = mSpeed * 1024;

		if (speed >= gSpeed)
		{
			speed = (speed / gSpeed).toFixed(1);
			if (speed >= 100)
			{
				speed = parseInt(speed);
			}
			speed = speed + "GB/s";
		}
		else if (speed >= mSpeed)
		{
			speed = (speed / mSpeed).toFixed(1);
			if (speed >= 100)
			{
				speed = parseInt(speed);
		}
			speed = speed + "MB/s";
		}
		else
		{
			speed = (speed / kSpeed).toFixed(1);
			if (speed >= 100)
			{
				speed = parseInt(speed);
			}
			speed = speed + "KB/s";
		}

		return speed;
	};
	/* 修复IOS系统CNA浏览器默认使用第三方输入法无法输入的问题 */
	this.adaptCNABrowserInput = function(idStr){
		try
		{
			/* 仅为CNA浏览器时进行该处理 */
			if ("NO" == gBeInCNA)
			{
				return;
			}

			id(idStr).onfocus = function(){
				var input = this;
				var value = input.value;

				input.value = "";
				input.type = "password";
				$.setTimeout(function(){
					input.type = "text";
					input.value = value;
				}, 0);
			};
		}
		catch(ex)
		{}
	};
}
function Switch(switchId, state, callback, isFirstLoadTrigger, stateChangeCallback, statusArray)
{
	this.switchId = switchId;
	this.switchCon = id(switchId);
	this.switchBall = $("#" + switchId + " i.switchBall")[0];
	this.switchBg = $("#" + switchId + " i.switchBg")[0];
	this.callback = callback;
	this.stateChangeCallback = stateChangeCallback;
	this.isFirstLoadTrigger = isFirstLoadTrigger;
	this.state = state;
	this.rightPos;
	this.disabled = false;
	this.statusArray = statusArray;

	if (typeof Switch.prototype.switchInit != "function")
	{
		Switch.prototype.switchInit = function(){
			var objThis = this;
			var state = this.state;
			var switchBall = this.switchBall;
			var switchCon = this.switchCon;
			var switchBg = this.switchBg;

			if (switchCon == null || switchBall == null)
			{
				return;
			}

			this.rightPos = switchCon.offsetWidth - switchBall.offsetWidth;
			this.setState(state);
			if (this.isFirstLoadTrigger == undefined || this.isFirstLoadTrigger != false)
			{
				this.callback&&this.callback(state);
			}

			switchBall.onmousedown = this.draggableBind();
			switchBg.onclick = this.switchBgClick();
		};

		/* 设置状态 */
		Switch.prototype.setState = function(state){
			var switchCon = this.switchCon;
			var switchBall = this.switchBall;
			var switchBg = this.switchBg;
			var blank = (state == 1 ? -2 : 2);

			this.state = state;
			switchCon.value = state;
			switchBall.style.left = state*this.rightPos + blank + "px";
			if (state == 1)
			{
				switchBg.style.background = "url(../web-static/images/basic.png) no-repeat scroll -144px 0";
			}
			else
			{
				switchBg.style.background = "url(../web-static/images/basic.png) no-repeat scroll -144px -16px";
			}

			if (this.stateChangeCallback != undefined)
			{
				this.stateChangeCallback(state);
			}
		};

		/* 状态修改 */
		Switch.prototype.switchChgState = function(state){
			state = 1 - state;
			this.setState(state);
			this.callback&&this.callback(state);
		};

		/* 点击的响应函数 */
		Switch.prototype.switchCHandle = function(){
			/* 1为on, 0 为off */
			var state = this.state;
			var switchBall = this.switchBall;
			var tag = (state == 1 ? -1 : 1);
			var left = parseInt(switchBall.style.left);
			var width = this.rightPos - 2;
			var obj = this;

			/* on to off */
			if ((state == 1 && left <= 2) || (state == 0 && left >= width))
			{
				this.switchChgState(state);
				return;
			}

			switchBall.style.left = left + tag*width/8 + "px";
			window.setTimeout(function(){obj.switchCHandle()}, 20);
		};

		Switch.prototype.msMove = function(ta, currMousePos, distance)
		{
			var taWidth = ta.offsetWidth;
			var posX = currMousePos.x - distance.x;
			var maxX = this.switchCon.offsetWidth - taWidth - 2;

			posX = posX > 2 ? posX:2;
			posX = posX > maxX ? maxX:posX;
			ta.style.left = posX + "px";
		};

		/* switchBg的点击处理函数 */
		Switch.prototype.switchBgClick = function(){
			var objThis = this;

			return function(event){
				event = event || window.event;
				var target = event.target || event.srcElement;

				if (objThis.disabled)
				{
					return;
				}

				if (objThis.switchBg == target)
				{
					objThis.switchCHandle();
				}
			};
		};

		Switch.prototype.draggableBind = function()
		{
			var thisObj = this;

			return function(event){
				event = event ? event : window.event;
				var currMousePos = getMousePos(event);
				var ta = event.target || event.srcElement;

				if (thisObj.disabled)
				{
					return;
				}

				/* 记录鼠标按下瞬间鼠标与控件左上角的距离 */
				var distance = {x:currMousePos.x - ta.offsetLeft};

				document.onmousemove = function(event)
				{
					event = event ? event : window.event;
					var currMousePos = getMousePos(event);

					clearSelection();
					thisObj.msMove(ta, currMousePos, distance);
				};

				document.onmouseup = function(event)
				{
					clearSelection();
					document.onmousemove = null;
					document.onmouseup = null;
					thisObj.switchCHandle();
				};

				stopProp(event);
			};
		};

		Switch.prototype.disable = function(disabled){
			this.disabled = disabled;
			var cursor = disabled ? "default" : "pointer";
			this.switchBall.style.cursor = cursor;
			this.switchCon.style.cursor = cursor;

			if (disabled)
			{
				this.switchBall.style.background = "url(../web-static/images/basic.png) no-repeat -178px -18px";
				this.switchBg.style.background = "url(../web-static/images/basic.png) no-repeat -144px -32px";
			}
			else
			{
				this.switchBall.style.background = "url(../web-static/images/basic.png) no-repeat -178px -2px";
				if (this.state == 1)
				{
					this.switchBg.style.background = "url(../web-static/images/basic.png) no-repeat -144px 0";
				}
				else
				{
					this.switchBg.style.background = "url(../web-static/images/basic.png) no-repeat -144px -16px";
				}
			}
		};
	}

	this.switchInit();
}
function ShowTips()
{
	this.alertTimeHd;
	this.shAltObjOrId;

	/* 显示正在loading的状态
	this.showLoading = function(noteStr, closeCallBack, classObj, hasCloseBtn)
	{
		closeLoading();
		showCover(function(cover){
			var coverId = cover.id;
			var loadCon, load, loadCover;
			var loadImg, detail, close;
			var cover$ = $("#" + coverId);
			var loadConClass, loadClass;
			var coverLoadingClass, detailClass;
			var coverOpacity = 0;
			var hasCloseBtnValue = hasCloseBtn == undefined ? true : hasCloseBtn;

			if (undefined != classObj)
			{
				loadConClass = classObj.loadConClass;
				loadClass = classObj.loadClass;
				coverLoadingClass = classObj.coverLoadingClass;
				detailClass = classObj.detailClass;
				coverOpacity = classObj.coverOpacity || 0;
			}

			// 将cover设置为透明的
			cover$.css("opacity", coverOpacity);

			loadCover = el("div");
			loadCover.className = "LoadConCover";
			document.body.appendChild(loadCover);

			loadCon = el("div");
			loadCon.className = loadConClass || "coverLoadCon";
			loadCover.appendChild(loadCon);

			load = el("div");
			load.className = loadClass || "coverLoad";
			loadCon.appendChild(load);

			if (hasCloseBtnValue)
			{
				close = el("i");
				close.className = "coverLoadClose";
				close.onclick = function(){
					closeLoading(closeCallBack);
				};
				load.appendChild(close);
			}

			if (undefined == coverLoadingClass)
			{
				loadImg = el("img");
				loadImg.className = "coverLoading";
				loadImg.src = "../web-static/images/wdsDetect.gif";
				load.appendChild(loadImg);
			}
			else
			{
				loadImg = el("img");
				loadImg.className = coverLoadingClass;
				loadImg.src = "../web-static/images/wzdWarningWhite.png";
				load.appendChild(loadImg);
			}

			detail = el("p");
			detail.className = detailClass || "coverLoadNote";
			detail.innerHTML = (noteStr == undefined ? label.checkingWait : noteStr);
			load.appendChild(detail);
		});
	};
	*/

	/* 关闭正在loading的状态
	this.closeLoading = function(closeCallBack)
	{
		var loadCover = $("div.LoadConCover")[0];

		if (null == loadCover)
		{
			return;
		}

		$("#" + this.CoverId).css("opacity", "");
		document.body.removeChild(loadCover);
		hideCover(closeCallBack);
	};
	*/

	this.isGlobalShowLoadingWorking = false;
	this.isGlobalShowLoadingHandle = null;
	this.isGlobalShowLoadingTimeoutHandle = null;
	this.requestShowLoadingCount = 0;

	this.showLoading = function(){
		if (typeof loadingDialog != "undefined" && loadingDialog.status == "showed") {
			return;
		}
		var loadingCon = id("Loading");
		var i, iLeft, iTop;
		var windowWidth = $(window).width(),
		    windowHeight = $(window).height();

		if (loadingCon.childNodes.length == 0)
		{
			i = document.createElement("i");
			i.className = "iconfont icon-loading loading";
			loadingCon.appendChild(i);
		}

		i = loadingCon.childNodes[0];
		iLeft = (windowWidth / 2) - 24;
		iTop = (windowHeight / 2) - 24;
		$(i).css("left", iLeft);
		$(i).css("top", iTop);

		if ($("#Loading").css("display") != "block")
		{
			$("#Loading").fadeIn(250);
		}
	}

	this.closeLoading = function(callBack){
		if ($("#Loading").css("display") != "none")
		{
			$("#Loading").fadeOut(250, function(){
				typeof callBack == "function" && callBack();
			});
		}
	}

	this.showToastHandle = null;

	this.showToast = function(str)
	{
		var toastObj = $("#Toast");
		var windowWidth = window.document.body.offsetWidth;
		var toastObjWidth, toastObjHeight, toastObjLeft, toastObjTop, dialogBox;
		var dialogArr = Dialog.prototype.state.dialogArr;

		if (toastObj.css("display") == "block")
		{
			toastObj.trigger("ev_hide");
		}

		toastObj.html(str);

		/* 	NOTE:
		*
		*	$(obj).width() : ONLY CONTENT
		*	$(obj).innerWidth() : CONTENT + PADDING
		*	$(obj).outerWidth() : CONTENT + PADDING + BORDER
		*	$(obj).outerWidth(true) : CONTENT + PADDING + BORDER + MARGIN
		*
		*/
		toastObjWidth = toastObj.innerWidth();
		toastObjHeight = toastObj.innerHeight();

		if (dialogArr.length == 0)
		{
			toastObjLeft = (windowWidth / 2) - (toastObjWidth / 2);
			toastObjTop = 200;
		}
		else
		{
			dialogBox = $(dialogArr[dialogArr.length - 1].obj.container);
			toastObjLeft = parseInt(dialogBox.css('left')) + (parseInt(dialogBox.actual('width')) / 2) - (toastObjWidth / 2);
			toastObjTop = parseInt(dialogBox.css('top')) + (parseInt(dialogBox.actual('height')) / 2) - (toastObjHeight / 2);
		}

		toastObj.css("left", toastObjLeft);
		toastObj.css("top", toastObjTop);

		toastObj.fadeTo(500, 0.8);

		showToastHandle = setTimeout(function(){
			showToastHandle = null;
			toastObj.fadeOut(1000);
		}, 2000);

		toastObj.off("ev_hide").on("ev_hide", function(){
			if (showToastHandle != null)
			{
				clearTimeout(showToastHandle);
				toastObj.css("opacity", "0").css("display", "none");
			}
			else
			{
				toastObj.stop(false, true);
			}
		});
	}

	/* 在设置向导中显示警告框 */
	this.showPhWzdAlert = function(errStr, callBack)
	{
		this.showCover(function(){
			var con, img, p, lbl;
			var conId = "phWzdAlertCon";
			var objThis = this;

			con = id(conId);
			if (null == con)
			{
				con = document.createElement("div");
				con.className = "phWzdAlertCon";
				con.id = conId;
				document.body.appendChild(con);

				img = document.createElement("img");
				img.src = "../web-static/images/phoneWarn.png";
				con.appendChild(img);

				p = document.createElement("p");
				con.appendChild(p);

				lbl = document.createElement("label");
				lbl.className = "btnY";
				lbl.innerHTML = btn.ok;
				con.appendChild(lbl);
				//lbl.innerHTML = btn.confirm;
			}
			else
			{
				p = $("#" + conId +" p")[0];
				lbl = $("#" + conId +" label")[0];
			}

			con.style.top = "120px";
			con.style.visibility = "visible";
			p.innerHTML = errStr;
			lbl.onclick = function(){
				typeof callBack == "function" && callBack();
				objThis.closePhWzdAlert();
			};
		}, {"opacity": 0.4});
	};

	this.closePhWzdAlert = function()
	{
		this.hideCover(function(){
			var con = id("phWzdAlertCon");
			if (null != con)
			{
				con.style.top = "-9999px";
				con.style.visibility = "hidden";
			}
		});
	};

	/* 在设置向导中显示弹出框 */
	this.showPhConfirm = function(confStr, callBack, okStr, noStr)
	{
		this.showCover(function(){
			var con, img, p, btnY, btnN;
			var conId = "phConfirmCon";
			var objThis = this;
			var btnOkStr = (okStr != undefined) ? okStr : btn.ok;
			var btnNoStr = (noStr != undefined) ? noStr : btn.cancel;

			con = id(conId);
			if (null == con)
			{
				con = document.createElement("div");
				con.className = "phWzdAlertCon";
				con.id = conId;
				document.body.appendChild(con);

				img = document.createElement("img");
				img.src = "../web-static/images/phoneWarn.png";
				con.appendChild(img);

				p = document.createElement("p");
				con.appendChild(p);

				btnY = document.createElement("label");
				btnY.className = "btnY";
				con.appendChild(btnY);

				btnN = document.createElement("label");
				btnN.className = "btnN";
				con.appendChild(btnN);
			}
			else
			{
				p = $("#" + conId +" p")[0];
				btnY =  $("#" + conId +" label")[0];
				btnN =  $("#" + conId +" label")[1];
			}

			p.innerHTML = confStr;
			btnN.innerHTML = btnNoStr;
			btnY.innerHTML = btnOkStr;
			con.style.top = "120px";
			con.style.visibility = "visible";

			btnN.onclick = function(){
				objThis.closePhConfirm();
				typeof callBack == "function" && callBack(false);
			};

			btnY.onclick = function(){
				objThis.closePhConfirm();
				typeof callBack == "function" && callBack(true);
			};
		}, {"opacity": 0.4});
	};

	this.closePhConfirm = function()
	{
		this.hideCover(function(){
			var con = id("phConfirmCon");
			if (null != con)
			{
				con.style.top = "-9999px";
				con.style.visibility = "hidden";
			}
		});
	};

	this.showPhLoading = function(loadStr)
	{
		this.showCover(function(){
			var con, img, p, lbl;
			var conId = "phWzdLoadCon";
			var objThis = this;

			con = id(conId);
			if (null == con)
			{
				con = document.createElement("div");
				con.className = "phWzdLoadCon";
				con.id = conId;
				document.body.appendChild(con);

				img = document.createElement("i");
				img.className = "phWzdLoadImg"
				con.appendChild(img);

				p = document.createElement("p");
				con.appendChild(p);
			}
			else
			{
				p = $("#" + conId +" p")[0];
			}

			con.style.top = "240px";
			con.style.visibility = "visible";
			p.innerHTML = loadStr;
		}, {"opacity": 0.4});
	}
	this.closePhLoading = function()
	{
		this.hideCover(function(){
			var con = id("phWzdLoadCon");
			if (null != con)
			{
				con.style.top = "-9999px";
				con.style.visibility = "hidden";
			}
		});
	}

	/* 调试输出 */
	this.debugInfo = function()
	{
		var info = "";

		for (var i = 0, len = arguments.length; i < len; i++)
		{
			info += (arguments[i] + "\r\n");
		}

		alert(info);
	}
}
function Select()
{
	this.selectInitExtern = function(idStr, options, value, callback, maxSize)
	{
		var classObj = {
			className:"appSelOptsUl",
			colorN:"#FFFFFF",
			colorC:"#95AE31",
			fontColorN:"#3C3E43",
			fontColorC:"#FFFFFF",
			valueColor:"#FFFFFF",
			valueDisColor:"#95AE31",
			scrollBg:"#95AE31",
			scrollZIndex:"1009"
		};

		selectInit(idStr, options, value, callback, maxSize, classObj);
	};

	this.selectInitEptMgt = function(idStr, options, value, callback, maxSize)
	{
		var classObj = {
			className:"eptMgtSelOptsUl",
			colorN:"#FFFFFF",
			colorC:"#F17E50",
			fontColorN:"#3C3E43",
			fontColorC:"#FFFFFF",
			valueColor:"#FFFFFF",
			valueDisColor:"#F17E50",
			scrollBg:"#F17E50",
			scrollZIndex:"1009"
		};

		selectInit(idStr, options, value, callback, maxSize, classObj);
	};

	this.selectInit = function(idStr, options, value, callback, maxSize, property)
	{
		var li, tmp, parent, valueCon, visible = "hidden";
		var ul = document.createElement("ul");
		var con = id(idStr), className = "selOptsUl";
		var colorN = "#FFFFFF", colorC = "#f5f5f5";
		var fontColorN = "", fontColorC = "#333";
		var valueColor = "#000000", valueDisColor = "#B2B2B2";
		var valueConTmp, showSize, valueConWidth, fontSize, liCon;
		var escapeStr, listScroll, valueDef = value;

		parent = con.parentNode;
		valueConTmp = $("#"+idStr+" span.value");
		liCon = $("#"+idStr).parents('li.inputLi');
		fontColorN = valueConTmp.css("color");
		valueCon = valueConTmp[0];
		valueCon.value = 0;
		valueConWidth = parseInt(valueConTmp.css("width") == "100%" ? (maxSize == undefined ? valueConTmp.actual("width") : maxSize) : valueConTmp.css("width"));
		fontSize = parseInt(valueConTmp.css("fontSize"));
		con.value = 0;
		ul.className = className;
		ul.id = className + idStr;

		if (property != undefined && property.unlimitOptionsHigh == true)
		{
			$(ul).addClass("selOptsUlUnlimitHieght");
		}

		parent.appendChild(ul);

		function hiddenSelect(ul)
		{
			var visibilityVal, li;
			var options = ul.childNodes;
			var idCon = $(ul).prev();

			for (var i = 0, len = options.length; i < len; i++)
			{
				li = options[i];
				visibilityVal = li.childNodes[0].style.visibility;
				li.style.backgroundColor = (visibilityVal == "visible"?colorC:colorN);
				li.style.color = (visibilityVal == "visible"?fontColorC:fontColorN);
			}

			ul.style.visibility = "hidden";
			ul.style.top = "-9999px";
			ul.parentNode.style.position = "static";

			if (valueConTmp.hasClass("dropDown"))
			{
				valueConTmp.removeClass("dropDown").addClass("dropUp");
			}

			idCon[0].state = "idle";
		}

		attachEvnt(document.body, "click", function(){
			var ul = $("#"+className + idStr)[0];

			if (typeof ul == "undefined")
			{
				return;
			}

			hiddenSelect(ul);
		});

		function optionClick(li)
		{
			var con = id(idStr)
			var target = li;
			var parent = target.parentNode;
			var options = parent.childNodes;
			var valueCon = $("#"+idStr+" span.value")[0];

			if (target.childNodes[0].nodeType == 3)
			{
				return;
			}

			con.value = target.valueStr;
			valueCon.value = target.valueStr;

			for (var i = 0, len = options.length; i < len; i++)
			{
				options[i].childNodes[0].style.visibility = "hidden";
				options[i].style.backgroundColor = colorN;
				options[i].style.color = fontColorN;
				$(options[i]).removeClass("selected");
			}

			if (target.childNodes[0].style.visibility != "visible" &&
				typeof callback != "undefined")
			{
				callback(target.valueStr, con);
			}

			$(target).addClass("selected");
			valueConTmp.removeClass("dropDown").addClass("dropUp");

			target.childNodes[0].style.visibility = "visible";
			target.style.backgroundColor = colorC;
			target.style.color = fontColorC;
			valueCon.innerHTML = htmlEscape(target.childNodes[1].nodeValue);
			parent.style.visibility = "hidden";
			parent.style.top = "-9999px";
			parent.parentNode.style.position = "static";
		}

		function optionInit(options)
		{
			for (var i = 0, len = options.length; i < len; i++)
			{
				tmp = options[i];
				//escapeStr = htmlEscape(getStrInMax(tmp.str.toString(), showSize));
				escapeStr = htmlEscape(getStrInMaxWithPixel(tmp.str.toString(), fontSize, valueConWidth));
				visible = "hidden";

				li = document.createElement("li");
				li.className = "option";

				if ((tmp.value == undefined && i == valueDef) || (valueDef == tmp.value))
				{
					visible = "visible";
					valueCon.innerHTML = escapeStr;
					valueCon.value = valueDef;
					con.value = valueDef;
					li.style.backgroundColor = colorC;
					li.style.color = "#ff3366";

					/* 添加选中类 */
					$(li).addClass("selected");
				}
				else
				{
					li.style.color = fontColorN;
				}

				li.innerHTML = "<span style='visibility:" + visible + "' class='iconfont icon-ok'></span>" + escapeStr;
				li.title = tmp.title || tmp.str;
				li.valueStr = (tmp.value != undefined ? tmp.value : i);
				li.onclick = function(event)
				{
					event = event || window.event;
					optionClick(this);
					stopProp(event);
				};

				li.onmousemove = function(event){
					event = event || window.event;
					var target = event.srcElement || event.target;
					var options;

					if (target.tagName.toLowerCase() == "span")
					{
						return;
					}

					options = target.parentNode.childNodes;

					for (var i = 0, len = options.length; i < len; i++)
					{
						options[i].style.backgroundColor = colorN;
						if (!$(options[i]).hasClass("selected"))
						{
							options[i].style.color = fontColorN;
						}
					}

					target.style.backgroundColor = colorC;
					if (!$(target).hasClass("selected"))
					{
						target.style.color = fontColorC;
					}
				};

				ul.appendChild(li);
			}
		}

		function selectClick(event)
		{
			var target = $("#"+ className + idStr);
			var sel = $("ul."+ className);

			if (valueConTmp.hasClass("dropDown"))
			{
				hiddenSelect(ul);
				valueConTmp.addClass("dropUp");
				return;
			}
			else
			{
				valueConTmp.removeClass("dropUp").addClass("dropDown");
			}

			/* 先隐藏其他下拉列表 */
			sel.each(function(){
				if (this.style.visibility == "visible")
				{
					hiddenSelect(this);
				}
				return true;
			});

			var top = parseInt($(target).parent().css('height'), 10) + 4;
			target.css("visibility", "visible").css("top", top + 'px');
			target[0].parentNode.style.position = "relative";
			this.state = "focus";
			stopProp(event);
		}

		optionInit(options);

		con.state = "idle";
		con.onclick = selectClick;
		con.disable = function(disabled){
			if (disabled)
			{
				con.onclick = null;
				valueCon.style.color = valueDisColor;
				liCon.addClass("disabled");
			}
			else
			{
				con.onclick = selectClick;
				valueCon.style.color = valueColor;
				liCon.removeClass("disabled");
			}
		};
		con.changeSel = function(value){
			var selOptions = $("#"+ className + idStr+" li");

			$("#"+ className + idStr+" li").each(function(){
				if (this.valueStr == value)
				{
					optionClick(this);
					return false;
				}
			});
		};
		con.resetOptions = function(options, value){
			ul.innerHTML = "";
			valueDef = value || 0;
			optionInit(options);
		};

		listScroll = new NiceScroll({targetId: ul.id});
		listScroll.scrollTipOpacity(1);
		listScroll.scrollTipSet({background:"#999999"});
		listScroll.init();
	};
}
function Help()
{
	var objThis = this;

	this.help = "Help";
	this.helpDetail = "helpDetail";
	this.helpContent = "helpContent";
	this.helpURL = "Help.htm";
	this.helpInit = function()
	{
		var hp = id(this.help);
		var p, span, i, div;
		var objThis = this;

		if (hp.innerHTML.length != 0)
		{
			loadDialogRenderPage(this.helpURL, this.helpContent);
			return;
		}

		p = document.createElement("p");
		p.className = "helpTop";
		p.onmousedown = this.draggableBind(this.help);
		hp.appendChild(p);
		span = document.createElement("span");
		span.className = "helpDes";
		span.innerHTML = label.help;
		p.appendChild(span);

		i = document.createElement("i");
		i.onclick = function (){
			objThis.helpClose();
		};
		i.className = "helpClose iconfont icon-close";
		p.appendChild(i);
		div = document.createElement("div");
		div.id = "helpDetail";
		hp.appendChild(div);

		div = document.createElement("div");
		div.style.display = "none";
		div.id = this.helpContent;
		document.body.appendChild(div);
		loadDialogRenderPage(this.helpURL, this.helpContent);

		/* 触屏移动开始的处理函数 */
		attachEvnt(p, "touchstart", function(event){
			event = event || window.event;
			objThis.mousePos = {x:event.touches[0].clientX, y:event.touches[0].clientY};
			attachEvnt(document, "touchmove", touchMoveHd);
			attachEvnt(document, "touchend", touchEndHd);
		});
	};

	/* 触屏移动的处理函数 */
	this.touchMoveHd = function(event)
	{
		event = event || window.event;
		var mousePos = {x:event.touches[0].clientX, y:event.touches[0].clientY};
		var hp = id(objThis.help);
		var divWidth = hp.offsetWidth;
		var divHeight = hp.offsetHeight;
		var posX = mousePos.x - objThis.mousePos.x;
		var posY = mousePos.y - objThis.mousePos.y;
		var maxX = document.body.clientWidth - divWidth;
		var maxY = document.documentElement.scrollHeight - divHeight;

		posX = posX > 0 ? posX:0;
		posY = posY > 0 ? posY:0;
		posX = posX > maxX ? maxX:posX;
		posY = posY > maxY ? maxY:posY;
		hp.style.left = posX + "px";
		hp.style.top = posY + "px";
		eventPreventDefault(event);
		clearSelection(event);
	};

	/* 触屏结束移动的处理函数 */
	this.touchEndHd = function(event)
	{
		detachEvnt(document, "touchmove", touchMoveHd);
		detachEvnt(document, "touchend", touchEndHd);
	};
	this.helpBind = function(btn, helpIdStr)
	{
		btn&&(btn.onclick = function(event){
			event = event || window.event;
			var target = event.target || event.srcElement;

			helpShow(helpIdStr, target);
		});
	};
	this.helpClose = function()
	{
		var hp = id(this.help);
		var hpDe = id(this.helpDetail);

		if (hpDe == null || hp == null)
		{
			return;
		}

		setStyle(hp, {"visibility":"hidden", "top":"-9999px"});
		hpDe.innerHTML = "";
	};

	this.helpVisible = function(btn)
	{
		var hp = id(this.help);
		var pos = $(btn).offset();
		var width = hp.offsetWidth;
		var helpBtnHeight = btn.offsetHeight;
		var top, left;

		/* 常用设置help */
		var menuLoader = $("#menuLoader");
		left = menuLoader.offset().left + parseInt((menuLoader[0].offsetWidth - width)/2) + "px";

		top = pos.top + helpBtnHeight + "px";
		setStyle(hp, {"visibility":"visible", "top":top, "left":left});
	};
	this.helpDetailAppend = function(helpIdStr)
	{
		var hpDe;
		var helpCon = id(helpIdStr);

		if (null == helpCon)
		{
			return;
		}

		hpDe = id(this.helpDetail);
		hpDe.innerHTML = helpCon.outerHTML;
	};
	this.helpShow = function(helpIdStr, btn)
	{
		this.helpClose();
		this.helpVisible(btn);
		helpDetailAppend(helpIdStr);
	};
	this.msMove = function(helpDiv, currMousePos, distance)
	{
		var divWidth = helpDiv.offsetWidth;
		var divHeight = helpDiv.offsetHeight;
		var posX = currMousePos.x - distance.x;
		var posY = currMousePos.y - distance.y;
		var maxX = document.body.clientWidth - divWidth;
		var maxY = document.documentElement.scrollHeight - divHeight;

		posX = posX > 0 ? posX:0;
		posY = posY > 0 ? posY:0;
		posX = posX > maxX ? maxX:posX;
		posY = posY > maxY ? maxY:posY;
		helpDiv.style.left = posX + "px";
		helpDiv.style.top = posY + "px";
	};
	this.draggableBind = function(divPaId)
	{
		var inFrame = 1;
		var inSetFrame = 2;
		var outChild = 0;
		var helpDiv = id(divPaId);

		return function(event){
			event = event ? event : window.event;
			var currMousePos = getMousePos(event);

			/* 记录鼠标按下瞬间鼠标与DIV控件左上角的距离 */
			var distance = {x:currMousePos.x - helpDiv.offsetLeft,
							y:currMousePos.y - helpDiv.offsetTop};

			document.onmousemove = function(event)
			{
				event = event ? event : window.event;
				var currMousePos = getMousePos(event);

				clearSelection();
				msMove(helpDiv, currMousePos, distance);
			};

			document.onmouseup = function()
			{
				clearSelection();
				document.onmousemove = null;
				document.onmouseup = null;
			};
		};
	};
}

/* 提示信息相关 */
function Tips()
{
	this.addTitleError = function(id, str, options)
	{
		var headNode, titleErrorCon, htmlStr, p, i, span, br;
		var headNode = $("div.head");
		if (headNode.length == 0)
		{
			return;
		}

		if (id == undefined || typeof id != "string" || str == undefined || typeof str != "string")
		{
			return;
		}

		titleErrorCon = headNode.find("#highsetTitleError");
		if (titleErrorCon.length == 0)
		{
			p = el("p");
			p.id = "highsetTitleError";
			p.className = "commonErrTip highsetCommonErrTip";

			i = el("i");
			i.className = "iconfont icon-error";
			p.appendChild(i);
			$(p).css("width", $(headNode[0]).actual("width") - 12 * 2);	/* WIDTH - PADDING */

			headNode[0].appendChild(p);
			titleErrorCon = headNode.find("#highsetTitleError");
		}

		if (titleErrorCon.find("#" + id).length != 0)
		{
			return;
		}

		span = el("span");
		span.id = id;
		span.innerHTML = str;

		titleErrorCon.append(span);

		if (options != undefined)
		{
			if (options.hasIcon == false)
			{
				titleErrorCon.find("i").remove();
			}

			if (options.hasBtn == true)
			{
				options.btnArr.reverse();
				for (var i = 0; i < options.btnArr.length; i++)
				{
					var btnItem = options.btnArr[i];
					var btnDiv = $("<div></div>").addClass("highsetCommonErrBtn");
					btnDiv.html(btnItem.btnStr);
					btnDiv.on("click", btnItem.btnOnclick);

					titleErrorCon.append(btnDiv);
				}
			}
		}
	}

	this.removeTitleError = function(id)
	{
		var headNode, titleErrorCon;

		var headNode = $("div.head");
		if (headNode.length == 0)
		{
			return;
		}

		titleErrorCon = headNode.find("#highsetTitleError");
		if (titleErrorCon.length == 0)
		{
			return;
		}

		titleErrorCon.find("#" + id).remove();
		if (titleErrorCon.find("span").length == 0)
		{
			titleErrorCon.remove();
		}
	}

	this.addTitleWarning = function(str)
	{

	}
}

/* 检测LAN是否可以连接DUT */
function LanDetect()
{
	this.lanDetectSuccess = false;
	this.LAN_DETECT_TIME = 1000;
	this.lanDetectTimeHd = null;

	this.lanDetectHandle = function(callBack)
	{
		if (false == $.result.timeout && false == this.lanDetectSuccess)
		{
			this.lanDetectSuccess = true;
			clearTimeout(this.lanDetectTimeHd);
			callBack();
		}
	}

	this.lanDetecting = function(callBack)
	{
		this.lanDetectSuccess = false;
		$.detect(function(){
			lanDetectHandle(callBack);
		});

		this.lanDetectTimeHd = $.setTimeout(function(){
			lanDetecting(callBack);
		}, this.LAN_DETECT_TIME);
	}
}

/* 记录MECURY ID关联、创建、忘记密码等页面状态 */
function CloudHistory(options)
{
	this.container = options.container;
	this.track = options.track;
	this.state = {
		account: null,
		pwd: null,
		bind: false,
		createSuccessAndLoginFail: false
	};
	this.cursor = 0;
	this.isFormWizard = options.isFormWizard || false;

	if (typeof CloudHistory.prototype.go != "function")
	{
		CloudHistory.prototype.go = function(step){
			var cursor = this.cursor + step;

			if (cursor < 0 ||
				cursor >= this.track.length)
			{
				return;
			}

			if (this.isFormWizard)
			{
				loadPage(this.track[cursor].page, this.container, this.track[cursor].callback);
			}
			else
			{
				loadDialogRenderPage(this.track[cursor].page, this.container, this.track[cursor].callback);
			}

			this.cursor = cursor;
		};
		CloudHistory.prototype.setState = function(state){
			for (var key in state)
			{
				this.state[key] = state[key];
			}
		};
		CloudHistory.prototype.getState = function(key){
			return this.state[key];
		};
	}
}

/* 定时轮询函数 */
function refreshRoutine()
{
	var data = {};
	data[uciCloudConfig.fileName] = {};
	data[uciCloudConfig.fileName][KEY_NAME] = [
		uciCloudConfig.secName.newFirmware,
		uciCloudConfig.secName.deviceStatus,
		uciCloudConfig.secName.bind
	];

	if (slp.moduleSpec["wifison_mesh"] == 1)
	{
		data[uciPlc.fileName] = {};
		data[uciPlc.fileName][KEY_TABLE]= uciPlc.secType.connectedExt;
	}

	$.query(data, function(res){
		var fwNewNotify,
			bindeStatus,
			username,
			extFwNewCount = 0,
			cldList;

		if (ENONE == res[ERR_CODE])
		{
			fwNewNotify = res[uciCloudConfig.fileName][uciCloudConfig.secName.newFirmware][uciCloudConfig.optName.fwNewNotify] == uciCloudConfig.optValue.fwNewTrue;
			bindeStatus = res[uciCloudConfig.fileName][uciCloudConfig.secName.deviceStatus][uciCloudConfig.optName.bindStatus];
			username = htmlEscape(res[uciCloudConfig.fileName][uciCloudConfig.secName.bind][uciCloudConfig.optName.username]);

			if (slp.moduleSpec["wifison_mesh"] == 1)
			{
				cldList = formatTableData(res[uciPlc.fileName][uciPlc.secType.connectedExt]);

				for (var i = 0, j = cldList.length; i < j; i++)
				{
					var cld = cldList[i];
					cld.cur_fw_version = cld.cur_fw_version.split(" ")[0] == "" ? label.canNotDetect : cld.cur_fw_version.split(" ")[0];
					cld.newest_fw_version = (cld.newest_fw_version && cld.newest_fw_version.split(" ")[0]) || cld.cur_fw_version;

					if (cld[uciPlc.optName.supportOlUp] == uciPlc.optValue.supportOlUp.yes &&
							cld.cur_fw_version != label.canNotDetect &&
							cld.newest_fw_version != label.canNotDetect &&
							cld.newest_fw_version != cld.cur_fw_version)
					{
						extFwNewCount++;
					}
				}
			}

			fwNewNotify = fwNewNotify || (extFwNewCount > 0);

			//设置软件更新标志
			$(id("navHighSet")).trigger("showTag", [fwNewNotify]);
			$("#sysTool_menu").find("i.menuLiTag").css("display", fwNewNotify ? "block" : "none");
			$("#sysTool_menu").parent().find("li").each(function(){
				var spanText = $(this).find("label").text();

				if (spanText == menuStr.upgrade)
				{
					$(this).find("i.subMenuLiTag").css("display", fwNewNotify ? "block" : "none");
				}
			});

			cloudHistory.setState({
				account: username,
				bind: (bindeStatus == uciCloudConfig.optValue.bindStatusBind) ? true : false
			});
			refreshNavBarCloudStatus();

			/* 等待10s后刷新 */
			cloudRefreshHandle = setTimeout(function(){
				refreshRoutine();
			}, cloudRefreshPeriod);
		}
	}, undefined, true);
}

/* 刷新导航栏的Cloud状态 */
function refreshNavBarCloudStatus()
{
	if (cloudHistory.getState("bind") == false)
	{
		id("mercuryId").innerHTML = label.cloudIdNoBind;
	}
	else
	{
		id("mercuryId").innerHTML = cloudHistory.getState("account");
	}
}

/* Add By zhangwenhao: 此处开始添加云功能的支持 */
function CloudCommon()
{
	this.cloudRefreshHandle = null;
	this.cloudRefreshPeriod = 10 * 1000;
	this.cloudHistory = null;
	this.pushCloudUpgradeDialog = false;
	this.pushCloudIDSuggestDialog = false;

	this.cloudAccountEmailList = [
		{key:"gmail.com",	value:"https://mail.google.com"},
		{key:"live.com",	value:"http://mail.live.com"},
		{key:"live.cn",		value:"http://mail.live.com"},
		{key:"hotmail.com",	value:"http://mail.live.com"},
		{key:"outlook.com",	value:"http://mail.live.com"},
		{key:"qq.com",		value:"http://mail.qq.com"},
		{key:"126.com",		value:"http://mail.126.com"},
		{key:"163.com",		value:"http://mail.163.com"},
		{key:"yeah.net",	value:"http://mail.yeah.net"},
		{key:"sina.com",	value:"http://mail.sina.com.cn"},
		{key:"sohu.com",	value:"http://mail.sohu.com"},
		{key:"21cn.com",	value:"http://mail.21cn.com"},
		{key:"sina.com.cn",	value:"http://mail.sina.com.cn"},
		{key:"tom.com",		value:"http://mail.tom.com"},
		{key:"sogou.com",	value:"http://mail.sogou.com"},
		{key:"foxmail.com",	value:"http://mail.foxmail.com"},
		{key:"188.com",		value:"http://mail.188.com"},
		{key:"wo.cn",		value:"http://mail.wo.cn"},
		{key:"189.cn",		value:"http://mail.189.cn"},
		{key:"139.com",		value:"http://mail.10086.cn"},
		{key:"eyou.com",	value:"http://www.eyou.com"},
		{key:"aliyun.com",	value:"http://mail.aliyun.com"},
		{key:"263.net",		value:"http://mail.263.net"},
		{key:"2980.com",	value:"http://www.2980.com"}
	];

	this.emailLinkCheck = function(emallAddr){
		for (var index in cloudAccountEmailList)
		{
			var item = cloudAccountEmailList[index];
			if (emallAddr.indexOf(item.key) > 0)
			{
				return item.value;
			}
		}

		return null;
	};

	this.cloudRefreshFunc = function()
	{
		var data = {};
		var lUCC = uciCloudConfig;

		data[lUCC.fileName] = {};
		data[lUCC.fileName][KEY_NAME] = [lUCC.secName.newFirmware, lUCC.secName.deviceStatus, lUCC.secName.bind];

		$.query(data, function(result){
			if (ENONE == result[ERR_CODE])
			{
				try
				{
					/* set new firmware */
					basicMenuNewUpgradeSet(result[lUCC.fileName][lUCC.secName.newFirmware][lUCC.optName.fwNewNotify] == lUCC.optValue.fwNewTrue);

					/* set bind info */
					if (result[lUCC.fileName][lUCC.secName.deviceStatus][lUCC.optName.bindStatus] == lUCC.optValue.bindStatusBind)
					{
						basicCloudSet(true, result[lUCC.fileName][lUCC.secName.bind][lUCC.optName.username]);
					}
					else
					{
						basicCloudSet(false);
					}
				}catch(ex){debugInfo(ex);}

				cloudRefreshHandle = window.setTimeout(cloudRefreshFunc, 10000);
			}
		});
	}

	/* 增加页面新软件提示标志 */
	this.basicMenuNewUpgradeSet = function(tag)
	{
		var sysUpgradeMenu = id("sysTool_menu");
		var i;

		var highSetBtn = $("ul.headFunc").find("li")[1];

		var highSetBtnTip = $(highSetBtn).find("i");
		var softUpdateTip = $("#sysTool_menu2").find("i")[0];

		if (highSetBtnTip[0] == undefined)
		{
			i = el("i");
			i.style.visibility = "hidden";
			i.className = "highSetTip";
			highSetBtn.appendChild(i);
			highSetBtnTip = $(highSetBtn).find("i");
		}

		if (true == tag)
		{
			/* 设置菜单软件升级的标志 */
			if (undefined != sysUpgradeMenu)
			{
				i = $("#sysTool_menu i.devTipImg");
				if (i[0] == undefined)
				{
					i = el("i");
					i.className = "devTipImg";
					sysUpgradeMenu.appendChild(i);
				}
				else
				{
					i.css("visibility", "visible");
				}
			}

			if (softUpdateTip != undefined)
			{
				softUpdateTip.className = "subImgY";
			}

			highSetBtnTip.css("visibility", "visible");
		}
		else
		{
			if (undefined != sysUpgradeMenu)
			{
				i = $("#sysTool_menu i.devTipImg");
				if (i[0] != undefined)
				{
					i.css("visibility", "hidden");
				}
			}

			if (softUpdateTip != undefined)
			{
				softUpdateTip.className = "subImg";
			}

			highSetBtnTip.css("visibility", "hidden");
		}
	}

	/* 更新页眉的MERCURY ID状态 */
	this.basicCloudSet = function(bCloudBinded, account)
	{
		if (bCloudBinded)
		{
			$("#cloudHeadFunc a")[0].style.display = "none";
			$("#cloudHeadFunc a")[0].onclick = null;

			$("#cloudHeadFunc a")[1].style.display = "none";
			$("#cloudHeadFunc a")[1].onclick = null;

			$("#cloudHeadFunc a")[2].style.display = "inline";
			$("#cloudHeadFunc a")[2].innerHTML = account;
			$("#cloudHeadFunc a")[2].onclick = function(){
				loadPage("Advance.htm", "Con");
			}
		}
		else
		{
			$("#cloudHeadFunc a")[0].style.display = "inline";
			$("#cloudHeadFunc a")[0].onclick = function(){
				cloudSetBackBRHd(basicBRGoBackHandle);
				showCloudPage("CloudBindCfg.htm");
			};

			$("#cloudHeadFunc a")[1].style.display = "inline";
			$("#cloudHeadFunc a")[1].onclick = function(){
				cloudSetBackBRHd(basicBRGoBackHandle);
				showCloudPage("CloudRegistCfg.htm");
			};

			$("#cloudHeadFunc a")[2].style.display = "none";
			$("#cloudHeadFunc a")[2].innerHTML = "";
			$("#cloudHeadFunc a")[2].onclick = null;
		}
	}

	this.basicBRGoBackHandle = function(result)
	{
		var binded = result["binded"];
		var account = result["account"];

		if (true == binded)
		{
			basicCloudSet(binded, account);

			if (null != id("cloudFirstTitle"))
			{
				loadPage("CloudAccountCfg.htm", "hcDetail");
			}
		}
	}

	this.startCloudRefresh = function()
	{
		if (cloudRefreshHandle != null)
		{
			return;
		}

		cloudRefreshFunc();
	}

	this.stopCloudRefresh = function()
	{
		if (cloudRefreshHandle == null)
		{
			return;
		}

		window.clearTimeout(cloudRefreshHandle);
		cloudRefreshHandle = null;
	}

	this.gCloudColObj = {
		cloudBackHd:null,
		cloudBackBRHd:null,
		account:""
	};

	this.cloudSetBackHd = function(handle){
		gCloudColObj.cloudBackHd = handle;
	};

	this.cloudGoBack = function(){
		var goBack = gCloudColObj.cloudBackHd;

		typeof goBack == "function" && goBack();
	};

	this.cloudSetBackBRHd = function(handle){
		gCloudColObj.cloudBackBRHd = handle;
	};

	this.cloudGoBackBR = function(arg){
		var goBack = gCloudColObj.cloudBackBRHd;

		hideCloudPage();
		typeof goBack == "function" && goBack(arg);
	};

	this.gCloudAccountBR = {
		bodyHeight:0,
		account:"",
		pwd:"",
		CAPTCHAR:"",
		accountType:"",
		success:false,
		noteF:"",
		noteS:"",
		pwdLen:0,
		softVersion:"",
		bFWzd:false,
		registSuccess:false
	};

	/*
	this.showCloudPage = function(url)
    {
		stopCloudRefresh();
		var cloudAccountPage = id(this.cloudPageId);

		if (null == cloudAccountPage)
		{
			cloudAccountPage = el("div");
			cloudAccountPage.id = this.cloudPageId;
			document.body.appendChild(cloudAccountPage);
		}

        loadPage(url, "CloudAccountPage", function(result){
			if (ENONE == result[ERR_CODE])
			{
				cloudPageSetNodes(true);
			}
		});
    };

	this.hideCloudPage = function(){
		try
		{
			var cloudPageCon = id(this.cloudPageId);

			emptyNodes(cloudPageCon);
			cloudPageCon.style.height = "0px";
			cloudPageSetNodes(false);
			if (id("cloudHeadFunc") != undefined)
			{
				startCloudRefresh();
			}
		}catch(ex){}
	};
	*/

	this.cloudPageSetNodes = function(tag){
		var other = "none", cloudPage = "none";
		var node, nodes = document.body.childNodes;

		if (true == tag)
		{
			cloudPage = "block";
			other = "none";
			gCloudAccountBR.bodyHeight = parseInt(document.body.offsetHeight);
			document.body.style.height = "auto";
		}
		else
		{
			cloudPage = "none";
			other = "block";
			document.body.style.height = gCloudAccountBR.bodyHeight + "px";
		}

		/* 设置节点显隐 */
		for(var index in nodes)
		{
			node = nodes[index];
			if (node.nodeName != undefined &&
				node.nodeName.toUpperCase() == "DIV")
			{
				if (node.id == this.cloudPageId)
				{
					setStyle(node, {"display":cloudPage});
				}
				else if (node.id == "Con")
				{
					if (true == tag)
					{
						node.style.visibility = "hidden";
						node.style.position = "absolute";
						node.style.top = "-9999px";
					}
					else
					{
						node.style.visibility = "visible";
						node.style.position = "static";
						node.style.top = "0px";
					}
				}
				else if (node.id != this.loginId ||
					node.id != this.coverId)
				{
					setStyle(node, {"display":other});
				}
			}
		}

		id(this.loginId).style.display = "none";
		id(this.coverId).style.display = "none";
	};

	this.appendErrCode = function(str, code)
	{
		return str + label.lBrackets + errStr.errCode + label.colon + parseInt(code) + label.rBrackets;
	};

	this.cloudErrHandle = function(errCode)
	{
		var code = parseInt(errCode);

		switch(code)
		{
		case EINVCLOUDERRORPARSEJSON:
		case EINVCLOUDERRORPARSEJSONNULL:
		case EINVCLOUDERRORPARSEJSONID:
		case EINVCLOUDCLIENTGENERIC:
		case EINVCLOUDCLIENTPARSEDNSREQUEST:
		case EINVCLOUDCLIENTESTABLISHTCP:
		case EINVCLOUDCLIENTWANIPCHANGE:
		case EINVCLOUDCLIENTDISCONNECTFIN:
		case EINVCLOUDCLIENTDISCONNECTRST:
		case EINVCLOUDCLIENTDISCONNECT:
		case EINVCLOUDCLIENTDISCONNECTSOCKETERRNUM:
		case EINVCLOUDCLIENTWANPHYPORTLINKDOWN:
		case EINVCLOUDCLIENTDOWNLOADPARSEDNSREQUEST:
		case EINVCLOUDCLIENTDOWNLOADESTABLISHTCP:
		case EINVCLOUDCLIENTDOWNLOADHTTPNOTOK:
		case EINVCLOUDCLIENTDOWNLOADTIMEOUT:
			showStr = errStr.invNetworkErr;
			break;
		case EINVCLOUDERRORGENERIC:
		case EINVCLOUDERRORSERVERINTERNALERROR:
		case EINVCLOUDERRORPERMISSIONDENIED:
		case EINVCLOUDERRORSERVERBUSY:
		case EINVCLOUDCLIENTHEARTREQUESTTIMEOUT:
		case EINVCLOUDCLIENTSTOPCONNECT:
		case EINVCLOUDCLIENTHELLOCLOUD:
		case EINVCLOUDCLIENTPUSHPLUGININFO:
		case EINVCLOUDCLIENTGETFWLIST:
		case EINVCLOUDCLIENTGETINITFWLIST:
			showStr = errStr.invServerBusy;
			break;
		case EINVCLOUDCLIENTSSLSIGNERROR:
		case EINVCLOUDCLIENTSSLDOMAINERROR:
		case EINVCLOUDCLIENTSSLTIMEERROR:
		case EINVCLOUDCLIENTSSLENCRYPTIONNOTMATCH:
			showStr = errStr.invConnectServerFailed;
			break;
		case EINVCLOUDCLIENTDEVICEILLEGAL:
			showStr = errStr.invCloudDeviceIdErr;
			break;
		case EINVERRORPERMISSIONDENIED:
			showStr = errStr.invPermissionDeny;
			break;
		case EINVCLOUDERRORMETHODNOTFOUND:
		case EINVCLOUDERRORPARAMSNOTFOUND:
		case EINVCLOUDERRORPARAMSWRONGTYPE:
		case EINVCLOUDERRORPARAMSWRONGRANGE:
		case EINVCLOUDERRORINVALIDPARAMS:
			showStr = errStr.invRequestFail;
			break;
		case EINVCLOUDERRORBINDDEVICEERROR:
			showStr = errStr.invMEIDLgFail;
			break;
		case EINVCLOUDERRORUNBINDDEVICEERROR:
			showStr = errStr.invMEIDUnBindFail;
			break;
		case EINVCLOUDERRORHWIDNOTFOUND:
		case EINVCLOUDERRORFWIDNOTSUPPORTDEVICE:
			showStr = errStr.cloudDeviceInfoExpt;
			break;
		case EINVCLOUDERRORDEVICEALIASFORMATERROR:
			showStr = errStr.invRouterNameFormat;
			break;
		case EINVCLOUDERRORACCOUNTUSERNAMEFORMATERROR:
			showStr = errStr.invCloudAccountFmtErr;
			break;
		case EINVCLOUDERRORACCOUNTACTIVEMAILSENDFAIL:
		case EINVCLOUDERRORRESETMAILSENDFAIL:
			showStr = errStr.invCAPTCHASendFail;
			break;
		case EINVCLOUDERRORTOKENEXPRIED:
		case EINVCLOUDERRORTOKENINCORRECT:
			showStr = errStr.invMEIDTimeout;
			break;
		case EINVCLOUDERRORACCOUNTACTIVEFAIL:
		case EINVCLOUDERRORACCOUNTACTIVETIMEOUT:
			showStr = errStr.invAccountCheckFail;
			break;
		case EINVCLOUDERRORRESETPWDTIMEOUT:
		case EINVCLOUDERRORRESETPWDFAIL:
			showStr = errStr.invAccountRstPwdFail;
			break;
		default:
			return {result:true};
		}

		showStr = appendErrCode(showStr, code);

		return {result:false, tip:showStr};
	};
}

function CloudAction()
{
	this.cloudActionQueryStatusHd = null;
	this.cloudActionQueryStatusWaitHd = null;
	this.cloudActionStatusQuering = false;
	this.cloudActionQueryStoped = false;
	this.CLOUD_STATUS_QUERY_TIMEOUT = 1000;
	this.CLOUD_STATUS_QUERY_TIMEOUT_WAIT = 20 * 1000;
	this.cloudCloseLoadingHandle = null;
	this.cloudParseHandle = null;

	this.cloudResultType = {
		FINISH: 0,
		ACTION_ERROR: 1,
		QUERY_ALL_TIMEOUT: 2,
		QUERY_REQ_TIMEOUT: 3,
		EXCEPTION: 4,
		CLOSE: 5
	}

	this._cloudParseError = function(errNo){
		var showStr = "";
		var cloudErrRel;

		switch (parseInt(errNo))
		{
		case ENONE:		/* 执行成功 */
			return {result: true};
		case EINVSENDREQMSGFAILED:		/* 发送失败 */
			showStr = errStr.invSendReqMsgFailed;
			break;
		case ESYSBUSY:
		case EINVLASTOPTIONISNOTFINISHED:		/* 上个动作执行中 */
			showStr = errStr.invLastOptionIsNotFinished;
			break;
		case ESYSTEM:
			showStr = errStr.invRequestFail;		/* 系统错误 */
			break;
		case ENOMEMORY:
			showStr = errStr.invMemoryOut;		/* 系统内存不足 */
			break;
		case EINVGETDATAFAILED:
			showStr = errStr.invGetDataFailed;		/* 获取数据失败 */
			break;
		case EINVPARAMETER:
			showStr = errStr.invParameter;		/* 请求参数非法 */
			break;
		case EINVREQUESTTIMEOUT:
			showStr = appendErrCode(errStr.invRequestFailTrylater, errNo);		/* 请求超时，服务器无响应 */
			break;
		case EINVDEVICEIDNOTEXIST:
		case EINVERRORDEVICEIDFORMATERROR:
		case EINVILLEGALDEVICE:
			showStr = appendErrCode(errStr.cloudDeviceInfoExpt, errNo);		/* 设备非法 */
			break;
		default:		/* 未知的错误 */
			cloudErrRel = cloudErrHandle(errNo);
			if (cloudErrRel.result == false)
			{
				showStr = cloudErrRel.tip;
				break;
			}

			showStr = errStr.invRequestFail;
			break;
		}

		return {
			result: false,
			errCode: errNo,
			errStr: showStr
		};
	}

	this._setCloudHandle = function(handle){
		cloudParseHandle = handle;
	}

	/* 强制停止正在进行的查询动作 */
	this.cloudAccountQueryStop = function(){
		cloudActionQueryStoped = true;
		cloudActionStatusQuering = false;
		clearTimeout(cloudActionQueryStatusHd);
		clearTimeout(cloudActionQueryStatusWaitHd);
		cloudParseHandle(cloudResultType.CLOSE);

		_setCloudHandle(null);
	};

	this._cloudStatusDataOrg = function(secName){
		var data = {};
		var uciCS= cloudClientStatus;

		data[uciCS.fileName] = {};
		data[uciCS.fileName][KEY_NAME] = secName;

		return data;
	};

	/* 查询获取MERCURY ID的状态的结果 */
	this._cloudAccountStatus = function(secName){
		cloudActionStatusQuering = true;
		$.query(_cloudStatusDataOrg(secName), function(result){
			var state = _cloudParseError(result[ERR_CODE]);
			if (state.result == true)
			{
				var uciCS= cloudClientStatus;
				var status = parseInt(result[uciCS.fileName][secName][uciCS.optName.actionStatus]);
				var statusCC = uciCS.optValue.queryStatus;

				switch(status)
				{
				case statusCC.idle:
				case statusCC.max:
					state = _cloudParseError(result[ERR_CODE]);
					cloudParseHandle(cloudResultType.EXCEPTION, state);
					break;
				case statusCC.timeout:
					clearTimeout(cloudActionQueryStatusWaitHd);

					state = _cloudParseError(EINVREQUESTTIMEOUT);
					cloudParseHandle(cloudResultType.QUERY_REQ_TIMEOUT, state);
					break;
				case statusCC.prepare:
				case statusCC.trying:
					cloudActionQueryStatusHd = $.setTimeout(function(){
						_cloudAccountStatus(secName);
					}, CLOUD_STATUS_QUERY_TIMEOUT);
					return;
				case statusCC.failed:		/* 此处成功和失败是相同的处理，区别在于具体的错误码不同，需要具体的调用者具体分析 */
				case statusCC.success:
					cloudParseHandle(cloudResultType.FINISH, state, result);
					break;
				default:
					state = _cloudParseError(ESYSTEM);
					cloudParseHandle(cloudResultType.EXCEPTION, state);
					break;
				}

				cloudActionStatusQuering = false;
				clearTimeout(cloudActionQueryStatusWaitHd);
			}
			else
			{
				cloudParseHandle(cloudResultType.EXCEPTION, state);
				_setCloudHandle(null);
				cloudActionStatusQuering = false;
				clearTimeout(cloudActionQueryStatusWaitHd);
			}
		}, undefined, true);
	};

	/* 开始执行查询的状态 */
	this._cloudActionQueryStatus = function(secName, forced){
		/* 查询动作被手动关闭, 则直接退出 */
		var state;

		if (true == cloudActionQueryStoped)
		{
			return;
		}

		if (true == cloudActionStatusQuering && false == forced)	/* 之前的动作正在执行 */
		{
			state = _cloudParseError(EINVLASTOPTIONISNOTFINISHED);
			cloudParseHandle(cloudResultType.EXCEPTION, state);
		}
		else
		{
			cloudActionStatusQuering = false;
			clearTimeout(cloudActionQueryStatusHd);
			clearTimeout(cloudActionQueryStatusWaitHd);

			/* 设置超时处理 */
			cloudActionQueryStatusWaitHd = $.setTimeout(function(){
				cloudActionStatusQuering = false;
				clearTimeout(cloudActionQueryStatusHd);

				state = _cloudParseError(EINVREQUESTTIMEOUT);
				cloudParseHandle(cloudResultType.QUERY_ALL_TIMEOUT, state);
			}, CLOUD_STATUS_QUERY_TIMEOUT_WAIT);

			/* 开始查询 */
			_cloudAccountStatus(secName);
		}
	};

	/* 检查重置(找回)密码的验证码是否正确 */
	this.cloudAccountRstPwdCheckCAPTCHA = function(account, CAPTCHA, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.checkResetPwdVerifyCode] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.verifyCode] = CAPTCHA;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.checkResetPwdVerifyCode, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 获取重置(找回)密码的验证码 */
	this.cloudAccountRstPwdAC = function(account, accountType, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.getResetPwdVerifyCode] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.accountType] = accountType;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.getResetPwdVerifyCode, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 重置（找回）MERCURY ID的密码 */
	this.cloudAccountRstPwd = function(account, pwd, CAPTCHA, accountType, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.resetPassword] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.verifyCode] = CAPTCHA;
		secObj[uciCC.optName.password] = pwd;
		secObj[uciCC.optName.accountType] = accountType;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.resetPassword, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 登录MERCURY ID */
	this.cloudAccountBind = function(account, pwd, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.bind] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.password] = pwd;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.bind, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 获取创建MERCURY ID的验证码 */
	this.cloudAccountGetRegistAC = function(account, accountType, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.getRegVerifyCode] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.accountType] = accountType;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.getRegVerifyCode, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 创建MERCURY ID */
	this.cloudAccountRegist = function(account, accountType, pwd, CAPTCHA, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.register] = {};
		secObj[uciCC.optName.username] = account;
		secObj[uciCC.optName.accountType] = accountType;
		secObj[uciCC.optName.verifyCode] = CAPTCHA;
		secObj[uciCC.optName.password] = pwd;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.register, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 解绑MERCURY ID */
	this.cloudAccountUnind = function(parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.unbind] = {};
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.unbind, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true, true);
	};

	/* 修改MERCURY ID密码 */
	this.cloudAccountModifyPwd = function(oldpwd, newPwd, parseHandle){
		var secObj, data = {};
		var uciCC = uciCloudConfig;

		data[uciCC.fileName] = {};
		secObj = data[uciCC.fileName][uciCC.actionName.modifyAccountPwd] = {};
		secObj[uciCC.optName.oldPassword] = oldpwd;
		secObj[uciCC.optName.newPassword] = newPwd;
		cloudActionQueryStoped = false;
		_setCloudHandle(parseHandle);

		$.action(data, function(result){
			/* 查询动作被手动关闭, 则直接退出 */
			if (true == cloudActionQueryStoped)
			{
				return;
			}

			var state = _cloudParseError(result[ERR_CODE]);

			if (true == state.result)
			{
				var uciCS = cloudClientStatus;
				_cloudActionQueryStatus(uciCS.secName.modifyAccountPwd, true);
			}
			else
			{
				cloudParseHandle(cloudResultType.ACTION_ERROR, state);
				_setCloudHandle(null);
			}
		}, true);
	};

	/* 请在此处继续添加其他的处理 */
}

function CloudUpgradePush()
{
	this.pageCloudPush = true;	/* 登陆页面期间只弹出一处升级提示 */
	this.gOnlineUpgradeNote = "";
	this.upgradeErrCBCloudPush = null;
	this.gOnlineUpgradeFail = false;
	this.errHandleCloudPush = function(errNo)
	{
		switch (errNo)
		{
		case ENONE:
			return true;
		case EFWNOTSUPPORTED:
		case EFILETOOBIG:
		case EFWEXCEPTION:
			gOnlineUpgradeNote = errStr.fwFmtErr;
			break;
		case EFWNOTINFLANDBL:
		case EFWNEWEST:
			gOnlineUpgradeNote = errStr.fwNotSupported;
			break;
		case EINVMEMORYOUT:
		case EINVDOWNLOADFWFAILED:
		case EINVSENDREQMSGFAILED:
		case EINVREQUESTTIMEOUT:
		case EINVCONNECTTINGCLOUDSERVER:
		case EINVLASTOPTIONISNOTFINISHED:
		case ESYSBUSY:
			gOnlineUpgradeNote = errStr.fwDownLoadFailed;
			break;
		case EINVDEVICEIDNOTEXIST:
		case EINVERRORDEVICEIDFORMATERROR:
		case EINVILLEGALDEVICE:
			gOnlineUpgradeNote = appendErrCode(errStr.cloudDeviceInfoExpt, errNo);		/* 设备非法 */
			break;
		case EINVCLOUDCLIENTGENERIC:
		case EINVCLOUDCLIENTDOWNLOADPARSEDNSREQUEST:
		case EINVCLOUDCLIENTDOWNLOADESTABLISHTCP:
		case EINVCLOUDCLIENTDOWNLOADHTTPNOTOK:
		case EINVCLOUDCLIENTDOWNLOADTIMEOUT:
			gOnlineUpgradeNote = appendErrCode(errStr.invNetworkErr, errNo);	 /* 网络异常，请稍后重试 */
			break;
		case EINVFMT:
		case EFWRSAFAIL:
		case EFWHWIDNOTMATCH:
		case EFWZONECODENOTMATCH:
		case EFWVENDORIDNOTMATCH:
		case EINVUPGRADEFWFAILED:
		default:
			gOnlineUpgradeNote = errStr.fwUpgradeFailed;
			break;
		}

		//$.setTimeout(upgradeFailHdCloudPush, 10);
		return false;
	};

	/*
	this.showUpdateInfoLoading = function(noteStr, cancelClk, callback, classObj){
		showCoverB(function(cover){
			var cover$ = $("#" + cover.id);
			var loadClass;

			var conf = document.createElement("div");
			conf.id = "UpgradeSoftConfitrm";
			document.body.appendChild(conf);

			if (classObj != undefined)
			{
				loadClass = classObj.loadClass;
			}

			cover$.css("opacity", 0.4);

			var loadCon = document.createElement("div");
			loadCon.className = loadClass || "UpgradeSoftLoading";

			var loadImg = document.createElement("img");
			loadImg.className = "UpgradeLoadingImg";
			loadImg.src = "../web-static/images/loadingB.gif";
			loadCon.appendChild(loadImg);

			var loadDes = document.createElement("p");
			loadDes.className = "LoadingDes";
			loadDes.innerHTML = noteStr;
			loadCon.appendChild(loadDes);

			var btnDiv = document.createElement("div");
			btnDiv.className = "LoadingBtnDiv";

			var loadBtn = document.createElement("input");
			loadBtn.type = "button";
			loadBtn.onclick = function(){
				closeUpdateInfoLoading(cancelClk);
			};
			loadBtn.value = btn.cancel;
			btnDiv.appendChild(loadBtn);

			loadCon.appendChild(btnDiv);
			conf.appendChild(loadCon);

			conf.style.visibility = "visible";
			conf.style.top = "90px";
		});
	}*/

	this.closeUpdateInfoLoading = function(callback){
		var con = id("UpgradeSoftConfitrm");
		if (con != undefined)
		{
			document.body.removeChild(con);
		}

		hideCoverB();

		typeof callback == "function" && callback();
	}

	this.setUpgradeErrCBCloudPush = function(handle){
		this.upgradeErrCBCloudPush = handle;
	};

	this.upgradeFailHdCloudPush = function()
	{
		if (typeof this.upgradeErrCBCloudPush == "function")
		{
			this.upgradeErrCBCloudPush();
			this.upgradeErrCBCloudPush = null;
		}
	};

	/* 检查是否正在升级 */
	this.checkOnlineUpgrading = function(unUpgradingHd){
		var statusFile = cloudClientStatus.fileName;
		var downloadProg = {};

		downloadProg[statusFile] = {};
		downloadProg[statusFile][KEY_NAME] = cloudClientStatus.secName.clientInfo;

		if (true == $.local)
		{
			unUpgradingHd();
			return;
		}

		$.query(downloadProg, function(result){
			if (ENONE == result[ERR_CODE])
			{
				var cloudInfo = result[statusFile][cloudClientStatus.secName.clientInfo];
				var fwDownloadStatus = parseInt(cloudInfo[cloudClientStatus.optName.fwDownloadStatus]);

				if (uciCloudConfig.optValue.cloudDownloading == fwDownloadStatus)
				{
					onlineUpgradeProgress(SYSUPGRADE_SECONDS);
				}
				else
				{
					unUpgradingHd();
				}
			}
			else
			{
				unUpgradingHd();
			}
		});
	};

	this.onlineUpgradeProgress = function(waitTime){
		var statusFile = cloudClientStatus.fileName;
		var timeout = 500;

		loadingDialog.show({
			title: label.upgradeOnline,
			content:{
				primary: label.upgrading,
				secondary: label.upgradingTips
			}
		}, undefined, undefined, false, undefined);

		function queryDownloadStatus(){
			var downloadProg = {};

			downloadProg[statusFile] = {};
			downloadProg[statusFile][KEY_NAME] = cloudClientStatus.secName.clientInfo;

			$.query(downloadProg, function(result){
				var code = result[ERR_CODE];
				if (true == errHandleCloudPush(code))
				{
					var cloudInfo = result[statusFile][cloudClientStatus.secName.clientInfo];
					var fwDownloadStatus = parseInt(cloudInfo[cloudClientStatus.optName.fwDownloadStatus]);

					if (uciCloudConfig.optValue.cloudDownloading == fwDownloadStatus)
					{
						$.setTimeout(queryDownloadStatus, timeout);
					}
					else if(uciCloudConfig.optValue.cloudOutline == fwDownloadStatus)
					{
						gOnlineUpgradeNote = statusStr.fwDownLoadErr;
						upgradeFailHdCloudPush();
					}
					else if (uciCloudConfig.optValue.cloudComplete == fwDownloadStatus)
					{
						$.setTimeout(function(){
							var url = window.location.href;
							var index = url.indexOf("?");

							if (index >= 0)
							{
								url = url.substring(0, index);
							}

							$.setTimeout(function(){
								lanDetecting(function(){location.href = url;});
							}, LAN_DETECT_TIME);
						}, waitTime);
					}
					else
					{
						$.setTimeout(queryDownloadStatus, timeout);
					}
				}
				else
				{
					gOnlineUpgradeNote = statusStr.fwDownLoadErr;
					upgradeFailHdCloudPush();
				}
			}, true, true);
		}

		queryDownloadStatus();
	};

	/* 检查升级信息完成后进行下载更新 */
	this.checkFWVerSuccessCloudPush = function()
	{
		var uciFile = uciCloudConfig.fileName;
		var data = {};

		data[uciFile] = {};
		data[uciFile][uciCloudConfig.actionName.downloadFw] = null;

		$.action(data, function(dataObj){
			if (true == errHandleCloudPush(dataObj[ERR_CODE]))
			{
				var waitTime = dataObj["wait_time"]
							 ? parseInt(dataObj["wait_time"])*1000
							 : SYSUPGRADE_SECONDS;

				onlineUpgradeProgress(waitTime);
			}
			else
			{
				upgradeFailHdCloudPush();
			}
		}, undefined, true);
	}

	this.onlineUpgradeCheck = function(checkErrHd, checkFwFailHd, checkFwSuccessHd)
	{
		var uciFile = uciCloudConfig.fileName;
		var statusFile = cloudClientStatus.fileName;
		var data = {};

		/* 查询检查升级信息的结果 */
		function checkFWVer()
		{
			var checkFwVerFail = 0;
			var checkFwVerOK = 4;
			var checkFwVerTimeout = 5;
			var data = {};

			data[statusFile] = {};
			data[statusFile][KEY_NAME] = cloudClientStatus.secName.checkFwVer;
			$.query(data, function(result){
				if (true == checkErrHd(result[ERR_CODE]))
				{
					var actionStatus = result[statusFile][cloudClientStatus.secName.checkFwVer][cloudClientStatus.optName.actionStatus];
					switch(parseInt(actionStatus))
					{
					case checkFwVerFail:
					case checkFwVerTimeout:
						typeof checkFwFailHd == "function" && checkFwFailHd(result[statusFile][cloudClientStatus.secName.checkFwVer][cloudClientStatus.optName.errCode]);
						break;
					case checkFwVerOK:
						typeof checkFwSuccessHd == "function" && checkFwSuccessHd();
						break;
					default:
						$.setTimeout(checkFWVer, 500);
						break;
					}
				}
				else
				{
					typeof checkFwFailHd == "function" && checkFwFailHd();
				}
			}, undefined, true);
		}

		data[uciFile] = {};
		data[uciFile][uciCloudConfig.actionName.checkFwVersion] = null;

		/* 检查升级信息 */
		$.action(data, function(result){
			if (true == checkErrHd(result[ERR_CODE]))
			{
				checkFWVer();
			}
		}, undefined, true);
	};

	this.onlineUpgrade = function(upgradeErrCallBack, checkFwSuccessHd)
	{
		this.upgradeErrCBCloudPush = upgradeErrCallBack;
		this.gOnlineUpgradeNote = "";
		this.onlineUpgradeCheck(errHandleCloudPush, function(){
				gOnlineUpgradeNote = statusStr.fwDownLoadErr;
				upgradeFailHdCloudPush();
			}, function(){
				/* 检查成功。准备升级 */
				typeof checkFwSuccessHd == "function" && checkFwSuccessHd(function(){
					checkFWVerSuccessCloudPush();
				});
			}
		);
	};
}
/* End of Add By zhangwenhao: 此处开始添加云功能的支持 */

function Phone()
{
	this.OS = {
		windows:		false,
		windowsPhone:	false,
		unixPC:			false,
		iPad:			false,
		iPhone:			false,
		iMacPC:			false,
		iPod:			false,
		android:		false,
		nokia:			false,
		player:			false,
		Android_UC:		false,
		portable:		false,

		/* true is handled device; false is large device which is not for handler */
		checkDeviceMode:function ()
		{
			var pl = navigator.platform;
			var ua = navigator.userAgent;

			if (undefined != pl)
			{
				/* windows or windows phone */
				if (pl.indexOf("Win") >= 0)
				{
					if (ua.indexOf("Windows Phone") >= 0)
					{
						this.windowsPhone = true;
						this.windows = true;
						this.portable = true;
					}
					else
					{
						this.windows = true;
						this.portable = false;
					}

					return;
				}

				/* nokia */
				if (ua.indexOf("NOKIA") >= 0)
				{
					this.nokia = true;
					this.portable = true;
					return;
				}

				/* android */
				if (ua.indexOf("Android") >= 0)
				{
					this.android = true;
					this.portable = true;
					return;
				}

				/* iPad */
				if (pl.indexOf("iPad") >= 0)
				{
					this.iPad = true;
					this.portable = true;
					return;
				}

				/* iPhone */
				if (pl.indexOf("iPhone") >= 0)
				{
					this.iPhone = true;
					this.portable = true;
					return;
				}

				/* iPod */
				if (pl.indexOf("iPod") >= 0)
				{
					this.iPod = true;
					this.portable = true;
					return;
				}

				/* Wii or PLASTATION which is under version three */
				if ((ua.indexOf("Wii") >= 0) || (ua.indexOf("PLASTATION") >= 0))
				{
					this.player = true;
					this.portable = true;
					return;
				}

				/* MacBook of apple */
				if (pl.indexOf("Mac") >= 0)
				{
					this.iMacPC = true;
					this.portable = false;
					return;
				}

				/* unix include Linux */
				if ((pl.indexOf("X11") >= 0) || ((pl.indexOf("Linux") >= 0) && (pl.indexOf("arm") < 0)))
				{
					this.unixPC = true;
					this.portable = false;
					return;
				}

				return;
			}
			else if (ua.indexOf("Android") >= 0)
			{
				this.android = true;
				this.portable = true;
				return;
			}
			else
			{
				if (document.body.clientWidth >= 1024 || document.body.clientHeight >= 1024)
				{
					this.portable = false;
				}
				else
				{
					this.portable = true;
				}

				return;
			}
		}
	};

	this.phoneSet = {
		bContinuePCSet:false,
		bPhoneWizardSet:false
	};

	OS.checkDeviceMode();
}

/*added by WuWeier, 适用于Slp的函数 */
function Slp()
{
	this.cloneObj = function(obj)
	{
		var re = {};

		if (typeof (obj) != 'object')
		{
			return obj;
		}

		if (obj.constructor == Array)
		{
			re = [];
		}

		for ( var i in obj)
		{
			re[i] = cloneObj(obj[i]);
		}

		return re;
	};

	/* 去掉IP地址或端口中的前导0 */
	this.hideLeadingZeros = function(str)
	{
		return str.replace(/0*(\d+)/g, "$1");
	};

	/* 计算字符串UTF-8编码后的字节数 */
	this.getUTF8StrLen = function(str)
	{
		var encodeStr = escape(str), cnt = 0;

		for (var i = 0; i < encodeStr.length; i++)
		{
			if (encodeStr.charAt(i) == "%")
			{
				if (encodeStr.charAt(i+1) == "u")
				{
					var value = parseInt(encodeStr.substr(i+2, 4), 16);
					if (value < 0x0800)
					{
						cnt += 2;
					}
					else
					{
						cnt += 3;
					}

					i += 5;
				}
				else
				{
					cnt++;
					i += 2;
				}
			}
			else
			{
				cnt++;
			}
		}

		return cnt;
	};

	this.calcNextIndex = function(array, pos)
	{
		if (array == null || !(array instanceof Array))
		{
			return -1;
		}

		var indexArr = [];
		for (var i in array)
		{
			var name = array[i][SEC_NAME];
			if (typeof name == "undefined" || typeof name != "string")
			{
				continue;
			}

			var index = name.replace(/^.*_(\d+)$/g, '$1');
			indexArr[index] = true;
		}

		var len = indexArr.length;
		if (!(/\D/g.test(pos)) && pos >= len)
		{
			return pos;
		}

		var i = (/\D/g.test(pos)) ? 1 : pos;
		for (; i <= len; i++)
		{
			if (typeof indexArr[i] == "undefined")
			{
				return i;
			}
		}

		return (len + 1);
	};

	this.formatTableData = function (array)
	{
		var re = [];
		if (array == null || !(array instanceof Array))
		{
			return re;
		}

		for (var i=0;i<array.length;i++)
		{
			var obj = array[i];
			for (var prop in obj)
			{
				if (!obj.hasOwnProperty(prop)){
					continue;
				}
				obj[prop][SEC_NAME] = prop;
				re[i] = obj[prop];
			}
		}

		return re;
	};
}

function MacFactoryFun()
{
	this.getMacBrandObj = function(item){
		var brandArrLen = MacFactoryArr.length;
		var macItem, targetItem = null;
		var mac = (item.mac).substring(0, 8).toUpperCase().replace(/:/g, "-");

		for (var i = 0; i < brandArrLen - 1; i++)
		{
			macItem = MacBrands[MacFactoryArr[i]["name"]];

			if ((undefined != macItem) && (macItem.indexOf(mac) >= 0))
			{
				targetItem = MacFactoryArr[i];
				break;
			}
		}

		return targetItem;
	}

	this.macBrandTransition = function(item){
		var targetItem = getMacBrandObj(item);
		var brandArrLen = MacFactoryArr.length;

		if (targetItem != null)
		{
			item.logoPosX = targetItem.posX;
			item.logoPosY = targetItem.posY;
		}
		else
		{
			if (item.type == uciHostsInfo.optValue.linkType.wired)
			{
				item.logoPosX = MacFactoryArr[brandArrLen - 2].posX;
				item.logoPosY = MacFactoryArr[brandArrLen - 2].posY;
			}
			else
			{
				item.logoPosX = MacFactoryArr[brandArrLen - 3].posX;
				item.logoPosY = MacFactoryArr[brandArrLen - 3].posY;
			}
		}
	}

	this.getBrandName = function(item, language){
		var targetItem = getMacBrandObj(item);

		if (targetItem != null)
		{
			if (targetItem[language] != undefined)
			{
				return targetItem[language];
			}
			else
			{
				return "-";
			}
		}
		else
		{
			return "-";
		}
	}
}

function Custom()
{
	this.getBridgeStatus = function(callback)
	{
		var data = {};
		data[uciCustomNetwork.fileName] = {};
		data[uciCustomNetwork.fileName][KEY_NAME] = uciCustomNetwork.dynData.bridgeStatus;

		$.query(data, function(resp){
			var bridgeEnable = resp[uciCustomNetwork.fileName][uciCustomNetwork.dynData.bridgeStatus][uciCustomNetwork.optName.enable] == uciCustomNetwork.optValue.mode.bridge;

			typeof callback == "function" && callback(bridgeEnable);
		});
	}

	this.getPwdComplexity = function(str)
	{
		var result = 0;
		var hasNum = 0;
		var hasLetter = 0;
		var hasSymbol = 0;

		hasNum = /\d/g.test(str) ? 1 : 0;
		hasLetter = /[a-zA-Z]/g.test(str) ? 1 : 0;
		hasSymbol = /[\x21-\x2f\x3a-\x40\x5b-\x60\x7b-\x7e\s]/g.test(str) ? 1 : 0;

		result = hasNum + hasSymbol + hasLetter
		return result;
	}
}

function PortConfig() {
	PortConfig.prototype.init = function(initData) {
		this.initData = initData;
		this.portRateIconHtmlStr = {"default": '<i class="geDesc"></i>',"GE": '<i class="geDesc"></i>',"2.5GE": '<i class="twoPointFiveGeDesc"></i>'};
		this.sfpIconHtmlStr = '<i class="sfpDesc"></i>';
		this.portItemImageHtmlStr = [{"active":'<i class="activeSetPort"></i>',"disable":'<i class="disableSetPort"></i>',"normal":'<i class="normalSetPort"></i>'},
		{"active":'<i class="activeDisplayPort"></i>',"disable":'<i class="disableDisplayPort"></i>',"normal":'<i class="normalDisplayPort"></i>'}];
		this.portItemNameHtmlStr = {"active": '<div class="activePortItemName">',"normal":'<div class="normalPortItemName">',"disable": '<div class="disablePortItemName">'};
		this.portItemNameClass = {"active":"activePortItemName","normal":"normalPortItemName","disable":"disablePortItemName"};
		this.render();
		return this;
	};
	PortConfig.prototype.initPortTitleWidth = function(){
		var element = this.initData.element;
		var $element = $(element);
		var portWidth = $element.find(".portArea").outerWidth();
		var offLineWidth = $element.find(".offLine").outerWidth(true);
		$element.find(".routerName").outerWidth(portWidth - offLineWidth);
	};
	PortConfig.prototype.initPortItemHtmlStr = function(type,state,name,rate,isSfp) {
		var htmlStr = '\
		<div class="portItem">\
			<div class="portItemDesc">' + this.portRateIconHtmlStr[rate] + (isSfp? this.sfpIconHtmlStr : "") + '\
			</div>\
			<div class="portItemImage">' + (type == "display" ? this.portItemImageHtmlStr[1][state] : this.portItemImageHtmlStr[0][state]) + '\
			</div>' + this.portItemNameHtmlStr[state] + name + '\
			</div>\
		</div>';
		return htmlStr;
	}

	PortConfig.prototype.render = function() {
		var $element = this.initData.element;
		var type = this.initData.type;
		var port = this.initData.port;
		var powerPos = this.initData.powerPos;
		var powerIdx = typeof this.initData.powerIdx !== "undefined" ? parseInt(this.initData.powerIdx) : 0;
		var showRouterName = typeof this.initData.showRouterName !== "undefined" && this.initData.showRouterName;
		var routerName = this.initData.routerName;
		var showOffLine = typeof this.initData.showOffLine !== "undefined" && this.initData.showOffLine;
		var displayClickable = typeof this.initData.displayClickable != "undefined" && this.initData.displayClickable;
		var portNum = port.length;
		var $portConfig;
		var $powerImg;
		var $portImgArray;
		var me = this;

		if (type === "display") {
			if(showRouterName){
				$element.innerHTML = '\
					<div class="portCustomImage display">\
					<div class="routerInfo">\
						<label class="routerName">' + routerName +'</label>\
						<div class="offLine"><i class="offLineDot"></i><span>已离线</span></div>\
						</div>\
						<div class="portArea">\
						</div>\
					</div>';
				if(!showOffLine){
					var portOffLine = $element.querySelector(".offLine");
					$(portOffLine).hide();
				}else{
					$($element).prepend('<div class="offLineTips"><i class="iconfont icon-error"></i>设备已离线，请检查路由器连接或重新选择端口。</div>')
				}
			} else {
				$element.innerHTML = '<div class="portCustomImage display"><div class="portArea"></div></div>';
			}
			$portConfig = $element.querySelector(".portArea");

			for (var index = 0; index < portNum; index++) {
				if (index === powerIdx) {
					$portConfig.innerHTML += '\
						<div class="portPowerItem">\
							<div class="portPowerDesc"></div>\
							<div class="portPowerImage">\
								<i></i>\
							</div>\
							<div class="portItemName">Power</div>\
						</div>\
					';
				}
				$portConfig.innerHTML += this.initPortItemHtmlStr("display",port[index].state,port[index].name,port[index].rate ? port[index].rate:"default",port[index].isSfp);
			}

			$powerImg = $portConfig.querySelector(".portPowerItem");
			$powerImg.style.float = powerPos;

			$portImgArray = $portConfig.querySelectorAll(".portItem");

			for (var index = 0, length = $portImgArray.length; index < length; index++) {
				$portImgArray[index].style.float = powerPos;
			}
			if(displayClickable){
				for (var index = 0, length = $portImgArray.length; index < length; index++) {
					$portImgArray[index].index = index;
					$portImgArray[index].onclick = function() {
						switch (me.initData.port[this.index].state) {
							case "disable":
								return;
							case "normal":
								me.initData.port[this.index].state = "active";
								me.refresh();
								break;
							case "active":
								me.initData.port[this.index].state = "normal";
								me.refresh();
								break;
						}
						if (Object.prototype.toString.call(me.initData.callback) === "[object Function]") {
							me.initData.callback({
								"index": "" + this.index,
								"state": me.initData.port[this.index].state,
								"name": me.initData.port[this.index].name,
								"num": me.initData.port.length
							});
						}
					};
				}
			}
			this.initPortTitleWidth();
		}
		if (type === "setting") {
			if(showRouterName){
				$element.innerHTML = '\
					<div class="portCustomImage setting">\
					<div class="routerInfo">\
						<label class="routerName">' + routerName +'</label>\
						<div class="offLine"><i class="offLineDot"></i><span>已离线</span></div>\
						</div>\
						<div class="portArea">\
						</div>\
					</div>';
				if(!showOffLine){
					var portOffLine = $element.querySelector(".offLine");
					$(portOffLine).hide();
				}
			} else {
				$element.innerHTML = '<div class="portCustomImage setting"><div class="portArea"></div></div>';
			}
			$portConfig = $element.querySelector(".portArea");

			for (var index = 0; index < portNum; index++) {
				if (index === powerIdx) {
					$portConfig.innerHTML += '\
					<div class="portPowerItem">\
						<div class="portPowerDesc"></div>\
						<div class="portPowerImage">\
							<i></i>\
						</div>\
						<div class="portItemName">Power</div>\
					</div>\
					';
				}
				$portConfig.innerHTML += this.initPortItemHtmlStr("setting",port[index].state,port[index].name,port[index].rate ? port[index].rate:"default",port[index].isSfp);
			}

			$powerImg = $portConfig.querySelector(".portPowerItem");
			$powerImg.style.float = powerPos;

			$portImgArray = $portConfig.querySelectorAll(".portItem");

			for (var index = 0, length = $portImgArray.length; index < length; index++) {
				$portImgArray[index].style.float = powerPos;
				$portImgArray[index].index = index;
				$portImgArray[index].onclick = function() {
					switch (me.initData.port[this.index].state) {
						case "disable":
							return;
						case "normal":
							me.initData.port[this.index].state = "active";
							me.refresh();
							break;
						case "active":
							me.initData.port[this.index].state = "normal";
							me.refresh();
							break;
					}
					if (Object.prototype.toString.call(me.initData.callback) === "[object Function]") {
						me.initData.callback({
							"index": "" + this.index,
							"state": me.initData.port[this.index].state,
							"name": me.initData.port[this.index].name,
							"num": me.initData.port.length
						});
					}
				};
			}
			this.initPortTitleWidth();
		}
	};

	PortConfig.prototype.refresh = function() {
		var $element = this.initData.element;
		var type = this.initData.type;
		var port = this.initData.port;
		var powerPos = this.initData.powerPos;
		var powerIdx = typeof this.initData.powerIdx === "undefined" ?  0 : parseInt(this.initData.powerIdx);
		var portNum = port.length;
		var $portImgArray = $element.querySelectorAll(".portItem");
		var $powerImg = $element.querySelector(".portPowerItem");
		var showRouterName = typeof this.initData.showRouterName !== "undefined" && this.initData.showRouterName;
		var showOffLine = typeof this.initData.showOffLine !== "undefined" && this.initData.showOffLine;
		if(!showRouterName){
			var routerInfo = $element.querySelector(".routerInfo");
			$(routerInfo).hide();
		} else {
			var routerInfo = $element.querySelector(".routerInfo");
			$(routerInfo).show();
			if(!showOffLine){
				var portOffLine = $element.querySelector(".offLine");
				$(portOffLine).hide();
			} else {
				$(portOffLine).show();
			}
		}

		if (portNum !== $portImgArray.length ||
			$element.querySelector(".portCustomImage." + type) === null ||
			$powerImg.style.float !== powerPos ||
			$element.querySelector(".portCustomImage .portArea").children[powerIdx].className !== "portPowerItem") {
			this.render();
			return;
		}
		for (var index = 0; index < portNum; index++) {
			$portImgArray[index].children[1].innerHTML = type == "setting" ? this.portItemImageHtmlStr[0][port[index].state] : this.portItemImageHtmlStr[1][port[index].state];
			$portImgArray[index].children[2].innerHTML = port[index].name;
			$portImgArray[index].children[2].className = this.portItemNameClass[port[index].state];
		}
	};

	PortConfig.prototype.transRoleName = function(role){
		var roleType = role.slice(0,3).toUpperCase();
		var roleName = "";
		switch(roleType){
			case "WAN":
				roleName = role.toUpperCase();
				break;
			case "LAN":
				roleName = role.toUpperCase();
				break;
			case "DOW":
				if(role == 'downlink1'){
					roleName = label.iptvPort1;
				}else{
					roleName = label.iptvPort2;
				}
				break;
			case "IPT":
				roleName = label.iptvPort;
				break;
			case "LAG":
				roleName = label.lagPort;
				break;
			case "GAM":
				roleName = label.gamePort;
				break;
			case "UPL":
				if(role == 'uplink1'){
					roleName = label.iptvUplinkPort1;
				}else{
					roleName = label.iptvUplinkPort2;
				}
				break;
			default:
				roleName = "LAN";
				break;
		}
		return roleName;
	};

	PortConfig.prototype.getPhySpeedByIndex = function(phyInfoList,index,sfpCapabilityList){
		function changeSpeedType(speed){
			switch (speed){
				case '1000M':
					return 'GE';
				case '2.5G':
					return '2.5GE';
				case '10G':
					return '10GE';
				default:
					return speed;
			}
		}
		if(phyInfoList[index].type.toUpperCase() == "SFP"){
			return changeSpeedType(sfpCapabilityList[sfpCapabilityList.length-1]);
		}else{
			return changeSpeedType(phyInfoList[index]["speed"]);
		}
	}

	PortConfig.prototype.setPort = function (index, portInfo) {
		if (portInfo.name !== undefined) {
			this.initData.port[index].name = portInfo.name;
		}
		if (portInfo.state !== undefined) {
			this.initData.port[index].state = portInfo.state;
		}
		if (portInfo.role !== undefined) {
			this.initData.port[index].role = portInfo.role;
		}

		this.refresh();
		return;
	}

	PortConfig.prototype.getPort = function (index) {
		return {
			"name": this.initData.port[index].name,
			"state": this.initData.port[index].state,
			"role": this.initData.port[index].role
		}
	}

	PortConfig.prototype.initDevInfo = function(portId, dev_info, type, callback, hideTitle,sfpCapabilityList){
		var online = parseInt(dev_info.online);
		var power_pos = dev_info.power_pos || "right";
		var power_index = typeof dev_info.power_index !== "undefined" ? parseInt(dev_info.power_index) : 0;
		var name = dev_info.name || label.routerName;
		var phy_info = dev_info.phy_info || [];
		var portData = [];
		this.initPortData(phy_info,'NULL',portData,sfpCapabilityList);
		var initData = {
			element: $('#'+ portId)[0],
			type: type == 1 ? 'setting':'display',
			port: portData,
			powerPos: power_pos,
			powerIdx: power_index,
			callback: callback,
			routerName: name,
			showRouterName: hideTitle != 1,
			showOffLine: !online
		}
		return this.init(initData);
	}

	PortConfig.prototype.refreshDevInfo = function (dev_info) {
		if (dev_info) {
			var online = parseInt(dev_info.online);
			var power_pos = dev_info.power_pos || "right";
			var power_index = typeof dev_info.power_index !== "undefined" ? parseInt(dev_info.power_index) : 0;
			var name = dev_info.name || label.routerName;
			var phy_info = dev_info.phy_info || [];
			var portData = [];
			this.initPortData(phy_info,'NULL',portData);
			this.initData.port = portData;
			this.initData.powerPos = power_pos;
			this.initData.powerIdx = power_index;
			this.initData.routerName = name;
			this.initData.showOffLine = !online;
		}
		this.render();
		return;
	}

	PortConfig.prototype.getActivePortList = function () {
		var portList = [];
		this.initData.port.forEach(function (el, idx) {
			if (el.state == "active") {
				portList.push({"index":idx,"phy_info":el});
			}
		});
		return portList;
	}

	PortConfig.prototype.initPortData = function(phyInfoList,feature,portData,sfpCapabilityList){
		var port_num = phyInfoList.length;
		portData.splice(0,portData.length);
		for(var i=0;i<port_num;i++){
			portData[i] = {};
		}
		for(var i=0;i<phyInfoList.length;i++){
			if(feature == 'NULL'){
				portData[i].state = phyInfoList[i].state || "normal";
				portData[i].name = phyInfoList[i].role ? PortConfig.prototype.transRoleName(phyInfoList[i].role) : 'LAN';
			}else if(feature == 'ALL'){
				if(phyInfoList[i][uciPortConfig.dynOptName.role].toUpperCase() == "LAN"){
                    portData[i].state = "normal";
                } else {
                    portData[i].state = "active";
				}
				portData[i].name = phyInfoList[i].role ? PortConfig.prototype.transRoleName(phyInfoList[i].role) : 'LAN';
			}else{
				if(phyInfoList[i]["role"].slice(0,3).toUpperCase() == feature){
					portData[i].state = "active";
					portData[i].name = PortConfig.prototype.transRoleName(phyInfoList[i]["role"]);
				}else if(phyInfoList[i]["role"].slice(0,3).toUpperCase() == "LAN"){
					portData[i].state = "normal";
					portData[i].name = "LAN";
				}else{
					portData[i].state = "disable";
					portData[i].name = PortConfig.prototype.transRoleName(phyInfoList[i]["role"]);
				}
			}
			portData[i].rate = PortConfig.prototype.getPhySpeedByIndex(phyInfoList,i,sfpCapabilityList);
			portData[i].isSfp = phyInfoList[i].type.toUpperCase() == "SFP";
		}
	}

	PortConfig.prototype.destroy = function() {
		this.initData.element.innerHTML = "";
	}
}

function RouterRelayConflict() {
	this.transRoleName = function (role, hasWanPhy, targetSysMode, isCap){
		var roleType = role.slice(0,3).toUpperCase();
		var roleName = "";
		switch(roleType){
			case "WAN":
				roleName = role.toUpperCase();
				break;
			case "LAN":
				//phy_info中没有WAN口 且 CAP 且 从中继切换到路由模式
				if (isCap && !hasWanPhy && targetSysMode == uciSystem.optValue.sysMode.routerMode) {
					roleName = "WAN/LAN";
				} else {
					roleName = role.toUpperCase();
				}
				break;
			case "DOW":
				roleName = "IPTV口";
				break;
			case "IPT":
				roleName = "IPTV口";
				break;
			case "LAG":
				roleName = "聚合口";
				break;
			case "GAM":
				roleName = "游戏专用口";
				break;
			case "UPL":
				roleName = "IPTV上联口";
				break;
			default:
				roleName = "LAN";
				break;
		}
		return roleName;
	};

	this.initPortData = function (phyInfoList, portData, targetSysMode, isCap){
		var i = 0;
		var hasWanPhy = false;		//有role为WAN的phy
		for(i = 0; i < phyInfoList.length; i++) {
			var roleType = phyInfoList[i]["role"].slice(0,3).toUpperCase();
			if (roleType == 'WAN') {
				hasWanPhy = true;
				break;
			}
		}

		for(i = 0; i < phyInfoList.length; i++) {
			portData[i] = {};
			portData[i].state = "normal";
			portData[i].name = transRoleName(phyInfoList[i]["role"], hasWanPhy, targetSysMode, isCap);
		}
	};

	this.showAlertDialog = function (innerHTML, callback) {
		var divCon = id("sysModeControlCon");
		if(divCon == null){
			divCon = document.createElement("div");
			divCon.className = "sysModeControlCon";
			divCon.id = "sysModeControlCon";
			document.body.appendChild(divCon);
		}else{
			emptyNodes(divCon);
		}
		divCon.innerHTML = innerHTML;
		var niceScroll = new NiceScroll({targetId:"popCon"});
		niceScroll.scrollTipOpacity(1);
		niceScroll.scrollTipSet({"background":"#E6E6E6"});
		niceScroll.scrollBarSet({zIndex:1010});
		niceScroll.init();
		callback();

		id("closePop").onclick = function() {
			setSysModeConDis(false);
		};
		id("cancel").onclick = function() {
			setSysModeConDis(false);
		};

		setSysModeConDis(true);
	};

	this.generatePortLayout = function (targetSysMode, routerArr) {
		$.action({"port_manage":{"get_new_dev_info":{"sys_mode":targetSysMode}}}, function(result) {
			var deviceList = result.dev_info;
			for(var i = 0; i < deviceList.length; i++) {
				if (deviceList[i].phy_info.length == 0) continue;

				var isCap = deviceList[i].cap == 1;
				var portArr = [];
				initPortData(deviceList[i].phy_info, portArr, targetSysMode, isCap);

				var router = {};
				router.portArr = portArr;
				router.name = deviceList[i].name;
				router.powerPos = deviceList[i].power_pos;

				//CAP在第一行显示
				if(isCap) {
					routerArr.unshift(router);
				} else {
					routerArr.push(router);
				}
			}
		}, false);
	};

	this.changeSysModeAlert = function (operate, targetSysMode, callback) {
		var hdTitle;
		var routerArr = [];
		var portCfgText = "";
		var changeModeTips = "";
		var bShowUnavailable = true;
		var bPortLayoutChanged = true;

		if (slp.gSupportPortManage) {
			generatePortLayout(operate == 'close' ? uciSystem.optValue.sysMode.routerMode : targetSysMode, routerArr);
		}

		if (0 == routerArr.length) {
			//routerArr为空 且 中继切换至路由模式时，不用弹框
			//operate为close时，也是从中继模式切换至路由模式
			if (operate == 'close' || uciSystem.optValue.sysMode.routerMode == targetSysMode) {
				callback();
				return;
			}

			bPortLayoutChanged = false;
		}

		switch (operate) {
			case "switch":
				hdTitle = "切换上网方式";
				if (uciSystem.optValue.sysMode.routerMode == targetSysMode) {
					changeModeTips = "切换上网方式后，路由器端口配置会发生变化，确定切换吗？";
					bShowUnavailable = false;
				} else {
					changeModeTips = "切换为" + (uciSystem.optValue.sysMode.apMode == targetSysMode ? "AP（有线中继）" : "桥接（无线中继）") + "后，部分功能将无法使用" + (bPortLayoutChanged ? '，且路由器端口配置会发生变化' : '') + "。确定切换吗？";
				}
				break;
			case "open":
				hdTitle = "开启" + (uciSystem.optValue.sysMode.apMode == targetSysMode ? "AP（有线中继）" : "桥接（无线中继）");
				changeModeTips = "开启" + (uciSystem.optValue.sysMode.apMode == targetSysMode ? "AP（有线中继）" : "桥接（无线中继）") + "后，部分功能将无法使用" + (bPortLayoutChanged ? '，且路由器端口配置会发生变化' : '') + "。确定开启吗？";
				break;
			case "close":
				hdTitle = "关闭" + (uciSystem.optValue.sysMode.apMode == targetSysMode ? "AP（有线中继）" : "桥接（无线中继）");
				changeModeTips = "关闭" + (uciSystem.optValue.sysMode.apMode == targetSysMode ? "AP（有线中继）" : "桥接（无线中继）") + "后，路由器端口配置会发生变化。确定关闭吗？";
				bShowUnavailable = false;
				break;
			default:
				break;
		}

		if (slp.gMulWanSupport && slp.gIptvSupport) {
			portCfgText = "端口功能自定义（双WAN口、IPTV口不可用）、";
		} else if (slp.gMulWanSupport) {
			portCfgText = "端口功能自定义（双WAN口不可用）、";
		} else if (slp.gIptvSupport) {
			portCfgText = "端口功能自定义（IPTV口不可用）、";
		}

		var innerHTML = '<div class="relayAlertCon">' +
			'<div class="popHd">' +
				'<span id="popTitle" class="title">' + hdTitle + '</span>' +
				'<i class="closeImg iconfont icon-close" id="closePop"></i>' +
			'</div>' +
			'<div class="popCon" id="popCon">' +
				'<p>' + changeModeTips + '</p>' +
				'<div id="unavailableDiv">' +
					'<p class="unavailable">不可用功能：</p>' +
					'<p>' + 'LAN口设置、' + portCfgText + (slp.ipv6Support ? 'IPv6设置、' : '') + 'DHCP服务器、DDNS、DMZ主机、IP与MAC绑定、虚拟服务器。' + '</p>' +
				'</div>' +
				'<div class="portLayoutDiv">' +
					'<p class="portTips">路由器端口配置将变为：</p>' +
				'</div>' +
			'</div>' +
			'<div class="popFoot">' +
				'<div id="cancel" class="buttonCMPT secondary" >' +
					'<span>取消</span>' +
				'</div>' +
				'<div id="changeMode" class="buttonCMPT primary" >' +
					'<span>确定</span>' +
				'</div>' +
			'</div>' +
		'</div>';
		showAlertDialog(innerHTML, function() {
			id("changeMode").onclick = function() {
				callback();
				setSysModeConDis(false);
			};

			if (!bShowUnavailable) {
				$("#unavailableDiv").hide();
			}

			if (0 == routerArr.length) {
				$(".portLayoutDiv").hide();
			} else {
				for (var i = 0; i < routerArr.length; ++i) {
					$(".portLayoutDiv").append('<p style="margin: 8px auto;">'+ routerArr[i].name + '</p><div class="portLayoutContainer' + i + '" style="margin-bottom: 24px;"></div>');
					var portLayoutConf = new PortConfig();
					var portInitData = {
						element: $('.portLayoutContainer' + i)[0],
						type: 'display',
						port: routerArr[i].portArr,
						powerPos: routerArr[i].powerPos,
						callback: null
					};
					portLayoutConf.init(portInitData);
				}
			}
		});
	};

	this.setSysModeConDis = function (tag) {
		var sysModeControlCon = id("sysModeControlCon");
		if (true === tag)
		{
			showCover(function(){
				sysModeControlCon.style.visibility = "visible";
				sysModeControlCon.style.top = "190px";
			});
		}
		else
		{
			hideCover(function(){
				sysModeControlCon.style.visibility = "hidden";
				sysModeControlCon.style.top = "-9999px";
				emptyNodes(sysModeControlCon);
			});
		}
	}
}

function MeshHelp() {
	this.setMeshHelpConDisplay = function(tag) {
		var sysModeControlCon = id("meshHelpCon");
		if (true === tag)
		{
			showCover(function(){
				sysModeControlCon.style.visibility = "visible";
				sysModeControlCon.style.top = "100px";
			});
		}
		else
		{
			hideCover(function(){
				sysModeControlCon.style.visibility = "hidden";
				sysModeControlCon.style.top = "-9999px";
				emptyNodes(sysModeControlCon);
			});
		}
	}

	this.showMeshHelpDialog = function() {
		var divCon = id("meshHelpCon");
		if (null == divCon)
		{
			divCon = document.createElement("div");
			divCon.className = "sysModeControlCon";
			divCon.id = "meshHelpCon";
			document.body.appendChild(divCon);
		}
		else
		{
			emptyNodes(divCon);
		}

		divCon.innerHTML =
			'<div class="meshHelpDiv">'+
				'<div class="popHd">' +
					'<i class="closeImg" id="closePop"></i>' +
				'</div>' +
				'<div class="popBody">' +
					'<p>本路由器可作为“易展”子路由器扩展现有无线网络：</p>' +
					'<div class="desCon" style="margin-right: 64px;">' +
						'<i class="resetIcon"></i>' +
						'<label>先将本路由器恢复至出厂状态（按住“Reset按键”直到系统指示灯闪烁后松开）。</label>' +
					'</div>' +
					'<div class="desCon">' +
						'<i class="meshButton"></i>' +
						'<label>本路由器恢复出厂状态后，分别按下前端“易展”主路由器和本路由器的“易展”按键进行组网配对。</label>' +
					'</div>' +
				'</div>' +
			'</div>';
		id("closePop").onclick = function(){
			setMeshHelpConDisplay(false);
		};
		setMeshHelpConDisplay(true);
	}
}

(function(){
	Phone.call(window);
	Tool.call(window);
	PageFunc.call(window);
	Cover.call(window);
	Explorer.call(window);
	LocalStorageSD.call(window);
	ShowTips.call(window);
	Select.call(window);
	Tips.call(window);
	LanDetect.call(window);
	Help.call(window);
	Slp.call(window);
	MacFactoryFun.call(window);
	CloudUpgradePush.call(window);
	CloudAction.call(window);
	CloudCommon.call(window);
	Custom.call(window);
	RouterRelayConflict.call(window);
	MeshHelp.call(window);
})();
