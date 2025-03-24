var PAGE_NAME=3;
var PAGE_POWER=4;
var PAGE_HELP=5;
var PAGE_IPMODE=6;

//  IP MODE
//  LAN:IPv4 WAN:IPv4,
//  LAN:IPv6 WAN:IPv4,
//  LAN:IPv6 WAN:IPv6, 
//  LAN:IPv4+IPv6 WAN:IPv4, 
//  LAN:IPv4+IPv6 WAN:IPv4+IPv6
//  LAN:IPv4 WAN:Ipv6

var Menu=new Array(); 
var sid=0,m=0;

Menu[m]=new Array();
Menu[m++][sid++]=new Array(__T(g_start.title),'','','getstart.asp',0,'getting_started.html','111111');

var sid=0;
Menu[m]=new Array();
Menu[m][sid++]=new Array(__T(share.sts),__T(router.dashboard),'','dashboard.asp',0,'status_dashboard.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(g_start.sys_summary),'','system.asp',0,'status_summary.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(router.activeservice),'','activelist.asp',0,'status_tcpip.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(wl.T1),'','status_wireless.asp',0,'status_wireless_statistics.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(wl.captivest),'','status_captive.asp',0,'status_captive_portal.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(vpn.sitetositevpn),'','status_sitetosite.asp',0,'status_site_ipsec.html','100110');
Menu[m][sid++]=new Array(__T(share.sts),__T(vpn.vpnser),'','status_vpn.asp',0,'status_ipsec.html','100110');
Menu[m][sid++]=new Array(__T(share.sts),__T(wan.pptpserver),'','status_pptp.asp',0,'status_pptp.html','100110');
Menu[m][sid++]=new Array(__T(share.sts),__T(viewlog.title),'','view_logs.asp',0,'status_logs.html','100110');
Menu[m][sid++]=new Array(__T(share.sts),__T(lan.connectdev),'','lan_host.asp',0,'status_devices.html','111111');
Menu[m][sid++]=new Array(__T(share.sts),__T(wan.wiredst),'','status_wide.asp',0,'status_ports.html','111111');
<% support_match("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(share.sts),__T(wwan.mobilenet),'','status_mobile.asp',0,'mobile_status.html','110110');"); %>
m++;

sid=0;
Menu[m]=new Array();
<% support_invmatch("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),'','wan.asp',0,'net_wan.html','110110');"); %>
<% support_invmatch("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.pppoeps),'','pppoe_profile.asp',0,'net_pppoe_profile.html','110110');"); %>
<% support_match("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),__T(wan.wanconfig),'wan.asp',0,'net_wan.html','110110');"); %>
<% support_match("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),__T(wan.pppoeps),'pppoe_profile.asp',0,'net_pppoe_profile.html','110110');"); %>
<% support_match("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),__T(wwan.mobilenet),'mobile.asp',0,'Mobile_Network.html','110110');");%>
<% support_match("WWAN_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),__T(wwan.failover),'failover.asp',0,'failover_recovery.html','110110');"); %>
<% support_match("WWANDL_SUPPORT","1","Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.wan),__T(wwandl.usbupdate),'mobile_dl.asp',0,'net_usb_device_update.html','110110');"); %>
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.lanconfig),'lan.asp',0,'net_lan.html','100111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.vlanmembership),'vlan_membership.asp',0,'net_vlans.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.staticdhcp),'static_dhcp.asp',0,'net_static_dhcp.html','100111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.dhcpleasedclient),'dhcp_leased_client.asp',0,'net_dhcp_leased.html','100111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.dmzhost),'dmz_host.asp',0,'net_dmz.html','101110');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(lan.rstp),'RSTP.asp',0,'net_rtsp.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.lan),__T(router.linkagg),'linkagg.asp',0,'net_link_aggregation.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(router.portmang),'','port_management.asp',0,'net_port_mgmt.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(lan.macclone),'','macclone.asp',0,'net_mac.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(router.routing),'','routing.asp',0,'net_routing.html','110111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(router.routingtb),'','routingtb.asp',0,'net_routing_table.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(wan.ddns),'','ddns.asp',0,'net_dynamic_dns.html','110111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(router.ipmode),'','ip_mode.asp',0,'net_ip_mode.html','111111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.wantitle),'wan_ipv6.asp',0,'net_ipv6_wan.html','001011');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.lantitle),'lan_ipv6.asp',0,'net_ipv6_lan.html','011110');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.staticrouting),'ipv6_routing.asp',0,'net_ipv6_static_routing.html','011111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.rripng),'ripng.asp',0,'net_ipv6_ripng.html','011111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.tunneling),'tunneling_6to4.asp',0,'net_ipv6_6to4.html','011111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.tunnelst),'status_ipv6.asp',0,'net_ipv6_tunnel.html','011111');
Menu[m][sid++]=new Array(__T(lan.networking),__T(ipv6.ipv6),__T(ipv6.routeradv),'router_ad.asp',0,'net_ipv6_advert.html','011110');

