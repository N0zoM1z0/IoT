//Version=1.01b02
//Language=Portuguese
//Date=Thu, 17, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Cancelar", //_cancel
	"Copiar o Endereço MAC do seu Computador", //_clone
	"Ligação DHCP (Endereço IP Dinâmico)", //_dhcpconn
	"Endereço IP", //_ipaddr
	"L2TP", //_L2TP
	"Endereço IP Gateway L2TP", //_L2TPgw
	"Endereço IP L2TP", //_L2TPip
	"Máscara de Sub-rede L2TP", //_L2TPsubnet
	"Idioma", //_Language
	"Endereço MAC", //_macaddr
	"Seguinte", //_next
	"Não", //_no
	"(opcional)", //_optional
	"Palavra-passe", //_password
	"Endereço IP Gateway PPTP:", //_PPTPgw
	"Endereço IP PPTP", //_PPTPip
	"Máscara de Sub-rede PPTP", //_PPTPsubnet
	"Ant", //_prev
	"Coloque as duas palavras-passe de administrador iguais e tente novamente", //_pwsame_admin
	"IP Estático", //_sdi_staticip
	"Máscara Sub-rede", //_subnet
	"Nome de utilizador", //_username
	"Confirmar a Palavra-passe", //_verifypw
	"Pretende abandonar todas as alterações que fez neste assistente?", //_wizquit
	"Sim", //_yes
	"Endereço IP do Servidor L2TP inválido", //bwn_alert_17
	"Modo Endereço", //bwn_AM
	"Servidor BigPond", //bwn_BPS
	"TKIP e AES", //bws_CT_3
	"IP Dinâmico", //carriertype_ct_0
	"O router está a detectar a sua ligação à Internet, aguarde…", //ES_auto_detect_desc
	"O router não conseguiu detectar o seu tipo de ligação à Internet.", //ES_auto_detect_failed_desc
	"Deseja marcar \"D-Link Router Web Management\"?", //ES_bookmark
	"Tente novamente", //ES_btn_try_again
	"Ligue uma extremidade do cabo Ethernet fornecido com o seu router na porta INTERNET na parte traseira do router. Ligue a outra extremidade deste cabo à porta Ethernet do seu modem.", //ES_cable_lost_desc
	"Passo 2: Configure a sua Segurança Wi-Fi", //ES_step_wifi_security
	"Passo 3: defina a sua Palavra-passe", //ES_title_s3
	"Passo 4: selecione o seu Fuso Horário", //ES_title_s4
	"Passo 5: Guardar Definições", //ES_title_s5
	"Passo 5: Confirmar Definições WI-FI", //ES_title_s5_0
	"Passo 6: Registo no MYDLINK", //ES_title_s6
	"Registo no MYDLINK", //ES_title_s6_myd
	"Passo 1: configure a sua Ligação à Internet", //ES_wwa_title_s1
	"Nome Cliente DHCP inválido", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Palavra-passe de DHCP+ inválida", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nome de utilizador de DHCP+ inválido", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"DEVE ser especificado um nome de utilizador L2TP", //GW_WAN_L2TP_USERNAME_INVALID
	"DEVE ser especificada uma palavra-passe PPTP", //GW_WAN_PPTP_PASSWORD_INVALID
	"Chave de Rede Inválida!", //IPV6_TEXT2
	"Endereço MAC inválido", //KR3
	"Automático (WPA ou WPA2) - Pessoal", //KR48
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"Serviço ATAT DSL", //manul_conn_03
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
	"Registando o seu produto em mydlink permitir-lhe-á utilizar as suas funções com ativação mydlink, incluindo acesso e gestão on-line do seu dispositivo através do serviço mydlink.", //mydlink_tx01
	"Gostaria de registar o seu dispositivo em mydlink?", //mydlink_tx02
	"Introduza um nome de utilizador", //PPP_USERNAME_EMPTY
	"PPPoE Plus Supported", //pppoe_plus_dail
	"A palavra-passe deve conter apenas caracteres para impressão.", //S493
	"A GUARDAR DEFINIÇÕES", //save_settings
	"As suas definições estão a ser guardadas.", //save_wait
	"Versão de Firmware", //sd_FWV
	"Página do Produto", //TA2
	"Versão de Hardware", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Havai", //up_tz_02
	"(GMT-09:00) Alasca", //up_tz_03
	"(GMT-08:00) Hora do Pacífico (EUA/Canadá), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Hora da Montanha (EUA/Canadá)", //up_tz_06
	"(GMT-06:00) América Central", //up_tz_07
	"(GMT-06:00) Hora Central (EUA/Canadá)", //up_tz_08
	"(GMT-06:00) Cidade do México", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogotá, Lima, Quito", //up_tz_11
	"(GMT-05:00) Hora Oriental (EUA/Canadá)", //up_tz_12
	"(GMT-05:00) Indiana (Este)", //up_tz_13
	"(GMT-04:00) Hora do Atlântico (Canadá)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Terranova", //up_tz_17
	"(GMT-03:00) Brasília", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Gronelândia", //up_tz_20
	"(GMT-02:00) Médio Atlântico", //up_tz_21
	"(GMT-01:00) Açores", //up_tz_22
	"(GMT-01:00) Ilhas de Cabo Verde", //up_tz_23
	"(GMT) Casablanca, Monróvia", //up_tz_24
	"(GMT) Meridiano de Greenwich: Dublin, Edimburgo, Lisboa, Londres  ", //up_tz_25
	"(GMT+01:00) Amesterdão, Berlim, Berna, Roma, Estocolmo", //up_tz_26
	"(GMT+01:00) Belgrado, Bratislava, Ljubljana", //up_tz_27
	"(GMT+01:00) Bruxelas, Copenhaga, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sófia, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapeste, Viena, Praga, Varsóvia", //up_tz_29b
	"(GMT+01:00) África Centro Oeste", //up_tz_30
	"(GMT+02:00) Atenas, Istambul, Minsk", //up_tz_31
	"(GMT+02:00) Bucareste", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretória", //up_tz_34
	"(GMT+02:00) Helsínquia, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalém", //up_tz_36
	"(GMT+03:00) Bagdade", //up_tz_37
	"(GMT+03:00) Kuwait, Riade", //up_tz_38
	"(GMT+04:00) Moscovo, S. Petersburgo, Volgogrado", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:00) Teerão", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Kabul", //up_tz_44
	"(GMT+06:00) Ecaterinburgo", //up_tz_45
	"(GMT+05:00) Islamabade, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcutá, Chennai, Mumbai, Nova Deli", //up_tz_47
	"(GMT+05:45) Katmandu", //up_tz_48
	"(GMT+06:00) Novosibirsk", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Banguecoque, Hanói, Jacarta", //up_tz_53
	"(GMT+08:00) Krasnoyarsk", //up_tz_54
	"(GMT+08:00) Pequim, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk, Ulaan Bataar", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Singapura", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osáca, Sapporo, Tóquio", //up_tz_60
	"(GMT+09:00) Seul", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Camberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Ilhas de Salomão, Nova Caledónia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Ilhas Marshall", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"Definições DNS", //wwa_dnsset
	"Endereço da Gateway", //wwa_gw
	"Por defeito, o seu novo Router D-Link não tem uma palavra-passe configurada para acesso de administrador às páginas de configuração baseadas na Internet. Para tornar seguro o seu novo dispositivo de rede, crie e verifique uma palavra-passe abaixo e ativando a Autenticação Gráfica CAPTCHA fornece proteção de segurança adicional para evitar que utilizadores on-line sem autorização e software hacker acedam às definições da sua rede.", //wwa_intro_s1
	"Selecione o fuso horário adequado para a sua localização. Esta informação é necessária para configurar as opções baseadas na hora para o router.", //wwa_intro_s2
	"Selecione o seu tipo de ligação à Internet:", //wwa_intro_s3
	"Este assistente guiá-lo-á pelo processo passo-a-passo para configurar o seu novo router D-Link e ligá-lo à Internet.", //wwa_intro_wel
	"Endereço IP do Servidor L2TP (pode ser o mesmo que a gateway)", //wwa_l2tp_svra
	"Selecione se a sua ligação à Internet lhe fornece um endereço IP automaticamente. A maioria dos modems por Cabo utiliza este tipo de ligação.", //wwa_msg_dhcp
	"Se o seu Fornecedor do Serviço de Internet não estiver listado ou não souber qual é, selecione a ligação à Internet:", //wwa_msg_ispnot
	"Selecione esta opção se a sua ligação à Internet necessitar de um nome de utilizador e palavra-passe para ligar. A maioria dos modems DSL utiliza este tipo de ligação.", //wwa_msg_pppoe
	"Cliente PPTP.", //wwa_msg_pptp
	"Para configurar a ligação, certifique-se de que está ligado ao router D-Link com o computador que foi ligado originalmente à sua ligação de banda larga. Se tiver, clique no botão Clonar MAC para copiar o Endereço MAC do seu computador para o Router D-Link.", //wwa_msg_set_dhcp
	"Para configurar esta ligação terá de ter um Nome de Utilizador e Palavra-passe do seu Fornecedor de Serviços de Internet. Se não tiver estas informações, por favor contacte o seu ISP (fornecedor de serviços Internet).", //wwa_msg_set_pppoe
	"Para configurar esta ligação terá de ter um Nome de Utilizador e Palavra-passe do seu Fornecedor de Serviços de Internet. Precisa também de um endereço IP PPTP. Se não tiver estas informações, por favor contacte o seu ISP (fornecedor de serviços Internet)", //wwa_msg_set_pptp
	"Escolha esta opção se o seu Fornecedor do Serviço de Internet lhe forneceu informações do Endereço IP que tenha de ser configurado manualmente.", //wwa_msg_sipa
	"Nota: Pode também precisar de fornecer um Nome de Anfitrião. Se não tiver ou não souber estas informações, por favor contacte o seu ISP (fornecedor de serviços Internet).", //wwa_note_hostname
	"Endereço de DNS preferido:", //wwa_pdns
	"Endereço IP do Servidor PPTP (pode ser a mesma que a gateway)", //wwa_pptp_svraddr
	"Endereço de DNS Alternativo", //wwa_sdns
	"Não Listado ou Não Sabe", //wwa_selectisp_not
	"Defina a Ligação com Nome de Utilizador e Palavra-passe (L2TP)", //wwa_set_l2tp_title
	"Para configurar esta ligação, deverá ter uma lista completa de informações do IP fornecida pelo seu Fornecedor do Serviço de Internet. Se tiver uma ligação com IP Estático e não tiver esta informação, contacte o seu ISP.", //wwa_set_sipa_msg
	"Definir Ligação com Endereço IP Fixo", //wwa_set_sipa_title
	"Definir Ligação por Cabo BigPond", //wwa_title_set_bigpond
	"Defina a Ligação com Nome de Utilizador e Palavra-passe (PPPoE)", //wwa_title_set_pppoe
	"Defina a Ligação com Nome de Utilizador e Palavra-passe (PPTP)", //wwa_title_set_pptp
	"Bem-vindo ao Assistente de Configuração D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Nome do utilizador / Palavra-passe da Ligação (L2TP)", //wwa_wanmode_l2tp
	"Nome do utilizador / Palavra-passe da Ligação (PPPoE)", //wwa_wanmode_pppoe
	"Nome do utilizador / Palavra-passe da Ligação (PPTP)", //wwa_wanmode_pptp
	"Ligação Endereço IP estático:", //wwa_wanmode_sipa
	"Atribuir um nome à sua rede sem fios.", //wwz_wwl_intro_s2_1
	"Nome de Rede Sem Fios (SSID)", //wwz_wwl_intro_s2_1_1
	"(utilizando até 32 caracteres)", //wwz_wwl_intro_s2_1_2
	"Atribuir uma palavra-passe à sua rede sem fios.", //wwz_wwl_intro_s2_2
	"Palavra-passe Wi-Fi", //wwz_wwl_intro_s2_2_1
	"(entre 8 e 63 caracteres)", //wwz_wwl_intro_s2_2_2
	"Dê um nome à sua rede utilizando até 32 caracteres.", //wwz_wwl_intro_s3_1
	"Passo 1: Bem-vindo AO ASSISTENTE DE CONFIGURAÇÃO DE SEGURANÇA DA REDE SEM FIOS D-LINK", //wwz_wwl_title_s3
	"Endereço IP do servidor PPTP inválido", //YM108
	"Use a mesma Palavra-passe de Segurança Sem Fios nas bandas 2,4GHz e 5GHz", //wwl_SSP
	"Atribua um nome e uma palavra-passe à sua rede Wi-Fi.", //wwz_wwl_intro_s0
	"O 1.º endereço de %s tem de ser um número inteiro.", //MSG002
	"O 2.º endereço de %s tem de ser um número inteiro.", //MSG003
	"O 3.º endereço de %s tem de ser um número inteiro.", //MSG004
	"O 4.º endereço de %s tem de ser um número inteiro.", //MSG005
	"O %s é um endereço inválido.", //MSG006
	"O %s não pode ser zero.", //MSG007
	"A porta %s introduzida é inválida.", //MSG008
	"A %s secreta introduzida é inválida.", //MSG009
	"A %s não pode permitir a introdução de IP de retorno ou multidifusão de IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x).", //MSG010
	"Introduza outro valor %s.", //MSG012
	"O valor de %s tem de ser numérico!", //MSG013
	"O intervalo de %s é %1n ~ %2n.", //MSG014
	"O valor de %s tem de ser um número par!", //MSG015
	"A Chave é inválida. A Chave tem de ser um número hexadecimal de 5 ou 10 caracteres. Introduziu", //MSG016
	"A Chave é inválida. A Chave tem de ser um número hexadecimal de 13 ou 26 caracteres. Introduziu", //MSG017
	"O 1.º endereço de %s tem de ser um número hexadecimal.", //MSG018
	"O 2.º endereço de %s tem de ser um número hexadecimal.", //MSG019
	"O 3.º endereço de %s tem de ser um número hexadecimal.", //MSG020
	"O 4.º endereço de %s tem de ser um número hexadecimal.", //MSG021
	"O 5.º endereço de %s tem de ser um número hexadecimal.", //MSG022
	"O 6.º endereço de %s tem de ser um número hexadecimal.", //MSG023
	"O 7.º endereço de %s tem de ser um número hexadecimal.", //MSG024
	"O 8.º endereço de %s tem de ser um número hexadecimal.", //MSG025
	"O 1.º intervalo de %s tem de estar entre", //MSG026
	"O 2.º intervalo de %s tem de estar entre", //MSG027
	"O 3.º intervalo de %s tem de estar entre", //MSG028
	"O 4.º intervalo de %s tem de estar entre", //MSG029
	"O 5.º intervalo de %s tem de estar entre", //MSG030
	"O 6.º intervalo de %s tem de estar entre", //MSG031
	"O 7.º intervalo de %s tem de estar entre", //MSG032
	"O 8.º intervalo de %s tem de estar entre", //MSG033
	"O %s não pode permitir a entrada em IP de retorno ( ::1 ).", //MSG034
	"O %s não pode permitir a entrada em multidifusão IP ( FFxx:0:0:0:0:0:0:2 ou ffxx:0:0:0:0:0:0:2.", //MSG035
	"Sistema Métrico Inválido", //MSG043
	"O valor métrico tem de situar-se entre (1..16).", //ar_alert_3
	"Máscara de Rede Inválida.", //ar_alert_5
	"A Chave", //TEXT042_1
	" está errada, os carateres são 0~9, A~F, ou a~f.", //TEXT042_2
	"Nota: Pode também precisar de fornecer um Nome do Serviço. Se não tiver ou não souber estas informações, por favor contacte o seu ISP (fornecedor de serviços Internet).", //wwa_note_svcn
	"Cliente L2TP.", //wwa_msg_l2tp
	"Para configurar esta ligação terá de ter um Nome de Utilizador e Palavra-passe do seu Fornecedor de Serviços de Internet. Precisa também de um endereço IP L2TP. Se não tiver estas informações, por favor contacte o seu ISP (fornecedor de serviços Internet)", //wwa_set_l2tp_msg
	"Para configurar esta ligação terá de ter um Nome de Utilizador e Palavra-passe do seu Fornecedor de Serviços de Internet. Precisa também de um endereço IP Servidor BigPond. Se não tiver estas informações, por favor contacte o seu ISP (fornecedor de serviç", //wwa_msg_set_bigpond
	"Nome do Anfitrião", //_hostname
	"Banda de 2,4 GHz", //GW_WLAN_RADIO_0_NAME
	"Banda de 5GHz", //GW_WLAN_RADIO_1_NAME
	"Abaixo encontra-se um resumo das suas definições de segurança Wi-Fi. Imprima esta página ou anote as informações num papel para que possa configurar as definições corretas nos seus dispositivos Wi-Fi.", //wwl_intro_end
	"Aguarde por favor...", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"Ligar", //_connect
	"Orientar-me nas definições da ligação à Internet", //ES_btn_guide_me
	"Permitir Autenticação Gráfica", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTER SEM FIOS | INÍCIO", //TEXT000
	"DEVE ser especificada uma palavra-passe L2TP", //GW_WAN_L2TP_PASSWORD_INVALID
	"A Internet não foi detetada, deseja reiniciar o assistente?", //mydlink_tx03
	"A palavra-passe de administrador não pode estar em branco.", //mydlink_tx04
	"A verificar a conetividade WAN.", //mydlink_tx05
	"segundos restantes.", //sec_left
	"Tentar novamente", //_retry
	"Tem uma conta mydlink?", //mydlink_tx06
	"Sim, tenho uma conta mydlink.", //mydlink_tx07
	"Não, quero registar e iniciar sessão com uma conta mydlink nova.", //mydlink_tx08
	"Endereço de Correio Eletrónico (Nome de Conta)", //mydlink_tx09
	"Preencha as opções para completar o registo.", //mydlink_tx10
	"Confirmar a Palavra-passe", //chk_pass
	"Último nome", //Lname
	"Primeiro Nome", //Fname
	"Aceito os termos e condições de mydlink.", //mydlink_tx12
	"Para concluir o seu registo em mydlink, verifique se na sua pasta Recebidas se encontra uma mensagem de correio eletrónico com instruções de confirmação.", //mydlink_tx13_1
	" Após confirmar o seu endereço de correio eletrónico, clique no botão Login (Iniciar sessão).", //mydlink_tx13_2
	"Login", //_login
	"OK", //_ok
	"Guardar", //_save
	"Coloque as duas palavras-passe iguais e tente novamente", //_pwsame
	"Para utilizar as funções de  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> e a aplicação mydlink Lite, necessitará de uma conta com  <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"Se já tiver uma conta, selecione <strong>Sim, tenho uma conta mydlink </strong> e clique em Seguinte para registar o router numa <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"Se não tiver uma conta, selecione <strong>Não, quero registar-me e iniciar sessão com uma conta mydlink nova</strong> e clique em Seguinte para criar uma conta. ", //mydlink_reg_into_3
	" Se não quiser registar-se no serviço mydlink, clique em Cancelar.", //mydlink_reg_into_4_a
	"Este endereço de correio eletrónico já tem uma conta mydlink. Experimente um endereço de correio eletrónico diferente.", //mydlink_pop_01
	"Tem de aceitar os termos e condições para continuar.", //mydlink_pop_02
	"não pode ficar em branco.", //mydlink_pop_03
	"é inválido.", //mydlink_pop_04
	"Agora já pode usar o serviço mydlink com este dispositivo", //mydlink_pop_05
	"O Início de sessão falhou", //mydlink_pop_06
	"se inscrever", //_signup
	"(GMT+07:00) Almaty", //up_tz_74
	"(GMT+12:00) Magadã", //up_tz_75
	"Após o registro no mydlink for concluído, a conexão  padrão do seu roteador, PPPoE, L2TP ou PPTP será definido como Always On (sempre conectado). Caso você queira alterar a configuração, você pode  escolher manualmente a opção Dial On Demand (discar sobre demanda) como sua configuração padrão", //mydlink_pop_09
	"Cannot login to mydlink.", //mdl_errmsg_01
	"Send signin request failed.", //mdl_errmsg_02
	"Cannot send signin request.", //mdl_errmsg_03
	"Send signup request failed.", //mdl_errmsg_04
	"Cannot send signup request.", //mdl_errmsg_05
	"O campo SSID não pode estar em branco.", //SSID_EMPTY_ERROR
	"As senhas digitadas não correspondem", //YM102
	"DEVE ser especificada uma palavra-passe PPPoE", //GW_WAN_PPPoE_PASSWORD_INVALID
	"The account password must be more than six characters", //limit_pass_msg
	"Avançar", //_skip
	"Se não quiser registar-se no serviço mydlink, clique em Saltar.", //mydlink_reg_into_4
	"A guardar definições Wi-Fi", //mydlink_WiFi_save
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
