/******************************* TAG *******************************/
/******************************* TAG START*******************************/
var CLOUD_ID_SUPPORT = true; 					/* IF SUPPORT MERCURY ID */
var CLOUD_UPGADE_SUPPORT = true; 				/* IF SUPPORT UPGRADE ONLINE */

var SET_SYS_PWD_LOADING = true;				/* SHOW BUTTON-LOADING WHEN SET SYS-PWD(FOR MESH-MODEL) */
/******************************* TAG END*******************************/

/******************************* MARCO *******************************/
/******************************* MARCO START*******************************/

/* TIMING */
var REBOOT_SECONDS = 16 * 1000;					/* DEFAULT REBOOT WAIT-TIME */
var RESTORE_SECONDS = 17 * 1000;				/* DEFAULT RESTORE WAIT-TIME */
var RESET_SECONDS = 17 * 1000;					/* DEFAULT RESET WAIT-TIME */
var SYSUPGRADE_SECONDS = 22 * 1000;				/* DEFAULT SYS-UPGRADE WAIT-TIME */

var REQ_TIMEOUT_SECONDS = 2 * 1000;				/* SHOW LOADING WHEN REQUEST TIMEOUT */

/* PORT ORDER */
var PORT_ORDER = ["POWER", "WAN", "LAN", "RESET", "MESH"];

/* WAN */
var MAX_WAN_RATE = 999999;

/* LAN PORT NUM */
var LAN_PORT_NUM = 3;

/* show andlink logo & QRcode */
var showAndlinkLogo = false;
var showAndlinkQRcode = false;
var andlinkLogoBg = "url(../web-static/images/andlinkLogo.png) no-repeat 0 1px";
var andlinkQRcodeSrc = "../web-static/images/andlinkQRcode.png";

/* show elink logo */
var showElinkLogo = false;
var elinkLogoBg = "url(../web-static/images/elinkLogo.png) no-repeat 0 1px";

/* SYS LOGIN */
var usernameSupport = false;
var SYS_LOGIN_PWD_LENGTH_MAX = 32;
var SYS_LOGIN_PWD_LENGTH_MIN = 6;
var SYS_LOGIN_PWD_COMPLEX_CHECK = false;
var SYS_LOGIN_PWD_COMPLEX_MIN = 0;

/* WIRELESS */
var WIRELESS_SSID_LENGTH_MAX = 32;
var WIRELESS_SSID_LENGTH_MIN = 1;
var WIRELESS_PWD_LENGTH_MAX = 63;
var WIRELESS_PWD_LENGTH_MIN = 8;
var MAX_WDS_SCAN_BAND = 64;

var SINGLE_BAND_ACCESS_DEVICE_NUM = 32;

/* HOST INFO */
var HOST_NAME_LEN_MIN = 0;
var HOST_NAME_LEN_MAX = 63;

/* DEVICE INFO */
var DEVICE_NAME_LEN_MIN = 0;
var DEVICE_NAME_LEN_MAX = 63;

/* CLOUD */
var CLOUD_ACCOUNT_LENGTH_MAX = 64;
var CLOUD_ACCOUNT_LENGTH_MIN = 1;
var CLOUD_PWD_LENGTH_MAX = 32;
var CLOUD_PWD_LENGTH_MIN = 6;

/* GUEST NETWORK */
var GUEST_NETWORK_ACCESS_TIME_RULE_MAX = 4;

/* PARENT CONTROL */
var PARENT_DEVICE_NUM_MAX = 8;
var PARENT_CONTROL_RULE_NUM_MAX = 16;

/* ACCESS CONTROL*/
var ACCESS_CONTROL_RULE_NUM_MAX = 16;			/* MAX FOR POOL */
var ACCESS_CONTROL_RULE_DEVICE_NUM_MAX = 4;		/* MAX FOR SIGNLE-DEVICE */

/* WLAN SWITCH */
var WLAN_SWITCH_RULE_MAX = 4;

/* REBOOT TIMER */
var REBOOT_TIMER_RULE_MAX = 4;

/* IP-MAC BIND */
var IP_MAC_BIND_RULE_MAX = 64;

/* ROUTE */
var STATIC_ROUTE_RULE_MAX = 16;

/* VIRTUAL SERVER */
var VIRTUAL_SERVER_RULE_MAX = 16;

/* OTHERS */
var TECHNICAL_SUPPORT_NUMBER = "400-8810-500";
/******************************* MARCO END*******************************/