﻿var curpasswd;
var showFlag=0;
var showter=true;
var speedFlag=0;
var cpAlies;
var curNumber;
var selfMac;
var IsDouble=false;
var REBOOT=null;
var vpnFlag=true;
var set_restore=0;
var FTPuser="",FTPpass="",SAMuser="",SAMpass="";
var alias_D,limit_D=true;
var curNASboxNumber=0;
var browser = {
    versions: function() {
        var u = navigator.userAgent, app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1, //android终端或uc浏览器
            iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        };
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
}

if(myBrowser()=="IE8"){
	$(".tab_container li .LED i").css({"background-size":"100%","filter":"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='codeBlue/LED.png',sizingMethod='scale')"});
	$(".tab_container li .LED .float_info i").css({"background-size":"100%","filter":"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='code/LED.png',sizingMethod='scale')"});
    $("#wifi_2gssidStatus").click(function (){
            onformFloatSSID();
    });
    $("#wifi_5gssidStatus").click(function(){
            onformDoubleSSID();
	});
}else{
    $(".tab_container li .LED i").css({"background-image":"url('codeBlue/LED.png')","background-size": "64px"});
    $(".tab_container li .LED .float_info i").css({"background-image":"url('code/LED.png')","background-size": "64px"});
    $("#wifi_2gssidStatus").on("change", function() {
        onformFloatSSID();
    });
    $("#wifi_5gssidStatus").on("change", function() {
        onformDoubleSSID();
    });
}
function myBrowser(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
    if (isIE) {
        var IE8 = false;
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);
        IE8 = fIEVersion == 8.0;
        if (IE8) {
            return "IE8";
        }
    }//isIE end
}
$(function() {
	$("#internet").mouseover(function(){
		layer.tips(curlang.WANtip, this);
	})
	$("#reset").mouseover(function(){
		layer.tips(curlangs.reboottip, this);
	})
	$("#wifi").mouseover(function(){
		layer.tips(curlang.wifiset, this);
	})
	$('.lancon').on('mouseover', function(){
		layer.tips(curlang.lantooltip,this,{tips:1}); //在元素的事件回调体中，follow直接赋予this即可
	});
	$(".close").click(function(){
		layer.closeAll();
	})
})
function getMobile() {
    var mob = 0;
    if (browser.versions.mobile || browser.versions.android || browser.versions.iPhone) {
        mob = 1;
    }
    return mob;
}
function getNum(obj){
	curNumber=$(obj).attr('id').replace("passWord","");
}
function cpName(obj){
	timeControl(0);
	cpAlies=$(obj).val();
}
function lb_restart(type) {
	var Time;
    if (type == "update") {
        Time =150;
    }
    else{
		if(IsDouble){
			Time =75;
		}else{
			Time =70;
		}
	}
    var time = parseInt(Time, 10);
    $("#curTime").html(time);
    $("#ug_time").html(time+"s");
   if (REBOOT){window.clearInterval(REBOOT);}
   REBOOT = window.setInterval(function () {
        time--;
        $("#curTime").html(time);
       	$("#ug_time").html(time+"s");
        if (time == 0) {
            window.onbeforeunload = null;
            window.clearInterval(REBOOT);
			if(type=="reboot"||type=="update")
				{window.location="../login.asp";}else{
				window.location="setup.html";
				}
			}
    }, 1000)
}
function restart(type){
	setTimeout(function(){lb_restart(type);},2000);
	var word;
	if(type=="update"){word=curlang.updatetime}else{word=curlang.waitingtime;}
	setTimeout(function(){window.reset=layer.open({
	  type: 1,
	  closeBtn: 0, //不显示关闭按钮
	  shift: 3,
	  offset:'150px',
	  skin:'layui-layer-loading',
	  scrollbar: false,
	  title: false,
	  shade: [0.7, '#000'],
	  content: '<div style="margin:0 auto;width:90px;height:90px;background: url(/admin/js/layer/skin/default/loading-2.gif) no-repeat;background-size: cover;-ms-behavior: url(/admin/backgroundsize.min.htc);behavior: url(/admin/backgroundsize.min.htc);" class="layui-layer-content layui-layer-loading2"></div><h4 style="text-align:center;font-size:15px;color:#fff"><span>'+word+'</span><label id="curTime" style="color:#7eda3d"></label>s</h4>'
	})},2000);
}
//返回信息
function showMessig(obj,num){
	if(obj==null||obj==""||(!obj)){
	 return;
	}
	else{
	if((typeof obj)=="object"){var msg=obj;}
	else{var msg=eval('('+obj+')'); }
		if(msg.result==0){
			if(num==1){
				layer.msg(curlang.info1, {icon: 6});
			}else{
				layer.msg(curlang.info2, {icon: 6});
			}
		}else if(msg.result==6){
			layer.msg(curlang.dns_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
	}
}
function showanimation(type,obj,num){
	if(type==1){
		window.animation=layer.open({
		  type: 1,
		  closeBtn: 0, //不显示关闭按钮
		  shift: 3,
		  offset:'160px',
		  area: '240px',
		  scrollbar: false,
		  title: false,
		  shade: [0.01, '#000'],
		  skin:"message_layer_h",
		  content: '<div style="display:block;" id="message_layer"><div id="msg_type" class="success"><img src="/admin/images/122.gif" /></div><div id="ug_time" style="color:#7eda3d;text-align: center;font-size: 15px;"></div><div id="msg" class="word"></div></div>'
		});
		$("#msg_type").children("img").attr("src","/admin/images/122.gif");
		$("#msg").html(curlang.PeaseWait);
	}
	if(type==2){
		if(obj==null||obj==""||(!obj)){
			$("#msg_type").children("img").attr("src","/admin/images/msg-error.png");
			$("#msg").html(curlang.info3);
			setTimeout(function(){layer.close(window.animation);},2000);
			return;
		}
		else{
		if((typeof obj)=="object"){var msg=obj;}
		else{var msg=eval('('+obj+')'); }
			if(msg.result==0){
				if(num==1){
					$("#msg_type").children("img").attr("src","/admin/images/msg-success.png");
					$("#msg").html(curlang.info1);
					setTimeout(function(){layer.close(window.animation);},2000);
				}else{
					$("#msg_type").children("img").attr("src","/admin/images/msg-success.png");
					$("#msg").html(curlang.info2);
					setTimeout(function(){layer.close(window.animation);},2000);
				}
			}else if(msg.result==6){
				$("#msg_type").children("img").attr("src","/admin/images/msg-error.png");
				$("#msg").html(curlang.dns_result);
				setTimeout(function(){layer.close(window.animation);},2000);
			}else{
				$("#msg_type").children("img").attr("src","/admin/images/msg-error.png");
				$("#msg").html(curlang.info3);
				setTimeout(function(){layer.close(window.animation);},2000);
			}
		}
	}
	if(type==3){
		$("#msg_type").children("img").attr("src","/admin/images/msg-error.png");
		$("#msg").html(curlang.info3);
		setTimeout(function(){layer.close(window.animation);},2000);
	}
    if(type==4){
        $("#msg_type").children("img").attr("src","/admin/images/msg-success.png");
        $("#msg").html(curlang.info2);
        setTimeout(function(){layer.close(animation);restart('reboot');},2000);
    }
	if(type==5){
		$("#msg_type").children("img").attr("src","/admin/images/msg-success.png");
		$("#msg").html(curlang.info2);
		setTimeout(function(){layer.close(window.animation);},2000);
	}
	if(type==6){
		window.manimation=layer.open({
		  type: 1,
		  closeBtn: 0, //不显示关闭按钮
		  shift: 3,
		  offset:'160px',
		  area: '240px',
		  scrollbar: false,
		  title: false,
		  shade: [0.01, '#000'],
		  skin:"message_layer_mh",
		  content: '<div style="display:block" id="message_layer"><div id="msg_type" class="success"><img src="/admin/images/msg-success.png" /></div><div id="msg" class="word"></div></div>'
		});
		$("#msg").html(curlang.info2);
		setTimeout(function(){layer.close(window.manimation);},2000);
	}
	if(type==7){
        $("#msg_type").children("img").attr("src","/admin/images/msg-success.png");
        setTimeout(function(){layer.close(window.animation);},1000);
    }
}
//主页面设备列表
function showline(obj){
	if(showFlag){
		$(obj).siblings(".hideLine").css("display","none");
		//$(obj).html('^');
		timeControl(1);
		showFlag=0;
	}
	else{
		$(obj).siblings(".hideLine").css("display","block");
		//$(obj).html('v');
		timeControl(0);
		showFlag=1;
	}
}
//主页面qos
function SetupSpeed(obj){
	if($("#upapply").attr("data-id")==1){
		var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
		var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
		var upVal=$(obj).siblings().eq(1).find("#upLimit").val();
		var downVal=$(obj).siblings().eq(1).find("#downLimit").val();

		var UP=CheckQos(upVal);
		if(!UP){$("#upLimit").focus();return false;}
		var DOWN=CheckQos(downVal);
		if(!DOWN){$("#downLimit").focus();return false;}
	}else{
        var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
        var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
		var downVal=0,upVal=0;
	}
	showanimation(1,"11",0);
	$.ajax({
		type: 'post',
		url: '/goform/set_qos_cfg',
		data: {"type":"setqos","MAC":mac,"IP":ip,"Up_Speed":upVal,"Dl_Speed":downVal},
		dataType:"json",
		success: function(data) {
			//showMessig(data,0);
			showanimation(2,data,0);
			if($("#upapply").attr("data-id")==1){
                $(obj).siblings(".dev-center").css("display","inline");
                $(obj).siblings("#uplimit_span").hide();
                $(obj).hide();
                $("#upapply").css("display","inline-block");
                $("#upapply").html(curlang.limit_cancel);
                $("#upapply").attr("data-id","0");
			}else{
                $(obj).siblings(".dev-center").hide();
                $("#upLimit").val("");
                $("#downLimit").val("");
                $(obj).siblings("#uplimit_span").css("display","inline-block");
                $(obj).html(curlang.limit_speed);
                $("#upapply").attr("data-id","1");
			}
			//sleep(0);
		},
		error:function(data)
		{
			showanimation(3,data,0);
		}
	})
}
function MSetupSpeed(obj){
	if($("#upapply").attr("data-id")==1){
		var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
		var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
		var upVal=$(obj).parent().siblings(".dev-center").find("#upLimit").val();
		var downVal=$(obj).parent().siblings(".dev-center").find("#downLimit").val();

		var UP=CheckQos(upVal);
		if(!UP){$("#upLimit").focus();return false;}
		var DOWN=CheckQos(downVal);
		if(!DOWN){$("#downLimit").focus();return false;}
	}else{
        var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
        var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
		var downVal=0,upVal=0;
	}
	showanimation(1,"11",0);
	$.ajax({
		type: 'post',
		url: '/goform/set_qos_cfg',
		data: {"type":"setqos","MAC" :mac,"IP":ip,"Up_Speed":upVal,"Dl_Speed":downVal},
		dataType:"json",
		success: function(data) {
			//showMessig(data,0);
			showanimation(2,data,0);
			if($("#upapply").attr("data-id")==1){
                $(obj).parent().siblings(".dev-center").css("display","block");
                $(obj).siblings("#uplimit_span").hide();
                $(obj).hide();
                $("#upapply").css("display","inline-block");
                $("#upapply").html(curlang.limit_cancel);
                $("#upapply").attr("data-id","0");
			}else{
                $(obj).parent().siblings(".dev-center").hide();
                $("#upLimit").val("");
                $("#downLimit").val("");
                $(obj).siblings("#uplimit_span").css("display","inline-block");
                $("#upapply").html(curlang.limit_speed);
                $("#upapply").attr("data-id","1");
			}
			//sleep(0);
		},
		error:function(data)
		{
			showanimation(3,data,0);
		}
	})
}
function getQos(mac){
	$.ajax({
		type: 'get',
		url: '/goform/get_qos_cfg',
		data: {"type":"getqos","MAC" :mac},
		dataType:"json",
		success: function(data) {
			if((typeof data)=='object'){
				var msg=data;
			}else{
				var msg=eval('('+data+')');
			}
			if($("#upapply").attr("data-id")==1){
                $("#upLimit").val("");
                $("#downLimit").val("");
			}else{
                $("#upLimit").val(msg.Up_Speed);
                $("#downLimit").val(msg.Dl_Speed);
			}
		},
		error:function(data)
		{
		}
	})
}

function showQos(obj){
	var displayflag=$(obj).parent().siblings(".qosLine").css("display");
	if(displayflag == "none")
	{
		getQos(obj);
		$(obj).parent().siblings(".qosLine").css("display","block");
	}
	else
		$(obj).parent().siblings(".qosLine").css("display","none");
	/*if(speedFlag){
		$(obj).parent().siblings(".qosLine").css("display","none");
		speedFlag=0;
	}else{
		getQos(obj);
		$(obj).parent().siblings(".qosLine").css("display","block");
		speedFlag=1;
	}*/
}
function addBind(obj){
	var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
	var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
	showanimation(1,'00',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_staticlist',
		data: {"type":"setarpbind","mac":mac,"ip":ip,"bind":"1"},
		dataType:"json",
		success: function(data) {
       // showMessig(data,0);
			if(data.result==0){
                showanimation(5);
                $(obj).siblings().eq(1).html(curlang.binded);
                $(obj).html(curlang.Unbind);
                $("#lostArp_apply").attr("data-id","0");
			}else if(data.result==3){
                layer.close(window.animation);
                layer.msg(curlang.add_bindLimit,{icon:5});
			}else{
                showanimation(3);
			}

		//sleep(0);
		},
		error:function(data)
		{
			showanimation(3,data,0);
		}
	})
}
function unBind(obj){
	var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
	var ip=$(obj).parent().siblings().eq(2).find(".span-r").html();
	showanimation(1,'00',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_staticlist',
		data: {"type":"setarpbind","mac":mac,"ip":ip,"bind":"0"},
		dataType:"json",
		success: function(data) {
       // showMessig(data,0);
		showanimation(2,data,0);
            $(obj).siblings().eq(1).html(curlang.unbounded);
            $(obj).html(curlang.loststatic);
            $("#lostArp_apply").attr("data-id","1");
		//sleep(0);
		},
		error:function(data)
		{
			showanimation(3,data,0);
		}
	})
}
function addBlack(obj){
	var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_blacklist',
		data: {"type":"setmacblack","mac":mac,"enable":"1"},
		dataType:"json",
		success:function(data) {
		//sleep(0);
         //showMessig(data,0);
			if(data.result==0){
                showanimation(5);
                getData_terminal_info();
                setTimeout(function(){layer.closeAll();},2000);
			}else if(data.result==3){
                layer.close(window.animation);
				layer.msg(curlang.add_blackLimit,{icon:5});
			}else{
                showanimation(3);
			}
    	},
		error:function(data)
		{
			showanimation(3,data,0);
		}
	})
}
function addMBlack(obj){
	var mac=$(obj).parent().siblings().eq(1).find(".span-r").html();
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_blacklist',
		data: {"type":"setmacblack","mac":mac,"enable":"1" },
		dataType:"json",
		success:function(data) {
			//sleep(0);
			//showMessig(data,0);
			if(data.result==0){
                showanimation(5);
                getM_terminal_info();
                setTimeout(function(){
                    $(".terminal_list").css("display","block");
                    $("#set_device").css("display","none");
                    $(".appCallback").css("display", "block");
                    $(".contentCallback").css("display", "none");
                    $(".appMenu").css("display", "block")
                },2000);
			}else if(data.result==3){
                layer.close(window.animation);
				layer.msg(curlang.add_blackLimit,{icon:5});
			}else{
                showanimation(3);
			}

    	},
		error:function(data){
			showanimation(3,data,0);
		}
	})
}
//输入设置
function inputSet(num){
	if(num=="0"){
			$("#wifi_ssid").attr("disabled",true);
			$("#wifi_ssid").css("cursor","not-allowed");
			$("#soft_mode").attr("disabled",true);
			$("#soft_mode").css("cursor","not-allowed");
			$("#wifi_pass1").attr("disabled",true);
			$("#wifi_pass1").css("cursor","not-allowed");
	}else{
			$("#wifi_ssid").attr("disabled",false);
			$("#wifi_ssid").css("cursor","text");
			$("#soft_mode").attr("disabled",false);
			$("#soft_mode").css("cursor","pointer");
			$("#wifi_pass1").attr("disabled",false);
			$("#wifi_pass1").css("cursor","text");
	}
}
function input5Set(num){
	if(num=="0"){
			$("#5gwifi_ssid").attr("disabled",true);
			$("#5gwifi_ssid").css("cursor","not-allowed");
			$("#5gsoft_mode").attr("disabled",true);
			$("#5gsoft_mode").css("cursor","not-allowed");
			$("#5gwifi_pass1").attr("disabled",true);
			$("#5gwifi_pass1").css("cursor","not-allowed");
	}else{
			$("#5gwifi_ssid").attr("disabled",false);
			$("#5gwifi_ssid").css("cursor","text");
			$("#5gsoft_mode").attr("disabled",false);
			$("#5gsoft_mode").css("cursor","pointer");
			$("#5gwifi_pass1").attr("disabled",false);
			$("#5gwifi_pass1").css("cursor","text");
	}
}
//QOS模式
function moreQOS_status(val){
	if(val==1){
        $("#more_qtype").attr("disabled",false);
        $("#more_qtype").removeClass("selection-disabled");
        more_qtype_status();
	}else{
        $("#QOS_up").val("");
        $("#QOS_down").val("");
        $("#more_qtype").attr("disabled",true);
        $("#QOS_up").attr("disabled",true);
        $("#QOS_down").attr("disabled",true);
        $("#more_qtype").addClass("selection-disabled");
        $("#QOS_up").addClass("inpt-disabled");
        $("#QOS_down").addClass("inpt-disabled");
        click_load(0);
	}
}
function more_qtype_status() {
    if($("#more_qtype").val()==1){
        $("#QOS_up").attr("disabled",false);
        $("#QOS_down").attr("disabled",false);
        $("#QOS_up").removeClass("inpt-disabled");
        $("#QOS_down").removeClass("inpt-disabled");
        click_load(1);
    }else{
        $("#QOS_up").val("");
        $("#QOS_down").val("");
        $("#QOS_up").attr("disabled",true);
        $("#QOS_down").attr("disabled",true);
        $("#QOS_up").addClass("inpt-disabled");
        $("#QOS_down").addClass("inpt-disabled");
        click_load(0);
    }
}

$("#moreQOS_on").click(function(){
    moreQOS_status(1);
})
$("#moreQOS_off").click(function(){
    moreQOS_status(0);
})
$("#more_qtype").click(function(){
    more_qtype_status();
})
function click_load(obj){
	if(obj==1){
        $("#start_speed").css("display","inline-block");
		$("#start_speed").unbind("click");
        $("#start_speed").click(function(){
            $("#start_speed").unbind("click");
            onform_testspeed();
            $("#Qspeed_title").css("display","block");
            setTimeout(function(){
                $.ajax({
                    type:"get",
                    url:"/goform/test_speed_info",
                    dataType:"json",
                    success: function(msg)
                    {
                        if((typeof msg)=="object"){var data=msg;}
                        else{ var data=eval('('+msg+')');}
                        var load=(data.download*8/1024/1024).toFixed(2);
                        var up=(data.upload*8/1024/1024).toFixed(2);
                        $("#speed_p").css("display","block");
                        $("#write").css("display","inline-block");
                        $("#up_speed").html(up);
                        $("#d_speed").html(load);
                        $("#start_speed").html(curlang.speedAgain);
                        click_load(1);
                        $("#Qspeed_title").css("display","none");
                        $("#write").click(function(){
                            $("#QOS_up").val($("#up_speed").html());
                            $("#QOS_down").val($("#d_speed").html());
                        })
                    },
                    error: function(msg){}
                })
			},34000);

		})
	}else{
        $("#start_speed").unbind("click");
        $("#start_speed").css("display","none");
        $("#write").css("display","none");
	}
}
//QOS验证
function set_QOSchecked(val){
    var reg=/^[0-9]+([.]{1}[0-9]{1,2}){0,1}$/;
    if(val==""){
        layer.msg(curlang.Enter_NULL, {icon: 5});
        return false;
	}
	if(!(reg.test(val))){
        layer.msg(curlangs.Enter_format, {icon: 5});
        return false;
	}
	return true;
}
function set_moreQos(){
    if($("#moreQOS_on").prop("checked")){
    	if($("#more_qtype").val()==1){
            if(!set_QOSchecked($("#QOS_up").val())){
                $("#QOS_up").focus();
                return false;
            }
            if(!set_QOSchecked($("#QOS_down").val())){
                $("#QOS_down").focus();
                return false;
            }
		}
	}
	showanimation(1);
    $.ajax({
		type:"post",
		url:"/goform/set_smartqos_cfg",
		data:$("#moreQos_form").serialize(),
		dataType:"json",
		success:function(msg){
			if(msg.result==0){
                showanimation(5);
			}else{
                showanimation(3);
			}
		},
		error:function(msg){
            showanimation(3);
		}
    })
}
function get_moreQOS_info(){
    // var msg={"type":"getsmartqosinfo","status":"1","qtype":"1","uload":"8.90","dload":"10.10"};
    $.ajax({
		type:"get",
		url:"/goform/get_smartqos_info",
		data:{"type":"getsmartqosinfo"},
		dataType:"json",
		success:function(msg){
			if((typeof msg)=='object'){
				var data=msg;
			}else{
				var data=eval('('+msg+')');
			}
			if(data.status==1){
				$("#moreQOS_on").prop("checked",true);
				$("#more_qtype").val(data.qtype);
				$("#QOS_up").val(data.uload);
				$("#QOS_down").val(data.dload);
                moreQOS_status(1);
			}else{
                $("#moreQOS_off").prop("checked",true);
                moreQOS_status(0);
			}
		},
		error:function(msg){

		}
	})
}

//检查静态IP
function value_check_static()
{
	var IP=CheckIPaddress($("#login_ip").val());
	if(!IP){$("#login_ip").focus();return false;}
	var ip = clearZERO($("#login_ip").val());
	if(ip==0){
		$("#login_ip").val("");
	}else{
		$("#login_ip").val(ip);
	}

	var MASK=CheckMask($("#login_ip").val(),$("#login_msk").val());
	if(!MASK){$("#login_msk").focus();return false;}
	var mask=clearZERO($("#login_msk").val());
	if(mask==0){
		$("#login_msk").val("");
	}else{
		$("#login_msk").val(mask);
	}

	var GW=CheckGateway($("#login_gateway").val());
	if(!GW){$("#login_gateway").focus();return false;};
	var gw= clearZERO($("#login_gateway").val());
	if(gw==0){
		$("#login_gateway").val("");
	}else{
		$("#login_gateway").val(gw);
	}

	var DNS1=CheckDNS($("#login_dns1").val());
	if(!DNS1){$("#login_dns1").focus();return false;}
	var dns1= clearZERO($("#login_dns1").val());
	if(dns1==0){
		$("#login_dns1").val("");
	}else{
		$("#login_dns1").val(dns1);
	}

	var DNS2=CheckDNS($("#login_dns2").val());
	if(!DNS2){$("#login_dns2").focus();return false;}
	var dns2= clearZERO($("#login_dns2").val());
	if(dns2==0){
		$("#login_dns2").val("");
	}else{
		$("#login_dns2").val(dns2);
	}

	return true;
}
//检查lan
function check_value_lan()
{
	var IP=CheckIPaddress($("#lanip").val());
	if(!IP){$("#login_ip").focus();return false;}
	var ip=clearZERO($("#lanip").val());
	if(ip==0){
		$("#lanip").val("");
	}else{
		$("#lanip").val(ip);
	}
	var MASK=CheckMask($("#lanip").val(),$("#lanmsk").val());
	if(!MASK){$("#lanmsk").focus();return false;}
	var mask= clearZERO($("#lanmsk").val());
	if(mask==0){
		$("#lanmsk").val("");
	}else{
		$("#lanmsk").val(mask);
	}

	var startIP=CheckIPaddress($("#startip").val());
	if(!startIP){$("#startip").focus();return false;}
	var startip=clearZERO($("#startip").val());
	if(startip==0){
		$("#startip").val("");
	}else{
		$("#startip").val(startip);
	}

	var EndIP=CheckIPaddress($("#endip").val());
	if(!EndIP){$("#endip").focus();return false;}
	var endip=clearZERO($("#endip").val());
	if(endip==0){
		$("#endip").val("");
	}else{
		$("#endip").val(endip);
	}

	var Buff1=parseInt($("#startip").val().split(".")[3]);
	var Buff2=parseInt($("#endip").val().split(".")[3]);
	var lanIpBuff3=parseInt($("#lanip").val().split(".")[3]);
    var Buff3=parseInt($("#lanip").val().split(".")[2]);
    var Buff4=parseInt($("#startip").val().split(".")[2]);
    var Buff5=parseInt($("#endip").val().split(".")[2]);
    if(!(Buff3==Buff5&&Buff4==Buff5)){
        layer.msg(curlang.IP_equal,{icon: 5});
        return false;
    }
    if(Buff1>=Buff2){
        layer.msg(curlang.IP_Scope,{icon: 5});
        return false;
    }
	var lanIpBuff3=parseInt($("#lanip").val().split(".")[3]);
	if(lanIpBuff3==Buff1||lanIpBuff3==Buff2){
		layer.msg(curlang.ip_equal_verify,{icon: 5});
        return false;
	}
	return true;
}
//设置lan信息
function onform_setlan(){
	set_restore=1;
	if($("#radio1").prop("checked")){
		if(!check_value_lan()){
			return;
		}
	}
	if($("#radio2").prop("checked")){
        var IP=CheckIPaddress($("#lanip").val());
        if(!IP){$("#login_ip").focus();return false;}
        var ip=clearZERO($("#lanip").val());
        if(ip==0){
            $("#lanip").val("");
        }else{
            $("#lanip").val(ip);
        }
        var MASK=CheckMask($("#lanip").val(),$("#lanmsk").val());
        if(!MASK){$("#lanmsk").focus();return false;}
        var mask= clearZERO($("#lanmsk").val());
        if(mask==0){
            $("#lanmsk").val("");
        }else{
            $("#lanmsk").val(mask);
        }
	}
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_Lanset',
		data: $("#form5").serialize(),
		dataType:"json",
		success: function(data) {

			//showMessig(data,0);
			//sleep(0);
			showanimation(2,data,0);
		},
		error:function(data)
		{
			showanimation(3,data,0);
		}
		})
	setTimeout(function () {set_restore=0;},8000);
}
//请求lan信息
	function getData_port_info(){
	$.ajax({
	type:"get",
	url:"/goform/getLanInfo",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
		if(data.landhcp=="on"){
			$("#radio1").trigger("click");
		}else{
			$("#radio2").trigger("click");
		}
	$("#lanip").val(data.lanip);
	$("#lanip").focus();
	$("#mac").val(data.mac);
	$("#lanIP").html(data.lanip);//	本机IP
	$("#startip").val(data.startip);
	$("#startip").focus();
	$("#endip").val(data.endip);
	$("#endip").focus();
	$("#lanmsk").val(data.lanmsk);
	$("#lanmsk").focus();
	},
	error: function(msg){
	}
	})}
