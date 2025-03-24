//Version=1.03b02
//Language=Finnish
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Peruuta", //_cancel
	"Kopioi tietokoneen MAC-osoite", //_clone
	"DHCP-yhteys (Dynaaminen IP-osoite)", //_dhcpconn
	"IP-osoite", //_ipaddr
	"L2TP", //_L2TP
	"L2TP-yhdyskäytävän IP-osoite", //_L2TPgw
	"L2TP-IP-osoite", //_L2TPip
	"L2TP-aliverkon peite", //_L2TPsubnet
	"Kieli", //_Language
	"MAC-osoite", //_macaddr
	"Seuraava", //_next
	"Ei", //_no
	"(valinnainen)", //_optional
	"Salasana", //_password
	"PPTP-yhdyskäytävän IP-osoite", //_PPTPgw
	"PPTP-IP-osoite", //_PPTPip
	"PPTP-aliverkon peite", //_PPTPsubnet
	"Edellinen", //_prev
	"Syötä sama järjestelmänvalvojan salasana kaksi kertaa ja yritä uudelleen.", //_pwsame_admin
	"Kiinteä IP-osoite", //_sdi_staticip
	"Aliverkon peite", //_subnet
	"Käyttäjätunnus", //_username
	"Vahvista salasana", //_verifypw
	"Haluatko peruuttaa kaikki tähän ohjelmaan tehdyt muutokset?", //_wizquit
	"Kyllä", //_yes
	"L2TP-palvelimen IP-osoite ei kelpaa", //bwn_alert_17
	"Osoitetila", //bwn_AM
	"BigPond-palvelin", //bwn_BPS
	"TKIP ja AES", //bws_CT_3
	"Dynaaminen IP", //carriertype_ct_0
	"Reititin tunnistaa Internet-yhteyden tyyppiä, odota ...", //ES_auto_detect_desc
	"Reititin ei pysty tunnistamaan Internet-yhteyden tyyppiä.", //ES_auto_detect_failed_desc
	"Haluatko lisätä \"D-Link Router Web Management\" -sivun kirjanmerkkeihin?", //ES_bookmark
	"Yritä uudelleen", //ES_btn_try_again
	"Kytke reitittimen mukana tulleen Ethernet-kaapelin toinen pää INTERNET-porttiin reitittimen takana. Kytke tämän kaapelin toinen pää modeemin Ethernet-porttiin ja käynnistä modeemi uudelleen.", //ES_cable_lost_desc
	"Vaihe 2: Määritä Wi-Fi-verkon turvallisuus", //ES_step_wifi_security
	"Vaihe 3: Aseta salasanasi", //ES_title_s3
	"Vaihe 4: Valitse aikavyöhyke", //ES_title_s4
	"Vaihe 5: Tallenna asetukset", //ES_title_s5
	"Vaihe 5: Vahvista WI-FI-asetukset", //ES_title_s5_0
	"Vaihe 6: MYDLINK-rekisteröinti", //ES_title_s6
	"MYDLINK-rekisteröinti", //ES_title_s6_myd
	"Vaihe 1: Määritä Internet-yhteytesi", //ES_wwa_title_s1
	"Virheellinen DHCP-asiakkaan nimi", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"DHCP+ salasana ei kelpaa", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"DHCP+ käyttäjätunnus ei kelpaa", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"L2TP-käyttäjätunnus on PAKOLLINEN", //GW_WAN_L2TP_USERNAME_INVALID
	"PPTP-salasana on PAKOLLINEN", //GW_WAN_PPTP_PASSWORD_INVALID
	"Virheellinen verkkoavain!", //IPV6_TEXT2
	"MAC-osoite ei kelpaa", //KR3
	"Automaattinen (WPA tai WPA2) - Henkilökohtainen", //KR48
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
	"Cox Communications", //manul_conn_25
	"Tuotteen rekisteröiminen mydlink-palveluun mahdollistaa mydlink-tuetut toiminnot kuten laitteen käytön ja hallinnan verkossa mydlink-sivuston kautta.", //mydlink_tx01
	"Haluatko rekisteröidä laitteesi mydlink-palveluun?", //mydlink_tx02
	"Anna käyttäjätunnus", //PPP_USERNAME_EMPTY
	"PPPoE Plus tuettu", //pppoe_plus_dail
	"Salasana voi sisältää vain tulostettavia merkkejä.", //S493
	"ASETUSTEN TALLENTAMINEN", //save_settings
	"Asetuksiasi tallennetaan.", //save_wait
	"Laiteohjelmiston versio", //sd_FWV
	"Tuotesivu", //TA2
	"Laiteversio", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway-saari, Samoa", //up_tz_01
	"(GMT-10:00) Havaiji", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Tyynenmeren aika (USA ja Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Kalliovuorten aika (USA ja Kanada)", //up_tz_06
	"(GMT-06:00) Väli-Amerikka", //up_tz_07
	"(GMT-06:00) Keskinen aikavyöhyke (USA ja Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Itäinen aikavyöhyke (USA ja Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (itä)", //up_tz_13
	"(GMT-04:00) Atlantin aika (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grönlanti", //up_tz_20
	"(GMT-02:00) Keski-Atlantti", //up_tz_21
	"(GMT-01:00) Atsorit", //up_tz_22
	"(GMT-01:00) Cape Verde", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwichin aika: Dublin, Edinburgh, Lissabon, Lontoo", //up_tz_25
	"(GMT+01:00) Amsterdam, Berliini, Bern, Rooma, Tukholma, Wien", //up_tz_26
	"(GMT+01:00) Belgrad, Bratislava, Budapest, Ljubljana, Praha", //up_tz_27
	"(GMT+01:00) Bryssel, Kööpenhamina, Madrid, Pariisi", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Wien, Praha, Varsova", //up_tz_29b
	"(GMT+01:00) Läntinen Keski-Afrikka", //up_tz_30
	"(GMT+02:00) Ateena, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukarest", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riika, Tallinna", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Baghdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moskova, Pietari, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Jerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Beijing, Chongqing, Hongkong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulan Bator", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapore", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Soul", //up_tz_61
	"(GMT+10:00) Jakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Salomonsaaret, Uusi-Kaledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fidži , Kamtšatka , Marshallinsaaret.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) Läntinen päiväraja", //up_tz_76
	"(GMT-11:00) Midway-saari", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Mexico City, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (itäinen)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Varsova, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kiova, Riika, Sofia, Tallinna, Vilna", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulan Bator", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"DNS-asetukset", //wwa_dnsset
	"Yhdyskäytävän osoite", //wwa_gw
	"Uudessa D-Link-reitittimessäsi ei oletusarvoisesti ole järjestelmänvalvojalle määritettyä salasanaa web-pohjaisten määrityssivujen käyttöä varten. Suojaa uusi verkkolaitteesi asettamalla ja vahvistamalla salasana alla. Graafisen CAPTCHA-todennuksen käyttöön otto antaa lisäsuojaa ja estää luvattomia käyttäjiä ja ohjelmistoja käyttämästä verkkoasetuksiasi.", //wwa_intro_s1
	"Valitse oikea aikavyöhyke sijaintisi mukaan. Nämä tiedot vaaditaan aikaan pohjautuvien asetusten määrittämiseksi. Reititin asetetaan päivittämään automaattisesti sisäisen kellonsa NTP-aikapalvelimesta.", //wwa_intro_s2
	"Valitse Internet-yhteyden tyyppi alla:", //wwa_intro_s3
	"Tämä ohjattu toiminto ohjaa sinut uuden D-Link-reitittimen määrityksen ja Internet-yhteyden muodostamisen vaiheiden läpi.", //wwa_intro_wel
	"L2TP-palvelimen IP-osoite (voi olla sama kuin yhdyskäytävä)", //wwa_l2tp_svra
	"Valitse tämä, jos Internet-yhteytesi antaa automaattisesti IP-osoitteen. Useimmat kaapelimodeemit käyttävät tämän tyyppistä yhteyttä.", //wwa_msg_dhcp
	"Jos Internet-palveluntarjoajaasi ei ole luettelossa tai et tiedä sitä, valitse alla oleva Internet-yhteystyyppi:", //wwa_msg_ispnot
	"Valitse tämä vaihtoehto, jos Internet-yhteytesi muodostamiseen vaaditaan käyttäjätunnus ja salasana. Useimmat DSL-modeemit käyttävät tämän tyyppistä yhteyttä.", //wwa_msg_pppoe
	"PPTP-palvelin.", //wwa_msg_pptp
	"Aseta tämä yhteys varmistamalla, että olet luonut yhteyden D-Link-reitittimeen tietokoneella, joka yhdistettiin alkuperäiseen laajakaistayhteyteen. Jos vastaus on kyllä, kopioi tietokoneesi MAC-osoite D-Link-reitittimeen napsauttamalla Kopioi MAC -painiketta.", //wwa_msg_set_dhcp
	"Tämän yhteyden asentamiseen tarvitaan Internet-palveluntarjoajalta saatu käyttäjätunnus ja salasana. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_msg_set_pppoe
	"Tämän yhteyden asentamiseen tarvitaan Internet-palveluntarjoajalta saatu käyttäjätunnus ja salasana. Tarvitset myös PPTP:n IP-osoitteen. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_msg_set_pptp
	"Valitse tämä valinta, jos Internet-palveluntarjoajasi on antanut sinulle IP-osoitteen, joka tulee määrittää manuaalisesti.", //wwa_msg_sipa
	"Huomaa: On ehkä ilmoitettava myös Isäntänimi. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_note_hostname
	"Ensisijainen DNS-osoite", //wwa_pdns
	"PPTP-palvelimen IP-osoite (voi olla sama kuin yhdyskäytävä)", //wwa_pptp_svraddr
	"Toissijainen DNS-osoite", //wwa_sdns
	"Ei mainittu tai en tiedä", //wwa_selectisp_not
	"Aseta käyttäjätunnus- ja salasanayhteys (L2TP)", //wwa_set_l2tp_title
	"Tämän yhteyden asentamiseen tarvitaan Internet-palveluntarjoajasi ilmoittama täydellinen IP-tietoluettelo. Jos sinulla on kiinteä IP-yhteys, ja nämä tiedot puuttuvat, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_set_sipa_msg
	"Aseta kiinteällä IP-osoitteella varustettu yhteys", //wwa_set_sipa_title
	"Aseta BigPond-kaapeliyhteys", //wwa_title_set_bigpond
	"Aseta käyttäjätunnus- ja salasanayhteys (PPPoE)", //wwa_title_set_pppoe
	"Aseta käyttäjätunnus- ja salasanayhteys (PPTP)", //wwa_title_set_pptp
	"Tervetuloa D-Linkin ohjattuun asetustoimintoon", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Käyttäjätunnus/salasana-yhteys (L2TP)", //wwa_wanmode_l2tp
	"Käyttäjätunnus/salasana-yhteys (PPPoE)", //wwa_wanmode_pppoe
	"Käyttäjätunnus/salasana-yhteys (PPTP)", //wwa_wanmode_pptp
	"Kiinteän IP-osoitteen yhteys", //wwa_wanmode_sipa
	"Anna Wi-Fi-verkollesi nimi.", //wwz_wwl_intro_s2_1
	"Wi-Fi-verkon nimi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Enintään 32 merkkiä)", //wwz_wwl_intro_s2_1_2
	"Anna Wi-Fi-verkollesi salasana.", //wwz_wwl_intro_s2_2
	"Wi-Fi-salasana", //wwz_wwl_intro_s2_2_1
	"(8 - 63 merkkiä)", //wwz_wwl_intro_s2_2_2
	"Syötä verkon nimi käyttäen korkeintaan 32 merkkiä.", //wwz_wwl_intro_s3_1
	"Vaihe 1: Tervetuloa D-LINKIN LANGATTOMAN VERKON SUOJAN OHJATTUUN ASETUSTOIMINTOON", //wwz_wwl_title_s3
	"PPTP-palvelimen IP-osoite ei kelpaa", //YM108
	"Käytä samaa langattoman verkon salasanaa sekä 2,4 GHz:n että 5 GHz:n kaistalla", //wwl_SSP
	"Anna Wi-Fi-verkollesi nimi ja salasana.", //wwz_wwl_intro_s0
	"Ensimmäisen %s-osoitteen pitää olla kokonaisluku.", //MSG002
	"Toisen %s-osoitteen pitää olla kokonaisluku.", //MSG003
	"Kolmannen %s-osoitteen pitää olla kokonaisluku.", //MSG004
	"Neljännen %s-osoitteen pitää olla kokonaisluku.", //MSG005
	"Osoite %s ei kelpaa.", //MSG006
	"%s ei voi olla nolla.", //MSG007
	"Annettu %s-portti ei kelpaa.", //MSG008
	"Annettu %s-salaisuus ei kelpaa.", //MSG009
	"%s ei voi sallia pääsyä loopback IP:lle tai multicast IP:lle (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Anna toinen %s-arvo.", //MSG012
	"%s-arvon pitää olla numeerinen!", //MSG013
	"%s-alue on %1n ~ %2n.", //MSG014
	"%s-arvon pitää olla parillinen numero.", //MSG015
	"Avain ei kelpaa. Avaimen on oltava 5 tai 10 merkin heksadesimaalinumero. Annoit", //MSG016
	"Avain ei kelpaa. Avaimen on oltava 13 tai 26 merkin heksadesimaalinumero. Annoit", //MSG017
	"Ensimmäisen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG018
	"Toisen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG019
	"Kolmannen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG020
	"Neljännen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG021
	"Viidennen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG022
	"Kuudennen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG023
	"Seitsemännen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG024
	"Kahdeksannen %s-osoitteen pitää olla heksadesimaaliluku.", //MSG025
	"Ensimmäisen %s-alueen pitää olla välillä", //MSG026
	"Toisen %s-alueen pitää olla välillä", //MSG027
	"Kolmannen %s-alueen pitää olla välillä", //MSG028
	"Neljännen %s-alueen pitää olla välillä", //MSG029
	"Viidennen %s-alueen pitää olla välillä", //MSG030
	"Kuudennen %s-alueen pitää olla välillä", //MSG031
	"Seitsemännen %s-alueen pitää olla välillä", //MSG032
	"Kahdeksannen %s-alueen pitää olla välillä", //MSG033
	"%s ei voi sallia pääsyä loopback IP:lle ( ::1 ).", //MSG034
	"%s ei voi sallia pääsyä multicast IP:lle ( FFxx:0:0:0:0:0:0:2 tai ffxx:0:0:0:0:0:0:2.", //MSG035
	"Arvo ei kelpaa.", //MSG043
	"Arvon pitää olla välillä 1 - 16.", //ar_alert_3
	"Verkon peite ei kelpaa.", //ar_alert_5
	"Avain", //TEXT042_1
	" on väärin, sallitut merkit ovat 0~9, A~F tai a~f.", //TEXT042_2
	"Huomaa: Sinun on ehkä ilmoitettava myös Palvelun nimi. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_note_svcn
	"L2TP-asiakas", //wwa_msg_l2tp
	"Tämän yhteyden asentamiseen tarvitaan Internet-palveluntarjoajalta saatu käyttäjätunnus ja salasana. Tarvitset myös L2TP:n IP-osoitteen. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_set_l2tp_msg
	"Tämän yhteyden asentamiseen tarvitaan Internet-palveluntarjoajalta saatu käyttäjätunnus ja salasana. Tarvitset myös BigPond-palvelimen IP-osoitteen. Jos sinulla ei ole tätä tietoa, ota yhteyttä Internet-palveluntarjoajaasi.", //wwa_msg_set_bigpond
	"Palvelimen nimi", //_hostname
	"2,4 GHz:n kaista", //GW_WLAN_RADIO_0_NAME
	"5GHz:n kaista", //GW_WLAN_RADIO_1_NAME
	"Alla on yksityiskohtainen yhteenveto Wi-Fi-verkon suojausasetuksista. Tulosta tämä sivu tai kirjoita tiedot paperille, jotta voit määrittää Wi-Fi-laitteiden asetukset oikein.", //wwl_intro_end
	"Odota...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Yhdistä", //_connect
	"Ohjaa minut läpi Internet-yhteyden asetusten", //ES_btn_guide_me
	"Ota käyttöön graafinen todennus", //_graph_auth
	"D-LINK CORPORATION, INC | LANGATON REITITIN | KOTI", //TEXT000
	"L2TP-salasana on PAKOLLINEN", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internet-yhteyttä ei havaittu. Haluatko käynnistää ohjatun asennuksen uudelleen?", //mydlink_tx03
	"Järjestelmänvalvojan salasana ei voi olla tyhjä.", //mydlink_tx04
	"Tarkistetaan WAN-yhteys.", //mydlink_tx05
	"sekuntia jäljellä.", //sec_left
	"Yritä uudelleen", //_retry
	"Onko sinulla mydlink-tili?", //mydlink_tx06
	"Kyllä, minulla on mydlink-tili.", //mydlink_tx07
	"Ei, haluan rekisteröidä ja kirjautua uudella mydlink-tilillä.", //mydlink_tx08
	"Sähköpostiosoite (tilin nimi)", //mydlink_tx09
	"Täytä asetukset rekisteröinnin päättämiseksi.", //mydlink_tx10
	"Vahvista salasana", //chk_pass
	"Sukunimi", //Lname
	"Etunimi", //Fname
	"Hyväksyn mydlink-käyttöehdot.", //mydlink_tx12
	"Päätä mydlink-rekisteröinti katsomalla saamastasi sähköpostiviestistä vahvistusohjeet.", //mydlink_tx13_1
	" Kun olet vahvistanut sähköpostiosoitteesi, napsauta Kirjaudu-painiketta.", //mydlink_tx13_2
	"Kirjautuminen", //_login
	"OK", //_ok
	"Tallenna", //_save
	"Syötä sama salasana kaksi kertaa ja yritä uudelleen.", //_pwsame
	"Jotta voit käyttää <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a>-sivuston ja mydlink Lite -ohjelman toimintoja, tarvitset <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>-tilin.", //mydlink_reg_into_1
	"Jos sinulla jo on tili, valitse <strong>Kyllä, minulla on mydlink-tili</strong> ja rekisteröi reititin <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>-palveluun valitsemalla Seuraava.", //mydlink_reg_into_2
	"Jos sinulla ei ole tiliä, valitse <strong>Ei, haluan rekisteröidä ja kirjautua uudella mydlink-tilillä</strong> ja luo tili valitsemalla Seuraava.", //mydlink_reg_into_3
	" Jos et halua rekisteröidä mydlink-palveluun, valitse Peruuta.", //mydlink_reg_into_4_a
	"Tällä sähköpostiosoitteella on jo mydlink-tili. Kokeile toista sähköpostiosoitetta.", //mydlink_pop_01
	"Sinun on hyväksyttävä käyttöehdot jatkaaksesi.", //mydlink_pop_02
	"ei saa olla tyhjä.", //mydlink_pop_03
	"ei kelpaa.", //mydlink_pop_04
	"Voit nyt käyttää mydlink-palvelua tämän laitteen kanssa", //mydlink_pop_05
	"Kirjautuminen ei onnistunut", //mydlink_pop_06
	"Rekisteröi", //_signup
	"Kun mydlink-rekisteröinti on valmis, reitittimen PPPoE-, L2TP- tai PPTP-yhteyden oletusarvo on Aina päällä. Jos Internet-palveluntarjoajasi veloittaa käytöstä, kannattaa oletusasetukseksi ehkä valita manuaalisesti Dial On Demand.", //mydlink_pop_09
	"mydlink-palveluun kirjautuminen ei onnistu.", //mdl_errmsg_01
	"Kirjautumispyynnön lähettäminen ei onnistunut.", //mdl_errmsg_02
	"Kirjautumispyyntöä ei voi lähettää.", //mdl_errmsg_03
	"Rekisteröitymispyynnön lähettäminen ei onnistunut.", //mdl_errmsg_04
	"Rekisteröitymispyyntöä ei voi lähettää.", //mdl_errmsg_05
	"SSID-kenttää ei voi jättää tyhjäksi", //SSID_EMPTY_ERROR
	"Salasanat eivät täsmää", //YM102
	"PPPoE-salasana on PAKOLLINEN", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Tilin salasanassa pitää olla yli kuusi merkkiä", //limit_pass_msg
	"Ohita", //_skip
	"Jos et halua rekisteröityä mydlink-palveluun, valitse Ohita.", //mydlink_reg_into_4
	"Tallennetaan WI-FI-asetus", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Tämä laite tukee mydlink-palvelua, jonka avulla voit seurata ja hallita verkkoasi mydlink.com-sivuston tai mydlink-mobiiliohjelman kautta.", //_wz_mydlink_into_1
	"Voit tarkistaa verkon nopeudet, katsoa, ketkä ovat yhteydessä, näyttää laitteen selaushistorian ja vastaanottaa ilmoituksia uusista käyttäjistä tai tunkeutumisyrityksistä.", //_wz_mydlink_into_2
	"Voit rekisteröidä tämän laitteen nykyiseen mydlink-tiliisi. Jos sinulla ei ole tiliä, voit luoda sen nyt.", //_wz_mydlink_into_3
	"Saapuneet-kansiossasi pitäisi olla sähköpostiviesti, jossa on vahvistamisohjeet.", //_wz_mydlink_email_1
	"Odota, kun reititin tarkistaa Internet-yhteyttä.", //_chk_wanconn_msg_00
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