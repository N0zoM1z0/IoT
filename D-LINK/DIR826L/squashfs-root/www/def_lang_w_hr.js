//Version=1.01b02
//Language=Croatian
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Odustani", //_cancel
	"Kopiraj MAC adresu računala", //_clone
	"DHCP veza (dinamička IP adresa)", //_dhcpconn
	"IP adresa", //_ipaddr
	"L2TP", //_L2TP
	"L2TP IP adresa mrežnog prolaza", //_L2TPgw
	"IP adresa L2TP poslužitelja", //_L2TPip
	"Maska L2TP podmreže", //_L2TPsubnet
	"Jezik", //_Language
	"MAC adresa", //_macaddr
	"Sljedeće", //_next
	"Ne", //_no
	"(opcijski)", //_optional
	"Zaporka", //_password
	"PPTP IP adresa mrežnog prolaza", //_PPTPgw
	"IP adresa PPTP poslužitelja", //_PPTPip
	"Maska PPTP podmreže", //_PPTPsubnet
	"Preth.", //_prev
	"Upišite dvije jednake administratorske zaporke i pokušajte ponovno.", //_pwsame_admin
	"Statička IP adresa", //_sdi_staticip
	"Maska podmreže", //_subnet
	"Korisničko ime", //_username
	"Potvrdite zaporku", //_verifypw
	"Želite li odbaciti sve promjene koje ste napravili u ovom čarobnjaku?", //_wizquit
	"Da", //_yes
	"Nevaljana IP adresa L2TP poslužitelja", //bwn_alert_17
	"Način adrese", //bwn_AM
	"BigPond poslužitelj", //bwn_BPS
	"TKIP i AES", //bws_CT_3
	"Dinamička IP adresa", //carriertype_ct_0
	"Usmjernik otkriva vrstu vaše internetske veze. Pričekajte...", //ES_auto_detect_desc
	"Usmjernik ne može otkriti vrstu vaše internetske veze.", //ES_auto_detect_failed_desc
	"Želite li dodati knjižnu oznaku za \"D-Link Router Web Management\"?", //ES_bookmark
	"Pokušajte ponovo", //ES_btn_try_again
	"Jedan kraj Ethernet kabela koji ste dobili s usmjernikom priključite na priključnicu s oznakom INTERNET na poleđini usmjernika,  a drugi kraj kabela priključite na Ethernet port modema.", //ES_cable_lost_desc
	"2. korak: konfigurirajte mreže zaštitu Wi-Fi mreže", //ES_step_wifi_security
	"3. korak: postavite zaporku", //ES_title_s3
	"4. korak: odaberite vremensku zonu", //ES_title_s4
	"5. korak: spremite postavke", //ES_title_s5
	"5. korak: potvrdite WI-FI postavke", //ES_title_s5_0
	"6. korak: MYDLINK registracija", //ES_title_s6
	"MYDLINK registracija", //ES_title_s6_myd
	"1. korak: konfigurirajte internetsku vezu", //ES_wwa_title_s1
	"Naziv DHCP klijenta nije valjan", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"DHCP+ zaporka nije valjana", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"DHCP+ korisničko ime nije valjano", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"MORATE navesti L2TP korisničko ime", //GW_WAN_L2TP_USERNAME_INVALID
	"MORATE navesti PPTP zaporku", //GW_WAN_PPTP_PASSWORD_INVALID
	"Mrežni ključ nije valjan!", //IPV6_TEXT2
	"Nevaljana MAC adresa", //KR3
	"Automatski (WPA ili WPA2) - osobni", //KR48
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
	"Registriranje proizvoda na servisu mydlink omogućit će vam da koristite značajke povezane sa servisom mydlink, uključujući mrežni pristup i upravljanje uređajem putem web-mjesta mydlink.", //mydlink_tx01
	"Želite li registrirati uređaj na servisu mydlink?", //mydlink_tx02
	"Unesite korisničko ime.", //PPP_USERNAME_EMPTY
	"Podrška za PPPoE Plus", //pppoe_plus_dail
	"Zaporka može sadržavati samo ispisive znakove.", //S493
	"SPREMANJE POSTAVKI", //save_settings
	"Vaše su postavke spremljene.", //save_wait
	"Inačica firmvera", //sd_FWV
	"Stranica proizvoda", //TA2
	"Hardverska inačica", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Otok Midway, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Aljaska", //up_tz_03
	"(GMT-08:00) Pacifičko vrijeme (SAD/Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Planinsko vrijeme (SAD/Kanada)", //up_tz_06
	"(GMT-06:00) Srednjeameričko vrijeme", //up_tz_07
	"(GMT-07:00) Središnje vrijeme (SAD/Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Istočno vrijeme (SAD/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (istok)", //up_tz_13
	"(GMT-07:00) Atlantsko vrijeme (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brazilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grenland", //up_tz_20
	"(GMT-02:00) Srednjeatlantsko vrijeme", //up_tz_21
	"(GMT-01:00) Azori", //up_tz_22
	"(GMT-01:00) Zelenortski otoci", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich: Dublin, Edinburgh, Lisabon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rim, Stockholm", //up_tz_26
	"(GMT+01:00) Beograd, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Bruxelles, Kopenhagen, Madrid, Pariz", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budimpešta, Beč, Prag, Varšava", //up_tz_29b
	"(GMT+01:00) Zapad središnje Afrike", //up_tz_30
	"(GMT+02:00) Atena, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukurešt", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jeruzalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moskva, St. Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Erevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karači, Taškent", //up_tz_46
	"(GMT+05:30) Kolkata, Chennai, Mumbaj, New Delhi", //up_tz_47
	"(GMT+05:45) Katmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Daka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Džakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Peking, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulan Bator", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Seoul", //up_tz_61
	"(GMT+10:00) Jakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Solomonovi otoci, Nova Kaledonija", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamčatka, Maršalovi otoci", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"DNS postavke", //wwa_dnsset
	"Adresa mrežnog prolaza", //wwa_gw
	"Vaš novi D-Link usmjernik nema zadanu zaporku za administratorski pristup web-stranicama za konfiguraciju. Da biste zaštitili svoj novi mrežni uređaj, postavite i potvrdite zaporku dolje. Omogućivanjem grafičke provjere autentičnosti CAPTCHA osigurana je dodatna zaštita kojom se neovlaštenim mrežnim korisnicima i hakerskim programima sprečava pristup vašim mrežnim postavkama.", //wwa_intro_s1
	"Odaberite odgovarajuću vremensku zonu za vaše područje. Taj podatak potreban je za konfiguriranje funkcija usmjernika koje se temelje na vremenu.", //wwa_intro_s2
	"Odaberite vrstu internetske veze:", //wwa_intro_s3
	"Čarobnjak će vas voditi kroz detaljan postupak konfiguriranja novog D-Link usmjernika i povezivanja s internetom.", //wwa_intro_wel
	"IP adresa L2TP poslužitelja (može biti ista kao i adresa mrežnog prolaza)", //wwa_l2tp_svra
	"To odaberite ako vaša internetska veza automatski dodjeljuje IP adresu Većina kabelskih modema koristi tu vrstu veze.", //wwa_msg_dhcp
	"Ako se vaš pružatelj internetskih usluga ne nalazi na popisu ili vam nije poznat, odaberite vrstu internetske veze:", //wwa_msg_ispnot
	"Tu opciju odaberite ako vaša internetska veza zahtijeva korisničko ime i zaporku za povezivanje s internetom. Većina DSL modema koristi tu vrstu veze.", //wwa_msg_pppoe
	"PPTP klijent.", //wwa_msg_pptp
	"Da biste uspostavili tu vrstu veze, D-Link usmjernik trebate povezati s računalom koje je izvorno povezano na vašu širokopojasnu vezu. Ako je to slučaj, kliknite gumb Kloniraj MAC adresu kako biste kopirali MAC adresu računala na D-Link usmjernik.", //wwa_msg_set_dhcp
	"Da biste uspostavili tu vrstu veze trebate zatražiti korisničko ime i zaporku od svog pružatelja internetskih usluga. Ako taj podatak nemate, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_msg_set_pppoe
	"Da biste uspostavili tu vrstu veze trebate zatražiti korisničko ime i zaporku od svog pružatelja internetskih usluga. Trebat će vam i PPTP IP adresa. Ako taj podatak nemate, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_msg_set_pptp
	"Tu opciju odaberite ako vam je pružatelj internetskih usluga (ISP) dodijelio IP adresu koju trebate ručno konfigurirati.", //wwa_msg_sipa
	"Napomena: Možda ćete također trebati upisati naziv glavnog računala. Ako nemate ili ne znate taj podatak, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_note_hostname
	"Primarna DNS adresa", //wwa_pdns
	"IP adresa PPTP poslužitelja (može biti ista kao i adresa mrežnog prolaza)", //wwa_pptp_svraddr
	"Sekundarna DNS adresa", //wwa_sdns
	"Nije na popisu ili je nepoznata", //wwa_selectisp_not
	"Postavite vezu sa korisničkim imenom i zaporkom (L2TP)", //wwa_set_l2tp_title
	"Da biste uspostavili tu vrstu veze, trebate zatražiti potpuni popis IP informacija od svog pružatelja internetskih usluga. Ako imate vezu sa statičkom IP adresom i nemate te podatke, obratite se svom ISP-u.", //wwa_set_sipa_msg
	"Postavite vezu sa statičkom IP adresom", //wwa_set_sipa_title
	"Postavite BigPond kabelsku vezu", //wwa_title_set_bigpond
	"Postavite vezu sa korisničkim imenom i zaporkom (PPPoE)", //wwa_title_set_pppoe
	"Postavite vezu sa korisničkim imenom i zaporkom (PPTP)", //wwa_title_set_pptp
	"Dobro došli u D-Link čarobnjak za postavljanje", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Veza s korisničkim imenom / zaporkom (L2TP)", //wwa_wanmode_l2tp
	"Veza s korisničkim imenom / zaporkom (PPPoE)", //wwa_wanmode_pppoe
	"Veza s korisničkim imenom / zaporkom (PPTP)", //wwa_wanmode_pptp
	"Veza sa statičkom IP adresom", //wwa_wanmode_sipa
	"Odredite naziv za svoju Wi-Fi mrežu.", //wwz_wwl_intro_s2_1
	"Naziv Wi-Fi mreže (SSID)", //wwz_wwl_intro_s2_1_1
	"(do 32 znaka)", //wwz_wwl_intro_s2_1_2
	"Odredite zaporku za svoju Wi-Fi mrežu.", //wwz_wwl_intro_s2_2
	"Wi-Fi zaporka", //wwz_wwl_intro_s2_2_1
	"(između 8 i 63 znaka)", //wwz_wwl_intro_s2_2_2
	"Dodijelite naziv mreži koji treba sadržavati do 32 znaka.", //wwz_wwl_intro_s3_1
	"1. korak: DOBRO DOŠLI U D-LINK ČAROBNJAK ZA POSTAVLJANJE ZAŠTITE BEŽIČNE MREŽE", //wwz_wwl_title_s3
	"Nevaljana IP adresa PPTP poslužitelja", //YM108
	"Koristite istu sigurnosnu zaporku za bežičnu mrežu za frekvencijski pojas od 2,4 GHz i 5 GHz.", //wwl_SSP
	"Odredite naziv i zaporku za svoju Wi-Fi mrežu.", //wwz_wwl_intro_s0
	"Prva adresa %s mora biti cijeli broj.", //MSG002
	"Druga adresa %s mora biti cijeli broj.", //MSG003
	"Treća adresa %s mora biti cijeli broj.", //MSG004
	"Četvrta adresa %s mora biti cijeli broj.", //MSG005
	"%s nije valjana adresa.", //MSG006
	"%s ne smije biti nula.", //MSG007
	"Uneseni %s port nije valjan.", //MSG008
	"Uneseni tajni ključ za %s nije valjan.", //MSG009
	"%s ne može dopustiti unos za povratne (loopback) IP ili višeodredišne IP adrese (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Unesite drugu vrijednost za %s.", //MSG012
	"Vrijednost za %s mora biti numerička!", //MSG013
	"Raspon za %s je %1n ~ %2n.", //MSG014
	"Vrijednost za %s mora biti parni broj!", //MSG015
	"Ključ nije valjan. Ključ mora sadržavati 5 ili 10 heksadecimalnih brojeva. Unijeli ste", //MSG016
	"Ključ nije valjan. Ključ mora sadržavati 13 ili 26 heksadecimalnih brojeva. Unijeli ste", //MSG017
	"Prva adresa %s mora biti heksadecimalni broj.", //MSG018
	"Druga adresa %s mora biti heksadecimalni broj.", //MSG019
	"Treća adresa %s mora biti heksadecimalni broj.", //MSG020
	"Četvrta adresa %s mora biti heksadecimalni broj.", //MSG021
	"Peta adresa %s mora biti heksadecimalni broj.", //MSG022
	"Šesta adresa %s mora biti heksadecimalni broj.", //MSG023
	"Sedma adresa %s mora biti heksadecimalni broj.", //MSG024
	"Osma adresa %s mora biti heksadecimalni broj.", //MSG025
	"Prvi raspon za %s mora biti između", //MSG026
	"Drugi raspon za %s mora biti između", //MSG027
	"Treći raspon za %s mora biti između", //MSG028
	"Četvrti raspon za %s mora biti između", //MSG029
	"Peti raspon za %s mora biti između", //MSG030
	"Šesti raspon za %s mora biti između", //MSG031
	"Sedmi raspon za %s mora biti između", //MSG032
	"Osmi raspon za %s mora biti između", //MSG033
	"%s ne može dopustiti unos za povratne (loopback) IP adrese ( ::1 ).", //MSG034
	"%s ne može dopustiti unos za višeodredišne IP adrese (FFxx:0:0:0:0:0:0:2 ili ffxx:0:0:0:0:0:0:2.", //MSG035
	"Metrika nije valjana", //MSG043
	"Metrička vrijednost mora biti između (1..16).", //ar_alert_3
	"Nevaljana mrežna maska.", //ar_alert_5
	"Ključ", //TEXT042_1
	" nije točan; dopušteni su znakovi 0~9, A~F ili a~f.", //TEXT042_2
	"Napomena: Možda ćete također trebati upisati naziv servisa. Ako nemate ili ne znate taj podatak, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_note_svcn
	"L2TP klijent.", //wwa_msg_l2tp
	"Da biste uspostavili tu vrstu veze trebate zatražiti korisničko ime i zaporku od svog pružatelja internetskih usluga. Trebat će vam i L2TP IP adresa. Ako taj podatak nemate, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_set_l2tp_msg
	"Da biste uspostavili tu vrstu veze trebate zatražiti korisničko ime i zaporku od svog pružatelja internetskih usluga. Trebat će vam i IP adresa BigPond poslužitelja. Ako taj podatak nemate, zatražite ga od pružatelja internetskih usluga (ISP).", //wwa_msg_set_bigpond
	"Naziv glavnog računala", //_hostname
	"2,4GHz frekvencijski pojas", //GW_WLAN_RADIO_0_NAME
	"5GHz frekvencijski pojas", //GW_WLAN_RADIO_1_NAME
	"Dolje se nalazi detaljan sažetak sigurnosnih postavki vaše Wi-Fi mreže. Molimo, ispišite ovu stranicu ili zapišite podatke na list papira kako biste mogli konfigurirati točne postavke na svojim Wi-Fi uređajima.", //wwl_intro_end
	"Pričekajte...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Poveži", //_connect
	"Vodi me kroz upute za postavljanje internetske veze", //ES_btn_guide_me
	"Omogući grafičku provjeru autentičnosti", //_graph_auth
	"D-LINK CORPORATION, INC | BEŽIČNI USMJERNIK | POČETNA", //TEXT000
	"MORATE navesti L2TP zaporku", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internetska veza nije otkrivena. Želite li ponovno pokrenuti čarobnjak?", //mydlink_tx03
	"Polje administratorske zaporke ne smije biti prazno.", //mydlink_tx04
	"Provjera WAN povezivosti.", //mydlink_tx05
	"sekundi preostalo.", //sec_left
	"Ponovi", //_retry
	"Imate li račun za mydlink?", //mydlink_tx06
	"Da, imam račun za mydlink.", //mydlink_tx07
	"Ne, želim se registrirati i prijaviti s novim računom za mydlink.", //mydlink_tx08
	"Adresa e-pošte (naziv računa)", //mydlink_tx09
	"Ispunite potrebna polja da biste dovršili registraciju.", //mydlink_tx10
	"Potvrdi zaporku", //chk_pass
	"Prezime", //Lname
	"Ime", //Fname
	"Prihvaćam mydlink uvjete i odredbe.", //mydlink_tx12
	"Da biste dovršili mydlink registraciju, u pretincu dolaznih poruka potražite poruku s uputama za potvrdu.", //mydlink_tx13_1
	" Nakon što potvrdite adresu e-pošte, kliknite gumb Prijava.", //mydlink_tx13_2
	"Prijava", //_login
	"U redu", //_ok
	"Spremi", //_save
	"Upišite dvije jednake zaporke i pokušajte ponovno.", //_pwsame
	"Za korištenje značajki servisa <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> i mydlink Lite aplikacije treba vam račun za <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Ako već imate račun, odaberite <strong>Da, imam račun za mydlink</strong> pa kliknite Sljedeće kako biste registrirali usmjernik na servisu <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Ako nemate račun, odaberite <strong>Ne, želim se registrirati i prijaviti s novim računom za mydlink</strong> pa kliknite Sljedeće kako biste stvorili račun. ", //mydlink_reg_into_3
	" Ako se ne želite registrirati na servis mydlink, odaberite Odustani.", //mydlink_reg_into_4_a
	"Ova adresa e-pošte već ima račun za mydlink. Pokušajte s drugom adresom e-pošte.", //mydlink_pop_01
	"Za nastavak morate prihvatiti odredbe i uvjete.", //mydlink_pop_02
	"ne smije biti prazno.", //mydlink_pop_03
	"nije valjana.", //mydlink_pop_04
	"Sada možete koristiti servis mydlink s ovim uređajem", //mydlink_pop_05
	"Prijava nije uspjela", //mydlink_pop_06
	"prijavite se", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Nakon registracije na mydlink zadana PPPoE, L2TP, PPTP veza vašeg usmjernika bit će postavljena na ''Uvijek uključeno''. Ako vaš pružatelj internetskih usluga (ISP) naplaćuje troškove uporabe, možda biste trebali ručno postaviti ''Biranje na zahtjev'' kao zadanu postavku.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"MORATE navesti PPPoE zaporku", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Preskoči", //_skip
	" Ako se ne želite registrirati na servis mydlink, odaberite Preskoči.", //mydlink_reg_into_4
	"Spremanje WI-Fi postavki", //mydlink_WiFi_save
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
