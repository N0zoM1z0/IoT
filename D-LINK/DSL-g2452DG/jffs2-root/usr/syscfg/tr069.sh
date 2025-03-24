#!/bin/sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/firewall.param.sh
. /usr/syscfg/api_log.sh

TR069CONF="/tmp/tr069.config"
TR069INFORMED="/tmp/tr069_informed"
CAFilePath="/tmp/server.crt"
need_restart="0"
need_start="1"
oURL=""
oUsername=""
oPassword=""
oPeriodicInformEnable=""
oPeriodicInformInterval=""
oPeriodicInformTime=""
oParameterKey=""
oConnectionRequestURL=""
oConnectionRequestUsername=""
oConnectionRequestPassword=""
oUpgradesManaged=""
oKickURL=""
oDownloadProgressURL=""
oManufacturer=""
oManufacturerOUI=""
oProductClass=""
oSerialNumber=""
myip=""
mygw=""
myif=""
mymask=""
conn_folder=""
tr069_resolv="/tmp/tr069_resolv.conf"

TR069Enable="InternetGatewayDevice.ManagementServer.EnableCWMP"
RequestPort="InternetGatewayDevice.ManagementServer.X_TRI_RequestPort"
URL="InternetGatewayDevice.ManagementServer.URL"
Username="InternetGatewayDevice.ManagementServer.Username"
Password="InternetGatewayDevice.ManagementServer.Password"
PeriodicInformEnable="InternetGatewayDevice.ManagementServer.PeriodicInformEnable"
PeriodicInformInterval="InternetGatewayDevice.ManagementServer.PeriodicInformInterval"
PeriodicInformTime="InternetGatewayDevice.ManagementServer.PeriodicInformTime"
ParameterKey="InternetGatewayDevice.ManagementServer.ParameterKey"
X_TRI_ConnectionRequestAuthentication="InternetGatewayDevice.ManagementServer.X_TRI_ConnectionRequestAuthentication"
ConnectionRequestURL="InternetGatewayDevice.ManagementServer.ConnectionRequestURL"
ConnectionRequestUsername="InternetGatewayDevice.ManagementServer.ConnectionRequestUsername"
ConnectionRequestPassword="InternetGatewayDevice.ManagementServer.ConnectionRequestPassword"
UpgradesManaged="InternetGatewayDevice.ManagementServer.UpgradesManaged"
KickURL="InternetGatewayDevice.ManagementServer.KickURL"
DownloadProgressURL="InternetGatewayDevice.ManagementServer.DownloadProgressURL"
CAEnable="InternetGatewayDevice.ManagementServer.X_TRI_CAEnable"
CAFile="InternetGatewayDevice.ManagementServer.X_TRI_CAFile"
Manufacturer="InternetGatewayDevice.DeviceInfo.Manufacturer"
ManufacturerOUI="InternetGatewayDevice.DeviceInfo.ManufacturerOUI"
ProductClass="InternetGatewayDevice.DeviceInfo.ProductClass"
SerialNumber="InternetGatewayDevice.DeviceInfo.SerialNumber"
TR069WANSavePath="InternetGatewayDevice.ManagementServer.X_TRI_TR069WANSAVE"
TR069UpWANPath="InternetGatewayDevice.ManagementServer.X_TRI_TR069UpWAN"

Save_Tr069WAN_Node ()
{
    if [ -n "${1}" ]; then
        conn_folder=`gen_wanconn_folder ${1}`
        myif=`get_wanconn_ifname ${conn_folder}`
        mygw=`get_wan_gw  ${conn_folder}`
        myip=`get_wan_ip  ${conn_folder}`
        conn_folder="/tmp/${conn_folder}/"
        cfgcmd sset ${TR069UpWANPath} ${1%.*}
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIFNAME ${myif}
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANGATEWAY ${mygw}
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIPADDR ${myip}
    else
        cfgcmd sset ${TR069UpWANPath}  ""
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIFNAME ""
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANGATEWAY ""
        cfgcmd sset InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIPADDR ""
    fi   
}