//请求APP_lan信息
function getData_port_Minfo(){
	$.ajax({
		type:"get",
		url:"/goform/getLanInfo",
		dataType:"json",
		success: function(msg){
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}
			if(data.landhcp=="on"){
				$("#radio1").trigger("click");
			}else{
				$("#radio2").trigger("click");
			}
			$("#lanip").val(data.lanip);
			//$("#lanip").focus();
			$("#mac").val(data.mac);
			//$("#lanIP").html(data.lanip);//	本机IP
			$("#startip").val(data.startip);
			//$("#startip").focus();
			$("#endip").val(data.endip);
			//$("#endip").focus();
			$("#lanmsk").val(data.lanmsk);
			//$("#lanmsk").focus();
		},
		error: function(msg){
		}
	})}

//pppoe
//pppoeserver
	function pppoeser_writch(num) {
		if(num==1){
            $("#pppoe_form .inpt").prop("disabled",false);
            $("#pppoesauth").prop("disabled",false);
            $(".pppoe_checkbox").prop("disabled",false);
            $("#pppoesauth").removeClass("selection-disabled");
            $("#pppoe_form .inpt").removeClass("inpt-disabled");
            $("#pppoe_form .inpt").focus();
		}else{
            $("#pppoe_form .inpt").prop("disabled",true);
            $("#pppoesauth").prop("disabled",true);
            $(".pppoe_checkbox").prop("disabled",true);
            $("#pppoesauth").addClass("selection-disabled");
            $("#pppoe_form .inpt").addClass("inpt-disabled");
		}
    }
	$("#pppoeRadio1").click(function(){
        pppoeser_writch(1);
	});
	$("#pppoeRadio2").click(function(){
        pppoeser_writch(0);
	});
	function get_pppoeserver(){
		$.ajax({
            type:"get",
            url:"/goform/get_pppoe_server",
            data:{"type":"getpppoeserver"},
            dataType:"json",
            success: function(msg){
                if((typeof msg)=="object"){var data=msg;}
                else{ var data=eval('('+msg+')');}
				$("#pppoeAddres").val(data.saddr);
				$("#pppoeName").val(data.sname);
				$("#startAddres").val(data.startip);
				$("#endAddres").val(data.endip);
				if(data.sauth==1){
                    $("#sauth_type").css("display","block");
                    $(".pppoe_checkbox").prop("disabled",false);
				}else{
                    $("#sauth_type").css("display","none");
                    $(".pppoe_checkbox").prop("disabled",true);
				}
        		$("#pppoesauth").val(data.sauth);
				if(data.spap==1){
                    $("#spap").prop("checked",true);
				}else{
                    $("#spap").prop("checked",false);
				}
				if(data.pswitch==1){
					$("#pppoeRadio1").prop("checked",true);
					pppoeser_writch(1);
				}else{
					$("#pppoeRadio2").prop("checked",true);
					pppoeser_writch(0);
                    $("#pppoe_form .inpt").siblings("label").css("display","none");
				}
        		$("#spap").val(data.spap);
				if(data.schap==1){
					$("#schap").prop("checked",true);
				}else{
					$("#schap").prop("checked",false);
				}
				$("#schap").val(data.schap);
				if(data.smschap==1){
					$("#sms_chap").prop("checked",true);
				}else{
					$("#sms_chap").prop("checked",false);
				}
				$("#sms_chap").val(data.smschap);
				if(data.smschapv2==1){
					$("#sms_chapv2").prop("checked",true);
				}else{
					$("#sms_chapv2").prop("checked",false);
				}
				$("#sms_chapv2").val(data.smschapv2);
				$("#ldpcktime").val(data.ldpcktime);
				$("#ldpcount").val(data.ldpcount);
				$("#pppoe_form .inpt").focus();
			},
			error:function(msg){}
        })
	}
	//pppoeserver验证
	function pppoecycle(cycletime){
		var cycle=/^[0-9]{0,5}$/;
		if(cycletime==""){
            layer.msg(curlang.Enter_NULL, {icon: 5});
            return false;
        }
        if(cycletime>65535||cycletime<0){
            layer.msg(curlangs.scope_error, {icon: 5});
            return false;
        }
		if(!(cycle.test(cycletime))){
            layer.msg(curlangs.address_error, {icon: 5});
            return false;
		}
		return true;
	}
	function Checkpppoeaddress(IP_val){
		var temp,i;
		var ip = new Array();
		var reg = /[^0-9]/;
		if(IP_val==""){
			layer.msg(curlangs.ser_null, {icon: 5});
			return false;
		}//IP为空
		if(CheckChinese(IP_val)){
			layer.msg(curlangs.ser_Illicit, {icon: 5});
			return false;
		}//IP有中文字符
		if(IP_val.length < 7 || IP_val.length > 15){
			layer.msg(curlangs.ser_error, {icon: 5});
			return false;
		}
		ip=IP_val.split(".");
		if(ip.length != 4){
			layer.msg(curlangs.ser_error, {icon: 5});
			return false;
		}
		if(parseInt(ip[0])==0 || parseInt(ip[0])==224 || parseInt(ip[0]) ==225 || parseInt(ip[3])==0 || parseInt(ip[3])==255 || (parseInt(ip[0])==127 && parseInt(ip[3])==127)){
			layer.msg(curlangs.ser_Illicit, {icon: 5});
			return false;
		}
		for(i=0;i<4;i++){
			if(reg.test(ip[i]) || ip[i] == "" || ip[i].length > 3 || parseInt(ip[i])> 255){
				layer.msg(curlangs.ser_Illicit, {icon: 5});
				return false;
			}
		}
		return true;
	}
	$("#pppoeAddres").change(function(){
		var string=$("#pppoeAddres").val().split(".");
		if(string.length>3){
			var end=string[3];
			string.pop();
			if(end<100){
				var buf=string[0]+'.'+string[1]+'.'+string[2]+".";
				$("#startAddres").val(buf+"5");
				$("#startAddres").focus();
				$("#endAddres").val(buf+"254");
				$("#endAddres").focus();
			}
			else {
				var buf=string[0]+'.'+string[1]+'.'+string[2]+".";
				$("#startAddres").val(buf+"2");
				$("#startAddres").focus();
				$("#endAddres").val(buf+"249");
				$("#endAddres").focus();}
		}
	})
	function pppoecheck(){
		var serAdd=$("#pppoeAddres").val();
		var startAdd=$("#startAddres").val();
		var endAdd=$("#endAddres").val();
		var ldpcktime=$("#ldpcktime").val();
		var ldpcount=$("#ldpcount").val();
		if(!Checkpppoeaddress(serAdd)){$("#pppoeAddres").focus();return false;}
		if(!Checkpppoeaddress(startAdd)){$("#startAddres").focus();return false;}
		if(!Checkpppoeaddress(endAdd)){$("#endAddres").focus();return false;}
		if(!pppoecycle(ldpcktime)){$("#ldpcktime").focus();return false;}
		if(!pppoecycle(ldpcount)){$("#ldpcount").focus();return false;}
        var Buff1=parseInt(startAdd.split(".")[3]);
        var Buff2=parseInt(endAdd.split(".")[3]);
        var Buff3=parseInt(startAdd.split(".")[2]);
        var Buff4=parseInt(endAdd.split(".")[2]);
        var Buff5=parseInt(serAdd.split(".")[2]);
        if(!(Buff3==Buff5&&Buff4==Buff5)){
            layer.msg(curlang.IP_equal,{icon: 5});
            return false;
        }
        if(Buff1>Buff2){
            layer.msg(curlang.IP_Scope,{icon: 5});
            return false;
        }
		return true;
	}
	function onform_pppoeserver(){
        var data;
        var spap=$("#spap").val();
        var schap=$("#schap").val();
        var sms_chap=$("#sms_chap").val();
        var sms_chapv2=$("#sms_chapv2").val();
		if($("#pppoeRadio1").prop("checked")){
			data={"type":"setpppoeserver","pppoeRadio":$("#pppoeRadio1").val(),"pppoeAdres":$("#pppoeAddres").val(),"pppoeName":$("#pppoeName").val(),"startAddres":$("#startAddres").val(),"endAddres":$("#endAddres").val(),"pppoesauth":$("#pppoesauth").val(),"ldpcktime":$("#ldpcktime").val(),"ldpcount":$("#ldpcount").val(),"spap":$("#spap").val(),"schap":$("#schap").val(),"sms_chap":$("#sms_chap").val(),"sms_chapv2":$("#sms_chapv2").val()};
			if(!pppoecheck()){
            	return;
			}
			if($("#pppoesauth").val()==1){
                if(spap==0&&schap==0&&sms_chap==0&&sms_chapv2==0){
                    layer.msg(curlangs.sauth_null,{icon:5});
                    return;
                }
			}

		}else{
            data={"type":"setpppoeserver","pppoeRadio":$("#pppoeRadio2").val(),"pppoeAdres":$("#pppoeAddres").val(),"pppoeName":$("#pppoeName").val(),"startAddres":$("#startAddres").val(),"endAddres":$("#endAddres").val(),"pppoesauth":$("#pppoesauth").val(),"ldpcktime":$("#ldpcktime").val(),"ldpcount":$("#ldpcount").val(),"spap":$("#spap").val(),"schap":$("#schap").val(),"sms_chap":$("#sms_chap").val(),"sms_chapv2":$("#sms_chapv2").val()};
		}
        if((typeof data)=="object"){var msg=data;}
        else{var msg=eval("("+data+")")}
        showanimation(6);
		$.ajax({
			type:"post",
			url:"/goform/set_pppoe_server",
			data:msg,
			dataType:"json",
			success:function(msg){
				if(msg.result==0){
                    showanimation(2,msg,0);
				}else{
                    showanimation(3,msg,0);
				}
			},
			error:function (msg) {
                showanimation(3,"0",0);
            }
		})
	}
//pppoe用户添加
function pppoeaddcheck(){
	var pppoe_pwd=$("#serverpwd").val();
	var pppoe_user=$("#userAddres").val();
	if(!pppoeaddset(pppoe_user)){
        $("#userAddres").focus();
		return false;
	}
	if(!pppoeaddset(pppoe_pwd)){
        $("#serverpwd").focus();
        return false;
    }
    function pppoeaddset(ser_val) {
		var addset=/^[0-9a-zA-Z]*$/;
        if(ser_val==""){
            layer.msg(curlang.Enter_NULL, {icon: 5});
            return false;
        }
        if(!(addset.test(ser_val))){
            layer.msg(curlangs.pppoe_Error, {icon: 5});
            return false;
        }
        return true;
    }
	return true;
}
function onform_adduser(){
	if(!pppoeaddcheck()){
		return;
	}
	if($("#user_buf div").length==10){
		layer.msg(curlangs.user_number,{icon:5});
		return;
	}
	for(var j=0;j<$("#user_buf div").length;j++){
        if($("#userAddres").val()==$("#user_buf div").eq(j).children("span").eq(1).html()){
            layer.msg(curlangs.user_exist,{icon:5});
            return;
        }
	}
    showanimation(6);
    $.ajax({
        type:"post",
        url:"/goform/set_pppoe_account",
        data:$("#form_account").serialize(),
        dataType:"json",
        success:function (msg) {
            if(msg.result==0){
                showanimation(2,msg,0);
                getpppoe_user();
            }else{
                showanimation(3,msg,0);
			}
		},
		error:function(msg){showanimation(3,"0",0);}
    })
}
//用户列表
function getpppoe_user(){
    $.ajax({
		type:"get",
		url:"/goform/get_pppoe_account",
		data:{"type":"getpppoeaccount"},
		dataType:"json",
		success:function (msg) {
			if(msg==""||msg==null||msg==undefined) {
                return;
            }
			if((typeof msg)=="object"){var data=msg;}
			else{var data=eval("("+msg+")");}
			var dataList=data.list;
			var userbuf="";
			if(!(dataList==""||dataList==null||dataList==undefined)){
                for(var i=0;i<dataList.length;i++){
                    userbuf+='<div><span class="user_span user-bor" style="width: 10%">'+(i+1)+'</span><span class="user_span user-bor" style="width:39%;">'+dataList[i].user+'</span><span class="user_span user-bor" style="width: 39%;">'+dataList[i].password+'</span><span class="user_span user-bor1" onclick="setpppouser(this)">'+curlang.Remove+'</span></div>';
                }
			}
			$("#user_buf").html(userbuf);
		},
		error:function(msg){}
	})
}
function setpppouser(obj){
	var uName=$(obj).siblings("span").eq(1).html();
	var upwd=$(obj).siblings("span").eq(2).html();
    showanimation(6);
    $.ajax({
        type:"post",
        url:"/goform/set_del_account",
        data:{"userAddres":uName,"serverpwd":upwd},
        dataType:"json",
        success:function (msg) {
            if(msg.result==0){
                showanimation(2,msg,0);
                $(obj).parent("div").remove();
                getpppoe_user();
            }else{
                showanimation(3,msg,0);
            }
        },
        error:function(msg){showanimation(3,"0",0);}
    })
}
//pppoe统计

