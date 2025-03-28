#!/bin/sh
TMPSSLPATH="/tmp/"
TMPSSLFILE="ssl.tgz"
SSLKEYFILE="server.key"
SSLPEMFILE="server.pem"
TMPSSL=$TMPSSLPATH$TMPSSLFILE
TMPKEY=$TMPSSLPATH$SSLKEYFILE
TMPPEM=$TMPSSLPATH$SSLPEMFILE
BUILDDATE="/etc/config/builddaytime"
TOTALDAYS=24800
SSLDAYS=7300

if [ -f /usr/sbin/openssl ]; then
	if [ ! -f $TMPKEY -o ! -f $TMPPEM ]; then
		cd $TMPSSLPATH
		devconf get -s -f $TMPSSL
		if [ "$?" = "0" ]; then
			tar zxf $TMPSSL
		fi

		if [ ! -f $TMPKEY -o ! -f $TMPPEM ]; then
			YEAR=`cut -f 1 -d ' ' $BUILDDATE`
			MONTH=`cut -f 2 -d ' ' $BUILDDATE`
			DAY=`cut -f 3 -d ' ' $BUILDDATE`
			if [ "x$YEAR" = "x" -o "x$MONTH" = "x" -o "x$DAY" = "x" ]; then
				YEAR=2016
				MONTH=01
				DAY=01
			fi
			DAYSNOW=`expr \( $YEAR - 1970 \) \* 365 + $MONTH \* 30 + $DAY`
			DAYSMAX=`expr $DAYSNOW + 20 \* 365`
			if [ "$DAYSMAX" -gt "$TOTALDAYS" ]; then
				SSLDAYS=`expr $TOTALDAYS - $DAYSNOW`
			fi
			date -s "$YEAR-$MONTH-$DAY 00:00"
			openssl req -new -newkey rsa:2048 -days $SSLDAYS -sha256 -nodes -x509 -subj "/C=TW/ST=Taiwan/L=Taipei/O=D-Link Corporation/OU=D-Link WRPD/CN=General Root CA/emailAddress=webmaster@localhost" -keyout $TMPKEY -out $TMPPEM -config /etc/openssl.cnf
			tar zcf $TMPSSL $SSLKEYFILE $SSLPEMFILE
			devconf put -f $TMPSSL -s
		fi

		rm -f $TMPSSL
	fi
fi

if [ ! -f $TMPKEY -o ! -f $TMPPEM ]; then
	ln -s /etc/stunnel.key $TMPKEY
	ln -s /etc/stunnel_cert.pem $TMPPEM
fi
