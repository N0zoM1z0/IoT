#!/bin/sh

secboot_logger() {
    local msg1="$1"
    echo "[secboot-img-chk] $msg1" >> /dev/kmsg 2>/dev/null
    echo "[secboot-img-chk] $msg1"
    return 0
}

secboot_check_image() {
    local img_full_path="$1"
    local img_name="$2"
    local ret

    ret=$(mkxqimage -c $img_full_path -f $img_name)
    if [ "$?" != "0" ]; then
        return 0
    fi
    # extract image
    cd /tmp
    ret=$(mkxqimage -x $img_full_path -f $img_name)
    if [ "$?" != "0" ]; then
        secboot_logger "Extract image \"$img_name\" fail!"
        cd -
        return 1
    fi
    # sign check chip id = 1540E1
    if [ -f "/tmp/$img_name" ]; then
        ret="$(strings $img_name | grep 1540E1)"
        if [ "$?" != "0" ]; then
            secboot_logger "check images \"$img_name\" fail! upgrade abort!!!"
            rm -f /tmp/$img_name
            return 1
        fi
    else
        secboot_logger "Extract image \"$img_name\" fail!"
        return 1
    fi
    cd -
    rm -f /tmp/$img_name
    return 0
}

secboot_upgd_sign_check() {
    local image_path="$2"
    local secboot_enable=0

    secboot_enable=$(cat /proc/xiaoqiang/secboot_enable 2>/dev/null)
    if [ "$secboot_enable" = "0" ]; then
        secboot_logger "secure boot is not enable"
        return 0
    fi

    secboot_logger "secure boot check images start..."

    secboot_check_image $image_path root.ubi
    if [ "$?" != "0" ]; then
        secboot_logger "secure boot signature check images fail! return directly..."
        return 1
    else
        secboot_logger "secure boot signature check images success! continue..."
        return 0
    fi
}
