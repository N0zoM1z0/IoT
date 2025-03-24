var langs= {
  zhcn:{
		mgpass:"登陆密码",
		routerSet:"系统设置",
		Reboot:"重启",
		version:"固件版本号: ",
        service:"客服电话: 400-998-5533",
	    reboottip:"路由复位",
		curStatus:"当前连接状态",
		linkType:"连接类型",
		curIP:"本机IP地址",
		internetIP:"外网IP地址",
		Routermac:"MAC地址",
		download:"手机APP下载",
		cloud:"云平台入口",
		curClientNum:"终端个数",
		terminalAlready:"已有 ",
		terminalLink:" 台设备连接路由器",
		closeFuntona:"此功能不可用",
		remian:"总内存",
		worktime:"在线时间",
		curmian:"剩余内存",
		curCPU:"CPU占用率",
		waninfo:"外网信息",
		wanmac:"MAC地址",
		wanlink:"连接方式",
		wandns:"DNS",
        RelayModea:"中继",
        WISPmodea:"万能中继",
        ClientModea:"Client",
        BridgeModea:"AP",
		mgpassSet:"登陆密码设置",
		upgrade_local:"本地升级",
		upgrade_online:"在线升级",
        file_selection:"文件选择",
        file_val:"未选择文件",
		firmware_up:"固件更新: 请指定一个文件。",
		reboot:"确认将重启路由器",
		passError:"密码不正确",
	},
    en: {
        mgpass: "Admin Password",
        routerSet: "System",
        Reboot: "Reboot",
        version: "Version: ",
        service: "Customer service Email: info@b-link.net.cn",
        reboottip: "Router Reset",
        curStatus: "Current Status",
        linkType: "Connection",
        curIP: "Local IP",
        internetIP: "WAN IP",
        Routermac: "MAC Address",
        download: "Download the APP",
        cloud: "Cloud Platform",
        curClientNum: "Number of terminal",
		terminalAlready:"There are already ",
		terminalLink:" devices connected to the router.",
        closeFuntona: "Function Not Available",
        remian: "Memory",
        worktime: "Up-Time",
        curmian: "Free Memory",
        curCPU: "CPU Usage",
        waninfo: "WAN Information",
        wanmac: "MAC",
        wanlink: "Connection",
        wandns: "DNS",
        RelayModea: "Repeater",
        WISPmodea: "WISP",
        ClientModea: "Client",
        BridgeModea: "AP",
        mgpassSet: "Admin Password Settings",
        upgrade_local: "Local Upgrade",
        upgrade_online: "Online Upgrade",
        file_selection: "File Selection",
        file_val: "No choice file",
        firmware_up: "Firmware Update: Please specify a file.",
        reboot: "Confirming will reboot the Router",
        passError: "Wrong Password"
    }
}
var getPages=function() {
    if (getLang() == 'zhcn') {
        var curlang = langs.zhcn;
    } else {
        var curlang = langs.en;
    }
    $("#version").siblings("em").html(curlang.version);
    $("#version_num").siblings("em").html(curlang.version);
    $("#phone").html(curlang.service);
    $("#RestoreTitle").html(curlang.reboottip);
    $("#netStatus").siblings("span").html(curlang.curStatus);
    $("#linkType").siblings("span").html(curlang.linkType);
    $("#lanIP").siblings("span").html(curlang.curIP);
    $("#interIP").siblings("span").html(curlang.internetIP);
    $("#scanfimg").html(curlang.download);
    $("#Mac").siblings("span").html(curlang.wanmac);
    $("#waninfotitle").html(curlang.waninfo);
    $("#Official").html(curlang.Official);
    $("#terminal").html(curlang.curClientNum);
    $("#already").html(curlang.terminalAlready);
    $("#terminalLink").html(curlang.terminalLink);
    $("#remainMemory").siblings("span").html(curlang.remian);
    $("#playTime").siblings("span").html(curlang.worktime);
    $("#totalMemory").siblings("span").html(curlang.curmian);
    $("#cpu").siblings("span").html(curlang.curCPU);
    $("#wan_mac1_td").html(curlang.wanmac);
    $("#connettype1_td").html(curlang.wanlink);
    $("#wan_dns1_td").html(curlang.wandns);
    $("#update_local").html(curlang.upgrade_local);
    $("#update_online").html(curlang.upgrade_online);
    $("#file_txt").html(curlang.file_selection);
    $("#file_val").html(curlang.file_val);
    return;
}
