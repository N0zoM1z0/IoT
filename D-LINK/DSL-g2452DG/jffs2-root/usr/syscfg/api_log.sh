#!/bin/sh

#log������
TGP_LOG_NONE=0
TGP_LOG_DEBUG=1
TGP_LOG_INFO=2
TGP_LOG_WARNING=3
TGP_LOG_ERROR=4
TGP_LOG_ALWAYS=5



#���ƣ�Log
#������ͨ����־����
#���룺$1 - log���𣬼�����Ķ���
#      $2 - ��־����
#���أ���
TGP_Log()
{
    local logLevel=$1
    local fileName=`basename $0`
    local curLevelString=`cat /var/tgp/log/cur_level`
    local curLevel=TGP_LOG_NONE
    local levelPrefix=""
    local logFileName="/var/tgp/log/log"

    #���ݼ�������ǰ׺�����������ȷ��ֱ�ӷ��ش���
    case "${logLevel}" in
        "$TGP_LOG_DEBUG")
            levelPrefix="DEBUG"
            ;;
        "$TGP_LOG_INFO")
            levelPrefix="INFO"
            ;;
        "$TGP_LOG_WARNING")
            levelPrefix="WARNING"
            ;;
        "$TGP_LOG_ERROR")
            levelPrefix="ERROR"
            ;;
        "$TGP_LOG_ALWAYS")
            levelPrefix="ALWAYS"
            ;;
        *)
            TGP_Log $TGP_LOG_ERROR "Log level error:${logLevel}"
            return
        ;;
    esac

    #��ȡ��ǰ�Ĵ�ӡ����
    case "${curLevelString}" in
        "debug")
            curLevel=$TGP_LOG_DEBUG
            ;;
        "info")
            curLevel=$TGP_LOG_INFO
            ;;
        "warning")
            curLevel=$TGP_LOG_WARNING
            ;;
        "error")
            curLevel=$TGP_LOG_ERROR
            ;;
        *)
            curLevel=$TGP_LOG_WARNING            
            ;;
    esac

    #�ж��Ƿ���Ҫ��ӡ
    if [ ${logLevel} -lt ${curLevel} ]; then
	      return
    fi

   #��ӡ������
   echo -e "[`date +%H`:`date +%M`:`date +%S`][${fileName}][${levelPrefix}] $2"


   #��ӡ���ļ�����Ϊ��Щ�ű�����ʱ�����ڱ��ر��ˣ��������һ����С��������¼�¼
   echo -e "[`date +%H`:`date +%M`:`date +%S`][${fileName}][${levelPrefix}] $2" >>${logFileName}
   if [ `ls -l ${logFileName} | awk '{print $5}'`  -gt 20480 ]; then
       cat /dev/null > ${logFileName}
   fi
}