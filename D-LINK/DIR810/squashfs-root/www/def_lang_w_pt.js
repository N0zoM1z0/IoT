//Version=1.03b02
//Language=Portuguese
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"Cancelar", //_cancel
	"Copiar MAC address do seu PC", //_clone
	"Conexão DHCP (Endereço IP Dinâmico)", //_dhcpconn
	"Endereço IP", //_ipaddr
	"L2TP", //_L2TP
	"L2TP Gateway IP Address", //_L2TPgw
	"L2TP Endereço IP", //_L2TPip
	"L2TP Máscara de sub-rede", //_L2TPsubnet
	"Idioma", //_Language
	"Endereço MAC", //_macaddr
	"Próximo", //_next
	"Não", //_no
	"(opcional)", //_optional
	"Senha", //_password
	"Endereço IP de Gateway PPTP", //_PPTPgw
	"Endereço IP PPTP ", //_PPTPip
	"PPTP Máscara", //_PPTPsubnet
	"Ant", //_prev
	"As duas senhas de administrador devem ser iguais. Tente novamente", //_pwsame_admin
	"IP estático", //_sdi_staticip
	"Máscara de sub-rede", //_subnet
	"Nome de usuário", //_username
	"Confirme sua senha", //_verifypw
	"Você deseja abandonar todas as alterações feitas a este assistente?", //_wizquit
	"sim", //_yes
	"Endereço IP do Servidor L2TP inválido", //bwn_alert_17
	"Modo Endereço", //bwn_AM
	"BigPond Servidor", //bwn_BPS
	"TKIP e AES", //bws_CT_3
	"IP dinâmico", //carriertype_ct_0
	"O roteador está detectando o tipo de conexão de sua Internet, por favor aguarde …", //ES_auto_detect_desc
	"Seu roteador não está detectando a conexão com Internet.", //ES_auto_detect_failed_desc
	"Você deseja marcar \"Gerenciamento Web Roteador D-Link\" como Favorito", //ES_bookmark
	"Tente novamente", //ES_btn_try_again
	"Ligue uma extremidade do cabo Ethernet fornecido com o seu router na porta INTERNET na parte traseira do router. Ligue a outra extremidade deste cabo à porta Ethernet do seu modem e ligue o modem.", //ES_cable_lost_desc
	"Passo 2: Configure a sua Segurança Wi-Fi", //ES_step_wifi_security
	"Passo 3: defina a sua Palavra-passe", //ES_title_s3
	"Passo 4: selecione o seu Fuso Horário", //ES_title_s4
	"Passo 5: Guardar Definições", //ES_title_s5
	"Passo 5: Confirmar Definições WI-FI", //ES_title_s5_0
	"Passo 6: Registo no MYDLINK", //ES_title_s6
	"registo no mydlink", //ES_title_s6_myd
	"Passo 1: Configure a sua Ligação à Internet", //ES_wwa_title_s1
	"Nome do cliente DHCP Inválido ", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"Palavra-passe de DHCP+ inválida", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"Nome de utilizador de DHCP+ inválido", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"Um nome de usuário L2TP deve ser especificado", //GW_WAN_L2TP_USERNAME_INVALID
	"A senha PPTP DEVE ser especificada", //GW_WAN_PPTP_PASSWORD_INVALID
	"Chave de rede inválida!", //IPV6_TEXT2
	"Endereço MAC inválido", //KR3
	"Auto (WPA ou WPA2) - Pessoal", //KR48
	"Adelphia Power Link", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"ATAT DSL Serviço", //manul_conn_03
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
	"Shaw ", //manul_conn_18
	"Speakeasy", //manul_conn_19
	"Sprint FastConnect", //manul_conn_20
	"Telus", //manul_conn_21
	"Time Warner Cable", //manul_conn_22
	"EUA West / Qwest", //manul_conn_23
	"Verizon DSL on-line", //manul_conn_24
	"Comunicação XO", //manul_conn_25
	"Registando o seu produto em mydlink permitir-lhe-á utilizar as suas funções com ativação mydlink, incluindo acesso e gestão on-line do seu dispositivo através do serviço mydlink.", //mydlink_tx01
	"Gostaria de registar o seu dispositivo em mydlink?", //mydlink_tx02
	"Por favor, insira o nome de usuário", //PPP_USERNAME_EMPTY
	"PPPoE Plus Supported", //pppoe_plus_dail
	"Senha só pode conter caracteres passíveis de impressão", //S493
	"A GUARDAR DEFINIÇÕES", //save_settings
	"As suas definições estão a ser guardadas.", //save_wait
	"Versão da firmware", //sd_FWV
	"Página do produto", //TA2
	"Versão de Hardware", //TA3
	"(GMT-12:00) Eniwetok, Kwajalein", //up_tz_00
	"(GMT-11:00) Midway Island, Samoa", //up_tz_01
	"(GMT-10:00) Havaí", //up_tz_02
	"(GMT-09:00) Alasca", //up_tz_03
	"(GMT-08:00) Hora do Pacífico (EUA / Canadá), Tijuana", //up_tz_04
	"(GMT-07:00) Arizona", //up_tz_05
	"(GMT-07:00) Hora das Montanhas (EUA / Canadá)", //up_tz_06
	"(GMT-06:00) América Central", //up_tz_07
	"(GMT-06:00) Hora Central (EUA / Canadá)", //up_tz_08
	"(GMT-06:00) Cidade do México", //up_tz_09
	"(GMT-06:00) Saskatchewan", //up_tz_10
	"(GMT-05:00) Bogotá, Lima, Quito", //up_tz_11
	"(GMT-05:00) Hora do Leste (EUA / Canadá)", //up_tz_12
	"(GMT-05:00) Indiana (Leste)", //up_tz_13
	"(GMT-04:00) Hora do Atlântico (Canadá)", //up_tz_14
	"(GMT-04:00) Caracas, La Paz", //up_tz_15
	"(GMT-04:00) Santiago", //up_tz_16
	"(GMT-03:30) Newfoundland", //up_tz_17
	"(GMT-03:00) Brasilia", //up_tz_18
	"(GMT-03:00) Buenos Aires, Georgetown", //up_tz_19
	"(GMT-03:00) Groenlândia", //up_tz_20
	"(GMT-02:00) Mid-Atlantic", //up_tz_21
	"(GMT-01:00) Açores", //up_tz_22
	"(GMT-01:00) Cabo Verde é.", //up_tz_23
	"(GMT) Casablanca, Monrovia", //up_tz_24
	"(GMT) Greenwich: Dublin, Edimburgo, Lisboa, Londres", //up_tz_25
	"(GMT+01:00) Amsterdã, Berlim, Berna, Roma, Estocolmo, Viena", //up_tz_26
	"(GMT+01:00) Belgrado, Bratislava, Budapeste, Ljubljana, Praga", //up_tz_27
	"(GMT+01:00) Bruxelas, Copenhagen, Madrid, Paris", //up_tz_28
	"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb", //up_tz_29
	"(GMT+01:00) Budapeste, Viena, Praga, Varsóvia", //up_tz_29b
	"(GMT+01:00) Centro-Oeste da África", //up_tz_30
	"(GMT+02:00) Atenas, Istambul, Minsk", //up_tz_31
	"(GMT+02:00) Bucareste", //up_tz_32
	"(GMT+02:00) Cairo", //up_tz_33
	"(GMT+02:00) Harare, Pretória", //up_tz_34
	"(GMT+02:00) Helsínquia, Riga, Tallinn", //up_tz_35
	"(GMT+02:00) Jerusalém", //up_tz_36
	"(GMT+03:00) Bagdá", //up_tz_37
	"(GMT+03:00) Kuwait, Riyadh", //up_tz_38
	"(GMT+04:00) Moscou, São Petersburgo, Volgograd", //up_tz_39
	"(GMT+03:00) Nairobi", //up_tz_40
	"(GMT+03:30) Teerã", //up_tz_41
	"(GMT+04:00) Abu Dhabi, Muscat", //up_tz_42
	"(GMT+04:00) Baku, Tbilisi, Yerevan", //up_tz_43
	"(GMT+04:30) Cabul", //up_tz_44
	"(GMT+06:00) Ekaterinburg", //up_tz_45
	"(GMT+05:00) Islamabad, Karachi, Tashkent", //up_tz_46
	"(GMT+05:30) Calcutá, Chennai, Mumbai, Nova Deli", //up_tz_47
	"(GMT+05:45) Kathmandu", //up_tz_48
	"(GMT+06:00) Almaty", //up_tz_49
	"(GMT+06:00) Astana, Dhaka", //up_tz_50
	"(GMT+06:00) Sri Jayawardenepura", //up_tz_51
	"(GMT+06:30) Rangoon", //up_tz_52
	"(GMT+07:00) Bangkok, Hanoi, Jacarta", //up_tz_53
	"(GMT+08:00) Krasnoyarsk", //up_tz_54
	"(GMT+08:00) Pequim, Chongqing, Hong Kong, Urumqi", //up_tz_55
	"(GMT+09:00) Irkutsk", //up_tz_56
	"(GMT+08:00) Kuala Lumpur, Cingapura", //up_tz_57
	"(GMT+08:00) Perth", //up_tz_58
	"(GMT+08:00) Taipei", //up_tz_59
	"(GMT+09:00) Osaka, Sapporo, Tóquio", //up_tz_60
	"(GMT+09:00) Seul", //up_tz_61
	"(GMT+10:00) Yakutsk", //up_tz_62
	"(GMT+09:30) Adelaide", //up_tz_63
	"(GMT+09:30) Darwin", //up_tz_64
	"(GMT+10:00) Brisbane", //up_tz_65
	"(GMT+10:00) Canberra, Melbourne, Sydney", //up_tz_66
	"(GMT+10:00) Guam, Port Moresby", //up_tz_67
	"(GMT+10:00) Hobart", //up_tz_68
	"(GMT+11:00) Vladivostok", //up_tz_69
	"(GMT+11:00) Ilhas Salomão, New Caledonia", //up_tz_70
	"(GMT+12:00) Auckland, Wellington", //up_tz_71
	"(GMT+12:00) Fiji, Kamchatka, Marshall É.", //up_tz_72
	"(GMT+13:00) Nuku'alofa, Tonga", //up_tz_73
	"(GMT+07:00) Novosibirsk", //up_tz_74
	"(GMT+12:00) Magadan", //up_tz_75
	"(GMT-12:00) International Date Line West", //up_tz_76
	"(GMT-11:00) Midway Island", //up_tz_77
	"(GMT-07:00) Chihuahua, La Paz, Mazatlan", //up_tz_78
	"(GMT-06:00) Guadalajara, Cidade do México, Monterrey", //up_tz_79
	"(GMT-05:00) Bogotá, Lima, Quito, Indiana (Este)", //up_tz_80
	"(GMT-04:30) Caracas", //up_tz_81
	"(GMT-04:00) Georgetown, La Paz", //up_tz_82
	"(GMT-03:00) Buenos Aires", //up_tz_83
	"(GMT+01:00) Sarajevo, Skopje, Varsóvia, Zagreb", //up_tz_84
	"(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius", //up_tz_85
	"(GMT+05:30) Chennai, Kolkata, Mumbai, Nova Delhi", //up_tz_86
	"(GMT+07:00) Almaty, Novosibirsk", //up_tz_87
	"(GMT+05:30) Sri Jayawardenepura", //up_tz_88
	"(GMT+08:00) Ulaan Bataar", //up_tz_89
	"(GMT+09:00) Irkutsk", //up_tz_90
	"(GMT+13:00) Nuku'alofa", //up_tz_91
	"(GMT+13:00) Samoa", //up_tz_92
	"Configurações de DNS", //wwa_dnsset
	"Endereço do Gateway", //wwa_gw
	"Por padrão, seu novo roteador D-Link não tem uma senha configurada para acesso de administrador às páginas de configuração baseadas em Web. Para proteger o seu novo dispositivo de rede, por favor, defina e verifique uma senha abaixo, permitindo a autenticação gráfica CAPTCHA, que fornece proteção de segurança adicional para evitar que usuários online não autorizados e software de hackers acessem as configurações de rede.", //wwa_intro_s1
	"Selecione o fuso horário adequado para a sua localização. Esta informação é necessária para configurar as opções baseadas na hora. O seu router será definido para realizar atualizações do relógio interno automaticamente a partir de um servidor de horário NTP.", //wwa_intro_s2
	"Selecione o seu tipo de ligação à Internet:", //wwa_intro_s3
	"Este assistente irá guiá-lo através de um processo passo-a-passo para configurar seu roteador D-Link novo e se conectar à Internet.", //wwa_intro_wel
	"L2TP endereço IP do servidor (pode ser o mesmo do gateway)", //wwa_l2tp_svra
	"Escolha esta opção se sua conexão com a Internet fornece automaticamente um endereço IP. A maioria dos Cable Modems usam esse tipo de conexão.", //wwa_msg_dhcp
	"Se o seu provedor de serviços de Internet não foi listado ou você não sabe quem é, selecione o tipo de conexão Internet abaixo:", //wwa_msg_ispnot
	"Escolha esta opção se a sua conexão Internet requer obtenção de um nome de usuário e senha on-line. A maioria dos modems DSL usam esse tipo de conexão de conexão.", //wwa_msg_pppoe
	"Cliente PPTP.", //wwa_msg_pptp
	"Para configurar essa conexão, certifique-se que você está conectado ao roteador D-Link com o PC que estava originalmente ligado à sua conexão de banda larga. Se estiver, então clique no botão Clone MAC para copiar endereço MAC do seu computador para o roteador D-Link.", //wwa_msg_set_dhcp
	"Para configurar esta conexão você precisa ter um nome de usuário e senha do seu provedor de serviços de Internet. Se você não tiver essas informações, contacte o seu ISP.", //wwa_msg_set_pppoe
	"Para configurar esta conexão você precisa ter um nome de usuário e senha do seu provedor de serviços de Internet. Você também precisa endereço PPTP de IP. Se você não tiver essas informações, contacte o seu ISP.", //wwa_msg_set_pptp
	"Escolha esta opção se o seu Provedor de Internet (ISP) fornece informações de endereço IP que necessita ser configurado manualmente.", //wwa_msg_sipa
	"Nota: Você também pode precisar fornecer um nome de Host. Se você não tem ou conhece essas informações, contacte o seu ISP.", //wwa_note_hostname
	"Endereço DNS primário", //wwa_pdns
	"Endereço IP do servidor PPTP (pode ser o mesmo que gateway)", //wwa_pptp_svraddr
	"Endereço DNS Secundário", //wwa_sdns
	"Não listados ou não sabe", //wwa_selectisp_not
	"Definir Nome de Usuário e Senha (L2TP)", //wwa_set_l2tp_title
	"Para configurar esta conexão você precisará ter uma lista completa de informações IP fornecido pelo seu provedor de serviços de Internet. Se você tiver uma conexão IP estático e não tiver essas informações, contacte o seu ISP.", //wwa_set_sipa_msg
	"Conjunto de ligação no Endereço com IP Estático ", //wwa_set_sipa_title
	"Conjunto de conexão de cabo BigPond ", //wwa_title_set_bigpond
	"Definir nome de usuário e senha (PPPoE)", //wwa_title_set_pppoe
	"Defina a Ligação com Nome de Utilizador e Palavra-passe (PPTP)", //wwa_title_set_pptp
	"Bem-vindo ao Assistente de configuração da D-Link", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"Nome de Usuário / Senha de conexão (L2TP)", //wwa_wanmode_l2tp
	"Nome de Usuário / Senha de conexão (PPPoE)", //wwa_wanmode_pppoe
	"Nome de Usuário / Senha de conexão (PPTP)", //wwa_wanmode_pptp
	"Conexão Endereço IP estático", //wwa_wanmode_sipa
	"Nome da rede Wi-Fi", //wwz_wwl_intro_s2_1
	"Nome da rede Wi-Fi (SSID)", //wwz_wwl_intro_s2_1_1
	"(Utilize até 32 caracteres)", //wwz_wwl_intro_s2_1_2
	"Senha da rede Wi-Fi", //wwz_wwl_intro_s2_2
	"Wi-Fi senha", //wwz_wwl_intro_s2_2_1
	"(entre 8 e 63 caracteres)", //wwz_wwl_intro_s2_2_2
	"Dê a sua rede um nome, usando até 32 caracteres.", //wwz_wwl_intro_s3_1
	"Passo 1 Bem-vindo ÀS CONFIGURAÇÕES DE SEGURANÇA DA REDE SEM FIO D-LINK", //wwz_wwl_title_s3
	"endereço IP de servidor PPTP inválido", //YM108
	"Use a Senha de segurança sem fio na mesma faixa de ambos os 2,4 GHz e 5GHz.", //wwl_SSP
	"Nome e senha da rede Wi-Fi", //wwz_wwl_intro_s0
	"O primeiro endereço %s deve ser um inteiro.", //MSG002
	"O segundo endereço de %s deve ser um inteiro.", //MSG003
	"O terceiro endereço de %s deve ser um inteiro.", //MSG004
	"O quarto endereço de %s deve ser um inteiro.", //MSG005
	"O %s é um endereço inválido.", //MSG006
	"O%s não pode ser zero.", //MSG007
	"A porta%s digitado é inválido.", //MSG008
	"O %s segredo digitado é inválido", //MSG009
	"O%s não pode permitir a entrada de loopback IP ou multicast IP (127.xxx, 224.xxx239.xxx ~).", //MSG010
	"Por favor insira outro valor %s.", //MSG012
	"O valor de%s deve ser numérico!", //MSG013
	"O intervalo de%s é%1n ~ %2n.", //MSG014
	"O valor de %s deve ser um número par.", //MSG015
	"A Chave é inválida. A chave deve ser a 5 ou 10 número hexadecimal personagem.você inseriu", //MSG016
	"A Chave é inválida. A chave deve ser um número 13 ou 26 caracteres hexadecimais.você inseriu", //MSG017
	"O 1º endereço de %s deve ser hexadecimal.", //MSG018
	"O 2º endereço de %s deve ser hexadecimal.", //MSG019
	"O 3º endereço de %s deve ser hexadecimal.", //MSG020
	"O 4º endereço de %s deve ser hexadecimal.", //MSG021
	"O 5º endereço de %s deve ser um hexadecimal.", //MSG022
	"O 6º endereço de %s deve ser hexadecimal.", //MSG023
	"O 7º endereço de %s deve ser hexadecimal.", //MSG024
	"O 8º endereço de %s deve ser hexadecimal.", //MSG025
	"O 1º intervalo de %s deve estar entre", //MSG026
	"O 2º intervalo de %s deve estar entre", //MSG027
	"O 3º intervalo de %s deve estar entre", //MSG028
	"O 4º intervalo de %s deve estar entre", //MSG029
	"O 5º intervalo de %s deve estar entre", //MSG030
	"O 6º intervalo de %s deve estar entre", //MSG031
	"O 7º intervalo de %s deve estar entre", //MSG032
	"O intervalo de %s deve estar entre", //MSG033
	"O%s não pode permitir a entrada de IP loopback (:: 1).", //MSG034
	"O%s não pode permitir a entrada de IP multicast (FFxx: 0:0:0:0:0:0:2 ou ffxx: 0:0:0:0:0:0:2.", //MSG035
	"Métrica inválida", //MSG043
	"Valor da métrica deve estar entre (1 .. 16).", //ar_alert_3
	"Netmask inválida.", //ar_alert_5
	"a Chave", //TEXT042_1
	" está errada, os carateres são 0~9, A~F, ou a~f.", //TEXT042_2
	"Nota: Você também pode precisar fornecer um nome de serviço. Se você não tem ou conhece essas informações, contacte o seu ISP.", //wwa_note_svcn
	"Cliente L2TP.", //wwa_msg_l2tp
	"Para configurar esta conexão você precisa ter um nome de usuário e senha do seu provedor de serviços de Internet. Você também precisa de endereço L2TP IP. Se você não tiver essas informações, contacte o seu ISP.", //wwa_set_l2tp_msg
	"Para configurar esta ligação terá de ter um Nome de Utilizador e Palavra-passe do seu Fornecedor de Serviços de Internet. Precisa também de um endereço IP Servidor BigPond. Se não tiver estas informações, por favor contacte o seu ISP (fornecedor de serviç", //wwa_msg_set_bigpond
	"Nome do host", //_hostname
	"Banda 2.4GHz", //GW_WLAN_RADIO_0_NAME
	"Banda 5GHz", //GW_WLAN_RADIO_1_NAME
	"Abaixo está um resumo detalhado das configurações Wi-Fi de segurança. Por favor,imprima esta página para fora, ou gravar as informações em um pedaço de papel, de modo que você pode configurar as configurações corretas em seu Wi-Fi dispositivos.", //wwl_intro_end
	"Por favor aguarde ...", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"Conectar", //_connect
	"Orientar-me nas definições da ligação à Internet", //ES_btn_guide_me
	"Habilitar autenticação gráfica", //_graph_auth
	"D-LINK CORPORATION, INC | ROUTER WIRELESS | HOME", //TEXT000
	"A senha L2TP deve ser especificada", //GW_WAN_L2TP_PASSWORD_INVALID
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
	"Confirme sua senha", //chk_pass
	"Último nome", //Lname
	"Primeiro Nome", //Fname
	"Aceito os termos e condições de mydlink.", //mydlink_tx12
	"Para concluir o seu registo em mydlink, verifique se na sua pasta Recebidas se encontra uma mensagem de correio eletrónico com instruções de confirmação.", //mydlink_tx13_1
	" Após confirmar o seu endereço de correio eletrónico, clique no botão Login (Iniciar sessão).", //mydlink_tx13_2
	"Acesso", //_login
	"OK", //_ok
	"Salvar", //_save
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
	"Inscrever", //_signup
	"Após o registro no mydlink for concluído, a conexão  padrão do seu roteador, PPPoE, L2TP ou PPTP será definido como Always On (sempre conectado). Caso você queira alterar a configuração, você pode  escolher manualmente a opção Dial On Demand (discar sobre demanda) como sua configuração padrão", //mydlink_pop_09
	"Impossível iniciar sessão em mydlink.", //mdl_errmsg_01
	"Envio de pedido de início de sessão falhou.", //mdl_errmsg_02
	"Impossível enviar pedido de início de sessão.", //mdl_errmsg_03
	"Envio de pedido de registo falhou.", //mdl_errmsg_04
	"Impossível enviar pedido de registo.", //mdl_errmsg_05
	"O campo SSID não pode estar em branco", //SSID_EMPTY_ERROR
	"As senhas digitadas não correspondem", //YM102
	"A senha PPPoE DEVE ser especificada", //GW_WAN_PPPoE_PASSWORD_INVALID
	"A palavra-passe da conta deve ter mais de seis caracteres", //limit_pass_msg
	"Avançar", //_skip
	"Se não quiser registar-se no serviço mydlink, clique em Saltar.", //mydlink_reg_into_4
	"A guardar definições Wi-Fi", //mydlink_WiFi_save
	"PPTP Rússia (Acesso DUAL)", //rus_wan_pptp
	"Tipo de ligação à internet PPTP Rússia (Acesso Dual)", //rus_wan_pptp_01
	"L2TP Rússia (Acesso Dual)", //rus_wan_l2tp
	"Tipo de ligação à internet L2TP Rússia (Acesso Dual)", //rus_wan_l2tp_01
	"PPPoE Rússia (Acesso Dual)", //rus_wan_pppoe
	"Tipo de ligação à internet PPPoE Rússia (Acesso Dual)", //rus_wan_pppoe_02
	"Definições Físicas Wan", //rus_wan_pppoe_03
	"Este dispositivo tem suporte mydlink, o que lhe permite controlar e gerir remotamente a sua rede através do sítio da Internet mydlink.com ou através da aplicação móvel mydlink.", //_wz_mydlink_into_1
	"Poderá verificar as velocidades da sua rede, ver quem está ligado, ver o histórico do explorador do dispositivo e receber notificações sobre novos utilizadores ou tentativas de intrusão.", //_wz_mydlink_into_2
	"Pode registar este dispositivo com a sua conta mydlink existente. Se não tiver, pode criar uma agora.", //_wz_mydlink_into_3
	"Deverá receber na sua caixa de entrada um e-mail com as instruções de confirmação.", //_wz_mydlink_email_1
	"O router está a verificar a conectividade da Internet. Aguarde.", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"Valor da métrica deve estar entre (1 .. 15).", //ar_alert_3a
	"Endereço IP do Servidor", //SERVER_IP_DESC
	"%s Endereço IP Gateway %s deve estar na subrede WAN.", //TEXT043
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