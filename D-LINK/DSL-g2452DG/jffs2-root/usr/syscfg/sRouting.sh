#!/bin/sh
#*****************************************************
#sRouting.sh
#
#Author:hongqing.xu
#****************************************************
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.utils.sh

G_ACTION=$1
G_ARGV=$2

srouting_root_patch="InternetGatewayDevice.Layer3Forwarding"
srouting_obj="${srouting_root_patch}.Forwarding"

dir_static_routing="/tmp/tri_static_routing"
dir_add="${dir_static_routing}/add"
dir_del="${dir_static_routing}/del"
dir_wan_info="${dir_static_routing}/wan_info"
file_retstatus="${dir_static_routing}/ret.status"

#Help
usage()
{
    echo "Usage:"
    echo "    $0 <action> <index|wan_folder_name>"
    echo "Example:"
    echo "    $0 addel 1"
    echo "    $0 ifup IP_1_1_1"
    echo "    $0 ifdown IP_1_1_1"
    echo "    $0 init 1"
}

NetmaskAton()
{
  local nMask=0

  local aa=`printf $1 | cut -d. -f1`
  local ab=`printf $1 | cut -d. -f2`
  local ac=`printf $1 | cut -d. -f3`
  local ad=`printf $1 | cut -d. -f4`
  
  for i in $aa $ab $ac $ad
  do
      if [ $i == 255 ]; then
          nMask=`expr $nMask + 8`
      elif [ $i == 254 ]; then
          nMask=`expr $nMask + 7`
      elif [ $i == 252 ]; then
          nMask=`expr $nMask + 6`
      elif [ $i == 248 ]; then
          nMask=`expr $nMask + 5`
      elif [ $i == 240 ]; then
          nMask=`expr $nMask + 4`
      elif [ $i == 224 ]; then
          nMask=`expr $nMask + 3`
      elif [ $i == 192 ]; then
          nMask=`expr $nMask + 2`
      elif [ $i == 128 ]; then
          nMask=`expr $nMask + 1`
      fi
  done
  
  echo "$nMask"
}
isSubElem()
{
  local elem="$1"
  local fullElem="$2"
  fullElem=`echo $fullElem | tr "," " "`
  local ret=0
  for i in ${fullElem}
  do
      if [ "$i" == "$elem" ]; then
          ret=1
          break
      fi
  done
  echo $ret
}
delSubElem()
{
  local elem="$1"
  local fullElem="$2"
  fullElem=`echo $fullElem | tr "," " "`
  local retElem=""
  for i in ${fullElem}
  do
      if [ "$i" != "$elem" ]; then
          if [ -z "$retElem" ]; then
          	retElem=$i
          else
          	retElem="$retElem" "," "$i"
          fi
      fi
  done
  echo $retElem

}
DelWanInfoFile()
{
    local index=$1
    local tmp_index=0
    local new_indexs

    for i in ${dir_wan_info}/*.index
    do
        tmp_index=`cat "$i"`
        if [ "$tmp_index" == "$index" ]; then
            rm -f "$i"
            break
        else
            new_indexs=`delSubElem "$index" "$tmp_index"`
            if [ "$tmp_index" != "$new_indexs" ]; then
               echo "$new_indexs" > $i
            fi
        fi
    done
}

AddWanInfoFile()
{
    local index=$1
    local wanconn=$2
    local index_file="${dir_wan_info}/${wanconn}.index" 
    local orig_index

    if [ -f "${index_file}" ]; then    
      orig_index=`cat ${index_file}`
      if [ "1" == `isSubElem "${index}" "${orig_index}"` ]; then
        return
      else
        index="${orig_index}"",""${index}"
      fi
      
    else
      touch "${index_file}"
    fi
    echo "${index}" > "${index_file}" 
    
}

HotplugWanGetIndex()
{
    local index_file="${dir_wan_info}/${1}.index"    
    local index=""

    if [ -f "${index_file}" ]; then    
        index="`cat ${index_file}`"
    fi
    echo "$index"
}

ReconfigRouting()
{
    local action=$1
    local index=$2
    local del_cmd=""
    local add_cmd=""
    
    local dest=""
    local netmask=""
    local gateway=""
    local interface_path=""
    local interface_type=""
    local interface=""
    local wan_interface_folder=""
    local wan_type=""
    local wan_ifname=""
    local metric="" 
    local nMask=32
    local status=""

    check_obj=`cfgcmd check_obj ${srouting_obj}.${index}`
    if [ "$action" != "del" ]; then
        enable=`cfgcmd get ${srouting_obj}.${index}.Enable`
        dest=`cfgcmd get ${srouting_obj}.${index}.DestIPAddress`
        netmask=`cfgcmd get ${srouting_obj}.${index}.DestSubnetMask`
        interface_path=`cfgcmd get ${srouting_obj}.${index}.Interface`
        metric=`cfgcmd get ${srouting_obj}.${index}.ForwardingMetric`
        #paras init       
        touch "${dir_add}/${index}.sh"
        touch "${dir_del}/${index}.sh"
        if [ "${interface_path}" != "" ]; then
            interface_type=`echo "$interface_path" | awk -F '.' '{print $2}'`
            if [ "${interface_type}" == "WANDevice" ]; then
                wan_type=`echo "$interface_path" | awk -F '.' '{print $6}'`
                if [ "${wan_type}" == "WANIPConnection" ]; then
                    wan_interface_folder=`gen_ipconn_folder ${interface_path}`
                    wan_ifname="ifname"
                else
                    wan_interface_folder=`gen_pppconn_folder ${interface_path}`
                    wan_ifname="ppp_ifname"
                fi

                AddWanInfoFile "$index" "${wan_interface_folder}"

                gateway=`get_wan_gw $wan_interface_folder`
                if [ -z "$gateway" ]; then
                    cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Interface inactive" > /dev/null
                    return 2
                else
                    cfgcmd sset "${srouting_obj}.${index}.GatewayIPAddress" "$gateway" > /dev/null
                    interface=`cat "/tmp/${wan_interface_folder}/${wan_ifname}"`
                fi
            elif [ "${interface_type}" == "LANDevice" ]; then
                gateway=`cfgcmd get ${srouting_obj}.${index}.GatewayIPAddress`
                if  [ "${gateway}" == "" ]; then
                    gateway="0.0.0.0"
                fi
                interface="br0"
            elif [ "${interface_type}" == "Services" ]; then
                		interface=`cfgcmd get "${interface_path}TunnelName"`
				gateway=`cfgcmd get ${srouting_obj}.${index}.GatewayIPAddress`
				if  [ "${gateway}" == "" ]; then
					gateway="0.0.0.0"
				fi
            else
                cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Interface Err" > /dev/null
                return 2
            fi
        else
            cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Interface Err" > /dev/null
            return 2
        fi
     
        if  [ "${dest}" == "" ]; then
            cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Destination NULL" > /dev/null
            return 2
        fi
        if  [ "${interface}" == "" ]; then
            cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Interface NULL" > /dev/null
            return 2
        fi

        if  [ "${netmask}" == "" ]; then
            netmask="255.255.255.255"
        fi
        nMask=`NetmaskAton ${netmask}`


        #Delete privous route firstly
        del_cmd=`cat ${dir_del}/${index}.sh`
        if [ "${del_cmd}" != "" ]; then
            eval ${del_cmd}
        fi
        #echo route cmd to self's *.sh 
        echo "ip route add ${dest}/${nMask} via ${gateway} dev ${interface} metric ${metric} > ${file_retstatus} 2>&1" >\
            "${dir_add}/${index}.sh"
        
        echo "ip route del ${dest}/${nMask} via ${gateway} dev ${interface} metric ${metric} > ${file_retstatus} 2>&1" >\
            "${dir_del}/${index}.sh"
        #Start to exec route cmd
        if [ "${enable}" == "1" -a "${action}" != "ifdown" ]; then
            add_cmd=`cat ${dir_add}/${index}.sh`
            eval ${add_cmd}
            #add success
            status=`cat ${file_retstatus} | sed 's/\"//g'`
            if [ "${status}" == "" -o "${status}" == "RTNETLINK answers: File exists" ]; then
                cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "NULL" > /dev/null
                return 0 
            else
                cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "${status}" > /dev/null
                return 2
            fi
        else
            #Only delete ip routing rule in Kernel
            del_cmd=`cat ${dir_del}/${index}.sh`
            eval ${del_cmd}
            status=`cat ${file_retstatus}`

            if [ "${action}" == "ifdown" ]; then
                cfgcmd sset "${srouting_obj}.${index}.X_CT-COM_ErrorInfo" "Interface inactive" > /dev/null
            fi

            if [ "${status}" == "" ]; then
                return 1 
            else
                return 2
            fi
        fi
    else
        if [ -f "${dir_del}/${index}.sh" -a -f "${dir_add}/${index}.sh" ]; then 
            del_cmd=`cat ${dir_del}/${index}.sh`
            if [ "${del_cmd}" != "" ]; then
                eval ${del_cmd}
            fi
            rm -f "${dir_del}/${index}.sh"
            rm -f "${dir_add}/${index}.sh"
            DelWanInfoFile ${index}
            return 1 
        else
            TGP_Log ${TGP_LOG_WARNING} "Routing Rule files not exist!"
            return 2
        fi
    fi
}

PrintResult()
{
    local ret=$1
    #0 add,1 del ,2 err
    if [ $ret -eq 0 ]; then
        TGP_Log ${TGP_LOG_WARNING} "One routing rule add success"
    elif [ $ret -eq 1 ]; then
        TGP_Log ${TGP_LOG_WARNING} "One routing rule del success"
    else
        TGP_Log ${TGP_LOG_WARNING} "This routing rule operate fail!Pls check para!"
     fi
}

if [ "${G_ACTION}" != "init" ]; then
    if [ "${G_ARGV}" == "" ]; then
        TGP_Log ${TGP_LOG_WARNING} "ARGV1=${G_ARGV}"
        usage
        exit 0
    fi
fi

if [ ! -d "${dir_add}" ]; then
    mkdir -p "${dir_add}"    
fi
if [ ! -d "${dir_del}" ]; then
    mkdir -p "${dir_del}"    
fi
if [ ! -d "${dir_wan_info}" ]; then
#not active wan info
    mkdir -p "${dir_wan_info}"    
fi
if [ ! -f "${file_retstatus}" ]; then
    touch "${file_retstatus}"    
fi

case ${G_ACTION} in
    "init")
        indexes=`cfgcmd get_idxes ${srouting_obj}.`
        
        for i in ${indexes}
        do
            ReconfigRouting ${G_ACTION} ${i}
            ret=$?
            PrintResult $ret
        done

        TGP_Log ${TGP_LOG_WARNING} "Static routing rule init complete!"
        ;;
        
	"ifup" | "ifdown")
        #$1:action; $2:Wan Folder Name

        ret=2
        TGP_Log ${TGP_LOG_WARNING} "Add/Delete wan $G_ARGV static routing rule!"
        
        index=`HotplugWanGetIndex $G_ARGV`
        index=`echo $index | tr "," " "`
        for i in ${index}
        do
            ReconfigRouting ${G_ACTION} $i
            ret=$?
            PrintResult $ret
        done
        ;;
    "set")
        TGP_Log ${TGP_LOG_WARNING} "set $G_ARGV static routing rule!"
        ReconfigRouting ${G_ACTION} $G_ARGV
        ret=$?
        PrintResult $ret
        ;;
    "del")
        TGP_Log ${TGP_LOG_WARNING} "del $G_ARGV static routing rule!"
        ReconfigRouting ${G_ACTION} $G_ARGV
        ret=$?
        PrintResult $ret
        ;;
    *)
        usage
        ;;
esac
