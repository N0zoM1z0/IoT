#!/bin/sh
level=`echo ${QUERY_STRING} | cut -d = -f 3`
	case "$level" in
                "1")
                        log_filename="/data/log/emerg.txt"
                        ;;
                "2")
                        log_filename="/data/log/alert.txt"
                        ;;
                "3")
                        log_filename="/data/log/crit.txt"
                        ;;
                "4")
                        log_filename="/data/log/err.txt"
                        ;;
                "5")
                        log_filename="/data/log/warning.txt"
                        ;;
                "6")
                        log_filename="/data/log/notice.txt"
                        ;;
                "7")
                        log_filename="/data/log/info.txt"
                        ;;
                "8")
                        log_filename="/data/log/debug.txt"
                        ;;
                *)
                        ;;
	esac

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""
if [ "${log_filename}" == "" ]; then
	exit 1
fi

cat ${log_filename}