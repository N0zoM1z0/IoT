#!/bin/sh

PROFTPD_FILE=/var/proftpd.conf
#DEFAULTDIR=`mount | grep "/mnt/" | sed 's/^.*mnt/\/mnt/g' | sed 's/ type.*$//g' | sed -n '1p'`
DEFAULTDIR=`cfgcmd get InternetGatewayDevice.Services.ServiceFTP.RootDIR`
echo "DEFAULTDIR:"$DEFAULTDIR""

Usage()
{
	echo "insufficient arguments!"
	echo "Usage: $0 <target> [option]..."
	echo "       $0 server <ServerName> <IP> <TcpPort> <MaxConn>"
	echo "       $0 user <AddDir> <ReName> <ReMove> <Read> <Write> <Download> <Upload>"
	exit 0
}

setFtpServer()
{
	echo "ServerName $SERVER_NAME" > $PROFTPD_FILE
	echo "DefaultAddress $IP_ADDR" >> $PROFTPD_FILE
	echo "ServerType  standalone" >> $PROFTPD_FILE
	echo "DefaultServer on" >> $PROFTPD_FILE
	echo "AuthUserFile /etc/passwd" >> $PROFTPD_FILE
	#echo "AuthGroupFile /etc/group" >> $PROFTPD_FILE 
	mkdir -p /var/log
	echo "SystemLog /var/log/proftpd.log" >> $PROFTPD_FILE

	echo "Port $TCP_PORT" >> $PROFTPD_FILE

	echo "Umask 022" >> $PROFTPD_FILE
		
	echo "MaxInstances $MAX_CONN" >> $PROFTPD_FILE

	#echo "User  admin" >> $PROFTPD_FILE
	#echo "Group admin" >> $PROFTPD_FILE

	echo "TimesGMT off" >> $PROFTPD_FILE
	echo "MaxClients 200" >> $PROFTPD_FILE
	echo "MaxClientsPerHost 5" >> $PROFTPD_FILE

	echo "DefaultRoot $DEFAULTDIR" >> $PROFTPD_FILE
	echo "RootLogin on" >> $PROFTPD_FILE
}


setFtpUser()
{
   echo "<Directory $DEFAULTDIR>"  >> $PROFTPD_FILE

	echo  "AllowOverwrite on" >> $PROFTPD_FILE

	##########INITIALIZATION#################
	echo "<Limit MKD RNFR DELE WRITE RETR STOR DIRS>" >> $PROFTPD_FILE
	echo "  DenyAll" >> $PROFTPD_FILE
	echo "</Limit>" >> $PROFTPD_FILE

	##########CREATE#################
	if [ "$MKDCAP" == "0" ]; then
		echo "<Limit MKD>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi
	##########RENAME#################
	if [ "$RNFRCAP" == "0" ]; then
		echo "<Limit RNFR>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi
	##########DELETE#################
	if [ "$DELECAP" == "0" ]; then
		echo "<Limit DELE>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
		echo "<Limit RMD>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi
	##########WRITE#################
	if [ "$WRITECAP" == "0" ]; then
		echo "<Limit WRITE>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi

	##########UPLOAD#################
	if [ -n "$UPLOADUSERS" ]; then
		echo "<Limit RETR>" >> $PROFTPD_FILE
		echo "  AllowUser $UPLOADUSERS" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	else
		echo "<Limit RETR>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi

	##########DOWNLOAD#################
	if [ -n "$DOWNLOADUSERS" ]; then
		echo "<Limit STOR>" >> $PROFTPD_FILE
		echo "  AllowUser $DOWNLOADUSERS" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	else
		echo "<Limit STOR>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi

	##########DIRLIST#################
	if [ -n "$DIRLISTUSERS" ]; then
		echo "<Limit DIRS>" >> $PROFTPD_FILE
		echo "  AllowUser $DIRLISTUSERS" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	else
		echo "<Limit DIRS>" >> $PROFTPD_FILE
		echo "  DenyAll" >> $PROFTPD_FILE
		echo "</Limit>" >> $PROFTPD_FILE
	fi
   echo "</Directory>"  >> $PROFTPD_FILE
}

case "$1" in
	"server")
		if [ ! -n "$5" ]; then
			Usage	
		else
			SERVER_NAME="$2"
			IP_ADDR="$3"
			TCP_PORT="$4"
			MAX_CONN="$5"
			setFtpServer
		fi
		;;
	"user")
		if [ ! -n "$8" ]; then
			Usage	
		else
			MKDCAP=$2
			RNFRCAP=$3
			DELECAP=$4
			READCAP=$5
			WRITECAP=$6
			UPLOADUSERS=$7
			DOWNLOADUSERS=$8
			DIRLISTUSERS=$9
			echo "MKDCAP=$MKDCAP"
			echo "RNFRCAP=$RNFRCAP"
			echo "READCAP=$READCAP"
			echo "WRITECAP=$WRITECAP"
			echo "UPLOADUSERS=$UPLOADUSERS"
			echo "DOWNLOADUSERS=$DOWNLOADUSERS"		
			echo "DIRLISTUSERS=$DIRLISTUSERS"		
			setFtpUser
		fi
		;;
	"anonymous")
		if [ ! -n "$2" ]; then
			MAXCLIENTS=10
		else
			MAXCLIENTS=$2
		fi

		echo "<Anonymous ~ftp>" >> $PROFTPD_FILE
		echo  "User		ftp" >> $PROFTPD_FILE
		echo  "UserAlias	anonymous" >> $PROFTPD_FILE
		echo  "MaxClients			10" >> $PROFTPD_FILE
		echo  "<Limit WRITE>" >> $PROFTPD_FILE
		echo  "DenyAll" >> $PROFTPD_FILE
		echo  "</Limit>" >> $PROFTPD_FILE
		echo "</Anonymous>" >> $PROFTPD_FILE
		;; 
	*)
		Usage	
		;;
esac
