//Version=1.03b02
//Language=ENGLISH
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Cancel", //_cancel
	"Copy Your PC's MAC Address", //_clone
	"DHCP Connection (Dynamic IP Address)", //_dhcpconn
	"IP Address", //_ipaddr
	"L2TP", //_L2TP
	"L2TP Gateway IP Address", //_L2TPgw
	"L2TP IP Address", //_L2TPip
	"L2TP Subnet Mask", //_L2TPsubnet
	"Language", //_Language
	"MAC Address", //_macaddr
	"Next", //_next
	"No", //_no
	"(optional)", //_optional
	"Password", //_password
	"PPTP Gateway IP Address", //_PPTPgw
	"PPTP IP Address", //_PPTPip
	"PPTP Subnet Mask", //_PPTPsubnet
	"Prev", //_prev
	"Please make the two admin passwords the same and try again", //_pwsame_admin
	"Static IP", //_sdi_staticip
	"Subnet Mask", //_subnet
	"User Name", //_username
	"Verify Password", //_verifypw
	"Do you want to abandon all changes you made to this wizard?", //_wizquit
	"Yes", //_yes
	"Invalid L2TP Server IP address", //bwn_alert_17
	"Address Mode", //bwn_AM
	"BigPond Server", //bwn_BPS
	"TKIP and AES", //bws_CT_3
	"Dynamic IP", //carriertype_ct_0
	"Router is detecting your Internet connection type, please wait ...", //ES_auto_detect_desc
	"Router is unable to detect your Internet connection type.", //ES_auto_detect_failed_desc
	"Do you want to bookmark \"D-Link Router Web Management\"?", //ES_bookmark
	"Try again", //ES_btn_try_again
	"Please plug one end of the included Ethernet cable that came with your router into the port labeled INTERNET on the back of the router. Plug the other end of this cable into the Ethernet port on your modem and power cycle the modem.", //ES_cable_lost_desc
	"Step 2: Configure your Wi-Fi Security", //ES_step_wifi_security
	"Step 3: Set your Password", //ES_title_s3
	"Step 4: Select your Time Zone", //ES_title_s4
	"Step 5: Save Settings", //ES_title_s5
	"Step 5: Confirm WI-FI settings", //ES_title_s5_0
	"Step 6: mydlink Registration", //ES_title_s6
	"mydlink Registration", //ES_title_s6_myd
	"Step 1: Configure your Internet Connection", //ES_wwa_title_s1
	"Invalid DHCP Client name", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Invalid DHCP+ password", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Invalid DHCP+ username", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"A L2TP user name MUST be specified", //GW_WAN_L2TP_USERNAME_INVALID
	"A PPTP password MUST be specified", //GW_WAN_PPTP_PASSWORD_INVALID
	"Invalid Network Key!", //IPV6_TEXT2
	"Invalid MAC address", //KR3
	"Auto (WPA or WPA2) - Personal", //KR48
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
	"Optimum Online", //manul_conn_13
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
	"Registering your product with mydlink will allow you to use its mydlink-enabled features, including online access and management of your device through the mydlink website.", //mydlink_tx01
	"Would you like to register your device with mydlink?", //mydlink_tx02
	"Please enter user name", //PPP_USERNAME_EMPTY
	"PPPoE Plus Supported", //pppoe_plus_dail
	"Password can only contain printable characters.", //S493
	"SAVING SETTINGS", //save_settings
	"Your settings are being saved.", //save_wait
	"Firmware Version", //sd_FWV
	"Product Page", //TA2
	"Hardware Version", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (US/Canada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (US/Canada)", //up_tz_06
	"(GMT-06:00) Central America", //up_tz_07
	"(GMT-06:00) Central Time (US/Canada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (US/Canada)", //up_tz_12
	"(GMT-05:00) Indiana (East)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Canada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Greenland", //up_tz_20
	"(GMT-02:00) Mid-Atlantic", //up_tz_21
	"(GMT-01:00) Azores", //up_tz_22
	"(GMT-01:00) Cape Verde Is.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna", //up_tz_26
	"(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague", //up_tz_27
	"(GMT+01:00) Brussels, Copenhagen, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Vienna, Prague, Warsaw", //up_tz_29b
	"(GMT+01:00) West Central Africa", //up_tz_30
	"(GMT+02:00) Athens, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bucharest", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Baghdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moscow, St. Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Tehran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Almaty", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnoyarsk", //up_tz_54
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapore", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"(GMT+09:00) Seoul", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Solomon Is., New Caledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall Is.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) International Date Line West", //up_tz_76
	"(GMT-11:00) Midway Island", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Mexico City, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (East)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulaan Bataar", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"DNS settings", //wwa_dnsset
	"Gateway Address", //wwa_gw
	"By default, your new D-Link Router does not have a password configured for administrator access to the Web-based configuration pages. To secure your new networking device, please set and verify a password below, and enabling CAPTCHA Graphical Authentication provides added security protection to prevent unauthorized online users and hacker software from accessing your network settings.", //wwa_intro_s1
	"Select the appropriate time zone for your location. This information is required to configure the time-based options. Your router will be set to automatically update its internal clock from an NTP time server.", //wwa_intro_s2
	"Please select your Internet connection type below:", //wwa_intro_s3
	"This wizard will guide you through a step-by-step process to configure your new D-Link router and connect to the Internet.", //wwa_intro_wel
	"L2TP Server IP Address (may be same as gateway)", //wwa_l2tp_svra
	"Choose this if your Internet connection automatically provides you with an IP Address. Most Cable Modems use this type of connection.", //wwa_msg_dhcp
	"If your Internet Service Provider was not listed or you don't know who it is, please select the Internet connection type below:", //wwa_msg_ispnot
	"Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection.", //wwa_msg_pppoe
	"PPTP client.", //wwa_msg_pptp
	"To set up this connection, please make sure that you are connected to the D-Link Router with the PC that was originally connected to your broadband connection. If you are, then click the Clone MAC button to copy your computer's MAC Address to the D-Link Router.", //wwa_msg_set_dhcp
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. If you do not have this information, please contact your ISP.", //wwa_msg_set_pppoe
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need PPTP IP address. If you do not have this information, please contact your ISP.", //wwa_msg_set_pptp
	"Choose this option if your Internet Setup Provider provided you with IP Address information that has to be manually configured.", //wwa_msg_sipa
	"Note: You may also need to provide a Host Name. If you do not have or know this information, please contact your ISP.", //wwa_note_hostname
	"Primary DNS Address", //wwa_pdns
	"PPTP Server IP Address (may be same as gateway)", //wwa_pptp_svraddr
	"Secondary DNS Address", //wwa_sdns
	"Not Listed or Don't Know", //wwa_selectisp_not
	"Set Username and Password Connection (L2TP)", //wwa_set_l2tp_title
	"To set up this connection you will need to have a complete list of IP information provided by your Internet Service Provider. If you have a Static IP connection and do not have this information, please contact your ISP.", //wwa_set_sipa_msg
	"Set Static IP Address Connection", //wwa_set_sipa_title
	"Set BigPond Cable Connection", //wwa_title_set_bigpond
	"Set Username and Password Connection (PPPoE)", //wwa_title_set_pppoe
	"Set Username and Password Connection (PPTP)", //wwa_title_set_pptp
	"Welcome to the D-Link Setup Wizard", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Username / Password Connection (L2TP)", //wwa_wanmode_l2tp
	"Username / Password Connection (PPPoE)", //wwa_wanmode_pppoe
	"Username / Password Connection (PPTP)", //wwa_wanmode_pptp
	"Static IP Address Connection", //wwa_wanmode_sipa
	"Give your Wi-Fi network a name.", //wwz_wwl_intro_s2_1
	"Wi-Fi Network Name (SSID)", //wwz_wwl_intro_s2_1_1
	"(Using up to 32 characters)", //wwz_wwl_intro_s2_1_2
	"Give your Wi-Fi network a password.", //wwz_wwl_intro_s2_2
	"Wi-Fi Password", //wwz_wwl_intro_s2_2_1
	"(Between 8 and 63 characters)", //wwz_wwl_intro_s2_2_2
	"Give your network a name, using up to 32 characters.", //wwz_wwl_intro_s3_1
	"Step 1: Welcome TO THE D-LINK WIRELESS SECURITY SETUP WIZARD", //wwz_wwl_title_s3
	"Invalid PPTP server IP address", //YM108
	"Use the same Wireless Security Password on both 2.4GHz and 5GHz band", //wwl_SSP
	"Give your Wi-Fi network a name and a password.", //wwz_wwl_intro_s0
	"The 1st address of %s must be an integer.", //MSG002
	"The 2nd address of %s must be an integer.", //MSG003
	"The 3rd address of %s must be an integer.", //MSG004
	"The 4th address of %s must be an integer.", //MSG005
	"The %s is an invalid address.", //MSG006
	"The %s cannot be zero.", //MSG007
	"The %s port entered is invalid.", //MSG008
	"The %s secret entered is invalid", //MSG009
	"The %s can't allow entry to loopback IP or multicast IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Please enter another %s value.", //MSG012
	"The value of %s must be numeric!", //MSG013
	"The range of %s is %1n ~ %2n.", //MSG014
	"The value of %s must be an even number.", //MSG015
	"The Key is invalid. The Key must be a 5 or 10 character hexadecimal number. You entered", //MSG016
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
	"Invalid Metric", //MSG043
	"Metric value should be in between (1..16).", //ar_alert_3
	"Invalid Netmask.", //ar_alert_5
	"The Key", //TEXT042_1
	" is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042_2
	"Note: You may also need to provide a Service Name. If you do not have or know this information, please contact your ISP.", //wwa_note_svcn
	"L2TP client.", //wwa_msg_l2tp
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need L2TP IP address. If you do not have this information, please contact your ISP.", //wwa_set_l2tp_msg
	"To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need BigPond Server IP address. If you do not have this information, please contact your ISP.", //wwa_msg_set_bigpond
	"Host Name", //_hostname
	"2.4GHz Band", //GW_WLAN_RADIO_0_NAME
	"5GHz Band", //GW_WLAN_RADIO_1_NAME
	"Below is a detailed summary of your Wi-Fi security settings. Please print this page out, or write the information on a piece of paper, so you can configure the correct settings on your Wi-Fi devices.", //wwl_intro_end
	"Please wait...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Connect", //_connect
	"Guide me through the Internet connection settings", //ES_btn_guide_me
	"Enable Graphical Authentication", //_graph_auth
	"D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME", //TEXT000
	"A L2TP password MUST be specified", //GW_WAN_L2TP_PASSWORD_INVALID
	"No internet detected, would you like to restart the wizard?", //mydlink_tx03
	"Administrator password cannot be blank.", //mydlink_tx04
	"Checking WAN connectivity.", //mydlink_tx05
	"seconds left.", //sec_left
	"Retry", //_retry
	"Do you have mydlink account?", //mydlink_tx06
	"Yes, I have a mydlink account.", //mydlink_tx07
	"No, I want to register and login with a new mydlink account.", //mydlink_tx08
	"E-mail Address (Account Name)", //mydlink_tx09
	"Please fulfill the options to complete the registration.", //mydlink_tx10
	"Confirm Password", //chk_pass
	"Last name", //Lname
	"First Name", //Fname
	"I Accept the mydlink terms and conditions.", //mydlink_tx12
	"To complete your mydlink registration, please check your Inbox for an email with confirmation instructions.", //mydlink_tx13_1
	" After confirming your email address, click the Login button.", //mydlink_tx13_2
	"Login", //_login
	"Ok", //_ok
	"Save", //_save
	"Please make two passwords the same and try again", //_pwsame
	"To use the features of  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> and the mydlink Lite app, you will need an account with <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"If you already have an account, select <strong>Yes, I have a mydlink account</strong> and click Next to register the router with <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"If you do not have an account, select <strong>No, I want to register and login with a new mydlink account</strong> and click Next to create an account. ", //mydlink_reg_into_3
	" If you do not wish to sign up for the mydlink service, please click Cancel.", //mydlink_reg_into_4_a
	"This e-mail address already has a mydlink account. Try a different e-mail address.", //mydlink_pop_01
	"You must accept the terms and conditions to continue.", //mydlink_pop_02
	"should not be blank.", //mydlink_pop_03
	"is invalid.", //mydlink_pop_04
	"You may now use mydlink service with this device", //mydlink_pop_05
	"Login failed", //mydlink_pop_06
	"Sign up", //_signup
	"After mydlink registration is completed, your router's default PPPoE, L2TP, PPTP connection will be set to Always On. If your ISP charges for usage, you may wish to manually choose Dial On Demand as your default setting.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"A PPPoE password MUST be specified", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Skip", //_skip
	" If you do not wish to sign up for the mydlink service, please click Skip.", //mydlink_reg_into_4
	"Saving Wi-Fi setting", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"This device is mydlink-enabled, which allows you to remotely monitor and manage your network through the mydlink.com website, or through the mydlink mobile app.", //_wz_mydlink_into_1
	"You will be able to check your network speeds, see who is connected, view device browsing history, and receive notifications about new users or intrusion attempts.", //_wz_mydlink_into_2
	"You can register this device with your existing mydlink account. If you do not have one, you can create one now.", //_wz_mydlink_into_3
	"Please check your mailbox for an email with confirmation instructions.", //_wz_mydlink_email_1
	"Router is checking Internet connectivity, please wait.", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"Metric value should be in between (1..15).", //ar_alert_3a
	"Server IP Address", //SERVER_IP_DESC
	"%s Gateway IP address %s must be within the WAN subnet.", //TEXT043
	"WAN", //WAN
	"SSID should be represent with ASCII character from code 32 to 126.", //ssid_ascii_range
	"IP Address should not be same as Default Gateway.", //ip_gateway_check
	"" //MAX
);
var _cancel=0;
var _clone=1;
var _dhcpconn=2;
var _ipaddr=3;
var _L2TP=4;
var _L2TPgw=5;
var _L2TPip=6;
var _L2TPsubnet=7;
var _Language=8;
var _macaddr=9;
var _next=10;
var _no=11;
var _optional=12;
var _password=13;
var _PPTPgw=14;
var _PPTPip=15;
var _PPTPsubnet=16;
var _prev=17;
var _pwsame_admin=18;
var _sdi_staticip=19;
var _subnet=20;
var _username=21;
var _verifypw=22;
var _wizquit=23;
var _yes=24;
var bwn_alert_17=25;
var bwn_AM=26;
var bwn_BPS=27;
var bws_CT_3=28;
var carriertype_ct_0=29;
var ES_auto_detect_desc=30;
var ES_auto_detect_failed_desc=31;
var ES_bookmark=32;
var ES_btn_try_again=33;
var ES_cable_lost_desc=34;
var ES_step_wifi_security=35;
var ES_title_s3=36;
var ES_title_s4=37;
var ES_title_s5=38;
var ES_title_s5_0=39;
var ES_title_s6=40;
var ES_title_s6_myd=41;
var ES_wwa_title_s1=42;
var GW_DHCP_CLIENT_CLIENT_NAME_INVALID=43;
var GW_WAN_DHCPPLUS_PASSWORD_INVALID=44;
var GW_WAN_DHCPPLUS_USERNAME_INVALID=45;
var GW_WAN_L2TP_USERNAME_INVALID=46;
var GW_WAN_PPTP_PASSWORD_INVALID=47;
var IPV6_TEXT2=48;
var KR3=49;
var KR48=50;
var manul_conn_01=51;
var manul_conn_02=52;
var manul_conn_03=53;
var manul_conn_04=54;
var manul_conn_05=55;
var manul_conn_06=56;
var manul_conn_07=57;
var manul_conn_08=58;
var manul_conn_09=59;
var manul_conn_10=60;
var manul_conn_11=61;
var manul_conn_12=62;
var manul_conn_13=63;
var manul_conn_14=64;
var manul_conn_15=65;
var manul_conn_16=66;
var manul_conn_17=67;
var manul_conn_18=68;
var manul_conn_19=69;
var manul_conn_20=70;
var manul_conn_21=71;
var manul_conn_22=72;
var manul_conn_23=73;
var manul_conn_24=74;
var manul_conn_25=75;
var mydlink_tx01=76;
var mydlink_tx02=77;
var PPP_USERNAME_EMPTY=78;
var pppoe_plus_dail=79;
var S493=80;
var save_settings=81;
var save_wait=82;
var sd_FWV=83;
var TA2=84;
var TA3=85;
var up_tz_00=86;
var up_tz_01=87;
var up_tz_02=88;
var up_tz_03=89;
var up_tz_04=90;
var up_tz_05=91;
var up_tz_06=92;
var up_tz_07=93;
var up_tz_08=94;
var up_tz_09=95;
var up_tz_10=96;
var up_tz_11=97;
var up_tz_12=98;
var up_tz_13=99;
var up_tz_14=100;
var up_tz_15=101;
var up_tz_16=102;
var up_tz_17=103;
var up_tz_18=104;
var up_tz_19=105;
var up_tz_20=106;
var up_tz_21=107;
var up_tz_22=108;
var up_tz_23=109;
var up_tz_24=110;
var up_tz_25=111;
var up_tz_26=112;
var up_tz_27=113;
var up_tz_28=114;
var up_tz_29=115;
var up_tz_29b=116;
var up_tz_30=117;
var up_tz_31=118;
var up_tz_32=119;
var up_tz_33=120;
var up_tz_34=121;
var up_tz_35=122;
var up_tz_36=123;
var up_tz_37=124;
var up_tz_38=125;
var up_tz_39=126;
var up_tz_40=127;
var up_tz_41=128;
var up_tz_42=129;
var up_tz_43=130;
var up_tz_44=131;
var up_tz_45=132;
var up_tz_46=133;
var up_tz_47=134;
var up_tz_48=135;
var up_tz_49=136;
var up_tz_50=137;
var up_tz_51=138;
var up_tz_52=139;
var up_tz_53=140;
var up_tz_54=141;
var up_tz_55=142;
var up_tz_56=143;
var up_tz_57=144;
var up_tz_58=145;
var up_tz_59=146;
var up_tz_60=147;
var up_tz_61=148;
var up_tz_62=149;
var up_tz_63=150;
var up_tz_64=151;
var up_tz_65=152;
var up_tz_66=153;
var up_tz_67=154;
var up_tz_68=155;
var up_tz_69=156;
var up_tz_70=157;
var up_tz_71=158;
var up_tz_72=159;
var up_tz_73=160;
var up_tz_74=161;
var up_tz_75=162;
var up_tz_76=163;
var up_tz_77=164;
var up_tz_78=165;
var up_tz_79=166;
var up_tz_80=167;
var up_tz_81=168;
var up_tz_82=169;
var up_tz_83=170;
var up_tz_84=171;
var up_tz_85=172;
var up_tz_86=173;
var up_tz_87=174;
var up_tz_88=175;
var up_tz_89=176;
var up_tz_90=177;
var up_tz_91=178;
var up_tz_92=179;
var wwa_dnsset=180;
var wwa_gw=181;
var wwa_intro_s1=182;
var wwa_intro_s2=183;
var wwa_intro_s3=184;
var wwa_intro_wel=185;
var wwa_l2tp_svra=186;
var wwa_msg_dhcp=187;
var wwa_msg_ispnot=188;
var wwa_msg_pppoe=189;
var wwa_msg_pptp=190;
var wwa_msg_set_dhcp=191;
var wwa_msg_set_pppoe=192;
var wwa_msg_set_pptp=193;
var wwa_msg_sipa=194;
var wwa_note_hostname=195;
var wwa_pdns=196;
var wwa_pptp_svraddr=197;
var wwa_sdns=198;
var wwa_selectisp_not=199;
var wwa_set_l2tp_title=200;
var wwa_set_sipa_msg=201;
var wwa_set_sipa_title=202;
var wwa_title_set_bigpond=203;
var wwa_title_set_pppoe=204;
var wwa_title_set_pptp=205;
var wwa_title_wel=206;
var wwa_wanmode_bigpond=207;
var wwa_wanmode_l2tp=208;
var wwa_wanmode_pppoe=209;
var wwa_wanmode_pptp=210;
var wwa_wanmode_sipa=211;
var wwz_wwl_intro_s2_1=212;
var wwz_wwl_intro_s2_1_1=213;
var wwz_wwl_intro_s2_1_2=214;
var wwz_wwl_intro_s2_2=215;
var wwz_wwl_intro_s2_2_1=216;
var wwz_wwl_intro_s2_2_2=217;
var wwz_wwl_intro_s3_1=218;
var wwz_wwl_title_s3=219;
var YM108=220;
var wwl_SSP=221;
var wwz_wwl_intro_s0=222;
var MSG002=223;
var MSG003=224;
var MSG004=225;
var MSG005=226;
var MSG006=227;
var MSG007=228;
var MSG008=229;
var MSG009=230;
var MSG010=231;
var MSG012=232;
var MSG013=233;
var MSG014=234;
var MSG015=235;
var MSG016=236;
var MSG017=237;
var MSG018=238;
var MSG019=239;
var MSG020=240;
var MSG021=241;
var MSG022=242;
var MSG023=243;
var MSG024=244;
var MSG025=245;
var MSG026=246;
var MSG027=247;
var MSG028=248;
var MSG029=249;
var MSG030=250;
var MSG031=251;
var MSG032=252;
var MSG033=253;
var MSG034=254;
var MSG035=255;
var MSG043=256;
var ar_alert_3=257;
var ar_alert_5=258;
var TEXT042_1=259;
var TEXT042_2=260;
var wwa_note_svcn=261;
var wwa_msg_l2tp=262;
var wwa_set_l2tp_msg=263;
var wwa_msg_set_bigpond=264;
var _hostname=265;
var GW_WLAN_RADIO_0_NAME=266;
var GW_WLAN_RADIO_1_NAME=267;
var wwl_intro_end=268;
var _please_wait=269;
var _copyright=270;
var _connect=271;
var ES_btn_guide_me=272;
var _graph_auth=273;
var TEXT000=274;
var GW_WAN_L2TP_PASSWORD_INVALID=275;
var mydlink_tx03=276;
var mydlink_tx04=277;
var mydlink_tx05=278;
var sec_left=279;
var _retry=280;
var mydlink_tx06=281;
var mydlink_tx07=282;
var mydlink_tx08=283;
var mydlink_tx09=284;
var mydlink_tx10=285;
var chk_pass=286;
var Lname=287;
var Fname=288;
var mydlink_tx12=289;
var mydlink_tx13_1=290;
var mydlink_tx13_2=291;
var _login=292;
var _ok=293;
var _save=294;
var _pwsame=295;
var mydlink_reg_into_1=296;
var mydlink_reg_into_2=297;
var mydlink_reg_into_3=298;
var mydlink_reg_into_4_a=299;
var mydlink_pop_01=300;
var mydlink_pop_02=301;
var mydlink_pop_03=302;
var mydlink_pop_04=303;
var mydlink_pop_05=304;
var mydlink_pop_06=305;
var _signup=306;
var mydlink_pop_09=307;
var mdl_errmsg_01=308;
var mdl_errmsg_02=309;
var mdl_errmsg_03=310;
var mdl_errmsg_04=311;
var mdl_errmsg_05=312;
var SSID_EMPTY_ERROR=313;
var YM102=314;
var GW_WAN_PPPoE_PASSWORD_INVALID=315;
var limit_pass_msg=316;
var _skip=317;
var mydlink_reg_into_4=318;
var mydlink_WiFi_save=319;
var rus_wan_pptp=320;
var rus_wan_pptp_01=321;
var rus_wan_l2tp=322;
var rus_wan_l2tp_01=323;
var rus_wan_pppoe=324;
var rus_wan_pppoe_02=325;
var rus_wan_pppoe_03=326;
var _wz_mydlink_into_1=327;
var _wz_mydlink_into_2=328;
var _wz_mydlink_into_3=329;
var _wz_mydlink_email_1=330;
var _chk_wanconn_msg_00=331;
var _wz_skip_mydlink=332;
var ar_alert_3a=333;
var SERVER_IP_DESC=334;
var TEXT043=335;
var WAN=336;
var ssid_ascii_range=337;
var ip_gateway_check=338;