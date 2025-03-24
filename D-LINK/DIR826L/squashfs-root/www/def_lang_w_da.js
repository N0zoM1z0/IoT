//Version=1.01b02
//Language=Danish
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Annullér", //_cancel
	"Kopiér din PC's MAC-adresse", //_clone
	"DHCP-forbindelse (dynamisk IP-adresse)", //_dhcpconn
	"IP-adresse", //_ipaddr
	"L2TP", //_L2TP
	"L2TP-gateway'ens IP-adresse", //_L2TPgw
	"L2TP IP-adresse", //_L2TPip
	"L2TP-subnetmaske", //_L2TPsubnet
	"Sprog", //_Language
	"MAC-adresse", //_macaddr
	"Næste", //_next
	"Nej", //_no
	"(valgfrit)", //_optional
	"Kodeord", //_password
	"PPTP-gateway'ens IP-adresse", //_PPTPgw
	"PPTP IP-adresse", //_PPTPip
	"PPTP-subnetmaske", //_PPTPsubnet
	"Foregående", //_prev
	"De to admin-kodeord skal være ens; prøv igen", //_pwsame_admin
	"Statisk IP", //_sdi_staticip
	"Subnetmaske", //_subnet
	"Brugernavn", //_username
	"Bekræft kodeord", //_verifypw
	"Vil du forlade alle ændringer, du foretog i denne guide?", //_wizquit
	"Ja", //_yes
	"L2TP-servers IP-adresse er ugyldig", //bwn_alert_17
	"Adresse-modus", //bwn_AM
	"BigPond-server", //bwn_BPS
	"TKIP og AES", //bws_CT_3
	"Dynamisk IP", //carriertype_ct_0
	"Routeren søger efter din internet-forbindelsestype, vent et øjeblik…", //ES_auto_detect_desc
	"Routerne kan ikke detektere din internet-forbindelsestype.", //ES_auto_detect_failed_desc
	"Vil du gøre \"D-Link router-styring via nettet\" til et bogmærke? \"D-Link Router Web Management\"", //ES_bookmark
	"Prøv igen", //ES_btn_try_again
	"Stik den ene ende af det vedlagte ethernet-kabel, der fulgte med routeren, i den port, der er mærket INTERNET, på bagsiden af routeren. Stik den anden ende af dette kabel i ethernet-porten på modemet.", //ES_cable_lost_desc
	"Trin 2: Konfigurér din Wi-Fi-sikkerhed", //ES_step_wifi_security
	"Trin 3: Opret dit kodeord", //ES_title_s3
	"Trin 4: Vælg din tidszone", //ES_title_s4
	"Trin 5: Gem indstillingerne", //ES_title_s5
	"Trin 5: Bekræft Wi-Fi-indstillingerne", //ES_title_s5_0
	"Trin 6: mydlink-registrering", //ES_title_s6
	"mydlink-registrering", //ES_title_s6_myd
	"Trin 1: Konfigurér din internetforbindelse", //ES_wwa_title_s1
	"Ugyldigt DHCP-klientnavn", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Ugyldigt DHCP+-kodeord", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Ugyldigt DHCP+-brugernavn", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Et L2TP-brugernavn SKAL specificeres", //GW_WAN_L2TP_USERNAME_INVALID
	"Et PPTP-kodeord SKAL specificeres", //GW_WAN_PPTP_PASSWORD_INVALID
	"Ugyldig netværksnøgle!", //IPV6_TEXT2
	"Ugyldig MAC-adresse", //KR3
	"Auto (WPA eller WPA2) - personlig", //KR48
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
	"Ved at registrere dit produkt hos mydlink får du adgang til at anvende dets mydlink-aktiverede funktioner, herunder online-adgang og styring af enheden via mydlink-websiden.", //mydlink_tx01
	"Vil du registrere din enhed hos mydlink?", //mydlink_tx02
	"Indtast brugernavn", //PPP_USERNAME_EMPTY
	"PPPoE Plus er understøttet", //pppoe_plus_dail
	"Kodeordet må kun indeholde tegn, som kan printes.", //S493
	"GEMMER INDSTILLINGER", //save_settings
	"Dine indstillinger gemmes.", //save_wait
	"Firmware-version", //sd_FWV
	"Produktside", //TA2
	"Hardware-version", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway-øen, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Amerikansk vestkysttid (USA, Canada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) West Virginia-tid (USA, Canada)", //up_tz_06
	"(GMT-06:00) Centralamerika", //up_tz_07
	"(GMT-06:00) Midtamerikansk tid (USA, Canada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Østkysttid (USA, Canada)", //up_tz_12
	"(GMT-05:00) Indiana (øst)", //up_tz_13
	"(GMT-04:00) Canadisk østkysttid (Canada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grønland", //up_tz_20
	"(GMT-02:00) Midtatlantisk tid", //up_tz_21
	"(GMT-01:00) Azorerne", //up_tz_22
	"(GMT-01:00) Kap Verde-øerne", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich-tid: Dublin, Edinburgh, Lissabon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rom, Stockholm", //up_tz_26
	"(GMT+01:00) Beograd, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Bruxelles, København, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofia, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Wien, Prag, Warszawa", //up_tz_29b
	"(GMT+01:00) Vest-Centralafrika", //up_tz_30
	"(GMT+02:00) Athen, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukarest", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsingfors, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riadh", //up_tz_38
	"(GMT+03:00) Moskva, St. Petersborg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Jerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapore", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"(GMT+09:00) Seoul", //up_tz_61
	"(GMT+10:00) Jakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Solomon-øerne, Ny Caledonien", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall-øerne", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"DNS-indstillinger", //wwa_dnsset
	"Gateway-adresse", //wwa_gw
	"Som standard har din nye D-Link-router ikke et kodeord konfigureret for administratoradgang til de web-baserede konfigurationssider. For at sikre din netværksenhed skal du oprette og verificere et kodeord herunder, og aktivering af CAPTCHA-grafisk autentifikation yder ekstra sikkerhedsbeskyttelse til at hindre uautoriserede online-brugere og hacker-software i adgang til dine netværksindstillinger.", //wwa_intro_s1
	"Vælg den korrekte tidszone for dig. Disse oplysninger er nødvendige for at konfigurere de tidsbaserede valgmuligheder for routeren.", //wwa_intro_s2
	"Vælg din internet-forbindelsestype herunder:", //wwa_intro_s3
	"Denne guide vil føre dig gennem en trin-for-trin konfigurering af din nye D-Link-router og forbindelse til internettet.", //wwa_intro_wel
	"L2TP-servers IP-adresse (kan være den samme som gateway'ens)", //wwa_l2tp_svra
	"Vælg denne, hvis din internetforbindelse automatisk tildeler dig en IP-adresse. De fleste kabel-modemer anvender denne forbindelsestype.", //wwa_msg_dhcp
	"Hvis din internetudbyder ikke er på listen, eller du ikke ved, hvem det er, vælges internet-forbindelsestype herunder:", //wwa_msg_ispnot
	"Vælg denne mulighed, hvis din internetforbindelse kræver et brugernavn og kodeord for at komme online. De fleste DSL-modemer anvender denne forbindelsestype.", //wwa_msg_pppoe
	"PPTP-klient.", //wwa_msg_pptp
	"Kontrollér ved indstillingen af denne forbindelse, at du er tilsluttet til D-Link-routeren med den PC, der oprindeligt var tilsluttet din bredbåndsforbindelse. Hvis du er, klikkes på knappen Clone MAC [Klon MAC-adresse] for at kopiere din computer's MAC-adresse til D-Link-routeren.", //wwa_msg_set_dhcp
	"For at indstille denne forbindelse skal du have et brugernavn og et kodeord fra din internetudbyder. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_msg_set_pppoe
	"For at indstille denne forbindelse skal du have et brugernavn og et kodeord fra din internetudbyder. Du skal også bruge en PPTP IP-adresse. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_msg_set_pptp
	"Vælg denne mulighed, hvis din internetudbyder leverede IP-adresseoplysninger, der skal konfigureres manuelt.", //wwa_msg_sipa
	"Bemærk: Du får måske også brug for at levere et værtsnavn. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_note_hostname
	"Primær DNS-adresse", //wwa_pdns
	"PPTP-servers IP-adresse (kan være den samme som gateway'ens)", //wwa_pptp_svraddr
	"Sekundær DNS-adresse", //wwa_sdns
	"Ikke angivet eller kendes ikke", //wwa_selectisp_not
	"Indstil forbindelse med brugernavn og kodeord (L2TP)", //wwa_set_l2tp_title
	"For at indstille denne forbindelse skal du have en komplet liste med IP-oplysninger fra din internetudbyder. Hvis du har en statisk IP-forbindelse og ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_set_sipa_msg
	"Indstil forbindelse med statisk IP-adresse", //wwa_set_sipa_title
	"Indstil BigPond-kabelforbindelse", //wwa_title_set_bigpond
	"Indstil forbindelse med brugernavn og kodeord (PPPoE)", //wwa_title_set_pppoe
	"Indstil forbindelse med brugernavn og kodeord (PPTP)", //wwa_title_set_pptp
	"Velkommen til D-Link's Indstillingsguide", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Forbindelse med brugernavn/kodeord (L2TP)", //wwa_wanmode_l2tp
	"Forbindelse med brugernavn/kodeord (PPPoE)", //wwa_wanmode_pppoe
	"Forbindelse med brugernavn/kodeord (PPTP)", //wwa_wanmode_pptp
	"Forbindelse med statisk IP-adresse", //wwa_wanmode_sipa
	"Giv dit Wi-Fi-netværk et navn.", //wwz_wwl_intro_s2_1
	"Wi-Fi-netværks navn (SSID, Service Set IDentification)", //wwz_wwl_intro_s2_1_1
	"(op til 32 tegn)", //wwz_wwl_intro_s2_1_2
	"Giv dit Wi-Fi-netværk et kodeord.", //wwz_wwl_intro_s2_2
	"Wi-Fi-kodeord", //wwz_wwl_intro_s2_2_1
	"(mellem 8 og 63 tegn)", //wwz_wwl_intro_s2_2_2
	"Giv dit netværk et navn på op til 32 tegn.", //wwz_wwl_intro_s3_1
	"Trin 1: Velkommen TIL D-LINK’s TRÅDLØSE SIKKERHEDS-INDSTILLINGSGUIDE", //wwz_wwl_title_s3
	"PPTP-servers IP-adresse er ugyldig", //YM108
	"Anvend samme trådløse sikkerhedskodeord på både 2,4 GHz- og 5 GHz-båndet", //wwl_SSP
	"Giv dit Wi-Fi-netværk et navn og et kodeord.", //wwz_wwl_intro_s0
	"Den første adresse for %s skal være et heltal.", //MSG002
	"Den anden adresse for %s skal være et heltal.", //MSG003
	"Den tredje adresse for %s skal være et heltal.", //MSG004
	"Den fjerde adresse for %s skal være et heltal.", //MSG005
	"%s er en ugyldig adresse.", //MSG006
	"%s må ikke være nul.", //MSG007
	"Den indtastede %s-port er ugyldig.", //MSG008
	"Det indtastede %s kodeord er ugyldigt.-", //MSG009
	"%s må ikke tillade indtastningen at tilbagesløjfe IP eller multicaste IP (127.x.x.x, 224.x.x.x - 239.x.x.x).", //MSG010
	"Indtast en anden værdi for %s.", //MSG012
	"Værdien for %s skal bestå af tal!", //MSG013
	"Intervallet for %s er %1n - %2n.", //MSG014
	"Værdien for %s skal være et lige tal.", //MSG015
	"Nøglen er ugyldig. Nøglen skal være et tal på 5 eller 10 hexadecimale cifre. Du indtastede", //MSG016
	"Nøglen er ugyldig. Nøglen skal være et tal på 13 eller 26 hexadecimale cifre. Du indtastede", //MSG017
	"Den første adresse for %s skal være hexadecimal.", //MSG018
	"Den anden adresse for %s skal være hexadecimal.", //MSG019
	"Den tredje adresse for %s skal være hexadecimal.", //MSG020
	"Den fjerde adresse for %s skal være hexadecimal.", //MSG021
	"Den femte adresse for %s skal være hexadecimal.", //MSG022
	"Den sjette adresse for %s skal være hexadecimal.", //MSG023
	"Den syvende adresse for %s skal være hexadecimal.", //MSG024
	"Den ottende adresse for %s skal være hexadecimal.", //MSG025
	"Det første interval for %s skal være mellem", //MSG026
	"Det andet interval for %s skal være mellem", //MSG027
	"Det tredje interval for %s skal være mellem", //MSG028
	"Det fjerde interval for %s skal være mellem", //MSG029
	"Det femte interval for %s skal være mellem", //MSG030
	"Det sjette interval for %s skal være mellem", //MSG031
	"Det syvende interval for %s skal være mellem", //MSG032
	"Det ottende interval for %s skal være mellem", //MSG033
	"%s må ikke tillade indtastningen af tilbagesløjfe IP ( ::1 ).", //MSG034
	"%s må ikke tillade indtastningen at multicaste IP (FFxx:0:0:0:0:0:0:2 eller ffxx:0:0:0:0:0:0:2).", //MSG035
	"Ugyldig metrik", //MSG043
	"Metrik-værdien skal være i intervallet (1 … 16).", //ar_alert_3
	"Ugyldig netmaske.", //ar_alert_5
	"Nøglen", //TEXT042_1
	" er forkert, de tilladte tegn er 0-9, A-F eller a-f.", //TEXT042_2
	"Bemærk: Du får måske også brug for at levere et service-navn. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_note_svcn
	"L2TP-klient.", //wwa_msg_l2tp
	"For at indstille denne forbindelse skal du have et brugernavn og et kodeord fra din internetudbyder. Du skal også bruge en L2TP IP-adresse. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_set_l2tp_msg
	"For at indstille denne forbindelse skal du have et brugernavn og et kodeord fra din internetudbyder. Du skal også bruge en BigPond-server IP-adresse. Hvis du ikke har disse oplysninger, skal du kontakte din internetudbyder.", //wwa_msg_set_bigpond
	"Værtsnavn", //_hostname
	"2,4 GHz-bånd", //GW_WLAN_RADIO_0_NAME
	"5 GHz-bånd", //GW_WLAN_RADIO_1_NAME
	"Herunder er et detaljeret resumé af dine Wi-Fi-sikkerhedsindstillinger. Udskriv denne side, eller skriv oplysningerne på et stykke papir, så at du kan konfigurere de korrekte indstillinger på dine Wi-Fi-enheder.", //wwl_intro_end
	"Vent venligst...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Tilslut", //_connect
	"Før mig gennem indstillingerne for internet-tilslutningen", //ES_btn_guide_me
	"Aktivér grafisk autentifikation", //_graph_auth
	"D-LINK CORPORATION, INC | TRÅDLØS ROUTER | HJEM", //TEXT000
	"Et L2TP-kodeord SKAL specificeres", //GW_WAN_L2TP_PASSWORD_INVALID
	"Intet internet er fundet, vil du genstarte indstillingsguiden?", //mydlink_tx03
	"Administrator-kodeordet må ikke være tomt.", //mydlink_tx04
	"Kontrollerer WAN-tilslutningen.", //mydlink_tx05
	"sekunder tilbage.", //sec_left
	"Gentag", //_retry
	"Har du en mydlink-konto?", //mydlink_tx06
	"Ja, jeg har en mydlink-konto.", //mydlink_tx07
	"Nej, jeg vil registrere mig og logge ind med en ny mydlink-konto.", //mydlink_tx08
	"E-mail-adresse (kontonavn)", //mydlink_tx09
	"Udfyld valgmulighederne for at afslutte registreringen.", //mydlink_tx10
	"Bekræft kodeord", //chk_pass
	"Efternavn", //Lname
	"Fornavn", //Fname
	"Jeg accepterer mydlink's vilkår og betingelser.", //mydlink_tx12
	"For at afslutte mydlink-registreringen finder du en i indbakken en e-mail med bekræftelse og de sidste vejledninger.", //mydlink_tx13_1
	" Når du har bekræftet din e-mail-adresse, klikkes på login-knappen.", //mydlink_tx13_2
	"Login", //_login
	"OK", //_ok
	"Gem", //_save
	"De to kodeord skal være ens; prøv igen", //_pwsame
	"For at anvende funktionerne i <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> mydlink Lite-applikationen skal du oprette en konto hos <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Hvis du allerede har en konto, vælges <strong>Yes, I have a mydlink account</strong> og klikkes på Next for at registrere routeren hos <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Hvis du ikke har en konto, vælges <strong>No, I want to register and login with a new mydlink account</strong> og klikkes på Next for at oprette en konto. ", //mydlink_reg_into_3
	" Hvis du ikke vil tilmelde dig mydlink-tjenesten, klikkes på Cancel.", //mydlink_reg_into_4_a
	"Denne e-mail-adresse har allerede en mydlink-konto. Prøv en anden e-mail-adresse.", //mydlink_pop_01
	"Du skal acceptere vilkår og betingelser for at fortsærtte.", //mydlink_pop_02
	"må ikke være tomt.", //mydlink_pop_03
	"er ugyldig.", //mydlink_pop_04
	"Du kan nu anvende mydlink-tjenesten til denne enhed", //mydlink_pop_05
	"Login mislykkedes", //mydlink_pop_06
	"Registrer", //_signup
	"(GMT+07:00) Almati", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Efter at mydlink-registreringen er fuldført, sættes routerens standard PPPoE-, L2TP-, PPTP-forbindelse til Altid tilsluttet. Hvis din internet-udbyder betales i forhold til brugen, kan du vælge Dial On Demand [Opkald efter behov] som standardindstilling.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"Et PPPoE-kodeord SKAL specificeres", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Spring over", //_skip
	"Hvis du ikke vil tilmelde dig mydlink-servicen, klikker du på spring over.", //mydlink_reg_into_4
	"Gemmer Wi-Fi-indstillingen", //mydlink_WiFi_save
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
