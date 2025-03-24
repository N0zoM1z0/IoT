--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008-2011 Jo-Philipp Wich <xm@subsignal.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.admin.system", package.seeall)

function index()
	entry({"admin", "system"}, alias("admin", "system", "system"), _("System"), 30).index = true
	entry({"admin", "system", "system"}, cbi("admin_system/system"), _("System"), 1)
	entry({"admin", "system", "clock_status"}, call("action_clock_status"))

	entry({"admin", "system", "admin"}, cbi("admin_system/admin"), _("Administration"), 2)

	if nixio.fs.access("/bin/opkg") then
		entry({"admin", "system", "packages"}, call("action_packages"), _("Software"), 10)
		entry({"admin", "system", "packages", "ipkg"}, form("admin_system/ipkg"))
	end

	entry({"admin", "system", "startup"}, form("admin_system/startup"), _("Startup"), 45)
	entry({"admin", "system", "crontab"}, form("admin_system/crontab"), _("Scheduled Tasks"), 46)

	if nixio.fs.access("/etc/config/fstab") then
		entry({"admin", "system", "fstab"}, cbi("admin_system/fstab"), _("Mount Points"), 50)
		entry({"admin", "system", "fstab", "mount"}, cbi("admin_system/fstab/mount"), nil).leaf = true
		entry({"admin", "system", "fstab", "swap"},  cbi("admin_system/fstab/swap"),  nil).leaf = true
	end

	if nixio.fs.access("/sys/class/leds") then
		entry({"admin", "system", "leds"}, cbi("admin_system/leds"), _("<abbr title=\"Light Emitting Diode\">LED</abbr> Configuration"), 60)
	end

	entry({"admin", "system", "flashops"}, call("action_flashops"), _("Backup / Flash Firmware"), 70)
	entry({"admin", "system", "flashops", "backupfiles"}, form("admin_system/backupfiles"))

	entry({"admin", "system", "reboot"}, call("action_reboot"), _("Reboot"), 90)
	
	entry({"admin", "system", "test"}, call("action_test"), nil).sysauth = false
    entry({"admin", "system", "ZeroSetting"}, call("action_ZeroSetting"), nil).sysauth = false
end

local uci = require "luci.model.uci".cursor()

function dbg(info)
    if info ~= nil then
        luci.sys.exec(string.format("echo '%s' >> /tmp/lpzlog.log", info))
    else
        luci.sys.exec("echo 'dbg(info): info is nil.' >> /tmp/dbg.log")
    end

    return
end


function exec_command(command)
  local file = assert(io.popen("PATH=/usr/bin:/usr/sbin:/bin:/sbin;"..command, 'r'))
  local output = file:read('*all')
  file:close()
  -- print(output)
  return output
end