function get_pppoeclient(){
   // var msg={"type":"getpppoeclient","onlist":[{"mac":"C8:3A:35:17:4F:03","user":"ppp0","ip":"192.168.166.5","up":"0","down":"1234","online":"1","endtime":"2017-07-27 09:49:00"},{"mac":"C8:3A:35:17:4F:03","user":"ppp0","ip":"192.168.166.5","up":"0","down":"1234","online":"1","endtime":"2017-07-27 09:49:00"},{},{},{},{},{}],"oflist":[{"mac":"C8:3A:35:17:4F:03","user":"ppp0","ip":"192.168.166.5","up":"0","down":"1234","online":"0","endtime":"2017-07-27 09:49:00"},{"mac":"C8:3A:35:17:4F:03","user":"ppp0","ip":"192.168.166.5","up":"0","down":"1234","online":"1","endtime":"2017-07-27 09:49:00"},{},{},{},{}]};
	$.ajax({
		type:"get",
		url:"/goform/get_pppoe_client_info",
		data:{"type":"getpppoeclient"},
		dataType:"json",
		success:function(msg){
            if(msg==""||msg==null||msg==undefined) {
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{var data=eval("("+msg+")");}
            var onlist=data.onlist;
            var oflist=data.oflist;
            var onlistBuf="";
            var oflistBuf="";
            var clientup=[];
            var clientdown=[];
            var endtime;
			if(onlist==""||onlist==null||onlist==undefined){$("#p_onlist").html("");}else{
				for(var i=0;i<onlist.length;i++){
                    var up=parseInt(onlist[i].up);
                    var down=parseInt(onlist[i].down);
                    if(up<1024){
                        clientup=up+"B/s";
                    }else{
                        up=(up/1024.0).toFixed(1);
                        if(up>1024){
                            clientup=(up/1024.0).toFixed(1)+"MB/s";
                        }else{clientup=up+"KB/s";}
                    }
                    if(down<1024){
                        clientdown=down+"B/s";;
                    }else{
                        down=(down/1024.0).toFixed(1);
                        if(down>1024){
                            clientdown=(down/1024.0).toFixed(1)+"MB/s";
                        }else{clientdown=down+"KB/s";}
                    }
                    if(onlist[i].endtime==0){
                    	endtime=curlangs.not_limited;
					}else{
                    	endtime=onlist[i].endtime;
					}
                    onlistBuf+= '<div class="total-div"><span class="user_span user-bor2" style="width:5%">'+(i+1)+'</span>'+
								'<span class="user_span user-bor2" style="width:18%">'+onlist[i].user+'</span>'+
								'<span class="user_span user-bor2 bg_up" style="width:12%;line-height:10px;text-align:left;"><p><span>'+clientup+'</span></p><p class="bg_down"><span>'+clientdown+'</span></p></span>'+
								'<span class="user_span user-bor2" style="width:20%;line-height:10px;padding-top:8px;"><p>'+onlist[i].ip+'</p><p>'+onlist[i].mac+'</p></span>'+
								'<span class="user_span user-bor2" style="width:19%;"><input type="text" style="display:none;" class="p_inpt"  value="'+endtime+'"><span>'+endtime+'</span></span>'+
                        		'<span class="user_span user-bor2" style="width:11%">'+curlangs.online+'</span>'+
								'<span class="user_span user-bor2" style="width:15%;border-right:1px solid #ccc;"><span class="p_setshow" data-id="0">'+curlang.host_edit+'</span><span class="del_pterm" data-id="0" style="margin-left:10px;">'+curlang.Remove+'</span></span></div>';
				}
				$("#p_onlist").html(onlistBuf);
			}
			if(oflist==""||oflist==null||oflist==undefined){$("#p_offlist").html("");}else{
				for(var i=0;i<oflist.length;i++){
                    var up=parseInt(oflist[i].up);
                    var down=parseInt(oflist[i].down);
                    if(up<1024){
                        clientup=up+"B/s";
                    }else{
                        up=(up/1024.0).toFixed(1);
                        if(up>1024){
                            clientup=(up/1024.0).toFixed(1)+"MB/s";
                        }else{clientup=up+"KB/s";}
                    }
                    if(down<1024){
                        clientdown=down+"B/s";;
                    }else{
                        down=(down/1024.0).toFixed(1);
                        if(down>1024){
                            clientdown=(down/1024.0).toFixed(1)+"MB/s";
                        }else{clientdown=down+"KB/s";}
                    }
                    if(oflist[i].endtime==0){
                    	endtime=curlangs.not_limited;
					}else{
                    	endtime=oflist[i].endtime;
					}
                    oflistBuf+= '<div class="total-div"><span class="user_span user-bor2" style="width:5%">'+(i+onlist.length+1)+'</span>'+
								'<span class="user_span user-bor2" style="width:18%">'+oflist[i].user+'</span>'+
								'<span class="user_span user-bor2 bg_up" style="width:12%;line-height:10px;text-align:left;"><p><span>'+clientup+'</span></p><p class="bg_down"><span>'+clientdown+'</span></p></span>'+
								'<span class="user_span user-bor2" style="width:20%;line-height:10px;padding-top:8px;"><p>'+oflist[i].ip+'</p><p>'+oflist[i].mac+'</p></span>'+
								'<span class="user_span user-bor2" style="width:19%;"><input type="text" style="display:none;" class="p_inpt"  value="'+endtime+'"><span>'+endtime+'</span></span>'+
                        		'<span class="user_span user-bor2" style="width:11%">'+curlangs.offline+'</span>'+
								'<span class="user_span user-bor2" style="width:15%;border-right:1px solid #ccc;"><span class="p_setshow" data-id="0">'+curlang.host_edit+'</span><span class="del_pterm" data-id="0" style="margin-left: 10px;">'+curlang.Remove+'</span></span></div>';
				}
				$("#p_offlist").html(oflistBuf);
			}
			$(".p_setshow").click(function () {
				if($(this).attr("data-id")=="1"){
					onform_pppoeclient(this);
				}else{
					$(this).html(curlang.apply);
					$(this).parent().siblings(".user-bor2").eq(4).find("span").hide();
					$(this).parent().siblings(".user-bor2").eq(4).find("input").css("display","inline-block");
					$(this).parent().siblings(".user-bor2").eq(4).find("input").focus();
					$(this).attr("data-id","1");
				}
    		});
			$(".del_pterm").click(function(){
                del_pterminal(this);
			})
            currentPage(1,5)
		},
		error:function(msg){}
	})
}
function currentPage(pno,psize){
    var num = $("#p_offlist div").length+$("#p_onlist div").length;//表格所有行数(所有记录数)
    var totalPage = 0;//总页数
    var pageSize = psize;//每页显示行数
    //总共分几页
    if(num/pageSize > parseInt(num/pageSize)){
        totalPage=parseInt(num/pageSize)+1;
    }else{
        totalPage=parseInt(num/pageSize);
    }
    var currentPage = pno;//当前页数
    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
    var endRow = currentPage * pageSize;//结束显示的行   40
    endRow = (endRow > num)? num : endRow;    //40
    //遍历显示数据实现分页
    for(var i=1;i<(num+1);i++){
        var irow =  $(".total-div")[i-1];
        if(i>=startRow && i<=endRow){
            irow.style.display = "block";
        }else{
            irow.style.display = "none";
        }
    }
    var tempStr = '<span>'+curlangs.total+num+curlangs.recording+'</span><span>'+curlangs.total+totalPage+curlangs.pages+'</span><span>'+curlangs.current+currentPage+curlangs.pages+'</span>';
    if(currentPage>1){
        tempStr += '<a href="#" onClick="currentPage('+(1)+','+psize+')">'+curlangs.home+'</a>';
        tempStr += '<a href="#" onClick="currentPage('+(currentPage-1)+','+psize+')">'+curlangs.previous+'</a>';
    }else{
        tempStr += '<span>'+curlangs.home+'</span>';
        tempStr += '<span>'+curlangs.previous+'</span>';
    }
    if(currentPage<totalPage){
        tempStr += '<a href="#" onClick="currentPage('+(currentPage+1)+','+psize+')">'+curlangs.next+'</a>';
        tempStr += '<a href="#" onClick="currentPage('+(totalPage)+','+psize+')">'+curlangs.last+'</a>';
    }else{
        tempStr += '<span>'+curlangs.next+'</span>';
        tempStr += '<span>'+curlangs.last+'</span>';
    }

    $("#barcon").html(tempStr);
}
function del_pterminal(obj){
    var mac=$(obj).parent().siblings(".user-bor2").eq(3).find("p").eq(1).html();
	set_restore = 1;
    $.ajax({
        type:"post",
        url:"/goform/set_del_pppoe_client",
        data:{"type":"setdelpppoeclient","mac":mac},
        dataType:"json",
        success:function(msg){
        	if(msg.result==0){
        		showanimation(6);
                $(obj).parent().parent().remove();
                get_pppoeclient();
				set_restore = 0;
			}else{
        		showanimation(6);
        		showanimation(3);
			}
        },
		error:function(msg){
            showanimation(6);
            showanimation(3);
        },
    })
}
function onform_pppoeclient(obj){
    var mac=$(obj).parent().siblings(".user-bor2").eq(3).find("p").eq(1).html();
    var endtime=$(obj).parent().siblings(".user-bor2").eq(4).find("input").val();
    var reg=/^\d{4}[-]([0][1-9]|(1[0-2]))[-](([0][1-9]|[12]\d)|(3[01]))([ \t\n\x0B\f\r])(([0-1]{1}[0-9]{1})|([2]{1}[0-3]{1}))([:])(([0-5]{1}[0-9]{1}))([:])(([0-5]{1}[0-9]{1}))$/;
    if(endtime==""){
        endtime=0;
	}else{
        if(!(reg.test(endtime))){
            layer.msg(curlangs.Expire_tips,{icon:5});
            return;
        }
    }
	$.ajax({
		type:"post",
		url:"/goform/set_pppoe_client_info",
		data:{"mac":mac,"endtime":endtime},
		dataType:"json",
		success:function(msg){
			if(msg.result==0){
				showanimation(6);
                $(obj).attr("data-id","0");
                $(obj).html(curlang.host_edit);
                $(obj).parent().siblings(".user-bor2").eq(5).find("span").css("display","inline-block");
                $(obj).parent().siblings(".user-bor2").eq(5).find("input").hide();
                if(endtime==0){
                    endtime=curlangs.not_limited;
                }
                $(obj).parent().siblings(".user-bor2").eq(5).find("span").html(endtime);
			}else{
				showanimation(6);
				showanimation(3);
			}
		},
		error:function(msg){
            showanimation(6);
            showanimation(3);
		}
	})
}

//路由器重启
function onform_reboot()
{
	layer.closeAll();
	showanimation(1,'01',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_reboot',
	data: "mode=reboot",
	dataType:"json",
	success: function(msg) {
		showanimation(2,msg,0);
        set_restore=1;
		restart('reboot');
		//showMessig(msg,0);
	},
	error:function(msg)
	{
		showanimation(3,msg,0);
	}
})}
//设置wifi开关
function onform_setwifi_switch(){
	//sleep(1);
	//showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_wifi_switch',
	data: $("#WIFI_key").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
            showanimation(2,data,0);
	},
	error:function(data) {}
	})
 showanimation(6);
}
function onform_set5gwifi_switch(){
	//sleep(1);
	//showanimation(1,'01',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_5wifi_switch',
	data: $("#5gWIFI_key").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
            showanimation(2,data,0);
	},
	error:function(data) {}
	});
	showanimation(6);
}
//获取wifi状态
function getData_wifi_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_wifi_info",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	$("#soft_mode").val(data.wlanpswmode);
		if(data.wlanpswmode=="open"){
			$("#WifiKeyLabel").css("display","none");
		}else{
			$("#WifiKeyLabel").css("display","block");
		}
	$("#wifiTkip").val(data.wlanpswencry);
	$("#wifi_pass1").val(data.wlanpsw);
	$("#wifi_pass1").focusin();
	$("#wifi_ssid").val(data.wlanssid);
	$("#wifi_ssid").focusin();
	},
	error: function(msg){
	}
})}
function getData_5gwifi_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_5wifi_info",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	$("#5gsoft_mode").val(data.wlan5pswmode);
		if(data.wlan5pswmode=="open"){
			$("#5gWifiKeyLabel").css("display","none");
		}else{
			$("#5gWifiKeyLabel").css("display","block");
		}
	$("#5gwifiTkip").val(data.wlan5pswencry);
	$("#5gwifi_pass1").val(data.wlan5psw);
	$("#5gwifi_pass1").focusin();
	$("#5gwifi_ssid").val(data.wlan5ssid);
	$("#5gwifi_ssid").focusin();
	},
	error: function(msg){
	}
})}
//设置无线
function onform_set_wifi(){
	$("#wifi_ssid").val($.trim($("#wifi_ssid").val()));
	$("#wifi_pass1").val($.trim($("#wifi_pass1").val()));
	var SSID=CheckSSID($.trim($("#wifi_ssid").val()));

	if(!SSID){$("#wifi_ssid").focus();return false;}
	if($("#soft_mode").val()!="open"){
		var PASS=CheckSSIDKey($.trim($("#wifi_pass1").val()));

		if(!PASS){$("#wifi_pass1").focus();return false;}
	}
		//showanimation(1,'0',0);
		$.ajax({
			type: 'post',
			url: '/goform/set_wifi',
			data: $("#form2").serialize(),
			dataType:"json",
			success: function(data){
				 //showMessig(data,0);
				 //sleep(0);
                    showanimation(2,data,0);

			},
			error:function(data) {}
			});
		showanimation(6);
}
function onform_set_5gwifi(){
	$("#5gwifi_ssid").val($.trim($("#5gwifi_ssid").val()));
	$("#5gwifi_pass1").val($.trim($("#5gwifi_pass1").val()));
	var SSID=CheckSSID($.trim($("#5gwifi_ssid").val()));

	if(!SSID){$("#5gwifi_ssid").focus();return false;}
	if($("#5gsoft_mode").val()!='open'){
		var PASS=CheckSSIDKey($.trim($("#5gwifi_pass1").val()));

		if(!PASS){$("#5gwifi_pass1").focus();return;}
	}
		//sleep(1);
		//showanimation(1,'0',0);
		$.ajax({
			type: 'post',
			url: '/goform/set_5wifi',
			data: $("#5gform2").serialize(),
			dataType:"json",
			success: function(data){
				 //showMessig(data,0);
                    showanimation(2,data,0);
				 //sleep(0);
			},
			error:function(data) {}
			}) ;
		showanimation(6);
}
//获取无线开关
function wifiswitch_2g(sum) {
    if(sum==0){
        $("#wlan_buuton").unbind("click");
    }else{
        $("#wlan_buuton").click(function(){
            onform_set_wifi();
            timeControl(1);
            //layer.closeAll();
        })
    }
}
function wifiswitch_5g(sum) {
    if(sum==0){
        $("#5gwlan_button").unbind("click");
    }else{
        $("#5gwlan_button").click(function(){
            onform_set_5gwifi();
            timeControl(1);
            //layer.closeAll();
        })
    }
}
function getData_wifi_switch(){
    wifiswitch_2g(0);
	$.ajax({
	type:"get",
	url:"/goform/get_wifi_switch",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(data.radioon == 1)
	{
			$("#wifi_2gssidStatus").prop("checked",true);
			$("#wifi_2gssidStatus").attr("disabled",false);
			$("#slidOne").val("1");
			$("#switchOn").css("display","inline-block");
			$("#switchOff").css("display","none");
			inputSet(1);
			getFloatSSID();
        	wifiswitch_2g(1);

	}
		else {
			$("#wifi_2gssidStatus").prop("checked",false);
			$("#wifi_2gssidStatus").attr("disabled",true);
			$("#slidOne").val("0");
			$("#switchOff").css("display","inline-block");
			$("#switchOn").css("display","none");
			inputSet(0);
        	wifiswitch_2g(0);

		}
	},
	error: function(msg){
	}
	})
}
function getData_5gwifi_switch(){
    wifiswitch_5g(0);
	$.ajax({
	type:"get",
	url:"/goform/get_5wifi_switch",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(data.radioon == 1)
	{
			$("#wifi_5gssidStatus").prop("checked",true);
			$("#wifi_5gssidStatus").attr("disabled",false);
			$("#5gslidOne").val("1");
			$("#5gswitchOn").css("display","inline-block");
			$("#5gswitchOff").css("display","none");
			input5Set(1);
			getDoubleSSID();
        	wifiswitch_5g(1);
	}
		else {
			$("#wifi_5gssidStatus").prop("checked",false);
			$("#wifi_5gssidStatus").attr("disabled",true);
			$("#5gslidOne").val("0");
			$("#5gswitchOff").css("display","inline-block");
			$("#5gswitchOn").css("display","none");
			input5Set(0);
        	wifiswitch_5g(0);
		}
	},
	error: function(msg){
	}
	})
}
//wifi 定时关闭
function WtimingSwitch(num){
    if(num==1){
        $(".edit_divW input").attr("disabled",false);
        $(".edit_divW input").removeClass("inpt-disabled");
    }else{
        $(".edit_divW input").attr("disabled",true);
        $(".edit_divW input").addClass("inpt-disabled");
    }
}
function WTimingOff_info(){
    $.ajax({
        type:"get",
        url:"/goform/get_wifi_limit_info",
        dataType:"json",
        success: function(msg){
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
            var h1,m1,h2,m2;;
            var info=data.wifilimit0.split('-');
            h1=info[0].split(":");
            m1=info[1].split(":");
            $("#Wstart_h1").val(h1[0]);
            $("#Wstart_m1").val(h1[1]);
            $("#Wend_h1").val(m1[0]);
            $("#Wend_m1").val(m1[1]);
            var info1=data.wifilimit1.split('-');
            h2=info1[0].split(":");
            m2=info1[1].split(":");
            $("#Wstart_h2").val(h2[0]);
            $("#Wstart_m2").val(h2[1]);
            $("#Wend_h2").val(m2[0]);
            $("#Wend_m2").val(m2[1]);
            if(data.wifilimitsw == 1){
                $("#Wtiming_on").prop("checked",true);
                WtimingSwitch(1);
            }else{
                $("#Wtiming_off").prop("checked",true);
                WtimingSwitch(0);
            }
        },
        error: function(msg){
        }
    })
}
function onformWTimingOff(starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2){
    var data;
    if($("#Wtiming_on").prop("checked")){
        if(!timingChenk(starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2)) {
            return;
        }
        if(starth2==""&&startm2==""&&endh2==""&&endm2==""){
            starth2="00";
            startm2="00";
            endh2="00";
            endm2="00";
        }
        if(starth1.length<2&&starth1<10){
            starth1=0+starth1;
        }
        if(startm1.length<2&&startm1<10){
            startm1=0+startm1;
        }
        if(endh1.length<2&&endh1<10){
            endh1=0+endh1;
        }
        if(endm1.length<2&&endm1<10){
            endm1=0+endm1;
        }
        if(starth2.length<2&&starth2<10){
            starth2=0+starth2;
        }
        if(startm2.length<2&&startm2<10){
            startm2=0+startm2;
        }
        if(endh2.length<2&&endh2<10){
            endh2=0+endh2;
        }
        if(endm2.length<2&&endm2<10){
            endm2=0+endm2;
        }
        data={"type":"setwifilimitinfo","wifilimitsw":"1","wifilimit0":starth1+':'+startm1+'-'+endh1+':'+endm1,"wifilimit1":starth2+':'+startm2+'-'+endh2+':'+endm2}
    }else{
        data={"type":"setwifilimitinfo","wifilimitsw":"0"}
    }
    showanimation(1);
    $.ajax({
        type:"post",
        url:"/goform/set_wifi_limit_info",
        dataType:"json",
        data:data,
        success: function(msg){
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
            if(data.result == 0){
                showanimation(5);
            }else{
                showanimation(3);
            }
        },
        error: function(msg){
            showanimation(3);
        }
    })
}
//设置pppoe
function onform_setwan_pppoe(){
	var Admin=$.trim($("#login_admin").val());
	var Pass=$.trim($("#login_pass").val());
	$("#login_admin").val(Admin);
	$("#login_pass").val(Pass);
	var ADMIN=CheckPPPOELogin(Admin);

	if(!ADMIN){$("#login_admin").focus();return false;}
	var PASS=CheckPPPOEPass(Pass);

	if(!PASS){$("#login_pass").focus();return false;}

	var PPPOEMTU=CheckMTU($("#pppoe_mtu").val());
	if(!PPPOEMTU){return false;}
	var PPPOEMTU=parseInt($("#pppoe_mtu").val());
	$("#pppoe_mtu").val(PPPOEMTU);
		//sleep(1);
		showanimation(1,'01',0);
		$.ajax({
			type: 'post',
			url: '/goform/set_WanEasy',
			data: $("#form1").serialize(),
			dataType:"json",
			success: function(data){
				//showMessig(data,0);
				//sleep(0);
				showanimation(2,data,0);
			},
			error:function(data)
			{
				showanimation(3,'o',0);
			}
		})
}
//设置DHCP
function onform_setwan_dhcp(){
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_WanEasy',
	data: $("#form3").serialize(),
	dataType:"json",
	success: function(data){
        //showMessig(data,0);
		showanimation(2,data,0);
		//sleep(0);
    },
	error:function(data)
	{
		showanimation(3,'0',0);
	}
})
}
//设置静态
function onform_setwan_static(){
	if(!value_check_static()){
		return;
	}
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_WanEasy',
		data: $("#form4").serialize(),
		dataType:"json",
		success: function(data){
			//showMessig(data,0);
			//sleep(0);
			showanimation(2,data,0);
		},
		error:function(data)
		{
			showanimation(3,'0',0);
		}
		})
}
//获取wan信息
function getData_get_wanset_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_wanset_info",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}

	if(data.wanmode == "pppoe")
	{
		$("#pppoe_title").trigger("click");
		$("#login_admin").val(data.pppoename);
		$("#login_admin").focus();
		$("#login_pass").val(data.pppoepsw);
		$("#login_pass").focus();
		$("#login_server").focus();
		$("#login_server").val(data.server_name);
		$("#pppoe_mtu").val(data.mtu);
		$("#pppoe_mtu").focus();
	}
	else if(data.wanmode == "dhcp")
	{
		$("#pppoe_mtu").val(data.mtu);
		$("#dhcp_title").trigger("click");
	}
	else{
		$("#internet_type").trigger("click");
		$("#login_ip").val(data.wanip);
		$("#login_ip").focus();
		$("#login_msk").val(data.wanmsk);
		$("#login_msk").focus();
		$("#login_gateway").val(data.wangw);
		$("#login_gateway").focus();
		$("#login_dns1").val(data.dns1);
		$("#login_dns1").focus();
		$("#login_dns2").val(data.dns2);
		$("#login_dns2").focus();
		$("#pppoe_mtu").val(data.mtu);
	}
	},
	error: function(msg){
	}
})}
function getData_get_wanset_Minfo(){
	$.ajax({
		type:"get",
		url:"/goform/get_wanset_info",
		dataType:"json",
		success: function(msg){
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}

			if(data.wanmode == "pppoe")
			{
				$("#pppoe_title").trigger("click");
				$("#login_admin").val(data.pppoename);
				// $("#login_admin").focus();
				$("#login_pass").val(data.pppoepsw);
				// $("#login_pass").focus();
				// $("#login_server").focus();
				$("#login_server").val(data.server_name);
				$("#pppoe_mtu").val(data.mtu);
				// $("#pppoe_mtu").focus();
			}
			else if(data.wanmode == "dhcp")
			{
				$("#pppoe_mtu").val(data.mtu);
				$("#dhcp_title").trigger("click");
			}
			else{
				$("#internet_type").trigger("click");
				$("#login_ip").val(data.wanip);
				$("#login_ip").focus();
				$("#login_msk").val(data.wanmsk);
				$("#login_msk").focus();
				$("#login_gateway").val(data.wangw);
				$("#login_gateway").focus();
				$("#login_dns1").val(data.dns1);
				$("#login_dns1").focus();
				$("#login_dns2").val(data.dns2);
				$("#login_dns2").focus();
				$("#pppoe_mtu").val(data.mtu);
			}
		},
		error: function(msg){
		}
	})}
//获取wan口info
	//wan pppoe设置
	var wanpppoe=true;
	$("#wanPppoe_set").click(function(){
		if(wanpppoe){
			$(".wanPppoe").show();
			$(".glyphicon-menu-down").hide();
			$(".glyphicon-menu-up").css("display","inline-block");
			wanpppoe=false;
		}else{
			$(".wanPppoe").hide();
			$(".glyphicon-menu-down").css("display","inline-block");
			$(".glyphicon-menu-up").hide();
			wanpppoe=true;
		}
	});
function getData_wan_info(){
	$.ajax({
	type:"get",
	url:"/goform/getWanInfo",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');};
	$("#wan_mac1").html(data.wan_mac);
	if((data.connetype).toLowerCase()=='static'){
		$("#wan_connettype1").html(curlang.wanstatic);
	}else if((data.connetype).toLowerCase()=='dhcp'){
		$("#wan_connettype1").html(curlang.wandhcp);
	}else if((data.connetype).toLowerCase()=='pppoe'){
        $("#wan_connettype1").html(curlang.wanpppoe);
	}else{
        $("#wan_connettype1").html(data.connetype);
	}
	$("#wan_ip1").html(data.ip);
	$("#wan_mask1").html(data.wanmsk);
	$("#wan_gateway1").html(data.gateway);
	$("#wan_dns1").html(data.dns1);
	$("#wanIP").html(data.wanip);  //外网IP
	},
	error: function(msg){
	}
})
}
function getData_wificonnet(){
	var status=false;
	$.ajax({
	type: 'get',
	url: '/goform/get_connetsta_cfg',
	data:{"type":"setrepeaterinfo"},
	dataType:"json",
	success: function(data){
		if(data==null||data==""){
			return;
		}else{
			if((typeof data)=="object"){var msg=data;}
			else{var msg=eval('('+data+')'); }
			if(msg.ssid=="NONE" || msg.mac=="NONE"){
				status=false;
			}else{
				status=true;
			}

		}
	},
	error:function(data){}
	})
	return status;
}
//获取主页面信息
function getData_routerinfo(){
	$.ajax({
	type:"get",
	url:"/goform/get_router_info",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	var up=parseInt(data.upspeed);
	var down=parseInt(data.downspeed);
	if(up<1024){
		$("#upSpeed").html(up+"B/s");}
	else {
		up=(up/1024.0).toFixed(1);
		if(up>1024){
			up=(up/1024.0).toFixed(1)
			$("#upSpeed").html(up+"MB/s");
			}
		else{$("#upSpeed").html(up+"KB/s");}
	}

	if(down<1024){$("#downSpeed").html(down+"B/s");}
	else{
		down=(down/1024.0).toFixed(1);
		if(down>1024){
			down=(down/1024.0).toFixed(1);
			$("#downSpeed").html(down+"MB/s");}
		else{$("#downSpeed").html(down+"KB/s");}
	}
	if(data.operationmode=="bridge"){
		$(".netStatus_div").css("display","none");
		$("#wanImg").unbind();
		$("#wanImg").click(function(){
			layer.msg(curlangs.closeFuntona);
		})
		$("#internet").unbind();
		$("#internet").click(function(){
			layer.msg(curlangs.closeFuntona);
		})
		//$("ul.dItem li").eq(5).hide();
	}
	else if(data.operationmode=="repeater"){
		$("#wanImg").unbind();
		$("#wanImg").click(function(){
			layer.msg(curlangs.closeFuntona);
		})
		$("#internet").unbind();
		$("#internet").click(function(){
			layer.msg(curlangs.closeFuntona);
		})
		//$("ul.dItem li").eq(5).hide();
	}
	$("#version").html((data.ver).split(',')[1]);
	$("#version_num").html((data.ver).split(',')[1]);
	var buf=(data.ver).split('-')[4];
	if(data.operationmode == "client"){
        $("#wanImg").unbind();
        $("#wanImg").click(function(){
            layer.msg(curlangs.closeFuntona);
        })
        $("#internet").unbind();
        $("#internet").click(function(){
            layer.msg(curlangs.closeFuntona);
        })
        //$("ul.dItem li").eq(5).hide();
	if(buf=="D"){
		$("#wifi_tab").css("display","block");
		$("#wifi_2G").css("display","none");
		$("#5gwlan").css("display","block");
		$("#2gwlan").css("display","none");
		IsDouble=true;
	}else{
		$("#wifi_tab").css("display","none");
		$("#wifi").css("display","none");
		$(".show_wifi").css("display","block");
		IsDouble=false;
	}}
		if(buf=="D"){
			$("#wifi_tab").css("display","block");

			IsDouble=true;
		}else{
			$("#wifi_tab").css("display","none");

			IsDouble=false;
		}
	if(data.smart==1){
		$("#divQRCode").css("display","block");
		if(data.server_type==2) {
            $("#QRCode").attr('src', "/admin/images/forign.png");
        }else{
			$("#QRCode").attr('src',"/admin/images/router.png");}
		$("#QR_official").css("display","none");
        $("#QR_app").css("display","block");
	}else{
		$("#divQRCode").css("display","block");
		if(getLang()=='zhcn'){
			$("#QRCode").attr('src',"/admin/images/webzhcn.png");
		}else{
			$("#QRCode").attr('src',"/admin/images/weben.png");
		}
		$("#QR_app").css("display","none");
        $("#QR_official").css("display","block");
	}
	$("#playTime").html(data.uptime);
	$("#Mac").html(data.lanmac);
	var remain=data.ramfree.replace('KByte','');
	var total=data.ramtotal.replace('KByte','');
	if(remain>1024){remain=(remain/1024.0).toFixed(2)+"MB";}
	else{remain=remain+"KB";}
	if(total>1024){total=(total/1024.0).toFixed(2)+"MB";}
	else{total=total+"KB";}
	$("#remainMemory").html(total);
	$("#totalMemory").html(remain);
	$("#cpu").html(data.cpu);
	$("#lanIP").html(data.lanip);
	var num=parseInt(data.basicstat).toString(2);
	if(num.length-7<0){
	var str="";
	for(var i=0;i<(7-num.length);i++){
	str+="0";
	}
	num =str+num;
	}
	if(num.charAt(6)=="0")
	{$("#wanImg").attr("src","/admin/images/wan-imgok.png");}
	else{$("#wanImg").attr("src","/admin/images/wan-img.png"); }
	if(num.charAt(5) == 1){$("#lan1").attr("src","/admin/images/wan-img.png");}else{ $("#lan1").attr("src","/admin/images/wan-imgok.png");};
	if(num.charAt(4) == 1){ $("#lan2").attr("src","/admin/images/wan-img.png");}else{ $("#lan2").attr("src","/admin/images/wan-imgok.png");};
	if(num.charAt(3)== 1){ $("#lan3").attr("src","/admin/images/wan-img.png");}else{ $("#lan3").attr("src","/admin/images/wan-imgok.png");};
	if(num.charAt(2) == 1){ $("#lan4").attr("src","/admin/images/wan-img.png");}else{ $("#lan4").attr("src","/admin/images/wan-imgok.png");};
	if(num.charAt(0) == 0){
	$("#linkStus").attr("src","/admin/images/linkOff.png");
	$("#lineStus").attr("src","/admin/images/wanOff2.png");
	}else{
	$("#linkStus").attr("src","/admin/images/linkOn.png");
	$("#lineStus").attr("src","/admin/images/wanOK2.png");
	loginFlag();
	};
	if(num.charAt(1) == 0)
	{
		$("#wifi").attr("src","/admin/images/wifiOff.png");
	}
	else
	{
		$("#wifi").attr("src","/admin/images/wifiOn.gif");
	}
		//getData_wan_info(data);
		if(data.operationmode == "router")
	{
        if((data.connetype).toLowerCase()=='static'){
            $("#linkType").html(curlang.wanstatic);
        }else if((data.connetype).toLowerCase()=='dhcp'){
            $("#linkType").html(curlang.wandhcp);
        }else if((data.connetype).toLowerCase()=='pppoe'){
            $("#linkType").html(curlang.wanpppoe);
        }else{
            $("#linkType").html(data.connetype);
		}
		if($("#linkStus").attr("src")=="/admin/images/linkOn.png"){
            $(".netDiagnosis").hide();
		}else{
            $(".netDiagnosis").show();
		}
		showter=true;
	}
	else if(data.operationmode == "WISP"){
		$("#linkType").html(curlangs.WISPmodea);
		showter=true;
	}
	if(data.link == 0){
	$("#netStatus").html(curlang.ulink);
	}else{
	$("#netStatus").html(curlang.linked);
	}
	},
	error: function(msg){
	}
	})
}
//网络诊断
function nd_load_info(type,num){
    var arr=["nd-load","nd-suc","nd-err"];
    $(".nd-right").eq(type).html("").removeClass("nd-load nd-suc nd-err").addClass(arr[num]);
    $(".nd-right").eq(type+1).html("").addClass(arr[0]);
}
var cleartime;
function get_diagnosis_info(){
	set_restore=1;
    $(".nd-right").eq(0).addClass("nd-load");
    $(".nd-load").html("");
	$.ajax({
		type:"get",
		url:"/goform/get_networkdiagnosis_info",
		dataType:"json",
		success:function(msg){
			set_restore=0;
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
            if(data.wanstatus==1){
                cleartime=setTimeout(function(){
                    nd_load_info(0,1);
					if(data.wanmodeequal==1){
                        cleartime=setTimeout(function(){
                            nd_load_info(1,1);
                            if(data.ipstatus==1){
                                cleartime=setTimeout(function() {
                                    nd_load_info(2,1);
                                    if(data.dnstatus==1){
                                        cleartime=setTimeout(function() {
                                            nd_load_info(3,1);
                                            if(data.netstatus==1){
                                                cleartime=setTimeout(function() {
                                                	$(".nd-right").eq(4).removeClass("nd-load").addClass("nd-suc");
                                                    $(".nd-right").eq(4).html("");
                                                },3000);
                                            }else{
                                                $(".nd-right").eq(1).removeClass("nd-load").addClass("nd-err");
                                                cleartime=setTimeout(function(){
                                                    $("#nd_wanhost").parent().css("display","inline-block");
                                                    $("#nd_apply").show();
                                                },3000);
                                                return;
                                            }
                                        },3000)
                                    }else{
                                        $(".nd-right").eq(1).removeClass("nd-load").addClass("nd-err");
                                        cleartime=setTimeout(function(){
                                            $("#nd_dns").parent().css("display","inline-block");
                                            $("#nd_apply").show();
                                        },3000);
                                        return;
                                    }
                                },3000)
                            }else{
                                cleartime=setTimeout(function(){
                                    $(".nd-right").eq(2).removeClass("nd-load").addClass("nd-err");
									setTimeout(function(){
										$("#nd_wanIP").parent().css("display","inline-block");
                                        $("#nd_apply").show();
									},2000);
                                },2000);
                                return;
                            }
						},3000);
					}else{
                        cleartime=setTimeout(function(){
                            $(".nd-right").eq(1).removeClass("nd-load").addClass("nd-err");
							setTimeout(function(){
								if(data.wanmodeequal==2){
									$("#nd_pppoe").parent().css("display","inline-block");
								}else if(data.wanmodeequal==3){
									$("#nd_dhcp").parent().css("display","inline-block");
								}else{
									$("#nd_static").parent().css("display","inline-block");
								}
                                $("#nd_apply").show();
							},2000);
						},2000);
                        return;
					}
                },3000);
			}else{
                cleartime=setTimeout(function(){
            		$(".nd-right").eq(0).removeClass("nd-load").addClass("nd-err");
						setTimeout(function(){
							$("#nd_wan").parent().css("display","inline-block");
							$("#nd_apply").show();
						},2000);
            		},2000);
                return;
			}
		}
	})
}
//获取版本信息
function compVer(str2,str1){
	var local_ver = str1.split(".");
	var ser_ver = str2.split(".");
	if(parseInt(local_ver[0]) < parseInt(ser_ver[0])){
		return true;
	}
	else if(parseInt(local_ver[0]) > parseInt(ser_ver[0])){
		return false;
	}
	else{
		if(parseInt(local_ver[1]) < parseInt(ser_ver[1])){
			return true;
		}
		else if(parseInt(local_ver[1]) > parseInt(ser_ver[1])){
			return false;
		}
		else{
			if(parseInt(local_ver[2].split("_")[0]) < parseInt(ser_ver[2].split("_")[0])){
				return true;
			}
			else if(parseInt(local_ver[2].split("_")[0]) > parseInt(ser_ver[2].split("_")[0])){
				return false;
			}
			else{
				return false;
			}
		}
	}
	return false;
}
function getData_version_info(){
	$("#upgrade_button").css("display","none");
	$.ajax({
	type:"get",
	url:"/goform/get_version_info",
	data:{"type":"getfirmver"},
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(data.result==4){
		layer.msg(curlang.sysError);
		return false;
	}else if(data.result==5){
        layer.msg(curlang.sysModel);
        return false;
	}else if(data.result==1){
        layer.msg(curlang.sysinfo);
        return false;
	}
	var lastV=data.lastver;
	var currV=data.curver;
	$("#newver").html(lastV);
	$("#curver").html(currV);
	if(compVer(lastV,currV))
	{
		$("#upgrade_button").css("display","inline-block");
		$("#upgrade_button").attr("disabled",false);
		$("#upgrade_button").css("cursor","pointer");
		if(getLang()=='zhcn'){
			$("#version_tips").html(data.content_zh);
		}else{
			$("#version_tips").html(data.content_en);
		}
		if(window.Isfirst){
			layer.open({
				type: 1,
				title: false,
				shade: [0.7, '#000'],
                area:'500px',
				closeBtn: false,
				content: $("#setupgrade"),
				offset:'150px',
				skin: 'cy-class'
			});
			window.Isfirst=false;
		}
	}
	else{
	$("#upgrade_button").css("display","none");
	}
	},
	error: function(msg){
	}
	})
}
function getstatus(){
	$.ajax({
	type:"get",
	url:"/goform/get_version_info",
	data:{"type":"getstatus"},
	dataType:"json",
	success: function(msg){
		if(msg.status=="download"){
            $("#msg").html(curlang.upgrade_down);
		}
		if(msg.status=="upgrade"){
            $("#msg").html(curlang.upgrade_ug);
		}
	},
	error: function(msg){
		$("#msg").html(curlang.upgrade_reboot);
	}
	})
}
//升级请求
	function onform_upgrade_versoin(){
	set_restore=1;
	TimeFlag=false;
    limit_D=false;
	showanimation(1);
	$.ajax({
	type: 'post',
	url: '/goform/upgrade_version',
	data: {'type':'upgrade'},
	dataType:"json",
	success: function(data) {
		if(data.result==0){
            setInterval(getstatus,3000);
            lb_restart('update');
		}else{
            showanimation(3);
		}
	},
	error:function(data)
	{
        showanimation(3);
        //restart('update');
	}
	})
}
//管理密码设置请求
function onform_setmanpsd(){
	var pw=$.trim($("#userpwd").val());
	var newpass=$.trim($("#userpwd2").val());
	var NewPass=ManagePasswords(newpass);
	$("#userpwd2").focus();
	if(!NewPass){return;}
	if(curpasswd!=pw){
		layer.msg(curlang.passError, {icon: 5});
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_manpwd',
	data: {'type':'setmanpwd','routepwd':newpass},
	dataType:"json",
	success: function(data) {
	//showMessig(data,0);
	//sleep(0);
	showanimation(2,data,0);
	window.location='../login.asp';
	},
	error:function(data)
	{
		showanimation(3,'0',0);
	}
	})
}
//获取原管理密码
function getData_manpsd(){
	$.ajax({
	type:"get",
	url:"/goform/get_manpwd_info",
	dataType:"json",
	success: function(msg){
	if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	curpasswd=data.routepwd;
	},
	error: function(msg){
	}
})}
//终端类型
function get_clientNum(){
    // var msg={"type":"getlimitclient","cable":"8","_2g":"10","_5g":"3"};
    $.ajax({
        type:"get",
        url:"/goform/get_ClientNum_cfg",
        dataType:"json",
        success: function(msg){
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
            var calbe=data.cable;
            var _2g=data._2g;
            var _5g=data._5g;
            var num;
            if(calbe==undefined){
				$("#device_pc").parent().hide();
                num=(parseInt(_2g)+parseInt(_5g))+curlang.tai;
			}
			if(_2g==undefined){
				$("#device_2g").parent().hide();
                num=(parseInt(calbe)+parseInt(_5g))+curlang.tai;
			}
			if(_5g==undefined){
				$("#device_5g").parent().hide();
                num=(parseInt(_2g)+parseInt(calbe))+curlang.tai;
			}
    		if(calbe!=undefined&&_2g!=undefined&&_5g!=undefined){
                num=(parseInt(_2g)+parseInt(_5g)+parseInt(calbe))+curlang.tai;
			}
            $("#deviceum span").html(num);
    		$("#device_pc_num").html(calbe+curlang.tai);
    		$("#device_2g_num").html(_2g+curlang.tai);
    		$("#device_5g_num").html(_5g+curlang.tai);
        },
        error: function(msg){
        }
    })
}
//获取限时终端列表
function get_limitTerm() {
    // var msg={"type":"getlimitclient","list":[{"mac":"00:11:22:33:44:55","time1":"10:00-00:00","time2":"20:00-00:00","name":"tgdfgfd"},{"mac":"00:11:22:33:44:55","time1":"10:00-00:00","time2":"20:00-00:00","name":"yyyyyyyyyy"}]};
    $.ajax({
        type:"get",
        url:"/goform/get_LimitClient_cfg",
        data:{"type":"getlimitlist"},
        dataType:"json",
        success:function (msg) {
			if ((typeof msg) == "object") {var data = msg;}
			else {var data = eval('(' + msg +')');}
			var len,time_buff="";
			len=data.list.length;
            $("#edit_time").hide();
            $("#termModal").show();
			for(var i=0;i<len;i++){
				time_buff+='<div><span class="term_span" style="width: 5%;border-left:1px solid #ccc;">'+(i+1)+'</span>'+
					'<span class="term_span" style="width: 26%">'+data.list[i].name+'</span>'+
				'<span class="term_span" style="width: 19%">'+data.list[i].mac+'</span>'+
				'<span class="term_span" style="width: 16%">'+data.list[i].time1+'</span>'+
				'<span class="term_span" style="width: 16%">'+data.list[i].time2+'</span>'+
				'<span class="term_span" style="width: 18%"><span class="term_edit" style="margin-right:10px;">'+curlang.host_edit+'</span><span class="term_del">'+curlang.Remove+'</span></span></div>';
			}
			$("#termT_list").html(time_buff);
            $(".term_edit").click(function() {
				$("#edit_time").show();
				$("#termModal").hide();
                var h1,m1;
                var info=$(this).parent().siblings().eq(3).html().split('-');
                h1=info[0].split(":");
                m1=info[1].split(":");
                $("#start_hour1").val(h1[0]);
                $("#start_min1").val(h1[1]);
                $("#end_hour1").val(m1[0]);
                $("#end_min1").val(m1[1]);
                var h2,m2;
                var Emac=$(this).parent().siblings().eq(2).html();
                var info1=$(this).parent().siblings().eq(4).html().split('-');
                if(info1==""){}else{
                    h2=info1[0].split(":");
                    m2=info1[1].split(":");
                    $("#start_hour2").val(h2[0]);
                    $("#start_min2").val(h2[1]);
                    $("#end_hour2").val(m2[0]);
                    $("#end_min2").val(m2[1]);
				}
                $("#set_Edittime").unbind("click");
                $("#set_Edittime").click(function(){
                    if(info1==""){
                        var starth1="00";
                        var endh1="00";
                        var startm1="00";
                        var endm1="00";
                        var starth2="00";
                        var endh2="00";
                        var startm2="00";
                        var endm2="00";
                    }else{
						var starth1=$("#start_hour1").val();
						var endh1=$("#end_hour1").val();
						var startm1=$("#start_min1").val();
						var endm1=$("#end_min1").val();
						var starth2=$("#start_hour2").val();
						var endh2=$("#end_hour2").val();
						var startm2=$("#start_min2").val();
						var endm2=$("#end_min2").val();
                    }
                    set_limitTerm(Emac,starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2,'pc');
                })
            })
            $(".term_del").click(function () {
                var mac=$(this).parent().siblings().eq(2).html();
                del_limitTerm(this,mac);
            })
            $(".cancel_edit").click(function () {
                $("#edit_time").hide();
                $("#termModal").show();
            });
    	},
    	error: function (msg) {
    	}
    });
}
//手机获取限时终端列表
function Mget_limitTerm() {
    // var msg={"type":"getlimitclient","list":[{"mac":"00:11:22:33:44:55","time1":"10:00-00:00","time2":"20:00-00:00","name":"tgdfgfd"},{"mac":"00:11:22:33:44:55","time1":"10:00-00:00","time2":"20:00-00:00","name":"yyyyyyyyyy"}]};
    $.ajax({
        type:"get",
        url:"/goform/get_LimitClient_cfg",
        data:{"type":"getlimitlist"},
        dataType:"json",
        success:function (msg) {
			if ((typeof msg) == "object") {var data = msg;}
			else {var data = eval('(' + msg +')');}
			$(".time_terminal").css("display","block");
			$("#edit_time").css("display","none");
			var len,time_buff="";
			len=data.list.length;
			for(var i=0;i<len;i++){
				time_buff+='<div><span class="term_span" style="width: 10%;border-left:1px solid #ccc;">'+(i+1)+'</span>'+
                    '<span class="term_span" style="width: 43%;line-height: 19px"><p>'+data.list[i].name+'</p><p>'+data.list[i].mac+'</p></span>'+
                    '<span class="term_span" style="width: 29%;line-height: 19px"><p>'+data.list[i].time1+'</p><p>'+data.list[i].time2+'</p></span>'+
					'<span class="term_span" style="width: 18%"><span class="term_edit"><i class="icon iconfont">&#xe616;</i></span><span class="term_del">+</span></span></div>';
			}
			$("#termT_list").html(time_buff);
            $(".term_edit").click(function() {
                $(".time_terminal").css("display","none");
                $("#edit_time").show();
                $(".appCallback").css("display", "none");
                $(".contentCallback").css("display", "block");
                var h1,m1;
                var info=$(this).parent().siblings().eq(2).find("p").eq(0).html().split('-');
                h1=info[0].split(":");
                m1=info[1].split(":");
                $("#Mstart_hour1").val(h1[0]);
                $("#Mstart_min1").val(h1[1]);
                $("#Mend_hour1").val(m1[0]);
                $("#Mend_min1").val(m1[1]);
                var h2,m2;
                var Emac=$(this).parent().siblings().eq(1).find("p").eq(1).html();
                var info1 = $(this).parent().siblings().eq(2).find("p").eq(1).html().split('-');
                if(info1==""){}else {
                    h2 = info1[0].split(":");
                    m2 = info1[1].split(":");
                    $("#Mstart_hour2").val(h2[0]);
                    $("#Mstart_min2").val(h2[1]);
                    $("#Mend_hour2").val(m2[0]);
                    $("#Mend_min2").val(m2[1]);
                }
                $("#set_Edittime").unbind("click");
				$("#set_Edittime").click(function(){
                    if(info1==""){
                        var starth1="00";
                        var endh1="00";
                        var startm1="00";
                        var endm1="00";
                        var starth2="00";
                        var endh2="00";
                        var startm2="00";
                        var endm2="00";
                    }else {
						var starth1 = $("#Mstart_hour1").val();
						var endh1 = $("#Mend_hour1").val();
						var startm1 = $("#Mstart_min1").val();
						var endm1 = $("#Mend_min1").val();
						var starth2 = $("#Mstart_hour2").val();
						var endh2 = $("#Mend_hour2").val();
						var startm2 = $("#Mstart_min2").val();
						var endm2 = $("#Mend_min2").val();
                    }
                    set_limitTerm(Emac,starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2,'mobile');
                })
            })
            $(".term_del").click(function () {
                var mac=$(this).parent().siblings().eq(1).find("p").eq(1).html();
                Mdel_limitTerm(this,mac);
            })
    	},
    	error: function (msg) {
    	}
    });
}
//添加限时终端列表
function add_limitTerm(mac) {
    // var msg={"type":"getlimitclient","mac":mac,"time1":"10:00-00:00","time2":"20:00-00:00"};
    $.ajax({
        type:"get",
        url:"/goform/get_LimitClient_cfg",
        data:{"type":"getlimitclient","mac":mac},
        dataType:"json",
        success:function (msg) {
            if ((typeof msg) == "object") {var data = msg;}
            else {var data = eval('(' + msg +')');}
                var h1,m1;
            if(msg.time1==""){
                $("#start_hour1").val("");
                $("#start_min1").val("");
                $("#end_hour1").val("");
                $("#end_min1").val("");
			}else{
                var info=msg.time1.split('-');
				h1=info[0].split(":");
				m1=info[1].split(":");
				$("#start_hour1").val(h1[0]);
				$("#start_min1").val(h1[1]);
				$("#end_hour1").val(m1[0]);
				$("#end_min1").val(m1[1]);
            }
                var h2,m2;
            if(msg.time2==""){
                $("#start_hour2").val("");
                $("#start_min2").val("");
                $("#end_hour2").val("");
                $("#end_min2").val("");
			}else {
                var info1 = msg.time2.split('-');
                h2 = info1[0].split(":");
                m2 = info1[1].split(":");
                $("#start_hour2").val(h2[0]);
                $("#start_min2").val(h2[1]);
                $("#end_hour2").val(m2[0]);
                $("#end_min2").val(m2[1]);
            }
        },
        error: function (msg) {
        }
    });
}

