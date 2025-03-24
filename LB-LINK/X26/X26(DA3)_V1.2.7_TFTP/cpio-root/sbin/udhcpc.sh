#!/bin/sh

# udhcpc script edited by Tim Riker <Tim@Rikers.org>

. /sbin/config.sh
. /sbin/global.sh

[ -z "$1" ] && echo "Error: should be called from udhcpc" && exit 1

RESOLV_CONF="/etc/resolv.conf"
[ -n "$broadcast" ] && BROADCAST="broadcast $broadcast"
[ -n "$subnet" ] && NETMASK="netmask $subnet"

case "$1" in
    deconfig)
        /sbin/ifconfig $interface 0.0.0.0
        ;;

    renew|bound)
        /sbin/ifconfig $interface $ip $BROADCAST $NETMASK

	/* remove all binding entries after getting new IP */
	HWNAT=`nvram_get 2860 hwnatEnabled`
	if [ "$HWNAT" = "1" ]; then
		rmmod hw_nat
        insmod -q hw_nat
		if [ "$CONFIG_USB" = "y" ];then
				mdev -s #add by wgl 20171218 fix the U disk function 
		fi
		fi

        if [ -n "$router" ] ; then
            echo "deleting routers"
            while route del default gw 0.0.0.0 dev $interface ; do
                :
            done

            metric=0
            for i in $router ; do
                metric=`expr $metric + 1`
                route add default gw $i dev $interface metric $metric
            done
        fi
        echo -n > $RESOLV_CONF
        [ -n "$domain" ] && echo search $domain >> $RESOLV_CONF
        for i in $dns ; do
            echo adding dns $i
            echo nameserver $i >> $RESOLV_CONF
        done
		# notify goahead when the WAN IP has been acquired. --yy
		killall -SIGTSTP goahead

		# restart igmpproxy daemon
        igmp=`nvram_get 2860 igmpEnabled`
        if [ "$igmp" = "1" ]; then
            config-igmpproxy.sh
        fi
		if [ "$wanmode" = "L2TP" ]; then
			if [ "$CONFIG_PPPOL2TP" == "y" ]; then
				killall -9 openl2tpd
				openl2tpd -f -D
			else
				killall -9 l2tpd
				l2tpd
				sleep 1
				l2tp-control "start-session $l2tp_srv"
			fi
            killall -SIGUSR1 daemon
		elif [ "$wanmode" = "PPTP" ]; then
			killall -9 pppd
			pppd file /etc/options.pptp  &
            killall -SIGUSR1 daemon
		fi
        ;;
esac

exit 0

