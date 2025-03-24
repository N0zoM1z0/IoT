#!/bin/sh

# mimesh_sync: sync mimesh

. /lib/mimesh/mimesh_public.sh


ERR_SYNC=60
ERR_SYNC_TIMEOUT=61
ERR_SYNC_ERR_WITHMSG=62
ERR_SYNC_WITHOUT_RE=63

wifi_mimesh_lock="/var/run/mimesh_wifi.lock"

# mimesh sync method
SYNC_USE_QCA=0  # disabled after trafficd ready
RETRY_MAX=3
RET_OK="success"
FCFG_SYNC="/var/run/trafficd_mimesh_sync_cap"

USE_ENCODE=1
SUPPORT_GUEST_ON_RE=0 # for now, we only support guest network on CAP. so we don not handle guest opts

__get_wifi()
{
	local ifname_2g=$(uci -q get misc.wireless.ifname_2G)
	local iface_2g=$(uci show wireless | grep -w "ifname=\'$ifname_2g\'" | awk -F"." '{print $2}')
	local ifname_5g=$(uci -q get misc.wireless.ifname_5G)
	local iface_5g=$(uci show wireless | grep -w "ifname=\'$ifname_5g\'" | awk -F"." '{print $2}')
	local ifname_game=$(uci -q get misc.wireless.ifname_game)
	local iface_game=$(uci show wireless | grep -w "ifname=\'$ifname_game\'" | awk -F"." '{print $2}')
	local device_2g=$(uci -q get misc.wireless.if_2G)
	local device_5g=$(uci -q get misc.wireless.if_5G)
	local device_game=$(uci -q get misc.wireless.if_game)
	local iface_5g_bh=$iface_game # bhdev was game radio
	local iface_5g_nbh=$iface_5g
	local device_5g_bh=$device_game
	local device_5g_nbh=$device_5g

	ssid_2g="`uci -q get wireless.$iface_2g.ssid`"
	pswd_2g="`uci -q get wireless.$iface_2g.key`"
	[ -z "$pswd_2g" ] && pswd_2g=""
	mgmt_2g="`uci -q get wireless.$iface_2g.encryption`"
	hidden_2g="`uci -q get wireless.$iface_2g.hidden`"
	[ -z "$hidden_2g" ] && hidden_2g=0
	disabled_2g="`uci -q get wireless.$iface_2g.disabled`"
	[ -z "$disabled_2g" ] && disabled_2g=0

	# 5g cfg get bh radio cfg (now was game radio)
	ssid_5g="`uci -q get wireless.$iface_5g_bh.ssid`"
	pswd_5g="`uci -q get wireless.$iface_5g_bh.key`"
	[ -z "$pswd_5g" ] && pswd_5g=""
	mgmt_5g="`uci -q get wireless.$iface_5g_bh.encryption`"
	hidden_5g="`uci -q get wireless.$iface_5g_bh.hidden`"
	[ -z "$hidden_5g" ] && hidden_5g=0
	disabled_5g="`uci -q get wireless.$iface_5g_bh.disabled`"
	[ -z "$disabled_5g" ] && disabled_5g=0

	# 5g_nbh cfg get none bh radio cfg (now was 5g radio)
	ssid_5g_nbh="`uci -q get wireless.$iface_5g_nbh.ssid`"
	mgmt_5g_nbh="`uci -q get wireless.$iface_5g_nbh.encryption`"
	pswd_5g_nbh="`uci -q get wireless.$iface_5g_nbh.key`"
	[ -z "$pswd_5g_nbh" ] && pswd_5g_nbh=""
	hidden_5g_nbh="`uci -q get wireless.$iface_5g_nbh.hidden`"
	[ -z "$hidden_5g_nbh" ] && hidden_5g_nbh=0
	disabled_5g_nbh="`uci -q get wireless.$iface_5g_nbh.disabled`"
	[ -z "$disabled_5g_nbh" ] && disabled_5g_nbh=0


	txpwr_2g="`uci -q get wireless.$device_2g.txpwr`"
	[ -z "$txpwr_2g" ] && txpwr_2g="max"
	ch_2g="`uci -q get wireless.$device_2g.channel`"
	[ -z "$ch_2g" ] && ch_2g="auto"
	bw_2g="`uci -q get wireless.$device_2g.bw`"
	[ -z "$bw_2g" ] && bw_2g=0
	txbf_2g="`uci -q get wireless.$device_2g.txbf`"
	[ -z "$txbf_2g" ] && txbf_2g=3
	ax_2g="`uci -q get wireless.$device_2g.ax`"
	[ -z "$ax_2g" ] && ax_2g=1


	txpwr_5g="`uci -q get wireless.$device_5g_bh.txpwr`"
	[ -z "$txpwr_5g" ] && txpwr_5g="max"
	ch_5g="`uci -q get wireless.$device_5g_bh.channel`"
	[ -z "$ch_5g" ] && ch_5g="auto"
	bw_5g="`uci -q get wireless.$device_5g_bh.bw`"
	[ -z "$bw_5g" ] && bw_5g=0
	txbf_5g="`uci -q get wireless.$device_5g_bh.txbf`"
	[ -z "$txbf_5g" ] && txbf_5g=3
	ax_5g="`uci -q get wireless.$device_5g_bh.ax`"
	[ -z "$ax_5g" ] && ax_5g=1


	txpwr_5g_nbh="`uci -q get wireless.$device_5g_nbh.txpwr`"
	[ -z "$txpwr_5g_nbh" ] && txpwr_5g_nbh="max"
	ch_5g_nbh="`uci -q get wireless.$device_5g_nbh.channel`"
	[ -z "$ch_5g_nbh" ] && ch_5g_nbh="auto"
	bw_5g_nbh="`uci -q get wireless.$device_5g_nbh.bw`"
	[ -z "$bw_5g_nbh" ] && bw_5g_nbh=0
	txbf_5g_nbh="`uci -q get wireless.$device_5g_nbh.txbf`"
	[ -z "$txbf_5g_nbh" ] && txbf_5g_nbh=3
	ax_5g_nbh="`uci -q get wireless.$device_5g_nbh.ax`"
	[ -z "$ax_5g_nbh" ] && ax_5g_nbh=1


	bsd_2g="`uci -q get wireless.$iface_2g.bsd`"
	[ -z "$bsd_2g" ] && bsd_2g=0
	sae_2g="`uci -q get wireless.$iface_2g.sae`"
	[ -z "$sae_2g" ] && sae_2g=""
	sae_pwd_2g="`uci -q get wireless.$iface_2g.sae_password`"
	[ -z "$sae_pwd_2g" ] && sae_pwd_2g=""
	ieee80211w_2g="`uci -q get wireless.$iface_2g.ieee80211w`"
	[ -z "$ieee80211w_2g" ] && ieee80211w_2g=""


	bsd_5g="`uci -q get wireless.$iface_5g_bh.bsd`"
	[ -z "$bsd_5g" ] && bsd_5g=0
	sae_5g="`uci -q get wireless.$iface_5g_bh.sae`"
	[ -z "$sae_5g" ] && sae_5g=""
	sae_pwd_5g="`uci -q get wireless.$iface_5g_bh.sae_password`"
	[ -z "$sae_pwd_5g" ] && sae_pwd_5g=""
	ieee80211w_5g="`uci -q get wireless.$iface_5g_bh.ieee80211w`"
	[ -z "$ieee80211w_5g" ] && ieee80211w_5g=""


	bsd_5g_nbh="`uci -q get wireless.$iface_5g_nbh.bsd`"
	[ -z "$bsd_5g_nbh" ] && bsd_5g_nbh=0
	sae_5g_nbh="`uci -q get wireless.$iface_5g_nbh.sae`"
	[ -z "$sae_5g_nbh" ] && sae_5g_nbh=""
	sae_pwd_5g_nbh="`uci -q get wireless.$iface_5g_nbh.sae_password`"
	[ -z "$sae_pwd_5g_nbh" ] && sae_pwd_5g_nbh=""
	ieee80211w_5g_nbh="`uci -q get wireless.$iface_5g_nbh.ieee80211w`"
	[ -z "$ieee80211w_5g_nbh" ] && ieee80211w_5g_nbh=""


	support160="`uci -q get misc.wireless.support_160m`"
	[ -z "$support160" ] && support160=0

	iot_switch="`uci -q get wireless.miot_2G.userswitch`"
	[ -z "$iot_switch" ] && iot_switch=""

	[ "$USE_ENCODE" -gt 0 ] || {
	# support special string escape
		ssid_2g="$(str_escape "$ssid_2g")"
		pswd_2g="$(str_escape "$pswd_2g")"
		ssid_5g="$(str_escape "$ssid_5g")"
		pswd_5g="$(str_escape "$pswd_5g")"
		ssid_5g_nbh="$(str_escape "$ssid_5g_nbh")"
		pswd_5g_nbh="$(str_escape "$pswd_5g_nbh")"
		sae_pwd_2g="$(str_escape "$sae_pwd_2g")"
		sae_pwd_5g="$(str_escape "$sae_pwd_5g")"
		sae_pwd_5g_nbh="$(str_escape "$sae_pwd_5g_nbh")"
	}
}