//删除
function del_limitTerm(obj,mac){
    showanimation(1);
    $.ajax({
        type:"post",
        url:"/goform/set_LimitClient_cfg",
        data:{"type":"setlimitclient","mac":mac,"time1":"00:00-00:00","time2":"00:00-00:00"},
        dataType:"json",
        success:function (msg) {
            if(msg.result==0){
                showanimation(2,msg,0);
                $(obj).parent().parent().remove();
                get_limitTerm();
            }else{
                showanimation(3);
            }
        },
        error: function (msg) {
            showanimation(3);
        }
    });
}
//手机删除
function Mdel_limitTerm(obj,mac){
    showanimation(1);
    $.ajax({
        type:"post",
        url:"/goform/set_LimitClient_cfg",
        data:{"type":"setlimitclient","mac":mac,"time1":"00:00-00:00","time2":"00:00-00:00"},
        dataType:"json",
        success:function (msg) {
            if(msg.result==0){
                showanimation(2,msg,0);
                $(obj).parent().parent().remove();
                Mget_limitTerm();
            }else{
                showanimation(3);
            }
        },
        error: function (msg) {
            showanimation(3);
        }
    });
}
//set_limitTerm时间判断
function checklimitTerm(sh1,sm1,eh1,em1){
	sh1=parseInt(sh1);
	eh1=parseInt(eh1);
    sm1=parseInt(sm1);
    em1=parseInt(em1);
    if(sh1>eh1||(sh1==eh1&&sm1>em1)){
        layer.msg(curlang.startend_time,{icon:5});
        return;
    }
    if(sh1==eh1&&sm1==em1&&sh1>0&&eh1>0){
        layer.msg(curlang.time_same,{icon:5});
        return;
    }
    return true;
}
function timingChenk(starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2) {
    if(!checkLEDhour(starth1)){
        $("#start_hour1").focus();
        $("#Wstart_h1").focus();
        return;
    }
    if(!checkLEDmin(startm1)){
        $("#start_min1").focus();
        $("#Wstart_m1").focus();
        return;
    }
    if(!checkLEDhour(endh1)){
        $("#end_hour1").focus();
        $("#Wend_h1").focus();
        return;
    }
    if(!checkLEDmin(endm1)){
        $("#end_min1").focus();
        $("#Wend_m1").focus();
        return;
    }
    if(starth2==""&&startm2==""&&endh2==""&&endm2==""){
        starth2="00";
        startm2="00";
        endh2="00";
        endm2="00";
    }else{
        if(!checkLEDhour(starth2)){
            $("#start_hour2").focus();
            $("#Wstart_h2").focus();
            return;
        }
        if(!checkLEDmin(startm2)){
            $("#start_min2").focus();
            $("#Wstart_m2").focus();
            return;
        }
        if(!checkLEDhour(endh2)){
            $("#end_hour2").focus();
            $("#Wend_h2").focus();
            return;
        }
        if(!checkLEDmin(endm2)){
            $("#end_min2").focus();
            $("#Wend_m2").focus();
            return;
        }
    }
    if(!checklimitTerm(starth1,startm1,endh1,endm1)){
        return;
    }
    if(!checklimitTerm(starth2,startm2,endh2,endm2)){
        return;
    }
    if(starth1.length<2&&starth1<10){
        starth1=0+starth1;
    }
    if(startm1.length<2&&startm1<10){
        startm1=0+startm1;
    }
    if(endh1.length<2&&endh1<10){
        endh1=0+endh1;
    }
    if(endm1.length<2&&endm1<10){
        endm1=0+endm1;
    }
    if(starth2.length<2&&starth2<10){
        starth2=0+starth2;
    }
    if(startm2.length<2&&startm2<10){
        startm2=0+startm2;
    }
    if(endh2.length<2&&endh2<10){
        endh2=0+endh2;
    }
    if(endm2.length<2&&endm2<10){
        endm2=0+endm2;
    }
    var st1=starth1+startm1;
    var et1=endh1+endm1;
    var st2=starth2+startm2;
    var et2=endh2+endm2;
    st1=parseInt(st1);et1=parseInt(et1);st2=parseInt(st2);et2=parseInt(et2);
    if((st2>st1&&st2<et1)||(et2>st1&&et2<et1)||(st2<st1&&et2>et1)||(st2==st1&&et2==et1&&st1>0&&st2>0&&et1>0&&et2>0)||(st2==st1&&et2>et1)||(st2<st1&&et2==et1)){
        layer.msg(curlang.overlap_time,{icon:5});
        return;
    }
    return true;
}
//提交
function set_limitTerm(mac,starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2,type){
    if(!timingChenk(starth1,endh1,startm1,endm1,starth2,endh2,startm2,endm2)){
        return;
	}
    if(starth2==""&&startm2==""&&endh2==""&&endm2==""){
        starth2="00";
        startm2="00";
        endh2="00";
        endm2="00";
    }
    if(starth1.length<2&&starth1<10){
        starth1=0+starth1;
    }
    if(startm1.length<2&&startm1<10){
        startm1=0+startm1;
    }
    if(endh1.length<2&&endh1<10){
        endh1=0+endh1;
    }
    if(endm1.length<2&&endm1<10){
        endm1=0+endm1;
    }
    if(starth2.length<2&&starth2<10){
        starth2=0+starth2;
    }
    if(startm2.length<2&&startm2<10){
        startm2=0+startm2;
    }
    if(endh2.length<2&&endh2<10){
        endh2=0+endh2;
    }
    if(endm2.length<2&&endm2<10){
        endm2=0+endm2;
    }
    showanimation(1);
    $.ajax({
        type:"post",
        url:"/goform/set_LimitClient_cfg",
        data:{"type":"setlimitclient","mac":mac,"time1":starth1+":"+startm1+"-"+endh1+":"+endm1,"time2":starth2+":"+startm2+"-"+endh2+":"+endm2},
        dataType:"json",
        success:function (msg) {
			if(msg.result==0){
				showanimation(5);
				if(type=='pc'){
					get_limitTerm();
				}else{
					Mget_limitTerm();
				}
			}
            if(msg.result==1){
                showanimation(3);
			}
            if(msg.result==2){
                showanimation(3);
            	layer.msg(curlang.limit_num,{icon:5})
			}
    	},
    	error: function (msg) {
            showanimation(3);
    	}
    });
}
//pc获取设备列表
function getData_terminal_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_terminallist_info",
	dataType:"json",
	success: function(msg){
	if(msg==null||msg==""||msg==undefined){
	 return;
	}
	if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(!msg.list){
		//layer.msg(curlang.sysinfo);
		return;
	}
	var i=data.list.length;
	var termlist=data.list;
	var buf="",buf2="",buf5="";
	var pos,up,down;
	for(var j=0;j<i;j++)
	{
        if(termlist[j].downspeed<1024){down=termlist[j].downspeed+"B/s";}
        else{
            if(termlist[j].downspeed>(1024*1024)){
                down=(termlist[j].downspeed/(1024*1024)).toFixed(1)+"MB/s";
            }else{
                down=(termlist[j].downspeed/1024).toFixed(1)+"KB/s";
            }
        }
        if(termlist[j].upspeed<1024){up=termlist[j].upspeed+"B/s";}
        else{
            if(termlist[j].upspeed>(1024*1024)){
                up=(termlist[j].upspeed/(1024*1024)).toFixed(1)+"MB/s";
            }else{
                up=(termlist[j].upspeed/1024).toFixed(1)+"KB/s";
            }
        }
        if(termlist[j].ostype=="Android"){
           pos="-38px";
        }
        else if(termlist[j].ostype=="iPhone"){
           pos="-74px";
        }
        else if(termlist[j].ostype=="PC"){
            pos="-1px";
        }
        else if(termlist[j].ostype=="TV"){
            pos="-112px";
        }
        else if(termlist[j].ostype=="Router"){
            pos="-149px";
        }
        else{
            pos="-186px";
        }
        if(termlist[j].link_type==0) {
            buf += '<div class="terminal-item">' +
                '<div class="device-img"><img src="images/devtype.png" style="left:' + pos + '"></div>' +
                '<div class="device-name">' +
                '<p>' + curlang.name + '<span class="dev-name">' + termlist[j].name + '</span></p>' +
                '<p class="p-margin">' + curlangs.online_Time + '<span class="dev-time">' + termlist[j].link_time + '</span></p>' +
                '</div>' +
                '<div class="device-ipmac">' +
                '<p>IP: <span class="device-ip">' + termlist[j].ip + '</span></p>' +
                '<p class="p-margin">MAC: <span class="device-mac">' + termlist[j].mac + '</span></p>' +
                '</div>' +
                '<div class="dev-speed">' +
                '<p class="p-up">' + up + '</p>' +
                '<p class="p-margin p-down">' + down + '</p>' +
                '</div>' +
                '<div class="manage">' + curlang.mangement + '   ></div>' +
                '<input type="hidden" id="sign" value="' + termlist[j].sign + '">' +
                '<input type="hidden" id="upfolw" value="' + termlist[j].totalup + '">' +
                '<input type="hidden" id="downfolw" value="' + termlist[j].totaldl + '">' +
                '</div>';
        }
        if(termlist[j].link_type==1){
            buf2+='<div class="terminal-item">'+
                '<div class="device-img"><img src="images/devtype.png" style="left:'+pos+'"></div>' +
                '<div class="device-name">' +
                '<p>'+curlang.name+'<span class="dev-name">'+termlist[j].name+'</span></p>' +
                '<p class="p-margin">'+curlangs.online_Time+'<span class="dev-time">'+termlist[j].link_time+'</span></p>' +
                '</div>' +
                '<div class="device-ipmac">'+
                '<p>IP: <span class="device-ip">'+termlist[j].ip+'</span></p>' +
                '<p class="p-margin">MAC: <span class="device-mac">'+termlist[j].mac+'</span></p>' +
                '</div>' +
                '<div class="dev-speed">' +
                '<p class="p-up">'+up+'</p>' +
                '<p class="p-margin p-down">'+down+'</p>' +
                '</div>' +
                '<div class="manage">'+curlang.mangement+'   ></div>' +
                '<input type="hidden" id="sign" value="'+termlist[j].sign+'">'+
                '<input type="hidden" id="upfolw" value="'+termlist[j].totalup+'">'+
                '<input type="hidden" id="downfolw" value="'+termlist[j].totaldl+'">'+
                '</div>';
        }
        if(termlist[j].link_type==2){
            buf5+='<div class="terminal-item">'+
                '<div class="device-img"><img src="images/devtype.png" style="left:'+pos+'"></div>' +
                '<div class="device-name">' +
                '<p>'+curlang.name+'<span class="dev-name">'+termlist[j].name+'</span></p>' +
                '<p class="p-margin">'+curlangs.online_Time+'<span class="dev-time">'+termlist[j].link_time+'</span></p>' +
                '</div>' +
                '<div class="device-ipmac">'+
                '<p>IP: <span class="device-ip">'+termlist[j].ip+'</span></p>' +
                '<p class="p-margin">MAC: <span class="device-mac">'+termlist[j].mac+'</span></p>' +
                '</div>' +
                '<div class="dev-speed">' +
                '<p class="p-up">'+up+'</p>' +
                '<p class="p-margin p-down">'+down+'</p>' +
                '</div>' +
                '<div class="manage">'+curlang.mangement+'   ></div>' +
                '<input type="hidden" id="sign" value="'+termlist[j].sign+'">'+
                '<input type="hidden" id="upfolw" value="'+termlist[j].totalup+'">'+
                '<input type="hidden" id="downfolw" value="'+termlist[j].totaldl+'">'+
                '</div>';
        }
	}
    $("#terminal_pc").html(buf);
    $("#terminal_2g").html(buf2);
    $("#terminal_5g").html(buf5);
    if($("#terminal_5g div").length==0){
        $("#terminal_5g").parent().hide();
	}else{
        $("#terminal_5g").parent().show();
	}
	if($("#terminal_2g div").length==0){
        $("#terminal_2g").parent().hide();
	}else{
        $("#terminal_2g").parent().show();
	}
	if($("#terminal_pc div").length==0){
        $("#terminal_pc").parent().hide();
	}else{
        $("#terminal_pc").parent().show();
	}
    $(".manage").click(function(){
            layer.open({
                type: 1,
                title: false,
                shade: [0.7, '#000'],
                closeBtn: false,
                area:'450px',
                offset:'150px',
                content: $("#set_device"),
                skin: 'cy-class'
            });
            limit_D=false;
        	focus_D=false;
            var devname=$(this).siblings(".device-name").find(".dev-name").html();
            var devmac=$(this).siblings(".device-ipmac").find(".device-mac").html();
            var devip=$(this).siblings(".device-ipmac").find(".device-ip").html();
            var devup=$(this).siblings("#upfolw").val();
            var devdown=$(this).siblings("#downfolw").val();
            var sign=$(this).siblings("#sign").val();
            add_limitTerm(devmac);
            if(devup<1024){devup=devup+"B";}
            else{
                if(devup>(1024*1024)){
                    devup=(devup/(1024*1024)).toFixed(1)+"MB";
                }else{
                    devup=(devup/1024).toFixed(1)+"KB";
                }
            }
            if(devdown<1024){devdown=devdown+"B";}
            else{
                if(devdown>(1024*1024)){
                    devdown=(devdown/(1024*1024)).toFixed(1)+"MB";
                }else{
                    devdown=(devdown/1024).toFixed(1)+"KB";
                }
            }
            $("#dev_name").val(devname);
            $("#span_alias").html(devname);
            $("#dev_mac").html(devmac);
            $("#dev_ip").html(devip);
            $("#dev_up").html(devup);
            $("#dev_down").html(devdown);
            $("#dev_name").hide();
            $("#span_alias").css("display","inline-block");
            alias_D=false;
            if((parseInt(sign).toString(2)&2)>>1){
                $("#lostarp").html(curlang.binded);
                $("#lostArp_apply").html(curlang.Unbind);
                $("#lostArp_apply").attr("data-id","0");
            }else{
                $("#lostarp").html(curlang.unbounded);
                $("#lostArp_apply").html(curlang.loststatic);
                $("#lostArp_apply").attr("data-id","1");
            }
            if(parseInt(sign).toString(2)&1){
                $(".dev-center").css("display","inline");
                $("#uplimit_span").hide();
                $("#upapply").css("display","inline-block");
                $("#upapply").html(curlang.limit_cancel);
                $("#limit_cm").hide();
                $("#upapply").attr("data-id","0");
                getQos(devmac);
            }else{
                $(".dev-center").hide();
                $("#limit_cm").hide();
                $("#uplimit_span").css("display","inline-block");
                $("#upapply").css("display","inline-block");
                $("#upapply").html(curlang.limit_speed);
                $("#upapply").attr("data-id","1");
                getQos(devmac);
            }
        });
		if(parseInt($(".terminal_list").css("height"))>470){
			$(".addon_container").css("height","471px");
			$(".addon_container").css("overflow-y","auto");
		}else{
			$(".addon_container").css("height","auto");
			$(".addon_container").css("overflow-y","hidden");
		}
	},
	error: function(msg){
	}
	})
}
//手机获取设备列表
function getM_terminal_info(){
	// var msg={"type":"getterminallist","list":[{"ip":"192.168.16.100","mac":"fc:aa:14:b3:42:78","upspeed":"0","link_time":"23:34","downspeed":"0","totalup":"11227189","totaldl":"98254817","up_total":"45345345","down_total":"5655345345","name":"PDPQV5D3CUSX7ZL","ostype":"unknown","sign":"2"},{"ip":"192.168.16.100","mac":"fc:aa:14:b3:42:78","upspeed":"0","downspeed":"0","up_total":"45345345","down_total":"5655345345","totalup":"11227189","link_time":"2:34","totaldl":"98254817","name":"PDPQV5D3CUSX7ZL","ostype":"iPhone","sign":"4"}]};
    $.ajax({
	type:"get",
	url:"/goform/get_terminallist_info",
	dataType:"json",
	success: function(msg){
        if(msg==null||msg==""||msg==undefined){
         return;
        }
        if((typeof msg)=="object"){var data=msg;}
        else{ var data=eval('('+msg+')');}
        if(!msg.list){
            //layer.msg(curlang.sysinfo);
            return;
        }
        var i=data.list.length;
        var termlist=data.list;
        var buf="",buf2="",buf5="";
        var pos,up,down;
        for(var j=0;j<i;j++)
        {
            if(termlist[j].downspeed<1024){down=termlist[j].downspeed+"B/s";}
            else{
                if(termlist[j].downspeed>(1024*1024)){
                    down=(termlist[j].downspeed/(1024*1024)).toFixed(1)+"MB/s";
                }else{
                    down=(termlist[j].downspeed/1024).toFixed(1)+"KB/s";
                }
            }
            if(termlist[j].upspeed<1024){up=termlist[j].upspeed+"B/s";}
            else{
                if(termlist[j].upspeed>(1024*1024)){
                    up=(termlist[j].upspeed/(1024*1024)).toFixed(1)+"MB/s";
                }else{
                    up=(termlist[j].upspeed/1024).toFixed(1)+"KB/s";
                }
            }
            if(termlist[j].ostype=="Android"){
               pos="-33px 0px";
            }
            else if(termlist[j].ostype=="iPhone"){
               pos="-65px 0px";
            }
            else if(termlist[j].ostype=="PC"){
                pos="0px 0px";
            }
            else if(termlist[j].ostype=="TV"){
                pos="-98px 0px";
            }
            else if(termlist[j].ostype=="Router"){
                pos="-130px 0px";
            }
            else{
                pos="-163px 0px";
            }
            if(termlist[j].link_type==0) {
                buf += '<div class="terminal-item">' +
                    '<div class="device-img" style="background-position:' + pos + '"></div>' +
                    '<div class="device-name">' +
                    '<p><span class="dev-name">' + termlist[j].name + '</span></p>' +
                    '<p class="p-margin">' + curlangs.online_Time + '<span class="dev-time">' + termlist[j].link_time + '</span></p>' +
                    '</div>' +
                    '<div class="dev-speed">' +
                    '<p class="p-up">' + up + '</p>' +
                    '<p class="p-margin p-down">' + down + '</p>' +
                    '</div>' +
                    '<span class="man-img"></span>' +
                    '<input type="hidden" id="sign" value="' + termlist[j].sign + '">' +
                    '<input type="hidden" id="upfolw" value="' + termlist[j].totalup + '">' +
                    '<input type="hidden" id="downfolw" value="' + termlist[j].totaldl + '">' +
                    '<input type="hidden" id="device_ip" value="' + termlist[j].ip + '">' +
                    '<input type="hidden" id="device_mac" value="' + termlist[j].mac + '">' +
                    '</div>';
            }
            if(termlist[j].link_type==1) {
                buf2 += '<div class="terminal-item">' +
                    '<div class="device-img" style="background-position:' + pos + '"></div>' +
                    '<div class="device-name">' +
                    '<p><span class="dev-name">' + termlist[j].name + '</span></p>' +
                    '<p class="p-margin">' + curlangs.online_Time + '<span class="dev-time">' + termlist[j].link_time + '</span></p>' +
                    '</div>' +
                    '<div class="dev-speed">' +
                    '<p class="p-up">' + up + '</p>' +
                    '<p class="p-margin p-down">' + down + '</p>' +
                    '</div>' +
                    '<span class="man-img"></span>' +
                    '<input type="hidden" id="sign" value="' + termlist[j].sign + '">' +
                    '<input type="hidden" id="upfolw" value="' + termlist[j].totalup + '">' +
                    '<input type="hidden" id="downfolw" value="' + termlist[j].totaldl + '">' +
                    '<input type="hidden" id="device_ip" value="' + termlist[j].ip + '">' +
                    '<input type="hidden" id="device_mac" value="' + termlist[j].mac + '">' +
                    '</div>';
            }
            if(termlist[j].link_type==2) {
                buf5 += '<div class="terminal-item">' +
                    '<div class="device-img" style="background-position:' + pos + '"></div>' +
                    '<div class="device-name">' +
                    '<p><span class="dev-name">' + termlist[j].name + '</span></p>' +
                    '<p class="p-margin">' + curlangs.online_Time + '<span class="dev-time">' + termlist[j].link_time + '</span></p>' +
                    '</div>' +
                    '<div class="dev-speed">' +
                    '<p class="p-up">' + up + '</p>' +
                    '<p class="p-margin p-down">' + down + '</p>' +
                    '</div>' +
                    '<span class="man-img"></span>' +
                    '<input type="hidden" id="sign" value="' + termlist[j].sign + '">' +
                    '<input type="hidden" id="upfolw" value="' + termlist[j].totalup + '">' +
                    '<input type="hidden" id="downfolw" value="' + termlist[j].totaldl + '">' +
                    '<input type="hidden" id="device_ip" value="' + termlist[j].ip + '">' +
                    '<input type="hidden" id="device_mac" value="' + termlist[j].mac + '">' +
                    '</div>';
            }
        }
        $("#terminal_pc").html(buf);
        $("#terminal_2g").html(buf2);
        $("#terminal_5g").html(buf5);
        if($("#terminal_5g div").length==0){
            $("#terminal_5g").parent().hide();
        }else{
            $("#terminal_5g").parent().show();
        }
        if($("#terminal_2g div").length==0){
            $("#terminal_2g").parent().hide();
        }else{
            $("#terminal_2g").parent().show();
        }
        if($("#terminal_pc div").length==0){
            $("#terminal_pc").parent().hide();
        }else{
            $("#terminal_pc").parent().show();
        }
        $(".terminal-item").click(function () {
            $(".terminal_list").css("display","none");
            $("#set_device").show();
            $(".appCallback").css("display", "none");
            $(".contentCallback").css("display", "block");
            limit_D=false;
            focus_D=false;
            var devname=$(this).find(".dev-name").html();
            var devmac=$(this).find("#device_mac").val();
            var devip=$(this).find("#device_ip").val();
            var devup=$(this).find("#upfolw").val();
            var devdown=$(this).find("#downfolw").val();
            var sign=$(this).find("#sign").val();
            add_limitTerm(devmac);
            if(devup<1024){devup=devup+"B";}
            else{
                if(devup>(1024*1024)){
                    devup=(devup/(1024*1024)).toFixed(1)+"MB";
                }else{
                    devup=(devup/1024).toFixed(1)+"KB";
                }
            }
            if(devdown<1024){devdown=devdown+"B";}
            else{
                if(devdown>(1024*1024)){
                    devdown=(devdown/(1024*1024)).toFixed(1)+"MB";
                }else{
                    devdown=(devdown/1024).toFixed(1)+"KB";
                }
            }
            $("#dev_name").val(devname);
            $("#span_alias").html(devname);
            $("#dev_mac").html(devmac);
            $("#dev_ip").html(devip);
            $("#dev_up").html(devup);
            $("#dev_down").html(devdown);
            $("#dev_name").hide();
            $("#span_alias").css("display","inline-block");
            alias_D=false;
            if((parseInt(sign).toString(2)&2)>>1){
                $("#lostarp").html(curlang.binded);
                $("#lostArp_apply").html(curlang.Unbind);
                $("#lostArp_apply").attr("data-id","0");
            }else{
            	$("#lostarp").html(curlang.unbounded);
                $("#lostArp_apply").html(curlang.loststatic);
                $("#lostArp_apply").attr("data-id","1");
            }
            if(parseInt(sign).toString(2)&1){
                $(".dev-center").css("display","block");
                $("#uplimit_span").hide();
                $("#upapply").css("display","inline-block");
                $("#upapply").html(curlang.limit_cancel);
                $("#limit_cm").hide();
                $("#upapply").attr("data-id","0");
                getQos(devmac);
            }else{
                $(".dev-center").hide();
                $("#limit_cm").hide();
                $("#uplimit_span").css("display","inline-block");
                $("#upapply").html(curlang.limit_speed);
                $("#upapply").css("display","inline-block");
                $("#upapply").attr("data-id","1");
                getQos(devmac);
            }
        });
	},
	error: function(msg){
	}
	})
}
function routerInfo(){
	if(showter){
        get_clientNum();
		// getData_terminal_info();
	}
	//getData_port_info();
	getData_routerinfo();
}
//信道优化
function onform_postchannel(){
		$.ajax({
		type: 'post',
		url: '/goform/set_scanon_cfg',
		data: {"type":"channel"},
		dataType:"json",
		success: function(msg) {
		if((typeof msg)=="object"){var data=msg;}
		else{ var data=eval('('+msg+')');}
			if(data.result==0){}
			else{
				layer.msg(curlang.channelError, {icon: 5});
			}
		},
		error:function(data)
		{
		}
		})
}
function onform_setchannel(){
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_refine_channel',
	data: $("#form8").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
		showanimation(2,data,0);
	},
	error:function(data)
	{
		showanimation(3,'0',0);
	}
})}
function getData_channelquality_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_channelquality_info",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
	var channel=data.channel;
	if(data.quality == 0)
	{
	$("#qua").css("width","25%");
	$("#qua").css("background-color","red");

	}else if(data.quality == 1){
	$("#qua").css("width","65%");
	$("#qua").css("background-color","#FF8000");
	}else{
	$("#qua").css("width","100%");
	$("#qua").css("background-color","#008000");
	}
	$("#channel_num").html(channel);
	},
	error: function(msg){
	}
})}
//访客网络
function onform_visitor(){
		if($("#visitorON").prop("checked")){
			$("#visitor_name").val($.trim($("#visitor_name").val()));
			$("#visitor_pass").val($.trim($("#visitor_pass").val()));
			var VSSID=CheckSSID($.trim($("#visitor_name").val()));

			if(!VSSID){$("#visitor_name").focus();return false;}
			var VPass=CheckSSIDKey($.trim($("#visitor_pass").val()));

			if(!VPass){$("#visitor_pass").focus();return;}
		}
		//sleep(1);
	//	showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_visitor',
		data: $("#form12").serialize(),
		dataType:"json",
		success: function(data) {
			//showMessig(data,2);
			//sleep(0);
            showanimation(2,data,0);
		},
		error:function(data)
		{
               // showanimation(5);
		}
		});
    	showanimation(1);
    	setTimeout(function(){showanimation(5);},4000);
}
function onform_5Gvisitor(){
    if($("#5GvisitorON").prop("checked")){
        $("#5Gvisitor_name").val($.trim($("#5Gvisitor_name").val()));
        $("#5Gvisitor_pass").val($.trim($("#5Gvisitor_pass").val()));
        var VSSID=CheckSSID($.trim($("#5Gvisitor_name").val()));

        if(!VSSID){$("#5Gvisitor_name").focus();return false;}
        var VPass=CheckSSIDKey($.trim($("#5Gvisitor_pass").val()));

        if(!VPass){$("#5Gvisitor_pass").focus();return;}
    }
    //sleep(1);
   //showanimation(1,'0',0);
    $.ajax({
        type: 'post',
        url: '/goform/set_visitor5_info',
        data: $("#form12_5G").serialize(),
        dataType:"json",
        success: function(data) {
            //showMessig(data,2);
            //sleep(0);
            showanimation(2,data,0);
        },
        error:function(data)
        {
            //showanimation(5);
        }
    });
    showanimation(1);
    setTimeout(function(){showanimation(5);},4000);
}
function GetMode(num){
	if(!num){
		$("#visitorOFF").trigger("click");
		$("#visitor_name").attr("disabled",true);
		$("#visitor_name").addClass("inpt-disabled");
		$("#visitor_pass").attr("disabled",true);
		$("#visitor_pass").addClass("inpt-disabled");
		$("#5GvisitorOFF").trigger("click");
        $("#5Gvisitor_name").attr("disabled",true);
        $("#5Gvisitor_name").addClass("inpt-disabled");
        $("#5Gvisitor_pass").attr("disabled",true);
        $("#5Gvisitor_pass").addClass("inpt-disabled");
        $(".visitor_namelabel").css("display","none");
        $(".visitor_passlabel").css("display","none");
	}else{
		$("#visitorON").trigger("click");
		$("#visitor_name").attr("disabled",false);
		$("#visitor_name").removeClass("inpt-disabled");
		$("#visitor_pass").attr("disabled",false);
		$("#visitor_pass").removeClass("inpt-disabled");
        $("#5GvisitorON").trigger("click");
        $("#5Gvisitor_name").attr("disabled",false);
        $("#5Gvisitor_name").removeClass("inpt-disabled");
        $("#5Gvisitor_pass").attr("disabled",false);
        $("#5Gvisitor_pass").removeClass("inpt-disabled");
	}
}
//pc访客
function getData_visitor_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_visiter_info",
	dataType:"json",
	success: function(msg){
	if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(!(data.gssid=="" || !data.gssid)){
		$("#visitor_name").val(data.gssid);
		$("#visitor_name").focus();
	}
	if(!(data.gpsw=="" || !data.gpsw)){
		$("#visitor_pass").val(data.gpsw);
		$("#visitor_pass").focus();
	}
	GetMode(data.gssidenable);
	},
	error: function(msg){
	}
})}
function getData_5Gvisitor_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_visitor5_info",
	dataType:"json",
	success: function(msg){
	if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(!(data.g5ssid=="" || !data.g5ssid)){
        $("#5Gvisitor_name").val(data.g5ssid);
		$("#5Gvisitor_name").focus();
	}
	if(!(data.g5psw=="" || !data.g5psw)){
		$("#5Gvisitor_pass").val(data.g5psw);
		$("#5Gvisitor_pass").focus();
	}
	GetMode(data.g5ssidenable);
	},
	error: function(msg){
	}

})}
//app访客
function getData_M24G_visitor_info(){
	$.ajax({
		type:"get",
		url:"/goform/get_visiter_info",
		dataType:"json",
		success: function(msg){
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}
			if(!(data.gssid=="" || !data.gssid)){
				$("#visitor_name").val(data.gssid);
				// $("#visitor_name").focus();
			}
			if(!(data.gpsw=="" || !data.gpsw)){
				$("#visitor_pass").val(data.gpsw);
				// $("#visitor_pass").focus();
			}
			GetMode(data.gssidenable);
		},
		error: function(msg){
		}
	})}

	function getData_M5G_visitor_info(){
	$.ajax({
		type:"get",
		url:"/goform/get_visitor5_info",
		dataType:"json",
		success: function(msg){
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}
			if(!(data.g5ssid=="" || !data.g5ssid)){
				$("#5Gvisitor_name").val(data.g5ssid);
				// $("#visitor_name").focus();
			}
			if(!(data.g5psw=="" || !data.g5psw)){
				$("#5Gvisitor_pass").val(data.g5psw);
				// $("#visitor_pass").focus();
			}
			GetMode(data.g5ssidenable);
		},
		error: function(msg){
		}
	})}
