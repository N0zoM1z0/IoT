//Version=1.03b02
//Language=Italian
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Annulla", //_cancel
	"Copia l'indirizzo MAC del PC", //_clone
	"Collegamento con DHCP (Indirizzo IP Dinamico)", //_dhcpconn
	"Indirizzo IP", //_ipaddr
	"L2TP", //_L2TP
	"indirizzo IP del gateway L2TP", //_L2TPgw
	"indirizzo IP L2TP", //_L2TPip
	"Subnet mask L2TP", //_L2TPsubnet
	"Language", //_Language
	"Indirizzo MAC", //_macaddr
	"Avanti", //_next
	"No", //_no
	"(opzionale)", //_optional
	"Password", //_password
	"indirizzo IP del gateway PPTP", //_PPTPgw
	"indirizzo IP PPTP", //_PPTPip
	"subnet mask PPTP", //_PPTPsubnet
	"Indietro", //_prev
	"Far corrispondere le due password amministratore e ripro", //_pwsame_admin
	"IP statico", //_sdi_staticip
	"Subnet mask", //_subnet
	"Nome utente", //_username
	"Verifica password", //_verifypw
	"Annullare tutte le modifiche apportate alla procedura guidata?", //_wizquit
	"Sì", //_yes
	"Indirizzo IP del server L2TP non valido", //bwn_alert_17
	"MOdalità Indirizzo", //bwn_AM
	"server BigPond", //bwn_BPS
	"TKIP e AES", //bws_CT_3
	"IP dinamico", //carriertype_ct_0
	"Il router sta rilevando il tipo della connessione Internet. Attendere...", //ES_auto_detect_desc
	"Il router non è in grado di rilevare il tipo di connessione Internet.", //ES_auto_detect_failed_desc
	"Aggiungere un segnalibro per \"Gestione router D-Link tramite Web\"?", //ES_bookmark
	"Riprovare", //ES_btn_try_again
	"Collegare un'estremità del cavo Ethernet fornito con il router alla porta INTERNET sul retro del router. Collegare l'altra estremità del cavo alla porta Ethernet del modem, quindi riavviare il modem.", //ES_cable_lost_desc
	"Passo 2: configurazione della protezione Wi-Fi", //ES_step_wifi_security
	"Passo 3: impostazione della password", //ES_title_s3
	"Passo 4: selezione del fuso orario", //ES_title_s4
	"Passo 5: salvataggio delle impostazioni", //ES_title_s5
	"Passo 5: conferma delle impostazioni Wi-Fi", //ES_title_s5_0
	"Passo 6: registrazione a mydlink", //ES_title_s6
	"registrazione a mydlink", //ES_title_s6_myd
	"Passo 1: configurazione della connessione Internet", //ES_wwa_title_s1
	"Nome client DHCP invalido", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Password DHCP+ non valida", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nome utente DHCP+ non valido", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"È OBBLIGATORIO specificare un nome utente L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"É OBBLIGATORIO specificare una password PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Chiave di rete non valida!", //IPV6_TEXT2
	"Indirizzo MAC non valido", //KR3
	"Automatico (WPA o WPA2) - Personale", //KR48
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"ATAT DSL Service", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Cavo Earthlink", //manul_conn_10
	"DSL Earthlink", //manul_conn_11
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
	"La registrazione del prodotto in mydlink consente di utilizzarne le funzionalità abilitate per questo sito, incluso l'accesso e la gestione online del dispositivo tramite il sito Web mydlink.", //mydlink_tx01
	"Registrare il dispositivo in mydlink?", //mydlink_tx02
	"Immettere un nome utente,", //PPP_USERNAME_EMPTY
	"PPPoE Plus supportato", //pppoe_plus_dail
	"La password può contenere solo caratteri stampabili.", //S493
	"SALVATAGGIO IMPOSTAZIONI", //save_settings
	"Salvataggio delle impostazioni in corso.", //save_wait
	"Versione firmware", //sd_FWV
	"Pagina prodotto", //TA2
	"Versione hardware", //TA3
	"(GMT - 12.00 h) Eniwetok, Kwajalein", //up_tz_00
	"(GMT - 11.00 h) Isole Midway, Samoa", //up_tz_01
	"(GMT - 10.00 h) Hawaii", //up_tz_02
	"(GMT - 9.00 h) Alaska", //up_tz_03
	"(GMT - 8.00 h) ora del Pacifico (USA/Canada), Tijuana", //up_tz_04
	"(GMT - 7.00 h) Arizona", //up_tz_05
	"(GMT - 7.00 h) Fuso occidentale (USA/Canada)", //up_tz_06
	"(GMT - 6.00 h) America centrale", //up_tz_07
	"(GMT - 6.00 h) Fuso centrale (USA/Canada)", //up_tz_08
	"(GMT - 6.00 h) Città del Messico", //up_tz_09
	"(GMT - 6.00 h) Saskatchewan", //up_tz_10
	"(GMT - 5.00 h) Bogotà Lima, Quito", //up_tz_11
	"(GMT - 5.00 h) Fuso orientale (USA/Canada)", //up_tz_12
	"(GMT - 5.00 h) Indiana (Est)", //up_tz_13
	"(GMT - 4.00 h) Ora costa atlantica (Canada)", //up_tz_14
	"(GMT - 04.00 h) Caracas, La Paz", //up_tz_15
	"(GMT - 4.00 h) Santiago", //up_tz_16
	"(GMT - 3.30 h) Terranova", //up_tz_17
	"(GMT - 3.00 h) Brasilia", //up_tz_18
	"(GMT - 3.00 h) Buenos Aires, Georgetown", //up_tz_19
	"(GMT - 3.00 h) Groenlandia", //up_tz_20
	"(GMT - 2.00 h) Medioatlantico", //up_tz_21
	"(GMT - 1.00 h) Azzorre", //up_tz_22
	"(GMT - 1.00 h) Isole di Capo Verde", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Ora di Greenwich: Dublino, Edimburgo, Lisbona, Londra", //up_tz_25
	"(GMT + 1.00 h) Amsterdam, Berlino, Berna, Roma, Stoccolma, Vienna", //up_tz_26
	"(GMT + 1.00 h) Belgrado, Bratislava, Budapest, Lubiana, Praga", //up_tz_27
	"(GMT + 1.00 h) Bruxelles, Copenaghen, Madrid, Parigi", //up_tz_28
	"(GMT + 1.00 h) Sarajevo, Skopje, Sofia, Vilnius, Zagabria", //up_tz_29
	"(GMT + 1.00 h) Budapest, Vienna, Praga, Varsavia", //up_tz_29b
	"(GMT + 1.00 h) Africa centro-occidentale", //up_tz_30
	"(GMT + 2.00 h) Atene, Istanbul, Minsk", //up_tz_31
	"(GMT + 2.00 h) Bucarest", //up_tz_32
	"(GMT + 2.00 h) Cairo", //up_tz_33
	"(GMT + 2.00 h) Harare, Pretoria", //up_tz_34
	"(GMT + 2.00 h) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT + 2.00 h) Gerusalemme", //up_tz_36
	"(GMT + 3.00 h) Bagdad", //up_tz_37
	"(GMT + 3.00 h) Kuwait, Riyad", //up_tz_38
	"(GMT + 4.00 h) Mosca, S. Pietroburgo, Volgograd", //up_tz_39
	"(GMT + 3.00 h) Nairobi", //up_tz_40
	"(GMT + 3.30 h) Teheran", //up_tz_41
	"(GMT + 4.00 h) Abu Dhabi, Muscat", //up_tz_42
	"(GMT + 4.00 h) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT + 4.30 h) Kabul", //up_tz_44
	"(GMT + 6.00 h) Ekaterinburg", //up_tz_45
	"(GMT + 5.00 h) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT + 5.30 h) Kolkata (Calcutta), Chennai, Mumbai, Nuova Delhi", //up_tz_47
	"(GMT + 5.45 h) Kathmandu", //up_tz_48
	"(GMT + 6.00 h) Almaty", //up_tz_49
	"(GMT + 6.00 h) Astana, Dhaka", //up_tz_50
	"(GMT + 6.00 h) Sri Jayawardenepura", //up_tz_51
	"(GMT + 6.30 h) Rangoon", //up_tz_52
	"(GMT + 7.00 h) Bangkok, Hanoi, Giacarta", //up_tz_53
	"(GMT + 8.00 h) Krasnoyarsk", //up_tz_54
	"(GMT + 8.00 h) Pechino, Chongqing, Hong Kong, Urumchi", //up_tz_55
	"(GMT + 9.00 h) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT + 8.00 h) Kuala Lumpur, Singapore", //up_tz_57
	"(GMT + 8.00 h) Perth", //up_tz_58
	"(GMT + 8.00 h) Taipei", //up_tz_59
	"(GMT + 9.00 h) Osaka, Sapporo, Tokyo", //up_tz_60
	"(GMT + 9.00 h) Seul", //up_tz_61
	"(GMT + 10.00 h) Yakutsk", //up_tz_62
	"(GMT + 9.30 h) Adelaide", //up_tz_63
	"(GMT + 9.30 h) Darwin", //up_tz_64
	"(GMT + 10.00 h) Brisbane", //up_tz_65
	"(GMT + 10.00 h) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT + 10.00 h) Guam, Port Moresby", //up_tz_67
	"(GMT + 10.00 h) Hobart", //up_tz_68
	"(GMT + 11.00 h) Vladivostok", //up_tz_69
	"(GMT + 11.00 h) Is. Salomone, Nuova Caledonia", //up_tz_70
	"(GMT + 12.00 h) Auckland, Wellington", //up_tz_71
	"(GMT + 12.00 h) Figi, Kamcatka, Is. Marshall", //up_tz_72
	"(GMT + 13.00 h) Nuku'alofa, Tonga", //up_tz_73
	"(GMT + 7.00 h) Novosibirsk", //up_tz_74
	"(GMT + 12.00 h) Magadan", //up_tz_75
	"(GMT - 12.00 h) Linea cambiamento data internazionale (occidentale)", //up_tz_76
	"(GMT - 11.00 h) Isole Midway", //up_tz_77
	"(GMT - 7.00 h) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT - 6.00 h) Guadalajara, Città del Messico, Monterrey", //up_tz_79
	"(GMT - 5.00 h) Bogotà, Lima, Quito, Indiana (Est)", //up_tz_80
	"(GMT - 4.30 h) Caracas", //up_tz_81
	"(GMT - 4.00 h) Georgetown, La Paz", //up_tz_82
	"(GMT - 3.00 h) Buenos Aires", //up_tz_83
	"(GMT + 1.00 h) Sarajevo, Skopje, Varsavia, Zagabria", //up_tz_84
	"(GMT + 2.00 h) Helsinki, Kiev, Riga, Sofia, Tallinn, Vilnius", //up_tz_85
	"(GMT + 5.30 h) Chennai, Kolkata (Calcutta), Mumbai, Nuova Delhi", //up_tz_86
	"(GMT + 7.00 h) Almaty, Novosibirsk", //up_tz_87
	"(GMT + 5.30 h) Sri Jayawardenepura", //up_tz_88
	"(GMT + 8.00 h) Ulaan Bataar", //up_tz_89
	"(GMT + 9.00 h) Irkutsk", //up_tz_90
	"(GMT + 13.00 h) Nuku'alofa", //up_tz_91
	"(GMT + 13.00 h) Samoa", //up_tz_92
	"Impostazioni DNS", //wwa_dnsset
	"Indirizzo gateway", //wwa_gw
	"Per impostazione predefinita, il nuovo router D-Link non dispone di una password configurata per l'accesso amministratore alle pagine di configurazione basate sul Web. Per proteggere il nuovo dispositivo di rete, impostare e verificare una password di seguito. L'abilitazione dell'autenticazione grafica CAPTCHA costituisce un'ulteriore misura di protezione per impedire ad utenti malintenzionato e malware di accedere alle impostazioni di rete.", //wwa_intro_s1
	"Selezionare il fuso orario appropriato per la propria area. Queste informazioni sono necessarie per configurare le opzioni correlate all'ora. Il router verrà impostato in modo da aggiornare il proprio orologio interno in base a un server di riferimento ora NTP.", //wwa_intro_s2
	"Selezionare un tipo di connessione Internet tra quelli seguenti:", //wwa_intro_s3
	"Questo wizard vi guiderà con un processo graduale per configurare il vostro nuovo D-Link router e collegarvi ad Internet.", //wwa_intro_wel
	"Indirizzo IP server L2TP (può corrispondere a quello del gateway)", //wwa_l2tp_svra
	"Scelgiete questo se il vostro collegamento ad Internet vi fornisce automaticamente un Indirizzo IP. La maggior parte dei Modem usano questo tipo di collegamento.", //wwa_msg_dhcp
	"Se il vostro Internet Service Provider non fosse elencato o non lo conoscete, selezionate il tipo di collegamento di Internet qui sotto:", //wwa_msg_ispnot
	"Scegliere questa opzione se per connettersi a Internet è necessario immettere un nome utente e una password. Questo tipo di connessione viene utilizzato con la maggior parte dei modem DSL.", //wwa_msg_pppoe
	"Client PPTP.", //wwa_msg_pptp
	"Per configurare questa connessione assicuratevi di essere collegati al D-Link Router con il PC che originalmente era collegato alla vostra connessione broadband. Se così fosse cliccate sul pulsante ‘Clonare MAC address’ per copiare l’indirizzo  MAC della scehda di rete del vostro PC e darlo al  D-Link Router.", //wwa_msg_set_dhcp
	"Per impostare questo collegamento dovrete avere un nome utente ed una paasword fornitevi dal vostro Internet Service Provider (ISP). Se non avete queste informazioni mettetevi in contatto con il vostro ISP.", //wwa_msg_set_pppoe
	"Per impostare questo collegamento dovrete avere un nome utente ed una password fornitevi dal vostro Internet Service Provider (ISP). Inoltre avete bisogno dell’indirizzo IP del server PPTP. Se non avete queste informazioni mettetevi in contatto con il vostro ISP.", //wwa_msg_set_pptp
	"Scelgliete questa opzione se il vostro Internet Setup Provider (ISP) vi fornisce dei parametri di connessione  IP che devono essere inseriti manualmente.", //wwa_msg_sipa
	"Nota: Potreste anche avere bisogno di fornire un Host name. Se non avete o non conoscete questa informazione mettetevi in contatto con il vostro ISP.", //wwa_note_hostname
	"Indirizzo DNS primario", //wwa_pdns
	"Indirizzo IP del server PPTP (puo essere lo stesso del gateway)", //wwa_pptp_svraddr
	"Indirizzo DNS secondario", //wwa_sdns
	"Non elencato o non conosciuto", //wwa_selectisp_not
	"Impostare il nome utente e la password per il Collegamento (L2TP)", //wwa_set_l2tp_title
	"Per impostare questo collegamento avrete bisogno di una lista completa di informazioni IP fornitavi dal vostro Internet Service Provider. Se avete un IP pubblico statico e non avete queste informazioni, mettetevi in contatto con il vostro ISP.", //wwa_set_sipa_msg
	"Impostare l’indirizzo IP Statico di collegamento", //wwa_set_sipa_title
	"Impostare la connessione via cavo BigPond", //wwa_title_set_bigpond
	"Impostare il nome utente e la password per il Collegamento (PPPoE)", //wwa_title_set_pppoe
	"Imposta connessione con nome utente e password (PPTP)", //wwa_title_set_pptp
	"Configurazione guidata di D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Username e Password di connessione (L2TP)", //wwa_wanmode_l2tp
	"Username e Password di connessione (PPPoE)", //wwa_wanmode_pppoe
	"Username e Password di connessione (PPTP)", //wwa_wanmode_pptp
	"Indirizzo  IP Statico di collegamento", //wwa_wanmode_sipa
	"Assegnare un nome alla rete Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nome della rete Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Massimo 32 caratteri)", //wwz_wwl_intro_s2_1_2
	"Assegnare una password per la rete Wi-Fi.", //wwz_wwl_intro_s2_2
	"Password Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(da 8 a 63 caratteri)", //wwz_wwl_intro_s2_2_2
	"Assegnare un nome alla rete, utilizzando fino a 32 caratteri.", //wwz_wwl_intro_s3_1
	"Passo 1: benvenuti alla CONFIGURAZIONE GUIDATA PROTEZIONE WIRELESS D-LINK", //wwz_wwl_title_s3
	"Indirizzo IP del server PPTP invalido", //YM108
	"Utilizza la stessa password di protezione wireless sia per la banda a 2,4 GHz che per quella a 5 GHz.", //wwl_SSP
	"Assegnare un nome e una password per la rete Wi-Fi.", //wwz_wwl_intro_s0
	"Il primo indirizzo di %s deve essere un numero intero.,", //MSG002
	"Il secondo indirizzo di %s deve essere un numero intero.,", //MSG003
	"Il terzo indirizzo di %s deve essere un numero intero.,", //MSG004
	"Il quarto indirizzo di %s deve essere un numero intero.,", //MSG005
	"%s è un indirizzo non valido.", //MSG006
	"Il valore di %s non può essere zero.,", //MSG007
	"La porta %s immessa non è valida.", //MSG008
	"Il segreto %s immesso non è valido,", //MSG009
	"%s non consente l'accesso a indirizzi IP di loopback o multicast (127.x.x.x, da 224.x.x.x a 239.x.x.x).", //MSG010
	"Immettere un altro valore di %s.", //MSG012
	"Il valore di %s deve essere numerico.,", //MSG013
	"L'intervallo di %s è da %1n a %2n.,", //MSG014
	"Il valore di %s deve essere un numero pari.", //MSG015
	"Chiave non valida. La chiave deve essere composta da 5 caratteri o 10 numeri esadecimali. È stato immesso", //MSG016
	"Chiave non valida. La chiave deve essere composta da 13 caratteri o 26 numeri esadecimali. È stato immesso", //MSG017
	"Il primo indirizzo di %s deve essere un valore esadecimale.", //MSG018
	"Il secondo indirizzo di %s deve essere un valore esadecimale.", //MSG019
	"Il terzo indirizzo di %s deve essere un valore esadecimale.", //MSG020
	"Il quarto indirizzo di %s deve essere un valore esadecimale.", //MSG021
	"Il quinto indirizzo di %s deve essere un valore esadecimale.", //MSG022
	"Il sesto indirizzo di %s deve essere un valore esadecimale.", //MSG023
	"Il settimo indirizzo di %s deve essere un valore esadecimale.", //MSG024
	"L'ottavo indirizzo di %s deve essere un valore esadecimale.", //MSG025
	"Il primo intervallo di %s deve essere compreso tra", //MSG026
	"Il secondo intervallo di %s deve essere compreso tra", //MSG027
	"Il terzo intervallo di %s deve essere compreso tra", //MSG028
	"Il quarto intervallo di %s deve essere compreso tra", //MSG029
	"Il quinto intervallo di %s deve essere compreso tra", //MSG030
	"Il sesto intervallo di %s deve essere compreso tra", //MSG031
	"Il settimo intervallo di %s deve essere compreso tra", //MSG032
	"L'ottavo intervallo di %s deve essere compreso tra", //MSG033
	"%s non consente l'accesso all'IP di loopback ( ::1 ).,", //MSG034
	"%s non consente l'accesso all'IP multicast (FFxx:0:0:0:0:0:0:2 o ffxx:0:0:0:0:0:0:2).", //MSG035
	"Metrico non valido", //MSG043
	"Il valore della metrica dovrebbe essere comprso fra (1..16).", //ar_alert_3
	"Netmask non valida.", //ar_alert_5
	"Chiave", //TEXT042_1
	" errato. I caratteri ammessi sono i numeri da 0 a 9, le lettere da A a F o da a a f.", //TEXT042_2
	"Nota: Potreste aver anche bisogno di fornire il nome del Service Provider. Se non avete o non conoscete queste informazioni mettatevi in contatto con il vostro ISP.", //wwa_note_svcn
	"Client L2TP.", //wwa_msg_l2tp
	"Per inpostare questo collegamento dovrete avere un nome utente ed una password fornitavi dal vostro Internet Service Provider. Inoltre avete bisogno di un indirizzo IP L2TP. Se non avete queste informazioni mettetevi in contatto con il vostro ISP.", //wwa_set_l2tp_msg
	"Per impostare la vostra connessione ad Internet dovete avere un nome utente e una password fornetevidal vostro Internet Service Provider. Inoltre avete bisogno dell’indirizzo di un server BigPond . Se non avete queste informazioni, mettetevi in contatto c", //wwa_msg_set_bigpond
	"Nome host", //_hostname
	"Banda 2,4GHz", //GW_WLAN_RADIO_0_NAME
	"Banda 5 GHz", //GW_WLAN_RADIO_1_NAME
	"Di seguito è riportato un riepilogo dettagliato delle impostazioni di protezione Wi-Fi. Stampare la pagina oppure annotare queste informazioni per configurare le impostazioni corrette nei dispositivi Wi-Fi.", //wwl_intro_end
	"Attendere...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Connetti", //_connect
	"Guida alle impostazioni della connessione Internet", //ES_btn_guide_me
	"Abilita autenticazione grafica", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTER WIRELESS | HOME", //TEXT000
	"É OBBLIGATORIO specificare una password PPPoE", //GW_WAN_L2TP_PASSWORD_INVALID
	"Connessione Internet non rilevata. Riavviare la procedura guidata?", //mydlink_tx03
	"Specificare un valore per la password dell'amministratore.", //mydlink_tx04
	"Verifica della connettività WAN.", //mydlink_tx05
	"secondi residui.", //sec_left
	"Riprova", //_retry
	"Si dispone di un account mydlink?", //mydlink_tx06
	"Sì, dispongo di un account mydlink.", //mydlink_tx07
	"No, desidero effettuare la registrazione e accedere con un nuovo account mydlink.", //mydlink_tx08
	"Indirizzo e-mail (nome account)", //mydlink_tx09
	"Selezionare le opzioni per completare la registrazione.", //mydlink_tx10
	"Conferma password", //chk_pass
	"Cognome", //Lname
	"Nome", //Fname
	"Accetto termini e condizioni di mydlink.", //mydlink_tx12
	"Per completare la registrazione a mydlink, verificare che nella Posta in arrivo sia stato ricevuto un messaggio e-mail con istruzioni per la conferma.", //mydlink_tx13_1
	" Dopo aver confermato l'indirizzo e-mail, fare clic sul pulsante Accesso.", //mydlink_tx13_2
	"Esegui accesso", //_login
	"OK", //_ok
	"Salva", //_save
	"Specificare due password uguali e riprovare", //_pwsame
	"Per utilizzare le funzionalità di <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> e l'app mydlink Lite, è necessario disporre di un account <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Se si dispone già di un account, selezionare <strong>Sì, dispongo di un account mydlink</strong> e fare clic su Avanti per registrare il router in <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Se non si dispone di un account, selezionare <strong>No, desidero effettuare la registrazione e accedere con un nuovo account mydlink</strong> e fare clic su Avanti per creare un account. ", //mydlink_reg_into_3
	" Se non si desidera effettuare la registrazione al servizio mydlink, fare clic su Annulla.", //mydlink_reg_into_4_a
	"Per questo indirizzo e-mail è già disponibile un account mydlink. Provare con un indirizzo e-mail diverso.", //mydlink_pop_01
	"Per continuare, è necessario accettare i termini e le condizioni.", //mydlink_pop_02
	"non deve essere vuoto.", //mydlink_pop_03
	"è invalida.", //mydlink_pop_04
	"È ora possibile utilizzare il servizio mydlink con questo dispositivo", //mydlink_pop_05
	"Accesso non riuscito", //mydlink_pop_06
	"Effettua registrazione", //_signup
	"Una volta completata la registrazione a mydlink, la connessione PPPoE, L2TP o PPTP predefinita del router verrà impostata su Sempre attiva. Se l'ISP prevede l'addebito in base all'utilizzo, è consigliabile scegliere manualmente la connessione a richiesta come impostazione predefinita.", //mydlink_pop_09
	"Impossibile accedere a mydlink.", //mdl_errmsg_01
	"Invio richiesta di accesso non riuscita.", //mdl_errmsg_02
	"Impossibile inviare la richiesta di accesso.", //mdl_errmsg_03
	"Invio richiesta di iscrizione non riuscita.", //mdl_errmsg_04
	"Impossibile inviare la richiesta di iscrizione.", //mdl_errmsg_05
	"Specificare un valore nel campo SSID.", //SSID_EMPTY_ERROR
	"Le password inserite non corrispondono", //YM102
	"E OBBLIGATORIO specificare una password PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"La lunghezza della password dell'account deve essere pari ad almeno sei caratteri.", //limit_pass_msg
	"Ignora", //_skip
	" Se non si desidera effettuare la registrazione al servizio mydlink, fare clic su Ignora.", //mydlink_reg_into_4
	"Salvataggio delle impostazioni Wi-Fi", //mydlink_WiFi_save
	"PPTP Russia (Dual Access)", //rus_wan_pptp
	"Tipo di connessione Internet PPTP Russia (Dual Access)", //rus_wan_pptp_01
	"L2TP Russia (Dual Access)", //rus_wan_l2tp
	"Tipo di connessione Internet L2TP Russia (Dual Access)", //rus_wan_l2tp_01
	"PPPoE Russia (Dual Access)", //rus_wan_pppoe
	"Tipo di connessione Internet PPPoE Russia (Dual Access)", //rus_wan_pppoe_02
	"Impostazione fisica WAN", //rus_wan_pppoe_03
	"Questo dispositivo è abilitato per mydlink. È quindi possibile monitorare e gestire in remoto la rete tramite il sito Web mydlink.com oppure tramite l'app mydlink mobile.", //_wz_mydlink_into_1
	"Sarà possibile controllare la velocità della rete, sapere quali utenti sono connessi, visualizzare la cronologia di esplorazione dei dispositivi e ricevere notifiche in caso di nuovi utenti o tentativi di intrusione.", //_wz_mydlink_into_2
	"È possibile registrare questo dispositivo con l'account mydlink esistente. Se non si dispone di un account, è possibile crearne uno ora.", //_wz_mydlink_into_3
	"Controllare la cassetta postale per verificare di aver ricevuto un messaggio e-mail con istruzioni per la conferma.", //_wz_mydlink_email_1
	"Il router sta controllando la connettività Internet. Attendere...", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"Il valore della metrica dovrebbe essere comprso fra (1..15).", //ar_alert_3a
	"Indirizzo IP server", //SERVER_IP_DESC
	"L'indirizzo IP %s del gateway %s deve essere compreso nella subnet della WAN.", //TEXT043
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