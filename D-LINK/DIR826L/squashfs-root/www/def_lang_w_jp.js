//Version=1.01b02
//Language=Japanese
//Date=Mon, 14, May, 2012
//Merged=FALSE
//Merged Fw=FALSE
var which_lang = new Array ( //_NO_SHARE_NAME_
	"キャンセル", //_cancel
	"あなたのPCのMACアドレスをコピーします", //_clone
	"DHCP接続（ダイナミックIPアドレス）", //_dhcpconn
	"IPアドレス", //_ipaddr
	"L2TP", //_L2TP
	"L2TP ゲートウェイ IPアドレス", //_L2TPgw
	"L2TP IPアドレス", //_L2TPip
	"L2TP サブネットマスク", //_L2TPsubnet
	"言語", //_Language
	"MACアドレス", //_macaddr
	"次へ", //_next
	"いいえ", //_no
	"（オプション）", //_optional
	"パスワード", //_password
	"PPTP ゲートウェイ IPアドレス", //_PPTPgw
	"PPTP IPアドレス", //_PPTPip
	"PPTP サブネットマスク", //_PPTPsubnet
	"前へ", //_prev
	"2つの管理者パスワードを同じにして、再度確認してください。", //_pwsame_admin
	"スタティックＩＰ", //_sdi_staticip
	"サブネットマスク", //_subnet
	"ユーザ名", //_username
	"パスワード確認", //_verifypw
	"このウィザードで加えられたすべての変更を破棄しますか？", //_wizquit
	"はい", //_yes
	"不正なL2TPサーバ IPアドレス", //bwn_alert_17
	"アドレスモード", //bwn_AM
	"BigPondサーバ", //bwn_BPS
	"TKIP及びAES", //bws_CT_3
	"ダイナミックIP", //carriertype_ct_0
	"ルータはインターネット接続タイプを検知しています。お待ちください。", //ES_auto_detect_desc
	"ルータはインターネット接続タイプを検知できません。", //ES_auto_detect_failed_desc
	"\"D-LinkルータWeb管理\"をブックマークしたいですか?", //ES_bookmark
	"再度行ってください", //ES_btn_try_again
	"ルータの背面にあるInternetラベルの付いているポートにルータ付属のイーサネットケーブルの端を接続してください。モデムのイーサネットポートにこのケーブルのもう一方の端を差し込みます。", //ES_cable_lost_desc
	"Step２：Wi-Fiセキュリティを設定します", //ES_step_wifi_security
	"Step３：パスワードを設定します", //ES_title_s3
	"Step４：タイムゾーンを選択します", //ES_title_s4
	"Step５：設定を保存します", //ES_title_s5
	"Step５：Wi-Fi設定を確認します", //ES_title_s5_0
	"Step６：mydlink登録", //ES_title_s6
	"mydlink登録", //ES_title_s6_myd
	"Step１：インターネット接続設定をします", //ES_wwa_title_s1
	"不正なDHCPクライアント名", //GW_DHCP_CLIENT_CLIENT_NAME_INVALID
	"不正なDHCP＋パスワード", //GW_WAN_DHCPPLUS_PASSWORD_INVALID
	"不正なDHCP＋ユーザ名", //GW_WAN_DHCPPLUS_USERNAME_INVALID
	"L2TPユーザ名が指定される必要があります", //GW_WAN_L2TP_USERNAME_INVALID
	"PPTPパスワードが指定される必要があります。", //GW_WAN_PPTP_PASSWORD_INVALID
	"不正なネットワークキー！", //IPV6_TEXT2
	"不正なMACアドレス", //KR3
	"自動（WPA or WPA2）-Personal", //KR48
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
	"mydlinkに製品を登録すると、mydlinkウェブサイトを通じてオンラインでアクセスし、デバイスの管理を含めたmydlink対応機能を使用することができます。", //mydlink_tx01
	"mydlinkにあなたのデバイスを登録しますか？", //mydlink_tx02
	"ユーザ名を入力してください", //PPP_USERNAME_EMPTY
	"PPPoEプラスサポート", //pppoe_plus_dail
	"パスワードは印刷可能文字だけを含むことができます", //S493
	"設定を保存", //save_settings
	"設定は保存されました", //save_wait
	"ファームウェアバージョン", //sd_FWV
	"製品ページ", //TA2
	"ハードウェアバージョン", //TA3
	"(GMT-12:00) エニウェトク、クエジェリン", //up_tz_00
	"(GMT-11:00) ミッドウェイ島、サモア", //up_tz_01
	"(GMT-10:00) ハワイ", //up_tz_02
	"(GMT-09:00) アラスカ", //up_tz_03
	"(GMT-08:00) 太平洋時間 (アメリカ/カナダ)、メキシコ", //up_tz_04
	"(GMT-07:00) アリゾナ", //up_tz_05
	"(GMT-07:00) 山地時間 (アメリカ/カナダ)", //up_tz_06
	"(GMT-06:00) 中央アメリカ", //up_tz_07
	"(GMT-06:00) 中部時間 (アメリカ/カナダ)", //up_tz_08
	"(GMT-06:00) メキシコシティー", //up_tz_09
	"(GMT-06:00) サスカチュワン", //up_tz_10
	"(GMT-05:00) ボゴタ、リマ、キト", //up_tz_11
	"(GMT-05:00) 東部時間 (アメリカ/カナダ)", //up_tz_12
	"(GMT-05:00) インディアナ (東部)", //up_tz_13
	"(GMT-04:00) 大西洋時間(カナダ)", //up_tz_14
	"(GMT-04:00) カラカス、ラパス", //up_tz_15
	"(GMT-04:00) サンチアゴ", //up_tz_16
	"(GMT-03:30) ニューファンドランド", //up_tz_17
	"(GMT-03:00) ブラジル", //up_tz_18
	"(GMT-03:00) ブエノスアイレス、ジョージタウン", //up_tz_19
	"(GMT-03:00) グリーンランド", //up_tz_20
	"(GMT-02:00) 中部大西洋", //up_tz_21
	"(GMT-01:00) アゾレス諸島", //up_tz_22
	"(GMT-01:00) カーポベルデ島", //up_tz_23
	"(GMT) カサブランカ、モンロビア", //up_tz_24
	"(GMT) グリニッジ時間: ダブリン、エディンバラ、リスボン、ロンドン", //up_tz_25
	"(GMT+01:00) アムステルダム、ベルリン、ベルン、ローマ、ストックホルム", //up_tz_26
	"(GMT+01:00) ベオグラード、ブラチスラバ、リュブリャナ", //up_tz_27
	"(GMT+01:00) ブリュッセル、コペンハーゲン、マドリッド、パリ", //up_tz_28
	"(GMT+01:00) サラエボ、スコピエ、ソフィア、ヴィリニュス、ザグレブ", //up_tz_29
	"(GMT+01:00) ブダベスト、ウィーン、プラハ、ワルシャワ", //up_tz_29b
	"(GMT+01:00) 西中央アフリカ", //up_tz_30
	"(GMT+02:00) アテネ、イスタンブール、ミンスク", //up_tz_31
	"(GMT+02:00) ブカレスト", //up_tz_32
	"(GMT+02:00) カイロ", //up_tz_33
	"(GMT+02:00) ハラーレ、プレトリア", //up_tz_34
	"(GMT+02:00) ヘルシンキ、リガ、タリン", //up_tz_35
	"(GMT+02:00) エルサレム", //up_tz_36
	"(GMT+03:00) バグダッド", //up_tz_37
	"(GMT+03:00) クウェート、リャド", //up_tz_38
	"(GMT+04:00) モスクワ、ピーターズバーグ、ボルゴグラード", //up_tz_39
	"(GMT+03:00) ナイロビ", //up_tz_40
	"(GMT+03:00) テヘラン", //up_tz_41
	"(GMT+04:00) アブダビ、マスカット", //up_tz_42
	"(GMT+04:00) バク、トビリシ、エレバン", //up_tz_43
	"(GMT+04:30) カブール", //up_tz_44
	"(GMT+06:00) エカチェリンブルグ", //up_tz_45
	"(GMT+05:00) イスラマバード、カラチ、タシケント", //up_tz_46
	"(GMT+05:30) カルカッタ、チェンナイ、ムンバイ、ニュー・デリー", //up_tz_47
	"(GMT+05:45) カトマンズ", //up_tz_48
	"(GMT+06:00) アルマティ", //up_tz_49
	"(GMT+06:00) アスターナ、ダッカ", //up_tz_50
	"(GMT+06:00) スリ・ジャヤワルデナプラ", //up_tz_51
	"(GMT+06:30) ラングーン", //up_tz_52
	"(GMT+07:00) バンコク、ハノイ、ジャカルタ", //up_tz_53
	"(GMT+08:00) クラスノヤルスク", //up_tz_54
	"(GMT+08:00) 北京、重慶、香港、ウルムチ", //up_tz_55
	"(GMT+09:00) イルクーック、ウラーンバートル", //up_tz_56
	"(GMT+08:00) クアラルンプール、シンガポール", //up_tz_57
	"(GMT+08:00) パース", //up_tz_58
	"(GMT+08:00) 台北", //up_tz_59
	"(GMT+09:00) 大阪、札幌、東京", //up_tz_60
	"(GMT+09:00) ソウル", //up_tz_61
	"(GMT+10:00) ヤクーツク", //up_tz_62
	"(GMT+09:30) アデレード", //up_tz_63
	"(GMT+09:30) ダーウィン", //up_tz_64
	"(GMT+10:00) ブリズベン", //up_tz_65
	"(GMT+10:00) キャンベラ、メルボルン、シドニー", //up_tz_66
	"(GMT+10:00) グァム、ポートモレスビー", //up_tz_67
	"(GMT+10:00) ホーバート", //up_tz_68
	"(GMT+11:00) ウラジオストク", //up_tz_69
	"(GMT+11:00) ソロモン諸島、ニューカレドニア", //up_tz_70
	"(GMT+12:00) オークランド、ウェリントン", //up_tz_71
	"(GMT+12:00) フィジー、カムチャッカ、 マーシャル諸島", //up_tz_72
	"(GMT+13:00) ヌークアロファ、トンガ", //up_tz_73
	"DNS設定", //wwa_dnsset
	"ゲートウェイアドレス", //wwa_gw
	"デフォルトでは、新しいD-Linkのルータは、Webベースの設定ページへの管理アクセス用に設定したパスワードを持っていません。新しいネットワークデバイスを保護するためには、下記のパスワードを設定し、確認してください。そしてCAPTCHAグラフィカル認証を有効にすると、ネットワークの設定にアクセスする権限のないオンライン·ユーザーやハッカーのソフトウェアを防ぐためにセキュリティ保護を提供します。", //wwa_intro_s1
	"あなたのロケーションの適切な​​タイムゾーンを選択します。この情報は、ルータに時間を設定するために必要です。", //wwa_intro_s2
	"以下のインターネット接続タイプから選択してください：", //wwa_intro_s3
	"このウィザードは新しいD-Linkルータを設定し、インターネットへ接続するための設定を段階的に案内します。", //wwa_intro_wel
	"L2TPサーバIPアドレス（ゲートウェイと同じかもしれません）", //wwa_l2tp_svra
	"インターネット接続が自動的にIPアドレスを提供している場合、このオプションを選択します。ほとんどのケーブルモデムがこのタイプの接続を使用します。", //wwa_msg_dhcp
	"ご利用のインターネットサービスプロバイダがリストにないか、あなたはそれがどこであるかわからない場合は、以下のインターネット接続の種類を選択してください：", //wwa_msg_ispnot
	"インターネット接続にユーザー名とパスワードをオンラインで入手する必要がある場合、このオプションを選択します。ほとんどのDSLモデムは、このタイプの接続を使用します。", //wwa_msg_pppoe
	"PPTPクライアント", //wwa_msg_pptp
	"この接続を設定するには、あなたがもともとブロードバンドに接続されていたPCでD-Linkルーターに接続されていることを確認してください。その場合、D-LinkのルータにコンピュータのMACアドレスをコピーするクローンMACボタンをクリックします。", //wwa_msg_set_dhcp
	"この接続を設定するには、あなたのインターネットサービスプロバイダからユーザ名とパスワードを受け取っている必要があります。この情報をお持ちでいない場合は、ISPに連絡してください。", //wwa_msg_set_pppoe
	"この接続を設定するには、あなたのインターネットサービスプロバイダからユーザ名とパスワードを受け取っている必要があります。また、PPTP IPアドレスが必要です。この情報をお持ちでいない場合は、ISPに連絡してください。", //wwa_msg_set_pptp
	"あなたのインターネット·セットアップ·プロバイダが手動で設定する必要があるIPアドレスの情報を提供している場合、このオプションを選択します。", //wwa_msg_sipa
	"注：ホスト名を持っている必要があるかもしれません。この情報を持っているかわからない場合は、ISPに連絡してください。", //wwa_note_hostname
	"プライマリDNSアドレス", //wwa_pdns
	"PPTPサーバIPアドレス（ゲートウェイと同じかもしれません）", //wwa_pptp_svraddr
	"セカンダリDNSアドレス", //wwa_sdns
	"リストにない、もしくはわからない", //wwa_selectisp_not
	"ユーザ名とパスワード接続設定（L2TP）", //wwa_set_l2tp_title
	"この接続を設定するには、あなたのインターネットサービスプロバイダから提供されるIP情報の完全なリストを持っている必要があります。あなたは、静的IP接続を使用している場合で、この情報をお持ちでいない場合は、ISPに連絡してください。", //wwa_set_sipa_msg
	"スタティックIPアドレス接続設定", //wwa_set_sipa_title
	"BigPondケーブル接続設定", //wwa_title_set_bigpond
	"接続ユーザ名とパスワードを設定（PPPoE）", //wwa_title_set_pppoe
	"接続ユーザ名とパスワードを設定（PPTP）", //wwa_title_set_pptp
	"ようこそD-Linkセットアップウィザードへ", //wwa_title_wel
	"BigPond", //wwa_wanmode_bigpond
	"ユーザ名/パスワード 接続（L2TP）", //wwa_wanmode_l2tp
	"ユーザ名/パスワード 接続（PPPoE）", //wwa_wanmode_pppoe
	"ユーザ名/パスワード 接続（PPTP）", //wwa_wanmode_pptp
	"スタティックIPアドレス接続", //wwa_wanmode_sipa
	"Wi-Fiネットワークに名前を付けてください", //wwz_wwl_intro_s2_1
	"Wi-Fiネットワーク名（SSID）", //wwz_wwl_intro_s2_1_1
	"（32文字まで使えます）", //wwz_wwl_intro_s2_1_2
	"Wi-Fiネットワークにパスワードを付けてください", //wwz_wwl_intro_s2_2
	"Wi-Fiパスワード", //wwz_wwl_intro_s2_2_1
	"（8から63文字の間）", //wwz_wwl_intro_s2_2_2
	"32文字まででネットワークに名前を付けてください", //wwz_wwl_intro_s3_1
	"Step１：D-Link ワイヤレスセキュリティセットアップウィザードへようこそ", //wwz_wwl_title_s3
	"不正なPPTPサーバIPアドレス", //YM108
	"2.4GHｚ帯及び5GHz帯の両方で同じワイヤレスセキュリティパスワードを使います", //wwl_SSP
	"Wi-Fiネットワークに名前とパスワードを付けてください", //wwz_wwl_intro_s0
	"%sの第一アドレスは整数でなければなりません。", //MSG002
	"%sの第二アドレスは整数でなければなりません。", //MSG003
	"%sの第三アドレスは整数でなければなりません。", //MSG004
	"%sの第四アドレスは整数でなければなりません。", //MSG005
	"%sは不正なアドレスです", //MSG006
	"%sにゼロは使えません", //MSG007
	"%sポート入力が不正です", //MSG008
	"%sシークレット入力が不正です", //MSG009
	"%sはループバックIPもしくはマルチキャストIP（127.x.x.x、224.x.x.x～239.x.x.x）を入力することはできません", //MSG010
	"別の%s値を入力してください", //MSG012
	"%s値は数字である必要があります", //MSG013
	"%sの範囲は%1n ~ %2nです", //MSG014
	"%sの範囲は偶数である必要があります", //MSG015
	"キーが正しくありません。キーは5文字もしくは10文字の16進数である必要があります。が入力されました。", //MSG016
	"キーが正しくありません。キーは13文字もしくは26文字の16進数である必要があります。 ", //MSG017
	"%sの第一アドレスは16進数でなければなりません。", //MSG018
	"%sの第二アドレスは16進数でなければなりません。", //MSG019
	"%sの第三アドレスは16進数でなければなりません。", //MSG020
	"%sの第四アドレスは16進数でなければなりません。", //MSG021
	"%sの第五アドレスは16進数でなければなりません。", //MSG022
	"%sの第六アドレスは16進数でなければなりません。", //MSG023
	"%sの第七アドレスは16進数でなければなりません。", //MSG024
	"%sの第八アドレスは16進数でなければなりません。", //MSG025
	"%sの第一範囲の間である必要があります", //MSG026
	"%sの第二範囲の間である必要があります", //MSG027
	"%sの第三範囲の間である必要があります", //MSG028
	"%sの第四範囲の間である必要があります", //MSG029
	"%sの第五範囲の間である必要があります", //MSG030
	"%sの第六範囲の間である必要があります", //MSG031
	"%sの第七範囲の間である必要があります", //MSG032
	"%sの第八範囲の間である必要があります", //MSG033
	"%sにはループバック IP ( ::1 )を入力することはできません", //MSG034
	"%sはマルチキャストIP ( FFxx:0:0:0:0:0:0:2 もしくは ffxx:0:0:0:0:0:0:2）を入力することはできません", //MSG035
	"不正なメトリック", //MSG043
	"メトリック値は（1～16）の間である必要があります", //ar_alert_3
	"不正なネットマスク", //ar_alert_5
	"キー", //TEXT042_1
	"間違いです。有効な文字は、0〜9、A〜F、またはA〜F。", //TEXT042_2
	"注：サービス名を提供する必要があるかもしれません。この情報を持っているかわからない場合は、ISPに連絡してください。", //wwa_note_svcn
	"L2TPクライアント", //wwa_msg_l2tp
	"この接続を設定するには、あなたのインターネットサービスプロバイダからユーザ名とパスワードを受け取っている必要があります。また、L2TP IPアドレスが必要です。この情報をお持ちでいない場合は、ISPに連絡してください。", //wwa_set_l2tp_msg
	"この接続を設定するには、あなたのインターネットサービスプロバイダからユーザ名とパスワードを受け取っている必要があります。また、BigpondにサーバーのIPアドレスを必要としています。この情報をお持ちでいない場合は、ISPに連絡してください。", //wwa_msg_set_bigpond
	"ホスト名", //_hostname
	"2.4GHｚ帯", //GW_WLAN_RADIO_0_NAME
	"5GHz帯", //GW_WLAN_RADIO_1_NAME
	"以下はWi-Fiセキュリティの設定の詳細要約です。このページをプリントアウトするか、紙に情報を書いてください。あなたのWi-Fiデバイスの正しい設定を行うことができます。", //wwl_intro_end
	"お待ちください", //_please_wait
	"Copyright &copy; 2012 D-Link Corporation. All rights reserved.", //_copyright
	"接続", //_connect
	"インターネット接続設定を案内します", //ES_btn_guide_me
	"グラフィカル認証を有効にする", //_graph_auth
	"D-LINK CORPORATION, INC | ワイヤレスルータ | ホーム", //TEXT000
	"L2TPパスワードは固有である必要があります", //GW_WAN_L2TP_PASSWORD_INVALID
	"インターネットを検知できません。ウィザードを再スタートしますか？", //mydlink_tx03
	"管理者パスワードを空白にすることはできません", //mydlink_tx04
	"WAN接続をチェックしています", //mydlink_tx05
	"お待ちください", //sec_left
	"再試行", //_retry
	"あなたはmydlinkアカウントを持っていますか？", //mydlink_tx06
	"はい、私はmydlinkアカウントを持っています", //mydlink_tx07
	"いいえ、私は登録して、新しいmydlinkアカウントでログインしたい。", //mydlink_tx08
	"E-mailアドレス（アカウント名）", //mydlink_tx09
	"登録を完了するためのオプションを埋めてください", //mydlink_tx10
	"パスワード確認", //chk_pass
	"姓", //Lname
	"名", //Fname
	"私はmydlinkの条件を受け入れます。", //mydlink_tx12
	"mydlink登録を完了するために、確認の指示に従って電子メールの受信トレイを確認してください。", //mydlink_tx13_1
	"emailアドレスを確認後、ログインボタンをクリックしてください", //mydlink_tx13_2
	"ログイン", //_login
	"OK", //_ok
	"保存", //_save
	"2つのパスワードを同じにして、再度確認してください。", //_pwsame
	"<a href=\"http://tw.mydlink.com\" target=\"_blank\">mydlink.com</a> 機能を利用するためにはmydlink Liteアプリと<a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>へのアカウントが必要です。", //mydlink_reg_into_1
	"既にアカウントを持っていて、 <strong>はい、mydlinkアカウントを持っています</strong>を選択した場合は、次へをクリックし、<a href=\"http://tw.mydlink.com\"  target=\"_blank\">mydlink.com</a>でルータを登録してください。", //mydlink_reg_into_2
	"アカウントを持たず、 <strong>いいえ、新しいmydlinkアカウントを登録しログインしたい</strong> を選択した場合は、次へをクリックし、アカウントを作成してください。", //mydlink_reg_into_3
	"あなたがmydlinkサービスにサインアップしたくない場合は、キャンセルをクリックしてください。", //mydlink_reg_into_4_a
	"このemailアドレスはすでにmydlinkアカウントを持っています。異なるemailアドレスを使ってください。", //mydlink_pop_01
	"続行するには諸条件に同意する必要があります。", //mydlink_pop_02
	"空白にはできません", //mydlink_pop_03
	"不正です", //mydlink_pop_04
	"これでこのデバイスでmydlinkサービスを使うことができます。", //mydlink_pop_05
	"ログイン失敗", //mydlink_pop_06
	"サインアップ", //_signup
	"(GMT+07:00) ノボシビルスク", //up_tz_74
	"(GMT+12:00) マガダン", //up_tz_75
	"mydlink登録が完了した後、ルータのPPPoE、L2TP、PPTP接続は常にオンに設定されます。ご利用のISPが利用に応じて課金する場合は、手動でデフォルト設定をオンデマンドダイアルにすることもできます。", //mydlink_pop_09
	"mydlinkにログインできません", //mdl_errmsg_01
	"サインインリクエストの送信に失敗しました", //mdl_errmsg_02
	"サインインリクエストを送信できません", //mdl_errmsg_03
	"サインアップリクエストの送信に失敗しました", //mdl_errmsg_04
	"サインアップリクエストを送信できません", //mdl_errmsg_05
	"SSID を入力してください。", //SSID_EMPTY_ERROR
	"入力したパスワードが一致しません。", //YM102
	"PPPoEパスワードが指定される必要があります。", //GW_WAN_PPPoE_PASSWORD_INVALID
	"アカウントパスワードは6文字以上である必要があります", //limit_pass_msg
	"スキップ", //_skip
	"mydlinkサービスにサインアップしたくない場合は、スキップをクリックしてください。", //mydlink_reg_into_4
	"Wi-Fi設定を保存しています。", //mydlink_WiFi_save
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
