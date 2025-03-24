#!/bin/sh


#���ƣ� to_xml
#��������a=b����ʽ��ת����xml��ʽ����ŵ�ָ�����ļ��У����͵�Ӧ�ó���Ϊcfgcmd get�Ľ����
#���룺$1 - a=b��ʽ���ַ�������
#      $2 - xml��ʽ��ŵ��ļ�
#���أ���
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