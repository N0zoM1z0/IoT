#!/bin/sh

echo "S17, setting jumbo frames 9000 bytes"
# normal packets 9000 + VLAN 4 + Atheros Header 2 = 9006 (0x232e)
ethreg -i eth0 0x0078=0x232e



