#!/bin/sh
lan_speed=`cs_cli /home/cli/debug/driver/kmdio/read_inner -v phy_addr 0x1 reg_addr 0x9 | grep "attribute(02)-alias(data" | awk '{print $4}'`
echo  "Content-type: text/html"
echo  ""
echo  ${lan_speed}
