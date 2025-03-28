var subnet_mask = new Array(0, 128, 192, 224, 240, 248, 252, 254, 255);
var month = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
var sequence = new Array("1st", "2nd", "3rd", "4th", "5th", "6th");
var msg = new Array("The IP Address entered is invalid",	
"The IP Address cannot be zero.",	
"IP Address",	
"The Subnet Mask entered is invalid",	
"The Subnet Mask cannot be zero",	
"Subnet Mask",	
"The Gateway IP Address entered is invalid",	
"The Gateway IP Address cannot be zero",	
"Gateway IP Address",	
"%s Gateway IP address %s must be within the WAN subnet.",	
"The Starting IP Address entered is invalid (IP Range: 1~254)",	
"Please enter another Starting IP Address",	
"Starting IP Address",	
"The LAN IP Address and the Start IP Address are not in the same subnet",	
"The Ending IP Address entered is invalid (IP Range: 1~254)",	
"Please enter another Ending IP Address",	
"Ending IP Address",	
"The LAN IP Address and the End IP Address are not in the same subnet",	
"The Primary DNS Address entered is invalid",	
"The Primary DNS Address cannot be zero",	
"Primary DNS Address",	
"The SSID field cannot be blank",	
"WEP cannot be disabled when the Authentication type is set to Shared Key",	
"The length of the Passphrase must be at least 8 characters",	
"The Confirmed Passphrase does not match the Passphrase",	
"The Confirmed Password does not match the New Password",	
"The selected WEP key field cannot be blank",	
"Please enter another Key",	
"Quit setup wizard and discard settings?",	
"The MAC Address entered is invalid.",	
"The Ending IP Address must be greater than the Starting IP Address",	
"The Secondary DNS Address entered is invalid",	
"The Secondary DNS Address cannot be zero",	
"Secondary DNS Address",	
"The confirmed password does not match the new Admin password",	
"The confirmed password does not match the new User password",	
"Please enter another Server Name",	
"The Host Name is invalid.",	
"Please enter another User Name",	
"Please enter another Password",	
"Are you sure you want to reset the device to its factory default settings?\nThis will cause all current settings to be lost.",	
"Are you sure you want to reboot the device?\nRebooting will disconnect any active internet sessions.",	
"Load settings from a saved configuration file?",	
"You must enter the name of a configuration file first.",	
"Only the Admin account can download the settings",	
"Please enter either a Host Name or an IP Address",	
"Please enter another SMTP Server or IP Address",	
"Please enter a valid email Address",	
"Are you sure that you want to delete this Virtual Server Rule?",	
"Are you sure that you want to delete this Application Rule",	
"Are you sure that you want to delete this Filter?",	
"Are you sure that you want to delete this Route?",	
"Are you sure that you want to delete this MAC Address?",	
"Are you sure that you want to delete this Keyword?",	
"Are you sure that you want to delete this Domain?",	
"Are you sure that you want to delete this Entry?",	
"Are you sure that you want to delete this DHCP Reservation?",	
"Please enter another name",	
"Please enter a Trigger Port number",	
"Please enter a Firewall Port number",	
"Please enter another Private Port number",	
"Please enter a Private IP Address.",	
"Please enter another port number",	
"Please select a Keyword to delete",	
"The Keyword entered already exists in the list",	
"Please enter another Keyword",	
"Unable to add another Keyword",	
"Please select a Blocked Domain to delete",	
"Please select a Permitted Domain to delete",	
"The Domain entered already exists in the list of Blocked Domains",	
"Please enter another Blocked Domain",	
"Unable to add another Blocked Domain",	
"The Domain entered already exists in the list of Permitted Domains",	
"Please enter another Permitted Domain",	
"Unable to add another Permitted Domain",	
"Please select a Firmware file to upgrade the router to",	
"Please enter another Domain",	
"Unable to add another Control Domains",	
"Please select a Control Domain to delete",	
"Please enter at least one Control Domain",	
"The RADIUS Server 1 IP Address entered is invalid",	
"The Radius Server 1 IP Address cannot be zero",	
"Radius Server 1 IP Address",	
"The RADIUS Server 2 IP Address entered is invalid",	
"The Radius Server 2 IP Address cannot be zero",	
"Radius Server 2 IP Address",	
"The IP Address entered is invalid (IP Range: 1~254)",	
"Please enter another IP Address",	
"Please enter another Name",	
"The Server IP Address entered is invalid",	
"The Server IP Address cannot be zero",	
"Server IP Address",	
"The Passwords entered do not match",	
"The Source Start IP Address entered is invalid",	
"The Source Start IP Address cannot be zero",	
"Source Start IP Address",	
"The Source End IP Address entered is invalid",	
"The Source End IP Address cannot be zero",	
"Source End IP Address",	
"The Destination Start IP Address entered is invalid",	
"The Destination Start IP Address cannot be zero",	
"Destination Start IP Address",	
"The Destination End IP Address entered is invalid",	
"The Destination End IP Address cannot be zero",	
"Destination End IP Address",	
"The length of the Passphrase must be between 8 and 63 characters",	
"Reset JumpStart?",	
"Are you sure that you want to delete this rule?",	
"Are you sure that you want to delete this schedule?",	
"Unable to add another schedule",	
"Schedule Name can not empty",	
"Schedule Name can not enter all space",	
"The Start Time entered is invalid",	
"The End Time entered is invalid",	
"The Start Time cannot be greater than the End Time",	
"Please select a machine first",	
"Please select an Application Name first",	
"Please select a Computer Name first",	
"Please enter another Wireless Security Password",	
"The Parental Control rule entered is already in the list",	
"Login Name error", 
"Login Password error",	
"%s is conflicted with LAN IP address, please enter again.",	
"The PSK should Hex.",	
"The IP Address and the reservation IP Address are not in the same subnet.",	
"There is unsaved data on this page. Do you want to abandon it?\n IF not, press Cancel and then click Save Settings.\nIf so, press OK.",	
"The confirmed password does not match the new User password",	
"Nothing has changed, save anyway?",	
"Rule name can not be empty string!",	
"The Ending Port number must be greater than the Starting Port number",	
"Are you sure that you want to enable/disable",	
"Are you sure that you want to delete ",	
"You must abandon all your changes in order to define a new schedule.\n Press 'Ok' to abandon these changes and display the Schedule page.\n Otherwise press 'Cancel'.", 
"Please enter user name", 
"Invalid LAN IP Address, ip address in DHCP Server range",	
"Reserved IP address should be within the configured DHCP range."	
);
var INVALID_IP_ADDRESS = 0;
var ZERO_IP_ADDRESS = 1;
var IP_ADDRESS_DESC = 2;
var INVALID_MASK_ADDRESS = 3;
var ZERO_MASK_ADDRESS = 4;
var MASK_ADDRESS_DESC = 5;
var INVALID_GATEWAY_ADDRESS = 6;
var ZERO_GATEWAY_ADDRESS = 7;
var GATEWAY_ADDRESS_DESC = 8;
var NOT_SAME_DOMAIN = 9;
var INVALID_START_IP = 10;
var ZERO_START_IP = 11;
var START_IP_DESC = 12;
var START_INVALID_DOMAIN = 13;
var INVALID_END_IP = 14;
var ZERO_END_IP = 15;
var END_IP_DESC = 16;
var END_INVALID_DOMAIN = 17;
var INVALID_DNS_ADDRESS = 18;
var ZERO_DNS_ADDRESS = 19;
var DNS_ADDRESS_DESC = 20;
var SSID_EMPTY_ERROR = 21;
var AUTH_TYPE_ERROR = 22;
var PSK_LENGTH_ERROR = 23;
var PSK_MATCH_ERROR = 24;
var MATCH_PWD_ERROR = 25;
var WEP_KEY_EMPTY = 26;
var WIZARD_KEY_EMPTY = 27;
var QUIT_WIZARD = 28;
var MAC_ADDRESS_ERROR = 29;
var IP_RANGE_ERROR = 30;
var INVALID_SEC_DNS_ADDRESS = 31;
var ZERO_SEC_DNS_ADDRESS = 32;
var SEC_DNS_ADDRESS_DESC = 33;
var ADMIN_PASS_ERROR = 34;
var USER_PASS_ERROR = 35;
var DDNS_SERVER_ERROR = 36;
var DDNS_HOST_ERROR = 37;
var DDNS_USER_ERROR = 38;
var DDNS_PASS_ERROR = 39;
var RESTORE_DEFAULT = 40;
var REBOOT_ROUTER = 41;
var LOAD_SETTING = 42;
var LOAD_FILE_ERROR = 43;
var DOWNLOAD_SETTING_ERROR = 44;
var PING_IP_ERROR = 45;
var SMTP_SERVER_ERROR = 46;
var EMAIL_ADDRESS_ERROR = 47;
var DEL_SERVER_MSG = 48;
var DEL_APPLICATION_MSG = 49;
var DEL_FILTER_MSG = 50;
var DEL_ROUTE_MSG = 51;
var DEL_MAC_MSG = 52;
var DEL_KEYWORD_MSG = 53;
var DEL_DOMAIN_MSG = 54;
var DEL_ENTRY_MSG = 55;
var DEL_STATIC_DHCP_MSG = 56;
var NAME_ERROR = 57;
var TRIGGER_PORT_ERROR = 58;
var PUBLIC_PORT_ERROR = 59;
var PRIVATE_PORT_ERROR = 60;
var PRIVATE_IP_ERROR = 61;
var PORT_ERROR = 62;
var DEL_KEYWORD_ERROR = 63;
var SAME_KEYWORD_ERROR = 64;
var KEYWORD_ERROR = 65;
var ADD_KEYWORD_ERROR = 66;
var DEL_BLOCK_DOMAIN_ERROR = 67;
var DEL_PERMIT_DOMAIN_ERROR = 68;
var SAME_BLOCK_DOMAIN = 69;
var BLOCK_DOMAIN_ERROR = 70;
var ADD_BLOCK_DOMAIN_ERROR = 71;
var SAME_PERMIT_DOMAIN = 72;
var PERMIT_DOMAIN_ERROR = 73;
var ADD_PERMIT_DOMAIN_ERROR = 74;
var FIRMWARE_UPGRADE_ERROR = 75;
var DOMAIN_ERROR = 76;
var ADD_CONTROL_DOMAIN_ERROR = 77;
var DEL_CONTROL_DOMAIN_ERROR = 78;
var CONTROL_DOMAIN_ERROR = 79;
var INVALID_RADIUS_SERVER1_IP = 80;
var ZERO_RADIUS_SERVER1_IP = 81;
var RADIUS_SERVER1_IP_DESC = 82;
var INVALID_RADIUS_SERVER2_IP = 83;
var ZERO_RADIUS_SERVER2_IP = 84;
var RADIUS_SERVER2_IP_DESC = 85;
var INVALID_STATIC_DHCP_IP = 86;
var ZERO_STATIC_DHCP_IP = 87;
var STATIC_DHCP_NAME = 88;
var INVALID_SERVER_IP = 89;
var ZERO_SERVER_IP = 90;
var SERVER_IP_DESC = 91;
var MATCH_WIZARD_PWD_ERROR = 92;
var INVALID_SOURCE_START_IP = 93;
var ZERO_SOURCE_START_IP = 94;
var SOURCE_START_IP_DESC = 95;
var INVALID_SOURCE_END_IP = 96;
var ZERO_SOURCE_END_IP = 97;
var SOURCE_END_IP_DESC = 98;
var INVALID_DEST_START_IP = 99;
var ZERO_DEST_START_IP = 100;
var DEST_START_IP_DESC = 101;
var INVALID_DEST_END_IP = 102;
var ZERO_DEST_END_IP = 103;
var DEST_END_IP_DESC = 104;
var PSK_OVER_LEN = 105;
var RESET_JUMPSTAR = 106;
var DEL_RULE_MSG = 107;
var DEL_SCHEDULE_MSG = 108;
var ADD_SCHEDULE_ERROR = 109;
var SCHEDULE_NAME_ERROR = 110
var SCHEDULE_NAME_SPACE_ERROR = 111;
var START_TIME_ERROR = 112;
var END_TIME_ERROR = 113;
var TIME_RANGE_ERROR = 114;
var SELECT_MACHINE_ERROR = 115;
var SELECT_APPLICATION_ERROR = 116;
var SELECT_COMPUTER_ERROR = 117;
var SECURITY_PWD_ERROR = 118;
var DUPLICATE_URL_ERROR = 119;
var LOGIN_NAME_ERROR = 120;
var LOGIN_PASS_ERROR = 121;
var THE_SAME_LAN_IP = 122;
var THE_PSK_IS_HEX = 123;
var SER_NOT_SAME_DOMAIN = 124;
var IS_CHANGE_DATA = 125;
var DDNS_PASS_ERROR_MARTH = 126;
var FORM_MODIFIED_CHECK = 127;
var INBOUND_NAME_ERROR = 128;
var PORT_RANGE_ERROR = 129;
var CHECK_ENABLE = 130;
var DEL_MSG = 131;
var GO_SCHEDULE = 132;
var PPP_USERNAME_EMPTY = 133;
var NETWORK_DHCP_IP_IN_SERVER = 134;
var BD_ALERT_8 = 135;
var default_virtual = new Array(new rule_obj("TELNET", "6", 23, 23),
new rule_obj("HTTP", "6", 80, 80),
new rule_obj("HTTPS", "6", 443, 443),
new rule_obj("FTP", "6", 21, 21),
new rule_obj("DNS", "17", 53, 53),
new rule_obj("SMTP", "6", 25, 25),
new rule_obj("POP3", "6", 110, 110),
new rule_obj("H.323", "6", 1720, 1720),
new rule_obj("REMOTE DESKTOP", "6", 3389, 3389),
new rule_obj("PPTP", "6", 1723, 1723),
new rule_obj("L2TP", "17", 1701, 1701),
new rule_obj("Wake-On-LAN", "17", 9, 9)
);
var default_rule = new Array(new rule_obj("Age of Empires", "TCP", "2302-2400,6073", "2302-2400,6073"),
new rule_obj("Aliens vs. Predator", "TCP", "80,2300-2400,8000-8999", "80,2300-2400,8000-8999"),
new rule_obj("America's Army", "TCP", "20045", "1716-1718,8777,27900"),
new rule_obj("Asheron's Call", "TCP", "9000-9013", "2001,9000-9013"),
new rule_obj("Battlefield 1942", "TCP", "", "14567,22000,23000-23009,27900,28900"),
new rule_obj("Battlefield 2", "TCP", "80,4711,29900,29901,29920,28910", "1500-4999,16567,27900,29900,29910,27901,55123,55124,55215"),
new rule_obj("Battlefield: Vietnam", "TCP", "", "4755,23000,22000,27243-27245"),
new rule_obj("BitTorrent", "TCP", "6881-6889", ""),
new rule_obj("Black and White", "TCP", "2611-2612,6500,6667,27900", "2611-2612,6500,6667,27900"),
new rule_obj("Call of Duty", "TCP", "28960", "20500,20510,28960"),
new rule_obj("Command and Conquer Generals", "TCP", "80,6667,28910,29900,29920", "4321,27900"),
new rule_obj("Command and Conquer Zero Hour", "TCP", "80,6667,28910,29900,29920", "4321,27900"),
new rule_obj("Counter Strike", "TCP", "27030-27039", "1200,27000-27015"),
new rule_obj("D-Link DVC-1000", "TCP", "1720,15328-15333", "15328-15333"),
new rule_obj("Dark Reign 2", "TCP", "26214", "26214"),
new rule_obj("Delta Force", "TCP", "3100-3999", "3568"),
new rule_obj("Diablo I and II", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Doom 3", "TCP", "", "27666"),
new rule_obj("Dungeon Siege", "TCP", "", "6073,2302-2400"),
new rule_obj("eDonkey", "TCP", "4661-4662", "4665"),
new rule_obj("eMule", "TCP", "4661-4662,4711", "4672,4665"),
new rule_obj("Everquest", "TCP", "1024-6000,7000", "1024-6000,7000"),
new rule_obj("Far Cry", "TCP", "", "49001,49002"),
new rule_obj("Final Fantasy XI (PC)", "TCP", "25,80,110,443,50000-65535", "50000-65535"),
new rule_obj("Final Fantasy XI (PS2)", "TCP", "1024-65535", "50000-65535"),
new rule_obj("Gamespy Arcade", "TCP", "", "6500"),
new rule_obj("Gamespy Tunnel", "TCP", "", "6700"),
new rule_obj("Ghost Recon", "TCP", "2346-2348", "2346-2348"),
new rule_obj("Gnutella", "TCP", "6346", "6346"),
new rule_obj("Half Life", "TCP", "6003,7002", "27005,27010,27011,27015"),
new rule_obj("Halo: Combat Evolved", "TCP", "", "2302,2303"),
new rule_obj("Heretic II", "TCP", "28910", "28910"),
new rule_obj("Hexen II", "TCP", "26900", "26900"),
new rule_obj("Jedi Knight II: Jedi Outcast", "TCP", "", "28060,28061,28062,28070-28081"),
new rule_obj("Jedi Knight III: Jedi Academy", "TCP", "", "28060,28061,28062,28070-28081"),
new rule_obj("KALI", "TCP", "", "2213,6666"),
new rule_obj("Links", "TCP", "2300-2400,47624", "2300-2400,6073"),
new rule_obj("Medal of Honor: Games", "TCP", "12203-12204", ""),
new rule_obj("MSN Game Zone", "TCP", "6667", "28800-29000"),
new rule_obj("MSN Game Zone (DX)", "TCP", "2300-2400,47624", "2300-2400"),
new rule_obj("Myth", "TCP", "3453", "3453"),
new rule_obj("Need for Speed", "TCP", "9442", "9442"),
new rule_obj("Need for Speed 3", "TCP", "1030", "1030"),
new rule_obj("Need for Speed: Hot Pursuit 2", "TCP", "8511,28900", "1230,8512,27900,61200-61230"),
new rule_obj("Neverwinter Nights", "TCP", "", "5120-5300,6500,27900,28900"),
new rule_obj("PainKiller", "TCP", "", "3455"),
new rule_obj("PlayStation2", "TCP", "4658,4659", "4658,4659"),
new rule_obj("Postal 2: Share the Pain", "TCP", "80", "7777-7779,27900,28900"),
new rule_obj("Quake 2", "TCP", "27910", "27910"),
new rule_obj("Quake 3", "TCP", "27660,27960", "27660,27960"),
new rule_obj("Rainbow Six", "TCP", "2346", "2346"),
new rule_obj("Rainbow Six: Raven Shield", "TCP", "", "7777-7787,8777-8787"),
new rule_obj("Return to Castle Wolfenstein", "TCP", "", "27950,27960,27965,27952"),
new rule_obj("Rise of Nations", "TCP", "", "34987"),
new rule_obj("Roger Wilco", "TCP", "3782", "27900,28900,3782-3783"),
new rule_obj("Rogue Spear", "TCP", "2346", "2346"),
new rule_obj("Serious Sam II", "TCP", "25600-25605", "25600-25605"),
new rule_obj("Shareaza", "TCP", "6346", "6346"),
new rule_obj("Silent Hunter II", "TCP", "3000", "3000"),
new rule_obj("Soldier of Fortune", "TCP", "", "28901,28910,38900-38910,22100-23000"),
new rule_obj("Soldier of Fortune II: Double Helix", "TCP", "", "20100-20112"),
new rule_obj("Splinter Cell: Pandora Tomorrow", "TCP", "40000-43000", "44000-45001,7776,8888"),
new rule_obj("Star Trek: Elite Force II", "TCP", "", "29250,29256"),
new rule_obj("Starcraft", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Starsiege Tribes", "TCP", "", "27999,28000"),
new rule_obj("Steam", "TCP", "27030-27039", "1200,27000-27015"),
new rule_obj("SWAT 4", "TCP", "", "10480-10483"),
new rule_obj("TeamSpeak", "TCP", "", "8767"),
new rule_obj("Tiberian Sun", "TCP", "1140-1234,4000", "1140-1234,4000"),
new rule_obj("Tiger Woods 2K4", "TCP", "80,443,1791-1792,13500,20801-20900,32768-65535", "80,443,1791-1792,13500,20801-20900,32768-65535"),
new rule_obj("Tribes of Vengeance", "TCP", "7777,7778,28910", "6500,7777,7778,27900"),
new rule_obj("Ubi.com", "TCP", "40000-42999", "41005"),
new rule_obj("Ultima", "TCP", "5001-5010,7775-7777,7875,8800-8900,9999", "5001-5010,7775-7777,7875,8800-8900,9999"),
new rule_obj("Unreal", "TCP", "7777,8888,27900", "7777-7781"),
new rule_obj("Unreal Tournament", "TCP", "7777-7783,8080,27900", "7777-7783,8080,27900"),
new rule_obj("Unreal Tournament 2004", "TCP", "28902", "7777-7778,7787-7788"),
new rule_obj("Vietcong", "TCP", "", "5425,15425,28900"),
new rule_obj("Warcraft II", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("Warcraft III", "TCP", "6112-6119,4000", "6112-6119"),
new rule_obj("WinMX", "TCP", "6699", "6257"),
new rule_obj("Wolfenstein: Enemy Territory", "TCP", "", "27950,27960,27965,27952"),
new rule_obj("WON Servers", "TCP", "27000-27999", "15001,15101,15200,15400"),
new rule_obj("World of Warcraft", "TCP", "3724,6112,6881-6999", ""),
new rule_obj("Xbox Live", "TCP", "3074", "88,3074")
);
var default_appl = new Array(new appl_obj("AIM Talk", "TCP", "4099", "TCP", "5190"),
new appl_obj("BitTorrent", "TCP", "6969", "TCP", "6881-6889"),
new appl_obj("Calista IP phone", "TCP", "5190", "UDP", "3000"),
new appl_obj("ICQ", "UDP", "4000", "TCP", "20000,20019,20039,20059"),
new appl_obj("PalTalk", "TCP", "5001-5020", "Any", "2090,2091,2095")
);


var all_ip_addr_msg = new Array("The %s is an invalid address.",	
"The %s can not be zero.",	
"The 1st address of %s must be an integer.",	
"The 2nd address of %s must be an integer.",	
"The 3rd address of %s must be an integer.",	
"The 4th address of %s must be an integer.",	
"The 1st range of %s must be between ",	
"The 2nd range of %s must be between ",	
"The 3rd range of %s must be between ",	
"The 4th range of %s must be between ",	
"The %s port entered is invalid.",	
"The %s secret entered is invalid",	
"The %s can't allow enter loopback IP or multicast IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x)."	
);

var subnet_mask_msg = new Array("The Subnet Mask is an invalid address.",	
"The Subnet Mask can not be zero.",	
"The 1st address of Subnet Mask must be an integer.",	
"The 2nd address of Subnet Mask must be an integer.",	
"The 3rd address of Subnet Mask must be an integer.",	
"The 4th address of Subnet Mask must be an integer.",	
"The 1st range of Subnet Mask must be 128, 192, 224, 240, 248, 252, 254, 255.",	
"The 2nd range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252, 254, 255.",	
"The 3rd range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252, 254, 255.",	
"The 4th range of Subnet Mask must be 0, 128, 192, 224, 240, 248, 252."	
);
var metric_msg = new Array("Please enter another Metric value.",
"The value of Metric must be an integer.",
"The range of Metric is 1 ~ 15."
);	
var INVALID_IP = 0;
var ZERO_IP = 1;
var FIRST_IP_ERROR = 2;
var SECOND_IP_ERROR = 3;
var THIRD_IP_ERROR = 4;
var FOURTH_IP_ERROR = 5;
var FIRST_RANGE_ERROR = 6;
var SECOND_RANGE_ERROR = 7;
var THIRD_RANGE_ERROR = 8;
var FOURTH_RANGE_ERROR = 9;
var RADIUS_SERVER_PORT_ERROR = 10;	
var RADIUS_SERVER_SECRET_ERROR = 11; 
var MULTICASE_IP_ERROR = 12;
var check_num_msg = new Array("Please enter another %s value.",
"The value of %s must be numeric!",
"The range of %s is %1n ~ %2n.",
"The value of %s is even number only."
);
var EMPTY_VARIBLE_ERROR = 0;
var INVALID_VARIBLE_ERROR = 1;
var VARIBLE_RANGE_ERROR = 2;
var EVEN_NUMBER_ERROR = 3;
/** the end of check_varible() using **/
/** for get_key_len_msg() using **/
var key_len_error = new Array("The Key is invalid. The Key must be 5 characters or 10 hexadecimal number. You entered ",
"The Key is invalid. The Key must be 13 characters or 26 hexadecimal number. You entered "
);
var illegal_key_error = new Array("Key is wrong, the legal characters are 0~9, A~F, or a~f.",
"Key is wrong, the legal characters are 0~9, A~F, or a~f.",
"Key is wrong, the legal characters are 0~9, A~F, or a~f.",
"Key is wrong, the legal characters are 0~9, A~F, or a~f."	
);
/** the end of get_key_len_msg() using **/	
/** for ipv6 error message as following **/ 
var all_ipv6_addr_msg = new Array("The %s is an invalid address.",	
"The %s can not be zero.",	
"The 1st address of %s must be a hexadecimal.",	
"The 2nd address of %s must be a hexadecimal.",	
"The 3rd address of %s must be a hexadecimal.",	
"The 4th address of %s must be a hexadecimal.",	
"The 5th address of %s must be a hexadecimal.",	
"The 6th address of %s must be a hexadecimal.",	
"The 7th address of %s must be a hexadecimal.",	
"The 8th address of %s must be a hexadecimal.",	
"The 1st range of %s must be between ",	
"The 2nd range of %s must be between ",	
"The 3rd range of %s must be between ",	
"The 4th range of %s must be between ",	
"The 5th range of %s must be between ",	
"The 6th range of %s must be between ",	
"The 7th range of %s must be between ",	
"The 8th range of %s must be between ",	
"", 
"",	
"The %s can't allow enter loopback IP ( ::1 ).", 
"The %s can't allow enter multicast IP ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2." 
);
var IPv6_INVALID_IP = 0;
var IPv6_ZERO_IP = 1;
var IPv6_FIRST_IP_ERROR = 2;
var IPv6_SECOND_IP_ERROR = 3;
var IPv6_THIRD_IP_ERROR = 4;
var IPv6_FOURTH_IP_ERROR = 5;
var IPv6_FIFTH_IP_ERROR =6;
var IPv6_SIXTH_IP_ERROR =7;
var IPv6_SEVENTH_IP_ERROR =8;
var IPv6_EIGHTH_IP_ERROR=9;
var IPv6_FIRST_RANGE_ERROR = 10;
var IPv6_SECOND_RANGE_ERROR = 11;
var IPv6_THIRD_RANGE_ERROR = 12;
var IPv6_FOURTH_RANGE_ERROR = 13;
var IPv6_FIFTH_RANGE_ERROR =14;
var IPv6_SIXTH_RANGE_ERROR =15;
var IPv6_SEVENTH_RANGE_ERROR = 16;
var IPv6_EIGHTH_RANGE_ERROR =17;
var IPv6_RADIUS_SERVER_PORT_ERROR = 18;	
var IPv6_RADIUS_SERVER_SECRET_ERROR = 19; 
var IPv6_LOOPBACK_IP_ERROR =20;	
var IPv6_MULTICASE_IP_ERROR =21; 
