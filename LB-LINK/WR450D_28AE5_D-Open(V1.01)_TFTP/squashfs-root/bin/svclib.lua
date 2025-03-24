#!/usr/bin/lua

require("uci")
require("luci.sys")
local uci = require "luci.model.uci".cursor()
local sys = require "luci.controller.admin.system"

function dbg(info)
    if info ~= nil then
        luci.sys.exec(string.format("echo '%s' >> /tmp/dbg.log", info))
    else
        luci.sys.exec("echo 'dbg: para info is nil.' >> /tmp/dbg.log")
    end     
	  
		return
end

function set_limitlist()
    -- step 1: don't care blackwhitelist_enable, just do deny_dev_list action.
    local p1, p2, p3, p4
    local deny_dev_list = uci.get("misc", "limit", "dw_limit")
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        p2 = 0 
        while true do
            p1, p2 = string.find(deny_dev_list, "(.-);" , p2 + 1)
            
            if p1 ~= nil then
                local deny_info  = string.sub(deny_dev_list, p1, p2 )
                local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
        
                if deny_t == '1' then
                    luci.sys.exec(string.format('iptables -D INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -D FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -I INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -I FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                else
                    luci.sys.exec(string.format('iptables -D INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -D FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                    
                    local dwlimit_s = tostring(math.modf(dwlimit_t*2/3))
                    local uplimit_s = tostring(math.modf(uplimit_t*2/3))
                    
                    if dwlimit_s ~= '0' then
                        luci.sys.exec(string.format('iptables -D FORWARD -d %s -j DROP', ip_t))
                        luci.sys.exec(string.format('iptables -D FORWARD -d %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, dwlimit_s, dwlimit_s))
                        luci.sys.exec(string.format('iptables -I FORWARD -d %s -j DROP', ip_t))
                        luci.sys.exec(string.format('iptables -I FORWARD -d %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, dwlimit_s, dwlimit_s))
                    else
                        luci.sys.exec(string.format('iptables -D FORWARD -d %s -j DROP', ip_t))
                    end
                  
                    if uplimit_s ~= '0' then
                        luci.sys.exec(string.format('iptables -D FORWARD -s %s -j DROP', ip_t))
                        luci.sys.exec(string.format('iptables -D FORWARD -s %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, uplimit_s, uplimit_s))
                        luci.sys.exec(string.format('iptables -I FORWARD -s %s -j DROP', ip_t))
                        luci.sys.exec(string.format('iptables -I FORWARD -s %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, uplimit_s, uplimit_s))
                    else
                        luci.sys.exec(string.format('iptables -D FORWARD -s %s -j DROP', ip_t))
                    end
                end    
            else
                break
            end
        end
    end
    return
end


function set_hwnat()
    local hwnat_enable_v
    
    hwnat_enable_v = string.trim(luci.sys.exec('uci get system.performance_mode.enabled'))
    luci.sys.exec("mkdir -p /tmp/mtk/")
    
    if hwnat_enable_v == '1' then
       luci.sys.exec("hwnat-enable.sh >> /tmp/mtk/hwnat.log 2>&1")
    else
       luci.sys.exec("hwnat-disable.sh >> /tmp/mtk/hwnat.log 2>&1")
    end
end


function init_svc()
    set_limitlist()
    set_hwnat()
    
    return
end


---------------------------------------------------- 
-- main process
---------------------------------------------------- 
if arg[1] == 'init_svc' then
    init_svc()
end
