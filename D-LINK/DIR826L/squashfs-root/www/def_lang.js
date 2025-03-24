//Version=1.02b02
//Language=ENGLISH
//Date=Mon, 13, Aug, 2012
//Merged=FALSE
//Merged Fw=FALSE
var msg = new Array ( //_NO_SHARE_NAME_
	"The IP Address entered is invalid", //INVALID_IP_ADDRESS
	"The IP Address cannot be zero.", //ZERO_IP_ADDRESS
	"IP Address", //IP_ADDRESS_DESC
	"The Subnet Mask entered is invalid", //INVALID_MASK_ADDRESS
	"The Subnet Mask can not be zero.", //ZERO_MASK_ADDRESS
	"Subnet Mask", //MASK_ADDRESS_DESC
	"The Gateway IP Address entered is invalid", //INVALID_GATEWAY_ADDRESS
	"The Gateway IP Address cannot be zero", //ZERO_GATEWAY_ADDRESS
	"Gateway IP Address", //GATEWAY_ADDRESS_DESC
	"%s Gateway IP address %s must be within the WAN subnet.", //NOT_SAME_DOMAIN
	"The Starting IP Address entered is invalid (IP Range: 1~254)", //INVALID_START_IP
	"Please enter another SMTP Server or IP Address", //SMTP_SERVER_ERROR
	"Starting IP Address", //START_IP_DESC
	"The LAN IP Address and the Start IP Address are not in the same subnet", //START_INVALID_DOMAIN
	"The Ending IP Address entered is invalid.", //INVALID_END_IP
	"Please enter another Domain", //DOMAIN_ERROR
	"The LAN IP Address and the End IP Address are not in the same subnet", //END_INVALID_DOMAIN
	"The Primary DNS Address entered is invalid", //INVALID_DNS_ADDRESS
	"The Primary DNS Address cannot be zero", //ZERO_DNS_ADDRESS
	"Primary DNS Address", //DNS_ADDRESS_DESC
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"WEP cannot be disabled when the Authentication type is set to Shared Key", //AUTH_TYPE_ERROR
	"The length of the Passphrase must be at least 8 characters", //PSK_LENGTH_ERROR
	"The Confirmed Passphrase does not match the Passphrase", //PSK_MATCH_ERROR
	"The Confirmed Password does not match the New Password", //MATCH_PWD_ERROR
	"The selected WEP key field cannot be blank", //WEP_KEY_EMPTY
	"Please enter another IP Address", //ZERO_STATIC_DHCP_IP
	"Quit setup wizard and discard settings?", //QUIT_WIZARD
	"The MAC Address entered is invalid.", //MAC_ADDRESS_ERROR
	"The Ending IP Address must be greater than the Starting IP Address", //IP_RANGE_ERROR
	"The Secondary DNS Address entered is invalid", //INVALID_SEC_DNS_ADDRESS
	"The Secondary DNS Address cannot be zero", //ZERO_SEC_DNS_ADDRESS
	"Secondary DNS Address", //SEC_DNS_ADDRESS_DESC
	"The confirmed password does not match the new Admin password", //ADMIN_PASS_ERROR
	"The confirmed password does not match the new User password", //USER_PASS_ERROR
	"The Host Name is invalid!", //DDNS_HOST_ERROR
	"Please enter another Starting IP Address", //ZERO_START_IP
	"Are you sure you want to reset the device to its factory default settings?\nThis will cause all current settings to be lost.", //RESTORE_DEFAULT
	"Are you sure you want to reboot the device?\nRebooting will disconnect any active internet sessions.", //REBOOT_ROUTER
	"Load settings from a saved configuration file?", //LOAD_SETTING
	"You must enter the name of a configuration file first.", //LOAD_FILE_ERROR
	"Please enter at least one Control Domain", //CONTROL_DOMAIN_ERROR
	"Please enter another Server Name", //DDNS_SERVER_ERROR
	"Are you sure that you want to delete this Virtual Server Rule?", //DEL_SERVER_MSG
	"Are you sure that you want to delete this Application Rule", //DEL_APPLICATION_MSG
	"Are you sure that you want to delete this Filter?", //DEL_FILTER_MSG
	"Are you sure that you want to delete this Route?", //DEL_ROUTE_MSG
	"Are you sure that you want to delete this MAC Address?", //DEL_MAC_MSG
	"Are you sure that you want to delete this Keyword?", //DEL_KEYWORD_MSG
	"Are you sure that you want to delete this Domain?", //DEL_DOMAIN_MSG
	"Are you sure that you want to delete this Entry?", //DEL_ENTRY_MSG
	"Are you sure that you want to delete this DHCP Reservation?", //DEL_STATIC_DHCP_MSG
	"Please enter another port number", //PORT_ERROR
	"Please enter another Permitted Domain", //PERMIT_DOMAIN_ERROR
	"Please select a Firmware file to upgrade the router to", //FIRMWARE_UPGRADE_ERROR
	"The Keyword entered already exists in the list", //SAME_KEYWORD_ERROR
	"Please enter another Key", //WIZARD_KEY_EMPTY
	"Unable to add another Keyword", //ADD_KEYWORD_ERROR
	"Please select a machine first", //SELECT_MACHINE_ERROR
	"The Domain entered already exists in the list of Blocked Domains", //SAME_BLOCK_DOMAIN
	"Unable to add another Blocked Domain", //ADD_BLOCK_DOMAIN_ERROR
	"The Domain entered already exists in the list of Permitted Domains", //SAME_PERMIT_DOMAIN
	"Please enter another Password", //DDNS_PASS_ERROR
	"Unable to add another Permitted Domain", //ADD_PERMIT_DOMAIN_ERROR
	"Please enter another Blocked Domain", //BLOCK_DOMAIN_ERROR
	"Unable to add another Control Domains", //ADD_CONTROL_DOMAIN_ERROR
	"Please enter another Wireless Security Password", //SECURITY_PWD_ERROR
	"The RADIUS Server 1 IP Address entered is invalid", //INVALID_RADIUS_SERVER1_IP
	"The Radius Server 1 IP Address cannot be zero or blank", //ZERO_RADIUS_SERVER1_IP
	"Radius Server 1 IP Address", //RADIUS_SERVER1_IP_DESC
	"The RADIUS Server 2 IP Address entered is invalid", //INVALID_RADIUS_SERVER2_IP
	"The Radius Server 2 IP Address cannot be zero or blank", //ZERO_RADIUS_SERVER2_IP
	"Radius Server 2 IP Address", //RADIUS_SERVER2_IP_DESC
	"The IP Address entered is invalid (IP Range: 1~254)", //INVALID_STATIC_DHCP_IP
	"Please enter another Ending IP Address", //ZERO_END_IP
	"Please enter another name", //NAME_ERROR
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
	"Please select a Keyword to delete", //DEL_KEYWORD_ERROR
	"Please select a Permitted Domain to delete", //DEL_PERMIT_DOMAIN_ERROR
	"Please select a Blocked Domain to delete", //DEL_BLOCK_DOMAIN_ERROR
	"The Parental Control rule entered is already in the list", //DUPLICATE_URL_ERROR
	"Login Name error", //LOGIN_NAME_ERROR
	"Login Password error", //LOGIN_PASS_ERROR
	"%s is conflicted with LAN IP address, please enter again.", //THE_SAME_LAN_IP
	"The PSK should Hex.", //THE_PSK_IS_HEX
	"The IP Address and the reservation IP Address are not in the same subnet.", //SER_NOT_SAME_DOMAIN
	"There is unsaved data on this page. Do you want to abandon it?%s If not, press Cancel and then click Save Settings.%s If so, press Ok.", //IS_CHANGE_DATA
	"The confirmed password does not match the new User password", //DDNS_PASS_ERROR_MARTH
	"Rule name can not be empty string", //INBOUND_NAME_ERROR
	"The Ending Port number must be greater than the Starting Port number", //PORT_RANGE_ERROR
	"Are you sure that you want to enable/disable", //CHECK_ENABLE
	"Are you sure that you want to delete ?", //DEL_MSG
	"You must abandon all your changes in order to define a new schedule.\n Press 'Ok' to abandon these changes and display the Schedule page.\n Otherwise press 'Cancel'.", //GO_SCHEDULE
	"Please enter user name", //PPP_USERNAME_EMPTY
	"Nothing has changed, save anyway?", //FORM_MODIFIED_CHECK
	"Please select an Application Name first", //SELECT_APPLICATION_ERROR
	"Please select a Computer Name first", //SELECT_COMPUTER_ERROR
	"Please enter another Name", //STATIC_DHCP_NAME
	"Please select a Control Domain to delete", //DEL_CONTROL_DOMAIN_ERROR
	"Please enter another Keyword", //KEYWORD_ERROR
	"Please enter a Private IP Address.", //PRIVATE_IP_ERROR
	"Please enter a Firewall Port number", //PUBLIC_PORT_ERROR
	"Please enter a Trigger Port number", //TRIGGER_PORT_ERROR
	"Please enter a valid email Address", //EMAIL_ADDRESS_ERROR
	"Please enter either a Host Name or an IP Address", //PING_IP_ERROR
	"Only the Admin account can download the settings", //DOWNLOAD_SETTING_ERROR
	"Please enter another User Name", //DDNS_USER_ERROR
	"Ending IP Address", //END_IP_DESC
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
var SMTP_SERVER_ERROR=11;
var START_IP_DESC=12;
var START_INVALID_DOMAIN=13;
var INVALID_END_IP=14;
var DOMAIN_ERROR=15;
var END_INVALID_DOMAIN=16;
var INVALID_DNS_ADDRESS=17;
var ZERO_DNS_ADDRESS=18;
var DNS_ADDRESS_DESC=19;
var SSID_EMPTY_ERROR=20;
var AUTH_TYPE_ERROR=21;
var PSK_LENGTH_ERROR=22;
var PSK_MATCH_ERROR=23;
var MATCH_PWD_ERROR=24;
var WEP_KEY_EMPTY=25;
var ZERO_STATIC_DHCP_IP=26;
var QUIT_WIZARD=27;
var MAC_ADDRESS_ERROR=28;
var IP_RANGE_ERROR=29;
var INVALID_SEC_DNS_ADDRESS=30;
var ZERO_SEC_DNS_ADDRESS=31;
var SEC_DNS_ADDRESS_DESC=32;
var ADMIN_PASS_ERROR=33;
var USER_PASS_ERROR=34;
var DDNS_HOST_ERROR=35;
var ZERO_START_IP=36;
var RESTORE_DEFAULT=37;
var REBOOT_ROUTER=38;
var LOAD_SETTING=39;
var LOAD_FILE_ERROR=40;
var CONTROL_DOMAIN_ERROR=41;
var DDNS_SERVER_ERROR=42;
var DEL_SERVER_MSG=43;
var DEL_APPLICATION_MSG=44;
var DEL_FILTER_MSG=45;
var DEL_ROUTE_MSG=46;
var DEL_MAC_MSG=47;
var DEL_KEYWORD_MSG=48;
var DEL_DOMAIN_MSG=49;
var DEL_ENTRY_MSG=50;
var DEL_STATIC_DHCP_MSG=51;
var PORT_ERROR=52;
var PERMIT_DOMAIN_ERROR=53;
var FIRMWARE_UPGRADE_ERROR=54;
var SAME_KEYWORD_ERROR=55;
var WIZARD_KEY_EMPTY=56;
var ADD_KEYWORD_ERROR=57;
var SELECT_MACHINE_ERROR=58;
var SAME_BLOCK_DOMAIN=59;
var ADD_BLOCK_DOMAIN_ERROR=60;
var SAME_PERMIT_DOMAIN=61;
var DDNS_PASS_ERROR=62;
var ADD_PERMIT_DOMAIN_ERROR=63;
var BLOCK_DOMAIN_ERROR=64;
var ADD_CONTROL_DOMAIN_ERROR=65;
var SECURITY_PWD_ERROR=66;
var INVALID_RADIUS_SERVER1_IP=67;
var ZERO_RADIUS_SERVER1_IP=68;
var RADIUS_SERVER1_IP_DESC=69;
var INVALID_RADIUS_SERVER2_IP=70;
var ZERO_RADIUS_SERVER2_IP=71;
var RADIUS_SERVER2_IP_DESC=72;
var INVALID_STATIC_DHCP_IP=73;
var ZERO_END_IP=74;
var NAME_ERROR=75;
var INVALID_SERVER_IP=76;
var ZERO_SERVER_IP=77;
var SERVER_IP_DESC=78;
var MATCH_WIZARD_PWD_ERROR=79;
var INVALID_SOURCE_START_IP=80;
var ZERO_SOURCE_START_IP=81;
var SOURCE_START_IP_DESC=82;
var INVALID_SOURCE_END_IP=83;
var ZERO_SOURCE_END_IP=84;
var SOURCE_END_IP_DESC=85;
var INVALID_DEST_START_IP=86;
var ZERO_DEST_START_IP=87;
var DEST_START_IP_DESC=88;
var INVALID_DEST_END_IP=89;
var ZERO_DEST_END_IP=90;
var DEST_END_IP_DESC=91;
var PSK_OVER_LEN=92;
var RESET_JUMPSTAR=93;
var DEL_RULE_MSG=94;
var DEL_SCHEDULE_MSG=95;
var ADD_SCHEDULE_ERROR=96;
var SCHEDULE_NAME_ERROR=97;
var SCHEDULE_NAME_SPACE_ERROR=98;
var START_TIME_ERROR=99;
var END_TIME_ERROR=100;
var TIME_RANGE_ERROR=101;
var DEL_KEYWORD_ERROR=102;
var DEL_PERMIT_DOMAIN_ERROR=103;
var DEL_BLOCK_DOMAIN_ERROR=104;
var DUPLICATE_URL_ERROR=105;
var LOGIN_NAME_ERROR=106;
var LOGIN_PASS_ERROR=107;
var THE_SAME_LAN_IP=108;
var THE_PSK_IS_HEX=109;
var SER_NOT_SAME_DOMAIN=110;
var IS_CHANGE_DATA=111;
var DDNS_PASS_ERROR_MARTH=112;
var INBOUND_NAME_ERROR=113;
var PORT_RANGE_ERROR=114;
var CHECK_ENABLE=115;
var DEL_MSG=116;
var GO_SCHEDULE=117;
var PPP_USERNAME_EMPTY=118;
var FORM_MODIFIED_CHECK=119;
var SELECT_APPLICATION_ERROR=120;
var SELECT_COMPUTER_ERROR=121;
var STATIC_DHCP_NAME=122;
var DEL_CONTROL_DOMAIN_ERROR=123;
var KEYWORD_ERROR=124;
var PRIVATE_IP_ERROR=125;
var PUBLIC_PORT_ERROR=126;
var TRIGGER_PORT_ERROR=127;
var EMAIL_ADDRESS_ERROR=128;
var PING_IP_ERROR=129;
var DOWNLOAD_SETTING_ERROR=130;
var DDNS_USER_ERROR=131;
var END_IP_DESC=132;

var which_lang = new Array ( //_NO_SHARE_NAME_
	"When feature is enabled, your internet traffic will be protected by a security ready DNS server. This feature provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //_Advanced_01
	"Although Advanced DNS feature is enabled, DNS IP address of your workstation can still be modified to the DNS server IP you desire. Please note that the router does not dictate the DNS name resolution when DNS IP address is configured on the workstation.", //_Advanced_03
	"If you selected this option and have VPN or Intranet setup in your network, you can disable Advanced DNS service if you experience connection difficulties.", //_Advanced_04
	"Advanced DNS Service", //bwn_ict_dns
	"Advanced DNS is a free security option that provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //bwn_msg_Modes_dns
	"Enable Access Control", //aa_EAC
	"Advanced DNS", //_dlinkdns
	"My USB type is", //new_bwn_mici_usb
	"Can't choose TKIP when 802.11n only.!!", //_tkip_11n
	"SharePort For Guest Zone", //bln_title_guest_use_shareport
	"Enable Routing Between Zones", //IPV6_TEXT3
	"Mixed 802.11n and 802.11g", //bwl_Mode_10
	"Enter the AFTR address information provided by your Internet Service Provider(ISP).", //IPV6_TEXT148
	"Regenerate", //_regenerate
	"Please enter the following settings in the device that you are adding to your wireless network and keep a note of it for future reference.", //TEXT048
	"Enable Email Notification", //te_EnEmN
	"USB 3.5G Settings", //usb3g_titile
	"APN Name", //usb3g_apn_name
	"Dial Number", //usb3g_dial_num
	"Reconnect Mode(0:always/1:OnDemand/2:Manual)", //usb3g_reconnect_mode
	"Idle Time", //usb3g_max_idle_time
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
	"Enter the email address where you want the email sent.", //help862
	"Authentication Protocol", //wwan_auth_label
	"Auto(PAP+CHAP)", //wwan_auth_auto
	"PAP issued an authentication request.", //IPPPPPAP_AUTH_ISSUE
	"CHAP only", //wwan_auth_chap
	"MS CHAP only", //wwan_auth_mschap
	"Select to share a USB printer, scanner, or storage device connected to the USB port behind the router with multiple users within your network.", //usb_network_help
	"Device drivers and the D-Link USB Network Utility must be installed on each computer that will use the device.", //usb_network_support_help
	"Select 3G USB Adapter to use a 3G adapter to provide access to the Internet using an EV-DO cellular signal. Simply connect a 3G USB adapter to access the Internet (third party EV-DO subscription and available signal required).", //usb_3g_help
	"If you have trouble accessing the Internet through the router. Double check the settings you entered on this page and verify with your Internet Service Provider (ISP) if needed.", //usb_3g_help_support_help
	"Select to configure your wireless network using Windows Connect Now (WCN). WCN allows you to copy your wireless settings from the router to a USB flash drive and use to automatically configure the wireless settings on your computer(s) or other WCN-compatible devices.", //usb_wcn_help
	"My plug of USB type is", //bwn_mici_usb
	"Please set Network USB Detection interval time, the router will automatically detect the USB device.", //_info_netowrk
	"Enable Multicast Streams", //anet_multicast_enable
	"Network USB Detection interval", //bwn_usb_time
	"sec (range:3-600 sec.)", //bwn_bytes_usb
	"Can't choose shared key when WPS is enable!!", //_wps_albert_1
	"Can't choos WPA-Enterprisey when WPS is enable!!", //_wps_albert_2
	"Please configure your Internet Connection Type settings.  If you are unsure of the settings, please contact your Internet Service Provider (ISP).", //usb_config2
	"Please choose a device to apply the policy.", //ac_alert_choose_dev
	"The Internet Connection Type is not for 3G Internet connection. Please select WWAN to support 3G Internet connection.", //usb_config3
	"The Internet Connection Type is for 3G Internet connection, please select another Internet Connection Type.", //usb_config4
	"The Internet Connection Type you selected is for 3G Internet connection.  The USB settings will be changed from Network USB/WCN to 3G USB Adapter.", //usb_config5
	"The Internet Connection Type you selected is not for 3G Internet connection. The USB settings will be changed from 3G USB Adapter to Network USB.", //usb_config6
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
	"Personals", //_aa_bsecure_personals
	"South Africa", //country_9
	"HongKong", //country_10
	"Taiwan", //country_11
	"Egypt", //country_12
	"Dominican Republic", //country_13
	"El Salvador", //country_14
	"Brasil", //country_15
	"Select this option if you want to add a guest network", //S500
	"Network Type", //S496
	"Enable HTTP Storage Remote Access", //sto_http_2
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
	"Off", //_off
	"2.4GHz Band", //GW_WLAN_RADIO_0_NAME
	"%s PPPoE session protocol fault. Connection attempt failed.", //GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
	"PPPoE session name %s conflicts with other session name", //GW_WAN_PPPOE_SESSION_NAME_CONFLICT
	"Problem in receiving logs! Memory is too low to display logs or there is a problem with the connection.", //S525
	"Password and Verify Password do not match. Please reconfirm user password.", //YM174
	"You should examine these warnings, because some features may have been disabled or modified.", //KR136
	"Terminating %s PPPoE session ID %u", //GW_PPPOE_EVENT_DISCONNECT
	"Endpoint Independent", //af_EFT_0
	"Use this section to enable routing between Host Zone and Guest Zone, Guest clients can not access Host clients' data without enable the function.", //LY34
	"%sWireless shut down", //GW_WIRELESS_SHUT_DOWN
	"%sWireless restart", //GW_WIRELESS_RESTART
	"The administration idle time should be in the range of 1 to 65535.", //S528
	"Port forwarding ALG failed to allocate session for TCP packet from %v:%u to %v:%u", //GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE
	"Use this section to configure the guest zone settings of your router. The guest zone provide a separate network zone for guest to access Internet.", //guestzone_Intro_1
	"Virtual server '%s' can not use the router's HTTPS WAN administration port, %u", //GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
	"Enable Remote Management", //ta_ERM
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
	"%s' [protocol:%u]->%v conflicts with '%s' [protocol:%u]->%v.", //GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID
	"Specifies whether the Guest Zone will be enabled or disabled.", //LY28
	"Trying to establish %s PPPoE connection", //GW_PPPOE_EVENT_CONNECT
	"Trigger Port", //GW_NAT_TRIGGER_PORT
	"operate mode", //tc_opmode
	"Automatically assign a network key for both 2.4GHz and 5GHz band (Recommended)", //wwz_auto_assign_key3
	"Provide a name for Guest Zone wireless network.", //LY292
	"Securing your wireless network is important as it is used to protect the integrity of the information being transmitted over your wireless network. The router is capable of 4 types of wireless security; WEP, WPA only, WPA2 only, and WPA/WPA2 (auto-detect).", //LY293
	"If you choose the WEP security option this device will <strong>ONLY</strong> operate in <strong>Legacy Wireless mode (802.11B/G)</strong>. This means you will <strong>NOT</strong> get 11N performance due to the fact that WEP is not supported by the Draft 11N specification.", //bws_msg_WEP_4
	"The route for %v on interface %s may not be created - only routes via gateways may be created on this interface", //GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID
	"DNS settings", //wwa_dnsset
	"This wizard is designed to assist you in connecting your guest wireless device to your wireless router. It will guide you through step-by-step instructions on how to get your guest wireless device connected. Click the button below to begin.", //wireless_gu
	"Add Guest Wireless with WPS", //add_gu_wps
	"Wireless Band", //wwl_band
	"Band", //_band
	"Manually set 5GHz band Network Name", //wwa_5G_nname
	"GUEST ZONE", //_guestzone
	"Guest Zone Selection", //guestzone_title_1
	"Enable Graphical Authentication", //_graph_auth
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
	"Enable or disable defined rules with the checkboxes at the left.", //help75a
	"This is the network to which the SSID belongs; SSID clients that belong to the same network can transmit data over this subnet.", //dlink_help157
	"WAN Ping Inbound Filter", //wpin_filter
	"Select a filter that controls which WAN computers can use the ping feature. If you do not see the filter you need in the list of filters, go to the  Advanced → Inbound Filter screen and create a new filter.", //dlink_help151
	"The raw TCP port printing protocol uses a fixed IP address and TCP port to communicate with your printer.", //tps_raw1
	"(GMT+06:30) Rangoon", //up_tz_52
	"Destination IP address are same", //_r_alert_new1
	"Email Settings", //te_EmSt
	"Notice of Wireless Intrusion", //mydlink_T06
	"Blocked outgoing packet from %v to %v (IP protocol %u)", //IPNAT_BLOCKED_EGRESS
	"Wireless Security Mode", //bws_WSMode
	"Pinging public WAN IP addresses is a common method used by hackers to test whether your WAN IP address is valid.", //anet_wan_ping_1
	"Give the rule a name that is meaningful to you, for example <code>Game Server</code>. You can also select from a list of popular games, and many of the remaining configuration values will be filled in accordingly. However, you should check whether the port values have changed since this list was created, and you must fill in the IP address field.", //help65
	"UPnP", //ta_upnp
	"Transmission Rate", //bwl_TxR
	"WAN interface speed measurement completed", //GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED
	"Average ping time (in milliseconds)", //tsc_pingt_msg106
	"All Day", //tsc_AllDay
	"Tiger Woods 2K4", //gw_gm_53
	"WAN interface speed measurements not started as low on resources", //GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR
	"Lost lease on IP Address", //DHCP_CLIENT_LOST_LEASE
	"Choose a schedule to apply to this policy.", //_aa_wiz_s3_msg
	"Authentication Timeout", //bwsAT_
	"Good timekeeping is important for accurate logs and scheduled firewall rules.", //hhtt_intro
	"Final Fantasy XI (PC)", //gw_gm_20
	"The IP address of the authentication server.", //help388
	"Set the Date and Time Manually", //tt_StDT
	"Offline", //psOffline
	"Status", //_status
	"Otherwise press 'Cancel'.", //up_ae_wic_3
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
	"Packets received by the DMZ host have their IP addresses translated from the WAN-side IP address of the router to the LAN-side IP address of the DMZ host. However, port numbers are not translated; so applications on the DMZ host can depend on specific port numbers.", //haf_dmz_30
	"Informational", //sl_Infrml
	"Wireless", //_wireless
	"RADIUS server IP Address", //bws_RIPA
	"Enabling this option can provide protection from certain kinds of \"spoofing\" attacks. However, enble this option with care. With some modems, the WAN connection may be lost when this option is enabled. In that case, it may be necessary to change the LAN subnet to something other than 192.168.0.x (192.168.2.x, for example), to re-establish the WAN connection.", //KR108
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
	"The network connection seems to be down. Press\"Ok\" to try again.", //li_alert_2
	"When Access Control is disabled, every device on the LAN has unrestricted access to the Internet. However, if you enable Access Control, Internet access is restricted for those devices that have an Access Control Policy configured for them. All other devices have unrestricted access to the Internet.", //help120
	"IGMP host has rejected group %v due to low system resources", //IGMP_HOST_LOW_RESOURCES
	"- Exactly 10 or 26 characters using 0-9 and A-F", //wwl_s4_intro_z3
	"Enable this option for better performance and experience with online games and other interactive applications, such as VoIP.", //help78
	"Windows 2000", //help339
	"Enable IPv6 Simple Security ", //IPv6_Simple_Security_enable
	"Enter the port range that you want to open up to Internet traffic (for example <code>6000-6200</code>).", //help51
	"THE ADDRESSING OF THE INTERNET SIDE LEARNT THRU PPPoE CONFLICTS WITH THE ADDRESSING SELECTED FOR THE LAN SIDE. INTERNET COMMUNICATIONS WILL BE DISABLED UNTIL YOU HAVE CHANGED THE LAN SIDE ADDRESSING TO RESOLVE THE PROBLEM", //GW_WAN_LAN_ADDRESS_CONFLICT_PPP
	"Errors", //ss_Errors
	"If a dynamic DNS update fails for any reason (for example, when incorrect parameters are entered), the router automatically disables the Dynamic DNS feature and records the failure in the log.", //help899
	"Please enter the graphical authentication code.", //li_alert_4
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
	"TIME", //_time
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
	"Press \"Ok \" to abandon these changes and display the Schedule page.", //aa_sched_conf_2
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
	"No printer detected", //wprn_nopr
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
	"Ping Result", //tsc_pingr
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
	"Enter the correct password above and<br>then type the characters you see in the<br>picture below.", //_authword
	"Blocked outgoing TCP packet from %v:%u to %v:%u as %s received but there is no active connection", //IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN
	"Gateway Name", //ta_GWN
	"If you are not authorized to modify the router's configuration, contact the router administrator.", //wprn_tt3
	"MTU", //help293
	"If your ISP has assigned a fixed IP address, select this option. The ISP provides the value for the", //help265_2
	"Dropped packet from %v to %v (IP protocol %u) as unable to create new session", //IPNAT_UNABLE_TO_CREATE_CONNECTION
	"Always on", //help270
	"Advanced Wireless Settings", //aw_title_2
	"Firewall Settings", //_firewalls
	"Enabled/Not Configured", //LW67
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
	"FIRMWARE and LANGUAGE PACK INFORMATION", //tf_FWInf
	"Up to eight ranges of WAN IP addresses can be controlled by each rule. The checkbox by each IP range can be used to disable ranges already defined.", //hhai_ipr
	"It is recommended that you leave these parameters at their default values. Adjusting them could limit the performance of your wireless network.", //hhaw_1
	"Allows multiple VPN clients to connect to their corporate networks using IPSec. Some VPN clients support traversal of IPSec through NAT. This option may interfere with the operation of such VPN clients. If you are having trouble connecting with your corporate network, try disabling this option.", //help34
	"Enable Network USB Auto-Detection", //_network_usb_auto
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
	"OFDM", //help636
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
	"MAC Address Authentication", //help393
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
	"Pre-Shared Key", //help381
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
	"Obtain IPv6 DNS server address automatically", //IPV6_TEXT65_v6
	"Gateway Logs", //GW_EMAIL_SUBJ
	"Port trigger ALG failed to allocate session for UDP packet from %v:%u to %v:%u", //IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE
	"If you are new to networking and have never configured a router before, click on <span class=\"button_ref\">Setup Wizard</span> and the router will guide you through a few simple steps to get your network up and running.", //bi_wiz
	"Out", //_Out
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
	"Enable at least one Source IP Range for %s", //ai_alert_5
	"Select this option if you want to synchronize the router's clock to a Network Time Server over the Internet. If you are using schedules or logs, this is the best way to ensure that the schedules and logs are kept accurate.", //help848
	"Return to Castle Wolfenstein", //gw_gm_41
	"Policy Wizard", //_aa_pol_wiz
	"IP Filters", //IP_FILTERS
	"Starsiege Tribes", //gw_gm_50
	"Your Internet Connection could not be detected, please select your Internet Service Provider (ISP) from the list below. If your ISP is not listed; select the\"Not Listed or Don't Know\" option to manually configure your connection.", //wwa_intro_s3
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
	"Out", //EGRESS
	"The following <span id='status_text'>printer is</span> attached to your router.", //sps_fp
	"Unreal Tournament 2004", //gw_gm_57
	"Choose this if your Internet connection automatically provides you with an IP Address. Most Cable Modems use this type of connection.", //wwa_msg_dhcp
	"Step 1 - Choose a unique name for your policy", //aa_wiz_s1_msg1
	"You must be logged in as \"admin\" to perform this action", //MUST_BE_LOGGED_IN_AS_ADMIN
	"(GMT+09:30) Darwin", //up_tz_64
	"gw_wireless_schedule stop", //GW_WLS_SCHEDULE_STOP
	"Wake-on-LAN ALG rejected packet from %v:%u to %v:%u", //IPWOLALG_REJECTED_PACKET
	"Update device to wsetting.wfc", //WCN_LOG_UPDATE
	"This option should be enabled when you have a slow Internet uplink. It helps to reduce the impact that large low priority network packets can have on more urgent ones by breaking the large packets into several smaller packets.", //help80
	"Here you can add entries to the Inbound Filter Rules List below, or edit existing entries.", //help171
	"Mon", //_Mon
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"Step 2: Set your Wireless Security Password", //wwl_title_s4_2
	"If you don't use the All Day option, then you enter the time here. The start time is entered in two fields. The first box is for the hour and the second box is for the minute. Email events are normally triggered only by the start time.", //help196
	"PPPoE session offer had errors. Connection attempt failed.", //PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
	"Log In", //li_Log_In
	"Non-UDP/TCP/ICMP LAN Sessions", //af_gss
	"Default Gateway", //_defgw
	"NTP Server is not configured.", //YM185
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
	"Enable Management", //ta_ELM
	"Enable HTTPS Storage Remote Access", //sto_http_4
	"Enable IPv4 Multicast Streams", //anet_multicast_enable_v4
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
	"Enable", //_enable
	"On demand", //help272
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
	"Enter a name for the Special Application Rule, for example <code>Game App</code>, which will help you identify the rule in the future. Alternatively, you can select from the <span class=\"option\">Application</span> list of common applications.", //help48
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
	"Place a checkmark in the boxes for the desired days or select the All Week radio button to select all seven days of the week.", //help194
	"Are you sure you want to reset the device to its factory default settings?", //up_rb_4
	"Newer Firmware Version %d.%d for your %s %s router is now available at", //NEWER_FW_VERSION
	"PPTP Internet Connection Type", //bwn_PPTPICT
	"Firmware upgrade image successfully uploaded - installing", //GW_UPGRADE_SUCCEEDED
	"(Also called the SSID)", //bwl_AS
	"The rule applies to a flow of messages whose WAN-side port number is within the range set here.", //help96
	"Wireless Channel", //_wchannel
	"Manually assign a network key", //wwz_manual_key
	"Please press the button below to continue configuring the router.", //ap_intro_cont
	"Enable Logging To Syslog Server", //tsl_EnLog
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
	"Ping checks whether a computer on the Internet is running and responding.", //hhtsc_pingt_intro
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
	"Enable DHCP-PD", //DHCP_PD_ENABLE
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
	"Both of these options select some variant of Wi-Fi Protected Access (WPA) -- security standards published by the Wi-Fi Alliance. The <span class ='option'>WPA Mode</span> further refines the variant that the router should employ.", //help373
	"Daylight Saving Offset", //tt_dsoffs
	"Automatically assign a network key (Recommended)", //wwz_auto_assign_key
	"Doom 3", //gw_gm_15
	"For information on which security features your wireless adapters support, please refer to the adapters' documentation.", //wwl_s3_note_1
	"Click <strong>Save</strong> to add a completed schedule to the list below.", //hhts_save
	"Auto-detect", //at_Auto
	"Pings sent:", //tsc_pingt_msg100
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
	"Maximum Idle Time", //help276
	"to", //_to
	"IP", //aa_AT_0
	"Create a list of Web Sites to which you would like to deny or allow through the network.", //dlink_hhwf_intro
	"Dec", //tt_Dec
	"Click the <span class=\"button_ref\">Browse</span> button to locate the D-Link upgrade file on your computer.", //help879
	"Policy %s started; Internet access for all non-specified systems changed to: %s", //GW_INET_ACCESS_POLICY_START_OTHERS
	"(GMT+12:00) Magadan", //up_tz_75
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
	"Enable BigPond:", //help262
	"Allow", //_allow
	"Select the level of events that you want to view.", //help798
	"Obtained IP Address using DHCP. IP address is %v", //DHCP_CLIENT_GOT_LEASE
	"WAN Port Speed", //anet_wan_phyrate
	"Note", //_note
	"Dest<br />Port<br />Start", //aa_FPR_c6
	"UDP Ports To Open", //help69
	"DHCP Lease Time", //bd_DLT
	"Welcome to the D-Link Internet Connection Setup Wizard", //wwa_title_wel
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
	"Pings lost", //tsc_pingt_msg102
	"RADIUS server Port", //bws_RSP
	"Trying to establish a PPPoE connection", //PPPOE_EVENT_CONNECT
	"Automatic Time Configuration", //tt_auto
	"The PPTP subsystem is low on resources. Connectivity may be affected.", //PPTP_EVENT_LOW_RESOURCES_TO_QUEUE
	"L2TP local tunnel 0x%04X received unexpected control message (ignored)", //IPL2TP_TUNNEL_UNEXPECTED_MESSAGE
	"Neverwinter Nights", //gw_gm_34
	"5th", //tt_week_5
	"Below is a detailed summary of your wireless security settings. Please print this page out, or write the information on a piece of paper, so you can configure the correct settings on your wireless client adapters.", //wwl_intro_end
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
	"Host Name", //help260
	"FIN Wait -- The client system has requested that the connection be stopped.", //help819_4
	"If all of the wireless devices you want to connect with this router can connect in the same transmission mode, you can improve performance slightly by choosing the appropriate \"Only\" mode. If you have some devices that use a different transmission mode, choose the appropriate \"Mixed\" mode.", //help357
	"TCP", //_TCP
	"MSCHAP authentication challenge received from peer.", //IPMSCHAP_CHALLENGE_RECVD
	"Universal Plug and Play (UPnP) supports peer-to-peer Plug and Play functionality for network devices.", //anet_msg_upnp
	"Clicking the <span class=\"button_ref\">DHCP Release</span> button unassigns the router's IP address. The router will not respond to IP messages from the WAN side until you click the <span class=\"button_ref\">DHCP Renew</span> button or power-up the router again. Clicking the <span class=\"button_ref\">DHCP Renew</span> button causes the router to request a new IP address from the ISP's server.", //help776
	"Please Select Configuration Method to set up your Wireless Network", //KR49
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
	"Enabling WLAN Partition prevents associated wireless clients from communicating with each other.", //KR58_ww
	"optional", //YM98
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
	"password must be specified", //GW_DYNDNS_PASSWORD_INVALID
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
	"Manual", //help274
	"Using a short (400ns) guard interval can increase throughput. However, it can also increase error rate in some installations, due to increased sensitivity to radio-frequency reflections.", //aw_sgi_h1
	"Blocked source-routed packet from %v to %v", //IPSTACK_REJECTED_SOURCE_ROUTED_PACKET
	"Primary DNS Address", //wwa_pdns
	"Use this option to restore previously saved router configuration settings.", //help834
	"Sun", //_Sun
	"Number of Devices", //sto_no_dev
	"To prevent outsiders from accessing your network, the router will automatically assign a security (also called WEP or WPA key) to your network.", //wwz_auto_assign_key2
	"Number of Spatial Streams", //bwl_NSS
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"Once you have found the file to be used, click the <span class=\"button_ref\">Upload</span> button below to start the firmware upgrade process. This can take a minute or more.", //help880
	"Trying to connect to L2TP server", //IPL2TP_TUNNEL_CONNECTING
	"Enable SharePort For Guest Zone", //bwn_mici_guest_use_shareport
	"Time synchronized", //NET_RTC_SYNCHRONIZED
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"On", //_on
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
	"To input the MAC address of your system, enter it in manually or connect to the D-Link router's Web-Management interface from the system and click the <span class='button_ref'>Copy Your PC's MAC Address</span> button.", //help333
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
	"Ping Test sends \"ping\" packets to test a computer on the Internet.", //tsc_pingt_mesg
	"(GMT+04:30) Kabul", //up_tz_44
	"You might have trouble accessing a virtual server using its public identity (WAN-side IP-address of the gateway or its dynamic DNS name) from a machine on the LAN. Your requests may not be looped back or you may be redirected to the \"Forbidden\" page.", //help27
	"IPSec (VPN)", //as_IPSec
	"Admin", //_admin
	"eDonkey", //gw_gm_65
	"To upgrade the firmware, locate the upgrade file on the local hard drive with the Browse button.Once you have found the file to be used, click the Upload button below to start the firmware upgrade.", //tf_intro_FWChB
	"Blocked", //BLOCKED
	"BigPond Cable (Australia)", //wwa_msg_bigpond
	"Enable Logging To Syslog Server", //help857
	"Close Wait -- the server system has requested that the connection be stopped.", //help819_5
	"Low", //aw_TP_2
	"Authentication Timeout", //help385
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
	"Check Online Now for Latest Firmware and Language pack Version", //tf_COLF
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
	"Enabling Remote Management allows you to manage the router from anywhere on the Internet. Disabling Remote Management allows you to manage the router only from computers on your LAN.", //help828
	"Unable to find DNS record for SMTP (Email) server %s", //GW_SMTP_EMAIL_FAILED_DNS
	"The number of packets that were dropped due to Ethernet collisions (two or more devices attempting to use an Ethernet circuit at the same time).", //help810
	"Wake-On-LAN", //_WOL
	"On demand", //bwn_RM_1
	"None -- This entry is used as a placeholder for a future connection that may occur.", //help819_1
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no TCP connection active between %v:%u and %v:%u", //IPNAT_TCP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"(GMT-04:00) Atlantic Time (Canada)", //up_tz_14
	"Star Trek: Elite Force II", //gw_gm_51
	"Server Address", //td_SvAd
	"You can enter ports in various formats:", //hhag_40
	"Inbound Filters can be used for limiting access to a server on your network to a system or group of systems. Filter rules can be used with Virtual Server, Gaming, or Remote Administration features. Each filter can be used for several functions; for example a \"Game Clan\" filter might allow all of the members of a particular gaming group to play several different games for which gaming entries have been created. At the same time an \"Admin\" filter might only allows systems from your office network to access the WAN admin pages and an FTP server you use at home. If you add an IP address to a filter, the change is effected in all of the places where the filter is used.", //help169
	"The amount of time that a computer may have an IP address before it is required to renew the lease. The lease functions just as a lease on an apartment would. The initial lease designates the amount of time before the lease expires. If the tenant wishes to retain the address when the lease is expired then a new lease is established. If the lease expires and the address is no longer needed than another tenant may use the address.", //help324
	"Ping is an Internet utility function that sends a series of short messages to a target computer and reports the results. You can use it to test whether a computer is running, and to get an idea of the quality of the connection to that computer, based on the speed of the responses.", //htsc_intro
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
	"Enter a password for the user \"admin\", who will have full access to the Web-based management interface.", //help824
	"Computers that have obtained an IP address from the router's DHCP server will be in the DHCP Client List. Select a device from the drop down menu, then click the arrow to add that device's MAC address to the list.", //hham_add
	"WAN Statistics", //ss_WANStats
	"Attempting to start WAN connection on-demand", //GW_WAN_CONNECT_ON_ACTIVE
	"You must abandon all your changes in order to define a new schedule.", //aa_sched_conf_1
	"Policy %s stopped; Internet access for all non-specified systems changed to: %s", //GW_INET_ACCESS_POLICY_END_OTHERS
	"DHCP Reservations List", //bd_title_list
	"Web Access Logging", //_aa_logging
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no session active for protocol %u between %v and %v", //IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"User Name", //_username
	"eMule", //gw_gm_67
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
	"The router must be rebooted before settings saved on a previous page will take effect. You can reboot the router now using the \"Reboot\" button below, or press the \"Continue\" button and make other changes.", //sc_intro_rb3
	"TCP Ports To Open", //help67
	"Quake 2", //gw_gm_37
	"Others", //aa_AT_2
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
	"Once you have a firmware update on your computer, use this option to browse for the file and then upload the information into the router.", //help888
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
	"A MAC address is usually located on a sticker on the bottom of a network device. The MAC address is comprised of twelve digits. Each pair of hexadecimal digits are usually separated by dashes or colons such as 00-0D-88-11-22-33 or 000D88112233. If your network device is a computer and the network card is already located inside the computer, you can connect to the D-Link router from the computer and click the <span class='button_ref'>Copy Your PC's MAC Address</span> button to enter the MAC address.", //help334
	"Battlefield 2", //gw_gm_84
	"L2TP local tunnel 0x%04X RTE module is low on resources.", //IPL2TP_LOW_RESOURCES
	"Click <strong>Add Policy</strong> to start the processes of creating a rule. You can cancel the process at any time. When you are finished creating a rule it will be added to the <strong>Policy Table</strong> below.", //hhac_add
	"Auto 10/100Mbps", //anet_wp_auto2
	"RTSP", //as_RTSP
	"Authentication &amp; Security", //_authsecmodel
	"MTU", //bwn_MTU
	"Steam", //gw_gm_72
	"WAN", //_WAN
	"Enhanced IGMP Proxy", //anet_multicast_enhanced
	"Command and Conquer Generals", //gw_gm_8
	"WPA", //_WPA
	"Re-type the password or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields.", //help897
	"Blocked incoming TCP packet from %v:%u to %v:%u with unexpected sequence %lu (expected %lu to %lu)", //IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ
	"Response from", //tsc_pingt_msg7
	"Jan", //tt_Jan
	"Battlefield: Vietnam", //gw_gm_5
	"Advanced Wireless", //_adwwls
	"Pings received:", //tsc_pingt_msg101
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
	"Enable SharePort Web Access", //sto_http_1
	"The Printer Setup Wizard requires the raw TCP port printing protocol. This protocol is currently disabled on your router.", //wprn_foo1
	"A wireless network uses specific channels in the wireless spectrum to handle communication between clients. Some channels in your area may have interference from other electronic devices. Choose the clearest channel to help optimize the performance and coverage of your wireless network.", //help355
	"Logged", //aa_ACR_c6
	"Second RADIUS server Shared Secret", //bws_2RSSS
	"RADIUS Server Shared Secret:", //help391
	"PM", //_PM
	"Define the ranges of Internet addresses this rule applies to. For a single IP address, enter the same address in both the <span class=\"option\">Start</span> and <span class=\"option\">End</span> boxes. Up to eight ranges can be entered. The <span class=\"option\">Enable</span> checkbox allows you to turn on or off specific entries in the list of ranges.", //help174
	"PPPoE timed out waiting for connection. Connection attempt failed.", //PPPOE_EVENT_DISCOVERY_TIMEOUT
	"Device %s, wsetting.wfc: file not found", //WCN_LOG_NO_WSETTING
	"Paper Error", //psPaperError
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
	"Ping", //_ping
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
	"Use this section to configure your Internet Connection type. There are several connection types to choose from Static IP, DHCP, PPPoE, PPTP, L2TP. If you are unsure of your connection method, please contact your Internet Service Provider.", //bwn_intro_ICS
	"Use this section to configure your Internet Connection type. There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP, and 3G USB. If you are unsure of your connection method, please contact your Internet Service Provider.", //bwn_intro_ICS_3G
	"Use this section to configure your Internet Connection type. There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP, and DS-Lite. If you are unsure of your connection method, please contact your Internet Service Provider.", //bwn_intro_ICS_v6
	"When enabled, this option causes the router to automatically measure the useful uplink bandwidth each time the WAN interface is re-established (after a reboot, for example).", //help81
	"This option allows you to save the router's configuration to a file on your computer. Be sure to save the configuration before performing a firmware upgrade.", //help833
	"Your D-Link Router includes an integrated print server that allows a printer to be shared between multiple computers on your network. From this page you can select which printing protocols to enable.", //tps_intro3
	"Sent", //ss_Sent
	"Group Key Update Interval:", //help378
	"Tribes of Vengeance", //gw_gm_80
	"Upload Succeeded", //_uploadgood
	"PIN", //KR38
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
	"Passphrase", //IPV6_TEXT24
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
	"Ping Test", //tsc_pingt
	"View Levels", //sl_VLevs
	"Encryption", //wwl_enc
	"A MAC address is a unique ID assigned by the manufacturer of the network adapter.", //help151
	"Choose a port to open for remote management.", //hhta_pt
	"Internet access control dropped packet from %v to %v (protocol %u)", //GW_INET_ACCESS_DROP_ACCESS_CONTROL
	"Enable Authentication", //te_EnAuth
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
	"Enable QoS Engine", //at_ESE
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
	"Employment", //_aa_bsecure_employment
	"Internet access control dropped bad packet from %v to %v (protocol %u)", //GW_INET_ACCESS_DROP_BAD_PKT
	"Dark Reign 2", //gw_gm_12
	"Hexen II", //gw_gm_25
	"Select the starting and ending times for the change to and from daylight saving time. For example, suppose for DST Start you select Month=\"Oct\", Week=\"3rd\", Day=\"Sun\" and Time=\"2am\". This is the same as saying: \"Daylight saving starts on the third Sunday of October at 2:00 AM.\"", //help846
	"Please select one of Automatic or Manual Time setting. Not both", //tt_alert_1only
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
	"PIN(2nd half) Mismatch Detected", //KR30
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
	"Permission", //sto_permi
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
	"Multiple connections are required by some applications, such as internet games, video conferencing, Internet telephony, and others. These applications have difficulties working through NAT (Network Address Translation). This section is used to open multiple ports or a range of ports in your router and redirect data through those ports to a single PC on your network. You can enter ports in various formats", //help57
	"Enable Daylight Saving", //tt_dsen2
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
	"Email Log When Full or on Schedule", //te__title_EmLog
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
	"Enable ULA", //IPV6_ULA_TEXT02
	"Enable DMZ", //af_ED
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
	"Enabling L2 (Layer 2) Isolation prevents associated wireless clients from communicating with each other.", //KR58
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
	"Enable DNS Relay", //bln_EnDNSRelay
	"Inbound Filter Rule", //ai_title_IFR
	"PPTP", //_PPTP
	"Both", //_both
	"(GMT+03:00) Nairobi", //up_tz_40
	"Unplug and reinsert the printer's USB cable.", //wprn_tt8
	"Disable Soft Reset", //tps_dsr
	"Other", //at_Prot_1
	"This restarts the router. Useful for restarting when you are not near the device.", //help875
	"Website Filter Parameters", //awsf_p
	"- Exactly 5 or 13 characters", //wwl_s4_intro_z2
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need L2TP IP adress. If you do not have this information, please contact your ISP.", //wwa_set_l2tp_msg
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"Error", //_error
	"Dest IP<br />End", //aa_FPR_c4
	"Enable NTP Server", //tt_EnNTP
	"Invalid LAN IP Address, ip address in DHCP Server range", //network_dhcp_ip_in_server
	"To upgrade the firmware, your PC must have a wired connection to the router. Enter the name of the firmware upgrade file, and click on the Upload button.", //tf_msg_wired
	"Set Username and Password Connection (PPPoE)", //wwa_title_set_pppoe
	"Ensure the schedule is set to <code>Always</code>", //help10
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
	"(GMT+06:00) Almaty", //up_tz_49
	"World of Warcraft", //gw_gm_62
	"BigPond logged out", //BIGPOND_LOGGED_OUT
	"Email Notification of Newer Firmware Version", //tf_EmNew
	"Internet access policy for MAC address %m cannot be set", //GW_INET_ACCESS_INITIAL_MAC_FAIL
	"MAC Address", //help303
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
	"The 'admin' account can access the management interface. The admin has read/write access and can change passwords.", //ta_intro1
	"3rd", //tt_week_3
	"DHCP Server", //_dhcpsrv
	"Dynamic PPPoE", //Dynamic_PPPoE
	"Enable:", //help102
	"WINS/NetBIOS may not operate in this mode given your Internet connection settings.", //GW_DHCP_SERVER_WINS_MODE_INVALID
	"One bits in the mask specify which bits of the IP address must match.", //help107
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
	"When you set <span class='option'>Enable DHCP Server</span>, the following options are displayed.", //help318
	"The SysLog options allow you to send log information to a SysLog Server.", //tsl_intro
	"03:00 AM", //tt_time_4
	"08:00 PM", //tt_time_21
	"L2TP local session 0x%04X connected", //IPL2TP_SESSION_CONNECTED
	"Fragmentation Threshold", //aw_FT
	"Save", //_save
	"Not Estimated", //at_NEst
	"Once a LAN-side application has created a connection through a specific port, the NAT will forward any incoming connection requests with the same port to the LAN-side application regardless of their origin. This is the least restrictive option, giving the best connectivity and allowing some applications (P2P applications in particular) to behave almost as if they are directly connected to the Internet.", //af_EFT_h0
	"FIRMWARE", //_firmware
	"Rogue Spear", //gw_gm_43
	"Please start WPS on the wireless device you are adding to your wireless network winth", //wps_messgae1_1
	"L2TP local tunnel 0x%04X RTE module is shutting down.", //IPL2TP_SHUTDOWN_STARTED
	"TX Packets Dropped", //ss_TXPD
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"Click Next if you still want to secure the router with a password and set the time zone.", //wwa_intro_online2
	"Select the outbound protocol used by your application (for example <code>Both</code>).", //help50
	"Enter the UDP ports to open (for example <code>6159-6180, 99</code>).", //help70
	"Enabling WMM can help control latency and jitter when transmitting multimedia content over a wireless connection.", //help188_wmm
	"DHCP Reservation", //bd_title_SDC
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"Ultima", //gw_gm_54
	"Optional backup RADIUS server", //help396
	"Administrator logout", //GW_ADMIN_LOGOUT
	"Serious Sam II", //gw_gm_44
	"Enable UPnP", //ta_EUPNP
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
	"Enable automatic IPv6 address assignment", //IPV6_TEXT105
	"Port", //sps_port
	"Whether SPI is enabled or not, the router always tracks TCP connection states and ensures that each TCP packet's flags are valid for the current state.", //help164_2
	"Wait for the router to reboot. This can take another minute or more.", //help881
	"Destination IP", //_destip
	"The Time Configuration option allows you to configure, update, and maintain the correct time on the router's internal system clock. From this section you can set the time zone that you are in and set the Time Server. Daylight saving can also be configured to automatically adjust the time when needed.", //help840
	"L2TP Server IP Address (may be same as gateway)", //wwa_l2tp_svra
	"Daylight Saving Dates", //tt_dsdates
	"Note that L2TP VPN connections typically use IPSec to secure the connection. To achieve multiple VPN pass-through in this case, the IPSec ALG must be enabled.", //help34b
	"10:00 AM", //tt_time_11
	"Enable Dynamic DNS", //td_EnDDNS
	"The actual transmission rate of the client in megabits per second.", //help786
	"Username", //bwn_UN
	"This Policy Name is already used.", //aa_alert_8
	"Enable raw TCP port printing from the <em>Print Server </em> page under the <em>Tools</em> submenu.", //wprn_tt2
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
	"Please plug one end of the included Ethernet cable that came with your router into the port labeled INTERNET on the back of the router. Plug the other end of this cable into the Ethernet port on your modem.", //ES_cable_lost_desc
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
	"Enter a MAC address for each of the other APs that you want to connect with WDS.", //help189a
	"Trigger", //_trigger
	"The Ethernet ID (MAC address) of the wireless client.", //help783
	"The Gateway will not be reprogrammed.", //ub_intro_2
	"For security reasons, it is recommended that you change the password for the Admin account. Be sure to write down the new and passwords to avoid having to reset the router in case they are forgotten.", //hhta_pw
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
	"Configure Website Filter below", //dlink_wf_intro
	"Website Filter", //_websfilter
	"BigPond Server Name", //sd_BPSN
	"User Password", //_password_user
	"Policy %s stopped; Internet access for IP address %v changed to: %s", //GW_INET_ACCESS_POLICY_END_IP
	"Choose the mode to be used by the router to connect to the Internet.", //bwn_msg_Modes
	"The IP address ' + mf.dmz_address.value + ' is not valid.", //up_gX_1
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
	"(GMT+11:00) Solomon Is., New Caledonia", //up_tz_70
	"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no ICMP session active between %v and %v", //IPNAT_ICMP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
	"Schedule", //GW_SCHEDULES_IN_USE_INVALID_s1
	"This page is not included in the router's Allowed Web Site List.", //fb_p_2
	"Printer Status", //sps_ps
	"You need to configure your router to allow a software application running on any computer on your network to connect to a web-based server or another user on the Internet.", //help47
	"Step 4: Save Settings and Connect", //wwa_title_s4
	"05:00 PM", //tt_time_18
	"When this option is enabled, router activity logs or firmware upgrade notifications can be emailed to a designated email address, and the following parameters are displayed.", //help860
	"UPnP deleted entry %v <-> %v:%d <-> %v%d %s '%s' (client released address)", //GW_UPNP_IGD_PORTMAP_RELEASE
	"The Internet Connection Setup Wizard has completed. Click the save button to save your settings and reboot the router.", //wwa_intro_s4
	"Some ISP's may require that you enter a Service Name. Only enter a Service Name if your ISP requires one.", //help267
	"L2TP local session 0x%04X aborted", //IPL2TP_SESSION_ABORTED
	"This section allows you to manage the router's configuration settings, reboot the router, and restore the router to the factory default settings. Restoring the unit to the factory default settings will erase all settings, including any rules that you've created.", //help874
	"Sep", //tt_Sep
	"Dropped ESP packet from %v to %v as unable handle packet header", //IPSEC_ALG_ESP_UNABLE_TO_HANDLE_HEADER
	"Group Key Update Interval", //bws_GKUI
	"Enables the router to recognize certain audio and video streams generated by a Windows Media Center PC and to prioritize these above other traffic. Such streams are used by systems known as Windows Media Extenders, such as the Xbox 360.", //help80b
	"In these cases, you can use Inbound Filters to limit that exposure by specifying the IP addresses of internet hosts that you trust to access your LAN through the ports that you have opened. You might, for example, only allow access to a game server on your home LAN from the computers of friends whom you have invited to play the games on that server.", //help168c
	"BigPond logging in", //BIGPOND_LOGGING_IN
	"Username / Password Connection (PPTP)", //wwa_wanmode_pptp
	"Range (50-100)", //help58
	"This option will check D-Link's support site to see if you have the latest version of the firmware available. If a newer version is available, download instructions will be displayed.", //help885
	"Connected", //ddns_connected
	"Upload Failed", //ub_Upload_Failed
	"WPS end for STA with MAC (%m) on msg: %s", //WIFISC_AP_PROXY_END_ON_MSG
	"PPTP (Point to Point Tunneling Protocol) uses a virtual private network to connect to your ISP. This method of connection is primarily used in Europe. This method of connection requires you to enter a <span class=\"option\">Username</span> and <span class=\"option\">Password</span> (provided by your Internet Service Provider) to gain access to the Internet.", //help278
	"Enter an 8- to 63-character alphanumeric pass-phrase.", //KR18
	"A System Logger (syslog) is a server that collects in one place the logs from different sources. If the LAN includes a syslog server, you can use this option to send the router's logs to that server.", //hhts_def
	"Used when your ISP provides you a set IP address that does not change. The IP information is manually entered in your IP configuration settings. You must enter the", //help255
	"Second RADIUS server Port", //bws_2RSP
	"Enter the Private Port as [80]", //help7
	"Visible", //bwl_VS_0
	"TCP Endpoint Filtering", //af_TEFT
	"When <span class='option'>Connection Type</span> is set to <span class='option'> Auto-detect</span>, the automatically detected connection type is displayed here.", //help86
	"Network Name (SSID)", //sd_NNSSID
	"Accessing this web page might have an effect on the measurement.", //wt_p_2
	"Gateway", //_gateway
	"Current Router Time", //tt_CurTime
	"AM", //_AM
	"Disconnected", //DISCONNECTED
	"Soldier of Fortune", //gw_gm_47
	"(GMT-01:00) Azores", //up_tz_22
	"WPS Internal Registrar detected session overlap between %m and %m", //WIFISC_IR_REGISTRATION_SESSION_OVERLAP
	"Please make the two admin passwords the same and try again", //_pwsame_admin
	"WAN IP changed to %v, updating to dynamic DNS provider", //GW_DYNDNS_UPDATE_IP
	"A network computer (%s) was assigned the IP address of %v.", //GW_DHCPSERVER_NEW_ASSIGNMENT
	"Windows/MSN Messenger", //as_WM
	"(GMT-09:00) Alaska", //up_tz_03
	"Please enter the PIN of your wireless device, then click on the Connect button below.", //KR43
	"passwords do not match, please re-enter", //YM177
	"Depending on the type of WAN connection, you can take one of the following sets of actions:", //help774
	"Click the <strong>Edit</strong> icon to modify an existing rule using the Policy Wizard.", //hhac_edit
	"(GMT+02:00) Jerusalem", //up_tz_36
	"Host Name", //_hostname
	"Internet access control initialization failed", //GW_INET_ACCESS_INITIAL_FAIL
	"Web filter initialization failed", //GW_WEB_FILTER_INITIAL_FAIL
	"On Log Full", //te_OnFull
	"Step 3: Set your Wireless Security Password", //wwl_title_s4
	"Reconnect Mode:", //help281
	"Gamespy Tunnel", //gw_gm_77
	"Clone Your PC's MAC Address", //_clonemac
	"This is a summary of the number of packets that have passed between the WAN and the LAN since the router was last initialized.", //hhss_intro
	"Measured Uplink Speed", //at_MUS
	"The WAN speed is usually detected automatically. If you are having problems connecting to the WAN, try selecting the speed manually.", //hhan_wans
	"Enable this option if you want to allow WISH to prioritize your traffic.", //YM141
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
	"Enable Anti-ARP Attack", //ip_mac_binding_desc
	"Enabling this option (the default setting) enables single VPN connections to a remote host. (But, for multiple VPN connections, the appropriate VPN ALG must be used.) Disabling this option, however, only disables VPN if the appropriate VPN ALG is also disabled.", //LW50
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
	"Please press down the Push Button (physical or virtual) on the wireless device you are adding to your wireless network within", //wps_messgae1_2
	"Create a random number that is a valid PIN. This becomes the router's PIN. You can then copy this PIN to the user interface of the registrar.", //LW60
	"Restore Failed", //_rs_failed
	"Select this option if the device is connected to a local network downstream from another router. In this mode, the device functions as a bridge between the network on its WAN port and the devices on its LAN port and those connected to it wirelessly.", //KR62
	"The Wireless Device PIN field cannot be blank", //KR20
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
	"Only Administrator can clear the statistics. The Clear Statistics button is disabled as you are not currently logged in as Administrator.", //ss_intro_user
	"The Schedule name '%s' is reserved and can not be used", //GW_SCHEDULES_NAME_RESERVED_INVALID
	"Add Wireless Station", //LW12
	"Windows Media Center", //YM75
	"Route gateway IP %v is invalid", //GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID
	"WPA Group Key Update Interval should be between 30 and 65535 seconds.", //GW_WLAN_WPA_REKEY_TIME_INVALID
	"WEP is the wireless encryption standard. To use it you must enter the same key(s) into the router and the wireless stations. For 64 bit keys you must enter 10 hex digits into each key box. For 128 bit keys you must enter 26 hex digits into each key box. A hex digit is either a number from 0 to 9 or a letter from A to F. For the most secure use of WEP set the authentication type to \"Shared Key\" when WEP is enabled.", //bws_msg_WEP_1
	"Enabling Hidden Mode is another way to secure your network. With this option enabled, no wireless clients will be able to see your wireless network when they scan to see what's available. For your wireless devices to connect to your router, you will need to manually enter the Wireless Network Name on each device.", //YM125
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
	"Enable this option if you want to allow WISH to prioritize wireless traffic.", //YM86
	"Invalid WAN MAC address: %m", //GW_WAN_MAC_ADDRESS_INVALID
	"recepient email address is in wrong format", //IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT
	"WISH supports overlaps between rules. If more than one rule matches for a specific message flow, the rule with the highest priority will be used.", //YM146
	"Configuration Warnings", //LS151
	"Name can not be empty string.", //GW_QOS_RULES_NAME_INVALID
	"%s' [protocol:%d]->%v conflicts with '%s' [protocol:%d]->%v.", //GW_NAT_VS_PROTO_CONFLICT_INVALID
	"Name can not be empty string.", //GW_WISH_RULES_NAME_INVALID
	"Adding wireless station %s failed, reason %s, err_code %u", //WIFISC_IR_REGISTRATION_FAIL
	"ROUTE LIST", //r_rlist
	"Enter a specific DNS server address", //IPV6_TEXT109
	"128 bit (26 hex digits)", //bws_WKL_1
	"Organizes information so that it can be managed updated, as well as easily accessed by users or applications.", //help473
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
	"Operating frequency band. Choose 2.4GHz for visibility to legacy devices and for longer range. Choose 5GHz for least interference; interference can hurt performance.", //KR971
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
	"Personal Area Network", //help643
	"The <span class=\"option\">Router IP Address</span> field below must be set to the IP address of this device. The <span class=\"option\">Gateway</span> must be set to the IP address of the upstream router. Both addresses must be within the LAN subnet as specified by <span class=\"option\">Subnet Mask</span>.", //KR63
	"The following Web-based Setup Wizard is designed to assist you in your printer setup. This Setup Wizard will guide you through step-by-step instructions on how to set up your printer.", //LW31
	"Invalid secondary DNS server IP address: %v", //GW_WAN_DNS_SERVER_SECONDARY_INVALID
	"If you would like to configure the Internet settings of your new D-Link Systems Router manually, then click on the button below.", //LW29
	"Invalid remote end IP Address.", //YM55
	"For information on which configuration method your wireless device support, please refer to the adapters' documentation.", //KR37
	"Check this box to allow the DHCP Server to offer NetBIOS configuration settings to the LAN hosts.", //KR80
	"Invalid WAN subnet mask", //YM100
	"Wake-On-LAN", //_wakeonlan
	"The device may be too busy to properly receive it right now. Please try the restore again. It is also possible that you are logged in as a \"user\" instead of an \"admin\" - only administrators can restore the configuration file. Please check the system log for any errors.", //rs_intro_3
	"PainKiller", //gw_gm_35
	"You will be redirected to the login page in", //YM7
	"If you are not utilizing Super G with Dynamic Turbo for its speed improvements, enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //YM124g
	"MAC address %m already exists.", //GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID
	"invalid destination starting IP Address.", //YM66
	"Optimum Online", //manul_conn_13
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
	"The QoS Engine feature helps improve your network performance by prioritizing the data flows of network applications.", //help76
	"'%s': Host 1 port start, %u, must be less than host 1 port end, %u", //GW_WISH_RULES_HOST1_PORT
	"For 11g Turbo mode, the channel should be set to 6.", //GW_WLAN_11G_TURBO_INVALID
	"Entertainment", //_aa_bsecure_entertainment
	"Inactive", //YM165
	"Enter a name for the rule that is meaningful to you.", //help172
	"Lifestyles", //_aa_bsecure_lifestyles
	"DMZ address should be within LAN subnet(%v).", //GW_NAT_DMZ_NOT_IN_SUBNET_INVALID
	"Turbo Mode", //sd_TMode
	"%s port range '%s' of '%s' is invalid.", //GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID
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
	"Oops!", //OOPS
	"WISH Sessions", //YM158
	"Send/Receive instance failure", //ZM16
	"Select Age Category", //_aa_bsecure_select_age
	"Route destination IP %v is invalid", //GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID
	"Reset by %s complete", //WIFISC_AP_RESET_COMPLETE
	"NetBIOS Registration mode", //bd_NETBIOS_REG
	"LAN Gateway IP address is invalid.", //GW_LAN_GATEWAY_IP_ADDRESS_INVALID
	"Saves the new or edited Schedule Rule.", //KR96
	"Successfully exported configuration file", //GW_XML_CONFIG_GET_SUCCESS
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
	"UPnP added entry %v <-> %v%d <-> %v%d %s timeout%d '%s'", //GW_UPNP_IGD_PORTMAP_ADD
	"UPnP conflict with existing entry %v <-> %v:%d <-> %v:%d %s '%s'", //GW_UPNP_IGD_PORTMAP_CONFLICT
	"Message", //KRA1
	"Port", //_vs_port
	"<warn>Access Control Table is being reconfigured because the LAN subnet has been changed.</warn>", //GW_INET_ACL_RECONFIGURED_WARNING
	"Enables 802.11d operation. 802.11d is a wireless specification for operation in additional regulatory domains. This supplement to the 802.11 specifications defines the physical layer requirements (channelization, hopping patterns, new values for current MIB attributes, and other requirements to extend the operation of 802.11 WLANs to new regulatory domains (countries). The current 802.11 standard defines operation in only a few regulatory domains (countries). This supplement adds the requirements and definitions necessary to allow 802.11 WLAN equipment to operate in markets not served by the current standard. Enable this option if you are operating in one of these \"additional regulatory domains\".", //help186
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
	"PIN (Personal Identification Number)", //wps_p3_2
	"Save Settings Succeeded", //KR102
	"'%s': Local IP start '%v' is not in the LAN subnet", //GW_QOS_RULES_LOCAL_IP_START_SUBNET
	"Invalid PPTP IP address: %v", //GW_WAN_PPTP_IP_ADDRESS_INVALID
	"Alcohol", //_aa_bsecure_alcohol
	"Port Filter rule names cannot be duplicated.", //YM14
	"Dynamic Turbo mode is not allowed with 802.11b.", //GW_WLAN_11B_DYNAMIC_TURBO_INVALID
	"UPnP expired entry %v <-> %v:%d <-> %v%d %s '%s'", //GW_UPNP_IGD_PORTMAP_EXPIRE
	"Once your router is configured the way you want it, you can save the configuration settings to a configuration file. You might need this file so that you can load your configuration later in the event that the router's default settings are restored. To save the configuration, click the <strong>Save Configuration</strong> button.", //TA18
	"This option is available only when <span class='option'>802.11 Mode</span> is set to <span class='option'>802.11n only</span> or <span class='option'>802.11g only</span>.", //aw_erpe_h2
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
	"Add Wireless Device With WPS", //LW13
	"Time Frame", //sch_time
	"To protect your privacy you can configure wireless security features. This device supports three wireless security modes, including WEP, WPA-Personal, and WPA-Enterprise. WEP is the original wireless encryption standard. WPA provides a higher level of security. WPA-Personal does not require an authentication server. The WPA-Enterprise option requires an external RADIUS server.", //bws_intro_WlsSec
	"A PPPoE password MUST be specified", //GW_WAN_PPPOE_PASSWORD_INVALID
	"Before you can use the router's WCN Wizard, you must first execute the Wireless Network Setup Wizard on your PC. If you have not already done so, go to the Windows Control Panel and select Wireless Network Setup Wizard. When the Wireless Network Setup Wizard gives you the choice to \"Use a USB flash drive\" or \"Set up a network manually\", choose the latter. (In fact, you will not have to do the set-up manually; it will be done with the WCN ActiveX Control.)", //help211
	"Invalid Subnet Mask", //LS202
	"End Time", //tsc_EndTime
	"This wizard will guide you through a step-by-step process to add your wireless device to your wireless network.", //KR34
	"WEP Key 3", //_wepkey3
	"Remote Port Range", //at_RePortR
	"OSPF", //help640
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
	"PIN Settings", //LY5
	"For most applications, the priority classifiers ensure the right priorities, and specific WISH Rules are not required.", //YM87
	"The WAN Ping filter name %s does not exist", //GW_NAT_WAN_PING_FILTER_INVALID
	"If your PC's operating system is Windows XP Service Pack 2 (SP2) or later and you are using Windows Internet Explorer (IE) as your browser, you can use this option to save key parts of the router's current wireless security settings to your PC with Windows Connect Now (WCN) technology. The settings will then be available to propagate to other wireless devices.", //help835
	"(1..255)", //at_lowpriority
	"A name is required for rule number %d", //YM49
	"You cannot add new IP address %v. You can only reuse IP addresses from other policies.", //GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID
	"Invalid L2TP server IP address", //YM112
	"H-Node, this indicates a Hybrid-State of operation. First WINS servers are tried, if any, followed by local network broadcast. This is generally the preferred mode if you have configured WINS servers.", //KR90
	"Note that WCN only saves a few of the wireless security settings. When you use WCN to propagate settings to other wireless devices, you may have to make additional settings manually on those devices.", //help838
	"Enable this option only if you have purchased your own domain name and registered with a dynamic DNS service provider. The following parameters are displayed when the option is enabled.", //help892
	"If WAN Port Mode is set to \"Bridge Mode\", the following choices are displayed in place of the above choices, because the device is functioning as a bridge in a network that contains another router.", //KR73
	"There are several levels of wireless security. The level you choose depends on the security features your wireless adapters support.", //wwl_intro_s3_2
	"Invalid Metric for route", //_r_alert5
	"<warn>The WAN Ping filter name %s no longer exists, WAN PING will be disabled.</warn>", //GW_NAT_WAN_PING_FILTER_WARNING
	"Invalid local end IP Address.", //YM53
	"Note that WCN only sets a few of the wireless options. You will still need to go to the <a href=\"wireless.asp\">Wireless Settings</a> page to set other wireless options such as Super G Mode and transmission rate.", //help215
	"WISH is short for Wireless Intelligent Stream Handling, a technology developed to enhance your experience of using a wireless network by prioritizing the traffic of different applications.", //YM140
	"The DHCP server address %v was rejected by the network device. If you have more than one DHCP server on your network this may cause IP address conflicts.", //GW_DHCPSERVER_REJECTED
	"Allows the router to recognize HTTP transfers for many common audio and video streams and prioritize them above other traffic. Such streams are frequently used by digital media players.", //YM142
	"Password is invalid", //GW_SMTP_PASSWORD_INVALID
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
	"Enable the DMZ option only as a last resort. If you are having trouble using an application from a computer behind the router, first try opening ports associated with the application in the <a href='adv_virtual.asp' onclick='return jump_if();'>Virtual Server</a> or <a href='adv_portforward.asp' onclick='return jump_if();'>Port Forwarding</a> sections.", //hhaf_dmz
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
	"The IP address and, where appropriate, port number of the computer that originated a network connection.", //YM160
	"Assigned IP", //LS423
	"L2TP Gateway IP address %v must be within the WAN subnet.", //GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID
	"%s': Host 1 IP start, %v, must be less than host 1 IP end, %v", //GW_WISH_RULES_HOST1_IP
	"Private", //_vs_private
	"This setting has no effect if the \"Learn NetBIOS information from WAN\" is activated.", //KR86
	"Secondary WINS IP Address", //bd_NETBIOS_SEC_WINS
	"Start IP address must be less than end IP address: %v-%v.", //GW_INET_ACL_START_IP_ADDRESS_INVALID
	"Authentication", //auth
	"Cannot stop the process", //KR24
	"5GHz", //KR17
	"Host 2 IP Range", //YM84
	"A QoS Engine Rule identifies a specific message flow and assigns a priority to that flow.", //help88
	"Enabling Remote Management, allows you or others to change the router configuration from a computer on the Internet.", //hhta_en
	"Invalid PPPoE IP address", //YM103
	"In bridge mode, the device still supports several features not available in ordinary bridges -- features that involve the WAN side of the upstream router.", //KR64
	"Per regulatory request, channel 52 - 140 can not be used without enable radar detection.", //GW_WLAN_11A_DFS_CHANNEL_INVALID
	"Wi-Fi Protected Setup", //LW4
	"Physical layer", //help645
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
	"Enabled", //_enabled
	"Invalid Interface for route", //_r_alert4
	"Add Wireless Station", //LY10
	"The DHCP server start address %v is not valid in the LAN subnet %v.", //GW_DHCP_SERVER_POOL_FROM_INVALID
	"Lock AP setup", //WIFISC_AP_SETUP_LOCKED
	"Do you want to abandon changes you made to the current entry?", //YM91
	"Set Selected Registrar failed, reason (%s), err_code (%u)", //WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL
	"Nothing has changed, save anyway?", //_ask_nochange
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
	"obj_word + \" conflict with Virtual Server Port.\"", //TEXT056
	"Invalid Server IP Address", //YM130
	"Select Dynamic DNS Server", //KR99
	"Primary WINS IP address must be specified if secondary is also specified.", //GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID
	"Enable anti-spoof checking", //KR106
	"Virtual server '%s' protocol number, %d, must be 0 or between 3 and 255.", //GW_NAT_VS_PROTOCOL_INVALID
	"Select this option if you want to setup your network manually", //KR52
	"Welcome to the Add Wireless Device Wizard", //KR33
	"You must be logged in as \"admin\" to perform this action.", //ZM23
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
	"Metric", //help112
	"Some firmware upgrades reset the configuration options to the factory defaults. Before performing an upgrade, be sure to save the current configuration.", //tf_msg_FWUgReset
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
	"The Web Filter section is one of two means by which you can specify the web sites you want to allow. You also have the alternative of using the Sentinel Parental Controls Service, which allows you to specify broad categories of web sites and saves you the trouble of entering specific web site URLs. For more information about the Sentinel service, refer to <a href='../Tools/Sentinel.shtml'>Tools&nbsp;&rarr;&nbsp;Sentinel</a>.", //help143s
	"This mode is not backwards compatible with non-Turbo (legacy) devices. This mode should only be enabled when all devices on the wireless network are Static Turbo enabled.", //help363
	"Web Newsgroup", //_aa_bsecure_web_newsgroup
	"Invalid Primary DNS Address", //YM128
	"%s of '%s' can not be empty.", //GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID
	"StreamEngine&trade; technology is applied to media streams that are passed between the WAN side of the upstream router and clients of the bridge.", //KR72
	"Password or Key", //td_PWK
	"Host 1 IP Range", //YM82
	"Invalid Authentication Timeout.", //YM119
	"The bridge still has the ability to analyze traffic on the WAN side of the upstream router so as to determine the speed of its WAN connection.", //KR70
	"The IP address and, where appropriate, port number of the computer to which a network connection has been made.", //YM161
	"DHCP server pool size is too big (must be no more than 256 addresses).", //GW_DHCP_SERVER_POOL_SIZE_INVALID
	"Established", //_sdi_s4b
	"DNS Lookup Authentication Server", //ZM8
	"Invalid Secondary DNS Address", //YM129
	"64-bit ASCII keys are up to 5 characters in length (DMODE is a valid string of 5 characters for 64-bit encryption.)", //help370
	"Locking the WPS-PIN Setup prevents the settings from being changed by any new external register using its PIN. Devices can still be added to the wireless network using Wi-Fi Protected Setup. It is still possible to change wireless network settings with <a href=\"wireless.asp\" shape=\"rect\">Manual Wireless Network Setup</a>, <a href=\"wizard_wlan.asp\" shape=\"rect\">Wireless Network Setup Wizard</a>", //LY29
	"Warning while writing configuration file: %s", //GW_XML_CONFIG_WRITE_WARN
	"Name '%s' is already used", //GW_FIREWALL_NAME_INVALID
	"'%s': Host 2 IP start, %v, must be less than host 2 IP end, %v", //GW_WISH_RULES_HOST2_IP
	"Product Page", //TA2
	"Connect", //LS314
	"Traffic Type", //_vs_traffictype
	"The timeout value cannot be greater than 8760.", //GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID
	"please enter the PIN from your wireless device and click the below 'Connect' Button", //wps_p3_4
	"Select this option if your wireless device supports Wi-Fi Protected Setup", //KR51
	"PPTP Gateway IP address %v must be within the WAN subnet.", //GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID
	"Click the <span class=\"button_ref\">Save to Windows Connect Now</span> button, and the WCN technology will capture the wireless network settings from your router and save them on your PC.", //help837
	"Please select an Application Name first", //TEXT052
	"Open", //OPEN
	"News", //_aa_bsecure_news
	"Update", //YM34
	"Advanced Wireless", //_advwls
	"<warn>DHCP Reservation %v has been disabled because the DHCP pool is too small.</warn>", //GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING
	"MAC Filter settings will lockout all machines. This is not allowed.", //GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID
	"WEP Key 4", //_wepkey4
	"optional", //LT124
	"Search Engine", //_aa_bsecure_search_engine
	"WPA Only", //KR47
	"If you choose the WEP security option this device will <strong>ONLY</strong> operate in <strong>Legacy Wireless mode (802.11B/G)</strong>. This means you will <strong>NOT</strong> get 11N performance due to the fact that WEP is not supported by the Draft 11N specification.", //bws_msg_WEP_3
	"<warn>Email server address conflicts with router LAN address - email will be disabled.</warn>", //GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING
	"LAN IP mode is invalid", //GW_LAN_IP_MODE_INVALID
	"The specified Big Pond server is not a proper domain name or IP address.", //GW_WAN_BIGPOND_SERVER_NOTSTD15
	"Once your D-Link router is properly configured and this option is enabled, the router will manage the IPv6 addresses and other network configuration information for computers and other devices connected to your Local Area Network. There is no need for you to do this yourself.", //IPV6_TEXT101
	"Fragmentation threshold should be between 256 and 2346.", //GW_WLAN_FRAGMENT_THRESHOLD_INVALID
	"Domain name given is invalid", //GW_LAN_DOMAIN_NAME_INVALID
	"Device name given is invalid", //GW_LAN_DEVICE_NAME_INVALID
	"Session Overlap Detected", //_wifisc_overlap
	"The wizard will either display the wireless network settings to guide you through manual configuration, prompt you to enter the PIN for the device, or ask you to press the configuration button on the device. If the device supports Wi-Fi Protected Setup and has a configuration button, you can add it to the network by pressing the configuration button on the device and then the on the router within 60 seconds. The status LED on the router will flash three times if the device has been successfully added to the network.", //LW62
	"Process stopped. You may click on the Cancel button below to return to the beginning of the wizard page and restart the process", //KR23
	"Pornography", //_aa_bsecure_pornography
	"Name can not be empty string.", //GW_NAT_NAME_INVALID
	"Number of Dynamic DHCP Clients", //bd_title_clients
	"Invalid PPTP server IP address", //YM108
	"Destination IP End address should not be in LAN subnet", //YM19
	"STA with MAC (%m) registered in", //WIFISC_AP_PROXY_PROCESS_COMPLETE
	"Record '%s' is duplicate of '%s'.", //GW_NAT_ENTRY_DUPLICATED_INVALID
	"%s' [%s:%s] conflicts with '%s'[%s:%s] on different IP Addresses.", //GW_NAT_PORT_FORWARD_CONFLICT_INVALID
	"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new D-Link Systems Router to the Internet, click on the button below.", //LW27
	"Are you sure you want to update", //YM38
	"NTP Server is not configured", //tt_alert_nontp
	"Wi-Fi Protected Setup", //LY2
	"PIN(1st half) Mismatch Detected", //KR29
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
	"Only \"Admin\" account can change security settings.", //LW15
	"If you are new to networking and have never configured a router before, click on <strong>Internet Connection Setup Wizard</strong> and the router will guide you through a few simple steps to get your network up and running.", //LW33
	"Succeeded. To add another device click on the Cancel button below or click on the Wireless Status button to check wireless status.", //KR27
	"Controls endpoint filtering for packets of the UDP protocol.", //YM138
	"%s' [%s%d]->%v/%d conflicts with '%s' [%s%d]->%v%d.", //GW_NAT_VS_PORT_CONFLICT_INVALID
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
	"Enable Auto Channel Scan", //ebwl_AChan
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
	"Password", //_password
	"Invalid MAC address %m.", //GW_INET_ACCESS_POLICY_MAC_INVALID
	"Wi-Fi Protected Setup", //LW2
	"Assign any unused IP address in the range of IP addresses available for the LAN.", //KR75
	"Failed to write configuration file: %s", //GW_XML_CONFIG_WRITE_FAILED
	"Enable WISH", //YM73
	"Name '%s' is already used.", //GW_WISH_RULES_NAME_USED_INVALID
	"The DHCP server pool size is too big to fit in LAN subnet %v.", //GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID
	"Aggregation Max Size", //aw_AS
	"This is a list of all active conversations involving wireless clients in the local network.", //YM171
	"Reserved IP %v conflicts with configured LAN IP Address", //GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID
	"Virtual server '%s' can not use the router's HTTP WAN administration port, %u", //GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
	"The netmask field identifies the portion of the destination IP in use.", //hhav_r_netmask
	"VIRTUAL SERVERS LIST", //vs_vslist
	"IPv6 FIREWALL", //if_iflist
	"Note that some of these options can interact with other port restrictions. Endpoint Independent Filtering takes priority over inbound filters or schedules, so it is possible for an incoming session request related to an outgoing session to enter through a port in spite of an active inbound filter on that port. However, packets will be rejected as expected when sent to blocked ports (whether blocked by schedule or by inbound filter) for which there are no active sessions. Port and Address Restricted Filtering ensures that inbound filters and schedules work precisely, but prevents some level of connectivity, and therefore might require the use of port triggers, virtual servers, or port forwarding to open the ports needed by the application. Address Restricted Filtering gives a compromise position, which avoids problems when communicating with certain other types of NAT router (symmetric NATs in particular) but leaves inbound filters and scheduled access working as expected.", //YM137
	"Priority Classifiers", //YM74
	"Syslog server IP address %v is not in the lan subnet.", //GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID
	"Enable this option if you have a syslog server currently running on the LAN and wish to send log messages to it.", //help858
	"MAC address is already used: %s", //GW_MAC_FILTER_MAC_UNIQUENESS_INVALID
	"Push Button", //KR40
	"MAC address filter can't be NULL address: %m", //GW_MAC_FILTER_NULL_MAC_INVALID
	"32 Kbytes", //aw_32
	"WAN subnet conflicts with LAN subnet", //GW_WAN_LAN_SUBNET_CONFLICT_INVALID
	"Enabled/Configured", //LW66
	"DelAPSettings by (%s) failed, reason (%s), err_code (%u)", //WIFISC_AP_DEL_APSETTINGS_FAIL
	"(13 characters or 26 hex digits)", //wwl_wsp_chars_1
	"WINS Servers store information regarding network hosts, allowing hosts to \"register\" themselves as well as discover other available hosts, e.g. for use in Network Neighbourhood.", //KR85
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
	"PIN Settings", //LW7
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
	"This area of the screen reflects configuration settings from the <a href='wireless.asp'>Setup &rarr; Wireless Settings</a> page. The <span class='option'>MAC Address</span> is the factory-assigned identifier of the wireless card.", //LT291
	"This section is where you define WISH Rules.", //YM156
	"Adolescent (9-12)", //_aa_bsecure_age_ado
	"Select this option if your wireless adapters DO NOT SUPPORT WPA", //wwl_text_good
	"'%s': Priority, %d, needs to be between 1 and 255", //GW_QOS_RULES_PRIORITY_RANGE
	"On Schedule", //te_OnSch
	"Web Mail", //_aa_bsecure_web_mail
	"Make sure the APs are configured with same channel number.", //help188b
	"Start IP address(%v) of '%s' should not be within LAN subnet(%v).", //GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID
	"WAN Traffic Shaping", //at_title_Traff
	"Specifies one-half of the WDS link. The other AP must also have the MAC address of this AP to create the WDS link back to this AP.", //help189
	"Wireless radar detected, switch to channel %d", //GW_WIRELESS_SWITCH_CHANNEL
	"A Big Pond server MUST be specified", //GW_WAN_BIGPOND_SERVER_INVALID
	"Configuration file parse error around line %u char %u", //GW_XML_CONFIG_SET_PARSE
	"Enabling <strong>WMM</strong> can help control latency and jitter when transmitting multimedia content over a wireless connection.", //hhaw_wmm
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
	"IPv6 FIREWALL", //_if_title
	"A PPPoE user name MUST be specified", //GW_WAN_PPPOE_USERNAME_INVALID
	"Invalid PPTP subnet mask %v", //GW_WAN_PPTP_SUBNET_INVALID
	"NetBIOS Scope is not in a valid form", //GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID
	"Static IP mode is always on, so no action buttons are avaliable.", //KR94
	"WISH", //YM63
	"Gateway", //help108
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
	"Enter a host name or IP address above and click 'Ping'", //tsc_pingt_msg1
	"UPnP deleted entry %v <-> %v:%d %s", //GW_UPNP_IGD_PORTMAP_DEL
	"Invalid L2TP gateway IP address", //YM111
	"Disconnect", //LS315
	"Incorrect key length, should be 8 to 63 characters long.", //GW_WLAN_WPA_PSK_LEN_INVALID
	"Permit any WAN user to access the related capability.", //help178
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
	"Enable or disable this SSID. When enabled, the following parameters are in effect.", //dlink_help156
	"Child (0-8)", //_aa_bsecure_age_child
	"WPA is the older standard; select this option if the clients that will be used with the router only support the older standard. WPA2 is the newer implementation of the stronger IEEE 802.11i security standard. With the \"WPA or WPA2\" option, the router tries WPA2 first, but falls back to WPA if the client only supports WPA. The strongest cipher that the client supports will be used. With the \"WPA2 Only\" option, the router associates only with clients that also support WPA2 security. The AES cipher will be used in \"WPA or WPA2\" and \"WPA2 Only\" modes to ensure best security. Some gaming and legacy devices work only in \"WPA Only\" mode. TKIP is the cipher for \"WPA only\" mode.", //help375
	"This web site address '%s' is invalid.", //GW_WEB_FILTER_WEBSITE_INVALID_INVALID
	"Week", //ZM21
	"Internet Sessions", //YM157
	"The WCN ActiveX Control provides the WCN link between your PC and the router via the browser that communicates wireless configuration data without a USB flash drive. The browser will attempt to download the WCN ActiveX Control, if it is not already available on your PC. For this action to succeed, you must already have a WAN connection, and the browser's internet security setting must be Medium or lower (select Tools &rarr; Internet Options &rarr; Security &rarr; Custom Level &rarr; Medium).", //help213
	"Are you sure you want to enable/disable", //YM24
	"PBC (Push Button Configuration)", //wps_p3_3
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
	"Received Unknown Message", //KR32
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
	"The name field allows you to specify a name for identification of this route, e.g. \"Network 2\"", //hhav_r_name
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
	"%s' is duplicate of '%s'", //GW_WISH_RULES_DUPLICATED
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
	"Password and Verify Password do not match. Please reconfirm admin password.", //YM173
	"A Port Filter rule name cannot be blank.", //YM13
	"Your web browser is too old to use this web site. Please upgrade your browser.", //YM172
	"Invalid TPC Max Gain", //YM31
	"Select the Sentinel categories to filter.", //_aa_wiz_s6_msg
	"Password can only contain printable characters.", //S493
	"Host 2 Port Range", //YM85
	"The 'Name' field can not be blank", //GW_SCHEDULES_NAME_INVALID
	"Invalid Gateway", //LS204
	"16 Kbytes", //aw_16
	"(Refer to the <a href=\"wireless.asp\"> Setup &rarr; Wireless Settings &rarr; Manual Wireless Network Setup</a> page.)", //aw_erpe_h3
	"Start the wizard.", //LW64
	"Day(s)", //_days
	"Use this section to configure D-Link's QoS Engine powered by QoS Engine&trade; Technology. This QoS Engine improves your online gaming experience by ensuring that your game traffic is prioritized over other network traffic, such as FTP or Web.", //at_intro
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
	"This is an advanced setting and is normally left blank. This allows the configuration of a NetBIOS \"domain\" name under which network hosts operate.", //KR88
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
	"Enable the Wi-Fi Protected Setup feature.", //LW55
	"Enable Wireless", //bwl_EW
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
	"please press the push button on your wireless device and click the below 'Connect' Button within 120 seconds", //wps_p3_5
	"To specify any other protocol, select \"Other\" from the list, then enter the corresponding protocol number (<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'> as assigned by the IANA</a>) in the <span class='option'>Protocol</span> box.", //help19x2
	"Step 2: Connect your Wireless Device", //KR36
	"Route metric %u is invalid, must be from 1 to 16", //GW_ROUTES_METRIC_INVALID
	"The SSID field can not be blank.", //GW_WLAN_SSID_INVALID
	"Invalid IP Address", //LS46
	"The timeout value cannot be less than or equal to zero.", //YM179
	"The IP address of the router on the local area network. For example, 192.168.0.1.", //KR78
	"The bridge checks the support site for updates by way of the upstream router.", //KR66
	"Magazine", //_aa_bsecure_magazine
	"The device may be too busy to properly receive it right now. Please try to save the settings again.", //KR101
	"WPA only mode doesn't support AES.", //GW_WLAN_WPA_WPA_AES_INVALID
	"Inbound Filter", //GW_NAT_INBOUND_FILTER
	"The Policy Name cannot be blank.", //GW_INET_ACL_POLICY_NAME_INVALID
	"Internet", //sa_Internet
	"Peer-to-Peer network between wireless clients", //help406
	"The rule applies to a flow of messages for which host 1's port number is within the range set here.", //YM153
	"Remote IP Range", //at_ReIPR
	"One or more Internet access policies are in effect. Internet access will be restricted according to these policies", //GW_INET_ACCESS_RESTRICTED
	"DTIM should be between 1 and 255.", //GW_WLAN_DTIM_INVALID
	"A WISH Rule identifies a specific message flow and assigns a priority to that flow.", //YM144
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna", //up_tz_26
	"Select a filter that controls access as needed for this rule. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help71
	"HNAP AddPortMapping modified %dth virtual server entry from '%s' %v%d<->%v%d %S to '%s' %v%d<->%v%d %S", //GW_PURE_ADDPORTMAPPING_MODIFY
	"User stopped", //tsc_pingt_msg10
	"The printer's IP address and TCP port number are shown <a href=\"../Status/PS.shtml\" onclick=\"return jump_if();\">here</a>.", //tps_foo
	"HNAP AddPortMapping modified %dth virtual server entry from '%s' %v%d<->%v%d %S to %S", //GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL
	"Above message repeated %d times", //LOG_PREV_MSG_REPEATED_N_TIMES
	"The <strong>user</strong> account may not perform the requested action.", //ca_intro
	"The addressing of the Internet side learnt thru DHCP conflicts with the addressing selected for the LAN side. Internet communications will be disabled until you have changed the LAN side addressing to resolve the problem.", //GW_WAN_LAN_ADDRESS_CONFLICT_DHCP
	"The section lists the current Inbound Filter Rules. An Inbound Filter Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the \"Update Inbound Filter Rule\" section is activated for editing.", //help176
	"HNAP AddPortMapping created %dth virtual server entry '%s' %v%d<->%v%d %S", //GW_PURE_ADDPORTMAPPING_CREATE
	"Select a schedule for when the rule will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools → Schedules</a> screen and create a new schedule.", //hhag_30
	"Click the <strong>Add</strong> or <strong>Update</strong> button to store a finished rule in the Rules List below.", //hhai_save
	"Administrator", //ADMIN
	"The following printer has been detected.&nbsp; Click <i>Next</i>&nbsp; to install the printer onto your computer.", //wprn_s1a
	"Email notification is not enabled.", //sl_alert_3
	"After configuring the router for dynamic DNS, you can open a browser and navigate to the URL for your domain (for example <code>http://www.mydomain.info</code>) and the router will attempt to forward the request to port 80 on your LAN. If, however, you do this from a LAN-side computer and there is no virtual server defined for port 80, the router will return the router's configuration home page. Refer to the <a href='adv_virtual.asp'>Advanced &rarr; Virtual&nbsp;Server</a> configuration page to set up a virtual server.", //help900
	"The printer's IP address and queue name are shown <a href=\"../Status/PS.shtml\" onclick=\"return jump_if();\">here</a>.", //tps_foo2
	"This setting should remain at its default value of 2346 bytes.", //help182
	" -- IP Address should be in LAN subnet.", //aa_alert_12
	"To check for the latest firmware, click the [Check Online Now...] button. If you would like to be notified when new firmware is released, place a checkmark in the box next to Email Notification of Newer Firmware Version.", //tf_intro_FWCh
	"Save To Local Hard Drive", //ts_ss
	"Set Username and Password Connection (PPTP)", //wwa_title_set_pptp
	"(e.g. myhost.mydomain.net)", //_hostname_eg
	"Note: You will need to enter the same password as keys in this step into your wireless clients in order to enable proper wireless communication.", //wwl_s4_note
	"Select a filter that controls access as needed for this virtual server. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help22
	"The Wireless Security Password must be at least 13 characters or 26 hex digits. You entered", //wwl_alert_pv5_1
	"HNAP SetWLanSettings24 set Enabled %s, SSIDBroadcast %s, Channel %d", //GW_PURE_SETWLANSETTINGS24
	"Specify the LAN IP address of the LAN computer that you want to have unrestricted Internet communication. If this computer obtains its address Automatically using DHCP, then you may want to make a static reservation on the <a href=\"adv_network.asp\">Setup &rarr; Network&nbsp;Settings</a> page so that the IP address of the DMZ computer does not change.", //help167
	"Detected xDSL or Other Frame Relay Network", //at_DxDSL
	"The Printer Setup Wizard supports only Windows XP/2000/98/ME operating systems. Your computer uses the <span id=\"wz_page_1_err_1_os\">&nbsp;</span> operating system.", //wprn_bados2
	"The setup executable you have just launched will display a progress bar and notify you when setup is complete. When done, click <em>Finish</em> below to close the Printer Setup wizard.", //wprn_s3a
	"If the setup executable did not launch automatically after downloading to your computer, you may need to open the file-download folder using a file browser and double-click on the icon labeled <em>Printer_Setup.exe.</em>", //wprn_tt10
	"WAN Ping <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Inbound Filter</a>", //bwn_IF
	"Note, however, if the AP's settings specify \"DHCP (Dynamic)\" Address, and the <span>router</span>'s DHCP server assigns a domain name to the AP, that domain name will override any name you enter here.", //_1044a
	"Attempt to fix the problem with the printer, then click <i>Refresh</i>&nbsp; to update printer status.", //wprn_tt6
	"Select a schedule for the times when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help72
	"Unknown", //_sdi_s6
	"Select a schedule for when the service will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools → Schedules</a> screen and create a new schedule.", //hhpt_sch
	"Enable Raw Port Printing", //tps_enraw
	"This log will be sent to email address", //sl_alert_2
	"Auto 10/100/1000Mbps", //anet_wp_2
	"Restore all Settings to the Factory Defaults", //tss_RestAll
	"HNAP SetDeviceSettings set wan mode to %S, %v/%v/%v", //GW_PURE_SETWANSETTINGS
	"Select a schedule for when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help53
	"Saves the new or edited Inbound Filter Rule in the following list.", //help175
	"If you selected the On Schedule option, select one of the defined schedule rules. If you do not see the schedule you need in the list of schedules, go to the <a href='tools_schedules.asp'>Tools&nbsp;&rarr;&nbsp;Schedules</a> screen and create a new schedule.", //help872
	"The transmission standard being used by the client. Values are 11a, 11b, 11g, or 11n for 802.11a, 802.11b, 802.11g, or 802.11n respectively.", //help785
	"After clicking <i>Next</i>, you will be asked for permission to download an executable file. Please click <i>Run/Open</i>&nbsp; to allow the executable to run on your computer. If a second window appears prompting you to verify the publisher, please click <i>Run</i>&nbsp; again.", //wprn_s2b
	"The wizard will guide you through the following steps. Click <em>Next</em> to begin.", //wprn_intro2
	"Please select a filter.", //GW_INET_ACL_NO_FILTER_SELECTED_INVALID
	"When this option is enabled, an email will be sent to the email address configured in the email section whenever new firmware is available. You must have Email Notification enabled from the <a href=\"tools_email.asp\">Tools &rarr; Email&nbsp;Settings</a> page.", //help890
	"The IP address and, where appropriate, port number of the local application.", //help814
	"Time interval the machine can be idle before the PPTP connection is disconnected. The Maximum Idle Time value is only used for the \"On demand\" and \"Manual\" reconnect modes.", //help283
	"This printing protocol is currently disabled. You can enable it <a href='../Tools/PS.shtml' onclick='return jump_if();'>here</a>.", //sps_protdis
	"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help831
	"Insufficient Permissions", //_cantapplysettings
	"Allows H.323 (specifically Microsoft Netmeeting) clients to communicate across NAT. Note that if you want your buddies to call you, you should also set up a virtual server for NetMeeting. Refer to the <a href='adv_virtual.asp'> Advanced&nbsp;&rarr;&nbsp;Virtual&nbsp;Server</a> page for information on how to set up a virtual server.", //help39
	"WCN configuration aborted due to %s", //WCN_LOG_ABORT
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"The Web sites listed here are used when the Web Filter option is enabled in <a href='adv_access_control.asp'>Access Control</a>.", //help141_a
	"The Firewall Settings allows you to set a single computer on your network outside of the router.", //af_intro_x
	"Add/Update Inbound Filter Rule", //help170
	"To use the shared printer from this computer, launch the Printer Wizard from the <a href=\"../Basic/Wizard.shtml\" onclick=\"return jump_if();\"> <i>Wizard </i> page</a>.", //tps_intro4
	"Or you may enter a dynamic DNS service provider manually.", //help893b
	"Starting DHCP server", //GW_DHCPSERVER_START
	"Some firmware upgrades reset the configuration options to the factory defaults. Before performing an upgrade, be sure to save the current configuration from the <a href=\"tools_system.asp\">Tools &rarr; System</a> screen.", //help887
	"Allows FTP clients and servers to transfer data across NAT. Refer to the <a href='adv_virtual.asp'>Advanced&nbsp;&rarr;&nbsp;Virtual&nbsp;Server</a> page if you want to host an FTP server.", //help38
	"Welcome to the D-Link Wireless Security Setup Wizard", //wwl_title_wel
	"SPI (\"stateful packet inspection\" also known as \"dynamic packet filtering\") helps to prevent cyberattacks by tracking more state per session. It validates that the traffic passing through that session conforms to the protocol.", //help164
	"Select a filter that restricts the Internet hosts that can access this virtual server to hosts that you trust. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\"> Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //hhav_filt
	"HNAP AddPortMapping '%s' %v%d<->%v%d %S conflict with %dth virtual server entry '%s' %v%d<->%v%d %S", //GW_PURE_ADDPORTMAPPING_CONFLICT
	"HNAP SetRouterLanSettings set RouterIPAddress %v, RouterSubnetMask %v, DHCPServerEnabled %s", //GW_PURE_SETROUTERLANSETTINGS
	"HNAP setWLanSecurity set Enabled %s, Type %s", //GW_PURE_SETWLANSECURITY
	"The Policy Name cannot be blank.", //aa_alert_9
	"Time interval the machine can be idle before the L2TP connection is disconnected. The Maximum Idle Time value is used for the \"On demand\" and \"Manual\" reconnect modes.", //help287
	"Remote Admin <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Inbound Filter</a>", //ta_RAIF
	"This setting should remain at its default value of 2346 bytes.", //help180
	"HNAP SetDeviceSettings changed DeviceName to '%s'", //GW_PURE_SETDEVICESETTINGS
	"Signal(%)", //_rssi
	"This wizard will guide you through a step-by-step process to setup your wireless network and make it secure.", //wwl_intro_wel
	"Click here to access firmware online.", //tf_ClickDL
	"DMZ means \"Demilitarized Zone.\" If an application has trouble working from behind the router, you can expose one computer to the Internet and run the application on that computer.", //help165
	"Other", //_vs_other
	"To use the shared printer from this computer, follow the setup instructions found in <a href='../Help/Basic.shtml#PS' onclick='return jump_if();' style='white-spacenowrap;'>Help -> Home -> Printer Wizard</a>.", //tps_intro5
	"The uploaded firmware file may not be correct. You may have uploaded a file that is not intended for this device, or the uploaded file may be corrupted.", //ub_intro_1
	"Time interval the machine can be idle before the PPPoE connection is disconnected. The Maximum Idle Time value is only used for the \"On demand\" and \"Manual\" reconnect modes.", //help277
	"This feature enables forwarding of \"magic packets\" (that is, specially formatted wake-up packets) from the WAN to a LAN computer or other device that is \"Wake on LAN\" (WOL) capable. The WOL device must be defined as such on the <a href='adv_virtual.asp'> Advanced&nbsp;&rarr;&nbsp;Virtual&nbsp;Server</a> page. The LAN IP address for the virtual server is typically set to the broadcast address 192.168.0.255. The computer on the LAN whose MAC address is contained in the magic packet will be awakened.", //help41
	"Virtual Server", //VIRTUAL_SERVERS
	"Select a schedule for when the virtual server will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\" onclick=\"return jump_if();\">Tools &rarr; Schedules</a> screen and create a new schedule.", //hhav_sch
	"Restore To Factory Default Settings", //ts_rfd
	"When the PPTP ALG is enabled, LAN computers can establish PPTP VPN connections either with the same or with different VPN servers. When the PPTP ALG is disabled, the router allows VPN operation in a restricted way 。 LAN computers are typically able to establish VPN tunnels to different VPN Internet servers but not to the same server. The advantage of disabling the PPTP ALG is to increase VPN performance. Enabling the PPTP ALG also allows incoming VPN connections to a LAN side VPN server (refer to <a href=\"adv_virtual.asp\">Advanced &rarr; Virtual Server</a>).", //help33b
	"Load From Local Hard Drive", //ts_ls
	"Your wireless network needs a name so it can be easily recognized by wireless clients. For security purposes, it is highly recommended to change the pre-configured network name of [dlink].", //wwl_intro_s1
	"HNAP DeletePortMapping %s%d modified %dth virtual server entry '%s' %v%d<->%v%d %S to %S", //GW_PURE_DELETEPORTMAPPING_MODIFY
	"After clicking <i>Next</i>, you will be asked for permission to download an executable file. Please click \"OK\" to download the the file.<br /><br /> To launch the executable, you may need to open the file-download folder using a file browser and double-click on the icon labeled <i>Printer_Setup.exe</i>.", //wprn_s2c
	"It is possible for a computer or device that is manually configured to have an address that does reside within this range. In this case the address should be reserved (see <a href=\"#Static_DHCP\">DHCP Reservation</a> below), so that the DHCP Server knows that this specific address can only be used by a specific computer or device.", //help320
	"The Internet Sessions page displays full details of active Internet sessions through your router. An Internet session is a conversation between a program or application on a LAN-side computer and a program or application on a WAN-side computer.", //help813
	"Select a dynamic DNS service provider from the pull-down list, or you may enter a dynamic DNS service provider manually.", //help893
	"Select this option to save the router log to a file on your computer.", //help803
	"To check for the latest firmware, click the <span class='button_ref'>Check Online Now</span> button. If you would like to be notified when new firmware is released, place a checkmark in the box next to <span class='option'>Email Notification of Newer Firmware Version</span>.", //help877
	"(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague", //up_tz_27
	"With the above example values filled in and this Port Forwarding Rule enabled, all TCP and UDP traffic on ports 6159 through 6180 and port 99 is passed through the router and redirected to the Internal Private IP Address of your Game Server at 192.168.0.50.", //help74
	"When \"OFF\" is selected, MAC addresses are not used to control network access. When \"ALLOW\" is selected, only computers with MAC addresses listed in the MAC Address List are granted network access. When \"DENY\" is selected, any computer with a MAC address listed in the MAC Address List is refused access to the network.", //help155_2
	"Established: Rate Estimating", //_sdi_s4
	"Miscellaneous", //MISC
	"Note: Now uploading. The upload may take up to 1 minute.", //tf_msg_Upping
	"Failure sending log email - try again in %d minutes", //GW_LOG_EMAIL_FAILED
	"Established or closing TCP connections.", //help823_17
	"Enable SSID", //IPV6_TEXT4
	"This page displays the full details of active sessions to your router.", //sa_intro
	"Rebooting will disconnect any active internet sessions.", //up_rb_2
	"Select a schedule for when the service will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> screen and create a new schedule.", //help23
	"If IGMP is enabled, this area of the screen shows all multicast groups of which any LAN devices are members.", //_bln_title_IGMPMemberships_h
	"See also <a href=\"adv_virtual.asp\"> Advanced &rarr; Virtual&nbsp;Server</a>, <a href=\"adv_portforward.asp\">Advanced &rarr; Port&nbsp;Forwarding</a>, <a href=\"adv_appl.asp\"> Advanced &rarr; Application&nbsp;Rules</a>, and <a href=\"adv_network.asp\">Advanced &rarr; Network (UPnP)</a> for related options.", //haf_intro_2
	"If you provided email information with the <a href='tools_email.asp'>Tools&nbsp;&rarr;&nbsp;Email</a> screen, clicking the <span class='button_ref'>Email Now</span> button sends the router log to the configured email address.", //help802
	"Click <i>Refresh</i>&nbsp; to try again.", //wprn_tt5
	"You can also have the log mailed to you periodically. Refer to <a href='tools_email.asp' onclick='return jump_if();'>Tools &rarr; EMail</a>.", //hhsl_lmail
	"Press the button below to continue configuring the router if the previous page doesn't restore in <span id=\"show_sec\"></span>&nbsp;seconds.", //ap_intro_noreboot
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Warsaw, Zagreb", //up_tz_29
	"HNAP SetMACFilters2", //GW_PURE_SETMACFILTERS2
	"HNAP Reboot", //GW_PURE_REBOOT
	"If you changed the IP address of the router you will need to change the IP address in your browser before accessing the configuration website again.", //rb_change
	"The IP address and, where appropriate, port number of the application on the Internet.", //help816
	"HNAP DeletePortMapping %s%d deleted %dth virtual server entry '%s' %v%d<->%v%d %S", //GW_PURE_DELETEPORTMAPPING_DELETE
	"If the uploaded file is correct, it is possible that the device may be too busy to properly receive it right now. In this case, please try the upload again. It is also possible that you are logged in as a 'user' instead of an 'admin' - only administrators can upload new firmware.", //ub_intro_3
	"Requests may be redirected to the \"Forbidden\" page if web access for the LAN machine is restricted by an Access Control Rule. Add the WAN-side identity (WAN-side IP-address of the router or its dynamic DNS name) on the <a href='adv_filters_url.asp'> Advanced&nbsp;&rarr;&nbsp;Web&nbsp;Filter</a> screen to work around this problem.", //help30
	"Invalid LAN IP Address", //bln_alert_2
	"Use with <a href='adv_access_control.asp' onclick='return jump_if();'>Access Control</a>.", //hhwf_xref
	"Gateway remote administration enabled on port: %u", //GW_REMOTE_ADMINSTRATION
	"You have selected your security level - you will need to set a wireless security password.", //wwl_s4_intro
	"Security Mode", //sd_SecTyp
	"WAN IPv6 ADDRESS SETTINGS", //IPV6_WAN_IP
	"IPv6 Address", //IPV6_TEXT0
	"Please accept and install the ActiveX, then try it again.", //gw_wcn_alert_3
	"Invalid Network Key!", //IPV6_TEXT2
	"Enable Routing Between Zones", //S473
	"Enable SPI", //af_ES
	"This selection helps you to define the Guest Zone scale.", //IPV6_TEXT5
	"Specifies whether the Guest Zone will be enabled or disabled.", //IPV6_TEXT6
	"Provide a name for Guest Zone wireless network.", //IPV6_TEXT7
	"Use this section to enable routing between Host Zone and Guest Zone, Guest clients cannot access Host clients' data without enabling this function.", //IPV6_TEXT8
	"Securing your wireless network is important as it is used to protect the integrity of the information being transmitted. The router is capable of 4 types of wireless security; WEP, WPA only, WPA2 only, and WPA/WPA2 (auto-detect).", //IPV6_TEXT9
	"Wired Equivalent Protocol (WEP) is a wireless security protocol for Wireless Local Area Networks (WLAN). WEP provides security by encrypting the data that is sent over the WLAN. The router supports 2 levels of WEP Encryption: 64-bit and 128-bit. WEP is disabled by default. The WEP setting can be changed to suit an existing wireless network or to customize your wireless network.", //IPV6_TEXT10
	"Authentication is a process by which the router verifies the identity of a network device that is attempting to join the wireless network. There are two types of authentication for this device when using WEP.", //IPV6_TEXT11
	"Select this option to allow all wireless devices to communicate with the router without being required to provide the encryption key needed to gain access to the network.", //IPV6_TEXT12
	"Select this option if you require any wireless device attempting to communicate with the router to provide the encryption key needed to access the network before being allowed to communicate with the DIR-826L.", //IPV6_TEXT13
	"Select the level of WEP Encryption that you would like to use on your network. The two supported levels are 64-bit and 128-bit.", //IPV6_TEXT14
	"The Key Types that are supported by the DIR-826L are HEX (Hexadecimal) and ASCII (American Standard Code for Information Interchange.) The Key Type can be changed to suit an existing wireless network or to customize your wireless network.", //IPV6_TEXT15
	"Keys", //IPV6_TEXT16
	"Keys 1-4 allow you to easily change wireless encryption settings to maintain a secure network. Simply select the specific key to be used for encrypting the network wireless data.", //IPV6_TEXT17
	"Key Type", //IPV6_TEXT18
	"WEP Encryption", //IPV6_TEXT19
	"Wi-Fi Protected Access authorizes and authenticates users coming onto the wireless network. WPA uses stronger security than WEP and is based on a key that changes automatically at regular intervals.", //IPV6_TEXT20
	"%s supports two different cipher types when WPA is used as the Security Type. These two options are TKIP (Temporal Key Integrity Protocol) and AES (Advanced Encryption Standard).", //IPV6_TEXT21
	"PSK/EAP", //IPV6_TEXT22
	"When PSK is selected, your wireless clients will need to provide a Passphrase for authentication. When EAP is selected, you will need to have a RADIUS server on your network which will handle the authentication of all your wireless clients.", //IPV6_TEXT23
	"PARENTAL CONTROL", //DNS_TEXT0
	"This will be needed by your wireless clients in order to communicate with your %m, when PSK is selected. Enter 8 to 63 alphanumeric characters. Be sure to write this Passphrase down as you will need to enter it on any other wireless devices you are trying to add to your network.", //IPV6_TEXT25
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
	"Enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //TA11
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
	"Obtain a DNS server address automatically", //IPV6_TEXT65
	"Obscene", //_aa_bsecure_obscene
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
	"Once your D-Link router is properly configured and this option is enabled, the DHCP Server will manage the IP addresses and other network configuration information for computers and other devices connected to your Local Area Network. There is no need for you to do this yourself.", //help316
	"It is possible for a computer or device that is manually configured to have an IPv6 address that does reside within this range.", //IPV6_TEXT102
	"The amount of time that a computer may have an IPv6 address before it is required to renew the lease.", //IPV6_TEXT103
	"Use Link-Local Address", //IPV6_TEXT104
	"Enable Automatic DHCP-PD in LAN", //IPV6_TEXT108
	"SLAAC + Stateless DHCPv6", //IPV6_TEXT106
	"Autoconfiguration (SLAAC/DHCPv6)", //IPV6_TEXT107
	"Enable Autoconfiguration", //IPV6_TEXT50
	"Enter a password for the user \"user\", who will have read-only access to the Web-based management interface.", //help825
	"IPv6 Internet Connection Setup Wizard", //IPV6_TEXT110
	"Manual IPv6 Internet Connection Setup", //IPV6_TEXT111
	"IPv6 Internet Connection", //IPV6_TEXT112
	"There are two ways to set up your IPv6 Internet connection. You can use the Web-based IPv6 Internet Connection Setup Wizard, or you can manually configure the connection.", //IPV6_TEXT113
	"If you would like to configure the IPv6 Internet settings of your new D-Link Systems Router manually, then click on the button below.", //IPV6_TEXT114
	"Welcome to the D-Link IPv6 internet connection setup wizard", //IPV6_TEXT115
	"This wizard will guide you through a step-by-step process to configure a new connection to the IPv6 Internet.", //IPV6_TEXT116
	"Step 1: Configure your IPv6 Internet Connection", //IPV6_TEXT117
	"Step 2: Save Settings and Connect", //IPV6_TEXT118
	"Router is detecting your IPv6 Interent connection type, please wait ...", //IPV6_TEXT119
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
	"To set up this 6rd tunneling connection you will need to have the following information from your IPv6 Internet Service Provider. If you do not have this information, please contact your ISP.", //IPV6_TEXT131
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
	"AFTR ADDRESS INTERNET CONNECTION TYPE", //IPV6_TEXT146
	"Enable DHCP Server", //bd_EDSv
	"Enter either the IP address of the target computer or enter its fully qualified domain name.", //htsc_pingt_h
	"DS-Lite Configuration", //IPV6_TEXT149
	"DS-Lite DHCPv6 Option", //IPV6_TEXT150
	"AFTR IPv6 Address", //IPV6_TEXT151
	"B4 IPv4 Address", //IPV6_TEXT152
	"IPv6 WAN Default Gateway", //IPV6_TEXT153
	"Please select one of following configuration methods and click next to continue.", //wps_KR37
	"Set static ipv6 address connection", //IPV6_TEXT155
	"The IPv6 Internet Connection Setup Wizard has completed. Click the Connect button to save your settings and reboot the router.", //IPV6_TEXT156
	"SLAAC + RDNSS", //IPV6_TEXT157
	"Destination IPv6/Prefix Length", //IPV6_TEXT158
	"The range of B4 IPv4 Address is from 192.0.0.2 to 192.0.0.7", //IPV6_TEXT159
	"AFTR Address", //IPV6_TEXT160
	"IPv6 PPPoE is share with IPv4 PPPoE. Please change IPv4 WAN protocol at first!", //IPV6_TEXT161
	"6rd is using DHCPv4 option. Please change IPv6 WAN protocol at first!", //IPV6_TEXT162
	"IPv6 wan type should be SLAAC/DHCPv6, PPPoE, Autodetect Mode", //IPV6_TEXT163
	"You can also enable DHCP-PD to delegate prefixes for router in your LAN.", //IPV6_TEXT164
	"All of your IPv6 LAN connection details are displayed here.", //IPV6_TEXT165
	"IPv6 Network assigned by DHCP-PD", //IPV6_TEXT166
	"Parameters for an Application Rule", //haar_p
	"Optional backup RADIUS server", //bws_ORAD
	"SECURITY OPTIONS", //DNS_TEXT2
	"Advanced DNS&#8482;", //DNS_TEXT3
	"Advanced DNS makes your Internet connection safer, faster, smarter and more reliable. It blocks phishing websites to proetct you from identity theft.", //DNS_TEXT4
	"OpenDNS Parental Controls provides award-winning Web content filtering while making your Internet connection safer, faster, smarter and more reliable. With more than 50 content categories to choose from it's effective against adult content, proxies, social networking, phishing sites, malware and more. Fully configurable from anywhere there is Internet access. ", //DNS_TEXT8
	"Automatically block adult and phishing websites while improving the speed and reliability of your Internet connection.", //DNS_TEXT6
	"OpenDNS&reg; FamilyShield&#8482", //DNS_TEXT5
	"Open Systems Interconnection is the reference model for how data should travel between two devices on a network", //help639
	"None: Static IP or Obtain Automatically From ISP", //DNS_TEXT9
	"Use the DNS servers provided by your ISP, or enter your preferred DNS servers.", //DNS_TEXT10
	"Although the Advanced DNS feature is enabled, the DNS IP address of your workstation can still be modified to the DNS server IP you desire. Please note that the router does not dictate the DNS name resolution when the DNS IP address is manually configured on the workstation.", //DNS_TEXT11
	"If you selected this option and have a VPN or an Intranet setup on your network, you can disable the Advanced DNS service if you experience connection difficulties.", //DNS_TEXT12
	"D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME", //TEXT000
	"Stateless Autoconfiguration", //TEXT001
	"Virtual server name %s invalid. Illegal character ',/,''\"", //TEXT002
	"Rules name '+ i +' invalid. Illegal character ',/,''", //TEXT003
	"Host name invalid. Illegal character ',/,''", //TEXT004
	"Local domain name invalid. Illegal character ',/,'", //TEXT005
	"Rules name '+ i +' invalid. Illegal character ',/,''", //TEXT006
	"Port forwarding name %s invalid. Illegal character ',/,''", //TEXT007
	"Rules'+i+' is setting same as Rules'+j+'.", //TEXT008
	"obj_word + \" conflict with another private port.\"", //TEXT010
	"Number Of Wireless Clients", //sw_title_list
	"The Other Protocol Type is invalid", //TEXT011
	"Please choose wireless device with wps!", //TEXT012
	"Inbound filter must be smaller than + rule_max_num", //TEXT013
	"Name cannot be set as the same as default Inbound filter name 'Allow All' or 'Deny All'.", //TEXT014
	"Schedule rules Full! Please Delete an Entry.", //TEXT015
	"First Page", //TEXT016
	"Last Page", //TEXT017
	"Previous", //TEXT018
	"System Activity", //TEXT019
	"Debug Information", //TEXT020
	"Attacks", //TEXT021
	"Dropped Packets", //TEXT022
	"Nothing has changed, save anyway?", //LS3
	"Cannot choose WEP key 2, 3, 4 when WPS is enabled!!", //TEXT024
	"Cannot choose WPA-Personal/TKIP and AES when WPS is enabled!!", //TEXT025
	"Cannot choose WPA-Enterprise when WPS is enabled!!", //TEXT026
	"Cannot choose shared key when WPS is enabled!!", //TEXT027
	"Please Enable Wireless first.", //TEXT028
	"The WPS Function is currently set to disabled. Please click \"Yes\" to enable it or \"No\" to exit the wizard.", //TEXT029
	"The %s cannot allow loopback IP or multicase IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x) entries.", //TEXT030
	"The %s port entered is invalid.", //TEXT031
	"The %s secret entered is invalid.", //TEXT032
	"Reserved IP address", //TEXT033
	"Start IP address", //TEXT035
	"\"End IP address\"", //TEXT036
	"The LAN IP Address and the Start IP Address are not in the same subnet", //TEXT037
	"The LAN IP Address and the End IP Address are not in the same subnet", //TEXT038
	"The Ending IP Address must be greater than the Starting IP Address", //TEXT039
	"The setting has been saved.", //TEXT040
	"The Key \" + i + \" is invalid. The Key must be \" + wep_key_len + \" characters or \" + hex_len + \" hexadecimal number.", //TEXT041
	"Key ' + i + 'is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042
	"%s Gateway IP address %s must be within the WAN subnet.", //TEXT043
	"This firmware is the latest version.", //TEXT045
	"Error contacting the server, please check the Internet connection status.", //TEXT046
	"WAN and LAN IP Address cannot be in the same subnet.", //TEXT047
	"Please enter one machine.", //aa_alert_10
	"You have failed to add the wireless device to your wireless network within the given timeframe, please click on the button below to do it again.", //TEXT049
	"\"IP Address '\"+ res_ip +\"' has already been used.\"", //TEXT050
	"The Confirmed Password does not match the New Password", //TEXT051
	"ALSO CALLED WCN 2.0 IN WINDOW VISTA", //TEXT053
	"obj_word + \" conflict with Application Firewall Port.\"", //TEXT055
	"obj_word + \" conflict with another public port.\"", //TEXT009
	"obj_word + \" conflict with Port Forwarding Port.\"", //TEXT054
	"Port conflict.", //TEXT057
	"TCP Port conflict.", //TEXT058
	"UDP Port conflict.", //TEXT059
	"The Port Forwarding name is already in the list", //TEXT060
	"Do you want to enable the DHCP Reservation entry for IP Address ' + DataArray[idx].IP", //TEXT062
	"The rule is being used by another rule and cannot be deleted.", //TEXT063
	"Schedule Name is invalid. Legal characters are 0~9, A~Z, or a~z.", //TEXT064
	"Schedule Name is the default name.", //TEXT065
	"The Schdule name is already in the list", //TEXT066
	"The rule is being used by another rule and cannot be edited.", //TEXT067
	"IPv6 Network Information", //TEXT068
	"All of your IPv6 Internet and network connection details are displayed on this page.", //TEXT069
	"IPv6 Connection Information", //TEXT070
	"WAN IPv6 Address", //TEXT071
	"LAN IPv6 Computers", //TEXT072
	"Retry", //TEXT073
	"Next", //TEXT074
	"Host Name or IPv6 Address", //TEXT075
	"Try again", //TEXT076
	"PPPoE Session", //TEXT077
	"Create a new session", //TEXT078
	"The 1st address of %s must be an integer.", //MSG002
	"The 2nd address of %s must be an integer.", //MSG003
	"The 3rd address of %s must be an integer.", //MSG004
	"The 4th address of %s must be an integer.", //MSG005
	"The %s is an invalid address.", //MSG006
	"The %s cannot be zero.", //MSG007
	"The %s port entered is invalid.", //MSG008
	"The %s secret entered is invalid", //MSG009
	"The %s can't allow entry to loopback IP or multicast IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
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
	"The page you requested is not available.", //ERROR404
	"Suggestions", //SUGGESTIONS
	"Make sure your internet cable is securely connected to the internet port on your router, and your internet LED is blink green or blue.", //SUGGESTIONS_1
	"Check to make sure that the <a href='http://<% CmoGetCfg('lan_ipaddr',''); %>/'>Internet settings</a> on your router are set correctly, such as your PPPoE username/password settings.", //SUGGESTIONS_2
	"(hour minute)", //tsc_hrmin_1
	"DHCP-PD", //DHCP_PD
	"Enable DHCP-PD", //IPV6_TEXT147
	"IPv6 network assigned <br>by DHCP-PD", //DHCP_PD_ASSIGNED
	"6to4 Relay", //_6to4RELAY
	"Obtain a DNS server address automatically or enter a specific DNS server address.", //IPV6_TEXT64
	"Use the following IPv6 DNS address", //IPV6_TEXT66_v6
	"Changing usb type to Windows Mobile or iPhone or Android Phone will cause the device to reboot.", //usb_reboot
	"Changing usb type to Windows Mobile or iPhone will cause the device to reboot, also will change device IP to 192.168.99.1.", //usb_reboot_chnip
	"Philippine", //country_8
	"Select usb phone", //_select_phone
	"Select the 3G USB phone you used.", //_phone_info
	"3G USB Phone", //usb_3g_phone
	"Windows Mobile 5", //usb_window_mobile_5
	"iPhone 3G(s)", //usb_iphone
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
	"OK", //_ok
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
	"Wi, Wide Area Network", //help740
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
	"Nov", //tt_Nov
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
	"OR, click <em>Next</em> to continue anyway and later choose <em>No</em> when asked if you'd like to print a test page.", //wprn_tt7
	"Legacy", //help599
	"IPX", //help585
	"Sending and Receiving data at the same time", //help530
	"NetBEUI", //help623
	"WLAN", //help758
	"NIC", //help634
	"The larger network that your LAN is connected to, which may be the Internet itself, or a regional or corporate network", //help752
	"Internet Protocol Security", //help575
	"Broadcast", //help450
	"PHYSICAL CONNECTION OF INTERNET PORT IS DISCONNECTED", //ES_CABLELOST_bnr
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
	"Demilitarized Zone. A computer that logically sits in a \"no-mans land\" between the LAN and the WAN. The DMZ computer trades some of the protection of the router's security mechanisms for the convenience of being directly addressable from the Internet.", //help496
	"Bottleneck", //help446
	"Allows you to power up a computer though it's Network Interface Card", //help739
	"Determines what portion of an IP address designates the Network and which part designates the Host", //help627
	"Active Sessions", //_actsess
	"Priority 0 is reserved.", //help91a
	"Flows that are not prioritized by any rule receive lowest priority.", //help91b
	"The common choices can be selected from the drop-down menu.", //help92x1
	"To specify any other protocol, enter its protocol number (<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'>as assigned by the IANA</a>) in the <span class='option'>Protocol</span> box.", //help92x2
	"When a LAN application that uses a protocol other than UDP, TCP, or ICMP initiates a session to the Internet, the router's NAT can track such a session, even though it does not recognize the protocol. This feature is useful because it enables certain applications (most importantly a single VPN connection to a remote host) without the need for an ALG.", //TA21
	"Note that this feature does not apply to the DMZ host (if one is enabled). The DMZ host always handles these kinds of sessions.", //TA22
	"are recommended.", //help183
	"Check this box to allow the DHCP Server to offer NetBIOS configuration settings to the LAN hosts.", //help400_b
	"If NetBIOS advertisement is swicthed on, switching this setting on causes WINS information to be learned from the WAN side, if available.", //help401_b
	"Configure the IP address of the preferred WINS server.", //help402_b
	"ActiveX", //help403
	"Configure the IP address of the backup WINS server, if any.", //help403_b
	"A Microsoft specification for the interaction of software components.", //help404
	"This is an advanced setting and is normally left blank. This allows the configuration of a NetBIOS \"domain\" name under which network hosts operate.", //help404_b
	"Ad-hoc network", //help405
	"Indicates how network hosts are to perform NetBIOS name registration and discovery.", //help405_b
	"Peer configuration error %u", //WIFISC_AP_PEER_CFG_ERR
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
	"Line Printer Requestor/\"Line Printer Daemon\". A TCP/IP protocol for transmitting streams of printer data.", //help603
	"MDI", //help609
	"Medium Dependent Interface is an Ethernet port for a connection to a straight-through cable", //help610
	"MDIX", //help611
	"Medium Dependent Interface Crossover, is an Ethernet port for a connection to a crossover cable", //help612
	"MIB", //help613
	"Management Information Base is a set of objects that can be managed by using SNMP", //help614
	"Modem", //help615
	"A device that Modulates digital signals from a computer to an analog signal in order to transmit the signal over phone lines. It also Demodulates the analog signals coming from the phone lines to digital signals for your computer", //help616
	"Oct", //tt_Oct
	"Originator", //sa_Originator
	"Orthogonal Frequency-Division Multiplexing is the modulation technique for both 802.11a and 802.11g", //help637
	"Open Shortest Path First is a routing protocol that is used more than RIP in larger scale networks because only changes to the routing table are sent to all the other routers in the network as opposed to sending the entire routing table at a regular interval, which is how RIP functions", //help641
	"OSI", //help638
	"Open mode configuration is not secure", //msg_non_sec
	"Personal", //LW24
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
	"OpenDNS&reg; Parental Controls&#8482", //DNS_TEXT7
	"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href=\"Inbound_Filter.asp\" onclick=\"return jump_if();\">Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.", //help831_1
	"Options to improve the speed and reliability of your Internet connection, to apply content filtering and to protect you from phishing sites. Choose from pre-configured bundles or register your router with OpenDNS&reg; to choose from 50 content categories for custom blocking.", //DNS_TEXT1
	"Add/Edit Schedule Rule", //help191
	"Saves the new or edited Schedule Rule in the following list. When finished updating the Schedule Rules, you must still click the <span class='button_ref'>Save Settings</span> button at the top of the page to make the changes effective and permanent.", //help198
	"Unknown (Please wait...)", //_unknown_wait
	"Unknown", //_unknown
	"N/A", //_na
	"No computer information yet.", //_sdi_nciy
	"DHCP Client", //_sdi_dhcpclient
	"BigPond Client", //_sdi_bpc
	"Older devices or technology", //help600
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
	"The Routing Status menu shows information about the routes that have been enabled on your router. The list will display the destination IP address, gateway IP address, subnet mask, metric and interface for each route.", //sr_intro
	"Network Traffic Stats", //ss_title_stats
	"Associated Wireless Client List", //sw_title
	"Invalid value for Admin Idle Timeout, should be in range (1..65535)", //ta_alert_1
	"Please make sure the cable between the ADSL/cable modem and the router is properly connected. The router will try to detect your Internet connection type again.", //ES_CABLELOST_dsc1
	"Please make the two passwords the same and try again", //_pwsame
	"Invalid remote management port '+data.wan_web_port+', should be in range (1..65535)", //ta_alert_3
	"The specified Dynamic DNS Service Provider is not supported", //_invalidddnsserver
	"The specified Server Address is blank", //_blankddnsserver
	"Please change IPv6 WAN protocol first!", //IPV6_TEXT1
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
	" The SMTP Server Address' + data.smtp_email_server_addr + ' is not valid.", //_invalidsmtpserveraddr
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
	"No day is selected for schedule name '+(data.sched_table[i].sched_name)+'", //tsc_alert_1
	"Invalid Time", //tsc_alert_2
	"\"The schedule name '\"+(data.sched_table[i].sched_name)+\"' is reserved and can not be used\"", //tsc_alert_3
	"This schedule is already used", //tsc_alert_6
	"There is no room for any more entries", //tsc_alert_9
	"Select Day(s)", //tsc_SelDays
	"Time Frame", //tsc_TimeFr
	"Syslog server IP address should not be same as Gateway IP address", //tsl_alert_3
	"Syslog server IP address is in WAN subnet, it should be within LAN subnet (+lan_subnet+)", //tsl_alert_1
	"Syslog server IP address should be within LAN subnet (+lan_subnet+)", //tsl_alert_2
	"Once your router is configured the way you want it, you can save the configuration settings to a configuration file.", //ZM18
	"milliseconds. TTL =", //tsc_pingt_msg9
	"NTP", //help635
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
	"Invalid PPTP gateway IP address", //_badPPTPgwip
	"Invalid PPTP Server address", //wwa_pv5_alert_15
	"Invalid L2TP gateway IP address", //_badL2TPgwip
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
	"PalTalk", //YM47
	"Select BigPond Server", //gw_SelBPS
	"Name1", //gw_bp_0
	"Name2", //gw_bp_1
	"Name3", //gw_bp_2
	"PlayStation2", //gw_gm_81
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
	"Offer received for %s PPPoE Session, service offered is %s from %s (%m)", //GW_PPPOE_EVENT_OFFER
	"Unplugged", //psUnplugged
	"Printing", //psPrinting
	"PAP sent authentication \"%s\" response to remote peer.", //IPPPPPAP_AUTH_RESULT
	"'The string \"' + value + '\" is too long\n(maximum length is ' + length + ' characters).'", //up_gS_1
	"The number ' + value + ' is not valid.", //up_gIUH_1
	"The number ' + value + ' must be positive.", //up_gIUH_2
	"The number ' + value + ' should be in between '+ min + ' to ' + max + '.", //up_gIUH_3
	"The hex string ' + value + ' is not valid.", //up_gH_1
	"There is no room for any more entries.", //up_ae_se_1
	"The '%s' field can not be blank", //up_ai_se_2
	"this.primary_key_name+'+ this.thearray[-1][this.primary_key] +' is already used", //up_ae_se_3
	"You have unsaved changes in the entry you are editing.", //up_ae_wic_1
	"Press \"Ok\" to abandon these changes and perform the requested action.", //up_ae_wic_2
	"Note:<br />When DNS Relay is enabled along with Advanced DNS feature, your workstations on the network that are obtaining an IP address from router's DHCP server will obtain 192.168.0.1 (router's IP address). However, traffic will still be protected.", //_Advanced_02
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
	"An error occurred on this page. This might be because you are\n+ \not properly logged in, for example just after a reboot.\n", //up_he_1
	"Press OK to go to the login page, or Cancel if you want to see\n+ the error message.", //up_he_2
	"\"The error on line \"+line+\" of \"+url+\" is:\n\"\"+msg+\"\".\"", //up_he_5
	"PalTalk", //gw_sa_5
	"Blocked packet from %v to %v that was received from the wrong network interface (IP address spoofing)", //IPSTACK_REJECTED_SPOOFED_PACKET
	"Lease assignment attempt fail - detected a LAN host active with address %v and MAC of %m", //IPDHCPSERVER_HOST_IS_ACTIVE
	"%S service authorization failed: service is unregistered", //BSECURE_LOG_AUTH_FAIL_UNREG
	"Estimated rate of link is %d kbps", //RATE_ESTIMATOR_RATE_IS
	"Filter - Denied packet from IP address %v port %u, protocol %u, to %v port %u", //GW_IPFILTER_DENY
	"Unable to create connection to email server", //GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION
	"Dropped packet to illegal destination %v from %v", //IPNAT_ILLEGAL_DEST
	"%S filter server disconnected timeout", //BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT
	"The client %02x%02x%02x%02x%02x%02x had its lease (%v) revoked.", //IPDHCPSERVER_LEASE_REVOKED1
	"Previous message repeated 1 time", //LOG_PREV_MSG_REPEATED_1_TIME
	"UPnP changed VS entry %v <-> %v:%d <-> %v:%d %s to %s", //GW_UPNP_PORTMAP_VS_CHANGE
	"Lease expired %v", //IPDHCPSERVER_LEASE_EXPIRED
	"%S service authorization failed: internal error", //BSECURE_LOG_AUTH_FAIL_INTNL
	"UPnP deleted entry %v <-> %v:%d %s", //GW_UPNP_PORTMAP_DEL
	"Unable to send email as \"%s\" is not a valid \"To:\" address", //GW_SMTP_EMAIL_INVALID_TO_ADDRESS
	"%S filter server disconnected closed", //BSECURE_LOG_FLTR_DISCONNECTED_CLOSED
	"Lease expired %v - was reassigned because a client specifically requested this address", //IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC
	"%S service authorization passed", //BSECURE_LOG_AUTH_PASS
	"%S service authorization failed: auth server returned UNKNOWN error", //BSECURE_LOG_AUTH_FAIL_UNKNW
	"PAP only", //wwan_auth_pap
	"%S service authorization failed: service needs renewal", //BSECURE_LOG_AUTH_FAIL_RENEW
	"Client %m wanted specific address (%v) but it is not available", //IPDHCPSERVER_LEASE_DENIED
	"Unable to send email (connection timed out)", //GW_SMTP_EMAIL_TIMEOUT
	"%S service authorization failed: auth server returned DB error", //BSECURE_LOG_AUTH_FAIL_DB
	"DHCP Server Parameter %u was updated", //IPDHCPSERVER_PARAM_DB_UPDATED
	"Application Rules", //APP_RULES
	"Lease table full", //IPDHCPSERVER_LEASE_POOL_FULL
	"PAP authentication successful.", //IPPPPPAP_AUTH_SUCCESS
	"Advanced Networks", //ADVANCED_NETWORKS
	"Assigned new lease %v to client %m", //IPDHCPSERVER_LEASE_ASSIGNED
	"%S filter server connected", //BSECURE_LOG_FLTR_CONNECTED
	"%S auth server connected", //BSECURE_LOG_AUTH_CONNECTED
	"%S service authorization failed: auth response packet corrupted", //BSECURE_LOG_AUTH_FAIL_PKT
	"SMTP client failed to connect to server %v", //IPSMTPCLIENT_CONN_FAILED
	"PAP authentication failed - please check login details.", //IPPPPPAP_AUTH_FAIL
	"Latest firmware version retrieved from the server was %d.%d", //GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED
	"Unable to send email (send status %u)", //GW_SMTP_EMAIL_SEND_FAILURE
	"Lease %v released by client %m", //IPDHCPSERVER_LEASE_RELEASED
	"DHCP Server Parameter %u was added to the parameter database", //IPDHCPSERVER_PARAM_DB_ADDED
	"PAP authentication timed out - authentication failed.", //IPPPPPAP_AUTH_TIMEOUT
	"UPnP added entry %v <-> %v%d <-> %v%d %s timeout%d '%s'", //GW_UPNP_PORTMAP_ADD
	"Unable to send email as server IP address is not known", //GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS
	"UPnP renew entry %v <-> %v:%d <-> %v:%d %s timeout:%d '%s'", //GW_UPNP_PORTMAP_REFRESH
	"UPnP expired entry %v <-> %v:%d <-> %v%d %s '%s'", //GW_UPNP_PORTMAP_EXPIRE
	"DHCP Server Parameter %u was removed from the parameter database", //IPDHCPSERVER_PARAM_DB_REMOVED
	"Lease was deleted from server pool %v", //IPDHCPSERVER_LEASE_DELETED
	"UPnP conflict with existing entry %v <-> %v:%d <-> %v:%d %S '%s'", //GW_UPNP_PORTMAP_CONFLICT
	"Not all of the needed components have been loaded; this page will refresh.", //TA1
	"is not a valid IP address", //aa_alert_11
	"This Access Control rule is already defined by the Policy  + data.access_ctrl_table[i].policy_name", //aa_alert_1
	"There are ' + unsaved_policies + ' unsaved policies, do you want to abandon these policies.", //aa_sched_conf_3
	"'The Port Filter rule \"' + data.access_ctrl_table[-1].port_filter_table[i].entry_name + '\" is duplicated.'", //aa_alert_16
	"Destination IP Start address for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be in LAN subnet ('+lan_subnet+')", //aa_alert_2
	"Destination IP End address for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be in LAN subnet ('+lan_subnet+')", //aa_alert_3
	"Invalid destination IP address range for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'", //aa_alert_4
	"Invalid destination port range for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should be in range (1..65535)", //aa_alert_5
	"Destination start port for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be greater than destination end port", //aa_alert_6
	"Other Machines", //_aa_other_machines
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"The valid range for fragmentation threshold is 256..65535", //aw_alert_1
	"The valid range for RTS threshold is 1..65535", //aw_alert_2
	"The valid range for beacon period is 20..1000", //aw_alert_3
	"The valid range for DTIM interval is 1..255", //aw_alert_4
	"DMZ address should be within LAN subnet (+lan_subnet+')", //af_alert_1
	"DMZ Address is not allowed", //af_alert_2
	"(automatically disabled if UPnP is enabled)", //TA19
	"This '+ data.game_rules[j].entry_name + ' record is already present.", //ag_alert_4
	"This '+ data.game_rules[j].entry_name + ' record is duplicate of '' + data.game_rules[i].entry_name + ''.", //ag_alert_5
	"'TCP ports ['+data.game_rules[i].tcp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' TCP ports ['+data.game_rules[j].tcp_ports_to_open+']'", //ag_conflict10
	"'UDP ports ['+data.game_rules[i].udp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' UDP ports ['+data.game_rules[j].udp_ports_to_open+']'", //ag_conflict20
	"Please select a schedule for record ' + data.game_rules[i].entry_name + ''.'", //ag_conflict21
	"IP address for '+data.game_rules[i].entry_name+'' should be within LAN subnet ('+lan_subnet+')'", //ag_alert_1
	"IP Address for '+data.game_rules[i].entry_name+'' is not allowed'", //ag_alert_3
	"Both 'TCP Ports to Open' and 'UDP Ports to Open' fields can not be blank", //ag_alert2
	"TCP ports", //_tcpports
	"UDP ports", //_udpports
	"%s ports[%s] conflicts with Remote Management Port", //ag_conflict4
	"You can not change name of this entry because it is used on the '+used_page+' page.", //tsc_alert_7
	"Invalid source IP Range for '+data.ingress_rules[i].ingress_filter_name+'+' ('+data.ingress_rules[i].ip_range_table[j].ip_start+', +data.ingress_rules[i].ip_range_table[j].ip_end+)'", //ai_alert_3
	"Enable at least one Source IP Range for '%s'", //GW_FIREWALL_NO_IP_RANGE_INVALID
	"The inbound filter range '%s - %s' is duplicated.", //ai_alert_7
	"The inbound filter name '+(data.ingress_rules[i].ingress_filter_name)+'' is reserved and can not be used'", //ai_alert_4
	"'The inbound filter rule \"' + data.ingress_rules[-1].ingress_filter_name + '\" is duplicated.'", //ai_alert_6
	"You can not delete this entry because it is used on the +x+ page.", //tsc_alert_5
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
	"The Application Rules name ' + saved_records[i].entry_name + ' is duplicated.", //ag_alert_duplicate_name
	"The Application Rules name ' + saved_records[j].entry_name + ' is duplicate of ' + saved_records[i].entry_name + '", //ag_alert_duplicate
	"This Rule is already used", //ag_inuse
	"Trigger port range '+protocols[ae.thearray[-1].trigger_ports.protocol]+' ['+ae.thearray[-1].trigger_ports.port_range+'] conflicts with '+saved_records[i].entry_name+':'+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+']'", //_specapps_alert_2
	"Trigger port range", //_specapps_tpr
	"Input port range", //_specapps_ipr
	"Special Applications Rule", //as_title_SAR
	"Trigger Port Range", //as_TPRange
	"ex.", //as_ex
	"Trigger Protocol", //as_TPR
	"Input Port Range", //as_IPR
	"Input Protocol", //as_IPrt
	"Max transmission rate should be between 8 kbps and 10 Mbps, inclusive.", //at_alert_1_1
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
	"Name ''+data.qos_rules[i].entry_name+'' is already used.'", //at_alert_22
	"'Source/Destination IP Range for \"'+data.qos_rules[j].entry_name+'\" is overlapped with \"'+data.qos_rules[i].entry_name+'\".'", //at_alert_23
	"'Source/Destination IP/Port Range for \"'+data.qos_rules[j].entry_name+'\" is overlapped with \"'+data.qos_rules[i].entry_name+'\".'", //at_alert_24
	"'Protocol \"ANY\" includes ICMP so port ranges are disabled. Select TCP or UDP if you want to configure port ranges.'", //at_alert_14
	"ANY", //at_Prot_0
	"Source Port Range", //_srcport
	"Destination IP Range", //at_DIPR
	"Destination Port Range", //at_DPR
	"The record ' + data.virtual_servers[i].entry_name + ' is duplicated.", //av_alert_11
	"The record ' + data.virtual_servers[j].entry_name + ' is duplicate of ' + data.virtual_servers[i].entry_name + '.", //av_alert_21
	"Please select a schedule for record ' + data.virtual_servers[i].entry_name + '.", //av_alert_24
	"IP address for ' + data.virtual_servers[i].entry_name + ' should be within LAN subnet ('+lan_subnet+')", //av_alert_1
	"IP address for ' + data.virtual_servers[i].entry_name + ' is not allowed", //av_alert_2
	"Private port for ' + data.virtual_servers[i].entry_name + ' should be in range (1..65535)", //av_alert_3
	"Public port for ' + data.virtual_servers[i].entry_name + ' should be in range (1..65535)", //av_alert_4
	"Public port should not be same as Remote Management Port", //av_alert_12
	"Cannot create an entry for ICMP (protocol 1) as this will prevent the router from working correctly", //av_alert_18
	"Cannot create an entry for IGMP (protocol 2) as this will prevent the router from working correctly", //av_alert_23
	"Please select TCP instead of protocol 6 and specify port details", //av_alert_19
	"Please select UDP instead of protocol 17 and specify port details", //av_alert_20
	"Other protocol for ' + data.virtual_servers[i].entry_name + ' should be in range (3..5, 7..16 or 18..255)", //av_alert_13
	"Protocol for ' + data.virtual_servers[i].entry_name + ' is overlapped with ' + data.virtual_servers[j].entry_name+'", //av_alert_17
	"Ports for ' + data.virtual_servers[i].entry_name + ' are overlapped with ' + data.virtual_servers[j].entry_name+'", //av_alert_5
	"Private Port for '\" + data.virtual_servers[i].entry_name + \"' conflicts with '\" + data.virtual_servers[j].entry_name+\"'", //av_alert_6
	"FTP ALG has been enabled", //av_alert_7
	"PPTP ALG has been enabled", //av_alert_8
	"Wake-On-LAN ALG has been enabled", //av_alert_9
	"H.323 ALG has been enabled", //av_alert_10
	"Public", //_public
	"Other", //at_Prot__1
	"Private", //_private
	"Web Site", //aa_WebSite
	"https is not a supported protocol.", //awf_alert_4
	"The web site address '%s' already used.", //awf_alert_5
	"The web site addresses ' + invalid_wf_str + ' are invalid.", //awf_alert_7
	"The web site address ' + invalid_wf_str + ' is invalid.", //awf_alert_8
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
	"The DHCP address range TO is not in the LAN subnet.", //bd_alert_11
	"The DHCP FROM address does not contain a valid host starting value.", //bd_alert_1
	"The DHCP address range should go from a low address to a high address, not high to low", //bd_alert_3
	"The DHCP address range must not include the subnet broadcast address.", //bd_alert_13
	"The number of IP addresses in the range exceeds a limit of 256.", //bd_alert_12
	"DHCP Lease Time can not be 0", //bd_alert_5
	"Reserved IP address for this MAC address ('+ae.thearray[-1].mac_addr+') is already set", //bd_alert_6
	"Reserved IP address for this Computer Name ('+ae.thearray[-1].comp_name+') is already set", //bd_alert_7
	"A reservation cannot be the same as the configured LAN IP Address.", //TA20
	"Reserved IP address should be within the configured DHCP range.", //bd_alert_8
	"Must specify primary DNS server before supplying a secondary DNS server", //bd_alert_22
	"Invalid Primary dns IP address", //bd_alert_23
	"Invalid Secondary dns IP address", //bd_alert_24
	"Invalid WAN IP address", //_badWANIP
	"Invalid WAN subnet mask", //bwn_alert_2
	"The default gateway address is not in the WAN subnet", //bwn_alert_3
	"DNS are not configured. The clients will not be able to resolve domain names. Proceed ?", //bwn_alert_4
	"WAN subnet conflicts with LAN subnet", //bwn_alert_5
	"Please enter a Trigger Port number", //MSG000
	"The maximum idle time should be in the range 0..600", //bwn_alert_8
	"Invalid PPPoE IP address", //bwn_alert_12
	"Invalid PPTP IP address", //_badPPTPip
	"Invalid PPTP subnet mask", //_badPPTPsub
	"The PPTP gateway IP address is not in the PPTP subnet", //_badPPTPipsub
	"Invalid PPTP server IP address", //bwn_alert_11
	"Invalid L2TP address", //_badL2TP3
	"Invalid L2TP subnet mask", //_badL2TP
	"The L2TP gateway IP address is not in the L2TP subnet", //_badL2TP2
	"Invalid L2TP server IP address", //bwn_alert_17
	"The MTU should be in the range 128..30000", //bwn_alert_21
	"WEP Keys '+ wep_error_msg + ' are invalid.", //bws_alert_15
	"WEP Key '+ wep_error_msg + ' is invalid.", //bws_alert_16
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
	"WEP key' +(i+1)+' must be '+len+' characters long", //bws_alert_3
	"Uncheck \"Auto Channel Select\" for WDS mode.", //aw_alert_5_1
	"The IP address ' + data.wireless.radius_server_address + ' is not valid.", //bwl_alert_13
	"The IP address ' + data.wireless.second_radius_server_address + ' is not valid.", //bwl_alert_14
	"802.11g only", //bwl_Mode_2
	"Mixed 802.11g and 802.11b", //bwl_Mode_3
	"802.11b only", //bwl_Mode_1
	"802.11n only", //bwl_Mode_8
	"Mixed 802.11n, 802.11g and 802.11b", //bwl_Mode_11
	"20 MHz", //bwl_ht20
	"Auto 20/40 MHz", //bwl_ht2040
	"Best (automatic)", //bwl_TxR_0
	"Changing your Wireless Network Name is the first step in securing your wireless network. Change it to a familiar name that does not contain any personal information.", //TA9
	"Enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.", //YM124
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
	"The rule name can not be empty.", //ag_alert_empty_name
	"The rule name ' + data.game_rules[j].entry_name + '' is duplicated.'", //ag_alert_duplicate_name2
	"'MAC Address Filter allows no machines. This is not allowed because it locks out all machines.'", //amaf_alert_2
	"The rule name ' + saved_records[i].entry_name + '' is duplicated.'", //specapps_alert_duplicate_name
	"\"The rule '\" + saved_records[j].entry_name + \"' is duplicate of '\" + saved_records[i].entry_name + \"'.\"", //specapps_alert_duplicate1
	"Trigger port range of '+saved_records[i].entry_name+'' '+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+'] conflicts with ''+saved_records[j].entry_name+'' '+protocols[saved_records[j].trigger_ports.protocol]+' ['+saved_records[j].trigger_ports.port_range+'].'", //specapps_alert_conflict1
	"Please select a schedule for rule ' + data.port_trigger_rules[i].entry_name + ''.'", //specapps_alert_empty_schedule
	"Traffic Shaping Setup", //at_title_TSSet
	"Protocol \" + entry_1.user_protocol + \" of '\" + entry_1.entry_name + \"' conflicts with '\" + entry_2.entry_name + \"'", //av_alert_35
	"The 'Name' field can not be blank", //av_alert_empty_name
	"Name '%s' is already used", //av_alert_16
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
	"Once a LAN-side application has created a connection through a specific port, the NAT will forward any incoming connection requests with the same port to the LAN-side application regardless of their origin. This is the least restrictive option, giving the best connectivity and allowing some applications (P2P applications in particular) to behave almost as if they are directly connected to the Internet.", //YM134
	"The NAT forwards incoming connection requests to a LAN-side host only when they come from the same IP address with which a connection was established. This allows the remote application to send data back through a port different from the one used when the outgoing session was created.", //af_EFT_h1
	"The NAT does not forward any incoming connection requests with the same port address as an already establish connection.", //af_EFT_h2
	"Note that some of these options can interact with other port restrictions. Endpoint Independent Filtering takes priority over inbound filters or schedules, so it is possible for an incoming session request related to an outgoing session to enter through a port in spite of an active inbound filter on that port. However, packets will be rejected as expected when sent to blocked ports (whether blocked by schedule or by inbound filter) for which there are no active sessions. Port and Address Restricted Filtering ensures that inbound filters and schedules work precisely, but prevents some level of connectivity, and therefore might require the use of port triggers, virtual servers, or port forwarding to open the ports needed by the application. Address Restricted Filtering gives a compromise position, which avoids problems when communicating with certain other types of NAT router (symmetric NATs in particular) but leaves inbound filters and scheduled access working as expected.", //af_EFT_h5
	"Controls endpoint filtering for packets of the UDP protocol.", //af_UEFT_h1
	"Controls endpoint filtering for packets of the TCP protocol.", //af_TEFT_h2
	"The subnet mask of the local area network.", //help309A
	"NetBIOS allow LAN hosts to discover all other computers within the network, e.g. within Network Neighbourhood.", //help400_1
	"Turn this setting off to configure manually.", //help401_1
	"WINS Servers store information regarding network hosts, allowing hosts to \"register\" themselves as well as discover other available hosts, e.g. for use in Network Neighbourhood.", //help402_1
	"This setting has no effect if the \"Learn NetBIOS information from WAN\" is activated.", //help402_2
	"H-Node, this indicates a Hybrid-State of operation. First WINS servers are tried, if any, followed by local network broadcast. This is generally the preferred mode if you have configured WINS servers.", //help405_1
	"M-Node (default), this indicates a Mixed-Mode of operation. First Broadcast operation is performed to register hosts and discover other hosts, if broadcast operation fails, WINS servers are tried, if any. This mode favours broadcast operation which may be preferred if WINS servers are reachable by a slow network link and the majority of network services such as servers and printers are local to the LAN.", //help405_2
	"P-Node, this indicates to use WINS servers ONLY. This setting is useful to force all NetBIOS operation to the configured WINS servers. You must have configured at least the primary WINS server IP to point to a working WINS server.", //help405_3
	"B-Node, this indicates to use local network broadcast ONLY. This setting is useful where there are no WINS servers available, however, it is preferred you try M-Node operation first.", //help405_4
	" Incorrectly configured - check logs", //_sdi_s1a
	"Invalid secure remote management port '+data.web_server_wan_port_https+', should be in range (1..65535)", //ta_alert_3b
	"Secure remote management port and remote management port may not be the same.", //ta_alert_3c
	"You must enable one method of management.", //ta_alert_3d
	"Invalid management port '+data.web_server_lan_port_http+', should be in range (1..65535)", //ta_alert_3e
	"Invalid secure management port '+data.web_server_lan_port_https+', should be in range (1..65535)", //ta_alert_3f
	"Secure management port and management port may not be the same.", //ta_alert_3g
	"Enable LPD/LPR Printing", //tps_enlpd
	"Admin Port", //ta_LMAP
	"Failed Login", //fb_FailLogin
	"Access to this device is not allowed without a correct password.", //fb_FailLogin_1
	"Open", //_open
	"Other", //_other
	"Expire Time", //_223
	"The gateway address is not in the LAN subnet", //_225ap
	"IP address or subnet mask is badly formatted", //_226ap
	"This entry is optional. Enter a domain name for the local network. Your LAN computer will assume this domain name when it gets an address from the <span>rou</span><span>ter</span>'s built in DHCP server. So, for example, if you enter <code>mynetwork.net</code> here, and you have a LAN side laptop with a name of <code>chris</code>, that laptop will be known as <code>chris.mynetwork.net</code>.", //_1044wired
	"Note, however, the entered domain name can be overridden by the one obtained from the <span>rou</span><span>ter</span>'s upstream DHCP server.", //_1044awired
	"IPv6 address", //TEXT0
	"Regenerate", //regenerate
	"Advanced DNS Service", //_title_AdvDns
	"Advanced DNS is a free security option that provides Anti-Phishing to protect your Internet connection from fraud and navigation improvements such as auto-correction of common URL typos.", //_desc_AdvDns
	"Enable Advanced DNS Service", //ta_EUPNP_dns
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
	"Enable Advanced DNS Service", //_en_AdvDns
	"XKJS Supported", //xkjs_support
	"Service type", //ddns_serv_type
	"Domain", //ddns_domain
	"DDNS account test", //ddns_account
	"Invalid public port", //virtual_pub_port_err
	"Invalid private port", //virtual_pri_port_err
	"Invalid protocol number", //virtual_proto_num_err
	"Wi-Fi Protected Setup", //menu_wps
	"IP Range", //tc_iprange
	"Opening or closing TCP connections.", //help823_15
	"bandwidth(kbps)", //tc_bw
	"Schedule", //tc_schedule
	"New Schedule", //tc_new_sch
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
	"Phone Type", //_phone
	"Please fulfill the options to complete the registration.", //mydlink_tx10
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
	"Please configure your WWAN settings.  If you are unsure of the settings, please contact your Internet Service Provider (ISP).", //usb_config1
	"Easy Setup", //ES_NAME
	"Please enter user name", //MSG011
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
	"Port range should be set between 1 and 65535.", //ac_alert_invalid_port
	"Duplicated name:", //ac_alert_dup_name
	"Port conflict.", //ac_alert_port_conflit
	"Policy cannot be null.", //ac_alert_policy_null
	"Please check the configured Server Address", //tt_alert_checkdyndns
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
	"Remove Language Pack", //clear_lang_pack
	"Current Language Pack Version", //current_lang_pack_version
	"Current Language Pack Date", //current_lang_pack_date
	"Language pack Upgrade", //lang_package_info
	"Upgrade language pack will change the language displayed on web site.", //lang_package_note1
	"To upgrade the language pack, locate the upgrade file on the local hard drive with Browse button. Once you have found the file to be used, click the Upload button to start the language pack upgrade.", //lang_package_note2
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
	"Enable Traffic Shaping", //at_ETS
	"When True Gigabit Routing Connectivity is enabled, SPI and QoS engine will be disabled automatically. Would you like to proceed?", //alert_hw_nat_1
	"When QoS engine is enabled, True Gigabit Routing Connectivity will be disabled automatically. Would you like to proceed?", //alert_hw_nat_2
	"When SPI is enabled, True Gigabit Routing Connectivity will be disabled automatically. Would you like to proceed?", //alert_hw_nat_3
	"When this option is enabled, True Gigabit Routing Connectivity will be disabled automatically.", //help_auto_disable_hw_nat
	" and True Gigabit Routing Connectivity will be disabled automatically.", //help_auto_disable_hw_nat_1
	"True Gigabit Routing Connectivity:", //help_hw_nat
	"When this option is enabled, the router will speed up the NAT/Routing performance by hardware acceleration mechanism. The limitation is that both of SPI and QoS engine will be disabled automatically when True Gigabit Routing Connectivity is enabled.", //help_hw_nat_desc
	"Step 2: Configure your Wi-Fi Security", //ES_step_wifi_security
	"Please make the two user passwords the same and try again", //_pwsame_user
	"Try again", //ES_btn_try_again
	"Router is detecting your Internet connection type, please wait ...", //ES_auto_detect_desc
	"Router is unable to detect your Internet connection type", //ES_auto_detect_failed_desc
	"Guide me through the Internet connection settings", //ES_btn_guide_me
	"Note: All D-Link wireless adapters currently support WPA.", //ES_note_support_wpa
	"Save & Connect", //ES_btn_save_conn
	"Save", //ES_btn_save
	"Do you want to bookmark \"D-Link Router Web Management\"?", //ES_bookmark
	"IPv6 Routing", //v6_routing
	"IPv6 Routing Table", //v6_routing_table
	"The Routing Status menu shows information about the routes that have been enabled on your router. The list will display the destination IP address, gateway IP address, subnet mask, metric and interface for each route.", //v6_routing_info
	"IPv6", //ipv6
	"IPv6 FIREWALL", //ipv6_firewall
	"Remaining number of firewall rules that can be configured:", //ipv6_firewall_info
	"6RD SETTINGS", //_6rd_settings
	"IPv4 Address", //ipv4_addr
	"Mask Length", //mask_len
	"IPv6 ULA Settings", //IPV6_ULA_TEXT01
	"Enable True Gigabit Routing Connectivity", //HW_NAT_enable
	"Use default ULA prefix", //IPV6_ULA_TEXT03
	"ULA Prefix", //IPV6_ULA_TEXT04
	"Current IPv6 ULA Settings", //IPV6_ULA_TEXT05
	"Current ULA Prefix", //IPV6_ULA_TEXT06
	"LAN IPv6 ULA", //IPV6_ULA_TEXT07
	"LAN IPv6 Unique Local Address", //IPV6_ULA_TEXT08
	"Manual IPv6 Local Connectivity Setup", //IPV6_ULA_TEXT09
	"If you would like to configure the IPv6 local connectivity settings of your D-Link Router, then click on the button below.", //IPV6_ULA_TEXT10
	"Use this section to configure Unique Local IPv6 Unicast Addresses(ULA) settings for your router. ULA is intended for local communications and not expected to be routable on the global Internet.", //IPV6_ULA_TEXT11
	"IPv6 Local Connectivity Settings", //IPV6_ULA_TEXT12
	"ULA is useful for Local IPv6 communications, if you would like to enable it, click <b>Enable ULA</b>. By default ULA is disabled.", //IPV6_ULA_TEXT13
	"IPv6 LOCAL CONNECTIVITY SETTINGS ", //IPV6_ULA_TEXT14
	"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new D-Link Systems Router to the IPv6 Internet, click on the button below.", //LW27_v6
	"If you would like to configure the IPv6 Internet settings of your new D-Link Systems Router manually, then click on the button below.", //LW29_v6
	"LAN IPv6 address for local IPv6 communicatoins.", //IPv6_Local_Info
	"IPv6 SIMPLE SECURITY", //IPv6_Simple_Security
	"Enable IPv6 Multicast Streams", //anet_multicast_enable_v6
	"Set up 6rd tunneling connection", //IPv6_Wizard_6rd_title
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
	"802.11n only", //bwl_Mode_n
	"802.11a only", //bwl_Mode_a
	"Mixed 802.11n and 802.11a", //bwl_Mode_5
	"The schedule of Guest Zone must be within the schedule of main WLAN.", //MSG049
	"The GuestZone WLAN will be disabled when you turn off main WLAN. Are you sure to continue?", //MSG050
	"Hardware init error", //HWerr
	"Storage", //storage
	"Share Port Web Access allows you to use a web browser to access files stored on an USB storage drive plugged into the router. To use this feature, check the <strong>Enable SharePort Web Access</strong> checkbox, then create user accounts to manage access to your storage devices or use the Guest account (guest/guest) to access the Guest Folder. After plugging in an USB storage drive, the new device will appear in the list with a link to it. You can then use this link to connect to the drive and log in with a user account.", //sto_into
	"SHAREPORT WEB ACCESS", //sto_http_0
	"Enable WAN Ping Respond", //bwn_RPing
	"Enable Guest Zone", //guestzone_enable
	"HTTP Access Port", //sto_http_3
	"Enable HTTPS Server", //LV2
	"HTTPS Access Port", //sto_http_5
	"10 -- USER CREATION", //sto_creat
	"Add/Edit", //_add_edit
	"User List", //sto_list
	"Modify", //_modify
	"Access Path", //sto_path
	"Performance enhancing features such as Packet Bursting, FastFrames, and Compression.", //help361
	"NTP Server Used", //tt_NTPSrvU
	"Device", //sto_dev
	"Total Space", //_total_space
	"Free Space", //_free_space
	"SHAREPORT WEB ACCESS LINK", //sto_link_0
	"You can use this link to connect to the drive remotely after logging with a user account.", //sto_link_1
	"http://&lt;DDNS&gt; or&lt;WAN IP Address&gt;:8181", //sto_link_2
	"Email Now", //_email_now
	"The Storage page contains information about the USB storage drives or SD cards currently plugged in to the device.", //sto_help
	"Device Link", //_DevLink
	"Folder", //_folder
	"Browse", //_browse
	"Append", //_append
	"Remote Access Port & Remote HTTPS Port is Empty!!!", //sto_01
	"The confirmed password does not match the new User password", //sto_02
	"Read Only", //_readonly
	"Read/Write", //_readwrite
	"Append New Folder", //_AppendNewFolder
	"Please push button on your wireless device, then click on the Connect button below.", //KR45
	"This account has reached the maximum rule", //MSG052
	"This rule already exists", //MSG053
	"Can't find this rule, please press the Append button", //MSG054
	"Add New Folder", //_AddFolder
	"http://&lt;DDNS&gt; or &lt;WAN IP Address&gt;", //_StorageLink
	"Lock WPS-PIN Setup", //LW6_1
	"The maximum number of users", //MSG055
	"mydlink Registration", //ES_title_s6
	"Step 5: Confirm WI-FI Settiongs", //ES_title_s5_0
	"Saving System", //save_settings
	"Your settings are being saved.", //save_wait
	"Registering your product with mydlink will allow you to use its mydlink-enabled features, including online access and management of your device through the mydlink website.", //mydlink_tx01
	"Would you like to register your device with mydlink?", //mydlink_tx02
	"Language", //_Language
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"ATAT DSL Service", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Earthlink Cable", //manul_conn_10
	"Earthlink DSL", //manul_conn_11
	"FrontierNet", //manul_conn_12
	"Opinion", //_aa_bsecure_opinion
	"RCN", //manul_conn_14
	"Road Runner", //manul_conn_15
	"Rogers Yahoo!", //manul_conn_16
	"SBC Yahoo! DSL", //manul_conn_17
	"Shaw", //manul_conn_18
	"Speakeasy", //manul_conn_19
	"Sprint FastConnect", //manul_conn_20
	"Telus", //manul_conn_21
	"Time Warner Cable", //manul_conn_22
	"US West / Qwest", //manul_conn_23
	"Verizon Online DSL", //manul_conn_24
	"XO Communications", //manul_conn_25
	"Manully set 5GHz band Network Name(SSID)", //manul_5g_ssid
	"<a href=\"http://www.dlink.com\">Click here to check for an upgrade on our support site.</a>", //tf_intro_FWU3
	"The language pack allows you to change the language of the user interface on the ", //tf_intro_FWU4
	" We suggest that you upgrade your current language pack if you upgrade the firmware. This ensures that any changes in the firmware are displayed correctly.", //tf_intro_FWU5
	"Firmware update", //_firmwareUpdate
	"Date", //_date
	"Remove", //_remove
	"When you set security WEP, EAP, cipher type is TKIP or Visibility Status is Invisible, WPS will be disable.", //notify_wps
	"%s ports[%s] conflicts with other setting", //ag_conflict5
	"Disable", //_disable
	"HT 20/40 MHz Coexistence ", //coexi
	"Use the same Wireless Security Password on both 2.4GHz and 5GHz band", //wwl_SSP
	"Give your Wi-Fi network a name and  a password.", //wwz_wwl_intro_s0
	"This page displays your IPv6 internet and network connection details.", //STATUS_IPV6_DESC_0
	"IPv6 Connection Information", //STATUS_IPV6_DESC_1
	"The IPv6 address of the connected computer.", //STATUS_IPV6_DESC_6
	"The LAN IPv6 Link-Local Address.", //STATUS_IPV6_DESC_5
	"The MAC address of the connected computer.", //STATUS_IPV6_DESC_4
	"The type of IPv6 connection.", //STATUS_IPV6_DESC_3
	"The name of the connected computer.", //STATUS_IPV6_DESC_2
	"The QoS Engine feature helps improve your network performance by prioritizing applications.\" ;", //ag_conflict6
	"Rules", //TEXT008a
	"is setting same as Rules", //TEXT008b
	"MYDLINK SETTINGS", //mydlink_S01
	"Setting and registering your product with mydlink will allow you to use its mydlink cloud services features, including online access and management of your device through mydlink portal website.", //mydlink_S02
	"mydlink", //mydlink_S03
	"Register mydlink Service", //mydlink_S04
	"REAL-TIME BROWSING HISTORY", //mydlink_T01
	"PUSH EVENT", //mydlink_T02
	"EVENT TRIGGER", //mydlink_T03
	"Notice of Firmware Upgrade", //mydlink_T05
	"Notice", //TEXT023
	"Notice of Online User Logging", //mydlink_T04
	"Mbps", //at_mbps
	"Invalid PIN format. Please follow this  0000 0000 or 0000-0000", //pin_f
	"Using WEP Encryption will be disabled the WPS, Are you sure?", //msg_eap
	"Open", //open
	"Please enter another Private Port number", //PRIVATE_PORT_ERROR
	"Folder can't be set as \"%s\"", //MSG056
	"You use the same account and password!", //MSG057
	"Destination IP", //_DestIP
	"Type", //_type
	"No internet detected, would you like to restart the wizard?", //mydlink_tx03
	"Administrator password cannot be blank.", //mydlink_tx04
	"Checking WAN connectivity.", //mydlink_tx05
	"seconds left.", //sec_left
	"Do you have mydlink account?", //mydlink_tx06
	"Yes, I have a mydlink account.", //mydlink_tx07
	"No, I want to register and login with a new mydlink account.", //mydlink_tx08
	"E-Mail Address", //mydlink_tx09
	"Please fill out the required fields and click \"Connect\"", //ES_CONN_dsc
	"Confirm Password", //chk_pass
	"Last name", //Lname
	"First Name", //Fname
	"I Accept the mydlink terms and conditions.", //mydlink_tx12
	"To complete your mydlink registration, please check your Inbox for an email with confirmation instructions.", //mydlink_tx13_1
	" After confirming your email address, click the Login button.", //mydlink_tx13_2
	"Login", //_login
	"%s ports[%s] conflicts with Storage Remote Access Http Port", //ag_conflict22
	"%s ports[%s] conflicts with Storage Remote Access Https Port", //ag_conflict23
	"host wireless is disabled, can't enable guest zone wireless.", //wifi_enable_chk
	"To use the features of  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> and the mydlink Lite app, you will need an account with <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"If you already have an account, select <strong>Yes, I have a mydlink account</strong> and click Next to register the router with <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"If you do not have an account, select <strong>No, I want to register and login with a new mydlink account</strong> and click Next to create an account. ", //mydlink_reg_into_3
	" If you do not wish to sign up for the mydlink service, please click Cancel.", //mydlink_reg_into_4
	"This e-mail address already has a mydlink account. Try a different e-mail address.", //mydlink_pop_01
	"You must accept the terms and conditions to continue.", //mydlink_pop_02
	"should not be blank.", //mydlink_pop_03
	"is invalid.", //mydlink_pop_04
	"You may now use mydlink service with this device", //mydlink_pop_05
	"Login failed", //mydlink_pop_06
	"The IPv6 Address cannot be zero.", //ZERO_IPV6_ADDRESS
	"The IPv6 Port Range cannot be blank.", //port_empty
	"mydlink Service", //mydlink_srv
	"Registered", //mydlink_reg
	"Non-Registered", //mydlink_nonreg
	"disable", //_disable_s
	"Please select your IPv6 Internet Connection type", //IPV6_TEXT154
	"Please set an Administrator password before mydlink registration begins", //mydlink_pop_07
	"Sign up", //_signup
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"The Wireless Security Password field entered is invalid.", //wifi_pass_chk
	"Remove", //_remove_multi
	"Do you really want to reprogram the device using the language file", //tf_really_langf
	"You must enter the name of a language file first.", //tf_langf
	"The uploaded language file may not be correct. You may have uploaded a file that is not intended for this device, or the uploaded file may be corrupted.", //ub_intro_l1
	"If the uploaded file is correct, it is possible that the device may be too busy to properly receive it right now. In this case, please try the upload again. It is also possible that you are logged in as a 'user' instead of an 'admin' - only administrators can upload new language.", //ub_intro_l3
	"The page you requested is not available ", //err404_title
	"Could not detect an Internet connection.", //err404_detect
	"Suggestions:", //err404_sug
	"Make sure your Internet cable is securely connected to the Internet port on your router, and your Internet LED is blinking green or blue. ", //err404_sug1
	"Check to make sure that the", //err404_sug2
	"\"Internet settings\"", //err404_sug3
	"on your router are set correctly, such as your PPPoE username/password settings.", //err404_sug4
	"The DNS server may be down at the moment, please contact your ISP or try again later.", //err404_sug5
	"End Time", //tsc_end_time
	"Please enter another remote Admin Port value", //remote_port_msg
	"Please enter another Name", //TEXT034
	"Only Administrator has access to these functionalities. The buttons are disabled as you are not currently logged in as Administrator.", //LW39b
	"Please enter a user name and try again", //_nousername
	"Please enter another Metric value.", //metric_empty
	"Please enter a TCP port number or a UDP port number.", //TEXT061
	"Please contact your ISP to get the correct username/password", //ES_DIALUP_ERROR_dsc
	"Please enter a Firewall Port number", //MSG001
	"Please select \"Device Link\"", //MSG051
	"Please enter another %s value.", //MSG012
	"Please select a filter.", //aa_alert_13
	"Please select a Computer Name first", //TEXT044
	"Please enter another User Name", //sto_03
	"Nothing has changed on this page. Do you want to save it anyway?", //up_nosave
	"Please enter the same password into both boxes, for confirmation.", //ta_msg_TW
	"When “Dial on Demand” is selected, mydlink functionality became unreliable or unavailable. Are you sure you want to continue?", //mydlink_pop_08
	"If you want to \" Enable Web File Access\", you need select \"Enable HTTP Storage Remote Access\" or  \"Enable HTTPS Storage Remote Access\" .", //sto_04
	"Enable Hub and Spoke Mode", //IPV6_TEXT167
	"This page displays IPv6 routing details configured for your router.", //IPV6_TEXT170
	"For each rule you can create a name and control the direction of traffic. You can also allow or deny a range of IP Addresses, the protocol and a port range. In order to apply a schedule to a firewall rule, you must first define a schedule on the <a href=\"tools_schedules.asp\"> Tools &rarr; Schedules</a> page.", //help_171
	"The Host Name is invalid!", //DDNS_HOST_ERROR
	"No.", //_item_no
	"Failed to mount USB device", //_usb_not_found
	"Server name cannot be empty.", //srv_name_empty
	"Using WEP Encryption will be disabled the WPS, Are you sure ?", //msg_wps_sec_01
	"Using WPA/TKIP Encryption will be disabled the WPS, Are you sure ?", //msg_wps_sec_02
	"To hidden SSID will be disabled the WPS, Are you sure ?", //msg_wps_sec_03
	"SharePort", //sh_port_tx_00a
	"Mobile/Web Access", //sh_port_tx_00b
	"SharePort&trade; Mobile/Web Access", //sh_port_tx_00
	"SharePort&trade; Mobile/Web Access is an easy to use shared access from any computer or mobile device in your home network to an external USB storage drive connected to your router. It allows you and other guest users to access files stored on a USB storage drive via the user account you create.", //sh_port_tx_01
	"You can use the Setup Wizard or manually configure for the SharePort&trade; Mobile/Web Access.", //sh_port_tx_02
	"SharePort&trade; Mobile Setup Wizard", //sh_port_tx_03
	"If you would like to utilize our easy to use Web-based Wizards to assist you in setting SharePort&trade; Mobile service, click on the button below.", //sh_port_tx_04
	"SharePort&trade; Mobile Manual Setup", //sh_port_tx_05
	"If you would like to configure SharePort&trade; Mobile/Web Access service settings manually, please click on the button below.", //sh_port_tx_06
	"Please make sure your USB storage is connected to the router.", //sh_port_tx_07
	"No USB storage! Please make sure there is a storage device plugged in the router.", //sh_port_tx_08
	"Create a User Account to manage the storage accessibility.", //sh_port_tx_09
	"Select/Create a folder in the USB drive for accessing the contents.", //sh_port_tx_10
	"Fill in Dynamic DNS Account information for enabling remote access service. If you don't have DDNS account, please sign up one from here:", //sh_port_ddns_01
	"Process Settings", //sh_port_ddns_02
	"Please wait for web access link checking…", //sh_port_ddns_03
	"setup is complete! You can now use below link to access your USB storage via below User Account.", //sh_port_tx_11
	"Local Access", //sh_port_tx_12
	"Remote Access", //sh_port_tx_13
	"<a href=\"http://dlinkrouter:8181\">http://dlinkrouter:8181</a>", //sh_port_tx_14
	"<a href=\"http://dlinkrouter.local:8181\">http://dlinkrouter.local:8181</a>", //sh_port_tx_15
	"or", //sh_port_tx_16
	"<a href=\"http://FQDN:8181\">http://FQDN:8181</a>", //sh_port_tx_17
	"Above links will activate when settings are saved and after device reboot.", //sh_port_tx_18
	"User Name or key", //sh_port_tx_19
	"Password or key", //sh_port_tx_20
	"Select", //sh_port_tx_21
	"The Account Name field cannot be empty.", //sh_port_msg_01
	"The Account Password field cannot be empty.", //sh_port_msg_02
	"The two Password entries do not match.", //sh_port_msg_04
	"Please select a folder for your User Account.", //sh_port_msg_05
	"The Host Name field cannot be empty.", //sh_port_msg_06
	"The User Name field cannot be empty.", //sh_port_msg_07
	"The Password field cannot be empty.", //sh_port_msg_08
	"The Dynamic DNS cannot establish a connection.", //sh_port_msg_09
	"Allow Remote Access", //sto_http_6
	"Are you sure you want to delete this User?", //file_acc_del_user
	"Are you sure  you want to delete this Path?", //file_acc_del_path
	"Are you sure  you want to delete this File?", //file_acc_del_file
	"mydlink Account", //mydlink_acc
	"login again", //_login_a
	"DYNAMIC DNS FOR IPv6 HOSTS", //IPv6_ddns_01
	"IPv6 DYNAMIC DNS LIST", //IPv6_ddns_02
	"Configure IPv6 Firewall below:", //IPv6_fw_01
	"Turn IPv6 Firewall OFF", //IPv6_fw_02
	"Turn IPv6 Firewall ON and ALLOW rules listed", //IPv6_fw_03
	"Turn IPv6 Firewall ON and DENY rules listed", //IPv6_fw_04
	"IP Address Range", //IPv6_fw_ipr
	"Port Range", //IPv6_fw_pr
	"Source", //IPv6_fw_sr
	"Dest", //IPv6_fw_dest
	"6rd Relay can not be empty.", //IPv6_6rd_relay
	"Please change IPv4 wan protocol to DHCP mode first.", //IPv6_6rd_wan
	"6to4 Relay cannot be empty.", //IPv6_6to4_relay
	"Address Range(Start)", //IPv6_addrSr
	"Address Range(End)", //IPv6_addrEr
	"Using WPA Only will be disabled the WPS, Are you sure ?", //msg_wps_sec_04
	"Enable Security", //mydlink_sec
	"Send Mail Now", //mydlink_sendM
	"Please wait %d seconds.", //msg_wait_sec
	"Please select a file to delete", //file_acc_del_empty
	"Please Sign in Mydlink first", //mydlink_reg_chk
	"IPv6 PPPoE is share with IPv4 PPPoE. Please change IPv6 WAN protocol at first!", //IPV6_TEXT161a
	"WI-FI Statistics 2.4GHZ", //ss_Wstats_2
	"WI-FI Statistics 5GHZ", //ss_Wstats_5g
	"If you have already registered this router with your mydlink account, the registration will be confirmed here and the name of the registered mydlink account will be shown.", //mydlink_help_01
	"If you haven't registered with mydlink, you may click the Register mydlink button to login or create a new account. After completion, the router will automatically be connected to your account.", //mydlink_help_02
	"mydlink Settings", //mydlink_help_03
	"Media Server", //dlna_t
	"Enable Media Server", //dlna_01
	"Media Server Name", //dlna_02
	"Media Server name given is invalid", //dlna_03
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Using WPA-Enterprise Encryption will be disabled the WPS, Are you sure ?", //msg_wps_sec_05
	"Web File Access Login", //webf_login
	"Log in to the web file access Server", //webf_intro
	"SharePort Web Access", //webf_title
	"New Folder", //webf_folder
	"My Access Device Hard Drive", //webf_hd
	"Create Folder", //webf_createfd
	"Please enter a folder name", //webf_fd_name
	"Upload File", //webf_upload
	"Please select a file", //webf_file_sel
	"If you enable to share media with devices, any computer or device that connects to your network can play your shared music, pictures and videos.", //dlna_t1
	"<strong>Note:</strong> The shared media may not be secure. Allowing any devices to stream is recommended only on secure networks.", //dlna_t2
	"It will allow you to access files from a USB external hard drive or thumb drive that is plugged into the DIR-826L from your local network or from the Internet using either a web browser or the SharePort &trade; Mobile app for your smartphone or tablet. You can create users to customize access rights to the files stored on the USB drive. After making your changes, click the <strong>Save Settings</strong> button.", //help_stor1
	"Tick this checkbox to enable sharing files stored on a USB storage drive connected to the DIR-826L.", //help_stor2
	"Enter a port to use for HTTP web access to your files (8181 is the default). You will have to add this port to the IP address of the DIR-826L when connecting. For example: http://192.168.0.1:8181", //help_stor3
	"Enter a port to use for HTTPS secure access to your files (4433 is the default). You will have to add this port to the IP address of the DIR-826L when connecting. For example: https://192.168.0.1:4433", //help_stor4
	"Check to enable remote access to your router's storage.", //help_stor5
	"User Creation", //help_stor6
	"To create a new user, enter a user name. To edit an existing user, use the dropdown box to the right.", //help_stor7
	"Enter a password you want to use for the account, re-enter the password in the <strong>Verify Password</strong> text box, then click <strong>Add/Edit</strong> to save your changes.", //help_stor8
	"This section shows existing user accounts. There are <strong>admin</strong> and <strong>guest</strong> accounts by default.", //help_stor9
	"This feature allows you to share music, pictures and videos with any devices connected to your network. After making your changes, click the <strong>Save Settings</strong> button.", //help_dlna1
	"None USB Storage Insert.", //webf_non_hd
	"DDNS detection fail!", //sh_port_tx_22
	"DDNS link failed, please try again and check your account information, or click next to save your DDNS settings anyway.", //sh_port_tx_23
	"Enable IPv6 Ingress Filtering", //IPv6_Ingress_Filtering_enable
	"Music", //share_title_1
	"Photo", //share_title_2
	"Movie", //share_title_3
	"Document", //share_title_4
	"Search Songs...", //share_ser_1
	"Search Photos...", //share_ser_2
	"Search Movie...", //share_ser_3
	"Search Documents...", //share_ser_4
	"Disconnecting", //ddns_disconnecting
	"Reservation IP", //lan_reserveIP
	"End IP address", //end_ip
	"NULL", //_NULL
	"dlinkddns.com(Free)", //ddns_sel1
	"dyndns.com(Custom)", //ddns_sel2
	"dyndns.com(Free)", //ddns_sel3
	"Remote IP Address", //_remoteipaddr
	"Back", //_back
	"Ping %s failed.", //_ping_fail
	"Ping %s successfully.", //_ping_success
	"" //MAX
);
var _Advanced_01=0;
var _Advanced_03=1;
var _Advanced_04=2;
var bwn_ict_dns=3;
var bwn_msg_Modes_dns=4;
var aa_EAC=5;
var _dlinkdns=6;
var new_bwn_mici_usb=7;
var _tkip_11n=8;
var bln_title_guest_use_shareport=9;
var IPV6_TEXT3=10;
var bwl_Mode_10=11;
var IPV6_TEXT148=12;
var _regenerate=13;
var TEXT048=14;
var te_EnEmN=15;
var usb3g_titile=16;
var usb3g_apn_name=17;
var usb3g_dial_num=18;
var usb3g_reconnect_mode=19;
var usb3g_max_idle_time=20;
var usb_device=21;
var usb3g_manual=22;
var usb3g_stat_titile=23;
var bln_title_usb=24;
var usb_wcn=25;
var bwn_intro_usb=26;
var usb_network=27;
var usb_3g=28;
var wwan_dial_num=29;
var bwn_wwanICT=30;
var help862=31;
var wwan_auth_label=32;
var wwan_auth_auto=33;
var IPPPPPAP_AUTH_ISSUE=34;
var wwan_auth_chap=35;
var wwan_auth_mschap=36;
var usb_network_help=37;
var usb_network_support_help=38;
var usb_3g_help=39;
var usb_3g_help_support_help=40;
var usb_wcn_help=41;
var bwn_mici_usb=42;
var _info_netowrk=43;
var anet_multicast_enable=44;
var bwn_usb_time=45;
var bwn_bytes_usb=46;
var _wps_albert_1=47;
var _wps_albert_2=48;
var usb_config2=49;
var ac_alert_choose_dev=50;
var usb_config3=51;
var usb_config4=52;
var usb_config5=53;
var usb_config6=54;
var bwn_msg_usb=55;
var bwn_note_usb=56;
var _country=57;
var _select_country=58;
var _select_ISP=59;
var country_1=60;
var country_2=61;
var country_3=62;
var country_4=63;
var country_5=64;
var country_6=65;
var country_7=66;
var _aa_bsecure_personals=67;
var country_9=68;
var country_10=69;
var country_11=70;
var country_12=71;
var country_13=72;
var country_14=73;
var country_15=74;
var S500=75;
var S496=76;
var sto_http_2=77;
var logs_LW39b_email=78;
var LV3=79;
var GW_WIRELESS_DEVICE_LINK_UP=80;
var LT248=81;
var GW_PPPOE_EVENT_DISCOVERY_ATTEMPT=82;
var GW_WLAN_RADIO_1_NAME=83;
var te_SMTPSv_Port=84;
var GW_WLAN_CHANGING_PHY_MODE_TO_11NG_ONLY_INVALID=85;
var S558=86;
var KRL8=87;
var LY30=88;
var GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=89;
var GW_WIFISC_DISABLED_AUTOMATICALLY=90;
var _off=91;
var GW_WLAN_RADIO_0_NAME=92;
var GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR=93;
var GW_WAN_PPPOE_SESSION_NAME_CONFLICT=94;
var S525=95;
var YM174=96;
var KR136=97;
var GW_PPPOE_EVENT_DISCONNECT=98;
var af_EFT_0=99;
var LY34=100;
var GW_WIRELESS_SHUT_DOWN=101;
var GW_WIRELESS_RESTART=102;
var S528=103;
var GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE=104;
var guestzone_Intro_1=105;
var GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=106;
var ta_ERM=107;
var te_SMTPSv_Port_alert=108;
var GW_WIRELESS_DEVICE_START_FAILED=109;
var GW_PORT_FORWARD_UDP_PACKET_ALLOC_FAILURE=110;
var GW_WIRELESS_DEVICE_DISCONNECT_ALL=111;
var GW_PPPOE_EVENT_OFFER_REQUEST=112;
var GW_ROUTES_ROUTERS_IP_ADDRESS_INVALID=113;
var GW_PORT_TRIGGER_UDP_PACKET_ALLOC_FAILURE=114;
var GW_WLAN_SETTING_SSID_SECURITY_TO_WEP_INVALID=115;
var GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT=116;
var GW_WLAN_STATION_TIMEOUT=117;
var GW_NAT_VIRTUAL_SERVER_IP_ADDRESS_CAN_NOT_MATCH_ROUTER=118;
var GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID=119;
var LY28=120;
var GW_PPPOE_EVENT_CONNECT=121;
var GW_NAT_TRIGGER_PORT=122;
var tc_opmode=123;
var wwz_auto_assign_key3=124;
var LY292=125;
var LY293=126;
var bws_msg_WEP_4=127;
var GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID=128;
var wwa_dnsset=129;
var wireless_gu=130;
var add_gu_wps=131;
var wwl_band=132;
var _band=133;
var wwa_5G_nname=134;
var _guestzone=135;
var guestzone_title_1=136;
var _graph_auth=137;
var guestzone_inclw=138;
var guest=139;
var lower_wnt=140;
var equal_wnt=141;
var _lowest=142;
var ssid_lst=143;
var dlink_help150=144;
var mult_ssid=145;
var dlink_help155=146;
var add_ed_ssid=147;
var help75a=148;
var dlink_help157=149;
var wpin_filter=150;
var dlink_help151=151;
var tps_raw1=152;
var up_tz_52=153;
var _r_alert_new1=154;
var te_EmSt=155;
var mydlink_T06=156;
var IPNAT_BLOCKED_EGRESS=157;
var bws_WSMode=158;
var anet_wan_ping_1=159;
var help65=160;
var ta_upnp=161;
var bwl_TxR=162;
var GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED=163;
var tsc_pingt_msg106=164;
var tsc_AllDay=165;
var gw_gm_53=166;
var GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR=167;
var DHCP_CLIENT_LOST_LEASE=168;
var _aa_wiz_s3_msg=169;
var bwsAT_=170;
var hhtt_intro=171;
var gw_gm_20=172;
var help388=173;
var tt_StDT=174;
var psOffline=175;
var _status=176;
var up_ae_wic_3=177;
var sl_WtV=178;
var WIFISC_AP_PROXY_PROCESS_START=179;
var wprn_nopr2=180;
var help352=181;
var wwz_wwl_wnn=182;
var _ipaddr=183;
var GW_WLS_SCHEDULE_START=184;
var help820=185;
var help326=186;
var up_tz_54=187;
var help773=188;
var am_MACFILT=189;
var aa_alert_7_new1=190;
var help302=191;
var aa_intro=192;
var help348=193;
var haf_dmz_30=194;
var sl_Infrml=195;
var _wireless=196;
var bws_RIPA=197;
var KR108=198;
var help83=199;
var hhase_intro=200;
var RUNTIME_CONFIG_MAGIC_NUM_ERROR=201;
var _Sat=202;
var awf_title_WSFR=203;
var help18_a=204;
var dlink_wf_op_1=205;
var gw_gm_18=206;
var gw_gm_7=207;
var USB_LOG_STORAGE_TYPE=208;
var help346=209;
var up_rb_5=210;
var _WEP=211;
var IPMSCHAP_AUTH_FAIL_AND_NO_RETRY=212;
var gw_gm_82=213;
var bw_sap=214;
var bwn_msg_SWM=215;
var li_alert_2=216;
var help120=217;
var IGMP_HOST_LOW_RESOURCES=218;
var wwl_s4_intro_z3=219;
var help78=220;
var help339=221;
var IPv6_Simple_Security_enable=222;
var help51=223;
var GW_WAN_LAN_ADDRESS_CONFLICT_PPP=224;
var ss_Errors=225;
var help899=226;
var li_alert_4=227;
var haf_dmz_40=228;
var hhts_edit=229;
var wwl_wnn=230;
var WEB_FILTER_LOG_URL_ACCESSED_MAC=231;
var aw_WE=232;
var help201a=233;
var _bsecure_activate_trial=234;
var help896=235;
var help815=236;
var _netmask=237;
var _please_wait=238;
var help12=239;
var am_intro_1=240;
var IPPPPLCP_SET_LOCAL_AUTH=241;
var gw_gm_11=242;
var _dontsavesettings=243;
var wwl_s4_intro_za1=244;
var _308=245;
var dlink_help148=246;
var aa_AT_1=247;
var IPL2TP_TUNNEL_ABORTING=248;
var help330=249;
var dlink_1_bwl_schld=250;
var wwa_msg_l2tp=251;
var tt_time_5=252;
var help6=253;
var _time=254;
var at_xDSL=255;
var wprn_intro4=256;
var help296=257;
var _LAN=258;
var gw_gm_60=259;
var _aa_wiz_s4_msg=260;
var wwl_64bits=261;
var IPFAT_DISK_FULL=262;
var help341=263;
var sps_intro3=264;
var aa_sched_conf_2=265;
var IPL2TP_SESSION_CONNECTING=266;
var NET_RTC_SYNCHRONIZATION_FAILED=267;
var tf_AutoCh=268;
var wprn_iderr2=269;
var help319=270;
var af_intro_2=271;
var help800=272;
var sd_title_Dev_Info=273;
var GW_INET_ACCESS_DROP_PORT_FILTER=274;
var _connow=275;
var IPSIPALG_REJECTED_PACKET=276;
var IPNAT_TCP_UNABLE_TO_MODIFY_OPTIONS=277;
var tt_SelNTPSrv=278;
var help812=279;
var _user=280;
var up_tz_59=281;
var SPECIAL_APP=282;
var wwl_NONE=283;
var GW_WAN_SERVICES_STARTED=284;
var fb_FbWbAc=285;
var help275=286;
var wprn_nopr=287;
var tt_TimeZ=288;
var wprn_tt=289;
var help841=290;
var aa_sched_new=291;
var tt_time_14=292;
var gw_vs_1=293;
var tsl_SLSt=294;
var IPH323ALG_REJECTED_PACKET=295;
var aa_wiz_s1_msg4=296;
var help336=297;
var ta_sn=298;
var help780=299;
var _interface=300;
var WEB_FILTER_LOG_URL_BLOCKED=301;
var vs_http_port=302;
var haf_intro_1=303;
var up_tz_07=304;
var aw_intro=305;
var wwa_gw=306;
var _sentinel_serv=307;
var wwa_msg_sipa=308;
var IPNAT_TCP_UNABLE_TO_HANDLE_HEADER=309;
var hhav_ip=310;
var haf_dmz_50=311;
var GW_INET_ACCESS_POLICY_END_MAC=312;
var tsc_intro_Sch=313;
var GW_WLAN_ACCESS_DENIED=314;
var _262=315;
var help79=316;
var GW_BIGPOND_CONFIG=317;
var aw_TP_0=318;
var _sdi_s3=319;
var tsc_pingr=320;
var tsc_pingt_v6=321;
var _WPApersonal=322;
var _email=323;
var PPPOE_EVENT_DISCOVERY_REQUEST=324;
var _firewall=325;
var wwa_wanmode_sipa=326;
var _syscheck=327;
var help784=328;
var UNKNOWN=329;
var help322=330;
var help_upnp_1=331;
var gw_gm_61=332;
var _optional=333;
var help181=334;
var help569=335;
var anet_intro=336;
var _authword=337;
var IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN=338;
var ta_GWN=339;
var wprn_tt3=340;
var help293=341;
var help265_2=342;
var IPNAT_UNABLE_TO_CREATE_CONNECTION=343;
var help270=344;
var aw_title_2=345;
var _firewalls=346;
var LW67=347;
var PPPOE_EVENT_UP=348;
var _protocol=349;
var help372=350;
var up_tz_32=351;
var at_kbps=352;
var at_Cable=353;
var anet_wp_1=354;
var help17=355;
var ta_intro_Adm2=356;
var tool_admin_check=357;
var IPPPPIPCP_PPP_LINK_UP=358;
var _stop=359;
var GW_SYSLOG_STATUS=360;
var bd_title_DHCPSSt=361;
var help827=362;
var tf_FWCheckInf=363;
var tf_FWInf=364;
var hhai_ipr=365;
var hhaw_1=366;
var help34=367;
var _network_usb_auto=368;
var help309=369;
var aa_alert_15=370;
var _savesettings=371;
var help193=372;
var help14_p=373;
var gw_gm_32=374;
var IPNAT_TCP_BLOCKED_INGRESS_SYN=375;
var anet_msg_wan_ping=376;
var ai_intro_2=377;
var help285=378;
var ss_LANStats=379;
var ta_alert_4=380;
var _clone=381;
var gw_gm_14=382;
var PPTP_ALG_GRE_UNABLE_TO_HANDLE_HEADER=383;
var _aa_block_some=384;
var help819_3=385;
var tt_time_24=386;
var help873=387;
var ss_Collisions=388;
var help863=389;
var help397=390;
var av_title_VSL=391;
var help636=392;
var tf_ENFA=393;
var help13=394;
var wwa_title_s3=395;
var ES_wwa_title_s1=396;
var GW_WAN_RATE_ESTIMATOR_CONVERGENCE_ERROR=397;
var wwa_wanmode_bigpond=398;
var help254=399;
var haf_dmz_70=400;
var GW_SCHED_ATTACH_FAILED=401;
var _badssid=402;
var RUNTIME_CONFIG_STORING_CONFIG_IN_NVRAM=403;
var FW_UPDATE_AVAILABLE=404;
var dlink_awf_intro_WF=405;
var help891=406;
var help777=407;
var help393=408;
var bwn_ict=409;
var tt_Jun=410;
var IPL2TP_TUNNEL_CONNECTED=411;
var gw_gm_9=412;
var gw_gm_2=413;
var wwl_wl_wiz=414;
var network_dhcp_range=415;
var wprn_intro6=416;
var GW_BIGPOND_FAIL=417;
var af_EFT_1=418;
var _use_unicasting=419;
var _networkstate=420;
var tt_Year=421;
var IPASYNCFILEUSB_MOUNT_FAILED=422;
var af_UEFT=423;
var help356=424;
var help381=425;
var _inboundfilter=426;
var _aa_apply_port_filter=427;
var aa_FPR_c7=428;
var gw_gm_27=429;
var BIGPOND_NOT_PROPERLY_CFGD=430;
var help335=431;
var up_tz_58=432;
var _never=433;
var help801=434;
var tsc_pingt_msg105=435;
var li_WJS=436;
var te_ToEm=437;
var tt_time_1=438;
var help787=439;
var IPV6_TEXT65_v6=440;
var GW_EMAIL_SUBJ=441;
var IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE=442;
var bi_wiz=443;
var _Out=444;
var hhpt_app=445;
var _dhcpconn=446;
var bln_title_Rtrset=447;
var _ps=448;
var _1044=449;
var wwl_text_best=450;
var wwa_pptp_svraddr=451;
var GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED=452;
var _LANComputers=453;
var hhte_intro=454;
var as_NM=455;
var wwa_setupwiz=456;
var help264=457;
var bw_WDUU_note=458;
var as_MMS=459;
var _srvname=460;
var help93=461;
var tt_Minute=462;
var sa_State=463;
var aw_dE=464;
var tsc_pingt_h=465;
var tsc_pingt_h_v6=466;
var ss_WStats=467;
var IPMSCHAP_AUTH_SEND_CHALLENGE=468;
var wprn_intro1=469;
var help889=470;
var as_H323=471;
var tool_admin_pfname=472;
var IPNAT_SESSION_ALREADY_EXISTS=473;
var wwa_title_set_bigpond=474;
var up_tz_16=475;
var GW_BIGPOND_STATUS=476;
var wwa_msg_set_bigpond=477;
var ai_alert_5=478;
var help848=479;
var gw_gm_41=480;
var _aa_pol_wiz=481;
var IP_FILTERS=482;
var gw_gm_50=483;
var wwa_intro_s3=484;
var IPSEC_ALG_ESP_ESTABLISH_ALREADY_PENDING=485;
var help59=486;
var wps_reboot_need=487;
var at_DF=488;
var help265_7=489;
var tt_alert_dstchkmonth=490;
var up_tz_23=491;
var _advanced=492;
var STATIC_IP_ADDRESS=493;
var wwl_title_s3=494;
var hhsw_intro=495;
var ish_menu=496;
var up_tz_33=497;
var GW_FW_NOTIFY_FIRMWARE_ERROR=498;
var _bsecure_more_info=499;
var tf_CFWV=500;
var tt_week_2=501;
var help3=502;
var _creator=503;
var bln_title_DNSRly=504;
var GW_INET_ACCESS_DROP_PORT_FILTER_MAC=505;
var ish_glossary=506;
var wwl_s4_intro_z4=507;
var help118=508;
var gw_gm_66=509;
var help312dr2=510;
var tsc_24hrs=511;
var hhag_10=512;
var help261=513;
var as_TPrt=514;
var help28=515;
var tt_time_12=516;
var ss_reload=517;
var EGRESS=518;
var sps_fp=519;
var gw_gm_57=520;
var wwa_msg_dhcp=521;
var aa_wiz_s1_msg1=522;
var MUST_BE_LOGGED_IN_AS_ADMIN=523;
var up_tz_64=524;
var GW_WLS_SCHEDULE_STOP=525;
var IPWOLALG_REJECTED_PACKET=526;
var WCN_LOG_UPDATE=527;
var help80=528;
var help171=529;
var _Mon=530;
var up_tz_66=531;
var wwl_title_s4_2=532;
var help196=533;
var PPPOE_EVENT_DISCOVERY_REQUEST_ERROR=534;
var li_Log_In=535;
var af_gss=536;
var _defgw=537;
var YM185=538;
var add_wireless_device=539;
var help8=540;
var help258=541;
var PPPOE_EVENT_TERMINATED=542;
var up_rb_1=543;
var help25_b=544;
var sl_saveLog=545;
var sl_intro=546;
var _aa_wiz_s4_help=547;
var GW_WAN_CARRIER_LOST=548;
var bwn_bytes=549;
var help890_1=550;
var help779=551;
var _macaddr=552;
var help823_13=553;
var ta_ELM=554;
var sto_http_4=555;
var anet_multicast_enable_v4=556;
var GW_DYNDNS_UPDATE_NEXT=557;
var help866=558;
var sl_RStat=559;
var gw_gm_78=560;
var help90=561;
var PPTP_EVENT_TUNNEL_DOWN=562;
var bwn_SWM=563;
var IPWEBFILTER_REJECTED_PACKET=564;
var GW_UPGRADE_FAILED=565;
var ag_intro=566;
var ta_intro_Adm=567;
var bwn_L2TPSIPA=568;
var GW_INET_ACCESS_UNRESTRICTED=569;
var up_tz_11=570;
var _disabled=571;
var GW_LOG_EMAIL_ON_LOG_FULL=572;
var tt_time_8=573;
var help43=574;
var ddns_connecting=575;
var help282=576;
var _enable=577;
var help272=578;
var tt_Apr=579;
var tt_alert_invlddt=580;
var bwl_MS=581;
var wwa_intro_wel=582;
var tool_admin_portconflict=583;
var gw_SelVS=584;
var bwn_RM_0=585;
var hhai_edit=586;
var te_FromEm=587;
var wt_p_1=588;
var NET_RTC_REQUEST_TIME=589;
var help48=590;
var N_A=591;
var help279=592;
var tt_week_6=593;
var gw_gm_48=594;
var bwl_VS_1=595;
var help882=596;
var up_tz_41=597;
var RUNTIME_CONFIG_LOADED_CONFIG_FROM_NVRAM=598;
var li_alert_1=599;
var help307=600;
var help273=601;
var help194=602;
var up_rb_4=603;
var NEWER_FW_VERSION=604;
var bwn_PPTPICT=605;
var GW_UPGRADE_SUCCEEDED=606;
var bwl_AS=607;
var help96=608;
var _wchannel=609;
var wwz_manual_key=610;
var ap_intro_cont=611;
var tsl_EnLog=612;
var _L2TP=613;
var bd_DIPAR=614;
var _stats=615;
var wwl_s4_intro_za2=616;
var IPL2TP_SESSION_DOWN=617;
var bwn_DIAICT=618;
var help338=619;
var help859=620;
var _add=621;
var _acccon=622;
var tsc_pingt_msg4=623;
var ddns_disconnect=624;
var _verifypw=625;
var am_intro_2=626;
var _aa_pol_add=627;
var gw_gm_59=628;
var help11=629;
var _system=630;
var help261a=631;
var up_tz_02=632;
var hhtsc_pingt_intro=633;
var help5=634;
var help767s=635;
var gw_gm_45=636;
var wwa_wanmode_pppoe=637;
var GW_ROUTES_GATEWAY_SUBNET_SAME=638;
var haf_dmz_60=639;
var te_intro_Em=640;
var wwl_text_none=641;
var help895=642;
var help269=643;
var GW_WAN_RECONNECT_ON_ACTIVE=644;
var aa_Machine=645;
var GW_WLS_SCHEDULE_INIT=646;
var _Wed=647;
var tt_time_20=648;
var aa_FPR_c3=649;
var help68=650;
var help150=651;
var te_Acct=652;
var IPSMTPCLIENT_MSG_SENT=653;
var gw_gm_38=654;
var help384=655;
var tt_time_2=656;
var at_AUS=657;
var hhts_del=658;
var help818=659;
var help886=660;
var _aa_wiz_s2_msg=661;
var help52=662;
var wps_KR46=663;
var wwz_wwl_intro_s3_1=664;
var gw_gm_19=665;
var td_intro_DDNS=666;
var up_tz_53=667;
var help845=668;
var wt_p_3=669;
var up_tz_51=670;
var wprn_s3d=671;
var IPPPPCHAP_AUTH_FAIL=672;
var gw_gm_52=673;
var IPNAT_TCP_BAD_FLAGS=674;
var _name=675;
var help66=676;
var IPNAT_UDP_BLOCKED_INGRESS_ICMP_ERROR_PACKET=677;
var IPFTPALG_REJECTED_PACKET=678;
var fb_p_1=679;
var _contype=680;
var help829=681;
var _specappsr=682;
var help353=683;
var gw_gm_23=684;
var help325=685;
var bwn_RM=686;
var sl_LogOps=687;
var help772=688;
var _aa_method=689;
var sl_LogDet=690;
var help788=691;
var _continue=692;
var help349=693;
var help804=694;
var _devinfo=695;
var _yes=696;
var help699=697;
var up_tz_62=698;
var help192=699;
var DHCP_PD_ENABLE=700;
var gw_gm_31=701;
var help271=702;
var help33=703;
var IPNAT_TCP_BLOCKED_INGRESS_BAD_ACK=704;
var htsc_pingt_p=705;
var tf_CKN=706;
var wprn_cps=707;
var up_tz_45=708;
var help84=709;
var GW_FW_NOTIFY_FIRMWARE_AVAIL=710;
var ss_RXPD=711;
var WEB_FILTER_LOG_URL_BLOCKED_MAC=712;
var IPPORTTRIGGERALG_TCP_PACKET_ALLOC_FAILURE=713;
var dlink_1_bw1_schld_help=714;
var wwa_note_hostname=715;
var ai_Action=716;
var RUNTIME_CONFIG_RESET_CONFIG_TO_FACTORY_DEFAULTS=717;
var sps_nopr=718;
var gw_hours=719;
var _Fri=720;
var tps_lpd=721;
var tf_FWUg=722;
var anet_wp_0=723;
var gw_gm_4=724;
var help373=725;
var tt_dsoffs=726;
var wwz_auto_assign_key=727;
var gw_gm_15=728;
var wwl_s3_note_1=729;
var hhts_save=730;
var at_Auto=731;
var tsc_pingt_msg100=732;
var IPPPPIPCP_PPP_LINK_DOWN=733;
var aa_AT=734;
var gw_gm_71=735;
var aa_wiz_s1_msg3=736;
var BIGPOND_FAILED=737;
var help898=738;
var bwn_PPTPSIPA=739;
var _routing=740;
var hham_intro=741;
var WIFISC_IR_REGISTRATION_FAIL_3=742;
var ai_intro_1=743;
var wwa_title_s2=744;
var up_tz_69=745;
var IPMSCHAP_AUTH_RESULT=746;
var tss_intro2=747;
var help354=748;
var up_tz_19=749;
var ta_alert_5=750;
var bd_DAB=751;
var _WPAenterprise=752;
var GW_INET_ACCESS_DROP_ACCESS_CONTROL_MAC=753;
var sps_pr=754;
var up_tz_34=755;
var _psk=756;
var _dyndns=757;
var _deny=758;
var IPNAT_TCP_BLOCKED_INGRESS_UNEXP_FLAGS=759;
var help276=760;
var _to=761;
var aa_AT_0=762;
var dlink_hhwf_intro=763;
var tt_Dec=764;
var help879=765;
var GW_INET_ACCESS_POLICY_START_OTHERS=766;
var up_tz_75=767;
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
var help262=800;
var _allow=801;
var help798=802;
var DHCP_CLIENT_GOT_LEASE=803;
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
var tsc_pingt_msg102=831;
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
var KR49=875;
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
var KR58_ww=898;
var YM98=899;
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
var GW_DYNDNS_PASSWORD_INVALID=910;
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
var sto_no_dev=942;
var wwz_auto_assign_key2=943;
var bwl_NSS=944;
var up_tz_15=945;
var help880=946;
var IPL2TP_TUNNEL_CONNECTING=947;
var bwn_mici_guest_use_shareport=948;
var NET_RTC_SYNCHRONIZED=949;
var up_tz_10=950;
var _on=951;
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
var tsc_pingt_mesg=987;
var up_tz_44=988;
var help27=989;
var as_IPSec=990;
var _admin=991;
var gw_gm_65=992;
var tf_intro_FWChB=993;
var BLOCKED=994;
var wwa_msg_bigpond=995;
var help857=996;
var help819_5=997;
var aw_TP_2=998;
var help385=999;
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
var help828=1054;
var GW_SMTP_EMAIL_FAILED_DNS=1055;
var help810=1056;
var _WOL=1057;
var bwn_RM_1=1058;
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
var help824=1090;
var hham_add=1091;
var ss_WANStats=1092;
var GW_WAN_CONNECT_ON_ACTIVE=1093;
var aa_sched_conf_1=1094;
var GW_INET_ACCESS_POLICY_END_OTHERS=1095;
var bd_title_list=1096;
var _aa_logging=1097;
var IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET=1098;
var _username=1099;
var gw_gm_67=1100;
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
var aa_AT_2=1115;
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
var help888=1162;
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
var anet_multicast_enhanced=1184;
var gw_gm_8=1185;
var _WPA=1186;
var help897=1187;
var IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ=1188;
var tsc_pingt_msg7=1189;
var tt_Jan=1190;
var gw_gm_5=1191;
var _adwwls=1192;
var tsc_pingt_msg101=1193;
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
var sto_http_1=1209;
var wprn_foo1=1210;
var help355=1211;
var aa_ACR_c6=1212;
var bws_2RSSS=1213;
var help391=1214;
var _PM=1215;
var help174=1216;
var PPPOE_EVENT_DISCOVERY_TIMEOUT=1217;
var WCN_LOG_NO_WSETTING=1218;
var psPaperError=1219;
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
var _ping=1231;
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
var bwn_intro_ICS_v6=1246;
var help81=1247;
var help833=1248;
var tps_intro3=1249;
var ss_Sent=1250;
var help378=1251;
var gw_gm_80=1252;
var _uploadgood=1253;
var KR38=1254;
var wprn_s3c=1255;
var haf_dmz_20=1256;
var help343=1257;
var ss_Received=1258;
var help263=1259;
var _bsecure_free_trial=1260;
var tf_FUNO=1261;
var aw_sgi=1262;
var help386=1263;
var help254_ict=1264;
var help254_ict_3G=1265;
var _aa_wiz_s5_msg1=1266;
var td_VPWK=1267;
var gw_gm_33=1268;
var gw_gm_0=1269;
var _macfilt=1270;
var TA16=1271;
var bd_DAB_note=1272;
var help796=1273;
var tf_really_FWF=1274;
var up_tz_05=1275;
var tt_time_16=1276;
var help861=1277;
var help19=1278;
var bwn_DWM=1279;
var _ICMP=1280;
var gw_gm_22=1281;
var help868=1282;
var IPV6_TEXT24=1283;
var tt_time_6=1284;
var _501_12=1285;
var hhac_en=1286;
var int_LWlsWz=1287;
var at_STR=1288;
var tt_Aug=1289;
var am_FM_4=1290;
var aa_wiz_s1_msg5=1291;
var ACCESS_CONTROL=1292;
var GW_DYNDNS_HERROR=1293;
var sps_ports=1294;
var help851=1295;
var hhag_20=1296;
var aa_alert_7=1297;
var af_DI=1298;
var tf_ADS=1299;
var tsc_pingt=1300;
var sl_VLevs=1301;
var wwl_enc=1302;
var help151=1303;
var hhta_pt=1304;
var GW_INET_ACCESS_DROP_ACCESS_CONTROL=1305;
var te_EnAuth=1306;
var WIFISC_AP_PROXY_PROCESS_CLOSE=1307;
var bd_CName=1308;
var help305rt=1309;
var li_alert_3=1310;
var GW_DYNDNS_UPDATE_TO=1311;
var tt_week_4=1312;
var tt_Day=1313;
var GW_LAN_CARRIER_LOST=1314;
var hhai_action=1315;
var help121=1316;
var bwl_Intro_1=1317;
var wwa_msg_set_pppoe=1318;
var IPNAT_ICMP_BLOCKED_INGRESS_PACKET=1319;
var tf_intro_FWU2=1320;
var at_ESE=1321;
var _bsecure_security_blurb=1322;
var bd_DHCP=1323;
var help865=1324;
var wwl_s4_intro_z1=1325;
var help501=1326;
var help280=1327;
var help775=1328;
var _connect=1329;
var GW_BIGPOND_INIT=1330;
var _always=1331;
var _minutes=1332;
var as_IPR_b=1333;
var _aa_bsecure_employment=1334;
var GW_INET_ACCESS_DROP_BAD_PKT=1335;
var gw_gm_12=1336;
var gw_gm_25=1337;
var help846=1338;
var tt_alert_1only=1339;
var gw_gm_76=1340;
var GW_LOGS_VIEWED=1341;
var bws_msg_EAP=1342;
var WIFISC_IR_REGISTRATION_INPROGRESS=1343;
var hhsa_intro=1344;
var help856=1345;
var sa_Dir=1346;
var _bln_title_IGMPMemberships=1347;
var bwn_Mode_L2TP=1348;
var _Thu=1349;
var KR30=1350;
var help184=1351;
var _worksbest=1352;
var _unavailable=1353;
var IPFAT_INCOMPATIBLE_FILESYS=1354;
var IPNAT_TCP_BLOCKED_INGRESS_NOT_SYN=1355;
var up_tz_04=1356;
var sl_ApplySt=1357;
var IPPPPCHAP_CHALLENGE_RECVD=1358;
var help141=1359;
var bd_Revoke=1360;
var wprn_intro3=1361;
var _conuptime=1362;
var wprn_tt4=1363;
var help383=1364;
var tsc_pingt_msg6=1365;
var help821a=1366;
var PPPOE_EVENT_SESSION_OFFER_RECVD=1367;
var gw_gm_30=1368;
var bi_man=1369;
var help60=1370;
var ta_RAP=1371;
var bwn_Mode_BigPond=1372;
var wprn_cps2=1373;
var tt_dststart=1374;
var help164_1=1375;
var IPMSCHAP_AUTH_TIMEOUT=1376;
var sl_emailLog=1377;
var bwl_title_1=1378;
var bwn_BPP=1379;
var sl_reload=1380;
var wwl_title_s1=1381;
var IPDRIVE_MOUNT_FAILED=1382;
var int_ConWz=1383;
var sto_permi=1384;
var help329=1385;
var IPL2TP_TUNNEL_DISCONNECTED=1386;
var help830=1387;
var help294=1388;
var up_tz_21=1389;
var tf_LFWD=1390;
var GW_BIGPOND_SUCCESS=1391;
var _denyall=1392;
var at_AC=1393;
var bwl_VS=1394;
var help327=1395;
var wprn_s2a=1396;
var td_=1397;
var PPTP_EVENT_TUNNEL_WINDOW_TIMEOUT=1398;
var aw_TP=1399;
var bwn_SIAICT=1400;
var help57=1401;
var tt_dsen2=1402;
var _sdi_s5=1403;
var wprn_man=1404;
var tt_time_3=1405;
var bwn_note_clientSW=1406;
var up_tz_20=1407;
var RIP_LOW_RESOURCES=1408;
var help266=1409;
var CONNECTED=1410;
var help265_5=1411;
var tsc_Days=1412;
var up_tz_13=1413;
var sd_General=1414;
var hhan_upnp=1415;
var help35=1416;
var help18=1417;
var bwz_psw=1418;
var tt_DaT=1419;
var help190=1420;
var help819_2=1421;
var bwn_MIT=1422;
var hhai_name=1423;
var te__title_EmLog=1424;
var up_tz_47=1425;
var IPSMTPCLIENT_DIALOG_FAILED=1426;
var hham_del=1427;
var wwa_msg_ispnot=1428;
var help808=1429;
var PPTP_EVENT_TUNNEL_ESTABLISH_REQUEST=1430;
var help37=1431;
var WCN_LOG_REBOOT=1432;
var PPTP_EVENT_TUNNEL_CONNECT_FAIL=1433;
var bwl_CWM=1434;
var up_tz_12=1435;
var _cancel=1436;
var IPV6_ULA_TEXT02=1437;
var af_ED=1438;
var up_tz_38=1439;
var aw_DI=1440;
var up_tz_31=1441;
var hhai_delete=1442;
var av_intro_vs=1443;
var av_intro_if=1444;
var GW_WAN_RECONNECT_ALWAYS_ON=1445;
var wwl_WSP=1446;
var INGRESS=1447;
var RESTRICTED=1448;
var bwn_msg_DHCPDesc=1449;
var help390=1450;
var KR58=1451;
var help867=1452;
var GW_WAN_CONNECT_ALWAYS_ON=1453;
var IPRTSPALG_REJECTED_ODD_RTP_PACKET=1454;
var help60f=1455;
var gw_gm_10=1456;
var bwn_min=1457;
var tt_Month=1458;
var wwz_wpa_support=1459;
var tf_CFWD=1460;
var _advnetwork=1461;
var bwn_PPPOEICT=1462;
var help389=1463;
var help844=1464;
var tt_time_17=1465;
var help284=1466;
var GW_WIRELESS_DEVICE_ASSOCIATED=1467;
var bws_2RMAA=1468;
var as_SIP=1469;
var help704=1470;
var WIFISC_IR_REGISTRATION_FAIL_1=1471;
var up_tz_25=1472;
var help55=1473;
var GW_WLAN_LINK_UP=1474;
var bln_EnDNSRelay=1475;
var ai_title_IFR=1476;
var _PPTP=1477;
var _both=1478;
var up_tz_40=1479;
var wprn_tt8=1480;
var tps_dsr=1481;
var at_Prot_1=1482;
var help875=1483;
var awsf_p=1484;
var wwl_s4_intro_z2=1485;
var wwa_set_l2tp_msg=1486;
var up_tz_42=1487;
var _error=1488;
var aa_FPR_c4=1489;
var tt_EnNTP=1490;
var network_dhcp_ip_in_server=1491;
var tf_msg_wired=1492;
var wwa_title_set_pppoe=1493;
var help10=1494;
var bwl_CWM_h2=1495;
var dlink_1_add_new=1496;
var help884=1497;
var rb_Rebooting=1498;
var help819_6=1499;
var tt_time_10=1500;
var help199=1501;
var help259=1502;
var af_algconfig=1503;
var wwa_msg_pptp=1504;
var bws_2RIPA=1505;
var _aa_wiz_s4_title=1506;
var wwa_note_svcn=1507;
var help85=1508;
var help304=1509;
var GW_INET_ACCESS_DROP_PORT_FILTER_WITH_PORT=1510;
var sd_BPSt=1511;
var up_tz_49=1512;
var gw_gm_62=1513;
var BIGPOND_LOGGED_OUT=1514;
var tf_EmNew=1515;
var GW_INET_ACCESS_INITIAL_MAC_FAIL=1516;
var help303=1517;
var wwa_selectisp_not=1518;
var IPNAT_TCP_BLOCKED_EGRESS_BAD_ACK=1519;
var help94=1520;
var gw_gm_70=1521;
var IPNAT_ICMP_UNABLE_TO_HANDLE_HEADER=1522;
var _FTP=1523;
var _neft=1524;
var ta_A12n=1525;
var gw_gm_83=1526;
var GW_BIGPOND_LOGOUT=1527;
var help46=1528;
var hhsl_intro=1529;
var help770=1530;
var wwa_msg_set_pptp=1531;
var GW_FW_NOTIFY_FAILED_DNS=1532;
var gw_gm_40=1533;
var bln_IGMP_title_h=1534;
var hhaw_11d=1535;
var up_jt_2=1536;
var GW_INET_ACCESS_POLICY_START_MAC=1537;
var wwa_msg_pppoe=1538;
var help323=1539;
var ta_intro1=1540;
var tt_week_3=1541;
var _dhcpsrv=1542;
var Dynamic_PPPoE=1543;
var help102=1544;
var GW_DHCP_SERVER_WINS_MODE_INVALID=1545;
var help107=1546;
var gw_gm_69=1547;
var aa_ACR_c5=1548;
var help331=1549;
var bwz_note_WlsWz=1550;
var help345=1551;
var hhav_name=1552;
var av_PriP=1553;
var tsc_pingt_msg103=1554;
var help_upnp_2=1555;
var WAN_MODE_INCORRECT=1556;
var wwl_alert_pv5_2_5=1557;
var _aa_wiz_s5_title=1558;
var KR22_ww=1559;
var _aa_wiz_s7_help=1560;
var IPL2TP_SEQUENCING_DEACTIVATED=1561;
var tps_apc=1562;
var up_tz_09=1563;
var tt_Jul=1564;
var GW_WAN_INTERFACE_DOWN=1565;
var WCN_LOG_RESTORE=1566;
var gw_gm_17=1567;
var GW_INET_ACCESS_INITIAL_IP=1568;
var _wizquit=1569;
var tss_intro=1570;
var help318=1571;
var tsl_intro=1572;
var tt_time_4=1573;
var tt_time_21=1574;
var IPL2TP_SESSION_CONNECTED=1575;
var aw_FT=1576;
var _save=1577;
var at_NEst=1578;
var af_EFT_h0=1579;
var _firmware=1580;
var gw_gm_43=1581;
var wps_messgae1_1=1582;
var IPL2TP_SHUTDOWN_STARTED=1583;
var ss_TXPD=1584;
var up_tz_55=1585;
var wwa_intro_online2=1586;
var help50=1587;
var help70=1588;
var help188_wmm=1589;
var bd_title_SDC=1590;
var up_tz_60=1591;
var gw_gm_54=1592;
var help396=1593;
var GW_ADMIN_LOGOUT=1594;
var gw_gm_44=1595;
var ta_EUPNP=1596;
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
var IPV6_TEXT105=1612;
var sps_port=1613;
var help164_2=1614;
var help881=1615;
var _destip=1616;
var help840=1617;
var wwa_l2tp_svra=1618;
var tt_dsdates=1619;
var help34b=1620;
var tt_time_11=1621;
var td_EnDDNS=1622;
var help786=1623;
var bwn_UN=1624;
var aa_alert_8=1625;
var wprn_tt2=1626;
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
var ES_cable_lost_desc=1638;
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
var help189a=1677;
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
var help80b=1742;
var help168c=1743;
var BIGPOND_LOGGING_IN=1744;
var wwa_wanmode_pptp=1745;
var help58=1746;
var help885=1747;
var ddns_connected=1748;
var ub_Upload_Failed=1749;
var WIFISC_AP_PROXY_END_ON_MSG=1750;
var help278=1751;
var KR18=1752;
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
var _pwsame_admin=1769;
var GW_DYNDNS_UPDATE_IP=1770;
var GW_DHCPSERVER_NEW_ASSIGNMENT=1771;
var as_WM=1772;
var up_tz_03=1773;
var KR43=1774;
var YM177=1775;
var help774=1776;
var hhac_edit=1777;
var up_tz_36=1778;
var _hostname=1779;
var GW_INET_ACCESS_INITIAL_FAIL=1780;
var GW_WEB_FILTER_INITIAL_FAIL=1781;
var te_OnFull=1782;
var wwl_title_s4=1783;
var help281=1784;
var gw_gm_77=1785;
var _clonemac=1786;
var hhss_intro=1787;
var at_MUS=1788;
var hhan_wans=1789;
var YM141=1790;
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
var ip_mac_binding_desc=1827;
var LW50=1828;
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
var wps_messgae1_2=1853;
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
var ss_intro_user=1869;
var GW_SCHEDULES_NAME_RESERVED_INVALID=1870;
var LW12=1871;
var YM75=1872;
var GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID=1873;
var GW_WLAN_WPA_REKEY_TIME_INVALID=1874;
var bws_msg_WEP_1=1875;
var YM125=1876;
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
var YM86=1892;
var GW_WAN_MAC_ADDRESS_INVALID=1893;
var IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT=1894;
var YM146=1895;
var LS151=1896;
var GW_QOS_RULES_NAME_INVALID=1897;
var GW_NAT_VS_PROTO_CONFLICT_INVALID=1898;
var GW_WISH_RULES_NAME_INVALID=1899;
var WIFISC_IR_REGISTRATION_FAIL=1900;
var r_rlist=1901;
var IPV6_TEXT109=1902;
var bws_WKL_1=1903;
var help473=1904;
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
var KR971=1920;
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
var help643=1970;
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
var gw_gm_35=1981;
var YM7=1982;
var YM124g=1983;
var GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID=1984;
var YM66=1985;
var manul_conn_13=1986;
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
var help172=2010;
var _aa_bsecure_lifestyles=2011;
var GW_NAT_DMZ_NOT_IN_SUBNET_INVALID=2012;
var sd_TMode=2013;
var GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID=2014;
var GW_QOS_RULES_LOCAL_IP_END_SUBNET=2015;
var bws_CT_2=2016;
var _bsecure_parental_limits=2017;
var aw_64=2018;
var _aa_bsecure_humor=2019;
var KR92=2020;
var KR13=2021;
var GW_INET_ACL_POLICY_NAME_DUPLICATE_INVALID=2022;
var YM136=2023;
var TA3=2024;
var help360=2025;
var YM10=2026;
var GW_WAN_PPTP_SERVER_IP_ADDRESS_INVALID=2027;
var YM150=2028;
var GW_DHCP_SERVER_RESERVATION_IN_USE=2029;
var GW_NAT_INPUT_PORT=2030;
var WIFISC_AP_REBOOT_COMPLETE=2031;
var YM182=2032;
var LW3=2033;
var YM116=2034;
var LW22=2035;
var OOPS=2036;
var YM158=2037;
var ZM16=2038;
var _aa_bsecure_select_age=2039;
var GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID=2040;
var WIFISC_AP_RESET_COMPLETE=2041;
var bd_NETBIOS_REG=2042;
var GW_LAN_GATEWAY_IP_ADDRESS_INVALID=2043;
var KR96=2044;
var GW_XML_CONFIG_GET_SUCCESS=2045;
var GW_UPNP_IGD_PORTMAP_REFRESH=2046;
var bws_msg_WPA_2=2047;
var GW_LAN_IP_ADDRESS_INVALID=2048;
var KR5=2049;
var help88c=2050;
var GW_INET_ACL_SCHEDULE_NAME_INVALID=2051;
var GW_QOS_RULES_REMOTE_PORT=2052;
var GW_NAT_IP_ADDRESS_INVALID=2053;
var help369=2054;
var help48a=2055;
var LW38=2056;
var GW_DYNDNS_USER_NAME_INVALID=2057;
var hhav_r_dest_ip=2058;
var YM175=2059;
var LY3=2060;
var GW_UPNP_IGD_PORTMAP_ADD=2061;
var GW_UPNP_IGD_PORTMAP_CONFLICT=2062;
var KRA1=2063;
var _vs_port=2064;
var GW_INET_ACL_RECONFIGURED_WARNING=2065;
var help186=2066;
var YM145=2067;
var WIFISC_AP_UNSET_SELECTED_REGISTRAR=2068;
var GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID=2069;
var YM72=2070;
var _hints=2071;
var GW_QOS_RULES_LOCAL_PORT=2072;
var YM52=2073;
var _aa_bsecure_chat=2074;
var help104=2075;
var help839=2076;
var YM99=2077;
var _aa_bsecure_byage=2078;
var GW_INET_ACL_NAME_DUPLICATE_INVALID=2079;
var GW_DHCP_SERVER_POOL_TO_INVALID=2080;
var KR26=2081;
var YM92=2082;
var GW_DHCP_SERVER_RESERVED_IP_INVALID=2083;
var help19x1=2084;
var _aa_bsecure_unstable=2085;
var GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID=2086;
var GW_FIREWALL_FILTER_NAME_INVALID=2087;
var ZM19=2088;
var YM80=2089;
var bd_NETBIOS_WINS_2=2090;
var KR57=2091;
var YM164=2092;
var _logsyslog_alert2=2093;
var YM149=2094;
var LT120=2095;
var KR48=2096;
var GW_WAN_RECONNECT_INTERVAL_INVALID=2097;
var YM139=2098;
var YM61=2099;
var GW_NAT_VIRTUAL_SERVER_TABLE_RECONFIGURED_WARNING=2100;
var YM1=2101;
var bws_WKL=2102;
var wps_p3_2=2103;
var KR102=2104;
var GW_QOS_RULES_LOCAL_IP_START_SUBNET=2105;
var GW_WAN_PPTP_IP_ADDRESS_INVALID=2106;
var _aa_bsecure_alcohol=2107;
var YM14=2108;
var GW_WLAN_11B_DYNAMIC_TURBO_INVALID=2109;
var GW_UPNP_IGD_PORTMAP_EXPIRE=2110;
var TA18=2111;
var aw_erpe_h2=2112;
var YM21=2113;
var YM147=2114;
var KR68=2115;
var LW61=2116;
var GW_WAN_L2TP_USERNAME_INVALID=2117;
var LT120z=2118;
var KR97=2119;
var GW_WAN_L2TP_SUBNET_INVALID=2120;
var help_ts_ss=2121;
var _aa_bsecure_automobile=2122;
var LW13=2123;
var sch_time=2124;
var bws_intro_WlsSec=2125;
var GW_WAN_PPPOE_PASSWORD_INVALID=2126;
var help211=2127;
var LS202=2128;
var tsc_EndTime=2129;
var KR34=2130;
var _wepkey3=2131;
var at_RePortR=2132;
var help640=2133;
var GW_SMTP_SERVER_ADDRESS_INVALID=2134;
var GW_WAN_L2TP_GATEWAY_IP_ADDRESS_INVALID=2135;
var LW58=2136;
var LW22usekey=2137;
var GW_WLAN_11B_STATIC_TURBO_INVALID=2138;
var YM67=2139;
var GW_WIFISC_CFG_CHANGED_WARNING=2140;
var ZM10=2141;
var GW_WLAN_11A_CHANNEL_INVALID=2142;
var at_title_SERules=2143;
var YM176=2144;
var KR81=2145;
var GW_NAT_TCP_PORT=2146;
var YM155=2147;
var help365=2148;
var bd_NETBIOS_SCOPE=2149;
var KR28=2150;
var _webfilter=2151;
var YM33=2152;
var YM76=2153;
var WIFISC_AP_SETUP_UNLOCKED=2154;
var GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT=2155;
var LS313=2156;
var bwz_WCNWz=2157;
var ZM9=2158;
var GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID=2159;
var LY5=2160;
var YM87=2161;
var GW_NAT_WAN_PING_FILTER_INVALID=2162;
var help835=2163;
var at_lowpriority=2164;
var YM49=2165;
var GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID=2166;
var YM112=2167;
var KR90=2168;
var help838=2169;
var help892=2170;
var KR73=2171;
var wwl_intro_s3_2=2172;
var _r_alert5=2173;
var GW_NAT_WAN_PING_FILTER_WARNING=2174;
var YM53=2175;
var help215=2176;
var YM140=2177;
var GW_DHCPSERVER_REJECTED=2178;
var YM142=2179;
var GW_SMTP_PASSWORD_INVALID=2180;
var YM152=2181;
var LT119a=2182;
var LW36=2183;
var help377=2184;
var GW_NAT_PORT_TRIGGER_PORT_RANGE_INVALID=2185;
var YM121=2186;
var YM29=2187;
var YM159=2188;
var YM120=2189;
var wwl_BETTER=2190;
var hhaf_dmz=2191;
var YM106=2192;
var _aa_bsecure_block_unrated=2193;
var GW_WAN_BIGPOND_USERNAME_INVALID=2194;
var KR76=2195;
var GW_DHCPSERVER_EXHAUSTED=2196;
var GW_WAN_L2TP_SERVER_IP_ADDRESS_INVALID=2197;
var wwl_alert_pv5_2=2198;
var GW_ROUTES_SUBNET_INVALID=2199;
var _aa_bsecure_drugs=2200;
var LW1=2201;
var GW_DHCPSERVER_EXPIRED=2202;
var GW_INET_ACL_IP_ADDRESS_IN_LAN_SUBNET_INVALID=2203;
var bd_NETBIOS_REG_TYPE_B=2204;
var _aa_bsecure_financial=2205;
var YM135=2206;
var LT119=2207;
var _vs_public=2208;
var KR93=2209;
var GW_SECURE_REMOTE_ADMINSTRATION=2210;
var YM160=2211;
var LS423=2212;
var GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID=2213;
var GW_WISH_RULES_HOST1_IP=2214;
var _vs_private=2215;
var KR86=2216;
var bd_NETBIOS_SEC_WINS=2217;
var GW_INET_ACL_START_IP_ADDRESS_INVALID=2218;
var auth=2219;
var KR24=2220;
var KR17=2221;
var YM84=2222;
var help88=2223;
var hhta_en=2224;
var YM103=2225;
var KR64=2226;
var GW_WLAN_11A_DFS_CHANNEL_INVALID=2227;
var LW4=2228;
var help645=2229;
var GW_WLAN_11A_STATIC_TURBO_INVALID=2230;
var help358=2231;
var YM6=2232;
var _aa_bsecure_categ_select=2233;
var YM58=2234;
var _aa_bsecure_age_youth=2235;
var LW17=2236;
var YM18=2237;
var LT210=2238;
var GW_WAN_IDLE_TIME_INVALID=2239;
var YM186=2240;
var _aa_bsecure_sports=2241;
var GW_QOS_RULES_NAME_ALREADY_USED=2242;
var bwz_intro_WCNWz=2243;
var GW_DHCP_SERVER_POOL_TO_IN_SUBNET_INVALID=2244;
var GW_NAT_H323_ALG_ACTIVATED_WARNING=2245;
var KR4=2246;
var LT120y=2247;
var KR103=2248;
var YM44=2249;
var LW47=2250;
var GW_XML_CONFIG_GET_FAILED=2251;
var WIFISC_AP_SET_APSETTINGS_COMPLETE=2252;
var wwl_WKL=2253;
var YM168=2254;
var GW_NAT_NAME_USED_INVALID=2255;
var GW_DYNDNS_SERVER_INDEX_VALUE_INVALID=2256;
var WARN=2257;
var LW23=2258;
var ADVANCED_NETWORK=2259;
var GW_WAN_PPTP_PASSWORD_INVALID=2260;
var LW59=2261;
var YM126=2262;
var _enabled=2263;
var _r_alert4=2264;
var LY10=2265;
var GW_DHCP_SERVER_POOL_FROM_INVALID=2266;
var WIFISC_AP_SETUP_LOCKED=2267;
var YM91=2268;
var WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL=2269;
var _ask_nochange=2270;
var GW_NAT_UNKNOWN=2271;
var GW_WLAN_11A_DYNAMIC_TURBO_INVALID=2272;
var YM163=2273;
var YM181=2274;
var _cantapplysettings_1=2275;
var YM11=2276;
var wwl_wsp_chars_2=2277;
var bd_NETBIOS_PRI_WINS=2278;
var wwl_DWKL=2279;
var KR44=2280;
var TEXT056=2281;
var YM130=2282;
var KR99=2283;
var GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID=2284;
var KR106=2285;
var GW_NAT_VS_PROTOCOL_INVALID=2286;
var KR52=2287;
var KR33=2288;
var ZM23=2289;
var LW40=2290;
var LY4=2291;
var LW34=2292;
var YM25=2293;
var YM15=2294;
var bwl_SGM=2295;
var GW_WLAN_80211X_RADIUS_INVALID=2296;
var GW_WISH_RULES_PROTOCOL=2297;
var LS316=2298;
var ZM15=2299;
var GW_DHCP_SERVER_RESERVATION_DISABLED_IN_CONFLICT_WARNING=2300;
var GW_DYNDNS_HOST_NAME_INVALID=2301;
var LW42=2302;
var GW_WAN_PPTP_GATEWAY_IP_ADDRESS_INVALID=2303;
var rs_intro_4=2304;
var GW_QOS_RULES_REMOTE_IP_END_SUBNET=2305;
var _NA=2306;
var hhav_r_gateway=2307;
var INFO=2308;
var help112=2309;
var tf_msg_FWUgReset=2310;
var bd_NETBIOS_WAN=2311;
var aw_igslot=2312;
var ZM2=2313;
var LT7=2314;
var WIFISC_AP_SET_SELECTED_REGISTRAR=2315;
var help214=2316;
var at_Both=2317;
var ZM22=2318;
var help_ts_rfd=2319;
var LW44=2320;
var help209=2321;
var YM70=2322;
var GW_UPNP_IGD_PORTMAP_VS_CHANGE=2323;
var help143s=2324;
var help363=2325;
var _aa_bsecure_web_newsgroup=2326;
var YM128=2327;
var GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID=2328;
var KR72=2329;
var td_PWK=2330;
var YM82=2331;
var YM119=2332;
var KR70=2333;
var YM161=2334;
var GW_DHCP_SERVER_POOL_SIZE_INVALID=2335;
var _sdi_s4b=2336;
var ZM8=2337;
var YM129=2338;
var help370=2339;
var LY29=2340;
var GW_XML_CONFIG_WRITE_WARN=2341;
var GW_FIREWALL_NAME_INVALID=2342;
var GW_WISH_RULES_HOST2_IP=2343;
var TA2=2344;
var LS314=2345;
var _vs_traffictype=2346;
var GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID=2347;
var wps_p3_4=2348;
var KR51=2349;
var GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID=2350;
var help837=2351;
var TEXT052=2352;
var OPEN=2353;
var _aa_bsecure_news=2354;
var YM34=2355;
var _advwls=2356;
var GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING=2357;
var GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID=2358;
var _wepkey4=2359;
var LT124=2360;
var _aa_bsecure_search_engine=2361;
var KR47=2362;
var bws_msg_WEP_3=2363;
var GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING=2364;
var GW_LAN_IP_MODE_INVALID=2365;
var GW_WAN_BIGPOND_SERVER_NOTSTD15=2366;
var IPV6_TEXT101=2367;
var GW_WLAN_FRAGMENT_THRESHOLD_INVALID=2368;
var GW_LAN_DOMAIN_NAME_INVALID=2369;
var GW_LAN_DEVICE_NAME_INVALID=2370;
var _wifisc_overlap=2371;
var LW62=2372;
var KR23=2373;
var _aa_bsecure_pornography=2374;
var GW_NAT_NAME_INVALID=2375;
var bd_title_clients=2376;
var YM108=2377;
var YM19=2378;
var WIFISC_AP_PROXY_PROCESS_COMPLETE=2379;
var GW_NAT_ENTRY_DUPLICATED_INVALID=2380;
var GW_NAT_PORT_FORWARD_CONFLICT_INVALID=2381;
var LW27=2382;
var YM38=2383;
var tt_alert_nontp=2384;
var LY2=2385;
var KR29=2386;
var KR31=2387;
var _init_fail=2388;
var YM68=2389;
var sd_macaddr=2390;
var KR12=2391;
var help366=2392;
var WIFISC_AP_REGISTRATION_COMPLETE=2393;
var aw_TPC=2394;
var aw_WDSMAC=2395;
var YM62=2396;
var aw_erpe_h=2397;
var GW_WAN_RECONNECT_MODE_INVALID=2398;
var WIFISC_AP_DEL_APSETTINGS_COMPLETE=2399;
var LW15=2400;
var LW33=2401;
var KR27=2402;
var YM138=2403;
var GW_NAT_VS_PORT_CONFLICT_INVALID=2404;
var bd_NETBIOS_WINS_1=2405;
var _aa_wiz_s6_title=2406;
var YM77=2407;
var YM48=2408;
var YM89=2409;
var GW_WLAN_WPA_PSK_HEX_STRING_INVALID=2410;
var GW_WAN_WAN_IP_ADDRESS_INVALID=2411;
var LS4=2412;
var KR98=2413;
var YM148=2414;
var bws_WPAM_2=2415;
var help877a=2416;
var KR56=2417;
var LS424=2418;
var GW_DHCPSERVER_DECLINED=2419;
var GW_SCHEDULES_DAY_INVALID=2420;
var GW_NAT_UDP=2421;
var IPSMTPCLIENT_CANNOT_CREATE_CONNECTION=2422;
var _aa_check_all=2423;
var YM94=2424;
var LS312=2425;
var KR2=2426;
var _vs_proto=2427;
var GW_SMTP_TO_ADDRESS_INVALID=2428;
var WIFISC_AP_REGISTRATION_FAIL=2429;
var GW_WISH_RULES_NAME_ALREADY_USED=2430;
var LW48=2431;
var YM54=2432;
var LW9=2433;
var LW41=2434;
var ebwl_AChan=2435;
var GW_WLAN_RTS_THRESHOLD_INVALID=2436;
var GW_WAN_L2TP_PASSWORD_INVALID=2437;
var YM12=2438;
var ZM14=2439;
var KR60=2440;
var YM28=2441;
var YM184=2442;
var int_intro_WCNWz7=2443;
var bws_Auth_2=2444;
var rs_intro_1=2445;
var help92=2446;
var GW_NAT_BOTH=2447;
var rs_success=2448;
var up_tz_29b=2449;
var day=2450;
var GW_DHCP_SERVER_DISABLED_WARNING=2451;
var _password=2452;
var GW_INET_ACCESS_POLICY_MAC_INVALID=2453;
var LW2=2454;
var KR75=2455;
var GW_XML_CONFIG_WRITE_FAILED=2456;
var YM73=2457;
var GW_WISH_RULES_NAME_USED_INVALID=2458;
var GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID=2459;
var aw_AS=2460;
var YM171=2461;
var GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID=2462;
var GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT=2463;
var hhav_r_netmask=2464;
var vs_vslist=2465;
var if_iflist=2466;
var YM137=2467;
var YM74=2468;
var GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID=2469;
var help858=2470;
var GW_MAC_FILTER_MAC_UNIQUENESS_INVALID=2471;
var KR40=2472;
var GW_MAC_FILTER_NULL_MAC_INVALID=2473;
var aw_32=2474;
var GW_WAN_LAN_SUBNET_CONFLICT_INVALID=2475;
var LW66=2476;
var WIFISC_AP_DEL_APSETTINGS_FAIL=2477;
var wwl_wsp_chars_1=2478;
var KR85=2479;
var YM115=2480;
var YM83=2481;
var wwl_128bits=2482;
var LW51=2483;
var YM178=2484;
var _aa_bsecure_cults=2485;
var YM5=2486;
var KR65=2487;
var ZM17=2488;
var LW14=2489;
var ta_wcn_bv=2490;
var GW_NAT_VS_IP_ADDRESS_CAN_NOT_MATCH_ROUTER=2491;
var GW_SCHEDULES_IN_USE_INVALID=2492;
var wepkey3=2493;
var KR69=2494;
var YM43=2495;
var YM45=2496;
var GW_SMTP_USERNAME_INVALID=2497;
var help362=2498;
var tf_intro_FWChA=2499;
var _remotedesktop=2500;
var LW7=2501;
var help359=2502;
var KR84=2503;
var YM30=2504;
var at_LoPortR=2505;
var GW_DHCP_SERVER_POOL_FROM_IN_SUBNET_INVALID=2506;
var GW_MAC_FILTER_MULTICAST_MAC_INVALID=2507;
var GW_SMTP_INIT_FAILED_WARNING=2508;
var GW_DHCPSERVER_STOP=2509;
var help350=2510;
var GW_NAT_DMZ_NOT_ALLOWED_INVALID=2511;
var YM143=2512;
var GW_XML_CONFIG_SET_FAILED=2513;
var GW_NAT_PORT_DUP_INVALID=2514;
var KR46=2515;
var KR35=2516;
var GW_WAN_BIGPOND_PASSWORD_INVALID=2517;
var YM57=2518;
var KR104=2519;
var IPSMTPCLIENT_MSG_WRONG_SENDER_ADDR_FORMAT=2520;
var LS317=2521;
var YM102=2522;
var help188=2523;
var _logsyslog_alert1=2524;
var KR3=2525;
var _aa_bsecure_hate=2526;
var GW_WLAN_11BG_CHANNEL_INVALID=2527;
var RATE_ESTIMATOR_RATE_COMPLETED=2528;
var wwl_alert_pv5_3=2529;
var aw_aggr=2530;
var _wifisc_addstart=2531;
var help111=2532;
var GW_QOS_RULES_REMOTE_IP_START_SUBNET=2533;
var YM22=2534;
var GW_WLAN_WDS_MAC_ADDR_INVALID=2535;
var LW10=2536;
var LT291=2537;
var YM156=2538;
var _aa_bsecure_age_ado=2539;
var wwl_text_good=2540;
var GW_QOS_RULES_PRIORITY_RANGE=2541;
var te_OnSch=2542;
var _aa_bsecure_web_mail=2543;
var help188b=2544;
var GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID=2545;
var at_title_Traff=2546;
var help189=2547;
var GW_WIRELESS_SWITCH_CHANNEL=2548;
var GW_WAN_BIGPOND_SERVER_INVALID=2549;
var GW_XML_CONFIG_SET_PARSE=2550;
var hhaw_wmm=2551;
var LT290wifisc=2552;
var GW_FIREWALL_RULE_NAME_INVALID=2553;
var GW_NAT_SCHEDULE=2554;
var help109=2555;
var GW_LAN_RIP_MODE_INVALID=2556;
var LW52=2557;
var _aa_bsecure_popups=2558;
var GW_WLAN_WPA_WPA2_TKIP_INVALID=2559;
var KR16=2560;
var _vs_title=2561;
var _if_title=2562;
var GW_WAN_PPPOE_USERNAME_INVALID=2563;
var GW_WAN_PPTP_SUBNET_INVALID=2564;
var GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID=2565;
var KR94=2566;
var YM63=2567;
var help108=2568;
var GW_SCHEDULES_DUPLICATED_INVALID=2569;
var bws_WPAM_1=2570;
var KR11=2571;
var LW45=2572;
var KR6=2573;
var GW_DHCP_SERVER_NETBIOS_TYPE_INVALID=2574;
var _aa_bsecure_games=2575;
var KR42=2576;
var YM104=2577;
var _aa_bsecure_tickets=2578;
var KR39=2579;
var bd_NETBIOS_REG_TYPE_M=2580;
var tsc_pingt_msg1=2581;
var GW_UPNP_IGD_PORTMAP_DEL=2582;
var YM111=2583;
var LS315=2584;
var GW_WLAN_WPA_PSK_LEN_INVALID=2585;
var help178=2586;
var YM167=2587;
var help371=2588;
var _aa_bsecure_anarchy=2589;
var YM4=2590;
var _aa_bsecure_criminal_skills=2591;
var YM188=2592;
var YM133=2593;
var YM59=2594;
var _aa_bsecure_manually=2595;
var YM169=2596;
var YM97=2597;
var dlink_help156=2598;
var _aa_bsecure_age_child=2599;
var help375=2600;
var GW_WEB_FILTER_WEBSITE_INVALID_INVALID=2601;
var ZM21=2602;
var YM157=2603;
var help213=2604;
var YM24=2605;
var wps_p3_3=2606;
var LW43=2607;
var help99_s=2608;
var YM90=2609;
var bws_CT_3=2610;
var help371_n=2611;
var GW_DHCP_SERVER_RESERVATION_RECONFIG_WARNING=2612;
var _r_alert3=2613;
var GW_LAN_RIP_METRIC_INVALID=2614;
var YM118=2615;
var YM127=2616;
var KR71=2617;
var aw_WDSEn=2618;
var KR32=2619;
var sa_Local=2620;
var GW_WEB_SERVER_IDLE_TIME=2621;
var KR59=2622;
var GW_WAN_WAN_GATEWAY_IN_SUBNET_INVALID=2623;
var at_LoIPR=2624;
var YM81=2625;
var aw_AP=2626;
var LT290=2627;
var YM162=2628;
var GW_XML_CONFIG_SET_PARSE_MIME=2629;
var GW_NAT_UDP_PORT=2630;
var YM9=2631;
var GW_WAN_MTU_INVALID=2632;
var LW63=2633;
var WIFISC_IR_REGISTRATION_SUCCESS=2634;
var help105=2635;
var GW_DHCPSERVER_RELEASED=2636;
var LW32=2637;
var WIFISC_AP_SET_APSETTINGS_FAIL=2638;
var KR8=2639;
var hhav_r_name=2640;
var bd_NETBIOS_REG_TYPE_H=2641;
var KR55=2642;
var GW_WAN_PPPOE_LAN_SUBNET_CONFLICT_INVALID=2643;
var GW_XML_CONFIG_SET_SUCCESS=2644;
var YM60=2645;
var KR100=2646;
var KR61=2647;
var bws_WKL_0=2648;
var bws_msg_WPA=2649;
var YM109=2650;
var WIFISC_AP_RESET_FAIL=2651;
var GW_WISH_RULES_HOST2_PORT=2652;
var help_ts_ls=2653;
var YM101=2654;
var KR50=2655;
var YM56=2656;
var aa_WebSite_Domain=2657;
var GW_QOS_RULES_MAX_TRANS=2658;
var GW_QOS_RULES_PROTOCOL=2659;
var GW_WEB_SERVER_NO_ACCESS=2660;
var KR87=2661;
var GW_WISH_RULES_DUPLICATED=2662;
var YM16=2663;
var GW_SCHEDULES_NAME_CONFLICT_INVALID=2664;
var wepkey4=2665;
var GW_WEB_SERVER_SAME_PORT_WAN=2666;
var YM65=2667;
var bln_title=2668;
var WIFISC_AP_PROXY_PROCESS_FAIL=2669;
var _more=2670;
var ZM12=2671;
var _aa_bsecure_banner_ad=2672;
var LY23=2673;
var help88b=2674;
var bwl_NSS_h1=2675;
var help203=2676;
var GW_INET_ACL_NO_MACHINE_IN_LAN_SUBNET_INVALID=2677;
var LW39c=2678;
var WIFISC_AP_SET_SELECTED_REGISTRAR_COMPLETE=2679;
var GW_DHCP_CLIENT_CLIENT_NAME_INVALID=2680;
var YM166=2681;
var WIFISC_AP_REBOOT_FAIL=2682;
var help91=2683;
var LW39=2684;
var YM173=2685;
var YM13=2686;
var YM172=2687;
var YM31=2688;
var _aa_wiz_s6_msg=2689;
var S493=2690;
var YM85=2691;
var GW_SCHEDULES_NAME_INVALID=2692;
var LS204=2693;
var aw_16=2694;
var aw_erpe_h3=2695;
var LW64=2696;
var _days=2697;
var at_intro=2698;
var help103=2699;
var YM183=2700;
var YM117=2701;
var KR54=2702;
var av_intro_r=2703;
var help368=2704;
var hhav_enable=2705;
var GW_WAN_DNS_SERVERS_INVALID=2706;
var _rs_succeeded=2707;
var GW_WAN_PPTP_USERNAME_INVALID=2708;
var GW_WAN_L2TP_IP_ADDRESS_INVALID=2709;
var GW_INET_ACL_NAME_INVALID=2710;
var days=2711;
var KR88=2712;
var GW_WAN_PPPOE_IP_ADDRESS_INVALID=2713;
var KR19=2714;
var RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED=2715;
var YM27=2716;
var LT291wifisc=2717;
var KR1=2718;
var YM51=2719;
var ZM13=2720;
var GW_LAN_PRIMARY_DNS_INVALID=2721;
var GW_WLAN_11A_DFS_TURBO_INVALID=2722;
var YM123=2723;
var TA8=2724;
var KR9=2725;
var KR79=2726;
var GW_QOS_RULES_REMOTE_IP=2727;
var _aa_bsecure_age_adult=2728;
var ZM7=2729;
var YM23=2730;
var tf_USSW=2731;
var LW55=2732;
var bwl_EW=2733;
var LS425=2734;
var wwl_WK=2735;
var LW11=2736;
var GW_NAT_PPTP_ALG_ACTIVATED_WARNING=2737;
var YM35=2738;
var tsc_sel_days=2739;
var sc_intro_rb4=2740;
var GW_SCHEDULES_TIME_INVALID=2741;
var GW_DHCP_SERVER_LEASE_TIME_INVALID=2742;
var IPSMTPCLIENT_NO_SERVER_IP_ADDRESS=2743;
var KR10=2744;
var GW_WEB_FILTER_HTTPS_NOT_SUPPORTED_INVALID=2745;
var KR22=2746;
var _vs_both=2747;
var wwl_alert_pv5_4=2748;
var GW_WIFISC_LOCK_VERIFY_ERR=2749;
var LW53=2750;
var GW_WEB_FILTER_WEB_SITE_IS_USED_INVALID=2751;
var YM64=2752;
var GW_ROUTES_INTERFACE_INVALID=2753;
var GW_LAN_SECONDARY_DNS_INVALID=2754;
var bd_NETBIOS_LEARN_FROM_WAN_ENABLE=2755;
var GW_NAT_PORT_FORWARDING_TABLE_RECONFIGURED_WARNING=2756;
var KR15=2757;
var WIFISC_AP_REGISTRATION_UNEXPECTED_EVENT=2758;
var GW_SYSLOG_ADDRESS_NOT_IN_SUBNET_WARNING=2759;
var GW_DHCP_SERVER_NETBIOS_SECONDARY_WINS_INVALID=2760;
var LW49=2761;
var KR95=2762;
var aw_8=2763;
var YM114=2764;
var bws_CT=2765;
var _aa_bsecure_rrated=2766;
var LW6=2767;
var bws_msg_WEP_2=2768;
var GW_QOS_RULES_LOCAL_IP=2769;
var GW_DHCP_SERVER_POOL_FROM_TO_ORIENTATION_INVALID=2770;
var bws_CT_1=2771;
var GW_XML_CONFIG_SET_LOCK=2772;
var GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID=2773;
var wepkey2=2774;
var LW28=2775;
var _wepkey1=2776;
var KR83=2777;
var GW_SYSLOG_ADDRESS_INVALID=2778;
var YM105=2779;
var ZM5=2780;
var help212=2781;
var wps_p3_5=2782;
var help19x2=2783;
var KR36=2784;
var GW_ROUTES_METRIC_INVALID=2785;
var GW_WLAN_SSID_INVALID=2786;
var LS46=2787;
var YM179=2788;
var KR78=2789;
var KR66=2790;
var _aa_bsecure_magazine=2791;
var KR101=2792;
var GW_WLAN_WPA_WPA_AES_INVALID=2793;
var GW_NAT_INBOUND_FILTER=2794;
var GW_INET_ACL_POLICY_NAME_INVALID=2795;
var sa_Internet=2796;
var help406=2797;
var YM153=2798;
var at_ReIPR=2799;
var GW_INET_ACCESS_RESTRICTED=2800;
var GW_WLAN_DTIM_INVALID=2801;
var YM144=2802;
var up_tz_26=2803;
var help71=2804;
var GW_PURE_ADDPORTMAPPING_MODIFY=2805;
var tsc_pingt_msg10=2806;
var tps_foo=2807;
var GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL=2808;
var LOG_PREV_MSG_REPEATED_N_TIMES=2809;
var ca_intro=2810;
var GW_WAN_LAN_ADDRESS_CONFLICT_DHCP=2811;
var help176=2812;
var GW_PURE_ADDPORTMAPPING_CREATE=2813;
var hhag_30=2814;
var hhai_save=2815;
var ADMIN=2816;
var wprn_s1a=2817;
var sl_alert_3=2818;
var help900=2819;
var tps_foo2=2820;
var help182=2821;
var aa_alert_12=2822;
var tf_intro_FWCh=2823;
var ts_ss=2824;
var wwa_title_set_pptp=2825;
var _hostname_eg=2826;
var wwl_s4_note=2827;
var help22=2828;
var wwl_alert_pv5_1=2829;
var GW_PURE_SETWLANSETTINGS24=2830;
var help167=2831;
var at_DxDSL=2832;
var wprn_bados2=2833;
var wprn_s3a=2834;
var wprn_tt10=2835;
var bwn_IF=2836;
var _1044a=2837;
var wprn_tt6=2838;
var help72=2839;
var _sdi_s6=2840;
var hhpt_sch=2841;
var tps_enraw=2842;
var sl_alert_2=2843;
var anet_wp_2=2844;
var tss_RestAll=2845;
var GW_PURE_SETWANSETTINGS=2846;
var help53=2847;
var help175=2848;
var help872=2849;
var help785=2850;
var wprn_s2b=2851;
var wprn_intro2=2852;
var GW_INET_ACL_NO_FILTER_SELECTED_INVALID=2853;
var help890=2854;
var help814=2855;
var help283=2856;
var sps_protdis=2857;
var help831=2858;
var _cantapplysettings=2859;
var help39=2860;
var WCN_LOG_ABORT=2861;
var up_tz_73=2862;
var help141_a=2863;
var af_intro_x=2864;
var help170=2865;
var tps_intro4=2866;
var help893b=2867;
var GW_DHCPSERVER_START=2868;
var help887=2869;
var help38=2870;
var wwl_title_wel=2871;
var help164=2872;
var hhav_filt=2873;
var GW_PURE_ADDPORTMAPPING_CONFLICT=2874;
var GW_PURE_SETROUTERLANSETTINGS=2875;
var GW_PURE_SETWLANSECURITY=2876;
var aa_alert_9=2877;
var help287=2878;
var ta_RAIF=2879;
var help180=2880;
var GW_PURE_SETDEVICESETTINGS=2881;
var _rssi=2882;
var wwl_intro_wel=2883;
var tf_ClickDL=2884;
var help165=2885;
var _vs_other=2886;
var tps_intro5=2887;
var ub_intro_1=2888;
var help277=2889;
var help41=2890;
var VIRTUAL_SERVERS=2891;
var hhav_sch=2892;
var ts_rfd=2893;
var help33b=2894;
var ts_ls=2895;
var wwl_intro_s1=2896;
var GW_PURE_DELETEPORTMAPPING_MODIFY=2897;
var wprn_s2c=2898;
var help320=2899;
var help813=2900;
var help893=2901;
var help803=2902;
var help877=2903;
var up_tz_27=2904;
var help74=2905;
var help155_2=2906;
var _sdi_s4=2907;
var MISC=2908;
var tf_msg_Upping=2909;
var GW_LOG_EMAIL_FAILED=2910;
var help823_17=2911;
var IPV6_TEXT4=2912;
var sa_intro=2913;
var up_rb_2=2914;
var help23=2915;
var _bln_title_IGMPMemberships_h=2916;
var haf_intro_2=2917;
var help802=2918;
var wprn_tt5=2919;
var hhsl_lmail=2920;
var ap_intro_noreboot=2921;
var up_tz_29=2922;
var GW_PURE_SETMACFILTERS2=2923;
var GW_PURE_REBOOT=2924;
var rb_change=2925;
var help816=2926;
var GW_PURE_DELETEPORTMAPPING_DELETE=2927;
var ub_intro_3=2928;
var help30=2929;
var bln_alert_2=2930;
var hhwf_xref=2931;
var GW_REMOTE_ADMINSTRATION=2932;
var wwl_s4_intro=2933;
var sd_SecTyp=2934;
var IPV6_WAN_IP=2935;
var IPV6_TEXT0=2936;
var gw_wcn_alert_3=2937;
var IPV6_TEXT2=2938;
var S473=2939;
var af_ES=2940;
var IPV6_TEXT5=2941;
var IPV6_TEXT6=2942;
var IPV6_TEXT7=2943;
var IPV6_TEXT8=2944;
var IPV6_TEXT9=2945;
var IPV6_TEXT10=2946;
var IPV6_TEXT11=2947;
var IPV6_TEXT12=2948;
var IPV6_TEXT13=2949;
var IPV6_TEXT14=2950;
var IPV6_TEXT15=2951;
var IPV6_TEXT16=2952;
var IPV6_TEXT17=2953;
var IPV6_TEXT18=2954;
var IPV6_TEXT19=2955;
var IPV6_TEXT20=2956;
var IPV6_TEXT21=2957;
var IPV6_TEXT22=2958;
var IPV6_TEXT23=2959;
var DNS_TEXT0=2960;
var IPV6_TEXT25=2961;
var IPV6_TEXT26=2962;
var IPV6_TEXT27=2963;
var IPV6_TEXT28=2964;
var IPV6_TEXT29=2965;
var IPV6_TEXT29a=2966;
var IPV6_TEXT30=2967;
var IPV6_TEXT31=2968;
var IPV6_TEXT32=2969;
var IPV6_TEXT33=2970;
var IPV6_TEXT34=2971;
var IPV6_TEXT35=2972;
var IPV6_TEXT36=2973;
var IPV6_TEXT37=2974;
var IPV6_TEXT38=2975;
var IPV6_TEXT39=2976;
var IPV6_TEXT40=2977;
var IPV6_TEXT41=2978;
var IPV6_TEXT42=2979;
var IPV6_TEXT43=2980;
var IPV6_TEXT44=2981;
var IPV6_TEXT45=2982;
var IPV6_TEXT46=2983;
var IPV6_TEXT47=2984;
var IPV6_TEXT48=2985;
var IPV6_TEXT49=2986;
var TA11=2987;
var IPV6_TEXT51=2988;
var IPV6_TEXT52=2989;
var IPV6_TEXT53=2990;
var IPV6_TEXT54=2991;
var IPV6_TEXT55=2992;
var IPV6_TEXT56=2993;
var IPV6_TEXT57=2994;
var IPV6_TEXT58=2995;
var IPV6_TEXT59=2996;
var IPV6_TEXT60=2997;
var IPV6_TEXT61=2998;
var IPV6_TEXT62=2999;
var IPV6_TEXT63=3000;
var IPV6_TEXT65=3001;
var _aa_bsecure_obscene=3002;
var IPV6_TEXT66=3003;
var IPV6_TEXT67=3004;
var IPV6_TEXT68=3005;
var IPV6_TEXT69=3006;
var IPV6_TEXT70=3007;
var IPV6_TEXT71=3008;
var IPV6_TEXT72=3009;
var IPV6_TEXT73=3010;
var IPV6_TEXT74=3011;
var IPV6_TEXT75=3012;
var IPV6_TEXT76=3013;
var IPV6_TEXT77=3014;
var IPV6_TEXT78=3015;
var IPV6_TEXT79=3016;
var IPV6_TEXT80=3017;
var IPV6_TEXT81=3018;
var IPV6_TEXT82=3019;
var IPV6_TEXT83=3020;
var IPV6_TEXT84=3021;
var IPV6_TEXT85=3022;
var IPV6_TEXT86=3023;
var IPV6_TEXT87=3024;
var IPV6_TEXT88=3025;
var IPV6_TEXT89=3026;
var IPV6_TEXT90=3027;
var IPV6_TEXT91=3028;
var IPV6_TEXT92=3029;
var IPV6_TEXT93=3030;
var IPV6_TEXT94=3031;
var IPV6_TEXT95=3032;
var IPV6_TEXT96=3033;
var IPV6_TEXT97=3034;
var IPV6_TEXT98=3035;
var IPV6_TEXT99=3036;
var IPV6_TEXT100=3037;
var help316=3038;
var IPV6_TEXT102=3039;
var IPV6_TEXT103=3040;
var IPV6_TEXT104=3041;
var IPV6_TEXT108=3042;
var IPV6_TEXT106=3043;
var IPV6_TEXT107=3044;
var IPV6_TEXT50=3045;
var help825=3046;
var IPV6_TEXT110=3047;
var IPV6_TEXT111=3048;
var IPV6_TEXT112=3049;
var IPV6_TEXT113=3050;
var IPV6_TEXT114=3051;
var IPV6_TEXT115=3052;
var IPV6_TEXT116=3053;
var IPV6_TEXT117=3054;
var IPV6_TEXT118=3055;
var IPV6_TEXT119=3056;
var IPV6_TEXT120=3057;
var IPV6_TEXT121=3058;
var IPV6_TEXT122=3059;
var IPV6_TEXT123=3060;
var IPV6_TEXT124=3061;
var IPV6_TEXT125=3062;
var IPV6_TEXT126=3063;
var IPV6_TEXT127=3064;
var IPV6_TEXT128=3065;
var IPV6_TEXT129=3066;
var IPV6_TEXT130=3067;
var IPV6_TEXT131=3068;
var IPV6_TEXT132=3069;
var IPV6_TEXT133=3070;
var IPV6_TEXT134=3071;
var IPV6_TEXT135=3072;
var IPV6_TEXT136=3073;
var IPV6_TEXT137=3074;
var IPV6_TEXT138=3075;
var IPV6_TEXT139=3076;
var IPV6_TEXT140=3077;
var IPV6_TEXT141=3078;
var IPV6_TEXT142=3079;
var IPV6_TEXT143=3080;
var IPV6_TEXT144=3081;
var IPV6_TEXT145=3082;
var IPV6_TEXT146=3083;
var bd_EDSv=3084;
var htsc_pingt_h=3085;
var IPV6_TEXT149=3086;
var IPV6_TEXT150=3087;
var IPV6_TEXT151=3088;
var IPV6_TEXT152=3089;
var IPV6_TEXT153=3090;
var wps_KR37=3091;
var IPV6_TEXT155=3092;
var IPV6_TEXT156=3093;
var IPV6_TEXT157=3094;
var IPV6_TEXT158=3095;
var IPV6_TEXT159=3096;
var IPV6_TEXT160=3097;
var IPV6_TEXT161=3098;
var IPV6_TEXT162=3099;
var IPV6_TEXT163=3100;
var IPV6_TEXT164=3101;
var IPV6_TEXT165=3102;
var IPV6_TEXT166=3103;
var haar_p=3104;
var bws_ORAD=3105;
var DNS_TEXT2=3106;
var DNS_TEXT3=3107;
var DNS_TEXT4=3108;
var DNS_TEXT8=3109;
var DNS_TEXT6=3110;
var DNS_TEXT5=3111;
var help639=3112;
var DNS_TEXT9=3113;
var DNS_TEXT10=3114;
var DNS_TEXT11=3115;
var DNS_TEXT12=3116;
var TEXT000=3117;
var TEXT001=3118;
var TEXT002=3119;
var TEXT003=3120;
var TEXT004=3121;
var TEXT005=3122;
var TEXT006=3123;
var TEXT007=3124;
var TEXT008=3125;
var TEXT010=3126;
var sw_title_list=3127;
var TEXT011=3128;
var TEXT012=3129;
var TEXT013=3130;
var TEXT014=3131;
var TEXT015=3132;
var TEXT016=3133;
var TEXT017=3134;
var TEXT018=3135;
var TEXT019=3136;
var TEXT020=3137;
var TEXT021=3138;
var TEXT022=3139;
var LS3=3140;
var TEXT024=3141;
var TEXT025=3142;
var TEXT026=3143;
var TEXT027=3144;
var TEXT028=3145;
var TEXT029=3146;
var TEXT030=3147;
var TEXT031=3148;
var TEXT032=3149;
var TEXT033=3150;
var TEXT035=3151;
var TEXT036=3152;
var TEXT037=3153;
var TEXT038=3154;
var TEXT039=3155;
var TEXT040=3156;
var TEXT041=3157;
var TEXT042=3158;
var TEXT043=3159;
var TEXT045=3160;
var TEXT046=3161;
var TEXT047=3162;
var aa_alert_10=3163;
var TEXT049=3164;
var TEXT050=3165;
var TEXT051=3166;
var TEXT053=3167;
var TEXT055=3168;
var TEXT009=3169;
var TEXT054=3170;
var TEXT057=3171;
var TEXT058=3172;
var TEXT059=3173;
var TEXT060=3174;
var TEXT062=3175;
var TEXT063=3176;
var TEXT064=3177;
var TEXT065=3178;
var TEXT066=3179;
var TEXT067=3180;
var TEXT068=3181;
var TEXT069=3182;
var TEXT070=3183;
var TEXT071=3184;
var TEXT072=3185;
var TEXT073=3186;
var TEXT074=3187;
var TEXT075=3188;
var TEXT076=3189;
var TEXT077=3190;
var TEXT078=3191;
var MSG002=3192;
var MSG003=3193;
var MSG004=3194;
var MSG005=3195;
var MSG006=3196;
var MSG007=3197;
var MSG008=3198;
var MSG009=3199;
var MSG010=3200;
var MSG013=3201;
var MSG014=3202;
var MSG015=3203;
var MSG016=3204;
var MSG017=3205;
var MSG018=3206;
var MSG019=3207;
var MSG020=3208;
var MSG021=3209;
var MSG022=3210;
var MSG023=3211;
var MSG024=3212;
var MSG025=3213;
var MSG026=3214;
var MSG027=3215;
var MSG028=3216;
var MSG029=3217;
var MSG030=3218;
var MSG031=3219;
var MSG032=3220;
var MSG033=3221;
var MSG034=3222;
var MSG035=3223;
var MSG036_1=3224;
var MSG037_1=3225;
var MSG038_1=3226;
var MSG039_1=3227;
var MSG036=3228;
var MSG037=3229;
var MSG038=3230;
var MSG039=3231;
var MSG040=3232;
var MSG041=3233;
var MSG042=3234;
var MSG043=3235;
var MSG044=3236;
var MSG045=3237;
var MSG046=3238;
var MSG047=3239;
var MSG048=3240;
var ADV_DNS_DESC1=3241;
var ADV_DNS_DESC2=3242;
var ADV_DNS_DESC3=3243;
var ERROR404=3244;
var SUGGESTIONS=3245;
var SUGGESTIONS_1=3246;
var SUGGESTIONS_2=3247;
var tsc_hrmin_1=3248;
var DHCP_PD=3249;
var IPV6_TEXT147=3250;
var DHCP_PD_ASSIGNED=3251;
var _6to4RELAY=3252;
var IPV6_TEXT64=3253;
var IPV6_TEXT66_v6=3254;
var usb_reboot=3255;
var usb_reboot_chnip=3256;
var country_8=3257;
var _select_phone=3258;
var _phone_info=3259;
var usb_3g_phone=3260;
var usb_window_mobile_5=3261;
var usb_iphone=3262;
var android_phone=3263;
var help901=3264;
var DEVICE_NAME=3265;
var DEVICE_DESC=3266;
var IPDHCPSERVER_LEASE_REVOKED2=3267;
var IPDHCPSERVER_LEASE_RESERVATION_DELETED=3268;
var IPDHCPSERVER_LEASE_RENEW=3269;
var help738=3270;
var help759=3271;
var help517=3272;
var help443=3273;
var help414=3274;
var _ok=3275;
var help486=3276;
var help503=3277;
var help426=3278;
var help432=3279;
var help527=3280;
var awf_intro_WF=3281;
var help652=3282;
var help456=3283;
var help539=3284;
var help472=3285;
var help520=3286;
var help737=3287;
var help646=3288;
var help745=3289;
var help659=3290;
var help727=3291;
var help753=3292;
var help574=3293;
var help663=3294;
var help748=3295;
var hhwf_intro=3296;
var help598=3297;
var help761=3298;
var help510=3299;
var help584=3300;
var help716=3301;
var help440=3302;
var help410=3303;
var help480=3304;
var help559=3305;
var help516=3306;
var help413=3307;
var help619=3308;
var help521=3309;
var help494=3310;
var help498=3311;
var help628=3312;
var help683=3313;
var help535=3314;
var help695=3315;
var help740=3316;
var help578=3317;
var help438=3318;
var help508=3319;
var help423=3320;
var help625=3321;
var help680=3322;
var help568=3323;
var help620=3324;
var help667=3325;
var help766=3326;
var help662=3327;
var help701=3328;
var help542=3329;
var help570=3330;
var help489=3331;
var help723=3332;
var help593=3333;
var help447=3334;
var help705=3335;
var help755=3336;
var _H323=3337;
var help427=3338;
var help485=3339;
var help490=3340;
var help555=3341;
var help462=3342;
var help732=3343;
var help592=3344;
var help455=3345;
var help685=3346;
var help146=3347;
var help655=3348;
var help439=3349;
var help416=3350;
var help726=3351;
var help692=3352;
var help550=3353;
var help714=3354;
var help504=3355;
var help469=3356;
var help629=3357;
var help597=3358;
var help746=3359;
var help749=3360;
var help471=3361;
var help736=3362;
var help596=3363;
var help706=3364;
var help664=3365;
var help702=3366;
var help756=3367;
var help573=3368;
var help601=3369;
var help684=3370;
var help678=3371;
var help760=3372;
var help536=3373;
var help499=3374;
var help562=3375;
var help741=3376;
var help541=3377;
var help717=3378;
var help604=3379;
var help718=3380;
var help551=3381;
var help577=3382;
var help515=3383;
var help621=3384;
var help412=3385;
var help713=3386;
var help687=3387;
var help567=3388;
var help618=3389;
var help441=3390;
var help466=3391;
var gw_vs_5=3392;
var help488=3393;
var help591=3394;
var help402=3395;
var help661=3396;
var help495=3397;
var help587=3398;
var help658=3399;
var help722=3400;
var help483=3401;
var help670=3402;
var help750=3403;
var help452=3404;
var help696=3405;
var help668=3406;
var help433=3407;
var help681=3408;
var help632=3409;
var help409=3410;
var help765=3411;
var help421=3412;
var help725=3413;
var help660=3414;
var help576=3415;
var help751=3416;
var help735=3417;
var help401=3418;
var gw_vs_6=3419;
var help491=3420;
var help448=3421;
var help566=3422;
var help398=3423;
var help586=3424;
var help710=3425;
var help686=3426;
var help537=3427;
var help654=3428;
var help708=3429;
var help424=3430;
var help505=3431;
var help583=3432;
var help430=3433;
var help484=3434;
var help454=3435;
var help556=3436;
var help470=3437;
var help689=3438;
var help464=3439;
var help461=3440;
var tt_Nov=3441;
var help715=3442;
var help622=3443;
var help731=3444;
var help408=3445;
var help688=3446;
var help465=3447;
var help703=3448;
var help697=3449;
var help605=3450;
var help549=3451;
var help506=3452;
var help642=3453;
var help428=3454;
var help682=3455;
var help492=3456;
var help526=3457;
var help631=3458;
var help606=3459;
var help665=3460;
var help148=3461;
var RATE_ESTIMATOR_RESOURCE_ERROR=3462;
var help721=3463;
var gw_vs_2=3464;
var help729=3465;
var help757=3466;
var help595=3467;
var help671=3468;
var help747=3469;
var help707=3470;
var help451=3471;
var help514=3472;
var help512=3473;
var help675=3474;
var help399=3475;
var help626=3476;
var help415=3477;
var help533=3478;
var help572=3479;
var help557=3480;
var help468=3481;
var help724=3482;
var help648=3483;
var wt_title=3484;
var help657=3485;
var help482=3486;
var help679=3487;
var help431=3488;
var help560=3489;
var help742=3490;
var help449=3491;
var help565=3492;
var wprn_tt7=3493;
var help599=3494;
var help585=3495;
var help530=3496;
var help623=3497;
var help758=3498;
var help634=3499;
var help752=3500;
var help575=3501;
var help450=3502;
var ES_CABLELOST_bnr=3503;
var help463=3504;
var help407=3505;
var help453=3506;
var help561=3507;
var help442=3508;
var help762=3509;
var help553=3510;
var help590=3511;
var help608=3512;
var help411=3513;
var gw_vs_4=3514;
var help546=3515;
var help653=3516;
var help481=3517;
var help529=3518;
var help425=3519;
var help400=3520;
var help509=3521;
var _DHCP=3522;
var help709=3523;
var help720=3524;
var help728=3525;
var help467=3526;
var help719=3527;
var help594=3528;
var help457=3529;
var help666=3530;
var help698=3531;
var help538=3532;
var help630=3533;
var help422=3534;
var help493=3535;
var help507=3536;
var help571=3537;
var RATE_ESTIMATOR_CONVERGENCE_ERROR=3538;
var help487=3539;
var help624=3540;
var help543=3541;
var help700=3542;
var help460=3543;
var help730=3544;
var help502=3545;
var help513=3546;
var help690=3547;
var help607=3548;
var help525=3549;
var help754=3550;
var help617=3551;
var help500=3552;
var help558=3553;
var help429=3554;
var help511=3555;
var help534=3556;
var help496=3557;
var help446=3558;
var help739=3559;
var help627=3560;
var _actsess=3561;
var help91a=3562;
var help91b=3563;
var help92x1=3564;
var help92x2=3565;
var TA21=3566;
var TA22=3567;
var help183=3568;
var help400_b=3569;
var help401_b=3570;
var help402_b=3571;
var help403=3572;
var help403_b=3573;
var help404=3574;
var help404_b=3575;
var help405=3576;
var help405_b=3577;
var WIFISC_AP_PEER_CFG_ERR=3578;
var help417=3579;
var help418=3580;
var help419=3581;
var help420=3582;
var help434=3583;
var help435=3584;
var help436=3585;
var help437=3586;
var help444=3587;
var help445=3588;
var help458=3589;
var help459=3590;
var help474=3591;
var help475=3592;
var help476=3593;
var help477=3594;
var help478=3595;
var help479=3596;
var help518=3597;
var help519=3598;
var help522=3599;
var help523=3600;
var help528=3601;
var help531=3602;
var help532=3603;
var help544=3604;
var help545=3605;
var help548=3606;
var help563=3607;
var help564=3608;
var help579=3609;
var help580=3610;
var help581=3611;
var help582=3612;
var help588=3613;
var help589=3614;
var help602=3615;
var help603=3616;
var help609=3617;
var help610=3618;
var help611=3619;
var help612=3620;
var help613=3621;
var help614=3622;
var help615=3623;
var help616=3624;
var tt_Oct=3625;
var sa_Originator=3626;
var help637=3627;
var help641=3628;
var help638=3629;
var msg_non_sec=3630;
var LW24=3631;
var help644=3632;
var help649=3633;
var help650=3634;
var help672=3635;
var help673=3636;
var help676=3637;
var help677=3638;
var help693=3639;
var help694=3640;
var help711=3641;
var help712=3642;
var help733=3643;
var help734=3644;
var help743=3645;
var help744=3646;
var help763=3647;
var help764=3648;
var help795a=3649;
var sa_Internal=3650;
var sa_External=3651;
var DNS_TEXT7=3652;
var help831_1=3653;
var DNS_TEXT1=3654;
var help191=3655;
var help198=3656;
var _unknown_wait=3657;
var _unknown=3658;
var _na=3659;
var _sdi_nciy=3660;
var _sdi_dhcpclient=3661;
var _sdi_bpc=3662;
var help600=3663;
var _bln_nmgmy=3664;
var _sdi_s1=3665;
var _sdi_s10=3666;
var _sdi_s8=3667;
var _sdi_s9=3668;
var _sdi_days=3669;
var _sdi_disconnectpending=3670;
var _sdi_secs=3671;
var sd_Renew=3672;
var sd_Release=3673;
var sd_Disconnect=3674;
var sd_bp_login=3675;
var sd_bp_logout=3676;
var _channel=3677;
var sl_SLogs=3678;
var sps_intro2=3679;
var sps_pare=3680;
var sr_RTable=3681;
var sr_intro=3682;
var ss_title_stats=3683;
var sw_title=3684;
var ta_alert_1=3685;
var ES_CABLELOST_dsc1=3686;
var _pwsame=3687;
var ta_alert_3=3688;
var _invalidddnsserver=3689;
var _blankddnsserver=3690;
var IPV6_TEXT1=3691;
var td_alert_2=3692;
var td_alert_3=3693;
var td_DDNSDDNS=3694;
var tt_SelDynDns=3695;
var _emailaccnameisblank=3696;
var _blankfromemailaddr=3697;
var _blanktomemailaddr=3698;
var _blanksmtpmailaddr=3699;
var _badfromemailaddr=3700;
var _badtoemailaddr=3701;
var _invalidsmtpserveraddr=3702;
var _badsmtpserveraddr=3703;
var tf_NFWA=3704;
var tf_alert_1=3705;
var tf_LFWVis=3706;
var tf_FWCinP=3707;
var tf_Ching_FW=3708;
var tf_EM_not=3709;
var tf_LFWV=3710;
var tf_FWChNow=3711;
var TA17=3712;
var tps_sfp=3713;
var tps_dci=3714;
var tps_intro2=3715;
var tsc_alert_1=3716;
var tsc_alert_2=3717;
var tsc_alert_3=3718;
var tsc_alert_6=3719;
var tsc_alert_9=3720;
var tsc_SelDays=3721;
var tsc_TimeFr=3722;
var tsl_alert_3=3723;
var tsl_alert_1=3724;
var tsl_alert_2=3725;
var ZM18=3726;
var tsc_pingt_msg9=3727;
var help635=3728;
var tt_alert_tupdt=3729;
var TA24=3730;
var TA25=3731;
var fb_FbAc=3732;
var sentinel_1=3733;
var sentinel_2=3734;
var sentinal_3=3735;
var fl_Failure=3736;
var fl_text=3737;
var li_newfw=3738;
var rd_p_1=3739;
var rd_p_2=3740;
var rs_Restoring_Settings=3741;
var reh=3742;
var rs_RSPW=3743;
var rs_cld=3744;
var rs_Done=3745;
var rs_uld=3746;
var rs_usd=3747;
var rs_csd=3748;
var rs_Repacked=3749;
var rs_Converted=3750;
var rs_Saving=3751;
var sc_intro_rb=3752;
var _relogin=3753;
var _badWANsub=3754;
var wwa_pv5_alert_4=3755;
var wwa_pv5_alert_5=3756;
var wwa_pv5_alert_8=3757;
var wwa_pv5_alert_6=3758;
var wwa_pv5_alert_7=3759;
var wwa_pv5_alert_21=3760;
var _badPPTPgwip=3761;
var wwa_pv5_alert_15=3762;
var _badL2TPgwip=3763;
var wwa_pv5_alert_20=3764;
var wwl_intro_s3_1=3765;
var wwl_intro_s3_2r=3766;
var wwl_WSP_1=3767;
var wwl_wpa=3768;
var wwl_wpa2=3769;
var gw_vs_0=3770;
var gw_vs_8=3771;
var gw_sa_0=3772;
var gw_sa_2=3773;
var gw_sa_3=3774;
var gw_sa_4=3775;
var YM47=3776;
var gw_SelBPS=3777;
var gw_bp_0=3778;
var gw_bp_1=3779;
var gw_bp_2=3780;
var gw_gm_81=3781;
var gw_wcn_alert_4=3782;
var gw_wcn_alert5=3783;
var gw_wcn_alert6=3784;
var gw_wcn_alert7=3785;
var gw_wcn_err_ok=3786;
var gw_wcn_err_code=3787;
var gw_wcn_err_os_version=3788;
var gw_wcn_err_load_config=3789;
var gw_wcn_err_provision=3790;
var gw_wcn_err_io_write_config=3791;
var gw_wcn_err_encryption=3792;
var gw_wcn_err_exception=3793;
var gw_wcn_err_com=3794;
var gw_wcn_err_bad_wsetting_entry=3795;
var gw_wcn_err_bad_wps_profile=3796;
var gw_wcn_err_unsupported_wsetting=3797;
var gw_wcn_err_dom_processing=3798;
var gw_wcn_err_default=3799;
var adv_Everyone=3800;
var adv_Noone=3801;
var psQueued=3802;
var psStarting=3803;
var psClosed=3804;
var psIdle=3805;
var psReady=3806;
var GW_PPPOE_EVENT_OFFER=3807;
var psUnplugged=3808;
var psPrinting=3809;
var IPPPPPAP_AUTH_RESULT=3810;
var up_gS_1=3811;
var up_gIUH_1=3812;
var up_gIUH_2=3813;
var up_gIUH_3=3814;
var up_gH_1=3815;
var up_ae_se_1=3816;
var up_ai_se_2=3817;
var up_ae_se_3=3818;
var up_ae_wic_1=3819;
var up_ae_wic_2=3820;
var _Advanced_02=3821;
var up_fm_dc_1=3822;
var up_fm_re_1=3823;
var up_fm_re_2=3824;
var up_fm_dr_1=3825;
var up_fm_dr_2=3826;
var up_fm_dr_3=3827;
var up_if_1=3828;
var up_rb_3=3829;
var up_rb_6=3830;
var up_vp_1=3831;
var up_vp_2=3832;
var up_vp_3=3833;
var up_vp_0=3834;
var up_vm_1=3835;
var up_vm_2=3836;
var up_he_1=3837;
var up_he_2=3838;
var up_he_5=3839;
var gw_sa_5=3840;
var IPSTACK_REJECTED_SPOOFED_PACKET=3841;
var IPDHCPSERVER_HOST_IS_ACTIVE=3842;
var BSECURE_LOG_AUTH_FAIL_UNREG=3843;
var RATE_ESTIMATOR_RATE_IS=3844;
var GW_IPFILTER_DENY=3845;
var GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION=3846;
var IPNAT_ILLEGAL_DEST=3847;
var BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT=3848;
var IPDHCPSERVER_LEASE_REVOKED1=3849;
var LOG_PREV_MSG_REPEATED_1_TIME=3850;
var GW_UPNP_PORTMAP_VS_CHANGE=3851;
var IPDHCPSERVER_LEASE_EXPIRED=3852;
var BSECURE_LOG_AUTH_FAIL_INTNL=3853;
var GW_UPNP_PORTMAP_DEL=3854;
var GW_SMTP_EMAIL_INVALID_TO_ADDRESS=3855;
var BSECURE_LOG_FLTR_DISCONNECTED_CLOSED=3856;
var IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC=3857;
var BSECURE_LOG_AUTH_PASS=3858;
var BSECURE_LOG_AUTH_FAIL_UNKNW=3859;
var wwan_auth_pap=3860;
var BSECURE_LOG_AUTH_FAIL_RENEW=3861;
var IPDHCPSERVER_LEASE_DENIED=3862;
var GW_SMTP_EMAIL_TIMEOUT=3863;
var BSECURE_LOG_AUTH_FAIL_DB=3864;
var IPDHCPSERVER_PARAM_DB_UPDATED=3865;
var APP_RULES=3866;
var IPDHCPSERVER_LEASE_POOL_FULL=3867;
var IPPPPPAP_AUTH_SUCCESS=3868;
var ADVANCED_NETWORKS=3869;
var IPDHCPSERVER_LEASE_ASSIGNED=3870;
var BSECURE_LOG_FLTR_CONNECTED=3871;
var BSECURE_LOG_AUTH_CONNECTED=3872;
var BSECURE_LOG_AUTH_FAIL_PKT=3873;
var IPSMTPCLIENT_CONN_FAILED=3874;
var IPPPPPAP_AUTH_FAIL=3875;
var GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED=3876;
var GW_SMTP_EMAIL_SEND_FAILURE=3877;
var IPDHCPSERVER_LEASE_RELEASED=3878;
var IPDHCPSERVER_PARAM_DB_ADDED=3879;
var IPPPPPAP_AUTH_TIMEOUT=3880;
var GW_UPNP_PORTMAP_ADD=3881;
var GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS=3882;
var GW_UPNP_PORTMAP_REFRESH=3883;
var GW_UPNP_PORTMAP_EXPIRE=3884;
var IPDHCPSERVER_PARAM_DB_REMOVED=3885;
var IPDHCPSERVER_LEASE_DELETED=3886;
var GW_UPNP_PORTMAP_CONFLICT=3887;
var TA1=3888;
var aa_alert_11=3889;
var aa_alert_1=3890;
var aa_sched_conf_3=3891;
var aa_alert_16=3892;
var aa_alert_2=3893;
var aa_alert_3=3894;
var aa_alert_4=3895;
var aa_alert_5=3896;
var aa_alert_6=3897;
var _aa_other_machines=3898;
var _copyright=3899;
var aw_alert_1=3900;
var aw_alert_2=3901;
var aw_alert_3=3902;
var aw_alert_4=3903;
var af_alert_1=3904;
var af_alert_2=3905;
var TA19=3906;
var ag_alert_4=3907;
var ag_alert_5=3908;
var ag_conflict10=3909;
var ag_conflict20=3910;
var ag_conflict21=3911;
var ag_alert_1=3912;
var ag_alert_3=3913;
var ag_alert2=3914;
var _tcpports=3915;
var _udpports=3916;
var ag_conflict4=3917;
var tsc_alert_7=3918;
var ai_alert_3=3919;
var GW_FIREWALL_NO_IP_RANGE_INVALID=3920;
var ai_alert_7=3921;
var ai_alert_4=3922;
var ai_alert_6=3923;
var tsc_alert_5=3924;
var ai_title_2=3925;
var _edit=3926;
var _srcip=3927;
var ai_c2=3928;
var ai_c3=3929;
var amaf_alert_1=3930;
var am_cMT_deny=3931;
var am_cMT_Allow=3932;
var _sr_nriy=3933;
var ar_alert_1=3934;
var ar_alert_2=3935;
var ar_alert_3=3936;
var ar_alert_4=3937;
var ar_alert_5=3938;
var ar_RoutI=3939;
var ar_Route=3940;
var ar_RoutesList=3941;
var _delete=3942;
var ar_ERTable=3943;
var ag_alert_duplicate_name=3944;
var ag_alert_duplicate=3945;
var ag_inuse=3946;
var _specapps_alert_2=3947;
var _specapps_tpr=3948;
var _specapps_ipr=3949;
var as_title_SAR=3950;
var as_TPRange=3951;
var as_ex=3952;
var as_TPR=3953;
var as_IPR=3954;
var as_IPrt=3955;
var at_alert_1_1=3956;
var at_alert_15=3957;
var at_alert_16=3958;
var at_alert_17=3959;
var at_alert_2=3960;
var at_alert_18=3961;
var at_alert_3=3962;
var at_alert_19=3963;
var at_alert_4=3964;
var at_alert_5=3965;
var at_alert_20=3966;
var at_alert_6=3967;
var at_alert_21=3968;
var at_alert_8=3969;
var at_alert_7=3970;
var at_alert_10=3971;
var at_alert_9=3972;
var at_alert_11=3973;
var at_alert_22=3974;
var at_alert_23=3975;
var at_alert_24=3976;
var at_alert_14=3977;
var at_Prot_0=3978;
var _srcport=3979;
var at_DIPR=3980;
var at_DPR=3981;
var av_alert_11=3982;
var av_alert_21=3983;
var av_alert_24=3984;
var av_alert_1=3985;
var av_alert_2=3986;
var av_alert_3=3987;
var av_alert_4=3988;
var av_alert_12=3989;
var av_alert_18=3990;
var av_alert_23=3991;
var av_alert_19=3992;
var av_alert_20=3993;
var av_alert_13=3994;
var av_alert_17=3995;
var av_alert_5=3996;
var av_alert_6=3997;
var av_alert_7=3998;
var av_alert_8=3999;
var av_alert_9=4000;
var av_alert_10=4001;
var _public=4002;
var at_Prot__1=4003;
var _private=4004;
var aa_WebSite=4005;
var awf_alert_4=4006;
var awf_alert_5=4007;
var awf_alert_7=4008;
var awf_alert_8=4009;
var int_ConWz2=4010;
var int_intro_ConWz=4011;
var int_WlsWz=4012;
var int_intro_WlsWz=4013;
var hhbi_wiz=4014;
var hhbi_man=4015;
var bd_noneyet=4016;
var bd_revoked=4017;
var bln_alert_3=4018;
var bd_alert_10=4019;
var bd_alert_11=4020;
var bd_alert_1=4021;
var bd_alert_3=4022;
var bd_alert_13=4023;
var bd_alert_12=4024;
var bd_alert_5=4025;
var bd_alert_6=4026;
var bd_alert_7=4027;
var TA20=4028;
var bd_alert_8=4029;
var bd_alert_22=4030;
var bd_alert_23=4031;
var bd_alert_24=4032;
var _badWANIP=4033;
var bwn_alert_2=4034;
var bwn_alert_3=4035;
var bwn_alert_4=4036;
var bwn_alert_5=4037;
var MSG000=4038;
var bwn_alert_8=4039;
var bwn_alert_12=4040;
var _badPPTPip=4041;
var _badPPTPsub=4042;
var _badPPTPipsub=4043;
var bwn_alert_11=4044;
var _badL2TP3=4045;
var _badL2TP=4046;
var _badL2TP2=4047;
var bwn_alert_17=4048;
var bwn_alert_21=4049;
var bws_alert_15=4050;
var bws_alert_16=4051;
var bwl_alert_2=4052;
var bwl_alert_3=4053;
var bwl_alert_15=4054;
var bwl_alert_16=4055;
var bwl_alert_4=4056;
var bwl_alert_5=4057;
var bwl_alert_6=4058;
var bwl_alert_7=4059;
var bwl_alert_8=4060;
var bwl_alert_9=4061;
var bwl_alert_10=4062;
var bws_alert_2=4063;
var bwl_alert_11=4064;
var bwl_alert_12=4065;
var bws_alert_3=4066;
var aw_alert_5_1=4067;
var bwl_alert_13=4068;
var bwl_alert_14=4069;
var bwl_Mode_2=4070;
var bwl_Mode_3=4071;
var bwl_Mode_1=4072;
var bwl_Mode_8=4073;
var bwl_Mode_11=4074;
var bwl_ht20=4075;
var bwl_ht2040=4076;
var bwl_TxR_0=4077;
var TA9=4078;
var YM124=4079;
var TA12=4080;
var TA14=4081;
var TA15=4082;
var _wizard=4083;
var bwz_intro=4084;
var bwz_intro_ConWz=4085;
var bwz_LConWz=4086;
var bwz_WlsWz=4087;
var bwz_intro_WlsWz=4088;
var bwz_LWlsWz=4089;
var _specapps=4090;
var _gaming=4091;
var _basic=4092;
var ag_alert_empty_name=4093;
var ag_alert_duplicate_name2=4094;
var amaf_alert_2=4095;
var specapps_alert_duplicate_name=4096;
var specapps_alert_duplicate1=4097;
var specapps_alert_conflict1=4098;
var specapps_alert_empty_schedule=4099;
var at_title_TSSet=4100;
var av_alert_35=4101;
var av_alert_empty_name=4102;
var av_alert_16=4103;
var bln_alert_lannbpri=4104;
var bln_alert_lannbsec=4105;
var lan_dns=4106;
var lan_dns2=4107;
var bln_NetBIOSReg_H=4108;
var bln_NetBIOSReg_M=4109;
var bln_NetBIOSReg_P=4110;
var bln_NetBIOSReg_B=4111;
var _help=4112;
var help81ets=4113;
var af_EFT_h4=4114;
var YM134=4115;
var af_EFT_h1=4116;
var af_EFT_h2=4117;
var af_EFT_h5=4118;
var af_UEFT_h1=4119;
var af_TEFT_h2=4120;
var help309A=4121;
var help400_1=4122;
var help401_1=4123;
var help402_1=4124;
var help402_2=4125;
var help405_1=4126;
var help405_2=4127;
var help405_3=4128;
var help405_4=4129;
var _sdi_s1a=4130;
var ta_alert_3b=4131;
var ta_alert_3c=4132;
var ta_alert_3d=4133;
var ta_alert_3e=4134;
var ta_alert_3f=4135;
var ta_alert_3g=4136;
var tps_enlpd=4137;
var ta_LMAP=4138;
var fb_FailLogin=4139;
var fb_FailLogin_1=4140;
var _open=4141;
var _other=4142;
var _223=4143;
var _225ap=4144;
var _226ap=4145;
var _1044wired=4146;
var _1044awired=4147;
var TEXT0=4148;
var regenerate=4149;
var _title_AdvDns=4150;
var _desc_AdvDns=4151;
var ta_EUPNP_dns=4152;
var _st_AdvDns=4153;
var _sp_title_AdvDNS=4154;
var _sp_desc1_AdvDNS=4155;
var _sp_desc2_AdvDNS=4156;
var _sp_desc3_AdvDNS=4157;
var _sp_desc4_AdvDNS=4158;
var TEXT041_1=4159;
var TEXT041_2=4160;
var TEXT041_3=4161;
var TEXT041_4=4162;
var TEXT042_1=4163;
var TEXT042_2=4164;
var GW_URL_INVALID=4165;
var GW_LAN_NETBIOS_SCOPE_INVALID=4166;
var GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID_a=4167;
var bwn_Mode_DHCPPLUS=4168;
var net_sniper_support=4169;
var TEXT_xkjs_descript=4170;
var SEL_DIAL_MODE=4171;
var pppoe_dialmode_normal=4172;
var pppoe_dialmode_sp1=4173;
var pppoe_dialmode_sp2=4174;
var pppoe_dialmode_sp3=4175;
var pppoe_dialmode_sp4=4176;
var pppoe_dialmode_sp5=4177;
var pppoe_dialmode_sp6=4178;
var pppoe_dialmode_learn=4179;
var bt_learn_text=4180;
var box_ip_mac_binding=4181;
var _en_AdvDns=4182;
var xkjs_support=4183;
var ddns_serv_type=4184;
var ddns_domain=4185;
var ddns_account=4186;
var virtual_pub_port_err=4187;
var virtual_pri_port_err=4188;
var virtual_proto_num_err=4189;
var menu_wps=4190;
var tc_iprange=4191;
var help823_15=4192;
var tc_bw=4193;
var tc_schedule=4194;
var tc_new_sch=4195;
var tc_min_bw=4196;
var tc_max_bw=4197;
var _login_admin=4198;
var _login_user=4199;
var pppoe_plus_dail=4200;
var wwa_msg_dhcpplus=4201;
var GW_WAN_DHCPPLUS_USERNAME_INVALID=4202;
var GW_WAN_DHCPPLUS_PASSWORD_INVALID=4203;
var te_SMTPPort=4204;
var WLANMODE=4205;
var ROUTER_MODE=4206;
var AP_MODE=4207;
var WDSROUTER_MODE=4208;
var WDSAP_MODE=4209;
var BR_SET=4210;
var device_mode=4211;
var router_mode=4212;
var ap_mode=4213;
var auto_mode=4214;
var enable_WDS=4215;
var ES_WELCOME=4216;
var ES_AUTODECT=4217;
var _phone=4218;
var mydlink_tx10=4219;
var ES_CABLELOST_dsc2=4220;
var ES_DONT_CONN_btn=4221;
var ES_UPDATE_SETTING_bnr=4222;
var ES_UPDATE_SETTING_dsc=4223;
var ES_CONFIG_INTERNET_bnr=4224;
var ES_CONFIG_INTERNET_dsc1=4225;
var ES_CONFIG_INTERNET_dsc2=4226;
var ES_INTERNET_CONN_dsc=4227;
var ES_MUST_FIELD_dsc=4228;
var ES_DIALUP_ERROR_bnr=4229;
var usb_config1=4230;
var ES_NAME=4231;
var MSG011=4232;
var ES_what_is_this=4233;
var ES_PRI_DNS=4234;
var ES_SEC_DNS=4235;
var ES_GW_ADDR=4236;
var ES_MASK=4237;
var ES_IP_ADDR=4238;
var ES_complete=4239;
var ES_save_dsc=4240;
var ES_status=4241;
var ES_connected=4242;
var ES_unconnected=4243;
var ES_wlan_setting=4244;
var ES_wlan_ssid=4245;
var ES_security=4246;
var ES_unsecured=4247;
var ES_unsecured_suggest=4248;
var ES_save_mySetting=4249;
var ES_sync_pw=4250;
var ES_save=4251;
var ES_network_key=4252;
var ES_autogen_key=4253;
var ES_disable_wifi_sec=4254;
var ES_wifi_sec_recomm=4255;
var ES_current_setting_dsc=4256;
var ES_current_setting=4257;
var ES_manual_btn=4258;
var ES_cancel=4259;
var logout_caption=4260;
var logout_desc=4261;
var logout_return=4262;
var st_connected_time=4263;
var t_ctl_title=4264;
var t_ctl_note=4265;
var t_ctl_note1=4266;
var page_title=4267;
var ac_alert_invalid_port=4268;
var ac_alert_dup_name=4269;
var ac_alert_port_conflit=4270;
var ac_alert_policy_null=4271;
var tt_alert_checkdyndns=4272;
var ES_static_no_internet=4273;
var ES_static_no_internet_desc=4274;
var _CFM_close_window=4275;
var ES_save_result=4276;
var ES_save_success=4277;
var ES_confirm_bt=4278;
var sch_timeformat=4279;
var sch_hourfmt_12=4280;
var sch_hourfmt_24=4281;
var no_available_update=4282;
var clear_lang_pack=4283;
var current_lang_pack_version=4284;
var current_lang_pack_date=4285;
var lang_package_info=4286;
var lang_package_note1=4287;
var lang_package_note2=4288;
var latest_lang_package_ver=4289;
var latest_lang_package_date=4290;
var no_lang_pack=4291;
var pf_name_empty=4292;
var vs_name_empty=4293;
var fw_checksum_err=4294;
var fw_bad_hwid=4295;
var fw_unknow_file_format=4296;
var fw_fw_upgrade_success=4297;
var fw_lp_upgrade_success=4298;
var fw_cfg_upgrade_success=4299;
var ES_timectrl_bnr=4300;
var ES_timectrl_btn=4301;
var ES_webpolicy_btn=4302;
var HW_NAT_desc=4303;
var at_ETS=4304;
var alert_hw_nat_1=4305;
var alert_hw_nat_2=4306;
var alert_hw_nat_3=4307;
var help_auto_disable_hw_nat=4308;
var help_auto_disable_hw_nat_1=4309;
var help_hw_nat=4310;
var help_hw_nat_desc=4311;
var ES_step_wifi_security=4312;
var _pwsame_user=4313;
var ES_btn_try_again=4314;
var ES_auto_detect_desc=4315;
var ES_auto_detect_failed_desc=4316;
var ES_btn_guide_me=4317;
var ES_note_support_wpa=4318;
var ES_btn_save_conn=4319;
var ES_btn_save=4320;
var ES_bookmark=4321;
var v6_routing=4322;
var v6_routing_table=4323;
var v6_routing_info=4324;
var ipv6=4325;
var ipv6_firewall=4326;
var ipv6_firewall_info=4327;
var _6rd_settings=4328;
var ipv4_addr=4329;
var mask_len=4330;
var IPV6_ULA_TEXT01=4331;
var HW_NAT_enable=4332;
var IPV6_ULA_TEXT03=4333;
var IPV6_ULA_TEXT04=4334;
var IPV6_ULA_TEXT05=4335;
var IPV6_ULA_TEXT06=4336;
var IPV6_ULA_TEXT07=4337;
var IPV6_ULA_TEXT08=4338;
var IPV6_ULA_TEXT09=4339;
var IPV6_ULA_TEXT10=4340;
var IPV6_ULA_TEXT11=4341;
var IPV6_ULA_TEXT12=4342;
var IPV6_ULA_TEXT13=4343;
var IPV6_ULA_TEXT14=4344;
var LW27_v6=4345;
var LW29_v6=4346;
var IPv6_Local_Info=4347;
var IPv6_Simple_Security=4348;
var anet_multicast_enable_v6=4349;
var IPv6_Wizard_6rd_title=4350;
var fr_name_empty=4351;
var r6_name_empty=4352;
var wwz_wwl_intro_s2_1=4353;
var wwz_wwl_intro_s2_1_1=4354;
var wwz_wwl_intro_s2_1_2=4355;
var wwz_wwl_intro_s2_2=4356;
var wwz_wwl_intro_s2_2_1=4357;
var wwz_wwl_intro_s2_2_2=4358;
var ES_title_s3=4359;
var ES_title_s4=4360;
var ES_title_s5=4361;
var bwl_Mode_n=4362;
var bwl_Mode_a=4363;
var bwl_Mode_5=4364;
var MSG049=4365;
var MSG050=4366;
var HWerr=4367;
var storage=4368;
var sto_into=4369;
var sto_http_0=4370;
var bwn_RPing=4371;
var guestzone_enable=4372;
var sto_http_3=4373;
var LV2=4374;
var sto_http_5=4375;
var sto_creat=4376;
var _add_edit=4377;
var sto_list=4378;
var _modify=4379;
var sto_path=4380;
var help361=4381;
var tt_NTPSrvU=4382;
var sto_dev=4383;
var _total_space=4384;
var _free_space=4385;
var sto_link_0=4386;
var sto_link_1=4387;
var sto_link_2=4388;
var _email_now=4389;
var sto_help=4390;
var _DevLink=4391;
var _folder=4392;
var _browse=4393;
var _append=4394;
var sto_01=4395;
var sto_02=4396;
var _readonly=4397;
var _readwrite=4398;
var _AppendNewFolder=4399;
var KR45=4400;
var MSG052=4401;
var MSG053=4402;
var MSG054=4403;
var _AddFolder=4404;
var _StorageLink=4405;
var LW6_1=4406;
var MSG055=4407;
var ES_title_s6=4408;
var ES_title_s5_0=4409;
var save_settings=4410;
var save_wait=4411;
var mydlink_tx01=4412;
var mydlink_tx02=4413;
var _Language=4414;
var manul_conn_01=4415;
var manul_conn_02=4416;
var manul_conn_03=4417;
var manul_conn_04=4418;
var manul_conn_05=4419;
var manul_conn_06=4420;
var manul_conn_07=4421;
var manul_conn_08=4422;
var manul_conn_09=4423;
var manul_conn_10=4424;
var manul_conn_11=4425;
var manul_conn_12=4426;
var _aa_bsecure_opinion=4427;
var manul_conn_14=4428;
var manul_conn_15=4429;
var manul_conn_16=4430;
var manul_conn_17=4431;
var manul_conn_18=4432;
var manul_conn_19=4433;
var manul_conn_20=4434;
var manul_conn_21=4435;
var manul_conn_22=4436;
var manul_conn_23=4437;
var manul_conn_24=4438;
var manul_conn_25=4439;
var manul_5g_ssid=4440;
var tf_intro_FWU3=4441;
var tf_intro_FWU4=4442;
var tf_intro_FWU5=4443;
var _firmwareUpdate=4444;
var _date=4445;
var _remove=4446;
var notify_wps=4447;
var ag_conflict5=4448;
var _disable=4449;
var coexi=4450;
var wwl_SSP=4451;
var wwz_wwl_intro_s0=4452;
var STATUS_IPV6_DESC_0=4453;
var STATUS_IPV6_DESC_1=4454;
var STATUS_IPV6_DESC_6=4455;
var STATUS_IPV6_DESC_5=4456;
var STATUS_IPV6_DESC_4=4457;
var STATUS_IPV6_DESC_3=4458;
var STATUS_IPV6_DESC_2=4459;
var ag_conflict6=4460;
var TEXT008a=4461;
var TEXT008b=4462;
var mydlink_S01=4463;
var mydlink_S02=4464;
var mydlink_S03=4465;
var mydlink_S04=4466;
var mydlink_T01=4467;
var mydlink_T02=4468;
var mydlink_T03=4469;
var mydlink_T05=4470;
var TEXT023=4471;
var mydlink_T04=4472;
var at_mbps=4473;
var pin_f=4474;
var msg_eap=4475;
var open=4476;
var PRIVATE_PORT_ERROR=4477;
var MSG056=4478;
var MSG057=4479;
var _DestIP=4480;
var _type=4481;
var mydlink_tx03=4482;
var mydlink_tx04=4483;
var mydlink_tx05=4484;
var sec_left=4485;
var mydlink_tx06=4486;
var mydlink_tx07=4487;
var mydlink_tx08=4488;
var mydlink_tx09=4489;
var ES_CONN_dsc=4490;
var chk_pass=4491;
var Lname=4492;
var Fname=4493;
var mydlink_tx12=4494;
var mydlink_tx13_1=4495;
var mydlink_tx13_2=4496;
var _login=4497;
var ag_conflict22=4498;
var ag_conflict23=4499;
var wifi_enable_chk=4500;
var mydlink_reg_into_1=4501;
var mydlink_reg_into_2=4502;
var mydlink_reg_into_3=4503;
var mydlink_reg_into_4=4504;
var mydlink_pop_01=4505;
var mydlink_pop_02=4506;
var mydlink_pop_03=4507;
var mydlink_pop_04=4508;
var mydlink_pop_05=4509;
var mydlink_pop_06=4510;
var ZERO_IPV6_ADDRESS=4511;
var port_empty=4512;
var mydlink_srv=4513;
var mydlink_reg=4514;
var mydlink_nonreg=4515;
var _disable_s=4516;
var IPV6_TEXT154=4517;
var mydlink_pop_07=4518;
var _signup=4519;
var up_tz_74=4520;
var wifi_pass_chk=4521;
var _remove_multi=4522;
var tf_really_langf=4523;
var tf_langf=4524;
var ub_intro_l1=4525;
var ub_intro_l3=4526;
var err404_title=4527;
var err404_detect=4528;
var err404_sug=4529;
var err404_sug1=4530;
var err404_sug2=4531;
var err404_sug3=4532;
var err404_sug4=4533;
var err404_sug5=4534;
var tsc_end_time=4535;
var remote_port_msg=4536;
var TEXT034=4537;
var LW39b=4538;
var _nousername=4539;
var metric_empty=4540;
var TEXT061=4541;
var ES_DIALUP_ERROR_dsc=4542;
var MSG001=4543;
var MSG051=4544;
var MSG012=4545;
var aa_alert_13=4546;
var TEXT044=4547;
var sto_03=4548;
var up_nosave=4549;
var ta_msg_TW=4550;
var mydlink_pop_08=4551;
var sto_04=4552;
var IPV6_TEXT167=4553;
var IPV6_TEXT170=4554;
var help_171=4555;
var DDNS_HOST_ERROR=4556;
var _item_no=4557;
var _usb_not_found=4558;
var srv_name_empty=4559;
var msg_wps_sec_01=4560;
var msg_wps_sec_02=4561;
var msg_wps_sec_03=4562;
var sh_port_tx_00a=4563;
var sh_port_tx_00b=4564;
var sh_port_tx_00=4565;
var sh_port_tx_01=4566;
var sh_port_tx_02=4567;
var sh_port_tx_03=4568;
var sh_port_tx_04=4569;
var sh_port_tx_05=4570;
var sh_port_tx_06=4571;
var sh_port_tx_07=4572;
var sh_port_tx_08=4573;
var sh_port_tx_09=4574;
var sh_port_tx_10=4575;
var sh_port_ddns_01=4576;
var sh_port_ddns_02=4577;
var sh_port_ddns_03=4578;
var sh_port_tx_11=4579;
var sh_port_tx_12=4580;
var sh_port_tx_13=4581;
var sh_port_tx_14=4582;
var sh_port_tx_15=4583;
var sh_port_tx_16=4584;
var sh_port_tx_17=4585;
var sh_port_tx_18=4586;
var sh_port_tx_19=4587;
var sh_port_tx_20=4588;
var sh_port_tx_21=4589;
var sh_port_msg_01=4590;
var sh_port_msg_02=4591;
var sh_port_msg_04=4592;
var sh_port_msg_05=4593;
var sh_port_msg_06=4594;
var sh_port_msg_07=4595;
var sh_port_msg_08=4596;
var sh_port_msg_09=4597;
var sto_http_6=4598;
var file_acc_del_user=4599;
var file_acc_del_path=4600;
var file_acc_del_file=4601;
var mydlink_acc=4602;
var _login_a=4603;
var IPv6_ddns_01=4604;
var IPv6_ddns_02=4605;
var IPv6_fw_01=4606;
var IPv6_fw_02=4607;
var IPv6_fw_03=4608;
var IPv6_fw_04=4609;
var IPv6_fw_ipr=4610;
var IPv6_fw_pr=4611;
var IPv6_fw_sr=4612;
var IPv6_fw_dest=4613;
var IPv6_6rd_relay=4614;
var IPv6_6rd_wan=4615;
var IPv6_6to4_relay=4616;
var IPv6_addrSr=4617;
var IPv6_addrEr=4618;
var msg_wps_sec_04=4619;
var mydlink_sec=4620;
var mydlink_sendM=4621;
var msg_wait_sec=4622;
var file_acc_del_empty=4623;
var mydlink_reg_chk=4624;
var IPV6_TEXT161a=4625;
var ss_Wstats_2=4626;
var ss_Wstats_5g=4627;
var mydlink_help_01=4628;
var mydlink_help_02=4629;
var mydlink_help_03=4630;
var dlna_t=4631;
var dlna_01=4632;
var dlna_02=4633;
var dlna_03=4634;
var rus_wan_pptp=4635;
var rus_wan_pptp_01=4636;
var rus_wan_l2tp=4637;
var rus_wan_l2tp_01=4638;
var rus_wan_pppoe=4639;
var rus_wan_pppoe_02=4640;
var rus_wan_pppoe_03=4641;
var msg_wps_sec_05=4642;
var webf_login=4643;
var webf_intro=4644;
var webf_title=4645;
var webf_folder=4646;
var webf_hd=4647;
var webf_createfd=4648;
var webf_fd_name=4649;
var webf_upload=4650;
var webf_file_sel=4651;
var dlna_t1=4652;
var dlna_t2=4653;
var help_stor1=4654;
var help_stor2=4655;
var help_stor3=4656;
var help_stor4=4657;
var help_stor5=4658;
var help_stor6=4659;
var help_stor7=4660;
var help_stor8=4661;
var help_stor9=4662;
var help_dlna1=4663;
var webf_non_hd=4664;
var sh_port_tx_22=4665;
var sh_port_tx_23=4666;
var IPv6_Ingress_Filtering_enable=4667;
var share_title_1=4668;
var share_title_2=4669;
var share_title_3=4670;
var share_title_4=4671;
var share_ser_1=4672;
var share_ser_2=4673;
var share_ser_3=4674;
var share_ser_4=4675;
var ddns_disconnecting=4676;
var lan_reserveIP=4677;
var end_ip=4678;
var _NULL=4679;
var ddns_sel1=4680;
var ddns_sel2=4681;
var ddns_sel3=4682;
var _remoteipaddr=4683;
var _back=4684;
var _ping_fail=4685;
var _ping_success=4686;