__get_bh_wifi()
{
	local bh_tag=$(uci -q get misc.backhauls.backhaul)
	[ -z "$bh_tag" ] && bh_tag="$BHTAG"
	local iface_5g_name=`uci -q get misc.backhauls.backhaul_${bh_tag}_ap_iface`
	local iface_5g_no=`uci show wireless|grep $iface_5g_name|awk -F "." '{print $2}'`
	if [ -n "$iface_5g_no" ]; then
		ssid_bh="`uci -q get wireless.$iface_5g_no.ssid`"
		pswd_bh="`uci -q get wireless.$iface_5g_no.key`"
		mgmt_bh="`uci -q get wireless.$iface_5g_no.encryption`"
		maclist_5g="`uci -q get wireless.$iface_5g_no.maclist`"
		maclist_5g_format="`echo -n $maclist_5g | sed "s/ /;/g"`"
		filter_5g="`uci -q get wireless.$iface_5g_no.macfilter`"
	else
		random_ssid_str="`dd if=/dev/urandom bs=1 count=6 2> /dev/null | openssl base64`"
		ssid_bh="MiMesh_$random_ssid_str"
		pswd_bh="`dd if=/dev/urandom bs=1 count=12 2> /dev/null | openssl base64`"
		mgmt_bh="psk2"
		maclist_5g=""
		maclist_5g_format=""
		filter_5g=""
	fi

	echo "$ssid_bh" > /tmp/ssid_backhaul_init
	echo "$pswd_bh" > /tmp/pswd_backhaul_init
}

