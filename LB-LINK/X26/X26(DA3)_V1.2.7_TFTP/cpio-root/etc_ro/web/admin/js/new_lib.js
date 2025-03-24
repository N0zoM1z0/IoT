//Point Class
function Point(x, y) {
    this.x = x;
    this.y = y;
}

//��ȡһ��ҳ��Ԫ�صľ�������
function getPosition(obj) {
    var p = new Point(0, 0);
    while (obj) {
        p.x = p.x + obj.offsetLeft;
        p.y = p.y + obj.offsetTop;
        obj = obj.offsetParent;
    }
    return p;
}

//��Ϣ��
if (!igd) {
    var igd = new Object();
}
igd.msgbox = function (id, msg) {
    this.id = id;
    this.msg = msg;
    this.state = "INIT";
    igd.msgbox.prototype.show = function () {
        this.state = "SHOW";
    }
    igd.msgbox.prototype.hide = function () {
        this.state = "HIDE";
    }

};

//MessageBox Class
function MessageBox(msg, position, errorId) {
    this.msg = msg || null;
    this.position = position || null;
    this.type = window.location.href.indexOf("mobile") > -1 ? true : false;
    this.error = errorId || null;
    if (typeof MessageBox._initialized == "undefined") {

        if (!this.type) {

            MessageBox.prototype.Obj = document.createElement("div");
            MessageBox.prototype.Obj.id = "_MessageBox_";
            MessageBox.prototype.Obj.className = "MessageBox";
            MessageBox.prototype.Obj.appendChild(document.createElement("div"));
            MessageBox.prototype.Obj.firstChild.className = "MessageBox_div";
            MessageBox.prototype.Show = MessageBox.prototype.showMsg;


            MessageBox.prototype.Hide = function () {
                this.Obj.style.visibility = "hidden";
            }
        }
        else {
            MessageBox.prototype.error = errorId;
            MessageBox.prototype.Show = MessageBox.prototype.showErrMsg;
            MessageBox.prototype.Hide = MessageBox.prototype.hideErrMsg;
        }
        MessageBox._initialized = true;
    }

}
MessageBox.prototype.showMsg = function (_msg, _position) {
    var obj = this.Obj;
    obj.style.visibility = "visible";

    if (_msg)
        obj.firstChild.innerHTML = _msg;
    else
        obj.firstChild.innerHTML = this.msg;

    if (_position) {
        obj.style.left = (_position.x) + "px";
        obj.style.top = (_position.y) + "px";
    }
    else {
        obj.style.left = (this.position.x) + "px";
        obj.style.top = (this.position.y) + "px";
    }
    document.body.appendChild(this.Obj);
    $(obj).height($(this.Obj.firstChild).height() + 22);
};
MessageBox.prototype.showErrMsg = function () {
    var me = this;
    $(".error-msg").html(me.msg).css("visibility", "visible");
    if (typeof me.error == "string") {
        $("#" + me.error).addClass("err-line");
    }
    else {
        for (var i = 0; i < me.error.length; i++) {
            $("#" + me.error[i]).addClass("err-line");
        }
    }
//                setTimeout(function () {
//                    $('.error-msg').html("").css('visibility', 'hidden');
//                    $(".err-line").removeClass('err-line');
//                }, 2000);
};
MessageBox.prototype.hideErrMsg = function () {
    $(".error-msg").html("").css("visibility", "hidden");
    $(".err-line").removeClass("err-line");
};

function hide_msgbox() {
    var msgbox = new MessageBox();
    if (msgbox) {
        msgbox.Hide();
    }
}

//browser
var browser = {
    versions: function () {
        var u = navigator.userAgent, app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1, //IE�ں�
            presto: u.indexOf('Presto') > -1, //opera�ں�
            webKit: u.indexOf('AppleWebKit') > -1, //ƻ�����ȸ��ں�
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//����ں�
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //�Ƿ�Ϊ�ƶ��ն�
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios�ն�
            android: u.indexOf('Android') > -1, //android�ն�
            iPhone: u.indexOf('iPhone') > -1, //�Ƿ�ΪiPhone����QQHD�����
            iPad: u.indexOf('iPad') > -1, //�Ƿ�iPad
            webApp: u.indexOf('Safari') == -1, //�Ƿ�webӦ�ó���û��ͷ����ײ�
            symbian: u.indexOf('Symbian') > -1, //symbian
            mac: u.indexOf('Mac OS X') > -1, //Mac OS X
            linux: u.indexOf('Linux') > -1 //Linux
        };
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
};
//collect user fov info ========== start ============
var user_fov_info = {
    ua:null,
    sendInfo:function(idNo){
        var me = this;
        $.post("/app/dot_data_app/webs/dd_count.cgi",{id:idNo,brower:me.ua});
    },
    uaInfo:function(){
        var me =this;
        var u = window.navigator.userAgent;
        var idNo= window.location.href.indexOf("mobile")>-1?"3027":"3028";
        var uaName = function(){
            var name;
            u.indexOf('Trident') > -1 && (name="Trident");
            u.indexOf('Presto') > -1 && (name="Presto");
            u.indexOf('AppleWebKit') > -1 && (name="AppleWebKit");
            u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1 && (name="Gecko");
            return name;
        };
        me.ua=uaName();
        me.sendInfo(idNo);
    },
    appInfo:function(idNo){
        var me = this;
        me.sendInfo(idNo);
    }
};
//collect user fov info ========== end ============
function check_input(key, min, max) {
    var page_map = reg_map[key];
    for (var i in page_map) {
        var _input = document.getElementById(page_map[i].id);
        if (_input) {
            var point_xy = getPosition(_input);
            point_xy.x += _input.clientWidth + 10;
            if (_input.nodeName.toLowerCase() == "select")
                point_xy.y -= 20;
            else
                point_xy.y -= _input.clientHeight;

            //tmp add
            if (_input.className.indexOf("txt_prevalue") != -1) {
                //�ܱ���Ϊ����
                var tmp_pre_data;
                if (_input.id == "wirel_answer") {
                    tmp_pre_data = pre_data[current_html][page_map[i].id][$("#question_sel").val()];
                }
                else {
                    if (quick_setup_html == 'quick_setup') {
                        tmp_pre_data = pre_data[quick_setup_html][page_map[i].id];
                    }
                    else {
                        tmp_pre_data = pre_data[current_html][page_map[i].id];
                    }
                }
                if (_input.value == tmp_pre_data) {
                    if (page_map[i].type.indexOf("noneed") != -1) {
                        return true;
                    }
                    else {
                        var msgbox = new MessageBox(L.need_data, point_xy);
                        msgbox.Show();
                        return false;
                    }
                }

            }
            /////////////////////////
            var reg_val = _input.value;
            /* �Ͱ汾��������֤value�Ƿ���placehoder��ͬ */
            var holder = _input.getAttribute('placeholder');
            if (reg_val && holder && reg_val === holder) {
                reg_val = '';
            }
            if (reg_val == '') {
                if (page_map[i].type.indexOf("noneed") != -1) {
                    continue;
                }
            }
            var types = page_map[i].type.split(' ');
            for (var p in types) {
                if (types[p] == "noneed")
                    continue;
                var reg_type = types[p];
                var res = check_map[reg_type](reg_val);
                //---------- add �洢���� Ǩ��Ӧ�÷����õ�
                if (arguments.length === 3 && _input.id === "def_new_size" && current_html === "store_manage") {
                    res = check_map[reg_type](reg_val, min, max);
                }
                //-----------res Ϊ�ַ�������bool
                if (res == true) {
                    if(current_html === "store_manage"){
                        var fs_type = _input.getAttribute("data-fs_type");
                        res = CheckLength(_input,fs_type);
                    }else{
                        res = CheckLength(_input);
                    }
                }
                if (res != true) {
                    var  msgbox  = new MessageBox(res, point_xy,page_map[i].id);
                    msgbox.Show();
                    return false;
                }
            }
        }
    }
    return true;
}

function CheckLength(strTemp,fs_type) {
    var i, sum, count;
    count = strTemp.value.length;
    sum = 0;

    for (i = 0; i < count; i++) {
        if ((strTemp.value.charCodeAt(i) >= 0) && (strTemp.value.charCodeAt(i) <= 255)) {
            sum = sum + 1;
        }
        else{
            if(fs_type && fs_type == "3"){//��̨gb2312����
                sum = sum + 2;
            }else{
                sum = sum + 3;
            }
        }


        if (sum > strTemp.maxLength) {
            var v = strTemp.value.substring(0, i);
            strTemp.value = v;
            return L.exceed_max;
        }
    }
    return true;
}

function get_msgbox(id, type) {
    var _input;
    if (typeof(id) == "object") {
        _input = id;
    }
    else {
        _input = document.getElementById(id);
    }
    if (_input == null)
        return;
    var point_xy = getPosition(_input);
    point_xy.x += _input.clientWidth + 10;
    if (_input.nodeName.toLowerCase() == "select")
        point_xy.y -= 20;
    else
        point_xy.y -= _input.clientHeight;
    var reg_val = _input.value;
    var types = type.split(' ');

    for (var p in types) {
        if (types[p] == "noneed")
            continue;
        var reg_type = types[p];
        var res = check_map[reg_type](reg_val);
        if (res == true)res = CheckLength(_input);
        if (res != true) {
            var msgbox = new MessageBox(res, point_xy);
            msgbox.Show();
            return false;
        }
    }
    return true;
}

function check_pwd_differ(val1, val2) {
    var ss;
    if (val2 == "") {
        ss = L.comfirm_pwd;
        return ss;
    }
    else {
        if (val1 != val2) {
            ss = L.pwd_differ;
            return ss;
        }
        else
            return true;
    }
}
function check_ip_ip2_mask(ip, ipgw, mask) {

    var ipArray = ip.split(".");
    var lanIpArray = ROUTE_INFO.lan_ip.split(".");
    var ipgwArray = ipgw.split(".");
    var maskArray = mask.split(".");
    var andIp = "";
    if (ip == ipgw) {
        return L.ip_getway_not_same;
    }
    if (!getIsSameSegment(ipArray, ipgwArray, maskArray)) {
        return L.ip_default_getway_in_same_segment;
    }
    if (getIsSameSegment(lanIpArray, ipgwArray, maskArray)) {
        return L.out_ip_in_ip_same_segment;
    }
    return true;

}

function show_differ_tip(return_str, id) {
    var ctr_obj = document.getElementById(id);
    var point_xy = getPosition(ctr_obj);
    point_xy.x += ctr_obj.clientWidth + 5;
    point_xy.y -= ctr_obj.clientHeight;
    var msgbox = new MessageBox(return_str, point_xy);
    msgbox.Show();
}
function show_same_tip(return_str, id) {
    var ctr_obj = document.getElementById(id);
    var point_xy = getPosition(ctr_obj);
    point_xy.x += ctr_obj.clientWidth + 5;
    point_xy.y -= ctr_obj.clientHeight;
    var msgbox = new MessageBox(return_str, point_xy);
    msgbox.Show();
}

