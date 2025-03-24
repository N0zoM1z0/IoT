/* 宏定义 */
var PAGE_LEVEL_HIDDEN = 0;
var PAGE_LEVEL_ADMIN  = 1;
var PAGE_LEVEL_USER   = 2;

var PAGE_LEVEL_menu                  = PAGE_LEVEL_USER; // menu.shtml必须设置为user可以访问

/*************** 页面级别默认值，可以在产品侧定制****************/
/* Status相关页面 */
var MENU_LEVEL_status                = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_info           = PAGE_LEVEL_USER;
var MENU_LEVEL_status_WAN            = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_wannetwork     = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_ethnetwork     = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_dongle         = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_wanxdsl        = PAGE_LEVEL_USER;
var MENU_LEVEL_status_LAN            = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_lannetwork     = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_lanethernet    = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_lanwlan        = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_dhcpclient     = PAGE_LEVEL_USER;
var MENU_LEVEL_status_Statistics     = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_statisticswan  = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_statisticslan  = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_statisticswlan = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_statisticsxtm  = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_statisticsxdsl = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_arp            = PAGE_LEVEL_USER;
var MENU_LEVEL_status_VOIP           = PAGE_LEVEL_USER;
var PAGE_LEVEL_status_voipvoiceinfo  = PAGE_LEVEL_USER;

/* Quick Setup页面 */
var PAGE_LEVEL_quicksetup            = PAGE_LEVEL_ADMIN;

/* Basic Setup相关页面 */
var MENU_LEVEL_basic                 = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_wanservice      = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_basic_LAN             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_lanipv4config   = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_lanipv6config   = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_basic_Wireless        = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_wlcfg           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_wlcfg_5g        = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_basic_wlsecurity      = PAGE_LEVEL_ADMIN;

/* Advanced Setup相关页面 */
var MENU_LEVEL_advanced              = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_WAN          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_xdslcfg           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wanethspeedconfig = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_LAN          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_lanethspeedconfig = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_dvlanconfig       = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_Wireless     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wladvcfg          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wladvcfg_5g       = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wlacl             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wlwps             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wlwps_5g          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_wds               = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_NAT          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_scvrtsrv          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_porttriggering    = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_multinat          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_scdmz             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_algcfg            = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_Security     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_ipfilter          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_macfilter         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_dos               = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_ParentalControl = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_timerestrict      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_urlfilter         = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_Routing      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_defaultroute      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_staticroute       = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_dynamicroute      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_v6staticroute     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_v6dynamicroute    = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_QualityofService = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_qosqueue          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_qoscliffication   = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_qosds   = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_IPTunnel     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_v4inv6            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_v6inv4            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_ipgre            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_channel_info      = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_advanced_BandwidthLimit = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_portbwlimit       = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_adv_ipbwlimit         = PAGE_LEVEL_ADMIN;

/* Application相关页面*/
var MENU_LEVEL_app                   = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_app_StorageService    = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_storagedevinfo    = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_storageuserlist   = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_sambasrv          = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_ftpsrv            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_ftpclient         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_tftpsrv           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_telnetsrv         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_sshsrv            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_printersrv        = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_dlna              = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_app_DNS               = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_app_VPN               = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_l2tp               = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_ddns              = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_upnp              = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_app_Multicast         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_igmp              = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_mld               = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_snmpsrv           = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_app_VOIP              = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipbasiccall     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipadvanced      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipmediasetting  = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipfax           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipvoiceservice  = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipprotocalunregister = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipdialplan      = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipbasiccallcontrol = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipcid           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_voipcdr           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_app_ipsec             = PAGE_LEVEL_ADMIN;

/* Management相关页面 */
var MENU_LEVEL_management            = PAGE_LEVEL_USER;
var PAGE_LEVEL_mngt_reboot           = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_mngt_Settings         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_backup           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_opt66_backup     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_update           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_restoredefault   = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_updatesoftware   = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_mngt_AccountManagement= PAGE_LEVEL_USER;
var PAGE_LEVEL_mngt_password         = PAGE_LEVEL_USER;
var MENU_LEVEL_mngt_Logs             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_loglevel         = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_logs             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_srvctl           = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_cwmp             = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_internettime     = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_xdsldiag         = PAGE_LEVEL_ADMIN;
var MENU_LEVEL_mngt_Tools            = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_pingroute        = PAGE_LEVEL_ADMIN;
var PAGE_LEVEL_mngt_traceroute       = PAGE_LEVEL_ADMIN;
