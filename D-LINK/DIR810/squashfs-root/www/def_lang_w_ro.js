//Version=1.03b02
//Language=Romanian
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Revocare", //_cancel
	"Copiere adresă MAC a PC-ului", //_clone
	"Conexiune DHCP (adresă IP dinamică)", //_dhcpconn
	"Adresă IP", //_ipaddr
	"L2TP", //_L2TP
	"Adresă IP gateway L2TP", //_L2TPgw
	"Adresă IP L2TP", //_L2TPip
	"Mască subreţea L2TP", //_L2TPsubnet
	"Limbă", //_Language
	"Adresă MAC", //_macaddr
	"Următorul", //_next
	"Nu", //_no
	"(opţional)", //_optional
	"Parolă", //_password
	"Adresă IP gateway PPTP", //_PPTPgw
	"Adresă IP PPTP", //_PPTPip
	"Mască subreţea PPTP", //_PPTPsubnet
	"Anter.", //_prev
	"Creaţi două parole de administrator identice şi încercaţi din nou", //_pwsame_admin
	"IP static", //_sdi_staticip
	"Mască subreţea", //_subnet
	"Nume utilizator", //_username
	"Verificare parolă", //_verifypw
	"Abandonaţi toate modificările efectuate la acest expert?", //_wizquit
	"Da", //_yes
	"Adresă IP server L2TP nevalidă", //bwn_alert_17
	"Mod Adresă", //bwn_AM
	"Server BigPond", //bwn_BPS
	"TKIP şi AES", //bws_CT_3
	"IP dinamic", //carriertype_ct_0
	"Ruterul vă detectează tipul de conexiune la Internet, aşteptaţi...", //ES_auto_detect_desc
	"Ruterul nu reuşeşte să detecteze tipul dvs. de conexiune la Internet.", //ES_auto_detect_failed_desc
	"Marcaţi \"Gestionare Web router D-Link\"?", //ES_bookmark
	"Încercaţi din nou", //ES_btn_try_again
	"Conectaţi un capăt al cablului Ethernet inclus care a fost livrat împreună cu ruterul la portul etichetat INTERNET de pe partea din spate a ruterului. Conectaţi celălalt capăt al acestui cablu la portul Ethernet de pe modem şi executaţi un ciclu de alimentare a modemului.", //ES_cable_lost_desc
	"Pasul 2: Configurarea securităţii Wi-Fi", //ES_step_wifi_security
	"Pasul 3: Setarea parolei", //ES_title_s3
	"Pasul 4: Selectarea fusului orar", //ES_title_s4
	"Pasul 5: Salvarea setărilor", //ES_title_s5
	"Pasul 5: Confirmarea setărilor WI-FI", //ES_title_s5_0
	"Pasul 6: Înregistrarea cu MYDLINK", //ES_title_s6
	"Înregistrarea cu MYDLINK", //ES_title_s6_myd
	"Pasul 1: Configurarea conexiunii la Internet", //ES_wwa_title_s1
	"Nume client DHCP nevalid", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Parolă DHCP+ nevalidă", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nume de utilizator DHCP+ nevalid", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"TREBUIE specificat un nume de utilizator L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"TREBUIE specificată o parolă PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Cheie de reţea nevalidă!", //IPV6_TEXT2
	"Adresă MAC nevalidă", //KR3
	"Automat (WPA sau WPA2) - Personal", //KR48
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
	"US West/Qwest", //manul_conn_23
	"Verizon Online DSL", //manul_conn_24
	"XO Communications", //manul_conn_25
	"Înregistrarea produsului cu mydlink vă va permite să folosiţi caracteristici mydlink, inclusiv acces online şi gestionare a dispozitivului prin intermediul site-ului Web mydlink.", //mydlink_tx01
	"Înregistraţi dispozitivul cu mydlink?", //mydlink_tx02
	"Introduceţi numele de utilizator", //PPP_USERNAME_EMPTY
	"PPPoE Plus acceptat", //pppoe_plus_dail
	"Parola poate conţine numai caractere imprimabile.", //S493
	"SALVARE SETĂRI", //save_settings
	"Se salvează setările.", //save_wait
	"Versiune firmware", //sd_FWV
	"Pagină produs", //TA2
	"Versiune hardware", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Insula Midway, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Ora Pacificului (SUA/Canada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Ora Zonei muntoase (SUA/Canada)", //up_tz_06
	"(GMT-06:00) America Centrală", //up_tz_07
	"(GMT-06:00) Ora regiunii centrale (SUA/Canada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Ora regiunii de est (SUA/Canada)", //up_tz_12
	"(GMT-05:00) Indiana (Est)", //up_tz_13
	"(GMT-04:00) Ora Atlanticului (Canada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Groenlanda", //up_tz_20
	"(GMT-02:00) Atlanticul Mijlociu", //up_tz_21
	"(GMT-01:00) Azore", //up_tz_22
	"(GMT-01:00) Insulele Capului Verde", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Ora meridianului Greenwich: Dublin, Edinburgh, Lisabona, Londra", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Berna, Roma, Stockholm, Viena", //up_tz_26
	"(GMT+01:00) Belgrad, Bratislava, Budapesta, Ljubljana, Praga", //up_tz_27
	"(GMT+01:00) Bruxelles, Copenhaga, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofia, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budapesta, Viena, Praga, Varşovia", //up_tz_29b
	"(GMT+01:00) Africa Centrală şi de Vest", //up_tz_30
	"(GMT+02:00) Atena, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bucureşti", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Ierusalim", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuweit, Riad", //up_tz_38
	"(GMT+04:00) Moscova, St. Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Erevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Taşkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnoiarsk", //up_tz_54
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaanbataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapore", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"(GMT+09:00) Seul", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Insulele Solomon, Noua Caledonie", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamceatka, Insulele Marshall", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) Linia de schimbare a datei, vest", //up_tz_76
	"(GMT-11:00) Insula Midway", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Mexico City, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (Est)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Varșovia, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kiev, Riga, Sofia, Tallinn, Vilnius", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulaan Bataar", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"Setări DNS", //wwa_dnsset
	"Adresă gateway", //wwa_gw
	"În mod implicit, noul dvs. ruter D-Link nu are o parolă configurată pentru acces de administrator la paginile de configurare bazate pe Web. Pentru a securiza noul dvs. dispozitiv de lucru în reţea, setaţi şi verificaţi o parolă mai jos. Activarea autentificării grafice CAPTCHA este o măsură de securitate şi de protecţie suplimentară pentru prevenirea accesului neautorizat al utilizatorilor online şi al software-urilor hackerilor la setările de reţea.", //wwa_intro_s1
	"Selectaţi fusul orar corespunzător locaţiei dvs. Aceste informaţii sunt necesare pentru a configura opţiunile bazate pe timp. Ruterul va fi setat pentru a actualiza automat ceasul intern de la un server de timp NTP.", //wwa_intro_s2
	"Selectaţi tipul de conexiune la Internet mai jos:", //wwa_intro_s3
	"Acest expert vă va ghida printr-un proces pas cu pas pentru configurarea noului dvs. ruter D-Link şi conectarea la Internet.", //wwa_intro_wel
	"Adresă IP server L2TP (poate fi identică cu adresa gateway-ului)", //wwa_l2tp_svra
	"Selectaţi această opţiune în cazul în care conexiunea la Internet vă furnizează o adresă IP. Majoritatea modemurilor de cablu utilizează acest tip de conexiune.", //wwa_msg_dhcp
	"Dacă furnizorul dvs. de servicii Internet nu este listat sau nu îi cunoaşteţi numele, selectaţi tipul de conexiune la Internet mai jos:", //wwa_msg_ispnot
	"Alegeţi această opţiune în cazul în care conexiunea la Internet necesită un nume de utilizator şi o parolă pentru a trece online. Majoritatea modemurilor DSL utilizează acest tip de conexiune.", //wwa_msg_pppoe
	"Client PPTP.", //wwa_msg_pptp
	"Pentru a configura această conexiune, asiguraţi-vă că sunteţi conectat la ruterul D-Link cu PC-ul care a fost conectat iniţial la conexiunea de bandă largă. În caz afirmativ, faceţi clic pe butonul Clonare MAC pentru a copia adresa MAC a computerului în ruterul D-Link.", //wwa_msg_set_dhcp
	"Pentru a configura această conexiune, va trebui să aveţi un nume utilizator şi o parolă de la furnizorul dvs. de servicii Internet. Dacă nu aveţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_msg_set_pppoe
	"Pentru a configura această conexiune, va trebui să aveţi un nume utilizator şi o parolă de la furnizorul dvs. de servicii Internet. De asemenea, aveţi nevoie de adresa IP PPTP. Dacă nu aveţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_msg_set_pptp
	"Selectaţi această opţiune dacă furnizorul dvs. de servicii Internet v-a furnizat informaţiile despre adresa IP care trebuie configurate manual.", //wwa_msg_sipa
	"Notă: De asemenea, este posibil să fie necesar să furnizaţi un nume de gazdă. Dacă nu aveţi sau nu cunoaşteţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_note_hostname
	"Adresă DNS principal", //wwa_pdns
	"Adresă IP server PPTP (poate fi identică cu adresa gateway-ului)", //wwa_pptp_svraddr
	"Adresă DNS secundar", //wwa_sdns
	"Nelistat sau Nu ştiu", //wwa_selectisp_not
	"Setare conexiune prin nume de utilizator şi parolă (L2TP)", //wwa_set_l2tp_title
	"Pentru a configura această conexiune, va trebui să aveţi o listă completă de informaţii IP furnizate de furnizorul de servicii Internet. Dacă aveţi o conexiune prin IP static şi nu aveţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_set_sipa_msg
	"Setare conexiune prin adresă IP statică", //wwa_set_sipa_title
	"Setare conexiune prin cablu BigPond", //wwa_title_set_bigpond
	"Setare conexiune prin nume de utilizator şi parolă (PPPoE)", //wwa_title_set_pppoe
	"Setare conexiune prin nume de utilizator şi parolă (PPTP)", //wwa_title_set_pptp
	"Bun venit la expertul de configurare D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Conexiune prin nume de utilizator/parolă (L2TP)", //wwa_wanmode_l2tp
	"Conexiune prin nume de utilizator/parolă (PPPoE)", //wwa_wanmode_pppoe
	"Conexiune prin nume de utilizator/parolă (PPTP)", //wwa_wanmode_pptp
	"Conexiune prin adresă IP statică", //wwa_wanmode_sipa
	"Stabiliţi numele reţelei dvs. Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nume reţea Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(maximum 32 de caractere)", //wwz_wwl_intro_s2_1_2
	"Stabiliţi parola reţelei dvs. Wi-Fi.", //wwz_wwl_intro_s2_2
	"Parolă Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(între 8 şi 63 de caractere)", //wwz_wwl_intro_s2_2_2
	"Stabiliţi numele reţelei utilizând maximum 32 de caractere.", //wwz_wwl_intro_s3_1
	"Pasul 1: Bun venit la EXPERTUL DE CONFIGURARE A SECURITĂŢII FĂRĂ FIR D-LINK", //wwz_wwl_title_s3
	"Adresă IP server PPTP nevalidă", //YM108
	"Utilizaţi aceeaşi parolă de securitate fără fir pe benzile de 2,4 GHz şi 5 GHz", //wwl_SSP
	"Stabiliţi numele şi parola reţelei dvs. Wi-Fi.", //wwz_wwl_intro_s0
	"Prima adresă a %s trebuie să fie un număr întreg.", //MSG002
	"A doua adresă a %s trebuie să fie un număr întreg.", //MSG003
	"A treia adresă a %s trebuie să fie un număr întreg.", //MSG004
	"A patra adresă a %s trebuie să fie un număr întreg.", //MSG005
	"%s este o adresă nevalidă.", //MSG006
	"%s nu poate fi zero.", //MSG007
	"Portul %s introdus este nevalid.", //MSG008
	"Secretul %s introdus este nevalid.", //MSG009
	"%s nu poate permite intrarea pentru IP de întoarcere în buclă sau IP de difuzare multiplă (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Introduceţi o altă valoare %s.", //MSG012
	"Valoarea %s trebuie să fie numerică!", //MSG013
	"Intervalul %s este de %1n ~ %2n.", //MSG014
	"Valoarea %s trebuie să fie un număr par.", //MSG015
	"Cheia este nevalidă. Cheia trebuie să conţină un număr hexazecimal cu 5 sau 10 caractere. Aţi introdus", //MSG016
	"Cheia este nevalidă. Cheia trebuie să conţină un număr hexazecimal cu 13 sau 26 de caractere. Aţi introdus", //MSG017
	"Prima adresă pentru %s trebuie să fie hexazecimală.", //MSG018
	"A doua adresă pentru %s trebuie să fie hexazecimală.", //MSG019
	"A treia adresă pentru %s trebuie să fie hexazecimală.", //MSG020
	"A patra adresă pentru %s trebuie să fie hexazecimală.", //MSG021
	"A cincea adresă pentru %s trebuie să fie hexazecimală.", //MSG022
	"A şasea adresă pentru %s trebuie să fie hexazecimală.", //MSG023
	"A şaptea adresă pentru %s trebuie să fie hexazecimală.", //MSG024
	"A opta adresă pentru %s trebuie să fie hexazecimală.", //MSG025
	"Primul interval pentru %s trebuie să fie între", //MSG026
	"Al doilea interval pentru %s trebuie să fie între", //MSG027
	"Al treilea interval pentru %s trebuie să fie între", //MSG028
	"Al patrulea interval pentru %s trebuie să fie între", //MSG029
	"Al cincilea interval pentru %s trebuie să fie între", //MSG030
	"Al şaselea interval pentru %s trebuie să fie între", //MSG031
	"Al şaptelea interval pentru %s trebuie să fie între", //MSG032
	"Al optulea interval pentru %s trebuie să fie între", //MSG033
	"%s nu poate permite intrarea pentru IP de întoarcere în buclă ( ::1 ).", //MSG034
	"%s nu poate permite intrarea pentru IP de difuzare multiplă ( FFxx:0:0:0:0:0:0:2 sau ffxx:0:0:0:0:0:0:2.", //MSG035
	"Metrică nevalidă", //MSG043
	"Valoarea metrică trebuie să fie între (1..16).", //ar_alert_3
	"Mască de reţea nevalidă.", //ar_alert_5
	"Cheia", //TEXT042_1
	" este greşită, caracterele permise sunt 0~9, A~F sau a~f.", //TEXT042_2
	"Notă: De asemenea, este posibil să fie necesar să furnizaţi un nume serviciu. Dacă nu aveţi sau nu cunoaşteţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_note_svcn
	"Client L2TP.", //wwa_msg_l2tp
	"Pentru a configura această conexiune, va trebui să aveţi un nume utilizator şi o parolă de la furnizorul dvs. de servicii Internet. De asemenea, aveţi nevoie de adresa IP L2TP. Dacă nu aveţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_set_l2tp_msg
	"Pentru a configura această conexiune, va trebui să aveţi un nume utilizator şi o parolă de la furnizorul dvs. de servicii Internet. De asemenea, aveţi nevoie de adresa IP de server BigPond. Dacă nu aveţi aceste informaţii, contactaţi furnizorul ISP.", //wwa_msg_set_bigpond
	"Nume gazdă", //_hostname
	"Bandă de 2,4 GHz", //GW_WLAN_RADIO_0_NAME
	"Bandă de 5 GHz", //GW_WLAN_RADIO_1_NAME
	"Mai jos se găseşte un rezumat detaliat al setărilor de securitate Wi-Fi. Imprimaţi această pagină sau notaţi informaţiile pe hârtie, astfel încât să puteţi configura setările corecte pe dispozitivele Wi-Fi.", //wwl_intro_end
	"Aşteptaţi...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Conectare", //_connect
	"Ghidează-mă prin setările de conexiune la Internet", //ES_btn_guide_me
	"Activare autentificare grafică", //_graph_auth
	"D-LINK CORPORATION, INC | RUTER FĂRĂ FIR | ACASĂ", //TEXT000
	"TREBUIE specificată o parolă L2TP", //GW_WAN_L2TP_PASSWORD_INVALID
	"Nu s-a detectat nicio conexiune la Internet, reporniţi expertul?", //mydlink_tx03
	"Parola de administrator nu poate fi goală.", //mydlink_tx04
	"Verificare conectivitate WAN în curs.", //mydlink_tx05
	"secunde rămase.", //sec_left
	"Reîncercare", //_retry
	"Aveţi un cont mydlink?", //mydlink_tx06
	"Da, am un cont mydlink.", //mydlink_tx07
	"Nu, doresc să mă înregistrez şi să mă conectez cu un cont mydlink nou.", //mydlink_tx08
	"Adresă de e-mail (nume cont)", //mydlink_tx09
	"Procesaţi opţiunile pentru a finaliza înregistrarea.", //mydlink_tx10
	"Confirmare parolă", //chk_pass
	"Nume", //Lname
	"Prenume", //Fname
	"Accept termenii şi condiţiile mydlink.", //mydlink_tx12
	"Pentru a finaliza înregistrarea mydlink, verificaţi inboxul pentru un e-mail cu instrucţiuni de confirmare.", //mydlink_tx13_1
	" După confirmarea adresei de e-mail, faceţi clic pe butonul de login.", //mydlink_tx13_2
	"Conectare", //_login
	"OK", //_ok
	"Salvare", //_save
	"Creaţi două parole identice şi încercaţi din nou", //_pwsame
	"Pentru a utiliza caracteristicile <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> şi aplicaţia mydlink Lite, aveţi nevoie de un cont la adresa <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_1
	"Dacă aveţi deja un cont, selectaţi <strong>Yes, I have a mydlink account (Da, am un cont mydlink)</strong> şi faceţi clic pe Next (Următorul) pentru a înregistra ruterul la adresa <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_2
	"Dacă nu aveţi un cont, selectaţi <strong>No, I want to register and login with a new mydlink account (Nu, doresc să mă înregistrez şi să mă conectez cu un cont mydlink nou)</strong> şi faceţi clic pe Next (Următorul) pentru a crea un cont.", //mydlink_reg_into_3
	" Dacă nu doriţi să vă înregistraţi pentru serviciul mydlink, faceţi clic pe Cancel (Revocare).", //mydlink_reg_into_4_a
	"Această adresă de e-mail are deja un cont mydlink. Încercaţi o altă adresă de e-mail.", //mydlink_pop_01
	"Trebuie să acceptaţi termenii şi condiţiile pentru a continua.", //mydlink_pop_02
	"nu trebuie să fie goală.", //mydlink_pop_03
	"este nevalidă.", //mydlink_pop_04
	"Acum puteţi utiliza serviciul mydlink cu acest dispozitiv", //mydlink_pop_05
	"Login nereuşit", //mydlink_pop_06
	"inscriere", //_signup
	"După ce înregistrarea mydlink este terminată, conexiunea PPPoE, L2TP, PPTP implicită a ruterului va fi setată la Always On (Activat în permanenţă). Dacă furnizorul ISP taxează utilizarea, este posibil să alegeţi manual Dial On Demand (Apelare la cerere) drept setare implicită.", //mydlink_pop_09
	"Imposibil de conectat la mydlink.", //mdl_errmsg_01
	"Trimiterea solicitării de conectare nu a reuşit.", //mdl_errmsg_02
	"Imposibil de trimis solicitarea de conectare.", //mdl_errmsg_03
	"Trimiterea solicitării de înregistrare nu a reuşit.", //mdl_errmsg_04
	"Imposibil de trimis solicitarea de înregistrare.", //mdl_errmsg_05
	"Câmpul SSID nu poate fi gol", //SSID_EMPTY_ERROR
	"Parolele introduse nu se potrivesc", //YM102
	"TREBUIE specificată o parolă PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Parola de cont trebuie să conţină mai mult de şase caractere", //limit_pass_msg
	"Ignorare", //_skip
	"Dacă nu doriţi să vă înregistraţi la serviciul mydlink, faceţi clic pe Ignorare.", //mydlink_reg_into_4
	"Se salvează setarea Wi-Fi", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"Acest dispozitiv are capacitate mydlink, care vă permite să monitorizaţi şi să gestionaţi la distanţă reţeaua prin site-ul Web mydlink.com sau prin aplicaţia mobilă mydlink.", //_wz_mydlink_into_1
	"Veţi putea să verificaţi vitezele reţelei, să vedeţi cine este conectat, să vizualizaţi istoricul de navigare a dispozitivului şi să primiţi notificări despre utilizatori noi sau încercări de acces ilegal.", //_wz_mydlink_into_2
	"Puteţi înregistra acest dispozitiv la contul dvs. mydlink existent. Dacă nu aveţi un cont, puteţi crea unul nou.", //_wz_mydlink_into_3
	"Verificaţi-vă căsuţa poştală pentru un e-mail cu instrucţiuni de confirmare.", //_wz_mydlink_email_1
	"Ruterul este în curs de verificare a conectivităţii la Internet, aşteptaţi.", //_chk_wanconn_msg_00
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