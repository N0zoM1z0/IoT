//Version=1.00b01
//Language=TAIWANESE
//Date=Fri, 02, Aug, 2013
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"取消", //_cancel
	"複製電腦端的MAC位址", //_clone
	"DHCP 連線 (動態IP位址)", //_dhcpconn
	"IP 位址", //_ipaddr
	"L2TP", //_L2TP
	"L2TP通訊閘IP位址", //_L2TPgw
	"L2TP IP位址", //_L2TPip
	"L2TP 子網路遮罩", //_L2TPsubnet
	"語言", //_Language
	"MAC 位址", //_macaddr
	"下一步", //_next
	"否", //_no
	"(非必要)", //_optional
	"密碼", //_password
	"PPTP 通訊閘IP 位址", //_PPTPgw
	"PPTP IP位址", //_PPTPip
	"PPTP 子網路遮罩", //_PPTPsubnet
	"前一個", //_prev
	"請確認管理者的兩組密碼相同後再試一次", //_pwsame_admin
	"固定IP", //_sdi_staticip
	"子網路遮罩", //_subnet
	"使用者名稱", //_username
	"確認密碼", //_verifypw
	"您想要放棄對此精靈所做的所有變更？", //_wizquit
	"是", //_yes
	"無效L2TP伺服器IP位址", //bwn_alert_17
	"位址模式", //bwn_AM
	"BigPond 伺服器", //bwn_BPS
	"TKIP 及 AES", //bws_CT_3
	"動態 IP", //carriertype_ct_0
	"路由器正在偵測網際網路連線類型，請稍候…", //ES_auto_detect_desc
	"路由器無法偵測到您的網際網路連線類別，請與您的寬頻服務業者(ISP)確認。", //ES_auto_detect_failed_desc
	"您想在「D-Link路由器網路管理」上標示書簽嗎？", //ES_bookmark
	"請再試一次", //ES_btn_try_again
	"請將網路線的一端插入路由器後方標示為「INTERNET」的網路埠，另一端插入數據機或位於牆壁上的網路埠。", //ES_cable_lost_desc
	"步驟2: 設定您的 Wi-Fi 安全", //ES_step_wifi_security
	"步驟3: 設定您的密碼", //ES_title_s3
	"步驟4: 選取您的時區", //ES_title_s4
	"步驟5: 儲存設定", //ES_title_s5
	"步驟5: 確認 Wi-Fi 設定", //ES_title_s5_0
	"步驟6: mydlink雲端服務註冊", //ES_title_s6
	"mydlink雲端服務註冊", //ES_title_s6_myd
	"步驟1: 設定您的網際網路連線", //ES_wwa_title_s1
	"無效的DHCP 用戶端名稱", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"無效DHCP+ 密碼", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"無效DHCP+ 登入名稱", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"L2TP 使用者名稱必須被定義。", //GW_WAN_L2TP_USERNAME_INVALID
	"PPTP 密碼必須被定義。", //GW_WAN_PPTP_PASSWORD_INVALID
	"無效的網路金鑰!", //IPV6_TEXT2
	"無效MAC位址", //KR3
	"自動 (WPA 或 WPA2) - 個人級", //KR48
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
	"SBC Yahoo!DSL", //manul_conn_17
	"Shaw", //manul_conn_18
	"Speakeasy", //manul_conn_19
	"Sprint FastConnect", //manul_conn_20
	"Telus", //manul_conn_21
	"Time Warner Cable", //manul_conn_22
	"US West / Qwest", //manul_conn_23
	"Verizon Online DSL", //manul_conn_24
	"XO Communications", //manul_conn_25
	"產品註冊後您將可以使用mydlink專屬的功能，包含透過mydlink網站來管理您的網路連線。", //mydlink_tx01
	"您希望將裝置登記於mydlink服務嗎?", //mydlink_tx02
	"請輸入使用者名稱", //PPP_USERNAME_EMPTY
	"支援PPPoE Plus", //pppoe_plus_dail
	"密碼內容只能為可印刷的字元(英文)。", //S493
	"儲存設定", //save_settings
	"設定儲存中。", //save_wait
	"韌體版本", //sd_FWV
	"產品頁面", //TA2
	"硬體版本", //TA3
	"(GMT-12:00) 埃尼威托克島, 瓜加林島", //up_tz_00
	"(GMT-11:00) 中途島, 薩摩亞", //up_tz_01
	"(GMT-10:00) 夏威夷", //up_tz_02
	"(GMT-09:00) 阿拉斯加", //up_tz_03
	"(GMT-08:00) 太平洋時間 (美國/加拿大), 提華納", //up_tz_04
	"(GMT-07:00) 亞利桑那州", //up_tz_05
	"(GMT-07:00) 山地時間 (美國/加拿大)", //up_tz_06
	"(GMT-06:00) 中美洲", //up_tz_07
	"(GMT-06:00) 中央時間 (美國/加拿大)", //up_tz_08
	"(GMT-06:00) 墨西哥市", //up_tz_09
	"(GMT-06:00) 薩克斯其萬省", //up_tz_10
	"(GMT-05:00) 波哥大, 利馬, 基多", //up_tz_11
	"(GMT-05:00) 東部時間 (美國/加拿大)", //up_tz_12
	"(GMT-05:00) 印第安納州 (東部)", //up_tz_13
	"(GMT-04:00) 大西洋時間 (加拿大)", //up_tz_14
	"(GMT-04:00) 卡拉卡斯, 拉巴斯", //up_tz_15
	"(GMT-04:00) 聖地牙哥", //up_tz_16
	"(GMT-03:30) 紐芬蘭", //up_tz_17
	"(GMT-03:00) 巴西利亞", //up_tz_18
	"(GMT-03:00) 布宜諾斯艾利斯, 喬治城", //up_tz_19
	"(GMT-03:00) 格林蘭島", //up_tz_20
	"(GMT-02:00) 大西洋中部", //up_tz_21
	"(GMT-01:00) 亞速爾群島", //up_tz_22
	"(GMT-01:00) 維德角群島", //up_tz_23
	"(GMT) 卡薩布蘭卡市, 蒙羅維亞", //up_tz_24
	"(GMT) 格林威治時間: 都柏林, 愛丁保, 里斯本, 倫敦", //up_tz_25
	"(GMT+01:00) 阿姆斯特丹, 柏林, 伯恩, 羅馬, 斯德哥爾摩, 維也納", //up_tz_26
	"(GMT+01:00) 貝爾格勒, 布拉提斯拉瓦, 布達佩斯, 盧布亞納, 布拉格", //up_tz_27
	"(GMT+01:00) 布魯塞爾, 哥本哈根, 馬德里, 巴黎", //up_tz_28
	"(GMT+01:00) 薩拉熱窩，斯科普里，索非亞，維爾紐斯，華沙，薩格勒布", //up_tz_29
	"(GMT+01:00) 布達佩斯, 維也納, 布拉格, 華沙", //up_tz_29b
	"(GMT+01:00) 中西非", //up_tz_30
	"(GMT+02:00) 雅典, 伊斯坦堡, 明斯克", //up_tz_31
	"(GMT+02:00) 布加勒斯特", //up_tz_32
	"(GMT+02:00) 開羅", //up_tz_33
	"(GMT+02:00) 辛巴威, 普利托里亞", //up_tz_34
	"(GMT+02:00) 赫爾辛基, 里加, 塔林", //up_tz_35
	"(GMT+02:00) 耶路撒冷", //up_tz_36
	"(GMT+03:00) 巴格達", //up_tz_37
	"(GMT+03:00) 科威特, 利雅德", //up_tz_38
	"(GMT+04:00) 莫斯科, 聖彼得堡, 伏爾加格勒", //up_tz_39
	"(GMT+03:00) 奈洛比", //up_tz_40
	"(GMT+03:30) 德黑蘭", //up_tz_41
	"(GMT+04:00) 阿布達比、馬斯喀特", //up_tz_42
	"(GMT+04:00) 巴庫, 第比利斯, 葉里溫", //up_tz_43
	"(GMT+04:30) 喀布爾", //up_tz_44
	"(GMT+06:00) 葉卡捷琳堡", //up_tz_45
	"(GMT+05:00) 伊斯蘭馬巴德, 喀拉蚩港, 塔什干", //up_tz_46
	"(GMT+05:30) 加爾各答, 辰內, 孟買, 新德里", //up_tz_47
	"(GMT+05:45) 加德滿都", //up_tz_48
	"(GMT+06:00) 阿馬堤", //up_tz_49
	"(GMT+06:00) 阿斯塔那, 達卡", //up_tz_50
	"(GMT+06:00) 斯里蘭卡", //up_tz_51
	"(GMT+06:30) 仰光", //up_tz_52
	"(GMT+07:00) 曼谷, 河內, 雅加達", //up_tz_53
	"(GMT+08:00) 克拉斯諾亞爾斯克", //up_tz_54
	"(GMT+08:00) 北京, 北韓, 香港, 烏拉圭", //up_tz_55
	"(GMT+09:00) 伊爾庫次克、烏蘭巴圖", //up_tz_56
	"(GMT+08:00) 吉隆坡, 新加坡", //up_tz_57
	"(GMT+08:00) 伯斯", //up_tz_58
	"(GMT+08:00) 台北", //up_tz_59
	"(GMT+09:00) 大阪, 札幌, 東京", //up_tz_60
	"(GMT+09:00) 首爾", //up_tz_61
	"(GMT+10:00) 雅庫茨克", //up_tz_62
	"(GMT+09:30) 阿德萊德", //up_tz_63
	"(GMT+09:30) 達爾文", //up_tz_64
	"(GMT+10:00) 布里斯本", //up_tz_65
	"(GMT+10:00) 坎培拉, 墨爾本, 雪梨", //up_tz_66
	"(GMT+10:00) 關島, 摩爾斯比港", //up_tz_67
	"(GMT+10:00) 霍巴特", //up_tz_68
	"(GMT+11:00) 海參崴", //up_tz_69
	"(GMT+11:00) 所羅門群島, 新卡倫多尼亞", //up_tz_70
	"(GMT+12:00) 奧克蘭, 威靈頓", //up_tz_71
	"(GMT+12:00) 斐濟, 堪察加半島, 馬紹爾群島", //up_tz_72
	"(GMT+13:00) 努瓜婁發, 湯加", //up_tz_73
	"(GMT+07:00) 新西伯利亞", //up_tz_74
	"(GMT+12:00) 馬加丹", //up_tz_75
	"(GMT-12:00) 國際換日線以西", //up_tz_76
	"(GMT-11:00) 中途島", //up_tz_77
	"(GMT-07:00) 奇瓦瓦, 拉巴斯, 馬薩特蘭", //up_tz_78
	"(GMT-06:00) 瓜達拉哈拉, 墨西哥城, 蒙特雷", //up_tz_79
	"(GMT-05:00) 波哥大，利馬，基多，印第安納州（東）", //up_tz_80
	"(GMT-04:30) 加拉加斯", //up_tz_81
	"(GMT-04:00) 喬治敦，拉巴斯", //up_tz_82
	"(GMT-03:00) 布宜諾斯艾利斯", //up_tz_83
	"(GMT+01:00) 塞拉耶佛, 斯高比亞, 華沙, 札格雷布", //up_tz_84
	"(GMT+02:00) 赫爾辛基, 基輔, 裏加, 索非雅, 塔林, 維爾紐斯", //up_tz_85
	"(GMT+05:30) 陳奈, 加爾各答, 孟買, 新德里", //up_tz_86
	"(GMT+07:00) 阿拉木圖，新西伯利亞", //up_tz_87
	"(GMT+05:30) 斯里蘭卡 Jayawardenepura", //up_tz_88
	"(GMT+08:00) 烏蘭巴托", //up_tz_89
	"(GMT+09:00) 伊爾庫茨克", //up_tz_90
	"(GMT+13:00) 努瓜婁發", //up_tz_91
	"(GMT+13:00) 薩摩亞", //up_tz_92
	"DNS 設定", //wwa_dnsset
	"通訊閘位址", //wwa_gw
	"D-Link 路由器並沒有預設密碼讓管理員可以存取網頁設定介面。請設定並驗證以下密碼來確保裝置安全性，並啟用 CAPTCHA 圖形驗證來增加安全性，避免未經授權的線上使用者與駭客軟體入侵網路設定。", //wwa_intro_s1
	"請依您所在的地點來選擇一個適當的時區，此資訊將會關聯到以時間為依據的功能和規則。路由器將會使用NTP時間伺服器來自動更新系統的時間。", //wwa_intro_s2
	"請從以下選擇您的網路連線類型:", //wwa_intro_s3
	"安裝設定精靈將會引導您一步一步設定新的路由器並連線至網際網路。", //wwa_intro_wel
	"L2TP 伺服器IP 位址 (也許跟通訊閘位址相同)", //wwa_l2tp_svra
	"如果您的網路會自動配發IP 位址則請選擇這個項目。大部分的Cable Modem都是使用此種連線類型。", //wwa_msg_dhcp
	"若您的網路業者沒有在清單內，或您不知道網路服務由誰提供，則請在下方選擇網路類型 :", //wwa_msg_ispnot
	"若您的網際網路連線需要帳號密碼做登入，請選擇此項。大多數 DSL 數據機會使用此種連線。", //wwa_msg_pppoe
	"PPTP用戶端。", //wwa_msg_pptp
	"若要設定這個連線，請確認您的網路線已從電腦連接至D-Link路由器。若您已接好，請點選「複製電腦的MAC位址」按鈕來複製您電腦的MAC位址到D-Link路由器。", //wwa_msg_set_dhcp
	"若要設定這個連線，您的網路業者需提供一組使用者名稱和密碼，若您沒有這些資料，請詢問您的網路業者。", //wwa_msg_set_pppoe
	"若要設定這個連線，您的網路業者需提供一組使用者名稱和密碼，還有PPTP IP位址。若您沒有這些資料，請詢問您的網路業者。", //wwa_msg_set_pptp
	"若您網路業者提供的IP位址必須以手動方式來設定，則請選擇此項目。", //wwa_msg_sipa
	"備註：您也可能需要輸入主機名稱。如果您沒有或不知道此資料，請詢問您的網路業者。", //wwa_note_hostname
	"主要DNS位址", //wwa_pdns
	"PPTP 伺服器IP位址 (可以和通訊閘位址相同)", //wwa_pptp_svraddr
	"次要DNS位址", //wwa_sdns
	"沒有列出或未知", //wwa_selectisp_not
	"設定使用者名稱與密碼 (L2TP)", //wwa_set_l2tp_title
	"若要設定這個連線，您的網路業者需提供一組完整的IP位址資料。若您有申請一個固定IP但沒有相關的資料，請詢問您的網路業者。", //wwa_set_sipa_msg
	"設定固定IP位址連線", //wwa_set_sipa_title
	"設定 BigPond Cable 連線", //wwa_title_set_bigpond
	"設定使用者名稱和密碼(PPPoE)", //wwa_title_set_pppoe
	"設定登入名稱和密碼連線 (PPTP)", //wwa_title_set_pptp
	"歡迎使用D-Link 設定精靈", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"使用者名稱 / 密碼(L2TP)", //wwa_wanmode_l2tp
	"使用者名稱 / 密碼(PPPoE)", //wwa_wanmode_pppoe
	"使用者名稱 / 密碼 (PPTP)", //wwa_wanmode_pptp
	"固定IP位址", //wwa_wanmode_sipa
	"為您的無線網路設定一個名稱(SSID)", //wwz_wwl_intro_s2_1
	"無線網路名稱 (SSID)", //wwz_wwl_intro_s2_1_1
	"(最多32個英文或數字)", //wwz_wwl_intro_s2_1_2
	"為您的無線網路設定一個連線密碼", //wwz_wwl_intro_s2_2
	"無線密碼", //wwz_wwl_intro_s2_2_1
	"(8~63個英文或數字)", //wwz_wwl_intro_s2_2_2
	"為您的網路命名，最多可輸入32 個字元。", //wwz_wwl_intro_s3_1
	"步驟1: 歡迎使用D-Link無線安全設定精靈", //wwz_wwl_title_s3
	"無效的PPTP 伺服器IP 位址", //YM108
	"請於2.4GHz和5GHz頻段", //wwl_SSP
	"為您的無線網路設定一個名稱(SSID)及連線密碼", //wwz_wwl_intro_s0
	"第1組位址 %s 必須為一整數。", //MSG002
	"第2組位址 %s 必須為一整數。", //MSG003
	"第3組位址 %s 必須為一整數。", //MSG004
	"第4組位址 %s 必須為一整數。", //MSG005
	"%s 為無效的位址。", //MSG006
	"%s 內容不能為零。", //MSG007
	"%s 為無效的輸入通訊埠。", //MSG008
	"輸入的%s 為無效的secret", //MSG009
	"%s 無法允許回送IP 或多點廣播IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x) 規則。", //MSG010
	"請輸入其他 %s 值。", //MSG012
	"%s的數值必須為數字!", //MSG013
	"%s的範圍是%1n ~ %2n。", //MSG014
	"%s 值需為偶數。", //MSG015
	"金鑰無效。金鑰需為5或10個十六進位字元。您所輸入的是 \"", //MSG016
	"金鑰無效。金鑰需為13或26個十六進位字元。您所輸入的是 \"", //MSG017
	"%s 的第一個位址需為十六進位。", //MSG018
	"%s 的第二個位址需為十六進位。", //MSG019
	"%s 的第三個位址需為十六進位。", //MSG020
	"%s 的第四個位址需為十六進位。", //MSG021
	"%s 的第五個位址需為十六進位。", //MSG022
	"%s 的第六個位址需為十六進位。", //MSG023
	"%s 的第七個位址需為十六進位。", //MSG024
	"%s 的第八個位址需為十六進位。", //MSG025
	"%s 的第一個範圍需為", //MSG026
	"%s 的第二個範圍需為", //MSG027
	"%s 的第三個範圍需為", //MSG028
	"%s 的第四個範圍需為", //MSG029
	"%s 的第五個範圍需為", //MSG030
	"%s 的第六個範圍需為", //MSG031
	"%s 的第七個範圍需為", //MSG032
	"%s 的第八個範圍需為", //MSG033
	"%s 不允許迴圈IP (::!)。", //MSG034
	"%s 不允許進入多重播IP位址 (FFxx:0:0:0:0:0:0:2 或 ffxx:0:0:0:0:0:0:2)。", //MSG035
	"無效的公制", //MSG043
	"Metric數值應該介於(1..16).", //ar_alert_3
	"無效的子網路遮罩.", //ar_alert_5
	"金鑰", //TEXT042_1
	"是錯誤的。您可使用的字元限於0~9、A~F和a~f。", //TEXT042_2
	"注意：您可能也需要提供輸入一個服務名稱。若您沒有或不知道此資料，請詢問您的網路業者。", //wwa_note_svcn
	"L2TP用戶端", //wwa_msg_l2tp
	"若要設定這個連線，您的網路業者需提供一組使用者名稱和密碼，還有L2TP IP位址。若您沒有這些資料，請詢問您的網路業者。", //wwa_set_l2tp_msg
	"若要使用此連線，您將需要您的ISP所提供的登入名稱、密碼和BigPond伺服器IP位址。如果您不確定此資訊，請連絡您的ISP。", //wwa_msg_set_bigpond
	"主機名稱", //_hostname
	"2.4GHz 頻段", //GW_WLAN_RADIO_0_NAME
	"5GHz 頻段", //GW_WLAN_RADIO_1_NAME
	"以下是您無線網路安全的設定內容，建議您請將此頁面列印出來或記錄下來，並以此做為您無線裝置連線時的參考。", //wwl_intro_end
	"請稍後…", //_please_wait
	"Copyright &copy; 2014 D-Link Corporation. All rights reserved.", //_copyright
	"連線", //_connect
	"引導我完成網際網路連線設定", //ES_btn_guide_me
	"啟用圖形化驗證", //_graph_auth
	"D-LINK CORPORATION, INC | 無線 路由器 | 首頁", //TEXT000
	"L2TP 密碼必須被定義。", //GW_WAN_L2TP_PASSWORD_INVALID
	"沒有偵測到網路連線。您希望重新執行精靈嗎?", //mydlink_tx03
	"管理員密碼不可以是空白。", //mydlink_tx04
	"檢查WAN連線。", //mydlink_tx05
	"秒", //sec_left
	"重試", //_retry
	"您有mydlink帳號嗎 ?", //mydlink_tx06
	"是，我有mydlink帳號。", //mydlink_tx07
	"否，我想註冊並登入我的mydlink帳號。", //mydlink_tx08
	"電子郵件信箱 (帳號名稱)", //mydlink_tx09
	"請完成選項完成註冊。", //mydlink_tx10
	"確認密碼", //chk_pass
	"姓氏", //Lname
	"名字", //Fname
	"我同意服務條款內容。", //mydlink_tx12
	"請查看您的電子郵件信箱的收件夾來取得完成註冊流程的指示。", //mydlink_tx13_1
	"確認電子郵件信箱後按下登入鈕。", //mydlink_tx13_2
	"登入", //_login
	"完成", //_ok
	"儲存", //_save
	"請確認兩欄的密碼是相同的再繼續", //_pwsame
	"若要使用 <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> 和mydlink Lite app，您需於 <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>註冊一個帳號。 ", //mydlink_reg_into_1
	"如果您已有一個帳號，請按下 <strong>是，我有mydlink帳號</strong> 後按下一步來將您的裝置登記於<a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"如果您尚未擁有帳號，按下 <strong>否，我想註冊並登入我的mydlink帳號</strong> 後按下一步來新增一個帳號。", //mydlink_reg_into_3
	"如果您不想註冊並使用mydlink服務，請按下取消鍵。", //mydlink_reg_into_4_a
	"這個電子郵件信箱已用於其他mydlink帳號。請輸入其他電子郵件信箱。", //mydlink_pop_01
	"您需先同意服務條款才可繼續。", //mydlink_pop_02
	"不可為空白。", //mydlink_pop_03
	"是無效的", //mydlink_pop_04
	"您現在可以開始使用mydlink服務。", //mydlink_pop_05
	"登入失敗", //mydlink_pop_06
	"註冊", //_signup
	"一旦完成mydlink註冊且可透過本設備連上網際網路後，您的雲路由設備預設網際網路連線(PPPoE/L2TP/PPTP)將設定為持續保持連線不會中斷，如果您的寬頻服務業者(ISP)是採取實際使用流量收費，您可以手動修改將連線模式改選擇為\"有需求時才連線\"(Dial On Demand)為預設值。月費不限制使用流量則不需修改。", //mydlink_pop_09
	"無法登入mydlink服務。", //mdl_errmsg_01
	"發送登入要求失敗。", //mdl_errmsg_02
	"無法發送登入要求。", //mdl_errmsg_03
	"發送註冊要求失敗。", //mdl_errmsg_04
	"無法發送註冊要求。", //mdl_errmsg_05
	"SSID欄不可空白。", //SSID_EMPTY_ERROR
	"輸入的密碼不相符", //YM102
	"PPPoE 密碼必須被定義。", //GW_WAN_PPPoE_PASSWORD_INVALID
	"帳戶密碼必須為6個字元以上。", //limit_pass_msg
	"略過", //_skip
	"如果您不希望登入mydlink服務，請點選略過。", //mydlink_reg_into_4
	"儲存Wi-Fi設定", //mydlink_WiFi_save
	"Russia PPTP (雙存取)", //rus_wan_pptp
	"Russia PPTP (雙存取) internet connection type", //rus_wan_pptp_01
	"Russia L2TP (雙存取)", //rus_wan_l2tp
	"Russia L2TP (雙存取) internet connection type", //rus_wan_l2tp_01
	"Russia PPPoE (雙存取)", //rus_wan_pppoe
	"Russia PPPoE (雙存取) internet connection type", //rus_wan_pppoe_02
	"WAN實體設定", //rus_wan_pppoe_03
	"此路由器支援mydlink雲端服務，註冊後您可透過mydlink的網站或mydlink Lite app來遠端管理設備。", //_wz_mydlink_into_1
	"mydlink服務可讓您查看路由器的即時網路速度、使用者的上線狀態和瀏覽記錄、設定在新使用者上線或有使用者嘗試入侵時寄送email通知，及封鎖使用者。", //_wz_mydlink_into_2
	"您可以將此路由器註冊到您現有的mydlink帳戶內，若您尚未註冊過mydlink服務，請在此建立一個新帳戶。", //_wz_mydlink_into_3
	"請至您的email信箱查看是否已收到mydlink服務通知書。", //_wz_mydlink_email_1
	"路由器正在檢查網際網路連線中，請稍候…", //_chk_wanconn_msg_00
	"Would you like to skip mydlink registration?", //_wz_skip_mydlink
	"Metric數值應該介於(1..15).", //ar_alert_3a
	"伺服器 IP 位址", //SERVER_IP_DESC
	"%s 通訊閘IP位址 %s 必須在WAN子網路遮罩內,", //TEXT043
	"廣域網路", //WAN
	"SSID should be represent with ASCII character from code 32 to 126.", //ssid_ascii_range
	"IP位址不應與閘道IP位址相同", //ip_gateway_check
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