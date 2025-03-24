//Version=1.01b02
//Language=Russian
//Date=Mon, 14, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Отменить", //_cancel
	"Копировать MAC-адрес Вашего компьютера", //_clone
	"DHCP-соединение (Динамический IP-адрес)", //_dhcpconn
	"IP-адрес", //_ipaddr
	"L2TP", //_L2TP
	"IP-адрес шлюза L2TP", //_L2TPgw
	"IP-адрес L2TP", //_L2TPip
	"Маска подсети L2TP", //_L2TPsubnet
	"Язык", //_Language
	"MAC-адрес", //_macaddr
	"Далее", //_next
	"Нет", //_no
	"(дополнительно)", //_optional
	"Пароль", //_password
	"IP-адрес шлюза PPTP", //_PPTPgw
	"IP-адрес PPTP", //_PPTPip
	"Маска подсети PPTP", //_PPTPsubnet
	"Предыдущий", //_prev
	"Пожалуйста, сделайте два пароля администратора одинаковыми и попробуйте еще раз", //_pwsame_admin
	"Статический IP", //_sdi_staticip
	"Маска подсети", //_subnet
	"Имя пользователя", //_username
	"Подтвердить пароль", //_verifypw
	"Хотите отменить все изменения, выполненные с данным мастером?", //_wizquit
	"Да ", //_yes
	"Некорректный IP-адрес L2TP-сервера", //bwn_alert_17
	"Режим адресации", //bwn_AM
	"Сервер BigPond", //bwn_BPS
	"TKIP и AES", //bws_CT_3
	"Динамический IP", //carriertype_ct_0
	"Маршрутизатор определяет тип Интернет-соединения, пожалуйста, подождите…", //ES_auto_detect_desc
	"Маршрутизатор не может определить тип Интернет-соединения.", //ES_auto_detect_failed_desc
	"Хотите сделать закладку \"Web-управление маршрутизатором D-Link\"?", //ES_bookmark
	"Попробуйте еще раз", //ES_btn_try_again
	"Пожалуйста, подключите Ethernet-кабель, входящий в комплект поставки маршрутизатора, к порту, обозначенному INTERNET, на задней панели маршрутизатора и к Ethernet-пору модема.", //ES_cable_lost_desc
	"Шаг 2: Настройте безопасность Wi-Fi", //ES_step_wifi_security
	"Шаг 3: Установите пароль", //ES_title_s3
	"Шаг 4: Выберите часовой пояс", //ES_title_s4
	"Шаг 5: Сохраните настройки", //ES_title_s5
	"Шаг 5: Подтвердите настройки WI-FI", //ES_title_s5_0
	"Шаг 6: Регистрация mydlink", //ES_title_s6
	"Регистрация mydlink", //ES_title_s6_myd
	"Шаг 1: Настройте Интернет-соединение", //ES_wwa_title_s1
	"Некорректное имя DHCP-клиента", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Некорректный пароль DHCP+", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Некорректное имя пользователя DHCP+", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Имя пользователя L2TP ДОЛЖНО быть задано", //GW_WAN_L2TP_USERNAME_INVALID
	"Пароль PPTP ДОЛЖЕН быть задан", //GW_WAN_PPTP_PASSWORD_INVALID
	"Некорректный ключ сети!", //IPV6_TEXT2
	"Некорректный MAC-адрес", //KR3
	"Auto (WPA или WPA2) - Personal", //KR48
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
	"Регистрация продукта в mydlink позволит использовать доступные функции mydlink, включая доступ и управление устройством в режиме онлайн через Web-сайт mydlink.", //mydlink_tx01
	"Хотите зарегистрировать устройство в mydlink?", //mydlink_tx02
	"Пожалуйста, введите имя пользователя", //PPP_USERNAME_EMPTY
	"Поддерживается PPPoE Plus", //pppoe_plus_dail
	"Пароль может содержать только печатаемые символы.", //S493
	"СОХРАНЕНИЕ НАСТРОЕК", //save_settings
	"Выполняется сохранение настроек.", //save_wait
	"Версия программного обеспечения", //sd_FWV
	"Страница продукта", //TA2
	"Аппаратная версия", //TA3
	"(GMT-12:00) Эниветок, Кваджалейн", //up_tz_00
	"(GMT-11:00) о. Мидуэй, Самоа", //up_tz_01
	"(GMT-10:00) Гавайи", //up_tz_02
	"(GMT-09:00) Аляска", //up_tz_03
	"(GMT-08:00) Тихоокеанское время (США и Канада), Тихуана", //up_tz_04
	"(GMT-07:00) Аризона", //up_tz_05
	"(GMT-07:00) Горное время (США и Канада)", //up_tz_06
	"(GMT-06:00) Центральная Америка", //up_tz_07
	"(GMT-06:00) Центральное время (США и Канада)", //up_tz_08
	"(GMT-06:00) Мехико", //up_tz_09
	"(GMT-06:00) Саскачеван", //up_tz_10
	"(GMT-05:00) Богота, Лима, Кито", //up_tz_11
	"(GMT-05:00) Восточное время (США и Канада)", //up_tz_12
	"(GMT-05:00) Индиана (восток)", //up_tz_13
	"(GMT-04:00) Атлантическое время (Канада)", //up_tz_14
	"(GMT-04:00) Каракас, Ла пас", //up_tz_15
	"(GMT-04:00) Сантьяго", //up_tz_16
	"(GMT-03:30) Ньюфаундленд", //up_tz_17
	"(GMT-03:00) Бразилиа", //up_tz_18
	"(GMT-03:00) Буэнос-Айрес, Джорджтаун", //up_tz_19
	"(GMT-03:00) Гренландия", //up_tz_20
	"(GMT-02:00) Среднеатлантическое время", //up_tz_21
	"(GMT-01:00) Азорские о-ва", //up_tz_22
	"(GMT-01:00) о-ва Зеленого мыса", //up_tz_23
	"(GMT) Касабланка, Монровия", //up_tz_24
	"(GMT) Время по Гринвичу: Дублин, Эдинбург, Лиссабон, Лондон", //up_tz_25
	"(GMT+01:00) Амстердам, Берлин, Берн, Рим, Стокгольм", //up_tz_26
	"(GMT+01:00) Белград, Братислава, Любляна", //up_tz_27
	"(GMT+01:00) Брюссель, Копенгаген, Мадрид, Париж", //up_tz_28
	"(GMT+01:00) Сараево, Скопье, София, Вильнюс, Загреб", //up_tz_29
	"(GMT+01:00) Будапешт, Вена, Прага, Варшава", //up_tz_29b
	"(GMT+01:00) Западная Центральная Африка", //up_tz_30
	"(GMT+02:00) Афины, Стамбул, Минск", //up_tz_31
	"(GMT+02:00) Бухарест", //up_tz_32
	"(GMT+02:00) Каир", //up_tz_33
	"(GMT+02:00) Хараре, Претория", //up_tz_34
	"(GMT+02:00) Хельсинки, Рига, Таллин", //up_tz_35
	"(GMT+02:00) Иерусалим", //up_tz_36
	"(GMT+03:00) Багдад", //up_tz_37
	"(GMT+03:00) Кувейт, Эр-Рияд", //up_tz_38
	"(GMT+04:00) Москва, Санкт-Петербург, Волгоград", //up_tz_39
	"(GMT+03:00) Найроби", //up_tz_40
	"(GMT+03:00) Тегеран", //up_tz_41
	"(GMT+04:00) Абу-Даби, Мускат", //up_tz_42
	"(GMT+04:00) Баку, Тбилиси, Ереван", //up_tz_43
	"(GMT+04:30) Кабул", //up_tz_44
	"(GMT+06:00) Екатеринбург", //up_tz_45
	"(GMT+05:00) Исламабад, Карачи, Ташкент", //up_tz_46
	"(GMT+05:30) Калькутта, Ченнаи, Мумбаи, Нью-Дели", //up_tz_47
	"(GMT+05:45) Катманду", //up_tz_48
	"(GMT+06:00) Новосибирск", //up_tz_49
	"(GMT+06:00) Астана, Дхака", //up_tz_50
	"(GMT+06:00) Шри Джаяварденепура", //up_tz_51
	"(GMT+06:30) Рангун", //up_tz_52
	"(GMT+07:00) Бангкок, Ханой, Джакарта", //up_tz_53
	"(GMT+08:00) Красноярск", //up_tz_54
	"(GMT+08:00) Пекин, Чунцин, Гонконг, Урумчи", //up_tz_55
	"(GMT+09:00) Иркутск, Улан-Батор", //up_tz_56
	"(GMT+08:00) Куала-Лумпур, Сингапур", //up_tz_57
	"(GMT+08:00) Перт", //up_tz_58
	"(GMT+08:00) Тайпей", //up_tz_59
	"(GMT+09:00) Осака, Саппоро, Токио", //up_tz_60
	"(GMT+09:00) Сеул", //up_tz_61
	"(GMT+10:00) Якутск", //up_tz_62
	"(GMT+09:30) Аделаида", //up_tz_63
	"(GMT+09:30) Дарвин", //up_tz_64
	"(GMT+10:00) Брисбейн", //up_tz_65
	"(GMT+10:00) Канберра, Мельбурн, Сидней", //up_tz_66
	"(GMT+10:00) Гуам, Порт Моресби", //up_tz_67
	"(GMT+10:00) Хобарт", //up_tz_68
	"(GMT+11:00) Владивосток", //up_tz_69
	"(GMT+11:00) Соломоновы о-ва, Новая Каледония", //up_tz_70
	"(GMT+12:00) Окленд, Веллингтон", //up_tz_71
	"(GMT+12:00) Фиджи, Камчатка, Маршалловы о-ва", //up_tz_72
	"(GMT+13:00) Нукуалофа, Тонга", //up_tz_73
	"Настройки DNS", //wwa_dnsset
	"Адрес шлюза", //wwa_gw
	"По умолчанию новый маршрутизатор D-Link не имеет пароля, настроенного для доступа администратора к Web-страницам настройки. Чтобы защитить новое сетевое устройство, пожалуйста, установите и подтвердите ниже пароль. Включение графической аутентификации CAPTCHA обеспечивает дополнительную защиту для предотвращения доступа к настройкам сети несанкционированных онлайн-пользователей и хакерского программного обеспечения.", //wwa_intro_s1
	"Выберите часовой пояс, соответствующий Вашему местоположению. Данная информация требуется для настройки опций с временным критерием маршрутизатора.", //wwa_intro_s2
	"Пожалуйста, выберите ниже тип Интернет-соединения:", //wwa_intro_s3
	"Данный мастер поможет выполнить пошаговый процесс настройки нового маршрутизатора D-Link и подключиться к Интернет.", //wwa_intro_wel
	"IP-адрес L2TP-сервера (может совпадать со шлюзом)", //wwa_l2tp_svra
	"Выберите эту опцию, если Интернет-соединение автоматически предоставляет IP-адрес. Большинство кабельных модемов используют данный тип соединения.", //wwa_msg_dhcp
	"Если провайдер не указан в списке или неизвестен, пожалуйста, выберите ниже тип Интернет-соединения:", //wwa_msg_ispnot
	"Выберите эту опцию, если Интернет-соединение требует имя пользователя и пароль. Большинство DSL-модемов используют данный тип соединения.", //wwa_msg_pppoe
	"PPTP-клиент.", //wwa_msg_pptp
	"Чтобы установить данное соединение, пожалуйста, убедитесь, что компьютер, который был изначально подключен к широкополосному соединению, подключен к маршрутизатору D-Link. Если это так, нажмите кнопку Копировать MAC, чтобы копировать MAC-адрес компьютера на маршрутизатор D-Link.", //wwa_msg_set_dhcp
	"Чтобы установить данное соединение, необходимы имя пользователя и пароль от провайдера. Если эта информация отсутствует, пожалуйста, обратитесь к провайдеру.", //wwa_msg_set_pppoe
	"Чтобы установить данное соединение, необходимы имя пользователя и пароль от провайдера. Также потребуется IP-адрес PPTP. Если эта информация отсутствует, пожалуйста, обратитесь к провайдеру.", //wwa_msg_set_pptp
	"Выберите эту опцию, если провайдер предоставил информацию об IP-адресах, которые должны быть настроены вручную.", //wwa_msg_sipa
	"Примечание: Также, возможно, потребуется предоставить имя хоста. Если эта информация отсутствует или неизвестна, пожалуйста, обратитесь к провайдеру.", //wwa_note_hostname
	"Предпочитаемый DNS-адрес", //wwa_pdns
	"IP-адрес PPTP-сервера (может совпадать со шлюзом)", //wwa_pptp_svraddr
	"Альтернативный DNS-адрес", //wwa_sdns
	"Не указан в списке или Неизвестен", //wwa_selectisp_not
	"Установить имя пользователя и пароль соединения (L2TP)", //wwa_set_l2tp_title
	"Чтобы установить данное соединение, необходимо иметь полный список с информацией об IP-адресах от провайдера. Если типом соединения является Статический IP, и эта информация отсутствует, пожалуйста, обратитесь к провайдеру.", //wwa_set_sipa_msg
	"Установить соединение Статический IP-адрес", //wwa_set_sipa_title
	"Установить кабельное соединение BigPond", //wwa_title_set_bigpond
	"Установить имя пользователя и пароль (PPPoE)", //wwa_title_set_pppoe
	"Установить имя пользователя и пароль (PPTP)", //wwa_title_set_pptp
	"Добро пожаловать в мастер установки D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Имя пользователя / Пароль (L2TP)", //wwa_wanmode_l2tp
	"Имя пользователя / Пароль (PPPoE)", //wwa_wanmode_pppoe
	"Имя пользователя / Пароль (PPTP)", //wwa_wanmode_pptp
	"Соединение Статический IP-адрес", //wwa_wanmode_sipa
	"Задать имя сети Wi-Fi.", //wwz_wwl_intro_s2_1
	"Имя сети Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Используя не больше 32 символов)", //wwz_wwl_intro_s2_1_2
	"Задать пароль сети Wi-Fi.", //wwz_wwl_intro_s2_2
	"Пароль Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(От 8 до 63 символов)", //wwz_wwl_intro_s2_2_2
	"Задать имя сети, используя не больше 32 символов.", //wwz_wwl_intro_s3_1
	"Шаг 1: Добро пожаловать В МАСТЕР УСТАНОВКИ БЕЗОПАСНОСТИ БЕСПРОВОДНОЙ СЕТИ D-LINK", //wwz_wwl_title_s3
	"Некорректный IP-адрес PPTP-сервера", //YM108
	"Использовать одинаковый пароль безопасности беспроводной сети как на полосе частот 2,4 ГГц, так и на полосе частот 5 ГГц", //wwl_SSP
	"Задать имя и пароль сети Wi-Fi.", //wwz_wwl_intro_s0
	"1-й адрес %s должен быть целым числом.", //MSG002
	"2-й адрес %s должен быть целым числом.", //MSG003
	"3-й адрес %s должен быть целым числом.", //MSG004
	"4-й адрес %s должен быть целым числом.", //MSG005
	"%s является некорректным адресом.", //MSG006
	"%s не может быть нулем.", //MSG007
	"Введенный порт %s является некорректным.", //MSG008
	"Введенный ключ %s является некорректным.", //MSG009
	"%s не может разрешить запись к loopback IP-адресу или групповому IP-адресу (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Пожалуйста, введите другое значение %s.", //MSG012
	"Значение %s должно быть числовым!", //MSG013
	"Диапазоном %s является %1n ~ %2n.", //MSG014
	"Значение %s должно быть четным числом.", //MSG015
	"Некорректный ключ. Ключ должен содержать 5 или 10 шестнадцатеричных символов. Введено \"", //MSG016
	"Некорректный ключ. Ключ должен содержать 13 или 26 шестнадцатеричных символов. Введено", //MSG017
	"1-й адрес %s должен быть шестнадцатеричным.", //MSG018
	"2-й адрес %s должен быть шестнадцатеричным.", //MSG019
	"3-й адрес %s должен быть шестнадцатеричным.", //MSG020
	"4-й адрес %s должен быть шестнадцатеричным.", //MSG021
	"5-й адрес %s должен быть шестнадцатеричным.", //MSG022
	"6-й адрес %s должен быть шестнадцатеричным.", //MSG023
	"7-й адрес %s должен быть шестнадцатеричным.", //MSG024
	"8-й адрес %s должен быть шестнадцатеричным.", //MSG025
	"1-й диапазон %s должен находиться между", //MSG026
	"2-й диапазон %s должен находиться между", //MSG027
	"3-й диапазон %s должен находиться между", //MSG028
	"4-й диапазон %s должен находиться между", //MSG029
	"5-й диапазон %s должен находиться между", //MSG030
	"6-й диапазон %s должен находиться между", //MSG031
	"7-й диапазон %s должен находиться между", //MSG032
	"8-й диапазон %s должен находиться между", //MSG033
	"%s не может разрешить запись к loopback IP-адресу ( ::1 ).", //MSG034
	"%s не может разрешить запись к групповому IP-адресу ( FFxx:0:0:0:0:0:0:2 или ffxx:0:0:0:0:0:0:2.", //MSG035
	"Некорректная метрика", //MSG043
	"Значение метрики должно находиться в промежутке (1..16).", //ar_alert_3
	"Некорректная маска сети.", //ar_alert_5
	"Ключ", //TEXT042_1
	" является неверным, допустимыми символами являются 0~9, A~F или a~f.", //TEXT042_2
	"Примечание: Также, возможно, потребуется предоставить имя службы. Если эта информация отсутствует или неизвестна, пожалуйста, обратитесь к провайдеру.", //wwa_note_svcn
	"L2TP-клиент.", //wwa_msg_l2tp
	"Чтобы установить данное соединение, необходимо иметь имя пользователя и пароль от провайдера. Также потребуется IP-адрес L2TP. Если эта информация отсутствует, пожалуйста, обратитесь к провайдеру.", //wwa_set_l2tp_msg
	"Чтобы установить данное соединение, необходимо иметь имя пользователя и пароль от провайдера. Также потребуется IP-адрес сервера BigPond. Если эта информация отсутствует, пожалуйста, обратитесь к провайдеру.", //wwa_msg_set_bigpond
	"Имя хоста", //_hostname
	"Полоса частот 2,4 ГГц", //GW_WLAN_RADIO_0_NAME
	"Полоса частот 5 ГГц", //GW_WLAN_RADIO_1_NAME
	"Ниже указано подробное изложение настроек безопасности Wi-Fi. Пожалуйста, распечатайте эту страницу или запишите информацию на листок бумаги, в результате чего можно будет настроить верные параметры на устройствах Wi-Fi.", //wwl_intro_end
	"Пожалуйста, подождите…", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Подключить", //_connect
	"Провести через настройки Интернет-соединения", //ES_btn_guide_me
	"Включить графическую аутентификацию", //_graph_auth
	"D-LINK CORPORATION, INC | БЕСПРОВОДНОЙ МАРШРУТИЗАТОР | ДОМАШНЯЯ СТРАНИЦА", //TEXT000
	"Пароль L2TP ДОЛЖЕН быть задан", //GW_WAN_L2TP_PASSWORD_INVALID
	"Интернет не обнаружен, хотите перезапустить мастер?", //mydlink_tx03
	"Пароль администратора не может быть пустым.", //mydlink_tx04
	"Проверка возможности подключения WAN.", //mydlink_tx05
	"секунд осталось.", //sec_left
	"Повторить", //_retry
	"У Вас есть учетная запись mydlink?", //mydlink_tx06
	"Да, у меня есть учетная запись mydlink.", //mydlink_tx07
	"Нет, я хочу зарегистрироваться и авторизоваться под новой учетной записью mydlink.", //mydlink_tx08
	"Адрес электронной почты (Имя учетной записи)", //mydlink_tx09
	"Пожалуйста, выполните опции, чтобы завершить регистрацию.", //mydlink_tx10
	"Подтвердить пароль", //chk_pass
	"Фамилия", //Lname
	"Имя", //Fname
	"Я принимаю условия соглашения mydlink.", //mydlink_tx12
	"Чтобы завершить регистрацию в mydlink, пожалуйста, проверьте почтовый ящик на предмет получения инструкций подтверждения.", //mydlink_tx13_1
	" После подтверждения адреса электронной почты нажмите кнопку Авторизоваться.", //mydlink_tx13_2
	"Авторизоваться", //_login
	"Ok", //_ok
	"Сохранить", //_save
	"Пожалуйста, сделайте два пароля одинаковыми и попробуйте еще раз", //_pwsame
	"Чтобы использовать функции  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> и приложение mydlink Lite, потребуется учетная запись с <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Если у Вас уже есть учетная запись, выберите <strong>Да, у меня есть учетная запись mydlink</strong> и нажмите Далее, чтобы зарегистрировать маршрутизатор с <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Если у Вас нет учетной записи, выберите <strong>Нет, я хочу зарегистрироваться и авторизоваться под новой учетной записью mydlink</strong> и нажмите Далее, чтобы создать учетную запись. ", //mydlink_reg_into_3
	" Если Вы не желаете подписаться на службу mydlink, пожалуйста, нажмите Отменить.", //mydlink_reg_into_4_a
	"Данный адрес электронной почты уже имеет учетную запись mydlink. Попробуйте другой адрес электронной почты.", //mydlink_pop_01
	"Необходимо принять условия соглашения, чтобы продолжить.", //mydlink_pop_02
	"не должен быть пустым.", //mydlink_pop_03
	"является некорректным.", //mydlink_pop_04
	"Теперь можно использовать службу mydlink с данным устройством", //mydlink_pop_05
	"Ошибка авторизации", //mydlink_pop_06
	"Подписаться", //_signup
	"(GMT+07:00) Новосибирск", //up_tz_74
	"(GMT+12:00) Магадан", //up_tz_75
	"После регистрации в mydlink для соединений PPPoE, L2TP, PPTP по умолчанию будет установлено \"Всегда вкл.\". Если Ваш провайдер взимает оплату на основе времени соединения, в качестве настройки по умолчанию можно вручную выбрать \"Соединение по требованию\".", //mydlink_pop_09
	"Невозможно зайти на сайт mydlink.", //mdl_errmsg_01
	"Не удалось отправить запрос на вход.", //mdl_errmsg_02
	"Невозможно отправить запрос на вход.", //mdl_errmsg_03
	"Не удалось отправить запрос на регистрацию.", //mdl_errmsg_04
	"Невозможно отправить запрос на регистрацию.", //mdl_errmsg_05
	"Поле SSID не может быть пустым", //SSID_EMPTY_ERROR
	"Введеные пароли не совпадают", //YM102
	"Пароль PPPoE ДОЛЖЕН быть задан", //GW_WAN_PPPoE_PASSWORD_INVALID
	"Пароль должен содержать более 6 символов", //limit_pass_msg
	"Пропустить", //_skip
	" Если Вы не желаете подписаться на службу mydlink, пожалуйста, нажмите Пропустить.", //mydlink_reg_into_4
	"Сохранение настроек Wi-Fi", //mydlink_WiFi_save
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