m++;
sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.basicset),'','Wireless_Manual.asp',0,'wireless_basic.html','111111');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.advset),'','Wireless_Advanced.asp',0,'wireless_advanced.html','111111');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.rogueap),'','authap.asp',0,'wireless_rogueap.html','111111');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.wds),'','wds.asp',0,'wireless_wds.html','111111');
Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.wps),'','Wireless_WPS.asp',0,'wireless_wps.html','111111');
<% support_match("GUESTNET_SUPPORT","1","Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.captive),__T(wl.portalprofile),'Wireless_welcome.asp',0,'wireless_captive_portal.html','111111');"); %>
<% support_match("GUESTNET_SUPPORT","1","Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.captive),__T(wl.portalprofilerev),'Wireless_welcome_prev.asp',0,'wireless_captive_portal.html','111111');"); %>
<% support_match("GUESTNET_SUPPORT","1","Menu[m][sid++]=new Array(__T(wl.wl),__T(wl.captive),__T(wl.useraccount),'Wireless_user.asp',0,'wireless_captive_portal.html','111111');"); %>
Menu[m][sid++]=new Array(__T(wl.wl),__T(router.workmode),'','workmode.asp',0,'wireless_device_mode.html','111111');

m++;
sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(filter.firewall),__T(wl.basicset),'','firewall.asp',0,'firewall_basic.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.schmang),'','schedule_manage.asp',0,'firewall_schedule.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.mangservice),'','service_manage.asp',0,'firewall_service.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.accessrules),'','ip_based_acl.asp',0,'firewall_access.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.IAP),'','filter.asp',0,'firewall_policy.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.nat1to1),'','nat_1to1.asp',0,'firewall_1to1nat.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.singleforward),'','singleforward.asp',0,'firewall_single.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.portrangeforward),'','portforward.asp',0,'firewall_range.html','111111');
Menu[m][sid++]=new Array(__T(filter.firewall),__T(filter.portrangetrigger),'','triggering.asp',0,'firewall_trigger.html','111111');
m++;
sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.sitetositevpn),__T(vpn.basicvpnsetup),'vpn_basic.asp',0,'vpn_basic_setup.html','110110');
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.sitetositevpn),__T(vpn.ipsecpolicy),'vpn_adv.asp',0,'vpn_advanced.html','110110'); 
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.vpnser),__T(filter.setup),'ipsec_setup.asp',0,'ipsec_vpn_config.html','110110'); 
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.vpnser),__T(vpn.user),'ipsec_user.asp',0,'ipsec_vpn_user.html','110110'); 
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(wan.pptpserver),'','vpn_client.asp',0,'pptp_config.html','110110'); 
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.passthrough),'','VPN.asp',0,'vpn_pass.html','110110');
Menu[m][sid++]=new Array(__T(vpn.vpn),__T(vpn.sslcert),'','ssl_cert.asp',0,'vpn_sslcertificate.html','110110');
Menu[m++][sid++]=new Array(__T(vpn.vpn),__T(mang.vpnsetupwizard),'','wizard_vpn.asp',0,'','111111');

sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(filter.qos),__T(filter.bandwidthmang),'','bandwidth.asp',0,'qos_bandwidth.html','111111');
Menu[m][sid++]=new Array(__T(filter.qos),__T(filter.qosportset),'','qos_port.asp',0,'qos_port_settings.html','111111');
Menu[m][sid++]=new Array(__T(filter.qos),__T(filter.cosset),'','cos.asp',0,'qos_cos.html','111111');
Menu[m++][sid++]=new Array(__T(filter.qos),__T(filter.dscpset),'','dscp.asp',0,'qos_dscp.html','111111');

sid=0;
Menu[m]=new Array()
Menu[m][sid++]=new Array(__T(mang.administration),__T(router.devicepro),'','device.asp',0,'device_properties.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.pwdcomplex),'','password.asp',0,'admin_password.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.users),'','users.asp',0,'admin_users.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.sessiontimeout),'','session_timeout.asp',0,'admin_timeout.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.snmp),'','snmp.asp',0,'admin_snmp.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.diagnostics),__T(mang.networktools),'network_tools.asp',0,'admin_diag_net.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.diagnostics),__T(mang.portmirror),'port_mirror.asp',0,'admin_diag_mirror.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(syslog.logging),__T(syslog.title),'log.asp',0,'admin_log_settings.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(syslog.logging),__T(logemail.set),'log_email.asp',0,'admin_log_email.html');
Menu[m][sid++]=new Array(__T(mang.administration),__T(bonjour.title),'','bonjour.asp',0,'admin_bonjour.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.timesetting),'','time_zone.asp',0,'admin_date_time.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.bkrestoreset),'','backup.asp',0,'admin_backup.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(router.fwupgrade),'','upgrade.asp',0,'admin_firmware.html','111111');
Menu[m][sid++]=new Array(__T(mang.administration),__T(mang.reboot),'','reboot.asp',0,'admin_restart.html','111111');
Menu[m++][sid++]=new Array(__T(mang.administration),__T(mang.setupwizard),'','wizard.asp',0,'','111111');

sid=0;
Menu[m]=new Array()
<% support_match("WEBFILTER_SUPPORT","1","Menu[m++][sid++]=new Array(__T(filter.webfilter),'','','webfilter.asp',0,'web_filtering.html','111111');"); %>

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

