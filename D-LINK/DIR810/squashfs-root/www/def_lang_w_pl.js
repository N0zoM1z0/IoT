//Version=1.03b02
//Language=Polish
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Anuluj", //_cancel
	"Kopiuj adres MAC swojego komputera", //_clone
	"Połączenie DHCP (Dynamiczny adres IP)", //_dhcpconn
	"Adres IP", //_ipaddr
	"L2TP", //_L2TP
	"Adres IP bramy L2TP", //_L2TPgw
	"Adres IP L2TP", //_L2TPip
	"Maska podsieci L2TP", //_L2TPsubnet
	"Język", //_Language
	"Adres MAC", //_macaddr
	"Dalej", //_next
	"Nie", //_no
	"(opcjonalne)", //_optional
	"Hasło", //_password
	"Adres IP bramy PPTP", //_PPTPgw
	"Adres IP PPTP", //_PPTPip
	"Maska podsieci PPTP", //_PPTPsubnet
	"Wstecz", //_prev
	"Należy upewnić się, że obydwa wprowadzone hasła administratora są identyczne i spróbować ponownie", //_pwsame_admin
	"Statyczny adres IP", //_sdi_staticip
	"Maska podsieci", //_subnet
	"Nazwa użytkownika", //_username
	"Potwierdź hasło", //_verifypw
	"Czy chcesz porzucić wszystkie zmiany wprowadzone w tym kreatorze?", //_wizquit
	"Tak", //_yes
	"Nieprawidłowy adres IP serwera L2TP", //bwn_alert_17
	"Rodzaj adresu", //bwn_AM
	"Serwer BigPond", //bwn_BPS
	"TKIP i AES", //bws_CT_3
	"Dynamiczne IP", //carriertype_ct_0
	"Router wykrywa typ połączenia internetowego, proszę czekać...", //ES_auto_detect_desc
	"Router nie może wykryć rodzaju połączenia z Internetem.", //ES_auto_detect_failed_desc
	"Czy chcesz dodać \"D-Link Router Web Management\" do zakładek?", //ES_bookmark
	"Spróbuj ponownie", //ES_btn_try_again
	"Podłącz jedną końcówkę załączonego kabla Ethernet do portu oznaczonego jako INTERNET. Drugi koniec podłącz do portu Ethernet na modemie i podłącz modem do zasilania.", //ES_cable_lost_desc
	"Etap 2: Konfiguracja zabezpieczeń Wi-Fi", //ES_step_wifi_security
	"Etap 3: Konfiguracja hasła", //ES_title_s3
	"Etap 4: Wybór strefy czasowej", //ES_title_s4
	"Etap 5: Zapisanie ustawień", //ES_title_s5
	"Etap 5: Potwierdzenie ustawień WI-FI", //ES_title_s5_0
	"Etap 6: Rejestracja MYDLINK", //ES_title_s6
	"Rejestracja MYDLINK", //ES_title_s6_myd
	"Etap 1: Konfiguracja połączenia internetowego", //ES_wwa_title_s1
	"Nieprawidłowa nazwa klienta DHCP", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Nieprawidłowe hasło DHCP+", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nieprawidłowa nazwa użytkownika DHCP+", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Nazwa użytkownika L2TP MUSI być zdefiniowana", //GW_WAN_L2TP_USERNAME_INVALID
	"Hasło PPTP MUSI być zdefiniowane", //GW_WAN_PPTP_PASSWORD_INVALID
	"Nieprawidłowy klucz sieciowy!", //IPV6_TEXT2
	"Nieprawidłowy adres MAC", //KR3
	"Auto (WPA lub WPA2) - Osobiste", //KR48
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
	"Rejestracja produktu w mydlink pozwala użytkownikowi korzystać z funkcjonalności dostępnych za pośrednictwem mydlink, w tym z dostępu online oraz z zarządzania urządzeniem poprzez stronę mydlink.", //mydlink_tx01
	"Czy chcesz zarejestrować swoje urządzenie w mydlink?", //mydlink_tx02
	"Wprowadź nazwę użytkownika", //PPP_USERNAME_EMPTY
	"Obsługa PPPoE Plus", //pppoe_plus_dail
	"Hasło może zawierać wyłącznie znaki nadające się do druku.", //S493
	"ZAPISYWANIE USTAWIEŃ", //save_settings
	"Ustawienia są zapisywane.", //save_wait
	"Wersja oprogramowania", //sd_FWV
	"Strona produktu", //TA2
	"Wersja sprzętu komputerowego", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway, Samoa", //up_tz_01
	"(GMT-10:00) Hawaje", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Czas pacyficzny (USA/Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Czas górski (USA/Kanada)", //up_tz_06
	"(GMT-06:00) Ameryka Środkowa", //up_tz_07
	"(GMT-06:00) Czas środkowoamerykański (USA/Kanada)", //up_tz_08
	"(GMT-06:00) Meksyk", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Czas wschodnioamerykański (USA/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (Wschód)", //up_tz_13
	"(GMT-04:00) Czas atlantycki (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Nowa Fundlandia", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grenlandia", //up_tz_20
	"(GMT-02:00) Czas środkowoatlantycki", //up_tz_21
	"(GMT-01:00) Azory", //up_tz_22
	"(GMT-01:00) Wyspy Zielonego Przylądka", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Czas Greenwich: Dublin, Edynburg, Lizbona, Londyn", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Brno, Rzym, Sztokholm, Wiedeń", //up_tz_26
	"(GMT+01:00) Belgrad, Bratysława, Budapeszt, Ljubljana, Praga", //up_tz_27
	"(GMT+01:00) Bruksela, Kopenhaga, Madryt, Paryż", //up_tz_28
	"(GMT+01:00) Sarajewo, Skopje, Sofia, Wilno, Zagrzeb", //up_tz_29
	"(GMT+01:00) Budapeszt, Wiedeń, Praga, Warszawa", //up_tz_29b
	"(GMT+01:00) Czas zachodnio-środkowoafrykański", //up_tz_30
	"(GMT+02:00) Ateny, Stambuł, Mińsk", //up_tz_31
	"(GMT+02:00) Bukareszt", //up_tz_32
	"(GMT+02:00) Kair", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Ryga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerozolima", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwejt, Rijad", //up_tz_38
	"(GMT+04:00) Moskwa, Petersburg, Wołgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Maskat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Erywań", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterynburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Taszkient", //up_tz_46
	"(GMT+05:30) Kalkuta, Madras, Bombaj, Nowe Delhi", //up_tz_47
	"(GMT+05:45) Katmandu", //up_tz_48
	"(GMT+06:00) Nowosybirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Dźajawardanapura", //up_tz_51
	"(GMT+06:30) Rangun", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Dżakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Pekin, Chongqing, Hong Kong, Urumczi", //up_tz_55
	"(GMT+09:00) Irkuck, Ułan Bator", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Tajpej", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Seul", //up_tz_61
	"(GMT+10:00) Jakuck", //up_tz_62
	"(GMT+09:30) Adelajda", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Władywostok", //up_tz_69
	"(GMT+11:00) Wyspy Salomona, Nowa Kaledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fidżi, Kamczatka, Wyspy Marshalla", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Nowosybirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) Międzynarodowa linia zmiany daty – Zachód", //up_tz_76
	"(GMT-11:00) Midway", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, miasto Meksyk, Monterrey", //up_tz_79
	"(GMT-05:00) Bogota, Lima, Quito, Indiana (Wschód)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajewo, Skopje, Warszawa, Zagrzeb", //up_tz_84
	"(GMT+02:00) Helsinki, Kijów, Ryga, Sofia, Tallinn, Wilno", //up_tz_85
	"(GMT+05:30) Madras, Kalkuta, Bombaj, Nowe Delhi", //up_tz_86
	"(GMT+07:00) Ałma-Ata, Nowosybirsk", //up_tz_87
	"(GMT+05:30) Sri Dźajawardanapura", //up_tz_88
	"(GMT+08:00) Ułan Bator", //up_tz_89
	"(GMT+09:00) Irkuck", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"Ustawienia DNS", //wwa_dnsset
	"Adres bramy", //wwa_gw
	"Wg ustawień domyślnych nowy router D-Link nie posiada skonfigurowanego hasła dostępu dla administratora do stron internetowych, gdzie urządzenie jest konfigurowane. W celu zabezpieczenia nowego urządzenia sieciowego należy poniżej ustawić i zweryfikować hasło. Włączenie uwierzytelniania graficznego CAPTCHA zapewnia dodatkową, bezpieczną ochronę dostępu do Twoich ustawień sieciowych w celu zabezpieczenia przed nieupoważnionymi użytkownikami online oraz oprogramowaniem hakerskim.", //wwa_intro_s1
	"Wybierz strefę czasową zgodną ze swoją lokalizacją. Jest to potrzebne do konfiguracji opcji czasowych. Wewnętrzny zegar routera będzie pobierał automatyczne aktualizacje z serwera czasu NTP.", //wwa_intro_s2
	"Wybierz poniżej rodzaj połączenia internetowego:", //wwa_intro_s3
	"Kreator poprowadzi Cię krok po kroku przez proces konfiguracji nowego routera D-Link oraz łączenia z Internetem.", //wwa_intro_wel
	"Adres IP serwera L2TP (może być taki sam, jak bramy)", //wwa_l2tp_svra
	"Wybierz, jeśli podczas połączenia z Internetem adres IP jest nadawany automatycznie. Większość modemów kablowych korzysta z tego typu połączenia.", //wwa_msg_dhcp
	"Jeśli Twojego dostawcy usług internetowych nie ma na liście lub nie znasz jego nazwy, wybierz rodzaj połączenia internetowego poniżej:", //wwa_msg_ispnot
	"Zaznacz tę opcję, jeśli do nawiązania połączenia konieczne jest podanie nazwy użytkownika i hasła. Większość modemów DSL korzysta z tego rodzaju połączeń.", //wwa_msg_pppoe
	"Klient PPTP.", //wwa_msg_pptp
	"W celu ustawienia tego połączenia upewnij się, że jesteś podłączony do routera D-Link za pomocą komputera, który był pierwotnie podłączony do łącza szerokopasmowego. Jeśli tak, kliknij przycisk klonowania adresu MAC, aby skopiować adres MAC komputera na router D-Link.", //wwa_msg_set_dhcp
	"Aby ustawić to połączenie, należy uzyskać nazwę użytkownika i hasło od dostawcy usług internetowych. Jeśli nie masz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_msg_set_pppoe
	"Aby ustawić to połączenie, należy uzyskać nazwę użytkownika i hasło od dostawcy usług internetowych. Potrzebny jest również adres IP PPTP. Jeśli nie masz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_msg_set_pptp
	"Wybierz tę opcję, jeśli dostawca usług internetowych przekazał Ci dane dotyczące adresu IP, które należy skonfigurować ręcznie.", //wwa_msg_sipa
	"Uwaga: Może zaistnieć konieczność podania nazwy hosta. Jeśli nie masz lub nie znasz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_note_hostname
	"Podstawowy adres DNS", //wwa_pdns
	"Adres IP serwera PPTP (może być taki sam, jak bramy)", //wwa_pptp_svraddr
	"Pomocniczy adres DNS", //wwa_sdns
	"Brak danych lub nie wiem", //wwa_selectisp_not
	"Ustaw nazwę użytkownika oraz hasło dla połączenia (L2TP)", //wwa_set_l2tp_title
	"Aby ustawić to połączenie, należy uzyskać pełną listę danych dotyczących IP od dostawcy usług internetowych. Jeśli posiadasz połączenie ze statycznym IP i nie masz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_set_sipa_msg
	"Ustaw połączenie ze statycznym adresem IP", //wwa_set_sipa_title
	"Ustaw połączenie BigPond Cable", //wwa_title_set_bigpond
	"Ustaw nazwę użytkownika oraz hasło dla połączenia (PPPoE)", //wwa_title_set_pppoe
	"Ustaw nazwę użytkownika oraz hasło dla połączenia (PPTP)", //wwa_title_set_pptp
	"Witaj w kreatorze instalacji D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Nazwa użytkownika / hasło dla połączenia (L2TP)", //wwa_wanmode_l2tp
	"Nazwa użytkownika / hasło dla połączenia (PPPoE)", //wwa_wanmode_pppoe
	"Nazwa użytkownika / hasło dla połączenia (PPTP)", //wwa_wanmode_pptp
	"Połączenie ze statycznym adresem IP", //wwa_wanmode_sipa
	"Nadaj nazwę swojej sieci Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nazwa sieci Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Do 32 znaków)", //wwz_wwl_intro_s2_1_2
	"Podaj hasło do swojej sieci Wi-Fi.", //wwz_wwl_intro_s2_2
	"Hasło do sieci Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(od 8 do 63 znaków)", //wwz_wwl_intro_s2_2_2
	"Nadaj nazwę swojej sieci, maksymalnie 32 znaki.", //wwz_wwl_intro_s3_1
	"Etap 1: Witaj W KREATORZE INSTALACJI ZABEZPIECZEŃ SIECI BEZPRZEWODOWEJ D-LINK", //wwz_wwl_title_s3
	"Nieprawidłowy adres IP serwera PPTP", //YM108
	"Wykorzystaj to samo hasło zabezpieczenia bezprzewodowego w paśmie 2.4 GHz i 5 GHz", //wwl_SSP
	"Podaj nazwę i hasło do swojej sieci Wi-Fi.", //wwz_wwl_intro_s0
	"Pierwszy adres %s musi być liczbą całkowitą.", //MSG002
	"Drugi adres %s musi być liczbą całkowitą.", //MSG003
	"Trzeci adres %s musi być liczbą całkowitą.", //MSG004
	"Czwarty adres %s musi być liczbą całkowitą.", //MSG005
	"%s jest nieprawidłowym adresem.", //MSG006
	"%s nie może być zerem.", //MSG007
	"Wprowadzony port %s jest nieprawidłowy.", //MSG008
	"Wprowadzony tajny klucz %s jest nieprawidłowy.", //MSG009
	"%s nie zezwala na wprowadzenie w adres IP sprzężenia zwrotnego lub adres IP multiemisji (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Proszę wprowadzić inną wartość %s.", //MSG012
	"Wartość %s musi być cyfrą!", //MSG013
	"Zakres %s wynosi %1n ~ %2n.", //MSG014
	"Wartość %s musi być liczbą parzystą.", //MSG015
	"Klucz jest nieprawidłowy. Klucz musi być liczbą szesnastkową składającą się z 5 lub 10 znaków. Wprowadzono", //MSG016
	"Klucz jest nieprawidłowy. Klucz musi być liczbą szesnastkową składającą się z 13 lub 26 znaków. Wprowadzono", //MSG017
	"Pierwszy adres %s musi być liczbą szesnastkową.", //MSG018
	"Drugi adres %s musi być liczbą szesnastkową.", //MSG019
	"Trzeci adres %s musi być liczbą szesnastkową.", //MSG020
	"Czwarty adres %s musi być liczbą szesnastkową.", //MSG021
	"Piąty adres %s musi być liczbą szesnastkową.", //MSG022
	"Szósty adres %s musi być liczbą szesnastkową.", //MSG023
	"Siódmy adres %s musi być liczbą szesnastkową.", //MSG024
	"Ósmy adres %s musi być liczbą szesnastkową.", //MSG025
	"Pierwszy adres %s musi być między", //MSG026
	"Drugi adres %s musi być między", //MSG027
	"Trzeci adres %s musi być między", //MSG028
	"Czwarty adres %s musi być między", //MSG029
	"Piąty adres %s musi być między", //MSG030
	"Szósty adres %s musi być między", //MSG031
	"Siódmy adres %s musi być między", //MSG032
	"Ósmy adres %s musi być między", //MSG033
	"%s nie zezwala na wprowadzenie w adres IP sprzężenia zwrotnego ( ::1 ).", //MSG034
	"%s nie zezwala na wprowadzenie w adres IP multiemisji ( FFxx:0:0:0:0:0:0:2 lub ffxx:0:0:0:0:0:0:2.", //MSG035
	"Nieprawidłowa metryka", //MSG043
	"Wartość metryki musi być między (1..16).", //ar_alert_3
	"Nieprawidłowa maska sieci.", //ar_alert_5
	"Klucz", //TEXT042_1
	" jest nieprawidłowy, prawidłowymi znakami są 0~9, A~F lub a~f.", //TEXT042_2
	"Uwaga: Może zaistnieć konieczność podania nazwy usługi. Jeśli nie masz lub nie znasz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_note_svcn
	"Klient L2TP.", //wwa_msg_l2tp
	"Aby ustawić to połączenie, należy uzyskać nazwę użytkownika i hasło od dostawcy usług internetowych. Potrzebny jest również adres IP L2TP. Jeśli nie masz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_set_l2tp_msg
	"Aby ustawić to połączenie, należy uzyskać nazwę użytkownika i hasło od dostawcy usług internetowych. Potrzebny jest również adres IP serwera BigPond. Jeśli nie masz tych danych, skontaktuj się z dostawcą usług internetowych.", //wwa_msg_set_bigpond
	"Nazwa hosta", //_hostname
	"Pasmo 2.4 GHz", //GW_WLAN_RADIO_0_NAME
	"Pasmo 5 GHz", //GW_WLAN_RADIO_1_NAME
	"Poniżej znajduje się szczegółowe podsumowanie ustawień zabezpieczeń Wi-Fi. Proszę je wydrukować lub zapisać te informacje na kartce papieru, aby móc prawidłowo skonfigurować ustawienia urządzeń WiFi.", //wwl_intro_end
	"Proszę czekać...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Połącz", //_connect
	"Przeprowadź mnie przez konfigurowanie ustawień połączenia internetowego", //ES_btn_guide_me
	"Włącz uwierzytelnianie graficzne", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTER BEZPRZEWODOWY | DLA DOMU", //TEXT000
	"Hasło L2TP MUSI być zdefiniowane", //GW_WAN_L2TP_PASSWORD_INVALID
	"Nie wykryto połączenia z Internetem, czy uruchomić ponownie kreatora?", //mydlink_tx03
	"Hasło administratora nie może być puste.", //mydlink_tx04
	"Sprawdzanie połączenia WAN.", //mydlink_tx05
	"sekund do końca.", //sec_left
	"Ponów", //_retry
	"Czy posiadasz konto mydlink?", //mydlink_tx06
	"Tak, posiadam konto mydlink.", //mydlink_tx07
	"Nie, chcę się zarejestrować i zalogować na nowe konto mydlink.", //mydlink_tx08
	"Adres e-mail (nazwa konta)", //mydlink_tx09
	"Proszę wypełnić opcje, aby zakończyć rejestrację.", //mydlink_tx10
	"Potwierdź hasło", //chk_pass
	"Nazwisko", //Lname
	"Imię", //Fname
	"Akceptuję zasady i warunki mydlink.", //mydlink_tx12
	"Aby ukończyć rejestrację mydlink, proszę sprawdzić swoją skrzynkę odbiorczą w celu zapoznania się z instrukcjami dotyczącymi potwierdzenia.", //mydlink_tx13_1
	" Po potwierdzeniu adresu e-mail, proszę kliknąć przycisk Zaloguj.", //mydlink_tx13_2
	"Login", //_login
	"Ok", //_ok
	"Zapisz", //_save
	"Należy upewnić się, że dwa hasła są identyczne i spróbować ponownie", //_pwsame
	"Aby korzystać z funkcji  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> i aplikacji mydlink Lite, potrzebne jest konto na stronie <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_1
	"Jeśli posiadasz już konto, wybierz <strong>Tak, posiadam konto mydlink</strong> i kliknij Dalej, aby zarejestrować router na stronie <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>.", //mydlink_reg_into_2
	"Jeśli nie posiadasz konta, wybierz <strong>Nie, chcę się zarejestrować i zalogować na nowe konto mydlink.</strong> i kliknij Dalej, aby utworzyć konto.", //mydlink_reg_into_3
	" Jeśli nie chcesz się logować w mydlink, kliknij Anuluj.", //mydlink_reg_into_4_a
	"Dla tego adresu e-mail istnieje już konto mydlink. Wpisz inny adres e-mail.", //mydlink_pop_01
	"Musisz zaakceptować zasady i warunki, aby kontynuować.", //mydlink_pop_02
	"nie może być puste.", //mydlink_pop_03
	"jest nieprawidłowe.", //mydlink_pop_04
	"Możesz teraz korzystać z usług mydlink na tym urządzeniu", //mydlink_pop_05
	"Logowanie nie powiodło się", //mydlink_pop_06
	"zapisać się", //_signup
	"Po zarejestrowaniu usługi mydlink domyślne połączenie PPPoE, L2TP i PPTP routera będzie ustawione jako Zawsze włączone. Jeśli dostawca usług internetowych pobiera opłatę za połączenie, można ręcznie wybrać opcję Połączenie na żądanie jako ustawienie domyślne.", //mydlink_pop_09
	"Nie można zalogować do usługi mydlink.", //mdl_errmsg_01
	"Nieudane wysyłanie żądania logowania.", //mdl_errmsg_02
	"Nie można wysłać żądania logowania.", //mdl_errmsg_03
	"Nieudane wysyłanie żądania rejestracji.", //mdl_errmsg_04
	"Nie można wysłać żądania rejestracji.", //mdl_errmsg_05
	"Pole SSID nie może być puste", //SSID_EMPTY_ERROR
	"Wpisane hasła nie pasują do siebie", //YM102
	"Hasło PPPoE MUSI być zdefiniowane", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Hasło do konta musi składać się z minimum siedmiu znaków", //limit_pass_msg
	"Pomiń", //_skip
	" Jeśli nie chcesz zalogować się w mydlink, kliknij Pomiń.", //mydlink_reg_into_4
	"Zapisywanie ustawień Wi-Fi", //mydlink_WiFi_save
	"Russia PPTP (Dual Access)", //rus_wan_pptp
	"Russia PPTP (Dual Access) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (Dual Access)", //rus_wan_l2tp
	"Russia L2TP (Dual Access) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (Dual Access)", //rus_wan_pppoe
	"Russia PPPoE (Dual Access) internet connection type", //rus_wan_pppoe_02
	"Wan Physical Setting", //rus_wan_pppoe_03
	"To urządzenie obsługuje funkcję mydlink, co pozwala na zdalne monitorowanie i zarządzanie za pośrednictwem strony mydlink.com lub mobilnej aplikacji mydlink.", //_wz_mydlink_into_1
	"Funkcja pozwala na sprawdzenie szybkości działania sieci i historii przeglądania na urządzeniu, na podgląd podłączonych użytkowników i otrzymywanie powiadomień o nowych użytkownikach lub próbach uzyskania nieautoryzowanego dostępu.", //_wz_mydlink_into_2
	"Urządzenie można zarejestrować za pośrednictwem istniejącego konta mydlink. Jeżeli jeszcze go nie masz, załóż je teraz.", //_wz_mydlink_into_3
	"Na Twoją skrzynkę pocztową zostanie wysłana wiadomość e-mail z instrukcjami dot. potwierdzenia.", //_wz_mydlink_email_1
	"Proszę czekać, router sprawdza łączność z Internetem.", //_chk_wanconn_msg_00
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