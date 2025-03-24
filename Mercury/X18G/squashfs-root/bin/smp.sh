#!/bin/sh

#=============================================================================
# smp_affinity: 1 = CPU1, 2 = CPU2, 3 = CPU3, 4 = CPU4
# rps_cpus: wxyz = CPU3 CPU2 CPU1 CPU0 (ex:0xd = 0'b1101 = CPU1, CPU3, CPU4)
#=============================================================================

write_proc() {
    [ -f $2 ] && {
        echo $1 > $2
        #echo -n $1 ">" $2, "= "
        #cat $2
    }
}


write_proc 2 /proc/irq/3/smp_affinity  #GMAC(ethernet)

write_proc 8 /proc/irq/4/smp_affinity  #PCIe0(5G)
write_proc 8 /proc/irq/24/smp_affinity #PCIe1(2G)
write_proc 8 /proc/irq/25/smp_affinity #PCIe2

write_proc 8 /proc/irq/19/smp_affinity #VPN
write_proc 8 /proc/irq/20/smp_affinity #SDXC
write_proc 8 /proc/irq/22/smp_affinity #USB

#WIFI RPS
#Need to config all wifi netdev
write_proc 1 /sys/class/net/ra0/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rai0/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rax0/queues/rx-0/rps_cpus

write_proc 1 /sys/class/net/ra1/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rai1/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rax1/queues/rx-0/rps_cpus

write_proc 1 /sys/class/net/ra2/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rai2/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/rax2/queues/rx-0/rps_cpus

write_proc 1 /sys/class/net/apcli0/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/apclii0/queues/rx-0/rps_cpus
write_proc 1 /sys/class/net/apclix0/queues/rx-0/rps_cpus

#eth driver
write_proc 0 /sys/class/net/eth0/queues/rx-0/rps_cpus
write_proc 0 /sys/class/net/eth1/queues/rx-0/rps_cpus
