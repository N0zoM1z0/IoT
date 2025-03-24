var menuConfig = {
	menuTargetUrl:"",
	loadMainIndex:0,
	loadSubIndex:0,
	timeoutId:null
};

var menu = {
	netWorkData_menu:{
		value: menuStr.netData,
		className:"icon-networkparameter",
		url: "WanLoader.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.wanSet,
				url: "WanLoader.htm"
			},
			{
				value: menuStr.lanSet,
				url: "LanCfg.htm"
			},
			{
				value: menuStr.hnat,
				url: "HNat.htm"
			},
			{
				value: menuStr.macSet,
				url: "MacClone.htm"
			},
			{
				value: menuStr.DHCPServer,
				url: "DHCPServer.htm"
			},
			{
				value: menuStr.IPMACBind,
				url: "IPMACBind.htm"
			},
			{
				value: menuStr.ipv6,
				url: "WanIpv6Loader.htm"
			}
		]
	},

	wifiSet_menu:{
		value: menuStr.wifi,
		className:"icon-wifisetting",
		url: "WlanNetwork.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.wifiHost,
				url: "WlanNetwork.htm"
			},
			{
				value: menuStr.wifiGuestNet,
				url: "WlanGuestNetWorkCfg.htm"
			},
			{
				value: menuStr.multiSsid,
				url: "MultiSsid.htm"
			},
			{
				value: menuStr.wifiAllSwitch,
				url: "WifiMasterSwitch.htm"
			},
			{
				value: menuStr.wirelessSwitch,
				url: "WlanSwitch.htm"
			},
			{
				value: menuStr.wifiWDS,
				url: "WlanWDSCfg.htm"
			}
		]
	},

	netControl_menu:{
		value: menuStr.netControl,
		className:"icon-internetcontrol",
		url: "ParentControl.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.parentControl,
				url: "ParentControl.htm"
			},
			{
				value: menuStr.actionControl,
				url: "AccessCtrl.htm"
			},
			{
				value: menuStr.wlanAccess,
				url: "wlanACCfg.htm"
			}
		]
	},

	/*
	usbSet_menu:{
		value: menuStr.usbSet,
		className:"icon-usbsetting",
		url: "FileShare.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.fileShare,
				url: "FileShare.htm"
			},
			{
				value: menuStr.printServer,
				url: "PrintServer.htm"
			}
		]
	},*/

	highUser_menu:{
		value: menuStr.highUser,
		className:"icon-advanceduser",
		url: "VirtualServerCfg.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.virtualS,
				url: "VirtualServerCfg.htm"
			},
			{
				value: menuStr.DMZS,
				url: "DMZCfg.htm"
			},
			{
				value: menuStr.upnpSet,
				url: "UpnpCfg.htm"
			},
			{
				value: menuStr.router,
				url: "RouteTable.htm"
			},
			{
				value: menuStr.ddns,
				url: "DdnsCfg.htm"
			}
		]
	},

	sysTool_menu:{
		value: menuStr.sysTool,
		className:"icon-advancesetting",
		url: "BridgeSwitch.htm",
		hasSub: true,
		subMenu:
		[
			{
				value: menuStr.bridgeSwitch,
				url: "BridgeSwitch.htm"
			},
			{
				value: menuStr.lightNButton,
				url: "LightNButton.htm"
			},
			{
				value: menuStr.routerManage,
				url: "ManageSettingUp.htm"
			},
			{
				value: menuStr.upgrade,
				url: "SysUpgrade.htm",
				tagClass: "new",
				roleList: [USER_GROUP_ADMIN]
			},
			{
				value: menuStr.backupload,
				url: "SysBakNRestore.htm",
				roleList: [USER_GROUP_ADMIN]
			},
			{
				value: menuStr.resetNreboot,
				url: "SysResetNReboot.htm",
				roleList: [USER_GROUP_ADMIN]
			},
			{
				value: menuStr.rebootTimer,
				url: "RebootTimer.htm"
			},
			{
				value: menuStr.changeLgPwd,
				url: "SysChangeLgPwd.htm",
				roleList: [USER_GROUP_ADMIN]
			},
			{
				value: menuStr.diagnostic,
				url: "Diagnostic.htm"
			},
			{
				value: menuStr.syslog,
				url: "SystemLog.htm"
			},
			{
				value: menuStr.elink,
				url: "Elink.htm"
			},
			{
				value: menuStr.wolink,
				url: "Wolink.htm"
			},
			{
				value: menuStr.alinkTest,
				url: "AlinkClient.htm"
			}
		]
	}
};

