//Version=1.01b02
//Language=Swedish
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Avbryt", //_cancel
	"Kopiera din dators MAC-adress", //_clone
	"DHCP-anslutning (dynamisk IP-adress)", //_dhcpconn
	"IP-adress", //_ipaddr
	"L2TP", //_L2TP
	"IP-adress för L2TP-gateway", //_L2TPgw
	"IP-adress för L2TP", //_L2TPip
	"Delnätmask för L2TP", //_L2TPsubnet
	"Språk", //_Language
	"MAC-adress", //_macaddr
	"Nästa", //_next
	"Nej", //_no
	"(valfritt)", //_optional
	"Lösenord", //_password
	"IP-adress för PPTP-gateway", //_PPTPgw
	"IP-adress för PPTP", //_PPTPip
	"Delnätmask för PPTP", //_PPTPsubnet
	"Föreg.", //_prev
	"Ändra de två administratörslösenorden så att de är lika och försök igen", //_pwsame_admin
	"Statisk IP", //_sdi_staticip
	"Delnätmask", //_subnet
	"Användarnamn", //_username
	"Bekräfta lösenord", //_verifypw
	"Vill du överge ändringarna du gjort med guiden?", //_wizquit
	"Ja", //_yes
	"Ogiltig IP-adress för L2TP-server", //bwn_alert_17
	"Adressläge", //bwn_AM
	"BigPond-server", //bwn_BPS
	"TKIP och AES", //bws_CT_3
	"Dynamisk IP", //carriertype_ct_0
	"Routrar identifierar din typ av Internet-anslutning, vänta…", //ES_auto_detect_desc
	"Routrarna kan inte identifiera din typ av Internet-anslutning.", //ES_auto_detect_failed_desc
	"Vill du lägga till \"D-Link Router Web Management\" som bokmärke?", //ES_bookmark
	"Försök igen", //ES_btn_try_again
	"Anslut den ena änden av Ethernet-kabeln som levererades med routern till porten märkt INTERNET på routerns baksida. Anslut den andra änden av kabeln till en Ethernet-port på modemet.", //ES_cable_lost_desc
	"Steg 2: Konfigurera din Wi-Fi-säkerhet", //ES_step_wifi_security
	"Steg 3: Ställ in ditt lösenord", //ES_title_s3
	"Steg 4: Välj tidszon", //ES_title_s4
	"Steg 5: Spara inställningarna", //ES_title_s5
	"Steg 5: Bekräfta Wi-Fi-inställningarna", //ES_title_s5_0
	"Steg 6: mydlink-registrering", //ES_title_s6
	"mydlink-registrering", //ES_title_s6_myd
	"Steg 1: Konfigurera din Internet-anslutning", //ES_wwa_title_s1
	"Ogiltigt DHCP-klientnamn", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Ogiltigt DHCP+-lösenord", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Ogiltigt DHCP+-användarnamn", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Ett L2TP-användarnamn MÅSTE anges", //GW_WAN_L2TP_USERNAME_INVALID
	"Ett PPTP-lösenord MÅSTE anges", //GW_WAN_PPTP_PASSWORD_INVALID
	"Ogiltig nätverksnyckel!", //IPV6_TEXT2
	"Ogiltig MAC-adress", //KR3
	"Auto (WPA eller WPA2) - Personlig", //KR48
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"ATAT DSL-tjänst", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Earthlink kabel", //manul_conn_10
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
	"Registrering av din produkt med mydlink ger dig tillgång till dess mydlink-aktiverade funktioner, inklusive onlineåtkomst och hantering av din enhet via mydlink-webbplatsen.", //mydlink_tx01
	"Vill du registrera din enhet med mydlink?", //mydlink_tx02
	"Ange ett användarnamn", //PPP_USERNAME_EMPTY
	"Stöds av PPPoE Plus", //pppoe_plus_dail
	"Lösenord får endast innehålla utskrivbara tecken.", //S493
	"SPARAR INSTÄLLNINGAR", //save_settings
	"Dina inställningar sparas.", //save_wait
	"Firmware-version", //sd_FWV
	"Produktsida", //TA2
	"Hårdvaruversion", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (USA/Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (USA/Kanada)", //up_tz_06
	"(GMT-06:00) Centralamerika", //up_tz_07
	"(GMT-06:00) Central Time (USA/Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (USA/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (östra)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilien", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grönland", //up_tz_20
	"(GMT-02:00) Mid-Atlantic", //up_tz_21
	"(GMT-01:00) Azorerna", //up_tz_22
	"(GMT-01:00) Cape Verde", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich Time: Dublin, Edinburgh, Lissabon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rom, Stockholm", //up_tz_26
	"(GMT+01:00) Belgrad, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Bryssel, Köpenhamn, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Wien, Prag, Warszawa", //up_tz_29b
	"(GMT+01:00) West Central Africa", //up_tz_30
	"(GMT+02:00) Aten, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukarest", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsingfors, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moskva, St. Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tasjkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Bombay, New Delhi", //up_tz_47
	"(GMT+05:45) Katmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Almaty, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Peking, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulan Bator", //up_tz_56
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
	"(GMT+11:00) Salomonöarna, Nya Kaledonien", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamtjatka, Marshallöarna", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"DNS-inställningar", //wwa_dnsset
	"Gateway-adress", //wwa_gw
	"Som standard har din D-Link-router inte något konfigurerat lösenord för administratörsåtkomst till de webbaserade konfigurationssidorna. För att säkra din nya nätverksenhet bör du ställa in och bekräfta ett lösenord nedan. Genom att även aktivera den grafiska CAPTCHA-autentiseringen utökar du säkerheten och förhindrar att obehöriga användare på nätet och hacker-programvara kommer åt dina nätverksinställningar.", //wwa_intro_s1
	"Välj din tidszon. Den här informationen krävs för att konfigurera tidsbaserade alternativ för routern.", //wwa_intro_s2
	"Välj din typ av Internet-anslutning nedan:", //wwa_intro_s3
	"Guiden tar dig igenom en steg-för-steg-process för att konfigurera din nya D-Link-router och ansluta till Internet.", //wwa_intro_wel
	"IP-adress för L2TP-server (kan vara samma som gateway)", //wwa_l2tp_svra
	"Välj detta alternativ om din Internet-anslutning automatiskt ger dig en IP-adress. De flesta kabelmodem använder den här typen av anslutning.", //wwa_msg_dhcp
	"Om din Internet-leverantör inte finns med i listen eller du inte vet vem det är så väljer du typ av Internet-anslutning nedan:", //wwa_msg_ispnot
	"Välj detta alternativ om din Internet-anslutning kräver ett användarnamn och lösenord för att gå online. De flesta DSL-modem använder den här typen av anslutning.", //wwa_msg_pppoe
	"PPTP-klient.", //wwa_msg_pptp
	"För att ställa in den här anslutningen måste du kontrollera att du är ansluten till D-Link-routern med den dator som ursprungligen var ansluten till din bredbandsanslutning. Om så är fallet, klicka på knappen Klona MAC för att kopiera datorns MAC-adress till D-Link-routern.", //wwa_msg_set_dhcp
	"För att ställa in den här anslutningen behöver du användarnamnet och lösenordet från din Internet-leverantör. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_msg_set_pppoe
	"För att ställa in den här anslutningen behöver du användarnamnet och lösenordet från din Internet-leverantör. Du behöver även IP-adressen för PPTP. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_msg_set_pptp
	"Välj detta alternativ om din Internet-leverantör har gett dig information om IP-adressen som måste konfigureras manuellt.", //wwa_msg_sipa
	"Obs! Du kanske även måste ange ett värdnamn. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_note_hostname
	"Primär DNS-adress", //wwa_pdns
	"IP-adress för PPTP-server (kan vara samma som gateway)", //wwa_pptp_svraddr
	"Sekundär DNS-adress", //wwa_sdns
	"Finns inte i listan eller känner inte till", //wwa_selectisp_not
	"Ställ in användarnamn och lösenord för anslutningen (L2TP)", //wwa_set_l2tp_title
	"För att ställa in den här anslutningen behöver du den kompletta IP-informationen från din Internet-leverantör. Kontakta din Internet-leverantör om du har en statisk IP-anslutning och inte har denna information.", //wwa_set_sipa_msg
	"Ställ in en anslutning för statisk IP-adress", //wwa_set_sipa_title
	"Ställ in en kabelanslutning för BigPond", //wwa_title_set_bigpond
	"Ställ in en anslutning med användarnamn och lösenord (PPPoE)", //wwa_title_set_pppoe
	"Ställ in en anslutning med användarnamn och lösenord (PPTP)", //wwa_title_set_pptp
	"Välkommen till D-links installationsguide", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Anslutning med användarnamn/lösenord (L2TP)", //wwa_wanmode_l2tp
	"Anslutning med användarnamn/lösenord (PPPoE)", //wwa_wanmode_pppoe
	"Anslutning med användarnamn/lösenord (PPTP)", //wwa_wanmode_pptp
	"Anslutning med statisk IP-adress", //wwa_wanmode_sipa
	"Skapa ett namn på Wi-Fi-nätverket.", //wwz_wwl_intro_s2_1
	"Namn på Wi-Fi-nätverket (SSID)", //wwz_wwl_intro_s2_1_1
	"(upp till 32 tecken)", //wwz_wwl_intro_s2_1_2
	"Skapa ett lösenord för Wi-Fi-nätverket.", //wwz_wwl_intro_s2_2
	"Wi-Fi-lösenord", //wwz_wwl_intro_s2_2_1
	"(mellan 8 och 63 tecken)", //wwz_wwl_intro_s2_2_2
	"Skapa ett nätverksnamn med upp till 32 tecken.", //wwz_wwl_intro_s3_1
	"Steg 1: Välkommen TILL D-LINKS INSTALLATIONSGUIDE FÖR TRÅDLÖS SÄKERHET", //wwz_wwl_title_s3
	"Ogiltig IP-adress för PPTP-server", //YM108
	"Använd samma säkerhetslösenord för trådlöst nätverk på både 2,4 GHz och 5 GHz-banden.", //wwl_SSP
	"Skapa ett namn och ett lösenord för Wi-Fi-nätverket.", //wwz_wwl_intro_s0
	"Den första adressen av %s måste vara ett heltal.", //MSG002
	"Den andra adressen av %s måste vara ett heltal.", //MSG003
	"Den tredje adressen av %s måste vara ett heltal.", //MSG004
	"Den fjärde adressen av %s måste vara ett heltal.", //MSG005
	"%s är en ogiltig adress.", //MSG006
	"%s får inte vara noll.", //MSG007
	"Den angivna %s-porten är ogiltig.", //MSG008
	"Den angivna %s-hemligheten är ogiltig.", //MSG009
	"%s tillåter inte IP-loopback eller IP-multicast (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Ange ett annat %s-värde.", //MSG012
	"%s-värdet måste vara numeriskt!", //MSG013
	"Området för %s är %1n ~ %2n.", //MSG014
	"%s-värdet måste vara ett jämnt tal!", //MSG015
	"Nyckeln är ogiltig. Nyckeln måste vara ett hexadecimalt tal bestående av 5 eller 10 tecken. Du angav", //MSG016
	"Nyckeln är ogiltig. Nyckeln måste vara ett hexadecimalt tal bestående av 13 eller 26 tecken. Du angav ", //MSG017
	"Den första adressen av %s måste vara ett hexadecimalt tal.", //MSG018
	"Den andra adressen av %s måste vara ett hexadecimalt tal.", //MSG019
	"Den tredje adressen av %s måste vara ett hexadecimalt tal.", //MSG020
	"Den fjärde adressen av %s måste vara ett hexadecimalt tal.", //MSG021
	"Den femte adressen av %s måste vara ett hexadecimalt tal.", //MSG022
	"Den sjätte adressen av %s måste vara ett hexadecimalt tal.", //MSG023
	"Den sjunde adressen av %s måste vara ett hexadecimalt tal.", //MSG024
	"Den åttonde adressen av %s måste vara ett hexadecimalt tal.", //MSG025
	"Det första området av %s måste vara mellan", //MSG026
	"Det andra området av %s måste vara mellan", //MSG027
	"Det tredje området av %s måste vara mellan", //MSG028
	"Det fjärde området av %s måste vara mellan", //MSG029
	"Det femte området av %s måste vara mellan", //MSG030
	"Det sjätte området av %s måste vara mellan", //MSG031
	"Det sjunde området av %s måste vara mellan", //MSG032
	"Det åttonde området av %s måste vara mellan", //MSG033
	"%s tillåter inte IP-loopback ( ::1 ).", //MSG034
	"%s tillåter inte IP-multicast ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"Ogiltigt metriskt värde", //MSG043
	"Det metriska värdet måste vara mellan (1..16).", //ar_alert_3
	"Ogiltig nätmask.", //ar_alert_5
	"Nyckeln", //TEXT042_1
	" är felaktig, giltiga tecken är 0~9, A~F, or a~f.", //TEXT042_2
	"Obs! Du kanske även måste ange ett tjänstenamn. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_note_svcn
	"L2TP-klient.", //wwa_msg_l2tp
	"För att ställa in den här anslutningen behöver du användarnamnet och lösenordet från din Internet-leverantör. Du behöver även IP-adressen för L2TP. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_set_l2tp_msg
	"För att ställa in den här anslutningen behöver du användarnamnet och lösenordet från din Internet-leverantör. Du behöver även IP-adressen för BigPond-servern. Kontakta din Internet-leverantör om du inte har nödvändig information.", //wwa_msg_set_bigpond
	"Värdnamn", //_hostname
	"2,4 GHz-band", //GW_WLAN_RADIO_0_NAME
	"5 GHz-band", //GW_WLAN_RADIO_1_NAME
	"Nedan följer en detaljerad sammanfattning av dina Wi-Fi-säkerhetsinställningar. Skriv ut sidan eller anteckna informationen på ett papper så att du kan konfigurera de rätta inställningarna på dina Wi-Fi-enheter.", //wwl_intro_end
	"Vänta...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Anslut", //_connect
	"Hjälp mig med inställningarna för Internet-anslutningen", //ES_btn_guide_me
	"Aktivera grafisk autentisering", //_graph_auth
	"D-LINK CORPORATION, INC | WIRELESS ROUTER | HEM", //TEXT000
	"Ett L2TP-lösenord MÅSTE anges", //GW_WAN_L2TP_PASSWORD_INVALID
	"Kunde inte hitta någon Internet-anslutning, vill du start om guiden?", //mydlink_tx03
	"Administratörslösenordet får inte vara tomt.", //mydlink_tx04
	"Kontrollerar WAN-anslutningen.", //mydlink_tx05
	"sekunder kvar.", //sec_left
	"Försök igen", //_retry
	"Har du ett mydlink-konto?", //mydlink_tx06
	"Ja, jag har ett mydlink-konto.", //mydlink_tx07
	"Nej, jag vill registrera mig och logga in med ett nytt mydlink-konto.", //mydlink_tx08
	"E-postadress (kontonamn)", //mydlink_tx09
	"Fyll i alternativen för att slutföra registreringen.", //mydlink_tx10
	"Bekräfta lösenord", //chk_pass
	"Efternamn", //Lname
	"Förnamn", //Fname
	"Jag accepterar villkoren för mydlink.", //mydlink_tx12
	"För att slutföra din mydlink-registrering, kontrollera din inkorg efter ett e-postmeddelande med bekräftelseanvisningar.", //mydlink_tx13_1
	" När du bekräftat din e-postadress klickar du på knappen Logga in", //mydlink_tx13_2
	"Logga in", //_login
	"OK", //_ok
	"Spara", //_save
	"Ändra de två lösenorden så att de är lika och försök igen", //_pwsame
	"För att använda funktionerna i  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> och mydlink Lite-programmet behöver du ett konto med <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Om du redan har ett konto väljer du <strong>Ja, jag har ett mydlink-konto</strong> och klickar på Nästa för att registrera routern med <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Om du inte har ett konto väljer du <strong>Nej, jag vill registrera mig och logga in med ett nytt mydlink-konto</strong> och klickar på Nästa för att skapa ett konto. ", //mydlink_reg_into_3
	" Om du inte vill registrera dig för mydlink-tjänsten klickar du på Avbryt.", //mydlink_reg_into_4_a
	"Den här e-postadressen har redan ett mydlink-konto. Prova med en annan e-postadress.", //mydlink_pop_01
	"Du måste acceptera villkoren för att fortsätta.", //mydlink_pop_02
	"får inte vara blankt.", //mydlink_pop_03
	"är ogiltigt", //mydlink_pop_04
	"Du kan nu använda mydlink-tjänsten med enheten", //mydlink_pop_05
	"Inloggningen misslyckades", //mydlink_pop_06
	"Registrera dig", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	" När mydlink-registreringen är klar kommer routerns standardinställning för PPoE-, L2TP- och PPTP-anslutning att sättas till Alltid på. Om din Internetleverantör tar betalt för användning bör du kanske manuellt välja Dial on Demand som standardinställning.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"Ett PPPoE-lösenord MÅSTE anges", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Hoppa över", //_skip
	"Om du inte vill registrera dig för mydlink-tjänsten klickar du på Hoppa över.", //mydlink_reg_into_4
	"Sparar Wi-Fi-inställningen", //mydlink_WiFi_save
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
