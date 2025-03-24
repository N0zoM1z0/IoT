###
# @Copyright (C), 2020-2022, Xiaomi CO., Ltd.:
# @Description: this file include lib functions for different models
# @Author: Lin Hongqing
# @Date: 2021-05-26 10:19:25
# @Email: linhongqing@xiaomi.com
# @LastEditTime: 2021-07-07 20:59:15
# @LastEditors: Lin Hongqing
# @History:
###
#!/bin/sh

HNAT_LOCK_FILE=/tmp/lock/hnat_switch.lock

arch_start_hnat() {
    local hnat_disabled=$(uci -q get misc.quickpass.hnat_disabled)
    [ ${hnat_disabled:=0} -ne 0 ] && return
    echo 1 >/sys/kernel/debug/hnat/hook_toggle
    export hnat_tmp_switch=1
}

arch_stop_hnat() {
    echo 0 >/sys/kernel/debug/hnat/hook_toggle
    export hnat_tmp_switch=0
}

arch_restart_hnat() {
    arch_stop_hnat
    arch_start_hnat
}

arch_disable_hnat() {
    local hnat_disabled=$(uci -q get misc.quickpass.hnat_disabled)
    [ ${hnat_disabled:=0} -eq 0 ] && echo 0 >/sys/kernel/debug/hnat/hook_toggle
    hnat_disabled=$((${hnat_disabled:=0} + 1))
    uci -q set misc.quickpass.hnat_disabled=${hnat_disabled}
    uci commit misc
}

arch_enable_hnat() {
    local hnat_disabled=$(uci -q get misc.quickpass.hnat_disabled)
    [ ${hnat_disabled:=0} -eq 0 ] && return
    hnat_disabled=$((${hnat_disabled} - 1))
    [ ${hnat_disabled} -eq 0 -a ${hnat_tmp_switch:=1} -eq 1 ] && {
        echo 1 >/sys/kernel/debug/hnat/hook_toggle
    }
    uci -q set misc.quickpass.hnat_disabled=${hnat_disabled}
    uci commit misc
}

arch_disable_ipv6_hnat() {
    echo 0 >/sys/kernel/debug/hnat/ipv6_toggle
}

arch_enable_ipv6_hnat() {
    echo 1 >/sys/kernel/debug/hnat/ipv6_toggle
}

# enable or disable hnat
# on true
# off false
arch_set_hnat() {
    trap "lock -u ${HNAT_LOCK_FILE}; exit 1" SIGHUP SIGINT SIGTERM
    lock ${HNAT_LOCK_FILE}
    case "$1" in
    "on" | "true")
        arch_enable_hnat
        ;;
    "off" | "false")
        arch_disable_hnat
        ;;
    *)
        echo "arch_set_hnat unsupport $1" >/dev/console
        ;;
    esac
    lock -u ${HNAT_LOCK_FILE}
}