var reg_map = {
    i_wired_frm: [],
    quick_wired_frm: [],
    i_wireless_frm: [
        {id: "ssid", type: "string"}/*,
         {id:"wirel_key",type:"password eq8_63"}	*/
    ],
    login_frm: [
        {id: "login_pwd", type: "password"}
    ],
    host_name: [
        {id: "w_name_modify", type: "string"}
    ],
    wireless_base_2_4_frm: [
        {id: "wire_2_4_ssid", type: "string"}
    ],
	wireless_base_5_frm: [
        {id: "wire_5_ssid", type: "string"}
    ],
	wireless_advance_frm: [
        {id: "wireless_fragment", type: "fragment"},
        {id: "wireless_RTSThreshold", type: "RTSThreshold"}
    ],
	boa_deny_ip_frm:[
		{id: "deny_ip", type: "ip"}
	],
    user_pwd_frm: [
        {id: "igd_webs_old_password", type: "password"},
        {id: "igd_webs_password1", type: "password eq8_31"},
        {id: "igd_webs_password2", type: "password eq8_31"}
    ],
    system_time_frm: [
        {id: "system_year", type: "year"},
        {id: "system_month", type: "mounth"},
        {id: "system_day", type: "day"},
        {id: "system_hour", type: "hour"},
        {id: "system_minute", type: "minute"},
        {id: "system_second", type: "second"}
    ],
    wan_dhcp_form: [
		{id: "wan_setup_mtu1", type: "mtu"},
        {id: "wan_setup_mac1", type: "mac"},
        {id: "wan_setup_dns11", type: "dns noneed"},
        {id: "wan_setup_dns12", type: "dns noneed"}
    ],
    wan_static_form: [
        {id: "wan_setup_ip2", type: "ip"},
        {id: "wan_setup_mask2", type: "mask"},
        {id: "wan_setup_gw2", type: "getway"},
        {id: "wan_setup_mac2", type: "mac"},
		{id: "wan_setup_mtu2", type: "mtu"},
        {id: "wan_setup_dns21", type: "dns"},
        {id: "wan_setup_dns22", type: "dns noneed"}
    ],
    wan_pppoe_form: [
        {id: "wan_setup_user0", type: "pppoe_string"},
        {id: "wan_setup_pass0", type: "password_blank"},
        {id: "wan_setup_mac0", type: "mac"},
		{id: "wan_setup_mtu0", type: "pppoe_mtu"},
        {id: "wan_setup_out_time0", type: "pppoe_out_time"},
        {id: "server_name0", type: "string_blank noneed"},
        {id: "ac_name0", type: "string_blank noneed"},
        {id: "wan_setup_dns01", type: "dns noneed"},
        {id: "wan_setup_dns02", type: "dns noneed"}
    ],
    wan_dhcp_form_advance: [
        {id: "wan_setup_mtu1", type: "mtu"},
        {id: "wan_setup_dns11", type: "dns noneed"},
        {id: "wan_setup_dns12", type: "dns noneed"}
    ],
    wan_static_form_advance: [
        {id: "wan_setup_mtu2", type: "mtu"}
    ],
    wan_static_advance: [],
    wan_pppoe_form_advance: [
        {id: "wan_setup_mtu0", type: "pppoe_mtu"},
        {id: "server_name0", type: "string_blank noneed"},
        {id: "ac_name0", type: "string_blank noneed"},
        {id: "wan_setup_dns01", type: "dns noneed"},
        {id: "wan_setup_dns02", type: "dns noneed"}
    ],
    lan_setup_frm: [
        {id: "lan_ip_address", type: "nin_wan_ip"},
        {id: "lan_sub_mask", type: "mask"}
    ],
	dhcp_addr_frm:[
		{id: "dhcp_addr_mac", type: "mac"},
        {id: "dhcp_addr_ip", type: "ip"}
	],
    timed_reboot_form: [
        {id: "hour", type: "hour"},
        {id: "minute", type: "minute"}
    ],
    g_time_segment: [
        {id: "g_start_hour", type: "hour"},
        {id: "g_start_min", type: "minute"},
        {id: "g_end_hour", type: "hour"},
        {id: "g_end_min", type: "minute"}
    ],
    lan_host: [
        {id: "lan_filter_ip", type: "ip"}
    ],
    lan_sub_host: [
        {id: "lan_filter_ip", type: "ip"},
        {id: "lan_filter_mask", type: "mask"}
    ],
    lan_ip_host: [
        {id: "lan_filter_ip", type: "ip"},
        {id: "lan_filter_mask", type: "ip"}
    ],
    net_auth_frm: [
        {id: "user", type: "string"},
        {id: "pass", type: "password"}
    ],
    noneed: []
}

var check_map = {
    "int": check_int,
    decimal: check_decimal,
    string: check_string,
    string_blank: check_string_blank,
	pppoe_string:check_pppoe_string,
    int_letter: check_int_letter,
    password: check_password,
    password_blank: check_password_blank,
    ip: check_ip,
    getway: check_getway,
    lan_ip: check_lan_ip,
    nin_wan_ip: check_nin_wan_ip,
    dns: check_dns,
    port: check_port,
    mask: check_mask,
    mac: check_mac,
    mtu: check_mtu,
    pppoe_mtu: check_pppoe_mtu,
    pptp_l2tp_mtu: check_pptp_l2tp_mtu,
    pppoe_out_time: check_pppoe_out_time,
    year: check_year,
    mounth: check_month,
    day: check_day,
    hour: check_hour,
    minute: check_min,
    second: check_sec,
    calendar: check_calendar,
    url: check_url,
    ip_url: check_ip_url,
	fragment: check_fragment,
	RTSThreshold: check_RTSThreshold,
    eq5: check_eq5,
    eq4_20: check_eq4_20,
    eq6_20: check_eq6_20,
    eq8_63: check_eq8_63,
    eq8_30: check_eq8_30,
	eq8_31: check_eq8_31,
    between_the_two: check_between_the_two,
    noneed: null
}
//��������������ĳ��Χ��
function check_between_the_two(ipt_str, min, max) {
    var ss = L.not_in + "(" + min + "---" + max + ")"+ L.range + L.within +"��"+ L.re_enter;
    if (parseFloat(ipt_str) < parseFloat(min) || parseFloat(ipt_str) > parseFloat(max)) {
        return ss;
    }
    return true;
}

//�������
function check_int(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    return true;
}

//���С��
function check_decimal(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_decimal;
        return ss;
    }
    var cmp = '0123456789.';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_decimal_char;
            return ss;
        }
    }
    if (str.split(".")[0] == '' || str.split(".").length > 2 || str.split(".")[1] == '') {
        var ss = L.digital_format_incorrect;
        return ss;
    }
    return true;
}

function check_string(str) {//����
    if (str == "" || str == null) {
        var ss = L.non_null_string;
        return ss;
    }
    var cmp = '\\\'"<>';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp;
            return ss;
        }
    }
    return true;
}

function check_string_blank(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_string;
        return ss;
    }
    var cmp = '\\\'"<> ';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp + L.and + L.blank;
            return ss;
        }
    }
    return true;
}

function check_pppoe_string(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_string;
        return ss;
    }
    var cmp = '\'"<> ';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp + L.and + L.blank;
            return ss;
        }
		/*if (tst.charCodeAt(0) < 0 || tst.charCodeAt(0) > 255) {
            var ss = L.not_chinese;
            return ss;
        }*/
    }
    return true;
}

function check_int_letter(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_string;
        return ss;
    }
    var cmp = '0123456789abcdefghijklmnopqrstuvwxyz' + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_alphanumeric_char;
            return ss;
        }
    }
    return true;
}

function check_password(str) {
    if (str == "" || str == null) {
        var ss = L.pwd_not_empty;
        return ss;
    }
    var cmp = '\\\'"<>';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp;
            return ss;
        }
        if (tst.charCodeAt(0) < 0 || tst.charCodeAt(0) > 255) {
            var ss = L.not_chinese;
            return ss;
        }
    }
    return true;
}

function check_password_blank(str) {
    if (str == "" || str == null) {
        var ss = L.pwd_not_empty;
        return ss;
    }
    var cmp = '\\\'"<> ';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp + L.and + L.blank;
            return ss;
        }
        if (tst.charCodeAt(0) < 0 || tst.charCodeAt(0) > 255) {
            var ss = L.not_chinese;
            return ss;
        }
    }
    return true;
}

function check_ip_url(str) {
    var flg = 0;
    if (str == "") {
        var ss = L.server_addr_not_null;
        return ss;
    }
    for (var h = 0; h < str.length; h++) {
        cmp = "0123456789.";
        var tst = str.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            flg++;
        }
    }
    if (flg != 0) {//url
        var ss = check_url(str);
        if (ss != true)
            return ss;
    }
    else {//ip
        var ss = check_ip(str);
        if (ss != true)
            return ss;
    }
    return true;
}
function check_ip(str) {
    return check_ip_come(str, true);
}

function check_lan_ip(str) {
    return check_ip_come(str, false);
}

//���ip�Ϸ���
function check_ip_come(str, check_lan_ip_b) {
    var flg = 0;
    if (str == "") {
        var ss = L.ip_not_null;
        return ss;
    }
    for (var h = 0; h < str.length; h++) {
        cmp = "0123456789.";
        var tst = str.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            flg++;
        }
    }
    if (flg != 0) {
        var ss = L.ip_num + "," + L.discover + flg + L.piece + L.illegal_char;
        return ss;
    }
    var str2 = str.split(".");
    if (str2.length != 4) {
        var ss = L.ip_incorrect_len;
        return ss;
    }
    for (var h = 0; h < str2.length; h++) {
        if (str2[h] == "") {
            var ss = L.the + (h + 1) + L.section + L.ip_val_not_null;
            return ss;
        }
		if (str2[h].length > 3) {
            var ss = L.the + (h + 1) + L.section + L.ip_incorrect_len;
            return ss;
        }
        if (str2[h] > 255 || str2[h] < 0) {
            var ss = L.the + (h + 1) + L.section + L.ip_range;
            return ss;
        }
    }
    if (str2[0] == 0) {
        var ss = L.firsr_section_not_zero;
        return ss;
    }
    if (str2[3] == "0") {
        var ss = L.four_section_not_zero
        return ss;
    }
    if (str2[0] == 1 && str2[1] == 0 && str2[2] == 0 && str2[3] == 0) {
        var ss = L.ip_incorrect;
        return ss;
    }
    if (str2[0] == 255 && str2[1] == 255 && str2[2] == 255 && str2[3] == 255) {
        var ss = L.ip_incorrect;
        return ss;
    }
    if (str2[0] == 127) {
        var ss = L.not_loopback_addr;
        return ss;
    }
    if (str2[0] >= 224 && str2[0] <= 239) {
        var ss = L.not_multicast_addr;
        return ss;
    }
    if (str2[0] >= 240) {
        var ss = L.ip_reserve_addr;
        return ss;
    }
    if (check_lan_ip_b) {
        if (str == ROUTE_INFO.lan_ip) {
            var ss = L.not_lan_ip_addr;
            return ss;
        }
    }
    if (str == ROUTE_INFO.lan_mask) {
        var ss = L.not_lan_mask_addr;
        return ss;
    }
    var lanIpArray = ROUTE_INFO.lan_ip.split(".");
    var maskArray = ROUTE_INFO.lan_mask.split(".");
    var andIp255 = "", andIp0 = "";
    for (var i = 0; i < 4; i++) {
        var ipItem = (lanIpArray[i] * 1) & (maskArray[i] * 1);
        andIp255 += ipItem ? ipItem : 255;
        andIp0 += ipItem;
        if (i != 3) {
            andIp0 += ".";
            andIp255 += ".";
        }
    }
    if (str == andIp255) {

        var ss = L.ip_broadcast_addr;
        return ss;
    }
    if (str == andIp0) {
        var ss = L.ip_network_addr;
        return ss;
    }
    return true;
}


//���ip�Ϸ���
function check_ip_basic(str) {
    var flg = 0;
    if (str == "") {
        var ss = L.ip_not_null;
        return ss;
    }
    for (var h = 0; h < str.length; h++) {
        cmp = "0123456789.";
        var tst = str.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            flg++;
        }
    }
    if (flg != 0) {
        var ss = L.ip_num + "," + L.discover + flg + L.piece + L.illegal_char;
        return ss;
    }
    var str2 = str.split(".");
    if (str2.length != 4) {
        var ss = L.ip_incorrect_len;
        return ss;
    }
    for (var h = 0; h < str2.length; h++) {
        if (str2[h] == "") {
            var ss = L.the + (h + 1) + L.section + L.ip_val_not_null;
            return ss;
        }
		if (str2[h].length > 3) {
            var ss = L.the + (h + 1) + L.section + L.ip_incorrect_len;
            return ss;
        }
        if (str2[h] > 255 || str2[h] < 0) {
            var ss = L.the + (h + 1) + L.section + L.ip_range;
            return ss;
        }
    }
    return true;
}

