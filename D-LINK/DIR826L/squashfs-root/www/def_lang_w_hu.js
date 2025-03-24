//Version=1.01b02
//Language=Hungarian
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Mégse", //_cancel
	"Másolja át számítógépe MAC-címét", //_clone
	"DHCP-kapcsolat (Dinamikus IP-cím kapcsolat)", //_dhcpconn
	"IP-cím", //_ipaddr
	"L2TP", //_L2TP
	"L2TP Átjáró IP-címe", //_L2TPgw
	"L2TP IP-cím", //_L2TPip
	"L2TP Alhálózati maszk", //_L2TPsubnet
	"Nyelv", //_Language
	"MAC-cím", //_macaddr
	"Tovább", //_next
	"Nem", //_no
	"(opcionális)", //_optional
	"Jelszó", //_password
	"PPTP Átjáró IP-cím", //_PPTPgw
	"PPTP IP-cím", //_PPTPip
	"PPTP Alhálózati maszk", //_PPTPsubnet
	"Előző", //_prev
	"Kérjük, írja át a két adminisztrátori jelszót egyformára, majd próbálja újra.", //_pwsame_admin
	"Állandó IP-cím", //_sdi_staticip
	"Alhálózati maszk", //_subnet
	"Felhasználónév", //_username
	"Jelszó hitelesítése", //_verifypw
	"El akarja vetni a varázslóban elvégzett minden módosítását?", //_wizquit
	"Igen", //_yes
	"Az L2TP kiszolgáló IP-címe érvénytelen.", //bwn_alert_17
	"Cím mód", //bwn_AM
	"BigPond kiszolgáló", //bwn_BPS
	"TKIP és AES", //bws_CT_3
	"Dinamikus IP", //carriertype_ct_0
	"A router most felismeri az internetkapcsolat típusát, kérjük, várjon...", //ES_auto_detect_desc
	"A router nem tudja felismerni az internetkapcsolat típusát.", //ES_auto_detect_failed_desc
	"Szeretné hozzáadni a \"D-Link Router Web Management\" elemet a könyvjelzőkhöz?", //ES_bookmark
	"Próbálja újra", //ES_btn_try_again
	"Kérjük, dugja a routerral szállított és a tartozék részét képező Ethernet kábel egyik végét az INTERNET jelölésű portba a router hátoldalán. Csatlakoztassa a kábel másik végét a modem Ethernet portjába.", //ES_cable_lost_desc
	"2. lépés: Wi-Fi biztonság konfigurálása", //ES_step_wifi_security
	"3. lépés: Jelszó beállítása", //ES_title_s3
	"4. lépés: Időzóna kiválasztása", //ES_title_s4
	"5. lépés: Beállítások mentése", //ES_title_s5
	"5. lépés: Wi-Fi beállítások megerősítése", //ES_title_s5_0
	"6. lépés: MYDLINK regisztráció", //ES_title_s6
	"MYDLINK regisztráció", //ES_title_s6_myd
	"1. lépés: Internetkapcsolat konfigurálása", //ES_wwa_title_s1
	"Érvénytelen DHCP-kliens név", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Érvénytelen DHCP+ jelszó", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Érvénytelen DHCP+ felhasználónév", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"L2TP felhasználónevet KELL megadnia", //GW_WAN_L2TP_USERNAME_INVALID
	"PPTP jelszót KELL megadnia", //GW_WAN_PPTP_PASSWORD_INVALID
	"Érvénytelen hálózati kulcs!", //IPV6_TEXT2
	"Érvénytelen MAC-cím", //KR3
	"Automatikus (WPA vagy WPA2) - Személyes", //KR48
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
	"A termék regisztrálásával a mydlink-nél használni tudja a mydlink funkciókat, beleértve az eszközhöz való online hozzáférést és annak kezelését a mydlink weboldalon keresztül.", //mydlink_tx01
	"Szeretné regisztrálni eszközét a mydlink-nél?", //mydlink_tx02
	"Kérjük, adjon meg egy felhasználónevet.", //PPP_USERNAME_EMPTY
	"PPPoE Plus támogatva", //pppoe_plus_dail
	"A jelszó csak nyomtatható karaktereket tartalmazhat.", //S493
	"BEÁLLÍTÁSOK MENTÉSE", //save_settings
	"Az Ön beállításainak mentésére kerül sor. ", //save_wait
	"Firmware verzió", //sd_FWV
	"Terméklap", //TA2
	"Hardver verzió", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway-szigetek, Szamoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-10:00) Alaszka", //up_tz_03
	"(GMT-08:00) Pacific Time (USA/Kanada);Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (USA/Kanada)", //up_tz_06
	"(GMT-06:00) Közép-Amerika", //up_tz_07
	"(GMT-06:00) Central Time (USA/Kanada)", //up_tz_08
	"(GMT-06:00) Mexikóváros", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (USA/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (Kelet)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Új-Foundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grönland", //up_tz_20
	"(GMT-02:00) Közép-Atlanti-óceán", //up_tz_21
	"(GMT-01:00) Azori-szigetek", //up_tz_22
	"(GMT-01:00) Zöld-foki-szigetek", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich-i idő: Dublin, Edinburgh, Lisszabon, London", //up_tz_25
	"(GMT+01:00) Amszterdam, Berlin, Bern, Róma, Stockholm", //up_tz_26
	"(GMT+01:00) Belgrád, Pozsony, Ljubljana", //up_tz_27
	"(GMT+01:00) Brüsszel, Koppenhága, Madrid, Párizs", //up_tz_28
	"(GMT+01:00) Szarajevó, Szkopje, Szófia, Vilnius, Zágráb", //up_tz_29
	"(GMT+01:00) Budapest, Bécs, Prága, Varsó", //up_tz_29b
	"(GMT+01:00) Nyugat-Közép-Afrika", //up_tz_30
	"(GMT+02:00) Athén, Isztambul, Minszk", //up_tz_31
	"(GMT+02:00) Bukarest", //up_tz_32
	"(GMT+02:00) Kairó", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jeruzsálem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuvait, Rijád", //up_tz_38
	"(GMT+04:00) Moszkva, Szentpétervár, Volgográd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teherán", //up_tz_41
	"(GMT+04:00) Abu-Dzabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbiliszi, Jereván", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekatyerinburg", //up_tz_45
	"(GMT+05:00) Iszlámábád, Karacsi, Taskent", //up_tz_46
	"(GMT+05:30) Kalkutta, Chennai, Bombay, Új-Delhi", //up_tz_47
	"(GMT+05:45) Katmandu", //up_tz_48
	"(GMT+06:00) Novoszibirszk", //up_tz_49
	"(GMT+06:00) Astana, Dakka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangun", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasznojarszk", //up_tz_54
	"(GMT+08:00) Peking, Chongqing, Hong Kong, Urumucsi", //up_tz_55
	"(GMT+09:00) Irkutszk, Ulánbátor", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Szingapúr", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Tajpej", //up_tz_59
	"(GMT+09:00) Oszaka, Sapporo, Tokió", //up_tz_60
	"(GMT+09:00) Szöul", //up_tz_61
	"(GMT+10:00) Jakutszk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vlagyivosztok", //up_tz_69
	"(GMT+11:00) Salamon-szigetek, Új-Kaledónia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fidzsi, Kamcsatka, Marshall-szigetek", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"DNS-beállítások", //wwa_dnsset
	"Átjárócím", //wwa_gw
	"Alapértelmezetten az új D-Link routernek nincs konfigurált jelszava a rendszergazda web alapú konfigurációs oldalakhoz való hozzáféréséhez. Az új hálózati eszköz bebiztosításához kérjük, adja meg és hitelesítse a lenti jelszót, a CAPTCHA grafikai hitelesítés pedig további biztonsági védelmet nyújt, hogy a jogosulatlan online felhasználók és kártékony szoftverek ne tudjanak hozzáférni a hálózati beállításokhoz.", //wwa_intro_s1
	"Válassza ki az Ön helyének megfelelő időzónát. Ez az információ a router idő alapú opcióinak konfigurálásához szükséges.", //wwa_intro_s2
	"Kérjük, lentebb válassza ki internetkapcsolata típusát:", //wwa_intro_s3
	"Ez a varázsló lépésről lépésre végigvezeti Önt az új D-Link router konfigurálási folyamatán és internethez való csatlakozáson. ", //wwa_intro_wel
	"L2TP-kiszolgáló IP-címe (lehet ugyanaz mint az átjáró)", //wwa_l2tp_svra
	"Válassza ezt a lehetőséget, ha internetkapcsolata automatikusan szolgál IP-címmel. A legtöbb kábelmodem ezt a csatlakozási típust használja.", //wwa_msg_dhcp
	"Amennyiben az Ön internetszolgáltatója nincs az alábbi listán vagy nem tudja a nevét, válassza ki az alábbi internetkapcsolat típusát:", //wwa_msg_ispnot
	"Válassza ezt az opciót, ha internetkapcsolatának felhasználónévre és jelszóra van szüksége a kapcsolódáshoz. A legtöbb DSL modem ezt a csatlakozási típust használja.", //wwa_msg_pppoe
	"PPTP kliens", //wwa_msg_pptp
	"A kapcsolat beállításához bizonyosodjon meg arról, hogy az eredetileg szélessávú kapcsolathoz csatlakoztatott számítógép csatlakozik a D-Link routerhez. Amennyiben igen, kattintson a Klón MAC gombra a számítógép MAC-címének átmásolásához a D-Link routerbe.", //wwa_msg_set_dhcp
	"Ezen kapcsolat beállításához kérnie kell internetszolgáltatójától Felhasználónevet és Jelszót. Amennyiben nem rendelkezik ezzel az információval, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_msg_set_pppoe
	"Ezen kapcsolat beállításához kérnie kell internetszolgáltatójától Felhasználónevet és Jelszót. Szüksége van PPTP IP-címre is. Amennyiben nem rendelkezik ezzel az információval, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_msg_set_pptp
	"Ezt az opciót akkor válassza, ha internetszolgáltatója manuálisan konfigurálandó IP-cím információkkal szolgált Önnek.", //wwa_msg_sipa
	"Megjegyzés: Lehet, hogy meg kell adnia az Állomásnevet is. Amennyiben nem rendelkezik vagy nem ismeri ezt az információt, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_note_hostname
	"Elsődleges DNS cím", //wwa_pdns
	"PPTP-kiszolgáló IP-címe (lehet ugyanaz mint az átjáró)", //wwa_pptp_svraddr
	"Másodlagos DNS cím", //wwa_sdns
	"Nincs a listán vagy nem tudom", //wwa_selectisp_not
	"Felhasználónév és Jelszó kapcsolódás (L2TP) beállítása", //wwa_set_l2tp_title
	"A kapcsolat beállításához szüksége lesz a teljes IP-listára internetszolgáltatójától. Ha Állandó IP-kapcsolata van és nem rendelkezik ezzel az információval, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_set_sipa_msg
	"Állandó IP-című kapcsolat beállítása", //wwa_set_sipa_title
	"BigPond kábeles kapcsolat beállítása", //wwa_title_set_bigpond
	"Felhasználónév és Jelszó kapcsolódás (PPPoE) beállítása", //wwa_title_set_pppoe
	"Felhasználónév és Jelszó kapcsolódás (PPTP) beállítása", //wwa_title_set_pptp
	"Üdvözli Önt a D-Link Telepítő varázsló", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Felhasználónév / Jelszó kapcsolódás (L2TP)", //wwa_wanmode_l2tp
	"Felhasználónév / Jelszó kapcsolódás (PPPoE)", //wwa_wanmode_pppoe
	"Felhasználónév / Jelszó kapcsolódás (PPTP)", //wwa_wanmode_pptp
	"Állandó IP-cím kapcsolat", //wwa_wanmode_sipa
	"Adjon a Wi-Fi hálózatnak egy nevet.", //wwz_wwl_intro_s2_1
	"Wi-Fi hálózat neve (SSID)", //wwz_wwl_intro_s2_1_1
	"(Legfeljebb 32 karakter)", //wwz_wwl_intro_s2_1_2
	"Adjon a Wi-Fi hálózatnak egy jelszót.", //wwz_wwl_intro_s2_2
	"Wi-Fi jelszó", //wwz_wwl_intro_s2_2_1
	"(8 és 63 karakter között)", //wwz_wwl_intro_s2_2_2
	"Adja meg hálózata nevét, legfeljebb 32 karakterben.", //wwz_wwl_intro_s3_1
	"1. lépés: Üdvözli Önt a D-LINK VEZETÉK NÉLKÜLI BIZTONSÁG TELEPÍTŐ VARÁZSLÓ", //wwz_wwl_title_s3
	"Érvénytelen PPTP-kiszolgáló IP-cím", //YM108
	"Ugyanannak a Vezeték nélküli biztonsági jelszónak a használata 2,4 GHz-es és 5 GHz-es sávon.", //wwl_SSP
	"Adjon a Wi-Fi hálózatnak egy nevet és egy jelszót.", //wwz_wwl_intro_s0
	"A(z) %s 1. címének egész számnak kell lennie.", //MSG002
	"A(z) %s 2. címének egész számnak kell lennie.", //MSG003
	"A(z) %s 3. címének egész számnak kell lennie.", //MSG004
	"A(z) %s 4. címének egész számnak kell lennie.", //MSG005
	"A(z) %s érvénytelen cím.", //MSG006
	"A(z) %s nem lehet nulla.", //MSG007
	"A(z) megadott %s port érvénytelen.", //MSG008
	"A megadott %s titok érvénytelen.", //MSG009
	"A(z) %s nem engedi a visszacsatolási IP vagy multicast IP bevitelét (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Kérjük, adjon meg másik %s értéket.", //MSG012
	"A(z) %s értékének számnak kell lennie!", //MSG013
	"A(z) %s tartományának %1n és %2n között kell lennie.", //MSG014
	"A(z) %s értékének páros számnak kell lennie.", //MSG015
	"A Kulcs érvénytelen. A Kulcsnak 5 vagy 10 karakterből álló hexadecimális számjegynek kell lennie. Amit beírt:", //MSG016
	"A Kulcs érvénytelen. A Kulcsnak 13 vagy 26 karakterből álló hexadecimális számjegynek kell lennie. Amit beírt:", //MSG017
	"A(z) %s 1. címének hexadecimálisnak kell lennie.", //MSG018
	"A(z) %s 2. címének hexadecimálisnak kell lennie.", //MSG019
	"A(z) %s 3. címének hexadecimálisnak kell lennie.", //MSG020
	"A(z) %s 4. címének hexadecimálisnak kell lennie.", //MSG021
	"A(z) %s 5. címének hexadecimálisnak kell lennie.", //MSG022
	"A(z) %s 6. címének hexadecimálisnak kell lennie.", //MSG023
	"A(z) %s 7. címének hexadecimálisnak kell lennie.", //MSG024
	"A(z) %s 8. címének hexadecimálisnak kell lennie.", //MSG025
	"A(z) %s 1. tartományának a következők között kell lennie:", //MSG026
	"A(z) %s 2. tartományának a következők között kell lennie:", //MSG027
	"A(z) %s 3. tartományának a következők között kell lennie:", //MSG028
	"A(z) %s 4. tartományának a következők között kell lennie:", //MSG029
	"A(z) %s 5. tartományának a következők között kell lennie:", //MSG030
	"A(z) %s 6. tartományának a következők között kell lennie:", //MSG031
	"A(z) %s 7. tartományának a következők között kell lennie:", //MSG032
	"A(z) %s 8. tartományának a következők között kell lennie:", //MSG033
	"A(z) nem engedélyez bevitelt visszacsatolási IP-be ( ::1 ).", //MSG034
	"A(z) %s nem engedélyez bevitelt multicast IP-be ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"Érvénytelen mértékegység", //MSG043
	"A mértékegység értékének (1..16) között kell lennie.", //ar_alert_3
	"Érvénytelen hálózati maszk.", //ar_alert_5
	"A Kulcs", //TEXT042_1
	" rossz, a használható karakterek: 0~9, A~F vagy a~f.", //TEXT042_2
	"Megjegyzés: Lehet, hogy meg kell adnia a Szolgáltatás nevét is. Amennyiben nem rendelkezik vagy nem ismeri ezt az információt, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_note_svcn
	"L2TP-kliens", //wwa_msg_l2tp
	"Ezen kapcsolat beállításához kérnie kell internetszolgáltatójától Felhasználónevet és Jelszót. Szüksége van L2TP IP-címre is. Amennyiben nem rendelkezik ezzel az információval, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_set_l2tp_msg
	"Ezen kapcsolat beállításához kérnie kell internetszolgáltatójától Felhasználónevet és Jelszót. Szüksége van a BigPond kiszolgáló IP-címére is. Amennyiben nem rendelkezik ezzel az információval, vegye fel a kapcsolatot internetszolgáltatójával.", //wwa_msg_set_bigpond
	"Állomásnév", //_hostname
	"2,4 GHz sáv", //GW_WLAN_RADIO_0_NAME
	"5 GHz sáv", //GW_WLAN_RADIO_1_NAME
	"Lentebb a Wi-Fi biztonsági beállítások összegzését nézheti meg. Kérjük, nyomtassa ki ezt az oldalt vagy írja le az információkat egy papírra, hogy konfigurálhassa a helyes beállításokat a Wi-Fi eszközökön.", //wwl_intro_end
	"Kérjük, várjon...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Kapcsolódás", //_connect
	"Vezess át az Internetkapcsolat beállításain", //ES_btn_guide_me
	"Grafikus hitelesítés engedélyezése", //_graph_auth
	"D-LINK CORPORATION, INC | VEZETÉK NÉLKÜLI ROUTER | KEZDŐLAP", //TEXT000
	"Meg kell adnia egy L2TP-jelszót", //GW_WAN_L2TP_PASSWORD_INVALID
	"Nem észlelhető internet, újraindítja a varázslót?", //mydlink_tx03
	"Az adminisztrátori jelszó nem lehet üres.", //mydlink_tx04
	"WAN kapcsolat ellenőrzése.", //mydlink_tx05
	"másodperc van hátra.", //sec_left
	"Újra", //_retry
	"Van mydlink fiókja?", //mydlink_tx06
	"Igen, van mydlink fiókom.", //mydlink_tx07
	"Nem, szeretnék regisztrálni és belépni egy új mydlink fiókba.", //mydlink_tx08
	"E-mail cím (fióknév)", //mydlink_tx09
	"Kérjük, írja be az adatokat a regisztráció befejezéséhez.", //mydlink_tx10
	"Jelszó megerősítése", //chk_pass
	"Családi név", //Lname
	"Utónév", //Fname
	"Elfogadom a mydlink általános feltételeit.", //mydlink_tx12
	"A mydlink regisztráció befejezéséhez kérjük, ellenőrizze a Bejövő postafiókját, ahova egy e-mailt küldtünk a megerősítési utasításokkal.", //mydlink_tx13_1
	" Az e-mail cím megerősítését követően kattintson a Belépés gombra.", //mydlink_tx13_2
	"Belépés", //_login
	"Ok", //_ok
	"Mentés", //_save
	"Kérjük, írja át a két jelszót egyformára, majd próbálja újra.", //_pwsame
	"A  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> funkcióinak és a mydlink Lite alkalmazás használatához szüksége lesz egy fiók létrehozására a <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a> weboldalon. ", //mydlink_reg_into_1
	"Ha már rendelkezik fiókkal, válassza az <strong>Igen, van mydlink fiókom.</strong> lehetőséget és kattintson a Tovább gombra a router regisztrálásához a <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a> weboldalon. ", //mydlink_reg_into_2
	"Ha nem rendelkezik fiókkal, válassza a <strong>Nem, szeretnék regisztrálni és belépni egy új mydlink fiókba.</strong> lehetőséget, majd kattintson a Tovább gombra egy új fiók létrehozásához. ", //mydlink_reg_into_3
	" Ha nem szeretne feliratkozni a mydlink szolgáltatásra, kattintson a Mégse gombra.", //mydlink_reg_into_4_a
	"Ennek az e-mail címnek már van mydlink fiókja. Próbálja meg egy másik e-mail címmel.", //mydlink_pop_01
	"A folytatáshoz el kell fogadnia az általános feltételeket.", //mydlink_pop_02
	"nem lehet üres.", //mydlink_pop_03
	"érvénytelen.", //mydlink_pop_04
	"Most már használhatja a mydlink szolgáltatást ezzel az eszközzel", //mydlink_pop_05
	"Belépés sikertelen", //mydlink_pop_06
	"regisztrálj", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"A mydlink regisztrációt követően a router alapértelmezett PPPoE, L2TP és PPTP kapcsolata Mindig be értékre lesz állítva. Amennyiben az Ön internetszolgáltatója számláz a használatért, lehet, hogy manuálisan kell kiválasztania az Igény szerinti tárcsázás lehetőséget alapértelmezett beállításnak.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"PPPoE jelszót KELL megadnia", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Átugorja", //_skip
	" Ha nem akar feliratkozni a mydlink szolgáltatásra, kérjük, kattintson az Átugorja gombra.", //mydlink_reg_into_4
	"Wi-Fi beállítás mentése", //mydlink_WiFi_save
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
