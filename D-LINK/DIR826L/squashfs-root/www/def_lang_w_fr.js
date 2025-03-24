//Version=1.01b02
//Language=French
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Annuler", //_cancel
	"Copier l'adresse MAC de votre PC", //_clone
	"Connexion DHCP (adresse IP dynamique)", //_dhcpconn
	"Adresse IP", //_ipaddr
	"L2TP", //_L2TP
	"Adresse IP de la passerelle L2TP", //_L2TPgw
	"Adresse IP de L2TP", //_L2TPip
	"Masque du sous-réseau L2TP", //_L2TPsubnet
	"Langue", //_Language
	"Adresse MAC", //_macaddr
	"Suivant", //_next
	"Non", //_no
	"(en option)", //_optional
	"Mot de passe", //_password
	"Adresse IP de la passerelle PPTP", //_PPTPgw
	"Adresse IP de PPTP", //_PPTPip
	"Masque de sous-réseau PPTP", //_PPTPsubnet
	"Préc.", //_prev
	"Veuillez faire correspondre les deux mots de passe admin et réessayer", //_pwsame_admin
	"Adresse IP statique", //_sdi_staticip
	"Masque de sous-réseau", //_subnet
	"Nom d’utilisateur", //_username
	"Confirmer le mot de passe", //_verifypw
	"Voulez-vous annuler tous les changements apportés à cet assistant ?", //_wizquit
	"Oui", //_yes
	"Adresse IP du serveur L2TP incorrecte", //bwn_alert_17
	"Mode adresse", //bwn_AM
	"Serveur BigPond", //bwn_BPS
	"TKIP et AES", //bws_CT_3
	"Adresse IP dynamique", //carriertype_ct_0
	"Le routeur est en train de détecter votre type de connexion Internet, veuillez patienter...", //ES_auto_detect_desc
	"Le routeur ne parvient pas à détecter votre type de connexion Internet.", //ES_auto_detect_failed_desc
	"Voulez-vous mettre \"Gestion Web du routeur D-Link en signet\" ?", //ES_bookmark
	"Veuillez réessayer", //ES_btn_try_again
	"Branchez une extrémité du câble Ethernet joint au routeur dans le port étiqueté INTERNET à l'arrière du routeur. Branchez l’autre extrémité de ce câble au port Ethernet de votre modem.", //ES_cable_lost_desc
	"Étape 2 : Configurez votre sécurité Wi-Fi", //ES_step_wifi_security
	"Étape 3 : Définissez votre mot de passe", //ES_title_s3
	"Étape 4 : Sélectionnez votre fuseau horaire", //ES_title_s4
	"Étape 5 : Enregistrez les paramètres", //ES_title_s5
	"Étape 5 : Confirmez les paramètres Wi-Fi", //ES_title_s5_0
	"Étape 6 : Inscrivez-vous sur mydlink", //ES_title_s6
	"Inscrivez-vous sur mydlink", //ES_title_s6_myd
	"Étape 1 : Configurez votre connexion Internet", //ES_wwa_title_s1
	"Nom du client DHCP incorrect", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Mot de passe DHCP+ incorrect", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nom d'utilisateur DHCP+ incorrect", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Un nom d'utilisateur L2TP DOIT être indiqué", //GW_WAN_L2TP_USERNAME_INVALID
	"Un mot de passe PPTP DOIT être indiqué", //GW_WAN_PPTP_PASSWORD_INVALID
	"Clé de réseau incorrecte !", //IPV6_TEXT2
	"Adresse MAC incorrecte", //KR3
	"Auto (WPA ou WPA2) - Personnel", //KR48
	"Adelphia Powerlink", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"Service DSL ATAT", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Haut débit Charter", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Câble Earthlink", //manul_conn_10
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
	"US West / Qwest", //manul_conn_23
	"Verizon Online DSL", //manul_conn_24
	"XO Communications", //manul_conn_25
	"L'enregistrement de votre produit sur mydlink vous permet d'utiliser ses fonctions mydlink, notamment l'accès en ligne et la gestion de votre périphérique via le site Web mydlink.", //mydlink_tx01
	"Voulez-vous enregistrer votre périphérique sur mydlink ?", //mydlink_tx02
	"Veuillez entrer un nom d'utilisateur", //PPP_USERNAME_EMPTY
	"PPPoE Plus pris en charge", //pppoe_plus_dail
	"Le mot de passe peut contenir uniquement des caractères imprimables.", //S493
	"ENREGISTREMENT DES PARAMÈTRES", //save_settings
	"Vos paramètres sont en cours d'enregistrement.", //save_wait
	"Version du microprogramme", //sd_FWV
	"Page de produits", //TA2
	"Version matérielle", //TA3
	"(GMT-12:00) Eniwetak, Kwajalein", //up_tz_00
	"(GMT-11:00) Îles Midway, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT -08:00) Pacifique (USA/Canada), Tijuana ", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Heure des Rocheuses (États-Unis/Canada)", //up_tz_06
	"(GMT-06:00) Amérique centrale", //up_tz_07
	"(GMT-06:00) Heure du Centre (États-Unis/Canada)", //up_tz_08
	"(GMT-06:00) Mexico", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Heure de l'Est (États-Unis/Canada)", //up_tz_12
	"(GMT-05:00) Indiana (Est)", //up_tz_13
	"(GMT-04:00) Heure de l'Atlantique (Canada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Terre-Neuve", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Groenland", //up_tz_20
	"(GMT-02:00) Atlantique centrale", //up_tz_21
	"(GMT-01:00) Açores", //up_tz_22
	"(GMT-01:00) Îles du Cap-Vert", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Heure de Greenwich : Dublin, Édimbourg, Lisbonne, Londres", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlin, Berne, Rome, Stockholm", //up_tz_26
	"(GMT+01:00) Belgrade, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Bruxelles, Copenhague, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofia, Vilnius, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Vienne, Prague, Varsovie", //up_tz_29b
	"(GMT+01:00) Afrique centrale de l'Ouest", //up_tz_30
	"(GMT+02:00) Athènes, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bucarest", //up_tz_32
	"(GMT+02:00) Le Caire", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jérusalem", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Koweït, Riyad", //up_tz_38
	"(GMT+04:00) Moscou, St Petersburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Téhéran", //up_tz_41
	"(GMT+04:00) Abou Dabi, Muscat", //up_tz_42
	"(GMT+04:00) Bakou, Tbilissi, Erevan", //up_tz_43
	"(GMT+04:30) Kaboul", //up_tz_44
	"(GMT+06:00) Ekaterinbourg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tachkent", //up_tz_46
	"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi", //up_tz_47
	"(GMT+05:45) Katmandou", //up_tz_48
	"(GMT+06:00) Almaty", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT +06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoï, Jakarta", //up_tz_53
	"(GMT+08:00) Krasnoïarsk", //up_tz_54
	"(GMT+08:00) Pékin, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkoutsk, Oulan-Bator", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapour", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokyo", //up_tz_60
	"(GMT+09:00) Séoul", //up_tz_61
	"(GMT+10:00) Iakutsk", //up_tz_62
	"(GMT+09:30) Adélaïde", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Îles Salomon, Nouvelle-Calédonie", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Îles Marshall", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"Paramètres DNS", //wwa_dnsset
	"Adresse de passerelle", //wwa_gw
	"Par défaut, votre routeur D-Link ne possède aucun mot de passe configuré pour l'accès administrateur aux pages de configuration Web. Pour sécuriser votre nouveau périphérique en réseau, définissez un mot de passe ci-dessous, vérifiez-le, puis activez l'authentification graphique CAPTCHA pour une meilleure protection et éviter que des utilisateurs en ligne non autorisés et des pirates de logiciels n'accèdent à vos paramètres réseau.", //wwa_intro_s1
	"Sélectionnez le fuseau horaire correspondant à votre zone. Vous aurez besoin de ces informations pour configurer les options du routeur qui sont basées sur le temps.", //wwa_intro_s2
	"Sélectionnez votre type de connexion Internet ci-dessous :", //wwa_intro_s3
	"Cet assistant vous guidera étape par étape pour configurer votre nouveau routeur D-Link et vous connecter à Internet.", //wwa_intro_wel
	"Adresse IP du serveur L2TP (peut être identique à celle de la passerelle)", //wwa_l2tp_svra
	"Choisissez cette option si votre connexion Internet vous fournit automatiquement une adresse IP. La plupart des modems câblés utilisent ce type de connexion.", //wwa_msg_dhcp
	"Si votre fournisseur d'accès Internet n'est pas énuméré ou vous ne savez pas qui c'est, veuillez choisir le type de connexion Internet ci-dessous :", //wwa_msg_ispnot
	"Choisissez cette option si votre connexion Internet requiert un nom d'utilisateur et un mot de passe. La plupart des modems DSL utilisent ce type de connexion.", //wwa_msg_pppoe
	"Client PPTP.", //wwa_msg_pptp
	"Pour établir cette connexion, veuillez vous assurer que vous êtes reliés au D-Link Router avec le PC qui était à l'origine connecté sur votre lien haut débit. Si oui, cliquez alors sur le bouton Copie MAC pour copier l’adresse MAC de votre ordinateur sur le D-Link Router.", //wwa_msg_set_dhcp
	"Pour configurer cette connexion, vous avez besoin d'un nom d'utilisateur et d'un mot de passe fournis par votre fournisseur d'accès Internet. Si vous ne possédez pas ces informations, contactez votre fournisseur d'accès Internet.", //wwa_msg_set_pppoe
	"Pour configurer cette connexion, vous avez besoin d'un nom d'utilisateur et d'un mot de passe fournis par votre fournisseur d'accès Internet. Vous avez également besoin d'une adresse IP PPTP. Si vous ne possédez pas ces informations, contactez votre fourn", //wwa_msg_set_pptp
	"Choisissez cette option si votre fournisseur d'accès Internet vous a fourni des informations relatives à l'adresse IP à configurer manuellement.", //wwa_msg_sipa
	"Remarque : Vous devrez peut-être également fournir un nom d'hôte. Si vous ne possédez pas ces informations ou si vous ne les connaissez pas, contactez votre fournisseur d'accès Internet.", //wwa_note_hostname
	"Adresse DNS principale", //wwa_pdns
	"Adresse IP du serveur PPTP (peut être identique à celle de la passerelle)", //wwa_pptp_svraddr
	"Adresse DNS secondaire", //wwa_sdns
	"Non listé ou Ne sais pas", //wwa_selectisp_not
	"Définir un nom d''utilisateur et un mot de passe de connexion (L2TP)", //wwa_set_l2tp_title
	"Pour configurer cette connexion, vous devez posséder une liste complète des informations IP fournies par votre fournisseur d'accès Internet. Si vous possédez une connexion par adresse IP statique, mais que vous n'avez pas cette information, contactez votr", //wwa_set_sipa_msg
	"Définir la connexion de l''adresse IP statique", //wwa_set_sipa_title
	"Définir la connexion câblée BigPond", //wwa_title_set_bigpond
	"Définir un nom d''utilisateur et un mot de passe de connexion (PPPoE)", //wwa_title_set_pppoe
	"Définir un nom d''utilisateur et un mot de passe de connexion (PPTP)", //wwa_title_set_pptp
	"Bienvenue dans l'assistant de configuration de D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Nom d''utilisateur/mot de passe de connexion (L2TP)", //wwa_wanmode_l2tp
	"Nom d''utilisateur/mot de passe de connexion (PPPoE)", //wwa_wanmode_pppoe
	"Nom d''utilisateur/mot de passe de connexion (PPTP)", //wwa_wanmode_pptp
	"Adresse IP statique de connexion", //wwa_wanmode_sipa
	"Attribuez un nom au réseau Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nom du réseau Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Jusqu'à 32 caractères autorisés)", //wwz_wwl_intro_s2_1_2
	"Attribuez un mot de passe au réseau Wi-Fi.", //wwz_wwl_intro_s2_2
	"Mot de passe Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(Entre 8 et 63 caractères)", //wwz_wwl_intro_s2_2_2
	"Attribuez un nom à votre réseau (32 caractères maximum).", //wwz_wwl_intro_s3_1
	"Étape 1 : Bienvenue DANS L'ASSISTANT DE CONFIGURATION DE SÉCURITÉ SANS FIL D-LINK", //wwz_wwl_title_s3
	"Adresse IP du serveur PPTP incorrecte", //YM108
	"Utilisez le même mot de passe de sécurité sans fil pour les bandes de 2,4 GHz et 5 GHz.", //wwl_SSP
	"Attribuez un nom et un mot de passe au réseau Wi-Fi.", //wwz_wwl_intro_s0
	"La première adresse de %s doit être un entier.", //MSG002
	"La deuxième adresse de %s doit être un entier.", //MSG003
	"La troisième adresse de %s doit être un entier.", //MSG004
	"La quatrième adresse de %s doit être un entier.", //MSG005
	"Le %s est une adresse non valide.", //MSG006
	"Le %s ne peut pas être zéro.", //MSG007
	"Le secret %s entré n'est pas valide", //MSG008
	"Le secret %s entré n'est pas valide", //MSG009
	"Les %s ne peuvent pas autoriser l'entrée d'IP de rebouclage ou d'IP de multidiffusion (127.x.x.x, 224.x.x.x à 239.x.x.x).", //MSG010
	"Veuillez entrer une autre valeur %s.", //MSG012
	"La valeur de %s doit être numérique !", //MSG013
	"La plage de %s est %1n à %2n.", //MSG014
	"La valeur de %s doit être un nombre pair.", //MSG015
	"La clé n'est pas valide. La clé doit comporter 5 ou 10 caractères hexadécimaux. Entrés par vous-même ", //MSG016
	"La clé n'est pas valide. La clé doit comporter 13 ou 26 caractères hexadécimaux. Entrés par vous-même ", //MSG017
	"La première adresse de %s doit être un hexadécimal.", //MSG018
	"La deuxième adresse de %s doit être un hexadécimal.", //MSG019
	"La troisième adresse de %s doit être un hexadécimal.", //MSG020
	"La quatrième adresse de %s doit être un hexadécimal.", //MSG021
	"La cinquième adresse de %s doit être un hexadécimal.", //MSG022
	"La sixième adresse de %s doit être un hexadécimal.", //MSG023
	"La septième adresse de %s doit être un hexadécimal.", //MSG024
	"La huitième adresse de %s doit être un hexadécimal.", //MSG025
	"La première plage de %s doit être comprise entre", //MSG026
	"La deuxième plage de %s doit être comprise entre", //MSG027
	"La troisième plage de %s doit être comprise entre", //MSG028
	"La quatrième plage de %s doit être comprise entre", //MSG029
	"La cinquième plage de %s doit être comprise entre", //MSG030
	"La sixième plage de %s doit être comprise entre", //MSG031
	"La septième plage de %s doit être comprise entre", //MSG032
	"La huitième plage de %s doit être comprise entre", //MSG033
	"Le %s ne peut pas autoriser l'entrée d'IP de rebouclage ( ::1 ).", //MSG034
	"Le %s ne peut pas autoriser l'entrée d'IP de multidiffusion ( FFxx:0:0:0:0:0:0:2 ou ffxx:0:0:0:0:0:0:2.", //MSG035
	"Mesure non valide", //MSG043
	"La valeur métrique doit être entre 1 et 16.", //ar_alert_3
	"Masque de sous réseau invalide.", //ar_alert_5
	"La clé", //TEXT042_1
	" n'est pas valide, les caractères valides sont 0~9, A~F ou a~f.", //TEXT042_2
	"Remarque : Vous devrez également fournir un nom de service. Si vous ne l'avez pas ou ne le connaissez pas, entrez en contact avec votre FAI.", //wwa_note_svcn
	"Client L2TP", //wwa_msg_l2tp
	"Pour établir cette connexion, vous devrez avoir un nom d’utilisateur et un mot de passe de votre Fournisseur d’accès Internet. Vous avez besoin également de l’adresse IP L2TP. Si vous n'avez pas cette information, entrez en contact avec votre FAI.", //wwa_set_l2tp_msg
	"Pour établir cette connexion, vous devrez avoir un nom d’utilisateur et un mot de passe de votre Fournisseur d’accès Internet. Vous avez besoin également de l’adresse IP du serveur BigPond. Si vous n'avez pas cette information, entrez en contact avec votr", //wwa_msg_set_bigpond
	"Nom d'hôte", //_hostname
	"Bande des 2,4GHz", //GW_WLAN_RADIO_0_NAME
	"Bande des 5GHz", //GW_WLAN_RADIO_1_NAME
	"Voici ci-dessous un résumé détaillé de vos réglages de sécurité sans fil. Veuillez imprimer cette page, ou écrire l'information sur un morceau de papier, ainsi vous pourrez configurer les mêmes réglages sur vos adaptateurs clients sans fil.", //wwl_intro_end
	"veuillez patienter...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Connecter", //_connect
	"Guidez-moi tout au long de la configuration de la connexion Internet", //ES_btn_guide_me
	"Activer l'authentification graphique", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTEUR SANS FIL | ACCUEIL", //TEXT000
	"Un mot de passe L2TP DOIT être spécifié.", //GW_WAN_L2TP_PASSWORD_INVALID
	"Internet non détecté, redémarrer l'assistant ?", //mydlink_tx03
	"Le mot de passe administrateur ne peut pas être vierge.", //mydlink_tx04
	"Contrôle de connectivité du réseau étendu.", //mydlink_tx05
	"secondes restant.", //sec_left
	"Réessayer", //_retry
	"Possédez-vous un compte mydlink ?", //mydlink_tx06
	"Oui, je possède un compte mydlink.", //mydlink_tx07
	"Non, je veux m'enregistrer et me connecter à un nouveau compte mydlink.", //mydlink_tx08
	"Adresse électronique (nom du compte)", //mydlink_tx09
	"Renseignez les options pour terminer l'enregistrement.", //mydlink_tx10
	"Confirmer le mot de passe", //chk_pass
	"Nom", //Lname
	"Prénom", //Fname
	"J'accepte les conditions générales de mydlink.", //mydlink_tx12
	"Pour terminer l'enregistrement mydlink, recherchez le courrier électronique contenant les instructions de confirmation dans votre boîte de réception.", //mydlink_tx13_1
	"Après avoir confirmé votre adresse électronique, cliquez sur Connexion.", //mydlink_tx13_2
	"Connexion", //_login
	"Ok", //_ok
	"Enregistrer", //_save
	"Saisissez deux mots de passe identiques et réessayez", //_pwsame
	"Pour utiliser les fonctions de  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> et l'application mydlink Lite, vous avez besoin d'un compte <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Si vous possédez déjà un compte, sélectionnez <strong>Oui, je possède un compte mydlink</strong> et cliquez sur Suivant pour enregistrer le routeur sur <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Si vous ne possédez pas de compte, sélectionnez <strong>Non, je veux m'enregistrer et me connecter à mon nouveau compte mydlink</strong> et cliquez sur Suivant pour créer un compte. ", //mydlink_reg_into_3
	"Si vous ne souhaitez pas vous connecter au service mydlink, cliquez sur Annuler.", //mydlink_reg_into_4_a
	"Cette adresse électronique possède déjà un compte mydlink. Saisissez-en une autre", //mydlink_pop_01
	"Vous devez accepter les conditions générales pour continuer.", //mydlink_pop_02
	"ne doit pas être vierge.", //mydlink_pop_03
	"n'est pas valide.", //mydlink_pop_04
	"Vous pouvez maintenant utiliser le service mydlink avec ce périphérique.", //mydlink_pop_05
	"La connexion a échoué", //mydlink_pop_06
	"Connexion", //_signup
	"(GMT+07:00) Novossibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Une fois l'enregistrement mydlink terminé, la connexion PPPoE, L2TP ou PPTP par défaut de votre routeur est définie sur Toujours active. Si votre FAI applique des frais d'utilisation, vous voudrez peut-être choisir Connexion à la demande comme paramètre par défaut.", //mydlink_pop_09
	"Impossible de se connecter à mydlink.", //mdl_errmsg_01
	"L'envoi de la demande d'ouverture de session a échoué.", //mdl_errmsg_02
	"Impossible d'envoyer la demande d'ouverture de session.", //mdl_errmsg_03
	"L'envoi de la demande d'inscription a échoué.", //mdl_errmsg_04
	"Impossible d'envoyer la demande d'inscription.", //mdl_errmsg_05
	"Le champ SSID ne doit pas être vide.", //SSID_EMPTY_ERROR
	"Les mots de passe entrés ne concordent pas.", //YM102
	"Un mot de passe PPPoE DOIT être indiqué", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Le mot de passe du compte doit comporter plus de six caractères.", //limit_pass_msg
	"Ignorer", //_skip
	"Si vous ne souhaitez pas vous inscrire au service mydlink, cliquez sur Ignorer.", //mydlink_reg_into_4
	"Enregistrement de la configuration Wi-Fi", //mydlink_WiFi_save
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
