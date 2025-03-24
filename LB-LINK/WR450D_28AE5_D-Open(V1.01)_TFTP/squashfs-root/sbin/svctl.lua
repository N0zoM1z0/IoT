#!/usr/bin/lua

require("uci")
require("luci.sys")
local uci = require "luci.model.uci".cursor()
local sys = require "luci.controller.admin.system"

-- cpu info 
local system_type = luci.sys.exec("cat /proc/cpuinfo | grep 'system type' | awk -F' ' '{print $4}'")
-- wan ifc name
local wan_ifc
if string.find(system_type, "MT7621") then
    wan_ifc = "eth1"
elseif string.find(system_type, "MT7628") then
    wan_ifc = "eth0.2"
else
    wan_ifc = "eth1"
end

function dbg(info)
    if info ~= nil then
        luci.sys.exec(string.format("echo '%s' >> /tmp/dbg.log", info))
    else
        luci.sys.exec("echo 'dbg: para info is nil.' >> /tmp/dbg.log")
    end     

	return
end

function string_readln(str)
    local rv = { }

    if str ~= nil and str ~= '' then
        local ln, p1, p2
        local len = string.len(str)
        p1 = 1
   
        while true do
            p2 = string.find(str, "\n" , p1)
            if p2 ~= nil then
                if p2 > p1 then 
                    ln = string.sub(str, p1, p2 - 1 )
                else
                    ln = '' 
                end
                
                rv[#rv+1] = ln
                p1 = p2 + 1
   
                if p1 > len then
                    break
                end
            else
                if p1 < len then
                    ln = string.sub(str, p1, len )
                    rv[#rv+1] = ln
                end
                
                break
            end
        end
    end
    
    return rv
end

function get_ifc_info(ifc_name, item)
    local ln = ''
    local rv = ''
    local p1, p2, p3, p4

    if item == 'ip' then
        ln = string.trim(luci.sys.exec(string.format("ifconfig %s  |  grep  'inet addr:'", ifc_name)))
        if ln then p1, p2 = string.find(ln, 'inet addr:') end
    elseif item == 'ipv6_g' then
        ln = string.trim(luci.sys.exec(string.format("ifconfig %s  |  grep  'Scope:Global'", ifc_name)))
        if ln then p1, p2 = string.find(ln, 'inet6 addr:') end
    elseif item == 'ipv6_l' then
        ln = string.trim(luci.sys.exec(string.format("ifconfig %s  |  grep  'Scope:Link'", ifc_name)))
        if ln then p1, p2 = string.find(ln, 'inet6 addr:') end
    elseif item == 'mask' then
        ln = string.trim(luci.sys.exec(string.format("ifconfig %s  |  grep  'Mask:'", ifc_name)))
        if ln then p1, p2 = string.find(ln, 'Mask:') end
    else
        rv = ''
    end

    if p1 then
        p3, p4 = string.find(ln, ' ',  p2+2)
        if p3 then
            rv = string.sub(ln, p2+1, p3-1)
        else
            rv = string.sub(ln, p2+1, string.len(ln))
        end
    end

    return rv
end

function get_ipv6_pd()
    local rv = ""
    local linktype_v = uci.get("internet", "config", "mode")
    local ipv6_rt

    -- first, search br-lan 
    ipv6_rt = string.trim(luci.sys.exec("route -A inet6 | grep -e 'br-lan' | grep '::/' | grep '^2.*'"))
    if ipv6_rt ~= "" then
        local ipv6_rt_arr = string_readln(ipv6_rt)
        for i, v in pairs(ipv6_rt_arr) do  
            if v ~= '' then
                local pd_t, _ = v:match("^(%S+)%s+(.*)")
                if pd_t then rv = pd_t end
            end    
        end
    end

    if rv ~= "" then return rv end

    if linktype_v == 'routerdhcp' then
        ipv6_rt = string.trim(luci.sys.exec(string.format("route -A inet6 | grep -e '%s' | grep '::/' | grep '^2.*'", wan_ifc))) 
    elseif linktype_v == 'routerpppoe' then
        ipv6_rt = string.trim(luci.sys.exec("route -A inet6 | grep -e 'pppoe-wan' | grep '::/' | grep '^2.*'"))
    else
        ipv6_rt = "" 
    end

    if ipv6_rt ~= "" then                                                                               
        local ipv6_rt_arr = string_readln(ipv6_rt)                                                      
        for i, v in pairs(ipv6_rt_arr) do                                                               
            if v ~= '' then                                                                             
                local pd_t, _ = v:match("^(%S+)%s+(.*)")                                                
                if pd_t then rv = pd_t end                                                                 
            end                                                                                         
        end                                                                                             
    end 
    
    if rv == "" then
        local br_traverse_v = uci.get("network", "lan", "br_traverse_ipv6") or '0'
        if linktype_v == 'routerdhcp' and br_traverse_v == '1' then 
            local pd_rcd = string.trim(luci.sys.exec("cat /tmp/ipv6_pd")) 
            if pd_rcd ~= "" then
                rv = pd_rcd
            end
        end
    end  
 
    return rv
end

function rcd_ifc_info()
    local mode_v        = uci.get("internet", "config", "mode")
    local br_traverse_v = uci.get("network", "lan", "br_traverse_ipv6")
    if mode_v == "routerdhcp" and br_traverse_v == '1' then 
        for i = 0, 3 do 
            luci.sys.exec("echo  '----- rcd ip   ------'  >> /tmp/1.tmp ")        
         
            luci.sys.exec(string.format("brctl delif br-lan %s", wan_ifc))
            local eth_ip6addr_cur = get_ifc_info(wan_ifc, 'ipv6_g')
            local p = string.find(eth_ip6addr_cur, '2')
            if p and p == 2 then
                luci.sys.exec(string.format("echo '%s' > /tmp/eth_ip6addr", eth_ip6addr_cur))
                luci.sys.exec(string.format("echo '%s' > /tmp/ipv6_pd", get_ipv6_pd()))
                break
            else
                luci.sys.exec("ifconfig %s down; sleep 1; ifconfig %s up; sleep 5", wan_ifc, wan_ifc)
            end
        end
    end
end


function set_iptv_portmap()
    local port_dir = 0
    local portmap_enable, lan_ports, vlan_tag, p1, p2, p3, p4
    portmap_enable = string.trim(luci.sys.exec('uci get misc.iptv.enable'))
    lan_ports      = string.trim(luci.sys.exec('uci get misc.iptv.ports'))
    vlan_tag       = string.trim(luci.sys.exec('uci get misc.iptv.tag')) 
    
    if portmap_enable and lan_ports and vlan_tag and portmap_enable == "1" then
        if port_dir == 1 then
            p1, p2, p3, p4 = lan_ports:match("^(%d),(%d),(%d),(%d)")
        else
            p4, p3, p2, p1 = lan_ports:match("^(%d),(%d),(%d),(%d)")
        end        

        luci.sys.exec('sleep 20')
        luci.sys.exec(string.format('switch vlan set 0 %s %s%s%s%s1000', vlan_tag, p1, p2, p3, p4))
        vlan_tag = tonumber(vlan_tag)
        
        if p1 == "1" then
            luci.sys.exec(string.format('switch reg w 2014 10%03X', vlan_tag))
            luci.sys.exec('switch reg w 2010 81000000')
            luci.sys.exec('switch reg w 2004 ff0003')
        end
        
        if p2 == "1" then
            luci.sys.exec(string.format('switch reg w 2114 10%03X', vlan_tag))
            luci.sys.exec('switch reg w 2110 81000000')
            luci.sys.exec('switch reg w 2104 ff0003')
        end
        
        if p3 == "1" then
            luci.sys.exec(string.format('switch reg w 2214 10%03X', vlan_tag))
            luci.sys.exec('switch reg w 2210 81000000')
            luci.sys.exec('switch reg w 2204 ff0003')
        end
        
        if p4 == "1" then
            luci.sys.exec(string.format('switch reg w 2314 10%03X', vlan_tag))
            luci.sys.exec('switch reg w 2310 81000000')
            luci.sys.exec('switch reg w 2304 ff0003')
        end

        luci.sys.exec('switch reg w 2410 81000000')    
        luci.sys.exec(string.format('switch reg w 94 501%1X0001', tonumber(string.format('%s%s%s%s', p4, p3, p2, p1), 2)))
        luci.sys.exec('switch reg w 98 200')
        luci.sys.exec(string.format('switch reg w 90 80001%03X', vlan_tag))
    end    
        
    return
end


---------------------------------------------------- 
-- main process
---------------------------------------------------- 

if arg[1] == "rcd_ifc_info" then
    rcd_ifc_info()
end

if arg[1] == "set_iptv_portmap" then
    set_iptv_portmap()
end