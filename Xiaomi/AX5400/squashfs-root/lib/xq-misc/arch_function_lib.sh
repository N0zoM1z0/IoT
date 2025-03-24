###
# @Copyright (C), 2020-2022, Xiaomi CO., Ltd.:
# @Description: this file include lib functions for different models
# @Author: Lin Hongqing
# @Date: 2021-05-26 10:19:25
# @Email: linhongqing@xiaomi.com
# @LastEditTime: 2021-05-26 11:00:20
# @LastEditors: Lin Hongqing
# @History:
###
#!/bin/sh

arch_set_hnat() {
    [ -f "/etc/init.d/qca-nss-ecm" ] && /etc/init.d/qca-nss-ecm restart
}