var advanceMenuClicked = false;

var index = 0;

for(var menuObj in menu)
{
	menuObject = menu[menuObj];
	menuObject["index"] = index;
	index++;
}

function menuClick(menuid, url, className)
{
	var subLi = $("#menuList li");
	var targetUrl = "";
	var subLiClassName, subLiObj;

	if (advanceMenuClicked == true)
	{
		return;
	}

	advanceMenuClicked = true;

	for(var i = 0, j = subLi.length; i < j; i++)
	{
		subLiObj = subLi[i];

		if (subLiObj.nodeType != 1)
		{
			continue;
		}

		subLiClassName = subLiObj.className;
		if((subLiClassName == "menuLi")||(subLiClassName == "menuLiClick"))
		{
			if (subLiObj.id == menuid)
			{
				subLiObj.className = "menuLiClick";
				targetUrl = url;
			}
			else
			{
				subLiObj.className = "menuLi";
			}
		}
		else
		{
			if (subLiObj.id.indexOf(menuid) >= 0)
			{
				var num = parseInt(subLiObj.id.substring(menuid.length));
				if (num == 0)
				{
					subLiObj.className = "subMenuLiClick";
				}
				else
				{
					subLiObj.className = "subMenuLi";
				}

				(function(liObj){
					setTimeout(function(){
						liObj.style.height = "32px";
						liObj.style.display = "inline-block";
					},0);
				})(subLiObj);
			}
			else
			{
				subLiObj.style.height = "0";
				subLiObj.style.display = "none";
			}
		}
	}

	if (targetUrl != undefined && menuConfig.menuTargetUrl == "")
	{
		menuLoad(targetUrl);
	}
}
function subMenuClick(menuid, subMenuId, url)
{
	var subLi = $("#menuList li");
	var index = subMenuId.replace(/[^0-9]+/, "");
	var subMenuName = subMenuId.replace(index, "");

	if (advanceMenuClicked == true)
	{
		return;
	}

	advanceMenuClicked = true;

	for (var i = 0, j =subLi.length; i < j; i++)
	{
		if ((subLi[i].className == "subMenuLi")||(subLi[i].className == "subMenuLiClick"))
		{
			if (subLi[i].id == subMenuId)
			{
				subLi[i].className = "subMenuLiClick";
				menuLoad(url);
			}
			else if (subLi[i].id.indexOf(menuid) >= 0)
			{
				subLi[i].className = "subMenuLi";
			}
		}
	}
}
function menuLoad(url)
{
	var menuCon = id("menuLoader");

	if (isIESix == true)
	{
		menuCon.style.height = "";
	}

	menuCon.innerHTML = "";
	advanceMenuClicked = false;
	loadPage(url, "menuLoader", function(){
		advanceAutoFit();
	});
	window.scrollTo(0, 0);
}
function removeSubMenu(targetMenuArray, targetUrl)
{
	var targetIndex = targetMenuArray.findIndex(function(ele){
		return ele.url == targetUrl;
	});
	targetIndex != -1 && targetMenuArray.splice(targetIndex, 1);
}
function menuInit()
{
	var role = $.authRltObj["group"];
	var menuDiv = id("menuList");
	var menuObject, ul, li, i, liTag, lbl, iDom, subLiTag;
	var subMenu;

	if (!slp.ipv6Support)
	{
		removeSubMenu(menu.netWorkData_menu.subMenu, "WanIpv6Loader.htm");
	}

	if (!slp.hnatSupport)
	{
		removeSubMenu(menu.netWorkData_menu.subMenu, "HNat.htm");
	}

	if (!slp.wifiSwitchSupport)
	{
		removeSubMenu(menu.wifiSet_menu.subMenu, "WifiMasterSwitch.htm");
	}

	if (!slp.multiSsidSupport)
	{
		removeSubMenu(menu.wifiSet_menu.subMenu, "MultiSsid.htm");
	}

	if (!slp.modeSwitchSupport)
	{
		removeSubMenu(menu.sysTool_menu.subMenu, "BridgeSwitch.htm");
	}

	if (slp.usernameSupport)
	{
		for (var i = 0; i < menu.sysTool_menu.subMenu.length; i++)
		{
			var item = menu.sysTool_menu.subMenu[i];
			if (item.url == "SysChangeLgPwd.htm")
			{
				item.value = menuStr.changeLgUsrPwd;
			}
		}
	}

	if (!slp.elinkSupport)
	{
		removeSubMenu(menu.sysTool_menu.subMenu, "Elink.htm");
	}

	if (!slp.wolinkSupport)
	{
		removeSubMenu(menu.sysTool_menu.subMenu, "Wolink.htm");
	}

	if (!slp.alinkTestSupport)
	{
		removeSubMenu(menu.sysTool_menu.subMenu, "AlinkClient.htm");
	}

	if (!slp.customLedSupport &&
		(slp.moduleSpec["wifison_mesh"] == undefined || slp.moduleSpec["wifison_mesh"] == "0") &&
		(slp.moduleSpec["sys_led_control"] == undefined || slp.moduleSpec["sys_led_control"] == "0") &&
		(slp.moduleSpec["wifison"] == undefined || slp.moduleSpec["wifison"] == "0"))
	{
		removeSubMenu(menu.sysTool_menu.subMenu, "LightNButton.htm");
	}

	for(var menuObj in menu)
	{
		menuObject = menu[menuObj];
		menuObject["url"] = menuObject.subMenu[0]["url"]; // 将一级菜单的URL置为第一个二级菜单

		if (menuObject.roleList && $.inArray(role, menuObject.roleList) < 0)
		{
			continue;
		}

		ul = document.createElement("ul");
		ul.className = "menuUl";
		menuDiv.appendChild(ul);

		li = document.createElement("li");
		li.id = menuObj.toString();
		li.className = "menuLi";
		li.onclick = new Function("menuClick('"+menuObj.toString()+"', '"+menuObject.url+"', '"+menuObject.className+"')");

		if (menuConfig.menuTargetUrl == menuObject.url)
		{
			menuConfig.loadMainIndex = menuObject.index;
		}

		i = document.createElement("i");
		i.className = "menuImg iconfont " + menuObject.className;
		li.appendChild(i);

		lbl = document.createElement("label");
		lbl.innerHTML = menuObject.value;
		lbl.className = "menuLbl";
		li.appendChild(lbl);

		/* 若没有子选项，则箭头不能向下 */
		i = document.createElement("i");
		li.appendChild(i);
		if (menuObject.hasSub)
		{
			i.className = "arrow active iconfont icon-foldmenu";
		}
		else
		{
			i.className = "arrow iconfont icon-foldmenu";
		}

		liTag = document.createElement("i");
		liTag.className = "menuLiTag";
		li.appendChild(liTag);

		ul.appendChild(li);

		if (menuObject.hasSub)
		{
			subMenu = menuObject.subMenu;
			for(var i = 0; i < subMenu.length;i++)
			{
				if (subMenu[i].roleList && $.inArray(role, subMenu[i].roleList) < 0)
				{
					continue;
				}

				li = document.createElement("li");
				li.id = (menuObj.toString() + i);
				li.className = "subMenuLi";

				li.style.display = "none";
				li.onclick = new Function("subMenuClick('"+menuObj.toString()+"', '"+li.id+"', '"+subMenu[i].url+"')");

				if (menuConfig.menuTargetUrl == subMenu[i].url)
				{
					menuConfig.loadSubIndex = parseInt(i);
					menuConfig.loadMainIndex = menuObject.index;
				}

				iDom = document.createElement("i");
				iDom.className = "subImg";
				li.appendChild(iDom);

				lbl = document.createElement("label");
				lbl.innerHTML = subMenu[i].value;
				lbl.className = "subMenuLbl";
				li.appendChild(lbl);

				subLiTag = document.createElement("i");
				subLiTag.className = "subMenuLiTag";
				if (subMenu[i].tagClass)
				{
					subLiTag.className += " " + subMenu[i].tagClass;
				}
				li.appendChild(subLiTag);

				ul.appendChild(li);
			}
		}
	}

	if (menuConfig.loadSubIndex == 0)
	{
		menuConfig.menuTargetUrl = "";
	}

	/* 默认加载第一项 */
	menuDiv.childNodes[menuConfig.loadMainIndex].childNodes[0].onclick();
	if (0 != menuConfig.loadSubIndex)
	{
		advanceMenuClicked = false;
		menuDiv.childNodes[menuConfig.loadMainIndex].childNodes[menuConfig.loadSubIndex+1].onclick();
	}
	menuConfig.menuTargetUrl = "";
	menuConfig.loadMainIndex = 0;
	menuConfig.loadSubIndex = 0;
}
