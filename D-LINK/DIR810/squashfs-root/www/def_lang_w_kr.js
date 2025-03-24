//Version=1.03b02
//Language=Korean
//Date=Tue, 30, Jul, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"취소", //_cancel
	"PC의 MAC 주소를 복사합니다.", //_clone
	"DHCP 연결(동적 IP 주소)", //_dhcpconn
	"IP 주소", //_ipaddr
	"L2TP", //_L2TP
	"L2TP 게이트웨이 IP 주소", //_L2TPgw
	"L2TP IP 주소", //_L2TPip
	"L2TP 서브넷 마스크", //_L2TPsubnet
	"언어", //_Language
	"MAC 주소", //_macaddr
	"다음", //_next
	"아니오", //_no
	"(선택 사항)", //_optional
	"비밀번호", //_password
	"PPTP 게이트웨이 IP 주소", //_PPTPgw
	"PPTP IP 주소", //_PPTPip
	"PPTP 서브넷 마스크", //_PPTPsubnet
	"이전", //_prev
	"관리자 비밀번호를 동일하게 입력하였는지 확인하시고 다시 시도하여 주십시오.", //_pwsame_admin
	"고정 IP", //_sdi_staticip
	"서브넷 마스크", //_subnet
	"사용자 이름", //_username
	"비밀번호 확인", //_verifypw
	"마법사로 구성하신 모든 변경 사항을 적용하지 않겠습니까?", //_wizquit
	"네", //_yes
	"잘못된 L2TP 서버 IP 주소", //bwn_alert_17
	"주소 모드", //bwn_AM
	"BigPond 서버", //bwn_BPS
	"TKIP 과 AES", //bws_CT_3
	"유동 IP", //carriertype_ct_0
	"공유기의 인터넷 연결 유형을 감지하고 있습니다. 잠시 기다려주십시오…", //ES_auto_detect_desc
	"공유기가 인터넷 연결 유형을 감지할 수 없습니다.", //ES_auto_detect_failed_desc
	"\"디링크 공유기 웹 관리\" 즐겨찾기에 추가하시겠습니까?", //ES_bookmark
	"다시 시도하여 주십시오.", //ES_btn_try_again
	"플러그 라우터의 뒷면에있는 포트 라벨이 인터넷에 라우터와 함께 제공된 포함 된 이더넷 케이블의 한쪽 끝하시기 바랍니다. 모뎀과 모뎀의 전원을 껐다가 다시 켭의 이더넷 포트에이 케이블의 다른 쪽 끝을 꽂습니다.", //ES_cable_lost_desc
	"2단계: Wi-Fi 보안 구성", //ES_step_wifi_security
	"3단계: 비밀번호 설정", //ES_title_s3
	"4단계: 시간대 선택", //ES_title_s4
	"5단계: 설정 저장", //ES_title_s5
	"5단계: WI-FI 설정 확인", //ES_title_s5_0
	"6단계: mydlink 등록", //ES_title_s6
	"mydlink 등록", //ES_title_s6_myd
	"1단계: 인터넷 연결 구성", //ES_wwa_title_s1
	"DHCP 클라이언트 이름 잘못되었습니다.", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"DHCP+ 비밀번호가 잘못되었습니다.", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"DHCP+ 사용자이름이 잘못되었습니다.", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"L2TP 사용자 이름이 지정되어야 합니다.", //GW_WAN_L2TP_USERNAME_INVALID
	"PPTP 비밀번호가 지정되어야 합니다.", //GW_WAN_PPTP_PASSWORD_INVALID
	"네트워크 키가 잘못되었습니다!", //IPV6_TEXT2
	"MAC 주소가 잘못되었습니다.", //KR3
	"자동(WPA or WPA2) - Personal", //KR48
	"Adelphia 파워링크", //manul_conn_01
	"ALLTEL DSL", //manul_conn_02
	"ATAT DSL Service", //manul_conn_03
	"Bell Sympatico", //manul_conn_04
	"Bellsouth", //manul_conn_05
	"Charter High-Speed", //manul_conn_06
	"컴캐스트", //manul_conn_07
	"Covad", //manul_conn_08
	"콕스 커뮤니케이션", //manul_conn_09
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
	"mydlink로 제품을 등록하면 mydlink 웹사이트를 통해 온라인으로 접근하여 장치의 관리를 포함한 mydlink 기능을 사용하실 수 있습니다.", //mydlink_tx01
	"mydlink에 장치를 등록하시겠습니까?", //mydlink_tx02
	"사용자 이름을 입력 하십시오.", //PPP_USERNAME_EMPTY
	"PPPoE 플러스 지원", //pppoe_plus_dail
	"비밀번호는 인쇄 가능한 문자만을 포함 할 수 있습니다.", //S493
	"설정 저장", //save_settings
	"설정을 저장하고 있습니다.", //save_wait
	"펌웨어 버전", //sd_FWV
	"제품 페이지", //TA2
	"하드웨어 버전", //TA3
	"(GMT-12:00) 이니위톡, 콰잘렌", //up_tz_00
	"(GMT-11:00) 미드웨이 아일랜드, 사모아", //up_tz_01
	"(GMT-10:00) 하와이", //up_tz_02
	"(GMT-09:00) 알레스카", //up_tz_03
	"(GMT-08:00) 태평양 표준시 (US/Canada), 티후아나", //up_tz_04
	"(GMT-07:00) 아리조나", //up_tz_05
	"(GMT-07:00) 산지 표준지 (미국/캐나다)", //up_tz_06
	"(GMT-06:00) 중앙 아메리카", //up_tz_07
	"(GMT-06:00) 중부 표준지 (미국/캐나다)", //up_tz_08
	"(GMT-06:00) 맥시코 시티", //up_tz_09
	"(GMT-06:00) 사스카츄완", //up_tz_10
	"(GMT-05:00) 보고타, 리마, 키토", //up_tz_11
	"(GMT-05:00) 동부 표준시 (미국/캐나다)", //up_tz_12
	"(GMT-05:00) 인디애나 (동부)", //up_tz_13
	"(GMT-04:00) 대서양 표준지 (캐나다)", //up_tz_14
	"(GMT-04:00) 카라카스, 라파스", //up_tz_15
	"(GMT-04:00) 산티아고", //up_tz_16
	"(GMT-03:30) 뉴펀들랜드", //up_tz_17
	"(GMT-03:00) 브라질리아", //up_tz_18
	"(GMT-03:00) 부에노스 아이레스, 조지타운", //up_tz_19
	"(GMT-03:00) 그린란드", //up_tz_20
	"(GMT-02:00) 중부 대서양", //up_tz_21
	"(GMT-01:00) 아조 레스", //up_tz_22
	"(GMT-01:00) 카보베르데인가.", //up_tz_23
	"(GMT) 카사블랑카, 몬로 비아", //up_tz_24
	"(GMT) 그리니치 표준시간: 더블린, 에딘버러, 리스본, 런던", //up_tz_25
	"(GMT+01:00) 암스테르담, 베를린, 베른, 로마, 스톡홀름, 비엔나", //up_tz_26
	"(GMT+01:00) 베오그라드, 브라 티슬라바, 부다페스트, 류블랴나, 프라하", //up_tz_27
	"(GMT+01:00) 브뤼셀, 코펜하겐, 마드리드, 파리 ", //up_tz_28
	"(GMT+01:00) 사라예보, 스코페, 소피자, 비너스, 자그레브", //up_tz_29
	"(GMT+01:00) 부다페스트, 비엔나, 프라하, ", //up_tz_29b
	"(GMT+01:00) 서쪽 중앙 아프리카", //up_tz_30
	"(GMT+02:00) 아테네, 이스탄불, 민스크", //up_tz_31
	"(GMT+02:00) 부카레스트", //up_tz_32
	"(GMT+02:00) 알카히라", //up_tz_33
	"(GMT+02:00) 하라레, 프리토피아", //up_tz_34
	"(GMT+02:00) 헬싱키, 리가, 탈린", //up_tz_35
	"(GMT+02:00) 예루살렘", //up_tz_36
	"(GMT+03:00) 바그다드", //up_tz_37
	"(GMT+03:00) 쿠웨이트, 리야드", //up_tz_38
	"(GMT+04:00) 모스크바, 상트 페 테르 부르크, 불고그라드", //up_tz_39
	"(GMT+03:00) 나이로비", //up_tz_40
	"(GMT+03:30) 테헤란", //up_tz_41
	"(GMT+04:00) 아부 다비, 무스캇", //up_tz_42
	"(GMT+04:00) 바쿠, 트릴리시, 예레반", //up_tz_43
	"(GMT+04:30) 카불", //up_tz_44
	"(GMT+06:00) 에카테린부르크", //up_tz_45
	"(GMT+05:00) 이슬라마바드, 카라치, 타슈켄트", //up_tz_46
	"(GMT+05:30) 캘커타, 첸나이, 뭄바이, 뉴델리", //up_tz_47
	"(GMT+05:45) 카트만두", //up_tz_48
	"(GMT+06:00) 알마티", //up_tz_49
	"(GMT+06:00) 아스타나, 다카", //up_tz_50
	"(GMT+06:00) 스리랑카", //up_tz_51
	"(GMT+06:30) 양곤", //up_tz_52
	"(GMT+07:00) 방콕, 하노이, 자카르타", //up_tz_53
	"(GMT+08:00) 크라스노야", //up_tz_54
	"(GMT+08:00) 베이징, 충칭, 홍콩, 우루무치", //up_tz_55
	"(GMT+09:00) 이루크추크, 울란바토르", //up_tz_56
	"(GMT+08:00) 쿠알라 룸프르, 싱가포르", //up_tz_57
	"(GMT+08:00) 퍼스", //up_tz_58
	"(GMT+08:00) 타이 페이", //up_tz_59
	"(GMT+09:00) 오사카, 샷포로, 도코", //up_tz_60
	"(GMT+09:00) 서울", //up_tz_61
	"(GMT+10:00) 야쿠츠크", //up_tz_62
	"(GMT+09:30) 애들레이드", //up_tz_63
	"(GMT+09:30) 다윈", //up_tz_64
	"(GMT+10:00) 브리즈번", //up_tz_65
	"(GMT+10:00) 캔버라, 멜버른, 시드니", //up_tz_66
	"(GMT+10:00) 괌, 포트 모르즈비", //up_tz_67
	"(GMT+10:00) 호바트", //up_tz_68
	"(GMT+11:00) 블라디 보스 토크", //up_tz_69
	"(GMT+11:00) 솔로몬 있나요., 뉴 칼레도니아", //up_tz_70
	"(GMT+12:00) 오클랜드, 웰링턴", //up_tz_71
	"(GMT+12:00) 피지, 캄차카 반도, 마샬 군도.", //up_tz_72
	"(GMT+13:00) 누쿠알로파, 통가", //up_tz_73
	"(GMT+07:00) 노보 시비르스크", //up_tz_74
	"(GMT+12:00) 마가단", //up_tz_75
	"(GMT-12:00) 날짜 변경선 서쪽", //up_tz_76
	"(GMT-11:00) 미드웨이 아일랜드", //up_tz_77
	"(GMT-07:00) 치와와, 라파스, 마사틀란", //up_tz_78
	"(GMT-06:00) 과달라하라, 멕시코 시티, 몬테레이", //up_tz_79
	"(GMT-05:00) 보고타, 리마, 키토, 인디애나 (동부)", //up_tz_80
	"(GMT-04:30) 카라카스", //up_tz_81
	"(GMT-04:00) 조지 타운, 라 파스", //up_tz_82
	"(GMT-03:00) 부에노스 아이레스", //up_tz_83
	"(GMT+01:00) 사라예보, 스코페, 바르샤바, 자그레브", //up_tz_84
	"(GMT+02:00) 헬싱키, 키예프, 리가, 소피아, 탈린, 빌니우스", //up_tz_85
	"(GMT+05:30) 첸나이, 콜카타, 뭄바이, 뉴델리", //up_tz_86
	"(GMT+07:00) 알마티, 노보시비르스크", //up_tz_87
	"(GMT+05:30) 스리 Jayawardenepura", //up_tz_88
	"(GMT+08:00) 울란바토르", //up_tz_89
	"(GMT+09:00) 이르쿠츠크", //up_tz_90
	"(GMT+13:00) 누쿠알로파", //up_tz_91
	"(GMT+13:00) 사모아", //up_tz_92
	"DNS 설정", //wwa_dnsset
	"게이트웨이 주소", //wwa_gw
	"기본적으로 공유기 웹 구성 페이지에 대한 관리자 접근 암호가 설정되어 있지 않습니다.새로운 네트워크 장치의 보안을 위해서는 아래 비밀번호를 설정하고 확인하십시오. 그리고 보안 문자 그래픽 인증을 사용하면 접근 권한이 없는 온라인 사용자와 해킹 소프트웨어의 접속을 차단하고 안전하게 보호 할 수 있는 기능을 제공 합니다.", //wwa_intro_s1
	"위치에 해당하는 시간대를 선택합니다. 이 정보는 시간 기반의 옵션을 구성해야합니다. 라우터가 자동으로 NTP 시간 서버에서 내부 시계를 업데이트 설정됩니다.", //wwa_intro_s2
	"아래에서 인터넷 연결 유형을 선택 하십시오:", //wwa_intro_s3
	"마법사는 공유기를 구성하고 인터넷을 연결하기 위해 단계별로 안내 할 것 입니다.", //wwa_intro_wel
	"L2TP 서버 IP 주소(게이트웨이 주소와 같을 수도 있습니다.)", //wwa_l2tp_svra
	"인터넷 연결이 자동으로 IP를 할당 받는다면 이것을 선택 합니다. 대부분의 케이블 모뎀은 이 연결 방식을 사용 합니다.", //wwa_msg_dhcp
	"인터넷 서비스 업체가 목록에 없거나 알 수 없다면, 아래 인터넷 연결 유형을 선택 하십시오.", //wwa_msg_ispnot
	"인터넷 연결시 사용자이름과 비밀번호를 넣어야 하는 PPPoE 방식을 사용하는 경우 이 옵션을 선택하십시오.<br>대부분 DSL 모뎀을 사용하는경우 이 유형을 사용합니다.", //wwa_msg_pppoe
	"PPTP 클라이언트", //wwa_msg_pptp
	"이 연결을 설정하려면 광대역 연결이 되어있고 디링크 공유기와 PC가 연결되어있는지 확인하십시오. 디링크 공유기에서 컴퓨터의 MAC 주소를 복사하는 MAC 복제 버튼을 클릭 하십시오.", //wwa_msg_set_dhcp
	"이 연결을 설정하려면 인터넷 서비스 업체에서 제공한 사용자 이름과 비밀번호가 필요 합니다. 이 정보가 없다면 인터넷 서비스 업체에 문의 하십시오.", //wwa_msg_set_pppoe
	"이 연결을 설정하려면 인터넷 서비스 업체에서 제공한 사용자 이름과 비밀번호가 필요 합니다. 또한 PPTP IP 주소도 필요합니다. 이 정보가 없다면 인터넷 서비스 업체에 문의 하십시오.", //wwa_msg_set_pptp
	"인터넷 서비스 업체에서 제공 받은 IP 주소 정보가 수동으로 구성 한다면 이 옵션을 선택 하십시오.", //wwa_msg_sipa
	"참고: 호스트 이름을 제공해야 할 수도 있습니다. 이 정보를 없거나 모르는 경우 인터넷 서비스 업체에 문의 하십시오", //wwa_note_hostname
	"주 DNS 주소", //wwa_pdns
	"PPTP 서버 IP 주소(게이트웨이와 같을 수 있습니다.)", //wwa_pptp_svraddr
	"보조 DNS 주소", //wwa_sdns
	"목록에 없거나 알 수 없습니다.", //wwa_selectisp_not
	"사용자 이름과 연결 비밀번호 설정(L2TP)", //wwa_set_l2tp_title
	"이 연결을 설정하려면 인터넷 서비스 업체가 제공하는 전체 IP 정보가 있어야 합니다. 고정 IP를 가지고 있으며, IP에 대한 정보가 없다면 인터넷 서비스 업체에 문의 하십시오.", //wwa_set_sipa_msg
	"고정 IP 주소 연결 설정", //wwa_set_sipa_title
	"BigPond 케이블 연결 설정", //wwa_title_set_bigpond
	"사용자 이름과 연결 비밀번호 설정(PPPoE)", //wwa_title_set_pppoe
	"사용자 이름과 연결 비밀번호 설정(PPTP)", //wwa_title_set_pptp
	"디링크 설치 마법사에 오신 것을 환영 합니다.", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"사용자 이름 / 연결 비밀번호 (L2TP)", //wwa_wanmode_l2tp
	"사용자 이름 / 연결 비밀번호 (PPPoE)", //wwa_wanmode_pppoe
	"사용자 이름 / 연결 비밀번호 (PPTP)", //wwa_wanmode_pptp
	"고정 IP 주소 연결", //wwa_wanmode_sipa
	"Wi-Fi 네트워크 이름을 지정 합니다.", //wwz_wwl_intro_s2_1
	"Wi-Fi 네트워크 이름(SSID)", //wwz_wwl_intro_s2_1_1
	"(32자 까지 사용)", //wwz_wwl_intro_s2_1_2
	"Wi-Fi 네트워크 비밀번호를 지정 합니다.", //wwz_wwl_intro_s2_2
	"Wi-Fi 비밀번호", //wwz_wwl_intro_s2_2_1
	"(8에서 63자 사이)", //wwz_wwl_intro_s2_2_2
	"32자리까지 사용하여 네트워크 이름을 지정 합니다.", //wwz_wwl_intro_s3_1
	"1단계: 디링크 무선 보안 설정 마법사에 오신 것을 환영 합니다.", //wwz_wwl_title_s3
	"PPTP 서버 IP 주소가 잘못되었습니다.", //YM108
	"2.GHz와 5GHz 둘 다 같은 무선 보안 비밀번호를 사용 합니다.", //wwl_SSP
	"무선 네트워크 이름과 비밀번호를 지정 합니다.", //wwz_wwl_intro_s0
	"%s의 첫 번째 주소는 정수여야 합니다.", //MSG002
	"%s의 두 번째 주소는 정수여야 합니다.", //MSG003
	"%s의 세 번째 주소는 정수여야 합니다.", //MSG004
	"%s의 네 번째 주소는 정수여야 합니다.", //MSG005
	"%s의 주소가 잘못되었습니다.", //MSG006
	"%s은 0 일 수 없습니다.", //MSG007
	"%s에 입력된 포트가 잘못되었습니다.", //MSG008
	"%s에 입력된 보안키가 잘못되었습니다.", //MSG009
	"%s는 loopback IP 또는 멀티캐스트 IP(127.x.x.x, 224.x.x.x ~ 239.x.x.x)의 등록을 허용 할 수 없습니다.", //MSG010
	"%s에 다른 값을 입력하여 주십시오.", //MSG012
	"%s의 값은 숫자여야 합니다.", //MSG013
	"%s 범위는 %1n~%2n 입니다.", //MSG014
	"%s의 값은 짝수여야 합니다.", //MSG015
	"키가 잘못되었습니다. 키는 5자 또는 10자 사이의 16진수여야 합니다. 입력된", //MSG016
	"키가 잘못되었습니다. 키는 13자 또는 26자의 16진수여야 합니다. 입력된 ", //MSG017
	"%s의 첫 번째 주소는 16진수여야 합니다.", //MSG018
	"%s의 두 번째 주소는 16진수여야 합니다.", //MSG019
	"%s의 세 번째 주소는 16진수여야 합니다.", //MSG020
	"%s의 네 번째 주소는 16진수여야 합니다.", //MSG021
	"%s의 다섯 번째 주소는 16진수여야 합니다.", //MSG022
	"%s의 여섯 번째 주소는 16진수여야 합니다.", //MSG023
	"%s의 일곱 번째 주소는 16진수여야 합니다.", //MSG024
	"%s의 여덟 번째 주소는 16진수여야 합니다.", //MSG025
	"%s는 첫 번째 범위 사이여야 합니다.", //MSG026
	"%s는 두 번째 범위 사이여야 합니다.", //MSG027
	"%s는 세 번째 범위 사이여야 합니다.", //MSG028
	"%s는 네 번째 범위 사이여야 합니다.", //MSG029
	"%s는 다섯 번째 범위 사이여야 합니다.", //MSG030
	"%s는 여섯 번째 범위 사이여야 합니다.", //MSG031
	"%s는 일곱 번째 범위 사이여야 합니다.", //MSG032
	"%s는 여덟 번째 범위 사이여야 합니다.", //MSG033
	"%s는 loopback IP의 등록을 허용 할 수 없습니다.", //MSG034
	"%s는 멀티캐스트 IP 등록을 허용 할 수 없습니다.", //MSG035
	"메트릭이 잘못되었습니다.", //MSG043
	"메트릭 값은 1~16 사이여야 합니다.", //ar_alert_3
	"넷마스크가 잘못되었습니다.", //ar_alert_5
	"키", //TEXT042_1
	"잘못되었습니다. 사용 가능한 문자는 0~9, A~F 또는 a~f 입니다.", //TEXT042_2
	"참고: 호스트 이름을 제공해야 할 수도 있습니다. 이 정보를 없거나 모르는 경우 인터넷 서비스 업체에 문의 하십시오", //wwa_note_svcn
	"L2TP 클라이언트", //wwa_msg_l2tp
	"이 연결을 설정하려면 인터넷 서비스 업체에서 제공한 사용자 이름과 비밀번호가 필요 합니다. 또한 L2TP IP 주소도 필요합니다. 이 정보가 없다면 인터넷 서비스 업체에 문의 하십시오.", //wwa_set_l2tp_msg
	"이 연결을 설정하려면 인터넷 서비스 업체에서 제공한 사용자 이름과 비밀번호가 필요 합니다. 또한 BigPond 서버 IP 주소도 필요합니다. 이 정보가 없다면 인터넷 서비스 업체에 문의 하십시오.", //wwa_msg_set_bigpond
	"호스트 이름", //_hostname
	"2.4GHz 주파수 대역", //GW_WLAN_RADIO_0_NAME
	"5GHz 주파수 대역", //GW_WLAN_RADIO_1_NAME
	"아래는 무선 보안 설정에 대한 세부 요약 입니다. 이 페이지를 인쇄하거나 종이에 정보를 적어두면 무선 장치를 올바르게 구성 할 수 있습니다.", //wwl_intro_end
	"잠시만 기다려 주십시오…", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"연결", //_connect
	"인터넷 연결 설정을 통해 안내 합니다.", //ES_btn_guide_me
	"그래픽 인증 활성화", //_graph_auth
	"D-LINK CORPORATION, INC | 무선 라우터 | HOME", //TEXT000
	"L2TP 비밀번호를 지정해야 합니다.", //GW_WAN_L2TP_PASSWORD_INVALID
	"인터넷 연결이 검색되지 않았습니다. 마법사를 다시 시작하시겠습니까?", //mydlink_tx03
	"관리자 비밀번호는 공란일 수 없습니다.", //mydlink_tx04
	"WAN 연결을 확인하십시오.", //mydlink_tx05
	"초 남았습니다.", //sec_left
	"재시도", //_retry
	"mydlink 계정을 가지고 있습니까?", //mydlink_tx06
	"네, 계정이 있습니다.", //mydlink_tx07
	"아니요, 새 mydlink 계정을 등록하여 로그인 하겠습니다.", //mydlink_tx08
	"E-mail 주소 (계정 이름 )", //mydlink_tx09
	"등록을 완료하려면 옵션을 실행하시기 바랍니다.", //mydlink_tx10
	"비밀번호 확인", //chk_pass
	"성", //Lname
	"이름", //Fname
	"나는 mydlink 이용 약관에 동의합니다.", //mydlink_tx12
	"mydlink 등록을 완료 하려면 등록 확인 메일을 확인하시기 바랍니다.", //mydlink_tx13_1
	"로그인 주소를 확인 후 로그인 버튼을 클릭하십시오.", //mydlink_tx13_2
	"로그인", //_login
	"완료", //_ok
	"저장", //_save
	"비밀번호를 동일하게 하여 다시 시도하여 주십시오.", //_pwsame
	"기능을 사용하려면  <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> and the mydlink Lite app, you will need an account with <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_1
	"이미 계정이 있다면 <strong>네, mydlink 계정이 있습니다</strong>를 선택하고 다음을 클릭하여 <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>에서 공유기를 등록하십시오.", //mydlink_reg_into_2
	"계정이 없는 경우 <strong>아니오, 새로운 mydlink 계정을 등록하고 로그인 하겠습니다.</strong>를 선택하고 다음을 클릭하여 계정을 생성 합니다.", //mydlink_reg_into_3
	"mydlink에 등록하지 않으려면, 취소를 클릭하여 주십시오.", //mydlink_reg_into_4_a
	"이 메일 주소가 이미 mydlink 계정에 등록되어 있습니다. 다른 이메일 주소를 입력하여 주십시오.", //mydlink_pop_01
	"이용 약관에 동의해야 합니다.", //mydlink_pop_02
	"비워 둘 수 없습니다.", //mydlink_pop_03
	"유효하지 않습니다.", //mydlink_pop_04
	"이제 장치와 mydlink 서비스를 이용 할 수 있습니다.", //mydlink_pop_05
	"로그인 실패", //mydlink_pop_06
	"가입", //_signup
	"mydlink 등록이 완료되면, 공유기의 기본 연결 PPPoE, L2TP, PPTP이 항상 설정됩니다. ISP에서 비용이 발생되어도 사용을 한다면, 수동으로 기본 설정을 다이얼 자동 요구를 선택할 수 있습니다.", //mydlink_pop_09
	"mydlink하려면 로그인 없습니다.", //mdl_errmsg_01
	"에 로그 요청을 보내기가 실패했습니다.", //mdl_errmsg_02
	"에 로그 요청을 보낼 수 없습니다.", //mdl_errmsg_03
	"요청을 가입 보내기가 실패했습니다.", //mdl_errmsg_04
	"가입 요청을 보낼 수 없습니다.", //mdl_errmsg_05
	"SSID 항목은 반드시 입력하십시오.", //SSID_EMPTY_ERROR
	"입력하신 비밀번호가 맞지 않습니다.", //YM102
	"PPPoE 비밀번호가 지정되어야 합니다.", //GW_WAN_PPPoE_PASSWORD_INVALID
	"계정 비밀 번호는 6 자 이상이어야합니다", //limit_pass_msg
	"건너뛰기", //_skip
	"당신 mydlink 서비스에 가입하지 않으려면 건너뛰기를 클릭하십시오.", //mydlink_reg_into_4
	"와이파이 설정을 저장", //mydlink_WiFi_save
	"러시아 PPTP (듀얼 액세스)", //rus_wan_pptp
	"러시아 PPTP (듀얼 액세스) 인터넷 연결 유형", //rus_wan_pptp_01
	"러시아 L2TP (듀얼 액세스)", //rus_wan_l2tp
	"러시아 L2TP (듀얼 액세스) 인터넷 연결 유형", //rus_wan_l2tp_01
	"러시아 PPPoE를 (듀얼 액세스)", //rus_wan_pppoe
	"러시아 PPPoE를 (듀얼 액세스) 인터넷 연결 유형", //rus_wan_pppoe_02
	"물리적 설정 완", //rus_wan_pppoe_03
	"이 장치는 원격 mydlink.com 웹 사이트를 통해, 또는 mydlink 모바일 응용 프로그램을 통해 네트워크를 모니터링하고 관리 할 수 ​​있습니다 mydlink 기반입니다.", //_wz_mydlink_into_1
	"당신은 네트워크 속도를 확인 연결하는 사용자를 확인할, 장치 검색 기록을 볼 수 있으며, 신규 사용자 나 침입 시도에 대한 알림을 수신 할 수 있습니다.", //_wz_mydlink_into_2
	"당신은 기존 mydlink 계정으로이 장치를 등록 할 수 있습니다. 한을 가지고 있지 않은 경우, 지금 하나를 만들 수 있습니다.", //_wz_mydlink_into_3
	"확인 지침을 이메일에 대한 사서함을 확인하시기 바랍니다.", //_wz_mydlink_email_1
	"라우터는 인터넷 연결을 확인되며, 기다려주십시오.", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"메트릭 값은 1~15 사이여야 합니다.", //ar_alert_3a
	"서버 IP 주소", //SERVER_IP_DESC
	"%s 게이트웨이 IP 어드레스 %s WAN 서브넷 안에 있어야 함.", //TEXT043
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