stop_tr069_agent()
{
    vRequestPort=`cfgcmd get $RequestPort`

    echo "myif=$myif"
    if [ "$myif" == "" ]; then
        return
    fi

    iptables -t filter -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT
    iptables -t nat -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT
    echo "iptables -t filter -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT"
    echo "iptables -t nat -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT"

    killall -9 evcpe

    if [ -f $TR069INFORMED ]; then
        vInformed=`cat $TR069INFORMED`
        if [ "$vInformed" == "1" ]; then
            cfgcmd set InternetGatewayDevice.ManagementServer.X_TRI_TR069ValueChange 1
        fi
    fi
    
}

create_correct_resolv_base()
{
    file=$1

    if [ -s "$file" ];then
        i=1
        line=`cat $file | wc -l`
        while [ "${i}" -le "$line" ]
        do
                dns_ip=`sed -n ${i}p $file`
                i=`expr $i + 1`
                echo "nameserver $dns_ip" >> $tr069_resolv
        done

    fi  
}

create_correct_resolv_conf()
{
    
    echo -n > $tr069_resolv

    #MUST set bind-to before add nameserver,otherwise it dosn't work
    echo "options bind-to:${myip}" >> $tr069_resolv

    # 设置randomize-case为0, 关闭DNS-0x20 encoding, 增强对dns server的兼容性
    echo "options randomize-case:0" >> $tr069_resolv

    create_correct_resolv_base ${conn_folder}/${SERVER_ASSIGNED_DNS}
    create_correct_resolv_base ${conn_folder}/${USER_DEFINED_DNS}

    if [ ! -s "$tr069_resolv" ];then
        cp /etc/resolv.conf $tr069_resolv
    fi
}