__get_guest()
{
	local gst_sect="guest"

	[ "`uci -q get wireless.$gst_sect`" = "wifi-iface" ] && {
		gst_disab="uci -q get wireless.$gst_sect.disabled"
		[ -z "$gst_disab" ] && gst_disab=0
		gst_ssid="`uci -q get wireless.$gst_sect.ssid`"
		gst_pswd="`uci -q get wireless.$gst_disab.key`"
		gst_mgmt="`uci -q get wireless.$gst_disab.encryption`"
	}|| {
		gst_disab=1
		gst_ssid=""
		gst_pswd=""
		gst_mgmt=""
	}

	[ "$USE_ENCODE" -gt 0 ] || {
	# support special string escape
		gst_ssid="$(str_escape "$gst_ssid")"
		gst_pswd="$(str_escape "$gst_pswd")"
	}
}

__get_system()
{
	timezone="`uci -q get system.@system[0].timezone`"
	ota_auto="`uci -q get otapred.settings.auto`"
	[ -z "$ota_auto" ] && {
		ota_auto=0
		uci set otapred.settings.auto=0
		uci commit otapred
	}

	ota_time="`uci -q get otapred.settings.time`"
	[ -z "$ota_time" ] && {
		ota_time=4
		uci set otapred.settings.time="$ota_time"
		uci commit otapred
	}

	led_blue="`uci -q get xiaoqiang.common.BLUE_LED`"
	[ -z "$led_blue" ] && led_blue=1
}

__get_miscan()
{
	miscan_enable="`uci -q get miscan.config.enabled`"
	[ -z "$miscan_enable" ] && miscan_enable=1
}

