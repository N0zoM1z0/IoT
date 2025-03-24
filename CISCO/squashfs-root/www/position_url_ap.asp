var PAGE_NAME=3;
var PAGE_POWER=4;
var PAGE_HELP=5;

var Menu=new Array(); 
var sid=0,m=0;

var sid=0;
Menu[m]=new Array();
Menu[m][sid++]=new Array(__T(share.sts),__T(router.dashboard),'','dashboard.asp',0,'status2.html');
Menu[m][sid++]=new Array(__T(share.sts),__T(g_start.sys_summary),'','system.asp',0,'status3.html');
Menu[m][sid++]=new Array(__T(share.sts),__T(wl.T1),'','status_wireless.asp',0,'status4.html');
Menu[m][sid++]=new Array(__T(share.sts),__T(viewlog.title),'','view_logs.asp',0,'status6.html');
Menu[m][sid++]=new Array(__T(share.sts),__T(lan.connectdev),'','lan_host.asp',0,'status7.html');
Menu[m++][sid++]=new Array(__T(share.sts),__T(wan.wiredst),'','status_wide.asp',0,'status8.html');

sid=0;
Menu[m]=new Array();
Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),'','wan.asp',0,'networking01.html');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.rstp),'','RSTP.asp',0,'networking16.html');
Menu[m][sid++]=new Array(__T(lan.networking),__T(router.portmang),'','port_management.asp',0,'networking23.html');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.macclone),'','macclone.asp',0,'networking17.html');
Menu[m++][sid++]=new Array(__T(lan.networking),__T(ipv6.wantitle),'','wan_ipv6.asp',0,'networking27.html');

sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.basicset),'','Wireless_Manual.asp',0,'wireless01.html');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.advset),'','Wireless_Advanced.asp',0,'wireless12.html');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.rogueap),'','authap.asp',0,'wireless12.html');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.wds),'','wds.asp',0,'wireless13.html');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.wps),'','Wireless_WPS.asp',0,'wireless14.html');
Menu[m][sid++]=new Array(__T(wl.wl),__T(router.workmode),'','workmode.asp',0,'networking41.html');

m++;
sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.pwdcomplex),'','password.asp',0,'administering02.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.users),'','users.asp',0,'administering03.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.sessiontimeout),'','session_timeout.asp',0,'administering04.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.snmp),'','snmp.asp',0,'administering05.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.diagnostics),__T(mang.networktools),'network_tools.asp',0,'administering10.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(syslog.logging),__T(syslog.title),'log.asp',0,'administering16.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(syslog.logging),__T(logemail.set),'log_email.asp',0,'administering17.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(bonjour.title),'','bonjour.asp',0,'administering18.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.timesetting),'','time_zone.asp',0,'administering19.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.bkrestoreset),'','backup.asp',0,'administering20.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.reboot),'','reboot.asp',0,'administering27.html');
Menu[m++][sid++]=new Array(__T(mang.administration),__T(mang.restoredef),'','factory.asp',0,'administering28.html');

sid=0;
var MHELP=new Array();
MHELP[sid++]=new Array('Wireless_Manual.asp', 'WL_WPATable.asp','wireless_security.html');
MHELP[sid++]=new Array('Wireless_Manual.asp', 'Wireless_MAC.asp','wireless_mac_filter.html');
MHELP[sid++]=new Array('Wireless_Manual.asp', 'access_time.asp','wireless_time_day.html');
MHELP[sid++]=new Array('schedule_manage.asp', 'schedule_manage_edit.asp','firewall_sched_add_edit.html');
MHELP[sid++]=new Array('filter.asp', 'filter_edit.asp','firewall_policy_add_edit.html');
MHELP[sid++]=new Array('ip_based_acl.asp', 'ip_based_acl_edit.asp','firewall_access_add.html');
MHELP[sid++]=new Array('ip_based_acl.asp', 'ip_based_acl_order.asp','firewall_access.html');
MHELP[sid++]=new Array('vpn_basic.asp', 'vpn_basic_view.asp','vpn_default_values.html');
MHELP[sid++]=new Array('vpn_adv.asp', 'ike_edit.asp','vpn_ike_add_edit.html');
MHELP[sid++]=new Array('vpn_adv.asp', 'ipsec_edit.asp','vpn_policy_add_edit.html');

