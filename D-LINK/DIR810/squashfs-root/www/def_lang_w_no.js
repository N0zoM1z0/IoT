//Version=1.03b02
//Language=Norwegian
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Avbryt", //_cancel
	"Kopier PC-ens MAC-adresse", //_clone
	"DHCP-tilkobling (dynamisk IP-adresse )", //_dhcpconn
	"IP-adresse", //_ipaddr
	"L2TP", //_L2TP
	"L2TP Gateway IP-adresse", //_L2TPgw
	"L2TP IP-adresse:", //_L2TPip
	"L2TP Subnettmaske", //_L2TPsubnet
	"Språk", //_Language
	"MAC-adresse", //_macaddr
	"Neste", //_next
	"Nei", //_no
	"(valgfritt)", //_optional
	"Passord", //_password
	"PPTP Gateway IP-adresse", //_PPTPgw
	"PPTP IP-adresse:", //_PPTPip
	"PPTP Subnettmaske:", //_PPTPsubnet
	"Forr.", //_prev
	"Sørg for at de to admin-passordene er like, og prøv igjen", //_pwsame_admin
	"Statisk IP", //_sdi_staticip
	"Subnettmaske", //_subnet
	"Brukernavn", //_username
	"Bekreft passord", //_verifypw
	"Vil du annulere alle endringer du har gjort i denne veiviseren?", //_wizquit
	"Ja", //_yes
	"Ugyldig L2TP Server IP-adresse", //bwn_alert_17
	"Adressemodus", //bwn_AM
	"BigPond-server", //bwn_BPS
	"TKIP og AES", //bws_CT_3
	"Dynamisk IP", //carriertype_ct_0
	"Ruter oppdager din internettforbindelse, vennligst vent …", //ES_auto_detect_desc
	"Ruteren klarer ikke å oppdage din Internett-tilkoblingstype.", //ES_auto_detect_failed_desc
	"Vil du bokmerke \"D-Link Ruter-webadministrasjon\"?", //ES_bookmark
	"Prøv igjen", //ES_btn_try_again
	"Sett inn den ene enden av ethernetkabelen som fulgte med ruteren i porten INTERNET på baksiden av ruteren. Sett den andre enden av denne kabelen i ethernetporten på modemet og slå av og på modemet.", //ES_cable_lost_desc
	"Trinn 2: Konfigurer WiFi-sikkerheten", //ES_step_wifi_security
	"Trinn 3: Angi ditt passord", //ES_title_s3
	"Trinn 4: Velg din tidssone", //ES_title_s4
	"Trinn 5: Lagre innstillinger", //ES_title_s5
	"Trinn 5: Bekreft WiFi-innstillinger", //ES_title_s5_0
	"Trinn 6: MYDLINK-registrering", //ES_title_s6
	"MYDLINK-registrering", //ES_title_s6_myd
	"Trinn 1: Konfigurere Internett-tilkoblingen", //ES_wwa_title_s1
	"Ugyldig DHCP-klientnavn", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Ugyldig DHCP+ passord", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Ugyldig DHCP+ brukernavn", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Et L2TP-brukernavn må angis", //GW_WAN_L2TP_USERNAME_INVALID
	"En PPTP-passord MÅ angis", //GW_WAN_PPTP_PASSWORD_INVALID
	"Ugyldig nettverksnøkkel!", //IPV6_TEXT2
	"Ugyldig MAC-adresse", //KR3
	"Auto (WPA eller WPA2) - Personlig", //KR48
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
	"Å registrere produktet hos mydlink vil la deg bruke de mydlink-aktiverte funksjoner, inkludert elektronisk adgang og administrasjon av enheten din gjennom mydlink-nettstedet.", //mydlink_tx01
	"Ønsker du å registrere enheten hos mydlink?", //mydlink_tx02
	"Tast inn et brukernavn.", //PPP_USERNAME_EMPTY
	"PPPoE Plus-støttet", //pppoe_plus_dail
	"Passord kan bare inneholde utskrivbare tegn.", //S493
	"LAGRER INNSTILLINGER", //save_settings
	"Innstillingene dine blir lagret.", //save_wait
	"Firmware-versjon", //sd_FWV
	"Produktside", //TA2
	"Maskinvare-versjon", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway-øya, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (US og Canada);Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (US og Canada)", //up_tz_06
	"(GMT-06:00) Sentralamerika", //up_tz_07
	"(GMT-06:00) Central Time (US og Canada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (US og Canada)", //up_tz_12
	"(GMT-05:00) Indiana (Øst)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Canada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grønland", //up_tz_20
	"(GMT-02:00) Midt-atlanteren", //up_tz_21
	"(GMT-01:00) Azorene", //up_tz_22
	"(GMT-01:00) Cape Verde-øyene.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich Time: Dublin, Edinburgh, Lisboa, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Roma, Stockholm, Vienna", //up_tz_26
	"(GMT+01:00) Beograd, Bratislava, Budapest, Ljubljana, Praha", //up_tz_27
	"(GMT+01:00) Brussel, København, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Wien, Praha, Warsawa", //up_tz_29b
	"(GMT+01:00) Vest-sentralafrika", //up_tz_30
	"(GMT+02:00) Athen, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bucharest", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Baghdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moskva, St. Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teheran", //up_tz_41
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
	"(GMT+11:00) Solomon-øyene, Ny-Caledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall-øyene.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) Vestlige internasjonale datolinje", //up_tz_76
	"(GMT-11:00) Midway Island", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Mexico City, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (East)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Warsawa, Zagreb", //up_tz_84
	"(GMT+02:00) Helsingfors, Kiev, Riga, Sofia, Tallinn, Vilnius", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulaan Bataar", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"DNS-innstillinger", //wwa_dnsset
	"Gateway-adresse", //wwa_gw
	"Som standard har den nye D-Link-ruteren ikke et passord konfigurert for administrator-tilgang til web-baserte konfigurasjonssider. For å sikre din nye nettverksenhet, kan du angi og bekrefte et passord nedenfor, og å aktivere CAPTCHA grafisk autentisering utgjør en ekstra sikkerhet for å forhindre uautoriserte online brukere og hackerprogramvare som kunne få adgang til dine nettverksinnstillinger.", //wwa_intro_s1
	"Velg riktig tidssone for stedet du befinner deg på. Denne informasjonen er nødvendig for å konfigurere tidsbaserte alternativer. Ruteren vil bli satt til å automatisk oppdatere sin interne klokke fra en NTP-tidsserver.", //wwa_intro_s2
	"Velg din Internett-tilkoblingstype nedenfor:", //wwa_intro_s3
	"Denne veiviseren vil guide deg gjennom en trinn-for-trinn prosess for å konfigurere den nye D-Link-ruteren og koble den til Internett.", //wwa_intro_wel
	"L2TP server IP-adresse (kan være samme som gateway )", //wwa_l2tp_svra
	"Velg dette hvis Internett-tilkoblingen automatisk gir deg en IP-adresse. De fleste kabelmodemer bruker denne typen tilkobling.", //wwa_msg_dhcp
	"Hvis Internett-leverandøren ikke var oppført eller du ikke vet hvem det er, må du velge Internett-tilkoblingstype nedenfor:", //wwa_msg_ispnot
	"Velg dette alternativet hvis Internett-tilkoblingen krever brukernavn og passord for å komme på nett. De fleste DSL-modemer bruke denne tilkoblingstypen.", //wwa_msg_pppoe
	"PPTP-klient.", //wwa_msg_pptp
	"For å sette opp denne forbindelsen, må du kontrollere at du er koblet til D-Link-ruteren med PC-en som opprinnelig ble koblet til bredbånd. Hvis du er det, kan du klikke på Clone MAC-knappen for å kopiere datamaskinens MAC-adresse til D-Link-ruteren.", //wwa_msg_set_dhcp
	"For å sette opp denne forbindelsen må du ha et brukernavn og passord fra din internettleverandør. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_msg_set_pppoe
	"For å sette opp denne forbindelsen må du ha et brukernavn og passord fra din internettleverandør. Du trenger også en PPTP IP-adresse. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_msg_set_pptp
	"Velg dette alternativet hvis din internettleverandør har gitt deg IP-adresseinformasjon som må konfigureres manuelt.", //wwa_msg_sipa
	"Merk: Du må kanskje også oppgi et vertsnavn. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_note_hostname
	"Primær DNS-adresse", //wwa_pdns
	"PPTP server IP-adresse (kan være samme som gateway )", //wwa_pptp_svraddr
	"Sekundær DNS-adresse", //wwa_sdns
	"Ikke oppført eller vet ikke", //wwa_selectisp_not
	"Angi brukernavn og passord forbindelse (L2TP)", //wwa_set_l2tp_title
	"For å sette opp denne forbindelsen må du ha et brukernavn og passord fra din internettleverandør. Hvis du har en statisk IP-tilkobling og ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_set_sipa_msg
	"Angi statisk IP-adresse-forbindelse", //wwa_set_sipa_title
	"Angi BigPond-kabelforbindelse", //wwa_title_set_bigpond
	"Angi brukernavn og passord-forbindelse (PPPoE)", //wwa_title_set_pppoe
	"Angi brukernavn og passord-forbindelse (PPTP)", //wwa_title_set_pptp
	"Velkommen til D-Link-oppsetveiviseren", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Brukernavn / passord-forbindelse (L2TP)", //wwa_wanmode_l2tp
	"Brukernavn / passord-forbindelse (PPPoE)", //wwa_wanmode_pppoe
	"Brukernavn / passord-forbindelse (PPTP)", //wwa_wanmode_pptp
	"Statisk IP-adresse-forbindelse", //wwa_wanmode_sipa
	"Gi ditt WiFi-nettverk et navn", //wwz_wwl_intro_s2_1
	"WiFi-nettverkets navn (SSID)", //wwz_wwl_intro_s2_1_1
	"(bruk opptil 32 tegn )", //wwz_wwl_intro_s2_1_2
	"Gi ditt WiFi-nettverk et passord", //wwz_wwl_intro_s2_2
	"WiFi-passord", //wwz_wwl_intro_s2_2_1
	"(mellom 8 og 63 tegn)", //wwz_wwl_intro_s2_2_2
	"Gi nettverket et navn, med opptil 32 tegn.", //wwz_wwl_intro_s3_1
	"Trinn 1: VELKOMMEN TIL D-LINKs TRÅDLØSE SIKKERHETS-OPPSETTVEISVISEREN", //wwz_wwl_title_s3
	"Ugyldig PPTP-server IP-adresse", //YM108
	"Bruk samme trådløse sikkerhetspassord på både 2,4 GHz- og 5 GHz-båndet", //wwl_SSP
	"Gi ditt WiFi-nettverk et navn og et passord", //wwz_wwl_intro_s0
	"Den 1. adressen av %s må være et heltall.", //MSG002
	"Den 2. adressen av %s må være et heltall.", //MSG003
	"Den 3. adressen av %s må være et heltall.", //MSG004
	"Den 4. adressen av %s må være et heltall.", //MSG005
	"%s er en ugyldig adresse.", //MSG006
	"%s kan ikke være null.", //MSG007
	"%s-porten som er tastet inn er ugyldig.", //MSG008
	"%s-hemmeligheten som er tastet inn er ugyldig.", //MSG009
	"%s tillater ikke tiøgang til loopback-IP eller multicast-IP(127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Tast inn en annen %s-verdi.", //MSG012
	"Verdien av %s må være numerisk!", //MSG013
	"Området av %s er %1n ~ %2n.", //MSG014
	"Verdien av %s må et partall.", //MSG015
	"Nøkkelen er ugyldig. Nøkkelen må være et heksadesimal tall på 5 eller 10 tegn. Du tastet inn", //MSG016
	"Nøkkelen er ugyldig. Nøkkelen må være et heksadesimal tall på 13 eller 26 tegn. Du tastet inn", //MSG017
	"Den 1. adressen av %s må være heksadesimal.", //MSG018
	"Den 2. adressen av %s må være heksadesimal.", //MSG019
	"Den 3. adressen av %s må være heksadesimal.", //MSG020
	"Den 4. adressen av %s må være heksadesimal.", //MSG021
	"Den 5. adressen av %s må være heksadesimal.", //MSG022
	"Den 6. adressen av %s må være heksadesimal.", //MSG023
	"Den 7. adressen av %s må være heksadesimal.", //MSG024
	"Den 8. adressen av %s må være heksadesimal.", //MSG025
	"Det 1. området av %s må være mellom", //MSG026
	"Det 2. området av %s må være mellom", //MSG027
	"Det 3. området av %s må være mellom", //MSG028
	"Det 4. området av %s må være mellom", //MSG029
	"Det 5. området av %s må være mellom", //MSG030
	"Det 6. området av %s må være mellom", //MSG031
	"Det 7. området av %s må være mellom", //MSG032
	"Det 8. området av %s må være mellom", //MSG033
	"%s tillater ikke tilgang til loopback-IP ( ::1 ).", //MSG034
	"%s tillater ikke tilgang til multicast-IP ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"Ugyldig metrisk", //MSG043
	"Metrisk verdi skal være mellom (1..16).", //ar_alert_3
	"Ugyldig nettmaske.", //ar_alert_5
	"Nøkkelen", //TEXT042_1
	" er feil, de gyldige tegnene er 0~9, A~F eller a~f.", //TEXT042_2
	"Merk: Du må kanskje også oppgi et servicenavn. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_note_svcn
	"L2TP-klient.", //wwa_msg_l2tp
	"For å sette opp denne forbindelsen må du ha et brukernavn og passord fra din internettleverandør. Du trenger også en L2TP IP-adresse. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_set_l2tp_msg
	"For å sette opp denne forbindelsen må du ha et brukernavn og passord fra din internettleverandør. Du trenger også en BigPond-server IP-adresse. Hvis du ikke har denne informasjonen, kan du kontakte din internettleverandør.", //wwa_msg_set_bigpond
	"Vertsnavn", //_hostname
	"2,4 GHz-bånd", //GW_WLAN_RADIO_0_NAME
	"5 GHz-bånd", //GW_WLAN_RADIO_1_NAME
	"Nedenfor er en detaljert oppsummering av dine Wi-Fi-sikkerhetsinnstillinger. Skriv denne siden ut, eller skriv informasjonen på et stykke papir, slik at du kan konfigurere de riktige innstillingene på dine Wi-Fi-enheter.", //wwl_intro_end
	"Vennligst vent ...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Koble til", //_connect
	"Vis meg Internett-tilkoblingsinnstillingene", //ES_btn_guide_me
	"Aktiver grafisk autentisering", //_graph_auth
	"D-LINK CORPORATION, INC | TRÅDLØS RUTER | HJEM", //TEXT000
	"En L2TP-passord MÅ angis", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internett ikke oppdaget, ønsker du å starte veiviseren?", //mydlink_tx03
	"Administratorpassord kan ikke være blank.", //mydlink_tx04
	"Sjekk WAN-tilkobling.", //mydlink_tx05
	"sekunder igjen.", //sec_left
	"Forsøk igjen", //_retry
	"Har du en mydlink-konto?", //mydlink_tx06
	"Ja, jeg har allerede en mydlink-konto.", //mydlink_tx07
	"Nei, jeg ønsker å registrere meg og logge på med en ny mydlink konto.", //mydlink_tx08
	"E-postadresse (kontonavn)", //mydlink_tx09
	"Velg alternativene for å fullføre registreringen.", //mydlink_tx10
	"Bekreft passord", //chk_pass
	"Etternavn", //Lname
	"Fornavn", //Fname
	"Jeg aksepterer mydlinks vilkår og betingelser.", //mydlink_tx12
	"For å fullføre mydlink-registreringen kan du sjekke innboksen for en e-post med bekreftelsesinstruksjoner.", //mydlink_tx13_1
	" Etter å ha bekreftet e-postadressen din kan du klikke på Logg inn-knappen.", //mydlink_tx13_2
	"Logg inn", //_login
	"OK", //_ok
	"Lagre", //_save
	"Sørg for at de to admin-passordene er like, og prøv igjen", //_pwsame
	"Hvis du vil bruke funksjonene i <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> og mydlink Lite-appen, må du ha en konto hos <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_1
	"Hvis du allerede har en konto, velg <strong>Ja, jeg har en mydlink-konto</strong>og klikk på Neste for å registrere ruteren hos <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_2
	"Hvis du ikke har en konto, velg <strong>Nei, jeg ønsker å registrere og logge inn med en ny mydlink konto</strong> og klikk på Neste for å opprette en konto.", //mydlink_reg_into_3
	" Hvis du ikke ønsker å registrere deg for mydlink, vennligst klikk Avbryt.", //mydlink_reg_into_4_a
	"Denne e-postadressen har allerede en mydlink-konto. Prøv en annen e-postadresse.", //mydlink_pop_01
	"Du må akseptere vilkårene og betingelsene for å fortsette.", //mydlink_pop_02
	"bør ikke være blank.", //mydlink_pop_03
	"er ugyldig.", //mydlink_pop_04
	"Du kan nå bruke mydlink-tjenesten med denne enheten", //mydlink_pop_05
	"Påloggingen mislyktes", //mydlink_pop_06
	"påmelding", //_signup
	"Etter at mydlink-registreringen er fullført, settes ruterens standard PPPoE-, L2TP- og PPTP-tilkobling til Alltid på. Hvis din ISP beregner avgifter for bruk, kan du manuelt velge Ring etter behov som standard innstilling. ", //mydlink_pop_09
	"Kan ikke logge inn til mydlink.", //mdl_errmsg_01
	"Innsending av innloggingsforespørsel mislyktes.", //mdl_errmsg_02
	"Kan ikke sende innloggingsforespørsel.", //mdl_errmsg_03
	"Innsending av registreringsforespørsel mislyktes.", //mdl_errmsg_04
	"Kan ikke sende registreringsforespørsel.", //mdl_errmsg_05
	"SSID-feltet kan ikke være tomt", //SSID_EMPTY_ERROR
	"Passordene du har tastet matcher ikke.", //YM102
	"En PPPoE-passord MÅ angis", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Kontopassordet må være på mer enn seks tegn", //limit_pass_msg
	"Hopp over", //_skip
	"Hvis du ikke ønsker å registrere deg for mydlink-service, klikk på Hopp over", //mydlink_reg_into_4
	"Lagre Wi-Fi-innstillingen", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Denne enheten er mydlink-aktivert, slik at du kan fjernstyre og administrere ditt nettverk gjennom mydlink.coms nettsted eller gjennom mydlink mobil-appen.", //_wz_mydlink_into_1
	"Du kan sjekke nettverkshastigheter, se hvem som er tilkoblet, se enhetens surfe-historie, og motta varslinger om nye brukere eller innbruddsforsøk.", //_wz_mydlink_into_2
	"Du kan registrere denne enheten med din eksisterende mydlink-konto. Hvis du ikke har en konto, kan du opprette en nå.", //_wz_mydlink_into_3
	"Vennligst sjekk din postkasse for en e-post med bekreftelsesinstruksjoner.", //_wz_mydlink_email_1
	"Ruteren sjekker Internett-tilkoblingen, vennligst vent.", //_chk_wanconn_msg_00
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