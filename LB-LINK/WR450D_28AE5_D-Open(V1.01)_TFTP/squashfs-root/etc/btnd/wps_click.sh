echo "gpio btn wps!"
touch /tmp/on_button

iwpriv ra0 set WscConfMode=7
iwpriv ra0 set WscMode=2
iwpriv ra0 set WscGetConf=1

iwpriv rai0 set WscConfMode=7
iwpriv rai0 set WscMode=2
iwpriv rai0 set WscGetConf=1






