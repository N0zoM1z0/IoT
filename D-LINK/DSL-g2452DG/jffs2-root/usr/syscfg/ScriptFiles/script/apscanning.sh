#!/bin/sh

. /usr/syscfg/mac.sh

# $1 -- apscanband=2g/5g

LOCK="/tmp/.apscan.lock"

if [ -f ${LOCK} ]; then
	exit
fi
touch ${LOCK}

for para in $*
do
	export $para
done

local data=""

parse_mtk_site_survey()
{
	iwpriv $ifname set SiteSurvey=1 > /dev/null 2>&1
	sleep 1
	iwpriv $ifname get_site_survey > ${tmpfile}

	## delete useless lines
	sed -i '1,2d' ${tmpfile}

	while read line
	do
		# 删除空白行
		if [ "$line" == "" ]; then
			continue
		fi

		channel=`echo ${line} | awk '{print $1}'` #获取channel
		local i=2
		local ssid=""

		# 循环找到BSSID
		while true
		do
			tmp=`echo ${line} | awk -v var=$i '{print $var}'` #获取channel后面的内容
			if [ `IsMac ${tmp}` -eq 1 ]; then
				break
			fi

			let i++
		done

		# 经过上面的循环, i指向BSSID
		if [ $i -eq 2 ]; then # i等于2表示ssid为空, ssid可以为空吗???
			ssid=""
			bssid=`echo ${line} | awk '{print $2}'`
			encrypt=`echo ${line} | awk '{print $3}'`
			signal=`echo ${line} | awk '{print $4}'`
			mode=`echo ${line} | awk '{print $5}'`
		else
			let i--
			ssid=`echo ${line} | cut -d ' ' -f 2-${i}`
			let i++
			bssid=`echo ${line} | awk -v var=$i '{print $var}'`
			let i++
			encrypt=`echo ${line} | awk -v var=$i '{print $var}'`
			let i++
			signal=`echo ${line} | awk -v var=$i '{print $var}'`
			let i++
			mode=`echo ${line} | awk -v var=$i '{print $var}'`
		fi

		## 将解析到的信号参数添加到数组中
		data=${data}"{SSID:\"${ssid}\",BSSID:\"${bssid}\",CH:\"${channel}\",Sig:\"${signal}\",Sec:\"${encrypt}\",Mode:\"${mode}\"},"
	done < ${tmpfile}
}

# function entry.
case "${apscanband}" in
	"2g" )
		parse_mtk_site_survey "2g"
		;;
	"5g" )
		parse_mtk_site_survey "5g"
		;;
esac

rm ${LOCK}

echo -n $data