//���getway�Ϸ���
function check_getway(str) {
    var flg = 0;
    if (str == "") {
        var ss = L.getway_not_null;
        return ss;
    }
    for (var h = 0; h < str.length; h++) {
        cmp = "0123456789.";
        var tst = str.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            flg++;
        }
    }
    if (flg != 0) {
        var ss = L.getway_num + "," + L.discover + flg + L.piece + L.illegal_char;
        return ss;
    }
    var str2 = str.split(".");
    if (str2.length != 4) {
        var ss = L.getway_incorrect_len;
        return ss;
    }
    for (var h = 0; h < str2.length; h++) {
        if (str2[h] == "") {
            var ss = L.the + (h + 1) + L.section + L.getway_val_not_null;
            return ss;
        }
        if (str2[h] > 255 || str2[h] < 0) {
            var ss = L.the + (h + 1) + L.section + L.getway_range;
            return ss;
        }
    }
    if (str2[0] == 0) {
        var ss = L.getway_firsr_section_not_zero;
        return ss;
    }
    if (str2[3] == "0") {
        var ss = L.getway_four_section_not_zero
        return ss;
    }
    if (str2[0] == 1 && str2[1] == 0 && str2[2] == 0 && str2[3] == 0) {
        var ss = L.getway_incorrect;
        return ss;
    }
    if (str2[0] == 255 && str2[1] == 255 && str2[2] == 255 && str2[3] == 255) {
        var ss = L.getway_incorrect;
        return ss;
    }
    if (str2[0] == 127) {
        var ss = L.getway_not_loopback_addr;
        return ss;
    }
    if (str2[0] >= 224 && str2[0] <= 239) {
        var ss = L.getway_not_multicast_addr;
        return ss;
    }
    if (str2[0] >= 240) {
        var ss = L.getway_reserve_addr;
        return ss;
    }
    if (str == ROUTE_INFO.lan_ip) {
        var ss = L.not_lan_getway_addr;
        return ss;
    }
    if (str == ROUTE_INFO.lan_mask) {
        var ss = L.getway_not_lan_mask_addr;
        return ss;
    }
    var lanIpArray = ROUTE_INFO.lan_ip.split(".");
    var maskArray = ROUTE_INFO.lan_mask.split(".");
    var andIp255 = "", andIp0 = "";
    for (var i = 0; i < 4; i++) {
        var ipItem = (lanIpArray[i] * 1) & (maskArray[i] * 1);
        andIp255 += ipItem ? ipItem : 255;
        andIp0 += ipItem;
        if (i != 3) {
            andIp0 += ".";
            andIp255 += ".";
        }
    }
    if (str == andIp255) {

        var ss = L.getway_broadcast_addr;
        return ss;
    }
    if (str == andIp0) {
        var ss = L.getway_network_addr;
        return ss;
    }
    return true;
}
//���dns�Ϸ���
function check_dns(str) {
    if (str == "") {
        var ss = L.dns_not_null;
        return ss;
    }
    var reg = /^(|((22[0-3])|(2[0-1]\d)|(1\d\d)|([1-9]\d)|[1-9])(\.((25[0-5])|(2[0-4]\d)|(1\d\d)|([1-9]\d)|\d)){3})$/;
    flag = reg.test(str);
    if (!flag) {
        var ss = L.dns_format_incorrect;
        return ss;
    }
    var str2 = str.split(".");
    if (str2[0] == 127 || str2[3] == 0) {
        var ss = L.dns_format_incorrect;
        return ss;
    }
    return true;
}

//���˿�
function check_port(str) {
    if (str == "" || str == null) {
        var ss = L.port_not_null;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.port_non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) > 65535 || parseInt(str, 10) < 1) {
        var ss = L.port_range;
        return ss;
    }
    return true;
}

//���mask�Ƿ�Ϸ�
function check_mask(str) {
    var strsub = str.split(".");
    if (str == "" || str == "0.0.0.0" || strsub.length != 4 || str == "255.255.255.255") {
        var ss = L.mask_err;
        return ss;
    }
	if(strsub[0] == 0)
		return L.mask_first_not_zero;
    for (var j = 0; j < strsub.length; j++) {
        strsub[j] = parseInt(strsub[j], 10);
        if (strsub[j] != 0 && strsub[j] != 128 && strsub[j] != 192 && strsub[j] != 224 && strsub[j] != 240 && strsub[j] != 248 &&
            strsub[j] != 252 && strsub[j] != 254 && strsub[j] != 255) {
            var ss = L.mask_err + L.s_in + L.the + (j + 1) + L.section;
            return ss;
        }
    }
    if (parseInt(strsub[0], 10) != 255 && parseInt(strsub[1], 10) != 0) {
        var ss = L.the + L.two + L.section + L.mask_format_err;
        return ss;
    }
    if (parseInt(strsub[1], 10) != 255 && parseInt(strsub[2], 10) != 0) {
        var ss = L.the + L.three + L.section + L.mask_format_err;
        return ss;
    }
    if (parseInt(strsub[2], 10) != 255 && parseInt(strsub[3], 10) != 0) {
        var ss = L.the + L.four + L.section + L.mask_format_err;
        return ss;
    }
    return true;
}

//���mac�Ƿ�Ϸ�
function check_mac(str) {
    var err_obj = new Object;
    err_obj.mac_addr_err = L.mac_err;
    if (str == "") {
        var ss = err_obj.mac_addr_err;
        return ss;
    }
    if (str == "00-00-00-00-00-00" || str == "00:00:00:00:00:00") {
        var ss = L.mac_not + "0";
        return ss;
    }
    var tmp_str = str.toUpperCase();
    if (tmp_str == "FF-FF-FF-FF-FF-FF" || tmp_str == "FF:FF:FF:FF:FF:FF") {
        var ss = L.mac_not + "F";
        return ss;
    }
    if (str.length != 17) {
        var ss = err_obj.mac_addr_err;
        return ss;
    }
    var pattern = "/^([0-9A-Fa-f]{2})(-[0-9A-Fa-f]{2}){5}|([0-9A-Fa-f]{2})(:[0-9A-Fa-f]{2}){5}/";
    eval("var pattern=" + pattern);
    var ck = pattern.test(str);
    if (ck == false) {
        var ss = err_obj.mac_addr_err;
        return ss;
    }
    if (str.substring(0, 2) == '01') {
        var ss = L.mac_broadcast_addr;
        return ss;
    }
    return true;
}

function check_mtu(str) {
    var ret = check_int(str);
    if (true != ret)
        return ret;
    if (parseInt(str, 10) > 1500 || parseInt(str, 10) < 576) {
        var ss = L.mtu_1500_576;
        return ss;
    }
    return true;
}

function check_pppoe_mtu(str) {
    var ret = check_int(str);
    if (true != ret)
        return ret;
    if (parseInt(str, 10) > 1480 || parseInt(str, 10) < 576) {
        var ss = L.mtu_1480_576;
        return ss;
    }
    return true;
}

function check_pptp_l2tp_mtu(str) {
    var ret = check_int(str);
    if (true != ret)
        return ret;
    if (parseInt(str, 10) > 1440 || parseInt(str, 10) < 576) {
        var ss = L.mtu_1440_576;
        return ss;
    }
    return true;
}

function check_pppoe_out_time(str) {
    var ss = check_int(str);
    if (ss != true)
        return ss;
    if (str < 1 || str > 30) {
        ss = L.pppoe_out_time_range;
        return ss;
    }
    return true;
}

function check_fragment(str){
	var ss = check_int(str);
    if (ss != true)
        return ss;
    if (str < 256 || str > 2346) {
        ss = L.fragment_out_range;
        return ss;
    }
    return true;
}
function check_RTSThreshold(str){
	var ss = check_int(str);
    if (ss != true)
        return ss;
    if (str < 256 || str > 2347) {
        ss = L.RTSThreshold_out_range;
        return ss;
    }
    return true;
}

function check_year(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) < 2008) {
        var ss = L.year_lt_2008;
        return ss;
    }
    return true;
}

function check_month(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) <= 0) {
        var ss = L.month_range;
        return ss;
    }
    else if (parseInt(str, 10) > 12) {
        var ss = L.month_range;
        return ss;
    }

    return true;
}

function check_day(str) {
    var solarMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    var y = get_ctrl_year();
    var month = get_ctrl_month();
    var day = "";
    if (month == 2) {
        day = (((y % 4 == 0) && (y % 100 != 0) || (y % 400 == 0)) ? 29 : 28);
    }
    else {
        month = month - 1;
        day = solarMonth[month];
    }
    if (parseInt(str, 10) <= 0) {
        var ss = L.day_range + day;
        return ss;
    }
    else if (parseInt(str, 10) > day) {
        var ss = L.day_range + day;
        return ss;
    }
    return true;
}

function get_ctrl_year() {
    var year;
    if (current_html == "system_time")
        year = $("#system_year").val();
    return year;
}

function get_ctrl_month() {
    var month;
    if (current_html == "system_time")
        month = $("#system_month").val();
    return month;
}

function check_hour(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) < 0) {
        var ss = L.hour_range;
        return ss;
    }
    else if (parseInt(str, 10) > 23) {
        var ss = L.hour_range;
        return ss;
    }
    return true;
}

function check_min(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) < 0) {
        var ss = L.minute_range;
        return ss;
    }
    else if (parseInt(str, 10) > 59) {
        var ss = L.minute_range;
        return ss;
    }
    return true;
}

function check_sec(str) {
    if (str == "" || str == null) {
        var ss = L.non_null_integer;
        return ss;
    }
    var cmp = '0123456789';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (cmp.indexOf(tst) < 0) {
            var ss = L.non_numeric_char;
            return ss;
        }
    }
    if (parseInt(str, 10) < 0) {
        var ss = L.second_range;
        return ss;
    }
    else if (parseInt(str, 10) > 59) {
        var ss = L.second_range;
        return ss;
    }
    return true;
}

//�������ڸ�ʽΪYYYY-MM-DD
function check_calendar(str) {
    if (str == "" || str == null) {
        var ss = L.calendar_not_null;
        return ss;
    }
    var parts;
    var msg = L.calendar_format_err;
    if (str.indexOf("-") > -1) {
        parts = str.split('-');
    } else {
        return msg;
    }
    if (parts.length < 3) {
        return msg;
    }
    for (i = 0; i < 3; i++) {
        if (isNaN(parseInt(parts[i], 10))) {
            return msg;
        }
    }
    var y = parseInt(parts[0], 10);
    var m = parseInt(parts[1], 10);
    var d = parseInt(parts[2], 10);
    if (y < 1900 || y > 3000) {
        var ss = L.year_err;
        return ss;
    }
    if (m < 1 || m > 12) {
        var ss = L.month_err;
        return ss;
    }
    var ss_msg = L.day_err;
    if (d < 1 || d > 31) {
        return ss_msg;
    }
    switch (d) {
        case 29:
            if (m == 2) {
                if ((y % 4 == 0) && (y % 100 != 0)) {
                    return true;
                }
                else if (y % 400 == 0) {
                    return true;
                }
                else
                    return ss_msg;
            }
            break;
        case 30:
            if (m == 2)
                return ss_msg;
            break;
        case 31:
            if (m == 2 || m == 4 || m == 6 || m == 9 || m == 11)
                return ss_msg;
            break;
        default:
            break;
    }
    return true;
}

function check_url(str) { //JK 20141210 ���Ż�
    if (str == "" || str == null) {
        var ss = L.url_not_null;
        return ss;
    }
    var cmp = '<>(),;+[]{} ';
    var buf = str;
    for (var h = 0; h < buf.length; h++) {
        var tst = buf.substring(h, h + 1);
        if (tst == ".") {
            var temp = buf.substring(h + 1, h + 2);
            if (temp == "." || h == buf.length - 1) {
                var ss = L.url_err;
                return ss;
            }
        }
        if (cmp.indexOf(tst) >= 0) {
            var ss = L.not_illegal_char + cmp + L.and + L.blank;
            return ss;
        }
        if (tst.charCodeAt(0) < 0 || tst.charCodeAt(0) > 255) {
            var ss = L.not_chinese;
            return ss;
        }
    }
    return true;
}

