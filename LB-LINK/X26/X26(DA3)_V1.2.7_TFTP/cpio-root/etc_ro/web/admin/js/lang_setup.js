var langs= {
    zhcn:{
        ApplySuc:"保存成功",
        Apply:"保存生效",
        AdminPassword:"管理密码",
        Tips:"小贴士:管理密码是您管理路由器的登录密码,请务必记住.",
        userAgreement:"用户服务协议",
        userAgreement_info:"请勾选用户服务协议",
        hlepTip:"小贴士",
        Mode1:"路由模式: 有线连接ADSL或电缆调制解调器通过广域网端口和共享互联网本地有线和无线网络;",
        Mode2:"中继模式: 通过中继无线信号扩展你现有的无线覆盖;",
        Mode3:"万能中继模式: 无线网络接口和所有的以太网接口被桥接在一起并视为LAN口，无线网络接口同时还兼作WAN口;",
        Mode4:"Client模式: 作为一个“无线网卡”连接你的有线设备（例如Xbox或PS3）到一个无线网络;",
        Mode5:"AP(接入点)模式: 所有以太网、无线网接口都被桥接到单一的桥接口，在此模式下，该设备相当于一台无线HUB",
        WISP_Setup:"万能中继设置",
        Relay_Setup:"中继设置",
        Client_Setup:"Client设置",
        WanSet:"外网设置",
        WIFISet:"WiFi设置",
        Warning:"系统提醒",
        Messages:"系统检测到路由器WAN口未插网线，请确认！",
        WlanList:"无线列表",
        Admin:"管理密码设置",
        ssid_label:"请输入WIFI名称",
        wlanpass_label:"请输入WIFI密码",
        dssid_label:"请输入5GWIFI名称",
        dwlanpass_label:"请输入5GWIFI密码",
        Mpass_label:"请输入管理密码密码",
    },
    en:{
        ApplySuc:"Saved Successfully",
  		Apply:"Apply",
  		AdminPassword:"Admin Password",
  		Tips:"Tips: The Admin Password is your router login password, please remember it..",
  		userAgreement:"User Services Agreement",
  		userAgreement_info:"Please tick the user service agreement",
  		hlepTip:"Tips",
  		Mode1:"Router: A Wired connection to an ADSL / Cable Modem via a WAN port, and access the Internet through local wireless and wired networks.",
  		Mode2:"Repeater: Extend your existing wireless network.",
  		Mode3:"WISP: Wirelessly connect to a WISP station / hotspot to access the Internet through local wireless and wired networks.",
  		Mode4:"Client: Act as a Wireless Adapter to connect your wired devices (e.g.XBox/PS3) to a wireless network.",
  		Mode5:"Bridge with AP: Connect two local networks via a wireless connection.",
  		WISP_Setup:"WISP Setup",
  		Relay_Setup:"Repeater Setup",
  		Client_Setup:"Client Setup",
        WanSet:"Wan",
        WIFISet:"WiFi",
  		Warning:"Warning",
  		Messages:"The Router detected that a network cable is not connected, please make sure the network!",
  		WlanList:"WiFi List",
  		Admin:"Admin Password",
  		ssid_label:"Enter the WIFI SSID",
  		wlanpass_label:"Enter the WiFi Password",
  		dssid_label:"Enter the 5G WIFI SSID",
  		dwlanpass_label:"Enter the 5G WiFi Password",
  		Mpass_label:"Enter the Admin Password",

	}
};
var getPages=function() {
    if (getLang() == 'zhcn') {
        var curlang = langs.zhcn;
    } else {
        var curlang = langs.en;
    }
    $('#routerpwd').attr('placeholder',curlang.AdminPassword);
    $('#floatWifiName').attr('placeholder',curlang.ssid_label);
    $('#floatWifiPass').attr('placeholder',curlang.wlanpass_label);
    $('#doubleWifiName').attr('placeholder',curlang.dssid_label);
    $('#doubleWifiPass').attr('placeholder',curlang.dwlanpass_label);
    $("#mangepass").html(curlang.AdminPassword);
    $("#routertip").html(curlang.Tips);
    $("#eula_user").html(curlang.userAgreement);
    $("#hlepTip").html(curlang.hlepTip);
    $("#helpcontant li").eq(0).html(curlang.Mode1);
    $("#helpcontant li").eq(1).html(curlang.Mode3);
    //$("#helpcontant li").eq(2).html(curlang.Mode2);
    //$("#helpcontant li").eq(3).html(curlang.Mode4);
    //$("#helpcontant li").eq(4).html(curlang.Mode5);
    $("#mySmallModalLabel").html(curlang.WISP_Setup);
    $("#ChangeInfoLabel").html(curlang.Warning);
    $("#ChangeBox").html(curlang.Messages);
    return;
}