create_tr069_agent()
{
    if [ "$myif" == "" -o "$mygw" == "" -o "$myip" == "" ]; then
        vURL=`cfgcmd get $URL`
        if [ "$oURL" != "$vURL" ]; then
            if [ "$oURL" != "" ]; then
                echo "URL changed"
                nvram set Tr069strap=BS
                nvram commit
            fi
        fi
        return
    fi

    ## Con_Bridged Mode
    if [ -f "${conn_folder}/ip_mask" ]; then
        mymask=`cat ${conn_folder}/ip_mask`
    else
        mymask=`ifconfig $myif | grep Mask | awk '{print $4}' | cut -d ":" -f 2`
    fi
    echo "mymask=$mymask"
    vTR069Enable=`cfgcmd get $TR069Enable`
    vRequestPort=`cfgcmd get $RequestPort`
    vRequestPath=`cfgcmd get $RequestPath`

    cfgcmd sset $ConnectionRequestURL "http://$myip:$vRequestPort$vRequestPath"
    echo "cfgcmd sset $ConnectionRequestURL http://$myip:$vRequestPort$vRequestPath"

    acsip=`cfgcmd get $URL | cut -d : -f 2 | cut -d / -f 3`
    echo "acsip=$acsip"
    if [ ! -n $acsip ]; then
        return
    fi

    create_correct_resolv_conf

    vDelReqPort=`cat /tmp/.reqport`
    if [ "$vDelReqPort" != "" ]; then
        iptables -t filter -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vDelReqPort -j ACCEPT
        iptables -t nat -D ${SERVICES_CHAIN} -i $myif -p tcp --dport $vDelReqPort -j ACCEPT
    fi

    iptables -t filter -A ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT
    iptables -t nat -I ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT
    echo "iptables -t filter -A ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT"
    echo "iptables -t nat -A ${SERVICES_CHAIN} -i $myif -p tcp --dport $vRequestPort -j ACCEPT"

    echo $vRequestPort > /tmp/.reqport

    vURL=""
    if [ "$vTR069Enable" == "1" ]; then
        vURL=`cfgcmd get $URL`
    else
        killall -9 evcpe
        return
    fi
    vUsername=`cfgcmd get $Username`
    vPassword=`cfgcmd get $Password`
    vPeriodicInformEnable=`cfgcmd get $PeriodicInformEnable`
    vPeriodicInformInterval=`cfgcmd get $PeriodicInformInterval`
    vPeriodicInformTime=`cfgcmd get $PeriodicInformTime`
    vParameterKey=`cfgcmd get $ParameterKey`
    vX_TRI_ConnectionRequestAuthentication=`cfgcmd get $X_TRI_ConnectionRequestAuthentication`
    vConnectionRequestURL=`cfgcmd get $ConnectionRequestURL`
    vConnectionRequestUsername=`cfgcmd get $ConnectionRequestUsername`
    vConnectionRequestPassword=`cfgcmd get $ConnectionRequestPassword`
    vUpgradesManaged=`cfgcmd get $UpgradesManaged`
    vKickURL=`cfgcmd get $KickURL`
    vDownloadProgressURL=`cfgcmd get $DownloadProgressURL`
    vManufacturer=`cfgcmd get $Manufacturer`
    vManufacturerOUI=`cfgcmd get $ManufacturerOUI`
    vProductClass=`cfgcmd get $ProductClass`
    vSerialNumber=`cfgcmd get $SerialNumber`
    vCAEnable=`cfgcmd get $CAEnable`
    vCAFile="`cfgcmd get $CAFile`"

    if [ "$vURL" == "" ]; then
        return
    fi

    if [ "$vPeriodicInformEnable" == "" ]; then
        return
    fi
    if [ "$vPeriodicInformInterval" == "" ]; then
        return
    fi

    echo "$URL=$vURL" > $TR069CONF
    echo "$Username=$vUsername" >> $TR069CONF
    echo "$Password=$vPassword" >> $TR069CONF
    echo "$PeriodicInformEnable=$vPeriodicInformEnable" >> $TR069CONF
    echo "$PeriodicInformInterval=$vPeriodicInformInterval" >> $TR069CONF
    echo "$PeriodicInformTime=$vPeriodicInformTime" >> $TR069CONF
    echo "$ParameterKey=$vParameterKey" >> $TR069CONF
    echo "$ConnectionRequestURL=$vConnectionRequestURL" >> $TR069CONF 
    if [ "$vX_TRI_ConnectionRequestAuthentication" == "1" ]; then
		  echo "$ConnectionRequestUsername=$vConnectionRequestUsername" >> $TR069CONF
      echo "$ConnectionRequestPassword=$vConnectionRequestPassword" >> $TR069CONF
	  fi  
    echo "$UpgradesManaged=$vUpgradesManaged" >> $TR069CONF
    echo "$KickURL=$vKickURL" >> $TR069CONF
    echo "$DownloadProgressURL=$vDownloadProgressURL" >> $TR069CONF
    echo "$Manufacturer=$vManufacturer" >> $TR069CONF
    echo "$ManufacturerOUI=$vManufacturerOUI" >> $TR069CONF
    echo "$ProductClass=$vProductClass" >> $TR069CONF
    echo "$SerialNumber=$vSerialNumber" >> $TR069CONF
    echo "myif=$myif" >> $TR069CONF
    echo "mygw=$mygw" >> $TR069CONF
    echo "myip=$myip" >> $TR069CONF
    echo "mymask=$mymask" >> $TR069CONF
    
    rm -f $CAFilePath
    if [ "$vCAEnable" == 1 -a -n "$vCAFile" ]; then
        echo "$vCAFile" > $CAFilePath
    fi
    
    cat $TR069CONF

    judge_launch
}

