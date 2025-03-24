//Version=1.03b02
//Language=Spanish
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Cancelar", //_cancel
	"Copiar la dirección MAC del PC", //_clone
	"Conexión DHCP (dirección IP dinámica)", //_dhcpconn
	"Dirección IP", //_ipaddr
	"L2TP", //_L2TP
	"Dirección IP de puerta de enlace de L2TP", //_L2TPgw
	"Dirección IP de L2TP", //_L2TPip
	"Máscara de subred L2TP", //_L2TPsubnet
	"Idioma", //_Language
	"Dirección MAC", //_macaddr
	"Siguiente", //_next
	"No", //_no
	"(Opcional)", //_optional
	"Contraseña", //_password
	"Dirección IP de puerta de enlace PPTP", //_PPTPgw
	"Dirección IP de PPTP", //_PPTPip
	"Máscara de subred PPTP", //_PPTPsubnet
	"Anterior", //_prev
	"Haga coincidir las dos contraseñas de administrador y vuelva a intentarlo.", //_pwsame_admin
	"IP estática", //_sdi_staticip
	"Máscara de subred", //_subnet
	"Nombre de usuario", //_username
	"Verifique su contraseña", //_verifypw
	"¿Desea abandonar todos los cambios realizados en este asistente?", //_wizquit
	"Sí", //_yes
	"Dirección IP del servidor L2TP no válida", //bwn_alert_17
	"Modo de dirección", //bwn_AM
	"Servidor BigPond", //bwn_BPS
	"TKIP y AES", //bws_CT_3
	"IP dinámica", //carriertype_ct_0
	"El router está detectando el tipo de conexión a Internet, espere…", //ES_auto_detect_desc
	"El router no puede detectar el tipo de conexión a Internet.", //ES_auto_detect_failed_desc
	"¿Desea marcar \"Gestión web del router D-Link\"?", //ES_bookmark
	"Inténtelo de nuevo", //ES_btn_try_again
	"Conecte un extremo del cable Ethernet suministrado con el router al puerto que lleva la etiqueta INTERNET en la parte posterior del router. Enchufe el otro extremo de este cable al puerto Ethernet de su módem y realice un ciclo de encendido y apagado en el módem.", //ES_cable_lost_desc
	"Paso 2: Configurar la seguridad Wi-Fi", //ES_step_wifi_security
	"Paso 3: Establecer su contraseña", //ES_title_s3
	"Paso 4: Seleccionar su zona horaria", //ES_title_s4
	"Paso 5: Guardar los parámetros", //ES_title_s5
	"Paso 5: Confirmar los parámetros de WI-FI", //ES_title_s5_0
	"Paso 6: Registro mydlink", //ES_title_s6
	"Registro mydlink", //ES_title_s6_myd
	"Paso 1: Configurar la conexión de Internet", //ES_wwa_title_s1
	"El nombre del cliente DHCP no es válido", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Contraseña DHCP+ no válida", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nombre de usuario DHCP+ no válido", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Se ha de especificar un nombre de usuario L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"Se ha de especificar una contraseña PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Tecla de red no válida", //IPV6_TEXT2
	"Dirección MAC no válida", //KR3
	"Auto (WPA o WPA2) - Personal", //KR48
	"Adelphia PowerLink", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"Servicio DSL de AT&T", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"Comcast", //manul_conn_07
	"Covad", //manul_conn_08
	"Cox Communications", //manul_conn_09
	"Earthlink por cable", //manul_conn_10
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
	"Registrar su producto con mydlink le permitirá utilizar sus características habilitadas para mydlink, incluido el acceso y la gestión en línea del dispositivo a través del sitio web de mydlink.", //mydlink_tx01
	"¿Desea registrar el dispositivo con mydlink?", //mydlink_tx02
	"Introduzca el nombre de usuario", //PPP_USERNAME_EMPTY
	"Admite PPPoE Plus", //pppoe_plus_dail
	"La contraseña sólo puede contener caracteres imprimibles.", //S493
	"GUARDANDO LOS PARÁMETROS", //save_settings
	"Se están guardando los parámetros.", //save_wait
	"Versión de Firmware", //sd_FWV
	"Página del producto", //TA2
	"Versión de Hardware", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Hawái", //up_tz_02
	"(GMT-09:00) Alaska", //up_tz_03
	"(GMT-08:00) Hora Pacifico  (US/Canadá), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Hora Montaña (US/Canadá)", //up_tz_06
	"(GMT-06:00) América Central", //up_tz_07
	"(GMT-06:00) Hora Central  (US/Canadá)", //up_tz_08
	"(GMT-06:00) Ciudad de México", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogotá, Lima, Quito", //up_tz_11
	"(GMT-05:00) Hora este (US/Canadá)", //up_tz_12
	"(GMT-05:00) Indiana (East)", //up_tz_13
	"(GMT-04:00) Hora Atlántico  (Canadá)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Groenlandia", //up_tz_20
	"(GMT-02:00) Medio-Atlantico", //up_tz_21
	"(GMT-01:00) Azores", //up_tz_22
	"(GMT-01:00) Cabo Verde Is.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Hora Greenwich: Dublín, Edimburgo, Lisboa, Londres", //up_tz_25
	"(GMT+01:00) Amsterdam, Berlín, Berna, Roma, Estocolmo, Viena", //up_tz_26
	"(GMT+01:00) Belgrado, Bratislava, Budapest, Ljubljana, Praga", //up_tz_27
	"(GMT+01:00) Bruselas, Copenhague, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofía, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapest, Viena, Praga, Warsaw", //up_tz_29b
	"(GMT+01:00) África Central Este", //up_tz_30
	"(GMT+02:00) Atenas, Estambul, Minsk", //up_tz_31
	"(GMT+02:00) Bucarest", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretoria", //up_tz_34
	"(GMT+02:00) Helsinki, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalén", //up_tz_36
	"(GMT+03:00) Bagdad", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moscú, St. Petersburgo, Volgogrado", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teherán", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Bakú, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ekaterimburgo", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcuta, Chennai, Mumbai, Nueva Delhi", //up_tz_47
	"(GMT+05:45) Katmandú", //up_tz_48
	"(GMT+06:00) Almaty", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Yakarta", //up_tz_53
	"(GMT+08:00) Krasnoiarsk", //up_tz_54
	"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulan Bator", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapur", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipéi", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tokio", //up_tz_60
	"(GMT+09:00) Seúl", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaida", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sídney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Islas Salomón, New Caledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall Is.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) Línea de fecha internacional occidental", //up_tz_76
	"(GMT-11:00) Isla de Midway", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlán", //up_tz_78
	"(GMT-06:00) Guadalajara, Ciudad de Méjico, Monterrey", //up_tz_79
	"(GMT-05:00) Bogotá, Lima, Quito, Indiana (Este)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Varsovia, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kyiv, Riga, Sofía, Tallinn, Vilnius", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, Nueva Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulan Bator", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"Configuración DNS", //wwa_dnsset
	"Dirección Gateway", //wwa_gw
	"De forma predeterminada, el nuevo router D-Link no tiene configurada una contraseña para el acceso de administrador a las páginas de configuración basadas en la web. Para proteger el nuevo dispositivo de conexión en red, establezca y verifique una contraseña a continuación; además, la activación de la autenticación gráfica CAPTCHA proporciona seguridad añadida a fin de evitar el acceso a los parámetros de red por parte de software de piratas informáticos y de usuarios conectados no autorizados.", //wwa_intro_s1
	"Seleccione la zona horaria adecuada para su ubicación. Esta información es necesaria para configurar las opciones basadas en la hora. El router se ajustará para actualizar automáticamente su reloj interno desde un servidor de hora NTP.", //wwa_intro_s2
	"Seleccione su tipo de conexión a Internet a continuación:", //wwa_intro_s3
	"Este asistente lo guiará a lo largo del proceso de configuración de su nuevo router D-Link y de conexión a internet.", //wwa_intro_wel
	"Dirección IP del servidor L2TP (puede ser la misma que la de la puerta de enlace)", //wwa_l2tp_svra
	"Escoja esta si su conexión a internet le proporciona automáticamente una dirección IP. La mayoría de los módems de cable usan este tipo de conexión.", //wwa_msg_dhcp
	"Si su proveedor de servicios internet no figura en la lista o usted no sabe cuál es, seleccione el tipo de conexión a internet:", //wwa_msg_ispnot
	"Elija esta opción si su conexión a Internet requiere un nombre de usuario y una contraseña para navegar por la red. La mayoría de los módems DSL utilizan este tipo de conexión.", //wwa_msg_pppoe
	"Cliente PPTP", //wwa_msg_pptp
	"Para configurar esta conexión, asegúrese de que está conectado a D-Link Router con el PC que se conectó por primera vez a su conexión de banda ancha. Si es así, haga clic sobre el botón Clonar MAC para copiar la dirección MAC del ordenador al D-Link Router", //wwa_msg_set_dhcp
	"Para configurar esta conexión necesita que su proveedor de servicios internet le haya proporcionado un nombre de usuario y una clave de acceso. Si no tiene esta información, contacte con su ISP.", //wwa_msg_set_pppoe
	"Para configurar esta conexión necesita que su proveedor de servicios internet le haya proporcionado un nombre de usuario y una clave de acceso, así como una dirección IP PPTP. Si no tiene esta información, contacte con su ISP.", //wwa_msg_set_pptp
	"Escoja esta opción si su proveedor de servicios internet le ha proporcionado información de la dirección IP porque tiene que configurarse manualmente", //wwa_msg_sipa
	"Nota: Puede tener que proporcionar un nombre de host. Si no lo sabe con certeza, contacte con su ISP.", //wwa_note_hostname
	"Dirección DNS primaria", //wwa_pdns
	"Dirección IP del servidor PPTP (puede ser igual que el gateway)", //wwa_pptp_svraddr
	"Dirección DNS secundaria", //wwa_sdns
	"No figura en la lista o no lo sé", //wwa_selectisp_not
	"Configurar conexión con nombre de usuario y clave de acceso (L2TP)", //wwa_set_l2tp_title
	"Para configurar esta conexión necesita una lista completa de la información de IP proporcionada por su proveedor de servicios de internet. Si tiene una conexión de IP estática y no tiene esta información, contacte con su ISP.", //wwa_set_sipa_msg
	"Configurar conexión con dirección IP estática", //wwa_set_sipa_title
	"Configurar conexión BigPond Cable", //wwa_title_set_bigpond
	"Configurar conexión con nombre de usuario y clave de acceso (PPPoE)", //wwa_title_set_pppoe
	"Establezca la conexión con nombre de usuario y contraseña (PPTP)", //wwa_title_set_pptp
	"Bienvenido al Asistente de configuración D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Conexión con nombre de usario y clave de acceso (L2TP)", //wwa_wanmode_l2tp
	"Conexión con nombre de usario y clave de acceso (PPPoE)", //wwa_wanmode_pppoe
	"Conexión con nombre de usario y clave de acceso (PPTP)", //wwa_wanmode_pptp
	"Conexión con dirección IP estática", //wwa_wanmode_sipa
	"Asigne un nombre a la red Wi-Fi.", //wwz_wwl_intro_s2_1
	"Nombre de la red Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Utilizando un máximo de 32 caracteres)", //wwz_wwl_intro_s2_1_2
	"Asigne una contraseña a la red Wi-Fi.", //wwz_wwl_intro_s2_2
	"Contraseña Wi-Fi ", //wwz_wwl_intro_s2_2_1
	"(entre 8 y 63 caracteres)", //wwz_wwl_intro_s2_2_2
	"Asígnele un nombre a la red, de hasta 32 caracteres.", //wwz_wwl_intro_s3_1
	"Paso 1: Bienvenido al ASISTENTE DE CONFIGURACIÓN DE SEGURIDAD INALÁMBRICA DE D-LINK", //wwz_wwl_title_s3
	"La dirección IP del servidor PPTP no es válida", //YM108
	"Utilice la contraseña de seguridad inalámbrica en las bandas de 2,4 GHz y de 5 GHz.", //wwl_SSP
	"Asigne un nombre y una contraseña a la red Wi-Fi.", //wwz_wwl_intro_s0
	"La 1ª dirección de %s debe ser un número entero.,", //MSG002
	"La 2ª dirección de %s debe ser un número entero.,", //MSG003
	"La 3ª dirección de %s debe ser un número entero.,", //MSG004
	"La 4ª dirección de %s debe ser un número entero.,", //MSG005
	"La %s es una dirección no válida.", //MSG006
	"El %s no puede ser cero.,", //MSG007
	"El puerto %s no es válida.", //MSG008
	"El secreto %s introducido no es válido,", //MSG009
	"El %s no puede permitir introducir IP de bucle o IP multidifusión (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Por favor, introduzca otro valor% s.", //MSG012
	"El valor de %s debe ser numérico,", //MSG013
	"El rango de %s es %1n ~ %2n.,", //MSG014
	"El valor de% s debe ser un número par.", //MSG015
	"La clave no es válida. La clave debe tener 5 caracteres o 10 números hexadecimales. Ha introducido", //MSG016
	"La clave no es válida. La clave debe tener 13 caracteres o 26 números hexadecimales. Ha introducido", //MSG017
	"La 1ra dirección de %s debe ser hexadecimal.", //MSG018
	"La 2da dirección de %s debe ser hexadecimal.", //MSG019
	"La 3ra dirección  de %s debe ser hexadecimal.", //MSG020
	"La 4ta dirección de %s debe ser hexadecimal.", //MSG021
	"La 5ta dirección  de% s debe ser un hexadecimal.", //MSG022
	"La 6ta dirección de %s debe ser hexadecimal.", //MSG023
	"La 7ma dirección de %s debe ser hexadecimal.", //MSG024
	"La 8va dirección de %s debe ser hexadecimal.", //MSG025
	"El 1er rango de %s debe estar entre", //MSG026
	"El 2do rango de %s debe estar entre", //MSG027
	"El 3er rango de %s debe estar entre", //MSG028
	"El 4to rango  de %s debe estar entre", //MSG029
	"El 5to rango de %s debe estar entre", //MSG030
	"El 6to rango de %s debe estar entre", //MSG031
	"El 7mo rango de %s debe estar entre", //MSG032
	"El 8vo rango de %s debe estar entre", //MSG033
	"El %s no puede permitir introducir IP de bucle ( ::1 ).,", //MSG034
	"El %s no puede permitir introducir IP multidifusión ( FFxx:0:0:0:0:0:0:2 or ffxx:0:0:0:0:0:0:2.", //MSG035
	"Inválida Métrico", //MSG043
	"El valor métrico debe estar comprendido entre1 y 16", //ar_alert_3
	"Máscara de red no válida", //ar_alert_5
	"La clave", //TEXT042_1
	" no es correcta, los caracteres permitidos son 0~9, A~F o a~f.", //TEXT042_2
	"Nota: Puede tener que proporcionar un nombre de servicio. Si no lo sabe con certeza, contacte con su ISP.", //wwa_note_svcn
	"Cliente L2TP", //wwa_msg_l2tp
	"Para configurar esta conexión necesita que su proveedor de servicios internet le haya proporcionado un nombre de usuario y una clave de acceso, así como una dirección IP L2TP. Si no tiene esta información, contacte con su ISP.", //wwa_set_l2tp_msg
	"Para configurar esta conexión necesita que su proveedor de servicios internet le haya proporcionado un nombre de usuario y una clave de acceso, así como una dirección IP de servidor BigPond. Si no tiene esta información, contacte con su ISP.", //wwa_msg_set_bigpond
	"Nombre de host", //_hostname
	"Banda de frecuencia 2,4 GHz", //GW_WLAN_RADIO_0_NAME
	"Banda de frecuencia 5GHz", //GW_WLAN_RADIO_1_NAME
	"A continuación se muestra un resumen detallado de los parámetros de seguridad Wi-Fi. Imprima esta página o escriba la información en un papel para configurar los parámetros correctos en los dispositivos Wi-Fi.", //wwl_intro_end
	"espere, por favor...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Conectar", //_connect
	"Guíame por los parámetros de conexión a Internet", //ES_btn_guide_me
	"Habilitar la autenticación gráfica", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTER INALÁMBRICO | HOGAR", //TEXT000
	"Se ha de especificar una contraseña L2TP", //GW_WAN_L2TP_PASSWORD_INVALID
	"No se ha detectado Internet, ¿desea reiniciar el asistente?", //mydlink_tx03
	"La contraseña de administrador no puede estar en blanco.", //mydlink_tx04
	"Comprobando la conexión WAN.", //mydlink_tx05
	"segundos restantes.", //sec_left
	"Reintentar", //_retry
	"¿Tiene una cuenta de mydlink?", //mydlink_tx06
	"Sí, tengo una cuenta de mydlink.", //mydlink_tx07
	"No, deseo registrarme e iniciar sesión con una nueva cuenta mydlink.", //mydlink_tx08
	"Dirección de correo electrónico (nombre de cuenta)", //mydlink_tx09
	"Rellene las opciones para completar el registro..", //mydlink_tx10
	"Confirmar contraseña", //chk_pass
	"Apellido", //Lname
	"Nombre", //Fname
	"Acepto las condiciones de mydlink.", //mydlink_tx12
	"Para completar el registro en mydlink, marque la Bandeja de entrada para ver las instrucciones sobre el correo electrónico con confirmación.", //mydlink_tx13_1
	" Después de confirmar la dirección de correo electrónico, haga clic en el botón Inicio de sesión.", //mydlink_tx13_2
	"Iniciar sesión", //_login
	"Aceptar", //_ok
	"guardar", //_save
	"Haga que las dos contraseñas sean iguales e inténtelo de nuevo", //_pwsame
	"Para utilizar las características de <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> y de la aplicación Lite de mydlink, necesitará disponer de una cuenta con <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Si ya tiene una cuenta, seleccione <strong>Sí, tengo una cuenta de mydlink</strong> y haga clic en Siguiente para registrar el router con <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Si no tiene una cuenta, seleccione <strong>No, deseo registrarme e iniciar sesión con una nueva cuenta mydlink</strong> y haga clic en Siguiente para crear una cuenta. ", //mydlink_reg_into_3
	" Si no desea registrarse para el servicio mydlink, haga clic en Cancelar.", //mydlink_reg_into_4_a
	"Esta dirección de correo electrónico ya tiene una cuenta mydlink. Inténtelo con una cuenta de correo electrónico diferente.", //mydlink_pop_01
	"Para continuar, debe aceptar las condiciones.", //mydlink_pop_02
	"no debe estar en blanco.", //mydlink_pop_03
	"no es válido.", //mydlink_pop_04
	"Ahora puede utilizar el servicio mydlink con este dispositivo", //mydlink_pop_05
	"Error de inicio de sesión", //mydlink_pop_06
	"Registrarse", //_signup
	"Una vez completado el registro en mydlink, el router tiene las conexiones PPPoE, L2TP, PPTP como predeterminadas y serán definidas como Always On (Siempre Conectado). Si su ISP hace cambios, usted puede elegir manualmente Dial On Demand como su configuración predeterminada.", //mydlink_pop_09
	"No se puede iniciar sesión en mydlink.", //mdl_errmsg_01
	"Error de solicitud de envío de registro.", //mdl_errmsg_02
	"No se puede enviar la solicitud de registro.", //mdl_errmsg_03
	"Error de solicitud de envío de suscripción.", //mdl_errmsg_04
	"No se puede enviar la solicitud de suscripción.", //mdl_errmsg_05
	"El campo SSID no puede estar en blanco", //SSID_EMPTY_ERROR
	"Las contraseñas introducidas no coinciden", //YM102
	"Se ha de especificar una contraseña PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"La contraseña de la cuenta debe tener más de seis caracteres", //limit_pass_msg
	"Omitir", //_skip
	" Si no desea registrarse para el servicio mydlink, haga clic en Omitir.", //mydlink_reg_into_4
	"Guardando la configuración Wi-Fi", //mydlink_WiFi_save
	"PPTP para Rusia (acceso dual)", //rus_wan_pptp
	"PPTP para Rusia (acceso dual)", //rus_wan_pptp_01
	"L2TP para Rusia (acceso dual)", //rus_wan_l2tp
	"L2TP para Rusia (acceso dual)", //rus_wan_l2tp_01
	"PPPoE para Rusia (acceso dual)", //rus_wan_pppoe
	"PPPoE para Rusia (acceso dual)", //rus_wan_pppoe_02
	"Configuración de Wan física", //rus_wan_pppoe_03
	"Este dispositivo está habilitado para mydlink, que permite supervisar y gestionar la red de forma remota a través del sitio web mydlink.com o a través de la aplicación móvil de mydlink.", //_wz_mydlink_into_1
	"Podrá comprobar las velocidades de la red, ver quién está conectado, ver el historial de exploración del dispositivo y recibir notificaciones acerca de nuevos usuarios o intentos de intrusión.", //_wz_mydlink_into_2
	"Puede registrar este dispositivo con su cuenta de mydlink existente. Si no tiene una, puede crearla ahora.", //_wz_mydlink_into_3
	"Consulte su buzón de correo para ver si ha recibido un mensaje de correo electrónico con las instrucciones de confirmación.", //_wz_mydlink_email_1
	"El router está comprobando la conectividad a Internet, espere.", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"El valor métrico debe estar comprendido entre1 y 15", //ar_alert_3a
	"Dirección IP del servidor", //SERVER_IP_DESC
	"%s La dirección IP de puerta de enlace %s debe estar dentro de la subred WAN.", //TEXT043
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