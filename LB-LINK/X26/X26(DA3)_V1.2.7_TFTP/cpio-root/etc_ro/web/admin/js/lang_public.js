var getLang=function(){
    var currentLang=navigator.language;   //判断除IE外其他浏览器使用语言
    if(!currentLang){//判断IE浏览器使用语言
        currentLang = navigator.browserLanguage;
    }
    function testIt(str){
        var pattern = /zh/;
        return pattern.test(str);
    }
    if(testIt(currentLang)){
        nowlang='zhcn';
        return nowlang;
    }else{
        nowlang='en';
        return nowlang;
    }
};
var lang={
    "zhcn":{
		    Official:"官方网站",
        B_Link:"必联路由器",
        myRouter:"主页面",
        morefuntion:"高级设置",
        changemode:"模式切换",
        changeMode:"易操作",
        RouteMode:"路由模式",
        RelayMode:"中继模式",
        WISPmode:"WISP中继模式",
        ClientMode:"Client模式",
        BridgeMode:"AP(接入点)模式",
        BridgeModeTips:"(WAN口/LAN口接入)",
        wispModeTips:"(WISP,WIFI接入)",
        wanModeTips:"(WAN口接入)",
        wifiModeTips:"(WIFI接入)",
        setupMode:"更多模式",
        wanPMode:"更多设置",
        help:"帮助",
        LastStep:"上一步",
        NextStep :"下一步",
        Connect:"连接",
        Switch:"切换",
        WIFISet:"WiFi设置",
        Apply:"保存生效",
        To_scan:"重新扫描",
        WanScan:"上网方式侦测中",
        WlanScan:"无线网络扫描中",
        Message:"系统检测到路由器WAN口未插网线，是否切换到万能中继模式？",
        No:"信道",
        SQ:"强度",
        term:"终端列表",
        Client_pc:"有线设备",
        Client_2g:"2.4G设备",
        Client_5g:"5G设备",
        clientInfo:"设备信息",
        Tperiod:"时间段",
        time_period:"时间段1",
        Time_period:"时间段2",
        device_list:"设备列表",
        name:"名称: ",
        total_traffic:"流量总计:",
        limit_speed:"限速",
        limit_cancel:"取消限速",
        limit_not:"未限速",
        qostooltip:"0为不限速",
        forbidden:"禁止上网:",
        lostblack:"拉黑",
        loststatic:"绑定",
        Unbind:"解绑",
        staticbind:"静态绑定:",
        add_time:"添加禁止上网时间",
        overlap_time:"时间不能重叠",
        limit_time:"提示: 输入00时00分~00时00分则不限制时间",
        limit_num:"最多添加20个终端限制时间",
        unbounded:"未绑定",
        binded:"已绑定",
        termT_add:"添加",
        protection:"儿童保护:",
        protectionlist:"儿童保护列表",
        startend_time:"结束时间不能小于开始时间",
        time_same:"时间不能一样",
        add_blackLimit:"已超过最大限制21个，请到黑名单列表删除部分黑名单",
        add_bindLimit:"已超过最大限制29个，请到绑定列表删除部分绑定设备",
        limit_cm:"确认",
        getupgrade:"固件升级",
        curvision:"当前版本",
        lastvision:"最新版本",
        upgrade_button:"升级",
        upgrade_down:"正在下载,请稍等...",
        upgrade_ug:"下载成功,正在烧写中",
        upgrade_reboot:"升级成功,正在重启中,请稍等...",
        sysinfo:"系统错误",
        sysError:"网络异常，请检查网络",
        sysModel:"型号不对，请联系客服",
        lantooltip:"局域网设置",
        tai:"台",
        netdiagonsis:"网络诊断",
        netCheck:"检测中",
        rootedcheck:"重新诊断",
        Checkwanport:"检测外网连接状态",
        Checkwanmode:"检测上网方式是否正确",
        Checkwanip:"检测外网是否获取到IP地址",
        Checkwandns:"检测DNS服务器状态",
        Checkwanpage:"检测网页访问状态",
        nd_wan:"WAN口网线未连接，请您检查网线连接是否正确",
        nd_pppoe:"PPPOE未连接成功，请您检查外网设置，或者联系宽带运营商处理",
        nd_static:"静态IP未连接成功，请您检查外网设置，或者联系宽带运营商处理",
        nd_dhcp:"动态连接未连接成功，请您检查外网设置，或者联系宽带运营商处理",
        nd_wanIP:"外网IP未获取成功，请您尝试重启，或者联系宽带运营商处理",
        nd_dns:"DNS服务器状态异常，请您尝试重启，或者联系宽带运营商处理",
        nd_wanhost:"网页访问状态异常，请您尝试重启，或者联系宽带运营商处理",
        WANtip:"外网设置",
        wanpppoe:"宽带拨号",
        wandhcp:"动态获取",
        wanstatic:"静态设置",
        wanusername:"账号",
        username_label:"请输入账号",
        dns_label:"请输入DNS",
        dns_result:"设备不支持此功能",
        wanpass:"密码",
        wanpass_label:"请输入密码",
        server_name:"服务器名称",
        server_label:"请输入服务器名称",
        server_optional:"可选的",
        wifiset:"WiFi设置",
        wifitip:"2.4G WiFi设置",
        wifiTip:"5G WiFi设置",
        wireless:"无线设置",
        wireless_24g:"2.4G无线设置",
        wireless_5g:"5G无线设置",
        ssid:"WiFi名称",
        ssid_label:"请输入WiFi名称",
        encryptionmode:"加密模式",
        wifi_open:"无加密(允许所有人连)",
        wifi_wpawpa2:"混合加密(WPA/WPA2)",
        pass:"WiFi密码",
        pass_label:"请输入WiFi密码",
        Hidden_SSID:"隐藏WiFi名称不被发现",
        visitorWlan:"2.4G 访客网络",
        visitorwlan:"5G 访客网络",
        inspeed:"网络测速",
        upspeed:"上传速度",
        downspeed:"下载速度",
        speedAgain:"重新测速",
        ChannelGet:"2.4G信道设置",
        Channel5Get:"5G信道设置",
        channelError:"信道信息请求失败",
        ChannelChance:"信道选择",
        CountryCode:"国家代码",
        C_channel:"当前工作信道: ",
        M_channel:"当前工作频宽: ",
        bandwidth:"频宽模式",
        band_mode1:"20M",
        band_mode2:"40M",
        band_mode3:"80M",
        JP_channel:"选择14信道时,只支持11b模式,最大速率11M",
        Current_tips:"提示: 20M是抗干扰模式,40M是均衡模式,80M是高性能模式",
        Current2_tips:"提示: 20M是抗干扰模式,40M是均衡模式",
        O_auto:"自动",
        united_states:"US(美国)",
        japan:"JP(日本)",
        france:"FR(法国)",
        TaiWan:"TW(台湾)",
        ireland:"IE(爱尔兰)",
        chain:"CN(中国)",
        O_none:"无",
        blacklist:"黑名单列表",
        singnalSet:"2.4G信号强度",
        singnalSet5G:"5G信号强度",
        greenmode:"孕妇模式",
        Balancemode:"平衡模式",
        HPmode:"穿墙模式",
		    DNStitle: "高级DNS",
        restore:"恢复出厂设置",
        reboot:"重启路由器",
        rebootrouter:"重启路由器需要等待一段时间,<br>期间所有连接设备将自动断开",
        resetRouter:"恢复出厂设置将清除路由器已<br>配置的信息,并自动重启",
        waitingtime:"路由器正在重启,预计等待",
        updatetime:"路由器升级过程中请勿断电,预计等待",
        info1:"设置成功,重启生效",
        info2:"设置成功",
        info3:"设置失败",
        PeaseWait:"请稍后",
        checknum:"请输入合法数字",
        clientinfo:"设备已绑定",
        mgpassSet:"修改管理密码",
        oldmgpass:"原密码",
        oldmgpass_label:"请输入原密码",
        newmgpass:"新密码",
        newmgpass_label:"请输入新密码",
        passError:"原密码不正确",
        staticList:"绑定列表",
        worldTime_name:"世界时间",
        cur_timeTitle:"当前系统时间",
        time_server:"时间服务器地址",
        time_zoneTitle:"世界时区",
        MidIsland:"(GMT-11:00) 中途岛、萨摩亚",
        Hawaii:"(GMT-10:00) 夏威夷",
        Alaska:"(GMT-09:00) 阿拉斯加",
        Pacific:"(GMT-08:00) 太平洋标准时间",
        Mountain:"(GMT-07:00) 落矶山区时间",
        Arizona:"(GMT-07:00) 亚利桑那",
        Central:"(GMT-06:00) 中央时间",
        MidUS:"(GMT-06:00) 中美洲",
        IndianaEast:"(GMT-05:00) 印第安纳州（东部）、哥伦比亚",
        Eastern:"(GMT-05:00) 东部时区",
        Atlantic:"(GMT-04:00) 大西洋标准时间、西巴西",
        Bolivia:"(GMT-04:00) 玻利维亚、委内瑞拉",
        Guyana:"(GMT-03:00) 盖亚纳",
        BrazilEast:"(GMT-03:00) 东巴西、格陵兰",
        MidAtlantic:"(GMT-02:00) 中大西洋",
        AzoresIslands:"(GMT-01:00) 亚速尔群岛",
        Gambia:"(GMT) 甘比亚，赖比瑞亚、摩洛哥",
        England:"(GMT) 英格兰",
        CzechRepublic:"(GMT+01:00) 捷克、N",
        Germany:"(GMT+01:00) 德国",
        Tunisia:"(GMT+01:00) 突尼西亚",
        Greece:"(GMT+02:00) 希腊、乌克兰、土耳其",
        SouthAfrica:"(GMT+02:00) 南非",
        Iraq:"(GMT+03:00) 伊拉克、约旦、科威特",
        MoscowWinter:"(GMT+03:00) 莫斯科冬令时间",
        Armenia:"(GMT+04:00) 亚美尼亚",
        Pakistan:"(GMT+05:00) 巴基斯坦、俄罗斯",
        Bangladesh:"(GMT+06:00) 孟加拉、俄罗斯",
        Thailand:"(GMT+07:00) 泰国、俄罗斯",
        ChinaCoast:"(GMT+08:00) 中国沿岸、香港",
        Taipei:"(GMT+08:00) 台北",
        Singapore:"(GMT+08:00) 新加坡",
        AustraliaWA:"(GMT+08:00) 西澳洲",
        Japan:"(GMT+09:00) 日本、韩国",
        Korean:"(GMT+09:00) 朝鲜时区",
        Guam:"(GMT+10:00) 关岛、俄罗斯",
        AustraliaQLD:"(GMT+10:00) 澳洲（昆士兰、塔斯马尼亚、维多利亚）",
        SolomonIslands:"(GMT+11:00) 索罗门群岛",
        Fiji:"(GMT+12:00) 斐济",
        NewZealand:"(GMT+12:00) 新西兰",
        Nuku:"(GMT+13:00) 努库阿洛法",
        url_blacklist:"网址黑名单",
        host_blacklist:"所有主机网址黑名单设置",
        shost_blacklist:"主机网址黑名单设置",
        hostBlacklist:"设置黑名单",
        pchostBlacklist:"主机网址黑名单列表",
        termBlacklist:"终端网址黑名单设置",
        host_blacklist1:"所有主机网址黑名单列表",
        termBlacklist4:"终端网址黑名单列表",
        host_sbu:"提交",
        host_edit:"编辑",
        host_setup:"设置",
        refresh:"刷新",
        see_details:"查看详情>",
        host_website:"网址: ",
        url_str:"不能超过500个字符",
        term_str:"不能超过64个字符",
        term_num:"最多添加24个终端",
        space_str:"网址不能有空格和换行符",
        host_urlTips:"说明:",
        host_urlTips1:"1. 所有主机网址黑名单优先级高于终端网址黑名单",
        host_urlTips2:"2. 网址格式为 www.baidu.com (精确匹配：主机将不能访问该网址)或 baidu (关键字匹配：主机将不能访问带有该关键字的网址)",
        host_urlTips3:"3. 输入格式可以为精确匹配、关键字匹配或混合模式，如baidu;google;sina; 必须以 ; 号分割网址",
        pptpSet:"PPTP客户端",
        L2TPSet:"L2TP客户端",
        Domain:"服务器域名",
        deviceName:"设备名称",
        mangement:"管理",
        open:"开启",
        close:"关闭",
        mppeOpen:"开启",
        mppeClose:"关闭",
        cancel:"取消",
        apply:"应用",
        workMode:"开关",
        Scanwlan:"扫描侦测",
        admin:"登录密码",
        isip:"IP地址",
        isip_label:"请输入IP地址",
        hostIP:"与主机IP冲突了",
        ip_label:"请输入IP",
        IP_Scope:"起始IP需小于终止IP",
        IP_equal:"所有IP的第三个网段要相等",
        ip_equal_verify:"起始IP和终止IP不能和lan口IP一致",
        chack_startip:"起始IP",
        startip_label:"请输入起始IP",
        check_endip:"终止IP",
        endip_label:"请输入终止IP",
        mask:"子网掩码",
        mask_label:"请输入子网掩码",
        gateway:"网关",
        gateway_label:"请输入网关",
        dns1:"DNS1",
        dns1_label:"请输入DNS1",
        dns2:"DNS2",
        dns2_label:"请输入DNS2",
        ip_addr:"网络协议",
        ulink:"未连接",
        linked:"已连接",
        unclik:"解除",
        Remove:"删除",
        mac:"Mac地址",
        devup:"上传",
        devdown:"下载",
        led_name:"面板灯开关",
        Timing:"面板灯关闭时间",
        startTime:"开始时间",
        endTime:"结束时间",
        Hour:"时",
        Min:"分",
        wifiTiming_off:"WiFi定时关闭",
        led_mode:"开关模式",
        led_open:"定时关闭",
        led_close:"全天关闭",
        WT_tip:"提示: 路由器没有连接外网的情况下,WiFi定时关闭功能可能会存在异常,建议关闭WiFi定时关闭功能",
        led_tip:"提示: 路由器没有连接外网的情况下,面板灯功能可能会存在异常,建议关闭面板灯功能",
        Visitor_tip:"提示: 用户连接访客网络,将无法访问路由界面",
        DMZ_tip:"提示: 请输入局域网设备的IP,开启DMZ可以使局域网中的一台设备映射到广域网,实现双向通信",
        sharedWifi:"共享WiFi",
        sharedOff:"共享WiFi开关",
        sharedSsid:"共享WiFi SSID",
        sharedTips:"关闭共享WiFi时，路由器将自动重启",
        webadmin:"远程Web管理",
        webadminPort:"端口",
        Server_IP:"服务器IP",
        External_port:"外部端口",
        IP:"IP",
        Internal_port:"内部端口",
        AdminPass_NULL:"登录密码输入不能为空",
        AdminPass_Length:"登录密码的长度不对,请输入8~64位数字、字母、符号的组合",
        AdminPass_Error:"登录密码输入错误，请重新输入",
        AdminPass_CH:"登录密码不能输入中文",
        IP_NULL:"IP地址输入不能为空",
        IP_Illicit:"IP地址输入非法，请重新输入",
        IP_Error:"IP地址输入格式不对，请重新输入",
        Subnet_NULL:"子网掩码输入不能为空",
        Subnet_Illicit:"子网掩码输入非法，请重新输入",
        Subnet_Error:"子网掩码输入格式不对，请重新输入",
        GateWay_NULL:"网关输入不能为空",
        GateWay_Illicit:"网关输入非法，请重新输入",
        GateWay_Error:"网关输入格式不对，请重新输入",
        DNS_Null:"DNS输入不能为空",
        DNS_Illicit:"DNS服务器输入非法，请重新输入",
        DNS_Error:"DNS服务器输入格式不对，请重新输入",
        Account_NULL:"账号不能为空",
        DialPass_NULL:"密码不能为空",
        DialPass_CH:"密码不能输入中文",
        SSID_NULL:"WiFi名称不能为空",
        SSID_Length:"WiFi名称的长度不能超过32位",
        WIFIPass_NULL:"WiFi密码不能为空, 请输入8-64位ASCII字符",
        WIFIPass_Smaller:"WiFi密码长度不能小于8，请重新输入",
        WIFIPass_Over:"WiFi密码长度不能大于64，请重新输入",
        WIFIPass_CH:"WiFi密码不能输入中文",
        Enter_NULL:"输入不能为空",
        Port_Scope:"输入值不在范围内,请输入1-65535之间的数值",
        Port_Error:"输入非法，请输入1-65535之间的数值",
        MTU_Scope:"输入值不在范围内,请输入576-1492之间的数值",
        MTU_Error:"输入非法，请输入576-1492之间的数值",
        MTUppoe_Scope:"输入值不在范围内,请输入576-1444之间的数值",
        MTUppoe_Error:"输入非法，请输入576-1444之间的数值",
        MTUl2tp_Scope:"输入值不在范围内,请输入576-1460之间的数值",
        MTUl2tp_Error:"输入非法，请输入576-1460之间的数值",
        Domain_Error:"域名输入错误，请重新输入",
        Alias_NULL:"别名不能为空",
        Alias_Over:"别名长度不能超过18位",
        Alias_Error:"别名不能输入特殊字符",
        QOS_Error:"输入非法,请输入由0-9组合的数字",
        hour_Error:"输入非法,请输入0-23的数字",
        min_Error:"输入非法,请输入0-59的数字",
        QOS_Over:"输入非法，请输入1-99999之间的字符",
        MAC_Illicit:"MAC长度不对",
        MAC_Error:"MAC格式错误",
        MAC_length:"无效的MAC",
        closeFunton:"设备不在线",
        // 新增
        recommendWanModeTip:"经检测，推荐您的连接方式为",
        hasNetTip:"您已经成功联网",
        noNetTip:"您当前暂未联网",
        noWanTip:"您当前WAN口未插网线",
        selectNetMode:"请选择上网方式",
        netMode:"上网模式",
        setFinish:"设置完成",
        routerSetTip1:"恭喜您，可以上网了！",
        routerSetTip2:"请连接无线信号",
        pleaseWait:"请等待",
        reconnectionWifi:"之后重连无线",
        or:"或者",
		    second:'秒',
        pppoeName_placeholder:"请输入运营商提供给您的宽带账号",
        pppoePwd_placeholder:"请输入运营商提供给您的宽带密码",
		    wanMode_notNull:'请选择WAN模式',
		    quickSetup:"设置向导",
        wifiName:"Wi-Fi名称",
        wifiPassword:"Wi-Fi密码"
    },
    en:{
	    Official: "Official Site",
  		B_Link:"LB-LINK Router",
      myRouter:"Homepage",
      morefuntion:"Advanced Settings",
      changemode:"Change Mode",
      changeMode:"Easy Setup",
      RouteMode:"Router Mode",
      RelayMode:"Repeater Mode",
      WISPmode:"WISP Mode",
      ClientMode:"Client Mode",
      BridgeMode:"AP Mode",
      BridgeModeTips:"(WAN, LAN access)",
      wispModeTips:"(WISP,WIFI access)",
      wanModeTips:"(WAN access)",
      wifiModeTips:"(WIFI access)",
      setupMode:"More Mode",
      wanPMode:"More settings",
      help:"Help",
      LastStep:"Back",
      NextStep :"Next",
      Connect:"Connect",
      Switch:"Switch",
      WIFISet:"WiFi",
      Apply:"Apply",
      To_scan:"Rescan",
      WanScan:"WAN Automatic Detection",
      WlanScan:"Wlan Scanning",
      Message:"The Router detected that a network cable is not connected, switch to WISP mode?",
      No:"CH",
      SQ:"SQ",
      term:"Terminal List",
      Client_pc:"Wired Device",
      Client_2g:"2.4G Device",
      Client_5g:"5G Device",
      clientInfo:"Device Info",
      Tperiod:"Period",
      time_period:"Period 1",
      Time_period:"Period 2",
      device_list:"Device List",
      name:"Name: ",
      total_traffic:"Traffic in total: ",
      limit_speed:"Speed Limit",
      limit_cancel:"Cancel",
      limit_not:"No speed limit",
      qostooltip:"'0' For Unrestricted Speed",
      forbidden:"Forbidden:",
      lostblack:"Blacklist",
      loststatic:"Binding",
      Unbind:"Unbind",
      staticbind:"Static Binding:",
      add_time:"Add the forbidden time",
      overlap_time:"Time can not overlap",
      limit_time:"Tips: Enter 00:00 to 00:00 does not limit the time",
      limit_num:"20 terminal time limitd at most",
      unbounded:"Unbound",
      binded:"Bounded",
      termT_add:"Add",
      protection:"Child protection:",
      protectionlist:"Child Protection List",
      startend_time:"The end time can not be less than the start time",
      time_same:"Time can not be the same",
      add_blackLimit:"Has exceeded the maximum limit of 21, please go to the black list to delete some of the blacklist",
      add_bindLimit:"Has exceeded the maximum limit of 29, please go to the binding list to delete part of the binding device",
      limit_cm:"Confirm",
      getupgrade:"Upgrade",
      curvision:"Current Version",
  		lastvision:"Latest Version",
  		upgrade_button:"Upgrade",
      upgrade_down:"Downloading...",
      upgrade_ug:"Upgrading...",
      upgrade_reboot:"Rebooting...",
      sysinfo:"System Error",
      sysError:"The network is abnormal, please check the network",
      sysModel:"Model is wrong, please contact customer service",
      lantooltip:"LAN Settings",
      tai:"",
      netdiagonsis:"Diagnosis",
      netCheck:"checking",
      rootedcheck:"Rediagnosis",
      Checkwanport:"Detect of internet connection status",
      Checkwanmode:"Detect of internet access",
      Checkwanip:"Detect whether internet obtain IP address automatically",
      Checkwandns:"Detect DNS server status",
      Checkwanpage:"Detect web visit status",
      nd_wan:"The WAN port network cable is not connected. Please check if the network cable connection is correct.",
      nd_pppoe:"PPPOE is not connected successfully. Please check the external network settings or contact the broadband operator.",
      nd_static:"The static IP is not successfully connected. Please check the external network settings or contact the broadband operator.",
      nd_dhcp:"The dynamic connection is not connected successfully. Please check the external network settings or contact the broadband operator.",
      nd_wanIP:"The external network IP has not been successful. Please try to restart or contact the broadband operator.",
      nd_dns:"The DNS server status is abnormal. Please try to restart or contact the broadband operator.",
      nd_wanhost:"The page access status is abnormal. Please try to restart or contact the broadband operator.",
      WANtip:"WAN Settings",
      wanpppoe:"PPPOE",
  		wandhcp:"DHCP",
  		wanstatic:"Static",
      wanusername:"Username",
  		username_label:"Enter the Username",
      dns_label:"Input the DNS",
      dns_result:"Not Supported",
      wanpass:"Password",
  		wanpass_label:"Enter the Password",
      server_name:"Server Name",
      server_label:"Enter the server name",
      server_optional:"Optional",
      wifiset:"WiFi Settings",
      wifitip:"2.4G WiFi Settings",
      wifiTip:"5G WiFi Settings",
      wireless:"Wireless",
      wireless_24g:"2.4G Wireless Settings",
      wireless_5g:"5G Wireless Settings",
      ssid:"SSID",
      ssid_label:"Enter the SSID",
      encryptionmode:"Encryption",
      wifi_open:"OPEN",
      wifi_wpawpa2:"WPA/WPA2-PSK",
  		pass:"Password",
  		pass_label:"Enter the Password",
      Hidden_SSID:"Hidden SSID",
      visitorWlan:"2.4G Guest Network",
      visitorwlan:"5G Guest Network",
	  visitorName: "Name",
      inspeed:"Speed Test",
      upspeed:"Upload",
      downspeed:"Download",
      speedAgain:"Retest",
      ChannelGet:"2.4G Channel Settings",
      Channel5Get:"5G Channel Settings",
      channelError:"Channel information request failed",
      ChannelChance:"Channel",
      CountryCode:"Country Code",
      C_channel:"Current Channel: ",
      M_channel:"Current Bandwidth: ",
      bandwidth:"Bandwidth",
      band_mode1:"20M",
      band_mode2:"40M",
      band_mode3:"80M",
      JP_channel:"When 14 channels are selected, only 11b mode is supported and the maximum rate is 11M",
      Current_tips:"Tips: 20M is anti-jamming mode, 40M is balanced mode, 80M is high performance mode",
      Current2_tips:"Tips: 20M is anti-jamming mode, 40M is balanced mode",
      O_auto:"auto",
      united_states:"US(United States)",
      japan:"JP(Japan)",
      france:"FR(France)",
      TaiWan:"TW(Taiwan)",
      ireland:"IE(Ireland)",
      chain:"CN(China)",
      O_none:"NONE",
      blacklist:"Black List",
      singnalSet:"2.4G Signal Strength",
      singnalSet5G:"5G Signal Strength",
      greenmode:"Low",
      Balancemode:"Middle",
      HPmode:"High",
	  DNStitle: "DNS Setup",
      restore:"Restore",
      reboot:"Reboot",
      rebootrouter:"The router will be reboot.",
      resetRouter:"The router will be restored.",
      waitingtime:" The Router is Rebooting, please wait ",
      updatetime:"Please wait, upgrading ",
      info1:"Setup was Successful, reboot to take effect.",
      info2:"Setup Successful",
      info3:"Setup Failed",
      PeaseWait:"Please Wait",
      checknum:"Please Enter a Valid Number",
      clientinfo:"The Device was bound",
      mgpassSet:"Admin Password",
      oldmgpass:"Old Password",
      oldmgpass_label:"Enter the Old Password",
      newmgpass:"New Password",
      newmgpass_label:"Enter the New Password",
      passError:"Wrong Old Password",
      staticList:"Binding List",
      worldTime_name:"World Time",
      cur_timeTitle:"Current system time",
      time_server:"Time server address",
      time_zoneTitle:"World time zone",
      MidIsland:"(GMT-11:00) Midway Island, Samoa",
      Hawaii:"(GMT-10:00) Hawaii",
      Alaska:"(GMT-09:00) Alaska",
      Pacific:"(GMT-08:00) Pacific Standard Time",
      Mountain:"(GMT-07:00) Rocky Mountain Time",
      Arizona:"(GMT-07:00) Arizona",
      Central:"(GMT-06:00) Central Standard Time",
      MidUS:"(GMT-06:00) Central America",
      IndianaEast:"(GMT-05:00) Indiana (Eastern), Colombia",
      Eastern:"(GMT-05:00) Eastern Standard Time",
      Atlantic:"(GMT-04:00) Atlantic Standard Time, West Brazil",
      Bolivia:"(GMT-04:00) Bolivia, Venezuela",
      Guyana:"(GMT-03:00) Guyana",
      BrazilEast:"(GMT-03:00) East Brazil, Greenland",
      MidAtlantic:"(GMT-02:00) Mid-Atlantic",
      AzoresIslands:"(GMT-01:00) Azores",
      Gambia:"(GMT) Gambia, Liberia, Morocco",
      England:"(GMT) England",
      CzechRepublic:"(GMT+01:00) Czech Republic, N.",
      Germany:"(GMT+01:00) Germany",
      Tunisia:"(GMT+01:00) Tunisia",
      Greece:"(GMT+02:00) Greece, Ukraine, Turkey",
      SouthAfrica:"(GMT+02:00) South Africa",
      Iraq:"(GMT+03:00) Iraq, Jordan, Kuwait",
      MoscowWinter:"(GMT+03:00) Moscow Winter Time",
      Armenia:"(GMT+04:00) Armenia",
      Pakistan:"(GMT+05:00) Pakistan, Russia",
      Bangladesh:"(GMT+06:00) Bengal, Russia",
      Thailand:"(GMT+07:00) Thailand, Russia",
      ChinaCoast:"(GMT+08:00) China Coast, Hong Kong",
      Taipei:"(GMT+08:00) Taipei",
      Singapore:"(GMT+08:00) Singapore",
      AustraliaWA:"(GMT+08:00) Western Australia",
      Japan:"(GMT+09:00) Japan, South Korea",
      Korean:"(GMT+09:00) North Korea",
      Guam:"(GMT+10:00) Guam, Russia",
      AustraliaQLD:"(GMT+10:00) Australia (Queensland, Tasmania, Victoria)",
      SolomonIslands:"(GMT+11:00) Solomon Islands",
      Fiji:"(GMT+12:00) Republic Of Fiji",
      NewZealand:"(GMT+12:00) New Zealand",
      Nuku:"(GMT+13:00) Nukualofa",
      url_blacklist:"Website Blacklist",
      host_blacklist:"Blacklist of all host websites setup",
      shost_blacklist:"Host website blacklist setup",
      hostBlacklist:"Set up blacklist",
      pchostBlacklist:"Host website blacklist list",
      termBlacklist:"Terminal website blacklist setup",
      host_blacklist1:"Blacklist of all host websites list",
      termBlacklist4:"Terminal website blacklist list",
      host_sbu:"Submit",
      host_edit:"Edit",
      host_setup:"Setup",
      refresh:"Refresh",
      see_details:"See Details>",
      host_website:"Website: ",
      url_str:"Can not be greater than 500 characters",
      term_str:"Can not be greater than 64 characters",
      term_num:"Add up to 24 terminals",
      space_str:"Website can not have spaces and newlines",
      host_urlTips:"Description:",
      host_urlTips1:"1. The blacklist of all the hosts has a higher priority than the blacklist of the terminal",
      host_urlTips2:"2. URL format is www.baidu.com (exact match: the host will not be able to access the URL) or baidu (keyword match: the host will not be able to access the URL with the keyword)",
      host_urlTips3:"3. Input format can be exact match, keyword match or mixed mode, such as baidu; google; sina; must be; split URL",
      pptpSet:"PPTP Client",
      L2TPSet:"L2TP Client",
      Domain:"Server Name",
      deviceName:"Device",
      mangement:"Manage",
      open:"Enable",
      close:"Disable",
      mppeOpen:"on",
      mppeClose:"off",
      cancel:"Cancel",
  		apply:"Apply",
      workMode:"Switch",
      Scanwlan:"Scan Detection",
      admin:"Password",
      isip:"IP Address",
      isip_label:"Enter IP Address",
      hostIP:"Conflicts  with the host's IP",
      ip_label:"Enter the IP Address",
      IP_Scope:"The start IP needs to be less than the stop IP",
      IP_equal:"The third segment of all IP is equal",
      ip_equal_verify:"The start IP and stop IP cannot be the same as the LAN port IP",
      chack_startip:"Start IP",
      startip_label:"Enter the Starting IP",
      check_endip:"End IP",
      endip_label:"Enter the Ending IP",
      mask:"Subnet Mask",
      mask_label:"Enter the Subnet Mask",
      gateway:"Gateway",
      gateway_label:"Enter the Gateway",
      dns1:"DNS1",
      dns1_label:"Enter the DNS1",
      dns2:"DNS2",
      dns2_label:"Enter the DNS2",
      ip_addr:"Protocol",
      ulink:"Disconnected",
      linked:"Connected",
      unclik:"Remove",
      Remove:"Delete",
      mac:"MAC",
      devup:"Upload",
  		devdown:"Download",
      led_name:"Panel lights switch",
      Timing:"Light Off Time",
      startTime:"Start Time",
      endTime:"End Time",
      Hour:"Hour",
      Min:"Minute",
      wifiTiming_off:"WiFi off regularly",
      led_mode:"Switch Mode",
      led_open:"Timing Off",
      led_close:"Closed all day",
      WT_tip:"Tips: The router is not connected to the external network, the WiFi timer off may be abnormal, it is recommended to turn off WiFi timer off",
      led_tip:"",
      Visitor_tip:"",
      DMZ_tip:"",
      sharedWifi:"Shared WiFi",
      sharedOff:"Shared WiFi Switch",
      sharedSsid:"Shared WiFi SSID",
      sharedTips:"When turning off shared WiFi, the router will automatically restart",
      webadmin:"Remote Web Management",
      webadminPort:"Port",
      Server_IP:"Server IP",
      External_port:"External Port",
      IP:"IP",
      Internal_port:"Internal Port",
      AdminPass_NULL:"Admin password cannot be empty",
  		AdminPass_Length:"The length of the admin password is wrong, please enter 8 to 64 characters, a combination of numbers, letters, and symbols.",
  		AdminPass_Error:"Admin password input error, please enter again.",
  		AdminPass_CH:"Admin password, you can't enter Chinese.",
  		IP_NULL:"The IP address cannot be empty.",
  		IP_Illicit:"Illegal IP address input, please enter again.",
  		IP_Error:"The IP address input format is wrong, please enter again.",
  		Subnet_NULL:"The Subnet mask cannot be empty.",
  		Subnet_Illicit:"The Subnet mask input is illegal, please enter again.",
  		Subnet_Error:"The Subnet mask format is wrong, please enter again.",
  		GateWay_NULL:"The Gateway cannot be empty.",
  		GateWay_Illicit:"The Gateway input is illegal, please enter again.",
  		GateWay_Error:"The Gateway format is wrong, please enter again.",
  		DNS_Null:"The DNS cannot be empty.",
  		DNS_Illicit:"The DNS server input is illegal, please enter again.",
  		DNS_Error:"The DNS server input format is wrong, please enter again.",
  		Account_NULL:"The Username cannot be empty.",
  		DialPass_NULL:"The Password cannot be empty.",
  		DialPass_CH:"The Password can't be in Chinese",
  		SSID_NULL:"The SSID can't be empty.",
  		SSID_Length:"The length of the SSID cannot be more than 32 characters.",
  		WIFIPass_NULL:"The Password cannot be empty, please enter  8 to 64 ASCII characters.",
  		WIFIPass_Smaller:"The Password length cannot be less than 8 characters, please enter again!",
  		WIFIPass_Over:"The Password length cannot be more than 64 characters, please enter again!",
  		WIFIPass_CH:"The Password can't be in Chinese",
  		Enter_NULL:"Input can't be empty.",
  		Port_Scope:"The entered value is not in the range, please enter a value between 1 and 65535.",
  		Port_Error:"The Input is illegal, please enter a value between 1 and 65535.",
  		MTU_Scope:"The entered value is not in the range, please enter a value between 576 and 1492.",
  		MTU_Error:"The Input is Illegal, please enter a value between 576 and 1492.",
  		MTUppoe_Scope:"The entered value is not in the range, please enter a value between 576 and 1444.",
      MTUppoe_Error:"The Input is Illegal, please enter a value between 576 and 1444.",
      MTUl2tp_Scope:"The entered value is not in the range, please enter a value between 576 and 1460.",
      MTUl2tp_Error:"The Input is Illegal, please enter a value between 576 and 1460.",
  		Domain_Error:"Domain Name Input Error, please enter again.",
  		Alias_NULL:"The Alias cannot be empty.",
  		Alias_Over:"The Alias length can't be more than 18 characters.",
  		Alias_Error:"For the Alias, you cannot enter special characters.",
  		QOS_Error:"The Input is Illegal, Please enter a group of numbers from 0 to 9. ",
      hour_Error:"The Input is Illegal, Please enter a of numbers from 0 to 23.",
      min_Error:"The Input is Illegal, Please enter a of numbers from 0 to 59.",
      QOS_Over:"The Input is Illegal, please enter a value between 0 and 99999.",
      MAC_Illicit:"Wrong MAC length",
      MAC_Error:"MAC Address format Error",
      MAC_length:"Invalid MAC",
      closeFunton:"Funtion Not Online",
      // 新增
      recommendWanModeTip:"After testing, the recommended connection method is",
      hasNetTip:"You have successfully connected to the Internet",
      noNetTip:"You are currently offline",
      selectNetMode:"Please select the Internet access method",
      netMode:"Internet mode",
      setFinish:"Setup finish",
      routerSetTip1:"Congratulations, you are online!",
      routerSetTip2:"Please connect wireless signal",
      pleaseWait:"Please wait",
      reconnectionWifi:"reconnect wireless later",
      or:"or",
      second:"Seconds",
      pppoeName_placeholder:"Please enter the broadband account provided by your operator",
      pppoePwd_placeholder:"Please enter the broadband password provided by your carrier",
		  wanMode_notNull:'Please select wan mode',
		  quickSetup:"Quick Setup",
      wifiName:"Wi-Fi Name",
      wifiPassword:"Wi-Fi Password"
    }
};
var getPage=function() {
    if (getLang() == 'zhcn') {
        var curlang = lang.zhcn;
        $("#websit_info").attr('href', "http://www.b-link.net.cn/");
        $('#hostLogo').attr('src', 'images/logo_zh.png');
    } else {
        var curlang = lang.en;
        $("#websit_info").attr('href', "http://www.lb-link.cn/");
        $('#hostLogo').attr('src', 'images/logo_en.png');
    }
	$("#websit_info").children("span").html(curlang.Official);
    //public
    document.title = curlang.B_Link;
    $("#hostPage").html(curlang.myRouter);
    $("#MoreFunction").html(curlang.morefuntion);
    $("#ChangeMode").html(curlang.quickSetup);
    $("#term").html(curlang.term);
    $("#getNew").html(curlang.getupgrade);
    $(".workMode").html(curlang.workMode);
    $(".visitor_on").html(curlang.open);
    $(".visitor_off").html(curlang.close);
    $(".WCancel").html(curlang.cancel);
    $(".WApply").html(curlang.apply);
    //main
    $("#wanPppoe_set span").eq(0).html(curlang.wanPMode);
    $("#device_pc").html(curlang.Client_pc);
    $("#device_2g").html(curlang.Client_2g);
    $("#device_5g").html(curlang.Client_5g);
    $("#clientInfo").html(curlang.clientInfo);
    $("#upSpeed").siblings("span").html(curlang.devup);
    $("#downSpeed").siblings("span").html(curlang.devdown);
    $("#Setup").siblings("label").html(curlang.devup);
    $("#Setdown").siblings("label").html(curlang.devdown);
    $("#wlanTitle").html(curlang.wifiset);
    $("#wifi_2G").html(curlang.wireless_24g);
    $("#wifi_5G").html(curlang.wireless_5g);
    $("#2gSsid").html(curlang.ssid);
    $("#2gSsid_label").html(curlang.ssid_label);
    $("#2gMODE").html(curlang.encryptionmode);
    $("#wifi_wpawpa2").text(curlang.wifi_wpawpa2);
    $("#wifi_open").text(curlang.wifi_open);
    $("#2gPass").html(curlang.pass);
    $("#2gPass_label").html(curlang.pass_label);
    $("#5gSsid").html(curlang.ssid);
    $("#5gSsid_label").html(curlang.ssid_label);
    $("#5gMODE").html(curlang.encryptionmode);
    $("#5gwifi_wpawpa2").text(curlang.wifi_wpawpa2);
    $("#5gwifi_open").text(curlang.wifi_open);
    $("#5gPass").html(curlang.pass);
    $("#5gPass_label").html(curlang.pass_label);
    $("#rebootTitle").html(curlang.rebootrouter);
    $("#diagonsis_title").html(curlang.netdiagonsis);
    $(".bg-img span").html(curlang.netdiagonsis);
    $(".nd-left").eq(0).html(curlang.Checkwanport);
    $(".nd-left").eq(1).html(curlang.Checkwanmode);
    $(".nd-left").eq(2).html(curlang.Checkwanip);
    $(".nd-left").eq(3).html(curlang.Checkwandns);
    $(".nd-left").eq(4).html(curlang.Checkwanpage);
    $("#nd_wan").html(curlang.nd_wan);
    $("#nd_pppoe").html(curlang.nd_pppoe);
    $("#nd_static").html(curlang.nd_static);
    $("#nd_dhcp").html(curlang.nd_dhcp);
    $("#nd_wanIP").html(curlang.nd_wanIP);
    $("#nd_dns").html(curlang.nd_dns);
    $("#nd_wanhost").html(curlang.nd_wanhost);
    $("#nd_apply").html(curlang.rootedcheck);
    $("#wan_ip1_td").html(curlang.isip);
    $("#wan_mask1_td").html(curlang.mask);
    $("#gateway1_td").html(curlang.gateway);
    $("#wansettitle").html(curlang.WANtip);
    $("#pppoe_title").html(curlang.wanpppoe);
    $("#dhcp_title").html(curlang.wandhcp);
    $("#internet_type").html(curlang.wanstatic);
    $("#wanTitle").html(curlang.WANtip);
    $("#pppoename_span").html(curlang.wanusername);
    $("#pppoename_label").html(curlang.username_label);
    $("#pppoepass_span").html(curlang.wanpass);
    $("#server_name").html(curlang.server_name);
    $("#server_optional").html(curlang.server_optional);
    $("#server_label").html(curlang.server_label);
    $("#pppoepass_label").html(curlang.wanpass_label);
    $("#ip3_span").html(curlang.isip);
    $("#login_ip_label").html(curlang.ip_label);
    $("#msk_span").html(curlang.mask);
    $("#msk_label").html(curlang.mask_label);
    $("#gw_span").html(curlang.gateway);
    $("#gw_label").html(curlang.gateway_label);
    $("#dns1_span").html(curlang.dns1);
    $("#dns1_label").html(curlang.dns1_label);
    $("#dns2_span").html(curlang.dns2);
    $("#dns2_label").html(curlang.dns2_label);
    $("#lantitle").html(curlang.lantooltip);
    $("#lanip_span").html(curlang.isip);
    $("#lanIP_label").html(curlang.isip_label);
    $("#lanmsk_span").html(curlang.mask);
    $("#lanmsk_label").html(curlang.mask_label);
    $("#startip_span").html(curlang.chack_startip);
    $("#startip_label").html(curlang.startip_label);
    $("#endip_span").html(curlang.check_endip);
    $("#endip_label").html(curlang.endip_label);
    $("#upgradeTitle").html(curlang.getupgrade);
    $("#nowvsion").html(curlang.curvision);
    $("#newvsion").html(curlang.lastvision);
    $("#upgrade_button").html(curlang.upgrade_button);
    $("#uploadFWApply").val(curlang.upgrade_button);
    $("#wifi_2gssidStatus").siblings("p").html(curlang.Hidden_SSID);
    $("#wifi_5gssidStatus").siblings("p").html(curlang.Hidden_SSID);
    $("#terlist").html(curlang.mangement);
    //more
    $("#adminPass .menu_text").html(curlang.mgpassSet);
    $("#visitor .menu_text").html(curlang.visitorWlan);
    $("#visitor_5G .menu_text").html(curlang.visitorwlan);
    $("#signal .menu_text").html(curlang.singnalSet);
    $("#signal_5G .menu_text").html(curlang.singnalSet5G);
    $("#BlackList .menu_text").html(curlang.blacklist);
    $("#URL_blacklist .menu_text").html(curlang.url_blacklist);
    $("#StaticList .menu_text").html(curlang.staticList);
    $("#channelSet .menu_text").html(curlang.ChannelGet);
    $("#channelSet_5G .menu_text").html(curlang.Channel5Get);
    $("#restore .menu_text").html(curlang.restore);
    $("#ReBoot .menu_text").html(curlang.reboot);
    $("#LED .menu_text").html(curlang.led_name);
    $("#worldTime .menu_text").html(curlang.worldTime_name);
    $("#Wlanspeed .menu_text").html(curlang.inspeed);
    $("#vpnSet .menu_text").html(curlang.L2TPSet);
    $("#pptp_vpnSet .menu_text").html(curlang.pptpSet);
    $("#shared .menu_text").html(curlang.sharedWifi);
    $("#webadmin .menu_text").html(curlang.webadmin);
    $("#more_wifi .menu_text").html(curlang.wifitip);
    $("#more_5Gwifi .menu_text").html(curlang.wifiTip);
    $("#wifiTiming .menu_text").html(curlang.wifiTiming_off);
    $("#wireless2Title").html(curlang.wireless_24g);
    $("#wireless5Title").html(curlang.wireless_5g);
    $("#more_internet .menu_text").html(curlang.WANtip);
    $("#more_terminallist .menu_text").html(curlang.protectionlist);
    $("#more_lan .menu_text").html(curlang.lantooltip);
    $(".visitorKey").html(curlang.encryptionmode);
	  $(".visitorName").html(curlang.visitorName);
    $("#led_name").html(curlang.led_name);
    $("#open_led").text(curlang.led_open);
    $("#close_led").text(curlang.led_close);
    $("#WT_tip").html(curlang.WT_tip);
    $("#led_tip").html(curlang.led_tip);
    $("#DMZ_tip").html(curlang.DMZ_tip);
    $(".visitor_tip").html(curlang.Visitor_tip);
    $("#termTime_title").html(curlang.protectionlist);
    $("#termT1").html(curlang.time_period);
    $("#termT2").html(curlang.Time_period);
    $("#lostBlack").html(curlang.lostblack);
    $("#lostArp").html(curlang.loststatic);
    $("#pppoe_optional").html(curlang.server_optional);
    $("#pppoeserver_span").html(curlang.server_name);
    $("#pppoe_option1").html(curlang.O_auto);
    $("#serverpwd_span").html(curlang.wanpass);
    $("#user_switch").html(curlang.mangement);
    $("#user_pwd").html(curlang.wanpass);
    $("#pppoeserver_label").html(curlang.server_label);
    $("#serverpwd_label").html(curlang.wanpass_label);
    $("#sharedTitle").html(curlang.sharedOff);
    $("#sharedSSIDTitle").html(curlang.sharedSsid);
    $("#sharedTips").html(curlang.sharedTips);
    $("#helpT").html(curlang.help);
    $("#Por_span").html(curlang.port);
    $("#pwd_span").html(curlang.wanpass);
    $("#pwd_label").html(curlang.wanpass_label);
    $("#pptp_vpntitle").html(curlang.pptpSet);
    $(".vpn_domain_span").html(curlang.Domain);
    $(".vpn_username_span").html(curlang.wanusername);
    $(".vpn_username_label").html(curlang.username_label);
    $(".vpn_password_span").html(curlang.wanpass);
    $(".vpn_password_label").html(curlang.wanpass_label);
    $(".vpn_type_span").html(curlang.ip_addr);
    $(".vpn_ip_span").html(curlang.isip);
    $(".vpn_ip_label").html(curlang.isip_label);
    $(".vpn_mask_span").html(curlang.mask);
    $(".vpn_mask_label").html(curlang.mask_label);
    $(".vpn_gateway_span").html(curlang.gateway);
    $(".vpn_gateway_label").html(curlang.gateway_label);
    $("#NASuser_type_span").html(curlang.ip_addr);
    $("#NASuser_user_span").html(curlang.wanusername);
    $("#NASuser_user_label").html(curlang.username_label);
    $("#NASuser_password").html(curlang.wanpass);
    $("#NAS_NASuser_label").html(curlang.wanpass_label);
    $("#speedtitle").html(curlang.inspeed);
    $("#speedUp").html(curlang.upspeed);
    $("#speedDown").html(curlang.downspeed);
    $("#respeed_button").html(curlang.speedAgain);
    $(".visitor_name_span").html(curlang.ssid);
    $(".visitor_namelabel").html(curlang.ssid_label);
    $(".visitor_pass_span").html(curlang.pass);
    $(".visitor_passlabel").html(curlang.pass_label);
    $("#wifiTiming_title").html(curlang.wifiTiming_off);
    $("#mdz_ip_name").html(curlang.isip);
    $("#mdz_ip_namelabel").html(curlang.isip_label);
    $("#dmz_port_name").html(curlang.port);
    $("#ForwardingList_ip_span").html(curlang.isip);
    $("#ForwardingList_ip_label").html(curlang.isip_label);
    $("#Forwarding_type_span").html(curlang.ip_addr);
    $("#Forwardlist_type").html(curlang.ip_addr);
    $("#Forwardlist_mange").html(curlang.mangement);
    $("#VserverAdd_ip_span").html(curlang.Server_IP);
    $("#VserverAdd_pu_span").html(curlang.External_port);
    $("#VserverAdd_pr_span").html(curlang.Internal_port);
    $("#VserverAdd_type_span").html(curlang.ip_addr);
    $("#VserverList_start").html(curlang.External_port);
    $("#VserverList_end").html(curlang.Internal_port);
    $("#VserverList_type").html(curlang.ip_addr);
    $("#VserverList_mange").html(curlang.mangement);
    $("#hostBlacklist").html(curlang.url_blacklist);
    $("#url_t").html(curlang.host_blacklist);
    $("#edit_blacklist").html(curlang.shost_blacklist);
    $("#url_blacklist").html(curlang.pchostBlacklist);
    $("#term_t").html(curlang.termBlacklist);
    $("#url_set").html(curlang.host_sbu);
    $(".refresh").html(curlang.refresh);
    $("#set_urllist").html(curlang.host_sbu);
    $("#t_name").html(curlang.name);
    $("#del_urllist").html(curlang.Remove);
    $("#term_set").html(curlang.host_sbu);
    $("#blacktltle").html(curlang.blacklist);
    $("#bName").html(curlang.deviceName);
    $("#bMac").html(curlang.mac);
    $("#bChance").html(curlang.mangement);
    $("#staticTitle").html(curlang.staticList);
    $("#sName").html(curlang.deviceName);
    $("#sIP").html("IP ");
    $("#sMac").html(curlang.mac);
    $("#sChance").html(curlang.mangement);
    $("#userpwd_1_label").html(curlang.oldmgpass_label);
    $("#userpwd2_label").html(curlang.newmgpass_label);
    $("#dns_set1_label").html(curlang.dns_label);
    $("#dns_set2_label").html(curlang.dns_label);
    //mobile
    $("#mobileCountUnit").html(curlang.tai);
    $("#netDiagnosis").html(curlang.netdiagonsis);
    $("#wan_speed_manage p span").html(curlang.WANtip);
    $("#2_4G_wifi_set p span").html(curlang.wifitip);
    $("#5G_wifi_set p span").html(curlang.wifiTip);
    $("#wifiTiming p span").html(curlang.wifiTiming_off);
    $("#setup_terminallist p span").html(curlang.term);
    $("#lan_set p span").html(curlang.lantooltip);
    $("#ChangerMode p span").html(curlang.quickSetup);
    $("#LED_set p span").html(curlang.led_name);
    $("#worldTime p span").html(curlang.worldTime_name);
    $("#2_4G_Visitor_time_set p span").html(curlang.visitorWlan);
    $("#5G_Visitor_time_set p span").html(curlang.visitorwlan);
    $("#led_Wlanspeed p span").html(curlang.inspeed);
    $("#2_4G_channelSet p span").html(curlang.ChannelGet);
    $("#5G_channelSet p span").html(curlang.Channel5Get);
    $("#baby_BlackList p span").html(curlang.blacklist);
    $("#2_4G_signal_set p span").html(curlang.singnalSet);
    $("#5G_signal_set p span").html(curlang.singnalSet5G);
    $("#pro_term p span").html(curlang.protectionlist);
    $("#misc_reboot p span").html(curlang.reboot);
    $("#rally_restore p span").html(curlang.restore);
    $("#password p span").html(curlang.mgpassSet);
    $("#URL_blacklist p span").html(curlang.url_blacklist);
    $("#shared p span").html(curlang.sharedWifi);
    $("#webadmin p span").html(curlang.webadmin);
    $("#StaticList_time p span").html(curlang.staticList);
    $("#VPN_pptp_set p span").html(curlang.pptpSet);
    $("#VPN_l2tp_set p span").html(curlang.L2TPSet);
    $("#wanPppoe_set1 span").eq(0).html(curlang.wanPMode);
    $("#ChangeBox").html(curlang.Message);
    $("#Change_staticip").html(curlang.isip);
    $("#Change_staticmask").html(curlang.mask);
    $("#Change_staticgw").html(curlang.gateway);
    $("#term_name").html(curlang.deviceName);
    $("#termT").html(curlang.Tperiod);
    $("#termTime1,#WPeriod1").html(curlang.time_period);
    $("#termTime2,#WPeriod2").html(curlang.Time_period);
    $("#term_manage").html(curlang.mangement);
    $("#device_list").html(curlang.device_list);
    $("#up_label").html(curlang.total_traffic);
    $("#lostBlack_apply").html(curlang.lostblack);
    $("#uplimit_span").html(curlang.limit_not);
    $("#add_time").html(curlang.add_time);
    $("#hm_tips").html(curlang.limit_time);
    $("#Mhm_tips").html(curlang.limit_time);
    $("#lostBlack_label").html(curlang.forbidden);
    $("#lostArp_label").html(curlang.staticbind);
    $("#lostArp_apply").html(curlang.loststatic);
    $("#timelimit_label").html(curlang.protection);
    $("#add_timelimit").html(curlang.termT_add);
    $("#arpConfirm").html(curlang.loststatic);
    $("#blackConfirm").html(curlang.lostblack);
    $("#Change_pppoeuser").html(curlang.wanusername);
    $("#Change_pppoepass").html(curlang.wanpass);
    $("#Change_server_name").html(curlang.server_name);
    $("#Change_server_optional").html(curlang.server_optional);
    $("#ser_span").html(curlang.ip_addr);
    $("#port_span").html(curlang.port);
    $("#domain_span").html(curlang.Domain);
    $("#l2tp_set").html(curlang.L2TPSet);
    $("#pptp_set").html(curlang.pptpSet);
    $("#vpn_domain_span").html(curlang.Domain);
    $("#pptp_domain_span").html(curlang.Domain);
    $("#vpn_username_span").html(curlang.wanusername);
    $("#pptp_username_span").html(curlang.wanusername);
    $("#vpn_password_span").html(curlang.wanpass);
    $("#pptp_password_span").html(curlang.wanpass);
    $("#mppe_enable").html(curlang.mppeOpen);
    $("#mppe_disable").html(curlang.mppeClose);
    $("#vpn_type_span").html(curlang.ip_addr);
    $("#pptp_type_span").html(curlang.ip_addr);
    $("#vpn_ip_span").html(curlang.isip);
    $("#pptp_ip_span").html(curlang.isip);
    $("#vpn_mask_span").html(curlang.mask);
    $("#pptp_mask_span").html(curlang.mask);
    $("#vpn_gateway_span").html(curlang.gateway);
    $("#pptp_gateway_span").html(curlang.gateway);
    $(".qosUP").html(curlang.upspeed);
    $(".qosDOWN").html(curlang.downspeed);
    $("#setVisitortitle").html(curlang.visitorwlan);
    $("#visitor_name_span").html(curlang.ssid);
    $("#5Gvisitor_name_span").html(curlang.ssid);
    $("#visitor_pass_span").html(curlang.pass);
    $("#5Gvisitor_pass_span").html(curlang.pass);
    $("#Channeltitle").html(curlang.ChannelGet);
    $("#CountryCodeFloat_span").html(curlang.CountryCode);
    $("#FloatChannel_span").html(curlang.ChannelChance);
    $("#CountryCodeDouble_span").html(curlang.CountryCode);
    $("#DoubleChannel_span").html(curlang.ChannelChance);
    $(".O_auto").text(curlang.O_auto);
    $(".united_states").text(curlang.united_states);
    $(".japan").text(curlang.japan);
    $(".france").text(curlang.france);
    $(".taiwan").text(curlang.TaiWan);
    $(".ireland").text(curlang.ireland);
    $(".china").text(curlang.chain);
    $(".O_none").text(curlang.O_none);
    $(".C_channel").text(curlang.C_channel);
    $(".M_channel").text(curlang.M_channel);
    $(".bandwidth").text(curlang.bandwidth);
    $(".band_mode1").text(curlang.band_mode1);
    $(".band_mode2").text(curlang.band_mode2);
    $(".band_mode3").text(curlang.band_mode3);
    $(".Current_tips").html(curlang.Current_tips);
    $(".Current2_tips").html(curlang.Current2_tips);
    $("#led_modeTitle").html(curlang.led_mode);
    $("#startTime").html(curlang.startTime);
    $("#endTime").html(curlang.endTime);
    $("#Timing").html(curlang.Timing);
    $(".spacing").html(curlang.Min);
    $(".timeSlot").html(curlang.Hour);
    $("#webPortSpan").html(curlang.webadminPort);
    $("#VserverAdd_ip_span").html(curlang.Server_IP);
    $("#VserverAdd_pu_span").html(curlang.External_port);
    $("#VserverAdd_pr_span").html(curlang.Internal_port);
    $("#VserverAdd_type_span").html(curlang.ip_addr);
    $("#VserverList_start").html(curlang.External_port);
    $("#VserverList_end").html(curlang.Internal_port);
    $("#VserverList_type").html(curlang.ip_addr);
    $("#VserverList_mange").html(curlang.mangement);
    $("#label_1").html(curlang.greenmode);
    $("#label_2").html(curlang.Balancemode);
    $("#label_3").html(curlang.HPmode);
    $("#label_4").html(curlang.greenmode);
    $("#label_5").html(curlang.Balancemode);
    $("#label_6").html(curlang.HPmode);
	$("#advancedDNS .menu_text").html(curlang.DNStitle);
    $("#worldTime_name").html(curlang.worldTime_name);
    $("#cur_timeTitle").html(curlang.cur_timeTitle);
    $("#time_server").html(curlang.time_server);
    $("#time_zoneTitle").html(curlang.time_zoneTitle);
    $("#manNTPMidIsland").text(curlang.MidIsland);
    $("#manNTPHawaii").text(curlang.Hawaii);
    $("#manNTPAlaska").text(curlang.Alaska);
    $("#manNTPPacific").text(curlang.Pacific);
    $("#manNTPMountain").text(curlang.Mountain);
    $("#manNTPArizona").text(curlang.Arizona);
    $("#manNTPCentral").text(curlang.Central);
    $("#manNTPMidUS").text(curlang.MidUS);
    $("#manNTPIndianaEast").text(curlang.IndianaEast);
    $("#manNTPEastern").text(curlang.Eastern);
    $("#manNTPAtlantic").text(curlang.Atlantic);
    $("#manNTPBolivia").text(curlang.Bolivia);
    $("#manNTPGuyana").text(curlang.Guyana);
    $("#manNTPBrazilEast").text(curlang.BrazilEast);
    $("#manNTPMidAtlantic").text(curlang.MidAtlantic);
    $("#manNTPAzoresIslands").text(curlang.AzoresIslands);
    $("#manNTPGambia").text(curlang.Gambia);
    $("#manNTPEngland").text(curlang.England);
    $("#manNTPCzechRepublic").text(curlang.CzechRepublic);
    $("#manNTPGermany").text(curlang.Germany);
    $("#manNTPTunisia").text(curlang.Tunisia);
    $("#manNTPGreece").text(curlang.Greece);
    $("#manNTPSouthAfrica").text(curlang.SouthAfrica);
    $("#manNTPIraq").text(curlang.Iraq);
    $("#manNTPMoscowWinter").text(curlang.MoscowWinter);
    $("#manNTPArmenia").text(curlang.Armenia);
    $("#manNTPPakistan").text(curlang.Pakistan);
    $("#manNTPBangladesh").text(curlang.Bangladesh);
    $("#manNTPThailand").text(curlang.Thailand);
    $("#manNTPChinaCoast").text(curlang.ChinaCoast);
    $("#manNTPTaipei").text(curlang.Taipei);
    $("#manNTPSingapore").text(curlang.Singapore);
    $("#manNTPAustraliaWA").text(curlang.AustraliaWA);
    $("#manNTPJapan").text(curlang.Japan);
    $("#manNTPKorean").text(curlang.Korean);
    $("#manNTPGuam").text(curlang.Guam);
    $("#manNTPAustraliaQLD").text(curlang.AustraliaQLD);
    $("#manNTPSolomonIslands").text(curlang.SolomonIslands);
    $("#manNTPFiji").text(curlang.Fiji);
    $("#manNTPNewZealand").text(curlang.NewZealand);
    $("#manNTPNuku").text(curlang.Nuku);
    $("#RestoreTitle").html(curlang.restore);
    $("#restoreTitle").html(curlang.resetRouter);
    $("#Accounttitle").html(curlang.mgpassSet);
    $("#oldpass_span").html(curlang.oldmgpass);
    $("#newpass_span").html(curlang.newmgpass);
    $("#shost_blacklist span").html(curlang.hostBlacklist);
    $("#host_blacklist span").html(curlang.blacklist);
    $("#host_con").html(curlang.host_blacklist);
    $("#term_Btitle").html(curlang.termBlacklist);
    $("#set_hostCon").html(curlang.host_setup);
    $("#Tblacktitle").html(curlang.name);
    $("#url_edit,#term_edit").html(curlang.host_edit);
    $("#url_sbu,#term_sbu").html(curlang.host_sbu);
    $("#url_del,#term_del").html(curlang.Remove);
    $("#url_tip").html(curlang.host_urlTips);
    $("#url_tip1").html(curlang.host_urlTips1);
    $("#url_tip2").html(curlang.host_urlTips2);
    $("#url_tip3").html(curlang.host_urlTips3);
    $("#term_website").html(curlang.host_website);
    $("#RootTitle").html(curlang.reboot);
    //setup
    $("#modeChange").html(curlang.quickSetup);
    $("#help-info").html(curlang.help);
    $(".Tdmiddle em").eq(0).html(curlang.RouteMode);
    $(".Tdmiddle em").eq(2).html(curlang.RelayMode);
    $(".Tdmiddle em").eq(1).html(curlang.WISPmode);
    $(".Tdmiddle em").eq(3).html(curlang.ClientMode);
    $(".Tdmiddle em").eq(4).html(curlang.BridgeMode);
    $(".Tdmiddle span").eq(0).html(curlang.wanModeTips);
    $(".Tdmiddle span").eq(2).html(curlang.wifiModeTips);
    $(".Tdmiddle span").eq(1).html(curlang.wispModeTips);
    $(".Tdmiddle span").eq(3).html(curlang.wifiModeTips);
    $(".Tdmiddle span").eq(4).html(curlang.BridgeModeTips);
    $("#setup_more span").eq(0).html(curlang.setupMode);
    $("#wan_type1").html(curlang.wanpppoe+'>');
    $("#wan_type2").html(curlang.wandhcp+'>');
    $("#wan_type3").html(curlang.wanstatic+'>');
    $("#pppoeuser").html(curlang.wanusername);
    $("#pppoepass").html(curlang.wanpass);
    $("#staticip").html(curlang.isip);
    $("#staticmask").html(curlang.mask);
    $("#staticgw").html(curlang.gateway);
    $("#wan_prev").html(curlang.LastStep);
    $("#wan_after").html(curlang.NextStep);
    $("#Fwifi").html(curlang.ssid);
    $("#Fpass").html(curlang.pass);
    $("#Dwifi").html(curlang.ssid);
    $("#Dpass").html(curlang.pass);
    $("#wlan_prev").html(curlang.LastStep);
    $("#wlan_after").html(curlang.NextStep);
    $("#list_prev").html(curlang.LastStep);
    $("#toScan").html(curlang.To_scan);
    $("#to_scan").html(curlang.To_scan);
    $("#list_after").html(curlang.NextStep);
    $("#logo_prev").html(curlang.LastStep);
    $("#login_prev").html(curlang.LastStep);
    $("#login_after").html(curlang.NextStep);
    $("#msg").html(curlang.info);
    $("#dialogWifi").html(curlang.ssid);
    $("#dialogPass").html(curlang.pass);
    $("#wlan_link").html(curlang.Connect);
    $("#ChangeInfoBody").html(curlang.Message);
    $("#changeTrue").html(curlang.Switch);
    // 新增
    $("#wanCheckTip").html(curlang.recommendWanModeTip+":");
    $(".wandhcp").html(curlang.wandhcp);
    $(".wanpppoe").html(curlang.wanpppoe);
    $(".wanstatic").html(curlang.wanstatic);
    $("#noWanTip").html(curlang.noWanTip);
    $("#hasNetTip").html(curlang.hasNetTip);
    $("#noNetTip").html(curlang.noNetTip);
    $('.divider label').html(curlang.or);
    $('.routerSetTip1').html(curlang.routerSetTip1);
    $('.setting-tips').find('span').eq(0).html(curlang.pleaseWait);
    $('.setting-tips').find('span').eq(2).html(curlang.second+curlang.reconnectionWifi);
    $('#wlan_after').html(curlang.NextStep);
    $('.twoWifiSsid').prev().html(curlang.wifiName+":");
    $('.twoWifiPassword').prev().html(curlang.wifiPassword+":");
    $('.fiveWifiSsid').prev().html(curlang.wifiName+":");
    $('.fiveWifiPassword').prev().html(curlang.wifiPassword+":");
    $('#pppoeUser').attr('placeholder', curlang.pppoeName_placeholder);
    $('#pppoePass').attr('placeholder', curlang.pppoePwd_placeholder);
    $('#staticIp').attr('placeholder', curlang.ip_label);
    $('#staticMask').attr('placeholder', curlang.mask_label);
    $('#staticGw').attr('placeholder', curlang.gateway_label);
    $('#staticDNS').attr('placeholder', curlang.dns1_label);
    $("#Change_pppoeserver").html(curlang.server_name);
    $("#pppoeServer").attr('placeholder',curlang.server_optional);
    return;
}
