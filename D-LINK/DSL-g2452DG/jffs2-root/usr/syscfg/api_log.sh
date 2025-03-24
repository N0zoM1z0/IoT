#!/bin/sh

#log级别定义
TGP_LOG_NONE=0
TGP_LOG_DEBUG=1
TGP_LOG_INFO=2
TGP_LOG_WARNING=3
TGP_LOG_ERROR=4
TGP_LOG_ALWAYS=5



#名称：Log
#描述：通用日志功能
#输入：$1 - log级别，见上面的定义
#      $2 - 日志内容
#返回：无
TGP_Log()
{
    local logLevel=$1
    local fileName=`basename $0`
    local curLevelString=`cat /var/tgp/log/cur_level`
    local curLevel=TGP_LOG_NONE
    local levelPrefix=""
    local logFileName="/var/tgp/log/log"

    #根据级别生成前缀，如果级别不正确，直接返回错误
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

    #获取当前的打印级别
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

    #判断是否需要打印
    if [ ${logLevel} -lt ${curLevel} ]; then
	      return
    fi

   #打印到串口
   echo -e "[`date +%H`:`date +%M`:`date +%S`][${fileName}][${levelPrefix}] $2"


   #打印到文件，因为有些脚本运行时，串口被关闭了，如果超过一定大小，清空重新记录
   echo -e "[`date +%H`:`date +%M`:`date +%S`][${fileName}][${levelPrefix}] $2" >>${logFileName}
   if [ `ls -l ${logFileName} | awk '{print $5}'`  -gt 20480 ]; then
       cat /dev/null > ${logFileName}
   fi
}