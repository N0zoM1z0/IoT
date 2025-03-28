#!/bin/sh

MINIDLNA_CONF_FIFE=/var/minidlna.conf

DlnaServerConfiguration()
{
	#touch "$MINIDLNA_CONF_FIFE"
	#chmod 777 "$MINIDLNA_CONF_FIFE"
	
	# port for HTTP (descriptions, SOAP, media transfer) traffic
	#port=8200
	echo "port=8200" > $MINIDLNA_CONF_FIFE
	# network interfaces to serve, comma delimited
	#network_interface=br0
	echo "network_interface=$IF" >>	$MINIDLNA_CONF_FIFE

	# set this to the directory you want scanned.
	# * if have multiple directories, you can have multiple media_dir= lines
	# * if you want to restrict a media_dir to a specific content type, you
	#   can prepend the type, followed by a comma, to the directory:
	#   + "A" for audio  (eg. media_dir=A,/home/jmaggard/Music)
	#   + "V" for video  (eg. media_dir=V,/home/jmaggard/Videos)
	#   + "P" for images (eg. media_dir=P,/home/jmaggard/Pictures)
	#media_dir=/media
	echo "media_dir=$MEDIAPATH" >>	$MINIDLNA_CONF_FIFE

	# set this if you want to customize the name that shows up on your clients
	#friendly_name=DLNA Server
	echo "friendly_name=$DLNASERVER" >>	$MINIDLNA_CONF_FIFE

	# set this if you would like to specify the directory where you want MiniDLNA to store its database and album art cache
	#db_dir=/var/cache/minidlna

	# set this if you would like to specify the directory where you want MiniDLNA to store its log file
	#log_dir=/var/log

	# set this to change the verbosity of the information that is logged
	# each section can use a different level: off, fatal, error, warn, info, or debug
	#log_level=general,artwork,database,inotify,scanner,metadata,http,ssdp,tivo=warn

	# this should be a list of file names to check for when searching for album art
	# note: names should be delimited with a forward slash ("/")
	album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg/AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg/Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg
	echo "album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg/AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg/Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg" >>	$MINIDLNA_CONF_FIFE
	
	# set this to no to disable inotify monitoring to automatically discover new files
	# note: the default is yes
	#inotify=yes
	echo "inotify=yes" >>	$MINIDLNA_CONF_FIFE

	# set this to yes to enable support for streaming .jpg and .mp3 files to a TiVo supporting HMO
	#enable_tivo=no
	echo "enable_tivo=no" >>	$MINIDLNA_CONF_FIFE

	# set this to strictly adhere to DLNA standards.
	# * This will allow server-side downscaling of very large JPEG images,
	#   which may hurt JPEG serving performance on (at least) Sony DLNA products.
	#strict_dlna=no
	echo "strict_dlna=no" >>	$MINIDLNA_CONF_FIFE

	# default presentation url is http address on port 80
	#presentation_url=http://www.mylan/index.php

	# notify interval in seconds. default is 895 seconds.
	#notify_interval=900
	echo "notify_interval=900" >>	$MINIDLNA_CONF_FIFE

	# serial and model number the daemon will report to clients
	# in its XML description
	#serial=12345678
	#model_number=1
	echo "serial=$SERIALNUMBER" >>	$MINIDLNA_CONF_FIFE
	echo "model_number=001" >>	$MINIDLNA_CONF_FIFE

	# specify the path to the MiniSSDPd socket
	#minissdpdsocket=/var/run/minissdpd.sock

	# use different container as root of the tree
	# possible values:
	#   + "." - use standard container (this is the default)
	#   + "B" - "Browse Directory"
	#   + "M" - "Music"
	#   + "V" - "Video"
	#   + "P" - "Pictures"
	# if you specify "B" and client device is audio-only then "Music/Folders" will be used as root
	#root_container=.
}

DlnaServerConfigurationHelp()
{
	echo "DlnaServerConfigurationHelp"
	echo "Please feel free send questions to triductor.com.support immediately!"
}

if [ "$1" == "minidlna" ]; then
	IF=$2
	MEDIAPATH=$3
	DLNASERVER=$4
	SERIALNUMBER=$5
	DlnaServerConfiguration
else
	DlnaServerConfigurationHelp
fi

