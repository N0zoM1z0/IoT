#!/bin/sh
#

# RA71 upgrade file

. /lib/upgrade/libupgrade.sh

klogger() {
    local msg1="$1"
    local msg2="$2"

    if [ "$msg1" = "-n" ]; then
        echo -n "$msg2" >> /dev/kmsg 2>/dev/null
        echo -n "$msg2"
    else
        echo "$msg1" >> /dev/kmsg 2>/dev/null
        echo "$msg1"
    fi  

    return 0
}

board_prepare_upgrade() {
    # gently stop pppd, let it close pppoe session
    ifdown wan
    timeout=5
    while [ $timeout -gt 0 ]; do
        pidof pppd >/dev/null || break
        sleep 1
        let timeout=timeout-1
    done

    # clean up upgrading environment
    # call shutdown scripts with some exceptions
    wait_stat=0
    klogger "@Shutdown service "
    for i in /etc/rc.d/*; do
        # filter out K01reboot-wdt and K99umount network dnsmasq

        case $i in
            *reboot-wdt | *umount | *network | *dnsmasq)
                klogger "$i skipped"
                continue
            ;;
        esac

        [ -x "$i" ] || continue

        # wait for high-priority K* scripts to finish
        if echo "$i" | grep -qE "K7"; then
            if [ $wait_stat -eq 0 ]; then
                wait
                sleep 2
                wait_stat=1
            fi
            klogger "  service $i shutdown 2>&1"
            $i shutdown 2>&1
        else
            klogger "  service $i shutdown 2>&1 &"
            $i shutdown 2>&1 &
        fi
    done

    # flush cache and dump meminfo
    sync
    echo 3>/proc/sys/vm/drop_caches
    klogger "@dump meminfo"
    klogger "`cat /proc/meminfo | xargs`"
}

board_start_upgrade_led() {
    # blue: off
    # yellow: blink
    # red: off
    xqled sys_ota

    return
}

board_system_upgrade() {
    local filename=$1
    local uboot_mtd=$(grep "Bootloader" /proc/mtd | awk -F: '{print substr($1,4)}')
    local crash_mtd=$(grep "crash" /proc/mtd | awk -F: '{print substr($1,4)}')
    local firmware0_mtd=$(grep "firmware" /proc/mtd | head -1 | awk -F: '{print substr($1,4)}')
    local firmware1_mtd=$(grep "firmware1" /proc/mtd | awk -F: '{print substr($1,4)}')

    local os_idx=$(nvram get flag_boot_rootfs)
    local firmware_mtd_current=$firmware0_mtd
    local firmware_mtd_target=""
	
    [ -n "$os_idx" -a $os_idx -eq 1 ] && firmware_mtd_current=$firmware1_mtd
    firmware_mtd_target=$(($firmware0_mtd+$firmware1_mtd-$firmware_mtd_current))

    pipe_upgrade_uboot $uboot_mtd $filename
    pipe_upgrade_firmware $firmware_mtd_target $filename
}
