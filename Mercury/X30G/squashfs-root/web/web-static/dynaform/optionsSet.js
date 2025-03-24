/* NETWORK */
var rateOptions = [{str:label.dupAuto, value:"auto"},
				   {str:label.dup10MF, value:"10F"},
				   {str:label.dup10MH, value:"10H"}];

/* END OF NETWORK */

/* WIRELESS */
/* AUTH */
var authOption = [{str:label.wpaPskSel, value:uciWireless.dynOptValue.auth.psk},
	{str:label.wpa2PskSel, value:uciWireless.dynOptValue.auth.psk2},
	{str:label.wirelessPsk, value:uciWireless.dynOptValue.auth.pskMixed}];

var authOptStr = [label.wirelessPsk, label.wpaPskSel, label.wpa2PskSel, label.wirelessWpa2PskWpa3Sae, label.wirelessWpa3Sae];

/* CIPHER */
var cipherOption = [{str:label.aes, value:uciWireless.dynOptValue.cipher.aes},
	{str:label.tkip, value:uciWireless.dynOptValue.cipher.tkip}];

/* MODE */
var wifi2GModeOptions = [{str:label.hwmode11bgn, value:uciWireless.dynOptValue.mode.m_11bgn},
						 {str:label.hwmode11bg, value:uciWireless.dynOptValue.mode.m_11bg},
						 {str:label.hwmode11n, value:uciWireless.dynOptValue.mode.m_11n},
						 {str:label.hwmode11g, value:uciWireless.dynOptValue.mode.m_11g},
						 {str:label.hwmode11b, value:uciWireless.dynOptValue.mode.m_11b}];

var wifi5GModeOptionsAC = [{str:label.hwmode11ac, value:uciWireless.dynOptValue.mode.m_11ac},
						   {str:label.hwmode11an, value:uciWireless.dynOptValue.mode.m_11an}];

var wifi2GModeOptionsAX = [{str:label.hwmode11bgn_ax, value:uciWireless.dynOptValue.mode.m_11bgn_ax},
						 {str:label.hwmode11bgn, value:uciWireless.dynOptValue.mode.m_11bgn},
						 {str:label.hwmode11bg, value:uciWireless.dynOptValue.mode.m_11bg},
						 {str:label.hwmode11n, value:uciWireless.dynOptValue.mode.m_11n},
						 {str:label.hwmode11g, value:uciWireless.dynOptValue.mode.m_11g},
						 {str:label.hwmode11b, value:uciWireless.dynOptValue.mode.m_11b}];

var wifi5GModeOptionsAX = [{str:label.hwmode11ac_ax, value:uciWireless.dynOptValue.mode.m_11ac_ax},
						   {str:label.hwmode11ac, value:uciWireless.dynOptValue.mode.m_11ac},
						   {str:label.hwmode11an, value:uciWireless.dynOptValue.mode.m_11an}];

/* CHANNEL */
var wifi2GChannelOptions = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"];

var wifi5GChannelOptions = ["0", "36", "40", "44", "48", "149", "153", "157", "161", "165"];

var wifi5G1ChannelOptions = ["0", "36", "40", "44", "48"];

var wifi5G2ChannelOptions = ["0", "149", "153", "157", "161", "165"];

/* BAND WIDTH */
var wifiBandWidthOptions40M = [{str:label.wirelessAuto40, value:uciWireless.dynOptValue.bandwidth.auto},
							   {str:label.chanbw20, value:uciWireless.dynOptValue.bandwidth.bw20}];

var wifiBandWidthOptions80M = [{str:label.wirelessAuto80, value:uciWireless.dynOptValue.bandwidth.auto},
							   {str:label.chanbw20, value:uciWireless.dynOptValue.bandwidth.bw20},
							   {str:label.chanbw40, value:uciWireless.dynOptValue.bandwidth.bw40}];

var wifiBandWidthOptions160M = [];

/* POWER */
var wifiPowerOptionsNormal = [{str:label.txPowerHigh, value:uciWireless.dynOptValue.power.high},
							  {str:label.txPowerMiddle, value:uciWireless.dynOptValue.power.mid},
							  {str:label.txPowerLow, value:uciWireless.dynOptValue.power.low}];

var wifiPowerOptionsTurbo = [{str:label.txPowerEnhance, value:uciWireless.dynOptValue.power.high},
							 {str:label.txPowerGeneral, value:uciWireless.dynOptValue.power.mid}];

/* MU-MIMO */
var muMimoOptions = [{str:label.muMimoOn, value:uciWireless.dynOptValue.muMimo.on},
					 {str:label.muMimoOff, value:uciWireless.dynOptValue.muMimo.off}];

/* WPS连接方式 */
var wpsMethod = [{str:label.wpsMethodButton, value:uciWireless.optValue.wps.button},
					  {str:label.wpsMethodPin, value:uciWireless.optValue.wps.pin}]

/* 路由/桥模式切换 */
var routerWorkModeOptions = [
	{
		str: label.routeMode,
		value: uciCustomNetwork.optValue.mode.route
	},
	{
		str: label.bridgeMode,
		value: uciCustomNetwork.optValue.mode.bridge
	}
]

/* END OF WIRELESS */