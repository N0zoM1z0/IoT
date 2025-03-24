//Version=1.01b02
//Language=Czech
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Storno", //_cancel
	"Zkopírovat adresu MAC počítače", //_clone
	"Připojení DHCP (dynamická IP adresa)", //_dhcpconn
	"IP adresa", //_ipaddr
	"L2TP", //_L2TP
	"IP adresa brány L2TP", //_L2TPgw
	"IP adresa L2TP", //_L2TPip
	"Maska podsítě L2TP", //_L2TPsubnet
	"Jazyk", //_Language
	"Adresa MAC", //_macaddr
	"Další", //_next
	"Ne", //_no
	"(nepovinné)", //_optional
	"Heslo", //_password
	"IP adresa brány PPTP", //_PPTPgw
	"IP adresa PPTP", //_PPTPip
	"Maska podsítě PPTP", //_PPTPsubnet
	"Předchozí", //_prev
	"Upravte hesla administrátora tak, aby se shodovala, a zkuste to znovu.", //_pwsame_admin
	"Statická IP adresa", //_sdi_staticip
	"Maska podsítě", //_subnet
	"Uživatelské jméno", //_username
	"Ověření hesla", //_verifypw
	"Chcete zrušit všechny změny, které byly v tomto průvodci provedeny?", //_wizquit
	"Ano", //_yes
	"Neplatná IP adresa serveru L2TP", //bwn_alert_17
	"Režim adresy", //bwn_AM
	"Server BigPond", //bwn_BPS
	"TKIP a AES", //bws_CT_3
	"Dynamická IP adresa", //carriertype_ct_0
	"Směrovač zjišťuje typ připojení k internetu, čekejte prosím...", //ES_auto_detect_desc
	"Směrovač nemůže zjistit typ připojení k internetu.", //ES_auto_detect_failed_desc
	"Chcete si \"webovou správu směrovače D-Link\" uložit do záložek?", //ES_bookmark
	"Opakovat", //ES_btn_try_again
	"Zapojte jeden konec přibaleného ethernetového kabelu do portu s označením INTERNET na zadní straně směrovače. Zapojte druhý konec tohoto kabelu do ethernetového portu modemu.", //ES_cable_lost_desc
	"Krok 2: Konfigurace zabezpečení sítě Wi-Fi", //ES_step_wifi_security
	"Krok 3: Nastavení hesla", //ES_title_s3
	"Krok 4: Výběr časového pásma", //ES_title_s4
	"Krok 5: Uložení nastavení", //ES_title_s5
	"Krok 5: Potvrzení nastavení Wi-Fi", //ES_title_s5_0
	"Krok 6: Registrace na portálu MYDLINK", //ES_title_s6
	"Registrace na portálu MYDLINK", //ES_title_s6_myd
	"Krok 1: Konfigurace připojení k internetu", //ES_wwa_title_s1
	"Neplatný název klienta DHCP", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Neplatné heslo pro DHCP+", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Neplatné uživatelské jméno pro DHCP+", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Musí být zadáno uživatelské jméno pro L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"Musí být zadáno heslo pro PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Neplatný síťový klíč!", //IPV6_TEXT2
	"Neplatná adresa MAC", //KR3
	"Auto (WPA nebo WPA2) – Osobní", //KR48
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
	"Registrace produktu na portálu mydlink vám umožní používat funkce, které s portálem mydlink spolupracují, včetně online přístupu k zařízení a jeho ovládání pomocí webu mydlink.", //mydlink_tx01
	"Chcete své zařízení registrovat na portálu mydlink?", //mydlink_tx02
	"Zadejte uživatelské jméno", //PPP_USERNAME_EMPTY
	"Podpora PPPoE Plus", //pppoe_plus_dail
	"Heslo může obsahovat jen zobrazitelné znaky.", //S493
	"UKLÁDÁ SE NASTAVENÍ", //save_settings
	"Vaše nastavení se ukládá.", //save_wait
	"Verze firmwaru", //sd_FWV
	"Stránka produktu", //TA2
	"Verze hardwaru", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Ostrov Midway, Samoa", //up_tz_01
	"(GMT-10:00) Hawaii", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Pacific Time (USA a Kanada), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Mountain Time (USA a Kanada)", //up_tz_06
	"(GMT-06:00) Střední Amerika", //up_tz_07
	"(GMT-06:00) Central Time (USA a Kanada)", //up_tz_08
	"(GMT-06:00) Mexico City", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogota, Lima, Quito", //up_tz_11
	"(GMT-05:00) Eastern Time (USA a Kanada)", //up_tz_12
	"(GMT-05:00) Indiana (východní část)", //up_tz_13
	"(GMT-04:00) Atlantic Time (Kanada)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brazílie", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Grónsko", //up_tz_20
	"(GMT-02:00) Střední Atlantik", //up_tz_21
	"(GMT-01:00) Azory", //up_tz_22
	"(GMT-01:00) Kapverdské ostrovy", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwichský čas: Dublin, Edinburgh, Lisabon, Londýn", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlín, Bern, Řím, Stockholm", //up_tz_26
	"(GMT+01:00) Bělehrad, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Brusel, Kodaň, Madrid, Paříž", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofie, Vilnius, Záhřeb", //up_tz_29
	"(GMT+01:00) Budapešť, Vídeň, Praha, Varšava", //up_tz_29b
	"(GMT+01:00) Západní střední Afrika", //up_tz_30
	"(GMT+02:00) Atény, Istanbul, Minsk", //up_tz_31
	"(GMT+02:00) Bukurešť", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinky, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jeruzalém", //up_tz_36
	"(GMT+03:00) Bagdád", //up_tz_37
	"(GMT+03:00) Kuvajt, Rijád", //up_tz_38
	"(GMT+04:00) Moskva, St. Petěrsburg, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teherán", //up_tz_41
	"(GMT+04:00) Abú Dhabí, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Jerevan", //up_tz_43
	"(GMT+04:30) Kábul", //up_tz_44
	"(GMT+06:00) Jekatěrinburg", //up_tz_45
	"(GMT+05:00) Islámábád, Karáčí, Taškent", //up_tz_46
	"(GMT+05:30) Kalkata, Chennai, Bombaj, Nové Dillí", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dháka", //up_tz_50
	"(GMT+06:00) Šrí Džajvardanapura", //up_tz_51
	"(GMT+06:30) Rangún", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoj, Džakarta", //up_tz_53
	"(GMT+08:00) Krasnojarsk", //up_tz_54
	"(GMT+08:00) Peking, Čchung-čching, Hongkong, Urumči", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulánbátar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Tchaj-pej", //up_tz_59
	"(GMT+09:00) Ósaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Soul", //up_tz_61
	"(GMT+10:00) Jakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Šalomounovy ostr., Nová Kaledonie", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fidži, Kamčatka, Marshallovy ostr.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"Nastavení DNS", //wwa_dnsset
	"Adresa brány", //wwa_gw
	"Nový směrovač D-Link ve výchozím nastavení nemá nastaveno heslo pro správcovský přístup k webovým stránkám s konfigurací. Abyste své nové síťové zařízení zabezpečili, níže nastavte a ověřte heslo. Povolíte-li grafické ověřování CAPTCHA, přístup k nastavení vaší sítě bude lépe zabezpečen před neoprávněnými uživateli  a hackerským softwarem.", //wwa_intro_s1
	"Vyberte časové pásmo odpovídající vaší zemi. Tato informace je nutná ke konfiguraci možností směrovače souvisejících s časem.", //wwa_intro_s2
	"Níže vyberte váš typ připojení k internetu:", //wwa_intro_s3
	"Tento průvodce vás provede celým procesem konfigurace nového směrovače D-Link a připojení k internetu.", //wwa_intro_wel
	"IP adresa serveru L2TP (může se shodovat s bránou)", //wwa_l2tp_svra
	"Tuto možnost vyberte, pokud vaše připojení k internetu automaticky přiděluje IP adresu. Tento typ připojení používá většina kabelových modemů.", //wwa_msg_dhcp
	"Pokud váš poskytovatel internetových služeb není v seznamu nebo jej neznáte, níže vyberte typ připojení k internetu:", //wwa_msg_ispnot
	"Tuto možnost vyberte, pokud připojení k internetu vyžaduje uživatelské jméno a heslo. Tento typ připojení používá většina modemů DSL.", //wwa_msg_pppoe
	"Klient PPTP.", //wwa_msg_pptp
	"Chcete-li nastavit toto připojení, ujistěte se, že jste ke směrovači D-Link připojeni z počítače, který byl původně připojen k vašemu širokopásmovému připojení. Pokud ano, kliknutím na tlačítko Klonovat adresu MAC zkopírujte adresu MAC počítače do směrovače D-Link.", //wwa_msg_set_dhcp
	"K nastavení tohoto připojení je zapotřebí uživatelské jméno a heslo od poskytovatele internetových služeb. Nemáte-li tyto údaje k dispozici, obraťte se na svého poskytovatele internetových služeb.", //wwa_msg_set_pppoe
	"K nastavení tohoto připojení je zapotřebí uživatelské jméno a heslo od poskytovatele internetových služeb. Také je nutná IP adresa pro protokol PPTP. Nemáte-li tyto údaje k dispozici, obraťte se na svého poskytovatele internetových služeb.", //wwa_msg_set_pptp
	"Tuto možnost vyberte, pokud vám poskytovatel internetových služeb poskytl údaje o IP adrese, které je třeba ručně zadat.", //wwa_msg_sipa
	"Poznámka: Také může být třeba zadat název hostitele. Pokud tyto údaje nemáte nebo neznáte, obraťte se na svého poskytovatele internetových služeb.", //wwa_note_hostname
	"Primární adresa DNS", //wwa_pdns
	"IP adresa serveru PPTP (může se shodovat s bránou)", //wwa_pptp_svraddr
	"Sekundární adresa DNS", //wwa_sdns
	"Není v seznamu nebo nevím", //wwa_selectisp_not
	"Nastavit připojení s uživatelským jménem a heslem (L2TP)", //wwa_set_l2tp_title
	"Chcete-li nastavit toto připojení, budete od poskytovatele internetových služeb potřebovat kompletní informace o IP adresách. Pokud máte připojení se statickou IP adresou a tyto údaje nemáte, obraťte se na svého poskytovatele internetových služeb.", //wwa_set_sipa_msg
	"Nastavit připojení se statickou IP adresou", //wwa_set_sipa_title
	"Nastavit kabelové připojení BigPond", //wwa_title_set_bigpond
	"Nastavit připojení s uživatelským jménem a heslem (PPPoE)", //wwa_title_set_pppoe
	"Nastavit připojení s uživatelským jménem a heslem (PPTP)", //wwa_title_set_pptp
	"Vítejte v průvodci nastavením D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Připojení s uživatelským jménem a heslem (L2TP)", //wwa_wanmode_l2tp
	"Připojení s uživatelským jménem a heslem (PPPoE)", //wwa_wanmode_pppoe
	"Připojení s uživatelským jménem a heslem (PPTP)", //wwa_wanmode_pptp
	"Připojení se statickou IP adresou", //wwa_wanmode_sipa
	"Pojmenujte svou síť Wi-Fi.", //wwz_wwl_intro_s2_1
	"Název sítě Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(až 32 znaků)", //wwz_wwl_intro_s2_1_2
	"Zabezpečte svou síť Wi-Fi heslem.", //wwz_wwl_intro_s2_2
	"Heslo sítě Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(8 až 63 znaků)", //wwz_wwl_intro_s2_2_2
	"Dejte své síti název dlouhý maximálně 32 znaků.", //wwz_wwl_intro_s3_1
	"Krok 1: VÍTEJTE V PRŮVODCI NASTAVENÍM ZABEZPEČENÍ BEZDRÁTOVÉ KOMUNIKACE D-LINK", //wwz_wwl_title_s3
	"Neplatná IP adresa serveru PPTP", //YM108
	"Použít stejné heslo zabezpečení bezdrátové komunikace pro pásmo 2,4 GHz i 5 GHz", //wwl_SSP
	"Pojmenujte svou síť Wi-Fi a zabezpečte ji heslem.", //wwz_wwl_intro_s0
	"1. část adresy %s musí být celé číslo.", //MSG002
	"2. část adresy %s musí být celé číslo.", //MSG003
	"3. část adresy %s musí být celé číslo.", //MSG004
	"4. část adresy %s musí být celé číslo.", //MSG005
	"%s je neplatná adresa.", //MSG006
	"%s nemůže být nula.", //MSG007
	"Zadaný port %s je neplatný.", //MSG008
	"Zadané heslo %s je neplatné.", //MSG009
	"Jako %s nelze zadat IP adresu zpětné smyčky nebo vícesměrového vysílání (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Zadejte jinou hodnotu %s.", //MSG012
	"Hodnota %s musí být číselná.", //MSG013
	"Rozsah pro %s je %1n ~ %2n.", //MSG014
	"Hodnota %s musí být sudá.", //MSG015
	"Klíč je neplatný. Klíč musí obsahovat 5 znaků nebo 10 hexadecimálních číslic. Zadali jste", //MSG016
	"Klíč je neplatný. Klíč musí obsahovat 13 znaků nebo 26 hexadecimálních číslic. Zadali jste", //MSG017
	"1. část adresy %s musí být hexadecimální.", //MSG018
	"2. část adresy %s musí být hexadecimální.", //MSG019
	"3. část adresy %s musí být hexadecimální.", //MSG020
	"4. část adresy %s musí být hexadecimální.", //MSG021
	"5. část adresy %s musí být hexadecimální.", //MSG022
	"6. část adresy %s musí být hexadecimální.", //MSG023
	"7. část adresy %s musí být hexadecimální.", //MSG024
	"8. část adresy %s musí být hexadecimální.", //MSG025
	"1. část adresy %s musí být v rozsahu", //MSG026
	"2. část adresy %s musí být v rozsahu", //MSG027
	"3. část adresy %s musí být v rozsahu", //MSG028
	"4. část adresy %s musí být v rozsahu", //MSG029
	"5. část adresy %s musí být v rozsahu", //MSG030
	"6. část adresy %s musí být v rozsahu", //MSG031
	"7. část adresy %s musí být v rozsahu", //MSG032
	"8. část adresy %s musí být v rozsahu", //MSG033
	"Jako %s nelze zadat IP adresu zpětné smyčky ( ::1).", //MSG034
	"Jako %s nelze zadat IP adresu vícesměrového vysílání ( FFxx:0:0:0:0:0:0:2 nebo ffxx:0:0:0:0:0:0:2).", //MSG035
	"Neplatná metrika", //MSG043
	"Hodnota metriky musí být v rozmezí (1..16).", //ar_alert_3
	"Neplatná maska sítě.", //ar_alert_5
	"Klíč", //TEXT042_1
	" je chybný, povolené znaky jsou 0~9, A~F, a~f.", //TEXT042_2
	"Poznámka: Také může být třeba zadat název služby. Pokud tyto údaje nemáte nebo neznáte, obraťte se na svého poskytovatele internetových služeb.", //wwa_note_svcn
	"Klient L2TP.", //wwa_msg_l2tp
	"K nastavení tohoto připojení je zapotřebí uživatelské jméno a heslo od poskytovatele internetových služeb. Také je nutná IP adresa pro protokol L2TP. Nemáte-li tyto údaje k dispozici, obraťte se na svého poskytovatele internetových služeb.", //wwa_set_l2tp_msg
	"K nastavení tohoto připojení je zapotřebí uživatelské jméno a heslo od poskytovatele internetových služeb. Také je nutná IP adresa serveru BigPond. Nemáte-li tyto údaje k dispozici, obraťte se na svého poskytovatele internetových služeb.", //wwa_msg_set_bigpond
	"Název hostitele", //_hostname
	"Pásmo 2,4 GHz", //GW_WLAN_RADIO_0_NAME
	"Pásmo 5 GHz", //GW_WLAN_RADIO_1_NAME
	"Následuje podrobný souhrn nastavení zabezpečení sítě Wi-Fi. Tuto stránku si vytiskněte nebo si uvedené informace zapište, abyste mohli správně nastavit svá zařízení Wi-Fi.", //wwl_intro_end
	"Čekejte, prosím...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Připojit", //_connect
	"Proveďte mě nastavením připojení k internetu", //ES_btn_guide_me
	"Povolit grafické ověřování", //_graph_auth
	"D-LINK CORPORATION, INC | BEZDRÁTOVÝ SMĚROVAČ | ÚVOD", //TEXT000
	"Musí být zadáno heslo pro L2TP", //GW_WAN_L2TP_PASSWORD_INVALID
	"Nebylo zjištěno připojení k internetu, chcete průvodce spustit znovu?", //mydlink_tx03
	"Heslo administrátora nemůže být prázdné.", //mydlink_tx04
	"Kontroluje se připojení WAN.", //mydlink_tx05
	"sekund ještě zbývá.", //sec_left
	"Opakovat", //_retry
	"Máte účet mydlink?", //mydlink_tx06
	"Ano, mám účet mydlink.", //mydlink_tx07
	"Ne, chci se zaregistrovat a přihlásit se k novému účtu mydlink.", //mydlink_tx08
	"E‑mailová adresa (název účtu)", //mydlink_tx09
	"Vyplňte možnosti a dokončete registraci.", //mydlink_tx10
	"Potvrďte heslo", //chk_pass
	"Příjmení", //Lname
	"Jméno", //Fname
	"Přijímám podmínky služby mydlink.", //mydlink_tx12
	"Zkontrolujte si schránku došlé pošty a dokončete registraci podle e-mailu s pokyny pro potvrzení.", //mydlink_tx13_1
	" Po potvrzení e-mailové adresy klikněte na tlačítko Přihlásit.", //mydlink_tx13_2
	"Přihlásit", //_login
	"OK", //_ok
	"Uložit", //_save
	"Upravte hesla tak, aby se shodovala, a zkuste to znovu", //_pwsame
	"K využívání funkcí služby <a href=\"http://cz.mydlink.com\" target=\"_blank\">mydlink.com</a> a aplikace mydlink Lite potřebujete účet na portálu <a href=\"http://cz.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Pokud již máte účet, vyberte možnost <strong>Ano, mám účet mydlink</strong> a kliknutím na tlačítko Další pokračujte v registraci směrovače na portálu <a href=\"http://cz.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Pokud účet nemáte, vyberte možnost <strong>Ne, chci se zaregistrovat a přihlásit se k novému účtu mydlink</strong> a kliknutím na tlačítko Další si vytvořte účet. ", //mydlink_reg_into_3
	" Pokud se nechcete zaregistrovat ke službě mydlink, stiskněte tlačítko Storno.", //mydlink_reg_into_4_a
	"K této e-mailové adrese je již přidružen účet mydlink. Zkuste jinou e-mailovou adresu.", //mydlink_pop_01
	"Musíte přijmout podmínky, abyste mohli pokračovat.", //mydlink_pop_02
	"– pole nesmí být prázdné.", //mydlink_pop_03
	"– hodnota je neplatná.", //mydlink_pop_04
	"Nyní můžete s tímto zařízením využívat službu mydlink.", //mydlink_pop_05
	"Přihlášení se nezdařilo", //mydlink_pop_06
	"Registrovat se", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"Po dokončení registrace ke službě mydlink bude výchozí připojení PPPoE, L2TP a PPTP ve směrovači nastaveno na \"Vždy připojeno\". Pokud váš poskytovatel internetových služeb účtuje poplatky podle využívání, může být užitečné jako výchozí nastavení ručně zvolit možnost \"Vytočit na vyžádání\".", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"The SSID field can not be blank", //SSID_EMPTY_ERROR
	"The entered passwords do not match", //YM102
	"Musí být zadáno heslo pro PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Přeskočit", //_skip
	" Pokud se nechcete registrovat ke službě mydlink, stiskněte tlačítko Přeskočit.", //mydlink_reg_into_4
	"Ukládá se nastavení Wi-Fi", //mydlink_WiFi_save
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
