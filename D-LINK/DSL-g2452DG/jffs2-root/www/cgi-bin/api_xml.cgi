#!/bin/sh


#名称： to_xml
#描述：将a=b的形式，转换成xml格式，存放到指定的文件中，典型的应用场景为cfgcmd get的结果。
#输入：$1 - a=b形式的字符串数组
#      $2 - xml格式存放的文件
#返回：无
to_xml()
{
	local filePath=${2}
	local name=""
	local value=""
	echo "<?xml version=\"1.0\"?>" > $filePath
	echo "<body>" >> $filePath
    for i in ${1}; do
		echo "<name>${i%=*}</name>" >> ${filePath}
        echo "<value>${i##*=}</value>" >> ${filePath}
    done
	echo "</body>" >> $filePath
}