function action_ZeroSetting()

	local pppoe_reg_suc;
	local get_wan_ip;

	local username = luci.http.formvalue("username") or nil            
	local userpwd = luci.http.formvalue("userpwd") or nil              
	local checkUserPasswd= luci.sys.user.checkpasswd(username, userpwd)
	
	if checkUserPasswd == false then                        
			luci.http.prepare_content("application/json")                    
			luci.http.write_json({ Result='Auth Failed' })                   
			return                                                           
	end
	
	local action = luci.http.formvalue("action") or nil                
    if action == 'GetRegStat' then
		dbg("into GetRegStat")
		pppoe_reg_suc=tonumber(uci:get("system", "Zero", "pppoe_reg_suc")) or 0
		if pppoe_reg_suc == 1 then
			fork_exec("uci set system.Zero.get_wan_ip=1; uci set system.Zero.pppoe_reg_suc=2; uci commit system");
			luci.http.prepare_content("application/json")                                  
			luci.http.write_json({ Result='Getting WAN Address' })
			return
		end
		get_wan_ip=tonumber(uci:get("system", "Zero", "get_wan_ip")) or 0
		if get_wan_ip == 1 then
			dbg("into get_wan_ip==1")
			--shengfen
			local area=uci:get("system", "Zero", "area") or 'JXI'
			--local nvram_if6Addr=exec_command("nvram get blink if6Server");
			--if nvram_if6Addr == "0.0.0.0" then

				province={
					['BEJ']='bj',['HUN']='hn',['TAJ']='tj',['HUB']='hb',['SHH']='sh',
					['GUD']='gd',['CHQ']='cq',['HAI']='hi',['HEB']='he',['SCH']='sc',
					['SHX']='sx',['GUI']='gz',['LIA']='ln',['YUN']='yn',['JIL']='jl',
					['SHA']='sn',['HLJ']='hl',['GAN']='gs',['JSU']='js',['QIH']='qh',
					['ZHJ']='zj',['ANH']='ah',['TIB']='xz',['FUJ']='fj',['NMG']='nm',
					['JXI']='jx',['GXI']='gx',['SHD']='sd',['NXA']='nx',['HEN']='ha',
					['XIN']='xj',['HKG']='null',['MAC']='null',['TAI']='null'

				}

				local domain_url="jtwlgl." .. province[area] .. ".chinamobile.com"
				fork_exec("nvram set blink if6Server " .. domain_url .. ";nvram commit;/etc/init.d/if6 restart");
			--end
			local if6Status=exec_command("ls -l /tmp | grep 'if6.status' | wc -l | tr -d '\n'");

			GetIf6statusNum=tonumber(uci:get("system", "Zero", "GetIf6statusNum")) or 0
		
			GetIf6statusNum=GetIf6statusNum + 1
			fork_exec("uci set system.Zero.GetIf6statusNum=" .. GetIf6statusNum .. ";uci commit system");
			if if6Status == "1" then
				dbg("into if6Status==1")
				luci.http.prepare_content("application/json")
				luci.http.write_json({ Result='Intelligent Platform Auth Succ' })
				return
			else
				dbg("into if6Status " .. GetIf6statusNum)
				if GetIf6statusNum > 10 then
					luci.http.prepare_content("application/json")
					luci.http.write_json({ Result='Getting Address Failed' })
				else
					luci.http.prepare_content("application/json")
					luci.http.write_json({ Result='Registering Intelligent Platform' })
				end
				return
			end
		end	
			
		local pppoe_reg= tonumber(exec_command("ifconfig pppoe-wan 2&> /dev/null | grep 'inet addr' | wc -l")) or 0
		GetRegNum=tonumber(uci:get("system", "Zero", "GetRegNum")) or 0
		dbg("pppoe_reg " .. pppoe_reg)
		if pppoe_reg == 0 and GetRegNum > 30 then
			luci.http.prepare_content("application/json")                                  
			luci.http.write_json({ Result='PPPOE Failed' })
			return
		elseif pppoe_reg == 1 then
			fork_exec("uci set system.Zero.pppoe_reg_suc=1;uci commit system");
		end	
		
		GetRegNum=GetRegNum + 1
		fork_exec("uci set system.Zero.GetRegNum=" .. GetRegNum .. ";uci commit system");
		luci.http.prepare_content("application/json")                                  
		luci.http.write_json({ Result='Setting Default Configuration' })              
	else     
		
		local area = luci.http.formvalue("area") or nil            
		if area then
			fork_exec("uci set system.Zero.area=" .. area);
		end																   
		fork_exec("uci set system.Zero.GetRegNum=0; uci set system.Zero.pppoe_reg_suc=0; uci set system.Zero.get_wan_ip=0; uci commit system")                                
		
		local isBridge = uci:get("system", "board", "type") or "bridge"
		if isBridge == 'bridge' then
			luci.http.prepare_content("application/json")   
			luci.http.write_json({ Result='Bridge Mode Failed' })
			return
		end
		                                                                
		local PPPOEuser = luci.http.formvalue("PPPOEuser") or nil        
		local PPPOEpassword = luci.http.formvalue("PPPOEpassword") or nil
		local area = luci.http.formvalue("area") or nil                  
		
		if PPPOEuser ~= '' and PPPOEuser ~= nil and PPPOEpassword ~= '' and PPPOEpassword ~= nil then
			fork_exec("uci set internet.config.mode=routerpppoe;uci set internet.config.id=" .. PPPOEuser .. ";uci set internet.config.pwd=" .. PPPOEpassword .."; uci commit internet; switch_internet_mode.sh")                                
			luci.http.prepare_content("application/json")                                        
			luci.http.write_json({ Result='Default Configuration Succ' }) 
		end                                                                                  
    end 
end


function init_test()
        fork_exec("echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables")
        fork_exec("echo 0 > /proc/sys/net/bridge/bridge-nf-call-ip6tables")
	fork_exec("/etc/init.d/if6 stop;/etc/init.d/convert stop;/etc/init.d/and stop")
	fork_exec("/etc/init.d/usr_flow stop;rmmod flow_manage;killall btnd")
