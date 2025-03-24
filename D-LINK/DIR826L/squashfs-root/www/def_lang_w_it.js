//Version=1.01b02
//Language=Italian
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Annulla", //_cancel
	"Copia indirizzo MAC PC", //_clone
	"Connessione DHCP (indirizzo IP dinamico)", //_dhcpconn
	"Indirizzo IP", //_ipaddr
	"L2TP", //_L2TP
	"Indirizzo IP gateway L2TP", //_L2TPgw
	"Indirizzo IP L2TP", //_L2TPip
	"Subnet mask L2TP", //_L2TPsubnet
	"Lingua", //_Language
	"Indirizzo MAC", //_macaddr
	"Avanti", //_next
	"No", //_no
	"(facoltativo)", //_optional
	"Password", //_password
	"Indirizzo IP gateway PPTP", //_PPTPgw
	"Indirizzo IP PPTP", //_PPTPip
	"Subnet mask PPTP", //_PPTPsubnet
	"Indietro", //_prev
	"Verificare che le due password admin siano uguali e riprovare.", //_pwsame_admin
	"IP statico", //_sdi_staticip
	"Subnet mask", //_subnet
	"Nome utente", //_username
	"Verifica password", //_verifypw
	"Annullare tutte le modifiche apportate alla procedura guidata?", //_wizquit
	"Sì", //_yes
	"Indirizzo IP del server L2TP non valido", //bwn_alert_17
	"Modalità indirizzo", //bwn_AM
	"Server BigPond", //bwn_BPS
	"TKIP e AES", //bws_CT_3
	"IP dinamico", //carriertype_ct_0
	"Il router sta rilevando il tipo della connessione Internet. Attendere…", //ES_auto_detect_desc
	"Il router non è in grado di rilevare il tipo della connessione Internet.", //ES_auto_detect_failed_desc
	"Impostare come segnalibro \"Gestione Web router D-Link\"?", //ES_bookmark
	"Riprovare", //ES_btn_try_again
	"Collegare un'estremità del cavo Ethernet fornito con il router alla porta INTERNET sul retro del router. Collegare l'altra estremità del cavo alla porta Ethernet del modem.", //ES_cable_lost_desc
	"Passo 2: configurazione della protezione Wi-Fi", //ES_step_wifi_security
	"Passo 3: impostazione della password", //ES_title_s3
	"Passo 4: selezione del fuso orario", //ES_title_s4
	"Passo 5: salvataggio delle impostazioni", //ES_title_s5
	"Passo 5: conferma delle impostazioni Wi-Fi", //ES_title_s5_0
	"Passo 6: registrazione a mydlink", //ES_title_s6
	"registrazione a mydlink", //ES_title_s6_myd
	"Passo 1: configurazione della connessione Internet", //ES_wwa_title_s1
	"Nome di client DHCP non valido", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Password DHCP+ non valida", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nome utente DHCP+ non valido", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Specificare un nome utente L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"Specificare una password PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Chiave di rete non valida.", //IPV6_TEXT2
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
	"Immettere un nome utente", //PPP_USERNAME_EMPTY
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
	"(GMT - 5.00 h) Bogotà, Lima, Quito", //up_tz_11
	"(GMT - 5.00 h) Fuso orientale (USA/Canada)", //up_tz_12
	"(GMT - 5.00 h) Indiana (Est)", //up_tz_13
	"(GMT - 4.00 h) Ora costa atlantica (Canada)", //up_tz_14
	"(GMT - 4.00 h) Caracas, La Paz", //up_tz_15
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
	"(GMT + 1.00 h) Amsterdam, Berlino, Berna, Roma, Stoccolma", //up_tz_26
	"(GMT + 1.00 h) Belgrado, Bratislava, Lubiana", //up_tz_27
	"(GMT + 1.00 h) Bruxelles, Copenaghen, Madrid, Parigi", //up_tz_28
	"(GMT+1.00 h) Sarajevo, Skopje, Sofia, Vilnius, Zagabria", //up_tz_29
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
	"(GMT + 3.00 h) Teheran", //up_tz_41
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
	"Impostazioni DNS", //wwa_dnsset
	"Indirizzo gateway", //wwa_gw
	"Per impostazione predefinita, il nuovo router D-Link non dispone di una password configurata per l'accesso amministratore alle pagine di configurazione basate sul Web. Per proteggere il nuovo dispositivo di rete, impostare e verificare una password di seguito. L'abilitazione dell'autenticazione grafica CAPTCHA costituisce un'ulteriore misura di protezione per impedire ad utenti malintenzionato e malware di accedere alle impostazioni di rete.", //wwa_intro_s1
	"Selezionare il fuso orario appropriato per la propria area. Queste informazioni sono necessarie per configurare le opzioni del router correlate all'ora.", //wwa_intro_s2
	"Selezionare un tipo di connessione Internet tra quelli seguenti:", //wwa_intro_s3
	"Questa procedura guidata assiste l'utente nelle varie fasi della configurazione di un nuovo router D-Link e della connessione a Internet.", //wwa_intro_wel
	"Indirizzo IP server L2TP (può essere uguale al gateway)", //wwa_l2tp_svra
	"Scegliere questa opzione se la connessione Internet fornisce automaticamente l'indirizzo IP. Questo tipo di connessione viene utilizzata con la maggior parte dei modem cavo.", //wwa_msg_dhcp
	"Se l'ISP non è presente in elenco o non è noto, selezionare il tipo di connessione Internet di seguito:", //wwa_msg_ispnot
	"Scegliere questa opzione se per connettersi a Internet è necessario immettere un nome utente e una password. Questo tipo di connessione viene utilizzata con la maggior parte dei modem DSL.", //wwa_msg_pppoe
	"Client PPTP.", //wwa_msg_pptp
	"Per configurare questa connessione assicuratevi di essere collegati al D-Link Router con il PC che originalmente era collegato alla vostra connessione broadband. Se così fosse cliccate sul pulsante ‘Clonare MAC address’ per copiare l’indirizzo  MAC della scehda di rete del vostro PC e darlo al  D-Link Router.", //wwa_msg_set_dhcp
	"Per configurare la connessione, è necessario disporre del nome utente e della password forniti dal provider di servizi Internet (ISP). Se non si dispone di queste informazioni, contattare l'ISP.", //wwa_msg_set_pppoe
	"Per configurare la connessione, è necessario disporre del nome utente e della password forniti dal provider di servizi Internet (ISP). È inoltre necessario l'indirizzo IP PPTP. Se non si dispone di queste informazioni, contattare l'ISP.", //wwa_msg_set_pptp
	"Scegliere questa opzione se il provider di servizi Internet ha fornito le informazioni sugli indirizzi IP da configurare manualmente.", //wwa_msg_sipa
	"Nota: potrebbe essere necessario specificare un nome host. Se queste informazioni non sono disponibili o sono sconosciute, contattare l'ISP.", //wwa_note_hostname
	"Indirizzo DNS primario", //wwa_pdns
	"Indirizzo IP server PPTP (può essere uguale al gateway)", //wwa_pptp_svraddr
	"Indirizzo DNS secondario", //wwa_sdns
	"Non in elenco o non noto", //wwa_selectisp_not
	"Imposta connessione con nome utente e password (L2TP)", //wwa_set_l2tp_title
	"Per configurare la connessione, è necessario disporre di un elenco completo di indirizzi IP fornito dal provider di servizi Internet (ISP). Se la connessione è di tipo IP statico e non si dispone di queste informazioni, contattare l'ISP.", //wwa_set_sipa_msg
	"Imposta connessione con indirizzo IP statico", //wwa_set_sipa_title
	"Imposta connessione BigPond via cavo", //wwa_title_set_bigpond
	"Imposta connessione con nome utente e password (PPPoE)", //wwa_title_set_pppoe
	"Imposta connessione con nome utente e password (PPTP)", //wwa_title_set_pptp
	"Configurazione guidata di D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Connessione con nome utente/password (L2TP)", //wwa_wanmode_l2tp
	"Connessione con nome utente/password (PPPoE)", //wwa_wanmode_pppoe
	"Connessione con nome utente/password (PPTP)", //wwa_wanmode_pptp
	"Connessione con indirizzo IP statico", //wwa_wanmode_sipa
	"Assegnare un nome alla rete Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nome della rete Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Massimo 32 caratteri)", //wwz_wwl_intro_s2_1_2
	"Assegnare una password per la rete Wi-Fi.", //wwz_wwl_intro_s2_2
	"Password Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(Da 8 a 63 caratteri)", //wwz_wwl_intro_s2_2_2
	"Assegnare alla rete un nome composto da un massimo di 32 caratteri.", //wwz_wwl_intro_s3_1
	"Passo 1: benvenuti alla CONFIGURAZIONE GUIDATA PROTEZIONE WIRELESS D-LINK", //wwz_wwl_title_s3
	"Indirizzo IP del server PPTP non valido", //YM108
	"Utilizza la stessa password di protezione wireless sia per la banda a 2,4 GHz che per quella a 5 GHz.", //wwl_SSP
	"Assegnare un nome e una password per la rete Wi-Fi.", //wwz_wwl_intro_s0
	"Il primo indirizzo di %s deve essere un numero intero.,", //MSG002
	"Il secondo indirizzo di %s deve essere un numero intero.,", //MSG003
	"Il terzo indirizzo di %s deve essere un numero intero.,", //MSG004
	"Il quarto indirizzo di %s deve essere un numero intero.,", //MSG005
	"%s è un indirizzo non valido.", //MSG006
	"Il valore di %s non può essere zero.,", //MSG007
	"Il segreto %s immesso non è valido,", //MSG008
	"Il segreto %s immesso non è valido,", //MSG009
	"%s non consente l'accesso a indirizzi IP di loopback o multicast (127.x.x.x, da 224.x.x.x a 239.x.x.x).", //MSG010
	"Immettere un altro valore di %s.,", //MSG012
	"Il valore di %s deve essere numerico.,", //MSG013
	"L'intervallo di %s è da %1n a %2n.,", //MSG014
	"Il valore di %s deve essere un numero pari.", //MSG015
	"Chiave non valida. La chiave deve essere composta da 5 caratteri o 10 numeri esadecimali. È stato immesso", //MSG016
	"Chiave non valida. La chiave deve essere composta da 13 caratteri o 26 numeri esadecimali. È stato immesso", //MSG017
	"Il primo indirizzo di %s deve essere un valore esadecimale.,", //MSG018
	"Il secondo indirizzo di %s deve essere un valore esadecimale.,", //MSG019
	"Il terzo indirizzo di %s deve essere un valore esadecimale.,", //MSG020
	"Il quarto indirizzo di %s deve essere un valore esadecimale.,", //MSG021
	"Il quinto indirizzo di %s deve essere un valore esadecimale.,", //MSG022
	"Il sesto indirizzo di %s deve essere un valore esadecimale.,", //MSG023
	"Il settimo indirizzo di %s deve essere un valore esadecimale.,", //MSG024
	"L'ottavo indirizzo di %s deve essere un valore esadecimale.,", //MSG025
	"Il primo intervallo di %s deve essere compreso tra ,", //MSG026
	"Il secondo intervallo di %s deve essere compreso tra ,", //MSG027
	"Il terzo intervallo di %s deve essere compreso tra ,", //MSG028
	"Il quarto intervallo di %s deve essere compreso tra ,", //MSG029
	"Il quinto intervallo di %s deve essere compreso tra ,", //MSG030
	"Il sesto intervallo di %s deve essere compreso tra ,", //MSG031
	"Il settimo intervallo di %s deve essere compreso tra ,", //MSG032
	"L'ottavo intervallo di %s deve essere compreso tra ,", //MSG033
	"%s non consente l'accesso all'IP di loopback ( ::1 ).,", //MSG034
	"%s non consente l'accesso all'IP multicast (FFxx:0:0:0:0:0:0:2 o ffxx:0:0:0:0:0:0:2).", //MSG035
	"Metrico non valido", //MSG043
	"Il valore della metrica dovrebbe essere comprso fra (1..16).", //ar_alert_3
	"Netmask non valida.", //ar_alert_5
	"Chiave", //TEXT042_1
	" is wrong, the legal characters are 0~9, A~F, or a~f.", //TEXT042_2
	"Nota: Potreste aver anche bisogno di fornire il nome del Service Provider. Se non avete o non conoscete queste informazioni mettatevi in contatto con il vostro ISP.", //wwa_note_svcn
	"Client L2TP.", //wwa_msg_l2tp
	"Per inpostare questo collegamento dovrete avere un nome utente ed una password fornitavi dal vostro Internet Service Provider. Inoltre avete bisogno di un indirizzo IP L2TP. Se non avete queste informazioni mettetevi in contatto con il vostro ISP.", //wwa_set_l2tp_msg
	"Per impostare la vostra connessione ad Internet dovete avere un nome utente e una password fornetevidal vostro Internet Service Provider. Inoltre avete bisogno dell’indirizzo di un server BigPond . Se non avete queste informazioni, mettetevi in contatto c", //wwa_msg_set_bigpond
	"Nome host", //_hostname
	"Banda 2,4GHz", //GW_WLAN_RADIO_0_NAME
	"Banda 5 GHz", //GW_WLAN_RADIO_1_NAME
	"Di seguito troverete un sommario dettagliato delle vostre impostazioni di sicurezza della rete senza-fili. Stampate o trascrivete questa pagina per poter configurare correttamente i vostri client senza-fili.", //wwl_intro_end
	"Attendere...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
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
	"non valida.", //mydlink_pop_04
	"È ora possibile utilizzare il servizio mydlink con questo dispositivo", //mydlink_pop_05
	"Accesso non riuscito", //mydlink_pop_06
	"Effettua registrazione", //_signup
	"(GMT + 7.00 h) Novosibirsk", //up_tz_74
	"(GMT + 12.00 h) Magadan", //up_tz_75
	"Una volta completata la registrazione a mydlink, la connessione PPPoE, L2TP o PPTP predefinita del router verrà impostata su Sempre attiva. Se l'ISP prevede l'addebito in base all'utilizzo, è consigliabile scegliere manualmente la connessione a richiesta come impostazione predefinita.", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"Il campo SSID è obbligatorio", //SSID_EMPTY_ERROR
	"Le password inserite non corrispondono", //YM102
	"Specificare una password PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Ignora", //_skip
	" Se non si desidera effettuare la registrazione al servizio mydlink, fare clic su Ignora.", //mydlink_reg_into_4
	"Salvataggio delle impostazioni Wi-Fi", //mydlink_WiFi_save
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
