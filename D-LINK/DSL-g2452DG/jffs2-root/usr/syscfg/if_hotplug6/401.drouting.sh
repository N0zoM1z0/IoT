#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done

TGP_Log ${TGP_LOG_WARNING} "action=$action"

case "$action" in
        "ifup")
                /usr/syscfg/dRouting6.sh "${action}" "${path}"
                ;;
        "ifdown")
                /usr/syscfg/dRouting6.sh "${action}" "${path}"
                ;;
        *)
                echo "unsupported action"
                ;;
esac