//qos
function getData_qos_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_qos_cfg",
	dataType:"json",
	success: function(msg){
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(data.mode == 0)
	{
	document.getElementById("qos1").checked=true;

	}else if(data.mode == 1){
	document.getElementById("qos2").checked=true;
	}else if(data.mode == 2){
	document.getElementById("qos3").checked=true;
	}else{
	document.getElementById("qos4").checked=true;
	}},
	error: function(msg){
	}
})}
function onform_Qos(){
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_qos_cfg',
	data: $("#form11").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
		showanimation(2,data,0);
	},
	error:function(data)
	{
		showanimation(3,'0',0);
	}
})}
//黑名单
function lostBlack(obj){
	if($(obj).attr('id')==$("#bChance").attr('id')){
		return;
	}
	var num=$(obj).attr("id").toString();
	num=num.replace('bChance','');
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'get',
		url: '/goform/set_blacklist',
		data: {"type":"setmacblack", "mac":$("#bMac"+num).html(),"enable": "0"},
		dataType:"json",
		success: function(data) {
         //showMessig(data,0);
		 //sleep(0);
		 showanimation(2,data,0);
		 getData_blacklist_info();
		 },
			error:function(data)
		{showanimation(3,'0',0);}
	})
}
function getData_blacklist_info(){
	$.ajax({
	type:"get",
	url:"/goform/get_blacklist_info",
	dataType:"json",
	success: function(msg){
	if(msg==null||msg==""||msg==undefined){
	 return;
	}
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(!data.list){
		return;
	}
	var i=data.list.length;
	$($("#blackItem").siblings()).remove();
	$("#blackItem").css("display","block");
	for(var j=1;j<=i;j++)
	{
	$("#blackItem").clone("ture").appendTo("#blackList");
	$("#blackItem").attr('id','blackItem'+j);
	$("#bNum").attr('id','bNum'+j);
	$("#bNum"+j).html(j);
	$("#bMac").attr('id','bMac'+j);
	$("#bMac"+j).html(data.list[j-1].mac);
	$("#bName").attr('id','bName'+j);
	if(data.list[j-1].name.length>12){
		var buf=data.list[j-1].name.substr(0,12);
	}else{
		var buf=data.list[j-1].name;
	}
	$("#bName"+j).html(buf);
	$("#bChance").attr('id','bChance'+j);
	$("#bChance"+j).html(curlang.unclik);
	$("#bChance"+j).css('cursor','pointer');
	$("#bChance"+j).css('color','red');
	}
	$("#blackItem").prependTo("#blackList");
	},
	error: function(msg){
	}
	})
}
//静态绑定
function lostBind(obj){
	if($(obj).attr('id')==$("#sChance").attr('id')){
		return;
	}
	var num=$(obj).attr("id").toString();
	num=num.replace('sChance','');
	//sleep(1);
	showanimation(1,'0',0);
		$.ajax({
		type: 'get',
		url: '/goform/set_staticlist',
		data: {"type":" setarpbind","mac":$("#sMac"+num).html(),"ip":$("#sIP"+num).html(),"bind":"0"},
		dataType:"json",
		success: function(data) {
        //showMessig(data,0);
		//sleep(0);
		showanimation(2,data,0);
		getData_staticbind_list();
    },
			error:function(data)
		{
			showanimation(3,'0',0);
		}
	})
}
function getData_staticbind_list(){
	$.ajax({
	type:"get",
	url:"/goform/get_staticlist_info",
	dataType:"json",
	success: function(msg){
	if(msg==null||msg==""||msg==undefined){
	 return;
	}
		if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
	if(!data.list){
		return;
	}
	var i=data.list.length;
	$($("#staticItem").siblings()).remove();
	$("#staticItem").css("display","block");
	for(var j=1;j<=i;j++)
	{
	$("#staticItem").clone("staticItem").appendTo("#staticList");
	$("#staticItem").attr('id','staticItem'+j);
	$("#sNum").attr('id','sNum'+j);
	$("#sNum"+j).html(j);
	$("#sMac").attr('id','sMac'+j);
	if($("#staticItem").attr("data-id")==1){
        $("#sMac"+j).parent().parent().find("li").css({"height":"45px","line-height":"44px"});
        $("#sMac"+j).parent().css("line-height","21px");
        $("#sMac"+j).css({"line-height":"20px","display":"block"});
	}
	$("#sMac"+j).html(data.list[j-1].mac);
	$("#sName").attr('id','sName'+j);
	if(data.list[j-1].name.length>12){
		var buf=data.list[j-1].name.substr(0,12);
	}else{
		var buf=data.list[j-1].name;
	}
	$("#sName"+j).html(buf);
	$("#sIP").attr('id','sIP'+j);
	$("#sIP"+j).html(data.list[j-1].ip);
	$("#sChance").attr('id','sChance'+j);
	$("#sChance"+j).html(curlang.unclik);
	$("#sChance"+j).css('cursor','pointer');
	$('#sChance'+j).css('color','red');
	}
	$("#staticItem").prependTo("#staticList");
	},
	error: function(msg){}
	})
}
//修改别名
function changeName(obj){
	var mac=$(obj).parent().siblings().eq(0).find(".span-r").html();
	$(obj).val($.trim($(obj).val()));
	var Alias=CheckAlias($(obj).val());
	if(!Alias){
		$(obj).val("");
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_alias_cfg',
		data: {"type":"setalias","mac" :mac,"alias":$(obj).val()},
		dataType:"json",
		success: function(data) {
        //showMessig(data,0);
		//sleep(0);
			showanimation(2,data,0);
            $("#dev_name").hide();
            $("#span_alias").css("display","inline-block");
            $("#span_alias").html($(obj).val());
            alias_D=false;
		},
		error:function(data)
		{
			showanimation(3,'0',0);
		}
	})
}
//修改别名
function MchangeName(obj){
	timeControl(1);
	var num=$(obj).attr("id").replace('Dnamer','');
	$(obj).val($.trim($(obj).val()));
	var Alias=CheckAlias($(obj).val());
	if(!Alias){
		$(obj).val("");
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_alias_cfg',
		data: {"type":"setalias","mac" :$("#DMac"+num).val(),"alias":$(obj).val()},
		dataType:"json",
		success: function(data) {
			//showMessig(data,0);
			//sleep(0);
			showanimation(2,data,0);
            $("#span_alias").html($(obj).val());
		},
		error:function(data)
		{
			showanimation(3,'0',0);
		}
	})
}
//网址黑名单
function urlBlacklist(){
    $.ajax({
        type: 'get',
        url: '/goform/get_wsiteblist_info',
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
            if(!textarea){
                $(".textarea").val(data.allurl);
			}
            var onbuf="",offbuf="",pos;
            for(var i=0;i<data.onlist.length;i++){
                if(data.onlist[i].type=="Android"){
                    pos="-33px";
                }
                else if(data.onlist[i].type=="iPhone"){
                    pos="-65px";
                }
                else if(data.onlist[i].type=="PC"){
                    pos="0px";
                }
                else if(data.onlist[i].type=="Router"){
                    pos="-130px";
                }
                else{
                    pos="-163px";
                }
            	onbuf=onbuf+'<div class="term_con"><span class="term_img"><img src="images/devtype.png" style="left:'+pos+'"></span><span class="term_macN"><p>'+curlang.name+'</p><p style="width:140px;">'+data.onlist[i].name+'</p><p>MAC: '+data.onlist[i].mac+'</p></span><span class="term_text"><p>'+curlang.host_website+'</p><p class="website_p">'+data.onlist[i].url+'</p></span><span><p class="edit_term">'+curlang.host_setup+'</p></span><span><p class="one_delurl">'+curlang.Remove+'</p></span></div>'
			}
			$("#term_online").html(onbuf);
			for(var i=0;i<data.oflist.length;i++){
            	offbuf=offbuf+'<div class="term_con"><span class="term_img">***</span><span class="term_macN"><p>'+curlang.name+'</p><p style="width:140px;">'+data.oflist[i].name+'</p><p>MAC: '+data.oflist[i].mac+'</p></span><span class="term_text"><p>'+curlang.host_website+'</p><p class="website_p">'+data.oflist[i].url+'</p></span><span><p class="edit_term">'+curlang.host_setup+'</p></span><span><p class="one_delurl"">'+curlang.Remove+'</p></span></div>'
			}
			$("#term_offline").html(offbuf);
            $("#term_offline").hide();
            EditTerm();
            if($("#get_urlBlack").css("display")=="block"){
                $(".edit_term").html(curlang.host_edit);
                urlVal();
			}else{
                $(".term_con").show();
                $(".edit_term").html(curlang.host_setup);
			}
			if(parseInt($(".term_height").css("height"))>187){
				$(".term_mode").css("height","188px");
				$(".term_mode").css("overflow-y","auto");
			}else{
				$(".term_mode").css("height","auto");
				$(".term_mode").css("overflow-y","hidden");
			}
        },
        error:function(msg){

        }
    })
}
//app网址黑名单
function MurlBlacklist(){
    $.ajax({
        type: 'get',
        url: '/goform/get_wsiteblist_info',
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{ var data=eval('('+msg+')');}
			$("#g_urllist").val(data.allurl);
            var onbuf="",offbuf="",pos;
            for(var i=0;i<data.onlist.length;i++){
                if(data.onlist[i].type=="Android"){
                    pos="-33px 7px";
                }
                else if(data.onlist[i].type=="iPhone"){
                    pos="-65px 7px";
                }
                else if(data.onlist[i].type=="PC"){
                    pos="0px 7px";
                }
                else if(data.onlist[i].type=="Router"){
                    pos="-130px 7px";
                }
                else {
                    pos = "-163px 7px";
                }
            	onbuf=onbuf+'<div class="term_con"><span class="term_img" style="background-position:' + pos + '"></span><span class="term_macN"><p><i>'+curlang.name+'</i><i>'+data.onlist[i].name+'</i></p><p>MAC: '+data.onlist[i].mac+'</p></span><span class="term_text" style="display: none">'+data.onlist[i].url+'</span><span style="float: right;color: #0bb7f5;"><p class="edit_term">'+curlang.see_details+'</p></span><span style="float: right;padding-top: 8px"><p class="setup setup_term">'+curlang.host_setup+'</p></span></div>';
			}
			$("#term_online").html(onbuf);
			for(var i=0;i<data.oflist.length;i++){
                offbuf=offbuf+'<div class="term_con"><span style="width:32px;text-align:center;">***</span><span class="term_macN"><p><i>'+curlang.name+'</i><i>***</i></p><p>MAC: '+data.oflist[i].mac+'</p></span><span class="term_text" style="display: none">'+data.oflist[i].url+'</span><span style="float: right;color: #0bb7f5;"><p class="edit_term">'+curlang.see_details+'</p></span><span style="float: right;padding-top: 8px"><p class="setup setup_term">'+curlang.host_setup+'</p></span></div>';
			}
			$("#term_offline").html(offbuf);
            $("#term_offline").hide();
            appTermBlack();
        },
        error:function(msg){

        }
    })
}
//主机网址黑名单
function onform_urlBlack(url_v,num){
    var reg=/\s|\n/;
    if(url_v.length>500){
    	layer.msg(curlang.url_str,{icon:5});
    	return false;
	}
	if(reg.test(url_v)){
        layer.msg(curlang.space_str,{icon:5});
        return false;
	}
    if(url_v!=""&&url_v.charAt(url_v.length-1)!=";"){
        url_v+=";";
    }
    showanimation(1);
    $.ajax({
        type: 'post',
        url: '/goform/set_wsiteblist_info',
        data: {"type":"setwebsite","mac":"*","url":url_v},
        dataType:"json",
        success: function(data){
        	if(data.result==0){
                showanimation(5);
                if(num==1){
                    $("#g_urllist").val(url_v);
				}else{
					$("#set_urllist").hide();
					$("#edit_urllist").show();
					$("#g_urllist").attr("disabled",true);
					$("#g_urllist").css("border","0");
					urlBlacklist();
                }
			}else{
                showanimation(3);
			}
        },
        error:function(data){
            showanimation(3);
        }
    })
}
//终端网址黑名单
function onform_termBlack(num){
    var url_v=$("#text_term").val(),mac=$("#mac_term").val(),reg=/\s|\n/,data;
    if(url_v.length>64){
        layer.msg(curlang.term_str,{icon:5});
    	return false;
	}
	if(reg.test(url_v)){
        layer.msg(curlang.space_str,{icon:5});
        return false;
	}
	if(url_v==""){
        data={"type":"setdelwebsite","mac":mac};
	}else{
        if(url_v.charAt(url_v.length-1)!=";"){
            url_v+=";";
        }
        data={"type":"setwebsite","mac":mac,"url":url_v};
	}
    showanimation(1);
    $.ajax({
        type: 'post',
        url: '/goform/set_wsiteblist_info',
        data: data,
        dataType:"json",
        success: function(data){
        	if(data.result==0){
                showanimation(5);
                if(num==1){
                    MurlBlacklist();
                    $("#text_term").attr("disabled",true);
                    $("#text_term").css("border","0");
                    $("#term_edit").css("display","inline-block");
                    $("#term_sbu").css("display","none");
				}else{
                    urlBlacklist();
				}
			}else if(data.result==3){
        		layer.closeAll();
                layer.msg(curlang.term_num,{icon:5});
			}else{
                showanimation(3);
			}
        },
        error:function(data){
            showanimation(3);
        }
    })
}
//删除网址黑名单
function onform_delBlack(mac,num){
	var msg;
    if(mac=="*"){
        msg={"type":"setdelwebsite","mac":"*"}
	}else{
        msg={"type":"setdelwebsite","mac":mac}
	}
    showanimation(1);
    $.ajax({
        type: 'post',
        url: '/goform/set_wsiteblist_info',
        data: msg,
        dataType:"json",
        success: function(data){
        	if(data.result==0){
                showanimation(5);
                if(num==1){
                    MurlBlacklist();
                    if(mac!="*"){
						$("#text_term").val("");
					}
				}else{
                    urlBlacklist();
				}
			}else{
                showanimation(3);
			}
        },
        error:function(data){
            showanimation(3);
        }
    })
}
//信号强度设置
function onform_set_pamode()
{
	//sleep(1);
	//showanimation(1,'0',0);
	showanimation(6);
	$.ajax({
	type: 'post',
	url: '/goform/set_pamode',
	data: $("#form7").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
		showanimation(2,data,0);
	},
	error:function(data)
	{
		//showanimation(3,'0',0);
	}
	})
}
//5G信号强度设置
function onform_5Gset_pamode()
{
	//sleep(1);
	//showanimation(1,'0',0);
    showanimation(6);
	$.ajax({
	type: 'post',
	url: '/goform/set_pa5mode',
	data: $("#form7_5G").serialize(),
	dataType:"json",
	success: function(data) {
		//showMessig(data,0);
		//sleep(0);
		showanimation(2,data,0);
	},
	error:function(data)
	{
		//showanimation(3,'0',0);
	}
	})
}
function getData_signalstrength_info()
{
	$.ajax({
	type:"get",
	url:"/goform/get_signal_info",
	dataType:"json",
	success: function(msg)
	{
			if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
		if(data.pamode == 0)
		{
			$("#label_l").addClass("chanceThis");
			$("#label_2").removeClass("chanceThis");
			$("#label_3").removeClass("chanceThis");
			$("#signal_bar").css("width","25%");
			$("#signal_bar").css("background-color","#86E01E");
		}
		else if(data.pamode == 1)
		{
			$("#label_2").addClass("chanceThis");
			$("#label_1").removeClass("chanceThis");
			$("#label_3").removeClass("chanceThis");
			$("#signal_bar").css("width","55%");
			$("#signal_bar").css("background-color","#F2B01E");
		}
		else
		{
			$("#label_3").addClass("chanceThis");
			$("#label_2").removeClass("chanceThis");
			$("#label_1").removeClass("chanceThis");
			$("#signal_bar").css("width","100%");
			$("#signal_bar").css("background-color","red");
		}
	},
	error: function(data){
	}
})}
function getData_5Gsignalstrength_info()
{
	$.ajax({
	type:"get",
	url:"/goform/get_signal5_info",
	dataType:"json",
	success: function(msg)
	{
			if((typeof msg)=="object"){var data=msg;}
	else{ var data=eval('('+msg+')');}
		if(data.pa5mode == 0)
		{
			$("#label_4").addClass("chanceThis");
			$("#label_5").removeClass("chanceThis");
			$("#label_6").removeClass("chanceThis");
			$("#signal_bar_5G").css("width","25%");
			$("#signal_bar_5G").css("background-color","#86E01E");
		}
		else if(data.pa5mode == 1)
		{
			$("#label_5").addClass("chanceThis");
			$("#label_4").removeClass("chanceThis");
			$("#label_6").removeClass("chanceThis");
			$("#signal_bar_5G").css("width","55%");
			$("#signal_bar_5G").css("background-color","#F2B01E");
		}
		else
		{
			$("#label_6").addClass("chanceThis");
			$("#label_5").removeClass("chanceThis");
			$("#label_4").removeClass("chanceThis");
			$("#signal_bar_5G").css("width","100%");
			$("#signal_bar_5G").css("background-color","red");
		}
	},
	error: function(data){
	}
})}
//网络测速
function onform_testspeed(){
	$.ajax({
	type: 'post',
	url: '/goform/set_bandwidth_check',
	data: {"type":"wdCheck"},
	dataType:"json",
	success: function(data) {
	},
	error:function(data)
	{}
	})
}
	function getData_bwinfo(){
		$(".return_a,.Mcannel").click(function(){
            $("#app_section").show();
            $("#app_detail").hide();
            $("#area").html("");
            $("#F_name").html("");
		})
		$("#respeed_button").click(function(){
		  $("#close_button").attr("disabled", true);
		  $("#close_button").css("cursor", "not-allowed");
		  $("#close_button").unbind("click");
		  $("#respeed_button").attr("disabled", true);
		  $("#respeed_button").css("cursor", "not-allowed");
		  $("#respeed_button").unbind("click");
		  $(".return_a").unbind("click");
		  $(".return_a").css("cursor", "not-allowed");
		  start();
		  onform_testspeed();
		  setTimeout(getData_bwinfo, 34000);
		  $("#speedWait").css("display", "block");
		  $("#dialogspeed").css("display", "none");
		})

		$.ajax({
		type:"get",
		url:"/goform/test_speed_info",
		dataType:"json",
		success: function(msg)
		{
			if((typeof msg)=="object"){var data=msg;}
		else{ var data=eval('('+msg+')');}
		var load=(data.download/1024).toFixed(1);
		var up=(data.upload/1024).toFixed(1);
		if(load>1024){
			load=(load/1024.0).toFixed(1);
			$("#unitDown").html("MB/s");
		}else{
			$("#unitDown").html("KB/s");
		}
		if(up>1024){
			up=(up/1024.0).toFixed(1);
			$("#unitUp").html("MB/s");
		}else{
			$("#unitUp").html('KB/s');
		}
		speedUp=up;
		speedLoad=load;
		$("#close_button").attr("disabled",false);
		$("#close_button").css("cursor","pointer");
		$("#respeed_button").attr("disabled",false);
		$("#respeed_button").css("cursor","pointer");
		$(".return_a").css("cursor","pointer");
	},
	error: function(msg)
	{

	}
	})}

