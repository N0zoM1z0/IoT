//Version=1.01b02
//Language=TAIWANESE
//Date=Mon, 14, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"取消", //_cancel
	"覆製電腦的MAC位址", //_clone
	"DHCP連線 (動態IP位址)", //_dhcpconn
	"IP位址", //_ipaddr
	"L2TP", //_L2TP
	"L2TP 閘道IP位址", //_L2TPgw
	"L2TP IP位址", //_L2TPip
	"L2TP子網路遮罩", //_L2TPsubnet
	"語言", //_Language
	"MAC位址", //_macaddr
	"下一步", //_next
	"否", //_no
	"(選擇性)", //_optional
	"密碼", //_password
	"PPTP閘道IP位址", //_PPTPgw
	"PPTP IP位址", //_PPTPip
	"PPTP子網路遮罩", //_PPTPsubnet
	"上一步", //_prev
	"請確定兩欄密碼皆相同", //_pwsame_admin
	"固定IP位址", //_sdi_staticip
	"子網路遮罩", //_subnet
	"登入名稱", //_username
	"確認密碼", //_verifypw
	"確定放棄目前精靈所做的設定?", //_wizquit
	"是", //_yes
	"無效L2TP伺服器IP位址", //bwn_alert_17
	"位址模式", //bwn_AM
	"BigPond伺服器", //bwn_BPS
	"TKIP和AES", //bws_CT_3
	"動態IP位址", //carriertype_ct_0
	"路由器正在偵測您的網路連線類型，請稍候…", //ES_auto_detect_desc
	"路由器無法偵測網路連線類型。", //ES_auto_detect_failed_desc
	"將\"D-Link路由器管理介面\"加入書籤嗎?", //ES_bookmark
	"重試", //ES_btn_try_again
	"請將包裝內所附乙太網路線的一端連接至路由器INTERNET埠並將另一端連接至數據機的乙太網路埠。", //ES_cable_lost_desc
	"步驟2: 設定您的 Wi-Fi 安全", //ES_step_wifi_security
	"步驟3: 設定您的密碼", //ES_title_s3
	"步驟4: 選取您的時區", //ES_title_s4
	"步驟5: 儲存設定", //ES_title_s5
	"步驟5: 確認 Wi-Fi 設定", //ES_title_s5_0
	"步驟6: mydlink雲端服務註冊", //ES_title_s6
	"mydlink雲端服務註冊", //ES_title_s6_myd
	"步驟1: 設定您的網際網路連線", //ES_wwa_title_s1
	"無效DHCP用戶端名稱", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"無效DHCP+ 密碼", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"無效DHCP+ 登入名稱", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"需指定L2TP登入名稱", //GW_WAN_L2TP_USERNAME_INVALID
	"需指定PPTP密碼", //GW_WAN_PPTP_PASSWORD_INVALID
	"無效網路金鑰!", //IPV6_TEXT2
	"無效MAC位址", //KR3
	"自動 (WPA或WPA2) - 個人", //KR48
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
	"產品註冊後您將可以使用mydlink專屬的功能，包含透過mydlink網站來管理您的網路連線。", //mydlink_tx01
	"您希望將裝置登記於mydlink服務嗎?", //mydlink_tx02
	"請輸入登入名稱", //PPP_USERNAME_EMPTY
	"支援PPPoE Plus", //pppoe_plus_dail
	"密碼僅能包含可列印字元", //S493
	"儲存設定", //save_settings
	"設定儲存中。", //save_wait
	"韌體版本", //sd_FWV
	"產品頁面", //TA2
	"硬體版本", //TA3
	"(GMT-12:00) 埃尼威托克島, 瓜加林島", //up_tz_00
	"(GMT-11:00) 中途島、薩摩亞", //up_tz_01
	"(GMT-10:00) 夏威夷", //up_tz_02
	"(GMT-09:00) 阿拉斯加", //up_tz_03
	"(GMT-08:00)太平洋時間 (美國/加拿大), 提華納", //up_tz_04
	"(GMT-07:00) 亞利桑那州", //up_tz_05
	"(GMT-07:00) 山地時間 (美國/加拿大)", //up_tz_06
	"(GMT-06:00) 中美洲", //up_tz_07
	"(GMT-06:00) 中央時間 (美國/加拿大)", //up_tz_08
	"(GMT-06:00) 墨西哥市", //up_tz_09
	"(GMT-06:00) 薩克斯其萬省", //up_tz_10
	"(GMT-05:00) 波哥大、利馬、基多", //up_tz_11
	"(GMT-05:00) 東部時間 (美國/加拿大)", //up_tz_12
	"(GMT-05:00) 印第安納州 (東部)", //up_tz_13
	"(GMT-04:00) 大西洋時間 (加拿大)", //up_tz_14
	"(GMT-04:00) 卡拉卡斯、拉巴斯", //up_tz_15
	"(GMT-04:00) 聖地牙哥", //up_tz_16
	"(GMT-03:30) 紐芬蘭", //up_tz_17
	"(GMT-03:00) 巴西利亞", //up_tz_18
	"(GMT-03:00) 布宜諾斯艾利斯、喬治城", //up_tz_19
	"(GMT-03:30) 格林蘭島", //up_tz_20
	"(GMT-02:00) 大西洋中部", //up_tz_21
	"(GMT-01:00) 亞速爾群島", //up_tz_22
	"(GMT-01:00) 維德角群島", //up_tz_23
	"(GMT) 卡薩布蘭卡市、蒙羅維亞", //up_tz_24
	"(GMT) 格林威治時間: 都柏林, 愛丁保, 里斯本, 倫敦", //up_tz_25
	"(GMT+01:00) 阿姆斯特丹、柏林、伯恩、羅馬、斯德哥爾摩", //up_tz_26
	"(GMT+01:00) 貝爾格勒、布拉提斯拉瓦、盧布亞納", //up_tz_27
	"(GMT+01:00) 布魯塞爾、哥本哈根、馬德里、巴黎", //up_tz_28
	"(GMT+01:00) 塞拉耶佛、斯高比亞、華沙、札格雷布", //up_tz_29
	"(GMT+01:00) 布達佩斯、維也納、布拉格", //up_tz_29b
	"(GMT+01:00) 中西非", //up_tz_30
	"(GMT+02:00) 雅典、伊斯坦堡、明斯克", //up_tz_31
	"(GMT+02:00) 布加勒斯特", //up_tz_32
	"(GMT+02:00) 開羅", //up_tz_33
	"(GMT+02:00) 辛巴威、普利托里亞", //up_tz_34
	"(GMT+02:00) 赫爾辛基、裏加、塔林", //up_tz_35
	"(GMT+02:00) 耶路撒冷", //up_tz_36
	"(GMT+03:00) 巴格達", //up_tz_37
	"(GMT+03:00) 科威特、利雅德", //up_tz_38
	"(GMT+03:00) 莫斯科、聖彼得堡、伏爾加格勒", //up_tz_39
	"(GMT+03:00) 奈洛比", //up_tz_40
	"(GMT+03:00) 德黑蘭", //up_tz_41
	"(GMT+04:00) 阿布達比、馬斯喀特", //up_tz_42
	"(GMT+04:00) 巴庫、第比利斯、葉里溫", //up_tz_43
	"(GMT+04:30) 喀布爾", //up_tz_44
	"(GMT+05:00) 伊卡特林堡", //up_tz_45
	"(GMT+05:00) 伊斯蘭馬巴德、喀拉蚩港、塔什干", //up_tz_46
	"(GMT+05:30) 加爾各答、辰內、孟買、新德里", //up_tz_47
	"(GMT+05:45) 加德滿都", //up_tz_48
	"(GMT+06:00) 阿馬堤", //up_tz_49
	"(GMT+06:00) 阿斯塔那、達卡", //up_tz_50
	"(GMT+06:00) 斯里蘭卡", //up_tz_51
	"(GMT+06:30) 仰光", //up_tz_52
	"(GMT+07:00) 曼谷、河內、雅加達", //up_tz_53
	"(GMT+07:00) 克拉斯諾亞爾斯克", //up_tz_54
	"(GMT+08:00) 北京、北韓、香港、烏拉圭", //up_tz_55
	"(GMT+08:00) 伊爾庫次克、烏蘭巴圖", //up_tz_56
	"(GMT+08:00) 吉隆坡、新加坡", //up_tz_57
	"(GMT+08:00) 伯斯", //up_tz_58
	"(GMT+08:00) 台北", //up_tz_59
	"(GMT+09:00) 大阪、札幌、東京", //up_tz_60
	"(GMT+09:00) 首爾", //up_tz_61
	"(GMT+09:00) 亞庫次克", //up_tz_62
	"(GMT+09:30) 阿德萊德", //up_tz_63
	"(GMT+09:30) 達爾文", //up_tz_64
	"(GMT+10:00) 布里斯本", //up_tz_65
	"(GMT+10:00) 坎培拉、墨爾本、雪梨", //up_tz_66
	"(GMT+10:00) 關島、摩爾斯比港", //up_tz_67
	"(GMT+10:00) 霍巴特", //up_tz_68
	"(GMT+10:00) 海參威", //up_tz_69
	"(GMT+11:00) 索羅門群島、新卡倫多尼亞", //up_tz_70
	"(GMT+12:00) 奧克蘭、威靈頓", //up_tz_71
	"(GMT+12:00) 斐濟、堪察加半島、馬紹爾群島", //up_tz_72
	"(GMT+13:00) 努瓜婁發、東加", //up_tz_73
	"DNS設定", //wwa_dnsset
	"閘道位址", //wwa_gw
	"您的路由器並沒有預設的登入密碼來做設定的修改。為使您的網路更安全，請於以下設定您的登入密碼並啟動CAPTCHA圖示認證來避免網路惡或軟體性的惡性攻擊。", //wwa_intro_s1
	"請選擇適當的時區。路由器上設定時間相關的參數將會需要。", //wwa_intro_s2
	"請從以下選擇您的網路連線類型:", //wwa_intro_s3
	"此精靈將會一步步引導您完成您的D-Link路由器並連接至網際網路。", //wwa_intro_wel
	"L2TP伺服器IP位址 (可與閘道相同)", //wwa_l2tp_svra
	"若您的網際網路自動提供一個IP位址給您，請選擇此連線類型。大多有線電視網路都使用此類型。", //wwa_msg_dhcp
	"若您的ISP不在清單中或您不確定是哪一家，請選取以下連線類型:", //wwa_msg_ispnot
	"若您的網際網路需要您輸入一組登入名稱和密碼才可以連線，請選擇此連線類型。大多DSL數據機都使用此類型。", //wwa_msg_pppoe
	"PPTP用戶端。", //wwa_msg_pptp
	"若要設定此連線，請確認您原先連接至寬頻網路的電腦已連接至D-Link路由器。若確認已連接，按下複製MAC位紙鈕來將電腦的MAC位址複製到路由器。", //wwa_msg_set_dhcp
	"若要設定此連線，請確認您已備有ISP所提供之登入名稱和密碼。如果沒有此資訊，請連絡您的ISP。", //wwa_msg_set_pppoe
	"若要設定此連線，請確認您已備有ISP所提供之登入名稱和密碼。您也會需要PPTP IP位址。如果沒有此資訊，請連絡您的ISP。", //wwa_msg_set_pptp
	"若您的ISP提供了一組IP位址給您且需要手動輸入，請選擇此選項。", //wwa_msg_sipa
	"注意: 您將有可能會需要知道Host名稱。若您沒有或不確定此資訊，請連絡您的ISP。", //wwa_note_hostname
	"主要DNS位址", //wwa_pdns
	"PPTP伺服器IP位址 (可與閘道相同)", //wwa_pptp_svraddr
	"次要DNS位址", //wwa_sdns
	"不在清單中或不確定", //wwa_selectisp_not
	"設定登入名稱和密碼連線 (L2TP)", //wwa_set_l2tp_title
	"若您選擇此連線，您將需要ISP 所提供的IP位址清單。若您使用的是固定IP位址但沒有此資訊，請連絡您的ISP。", //wwa_set_sipa_msg
	"設定固定IP位址連線", //wwa_set_sipa_title
	"設定BigPond Cable連線", //wwa_title_set_bigpond
	"設定登入名稱和密碼連線 (PPPoE)", //wwa_title_set_pppoe
	"設定登入名稱和密碼連線 (PPTP)", //wwa_title_set_pptp
	"歡迎使用D-Link安裝精靈", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"登入名稱 / 密碼連線 (L2TP)", //wwa_wanmode_l2tp
	"登入名稱 / 密碼連線 (PPPoE)", //wwa_wanmode_pppoe
	"登入名稱 / 密碼連線 (PPTP)", //wwa_wanmode_pptp
	"固定IP位址連線", //wwa_wanmode_sipa
	"為您的 Wi-Fi 無線網路取一個名稱。", //wwz_wwl_intro_s2_1
	" Wi-Fi 無線網路名稱 (SSID)", //wwz_wwl_intro_s2_1_1
	"(高達32個字元)", //wwz_wwl_intro_s2_1_2
	"為您的 Wi-Fi 無線網路設定密碼。", //wwz_wwl_intro_s2_2
	" Wi-Fi 無線網路密碼", //wwz_wwl_intro_s2_2_1
	"(於8至63個字元之間)", //wwz_wwl_intro_s2_2_2
	"為您的網路取一個名稱，最多不超過32個字元。", //wwz_wwl_intro_s3_1
	"步驟1: 歡迎使用D-Link無線安全設定精靈", //wwz_wwl_title_s3
	"無效PPTP伺服器IP位址", //YM108
	"請於2.4GHz和5GHz頻段", //wwl_SSP
	"請為您的 Wi-Fi 無線網路建立一個名稱和密碼。", //wwz_wwl_intro_s0
	"%s 的第一個位址需為整數。", //MSG002
	"%s 的第二個位址需為整數。", //MSG003
	"%s 的第三個位址需為整數。", //MSG004
	"%s 的第四個位址需為整數。", //MSG005
	"%s 是無效位址。", //MSG006
	"%s 不可以是零。", //MSG007
	"%s 埠是無效的。", //MSG008
	"%s 暗號是無效的。", //MSG009
	"%s 不允許迴圈IP或多重播IP位址 (127.x.x.x, 224.x.x.x ~ 239.x.x.x)。", //MSG010
	"請輸入其他 %s 值。", //MSG012
	"%s 值需為數字!", //MSG013
	"%s 的範圍為 %1n ~ %2n。", //MSG014
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
	"無效測量", //MSG043
	"測量值需於(1..16)之間。", //ar_alert_3
	"無效網路遮罩。", //ar_alert_5
	"金鑰", //TEXT042_1
	"錯誤，有效字元為0~9, A~F和a~f.", //TEXT042_2
	"注意: 您將有可能需要提供福務名稱。若您不確定此資訊，請連絡您的ISP。", //wwa_note_svcn
	"L2TP 使用端", //wwa_msg_l2tp
	"若要使用此連線，您將需要您的ISP所提供的登入名稱、密碼和L2TP IP位址。如果您不確定此資訊，請連絡您的ISP。", //wwa_set_l2tp_msg
	"若要使用此連線，您將需要您的ISP所提供的登入名稱、密碼和BigPond伺服器IP位址。如果您不確定此資訊，請連絡您的ISP。", //wwa_msg_set_bigpond
	"主機名稱", //_hostname
	"2.4GHz頻段", //GW_WLAN_RADIO_0_NAME
	"5GHz頻段", //GW_WLAN_RADIO_1_NAME
	"以下為您的 Wi-Fi 安全設定的參數。請將此頁面列印後謹慎保存以利未來設定使用。", //wwl_intro_end
	"請稍候…", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"連線", //_connect
	"引導我完成網際網路連線設定", //ES_btn_guide_me
	"啟用圖形驗證", //_graph_auth
	"D-LINK CORPORATION, INC | 無線寬頻路由器 |首頁", //TEXT000
	"需提供L2TP密碼", //GW_WAN_L2TP_PASSWORD_INVALID
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
	"儲存設定", //_save
	"請確認兩欄的密碼是相同的再繼續", //_pwsame
	"若要使用 <a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> 和mydlink Lite app，您需於 <a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>註冊一個帳號。 ", //mydlink_reg_into_1
	"如果您已有一個帳號，請按下 <strong>是，我有mydlink帳號</strong> 後按下一步來將您的裝置登記於<a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>. ", //mydlink_reg_into_2
	"如果您尚未擁有帳號，按下 <strong>否，我想註冊並登入我的mydlink帳號</strong> 後按下一步來新增一個帳號。", //mydlink_reg_into_3
	"如果您不想註冊並使用mydlink服務，請按下取消鍵。", //mydlink_reg_into_4_a
	"這個電子郵件信箱已用於其他mydlink帳號。請輸入其他電子郵件信箱。", //mydlink_pop_01
	"您需先同意服務條款才可繼續。", //mydlink_pop_02
	"不可為空白。", //mydlink_pop_03
	"無效。", //mydlink_pop_04
	"您現在可以開始使用mydlink服務。", //mydlink_pop_05
	"登入失敗", //mydlink_pop_06
	"註冊", //_signup
	"(GMT+07:00) 諾曼斯比爾斯科", //up_tz_74
	"(GMT+12:00) 馬加丹", //up_tz_75
	"一旦完成mydlink註冊且可透過本設備連上網際網路後，您的雲路由設備預設網際網路連線(PPPoE/L2TP/PPTP)將設定為持續保持連線不會中斷，如果您的寬頻服務業者(ISP)是採取實際使用流量收費，您可以手動修改將連線模式改選擇為\"有需求時才連線\"(Dial On Demand)為預設值。月費不限制使用流量則不需修改。", //mydlink_pop_09
	"無法登入mydlink服務。", //mdl_errmsg_01
	"發送登入要求失敗。", //mdl_errmsg_02
	"無法發送登入要求。", //mdl_errmsg_03
	"發送註冊要求失敗。", //mdl_errmsg_04
	"無法發送註冊要求。", //mdl_errmsg_05
	"SSID 欄位不能為空白。", //SSID_EMPTY_ERROR
	"輸入的密碼不相符", //YM102
	"需指定PPPoE密碼", //GW_WAN_PPPoE_PASSWORD_INVALID
	"帳戶密碼必須為6個字元以上。", //limit_pass_msg
	"略過", //_skip
	"如果您不希望登入mydlink服務，請點選略過。", //mydlink_reg_into_4
	"儲存Wi-Fi設定", //mydlink_WiFi_save
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
