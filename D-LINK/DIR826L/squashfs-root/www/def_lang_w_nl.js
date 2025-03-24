//Version=1.01b02
//Language=Dutch
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Annuleren", //_cancel
	"Het MAC-adres van uw pc kopiëren", //_clone
	"DHCP-aansluiting (dynamisch IP-adres)", //_dhcpconn
	"IP-adres", //_ipaddr
	"L2TP", //_L2TP
	"L2TP Gateway IP-adres", //_L2TPgw
	"L2TP IP-adres", //_L2TPip
	"L2TP-subnetmasker", //_L2TPsubnet
	"Taal", //_Language
	"MAC-adres", //_macaddr
	"Volgende", //_next
	"Nee", //_no
	"(optioneel)", //_optional
	"Wachtwoord", //_password
	"PPTP Gateway IP-adres", //_PPTPgw
	"PPTP IP-adres", //_PPTPip
	"PPTP subnetmasker", //_PPTPsubnet
	"Vorige", //_prev
	"Zorg dat de twee admin wachtwoorden hetzelfde zijn en probeer het opnieuw", //_pwsame_admin
	"Statisch IP", //_sdi_staticip
	"Subnetmasker", //_subnet
	"Gebruikersnaam", //_username
	"Controleer wachtwoord", //_verifypw
	"Wilt u alle wijzigingen die u in deze wizard gemaakt hebt intrekken?", //_wizquit
	"Ja", //_yes
	"Ongeldig IP-adres L2TP-server:", //bwn_alert_17
	"Adresmodus", //bwn_AM
	"BigPond Server", //bwn_BPS
	"TKIP en AES", //bws_CT_3
	"Dynamisch IP", //carriertype_ct_0
	"Router is bezig met het detecteren van uw Internet verbindingstype, even geduld…", //ES_auto_detect_desc
	"De router kan uw Internetverbindingstype niet detecteren.", //ES_auto_detect_failed_desc
	"Wilt u \"D-Link Router Web Management\" opslaan in uw favorieten?", //ES_bookmark
	"Probeer het opnieuw", //ES_btn_try_again
	"Steek het ene uiteinde van de meegeleverde Ethernet-kabel die bij uw router werd meegeleverd in de poort met de naam INTERNET op de achterkant van de router. Steek het andere uiteinde van deze kabel in de Ethernet-poort op uw modem.", //ES_cable_lost_desc
	"Stap 2: Configureer uw Wi-Fi beveiliging", //ES_step_wifi_security
	"Stap 3: Stel uw wachtwoord in", //ES_title_s3
	"Stap 4: Selecteer uw Tijdzone", //ES_title_s4
	"Stap 5: Instellingen opslaan", //ES_title_s5
	"Stap 5: bevestig WI-FI-instellingen", //ES_title_s5_0
	"Stap 6: MYDLINK registratie", //ES_title_s6
	"MYDLINK registratie", //ES_title_s6_myd
	"Stap 1: Configureer uw Internet-aansluiting", //ES_wwa_title_s1
	"Ongeldige DHCP Client-naam", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Ongeldig DHCP+ wachtwoord", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Ongeldig DHCP+ gebruikersnaam", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Er MOET een L2TP-gebruikersnaam gespecificeerd worden", //GW_WAN_L2TP_USERNAME_INVALID
	"Er MOET een PPTP-wachtwoord gespecificeerd worden", //GW_WAN_PPTP_PASSWORD_INVALID
	"Ongeldige netwerkcode!", //IPV6_TEXT2
	"Ongeldig MAC-adres", //KR3
	"Auto (WPA of WPA2) - persoonlijk", //KR48
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
	"Als u uw product registreert bij mydlink kunt u de mydlink-geactiveerde functies gebruiken, inclusief online toegang en beheer van uw toestel via de mydlink website.", //mydlink_tx01
	"Wilt u uw toestel registreren bij mydlink?", //mydlink_tx02
	"Voer een gebruikersnaam in", //PPP_USERNAME_EMPTY
	"PPPoE Plus ondersteund", //pppoe_plus_dail
	"Wachtwoord kan alleen afdrukbare tekens bevatten.", //S493
	"BEZIG MET OPSLAAN INSTELLINGEN", //save_settings
	"Uw instellingen worden opgeslagen.", //save_wait
	"Firmware-versie", //sd_FWV
	"Productpagina", //TA2
	"Hardware-versie", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (US/Canada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (US/Canada)", //up_tz_06
	"(GMT-06:00) Centraal-Amerika", //up_tz_07
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
	"(GMT-03:00) Brazilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Greenland", //up_tz_20
	"(GMT-02:00) Mid-Atlantic", //up_tz_21
	"(GMT-01:00) Azores", //up_tz_22
	"(GMT-01:00) Cape Verde Is.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich Time: Dublin, Edinburgh, Lisbon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm", //up_tz_26
	"(GMT+01:00) Belgrade, Brastislava, Ljubljana", //up_tz_27
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
	"(GMT+03:00) Tehran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
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
	"DNS-instellingen", //wwa_dnsset
	"Gateway-adres", //wwa_gw
	"Als standaard heeft uw nieuwe D-Link Router geen wachtwoord geconfigureerd voor beheerderstoegang tot de webgebaseerde configuratiepagina's. Om uw nieuwe netwerkapparaat te beveiligen dient u onderstaand een wachtwoord in te stellen en te bevestigen. Door het activeren van CAPTCHA grafische verificatie krijgt u extra beveiliging om te verhinderen dat onbevoegde online gebruikers en hackersoftware toegang krijgen tot uw netwerkinstellingen.", //wwa_intro_s1
	"Selecteer de gepaste tijdzone voor uw lokatie. Deze informatie is vereist om de tijdgebaseerde opties voor de router te configureren.", //wwa_intro_s2
	"Selecteer onderstaand uw Internetverbindingstype:", //wwa_intro_s3
	"Deze wizard begeleidt u doorheen een stap-voor-stap proces om uw nieuwe D-Link router te configureren en een verbinding te maken met het Internet.", //wwa_intro_wel
	"L2TP Server IP-adres (mogelijk hetzelfde als gateway)", //wwa_l2tp_svra
	"Kies dit indien uw Internetaansluiting u automatisch voorziet van een IP-adres. De meeste kabelmodems gebruiken dit soort aansluiting.", //wwa_msg_dhcp
	"Indien uw Internet Service Provider niet vermeld werd of u niet weet wie het is, dient u onderstaand het Internet verbindingstype te selecteren:", //wwa_msg_ispnot
	"Kies deze optie als uw Internetverbinding een gebruikersnaam en wachtwoord vereist om online te gaan. De meeste DSL-modems gebruiken dit soort aansluiting.", //wwa_msg_pppoe
	"PPTP client.", //wwa_msg_pptp
	"om deze aansluiting in te stellen dient u ervoor te zorgen dat u aangesloten bent op de D-Link router met de pc die oorspronkelijk aangesloten was op uw breedbandaansluiting. Indien dit zo is, dient u te klikken op de Clone MAC-knop om het MAC-adres van uw computer te kopiëren naar de D-Link Router.", //wwa_msg_set_dhcp
	"Om deze verbinding in te stellen moet u een Gebruikersnaam en Wachtwoord hebben van uw Internet Service Provider. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_msg_set_pppoe
	"Om deze verbinding in te stellen moet u een Gebruikersnaam en Wachtwoord hebben van uw Internet Service Provider. U hebt ook een PPTP IP-adres nodig. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_msg_set_pptp
	"Kies deze optie indien uw Internet Setup Provider u voorzien heeft van IP-adresinformatie die handmatig geconfigureerd moet worden.", //wwa_msg_sipa
	"Opmerking: Mogelijk moet u ook een hostnaam opgeven. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_note_hostname
	"Primair DNS-adres", //wwa_pdns
	"PPTP Server IP-adres (mogelijk hetzelfde als gateway)", //wwa_pptp_svraddr
	"Secundair DNS-adres", //wwa_sdns
	"Niet vermeld of Weet niet", //wwa_selectisp_not
	"Gebruikersnaam en wachtwoord verbinding (L2TP) instellen", //wwa_set_l2tp_title
	"Om deze verbinding in te stellen moet u een volledige lijst met IP-informatie hebben van uw Internet Service Provider. Neem contact op met uw ISP indien u een Statische IP-verbinding hebt en deze informatie niet heeft.", //wwa_set_sipa_msg
	"Statische IP-adresverbinding instellen", //wwa_set_sipa_title
	"BigPond Cable-verbinding instellen", //wwa_title_set_bigpond
	"Gebruikersnaam en wachtwoord verbinding (PPP0E) instellen", //wwa_title_set_pppoe
	"Gebruikersnaam en wachtwoord verbinding (PPTP) instellen", //wwa_title_set_pptp
	"Welkom bij de D-Link installatiewizard", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Gebruikersnaam/wachtwoord aansluiting (L2TP)", //wwa_wanmode_l2tp
	"Gebruikersnaam/wachtwoord aansluiting (PPPoE)", //wwa_wanmode_pppoe
	"Gebruikersnaam/wachtwoord aansluiting (PPTP)", //wwa_wanmode_pptp
	"Verbinding via statisch IP-adres", //wwa_wanmode_sipa
	"Geef uw Wi-Fi netwerk een naam.", //wwz_wwl_intro_s2_1
	"Naam van het Wi-Fi-netwerk (SSID)", //wwz_wwl_intro_s2_1_1
	"(Maximaal 32 tekens gebruiken)", //wwz_wwl_intro_s2_1_2
	"Geef uw Wi-Fi netwerk een wachtwoord.", //wwz_wwl_intro_s2_2
	"Wi-Fi wachtwoord", //wwz_wwl_intro_s2_2_1
	"(tussen de 8 en 63 tekens)", //wwz_wwl_intro_s2_2_2
	"Geef uw netwerk een naam, gebruik maximaal 32 tekens.", //wwz_wwl_intro_s3_1
	"Stap 1: Welkom bij de D-LINK DRAADLOZE BEVEILIGING INSTALLATIEWIZARD", //wwz_wwl_title_s3
	"Ongeldig IP-adres PPTP-server", //YM108
	"Gebruik hetzelfde draadloze beveiligingswachtwoord, zowel op 2.4GHz als 5GHz band", //wwl_SSP
	"Geef uw Wi-Fi netwerk een naam en een wachtwoord.", //wwz_wwl_intro_s0
	"Het 1e adres van %s moet een geheel getal zijn.", //MSG002
	"Het 2e adres van %s moet een geheel getal zijn.", //MSG003
	"Het 3e adres van %s moet een geheel getal zijn.", //MSG004
	"Het 4e adres van %s moet een geheel getal zijn.", //MSG005
	"De %s is een ongeldig adres.", //MSG006
	"De %s kan niet nul zijn.", //MSG007
	"De ingevoerde %s poort is ongeldig.", //MSG008
	"De %s geheim ingevoerd is ongeldig", //MSG009
	"De %s kan geen invoer toestaan voor loopback IP of multicast IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Voer a.u.b. een andere %s waarde in.", //MSG012
	"De waarde van %s moet numeriek zijn!", //MSG013
	"Het bereik van %s is %1n ~ %2n.", //MSG014
	"De waarde van %s moet een even getal zijn.", //MSG015
	"De Code is ongeldig. De Code moet 5 tekens of 10 hexadecimale cijfers lang zijn. U hebt het volgende ingevoerd", //MSG016
	"De Code is ongeldig. De Code moet 13 tekens of 26 hexadecimale cijfers lang zijn. U hebt het volgende ingevoerd", //MSG017
	"Het 1e adres van %s moet hexadecimaal zijn.", //MSG018
	"Het 2e adres van %s moet hexadecimaal zijn.", //MSG019
	"Het 3e adres van %s moet hexadecimaal zijn.", //MSG020
	"Het 4e adres van %s moet hexadecimaal zijn.", //MSG021
	"Het 5e adres van %s moet hexadecimaal zijn.", //MSG022
	"Het 6e adres van %s moet hexadecimaal zijn.", //MSG023
	"Het 7e adres van %s moet hexadecimaal zijn.", //MSG024
	"Het 8e adres van %s moet hexadecimaal zijn.", //MSG025
	"Het 1e bereik van %s moet liggen tussen ", //MSG026
	"Het 2e bereik van %s moet liggen tussen ", //MSG027
	"Het 3e bereik van %s moet liggen tussen ", //MSG028
	"Het 4e bereik van %s moet liggen tussen ", //MSG029
	"Het 5e bereik van %s moet liggen tussen ", //MSG030
	"Het 6e bereik van %s moet liggen tussen ", //MSG031
	"Het 7e bereik van %s moet liggen tussen ", //MSG032
	"Het 8e bereik van %s moet liggen tussen ", //MSG033
	"De %s kan geen invoer toestaan voor loopback IP ( ::1 ).", //MSG034
	"De %s kan geen invoer toestaan voor multicast IP ( FFxx:0:0:0:0:0:0:2 of ffxx:0:0:0:0:0:0:2.", //MSG035
	"Ongeldig metrisch", //MSG043
	"Metrische waarde moet liggen tussen (1..16).", //ar_alert_3
	"Ongeldig netmasker.", //ar_alert_5
	"De Code", //TEXT042_1
	" is verkeerd, de toegestane tekens zijn 0~9, A~F of a~f.", //TEXT042_2
	"Opmerking: Mogelijk moet u ook een servicenaam opgeven. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_note_svcn
	"L2TP client.", //wwa_msg_l2tp
	"Om deze verbinding in te stellen moet u een Gebruikersnaam en Wachtwoord hebben van uw Internet Service Provider. U heeft ook een L2TP IP-adres nodig. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_set_l2tp_msg
	"Om deze verbinding in te stellen moet u een Gebruikersnaam en Wachtwoord hebben van uw Internet Service Provider. U heeft ook een BigPond Server IP-adres nodig. Neem contact op met uw ISP als u deze informatie niet heeft.", //wwa_msg_set_bigpond
	"Hostnaam", //_hostname
	"2,4GHz Band", //GW_WLAN_RADIO_0_NAME
	"5GHz Band", //GW_WLAN_RADIO_1_NAME
	"Onderstaand vindt u een gedetailleerde samenvatting van uw Wi-Fi beveiligingsinstellingen. Druk deze pagina af, of noteer de informatie op een stuk papier, zodat u de correcte instellingen op uw Wi-Fi toestellen kunt configureren.", //wwl_intro_end
	"Even geduld …", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Verbinden", //_connect
	"Begeleid me doorheen de internet verbindingsinstellingen", //ES_btn_guide_me
	"Grafische verificatie inschakelen", //_graph_auth
	"D-LINK CORPORATION, INC | DRAADLOZE ROUTER | HOME", //TEXT000
	"Er MOET een L2TP-wachtwoord gespecificeerd worden", //GW_WAN_L2TP_PASSWORD_INVALID
	"Geen internet gedetecteerd, wilt u de wizard opnieuw opstarten?", //mydlink_tx03
	"Het wachtwoord van de beheerder kan niet leeg zijn.", //mydlink_tx04
	"Bezig met controleren van de WAN-aansluiting.", //mydlink_tx05
	"seconden resterend.", //sec_left
	"Opnieuw proberen", //_retry
	"Hebt u een mydlink account?", //mydlink_tx06
	"Ja, ik heb een mydlink account.", //mydlink_tx07
	"Nee, ik wil registreren en aanmelden met een nieuwe mydlink account.", //mydlink_tx08
	"E-mail adres (accountnaam)", //mydlink_tx09
	"Vul de opties in om de registratie te voltooien.", //mydlink_tx10
	"Bevestig wachtwoord", //chk_pass
	"Achternaam", //Lname
	"Voornaam", //Fname
	"Ik aanvaard de mydlink algemene voorwaarden.", //mydlink_tx12
	"Controleer uw Postvak IN voor een e-mail met bevestigingsintructies om uw mydlink-registratie te voltooien.", //mydlink_tx13_1
	" Klik op de Login-knop na bevestiging van uw e-mailadres.", //mydlink_tx13_2
	"Log-in", //_login
	"Ok", //_ok
	"Opslaan", //_save
	"Zorg dat de twee wachtwoorden hetzelfde zijn en probeer het opnieuw", //_pwsame
	"Om gebruik te maken van de functies van  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> en de mydlink Lite app, hebt u een account nodig met <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Indien u al een account hebt, selecteert u <strong>Ja, ik heb een mydlink account</strong> en klik op Volgende om de router te registreren bij <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Indien u geen account hebt, selecteert u <strong>Nee, ik wil registreren en aanmelden met een nieuwe mydlink account</strong> en klik op Volgende om een account te maken. ", //mydlink_reg_into_3
	" Klik op Annuleren indien u zich niet wenst in te schrijven voor de mydlink service.", //mydlink_reg_into_4_a
	"Dit e-mailadres heeft al een mydlink account. Probeer een ander e-mailadres.", //mydlink_pop_01
	"U dient de algemene voorwaarden te aanvaarden om verder te gaan.", //mydlink_pop_02
	"mag niet leeg zijn.", //mydlink_pop_03
	"is ongeldig.", //mydlink_pop_04
	"U mag nu mydlink service gebruiken met dit toestel", //mydlink_pop_05
	"Aanmelden mislukt", //mydlink_pop_06
	"aanmelden", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Nadat de mydlink registratie is voltooid, wordt de standaard PPPoE, L2TP, PPTP-aansluiting van uw router ingesteld op Altijd aan. Indien uw ISP kosten aanrekent voor gebruik, kunt u handmatig Bellen op verzoek kiezen als uw standaardinstelling.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"Er MOET een PPPoE-wachtwoord gespecificeerd worden", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Overslaan", //_skip
	"Indien u zich niet wenst in te schrijven voor de mydlink service, klikt u op Overslaan.", //mydlink_reg_into_4
	"Bezig met opslaan Wi-Fi instelling", //mydlink_WiFi_save
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
var wwa_dnsset=161;
var wwa_gw=162;
var wwa_intro_s1=163;
var wwa_intro_s2=164;
var wwa_intro_s3=165;
var wwa_intro_wel=166;
var wwa_l2tp_svra=167;
var wwa_msg_dhcp=168;
var wwa_msg_ispnot=169;
var wwa_msg_pppoe=170;
var wwa_msg_pptp=171;
var wwa_msg_set_dhcp=172;
var wwa_msg_set_pppoe=173;
var wwa_msg_set_pptp=174;
var wwa_msg_sipa=175;
var wwa_note_hostname=176;
var wwa_pdns=177;
var wwa_pptp_svraddr=178;
var wwa_sdns=179;
var wwa_selectisp_not=180;
var wwa_set_l2tp_title=181;
var wwa_set_sipa_msg=182;
var wwa_set_sipa_title=183;
var wwa_title_set_bigpond=184;
var wwa_title_set_pppoe=185;
var wwa_title_set_pptp=186;
var wwa_title_wel=187;
var wwa_wanmode_bigpond=188;
var wwa_wanmode_l2tp=189;
var wwa_wanmode_pppoe=190;
var wwa_wanmode_pptp=191;
var wwa_wanmode_sipa=192;
var wwz_wwl_intro_s2_1=193;
var wwz_wwl_intro_s2_1_1=194;
var wwz_wwl_intro_s2_1_2=195;
var wwz_wwl_intro_s2_2=196;
var wwz_wwl_intro_s2_2_1=197;
var wwz_wwl_intro_s2_2_2=198;
var wwz_wwl_intro_s3_1=199;
var wwz_wwl_title_s3=200;
var YM108=201;
var wwl_SSP=202;
var wwz_wwl_intro_s0=203;
var MSG002=204;
var MSG003=205;
var MSG004=206;
var MSG005=207;
var MSG006=208;
var MSG007=209;
var MSG008=210;
var MSG009=211;
var MSG010=212;
var MSG012=213;
var MSG013=214;
var MSG014=215;
var MSG015=216;
var MSG016=217;
var MSG017=218;
var MSG018=219;
var MSG019=220;
var MSG020=221;
var MSG021=222;
var MSG022=223;
var MSG023=224;
var MSG024=225;
var MSG025=226;
var MSG026=227;
var MSG027=228;
var MSG028=229;
var MSG029=230;
var MSG030=231;
var MSG031=232;
var MSG032=233;
var MSG033=234;
var MSG034=235;
var MSG035=236;
var MSG043=237;
var ar_alert_3=238;
var ar_alert_5=239;
var TEXT042_1=240;
var TEXT042_2=241;
var wwa_note_svcn=242;
var wwa_msg_l2tp=243;
var wwa_set_l2tp_msg=244;
var wwa_msg_set_bigpond=245;
var _hostname=246;
var GW_WLAN_RADIO_0_NAME=247;
var GW_WLAN_RADIO_1_NAME=248;
var wwl_intro_end=249;
var _please_wait=250;
var _copyright=251;
var _connect=252;
var ES_btn_guide_me=253;
var _graph_auth=254;
var TEXT000=255;
var GW_WAN_L2TP_PASSWORD_INVALID=256;
var mydlink_tx03=257;
var mydlink_tx04=258;
var mydlink_tx05=259;
var sec_left=260;
var _retry=261;
var mydlink_tx06=262;
var mydlink_tx07=263;
var mydlink_tx08=264;
var mydlink_tx09=265;
var mydlink_tx10=266;
var chk_pass=267;
var Lname=268;
var Fname=269;
var mydlink_tx12=270;
var mydlink_tx13_1=271;
var mydlink_tx13_2=272;
var _login=273;
var _ok=274;
var _save=275;
var _pwsame=276;
var mydlink_reg_into_1=277;
var mydlink_reg_into_2=278;
var mydlink_reg_into_3=279;
var mydlink_reg_into_4_a=280;
var mydlink_pop_01=281;
var mydlink_pop_02=282;
var mydlink_pop_03=283;
var mydlink_pop_04=284;
var mydlink_pop_05=285;
var mydlink_pop_06=286;
var _signup=287;
var up_tz_74=288;
var up_tz_75=289;
var mydlink_pop_09=290;
var mdl_errmsg_01=291;
var mdl_errmsg_02=292;
var mdl_errmsg_03=293;
var mdl_errmsg_04=294;
var mdl_errmsg_05=295;
var SSID_EMPTY_ERROR=296;
var YM102=297;
var GW_WAN_PPPoE_PASSWORD_INVALID=298;
var limit_pass_msg=299;
var _skip=300;
var mydlink_reg_into_4=301;
var mydlink_WiFi_save=302;
