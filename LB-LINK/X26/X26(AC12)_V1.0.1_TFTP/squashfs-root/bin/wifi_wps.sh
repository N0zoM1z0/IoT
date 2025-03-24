#!/bin/sh

iwpriv ra0 set WscStop=1 
iwpriv rai0 set WscStop=1 

sleep 1

iwpriv ra0 set WscConfMode=4
iwpriv ra0 set WscMode=2
iwpriv ra0 set WscConfStatus=2
iwpriv ra0 set WscGetConf=1

sleep 30

iwpriv ra0 set WscStop=1 
iwpriv rai0 set WscStop=1 

sleep 1

iwpriv rai0 set WscConfMode=4
iwpriv rai0 set WscMode=2
iwpriv rai0 set WscConfStatus=2
iwpriv rai0 set WscGetConf=1

sleep 30