end

function action_test()
    local name = luci.http.formvalue("name")
    if name == 'enable' then
	fork_exec("/usr/sbin/TestActionEna.sh")
    elseif name == 'g24all' then
	init_test()
	fork_exec("/usr/sbin/ixia_all.sh")
    elseif name == 'g5all' then
	init_test()
	fork_exec("/usr/sbin/ixia_g5all.sh")
    elseif name == 'g5clean' then
        init_test()
	fork_exec("/usr/sbin/ixia_g5clean.sh")
    elseif name == 'g5nei' then
        init_test()
	fork_exec("/usr/sbin/ixia_g5neighbor.sh")
    elseif name == 'g5same' then
        init_test()
	fork_exec("/usr/sbin/ixia_g5same.sh")
    elseif name == 'srrc_power' then
        fork_exec("/usr/sbin/srrc_Power.sh")
    elseif name == 'normal_power' then
        fork_exec("/usr/sbin/normal_Power.sh")
    elseif name == 'igmp' then
        fork_exec("igmpall_enable.sh; touch /tmp/igmp_enable")
    elseif name == 'telnet' then
        fork_exec("uci set system.sysFunc.telnet_ena=1;/etc/init.d/bl_telnet start")
    elseif name == 'convert' then
        fork_exec("/etc/init.d/convert start")
    elseif name == 'killapp' then
        init_test()
    end
    luci.http.prepare_content("application/json")
    luci.http.write_json({ msg='ok' })
end


function action_clock_status()
	local set = tonumber(luci.http.formvalue("set"))
	if set ~= nil and set > 0 then
		local date = os.date("*t", set)
		if date then
			luci.sys.call("date -s '%04d-%02d-%02d %02d:%02d:%02d'" %{
				date.year, date.month, date.day, date.hour, date.min, date.sec
			})
		end
	end

	luci.http.prepare_content("application/json")
	luci.http.write_json({ timestring = os.date("%c") })
end