judge_launch()
{
    echo "judge_launch"
    need_restart="0"
    if [ "$oURL" != "$vURL" ]; then
        if [ "$oURL" != "" ]; then
            echo "URL changed"
            nvram get Tr069strap
            nvram set Tr069strap=BS
            nvram commit
            nvram get Tr069strap
        fi
        need_restart="1"
    fi
    if [ "$oUsername" != "$vUsername" ]; then
        echo "Username changed"
        #need_restart="1"
    fi
    if [ "$oPassword" != "$vPassword" ]; then
        echo "Password changed"
        #need_restart="1"
    fi
    if [ "$oPeriodicInformEnable" != "$vPeriodicInformEnable" ]; then
        echo "PeriodicInformEnable changed"
        #need_restart="1"
    fi
    if [ "$oPeriodicInformInterval" != "$vPeriodicInformInterval" ]; then
        echo "PeriodicInformInterval changed"
        #need_restart="1"
    fi
    if [ "$vX_TRI_ConnectionRequestAuthentication" == "1" ]; then
        
        if [ "$oConnectionRequestUsername" != "$vConnectionRequestUsername" ]; then
            echo "ConnectionRequestUsername changed"
            #need_restart="1"
        fi
        if [ "$oConnectionRequestPassword" != "$vConnectionRequestPassword" ]; then
            echo "ConnectionRequestPassword changed"
            #need_restart="1"
        fi
    fi
    if [ "$oConnectionRequestURL" != "$vConnectionRequestURL" ]; then
            echo "ConnectionRequestURL changed"
            #need_restart="1"
    fi

    need_start="1"
    if [ "$vURL" == "" ]; then
        echo "URL null"
        need_start="0"
    fi
    if [ "$vPeriodicInformEnable" == "" ]; then
        echo "PeriodicInformEnable null"
        need_start="0"
    fi
    if [ "$vX_TRI_ConnectionRequestAuthentication" == "" ]; then
        echo "vX_TRI_ConnectionRequestAuthentication null"
        need_start="0"
    fi

    if [ "$need_start" == "0" ]; then
        echo  "not_need_start"
        echo  "not_need_start" > /tmp/tr069_status
        return
    fi
    if [ "$need_restart" == "1" ]; then
        echo  "need_restart"
        echo  "need_restart" > /tmp/tr069_status
        killall -9 evcpe
        evcpe start -f $TR069CONF &
    else
        echo  "need_start"
        echo  "need_start" > /tmp/tr069_status
        result=`pidof evcpe`
        echo  "result=$result"
        if [ "$result" != "" ]; then
            echo  "evcpe alive"
            cfgcmd manully_inform UP
            return
        fi
        echo  "evcpe start -f $TR069CONF"
        evcpe start -f $TR069CONF  &
    fi
    
}

################################################################## main ##################################################################
if [ "$0" == "tr069.sh" -o "$0" == "./tr069.sh" -o "$0" == "/usr/syscfg/tr069.sh" ]; then
    if [ -f $TR069CONF ]; then
        oURL=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.URL" | cut -d "=" -f 2`
        oUsername=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.Username" | cut -d "=" -f 2`
        oPassword=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.Password" | cut -d "=" -f 2`
        oPeriodicInformEnable=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.PeriodicInformEnable" | cut -d "=" -f 2`
        oPeriodicInformInterval=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.PeriodicInformInterval" | cut -d "=" -f 2`
        oConnectionRequestURL=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.ConnectionRequestURL" | cut -d "=" -f 2`
        oConnectionRequestUsername=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.ConnectionRequestUsername" | cut -d "=" -f 2`
        oConnectionRequestPassword=`cat $TR069CONF | grep "InternetGatewayDevice.ManagementServer.ConnectionRequestPassword" | cut -d "=" -f 2`
        echo "oURL=$oURL"
        echo "oUsername=$oUsername"
        echo "oPassword=$oPassword"
        echo "oPeriodicInformEnable=$oPeriodicInformEnable"
        echo "oPeriodicInformInterval=$oPeriodicInformInterval"
        echo "oConnectionRequestURL=$oConnectionRequestURL"
        echo "oConnectionRequestUsername=$oConnectionRequestUsername"
        echo "oConnectionRequestPassword=$oConnectionRequestPassword"
    fi

    
    if [ "$1" == "stop" ]; then
        Save_Tr069WAN_Node
        stop_tr069_agent
    elif [ "$1" == "quick_start" ]; then
        TGP_Log ${TGP_LOG_WARNING} "wan path is $2"
        Save_Tr069WAN_Node  "$2"
        create_tr069_agent
    elif [ "$1" == "set" ]; then
        local wanPath=`cfgcmd get ${TR069UpWANPath}`
        if [ -n "$wanPath" ]; then
            conn_folder=`gen_wanconn_folder ${wanPath}`
            conn_folder="/tmp/${conn_folder}/"
            myif=`cfgcmd get InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIFNAME`
            mygw=`cfgcmd get InternetGatewayDevice.ManagementServer.X_TRI_TR069WANGATEWAY`
            myip=`cfgcmd get InternetGatewayDevice.ManagementServer.X_TRI_TR069WANIPADDR`
            create_tr069_agent
        fi
    fi
fi