function check_eq5(str) {
    var ss = L.eq_5;
    if (str.length != 5)
        return ss;
    return true;
}

function check_eq4_20(str) {
    var ss = L.eq4_20;
    if (str.length < 4 || str.length > 20)
        return ss;
    return true;
}

function check_eq6_20(str) {
    var ss = L.eq6_20;
    if (str.length < 6 || str.length > 20)
        return ss;
    return true;
}

function check_eq8_63(str) {
    var ss = L.eq8_63;
    if (str.length < 8 || str.length > 63)
        return ss;
    return true;
}

function check_eq8_30(str) {
    var ss = L.eq8_30;
    if (str.length < 8 || str.length > 30)
        return ss;
    return true;
}
function check_eq8_31(str) {
    var ss = L.eq8_31;
    if (str.length < 8 || str.length > 31)
        return ss;
    return true;
}
function GetIP(ip_str) {
    var ip = "";
    var obj = {};
    var ip_arr = ip_str.split(".");
    for (var i = 0; i < ip_arr.length; i++) {
        obj["ip" + i] = parseInt(ip_arr[i], 10);
        ip += IP2Bin(obj["ip" + i])
    }
    return ip;
}
function IP2Bin(ip) {
    var strIP = ip.toString(2);
    var len = strIP.length;
    if (len < 8) {
        for (var i = 0; i < 8 - len; i++) {
            strIP = "0" + strIP;
        }
    }
    return strIP;
}
function check_ip_mask(ip, mask, ctr) {
    var index = 0;
    var mask_str = GetIP(mask);
    for (var i = 0; i < mask_str.length; i++) {
        if (mask_str.charAt(i) == "0") {
            index = i
            break;
        }
    }
    //
    var ip_str = "", ip_temp = "";
    ip_str = GetIP(ip);
    ip_temp = ip_str.substring(index, 32);
    //
    var cmp_str1 = "", cmp_str2 = "";
    for (var i = 0; i < ip_temp.length; i++) {
        cmp_str1 += "1";
        cmp_str2 += "0";
    }
    if (ip_temp == cmp_str1) {
        var ss = L.ip_broadcast_addr;
        return ss;
    }
    if (ip_temp == cmp_str2) {
        var ss = L.ip_network_addr;
        return ss;
    }
    return true;
}
function check_getway_mask(ip, mask, ctr) {
    var index = 0;
    var mask_str = GetIP(mask);
    for (var i = 0; i < mask_str.length; i++) {
        if (mask_str.charAt(i) == "0") {
            index = i
            break;
        }
    }
    //
    var ip_str = "", ip_temp = "";
    ip_str = GetIP(ip);
    ip_temp = ip_str.substring(index, 32);
    //
    var cmp_str1 = "", cmp_str2 = "";
    for (var i = 0; i < ip_temp.length; i++) {
        cmp_str1 += "1";
        cmp_str2 += "0";
    }
    if (ip_temp == cmp_str1) {
        var ss = L.getway_broadcast_addr;
        return ss;
    }
    if (ip_temp == cmp_str2) {
        var ss = L.getway_network_addr;
        return ss;
    }
    return true;
}


//===================message collect===============================
igd.ui = new Object();
igd.ui.form = new Object();
igd.ui.form.collect = function (id) {
    var c = new Object();
    var f = $("#" + id).get(0);
    var i = 0;
    var rank_key_obj={};
    for (i = 0; i < f.elements.length; i++) {
        var t = f.elements[i];
        if (f.elements[i].name != "") {
            //�ж��Ƿ�Ϊ�����ֶ�
            if (f.elements[i].getAttribute('data-aes') && f.elements[i].getAttribute('data-aes') == 'true') {
                if($.isEmptyObject(rank_key_obj)){
                    rank_key_obj=get_rand_key(0);
                }
                c[f.elements[i].name] = getAesString(f.elements[i].value,rank_key_obj);
            } else {
                c[f.elements[i].name] = f.elements[i].value;
            }
        }
    }
    return c;
};
//============================tab====================================

igd.ui.Tab = function(obj,func){
	this.elem = obj;
	this.func = func;
};

igd.ui.Tab.prototype.init = function(num){
	var me = this;
	var div_elems = $("#"+ me.elem.parent + " div");
	div_elems.unbind("click").bind("click",function(){
		div_elems.each(function(){
			$(this).removeClass("on");
		});
		$(this).addClass("on");
		var index = parseInt($(this).attr("data-type-index"));
		if(me.func){
			if(typeof me.func == "string"){
				if(me.func == "set_wan_link_work_mode"){
					eval(me.func).call(this,index);
				}
				else
					eval("(" + me.func + ")();");
			}
			else if(typeof me.func == "function"){
				me.func.call(this);
			}
		}
		$.each(me.elem.child,function(){
			$("#" + this.name).removeClass("section_show").addClass("section_hide");
		});
		if(me.elem.child.length != 0){
			$("#" + me.elem.child[index].name).removeClass("section_hide").addClass("section_show");
			if(me.elem.child[index].func != "")
				eval("(" + me.elem.child[index].func + ")();");
		}
	});
	if(num && me.elem.child.length != 0 && me.elem.child[num].func != ""){
		eval("(" + me.elem.child[num].func + ")();");
	}
	else{	
		if(me.elem.child.length != 0 && me.elem.child[0].func != "")
			eval("(" + me.elem.child[0].func + ")();");
	}
};

//=======================page related================================

function dataDeal(data) {
    //debug
    if ((typeof data) == "string" && data.toString().indexOf("360LoginFlag") != -1) {
        loginOut();
    }
    else {
        try {
            var tmp_data = eval("(" + data + ")");
            return tmp_data;
        }
        catch (e) {
            return false;
        }
    }
}