function action_packages()
	local ipkg = require("luci.model.ipkg")
	local submit = luci.http.formvalue("submit")
	local changes = false
	local install = { }
	local remove  = { }
	local stdout  = { "" }
	local stderr  = { "" }
	local out, err

	-- Display
	local display = luci.http.formvalue("display") or "installed"

	-- Letter
	local letter = string.byte(luci.http.formvalue("letter") or "A", 1)
	letter = (letter == 35 or (letter >= 65 and letter <= 90)) and letter or 65

	-- Search query
	local query = luci.http.formvalue("query")
	query = (query ~= '') and query or nil


	-- Packets to be installed
	local ninst = submit and luci.http.formvalue("install")
	local uinst = nil

	-- Install from URL
	local url = luci.http.formvalue("url")
	if url and url ~= '' and submit then
		uinst = url
	end

	-- Do install
	if ninst then
		install[ninst], out, err = ipkg.install(ninst)
		stdout[#stdout+1] = out
		stderr[#stderr+1] = err
		changes = true
	end

	if uinst then
		local pkg
		for pkg in luci.util.imatch(uinst) do
			install[uinst], out, err = ipkg.install(pkg)
			stdout[#stdout+1] = out
			stderr[#stderr+1] = err
			changes = true
		end
	end

	-- Remove packets
	local rem = submit and luci.http.formvalue("remove")
	if rem then
		remove[rem], out, err = ipkg.remove(rem)
		stdout[#stdout+1] = out
		stderr[#stderr+1] = err
		changes = true
	end


	-- Update all packets
	local update = luci.http.formvalue("update")
	if update then
		update, out, err = ipkg.update()
		stdout[#stdout+1] = out
		stderr[#stderr+1] = err
	end


	-- Upgrade all packets
	local upgrade = luci.http.formvalue("upgrade")
	if upgrade then
		upgrade, out, err = ipkg.upgrade()
		stdout[#stdout+1] = out
		stderr[#stderr+1] = err
	end


	-- List state
	local no_lists = true
	local old_lists = false
	local tmp = nixio.fs.dir("/var/opkg-lists/")
	if tmp then
		for tmp in tmp do
			no_lists = false
			tmp = nixio.fs.stat("/var/opkg-lists/"..tmp)
			if tmp and tmp.mtime < (os.time() - (24 * 60 * 60)) then
				old_lists = true
				break
			end
		end
	end


	luci.template.render("admin_system/packages", {
		display   = display,
		letter    = letter,
		query     = query,
		install   = install,
		remove    = remove,
		update    = update,
		upgrade   = upgrade,
		no_lists  = no_lists,
		old_lists = old_lists,
		stdout    = table.concat(stdout, ""),
		stderr    = table.concat(stderr, "")
	})

	-- Remove index cache
	if changes then
		nixio.fs.unlink("/tmp/luci-indexcache")
	end
end

-- cwx modi
function file_exist(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return 1 else return 0 end
end

function action_flashops()
	local sys = require "luci.sys"
	local fs  = require "luci.fs"

	local upgrade_avail = nixio.fs.access("/lib/upgrade/platform.sh")
	local reset_avail   = os.execute([[grep '"rootfs_data"' /proc/mtd >/dev/null 2>&1]]) == 0

	local restore_cmd = "tar -xzC/ >/dev/null 2>&1"
	local backup_cmd  = "sysupgrade --create-backup - 2>/dev/null"
	local image_tmp   = "/tmp/firmware.img"

	local function image_supported()
		-- XXX: yay...
		return ( 0 == os.execute(
			". /lib/functions.sh; " ..
			"include /lib/upgrade; " ..
			"platform_check_image %q >/dev/null"
				% image_tmp
		) )
	end

	local function image_checksum()
		return (luci.sys.exec("md5sum %q" % image_tmp):match("^([^%s]+)"))
	end

	local function storage_size()
		local size = 0
		if nixio.fs.access("/proc/mtd") then
			for l in io.lines("/proc/mtd") do
				local d, s, e, n = l:match('^([^%s]+)%s+([^%s]+)%s+([^%s]+)%s+"([^%s]+)"')
				if n == "linux" or n == "firmware" then
					size = tonumber(s, 16)
					break
				end
			end
		elseif nixio.fs.access("/proc/partitions") then
			for l in io.lines("/proc/partitions") do
				local x, y, b, n = l:match('^%s*(%d+)%s+(%d+)%s+([^%s]+)%s+([^%s]+)')
				if b and n and not n:match('[0-9]') then
					size = tonumber(b) * 1024
					break
				end
			end
		end
		return size
	end

	local fp
	luci.http.setfilehandler(
		function(meta, chunk, eof)
			if not fp then
				if meta and meta.name == "image" then
					fp = io.open(image_tmp, "w")
				else
					fp = io.popen(restore_cmd, "w")
				end
			end
			if chunk then
				fp:write(chunk)
			end
			if eof then
				fp:close()
			end
		end
	)

  --fork_exec("sleep 2; /sbin/sysupgrade  /tmp/firmware.img")
   
	if luci.http.formvalue("backup") then
		--
		-- Assemble file list, generate backup
		--
		local reader = ltn12_popen(backup_cmd)
		luci.http.header('Content-Disposition', 'attachment; filename="backup-%s-%s.tar.gz"' % {
			luci.sys.hostname(), os.date("%Y-%m-%d")})
		luci.http.prepare_content("application/x-targz")
		luci.ltn12.pump.all(reader, luci.http.write)
	elseif luci.http.formvalue("restore") then
		--
		-- Unpack received .tar.gz
		--
		local upload = luci.http.formvalue("archive")
		if upload and #upload > 0 then
			luci.template.render("admin_system/applyreboot")
			luci.sys.reboot()
		end
	elseif luci.http.formvalue("image") or luci.http.formvalue("step") then
		--
		-- Initiate firmware flash
		--
		local step = tonumber(luci.http.formvalue("step") or 1)
		
		-- cwx modi
		step = 2
		
		if step == 1 then
			if image_supported() then
				luci.template.render("admin_system/upgrade", {
					checksum = image_checksum(),
					storage  = storage_size(),
					size     = nixio.fs.stat(image_tmp).size,
					keep     = (not not luci.http.formvalue("keep"))
				})
			else
				nixio.fs.unlink(image_tmp)
				luci.template.render("admin_system/flashops", {
					reset_avail   = reset_avail,
					upgrade_avail = upgrade_avail,
					image_invalid = true
				})
			end
		--
		-- Start sysupgrade flash
		--
		elseif step == 2 then
			--local keep = (luci.http.formvalue("keep") == "1") and "" or "-n"
			local keep = "-c"
			--luci.template.render("admin_system/applyreboot", {
			--	title = luci.i18n.translate("Flashing..."),
			--	msg   = luci.i18n.translate("The system is flashing now.<br /> DO NOT POWER OFF THE DEVICE!<br /> Wait a few minutes before you try to reconnect. It might be necessary to renew the address of your computer to reach the device again, depending on your settings."),
			--	addr  = (#keep > 0) and "192.168.1.1" or nil
			--})
			
			-- cwx modi
			-- luci.sys.exec("ifconfig ra0 down; ifconfig ra1 down; rmmod mt7628.ko; sleep 1;")
			luci.sys.exec("sync && echo 1 > /proc/sys/vm/drop_caches; sync && echo 2 > /proc/sys/vm/drop_caches; sync && echo 3 > /proc/sys/vm/drop_caches")
			luci.sys.exec("rm /sbin/update_data -rf")
			luci.sys.exec("/sbin/verify_img.sh")
                
            local resp_s
            if file_exist("/tmp/verify_OK") == 1 then
                resp_s = '{"result":0, "msg":"Verifing upgrade firmware, is correct."}'
                fork_exec("sleep 2; killall dropbear uhttpd; sleep 1; /sbin/sysupgrade %s %q" %{ keep, image_tmp })
            else
                resp_s = '{"result":1, "msg":"Verifing upgrade firmware, is error."}'
                --fork_exec("rm /tmp/firmware.img /tmp/openwrt_uImage -rf; insmod mt7628; sleep 2; wifi restart")
                fork_exec("rm /tmp/firmware.img /tmp/openwrt_uImage -rf")
            end
      
            luci.http.prepare_content("text/plain")
            luci.http.write(resp_s) 
		end
	elseif reset_avail and luci.http.formvalue("reset") then
		--
		-- Reset system
		--
		luci.template.render("admin_system/applyreboot", {
			title = luci.i18n.translate("Erasing..."),
			msg   = luci.i18n.translate("The system is erasing the configuration partition now and will reboot itself when finished."),
			addr  = "192.168.1.1"
		})
		fork_exec("killall dropbear uhttpd; sleep 1; mtd -r erase rootfs_data")
	else
		--
		-- Overview
		--
		luci.template.render("admin_system/flashops", {
			reset_avail   = reset_avail,
			upgrade_avail = upgrade_avail
		})
	end
end

function action_passwd()
	local p1 = luci.http.formvalue("pwd1")
	local p2 = luci.http.formvalue("pwd2")
	local stat = nil

	if p1 or p2 then
		if p1 == p2 then
			stat = luci.sys.user.setpasswd("root", p1)
		else
			stat = 10
		end
	end

  luci.template.render("admin_system/passwd", {stat=stat})
end

function action_reboot()
	local reboot = luci.http.formvalue("reboot")
	luci.template.render("admin_system/reboot", {reboot=reboot})
	if reboot then
        fork_exec("sleep 5;reboot")
	end
end

function fork_exec(command)
	local pid = nixio.fork()
	if pid > 0 then
		return
	elseif pid == 0 then
		-- change to root dir
		nixio.chdir("/")

		-- patch stdin, out, err to /dev/null
		local null = nixio.open("/dev/null", "w+")
		if null then
			nixio.dup(null, nixio.stderr)
			nixio.dup(null, nixio.stdout)
			nixio.dup(null, nixio.stdin)
			if null:fileno() > 2 then
				null:close()
			end
		end

		-- replace with target command
		nixio.exec("/bin/sh", "-c", command)
	end
end

function ltn12_popen(command)

	local fdi, fdo = nixio.pipe()
	local pid = nixio.fork()

	if pid > 0 then
		fdo:close()
		local close
		return function()
			local buffer = fdi:read(2048)
			local wpid, stat = nixio.waitpid(pid, "nohang")
			if not close and wpid and stat == "exited" then
				close = true
			end

			if buffer and #buffer > 0 then
				return buffer
			elseif close then
				fdi:close()
				return nil
			end
		end
	elseif pid == 0 then
		nixio.dup(fdo, nixio.stdout)
		fdi:close()
		fdo:close()
		nixio.exec("/bin/sh", "-c", command)
	end
end
