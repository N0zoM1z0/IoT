#!/bin/sh
# Copyright (C) 2006-2011 OpenWrt.org

# if ( ! grep -qs '^root:[!x]\?:' /etc/shadow || \
#      ! grep -qs '^root:[!x]\?:' /etc/passwd ) && \
#    [ -z "$FAILSAFE" ]
# then
# 	echo "Login failed."
# # 	exit 0
# else
cat << EOF
 ================================================================
 |                    Welecome to PanguBox !                    |
 |                     Copyright 2013-2022                      |
 |                      PandoraBox-Team                         |
 ================================================================ 
EOF
#  === IMPORTANT ============================
#   Use 'passwd' to set your login password
#   this will disable telnet and enable SSH
#  ------------------------------------------
# EOF
# fi

exec /bin/login
