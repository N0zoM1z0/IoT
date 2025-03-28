#!/usr/bin/lua
-- Alternative for OpenWrt's /sbin/wifi.
-- Copyright Not Reserved.
-- Hua Shao <nossiac@163.com>

function mt7628_up(devname)
	local nixio = require("nixio")
	local mtkwifi = require("mtkwifi")
	nixio.syslog("debug", "mt7628_up called!")

	-- 7628 is always the 1st card and it takes "ra" and "apcli" prefix.
	-- for multi-bssid, we must bring up ra0 first. ra0 will create ra1, ra2,...
	if not mtkwifi.exists("/sys/class/net/ra0") then
		nixio.syslog("err", "unable to detect ra0, abort!")
		return
	end
	os.execute("ifconfig ra0 up")

	-- then we bring up ra1, ra2,...
	for _,vif in mtkwifi.__spairs(string.split(mtkwifi.read_pipe("ls /sys/class/net"), "\n"))
	do
		if string.match(vif, "ra%d+") then
			os.execute("ifconfig "..vif.." up")
			local brvifs = mtkwifi.__trim(mtkwifi.read_pipe("uci get network.lan.ifname"))
			if not string.match(brvifs, vif) and not string.find(vif, "apcli") then
			brvifs = brvifs.." "..vif
			nixio.syslog("debug", "add "..vif.." into lan")
			os.execute("uci set network.lan.ifname=\""..brvifs.."\"")
			os.execute("uci commit")
			os.execute("ubus call network.interface.lan add_device \"{\\\"name\\\":\\\""..vif.."\\\"}\"")
			end
		-- else nixio.syslog("debug", "skip "..vif..", prefix not match "..pre[1])
		end
	end

	-- then we bring up apcli0, apcli1,...
	for _,vif in mtkwifi.__spairs(string.split(mtkwifi.read_pipe("ls /sys/class/net"), "\n"))
	do
		if string.match(vif, "apcli%d+") then
			os.execute("ifconfig "..vif.." up")
		end
	end

	os.execute(" rm -rf /tmp/mtk/wifi/mt7628*.need_reload")
end

function mt7628_down(devname)
	local nixio = require("nixio")
	local mtkwifi = require("mtkwifi")
	nixio.syslog("debug", "mt7628_down called!")

	for _,vif in mtkwifi.__spairs(string.split(mtkwifi.read_pipe("ls /sys/class/net"), "\n"))
	do
		if string.match(vif, "apcli%d+") then
			os.execute("ifconfig "..vif.." down")
		end
	end

	for _,vif in mtkwifi.__spairs(string.split(mtkwifi.read_pipe("ls /sys/class/net"), "\n"))
	do
		if string.match(vif, "ra%d+") then
			os.execute("ifconfig "..vif.." down")
			local brvifs = mtkwifi.read_pipe("uci get network.lan.ifname")
			if string.match(brvifs, vif) then
			brvifs = mtkwifi.__trim(string.gsub(brvifs, vif, ""))
			nixio.syslog("debug", "remove "..vif.." from lan")
			os.execute("uci set network.lan.ifname=\""..brvifs.."\"")
			os.execute("uci commit")
			os.execute("ubus call network.interface.lan remove_device \"{\\\"name\\\":\\\""..vif.."\\\"}\"")
			end
		-- else nixio.syslog("debug", "skip "..vif..", prefix not match "..pre[1])
		end
	end

	os.execute(" rm -rf /tmp/mtk/wifi/mt7628*.need_reload")
end

function mt7628_reload(devname)
	local nixio = require("nixio")
	local mtkwifi = require("mtkwifi")
	nixio.syslog("debug", "mt7628_reload called!")
	-- merge mapddat file to dat
	local profile = mtkwifi.search_dev_and_profile()[devname]
	local tmpdat = "/etc/map/"..string.match(profile, "([^/]+)\.dat")..".tmpdat"
	if mtkwifi.exists(tmpdat) then
		mtkwifi.update_profile(profile, tmpdat)
		os.remove(tmpdat)
	end
	mt7628_down()
	os.execute("rmmod mt7628")
	os.execute("modprobe mt7628")
	mt7628_up()
end

function mt7628_reset(devname)
	local nixio = require("nixio")
	local mtkwifi = require("mtkwifi")
	nixio.syslog("debug", "mt7628_reset called!")
	if mtkwifi.exists("/rom/etc/wireless/mt7628/") then
		os.execute("rm -rf /etc/wireless/mt7628/")
		os.execute("cp -rf /rom/etc/wireless/mt7628/ /etc/wireless/")
		mt7628_reload()
	else
		nixio.syslog("debug", "/rom"..profile.." missing, unable to reset!")
	end
end

function mt7628_status(devname)
	return wifi_common_status()
end

function mt7628_hello(devname)
    print("hello from mt7628, devname="..devname)
end

function mt7628_detect(devname)
	local nixio = require("nixio")
	local mtkwifi = require("mtkwifi")
	nixio.syslog("debug", "mt7628_detect called!")

	for _,dev in ipairs(mtkwifi.get_all_devs()) do
		print([[
config wifi-device ]]..dev.maindev.."\n"..[[
	option type mt7628
	option vendor ralink
]])
		for _,vif in ipairs(dev.vifs) do
			print([[
config wifi-iface
	option device ]]..dev.maindev.."\n"..[[
	option ifname ]]..vif.vifname.."\n"..[[
	option network lan
	option mode ap
	option ssid ]]..vif.__ssid.."\n")
		end
	end
end