function init_language(html_name) {
    var html_map = language[language_type]["HTML"][html_name];
    for (var i in html_map) {
		if($("#" + i).is("img"))
			continue;
		else
        	$("#" + i).html(html_map[i]);
    }
    var btn_map = language[language_type]["BUTTON"];
	//input button & button
    $("input[type=submit],input[type=button],button").each(function () {
        var _class = $(this).attr("class");
        for (var i in btn_map) {
            if (_class == undefined)
                continue;
            if (_class.indexOf(i) > -1) {
				if($(this).is("button"))
					$(this).html(btn_map[i]);
				else
                	$(this).val(btn_map[i]);
                break;
            }

        }
    });
	 
    var select_map = language[language_type]["SELECT"];
    $("select").each(function () {
        var _id = $(this).attr("id");
        for (var i in select_map) {
            if (_id == i) {
                $(this).empty();
                for (var j in select_map[i]) {
                    $(this).append("<option value=\"" + select_map[i][j].value + "\">" + select_map[i][j].txt + "</option>");
                }
                break;
            }

        }
    });
	
	$("img").each(function(){
		var _alt = $(this).attr("alt");
		var _id = $(this).attr("id");
		if(_alt == "" && html_map != undefined && html_map[_id] != undefined){
			$(this).attr("alt",html_map[_id]);
		}
	});
}
/*================================ by houbingyang start �˵����� ================================ */
var current_html = null;
var load_finish_flag = false;
(function () {
    //��ȡtop�˵���
    var get_nav_return_a_fn = function () {
        var navHtml = $('<div class="nav"></div>');
        (function (menuObj, menuParentObj) {
            var ahtml;
            if (menuObj instanceof parent) {
                ahtml = $('<a href="javascript:void(0)"></a>');
                ahtml.on("click", function () {
                    menuObj.remove_child(menuObj.code);
                    window.history.go(-1);
                    //menuObj.initFn(menuObj.code, "init_" + menuObj.code)
                })
                var showText = menuObj.name + "&nbsp";
                if (menuObj.child instanceof parent) {
                    showText += ">";
                }
                ahtml.html(showText);
                navHtml.append(ahtml);
                arguments.callee(menuObj.child, menuObj);
            } else {
                var returnObj = menuParentObj.parent || menuParentObj;
                ahtml = $('<button class="return_a"></button>');
                ahtml.on("click", function () {
                    returnObj.remove_child(returnObj.code);
                    window.history.go(-1);
                    //returnObj.initFn(returnObj.code, "init_" + returnObj.code)
                })
                ahtml.html(L.s_return);
                navHtml.append(ahtml);
            }
        })(PAGE_INFO.menu_parent);
        return navHtml;
    };

    //����top�˵�ҳ
    var load_html = function (html_name, init_function) {
		//tmp add
		appBar.show(html_name);
		$('body').css("background","#F3F4F6");
        hide_msgbox();
        load_finish_flag = false;
        set_w_lock_div();
        current_html = html_name;
        //��Ӳ˵���
        PAGE_INFO.menu_parent = new parent(getJsonObject(igd.menu, "tab_id", html_name + "_tab").tab_title || igd.menu[html_name].title, html_name, arguments.callee);
        PAGE_INFO.current_html = html_name;
        var params = Array.prototype.slice.apply(arguments, [2, arguments.length]);
        $.ajax({
            type: "get",
            url: "./" + html_name + ".htm",
            dataType: "html",
            error: function (XMLHttpRequest, textStatus) {
                return;
            },
            success: function (ret) {
                if (ret.indexOf("360LoginFlag") != -1) {
                    loginOut();
                }
                else {
                    var _this = $("#container_wrap");
                    _this.html(ret);
                    init_language(html_name);
                    remove_w_lock_div();
                    if (init_function != null && init_function != "") {
                        try {
                            if (typeof(window[init_function]) == 'function') {
                                window[init_function].apply(null, params);
                            }
							if (typeof(init_function) == 'function') {
								init_function.call(this);
                            }
                            load_finish_flag = true;
							toolTipsBar.set();
                        }
                        catch (e) {
                        }
                    }
                }
            }
        });
    };

//���ر�ҳ  wifi�����������õ�
    var load_sub_html = function (html_name, init_function, return_html_name) {
		//tmp add
		appBar.show(html_name);
        hide_msgbox();
        current_html = html_name;
        //��Ӳ˵���
        if (PAGE_INFO.menu_parent == null) {
            PAGE_INFO.menu_parent = new parent(getJsonObject(igd.menu, "tab_id", return_html_name + "_tab").tab_title || igd.menu[return_html_name].title, return_html_name, arguments.callee);
        }
        PAGE_INFO.menu_parent.add_child(getJsonObject(igd.menu, "tab_id", html_name + "_tab").tab_title || igd.menu[html_name].title, html_name, arguments.callee);
        PAGE_INFO.current_html = html_name;

        $.ajax({
            type: "get",
            url: "./" + html_name + ".htm",
            dataType: "html",
            error: function (XMLHttpRequest, textStatus) {
                return;
            },
            success: function (ret) {
                if (ret.indexOf("360LoginFlag") != -1) {
                    loginOut();
                }
                else {
                    var containerWarp = $("#container_wrap");
                    if (return_html_name == "nav_setting") {
                        PAGE_INFO.tab_page_name = return_html_name;
                    }
                    var nav = get_nav_return_a_fn();
                    containerWarp.html(nav).append(ret);
					toolTipsBar.set();
                    init_language(html_name);
					fix_ie_shadow();
                    if (init_function != null && init_function != "") {
                        try {
                            eval(init_function + "();");
                        }
                        catch (e) {
                        }
                    }
                }
            }
        });
    };
    var jump_sub_html = function (html_name, init_function, return_html_name, parent_html_name) {
        $("#" + parent_html_name || return_html_name).addClass("current").siblings().removeClass("current");
        load_sub_html(html_name, init_function, return_html_name);

    };
    var load_app_html = function (appsign) {
		//tmp add
		appBar.show(appsign);
        hide_msgbox();
        $("#app_detail_area").css("padding", "15px 0 0 0;");
        var url = "../app/" + appsign + "/webs/index.html";
        $("#app_detail_area").html("");
		if($("#config_page").length > 0)
			$("#config_page").remove();
        var frm = $("<iframe />");
        frm.attr("id", "config_page");
        frm.attr("src", url);
        frm.attr("frameborder", "0");
        frm.attr("width", "100%");
        //frm.attr("scrolling","no");
        frm.attr("allowtransparency", true);
        frm.unbind("load").bind("load", function () {
            if (document.getElementById("config_page").contentWindow.document.body.innerHTML.toString().indexOf("NetcoreLoginFlag") != -1) {
                window.top.open("/", "_self");
                set_lock_size();
                return;
            }
            if (document.getElementById('config_page').contentWindow.nos != null) {
                document.getElementById('config_page').contentWindow.nos.app.resizePage();
				toolTipsBar.set();
            }
            //iFrameHeight();
            //app_web_height_loop();

            /*window.setTimeout(function(){
             iFrameHeight();
             },200);*/

        });
        $("#app_set").append(frm);
    };
    var paint_tab = function (index) {
        $(".tab_container").html("");
        var tab_items = [];
        if (PAGE_INFO.tab_page_name != undefined) {
            tab_items = igd.menu[PAGE_INFO.tab_page_name].submenu;
        }
        var tab_items_len = tab_items instanceof Array ? tab_items.length : 0;
        var tab_html_str = "";

        for (var k = 0; k < tab_items_len; k++) {
            //����tabͷ��Ϣ
            tab_html_str += "<div class='tab_item_container'><div class='tab_title'><h3>" + tab_items[k]["title"] + "</h3></div>";
            var submenu_itmes = tab_items[k]["submenu"];
            var submenu_len = submenu_itmes.length;
            if (submenu_len > 0) {
                tab_html_str += "<ul>"
            }
            for (var i = 0; i < submenu_len; i++) {
                var isEnd = (i + 1) % 3 == 0 ? "thirdend " : "";
                tab_html_str += "<li class='" + isEnd + submenu_itmes[i].tab_id + "'><div id='" + submenu_itmes[i].tab_id + "' class='ext-item'>" +
                "<div class='menu_text'>" + submenu_itmes[i].tab_title + "</div>" +
                "<div class='float_info'><div class='detail'>" + " <p class='wisp-info js-txt-wisp-status'></p></div></div> </div> </li>";
            }
            if (submenu_len > 0) {
                tab_html_str += "</ul>"
            }
            tab_html_str += "</div>"
        }
        $(".tab_container").append($(tab_html_str));
        $(".tab_container").undelegate(".ext-item", "click").delegate(".ext-item", "click", function () {
//            var $obj = $(".tab_container .float_info").removeClass("tab_selected");
//            $(this).find(".float_info").addClass("tab_selected");
            if ($(this).attr("id") != undefined) {
                var id = $(this).attr("id").split("_tab")[0];
                var newUrlToken = "#extitem" + "/";
                //��Ҫ����TABѡ����ڴ����
                newUrlToken += id + "/" + PAGE_INFO.tab_page_name;
                window.location.hash = newUrlToken;
            }
        });
        if (index) {
            $(".tab_container").find("a").eq(index).click();
        }
    };
    var applyToken = function (token) {
        return token.substr(0,1) == '#' ? token.substr(1) : token;
    }
    var detectStateChange = function () {
        var newUrlToken = applyToken(window.location.hash), menuObj = {
            type: "",
            id: "",
            parentId: ""
        }, urlTokenList;
        newUrlToken = newUrlToken || "menu/index_page";
        if (newUrlToken == PAGE_INFO.oldUrlToken) {
            return;
        }
        urlTokenList = newUrlToken.split("/");
        if (urlTokenList.length < 2) {
            return;
        }
        menuObj["type"] = urlTokenList[0];
        var id = menuObj["id"] = urlTokenList[1];
        var parentId = menuObj["parentId"] = urlTokenList[2];
        if($.isEmptyObject(getJsonObject(igd.menu, "tab_id", id + "_tab"))&& $.isEmptyObject(igd.menu[id])&&menuObj["type"]!="addonitem"){
            newUrlToken="menu/index_page";
            menuObj["type"] = "menu";
            id = menuObj["id"] = "index_page";
        }
		remove_w_lock_div();
        switch (menuObj["type"]) {
            case "menu":
                $("#sidebar_wrap").find("#" + id).addClass('current').siblings().removeClass('current');
                if (id == "nav_setting") {
                    PAGE_INFO.tab_page_name = id;
                    load_html(id, "paint_tab");
                }
                else {
                    load_html(id, "init_" + id);
                }
                break;
            case "extitem":
				$("#sidebar_wrap").find("#" + parentId).addClass('current').siblings().removeClass('current');
                load_sub_html(id, 'init_' + id, menuObj["parentId"]);
                break;
            case "addonitem":
				$("#sidebar_wrap").find("#nav_addon").addClass('current').siblings().removeClass('current');
                if (!ROUTE_INFO.is_touch_link) {
                    if (id == "touch_link") {
                        load_sub_html("touch_link", "init_touch_link", "nav_setting");
                    }
                    else{
						if($(".app_container").length == 0){
							load_html("nav_addon",function(){
								init_nav_addon(id);
							});
						}
						else
							show_app_detail(id);	
					}
                }
                else{
					if($(".app_container").length == 0){
						load_html("nav_addon",function(){
							init_nav_addon(id);
						});
					}
					else
						show_app_detail(id);
				}
                break;
            case "indexitem":
                if (window.location.href.toString().indexOf("app") != -1) {
					$("#sidebar_wrap").find("#index_page").addClass('current').siblings().removeClass('current');
					load_html("nav_addon",function(){
						init_nav_addon(id);
					});
					
                } else {
                    var return_html_name = "index_page";
                    var parent_html_name = "index_page";
					if(urlTokenList.length != 4)
                    	jump_sub_html(id, 'init_' + id, return_html_name, parent_html_name);
					else{
						if(urlTokenList[3] == "wireless_base" || urlTokenList[3] == "password"){
							$("#sidebar_wrap").find("#index_page").addClass('current').siblings().removeClass('current');
							if($("#app_section").length == 0){//use this if to detect refresh
								jump_sub_html(urlTokenList[3], 'init_' + urlTokenList[3], return_html_name, parent_html_name);
								PAGE_INFO.current_html = urlTokenList[3];
								PAGE_INFO.menu_parent.code = "index_page";
								PAGE_INFO.menu_parent.name = L.my_router;
								PAGE_INFO.menu_parent.remove_child(PAGE_INFO.menu_parent.code);
								PAGE_INFO.menu_parent.add_child(L.internet_security);
								PAGE_INFO.menu_parent.child.code = "nav_protection";
								if(urlTokenList[3] == "wireless_base")
									PAGE_INFO.menu_parent.add_child(L.wireless_menu_title);
								else if(urlTokenList[3] == "password")
									PAGE_INFO.menu_parent.add_child(L.password_menu_title);
								PAGE_INFO.menu_parent.child.child.code = urlTokenList[3];
								$("#container_wrap .nav").remove();
								$("#container_wrap").prepend(get_nav_return_a_fn());
							}
						}
						else{
							$("#sidebar_wrap").find("#index_page").addClass('current').siblings().removeClass('current');
							if($(".app_container").length == 0){//use this if to detect refresh
								load_html("nav_addon",function(){
									$("#app_intro").removeClass("section_show").addClass("section_hide");
									set_app_data(urlTokenList[3],"nav_protection");
									
									PAGE_INFO.current_html = 'nav_protection';
									PAGE_INFO.menu_parent.code = "index_page";
									PAGE_INFO.menu_parent.name = L.my_router;
									PAGE_INFO.menu_parent.remove_child(PAGE_INFO.menu_parent.code);
									PAGE_INFO.menu_parent.add_child(L.internet_security);
									PAGE_INFO.menu_parent.child.code = "nav_protection";
									PAGE_INFO.menu_parent.add_child(g_app_data[urlTokenList[3]].appname);
									$("#container_wrap .nav").remove();
									$("#container_wrap").prepend(get_nav_return_a_fn());
								});
							}
						}
					}
					
                }
                break;
            default :
                break
        }
    }
    var init_menu = function () {
        $("#sidebar_wrap li").unbind("click").bind("click", function () {
            var self = $(this),
                id = self.attr('id');
            var appIdNo = self.attr("data-us-fov-count");
            self.addClass('current').siblings().removeClass('current');
            var newUrlToken = "#menu" + "/";
            //��Ҫ����TABѡ����ڴ����
            newUrlToken += id;
            window.location.hash = newUrlToken;
            user_fov_info.appInfo(appIdNo);
        });
        $(window).on("hashchange",detectStateChange);
        /*if (PAGE_INFO.oldUrlToken == "") {
            setTimeout(detectStateChange, 100);
        }*/
    };

    var menu_load = function (id) {
        $("#" + id).click();
    };
    window.load_html = load_html;
    window.load_sub_html = load_sub_html;
    window.load_app_html = load_app_html;
    window.get_nav_return_a_fn = get_nav_return_a_fn;
    window.paint_tab = paint_tab;
    window.init_menu = init_menu;
    window.detectStateChange = detectStateChange;
    window.menu_load = menu_load;
    window.jump_sub_html = jump_sub_html;
})();
/*================================ by houbingyang end �˵����� ================================ */

function app_web_height_loop() {
    if (app_web_height_timer)
        window.clearInterval(app_web_height_timer);
    app_web_height_timer = window.setInterval(function () {
        if (current_html != "app") {
            window.clearInterval(app_web_height_timer);
        }
        else {
            iFrameHeight();
        }
    }, 500);
}

function iFrameHeight() {
    var ifm = document.getElementById("app_iframe");
    if (ifm == null) {
        window.clearInterval(app_web_height_timer);
        return;
    }
    var subWeb = document.frames ? document.frames["app_iframe"].document : ifm.contentDocument;
    ifm.height = subWeb.body.scrollHeight;
}

function fix_ie_shadow(){
	if(jQuery.browser.msie && (jQuery.browser.version == "7.0"||jQuery.browser.version == "8.0")) {
			var shadow = $(".form-border-shadow");
			if(shadow.length == 1){
				var offset = getPosition(shadow.get(0));
				var _height = $(".form-border-shadow").outerHeight();
				var _width = $(".form-border-shadow").outerWidth()-1;
				$(".fix_ie_shadow").css({
					"width":_width + "px",
					"height":_height + "px",
					"left":offset.x - 3 + "px",
					"top":offset.y - 5 + "px"
				});
			}
	}
}
function show_message(title, message) {
    paint_select_iframe();
    show_lock_div();
    print_message_panel(title, message);
    //�˴���ʱ�����޸�����Ϊsuccess�������������һ��������Ҫ��ʧ��һ���ǲ���ʧ���ȴ��¸�����
    //var type = message_panel[title].type;
    var auto_fade = message_panel[title].auto_fade;
    if (auto_fade == true) {
        $("#message_layer").stop(false, true).delay(1000).fadeOut(500, function () {
            hide_lock_div();
            remove_select_iframe();
        });
    }
}

function show_dialog(message, confirm_callback, cancel_callback,text_name) {
	if(text_name){
		$("#dialog_head").html(dialog_text[text_name][0]);
		$("#dialog_confirm_btn").val(dialog_text[text_name][1]);
		$("#dialog_cancel_btn").val(dialog_text[text_name][2]);
	}
	else{
		$("#dialog_head").html(dialog_text["default"][0]);
		$("#dialog_confirm_btn").val(dialog_text["default"][1]);
		$("#dialog_cancel_btn").val(dialog_text["default"][2]);
	}
    show_lock_div();
    var _this = $("#dialog");
    _this.stop(false, true).fadeIn();
    $("#dialog_msg").html(message);
    var left = (parseInt(document.documentElement.scrollWidth) - _this.width()) / 2 + "px";
    var M_MIUI_compatible = (window.location.pathname.indexOf("mobile")>-1&&document.documentElement.clientHeight==0)?_MIUI_height_compatiable():false;
    var top = document.documentElement.scrollTop + document.body.scrollTop + (!!M_MIUI_compatible?M_MIUI_compatible:document.documentElement.clientHeight - _this.outerHeight()) / 2 + "px";//fix chrome bug
    _this.css("left", left);
    _this.css("top", top);
    $(".dialog_focus").focus();
    $("#dialog_confirm_btn").unbind("click").bind("click", function () {
        hide_dialog();
        confirm_callback();
    });
    if ((typeof cancel_callback) == "function") {
        $("#dialog_cancel_btn").unbind("click").bind("click", cancel_callback);
    } else {
        $("#dialog_cancel_btn").unbind("click").bind("click", hide_dialog);
    }
}

