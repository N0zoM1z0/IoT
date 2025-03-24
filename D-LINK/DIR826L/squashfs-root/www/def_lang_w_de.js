//Version=1.01b02
//Language=German
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Abbrechen", //_cancel
	"MAC-Adresse des PCs kopieren", //_clone
	"DHCP-Verbindung (Dynamische IP-Adresse)", //_dhcpconn
	"IP-Adresse", //_ipaddr
	"L2TP", //_L2TP
	"L2TP-Gateway-IP-Adresse", //_L2TPgw
	"L2TP-IP-Adresse", //_L2TPip
	"L2TP-Subnetzmaske", //_L2TPsubnet
	"Sprache", //_Language
	"MAC-Adresse", //_macaddr
	"Weiter", //_next
	"Nein", //_no
	"(optional)", //_optional
	"Kennwort", //_password
	"PPTP-Gateway-IP-Adresse", //_PPTPgw
	"PPTP-IP-Adresse", //_PPTPip
	"PPTP-Subnetzmaske", //_PPTPsubnet
	"Zurück", //_prev
	"Die beiden Admin-Kennwörter müssen übereinstimmen. Geben Sie sie noch einmal ein.", //_pwsame_admin
	"Statische IP-Adresse", //_sdi_staticip
	"Subnetzmaske", //_subnet
	"Benutzername", //_username
	"Kennwort bestätigen", //_verifypw
	"Möchten Sie alle Änderungen verwerfen, die Sie in diesem Assistenten vorgenommen haben?", //_wizquit
	"Ja", //_yes
	"Ungültige L2TP Server IP-Adresse", //bwn_alert_17
	"Adressmodus", //bwn_AM
	"BigPond Server", //bwn_BPS
	"TKIP und AES", //bws_CT_3
	"Dynamische IP-Adresse", //carriertype_ct_0
	"Router sucht nach Ihrem Internetverbindungstyp, bitte warten...", //ES_auto_detect_desc
	"Router kann Ihren Internetverbindungstyp nicht erkennen.", //ES_auto_detect_failed_desc
	"Möchten Sie \"D-Link Router Web Management\" als Lesezeichen setzen?", //ES_bookmark
	"Versuchen Sie es noch einmal", //ES_btn_try_again
	"Stecken Sie das eine Ende des im Lieferumfang Ihres Routers enthaltenen Ethernet-Kabels in den mit INTERNET gekennzeichneten Port auf der Rückseite des Routers. Stecken Sie das andere Ende dieses Kabels in den Ethernet-Port Ihres Modems.", //ES_cable_lost_desc
	"Schritt 2: Konfigurieren Sie Ihre Wi-Fi-Sicherheit", //ES_step_wifi_security
	"Schritt 3: Richten Sie Ihr Kennwort ein", //ES_title_s3
	"Schritt 4: Wählen Sie Ihre Zeitzone", //ES_title_s4
	"Schritt 5: Speichern Sie die Einstellungen", //ES_title_s5
	"Schritt 5: Bestätigen Sie die WI-FI-Einstellungen", //ES_title_s5_0
	"Schritt 6: mydlink-Registrierung", //ES_title_s6
	"mydlink-Registrierung", //ES_title_s6_myd
	"Schritt 1: Konfigurieren Sie Ihre Internetverbindung", //ES_wwa_title_s1
	"Ungültiger DHCP-Client-Name", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Ungültiges DHCP+ Kennwort", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Ungültiger DHCP+ Benutzername", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Es MUSS ein L2TP-Benutzername angegeben werden", //GW_WAN_L2TP_USERNAME_INVALID
	"Es MUSS ein PPTP-Kennwort angegeben werden.", //GW_WAN_PPTP_PASSWORD_INVALID
	"Ungültiger Netzwerkschlüssel!", //IPV6_TEXT2
	"Ungültige MAC-Adresse", //KR3
	"Auto (WPA oder WPA2) – Personal", //KR48
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
	"Durch die Registrierung Ihres Produkts in mydlink können Sie die dort angebotenen mydlink-aktivierten Funktionen wie z. B. den Online-Zugriff auf Ihr Gerät und dessen Verwaltung über die mydlink-Website nutzen.", //mydlink_tx01
	"Möchten Sie Ihr Gerät mit mydlink registrieren?", //mydlink_tx02
	"Geben Sie den Benutzernamen ein", //PPP_USERNAME_EMPTY
	"PPPoE Plus unterstützt", //pppoe_plus_dail
	"Kennwort darf nur druckbare Zeichen enthalten.", //S493
	"EINSTELLUNGEN SPEICHERN", //save_settings
	"Ihre Einstellungen werden gespeichert.", //save_wait
	"Firmware-Version", //sd_FWV
	"Produktseite", //TA2
	"Hardware-Version", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (USA/Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (USA/Kanada)", //up_tz_06
	"(GMT-06:00) Mittelamerika", //up_tz_07
	"(GMT-06:00) Central Time (USA/Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (USA/Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (Ost)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Neufundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grönland", //up_tz_20
	"(GMT-02:00) Mittelatlantik", //up_tz_21
	"(GMT-01:00) Azoren", //up_tz_22
	"(GMT-01:00) Kapverdische Inseln", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich Time: Dublin, Edinburgh, Lissabon, London", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Bern, Rom, Stockholm", //up_tz_26
	"(GMT+01:00) Belgrad, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Brüssel, Kopenhagen, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofia, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Wien, Prag, Warschau", //up_tz_29b
	"(GMT+01:00) West-Zentralafrika", //up_tz_30
	"(GMT+02:00) Athen, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukarest", //up_tz_32
	"(GMT+02:00) Kairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riad", //up_tz_38
	"(GMT+04:00) Moskau, St. Petersburg, Wolgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teheran", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tiflis, Eriwan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Jekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karatschi, Taschkent", //up_tz_46
	"(GMT+05:30) Kalkutta, Chennai, Mumbai, Neu-Delhi", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Almaty", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangun", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Peking, Chongqing, Hongkong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipeh", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Seoul", //up_tz_61
	"(GMT+10:00) Jakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Wladiwostok", //up_tz_69
	"(GMT+11:00) Salomoninseln, Neukaledonien", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fidschi, Kamschatka, Marshall-Inseln", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"DNS-Einstellungen", //wwa_dnsset
	"Gateway-Adresse", //wwa_gw
	"Standardmäßig ist für den Zugriff des Administrators auf die webbasierten Konfigurationsseiten Ihres neuen D-Link Routers kein Kennwort konfiguriert. Legen Sie bitte unten ein Kennwort fest, um Ihr neues Netzwerkgerät abzusichern. Die Aktivierung der CAPTCHA-Grafikauthentifizierung bietet eine zusätzliche Schutzmaßnahme, um zu verhindern, dass nicht autorisierte Online-Benutzer und Hacker-Softwareprogramme auf Ihre Netzwerkeinstellungen zugreifen.", //wwa_intro_s1
	"Wählen Sie die passende Zeitzone für Ihren Standort. Diese Information ist erforderlich, um die zeitbasierten Optionen des Routers zu konfigurieren.", //wwa_intro_s2
	"Wählen Sie bitte unten Ihren Internet-Verbindungstyp:", //wwa_intro_s3
	"Dieser Assistent führt Sie Schritt für Schritt durch die Konfiguration Ihres neuen D-Link-Routers und hilft Ihnen, eine Verbindung mit dem Internet herzustellen.", //wwa_intro_wel
	"L2TP-Server-IP-Adresse (kann gleich dem Gateway sein)", //wwa_l2tp_svra
	"Wählen Sie diese Option, wenn Ihre Internetverbindung Ihnen automatisch eine IP-Adresse zur Verfügung stellt. Die meisten Kabelmodems verwenden diesen Verbindungstyp.", //wwa_msg_dhcp
	"Ist Ihr Internetdienstanbieter nicht aufgelistet oder Sie wissen nicht, wer es ist, wählen Sie den Internetverbindungstyp unten:", //wwa_msg_ispnot
	"Wählen Sie diese Option, wenn Ihre Internetverbindung einen Benutzernamen und ein Kennwort erfordert, um online zu gehen. Die meisten DSL-Modems verwenden diesen Verbindungstyp.", //wwa_msg_pppoe
	"PPTP-Client.", //wwa_msg_pptp
	"Um diesen Anschluß einzurichten, überprüfen Sie bitte, ob Sie an den D-Link Router mit dem PC angeschlossen sind, der ursprünglich an Ihrem Breitbandanschluß genutzt wurde. Klicken Sie anschließend auf &quot;MAC-Adresse Klonen&quot;, um die MAC-Adresse Ihres Computers in den D-Link Router zu kopieren.", //wwa_msg_set_dhcp
	"Um diese Verbindung einzurichten, benötigen Sie einen Benutzernamen und ein Kennwort von Ihrem Internetdienstanbieter. Wenn Sie diese Informationen nicht haben, kontaktieren Sie bitte Ihren Internetdienstanbieter.", //wwa_msg_set_pppoe
	"Um diese Verbindung einzurichten, benötigen Sie einen Benutzernamen und ein Kennwort von Ihrem Internetdienstanbieter. Sie benötigen zudem die PPTP-IP-Adresse. Wenn Sie diese Informationen nicht haben, kontaktieren Sie bitte Ihren Internetdienstanbieter.", //wwa_msg_set_pptp
	"Wählen Sie diese Option, wenn Ihr Internetdienstanbieter Ihnen IP-Adressinformationen gegeben hat, die manuell eingerichtet werden müssen.", //wwa_msg_sipa
	"Hinweis: Sie müssen möglicherweise auch einen Hostnamen angeben. Wenn Sie diese Informationen nicht haben oder wissen, kontaktieren Sie bitte Ihren Internetdienstanbieter.", //wwa_note_hostname
	"Primäre DNS-Adresse", //wwa_pdns
	"PPTP-Server-IP-Adresse (kann gleich dem Gateway sein)", //wwa_pptp_svraddr
	"Sekundäre DNS-Adresse", //wwa_sdns
	"Nicht in der Liste oder Weiß nicht", //wwa_selectisp_not
	"Benutzername- und Kennwortverbindung einrichten (L2TP)", //wwa_set_l2tp_title
	"Um diese Verbindung einzurichten, benötigen Sie eine vollständige Liste der IP-Informationen von Ihrem Internetdienstanbieter. Wenden Sie sich bitte an Ihren Internetdienstanbieter, wenn Sie über eine statische IP-Verbindung verfügen, aber Ihnen diese Inf", //wwa_set_sipa_msg
	"Verbindung mit statischer IP-Adresse einrichten", //wwa_set_sipa_title
	"BigPond-Kabelverbindung einrichten", //wwa_title_set_bigpond
	"Benutzername- und Kennwortverbindung einrichten (PPPoE)", //wwa_title_set_pppoe
	"Benutzername- und Kennwortverbindung einrichten (PPTP)", //wwa_title_set_pptp
	"Willkommen beim D-Link-Setup-Assistenten", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Benutzername- / Kennwortverbindung (L2TP)", //wwa_wanmode_l2tp
	"Benutzername- / Kennwortverbindung (PPPoE)", //wwa_wanmode_pppoe
	"Benutzername- / Kennwortverbindung (PPTP)", //wwa_wanmode_pptp
	"Verbindung mit statischer IP-Adresse", //wwa_wanmode_sipa
	"Geben Sie Ihrem Wi-Fi-Netzwerk einen Namen.", //wwz_wwl_intro_s2_1
	"Wi-Fi-Netzwerkname (SSID)", //wwz_wwl_intro_s2_1_1
	"(Bis zu 32 Zeichen verwenden)", //wwz_wwl_intro_s2_1_2
	"Richten Sie für Ihr Wi-Fi-Netzwerk ein Kennwort ein.", //wwz_wwl_intro_s2_2
	"Wi-Fi-Kennwort", //wwz_wwl_intro_s2_2_1
	"(Zwischen 8 und 63 Zeichen)", //wwz_wwl_intro_s2_2_2
	"Geben Sie Ihrem Netzwerk einen aus bis zu 32 Zeichen bestehenden Namen.", //wwz_wwl_intro_s3_1
	"Schritt 1: Willkommen BEIM SETUP-ASSISTENTEN FÜR DIE DRAHTLOSE SICHERHEIT VON D-LINK", //wwz_wwl_title_s3
	"Ungültige PPTP Server-IP-Adresse", //YM108
	"Verwenden Sie das gleiche Kennwort für die drahtlose Sicherheit auf dem 2,4 GHz sowie auf dem 5 GHz Frequenzband.", //wwl_SSP
	"Geben Sie Ihrem Wi-Fi-Netzwerk einen Namen und richten Sie ein Kennwort ein.", //wwz_wwl_intro_s0
	"Der 1. Teil der Adresse (von %s) muss eine Ganzzahl sein.", //MSG002
	"Der 2. Teil der Adresse (von %s) muss eine Ganzzahl sein.", //MSG003
	"Der 3. Teil der Adresse (von %s) muss eine Ganzzahl sein.", //MSG004
	"Der 4. Teil der Adresse (von %s) muss eine Ganzzahl sein.", //MSG005
	"%s ist ungültig.", //MSG006
	"%s darf nicht Null sein.", //MSG007
	"Das eingegebene %s Secret (Geheimnis) ist ungültig.", //MSG008
	"Das eingegebene %s Secret (Geheimnis) ist ungültig.", //MSG009
	"Für %s ist die Eingabe zu Loopback-IP oder Multicast-IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x) nicht zulässig.", //MSG010
	"Geben Sie einen anderen %s-Wert ein.", //MSG012
	"%s muss ein numerischer Wert sein.", //MSG013
	"Der Bereich von %s ist %1n ~ %2n.", //MSG014
	"Der Wert von %s muss eine Ganzzahl sein.", //MSG015
	"Der Schlüssel ist ungültig. Er muss 5 Zeichen oder 10 hexadezimale Ziffern und Zahlen aufweisen. Ihre Eingabe:", //MSG016
	"Der Schlüssel ist ungültig. Er muss 13 Zeichen oder 26 hexadezimale Ziffern und Zahlen aufweisen. Ihre Eingabe:", //MSG017
	"Die erste Adresse von %s muss hexadezimal sein.", //MSG018
	"Die zweite Adresse von %s muss hexadezimal sein.", //MSG019
	"Die dritte Adresse von %s muss hexadezimal sein.", //MSG020
	"Die vierte Adresse von %s muss hexadezimal sein.", //MSG021
	"Die fünfte Adresse von %s muss hexadezimal sein.", //MSG022
	"Die sechste Adresse von %s muss hexadezimal sein.", //MSG023
	"Die siebte Adresse von %s muss hexadezimal sein.", //MSG024
	"Die achte Adresse von %s muss hexadezimal sein.", //MSG025
	"Der erste Bereich von %s muss zwischen folgenden Werten sein:", //MSG026
	"Der zweite Bereich von %s muss zwischen folgenden Werten sein:", //MSG027
	"Der dritte Bereich von %s muss zwischen folgenden Werten sein:", //MSG028
	"Der vierte Bereich von %s muss zwischen folgenden Werten sein:", //MSG029
	"Der fünfte Bereich von %s muss zwischen folgenden Werten sein:", //MSG030
	"Der sechste Bereich von %s muss zwischen folgenden Werten sein:", //MSG031
	"Der siebte Bereich von %s muss zwischen folgenden Werten sein:", //MSG032
	"Der achte Bereich von %s muss zwischen folgenden Werten sein:", //MSG033
	"Für %s ist die Eingabe zu Loopback-IP ( ::1 ) nicht zulässig.", //MSG034
	"Für %s ist die Eingabe zu Multicast-IP (FFxx:0:0:0:0:0:0:2 oder ffxx:0:0:0:0:0:0:2) nicht zulässig.", //MSG035
	"Ungültige Metrik", //MSG043
	"Metrischer Wert sollte zwischen (1..16) sein.", //ar_alert_3
	"Ungültige Netzmaske.", //ar_alert_5
	"Der Schlüssel", //TEXT042_1
	" is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042_2
	"Anmerkung: Sie müssen, falls notwendig, einen Service-Namen angeben. Wenn Sie diesen nicht wissen oder diese Informationen nicht haben, fragen Sie bitte Ihren ISP.", //wwa_note_svcn
	"L2TP Klient.", //wwa_msg_l2tp
	"Um diesen Anschluß einzurichten, benötigen Sie einen Benutzernamen und ein Kennwort von Ihrem Internetdienstanbieter (ISP). Zusätzlich benötigen Sie L2TP IP-Adressen. Wenn Sie diesen nicht wissen oder diese Informationen nicht haben, fragen Sie bitte Ihre", //wwa_set_l2tp_msg
	"Um diese Verbindung zu konfigurieren brauchen Sie einen Benutzernamen und ein Passwort von Ihrem Internetdienstanbieter. Sie benötigen auch die BigPond Server IP-Adresse. Wenn Sie diese Informationen nicht haben, setzen Sie sich bitte mit Ihrem Internetdi", //wwa_msg_set_bigpond
	"Hostname", //_hostname
	"2.4 GHz Band", //GW_WLAN_RADIO_0_NAME
	"5 GHz Band", //GW_WLAN_RADIO_1_NAME
	"Unten finden Sie eine ausführliche Zusammenfassung Ihrer Wireless-Sicherheitseinstellungen. Drucken Sie bitte diese Seite aus oder schreiben Sie die Informationen auf ein Stück Papier, damit Sie diese Einstellungen auf Ihren Wireless-Netzwerkkarten vorneh", //wwl_intro_end
	"bitte warten...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Verbinden", //_connect
	"Ich wünsche schrittweise Anleitungen zu den Einstellungen für die Internetverbindung", //ES_btn_guide_me
	"Grafische Authentifizierung aktivieren", //_graph_auth
	"D-LINK CORPORATION, INC | DRAHTLOSER ROUTER | HOME", //TEXT000
	"Ein L2TP-Kennwort MUSS angegeben werden", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internet nicht gefunden. Möchten Sie den Assistenten noch einmal starten?", //mydlink_tx03
	"Das Administratorkennwort muss angegeben werden.", //mydlink_tx04
	"WAN-Verbindung prüfen.", //mydlink_tx05
	"Sekunden verbleiben.", //sec_left
	"Erneut versuchen", //_retry
	"Haben Sie ein mydlink-Konto?", //mydlink_tx06
	"Ja, ich habe ein mydlink-Konto.", //mydlink_tx07
	"Nein, ich möchte mich registrieren und mich mit einem neuen mydlink-Konto anmelden.", //mydlink_tx08
	"E-Mail-Adresse (Kontoname)", //mydlink_tx09
	"Machen Sie bitte Angaben in den Optionen, um die Registrierung abzuschließen.", //mydlink_tx10
	"Kennwort bestätigen", //chk_pass
	"Nachname", //Lname
	"Vorname", //Fname
	"Ich akzeptiere die für mydlink geltenden Nutzungsbedingungen.", //mydlink_tx12
	"Um Ihre Registrierung für mydlink zum Abschluss zu bringen, prüfen Sie bitte die für Sie im Posteingang eingegangene E-Mail mit entsprechenden Bestätigungsanweisungen.", //mydlink_tx13_1
	" Klicken Sie nach Bestätigung Ihrer E-Mail-Adresse auf 'Anmelden'.", //mydlink_tx13_2
	"Anmeldung", //_login
	"OK", //_ok
	"Speichern", //_save
	"Die beiden Kennwörter müssen übereinstimmen. Geben Sie sie noch einmal ein.", //_pwsame
	"Um die Funktionen von <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> und die mydlink Lite Applikationen zu verwenden, benötigen Sie ein Konto bei <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Wenn Sie bereits ein Konto haben, wählen Sie <strong>Ja, ich habe ein mydlink-Konto</strong> und klicken Sie auf 'Weiter', um den Router unter <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a> zu registrieren. ", //mydlink_reg_into_2
	"Falls Sie kein Konto haben, wählen Sie <strong>Nein, ich möchte mich registrieren und mich mit einem neuen mydlink-Konto anmelden</strong> und klicken Sie auf 'Weiter', um ein Konto zu erstellen. ", //mydlink_reg_into_3
	" Falls Sie sich nicht für den mydlink-Dienst anmelden möchten, klicken Sie bitte auf 'Abbrechen'.", //mydlink_reg_into_4_a
	"Dieser E-Mail-Adresse ist bereits ein mydlink-Konto zugeordnet. Versuchen Sie eine andere E-Mail-Adresse.", //mydlink_pop_01
	"Um fortzufahren, müssen Sie die Nutzungsbedingungen akzeptieren.", //mydlink_pop_02
	"sollte nicht leer sein.", //mydlink_pop_03
	"ist ungültig.", //mydlink_pop_04
	"Sie können nun den mydlink-Dienst mit diesem Gerät nutzen", //mydlink_pop_05
	"Anmeldung fehlgeschlagen", //mydlink_pop_06
	"Anmelden", //_signup
	"(GMT+07:00) Nowosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Sobald die mydlink-Registrierung abgeschlossen ist, wird die standardmäßige PPPoE-, L2TP-, PPTP-Verbindung Ihres Routers auf ''Always On'' (Immer aktiv) gesetzt. Falls Ihr Internetdienstanbieter für die Nutzung eine Gebühr erhebt, möchten Sie eventuell manuell die Option ''Dial On Demand'' (Einwahl nach Bedarf) als Ihre Standardeinstellung wählen.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"Das SSID-Feld darf nicht leer sein.", //SSID_EMPTY_ERROR
	"Die eingegebenen Kennwörter stimmen nicht überein.", //YM102
	"Es MUSS ein PPPoE-Kennwort angegeben werden.", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Überspringen", //_skip
	" Falls Sie sich nicht für den mydlink-Dienst anmelden möchten, klicken Sie bitte auf 'Überspringen'.", //mydlink_reg_into_4
	"Wi-Fi-Einstellung speichern", //mydlink_WiFi_save
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