function onform_restore()
{
	layer.closeAll();
	showanimation(1,'0',0);
	set_restore = 1;
	$.ajax({
	type: 'post',
	url: '/goform/set_restore',
	data: 'type=restore',
	dataType:"json",
	success: function(msg) {
		if(msg==null||msg==""||msg==undefined){
		 return;
		}
		else{

			showanimation(2,msg,0);
			restart('restore');
			//showMessig(msg,0);
		}
	},
	error:function(msg)
	{
		showanimation(3,'0',0);
	}
})}
//延时动画
function sleep(num){
	if(num){
		window.sleepShow=layer.open({
							  type: 1,
							  closeBtn: 0, //不显示关闭按钮
							  shift: 3,
							  offset:'150px',
							  skin:'layui-layer-loading',
							   scrollbar: false,
							  title: false,
							  shade: [0.7, '#000'],
							  content: '<div style="margin:0 auto;width:90px;height:90px;background: url(/admin/js/layer/skin/default/loading-2.gif) no-repeat;background-size: cover;" class="layui-layer-content layui-layer-loading2"></div>'
							});
	}else{
		layer.close(window.sleepShow);
		window.sleepShow=-1;
	}
	setTimeout(function(){layer.close(window.sleepShow);window.sleepShow=-1;},4000);
}
//LED获取
function get_ledswitch() {
    $.ajax({
        type: 'get',
        url: '/goform/get_led_status',
        data: {"type":"getledstatus"},
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{
                var data=eval('('+msg+')');
            }
            $("#start_hour").val(data.ledsh);
            $("#start_min").val(data.ledsm);
            $("#end_hour").val(data.ledeh);
            $("#end_min").val(data.ledem);
            $("#led_mode").val(data.ledeasysw);
            if(data.status==1){
                $('#LEDval1').prop("checked",true);
                ledSwitch(0);
            }else{
                $('#LEDval2').prop("checked",true);
                ledSwitch(1);
            }
        },
        error:function(msg) {}
    })
}
//led验证
function check_led(){
    var start_h=$("#start_hour").val();
    var start_m=$("#start_min").val();
    var end_h=$("#end_hour").val();
    var end_m=$("#end_min").val();
    if(!checkLEDhour(start_h)){
        $("#start_hour").focus();
        return;
    }
    if(!checkLEDmin(start_m)){
        $("#start_min").focus();
        return;
    }
    if(!checkLEDhour(end_h)){
        $("#end_hour").focus();
        return;
    }
    if(! checkLEDmin(end_m)){
        $("#end_min").focus();
        return;
    }
    start_h=parseInt(start_h);start_m=parseInt(start_m);end_h=parseInt(end_h);end_m=parseInt(end_m);
	if(start_h>end_h||(start_h==end_h&&start_m>end_m)){
        layer.msg(curlang.startend_time,{icon:5});
        return;
    }
    return true;
}
function checkLEDhour(hour_val) {
    if(hour_val==""){
        layer.msg(curlang.Enter_NULL,{icon: 5});
        return false;
    }
    var reg_hour=/^[0-9]{1,2}$/;
    if(!(reg_hour.test(hour_val))){
        $(this).val("");
        layer.msg(curlang.QOS_Error,{icon:5});
        return false;
    }
    if(hour_val>23||hour_val<0){
        $(this).val("");
        layer.msg(curlang.hour_Error,{icon:5});
        return false;
    }
    return true;
}
function checkLEDmin(min_val) {
    if(min_val==""){
        layer.msg(curlang.Enter_NULL,{icon: 5});
        return false;
    }
    var reg_min=/^[0-9]{1,2}$/;
    if(!(reg_min.test(min_val))){
        $(this).val("");
        layer.msg(curlang.QOS_Error,{icon:5});
        return false;
    }
    if(min_val>59||min_val<0){
        $(this).val("");
        layer.msg(curlang.min_Error,{icon:5});
        return false;
    }
    return true;
}
//led开关
function ledSwitch(num) {
	if(num==0){
		if($("#led_mode").val()=="0"){
            $(".hour").attr("disabled",false);
            $(".hour").removeClass("inpt-disabled");
			$("#Wtime_con").show();
			$("#led_tip").show();
		}else{
            $(".hour").attr("disabled",true);
            $(".hour").addClass("inpt-disabled");
			$("#Wtime_con").hide();
			$("#led_tip").hide();
		}
        $("#led_mode").attr("disabled",false);
        $("#led_mode").removeClass("inpt-disabled");
        $("#selectHide").show();
	}else{
        $(".hour").addClass("inpt-disabled");
        $(".hour").attr("disabled",true);
        $("#led_mode").attr("disabled",true);
        $("#led_mode").addClass("inpt-disabled");
		$("#selectHide").hide();
		$("#Wtime_con").hide();
		$("#led_tip").hide();
	}
}
$("#led_mode").change(function () {
    if($("#led_mode").val()=="0"){
        $(".hour").attr("disabled",false);
        $(".hour").removeClass("inpt-disabled");
		$("#Wtime_con").show();
		$("#led_tip").show();
    }else{
        $(".hour").attr("disabled",true);
        $(".hour").addClass("inpt-disabled");
		$("#Wtime_con").hide();
		$("#led_tip").hide();
    }
})
$('#LEDval1').click(function(){
    ledSwitch(0);
});
$('#LEDval2').click(function(){
    ledSwitch(1);
});
//led提交
function onform_ledswitch() {
    if($('#LEDval1').prop("checked")){
        if(!check_led()){
            return;
        }
	}
    showanimation(1,'0',0);
    $.ajax({
        type: 'post',
        url: '/goform/set_led_status',
        data: $("#LED_timing").serialize(),
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{
                var data=eval('('+msg+')');
            }
            if(data.result==0){
                //showMessig(msg,0);
                //sleep(0);
                showanimation(2,msg,0);
            }else{
                showanimation(3,msg,0);
			}
        },
        error:function(msg)
        {
            showanimation(3,'0',0);
        }
    })
}
//世界时间
	//本地时间
function get_curTmie(){
    $.ajax({
        type: 'get',
        url: '/goform/get_time_zone',
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{
                var data=eval('('+msg+')');
            }
            $("#current_time").html(data.systemtime);
        },
        error:function(msg) {}
    })
}
function get_timeZone_info(){
    $.ajax({
        type: 'get',
        url: '/goform/get_time_zone',
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{
                var data=eval('('+msg+')');
            }
			$("#ntpserver").val(data.ntpserver);
			$("#timeZone").val(data.ntptz);
			$("#ntpsync").val(data.ntpsync);
        },
        error:function(msg) {}
    })
}
function onform_timeZone(){
	if($("#ntpserver").val()==""){
		layer.msg(curlang.Enter_NULL,{icon:5});
		return false;
	}
    $.ajax({
        type: 'post',
        url: '/goform/set_time_zone',
        data:$("#worldTiming").serialize(),
        dataType:"json",
        success: function(msg) {
            showanimation(6);
        },
        error:function(msg) {
            showanimation(6);
            showanimation(3);
		}
    })
}
//硬件加速
function get_HWNATswitch() {
	$.ajax({
		type: 'get',
		url: '/goform/get_hw_nat',
		data: {"type":" gethwnat"},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.status==1){
				$('#hardware_radio1').prop("checked",true);
			}else{
				$('#hardware_radio2').prop("checked",true);
			}
		},
		error:function(msg) {}
	})
}
function onform_HWNATswitch(obj) {
    var radioVal=$(obj).val();
    showanimation(1,'0',0);
    $.ajax({
        type: 'post',
        url: '/goform/set_hw_nat',
        data: {"type":" sethwnat","status":radioVal},
        dataType:"json",
        success: function(msg) {
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            if((typeof msg)=="object"){var data=msg;}
            else{
                var data=eval('('+msg+')');
            }
            if(data.result==0){
                //showMessig(msg,0);
                //sleep(0);
                showanimation(2,msg,0);
            }else{
                showanimation(3,msg,0);
            }
        },
        error:function(msg)
        {
            showanimation(3,'0',0);
        }
    })
}
function getdata_macclone(){
	$.ajax({
		type: 'get',
		url: '/goform/get_clonelist_cfg',
		data: {"type":"getsubmaclist"},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}
                $("#cloneinpt").val(data.clonemac);
				$("#cloneinpt").siblings().click(function(){
					$("#cloneinpt").val(data.self);
				});
			$("#mac_apply").css("cursor","pointer");
			$("#cloneOn").prop('checked',true);
			$("#layList").children().empty();
			var maxlength;
			var temp="";
			if(!data.list){
				return;
			}
			if(data.list.length>5){
				maxlength=5;
			}else{
				maxlength=data.list.length;
			}
			for(var i=0;i<maxlength;i++){
				temp="<li class='macitem' style='border:0px;margin:0px;color:black;'>"+data.list[i].mac+"</li>";
				$("#layList").children().append(temp);
			}
				$(".macitem").mouseover(function(){
					$("#cloneinpt").val($(this).html());
				})



		},
		error:function(msg)
		{
		}
	})
}
function onform_keyMac(){
	//sleep(1);
	var keystatus;
	if($("#cloneOn").prop('checked')){
		keystatus=1;
		$("#cloneinpt").attr("disabled",false);
		$("#cloneinpt").removeClass("inpt-disabled");
		$("#cloneinpt").siblings().attr("disabled",false);
	}else{
		keystatus=0;
		$("#cloneinpt").val("");
		$("#cloneinpt").addClass("inpt-disabled");
		$("#cloneinpt").attr("disabled",true);
		$("#cloneinpt").siblings().attr("disabled",true);
	}
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_cloneSW_cfg',
		data: {"type":"setclonesw","clone_status" :keystatus},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}
			else{
				getdata_macclone();
				//showMessig(msg,0);
				//sleep(0);
				showanimation(2,msg,0);
			}
		},
		error:function(msg)
		{
			showanimation(3,'0',0);
		}
	})
}
function onform_setMac(){
	set_restore=1;
	var macBool=CheckMAC($("#cloneinpt").val());
	if(!macBool){return;}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_clone_cfg',
		data: {"type":"setclonemac","mac" :$("#cloneinpt").val()},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}
			else{
				showanimation(2,msg,0);
                //onform_reboot();
                restart('reboot');
				//showMessig(msg,0);
				//sleep(0);
			}
		},
		error:function(msg)
		{
			showanimation(3,'0',0);
		}
	})
}
//
function getdataM_DNS_info(){
	$.ajax({
		type: 'get',
		url: '/goform/get_AdvDns_cfg',
		data: {"type":"getdnsinfo"},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}
			if((typeof msg)=="object"){
				var data=msg;
			}else{ 
				var data=eval('('+msg+')');
			}
			$("#dns_set1").val(data.dns1);
			if(data.dns1!=""){
				$("#dns_set2").val(data.dns2);
			}else{
				if(data.dns2==""){
					$("#dns_set2").val("");
				}else{
					$("#dns_set2").val(data.dns2);
				}
			}
            if(data.status==1){
                dnsset(data.status);
            }else{
                dnsset(data.status);
            }
		},
		error:function(msg){
		}
	})
}
function getdata_DNS_info(){
	$.ajax({
		type: 'get',
		url: '/goform/get_AdvDns_cfg',
		data: {"type":"getdnsinfo"},
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{ var data=eval('('+msg+')');}
			$("#dns_set1").val(data.dns1);
			$("#dns_set1").focus();
			if(data.dns1!=""){
				$("#dns_set2").val(data.dns2);
				$("#dns_set2").focus();
			}else{
				if(data.dns2==""){
					$("#dns_set2").val("");
				}else{
					$("#dns_set2").val(data.dns2);
					$("#dns_set2").focus();
				}
			}
            if(data.status==1){
                dnsset(data.status);
            }else{
                dnsset(data.status);
            }
		},
		error:function(msg){}
	})
}
function checkDNS(){
	var dns1=CheckDNS($("#dns_set1").val());
	if(!dns1){$("#dns_set1").focus();return false;}
	if($("#dns_set2").val()!=""){
		var dns2=CheckDNS($("#dns_set2").val());
		if(!dns2){$("#dns_set2").focus();return false;}
	}
	return true;
}
//DNS开关
function dnsset(num) {
	if(num==1){
        $("#DNS_on").prop("checked",true);
        $("#dns_set1").attr("disabled",false);
        $("#dns_set2").attr("disabled",false);
        $("#dns_set1").removeClass("inpt-disabled");
        $("#dns_set2").removeClass("inpt-disabled");
	}else{
        $("#DNS_off").prop("checked",true);
        $("#dns_set1").attr("disabled",true);
        $("#dns_set2").attr("disabled",true);
        $("#dns_set1").addClass("inpt-disabled");
        $("#dns_set2").addClass("inpt-disabled");
	}
}
$("#DNS_on").click(function(){
    dnsset(1);
})
$("#DNS_off").click(function(){
    dnsset(0);
})
function onform_DNS(){
	if($("#DNS_on").prop('checked')){
        if(!checkDNS()){return;}
	}
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_AdvDns_cfg',
		data: $("#dnsSet").serialize(),
		dataType:"json",
		success: function(msg) {
			if(msg==null||msg==""||msg==undefined){
			 return;
			}else{
				showanimation(2,msg,0);
			}
		},
		error:function(msg)
		{
			showanimation(3,'0',0);
		}
	})
}
function changeMode(obj){
	if($(obj).val()=="DHCP"){
		$(".static_type").css("display","none");
		$(".vpn_inpt").attr("disabled",true);
	}else{
		$(".static_type").css("display","block");
		$(".vpn_inpt").attr("disabled",false);
	}
}

