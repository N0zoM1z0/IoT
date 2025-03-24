#!/bin/sh

. /usr/syscfg/usb/utils.sh

if [ ! -e "$USB_INFO_PATH" ]; then
	mkdir -p $USB_INFO_PATH
fi

