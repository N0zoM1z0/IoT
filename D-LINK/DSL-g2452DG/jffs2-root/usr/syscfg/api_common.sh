#!/bin/sh


#名称：GetParentPath
#描述：获取节点的父节点path,一般是通过叶子获取object或者array的path
#输入：$1 - 子节点
#返回：成功 - 父节点, 失败 - 空
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


#名称：GetLeafValueFromObject
#描述：从整个object字符串中取出leaf的值
#输入：$1 - 整个object的path和值
#      $2 - leaf的名称
#返回：成功 - leaf的值, 失败 - 空
GetLeafValueFromObject()
{
    local objectValue=$1
    local leafName=$2
    local tmp=""

    if [ -z "${objectValue}" ]; then
        echo -n ""
        return
    fi

    # 删除leaf名字加=及其之前的内容,此时tmp为leaf的值及其后面的内容
    tmp=`echo ${objectValue#*${leafName}=}`
    if [ -z "${tmp}" ]; then
        echo -n ""
        return
    fi

    # 删除leaf的值后面的内容
    tmp=`echo ${tmp%% *}`

    echo -n "$tmp"
    return
}