__info_compose()
{
    # collect whc_sync msg & push to REs
#tbus call 192.168.31.115 whc_sync "{\"ssid_2g\":\"!@D01-son\",\"ssid_5g\":\"!@D01-son\",\"pswd_2g\":\"123456789\",\"pswd_5g\":\"123456789\",\"mgmt_2g\":\"mixed-psk\",\"mgmt_5g\":\"mixed-psk\",\"txpwr_2g\":\"max\",\"txpwr_5g\":\"max\",\"hidden_2g\":\"0\",\"hidden_5g\":\"0\,\"ch_2g\":\"1\",\"ch_5g\":\"161\",\"bw_2g\":\"0\",\"bw_5g\":\"0\",\"bsd_2g\":\"1\",\"bsd_5g\":\"1\",\"txbf_2g\":\"0\",\"txbf_5g\":\"0\",\sae_2g\":\"1\",\"sae_5g\":\"1\",\"sae_passwd_2g\":\"123456789\",\"sae_passwd_5g\":\"123456789\",\"ieee80211w_2g\":\"1\",\"ieee80211w_5g\":\"1\",\"gst_disab\":\"1\",\"gst_ssid\":\"\",\"gst_pswd\":\"\",\"gst_mgmt\":\"\",\"timezone\":\"CST-8\",\"ota_auto\":\"0\",\"ota_time\":\"4\",\"led_blue\":\"1\"}"

	__get_wifi
	[ "$SUPPORT_GUEST_ON_RE" -gt 0 ] && {
		__get_guest
	}
	__get_system
	__get_miscan

	local bsd1
	if [ $bsd_2g = "1" ]; then
		bsd1="0"
		bsd_2g="1"
		bsd_5g="1"
		bsd_5g_nbh="1"
	elif [ "$bsd_2g" = "3" ]; then
		bsd1="1"
		bsd_2g="1"
		bsd_5g="1"
		bsd_5g_nbh="1"
	elif [ "$bsd_2g" = "0" ]; then
		bsd1="0"
		bsd_2g="0"
		bsd_5g="0"
		bsd_5g_nbh="0"
	elif [ "$bsd_2g" = "2" ]; then
		bsd1="1"
		bsd_2g="0"
		bsd_5g="0"
		bsd_5g_nbh="0"
	fi
	if [ "$SUPPORT_GUEST_ON_RE" -gt 0 ]; then
	msg_decode="{\
\"ssid_2g\":\"$ssid_2g\",\"ssid_5g\":\"$ssid_5g\",\"ssid_5g_nbh\":\"$ssid_5g_nbh\",\"pswd_2g\":\"$pswd_2g\",\"pswd_5g\":\"$pswd_5g\",\"pswd_5g_nbh\":\"$pswd_5g_nbh\",\
\"mgmt_2g\":\"$mgmt_2g\",\"mgmt_5g\":\"$mgmt_5g\",\"mgmt_5g_nbh\":\"$mgmt_5g_nbh\",\"hidden_2g\":\"$hidden_2g\",\"hidden_5g\":\"$hidden_5g\",\"hidden_5g_nbh\":\"$hidden_5g_nbh\",\
\"disabled_2g\":\"$disabled_2g\",\"disabled_5g\":\"$disabled_5g\",\"disabled_5g_nbh\":\"$disabled_5g_nbh\",\"ax_2g\":\"$ax_2g\",\"ax_5g\":\"$ax_5g\",\"ax_5g_nbh\":\"$ax_5g_nbh\",\
\"txpwr_2g\":\"$txpwr_2g\",\"txpwr_5g\":\"$txpwr_5g\",\"txpwr_5g_nbh\":\"$txpwr_5g_nbh\",\"ch_2g\":\"$ch_2g\",\"ch_5g\":\"$ch_5g\",\"ch_5g_nbh\":\"$ch_5g_nbh\",\
\"bw_2g\":\"$bw_2g\",\"bw_5g\":\"$bw_5g\",\"$bw_5g_nbh\":\"$bw_5g_nbh\",\"bsd_2g\":\"$bsd_2g\",\"bsd_5g\":\"$bsd_5g\",\"bsd_5g_nbh\":\"$bsd_5g_nbh\",\"bsd1\":\"$bsd1\",\"txbf_2g\":\"$txbf_2g\",\"txbf_5g\":\"$txbf_5g\",\"txbf_5g_nbh\":\"$txbf_5g_nbh\",\
\"sae_2g\":\"$sae_2g\",\"sae_5g\":\"$sae_5g\",\"sae_5g_nbh\":\"$sae_5g_nbh\",\"sae_passwd_2g\":\"$sae_pwd_2g\",\"sae_passwd_5g\":\"$sae_pwd_5g\",\"sae_passwd_5g_nbh\":\"$sae_pwd_5g_nbh\",\
\"ieee80211w_2g\":\"$ieee80211w_2g\",\"ieee80211w_5g\":\"$ieee80211w_5g\",\"ieee80211w_5g_nbh\":\"$ieee80211w_5g_nbh\",\
\"gst_disab\":\"$gst_disab\",\"gst_ssid\":\"$gst_ssid\",\"gst_pswd\":\"$gst_pswd\",\"gst_mgmt\":\"$gst_mgmt\",\
\"timezone\":\"$timezone\",\"ota_auto\":\"$ota_auto\",\"ota_time\":\"$ota_time\",\"led_blue\":\"$led_blue\",\"miscan_enable\":\"$miscan_enable\",\"support160\":\"$support160\",\
\"iot_switch\":\"$iot_switch\"\
}"

	msg="$msg_decode"
	if [ "$USE_ENCODE" -gt 0 ]; then
	msg="{\
\"ssid_2g\":\"$(base64_enc "$ssid_2g")\",\"ssid_5g\":\"$(base64_enc "$ssid_5g")\",\"ssid_5g_nbh\":\"$(base64_enc "$ssid_5g_nbh")\",\"pswd_2g\":\"$(base64_enc "$pswd_2g")\",\"pswd_5g\":\"$(base64_enc "$pswd_5g")\",\"pswd_5g_nbh\":\"$(base64_enc "$pswd_5g_nbh")\",\
\"mgmt_2g\":\"$mgmt_2g\",\"mgmt_5g\":\"$mgmt_5g\",\"mgmt_5g_nbh\":\"$mgmt_5g_nbh\",\"hidden_2g\":\"$hidden_2g\",\"hidden_5g\":\"$hidden_5g\",\"hidden_5g_nbh\":\"$hidden_5g_nbh\",\
\"disabled_2g\":\"$disabled_2g\",\"disabled_5g\":\"$disabled_5g\",\"disabled_5g_nbh\":\"$disabled_5g_nbh\",\"ax_2g\":\"$ax_2g\",\"ax_5g\":\"$ax_5g\",\"ax_5g_nbh\":\"$ax_5g_nbh\",\
\"txpwr_2g\":\"$txpwr_2g\",\"txpwr_5g\":\"$txpwr_5g\",\"txpwr_5g_nbh\":\"$txpwr_5g_nbh\",\"ch_2g\":\"$ch_2g\",\"ch_5g\":\"$ch_5g\",\"ch_5g_nbh\":\"$ch_5g_nbh\",\
\"bw_2g\":\"$bw_2g\",\"bw_5g\":\"$bw_5g\",\"bw_5g_nbh\":\"$bw_5g_nbh\",\"bsd_2g\":\"$bsd_2g\",\"bsd_5g\":\"$bsd_5g\",\"bsd_5g_nbh\":\"$bsd_5g_nbh\",\"bsd1\":\"$bsd1\",\"txbf_2g\":\"$txbf_2g\",\"txbf_5g\":\"$txbf_5g\",\"txbf_5g_nbh\":\"$txbf_5g_nbh\",\
\"sae_2g\":\"$sae_2g\",\"sae_5g\":\"$sae_5g\",\"sae_5g_nbh\":\"$sae_5g_nbh\",\"sae_passwd_2g\":\"$(base64_enc "$sae_pwd_2g")\",\"sae_passwd_5g\":\"$(base64_enc "$sae_pwd_5g")\",\"sae_passwd_5g_nbh\":\"$(base64_enc "$sae_pwd_5g_nbh")\",\
\"ieee80211w_2g\":\"$ieee80211w_2g\",\"ieee80211w_5g\":\"$ieee80211w_5g\",\"ieee80211w_5g_nbh\":\"$ieee80211w_5g_nbh\",\
\"gst_disab\":\"$gst_disab\",\"gst_ssid\":\"$gst_ssid\",\"gst_pswd\":\"$gst_pswd\",\"gst_mgmt\":\"$gst_mgmt\",\
\"timezone\":\"$timezone\",\"ota_auto\":\"$ota_auto\",\"ota_time\":\"$ota_time\",\"led_blue\":\"$led_blue\",\"miscan_enable\":\"$miscan_enable\",\"support160\":\"$support160\",\
\"iot_switch\":\"$iot_switch\"\
}"
	fi
	else
	msg_decode="{\
\"ssid_2g\":\"$ssid_2g\",\"ssid_5g\":\"$ssid_5g\",\"ssid_5g_nbh\":\"$ssid_5g_nbh\",\"pswd_2g\":\"$pswd_2g\",\"pswd_5g\":\"$pswd_5g\",\"pswd_5g_nbh\":\"$pswd_5g_nbh\",\
\"mgmt_2g\":\"$mgmt_2g\",\"mgmt_5g\":\"$mgmt_5g\",\"mgmt_5g_nbh\":\"$mgmt_5g_nbh\",\"hidden_2g\":\"$hidden_2g\",\"hidden_5g\":\"$hidden_5g\",\"hidden_5g_nbh\":\"$hidden_5g_nbh\",\
\"disabled_2g\":\"$disabled_2g\",\"disabled_5g\":\"$disabled_5g\",\"disabled_5g_nbh\":\"$disabled_5g_nbh\",\"ax_2g\":\"$ax_2g\",\"ax_5g\":\"$ax_5g\",\"ax_5g_nbh\":\"$ax_5g_nbh\",\
\"txpwr_2g\":\"$txpwr_2g\",\"txpwr_5g\":\"$txpwr_5g\",\"txpwr_5g_nbh\":\"$txpwr_5g_nbh\",\"ch_2g\":\"$ch_2g\",\"ch_5g\":\"$ch_5g\",\"ch_5g_nbh\":\"$ch_5g_nbh\",\
\"bw_2g\":\"$bw_2g\",\"bw_5g\":\"$bw_5g\",\"$bw_5g_nbh\":\"$bw_5g_nbh\",\"bsd_2g\":\"$bsd_2g\",\"bsd_5g\":\"$bsd_5g\",\"bsd_5g_nbh\":\"$bsd_5g_nbh\",\"bsd1\":\"$bsd1\",\"txbf_2g\":\"$txbf_2g\",\"txbf_5g\":\"$txbf_5g\",\"txbf_5g_nbh\":\"$txbf_5g_nbh\",\
\"sae_2g\":\"$sae_2g\",\"sae_5g\":\"$sae_5g\",\"sae_5g_nbh\":\"$sae_5g_nbh\",\"sae_passwd_2g\":\"$sae_pwd_2g\",\"sae_passwd_5g\":\"$sae_pwd_5g\",\"sae_passwd_5g_nbh\":\"$sae_pwd_5g_nbh\",\
\"ieee80211w_2g\":\"$ieee80211w_2g\",\"ieee80211w_5g\":\"$ieee80211w_5g\",\"ieee80211w_5g_nbh\":\"$ieee80211w_5g_nbh\",\
\"timezone\":\"$timezone\",\"ota_auto\":\"$ota_auto\",\"ota_time\":\"$ota_time\",\"led_blue\":\"$led_blue\",\"miscan_enable\":\"$miscan_enable\",\"support160\":\"$support160\",\
\"iot_switch\":\"$iot_switch\"\
}"

	msg="$msg_decode"
	if [ "$USE_ENCODE" -gt 0 ]; then
	msg="{\
\"ssid_2g\":\"$(base64_enc "$ssid_2g")\",\"ssid_5g\":\"$(base64_enc "$ssid_5g")\",\"ssid_5g_nbh\":\"$(base64_enc "$ssid_5g_nbh")\",\"pswd_2g\":\"$(base64_enc "$pswd_2g")\",\"pswd_5g\":\"$(base64_enc "$pswd_5g")\",\"pswd_5g_nbh\":\"$(base64_enc "$pswd_5g_nbh")\",\
\"mgmt_2g\":\"$mgmt_2g\",\"mgmt_5g\":\"$mgmt_5g\",\"mgmt_5g_nbh\":\"$mgmt_5g_nbh\",\"hidden_2g\":\"$hidden_2g\",\"hidden_5g\":\"$hidden_5g\",\"hidden_5g_nbh\":\"$hidden_5g_nbh\",\
\"disabled_2g\":\"$disabled_2g\",\"disabled_5g\":\"$disabled_5g\",\"disabled_5g_nbh\":\"$disabled_5g_nbh\",\"ax_2g\":\"$ax_2g\",\"ax_5g\":\"$ax_5g\",\"ax_5g_nbh\":\"$ax_5g_nbh\",\
\"txpwr_2g\":\"$txpwr_2g\",\"txpwr_5g\":\"$txpwr_5g\",\"txpwr_5g_nbh\":\"$txpwr_5g_nbh\",\"ch_2g\":\"$ch_2g\",\"ch_5g\":\"$ch_5g\",\"ch_5g_nbh\":\"$ch_5g_nbh\",\
\"bw_2g\":\"$bw_2g\",\"bw_5g\":\"$bw_5g\",\"bw_5g_nbh\":\"$bw_5g_nbh\",\"bsd_2g\":\"$bsd_2g\",\"bsd_5g\":\"$bsd_5g\",\"bsd_5g_nbh\":\"$bsd_5g_nbh\",\"bsd1\":\"$bsd1\",\"txbf_2g\":\"$txbf_2g\",\"txbf_5g\":\"$txbf_5g\",\"txbf_5g_nbh\":\"$txbf_5g_nbh\",\
\"sae_2g\":\"$sae_2g\",\"sae_5g\":\"$sae_5g\",\"sae_5g_nbh\":\"$sae_5g_nbh\",\"sae_passwd_2g\":\"$(base64_enc "$sae_pwd_2g")\",\"sae_passwd_5g\":\"$(base64_enc "$sae_pwd_5g")\",\"sae_passwd_5g_nbh\":\"$(base64_enc "$sae_pwd_5g_nbh")\",\
\"ieee80211w_2g\":\"$ieee80211w_2g\",\"ieee80211w_5g\":\"$ieee80211w_5g\",\"ieee80211w_5g_nbh\":\"$ieee80211w_5g_nbh\",\
\"timezone\":\"$timezone\",\"ota_auto\":\"$ota_auto\",\"ota_time\":\"$ota_time\",\"led_blue\":\"$led_blue\",\"miscan_enable\":\"$miscan_enable\",\"support160\":\"$support160\",\
\"iot_switch\":\"$iot_switch\"\
}"
	fi

fi
}

