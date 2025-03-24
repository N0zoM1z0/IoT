var langs= {
    zhcn:{
        myRouter:"路由状态",
        morefuntion:"路由设置",
        b_link:"路由器",
        Internet:"互联网",
        upside:"上行速率:",
        downside:"下行速率:",
        surf_nternet:"终端",
        stable_operation:"上线时间",
        minutes:"分钟",
        hours:"小时",
        version:"版本号:",
        getupgrade:"系统升级",
        apply:"确 定",
        online_Time:"在线: ",
        alias:"别名:",
        server_optional:"可选的",
    },
    en:{
  	   myRouter:"Routing State",
	     morefuntion:"Advanced",
       b_link:"Router",
       Internet:"Internet",
       upside:"Upload:",
       downside:"Download:",
       surf_nternet:"Terminal",
       stable_operation:"Up-Time",
       minutes:"Minutes",
       hours:"Hours",
       version:"Version:",
       getupgrade:"Upgrade",
       apply:"Apply",
       online_Time:"Online: ",
       alias:"Alias",
      server_optional:"Optional"
    }
};
var getPages=function() {
    if (getLang() == 'zhcn') {
        var curlang = langs.zhcn;
        $('#hostLogo').attr('src', '../images/logo_zh.png');
    } else {
        var curlang = langs.en;
        $('#hostLogo').attr('src', '../images/logo_en.png');
    }
    $("#routerStatus").html(curlang.myRouter);
    $("#routerSet").html(curlang.morefuntion);
    $("#routerTxt").html(curlang.b_link);
    $("#internetTxt").html(curlang.Internet);;
    $("#upside").html(curlang.upside);
    $("#downside").html(curlang.downside);
    $("#surf_nternet").html(curlang.surf_nternet);
    $("#stable_operation").html(curlang.stable_operation);
    $("#fnUnit").html(curlang.minutes);
    $("#version").html(curlang.version);
    $("#update p span").html(curlang.getupgrade);
    $("#alias").html(curlang.alias);
    $('#pppoeServer,#login_server').attr('placeholder', curlang.server_optional);
    return;
}
