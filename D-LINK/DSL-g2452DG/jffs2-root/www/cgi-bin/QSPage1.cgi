#!/bin/sh 
provider=`echo "${QUERY_STRING}" | cut -d ? -f 2`
nowprovi=`cfgcmd get InternetGatewayDevice.DeviceInfo.X_TRI_Provider`
if [ ${nowprovi} != ${provider} ] 
then
    cfgcmd set InternetGatewayDevice.DeviceInfo.X_TRI_Provider ${provider}
fi

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

