#!/bin/sh

local id=`echo ${QUERY_STRING} | cut -d = -f 3 | cut -d ? -f 1`
local path=`echo ${QUERY_STRING} | cut -d = -f 4 | cut -d ? -f 1`

getSubNodes()
{
	ls -F /mnt/$path | grep '/$' > /tmp/subdirs
	local lines=`cat /tmp/subdirs | wc -l`

	local i=1
	local dirs="["
	if [ "$lines" == "0" ]; then
		dirs="[]"
		echo -n $dirs
		return
	fi
	while [ $i -le $lines ]
	do
		local dirName=`sed -n "${i}p" /tmp/subdirs | awk -F '/' '{print $1}'`
		if [ $i -lt $lines ]; then
			subdirs="{id:${id}${i}, pId:${id}, name:\"$dirName\", isParent:true, expanded:0}, "
		else
			subdirs="{id:${id}${i}, pId:${id}, name:\"$dirName\", isParent:true, expanded:0}]"
		fi
		dirs=${dirs}${subdirs}
		i=`expr $i + 1`
	done
	echo -n $dirs
}
local nodeDirs=`getSubNodes`
# response to client
echo "Pragma: no-cache\n"                                        
echo "Cache-control: no-cache\n"
echo "Content-type: text/xml"               
echo ""                                                
echo "pId=$id; subNodes=$nodeDirs;"