function hide_dialog(title, message) {
    hide_lock_div();
    $("#dialog").stop(false, true).fadeOut();
}

function print_message_panel(title, message) {
    var _this = $("#message_layer");
    if (title != "error" && title != "wait_one_min") {
        $("#msg_type").attr("class", message_panel[title].type);
        message = message || message_panel[title].message;
        $("#msg").html(message);
    }
    else {
        if (title == "wait_one_min") {
            $("#msg_type").attr("class", message_panel[title].type);
        } else {
            $("#msg_type").attr("class", title);
        }
        $("#msg").html(message);
    }
    var left = (parseInt(document.documentElement.scrollWidth) - _this.outerWidth()) / 2 + "px";
    var top = document.documentElement.scrollTop + document.body.scrollTop + (document.documentElement.clientHeight - _this.outerHeight()) / 2 + "px";//fix chrome bug
    _this.css("left", left);
    _this.css("top", top);
    _this.stop(false, true).show();
}

function paint_select_iframe() {
    if (jQuery.browser.msie && jQuery.browser.version == "6.0") {
        remove_select_iframe();
        var _frm = $("<iframe/>");
        _frm.attr("id", "msg_select_iframe");
        _frm.attr("class", "select_iframe");
        _frm.css("height", $(document).height());
        _frm.css("width", $(document).width());
        $(document.body).append(_frm);
    }
}

function remove_select_iframe() {
    if (jQuery.browser.msie && jQuery.browser.version == "6.0") {
        if ($("#msg_select_iframe").length > 0) {
            $("#msg_select_iframe").remove();
        }
    }
}

function show_lock_div(opacity) {
    var M_MIUI_compatible = (window.location.pathname.indexOf("mobile")>-1&&document.documentElement.clientHeight==0)?_MIUI_height_compatiable():false;
    remove_quick_lock_div();
    $("#lock_div").show();
	$("#lock_div").css({
		"width":"100%",
		"height":(!!M_MIUI_compatible?M_MIUI_compatible:(document.documentElement.clientHeight+document.documentElement.scrollTop+document.body.scrollTop))+"px",
		"opacity":opacity||"0.15"
	});
    paint_select_iframe();
}

function hide_lock_div() {
    $("#lock_div").hide();
    remove_select_iframe();
}

//�������õ���������ҳ�������ͻ
function remove_lock_div() {
    var _lock_div = $("#lock_div");
    if (_lock_div.css("display") == "" || _lock_div.css("display") == "block") {
        _lock_div.css("display", "none");
    }
}

function remove_quick_lock_div() {
    var _quick_lock_div = $("#quick_lock_div");
    if (_quick_lock_div.css("display") == "" || _quick_lock_div.css("display") == "block") {
        _quick_lock_div.css("display", "none");
    }
}

function show_quick_lock_div() {
    $("#quick_lock_div").show();
    //�����ʱ���������������Ƴ�
    remove_lock_div();
    remove_w_lock_div();
    $("#quick_lock_div").css("width", $(document).width());
    $("#quick_lock_div").css("height", $(document).height());
    paint_select_iframe();
}

function hide_quick_lock_div() {
    $("#quick_lock_div").hide();
    remove_select_iframe();
}

function show_pop_layer(id) {
    //$("#"+id).find(".txt").eq(0).focus();
    /*var container_width = $("#container").width();
     var container_height = $("#container").height();*/
    var layer = $("#" + id);
    var o_elem_width = layer.width();
    var o_elem_height = layer.height();
    /*var left = parseInt(container_width-o_elem_width)/2+"px";
     var top = document.documentElement.scrollTop+(container_height-o_elem_height)/2+"px";*/

    var left = (parseInt(document.documentElement.scrollWidth) - o_elem_width) / 2 + "px";
    var top = document.documentElement.scrollTop + document.body.scrollTop + (document.documentElement.clientHeight - o_elem_height) / 2 + "px";

    layer.css({"left": left, "top": top}).stop(false, true).fadeIn();
    set_w_lock_div();
    paint_select_iframe();
    $("#w_lock_div").css({
        "background": "#000",
        "filter": "Alpha(opacity=60)",
        "-moz-opacity": "0.6",
        "-khtml-opacity": "0.6",
        "opacity": "0.6"
    });
}

function hide_pop_layer(id,callback) {
    var callFn = callback || $.noop;
    $("#" + id).stop(false, true).fadeOut("normal",function(){
        if(typeof  callFn == "function"){
            callFn.call(null);
        }
    });
    remove_w_lock_div();
    remove_select_iframe();
}

function set_w_lock_div() {
    remove_w_lock_div();
    $(document.body).append('<div id="w_lock_div" style=" position:absolute; top:0; left:0; width:100%; z-index:2000; background:#fff; filter:Alpha(opacity=0);-moz-opacity:0;-khtml-opacity:0;opacity:0;"></div>');
    $("#w_lock_div").css({height: document.documentElement.clientHeight+document.documentElement.scrollTop+document.body.scrollTop+"px",width:$(document).width()});
}

function remove_w_lock_div() {
    if ($("#w_lock_div").length > 0) {
        $("#w_lock_div").remove();
    }
}

$(window).unbind("resize").bind("resize",function () {
    set_lock_size();
	if(toolTipsBar)
		toolTipsBar.set();
	var conner = $("#conner");
	if(conner.length == 1){
		set_btn_pos();	
	}	
});

$(window).unbind("scroll").bind("scroll",function () {
    set_lock_size();
	if(toolTipsBar)
		toolTipsBar.set();
});

function set_lock_size() {
    var w_lock_div_state = $("#w_lock_div").css("display");
    //    edit -- add  by lwj
    var _height = document.documentElement.clientHeight+document.documentElement.scrollTop+document.body.scrollTop+"px";
    //    edit -- add  by lwj
    if (w_lock_div_state == "block") {
        $("#w_lock_div").css("width", $(document).width());
        $("#w_lock_div").css("height", _height);
    }

    var lock_div_state = $("#lock_div").css("display");
    if (lock_div_state == "block") {
        $("#lock_div").css("width", $(document).width());
        $("#lock_div").css("height", $(document).height());
    }

    var quick_lock_div_state = $("#quick_lock_div").css("display");
    if (quick_lock_div_state == "block") {
        $("#quick_lock_div").css("width", $(document).width());
        $("#quick_lock_div").css("height", $(document).height());
    }
}


function init_text_event() {
    $(".txt").addClass("txt_normal");
    $(".txt").unbind("focus").bind("focus", function () {
        if ($(this).attr("class").indexOf("txt_prevalue") != -1) {
            clear_value(this);
        }
        else {
            $(this).removeClass().addClass("input-text");
        }
    });
    $(".txt").unbind("blur").bind("blur", function () {
        if ($(this).val() != "") {
            var parent_form_id = $(this).parents("form").attr("id");
            if (!form_check(this, parent_form_id)) {
                return;
            }
        }
        else {
            fill_default_value(this);
        }
        if ($(this).attr("class").indexOf("txt_focus") != -1) {
            if ($(this).attr("class").indexOf("txt_prevalue") != -1)
                $(this).removeClass().addClass("input-text txt_prevalue");
            else
                $(this).removeClass().addClass("input-text");
        }
    });
    $(".txt").unbind("keyup").bind("keyup", function (e) {
        if (e.keyCode == 13)
            return;
        if ($(this).val() != "") {
            var parent_form_id = $(this).parents("form").attr("id");
            if (!form_check(this, parent_form_id))
                return;
        }
        else {
            $(this).focus();
            hide_msgbox();
        }
    });
}

function form_check(obj, form_id) {
    var ctr_id = $(obj).attr("id");
    var oldClass = $(obj).attr('class');
    for (var i in reg_map[form_id]) {
        if (ctr_id == reg_map[form_id][i].id.toString()) {
            var type_arr = reg_map[form_id][i].type.split(" ");
            for (var j in type_arr) {
                if (!get_msgbox(ctr_id, type_arr[j])) {
                    $(obj).removeClass().addClass("input-text input-error");
                    return false;
                } else {
                    $(obj).removeClass().addClass(oldClass);
                    hide_msgbox();
                }
            }
            break;
        }
    }
}


function clear_value(obj) {
    $(obj).removeClass().addClass("input-text");
    $(obj).val("");
}

function fill_default_value(obj) {
    if ($(obj).val() == "") {
        if ($(obj).attr("id") == "wirel_answer") {//��������������֤����
            $(obj).val(pre_data[current_html]["wirel_answer"][$("#question_sel").val()]);
        }
        else {
            if (pre_data[current_html] == undefined)//������֤
                return;
            if (pre_data[current_html][$(obj).attr("id")] != "") {
                $(obj).val(pre_data[current_html][$(obj).attr("id")]);
                $(obj).removeClass().addClass("txt txt_prevalue txt_focus");
            }
        }
    }
}

//��������
function ck_pwd(id, pwd) {
    remove_ck_pwd(id);

    /* ��placeholder��ʱ����placeholder�������� */
    if (pwd === document.getElementById(id).getAttribute('placeholder')) {
        pwd = '';
    }
    if (id == "login_pwd") {
        $("#pwd_check").html("<div id=\"" + id + "_pwd_ck\" class=\"pwd_status\"><span id=\"" + id + "_strength_L\" class=\"strength_L\"></span><span id=\"" + id + "_strength_M\" class=\"strength_M\"></span><span id=\"" + id + "_strength_H\" class=\"strength_H\"></span></div>");
    }
    else {
        $("#" + id).parent().after("<div id=\"" + id + "_pwd_ck\" class=\"strength\"><div class=\"pwd_status\"><span id=\"" + id + "_strength_L\" class=\"strength_L\"></span><span id=\"" + id + "_strength_M\" class=\"strength_M\"></span><span id=\"" + id + "_strength_H\" class=\"strength_H\"></span></div></div>");
		if(id == "wireless_2_4_key_val" && !ROUTE_INFO.is_5G){
			$("#wireless_2_4_key_val_pwd_ck").css("top","255px");
		}
    }
    pwStrength(id, pwd);
}

function remove_ck_pwd(id) {
    if ($("#" + id + "_pwd_ck").length > 0) {
        $("#" + id + "_pwd_ck").remove();
    }
}


//�ж��������������  
function CharMode(iN) {
    if (iN >= 48 && iN <= 57) //����
        return 1;
    if (iN >= 65 && iN <= 90) //��д
        return 2;
    if (iN >= 97 && iN <= 122) //Сд
        return 4;
    else {
        return 8;
    }
}

//bitTotal����  
//��������ģʽ  
function bitTotal(num) {//�������1 2 4 8
    modes = 0;
    for (var i = 0; i < 4; i++) {
        if (num & 1) //ȫ1Ϊ1
            modes++;
        num >>>= 1; // >>> ������1λ
    }
    return modes;
}


//����ǿ�ȼ���  
function checkStrong(sPW) {
    if (sPW.length < 8)
        return 0; //����̫��
    var Modes = 0;
    for (i = 0; i < sPW.length; i++) {
        //����ģʽ
        Modes |= CharMode(sPW.charCodeAt(i));
        //ֻ�����������������Ӧ��λ����0ʱ�������������Ӧ��λ����0������Ϊ1��
    }
    return bitTotal(Modes);
}

