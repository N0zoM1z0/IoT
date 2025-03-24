//Version=1.01b06
//Language=ENGLISH
//Date=Fri, 14, Oct, 2011
//Merged=FALSE
//Merged Fw=FALSE
var msg = new Array ( //_NO_SHARE_NAME_
	"The IP Address entered is invalid", //INVALID_IP_ADDRESS
	"The IP Address cannot be zero.", //ZERO_IP_ADDRESS
	"IP Address", //IP_ADDRESS_DESC
	"The Subnet Mask entered is invalid", //INVALID_MASK_ADDRESS
	"The Subnet Mask cannot be zero", //ZERO_MASK_ADDRESS
	"Subnet Mask", //MASK_ADDRESS_DESC
	"The Gateway IP Address entered is invalid", //INVALID_GATEWAY_ADDRESS
	"The Gateway IP Address cannot be zero", //ZERO_GATEWAY_ADDRESS
	"Gateway IP Address", //GATEWAY_ADDRESS_DESC
	"%s Gateway IP address %s must be within the WAN subnet.", //NOT_SAME_DOMAIN
	"The Starting IP Address entered is invalid (IP Range: 1~254)", //INVALID_START_IP
	"Please enter another Starting IP Address", //ZERO_START_IP
	"Starting IP Address", //START_IP_DESC
	"The LAN IP Address and the Start IP Address are not in the same subnet", //START_INVALID_DOMAIN
	"The Ending IP Address entered is invalid (IP Range: 1~254)", //INVALID_END_IP
	"Please enter another Ending IP Address", //ZERO_END_IP
	"Ending IP Address", //END_IP_DESC
	"The LAN IP Address and the End IP Address are not in the same subnet", //END_INVALID_DOMAIN
	"The Primary DNS Address entered is invalid", //INVALID_DNS_ADDRESS
	"The Primary DNS Address cannot be zero", //ZERO_DNS_ADDRESS
	"Primary DNS Address", //DNS_ADDRESS_DESC
	"The SSID field cannot be blank", //SSID_EMPTY_ERROR
	"WEP cannot be disabled when the Authentication type is set to Shared Key", //AUTH_TYPE_ERROR
	"The length of the Passphrase must be at least 8 characters", //PSK_LENGTH_ERROR
	"The Confirmed Passphrase does not match the Passphrase", //PSK_MATCH_ERROR
	"The Confirmed Password does not match the New Password", //MATCH_PWD_ERROR
	"The selected WEP key field cannot be blank", //WEP_KEY_EMPTY
	"Please enter another Key", //WIZARD_KEY_EMPTY
	"Quit setup wizard and discard settings?", //QUIT_WIZARD
	"The MAC Address entered is invalid.", //MAC_ADDRESS_ERROR
	"The Ending IP Address must be greater than the Starting IP Address", //IP_RANGE_ERROR
	"The Secondary DNS Address entered is invalid", //INVALID_SEC_DNS_ADDRESS
	"The Secondary DNS Address cannot be zero", //ZERO_SEC_DNS_ADDRESS
	"Secondary DNS Address", //SEC_DNS_ADDRESS_DESC
	"The confirmed password does not match the new Admin password", //ADMIN_PASS_ERROR
	"The confirmed password does not match the new User password", //USER_PASS_ERROR
	"Please enter another Server Name", //DDNS_SERVER_ERROR
	"The Host Name is invalid.", //DDNS_HOST_ERROR
	"Please enter another User Name", //DDNS_USER_ERROR
	"Please enter another Password", //DDNS_PASS_ERROR
	"Are you sure you want to reset the device to its factory default settings?\nThis will cause all current settings to be lost.", //RESTORE_DEFAULT
	"Are you sure you want to reboot the device?\nRebooting will disconnect any active internet sessions.", //REBOOT_ROUTER
	"Load settings from a saved configuration file?", //LOAD_SETTING
	"You must enter the name of a configuration file first.", //LOAD_FILE_ERROR
	"Only the Admin account can download the settings", //DOWNLOAD_SETTING_ERROR
	"Please enter either a Host Name or an IP Address", //PING_IP_ERROR
	"Please enter another SMTP Server or IP Address", //SMTP_SERVER_ERROR
	"Please enter a valid email Address", //EMAIL_ADDRESS_ERROR
	"Are you sure that you want to delete this Virtual Server Rule?", //DEL_SERVER_MSG
	"Are you sure that you want to delete this Application Rule", //DEL_APPLICATION_MSG
	"Are you sure that you want to delete this Filter?", //DEL_FILTER_MSG
	"Are you sure that you want to delete this Route?", //DEL_ROUTE_MSG
	"Are you sure that you want to delete this MAC Address?", //DEL_MAC_MSG
	"Are you sure that you want to delete this Keyword?", //DEL_KEYWORD_MSG
	"Are you sure that you want to delete this Domain?", //DEL_DOMAIN_MSG
	"Are you sure that you want to delete this Entry?", //DEL_ENTRY_MSG
	"Are you sure that you want to delete this DHCP Reservation?", //DEL_STATIC_DHCP_MSG
	"Please enter another name", //NAME_ERROR
	"Please enter a Trigger Port number", //TRIGGER_PORT_ERROR
	"Please enter a Firewall Port number", //PUBLIC_PORT_ERROR
	"Please enter another Private Port number", //PRIVATE_PORT_ERROR
	"Please enter a Private IP Address.", //PRIVATE_IP_ERROR
	"Please enter another port number", //PORT_ERROR
	"Please select a Keyword to delete", //DEL_KEYWORD_ERROR
	"The Keyword entered already exists in the list", //SAME_KEYWORD_ERROR
	"Please enter another Keyword", //KEYWORD_ERROR
	"Unable to add another Keyword", //ADD_KEYWORD_ERROR
	"Please select a Blocked Domain to delete", //DEL_BLOCK_DOMAIN_ERROR
	"Please select a Permitted Domain to delete", //DEL_PERMIT_DOMAIN_ERROR
	"The Domain entered already exists in the list of Blocked Domains", //SAME_BLOCK_DOMAIN
	"Please enter another Blocked Domain", //BLOCK_DOMAIN_ERROR
	"Unable to add another Blocked Domain", //ADD_BLOCK_DOMAIN_ERROR
	"The Domain entered already exists in the list of Permitted Domains", //SAME_PERMIT_DOMAIN
	"Please enter another Permitted Domain", //PERMIT_DOMAIN_ERROR
	"Unable to add another Permitted Domain", //ADD_PERMIT_DOMAIN_ERROR
	"Please select a Firmware file to upgrade the router to", //FIRMWARE_UPGRADE_ERROR
	"Please enter another Domain", //DOMAIN_ERROR
	"Unable to add another Control Domains", //ADD_CONTROL_DOMAIN_ERROR
	"Please select a Control Domain to delete", //DEL_CONTROL_DOMAIN_ERROR
	"Please enter at least one Control Domain", //CONTROL_DOMAIN_ERROR
	"The RADIUS Server 1 IP Address entered is invalid", //INVALID_RADIUS_SERVER1_IP
	"The Radius Server 1 IP Address cannot be zero or blank", //ZERO_RADIUS_SERVER1_IP
	"Radius Server 1 IP Address", //RADIUS_SERVER1_IP_DESC
	"The RADIUS Server 2 IP Address entered is invalid", //INVALID_RADIUS_SERVER2_IP
	"The Radius Server 2 IP Address cannot be zero or blank", //ZERO_RADIUS_SERVER2_IP
	"Radius Server 2 IP Address", //RADIUS_SERVER2_IP_DESC
	"The IP Address entered is invalid (IP Range: 1~254)", //INVALID_STATIC_DHCP_IP
	"Please enter another IP Address", //ZERO_STATIC_DHCP_IP
	"Please enter another Name", //STATIC_DHCP_NAME
	"The Server IP Address entered is invalid", //INVALID_SERVER_IP
	"The Server IP Address cannot be zero or blank", //ZERO_SERVER_IP
	"Server IP Address", //SERVER_IP_DESC
	"The Passwords entered do not match", //MATCH_WIZARD_PWD_ERROR
	"The Source Start IP Address entered is invalid", //INVALID_SOURCE_START_IP
	"The Source Start IP Address cannot be zero or blank", //ZERO_SOURCE_START_IP
	"Source Start IP Address", //SOURCE_START_IP_DESC
	"The Source End IP Address entered is invalid", //INVALID_SOURCE_END_IP
	"The Source End IP Address cannot be zero or blank", //ZERO_SOURCE_END_IP
	"Source End IP Address", //SOURCE_END_IP_DESC
	"The Destination Start IP Address entered is invalid", //INVALID_DEST_START_IP
	"The Destination Start IP Address cannot be zero or blank", //ZERO_DEST_START_IP
	"Destination Start IP Address", //DEST_START_IP_DESC
	"The Destination End IP Address entered is invalid", //INVALID_DEST_END_IP
	"The Destination End IP Address cannot be zero or blank", //ZERO_DEST_END_IP
	"Destination End IP Address", //DEST_END_IP_DESC
	"The length of the Passphrase must be between 8 and 63 characters", //PSK_OVER_LEN
	"Reset JumpStart?", //RESET_JUMPSTAR
	"Are you sure that you want to delete this rule?", //DEL_RULE_MSG
	"Are you sure that you want to delete this schedule?", //DEL_SCHEDULE_MSG
	"Unable to add another schedule", //ADD_SCHEDULE_ERROR
	"Schedule Name can not empty", //SCHEDULE_NAME_ERROR
	"Schedule Name can not enter all space", //SCHEDULE_NAME_SPACE_ERROR
	"The Start Time entered is invalid", //START_TIME_ERROR
	"The End Time entered is invalid", //END_TIME_ERROR
	"The Start Time cannot be greater than the End Time", //TIME_RANGE_ERROR
	"Please select a machine first", //SELECT_MACHINE_ERROR
	"Please select an Application Name first", //SELECT_APPLICATION_ERROR
	"Please select a Computer Name first", //SELECT_COMPUTER_ERROR
	"Please enter another Wireless Security Password", //SECURITY_PWD_ERROR
	"The Parental Control rule entered is already in the list", //DUPLICATE_URL_ERROR
	"Login Name error", //LOGIN_NAME_ERROR
	"Login Password error", //LOGIN_PASS_ERROR
	"%s is conflicted with LAN IP address, please enter again.", //THE_SAME_LAN_IP
	"The PSK should Hex.", //THE_PSK_IS_HEX
	"The IP Address and the reservation IP Address are not in the same subnet.", //SER_NOT_SAME_DOMAIN
	"There is unsaved data on this page. Do you want to abandon it?\n IF not, press Cancel and then click Save Settings.\nIf so, press OK.", //IS_CHANGE_DATA
	"The confirmed password does not match the new User password", //DDNS_PASS_ERROR_MARTH
	"Nothing has changed, save anyway?", //FORM_MODIFIED_CHECK
	"Rule name can not be empty string!", //INBOUND_NAME_ERROR
	"The Ending Port number must be greater than the Starting Port number", //PORT_RANGE_ERROR
	"Are you sure that you want to enable/disable", //CHECK_ENABLE
	"Are you sure that you want to delete", //DEL_MSG
	"You must abandon all your changes in order to define a new schedule.\n Press 'Ok' to abandon these changes and display the Schedule page.\n Otherwise press 'Cancel'.", //GO_SCHEDULE
	"Please enter user name", //PPP_USERNAME_EMPTY
	"" //MAX
);
var INVALID_IP_ADDRESS=0;
var ZERO_IP_ADDRESS=1;
var IP_ADDRESS_DESC=2;
var INVALID_MASK_ADDRESS=3;
var ZERO_MASK_ADDRESS=4;
var MASK_ADDRESS_DESC=5;
var INVALID_GATEWAY_ADDRESS=6;
var ZERO_GATEWAY_ADDRESS=7;
var GATEWAY_ADDRESS_DESC=8;
var NOT_SAME_DOMAIN=9;
var INVALID_START_IP=10;
var ZERO_START_IP=11;
var START_IP_DESC=12;
var START_INVALID_DOMAIN=13;
var INVALID_END_IP=14;
var ZERO_END_IP=15;
var END_IP_DESC=16;
var END_INVALID_DOMAIN=17;
var INVALID_DNS_ADDRESS=18;
var ZERO_DNS_ADDRESS=19;
var DNS_ADDRESS_DESC=20;
var SSID_EMPTY_ERROR=21;
var AUTH_TYPE_ERROR=22;
var PSK_LENGTH_ERROR=23;
var PSK_MATCH_ERROR=24;
var MATCH_PWD_ERROR=25;
var WEP_KEY_EMPTY=26;
var WIZARD_KEY_EMPTY=27;
var QUIT_WIZARD=28;
var MAC_ADDRESS_ERROR=29;
var IP_RANGE_ERROR=30;
var INVALID_SEC_DNS_ADDRESS=31;
var ZERO_SEC_DNS_ADDRESS=32;
var SEC_DNS_ADDRESS_DESC=33;
var ADMIN_PASS_ERROR=34;
var USER_PASS_ERROR=35;
var DDNS_SERVER_ERROR=36;
var DDNS_HOST_ERROR=37;
var DDNS_USER_ERROR=38;
var DDNS_PASS_ERROR=39;
var RESTORE_DEFAULT=40;
var REBOOT_ROUTER=41;
var LOAD_SETTING=42;
var LOAD_FILE_ERROR=43;
var DOWNLOAD_SETTING_ERROR=44;
var PING_IP_ERROR=45;
var SMTP_SERVER_ERROR=46;
var EMAIL_ADDRESS_ERROR=47;
var DEL_SERVER_MSG=48;
var DEL_APPLICATION_MSG=49;
var DEL_FILTER_MSG=50;
var DEL_ROUTE_MSG=51;
var DEL_MAC_MSG=52;
var DEL_KEYWORD_MSG=53;
var DEL_DOMAIN_MSG=54;
var DEL_ENTRY_MSG=55;
var DEL_STATIC_DHCP_MSG=56;
var NAME_ERROR=57;
var TRIGGER_PORT_ERROR=58;
var PUBLIC_PORT_ERROR=59;
var PRIVATE_PORT_ERROR=60;
var PRIVATE_IP_ERROR=61;
var PORT_ERROR=62;
var DEL_KEYWORD_ERROR=63;
var SAME_KEYWORD_ERROR=64;
var KEYWORD_ERROR=65;
var ADD_KEYWORD_ERROR=66;
var DEL_BLOCK_DOMAIN_ERROR=67;
var DEL_PERMIT_DOMAIN_ERROR=68;
var SAME_BLOCK_DOMAIN=69;
var BLOCK_DOMAIN_ERROR=70;
var ADD_BLOCK_DOMAIN_ERROR=71;
var SAME_PERMIT_DOMAIN=72;
var PERMIT_DOMAIN_ERROR=73;
var ADD_PERMIT_DOMAIN_ERROR=74;
var FIRMWARE_UPGRADE_ERROR=75;
var DOMAIN_ERROR=76;
var ADD_CONTROL_DOMAIN_ERROR=77;
var DEL_CONTROL_DOMAIN_ERROR=78;
var CONTROL_DOMAIN_ERROR=79;
var INVALID_RADIUS_SERVER1_IP=80;
var ZERO_RADIUS_SERVER1_IP=81;
var RADIUS_SERVER1_IP_DESC=82;
var INVALID_RADIUS_SERVER2_IP=83;
var ZERO_RADIUS_SERVER2_IP=84;
var RADIUS_SERVER2_IP_DESC=85;
var INVALID_STATIC_DHCP_IP=86;
var ZERO_STATIC_DHCP_IP=87;
var STATIC_DHCP_NAME=88;
var INVALID_SERVER_IP=89;
var ZERO_SERVER_IP=90;
var SERVER_IP_DESC=91;
var MATCH_WIZARD_PWD_ERROR=92;
var INVALID_SOURCE_START_IP=93;
var ZERO_SOURCE_START_IP=94;
var SOURCE_START_IP_DESC=95;
var INVALID_SOURCE_END_IP=96;
var ZERO_SOURCE_END_IP=97;
var SOURCE_END_IP_DESC=98;
var INVALID_DEST_START_IP=99;
var ZERO_DEST_START_IP=100;
var DEST_START_IP_DESC=101;
var INVALID_DEST_END_IP=102;
var ZERO_DEST_END_IP=103;
var DEST_END_IP_DESC=104;
var PSK_OVER_LEN=105;
var RESET_JUMPSTAR=106;
var DEL_RULE_MSG=107;
var DEL_SCHEDULE_MSG=108;
var ADD_SCHEDULE_ERROR=109;
var SCHEDULE_NAME_ERROR=110;
var SCHEDULE_NAME_SPACE_ERROR=111;
var START_TIME_ERROR=112;
var END_TIME_ERROR=113;
var TIME_RANGE_ERROR=114;
var SELECT_MACHINE_ERROR=115;
var SELECT_APPLICATION_ERROR=116;
var SELECT_COMPUTER_ERROR=117;
var SECURITY_PWD_ERROR=118;
var DUPLICATE_URL_ERROR=119;
var LOGIN_NAME_ERROR=120;
var LOGIN_PASS_ERROR=121;
var THE_SAME_LAN_IP=122;
var THE_PSK_IS_HEX=123;
var SER_NOT_SAME_DOMAIN=124;
var IS_CHANGE_DATA=125;
var DDNS_PASS_ERROR_MARTH=126;
var FORM_MODIFIED_CHECK=127;
var INBOUND_NAME_ERROR=128;
var PORT_RANGE_ERROR=129;
var CHECK_ENABLE=130;
var DEL_MSG=131;
var GO_SCHEDULE=132;
var PPP_USERNAME_EMPTY=133;

var which_lang = new Array ( //_NO_SHARE_NAME_
	"When feature is enabled, your internet traffic will be protected by a security ready DNS server. This feature provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //_Advanced_01
	"When DNS Relay is enabled along with Advanced DNS feature,your workstations on the network that are obtaining an IP address from router's DHCP server will obtain 192.168.0.1 (router's IP address). However, traffic will still be protected.", //_Advanced_02
	"Although Advanced DNS feature is enabled, DNS IP address of your workstation can still be modified to the DNS server IP you desire. Please note that the router does not dictate the DNS name resolution when DNS IP address is configured on the workstation.", //_Advanced_03
	"If you selected this option and have VPN or Intranet setup in your network, you can disable Advanced DNS service if you experience connection difficulties.", //_Advanced_04
	"Advanced DNS Service", //bwn_ict_dns
	"Advanced DNS is a free security option that provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //bwn_msg_Modes_dns
	"Enable Advanced DNS Service", //ta_EUPNP_dns
	"Advanced DNS", //_dlinkdns
	"My USB type is", //new_bwn_mici_usb
	"Can't choose TKIP when 802.11n only.!!", //_tkip_11n
	"SharePort For Guest Zone", //bln_title_guest_use_shareport
	"Enable SharePort For Guest Zone", //bwn_mici_guest_use_shareport
	"Mixed 802.11n and 802.11g", //bwl_Mode_10
	"Enter the correct password above and then type the characters you see in the picture", //_authword
	"Regenerate", //_regenerate
	"Please enter the graphical authentication code.", //li_alert_4
	"Enable Graphical Authentication", //_graph_auth
	"USB 3.5G Settings", //usb3g_titile
	"APN Name", //usb3g_apn_name
	"Dial Mumber", //usb3g_dial_num
	"Reconnect Mode(0:always/1:OnDemand/2:Manual)", //usb3g_reconnect_mode
	"IDLE TIME", //usb3g_max_idle_time
	"USB DEVICE(0:3G Modem/1:KCODE)", //usb_device
	"USB 3.5G Manual", //usb3g_manual
	"USB 3.5G Statistic", //usb3g_stat_titile
	"USB Settings", //bln_title_usb
	"WCN Configuration", //usb_wcn
	"Use this section to configure your USB port. There are several configurations to choose from: Network USB, 3G USB Adapter and WCN Configuration.", //bwn_intro_usb
	"Network USB", //usb_network
	"3G USB Adapter", //usb_3g
	"Dial Number", //wwan_dial_num
	"WWAN Internet Connection Type", //bwn_wwanICT
	"Enter the information provided by your Internet Service Provider (ISP).", //_ispinfo
	"Authentication Protocol", //wwan_auth_label
	"Auto(PAP+CHAP)", //wwan_auth_auto
	"PAP only", //wwan_auth_pap
	"CHAP only", //wwan_auth_chap
	"MS CHAP only", //wwan_auth_mschap
	"Select to share a USB printer, scanner, or storage device connected to the USB port behind the router with multiple users within your network.", //usb_network_help
	"Device drivers and the D-Link USB Network Utility must be installed on each computer that will use the device.", //usb_network_support_help
	"Select 3G USB Adapter to use a 3G adapter to provide access to the Internet using an EV-DO cellular signal. Simply connect a 3G USB adapter to access the Internet (third party EV-DO subscription and available signal required).", //usb_3g_help
	"If you have trouble accessing the Internet through the router. Double check the settings you entered on this page and verify with your Internet Service Provider (ISP) if needed.", //usb_3g_help_support_help
	"Select to configure your wireless network using Windows Connect Now (WCN). WCN allows you to copy your wireless settings from the router to a USB flash drive and use to automatically configure the wireless settings on your computer(s) or other WCN-compatible devices.", //usb_wcn_help
	"My plug of USB type is", //bwn_mici_usb
	"Please set Network USB Detection interval time, the router will automatically detect the USB device.", //_info_netowrk
	"Enable Network USB Auto-Detection", //_network_usb_auto
	"Network USB Detection interval", //bwn_usb_time
	"sec (range:3-600 sec.)", //bwn_bytes_usb
	"Can't choose shared key when WPS is enable!!", //_wps_albert_1
	"Can't choos WPA-Enterprisey when WPS is enable!!", //_wps_albert_2
	"Please configure your WWAN settings.  If you are unsure of the settings, please contact your Internet Service Provider (ISP).", //usb_config1
	"Please configure your Internet Connection Type settings.  If you are unsure of the settings, please contact your Internet Service Provider (ISP).", //usb_config2
	"The Internet Connection Type is not for 3G Internet connection.  Please select WWAN to support 3G Internet connection.", //usb_config3
	"The Internet Connection Type is for 3G Internet connection, please select another Internet Connection Type.", //usb_config4
	"The Internet Connection Type you selected is for 3G Internet connection.  The USB settings will be changed from Network USB/WCN to 3G USB Adapter.", //usb_config5
	"The Internet Connection Type you selected is not for 3G Internet connection.  The USB settings will be changed from 3G USB Adapter to Network USB.", //usb_config6
	"Choose the type of USB device to be plugged into the USB port.", //bwn_msg_usb
	"If using the Network USB option, users will need to install the Network USB Utility into their computers to share the USB device through the router.", //bwn_note_usb
	"Country", //_country
	"Select your country", //_select_country
	"Select your ISP", //_select_ISP
	"Australia", //country_1
	"Italy", //country_2
	"Portugal", //country_3
	"UK", //country_4
	"Indonesia", //country_5
	"Malaysia", //country_6
	"Singapore", //country_7
	"Philippine", //country_8
	"South Africa", //country_9
	"HongKong", //country_10
	"Taiwan", //country_11
	"Egypt", //country_12
	"Dominican Republic", //country_13
	"El Salvador", //country_14
	"Brasil", //country_15
	"Select this option if you want to add a guest network", //S500
	"Network Type", //S496
	"Enable HTTPS Server", //LV2
	"The Email Now button is disabled because Email Notification is not enabled on <a href=\"tools_email.asp\" onclick=\"return jump_if();\" shape=\"rect\">Tools &rarr; Email</a> screen.", //logs_LW39b_email
	"Use HTTPS", //LV3
	"%s%sWireless system with MAC address %m secured and linked", //GW_WIRELESS_DEVICE_LINK_UP
	"All log entries were cleared.", //LT248
	"Discovering PPPoE servers for %s PPPoE Session", //GW_PPPOE_EVENT_DISCOVERY_ATTEMPT
	"5GHz Band", //GW_WLAN_RADIO_1_NAME
	"SMTP Server Port", //te_SMTPSv_Port
	"Can not change 802.11 Mode to 802.11n only, while there is an SSID with WEP security.", //GW_WLAN_CHANGING_PHY_MODE_TO_11NG_ONLY_INVALID
	"Select your Wireless Network", //S558
	"Select the Radio you Want to Configure", //KRL8
	"The selection helps you to define the Guest Zone scale.", //LY30
	"Virtual server '%s' can not use the router's HTTPS WAN administration port, %u", //GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
	"Wi-Fi protected setup disabled because security of SSID '%s' is set to WPA-Enterprise.", //GW_WIFISC_DISABLED_AUTOMATICALLY
	"Offer received for %s PPPoE Session, service offered is %s from %s (%m)", //GW_PPPOE_EVENT_OFFER
	"2.4GHz Band", //GW_WLAN_RADIO_0_NAME
	"%s PPPoE session protocol fault. Connection attempt failed.", //GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
	"PPPoE session name %s conflicts with other session name", //GW_WAN_PPPOE_SESSION_NAME_CONFLICT
	"Problem in receiving logs! Memory is too low to display logs or there is a problem with the connection.", //S525
	"Password can only contain printable characters.", //S493
	"You should examine these warnings, because some features may have been disabled or modified.", //KR136
	"Terminating %s PPPoE session ID %u", //GW_PPPOE_EVENT_DISCONNECT
	"Enhanced IGMP Proxy", //anet_multicast_enhanced
	"Use this section to enable routing between Host Zone and Guest Zone, Guest clients can not access Host clients' data without enable the function.", //LY34
	"%sWireless shut down", //GW_WIRELESS_SHUT_DOWN
	"%sWireless restart", //GW_WIRELESS_RESTART
	"The administration idle time should be in the range of 1 to 65535.", //S528
	"Port forwarding ALG failed to allocate session for TCP packet from %v:%u to %v:%u", //GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE
	"Use this section to configure the guest zone settings of your router. The guest zone provide a separate network zone for guest to access Internet.", //guestzone_Intro_1
	"Virtual server '%s' can not use the router's HTTPS WAN administration port, %u", //GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
	"Enable Routing Between Zones", //S473
	"Port should be in range (1..65535)", //te_SMTPSv_Port_alert
	"%sFailed to start wireless", //GW_WIRELESS_DEVICE_START_FAILED
	"Port forwarding ALG failed to allocate session for UDP packet from %v:%u to %v:%u", //GW_PORT_FORWARD_UDP_PACKET_ALLOC_FAILURE
	"%sDisconnect all stations", //GW_WIRELESS_DEVICE_DISCONNECT_ALL
	"Issuing request for offer for %s PPPoE Session", //GW_PPPOE_EVENT_OFFER_REQUEST
	"Router IP %v must be a valid host address", //GW_ROUTES_ROUTERS_IP_ADDRESS_INVALID
	"Port trigger ALG failed to allocate session for UDP packet from %v:%u to %v:%u", //GW_PORT_TRIGGER_UDP_PACKET_ALLOC_FAILURE
	"Can not set WEP security for an SSID, while 802.11 Mode is 802.11n only.", //GW_WLAN_SETTING_SSID_SECURITY_TO_WEP_INVALID
	"Virtual server '%s' can not use the router's HTTP WAN administration port, %u", //GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
	"Timeout, station left", //GW_WLAN_STATION_TIMEOUT
	"Virtual server '%s' can not use the router's IP address, %v.", //GW_NAT_VIRTUAL_SERVER_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
	"'%s' [protocol:%u]->%v conflicts with '%s' [protocol:%u]->%v.", //GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID
	"Specifies whether the Guest Zone will be enabled or disabled.", //LY28
	"Trying to establish %s PPPoE connection", //GW_PPPOE_EVENT_CONNECT
	"Trigger Ports", //GW_NAT_TRIGGER_PORT
	"Operating frequency band. Choose 2.4GHz for visibility to legacy devices and for longer range. Choose 5GHz for least interference; interference can hurt performance.", //KR971
	"Automatically assign a network key for both 2.4GHz and 5GHz band (Recommended)", //wwz_auto_assign_key3
	"Provide a name for Guest Zone wireless network.", //LY292
	"Securing your wireless network is important as it is used to protect the integrity of the information being transmitted over your wireless network. The router is capable of 4 types of wireless security; WEP, WPA only, WPA2 only, and WPA/WPA2 (auto-detect).", //LY293
	"If you choose the WEP security option this device                                         will <strong>ONLY</strong> operate in <strong>Legacy Wireless mode (802.11B/G)</strong>.                                         This means you will <strong>NOT</strong> get 11N performance due to the fact that WEP                                         is not supported by the Draft 11N specification.", //bws_msg_WEP_4
	"The route for %v on interface %s may not be created - only routes via gateways may be created on this interface", //GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID
	"DNS settings", //wwa_dnsset
	"This wizard is designed to assist you in connecting your guest wireless device to your wireless router. It will guide you through step-by-step instructions on how to get your guest wireless device connected. Click the button below to begin.", //wireless_gu
	"Add Guest Wireless with WPS", //add_gu_wps
	"Wireless Band", //wwl_band
	"Band", //_band
	"Manually set 5GHz band Network Name", //wwa_5G_nname
	"GUEST ZONE", //_guestzone
	"Guest Zone Selection", //guestzone_title_1
	"Enable Guest Zone", //guestzone_enable
	"Include Wireless", //guestzone_inclw
	"Guest", //guest
	"lower than wireless network", //lower_wnt
	"equal to wireless network", //equal_wnt
	"lowest", //_lowest
	"SSID List", //ssid_lst
	"Guest clients can reach to the internet along guest SSIDs", //dlink_help150
	"Multiple SSID", //mult_ssid
	"You may assign more than one SSID to each radio card.", //dlink_help155
	"Add/Edit SSID", //add_ed_ssid
	"Enable or disable this SSID. When enabled, the following parameters are in effect.", //dlink_help156
	"This is the network to which the SSID belongs; SSID clients that belong to the same network can transmit data over this subnet.", //dlink_help157
	"WAN Ping Inbound Filter", //wpin_filter
	"Select a filter that controls which WAN computers can use the ping feature. If you do not see the filter you need in the list of filters, go to the  Advanced → Inbound Filter screen and create a new filter.", //dlink_help151
	"The raw TCP port printing protocol uses a fixed IP address and TCP port to communicate with your printer.", //tps_raw1
	"(GMT+06:30) Rangoon", //up_tz_52
	"Destination IP address are same", //_r_alert_new1
	"Email Settings", //te_EmSt
	"Nov", //tt_Nov
	"Blocked outgoing packet from %v to %v (IP protocol %u)", //IPNAT_BLOCKED_EGRESS
	"Wireless Security Mode", //bws_WSMode
	"Pings lost:", //tsc_pingt_msg102
	"Give the rule a name that is meaningful to you, for example <code>Game Server</code>. You can also select from a list of popular games, and many of the remaining configuration values will be filled in accordingly. However, you should check whether the port values have changed since this list was created, and you must fill in the IP address field.", //help65
	"UPnP", //ta_upnp
	"Transmission Rate", //bwl_TxR
	"WAN interface speed measurement completed", //GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED
	"Average ping time (in milliseconds):", //tsc_pingt_msg106
	"All Day", //tsc_AllDay
	"Tiger Woods 2K4", //gw_gm_53
	"WAN interface speed measurements not started as low on resources", //GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR
	"Lost lease on IP Address", //DHCP_CLIENT_LOST_LEASE
	"Choose a schedule to apply to this policy.", //_aa_wiz_s3_msg
	"Authentication Timeout:", //help385
	"Good timekeeping is important for accurate logs and scheduled firewall rules.", //hhtt_intro
	"Final Fantasy XI (PC)", //gw_gm_20
	"The IP address of the authentication server.", //help388
	"Set the Date and Time Manually", //tt_StDT
	"OK", //_ok
	"Status", //_status
	"Out", //_Out
	"What to View", //sl_WtV
	"STA with MAC (%m) requested for WPS registration", //WIFISC_AP_PROXY_PROCESS_START
	"The setup wizard was unable to communicate with the printer.", //wprn_nopr2
	"When you are browsing for available wireless networks, this is the name that will appear in the list (unless Visibility Status is set to Invisible, see below). This name is also referred to as the SSID. For security purposes, it is highly recommended to change from the pre-configured network name.", //help352
	"Network Name (SSID)", //wwz_wwl_wnn
	"IP Address", //_ipaddr
	"gw_wireless_schedule start", //GW_WLS_SCHEDULE_START
	"The direction of initiation of the conversation:", //help820
	"If all the computers on the LAN successfully obtain their IP addresses from the router's DHCP server as expected, this option can remain disabled. However, if one of the computers on the LAN fails to obtain an IP address from the router's DHCP server, it may have an old DHCP client that incorrectly turns off the broadcast flag of DHCP packets. Enabling this option will cause the router to always broadcast its responses to all clients, thereby working around the problem, at the cost of increased broadcast traffic on the LAN.", //help326
	"(GMT+08:00) Krasnoyarsk", //up_tz_54
	"Note: Some browsers have limitations that make it impossible to update the WAN status display when the status changes. Some browsers require that you refresh the display to obtain updated status. Some browsers report an error condition when trying to obtain WAN status.", //help773
	"MAC Filtering Rules", //am_MACFILT
	"are same Machine.", //aa_alert_7_new1
	"Each networking device has it's own unique MAC address defined by the hardware manufacturer. Some ISP's may check your computer's MAC address. Some ISP's record the MAC address of the network adapter in the computer or router used to initially connect to their service. The ISP will then only grant Internet access to requests from a computer or router with this particular MAC address. This router has a different MAC address than the computer or router that initially connected to the ISP.", //help302
	"The Access Control option allows you to control access in and out of your network. Use this feature as Access Controls to only grant access to approved sites, limit web access based on time or dates, and/or block internet access for applications like P2P utilities or games.", //aa_intro
	"This shows clients that you have specified to have reserved DHCP addresses. An entry can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the \"Edit DHCP Reservation\" section is activated for editing.", //help348
	"PainKiller", //gw_gm_35
	"Informational", //sl_Infrml
	"Wireless", //_wireless
	"RADIUS server IP Address", //bws_RIPA
	"Enabling WLAN Partition prevents associated wireless clients from communicating with each other.", //KR58_ww
	"If Automatic Uplink Speed is disabled, this option allows you to set the uplink speed manually. Uplink speed is the speed at which data can be transferred from the router to your ISP. This is determined by your ISP. ISPs often specify speed as a downlink/uplink pair; for example, 1.5Mbps/284kbps. For this example, you would enter \"284\". Alternatively you can test your uplink speed with a service such as <a href=\"http://www.dslreports.com\">www.dslreports.com</a>. Note however that sites such as DSL Reports, because they do not consider as many network protocol overheads, will generally note speeds slightly lower than the Measured Uplink Speed or the ISP rated speed.", //help83
	"If the <strong>Measured Uplink Speed</strong> is known to be incorrect (that is, it produces suboptimal performance), disable <strong>Automatic Uplink Speed</strong> and enter the <strong>Manual Uplink Speed</strong>. Some experimentation and performance measurement may be required to converge on the optimal value.", //hhase_intro
	"Error loading configuration from non-volatile memory (Magic number mis-match). Reset configuration to factory defaults", //RUNTIME_CONFIG_MAGIC_NUM_ERROR
	"Sat", //_Sat
	"Website Filtering Rules", //awf_title_WSFR
	"You can select a computer from the list of DHCP clients in the \"Computer Name\" drop-down menu, or you can manually enter the IP address of the server computer.", //help18_a
	"ALLOW computers access to ONLY these sites", //dlink_wf_op_1
	"Far Cry", //gw_gm_18
	"Call of Duty", //gw_gm_7
	"Found USB mass storage with subclass %u protocol %u", //USB_LOG_STORAGE_TYPE
	"Game Server", //help346
	"This will cause all current settings to be lost.", //up_rb_5
	"WEP", //_WEP
	"MSCHAP send authentication response (Failure and no Retry).", //IPMSCHAP_AUTH_FAIL_AND_NO_RETRY
	"SWAT 4", //gw_gm_82
	"The supported authentication protocols are PAP and CHAP.", //bw_sap
	"Enter the static address information provided by your Internet Service Provider (ISP).", //bwn_msg_SWM
	"The network connection seems to be down. Press 'Ok' to try again.", //li_alert_2
	"When Access Control is disabled, every device on the LAN has unrestricted access to the Internet. However, if you enable Access Control, Internet access is restricted for those devices that have an Access Control Policy configured for them. All other devices have unrestricted access to the Internet.", //help120
	"IGMP host has rejected group %v due to low system resources", //IGMP_HOST_LOW_RESOURCES
	"- Exactly 10 or 26 characters using 0-9 and A-F", //wwl_s4_intro_z3
	"Enable this option if you have a syslog server currently running on the LAN and wish to send log messages to it.", //help858
	"Windows 2000", //help339
	"Enable Logging to Syslog Server", //help857
	"Enter the port range that you want to open up to Internet traffic (for example <code>6000-6200</code>).", //help51
	"THE ADDRESSING OF THE INTERNET SIDE LEARNT THRU PPPoE CONFLICTS WITH THE ADDRESSING SELECTED FOR THE LAN SIDE. INTERNET COMMUNICATIONS WILL BE DISABLED UNTIL YOU HAVE CHANGED THE LAN SIDE ADDRESSING TO RESOLVE THE PROBLEM", //GW_WAN_LAN_ADDRESS_CONFLICT_PPP
	"Errors", //ss_Errors
	"If a dynamic DNS update fails for any reason (for example, when incorrect parameters are entered), the router automatically disables the Dynamic DNS feature and records the failure in the log.", //help899
	"please enter the PIN from your wireless device and click the below 'Connect' Button", //wps_p3_4
	"The DMZ capability is just one of several means for allowing incoming requests that might appear unsolicited to the NAT. In general, the DMZ host should be used only if there are no other alternatives, because it is much more exposed to cyberattacks than any other system on the LAN. Thought should be given to using other configurations instead: a virtual server, a port forwarding rule, or a port trigger. Virtual servers open one port for incoming sessions bound for a specific application (and also allow port redirection and the use of ALGs ). Port forwarding is rather like a selective DMZ, where incoming traffic targeted at one or more ports is forwarded to a specific LAN host (thereby not exposing as many ports as a DMZ host). Port triggering is a special form of port forwarding, which is activated by outgoing traffic, and for which ports are only forwarded while the trigger is active.", //haf_dmz_40
	"Click the <strong>Edit</strong> icon to change an existing schedule.", //hhts_edit
	"Wireless Network Name (SSID)", //wwl_wnn
	"Web site %S accessed from %s", //WEB_FILTER_LOG_URL_ACCESSED_MAC
	"WMM Enable", //aw_WE
	"Setup Help", //help201a
	"Activate Your FREE 30 Day Trial Here", //_bsecure_activate_trial
	"Enter the password or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields.", //help896
	"The communications protocol used for the conversation.", //help815
	"Netmask", //_netmask
	"Please wait...", //_please_wait
	"Repeat these steps for each Virtual Server Rule you wish to add. After the list is complete, click <span class=\"button_ref\">Save Settings</span> at the top of the page.", //help12
	"The MAC (Media Access Controller) Address filter option is used to control network access based on the MAC Address of the network adapter. A MAC address is a unique ID assigned by the manufacturer of the network adapter. This feature can be configured to ALLOW or DENY network/Internet access.", //am_intro_1
	"LCP sets local auth: %04x", //IPPPPLCP_SET_LOCAL_AUTH
	"Crimson Skies", //gw_gm_11
	"Don't Save Settings", //_dontsavesettings
	"The WPA (Wi-Fi Protected Access) key must meet following guildelines", //wwl_s4_intro_za1
	"MTU default =", //_308
	"The section lists the current denied or allowed web sites.", //dlink_help148
	"MAC", //aa_AT_1
	"L2TP local tunnel 0x%04X aborted", //IPL2TP_TUNNEL_ABORTING
	"Add/Edit DHCP Reservation", //help330
	"Scheduling for Wireless Settings", //dlink_1_bwl_schld
	"L2TP client.", //wwa_msg_l2tp
	"04:00 PM", //tt_time_5
	"Enter the IP Address of the machine on your LAN (for example: <code>192.168.0.50</code>", //help6
	"Time", //_time
	"xDSL Or Other Frame Relay Network", //at_xDSL
	"Step 2: Launch the setup executable on your computer", //wprn_intro4
	"Normally, this is set to \"auto\". If you have trouble connecting to the WAN, try the other settings.", //help296
	"LAN", //_LAN
	"Warcraft III", //gw_gm_60
	"Select the machine to which this policy applies.", //_aa_wiz_s4_msg
	"64 bits", //wwl_64bits
	"Disk is full", //IPFAT_DISK_FULL
	"Go to your Start menu, select Programs, select Accessories, and select Command Prompt. At the command prompt type <code>ipconfig /all</code> and hit Enter. The physical address displayed for the adapter connecting to the router is the MAC address.", //help341
	"Your D-Link Router includes an integrated print server that allows a printer to be shared between multiple computers on your network. This page displays status information about the print server and any attached printer.", //sps_intro3
	"Press 'Ok' to abandon these changes and display the Schedule page.", //aa_sched_conf_2
	"Trying to start L2TP local session 0x%04X", //IPL2TP_SESSION_CONNECTING
	"Time synchronization failed (status %d)", //NET_RTC_SYNCHRONIZATION_FAILED
	"Automatically Check Online for Latest Firmware Version", //tf_AutoCh
	"The printer manufacturer and/or model could not be determined, possibly due to an invalid device ID reported by the printer. The wizard cannot continue without this information.", //wprn_iderr2
	"These two IP values (<i>from</i> and <i>to</i>) define a range of IP addresses that the DHCP Server uses when assigning addresses to computers and devices on your Local Area Network. Any addresses that are outside of this range are not managed by the DHCP Server; these could, therefore, be used for manually configured devices or devices that cannot use DHCP to obtain network address details automatically.", //help319
	"<b>Note:</b> Putting a computer in the DMZ may expose that computer to a variety of security risks. Use of this option is only recommended as a last resort.", //af_intro_2
	"Clicking this button refreshes the display of log entries. There may be new events since the last time you accessed the log.", //help800
	"Device Information", //sd_title_Dev_Info
	"Internet access port filter dropped packet from %v to %v (protocol %u)", //GW_INET_ACCESS_DROP_PORT_FILTER
	"Windows Connect Now", //_connow
	"SIP ALG rejected packet from %v:%u to %v:%u", //IPSIPALG_REJECTED_PACKET
	"Dropped TCP packet from %v:%u to %v:%u as unable to modify header options", //IPNAT_TCP_UNABLE_TO_MODIFY_OPTIONS
	"Select NTP Server", //tt_SelNTPSrv
	"A noisy radio-frequency environment can cause a high error rate on the wireless LAN.", //help812
	"User", //_user
	"(GMT+08:00) Taipei", //up_tz_59
	"Special Applications", //SPECIAL_APP
	"NONE", //wwl_NONE
	"Starting WAN Services", //GW_WAN_SERVICES_STARTED
	"Forbidden Web Access", //fb_FbWbAc
	"You have to open up the Web-based management interface and click the Connect button manually any time that you wish to connect to the Internet.", //help275
	"No Printer Detected", //wprn_nopr
	"Time Zone", //tt_TimeZ
	"Troubleshooting Tips", //wprn_tt
	"Select your local time zone from pull down menu.", //help841
	"Define a new schedule", //aa_sched_new
	"01:00 PM", //tt_time_14
	"HTTP", //gw_vs_1
	"SysLog Settings", //tsl_SLSt
	"H.323 ALG rejected packet from %v:%u to %v:%u", //IPH323ALG_REJECTED_PACKET
	"Step 4 - Select filtering method", //aa_wiz_s1_msg4
	"Windows 98", //help336
	"System Name", //ta_sn
	"Depending on whether you are currently logged in to BigPond, you can click either the <span class=\"button_ref\">BigPond Login</span> to attempt to establish the WAN connection or the <span class=\"button_ref\">BigPond Logout</span> to break the WAN connection.", //help780
	"Interface", //_interface
	"Web site %S blocked for %v", //WEB_FILTER_LOG_URL_BLOCKED
	"Remote Admin Port confict with Virtual Server Item", //vs_http_port
	"The router provides a tight firewall by virtue of the way NAT works. Unless you configure the router to the contrary, the NAT does not respond to unsolicited incoming requests on any port, thereby making your LAN invisible to Internet cyberattackers. However, some network applications cannot run with a tight firewall. Those applications need to selectively open ports in the firewall to function correctly. The options on this page control several ways of opening the firewall to address the needs of specific types of applications.", //haf_intro_1
	"(GMT-06:00) Central America", //up_tz_07
	"If you are not familiar with these Advanced Wireless settings, please read the help section before attempting to modify these settings.", //aw_intro
	"Gateway Address", //wwa_gw
	"Sentinel Services", //_sentinel_serv
	"Choose this option if your Internet Setup Provider provided you with IP Address information that has to be manually configured.", //wwa_msg_sipa
	"Dropped TCP packet from %v to %v as unable handle packet header", //IPNAT_TCP_UNABLE_TO_HANDLE_HEADER
	"You can select a computer from the list of DHCP clients in the <strong>Computer Name</strong> drop down menu, or you can manually enter the IP address of the computer at which you would like to open the specified port.", //hhav_ip
	"Few applications truly require the use of the DMZ host. Following are examples of when a DMZ host might be required:", //haf_dmz_50
	"Policy %s stopped; Internet access for MAC address %m changed to: %s", //GW_INET_ACCESS_POLICY_END_MAC
	"The Schedule configuration option is used to manage schedule rules for various firewall and parental control features.", //tsc_intro_Sch
	"Access denied to wireless system with MAC address %m", //GW_WLAN_ACCESS_DENIED
	"Local Domain Name", //_262
	"This option is enabled by default so that your router will automatically determine which programs should have network priority.", //help79
	"BigPond not configured properly", //GW_BIGPOND_CONFIG
	"High", //aw_TP_0
	"Establishing (please wait...)", //_sdi_s3
	"Ping Test", //tsc_pingt
	"IPv6 Ping Test", //tsc_pingt_v6
	"WPA-Personal", //_WPApersonal
	"EMail Settings", //_email
	"PPPoE confirming session offer", //PPPOE_EVENT_DISCOVERY_REQUEST
	"Firewall", //_firewall
	"Static IP Address Connection", //wwa_wanmode_sipa
	"System Check", //_syscheck
	"The LAN-side IP address of the client.", //help784
	"Unknown", //UNKNOWN
	"Your D-Link router uses 192.168.0.1 for the IP address. You've assigned a computer that you want to designate as a Web server with a static IP address of 192.168.0.3. You've assigned another computer that you want to designate as an FTP server with a static IP address of 192.168.0.4. Therefore the starting IP address for your DHCP IP address range needs to be 192.168.0.5 or greater.", //help322
	"UPnP is short for Universal Plug and Play, which is a networking architecture that provides compatibility among networking equipment, software, and peripherals. This router has optional UPnP capability, and can work with other UPnP devices and software.", //help_upnp_1
	"Wolfenstein: Enemy Territory", //gw_gm_61
	"(optional)", //_optional
	"Setting the Fragmentation value too low may result in poor performance.", //help181
	"Internet", //help569
	"If you are not familiar with these Advanced Network settings, please read the help section before attempting to modify these settings.", //anet_intro
	"Enter the email address where you want the email sent.", //help862
	"Blocked outgoing TCP packet from %v:%u to %v:%u as %s received but there is no active connection", //IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN
	"Gateway Name", //ta_GWN
	"If you are not authorized to modify the router's configuration, contact the router administrator.", //wprn_tt3
	"MTU:", //help293
	"If your ISP has assigned a fixed IP address, select this option. The ISP provides the value for the", //help265_2
	"Dropped packet from %v to %v (IP protocol %u) as unable to create new session", //IPNAT_UNABLE_TO_CREATE_CONNECTION
	"Always on:", //help270
	"Advanced Wireless Settings", //aw_title_2
	"Firewall Settings", //_firewalls
	"Enables 802.11d operation. 802.11d is a wireless specification for operation in additional regulatory domains. This supplement to the 802.11 specifications defines the physical layer requirements (channelization, hopping patterns, new values for current MIB attributes, and other requirements to extend the operation of 802.11 WLANs to new regulatory domains (countries). The current 802.11 standard defines operation in only a few regulatory domains (countries). This supplement adds the requirements and definitions necessary to allow 802.11 WLAN equipment to operate in markets not served by the current standard. Enable this option if you are operating in one of these \"additional regulatory domains\".", //help186
	"PPPoE session 0x%04X established", //PPPOE_EVENT_UP
	"Protocol", //_protocol
	"WPA-Personal and WPA-Enterprise", //help372
	"(GMT+02:00) Bucharest", //up_tz_32
	"kbps", //at_kbps
	"Cable Or Other Broadband Network", //at_Cable
	"100Mbps", //anet_wp_1
	"Assign a meaningful name to the virtual server, for example <code>Web Server</code>. Several well-known types of virtual server are available from the \"Application Name\" drop-down list. Selecting one of these entries fills some of the remaining parameters with standard values for that type of server.", //help17
	"By default there is no password configured. It is highly recommended that you create a password to keep your router secure.", //ta_intro_Adm2
	", Please check", //tool_admin_check
	"PPP network up with IP Address %v", //IPPPPIPCP_PPP_LINK_UP
	"Stop", //_stop
	"Syslog server set as IP address %v", //GW_SYSLOG_STATUS
	"DHCP Server Settings", //bd_title_DHCPSSt
	"The name of the router can be changed here.", //help827
	"Check Latest Firmware Version", //tf_FWCheckInf
	"Firmware Information", //tf_FWInf
	"Up to eight ranges of WAN IP addresses can be controlled by each rule. The checkbox by each IP range can be used to disable ranges already defined.", //hhai_ipr
	"It is recommended that you leave these parameters at their default values. Adjusting them could limit the performance of your wireless network.", //hhaw_1
	"Allows multiple VPN clients to connect to their corporate networks using IPSec. Some VPN clients support traversal of IPSec through NAT. This option may interfere with the operation of such VPN clients. If you are having trouble connecting with your corporate network, try disabling this option.", //help34
	"Enable NTP Server", //tt_EnNTP
	"The subnet mask of your router on the local area network.", //help309
	"You cannot add new MAC addresses. You can only reuse MAC addresses from other policies.", //aa_alert_15
	"Save Settings", //_savesettings
	"Give the schedule a name that is meaningful to you, such as \"Weekday rule\".", //help193
	"Virtual Server Parameters", //help14_p
	"Need for Speed: Hot Pursuit 2", //gw_gm_32
	"Blocked incoming TCP connection request from %v:%u to %v:%u", //IPNAT_TCP_BLOCKED_INGRESS_SYN
	"If you enable this feature, the WAN port of your router will respond to ping requests from the Internet that are sent to the WAN IP Address.", //anet_msg_wan_ping
	"Inbound Filters can be used for limiting access to a server on your network to a system or group of systems.", //ai_intro_2
	"L2TP Subnet Mask", //help285
	"LAN Statistics", //ss_LANStats
	"A restore is already in progress.", //ta_alert_4
	"Copy Your PC's MAC Address", //_clone
	"Diablo I and II", //gw_gm_14
	"Dropped GRE packet from %v to %v as unable handle packet header", //PPTP_ALG_GRE_UNABLE_TO_HANDLE_HEADER
	"Block Some Access", //_aa_block_some
	"Established -- the connection is passing data.", //help819_3
	"11:00 PM", //tt_time_24
	"Normally email is sent at the start time defined for a schedule, and the schedule end time is not used. However, rebooting the router during the schedule period will cause additional emails to be sent.", //help873
	"Collisions", //ss_Collisions
	"Enter the SMTP server address for sending email.", //help863
	"This option enables configuration of an optional second RADIUS server. A second RADIUS server can be used as backup for the primary RADIUS server. The second RADIUS server is consulted only when the primary server is not available or not responding. The fields <span class=\"option\">Second RADIUS Server IP Address</span>, <span class=\"option\">RADIUS Server Port</span>, <span class=\"option\">Second RADIUS server Shared Secret</span>, <span class=\"option\">Second MAC Address Authentication</span> provide the corresponding parameters for the second RADIUS Server.", //help397
	"Virtual Servers List", //av_title_VSL
	"Off", //_off
	"Email me if a newer Firmware is available", //tf_ENFA
	"With this Virtual Server entry, all Internet traffic on Port 8888 will be redirected to your internal web server on port 80 at IP Address 192.168.0.50.", //help13
	"Step 3: Configure your Internet Connection", //wwa_title_s3
	"Step 1: Configure your Internet Connection", //ES_wwa_title_s1
	"WAN interface speed measurement aborted as they did not converge", //GW_WAN_RATE_ESTIMATOR_CONVERGENCE_ERROR
	"BigPond", //wwa_wanmode_bigpond
	"The WAN (Wide Area Network) section is where you configure your Internet Connection type.", //help254
	"To handle incoming connections that use a protocol other than ICMP, TCP, UDP, and IGMP (also GRE and ESP, when these protocols are enabled by the PPTP and IPSec ALGs ).", //haf_dmz_70
	"System error occured when attaching with schedule %s", //GW_SCHED_ATTACH_FAILED
	"The SSID field can not be blank", //_badssid
	"Stored configuration to non-volatile memory", //RUNTIME_CONFIG_STORING_CONFIG_IN_NVRAM
	"Firmware Update is Available", //FW_UPDATE_AVAILABLE
	"The Website Filter option allows you to set up a list of Web sites you would like to allow or deny through your network. To use this feature, you must also select the \"Apply Web Filter\" checkbox in the Access Control section.", //dlink_awf_intro_WF
	"The Dynamic DNS feature allows you to host a server (Web, FTP, Game Server, etc.) using a domain name that you have purchased (www.whateveryournameis.com) with your dynamically assigned IP address. Most broadband Internet Service Providers assign dynamic (changing) IP addresses. When you use a Dynamic DNS service provider, your friends can enter your host name to connect to your server, no matter what your IP address is.", //help891
	"PPPoE, PPTP, L2TP Connection", //help777
	"MAC Address Authentication:", //help393
	"Internet Connection Type", //bwn_ict
	"Jun", //tt_Jun
	"L2TP local tunnel 0x%04X has been connected to \"%s\"", //IPL2TP_TUNNEL_CONNECTED
	"Command and Conquer Zero Hour", //gw_gm_9
	"Aliens vs. Predator", //gw_gm_2
	"Wireless Network Setup Wizard", //wwl_wl_wiz
	"DHCP Range Invalid, FROM not bigger than TO", //network_dhcp_range
	"Step 4: Print a test page", //wprn_intro6
	"BigPond failed, state=%d with error=%d, server response=%s", //GW_BIGPOND_FAIL
	"Address Restricted", //af_EFT_1
	"Use Unicasting", //_use_unicasting
	"Network Status", //_networkstate
	"Year", //tt_Year
	"Failed to mount USB device", //IPASYNCFILEUSB_MOUNT_FAILED
	"UDP Endpoint Filtering", //af_UEFT
	"By default the fastest possible transmission rate will be selected. You have the option of selecting the speed if necessary.", //help356
	"Pre-Shared Key:", //help381
	"Inbound Filter", //_inboundfilter
	"Apply Advanced Port Filters", //_aa_apply_port_filter
	"Dest<br />Port<br />End", //aa_FPR_c7
	"Jedi Knight III: Jedi Academy", //gw_gm_27
	"BigPond not properly configured", //BIGPOND_NOT_PROPERLY_CFGD
	"As an alternative, you can locate a MAC address in a specific operating system by following the steps below:", //help335
	"(GMT+08:00) Perth", //up_tz_58
	"Never", //_never
	"Clicking this button erases all log entries.", //help801
	"Longest ping time (in milliseconds):", //tsc_pingt_msg105
	"WARNING: JavaScript is not enabled for this browser!", //li_WJS
	"To Email Address", //te_ToEm
	"12:00 AM", //tt_time_1
	"Signal", //help787
	"Obtained IP Address using DHCP. IP address is %v", //DHCP_CLIENT_GOT_LEASE
	"Gateway Logs", //GW_EMAIL_SUBJ
	"Port trigger ALG failed to allocate session for UDP packet from %v:%u to %v:%u", //IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE
	"If you are new to networking and have never configured a router before, click on <span class=\"button_ref\">Setup Wizard</span> and the router will guide you through a few simple steps to get your network up and running.", //bi_wiz
	"Out", //EGRESS
	"Check the <strong>Application Name</strong> drop down menu for a list of predefined applications. If you select one of the predefined applications, click the arrow button next to the drop down menu to fill out the corresponding field.", //hhpt_app
	"DHCP Connection (Dynamic IP Address)", //_dhcpconn
	"Router Settings", //bln_title_Rtrset
	"Print Server", //_ps
	"This entry is optional. Enter a domain name for the local network. The AP's DHCP server will give this domain name to the computers on the wireless LAN. So, for example, if you enter <code>mynetwork.net</code> here, and you have a wireless laptop with a name of <code>chris</code>, that laptop will be known as <code>chris.mynetwork.net</code>.", //_1044
	"Select this option if your wireless adapters SUPPORT WPA2", //wwl_text_best
	"PPTP Server IP Address (may be same as gateway)", //wwa_pptp_svraddr
	"WAN interface speed measurement completed. Upstream speed is %u kbps", //GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
	"LAN Computers", //_LANComputers
	"You may want to make the email settings similar to those of your email client program.", //hhte_intro
	"H.323 (Netmeeting)", //as_NM
	"Setup Wizard", //wwa_setupwiz
	"and", //help264
	"(compatibility for some DHCP Servers)", //bw_WDUU_note
	"MMS", //as_MMS
	"Service Name", //_srvname
	"The rule applies to a flow of messages whose LAN-side IP address falls within the range set here.", //help93
	"Minute", //tt_Minute
	"State", //sa_State
	"802.11d Enable", //aw_dE
	"Host Name or IP Address", //tsc_pingt_h
	"Host Name or IPv6 Address", //tsc_pingt_h_v6
	"Wireless Statistics", //ss_WStats
	"MSCHAP authenticator send challenge.", //IPMSCHAP_AUTH_SEND_CHALLENGE
	"Welcome to the D-Link Printer Setup Wizard", //wprn_intro1
	"When this option is enabled, your router will check online periodically to see if a newer version of the firmware is available.", //help889
	"H.323 (NetMeeting)", //as_H323
	"Port Forwarding Item", //tool_admin_pfname
	"Dropped packet from %v to %v (protocol %u) as session already exists", //IPNAT_SESSION_ALREADY_EXISTS
	"Set BigPond Cable Connection", //wwa_title_set_bigpond
	"(GMT-04:00) Santiago", //up_tz_16
	"BigPond state changed, new state=%d", //GW_BIGPOND_STATUS
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need BigPond Server IP adress. If you do not have this information, please contact your ISP.", //wwa_msg_set_bigpond
	"Enable Authentication", //te_EnAuth
	"Select this option if you want to synchronize the router's clock to a Network Time Server over the Internet. If you are using schedules or logs, this is the best way to ensure that the schedules and logs are kept accurate.", //help848
	"Return to Castle Wolfenstein", //gw_gm_41
	"Policy Wizard", //_aa_pol_wiz
	"IP Filters", //IP_FILTERS
	"Starsiege Tribes", //gw_gm_50
	"Please select your Internet connection type below:", //wwa_intro_s3
	"Dropped ESP packet from %v as connection attempt already pending from %v to %v", //IPSEC_ALG_ESP_ESTABLISH_ALREADY_PENDING
	"Individual (80, 68, 888)", //help59
	"Are you sure you want to reset the device to Unconfiged?", //wps_reboot_need
	"Dynamic Fragmentation", //at_DF
	"If the ISP's servers assign the router's IP addressing upon establishing a connection, select this option.", //help265_7
	"DST end month must be different than DST start month", //tt_alert_dstchkmonth
	"(GMT-01:00) Cape Verde Is.", //up_tz_23
	"Advanced", //_advanced
	"Static IP Address", //STATIC_IP_ADDRESS
	"Step 2: Secure your Wireless Network", //wwl_title_s3
	"This is a list of all wireless clients that are currently connected to your wireless router.", //hhsw_intro
	"Menu", //ish_menu
	"(GMT+02:00) Cairo", //up_tz_33
	"Failed to check for new firmware", //GW_FW_NOTIFY_FIRMWARE_ERROR
	"More info...", //_bsecure_more_info
	"Current Firmware Version", //tf_CFWV
	"2nd", //tt_week_2
	"Example:", //help3
	"Creator", //_creator
	"DNS Relay", //bln_title_DNSRly
	"Internet access port filter dropped packet from %v:%u[%s] to %v:%u (protocol %u)", //GW_INET_ACCESS_DROP_PORT_FILTER_MAC
	"Glossary", //ish_glossary
	"A longer WEP key is more secure than a short one", //wwl_s4_intro_z4
	"By default, the Access Control feature is disabled. If you need Access Control, check this option.", //help118
	"Shareaza", //gw_gm_66
	"When DNS Relay is enabled, the router plays the role of a DNS server. DNS requests sent to the router are forwarded to the ISP's DNS server. This provides a constant DNS address that LAN computers can use, even when the router obtains a different DNS server address from the ISP upon re-establishing the WAN connection. You should disable DNS relay if you implement a LAN-side DNS server as a virtual server.", //help312dr2
	"All Day - 24 hrs", //tsc_24hrs
	"Check the <strong>Application Name</strong> drop down menu for a list of predefined applications. If you select one of the predefined applications, click the arrow button next to the drop down menu to fill out the corresponding field.", //hhag_10
	"Some ISP's may check your computer's Host Name. The Host Name identifies your system to the ISP's server. This way they know your computer is eligible to receive an IP address. In other words, they know that you are paying for their service.", //help261
	"Trigger Traffic Type", //as_TPrt
	"This will happen if you have an Access Control Rule configured for this LAN machine.", //help28
	"11:00 AM", //tt_time_12
	"Refresh Statistics", //ss_reload
	"Packets received by the DMZ host have their IP addresses translated from the WAN-side IP address of the router to the LAN-side IP address of the DMZ host. However, port numbers are not translated; so applications on the DMZ host can depend on specific port numbers.", //haf_dmz_30
	"The following <span id=\"status_text\">printer is</span> attached to your router.", //sps_fp
	"Unreal Tournament 2004", //gw_gm_57
	"Choose this if your Internet connection automatically provides you with an IP Address. Most Cable Modems use this type of connection.", //wwa_msg_dhcp
	"Step 1 - Choose a unique name for your policy", //aa_wiz_s1_msg1
	"You must be logged in as 'admin' to perform this action", //MUST_BE_LOGGED_IN_AS_ADMIN
	"(GMT+09:30) Darwin", //up_tz_64
	"gw_wireless_schedule stop", //GW_WLS_SCHEDULE_STOP
	"Wake-on-LAN ALG rejected packet from %v:%u to %v:%u", //IPWOLALG_REJECTED_PACKET
	"Update device to wsetting.wfc", //WCN_LOG_UPDATE
	"This option should be enabled when you have a slow Internet uplink. It helps to reduce the impact that large low priority network packets can have on more urgent ones by breaking the large packets into several smaller packets.", //help80
	"Here you can add entries to the Inbound Filter Rules List below, or edit existing entries.", //help171
	"Mon", //_Mon
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"Step 2: Set your Wireless Security Password", //wwl_title_s4_2
	"If you don't use the All DayDay option, then you enter the time here. The start time is entered in two fields. The first box is for the hour and the second box is for the minute. Email events are normally triggered only by the start time.", //help196
	"PPPoE session offer had errors. Connection attempt failed.", //PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
	"Log In", //li_Log_In
	"Non-UDP/TCP/ICMP LAN Sessions", //af_gss
	"Default Gateway", //_defgw
	"NTP Server Used", //tt_NTPSrvU
	"Adding wireless device:", //add_wireless_device
	"Enter the Public Port as [8888]", //help8
	"Your ISP provides you with all of this information.", //help258
	"PPPoE session 0x%04X terminated by access concentrator", //PPPOE_EVENT_TERMINATED
	"Are you sure you want to reboot the device?", //up_rb_1
	"Use the checkboxes at the left to activate or deactivate completed Virtual Server entries.", //help25_b
	"Save Log", //sl_saveLog
	"Use this option to view the router logs. You can define what types of events you want to view and the event levels to view. This router also has internal syslog server support so you can send the log files to a computer on your network that is running a syslog utility.", //sl_intro
	"Specify a machine with its IP or MAC address, or select \"Other Machines\" for machines that do not have a policy.", //_aa_wiz_s4_help
	"WAN interface cable has been disconnected", //GW_WAN_CARRIER_LOST
	"(bytes)", //bwn_bytes
	"Register the email notification service online to receive an email notification when a newer version of the firmware is available.", //help890_1
	"BigPond Connection", //help779
	"MAC Address", //_macaddr
	"Reset or closed TCP connections. The connection does not close instantly so that lingering packets can pass or the connection can be re-established.", //help823_13
	"Enable Multicast Streams", //anet_multicast_enable
	"Enable IPv4 Multicast Streams", //anet_multicast_enable_v4
	"Enable IPv6 Multicast Streams", //anet_multicast_enable_v6
	"Next dynamic DNS update scheduled for %s", //GW_DYNDNS_UPDATE_NEXT
	"Enter the password associated with the account.", //help866
	"Router Status", //sl_RStat
	"Roger Wilco", //gw_gm_78
	"Create a name for the rule that is meaningful to you.", //help90
	"PPTP tunnel ID 0x%04X has been closed", //PPTP_EVENT_TUNNEL_DOWN
	"Static WAN Mode", //bwn_SWM
	"Web filter rejected packet from %v:%u to %v:%u", //IPWEBFILTER_REJECTED_PACKET
	"Invalid firmware upgrade image uploaded - discarding it", //GW_UPGRADE_FAILED
	"This option is used to open multiple ports or a range of ports in your router and redirect data through those ports to a single PC on your network. This feature allows you to enter ports in various formats including, Port Ranges (100-150), Individual Ports (80, 68, 888), or Mixed (1020-5000, 689).", //ag_intro
	"The Admin option is used to set a password for access to the Web-based management. By default there is no password configured. It is highly recommended that you create a password to keep your new router secure.", //ta_intro_Adm
	"L2TP Server IP Address", //bwn_L2TPSIPA
	"No Internet access policy is in effect. Unrestricted Internet access allowed to everyone", //GW_INET_ACCESS_UNRESTRICTED
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"Disabled", //_disabled
	"Sending log email as log is full", //GW_LOG_EMAIL_ON_LOG_FULL
	"07:00 AM", //tt_time_8
	"Allows Windows Media Player, using MMS protocol, to receive streaming media from the internet.", //help43
	"Connecting", //ddns_connecting
	"Typically PPTP connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are:", //help282
	"Enable Access Control", //aa_EAC
	"On Log Full", //te_OnFull
	"Apr", //tt_Apr
	"Invalid Date or Time", //tt_alert_invlddt
	"(Mbit/s)", //bwl_MS
	"This wizard will guide you through a step-by-step process to configure your new D-Link router and connect to the Internet.", //wwa_intro_wel
	"Remote Admin Port conflict with", //tool_admin_portconflict
	"Application Name", //gw_SelVS
	"Always on", //bwn_RM_0
	"Click the <strong>Edit</strong> icon in the Rules List to change a rule.", //hhai_edit
	"From Email Address", //te_FromEm
	"The gateway is currently measuring your network connection.", //wt_p_1
	"Requesting time from %v", //NET_RTC_REQUEST_TIME
	"Enter a password for the user \"admin\", who will have full access to the Web-based management interface.", //help824
	"N/A", //N_A
	"PPTP Subnet Mask", //help279
	"6th", //tt_week_6
	"Soldier of Fortune II: Double Helix", //gw_gm_48
	"Invisible", //bwl_VS_1
	"Confirm updated firmware revision on status page.", //help882
	"(GMT+03:00) Tehran", //up_tz_41
	"Loaded configuration from non-volatile memory", //RUNTIME_CONFIG_LOADED_CONFIG_FROM_NVRAM
	"Session timeout, please try again.", //li_alert_1
	"The IP address of your router on the local area network. Your local area network settings are based on the address assigned here. For example, 192.168.0.1.", //help307
	"A connection to the Internet is made as needed.", //help273
	"PlayStation2", //gw_gm_81
	"Are you sure you want to reset the device to its factory default settings?", //up_rb_4
	"Newer Firmware Version %d.%d for your %s %s router is now available at", //NEWER_FW_VERSION
	"PPTP Internet Connection Type", //bwn_PPTPICT
	"Firmware upgrade image successfully uploaded - installing", //GW_UPGRADE_SUCCEEDED
	"(Also called the SSID)", //bwl_AS
	"The rule applies to a flow of messages whose WAN-side port number is within the range set here.", //help96
	"Wireless Channel", //_wchannel
	"Manually assign a network key", //wwz_manual_key
	"please press the push button on your wireless device and click the below 'Connect' Button within 120 seconds", //wps_p3_5
	"Enable LPD/LPR Printing", //tps_enlpd
	"L2TP", //_L2TP
	"DHCP IP Address Range", //bd_DIPAR
	"Statistics", //_stats
	"- Between 8 and 63 characters (A longer WPA key is more secure than a short one)", //wwl_s4_intro_za2
	"L2TP local session 0x%04X is down", //IPL2TP_SESSION_DOWN
	"Dynamic IP (DHCP) Internet Connection Type", //bwn_DIAICT
	"Go to the Start menu, select Run, type in <code>winipcfg</code>, and hit Enter. A popup window will be displayed. Select the appropriate adapter from the pull-down menu and you will see the Adapter Address. This is the MAC address of the device.", //help338
	"Enter the LAN IP address of the Syslog Server.", //help859
	"Add", //_add
	"Access Control", //_acccon
	"Unable to resolve, check that the name is correct.", //tsc_pingt_msg4
	"Disconnect", //ddns_disconnect
	"Verify Password", //_verifypw
	"Configure MAC Filtering", //am_intro_2
	"Add Policy", //_aa_pol_add
	"Warcraft II", //gw_gm_59
	"Click <span class=\"button_ref\">Save</span> to add the settings to the Virtual Servers List", //help11
	"System", //_system
	"This option is normally turned off, and should remain off as long as the WAN-side DHCP server correctly provides an IP address to the router. However, if the router cannot obtain an IP address from the DHCP server, the DHCP server may be one that works better with unicast responses. In this case, turn the unicasting option on, and observe whether the router can obtain an IP address. In this mode, the router accepts unicast responses from the DHCP server instead of broadcast responses.", //help261a
	"(GMT-10:00) Hawaii", //up_tz_02
	"\"Ping\" checks whether a computer on the Internet is running and responding.", //hhtsc_pingt_intro
	"Name the Virtual Server (for example: <code>Web Server</code>)", //help5
	"Support Menu", //help767s
	"Splinter Cell: Pandora Tomorrow", //gw_gm_45
	"Username / Password Connection (PPPoE)", //wwa_wanmode_pppoe
	"Destination and Gateway should not reside on the same subnet %v", //GW_ROUTES_GATEWAY_SUBNET_SAME
	"A host needs to support several applications that might use overlapping ingress ports such that two port forwarding rules cannot be used because they would potentially be in conflict.", //haf_dmz_60
	"The Email feature can be used to send the system log files, router alert messages, and firmware update notification to your email address.", //te_intro_Em
	"Select this option if you do not want to activate any security features", //wwl_text_none
	"Enter the username or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields.", //help895
	"Typically PPPoE connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are:", //help269
	"Attempting to re-connect on-demand WAN connection", //GW_WAN_RECONNECT_ON_ACTIVE
	"Machine", //aa_Machine
	"gw_wireless_schedule init", //GW_WLS_SCHEDULE_INIT
	"Wed", //_Wed
	"07:00 PM", //tt_time_20
	"Dest IP<br />Start", //aa_FPR_c3
	"Enter the TCP ports to open (for example <code>6159-6180, 99</code>).", //help68
	"It is most useful to prevent unauthorized wireless devices from connecting to your network.", //help150
	"Account Name", //te_Acct
	"SMTP client succeeded sending email", //IPSMTPCLIENT_MSG_SENT
	"Quake 3", //gw_gm_38
	"This option works with a RADIUS Server to authenticate wireless clients. Wireless clients should have established the necessary credentials before attempting to authenticate to the Server through this Gateway. Furthermore, it may be necessary to configure the RADIUS Server to allow this Gateway to authenticate users.", //help384
	"01:00 AM", //tt_time_2
	"Automatic Uplink Speed", //at_AUS
	"Click the <strong>Delete</strong> icon to permanently delete a schedule.", //hhts_del
	"The preference given to outbound packets of this conversation by the QoS Engine logic. Smaller numbers represent higher priority.", //help818
	"Firmware upgrade cannot be performed from a wireless device. To perform an upgrade, ensure that you are using a PC that is connected to the router by wire.", //help886
	"Choose a unique name for your policy.", //_aa_wiz_s2_msg
	"Select the protocol used by the Internet traffic coming back into the router through the opened port range (for example <code>Both</code>).", //help52
	"seconds ...", //wps_KR46
	"Give your network a name, using up to 32 characters.", //wwz_wwl_intro_s3_1
	"Ghost Recon", //gw_gm_19
	"The DDNS feature allows you to host a server (Web, FTP, Game Server, etc...) using a domain name that you have purchased (www.whateveryournameis.com) with your dynamically assigned IP address. Most broadband Internet Service Providers assign dynamic (changing) IP addresses. Using a DDNS service provider, your friends can enter your host name to connect to your game server no matter what your IP address is.", //td_intro_DDNS
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"DST Start and DST End", //help845
	"This page will refresh shortly.", //wt_p_3
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"Alternatively, you can direct the setup executable to a folder on your computer containing a printer driver you have downloaded from the printer manufacturer's web site.", //wprn_s3d
	"CHAP authentication failed - please check login details.", //IPPPPCHAP_AUTH_FAIL
	"Tiberian Sun", //gw_gm_52
	"Blocked TCP packet from %v:%u to %v:%u as control %s in not valid", //IPNAT_TCP_BAD_FLAGS
	"Name", //_name
	"Enter the local network IP address of the system hosting the server, for example <code>192.168.0.50</code>.", //help66
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no UDP session active between %v:%u and %v:%u", //IPNAT_UDP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"FTP ALG rejected packet from %v:%u to %v:%u", //IPFTPALG_REJECTED_PACKET
	"Access to this Web site is not allowed from this computer.", //fb_p_1
	"Connection Type", //_contype
	"The port that you will use to address the management interface from the Internet. For example, if you specify port 1080 here, then, to access the router from the Internet, you would use a URL of the form: <code>http://my.domain.com:1080/</code>.", //help829
	"Application Rules", //_specappsr
	"The Invisible option allows you to hide your wireless network. When this option is set to Visible, your wireless network name is broadcast to anyone within the range of your signal. If you're not using encryption then they could connect to your network. When Invisible mode is enabled, you must enter the Wireless Network Name (SSID) on the client manually to connect to the network.", //help353
	"Halo: Combat Evolved", //gw_gm_23
	"Always Broadcast", //help325
	"Reconnect Mode", //bwn_RM
	"Log Options", //sl_LogOps
	"All of your Internet and network connection details are displayed on the Device Info page. The firmware version is also displayed here.", //help772
	"Method", //_aa_method
	"Log Details", //sl_LogDet
	"This is a relative measure of signal quality. The value is expressed as a percentage of theoretical best quality. Signal quality can be reduced by distance, by interference from other radio-frequency sources (such as cordless telephones or neighboring wireless networks), and by obstacles between the router and the wireless device.", //help788
	"Continue", //_continue
	"The wireless section is used to configure the wireless settings for your D-Link router. Note that changes made in this section may also need to be duplicated on wireless clients that you want to connect to your wireless network.", //help349
	"The Statistics page displays all of the LAN, WAN, and Wireless packet transmit and receive statistics.", //help804
	"Device Info", //_devinfo
	"Yes", //_yes
	"SSID", //help699
	"(GMT+10:00) Yakutsk", //up_tz_62
	"In this section you can add entries to the Schedule Rules List below or edit existing entries.", //help192
	"Enable DMZ", //af_ED
	"Need for Speed", //gw_gm_31
	"A connection to the Internet is always maintained.", //help271
	"Allows multiple machines on the LAN to connect to their corporate networks using PPTP protocol.", //help33
	"Blocked incoming TCP packet from %v:%u to %v:%u with unexpected acknowledgement %lu (expected %lu to %lu)", //IPNAT_TCP_BLOCKED_INGRESS_BAD_ACK
	"Start pinging the specified host.", //htsc_pingt_p
	"Check Now", //tf_CKN
	"Check Printer Status", //wprn_cps
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"By default, the router automatically determines whether the underlying connection is an xDSL/Frame-relay network or some other connection type (such as cable modem or Ethernet), and it displays the result as <span class=\"option\">Detected xDSL or Frame Relay Network</span>. If you have an unusual network connection in which you are actually connected via xDSL but for which you configure either \"Static\" or \"DHCP\" in the WAN settings, setting this option to <span class=\"option\"> xDSL or Other Frame Relay Network</span> ensures that the router will recognize that it needs to shape traffic slightly differently in order to give the best performance. Choosing <span class=\"option\">xDSL or Other Frame Relay Network</span> causes the measured uplink speed to be reported slightly lower than before on such connections, but gives much better results.", //help84
	"Latest firmware version %d.%02d is available", //GW_FW_NOTIFY_FIRMWARE_AVAIL
	"RX Packets Dropped", //ss_RXPD
	"Web site %S blocked for %s", //WEB_FILTER_LOG_URL_BLOCKED_MAC
	"Port trigger ALG failed to allocate session for TCP packet from %v:%u to %v:%u", //IPPORTTRIGGERALG_TCP_PACKET_ALLOC_FAILURE
	"When Wireless is enabled, the default selection for scheduling is \"Always\". Selections for other schedules will be available in the drop down menu after users define schedules in the \"Schedule\" page. This function gets disabled when wireless is disabled.", //dlink_1_bw1_schld_help
	"Note: You may also need to provide a Host Name. If you do not have or know this information, please contact your ISP.", //wwa_note_hostname
	"Action", //ai_Action
	"Reset configuration to factory defaults", //RUNTIME_CONFIG_RESET_CONFIG_TO_FACTORY_DEFAULTS
	"No printer detected", //sps_nopr
	"Hours", //gw_hours
	"Fri", //_Fri
	"LPD/LPR Printing", //tps_lpd
	"Firmware Upgrade", //tf_FWUg
	"10Mbps", //anet_wp_0
	"Battlefield 1942", //gw_gm_4
	"Both of these options select some variant of Wi-Fi Protected Access (WPA) -- security standards published by the Wi-Fi Alliance. The <span class=\"option\">WPA Mode</span> further refines the variant that the router should employ.", //help373
	"Daylight Saving Offset", //tt_dsoffs
	"Automatically assign a network key (Recommended)", //wwz_auto_assign_key
	"Doom 3", //gw_gm_15
	"For information on which security features your wireless adapters support, please refer to the adapters' documentation.", //wwl_s3_note_1
	"Click <strong>Save</strong> to add a completed schedule to the list below.", //hhts_save
	"Auto-detect", //at_Auto
	"Place a checkmark in the boxes for the desired days or select the All Week radio button to select all seven days of the week.", //help194
	"PPP network down", //IPPPPIPCP_PPP_LINK_DOWN
	"Address Type", //aa_AT
	"Ubi.com", //gw_gm_71
	"Step 3 - Select the machine to which this policy applies", //aa_wiz_s1_msg3
	"BigPond failed, see log for details", //BIGPOND_FAILED
	"The time between periodic updates to the Dynamic DNS, if your dynamic IP address has not changed. The timeout period is entered in hours.", //help898
	"PPTP Server IP Address", //bwn_PPTPSIPA
	"Routing", //_routing
	"Create a list of MAC addresses that you would either like to allow or deny access to your network.", //hham_intro
	"WPS Internal Registrar did not receive request from any wireless station in 2 minutes and stopped.", //WIFISC_IR_REGISTRATION_FAIL_3
	"The Inbound Filter option is an advanced method of controlling data received from the Internet. With this feature you can configure inbound data filtering rules that control data based on an IP address range.", //ai_intro_1
	"Step 2: Select your Time Zone", //wwa_title_s2
	"(GMT+11:00) Vladivostok", //up_tz_69
	"MSCHAP sent authentication response to peer.", //IPMSCHAP_AUTH_RESULT
	"The current system settings can be saved as a file onto the local hard drive. The saved file or any other saved setting file created by device can be uploaded into the unit.", //tss_intro2
	"If you select this option, the router automatically finds the channel with least interference and uses that channel for wireless networking. If you disable this option, the router uses the channel that you specify with the following <span class=\"option\">Wireless Channel</span> option.", //help354
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"You must enter the name of a configuration file first.", //ta_alert_5
	"Always broadcast", //bd_DAB
	"WPA-Enterprise", //_WPAenterprise
	"Internet access control dropped packet from %v:%u[%s] to %v:%u (protocol %u)", //GW_INET_ACCESS_DROP_ACCESS_CONTROL_MAC
	"Printer", //sps_pr
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"Pre-Shared Key", //_psk
	"Dynamic DNS", //_dyndns
	"Deny", //_deny
	"Blocked incoming TCP packet from %v:%u to %v:%u as %s is not allowed in state %s", //IPNAT_TCP_BLOCKED_INGRESS_UNEXP_FLAGS
	"Maximum Idle Time:", //help276
	"to", //_to
	"IP", //aa_AT_0
	"Create a list of Web Sites to which you would like to deny or allow through the network.", //dlink_hhwf_intro
	"Dec", //tt_Dec
	"Click the <span class=\"button_ref\">B\">Browse</span> button to locate the D-Link upgrade file on your computer.", //help879
	"Policy %s started; Internet access for all non-specified systems changed to: %s", //GW_INET_ACCESS_POLICY_START_OTHERS
	"(GMT+12:00) Fiji, Kamchatka, Marshall Is.", //up_tz_72
	"No response from host, retrying...", //tsc_pingt_msg11
	"Are you sure you want to delete this entry?", //up_ae_de_1
	"This area of the screen continually updates to show all DHCP enabled computers and devices connected to the LAN side of your router. The detection \"range\" is limited to the address range as configured in DHCP Server. Computers that have an address outside of this range will not show. If the DHCP Client (i.e. a computer configured to \"Automatically obtain an address\") supplies a Host Name then that will also be shown. Any computer or device that has a static IP address that lies within the detection \"range\" may show, however its host name will not.", //help781
	"Enter the MAC address of the desired.", //help161_2
	"06:00 PM", //tt_time_19
	"Configure MAC Filtering below:", //am_intro
	"The number of transmission failures that cause loss of a packet.", //help811
	"Medium", //aw_TP_1
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"MSCHAP authentication details were sent to authenticator.", //IPMSCHAP_AUTH_SENT
	"Use this option to view the wireless clients that are connected to your wireless router.", //sw_intro
	"The LPD/LPR printing protocol uses a fixed IP address and queue name to communicate with your printer.", //tps_lpd1
	"and", //help257
	"The router will now be reprogrammed using the uploaded firmware file. Please wait <span id=\"show_sec\"></span>&nbsp;seconds for this process to complete, after which you may access these web pages again. Pressing reload or back on your browser may cause this operation to fail.", //_upgintro
	"Closed -- The connection is no longer active but the session is being tracked in case there are any retransmitted packets still pending.", //help819_8
	"(seconds)", //bws_secs
	"Blocked outgoing ICMP packet (ICMP type %u) from %v to %v", //IPNAT_ICMP_BLOCKED_EGRESS_PACKET
	"Port Forwarding", //PORT_FORWARDING
	"Dynamic IP (DHCP)", //bwn_Mode_DHCP
	"Hour", //tt_Hour
	"Enter the IP addresses of the DNS Servers. Leave the field for the secondary server empty if not used.", //help290a
	"BigPond logging out", //BIGPOND_LOGGING_OUT
	"The DMZ (Demilitarized Zone) option lets you set a single computer on your network outside of the router. If you have a computer that cannot run Internet applications successfully from behind the router, then you can place the computer into the DMZ for unrestricted Internet access.", //af_intro_1
	"If you are having trouble receiving multicast streams from the Internet, make sure the Multicast Streams option is enabled.", //hhan_mc
	"Primary DNS Server", //_dns1
	"Primary IPv6 DNS Server", //_dns1_v6
	"Tools", //_tools
	"Disconnected", //_sdi_s2
	"USB Port", //sps_usbport
	"System error occured when allocating schedule %s", //GW_SCHED_ALLOC_FAILED
	"Prevent all WAN users from accessing the related capability. (LAN users are not affected by Inbound Filter Rules.)", //help179
	"Enable Daylight Saving", //tt_dsen2
	"Allow", //_allow
	"Select the level of events that you want to view.", //help798
	"Oct", //tt_Oct
	"WAN Port Speed", //anet_wan_phyrate
	"Note", //_note
	"Dest<br />Port<br />Start", //aa_FPR_c6
	"UDP Ports To Open", //help69
	"DHCP Lease Time", //bd_DLT
	"Welcome to the D-Link Setup Wizard", //wwa_title_wel
	"Inbound Filter Rules List", //ai_title_IFRL
	"LAN interface is up", //GW_LAN_INTERFACE_UP
	"Logs", //_logs
	"Turn MAC Filtering OFF", //am_FM_2
	"Sending log email after administrator request", //GW_LOG_EMAIL_ON_USER_REQUEST
	"The port that will be accessed from the Internet.", //help21
	"802.11 Mode", //bwl_Mode
	"Enter the URL (address) of the Web Site that you want to allow or deny; for example: <code>google.com</code>. Do not enter the <code>http://</code> preceding the URL. Enter the most inclusive domain; for example, select allow and enter <code>dlink.com</code> and access will be permitted to both <code>www.dlink.com</code> and <code>support.dlink.com</code>.", //dlink_help145
	"Address Mode", //bwn_AM
	"BigPond Server", //bwn_BPS
	"Enter the information provided by your Internet Service Provider (ISP).", //_ispinfo
	"Rate", //_rate
	"Your D-Link router, by default, has a static IP address of 192.168.0.1. This means that addresses 192.168.0.2 to 192.168.0.254 can be made available for allocation by the DHCP Server.", //help321
	"(GMT-07:00) Mountain Time (US/Canada)", //up_tz_06
	"Success", //_success
	"Sentinel Parental Controls Service", //_bsecure_parental_serv
	"Set Username and Password Connection (L2TP)", //wwa_set_l2tp_title
	"Step 1: Welcome TO THE D-LINK WIRELESS SECURITY SETUP WIZARD", //wwz_wwl_title_s3
	"Mac OS X", //help342
	"Select this option if your ISP requires you to use a PPPoE (Point to Point Protocol over Ethernet) connection. DSL providers typically use this option. This method of connection requires you to enter a <span class=\"option\">Username</span> and <span class=\"option\">Password</span> (provided by your Internet Service Provider) to gain access to the Internet.", //help265
	"SMTP (Email) server %s is at IP address %v", //GW_SMTP_EMAIL_RESOLVED_DNS
	"Pings received:", //tsc_pingt_msg101
	"RADIUS server Port", //bws_RSP
	"Trying to establish a PPPoE connection", //PPPOE_EVENT_CONNECT
	"Automatic Time Configuration", //tt_auto
	"The PPTP subsystem is low on resources. Connectivity may be affected.", //PPTP_EVENT_LOW_RESOURCES_TO_QUEUE
	"L2TP local tunnel 0x%04X received unexpected control message (ignored)", //IPL2TP_TUNNEL_UNEXPECTED_MESSAGE
	"Neverwinter Nights", //gw_gm_34
	"5th", //tt_week_5
	"Below is a detailed summary of your Wi-Fi security settings. Please print this page out, or write the information on a piece of paper, so you can configure the correct settings on your Wi-Fi devices.", //wwl_intro_end
	"Policy Table", //aa_Policy_Table
	"Time Configuration", //tt_TimeConf
	"None", //_none
	"Step 2: Select Schedule", //_aa_wiz_s3_title
	"A pass-phrase that must match with the authentication server.", //help392
	"Sending log email on schedule", //GW_LOG_EMAIL_ON_SCHEDULE
	"Select the appropriate time zone for your location. This information is required to configure the time-based options for the router.", //wwa_intro_s2
	"PPTP Gateway IP Address", //_PPTPgw
	"Web site %S accessed from %v", //WEB_FILTER_LOG_URL_ACCESSED
	"MMS ALG rejected packet from %v:%u to %v:%u", //IPMMSALG_REJECTED_PACKET
	"Wireless Settings", //_wirelesst
	"There are two ways to set up your Internet connection: you can use the Web-based Internet Connection Setup Wizard, or you can manually configure the connection.", //int_intro
	"Access denied to LAN system with MAC address %m", //GW_LAN_ACCESS_DENIED
	"Jedi Knight II: Jedi Outcast", //gw_gm_26
	"Blocked incoming GRE packet from %v to %v", //PPTP_ALG_GRE_BLOCKED_INGRESS
	"(GMT+01:00) West Central Africa", //up_tz_30
	"Starcraft", //gw_gm_49
	"Schedule", //_sched
	"Failed to mount FAT device", //IPFAT_MOUNT_FAILED
	"KALI", //gw_gm_75
	"Here are displayed the version numbers of the firmware currently installed in your router and the most recent upgrade that is available.", //help883
	"Please wait, uploading configuration file", //ta_alert_6
	"Policy %s started; Internet access for IP address %v changed to: %s", //GW_INET_ACCESS_POLICY_START_IP
	"Displays the time currently maintained by the router. If this is not correct, use the following options to configure the time correctly.", //help841a
	"10:00 PM", //tt_time_23
	"Port Forwarding Rules", //ag_title_4
	"WinMX", //gw_gm_68
	"Blocked outgoing TCP packet from %v:%u to %v:%u as %s is not allowed in state %s", //IPNAT_TCP_BLOCKED_EGRESS_UNEXP_FLAGS
	"Host Name:", //help260
	"FIN Wait -- The client system has requested that the connection be stopped.", //help819_4
	"If all of the wireless devices you want to connect with this router can connect in the same transmission mode, you can improve performance slightly by choosing the appropriate \"Only\" mode. If you have some devices that use a different transmission mode, choose the appropriate \"Mixed\" mode.", //help357
	"TCP", //_TCP
	"MSCHAP authentication challenge received from peer.", //IPMSCHAP_CHALLENGE_RECVD
	"Universal Plug and Play (UPnP) supports peer-to-peer Plug and Play functionality for network devices.", //anet_msg_upnp
	"Clicking the <span class=\"button_ref\">DHCP Release</span> button unassigns the router's IP address. The router will not respond to IP messages from the WAN side until you click the <span class=\"button_ref\">DHCP Renew</span> button or power-up the router again. Clicking the <span class=\"button_ref\">DHCP Renew</span> button causes the router to request a new IP address from the ISP's server.", //help776
	"Please select one of Automatic or Manual Time setting. Not both", //tt_alert_1only
	"Here you can enable or disable ALGs. Some protocols and applications require special handling of the IP payload to make them work with network address translation (NAT). Each ALG provides special handling for a specific protocol or application. A number of ALGs for common applications are enabled by default.", //help32
	"Asheron's Call", //gw_gm_3
	"The number of seconds of idle time until the router considers the session terminated.", //help823
	"L2TP IP Address", //_L2TPip
	"Reboot the Device", //_reboot
	"There are two ways to add wireless device to your wireless network:", //wps_p3_1
	"Step 3: Insert the printer driver CD if requested", //wprn_intro5
	"Sentinel Security Services", //_bsecure_security_serv
	"received in", //tsc_pingt_msg8
	"Unreal Tournament", //gw_gm_56
	"Typically L2TP connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are:", //help286
	"The Firmware Upgrade section can be used to update to the latest firmware code to improve functionality and performance.", //tf_intro_FWU
	"(GMT+08:00) Kuala Lumpur, Singapore", //up_tz_57
	"Firmware upgrade server %s is at IP address %v", //GW_FW_NOTIFY_RESOLVED_DNS
	"Port And Address Restricted", //af_EFT_2
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"Schedules are used with a number of other features to define when those features are in effect.", //hhts_intro
	"Authentication", //_auth
	"L2TP local tunnel 0x%04X is disconnecting", //IPL2TP_TUNNEL_DISCONNECTING
	"Time synchronization failed after retries ... giving up", //NET_RTC_SYNCHRONIZATION_FAILED_AFTER_RETRIES
	"Firmware Version", //sd_FWV
	"Schedule Rules List", //tsc_SchRuLs
	"Enabling WMM can help control latency and jitter when transmitting multimedia content over a wireless connection.", //help188_wmm
	"Optional Backup RADIUS Server", //help396
	"Save Configuration", //ta_SavConf
	"Secondary DNS Address", //wwa_sdns
	"This option restores all configuration settings back to the settings that were in effect at the time the router was shipped from the factory. Any settings that have not been saved will be lost. If you want to save your router configuration settings, use the Save Settings option above.", //help876
	"This option uses Wi-Fi Protected Access with a Pre-Shared Key (PSK).", //help380
	"Network Filter", //_netfilt
	"Days", //gw_days
	"Login", //li_Login
	"WAN is already connected", //WAN_ALREADY_CONNECTED
	"WPA2 Only", //bws_WPAM_3
	"Gateway address %v must not be the address of the intended interface", //GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS
	"Password or Key", //td_PWK
	"Virtual Server Item", //tool_admin_vsname
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"Static IP", //static_PPPoE
	"Start Time", //tsc_StrTime
	"Shortest ping time (in milliseconds):", //tsc_pingt_msg104
	"Printer Device ID Error", //wprn_iderr
	"Select this option will display the current wireless settings for you to configure the wireless device manually", //wps_KR42
	"Timeout", //td_Timeout
	"Apply Web Filter", //_aa_apply_web_filter
	"Reset to Unconfigured", //resetUnconfiged
	"Gaming", //GAMING
	"08:00 AM", //tt_time_9
	"Blocked incoming packet from %v to %v (IP protocol %u)", //IPNAT_BLOCKED_INGRESS
	"WAN interface is up. Connection to Internet established with IP Address %v and default gateway %v", //GW_WAN_INTERFACE_UP
	"Router IP Address", //_ripaddr
	"Time Out", //sa_TimeOut
	"Blocked outgoing TCP packet from %v:%u to %v:%u with unexpected sequence %lu (expected %lu to %lu)", //IPNAT_TCP_BLOCKED_EGRESS_BAD_SEQ
	"LAN interface is down", //GW_LAN_INTERFACE_DOWN
	"Depending on whether the WAN connection is currently established, you can click either the <span class=\"button_ref\">Connect</span> to attempt to establish the WAN connection or the <span class=\"button_ref\">Disconnect</span> to break the WAN connection.", //help778
	"Queue Name", //sps_qname
	"seconds", //_seconds
	"Log cleared by IP address %v", //GW_LOGS_CLEARED
	"Warning", //sl_Warning
	"Machine Address", //aa_MAC
	"Select this option if your wireless device supports WPS (Wi-Fi Protected Setup)", //wps_KR51
	"Manual:", //help274
	"Using a short (400ns) guard interval can increase throughput. However, it can also increase error rate in some installations, due to increased sensitivity to radio-frequency reflections.", //aw_sgi_h1
	"Blocked source-routed packet from %v to %v", //IPSTACK_REJECTED_SOURCE_ROUTED_PACKET
	"Primary DNS Address", //wwa_pdns
	"Use this option to restore previously saved router configuration settings.", //help834
	"Sun", //_Sun
	"Number of Dynamic DHCP Clients", //bd_title_clients
	"To prevent outsiders from accessing your network, the router will automatically assign a security (also called WEP or WPA key) to your network.", //wwz_auto_assign_key2
	"Number Of Wireless Clients", //sw_title_list
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"Once your D-Link router is properly configured and this option is enabled, the DHCP Server will manage the IP addresses and other network configuration information for computers and other devices connected to your Local Area Network. There is no need for you to do this yourself.", //help316
	"Trying to connect to L2TP server", //IPL2TP_TUNNEL_CONNECTING
	"Enable SPI", //af_ES
	"Time synchronized", //NET_RTC_SYNCHRONIZED
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"On demand", //bwn_RM_1
	"You are not logged in, please refresh the browser", //NOT_LOGGED_IN_PLEASE_REFRESH
	"Blocked incoming ESP packet from %v to %v", //IPSEC_ALG_ESP_BLOCKED_INGRESS
	"continue", //ub_continue
	"Username or Key", //td_UNK
	"Failed to mount PV%d device", //IPPMVM_MOUNT_FAILED
	"Rise of Nations", //gw_gm_42
	"The LAN address that you want to reserve.", //_1066
	"All Week", //tsc_AllWk
	"Virtual Server", //_virtserv
	"The Virtual Server option gives Internet users access to services on your LAN. This feature is useful for hosting online services such as FTP, Web, or game servers. For each Virtual Server, you define a public port on your router for redirection to an internal LAN IP Address and LAN port.", //help2
	"Select this option if you want logs to be sent by email when the log is full.", //help869
	"LCP sets local options: ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u", //IPPPPLCP_SET_LOCAL_OPTIONS
	"Reboot The Device", //ts_rd
	"IPSec ALG rejected packet from %v:%u to %v:%u", //IPSEC_ALG_REJECTED_PACKET
	"Please wait, resolving", //tsc_pingt_msg3
	"Wireless system with MAC address %m disconnected for reason: %s", //GW_WIRELESS_DEVICE_DISCONNECTED
	"To input the MAC address of your system, enter it in manually or connect to the D-Link router's Web-Management interface from the system and click the <span class=\"button_ref\">Copy Your PC's MAC Address</span> button.", //help333
	"Wireless Radio", //sd_WRadio
	"Allowed, Web Sites - %s%s, Ports - %s", //ALLOWED_WEB_SITES
	"BitTorrent", //gw_sa_1
	"UDP", //_UDP
	"Putting a computer in the DMZ may expose that computer to a variety of security risks. Use of this option is only recommended as a last resort.", //help166
	"The Access Control section allows you to control access in and out of devices on your network. Use this feature as Parental Controls to only grant access to approved sites, limit web access based on time or dates, and/or block access from applications such as peer-to-peer utilities or games.", //help117
	"L2TP Internet Connection Type", //bwn_L2TPICT
	"The router automatically logs (records) events of possible interest in its internal memory. If there is not enough internal memory for all events, logs of older events are deleted, but logs of the latest events are retained. The Logs option allows you to view the router logs. You can define what types of events you want to view and the level of events to view. This router also has internal Syslog Server support so you can send the log files to a computer on your network that is running a Syslog utility.", //help795
	"No", //_no
	"(GMT+09:30) Adelaide", //up_tz_63
	"You must enter the name of a firmware file first.", //tf_FWF1
	"(GMT+10:00) Brisbane", //up_tz_65
	"Priority", //_priority
	"WAN is already disconnected", //WAN_ALREADY_DISCONNECTED
	"There is unsaved data on this page. Do you want to abandon it?", //up_jt_1
	"Internet access for all non-specified systems set to: %s", //GW_INET_ACCESS_INITIAL_OTHERS
	"The starting and ending IP addresses are WAN-side address.", //hhai_ip
	"This option is used to open single or multiple ports on your router when the router senses data sent to the Internet on a \"trigger\" port or port range. Special Applications rules apply to all computers on your internal network.", //as_intro_SA
	"Pinging public WAN IP addresses is a common method used by hackers to test whether your WAN IP address is valid.", //anet_wan_ping_1
	"(GMT+04:30) Kabul", //up_tz_44
	"You might have trouble accessing a virtual server using its public identity (WAN-side IP-address of the gateway or its dynamic DNS name) from a machine on the LAN. Your requests may not be looped back or you may be redirected to the \"Forbidden\" page.", //help27
	"IPSec (VPN)", //as_IPSec
	"Admin", //_admin
	"eDonkey", //gw_gm_65
	"To upgrade the firmware, locate the upgrade file on the local hard drive with the Browse button.Once you have found the file to be used, click the Upload button below to start the firmware upgrade.", //tf_intro_FWChB
	"Blocked", //BLOCKED
	"BigPond Cable (Australia)", //wwa_msg_bigpond
	"Enable Logging To Syslog Server", //tsl_EnLog
	"Close Wait -- the server system has requested that the connection be stopped.", //help819_5
	"Low", //aw_TP_2
	"Authentication Timeout", //bwsAT_
	"Setup Complete!", //_setupdone
	"Log in to the router", //li_intro
	"SMTP client failed to send email", //IPSMTPCLIENT_MSG_FAILED
	"Before launching these wizards, please make sure you have followed all steps outlined in the Quick Installation Guide included in the package.", //bwz_note_ConWz
	"Gnutella", //gw_gm_64
	"Reconnect Mode:", //help268
	"None Blocked", //NONE_BLOCKED
	"May", //tt_May
	"Big Pond Internet Connection Type", //bwn_BPICT
	"02:00 PM", //tt_time_15
	"Tue", //_Tue
	"Clear Statistics", //ss_clear_stats
	"The end time is entered in the same format as the start time. The hour in the first box and the minutes in the second box. The end time is used for most other rules, but is not normally used for email events.", //help197
	"Filter rules can be used with Virtual Server, Port Forwarding, or Remote Administration features.", //ai_intro_3
	"WAN connection inactive too long so attempting to disconnect", //GW_WAN_DISCONNECT_ON_INACTIVE
	"The DHCP address %v is released by the user", //DHCP_CLIENT_RELEASED_LEASE
	"Set Static IP Address Connection", //wwa_set_sipa_title
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"ALGs provide special handling of the IP payload for some protocols and applications to make them work with network address translation (NAT). If you are having trouble using any of these applications, try both enabling and disabling the corresponding ALG.", //hhaf_alg
	"Check this option if your location observes daylight saving time.", //help843
	"Verify that a printer is attached to the router's USB port.", //wprn_tt11
	"Traffic Statistics", //_tstats
	"LCP sets remote options: ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u", //IPPPPLCP_SET_REMOTE_OPTIONS
	"Check Online Now for Latest Firmware Version", //tf_COLF
	"(GMT+01:00) Brussels, Copenhagen, Madrid, Paris", //up_tz_28
	"Mar", //tt_Mar
	"Log Web Access Only", //_aa_allow_all
	"Username / Password Connection (L2TP)", //wwa_wanmode_l2tp
	"DMZ Host", //_dmzh
	"Time server %s is at IP address %v", //GW_TIME_RESOLVED_DNS
	"EAP (802.1x)", //bws_EAPx
	"Policy Name", //aa_PolName
	"To set up this connection you will need to have a complete list of IP information provided by your Internet Service Provider. If you have a Static IP connection and do not have this information, please contact your ISP.", //wwa_set_sipa_msg
	"Step 1: Choose Policy Name", //_aa_wiz_s2_title
	"PPTP connected to server \"%s\" with ID 0x%04X", //PPTP_EVENT_TUNNEL_CONNECTED
	"No WCN compatible USB mass storage interface was found", //USB_LOG_STORAGE_NOT_FOUND
	"Device initialized", //GW_INIT_DONE
	"Dynamic IP", //carriertype_ct_0
	"These are the settings of the LAN (Local Area Network) interface for the router. The router's local network (LAN) settings are configured based on the IP Address and Subnet Mask assigned in this section. The IP address is also used to access this Web-based management interface.", //help305
	"Raw TCP Port Printing", //tps_raw
	"Public Port", //av_PubP
	"WPA Mode:", //help374
	"PPTP received a tunnel clear down request from the application, the tunnel will now be closed.", //PPTP_EVENT_TUNNEL_CLEAR_DOWN_REQUEST
	"Click the <strong>Delete</strong> icon to permanently remove a rule.", //hhac_delete
	"L2TP local session 0x%04X terminating", //IPL2TP_SESSION_CLEAR_DOWN_REQUEST
	"Policy", //aa_ACR_c2
	"The requests from the LAN machine will not be looped back if Internet access is blocked at the time of access. To work around this problem, access the LAN machine using its LAN-side identity.", //help29
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"Application", //_app
	"Invalid LAN subnet mask.", //bln_alert_1
	"Estimating speed of WAN interface", //GW_WAN_RATE_ESTIMATOR_STARTED_ON_WAN
	"Firewall &amp; Security", //sl_FWandSec
	"For added security, it is recommended that you disable the WAN Ping Respond option. Ping is often used by malicious Internet users to locate active networks or PCs.", //hhan_ping
	"NAT", //sa_NAT
	"Enabling Remote Management, allows you or others to change the router configuration from a computer on the Internet.", //hhta_en
	"Unable to find DNS record for SMTP (Email) server %s", //GW_SMTP_EMAIL_FAILED_DNS
	"The number of packets that were dropped due to Ethernet collisions (two or more devices attempting to use an Ethernet circuit at the same time).", //help810
	"Wake-On-LAN", //_WOL
	"On demand:", //help272
	"None -- This entry is used as a placeholder for a future connection that may occur.", //help819_1
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no TCP connection active between %v:%u and %v:%u", //IPNAT_TCP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"(GMT-04:00) Atlantic Time (Canada)", //up_tz_14
	"Star Trek: Elite Force II", //gw_gm_51
	"Server Address", //td_SvAd
	"You can enter ports in various formats:", //hhag_40
	"Inbound Filters can be used for limiting access to a server on your network to a system or group of systems. Filter rules can be used with Virtual Server, Gaming, or Remote Administration features. Each filter can be used for several functions; for example a \"Game Clan\" filter might allow all of the members of a particular gaming group to play several different games for which gaming entries have been created. At the same time an \"Admin\" filter might only allows systems from your office network to access the WAN admin pages and an FTP server you use at home. If you add an IP address to a filter, the change is effected in all of the places where the filter is used.", //help169
	"The amount of time that a computer may have an IP address before it is required to renew the lease. The lease functions just as a lease on an apartment would. The initial lease designates the amount of time before the lease expires. If the tenant wishes to retain the address when the lease is expired then a new lease is established. If the lease expires and the address is no longer needed than another tenant may use the address.", //help324
	"\"Ping\" is an Internet utility function that sends a series of short messages to a target computer and reports the results. You can use it to test whether a computer is running, and to get an idea of the quality of the connection to that computer, based on the speed of the responses.", //htsc_intro
	"WLAN Partition", //KR4_ww
	"The computers (and other devices) connected to your LAN also need to have their TCP/IP configuration set to \"DHCP\" or \"Obtain an IP address automatically\".", //help317
	"Multicast Streams", //anet_multicast
	"IPv4 Multicast Streams", //anet_multicast_v4
	"IPv6 Multicast Streams", //anet_multicast_v6
	"Add New Policy", //_aa_wiz_s1_title
	"L2TP local tunnel 0x%04X RTE module has shut down.", //IPL2TP_SHUTDOWN_COMPLETE
	"Last ACK -- Waiting for a short time while a connection that was in Close Wait is fully closed.", //help819_7
	"Select the Protocol (for example <code>TCP</code>).", //help9
	"The number of packets that were dropped while being received, due to errors, collisions, or router resource limitations.", //help809
	"LAN Ethernet Carrier Detected", //GW_LAN_CARRIER_DETECTED
	"Are you sure you want to clear all log entries?", //sl_alert_1
	"Trigger Port", //as_TPRange_b
	"1st", //tt_week_1
	"If so, press Ok.", //up_jt_3
	"Clear", //_clear
	"Terminating PPPoE session 0x%04X", //PPPOE_EVENT_DISCONNECT
	"WPS Internal Registrar failed to add wireless station %m, reason: %s, err_code %u.", //WIFISC_IR_REGISTRATION_FAIL_2
	"Static IP", //_sdi_staticip
	"To set up this connection, please make sure that you are connected to the D-Link Router with the PC that was originally connected to your broadband connection. If you are, then click the Clone MAC button to copy your computer's MAC Address to the D-Link Router.", //wwa_msg_set_dhcp
	"Give each schedule a name that is meaningful to you. For example, a schedule for Monday through Friday from 3:00pm to 9:00pm, might be called \"After School\".", //hhts_name
	"WAN", //WAN
	"Enter a password for the user \"user\", who will have read-only access to the Web-based management interface.", //help825
	"Computers that have obtained an IP address from the router's DHCP server will be in the DHCP Client List. Select a device from the drop down menu, then click the arrow to add that device's MAC address to the list.", //hham_add
	"WAN Statistics", //ss_WANStats
	"Attempting to start WAN connection on-demand", //GW_WAN_CONNECT_ON_ACTIVE
	"You must abandon all your changes in order to define a new schedule.", //aa_sched_conf_1
	"Policy %s stopped; Internet access for all non-specified systems changed to: %s", //GW_INET_ACCESS_POLICY_END_OTHERS
	"DHCP Reservations List", //bd_title_list
	"Web Access Logging", //_aa_logging
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no session active for protocol %u between %v and %v", //IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"User Name", //_username
	"Enable", //_enable
	"Unable to find DNS record for time server %s", //GW_TIME_FAILED_DNS
	"Refer to the documentation that came with your router for printer setup instructions specific to your operating system.", //wprn_tt1
	"09:00 PM", //tt_time_22
	"IP address", //help256
	"Internet access policy for IP address %v cannot be set", //GW_INET_ACCESS_INITIAL_IP_FAIL
	"Details", //_aa_details
	"Allows applications that use Real Time Streaming Protocol to receive streaming media from the internet. QuickTime and Real Player are some of the common applications using this protocol.", //help36
	"The port number of the LAN-side application as viewed by the WAN-side application.", //help817
	"PPPoE (Username / Password)", //bwn_Mode_PPPoE
	"Allow All", //_allowall
	"Clear the list below...", //awf_clearlist
	"The router must be rebooted before settings saved on a previous page will take effect. You can reboot the router now using the 'Reboot' button below, or press the 'Continue' button and make other changes.", //sc_intro_rb3
	"TCP Ports To Open", //help67
	"Quake 2", //gw_gm_37
	"Otherwise press 'Cancel'.", //up_ae_wic_3
	"Step 1: Set your Password", //wwa_title_s1
	"Driver Name", //tps_drname
	"Copy Your Computer's Time Settings", //tt_CopyTime
	"L2TP session server started sending sequencing numbers for local session 0x%04X", //IPL2TP_SEQUENCING_ACTIVATED
	"Reserve", //bd_Reserve
	"MSN Messenger ALG rejected packet from %v:%u to %v:%u", //IPMSNMESSENGERALG_REJECTED_PACKET
	"The wireless section allows you to view the wireless clients that are connected to your wireless router.", //help782
	"Dungeon Siege", //gw_gm_16
	"Port forwarding ALG failed to allocate session for UDP packet from %v:%u to %v:%u", //IPPORTFORWARDALG_UDP_PACKET_ALLOC_FAILURE
	"Model", //wprn_mod
	"Note:", //help119
	"Silent Hunter II", //gw_gm_46
	"Turn MAC Filtering ON and ALLOW computers listed to access the network", //am_FM_3
	"Use this information to configure your computer for LPD/LPR printing.", //sps_lpd1
	"System Settings", //tss_SysSt
	"Restore Configuration from File", //ta_ResConf
	"Updated flash to wireless configuration", //WCN_LOG_SAVE
	"Firewall Traffic Type", //as_FPrt
	"UDP connections.", //help823_11
	"Every Day", //tsc_EvDay
	"Click the <span class=\"button_ref\">Clear</span> button to remove the MAC address from the MAC Filtering list.", //ham_del
	"PPPoE", //_PPPoE
	"It appears that you have already successfully connected your new router to the Internet.", //wwa_intro_online1
	"DST End", //tt_dstend
	"Schedule Rule", //tsc_SchRu
	"Failed configuration authentication attempt by IP address %v", //GW_AUTH_FAILED
	"Schedules", //_scheds
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"Secondary DNS Server", //_dns2
	"Secondary IPv6 DNS Server", //_dns2_v6
	"You must enter a host name or IP address.", //tsc_pingt_msg2
	"These settings are automatically configured and should be modified only by advanced users.", //tps_apc1
	"Internet access control dropped packet from %v:%u to %v:%u (protocol %u)", //GW_INET_ACCESS_DROP_ACCESS_CONTROL_WITH_PORT
	"(GMT+05:45) Kathmandu", //up_tz_48
	"Admin Password", //_password_admin
	"Use this section to configure the built-in DHCP Server to assign IP addresses to the computers on your network.", //bd_intro_
	"RADIUS Server IP Address:", //help387
	"Allowed configuration authentication by IP address %v", //GW_AUTH_SUCCEEDED
	"CHAP Authentication details sent to peer.", //IPPPPCHAP_AUTH_SENT
	"The Parental Controls service is a simple yet effective way to limit access to offensive, illegal or hateful web sites. This service covers all PC's or Apple Computers behind your router and is always automatically updated in real time. (No need for you to download or manually input sites.) This service is fast and will not slow down your network.", //_bsecure_parental_blurb
	"This wizard will guide you through the following steps to add a new policy for Access Control.", //_aa_wiz_s1_msg
	"The number of packets received by the router.", //help807
	"(GMT+09:00) Seoul", //up_tz_61
	"L2TP Gateway IP Address", //_L2TPgw
	"MSCHAP authentication failed - please check login details.", //IPMSCHAP_AUTH_FAIL
	"Advanced:", //help395
	"Once you have found the file to be used, click the <span class=\"button_ref\">Upload</span> button below to start the firmware upgrade process. This can take a minute or more.", //help880
	"Medal of Honor: Games", //gw_gm_29
	"The rule applies to a flow of messages whose WAN-side IP address falls within the range set here.", //help95
	"Beacon Period", //aw_BP
	"Stopping WAN Services", //GW_WAN_SERVICES_STOPPED
	"TeamSpeak", //gw_gm_79
	"Select a Network Time Server for synchronization. You can type in the address of a time server or select one from the list. If you have trouble using one server, select another.", //help850
	"You are hosting a Web Server on a PC that has LAN IP Address of 192.168.0.50 and your ISP is blocking Port 80.", //help4
	"(GMT-03:00) Brazilia", //up_tz_18
	"When you use the Virtual Server, Port Forwarding, or Remote Administration features to open specific ports to traffic from the Internet, you could be increasing the exposure of your LAN to cyberattacks from the Internet.", //help168a
	"PPTP ALG rejected packet from %v:%u to %v:%u", //PPTP_ALG_REJECTED_PACKET
	"SMTP Server Address", //te_SMTPSv
	"A MAC address is usually located on a sticker on the bottom of a network device. The MAC address is comprised of twelve digits. Each pair of hexadecimal digits are usually separated by dashes or colons such as 00-0D-88-11-22-33 or 00:0D:88:11:22:33. If your network device is a computer and the network card is already located inside the computer, you can connect to the D-Link router from the computer and click the <span class=\"button_ref\">Copy Your PC's MAC Address</span> button to enter the MAC address.", //help334
	"Battlefield 2", //gw_gm_84
	"L2TP local tunnel 0x%04X RTE module is low on resources.", //IPL2TP_LOW_RESOURCES
	"Click <strong>Add Policy</strong> to start the processes of creating a rule. You can cancel the process at any time. When you are finished creating a rule it will be added to the <strong>Policy Table</strong> below.", //hhac_add
	"Auto 10/100Mbps", //anet_wp_auto2
	"RTSP", //as_RTSP
	"Authentication &amp; Security", //_authsecmodel
	"MTU", //bwn_MTU
	"Steam", //gw_gm_72
	"WAN", //_WAN
	"Ensure the schedule is set to <code>Always</code>", //help10
	"Command and Conquer Generals", //gw_gm_8
	"WPA", //_WPA
	"Re-type the password or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields.", //help897
	"Blocked incoming TCP packet from %v:%u to %v:%u with unexpected sequence %lu (expected %lu to %lu)", //IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ
	"Response from", //tsc_pingt_msg7
	"Jan", //tt_Jan
	"Battlefield: Vietnam", //gw_gm_5
	"Advanced Wireless", //_adwwls
	"Pings sent:", //tsc_pingt_msg100
	"Unreal", //gw_gm_55
	"By default, your new D-Link Router does not have a password configured for administrator access to the Web-based configuration pages. To secure your new networking device, please set and verify a password below, and enabling CAPTCHA Graphical Authentication provides added security protection to prevent unauthorized online users and hacker software from accessing your network settings.", //wwa_intro_s1
	"WAN Ping", //anet_wan_ping
	"<warn>WINS/NetBIOS settings cannot be learned from the internet in this Internet mode - WINS will not function as expected.</warn>", //GW_DHCP_SERVER_WINS_INCOMPATIBILITY_WARNING
	"Many web sites construct pages with images and content from other web sites. For example, to access <code>my.yahoo.com</code>, you would need to select allow and type <code>yahoo.com</code>, <code>yimg.com</code>, and <code>doubleclick.net</code>.", //dlink_help146
	"MAC Address Authentication", //bws_RMAA
	"Step 2 - Select a schedule", //aa_wiz_s1_msg2
	"06:00 AM", //tt_time_7
	"Initiated from WAN to LAN.", //help822a
	"America's Army", //gw_gm_1
	"(GMT+03:00) Baghdad", //up_tz_37
	"Security Mode", //bws_SM
	"(GMT+10:00) Hobart", //up_tz_68
	"- Exactly 64 characters using 0-9 and A-F", //wwl_s4_intro_za3
	"Prev", //_prev
	"Enable Wireless", //bwl_EW
	"The Printer Setup Wizard requires the raw TCP port printing protocol. This protocol is currently disabled on your router.", //wprn_foo1
	"A wireless network uses specific channels in the wireless spectrum to handle communication between clients. Some channels in your area may have interference from other electronic devices. Choose the clearest channel to help optimize the performance and coverage of your wireless network.", //help355
	"Logged", //aa_ACR_c6
	"Second RADIUS server Shared Secret", //bws_2RSSS
	"RADIUS Server Shared Secret:", //help391
	"PM", //_PM
	"Define the ranges of Internet addresses this rule applies to. For a single IP address, enter the same address in both the <span class=\"option\">Start</span> and <span class=\"option\">End</span> boxes. Up to eight ranges can be entered. The <span class=\"option\">Enable</span> checkbox allows you to turn on or off specific entries in the list of ranges.", //help174
	"PPPoE timed out waiting for connection. Connection attempt failed.", //PPPOE_EVENT_DISCOVERY_TIMEOUT
	"Device %s, wsetting.wfc: file not found", //WCN_LOG_NO_WSETTING
	"Parameters for an Application Rule", //haar_p
	"If you leave this option unchecked, you are causing the router to ignore <code>ping</code> commands for the public WAN IP address of the router.", //anet_wan_ping_2
	"To upgrade the firmware, follow these steps:", //help878
	", Logged", //LOGGED
	"Manual", //bwn_RM_2
	"RADIUS server Shared Secret", //bws_RSSs
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"RTSP ALG rejected packet from %v:%u to %v:%u", //IPRTSPALG_REJECTED_PACKET
	"can't be deleted or renamed because it is used.", //GW_SCHEDULES_IN_USE_INVALID_s2
	"Advanced Help", //help1
	"MSN Game Zone", //gw_gm_73
	"Clicking any of these links or buttons will take you to another web site for further information.", //hhtsn_intro
	"Ping Result", //tsc_pingr
	"Manual Uplink Speed", //at_UpSp
	"Step 6 - Configure Web Access Logging", //aa_wiz_s1_msg6
	"PPTP IP Address", //_PPTPip
	"A DTIM is a countdown informing clients of the next window for listening to broadcast and multicast messages. When the wireless router has buffered broadcast or multicast messages for associated clients, it sends the next DTIM with a DTIM Interval value. Wireless clients detect the beacons and awaken to receive the broadcast and multicast messages. The default value is 1. Valid settings are between 1 and 255.", //help185
	"Click this button after changing Log Options to make them effective and permanent.", //help799
	"(GMT-03:30) Newfoundland", //up_tz_17
	"All of your Internet and network connection details are displayed on this page. The firmware version is also displayed here.", //sd_intro
	"Upload", //tf_Upload
	"Second", //tt_Second
	"This will cause all wireless settings to be lost.", //wps_lost
	"Note:", //help26
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"Use this section to configure your Internet Connection type. There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP and L2TP. If you are unsure of your connection method, please contact your Internet Service Provider.", //bwn_intro_ICS
	"Use this section to configure your Internet Connection type. There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP, and 3G USB. If you are unsure of your connection method, please contact your Internet Service Provider.", //bwn_intro_ICS_3G
	"When enabled, this option causes the router to automatically measure the useful uplink bandwidth each time the WAN interface is re-established (after a reboot, for example).", //help81
	"This option allows you to save the router's configuration to a file on your computer. Be sure to save the configuration before performing a firmware upgrade.", //help833
	"Your D-Link Router includes an integrated print server that allows a printer to be shared between multiple computers on your network. From this page you can select which printing protocols to enable.", //tps_intro3
	"Sent", //ss_Sent
	"Group Key Update Interval:", //help378
	"Tribes of Vengeance", //gw_gm_80
	"Upload Succeeded", //_uploadgood
	"PIN (Personal Identification Number)", //wps_p3_2
	"The setup executable will search for a compatible printer driver on your computer. If one cannot be found, you will be prompted to insert the driver CD that shipped with the printer.", //wprn_s3c
	"The router provides only limited firewall protection for the DMZ host. The router does not forward a TCP packet that does not match an active DMZ session, unless it is a connection establishment packet (SYN). Except for this limited protection, the DMZ host is effectively \"outside the firewall\". Anyone considering using a DMZ host should also consider running a firewall on that DMZ host system to provide additional protection.", //haf_dmz_20
	"Go to the Apple Menu, select System Preferences, select Network, and select the Ethernet Adapter connecting to the D-Link router. Select the Ethernet button and the Ethernet ID will be listed. This is the same as the MAC address.", //help343
	"Received", //ss_Received
	"Check this option to connect to the internet through Telstra BigPond Cable Broadband in Australia. Telstra BigPond provides the values for", //help263
	"FREE 30 Day Trial", //_bsecure_free_trial
	"Firmware Upgrade Notification Options", //tf_FUNO
	"Short GI", //aw_sgi
	"Amount of time before a client will be required to re-authenticate.", //help386
	"There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP and L2TP. If you are unsure of your connection method, please contact your Internet Service Provider. Note: If using the PPPoE option, you will need to ensure that any PPPoE client software on your computers is removed or disabled.", //help254_ict
	"There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP, and 3G USB. If you are unsure of your connection method, please contact your Internet Service Provider. Note: If using the PPPoE option, you will need to ensure that any PPPoE client software on your computers is removed or disabled.", //help254_ict_3G
	"Select the method for filtering.", //_aa_wiz_s5_msg1
	"Verify Password or Key", //td_VPWK
	"Need for Speed 3", //gw_gm_33
	"Age of Empires", //gw_gm_0
	"MAC Address Filter", //_macfilt
	"To use this feature, you must first have a Dynamic DNS account from one of the providers in the drop down menu.", //TA16
	"(compatibility for some DHCP Clients)", //bd_DAB_note
	"Select the kinds of events that you want to view.", //help796
	"Do you really want to reprogram the device using the firmware file", //tf_really_FWF
	"(GMT-07:00) Arizona", //up_tz_05
	"03:00 PM", //tt_time_16
	"This email address will appear as the sender when you receive a log file or firmware upgrade notification via email.", //help861
	"Select the protocol used by the service.", //help19
	"DHCP WAN Mode", //bwn_DWM
	"ICMP", //_ICMP
	"Half Life", //gw_gm_22
	"Email Log When Full or on Schedule", //help868
	"Password", //_password
	"05:00 AM", //tt_time_6
	"Click this button to start creating a new access control policy.", //_501_12
	"Check <strong>Enable Access Control</strong> if you want to enforce rules that limit Internet access from specific LAN computers.", //hhac_en
	"Manual Configure", //int_LWlsWz
	"Select Transmission Rate", //at_STR
	"Aug", //tt_Aug
	"Turn MAC Filtering ON and DENY computers listed to access the network", //am_FM_4
	"Step 5 - Select filters", //aa_wiz_s1_msg5
	"Access Control", //ACCESS_CONTROL
	"Error updating dynamic DNS entry: %s. Please check configuration. Disabling DynDNS", //GW_DYNDNS_HERROR
	"Ports to Open", //sps_ports
	"If you do not have the NTP Server option in effect, you can either manually set the time for your router here, or you can click the <span class=\"button_ref\">Copy Your Computer's Time Settings</span> button to copy the time from the computer you are using. (Make sure that computer's time is set correctly.)", //help851
	"You can select a computer from the list of DHCP clients in the <strong>Computer Name</strong> drop down menu, or you can manually enter the IP address of the LAN computer to which you would like to open the specified port.", //hhag_20
	"This Machine rule is already used.", //aa_alert_7
	"DMZ IP Address", //af_DI
	"Available Download Site", //tf_ADS
	"Ping Test sends \"ping\" packets to test a computer on the Internet.", //tsc_pingt_mesg
	"View Levels", //sl_VLevs
	"End Time", //tsc_EndTime
	"A MAC address is a unique ID assigned by the manufacturer of the network adapter.", //help151
	"Choose a port to open for remote management.", //hhta_pt
	"Internet access control dropped packet from %v to %v (protocol %u)", //GW_INET_ACCESS_DROP_ACCESS_CONTROL
	"Enable Auto Channel Scan", //ebwl_AChan
	"STA with MAC (%m) WPS process closed", //WIFISC_AP_PROXY_PROCESS_CLOSE
	"Computer Name", //bd_CName
	"It is recommended that you use the default settings if you do not have an existing network.", //help305rt
	"Invalid password, please try again.", //li_alert_3
	"Updating dynamic DNS entry due to timeout", //GW_DYNDNS_UPDATE_TO
	"4th", //tt_week_4
	"Day", //tt_Day
	"LAN Ethernet Carrier Lost", //GW_LAN_CARRIER_LOST
	"Each rule can either <strong>Allow</strong> or <strong>Deny</strong> access from the WAN.", //hhai_action
	"The Policy Wizard guides you through the steps of defining each access control policy. A policy is the \"Who, What, When, and How\" of access control -- whose computer will be affected by the control, what internet addresses are controlled, when will the control be in effect, and how is the control implemented. You can define multiple policies. The Policy Wizard starts when you click the button below and also when you edit an existing policy.", //help121
	"Use this section to configure the wireless settings for your D-Link Router. Please note that changes made on this section may also need to be duplicated on your Wireless Client.", //bwl_Intro_1
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. If you do not have this information, please contact your ISP.", //wwa_msg_set_pppoe
	"Blocked incoming ICMP packet (ICMP type %u) from %v to %v", //IPNAT_ICMP_BLOCKED_INGRESS_PACKET
	"to improve functionality and performance.", //tf_intro_FWU2
	"Enable Raw Port Printing", //tps_enraw
	"Security Services are a great way to protect all your PC's with a unified suite of services that are managed from any web browser. Includes Anti-Virus, Firewall, Intrusion Detection, Content Filtering, Spam Killer and Pop-up blocker. Any or all services can be selected at one low price.", //_bsecure_security_blurb
	"DHCP Client List", //bd_DHCP
	"Enter your account for sending email.", //help865
	"The WEP ( Wired Equivalent Privacy) key must meet one of following guildelines:", //wwl_s4_intro_z1
	"Download", //help501
	"The ISP provides this parameter, if necessary. The value may be the same as the Gateway IP Address.", //help280
	"DHCP Connection", //help775
	"Connect", //_connect
	"BigPond enabled", //GW_BIGPOND_INIT
	"Always", //_always
	"(minutes)", //_minutes
	"Firewall Port", //as_IPR_b
	"eMule", //gw_gm_67
	"Internet access control dropped bad packet from %v to %v (protocol %u)", //GW_INET_ACCESS_DROP_BAD_PKT
	"Dark Reign 2", //gw_gm_12
	"Hexen II", //gw_gm_25
	"Select the starting and ending times for the change to and from daylight saving time. For example, suppose for DST Start you select Month=\"Oct\", Week=\"3rd\", Day=\"Sun\" and Time=\"2am\". This is the same as saying: \"Daylight saving starts on the third Sunday of October at 2:00 AM.\"", //help846
	"Please select one of following configuration methods and click next to continue.", //wps_KR37
	"Gamespy Arcade", //gw_gm_76
	"Log viewed by IP address %v", //GW_LOGS_VIEWED
	"When WPA enterprise is enabled, the router uses EAP (802.1x) to authenticate clients via a remote RADIUS server.", //bws_msg_EAP
	"WPS Internal Registrar started %s registration", //WIFISC_IR_REGISTRATION_INPROGRESS
	"This is a list of all active conversations between WAN computers and LAN computers.", //hhsa_intro
	"This section allows you to archive your log files to a Syslog Server.", //help856
	"Dir", //sa_Dir
	"IGMP Multicast memberships", //_bln_title_IGMPMemberships
	"L2TP (Username / Password)", //bwn_Mode_L2TP
	"Thu", //_Thu
	"Ping", //_ping
	"Beacons are packets sent by a wireless router to synchronize wireless devices. Specify a Beacon Period value between 20 and 1000. The default value is set to 100 milliseconds.", //help184
	"Select the option that works best for your installation.", //_worksbest
	"unavailable", //_unavailable
	"Detected file system is not compatible (FAT32,FAT16,FAT12)", //IPFAT_INCOMPATIBLE_FILESYS
	"Blocked incoming TCP packet from %v:%u to %v:%u as %s received but there is no active connection", //IPNAT_TCP_BLOCKED_INGRESS_NOT_SYN
	"(GMT-08:00) Pacific Time (US/Canada), Tijuana", //up_tz_04
	"Apply Log Settings Now", //sl_ApplySt
	"CHAP authentication challenge received from peer.", //IPPPPCHAP_CHALLENGE_RECVD
	"This section is where you add the Web sites to be used for Access Control.", //help141
	"Revoke", //bd_Revoke
	"Step 1: Detect the printer", //wprn_intro3
	"Connection Up Time", //_conuptime
	"Verify that the printer is turned on.", //wprn_tt4
	"Wireless Networking technology enables ubiquitous communication", //help383
	"No response to ping from router, will retry.", //tsc_pingt_msg6
	"Initiated from LAN to WAN.", //help821a
	"PPPoE received session offer", //PPPOE_EVENT_SESSION_OFFER_RECVD
	"Myth", //gw_gm_30
	"If you consider yourself an advanced user and have configured a router before, click <span class=\"button_ref\">Manual Configure</span> to input all the settings manually.", //bi_man
	"Mixed (1020-5000, 689)", //help60
	"Remote Admin Port", //ta_RAP
	"BigPond (Australia)", //bwn_Mode_BigPond
	"The current printer status will result in the test page failing to print later in the setup process.", //wprn_cps2
	"DST Start", //tt_dststart
	"When the protocol is TCP, SPI checks that packet sequence numbers are within the valid range for the session, discarding those packets that do not have valid sequence numbers.", //help164_1
	"MSCHAP authentication timed out - authentication failed.", //IPMSCHAP_AUTH_TIMEOUT
	"Email Now", //sl_emailLog
	"Wireless Network Settings", //bwl_title_1
	"BigPond Password", //bwn_BPP
	"Refresh", //sl_reload
	"Step 1: Name your Wireless Network", //wwl_title_s1
	"Failed to mount drive device", //IPDRIVE_MOUNT_FAILED
	"Internet Connection Setup Wizard", //int_ConWz
	"Permit any WAN user to access the related capability.", //help178
	"The <code>Revoke</code> option is available for the situation in which the lease table becomes full or nearly full, you need to recover space in the table for new entries, and you know that some of the currently allocated leases are no longer needed. Clicking <code>Revoke</code> cancels the lease for a specific LAN device and frees an entry in the lease table. Do this only if the device no longer needs the leased IP address, because, for example, it has been removed from the network.", //help329
	"L2TP local tunnel 0x%04X has been disconnected", //IPL2TP_TUNNEL_DISCONNECTED
	"Remote Admin Inbound Filter", //help830
	"The Maximum Transmission Unit (MTU) is a parameter that determines the largest packet size (in bytes) that the router will send to the WAN. If LAN devices send larger packets, the router will break them into smaller packets. Ideally, you should set this to match the MTU of the connection to your ISP. Typical values are 1500 bytes for an Ethernet connection and 1492 bytes for a PPPoE connection. If the router's MTU is set too high, packets will be fragmented downstream. If the router's MTU is set too low, the router will fragment packets unnecessarily and in extreme cases may be unable to establish some connections. In either case, network performance can suffer.", //help294
	"(GMT-02:00) Mid-Atlantic", //up_tz_21
	"Latest Firmware Date", //tf_LFWD
	"BigPond logged in, state=%d, server response=%s", //GW_BIGPOND_SUCCESS
	"Deny All", //_denyall
	"Automatic Classification", //at_AC
	"Visibility Status", //bwl_VS
	"In this section you can see what LAN devices are currently leasing IP addresses.", //help327
	"To complete the setup process, the wizard will now launch an executable file on your computer.", //wprn_s2a
	"(hours)", //td_
	"The remote PPTP access concentrator is slow to respond. There may be connectivity problems.", //PPTP_EVENT_TUNNEL_WINDOW_TIMEOUT
	"Transmit Power", //aw_TP
	"Static IP Address Internet Connection Type", //bwn_SIAICT
	"Multiple connections are required by some applications, such as internet games, video conferencing, Internet telephony, and others. These applications have difficulties working through NAT (Network Address Translation). This section is used to open multiple ports or a range of ports in your router and redirect data through those ports to a single PC on your network. You can enter ports in various formats:", //help57
	"Enable DHCP Server", //bd_EDSv
	"Disconnecting (please wait...)", //_sdi_s5
	"Manufacturer", //wprn_man
	"02:00 AM", //tt_time_3
	"If using the PPPoE option, you will need to remove or disable any PPPoE client software on your computers.", //bwn_note_clientSW
	"(GMT-03:00) Greenland", //up_tz_20
	"RIP has rejected route %v from peer router %v due to low system resources", //RIP_LOW_RESOURCES
	"Service Name:", //help266
	"Connected", //CONNECTED
	"If your ISP has assigned a fixed IP address, select this option. The ISP provides the values for the following fields:", //help265_5
	"Day(s)", //tsc_Days
	"(GMT-05:00) Indiana (East)", //up_tz_13
	"General", //sd_General
	"UPnP helps other UPnP LAN hosts interoperate with the router. Leave the UPnP option enabled as long as the LAN has other UPnP applications.", //hhan_upnp
	"Check with the system administrator of your corporate network whether your VPN client supports NAT traversal.", //help35
	"The IP address of the system on your internal network that will provide the virtual service, for example <code>192.168.0.50</code>.", //help18
	"Printer Setup Wizard", //bwz_psw
	"Date And Time", //tt_DaT
	"Schedules can be created for use with enforcing rules. For example, if you want to restrict web access to Mon-Fri from 3pm to 8pm, you could create a schedule selecting Mon, Tue, Wed, Thu, and Fri and enter a Start Time of 3pm and End Time of 8pm.", //help190
	"SYN Sent -- One of the systems is attempting to start a connection.", //help819_2
	"Maximum Idle Time", //bwn_MIT
	"Give each rule a <strong>Name</strong> that is meaningful to you.", //hhai_name
	"Email log when FULL or on Schedule", //te__title_EmLog
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"SMTP failed during sender/recipient dialog", //IPSMTPCLIENT_DIALOG_FAILED
	"Click the <strong>Clear</strong> button to remove the MAC address from the MAC Filtering list.", //hham_del
	"If your Internet Service Provider was not listed or you don't know who it is, please select the Internet connection type below:", //wwa_msg_ispnot
	"The number of packets that were dropped while being sent, due to errors, collisions, or router resource limitations.", //help808
	"Attempting to establish a PPTP connection.", //PPTP_EVENT_TUNNEL_ESTABLISH_REQUEST
	"Supports use on LAN computers of Microsoft Windows Messenger (the Internet messaging client that ships with Microsoft Windows) and MSN Messenger. The SIP ALG must also be enabled when the Windows Messenger ALG is enabled.", //help37
	"Reboot requested for WCN", //WCN_LOG_REBOOT
	"PPTP connection attempt failed. Check remote PPTP server details.", //PPTP_EVENT_TUNNEL_CONNECT_FAIL
	"Channel Width", //bwl_CWM
	"(GMT-05:00) Eastern Time (US/Canada)", //up_tz_12
	"Cancel", //_cancel
	"Enable UPnP", //ta_EUPNP
	"Enable DNS Relay", //bln_EnDNSRelay
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"DTIM Interval", //aw_DI
	"(GMT+02:00) Athens, Istanbul, Minsk", //up_tz_31
	"Click the <strong>Delete</strong> icon in the Rules List to permanently remove a rule.", //hhai_delete
	"The Virtual Server option allows you to define a single public port on your router for redirection to an internal LAN IP Address and Private LAN port if required. This feature is useful for hosting online services such as FTP or Web Servers.", //av_intro_vs
	"The Firewall Settings section is an advance feature used to allow or deny traffic from passing through the device. It works in the same way as IP Filters with additional settings.  You can create more detailed rules for the device.", //av_intro_if
	"Attempting to re-connect always-on WAN connection", //GW_WAN_RECONNECT_ALWAYS_ON
	"Wireless Security Password", //wwl_WSP
	"In", //INGRESS
	"Restricted", //RESTRICTED
	"Use this Internet connection type if your Internet Service Provider (ISP) didn't provide you with IP Address information and/or a username and password.", //bwn_msg_DHCPDesc
	"The port number used to connect to the authentication server.", //help390
	"Enabling Remote Management allows you to manage the router from anywhere on the Internet. Disabling Remote Management allows you to manage the router only from computers on your LAN.", //help828
	"Re-type the password associated with the account.", //help867
	"Attempting to start always-on WAN connection", //GW_WAN_CONNECT_ALWAYS_ON
	"RTSP ALG rejected packet from %v:%u to %v:%u with odd RTP port %u", //IPRTSPALG_REJECTED_ODD_RTP_PACKET
	"Port Forwarding Fields", //help60f
	"Counter Strike", //gw_gm_10
	"(minutes, 0=infinite)", //bwn_min
	"Month", //tt_Month
	"Use WPA encryption instead of WEP(WPA is stronger than WEP and all D-Link wireless client adapters support WPA)", //wwz_wpa_support
	"Current Firmware Date", //tf_CFWD
	"Advanced Network", //_advnetwork
	"PPPOE Internet Connection Type", //bwn_PPPOEICT
	"RADIUS Server Port:", //help389
	"Select the time offset, if your location observes daylight saving time.", //help844
	"04:00 PM", //tt_time_17
	"L2TP (Layer Two Tunneling Protocol) uses a virtual private network to connect to your ISP. This method of connection requires you to enter a <span class=\"option\">Username</span> and <span class=\"option\">Password</span> (provided by your Internet Service Provider) to gain access to the Internet.", //help284
	"Wireless system with MAC address %m associated", //GW_WIRELESS_DEVICE_ASSOCIATED
	"Second MAC Address Authentication", //bws_2RMAA
	"SIP", //as_SIP
	"Syslog", //help704
	"WPS Internal Registrar failed to add new station, reason %s", //WIFISC_IR_REGISTRATION_FAIL_1
	"(GMT) Greenwich Time: Dublin, Edinburgh, Lisbon, London", //up_tz_25
	"With the above example application rule enabled, the router will open up a range of ports from 6000-6200 for incoming traffic from the Internet, whenever any computer on the internal network opens up an application that sends data to the Internet using a port in the range of 6500-6700.", //help55
	"Wireless Link is up", //GW_WLAN_LINK_UP
	"Enable Dynamic DNS", //td_EnDDNS
	"Inbound Filter Rule", //ai_title_IFR
	"PPTP", //_PPTP
	"Both", //_both
	"(GMT+03:00) Nairobi", //up_tz_40
	"Unplug and reinsert the printer's USB cable.", //wprn_tt8
	"Disable Soft Reset", //tps_dsr
	"Other Machines", //_aa_other_machines
	"This restarts the router. Useful for restarting when you are not near the device.", //help875
	"Website Filter Parameters", //awsf_p
	"- Exactly 5 or 13 characters", //wwl_s4_intro_z2
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need L2TP IP adress. If you do not have this information, please contact your ISP.", //wwa_set_l2tp_msg
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"Error", //_error
	"Dest IP<br />End", //aa_FPR_c4
	"Enable or disable defined rules with the checkboxes at the left.", //help75a
	"Invalid LAN IP Address, ip address in DHCP Server range", //network_dhcp_ip_in_server
	"To upgrade the firmware, your PC must have a wired connection to the router. Enter the name of the firmware upgrade file, and click on the Upload button.", //tf_msg_wired
	"Set Username and Password Connection (PPPoE)", //wwa_title_set_pppoe
	"Enter a host name or IP address above and click 'Ping'", //tsc_pingt_msg1
	"The other options are available for special circumstances.", //bwl_CWM_h2
	"Add New", //dlink_1_add_new
	"Check Online", //help884
	"Rebooting", //rb_Rebooting
	"Time Wait -- Waiting for a short time while a connection that was in FIN Wait is fully closed.", //help819_6
	"09:00 AM", //tt_time_10
	"This section shows the currently defined Schedule Rules. A Schedule Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the \"Edit Schedule Rule\" section is activated for editing.", //help199
	"A method of connection where the ISP assigns your IP address when your router requests one from the ISP's server. Some ISP's require you to make some settings on your side before your router can connect to the Internet.", //help259
	"Application Level Gateway (ALG) Configuration", //af_algconfig
	"PPTP client.", //wwa_msg_pptp
	"Second RADIUS server IP Address", //bws_2RIPA
	"Step 3: Select Machine", //_aa_wiz_s4_title
	"Note: You may also need to provide a Service Name. If you do not have or know this information, please contact your ISP.", //wwa_note_svcn
	"Detected xDSL or Frame Relay Network", //help85
	"If you need to change the MAC address of the router's WAN-side Ethernet interface, either type in an alternate MAC address (for example, the MAC address of the router initially connected to the ISP) or copy the MAC address of a PC. To copy the MAC address of the computer that initially connected to the ISP, connect to the D-Link router using that computer and click the <span class=\"button_ref\">Clone Your PC's MAC Address</span> button. The WAN interface will then use the MAC address of the network adapter in your computer.", //help304
	"Internet access port filter dropped packet from %v:%u to %v:%u (protocol %u)", //GW_INET_ACCESS_DROP_PORT_FILTER_WITH_PORT
	"BigPond Status", //sd_BPSt
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_49
	"World of Warcraft", //gw_gm_62
	"BigPond logged out", //BIGPOND_LOGGED_OUT
	"Email Notification of Newer Firmware Version", //tf_EmNew
	"Internet access policy for MAC address %m cannot be set", //GW_INET_ACCESS_INITIAL_MAC_FAIL
	"MAC Address:", //help303
	"Not Listed or Don't Know", //wwa_selectisp_not
	"Blocked outgoing TCP packet from %v:%u to %v:%u with unexpected acknowledgement %lu (expected %lu to %lu)", //IPNAT_TCP_BLOCKED_EGRESS_BAD_ACK
	"The rule applies to a flow of messages whose LAN-side port number is within the range set here.", //help94
	"Xbox Live", //gw_gm_70
	"Dropped ICMP packet from %v to %v as unable handle packet header", //IPNAT_ICMP_UNABLE_TO_HANDLE_HEADER
	"FTP", //_FTP
	"NAT Endpoint Filtering", //_neft
	"Administration", //ta_A12n
	"D-Link DVC-1000", //gw_gm_83
	"BigPond logged out", //GW_BIGPOND_LOGOUT
	"An application rule is used to open single or multiple ports on your router when the router senses data sent to the Internet on a \"trigger\" port or port range. An application rule applies to all computers on your internal network.", //help46
	"Check the log frequently to detect unauthorized network usage.", //hhsl_intro
	"Tools Help", //help770
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need PPTP IP adress. If you do not have this information, please contact your ISP.", //wwa_msg_set_pptp
	"Unable to find DNS record for firmware upgrade server %s", //GW_FW_NOTIFY_FAILED_DNS
	"Rainbow Six: Raven Shield", //gw_gm_40
	"The router uses the IGMP protocol to support efficient multicasting -- transmission of identical content, such as multimedia, from a source to a number of recipients.", //bln_IGMP_title_h
	"Use <strong>802.11d</strong> only for countries where it is required.", //hhaw_11d
	"If not, press Cancel and then click Save Settings.", //up_jt_2
	"Policy %s started; Internet access for MAC address %s changed to: %s", //GW_INET_ACCESS_POLICY_START_MAC
	"Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this type of connection.", //wwa_msg_pppoe
	"Suppose you configure the DHCP Server to manage addresses From 192.168.0.100 To 192.168.0.199. This means that 192.168.0.3 to 192.168.0.99 and 192.168.0.200 to 192.168.0.254 are NOT managed by the DHCP Server. Computers or devices that use addresses from these ranges are to be manually configured. Suppose you have a web server computer that has a manually configured address of 192.168.0.100. Because this falls within the \"managed range\" be sure to create a reservation for this address and match it to the relevant computer (see <a href=\"#Static_DHCP\">Static DHCP Client</a> below).", //help323
	"The 'admin' and 'user' accounts can access the management interface. The admin has read/write access and can change passwords, while the user has read-only access.", //ta_intro1
	"3rd", //tt_week_3
	"DHCP Server", //_dhcpsrv
	"Dynamic IP", //Dynamic_PPPoE
	"Enabled", //_enabled
	"WINS/NetBIOS may not operate in this mode given your Internet connection settings.", //GW_DHCP_SERVER_WINS_MODE_INVALID
	"One or more Internet access policies are in effect. Internet access will be restricted according to these policies", //GW_INET_ACCESS_RESTRICTED
	"WON Servers", //gw_gm_69
	"Filtering", //aa_ACR_c5
	"This option lets you reserve IP addresses, and assign the same IP address to the network device with the specified MAC address any time it requests an IP address. This is almost the same as when a device has a static IP address except that the device must still request an IP address from the D-Link router. The D-Link router will provide the device the same IP address every time. DHCP Reservations are helpful for server computers on the local network that are hosting applications such as Web and FTP. Servers on your network should either use a static IP address or use this option.", //help331
	"Some changes made using this Setup Wizard may require you to change some settings on your wireless client adapters so they can still connect to the D-Link Router.", //bwz_note_WlsWz
	"You can assign a name for each computer that is given a reserved IP address. This may help you keep track of which computers are assigned this way.", //help345
	"Check the <strong>Application Name</strong> drop down menu for a list of predefined server types. If you select one of the predefined server types, click the arrow button next to the drop down menu to fill out the corresponding field.", //hhav_name
	"Private Port", //av_PriP
	"% loss", //tsc_pingt_msg103
	"If you need to use the UPnP functionality, you can enable it here.", //help_upnp_2
	"Incorrect WAN connectivity mode", //WAN_MODE_INCORRECT
	"WEP password must be exactly 5 alphanumeric characters.", //wwl_alert_pv5_2_5
	"Step 4: Select Filtering Method", //_aa_wiz_s5_title
	"Invalid PIN number.", //KR22_ww
	"Specify rules to prohibit access to specific IP addresses and ports.", //_aa_wiz_s7_help
	"L2TP session server stopped sending sequencing numbers for local session 0x%04X", //IPL2TP_SEQUENCING_DEACTIVATED
	"Advanced Printer Configuration", //tps_apc
	"(GMT-06:00) Mexico City", //up_tz_09
	"Jul", //tt_Jul
	"WAN interface is down", //GW_WAN_INTERFACE_DOWN
	"Restore wireless settings", //WCN_LOG_RESTORE
	"Everquest", //gw_gm_17
	"Internet access for IP address %v set to: %s", //GW_INET_ACCESS_INITIAL_IP
	"Do you want to abandon all changes you made to this wizard?", //_wizquit
	"The System Settings section allows you to reboot the device, or restore the router to the factory default settings. Restoring the unit to the factory default settings will erase all settings, including any rules that you have created.", //tss_intro
	"Endpoint Independent", //af_EFT_0
	"When you set <span class=\"option\">Enable DHCP Server</span>, the following options are displayed.", //help318
	"The SysLog options allow you to send log information to a SysLog Server.", //tsl_intro
	"03:00 AM", //tt_time_4
	"08:00 PM", //tt_time_21
	"L2TP local session 0x%04X connected", //IPL2TP_SESSION_CONNECTED
	"Fragmentation Threshold", //aw_FT
	"Save", //_save
	"Not Estimated", //at_NEst
	"Once you have a firmware update on your computer, use this option to browse for the file and then upload the information into the router.", //help888
	"Firmware", //_firmware
	"Rogue Spear", //gw_gm_43
	"Please start WPS on the wireless device you are adding to your wireless network winth", //wps_messgae1_1
	"L2TP local tunnel 0x%04X RTE module is shutting down.", //IPL2TP_SHUTDOWN_STARTED
	"TX Packets Dropped", //ss_TXPD
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"Click Next if you still want to secure the router with a password and set the time zone.", //wwa_intro_online2
	"Select the outbound protocol used by your application (for example <code>Both</code>).", //help50
	"Enter the UDP ports to open (for example <code>6159-6180, 99</code>).", //help70
	"Encryption", //wwl_enc
	"DHCP Reservation", //bd_title_SDC
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"Ultima", //gw_gm_54
	"Optional backup RADIUS server", //bws_ORAD
	"Administrator logout", //GW_ADMIN_LOGOUT
	"Serious Sam II", //gw_gm_44
	"Enable WAN Ping Respond", //bwn_RPing
	"This option must be enabled if any applications on the LAN participate in a multicast group. If you have a multimedia LAN application that is not receiving content as expected, try enabling this option.", //igmp_e_h
	"The number of packets sent from the router.", //help806
	"DENY computers access to ONLY these sites", //dlink_wf_op_0
	"Enter the outgoing port range used by your application (for example <code>6500-6700</code>).", //help49
	"Example:", //help367
	"Links", //gw_gm_28
	"Windows Me", //help337
	"Administrator Settings", //ta_AdmSt
	"SysLog", //_syslog
	"(GMT-06:00) Central Time (US/Canada)", //up_tz_08
	"If this is selected, the user must connect from the same computer whenever logging into the wireless network.", //help394
	"Step 5: Port Filter", //_aa_wiz_s7_title
	"The Time Configuration option allows you to configure, update, and maintain the correct time on the internal system clock. From this section you can set the time zone that you are in and set the NTP (Network Time Protocol) Server. Daylight Saving can also be configured to automatically adjust the time when needed.", //tt_intro_Time
	"Error updating dynamic DNS entry: %s. Will retry later", //GW_DYNDNS_SERROR
	"Note: All D-Link wireless adapters currently support WPA.", //wwl_s3_note_2
	"Enable BigPond:", //help262
	"Port", //sps_port
	"Whether SPI is enabled or not, the router always tracks TCP connection states and ensures that each TCP packet's flags are valid for the current state.", //help164_2
	"Wait for the router to reboot. This can take another minute or more.", //help881
	"Destination IP", //_destip
	"The Time Configuration option allows you to configure, update, and maintain the correct time on the router's internal system clock. From this section you can set the time zone that you are in and set the Time Server. Daylight saving can also be configured to automatically adjust the time when needed.", //help840
	"L2TP Server IP Address (may be same as gateway)", //wwa_l2tp_svra
	"Daylight Saving Dates", //tt_dsdates
	"Note that L2TP VPN connections typically use IPSec to secure the connection. To achieve multiple VPN pass-through in this case, the IPSec ALG must be enabled.", //help34b
	"10:00 AM", //tt_time_11
	"Enable Email Notification", //te_EnEmN
	"The actual transmission rate of the client in megabits per second.", //help786
	"Username", //bwn_UN
	"This Policy Name is already used.", //aa_alert_8
	"Enable Remote Management", //ta_ERM
	"LCP sets remote auth: %04x", //IPPPPLCP_SET_REMOTE_AUTH
	"L2TP local tunnel 0x%04X RTE module fatal timeout - remote server is not responding.", //IPL2TP_FATAL_TIMEOUT
	"<strong>Non-UDP/TCP/ICMP LAN Sessions</strong> is normally enabled. It facilitates single VPN connections to a remote host.", //hhaf_ngss
	"Network Settings", //bln_title_NetSt
	"Traffic Type", //av_traftype
	"PPTP (Username / Password)", //bwn_Mode_PPTP
	"This section shows the currently defined access control policies. A policy can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the Policy Wizard starts and guides you through the process of changing a policy. You can enable or disable specific policies in the list by clicking the \"Enable\" checkbox.", //help140
	"A Required Printing Protocol Is Disabled", //wprn_rppd
	"All of your WAN and LAN connection details are displayed here.", //hhsd_intro
	"MSCHAP authentication successful.", //IPMSCHAP_AUTH_SUCCESS
	"Suppose you are hosting an online game server that is running on a PC with a private IP Address of 192.168.0.50. This game requires that you open multiple ports (6159-6180, 99) on the router so Internet users can connect.", //help63
	"Please press down the Push Button (physical or virtual) on the wireless device you are adding to your wireless network within", //wps_messgae1_2
	"The new settings have been applied.", //ap_intro_sv
	"L2TP Subnet Mask", //_L2TPsubnet
	"Sending log email before reboot", //GW_LOG_EMAIL_BEFORE_REBOOT
	"Any", //at_Any
	"The following options apply to all WAN modes.", //help288
	"Unless one of these encryption modes is selected, wireless transmissions to and from your wireless network can be easily intercepted and interpreted by unauthorized users.", //bws_SM_h1
	"In addition to the filters listed here, two predefined filters are available wherever inbound filters can be applied:", //help177
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"Please wait <span id=\"show_sec\"></span>&nbsp;seconds.", //rb_wait
	"Wireless Network Name", //bwl_NN
	"L2TP local session 0x%04X connect attempt failed", //IPL2TP_SESSION_CONNECT_FAIL
	"Final Fantasy XI (PS2)", //gw_gm_21
	"BEST", //wwl_BEST
	"Support", //_support
	"You cannot add new IP addresses. You can only reuse IP addresses from other policies.", //aa_alert_14
	"Cable Status", //_cablestate
	"DHCP stands for Dynamic Host Configuration Protocol. The DHCP section is where you configure the built-in DHCP Server to assign IP addresses to the computers and other devices on your local area network (LAN).", //help314
	"Add Wireless Device WITH WPS (WI-FI PROTECTED SETUP) Wizard", //wps_LW13
	"Critical", //sl_Critical
	"The new settings have been saved.", //sc_intro_sv
	"System LOG is inactive", //SYSTEM_LOG_INACTIVE
	"My Internet Connection is", //bwn_mici
	"Minutes", //gw_mins
	"If the router loses power for any reason, it cannot keep its clock running, and will not have the correct time when it is started again. To maintain correct time for schedules and logs, either you must enter the correct time after you restart the router, or you must enable the NTP Server option.", //help852
	"In", //_In
	"Select this option if you want logs to be sent by email according to a schedule.", //help870
	"MSN Game Zone (DX)", //gw_gm_74
	"Firewall and Security", //help797
	"Rainbow Six", //gw_gm_39
	"WEP key must be exactly 10 hexadecimal digits (0-9 or A-F).", //wwl_alert_pv5_3_10
	"The MAC address filter section can be used to filter network access by machines based on the unique MAC addresses of their network adapter(s).", //help149
	"Use this feature if you are trying to execute one of the listed network applications and it is not communicating as expected.", //hhpt_intro
	"WAN interface cable has been connected", //GW_WAN_CARRIER_DETECTED
	"BigPond User Id", //bwn_BPU
	"Select this option if you want this schedule in effect all day for the selected day(s).", //help195
	"The initial value of Time Out depends on the type and state of the connection.", //help823_1
	"Internet Connection", //_internetc
	"Resolved to", //tsc_pingt_msg5
	"Enter a name for the rule that is meaningful to you.", //help172
	"Trigger", //_trigger
	"The Ethernet ID (MAC address) of the wireless client.", //help783
	"The Gateway will not be reprogrammed.", //ub_intro_2
	"For security reasons, it is recommended that you change the password for the Admin and User accounts. Be sure to write down the new and passwords to avoid having to reset the router in case they are forgotten.", //hhta_pw
	"Step 6: Configure Web Access Logging", //_aa_wiz_s8_title
	"The rule can either Allow or Deny messages.", //help173
	"Status Help", //help771
	"Syslog Server IP Address", //tsl_SLSIPA
	"Add Port Filters Rules.", //_aa_wiz_s7_msg
	"12:00 PM", //tt_time_13
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"Primary DNS Server, Secondary DNS Server", //help289a
	"BigPond logged in", //BIGPOND_LOGGED_IN
	"When a LAN host is configured as a DMZ host, it becomes the destination for all incoming packets that do not match some other incoming session or rule. If any other ingress rule is in place, that will be used instead of sending packets to the DMZ host; so, an active session, virtual server, active port trigger, or port forwarding rule will take priority over sending a packet to the DMZ host. (The DMZ policy resembles a default port forwarding rule that forwards every port that is not specifically sent anywhere else.)", //haf_dmz_10
	"State for sessions that use the TCP protocol.", //help819
	"If the progress bar did not appear, the setup executable did not launch and setup is not yet complete. Refer to the Troubleshooting Tips section below.", //wprn_s3b
	"TCP Port", //sps_tcpport
	"Configure Website Filter below:", //dlink_wf_intro
	"Website Filter", //_websfilter
	"BigPond Server Name", //sd_BPSN
	"User Password", //_password_user
	"Policy %s stopped; Internet access for IP address %v changed to: %s", //GW_INET_ACCESS_POLICY_END_IP
	"Choose the mode to be used by the router to connect to the Internet.", //bwn_msg_Modes
	"The IP address \" + mf.dmz_address.value + \" is not valid.", //up_gX_1
	"Next", //_next
	"Setup", //_setup
	"The host is pinged repeatedly until you press this button.", //htsc_pingt_s
	"Email", //EMAIL
	"Mode", //_mode
	"Feb", //tt_Feb
	"Use this information to configure your computer for raw TCP port printing.", //sps_raw1
	"Successfully updated dynamic DNS entry for %s", //GW_DYNDNS_SUCCESS
	"Port forwarding ALG failed to allocate session for TCP packet from %v:%u to %v:%u", //IPPORTFORWARDALG_TCP_PACKET_ALLOC_FAILURE
	"IGMP router has rejected group %v due to low system resources", //IGMP_ROUTER_LOW_RESOURCES
	"The \"Auto 20/40 MHz\" option is usually best.", //bwl_CWM_h1
	"(GMT+04:00) Moscow, St. Petersburg, Volgograd", //up_tz_39
	"Allows devices and applications using VoIP (Voice over IP) to communicate across NAT. Some VoIP applications and devices have the ability to discover NAT devices and work around them. This ALG may interfere with the operation of such devices. If you are having trouble making VoIP calls, try turning this ALG off.", //help40
	"Sign up for D-Link's Free DDNS service at", //td_intro_DDNS_DLINK
	"Port Forwarding", //_pf
	"Dropped UDP packet from %v to %v as unable handle packet header", //IPNAT_UDP_UNABLE_TO_HANDLE_HEADER
	"<warn>Route gateway IP %v matches the address of the intended interface and will be disabled.</warn>", //GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS_WARNING
	"Internet access for MAC address %m set to: %s", //GW_INET_ACCESS_INITIAL_MAC
	"CHAP authentication successful.", //IPPPPCHAP_AUTH_SUCCESS
	"Normally the wireless transmitter operates at 100% power. In some circumstances, however, there might be a need to isolate specific frequencies to a smaller area. By reducing the power of the radio, you can prevent transmissions from reaching beyond your corporate/home office or designated wireless area.", //help187
	"Block All Access", //_aa_block_all
	"Wireless Link is down", //GW_WLAN_LINK_DOWN
	"The amount of time before the group key used for broadcast and multicast data is changed.", //help379
	"(GMT+12:00) Magadan, Solomon Is., New Caledonia", //up_tz_70
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no ICMP session active between %v and %v", //IPNAT_ICMP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"Schedule", //GW_SCHEDULES_IN_USE_INVALID_s1
	"This page is not included in the router's Allowed Web Site List.", //fb_p_2
	"Printer Status", //sps_ps
	"You need to configure your router to allow a software application running on any computer on your network to connect to a web-based server or another user on the Internet.", //help47
	"Step 4: Save Settings and Connect", //wwa_title_s4
	"05:00 PM", //tt_time_18
	"When this option is enabled, router activity logs or firmware upgrade notifications can be emailed to a designated email address, and the following parameters are displayed.", //help860
	"UPnP deleted entry %v <-> %v:%d <-> %v%d %s '%s' (client released address)", //GW_UPNP_IGD_PORTMAP_RELEASE
	"The Setup Wizard has completed. Click the save button to save your settings and reboot the router.", //wwa_intro_s4
	"Some ISP's may require that you enter a Service Name. Only enter a Service Name if your ISP requires one.", //help267
	"L2TP local session 0x%04X aborted", //IPL2TP_SESSION_ABORTED
	"This section allows you to manage the router's configuration settings, reboot the router, and restore the router to the factory default settings. Restoring the unit to the factory default settings will erase all settings, including any rules that you've created.", //help874
	"Sep", //tt_Sep
	"Dropped ESP packet from %v to %v as unable handle packet header", //IPSEC_ALG_ESP_UNABLE_TO_HANDLE_HEADER
	"Group Key Update Interval", //bws_GKUI
	"Enabling <strong>WMM</strong> can help control latency and jitter when transmitting multimedia content over a wireless connection.", //hhaw_wmm
	"In these cases, you can use Inbound Filters to limit that exposure by specifying the IP addresses of internet hosts that you trust to access your LAN through the ports that you have opened. You might, for example, only allow access to a game server on your home LAN from the computers of friends whom you have invited to play the games on that server.", //help168c
	"BigPond logging in", //BIGPOND_LOGGING_IN
	"Username / Password Connection (PPTP)", //wwa_wanmode_pptp
	"Range (50-100)", //help58
	"This option will check D-Link's support site to see if you have the latest version of the firmware available. If a newer version is available, download instructions will be displayed.", //help885
	"Connected", //ddns_connected
	"Upload Failed", //ub_Upload_Failed
	"WPS end for STA with MAC (%m) on msg: %s", //WIFISC_AP_PROXY_END_ON_MSG
	"PPTP (Point to Point Tunneling Protocol) uses a virtual private network to connect to your ISP. This method of connection is primarily used in Europe. This method of connection requires you to enter a <span class=\"option\">Username</span> and <span class=\"option\">Password</span> (provided by your Internet Service Provider) to gain access to the Internet.", //help278
	"Enter either the IP address of the target computer or enter its fully qualified domain name.", //htsc_pingt_h
	"A System Logger (syslog) is a server that collects in one place the logs from different sources. If the LAN includes a syslog server, you can use this option to send the router's logs to that server.", //hhts_def
	"Used when your ISP provides you a set IP address that does not change. The IP information is manually entered in your IP configuration settings. You must enter the", //help255
	"Second RADIUS server Port", //bws_2RSP
	"Enter the Private Port as [80]", //help7
	"Visible", //bwl_VS_0
	"TCP Endpoint Filtering", //af_TEFT
	"When <span class=\"option\">Connection Type</span> is set to <span class=\"option\"> Auto-detect</span>, the automatically detected connection type is displayed here.", //help86
	"Network Name (SSID)", //sd_NNSSID
	"Accessing this web page might have an effect on the measurement.", //wt_p_2
	"Gateway", //_gateway
	"Current Router Time", //tt_CurTime
	"AM", //_AM
	"Disconnected", //DISCONNECTED
	"Soldier of Fortune", //gw_gm_47
	"(GMT-01:00) Azores", //up_tz_22
	"WPS Internal Registrar detected session overlap between %m and %m", //WIFISC_IR_REGISTRATION_SESSION_OVERLAP
	"Please make the two passwords the same and try again", //_pwsame
	"WAN IP changed to %v, updating to dynamic DNS provider", //GW_DYNDNS_UPDATE_IP
	"A network computer (%s) was assigned the IP address of %v.", //GW_DHCPSERVER_NEW_ASSIGNMENT
	"Windows/MSN Messenger", //as_WM
	"(GMT-09:00) Alaska", //up_tz_03
	"Please enter the same password into both boxes, for confirmation.", //ta_msg_TW
	"PBC (Push Button Configuration)", //wps_p3_3
	"Depending on the type of WAN connection, you can take one of the following sets of actions:", //help774
	"Click the <strong>Edit</strong> icon to modify an existing rule using the Policy Wizard.", //hhac_edit
	"(GMT+02:00) Jerusalem", //up_tz_36
	"Host Name", //_hostname
	"Internet access control initialization failed", //GW_INET_ACCESS_INITIAL_FAIL
	"Web filter initialization failed", //GW_WEB_FILTER_INITIAL_FAIL
	"On Schedule", //te_OnSch
	"Step 3: Set your Wireless Security Password", //wwl_title_s4
	"Reconnect Mode:", //help281
	"Gamespy Tunnel", //gw_gm_77
	"Clone Your PC's MAC Address", //_clonemac
	"This is a summary of the number of packets that have passed between the WAN and the LAN since the router was last initialized.", //hhss_intro
	"Measured Uplink Speed", //at_MUS
	"The WAN speed is usually detected automatically. If you are having problems connecting to the WAN, try selecting the speed manually.", //hhan_wans
	"Enable this option only if you have purchased your own domain name and registered with a dynamic DNS service provider. The following parameters are displayed when the option is enabled.", //help892
	"The key is entered as a pass-phrase of up to 63 alphanumeric characters in ASCII (American Standard Code for Information Interchange) format at both ends of the wireless connection. It cannot be shorter than eight characters, although for proper security it needs to be of ample length and should not be a commonly known phrase. This phrase is used to generate session keys that are unique for each wireless client.", //help382
	"(hour:minute, 12 hour time)", //tsc_hrmin
	"(hour:minute, 24 hour time)", //tsc_hrmin1
	"This is the uplink speed measured when the WAN interface was last re-established. The value may be lower than that reported by your ISP as it does not include all of the network protocol overheads associated with your ISP's network. Typically, this figure will be between 87% and 91% of the stated uplink speed for xDSL connections and around 5 kbps lower for cable network connections.", //help82
	"Heretic II", //gw_gm_24
	"Delta Force", //gw_gm_13
	"RTS Threshold", //aw_RT
	"Windows XP", //help340
	"Wireless LAN", //sd_WLAN
	"If your SMTP server requires authentication, select this option.", //help864
	"Destination Port and Start Port should not be equal to 0 for Port Filter", //dlink_1_YM23
	"There may be new firmware for your", //tf_intro_FWU1
	"Unsupported Operating System", //wprn_bados
	"Metric", //_metric
	"Inbound Filter", //INBOUND_FILTER
	"Blocked incoming UDP packet from %v:%u to %v:%u", //IPNAT_UDP_BLOCKED_INGRESS
	"This option turns off and on the wireless connection feature of the router. When you set this option, the following parameters are in effect.", //help351
	"Use this options if you prefer to create our own key.", //wwz_manual_key2
	"PPTP Subnet Mask", //_PPTPsubnet
	"The port that will be used on your internal network.", //help20
	"Black and White", //gw_gm_6
	"WPA Mode", //bws_WPAM
	"GOOD", //wwl_GOOD
	"Postal 2: Share the Pain", //gw_gm_36
	"Enter your host name, fully qualified; for example: <code>myhost.mydomain.net</code>.", //help894
	"Subnet Mask", //_subnet
	"The PPTP transmit window is %u", //PPTP_EVENT_REMOTE_WINDOW_SIZE
	"Step 1: Select Configuration Method for your Wireless Network", //wps_KR35
	"The <code>Reserve</code> option converts this dynamic IP allocation into a DHCP Reservation and adds the corresponding entry to the DHCP Reservations List.", //help329_rsv
	"Vietcong", //gw_gm_58
	"Bringing up WAN using %s", //GW_WAN_MODE_IS
	"Use this section to configure the internal network settings of your router and also to configure the built-in DHCP Server to assign IP addresses to the computers on your network. The IP Address that is configured here is the IP Address that you use to access the Web-based management interface. If you change the IP Address here, you may need to adjust your PC's network settings to access the network again.", //ns_intro_
	"DNS relay ALG rejected packet from %v:%u to %v:%u", //IPDNSRELAYALG_REJECTED_PACKET
	"Traffic Statistics display Receive and Transmit packets passing through your router.", //ss_intro
	"You should examine these warnings as some features may have been disabled.", //KR112
	"<warn>Not all station are able to operate in channel 100-140. Please change channel if the station fails to connect.</warn>", //GW_WLAN_11A_CH_MID_BAND_WARN
	"Enable anti-spoof checking", //KR106
	"Enabling this option can provide protection from certain kinds of \"spoofing\" attacks. However, enble this option with care. With some modems, the WAN connection may be lost when this option is enabled. In that case, it may be necessary to change the LAN subnet to something other than 192.168.0.x (192.168.2.x, for example), to re-establish the WAN connection.", //KR108
	"Rule %s conflicts with an existing connection (%v:%u (public %v:%u)--->%v:%u). Connectivity to the rule may be affected until this connection ends.", //GW_NAT_CONFLICTING_CONNECTIONS_LOG
	"Warnings were raised as a result of configuration changes.", //KR111
	"Log Entries", //KR109
	"<warn>Rule %s conflicts with an existing connection (%v:%u (public %v:%u)--->%v:%u). Connectivity to the rule may be affected until this connection ends.</warn>", //GW_NAT_CONFLICTING_CONNECTIONS_WARNING
	"HNAP SetAccessPointMode %s returns %s, %s", //GW_PURE_SETACCESSPOINTMODE
	"Blocked packet from %v to %v that was received from the wrong network interface (IP address spoofing)", //GW_NAT_REJECTED_SPOOFED_PACKET
	"Message", //KR110
	"<warn>Route gateway IP %v is not in interface subnet (%v/%v) and will be disabled.</warn>", //GW_ROUTES_ROUTE_GATEWAY_NOT_IN_SUBNET_WARNING
	"When this option is enabled, the router restricts the flow of outbound traffic so as not to exceed the WAN uplink bandwidth", //KR107
	"Anti-Spoof checking", //KR105
	"Blocked packet from %v to %v (LAND Attack)", //IPSTACK_REJECTED_LAND_ATTACK
	"WEP", //LS321
	"Log emails", //KR67
	"destination ending port should be between 0 and 65535 inclusive.", //YM71
	"The Source IP Range '%v-%v' is duplicated.", //GW_FIREWALL_RANGE_DUPLICATED_INVALID
	"Hardware Address", //LS422
	"Use Windows Connect Now", //bwz_LWCNWz
	"Invalid WAN gateway IP address: %v", //GW_WAN_WAN_GATEWAY_IP_ADDRESS_INVALID
	"Save Configuration To Wireless Network Setup Wizard", //ta_wcn
	"A PIN is a unique number that can be used to add the router to an existing network or to create a new network. The default PIN may be printed on the bottom of the router. For extra security, a new PIN can be generated. You can restore the default PIN at any time. Only the Administrator (\"admin\" account) can change or reset the PIN.", //LW57
	"WEP Key 2", //_wepkey2
	"Enter the URL (address) of the Web Site that you want to allow; for example: <code>google.com</code>. Do not enter the <code>http://</code> preceding the URL. Enter the most inclusive domain; for example, enter <code>dlink.com</code> and access will be permitted to both <code>www.dlink.com</code> and <code>support.dlink.com</code>.", //help145
	"Hop", //tsc_pingt_msg109
	"NetBIOS node type", //bd_NETBIOS_REG_TYPE
	"Please press the button below to continue configuring the router.", //ap_intro_cont
	"Create a random number that is a valid PIN. This becomes the router's PIN. You can then copy this PIN to the user interface of the registrar.", //LW60
	"Restore Failed", //_rs_failed
	"Select this option if the device is connected to a local network downstream from another router. In this mode, the device functions as a bridge between the network on its WAN port and the devices on its LAN port and those connected to it wirelessly.", //KR62
	"The Wireless Device PIN field can not be blank", //KR20
	"For best performance, use the Automatic Classification option to automatically set the priority for your applications.", //at_intro_2
	"NetBIOS announcement", //bd_NETBIOS_ENABLE
	"The subnet mask of the local area network.", //KR77
	"Super G with Dynamic Turbo", //help364
	"Shopping", //_aa_bsecure_shopping
	"Public Proxies", //_aa_bsecure_public_proxies
	"WEP Key 1", //wepkey1
	"Send/Receive authorization", //ZM11
	"Start Time", //tsc_start_time
	"source ending port should be between 0 and 65535 inclusive.", //YM69
	"If NetBIOS advertisement is swicthed on, switching this setting on causes WINS information to be learned from the WAN side, if available.", //KR82
	"Only Administrator has access to these functionalities. The buttons are disabled as you are not currently logged in as Administrator.", //LW39b
	"The Schedule name '%s' is reserved and can not be used", //GW_SCHEDULES_NAME_RESERVED_INVALID
	"Add Wireless Station", //LW12
	"Windows Media Center", //YM75
	"Route gateway IP %v is invalid", //GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID
	"WPA Group Key Update Interval should be between 30 and 65535 seconds.", //GW_WLAN_WPA_REKEY_TIME_INVALID
	"WEP is the wireless encryption standard. To use it you must enter the same key(s) into the router and the wireless stations. For 64 bit keys you must enter 10 hex digits into each key box. For 128 bit keys you must enter 26 hex digits into each key box. A hex digit is either a number from 0 to 9 or a letter from A to F. For the most secure use of WEP set the authentication type to \"Shared Key\" when WEP is enabled.", //bws_msg_WEP_1
	"Enabling L2 (Layer 2) Isolation prevents associated wireless clients from communicating with each other.", //KR58
	"Gambling", //_aa_bsecure_gambling
	"Bridge Mode", //KR14
	"The given FROM address (%s) is invalid", //GW_SMTP_FROM_ADDRESS_INVALID
	"Indicates how network hosts are to perform NetBIOS name registration and discovery.", //KR89
	"Netmask:", //help106
	"When configuring the router to access the Internet, be sure to choose the correct <strong>Internet Connection Type</strong> from the drop down menu. If you are unsure of which option to choose, contact your <strong>Internet Service Provider (ISP)</strong>.", //LW35
	"Voice (most urgent).", //YM151
	"Your changes have been saved. The router must be rebooted for the changes to take effect. You can reboot now, or you can continue to make other changes and reboot later.", //YM2
	"Note: refer to <a href=\"../Help/Tools.shtml#wcn\" onclick=\"return jump_if();\" style=\"white-space: nowrap;\">Help -> Tools</a> for possible limitations regarding this feature.", //ta_wcn_note
	"The router configuration was changed by something else during wizard operation.\nWizard function will be cancelled, please try again.", //YM131
	"HTTP and HTTPS cannot occupy the same LAN port.", //GW_WEB_SERVER_SAME_PORT_LAN
	"Session Time Out", //KR25
	"Reboot Now", //YM3
	"<warn>The Wake-On-LAN ALG has been automatically enabled because a virtual server entry you created requires it.</warn>", //GW_NAT_WOL_ALG_ACTIVATED_WARNING
	"Invalid Destination IP range for Port Filter", //YM20
	"Enable this option if you want to allow WISH to prioritize your traffic.", //YM141
	"Invalid WAN MAC address: %m", //GW_WAN_MAC_ADDRESS_INVALID
	"recepient email address is in wrong format", //IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT
	"WISH supports overlaps between rules. If more than one rule matches for a specific message flow, the rule with the highest priority will be used.", //YM146
	"Configuration Warnings", //LS151
	"Name can not be empty string.", //GW_QOS_RULES_NAME_INVALID
	"'%s' [protocol:%d]->%v conflicts with '%s' [protocol:%d]->%v.", //GW_NAT_VS_PROTO_CONFLICT_INVALID
	"Name can not be empty string.", //GW_WISH_RULES_NAME_INVALID
	"Adding wireless station %m failed, reason: %s, err_code %u", //WIFISC_IR_REGISTRATION_FAIL
	"ROUTE LIST", //r_rlist
	"Enter an 8- to 63-character alphanumeric pass-phrase.", //KR18
	"128 bit (26 hex digits)", //bws_WKL_1
	"Originator", //sa_Originator
	"Extra Wireless Protection", //aw_erpe
	"Port ranges can not be both empty.", //GW_NAT_PORT_FORWARD_RANGE_BOTH_EMPTY_INVALID
	"Route gateway IP %v is not in interface subnet", //GW_ROUTES_GATEWAY_IP_ADDRESS_IN_SUBNET_INVALID
	"Wireless Wizard", //LW37
	"This feature is disabled when logged in as User", //tsc_pingdisallowed
	"To save the configuration, click the <strong>Save Configuration</strong> button.", //ZM20
	"Cipher Type:", //help376
	"Email Notification is not enabled on Tools->Email Settings page but Email Notification of New Firmware Version is enabled in Tools->Firmware page.", //GW_FW_NOTIFY_EMAIL_DISABLED_INVALID
	"Invalid WEP Key", //YM122
	"DMZ address %v can not be the same as the LAN IP address.", //GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID
	"Incorrectly configured - check logs", //_sdi_s7
	"QoS Engine Setup", //at_title_SESet
	"Start port must be less than end port: %d-%d.", //GW_INET_ACL_START_PORT_INVALID
	"failed to send email data", //IPSMTPCLIENT_DATA_FAILED
	"M-Node (default), this indicates a Mixed-Mode of operation. First Broadcast operation is performed to register hosts and discover other hosts, if broadcast operation fails, WINS servers are tried, if any. This mode favours broadcast operation which may be preferred if WINS servers are reachable by a slow network link and the majority of network services such as servers and printers are local to the LAN.", //KR91
	"Opinion", //_aa_bsecure_opinion
	"Restore Factory Defaults", //tss_RestAll_b
	"%s of '%s' [%s:%s]->%s conflicts with '%s' [%s:%s]->%s.", //GW_NAT_PORT_TRIGGER_CONFLICT_INVALID
	"Fragmentation will occur when frame size in bytes is greater than the Fragmentation Threshold.", //LW54
	"If you already have a DHCP server on your network or are using static IP addresses on all the devices on your network, uncheck <strong>Enable DHCP Server </strong> to disable this feature.", //TA7
	"The IP address of the this device on the local area network.", //KR74
	"Default WEP Key", //bws_DFWK
	"If you are new to wireless networking and have never configured a wireless router before, click on <strong>Wireless Network Setup Wizard</strong> and the router will guide you through a few simple steps to get your wireless network up and running.", //LW46
	"SMTP (Email) server %s is at IP address %v", //IPSMTPCLIENT_RESOLVED_DNS
	"Interface:", //help110
	"Invalid PPTP gateway IP address", //YM107
	"The timeout value cannot be greater than 8760.", //YM180
	"Invalid WAN subnet mask %v", //GW_WAN_WAN_SUBNET_INVALID
	"<warn>DMZ is disabled because the LAN subnet has been changed.</warn>", //GW_NAT_DMZ_DISABLED_WARNING
	"Do you want to disable the DHCP Reservation entry for IP Address", //YM93
	"<warn>The FTP ALG has been automatically enabled because a virtual server entry you created requires it.</warn>", //GW_NAT_FTP_ALG_ACTIVATED_WARNING
	"Free Host", //_aa_bsecure_free_host
	"Invalid Netmask for route", //_r_alert2
	"Invalid MAC Address", //LS47
	"LAN subnet mask leaves no addresses for DHCP server to use.", //GW_DHCP_SERVER_SUBNET_SIZE_INVALID
	"You cannot add new MAC address %m. You can only reuse MAC addresses from other policies.", //GW_INET_ACCESS_POLICY_TOO_MANY_MAC_INVALID
	"Start IP address must be less than end IP address: %v-%v", //GW_FIREWALL_START_IP_ADDRESS_INVALID
	"seconds.", //YM8
	"'%s': Priority, %u, needs to be between 0 and 7", //GW_WISH_RULES_PRIORITY_RANGE
	"Travel", //_aa_bsecure_travel
	"The route metric is a value from 1 to 16 that indicates the cost of using this route. A value of 1 is the lowest cost, and 15 is the highest cost. A value of 16 indicates that the route is not reachable from this router. When trying to reach a particular destination, computers on your network will select the best route, ignoring unreachable routes.", //help113
	"BigPond Client", //ZM6
	"(length applies to all keys)", //bws_length
	"The WCN ActiveX Control provides the necessary WCN link between the router and your PC via the browser. The browser will attempt to download the WCN ActiveX Control, if it is not already available on your PC. For this action to succeed, the WAN connection must be established, and the browser's internet security setting must be Medium or lower (select Tools &rarr; Internet Options &rarr; Security &rarr; Custom Level &rarr; Medium).", //help836
	"Try the restore again with valid restore configuration file.", //rs_intro_2
	"IP address %v already exists.", //GW_INET_ACL_IP_ADDRESS_DUPLICATION_INVALID
	"You must be logged in as Administrator to use these features.", //KR7
	"(automatically disabled if UPnP is enabled)", //ZM1
	"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Advanced → Inbound Filter</a> screen and create a new filter.", //hhta_831
	"Manual Internet Connection Setup", //LW30
	"Invalid L2TP subnet mask", //YM110
	"Point-to-Point (no broadcast)", //bd_NETBIOS_REG_TYPE_P
	"LAN subnet mask is invalid.", //GW_LAN_SUBNET_MASK_INVALID
	"No more reservations may be created", //YM88
	"Invalid primary WINS IP address", //GW_DHCP_SERVER_NETBIOS_PRIMARY_WINS_INVALID
	"Name (if any)", //YM187
	"%s name %s of '%s' is not defined.", //GW_NAT_NAME_UNDEFINED_INVALID
	"Wireless radar detected on channel %d", //GW_WIRELESS_RADAR_DETECTED
	"Pre-shared Key", //LW25
	"Restore Invalid", //_rs_invalid
	"Invalid primary DNS server IP address", //YM113
	"Wi-FI Protected Setup", //LW65
	"Select this option if your wireless device supports push button", //KR41
	"Invalid primary DNS server IP address: %v", //GW_WAN_DNS_SERVER_PRIMARY_INVALID
	"The Wireless Device PIN is not valid", //KR21
	"Personals", //_aa_bsecure_personals
	"The <span class=\"option\">Router IP Address</span> field below must be set to the IP address of this device. The <span class=\"option\">Gateway</span> must be set to the IP address of the upstream router. Both addresses must be within the LAN subnet as specified by <span class=\"option\">Subnet Mask</span>.", //KR63
	"The following Web-based Setup Wizard is designed to assist you in your printer setup. This Setup Wizard will guide you through step-by-step instructions on how to set up your printer.", //LW31
	"Invalid secondary DNS server IP address: %v", //GW_WAN_DNS_SERVER_SECONDARY_INVALID
	"If you would like to configure the Internet settings of your new D-Link Systems Router manually, then click on the button below.", //LW29
	"Invalid remote end IP Address.", //YM55
	"For information on which configuration method your wireless device support, please refer to the adapters' documentation.", //KR37
	"Check this box to allow the DHCP Server to offer NetBIOS configuration settings to the LAN hosts.", //KR80
	"Invalid WAN subnet mask", //YM100
	"Wake-On-LAN", //_wakeonlan
	"The device may be too busy to properly receive it right now. Please try the restore again. It is also possible that you are logged in as a 'user' instead of an 'admin' - only administrators can restore the configuration file. Please check the system log for any errors.", //rs_intro_3
	"PalTalk", //YM47
	"You will be redirected to the login page in:", //YM7
	"If you are not utilizing Super G with Dynamic Turbo for its speed improvements, enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //YM124g
	"MAC address %m already exists.", //GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID
	"invalid destination starting IP Address.", //YM66
	"optional", //LT124
	"NetBIOS Advertisement", //bd_NETBIOS
	"Target", //sa_Target
	"This section is where you define application rules.", //help56_a
	"<warn>DHCP Server is being reconfigured because the LAN subnet is not suitable, please ensure your server remains correct.</warn>", //GW_DHCP_SERVER_RECONFIG_WARNING
	"Failed", //_wifisc_addfail
	"Beacon period should be between 20 and 1000.", //GW_WLAN_BEACON_PERIOD_INVALID
	"Best Effort (BE)", //YM79
	"Invalid Aggregation Max Size", //YM32
	"This will save the current wireless configuration from the router to your computer through Microsoft's Windows Connect Now technology and allow future propagation of the setting through Microsoft's Wireless Network Setup Wizard.", //ta_intro_wcn
	"Select this option if your wireless adapters SUPPORT WPA", //wwl_text_better
	"Background (BK)", //YM78
	"Channel", //sd_channel
	"Note that different LAN computers cannot be associated with Port Forwarding rules that contain any ports in common; such rules would contradict each other.", //KR53
	"<strong>Lock Wireless Security Settings</strong> after all wireless network devices have been configured.", //LW16
	"TCP", //GW_NAT_TCP
	"This router has a USB port; so, if you have a USB flash drive, a USB port on your PC, and your PC runs Windows XP Service Pack 2 (SP2) or later, you can transfer wireless configuration data between your PC and the router with the USB flash drive. Go to the Windows Control Panel and select Wireless Network Setup Wizard. The Wireless Network Setup Wizard gives you the choices: \"Use a USB flash drive\" and \"Set up a network manually\". Select \"Use a USB flash drive\".", //help202
	"[CRIT]", //CRIT
	"The rule applies to a flow of messages for which the other computer's IP address falls within the range set here.", //YM154
	"The QoS Engine feature helps improve your network performance by prioritizing applications.", //help76
	"'%s': Host 1 port start, %u, must be less than host 1 port end, %u", //GW_WISH_RULES_HOST1_PORT
	"For 11g Turbo mode, the channel should be set to 6.", //GW_WLAN_11G_TURBO_INVALID
	"Entertainment", //_aa_bsecure_entertainment
	"Inactive", //YM165
	"Enter a name for the Special Application Rule, for example <code>Game App</code>, which will help you identify the rule in the future. Alternatively, you can select from the <span class=\"option\">Application</span> list of common applications.", //help48
	"Lifestyles", //_aa_bsecure_lifestyles
	"DMZ address should be within LAN subnet(%v).", //GW_NAT_DMZ_NOT_IN_SUBNET_INVALID
	"Turbo Mode", //sd_TMode
	"%s port range '%s' of '%s' is invalid.", //GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID
	"Please select a filter.", //GW_INET_ACL_NO_FILTER_SELECTED_INVALID
	"'%s': Local IP end '%v' is not in the LAN subnet", //GW_QOS_RULES_LOCAL_IP_END_SUBNET
	"AES", //bws_CT_2
	"Note that it is not possible to control access to web sites that use the secure HTTP protocol; that is, those whose URL is of the form <code>https://...</code>.", //_bsecure_parental_limits
	"64 Kbytes", //aw_64
	"Humor", //_aa_bsecure_humor
	"P-Node, this indicates to use WINS servers ONLY. This setting is useful to force all NetBIOS operation to the configured WINS servers. You must have configured at least the primary WINS server IP to point to a working WINS server.", //KR92
	"Router Mode", //KR13
	"Policy name can't be duplicated: %s.", //GW_INET_ACL_POLICY_NAME_DUPLICATE_INVALID
	"The NAT does not forward any incoming connection requests with the same port address as an already establish connection.", //YM136
	"Hardware Version", //TA3
	"Super G without Turbo:", //help360
	"Warnings", //YM10
	"Invalid PPTP server IP address: %v", //GW_WAN_PPTP_SERVER_IP_ADDRESS_INVALID
	"Video.", //YM150
	"The IP address %v is in use; you must Revoke its lease and reset the network settings for the device that uses it.", //GW_DHCP_SERVER_RESERVATION_IN_USE
	"Firewall Port", //GW_NAT_INPUT_PORT
	"Reboot by %s complete", //WIFISC_AP_REBOOT_COMPLETE
	"Latest Firmware Version", //YM182
	"1000Mbps", //LW3
	"WPA Personal Key must be at least 8 characters.", //YM116
	"WEP Key", //LW22
	"Open", //OPEN
	"WISH Sessions", //YM158
	"Send/Receive instance failure", //ZM16
	"Select Age Category", //_aa_bsecure_select_age
	"Route destination IP %v is invalid", //GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID
	"Reset by %s complete", //WIFISC_AP_RESET_COMPLETE
	"NetBIOS Registration mode", //bd_NETBIOS_REG
	"LAN Gateway IP address is invalid.", //GW_LAN_GATEWAY_IP_ADDRESS_INVALID
	"Saves the new or edited Schedule Rule.", //KR96
	"Successfully exported configuration file", //GW_XML_CONFIG_GET_SUCCESS
	"Nothing has changed, save anyway?", //_ask_nochange
	"UPnP renew entry %v <-> %v:%d <-> %v:%d %s timeout:%d '%s'", //GW_UPNP_IGD_PORTMAP_REFRESH
	"To achieve better wireless performance use <strong>WPA2 Only</strong> security mode (or in other words AES cipher).", //bws_msg_WPA_2
	"LAN IP address is invalid.", //GW_LAN_IP_ADDRESS_INVALID
	"Remote IP Start", //KR5
	"The QoS Engine supports overlaps between rules, where more than one rule can match for a specific message flow. If more than one rule is found to match the rule with the highest priority will be used.", //help88c
	"Schedule name %s is not defined.", //GW_INET_ACL_SCHEDULE_NAME_INVALID
	"'%s': Remote port start, %u, must be less than remote port end, %u", //GW_QOS_RULES_REMOTE_PORT
	"IP address for '%s' should be within LAN subnet (%v).", //GW_NAT_IP_ADDRESS_INVALID
	"128-bit hexadecimal keys are exactly 26 characters in length. (456FBCDF123400122225271730 is a valid string of 26 characters for 128-bit encryption.)", //help369
	"Instead of entering a name for the Special Application rule, you can select from this list of common applications, and the remaining configuration values will be filled in accordingly.", //help48a
	"Wireless Settings", //LW38
	"user account must be specified", //GW_DYNDNS_USER_NAME_INVALID
	"The destination IP address is the address of the host or network you wish to reach.", //hhav_r_dest_ip
	"The remote admin port number is not valid.", //YM175
	"Wi-Fi Protected Setup is used to easily add devices to a network using a PIN or button press. Devices must support Wi-Fi Protected Setup in order to be configured by this method.", //LY3
	"UPnP added entry %v <-> %v:%d <-> %v:%d %s timeout:%d '%s'", //GW_UPNP_IGD_PORTMAP_ADD
	"UPnP conflict with existing entry %v <-> %v:%d <-> %v:%d %s '%s'", //GW_UPNP_IGD_PORTMAP_CONFLICT
	"Message", //KRA1
	"Port", //_vs_port
	"<warn>Access Control Table is being reconfigured because the LAN subnet has been changed.</warn>", //GW_INET_ACL_RECONFIGURED_WARNING
	"Enables the router to recognize certain audio and video streams generated by a Windows Media Center PC and to prioritize these above other traffic. Such streams are used by systems known as Windows Media Extenders, such as the Xbox 360.", //help80b
	"For most applications, the priority classifiers ensure the right priorities and specific WISH Rules are not required.", //YM145
	"Unset Selected Registrar", //WIFISC_AP_UNSET_SELECTED_REGISTRAR
	"Secondary DNS cannot be specified without giving a primary also.", //GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID
	"WISH (Wireless Intelligent Stream Handling) prioritizes the traffic of various wireless applications.", //YM72
	"Helpful Hints", //_hints
	"'%s': Local port start, %u, must be less than local port end, %u", //GW_QOS_RULES_LOCAL_PORT
	"Invalid local start IP Address.", //YM52
	"Chat", //_aa_bsecure_chat
	"Destination IP:", //help104
	"Note that, in Microsoft's current implementation of WCN, you cannot save the wireless settings if a profile of the same name already exists. To work around this limitation, either delete the existing profile or change the SSID when you change the wireless settings; then, when you save the new settings, a new profile will be created.", //help839
	"Invalid WAN IP address", //YM99
	"By Age", //_aa_bsecure_byage
	"Name '%s' already exists.", //GW_INET_ACL_NAME_DUPLICATE_INVALID
	"The DHCP server end address %v is not valid in the LAN subnet %v.", //GW_DHCP_SERVER_POOL_TO_INVALID
	"In progress", //KR26
	"Do you want to enable the DHCP Reservation entry for IP Address", //YM92
	"Reserved IP %v is invalid", //GW_DHCP_SERVER_RESERVED_IP_INVALID
	"The common choices -- UDP, TCP, and both UDP and TCP -- can be selected from the drop-down menu.", //help19x1
	"Unstable", //_aa_bsecure_unstable
	"Reserved IP address %v should be within the configured DHCP range.", //GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
	"Filter Rule '%s' can't be deleted or renamed because it is used.", //GW_FIREWALL_FILTER_NAME_INVALID
	"You might need this file so that you can load your configuration later in the event that the router's default settings are restored.", //ZM19
	"Video (VI)", //YM80
	"Secondary WINS Server IP address", //bd_NETBIOS_WINS_2
	"Re-initializes the Add/Update area of the screen, erasing any changes that you may have made prior to clicking the Add/Update button.", //KR57
	"Active", //YM164
	"IP address is not allowed", //_logsyslog_alert2
	"Best Effort.", //YM149
	"Invalid DHCP Server lease time", //LT120
	"Auto (WPA or WPA2) - Personal", //KR48
	"Invalid Reconnect interval: %u (must be between 20 and 180)", //GW_WAN_RECONNECT_INTERVAL_INVALID
	"Controls endpoint filtering for packets of the TCP protocol.", //YM139
	"Remote start port should be between 0 and 65535 inclusive.", //YM61
	"<warn>Virtual Server Table is being reconfigured because the LAN subnet has been changed.</warn>", //GW_NAT_VIRTUAL_SERVER_TABLE_RECONFIGURED_WARNING
	"Reboot needed", //YM1
	"WEP Key Length", //bws_WKL
	"PIN Settings", //LY5
	"Save Settings Succeeded", //KR102
	"'%s': Local IP start '%v' is not in the LAN subnet", //GW_QOS_RULES_LOCAL_IP_START_SUBNET
	"Invalid PPTP IP address: %v", //GW_WAN_PPTP_IP_ADDRESS_INVALID
	"Alcohol", //_aa_bsecure_alcohol
	"Port Filter rule names cannot be duplicated.", //YM14
	"Dynamic Turbo mode is not allowed with 802.11b.", //GW_WLAN_11B_DYNAMIC_TURBO_INVALID
	"UPnP expired entry %v <-> %v:%d <-> %v%d %s '%s'", //GW_UPNP_IGD_PORTMAP_EXPIRE
	"One bits in the mask specify which bits of the IP address must match.", //help107
	"This option is available only when <span class=\"option\">802.11 Mode</span> is set to <span class=\"option\">802.11ng only</span>.", //aw_erpe_h2
	"Invalid Destination Port Start for Port Filter", //YM21
	"The priority of the message flow is entered here. Four priorities are defined:", //YM147
	"When the log email option is set, log emails are sent to the Internet by way of the upstream router.", //KR68
	"This Wizard helps you add wireless devices to the wireless network.", //LW61
	"A L2TP user name MUST be specified", //GW_WAN_L2TP_USERNAME_INVALID
	"Invalid Secondary WINS IP", //LT120z
	"WPA/WPA2", //KR97
	"Invalid L2TP subnet mask %v", //GW_WAN_L2TP_SUBNET_INVALID
	"Save Settings To Local Hard Drive", //help_ts_ss
	"Automobile", //_aa_bsecure_automobile
	"Add Wireless Device Wizard", //LW13
	"Time Frame", //sch_time
	"To protect your privacy you can configure wireless security features. This device supports three wireless security modes, including WEP, WPA-Personal, and WPA-Enterprise. WEP is the original wireless encryption standard. WPA provides a higher level of security. WPA-Personal does not require an authentication server. The WPA-Enterprise option requires an external RADIUS server.", //bws_intro_WlsSec
	"A PPPoE password MUST be specified", //GW_WAN_PPPOE_PASSWORD_INVALID
	"Before you can use the router's WCN Wizard, you must first execute the Wireless Network Setup Wizard on your PC. If you have not already done so, go to the Windows Control Panel and select Wireless Network Setup Wizard. When the Wireless Network Setup Wizard gives you the choice to \"Use a USB flash drive\" or \"Set up a network manually\", choose the latter. (In fact, you will not have to do the set-up manually; it will be done with the WCN ActiveX Control.)", //help211
	"Invalid Subnet Mask", //LS202
	"End Time", //tsc_end_time
	"This wizard will guide you through a step-by-step process to add your wireless device to your wireless network.", //KR34
	"WEP Key 3", //_wepkey3
	"Remote Port Range", //at_RePortR
	"Other", //_vs_other
	"The given server address (%s) is invalid", //GW_SMTP_SERVER_ADDRESS_INVALID
	"Invalid L2TP gateway IP address: %v", //GW_WAN_L2TP_GATEWAY_IP_ADDRESS_INVALID
	"Shows the current value of the router's PIN.", //LW58
	"Key In Use", //LW22usekey
	"Static Turbo mode is not allowed with 802.11b.", //GW_WLAN_11B_STATIC_TURBO_INVALID
	"invalid destination ending IP Address.", //YM67
	"<warn>Changing wireless security settings may cause Wi-Fi protected Setup to not function as expected.</warn>", //GW_WIFISC_CFG_CHANGED_WARNING
	"Restart during DNS query", //ZM10
	"Can not use 802.11b/g channel when the 802.11 mode is 802.11a.", //GW_WLAN_11A_CHANNEL_INVALID
	"QoS Engine Rules", //at_title_SERules
	"The remote admin port should be in the range of 1 to 65535.", //YM176
	"NetBIOS allow LAN hosts to discover all other computers within the network, e.g. within Network Neighbourhood.", //KR81
	"TCP Port", //GW_NAT_TCP_PORT
	"The rule applies to a flow of messages for which host 2's port number is within the range set here.", //YM155
	"This mode is backwards compatible with non-Turbo (legacy) devices. This mode should be enabled when some devices on the wireless network are not Turbo enabled but support other Super G features mentioned above.", //help365
	"NetBIOS Scope", //bd_NETBIOS_SCOPE
	"Session Aborted", //KR28
	"Web Filter", //_webfilter
	"Invalid Aggregation Num Packets", //YM33
	"Automatic", //YM76
	"Unlock AP setup", //WIFISC_AP_SETUP_UNLOCKED
	"Virtual server '%s' can not use the router's HTTPS WAN administration port, %u", //GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
	"Release", //LS313
	"Microsoft Windows Connect Now Wizard", //bwz_WCNWz
	"DNS Lookup Login Server", //ZM9
	"Reserved IP address for this MAC address(%m) is already set.", //GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID
	"PIN Settings", //LW7
	"For most applications, the priority classifiers ensure the right priorities, and specific WISH Rules are not required.", //YM87
	"The WAN Ping filter name %s does not exist", //GW_NAT_WAN_PING_FILTER_INVALID
	"If your PC's operating system is Windows XP Service Pack 2 (SP2) or later and you are using Windows Internet Explorer (IE) as your browser, you can use this option to save key parts of the router's current wireless security settings to your PC with Windows Connect Now (WCN) technology. The settings will then be available to propagate to other wireless devices.", //help835
	"(1..255)", //at_lowpriority
	"A name is required for rule number", //YM49
	"You cannot add new IP address %v. You can only reuse IP addresses from other policies.", //GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID
	"Invalid L2TP server IP address", //YM112
	"H-Node, this indicates a Hybrid-State of operation. First WINS servers are tried, if any, followed by local network broadcast. This is generally the preferred mode if you have configured WINS servers.", //KR90
	"Note that WCN only saves a few of the wireless security settings. When you use WCN to propagate settings to other wireless devices, you may have to make additional settings manually on those devices.", //help838
	"Enable Traffic Shaping", //at_ETS
	"If WAN Port Mode is set to \"Bridge Mode\", the following choices are displayed in place of the above choices, because the device is functioning as a bridge in a network that contains another router.", //KR73
	"There are several levels of wireless security. The level you choose depends on the security features your wireless adapters support.", //wwl_intro_s3_2
	"Invalid Metric for route", //_r_alert5
	"<warn>The WAN Ping filter name %s no longer exists, WAN PING will be disabled.</warn>", //GW_NAT_WAN_PING_FILTER_WARNING
	"Invalid local end IP Address.", //YM53
	"Note that WCN only sets a few of the wireless options. You will still need to go to the <a href=\"wireless.asp\">Wireless Settings</a> page to set other wireless options such as Super G Mode and transmission rate.", //help215
	"WISH is short for Wireless Intelligent Stream Handling, a technology developed to enhance your experience of using a wireless network by prioritizing the traffic of different applications.", //YM140
	"The DHCP server address %v was rejected by the network device. If you have more than one DHCP server on your network this may cause IP address conflicts.", //GW_DHCPSERVER_REJECTED
	"Allows the router to recognize HTTP transfers for many common audio and video streams and prioritize them above other traffic. Such streams are frequently used by digital media players.", //YM142
	"password must be specified", //GW_DYNDNS_PASSWORD_INVALID
	"The rule applies to a flow of messages for which one computer's IP address falls within the range set here.", //YM152
	"Invalid DHCP Server End IP Range", //LT119a
	"If you are having trouble accessing the Internet through the router, double check any settings you have entered on this page and verify them with your ISP if needed.", //LW36
	"The encryption algorithm used to secure the data communication. TKIP (Temporal Key Integrity Protocol) provides per-packet key generation and is based on WEP. AES (Advanced Encryption Standard) is a very secure block based encryption. With the \"TKIP and AES\" option, the router negotiates the cipher type with the client, and uses AES when available.", //help377
	"%s '%s' is invalid.", //GW_NAT_PORT_TRIGGER_PORT_RANGE_INVALID
	"Invalid WEP Keys", //YM121
	"Invalid Fragmentation Threshold", //YM29
	"The WISH Sessions page displays full details of active local wireless sessions through your router when WISH has been enabled. A WISH session is a conversation between a program or application on a wirelessly connected LAN-side computer and another computer, however connected.", //YM159
	"Invalid Port Number.", //YM120
	"BETTER", //wwl_BETTER
	"Enable the Wi-Fi Protected Setup feature.", //LW55
	"Invalid PPTP subnet mask", //YM106
	"Block Unrated Sites", //_aa_bsecure_block_unrated
	"A Big Pond user name MUST be specified", //GW_WAN_BIGPOND_USERNAME_INVALID
	"For example, 192.168.0.101.", //KR76
	"The DHCP server can offer no more IP addresses because all available addresses are in use. Increase the number of available IP addresses on the DHCP server configuration.", //GW_DHCPSERVER_EXHAUSTED
	"Invalid L2TP server IP address: %v", //GW_WAN_L2TP_SERVER_IP_ADDRESS_INVALID
	"WEP password must be exactly 13 alphanumeric characters.", //wwl_alert_pv5_2
	"Route subnet %v is invalid", //GW_ROUTES_SUBNET_INVALID
	"Drugs", //_aa_bsecure_drugs
	"IP address cannot be the same as LAN IP address of the router.", //LW1
	"A network computer never renewed its 'leasease' of %v and has lost its right to use that address. If the device continues to use that address it may cause IP address conflicts.", //GW_DHCPSERVER_EXPIRED
	"IP address %v should be within LAN subnet (%v).", //GW_INET_ACL_IP_ADDRESS_IN_LAN_SUBNET_INVALID
	"Broadcast only (use when no WINS servers configured)", //bd_NETBIOS_REG_TYPE_B
	"Financial", //_aa_bsecure_financial
	"The NAT forwards incoming connection requests to a LAN-side host only when they come from the same IP address with which a connection was established. This allows the remote application to send data back through a port different from the one used when the outgoing session was created.", //YM135
	"Invalid DHCP Server Start IP Range", //LT119
	"Public", //_vs_public
	"B-Node, this indicates to use local network broadcast ONLY. This setting is useful where there are no WINS servers available, however, it is preferred you try M-Node operation first.", //KR93
	"Gateway remote administration enabled on port: %u", //GW_SECURE_REMOTE_ADMINSTRATION
	"Employment", //_aa_bsecure_employment
	"The IP address and, where appropriate, port number of the computer that originated a network connection.", //YM160
	"Assigned IP", //LS423
	"L2TP Gateway IP address %v must be within the WAN subnet.", //GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID
	"'%s': Host 1 IP start, %v, must be less than host 1 IP end, %v", //GW_WISH_RULES_HOST1_IP
	"Private", //_vs_private
	"This setting has no effect if the 'Learn NetBIOS information from WAN' is activated.", //KR86
	"Secondary WINS IP Address", //bd_NETBIOS_SEC_WINS
	"Start IP address must be less than end IP address: %v-%v.", //GW_INET_ACL_START_IP_ADDRESS_INVALID
	"Authentication", //auth
	"Can not stop the process", //KR24
	"5GHz", //KR17
	"Host 2 IP Range", //YM84
	"A QoS Engine Rule identifies a specific message flow and assigns a priority to that flow.", //help88
	"Enabling this option (the default setting) enables single VPN connections to a remote host. (But, for multiple VPN connections, the appropriate VPN ALG must be used.) Disabling this option, however, only disables VPN if the appropriate VPN ALG is also disabled.", //LW50
	"Invalid PPPoE IP address", //YM103
	"In bridge mode, the device still supports several features not available in ordinary bridges -- features that involve the WAN side of the upstream router.", //KR64
	"Performance enhancing features such as Packet Bursting, FastFrames, and Compression.", //help361
	"Wi-Fi Protected Setup", //LW4
	"PIN", //KR38
	"For 11a Static Turbo mode, channel should be set to one of 42,50,58,152, or 160.", //GW_WLAN_11A_STATIC_TURBO_INVALID
	"Super G™ Mode", //help358
	"You do not have permissions to perform the specified action.", //YM6
	"Categories Selection", //_aa_bsecure_categ_select
	"Priority must be a number between 1 and 255 inclusive.", //YM58
	"Youth (13-17)", //_aa_bsecure_age_youth
	"Click <strong>Add Wireless Device Wizard</strong> to use Wi-Fi Protected Setup to add wireless devices to the wireless network.", //LW17
	"Invalid Destination IP End address for Port Filter", //YM18
	"WPA2-PSK/AES (also known as WPA2 Personal)", //LT210
	"Invalid Idle Time (the permitted range is %u to %u)", //GW_WAN_IDLE_TIME_INVALID
	"Multicast Group Address", //YM186
	"Sports", //_aa_bsecure_sports
	"Name '%s' is already used.", //GW_QOS_RULES_NAME_ALREADY_USED
	"The following wizard uses Microsoft's Windows Connect Now technology to automatically configure the wireless settings on your Router. Make sure that you have sucessfully run Microsoft's Network Wireless Configuarion Wizard on your computer before using this feature.", //bwz_intro_WCNWz
	"DHCP server pool TO %v is not in LAN subnet %v.", //GW_DHCP_SERVER_POOL_TO_IN_SUBNET_INVALID
	"<warn>The H.323 has been automatically enabled because a virtual server entry you created requires it.</warn>", //GW_NAT_H323_ALG_ACTIVATED_WARNING
	"L2 Isolation", //KR4
	"Invalid Primary WINS IP", //LT120y
	"The Wi-Fi Protected Setup Network Settings have been saved successfully.", //KR103
	"Calista IP phone", //YM44
	"If you consider yourself an advanced user and have configured a wireless router before, click <strong>Manual Wireless Network Setup</strong> to input all the settings manually.", //LW47
	"Failed to export configuration file #%u", //GW_XML_CONFIG_GET_FAILED
	"SetAPSettings by (%s) complete", //WIFISC_AP_SET_APSETTINGS_COMPLETE
	"Wep Key Length", //wwl_WKL
	"Communication with the router failed", //YM168
	"Name '%s' is already used.", //GW_NAT_NAME_USED_INVALID
	"invalid server index value: %d", //GW_DYNDNS_SERVER_INDEX_VALUE_INVALID
	"[WARN]", //WARN
	"Enterprise", //LW23
	"Advanced Network", //ADVANCED_NETWORK
	"A PPTP password MUST be specified", //GW_WAN_PPTP_PASSWORD_INVALID
	"Restore the default PIN of the router.", //LW59
	"If you have enabled Wireless Security, make sure you write down the Key or Passphrase that you have configured. You will need to enter this information on any wireless device that you connect to your wireless network.", //YM126
	"Enabled/Configured", //LW66
	"Invalid Interface for route", //_r_alert4
	"Add Wireless Station", //LY10
	"The DHCP server start address %v is not valid in the LAN subnet %v.", //GW_DHCP_SERVER_POOL_FROM_INVALID
	"Lock AP setup", //WIFISC_AP_SETUP_LOCKED
	"Do you want to abandon changes you made to the current entry?", //YM91
	"Set Selected Registrar failed, reason (%s), err_code (%u)", //WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL
	"Nothing has changed, save anyway?", //LS3
	"Unknown", //GW_NAT_UNKNOWN
	"For 11a Dynamic Turbo mode, channel should be set to one of 40,48,56,153, or 161.", //GW_WLAN_11A_DYNAMIC_TURBO_INVALID
	"Note that, even when NTP Server is enabled, you must still choose a time zone and set the daylight saving parameters.", //YM163
	"To use this feature, you must first have a Dynamic DNS account from one of the providers in the drop down menu.", //YM181
	"Insufficient Permission", //_cantapplysettings_1
	"Warnings:", //YM11
	"(8 to 63 characters)", //wwl_wsp_chars_2
	"Primary WINS IP Address", //bd_NETBIOS_PRI_WINS
	"Default WEP Key to Use", //wwl_DWKL
	"Wireless Device PIN", //KR44
	"Obscene", //_aa_bsecure_obscene
	"Invalid Server IP Address", //YM130
	"Select Dynamic DNS Server", //KR99
	"Primary WINS IP address must be specified if secondary is also specified.", //GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID
	"Enable at least one Source IP Range for '%s'", //GW_FIREWALL_NO_IP_RANGE_INVALID
	"Virtual server '%s' protocol number, %d, must be 0 or between 3 and 255.", //GW_NAT_VS_PROTOCOL_INVALID
	"Select this option if you want to setup your network manually", //KR52
	"Welcome to the Add Wireless Device Wizard", //KR33
	"You must be logged in as 'admin' to perform this action.", //ZM23
	"This wizard is designed to assist you in connecting your wireless device to your router. It will guide you through step-by-step instructions on how to get your wireless device connected. Click the button below to begin.", //LW40
	"Lock Wireless Security Settings", //LY4
	"If you consider yourself an advanced user and have configured a router before, click <strong>Manual Internet Connection Setup</strong> to input all the settings manually.", //LW34
	"Are you sure you want to delete", //YM25
	"Invalid Destination IP Start address for Port Filter", //YM15
	"Super&nbsp;G&trade;&nbsp;Mode", //bwl_SGM
	"Radius server address is not valid.", //GW_WLAN_80211X_RADIUS_INVALID
	"'%s': Protocol, %u, needs to be between 0 and 257", //GW_WISH_RULES_PROTOCOL
	"Login", //LS316
	"User has logged out", //ZM15
	"<warn>A DHCP Reservation has been disabled because it conflicts with the routers own LAN IP.</warn>", //GW_DHCP_SERVER_RESERVATION_DISABLED_IN_CONFLICT_WARNING
	"host must be specified", //GW_DYNDNS_HOST_NAME_INVALID
	"Manual Wireless Network Setup", //LW42
	"Invalid PPTP gateway IP address: %v", //GW_WAN_PPTP_GATEWAY_IP_ADDRESS_INVALID
	"The restored configuration file has been uploaded successfully.", //rs_intro_4
	"'%s': Remote IP end '%v' is in the LAN subnet", //GW_QOS_RULES_REMOTE_IP_END_SUBNET
	"N/A", //_NA
	"The gateway IP address is the IP address of the router, if any, used to reach the specified destination.", //hhav_r_gateway
	"[INFO]", //INFO
	"Metric:", //help112
	"Some firmware upgrades reset the configuration options to the factory defaults. Before performing an upgrade, be sure to save the current configuration from the <a href=\"tools_system.asp\" onclick=\"return jump_if();\"> Tools &rarr; System</a> screen.", //tf_msg_FWUgReset
	"Learn NetBIOS information from WAN", //bd_NETBIOS_WAN
	"Force Short Slot for 11N Clients", //aw_igslot
	"(default if not matched by anything else)", //ZM2
	"You do not have permission to perform the specified action.", //LT7
	"Set Selected Registrar", //WIFISC_AP_SET_SELECTED_REGISTRAR
	"When the necessary preparations are complete, the WCN technology will propagate the wireless network settings from your PC to the router. Then you will have to reboot the router for the settings to take effect.", //help214
	"Both", //at_Both
	"Day of Week", //ZM22
	"Restore To Factory Default Settings", //help_ts_rfd
	"If you would like to configure the wireless settings of your new D-Link Systems Router manually, then click on the Manual Wireless Network Setup button below.", //LW44
	"If your PC's operating system is Windows XP Service Pack 2 (SP2) or later and you are using Windows Internet Explorer (IE) as your browser, you can use Windows Connect Now (WCN) technology to help configure the router's wireless security settings.", //help209
	"destination starting port should be between 0 and 65535 inclusive.", //YM70
	"UPnP changed VS entry %v <-> %v:%d <-> %v:%d %s to %s", //GW_UPNP_IGD_PORTMAP_VS_CHANGE
	"The Web Filter section is one of two means by which you can specify the web sites you want to allow. You also have the alternative of using the Sentinel Parental Controls Service, which allows you to specify broad categories of web sites and saves you the trouble of entering specific web site URLs. For more information about the Sentinel service, refer to <a href=\"../Tools/Sentinel.shtml\">Tools &rarr; Sentinel</a>.", //help143s
	"This mode is not backwards compatible with non-Turbo (legacy) devices. This mode should only be enabled when all devices on the wireless network are Static Turbo enabled.", //help363
	"Web Newsgroup", //_aa_bsecure_web_newsgroup
	"Invalid Primary DNS Address", //YM128
	"%s of '%s' can not be empty.", //GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID
	"StreamEngine&trade; technology is applied to media streams that are passed between the WAN side of the upstream router and clients of the bridge.", //KR72
	"passwords do not match, please re-enter", //YM177
	"Host 1 IP Range", //YM82
	"Invalid Authentication Timeout.", //YM119
	"The bridge still has the ability to analyze traffic on the WAN side of the upstream router so as to determine the speed of its WAN connection.", //KR70
	"The IP address and, where appropriate, port number of the computer to which a network connection has been made.", //YM161
	"DHCP server pool size is too big (must be no more than 256 addresses).", //GW_DHCP_SERVER_POOL_SIZE_INVALID
	"Established", //_sdi_s4b
	"DNS Lookup Authentication Server", //ZM8
	"Invalid Secondary DNS Address", //YM129
	"64-bit ASCII keys are up to 5 characters in length (DMODE is a valid string of 5 characters for 64-bit encryption.)", //help370
	"Locking the wireless security settings prevents the settings from being changed by any new external registrar using its PIN. Devices can still be added to the wireless network using Wi-Fi Protected Setup. It is still possible to change wireless network settings with <a href=\"wireless.asp\" shape=\"rect\">Manual Wireless Network Setup</a>, <a href=\"wizard_wlan.asp\" shape=\"rect\">Wireless Network Setup Wizard</a>, or an existing external WLAN Manager Registrar.", //LY29
	"Warning while writing configuration file: %s", //GW_XML_CONFIG_WRITE_WARN
	"Name '%s' is already used", //GW_FIREWALL_NAME_INVALID
	"'%s': Host 2 IP start, %v, must be less than host 2 IP end, %v", //GW_WISH_RULES_HOST2_IP
	"Product Page", //TA2
	"Connect", //LS314
	"Traffic Type", //_vs_traffictype
	"The timeout value cannot be greater than 8760.", //GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID
	"Please enter the PIN of your wireless device, then click on the Connect button below.", //KR43
	"Select this option if your wireless device supports Wi-Fi Protected Setup", //KR51
	"PPTP Gateway IP address %v must be within the WAN subnet.", //GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID
	"Click the <span class=\"button_ref\">Save to Windows Connect Now</span> button, and the WCN technology will capture the wireless network settings from your router and save them on your PC.", //help837
	"Please Select Configuration Method to set up your Wireless Network", //KR49
	"Open", //_open
	"News", //_aa_bsecure_news
	"Update", //YM34
	"Advanced Wireless", //_advwls
	"<warn>DHCP Reservation %v has been disabled because the DHCP pool is too small.</warn>", //GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING
	"MAC Filter settings will lockout all machines. This is not allowed.", //GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID
	"WEP Key 4", //_wepkey4
	"optional", //YM98
	"Search Engine", //_aa_bsecure_search_engine
	"WPA Only\"", //KR47
	"If you choose the WEP security option this device will <strong>ONLY</strong> operate in <strong>Legacy Wireless mode (802.11B/G)</strong>. This means you will <strong>NOT</strong> get 11N performance due to the fact that WEP is not supported by Draft 11N specification.", //bws_msg_WEP_3
	"<warn>Email server address conflicts with router LAN address - email will be disabled.</warn>", //GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING
	"LAN IP mode is invalid", //GW_LAN_IP_MODE_INVALID
	"The specified Big Pond server is not a proper domain name or IP address.", //GW_WAN_BIGPOND_SERVER_NOTSTD15
	"Once your router is configured the way you want it, you can save the configuration settings to a configuration file.", //ZM18
	"Fragmentation threshold should be between 256 and 2346.", //GW_WLAN_FRAGMENT_THRESHOLD_INVALID
	"Domain name given is invalid", //GW_LAN_DOMAIN_NAME_INVALID
	"Device name given is invalid", //GW_LAN_DEVICE_NAME_INVALID
	"Session Overlap Detected", //_wifisc_overlap
	"The wizard will either display the wireless network settings to guide you through manual configuration, prompt you to enter the PIN for the device, or ask you to press the configuration button on the device. If the device supports Wi-Fi Protected Setup and has a configuration button, you can add it to the network by pressing the configuration button on the device and then the on the router within 60 seconds. The status LED on the router will flash three times if the device has been successfully added to the network.", //LW62
	"Process stopped. You may click on the Cancel button below to return to the beginning of the wizard page and restart the process", //KR23
	"Pornography", //_aa_bsecure_pornography
	"Name can not be empty string.", //GW_NAT_NAME_INVALID
	"Number of Spatial Streams", //bwl_NSS
	"Invalid PPTP server IP address", //YM108
	"Destination IP End address should not be in LAN subnet", //YM19
	"STA with MAC (%m) registered in", //WIFISC_AP_PROXY_PROCESS_COMPLETE
	"Record '%s' is duplicate of '%s'.", //GW_NAT_ENTRY_DUPLICATED_INVALID
	"'%s' [%s:%s] conflicts with '%s'[%s:%s] on different IP Addresses.", //GW_NAT_PORT_FORWARD_CONFLICT_INVALID
	"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new D-Link Systems Router to the Internet, click on the button below.", //LW27
	"Are you sure you want to update", //YM38
	"NTP Server is not configured.", //YM185
	"Wi-Fi Protected Setup", //LY2
	"PIN(2nd half) Mismatch Detected", //KR30
	"Session Over", //KR31
	"Init failed", //_init_fail
	"source starting port should be between 0 and 65535 inclusive.", //YM68
	"MAC Address", //sd_macaddr
	"WAN Port Mode", //KR12
	"A method of encrypting data for wireless communication intended to provide the same level of privacy as a wired network. WEP is not as secure as WPA encryption. To gain access to a WEP network, you must know the key. The key is a string of characters that you create. When using WEP, you must determine the level of encryption. The type of encryption determines the key length. 128-bit encryption requires a longer key than 64-bit encryption. Keys are defined by entering in a string in HEX (hexadecimal - using characters 0-9, A-F) or ASCII (American Standard Code for Information Interchange - alphanumeric characters) format. ASCII format is provided so you can enter a string that is easier to remember. The ASCII string is converted to HEX for use over the network. Four keys can be defined so that you can change keys easily. A default key is selected for use on the network.", //help366
	"AP registered to Registrar (%s) through %s", //WIFISC_AP_REGISTRATION_COMPLETE
	"TPC Max Gain", //aw_TPC
	"WDS AP MAC Address", //aw_WDSMAC
	"Remote end port should be between 0 and 65535 inclusive.", //YM62
	"Extra protection for neighboring 11b wireless networks. Turn this option off to reduce the adverse effect of legacy wireless networks on 802.11ng performance.", //aw_erpe_h
	"Invalid reconnect mode", //GW_WAN_RECONNECT_MODE_INVALID
	"DelAPSettings by (%s) complete", //WIFISC_AP_DEL_APSETTINGS_COMPLETE
	"Only Administrator can clear the statistics. The Clear Statistics button is disabled as you are not currently logged in as Administrator.", //ss_intro_user
	"If you are new to networking and have never configured a router before, click on <strong>Internet Connection Setup Wizard</strong> and the router will guide you through a few simple steps to get your network up and running.", //LW33
	"Succeeded. To add another device click on the Cancel button below or click on the Wireless Status button to check wireless status.", //KR27
	"Controls endpoint filtering for packets of the UDP protocol.", //YM138
	"'%s' [%s:%d]->%v/%d conflicts with '%s' [%s:%d]->%v:%d.", //GW_NAT_VS_PORT_CONFLICT_INVALID
	"Primary WINS Server IP address", //bd_NETBIOS_WINS_1
	"Step 5: Sentinel Categories", //_aa_wiz_s6_title
	"WISH Rules", //YM77
	"QoS Engine", //YM48
	"Invalid Reservation IP Address", //YM89
	"Pre-Shared Key should be all HEX chars if length is 64.", //GW_WLAN_WPA_PSK_HEX_STRING_INVALID
	"Invalid WAN IP address: %v", //GW_WAN_WAN_IP_ADDRESS_INVALID
	"Do you want to abandon all changes you made to this page?", //LS4
	"The specified Dynamic DNS Service Provider is not supported.", //KR98
	"Background (least urgent).", //YM148
	"Auto (WPA or WPA2)", //bws_WPAM_2
	"If you would like to be notified when new firmware is released, place a checkmark in the box next to <span class=\"option\">Email Notification of Newer Firmware Version</span>.", //help877a
	"Add/Update", //KR56
	"Hostname", //LS424
	"The DHCP server address %v was declined by the network device - check your network for IP Address conflicts.", //GW_DHCPSERVER_DECLINED
	"No day is selected", //GW_SCHEDULES_DAY_INVALID
	"UDP", //GW_NAT_UDP
	"Unable to create connection to email server", //IPSMTPCLIENT_CANNOT_CREATE_CONNECTION
	"Check All", //_aa_check_all
	"Do you want to abandon changes you made to the reservation entry?", //YM94
	"Renew", //LS312
	"Invalid IP address", //KR2
	"Protocol", //_vs_proto
	"The given TO address (%s) is invalid", //GW_SMTP_TO_ADDRESS_INVALID
	"AP failed to registere to Registrar (%s) through %s, reason (%s), err code (%u)", //WIFISC_AP_REGISTRATION_FAIL
	"Name '%s' is already used.", //GW_WISH_RULES_NAME_ALREADY_USED
	"When a LAN application that uses a protocol other than UDP, TCP, or ICMP initiates a session to the Internet, the router's NAT can track such a session, even though it does not recognize the protocol. This feature is useful because it enables certain applications (most importantly a single VPN connection to a remote host) without the need for an ALG.", //LW48
	"Invalid remote start IP Address.", //YM54
	"Current PIN", //LW9
	"This wizard is designed to assist you in your wireless network setup. It will guide you through step-by-step instructions on how to set up your wireless network and how to make it secure.", //LW41
	"Enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //YM124
	"RTS threshold should be between 0 and 2347.", //GW_WLAN_RTS_THRESHOLD_INVALID
	"A L2TP password MUST be specified", //GW_WAN_L2TP_PASSWORD_INVALID
	"Some configuration changes have an effect upon other system settings. Those changes may impact in a negative way, raising warnings that need to be communicated to you. A warning may indicate a feature has been modified, or even disabled, to match the new operating conditions.", //YM12
	"User is logging out", //ZM14
	"In this case the term \"port\" refers to the Ethernet connectors on the device.", //KR60
	"Invalid RTS Threshold", //YM28
	"The schedule is not valid.", //YM184
	"If you would like to utilize our easy to use Web-based Wizards to assist you in configuring the Microsoft's Windows Connect Now technology, click on the Setup Wizard button below.", //int_intro_WCNWz7
	"Shared Key", //bws_Auth_2
	"The restored configuration file is not correct. You may have restored a file that is not intended for this device, or the restored file may be corrupted.", //rs_intro_1
	"The protocol used by the messages.", //help92
	"Both", //GW_NAT_BOTH
	"Restore Success", //rs_success
	"(GMT+01:00) Budapest, Vienna, Prague, Warsaw", //up_tz_29b
	"Day", //day
	"<warn>DHCP Server is being disabled because the LAN subnet is not suitable</warn>", //GW_DHCP_SERVER_DISABLED_WARNING
	"Password and Verify Password do not match. Please reconfirm admin password.", //YM173
	"Invalid MAC address %m.", //GW_INET_ACCESS_POLICY_MAC_INVALID
	"Wi-Fi Protected Setup", //LW2
	"Assign any unused IP address in the range of IP addresses available for the LAN.", //KR75
	"Failed to write configuration file: %s", //GW_XML_CONFIG_WRITE_FAILED
	"Enable:", //help102
	"Name '%s' is already used.", //GW_WISH_RULES_NAME_USED_INVALID
	"The DHCP server pool size is too big to fit in LAN subnet %v.", //GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID
	"Aggregation Max Size", //aw_AS
	"This is a list of all active conversations involving wireless clients in the local network.", //YM171
	"Reserved IP %v conflicts with configured LAN IP Address", //GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID
	"Virtual server '%s' can not use the router's HTTP WAN administration port, %u", //GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
	"The netmask field identifies the portion of the destination IP in use.", //hhav_r_netmask
	"VIRTUAL SERVERS LIST", //vs_vslist
	"IPv6 FIREWALL RULES", //if_iflist
	"Note that some of these options can interact with other port restrictions. Endpoint Independent Filtering takes priority over inbound filters or schedules, so it is possible for an incoming session request related to an outgoing session to enter through a port in spite of an active inbound filter on that port. However, packets will be rejected as expected when sent to blocked ports (whether blocked by schedule or by inbound filter) for which there are no active sessions. Port and Address Restricted Filtering ensures that inbound filters and schedules work precisely, but prevents some level of connectivity, and therefore might require the use of port triggers, virtual servers, or port forwarding to open the ports needed by the application. Address Restricted Filtering gives a compromise position, which avoids problems when communicating with certain other types of NAT router (symmetric NATs in particular) but leaves inbound filters and scheduled access working as expected.", //YM137
	"Priority Classifiers", //YM74
	"Syslog server IP address %v is not in the lan subnet.", //GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID
	"Enable this option if you want to allow WISH to prioritize wireless traffic.", //YM86
	"MAC address is already used: %s", //GW_MAC_FILTER_MAC_UNIQUENESS_INVALID
	"Push Button", //KR40
	"MAC address filter can't be NULL address: %m", //GW_MAC_FILTER_NULL_MAC_INVALID
	"32 Kbytes", //aw_32
	"WAN subnet conflicts with LAN subnet", //GW_WAN_LAN_SUBNET_CONFLICT_INVALID
	"Enabled/Not Configured", //LW67
	"DelAPSettings by (%s) failed, reason (%s), err_code (%u)", //WIFISC_AP_DEL_APSETTINGS_FAIL
	"(13 characters or 26 hex digits)", //wwl_wsp_chars_1
	"WINS Servers store information regarding network hosts, allowing hosts to 'register' themselves as well as discover other available hosts, e.g. for use in Network Neighbourhood.", //KR85
	"Invalid MTU Size", //YM115
	"Host 1 Port Range", //YM83
	"128 bits", //wwl_128bits
	"When an excessive number of wireless packet collisions are occurring, wireless performance can be improved by using the RTS/CTS (Request to Send/Clear to Send) handshake protocol.", //LW51
	"You must enter a numeric value between 0 and 8760 inclusive.", //YM178
	"Cults", //_aa_bsecure_cults
	"Forbidden", //YM5
	"Firmware update checks", //KR65
	"Firmware updates are released periodically to improve the functionality of your router and to add features. If you run into a problem with a specific feature of the router, check if updated firmware is available for your router.", //ZM17
	"<strong>Enable</strong> if other wireless devices you wish to include in the local network support Wi-Fi Protected Setup.", //LW14
	"Save to Windows Connect Now", //ta_wcn_bv
	"Virtual server '%s' can not use the router's IP address, %v.", //GW_NAT_VS_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
	"Schedule '%s' can't be deleted or renamed because it is used.", //GW_SCHEDULES_IN_USE_INVALID
	"WEP Key 3", //wepkey3
	"Internet rate estimation", //KR69
	"AIM Talk", //YM43
	"ICQ", //YM45
	"User name is invalid", //GW_SMTP_USERNAME_INVALID
	"Super G with Static Turbo", //help362
	"If you would like to be notified when new firmware is released, place a checkmark in the box next to Email Notification of Newer Firmware Version.", //tf_intro_FWChA
	"REMOTE DESKTOP", //_remotedesktop
	"PIN(1st half) Mismatch Detected", //KR29
	"Super G Turbo Modes must use channel 6 for communication. For Super G with Static Turbo, <span class=\"option\">802.11 Mode</span> must be set to 802.11g. For proper operation, RTS threshold and Fragmentation Threshold on the <a href=\"adv_wlan_perform.asp\">Advanced &rarr; Advanced Wireless</a> screen should both be set to their default values.", //help359
	"Configure the IP address of the preferred WINS server.", //KR84
	"DTIM should be between 1 and 255.", //YM30
	"Local Port Range", //at_LoPortR
	"DHCP server pool FROM %v is not in LAN subnet %v.", //GW_DHCP_SERVER_POOL_FROM_IN_SUBNET_INVALID
	"MAC address filter can't be multicast address format: %m", //GW_MAC_FILTER_MULTICAST_MAC_INVALID
	"<warn>Initialisation of email failed</warn>", //GW_SMTP_INIT_FAILED_WARNING
	"DHCP server stopped", //GW_DHCPSERVER_STOP
	"To protect your privacy, use the wireless security mode to configure the wireless security features. This device supports three wireless security modes including: WEP, WPA-Personal, and WPA-Enterprise. WEP is the original wireless encryption standard. WPA provides a higher level of security. WPA-Personal does not require an authentication server. The WPA-Enterprise option does require a RADIUS authentication server.", //help350
	"DMZ address %v is not allowed.", //GW_NAT_DMZ_NOT_ALLOWED_INVALID
	"When enabled, this option causes the router to automatically attempt to prioritize traffic streams that it doesn't otherwise recognize, based on the behaviour that the streams exhibit. This acts to deprioritize streams that exhibit bulk transfer characteristics, such as file transfers, while leaving interactive traffic, such as gaming or VoIP, running at a normal priority.", //YM143
	"Failed to import configuration file #%u", //GW_XML_CONFIG_SET_FAILED
	"%s '%s' of '%s' should not contain duplicated numbers.", //GW_NAT_PORT_DUP_INVALID
	"seconds for your wireless device to be connected. If you want to stop the process, click on the Cancel button below.", //KR46
	"Step 1: Select Configuration Method for your Wireless Network", //KR35
	"A Big Pond password MUST be specified", //GW_WAN_BIGPOND_PASSWORD_INVALID
	"Protocol must be specified.", //YM57
	"The router must be rebooted before the new settings will take effect. You can reboot now, or you can continue to make other changes and reboot later.", //KR104
	"sender email address is in wrong format", //IPSMTPCLIENT_MSG_WRONG_SENDER_ADDR_FORMAT
	"Logout", //LS317
	"The entered passwords do not match", //YM102
	"When WDS is enabled, this access point functions as a wireless repeater and is able to wirelessly communicate with other APs via WDS links. Note that WDS is incompatible with WPA -- both features cannot be used at the same time. A WDS link is bidirectional; so this AP must know the MAC Address (creates the WDS link) of the other AP, and the other AP must have a WDS link back to this AP.", //help188
	"IP address is not valid", //_logsyslog_alert1
	"Invalid MAC address", //KR3
	"Hate", //_aa_bsecure_hate
	"Can not use 802.11a channel when the 802.11 mode is 802.11b/g.", //GW_WLAN_11BG_CHANNEL_INVALID
	"Rate estimation completed", //RATE_ESTIMATOR_RATE_COMPLETED
	"WEP key must be exactly 26 hexadecimal digits (0-9 or A-F).", //wwl_alert_pv5_3
	"Aggregation Limit", //aw_aggr
	"Started", //_wifisc_addstart
	"Specifies the interface -- LAN or WAN -- that the IP packet must use to transit out of the router, when this route is used.", //help111
	"'%s': Remote IP start '%v' is in the LAN subnet", //GW_QOS_RULES_REMOTE_IP_START_SUBNET
	"Invalid Destination Port End for Port Filter", //YM22
	"Can not use a multicast MAC address in WDS.", //GW_WLAN_WDS_MAC_ADDR_INVALID
	"Reset PIN to Default", //LW10
	"This area of the screen reflects configuration settings from the <a href=\"wireless.asp\">Setup &rarr; Wireless Settings</a> page. The <span class=\"option\">MAC Address</span> is the factory-assigned identifier of the wireless card.", //LT291
	"This section is where you define WISH Rules.", //YM156
	"Adolescent (9-12)", //_aa_bsecure_age_ado
	"Select this option if your wireless adapters DO NOT SUPPORT WPA", //wwl_text_good
	"'%s': Priority, %d, needs to be between 1 and 255", //GW_QOS_RULES_PRIORITY_RANGE
	"Once a LAN-side application has created a connection through a specific port, the NAT will forward any incoming connection requests with the same port to the LAN-side application regardless of their origin. This is the least restrictive option, giving the best connectivity and allowing some applications (P2P applications in particular) to behave almost as if they are directly connected to the Internet.", //YM134
	"Web Mail", //_aa_bsecure_web_mail
	"Make sure the APs are configured with same channel number.", //help188b
	"Start IP address(%v) of '%s' should not be within LAN subnet(%v).", //GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID
	"WAN Traffic Shaping", //at_title_Traff
	"Specifies one-half of the WDS link. The other AP must also have the MAC address of this AP to create the WDS link back to this AP.", //help189
	"Wireless radar detected, switch to channel %d", //GW_WIRELESS_SWITCH_CHANNEL
	"A Big Pond server MUST be specified", //GW_WAN_BIGPOND_SERVER_INVALID
	"Configuration file parse error around line %u char %u", //GW_XML_CONFIG_SET_PARSE
	"Enabling Hidden Mode is another way to secure your network. With this option enabled, no wireless clients will be able to see your wireless network when they scan to see what's available. For your wireless devices to connect to your router, you will need to manually enter the Wireless Network Name on each device.", //YM125
	"This area of the screen reflects configuration settings from the <a href=\"wireless.asp\">Setup &rarr; Wireless Settings</a> page, the <a href=\"adv_wish.asp\">Advanced &rarr; WISH</a> page and the <a href=\"../Advanced/Protected_Setup.shtml\">Advanced &rarr; Wi-Fi Protected Setup</a> page. The <span class=\"option\">MAC Address</span> is the factory-assigned identifier of the wireless card.", //LT290wifisc
	"Rule name can not be empty string", //GW_FIREWALL_RULE_NAME_INVALID
	"Schedule", //GW_NAT_SCHEDULE
	"Specifies the next hop to be taken if this route is used. A gateway of 0.0.0.0 implies there is no next hop, and the IP address matched is directly connected to the router on the interface specified: LAN or WAN.", //help109
	"RIP mode is invalid.", //GW_LAN_RIP_MODE_INVALID
	"The wireless transmitter will begin to send RTS frames (and wait for CTS) when data frame size in bytes is greater than the RTS Threshold.", //LW52
	"Pop-ups", //_aa_bsecure_popups
	"WPA2 only mode doesn't support TKIP.", //GW_WLAN_WPA_WPA2_TKIP_INVALID
	"2.4GHz", //KR16
	"Virtual Server", //_vs_title
	"IPv6 Firewall", //_if_title
	"A PPPoE user name MUST be specified", //GW_WAN_PPPOE_USERNAME_INVALID
	"Invalid PPTP subnet mask %v", //GW_WAN_PPTP_SUBNET_INVALID
	"NetBIOS Scope is not in a valid form", //GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID
	"Static IP mode is always on, so no action buttons are avaliable.", //KR94
	"WISH", //YM63
	"Gateway:", //help108
	"This schedule is already used in '%s'", //GW_SCHEDULES_DUPLICATED_INVALID
	"WPA Only", //bws_WPAM_1
	"Public port should be in range (1..65535) for virtual server", //KR11
	"If you already have a wireless network setup with Wi-Fi Protected Setup, click on <strong>Add Wireless Device Wizard</strong> to add new device to your wireless network.", //LW45
	"Remote IP End", //KR6
	"Invalid NetBIOS registration type", //GW_DHCP_SERVER_NETBIOS_TYPE_INVALID
	"Games", //_aa_bsecure_games
	"Select this option if you want to configure your wireless device manually", //KR42
	"Invalid Idle Time", //YM104
	"Tickets", //_aa_bsecure_tickets
	"Select this option if your wireless device supports PIN", //KR39
	"Mixed-mode (Broadcast then Point-to-Point)", //bd_NETBIOS_REG_TYPE_M
	"Enter a MAC address for each of the other APs that you want to connect with WDS.", //help189a
	"UPnP deleted entry %v <-> %v:%d %s", //GW_UPNP_IGD_PORTMAP_DEL
	"Invalid L2TP gateway IP address", //YM111
	"Disconnect", //LS315
	"Incorrect key length, should be 8 to 63 characters long.", //GW_WLAN_WPA_PSK_LEN_INVALID
	"Personal", //LW24
	"Getting active session list. Please wait", //YM167
	"128-bit ASCII keys are up to 13 characters in length (2002HALOSWIN1 is a valid string of 13 characters for 128-bit encryption.)", //help371
	"Anarchy", //_aa_bsecure_anarchy
	"Reboot Later", //YM4
	"Criminal Skills", //_aa_bsecure_criminal_skills
	"Warnings have been raised as a result of configuration changes.\nThe system is unable to generate a list of those warnings right now, but will retry.", //YM188
	"The NAT Endpoint Filtering options control how the router's NAT manages incoming connection requests to ports that are already being used.", //YM133
	"Local start port should be between 0 and 65535 inclusive.", //YM59
	"Manually", //_aa_bsecure_manually
	"Email address is not configured.", //YM169
	"Use this section to configure the internal network settings of your router. The IP Address that is configured here is the IP Address that you use to access the Web-based management interface. If you change the IP Address here, you may need to adjust your PC's network settings to access the network again.", //YM97
	"Enable QoS Engine", //at_ESE
	"Child (0-8)", //_aa_bsecure_age_child
	"WPA is the older standard; select this option if the clients that will be used with the router only support the older standard. WPA2 is the newer implementation of the stronger IEEE 802.11i security standard. With the \"WPA2\" option, the router tries WPA2 first, but falls back to WPA if the client only supports WPA. With the \"WPA2 Only\" option, the router associates only with clients that also support WPA2 security.", //help375
	"This web site address '%s' is invalid.", //GW_WEB_FILTER_WEBSITE_INVALID_INVALID
	"Week", //ZM21
	"Internet Sessions", //YM157
	"The WCN ActiveX Control provides the WCN link between your PC and the router via the browser that communicates wireless configuration data without a USB flash drive. The browser will attempt to download the WCN ActiveX Control, if it is not already available on your PC. For this action to succeed, you must already have a WAN connection, and the browser's internet security setting must be Medium or lower (select Tools &rarr; Internet Options &rarr; Security &rarr; Custom Level &rarr; Medium).", //help213
	"Are you sure you want to enable/disable", //YM24
	"Peer configuration error %u", //WIFISC_AP_PEER_CFG_ERR
	"If your wireless network is already set up with Wi-Fi Protected Setup, manual confguration of the wireless network will destroy the existing wireless network.", //LW43
	"This section is where you define QoS Engine Rules.", //help99_s
	"Invalid Reservation MAC address", //YM90
	"TKIP and AES", //bws_CT_3
	"Note that, if you enter fewer characters in the WEP key than required, the remainder of the key is automatically padded with zeros.", //help371_n
	"<warn>A DHCP Reservation %v has been reconfigured to %v, please check this meets your network requirements.</warn>", //GW_DHCP_SERVER_RESERVATION_RECONFIG_WARNING
	"Invalid Gateway for route", //_r_alert3
	"RIP metric is invalid.", //GW_LAN_RIP_METRIC_INVALID
	"WPA Group Key Update Interval should be between 30 and 65535 seconds.", //YM118
	"Invalid Gateway Address", //YM127
	"StreamEngine", //KR71
	"WDS Enable", //aw_WDSEn
	"Receive Unknown Message", //KR32
	"Local", //sa_Local
	"Idle time cannot be zero.", //GW_WEB_SERVER_IDLE_TIME
	"This option controls how the device reacts to traffic on the WAN connector.", //KR59
	"WAN Gateway IP address %v must be within the WAN subnet.", //GW_WAN_WAN_GATEWAY_IN_SUBNET_INVALID
	"Local IP Range", //at_LoIPR
	"Voice (VO)", //YM81
	"Aggregation Num Packets", //aw_AP
	"This area of the screen reflects configuration settings from the <a href=\"wireless.asp\">Setup &rarr; Wireless Settings</a> page and the <a href=\"adv_wish.asp\">Advanced &rarr; WISH</a> page. The <span class=\"option\">MAC Address</span> is the factory-assigned identifier of the wireless card.", //LT290
	"The priority given to packets sent wirelessly over this conversation by the WISH logic. The priorities are:", //YM162
	"Configuration file parse error (MIME)", //GW_XML_CONFIG_SET_PARSE_MIME
	"UDP Port", //GW_NAT_UDP_PORT
	"Succeeded", //YM9
	"The MTU size is invalid (the permitted range is %u to %u)", //GW_WAN_MTU_INVALID
	"There are several ways to add a wireless device to your network. Access to the wireless network is controlled by a “registrar”. A registrar only allows devices onto the wireless network if you have entered the PIN, or pressed a special Wi-Fi Protected Setup button on the device. The router acts as a registrar for the network, although other devices may act as a registrar as well.", //LW63
	"Successfully added station %s (%m)", //WIFISC_IR_REGISTRATION_SUCCESS
	"The IP address of packets that will take this route.", //help105
	"The DHCP server address %v was released by the network device - the network device no longer wants to use it.", //GW_DHCPSERVER_RELEASED
	"Launch Printer Setup Wizard", //LW32
	"SetAPSettings by (%s) failed, reason (%s), err_code (%u)", //WIFISC_AP_SET_APSETTINGS_FAIL
	"Invalid IP address for route", //KR8
	"The name field allows you to specify a name for identification of this route, e.g. 'Network 2'", //hhav_r_name
	"Hybrid (Point-to-Point then Broadcast)", //bd_NETBIOS_REG_TYPE_H
	"While not a perfect mapping, the following loose correspondences between the \"cone\" classification and the \"endpoint filtering\" modes can be drawn: if this router is configured for endpoint independent filtering, it implements full cone behavior; address restricted filtering implements restricted cone behavior; and port and address restricted filtering implements port restricted cone behavior.", //KR55
	"PPPoE IP address %v conflicts with LAN subnet", //GW_WAN_PPPOE_LAN_SUBNET_CONFLICT_INVALID
	"Successfully imported configuration file", //GW_XML_CONFIG_SET_SUCCESS
	"Local end port should be between 0 and 65535 inclusive.", //YM60
	"Save Settings Failed", //KR100
	"Select this option if the WAN port is connected to the Internet. The device functions as a NAT router.", //KR61
	"64 bit (10 hex digits)", //bws_WKL_0
	"Use <strong>WPA or WPA2</strong> mode to achieve a balance of strong security and best compatibility. This mode uses WPA for legacy clients while maintaining higher security with stations that are WPA2 capable. Also the strongest cipher that the client supports will be used. For best security, use <strong>WPA2 Only</strong> mode. This mode uses AES(CCMP) cipher and legacy stations are not allowed access with WPA security. For maximum compatibility, use <strong>WPA Only</strong>. This mode uses TKIP cipher. Some gaming and legacy devices work only in this mode.", //bws_msg_WPA
	"Invalid L2TP IP address", //YM109
	"Reset by %s failed, reason (%s), err_code (%u)", //WIFISC_AP_RESET_FAIL
	"'%s': Host 2 port start, %u, must be less than host 2 port end, %u", //GW_WISH_RULES_HOST2_PORT
	"Load Settings From Local Hard Drive", //help_ts_ls
	"Invalid WAN gateway IP address", //YM101
	"Auto", //KR50
	"Protocol must be a number.", //YM56
	"Website URL/Domain", //aa_WebSite_Domain
	"Max transmission rate should be between 8 kbps and 100 Mbps, inclusive.", //GW_QOS_RULES_MAX_TRANS
	"'%s': Protocol, %d, needs to be between 0 and 257", //GW_QOS_RULES_PROTOCOL
	"You must have at least one of HTTP or HTTPS enabled.", //GW_WEB_SERVER_NO_ACCESS
	"Configure the IP address of the backup WINS server, if any.", //KR87
	"'%s' is duplicate of '%s'", //GW_WISH_RULES_DUPLICATED
	"Destination IP Start address should not be in LAN subnet", //YM16
	"Name '%s' is already used", //GW_SCHEDULES_NAME_CONFLICT_INVALID
	"WEP Key 4", //wepkey4
	"HTTP and HTTPS cannot occupy the same WAN port.", //GW_WEB_SERVER_SAME_PORT_WAN
	"invalid source ending IP Address.", //YM65
	"Network Settings", //bln_title
	"STA with MAC (%m) failed to register in, reason (%s), err_code (%u)", //WIFISC_AP_PROXY_PROCESS_FAIL
	"More", //_more
	"Send/Receive login", //ZM12
	"Banner Ad", //_aa_bsecure_banner_ad
	"Wireless Status", //LY23
	"For most applications, automatic classification will be adequate, and specific QoS Engine Rules will not be required.", //help88b
	"Selecting more than one spatial stream can increase throughput, but can in some cases decrease signal quality.", //bwl_NSS_h1
	"Note: Do not connect more than one USB flash drive to the router, not even with a USB hub.", //help203
	"There is no machine defined in policy %s.", //GW_INET_ACL_NO_MACHINE_IN_LAN_SUBNET_INVALID
	"Before launching these wizards, please make sure you have followed all steps outlined in the Quick Installation Guide included in the package.", //LW39c
	"Set Selected Registrar complete", //WIFISC_AP_SET_SELECTED_REGISTRAR_COMPLETE
	"Invalid DHCP Client name", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Failed to retrieve active session list. Retrying", //YM166
	"Reboot by %s fail, reason (%s), err_code (%u)", //WIFISC_AP_REBOOT_FAIL
	"The priority of the message flow is entered here -- 1 receives the highest priority (most urgent) and 255 receives the lowest priority (least urgent).", //help91
	"The following Web-based wizards are designed to assist you in your wireless network setup and wireless device connection.", //LW39
	"Password and Verify Password do not match. Please reconfirm user password.", //YM174
	"A Port Filter rule name cannot be blank.", //YM13
	"Your web browser is too old to use this web site. Please upgrade your browser.", //YM172
	"Invalid TPC Max Gain", //YM31
	"Select the Sentinel categories to filter.", //_aa_wiz_s6_msg
	"Password is invalid", //GW_SMTP_PASSWORD_INVALID
	"Host 2 Port Range", //YM85
	"The 'Name' field can not be blank", //GW_SCHEDULES_NAME_INVALID
	"Invalid Gateway", //LS204
	"16 Kbytes", //aw_16
	"(Refer to the <a href=\"wireless.asp\"> Setup &rarr; Wireless Settings &rarr; Manual Wireless Network Setup</a> page.)", //aw_erpe_h3
	"Start the wizard.", //LW64
	"Day(s)", //_days
	"Use this section to configure D-Link's QoS Engine powered by StreamEngine&trade; Technology. The QoS Engine improves your online gaming experience by ensuring that your game traffic is prioritized over other network traffic, such as FTP or Web.", //at_intro
	"Specifies whether the entry will be enabled or disabled.", //help103
	"-", //YM183
	"Invalid Group Key Update Interval.", //YM117
	"Formerly, the terms \"Full Cone\", \"Restricted Cone\", \"Port Restricted Cone\" and \"Symmetric\" were used to refer to different variations of NATs. These terms are purposely not used here, because they do not fully describe the behavior of this router's NAT.", //KR54
	"This Routing page allows you to specify custom routes that determine how data is moved around your network.", //av_intro_r
	"64-bit hexadecimal keys are exactly 10 characters in length. (12345678FA is a valid string of 10 characters for 64-bit encryption.)", //help368
	"Each route has a check box next to it, check this box if you want the route to be enabled.", //hhav_enable
	"DNS Servers must be configured.", //GW_WAN_DNS_SERVERS_INVALID
	"Restore Succeeded", //_rs_succeeded
	"A PPTP user name MUST be specified", //GW_WAN_PPTP_USERNAME_INVALID
	"Invalid L2TP IP address: %v", //GW_WAN_L2TP_IP_ADDRESS_INVALID
	"Name can not be empty string.", //GW_INET_ACL_NAME_INVALID
	"Days", //days
	"This is an advanced setting and is normally left blank. This allows the configuration of a NetBIOS 'domain' name under which network hosts operate.", //KR88
	"Invalid PPPoE IP address: %v", //GW_WAN_PPPOE_IP_ADDRESS_INVALID
	"For good security it should be of ample length and should not be a commonly known phrase.", //KR19
	"Rate estimation completed. Upstream speed is %u kbps", //RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
	"Invalid Beacon Period", //YM27
	"This area of the screen reflects configuration settings from the <a href=\"wireless.asp\">Setup &rarr; Wireless Settings</a> page and the <a href=\"../Advanced/Protected_Setup.shtml\">Advanced &rarr; Wi-Fi Protected Setup</a> page. The <span class=\"option\">MAC Address</span> is the factory-assigned identifier of the wireless card.", //LT291wifisc
	"Port Filter name", //KR1
	"Rule \'", //YM51
	"Send/Receive heartbeat", //ZM13
	"Primary DNS is invalid.", //GW_LAN_PRIMARY_DNS_INVALID
	"Can not use Turbo in 11a mode.", //GW_WLAN_11A_DFS_TURBO_INVALID
	"Changing your Wireless Network Name is the first step in securing your wireless network. Change it to a familiar name that does not contain any personal information.", //YM123
	"If you have devices on your network that should always have fixed IP addresses, add a <strong>DHCP Reservation </strong> for each such device.", //TA8
	"Invalid IP address for virtual server", //KR9
	"For example, 192.168.0.1.", //KR79
	"'%s': Remote IP start, '%v' ,must be less than remote IP end, '%v'", //GW_QOS_RULES_REMOTE_IP
	"Adult (18+)", //_aa_bsecure_age_adult
	"Uninitalized", //ZM7
	"Destination Port Start should not be greater than Destination Port End for Port Filter", //YM23
	"Note: Some firmware upgrades reset the router's configuration options to the factory defaults.\n Before performing an upgrade, be sure to save the current configuration from the Tools-System screen.\n Do you still want to upgrade?", //tf_USSW
	"Enable this option for better performance and experience with online games and other interactive applications, such as VoIP.", //help78
	"Enable WISH", //YM73
	"Expires", //LS425
	"Wep Key", //wwl_WK
	"Generate New PIN", //LW11
	"<warn>The PPTP ALG has been automatically enabled because a virtual server entry you created requires it.</warn>", //GW_NAT_PPTP_ALG_ACTIVATED_WARNING
	"Are you sure you want to delete", //YM35
	"Select Day(s)", //tsc_sel_days
	"The router must be rebooted before the restored settings will take effect. You can reboot now, or you can continue to make other changes and reboot later.", //sc_intro_rb4
	"Invalid Time for schedule name: '%s'", //GW_SCHEDULES_TIME_INVALID
	"Lease time is invalid (must be 1 to 65535)", //GW_DHCP_SERVER_LEASE_TIME_INVALID
	"Unable to send email since server IP address could not resolved", //IPSMTPCLIENT_NO_SERVER_IP_ADDRESS
	"Private port should be in range (1..65535) for virtual server", //KR10
	"https is not a supported protocol.", //GW_WEB_FILTER_HTTPS_NOT_SUPPORTED_INVALID
	"The Wireless Device PIN should be either 4 or 8 digits", //KR22
	"Both", //_vs_both
	"The Wireless Security Password must be at least 8 characters.", //wwl_alert_pv5_4
	"AP should not be locked before configuring.", //GW_WIFISC_LOCK_VERIFY_ERR
	"Wireless frames can be divided into smaller units (fragments) to improve performance in the presence of RF interference and at the limits of RF coverage.", //LW53
	"The web site address '%s' already used.", //GW_WEB_FILTER_WEB_SITE_IS_USED_INVALID
	"invalid source starting IP Address.", //YM64
	"Route interface is invalid", //GW_ROUTES_INTERFACE_INVALID
	"Secondary DNS is invalid.", //GW_LAN_SECONDARY_DNS_INVALID
	"Learn NetBIOS from WAN", //bd_NETBIOS_LEARN_FROM_WAN_ENABLE
	"<warn>Port Forwarding Table is being reconfigured because the LAN subnet has been changed.</warn>", //GW_NAT_PORT_FORWARDING_TABLE_RECONFIGURED_WARNING
	"802.11 Band", //KR15
	"AP failed to registere to Registrar (%s) through %s, unexpected (%s), at state (%s)", //WIFISC_AP_REGISTRATION_UNEXPECTED_EVENT
	"<warn>Syslog server IP address is no longer in the LAN subnet, this may need to be reconfigured.</warn>", //GW_SYSLOG_ADDRESS_NOT_IN_SUBNET_WARNING
	"Invalid secondary WINS IP address", //GW_DHCP_SERVER_NETBIOS_SECONDARY_WINS_INVALID
	"Note that this feature does not apply to the DMZ host (if one is enabled). The DMZ host always handles these kinds of sessions.", //LW49
	"Add/Update Schedule Rule", //KR95
	"8 Kbytes", //aw_8
	"Invalid secondary DNS server IP address", //YM114
	"Cipher Type", //bws_CT
	"R-rated", //_aa_bsecure_rrated
	"Lock Wireless Security Settings", //LW6
	"You may also enter any text string into a WEP key box, in which case it will be converted into a hexadecimal key using the ASCII values of the characters. A maximum of 5 text characters can be entered for 64 bit keys, and a maximum of 13 characters for 128 bit keys.", //bws_msg_WEP_2
	"'%s': Local IP start, '%v', must be less than local IP end, '%v'", //GW_QOS_RULES_LOCAL_IP
	"Pool IP address FROM must not be bigger than TO.", //GW_DHCP_SERVER_POOL_FROM_TO_ORIENTATION_INVALID
	"TKIP", //bws_CT_1
	"Configuration database lock failed #%u", //GW_XML_CONFIG_SET_LOCK
	"Reserved IP %v conflicts with another reservation", //GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID
	"WEP Key 2", //wepkey2
	"Manual Internet Connection Options", //LW28
	"WEP Key 1", //_wepkey1
	"Turn this setting off to configure manually.", //KR83
	"Syslog server IP address is invalid.", //GW_SYSLOG_ADDRESS_INVALID
	"Invalid PPTP IP address", //YM105
	"DHCP Client", //ZM5
	"WCN ActiveX Control", //help212
	"Please push button on your wireless device, then click on the Connect button below.", //KR45
	"To specify any other protocol, select \"Other\" from the list, then enter the corresponding protocol number (<a href=\"http://www.iana.org/assignments/protocol-numbers\" target=\"_blank\"> as assigned by the IANA</a>) in the <span class=\"option\">Protocol</span> box.", //help19x2
	"Step 2: Connect your Wireless Device", //KR36
	"Route metric %u is invalid, must be from 1 to 16", //GW_ROUTES_METRIC_INVALID
	"The SSID field can not be blank.", //GW_WLAN_SSID_INVALID
	"Invalid IP Address", //LS46
	"The timeout value cannot be less than or equal to zero.", //YM179
	"The IP address of the router on the local area network.", //KR78
	"The bridge checks the support site for updates by way of the upstream router.", //KR66
	"Magazine", //_aa_bsecure_magazine
	"The device may be too busy to properly receive it right now. Please try to save the settings again.", //KR101
	"WPA only mode doesn't support AES.", //GW_WLAN_WPA_WPA_AES_INVALID
	"Inbound Filter", //GW_NAT_INBOUND_FILTER
	"The Policy Name cannot be blank.", //GW_INET_ACL_POLICY_NAME_INVALID
	"Internet", //sa_Internet
	"Per regulatory request, channel 52 - 140 can not be used without enable radar detection.", //GW_WLAN_11A_DFS_CHANNEL_INVALID
	"The rule applies to a flow of messages for which host 1's port number is within the range set here.", //YM153
	"Remote IP Range", //at_ReIPR
	"Only \"Admin\" account can change security settings.", //LW15
	"DTIM should be between 1 and 255.", //GW_WLAN_DTIM_INVALID
	"A WISH Rule identifies a specific message flow and assigns a priority to that flow.", //YM144
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm", //up_tz_26
	"Select a filter that controls access as needed for this rule. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help71
	"HNAP AddPortMapping modified %dth virtual server entry from '%s' %v:%d<->%v:%d %S to '%s' %v:%d<->%v:%d %S", //GW_PURE_ADDPORTMAPPING_MODIFY
	"User stopped", //tsc_pingt_msg10
	"The printer's IP address and TCP port number are shown <a href=\"../Status/PS.shtml\" onclick=\"return jump_if();\">here</a>.", //tps_foo
	"HNAP AddPortMapping modified %dth virtual server entry from '%s' %v:%d<->%v:%d %S to %S", //GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL
	"Above message repeated %d times", //LOG_PREV_MSG_REPEATED_N_TIMES
	"The <strong>user</strong> account may not perform the requested action.", //ca_intro
	"The addressing of the Internet side learnt thru DHCP conflicts with the addressing selected for the LAN side. Internet communications will be disabled until you have changed the LAN side addressing to resolve the problem.", //GW_WAN_LAN_ADDRESS_CONFLICT_DHCP
	"The section lists the current Inbound Filter Rules. An Inbound Filter Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the \"Update Inbound Filter Rule\" section is activated for editing.", //help176
	"HNAP AddPortMapping created %dth virtual server entry '%s' %v:%d<->%v:%d %S", //GW_PURE_ADDPORTMAPPING_CREATE
	"Select a schedule for when the rule will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools → Schedules</a> screen and create a new schedule.", //hhag_30
	"Click the <strong>Add</strong> or <strong>Update</strong> button to store a finished rule in the Rules List below.", //hhai_save
	"Administrator", //ADMIN
	"The following printer has been detected. Click <em>Next</em> to install the printer onto your computer.", //wprn_s1a
	"Email notification is not enabled.", //sl_alert_3
	"After configuring the router for dynamic DNS, you can open a browser and navigate to the URL for your domain (for example <code>http://www.mydomain.info</code>) and the router will attempt to forward the request to port 80 on your LAN. If, however, you do this from a LAN-side computer and there is no virtual server defined for port 80, the router will return the router's configuration home page. Refer to the <a href=\"adv_virtual.asp\">Advanced &rarr; Virtual&nbsp;Server</a> configuration page to set up a a virtual server.", //help900
	"The printer's IP address and queue name are shown <a href=\"../Status/PS.shtml\" onclick=\"return jump_if();\">here</a>.", //tps_foo2
	"This setting should remain at its default value of 2346 bytes.", //help182
	"IP address should be in LAN subnet.", //aa_alert_12
	"To check for the latest firmware, click the [Check Online Now...] button.", //tf_intro_FWCh
	"Save To Local Hard Drive", //ts_ss
	"Set Username and Password Connection (PPTP)", //wwa_title_set_pptp
	"(e.g.: me.mydomain.net)", //_hostname_eg
	"Note: You will need to enter the same password as keys in this step into your wireless clients in order to enable proper wireless communication.", //wwl_s4_note
	"Select a filter that controls access as needed for this virtual server. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help22
	"The Wireless Security Password must be 13 alphanumeric characters or 26 hex digits. You entered", //wwl_alert_pv5_1
	"HNAP SetWLanSettings24 set Enabled %s, SSIDBroadcast %s, Channel %d", //GW_PURE_SETWLANSETTINGS24
	"Specify the LAN IP address of the LAN computer that you want to have unrestricted Internet communication. If this computer obtains its address Automatically using DHCP, then you may want to make a static reservation on the <a href=\"adv_network.asp\">Setup &rarr; Network&nbsp;Settings</a> page so that the IP address of the DMZ computer does not change.", //help167
	"Detected xDSL or Other Frame Relay Network", //at_DxDSL
	"The Printer Setup Wizard supports only Windows XP/2000/98/ME operating systems. Your computer uses the <span id=\"wz_page_1_err_1_os\">&nbsp;</span> operating system.", //wprn_bados2
	"The setup executable you have just launched will display a progress bar and notify you when setup is complete. When done, click <em>Finish</em> below to close the Printer Setup wizard.", //wprn_s3a
	"If the setup executable did not launch automatically after downloading to your computer, you may need to open the file-download folder using a file browser and double-click on the icon labeled <em>Printer_Setup.exe.</em>", //wprn_tt10
	"WAN Ping <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Inbound Filter</a>", //bwn_IF
	"Note, however, if the AP's settings specify \"DHCP (Dynamic)\" Address, and the router's DHCP server assigns a domain name to the AP, that domain name will override any name you enter here.", //_1044a
	"Attempt to fix the problem with the printer, then click <em>Refresh</em> to update printer status.", //wprn_tt6
	"Select a schedule for the times when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help72
	"Unknown", //_sdi_s6
	"Select a schedule for when the service will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools → Schedules</a> screen and create a new schedule.", //hhpt_sch
	"Enable raw TCP port printing from the <em>Print Server </em> page under the <em>Tools</em> submenu.", //wprn_tt2
	"This log will be sent to email address", //sl_alert_2
	"Auto 10/100/1000Mbps", //anet_wp_2
	"Restore all settings to the factory defaults.", //tss_RestAll
	"HNAP SetDeviceSettings set wan mode to %S, %v/%v/%v", //GW_PURE_SETWANSETTINGS
	"Select a schedule for when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help53
	"Saves the new or edited Inbound Filter Rule in the following list.", //help175
	"If you selected the On Schedule option, select one of the defined schedule rules. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\">Tools &rarr; Schedules</a> screen and create a new schedule.", //help872
	"The transmission standard being used by the client. Values are 11a, 11b, 11g, or 11n for 802.11a, 802.11b, 802.11g, or 802.11n respectively.", //help785
	"After clicking <em>Next</em>, you will be asked for permission to download an executable file. Please click <em>Run/Open</em> to allow the executable to run on your computer. If a second window appears prompting you to verify the publisher, please click <em>Run</em> again.", //wprn_s2b
	"The wizard will guide you through the following steps. Click <em>Next</em> to begin.", //wprn_intro2
	"Please select a filter.", //aa_alert_13
	"When this option is enabled, an email will be sent to the email address configured in the email section whenever new firmware is available. You must have Email Notification enabled from the <a href=\"tools_email.asp\">Tools &rarr; Email&nbsp;Settings</a> page.", //help890
	"The IP address and, where appropriate, port number of the local application.", //help814
	"Time interval the machine can be idle before the PPTP connection is disconnected. The Maximum Idle Time value is only used for the \"On demand\" and \"Manual\" reconnect modes.", //help283
	"This printing protocol is currently disabled. You can enable it <a href=\"../Tools/PS.shtml\" onclick=\"return jump_if();\">here</a>.", //sps_protdis
	"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help831
	"Insufficient Permissions", //_cantapplysettings
	"Allows H.323 (specifically Microsoft Netmeeting) clients to communicate across NAT. Note that if you want your buddies to call you, you should also set up a virtual server for NetMeeting. Refer to the <a href=\"adv_virtual.asp\"> Advanced &rarr; Virtual Server</a> page for information on how to set up a virtual server.", //help39
	"WCN configuration aborted due to %s", //WCN_LOG_ABORT
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"The Web sites listed here are used when the Web Filter option is enabled in <a href=\"#Access_Control\">Advanced &rarr; Access&nbsp;Control</a>.", //help141_a
	"The Firewall Settings allow you to set a single computer on your network outside of the router.", //af_intro_x
	"Add/Update Inbound Filter Rule", //help170
	"To use the shared printer from this computer, launch the Printer Wizard from the <a href=\"../Basic/Wizard.shtml\" onclick=\"return jump_if();\"> <i>Wizard </i> page</a>.", //tps_intro4
	"OR, click <em>Next</em> to continue anyway and later choose <em>No</em> when asked if you'd like to print a test page.", //wprn_tt7
	"Starting DHCP server", //GW_DHCPSERVER_START
	"Some firmware upgrades reset the configuration options to the factory defaults. Before performing an upgrade, be sure to save the current configuration from the <a href=\"tools_system.asp\">Tools &rarr; System</a> screen.", //help887
	"Allows FTP clients and servers to transfer data across NAT. Refer to the <a href=\"adv_virtual.asp\">Advanced &rarr; Virtual Server</a> page if you want to host an FTP server.", //help38
	"Welcome to the Wireless Security Setup Wizard", //wwl_title_wel
	"SPI (\"stateful packet inspection\" also known as \"dynamic packet filtering\") helps to prevent cyberattacks by tracking more state per session. It validates that the traffic passing through that session conforms to the protocol.", //help164
	"Select a filter that restricts the Internet hosts that can access this virtual server to hosts that you trust. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //hhav_filt
	"HNAP AddPortMapping '%s' %v:%d<->%v:%d %S conflict with %dth virtual server entry '%s' %v:%d<->%v:%d %S", //GW_PURE_ADDPORTMAPPING_CONFLICT
	"HNAP SetRouterLanSettings set RouterIPAddress %v, RouterSubnetMask %v, DHCPServerEnabled %s", //GW_PURE_SETROUTERLANSETTINGS
	"HNAP SetWLanSecurity set Enabled %s, Type %s", //GW_PURE_SETWLANSECURITY
	"The Policy Name cannot be blank.", //aa_alert_9
	"Time interval the machine can be idle before the L2TP connection is disconnected. The Maximum Idle Time value is used for the \"On demand\" and \"Manual\" reconnect modes.", //help287
	"Remote Admin <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Inbound Filter</a>", //ta_RAIF
	"This setting should remain at its default value of 2346 bytes.", //help180
	"HNAP SetDeviceSettings changed DeviceName to '%s'", //GW_PURE_SETDEVICESETTINGS
	"Signal", //_rssi
	"This wizard will guide you through a step-by-step process to set up your wireless network and make it secure.", //wwl_intro_wel
	"Click here to access firmware online.", //tf_ClickDL
	"DMZ means \"Demilitarized Zone.\" If an application has trouble working from behind the router, you can expose one computer to the Internet and run the application on that computer.", //help165
	"Other", //at_Prot__1
	"To use the shared printer from this computer, follow the setup instructions found in <a href=\"../Help/Basic.shtml#PS\" onclick=\"return jump_if();\" style=\"white-space: nowrap;\">Help -> Home -> Printer Wizard</a>.", //tps_intro5
	"The uploaded firmware file may not be correct. You may have uploaded a file that is not intended for this device, or the uploaded file may be corrupted.", //ub_intro_1
	"Time interval the machine can be idle before the PPPoE connection is disconnected. The Maximum Idle Time value is only used for the \"On demand\" and \"Manual\" reconnect modes.", //help277
	"This feature enables forwarding of \"magic packets\" (that is, specially formatted wake-up packets) from the WAN to a LAN computer or other device that is \"Wake on LAN\" (WOL) capable. The WOL device must be defined as such on the <a href=\"adv_virtual.asp\"> Advanced &rarr; Virtual Server</a> page. The LAN IP address for the virtual server is typically set to the broadcast address 192.168.0.255. The computer on the LAN whose MAC address is contained in the magic packet will be awakened.", //help41
	"Virtual Server", //VIRTUAL_SERVERS
	"Select a schedule for when the virtual server will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools &rarr; Schedules</a> screen and create a new schedule.", //hhav_sch
	"Restore To Factory Default", //ts_rfd
	"When the PPTP ALG is enabled, LAN computers can establish PPTP VPN connections either with the same or with different VPN servers. When the PPTP ALG is disabled, the router allows VPN operation in a restricted way 。 LAN computers are typically able to establish VPN tunnels to different VPN Internet servers but not to the same server. The advantage of disabling the PPTP ALG is to increase VPN performance. Enabling the PPTP ALG also allows incoming VPN connections to a LAN side VPN server (refer to <a href=\"adv_virtual.asp\">Advanced &rarr; Virtual Server</a>).", //help33b
	"Load From Local Hard Drive", //ts_ls
	"Your wireless network needs a name so it can be easily recognized by wireless clients. For security purposes, it is highly recommended to change the pre-configured network name.", //wwl_intro_s1
	"HNAP DeletePortMapping %s:%d modified %dth virtual server entry '%s' %v:%d<->%v:%d %S to %S", //GW_PURE_DELETEPORTMAPPING_MODIFY
	"After clicking <em>Next</em>, you will be asked for permission to download an executable file. Please click 'OK' to download the the file.<br/><br/>To launch the executable, you may need to open the file-download folder using a file browser and double-click on the icon labeled <em>Printer_Setup.exe</em>.", //wprn_s2c
	"It is possible for a computer or device that is manually configured to have an address that does reside within this range. In this case the address should be reserved (see <a href=\"#Static_DHCP\">DHCP Reservation</a> below), so that the DHCP Server knows that this specific address can only be used by a specific computer or device.", //help320
	"The Internet Sessions page displays full details of active Internet sessions through your router. An Internet session is a conversation between a program or application on a LAN-side computer and a program or application on a WAN-side computer.", //help813
	"Select a dynamic DNS service provider from the pull-down list, or you may enter a dynamic DNS service provider manually.", //help893
	"Select this option to save the router log to a file on your computer.", //help803
	"To check for the latest firmware, click the <span class=\"button_ref\">Check Online Now</span> button.", //help877
	"(GMT+01:00) Belgrade, Brastislava, Ljubljana", //up_tz_27
	"With the above example values filled in and this Port Forwarding Rule enabled, all TCP and UDP traffic on ports 6159 through 6180 and port 99 is passed through the router and redirected to the Internal Private IP Address of your Game Server at 192.168.0.50.", //help74
	"When \"OFF\" is selected, MAC addresses are not used to control network access. When \"ALLOW\" is selected, only computers with MAC addresses listed in the MAC Address List are granted network access. When \"DENY\" is selected, any computer with a MAC address listed in the MAC Address List is refused access to the network.", //help155_2
	"Established: Rate Estimating", //_sdi_s4
	"Miscellaneous", //MISC
	"Please enter one machine.", //aa_alert_10
	"Note: Now uploading. The upload may take up to 1 minute.", //tf_msg_Upping
	"Failure sending log email - try again in %d minutes", //GW_LOG_EMAIL_FAILED
	"Established or closing TCP connections.", //help823_17
	"Enable the DMZ option only as a last resort. If you are having trouble using an application from a computer behind the router, first try opening ports associated with the application in the <a href=\"adv_virtual.asp\" onclick=\"return jump_if();\">Virtual Server</a> or <a href=\"adv_portforward.asp\" onclick=\"return jump_if();\">Port Forwarding</a> sections.", //hhaf_dmz
	"This page displays the full details of active internet sessions to your router.", //sa_intro
	"Rebooting will disconnect any active internet sessions.", //up_rb_2
	"Select a schedule for when the service will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help23
	"If IGMP is enabled, this area of the screen shows all multicast groups of which any LAN devices are members.", //_bln_title_IGMPMemberships_h
	"See also <a href=\"adv_virtual.asp\"> Advanced &rarr; Virtual&nbsp;Server</a>, <a href=\"adv_portforward.asp\">Advanced &rarr; Port&nbsp;Forwarding</a>, <a href=\"adv_appl.asp\"> Advanced &rarr; Application&nbsp;Rules</a>, and <a href=\"adv_network.asp\">Advanced &rarr; Network (UPnP)</a> for related options.", //haf_intro_2
	"If you provided email information with the <a href=\"tools_email.asp\">Tools &rarr; Email</a> screen, clicking the <span class=\"button_ref\">Email Now</span> button sends the router log to the configured email address.", //help802
	"Click <em>Refresh</em> to try again.", //wprn_tt5
	"You can also have the log mailed to you periodically. Refer to <a href=\"tools_email.asp\" onclick=\"return jump_if();\">Tools &rarr; EMail</a>.", //hhsl_lmail
	"Press the button below to continue configuring the router if the previous page doesn't restore in <span id=\"show_sec\"></span>&nbsp;seconds.", //ap_intro_noreboot
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb", //up_tz_29
	"HNAP SetMACFilters2", //GW_PURE_SETMACFILTERS2
	"HNAP Reboot", //GW_PURE_REBOOT
	"If you changed the IP address of the router you will need to change the IP address in your browser before accessing the configuration Web site again.", //rb_change
	"The IP address and, where appropriate, port number of the application on the Internet.", //help816
	"HNAP DeletePortMapping %s:%d deleted %dth virtual server entry '%s' %v:%d<->%v:%d %S", //GW_PURE_DELETEPORTMAPPING_DELETE
	"If the uploaded file is correct, it is possible that the device may be too busy to properly receive it right now. In this case, please try the upload again. It is also possible that you are logged in as a 'user' instead of an 'admin' - only administrators can upload new firmware.", //ub_intro_3
	"Requests may be redirected to the \"Forbidden\" page if web access for the LAN machine is restricted by an Access Control Rule. Add the WAN-side identity (WAN-side IP-address of the router or its dynamic DNS name) on the <a href=\"adv_filters_url.asp\"> Advanced &rarr; Web&nbsp;Filter</a> screen to work around this problem.", //help30
	"Invalid LAN IP Address", //bln_alert_2
	"Use with <a href=\"adv_access_control.asp\" onclick=\"return jump_if();\">Advanced &rarr; Access&nbsp;Control</a>.", //hhwf_xref
	"Gateway remote administration enabled on port: %u", //GW_REMOTE_ADMINSTRATION
	"You have selected your security level - you will need to set a wireless security password.", //wwl_s4_intro
	"Security Mode", //sd_SecTyp
	"WAN IPv6 ADDRESS SETTINGS", //IPV6_WAN_IP
	"IPv6 Address", //IPV6_TEXT0
	"Please change IPv6 WAN protocol first!", //IPV6_TEXT1
	"Invalid Network Key!", //IPV6_TEXT2
	"Enable Routing Between Zones", //IPV6_TEXT3
	"Enable SSID", //IPV6_TEXT4
	"This selection helps you to define the Guest Zone scale.", //IPV6_TEXT5
	"Specifies whether the Guest Zone will be enabled or disabled.", //IPV6_TEXT6
	"Provide a name for Guest Zone wireless network.", //IPV6_TEXT7
	"Use this section to enable routing between Host Zone and Guest Zone, Guest clients cannot access Host clients' data without enabling this function.", //IPV6_TEXT8
	"Securing your wireless network is important as it is used to protect the integrity of the information being transmitted. The router is capable of 4 types of wireless security; WEP, WPA only, WPA2 only, and WPA/WPA2 (auto-detect).", //IPV6_TEXT9
	"Wired Equivalent Protocol (WEP) is a wireless security protocol for Wireless Local Area Networks (WLAN). WEP provides security by encrypting the data that is sent over the WLAN. The router supports 2 levels of WEP Encryption: 64-bit and 128-bit. WEP is disabled by default. The WEP setting can be changed to suit an existing wireless network or to customize your wireless network.", //IPV6_TEXT10
	"Authentication is a process by which the router verifies the identity of a network device that is attempting to join the wireless network. There are two types of authentication for this device when using WEP.", //IPV6_TEXT11
	"Select this option to allow all wireless devices to communicate with the router without being required to provide the encryption key needed to gain access to the network.", //IPV6_TEXT12
	"Select this option if you require any wireless device attempting to communicate with the router to provide the encryption key needed to access the network before being allowed to communicate with the %s.", //IPV6_TEXT13
	"Select the level of WEP Encryption that you would like to use on your network. The two supported levels are 64-bit and 128-bit.", //IPV6_TEXT14
	"The Key Types that are supported by the %s are HEX (Hexadecimal) and ASCII (American Standard Code for Information Interchange.) The Key Type can be changed to suit an existing wireless network or to customize your wireless network.", //IPV6_TEXT15
	"Keys", //IPV6_TEXT16
	"Keys 1-4 allow you to easily change wireless encryption settings to maintain a secure network. Simply select the specific key to be used for encrypting the network wireless data.", //IPV6_TEXT17
	"Key Type", //IPV6_TEXT18
	"WEP Encryption", //IPV6_TEXT19
	"Wi-Fi Protected Access authorizes and authenticates users coming onto the wireless network. WPA uses stronger security than WEP and is based on a key that changes automatically at regular intervals.", //IPV6_TEXT20
	"%s supports two different cipher types when WPA is used as the Security Type. These two options are TKIP (Temporal Key Integrity Protocol) and AES (Advanced Encryption Standard).", //IPV6_TEXT21
	"PSK/EAP", //IPV6_TEXT22
	"When PSK is selected, your wireless clients will need to provide a Passphrase for authentication. When EAP is selected, you will need to have a RADIUS server on your network which will handle the authentication of all your wireless clients.", //IPV6_TEXT23
	"Passphrase", //IPV6_TEXT24
	"This will be needed by your wireless clients in order to communicate with your %s, when PSK is selected. Enter 8 to 63 alphanumeric characters. Be sure to write this Passphrase down as you will need to enter it on any other wireless devices you are trying to add to your network.", //IPV6_TEXT25
	"This means of WPA authentication is used in conjunction with a RADIUS server that must be presented on your network. Enter the IP address, port, and Shared Secret used to configure the RADIUS. You also have the option to enter information for a second RADIUS server in the event that there are two on your network being used to authenticate wireless clients.", //IPV6_TEXT26
	"Wi-Fi Protected Access 2 authorizes and authenticates users onto the wireless network. WPA2 uses stronger security than WEP and is based on a key that changes automatically at regular intervals.", //IPV6_TEXT27
	"Use this section to configure your IPv6 Connection type. If you are unsure of your connection method, please contact your Internet Service Provider.", //IPV6_TEXT28
	"IPv6 CONNECTION TYPE", //IPV6_TEXT29
	"IPv6 Connection Type", //IPV6_TEXT29a
	"Choose the mode to be used by the router to the IPv6 Internet.", //IPV6_TEXT30
	"My IPv6 Connection is", //IPV6_TEXT31
	"Static IPv6", //IPV6_TEXT32
	"DHCPv6", //IPV6_TEXT33
	"PPPoE", //IPV6_TEXT34
	"IPv6 in IPv4 Tunnel", //IPV6_TEXT35
	"6to4", //IPV6_TEXT36
	"Local Connectivity Only", //IPV6_TEXT37
	"IPv6 in IPv4 TUNNEL SETTINGS", //IPV6_TEXT38
	"Enter the IPv6 in IPv4 Tunnel information provided by your Tunnel Broker.", //IPV6_TEXT39
	"Remote IPv4 Address", //IPV6_TEXT40
	"Remote IPv6 Address", //IPV6_TEXT41
	"Local IPv4 Address", //IPV6_TEXT42
	"Local IPv6 Address", //IPV6_TEXT43
	"LAN IPv6 ADDRESS SETTINGS", //IPV6_TEXT44
	"Use this section to configure the internal network settings of your router. If you change the LAN IPv6 Address here, you may need to adjust your PC network settings to access the network again.", //IPV6_TEXT45
	"LAN IPv6 Address", //IPV6_TEXT46
	"LAN IPv6 Link-Local Address", //IPV6_TEXT47
	"ADDRESS AUTOCONFIGURATION SETTINGS", //IPV6_TEXT48
	"Use this section to setup IPv6 Autoconfiguration to assign IPv6 addresses to the computers in your network. ", //IPV6_TEXT49
	"Enable Autoconfiguration", //IPV6_TEXT50
	"Autoconfiguration Type", //IPV6_TEXT51
	"Stateless", //IPV6_TEXT52
	"Stateful (DHCPv6)", //IPV6_TEXT53
	"IPv6 Address Range (Start)", //IPV6_TEXT54
	"IPv6 Address Range (End)", //IPV6_TEXT55
	"IPv6 Address Lifetime", //IPV6_TEXT56
	"Router Advertisement Lifetime", //IPV6_TEXT57
	"When configuring the router to access the IPv6 Internet, be sure to choose the correct IPv6 Connection Type from the drop down menu. If you are unsure of which option to choose, contact your Internet Service Provider (ISP).", //IPV6_TEXT58
	"If you are having trouble accessing the IPv6 Internet through the router, double check any settings you have entered on this page and verify them with your ISP if needed.", //IPV6_TEXT59
	"6to4 SETTINGS", //IPV6_TEXT60
	"Enter the IPv6 address information provided by your Internet Service Provider (ISP).", //IPV6_TEXT61
	"6to4 Address", //IPV6_TEXT62
	"IPv6 DNS SETTINGS", //IPV6_TEXT63
	"Obtain a DNS server address automatically or enter a specific DNS server address.", //IPV6_TEXT64
	"Obtain a DNS server address automatically", //IPV6_TEXT65
	"Use the following IPv6 DNS servers", //IPV6_TEXT66
	"Use this section to configure the internal network settings of your router.", //IPV6_TEXT67
	"Address Lifetime", //IPV6_TEXT68
	"Advertisement Lifetime", //IPV6_TEXT69
	"Address Range (Start)", //IPV6_TEXT70
	"Address Range (End)", //IPV6_TEXT71
	"Enter the information provided by your Internet Service Provider (ISP).", //IPV6_TEXT72
	"Idle Time", //IPV6_TEXT73
	"Subnet Prefix Length", //IPV6_TEXT74
	"IPv6 Default Gateway", //IPV6_TEXT75
	"The IPv6 (Internet Protocol version 6) section is where you configure your IPv6 Connection type.", //IPV6_TEXT76
	"There are several connection types to choose from: Link-local, Static IPv6, DHCPv6, Stateless Autoconfiguration, PPPoE, IPv6 in IPv4 Tunnel and 6to4. If you are unsure of your connection method, please contact your IPv6 Internet Service Provider. Note: If using the PPPoE option, you will need to ensure that any PPPoE client software on your computers has been removed or disabled.", //IPV6_TEXT77
	"Link-local Mode", //IPV6_TEXT78
	"The Link-local address is used by nodes and routers when communicating with neighboring nodes on the same link. This mode enables IPv6-capable devices to communicate with each other on the LAN side.", //IPV6_TEXT79
	"Static IPv6 Mode", //IPV6_TEXT80
	"This mode is used when your ISP provides you with a set IPv6 addresses that does not change. The IPv6 information is manually entered in your IPv6 configuration settings. You must enter the IPv6 address, Subnet Prefix Length, Default Gateway, Primary DNS Server, and Secondary DNS Server. Your ISP provides you with all this information.", //IPV6_TEXT81
	"DHCPv6 Mode", //IPV6_TEXT82
	"This is a method of connection where the ISP assigns your IPv6 address when your router requests one from the ISP's server. Some ISP's require you to make some settings on your side before your router can connect to the IPv6 Internet.", //IPV6_TEXT83
	"Stateless Autoconfiguration Mode", //IPV6_TEXT84
	"This is a method of connection where the ISP assigns your IPv6  address when your router requests one from the Default Gateway. Configuration of the IPv6 address is based on the receipt of the Router Advertisement message.", //IPV6_TEXT85
	"Select this option if your ISP requires you to use a  PPPoE (Point to Point Protocol over Ethernet) connection  to IPv6 Internet. DSL providers typically use this option.  This method of connection requires you to enter a <strong>Username</strong> and <strong>Password</strong> (provided by your Internet Service Provider) to gain access to the IPv6 Internet. The supported authentication protocols are PAP and CHAP.", //IPV6_TEXT86
	"Select this option if the ISP's servers assign the router's WAN IPv6 address upon establishing a connection.", //IPV6_TEXT87
	"If your ISP has assigned a fixed IPv6 address, select this option. The ISP provides the value for the <SPAN class=option>IPv6 Address.", //IPV6_TEXT88
	"The time interval the machine can be idle before the WAN link is disconnected. The Maximum Idle Time value is only used for the \"On demand\" and \"Manual\" reconnect modes.", //IPV6_TEXT89
	"IPv6 in IPv4 Tunnel Mode", //IPV6_TEXT90
	"IPv6 in IPv4 tunneling encapsulate of IPv6 packets in IPv4 packets so that IPv6 packets can be sent over an IPv4 infrastructure.", //IPV6_TEXT91
	"6to4 Mode", //IPV6_TEXT92
	"6to4 is an IPv6 address assignment and automatic tunneling technology that used to provide unicast IPv6 connectivity between IPv6 sites and hosts across the IPv4 Internet.", //IPV6_TEXT93
	"Primary DNS Server, Secondary DNS Server: Enter the IPv6 addresses of the DNS Servers. Leave the field for the secondary server empty if not used.", //IPV6_TEXT94
	"These are the settings of the LAN (Local Area Network) IPv6 interface for the router. The router's LAN IPv6 Address configuration is based on the IPv6 Address and Subnet assigned by your ISP. (A subnet with prefix /64 is supported in LAN.)", //IPV6_TEXT95
	"Use this section to set up IPv6 Autoconfiguration to assign an IPv6 address to the computers on your local network. A Stateless and a Stateful Autoconfiguration method are provided.", //IPV6_TEXT96
	"These two values (from and to) define a range of IPv6 addresses that the DHCPv6 Server uses when assigning addresses to computers and devices on your Local Area Network. Any addresses that are outside this range are not managed by the DHCPv6 Server. However, these could be used for manually configuring devices or devices that cannot use DHCPv6 to automatically obtain network address details.", //IPV6_TEXT97
	"When you select Stateful (DHCPv6), the following options are displayed.", //IPV6_TEXT98
	"The computers (and other devices) connected to your LAN also need to have their TCP/IP configuration set to \"DHCPv6\" or \"Obtain an IPv6 address automatically\".", //IPV6_TEXT99
	"IPv6 Address Range (DHCPv6)", //IPV6_TEXT100
	"Once your D-Link router is properly configured and this option is enabled, the router will manage the IPv6 addresses and other network configuration information for computers and other devices connected to your Local Area Network. There is no need for you to do this yourself.", //IPV6_TEXT101
	"It is possible for a computer or device that is manually configured to have an IPv6 address that does reside within this range.", //IPV6_TEXT102
	"The amount of time that a computer may have an IPv6 address before it is required to renew the lease.", //IPV6_TEXT103
	"Use Link-Local Address", //IPV6_TEXT104
	"Enable automatic IPv6 address assignment", //IPV6_TEXT105
	"SLAAC + Stateless DHCPv6", //IPV6_TEXT106
	"Autoconfiguration (SLAAC/DHCPv6)", //IPV6_TEXT107
	"Enable Automatic DHCP-PD in LAN", //IPV6_TEXT108
	"Enter a specific DNS server address", //IPV6_TEXT109
	"IPv6 Internet Connection Setup Wizard", //IPV6_TEXT110
	"Manual IPv6 Internet Connection Setup", //IPV6_TEXT111
	"IPv6 Internet Connection", //IPV6_TEXT112
	"There are two ways to set up your IPv6 Internet connection. You can use the Web-based IPv6 Internet Connection Setup Wizard, or you can manually configure the connection.", //IPV6_TEXT113
	"If you would like to configure the IPv6 Internet settings of your new D-Link Systems Router manually, then click on the button below.", //IPV6_TEXT114
	"Welcome to the D-Link ipv6 Internet connection setup wizard", //IPV6_TEXT115
	"This wizard will guide you through a step-by-step process to configure a new connection to the IPv6 Internet.", //IPV6_TEXT116
	"Step 1: Configure your IPv6 Internet Connection", //IPV6_TEXT117
	"Step 2: Save Settings and Connect", //IPV6_TEXT118
	"Router is detecting your IPv6 Internet connection types, please wait …", //IPV6_TEXT119
	"Router is unable to detect your IPv6 Internet connection type.", //IPV6_TEXT120
	"Guide me through the IPv6 settings", //IPV6_TEXT121
	"IPv6 over PPPoE", //IPV6_TEXT122
	"Choose this option if your IPv6 Internet connection requires a username and password to get online. Most DSL modems use this type of connection.", //IPV6_TEXT123
	"Static IPv6 address and Route", //IPV6_TEXT124
	"Choose this option if your Internet Service Provider (ISP) provided you with IPv6 address information that has to be manually configured.", //IPV6_TEXT125
	"Tunneling Connection (6rd)", //IPV6_TEXT126
	"Choose this option if your Internet Service Provider (ISP) provided you a IPv6 Internet connection by using 6rd automatic tunneling mechanism. ", //IPV6_TEXT127
	"To set up this connection you will need to have a Username and Password from your IPv6 Internet Service Provider. If you do not have this inforamtion, please contact your ISP.", //IPV6_TEXT128
	"Share with IPv4", //IPV6_TEXT129
	"To set up this connection you will need to have a complete list of IPv6 information provided by your IPv6 Internet Service Provider.  If you have a Static IPv6 connection and do not have this inforamtion, please contact your ISP.", //IPV6_TEXT130
	"To set up this 6rd tunneling connection you will need to have the following information from your IPv6 Internet Service Provider.  If you do not have this inforamtion, please contact your ISP.", //IPV6_TEXT131
	"6rd IPv6 Prefix", //IPV6_TEXT132
	"Assigned IPv6 Prefix", //IPV6_TEXT133
	"6rd Border Relay IPv4 Address", //IPV6_TEXT134
	"IPv6 DNS Server", //IPV6_TEXT135
	"The IPv6 Internet Connection Setup Wizard has completed. Click the Connect button to save your settings and reboot the router.", //IPV6_TEXT136
	"IPv6", //IPV6_TEXT137
	"Auto Detection", //IPV6_TEXT138
	"6rd", //IPV6_TEXT139
	"DS-Lite", //IPV6_TEXT140
	"Teredo Tunneling Path-through", //IPV6_TEXT141
	"6rd Configuration", //IPV6_TEXT142
	"6rd DHCPv4 Option", //IPV6_TEXT143
	"Manual Configuration", //IPV6_TEXT144
	"Tunnel Link-Local Address", //IPV6_TEXT145
	"AFTR address Internet connection type", //IPV6_TEXT146
	"Enable DHCP-PD", //IPV6_TEXT147
	"Enter the AFTR address information provided by your Internet Service Provider(ISP).", //IPV6_TEXT148
	"DS-Lite Configuration", //IPV6_TEXT149
	"DS-Lite DHCPv6 Option", //IPV6_TEXT150
	"AFTR IPv6 Address", //IPV6_TEXT151
	"B4 IPv4 Address", //IPV6_TEXT152
	"IPv6 WAN Default Gateway", //IPV6_TEXT153
	"Please select your IPv6 Internet Connection type", //IPV6_TEXT154
	"Set static ipv6 address connection", //IPV6_TEXT155
	"The IPv6 Internet Connection Setup Wizard has completed. Click the Connect button to save your settings and reboot the router.", //IPV6_TEXT156
	"SLAAC + RDNSS", //IPV6_TEXT157
	"Destination IPv6/Prefix Length", //IPV6_TEXT158
	"The range of B4 IPv4 Address is from 192.0.0.2 to 192.0.0.7", //IPV6_TEXT159
	"AFTR Address", //IPV6_TEXT160
	"IPv6 PPPoE is share with IPv4 PPPoE. Please change IPv6 WAN protocol at first!", //IPV6_TEXT161
	"6rd is using DHCPv4 option. Please change IPv6 WAN protocol at first!", //IPV6_TEXT162
	"IPv6 wan type should be SLAAC/DHCPv6, PPPoE, Autodetect Mode", //IPV6_TEXT163
	"You can also enable DHCP-PD to delegate prefixes for routers in your LAN. ", //IPV6_TEXT164
	"All of your IPv6 LAN connection details are displayed here.", //IPV6_TEXT165
	"IPv6 Network assigned by DHCP-PD", //IPV6_TEXT166
	"PARENTAL CONTROL", //DNS_TEXT0
	"Options to improve the speed and reliability of your Internet connection, to apply content filtering and to protect you from phishing sites. Choose from pre-configured bundles or register your router with OpenDNSR to choose from 50 content categories for custom blocking. ", //DNS_TEXT1
	"SECURITY OPTIONS", //DNS_TEXT2
	"Advanced DNS&#8482;", //DNS_TEXT3
	"Advanced DNS makes your Internet connection safer, faster, smarter and more reliable. It blocks phishing websites to protect you from identity theft.", //DNS_TEXT4
	"OpenDNS&reg; FamilyShield&#8482;", //DNS_TEXT5
	"Automatically block adult and phishing websites while improving the speed and reliability of your Internet connection.", //DNS_TEXT6
	"OpenDNS&reg; Parental Controls&#8482;", //DNS_TEXT7
	"OpenDNS Parental Controls provides award-winning Web content filtering while making your Internet connection safer, faster, smarter and more reliable. With more than 50 content categories to choose from it's effective against adult content, proxies, social networking, phishing sites, malware and more. Fully configurable from anywhere there is Internet access. ", //DNS_TEXT8
	"None: Static IP or Obtain Automatically From ISP", //DNS_TEXT9
	"Use the DNS servers provided by your ISP, or enter your preferred DNS servers.", //DNS_TEXT10
	"Although the Advanced DNS feature is enabled, the DNS IP address of your workstation can still be modified to the DNS server IP you desire. Please note that the router does not dictate the DNS name resolution when the DNS IP address is manually configured on the workstation.", //DNS_TEXT11
	"If you selected this option and have a VPN or an Intranet setup on your network, you can disable the Advanced DNS service if you experience connection difficulties.", //DNS_TEXT12
	"D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME", //TEXT000
	"Stateless Autoconfiguration", //TEXT001
	"Virtual server name %s invalid. Illegal character ',/,''\"", //TEXT002
	"\"Rules name \"+ i +\" invalid. Illegal character ',/,''\"", //TEXT003
	"\"Host name invalid. Illegal character ',/,''\"", //TEXT004
	"\"Local domain name invalid. Illegal character ',/,''\"", //TEXT005
	"\"Rules name \"+ i +\" invalid. Illegal character ',/,''\"", //TEXT006
	"Port forwarding name %s invalid. Illegal character ',/,''", //TEXT007
	"\"Rules\"+i+\" is setting same as Rules\"+j+\".\"", //TEXT008
	"obj_word + \" conflict with another public port.\"", //TEXT009
	"obj_word + \" conflict with another private port.\"", //TEXT010
	"\"The Other Protocol Type is invalid\"", //TEXT011
	"\"Please choose wireless device with wps!\"", //TEXT012
	"\"Inbound filter must be smaller than \"+ rule_max_num", //TEXT013
	"\"Name cannot be set as the same as default Inbound filter name 'Allow All' or 'Deny All'.\"", //TEXT014
	"\"Schedule rules Full! Please Delete an Entry.\"", //TEXT015
	"First Page", //TEXT016
	"Last Page", //TEXT017
	"Previous", //TEXT018
	"System Activity", //TEXT019
	"Debug Information", //TEXT020
	"Attacks", //TEXT021
	"Dropped Packets", //TEXT022
	"Notice", //TEXT023
	"\"Cannot choose WEP key 2, 3, 4 when WPS is enabled!!\"", //TEXT024
	"\"Cannot choose WPA-Personal/TKIP and AES when WPS is enabled!!\"", //TEXT025
	"\"Cannot choose WPA-Enterprise when WPS is enabled!!\"", //TEXT026
	"\"Cannot choose shared key when WPS is enabled!!\"", //TEXT027
	"\"Please Enable Wireless first.\"", //TEXT028
	"The WPS Function is currently set to disabled. Please click \"Yes\" to enable it or \"No\" to exit the wizard.", //TEXT029
	"The %s cannot allow loopback IP or multicase IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x) entries.", //TEXT030
	"The %s port entered is invalid.", //TEXT031
	"The %s secret entered is invalid.\"", //TEXT032
	"\"Reserved IP address\"", //TEXT033
	"Please enter another Name", //TEXT034
	"\"Start IP address\"", //TEXT035
	"\"End IP address\"", //TEXT036
	"The LAN IP Address and the Start IP Address are not in the same subnet", //TEXT037
	"The LAN IP Address and the End IP Address are not in the same subnet", //TEXT038
	"The Ending IP Address must be greater than the Starting IP Address", //TEXT039
	"The setting has been saved.", //TEXT040
	"The Key \" + i + \" is invalid. The Key must be \" + wep_key_len + \" characters or \" + hex_len + \" hexadecimal number.", //TEXT041
	"\"Key \" + i + \" is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042
	"%s Gateway IP address %s must be within the WAN subnet.", //TEXT043
	"Please select a Computer Name first", //TEXT044
	"\"This firmware is the latest version.\"", //TEXT045
	"\"Error contacting the server, please check the Internet connection status.\"", //TEXT046
	"\"WAN and LAN IP Address cannot be in the same subnet.\"", //TEXT047
	"Please enter the following settings in the device that you are adding to your wireless network and keep a note of it for future reference.", //TEXT048
	"You have failed to add the wireless device to your wireless network within the given timeframe, please click on the button below to do it again.", //TEXT049
	"\"IP Address '\"+ res_ip +\"' has already been used.\"", //TEXT050
	"The Confirmed Password does not match the New Password", //TEXT051
	"Please select an Application Name first", //TEXT052
	"ALSO CALLED WCN 2.0 IN WINDOW VISTA", //TEXT053
	"obj_word + \" conflict with Port Forwarding Port.\"", //TEXT054
	"obj_word + \" conflict with Application Firewall Port.\"", //TEXT055
	"obj_word + \" conflict with Virtual Server Port.\"", //TEXT056
	"Port conflict.", //TEXT057
	"TCP Port conflict.", //TEXT058
	"UDP Port conflict.", //TEXT059
	"The Port Forwarding name is already in the list", //TEXT060
	"Please enter a TCP port number or a UDP port number.", //TEXT061
	"Do you want to enable the DHCP Reservation entry for IP Address \" + DataArray[idx].IP", //TEXT062
	"The rule is being used by another rule and cannot be deleted.", //TEXT063
	"Schedule Name is invalid. Legal characters are 0~9, A~Z, or a~z.", //TEXT064
	"Schedule Name is the default name.", //TEXT065
	"The Schdule name is already in the list", //TEXT066
	"The rule is being used by another rule and cannot be edited.", //TEXT067
	"IPv6 Network Information", //TEXT068
	"All of your IPv6 Internet and network connection details are displayed on this page.", //TEXT069
	"IPv6 Connetcion Information", //TEXT070
	"WAN IPv6 Address", //TEXT071
	"LAN IPv6 Computers", //TEXT072
	"Retry", //TEXT073
	"Next", //TEXT074
	"Host Name or IPv6 Address", //TEXT075
	"Try again", //TEXT076
	"PPPoE Session", //TEXT077
	"Create a new session", //TEXT078
	"Please enter a Trigger Port number", //MSG000
	"Please enter a Firewall Port number", //MSG001
	"The 1st address of %s must be an integer.", //MSG002
	"The 2nd address of %s must be an integer.", //MSG003
	"The 3rd address of %s must be an integer.", //MSG004
	"The 4th address of %s must be an integer.", //MSG005
	"The %s is an invalid address.", //MSG006
	"The %s cannot be zero.", //MSG007
	"The %s port entered is invalid.", //MSG008
	"The %s secret entered is invalid", //MSG009
	"The %s can't allow entry to loopback IP or multicast IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Please enter user name", //MSG011
	"Please enter another %s value.", //MSG012
	"The value of %s must be numeric!", //MSG013
	"The range of %s is %1n ~ %2n.", //MSG014
	"The value of %s must be an even number.", //MSG015
	"The Key is invalid. The Key must be a 5 or 10 character hexadecimal number. You entered \"", //MSG016
	"The Key is invalid. The Key must be a 13 or 26 character hexadecimal number. You entered", //MSG017
	"The 1st address of %s must be hexadecimal.", //MSG018
	"The 2nd address of %s must be hexadecimal.", //MSG019
	"The 3rd address of %s must be hexadecimal.", //MSG020
	"The 4th address of %s must be hexadecimal.", //MSG021
	"The 5th address of %s must be a hexadecimal.", //MSG022
	"The 6th address of %s must be hexadecimal.", //MSG023
	"The 7th address of %s must be hexadecimal.", //MSG024
	"The 8th address of %s must be hexadecimal.", //MSG025
	"The 1st range of %s must be between", //MSG026
	"The 2nd range of %s must be between", //MSG027
	"The 3rd range of %s must be between", //MSG028
	"The 4th range of %s must be between", //MSG029
	"The 5th range of %s must be between", //MSG030
	"The 6th range of %s must be between", //MSG031
	"The 7th range of %s must be between", //MSG032
	"The 8th range of %s must be between", //MSG033
	"The %s cannot allow entry to loopback IP ( ::1 ).", //MSG034
	"The %s cannot allow entry to multicast IP ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"The suffix of ", //MSG036_1
	"The subnet of ", //MSG037_1
	" must be hexadecimal.", //MSG038_1
	" is an invalid address.", //MSG039_1
	"The suffix of \"+tag +\" must be hexadecimal.", //MSG036
	"The suffix of \"+tag+\" is an invalid address.", //MSG037
	"The subnet of \"+tag +\" must be hexadecimal.", //MSG038
	"The subnet of \"+tag+\" is an invalid address.", //MSG039
	"The suffix of IPv6 Address Range(Start) is more than the suffix of IPv6 Address Range(End)", //MSG040
	"The IPv6 address allows a double-colon only once.", //MSG041
	"The IPv6 address is illegal", //MSG042
	"Invalid Metric", //MSG043
	"Pure 802.11n mode doesn't support WEP.", //MSG044
	"Pure 802.11n mode doesn't support TKIP.", //MSG045
	"The range of %s is from %s to ", //MSG046
	"Invalid IPv6 ULA Prefix", //MSG047
	"The field of ULA prefix is blank, use the default ULA prefix?", //MSG048
	"DNS stands for Domain Name System. The DNS servers act as a phonebook and translate the human-friendly domain name into its corresponding IP address. Advanced DNS Services for D-Link is powered by Best Path Networks, a subsidiary of OpenDNS that provides anti-phishing and DNS services to partners like D-Link. OpenDNS is the world’s largest and fastest-growing provider of free security and DNS infrastructure services. Advanced DNS Services makes your online experience safer and your Internet overall faster and more reliable.", //ADV_DNS_DESC1
	"The DNS platform is designed to not interfere with any specific protocol. However, a small subset of spam filtering solutions may be confused by receiving search responses for domains that do not exist. It is recommended that the enhanced search experience be disabled for clients that operate an on-site mail server. DNS does not affect upload or download speeds. These are controlled exclusively by your Internet Service Provider. D-Link and Best Path Networks do not collect or store any personally identifiable DNS information about Advanced DNS Services users.", //ADV_DNS_DESC2
	"Your search results are powered by Yahoo. The search function provides you with a much more fluid browsing experience. When a site cannot be reached, or a site does not exist, we will provide you with search suggestions instead of the generic error message displayed by your browser. We also automatically correct some of the common typos users make in the address bar. The typo-correction feature only works for top level domains that have been misspelled, such .cmo and .ogr. Sometimes you might be mis-directed to the search results page. If you clicked on a link in a spam email it is quite possible that the site has been disabled for abuse. Because the site no longer exists you may receive our search page.", //ADV_DNS_DESC3
	"Oops!", //OOPS
	"The page you requested is not available.", //ERROR404
	"Suggestions", //SUGGESTIONS
	"Make sure your internet cable is securely connected to the internet port on your router, and your internet LED is blink green or blue.", //SUGGESTIONS_1
	"Check to make sure that the <a href='http://<% CmoGetCfg('lan_ipaddr',''); %>/'>Internet settings</a> on your router are set correctly, such as your PPPoE username/password settings.", //SUGGESTIONS_2
	"(hour minute)", //tsc_hrmin_1
	"DHCP-PD", //DHCP_PD
	"Enable DHCP-PD", //DHCP_PD_ENABLE
	"IPv6 network assigned <br>by DHCP-PD", //DHCP_PD_ASSIGNED
	"6to4 Relay", //_6to4RELAY
	"Obtain IPv6 DNS server address automatically", //IPV6_TEXT65_v6
	"Use the following IPv6 DNS address", //IPV6_TEXT66_v6
	"Changing usb type to Windows Mobile or iPhone or Android Phone will cause the device to reboot.", //usb_reboot
	"Changing usb type to Windows Mobile or iPhone will cause the device to reboot, also will change device IP to 192.168.99.1.", //usb_reboot_chnip
	"Phone Type", //_phone
	"Select usb phone", //_select_phone
	"Select the 3G USB phone you used.", //_phone_info
	"3G USB Phone", //usb_3g_phone
	"Windows Mobile 5", //usb_window_mobile_5
	"iPhone 3G(s)\"", //usb_iphone
	"Android Phone", //android_phone
	"Displays the current status of connection to DDNS server", //help901
	"Device Name", //DEVICE_NAME
	"Device Name allows you to configure this device easily when your network using TCP/IP protocol. You can enter the device name of the router, instead of IP address, into your web browser to access for configuration. Recommend to change the device name if there's more than on D-Link devices within the subnet.", //DEVICE_DESC
	"The lease %v was revoked.", //IPDHCPSERVER_LEASE_REVOKED2
	"Lease reservation %v was deleted.", //IPDHCPSERVER_LEASE_RESERVATION_DELETED
	"Lease %v renewed by client %m", //IPDHCPSERVER_LEASE_RENEW
	"Wake on LAN", //help738
	"Wireless Local Area Network", //help759
	"The most widely used technology for Local Area Networks.", //help517
	"Bits per second", //help443
	"Characters A-Z and 0-9", //help414
	"Older devices or technology", //help600
	"Default", //help486
	"DSL", //help503
	"The loss in strength of digital and analog signals. The loss is greater when the signal is being transmitted over long distances.", //help426
	"Bandwidth", //help432
	"Breaking up data into smaller pieces to make it easier to store", //help527
	"The Web Filter option allows you to set up a list of allowed Web sites that can be used by multiple users. When Web Filter is enabled, all Web sites not listed on this page will be blocked. To use this feature, you must also select the \"Apply Web Filter\" checkbox in the Access Control section.", //awf_intro_WF
	"Post Office Protocol 3 is used for receiving email", //help652
	"CardBus", //help456
	"Graphical user interface", //help539
	"Database", //help472
	"File server", //help520
	"VoIP", //help737
	"The first layer of the OSI model. Provides the hardware means of transmitting electrical signals on a data carrier", //help646
	"Web browser", //help745
	"Used to synchronize communication timing between devices on a network", //help659
	"USB", //help727
	"Wireless ISP", //help753
	"The method of transferring data from one computer to another on the Internet", //help574
	"Remote Authentication Dial-In User Service allows for remote users to dial into a central server and be authenticated in order to access resources on a network", //help663
	"Wi-Fi", //help748
	"Create a list of Web sites to which you would like to allow access from the devices on your network.", //hhwf_intro
	"Light Emitting Diode", //help598
	"xDSL", //help761
	"IP address that is assigned by a DHCP server and that may change. Cable Internet providers usually use this method to assign IP addresses to their customers.", //help510
	"IPsec", //help584
	"A utility displays the routes between you computer and specific destination", //help716
	"Bit rate", //help440
	"Asymmetric Digital Subscriber Line", //help410
	"dBi", //help480
	"IEEE", //help559
	"Ethernet", //help516
	"Alphanumeric", //help413
	"Maximum Transmission Unit is the largest packet that can be transmitted on a packet-based network like the Internet", //help619
	"A computer on a network that stores data so that the other computers on the network can all access it", //help521
	"DSSS: Modulation technique used by 802.11b wireless devices", //help494
	"Domain Name System: Translates Domain Names to IP addresses", //help498
	"Network Interface Card", //help628
	"An encryption and decryption key that is generated for every communication session between two computers", //help683
	"Gigabits per second", //help535
	"SPI", //help695
	"Wi,Wide Area Network", //help740
	"An ISP provides access to the Internet to individuals or companies", //help578
	"Beacon", //help438
	"Dynamic DNS is provided by companies to allow users with Dynamic IP addresses to obtain a Domain Name that will always by linked to their changing IP address. The IP address is updated by either client software running on a computer or by a router that supports Dynamic DNS, whenever the IP address changes", //help508
	"ASCII", //help423
	"NetBIOS", //help625
	"Server", //help680
	"In terms of a wireless network, this is when wireless clients use an Access Point to gain access to the network", //help568
	"Multicast", //help620
	"Apple's version of UPnP, which allows for devices on a network to discover each other and be connected without the need to configure any settings", //help667
	"A family of specifications for wireless local area networks (WLANs) developed by a working group of the Institute of Electrical and Electronics Engineers (IEEE).", //help766
	"RADIUS", //help662
	"Stateful inspection", //help701
	"Half-duplex", //help542
	"A system of worldwide networks which use TCP/IP to allow for resources to be accessed from computers around the world", //help570
	"DMZ: A single computer or group of computers that can be accessed by both users on the Internet as well as users on the Local Network, but that is not protected by the same security as the Local Network.", //help489
	"To install a more recent version of a software or firmware product", //help723
	"Kilobyte", //help593
	"A time during processes when something causes the process to slowdown or stop all together", //help447
	"System Logger -- a distributed logging interface for collecting in one place the logs from different sources. Originally written for UNIX, it is now available for other operating systems, including Windows.", //help705
	"Connecting to a Local Area Network over one of the 802.11 wireless standards", //help755
	"H.323", //_H323
	"To provide credentials, like a Password, in order to verify that the person or device is really who they are claiming to be", //help427
	"To unscramble an encrypted message back into plain text", //help485
	"Dynamic Host Configuration Protocol: Used to automatically assign IP addresses from a predefined pool of addresses to computers or devices that request them", //help490
	"HTTP over SSL is used to encrypt and decrypt HTTP transmissions", //help555
	"Collision", //help462
	"VPN: A secure tunnel over the Internet to connect remote offices or users to their company's network", //help732
	"Kbyte", //help592
	"A device that allows you to connect a computer up to a coaxial cable and receive Internet access from your Cable provider", //help455
	"The fifth layer of the OSI model which coordinates the connection and communication between applications on both ends", //help685
	"Many web sites construct pages with images and content from other web sites. Access will be forbidden if you do not enable all the web sites used to construct a page. For example, to access <code>my.yahoo.com</code>, you need to enable access to <code>yahoo.com</code>, <code>yimg.com</code>, and <code>doubleclick.net</code>.", //help146
	"Point-to-Point Protocol is used for two computers to communicate with each over a serial interface, like a phone line", //help655
	"A data frame by which one of the stations in a Wi-Fi network periodically broadcasts network control data to other wireless stations.", //help439
	"Used to transmit and receive RF signals.", //help416
	"Uniform Resource Locator is a unique address for files accessible on the Internet", //help726
	"SNMP", //help692
	"Host", //help550
	"The amount of data that can be transferred in a given time period", //help714
	"Digital Subscriber Line. High bandwidth Internet connection over telephone lines", //help504
	"Uses a randomly selected 56-bit key that must be known by both the sender and the receiver when information is exchanged", //help469
	"A card installed in a computer or built onto the motherboard that allows the computer to connect to a network", //help629
	"LED", //help597
	"A utility that allows you to view content and interact with all of the information on the World Wide Web", //help746
	"Wireless Fidelity", //help749
	"The second layer of the OSI model. Controls the movement of data on the physical link of a network", //help471
	"Sending voice information over the Internet as opposed to the PSTN", //help736
	"The amount of time that it takes a packet to get from the one point to another on a network. Also referred to as delay", //help596
	"Transmission Control Protocol", //help706
	"Reboot", //help664
	"A feature of a firewall that monitors outgoing and incoming traffic to make sure that only valid responses to outgoing requests are allowed to pass though the firewall", //help702
	"WISP", //help756
	"Internet Protocol", //help573
	"A group of computers in a building that usually access files from a server", //help601
	"Session layer", //help684
	"RSA", //help678
	"Wi-Fi Protected Access. A Wi-Fi security enhancement that provides improved data encryption, relative to WEP.", //help760
	"Gigabit Ethernet", //help536
	"Domain name", //help499
	"Internet Group Management Protocol is used to make sure that computers can report their multicast group membership to adjacent routers", //help562
	"WCN", //help741
	"A standard that provides consistency of voice and video transmissions and compatibility for videoconferencing devices", //help541
	"User Datagram Protocol", //help717
	"Layer 2 Tunneling Protocol", //help604
	"Unicast", //help718
	"Computer on a network", //help551
	"Internet Service Provider", //help577
	"Converting data into cyphertext so that it cannot be easily read", //help515
	"Sending data from one device to many devices on a network", //help621
	"AES. Government encryption standard", //help412
	"Throughput", //help713
	"Used for sending and receiving email", //help687
	"Infrastructure", //help567
	"Microsoft Point-to-Point Encryption is used to secure data transmissions over PPTP connections", //help618
	"The amount of bits that pass in given amount of time", //help441
	"Data", //help466
	"SMTP", //gw_vs_5
	"DMZ", //help488
	"Kilobits per second", //help591
	"AP. Device that allows wireless clients to connect to it and access the network", //help402
	"Quality of Service", //help661
	"DMZ", //help495
	"ISP", //help587
	"Preamble", //help658
	"Upgrade", //help722
	"Decibels relative to one milliwatt", //help483
	"RIP", //help670
	"WPA", //help750
	"Browser", //help452
	"Stateful Packet Inspection", //help696
	"Repeater", //help668
	"The maximum amount of bytes or bits per second that can be transmitted to and from a network device", //help433
	"A computer on a network that provides services and resources to other computers on the network", //help681
	"Network Time Protocol", //help632
	"ADSL", //help409
	"802.11", //help765
	"Application layer", //help421
	"URL", //help725
	"QoS", //help660
	"IPsec provides security at the packet processing layer of network communication", //help576
	"An updated version of security for wireless networks that provides authentication as well as encryption", //help751
	"Voice over IP", //help735
	"Access Point", //help401
	"POP3", //gw_vs_6
	"Digital certificate:", //help491
	"Broadband", //help448
	"Internet Key Exchange is used to ensure security for VPN connections", //help566
	"Help Glossary", //help398
	"Internetwork Packet Exchange is a networking protocol developed by Novel to enable their Netware clients and servers to communicate", //help586
	"A TCP/IP protocol for transmitting streams of printer data.", //help710
	"Simple Mail Transfer Protocol", //help686
	"Transmission technology that provides a data rate of 1 billion bits per second", //help537
	"PPP", //help654
	"TCP/IP(Transmission Control Protocol/Internet Protocol)", //help708
	"American Standard Code for Information Interchange. This system of characters is most commonly used for text files", //help424
	"Duplex", //help505
	"A 32-bit number, when talking about Internet Protocol Version 4, that identifies each computer that transmits data on the Internet or on an Intranet", //help583
	"Backward Compatible", //help430
	"Decrypt", //help484
	"Cable modem", //help454
	"HUB", //help556
	"Data-Link layer", //help470
	"Governs the management and monitoring of network devices", //help689
	"Cookie", //help464
	"A program or user that requests data from a server", //help461
	"NTP", //help635
	"Traceroute", //help715
	"Network Address Translation allows many private IP addresses to connect to the Internet, or another network, through one IP address", //help622
	"Virtual Private Network", //help731
	"ARP. Used to map MAC addresses to IP addresses so that conversions can be made in both directions.", //help408
	"Simple Network Management Protocol", //help688
	"Information that is stored on the hard drive of your computer that holds your preferences to the site that gave your computer the cookie", //help465
	"Subnet mask", //help703
	"SSH", //help697
	"MAC address", //help605
	"The action of data packets being transmitted from one router to another", //help549
	"Sending and Receiving data transmissions at the sane time", //help506
	"A sequence of characters that is used to authenticate requests to resources on a network", //help642
	"Automatic Private IP Addressing", //help428
	"Session key", //help682
	"An electronic method of providing credentials to a server in order to have access to it or a network", //help492
	"Fragmentation", //help526
	"The third layer of the OSI model which handles the routing of traffic on a network", //help631
	"A unique hardware ID assigned to every Ethernet adapter by the manufacturer.", //help606
	"To restart a computer and reload it's operating software or firmware from nonvolatile storage.", //help665
	"The section lists the currently allowed web sites.", //help148
	"Rate estimation aborted as low on resources", //RATE_ESTIMATOR_RESOURCE_ERROR
	"A standard that allows network devices to discover each other and configure themselves to be a part of the network", //help721
	"HTTPS", //gw_vs_2
	"UTP", //help729
	"Wireless Internet Service Provider", //help757
	"Latency", //help595
	"Routing Information Protocol is used to synchronize the routing table of all the routers on a network", //help671
	"Wired Equivalent Privacy is security for wireless networks that is supposed to be comparable to that of a wired network", //help747
	"TCP/IP", //help707
	"Transmitting data in all directions at once", //help451
	"Electronic Mail is a computer-stored message that is transmitted over the Internet", //help514
	"Extensible Authentication Protocol", //help512
	"The most commonly used connection method for Ethernet", //help675
	"Access Control List", //help399
	"Network Basic Input/Output System", //help626
	"Antenna", //help415
	"A device that connects your network to another, like the internet", //help533
	"A World Wide Web browser created and provided by Microsoft", //help572
	"A networking device that connects multiple devices together", //help557
	"Data Encryption Standard", //help468
	"To send a request from one computer to another and have a file transmitted from the requesting computer to the other", //help724
	"A utility program that verifies that a given Internet address exists and can receive messages. The utility sends a control packet to the given address and waits for a response.", //help648
	"Please wait", //wt_title
	"Point-to-Point Tunneling Protocol is used for creating VPN tunnels over the Internet between two networks", //help657
	"dBm", //help482
	"Algorithm used for encryption and authentication", //help679
	"The ability for new devices to communicate and interact with older legacy devices to guarantee interoperability", //help431
	"Institute of Electrical and Electronics Engineers", //help560
	"Windows Connect Now. A Microsoft method for configuring and bootstrapping wireless networking hardware (access points) and wireless clients, including PCs and other devices.", //help742
	"A wide band of frequencies available for transmitting data", //help449
	"IKE", //help565
	"Organizes information so that it can be managed updated, as well as easily accessed by users or applications.", //help473
	"Legacy", //help599
	"IPX", //help585
	"Sending and Receiving data at the same time", //help530
	"NetBEUI", //help623
	"WLAN", //help758
	"NIC", //help634
	"The larger network that your LAN is connected to, which may be the Internet itself, or a regional or corporate network", //help752
	"Internet Protocol Security", //help575
	"Broadcast", //help450
	"Physical layer", //help645
	"When do two devices on the same Ethernet network try and transmit data at the exact same time.", //help463
	"Address Resolution Protocol", //help407
	"A program that allows you to access resources on the web and provides them to you graphically", //help453
	"IGMP", //help561
	"Bit/sec", //help442
	"A generic term for the family of digital subscriber line (DSL) technologies, such as ADSL, HDSL, RADSL, and SDSL.", //help762
	"Hypertext Transfer Protocol is used to transfer files from HTTP servers (web servers) to HTTP clients (web browsers)", //help553
	"Kbps", //help590
	"Megabits per second", //help608
	"Advanced Encryption Standard", //help411
	"DNS", //gw_vs_4
	"Hexadecimal", //help546
	"A logical channel endpoint in a network. A computer might have only one physical channel (its Ethernet channel) but can have multiple ports (logical channels) each identified by a number.", //help653
	"Decibels relative to isotropic radiator", //help481
	"Full-duplex", //help529
	"Attenuation", //help425
	"ACL. This is a database of network devices that are allowed to access resources on the network.", //help400
	"Dynamic IP address", //help509
	"DHCP", //_DHCP
	"TCP Raw", //help709
	"UPnP", //help720
	"USB", //help728
	"Information that has been translated into binary so that it can be processed or moved to another device", //help467
	"Communication between a single sender and receiver", //help719
	"Local Area Network", //help594
	"A newer version of the PC Card or PCMCIA interface. It supports a 32-bit data path, DMA, and consumes less voltage", //help457
	"Rendezvous", //help666
	"Secure Shell is a command line interface that allows for secure connections to remote computers", //help698
	"GUI", //help538
	"Network Layer", //help630
	"7th Layer of the OSI model. Provides services to applications to ensure that they can communicate properly with other applications on a network.", //help422
	"Direct Sequence Spread Spectrum", //help493
	"Dynamic DNS service", //help507
	"Internet Explorer", //help571
	"Rate estimation aborted as measurements failed to converge", //RATE_ESTIMATOR_CONVERGENCE_ERROR
	"A predetermined value or setting that is used by a program when no user input has been entered for this value or setting", //help487
	"NetBIOS Extended User Interface is a Local Area Network communication protocol. This is an updated version of NetBIOS", //help624
	"Data cannot be transmitted and received at the same time", //help543
	"Service Set Identifier is a name for a wireless network", //help700
	"Client", //help460
	"Unshielded Twisted Pair", //help730
	"To send a request from one computer to another and have the file transmitted back to the requesting computer", //help502
	"Email", //help513
	"Session Initiation Protocol. A standard protocol for initiating a user session that involves multimedia content, such as voice or chat.", //help690
	"Mbps", //help607
	"Programming that is inserted into a hardware device that tells it how to function", //help525
	"A company that provides a broadband Internet connection over a wireless connection", //help754
	"MPPE", //help617
	"A name that is associated with an IP address", //help500
	"Internet Control Message Protocol", //help558
	"APIPA. An IP address that that a Windows computer will assign itself when it is configured to obtain an IP address automatically but no DHCP server is available on the network", //help429
	"EAP", //help511
	"Gbps", //help534
	"\"Demilitarized Zone\". A computer that logically sits in a \"no-mans land\" between the LAN and the WAN. The DMZ computer trades some of the protection of the router's security mechanisms for the convenience of being directly addressable from the Internet.", //help496
	"Bottleneck", //help446
	"Allows you to power up a computer though it's Network Interface Card", //help739
	"Determines what portion of an IP address designates the Network and which part designates the Host", //help627
	"Active Sessions", //_actsess
	"Priority 0 is reserved.", //help91a
	"Flows that are not prioritized by any rule receive lowest priority.", //help91b
	"The common choices can be selected from the drop-down menu.", //help92x1
	"To specify any other protocol, enter its protocol number (<a href=\"http://www.iana.org/assignments/protocol-numbers\" target=\"_blank\">as assigned by the IANA</a>) in the <span class=\"option\">Protocol</span> box.", //help92x2
	"When a LAN application that uses a protocol other than UDP, TCP, or ICMP initiates a session to the Internet, the router's NAT can track such a session, even though it does not recognize the protocol. This feature is useful because it enables certain applications (most importantly a single VPN connection to a remote host) without the need for an ALG.", //TA21
	"Note that this feature does not apply to the DMZ host (if one is enabled). The DMZ host always handles these kinds of sessions.", //TA22
	"are recommended.", //help183
	"Check this box to allow the DHCP Server to offer NetBIOS configuration settings to the LAN hosts.", //help400_b
	"If NetBIOS advertisement is swicthed on, switching this setting on causes WINS information to be learned from the WAN side, if available.", //help401_b
	"Configure the IP address of the preferred WINS server.", //help402_b
	"ActiveX", //help403
	"Configure the IP address of the backup WINS server, if any.", //help403_b
	"A Microsoft specification for the interaction of software components.", //help404
	"This is an advanced setting and is normally left blank.  This allows the configuration of a NetBIOS 'domain' name under which network hosts operate.", //help404_b
	"Ad-hoc network", //help405
	"Indicates how network hosts are to perform NetBIOS name registration and discovery.", //help405_b
	"Peer-to-Peer network between wireless clients", //help406
	"AppleTalk", //help417
	"A set of Local Area Network protocols developed by Apple for their computer systems", //help418
	"AppleTalk Address Resolution Protocol (AARP)", //help419
	"AARP. Used to map the MAC addresses of Apple computers to their AppleTalk network addresses, so that conversions can be made in both directions.", //help420
	"Basic Input/Output System", //help434
	"BIOS. A program that the processor of a computer uses to startup the system once it is turned on", //help435
	"Baud", //help436
	"Data transmission speed", //help437
	"BOOTP", //help444
	"Bootstrap Protocol. Allows for computers to be booted up and given an IP address with no user intervention", //help445
	"CAT 5", //help458
	"Category 5. Used for 10/100 Mbps or 1Gbps Ethernet connections", //help459
	"DB-25", //help474
	"A 25 ping male connector for attaching External modems or RS-232 serial devices", //help475
	"DB-9", //help476
	" A 9 pin connector for RS-232 connections", //help477
	"dBd", //help478
	"Decibels related to dipole antenna", //help479
	"Fiber optic", //help518
	"A way of sending data through light impulses over glass or plastic wire or fiber", //help519
	"File sharing", //help522
	"Allowing data from computers on a network to be accessed by other computers on the network with different levels of access rights", //help523
	"File Transfer Protocol. Easiest way to transfer files between computers on the Internet", //help528
	"Gain", //help531
	"The amount an amplifier boosts the wireless signal", //help532
	"Hashing", //help544
	"Transforming a string of characters into a shorter string with a predefined length", //help545
	"Hop", //help548
	"IIS", //help563
	"Internet Information Server is a WEB server and FTP server provided by Microsoft", //help564
	"Intranet", //help579
	"A private network", //help580
	"Intrusion Detection", //help581
	"A type of security that scans a network to detect attacks coming from inside and outside of the network", //help582
	"Java", //help588
	"A programming language used to create programs and applets for web pages", //help589
	"LPR/LPD", //help602
	"\"Line Printer Requestor\"/\"Line Printer Daemon\". A TCP/IP protocol for transmitting streams of printer data.", //help603
	"MDI", //help609
	"Medium Dependent Interface is an Ethernet port for a connection to a straight-through cable", //help610
	"MDIX", //help611
	"Medium Dependent Interface Crossover, is an Ethernet port for a connection to a crossover cable", //help612
	"MIB", //help613
	"Management Information Base is a set of objects that can be managed by using SNMP", //help614
	"Modem", //help615
	"A device that Modulates digital signals from a computer to an analog signal in order to transmit the signal over phone lines. It also Demodulates the analog signals coming from the phone lines to digital signals for your computer", //help616
	"OFDM", //help636
	"Orthogonal Frequency-Division Multiplexing is the modulation technique for both 802.11a and 802.11g", //help637
	"OSI", //help638
	"Open Systems Interconnection is the reference model for how data should travel between two devices on a network", //help639
	"OSPF", //help640
	"Open Shortest Path First is a routing protocol that is used more than RIP in larger scale networks because only changes to the routing table are sent to all the other routers in the network as opposed to sending the entire routing table at a regular interval, which is how RIP functions", //help641
	"Personal Area Network", //help643
	"The interconnection of networking devices within a range of 10 meters", //help644
	"PoE", //help649
	"Power over Ethernet is the means of transmitting electricity over the unused pairs in a category 5 Ethernet cable", //help650
	"RJ-11", //help672
	"The most commonly used connection method for telephones", //help673
	"RS-232C", //help676
	"The interface for serial communication between computers and other related devices", //help677
	"SOHO", //help693
	"Small Office/Home Office", //help694
	"TFTP", //help711
	"Trivial File Transfer Protocol is a utility used for transferring files that is simpler to use than FTP but with less features", //help712
	"VLAN", //help733
	"Virtual LAN", //help734
	"WDS", //help743
	"Wireless Distribution System. A system that enables the interconnection of access points wirelessly.", //help744
	"Yagi antenna", //help763
	"A directional antenna used to concentrate wireless signals on a specific location", //help764
	"Note that a log message uses the language that is in effect at the time of the logged event. If you change languages, you may see some log messages in one language and other log messages in another language.", //help795a
	"Internal", //sa_Internal
	"External", //sa_External
	"Opening or closing TCP connections.", //help823_15
	"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help831_1
	"Or you may enter a dynamic DNS service provider manually.", //help893b
	"Add/Edit Schedule Rule", //help191
	"Saves the new or edited Schedule Rule in the following list. When finished updating the Schedule Rules, you must still click the <span class=\"button_ref\">Save Settings</span> button at the top of the page to make the changes effective and permanent.", //help198
	"Unknown (Please wait...)", //_unknown_wait
	"Unknown", //_unknown
	"N/A", //_na
	"No computer information yet.", //_sdi_nciy
	"DHCP Client", //_sdi_dhcpclient
	"BigPond Client", //_sdi_bpc
	"On", //_on
	"No multicast group membership information yet.", //_bln_nmgmy
	" Incorrectly configured", //_sdi_s1
	" Status change (please wait...)", //_sdi_s10
	" Logged out", //_sdi_s8
	" Failed", //_sdi_s9
	"day(s)", //_sdi_days
	" (disconnection pending in", //_sdi_disconnectpending
	" seconds)", //_sdi_secs
	"DHCP Renew", //sd_Renew
	"DHCP Release", //sd_Release
	"Disconnect", //sd_Disconnect
	"BigPond Login", //sd_bp_login
	"BigPond Logout", //sd_bp_logout
	"Channel", //_channel
	"System Logs", //sl_SLogs
	"Print Server Status", //sps_intro2
	"printers are", //sps_pare
	"Routing Table", //sr_RTable
	"This page displays the routing details configured for your router.", //sr_intro
	"Network Traffic Stats", //ss_title_stats
	"Associated Wireless Client List", //sw_title
	"Invalid value for Admin Idle Timeout, should be in range (1..65535)", //ta_alert_1
	"Please make the two admin passwords the same and try again", //_pwsame_admin
	"Please make the two user passwords the same and try again", //_pwsame_user
	"\"Invalid remote management port '\"+data.wan_web_port+\"', should be in range (1..65535)\"", //ta_alert_3
	"The specified Dynamic DNS Service Provider is not supported", //_invalidddnsserver
	"The specified Server Address is blank", //_blankddnsserver
	"Please check the configured Server Address", //tt_alert_checkdyndns
	"The timeout value can not be less than or equal to zero.", //td_alert_2
	"The timeout value can not be greater than 8760.", //td_alert_3
	"Dynamic DNS (DDNS)", //td_DDNSDDNS
	"Select Dynamic DNS Server", //tt_SelDynDns
	"Account Name must be valid", //_emailaccnameisblank
	"From email address should not be blank", //_blankfromemailaddr
	"To email address should not be blank", //_blanktomemailaddr
	"SMTP Server address should not be blank", //_blanksmtpmailaddr
	"The Email address \"' + from_addr + '\" is not valid.", //_badfromemailaddr
	"The Email address \"' + to_addr + '\" is not valid.", //_badtoemailaddr
	" The SMTP Server Address\"' + data.smtp_email_server_addr + '\" is not valid.", //_invalidsmtpserveraddr
	" SMTP Server Address is not allowed", //_badsmtpserveraddr
	"Newer firmware version is available.", //tf_NFWA
	"The web session has timed out. Please re-login to access this page.", //tf_alert_1
	"Based on the result of checking online, the latest firmware version is:", //tf_LFWVis
	"Firmware update check is in progress.", //tf_FWCinP
	"Checking availability of new firmware", //tf_Ching_FW
	"Email notification is not enabled on Tools -> Email Settings page", //tf_EM_not
	"Latest Firmware Version", //tf_LFWV
	"Check Online Now for Latest Firmware Version", //tf_FWChNow
	"Firmware updates are released periodically to improve the functionality of your router and to add features. If you run into a problem with a specific feature of the router, check our support site by clicking on the <strong>Check Online Now for Latest Firmware Version</strong> link and see if updated firmware is available for your router.", //TA17
	"Searching for Printers...", //tps_sfp
	"Double-click on an icon to install printer", //tps_dci
	"Print Server Setup", //tps_intro2
	"\"No day is selected for schedule name '\"+(data.sched_table[i].sched_name)+\"'\"", //tsc_alert_1
	"Invalid Time", //tsc_alert_2
	"\"The schedule name '\"+(data.sched_table[i].sched_name)+\"' is reserved and can not be used\"", //tsc_alert_3
	"\"This schedule is already used\"", //tsc_alert_6
	"\"There is no room for any more entries\"", //tsc_alert_9
	"Select Day(s)", //tsc_SelDays
	"Time Frame", //tsc_TimeFr
	"\"Syslog server IP address should not be same as Gateway IP address\"", //tsl_alert_3
	"\"Syslog server IP address is in WAN subnet, it should be within LAN subnet (\"+lan_subnet+\")\"", //tsl_alert_1
	"\"Syslog server IP address should be within LAN subnet (\"+lan_subnet+\")\"", //tsl_alert_2
	"Once your router is configured the way you want it, you can save the configuration settings to a configuration file. You might need this file so that you can load your configuration later in the event that the router's default settings are restored. To save the configuration, click the <strong>Save Configuration</strong> button.", //TA18
	"milliseconds. TTL =", //tsc_pingt_msg9
	"NTP Server is not configured", //tt_alert_nontp
	"Gateway Time has been updated", //tt_alert_tupdt
	"Week", //TA24
	"Day of Week", //TA25
	"Forbidden Access", //fb_FbAc
	"Sentinel Blocked Web Access", //sentinel_1
	"Access to this Web site has been blocked on this computer by your router's Sentinel Service.", //sentinel_2
	"Contact your Sentinel Service Administrator to enable access to this page.", //sentinal_3
	"Failure", //fl_Failure
	"The new settings have NOT been saved because an error occurred.", //fl_text
	"A new firmware update is available. You will be directed to the upgrade page upon login.", //li_newfw
	"You will now be redirected to the login page.", //rd_p_1
	"If the login page does not appear, click <a href=\"/login.asp\">this link</a>.", //rd_p_2
	"Restoring Settings", //rs_Restoring_Settings
	"The settings file is invalid.", //reh
	"Restoring Settings, Please Wait", //rs_RSPW
	"Converted local data", //rs_cld
	"Done", //rs_Done
	"Unpacked local data", //rs_uld
	"Unpacked saved data", //rs_usd
	"Converted saved data", //rs_csd
	"Repacked", //rs_Repacked
	"Converted", //rs_Converted
	"Saving", //rs_Saving
	"The router must be rebooted before the new settings will take effect. You can reboot the router now using the button below, or make other changes and then use the reboot button on the Tools/System page.", //sc_intro_rb
	"Re-login", //_relogin
	"Invalid WAN subnet mask.", //_badWANsub
	"Invalid Gateway IP address.", //wwa_pv5_alert_4
	"The gateway IP address is not in the WAN subnet", //wwa_pv5_alert_5
	"You must specify the primary DNS server", //wwa_pv5_alert_8
	"Invalid Primary DNS IP address.", //wwa_pv5_alert_6
	"Invalid Secondary DNS IP address.", //wwa_pv5_alert_7
	"The User Name field can not be blank", //wwa_pv5_alert_21
	"Invalid PPTP Gateway IP Address", //_badPPTPgwip
	"Invalid PPTP Server address", //wwa_pv5_alert_15
	"Invalid L2TP Gateway IP Address", //_badL2TPgwip
	"Invalid L2TP Server address", //wwa_pv5_alert_20
	"In order to protect your network from hackers and unauthorized users, it is highly recommended you choose one of the following wireless network security settings.", //wwl_intro_s3_1
	"There are three levels of wireless security -Good Security, Better Security, AND Best Security. The level you choose depends on the security features your wireless adapters support.", //wwl_intro_s3_2r
	"Wireless Security Password", //wwl_WSP_1
	"WPA-PSK/TKIP (also known as WPA Personal)", //wwl_wpa
	"WPA2-PSK/AES (also known as WPA2 Personal)", //wwl_wpa2
	"TELNET", //gw_vs_0
	"REMOTE DESKTOP", //gw_vs_8
	"AIM Talk", //gw_sa_0
	"Calista IP phone", //gw_sa_2
	"ICQ", //gw_sa_3
	"MSN Messenger", //gw_sa_4
	"PalTalk", //gw_sa_5
	"Select BigPond Server", //gw_SelBPS
	"Name1", //gw_bp_0
	"Name2", //gw_bp_1
	"Name3", //gw_bp_2
	"Please accept and install the ActiveX, then try it again.", //gw_wcn_alert_3
	"WCN ActiveX control is not available. Please check the security setting and refresh this page to install it.", //gw_wcn_alert_4
	"WCN does not support key index other than 1 now.", //gw_wcn_alert5
	"WCN does not support WPA2 mode now.", //gw_wcn_alert6
	"WCN does not support WPA enterprise authentication now.", //gw_wcn_alert7
	"Wireless settings saved successfully", //gw_wcn_err_ok
	"Error code:", //gw_wcn_err_code
	"This version of the operation system does not support WCN", //gw_wcn_err_os_version
	"Loading the Wireless Configuration file failed. Please run Windows Wireless Network Setup Wizard to create/re-create the configuration file", //gw_wcn_err_load_config
	"Failed to add the wireless profile. Please make sure that the new SSID does not conflict with an existing profile", //gw_wcn_err_provision
	"Failed to write wireless data in to configuration file. Please check the security setting", //gw_wcn_err_io_write_config
	"Failed to encrypt wireless data.", //gw_wcn_err_encryption
	"Internal exception occured", //gw_wcn_err_exception
	"WCN ActiveX control is not registered. Please check the security setting and refresh this page to install it.", //gw_wcn_err_com
	"Invalid wireless settings. Please check wireless settings", //gw_wcn_err_bad_wsetting_entry
	"Cannot create the wirless profile XML file", //gw_wcn_err_bad_wps_profile
	"WPA security mode is not enabled. Please check WPA security settings", //gw_wcn_err_unsupported_wsetting
	"MSXML2 DOM parser failed to parse the string in XML format", //gw_wcn_err_dom_processing
	"Unexpected error", //gw_wcn_err_default
	"Everyone allowed", //adv_Everyone
	"No one allowed", //adv_Noone
	"Queued", //psQueued
	"Starting", //psStarting
	"Closed", //psClosed
	"Idle", //psIdle
	"Ready", //psReady
	"Offline", //psOffline
	"Unplugged", //psUnplugged
	"Printing", //psPrinting
	"Paper Error", //psPaperError
	"'The string \"' + value + '\" is too long\n(maximum length is ' + length + ' characters).'", //up_gS_1
	"'The number \"' + value + '\" is not valid.'", //up_gIUH_1
	"'The number \"' + value + '\" must be positive.'", //up_gIUH_2
	"'The number \"' + value + '\" should be in between '+ min + ' to ' + max + '.'", //up_gIUH_3
	"'The hex string \"' + value + '\" is not valid.'", //up_gH_1
	"There is no room for any more entries.", //up_ae_se_1
	"The '%s' field can not be blank", //up_ai_se_2
	"this.primary_key_name+\" '\"+ this.thearray[-1][this.primary_key] +\"' is already used\"", //up_ae_se_3
	"You have unsaved changes in the entry you are editing.", //up_ae_wic_1
	"Press 'Ok' to abandon these changes and perform the requested action.", //up_ae_wic_2
	"Nothing has changed on this page. Do you want to save it anyway?", //up_nosave
	"Do you want to abandon all changes you made to this page?", //up_fm_dc_1
	"The restoration of settings failed", //up_fm_re_1
	"Press OK to continue", //up_fm_re_2
	"bad settings file", //up_fm_dr_1
	"Bad settings file", //up_fm_dr_2
	"Restored data not acceptable", //up_fm_dr_3
	"The action can not complete because the network connection seems to be down", //up_if_1
	"Rebooting.", //up_rb_3
	"Resetting to factory defaults and rebooting.", //up_rb_6
	"\"The \"+name+\" port range string '\"+input_string+\"' is invalid.\"", //up_vp_1
	"\"The \"+name+\" port '\"+n+\"' in the port range string '\"+input_string+\"' should be in between 1 to 65535.\"", //up_vp_2
	"\"The \"+name+\" port range'\"+got2[0]+\"' in the port range string '\"+input_string+\"' should go from low port to high port.\"", //up_vp_3
	"\"The \"+name+\" port range string can't be empty.\"", //up_vp_0
	"A MAC address field can not be empty.", //up_vm_1
	"input_string+\" is not a valid MAC address\"", //up_vm_2
	"\"An error occurred on this page. This might be because you are\n\"+ \"not properly logged in, for example just after a reboot.\n\"", //up_he_1
	"\"Press OK to go to the login page, or Cancel if you want to see\n\"+ \"the error message.\"", //up_he_2
	"\"The error on line \"+line+\" of \"+url+\" is:\n\"\"+msg+\"\".\"", //up_he_5
	"PAP authentication failed - please check login details.", //IPPPPPAP_AUTH_FAIL
	"Blocked packet from %v to %v that was received from the wrong network interface (IP address spoofing)", //IPSTACK_REJECTED_SPOOFED_PACKET
	"Lease assignment attempt fail - detected a LAN host active with address %v and MAC of %m", //IPDHCPSERVER_HOST_IS_ACTIVE
	"%S service authorization failed: service is unregistered", //BSECURE_LOG_AUTH_FAIL_UNREG
	"Estimated rate of link is %d kbps", //RATE_ESTIMATOR_RATE_IS
	"Filter - Denied packet from IP address %v port %u, protocol %u, to %v port %u", //GW_IPFILTER_DENY
	"Unable to create connection to email server", //GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION
	"Dropped packet to illegal destination %v from %v", //IPNAT_ILLEGAL_DEST
	"%S filter server disconnected: timeout", //BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT
	"The client %02x:%02x:%02x:%02x:%02x:%02x had its lease (%v) revoked.", //IPDHCPSERVER_LEASE_REVOKED1
	"Previous message repeated 1 time", //LOG_PREV_MSG_REPEATED_1_TIME
	"UPnP changed VS entry %v <-> %v:%d <-> %v:%d %S to %S", //GW_UPNP_PORTMAP_VS_CHANGE
	"Lease expired %v", //IPDHCPSERVER_LEASE_EXPIRED
	"%S service authorization failed: internal error", //BSECURE_LOG_AUTH_FAIL_INTNL
	"UPnP deleted entry %v <-> %v:%d %S", //GW_UPNP_PORTMAP_DEL
	"Unable to send email as \"%s\" is not a valid \"To:\" address", //GW_SMTP_EMAIL_INVALID_TO_ADDRESS
	"%S filter server disconnected: closed", //BSECURE_LOG_FLTR_DISCONNECTED_CLOSED
	"Lease expired %v - was reassigned because a client specifically requested this address", //IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC
	"%S service authorization passed", //BSECURE_LOG_AUTH_PASS
	"%S service authorization failed: auth server returned UNKNOWN error", //BSECURE_LOG_AUTH_FAIL_UNKNW
	"PAP sent authentication \"%s\" response to remote peer.", //IPPPPPAP_AUTH_RESULT
	"%S service authorization failed: service needs renewal", //BSECURE_LOG_AUTH_FAIL_RENEW
	"Client %m wanted specific address (%v) but it is not available", //IPDHCPSERVER_LEASE_DENIED
	"Unable to send email (connection timed out)", //GW_SMTP_EMAIL_TIMEOUT
	"%S service authorization failed: auth server returned DB error", //BSECURE_LOG_AUTH_FAIL_DB
	"DHCP Server Parameter %u was updated", //IPDHCPSERVER_PARAM_DB_UPDATED
	"Application Rules", //APP_RULES
	"Lease table full", //IPDHCPSERVER_LEASE_POOL_FULL
	"PAP authentication timed out - authentication failed.", //IPPPPPAP_AUTH_TIMEOUT
	"Advanced Networks", //ADVANCED_NETWORKS
	"Assigned new lease %v to client %m", //IPDHCPSERVER_LEASE_ASSIGNED
	"%S filter server connected", //BSECURE_LOG_FLTR_CONNECTED
	"%S auth server connected", //BSECURE_LOG_AUTH_CONNECTED
	"%S service authorization failed: auth response packet corrupted", //BSECURE_LOG_AUTH_FAIL_PKT
	"SMTP client failed to connect to server %v", //IPSMTPCLIENT_CONN_FAILED
	"PAP authentication successful.", //IPPPPPAP_AUTH_SUCCESS
	"Latest firmware version retrieved from the server was %d.%d", //GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED
	"Unable to send email (send status %u)", //GW_SMTP_EMAIL_SEND_FAILURE
	"Lease %v released by client %m", //IPDHCPSERVER_LEASE_RELEASED
	"DHCP Server Parameter %u was added to the parameter database", //IPDHCPSERVER_PARAM_DB_ADDED
	"PAP issued an authentication request.", //IPPPPPAP_AUTH_ISSUE
	"UPnP added entry %v <-> %v:%d <-> %v:%d %S timeout:%d '%s'", //GW_UPNP_PORTMAP_ADD
	"Unable to send email as server IP address is not known", //GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS
	"UPnP renew entry %v <-> %v:%d <-> %v:%d %S timeout:%d '%s'", //GW_UPNP_PORTMAP_REFRESH
	"UPnP expired entry %v <-> %v:%d <-> %v%d %S '%s'", //GW_UPNP_PORTMAP_EXPIRE
	"DHCP Server Parameter %u was removed from the parameter database", //IPDHCPSERVER_PARAM_DB_REMOVED
	"Lease was deleted from server pool %v", //IPDHCPSERVER_LEASE_DELETED
	"UPnP conflict with existing entry %v <-> %v:%d <-> %v:%d %S '%s'", //GW_UPNP_PORTMAP_CONFLICT
	"Not all of the needed components have been loaded; this page will refresh.", //TA1
	"is not a valid IP address", //aa_alert_11
	"\"This Access Control rule is already defined by the Policy \" + data.access_ctrl_table[i].policy_name", //aa_alert_1
	"There are \" + unsaved_policies + \" unsaved policies, do you want to abandon these policies.", //aa_sched_conf_3
	"'The Port Filter rule \"' + data.access_ctrl_table[-1].port_filter_table[i].entry_name + '\" is duplicated.'", //aa_alert_16
	"\"Destination IP Start address for Port Filter = '\"+data.access_ctrl_table[-1].port_filter_table[j].entry_name+\"' should not be in LAN subnet (\"+lan_subnet+\")\"", //aa_alert_2
	"\"Destination IP End address for Port Filter = '\"+data.access_ctrl_table[-1].port_filter_table[j].entry_name+\"' should not be in LAN subnet (\"+lan_subnet+\")\"", //aa_alert_3
	"\"Invalid destination IP address range for Port Filter = '\"+data.access_ctrl_table[-1].port_filter_table[j].entry_name+\"'\"", //aa_alert_4
	"\"Invalid destination port range for Port Filter = '\"+data.access_ctrl_table[-1].port_filter_table[j].entry_name+\"' should be in range (1..65535)\"", //aa_alert_5
	"\"Destination start port for Port Filter = '\"+data.access_ctrl_table[-1].port_filter_table[j].entry_name+\"' should not be greater than destination end port\"", //aa_alert_6
	"Others", //aa_AT_2
	"Copyright &copy; 2004-2011 D-Link Corporation, Inc.", //_copyright
	"The valid range for fragmentation threshold is 256..65535", //aw_alert_1
	"The valid range for RTS threshold is 1..65535", //aw_alert_2
	"The valid range for beacon period is 20..1000", //aw_alert_3
	"The valid range for DTIM interval is 1..255", //aw_alert_4
	"\"DMZ address should be within LAN subnet (\"+lan_subnet+\")\"", //af_alert_1
	"\"DMZ Address is not allowed\"", //af_alert_2
	"(automatically disabled if UPnP is enabled)", //TA19
	"This '\"+ data.game_rules[j].entry_name + \"' record is already present.", //ag_alert_4
	"This '\"+ data.game_rules[j].entry_name + \"' record is duplicate of '\" + data.game_rules[i].entry_name + \"'.", //ag_alert_5
	"'TCP ports ['+data.game_rules[i].tcp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' TCP ports ['+data.game_rules[j].tcp_ports_to_open+']'", //ag_conflict10
	"'UDP ports ['+data.game_rules[i].udp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' UDP ports ['+data.game_rules[j].udp_ports_to_open+']'", //ag_conflict20
	"\"Please select a schedule for record '\" + data.game_rules[i].entry_name + \"'.\"", //ag_conflict21
	"\"IP address for '\"+data.game_rules[i].entry_name+\"' should be within LAN subnet (\"+lan_subnet+\")\"", //ag_alert_1
	"\"IP Address for '\"+data.game_rules[i].entry_name+\"' is not allowed\"", //ag_alert_3
	"Both 'TCP Ports to Open' and 'UDP Ports to Open' fields can not be blank", //ag_alert2
	"TCP ports", //_tcpports
	"UDP ports", //_udpports
	"%s ports[%s] conflicts with Remote Management Port", //ag_conflict4
	"\"You can not change name of this entry because it is used on the \"+used_page+\" page.\"", //tsc_alert_7
	"\"Invalid source IP Range for '\"+data.ingress_rules[i].ingress_filter_name+\"'\"+\" (\"+data.ingress_rules[i].ip_range_table[j].ip_start+\",\"+data.ingress_rules[i].ip_range_table[j].ip_end+\")\"", //ai_alert_3
	"Enable at least one Source IP Range for %s.", //ai_alert_5
	"The inbound filter range '%s - %s' is duplicated.", //ai_alert_7
	"The inbound filter name '%s' is reserved and can not be used", //ai_alert_4
	"'The inbound filter rule \"' + data.ingress_rules[-1].ingress_filter_name + '\" is duplicated.'", //ai_alert_6
	"\"You can not delete this entry because it is used on the \"+x+\" page.\"", //tsc_alert_5
	"Inbound Filter Rules", //ai_title_2
	"Edit", //_edit
	"Source IP Range", //_srcip
	"Source IP Start", //ai_c2
	"Source IP End", //ai_c3
	"'The \"' + saved_records[i].mac_addr + '\" MAC address is duplicate.'", //amaf_alert_1
	"Deny access to all except the machines in this list (subject to \"Filter Settings\"):", //am_cMT_deny
	"Allow access to all except the machines in this list (subject to \"Filter Settings\"):", //am_cMT_Allow
	"No routes information yet.", //_sr_nriy
	"This internal route is already used", //ar_alert_1
	"This Route is already Present", //ar_alert_2
	"Metric value should be in between (1..16).", //ar_alert_3
	"Next Hop not on the specified interface", //ar_alert_4
	"Invalid Netmask.", //ar_alert_5
	"The Routing option allows you to define fixed routes to defined destinations.", //ar_RoutI
	"Route", //ar_Route
	"Routes List", //ar_RoutesList
	"Delete", //_delete
	"Existing routes", //ar_ERTable
	"\"The Application Rules name '\" + saved_records[i].entry_name + \"' is duplicated.\"", //ag_alert_duplicate_name
	"\"The Application Rules name '\" + saved_records[j].entry_name + \"' is duplicate of '\" + saved_records[i].entry_name + \"'\"", //ag_alert_duplicate
	"This Rule is already used", //ag_inuse
	"'Trigger port range '+protocols[ae.thearray[-1].trigger_ports.protocol]+' ['+ae.thearray[-1].trigger_ports.port_range+'] conflicts with '+saved_records[i].entry_name+':'+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+']'", //_specapps_alert_2
	"Trigger port range", //_specapps_tpr
	"Input port range", //_specapps_ipr
	"Special Applications Rule", //as_title_SAR
	"Trigger Port Range", //as_TPRange
	"ex.", //as_ex
	"Trigger Protocol", //as_TPR
	"Input Port Range", //as_IPR
	"Input Protocol", //as_IPrt
	"Max transmission rate should be between 8 kbps and 1024 Mbps, inclusive.", //at_alert_1_1
	"'Name can not be blank.'", //at_alert_15
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Priority '+data.qos_rules[i].priority+' should be between 1 and 255, inclusive.'", //at_alert_16
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Protocol can not be blank.'", //at_alert_17
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source IP Range \"'+data.qos_rules[i].source_ip_start+'\" should be within LAN subnet ('+lan_subnet+').'", //at_alert_2
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source IP Range \"'+data.qos_rules[i].source_ip_start+'\" is invalid.'", //at_alert_18
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source IP Range \"'+data.qos_rules[i].source_ip_end+'\" should be within LAN subnet ('+lan_subnet+').'", //at_alert_3
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source IP Range \"'+data.qos_rules[i].source_ip_end+'\" is invalid.'", //at_alert_19
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source IP Range is invalid.'", //at_alert_4
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination IP Range \"'+data.qos_rules[i].dest_ip_start+'\" should not be within LAN subnet ('+lan_subnet+').'", //at_alert_5
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination IP Range \"'+data.qos_rules[i].dest_ip_start+'\" is invalid.'", //at_alert_20
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination IP Range \"'+data.qos_rules[i].dest_ip_end+'\" should not be within LAN subnet ('+lan_subnet+').'", //at_alert_6
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination IP Range \"'+data.qos_rules[i].dest_ip_end+'\" is invalid.'", //at_alert_21
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination IP Range is invalid.'", //at_alert_8
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Source Port Range should be between 0 and 65535, inclusive.'", //at_alert_7
	"'Source Port start for rule \"'+data.qos_rules[i].entry_name+'\" should be less than Source Port end.'", //at_alert_10
	"'Rule \"'+data.qos_rules[i].entry_name+'\" Destination Port Range should be between 0 and 65535, inclusive.'", //at_alert_9
	"'Destination Port start for rule \"'+data.qos_rules[i].entry_name+'\" should be less than Destination Port end.'", //at_alert_11
	"'Name \"'+data.qos_rules[i].entry_name+'\" is already used.'", //at_alert_22
	"'Source/Destination IP Range for \"'+data.qos_rules[j].entry_name+'\" is overlapped with \"'+data.qos_rules[i].entry_name+'\".'", //at_alert_23
	"'Source/Destination IP/Port Range for \"'+data.qos_rules[j].entry_name+'\" is overlapped with \"'+data.qos_rules[i].entry_name+'\".'", //at_alert_24
	"'Protocol \"ANY\" includes ICMP so port ranges are disabled. Select TCP or UDP if you want to configure port ranges.'", //at_alert_14
	"ANY", //at_Prot_0
	"Source Port Range", //_srcport
	"Destination IP Range", //at_DIPR
	"Destination Port Range", //at_DPR
	"\"The record '\" + data.virtual_servers[i].entry_name + \"' is duplicated.\"", //av_alert_11
	"The record '\" + data.virtual_servers[j].entry_name + \"' is duplicate of '\" + data.virtual_servers[i].entry_name + \"'.", //av_alert_21
	"\"Please select a schedule for record '\" + data.virtual_servers[i].entry_name + \"'.\"", //av_alert_24
	"\"IP address for '\" + data.virtual_servers[i].entry_name + \"' should be within LAN subnet (\"+lan_subnet+\")\"", //av_alert_1
	"\"IP address for '\" + data.virtual_servers[i].entry_name + \"' is not allowed\"", //av_alert_2
	"\"Private port for '\" + data.virtual_servers[i].entry_name + \"' should be in range (1..65535)\"", //av_alert_3
	"\"Public port for '\" + data.virtual_servers[i].entry_name + \"' should be in range (1..65535)\"", //av_alert_4
	"\"Public port should not be same as Remote Management Port\"", //av_alert_12
	"\"Cannot create an entry for ICMP (protocol 1) as this will prevent the router from working correctly\"", //av_alert_18
	"\"Cannot create an entry for IGMP (protocol 2) as this will prevent the router from working correctly\"", //av_alert_23
	"\"Please select TCP instead of protocol 6 and specify port details\"", //av_alert_19
	"\"Please select UDP instead of protocol 17 and specify port details\"", //av_alert_20
	"\"Other protocol for '\" + data.virtual_servers[i].entry_name + \"' should be in range (3..5, 7..16 or 18..255)\"", //av_alert_13
	"\"Protocol for '\" + data.virtual_servers[i].entry_name + \"' is overlapped with '\" + data.virtual_servers[j].entry_name+\"'\"", //av_alert_17
	"Ports for '\" + data.virtual_servers[i].entry_name + \"' are overlapped with '\" + data.virtual_servers[j].entry_name+\"'", //av_alert_5
	"Private Port for '\" + data.virtual_servers[i].entry_name + \"' conflicts with '\" + data.virtual_servers[j].entry_name+\"'", //av_alert_6
	"FTP ALG has been enabled", //av_alert_7
	"PPTP ALG has been enabled", //av_alert_8
	"Wake-On-LAN ALG has been enabled", //av_alert_9
	"H.323 ALG has been enabled", //av_alert_10
	"Public", //_public
	"Other", //_other
	"Private", //_private
	"Web Site", //aa_WebSite
	"https is not a supported protocol.", //awf_alert_4
	"The web site address '%s' already used.", //awf_alert_5
	"The web site addresses: \"' + invalid_wf_str + '\" are invalid.", //awf_alert_7
	"'The web site address: \"' + invalid_wf_str + '\" is invalid.'", //awf_alert_8
	"Internet Connection Wizard", //int_ConWz2
	"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new DLink Router to the Internet, as well as configure the Wireless settings, click on the Setup Wizard button below.", //int_intro_ConWz
	"Manual Internet Connection Options", //int_WlsWz
	"If you would like to configure the Internet settings of your new DLink Router manually, then click on the Manual Configure button below.", //int_intro_WlsWz
	"If you are new to networking and have never configured a router before, click on <strong>Setup Wizard</strong> and the router will guide you through a few simple steps to get your network up and running.", //hhbi_wiz
	"If you consider yourself an advanced user and have configured a router before, click <strong>Manual Configure</strong> to input all the settings manually.", //hhbi_man
	"No dynamic clients detected yet.", //bd_noneyet
	"The lease has been revoked", //bd_revoked
	"Invalid LAN IP address", //bln_alert_3
	"LAN subnet conflicts with WAN subnet", //bd_alert_10
	"\"The DHCP address range TO is not in the LAN subnet.\"", //bd_alert_11
	"\"The DHCP FROM address does not contain a valid host starting value.\"", //bd_alert_1
	"The DHCP address range should go from a low address to a high address, not high to low", //bd_alert_3
	"The DHCP address range must not include the subnet broadcast address.", //bd_alert_13
	"The number of IP addresses in the range exceeds a limit of 256.", //bd_alert_12
	"DHCP Lease Time can not be 0", //bd_alert_5
	"\"Reserved IP address for this MAC address (\"+ae.thearray[-1].mac_addr+\") is already set\"", //bd_alert_6
	"\"Reserved IP address for this Computer Name (\"+ae.thearray[-1].comp_name+\") is already set\"", //bd_alert_7
	"A reservation cannot be the same as the configured LAN IP Address.", //TA20
	"\"Reserved IP address should be within the configured DHCP range.\"", //bd_alert_8
	"Must specify primary DNS server before supplying a secondary DNS server", //bd_alert_22
	"Invalid Primary dns IP address", //bd_alert_23
	"Invalid Secondary dns IP address", //bd_alert_24
	"Invalid WAN IP address", //_badWANIP
	"Invalid WAN subnet mask", //bwn_alert_2
	"The default gateway address is not in the WAN subnet", //bwn_alert_3
	"DNS are not configured. The clients will not be able to resolve domain names. Proceed ?", //bwn_alert_4
	"WAN subnet conflicts with LAN subnet", //bwn_alert_5
	"Please enter a user name and try again", //_nousername
	"The maximum idle time should be in the range 0..600", //bwn_alert_8
	"Invalid PPPoE IP address", //bwn_alert_12
	"Invalid PPTP IP address", //_badPPTPip
	"Invalid PPTP subnet mask", //_badPPTPsub
	"The PPTP gateway IP address is not in the PPTP subnet", //_badPPTPipsub
	"Invalid PPTP Server IP address", //bwn_alert_11
	"Invalid L2TP address", //_badL2TP3
	"Invalid L2TP subnet mask", //_badL2TP
	"The L2TP gateway IP address is not in the L2TP subnet", //_badL2TP2
	"Invalid L2TP Server IP address", //bwn_alert_17
	"The MTU should be in the range 128..30000", //bwn_alert_21
	"\"WEP Keys \"+ wep_error_msg + \" are invalid.\"", //bws_alert_15
	"\"WEP Key \"+ wep_error_msg + \" is invalid.\"", //bws_alert_16
	"Can not use 802.11b/g channel when the 802.11 mode is 802.11a", //bwl_alert_2
	"Can not use 802.11a channel when the 802.11 mode is 802.11b/g", //bwl_alert_3
	" RADIUS server Port field can not be blank.", //bwl_alert_15
	" RADIUS server Port ' + data.wireless.radius_server_port + ' should be in range (1..65535).", //bwl_alert_16
	"Can not use 802.11b transmit rates when the PHY mode is 802.11a", //bwl_alert_4
	"Can not use 802.11a/g transmit rates when the PHY mode is 802.11b", //bwl_alert_5
	"Static Turbo mode is not allowed with 802.11b", //bwl_alert_6
	"Dynamic Turbo mode is not allowed with 802.11b", //bwl_alert_7
	"For 11g Turbo mode, the channel should be set to 6", //bwl_alert_8
	"For 11a Static Turbo, channel should be set to one of 42,50,58,152, or 160.", //bwl_alert_9
	"For 11a Dynamic Turbo, channel should be set to one of 40,48,56,153 or 161.", //bwl_alert_10
	"Incorrect key length, should be 8 to 63 character long.", //bws_alert_2
	"WPA Group Key Update Interval should be between 30 and 65535 seconds.", //bwl_alert_11
	"IEEE 802.1X Authentication Timeout should be between 1 and 65535 minutes", //bwl_alert_12
	"\"WEP key \"+(i+1)+\" must be \"+len+\" characters long\"", //bws_alert_3
	"Uncheck 'Auto Channel Select' for WDS mode.", //aw_alert_5_1
	"'The IP address \"' + data.wireless.radius_server_address + '\" is not valid.'", //bwl_alert_13
	"'The IP address \"' + data.wireless.second_radius_server_address + '\" is not valid.'", //bwl_alert_14
	"802.11g only", //bwl_Mode_2
	"Mixed 802.11g and 802.11b", //bwl_Mode_3
	"802.11b only", //bwl_Mode_1
	"802.11n only", //bwl_Mode_8
	"Mixed 802.11n, 802.11g and 802.11b", //bwl_Mode_11
	"20 MHz", //bwl_ht20
	"Auto 20/40 MHz", //bwl_ht2040
	"Best (automatic)", //bwl_TxR_0
	"Changing your Wireless Network Name is the first step in securing your wireless network. Change it to a familiar name that does not contain any personal information.", //TA9
	"Enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //TA11
	"Setting Visibility Status to Invisible is another way to secure your network. With visibility disabled, no wireless clients will be able to see your wireless network when they scan to see what's available. For your wireless devices to connect to your router, you will need to manually enter the Wireless Network Name on each device.", //TA12
	"If you have enabled Wireless Security, make sure you write down the Passphrase that you have configured.", //TA14
	"You will need to enter this information on any wireless device that you connect to your wireless network.", //TA15
	"Wizard", //_wizard
	"The D-Link RangeBooster N&trade; 650 Router powered by QoS Engine&trade; technology meets the demands of individuals who demand powerful and reliable performance for the ultimate online gaming experience.", //bwz_intro
	"The following Web-based Setup Wizard is designed to assist you in connecting your new D-Link Router to the Internet. This Setup Wizard will guide you through step-by-step instructions on how to get your Internet connection up and running. Click the button below to begin.", //bwz_intro_ConWz
	"Launch Internet Connection Setup Wizard", //bwz_LConWz
	"Wireless Security Setup Wizard", //bwz_WlsWz
	"The following Web-based Setup Wizard is designed to assist you in your wireless network setup. This Setup Wizard will guide you through step-by-step instructions on how to set up your wireless network and how to make it secure.", //bwz_intro_WlsWz
	"Launch Wireless Security Setup Wizard", //bwz_LWlsWz
	"Special Applications", //_specapps
	"Gaming", //_gaming
	"Basic", //_basic
	"\"The rule name can not be empty.\"", //ag_alert_empty_name
	"\"The rule name '\" + data.game_rules[j].entry_name + \"' is duplicated.\"", //ag_alert_duplicate_name2
	"'MAC Address Filter allows no machines. This is not allowed because it locks out all machines.'", //amaf_alert_2
	"\"The rule name '\" + saved_records[i].entry_name + \"' is duplicated.\"", //specapps_alert_duplicate_name
	"\"The rule '\" + saved_records[j].entry_name + \"' is duplicate of '\" + saved_records[i].entry_name + \"'.\"", //specapps_alert_duplicate1
	"\"Trigger port range of '\"+saved_records[i].entry_name+\"' \"+protocols[saved_records[i].trigger_ports.protocol]+\" [\"+saved_records[i].trigger_ports.port_range+\"] conflicts with '\"+saved_records[j].entry_name+\"' \"+protocols[saved_records[j].trigger_ports.protocol]+\" [\"+saved_records[j].trigger_ports.port_range+\"].\"", //specapps_alert_conflict1
	"\"Please select a schedule for rule '\" + data.port_trigger_rules[i].entry_name + \"'.\"", //specapps_alert_empty_schedule
	"Traffic Shaping Setup", //at_title_TSSet
	"Protocol \" + entry_1.user_protocol + \" of '\" + entry_1.entry_name + \"' conflicts with '\" + entry_2.entry_name + \"'", //av_alert_35
	"The 'Name' field can not be blank", //av_alert_empty_name
	"Name (%s) is already used.", //av_alert_16
	"Primary WINS IP address must be specified.", //bln_alert_lannbpri
	"Secondary WINS IP address is invalid.", //bln_alert_lannbsec
	"Primary DNS", //lan_dns
	"Secondary DNS", //lan_dns2
	"Hybrid (Point-to-Point then Broadcast)", //bln_NetBIOSReg_H
	"Mixed-mode (Broadcast then Point-to-Point)", //bln_NetBIOSReg_M
	"Point-to-Point (no broadcast)", //bln_NetBIOSReg_P
	"Broadcast only (use when no WINS servers configured)", //bln_NetBIOSReg_B
	"Help", //_help
	"When this option is enabled, the router restricts the flow of outbound traffic so as not to exceed the WAN uplink bandwidth.", //help81ets
	"The NAT Endpoint Filtering options control how the router's NAT manages incoming connection requests to ports that are already being used.", //af_EFT_h4
	"Once a LAN-side application has created a connection through a specific port, the NAT will forward any incoming connection requests with the same port to the LAN-side application regardless of their origin. This is the least restrictive option, giving the best connectivity and allowing some applications (P2P applications in particular) to behave almost as if they are directly connected to the Internet.", //af_EFT_h0
	"The NAT forwards incoming connection requests to a LAN-side host only when they come from the same IP address with which a connection was established. This allows the remote application to send data back through a port different from the one used when the outgoing session was created.", //af_EFT_h1
	"The NAT does not forward any incoming connection requests with the same port address as an already establish connection.", //af_EFT_h2
	"Note that some of these options can interact with other port restrictions. Endpoint Independent Filtering takes priority over inbound filters or schedules, so it is possible for an incoming session request related to an outgoing session to enter through a port in spite of an active inbound filter on that port. However, packets will be rejected as expected when sent to blocked ports (whether blocked by schedule or by inbound filter) for which there are no active sessions. Port and Address Restricted Filtering ensures that inbound filters and schedules work precisely, but prevents some level of connectivity, and therefore might require the use of port triggers, virtual servers, or port forwarding to open the ports needed by the application. Address Restricted Filtering gives a compromise position, which avoids problems when communicating with certain other types of NAT router (symmetric NATs in particular) but leaves inbound filters and scheduled access working as expected.", //af_EFT_h5
	"Controls endpoint filtering for packets of the UDP protocol.", //af_UEFT_h1
	"Controls endpoint filtering for packets of the TCP protocol.", //af_TEFT_h2
	"The subnet mask of the local area network.", //help309A
	"NetBIOS allow LAN hosts to discover all other computers within the network, e.g. within Network Neighbourhood.", //help400_1
	"Turn this setting off to configure manually.", //help401_1
	"WINS Servers store information regarding network hosts, allowing hosts to 'register' themselves as well as discover other available hosts, e.g. for use in Network Neighbourhood.", //help402_1
	"This setting has no effect if the 'Learn NetBIOS information from WAN' is activated.", //help402_2
	"H-Node, this indicates a Hybrid-State of operation. First WINS servers are tried, if any, followed by local network broadcast. This is generally the preferred mode if you have configured WINS servers.", //help405_1
	"M-Node (default), this indicates a Mixed-Mode of operation. First Broadcast operation is performed to register hosts and discover other hosts, if broadcast operation fails, WINS servers are tried, if any. This mode favours broadcast operation which may be preferred if WINS servers are reachable by a slow network link and the majority of network services such as servers and printers are local to the LAN.", //help405_2
	"P-Node, this indicates to use WINS servers ONLY. This setting is useful to force all NetBIOS operation to the configured WINS servers. You must have configured at least the primary WINS server IP to point to a working WINS server.", //help405_3
	"B-Node, this indicates to use local network broadcast ONLY. This setting is useful where there are no WINS servers available, however, it is preferred you try M-Node operation first.", //help405_4
	" Incorrectly configured - check logs", //_sdi_s1a
	"\"Invalid secure remote management port '\"+data.web_server_wan_port_https+\"', should be in range (1..65535)\"", //ta_alert_3b
	"\"Secure remote management port and remote management port may not be the same.\"", //ta_alert_3c
	"\"You must enable one method of management.\"", //ta_alert_3d
	"\"Invalid management port '\"+data.web_server_lan_port_http+\"', should be in range (1..65535)\"", //ta_alert_3e
	"\"Invalid secure management port '\"+data.web_server_lan_port_https+\"', should be in range (1..65535)\"", //ta_alert_3f
	"\"Secure management port and management port may not be the same.\"", //ta_alert_3g
	"Enable Management", //ta_ELM
	"Admin Port", //ta_LMAP
	"Failed Login", //fb_FailLogin
	"Access to this device is not allowed without a correct password.", //fb_FailLogin_1
	"Open", //open
	"Other", //at_Prot_1
	"Expire Time", //_223
	"The gateway address is not in the LAN subnet", //_225ap
	"IP address or subnet mask is badly formatted", //_226ap
	"This entry is optional. Enter a domain name for the local network. Your LAN computer will assume this domain name when it gets an address from the <span>rou</span><span>ter</span>'s built in DHCP server. So, for example, if you enter <code>mynetwork.net</code> here, and you have a LAN side laptop with a name of <code>chris</code>, that laptop will be known as <code>chris.mynetwork.net</code>.", //_1044wired
	"Note, however, the entered domain name can be overridden by the one obtained from the <span>rou</span><span>ter</span>'s upstream DHCP server.", //_1044awired
	"IPv6 address", //TEXT0
	"Regenerate", //regenerate
	"Advanced DNS Service", //_title_AdvDns
	"Advanced DNS is a free security option that provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //_desc_AdvDns
	"Enable Advanced DNS Service", //_en_AdvDns
	"Advanced DNS", //_st_AdvDns
	"Advanced DNS", //_sp_title_AdvDNS
	"When feature is enabled, your internet traffic will be protected by a security ready DNS server. This feature provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //_sp_desc1_AdvDNS
	"Note:<br />When DNS Relay is enabled along with Advanced DNS feature, your workstations on the network that are obtaining an IP address from router’s DHCP server will obtain 192.168.0.1 (router’s IP address). However, traffic will still be protected.", //_sp_desc2_AdvDNS
	"Although Advanced DNS feature is enabled, DNS IP address of your workstation can still be modified to the DNS server IP you desire. Please note that the router does not dictate the DNS name resolution when DNS IP address is configured on the workstation.", //_sp_desc3_AdvDNS
	"If you selected this option and have VPN or Intranet setup in your network, you can disable Advanced DNS service if you experience connection difficulties.", //_sp_desc4_AdvDNS
	"The Key", //TEXT041_1
	" is invalid. The Key must be", //TEXT041_2
	" characters or", //TEXT041_3
	"hexadecimal number.", //TEXT041_4
	"The Key", //TEXT042_1
	" is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042_2
	"Invalid URL.", //GW_URL_INVALID
	"Invalid NetBIOS Scope.", //GW_LAN_NETBIOS_SCOPE_INVALID
	"should be within the configured DHCP range.", //GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a
	"DHCP Plus", //bwn_Mode_DHCPPLUS
	"Net Sniper Supported", //net_sniper_support
	"", //TEXT_xkjs_descript
	"Special dialing mode options", //SEL_DIAL_MODE
	"Normal dialing (default)", //pppoe_dialmode_normal
	"Special dialing 1", //pppoe_dialmode_sp1
	"Special dialing 2", //pppoe_dialmode_sp2
	"Special dialing 3", //pppoe_dialmode_sp3
	"Special dialing 4", //pppoe_dialmode_sp4
	"Special dialing 5", //pppoe_dialmode_sp5
	"Special dialing 6", //pppoe_dialmode_sp6
	"Learning Mode", //pppoe_dialmode_learn
	"Learning", //bt_learn_text
	"Anti-ARP Attack", //box_ip_mac_binding
	"Enable Anti-ARP Attack", //ip_mac_binding_desc
	"XKJS Supported", //xkjs_support
	"Service type", //ddns_serv_type
	"Domain", //ddns_domain
	"DDNS account test", //ddns_account
	"Invalid public port", //virtual_pub_port_err
	"Invalid private port", //virtual_pri_port_err
	"Invalid protocol number", //virtual_proto_num_err
	"Wi-Fi Protected Setup", //menu_wps
	"ip range", //tc_iprange
	"operate mode", //tc_opmode
	"bandwidth(kbps)", //tc_bw
	"schedule", //tc_schedule
	"new schedule", //tc_new_sch
	"gaurantee minimum bandwidth", //tc_min_bw
	"gaurantee maximum bandwidth", //tc_max_bw
	"Admin", //_login_admin
	"User", //_login_user
	"PPPoE Plus Supported", //pppoe_plus_dail
	"", //wwa_msg_dhcpplus
	"Invalid DHCP+ username", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Invalid DHCP+ password", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"SMTP server port", //te_SMTPPort
	"Wireless Mode", //WLANMODE
	"Router Mode", //ROUTER_MODE
	"AP Mode", //AP_MODE
	"WDS+Router Mode", //WDSROUTER_MODE
	"WDS+AP Mode", //WDSAP_MODE
	"Bridge setting", //BR_SET
	"Device Mode", //device_mode
	"Router Mode", //router_mode
	"AP Mode", //ap_mode
	"Automatic", //auto_mode
	"WDS Enable", //enable_WDS
	"WELCOME TO THE D-LINK EAST SETUP WIZARD", //ES_WELCOME
	"The router is detecting your Internet connection type. Please wait until the router provides suitable settings for your configuration.", //ES_AUTODECT
	"PHYSICAL CONNECTION OF INTERNET PORT IS DISCONNECTED", //ES_CABLELOST_bnr
	"Please make sure the cable between the ADSL/cable modem and the router is properly connected. The router will try to detect your Internet connection type again.", //ES_CABLELOST_dsc1
	"If you don't want to connect to Internet, please click the button below.", //ES_CABLELOST_dsc2
	"I don't need to connect to Internet", //ES_DONT_CONN_btn
	"INTERNET CONFIGURATION UPDATED", //ES_UPDATE_SETTING_bnr
	"The router is detecting your Internet connection type and trying to connect to Internet.                                Please wait until the detection is completed.", //ES_UPDATE_SETTING_dsc
	"CONFIGURE YOUR INTERNET CONNECTION", //ES_CONFIG_INTERNET_bnr
	"", //ES_CONFIG_INTERNET_dsc1
	"It seems that your username and passoword are incorrect. Please check again and click \"Connect\"", //ES_CONFIG_INTERNET_dsc2
	"Internet Connection", //ES_INTERNET_CONN_dsc
	"(* is required field)", //ES_MUST_FIELD_dsc
	"DIAL-UP IS FAILED", //ES_DIALUP_ERROR_bnr
	"Please contact your ISP to get the correct username/password", //ES_DIALUP_ERROR_dsc
	"Easy Setup", //ES_NAME
	"Please fill out the required fields and click \"Connect\"", //ES_CONN_dsc
	"What is this?", //ES_what_is_this
	"Primary DNS Server", //ES_PRI_DNS
	"Secondary DNS Server", //ES_SEC_DNS
	"Gateway Address", //ES_GW_ADDR
	"Subnet Mask", //ES_MASK
	"IP Address", //ES_IP_ADDR
	"EASY SETUP COMPLETE", //ES_complete
	"The Easy Setup process has successfully completed. Click the “Save” button for your settings to take effect. We recommend you check “Save the network settings” box to save your wireless network settings to your computer in case there are more PCs that need to connect to your router wirelessly.<br><br> After clicking the “Save” button, you need to provide your username and password to access the device when logging in next time.", //ES_save_dsc
	"Status", //ES_status
	"Connected", //ES_connected
	"Unconnected", //ES_unconnected
	"Wireless Settings", //ES_wlan_setting
	"Wireless Network Name (SSID)", //ES_wlan_ssid
	"Security", //ES_security
	"Unsecured", //ES_unsecured
	"Your current wireless security settings are not safe. We recommend you configure wireless settings.", //ES_unsecured_suggest
	"Save my network settings", //ES_save_mySetting
	"Set the password of the device to wireless network key", //ES_sync_pw
	"Save", //ES_save
	"Network Key", //ES_network_key
	"Auto generate network key", //ES_autogen_key
	"Disable Wireless Security (Not recommended)", //ES_disable_wifi_sec
	"AUTO-WPA/WPA2(Recommended)", //ES_wifi_sec_recomm
	"The current network settings and the connection status are displayed below. If you want to reconfigure your wireless settings, please click the “Configure” button. You can also enter advanced settings by clicking “Manual Setup”.", //ES_current_setting_dsc
	"CURRENT NETWORK SETTING", //ES_current_setting
	"Manual Setup", //ES_manual_btn
	"Cancel", //ES_cancel
	"Logout", //logout_caption
	"You have been logout.", //logout_desc
	"Return to login page.", //logout_return
	"Connected Time", //st_connected_time
	"Access Deny", //t_ctl_title
	"It is NOT allowed to access Internet currently. <br>Are you sure you want to use Emergency Internet Access?", //t_ctl_note
	"It is NOT allowed to access Internet currently. Pay attention to study please.", //t_ctl_note1
	"D-LINK CORPORATION, INC | WIRELESS ROUTER", //page_title
	"Port range should be set between 0 and 65535.", //ac_alert_invalid_port
	"Duplicated name:", //ac_alert_dup_name
	"Port conflict:", //ac_alert_port_conflit
	"Policy cannot be null.", //ac_alert_policy_null
	"Please choose a device to apply the policy.", //ac_alert_choose_dev
	"The router can't access Internet with the current static IP setting.", //ES_static_no_internet
	"Unable to access Internet with the current configuration. Please check your setting!", //ES_static_no_internet_desc
	"This window will be closed. Are you sure?", //_CFM_close_window
	"SAVE CONFIGURATION RESULT", //ES_save_result
	"The configuration has been saved.", //ES_save_success
	"Confirm", //ES_confirm_bt
	"Time format", //sch_timeformat
	"12-hour", //sch_hourfmt_12
	"24-hour", //sch_hourfmt_24
	"This firmware is the latest version.", //no_available_update
	"clean language pack", //clear_lang_pack
	"Current Language Pack Version", //current_lang_pack_version
	"Current Language Pack Date", //current_lang_pack_date
	"Language pack information", //lang_package_info
	"Upgrade language pack will change the language displayed on web site.", //lang_package_note1
	"To upgrade the language pack, your PC must connect to router with wire, input the file path and click the submit button.", //lang_package_note2
	"Latest Language Pack Version", //latest_lang_package_ver
	"Latest Language Pack Date", //latest_lang_package_date
	"There is no language pack.", //no_lang_pack
	"Port forward name cannot be empty.", //pf_name_empty
	"Virtual server name cannot be empty.", //vs_name_empty
	"Checksum error.", //fw_checksum_err
	"Bad hardware ID.", //fw_bad_hwid
	"Unknow file format.", //fw_unknow_file_format
	"Firmware upgrade success.", //fw_fw_upgrade_success
	"Language pack upgrade success.", //fw_lp_upgrade_success
	"Configuration upgrade success.", //fw_cfg_upgrade_success
	"Set Time Control", //ES_timectrl_bnr
	"Time Control", //ES_timectrl_btn
	"Web Control", //ES_webpolicy_btn
	"True Gigabit Routing Connectivity Setting", //HW_NAT_desc
	"Enable True Gigabit Routing Connectivity", //HW_NAT_enable
	"When True Gigabit Routing Connectivity is enabled, SPI and QoS engine will be disabled automatically. Would you like to proceed?", //alert_hw_nat_1
	"When QoS engine is enabled, True Gigabit Routing Connectivity will be disabled automatically. Would you like to proceed?", //alert_hw_nat_2
	"When SPI is enabled, True Gigabit Routing Connectivity will be disabled automatically. Would you like to proceed?", //alert_hw_nat_3
	"When this option is enabled, True Gigabit Routing Connectivity will be disabled automatically.", //help_auto_disable_hw_nat
	" and True Gigabit Routing Connectivity will be disabled automatically.", //help_auto_disable_hw_nat_1
	"True Gigabit Routing Connectivity:", //help_hw_nat
	"When this option is enabled, the router will speed up the NAT/Routing performance by hardware acceleration mechanism. The limitation is that both of SPI and QoS engine will be disabled automatically when True Gigabit Routing Connectivity is enabled.", //help_hw_nat_desc
	"Step 2: Configure your Wi-Fi Security", //ES_step_wifi_security
	"Please plug one end of the included Ethernet cable that came with your router into the port labeled INTERNET on the back of the router. Plug the other end of this cable into the Ethernet port on your modem.", //ES_cable_lost_desc
	"Try again", //ES_btn_try_again
	"Routers is detecting your Internet connection type, please wait…", //ES_auto_detect_desc
	"Routers is unable to detect your Internet connection type.", //ES_auto_detect_failed_desc
	"Guide me through the Internet connection settings", //ES_btn_guide_me
	"Note: All D-Link wireless adapters currently support WPA.", //ES_note_support_wpa
	"Save & Connect", //ES_btn_save_conn
	"Save", //ES_btn_save
	"Do you want to bookmark \"D-Link Router Web Management\"?", //ES_bookmark
	"IPv6 Routing", //v6_routing
	"IPv6 Routing Table", //v6_routing_table
	"This page displays the routing details configured for your router.", //v6_routing_info
	"IPv6", //ipv6
	"IPv6 Firewall", //ipv6_firewall
	"Remaining number of firewall rules that can be configured:", //ipv6_firewall_info
	"6rd SETTINGS", //_6rd_settings
	"IPv4 Address", //ipv4_addr
	"Mask Length", //mask_len
	"IPv6 ULA SETTINGS", //IPV6_ULA_TEXT01
	"Enable ULA", //IPV6_ULA_TEXT02
	"Use default ULA prefix", //IPV6_ULA_TEXT03
	"ULA Prefix", //IPV6_ULA_TEXT04
	"Current IPv6 ULA SETTINGS", //IPV6_ULA_TEXT05
	"Current ULA Prefix", //IPV6_ULA_TEXT06
	"LAN IPv6 ULA", //IPV6_ULA_TEXT07
	"LAN IPv6 Unique Local Address", //IPV6_ULA_TEXT08
	"MANUAL IPv6 LOCAL CONNECTIVITY SETUP", //IPV6_ULA_TEXT09
	"If you would like to configure the IPv6 local connectivity settings of your D-Link Router, then click on the button below.", //IPV6_ULA_TEXT10
	"Use this section to configure Unique Local IPv6 Unicast Addresses (ULA) settings for your router. ULA is  intended for local communications and not expected to be routable on the global Internet.", //IPV6_ULA_TEXT11
	"IPv6 Local Connectivity Settings", //IPV6_ULA_TEXT12
	"ULA is useful for Local IPv6 communications, if you would like to enable it, click <b>Enable ULA</b>. By default ULA is disabled.", //IPV6_ULA_TEXT13
	"IPv6 LOCAL CONNECTIVITY SETTINGS ", //IPV6_ULA_TEXT14
	"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new D-Link Systems Router to the IPv6 Internet, click on the button below.", //LW27_v6
	"If you would like to configure the IPv6 Internet settings of your new D-Link Systems Router manually, then click on the button below.", //LW29_v6
	"LAN IPv6 address for local IPv6 communicatoins.", //IPv6_Local_Info
	"IPv6 Simple Rules", //IPv6_Simple_Security
	"Enable IPv6 Simple Security ", //IPv6_Simple_Security_enable
	"SET UP 6rd TUNNELING CONNECTION", //IPv6_Wizard_6rd_title
	"Firewall rule name cannot be empty.", //fr_name_empty
	"IPv6 routing name cannot be empty.", //r6_name_empty
	"Give your Wi-Fi network a name.", //wwz_wwl_intro_s2_1
	"Wi-Fi Network Name (SSID)", //wwz_wwl_intro_s2_1_1
	"(Using up to 32 characters)", //wwz_wwl_intro_s2_1_2
	"Give your Wi-Fi network a password.", //wwz_wwl_intro_s2_2
	"Wi-Fi Password", //wwz_wwl_intro_s2_2_1
	"(Between 8 and 63 characters)", //wwz_wwl_intro_s2_2_2
	"Step 3: Set your Password", //ES_title_s3
	"Step 4: Select your Time Zone", //ES_title_s4
	"Step 5: Save Settings", //ES_title_s5
	"5GHz Band", //GW_WLAN_RADIO_1_NAME
	"802.11n only", //bwl_Mode_n
	"802.11a only", //bwl_Mode_a
	"Mixed 802.11n and 802.11a", //bwl_Mode_5
	"The schedule of Guest Zone must be within the schedule of main WLAN.", //MSG049
	"The GuestZone WLAN will be disabled when you turn off main WLAN. Are you sure to continue?", //MSG050
	"Hardware init error", //HWerr
	"STORAGE", //storage
	"Web File Access allows you to use a web browser to remotely access files stored on an SD card or USB storage drive plugged into the router. To use this feature, check the <strong>Enable Web File Access</strong> checkbox, the create user accounts to manage access to your storage devices or use the Guest account (guest/guest) to access the Guest Floder. After plugging in an SD card or USB storage drive, the new device will appear in the list with a link to it. You can then use this link to connect to the drive and log in with a user account.", //sto_into
	"HTTP STORAGE", //sto_http_0
	"Enable Web File Access", //sto_http_1
	"Enable HTTP Storage Remote Access", //sto_http_2
	"Remote Access Port", //sto_http_3
	"Enable HTTPS Storage Remote Access", //sto_http_4
	"Remote HTTPS Port", //sto_http_5
	"10 -- USER CREATION", //sto_creat
	"Add/Edit", //_add_edit
	"USER LIST", //sto_list
	"Modify", //_modify
	"Access Path", //sto_path
	"Permission", //sto_permi
	"NUMBER OF DEVICEE", //sto_no_dev
	"Device", //sto_dev
	"Total Space", //_total_space
	"Free Space", //_free_space
	"HTTP STORAGE LINK", //sto_link_0
	"You can use this link to connect to the drive remotely after logging in with a user account.", //sto_link_1
	"http://&lt;DDNS&gt; or&lt;WAN IP Address&gt;:8181", //sto_link_2
	"Email Now", //_email_now
	"The Storage page contains information about the USB storage drives or SD cards currently plugged in to the device.", //sto_help
	"Device Link", //_DevLink
	"Folder", //_folder
	"Browse", //_browse
	"Append", //_append
	"Read Only", //_readonly
	"Read/Write", //_readwrite
	"APPEND NEW FOLDER", //_AppendNewFolder
	"Please select \"Device Link\"", //MSG051
	"This account has reached the maximum rule", //MSG052
	"This rule already exists", //MSG053
	"Can't find this rule, please press the Append button", //MSG054
	"Add New Folder", //_AddFolder
	"http://&lt;DDNS&gt; or &lt;WAN IP Address&gt;", //_StorageLink
	"" //MAX
);
var _Advanced_01=0;
var _Advanced_02=1;
var _Advanced_03=2;
var _Advanced_04=3;
var bwn_ict_dns=4;
var bwn_msg_Modes_dns=5;
var ta_EUPNP_dns=6;
var _dlinkdns=7;
var new_bwn_mici_usb=8;
var _tkip_11n=9;
var bln_title_guest_use_shareport=10;
var bwn_mici_guest_use_shareport=11;
var bwl_Mode_10=12;
var _authword=13;
var _regenerate=14;
var li_alert_4=15;
var _graph_auth=16;
var usb3g_titile=17;
var usb3g_apn_name=18;
var usb3g_dial_num=19;
var usb3g_reconnect_mode=20;
var usb3g_max_idle_time=21;
var usb_device=22;
var usb3g_manual=23;
var usb3g_stat_titile=24;
var bln_title_usb=25;
var usb_wcn=26;
var bwn_intro_usb=27;
var usb_network=28;
var usb_3g=29;
var wwan_dial_num=30;
var bwn_wwanICT=31;
var _ispinfo=32;
var wwan_auth_label=33;
var wwan_auth_auto=34;
var wwan_auth_pap=35;
var wwan_auth_chap=36;
var wwan_auth_mschap=37;
var usb_network_help=38;
var usb_network_support_help=39;
var usb_3g_help=40;
var usb_3g_help_support_help=41;
var usb_wcn_help=42;
var bwn_mici_usb=43;
var _info_netowrk=44;
var _network_usb_auto=45;
var bwn_usb_time=46;
var bwn_bytes_usb=47;
var _wps_albert_1=48;
var _wps_albert_2=49;
var usb_config1=50;
var usb_config2=51;
var usb_config3=52;
var usb_config4=53;
var usb_config5=54;
var usb_config6=55;
var bwn_msg_usb=56;
var bwn_note_usb=57;
var _country=58;
var _select_country=59;
var _select_ISP=60;
var country_1=61;
var country_2=62;
var country_3=63;
var country_4=64;
var country_5=65;
var country_6=66;
var country_7=67;
var country_8=68;
var country_9=69;
var country_10=70;
var country_11=71;
var country_12=72;
var country_13=73;
var country_14=74;
var country_15=75;
var S500=76;
var S496=77;
var LV2=78;
var logs_LW39b_email=79;
var LV3=80;
var GW_WIRELESS_DEVICE_LINK_UP=81;
var LT248=82;
var GW_PPPOE_EVENT_DISCOVERY_ATTEMPT=83;
var GW_WLAN_RADIO_1_NAME=84;
var te_SMTPSv_Port=85;
var GW_WLAN_CHANGING_PHY_MODE_TO_11NG_ONLY_INVALID=86;
var S558=87;
var KRL8=88;
var LY30=89;
var GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=90;
var GW_WIFISC_DISABLED_AUTOMATICALLY=91;
var GW_PPPOE_EVENT_OFFER=92;
var GW_WLAN_RADIO_0_NAME=93;
var GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR=94;
var GW_WAN_PPPOE_SESSION_NAME_CONFLICT=95;
var S525=96;
var S493=97;
var KR136=98;
var GW_PPPOE_EVENT_DISCONNECT=99;
var anet_multicast_enhanced=100;
var LY34=101;
var GW_WIRELESS_SHUT_DOWN=102;
var GW_WIRELESS_RESTART=103;
var S528=104;
var GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE=105;
var guestzone_Intro_1=106;
var GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=107;
var S473=108;
var te_SMTPSv_Port_alert=109;
var GW_WIRELESS_DEVICE_START_FAILED=110;
var GW_PORT_FORWARD_UDP_PACKET_ALLOC_FAILURE=111;
var GW_WIRELESS_DEVICE_DISCONNECT_ALL=112;
var GW_PPPOE_EVENT_OFFER_REQUEST=113;
var GW_ROUTES_ROUTERS_IP_ADDRESS_INVALID=114;
var GW_PORT_TRIGGER_UDP_PACKET_ALLOC_FAILURE=115;
var GW_WLAN_SETTING_SSID_SECURITY_TO_WEP_INVALID=116;
var GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT=117;
var GW_WLAN_STATION_TIMEOUT=118;
var GW_NAT_VIRTUAL_SERVER_IP_ADDRESS_CAN_NOT_MATCH_ROUTER=119;
var GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID=120;
var LY28=121;
var GW_PPPOE_EVENT_CONNECT=122;
var GW_NAT_TRIGGER_PORT=123;
var KR971=124;
var wwz_auto_assign_key3=125;
var LY292=126;
var LY293=127;
var bws_msg_WEP_4=128;
var GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID=129;
var wwa_dnsset=130;
var wireless_gu=131;
var add_gu_wps=132;
var wwl_band=133;
var _band=134;
var wwa_5G_nname=135;
var _guestzone=136;
var guestzone_title_1=137;
var guestzone_enable=138;
var guestzone_inclw=139;
var guest=140;
var lower_wnt=141;
var equal_wnt=142;
var _lowest=143;
var ssid_lst=144;
var dlink_help150=145;
var mult_ssid=146;
var dlink_help155=147;
var add_ed_ssid=148;
var dlink_help156=149;
var dlink_help157=150;
var wpin_filter=151;
var dlink_help151=152;
var tps_raw1=153;
var up_tz_52=154;
var _r_alert_new1=155;
var te_EmSt=156;
var tt_Nov=157;
var IPNAT_BLOCKED_EGRESS=158;
var bws_WSMode=159;
var tsc_pingt_msg102=160;
var help65=161;
var ta_upnp=162;
var bwl_TxR=163;
var GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED=164;
var tsc_pingt_msg106=165;
var tsc_AllDay=166;
var gw_gm_53=167;
var GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR=168;
var DHCP_CLIENT_LOST_LEASE=169;
var _aa_wiz_s3_msg=170;
var help385=171;
var hhtt_intro=172;
var gw_gm_20=173;
var help388=174;
var tt_StDT=175;
var _ok=176;
var _status=177;
var _Out=178;
var sl_WtV=179;
var WIFISC_AP_PROXY_PROCESS_START=180;
var wprn_nopr2=181;
var help352=182;
var wwz_wwl_wnn=183;
var _ipaddr=184;
var GW_WLS_SCHEDULE_START=185;
var help820=186;
var help326=187;
var up_tz_54=188;
var help773=189;
var am_MACFILT=190;
var aa_alert_7_new1=191;
var help302=192;
var aa_intro=193;
var help348=194;
var gw_gm_35=195;
var sl_Infrml=196;
var _wireless=197;
var bws_RIPA=198;
var KR58_ww=199;
var help83=200;
var hhase_intro=201;
var RUNTIME_CONFIG_MAGIC_NUM_ERROR=202;
var _Sat=203;
var awf_title_WSFR=204;
var help18_a=205;
var dlink_wf_op_1=206;
var gw_gm_18=207;
var gw_gm_7=208;
var USB_LOG_STORAGE_TYPE=209;
var help346=210;
var up_rb_5=211;
var _WEP=212;
var IPMSCHAP_AUTH_FAIL_AND_NO_RETRY=213;
var gw_gm_82=214;
var bw_sap=215;
var bwn_msg_SWM=216;
var li_alert_2=217;
var help120=218;
var IGMP_HOST_LOW_RESOURCES=219;
var wwl_s4_intro_z3=220;
var help858=221;
var help339=222;
var help857=223;
var help51=224;
var GW_WAN_LAN_ADDRESS_CONFLICT_PPP=225;
var ss_Errors=226;
var help899=227;
var wps_p3_4=228;
var haf_dmz_40=229;
var hhts_edit=230;
var wwl_wnn=231;
var WEB_FILTER_LOG_URL_ACCESSED_MAC=232;
var aw_WE=233;
var help201a=234;
var _bsecure_activate_trial=235;
var help896=236;
var help815=237;
var _netmask=238;
var _please_wait=239;
var help12=240;
var am_intro_1=241;
var IPPPPLCP_SET_LOCAL_AUTH=242;
var gw_gm_11=243;
var _dontsavesettings=244;
var wwl_s4_intro_za1=245;
var _308=246;
var dlink_help148=247;
var aa_AT_1=248;
var IPL2TP_TUNNEL_ABORTING=249;
var help330=250;
var dlink_1_bwl_schld=251;
var wwa_msg_l2tp=252;
var tt_time_5=253;
var help6=254;
var _time=255;
var at_xDSL=256;
var wprn_intro4=257;
var help296=258;
var _LAN=259;
var gw_gm_60=260;
var _aa_wiz_s4_msg=261;
var wwl_64bits=262;
var IPFAT_DISK_FULL=263;
var help341=264;
var sps_intro3=265;
var aa_sched_conf_2=266;
var IPL2TP_SESSION_CONNECTING=267;
var NET_RTC_SYNCHRONIZATION_FAILED=268;
var tf_AutoCh=269;
var wprn_iderr2=270;
var help319=271;
var af_intro_2=272;
var help800=273;
var sd_title_Dev_Info=274;
var GW_INET_ACCESS_DROP_PORT_FILTER=275;
var _connow=276;
var IPSIPALG_REJECTED_PACKET=277;
var IPNAT_TCP_UNABLE_TO_MODIFY_OPTIONS=278;
var tt_SelNTPSrv=279;
var help812=280;
var _user=281;
var up_tz_59=282;
var SPECIAL_APP=283;
var wwl_NONE=284;
var GW_WAN_SERVICES_STARTED=285;
var fb_FbWbAc=286;
var help275=287;
var wprn_nopr=288;
var tt_TimeZ=289;
var wprn_tt=290;
var help841=291;
var aa_sched_new=292;
var tt_time_14=293;
var gw_vs_1=294;
var tsl_SLSt=295;
var IPH323ALG_REJECTED_PACKET=296;
var aa_wiz_s1_msg4=297;
var help336=298;
var ta_sn=299;
var help780=300;
var _interface=301;
var WEB_FILTER_LOG_URL_BLOCKED=302;
var vs_http_port=303;
var haf_intro_1=304;
var up_tz_07=305;
var aw_intro=306;
var wwa_gw=307;
var _sentinel_serv=308;
var wwa_msg_sipa=309;
var IPNAT_TCP_UNABLE_TO_HANDLE_HEADER=310;
var hhav_ip=311;
var haf_dmz_50=312;
var GW_INET_ACCESS_POLICY_END_MAC=313;
var tsc_intro_Sch=314;
var GW_WLAN_ACCESS_DENIED=315;
var _262=316;
var help79=317;
var GW_BIGPOND_CONFIG=318;
var aw_TP_0=319;
var _sdi_s3=320;
var tsc_pingt=321;
var tsc_pingt_v6=322;
var _WPApersonal=323;
var _email=324;
var PPPOE_EVENT_DISCOVERY_REQUEST=325;
var _firewall=326;
var wwa_wanmode_sipa=327;
var _syscheck=328;
var help784=329;
var UNKNOWN=330;
var help322=331;
var help_upnp_1=332;
var gw_gm_61=333;
var _optional=334;
var help181=335;
var help569=336;
var anet_intro=337;
var help862=338;
var IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN=339;
var ta_GWN=340;
var wprn_tt3=341;
var help293=342;
var help265_2=343;
var IPNAT_UNABLE_TO_CREATE_CONNECTION=344;
var help270=345;
var aw_title_2=346;
var _firewalls=347;
var help186=348;
var PPPOE_EVENT_UP=349;
var _protocol=350;
var help372=351;
var up_tz_32=352;
var at_kbps=353;
var at_Cable=354;
var anet_wp_1=355;
var help17=356;
var ta_intro_Adm2=357;
var tool_admin_check=358;
var IPPPPIPCP_PPP_LINK_UP=359;
var _stop=360;
var GW_SYSLOG_STATUS=361;
var bd_title_DHCPSSt=362;
var help827=363;
var tf_FWCheckInf=364;
var tf_FWInf=365;
var hhai_ipr=366;
var hhaw_1=367;
var help34=368;
var tt_EnNTP=369;
var help309=370;
var aa_alert_15=371;
var _savesettings=372;
var help193=373;
var help14_p=374;
var gw_gm_32=375;
var IPNAT_TCP_BLOCKED_INGRESS_SYN=376;
var anet_msg_wan_ping=377;
var ai_intro_2=378;
var help285=379;
var ss_LANStats=380;
var ta_alert_4=381;
var _clone=382;
var gw_gm_14=383;
var PPTP_ALG_GRE_UNABLE_TO_HANDLE_HEADER=384;
var _aa_block_some=385;
var help819_3=386;
var tt_time_24=387;
var help873=388;
var ss_Collisions=389;
var help863=390;
var help397=391;
var av_title_VSL=392;
var _off=393;
var tf_ENFA=394;
var help13=395;
var wwa_title_s3=396;
var ES_wwa_title_s1=397;
var GW_WAN_RATE_ESTIMATOR_CONVERGENCE_ERROR=398;
var wwa_wanmode_bigpond=399;
var help254=400;
var haf_dmz_70=401;
var GW_SCHED_ATTACH_FAILED=402;
var _badssid=403;
var RUNTIME_CONFIG_STORING_CONFIG_IN_NVRAM=404;
var FW_UPDATE_AVAILABLE=405;
var dlink_awf_intro_WF=406;
var help891=407;
var help777=408;
var help393=409;
var bwn_ict=410;
var tt_Jun=411;
var IPL2TP_TUNNEL_CONNECTED=412;
var gw_gm_9=413;
var gw_gm_2=414;
var wwl_wl_wiz=415;
var network_dhcp_range=416;
var wprn_intro6=417;
var GW_BIGPOND_FAIL=418;
var af_EFT_1=419;
var _use_unicasting=420;
var _networkstate=421;
var tt_Year=422;
var IPASYNCFILEUSB_MOUNT_FAILED=423;
var af_UEFT=424;
var help356=425;
var help381=426;
var _inboundfilter=427;
var _aa_apply_port_filter=428;
var aa_FPR_c7=429;
var gw_gm_27=430;
var BIGPOND_NOT_PROPERLY_CFGD=431;
var help335=432;
var up_tz_58=433;
var _never=434;
var help801=435;
var tsc_pingt_msg105=436;
var li_WJS=437;
var te_ToEm=438;
var tt_time_1=439;
var help787=440;
var DHCP_CLIENT_GOT_LEASE=441;
var GW_EMAIL_SUBJ=442;
var IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE=443;
var bi_wiz=444;
var EGRESS=445;
var hhpt_app=446;
var _dhcpconn=447;
var bln_title_Rtrset=448;
var _ps=449;
var _1044=450;
var wwl_text_best=451;
var wwa_pptp_svraddr=452;
var GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED=453;
var _LANComputers=454;
var hhte_intro=455;
var as_NM=456;
var wwa_setupwiz=457;
var help264=458;
var bw_WDUU_note=459;
var as_MMS=460;
var _srvname=461;
var help93=462;
var tt_Minute=463;
var sa_State=464;
var aw_dE=465;
var tsc_pingt_h=466;
var tsc_pingt_h_v6=467;
var ss_WStats=468;
var IPMSCHAP_AUTH_SEND_CHALLENGE=469;
var wprn_intro1=470;
var help889=471;
var as_H323=472;
var tool_admin_pfname=473;
var IPNAT_SESSION_ALREADY_EXISTS=474;
var wwa_title_set_bigpond=475;
var up_tz_16=476;
var GW_BIGPOND_STATUS=477;
var wwa_msg_set_bigpond=478;
var te_EnAuth=479;
var help848=480;
var gw_gm_41=481;
var _aa_pol_wiz=482;
var IP_FILTERS=483;
var gw_gm_50=484;
var wwa_intro_s3=485;
var IPSEC_ALG_ESP_ESTABLISH_ALREADY_PENDING=486;
var help59=487;
var wps_reboot_need=488;
var at_DF=489;
var help265_7=490;
var tt_alert_dstchkmonth=491;
var up_tz_23=492;
var _advanced=493;
var STATIC_IP_ADDRESS=494;
var wwl_title_s3=495;
var hhsw_intro=496;
var ish_menu=497;
var up_tz_33=498;
var GW_FW_NOTIFY_FIRMWARE_ERROR=499;
var _bsecure_more_info=500;
var tf_CFWV=501;
var tt_week_2=502;
var help3=503;
var _creator=504;
var bln_title_DNSRly=505;
var GW_INET_ACCESS_DROP_PORT_FILTER_MAC=506;
var ish_glossary=507;
var wwl_s4_intro_z4=508;
var help118=509;
var gw_gm_66=510;
var help312dr2=511;
var tsc_24hrs=512;
var hhag_10=513;
var help261=514;
var as_TPrt=515;
var help28=516;
var tt_time_12=517;
var ss_reload=518;
var haf_dmz_30=519;
var sps_fp=520;
var gw_gm_57=521;
var wwa_msg_dhcp=522;
var aa_wiz_s1_msg1=523;
var MUST_BE_LOGGED_IN_AS_ADMIN=524;
var up_tz_64=525;
var GW_WLS_SCHEDULE_STOP=526;
var IPWOLALG_REJECTED_PACKET=527;
var WCN_LOG_UPDATE=528;
var help80=529;
var help171=530;
var _Mon=531;
var up_tz_66=532;
var wwl_title_s4_2=533;
var help196=534;
var PPPOE_EVENT_DISCOVERY_REQUEST_ERROR=535;
var li_Log_In=536;
var af_gss=537;
var _defgw=538;
var tt_NTPSrvU=539;
var add_wireless_device=540;
var help8=541;
var help258=542;
var PPPOE_EVENT_TERMINATED=543;
var up_rb_1=544;
var help25_b=545;
var sl_saveLog=546;
var sl_intro=547;
var _aa_wiz_s4_help=548;
var GW_WAN_CARRIER_LOST=549;
var bwn_bytes=550;
var help890_1=551;
var help779=552;
var _macaddr=553;
var help823_13=554;
var anet_multicast_enable=555;
var anet_multicast_enable_v4=556;
var anet_multicast_enable_v6=557;
var GW_DYNDNS_UPDATE_NEXT=558;
var help866=559;
var sl_RStat=560;
var gw_gm_78=561;
var help90=562;
var PPTP_EVENT_TUNNEL_DOWN=563;
var bwn_SWM=564;
var IPWEBFILTER_REJECTED_PACKET=565;
var GW_UPGRADE_FAILED=566;
var ag_intro=567;
var ta_intro_Adm=568;
var bwn_L2TPSIPA=569;
var GW_INET_ACCESS_UNRESTRICTED=570;
var up_tz_11=571;
var _disabled=572;
var GW_LOG_EMAIL_ON_LOG_FULL=573;
var tt_time_8=574;
var help43=575;
var ddns_connecting=576;
var help282=577;
var aa_EAC=578;
var te_OnFull=579;
var tt_Apr=580;
var tt_alert_invlddt=581;
var bwl_MS=582;
var wwa_intro_wel=583;
var tool_admin_portconflict=584;
var gw_SelVS=585;
var bwn_RM_0=586;
var hhai_edit=587;
var te_FromEm=588;
var wt_p_1=589;
var NET_RTC_REQUEST_TIME=590;
var help824=591;
var N_A=592;
var help279=593;
var tt_week_6=594;
var gw_gm_48=595;
var bwl_VS_1=596;
var help882=597;
var up_tz_41=598;
var RUNTIME_CONFIG_LOADED_CONFIG_FROM_NVRAM=599;
var li_alert_1=600;
var help307=601;
var help273=602;
var gw_gm_81=603;
var up_rb_4=604;
var NEWER_FW_VERSION=605;
var bwn_PPTPICT=606;
var GW_UPGRADE_SUCCEEDED=607;
var bwl_AS=608;
var help96=609;
var _wchannel=610;
var wwz_manual_key=611;
var wps_p3_5=612;
var tps_enlpd=613;
var _L2TP=614;
var bd_DIPAR=615;
var _stats=616;
var wwl_s4_intro_za2=617;
var IPL2TP_SESSION_DOWN=618;
var bwn_DIAICT=619;
var help338=620;
var help859=621;
var _add=622;
var _acccon=623;
var tsc_pingt_msg4=624;
var ddns_disconnect=625;
var _verifypw=626;
var am_intro_2=627;
var _aa_pol_add=628;
var gw_gm_59=629;
var help11=630;
var _system=631;
var help261a=632;
var up_tz_02=633;
var hhtsc_pingt_intro=634;
var help5=635;
var help767s=636;
var gw_gm_45=637;
var wwa_wanmode_pppoe=638;
var GW_ROUTES_GATEWAY_SUBNET_SAME=639;
var haf_dmz_60=640;
var te_intro_Em=641;
var wwl_text_none=642;
var help895=643;
var help269=644;
var GW_WAN_RECONNECT_ON_ACTIVE=645;
var aa_Machine=646;
var GW_WLS_SCHEDULE_INIT=647;
var _Wed=648;
var tt_time_20=649;
var aa_FPR_c3=650;
var help68=651;
var help150=652;
var te_Acct=653;
var IPSMTPCLIENT_MSG_SENT=654;
var gw_gm_38=655;
var help384=656;
var tt_time_2=657;
var at_AUS=658;
var hhts_del=659;
var help818=660;
var help886=661;
var _aa_wiz_s2_msg=662;
var help52=663;
var wps_KR46=664;
var wwz_wwl_intro_s3_1=665;
var gw_gm_19=666;
var td_intro_DDNS=667;
var up_tz_53=668;
var help845=669;
var wt_p_3=670;
var up_tz_51=671;
var wprn_s3d=672;
var IPPPPCHAP_AUTH_FAIL=673;
var gw_gm_52=674;
var IPNAT_TCP_BAD_FLAGS=675;
var _name=676;
var help66=677;
var IPNAT_UDP_BLOCKED_INGRESS_ICMP_ERROR_PACKET=678;
var IPFTPALG_REJECTED_PACKET=679;
var fb_p_1=680;
var _contype=681;
var help829=682;
var _specappsr=683;
var help353=684;
var gw_gm_23=685;
var help325=686;
var bwn_RM=687;
var sl_LogOps=688;
var help772=689;
var _aa_method=690;
var sl_LogDet=691;
var help788=692;
var _continue=693;
var help349=694;
var help804=695;
var _devinfo=696;
var _yes=697;
var help699=698;
var up_tz_62=699;
var help192=700;
var af_ED=701;
var gw_gm_31=702;
var help271=703;
var help33=704;
var IPNAT_TCP_BLOCKED_INGRESS_BAD_ACK=705;
var htsc_pingt_p=706;
var tf_CKN=707;
var wprn_cps=708;
var up_tz_45=709;
var help84=710;
var GW_FW_NOTIFY_FIRMWARE_AVAIL=711;
var ss_RXPD=712;
var WEB_FILTER_LOG_URL_BLOCKED_MAC=713;
var IPPORTTRIGGERALG_TCP_PACKET_ALLOC_FAILURE=714;
var dlink_1_bw1_schld_help=715;
var wwa_note_hostname=716;
var ai_Action=717;
var RUNTIME_CONFIG_RESET_CONFIG_TO_FACTORY_DEFAULTS=718;
var sps_nopr=719;
var gw_hours=720;
var _Fri=721;
var tps_lpd=722;
var tf_FWUg=723;
var anet_wp_0=724;
var gw_gm_4=725;
var help373=726;
var tt_dsoffs=727;
var wwz_auto_assign_key=728;
var gw_gm_15=729;
var wwl_s3_note_1=730;
var hhts_save=731;
var at_Auto=732;
var help194=733;
var IPPPPIPCP_PPP_LINK_DOWN=734;
var aa_AT=735;
var gw_gm_71=736;
var aa_wiz_s1_msg3=737;
var BIGPOND_FAILED=738;
var help898=739;
var bwn_PPTPSIPA=740;
var _routing=741;
var hham_intro=742;
var WIFISC_IR_REGISTRATION_FAIL_3=743;
var ai_intro_1=744;
var wwa_title_s2=745;
var up_tz_69=746;
var IPMSCHAP_AUTH_RESULT=747;
var tss_intro2=748;
var help354=749;
var up_tz_19=750;
var ta_alert_5=751;
var bd_DAB=752;
var _WPAenterprise=753;
var GW_INET_ACCESS_DROP_ACCESS_CONTROL_MAC=754;
var sps_pr=755;
var up_tz_34=756;
var _psk=757;
var _dyndns=758;
var _deny=759;
var IPNAT_TCP_BLOCKED_INGRESS_UNEXP_FLAGS=760;
var help276=761;
var _to=762;
var aa_AT_0=763;
var dlink_hhwf_intro=764;
var tt_Dec=765;
var help879=766;
var GW_INET_ACCESS_POLICY_START_OTHERS=767;
var up_tz_72=768;
var tsc_pingt_msg11=769;
var up_ae_de_1=770;
var help781=771;
var help161_2=772;
var tt_time_19=773;
var am_intro=774;
var help811=775;
var aw_TP_1=776;
var up_tz_24=777;
var IPMSCHAP_AUTH_SENT=778;
var sw_intro=779;
var tps_lpd1=780;
var help257=781;
var _upgintro=782;
var help819_8=783;
var bws_secs=784;
var IPNAT_ICMP_BLOCKED_EGRESS_PACKET=785;
var PORT_FORWARDING=786;
var bwn_Mode_DHCP=787;
var tt_Hour=788;
var help290a=789;
var BIGPOND_LOGGING_OUT=790;
var af_intro_1=791;
var hhan_mc=792;
var _dns1=793;
var _dns1_v6=794;
var _tools=795;
var _sdi_s2=796;
var sps_usbport=797;
var GW_SCHED_ALLOC_FAILED=798;
var help179=799;
var tt_dsen2=800;
var _allow=801;
var help798=802;
var tt_Oct=803;
var anet_wan_phyrate=804;
var _note=805;
var aa_FPR_c6=806;
var help69=807;
var bd_DLT=808;
var wwa_title_wel=809;
var ai_title_IFRL=810;
var GW_LAN_INTERFACE_UP=811;
var _logs=812;
var am_FM_2=813;
var GW_LOG_EMAIL_ON_USER_REQUEST=814;
var help21=815;
var bwl_Mode=816;
var dlink_help145=817;
var bwn_AM=818;
var bwn_BPS=819;
var _ispinfo=820;
var _rate=821;
var help321=822;
var up_tz_06=823;
var _success=824;
var _bsecure_parental_serv=825;
var wwa_set_l2tp_title=826;
var wwz_wwl_title_s3=827;
var help342=828;
var help265=829;
var GW_SMTP_EMAIL_RESOLVED_DNS=830;
var tsc_pingt_msg101=831;
var bws_RSP=832;
var PPPOE_EVENT_CONNECT=833;
var tt_auto=834;
var PPTP_EVENT_LOW_RESOURCES_TO_QUEUE=835;
var IPL2TP_TUNNEL_UNEXPECTED_MESSAGE=836;
var gw_gm_34=837;
var tt_week_5=838;
var wwl_intro_end=839;
var aa_Policy_Table=840;
var tt_TimeConf=841;
var _none=842;
var _aa_wiz_s3_title=843;
var help392=844;
var GW_LOG_EMAIL_ON_SCHEDULE=845;
var wwa_intro_s2=846;
var _PPTPgw=847;
var WEB_FILTER_LOG_URL_ACCESSED=848;
var IPMMSALG_REJECTED_PACKET=849;
var _wirelesst=850;
var int_intro=851;
var GW_LAN_ACCESS_DENIED=852;
var gw_gm_26=853;
var PPTP_ALG_GRE_BLOCKED_INGRESS=854;
var up_tz_30=855;
var gw_gm_49=856;
var _sched=857;
var IPFAT_MOUNT_FAILED=858;
var gw_gm_75=859;
var help883=860;
var ta_alert_6=861;
var GW_INET_ACCESS_POLICY_START_IP=862;
var help841a=863;
var tt_time_23=864;
var ag_title_4=865;
var gw_gm_68=866;
var IPNAT_TCP_BLOCKED_EGRESS_UNEXP_FLAGS=867;
var help260=868;
var help819_4=869;
var help357=870;
var _TCP=871;
var IPMSCHAP_CHALLENGE_RECVD=872;
var anet_msg_upnp=873;
var help776=874;
var tt_alert_1only=875;
var help32=876;
var gw_gm_3=877;
var help823=878;
var _L2TPip=879;
var _reboot=880;
var wps_p3_1=881;
var wprn_intro5=882;
var _bsecure_security_serv=883;
var tsc_pingt_msg8=884;
var gw_gm_56=885;
var help286=886;
var tf_intro_FWU=887;
var up_tz_57=888;
var GW_FW_NOTIFY_RESOLVED_DNS=889;
var af_EFT_2=890;
var up_tz_00=891;
var hhts_intro=892;
var _auth=893;
var IPL2TP_TUNNEL_DISCONNECTING=894;
var NET_RTC_SYNCHRONIZATION_FAILED_AFTER_RETRIES=895;
var sd_FWV=896;
var tsc_SchRuLs=897;
var help188_wmm=898;
var help396=899;
var ta_SavConf=900;
var wwa_sdns=901;
var help876=902;
var help380=903;
var _netfilt=904;
var gw_days=905;
var li_Login=906;
var WAN_ALREADY_CONNECTED=907;
var bws_WPAM_3=908;
var GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS=909;
var td_PWK=910;
var tool_admin_vsname=911;
var up_tz_50=912;
var static_PPPoE=913;
var tsc_StrTime=914;
var tsc_pingt_msg104=915;
var wprn_iderr=916;
var wps_KR42=917;
var td_Timeout=918;
var _aa_apply_web_filter=919;
var resetUnconfiged=920;
var GAMING=921;
var tt_time_9=922;
var IPNAT_BLOCKED_INGRESS=923;
var GW_WAN_INTERFACE_UP=924;
var _ripaddr=925;
var sa_TimeOut=926;
var IPNAT_TCP_BLOCKED_EGRESS_BAD_SEQ=927;
var GW_LAN_INTERFACE_DOWN=928;
var help778=929;
var sps_qname=930;
var _seconds=931;
var GW_LOGS_CLEARED=932;
var sl_Warning=933;
var aa_MAC=934;
var wps_KR51=935;
var help274=936;
var aw_sgi_h1=937;
var IPSTACK_REJECTED_SOURCE_ROUTED_PACKET=938;
var wwa_pdns=939;
var help834=940;
var _Sun=941;
var bd_title_clients=942;
var wwz_auto_assign_key2=943;
var sw_title_list=944;
var up_tz_15=945;
var help316=946;
var IPL2TP_TUNNEL_CONNECTING=947;
var af_ES=948;
var NET_RTC_SYNCHRONIZED=949;
var up_tz_10=950;
var bwn_RM_1=951;
var NOT_LOGGED_IN_PLEASE_REFRESH=952;
var IPSEC_ALG_ESP_BLOCKED_INGRESS=953;
var ub_continue=954;
var td_UNK=955;
var IPPMVM_MOUNT_FAILED=956;
var gw_gm_42=957;
var _1066=958;
var tsc_AllWk=959;
var _virtserv=960;
var help2=961;
var help869=962;
var IPPPPLCP_SET_LOCAL_OPTIONS=963;
var ts_rd=964;
var IPSEC_ALG_REJECTED_PACKET=965;
var tsc_pingt_msg3=966;
var GW_WIRELESS_DEVICE_DISCONNECTED=967;
var help333=968;
var sd_WRadio=969;
var ALLOWED_WEB_SITES=970;
var gw_sa_1=971;
var _UDP=972;
var help166=973;
var help117=974;
var bwn_L2TPICT=975;
var help795=976;
var _no=977;
var up_tz_63=978;
var tf_FWF1=979;
var up_tz_65=980;
var _priority=981;
var WAN_ALREADY_DISCONNECTED=982;
var up_jt_1=983;
var GW_INET_ACCESS_INITIAL_OTHERS=984;
var hhai_ip=985;
var as_intro_SA=986;
var anet_wan_ping_1=987;
var up_tz_44=988;
var help27=989;
var as_IPSec=990;
var _admin=991;
var gw_gm_65=992;
var tf_intro_FWChB=993;
var BLOCKED=994;
var wwa_msg_bigpond=995;
var tsl_EnLog=996;
var help819_5=997;
var aw_TP_2=998;
var bwsAT_=999;
var _setupdone=1000;
var li_intro=1001;
var IPSMTPCLIENT_MSG_FAILED=1002;
var bwz_note_ConWz=1003;
var gw_gm_64=1004;
var help268=1005;
var NONE_BLOCKED=1006;
var tt_May=1007;
var bwn_BPICT=1008;
var tt_time_15=1009;
var _Tue=1010;
var ss_clear_stats=1011;
var help197=1012;
var ai_intro_3=1013;
var GW_WAN_DISCONNECT_ON_INACTIVE=1014;
var DHCP_CLIENT_RELEASED_LEASE=1015;
var wwa_set_sipa_title=1016;
var up_tz_71=1017;
var hhaf_alg=1018;
var help843=1019;
var wprn_tt11=1020;
var _tstats=1021;
var IPPPPLCP_SET_REMOTE_OPTIONS=1022;
var tf_COLF=1023;
var up_tz_28=1024;
var tt_Mar=1025;
var _aa_allow_all=1026;
var wwa_wanmode_l2tp=1027;
var _dmzh=1028;
var GW_TIME_RESOLVED_DNS=1029;
var bws_EAPx=1030;
var aa_PolName=1031;
var wwa_set_sipa_msg=1032;
var _aa_wiz_s2_title=1033;
var PPTP_EVENT_TUNNEL_CONNECTED=1034;
var USB_LOG_STORAGE_NOT_FOUND=1035;
var GW_INIT_DONE=1036;
var carriertype_ct_0=1037;
var help305=1038;
var tps_raw=1039;
var av_PubP=1040;
var help374=1041;
var PPTP_EVENT_TUNNEL_CLEAR_DOWN_REQUEST=1042;
var hhac_delete=1043;
var IPL2TP_SESSION_CLEAR_DOWN_REQUEST=1044;
var aa_ACR_c2=1045;
var help29=1046;
var up_tz_01=1047;
var _app=1048;
var bln_alert_1=1049;
var GW_WAN_RATE_ESTIMATOR_STARTED_ON_WAN=1050;
var sl_FWandSec=1051;
var hhan_ping=1052;
var sa_NAT=1053;
var hhta_en=1054;
var GW_SMTP_EMAIL_FAILED_DNS=1055;
var help810=1056;
var _WOL=1057;
var help272=1058;
var help819_1=1059;
var IPNAT_TCP_BLOCKED_INGRESS_ICMP_ERROR_PACKET=1060;
var up_tz_14=1061;
var gw_gm_51=1062;
var td_SvAd=1063;
var hhag_40=1064;
var help169=1065;
var help324=1066;
var htsc_intro=1067;
var KR4_ww=1068;
var help317=1069;
var anet_multicast=1070;
var anet_multicast_v4=1071;
var anet_multicast_v6=1072;
var _aa_wiz_s1_title=1073;
var IPL2TP_SHUTDOWN_COMPLETE=1074;
var help819_7=1075;
var help9=1076;
var help809=1077;
var GW_LAN_CARRIER_DETECTED=1078;
var sl_alert_1=1079;
var as_TPRange_b=1080;
var tt_week_1=1081;
var up_jt_3=1082;
var _clear=1083;
var PPPOE_EVENT_DISCONNECT=1084;
var WIFISC_IR_REGISTRATION_FAIL_2=1085;
var _sdi_staticip=1086;
var wwa_msg_set_dhcp=1087;
var hhts_name=1088;
var WAN=1089;
var help825=1090;
var hham_add=1091;
var ss_WANStats=1092;
var GW_WAN_CONNECT_ON_ACTIVE=1093;
var aa_sched_conf_1=1094;
var GW_INET_ACCESS_POLICY_END_OTHERS=1095;
var bd_title_list=1096;
var _aa_logging=1097;
var IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET=1098;
var _username=1099;
var _enable=1100;
var GW_TIME_FAILED_DNS=1101;
var wprn_tt1=1102;
var tt_time_22=1103;
var help256=1104;
var GW_INET_ACCESS_INITIAL_IP_FAIL=1105;
var _aa_details=1106;
var help36=1107;
var help817=1108;
var bwn_Mode_PPPoE=1109;
var _allowall=1110;
var awf_clearlist=1111;
var sc_intro_rb3=1112;
var help67=1113;
var gw_gm_37=1114;
var up_ae_wic_3=1115;
var wwa_title_s1=1116;
var tps_drname=1117;
var tt_CopyTime=1118;
var IPL2TP_SEQUENCING_ACTIVATED=1119;
var bd_Reserve=1120;
var IPMSNMESSENGERALG_REJECTED_PACKET=1121;
var help782=1122;
var gw_gm_16=1123;
var IPPORTFORWARDALG_UDP_PACKET_ALLOC_FAILURE=1124;
var wprn_mod=1125;
var help119=1126;
var gw_gm_46=1127;
var am_FM_3=1128;
var sps_lpd1=1129;
var tss_SysSt=1130;
var ta_ResConf=1131;
var WCN_LOG_SAVE=1132;
var as_FPrt=1133;
var help823_11=1134;
var tsc_EvDay=1135;
var ham_del=1136;
var _PPPoE=1137;
var wwa_intro_online1=1138;
var tt_dstend=1139;
var tsc_SchRu=1140;
var GW_AUTH_FAILED=1141;
var _scheds=1142;
var up_tz_56=1143;
var _dns2=1144;
var _dns2_v6=1145;
var tsc_pingt_msg2=1146;
var tps_apc1=1147;
var GW_INET_ACCESS_DROP_ACCESS_CONTROL_WITH_PORT=1148;
var up_tz_48=1149;
var _password_admin=1150;
var bd_intro_=1151;
var help387=1152;
var GW_AUTH_SUCCEEDED=1153;
var IPPPPCHAP_AUTH_SENT=1154;
var _bsecure_parental_blurb=1155;
var _aa_wiz_s1_msg=1156;
var help807=1157;
var up_tz_61=1158;
var _L2TPgw=1159;
var IPMSCHAP_AUTH_FAIL=1160;
var help395=1161;
var help880=1162;
var gw_gm_29=1163;
var help95=1164;
var aw_BP=1165;
var GW_WAN_SERVICES_STOPPED=1166;
var gw_gm_79=1167;
var help850=1168;
var help4=1169;
var up_tz_18=1170;
var help168a=1171;
var PPTP_ALG_REJECTED_PACKET=1172;
var te_SMTPSv=1173;
var help334=1174;
var gw_gm_84=1175;
var IPL2TP_LOW_RESOURCES=1176;
var hhac_add=1177;
var anet_wp_auto2=1178;
var as_RTSP=1179;
var _authsecmodel=1180;
var bwn_MTU=1181;
var gw_gm_72=1182;
var _WAN=1183;
var help10=1184;
var gw_gm_8=1185;
var _WPA=1186;
var help897=1187;
var IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ=1188;
var tsc_pingt_msg7=1189;
var tt_Jan=1190;
var gw_gm_5=1191;
var _adwwls=1192;
var tsc_pingt_msg100=1193;
var gw_gm_55=1194;
var wwa_intro_s1=1195;
var anet_wan_ping=1196;
var GW_DHCP_SERVER_WINS_INCOMPATIBILITY_WARNING=1197;
var dlink_help146=1198;
var bws_RMAA=1199;
var aa_wiz_s1_msg2=1200;
var tt_time_7=1201;
var help822a=1202;
var gw_gm_1=1203;
var up_tz_37=1204;
var bws_SM=1205;
var up_tz_68=1206;
var wwl_s4_intro_za3=1207;
var _prev=1208;
var bwl_EW=1209;
var wprn_foo1=1210;
var help355=1211;
var aa_ACR_c6=1212;
var bws_2RSSS=1213;
var help391=1214;
var _PM=1215;
var help174=1216;
var PPPOE_EVENT_DISCOVERY_TIMEOUT=1217;
var WCN_LOG_NO_WSETTING=1218;
var haar_p=1219;
var anet_wan_ping_2=1220;
var help878=1221;
var LOGGED=1222;
var bwn_RM_2=1223;
var bws_RSSs=1224;
var up_tz_43=1225;
var IPRTSPALG_REJECTED_PACKET=1226;
var GW_SCHEDULES_IN_USE_INVALID_s2=1227;
var help1=1228;
var gw_gm_73=1229;
var hhtsn_intro=1230;
var tsc_pingr=1231;
var at_UpSp=1232;
var aa_wiz_s1_msg6=1233;
var _PPTPip=1234;
var help185=1235;
var help799=1236;
var up_tz_17=1237;
var sd_intro=1238;
var tf_Upload=1239;
var tt_Second=1240;
var wps_lost=1241;
var help26=1242;
var up_tz_35=1243;
var bwn_intro_ICS=1244;
var bwn_intro_ICS_3G=1245;
var help81=1246;
var help833=1247;
var tps_intro3=1248;
var ss_Sent=1249;
var help378=1250;
var gw_gm_80=1251;
var _uploadgood=1252;
var wps_p3_2=1253;
var wprn_s3c=1254;
var haf_dmz_20=1255;
var help343=1256;
var ss_Received=1257;
var help263=1258;
var _bsecure_free_trial=1259;
var tf_FUNO=1260;
var aw_sgi=1261;
var help386=1262;
var help254_ict=1263;
var help254_ict_3G=1264;
var _aa_wiz_s5_msg1=1265;
var td_VPWK=1266;
var gw_gm_33=1267;
var gw_gm_0=1268;
var _macfilt=1269;
var TA16=1270;
var bd_DAB_note=1271;
var help796=1272;
var tf_really_FWF=1273;
var up_tz_05=1274;
var tt_time_16=1275;
var help861=1276;
var help19=1277;
var bwn_DWM=1278;
var _ICMP=1279;
var gw_gm_22=1280;
var help868=1281;
var _password=1282;
var tt_time_6=1283;
var _501_12=1284;
var hhac_en=1285;
var int_LWlsWz=1286;
var at_STR=1287;
var tt_Aug=1288;
var am_FM_4=1289;
var aa_wiz_s1_msg5=1290;
var ACCESS_CONTROL=1291;
var GW_DYNDNS_HERROR=1292;
var sps_ports=1293;
var help851=1294;
var hhag_20=1295;
var aa_alert_7=1296;
var af_DI=1297;
var tf_ADS=1298;
var tsc_pingt_mesg=1299;
var sl_VLevs=1300;
var tsc_EndTime=1301;
var help151=1302;
var hhta_pt=1303;
var GW_INET_ACCESS_DROP_ACCESS_CONTROL=1304;
var ebwl_AChan=1305;
var WIFISC_AP_PROXY_PROCESS_CLOSE=1306;
var bd_CName=1307;
var help305rt=1308;
var li_alert_3=1309;
var GW_DYNDNS_UPDATE_TO=1310;
var tt_week_4=1311;
var tt_Day=1312;
var GW_LAN_CARRIER_LOST=1313;
var hhai_action=1314;
var help121=1315;
var bwl_Intro_1=1316;
var wwa_msg_set_pppoe=1317;
var IPNAT_ICMP_BLOCKED_INGRESS_PACKET=1318;
var tf_intro_FWU2=1319;
var tps_enraw=1320;
var _bsecure_security_blurb=1321;
var bd_DHCP=1322;
var help865=1323;
var wwl_s4_intro_z1=1324;
var help501=1325;
var help280=1326;
var help775=1327;
var _connect=1328;
var GW_BIGPOND_INIT=1329;
var _always=1330;
var _minutes=1331;
var as_IPR_b=1332;
var gw_gm_67=1333;
var GW_INET_ACCESS_DROP_BAD_PKT=1334;
var gw_gm_12=1335;
var gw_gm_25=1336;
var help846=1337;
var wps_KR37=1338;
var gw_gm_76=1339;
var GW_LOGS_VIEWED=1340;
var bws_msg_EAP=1341;
var WIFISC_IR_REGISTRATION_INPROGRESS=1342;
var hhsa_intro=1343;
var help856=1344;
var sa_Dir=1345;
var _bln_title_IGMPMemberships=1346;
var bwn_Mode_L2TP=1347;
var _Thu=1348;
var _ping=1349;
var help184=1350;
var _worksbest=1351;
var _unavailable=1352;
var IPFAT_INCOMPATIBLE_FILESYS=1353;
var IPNAT_TCP_BLOCKED_INGRESS_NOT_SYN=1354;
var up_tz_04=1355;
var sl_ApplySt=1356;
var IPPPPCHAP_CHALLENGE_RECVD=1357;
var help141=1358;
var bd_Revoke=1359;
var wprn_intro3=1360;
var _conuptime=1361;
var wprn_tt4=1362;
var help383=1363;
var tsc_pingt_msg6=1364;
var help821a=1365;
var PPPOE_EVENT_SESSION_OFFER_RECVD=1366;
var gw_gm_30=1367;
var bi_man=1368;
var help60=1369;
var ta_RAP=1370;
var bwn_Mode_BigPond=1371;
var wprn_cps2=1372;
var tt_dststart=1373;
var help164_1=1374;
var IPMSCHAP_AUTH_TIMEOUT=1375;
var sl_emailLog=1376;
var bwl_title_1=1377;
var bwn_BPP=1378;
var sl_reload=1379;
var wwl_title_s1=1380;
var IPDRIVE_MOUNT_FAILED=1381;
var int_ConWz=1382;
var help178=1383;
var help329=1384;
var IPL2TP_TUNNEL_DISCONNECTED=1385;
var help830=1386;
var help294=1387;
var up_tz_21=1388;
var tf_LFWD=1389;
var GW_BIGPOND_SUCCESS=1390;
var _denyall=1391;
var at_AC=1392;
var bwl_VS=1393;
var help327=1394;
var wprn_s2a=1395;
var td_=1396;
var PPTP_EVENT_TUNNEL_WINDOW_TIMEOUT=1397;
var aw_TP=1398;
var bwn_SIAICT=1399;
var help57=1400;
var bd_EDSv=1401;
var _sdi_s5=1402;
var wprn_man=1403;
var tt_time_3=1404;
var bwn_note_clientSW=1405;
var up_tz_20=1406;
var RIP_LOW_RESOURCES=1407;
var help266=1408;
var CONNECTED=1409;
var help265_5=1410;
var tsc_Days=1411;
var up_tz_13=1412;
var sd_General=1413;
var hhan_upnp=1414;
var help35=1415;
var help18=1416;
var bwz_psw=1417;
var tt_DaT=1418;
var help190=1419;
var help819_2=1420;
var bwn_MIT=1421;
var hhai_name=1422;
var te__title_EmLog=1423;
var up_tz_47=1424;
var IPSMTPCLIENT_DIALOG_FAILED=1425;
var hham_del=1426;
var wwa_msg_ispnot=1427;
var help808=1428;
var PPTP_EVENT_TUNNEL_ESTABLISH_REQUEST=1429;
var help37=1430;
var WCN_LOG_REBOOT=1431;
var PPTP_EVENT_TUNNEL_CONNECT_FAIL=1432;
var bwl_CWM=1433;
var up_tz_12=1434;
var _cancel=1435;
var ta_EUPNP=1436;
var bln_EnDNSRelay=1437;
var up_tz_38=1438;
var aw_DI=1439;
var up_tz_31=1440;
var hhai_delete=1441;
var av_intro_vs=1442;
var av_intro_if=1443;
var GW_WAN_RECONNECT_ALWAYS_ON=1444;
var wwl_WSP=1445;
var INGRESS=1446;
var RESTRICTED=1447;
var bwn_msg_DHCPDesc=1448;
var help390=1449;
var help828=1450;
var help867=1451;
var GW_WAN_CONNECT_ALWAYS_ON=1452;
var IPRTSPALG_REJECTED_ODD_RTP_PACKET=1453;
var help60f=1454;
var gw_gm_10=1455;
var bwn_min=1456;
var tt_Month=1457;
var wwz_wpa_support=1458;
var tf_CFWD=1459;
var _advnetwork=1460;
var bwn_PPPOEICT=1461;
var help389=1462;
var help844=1463;
var tt_time_17=1464;
var help284=1465;
var GW_WIRELESS_DEVICE_ASSOCIATED=1466;
var bws_2RMAA=1467;
var as_SIP=1468;
var help704=1469;
var WIFISC_IR_REGISTRATION_FAIL_1=1470;
var up_tz_25=1471;
var help55=1472;
var GW_WLAN_LINK_UP=1473;
var td_EnDDNS=1474;
var ai_title_IFR=1475;
var _PPTP=1476;
var _both=1477;
var up_tz_40=1478;
var wprn_tt8=1479;
var tps_dsr=1480;
var _aa_other_machines=1481;
var help875=1482;
var awsf_p=1483;
var wwl_s4_intro_z2=1484;
var wwa_set_l2tp_msg=1485;
var up_tz_42=1486;
var _error=1487;
var aa_FPR_c4=1488;
var help75a=1489;
var network_dhcp_ip_in_server=1490;
var tf_msg_wired=1491;
var wwa_title_set_pppoe=1492;
var tsc_pingt_msg1=1493;
var bwl_CWM_h2=1494;
var dlink_1_add_new=1495;
var help884=1496;
var rb_Rebooting=1497;
var help819_6=1498;
var tt_time_10=1499;
var help199=1500;
var help259=1501;
var af_algconfig=1502;
var wwa_msg_pptp=1503;
var bws_2RIPA=1504;
var _aa_wiz_s4_title=1505;
var wwa_note_svcn=1506;
var help85=1507;
var help304=1508;
var GW_INET_ACCESS_DROP_PORT_FILTER_WITH_PORT=1509;
var sd_BPSt=1510;
var up_tz_49=1511;
var gw_gm_62=1512;
var BIGPOND_LOGGED_OUT=1513;
var tf_EmNew=1514;
var GW_INET_ACCESS_INITIAL_MAC_FAIL=1515;
var help303=1516;
var wwa_selectisp_not=1517;
var IPNAT_TCP_BLOCKED_EGRESS_BAD_ACK=1518;
var help94=1519;
var gw_gm_70=1520;
var IPNAT_ICMP_UNABLE_TO_HANDLE_HEADER=1521;
var _FTP=1522;
var _neft=1523;
var ta_A12n=1524;
var gw_gm_83=1525;
var GW_BIGPOND_LOGOUT=1526;
var help46=1527;
var hhsl_intro=1528;
var help770=1529;
var wwa_msg_set_pptp=1530;
var GW_FW_NOTIFY_FAILED_DNS=1531;
var gw_gm_40=1532;
var bln_IGMP_title_h=1533;
var hhaw_11d=1534;
var up_jt_2=1535;
var GW_INET_ACCESS_POLICY_START_MAC=1536;
var wwa_msg_pppoe=1537;
var help323=1538;
var ta_intro1=1539;
var tt_week_3=1540;
var _dhcpsrv=1541;
var Dynamic_PPPoE=1542;
var _enabled=1543;
var GW_DHCP_SERVER_WINS_MODE_INVALID=1544;
var GW_INET_ACCESS_RESTRICTED=1545;
var gw_gm_69=1546;
var aa_ACR_c5=1547;
var help331=1548;
var bwz_note_WlsWz=1549;
var help345=1550;
var hhav_name=1551;
var av_PriP=1552;
var tsc_pingt_msg103=1553;
var help_upnp_2=1554;
var WAN_MODE_INCORRECT=1555;
var wwl_alert_pv5_2_5=1556;
var _aa_wiz_s5_title=1557;
var KR22_ww=1558;
var _aa_wiz_s7_help=1559;
var IPL2TP_SEQUENCING_DEACTIVATED=1560;
var tps_apc=1561;
var up_tz_09=1562;
var tt_Jul=1563;
var GW_WAN_INTERFACE_DOWN=1564;
var WCN_LOG_RESTORE=1565;
var gw_gm_17=1566;
var GW_INET_ACCESS_INITIAL_IP=1567;
var _wizquit=1568;
var tss_intro=1569;
var af_EFT_0=1570;
var help318=1571;
var tsl_intro=1572;
var tt_time_4=1573;
var tt_time_21=1574;
var IPL2TP_SESSION_CONNECTED=1575;
var aw_FT=1576;
var _save=1577;
var at_NEst=1578;
var help888=1579;
var _firmware=1580;
var gw_gm_43=1581;
var wps_messgae1_1=1582;
var IPL2TP_SHUTDOWN_STARTED=1583;
var ss_TXPD=1584;
var up_tz_55=1585;
var wwa_intro_online2=1586;
var help50=1587;
var help70=1588;
var wwl_enc=1589;
var bd_title_SDC=1590;
var up_tz_60=1591;
var gw_gm_54=1592;
var bws_ORAD=1593;
var GW_ADMIN_LOGOUT=1594;
var gw_gm_44=1595;
var bwn_RPing=1596;
var igmp_e_h=1597;
var help806=1598;
var dlink_wf_op_0=1599;
var help49=1600;
var help367=1601;
var gw_gm_28=1602;
var help337=1603;
var ta_AdmSt=1604;
var _syslog=1605;
var up_tz_08=1606;
var help394=1607;
var _aa_wiz_s7_title=1608;
var tt_intro_Time=1609;
var GW_DYNDNS_SERROR=1610;
var wwl_s3_note_2=1611;
var help262=1612;
var sps_port=1613;
var help164_2=1614;
var help881=1615;
var _destip=1616;
var help840=1617;
var wwa_l2tp_svra=1618;
var tt_dsdates=1619;
var help34b=1620;
var tt_time_11=1621;
var te_EnEmN=1622;
var help786=1623;
var bwn_UN=1624;
var aa_alert_8=1625;
var ta_ERM=1626;
var IPPPPLCP_SET_REMOTE_AUTH=1627;
var IPL2TP_FATAL_TIMEOUT=1628;
var hhaf_ngss=1629;
var bln_title_NetSt=1630;
var av_traftype=1631;
var bwn_Mode_PPTP=1632;
var help140=1633;
var wprn_rppd=1634;
var hhsd_intro=1635;
var IPMSCHAP_AUTH_SUCCESS=1636;
var help63=1637;
var wps_messgae1_2=1638;
var ap_intro_sv=1639;
var _L2TPsubnet=1640;
var GW_LOG_EMAIL_BEFORE_REBOOT=1641;
var at_Any=1642;
var help288=1643;
var bws_SM_h1=1644;
var help177=1645;
var up_tz_46=1646;
var rb_wait=1647;
var bwl_NN=1648;
var IPL2TP_SESSION_CONNECT_FAIL=1649;
var gw_gm_21=1650;
var wwl_BEST=1651;
var _support=1652;
var aa_alert_14=1653;
var _cablestate=1654;
var help314=1655;
var wps_LW13=1656;
var sl_Critical=1657;
var sc_intro_sv=1658;
var SYSTEM_LOG_INACTIVE=1659;
var bwn_mici=1660;
var gw_mins=1661;
var help852=1662;
var _In=1663;
var help870=1664;
var gw_gm_74=1665;
var help797=1666;
var gw_gm_39=1667;
var wwl_alert_pv5_3_10=1668;
var help149=1669;
var hhpt_intro=1670;
var GW_WAN_CARRIER_DETECTED=1671;
var bwn_BPU=1672;
var help195=1673;
var help823_1=1674;
var _internetc=1675;
var tsc_pingt_msg5=1676;
var help172=1677;
var _trigger=1678;
var help783=1679;
var ub_intro_2=1680;
var hhta_pw=1681;
var _aa_wiz_s8_title=1682;
var help173=1683;
var help771=1684;
var tsl_SLSIPA=1685;
var _aa_wiz_s7_msg=1686;
var tt_time_13=1687;
var up_tz_67=1688;
var help289a=1689;
var BIGPOND_LOGGED_IN=1690;
var haf_dmz_10=1691;
var help819=1692;
var wprn_s3b=1693;
var sps_tcpport=1694;
var dlink_wf_intro=1695;
var _websfilter=1696;
var sd_BPSN=1697;
var _password_user=1698;
var GW_INET_ACCESS_POLICY_END_IP=1699;
var bwn_msg_Modes=1700;
var up_gX_1=1701;
var _next=1702;
var _setup=1703;
var htsc_pingt_s=1704;
var EMAIL=1705;
var _mode=1706;
var tt_Feb=1707;
var sps_raw1=1708;
var GW_DYNDNS_SUCCESS=1709;
var IPPORTFORWARDALG_TCP_PACKET_ALLOC_FAILURE=1710;
var IGMP_ROUTER_LOW_RESOURCES=1711;
var bwl_CWM_h1=1712;
var up_tz_39=1713;
var help40=1714;
var td_intro_DDNS_DLINK=1715;
var _pf=1716;
var IPNAT_UDP_UNABLE_TO_HANDLE_HEADER=1717;
var GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS_WARNING=1718;
var GW_INET_ACCESS_INITIAL_MAC=1719;
var IPPPPCHAP_AUTH_SUCCESS=1720;
var help187=1721;
var _aa_block_all=1722;
var GW_WLAN_LINK_DOWN=1723;
var help379=1724;
var up_tz_70=1725;
var IPNAT_ICMP_BLOCKED_INGRESS_ICMP_ERROR_PACKET=1726;
var GW_SCHEDULES_IN_USE_INVALID_s1=1727;
var fb_p_2=1728;
var sps_ps=1729;
var help47=1730;
var wwa_title_s4=1731;
var tt_time_18=1732;
var help860=1733;
var GW_UPNP_IGD_PORTMAP_RELEASE=1734;
var wwa_intro_s4=1735;
var help267=1736;
var IPL2TP_SESSION_ABORTED=1737;
var help874=1738;
var tt_Sep=1739;
var IPSEC_ALG_ESP_UNABLE_TO_HANDLE_HEADER=1740;
var bws_GKUI=1741;
var hhaw_wmm=1742;
var help168c=1743;
var BIGPOND_LOGGING_IN=1744;
var wwa_wanmode_pptp=1745;
var help58=1746;
var help885=1747;
var ddns_connected=1748;
var ub_Upload_Failed=1749;
var WIFISC_AP_PROXY_END_ON_MSG=1750;
var help278=1751;
var htsc_pingt_h=1752;
var hhts_def=1753;
var help255=1754;
var bws_2RSP=1755;
var help7=1756;
var bwl_VS_0=1757;
var af_TEFT=1758;
var help86=1759;
var sd_NNSSID=1760;
var wt_p_2=1761;
var _gateway=1762;
var tt_CurTime=1763;
var _AM=1764;
var DISCONNECTED=1765;
var gw_gm_47=1766;
var up_tz_22=1767;
var WIFISC_IR_REGISTRATION_SESSION_OVERLAP=1768;
var _pwsame=1769;
var GW_DYNDNS_UPDATE_IP=1770;
var GW_DHCPSERVER_NEW_ASSIGNMENT=1771;
var as_WM=1772;
var up_tz_03=1773;
var ta_msg_TW=1774;
var wps_p3_3=1775;
var help774=1776;
var hhac_edit=1777;
var up_tz_36=1778;
var _hostname=1779;
var GW_INET_ACCESS_INITIAL_FAIL=1780;
var GW_WEB_FILTER_INITIAL_FAIL=1781;
var te_OnSch=1782;
var wwl_title_s4=1783;
var help281=1784;
var gw_gm_77=1785;
var _clonemac=1786;
var hhss_intro=1787;
var at_MUS=1788;
var hhan_wans=1789;
var help892=1790;
var help382=1791;
var tsc_hrmin=1792;
var tsc_hrmin1=1793;
var help82=1794;
var gw_gm_24=1795;
var gw_gm_13=1796;
var aw_RT=1797;
var help340=1798;
var sd_WLAN=1799;
var help864=1800;
var dlink_1_YM23=1801;
var tf_intro_FWU1=1802;
var wprn_bados=1803;
var _metric=1804;
var INBOUND_FILTER=1805;
var IPNAT_UDP_BLOCKED_INGRESS=1806;
var help351=1807;
var wwz_manual_key2=1808;
var _PPTPsubnet=1809;
var help20=1810;
var gw_gm_6=1811;
var bws_WPAM=1812;
var wwl_GOOD=1813;
var gw_gm_36=1814;
var help894=1815;
var _subnet=1816;
var PPTP_EVENT_REMOTE_WINDOW_SIZE=1817;
var wps_KR35=1818;
var help329_rsv=1819;
var gw_gm_58=1820;
var GW_WAN_MODE_IS=1821;
var ns_intro_=1822;
var IPDNSRELAYALG_REJECTED_PACKET=1823;
var ss_intro=1824;
var KR112=1825;
var GW_WLAN_11A_CH_MID_BAND_WARN=1826;
var KR106=1827;
var KR108=1828;
var GW_NAT_CONFLICTING_CONNECTIONS_LOG=1829;
var KR111=1830;
var KR109=1831;
var GW_NAT_CONFLICTING_CONNECTIONS_WARNING=1832;
var GW_PURE_SETACCESSPOINTMODE=1833;
var GW_NAT_REJECTED_SPOOFED_PACKET=1834;
var KR110=1835;
var GW_ROUTES_ROUTE_GATEWAY_NOT_IN_SUBNET_WARNING=1836;
var KR107=1837;
var KR105=1838;
var IPSTACK_REJECTED_LAND_ATTACK=1839;
var LS321=1840;
var KR67=1841;
var YM71=1842;
var GW_FIREWALL_RANGE_DUPLICATED_INVALID=1843;
var LS422=1844;
var bwz_LWCNWz=1845;
var GW_WAN_WAN_GATEWAY_IP_ADDRESS_INVALID=1846;
var ta_wcn=1847;
var LW57=1848;
var _wepkey2=1849;
var help145=1850;
var tsc_pingt_msg109=1851;
var bd_NETBIOS_REG_TYPE=1852;
var ap_intro_cont=1853;
var LW60=1854;
var _rs_failed=1855;
var KR62=1856;
var KR20=1857;
var at_intro_2=1858;
var bd_NETBIOS_ENABLE=1859;
var KR77=1860;
var help364=1861;
var _aa_bsecure_shopping=1862;
var _aa_bsecure_public_proxies=1863;
var wepkey1=1864;
var ZM11=1865;
var tsc_start_time=1866;
var YM69=1867;
var KR82=1868;
var LW39b=1869;
var GW_SCHEDULES_NAME_RESERVED_INVALID=1870;
var LW12=1871;
var YM75=1872;
var GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID=1873;
var GW_WLAN_WPA_REKEY_TIME_INVALID=1874;
var bws_msg_WEP_1=1875;
var KR58=1876;
var _aa_bsecure_gambling=1877;
var KR14=1878;
var GW_SMTP_FROM_ADDRESS_INVALID=1879;
var KR89=1880;
var help106=1881;
var LW35=1882;
var YM151=1883;
var YM2=1884;
var ta_wcn_note=1885;
var YM131=1886;
var GW_WEB_SERVER_SAME_PORT_LAN=1887;
var KR25=1888;
var YM3=1889;
var GW_NAT_WOL_ALG_ACTIVATED_WARNING=1890;
var YM20=1891;
var YM141=1892;
var GW_WAN_MAC_ADDRESS_INVALID=1893;
var IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT=1894;
var YM146=1895;
var LS151=1896;
var GW_QOS_RULES_NAME_INVALID=1897;
var GW_NAT_VS_PROTO_CONFLICT_INVALID=1898;
var GW_WISH_RULES_NAME_INVALID=1899;
var WIFISC_IR_REGISTRATION_FAIL=1900;
var r_rlist=1901;
var KR18=1902;
var bws_WKL_1=1903;
var sa_Originator=1904;
var aw_erpe=1905;
var GW_NAT_PORT_FORWARD_RANGE_BOTH_EMPTY_INVALID=1906;
var GW_ROUTES_GATEWAY_IP_ADDRESS_IN_SUBNET_INVALID=1907;
var LW37=1908;
var tsc_pingdisallowed=1909;
var ZM20=1910;
var help376=1911;
var GW_FW_NOTIFY_EMAIL_DISABLED_INVALID=1912;
var YM122=1913;
var GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID=1914;
var _sdi_s7=1915;
var at_title_SESet=1916;
var GW_INET_ACL_START_PORT_INVALID=1917;
var IPSMTPCLIENT_DATA_FAILED=1918;
var KR91=1919;
var _aa_bsecure_opinion=1920;
var tss_RestAll_b=1921;
var GW_NAT_PORT_TRIGGER_CONFLICT_INVALID=1922;
var LW54=1923;
var TA7=1924;
var KR74=1925;
var bws_DFWK=1926;
var LW46=1927;
var IPSMTPCLIENT_RESOLVED_DNS=1928;
var help110=1929;
var YM107=1930;
var YM180=1931;
var GW_WAN_WAN_SUBNET_INVALID=1932;
var GW_NAT_DMZ_DISABLED_WARNING=1933;
var YM93=1934;
var GW_NAT_FTP_ALG_ACTIVATED_WARNING=1935;
var _aa_bsecure_free_host=1936;
var _r_alert2=1937;
var LS47=1938;
var GW_DHCP_SERVER_SUBNET_SIZE_INVALID=1939;
var GW_INET_ACCESS_POLICY_TOO_MANY_MAC_INVALID=1940;
var GW_FIREWALL_START_IP_ADDRESS_INVALID=1941;
var YM8=1942;
var GW_WISH_RULES_PRIORITY_RANGE=1943;
var _aa_bsecure_travel=1944;
var help113=1945;
var ZM6=1946;
var bws_length=1947;
var help836=1948;
var rs_intro_2=1949;
var GW_INET_ACL_IP_ADDRESS_DUPLICATION_INVALID=1950;
var KR7=1951;
var ZM1=1952;
var hhta_831=1953;
var LW30=1954;
var YM110=1955;
var bd_NETBIOS_REG_TYPE_P=1956;
var GW_LAN_SUBNET_MASK_INVALID=1957;
var YM88=1958;
var GW_DHCP_SERVER_NETBIOS_PRIMARY_WINS_INVALID=1959;
var YM187=1960;
var GW_NAT_NAME_UNDEFINED_INVALID=1961;
var GW_WIRELESS_RADAR_DETECTED=1962;
var LW25=1963;
var _rs_invalid=1964;
var YM113=1965;
var LW65=1966;
var KR41=1967;
var GW_WAN_DNS_SERVER_PRIMARY_INVALID=1968;
var KR21=1969;
var _aa_bsecure_personals=1970;
var KR63=1971;
var LW31=1972;
var GW_WAN_DNS_SERVER_SECONDARY_INVALID=1973;
var LW29=1974;
var YM55=1975;
var KR37=1976;
var KR80=1977;
var YM100=1978;
var _wakeonlan=1979;
var rs_intro_3=1980;
var YM47=1981;
var YM7=1982;
var YM124g=1983;
var GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID=1984;
var YM66=1985;
var LT124=1986;
var bd_NETBIOS=1987;
var sa_Target=1988;
var help56_a=1989;
var GW_DHCP_SERVER_RECONFIG_WARNING=1990;
var _wifisc_addfail=1991;
var GW_WLAN_BEACON_PERIOD_INVALID=1992;
var YM79=1993;
var YM32=1994;
var ta_intro_wcn=1995;
var wwl_text_better=1996;
var YM78=1997;
var sd_channel=1998;
var KR53=1999;
var LW16=2000;
var GW_NAT_TCP=2001;
var help202=2002;
var CRIT=2003;
var YM154=2004;
var help76=2005;
var GW_WISH_RULES_HOST1_PORT=2006;
var GW_WLAN_11G_TURBO_INVALID=2007;
var _aa_bsecure_entertainment=2008;
var YM165=2009;
var help48=2010;
var _aa_bsecure_lifestyles=2011;
var GW_NAT_DMZ_NOT_IN_SUBNET_INVALID=2012;
var sd_TMode=2013;
var GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID=2014;
var GW_INET_ACL_NO_FILTER_SELECTED_INVALID=2015;
var GW_QOS_RULES_LOCAL_IP_END_SUBNET=2016;
var bws_CT_2=2017;
var _bsecure_parental_limits=2018;
var aw_64=2019;
var _aa_bsecure_humor=2020;
var KR92=2021;
var KR13=2022;
var GW_INET_ACL_POLICY_NAME_DUPLICATE_INVALID=2023;
var YM136=2024;
var TA3=2025;
var help360=2026;
var YM10=2027;
var GW_WAN_PPTP_SERVER_IP_ADDRESS_INVALID=2028;
var YM150=2029;
var GW_DHCP_SERVER_RESERVATION_IN_USE=2030;
var GW_NAT_INPUT_PORT=2031;
var WIFISC_AP_REBOOT_COMPLETE=2032;
var YM182=2033;
var LW3=2034;
var YM116=2035;
var LW22=2036;
var OPEN=2037;
var YM158=2038;
var ZM16=2039;
var _aa_bsecure_select_age=2040;
var GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID=2041;
var WIFISC_AP_RESET_COMPLETE=2042;
var bd_NETBIOS_REG=2043;
var GW_LAN_GATEWAY_IP_ADDRESS_INVALID=2044;
var KR96=2045;
var GW_XML_CONFIG_GET_SUCCESS=2046;
var _ask_nochange=2047;
var GW_UPNP_IGD_PORTMAP_REFRESH=2048;
var bws_msg_WPA_2=2049;
var GW_LAN_IP_ADDRESS_INVALID=2050;
var KR5=2051;
var help88c=2052;
var GW_INET_ACL_SCHEDULE_NAME_INVALID=2053;
var GW_QOS_RULES_REMOTE_PORT=2054;
var GW_NAT_IP_ADDRESS_INVALID=2055;
var help369=2056;
var help48a=2057;
var LW38=2058;
var GW_DYNDNS_USER_NAME_INVALID=2059;
var hhav_r_dest_ip=2060;
var YM175=2061;
var LY3=2062;
var GW_UPNP_IGD_PORTMAP_ADD=2063;
var GW_UPNP_IGD_PORTMAP_CONFLICT=2064;
var KRA1=2065;
var _vs_port=2066;
var GW_INET_ACL_RECONFIGURED_WARNING=2067;
var help80b=2068;
var YM145=2069;
var WIFISC_AP_UNSET_SELECTED_REGISTRAR=2070;
var GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID=2071;
var YM72=2072;
var _hints=2073;
var GW_QOS_RULES_LOCAL_PORT=2074;
var YM52=2075;
var _aa_bsecure_chat=2076;
var help104=2077;
var help839=2078;
var YM99=2079;
var _aa_bsecure_byage=2080;
var GW_INET_ACL_NAME_DUPLICATE_INVALID=2081;
var GW_DHCP_SERVER_POOL_TO_INVALID=2082;
var KR26=2083;
var YM92=2084;
var GW_DHCP_SERVER_RESERVED_IP_INVALID=2085;
var help19x1=2086;
var _aa_bsecure_unstable=2087;
var GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID=2088;
var GW_FIREWALL_FILTER_NAME_INVALID=2089;
var ZM19=2090;
var YM80=2091;
var bd_NETBIOS_WINS_2=2092;
var KR57=2093;
var YM164=2094;
var _logsyslog_alert2=2095;
var YM149=2096;
var LT120=2097;
var KR48=2098;
var GW_WAN_RECONNECT_INTERVAL_INVALID=2099;
var YM139=2100;
var YM61=2101;
var GW_NAT_VIRTUAL_SERVER_TABLE_RECONFIGURED_WARNING=2102;
var YM1=2103;
var bws_WKL=2104;
var LY5=2105;
var KR102=2106;
var GW_QOS_RULES_LOCAL_IP_START_SUBNET=2107;
var GW_WAN_PPTP_IP_ADDRESS_INVALID=2108;
var _aa_bsecure_alcohol=2109;
var YM14=2110;
var GW_WLAN_11B_DYNAMIC_TURBO_INVALID=2111;
var GW_UPNP_IGD_PORTMAP_EXPIRE=2112;
var help107=2113;
var aw_erpe_h2=2114;
var YM21=2115;
var YM147=2116;
var KR68=2117;
var LW61=2118;
var GW_WAN_L2TP_USERNAME_INVALID=2119;
var LT120z=2120;
var KR97=2121;
var GW_WAN_L2TP_SUBNET_INVALID=2122;
var help_ts_ss=2123;
var _aa_bsecure_automobile=2124;
var LW13=2125;
var sch_time=2126;
var bws_intro_WlsSec=2127;
var GW_WAN_PPPOE_PASSWORD_INVALID=2128;
var help211=2129;
var LS202=2130;
var tsc_end_time=2131;
var KR34=2132;
var _wepkey3=2133;
var at_RePortR=2134;
var _vs_other=2135;
var GW_SMTP_SERVER_ADDRESS_INVALID=2136;
var GW_WAN_L2TP_GATEWAY_IP_ADDRESS_INVALID=2137;
var LW58=2138;
var LW22usekey=2139;
var GW_WLAN_11B_STATIC_TURBO_INVALID=2140;
var YM67=2141;
var GW_WIFISC_CFG_CHANGED_WARNING=2142;
var ZM10=2143;
var GW_WLAN_11A_CHANNEL_INVALID=2144;
var at_title_SERules=2145;
var YM176=2146;
var KR81=2147;
var GW_NAT_TCP_PORT=2148;
var YM155=2149;
var help365=2150;
var bd_NETBIOS_SCOPE=2151;
var KR28=2152;
var _webfilter=2153;
var YM33=2154;
var YM76=2155;
var WIFISC_AP_SETUP_UNLOCKED=2156;
var GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=2157;
var LS313=2158;
var bwz_WCNWz=2159;
var ZM9=2160;
var GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID=2161;
var LW7=2162;
var YM87=2163;
var GW_NAT_WAN_PING_FILTER_INVALID=2164;
var help835=2165;
var at_lowpriority=2166;
var YM49=2167;
var GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID=2168;
var YM112=2169;
var KR90=2170;
var help838=2171;
var at_ETS=2172;
var KR73=2173;
var wwl_intro_s3_2=2174;
var _r_alert5=2175;
var GW_NAT_WAN_PING_FILTER_WARNING=2176;
var YM53=2177;
var help215=2178;
var YM140=2179;
var GW_DHCPSERVER_REJECTED=2180;
var YM142=2181;
var GW_DYNDNS_PASSWORD_INVALID=2182;
var YM152=2183;
var LT119a=2184;
var LW36=2185;
var help377=2186;
var GW_NAT_PORT_TRIGGER_PORT_RANGE_INVALID=2187;
var YM121=2188;
var YM29=2189;
var YM159=2190;
var YM120=2191;
var wwl_BETTER=2192;
var LW55=2193;
var YM106=2194;
var _aa_bsecure_block_unrated=2195;
var GW_WAN_BIGPOND_USERNAME_INVALID=2196;
var KR76=2197;
var GW_DHCPSERVER_EXHAUSTED=2198;
var GW_WAN_L2TP_SERVER_IP_ADDRESS_INVALID=2199;
var wwl_alert_pv5_2=2200;
var GW_ROUTES_SUBNET_INVALID=2201;
var _aa_bsecure_drugs=2202;
var LW1=2203;
var GW_DHCPSERVER_EXPIRED=2204;
var GW_INET_ACL_IP_ADDRESS_IN_LAN_SUBNET_INVALID=2205;
var bd_NETBIOS_REG_TYPE_B=2206;
var _aa_bsecure_financial=2207;
var YM135=2208;
var LT119=2209;
var _vs_public=2210;
var KR93=2211;
var GW_SECURE_REMOTE_ADMINSTRATION=2212;
var _aa_bsecure_employment=2213;
var YM160=2214;
var LS423=2215;
var GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID=2216;
var GW_WISH_RULES_HOST1_IP=2217;
var _vs_private=2218;
var KR86=2219;
var bd_NETBIOS_SEC_WINS=2220;
var GW_INET_ACL_START_IP_ADDRESS_INVALID=2221;
var auth=2222;
var KR24=2223;
var KR17=2224;
var YM84=2225;
var help88=2226;
var LW50=2227;
var YM103=2228;
var KR64=2229;
var help361=2230;
var LW4=2231;
var KR38=2232;
var GW_WLAN_11A_STATIC_TURBO_INVALID=2233;
var help358=2234;
var YM6=2235;
var _aa_bsecure_categ_select=2236;
var YM58=2237;
var _aa_bsecure_age_youth=2238;
var LW17=2239;
var YM18=2240;
var LT210=2241;
var GW_WAN_IDLE_TIME_INVALID=2242;
var YM186=2243;
var _aa_bsecure_sports=2244;
var GW_QOS_RULES_NAME_ALREADY_USED=2245;
var bwz_intro_WCNWz=2246;
var GW_DHCP_SERVER_POOL_TO_IN_SUBNET_INVALID=2247;
var GW_NAT_H323_ALG_ACTIVATED_WARNING=2248;
var KR4=2249;
var LT120y=2250;
var KR103=2251;
var YM44=2252;
var LW47=2253;
var GW_XML_CONFIG_GET_FAILED=2254;
var WIFISC_AP_SET_APSETTINGS_COMPLETE=2255;
var wwl_WKL=2256;
var YM168=2257;
var GW_NAT_NAME_USED_INVALID=2258;
var GW_DYNDNS_SERVER_INDEX_VALUE_INVALID=2259;
var WARN=2260;
var LW23=2261;
var ADVANCED_NETWORK=2262;
var GW_WAN_PPTP_PASSWORD_INVALID=2263;
var LW59=2264;
var YM126=2265;
var LW66=2266;
var _r_alert4=2267;
var LY10=2268;
var GW_DHCP_SERVER_POOL_FROM_INVALID=2269;
var WIFISC_AP_SETUP_LOCKED=2270;
var YM91=2271;
var WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL=2272;
var LS3=2273;
var GW_NAT_UNKNOWN=2274;
var GW_WLAN_11A_DYNAMIC_TURBO_INVALID=2275;
var YM163=2276;
var YM181=2277;
var _cantapplysettings_1=2278;
var YM11=2279;
var wwl_wsp_chars_2=2280;
var bd_NETBIOS_PRI_WINS=2281;
var wwl_DWKL=2282;
var KR44=2283;
var _aa_bsecure_obscene=2284;
var YM130=2285;
var KR99=2286;
var GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID=2287;
var GW_FIREWALL_NO_IP_RANGE_INVALID=2288;
var GW_NAT_VS_PROTOCOL_INVALID=2289;
var KR52=2290;
var KR33=2291;
var ZM23=2292;
var LW40=2293;
var LY4=2294;
var LW34=2295;
var YM25=2296;
var YM15=2297;
var bwl_SGM=2298;
var GW_WLAN_80211X_RADIUS_INVALID=2299;
var GW_WISH_RULES_PROTOCOL=2300;
var LS316=2301;
var ZM15=2302;
var GW_DHCP_SERVER_RESERVATION_DISABLED_IN_CONFLICT_WARNING=2303;
var GW_DYNDNS_HOST_NAME_INVALID=2304;
var LW42=2305;
var GW_WAN_PPTP_GATEWAY_IP_ADDRESS_INVALID=2306;
var rs_intro_4=2307;
var GW_QOS_RULES_REMOTE_IP_END_SUBNET=2308;
var _NA=2309;
var hhav_r_gateway=2310;
var INFO=2311;
var help112=2312;
var tf_msg_FWUgReset=2313;
var bd_NETBIOS_WAN=2314;
var aw_igslot=2315;
var ZM2=2316;
var LT7=2317;
var WIFISC_AP_SET_SELECTED_REGISTRAR=2318;
var help214=2319;
var at_Both=2320;
var ZM22=2321;
var help_ts_rfd=2322;
var LW44=2323;
var help209=2324;
var YM70=2325;
var GW_UPNP_IGD_PORTMAP_VS_CHANGE=2326;
var help143s=2327;
var help363=2328;
var _aa_bsecure_web_newsgroup=2329;
var YM128=2330;
var GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID=2331;
var KR72=2332;
var YM177=2333;
var YM82=2334;
var YM119=2335;
var KR70=2336;
var YM161=2337;
var GW_DHCP_SERVER_POOL_SIZE_INVALID=2338;
var _sdi_s4b=2339;
var ZM8=2340;
var YM129=2341;
var help370=2342;
var LY29=2343;
var GW_XML_CONFIG_WRITE_WARN=2344;
var GW_FIREWALL_NAME_INVALID=2345;
var GW_WISH_RULES_HOST2_IP=2346;
var TA2=2347;
var LS314=2348;
var _vs_traffictype=2349;
var GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID=2350;
var KR43=2351;
var KR51=2352;
var GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID=2353;
var help837=2354;
var KR49=2355;
var _open=2356;
var _aa_bsecure_news=2357;
var YM34=2358;
var _advwls=2359;
var GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING=2360;
var GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID=2361;
var _wepkey4=2362;
var YM98=2363;
var _aa_bsecure_search_engine=2364;
var KR47=2365;
var bws_msg_WEP_3=2366;
var GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING=2367;
var GW_LAN_IP_MODE_INVALID=2368;
var GW_WAN_BIGPOND_SERVER_NOTSTD15=2369;
var ZM18=2370;
var GW_WLAN_FRAGMENT_THRESHOLD_INVALID=2371;
var GW_LAN_DOMAIN_NAME_INVALID=2372;
var GW_LAN_DEVICE_NAME_INVALID=2373;
var _wifisc_overlap=2374;
var LW62=2375;
var KR23=2376;
var _aa_bsecure_pornography=2377;
var GW_NAT_NAME_INVALID=2378;
var bwl_NSS=2379;
var YM108=2380;
var YM19=2381;
var WIFISC_AP_PROXY_PROCESS_COMPLETE=2382;
var GW_NAT_ENTRY_DUPLICATED_INVALID=2383;
var GW_NAT_PORT_FORWARD_CONFLICT_INVALID=2384;
var LW27=2385;
var YM38=2386;
var YM185=2387;
var LY2=2388;
var KR30=2389;
var KR31=2390;
var _init_fail=2391;
var YM68=2392;
var sd_macaddr=2393;
var KR12=2394;
var help366=2395;
var WIFISC_AP_REGISTRATION_COMPLETE=2396;
var aw_TPC=2397;
var aw_WDSMAC=2398;
var YM62=2399;
var aw_erpe_h=2400;
var GW_WAN_RECONNECT_MODE_INVALID=2401;
var WIFISC_AP_DEL_APSETTINGS_COMPLETE=2402;
var ss_intro_user=2403;
var LW33=2404;
var KR27=2405;
var YM138=2406;
var GW_NAT_VS_PORT_CONFLICT_INVALID=2407;
var bd_NETBIOS_WINS_1=2408;
var _aa_wiz_s6_title=2409;
var YM77=2410;
var YM48=2411;
var YM89=2412;
var GW_WLAN_WPA_PSK_HEX_STRING_INVALID=2413;
var GW_WAN_WAN_IP_ADDRESS_INVALID=2414;
var LS4=2415;
var KR98=2416;
var YM148=2417;
var bws_WPAM_2=2418;
var help877a=2419;
var KR56=2420;
var LS424=2421;
var GW_DHCPSERVER_DECLINED=2422;
var GW_SCHEDULES_DAY_INVALID=2423;
var GW_NAT_UDP=2424;
var IPSMTPCLIENT_CANNOT_CREATE_CONNECTION=2425;
var _aa_check_all=2426;
var YM94=2427;
var LS312=2428;
var KR2=2429;
var _vs_proto=2430;
var GW_SMTP_TO_ADDRESS_INVALID=2431;
var WIFISC_AP_REGISTRATION_FAIL=2432;
var GW_WISH_RULES_NAME_ALREADY_USED=2433;
var LW48=2434;
var YM54=2435;
var LW9=2436;
var LW41=2437;
var YM124=2438;
var GW_WLAN_RTS_THRESHOLD_INVALID=2439;
var GW_WAN_L2TP_PASSWORD_INVALID=2440;
var YM12=2441;
var ZM14=2442;
var KR60=2443;
var YM28=2444;
var YM184=2445;
var int_intro_WCNWz7=2446;
var bws_Auth_2=2447;
var rs_intro_1=2448;
var help92=2449;
var GW_NAT_BOTH=2450;
var rs_success=2451;
var up_tz_29b=2452;
var day=2453;
var GW_DHCP_SERVER_DISABLED_WARNING=2454;
var YM173=2455;
var GW_INET_ACCESS_POLICY_MAC_INVALID=2456;
var LW2=2457;
var KR75=2458;
var GW_XML_CONFIG_WRITE_FAILED=2459;
var help102=2460;
var GW_WISH_RULES_NAME_USED_INVALID=2461;
var GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID=2462;
var aw_AS=2463;
var YM171=2464;
var GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID=2465;
var GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT=2466;
var hhav_r_netmask=2467;
var vs_vslist=2468;
var if_iflist=2469;
var YM137=2470;
var YM74=2471;
var GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID=2472;
var YM86=2473;
var GW_MAC_FILTER_MAC_UNIQUENESS_INVALID=2474;
var KR40=2475;
var GW_MAC_FILTER_NULL_MAC_INVALID=2476;
var aw_32=2477;
var GW_WAN_LAN_SUBNET_CONFLICT_INVALID=2478;
var LW67=2479;
var WIFISC_AP_DEL_APSETTINGS_FAIL=2480;
var wwl_wsp_chars_1=2481;
var KR85=2482;
var YM115=2483;
var YM83=2484;
var wwl_128bits=2485;
var LW51=2486;
var YM178=2487;
var _aa_bsecure_cults=2488;
var YM5=2489;
var KR65=2490;
var ZM17=2491;
var LW14=2492;
var ta_wcn_bv=2493;
var GW_NAT_VS_IP_ADDRESS_CAN_NOT_MATCH_ROUTER=2494;
var GW_SCHEDULES_IN_USE_INVALID=2495;
var wepkey3=2496;
var KR69=2497;
var YM43=2498;
var YM45=2499;
var GW_SMTP_USERNAME_INVALID=2500;
var help362=2501;
var tf_intro_FWChA=2502;
var _remotedesktop=2503;
var KR29=2504;
var help359=2505;
var KR84=2506;
var YM30=2507;
var at_LoPortR=2508;
var GW_DHCP_SERVER_POOL_FROM_IN_SUBNET_INVALID=2509;
var GW_MAC_FILTER_MULTICAST_MAC_INVALID=2510;
var GW_SMTP_INIT_FAILED_WARNING=2511;
var GW_DHCPSERVER_STOP=2512;
var help350=2513;
var GW_NAT_DMZ_NOT_ALLOWED_INVALID=2514;
var YM143=2515;
var GW_XML_CONFIG_SET_FAILED=2516;
var GW_NAT_PORT_DUP_INVALID=2517;
var KR46=2518;
var KR35=2519;
var GW_WAN_BIGPOND_PASSWORD_INVALID=2520;
var YM57=2521;
var KR104=2522;
var IPSMTPCLIENT_MSG_WRONG_SENDER_ADDR_FORMAT=2523;
var LS317=2524;
var YM102=2525;
var help188=2526;
var _logsyslog_alert1=2527;
var KR3=2528;
var _aa_bsecure_hate=2529;
var GW_WLAN_11BG_CHANNEL_INVALID=2530;
var RATE_ESTIMATOR_RATE_COMPLETED=2531;
var wwl_alert_pv5_3=2532;
var aw_aggr=2533;
var _wifisc_addstart=2534;
var help111=2535;
var GW_QOS_RULES_REMOTE_IP_START_SUBNET=2536;
var YM22=2537;
var GW_WLAN_WDS_MAC_ADDR_INVALID=2538;
var LW10=2539;
var LT291=2540;
var YM156=2541;
var _aa_bsecure_age_ado=2542;
var wwl_text_good=2543;
var GW_QOS_RULES_PRIORITY_RANGE=2544;
var YM134=2545;
var _aa_bsecure_web_mail=2546;
var help188b=2547;
var GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID=2548;
var at_title_Traff=2549;
var help189=2550;
var GW_WIRELESS_SWITCH_CHANNEL=2551;
var GW_WAN_BIGPOND_SERVER_INVALID=2552;
var GW_XML_CONFIG_SET_PARSE=2553;
var YM125=2554;
var LT290wifisc=2555;
var GW_FIREWALL_RULE_NAME_INVALID=2556;
var GW_NAT_SCHEDULE=2557;
var help109=2558;
var GW_LAN_RIP_MODE_INVALID=2559;
var LW52=2560;
var _aa_bsecure_popups=2561;
var GW_WLAN_WPA_WPA2_TKIP_INVALID=2562;
var KR16=2563;
var _vs_title=2564;
var _if_title=2565;
var GW_WAN_PPPOE_USERNAME_INVALID=2566;
var GW_WAN_PPTP_SUBNET_INVALID=2567;
var GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID=2568;
var KR94=2569;
var YM63=2570;
var help108=2571;
var GW_SCHEDULES_DUPLICATED_INVALID=2572;
var bws_WPAM_1=2573;
var KR11=2574;
var LW45=2575;
var KR6=2576;
var GW_DHCP_SERVER_NETBIOS_TYPE_INVALID=2577;
var _aa_bsecure_games=2578;
var KR42=2579;
var YM104=2580;
var _aa_bsecure_tickets=2581;
var KR39=2582;
var bd_NETBIOS_REG_TYPE_M=2583;
var help189a=2584;
var GW_UPNP_IGD_PORTMAP_DEL=2585;
var YM111=2586;
var LS315=2587;
var GW_WLAN_WPA_PSK_LEN_INVALID=2588;
var LW24=2589;
var YM167=2590;
var help371=2591;
var _aa_bsecure_anarchy=2592;
var YM4=2593;
var _aa_bsecure_criminal_skills=2594;
var YM188=2595;
var YM133=2596;
var YM59=2597;
var _aa_bsecure_manually=2598;
var YM169=2599;
var YM97=2600;
var at_ESE=2601;
var _aa_bsecure_age_child=2602;
var help375=2603;
var GW_WEB_FILTER_WEBSITE_INVALID_INVALID=2604;
var ZM21=2605;
var YM157=2606;
var help213=2607;
var YM24=2608;
var WIFISC_AP_PEER_CFG_ERR=2609;
var LW43=2610;
var help99_s=2611;
var YM90=2612;
var bws_CT_3=2613;
var help371_n=2614;
var GW_DHCP_SERVER_RESERVATION_RECONFIG_WARNING=2615;
var _r_alert3=2616;
var GW_LAN_RIP_METRIC_INVALID=2617;
var YM118=2618;
var YM127=2619;
var KR71=2620;
var aw_WDSEn=2621;
var KR32=2622;
var sa_Local=2623;
var GW_WEB_SERVER_IDLE_TIME=2624;
var KR59=2625;
var GW_WAN_WAN_GATEWAY_IN_SUBNET_INVALID=2626;
var at_LoIPR=2627;
var YM81=2628;
var aw_AP=2629;
var LT290=2630;
var YM162=2631;
var GW_XML_CONFIG_SET_PARSE_MIME=2632;
var GW_NAT_UDP_PORT=2633;
var YM9=2634;
var GW_WAN_MTU_INVALID=2635;
var LW63=2636;
var WIFISC_IR_REGISTRATION_SUCCESS=2637;
var help105=2638;
var GW_DHCPSERVER_RELEASED=2639;
var LW32=2640;
var WIFISC_AP_SET_APSETTINGS_FAIL=2641;
var KR8=2642;
var hhav_r_name=2643;
var bd_NETBIOS_REG_TYPE_H=2644;
var KR55=2645;
var GW_WAN_PPPOE_LAN_SUBNET_CONFLICT_INVALID=2646;
var GW_XML_CONFIG_SET_SUCCESS=2647;
var YM60=2648;
var KR100=2649;
var KR61=2650;
var bws_WKL_0=2651;
var bws_msg_WPA=2652;
var YM109=2653;
var WIFISC_AP_RESET_FAIL=2654;
var GW_WISH_RULES_HOST2_PORT=2655;
var help_ts_ls=2656;
var YM101=2657;
var KR50=2658;
var YM56=2659;
var aa_WebSite_Domain=2660;
var GW_QOS_RULES_MAX_TRANS=2661;
var GW_QOS_RULES_PROTOCOL=2662;
var GW_WEB_SERVER_NO_ACCESS=2663;
var KR87=2664;
var GW_WISH_RULES_DUPLICATED=2665;
var YM16=2666;
var GW_SCHEDULES_NAME_CONFLICT_INVALID=2667;
var wepkey4=2668;
var GW_WEB_SERVER_SAME_PORT_WAN=2669;
var YM65=2670;
var bln_title=2671;
var WIFISC_AP_PROXY_PROCESS_FAIL=2672;
var _more=2673;
var ZM12=2674;
var _aa_bsecure_banner_ad=2675;
var LY23=2676;
var help88b=2677;
var bwl_NSS_h1=2678;
var help203=2679;
var GW_INET_ACL_NO_MACHINE_IN_LAN_SUBNET_INVALID=2680;
var LW39c=2681;
var WIFISC_AP_SET_SELECTED_REGISTRAR_COMPLETE=2682;
var GW_DHCP_CLIENT_CLIENT_NAME_INVALID=2683;
var YM166=2684;
var WIFISC_AP_REBOOT_FAIL=2685;
var help91=2686;
var LW39=2687;
var YM174=2688;
var YM13=2689;
var YM172=2690;
var YM31=2691;
var _aa_wiz_s6_msg=2692;
var GW_SMTP_PASSWORD_INVALID=2693;
var YM85=2694;
var GW_SCHEDULES_NAME_INVALID=2695;
var LS204=2696;
var aw_16=2697;
var aw_erpe_h3=2698;
var LW64=2699;
var _days=2700;
var at_intro=2701;
var help103=2702;
var YM183=2703;
var YM117=2704;
var KR54=2705;
var av_intro_r=2706;
var help368=2707;
var hhav_enable=2708;
var GW_WAN_DNS_SERVERS_INVALID=2709;
var _rs_succeeded=2710;
var GW_WAN_PPTP_USERNAME_INVALID=2711;
var GW_WAN_L2TP_IP_ADDRESS_INVALID=2712;
var GW_INET_ACL_NAME_INVALID=2713;
var days=2714;
var KR88=2715;
var GW_WAN_PPPOE_IP_ADDRESS_INVALID=2716;
var KR19=2717;
var RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED=2718;
var YM27=2719;
var LT291wifisc=2720;
var KR1=2721;
var YM51=2722;
var ZM13=2723;
var GW_LAN_PRIMARY_DNS_INVALID=2724;
var GW_WLAN_11A_DFS_TURBO_INVALID=2725;
var YM123=2726;
var TA8=2727;
var KR9=2728;
var KR79=2729;
var GW_QOS_RULES_REMOTE_IP=2730;
var _aa_bsecure_age_adult=2731;
var ZM7=2732;
var YM23=2733;
var tf_USSW=2734;
var help78=2735;
var YM73=2736;
var LS425=2737;
var wwl_WK=2738;
var LW11=2739;
var GW_NAT_PPTP_ALG_ACTIVATED_WARNING=2740;
var YM35=2741;
var tsc_sel_days=2742;
var sc_intro_rb4=2743;
var GW_SCHEDULES_TIME_INVALID=2744;
var GW_DHCP_SERVER_LEASE_TIME_INVALID=2745;
var IPSMTPCLIENT_NO_SERVER_IP_ADDRESS=2746;
var KR10=2747;
var GW_WEB_FILTER_HTTPS_NOT_SUPPORTED_INVALID=2748;
var KR22=2749;
var _vs_both=2750;
var wwl_alert_pv5_4=2751;
var GW_WIFISC_LOCK_VERIFY_ERR=2752;
var LW53=2753;
var GW_WEB_FILTER_WEB_SITE_IS_USED_INVALID=2754;
var YM64=2755;
var GW_ROUTES_INTERFACE_INVALID=2756;
var GW_LAN_SECONDARY_DNS_INVALID=2757;
var bd_NETBIOS_LEARN_FROM_WAN_ENABLE=2758;
var GW_NAT_PORT_FORWARDING_TABLE_RECONFIGURED_WARNING=2759;
var KR15=2760;
var WIFISC_AP_REGISTRATION_UNEXPECTED_EVENT=2761;
var GW_SYSLOG_ADDRESS_NOT_IN_SUBNET_WARNING=2762;
var GW_DHCP_SERVER_NETBIOS_SECONDARY_WINS_INVALID=2763;
var LW49=2764;
var KR95=2765;
var aw_8=2766;
var YM114=2767;
var bws_CT=2768;
var _aa_bsecure_rrated=2769;
var LW6=2770;
var bws_msg_WEP_2=2771;
var GW_QOS_RULES_LOCAL_IP=2772;
var GW_DHCP_SERVER_POOL_FROM_TO_ORIENTATION_INVALID=2773;
var bws_CT_1=2774;
var GW_XML_CONFIG_SET_LOCK=2775;
var GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID=2776;
var wepkey2=2777;
var LW28=2778;
var _wepkey1=2779;
var KR83=2780;
var GW_SYSLOG_ADDRESS_INVALID=2781;
var YM105=2782;
var ZM5=2783;
var help212=2784;
var KR45=2785;
var help19x2=2786;
var KR36=2787;
var GW_ROUTES_METRIC_INVALID=2788;
var GW_WLAN_SSID_INVALID=2789;
var LS46=2790;
var YM179=2791;
var KR78=2792;
var KR66=2793;
var _aa_bsecure_magazine=2794;
var KR101=2795;
var GW_WLAN_WPA_WPA_AES_INVALID=2796;
var GW_NAT_INBOUND_FILTER=2797;
var GW_INET_ACL_POLICY_NAME_INVALID=2798;
var sa_Internet=2799;
var GW_WLAN_11A_DFS_CHANNEL_INVALID=2800;
var YM153=2801;
var at_ReIPR=2802;
var LW15=2803;
var GW_WLAN_DTIM_INVALID=2804;
var YM144=2805;
var up_tz_26=2806;
var help71=2807;
var GW_PURE_ADDPORTMAPPING_MODIFY=2808;
var tsc_pingt_msg10=2809;
var tps_foo=2810;
var GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL=2811;
var LOG_PREV_MSG_REPEATED_N_TIMES=2812;
var ca_intro=2813;
var GW_WAN_LAN_ADDRESS_CONFLICT_DHCP=2814;
var help176=2815;
var GW_PURE_ADDPORTMAPPING_CREATE=2816;
var hhag_30=2817;
var hhai_save=2818;
var ADMIN=2819;
var wprn_s1a=2820;
var sl_alert_3=2821;
var help900=2822;
var tps_foo2=2823;
var help182=2824;
var aa_alert_12=2825;
var tf_intro_FWCh=2826;
var ts_ss=2827;
var wwa_title_set_pptp=2828;
var _hostname_eg=2829;
var wwl_s4_note=2830;
var help22=2831;
var wwl_alert_pv5_1=2832;
var GW_PURE_SETWLANSETTINGS24=2833;
var help167=2834;
var at_DxDSL=2835;
var wprn_bados2=2836;
var wprn_s3a=2837;
var wprn_tt10=2838;
var bwn_IF=2839;
var _1044a=2840;
var wprn_tt6=2841;
var help72=2842;
var _sdi_s6=2843;
var hhpt_sch=2844;
var wprn_tt2=2845;
var sl_alert_2=2846;
var anet_wp_2=2847;
var tss_RestAll=2848;
var GW_PURE_SETWANSETTINGS=2849;
var help53=2850;
var help175=2851;
var help872=2852;
var help785=2853;
var wprn_s2b=2854;
var wprn_intro2=2855;
var aa_alert_13=2856;
var help890=2857;
var help814=2858;
var help283=2859;
var sps_protdis=2860;
var help831=2861;
var _cantapplysettings=2862;
var help39=2863;
var WCN_LOG_ABORT=2864;
var up_tz_73=2865;
var help141_a=2866;
var af_intro_x=2867;
var help170=2868;
var tps_intro4=2869;
var wprn_tt7=2870;
var GW_DHCPSERVER_START=2871;
var help887=2872;
var help38=2873;
var wwl_title_wel=2874;
var help164=2875;
var hhav_filt=2876;
var GW_PURE_ADDPORTMAPPING_CONFLICT=2877;
var GW_PURE_SETROUTERLANSETTINGS=2878;
var GW_PURE_SETWLANSECURITY=2879;
var aa_alert_9=2880;
var help287=2881;
var ta_RAIF=2882;
var help180=2883;
var GW_PURE_SETDEVICESETTINGS=2884;
var _rssi=2885;
var wwl_intro_wel=2886;
var tf_ClickDL=2887;
var help165=2888;
var at_Prot__1=2889;
var tps_intro5=2890;
var ub_intro_1=2891;
var help277=2892;
var help41=2893;
var VIRTUAL_SERVERS=2894;
var hhav_sch=2895;
var ts_rfd=2896;
var help33b=2897;
var ts_ls=2898;
var wwl_intro_s1=2899;
var GW_PURE_DELETEPORTMAPPING_MODIFY=2900;
var wprn_s2c=2901;
var help320=2902;
var help813=2903;
var help893=2904;
var help803=2905;
var help877=2906;
var up_tz_27=2907;
var help74=2908;
var help155_2=2909;
var _sdi_s4=2910;
var MISC=2911;
var aa_alert_10=2912;
var tf_msg_Upping=2913;
var GW_LOG_EMAIL_FAILED=2914;
var help823_17=2915;
var hhaf_dmz=2916;
var sa_intro=2917;
var up_rb_2=2918;
var help23=2919;
var _bln_title_IGMPMemberships_h=2920;
var haf_intro_2=2921;
var help802=2922;
var wprn_tt5=2923;
var hhsl_lmail=2924;
var ap_intro_noreboot=2925;
var up_tz_29=2926;
var GW_PURE_SETMACFILTERS2=2927;
var GW_PURE_REBOOT=2928;
var rb_change=2929;
var help816=2930;
var GW_PURE_DELETEPORTMAPPING_DELETE=2931;
var ub_intro_3=2932;
var help30=2933;
var bln_alert_2=2934;
var hhwf_xref=2935;
var GW_REMOTE_ADMINSTRATION=2936;
var wwl_s4_intro=2937;
var sd_SecTyp=2938;
var IPV6_WAN_IP=2939;
var IPV6_TEXT0=2940;
var IPV6_TEXT1=2941;
var IPV6_TEXT2=2942;
var IPV6_TEXT3=2943;
var IPV6_TEXT4=2944;
var IPV6_TEXT5=2945;
var IPV6_TEXT6=2946;
var IPV6_TEXT7=2947;
var IPV6_TEXT8=2948;
var IPV6_TEXT9=2949;
var IPV6_TEXT10=2950;
var IPV6_TEXT11=2951;
var IPV6_TEXT12=2952;
var IPV6_TEXT13=2953;
var IPV6_TEXT14=2954;
var IPV6_TEXT15=2955;
var IPV6_TEXT16=2956;
var IPV6_TEXT17=2957;
var IPV6_TEXT18=2958;
var IPV6_TEXT19=2959;
var IPV6_TEXT20=2960;
var IPV6_TEXT21=2961;
var IPV6_TEXT22=2962;
var IPV6_TEXT23=2963;
var IPV6_TEXT24=2964;
var IPV6_TEXT25=2965;
var IPV6_TEXT26=2966;
var IPV6_TEXT27=2967;
var IPV6_TEXT28=2968;
var IPV6_TEXT29=2969;
var IPV6_TEXT29a=2970;
var IPV6_TEXT30=2971;
var IPV6_TEXT31=2972;
var IPV6_TEXT32=2973;
var IPV6_TEXT33=2974;
var IPV6_TEXT34=2975;
var IPV6_TEXT35=2976;
var IPV6_TEXT36=2977;
var IPV6_TEXT37=2978;
var IPV6_TEXT38=2979;
var IPV6_TEXT39=2980;
var IPV6_TEXT40=2981;
var IPV6_TEXT41=2982;
var IPV6_TEXT42=2983;
var IPV6_TEXT43=2984;
var IPV6_TEXT44=2985;
var IPV6_TEXT45=2986;
var IPV6_TEXT46=2987;
var IPV6_TEXT47=2988;
var IPV6_TEXT48=2989;
var IPV6_TEXT49=2990;
var IPV6_TEXT50=2991;
var IPV6_TEXT51=2992;
var IPV6_TEXT52=2993;
var IPV6_TEXT53=2994;
var IPV6_TEXT54=2995;
var IPV6_TEXT55=2996;
var IPV6_TEXT56=2997;
var IPV6_TEXT57=2998;
var IPV6_TEXT58=2999;
var IPV6_TEXT59=3000;
var IPV6_TEXT60=3001;
var IPV6_TEXT61=3002;
var IPV6_TEXT62=3003;
var IPV6_TEXT63=3004;
var IPV6_TEXT64=3005;
var IPV6_TEXT65=3006;
var IPV6_TEXT66=3007;
var IPV6_TEXT67=3008;
var IPV6_TEXT68=3009;
var IPV6_TEXT69=3010;
var IPV6_TEXT70=3011;
var IPV6_TEXT71=3012;
var IPV6_TEXT72=3013;
var IPV6_TEXT73=3014;
var IPV6_TEXT74=3015;
var IPV6_TEXT75=3016;
var IPV6_TEXT76=3017;
var IPV6_TEXT77=3018;
var IPV6_TEXT78=3019;
var IPV6_TEXT79=3020;
var IPV6_TEXT80=3021;
var IPV6_TEXT81=3022;
var IPV6_TEXT82=3023;
var IPV6_TEXT83=3024;
var IPV6_TEXT84=3025;
var IPV6_TEXT85=3026;
var IPV6_TEXT86=3027;
var IPV6_TEXT87=3028;
var IPV6_TEXT88=3029;
var IPV6_TEXT89=3030;
var IPV6_TEXT90=3031;
var IPV6_TEXT91=3032;
var IPV6_TEXT92=3033;
var IPV6_TEXT93=3034;
var IPV6_TEXT94=3035;
var IPV6_TEXT95=3036;
var IPV6_TEXT96=3037;
var IPV6_TEXT97=3038;
var IPV6_TEXT98=3039;
var IPV6_TEXT99=3040;
var IPV6_TEXT100=3041;
var IPV6_TEXT101=3042;
var IPV6_TEXT102=3043;
var IPV6_TEXT103=3044;
var IPV6_TEXT104=3045;
var IPV6_TEXT105=3046;
var IPV6_TEXT106=3047;
var IPV6_TEXT107=3048;
var IPV6_TEXT108=3049;
var IPV6_TEXT109=3050;
var IPV6_TEXT110=3051;
var IPV6_TEXT111=3052;
var IPV6_TEXT112=3053;
var IPV6_TEXT113=3054;
var IPV6_TEXT114=3055;
var IPV6_TEXT115=3056;
var IPV6_TEXT116=3057;
var IPV6_TEXT117=3058;
var IPV6_TEXT118=3059;
var IPV6_TEXT119=3060;
var IPV6_TEXT120=3061;
var IPV6_TEXT121=3062;
var IPV6_TEXT122=3063;
var IPV6_TEXT123=3064;
var IPV6_TEXT124=3065;
var IPV6_TEXT125=3066;
var IPV6_TEXT126=3067;
var IPV6_TEXT127=3068;
var IPV6_TEXT128=3069;
var IPV6_TEXT129=3070;
var IPV6_TEXT130=3071;
var IPV6_TEXT131=3072;
var IPV6_TEXT132=3073;
var IPV6_TEXT133=3074;
var IPV6_TEXT134=3075;
var IPV6_TEXT135=3076;
var IPV6_TEXT136=3077;
var IPV6_TEXT137=3078;
var IPV6_TEXT138=3079;
var IPV6_TEXT139=3080;
var IPV6_TEXT140=3081;
var IPV6_TEXT141=3082;
var IPV6_TEXT142=3083;
var IPV6_TEXT143=3084;
var IPV6_TEXT144=3085;
var IPV6_TEXT145=3086;
var IPV6_TEXT146=3087;
var IPV6_TEXT147=3088;
var IPV6_TEXT148=3089;
var IPV6_TEXT149=3090;
var IPV6_TEXT150=3091;
var IPV6_TEXT151=3092;
var IPV6_TEXT152=3093;
var IPV6_TEXT153=3094;
var IPV6_TEXT154=3095;
var IPV6_TEXT155=3096;
var IPV6_TEXT156=3097;
var IPV6_TEXT157=3098;
var IPV6_TEXT158=3099;
var IPV6_TEXT159=3100;
var IPV6_TEXT160=3101;
var IPV6_TEXT161=3102;
var IPV6_TEXT162=3103;
var IPV6_TEXT163=3104;
var IPV6_TEXT164=3105;
var IPV6_TEXT165=3106;
var IPV6_TEXT166=3107;
var DNS_TEXT0=3108;
var DNS_TEXT1=3109;
var DNS_TEXT2=3110;
var DNS_TEXT3=3111;
var DNS_TEXT4=3112;
var DNS_TEXT5=3113;
var DNS_TEXT6=3114;
var DNS_TEXT7=3115;
var DNS_TEXT8=3116;
var DNS_TEXT9=3117;
var DNS_TEXT10=3118;
var DNS_TEXT11=3119;
var DNS_TEXT12=3120;
var TEXT000=3121;
var TEXT001=3122;
var TEXT002=3123;
var TEXT003=3124;
var TEXT004=3125;
var TEXT005=3126;
var TEXT006=3127;
var TEXT007=3128;
var TEXT008=3129;
var TEXT009=3130;
var TEXT010=3131;
var TEXT011=3132;
var TEXT012=3133;
var TEXT013=3134;
var TEXT014=3135;
var TEXT015=3136;
var TEXT016=3137;
var TEXT017=3138;
var TEXT018=3139;
var TEXT019=3140;
var TEXT020=3141;
var TEXT021=3142;
var TEXT022=3143;
var TEXT023=3144;
var TEXT024=3145;
var TEXT025=3146;
var TEXT026=3147;
var TEXT027=3148;
var TEXT028=3149;
var TEXT029=3150;
var TEXT030=3151;
var TEXT031=3152;
var TEXT032=3153;
var TEXT033=3154;
var TEXT034=3155;
var TEXT035=3156;
var TEXT036=3157;
var TEXT037=3158;
var TEXT038=3159;
var TEXT039=3160;
var TEXT040=3161;
var TEXT041=3162;
var TEXT042=3163;
var TEXT043=3164;
var TEXT044=3165;
var TEXT045=3166;
var TEXT046=3167;
var TEXT047=3168;
var TEXT048=3169;
var TEXT049=3170;
var TEXT050=3171;
var TEXT051=3172;
var TEXT052=3173;
var TEXT053=3174;
var TEXT054=3175;
var TEXT055=3176;
var TEXT056=3177;
var TEXT057=3178;
var TEXT058=3179;
var TEXT059=3180;
var TEXT060=3181;
var TEXT061=3182;
var TEXT062=3183;
var TEXT063=3184;
var TEXT064=3185;
var TEXT065=3186;
var TEXT066=3187;
var TEXT067=3188;
var TEXT068=3189;
var TEXT069=3190;
var TEXT070=3191;
var TEXT071=3192;
var TEXT072=3193;
var TEXT073=3194;
var TEXT074=3195;
var TEXT075=3196;
var TEXT076=3197;
var TEXT077=3198;
var TEXT078=3199;
var MSG000=3200;
var MSG001=3201;
var MSG002=3202;
var MSG003=3203;
var MSG004=3204;
var MSG005=3205;
var MSG006=3206;
var MSG007=3207;
var MSG008=3208;
var MSG009=3209;
var MSG010=3210;
var MSG011=3211;
var MSG012=3212;
var MSG013=3213;
var MSG014=3214;
var MSG015=3215;
var MSG016=3216;
var MSG017=3217;
var MSG018=3218;
var MSG019=3219;
var MSG020=3220;
var MSG021=3221;
var MSG022=3222;
var MSG023=3223;
var MSG024=3224;
var MSG025=3225;
var MSG026=3226;
var MSG027=3227;
var MSG028=3228;
var MSG029=3229;
var MSG030=3230;
var MSG031=3231;
var MSG032=3232;
var MSG033=3233;
var MSG034=3234;
var MSG035=3235;
var MSG036_1=3236;
var MSG037_1=3237;
var MSG038_1=3238;
var MSG039_1=3239;
var MSG036=3240;
var MSG037=3241;
var MSG038=3242;
var MSG039=3243;
var MSG040=3244;
var MSG041=3245;
var MSG042=3246;
var MSG043=3247;
var MSG044=3248;
var MSG045=3249;
var MSG046=3250;
var MSG047=3251;
var MSG048=3252;
var ADV_DNS_DESC1=3253;
var ADV_DNS_DESC2=3254;
var ADV_DNS_DESC3=3255;
var OOPS=3256;
var ERROR404=3257;
var SUGGESTIONS=3258;
var SUGGESTIONS_1=3259;
var SUGGESTIONS_2=3260;
var tsc_hrmin_1=3261;
var DHCP_PD=3262;
var DHCP_PD_ENABLE=3263;
var DHCP_PD_ASSIGNED=3264;
var _6to4RELAY=3265;
var IPV6_TEXT65_v6=3266;
var IPV6_TEXT66_v6=3267;
var usb_reboot=3268;
var usb_reboot_chnip=3269;
var _phone=3270;
var _select_phone=3271;
var _phone_info=3272;
var usb_3g_phone=3273;
var usb_window_mobile_5=3274;
var usb_iphone=3275;
var android_phone=3276;
var help901=3277;
var DEVICE_NAME=3278;
var DEVICE_DESC=3279;
var IPDHCPSERVER_LEASE_REVOKED2=3280;
var IPDHCPSERVER_LEASE_RESERVATION_DELETED=3281;
var IPDHCPSERVER_LEASE_RENEW=3282;
var help738=3283;
var help759=3284;
var help517=3285;
var help443=3286;
var help414=3287;
var help600=3288;
var help486=3289;
var help503=3290;
var help426=3291;
var help432=3292;
var help527=3293;
var awf_intro_WF=3294;
var help652=3295;
var help456=3296;
var help539=3297;
var help472=3298;
var help520=3299;
var help737=3300;
var help646=3301;
var help745=3302;
var help659=3303;
var help727=3304;
var help753=3305;
var help574=3306;
var help663=3307;
var help748=3308;
var hhwf_intro=3309;
var help598=3310;
var help761=3311;
var help510=3312;
var help584=3313;
var help716=3314;
var help440=3315;
var help410=3316;
var help480=3317;
var help559=3318;
var help516=3319;
var help413=3320;
var help619=3321;
var help521=3322;
var help494=3323;
var help498=3324;
var help628=3325;
var help683=3326;
var help535=3327;
var help695=3328;
var help740=3329;
var help578=3330;
var help438=3331;
var help508=3332;
var help423=3333;
var help625=3334;
var help680=3335;
var help568=3336;
var help620=3337;
var help667=3338;
var help766=3339;
var help662=3340;
var help701=3341;
var help542=3342;
var help570=3343;
var help489=3344;
var help723=3345;
var help593=3346;
var help447=3347;
var help705=3348;
var help755=3349;
var _H323=3350;
var help427=3351;
var help485=3352;
var help490=3353;
var help555=3354;
var help462=3355;
var help732=3356;
var help592=3357;
var help455=3358;
var help685=3359;
var help146=3360;
var help655=3361;
var help439=3362;
var help416=3363;
var help726=3364;
var help692=3365;
var help550=3366;
var help714=3367;
var help504=3368;
var help469=3369;
var help629=3370;
var help597=3371;
var help746=3372;
var help749=3373;
var help471=3374;
var help736=3375;
var help596=3376;
var help706=3377;
var help664=3378;
var help702=3379;
var help756=3380;
var help573=3381;
var help601=3382;
var help684=3383;
var help678=3384;
var help760=3385;
var help536=3386;
var help499=3387;
var help562=3388;
var help741=3389;
var help541=3390;
var help717=3391;
var help604=3392;
var help718=3393;
var help551=3394;
var help577=3395;
var help515=3396;
var help621=3397;
var help412=3398;
var help713=3399;
var help687=3400;
var help567=3401;
var help618=3402;
var help441=3403;
var help466=3404;
var gw_vs_5=3405;
var help488=3406;
var help591=3407;
var help402=3408;
var help661=3409;
var help495=3410;
var help587=3411;
var help658=3412;
var help722=3413;
var help483=3414;
var help670=3415;
var help750=3416;
var help452=3417;
var help696=3418;
var help668=3419;
var help433=3420;
var help681=3421;
var help632=3422;
var help409=3423;
var help765=3424;
var help421=3425;
var help725=3426;
var help660=3427;
var help576=3428;
var help751=3429;
var help735=3430;
var help401=3431;
var gw_vs_6=3432;
var help491=3433;
var help448=3434;
var help566=3435;
var help398=3436;
var help586=3437;
var help710=3438;
var help686=3439;
var help537=3440;
var help654=3441;
var help708=3442;
var help424=3443;
var help505=3444;
var help583=3445;
var help430=3446;
var help484=3447;
var help454=3448;
var help556=3449;
var help470=3450;
var help689=3451;
var help464=3452;
var help461=3453;
var help635=3454;
var help715=3455;
var help622=3456;
var help731=3457;
var help408=3458;
var help688=3459;
var help465=3460;
var help703=3461;
var help697=3462;
var help605=3463;
var help549=3464;
var help506=3465;
var help642=3466;
var help428=3467;
var help682=3468;
var help492=3469;
var help526=3470;
var help631=3471;
var help606=3472;
var help665=3473;
var help148=3474;
var RATE_ESTIMATOR_RESOURCE_ERROR=3475;
var help721=3476;
var gw_vs_2=3477;
var help729=3478;
var help757=3479;
var help595=3480;
var help671=3481;
var help747=3482;
var help707=3483;
var help451=3484;
var help514=3485;
var help512=3486;
var help675=3487;
var help399=3488;
var help626=3489;
var help415=3490;
var help533=3491;
var help572=3492;
var help557=3493;
var help468=3494;
var help724=3495;
var help648=3496;
var wt_title=3497;
var help657=3498;
var help482=3499;
var help679=3500;
var help431=3501;
var help560=3502;
var help742=3503;
var help449=3504;
var help565=3505;
var help473=3506;
var help599=3507;
var help585=3508;
var help530=3509;
var help623=3510;
var help758=3511;
var help634=3512;
var help752=3513;
var help575=3514;
var help450=3515;
var help645=3516;
var help463=3517;
var help407=3518;
var help453=3519;
var help561=3520;
var help442=3521;
var help762=3522;
var help553=3523;
var help590=3524;
var help608=3525;
var help411=3526;
var gw_vs_4=3527;
var help546=3528;
var help653=3529;
var help481=3530;
var help529=3531;
var help425=3532;
var help400=3533;
var help509=3534;
var _DHCP=3535;
var help709=3536;
var help720=3537;
var help728=3538;
var help467=3539;
var help719=3540;
var help594=3541;
var help457=3542;
var help666=3543;
var help698=3544;
var help538=3545;
var help630=3546;
var help422=3547;
var help493=3548;
var help507=3549;
var help571=3550;
var RATE_ESTIMATOR_CONVERGENCE_ERROR=3551;
var help487=3552;
var help624=3553;
var help543=3554;
var help700=3555;
var help460=3556;
var help730=3557;
var help502=3558;
var help513=3559;
var help690=3560;
var help607=3561;
var help525=3562;
var help754=3563;
var help617=3564;
var help500=3565;
var help558=3566;
var help429=3567;
var help511=3568;
var help534=3569;
var help496=3570;
var help446=3571;
var help739=3572;
var help627=3573;
var _actsess=3574;
var help91a=3575;
var help91b=3576;
var help92x1=3577;
var help92x2=3578;
var TA21=3579;
var TA22=3580;
var help183=3581;
var help400_b=3582;
var help401_b=3583;
var help402_b=3584;
var help403=3585;
var help403_b=3586;
var help404=3587;
var help404_b=3588;
var help405=3589;
var help405_b=3590;
var help406=3591;
var help417=3592;
var help418=3593;
var help419=3594;
var help420=3595;
var help434=3596;
var help435=3597;
var help436=3598;
var help437=3599;
var help444=3600;
var help445=3601;
var help458=3602;
var help459=3603;
var help474=3604;
var help475=3605;
var help476=3606;
var help477=3607;
var help478=3608;
var help479=3609;
var help518=3610;
var help519=3611;
var help522=3612;
var help523=3613;
var help528=3614;
var help531=3615;
var help532=3616;
var help544=3617;
var help545=3618;
var help548=3619;
var help563=3620;
var help564=3621;
var help579=3622;
var help580=3623;
var help581=3624;
var help582=3625;
var help588=3626;
var help589=3627;
var help602=3628;
var help603=3629;
var help609=3630;
var help610=3631;
var help611=3632;
var help612=3633;
var help613=3634;
var help614=3635;
var help615=3636;
var help616=3637;
var help636=3638;
var help637=3639;
var help638=3640;
var help639=3641;
var help640=3642;
var help641=3643;
var help643=3644;
var help644=3645;
var help649=3646;
var help650=3647;
var help672=3648;
var help673=3649;
var help676=3650;
var help677=3651;
var help693=3652;
var help694=3653;
var help711=3654;
var help712=3655;
var help733=3656;
var help734=3657;
var help743=3658;
var help744=3659;
var help763=3660;
var help764=3661;
var help795a=3662;
var sa_Internal=3663;
var sa_External=3664;
var help823_15=3665;
var help831_1=3666;
var help893b=3667;
var help191=3668;
var help198=3669;
var _unknown_wait=3670;
var _unknown=3671;
var _na=3672;
var _sdi_nciy=3673;
var _sdi_dhcpclient=3674;
var _sdi_bpc=3675;
var _on=3676;
var _bln_nmgmy=3677;
var _sdi_s1=3678;
var _sdi_s10=3679;
var _sdi_s8=3680;
var _sdi_s9=3681;
var _sdi_days=3682;
var _sdi_disconnectpending=3683;
var _sdi_secs=3684;
var sd_Renew=3685;
var sd_Release=3686;
var sd_Disconnect=3687;
var sd_bp_login=3688;
var sd_bp_logout=3689;
var _channel=3690;
var sl_SLogs=3691;
var sps_intro2=3692;
var sps_pare=3693;
var sr_RTable=3694;
var sr_intro=3695;
var ss_title_stats=3696;
var sw_title=3697;
var ta_alert_1=3698;
var _pwsame_admin=3699;
var _pwsame_user=3700;
var ta_alert_3=3701;
var _invalidddnsserver=3702;
var _blankddnsserver=3703;
var tt_alert_checkdyndns=3704;
var td_alert_2=3705;
var td_alert_3=3706;
var td_DDNSDDNS=3707;
var tt_SelDynDns=3708;
var _emailaccnameisblank=3709;
var _blankfromemailaddr=3710;
var _blanktomemailaddr=3711;
var _blanksmtpmailaddr=3712;
var _badfromemailaddr=3713;
var _badtoemailaddr=3714;
var _invalidsmtpserveraddr=3715;
var _badsmtpserveraddr=3716;
var tf_NFWA=3717;
var tf_alert_1=3718;
var tf_LFWVis=3719;
var tf_FWCinP=3720;
var tf_Ching_FW=3721;
var tf_EM_not=3722;
var tf_LFWV=3723;
var tf_FWChNow=3724;
var TA17=3725;
var tps_sfp=3726;
var tps_dci=3727;
var tps_intro2=3728;
var tsc_alert_1=3729;
var tsc_alert_2=3730;
var tsc_alert_3=3731;
var tsc_alert_6=3732;
var tsc_alert_9=3733;
var tsc_SelDays=3734;
var tsc_TimeFr=3735;
var tsl_alert_3=3736;
var tsl_alert_1=3737;
var tsl_alert_2=3738;
var TA18=3739;
var tsc_pingt_msg9=3740;
var tt_alert_nontp=3741;
var tt_alert_tupdt=3742;
var TA24=3743;
var TA25=3744;
var fb_FbAc=3745;
var sentinel_1=3746;
var sentinel_2=3747;
var sentinal_3=3748;
var fl_Failure=3749;
var fl_text=3750;
var li_newfw=3751;
var rd_p_1=3752;
var rd_p_2=3753;
var rs_Restoring_Settings=3754;
var reh=3755;
var rs_RSPW=3756;
var rs_cld=3757;
var rs_Done=3758;
var rs_uld=3759;
var rs_usd=3760;
var rs_csd=3761;
var rs_Repacked=3762;
var rs_Converted=3763;
var rs_Saving=3764;
var sc_intro_rb=3765;
var _relogin=3766;
var _badWANsub=3767;
var wwa_pv5_alert_4=3768;
var wwa_pv5_alert_5=3769;
var wwa_pv5_alert_8=3770;
var wwa_pv5_alert_6=3771;
var wwa_pv5_alert_7=3772;
var wwa_pv5_alert_21=3773;
var _badPPTPgwip=3774;
var wwa_pv5_alert_15=3775;
var _badL2TPgwip=3776;
var wwa_pv5_alert_20=3777;
var wwl_intro_s3_1=3778;
var wwl_intro_s3_2r=3779;
var wwl_WSP_1=3780;
var wwl_wpa=3781;
var wwl_wpa2=3782;
var gw_vs_0=3783;
var gw_vs_8=3784;
var gw_sa_0=3785;
var gw_sa_2=3786;
var gw_sa_3=3787;
var gw_sa_4=3788;
var gw_sa_5=3789;
var gw_SelBPS=3790;
var gw_bp_0=3791;
var gw_bp_1=3792;
var gw_bp_2=3793;
var gw_wcn_alert_3=3794;
var gw_wcn_alert_4=3795;
var gw_wcn_alert5=3796;
var gw_wcn_alert6=3797;
var gw_wcn_alert7=3798;
var gw_wcn_err_ok=3799;
var gw_wcn_err_code=3800;
var gw_wcn_err_os_version=3801;
var gw_wcn_err_load_config=3802;
var gw_wcn_err_provision=3803;
var gw_wcn_err_io_write_config=3804;
var gw_wcn_err_encryption=3805;
var gw_wcn_err_exception=3806;
var gw_wcn_err_com=3807;
var gw_wcn_err_bad_wsetting_entry=3808;
var gw_wcn_err_bad_wps_profile=3809;
var gw_wcn_err_unsupported_wsetting=3810;
var gw_wcn_err_dom_processing=3811;
var gw_wcn_err_default=3812;
var adv_Everyone=3813;
var adv_Noone=3814;
var psQueued=3815;
var psStarting=3816;
var psClosed=3817;
var psIdle=3818;
var psReady=3819;
var psOffline=3820;
var psUnplugged=3821;
var psPrinting=3822;
var psPaperError=3823;
var up_gS_1=3824;
var up_gIUH_1=3825;
var up_gIUH_2=3826;
var up_gIUH_3=3827;
var up_gH_1=3828;
var up_ae_se_1=3829;
var up_ai_se_2=3830;
var up_ae_se_3=3831;
var up_ae_wic_1=3832;
var up_ae_wic_2=3833;
var up_nosave=3834;
var up_fm_dc_1=3835;
var up_fm_re_1=3836;
var up_fm_re_2=3837;
var up_fm_dr_1=3838;
var up_fm_dr_2=3839;
var up_fm_dr_3=3840;
var up_if_1=3841;
var up_rb_3=3842;
var up_rb_6=3843;
var up_vp_1=3844;
var up_vp_2=3845;
var up_vp_3=3846;
var up_vp_0=3847;
var up_vm_1=3848;
var up_vm_2=3849;
var up_he_1=3850;
var up_he_2=3851;
var up_he_5=3852;
var IPPPPPAP_AUTH_FAIL=3853;
var IPSTACK_REJECTED_SPOOFED_PACKET=3854;
var IPDHCPSERVER_HOST_IS_ACTIVE=3855;
var BSECURE_LOG_AUTH_FAIL_UNREG=3856;
var RATE_ESTIMATOR_RATE_IS=3857;
var GW_IPFILTER_DENY=3858;
var GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION=3859;
var IPNAT_ILLEGAL_DEST=3860;
var BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT=3861;
var IPDHCPSERVER_LEASE_REVOKED1=3862;
var LOG_PREV_MSG_REPEATED_1_TIME=3863;
var GW_UPNP_PORTMAP_VS_CHANGE=3864;
var IPDHCPSERVER_LEASE_EXPIRED=3865;
var BSECURE_LOG_AUTH_FAIL_INTNL=3866;
var GW_UPNP_PORTMAP_DEL=3867;
var GW_SMTP_EMAIL_INVALID_TO_ADDRESS=3868;
var BSECURE_LOG_FLTR_DISCONNECTED_CLOSED=3869;
var IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC=3870;
var BSECURE_LOG_AUTH_PASS=3871;
var BSECURE_LOG_AUTH_FAIL_UNKNW=3872;
var IPPPPPAP_AUTH_RESULT=3873;
var BSECURE_LOG_AUTH_FAIL_RENEW=3874;
var IPDHCPSERVER_LEASE_DENIED=3875;
var GW_SMTP_EMAIL_TIMEOUT=3876;
var BSECURE_LOG_AUTH_FAIL_DB=3877;
var IPDHCPSERVER_PARAM_DB_UPDATED=3878;
var APP_RULES=3879;
var IPDHCPSERVER_LEASE_POOL_FULL=3880;
var IPPPPPAP_AUTH_TIMEOUT=3881;
var ADVANCED_NETWORKS=3882;
var IPDHCPSERVER_LEASE_ASSIGNED=3883;
var BSECURE_LOG_FLTR_CONNECTED=3884;
var BSECURE_LOG_AUTH_CONNECTED=3885;
var BSECURE_LOG_AUTH_FAIL_PKT=3886;
var IPSMTPCLIENT_CONN_FAILED=3887;
var IPPPPPAP_AUTH_SUCCESS=3888;
var GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED=3889;
var GW_SMTP_EMAIL_SEND_FAILURE=3890;
var IPDHCPSERVER_LEASE_RELEASED=3891;
var IPDHCPSERVER_PARAM_DB_ADDED=3892;
var IPPPPPAP_AUTH_ISSUE=3893;
var GW_UPNP_PORTMAP_ADD=3894;
var GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS=3895;
var GW_UPNP_PORTMAP_REFRESH=3896;
var GW_UPNP_PORTMAP_EXPIRE=3897;
var IPDHCPSERVER_PARAM_DB_REMOVED=3898;
var IPDHCPSERVER_LEASE_DELETED=3899;
var GW_UPNP_PORTMAP_CONFLICT=3900;
var TA1=3901;
var aa_alert_11=3902;
var aa_alert_1=3903;
var aa_sched_conf_3=3904;
var aa_alert_16=3905;
var aa_alert_2=3906;
var aa_alert_3=3907;
var aa_alert_4=3908;
var aa_alert_5=3909;
var aa_alert_6=3910;
var aa_AT_2=3911;
var _copyright=3912;
var aw_alert_1=3913;
var aw_alert_2=3914;
var aw_alert_3=3915;
var aw_alert_4=3916;
var af_alert_1=3917;
var af_alert_2=3918;
var TA19=3919;
var ag_alert_4=3920;
var ag_alert_5=3921;
var ag_conflict10=3922;
var ag_conflict20=3923;
var ag_conflict21=3924;
var ag_alert_1=3925;
var ag_alert_3=3926;
var ag_alert2=3927;
var _tcpports=3928;
var _udpports=3929;
var ag_conflict4=3930;
var tsc_alert_7=3931;
var ai_alert_3=3932;
var ai_alert_5=3933;
var ai_alert_7=3934;
var ai_alert_4=3935;
var ai_alert_6=3936;
var tsc_alert_5=3937;
var ai_title_2=3938;
var _edit=3939;
var _srcip=3940;
var ai_c2=3941;
var ai_c3=3942;
var amaf_alert_1=3943;
var am_cMT_deny=3944;
var am_cMT_Allow=3945;
var _sr_nriy=3946;
var ar_alert_1=3947;
var ar_alert_2=3948;
var ar_alert_3=3949;
var ar_alert_4=3950;
var ar_alert_5=3951;
var ar_RoutI=3952;
var ar_Route=3953;
var ar_RoutesList=3954;
var _delete=3955;
var ar_ERTable=3956;
var ag_alert_duplicate_name=3957;
var ag_alert_duplicate=3958;
var ag_inuse=3959;
var _specapps_alert_2=3960;
var _specapps_tpr=3961;
var _specapps_ipr=3962;
var as_title_SAR=3963;
var as_TPRange=3964;
var as_ex=3965;
var as_TPR=3966;
var as_IPR=3967;
var as_IPrt=3968;
var at_alert_1_1=3969;
var at_alert_15=3970;
var at_alert_16=3971;
var at_alert_17=3972;
var at_alert_2=3973;
var at_alert_18=3974;
var at_alert_3=3975;
var at_alert_19=3976;
var at_alert_4=3977;
var at_alert_5=3978;
var at_alert_20=3979;
var at_alert_6=3980;
var at_alert_21=3981;
var at_alert_8=3982;
var at_alert_7=3983;
var at_alert_10=3984;
var at_alert_9=3985;
var at_alert_11=3986;
var at_alert_22=3987;
var at_alert_23=3988;
var at_alert_24=3989;
var at_alert_14=3990;
var at_Prot_0=3991;
var _srcport=3992;
var at_DIPR=3993;
var at_DPR=3994;
var av_alert_11=3995;
var av_alert_21=3996;
var av_alert_24=3997;
var av_alert_1=3998;
var av_alert_2=3999;
var av_alert_3=4000;
var av_alert_4=4001;
var av_alert_12=4002;
var av_alert_18=4003;
var av_alert_23=4004;
var av_alert_19=4005;
var av_alert_20=4006;
var av_alert_13=4007;
var av_alert_17=4008;
var av_alert_5=4009;
var av_alert_6=4010;
var av_alert_7=4011;
var av_alert_8=4012;
var av_alert_9=4013;
var av_alert_10=4014;
var _public=4015;
var _other=4016;
var _private=4017;
var aa_WebSite=4018;
var awf_alert_4=4019;
var awf_alert_5=4020;
var awf_alert_7=4021;
var awf_alert_8=4022;
var int_ConWz2=4023;
var int_intro_ConWz=4024;
var int_WlsWz=4025;
var int_intro_WlsWz=4026;
var hhbi_wiz=4027;
var hhbi_man=4028;
var bd_noneyet=4029;
var bd_revoked=4030;
var bln_alert_3=4031;
var bd_alert_10=4032;
var bd_alert_11=4033;
var bd_alert_1=4034;
var bd_alert_3=4035;
var bd_alert_13=4036;
var bd_alert_12=4037;
var bd_alert_5=4038;
var bd_alert_6=4039;
var bd_alert_7=4040;
var TA20=4041;
var bd_alert_8=4042;
var bd_alert_22=4043;
var bd_alert_23=4044;
var bd_alert_24=4045;
var _badWANIP=4046;
var bwn_alert_2=4047;
var bwn_alert_3=4048;
var bwn_alert_4=4049;
var bwn_alert_5=4050;
var _nousername=4051;
var bwn_alert_8=4052;
var bwn_alert_12=4053;
var _badPPTPip=4054;
var _badPPTPsub=4055;
var _badPPTPipsub=4056;
var bwn_alert_11=4057;
var _badL2TP3=4058;
var _badL2TP=4059;
var _badL2TP2=4060;
var bwn_alert_17=4061;
var bwn_alert_21=4062;
var bws_alert_15=4063;
var bws_alert_16=4064;
var bwl_alert_2=4065;
var bwl_alert_3=4066;
var bwl_alert_15=4067;
var bwl_alert_16=4068;
var bwl_alert_4=4069;
var bwl_alert_5=4070;
var bwl_alert_6=4071;
var bwl_alert_7=4072;
var bwl_alert_8=4073;
var bwl_alert_9=4074;
var bwl_alert_10=4075;
var bws_alert_2=4076;
var bwl_alert_11=4077;
var bwl_alert_12=4078;
var bws_alert_3=4079;
var aw_alert_5_1=4080;
var bwl_alert_13=4081;
var bwl_alert_14=4082;
var bwl_Mode_2=4083;
var bwl_Mode_3=4084;
var bwl_Mode_1=4085;
var bwl_Mode_8=4086;
var bwl_Mode_11=4087;
var bwl_ht20=4088;
var bwl_ht2040=4089;
var bwl_TxR_0=4090;
var TA9=4091;
var TA11=4092;
var TA12=4093;
var TA14=4094;
var TA15=4095;
var _wizard=4096;
var bwz_intro=4097;
var bwz_intro_ConWz=4098;
var bwz_LConWz=4099;
var bwz_WlsWz=4100;
var bwz_intro_WlsWz=4101;
var bwz_LWlsWz=4102;
var _specapps=4103;
var _gaming=4104;
var _basic=4105;
var ag_alert_empty_name=4106;
var ag_alert_duplicate_name2=4107;
var amaf_alert_2=4108;
var specapps_alert_duplicate_name=4109;
var specapps_alert_duplicate1=4110;
var specapps_alert_conflict1=4111;
var specapps_alert_empty_schedule=4112;
var at_title_TSSet=4113;
var av_alert_35=4114;
var av_alert_empty_name=4115;
var av_alert_16=4116;
var bln_alert_lannbpri=4117;
var bln_alert_lannbsec=4118;
var lan_dns=4119;
var lan_dns2=4120;
var bln_NetBIOSReg_H=4121;
var bln_NetBIOSReg_M=4122;
var bln_NetBIOSReg_P=4123;
var bln_NetBIOSReg_B=4124;
var _help=4125;
var help81ets=4126;
var af_EFT_h4=4127;
var af_EFT_h0=4128;
var af_EFT_h1=4129;
var af_EFT_h2=4130;
var af_EFT_h5=4131;
var af_UEFT_h1=4132;
var af_TEFT_h2=4133;
var help309A=4134;
var help400_1=4135;
var help401_1=4136;
var help402_1=4137;
var help402_2=4138;
var help405_1=4139;
var help405_2=4140;
var help405_3=4141;
var help405_4=4142;
var _sdi_s1a=4143;
var ta_alert_3b=4144;
var ta_alert_3c=4145;
var ta_alert_3d=4146;
var ta_alert_3e=4147;
var ta_alert_3f=4148;
var ta_alert_3g=4149;
var ta_ELM=4150;
var ta_LMAP=4151;
var fb_FailLogin=4152;
var fb_FailLogin_1=4153;
var open=4154;
var at_Prot_1=4155;
var _223=4156;
var _225ap=4157;
var _226ap=4158;
var _1044wired=4159;
var _1044awired=4160;
var TEXT0=4161;
var regenerate=4162;
var _title_AdvDns=4163;
var _desc_AdvDns=4164;
var _en_AdvDns=4165;
var _st_AdvDns=4166;
var _sp_title_AdvDNS=4167;
var _sp_desc1_AdvDNS=4168;
var _sp_desc2_AdvDNS=4169;
var _sp_desc3_AdvDNS=4170;
var _sp_desc4_AdvDNS=4171;
var TEXT041_1=4172;
var TEXT041_2=4173;
var TEXT041_3=4174;
var TEXT041_4=4175;
var TEXT042_1=4176;
var TEXT042_2=4177;
var GW_URL_INVALID=4178;
var GW_LAN_NETBIOS_SCOPE_INVALID=4179;
var GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a=4180;
var bwn_Mode_DHCPPLUS=4181;
var net_sniper_support=4182;
var TEXT_xkjs_descript=4183;
var SEL_DIAL_MODE=4184;
var pppoe_dialmode_normal=4185;
var pppoe_dialmode_sp1=4186;
var pppoe_dialmode_sp2=4187;
var pppoe_dialmode_sp3=4188;
var pppoe_dialmode_sp4=4189;
var pppoe_dialmode_sp5=4190;
var pppoe_dialmode_sp6=4191;
var pppoe_dialmode_learn=4192;
var bt_learn_text=4193;
var box_ip_mac_binding=4194;
var ip_mac_binding_desc=4195;
var xkjs_support=4196;
var ddns_serv_type=4197;
var ddns_domain=4198;
var ddns_account=4199;
var virtual_pub_port_err=4200;
var virtual_pri_port_err=4201;
var virtual_proto_num_err=4202;
var menu_wps=4203;
var tc_iprange=4204;
var tc_opmode=4205;
var tc_bw=4206;
var tc_schedule=4207;
var tc_new_sch=4208;
var tc_min_bw=4209;
var tc_max_bw=4210;
var _login_admin=4211;
var _login_user=4212;
var pppoe_plus_dail=4213;
var wwa_msg_dhcpplus=4214;
var GW_WAN_DHCPPLUS_USERNAME_INVALID=4215;
var GW_WAN_DHCPPLUS_PASSWORD_INVALID=4216;
var te_SMTPPort=4217;
var WLANMODE=4218;
var ROUTER_MODE=4219;
var AP_MODE=4220;
var WDSROUTER_MODE=4221;
var WDSAP_MODE=4222;
var BR_SET=4223;
var device_mode=4224;
var router_mode=4225;
var ap_mode=4226;
var auto_mode=4227;
var enable_WDS=4228;
var ES_WELCOME=4229;
var ES_AUTODECT=4230;
var ES_CABLELOST_bnr=4231;
var ES_CABLELOST_dsc1=4232;
var ES_CABLELOST_dsc2=4233;
var ES_DONT_CONN_btn=4234;
var ES_UPDATE_SETTING_bnr=4235;
var ES_UPDATE_SETTING_dsc=4236;
var ES_CONFIG_INTERNET_bnr=4237;
var ES_CONFIG_INTERNET_dsc1=4238;
var ES_CONFIG_INTERNET_dsc2=4239;
var ES_INTERNET_CONN_dsc=4240;
var ES_MUST_FIELD_dsc=4241;
var ES_DIALUP_ERROR_bnr=4242;
var ES_DIALUP_ERROR_dsc=4243;
var ES_NAME=4244;
var ES_CONN_dsc=4245;
var ES_what_is_this=4246;
var ES_PRI_DNS=4247;
var ES_SEC_DNS=4248;
var ES_GW_ADDR=4249;
var ES_MASK=4250;
var ES_IP_ADDR=4251;
var ES_complete=4252;
var ES_save_dsc=4253;
var ES_status=4254;
var ES_connected=4255;
var ES_unconnected=4256;
var ES_wlan_setting=4257;
var ES_wlan_ssid=4258;
var ES_security=4259;
var ES_unsecured=4260;
var ES_unsecured_suggest=4261;
var ES_save_mySetting=4262;
var ES_sync_pw=4263;
var ES_save=4264;
var ES_network_key=4265;
var ES_autogen_key=4266;
var ES_disable_wifi_sec=4267;
var ES_wifi_sec_recomm=4268;
var ES_current_setting_dsc=4269;
var ES_current_setting=4270;
var ES_manual_btn=4271;
var ES_cancel=4272;
var logout_caption=4273;
var logout_desc=4274;
var logout_return=4275;
var st_connected_time=4276;
var t_ctl_title=4277;
var t_ctl_note=4278;
var t_ctl_note1=4279;
var page_title=4280;
var ac_alert_invalid_port=4281;
var ac_alert_dup_name=4282;
var ac_alert_port_conflit=4283;
var ac_alert_policy_null=4284;
var ac_alert_choose_dev=4285;
var ES_static_no_internet=4286;
var ES_static_no_internet_desc=4287;
var _CFM_close_window=4288;
var ES_save_result=4289;
var ES_save_success=4290;
var ES_confirm_bt=4291;
var sch_timeformat=4292;
var sch_hourfmt_12=4293;
var sch_hourfmt_24=4294;
var no_available_update=4295;
var clear_lang_pack=4296;
var current_lang_pack_version=4297;
var current_lang_pack_date=4298;
var lang_package_info=4299;
var lang_package_note1=4300;
var lang_package_note2=4301;
var latest_lang_package_ver=4302;
var latest_lang_package_date=4303;
var no_lang_pack=4304;
var pf_name_empty=4305;
var vs_name_empty=4306;
var fw_checksum_err=4307;
var fw_bad_hwid=4308;
var fw_unknow_file_format=4309;
var fw_fw_upgrade_success=4310;
var fw_lp_upgrade_success=4311;
var fw_cfg_upgrade_success=4312;
var ES_timectrl_bnr=4313;
var ES_timectrl_btn=4314;
var ES_webpolicy_btn=4315;
var HW_NAT_desc=4316;
var HW_NAT_enable=4317;
var alert_hw_nat_1=4318;
var alert_hw_nat_2=4319;
var alert_hw_nat_3=4320;
var help_auto_disable_hw_nat=4321;
var help_auto_disable_hw_nat_1=4322;
var help_hw_nat=4323;
var help_hw_nat_desc=4324;
var ES_step_wifi_security=4325;
var ES_cable_lost_desc=4326;
var ES_btn_try_again=4327;
var ES_auto_detect_desc=4328;
var ES_auto_detect_failed_desc=4329;
var ES_btn_guide_me=4330;
var ES_note_support_wpa=4331;
var ES_btn_save_conn=4332;
var ES_btn_save=4333;
var ES_bookmark=4334;
var v6_routing=4335;
var v6_routing_table=4336;
var v6_routing_info=4337;
var ipv6=4338;
var ipv6_firewall=4339;
var ipv6_firewall_info=4340;
var _6rd_settings=4341;
var ipv4_addr=4342;
var mask_len=4343;
var IPV6_ULA_TEXT01=4344;
var IPV6_ULA_TEXT02=4345;
var IPV6_ULA_TEXT03=4346;
var IPV6_ULA_TEXT04=4347;
var IPV6_ULA_TEXT05=4348;
var IPV6_ULA_TEXT06=4349;
var IPV6_ULA_TEXT07=4350;
var IPV6_ULA_TEXT08=4351;
var IPV6_ULA_TEXT09=4352;
var IPV6_ULA_TEXT10=4353;
var IPV6_ULA_TEXT11=4354;
var IPV6_ULA_TEXT12=4355;
var IPV6_ULA_TEXT13=4356;
var IPV6_ULA_TEXT14=4357;
var LW27_v6=4358;
var LW29_v6=4359;
var IPv6_Local_Info=4360;
var IPv6_Simple_Security=4361;
var IPv6_Simple_Security_enable=4362;
var IPv6_Wizard_6rd_title=4363;
var fr_name_empty=4364;
var r6_name_empty=4365;
var wwz_wwl_intro_s2_1=4366;
var wwz_wwl_intro_s2_1_1=4367;
var wwz_wwl_intro_s2_1_2=4368;
var wwz_wwl_intro_s2_2=4369;
var wwz_wwl_intro_s2_2_1=4370;
var wwz_wwl_intro_s2_2_2=4371;
var ES_title_s3=4372;
var ES_title_s4=4373;
var ES_title_s5=4374;
var GW_WLAN_RADIO_1_NAME=4375;
var bwl_Mode_n=4376;
var bwl_Mode_a=4377;
var bwl_Mode_5=4378;
var MSG049=4379;
var MSG050=4380;
var HWerr=4381;
var storage=4382;
var sto_into=4383;
var sto_http_0=4384;
var sto_http_1=4385;
var sto_http_2=4386;
var sto_http_3=4387;
var sto_http_4=4388;
var sto_http_5=4389;
var sto_creat=4390;
var _add_edit=4391;
var sto_list=4392;
var _modify=4393;
var sto_path=4394;
var sto_permi=4395;
var sto_no_dev=4396;
var sto_dev=4397;
var _total_space=4398;
var _free_space=4399;
var sto_link_0=4400;
var sto_link_1=4401;
var sto_link_2=4402;
var _email_now=4403;
var sto_help=4404;
var _DevLink=4405;
var _folder=4406;
var _browse=4407;
var _append=4408;
var _readonly=4409;
var _readwrite=4410;
var _AppendNewFolder=4411;
var MSG051=4412;
var MSG052=4413;
var MSG053=4414;
var MSG054=4415;
var _AddFolder=4416;
var _StorageLink=4417;