function onformVpn(){
	if(vpnFlag){
		onformL2TP();
	}else{
		onformPPTP();
	}
}
function checkVpn(){
	var Domain=IsURL($("#vpn_domain").val());
	if(!Domain){$("#vpn_domain").focus();return false;}

	var Login=CheckPPPOELogin($("#vpn_username").val());
	if(!Login){$("#vpn_username").focus();return false;}
	var username=$.trim($("#vpn_username").val());
	$("#vpn_username").val(username);

	var PASS=CheckPPPOEPass($("#vpn_password").val());
	if(!PASS){$("#vpn_password").focus();return false;}
	var password=$.trim($("#vpn_password").val());
	$("#vpn_password").val(password);

	var type=$("#vpn_type").val();
	if(type!="DHCP"){
		var IP=CheckIPaddress($("#vpn_ip").val());
		if(!IP){$("#vpn_ip").focus();return false;}
		var ip=clearZERO($("#vpn_ip").val());
		if(ip==0){
			$("#vpn_ip").val("");
		}else{
			$("#vpn_ip").val(ip);
		}

		var mask=$("#vpn_mask").val();
		var MASK=CheckMask($("#vpn_ip").val(),mask);
		if(!MASK){$("#vpn_mask").focus();return false;}
		mask=clearZERO($("#vpn_mask").val());
		if(mask==0){
			$("#vpn_mask").val("");
		}else{
			$("#vpn_mask").val(mask);
		}

		var GateWay=CheckGateway($("#vpn_gateway").val());
		if(!GateWay){$("#vpn_gateway").focus();return false;}
		var gateway=clearZERO($("#vpn_gateway").val());
		if(gateway==0){
			$("#vpn_gateway").val("");
		}else{
			$("#vpn_gateway").val(gateway);
		}

	}
	var MTU=CheckMTUl2tp($("#vpn_mtu").val());
	if(!MTU){return false;}
	var mtu=parseInt($("#vpn_mtu").val());
	$("#vpn_mtu").val(mtu);
	return true;
}
function checkPPTP(){
	var pt_Domain=IsURL($("#pptp_domain").val());
	if(!pt_Domain){$("#pptp_domain").focus();return false;}

	var pt_Login=CheckPPPOELogin($("#pptp_username").val());
	if(!pt_Login){$("#pptp_username").focus();return false;}
	var pt_username=$.trim($("#pptp_username").val());
	$("#pptp_username").val(pt_username);

	var PT_PASS=CheckPPPOEPass($("#pptp_password").val());
	if(!PT_PASS){$("#pptp_password").focus();return false;}
	var pt_password=$.trim($("#pptp_password").val());
	$("#pptp_password").val(pt_password);

	var pt_type=$("#pptp_type").val();
	if(pt_type!="DHCP"){
		var PT_IP=CheckIPaddress($("#pptp_ip").val());
		if(!PT_IP){$("#pptp_ip").focus();return false;}
		var pt_ip=clearZERO($("#pptp_ip").val());
		if(pt_ip==0){
			$("#pptp_ip").val("");
		}else{
			$("#pptp_ip").val(pt_ip);
		}

		var pt_mask=$("#pptp_mask").val();
		var PT_MASK=CheckMask($("#pptp_ip").val(),pt_mask);
		if(!PT_MASK){$("#pptp_mask").focus();return false;}
		pt_mask=clearZERO($("#pptp_mask").val());
		if(pt_mask==0){
			$("#pptp_mask").val("");
		}else{
			$("#pptp_mask").val(pt_mask);
		}

		var PT_GateWay=CheckGateway($("#pptp_gateway").val());
		if(!PT_GateWay){$("#pptp_gateway").focus();return false;}
		var pt_gateway=clearZERO($("#pptp_gateway").val());
		if(pt_gateway==0){
			$("#pptp_gateway").val("");
		}else{
			$("#pptp_gateway").val(pt_gateway);
		}

	}
	var PT_MTU=CheckMTUppoe($("#pptp_mtu").val());
	if(!PT_MTU){return false;}
	var pt_mtu=parseInt($("#pptp_mtu").val());
	$("#pptp_mtu").val(pt_mtu);
	return true;
}
function onformL2TP(){
	if(!checkVpn()){
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_l2tpdata_cfg',
	data: $("#vpn_form").serialize(),
	dataType:"json",
	success: function(data) {
		setTimeout(function(){showanimation(2,data,0);},3000);
	},
	error:function(data){showanimation(3,'0',0);}
	})
}
function onformPPTP(){
	if(!checkVpn()){
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
	type: 'post',
	url: '/goform/set_pptpdata_cfg',
	data: $("#vpn_form").serialize(),
	dataType:"json",
	success: function(data) {
		setTimeout(function(){showanimation(2,data,0);},3000);
	},
	error:function(data){showanimation(3,'0',0);}
	})
}
function onformPPTPAPP(){
	if(!checkPPTP()){
		return;
	}
	//sleep(1);
	showanimation(1,'0',0);
	$.ajax({
		type: 'post',
		url: '/goform/set_pptpdata_cfg',
		data: $("#vpn_pptp_form").serialize(),
		dataType:"json",
		success: function(data) {
			// setTimeout(function(){showanimation(2,data,0);},3000);
            showanimation(2,data,0)
		},
		error:function(data){showanimation(3,'0',0);}
	})
}
function getData_l2tp(){
	//sleep(1);
	$.ajax({
	type:"get",
	url:"/goform/get_l2tpdata_cfg",
	dataType:"json",
	success: function(msg){
		sleep(0);
		if(msg==""||msg=="undefine"||msg==null){
			return;
		}
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
		if(data.result==6){
			layer.msg(curlang.dns_result, {icon: 5});
			var pptpTime=setInterval(function(){layer.closeAll();},3000);
			clearInterval(pptpTime);
			return;
		}
		$("#vpn_domain").val(data.domain);
		$("#vpn_domain").focus();
		$("#vpn_username").val(data.username);
		$("#vpn_username").focus();
		$("#vpn_password").val(data.password);
		$("#vpn_password").focus();
		$("#vpn_type").val(data.netmode);
		$("#vpn_type").trigger("change");
		$("#vpn_ip").val(data.staticip);
		$("#vpn_ip").focus();
		$("#vpn_mask").val(data.staticmask);
		$("#vpn_mask").focus();
		$("#vpn_gateway").val(data.staticgateway);
		$("#vpn_gateway").focus();
		$("#vpn_mtu").val(data.MTU);
		$("#vpn_mtu").focus();
	},
	error:function(msg){}
	})
}
function getData_pptp(){
	$.ajax({
	type:"get",
	url:"/goform/get_pptpdata_cfg",
	dataType:"json",
	success: function(msg){
		if(msg==""||msg=="undefine"||msg==null){
			return;
		}
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
		if(data.result==6){
			layer.msg(curlang.dns_result, {icon: 5});
			var pptpTime=setInterval(function(){layer.closeAll();},3000);
			clearInterval(pptpTime);
			return;
		}
		$("#pptp_domain").val(data.domain);
		$("#pptp_domain").focus();
		$("#pptp_username").val(data.username);
		$("#pptp_username").focus();
		$("#pptp_password").val(data.password);
		$("#pptp_password").focus();
		if(data.mppe==1){
			$("#mppeon").trigger("click");
		}else{
			$("#mppeoff").trigger("click");
		}
		$("#pptp_type").val(data.netmode);
		$("#pptp_type").trigger("change");
		$("#pptp_ip").val(data.staticip);
		$("#pptp_ip").focus();
		$("#pptp_mask").val(data.staticmask);
		$("#pptp_mask").focus();
		$("#pptp_gateway").val(data.staticgateway);
		$("#pptp_gateway").focus();
		$("#pptp_mtu").val(data.MTU);
		$("#pptp_mtu").focus();
	},
	error:function(msg){}
	})
}
function getData_Ml2tp(){
	//sleep(1);
	$.ajax({
		type:"get",
		url:"/goform/get_l2tpdata_cfg",
		dataType:"json",
		success: function(msg){
			sleep(0);
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==6){
				layer.msg(curlang.dns_result, {icon: 5});
				var pptpTime=setInterval(function(){layer.closeAll();},3000);
				clearInterval(pptpTime);
				return;
			}
			$("#vpn_domain").val(data.domain);
			// $("#vpn_domain").focus();
			$("#vpn_username").val(data.username);
			// $("#vpn_username").focus();
			$("#vpn_password").val(data.password);
			// $("#vpn_password").focus();
			$("#vpn_type").val(data.netmode);
			$("#vpn_type").trigger("change");
			$("#vpn_ip").val(data.staticip);
			// $("#vpn_ip").focus();
			$("#vpn_mask").val(data.staticmask);
			// $("#vpn_mask").focus();
			$("#vpn_gateway").val(data.staticgateway);
			// $("#vpn_gateway").focus();
			$("#vpn_mtu").val(data.MTU);
			// $("#vpn_mtu").focus();
		},
		error:function(msg){}
	})
}
function getData_Mpptp(){
	$.ajax({
		type:"get",
		url:"/goform/get_pptpdata_cfg",
		dataType:"json",
		success: function(msg){
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==6){
				layer.msg(curlang.dns_result, {icon: 5});
				var pptpTime=setInterval(function(){layer.closeAll();},3000);
				clearInterval(pptpTime);
				return;
			}
			$("#pptp_domain").val(data.domain);
			// $("#pptp_domain").focus();
			$("#pptp_username").val(data.username);
			// $("#pptp_username").focus();
			$("#pptp_password").val(data.password);
			// $("#pptp_password").focus();
			if(data.mppe==1){
				$("#mppeon").trigger("click");
			}else{
				$("#mppeoff").trigger("click");
			}
			$("#pptp_type").val(data.netmode);
			$("#pptp_type").trigger("change");
			$("#pptp_ip").val(data.staticip);
			// $("#pptp_ip").focus();
			$("#pptp_mask").val(data.staticmask);
			// $("#pptp_mask").focus();
			$("#pptp_gateway").val(data.staticgateway);
			// $("#pptp_gateway").focus();
			$("#pptp_mtu").val(data.MTU);
			// $("#pptp_mtu").focus();
		},
		error:function(msg){}
	})
}
	$(function(){
		$(".NAS_item").click(function(){
			$(this).addClass("on");
			$($(this).siblings()).removeClass("on");
			if($(this).attr('id')=="NASuser"){
				getData_NASUser_info();
				$("#NASuser_Item").css("display","block");
				$($("#NASuser_Item").siblings()).css("display","none");
			}
			if($(this).attr('id')=="NASdisk"){
				getData_NASpath();
				$("#NASdisk_Item").css("display","block");
				$($("#NASdisk_Item").siblings()).css("display","none");
			}
			if($(this).attr('id')=="NASftp"){
				getData_FTPswitch_info();
				$("#NASftp_Item").css("display","block");
				$($("#NASftp_Item").siblings()).css("display","none");
			}
			if($(this).attr('id')=="NASsamba"){
				getData_SAMBAswitch_info();
				$("#NASsamba_Item").css("display","block");
				$($("#NASsamba_Item").siblings()).css("display","none");
			}
		})
	})
	function switchStatus(number){
		if(number==1){
			onform_FTPshareSwitch();
		}else{
			onform_SAMBAshareSwitch();
		}
	}
	function changeType(){
		if($("#NASuser_type").val()=="setftpuserpass"){
			$("#NASuser_user").val(FTPuser);
			$("#NASuser_user").removeClass("inpt-disabled");
			$("#NASuser_user").attr("disabled",false);
			$("#NASuserPassword").val(FTPpass);
			$("#NASuserPassword").focus();
		}else{
			$("#NASuser_user").val(SAMuser);
			$("#NASuser_user").addClass("inpt-disabled");
			$("#NASuser_user").attr("disabled",true);
			$("#NASuserPassword").val(SAMpass);
			$("#NASuserPassword").focus();
		}
	}
	function getData_NASUser_info(){
		$.ajax({
			type: 'get',
			url: '/goform/get_fsusrepass_cfg',
			data: $("#form8").serialize(),
			dataType:"json",
			success: function(msg) {
					if(msg==""||msg=="undefine"||msg==null){
						return;
					}
					if((typeof msg)=="object"){var data=msg;}
					else{
						var data=eval('('+msg+')');
					}
					if(data.result==6){
						layer.msg(curlang.dns_result, {icon: 5});
						var nasTime=setInterval(function(){layer.closeAll();},3000);
						clearInterval(nasTime);
						return;
					}
					$("#NASuser_type").val("setsamuserpass");
					if($("#NASuser_type").val()=="setsamuserpass"){
						$("#NASuser_user").val(data.samuser);
						$("#NASuser_user").focus();
						$("#NASuser_user").addClass("inpt-disabled");
						$("#NASuser_user").attr('disabled',true);
						$("#NASuserPassword").val(data.sampass);
						$("#NASuserPassword").focus();
					}else{
						$("#NASuser_user").val(data.ftpuser);
						$("#NASuser_user").focus();
						$("#NASuser_user").removeClass("inpt-disabled");
						$("#NASuser_user").attr('disabled',false);
						$("#NASuserPassword").val(data.ftppass);
						$("#NASuserPassword").focus();
					}
					FTPuser=data.ftpuser;
					FTPpass=data.ftppass;
					SAMuser=data.samuser;
					SAMpass=data.sampass;
			},
			error:function(data)
			{
			}
		})
	}
	function checkNASuser(){
		function user_pass(val){
			var reg;
			if($("#NASuser_type").val() == "setftpuserpass"){
                reg=/[:]/;
			}else{
				reg=/[`=:;"'\|\\<>]/;
			}
			if(reg.test(val)) {
                return false;
            }else {
                return true;
            }

		}
		var UserName=CheckPPPOELogin($("#NASuser_user").val());
		if($("#NASuser_type").val() == "setftpuserpass"){
			if($("#NASuser_user").val() == "admin"){
				layer.msg(curlangs.account_NULL, {icon: 5});
				return false;
			}
			if(!user_pass($("#NASuser_user").val())){
				layer.msg(curlangs.ftpsymb,{icon:5});
				return false;
			}
			if(!user_pass($("#NASuserPassword").val())){
				layer.msg(curlangs.ftpsymb,{icon:5});
				return false;
			}
		}else{
			if(!user_pass($("#NASuserPassword").val())){
				layer.msg(curlangs.sambasymb,{icon:5});
				return false;
			}
		}
		if(!UserName){return false;}
		var PassWord=CheckPPPOEPass($("#NASuserPassword").val());
		if(!PassWord){return false;}
		return true;
	}

	function onform_NASUser(){
	if(checkNASuser()){
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_fsusrepass_cfg',
		data: $("#onform_setuser").serialize(),
		dataType:"json",
		success: function(data) {
			//showMessig(data,0);
			getData_NASUser_info();
			//sleep(0);
			showanimation(2,data,0);
		},
		error:function(data){showanimation(3,'0',0);}})
	}}
	function getData_NASpath(){
		$.ajax({
			type: 'get',
			url: '/goform/get_fspath_cfg',
			data: {"type":"getfspath"},
			dataType:"json",
			success: function(msg) {
				if(msg==""||msg=="undefine"||msg==null){
					return;
				}
				if((typeof msg)=="object"){var data=msg;}
				else{
					var data=eval('('+msg+')');
				}
				if(data.result==6){
					layer.msg(curlang.dns_result, {icon: 5});
					var naspathTime=setInterval(function(){layer.closeAll();},3000);
					clearInterval(naspathTime);
					return;
				}
				if(!data.list){
					return;
				}
				$($("#NASdisk_li_first").siblings()).remove();
				var item="";
				var itemLength=data.list.length;
				for(var i=0;i<itemLength;i++){
					item="<li style='margin:0px;'><span class='sp-l' style='width:70px'>"+(itemLength-i)+"</span><span class='sp-l' id='Path"+i+"' style='width:410px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;text-align:left;padding-left:10px;'>"+data.list[i].path+"</span><span class='sp-l' style='width:120px;'><input id='FTP"+i+"' name='NAS' class='FTPbox' type='checkbox' /></span><span class='sp-r' style='width:122px;text-align:center;'><input type='checkbox' name='NAS' class='SAMBAbox' id='SAMBA"+i+"' /></span></li>";
					$("#NASdisk_li_first").after(item);
                }
				$("input[name='NAS']").prop("checked",false);
				$(".FTPbox").change(function(){
					var num=$(this).attr('id').replace("FTP","");
					if($(this).prop('checked')&&!$("#SAMBA"+num).prop("checked")){
						if(curNASboxNumber==5){
							$(this).prop('checked',false);
							layer.msg(curlangs.fileFive);
						}else{
						curNASboxNumber++;}
					}
					if(!$(this).prop('checked')&&!$("#SAMBA"+num).prop("checked")){
						if(curNASboxNumber==0){
						}else{
						curNASboxNumber--;
						}
					}})
                getData_SAMBAshare_info();
				/*$(".SAMBAbox").change(function(){
					var num=$(this).attr('id').replace("SAMBA","");
					if($(this).prop('checked')&&!$("#FTP"+num).prop("checked")){
						if(curNASboxNumber==5){
							$(this).prop('checked',false);
							layer.msg(curlang.fileFive);
						}else{
						curNASboxNumber++;}
					}
					if(!$(this).prop('checked')&&!$("#FTP"+num).prop("checked")){
						if(curNASboxNumber==0){
						}else{
						curNASboxNumber--;
						}
					}})*/
			},
			error:function(msg){}})
	}
	function getPATH(){
		var length=$("input[name='NAS']").length/2;
		var buff='{"type":"setfspath","list":[';
		for(var i=0;i<length;i++){
			var flag=0;
			if($("#SAMBA"+i).prop("checked") || $("#FTP"+i).prop("checked")){
				if($("#SAMBA"+i).prop("checked")){
					flag=flag+2;
				}
				if($("#FTP"+i).prop("checked")){
					flag=flag+1;
				}
				buff=buff+'{"path":\"'+$("#Path"+i).html()+'\","attribute":'+flag+'},'
			}
		}
		var debuff;
		if(length>0){
            debuff=buff.substring(0,buff.length-1);
		}else{
            debuff=buff.substring(0,buff.length);
		}
		debuff=debuff+']}';
		var str=eval('('+debuff+')');
		return str;
	}
	function onform_Path(){
		//if(curNASboxNumber==0){
		///	layer.msg(curlang.ChancefileNull);
		//	return;
		//}
		//sleep(1);
		var length=$("input[name='NAS']").length/2;
		var flag=0;
		for(var i=0;i<length;i++){

			if( $("#FTP"+i).prop("checked")){
				if($("#FTP"+i).prop("checked")){
					flag=flag+1;
				}
			}
		}
		if(flag > 1)
		{
			alert(curlangs.FtpAlert);
			return false;
		}
		var len=$(".SAMBAbox").length;
		var len_num=0;
		for(var j=0;j<len;j++){
            if($("#SAMBA"+j).prop("checked")){
                len_num=len_num+1;
			}
		}
        var samb=len_num+$(".samb_num").length;
		if(samb>16){
            layer.msg(curlangs.samblen_err,{icon:5});
            return false;
		}
		$.ajax({
		type: 'post',
		url: '/goform/set_fspath_cfg',
		data: getPATH(),
		dataType:"json",
		success: function(data) {
			//showMessig(data,0);
			//sleep(0);
			if(data.result==0){
                showanimation(6);
			}else if(data.result==1){
                showanimation(6);
                showanimation(3,'0',0)
			}else if(data.result==2){
                layer.msg(curlangs.fspath_err, {icon: 5});
			}else if(data.result==3){
                layer.msg(curlangs.fspath_U, {icon: 5});
			}
		},
		error:function(data){showanimation(6);showanimation(3,'0',0);}})
	}
	function getData_FTPswitch_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_fsstatus_cfg',
		data: {"type":"getftpsw"},
		dataType:"json",
		success: function(msg) {
				if(msg==""||msg=="undefine"||msg==null){
					return;
				}
				if((typeof msg)=="object"){var data=msg;}
				else{
					var data=eval('('+msg+')');
				}
				if(data.result==6){
					layer.msg(curlang.dns_result, {icon: 5});
					var naspathShare=setInterval(function(){layer.closeAll();},3000);
					clearInterval(naspathShare);
					return;
				}
				if(data.status==1){
					getData_FTPshare_info();
					$("#NASFTP_type").val("ON");
				}
				if(data.status==0){
					$("#NASFTP_type").val("OFF");
				}
		},
		error:function(data){}})
	}
	function onform_FTPshareSwitch(){
		var status;
		if($("#NASFTP_type").val()=="ON"){
			status=1;
		}else{
			status=0;
		}
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_fsstatus_cfg',
		data: {"type":"setftpsw","status":status},
		dataType:"json",
		success: function(msg){
			//showMessig(msg,0);
			showanimation(2,msg,0);
			if(msg==null||msg==""){
			 return;
			}
			else{
			if((typeof msg)=="object"){var data=msg;}
			else{var data=eval('('+msg+')'); }
			if(data.result==0){
				if(status==1){
					getData_FTPshare_info();
				}
				if(status==0){
					$($("#NASftp_li_first").siblings()).remove();
				}
			}}
			//sleep(0);
		},
		error:function(msg){showanimation(3,'0',0);}
	})}
	function getData_FTPshare_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_fsshrpath_cfg',
		data: {"type":"getftppath"},
		dataType:"json",
		success: function(msg) {
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==6){
				layer.msg(curlang.dns_result, {icon: 5});
				var naspathShare=setInterval(function(){layer.closeAll();},3000);
				clearInterval(naspathShare);
				return;
			}
			if(!data.list || data.list==""){
				return;
			}
			var item="";
			$($("#NASftp_li_first").siblings()).remove();
			for(var i=0;i<data.list.length;i++){
				item="<li id='FtpPthLi"+(data.list.length-i)+"'><span class='sp-l' style='width:80px'>"+(data.list.length-i)+"</span><span class='sp-l' id='FtpPth"+(data.list.length-i)+"' style='width:533px;text-align:left;padding-left:10px;overflow:hidden;'>"+data.list[i].path+"</span><span class='sp-r FTPpth' id='rmFtp"+(data.list.length-i)+"' style='width:142px;text-align:center;color:red;cursor:pointer;'>"+curlang.Remove+"</span></li>";
				$("#NASftp_li_first").after(item);
			}
			$(".FTPpth").click(function(){
				var number=$(this).attr('id').replace('rmFtp','');
				var obj=$("#FtpPth"+number).html();
				onform_removeFTPpath(obj,number);
			})

		},
		error:function(msg){}
	})}
	function onform_removeFTPpath(obj,number){
		//sleep(1);
		showanimation(1,'0',0);
		var path='\"'+obj+'\"';
		$.ajax({
		type: 'post',
		url: '/goform/set_delshrpath_cfg',
		data: {"type":"setftppath","path":obj},
		dataType:"json",
		success: function(msg){
			//showMessig(msg,0);
			showanimation(2,msg,0);
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==0){
				$("#FtpPthLi"+number).remove();
			}
			//sleep(0);
		},
		error:function(msg){showanimation(3,'0',0);}
	})
	}
	function getData_SAMBAswitch_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_fsstatus_cfg',
		data: {"type":"getsamsw"},
		dataType:"json",
		success: function(msg) {
				if(msg==""||msg=="undefine"||msg==null){
					return;
				}
				if((typeof msg)=="object"){var data=msg;}
				else{
					var data=eval('('+msg+')');
				}
				if(data.result==6){
					layer.msg(curlang.dns_result, {icon: 5});
					var naspathShare=setInterval(function(){layer.closeAll();},3000);
					clearInterval(naspathShare);
					return;
				}
				if(data.status==1){
					getData_SAMBAshare_info();
					$("#NASsamba_type").val("ON");
				}
				if(data.status==0){
					$("#NASsamba_type").val("OFF");
				}
		},
		error:function(data){}})
	}
	function onform_SAMBAshareSwitch(){
		var status;
		if($("#NASsamba_type").val()=="ON"){
			status=1;
		}else{
			status=0;
		}
		//sleep(1);
		showanimation(1,'0',0);
		$.ajax({
		type: 'post',
		url: '/goform/set_fsstatus_cfg',
		data: {"type":"setsamsw","status":status},
		dataType:"json",
		success: function(msg){
			//showMessig(msg,0);
			showanimation(2,msg,0);
			if(msg==null||msg==""){
			 return;
			}
			else{
			if((typeof msg)=="object"){var data=msg;}
			else{var data=eval('('+msg+')'); }
			if(data.result==0){
				if(status==1){
					getData_SAMBAshare_info();
				}
				if(status==0){
					$($("#NASsamba_li_first").siblings()).remove();
				}
			}}
			//sleep(0);
		},
		error:function(msg){showanimation(3,'0',0);}
	})}
	function getData_SAMBAshare_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_fsshrpath_cfg',
		data: {"type":"getsampath"},
		dataType:"json",
		success: function(msg) {
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==6){
				layer.msg(curlang.dns_result, {icon: 5});
				var naspathShare=setInterval(function(){layer.closeAll();},3000);
				clearInterval(naspathShare);
				return;
			}
			var item="";
			if(!data.list || data.list==""){
				return;
			}
			$($("#NASsamba_li_first").siblings()).remove();
			for(var i=0;i<data.list.length;i++){
				item="<li id='SamPthLi"+(data.list.length-i)+"' class='samb_num'><span class='sp-l' style='width:80px'>"+(data.list.length-i)+"</span><span class='sp-l' id='SAMBAPth"+(data.list.length-i)+"' style='width:515px;text-align:left;padding-left:10px;overflow:hidden;'>"+data.list[i].path+"</span><span class='sp-r SAMBApth' id='rmSAMBA"+(data.list.length-i)+"' style='width:135px;text-align:center;color:red;cursor:pointer;'>"+curlang.Remove+"</span></li>";
				$("#NASsamba_li_first").after(item);
			}
			$(".SAMBApth").click(function(){
				var number=$(this).attr('id').replace('rmSAMBA','');
				var obj=$("#SAMBAPth"+number).html();
				onform_removeSAMBApath(obj,number);
			})

		},
		error:function(msg){}
	})}
	function onform_removeSAMBApath(obj,number){
		//sleep(1);
		showanimation(1,'0',0);
		var path='\"'+obj+'\"';
		$.ajax({
		type: 'post',
		url: '/goform/set_delshrpath_cfg',
		data: {"type":"setfsampath","path":obj},
		dataType:"json",
		success: function(msg){
			//showMessig(msg,0);
			showanimation(2,msg,0);
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==0){
				$("#SamPthLi"+number).remove();
				for(var i=0;i < $(".samb_num").length;i++){
					$("#NASsamba_li_first").siblings().eq(i).find("span").eq(0).html(i+1);
				}
			}
			//sleep(0);
		},
		error:function(msg){showanimation(3,'0',0);}
	})}
	function onform_removeallSAMBApath(){
		$.ajax({
		type: 'post',
		url: '/goform/set_delshrpath_cfg',
		data: {"type":"delallsambafolder"},
		dataType:"json",
		success: function(msg){
			//showMessig(msg,0);
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==0){
                showanimation(6);
								$(".samb_num").remove();
								$('#NASsamba_li_first').parent('ul').css('height','auto');
			}
		},
		error:function(msg){showanimation(3,'0',0);}
	})}
function curChannel(obj,num){
	if(num==0){
		var MODE=$(obj).val();
		if(MODE=="US" || MODE=="TW"){
			$("#FloatChannel option[value='12']").remove();
			$("#FloatChannel option[value='13']").remove();
			$("#FloatChannel option[value='14']").remove();
		}
		if(MODE=="JP" || MODE=="NONE"){
			$("#FloatChannel option[value='12']").remove();
			$("#FloatChannel option[value='13']").remove();
			$("#FloatChannel option[value='14']").remove();
			$("#FloatChannel").append("<option class='FOption F1'  value='12' >12</option>");
			$("#FloatChannel").append("<option class='FOption F1'  value='13' >13</option>");
			$("#FloatChannel").append("<option class='FOption F1 F2' value='14' >14</option>");
		}
		if(MODE=="FR" || MODE=="IE" || MODE=="HK"){
			$("#FloatChannel option[value='12']").remove();
			$("#FloatChannel option[value='13']").remove();
			$("#FloatChannel option[value='14']").remove();
			$("#FloatChannel").append("<option class='FOption F1'  value='12' >12</option>");
			$("#FloatChannel").append("<option class='FOption F1'  value='13' >13</option>");
		}
		$("#FloatChannel").val('0');
	}else{
		var MODE=$(obj).val();
		if(MODE=="US" ||　MODE=="NONE"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='36' >36</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='40' >40</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='44' >44</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='48' >48</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='52' >52</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='56' >56</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='60' >60</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='64' >64</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='100' >100</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='104' >104</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='108' >108</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='112' >112</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='116' >116</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='120' >120</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='124' >124</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='128' >128</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='132' >132</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='136' >136</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='140' >140</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='149' >149</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='153' >153</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='157' >157</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='161' >161</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='165' >165</option>");
		}
		if(MODE=="IE"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='36' >36</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='40' >40</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='44' >44</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='48' >48</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='52' >52</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='56' >56</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='60' >60</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='64' >64</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='100' >100</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='104' >104</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='108' >108</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='112' >112</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='116' >116</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='120' >120</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='124' >124</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='128' >128</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='132' >132</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='136' >136</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='140' >140</option>");
			// $("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='149' >149</option>");
		}
		if(MODE=="JP"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='36' >36</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='40' >40</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='44' >44</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='48' >48</option>");
		}
		if(MODE=="FR"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='36' >36</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='40' >40</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='44' >44</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='48' >48</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='52' >52</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='56' >56</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='60' >60</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='64' >64</option>");
		}
		if(MODE=="HK"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='36' >36</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='40' >40</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='44' >44</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='48' >48</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='52' >52</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='56' >56</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='60' >60</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='64' >64</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='149' >149</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='153' >153</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='157' >157</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='161' >161</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='165' >165</option>");
		}
		if(MODE=="TW"){
			$("#DoubleChannel").empty();
			$("#DoubleChannel").append("<option value='0' class='O_auto'>"+curlang.O_auto+"</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='52' >52</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='56' >56</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='60' >60</option>");
			$("#DoubleChannel").append("<option class='Doption JP FR IE HK' value='64' >64</option>");
		}
		$("#DoubleChannel").val('0');
	}
}
function getData_Channel_info(){
	if(ChannelMode){
		var data="get2channel";
		var URL='/goform/get_adv24gchannel';
	}else{
		var data="get5channel";
		var URL='/goform/get_adv5gchannel';
	}
	$.ajax({
	type: 'get',
	url: URL,
	data: {"type":data},
	success: function(msg){
		if(msg==null||msg==""||msg==undefined){
		 return;
		}
		var data;
		if((typeof msg)=="object"){data=msg;}
		else{
			data=eval('('+msg+')');
		}
        set_restore=0;
		if(ChannelMode){
            $("#CountryCodeFloat").val(data.countrycode);
            $("#CountryCodeFloat").trigger("change");
            $("#FloatChannel").val(data.channel);
            $("#band_mode").val(data.htbw);
            if(data.channel==0){
                $("#channel2_show").show();
                $("#channel_2num").html(data.curchannel);
            }else{
                $("#channel2_show").hide();
			}
            if(data.htbw==0){
                $("#band2_show").show();
                $("#band2_num").html("20/40Mbps");
            }else{
                $("#band2_show").hide();
			}
            if($("#FloatChannel").val()=="14"){
                $("#band_mode").attr("disabled",true);
                $("#band_mode").addClass("selection-disabled");
                $("#band_mode").val(0);
            }else{
                $("#band_mode").attr("disabled",false);
                $("#band_mode").removeClass("selection-disabled");
            }
		}
		if(!ChannelMode){
			$("#CountryCodeDouble").val(data.countrycode);
			$("#CountryCodeDouble").trigger("change");
			$("#DoubleChannel").val(data.channel);
			$("#band_5mode").val(data.htbw);
            if(data.channel==0){
                $("#channel5_show").show();
                $("#channel_5num").html(data.curchannel);
            }else{
                $("#channel5_show").hide();
			}
            if(data.htbw==0){
                $("#band5_show").show();
                $("#band5_num").html("20/40/80Mbps");
            }else{
                $("#band5_show").hide();
			}
		}
	},
	error: function(msg){}
	})
}
function onform_Channel(){
	var data;
		set_restore=1;
	if(ChannelMode){
		var URL='/goform/set_adv24ghannel';
		data='{"type":"set2channel","channel":'+$("#FloatChannel").val()+',"countrycode":"'+$("#CountryCodeFloat").val().toString()+'","htbw":'+$("#band_mode").val()+'}';
	}else{
		var URL='/goform/set_adv5ghannel';
		data='{"type":"set5channel","channel":'+$("#DoubleChannel").val()+',"countrycode":"'+$("#CountryCodeDouble").val().toString()+'","htbw":'+$("#band_5mode").val()+'}';
	}
	var buff=eval('('+data+')');
	//sleep(1);
	//showanimation(1,'0',0);
	$.ajax({
	type: 'get',
	url: URL,
	data: buff,
	success: function(msg){
		//showMessig(msg,0);
		//sleep(0);
		showanimation(2,msg,0);
        getData_Channel_info();
	},
	error: function(msg){
        set_restore=0;
	}
	})
 	showanimation(1);
	setTimeout(function(){showanimation(5)},6000);
}
function getData_Upnp_info(){
	$.ajax({
	type: 'get',
	url: '/goform/get_upnp_cfg',
	data: {"type":"getupnp"},
	dataType:"json",
	success: function(msg){

		if(msg==null||msg==""||msg==undefined){
		 return;
		}

		var data;
		if((typeof msg)=="object"){data=msg;}
		else{
			data=eval('('+msg+')');
		}
		if(data.enable==1){
			$("#UPNPON").prop("checked",true);
			$("#upnpList").css("display","block");
			get_Upnp_port();
		}else{
			$("#UPNPOFF").prop("checked",true);
            $("#upnpList").css("display","none");
		}
	},
	error:function(msg){

	}})
}


function get_Upnp_port(){
	$.ajax({
		type: 'get',
		url: '/goform/get_upnpport_cfg',
		data: {"type":"getupnpport"},
		dataType:"json",
		success: function(msg){
			if(msg==null||msg==""||msg==undefined){
				return;
			}
			var data;
			if((typeof msg)=="object"){data=msg;}
			else{
				data=eval('('+msg+')');
			}

			// data.list = [
			// 	{
			// 		ip:'111',
			// 		internal:'111',
			// 		external:'111',
			// 		protocol:'111'
			// 	},
			// 	{
			// 		ip:'222',
			// 		internal:'222',
			// 		external:'222',
			// 		protocol:'222'
			// 	}
			// ]


			var linkbuff='<div class="upnphead"><span>'+curlang.IP+'</span><span>'+curlang.Internal_port+'</span><span>'+curlang.External_port+'</span><span class="bor">'+curlang.ip_addr+'</span></div>'
			var buff="";
			if(data.list==undefined){

			}else{
				for(var i=0;i<data.list.length;i++){
					buff=buff+'<div class="upnpdata"><span>'+data.list[i].ip+'</span><span>'+data.list[i].internal+'</span><span>'+data.list[i].external+'</span><span class="bor">'+data.list[i].protocol+'</span></div>'
				}
			}
			$("#upnpList").html(linkbuff);
			$("#upnpList .upnphead").after(buff);
		},
		error:function(msg){

		}});

}
function getData_Plug_info(){
	$.ajax({
	type: 'get',
	url: '/goform/get_plugins_cfg',
	data: {"type":"getmarketcfg"},
	dataType:"json",
	success: function(msg){
		if(msg==null||msg==""||msg==undefined){
		 return;
		}
		var data;
		if((typeof msg)=="object"){data=msg;}
		else{
			data=eval('('+msg+')');
		}
		if((data.fun & 0x01)==1){
			$("#FCYON").prop("checked",true);
		}else{
			$("#FCYOFF").prop("checked",true);
		}
	},
	error:function(msg){

	}})
}

function onformPlug(){
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_plugins_cfg',
	data: $("#Plugset").serialize(),
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		sleep(0);
	},
	error:function(msg){

	}})
}

function onformUpnp(){
	set_restore=1;
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_upnp_cfg',
	data: $("#UPNPset").serialize(),
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		sleep(0);
	},
	error:function(msg){

	}})
	setTimeout(function(){set_restore=0;},9000);
}
function MgetData_Dmz_info(){
    $.ajax({
        type: 'get',
        url: '/goform/get_dmz_cfg',
        data: {"type":"getdmz"},
        dataType:"json",
        success: function(msg){
            if(msg==null||msg==""||msg==undefined){
                return;
            }
            var data;
            if((typeof msg)=="object"){data=msg;}
            else{
                data=eval('('+msg+')');
            }
            if(data.enable==1){
                $("#DMZON").prop("checked",true);
                $("#mdz_ip").attr("disabled",false);
                $("#mdz_ip").removeClass("inpt-disabled");
            }else{
                $("#DMZOFF").prop("checked",true);
                $("#mdz_ip").attr("disabled",true);
                $("#mdz_ip").addClass("inpt-disabled");
                $("#mdz_ip_namelabel").css("display","none");
            }
            $("#mdz_ip").val(data.ip);
            if(data.port){
                $("#dmz_port").val(data.port);
            }
        },
        error:function(msg){

        }})
}
function getData_Dmz_info(){
	$.ajax({
	type: 'get',
	url: '/goform/get_dmz_cfg',
	data: {"type":"getdmz"},
	dataType:"json",
	success: function(msg){
		if(msg==null||msg==""||msg==undefined){
		 return;
		}
		var data;
		if((typeof msg)=="object"){data=msg;}
		else{
			data=eval('('+msg+')');
		}
		if(data.enable==1){
			$("#DMZON").prop("checked",true);
			$("#mdz_ip").attr("disabled",false);
			$("#mdz_ip").removeClass("inpt-disabled");
			$("#mdz_ip").focus();
		}else{
			$("#DMZOFF").prop("checked",true);
			$("#mdz_ip").attr("disabled",true);
			$("#mdz_ip").addClass("inpt-disabled");
			$("#mdz_ip_namelabel").css("display","none");
		}
		$("#mdz_ip").val(data.ip);
		$("#mdz_ip").focus();
		if(data.port){
			$("#dmz_port").val(data.port);
			$("#dmz_port").focus();
		}
	},
	error:function(msg){

	}})
}
function CheckDmz(){
	if($("#DMZOFF").prop("checked")){
		return true;
	}
	var ip=CheckIPaddress($("#mdz_ip").val());
	if(!ip){return false;}
	var host=window.location.host;
	if(host==$("#mdz_ip").val()){
		layer.msg(curlang.hostIP, {icon: 5});
		return false;
	}
	var port=CheckPort($("#dmz_port").val());
	if(!port){return false;}
	return true;
}
function onformDmz(){
	if(!CheckDmz()){
	return;
	}
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_dmz_cfg',
	dataType:"json",
	data: $("#DMZset").serialize(),
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		sleep(0);
	},
	error:function(msg){

	}})
}
$("#webAdminOff").click(function(){
    $("#webPortLi").hide();
    $("#webPort").attr("disabled",true);
})
$("#webAdminOn").click(function(){
    $("#webPortLi").show();
    $("#webPort").attr("disabled",false);
})
$("#webAdminApply").click(function(){
    onform_webAdmin();
})
function get_webAdmin(){
	$.ajax({
		type:"get",
		url:"/goform/get_remotemanage_info",
		data:{"type":"getwebremotemanage"},
		dataType:"json",
		success:function(data){
            if((typeof data)=="object"){var msg=data;}
            else{var msg=eval('('+data+')'); }
            if(msg.remotemanagesw=="1"){
                $("#webAdminOn").prop("checked",true);
                $("#webPortLi").show();
                $("#webPort").attr("disabled",false);
            }else{
                $("#webAdminOff").prop("checked",true);
                $("#webPortLi").hide();
                $("#webPort").attr("disabled",true);
            }
            if(msg.remoteport==""){
            	$("#webPort").val("8080");
			}else{
                $("#webPort").val(msg.remoteport);
			}
            $("#webPortLabel").hide();
		},
		error:function(msg){}
	})
}
function onform_webAdmin(){
	if($("#webAdminOn").prop("checked")){
		if(!CheckPort($("#webPort").val())){
            $("#webPort").focus();
			return;
		}
	}
	showanimation(1);
	$.ajax({
		type:"post",
		url:"/goform/set_remotemanage",
		data:$("#webadminForm").serialize(),
		dataType:"json",
		success:function(data){
            if((typeof data)=="object"){var msg=data;}
            else{var msg=eval('('+data+')'); }
            if(msg.result==0){
                showanimation(5);
			}else{
                showanimation(3);
			}
		},
		error:function(msg){
            showanimation(3);
		}
	})
}
function get_shared_info() {
    $.ajax({
        type: 'get',
        url: '/goform/get_sharewifi_switch',
        dataType:"json",
        data: {"type":"getsharewifiswitch"},
        success: function(data){
            if((typeof data)=="object"){var msg=data;}
            else{var msg=eval('('+data+')'); }
            if(msg.status=="1"){
                $("#sharedOff").prop("checked",true);
			}else{
                $("#sharedOn").prop("checked",true);
			}
            $("#sharedSSID").html(msg.sharewifissid);
        },
        error:function(msg){}
    })
}
function onform_shared() {
	var sharedMsg;
	if($("#sharedOff").prop("checked")==true){
        sharedMsg={"type":"setwifilimitinfo","status":"1"}
	}else{
        sharedMsg={"type":"setsharewifiswitch","status":"0"}
	}
    showanimation(1);
    $.ajax({
        type: 'post',
        url: '/goform/set_sharewifi_switch',
        dataType:"json",
        data: sharedMsg,
        success: function(data){
            if((typeof data)=="object"){var msg=data;}
            else{var msg=eval('('+data+')'); }
            if(msg.result==0){
				if(sharedMsg.status==1){
                    showanimation(4);
				}else{
                    showanimation(5);
				}
            }else if(msg.result==6){
                layer.msg(curlang.dns_result, {icon: 5});
            }else{
                showanimation(3);
            }
        },
        error:function(msg){
            showanimation(3);
        }
    })
}
function getData_Forwarding_info(){
		$.ajax({
		type: 'get',
		url:'/goform/get_forward_cfg',
		data: {"type":"getsampath"},
		dataType:"json",
		success: function(msg) {
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			var item="";
			$($("#Forwarding_li_first").siblings()).remove();
			if(!data.list || data.list==""){
				return;
			}
			for(var i=0;i<data.list.length;i++){
				item="<li style='margin:0px' id='ForwardingLi"+(data.list.length-i)+"'><input type='hidden' id='ForwardingProtocol"+(data.list.length-i)+"' value='"+data.list[i].protocol+"' /><span class='sp-l' style='width:60px'>"+(data.list.length-i)+"</span><span class='sp-l' id='ForwardingIP"+(data.list.length-i)+"' style='width:209px'>"+data.list[i].ip+"</span><span class='sp-l' id='ForwardingPort"+(data.list.length-i)+"' style='width:180px;'>"+data.list[i].port+"</span><span class='sp-l'  style='width:170px;text-align:center;'>"+data.list[i].protocol+"</span><span class='sp-r ForwardingBtn' id='rmForwarding"+(data.list.length-i)+"' style='width:120px;text-align:center;cursor:pointer;color:red;'>"+curlang.Remove+"</span></li>";
				$("#Forwarding_li_first").after(item);
			}
			$(".ForwardingBtn").click(function(){
				var number=$(this).attr('id').replace('rmForwarding','');
				onform_removeForwarding(number);
			})

		},
		error:function(msg){}
	})
}
function onform_removeForwarding(num){
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_forward_cfg',
	data: {"type":"setforwarding","ip":$("#ForwardingIP"+num).html(),"port":$("#ForwardingPort"+num).html(),"protocol":$("#ForwardingProtocol"+num).val(),"enable":0},
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		getData_Forwarding_info();
		sleep(0);
	},
	error:function(msg){

	}})
}
$(function(){
	$(".Forward_item").click(function(){
		$(this).addClass("on");
		$($(this).siblings()).removeClass("on");
		if($(this).attr('id')=="ForwardAdd"){
			$("#Forwarding_Item").css("display","block");
			$("#ForwardingList_Item").css("display","none");
		}else{
			$("#Forwarding_Item").css("display","none");
			$("#ForwardingList_Item").css("display","block");
			getData_Forwarding_info();
		}
})
})
function checkForwarding(){
	var ip=CheckIPaddress($("#ForwardingList_ip").val());
	if(!ip){return false;}
	var host=window.location.host;
	if(host==$("#ForwardingList_ip").val()){
		layer.msg(curlang.hostIP, {icon: 5});
		return false;
	}
	if($("#ForwardingList_startport").val()=="" && $("#ForwardingList_endport").val()!=""){
		$("#ForwardingList_startport").val($("#ForwardingList_endport").val());
	}
	var start=CheckPort($("#ForwardingList_startport").val());
	if(!start){return false;}
	var end=CheckPort($("#ForwardingList_endport").val());
	if(!end){return false;}
	if(parseInt($("#ForwardingList_startport").val()) > parseInt($("#ForwardingList_endport").val())){
		layer.msg(curlangs.porterror, {icon: 5});
		return false;
	}
	return true;
}
function onform_addForwarding(){
	if(!checkForwarding()){
		return;
	}
	var port=$("#ForwardingList_startport").val()+"-"+$("#ForwardingList_endport").val();
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_forward_cfg',
	data: {"type":"setforwarding","ip":$("#ForwardingList_ip").val(),"port":port,"protocol":$("#Forwarding_type").val(),"enable":1},
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		sleep(0);
	},
	error:function(msg){

	}})
}
function getData_Vserver_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_virtual_cfg',
		data: {"type":"getvserver"},
		dataType:"json",
		success: function(msg) {
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			var item="";
			$($("#Vserver_li_first").siblings()).remove();
			if(!data.list || data.list==""){
				return;
			}
			for(var i=0;i<data.list.length;i++){
				item="<li style='margin:0px;'><input type='hidden' id='vseverProtocol"+(data.list.length-i)+"' value='"+data.list[i].protocol+"'><span class='sp-l' style='width:60px'>"+(data.list.length-i)+"</span><span class='sp-l' id='vseverIp"+(data.list.length-i)+"' style='width:194px'>"+data.list[i].ip+"</span><span class='sp-l' id='vseverPu"+(data.list.length-i)+"' style='width:140px;'>"+data.list[i].pu_port+"</span><span class='sp-l' id='vseverPr"+(data.list.length-i)+"' style='width:140px'>"+data.list[i].pr_port+"</span><span class='sp-l'  style='width:115px;text-align:center;'>"+data.list[i].protocol+"</span><span class='sp-r VserverBtn' id='rmVserver"+(data.list.length-i)+"' style='cursor:pointer;width:90px;text-align:center;color:red;'>"+curlang.Remove+"</span></li>"
				$("#Vserver_li_first").after(item);
			}
			$(".VserverBtn").click(function(){
				var number=$(this).attr('id').replace('rmVserver','');
				onform_removeVserver(number);
			})

		},
		error:function(msg){}
	})
}
function onform_removeVserver(num){
	sleep(1);
	$.ajax({
	type: 'post',
	url:'/goform/set_virtual_cfg',
	data: {"type":"setvserver","ip":$("#vseverIp"+num).html(),"pu_port":$("#vseverPu"+num).html(),"pr_port":$("#vseverPr"+num).html(),"protocol":$("#vseverProtocol"+num).val(),"enable":0},
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		getData_Vserver_info();
		sleep(0);
	},
	error:function(msg){

	}})
}
$(function(){
	$(".Vserver_item").click(function(){
		$(this).addClass("on");
		$($(this).siblings()).removeClass("on");
		if($(this).attr('id')=="VserverAdd"){
			$("#VserverAdd_Item").css("display","block");
			$("#VserverList_Item").css("display","none");
		}else{
			$("#VserverAdd_Item").css("display","none");
			$("#VserverList_Item").css("display","block");
			getData_Vserver_info();
		}
})
})
function checkVserver(){
	var ip=CheckIPaddress($("#VserverAdd_ip").val());
	if(!ip){return false;}
	var host=window.location.host;
	if(host==$("#VserverAdd_ip").val()){
		layer.msg(curlang.hostIP, {icon: 5});
		return false;
	}
	var PU=CheckPort($("#VserverAdd_pu").val());
	var Pr=CheckPort($("#VserverAdd_pr").val());
	if(!Pr||!PU){return false;}
	return true;
}
function onform_addVserver(){
	if(!checkVserver()){
		return;
	}
	sleep(1);
	$.ajax({
	type: 'post',
	url: '/goform/set_virtual_cfg',
	data: $("#onform_VserverAdd").serialize(),
	dataType:"json",
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
		sleep(0);
	},
	error:function(msg){

	}})
}
function Get_routerBase_info(){
		$.ajax({
		type: 'get',
		url: '/goform/get_sysversion',
		dataType:"json",
		success: function(msg){
			if(msg==""||msg=="undefine"||msg==null){
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if((data.version).split('-')[4] == "D")
			var buf=(data.version).split('-')[4];
			if(buf=="D"){
				IsDouble=true;
			}else{
				IsDouble=false;
			}
		},
		error:function(msg){}
})
}
function showMorePage(){
	sleep(1);
	$.ajax({
	type: 'get',
	url: '/goform/get_fun_list',
	dataType:"json",
	success: function(msg){
		if(msg==""||msg=="undefine"||msg==null){
			layer.msg(curlang.sysinfo);
			return;
		}
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
		for(var i=0;i < data.list.length ;i++){
			$("#"+data.list[i].fun).parent("li").css("display","block");
		}
        //5g 无线设置单双屏
        if($("#more_5Gwifi").parent("li").css("display")=="none"){
            $("#wireless5g").hide();
        }else{
            $("#wireless5g").show();
        }
        //client模式下
        if($("#more_wifi").parent("li").css("display")=="none"){
            $("#wireless2g").hide();
        }else{
            $("#wireless2g").show();
        }
        if($("#wireless5g").css("display")=="none"&&$("#wireless2g").css("display")=="none"){
            $("#wireless").hide();
            $(".tab_title").css("width","33%");
        }
        /**
        //更多 显示隐藏
        var flagM=0,Mlen=$("#plugin").parents("ul").find("li");
        for(var j=0;j<Mlen.length;j++){
			if(Mlen.eq(j).css("display")=="none"){
                flagM=flagM+1;
			}
        }
        if(flagM==10){
            $("#moreSet").hide();
        }else{
            $("#moreSet").show();
        }
        //选项卡 显示隐藏
		var tab=0;
        for(var j=0;j<4;j++){
			if($(".tab_title").eq(j).css("display")=="none"){
                tab=tab+1;
			}
		}
        if(tab==1){
            $(".tab_title").css("width","33%");
        }else if(tab==2){
            $(".tab_title").css("width","50%");
        }**/
		sleep(0);
	},
	error:function(msg){
		layer.msg(curlang.sysinfo);
		sleep(0);
	}
})
}
function MshowMorePage(){
	//sleep(1);
	$.ajax({
		type: 'get',
		url: '/goform/get_mobile_fun_list',
		dataType:"json",
		success: function(msg){
			if(msg==""||msg=="undefine"||msg==null){
				layer.msg(curlang.sysinfo);
				return;
			}
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			for(var i=0;i < data.list.length ;i++){
				$("#"+data.list[i].fun).css("display","block");
				if(data.list[i].fun=="5G_wifi_set")
				{
					curVersion=true;
				}
			}
			// sleep(0);
		},
		error:function(msg){
			layer.msg(curlang.sysinfo);
			// sleep(0);
		}
	})
}
//获取2.4gwifi ssid 状态
function getFloatSSID(){
	$.ajax({
	type: 'get',
	url: '/goform/get_hidessid_cfg',
	data:{
		"type":"gethide2"
	},
	dataType:"json",
	success: function(msg){
		if(msg==""||msg=="undefine"||msg==null){
			return;
		}
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
		if(data.enable==1){
			$("#wifi_2gssidStatus").prop("checked",true);
		}else{
			$("#wifi_2gssidStatus").prop("checked",false);
		}
	},
	error:function(msg){
	}
})
}
//获取5gwifi ssid 状态
function getDoubleSSID(){
	$.ajax({
	type: 'get',
	url: '/goform/get_hidessid_cfg',
	data:{
		"type":"gethide5"
	},
	dataType:"json",
	success: function(msg){
		if(msg==""||msg=="undefine"||msg==null){
			return;
		}
		if((typeof msg)=="object"){var data=msg;}
		else{
			var data=eval('('+msg+')');
		}
		if(data.enable==1){
			$("#wifi_5gssidStatus").prop("checked",true);
		}else{
			$("#wifi_5gssidStatus").prop("checked",false);
		}
	},
	error:function(msg){
	}
})
}
//设置2.4gwifi ssid 状态
function onformFloatSSID(){
	var enable=0;
	if($("#wifi_2gssidStatus").prop("checked")){
		enable=1;
	}
	$.ajax({
	type: 'post',
	url: '/goform/set_hidessid_cfg',
	dataType:"json",
	data:{
		"type":"sethide2",
		"enable":enable
	},
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
	},
	error:function(msg){

	}})
}
//设置5gwifi ssid 状态
function onformDoubleSSID(){
	var enable=0;
	if($("#wifi_5gssidStatus").prop("checked")){
		enable=1;
	}
	$.ajax({
	type: 'post',
	url: '/goform/set_hidessid_cfg',
	dataType:"json",
	data:{
		"type":"sethide5",
		"enable":enable
	},
	success: function(data){
		if((typeof data)=="object"){var msg=data;}
		else{var msg=eval('('+data+')'); }
		if(msg.result==0){
				layer.msg(curlang.info2, {icon: 6});
		}else if(msg.result==6){
			layer.msg(curlang.ac_result, {icon: 5});
		}else{
			layer.msg(curlang.info3, {icon: 5});
		}
	},
	error:function(msg){

	}})
}
//状态查询
function getweblink(){
	function getlinkmsg(){
		$.ajax({
		type: 'get',
		url: '/goform/get_lang_cfg',
		dataType:"json",
		success: function(msg) {
			window.location="../login.asp";
		},
		error:function(msg)
		{
		}
		})
	}
	setInterval(getlinkmsg,2000);
}
function getLoginStatus(){
	if(set_restore == 0)
	{
		$.ajax({
		type: 'get',
		url: '/goform/webheartbeat',
		timeout: 5000,
		dataType:"json",
		success: function(msg) {
			if((typeof msg)=="object"){var data=msg;}
			else{
				var data=eval('('+msg+')');
			}
			if(data.result==8){
				window.location="../login.asp";
			}else{}
		},
		error:function(msg)
		{
			getweblink();
		}
	})
	}
}

