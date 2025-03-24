//Version=1.03b02
//Language=Slovenian
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Prekliči", //_cancel
	"Kopirajte MAC naslov vašega računalnika", //_clone
	"DHCP povezava (dinamičen IP naslov)", //_dhcpconn
	"IP naslov", //_ipaddr
	"L2TP", //_L2TP
	"IP naslov L2TP prehoda", //_L2TPgw
	"L2TP IP naslov", //_L2TPip
	"Podomrežna maska L2TP", //_L2TPsubnet
	"Jezik", //_Language
	"MAC naslov", //_macaddr
	"Naprej", //_next
	"Ne", //_no
	"(poljubno)", //_optional
	"Geslo", //_password
	"IP naslov PPTP prehoda", //_PPTPgw
	"PPTP IP naslov", //_PPTPip
	"Podomrežna maska PPTP", //_PPTPsubnet
	"Nazaj", //_prev
	"Zagotovite, da sta gesli skrbnika enaka in poskusite znova", //_pwsame_admin
	"Fiksni IP", //_sdi_staticip
	"Podomrežna maska", //_subnet
	"Uporabniško ime", //_username
	"Preveri geslo", //_verifypw
	"Ali želite opustiti vse spremembe, ki ste jih naredili s tem čarovnikom?", //_wizquit
	"Da", //_yes
	"Neveljaven IP naslov L2TP strežnika", //bwn_alert_17
	"Način naslova", //bwn_AM
	"Strežnik BigPond", //bwn_BPS
	"TKIP in AES", //bws_CT_3
	"Dinamični IP", //carriertype_ct_0
	"Usmerjevalnik zaznava vrsto vaše internetne povezave, počakajte ...", //ES_auto_detect_desc
	"Usmerjevalnik ne more zaznati vrste vaše internetne povezave.", //ES_auto_detect_failed_desc
	"Ali želite zaznamovati stran \"D-Link Router Web Management\"?", //ES_bookmark
	"Poskusi znova", //ES_btn_try_again
	"Vklopite en konec priloženega Ethernet kabla, ki je bil priložen k usmerjevalniku, v priključek INTERNET na hrbtni strani usmerjevalnika. Drug konec tega kabla vtaknite v Ethernet priključek na vašem modemu i vklopite modem.", //ES_cable_lost_desc
	"Korak 2: Nastavite varnost omrežja Wi-Fi", //ES_step_wifi_security
	"Korak 3: Nastavite geslo", //ES_title_s3
	"Korak 4: Izberite časovni pas", //ES_title_s4
	"Korak 5: Shranite nastavitve", //ES_title_s5
	"Korak 5: Potrdite nastavitve Wi-Fi", //ES_title_s5_0
	"Korak 6: Registracija MYDLINK", //ES_title_s6
	"Registracija MYDLINK", //ES_title_s6_myd
	"Korak 1: Nastavite internetno povezavo", //ES_wwa_title_s1
	"Neveljavno ime odjemalca DHCP", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Neveljavno geslo DHCP+", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Neveljavno uporabniško ime DHCP+", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"TREBA je določiti uporabniško ime L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"TREBA je določiti geslo PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Neveljaven omrežni ključ!", //IPV6_TEXT2
	"Napačen MAC naslov", //KR3
	"Samodejno (WPA ali WPA2) – osebno", //KR48
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
	"Ko registrirate svoj izdelek na mydlink, boste lahko uporabljali omogočene storitve mydlink, vključno s spletnim dostopom in upravljanjem vaše naprave preko spletnega mesta mydlink.", //mydlink_tx01
	"Ali želite registrirati svojo napravo na mydlink?", //mydlink_tx02
	"Vnesite uporabniško ime", //PPP_USERNAME_EMPTY
	"Podpora za PPPoE Plus", //pppoe_plus_dail
	"Geslo lahko vsebuje le znake, ki se lahko natisnejo.", //S493
	"SHRANJEVANJE NASTAVITEV", //save_settings
	"Vaše nastavitve se shranjujejo.", //save_wait
	"Različica vdelane programske opreme", //sd_FWV
	"Stran izdelka", //TA2
	"Različica strojne opreme", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Otok Midway, Samoa", //up_tz_01
	"(GMT-10:00) Havaji", //up_tz_02
	"(GMT-09:00) Aljaska", //up_tz_03
	"(GMT-08:00) Pacifiški čas (ZDA/Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Gorski čas (ZDA/Kanada)", //up_tz_06
	"(GMT-06:00) Srednja Amerika", //up_tz_07
	"(GMT-06:00) Centralni čas (ZDA/Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Vzhodni čas (ZDA/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (vzhod)", //up_tz_13
	"(GMT-04:00) Atlantski čas (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brazilija", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grenlandija", //up_tz_20
	"(GMT-02:00) Srednji Atlantik", //up_tz_21
	"(GMT-01:00) Azori", //up_tz_22
	"(GMT-01:00) Cape Verde Is.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwiški čas: Dublin, Edinburgh, Lisbon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rim, Stockholm, Dunaj", //up_tz_26
	"(GMT+01:00) Beograd, Bratislava, Budimpešta, Ljubljana, Praga", //up_tz_27
	"(GMT+01:00) Bruselj, Kopenhagen, Madrid, Pariz", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budimpešta, Dunaj, Praga, Varšava", //up_tz_29b
	"(GMT+01:00) Zahodna centralna Afrika", //up_tz_30
	"(GMT+02:00) Atene, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukarešta", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Talin", //up_tz_35
	"(GMT+02:00) Jeruzalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuvajt, Riad", //up_tz_38
	"(GMT+04:00) Moskva, St. Peterburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Erevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Kolkata, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoj, Džakarta", //up_tz_53
	"(GMT+08:00) Krasnoyarsk", //up_tz_54
	"(GMT+08:00) Peking, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Tajpej", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Seoul", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Solomonovi otoki, Nova Kaledonija", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall Is.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) mednarodna datumska meja - zahod", //up_tz_76
	"(GMT-11:00) Otok Midway", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Mexico City, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (vzhod)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Varšava, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kijev, Riga, Sofia, Talin, Vilna", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulaan Bataar", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"DNS nastavitve", //wwa_dnsset
	"Naslov prehoda", //wwa_gw
	"Kot privzeto, vaš novi usmerjevalnik D-Link nima nastavljenega gesla za skrbniški dostop do spletnih strani za nastavljanje. Da zavarujete svojo novo omrežno napravo, nastavite in potrdite geslo spodaj, omogočanje CAPTCHA vizualnega preverjanja prisotnosti pa omogoča dodatno varnostno zaščito, ki preprečuje, da nepooblaščeni uporabniki interneta i hekerski programi dostopajo k vašim omrežnim nastavitvam.", //wwa_intro_s1
	"Izberite ustrezni časovni pas za vašo lokacijo. Ta informacije je potrebna za nastavljanje časovno odvisnih možnosti. Vaš usmerjevalnik bo samodejno posodobil notranjo uro z NTP strežnika za čas.", //wwa_intro_s2
	"Izberite vrsto vaše internetne povezave spodaj:", //wwa_intro_s3
	"Ta čarovnik vas popelje korak za korakom skozi postopek za nastavljanje vašega usmerjevalnika D-Link in povezovanje z internetom.", //wwa_intro_wel
	"IP naslov L2TP strežnika (lahko je enak prehodu)", //wwa_l2tp_svra
	"Izberite to možnost, če vam internetna povezava samodejno dodeli IP naslov. To vrsto povezave uporablja večina kabelskih modemov.", //wwa_msg_dhcp
	"Če vaš ponudnik internetnih storitev ni na seznamu ali ne veste, kateri je, izberite vrsto internetne povezave spodaj:", //wwa_msg_ispnot
	"Izberite to možnost, če je za povezovanje z internetom potrebujete uporabniško ime in geslo. To vrsto povezave uporablja večina DSL modemov.", //wwa_msg_pppoe
	"Odjemalec PPTP.", //wwa_msg_pptp
	"Za nastavljanje te povezave, zagotovite, da ste povezali usmerjevalnik D-Link z računalnikom, ki je izvirno bil povezan sz vašo širokopasovno povezavo. Če je tako, potem kliknite gumb Kloniraj MAC, da kopirate MAC naslov vašega računalnika v usmerjevalnik D-Link.", //wwa_msg_set_dhcp
	"Za nastavitev te povezave boste potrebovali uporabniško ime in geslo, ki vam ga je dodelil vaš ponudnik internetnih storitev. Če teh informacij nimate, se obrnite na vašega ponudnika internetnih storitev.", //wwa_msg_set_pppoe
	"Za nastavitev te povezave boste potrebovali uporabniško ime in geslo, ki vam ga je dodelil vaš ponudnik internetnih storitev. Potrebujete tudi PPTP IP naslov. Če teh informacij nimate, se obrnite na vašega ponudnika internetnih storitev.", //wwa_msg_set_pptp
	"Izberite to možnost, če vam je ponudnik internetnih storitev dodelil IP naslov, ki ga je treba nastaviti ročno.", //wwa_msg_sipa
	"Opomba: Morda boste morali določiti tudi ime gostitelja. Če teh informacij nimate ali jih ne veste, se obrnite na vašega ponudnika internetnih storitev.", //wwa_note_hostname
	"Primarni DNS naslov", //wwa_pdns
	"IP naslov PPTP strežnika (lahko je enak prehodu)", //wwa_pptp_svraddr
	"Sekundarni DNS naslov", //wwa_sdns
	"Ni na seznamu ali ne vem", //wwa_selectisp_not
	"Nastavite povezavo z uporabniškim imenom in geslom (L2TP)", //wwa_set_l2tp_title
	"Za nastavitev te povezave boste potrebovali celoten seznam informacij o IP-ju, ki vam ga je dodelil vaš ponudnik internetnih storitev. Če imate povezavo s statičnim IP-jem, teh informacij pa nimate, se obrnite na vašega ponudnika internetnih storitev.", //wwa_set_sipa_msg
	"Nastavite povezavo s statičnim IP naslovom", //wwa_set_sipa_title
	"Nastavite kabelsko povezavo BigPond", //wwa_title_set_bigpond
	"Nastavite povezavo z uporabniškim imenom in geslom (PPPoE)", //wwa_title_set_pppoe
	"Nastavite povezavo z uporabniškim imenom in geslom (PPTP)", //wwa_title_set_pptp
	"Dobrodošli v D-Link čarovnik za namestitev", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Povezava z uporabniškim imenom in geslom (L2TP)", //wwa_wanmode_l2tp
	"Povezava z uporabniškim imenom in geslom (PPPoE)", //wwa_wanmode_pppoe
	"Povezava z uporabniškim imenom in geslom (PPTP)", //wwa_wanmode_pptp
	"Povezava s statičnim IP naslovom", //wwa_wanmode_sipa
	"Dajte svojemu omrežju Wi-Fi ime.", //wwz_wwl_intro_s2_1
	"Ime omrežja Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(do 32 znakov)", //wwz_wwl_intro_s2_1_2
	"Nastavite geslo za svoje omrežje Wi-Fi.", //wwz_wwl_intro_s2_2
	"Geslo Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(med 8 in 63 znaki)", //wwz_wwl_intro_s2_2_2
	"Poimenujte omrežje z imenom, ki naj bo dolgo do 32 znakov.", //wwz_wwl_intro_s3_1
	"Korak 1: Dobrodošli V D-LINK ČAROVNIK ZA VARNO BREZŽIČNO POVEZAVO", //wwz_wwl_title_s3
	"Neveljaven IP naslov PPTP strežnika", //YM108
	"Uporabite enako brezžično varnostno geslo za pasova 2,4 GHz in 5 GHz", //wwl_SSP
	"Dajte svojemu omrežju Wi-Fi ime in geslo.", //wwz_wwl_intro_s0
	"1. naslov %s mora biti celo število.", //MSG002
	"2. naslov %s mora biti celo število.", //MSG003
	"3. naslov %s mora biti celo število.", //MSG004
	"4. naslov %s mora biti celo število.", //MSG005
	"%s je neveljaven naslov.", //MSG006
	"%s ne sme biti ničla.", //MSG007
	"Vrata %s, ki ste jih vnesli, so neveljavna.", //MSG008
	"Skrivnost %s, ki ste jo vnesli, je neveljavna", //MSG009
	"%s ne dovoli vnosa za povratno zanko IP ali večvrstno oddajanje IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Vnesite drugo vrednost %s.", //MSG012
	"Vrednost %s mora biti številka!", //MSG013
	"Razpon %s je med %1n ~ %2n.", //MSG014
	"Vrednost %s mora biti celo število.", //MSG015
	"Ključ je neveljaven. Ključ mora biti heksadecimalna številka z 5 ali 10 znaki. Vnesli ste", //MSG016
	"Ključ je neveljaven. Ključ mora biti heksadecimalna številka z 13 ali 26 znaki. Vnesli ste", //MSG017
	"1. naslov %s mora biti heksadecimalna številka.", //MSG018
	"2. naslov %s mora biti heksadecimalna številka.", //MSG019
	"3. naslov %s mora biti heksadecimalna številka.", //MSG020
	"4. naslov %s mora biti heksadecimalna številka.", //MSG021
	"5. naslov %s mora biti heksadecimalna številka.", //MSG022
	"6. naslov %s mora biti heksadecimalna številka.", //MSG023
	"7. naslov %s mora biti heksadecimalna številka.", //MSG024
	"8. naslov %s mora biti heksadecimalna številka.", //MSG025
	"1. razpon %s mora biti med", //MSG026
	"2. razpon %s mora biti med", //MSG027
	"3. razpon %s mora biti med", //MSG028
	"4. razpon %s mora biti med", //MSG029
	"5. razpon %s mora biti med", //MSG030
	"6. razpon %s mora biti med", //MSG031
	"7. razpon %s mora biti med", //MSG032
	"8. razpon %s mora biti med", //MSG033
	"%s ne dovoli vnosa za povratno zanko IP ( ::1 ).", //MSG034
	"%s ne dovoli vnosa za večvrstno oddajanje IP ( FFxx:0:0:0:0:0:0:2 ali ffxx:0:0:0:0:0:0:2.", //MSG035
	"Neveljavna metrična vrednost", //MSG043
	"Metrična vrednost mora biti med (1..16).", //ar_alert_3
	"Neveljavna maska omrežja.", //ar_alert_5
	"Ključ", //TEXT042_1
	" je napačen, dovoljeni znaki so 0~9, A~F ali a~f.", //TEXT042_2
	"Opomba: Morda boste morali določiti tudi ime storitve. Če teh informacij nimate ali jih ne veste, se obrnite na vašega ponudnika internetnih storitev.", //wwa_note_svcn
	"L2TP odjemalec.", //wwa_msg_l2tp
	"Za nastavitev te povezave boste potrebovali uporabniško ime in geslo, ki vam ga je dodelil vaš ponudnik internetnih storitev. Potrebujete tudi L2TP IP naslov. Če teh informacij nimate, se obrnite na vašega ponudnika internetnih storitev.", //wwa_set_l2tp_msg
	"Za nastavitev te povezave boste potrebovali uporabniško ime in geslo, ki vam ga je dodelil vaš ponudnik internetnih storitev. Potrebujete tudi IP naslov strežnika BigPond. Če teh informacij nimate, se obrnite na vašega ponudnika internetnih storitev.", //wwa_msg_set_bigpond
	"Ime gostitelja", //_hostname
	"2,4GHz pas", //GW_WLAN_RADIO_0_NAME
	"5GHz pas", //GW_WLAN_RADIO_1_NAME
	"Spodaj je podroben povzetek vaših varnostnih nastavitev Wi-Fi. Prosimo, natisnite to stran ali zapišite podatke na kos papirja, da boste lahko nastavili pravilne nastavitve na vaših napravah Wi-Fi.", //wwl_intro_end
	"Počakajte ...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Poveži", //_connect
	"Vodi me skozi nastavitve internetne povezave", //ES_btn_guide_me
	"Omogoči vizualno preverjanje prisotnosti", //_graph_auth
	"D-LINK CORPORATION, INC | BREZŽIČNI USMERJEVALNIK | ZAČETNA", //TEXT000
	"TREBA je določiti geslo L2TP", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internet ni zaznan, ali želite znova zagnati čarovnika?", //mydlink_tx03
	"Skrbniško geslo ne sme biti prazno.", //mydlink_tx04
	"Preverjanje povezljivosti WAN.", //mydlink_tx05
	"sekund je preostalo.", //sec_left
	"Poskusi znova", //_retry
	"Ali imate račun mydlink?", //mydlink_tx06
	"Da, imam račun mydlink.", //mydlink_tx07
	"Ne, želim se registrirati in se prijaviti z novim računom mydlink.", //mydlink_tx08
	"E-poštni naslov (ime računa)", //mydlink_tx09
	"Izpolnite možnosti, da končate registracijo.", //mydlink_tx10
	"Potrdite geslo", //chk_pass
	"Priimek", //Lname
	"Ime", //Fname
	"Sprejemam Določila in pogoje mydlink.", //mydlink_tx12
	"Da dokončate registracijo mydlink, v prejeti pošti poiščite e-poštno sporočilo z navodili za potrjevanje.", //mydlink_tx13_1
	" Potem ko potrdite svoj e-poštni naslov, kliknite gumb Prijava.", //mydlink_tx13_2
	"Prijava", //_login
	"V redu", //_ok
	"Shrani", //_save
	"Zagotovite, da sta gesli enaka in poskusite znova", //_pwsame
	"Za uporabo funkcij <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> in aplikacije mydlink Lite potrebujete račun pri <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_1
	"Če račun že imate, izberite <strong>Da, imam račun mydlink</strong> in kliknite Naprej, da registrirate svoj usmerjevalnik pri <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_2
	"Če računa nimate, izberite <strong>Ne, želim se registrirati in se prijaviti z novim računom mydlink.</strong> in kliknite Naprej, da ustvarite račun.", //mydlink_reg_into_3
	" Če se ne želite registrirati za storitev mydlink, kliknite Prekliči.", //mydlink_reg_into_4_a
	"Ta E-poštni naslov se že uporablja za račun mydlink. Poskusite z drugim e-poštnim naslovom.", //mydlink_pop_01
	"Morate sprejeti Določila in pogoje mydlink, da lahko nadaljujete.", //mydlink_pop_02
	"ne sme biti prazno.", //mydlink_pop_03
	"je neveljavno.", //mydlink_pop_04
	"Sedaj lahko uporabljate storitev mydlink s to napravo", //mydlink_pop_05
	"Prijava ni uspela", //mydlink_pop_06
	"prijavite", //_signup
	"Potem ko opravite registracijo mydlink, bo privzeta povezava PPPoE, L2TP, PPTP vašega usmerjevalnika vedno postavljena na Vedno vklopljeno. Če vam ISP zaračuna stroške povezave, lahko ročno izberete Kliči na zahtevo, kot privzeto nastavitev.", //mydlink_pop_09
	"Prijava v storitev mydlink ni mogoča.", //mdl_errmsg_01
	"Pošiljanje zahteve za prijavo ni uspelo.", //mdl_errmsg_02
	"Zahteve za prijavo ni mogoče poslati.", //mdl_errmsg_03
	"Pošiljanje zahteve za registracijo ni uspelo.", //mdl_errmsg_04
	"Zahteve za registracijo ni mogoče poslati.", //mdl_errmsg_05
	"Polje SSID ne sme biti prazno", //SSID_EMPTY_ERROR
	"Gesli, ki ste ju vnesli, se ne ujemata", //YM102
	"TREBA je določiti geslo PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Geslo računa mora vsebovati več kot šest znakov", //limit_pass_msg
	"Preskoči", //_skip
	" Če se ne želite registrirati za storitev mydlink, kliknite Preskoči.", //mydlink_reg_into_4
	"Shranjevanje nastavitev Wi-Fi", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Ta naprava podpira mydlink, kar vam omogoča oddaljeni nadzor in upravljanje vašega omrežja prek spletne strani mydlink ali mobilne aplikacije mydlink.", //_wz_mydlink_into_1
	"Preverili boste lahko omrežne hitrosti, kdo je povezan, zgodovino brskanja in boste prejemali obvestila o novih uporabnikih in nasilnih poskusih vdora.", //_wz_mydlink_into_2
	"To napravo lahko registrirate z vašim obstoječim računom mydlink. Če ga nimate, ga lahko ustvarite zdaj.", //_wz_mydlink_into_3
	"V poštnem nabiralniku poiščite e-pošto z navodili za potrditev.", //_wz_mydlink_email_1
	"Usmerjevalnik preverja možnost povezovanja z internetom, počakajte ...", //_chk_wanconn_msg_00
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