__init_info_compose()
{
	__get_wifi
	__get_system

	web_passwd="`uci -q get account.common.admin`"

	#cap_mode
	cap_mode=
	cap_ip=
	vendorinfo=

	local mesh_version="`uci -q get xiaoqiang.common.MESH_VERSION`"
	if [ -z "$mesh_version" ]; then
		mesh_version=1
	fi

	if [ "$mesh_version" = "2" ]; then
		net_mode="`uci -q get xiaoqiang.common.NETMODE`"
		if [ "$net_mode" = "lanapmode" ]; then
			cap_mode="ap"
			cap_ip="`uci -q get network.lan.ipaddr`"
			local model="`bdata get model`"
			local color="`bdata get color`"
			local rom="`uci get /usr/share/xiaoqiang/xiaoqiang_version.version.ROM`"
			vendorinfo="miwifi-${model}-${rom}-${color}"
		elif [ "$net_mode" = "whc_re" ]; then
			cap_mode="`uci -q get xiaoqiang.common.CAP_MODE`"
			cap_ip="`uci -q get xiaoqiang.common.CAP_IP`"
		else
			cap_mode="router"
			cap_ip="`uci -q get network.lan.ipaddr`"
		fi
	fi

	local pswd_5g_nbh_tmp=$pswd_5g_nbh
	[ "$mgmt_5g_nbh" = "ccmp" ] && pswd_5g_nbh_tmp=$sae_pwd_5g_nbh

    local ssid_5g_nbh_b64=$(base64_enc $ssid_5g_nbh)
    local pswd_5g_nbh_b64=$(base64_enc $pswd_5g_nbh_tmp)

	init_msg="{\
\"hidden_2g\":\"$hidden_2g\",\"hidden_5g\":\"$hidden_5g\",\"hidden_5g_nbh\":\"$hidden_5g_nbh\",\
\"disabled_2g\":\"$disabled_2g\",\"disabled_5g\":\"$disabled_5g\",\"disabled_5g_nbh\":\"$disabled_5g_nbh\",\"ax_2g\":\"$ax_2g\",\"ax_5g\":\"$ax_5g\",\"ax_5g_nbh\":\"$ax_5g_nbh\",\
\"txpwr_2g\":\"$txpwr_2g\",\"txpwr_5g\":\"$txpwr_5g\",\"txpwr_5g_nbh\":\"$txpwr_5g_nbh\",\"ch_2g\":\"$ch_2g\",\"ch_5g\":\"$ch_5g\",\"ch_5g_nbh\":\"$ch_5g_nbh\",\
\"bw_2g\":\"$bw_2g\",\"bw_5g\":\"$bw_5g\",\"bw_5g_nbh\":\"$bw_5g_nbh\",\"txbf_2g\":\"$txbf_2g\",\"txbf_5g\":\"$txbf_5g\",\"txbf_5g_nbh\":\"$txbf_5g_nbh\",\
\"support160\":\"$support160\",\"web_passwd\":\"$web_passwd\",\"mesh_version\":\"$mesh_version\",\"cap_mode\":\"$cap_mode\",\"cap_ip\":\"$cap_ip\",\
\"vendorinfo\":\"$vendorinfo\",\"bsd\":\"$bsd_2g\", \"nbh_b64\":\"1\",\"ssid_5g_nbh\":\"$ssid_5g_nbh_b64\",\"pswd_5g_nbh\":\"$pswd_5g_nbh_b64\",\"mgmt_5g_nbh\":\"$mgmt_5g_nbh\"\
}"
}
__syncbuf_compare()
{
	local msg_pre=`cat $FCFG_SYNC | grep -E "ssid.*pswd.*mgmt.*" | awk 'END{print $0}'`
	local msg_now="$1"
	[ "$msg_pre" = "$msg_now" ]
}

