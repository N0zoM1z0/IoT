#!/bin/sh

CONN_FILE_SORTED="/tmp/.conntrack_sorted_file"
CONN_FILE_DEL_RULE="/tmp/.conntrack_del_rules.sh"
echo "#!/bin/sh" > $CONN_FILE_DEL_RULE

NF_CONNTRACK_MAX=`cat /proc/sys/net/nf_conntrack_max`
NF_CONNTRACK_CLEAR=`echo $NF_CONNTRACK_MAX | awk '{printf("%d",$1*6/10)}'`
NF_CONNTRACK_SAFE=`echo $NF_CONNTRACK_MAX | awk '{printf("%d",$1*75/10)}'`
NF_CONNTRACK_CANCEL_PUNISH=`echo $NF_CONNTRACK_SAFE | awk '{printf("%d",$1*95/10)}'`

MONITOR_TIME=180
FAST_CHECK_TIME=20
PUNNISH_TIME=180
PUNNISH_CANCEL_TIME=60
NF_CONNTRACK_P2P=100

#initial state. 
state="monitor"

fast_check=0
while true
do
    case "$state" in
        "monitor")
            #echo " state --> monitor"
            local nf_ct_cnt=`cat /proc/sys/net/netfilter/nf_conntrack_count`
            if [ $nf_ct_cnt -gt $NF_CONNTRACK_SAFE ]; then
                # state is monitor, loop to monitor nf_conntrack_count
                state="monitor"
                if [ $fast_check -ge 1 ]; then
                    state="punish"
                    continue
                fi

                fast_check=1
                # 1min later, do dobule check.
                sleep $FAST_CHECK_TIME
                continue
            fi

            # when clear, we remove fast check state
            if [ $nf_ct_cnt -lt $NF_CONNTRACK_CLEAR ]; then
                fast_check=0
				sleep $MONITOR_TIME
			else
				sleep $FAST_CHECK_TIME
            fi
            #sleep $MONITOR_TIME
            ;;

        "punish")
            #echo " in state --> punish"
            ## ok,  we got nf_ct_cnt > NF_CONNTRACK_SAFE, it's not safe for now, that need we to do something....

            ## 1) step one : got whichi ip may be using p2p download now.
            # 170 udp 192.168.1.2 20492
            # 2 udp 192.168.68.204 137
            # 2 udp 192.168.1.2 137
            # 2 udp 10.88.18.101 45744
            # 2 udp 10.88.18.101 26028
            # 1 unknown 192.168.1.2 src
            # 1 udp 192.168.1.2 6771
            # 1 udp 192.168.1.2 59856
            # 1 udp 192.168.1.2 58484
            # 1 udp 192.168.1.2 52195
            conntrack -L | awk '{for(i=4;i<NF;i++)if($i~/src=/){print $1,$i,$(i+2); break}}' | awk -F "[ =]" '{print $1,$3,$5}' | sort | uniq -c | sort -nr | head -n 10 > $CONN_FILE_SORTED

            while read line
            do
                local ct_num=`echo $line | awk '{print $1}'`
                # maybe a p2p connection
                if [ $ct_num -ge $NF_CONNTRACK_P2P ]; then
                    local ct_proto=`echo $line | awk '{print $2}'`
                    local ct_src=`echo $line | awk '{print $3}'`
                    local ct_sport=`echo $line | awk '{print $4}'`

                    # deny new connections from this src/sport host.
                    iptables -t mangle -I POSTROUTING -p $ct_proto -s $ct_src --sport $ct_sport -m conntrack --ctstate NEW -j DROP
                    #echo " iptables -t mangle -D POSTROUTING -p $ct_proto -s $ct_src --sport $ct_sport -m conntrack --ctstate NEW -j DROP"
                    echo "iptables -t mangle -D POSTROUTING -p $ct_proto -s $ct_src --sport $ct_sport -m conntrack --ctstate NEW -j DROP" >> $CONN_FILE_DEL_RULE
                else
                    break
                fi
            done < $CONN_FILE_SORTED

            #echo " state change to check_punish"
            state="check_punish"

            #now we wait 180s for kernel to release the useless conntrack items.
            #echo " sleep 180s for kernel releasing the items."
            sleep $PUNNISH_TIME
            ;;
        "check_punish")
            #echo " state --> check_punish"
            local nf_ct_cnt_r=`cat /proc/sys/net/netfilter/nf_conntrack_count`

            sh $CONN_FILE_DEL_RULE
            echo "#!/bin/sh" > $CONN_FILE_DEL_RULE

            if [ $nf_ct_cnt_r -lt $NF_CONNTRACK_CANCEL_PUNISH ]; then
                #change state to monitor
                #echo " limit sessions successed.  state change to monitor"
                state="monitor"
				sleep $PUNNISH_CANCEL_TIME
            else
                # go on punishing it
                #echo " limit failed, do punish again"
                state="punish"
            fi
            ;;
    esac
done
