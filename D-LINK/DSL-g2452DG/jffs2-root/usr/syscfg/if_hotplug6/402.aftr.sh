#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done

TGP_Log ${TGP_LOG_WARNING} "action=$action"

case "$action" in
        "ifup")
                /usr/syscfg/aftr.sh $wan_ifname $path 1
                ;;
        "ifdown")
                /usr/syscfg/aftr.sh $wan_ifname $path 0
                ;;
        *)
                echo "unsupported action"
                ;;
esac