## sync_jsonbuf
# output jsonbuf as input for tbus call * whc_sync "$jsonbuf"
mimesh_sync_jsonbuf()
{
	__info_compose
	echo "$msg"

	__syncbuf_compare "$msg" || MIMESH_LOGI " whc_sync reply msg=<\"$msg\">"
	echo "`date +%Y%m%d-%H%M%S` whc_sync reply msg compose on CAP:" > "$FCFG_SYNC"
	echo "$msg_decode" >> "$FCFG_SYNC"
	echo "$msg" >> "$FCFG_SYNC"
}

mimesh_init_jsonbuf()
{
	__init_info_compose
	echo "$init_msg"
}

## notify REs with precompose cmd, if re exist&active
# 1. get and validate WHC_RE active in tbus list, exclude repeater
# 2. run tbus cmd
notify_re()
{
	. /usr/share/libubox/jshn.sh
	json_init
	json_add_string "method" "whc_sync"
	json_add_string "payload" $jmsg
	json_str=`json_dump`

	echo $json_str

	MIMESH_LOGI " ubus call xq_info_sync_mqtt send_msg "$json_str" "
	ubus call xq_info_sync_mqtt send_msg "$json_str"
	return 1
}

mimesh_sync()
{
	local fail=0

	local msg=""
	__info_compose

	MIMESH_LOGI " mimesh_sync note msg=<\"$msg\">"
	echo "`date +%Y%m%d-%H%M%S` mimesh_sync notice msg compose on CAP:" > "$FCFG_SYNC"
	echo "$msg_decode" >> "$FCFG_SYNC"
	echo "$msg" >> "$FCFG_SYNC"

	local cmd="whc_sync"
	local jmsg="$msg"
	notify_re
	ret=$?
	wifi &

	return "$ret"
}

mimesh_sync_lite()
{
	local fail=0
	local msg=""
	__info_compose

	MIMESH_LOGI " mimesh_sync_lite note msg=<\"$msg\">"
	echo "`date +%Y%m%d-%H%M%S` mimesh_sync_lite notice msg compose on CAP:" > "$FCFG_SYNC"
	echo "$msg_decode" >> "$FCFG_SYNC"
	echo "$msg" >> "$FCFG_SYNC"

	local cmd="whc_sync"
	local jmsg="$msg"
	notify_re
	return $?
}

