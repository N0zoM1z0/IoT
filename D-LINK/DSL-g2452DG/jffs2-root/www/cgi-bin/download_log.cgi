#!/bin/sh
level=`echo ${QUERY_STRING} | cut -d = -f 2`
	case "$level" in
		"1")
                        log_filename="/data/log/emerg.txt"
			prefix=Emergency
                        ;;
                "2")
                        log_filename="/data/log/alert.txt"
			prefix=Alert
                        ;;
                "3")
                        log_filename="/data/log/crit.txt"
			prefix=Critical
                        ;;
                "4")
                        log_filename="/data/log/err.txt"
			prefix=Error
                        ;;
                "5")
                        log_filename="/data/log/warning.txt"
			prefix=Warning
                        ;;
                "6")
                        log_filename="/data/log/notice.txt"
			prefix=Notice
                        ;;
                "7")
                        log_filename="/data/log/info.txt"
			prefix=Informational
                        ;;
                "8")
                        log_filename="/data/log/debug.txt"
			prefix=Debug
                        ;;
                *)
                        ;;
	esac

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: application/octet-stream"
echo "Content-Transfer-Encoding: binary"
echo "Content-Disposition: attachment; filename=\"${prefix}.txt\""
echo ""

cat ${log_filename}
