#!/bin/sh


#���ƣ�GetParentPath
#��������ȡ�ڵ�ĸ��ڵ�path,һ����ͨ��Ҷ�ӻ�ȡobject����array��path
#���룺$1 - �ӽڵ�
#���أ��ɹ� - ���ڵ�, ʧ�� - ��
GetParentPath()
{
    local childPath=$1
    local parentPath=""

    if [ -z "${childPath}" ]; then
        echo -n ""
        return
    fi

    parentPath=`echo "${childPath%.*}"`
    if [ -z "${parentPath}" ]; then
        echo -n ""
        return
    fi

    parentPath="${parentPath}."
    echo -n "$parentPath"
    return
}


#���ƣ�GetLeafValueFromObject
#������������object�ַ�����ȡ��leaf��ֵ
#���룺$1 - ����object��path��ֵ
#      $2 - leaf������
#���أ��ɹ� - leaf��ֵ, ʧ�� - ��
GetLeafValueFromObject()
{
    local objectValue=$1
    local leafName=$2
    local tmp=""

    if [ -z "${objectValue}" ]; then
        echo -n ""
        return
    fi

    # ɾ��leaf���ּ�=����֮ǰ������,��ʱtmpΪleaf��ֵ������������
    tmp=`echo ${objectValue#*${leafName}=}`
    if [ -z "${tmp}" ]; then
        echo -n ""
        return
    fi

    # ɾ��leaf��ֵ���������
    tmp=`echo ${tmp%% *}`

    echo -n "$tmp"
    return
}