//��ʾ��ɫ  
function pwStrength(id, pwd) {
    //���ݲ�ͬ��ID��֤��ͬ�������ַ�
    hide_msgbox();
    if ($("#" + id).attr("class").indexOf("txt_prevalue") != "-1" || $("#" + id).val() == "")
        return;
    var O_color = "#ACACAC";
    var L_color = "#FB0103";
    var M_color = "#FCC200";
    var H_color = "#02E323";

    S_level = checkStrong(pwd);
    switch (S_level) {
        case 0:
            Lcolor = Mcolor = Hcolor = O_color;
            $("#" + id + "_strength_L").html(L.pwd_low);
        case 1:
            Lcolor = L_color;
            Mcolor = Hcolor = O_color;
            $("#" + id + "_strength_L").html(L.pwd_low);
            break;
        case 2:
            Lcolor = Mcolor = M_color;
            Hcolor = O_color;
            $("#" + id + "_strength_M").html(L.pwd_medium);
            break;
        default:
            Lcolor = Mcolor = Hcolor = H_color;
            $("#" + id + "_strength_H").html(L.pwd_strong);
    }

    $("#" + id + "_strength_L").css("background", Lcolor);
    $("#" + id + "_strength_M").css("background", Mcolor);
    $("#" + id + "_strength_H").css("background", Hcolor);
    return;
}

function ajaxAsync(flag) {
    $.ajaxSetup({
        async: flag
    });
}

function handle_ip(ip) {
    if ("0.0.0.0" == ip)ip = "";
    return ip;
}

function count_length(value, max_length) {
    var sum = 0;
    for (var i = 0; i < value.length; i++) {
        if ((value.charCodeAt(i) >= 0) && (value.charCodeAt(i) <= 255))
            sum = sum + 1;
        else
            sum = sum + 2;
        if (sum > max_length) {
            var v = value.substring(0, i) + "��";
            return v;
        }
    }
    return value;
}

function math_unit_converter(str) {
    var int_v = parseInt(str, 10);
    var map = {0: "B", 1: "K", 2: "M", 3: "G", 4: "T"};
    var h = 0;
    for (h = 0; int_v > 1024; h++) {
        int_v = int_v / 1024;
    }
    if (h > 4) {
        int_v = int_v * Math.pow(1024, (h - 4));
        h = 4;
    }

    var ret_str = int_v.toString().indexOf(".") > -1 ? int_v.toFixed(2) : int_v;
    return ret_str + map[h];
}

function convert_time(timeStr) {
    var int_v = parseInt(timeStr, 10);
    var map = {0: L.second, 1: L.minute, 2: L.hour, 3: L.day};
    var h = 0;
    if (0 < int_v < 60) {
        h = 0
    }
    if (int_v >= 60 && int_v < 3600) {
        h = 1
    }
    if (int_v >= 3600 && int_v < 86400) {
        h = 2
    }
    if (int_v >= 86400) {
        h = 3
    }
    var re_str = "";
    if (h == 0) {
        ret_str = int_v + map[h];
    }
    if (h == 1) {
        var p1 = 0, p2 = 0;
        p1 = Math.floor(int_v / 60);
        p2 = Math.floor(int_v % 60);
        if (p2 != 0)
            ret_str = p1 + map[h] + p2 + map[h - 1];
        else
            ret_str = p1 + map[h];
    }
    if (h == 2) {
        var p1 = 0, p2 = 0, p3 = 0;
        p1 = Math.floor(int_v / 3600);
        p2 = Math.floor((int_v % 3600) / 60);
        p3 = Math.floor(int_v % 60);
        if (p3 == 0 && p2 == 0)
            ret_str = p1 + map[h];
        else if (p3 != 0 && p2 == 0)
            ret_str = p1 + map[h] + p3 + map[h - 2];
        else if (p3 == 0 && p2 != 0)
            ret_str = p1 + map[h] + p2 + map[h - 1];
        else
            ret_str = p1 + map[h] + p2 + map[h - 1] + p3 + map[h - 2];
    }
    if (h == 3) {
        var p1 = 0, p2 = 0, p3 = 0, p4 = 0;
        p1 = Math.floor(int_v / (60 * 60 * 24));
        p2 = Math.floor((int_v / 3600) % 24);
        p3 = Math.floor((int_v % 3600) / 60);
        p4 = Math.floor(int_v % 60);
        if (p2 == 0 && p3 == 0 & p4 == 0)
            ret_str = p1 + map[h];
        else if (p2 != 0 && p3 == 0 && p4 == 0)
            ret_str = p1 + map[h] + p2 + map[h - 1];
        else if (p2 == 0 && p3 != 0 && p4 == 0)
            ret_str = p1 + map[h] + p3 + map[h - 2];
        else if (p2 == 0 && p3 == 0 && p4 != 0)
            ret_str = p1 + map[h] + p4 + map[h - 3];
        else if (p2 != 0 && p3 != 0 && p4 == 0)
            ret_str = p1 + map[h] + p2 + map[h - 1] + p3 + map[h - 2];
        else if (p2 == 0 && p3 != 0 && p4 != 0)
            ret_str = p1 + map[h] + p3 + map[h - 2] + p4 + map[h - 3];
        else if (p2 != 0 && p3 == 0 && p4 != 0)
            ret_str = p1 + map[h] + p2 + map[h - 1] + p4 + map[h - 3];
        else
            ret_str = p1 + map[h] + p2 + map[h - 1] + p3 + map[h - 2] + p4 + map[h - 3];
    }
    return ret_str;
}

function getFileName(path) {
    var pos1 = path.lastIndexOf('/');
    var pos2 = path.lastIndexOf('\\');
    var pos = Math.max(pos1, pos2)
    if (pos < 0)
        return path;
    else
        return path.substring(pos + 1);
}

function section_disable(section_id, flag) {
    $("#" + section_id + " input").attr("disabled", flag);
    $("#" + section_id + " textarea").attr("disabled", flag);
    $("#" + section_id + " select").attr("disabled", flag);
}

function section_toggle() {
    $("#advance_body").toggle();
}

function check_start_end_ip(ip1, ip2) {
    var ip_arr1 = ip1.split(".");
    var ip_arr2 = ip2.split(".");
    for (var i = 0; i < 4; i++) {
        if (parseInt(ip_arr1[i], 10) > parseInt(ip_arr2[i], 10)) {
            var ss = L.start_end_ip_err;
            return ss;
        }
        /*		else if(parseInt(ip_arr1[i],10) == parseInt(ip_arr2[i],10)){
         var ss="��ʼIP���ڽ���IP";
         return ss;
         }*/
        else if (parseInt(ip_arr1[i], 10) < parseInt(ip_arr2[i], 10))
            break;
    }
    return true;
}

//��鲻��lan_ip�ε�ip
function check_nin_wan_ip(str, mask) {
    var ipChkStr = check_lan_ip(str);
    if (typeof ipChkStr == "string") {
        return ipChkStr;
    }
    var mask = mask || ROUTE_INFO.lan_mask;
    var maskArray = mask.split(".");
    var ipArray = str.split(".");
    var wanIpArray = ROUTE_INFO.wan_ip.split(".");
    if (getIsSameSegment(ipArray, wanIpArray, maskArray)) {
        return L.in_ip_out_ip_same_segment;
    }

    return true;
}

function break_row(str, len) {
    var temp_str = "", n = 1;
    if (str.length <= len) {
        temp_str = str;
    }
    else {
        var temp_arr = new Array();
        for (var i = 0; i < str.length; i++) {
            temp_arr[i] = str.charAt(i);
            if (n % len == 0) {
                temp_arr[i] = temp_arr[i] + "<br/>";
            }
            n++;
            temp_str += temp_arr[i];
        }
    }
    return temp_str;
}

function select_chose_set(sel_id, val, func) {
    var collection = document.getElementById(sel_id);
    if (collection) {
        if (collection.options) {
            for (var i = 0; i < collection.options.length; i++) {
                if (collection.options[i].value == val) {
                    collection.options[i].selected = true;
                }
            }
        } else {
            collection.value = val;
        }
    }
    if (func) {
        func(val);
    }
}

//��ѡ��ť
function radio_sele_set(radio_name, get_value) {
    var collection = document.getElementsByName(radio_name);
    for (i = 0; i < collection.length; i++) {
        collection[i].checked = (collection[i].value == get_value) ? true : false;
    }
}

function onbeforeunload_event(text) {

    window.onbeforeunload = function (e) {
        var str = text;
        e = e || window.event;
        if (e) {
            e.returnValue = str;
        }
        else
            return str;
    };

}
//��ȡ�˵��е�Ԫ��
function getJsonObject(obj, key, value) {
    var obj1 = new Object();

    function eachObject(o) {
        $.each(o, function (i, n) {
            if (n instanceof  Object && n[key] !== value) {
                eachObject(n, key, value);
            } else if (n[key] === value) {
                obj1 = n;
                return false;
            }
        });
    }

    eachObject(obj);
    return obj1;
}

//�����㼶�˵�����
function parent(name, code, initFn) {
    this.code = code || "";
    this.name = name || "";
    this.initFn = initFn || $.noop

}

parent.prototype.add_child = function (name, code, initFn) {
    var lastParent = PAGE_INFO.menu_parent;
    var isExist = (lastParent.code == code);
    while (lastParent.child instanceof  parent) {
        lastParent = lastParent.child;
        if (lastParent.code == code) {
            isExist = true;
        }
    }
    if (!isExist) {
        lastParent.child = new parent(name, code, initFn);
        lastParent.child.parent = lastParent;
    }
}
parent.prototype.remove_child = function (code) {
    var lastParent = PAGE_INFO.menu_parent;
    while (lastParent.child instanceof  parent) {
        if (lastParent.code == code) {
            lastParent.child = null;
            break;
        }
        lastParent = lastParent.child;
    }
}
function json_ajax(config) {
    config.successFn = config.successFn || $.noop;
    config.finalFn = config.finalFn || $.noop;
//    config.isFullDataStyle = config.isResponseDataStyle || true;//true -> ���� data.data  false ->���� data ======== by lwj add
    $.ajax({
        type: "post" || config.type,
        async: config.async || true,
        url: config.url,
        data: config.data,
        dataType: "json",
        error: function (XMLHttpRequest, textStatus) {
            var ret_json = {};
            ret_json.err_no = "requesterror";
            config.finalFn(ret_json);
        },
        success: function (ret) {
            var ret_json = ret;
            if (ret && typeof ret != "object") {
                ret_json = $.parseJson(ret);
            }
            if (ret_json && ret_json.err_no == 0) {
                config.successFn(!!config.isFullDataStyle?ret_json:ret_json.data);
            }
//            else if (ret_json && ret_json.err_no != 0 && ret_json.err_des) {
//                show_message("error", igd.make_err_msg(ret_json.err_des));
//            }
            else {
                //finalFn����trueʱȡ��Ĭ����ʾʱ��
                if (config.finalFn(ret_json))
                    return;
//                show_message("error", igd.err["11"]);
                return;
            }
            config.finalFn(ret_json);

        }
    });
}

(function ($) {
    $.fn.extend({
        placeholder: function () {
            if ("placeholder" in document.createElement("input")) {
                return this //���ԭ��֧��placeholder���ԣ��򷵻ض�����
            } else {
                return this.each(function () {
                    var _this = $(this);
                    _this.val(_this.attr("placeholder")).focus(function () {
                        if (_this.val() === _this.attr("placeholder")) {
                            _this.val("")
                        }
                    }).blur(function () {
                        if (_this.val().length === 0) {
                            _this.val(_this.attr("placeholder"))
                        }
                    })
                })
            }
        }
    })
})(jQuery);
//��ʽ���ٶ�    ���մ�С������ֵ
function formatSpeed(B) {
    var KB = 1024,
        MB = 1024 * 1024, returnObj = {
            value: "0",
            unit: "KB/s",
            allValue: "0KB/s"
        };
    if (B > 0 && B < MB) {
        returnObj.allValue = (B / KB).toFixed(1) + "KB/s";
        returnObj.value = (B / KB).toFixed(1);
        returnObj.unit = "KB/s";
    } else if (B > MB) {
        returnObj.allValue = (B / MB).toFixed(1) + "MB/s";
        returnObj.value = (B / MB).toFixed(1);
        returnObj.unit = "MB/s";

	}
	if(returnObj.value == "0.0")
		returnObj.value = "0";
	if(returnObj.value.length == 6)
		returnObj.value = returnObj.value.substring(0,returnObj.value.length-2);
    return returnObj;
}

//check number, ����true false
function checkNum(num) {
    if (!/^[0-9]*$/.test(num)) {
        return false;
    }
    return true;
}

/* start by houbingyang */
Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}

function getAesString(str, keyObj) {
    var lengthKeyObj = keyObj || get_rand_key(0);
    var key = CryptoJS.enc.Hex.parse(lengthKeyObj.rand_key);
    var iv = CryptoJS.enc.Latin1.parse("360luyou@install");
    var encrypted = CryptoJS.AES.encrypt(str, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
    });
    var cipher_text = encrypted.ciphertext.toString();
    //var retObj={
    //    "cipher_text":cipher_text,
    //    "key_index":lengthKeyObj.key_index
    //}
    return lengthKeyObj.key_index + cipher_text;
}

function getDAesString(str, keys) {
    var ciphertext = str.substr(32, str.length - 32);
    var lengthKeyObj = {};
    if (keys) {
        lengthKeyObj.rand_key = keys;
    } else {
        lengthKeyObj = get_rand_key(0, str, true);
    }
    if (!lengthKeyObj.rand_key) {
        return str;
    }
    var key = CryptoJS.enc.Hex.parse(lengthKeyObj.rand_key);
    var iv = CryptoJS.enc.Latin1.parse("360luyou@install");
    var str16T64 = CryptoJS.enc.Hex.parse(ciphertext).toString(CryptoJS.enc.Base64);
    var decrypted = CryptoJS.AES.decrypt(str16T64, key, {
        iv: iv,
        mode: CryptoJS.mode.CBC,
        padding: CryptoJS.pad.Pkcs7
    });
    return decrypted.toString(CryptoJS.enc.Utf8);
}

function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g, ''); //ȥ��HTML tag
    str = str.replace(/[ | ]*\n/g, '\n'); //ȥ����β�հ�
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //ȥ���������
    str = str.replace(/&nbsp;/ig, '');//ȥ��&nbsp;
    return str;
}

function get_rand_key(error_count, key_index, is_get) {
    error_count = error_count || 0;
    if (error_count > 5) {
        return "";
    }
    if (key_index) {
        key_index = key_index.substr(0, 32);
    }
    if (is_get && key_index == "") {
        return "";
    }
    var calleeFn = arguments.callee;
    var retObj = {
        "rand_key": "",
        "key_index": key_index
    };
    $.ajax({
        url: "/router/get_rand_key.cgi",
        data: {
            "noneed": "noneed",
            "key_index": key_index
        },
        dataType: "json",
        async: false,
        error: function (XMLHttpRequest, textStatus) {
            retObj = calleeFn(error_count, key_index, is_get);

        },
        success: function (data) {
            if (is_get && data.err_no * 1) {
                retObj["rand_key"] = "";
            } else {
                if (data.rand_key) {
                    retObj["rand_key"] = data.rand_key.substring(32, 64);
                    retObj["key_index"] = data.rand_key.substring(0, 32);
                } else {
                    retObj = calleeFn(error_count, key_index, is_get);
                }
            }

        }
    });

    return retObj;
}

/* end by houbingyang */

/* start  by houbingyang      ��ȡip�Ƿ�ͬһ����*/
function getIsSameSegment(ip1Array, ip2Array, maskArray) {
    for (var i = 0; i < 4; i++) {
        var ip1Part = (ip1Array[i] * 1) & (maskArray[i] * 1);
        var ip2Part = (ip2Array[i] * 1) & (maskArray[i] * 1);
        if (ip1Part != ip2Part) {
            return false;
        }
    }
    return true
}

/* end by houbingyang      ��ȡip�Ƿ�ͬһ����*/

/* start  by houbingyang      js�ַ�����html��ǩ��ת����*/
(function () {
    var TOOLS = {};
    TOOLS.Crypto = {};
    TOOLS.Crypto.htmlencode = function (str) {
		str = str.replace(/&/g, '&amp;');
        str = str.replace(/</g, '&lt;');
        str = str.replace(/>/g, '&gt;');
        str = str.replace(/(?:t| |v|r)*n/g, '<br />');
        str = str.replace(/  /g, '&nbsp; ');
        str = str.replace(/t/g, '&nbsp; &nbsp; ');
        str = str.replace(/x22/g, '&quot;');
        str = str.replace(/x27/g, '&#39;');
        return str;
    }
    TOOLS.Crypto.htmldecode = function (str) {
        str = str.replace(/&amp;/gi, '&');
        str = str.replace(/&nbsp;/gi, ' ');
        str = str.replace(/&quot;/gi, '"');
        str = str.replace(/&#39;/g, "'");
        str = str.replace(/&lt;/gi, '<');
        str = str.replace(/&gt;/gi, '>');
        str = str.replace(/<br[^>]*>(?:(rn)|r|n)?/gi, 'n');
        return str;
    }
    TOOLS.Crypto.textencode = function (str) {
        str = str.replace(/&amp;/gi, '&');
        str = str.replace(/</g, '&lt;');
        str = str.replace(/>/g, '&gt;');
        return str;
    }
    TOOLS.Crypto.textdecode = function (str) {
	   	str = str.replace(/&amp;/gi, '&');
        str = str.replace(/&lt;/gi, '<');
        str = str.replace(/&gt;/gi, '>');
        return str;
    }
    TOOLS.Url = {};
    TOOLS.Url.getQueryString = function (locationEmt) {
        var location_token = location;
        if (locationEmt && locationEmt.location) {
            location_token = locationEmt.location;
        }
        var url = location_token["search"]; //��ȡurl��"?"������ִ�
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            var strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = decodeURIComponent(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    window.TOOLS = TOOLS;
})();
/* end by houbingyang      js�ַ�����html��ǩ��ת����*/
//��ȡת�����豸�б�
function GetDeviceNameStr(str, length) {
    var realLength = 0, len = str.length, charCode = -1;
    length = length || 20;
    for (var i = 0; i < len; i++) {
        charCode = str.charCodeAt(i);
        if (charCode >= 0 && charCode <= 128) realLength += 1;
        else realLength += 2;
        if (realLength > length) {
            return str.substring(0, i) + "....";
        }

    }
    return str;
}
//��ȡ������Ĭ�Ϸ��������� ��format��������  {"days":days, "hours": hours}
function getDateBySec(sec) {
    var date = {
        days: 0,
        hours: 0,
        minute: 0,
        sec: 0
    };
    date.days = parseInt(sec / 60 / 60 / 24);
    date.hours = parseInt(sec / 60 / 60 - date.days * 24);
    date.minute = parseInt(sec / 60 - date.hours * 60 - date.days * 24 * 60);
    date.sec = sec % 60;
    if (!date.days && !date.hours && !date.minute) {
        date.minute = 1;
    }
    return date;
}

function radio_toggle(obj, o_event) {
    var name = $(obj).attr("id");
    if ($(obj).attr("class").indexOf("radio_on") != -1) {
        $(obj).removeClass("radio_on").addClass("radio_off");
        $("#" + name + "_hidden").val("0");
    }
    else {
        $(obj).removeClass("radio_off").addClass("radio_on");
        $("#" + name + "_hidden").val("1");
    }
    var str = $("#" + name + "_hidden").val();
    if (typeof(o_event) == "string")
        eval(o_event + "(" + str + ")");
	else if(typeof(o_event) == "function")
		o_event.call(this);
}

function radio_set(key,id){
	if(key == "0"){
		$("#" + id).removeClass("radio_on").addClass("radio_off");
	}
	else{
		$("#" + id).removeClass("radio_off").addClass("radio_on");
	}
	$("#"+ id +"_hidden").val(key);
}

//����������
var toolTipsBar = {
	basicParam:{
		timeEffect : 500,
		appearMethod : 'slide'
	},
	create:function(opts){
		var _this = this;
		var $li = $("<li/>");
		var $a = $("<a/>");
		$a.attr({
			href:"javascript:void(0)",
			id:opts.id
		});
		$a.unbind("click").bind("click",function(e) {
			e.preventDefault();
			if(opts.id == "BackToTop"){
				$("body,html").animate({scrollTop:0},_this.basicParam.timeEffect);
			}
			else if(opts.id == "GoToBottom"){
				var height = $("body").height();
				$("body,html").animate({scrollTop:height},_this.basicParam.timeEffect);
			}
		});
		$li.append($a);
		//�����ȥ���ײ���ť����ô��׷����ȥ�ײ�֮ǰ
		if(opts.id == "BackToTop" && $("#GoToBottom").length > 0){
			$("#GoToBottom").parent().before($li);
		}
		else
			$("#toolTipsBar ul").append($li);
	},
	show:function(obj){
		if(obj.opts == null)
			return;
		var elem = $("#" + obj.opts.id);
		switch (obj.opts.appearMethod) {
			case "fade" : 
				elem.stop(true,true).fadeIn("fast",function(){
					$(this).css("display","inline-block");
					toolTipsBar.setPosition();
				}); 
				break;
			case "slide" : 
				elem.stop(true,true).slideDown("fast",function(){
					$(this).css("display","inline-block");
					toolTipsBar.setPosition();
				}); 
				break;
			default : 
				elem.show();
				toolTipsBar.setPosition();
		}
	},
	hide:function(obj){
		if(obj.opts == null)
			return;
		var elem = $("#" + obj.opts.id);
		switch (obj.opts.appearMethod) {				
			case "fade" : 
				elem.stop(true,true).fadeOut("fast",function(){
					$(this).css("display","none");
				}); 
				break;
			case "slide" : 
				elem.stop(true,true).slideUp("fast",function(){
					$(this).css("display","none");
				}); 
				break;
			default :
				elem.hide();	
		}
	},
	set:function(){
		var _this = this;
		var marginBot = document.documentElement.scrollHeight - (document.documentElement.scrollTop + document.body.scrollTop) - document.documentElement.clientHeight;
		if(marginBot <= 0){//�ڵײ�
			_this.hide(_this.goToBottom);
		}
		else
			_this.show(_this.goToBottom);
		if($(window).scrollTop() != 0){
			_this.show(_this.backToTop);
		}
		else{
			_this.hide(_this.backToTop);
		}
		_this.setPosition();
	},
	backToTop:{
		defaults: {
			id:"BackToTop"
		},
		opts:null,
		init:function(options){
			var _this = this;
			$.extend(_this.defaults,toolTipsBar.basicParam);
			_this.opts = $.extend({}, _this.defaults, options);
			toolTipsBar.create(_this.opts);
		}
	},
	goToBottom:{
		defaults: {
			id:"GoToBottom"
		},
		opts:null,
		init:function(options){
			var _this = this;
			$.extend(_this.defaults,toolTipsBar.basicParam);
			_this.opts = $.extend({}, _this.defaults, options);
			toolTipsBar.create(_this.opts);
		}
	},
	returnToFrontPage:{},
	setPosition:function(){
		var pos = getPosition($("#container_wrap").get(0));
		$("#toolTipsBar").css({
			left:pos.x + 1004 + 5 + "px",
			top:document.documentElement.clientHeight - $("#toolTipsBar").height() - 50 + "px"
		});
	},
	init:function(){
		this.goToBottom.init();
		this.backToTop.init();
		this.set();
	}
};

function CaculateWeekDay(y,m,d){
	if(m == 1 || m == 2){
		m+=12;
		y--;
	}
	//��ķ����ɭ���㹫ʽ
	var week = Math.ceil((d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7); 
	return week;
}

function TimeCompareCoveter(hour,minute){
	var time = new Date ();
	time.setHours(hour);
	time.setMinutes(minute);
	time = time.getTime();
	return time;
}
//ȥ������ť�����ݴ��
function office_website(me){
    var appIdNo = $(me).attr("data-us-fov-count");
    user_fov_info.appInfo(appIdNo);
}
