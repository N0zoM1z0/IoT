--[[
Main Lua Interface for web system of MTK762x + Openwrt platform.
chengweixin 2019.8
]]--


module("luci.controller.admin.opsw", package.seeall)  
  
function index()
    local page
    
    entry({"admin", "opsw"}, alias("admin", "opsw", "control"), _("main --"), 30).index = true  
    entry({"admin", "opsw", "control"}, template("opsw/main"), _("main ~~"), 1)  
    
    page = entry({"admin", "opsw", "features.html"}, alias("admin", "features", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "manage.html"}, alias("admin", "manage", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "setup.html"}, alias("admin", "setup", "control"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "wizard.html"}, alias("admin", "wizard", "control"), nil)
    page.dependant = false
    page.sysauth = false
    page.sysauth_authenticator = "htmlauth"
    
    page = entry({"admin", "opsw", "mobwizard.html"}, alias("admin", "mobwizard", "control"), nil) 
    page.dependant = false
    page.sysauth = false
    page.sysauth_authenticator = "htmlauth"
    
    page = entry({"admin", "opsw", "mobindex.html"}, alias("admin", "mobindex", "control"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "associated_devs"}, call("get_assoc_devs"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "deny_dev_list"}, call("get_deny_dev_list"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "deny_dev"}, call("apply_deny_dev"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "dev_speed_limit"}, call("apply_dev_speed_limit"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "dev_rename"}, call("apply_dev_rename"), nil)
    page.leaf = true

    -- the login entry is special, don't need authentication.
    page = entry({"admin", "opsw", "login"}, call("login"), _("main ~~"), 2)  
    page.dependant = false
    page.sysauth = false
    page.sysauth_authenticator = "htmlauth"

    page = entry({"admin", "opsw", "logout"}, call("logout"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "wizard_apply"}, call("apply_wizard"), nil)
    page.leaf = true
 
    page = entry({"admin", "opsw", "wan_info"}, call("get_wan_info"), nil)
    page.leaf = true 
    page = entry({"admin", "opsw", "lan_info"}, call("get_lan_info"), nil)
    page.leaf = true 
    
    page = entry({"admin", "opsw", "wan_stat"}, call("get_wan_stat"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wan_link_type"}, call("get_wan_link_type"), nil)
    page.leaf = true
 
    page = entry({"admin", "opsw", "wan_setting"}, call("get_wan_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wan_dhcp_setting_apply"}, call("apply_wan_dhcp_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wan_pppoe_setting_apply"}, call("apply_wan_pppoe_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wan_static_setting_apply"}, call("apply_wan_static_setting"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "total_wifi_setting"}, call("get_total_wifi_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "total_wifi_setting_apply"}, call("apply_total_wifi_setting"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "guest_wifi_setting"}, call("get_guest_wifi_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "guest_wifi_setting_apply"}, call("apply_guest_wifi_setting"), nil)
    page.leaf = true
   
    page = entry({"admin", "opsw", "2g_wifi_setting"}, call("get_2g_wifi_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_wifi_setting_apply"}, call("apply_2g_wifi_setting"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "2g_wifi_enable"}, call("get_2g_wifi_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_wifi_enable_apply"}, call("apply_2g_wifi_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "5g_wifi_setting"}, call("get_5g_wifi_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_wifi_setting_apply"}, call("apply_5g_wifi_setting"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "5g_wifi_enable"}, call("get_5g_wifi_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_wifi_enable_apply"}, call("apply_5g_wifi_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "wifi_enable"}, call("get_wifi_top_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wifi_enable_apply"}, call("apply_wifi_top_enable"), nil)
    page.leaf = true
 
    page = entry({"admin", "opsw", "os_time"}, call("get_os_time"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "post_a_msg"}, call("WebService"), nil)
    page.leaf = true  
  
    page = entry({"admin", "opsw", "lan_setting"}, call("get_lan_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "lan_setting_apply"}, call("apply_lan_setting"), nil)
    page.leaf = true
    
    -- network setting
    page = entry({"admin", "opsw", "network_setting"}, call("get_network_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "network_setting_apply"}, call("apply_network_setting"), nil)
    page.leaf = true
    
    -- qos
    page = entry({"admin", "opsw", "qos_setting"}, call("get_qos_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "qos_setting_apply"}, call("apply_qos_setting"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "mac_clone"}, call("get_mac_clone"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "mac_clone_apply"}, call("apply_mac_clone"), nil)
    page.leaf = true
    
    -- No.24  multi_ssid
    page = entry({"admin", "opsw", "2g_multi_ssid"}, call("get_2g_multi_ssid"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_multi_ssid_apply"}, call("apply_2g_multi_ssid"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "5g_multi_ssid"}, call("get_5g_multi_ssid"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_multi_ssid_apply"}, call("apply_5g_multi_ssid"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "2g_channel"}, call("get_2g_channel"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_channel_apply"}, call("apply_2g_channel"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "5g_channel"}, call("get_5g_channel"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_channel_apply"}, call("apply_5g_channel"), nil)
    page.leaf = true
        
    page = entry({"admin", "opsw", "2g_wps"}, call("get_2g_wps"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_wps_apply"}, call("apply_2g_wps"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "5g_wps"}, call("get_5g_wps"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_wps_apply"}, call("apply_5g_wps"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "wps_pbc_apply"}, call("apply_wps_pbc"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "2g_roaming"}, call("get_2g_roaming"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_roaming_apply"}, call("apply_2g_roaming"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "5g_roaming"}, call("get_5g_roaming"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_roaming_apply"}, call("apply_5g_roaming"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "gw_mode"}, call("get_gw_mode"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "route_mode_apply"}, call("apply_route_mode"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "repeater_mode"}, call("get_repeater_mode"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "repeater_mode_apply"}, call("apply_repeater_mode"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "led_enable"}, call("get_led_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "led_enable_apply"}, call("apply_led_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "fw_version"}, call("get_fw_version"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "fw_upgrade"}, call("fw_upgrade"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "restore_factory_setting"}, call("restore_factory_setting"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "reboot"}, call("reboot_sys"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "modify_password"}, call("modify_password"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "ping_tracert"}, call("get_ping_tracert_result"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "ping_tracert_apply"}, call("apply_ping_tracert"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "ssh_enable"}, call("get_ssh_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "ssh_enable_apply"}, call("apply_ssh_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "sysinfo"}, call("get_sysinfo"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "syslog"}, call("get_syslog"), nil)
    page.leaf = true

    page = entry({"admin", "opsw", "dmz"}, call("dmz"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "dmz_apply"}, call("apply_dmz"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "hwnat"}, call("hwnat"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "hwnat_apply"}, call("apply_hwnat"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "2g_global_enable"}, call("get_2g_global_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "2g_global_enable_apply"}, call("apply_2g_global_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "5g_global_enable"}, call("get_5g_global_enable"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "5g_global_enable_apply"}, call("apply_5g_global_enable"), nil)
    page.leaf = true
    
    page = entry({"admin", "opsw", "ipv6_setting"}, call("get_ipv6_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "ipv6_setting_apply"}, call("apply_ipv6_setting"), nil)
    page.leaf = true
    
    -- iptv port mapping
    page = entry({"admin", "opsw", "iptv_portmap"}, call("get_iptv_portmap"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "iptv_portmap_apply"}, call("apply_iptv_portmap"), nil)
    page.leaf = true
    
    -- port forwarding
    page = entry({"admin", "opsw", "get_forward_cfg"}, call("get_forward_data"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "set_forward_cfg"}, call("apply_forward_data"), nil)
    page.leaf = true    
    
    -- url filter
    page = entry({"admin", "opsw", "get_url_filter"}, call("get_url_filter_data"), nil)   
    page.leaf = true
    page = entry({"admin", "opsw", "set_url_filter"}, call("set_url_filter_data"), nil)   
    page.leaf = true    
    
    -- vpn pptp/l2tp
    page = entry({"admin", "opsw", "get_pptp_l2tp_data_cfg"}, call("get_vpn_data"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "set_pptp_l2tp_data_cfg"}, call("apply_vpn_data"), nil)
    page.leaf = true
    
    -- static route
    page = entry({"admin", "opsw", "static_route"}, call("get_static_route"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "static_route_apply"}, call("apply_static_route"), nil)
    page.leaf = true
    
    -- ddns
    page = entry({"admin", "opsw", "ddns"}, call("get_ddns"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "ddns_apply"}, call("apply_ddns"), nil)
    page.leaf = true
    
    -- time
    page = entry({"admin", "opsw", "time"}, call("get_time"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "time_apply"}, call("apply_time"), nil)
    page.leaf = true
    
    -- firewall advance
    page = entry({"admin", "opsw", "firewall_advance"}, call("get_firewall_advance"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "firewall_advance_apply"}, call("apply_firewall_advance"), nil)
    page.leaf = true
    
    -- firewall rule (ipv4)
    page = entry({"admin", "opsw", "firewall_rule"}, call("get_firewall_rule"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "firewall_rule_apply"}, call("apply_firewall_rule"), nil)
    page.leaf = true
    
    -- acs setting
    page = entry({"admin", "opsw", "acs_setting"}, call("get_acs_setting"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "acs_setting_apply"}, call("apply_acs_setting"), nil)
    page.leaf = true
    
    -- get / set language
    page = entry({"admin", "opsw", "getLanguage"}, call("get_language"), nil)
    page.leaf = true
    page.dependant = false
    page.sysauth = false
    page.sysauth_authenticator = "htmlauth"

    page = entry({"admin", "opsw", "setLanguage"}, call("set_language"), nil)
    page.leaf = true
    page.dependant = false
    page.sysauth = false
    page.sysauth_authenticator = "htmlauth"
    
end  


------------------------------------------------------------------------- 
-- global variable and macro definition
-------------------------------------------------------------------------

-- macro definition
local SW_DUMP_CNT_MAX = 3
local WIFI_2G    = 0
local WIFI_5G    = 1
local ENABLE_ON  = 1
local ENABLE_OFF = 0
local PPPOE_IFC  = 'pppoe-wan'
local DEV_2G     = string.trim(luci.sys.exec("uci get wireless.@wifi-device[0].type"))
local DEV_5G     = string.trim(luci.sys.exec("uci get wireless.@wifi-device[1].type"))

-- global variable 
local uci = require "luci.model.uci".cursor()
local sw_dump_cnt = SW_DUMP_CNT_MAX
local assoc_dev_list = { }

-- macro definition
-- cwx tmp
--local FW_VER = luci.sys.exec("cat /etc/fwVer | tr -d '\n'")
--local HW_VER = luci.sys.exec("nvram get blink hwver | tr -d '\n'")
local FW_VER = "v1.01"
local HW_VER = "v1.2"

-- cpu info 
local system_type = luci.sys.exec("cat /proc/cpuinfo | grep 'system type' | awk -F' ' '{print $4}'")
-- wan ifc name
local wan_ifc, lan_ifc
if string.find(system_type, "MT7621") then
    wan_ifc = "eth1"
elseif string.find(system_type, "MT7628") then
    wan_ifc = "eth0.2"
else
    wan_ifc = "eth1"
end
lan_ifc = "br-lan"

-- wan at port0 or port 4.
local wan_at_port = 4

function get_devmodel_type()
    local wif_5g_exist = string.trim(luci.sys.exec("ls /lib/modules/3.10.108 | grep 'mt76x2e.ko'"))
    
    if wif_5g_exist and wif_5g_exist ~= "" then
        -- 8M Dual band, model:DIR-822F
        return 1
    else
        -- Single band
        local flash_size = string.trim(luci.sys.exec("cat /proc/mtd  | grep 'ALL' | awk '{print $2}' | tr -d '\n'"))
        if flash_size == "00800000" then
            -- 8M Single band, model:DIR-F1151.
            return 0
        elseif flash_size == "00400000" then
            -- 4M Single band, model:DIR-F1150.
            return 2
        else
            return 0
        end
    end
end

local MODEL_TYPE = get_devmodel_type()

function dbg(info)
    if info ~= nil then
        luci.sys.exec(string.format("echo '%s' >> /tmp/dbg.log", info))
    else
        luci.sys.exec("echo 'dbg(info): info is nil.' >> /tmp/dbg.log")
    end     
    
    return
end


function cvt_char(str)
    if str then
        str = str:gsub('%$', '\\$')
        str = str:gsub('%`', '\\`')
    end

    return str
end


function set_login_user(user)
    luci.sys.exec(string.format('echo %s > /tmp/login_user', user))
    return
end


function get_login_user()
    local dsp = require "luci.dispatcher"
    local login_user = dsp.context.authuser 
    local def_user = 'CMCCAdmin'
    
    if login_user ~= nil then
        return login_user
    else
        return def_user
    end
end


function chg_wzd_flg()
    local sys = require "luci.controller.admin.system"
    -- old method.
    -- touch '/etc/wzd_finish.flg', delete '/tmp/wzd_running.flg'.
    -- sys.fork_exec('touch /etc/wzd_finish.flg; rm /tmp/wzd_running.flg -rf')
     
    -- change to set nvram item of firstLogin: firstLogin == 0, need wizard; firstLogin == 1, not need wizard. 
    -- cwx: for mt7628
    -- sys.fork_exec('nvram set blink firstLogin 1; nvram commit; rm /tmp/wzd_running.flg -rf') 
end


function get_os_time()
    luci.http.prepare_content("application/json")
    luci.http.write_json({ timestring = os.date("%c") })
    
    return
end

function file_exist(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return 1 else return 0 end
end


function get_factory_wan_mac()
    local mac, b1, b2, b3, b4, b5, b6

    mac = string.trim(luci.sys.exec("mac r lan"))
    b1, b2, b3, b4, b5, b6 = mac:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
    b6 =  string.format('%x', tonumber(b6, 16) + 1)
    mac = string.format("%s:%s:%s:%s:%s:%s", b1, b2, b3, b4, b5, b6 )

    return mac
end


function is_wan_connected()
    return string.trim(luci.sys.exec("cat /tmp/wan_connected"))
end


function string_cut(str, p1, p2)
    local t1, t2, len
    
    t1 = ''
    t2 = ''
    len = string.len(str)
    
    if p1 > 1 then
        t1 = string.sub(str, 1, p1-1 )
    end
    
    if p2 < len then
        t2 = string.sub(str, p2+1, len)
    end
    
    return string.format("%s%s", t1, t2)
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


function del_route(ifc)
    -- delete needless route info.
    local sys = require "luci.controller.admin.system"  
    local route_s = string.trim(luci.sys.exec(string.format('route | grep %s', ifc)))
    local route_arr = string_readln(route_s)
    
    for i, v in pairs(route_arr) do  
        if v ~= '' then
            local dest_t, gateway_t, netmask_t, _, _, _, _, iface_t = v:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
            if dest_t == 'default' then
                --luci.sys.exec(string.format('route del default dev %s', ifc))
                sys.fork_exec(string.format('route del default dev %s', ifc))
            else
                --luci.sys.exec(string.format('route del -net %s netmask %s dev %s', dest_t, netmask_t, ifc))
                sys.fork_exec(string.format('route del -net %s netmask %s dev %s', dest_t, netmask_t, ifc))
            end        
        end    
    end
        
    return
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


------------------------------------------------------------------------- 
-- original get_dhcp_leases_common():  without andlink support.
------------------------------------------------------------------------- 
--[[
local function get_dhcp_leases_common(family)
  local rv = { }
  local nfs = require "nixio.fs"
  local leasefile = "/var/dhcp.leases"
  
  assoc_dev_list = { }
  
  uci:foreach("dhcp", "dnsmasq",
    function(s)
      if s.leasefile and nfs.access(s.leasefile) then
        leasefile = s.leasefile
        return false
      end
    end)
  
  local deny_dev_list = ''
  deny_dev_list = uci.get("misc", "limit", "dw_limit")
  
  local fd = io.open(leasefile, "r")
  if fd then
    if sw_dump_cnt == SW_DUMP_CNT_MAX then
        luci.sys.exec("switch dump > /tmp/switch.dump")
    end
    
    sw_dump_cnt = sw_dump_cnt - 1
    if sw_dump_cnt <= 0 then
        sw_dump_cnt = SW_DUMP_CNT_MAX
    end    
        
    while true do
      local ln = fd:read("*l")
      if not ln then
        break
      else
        local ts, mac, ip, name, duid = ln:match("^(%d+) (%S+) (%S+) (%S+) (%S+)")
        local type_v, up_speed_v, down_speed_v, up_limit_v, down_limit_v, link_v
        
        local mac_s = mac:gsub(':', '')
        local find_s1 = ''
        local find_s2 = ''
        find_s1 = string.trim(luci.sys.exec(string.format("cat /tmp/etc_ro/dev_info | grep '%s'", mac)))
        find_s2 = string.trim(luci.sys.exec(string.format("cat /tmp/switch.dump | grep '%s'", mac_s)))
        
        if find_s2 ~= '' then
            find_s2 = string.trim(string.sub(find_s2, 4, 11))
            if (find_s2 == ':   1---') or (find_s2 == ':   -1--') or (find_s2 == ':   --1-') or (find_s2 == ':   ---1') then
                type_v = 0
                link_v = 0
            else
                type_v = 1
                link_v = 1
            end
        else
            type_v = 1
            link_v = 1
        end
        
        -- To find real-time up/down speed.            
        if find_s1 ~= '' then
            local _, _, _, up_bps_t, down_bps_t, _, _, _, _, _, _, _ = find_s1:match("^(%d+),(%S+),(%S+),(%d+),(%d+),(%S+),(%S+),(%S+),(%S+),(%S+),(%S+),(%S+)")
            up_speed_v   = up_bps_t
            down_speed_v = down_bps_t
        else
            up_speed_v   = 0
            down_speed_v = 0
        end    
            
        -- To find speed limit data.
        if deny_dev_list ~= '' and deny_dev_list ~= nil then
            local p1, p2
            p1 = string.find(deny_dev_list, mac)
            if p1 ~= nil then
                p1, p2 = string.find(deny_dev_list, "(.-);" , p1) 
                local deny_info = string.sub(deny_dev_list, p1, p2)
                local _, _, _, _, _, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
            
                up_limit_v   = uplimit_t
                down_limit_v = dwlimit_t
            else
                up_limit_v   = 0
                down_limit_v = 0
            end
        else
            up_limit_v   = 0
            down_limit_v = 0
        end
        
        if ts and mac and ip and name and duid then
            if family == 4 and not ip:match(":") then
                assoc_dev_list[#assoc_dev_list+1] = {
                    mac        = mac,
                    type       = type_v,
                    --time     = os.difftime(tonumber(ts) or 0, os.time()),
                    time       =  12*3600 - (tonumber(ts) - os.time()),
                    ip         = ip,
                    hostname   = (name ~= "*") and name,
                    up_speed   = up_speed_v,
                    down_speed = down_speed_v, 
                    up_limit   = up_limit_v,
                    down_limit = down_limit_v,
                    link       = link_v
                }
            elseif family == 6 and ip:match(":") then
                -- ipv6 
            end
        end
      end
    end
    fd:close()
  end
  
  -- find static IP or other devices 
  local fd = io.open("/tmp/etc_ro/dev_info", "r")
  if fd then
    while true do
      local ln = fd:read("*l")
      if not ln then
        break
      else
        local idx_t, mac_t, ip_t, up_bps_t, down_bps_t, up_total_t, down_total_t, comp_t, devmode_t, b1_t, b2_t, b3_t = ln:match("^(%d+),(%S+),(%S+),(%d+),(%d+),(%S+),(%S+),(%S+),(%S+),(%d+),(%S+),(%S+)")
        local type_v, up_speed_v, down_speed_v, up_limit_v, down_limit_v, link_v
        local in_list = 0
        
        for i, v in pairs(assoc_dev_list) do  
            if v.mac == mac_t then
                in_list = 1
                break
            end    
        end
        
        -- The device in dev_info is static IP, add to the assoc_dev_list.
        if in_list == 0 then
            local mac_s = mac_t:gsub(':', '')
            local find_s = ''
            find_s = string.trim(luci.sys.exec(string.format("cat /tmp/switch.dump | grep '%s'", mac_s)))
        
            if find_s ~= '' then
                find_s = string.trim(string.sub(find_s, 4, 11))
                if (find_s == ':   1---') or (find_s == ':   -1--') or (find_s == ':   --1-') or (find_s == ':   ---1') then
                    type_v = 0
                    link_v = 0
                else
                    type_v = 1
                    link_v = 1
                end
            else
                type_v = 1
                link_v = 1
            end
        
            up_speed_v   = up_bps_t
            down_speed_v = down_bps_t
            
            -- To find speed limit data.
            if deny_dev_list ~= '' and deny_dev_list ~= nil then
                local p1, p2
                
                p1 = string.find(deny_dev_list, mac_t)
                if p1 ~= nil then
                    p1, p2 = string.find(deny_dev_list, "(.-);" , p1) 
                    local deny_info = string.sub(deny_dev_list, p1, p2)
                    local _, _, _, _, _, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
                
                    up_limit_v   = uplimit_t
                    down_limit_v = dwlimit_t
                else
                    up_limit_v   = 0
                    down_limit_v = 0
                end
            else
                up_limit_v   = 0
                down_limit_v = 0
            end
        
            assoc_dev_list[#assoc_dev_list+1] = {
                mac  = mac_t,
                type = type_v,
                time = b1_t,
                ip   = ip_t,
                hostname   = string.format('%s-%s', comp_t, devmode_t),
                up_speed   = up_speed_v,
                down_speed = down_speed_v, 
                up_limit   = up_limit_v,
                down_limit = down_limit_v,
                link       = link_v
            }
        end
      end  
    end
    
    fd:close()
  end
         
  return assoc_dev_list
end
]]--


function get_denydev_hostname(mac)
    local deny_dev_list = uci.get("misc", "rename", "rn_list")
        
    if deny_dev_list ~= nil and deny_dev_list ~= '' then
        local p1, p2
        p1 = string.find(deny_dev_list, mac)
    
        if p1 == nil then
            return nil
        else
            -- find mac in deny_dev_list
            p1, p2 = string.find(deny_dev_list, "(.-);" , p1)
            if p1 ~= nil then
                local deny_info  = string.sub(deny_dev_list, p1, p2 )
                local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
                
                return hostname_t
            end   
        end
    else
        return nil
    end

end


function is_wired_dev(mactbl_s)
    local mactbl = string_readln(mactbl_s)
    local rv = 1
    
    for i, v in pairs(mactbl) do  
        local find_s = string.trim(string.sub(v, 4, 13))
        if (find_s == ':   1--- -') or (find_s == ':   -1-- -') or (find_s == ':   --1- -') or 
           (find_s == ':   ---1 -') or (find_s == ':   ---- 1') then
            -- is a wired device.
            rv = 0
            break
        end    
    end
    
    return rv
end

function get_dev_type(devmode_s)
    local type_v

    if devmode_s == 'PC' then
        type_v = 0
    elseif devmode_s == 'Android' then
        type_v = 1 
    elseif devmode_s == 'iPhone' then
        type_v = 2 
    elseif devmode_s == 'TV' then
        type_v = 3 
    elseif devmode_s == 'Router' then
        type_v = 4
    elseif devmode_s == 'unknown' then
        type_v = 5
    else
        type_v = 5
    end

    return type_v
end


function is_denied_dev(mac)
    local MacFilterEnable_v, MacFilterPolicy_v, MacFilterEntries_v
    local rv = 0
    
    MacFilterEnable_v  = uci.get("andlink", "MacFilter", "MacFilterEnable")
    MacFilterPolicy_v  = uci.get("andlink", "MacFilter", "MacFilterPolicy")
    if MacFilterEnable_v ~= nil and MacFilterEnable_v == '1' then
        MacFilterEntries_v = uci.get("andlink", "MacFilter", "MacFilterEntries")
    
        if MacFilterPolicy_v == '0' then
            -- blacklist mode
            if MacFilterEntries_v then
                if string.find(string.lower(MacFilterEntries_v), mac) then rv = 1 else rv = 0 end
            else
                rv = 0
            end
        else
            -- whitelist mode
            if MacFilterEntries_v then
                if string.find(string.lower(MacFilterEntries_v), mac) then rv = 0 else rv = 1 end
            else
                rv = 1
            end
        end
    else
        -- web filter, there is only blacklist.
        MacFilterEntries_v = uci.get("andlink", "MacFilter", "WebFilterEntries")
        
        -- blacklist mode
        if MacFilterEntries_v then
            if string.find(string.lower(MacFilterEntries_v), mac) then rv = 1 else rv = 0 end
        else
            rv = 0
        end
    end    
  
    return rv 
end   


------------------------------------------------------------------------- 
-- current get_dhcp_leases_common():  with andlink support.
------------------------------------------------------------------------- 
local function get_dhcp_leases_common(family)
  local nfs = require "nixio.fs"
  local rv = { }
  assoc_dev_list = { }
  
  local deny_dev_list = ''
  deny_dev_list = uci.get("misc", "limit", "dw_limit")
  
--[[
  if sw_dump_cnt == SW_DUMP_CNT_MAX then
      luci.sys.exec("switch dump > /tmp/switch.dump")
  end
    
  sw_dump_cnt = sw_dump_cnt - 1
  if sw_dump_cnt <= 0 then
      sw_dump_cnt = SW_DUMP_CNT_MAX
  end
]]--
  
  -- find static IP or other devices 
  local fd = io.open("/tmp/etc_ro/dev_info", "r")
  if fd then
    while true do
      local ln = fd:read("*l")
      if not ln then
        break
      else
        local idx_t, mac_t, ip_t, up_bps_t, down_bps_t, up_total_t, down_total_t, comp_t, devmode_t, b1_t, b2_t, b3_t = 
        ln:match("^(%d+),(%S+),(%S+),(%d+),(%d+),(%S+),(%S+),(.*),(.*),(%d+),(%S+),(%S+)")

        local type_v, up_speed_v, down_speed_v, up_limit_v, down_limit_v, qos_pri_v, link_v, hostname_v
        local mac_s = mac_t:gsub(':', '')
        
        -- The device in dev_info, is not denied, add to the assoc_dev_list.
        if is_denied_dev(mac_s) == 0 then
            local find_s = ''
            
            -- find_s = string.trim(luci.sys.exec(string.format("cat /tmp/switch.dump | grep '%s'", mac_s)))
            -- if find_s ~= '' then link_v = is_wired_dev(find_s) else link_v = 1 end
            if b3_t == '0' then link_v = 0 else link_v = 1 end
            
            type_v = get_dev_type(devmode_t)
            up_speed_v   = up_bps_t
            down_speed_v = down_bps_t
            
            local new_hostname = get_denydev_hostname(mac_t)
            if new_hostname then
                hostname_v = new_hostname
            else    
                hostname_v = comp_t
            end
            
            -- To find speed limit data.
            if deny_dev_list ~= '' and deny_dev_list ~= nil then
                local p1, p2
                
                p1 = string.find(deny_dev_list, mac_t)
                if p1 ~= nil then
                    p1, p2 = string.find(deny_dev_list, "(.-);" , p1) 
                    local deny_info = string.sub(deny_dev_list, p1, p2)
                    local _, _, _, _, _, uplimit_t, dwlimit_t, qos_pri_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+),(%d+);")
                
                    up_limit_v   = uplimit_t
                    down_limit_v = dwlimit_t
                    qos_pri_v    = qos_pri_t
                else
                    up_limit_v   = 0
                    down_limit_v = 0
                    qos_pri_v    = 0
                end
            else
                up_limit_v   = 0
                down_limit_v = 0
                qos_pri_v    = 0
            end
            
            assoc_dev_list[#assoc_dev_list+1] = {
                mac  = mac_t,
                type = type_v,
                time = b1_t,
                ip   = ip_t,
                hostname   = hostname_v,
                up_speed   = up_speed_v,
                down_speed = down_speed_v, 
                up_limit   = up_limit_v,
                down_limit = down_limit_v,
                link       = link_v,
                qos_pri    = qos_pri_v
            }
        end
      end  
    end
    
    fd:close()
  end
         
  return assoc_dev_list
end


function get_assoc_devs()
    luci.http.prepare_content("application/json")
    luci.http.write('{"list":')
    luci.http.write_json(get_dhcp_leases_common(4))
    luci.http.write('}')
    
    return
end


------------------------------------------------------------------------- 
-- original get_deny_dev_list():  without andlink support.
------------------------------------------------------------------------- 
--[[
function get_deny_dev_list()
    local rv = { }
    local list_v
    local p1, p2, p3, p4
    
    list_v = ''
    list_v = uci.get("misc", "blackwhitelist", "deny_dev_list")
    if list_v ~= '' and list_v ~= nil then
        p2 = 0 
        while true do
            p1, p2 = string.find(list_v, "(.-);" , p2 + 1)
            
            if p1 ~= nil then
                local deny_info  = string.sub(list_v, p1, p2)
                local mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%S+),(%S+);")
                
                if deny_v == '1' then
                    rv[#rv+1] = {
                        mac      = mac_v,
                        type     = type_v,
                        hostname = hostname_v
                    }
                end
            else
                break
            end
        end
    end
  
    luci.http.prepare_content("application/json")
    luci.http.write('{"list":')
    luci.http.write_json(rv)
    luci.http.write('}')

    return
end
]]--


function format_mac(mac)
    local mac_s = ''
    
    if mac ~= nil and mac ~= '' then
        local len = string.len(mac)
        -- eg: '001111334455'
        if len == 12 then
            local b1, b2, b3, b4, b5, b6
            b1 = string.sub(mac, 1, 2) 
            b2 = string.sub(mac, 3, 4) 
            b3 = string.sub(mac, 5, 6) 
            b4 = string.sub(mac, 7, 8) 
            b5 = string.sub(mac, 9, 10) 
            b6 = string.sub(mac, 11, 12) 
            mac_s = string.format('%s:%s:%s:%s:%s:%s', b1, b2, b3, b4, b5, b6)
        end
    end    
            
    return mac_s
end

------------------------------------------------------------------------- 
-- current get_deny_dev_list():  with andlink support.
-------------------------------------------------------------------------
function get_deny_dev_list()
    local rv = { }
    local list_v = ''
    local p1, p2, p3, p4
    
    local MacFilterEnable_v, MacFilterPolicy_v, MacFilterEntries_v, WebFilterEntries_v 
    MacFilterEnable_v  = uci.get("andlink", "MacFilter", "MacFilterEnable")
    MacFilterPolicy_v  = uci.get("andlink", "MacFilter", "MacFilterPolicy")
    MacFilterEntries_v = uci.get("andlink", "MacFilter", "MacFilterEntries")
    WebFilterEntries_v = uci.get("andlink", "MacFilter", "WebFilterEntries")
    
    if MacFilterEnable_v == nil or MacFilterEnable_v == '0' then
            -- Andlink filter enable = 0, then enable web filter and there is only blacklist.  
            -- just backlist mode, show deny_dev_list.
            list_v = WebFilterEntries_v
            if list_v ~= nil and list_v ~= '' then
                list_v = string.format('%s,', list_v)
        
                p2 = 0 
                while true do
                    p1, p2 = string.find(list_v, "(.-)," , p2 + 1)
                    if p1 ~= nil then
                        local deny_info  = string.sub(list_v, p1, p2)
                        local mac_v, hostname_v = deny_info:match("^(%S+)/(%S+),")
                        local type_v, find_s
                    
                        mac_v = format_mac(mac_v)
                        mac_v = string.lower(mac_v)
                        find_s = string.trim(luci.sys.exec(string.format("cat /tmp/etc_ro/dev_info | grep '%s'", mac_v)))
                        if find_s ~= '' then
                            local _, _, _, _, _, _, _, comp_t, devmode_t, _, _, _ = find_s:match("^(%d+),(%S+),(%S+),(%d+),(%d+),(%S+),(%S+),(%S+),(%S+),(%d+),(%S+),(%S+)")
                            if devmode_t then
                                type_v = get_dev_type(devmode_t)
                            else
                                type_v = 5
                            end        
                        else
                            type_v = 5
                        end
                
                        local new_hostname = get_denydev_hostname(mac_v)
                        if new_hostname then
                            hostname_v = new_hostname
                        end    
        
                        rv[#rv+1] = {
                            mac      = mac_v,
                            type     = type_v,
                            hostname = hostname_v
                        }
                    else
                        break
                    end
                end
            end
    else
        -- Andlink filter enable = 1, then disable web filter and show nothing.   
    end
    
    luci.http.prepare_content("application/json")
    luci.http.write('{"list":')
    luci.http.write_json(rv)
    luci.http.write('}')

    return
end


function get_dev_idx(mac)
    local idx = 0
    
    for i, v in pairs(assoc_dev_list) do  
        if v.mac == mac then
            idx = i
            break
        end    
    end

    return idx
end


------------------------------------------------------------------------- 
-- original apply_deny_dev():  without andlink support.
------------------------------------------------------------------------- 
--[[
function apply_deny_dev()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    -- post data error, return. 
    if rcv_succ == 0 then
        return
    end
    
    local deny_dev_list = ''
    deny_dev_list = uci.get("misc", "limit", "dw_limit")
        
    local deny_info
    local idx = 0
    local mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v
            
    get_dhcp_leases_common(4)    
    idx = get_dev_idx(rcv_json["mac"])
    
    if idx > 0 then
        mac_v      = assoc_dev_list[idx].mac
        ip_v       = assoc_dev_list[idx].ip 
        type_v     = assoc_dev_list[idx].type
        hostname_v = assoc_dev_list[idx].hostname
        deny_v     = tostring(rcv_json["disabled"])
        uplimit_v  = assoc_dev_list[idx].up_limit
        dwlimit_v  = assoc_dev_list[idx].down_limit
    end
    
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        local p1, p2
        p1 = string.find(deny_dev_list, mac_v)
    
        if p1 == nil then
            -- new entry
            if idx > 0 then
                deny_info  = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
                deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
                
                uci.set("misc", "blackwhitelist", "deny_dev_list", deny_dev_list)
                uci.commit("misc")
            end
        else
            -- already in deny_dev_list
            -- replace deny_info
            p1, p2 = string.find(deny_dev_list, "(.-);" , p1)
    
            if p1 ~= nil then
               local deny_info  = string.sub(deny_dev_list, p1, p2 )
               local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
               
               -- new deny action.
               deny_t = tostring(rcv_json["disabled"])
               
               -- delete old entry
               -- here, gsub is not work!  deny_dev_list:gsub(deny_info, "")
               deny_dev_list = string_cut(deny_dev_list, p1, p2)
               
               -- if deny dev or limit dev speed, then replace new entry; otherwise, delete entry.
               if deny_t == '1' or uplimit_t ~= 0 or dwlimit_t ~= 0 then
                   deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t)
                   deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
               elseif deny_t == '0' then
                   luci.sys.exec(string.format('iptables -D INPUT    -m mac --mac-source %s -j DROP', mac_t))
                   luci.sys.exec(string.format('iptables -D FORWARD  -m mac --mac-source %s -j DROP', mac_t))
               else
               end 
               
               uci.set("misc", "blackwhitelist", "deny_dev_list", deny_dev_list)
               uci.commit("misc")
            end   
        end
    else
        -- new enrty
        if idx > 0 then
            deny_info  = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
            deny_dev_list = string.format('%s', deny_info)
            
            uci.set("misc", "limit", "dw_limit", deny_dev_list)
            uci.commit("misc")
        end
    end    
    
    -- now, only write iptable rules.    
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        local p1, p2
        p2 = 0
        
        while true do
            p1, p2 = string.find(deny_dev_list, "(.-);" , p2 + 1)
            if p1 ~= nil then
                local deny_info  = string.sub(deny_dev_list, p1, p2 )
                local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%S+),(%S+);")
        
                if deny_t == '1' then
                    luci.sys.exec(string.format('iptables -D INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -D FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -I INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -I FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                else
                    luci.sys.exec(string.format('iptables -D INPUT    -m mac --mac-source %s -j DROP', mac_t)) 
                    luci.sys.exec(string.format('iptables -D FORWARD  -m mac --mac-source %s -j DROP', mac_t)) 
                end    
            else
                break
            end
        end
    end
        
    return  
end
]]--


function maclist_add_mac(list, mac, hostname)
    local list_s = list
    local mac_s  = mac:gsub(':', '')
    
    if list_s ~= nil and list_s ~= '' then
        local p1 = string.find(list_s, mac_s)
        
        if p1 == nil then
            list_s = string.format("%s,%s/%s", list_s, mac_s, hostname)
        end
    else
        list_s = string.format("%s/%s", mac_s, hostname)
    end
            
    return list_s
end
            

function maclist_del_mac(list, mac)
    local list_s = list
    
    if list_s ~= nil and list_s ~= '' then
        local mac_s, p1, p2, pattern, len
        
        list_s =string.format('%s,', list_s)   
        mac_s = string.lower(mac:gsub(':', ''))
        pattern = string.format('%s%s', mac_s, '/%S-,')
        
        p1, p2 = string.find(string.lower(list_s), pattern)
        if p1 ~= nil then 
            list_s = string_cut(list_s, p1, p2)
        end 
        
        len = string.len(list_s)
        if len > 0 and string.sub(list_s, len, len) == ','  then
            list_s = string.sub(list_s, 1, len-1)
        end   
    end
    
    return list_s 
end        


------------------------------------------------------------------------- 
-- current apply_deny_dev():  with andlink support.
------------------------------------------------------------------------- 
function apply_deny_dev()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    -- post data error, return. 
    if rcv_succ == 0 then
        return
    end
    
    local idx = 0
    local mac_v, hostname_v, deny_v
    
    mac_v  = rcv_json["mac"]
    deny_v = rcv_json["disabled"]
            
    get_dhcp_leases_common(4)
    idx = get_dev_idx(rcv_json["mac"])
    
    if idx > 0 then
        hostname_v = assoc_dev_list[idx].hostname
    else
        hostname_v = 'unknown'    
    end
    
    if deny_v == 1 then
        save_dev_info(idx)
    end
    
    local MacFilterEnable_v, MacFilterPolicy_v, MacFilterEntries_v
    MacFilterEnable_v  = uci.get("andlink", "MacFilter", "MacFilterEnable")
    MacFilterPolicy_v  = uci.get("andlink", "MacFilter", "MacFilterPolicy")
    MacFilterEntries_v = uci.get("andlink", "MacFilter", "WebFilterEntries")
        
    -- there is only blacklist mode.
    if deny_v == 1 then
        -- deny mac action.
        -- add the mac to blacklist, deny it.
        MacFilterEntries_v = maclist_add_mac(MacFilterEntries_v, mac_v, hostname_v)
    else
        -- del the mac from blacklist, free it.
        MacFilterEntries_v = maclist_del_mac(MacFilterEntries_v, mac_v)
    end
        
    uci.set("andlink", "MacFilter", "WebFilterEntries", MacFilterEntries_v)
    uci.commit("andlink")
    
    return
end

function save_dev_info(idx)
    local deny_dev_list = uci.get("misc", "rename", "rn_list")
    local deny_info = ''
    local mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v
    local new_entry = 0
            
    if idx == 0 then 
        return
    end    
    
    if deny_dev_list == nil then
        deny_dev_list = ''
    end
    
    mac_v      = assoc_dev_list[idx].mac
    ip_v       = assoc_dev_list[idx].ip 
    type_v     = assoc_dev_list[idx].type
    hostname_v = assoc_dev_list[idx].hostname
    uplimit_v  = assoc_dev_list[idx].up_limit
    dwlimit_v  = assoc_dev_list[idx].down_limit
    
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        local p1, p2
        p1 = string.find(deny_dev_list, mac_v)
    
        if p1 == nil then
            -- new entry
            new_entry = 1
        else
            -- already in deny_dev_list
            -- replace deny_info
            p1, p2 = string.find(deny_dev_list, "(.-);" , p1)
            if p1 ~= nil then
               local deny_info  = string.sub(deny_dev_list, p1, p2 )
               deny_dev_list = string_cut(deny_dev_list, p1, p2)
               deny_v = '0'
               deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
               deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
               
               uci.set("misc", "rename", "rn_list", deny_dev_list)
               uci.commit("misc")
            end   
        end
    else
        -- new enrty
        new_entry = 1
    end
    
    if new_entry == 1 then
        deny_v = '0'
        deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
        deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
            
        uci.set("misc", "rename", "rn_list", deny_dev_list)
        uci.commit("misc")
    end

    return
end


function apply_dev_rename()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local deny_dev_list = uci.get("misc", "rename", "rn_list")
    if deny_dev_list == nil then
        deny_dev_list = ''
    end    
        
    local deny_info = ''
    local idx = 0
    local mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v
    local new_entry = 0
            
    get_dhcp_leases_common(4)
    mac_v = rcv_json["mac"]
    idx = get_dev_idx(mac_v)
    
    if idx > 0 then 
        ip_v       = assoc_dev_list[idx].ip 
        type_v     = assoc_dev_list[idx].type
        uplimit_v  = assoc_dev_list[idx].up_limit
        dwlimit_v  = assoc_dev_list[idx].down_limit
    end
    
    if rcv_json["deviceName"] and rcv_json["deviceName"] ~='' then
        hostname_v = rcv_json["deviceName"]
    else
        hostname_v = "unknown"
    end
    
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        local p1, p2
        p1 = string.find(deny_dev_list, rcv_json["mac"])
    
        if p1 == nil then
            -- new entry
            new_entry = 1
        else
            -- already in deny_dev_list
            -- replace deny_info
            p1, p2 = string.find(deny_dev_list, "(.-);" , p1)
            if p1 ~= nil then
               deny_info  = string.sub(deny_dev_list, p1, p2 )
               deny_dev_list = string_cut(deny_dev_list, p1, p2)
               deny_v = '0'
               
               if idx > 0 then 
                   deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
               else
                   local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
                   deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_t, ip_t, type_t, hostname_v, deny_v, uplimit_t, dwlimit_t)
               end    
               
               deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
               
               uci.set("misc", "rename", "rn_list", deny_dev_list)
               uci.commit("misc")
            end   
        end
    else
        -- new enrty
        new_entry = 1
    end
    
    if new_entry == 1 then
        deny_v = '0'
        if idx > 0 then 
            deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
        else
            -- not current associated device, and not existed entry in deny_dev_list, then build a new entry.
            deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, "0.0.0.0", "0", hostname_v, "0", "0", "0")
        end    
        
        deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
        uci.set("misc", "rename", "rn_list", deny_dev_list)
        uci.commit("misc")
    end
    
    return  
end



function apply_dev_speed_limit()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    -- post data error, return. 
    if rcv_succ == 0 then
        return
    end
    
    local deny_dev_list = uci.get("misc", "limit", "dw_limit")
    if deny_dev_list == nil then
        deny_dev_list = ''
    end    
        
    local deny_info = ''
    local idx = 0
    local mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v
    local new_entry = 0
            
    get_dhcp_leases_common(4)    
    idx = get_dev_idx(rcv_json["mac"])
    
    if idx > 0 then
        mac_v      = assoc_dev_list[idx].mac
        ip_v       = assoc_dev_list[idx].ip 
        type_v     = assoc_dev_list[idx].type
        hostname_v = assoc_dev_list[idx].hostname
        uplimit_v  = assoc_dev_list[idx].up_limit
        dwlimit_v  = assoc_dev_list[idx].down_limit
    end
    
    if deny_dev_list ~= '' and deny_dev_list ~= nil then
        local p1, p2
        p1 = string.find(deny_dev_list, rcv_json["mac"])
    
        if p1 == nil then
            -- new entry
            if idx > 0 then
                deny_v = '0'
                uplimit_v = rcv_json["uplimit"]
                dwlimit_v = rcv_json["downlimit"]
                
                deny_info  = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
                deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
                
                uci.set("misc", "limit", "dw_limit", deny_dev_list)
                uci.commit("misc")
                new_entry = 1
            end
        else
            -- already in deny_dev_list
            -- replace deny_info
            p1, p2 = string.find(deny_dev_list, "(.-);" , p1)
            if p1 ~= nil then
               local deny_info  = string.sub(deny_dev_list, p1, p2 )
               local mac_t, ip_t, type_t, hostname_t, deny_t, uplimit_t, dwlimit_t = deny_info:match("^(%S+),(%S+),(%S+),(%S+),(%S+),(%d+),(%d+);")
               
               -- delete old entry
               -- here, gsub is not work!  deny_dev_list:gsub(deny_info, "")
               deny_dev_list = string_cut(deny_dev_list, p1, p2)
               
               -- don't deny dev, then limit dev speed.
               if deny_t == '0' then
                   local dwlimit_s, uplimit_s
                   
                   dwlimit_s = tostring(math.modf(dwlimit_t*2/3))
                   uplimit_s = tostring(math.modf(uplimit_t*2/3))
                   
                   -- delete old rules firstly.
                   luci.sys.exec(string.format('iptables -D FORWARD -d %s -j DROP', ip_t))
                   luci.sys.exec(string.format('iptables -D FORWARD -d %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, dwlimit_s, dwlimit_s))
                   luci.sys.exec(string.format('iptables -D FORWARD -s %s -j DROP', ip_t))
                   luci.sys.exec(string.format('iptables -D FORWARD -s %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, uplimit_s, uplimit_s))

                   deny_v = deny_t
                   uplimit_v = rcv_json["uplimit"]
                   dwlimit_v = rcv_json["downlimit"]
                   
                   dwlimit_s = tostring(math.modf(dwlimit_v*2/3))
                   uplimit_s = tostring(math.modf(uplimit_v*2/3))
 
                   if dwlimit_v ~= 0 then
                       luci.sys.exec(string.format('iptables -I FORWARD -d %s -j DROP', ip_t))
                       luci.sys.exec(string.format('iptables -I FORWARD -d %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, dwlimit_s, dwlimit_s))
                   end
                  
                   if uplimit_v ~= 0 then
                       luci.sys.exec(string.format('iptables -I FORWARD -s %s -j DROP', ip_t))
                       luci.sys.exec(string.format('iptables -I FORWARD -s %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_t, uplimit_s, uplimit_s))
                   end
                   
                   deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
                   deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
               end 
               
               uci.set("misc", "limit", "dw_limit", deny_dev_list)
               uci.commit("misc")
            end   
        end
    else
        -- new enrty
        if idx > 0 then
            deny_v = '0'
            uplimit_v = rcv_json["uplimit"]
            dwlimit_v = rcv_json["downlimit"]
                
            deny_info = string.format('%s,%s,%s,%s,%s,%s,%s;', mac_v, ip_v, type_v, hostname_v, deny_v, uplimit_v, dwlimit_v)
            deny_dev_list = string.format('%s%s', deny_dev_list, deny_info)
            
            uci.set("misc", "limit", "dw_limit", deny_dev_list)
            uci.commit("misc")
            new_entry = 1
        end
    end
    
    if new_entry == 1 then
        if dwlimit_v ~= 0 then
            local dwlimit_s = tostring(math.modf(dwlimit_v*2/3))
            luci.sys.exec(string.format('iptables -I FORWARD -d %s -j DROP', ip_v))
            luci.sys.exec(string.format('iptables -I FORWARD -d %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_v, dwlimit_s, dwlimit_s))
        end
                  
        if uplimit_v ~= 0 then
            local uplimit_s = tostring(math.modf(uplimit_v*2/3))
            luci.sys.exec(string.format('iptables -I FORWARD -s %s -j DROP', ip_v))
            luci.sys.exec(string.format('iptables -I FORWARD -s %s -m limit --limit %s/s --limit-burst %s -j ACCEPT', ip_v, uplimit_s, uplimit_s))
        end
    end 
        
    return  
end


function get_wan_setting()
    require "luci.fs"
    require "luci.tools.status"

    -- below info is not needed currently. 
    --[[
    local has_ipv6 = luci.fs.access("/proc/net/ipv6_route")
    local has_dhcp = luci.fs.access("/etc/config/dhcp")
    local has_wifi = luci.fs.stat("/etc/config/wireless")
        has_wifi = has_wifi and has_wifi.size > 0
    local _, _, memtotal, memcached, membuffers, memfree, _, swaptotal, swapcached, swapfree = luci.sys.sysinfo()
    local has_swap
    if swaptotal > 0 then
        has_swap = 1
    end
    local has_dsl = luci.fs.stat("/etc/init.d/dsl_control")

    local ntm = require "luci.model.network".init()
    local wan = ntm:get_wannet()
    local wan6 = ntm:get_wan6net()

    local conn_count = tonumber((
      luci.sys.exec("wc -l /proc/net/nf_conntrack") or
      luci.sys.exec("wc -l /proc/net/ip_conntrack") or
      ""):match("%d+")) or 0

    local conn_max = tonumber((
      luci.sys.exec("sysctl net.nf_conntrack_max") or
      luci.sys.exec("sysctl net.ipv4.netfilter.ip_conntrack_max") or
      ""):match("%d+")) or 4096

    local rv = {
      uptime     = luci.sys.uptime(),
      localtime  = os.date(),
      loadavg    = { luci.sys.loadavg() },
      memtotal   = memtotal,
      memcached  = memcached,
      membuffers = membuffers,
      memfree    = memfree,
      swaptotal  = swaptotal,
      swapcached = swapcached,
      swapfree   = swapfree,
      connmax    = conn_max,
      conncount  = conn_count,
      leases     = luci.tools.status.dhcp_leases(),
      leases6    = luci.tools.status.dhcp6_leases(),
      wifinets   = luci.tools.status.wifi_networks()
    }

    if wan then
      rv.wan = {
        ipaddr  = wan:ipaddr(),
        gwaddr  = wan:gwaddr(),
        netmask = wan:netmask(),
        dns     = wan:dnsaddrs(),
        expires = wan:expires(),
        uptime  = wan:uptime(),
        proto   = wan:proto(),
        ifname  = wan:ifname(),
        link    = wan:adminlink()
      }
    end

    if wan6 then
      rv.wan6 = {
        ip6addr = wan6:ip6addr(),
        gw6addr = wan6:gw6addr(),
        dns     = wan6:dns6addrs(),
        uptime  = wan6:uptime(),
        ifname  = wan6:ifname(),
        link    = wan6:adminlink()
      }
    end

    if has_dsl then
      local dsl_stat = luci.sys.exec("/etc/init.d/dsl_control lucistat")
      local dsl_func = loadstring(dsl_stat)
      rv.dsl = dsl_func()
    end
    ]]--

    local wan_setting_s = {}
    local netType_v = 0
    local linkStatue_v = 0
    
    local is_connected = is_wan_connected()
    if is_connected == "1" then 
        linkStatue_v = 0 
    elseif is_connected == "0" then 
        linkStatue_v = 1 
    else 
        linkStatue_v = 2 
    end
    
    local uci = require "luci.model.uci".cursor()
    local proto_v, ipaddr_v, netmask_v, gateway_v, dns_v, dns1_v, dns2_v, pppoe_username_v, pppoe_password_v, mtu_v
    
    -- mtu
    mtu_v = uci.get("network", "wan", "mtu")
    if not mtu_v then mtu_v = 0 end
    
    -- dns                                                                                                         
    dns_v = uci.get("network", "wan", "dns") or ""                                                                       
    if dns_v and dns_v ~= "" then
        local p = string.find(dns_v, ' ')
        if p ~= nil then
            dns1_v = string.trim(string.sub(dns_v, 1, p-1))
            dns2_v = string.trim(string.sub(dns_v, p+1))
        else
            dns1_v = dns_v   
            dns2_v = ""
        end    
    else
        dns1_v = ""
        dns2_v = ""
    end
    
    -- mac clone
    local yourhost_v, clone_mac_v, cur_mac, factory_mac
    yourhost_v  = luci.sys.net.ip4mac(os.getenv("REMOTE_ADDR"))
    cur_mac     = uci.get("network", "wan", "macaddr")
    factory_mac = get_factory_wan_mac()
    
    if cur_mac and cur_mac ~= factory_mac then
        clone_mac_v = cur_mac
    else
        clone_mac_v = ""
    end    
    
    local vpn_switch_v = uci.get("internet", "pptp_l2tp", "Switch")
    if vpn_switch_v == "on" then
        -- VPN
        local clientmode_v, domain_v, username_v, password_v, netmode_v, staticip_v, staticmask_v, staticgateway_v, MTU_v
        local vpn_setting = {} 
        
        clientmode_v    = uci.get("internet", "pptp_l2tp", "clientmode")
        domain_v        = uci.get("internet", "pptp_l2tp", "domain")
        username_v      = uci.get("internet", "pptp_l2tp", "username")
        password_v      = uci.get("internet", "pptp_l2tp", "password")
        netmode_v       = uci.get("internet", "pptp_l2tp", "netmode")
        staticip_v      = uci.get("internet", "pptp_l2tp", "staticip")
        staticmask_v    = uci.get("internet", "pptp_l2tp", "staticmask")
        staticgateway_v = uci.get("internet", "pptp_l2tp", "staticgateway")
        MTU_v           = uci.get("internet", "pptp_l2tp", "MTU")
        
        if netmode_v == 'DHCP' then
       		vpn_setting = {
        		Switch = vpn_switch_v,
        		clientmode = clientmode_v,
        		domain = domain_v,
	        	username = username_v,
    	    	password = password_v,
        		netmode = netmode_v
    		}
        else
       		vpn_setting = {
	        	Switch = vpn_switch_v,
    	    	clientmode = clientmode_v,
        		domain = domain_v,
        		username = username_v,
	        	password = password_v,
    	    	netmode = netmode_v,
        		staticip = staticip_v,
	        	staticmask = staticmask_v,
    	    	staticgateway = staticgateway_v,
        		MTU = MTU_v
    		}
        end
       
        if clientmode_v == "pptp" then
            netType_v = 6
            wan_setting_s = {
                linkStatue  = linkStatue_v,
                netType     = netType_v,
                vpn_setting = vpn_setting
            }
        else
            netType_v = 7
            wan_setting_s = {
                linkStatue  = linkStatue_v,
                netType     = netType_v,
                vpn_setting = vpn_setting
            }
        end
    else
        -- no VPN
        proto_v = uci.get("internet", "config", "mode")
        if proto_v == "autodhcp" then 
            netType_v = 0
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v
            }
        elseif proto_v == "bridgedhcp" then    
            netType_v = 4
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v
            }
        elseif proto_v == "routerdhcp" then    
            netType_v = 5
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v,
                dns1       = dns1_v,
                dns2       = dns2_v,
                mtu        = mtu_v,
                yourhost   = yourhost_v,
                clone_mac  = clone_mac_v
            }    
        elseif proto_v == "routerstatic" then
            netType_v = 1
            ipaddr_v  = uci.get("network", "wan", "ipaddr")
            netmask_v = uci.get("network", "wan", "netmask")
            gateway_v = uci.get("network", "wan", "gateway")

            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v,
                ip         = ipaddr_v,
                mask       = netmask_v,
                gateway    = gateway_v,
                dns1       = dns1_v,
                dns2       = dns2_v,
                mtu        = mtu_v,
                yourhost   = yourhost_v,
                clone_mac  = clone_mac_v
            }
        elseif proto_v == "routerpppoe" then
            netType_v = 2
            pppoe_username_v = uci.get("network", "wan", "username")
            pppoe_password_v = uci.get("network", "wan", "password")
            pppoe_svcname_v  = uci.get("network", "wan", "service") or ""
            
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v,
                account    = pppoe_username_v,
                password   = pppoe_password_v,
                svcname    = pppoe_svcname_v,
                dns1       = dns1_v,
                dns2       = dns2_v,
                mtu        = mtu_v,
                yourhost   = yourhost_v,
                clone_mac  = clone_mac_v
            }
        elseif proto_v == "routerwisp" then
            netType_v = 3
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v
            }
        else
            netType_v = 0
            wan_setting_s = {
                linkStatue = linkStatue_v,
                netType    = netType_v
            }    
        end    
    end

    luci.http.prepare_content("application/json")
    luci.http.write_json(wan_setting_s)
    
    return
end

function restore_net_setting(new_mode)
    local pre_mode = uci.get("internet", "config", "mode")
    local sys = require "luci.controller.admin.system"
    
    if new_mode == "routerstatic" or new_mode == "routerdhcp" or new_mode == "routerpppoe" then
        if pre_mode == 'bridgedhcp' or pre_mode == 'routerwisp' then
            if pre_mode == 'bridgedhcp' then
                sys.fork_exec(string.format("ifconfig %s 0.0.0.0; brctl delif br-lan %s", wan_ifc, wan_ifc))
            else
                -- restore lan ip, bridge, apcli0/apclii0 status ...
                sys.fork_exec("ifconfig apcli0 down; ifconfig apcli0 0.0.0.0; brctl delif br-lan apcli0; ifconfig apclii0 down; ifconfig apclii0 0.0.0.0; brctl delif br-lan apclii0") 
            
                -- disable repeater.
                uci.set("wireless", DEV_2G, "apclienable", "0")
                uci.set("wireless", DEV_5G, "apclienable", "0")
                uci.commit("wireless")
            end
    
            -- restore lan dhcp setting.
            local ignore_orig_v = uci.get("dhcp", "lan", "ignore_orig")
            if ignore_orig_v == nil then ignore_orig_v = '0' end
            
            uci.set("dhcp", "lan", "ignore", ignore_orig_v)
            uci.commit("dhcp")
        end    
    end
        
    return
end

function apply_wan_dhcp_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
    end

    local rcv_json = cjson.decode(postdata)
    local resp_s = '{"result":0, "msg":"..."}'

    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    local netType_v, dhcptype_v
    netType_v = rcv_json["netType"]
    if netType_v == 0 then
        -- aotodhcp mode
        dhcptype_v = "autodhcp"
    elseif netType_v == 4 then
        dhcptype_v = "bridgedhcp"
    elseif netType_v == 5 then
        dhcptype_v = "routerdhcp"
    else
        dhcptype_v = "autodhcp"
    end

    local uci = require "luci.model.uci".cursor()
    local dns_v, dns1_v, dns2_v, mtu_v, clone_mac_v
    dns_v = ""
    dns1_v = rcv_json["dns1"]
    dns2_v = rcv_json["dns2"]
    if dns1_v and dns2_v then dns_v = string.trim(dns1_v .. " " .. dns2_v) end
    if (dns_v ~= "") then 
        uci.set("network", "wan", "dns", dns_v)
    else
        uci.delete("network", "wan", "dns")
    end
    
    mtu_v = rcv_json["mtu"]
    if mtu_v and mtu_v ~= "" then
        if mtu_v == "0" then 
            uci.delete("network", "wan", "mtu")
            luci.sys.exec(string.format("ifconfig %s mtu 1500", wan_ifc))
        else
            uci.set("network", "wan", "mtu", mtu_v)
        end    
    end
    
    --clone_mac_v = rcv_json["clone_mac"]
    clone_mac_v = rcv_json["mac"]
    if clone_mac_v and clone_mac_v ~= "" then
        uci.set("network", "wan", "macaddr", clone_mac_v)
        
        -- before MAC clone and network restart, should ifdown wan interface, just look like below. ~_~
        luci.sys.exec("env -i /sbin/ifdown wan") 
    else
        local factory_mac = get_factory_wan_mac()
        uci.set("network", "wan", "macaddr", factory_mac)
    end

    restore_net_setting(dhcptype_v)
    
    uci.set("internet", "config", "mode", dhcptype_v)
    if dns1_v then
        uci.set("internet", "config", "routerdns1", dns1_v)
    end
    if dns2_v then
        uci.set("internet", "config", "routerdns2", dns2_v)
    end
    uci.set("internet", "pptp_l2tp", "Switch", "off")
    uci.delete("network", "PPTP")
    uci.delete("network", "L2TP")
    
    local idx = -1
    uci:foreach("firewall", "zone", function(s)
        idx = idx + 1
        if s.name and s.name == "wan" then
            return false
        end
    end)
    if idx ~= -1 then  
        luci.sys.exec(string.format("uci del_list firewall.@zone[%d].network='PPTP'", idx)) 
        luci.sys.exec(string.format("uci del_list firewall.@zone[%d].network='L2TP'", idx)) 
        luci.sys.exec("uci commit firewall")
    end
    
    uci.commit("internet")
    uci.commit("network")
    
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 1; switch_internet_mode.sh")
        
    return
end


function apply_wan_pppoe_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
    end

    local rcv_json = cjson.decode(postdata)
    local resp_s = '{"result":0, "msg":"..."}'

    luci.http.prepare_content("application/json")
      luci.http.write(resp_s)
    
    local pppoe_username_v, pppoe_password_v, pppoe_svcname_v, mtu_v

    pppoe_username_v = {}
    pppoe_password_v = {}
    pppoe_username_v = rcv_json["account"]
    pppoe_password_v = rcv_json["password"]
    pppoe_svcname_v  = rcv_json["svcname"]
    mtu_v            = rcv_json["mtu"]
    
    local uci = require "luci.model.uci".cursor()
    local dns_v, dns1_v, dns2_v, mtu_v, clone_mac_v
    dns_v = ""
    dns1_v = rcv_json["dns1"]
    dns2_v = rcv_json["dns2"]
    if dns1_v and dns2_v then dns_v = string.trim(dns1_v .. " " .. dns2_v) end
    if (dns_v ~= "") then 
        uci.set("network", "wan", "dns", dns_v)
    else
        uci.delete("network", "wan", "dns")
    end
    
    mtu_v = rcv_json["mtu"]
    if mtu_v and mtu_v ~= "" then
        if mtu_v == "0" then 
            uci.delete("network", "wan", "mtu")
            luci.sys.exec(string.format("ifconfig %s mtu 1500", wan_ifc))
        else
            uci.set("network", "wan", "mtu", mtu_v)
        end    
    end
    
    -- cwx, here ! is "clone_mac" !!!
    clone_mac_v = rcv_json["clone_mac"]
    --clone_mac_v = rcv_json["mac"] 
    if clone_mac_v and clone_mac_v ~= "" then
        uci.set("network", "wan", "macaddr", clone_mac_v)
        
        -- before MAC clone and network restart, should ifdown wan interface, just look like below. ~_~
        luci.sys.exec("env -i /sbin/ifdown wan") 
    else
        local factory_mac = get_factory_wan_mac()
        uci.set("network", "wan", "macaddr", factory_mac)
    end
    
    restore_net_setting("routerpppoe")

    uci.set("internet", "config", "mode", "routerpppoe")
    uci.set("internet", "config", "id", pppoe_username_v)
    uci.set("internet", "config", "pwd", pppoe_password_v)
    uci.set("internet", "config", "routerdns1", dns1_v)
    uci.set("internet", "config", "routerdns2", dns2_v)
    uci.set("internet", "pptp_l2tp", "Switch", "off")
    uci.delete("network", "PPTP")
    uci.delete("network", "L2TP")
    
    if pppoe_svcname_v ~= "" then
        uci.set("network", "wan", "service", pppoe_svcname_v)
    else
        uci.delete("network", "wan", "service")
    end
    
    uci.commit("internet")
    uci.commit("network")
    
    --luci.sys.exec("nvram set blink pppoeUser " .. pppoe_username_v)
    --luci.sys.exec("nvram set blink pppoePwd " .. pppoe_password_v)
    --luci.sys.exec("nvram commit")
    
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 1;switch_internet_mode.sh")
        
    return
end


function apply_wan_static_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
    end

    local rcv_json = cjson.decode(postdata)
    local resp_s = '{"result":0, "msg":"..."}'

    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
     
    local uci = require "luci.model.uci".cursor()
    local dns_v, dns1_v, dns2_v, mtu_v, clone_mac_v
    dns_v = ""
    dns1_v = rcv_json["dns1"]
    dns2_v = rcv_json["dns2"]
    if dns1_v and dns2_v then dns_v = string.trim(dns1_v .. " " .. dns2_v) end
    if (dns_v ~= "") then 
        uci.set("network", "wan", "dns", dns_v)
    else
        uci.delete("network", "wan", "dns")
    end
    
    mtu_v = rcv_json["mtu"]
    if mtu_v and mtu_v ~= "" then
        if mtu_v == "0" then 
            uci.delete("network", "wan", "mtu")
            luci.sys.exec(string.format("ifconfig %s mtu 1500", wan_ifc))
        else
            uci.set("network", "wan", "mtu", mtu_v)
        end    
    end
    
    --clone_mac_v = rcv_json["clone_mac"]
    clone_mac_v = rcv_json["mac"]
    if clone_mac_v and clone_mac_v ~= "" then
        uci.set("network", "wan", "macaddr", clone_mac_v)
        
        -- before MAC clone and network restart, should ifdown wan interface, just look like below. ~_~
        luci.sys.exec("env -i /sbin/ifdown wan") 
    else
        local factory_mac = get_factory_wan_mac()
        uci.set("network", "wan", "macaddr", factory_mac)
    end
    
    restore_net_setting("routerstatic")
    
    local proto_v, ipaddr_v, netmask_v, gateway_v, dns_v
    
    proto_v   = "static"
    ipaddr_v  = rcv_json["ip"]
    netmask_v = rcv_json["mask"]
    gateway_v = rcv_json["gateway"]
    dns_v     = string.format("%s %s", rcv_json["dns1"], rcv_json["dns2"])
    
    uci.set("internet", "config", "mode", "routerstatic")
    uci.set("internet", "config", "routeripaddr", ipaddr_v)
    uci.set("internet", "config", "routernetmask", netmask_v)
    uci.set("internet", "config", "routergateway", gateway_v)
    uci.set("internet", "config", "routerdns1", rcv_json["dns1"])
    uci.set("internet", "config", "routerdns2", rcv_json["dns2"])
    
    uci.set("internet", "pptp_l2tp", "Switch", "off")
    uci.delete("network", "PPTP")
    uci.delete("network", "L2TP")
    
    uci.commit("internet")
    uci.commit("network")
    
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 1;switch_internet_mode.sh")
        
    return  
end


local os = require "os"
function old_get_wifi_setting(id)
  local rv = { }
  local ntm = require "luci.model.network".init()

  local dev
  for _, dev in ipairs(ntm:get_wifidevs()) do
    local rd = {
      up       = dev:is_up(),
      device   = dev:name(),
      name     = dev:get_i18n(),
      networks = { }
    }

    local wifi_s = {}

    local net
    for _, net in ipairs(dev:get_wifinets()) do
      rd.networks[#rd.networks+1] = {
        name       = net:shortname(),
        link       = net:adminlink(),
        up         = net:is_up(),
        mode       = net:active_mode(),
        ssid       = net:active_ssid(),
        bssid      = net:active_bssid(),
        encryption = net:active_encryption(),
        frequency  = net:frequency(),
        channel    = net:channel(),
        signal     = net:signal(),
        quality    = net:signal_percent(),
        noise      = net:noise(),
        bitrate    = net:bitrate(),
        ifname     = net:ifname(),
        assoclist  = net:assoclist(),
        country    = net:country(),
        txpower    = net:txpower(),
        txpoweroff = net:txpower_offset()
      }
      
    end

    rv[#rv+1] = rd
  end

  wifi_s = {
        ssid = rv[id].networks[1].ssid,
        password = 123,
        encryption = 1,
        power = rv[id].networks[1].txpower
  }

  return   wifi_s
end


function get_wifi_setting(wifi_band, no_http)
    local uci = require "luci.model.uci".cursor()
    local ssid_v, key_v, key1_v, encryption_s, encryption_v, encry_alg_v,txpower_s, txpower_v, channel_v, wlanWidth_v, disabled_v, hidden_v 
    local i, device_name, main_ifc
    
    -- wifi_band: 0=2.4G; 1=5G
    if wifi_band == WIFI_2G then
        ssid_v       = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].ssid'))
        key_v        = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].key'))
        key1_v       = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].key1'))
        encryption_s = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].encryption'))
        disabled_v   = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].disabled'))
        hidden_v     = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[0].hidden'))
        txpower_s    = string.trim(luci.sys.exec(string.format('uci get wireless.%s.txpower', DEV_2G)))
        channel_v    = string.trim(luci.sys.exec(string.format('uci get wireless.%s.channel', DEV_2G)))
        wlanWidth_v  = string.trim(luci.sys.exec('uci get misc.wifi.dw_g24'))
    else
        ssid_v       = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].ssid'))
        key_v        = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].key'))
        key1_v       = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].key1'))
        encryption_s = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].encryption'))
        disabled_v   = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].disabled'))
        hidden_v     = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[4].hidden'))
        txpower_s    = string.trim(luci.sys.exec(string.format('uci get wireless.%s.txpower', DEV_5G)))
        channel_v    = string.trim(luci.sys.exec(string.format('uci get wireless.%s.channel', DEV_5G)))
        wlanWidth_v  = string.trim(luci.sys.exec('uci get misc.wifi.dw_g5'))
    end  
  
    if string.find(encryption_s, 'mixed') ~= nil then
        encryption_v = 5
    elseif string.find(encryption_s, 'psk2') ~= nil then
        encryption_v = 4
    elseif string.find(encryption_s, 'psk') ~= nil then
        encryption_v = 3
    elseif string.find(encryption_s, 'wep') then
        if string.len(key1_v) >= 13 then
            encryption_v = 2
        else
            encryption_v = 1
        end    
                
        key_v = key1_v    
    else
        encryption_v = 0
    end
    
    if string.find(encryption_s, 'ccmp') ~= nil and string.find(encryption_s, 'tkip') ~= nil then
        encry_alg_v = 3
    elseif string.find(encryption_s, 'tkip') ~= nil then
        encry_alg_v = 2
    elseif string.find(encryption_s, 'ccmp') ~= nil then
        encry_alg_v = 1
    else
        encry_alg_v = 0
    end
    
    local txp = tonumber(txpower_s) or 0
    if txp > 60 then
        txpower_v = 2
    elseif txp > 40 and txp <= 60 then
        txpower_v = 1
    else
        txpower_v = 0
    end    
    
    local resp_s = {} 
    resp_s = {
        wifi_band  = wifi_band,
        disabled   = disabled_v,
        hidden     = hidden_v,
        ssid       = ssid_v,
        password   = key_v,
        encryption = encryption_v,
        encry_alg  = encry_alg_v,
        power      = txpower_v,
        channel    = channel_v,
        wlanWidth  = wlanWidth_v
    }
    
    if no_http then
        return resp_s
    else
        luci.http.prepare_content("application/json")
        luci.http.write_json(resp_s)
        
        return
    end
end


function get_total_wifi_setting()
    local wifi_info = {}
    
    if MODEL_TYPE == 0 or MODEL_TYPE == 2 then
        wifi_info[1] = get_wifi_setting(WIFI_2G, 1)
    else
        wifi_info[1] = get_wifi_setting(WIFI_2G, 1)
        wifi_info[2] = get_wifi_setting(WIFI_5G, 1)
    end
    
    luci.http.prepare_content("application/json")
    luci.http.write('{"wifi_info":')
    luci.http.write_json(wifi_info)
    luci.http.write('}')
end


function get_guest_wifi_setting()
    local guest2g_disabled, guest2g_ssid, guest2g_password, guest5g_disabled, guest5g_ssid, guest5g_password, guest_isolated
    local resp_s
    
    guest2g_disabled = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[1].disabled'))
    guest2g_ssid     = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[1].ssid'))
    guest2g_password = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[1].key'))
    guest_isolated   = string.trim(luci.sys.exec('uci get misc.guestwifi.isolated'))
    if guest_isolated == "" then guest_isolated = "1" end    
    
    if MODEL_TYPE == 0 or MODEL_TYPE == 2 then
        resp_s = {
            guest2g_disabled = guest2g_disabled,
            guest2g_ssid     = guest2g_ssid,
            guest2g_password = guest2g_password,
            guest_isolated   = guest_isolated
        }
    else
        guest5g_disabled = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[5].disabled'))
        guest5g_ssid     = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[5].ssid'))
        guest5g_password = string.trim(luci.sys.exec('uci get wireless.@wifi-iface[5].key'))
        
        resp_s = {
            guest2g_disabled = guest2g_disabled,
            guest2g_ssid     = guest2g_ssid,
            guest2g_password = guest2g_password,
            guest5g_disabled = guest5g_disabled,
            guest5g_ssid     = guest5g_ssid,
            guest5g_password = guest5g_password,
            guest_isolated   = guest_isolated
        }
    end
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_guest_wifi_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end
    
    local guest2g_disabled, guest2g_ssid, guest2g_password, guest5g_disabled, guest5g_ssid, guest5g_password, guest_isolated
    local encry_s = "psk-mixed+ccmp"
    guest2g_disabled = rcv_json["guest2g_disabled"]
    guest2g_ssid     = rcv_json["guest2g_ssid"]
    guest2g_password = rcv_json["guest2g_password"]
    guest_isolated   = rcv_json["guest_isolated"]
    
    luci.sys.exec(string.format('uci set wireless.@wifi-iface[1].disabled=%s', guest2g_disabled))
    luci.sys.exec(string.format('uci set wireless.@wifi-iface[1].ssid="%s"',   cvt_char(guest2g_ssid) ))
    luci.sys.exec(string.format('uci set wireless.@wifi-iface[1].key="%s"',    cvt_char(guest2g_password) ))
    luci.sys.exec(string.format('uci set misc.guestwifi.isolated="%s"',        guest_isolated))
    luci.sys.exec('uci commit wireless')
    
    if MODEL_TYPE == 1 then
        guest5g_disabled = rcv_json["guest5g_disabled"]
        guest5g_ssid     = rcv_json["guest5g_ssid"]
        guest5g_password = rcv_json["guest5g_password"]
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[5].disabled=%s', guest5g_disabled))
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[5].ssid="%s"',   cvt_char(guest5g_ssid) ))
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[5].key="%s"',    cvt_char(guest5g_password) ))
        luci.sys.exec('uci commit wireless')
    end
    
    -- apply wifi separately.
    local sys = require "luci.controller.admin.system"
    if guest2g_disabled == "0" then
        sys.fork_exec("/sbin/apply_wifi_single.sh ra1 enable; /sbin/apply_wifi_single.sh ra1 enable")
    else
        sys.fork_exec("/sbin/apply_wifi_single.sh ra1 disable")
    end

    if MODEL_TYPE == 1 then
        if guest5g_disabled == "0" then
            sys.fork_exec("/sbin/apply_wifi_single.sh rai1 enable")
        else
            sys.fork_exec("/sbin/apply_wifi_single.sh rai1 disable")
        end
    end
    
    return
end


function get_2g_wifi_setting()
    get_wifi_setting(WIFI_2G)
    return
end


function get_5g_wifi_setting()
    get_wifi_setting(WIFI_5G)
    return    
end


function apply_wifi_setting(wifi_band)
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local ssid_v, key_v, encryption_v,encry_alg_v,txpower_s, txpower_v
        local i, device_name, main_ifc
        
        ssid_v       = rcv_json["ssid"]
        key_v        = rcv_json["password"]
        encryption_v = rcv_json["encryption"]
        encry_alg_v  = rcv_json["encry_alg"]
        txpower_v    = rcv_json["power"]
        
        -- wifi_band: 0=2.4G; 1=5G
        if wifi_band == WIFI_2G then
                  luci.sys.exec(string.format("uci set wireless.@wifi-iface[0].ssid=\"%s\"", ssid_v))
            
                  --******** wifi encryption
                  local encry_alg_s              
                  if encry_alg_v == '3' then
                      encry_alg_s = "+tkip+ccmp"
                  elseif encry_alg_v == '2' then
                      encry_alg_s = "+tkip"
                  elseif encry_alg_v == '1' then
                      encry_alg_s = "+ccmp"
                  else
                      encry_alg_s = ""
                  end    
            
                  local encry_s              
                  if encryption_v == '1' or encryption_v == '2' then
                      encry_s = "wep-open"
                      luci.sys.exec(string.format('uci set wireless.@wifi-iface[0].key1="%s"', cvt_char(key_v) ))
                  elseif encryption_v == '3' then
                      encry_s = "psk".. encry_alg_s
                  elseif encryption_v == '4' then
                      encry_s = "psk2".. encry_alg_s
                  elseif encryption_v == '5' then
                      encry_s = "psk-mixed".. encry_alg_s
                  else
                      encry_s = "none"
                  end
            
                  luci.sys.exec('uci set wireless.@wifi-iface[0].encryption=' .. encry_s)
                  luci.sys.exec(string.format("uci set wireless.@wifi-iface[0].key='%s'", key_v))
            
                  if txpower_v and txpower_v ~= "" then
                      if txpower_v == '0' then
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=40', DEV_2G))
                      elseif txpower_v == '1' then
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=60', DEV_2G))
                      else
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=100', DEV_2G))
                      end 
                  end
        else
                  luci.sys.exec(string.format("uci set wireless.@wifi-iface[4].ssid=\"%s\"", ssid_v))
            
                  local encry_alg_s              
                  if encry_alg_v == '3' then
                      encry_alg_s = "+tkip+ccmp"
                  elseif encry_alg_v == '2' then
                      encry_alg_s = "+tkip"
                  elseif encry_alg_v == '1' then
                      encry_alg_s = "+ccmp"
                  else
                      encry_alg_s = ""
                  end 
            
                  local encry_s 
                  if encryption_v == '1' or encryption_v == '2' then
                      encry_s = "wep-open"
                      luci.sys.exec(string.format('uci set wireless.@wifi-iface[4].key1="%s"', cvt_char(key_v) ))
                  elseif encryption_v == '3' then
                      encry_s = "psk".. encry_alg_s
                  elseif encryption_v == '4' then
                      encry_s = "psk2".. encry_alg_s
                  elseif encryption_v == '5' then
                      encry_s = "psk-mixed".. encry_alg_s
                  else
                      encry_s = "none"
                  end     
    
                  luci.sys.exec('uci set wireless.@wifi-iface[4].encryption=' .. encry_s)
            
                  luci.sys.exec(string.format("uci set wireless.@wifi-iface[4].key='%s'", key_v))
                  
                  if txpower_v and txpower_v ~= "" then
                      if txpower_v == '0' then
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=40', DEV_5G))
                      elseif txpower_v == '1' then
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=60', DEV_5G))
                      else
                          luci.sys.exec(string.format('uci set wireless.%s.txpower=100', DEV_5G))
                      end
                  end 
        end
    
        luci.sys.exec('uci commit wireless')
        
        -- apply wifi separately.
        local ifc_name
        if wifi_band == WIFI_2G then ifc_name = "ra0" else ifc_name = "rai0" end
        luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s enable', ifc_name))
        
        -- restart wifi
        -- local sys = require "luci.controller.admin.system"
        -- sys.fork_exec("sleep 1;wifi")
    end
            
    return  
end


function apply_total_wifi_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end
    
    wifi_info_tbl = rcv_json["wifi_info"]
    for i, v in ipairs(wifi_info_tbl) do
        local wifi_band_v, disabled_v, hidden_v, channel_v, wlanWidth_v, ssid_v, key_v, encryption_v,encry_alg_v,txpower_s, txpower_v
        local idx, dev_name, main_ifc
        
        wifi_band_v  = v["wifi_band"]
        disabled_v   = v["disabled"]
        hidden_v     = v["hidden"]
        channel_v    = v["channel"]
        wlanWidth_v  = v["wlanWidth"]
        ssid_v       = v["ssid"]
        key_v        = v["password"]
        encryption_v = v["encryption"]
        encry_alg_v  = v["encry_alg"]
        txpower_v    = v["power"]
        
        -- wifi_band: 0=2.4G; 1=5G
        if wifi_band_v == WIFI_2G then
            idx = 0
            dev_name = DEV_2G
        else
            idx = 4
            dev_name = DEV_5G
        end
        
        if disabled_v and disabled_v == "1"  then
            -- Disable wifi interface.
            luci.sys.exec(string.format("uci set wireless.@wifi-iface[%d].disabled=%s", idx, disabled_v))
            luci.sys.exec('uci commit wireless')
        else
            local encry_alg_s              
            if encry_alg_v == '3' then
                encry_alg_s = "+tkip+ccmp"
            elseif encry_alg_v == '2' then
                encry_alg_s = "+tkip"
            elseif encry_alg_v == '1' then
                encry_alg_s = "+ccmp"
            else
                encry_alg_s = ""
            end    
            
            -- D-link fixed value. 
            encry_alg_s = "+ccmp"
            
            local encry_s              
            if encryption_v == '1' or encryption_v == '2' then
                encry_s = "wep-open"
                luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].key1="%s"', idx, cvt_char(key_v) ))
            elseif encryption_v == '3' then
                encry_s = "psk".. encry_alg_s
            elseif encryption_v == '4' then
                encry_s = "psk2".. encry_alg_s
            elseif encryption_v == '5' or encryption_v == 5 then
                encry_s = "psk-mixed".. encry_alg_s
            else
                encry_s = "none"
            end
            
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].disabled=%s', idx, disabled_v))
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].ssid="%s"', idx, cvt_char(ssid_v) ))
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].encryption="%s"', idx, encry_s))
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].key="%s"', idx, cvt_char(key_v) ))
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].hidden=%s', idx, hidden_v))
            luci.sys.exec(string.format('uci set wireless.%s.channel=%s', dev_name, channel_v))
            
            if txpower_v and txpower_v ~= "" then
                if txpower_v == '0' or txpower_v == 0 then
                    luci.sys.exec(string.format('uci set wireless.%s.txpower=40', dev_name))
                elseif txpower_v == '1' or txpower_v == 1 then
                    luci.sys.exec(string.format('uci set wireless.%s.txpower=60', dev_name))
                else
                    luci.sys.exec(string.format('uci set wireless.%s.txpower=100', dev_name))
                end 
            end
            
            -- Wifi band width and channel 
            if wifi_band_v == WIFI_2G then
                luci.sys.exec('uci set misc.wifi.dw_g24=' .. wlanWidth_v)
                
                if wlanWidth_v == '0' then  --auto
                    luci.sys.exec(string.format('uci set wireless.%s.bw=1', dev_name))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', dev_name))
                elseif wlanWidth_v == '1' then  -- 20MHz
                    luci.sys.exec(string.format('uci set wireless.%s.bw=0', dev_name))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', dev_name))
                elseif wlanWidth_v == '2' then  --40MHz
                    luci.sys.exec(string.format('uci set wireless.%s.bw=1', dev_name))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', dev_name))
                end
            else
                luci.sys.exec('uci set misc.wifi.dw_g5=' .. wlanWidth_v)
                
                if channel_v == '165' then
                    luci.sys.exec(string.format('uci set wireless.%s.wifimode=8', dev_name))
                else
                    if wlanWidth_v == '0'  or wlanWidth_v == '3' then  -- auto and 80MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=1', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=1', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=14', dev_name))
                    elseif wlanWidth_v == '1' then    --20MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=0', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=0', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=8', dev_name))
                    elseif wlanWidth_v == '2' then   --40MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=1', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=0', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', dev_name))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=14', dev_name))
                    end
                end
            end
        
            luci.sys.exec('uci commit wireless')
            luci.sys.exec('uci commit misc')
        end
        
        -- apply wifi separately.
        local ifc_name
        if wifi_band_v == WIFI_2G then ifc_name = "ra0" else ifc_name = "rai0" end
        if disabled_v == "0" then 
            local sys = require "luci.controller.admin.system"
            if wifi_band_v == WIFI_2G then
                -- sys.fork_exec(string.format("/sbin/apply_wifi_single.sh %s enable; /sbin/apply_wifi_single.sh %s channel", ifc_name, ifc_name))
                -- just for mt7628
                sys.fork_exec(string.format("/sbin/apply_wifi_single.sh %s enable;", ifc_name))
            else
                sys.fork_exec(string.format("/sbin/apply_wifi_single.sh %s channel; /sbin/apply_wifi_single.sh %s enable", ifc_name, ifc_name))
            end

            if wifi_band_v == WIFI_2G and channel_v == "0" then
                luci.sys.exec('sh /usr/sbin/channel_select.sh')
            end
        else
            luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s disable', ifc_name))
        end
    end
        
    return  
end


function apply_2g_wifi_setting()
    apply_wifi_setting(WIFI_2G)
    return
end


function apply_5g_wifi_setting()
    apply_wifi_setting(WIFI_5G)
    return
end


function get_wifi_enable(wifi_band)
    local uci = require "luci.model.uci".cursor()
    local i, device_name, main_ifc, wifi_disable_v, Switch_v
    
    -- wifi_band: 0=2.4G; 1=5G
    if wifi_band == WIFI_2G then
        device_name = DEV_2G
        main_ifc = "ra0"
    else
        device_name = DEV_5G
        main_ifc = "rai0"
    end
    
    for i = 0, 7 do 
        if (string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].device', i))) == device_name and 
            string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i))) == main_ifc) then
            wifi_disable_v = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].disabled', i)))
            break
        end
    end
    
    if wifi_disable_v and wifi_disable_v == '1' then
        Switch_v = ENABLE_OFF
    else
        Switch_v = ENABLE_ON
    end 
    
    local radio_v = string.trim(luci.sys.exec(string.format('uci get wireless.%s.radio', device_name)))
    if radio_v and radio_v == '0' then
        Switch_v = ENABLE_OFF
    end    
        
    local resp_s = {}
    resp_s = {
        Switch = Switch_v
    }
        
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_2g_wifi_enable()
    get_wifi_enable(WIFI_2G)
    return
end

function get_5g_wifi_enable()
    get_wifi_enable(WIFI_5G)
    return
end


function apply_wifi_enable(wifi_band)
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
      
    if rcv_succ == 1 then
        local wifi_enable_v = rcv_json["Switch"]
        if wifi_enable_v == 1 or wifi_enable_v == '1' then
            wifi_enable_v = '0'    
        else
            wifi_enable_v = '1'
        end

        -- wifi_band: 0=2.4G; 1=5G
        if wifi_band == WIFI_2G then
            -- when enable main ssid, then set the radio as 1.
            if wifi_disable_v == 0 then
                luci.sys.exec(string.format('uci set wireless.%s.radio=1', DEV_2G))
            end    
            luci.sys.exec("uci set wireless.@wifi-iface[0].disabled=" .. wifi_enable_v)
        else
            if wifi_disable_v == 0 then
                luci.sys.exec(string.format('uci set wireless.%s.radio=1', DEV_5G))
            end 
            luci.sys.exec("uci set wireless.@wifi-iface[4].disabled=" .. wifi_enable_v)
        end
        
        luci.sys.exec('uci commit wireless')
        
        -- apply wifi separately.
        local action, ifc_name
        if wifi_enable_v == '0' then action = "enable" else action = "disable" end    
        if wifi_band == WIFI_2G then ifc_name = "ra0" else ifc_name = "rai0" end
        luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s %s', ifc_name, action))
        
        -- restart wifi
        -- local sys = require "luci.controller.admin.system"
        -- sys.fork_exec("sleep 1;wifi fast")
    end    

    return
end


function apply_2g_wifi_enable()
    apply_wifi_enable(WIFI_2G)
    return
end

function apply_5g_wifi_enable()
    apply_wifi_enable(WIFI_5G)
    return
end


function WebService()
    local client = os.getenv("REMOTE_ADDR")
    local GET = os.getenv("QUERY_STRING")
    
    local POST = nil
    local POSTLength = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    if (POSTLength > 0) then
        POST = io.read(POSTLength)
        --POST = io.read("*a")
    end

    -- Fast-CGI+HTTP require HEADER
    -- enable cache
    -- io.write("Content-type: text/html\n\n")
    -- disable cache, especially for Internet Explorer
    
    -- cwx: io functions are working well.  don't delete below codes.
    -- io.write("Content-type: application/json\nPragma: no-cache\n\n")
    -- io.write(resp_s)
    
    io.write("Content-type: application/json\nPragma: no-cache\n\n")

    local reply = string.format("Client %s said: url: [%s], data: [%s]\n", client or '-', GET or '-', POST or '-')
    io.write(reply)
end


-- No.20
function get_lan_setting()
    local ignore_v, start_v, limit_v, ipaddr_v, netmask_v, Switch_v ,end_v
    
    ignore_v  = uci.get("dhcp", "lan", "ignore")
    start_v   = uci.get("dhcp", "lan", "start")
    limit_v   = uci.get("dhcp", "lan", "limit")
    ipaddr_v  = uci.get("network", "lan", "ipaddr")
    netmask_v = uci.get("network", "lan", "netmask")
    end_v = start_v + limit_v - 1
    
    if ignore_v then
        if ignore_v == '1' then
            Switch_v = ENABLE_OFF
        else
            Switch_v = ENABLE_ON
        end
    else
        Switch_v = ENABLE_ON
    end

    local subnet, ipbyte = ipaddr_v:match("(%d+.%d+.%d+).(%d+)")
    start_v = string.format("%s.%s", subnet, start_v)
    limit_v = string.format("%s.%d", subnet, end_v)
    
    local resp_s = {} 
    resp_s = {
        Switch = Switch_v,
        ip = ipaddr_v,
        mask = netmask_v,
        startip = start_v,
        endip = limit_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_network_setting()
    local ignore_v, start_v, limit_v, ipaddr_v, netmask_v, Switch_v ,end_v, leasetime_v, wanport_speed_v, upnp_enable_v

    ipaddr_v    = uci.get("network", "lan", "ipaddr")
    netmask_v   = uci.get("network", "lan", "netmask")
    ignore_v    = uci.get("dhcp", "lan", "ignore")
    start_v     = uci.get("dhcp", "lan", "start")
    limit_v     = uci.get("dhcp", "lan", "limit")
    leasetime_v = uci.get("dhcp", "lan", "leasetime")
    end_v       = tostring(tonumber(start_v) + tonumber(limit_v) - 1)
    wanport_speed_v = uci.get("misc", "wanport", "speed")
    upnp_enable_v   = uci.get("misc", "upnp", "enable")
    
    if string.find(leasetime_v, 'h') then
        local hour, _ = leasetime_v:match("^(%d+)h")
        leasetime_v = tostring(hour * 60)
    elseif string.find(leasetime_v, 'm') then    
        local min, _ = leasetime_v:match("^(%d+)m")
        leasetime_v = tostring(min)
    else
        -- default: 12h
        leasetime_v = "720"
    end

    if ignore_v and ignore_v == '1' then
        Switch_v = ENABLE_OFF
    else
        Switch_v = ENABLE_ON
    end

    if not wanspeed_v then wanspeed_v = 0 end
    if not upnp_enable_v then upnp_enable_v = 0 end
    
    local upnp_portmap_s 
    local upnp_portmap_list = {}
    if upnp_enable_v == "1" then
        upnp_portmap_s = string.trim(luci.sys.exec('iptables -v -n -t nat -L MINIUPNPD  | grep "DNAT"'))
        if upnp_portmap_s ~= "" then
            local portmap_arr = string_readln(upnp_portmap_s)

            for i, v in pairs(portmap_arr) do  
                if v ~= '' then
                    local _, prot_v, wan_port_v, lan_ip_v, lan_port_v = v:match("^(.*)%s+(%S+)%sdpt:(%S+)%sto:(%S+):(%S+)")
                    if prot_v then
                        upnp_portmap_list[i] = {
                            prot = prot_v,
                            wan_port = wan_port_v,
                            lan_ip = lan_ip_v,
                            lan_port = lan_port_v   
                        }
                    end 
                end    
            end
        end
    end
    
    local resp_s = {} 
    resp_s = {
        Switch = Switch_v,
        ip = ipaddr_v,
        mask = netmask_v,
        startip = start_v,
        endip = end_v,
        leasetime = leasetime_v,
        wanport_speed = wanport_speed_v,
        upnp_enable = upnp_enable_v,
        upnp_portmap_list = upnp_portmap_list
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_qos_setting()
    local enabled, upload, download, high_pri_list, medium_pri_list, low_pri_list
    enabled  = uci.get("qos", "wan", "enabled")
    upload   = uci.get("qos", "wan", "upload")
    download = uci.get("qos", "wan", "download")
    upload   = tostring(math.modf(tonumber(upload)/1024))
    download = tostring(math.modf(tonumber(download)/1024))
    
    local uci = require("uci").cursor()
    qos_pri_list = {}
    qos_pri = 2
    i = 0
    
    -- find "classify" section. 
    uci:foreach("qos", "classify", 
    function(s)
        if s.mac then
            i = i + 1
            if s.target == "Express" then
                qos_pri = 3
            elseif s.target == "Bulk" then    
                qos_pri = 1
            else
                qos_pri = 2
            end    
            
            qos_pri_list[i] = {
                mac = s.mac,
                ip  = s.dsthost,
                qos_pri = qos_pri
            }
        end
    end)
    
    local resp_s = {} 
    resp_s = {
        enabled = enabled,
        upload = upload,
        download = download,
        qos_pri_list = qos_pri_list
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_qos_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    

    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)

    if rcv_succ == 0 then return end
    
    local enabled, upload, download 
    enabled  = rcv_json["enabled"]
    upload   = rcv_json["upload"]
    download = rcv_json["download"]
    upload   = tostring(tonumber(upload) * 1024)
    download = tostring(tonumber(download) * 1024)
    
    if enabled then uci.set("qos", "wan", "enabled", enabled) end
    uci.set("qos", "wan", "upload", upload)
    uci.set("qos", "wan", "download", download)
    uci.commit("qos")
    
    local i, idx, qos_pri
    while true do
        i = -1
        idx = -1
        uci:foreach("qos", "classify", function(s)
            i = i + 1  
            if s.mac then
                idx=i
                return false
            end 
        end)
        
        if idx >= 0 then
            luci.sys.exec(string.format('uci delete qos.@classify[%d]', idx)) 
            uci:commit("qos")
        else
            break
        end
    end
    
    idx = -1
    uci:foreach("qos", "classify", function(s) idx = idx + 1  end)
        
    qos_pri_list = rcv_json["qos_pri_list"]
    for i, v in ipairs(qos_pri_list) do
        local ip_v, mac_v, qos_pri_v
        ip_v      = v["ip"]
        mac_v     = v["mac"]
        qos_pri_v = v["qos_pri"]
        idx = idx + 1
        
        luci.sys.exec("uci add qos classify")
        luci.sys.exec(string.format('uci set qos.@classify[%d].mac=%s',        idx, mac_v))
        luci.sys.exec(string.format('uci set qos.@classify[%d].dsthost=%s',    idx, ip_v))
        if qos_pri_v == 3 then
            luci.sys.exec(string.format('uci set qos.@classify[%d].target=%s', idx, "Express"))
        elseif qos_pri_v == 2 then   
            luci.sys.exec(string.format('uci set qos.@classify[%d].target=%s', idx, "Normal"))
        elseif qos_pri_v == 1 then   
            luci.sys.exec(string.format('uci set qos.@classify[%d].target=%s', idx, "Bulk"))
        else
            luci.sys.exec(string.format('uci set qos.@classify[%d].target=%s', idx, "Normal"))
        end
    end
    uci:commit("qos")
    
    -- qos-start
    luci.sys.exec("qos-stop; qos-start")
            
    return  
end


function apply_network_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    

    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)

    if rcv_succ == 0 then return end
    
    local ipaddr_v, netmask_v, ignore_v, start_v, end_v, limit_v, leasetime_v, wanport_speed_v, upnp_enable_v 
    if rcv_json["Switch"] == 1 then ignore_v = '0' else ignore_v = '1' end
    ipaddr_v        = rcv_json["ip"]
    netmask_v       = rcv_json["mask"]
    start_v         = rcv_json["startip"]
    end_v           = rcv_json["endip"]
    leasetime_v     = rcv_json["leasetime"]
    wanport_speed_v = rcv_json["wanport_speed"]
    upnp_enable_v   = rcv_json["upnp_enable"]
    limit_v         = tonumber(end_v) - tonumber(start_v) + 1
        
    luci.sys.exec(string.format('uci set network.lan.ipaddr=%s', ipaddr_v))
    luci.sys.exec(string.format('uci set network.lan.netmask=%s', netmask_v))
    luci.sys.exec(string.format('uci set dhcp.lan.ignore=%s', ignore_v))
    luci.sys.exec(string.format('uci set dhcp.lan.ignore_orig=%s', ignore_v))
    luci.sys.exec(string.format('uci set dhcp.lan.start=%s', start_v))
    luci.sys.exec(string.format('uci set dhcp.lan.limit=%s', limit_v))
    luci.sys.exec(string.format('uci set dhcp.lan.leasetime=\"%sm\"', leasetime_v))
    luci.sys.exec(string.format('uci set misc.wanport.speed=%s', wanport_speed_v))
    luci.sys.exec(string.format('uci set misc.upnp.enable=%s', upnp_enable_v))
    
    luci.sys.exec('uci commit network')
    luci.sys.exec('uci commit dhcp')
    luci.sys.exec('uci commit misc')
           
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("/etc/init.d/network restart")
            
    return
end


function apply_lan_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local ignore_v, ipaddr_v, netmask_v, start_v, limit_v 

        if rcv_json["Switch"] == 1 then
            ignore_v = '0'
        else
            ignore_v = '1'
        end
        
        ipaddr_v   = rcv_json["ip"]
        netmask_v  = rcv_json["mask"]
        start_v    = rcv_json["startip"]
        limit_v    = rcv_json["endip"]
        
        luci.sys.exec(string.format('uci set dhcp.lan.ignore=%s', ignore_v))
        luci.sys.exec(string.format('uci set dhcp.lan.ignore_orig=%s', ignore_v))
        luci.sys.exec(string.format('uci set network.lan.ipaddr=%s', ipaddr_v))
        luci.sys.exec(string.format('uci set network.lan.netmask=%s', netmask_v))
        
        if ignore_v == '0' then
            local b1, b2, b3, startip_b4, limitip_b4
            
            b1, b2, b3, startip_b4 = start_v:match("^(%d+).(%d+).(%d+).(%d+)")
            b1, b2, b3, limitip_b4 = limit_v:match("^(%d+).(%d+).(%d+).(%d+)")
            
            luci.sys.exec(string.format('uci set dhcp.lan.start=%s', startip_b4))
            luci.sys.exec(string.format('uci set dhcp.lan.limit=%d', limitip_b4 - startip_b4+1))
        end
                    
        luci.sys.exec('uci commit network')
        luci.sys.exec('uci commit dhcp')
    end
           
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("/etc/init.d/network restart")
            
    return  
end


-- No.22
function get_mac_clone()
    local host_v, Switch_v, cur_mac, factory_mac
    
    host_v      = luci.sys.net.ip4mac(os.getenv("REMOTE_ADDR"))
    cur_mac     = uci.get("network", "wan", "macaddr")
    factory_mac = get_factory_wan_mac()
    
    if cur_mac and cur_mac ~= factory_mac then
        Switch_v = 1
    else
        Switch_v = 0
    end    
    
    local resp_s = {} 
    resp_s = {
        Switch = Switch_v,
        -- pc mac
        host   = host_v,
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_mac_clone()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local host_v, Switch_v

        Switch_v = rcv_json["Switch"]
        host_v   = rcv_json["host"]
        
        if Switch_v == ENABLE_ON then
            uci.set("network", "wan", "macaddr", host_v)
        else
            local factory_mac = get_factory_wan_mac()
            uci.set("network", "wan", "macaddr", factory_mac)
        end
        uci.commit("network")
    end

    -- before MAC clone, should ifdown wan interface, just look like below. ~_~
    luci.sys.exec("env -i /sbin/ifdown wan") 

    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("/etc/init.d/network restart")
    
    return  
end


function get_wifi_channel(wifi_band)
    local channel_v, wlanWidth_v
    
    if wifi_band == WIFI_2G then
        channel_v   = string.trim(luci.sys.exec(string.format('uci get wireless.%s.channel', DEV_2G)))
        wlanWidth_v = string.trim(luci.sys.exec('uci get misc.wifi.dw_g24'))
    else
        channel_v   = string.trim(luci.sys.exec(string.format('uci get wireless.%s.channel', DEV_5G)))
        wlanWidth_v = string.trim(luci.sys.exec('uci get misc.wifi.dw_g5'))
    end
    
    local resp_s = {}
    resp_s = {
        channel   = channel_v,
        wlanWidth = wlanWidth_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_multi_ssid(wifi_band)
    local uci = require "luci.model.uci".cursor()
    local i, index_v, ssid_v, key_v, key1_v, encryption_s, encryption_v,encry_alg_v, disable_v
    local rv = {} 
    local device_name, main_ifc
    
    -- wifi_band: 0=2.4G; 1=5G
    if wifi_band == WIFI_2G then
        device_name = DEV_2G
        main_ifc = "ra0"
    else
        device_name = DEV_5G
        main_ifc = "rai0"
    end
    
    index_v = 0
    for i = 0, 7 do 
        if string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].device', i))) == device_name then
            if string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i))) ~= main_ifc then
                index_v = index_v + 1
                disabled_v   = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].disabled', i)))
                ssid_v       = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ssid', i)))
                key_v        = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].key', i)))
                key1_v       = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].key1', i)))
                encryption_s = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].encryption', i)))
              
                if string.find(encryption_s, 'mixed') ~= nil then
                    encryption_v = 5
                elseif string.find(encryption_s, 'psk2') ~= nil then
                    encryption_v = 4
                elseif string.find(encryption_s, 'psk') ~= nil then
                    encryption_v = 3
                elseif string.find(encryption_s, 'wep') ~= nil then
                    if string.len(key1_v) >= 13 then
                        encryption_v = 2
                    else
                        encryption_v = 1
                    end    
                
                    key_v = key1_v    
                else
                    encryption_v = 0
                end

                if string.find(encryption_s, 'ccmp') ~= nil and string.find(encryption_s, 'tkip') ~= nil then
                    encry_alg_v = 3
                elseif string.find(encryption_s, 'tkip') ~= nil then
                    encry_alg_v = 2
                elseif string.find(encryption_s, 'ccmp') ~= nil then
                    encry_alg_v = 1
                else
                    encry_alg_v = 0
                end

                if disabled_v == 1 or disabled_v =='1' then
                    disabled_v=0
                else
                    disabled_v=1
                end    
                
                rv[#rv+1] = {
                    index = index_v,
                    Switch = disabled_v,
                    ssid   = ssid_v,
                    pwd = key_v,
                    encryption = encryption_v,
                    encry_alg  = encry_alg_v
                }
            end
        end    
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write('{"list":')
    luci.http.write_json(rv)
    luci.http.write('}')
        
    return
end


function set_multi_ssid(wifi_band)
    local uci = require "luci.model.uci".cursor()
    local index_v, ssid_v, key_v, encryption_s, encryption_v, encry_alg_v,disabled_v
    local i, device_name, ifc_name
    
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        index_v      = tonumber(rcv_json["index"])
        ssid_v       = rcv_json["ssid"]
        key_v        = rcv_json["pwd"]
        encryption_v = rcv_json["encryption"]
        encry_alg_v  = rcv_json["encry_alg"]
        if rcv_json["Switch"] == 1 then
            disable_v = 0
        else
            disable_v = 1
        end        
 
        -- wifi_band: 0=2.4G; 1=5G
        if wifi_band == WIFI_5G then index_v = index_v + 4 end 
        
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].disabled=%s', index_v, disable_v))
        luci.sys.exec(string.format("uci set wireless.@wifi-iface[%d].ssid=\"%s\"", index_v, ssid_v))
        luci.sys.exec(string.format("uci set wireless.@wifi-iface[%d].key='%s'", index_v, key_v))
            
        local encry_alg_s              
        if encry_alg_v == '3' then
            encry_alg_s = "+tkip+ccmp"
        elseif encry_alg_v == '2' then
            encry_alg_s = "+tkip"
        elseif encry_alg_v == '1' then
            encry_alg_s = "+ccmp"
        else
            encry_alg_s = ""
        end    
            
        local encry_s              
        if encryption_v == '1' or encryption_v == '2' then
            encry_s = "wep-open"
            luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].key1=%s', index_v, key_v))
        elseif encryption_v == '3' then
            encry_s = "psk"..encry_alg_s
        elseif encryption_v == '4' then
            encry_s = "psk2"..encry_alg_s
        elseif encryption_v == '5' then
            encry_s = "psk-mixed"..encry_alg_s
        else
            encry_s = "none"
        end 
            
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[%d].encryption=%s', index_v, encry_s))
        luci.sys.exec('uci commit wireless')
        
        -- apply wifi separately.
        local action
        if disable_v == 0 then action = "enable" else action = "disable" end    
        if wifi_band == WIFI_2G then 
            ifc_name = "ra"..index_v 
        else 
            index_v = index_v - 4
            ifc_name = "rai"..index_v 
        end
        luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s %s', ifc_name, action))
        
        -- restart wifi
        -- local sys = require "luci.controller.admin.system"
        -- sys.fork_exec("sleep 1;wifi fast")                         
    end
    
    return
end


function apply_2g_multi_ssid()
    set_multi_ssid(WIFI_2G)
    return
end


function apply_5g_multi_ssid()
    set_multi_ssid(WIFI_5G)
    return
end


function get_2g_multi_ssid()
    get_multi_ssid(WIFI_2G)
    return
end


function get_5g_multi_ssid()
    get_multi_ssid(WIFI_5G)
    return
end

function get_2g_channel()
    get_wifi_channel(WIFI_2G)
    return
end

function get_5g_channel()
    get_wifi_channel(WIFI_5G)
    return
end

function apply_wifi_channel(wifi_band)
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
      luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local channel_v, wlanWidth_v
        
        channel_v   = rcv_json["channel"]
        wlanWidth_v = rcv_json["wlanWidth"]
        
        if channel_v ~= nil and wlanWidth_v ~= nil then
            if wifi_band == WIFI_2G then
                luci.sys.exec(string.format('uci set wireless.%s.channel=%s', DEV_2G, channel_v))
                luci.sys.exec('uci set misc.wifi.dw_g24=' .. wlanWidth_v)
                
                if wlanWidth_v == '0' then  --auto
                    luci.sys.exec(string.format('uci set wireless.%s.bw=1', DEV_2G))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', DEV_2G))
                elseif wlanWidth_v == '1' then  -- 20MHz
                    luci.sys.exec(string.format('uci set wireless.%s.bw=0', DEV_2G))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', DEV_2G))
                elseif wlanWidth_v == '2' then  --40MHz
                    luci.sys.exec(string.format('uci set wireless.%s.bw=1', DEV_2G))
                    luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', DEV_2G))
                end
            else
                luci.sys.exec(string.format('uci set wireless.%s.channel=%s', DEV_5G, channel_v))
                luci.sys.exec('uci set misc.wifi.dw_g5=' .. wlanWidth_v)
                
                if channel_v == '165' then
                    luci.sys.exec(string.format('uci set wireless.%s.wifimode=8', DEV_5G))
                else
                    if wlanWidth_v == '0'  or wlanWidth_v == '3' then  -- auto and 80MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=1', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=1', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=14', DEV_5G))
                    elseif wlanWidth_v == '1' then    --20MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=0', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=0', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=1', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=8', DEV_5G))
                    elseif wlanWidth_v == '2' then   --40MHz
                        luci.sys.exec(string.format('uci set wireless.%s.bw=1', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.vht_bw=0', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.ht_bsscoexist=0', DEV_5G))
                        luci.sys.exec(string.format('uci set wireless.%s.wifimode=14', DEV_5G))
                    end
                end
            end
        
            luci.sys.exec('uci commit wireless')
            luci.sys.exec('uci commit misc')             
            
            -- apply wifi separately.
            local ifc_name
            if wifi_band == WIFI_2G then ifc_name = "ra0" else ifc_name = "rai0" end
            luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s channel', ifc_name))
            
            if wifi_band == WIFI_2G and channel_v == "0" then
                luci.sys.exec('sh /usr/sbin/channel_select.sh')
            end
            
            -- restart wifi
            -- local sys = require "luci.controller.admin.system"
            -- sys.fork_exec("sleep 1;wifi")           
        end
    end    
        
    return  
end

function apply_2g_channel()
    apply_wifi_channel(WIFI_2G)
    return
end

function apply_5g_channel()
    apply_wifi_channel(WIFI_5G)
    return
end

-- get the current enduser name, the enduser name and password can be modified.
function get_enduser_name()
    local def_enduser_name = 'user'
    local ln = string.trim(luci.sys.exec("cat /etc/passwd | grep '500:500'"))
    local enduser_name = ln:match("^(%S-):(.*)")
    
    if enduser_name and enduser_name ~= "" then
        return enduser_name
    else
        return def_enduser_name
    end    
end


function modify_enduser_account(old_enduser_name, new_enduser_name, new_enduser_passwd)
    local cfg_str
    cfg_str = string.trim(luci.sys.exec("cat /etc/passwd"))
    cfg_str = cfg_str:gsub(old_enduser_name, new_enduser_name)
    luci.sys.exec(string.format("echo '%s' > /etc/passwd", cfg_str))
    
    cfg_str = string.trim(luci.sys.exec("cat /etc/shadow"))
    cfg_str = cfg_str:gsub(old_enduser_name, new_enduser_name)
    luci.sys.exec(string.format("echo '%s' > /etc/shadow", cfg_str))

    luci.sys.user.setpasswd(new_enduser_name, new_enduser_passwd)
end

function login()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    

    local username = rcv_json["username"]
    local passwd   = rcv_json["password"]
    if username and (username == 'CMCCAdmin' or username == get_enduser_name()) and passwd and luci.sys.user.checkpasswd(username, passwd) then
        set_login_user(username)
        luci.sys.exec("touch /tmp/login_succ.flg")
        
        resp_s = '{"result":0, "msg":"..."}'
    else
        if username and username ~= 'CMCCAdmin' and username ~= get_enduser_name() then
            resp_s = '{"result":1, "err": 0, "msg":"username error."}'
        else     
            resp_s = '{"result":1, "err": 1, "msg":"password error."}'
        end    
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    return  
end


function logout()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    local dsp = require "luci.dispatcher"
      local sauth = require "luci.sauth"
      if dsp.context.authsession then
            sauth.kill(dsp.context.authsession)
            dsp.context.urltoken.stok = nil
      end

      --luci.http.header("Set-Cookie", "sysauth=; path=" .. dsp.build_url())
      --luci.http.redirect(luci.dispatcher.build_url())
          
    return  
end

function get_wps(wifi_band)
    local wps_v, Switch_v
    
    if wifi_band == WIFI_2G then
        wps_v = uci.get("misc", "wifi", "wps_g24")
    else
        wps_v = uci.get("misc", "wifi", "wps_g5")
    end
    
    if wps_v and wps_v ~= "" then
        if wps_v == "1" then
            Switch_v = 1
        else
            Switch_v = 0
        end    
    else
        Switch_v = 1
    end
    
    local resp_s = {}
    resp_s = {
        Switch = Switch_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end

function get_2g_wps()
    get_wps(WIFI_2G)
    return
end

function get_5g_wps()
    get_wps(WIFI_5G)
    return
end


function apply_wps_pbc()
    local cjson = require "cjson"
    local sys = require "luci.controller.admin.system"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local sys = require "luci.controller.admin.system"   
    local wifitype_v = rcv_json["wifitype"]
    if wifitype_v == WIFI_2G then
        sys.fork_exec("/etc/btnd/wps_click.sh 2")           
    else
        sys.fork_exec("/etc/btnd/wps_click.sh 5")           
    end
        
    return  
end


function apply_wps(wifi_band)
    local cjson = require "cjson"
    local sys = require "luci.controller.admin.system"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
       
    local wps_v = rcv_json["Switch"]
    if wifi_band == WIFI_2G then
        uci.set("misc", "wifi", "wps_g24", wps_v)
    else
        uci.set("misc", "wifi", "wps_g5", wps_v)
    end
    uci.commit("misc")
    
    return  
end

function apply_2g_wps()
    apply_wps(WIFI_2G)
    return
end

function apply_5g_wps()
    apply_wps(WIFI_5G)
    return
end

function get_roaming(wifi_band)
    local rssi_v, Switch_v
    
    if wifi_band == WIFI_2G then
        rssi_v = uci.get("wireless", DEV_2G, "lowrssi")
    else
        rssi_v = uci.get("wireless", DEV_5G, "lowrssi")
    end
    
    if rssi_v ~= nil then
        if rssi_v == '0' then
            -- disable roaming 
            Switch_v = 1
        else
            -- enable roaming 
            Switch_v = 0
        end
    else
        -- disable roaming 
        Switch_v = 1
        rssi = '0'
    end    
    
    local resp_s = {}
    resp_s = {
        Switch = Switch_v,
        rssi   = rssi_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end

function get_2g_roaming()
    get_roaming(WIFI_2G)
    return
end

function get_5g_roaming()
    get_roaming(WIFI_5G)
    return
end

function apply_roaming(wifi_band)
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local rssi_v, Switch_v

        Switch_v = rcv_json["Switch"]
        rssi_v   = rcv_json["rssi"]
         
        
        if wifi_band == WIFI_2G then
            if Switch_v == 0 then
                uci.set("wireless", DEV_2G, "lowrssi", switch_v)
            else
                uci.set("wireless", DEV_2G, "lowrssi", rssi_v)
            end
        else
            if Switch_v == 0 then
                uci.set("wireless", DEV_5G, "lowrssi", switch_v)
            else
                uci.set("wireless", DEV_5G, "lowrssi", rssi_v)
            end
        end
      
        uci.commit("wireless")
        local sys = require "luci.controller.admin.system"
        sys.fork_exec("wifi&")    
    end    
        
    return  
end

function apply_2g_roaming()
    apply_roaming(WIFI_2G)
    return
end

function apply_5g_roaming()
    apply_roaming(WIFI_5G)
    return
end


function get_gw_mode()
    local gw_mode_v = uci.get("internet", "config", "mode")
    local wisptype_v = nil
    local resp_s
    
    if gw_mode_v == 'routerwisp' then
        -- repeater mode
        if uci.get("wireless", DEV_2G, "apclienable") == '1' then
            -- 2.4G apcli0
            wisptype_v = 0
        elseif uci.get("wireless", DEV_5G, "apclienable") == '1' then
            -- 5.8G apclii0
            wisptype_v = 1
        else
            wisptype_v = 0
        end    
        
        resp_s = {
            mode = gw_mode_v,
            wisptype = wisptype_v
        }
    elseif gw_mode_v == 'autodhcp' then
        local real_mode_v = uci.get("system", "board", "type")
        
        resp_s = {
            mode = gw_mode_v,
            real_mode = real_mode_v
        }
    else
        resp_s = {
            mode = gw_mode_v
        }
    end

    -- change wizard flag.
    chg_wzd_flg()

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_wizard()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then 
        return
    end
    
    local sys = require "luci.controller.admin.system"   
    local uci = require "luci.model.uci".cursor()
        
    local mode_v, ssid2g_v, pwd2g_v, encry2g_v, ssid5g_v, pwd5g_v, encry5g_v, adminPass_v
    
    mode_v      = rcv_json["mode"]
    ssid2g_v    = rcv_json["ssid2g"]
    pwd2g_v     = rcv_json["pwd2g"]
    encry2g_v   = rcv_json["encry2g"]
    adminPass_v = rcv_json["adminPass"]
        
    luci.sys.exec(string.format("uci set wireless.@wifi-iface[0].ssid=\"%s\"", ssid2g_v))
    luci.sys.exec(string.format("uci set wireless.@wifi-iface[0].key='%s'", pwd2g_v))
    luci.sys.exec(string.format('uci set wireless.@wifi-iface[0].encryption=%s', 'psk-mixed+ccmp'))
    
    if MODEL_TYPE == 1 then
        ssid5g_v    = rcv_json["ssid5g"]
        pwd5g_v     = rcv_json["pwd5g"]
        encry5g_v   = rcv_json["encry5g"]
        luci.sys.exec(string.format("uci set wireless.@wifi-iface[4].ssid=\"%s\"", ssid5g_v))
        luci.sys.exec(string.format("uci set wireless.@wifi-iface[4].key='%s'", pwd5g_v))
        luci.sys.exec(string.format('uci set wireless.@wifi-iface[4].encryption=%s', 'psk-mixed+ccmp'))
    end
    luci.sys.exec('uci commit wireless')
        
    -- modify pwd of admin account.
    if adminPass_v then
        luci.sys.user.setpasswd("CMCCAdmin", adminPass_v)
    end       
 
    if mode_v == "bridgedhcp" then
        uci.set("internet", "config", "mode", "bridgedhcp")
    elseif mode_v == "routerdhcp" then
        uci.set("internet", "config", "mode", "routerdhcp")
    elseif mode_v == "autodhcp" then
        uci.set("internet", "config", "mode", "autodhcp")
    elseif mode_v == "routerstatic" then
        -- static    
        uci.set("internet", "config", "mode", "routerstatic")
            
        local ipaddr_v, netmask_v, gateway_v, dns_v
        ipaddr_v  = rcv_json["ip"]
        netmask_v = rcv_json["mask"]
        gateway_v = rcv_json["gateway"]
        dns_v     = rcv_json["dns"]
    
        uci.set("internet", "config", "routeripaddr",  ipaddr_v)
        uci.set("internet", "config", "routernetmask", netmask_v)
        uci.set("internet", "config", "routergateway", gateway_v)
        if dns_v and dns_v ~= "" then
            local dns1_v, dns2_v
            local p = string.find(dns_v, ' ')
            if p ~= nil then
                dns1_v = string.trim(string.sub(dns_v, 1, p-1))
                dns2_v = string.trim(string.sub(dns_v, p+1))
            else
                dns1_v = dns_v   
                dns2_v = ""
            end     
             
            uci.set("internet", "config", "routerdns1", dns1_v)
            uci.set("internet", "config", "routerdns2", dns2_v)
        else
            uci.set("internet", "config", "routerdns1", gateway_v)
            uci.set("internet", "config", "routerdns2", "")
        end 
 
    elseif mode_v == "routerpppoe" then
        -- pppoe
        uci.set("internet", "config", "mode", "routerpppoe")
                
        local pppoe_username_v, pppoe_password_v
        pppoe_username_v = rcv_json["account"]
        pppoe_password_v = rcv_json["pppoePwd"]
        uci.set("internet", "config", "id", pppoe_username_v)
        uci.set("internet", "config", "pwd", pppoe_password_v)
    else
        -- repeater mode
        uci.set("internet", "config", "mode", "routerwisp")
                
        local wisptype_v,linkPwd_v, ssid_v, security_v, channel_v
        wisptype_v = rcv_json["wisptype"]
        linkPwd_v  = rcv_json["linkPwd"]
        ssid_v     = rcv_json["ssid"]
        security_v = rcv_json["security"]
        channel_v  = rcv_json["channel"]
        
        uci.set("internet", "config", "wisptype", wisptype_v)
        uci.set("internet", "config", "ssid", ssid_v)
        uci.set("internet", "config", "wirelesspwd", linkPwd_v)
        uci.set("internet", "config", "auth", security_v)
        
        if wisptype_v == '0' then
            uci:set("wireless", DEV_2G, "channel", channel_v)
            uci:set("wireless", DEV_5G, "apclienable", "0")
        else
            uci:set("wireless", DEV_5G, "channel", channel_v)
            uci:set("wireless", DEV_2G, "apclienable", "0")
        end
        uci:commit("wireless")
    end
    
    uci.commit("internet")
    
    -- restart network
    sys.fork_exec("sleep 1;switch_internet_mode.sh")

    return
end


function apply_route_mode()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
      luci.http.write(resp_s)
       
    local sys = require "luci.controller.admin.system"   
    local uci = require "luci.model.uci".cursor()
    
    if rcv_succ == 1 then
        local sys = require "luci.controller.admin.system"
        local netType_v = rcv_json["netType"]

        -- dhcp
        if netType_v == 0 then
            uci.set("internet", "config", "mode", "routerdhcp")
        -- static    
        elseif netType_v == 1 then
            local proto_v, ipaddr_v, netmask_v, gateway_v, dns_v
    
            proto_v   = "static"
            ipaddr_v  = rcv_json["ip"]
            netmask_v = rcv_json["mask"]
            gateway_v = rcv_json["gateway"]
            dns_v     = string.format("%s %s", rcv_json["dns1"], rcv_json["dns2"])
    
            uci.set("internet", "config", "mode", "routerstatic")
            uci.set("internet", "config", "routeripaddr", ipaddr_v)
            uci.set("internet", "config", "routernetmask", netmask_v)
            uci.set("internet", "config", "routergateway", gateway_v)
            uci.set("internet", "config", "routerdns1", rcv_json["dns1"])
            uci.set("internet", "config", "routerdns2", rcv_json["dns2"])
            
        -- pppoe    
        else
            local pppoe_username_v, pppoe_password_v,pppoe_mtu_v

            pppoe_username_v = rcv_json["account"]
            pppoe_password_v = rcv_json["password"]
            pppoe_mtu_v = rcv_json["mtu"]

            uci.set("internet", "config", "mode", "routerpppoe")
            uci.set("internet", "config", "id", pppoe_username_v)
            uci.set("internet", "config", "pwd", pppoe_password_v)
            uci.set("network", "wan", "mtu", pppoe_mtu_v)
            uci.commit("internet")
            uci.commit("network")
            
        end
        
        uci.commit("internet")
            
        -- restart network
        sys.fork_exec("sleep 1;switch_internet_mode.sh")
    end    

    return
end


function get_repeater_mode()
    local uci = require "luci.model.uci".cursor()
    local linkSsid_curr, linkSecurity_curr, linkStatus_curr
    local channel_v, ssid_v, bssid_v, security_v, signal_v
    local rv = {} 

    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0
    

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
        luci.http.prepare_content("application/json")
        luci.http.write(resp_s)
    end 
    
    if rcv_succ == 0 then return end

    --local fmt1={{1, 4},{5, 37},{38, 57},{58, 80},{81, 90}}
    -- mt7628 
    local fmt1={{1, 4},{5, 37},{38, 57},{58, 80},{81, 89}}
    local fmt2={{5, 8},{9, 41},{42, 61},{62, 84},{85, 93}}
    local fmt

    local is_mt7663e = 0
    local skipline = 2
    local wisptype_v = rcv_json["wisptype"]
    if wisptype_v and wisptype_v == 1 then
        if uci.get("wireless", DEV_5G, "type") == 'mt7663e' then is_mt7663e = 1 else is_mt7663e = 0 end
        if is_mt7663e == 1 then
            luci.sys.exec("iwpriv apclii0 set ApCliEnable=0; ifconfig apclii0 down")
            fmt = fmt2
            skipline = 3
        else
            fmt = fmt1
        end
        
        luci.sys.exec("iwpriv rai0 set SiteSurvey=1;sleep 3")
        luci.sys.exec("iwpriv rai0 get_site_survey > /tmp/wifiscan.list")
        
        if is_mt7663e == 1 then
            luci.sys.exec("iwpriv apclii0 set ApCliEnable=1; ifconfig apclii0 up")
        end
    else
        luci.sys.exec("iwpriv ra0 set SiteSurvey=1;sleep 3")
        luci.sys.exec("iwpriv ra0 get_site_survey > /tmp/wifiscan.list")    
        fmt = fmt1
    end
    
    -- spend too more cpu time.
    -- local t0 = os.clock()
    -- while os.clock() - t0 <= 6 do end
    
    -- local wait_s 
    -- wait_s = string.trim(luci.sys.exec("sleep 7; sleep 1"))
  
    local sfile = "/tmp/wifiscan.list"  
    local fd = io.open(sfile, "r")
    local k =0
    if fd then
        while true do
            local ln = fd:read("*l")
            if not ln then
                break
            else
                k = k + 1
                if k > skipline  then
                    --[[
                    local channel_v, ssid_v, bssid_v, security_v, signal_v = ln:match("^(%S)%s+(%S+)%s+(%x+:%x+:%x+:%x+:%x+:%x+)%s+(%S+)%s+(%S+)")
        
                    if channel_v and ssid_v and string.trim(ssid_v) ~= '' then
                        rv[#rv+1] = {
                        channel  = channel_v,
                        ssid     = ssid_v,
                        bssid    = bssid_v,
                        security = security_v,
                        signal   = signal_v
                        }
                    end
                    ]]--
                    
                    local ssid_v = string.trim(string.sub(ln, fmt[2][1], fmt[2][2]))
                    if ssid_v ~= '' and string.find(ssid_v, '0x') ~= 1 then
                        rv[#rv+1] = {
                        channel  = string.trim(string.sub(ln, fmt[1][1], fmt[1][2])),
                        ssid     = string.trim(string.sub(ln, fmt[2][1], fmt[2][2])),
                        bssid    = string.trim(string.sub(ln, fmt[3][1], fmt[3][2])),
                        security = string.trim(string.sub(ln, fmt[4][1], fmt[4][2])),
                        signal   = string.trim(string.sub(ln, fmt[5][1], fmt[5][2]))
                        }
                    end
                end
            end
        end
      
        fd:close()
    end
    
    if wisptype_v and wisptype_v == 1 then
        linkst=luci.sys.exec("[ \"`uci get wireless." .. DEV_2G .. ".apclienable | tr -d '\n'`\" == \"1\" ] && iwconfig apclii0 | grep ESSID | awk -F '\"' '{print $2}' | tr -d '\n' || echo -n ''")
    else    
        linkst=luci.sys.exec("[ \"`uci get wireless." .. DEV_5G .. ".apclienable | tr -d '\n'`\" == \"1\" ] && iwconfig apcli0 | grep ESSID | awk -F '\"' '{print $2}' | tr -d '\n' || echo -n ''")
    end

    if linkst ~= '' then
        linkSsid_curr = uci.get("internet", "config", "ssid") or ''
        linkSecurity_curr = uci.get("internet", "config", "auth") or ''
        linkStatus_curr  = '1'
    else
        linkSsid_curr = ''
        linkSecurity_curr = ''
        linkStatus_curr  = '0'
    end
    local curr_s = string.format('{"linkSsid":"%s",  "linkSecurity":"%s",  "linkStatus":"%s", "list":', linkSsid_curr, linkSecurity_curr, linkStatus_curr)
    
    
      luci.http.prepare_content("application/json")
        luci.http.write(curr_s)
        luci.http.write_json(rv)
        luci.http.write('}')
        
        return
end

function apply_repeater_mode()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end
    
    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 1 then
        local sys = require "luci.controller.admin.system"   
        local uci = require "luci.model.uci".cursor()
        
        -- repeater mode
        uci.set("internet", "config", "mode", "routerwisp")
                
        local wisptype_v, linkPwd_v, ssid_v, security_v, channel_v
        wisptype_v = rcv_json["wisptype"]
        linkPwd_v  = rcv_json["linkPwd"]
        ssid_v     = rcv_json["ssid"]
        security_v = rcv_json["security"]
        channel_v  = rcv_json["channel"]
        
        uci.set("internet", "config", "wisptype", wisptype_v)
        uci.set("internet", "config", "ssid", ssid_v)
        uci.set("internet", "config", "wirelesspwd", linkPwd_v)
        uci.set("internet", "config", "auth", security_v)
        uci.commit("internet")
        
        if wisptype_v == '0' then
            uci:set("wireless", DEV_2G, "channel", channel_v)
            uci:set("wireless", DEV_5G, "apclienable", "0")
        else
            uci:set("wireless", DEV_5G, "channel", channel_v)
            uci:set("wireless", DEV_2G, "apclienable", "0")
        end
        uci:commit("wireless")
        
        -- restart network
        sys.fork_exec("sleep 1;switch_internet_mode.sh")
    end    
    
    return
end


function get_led_enable()
        
    local led_enable_v = uci.get("system", "cfg02e48a", "led") 
    
    local resp_s = {}
    resp_s = {
        Switch = led_enable_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_led_enable()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    local sys = require "luci.controller.admin.system"   
    if rcv_succ == 1 then
        local led_enable_v
        led_enable_v = rcv_json["Switch"]
	local g24_radio = uci.get("wireless", "mt7603e", "radio")
	local g5_radio = uci.get("wireless", DEV_5G, "radio")
        
        if led_enable_v == ENABLE_ON then
            uci:set("wireless", DEV_2G, "led", '1')
            uci:set("wireless", DEV_5G, "led", '1')
            uci:set("system", "cfg02e48a", "led", '1')
	    uci:commit("system")
            uci:commit("wireless")
 
            sys.fork_exec('mtk_led -f 1')
	    if g24_radio == "1" then	
            	sys.fork_exec('iwpriv ra0 set MT7603LED=0')
	    end
	    if g5_radio == "1" then	
	    	if DEV_5G == "mt7663e" then
            		sys.fork_exec('iwpriv rai0 set MT7663Led=1')
	    	elseif DEV_5G == "mt7612e" then
                	sys.fork_exec('iwpriv rai0 set LedOn=1')
	    	end
	    end
        else
            uci:set("wireless", DEV_2G, "led", '0')
            uci:set("wireless", DEV_5G, "led", '0')
            uci:set("system", "cfg02e48a", "led", '0')
	    uci:commit("system")
            uci:commit("wireless")
            
            sys.fork_exec('mtk_led -f 0')
            sys.fork_exec('iwpriv ra0 set MT7603LED=1')
	    if DEV_5G == "mt7663e" then
            	sys.fork_exec('iwpriv rai0 set MT7663Led=0')
	    elseif DEV_5G == "mt7612e" then
                sys.fork_exec('iwpriv rai0 set LedOn=0')
	    end
        end
        sys.fork_exec("uci2dat -d " .. DEV_2G .. " -f /etc/wireless/" .. DEV_2G .. "/" .. DEV_2G .. ".dat > /dev/null")
        sys.fork_exec("uci2dat -d " .. DEV_5G .. " -f /etc/wireless/" .. DEV_5G .. "/" .. DEV_5G .. ".dat > /dev/null")
    end 
        
    return  
end


function get_fw_version()
    local fw_version_v = FW_VER
    local resp_s = {}

    local testAct = string.trim(luci.sys.exec("nvram get blink TestAction | tr -d '\n'")) 
    
    -- change wizard flag.
    chg_wzd_flg()
    
    resp_s = {
        curVersion = fw_version_v,
	testAction = testAct
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function restore_factory_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    local resp_s = {} 
    resp_s = '{"result":0, "msg":"..."}'
    rcv_succ = 1
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    -- restore factory settings for this gateway
    luci.sys.exec('date > /tmp/test.tmp')
    
    local sys = require "luci.controller.admin.system"
     -- set nvram item of firstLogin: firstLogin == 0, need wizard; firstLogin == 1, not need wizard. 
    sys.fork_exec("nvram set blink firstLogin 0; nvram commit")
    -- mtd -r erase action.
    sys.fork_exec("killall dropbear uhttpd; sleep 1; mtd -r erase rootfs_data")
    
    return  
end


function reboot_sys()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    local resp_s = {} 
    resp_s = '{"result":0, "msg":"..."}'
    rcv_succ = 1
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 2;reboot")
    
    return  
end

function get_ping_tracert_result()
    local ping_tracert_result_v, finish_v
    
    ping_tracert_result_v = string.trim(luci.sys.exec('cat /tmp/ping_tracert.log'))
    ping_tracert_result_v = ping_tracert_result_v:gsub('\r', '')
    ping_tracert_result_v = ping_tracert_result_v:gsub('\n', '<br>')
    
    finish_v = file_exist('/tmp/tracert_finish.flg')
    
    local resp_s = {}
    resp_s = {
        info = ping_tracert_result_v,
        finish = finish_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_ping_tracert()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 1 then
        local kind_v, domain_v
        kind_v   = rcv_json["kind"]
        domain_v = rcv_json["domain"]
        
        local sys = require "luci.controller.admin.system"
        if kind_v == "ping" then
            -- ping: blocked mode.
            luci.sys.exec(string.format('ping %s -c 4 > /tmp/ping_tracert.log', domain_v))
        else
            -- traceroute: non-blocked mode.
            sys.fork_exec(string.format('rm /tmp/tracert_finish.flg -rf; traceroute %s -m 12 -w 2 > /tmp/ping_tracert.log; touch /tmp/tracert_finish.flg', domain_v))
        end
    end    
        
    return
end


function get_wan_link_type()
    local uci = require "luci.model.uci".cursor()
    local sys = require "luci.controller.admin.system"
    
    local link_type_s = ''
    local link_type_v
    local curr_mode
    
    curr_mode = luci.sys.exec("uci get system.board.type | tr -d '\n'")

    if curr_mode == 'bridge' then
        link_type_s = luci.sys.exec(string.format('wan_check -I br-lan -P %d', wan_at_port))
    elseif curr_mode == 'router' then
        link_type_s = luci.sys.exec(string.format('wan_check -I %s -P %d', wan_ifc, wan_at_port))
    end
    
    if string.find(link_type_s, 'dhcp') then
        link_type_v = 0
    elseif string.find(link_type_s, 'static') then
        link_type_v = 1
    elseif string.find(link_type_s, 'pppoe') then
        link_type_v = 2
    elseif string.find(link_type_s, 'unlink') then
        link_type_v = 3    
    else
        -- unknown type        
        link_type_v = 4
    end
    
    local resp_s = {
        netType = link_type_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end

function get_wan_stat()
    local uci = require "luci.model.uci".cursor()
    local domain1, domain2, domain3
    domain1 = 'www.163.com'
    domain2 = 'www.jd.com'
    
    local sys = require "luci.controller.admin.system"
    -- kill old ping process.
    luci.sys.exec(string.format("kill -s 9 `ps | grep 'ping %s -c 2' | awk '{print $1}'`", domain1))
    luci.sys.exec(string.format("kill -s 9 `ps | grep 'ping %s -c 2' | awk '{print $1}'`", domain2))
    luci.sys.exec('rm /tmp/ping_result.log -rf')
    
    -- start new ping process.
    sys.fork_exec(string.format('ping %s -c 2 > /tmp/ping_result.log; ping %s -c 2 >> /tmp/ping_result.log', domain1, domain2))
    luci.sys.exec('sleep 4')
    
    local ping_result_s = ''
    local resp_s = {}
    
    ping_result_s = string.trim(luci.sys.exec("cat /tmp/ping_result.log | grep ' bytes from '"))
    if ping_result_s ~= '' then
        luci.sys.exec('echo 1 > /tmp/wan_connected')
        resp_s = '{"result":0, "msg":"..."}'
    else
        luci.sys.exec('echo 0 > /tmp/wan_connected')
        resp_s = '{"result":1, "msg":"..."}'
    end    

    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    return
end


function get_ssh_enable()
    local ssh_enable_v = tonumber(uci.get("dropbear", "cfg024dd4", "enable")) or 0
    local Switch_v

    local resp_s = {}
    resp_s = {
        Switch = ssh_enable_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_ssh_enable()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
      luci.http.write(resp_s)
       
    local sys = require "luci.controller.admin.system"   
    
    if rcv_succ == 1 then
        local ssh_enable_v
        ssh_enable_v   = rcv_json["Switch"]
        
    uci.set("dropbear", "cfg024dd4", "enable", ssh_enable_v)
        uci.commit("dropbear")    
    if ssh_enable_v == 1 then                                              
                luci.sys.exec('/etc/init.d/dropbear restart')                 
        else                                                                                    
                luci.sys.exec('killall dropbear')                                     
        end    
    end    
        
    return  
end

function get_route_gwaddr()
    local route_s = string.trim(luci.sys.exec('route | grep default'))
    local route_arr = string_readln(route_s)
    local rv = ''
    
    for i, v in pairs(route_arr) do  
        if v ~= '' then
            local dest_t, gateway_t, netmask_t, _, _, _, _, iface_t = v:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
            if gateway_t then
                rv = gateway_t
                break
            end 
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

    if linktype_v == 'routerdhcp'  or linktype_v == 'routerstatic' then
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


function get_wan_info()
    local wan_link_up_v, wan_mac_v, conn_uptime_v, networkStatus_v, linktype_v, ipaddr_v, gwaddr_v, netmask_v, dns_v, ipv6addr_global_v, ipv6addr_local_v, ipv6addr_pd_v, apclissid_v
    
    local ntm  = require "luci.model.network".init()
    local wan  = ntm:get_wannet()
    local wan6 = ntm:get_wan6net()
    
    linktype_v = uci.get("internet", "config", "mode")

    if linktype_v == 'bridgedhcp' or linktype_v == 'routerwisp' then
        ipaddr_v   = get_ifc_info('br-lan', 'ip')
        gwaddr_v   = get_route_gwaddr()
        netmask_v  = get_ifc_info('br-lan', 'mask')
        dns_v      = gwaddr_v
        ipv6addr_global_v = get_ifc_info('br-lan', 'ipv6_g')
        ipv6addr_local_v  = get_ifc_info('br-lan', 'ipv6_l')
        ipv6addr_pd_v     = ""
        wan_mac_v         = string.trim(luci.sys.exec("cat /sys/class/net/br-lan/address"))
        
        apclissid_v = ""
        if linktype_v == 'routerwisp' then
            local wisptype = uci.get("internet", "config", "wisptype")
            if (wisptype == '0') then
                apclissid_v = uci.get("wireless", DEV_2G, "apclissid")
            else
                apclissid_v = uci.get("wireless", DEV_5G, "apclissid")
            end    
        end
    else
        local wan_dev_up = string.trim(luci.sys.exec(string.format("ifconfig %s | grep 'UP'", wan_ifc)))
        if wan and wan_dev_up and wan_dev_up ~= "" then
            ipaddr_v   = wan:ipaddr()
            gwaddr_v   = wan:gwaddr()
            netmask_v  = wan:netmask()
            if wan:dnsaddrs()[1] and wan:dnsaddrs()[2] then
               dns_v = wan:dnsaddrs()[1].." "..wan:dnsaddrs()[2]
            elseif wan:dnsaddrs()[1] then    
               dns_v = wan:dnsaddrs()[1]
            else
               dns_v = ""
            end
        else
            ipaddr_v   = ""
            gwaddr_v   = ""
            netmask_v  = ""
            dns_v      = ""
        end
        
        wan_mac_v = string.trim(luci.sys.exec(string.format("cat /sys/class/net/%s/address", wan_ifc)))
        
        if linktype_v == 'routerpppoe' then
            ipv6addr_global_v = get_ifc_info(PPPOE_IFC, 'ipv6_g')
            ipv6addr_local_v  = get_ifc_info(PPPOE_IFC, 'ipv6_l')    
        else
            ipv6addr_global_v = get_ifc_info(wan_ifc, 'ipv6_g')
            ipv6addr_local_v  = get_ifc_info(wan_ifc, 'ipv6_l')
        end
            
        if ipv6addr_global_v == "" then                         
            local br_traverse_v = string.trim(luci.sys.exec('uci get network.lan.br_traverse_ipv6')) or '0'
            if linktype_v == "routerdhcp" and br_traverse_v == "1" then                                    
                if is_wan_connected() == "1" then
                    ipv6addr_global_v = string.trim(luci.sys.exec("cat /tmp/eth_ip6addr"))                    
                    ipv6addr_pd_v = get_ipv6_pd()
                else
                    ipv6addr_pd_v = ""
                end
            else
                ipv6addr_pd_v = ""
            end
        else
            ipv6addr_pd_v = get_ipv6_pd()  
        end
        
        apclissid_v = ""  
    end    
    
    local link_str = string.trim(luci.sys.exec(string.format("ethstt | grep 'port %d up'", wan_at_port)))
    if link_str and link_str ~= "" then
        wan_link_up_v = 1
    else
        wan_link_up_v = 0
    end
    
    local is_connected = is_wan_connected()
    if is_connected == "1" then 
        networkStatus_v = 0 
        
        local wan_ifup_time, sys_uptime
        wan_ifup_time = string.trim(luci.sys.exec("cat /tmp/wan_ifup_time | awk -F'.' '{print $1}'"))
        sys_uptime    = string.trim(luci.sys.exec("cat /proc/uptime | awk -F'.' '{print $1}'"))
        conn_uptime_v = tonumber(sys_uptime) - tonumber(wan_ifup_time)
    elseif is_connected == "0" then 
        networkStatus_v = 1 
        conn_uptime_v = 0 
    else 
        networkStatus_v = 2
        conn_uptime_v = 0 
    end
    
    local vpn_switch_v = uci.get("internet", "pptp_l2tp", "Switch")
    if vpn_switch_v == "on" then
        local clientmode_v = uci.get("internet", "pptp_l2tp", "clientmode")
        if clientmode_v == "pptp" then
            linktype_v = "pptp"
        else
            linktype_v = "l2tp"
        end
    end
    
    local resp_s = {}
    resp_s = {
        wan_link_up     = wan_link_up_v,
        wan_mac         = wan_mac_v,
        conn_uptime     = conn_uptime_v,
        networkStatus   = networkStatus_v,
        linktype        = linktype_v,
        ipaddr          = ipaddr_v,
        gwaddr          = gwaddr_v,
        netmask         = netmask_v,
        dns             = dns_v,
        ipv6addr_global = ipv6addr_global_v,
        ipv6addr_local  = ipv6addr_local_v,
        ipv6addr_pd     = ipv6addr_pd_v,
        apclissid       = apclissid_v  
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end

function get_lan_info()
    local ipaddr_v, netmask_v, ipv6addr_global_v, ipv6addr_local_v, ipv6addr_pd_v, lan_mac_v
    
    ipaddr_v = get_ifc_info('br-lan', 'ip')
    netmask_v = get_ifc_info('br-lan', 'mask')
    ipv6addr_global_v = get_ifc_info('br-lan', 'ipv6_g')
    ipv6addr_local_v = get_ifc_info('br-lan', 'ipv6_l')
    ipv6addr_pd_v = ""
    lan_mac_v = string.trim(luci.sys.exec("cat /sys/class/net/br-lan/address"))
    
    local resp_s = {
        ipaddr = ipaddr_v,
        netmask = netmask_v,
        ipv6addr_global = ipv6addr_global_v,
        ipv6addr_local = ipv6addr_local_v,
        ipv6addr_pd = ipv6addr_pd_v,
        lan_mac = lan_mac_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_sysinfo()
    local model_v, serial_v, softwareVer_v, hwVer_v, mac_v, ip_v, time_s, time_v, networkStatus_v
    
    local ntm = require "luci.model.network".init()
    local wan = ntm:get_wannet()
    local wan6 = ntm:get_wan6net()
    
    -- change wizard flag.
    chg_wzd_flg()
    
    -- model_v  = string.trim(luci.sys.exec("nvram get blink model | tr -d '\n'"))
    if MODEL_TYPE == 0 then
        -- 8M single band
        model_v  = "DIR-615F"
    elseif MODEL_TYPE == 1 then
        -- 8M Dual band
        model_v  = "DIR-822F"
    elseif MODEL_TYPE == 2 then
        -- 4M single band
        -- model_v  = "DIR-612"
        model_v  = "BL-WR450H"
    else
        model_v  = "unknow"
    end
    
    -- serial_v = string.trim(luci.sys.exec(". /usr/bin/and.sh; echo $device_sn"))
    serial_v = ""
    hwVer_v  = HW_VER 
    mac_v    = string.trim(luci.sys.exec('cat /sys/class/net/br-lan/address'))
    ip_v     = get_ifc_info('br-lan', 'ip')
    time_s   = string.trim(luci.sys.exec('cat /proc/uptime'))
    time_s   = time_s:match("^(%d+).(.*)")
    time_v   = tonumber(time_s)
    softwareVer_v = FW_VER
    
    local is_connected = is_wan_connected()
    if is_connected == "1" then 
        networkStatus_v = 0 
    elseif is_connected == "0" then 
        networkStatus_v = 1 
    else 
        networkStatus_v = 2 
    end
 
    local resp_s = {}
    resp_s = {
        model = model_v,
        serial = serial_v, 
        hwVer = hwVer_v, 
        mac = mac_v, 
        ip = ip_v, 
        time = time_v, 
        softwareVer = softwareVer_v, 
        networkStatus = networkStatus_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_syslog()
    local syslog_v
    
    -- kernel log.
    -- syslog_v = string.trim(luci.sys.exec('dmesg'))
    -- sys log.
    -- syslog_v = string.trim(luci.sys.exec('logread'))    
    
    syslog_v = luci.sys.syslog()
    syslog_v = syslog_v:gsub('\r', '')
    syslog_v = syslog_v:gsub('\n', '<br>')
    
    local resp_s = {}
    resp_s = {
        logInfo = syslog_v
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function fw_upgrade()
    --local resp_s = {}
    --resp_s = {
    --    Switch = ssh_enable_v
    --}

    --luci.http.prepare_content("application/json")
    --luci.http.write_json(resp_s)
    
    --return
    
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


-- cwx test
--[[
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
]]--
  
  
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
      
      
      local sys = require "luci.controller.admin.system"
      sys.fork_exec("killall dropbear uhttpd; sleep 1; /sbin/sysupgrade /tmp/firmware.img")
      
    end
  )

--[[
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
      local keep = (luci.http.formvalue("keep") == "1") and "" or "-n"
      luci.template.render("admin_system/applyreboot", {
        title = luci.i18n.translate("Flashing..."),
        msg   = luci.i18n.translate("The system is flashing now.<br /> DO NOT POWER OFF THE DEVICE!<br /> Wait a few minutes before you try to reconnect. It might be necessary to renew the address of your computer to reach the device again, depending on your settings."),
        addr  = (#keep > 0) and "192.168.1.1" or nil
      })
      fork_exec("killall dropbear uhttpd; sleep 1; /sbin/sysupgrade %s %q" %{ keep, image_tmp })
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
  
  --fork_exec("killall dropbear uhttpd; sleep 1; /sbin/sysupgrade %s %q" %{ keep, image_tmp })
  --fork_exec("killall dropbear uhttpd; sleep 1; /sbin/sysupgrade /tmp/firmware.img")
]]--

end


function modify_password()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    local username_v, oldpassword_v, newPassword_v
    username_v    = rcv_json["username"]
    oldpassword_v = rcv_json["oldpassword"]
    newPassword_v = rcv_json["newPassword"]
    
    if rcv_succ == 1 then
        if username_v == 'CMCCAdmin' or username_v == get_enduser_name() then
            -- just modify password.
            luci.sys.user.setpasswd(username_v, newPassword_v)
        else
            -- modify enduser name & password.
            modify_enduser_account(get_enduser_name(), username_v, newPassword_v)
            luci.sys.exec(string.format("echo '%s' > /etc/enduser_nm", username_v))
        end
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    return  
end


function dmz()
    local dmz_v, dmz_ip_v, Switch_v
    local uci = require("uci").cursor()
    local dmz_idx = -1
    
    -- find "DMZ" section. 
    local i = -1
    uci:foreach("firewall", "redirect",
            function(s)
                  i = i + 1
                    if s.name and s.name == "DMZ" then
                        dmz_idx = i
                        return false
                    end
              end)

    if dmz_idx >= 0 then
        Switch_v = ENABLE_ON
        dmz_ip_v = string.trim(luci.sys.exec(string.format('uci get firewall.@redirect[%d].dest_ip', dmz_idx)))
    else
        Switch_v = ENABLE_OFF
        dmz_ip_v = ""
    end 
    
    local resp_s = {} 
    resp_s = {
        Switch = Switch_v,
        ip     = dmz_ip_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_dmz()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end
    
    local uci = require("uci").cursor()
    local dmz_idx = -1
    
    -- find "DMZ" section. 
    local i = -1
    uci:foreach("firewall", "redirect",
            function(s)
                  i = i + 1
                    if s.name and s.name == "DMZ" then
                        dmz_idx = i
                        return false
                    end
              end)

    local dmz_ip_v, Switch_v
    Switch_v = rcv_json["Switch"]
    dmz_ip_v = rcv_json["ip"]
        
    if Switch_v == ENABLE_ON then
        -- enable DMZ function.
        local idx = -1
        if dmz_idx == -1 then
            luci.sys.exec("uci add firewall redirect")
        
            local j = -1
            uci:foreach("firewall", "redirect", function(s) j = j + 1 end)
                
            if j == -1 then idx = 0 else idx = j + 1 end    
        else
            idx = dmz_idx                      
        end  
       
        if idx >=0 then
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].name="%s"',    idx, "DMZ"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].src="%s"',     idx, "wan"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].dest_ip="%s"', idx,  dmz_ip_v))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].proto="%s"',   idx, "all"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].dest="%s"',    idx, "lan"))
        end
    else
        -- disable DMZ function.
        if dmz_idx >= 0 then
            -- "DMZ" section is existed, delete. 
            luci.sys.exec(string.format('uci delete firewall.@redirect[%d]', dmz_idx))
        end
    end   
    
    luci.sys.exec('uci commit firewall')
    luci.sys.exec('/etc/init.d/firewall restart')
    
    return  
end



function hwnat()
    local hwnat_enable_v, Switch_v
    
    hwnat_enable_v = string.trim(luci.sys.exec('uci get system.performance_mode.enabled'))
    if hwnat_enable_v == '1' then
       Switch_v = ENABLE_ON
    else
       Switch_v = ENABLE_OFF
    end   
    
    local resp_s = {} 
    resp_s = {
        Switch = Switch_v,
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_hwnat()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0
    local sys = require "luci.sys"

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end
    
    local hwnat_enable_v, Switch_v
    Switch_v = rcv_json["Switch"]
    hwnat_enable_v = Switch_v
        
    luci.sys.exec(string.format("uci set system.performance_mode.enabled=%s", hwnat_enable_v))
    luci.sys.exec("uci commit system") 
    
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("/usr/sbin/performance_mode.sh") 
    return
end


function get_wifi_global_enable(wifi_band)
    local uci = require "luci.model.uci".cursor()
    local i, device_name, radio_v, Switch_v
    
    -- wifi_band: 0=2.4G; 1=5G
    if wifi_band == WIFI_2G then
        device_name = DEV_2G
    else
        device_name = DEV_5G
    end
    
    radio_v = string.trim(luci.sys.exec(string.format('uci get wireless.%s.radio', device_name)))
    if radio_v == '1' then
        Switch_v = ENABLE_ON
    else
        Switch_v = ENABLE_OFF
    end    
        
    local resp_s = {}
    resp_s = {
        Switch = Switch_v
    }
        
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function get_2g_global_enable()
    get_wifi_global_enable(WIFI_2G)
    return
end


function get_5g_global_enable()
    get_wifi_global_enable(WIFI_5G)
    return
end


function apply_wifi_global_enable(wifi_band)
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local i, device_name, main_ifc 
    local sys = require "luci.controller.admin.system"
    
    -- wifi_band: 0=2.4G; 1=5G
    if wifi_band == WIFI_2G then
        device_name = DEV_2G
        main_ifc = "ra0"
    else
        device_name = DEV_5G
        main_ifc = "rai0"
    end
    
    if rcv_json["Switch"] == ENABLE_ON then
        luci.sys.exec(string.format('uci set wireless.%s.radio=1', device_name))
        
        -- restore all ssid status. ~_~
        for i = 0, 7 do
            if (string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].device', i))) == device_name) then
                local ifc_name  = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i)))
                local disable_v = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].disabled', i)))
                -- apply wifi separately.
                if disable_v == '0' then
                    luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s enable', ifc_name))
                else
                    luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s disable', ifc_name))
                end
            end
        end
        
        -- enable wifi, then set the led on.
        local sys_led=luci.sys.exec("uci get system.@system[0].led | tr -d '\n'")
	if sys_led == '1' then
		if wifi_band == WIFI_2G then
        		sys.fork_exec('iwpriv ra0 set MT7603LED=0')
		else
			if DEV_5G == 'mt7612e' then
            			sys.fork_exec('iwpriv rai0 set LedOn=1')
			elseif DEV_5G == 'mt7663e' then
            			sys.fork_exec('iwpriv rai0 set MT7663Led=1')
			end
		end
	else
		if wifi_band == WIFI_2G then
        		sys.fork_exec('iwpriv ra0 set MT7603LED=1')
		else
			if DEV_5G == 'mt7612e' then
            			sys.fork_exec('iwpriv rai0 set LedOn=0')
			elseif DEV_5G == 'mt7663e' then
            			sys.fork_exec('iwpriv rai0 set MT7663Led=0')
			end
		end
	
	end
    else
        luci.sys.exec(string.format('uci set wireless.%s.radio=0', device_name))
        -- sys.fork_exec(string.format('iwpriv %s set LedOn=1', main_ifc)) 
        -- disable wifi, then set the led off.
        if wifi_band == WIFI_2G then
		sys.fork_exec('iwpriv ra0 set MT7603LED=1')
	else
		if DEV_5G == 'mt7612e' then
            		sys.fork_exec('iwpriv rai0 set LedOn=0')
		elseif DEV_5G == 'mt7663e' then
            		sys.fork_exec('iwpriv rai0 set MT7663Led=0')
		end
	end
        
        -- disable all ssid ifc.
        for i = 0, 7 do
            if (string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].device', i))) == device_name) then
                -- apply wifi separately.
                local ifc_name = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i)))
                luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s disable', ifc_name))
            end
        end
        
    end
        
    luci.sys.exec('uci commit wireless')
        
    -- restart wifi
    -- sys.fork_exec("sleep 1;wifi fast")
    
    return
end


function apply_2g_global_enable()
    apply_wifi_global_enable(WIFI_2G)
    return
end


function apply_5g_global_enable()
    apply_wifi_global_enable(WIFI_5G)
    return
end

function get_ipv6_setting()
    local uci = require "luci.model.uci".cursor()
    local ra_management_v, lan_stateless_v, br_traverse_v, wan_glb_ip_v, wan_lnk_ip_v
    
    ra_management_v = string.trim(luci.sys.exec('uci get dhcp.lan.ra_management'))
    if ra_management_v == "2" then  
        lan_stateless_v = 1
    elseif ra_management_v == "0" then
        lan_stateless_v = 0 
    else
        lan_stateless_v = 1 
    end
        
    br_traverse_v = string.trim(luci.sys.exec('uci get network.lan.br_traverse_ipv6')) or '0'
    br_traverse_v = tonumber(br_traverse_v)
    
    local linktype_v = uci.get("internet", "config", "mode")
    if linktype_v == 'bridgedhcp' or linktype_v == 'routerwisp' then
        wan_glb_ip_v = ""
        wan_lnk_ip_v = ""
    else
        if linktype_v == 'routerpppoe' then
            wan_glb_ip_v = get_ifc_info(PPPOE_IFC, 'ipv6_g')
            wan_lnk_ip_v = get_ifc_info(PPPOE_IFC, 'ipv6_l')    
        else
            wan_glb_ip_v = get_ifc_info(wan_ifc, 'ipv6_g')
            wan_lnk_ip_v = get_ifc_info(wan_ifc, 'ipv6_l')    
            
            if wan_glb_ip_v == "" then
                if linktype_v == 'routerdhcp' and br_traverse_v == 1 then
                    wan_glb_ip_v = string.trim(luci.sys.exec("cat /tmp/eth_ip6addr"))
                end    
            end
        end
    end        
       
    local resp_s = {}
    resp_s = {
        lan_stateless = lan_stateless_v,
        br_traverse   = br_traverse_v,
        wan_glb_ip    = wan_glb_ip_v,
        wan_lnk_ip    = wan_lnk_ip_v
    }
        
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_ipv6_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local lan_stateless_v, br_traverse_v
    local sys = require "luci.controller.admin.system"
    
    lan_stateless_v = rcv_json["lan_stateless"]
    br_traverse_v   = rcv_json["br_traverse"]

    if lan_stateless_v == 1 then
        luci.sys.exec('uci set dhcp.lan.ra_management=2')
    else
        luci.sys.exec('uci set dhcp.lan.ra_management=0')
    end
    luci.sys.exec('uci set network.lan.br_traverse_ipv6='.. br_traverse_v)
    
    luci.sys.exec('uci commit dhcp')
    luci.sys.exec('uci commit network')
    luci.sys.exec(string.format("brctl delif br-lan %s", wan_ifc))
    
    -- restart dnsmasq
    sys.fork_exec("/etc/init.d/network restart")
    
    return
end


function get_wifi_top_enable()
    local radio_2g_v, radio_5g_v, Switch_v
    
    radio_2g_v = string.trim(luci.sys.exec(string.format('uci get wireless.%s.radio', DEV_2G)))
    radio_5g_v = string.trim(luci.sys.exec(string.format('uci get wireless.%s.radio', DEV_5G)))
    
    if radio_2g_v == '1' or radio_5g_v == '1' then
        Switch_v = ENABLE_ON
    else
        Switch_v = ENABLE_OFF
    end    
        
    local resp_s = {}
    resp_s = {
        enable = Switch_v
    }
        
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_wifi_top_enable()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local i, device_name, main_ifc, radio_v, disable_v
    local sys = require "luci.controller.admin.system"
    
    if rcv_json["enable"] == ENABLE_ON then
        luci.sys.exec(string.format('uci set wireless.%s.radio=1', DEV_2G))
        luci.sys.exec(string.format('uci set wireless.%s.radio=1', DEV_5G))
        
        for i = 0, 7 do
            local ifc_name  = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i)))
            local disable_v = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].disabled', i)))
            -- apply wifi separately.
            if disable_v == '0' then
                luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s enable', ifc_name))
            else
                luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s disable', ifc_name))
            end
        end
        
        -- enable wifi, then set the led on.
        local sys_led=luci.sys.exec("uci get system.@system[0].led | tr -d '\n'")
       
	if sys_led == '1' then
		sys.fork_exec('iwpriv ra0 set MT7603LED=0')
		if DEV_5G == 'mt7612e' then
            	    sys.fork_exec('iwpriv rai0 set LedOn=1')
		elseif DEV_5G == 'mt7663e' then
            	    sys.fork_exec('iwpriv rai0 set MT7663Led=1')
		end
	else
		sys.fork_exec('iwpriv ra0 set MT7603LED=1')
		if DEV_5G == 'mt7612e' then
            	    sys.fork_exec('iwpriv rai0 set LedOn=0')
		elseif DEV_5G == 'mt7663e' then
            	    sys.fork_exec('iwpriv rai0 set MT7663Led=0')
		end


	end
    else
        luci.sys.exec(string.format('uci set wireless.%s.radio=0', DEV_2G))
        luci.sys.exec(string.format('uci set wireless.%s.radio=0', DEV_5G))

        -- disable wifi, then set the led off.
        sys.fork_exec('iwpriv ra0 set MT7603LED=1')
	if DEV_5G == 'mt7612e' then
            sys.fork_exec('iwpriv rai0 set LedOn=0')
	elseif DEV_5G == 'mt7663e' then
            sys.fork_exec('iwpriv rai0 set MT7663Led=0')
	end

        -- disable all ssid ifc.
        for i = 0, 7 do
            -- apply wifi separately.
            local ifc_name = string.trim(luci.sys.exec(string.format('uci get wireless.@wifi-iface[%d].ifname', i)))
            luci.sys.exec(string.format('sh /sbin/apply_wifi_single.sh %s disable', ifc_name))
        end
        
    end
        
    luci.sys.exec('uci commit wireless')
        
    -- restart wifi
    -- sys.fork_exec("sleep 1;wifi fast")
    
    return
end


function get_iptv_portmap()
    local portmap_enable, lan_ports, vlan_tag, p1, p2, p3, p4
    portmap_enable = string.trim(luci.sys.exec('uci get misc.iptv.enable'))
    lan_ports      = string.trim(luci.sys.exec('uci get misc.iptv.ports'))
    vlan_tag       = string.trim(luci.sys.exec('uci get misc.iptv.tag')) 
    
    local resp_s = {}
    if portmap_enable and lan_ports and portmap_enable == "1" then
        p1, p2, p3, p4 = lan_ports:match("^(%d),(%d),(%d),(%d)")
        resp_s = {
            enable = tonumber(portmap_enable) or 0,
            lan1 = p1,
            lan2 = p2,
            lan3 = p3,
            lan4 = p4,
            tag  = vlan_tag            
        }
    else
        resp_s = {enable = 0}
    end    
        
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_iptv_portmap()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local portmap_enable, lan_ports, vlan_tag, p1, p2, p3, p4
    portmap_enable = rcv_json["enable"]
    
    if portmap_enable == ENABLE_ON then
        p1 = rcv_json["lan1"]
        p2 = rcv_json["lan2"]
        p3 = rcv_json["lan3"]
        p4 = rcv_json["lan4"]
        vlan_tag = rcv_json["tag"]
        
        luci.sys.exec(string.format('uci set misc.iptv.enable=%s', ENABLE_ON))
        luci.sys.exec(string.format('uci set misc.iptv.ports=%s,%s,%s,%s', p1, p2, p3, p4))
        luci.sys.exec(string.format('uci set misc.iptv.tag=%s', vlan_tag))
        luci.sys.exec('uci commit misc')
    else
        -- disable iptv portmapping
        luci.sys.exec(string.format('uci set misc.iptv.enable=%s', ENABLE_OFF))
        luci.sys.exec('uci commit misc')
    end
    
    -- reboot 
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 2;reboot")
    
    return
end


function get_url_filter_data()
	local curr_s
	local rv = {}
	local fd = io.open("/etc/url_filter_list", "r")
	if fd then
		while true do
			local ln = fd:read("*l")
			if not ln then
				break
			else
				if string.len(ln) == 0  then
				else
					local url_v = string.trim(ln):match("^(%S+)")
					rv[#rv+1] = {
						url = url_v
					}
				end
			end
		end
	    fd:close()
	end
	
	if #rv == 0 then
		curr_s = '{"list":[]'
	else
		curr_s = '{"list":'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(curr_s)
	
	if #rv ~= 0 then
		luci.http.write_json(rv)
	end

	luci.http.write('}')
	
	return
end

function set_url_filter_data()
	local cjson = require "cjson"
	local postdata = nil
	local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
	local rcv_json = nil
	local rcv_succ = 0
	local resp_s
	
	if (postdata_len > 0) then
		postdata = io.read(postdata_len)
		rcv_json = cjson.decode(postdata)
	end
	
	if (postdata ~= nil and rcv_json ~= nil) then
		resp_s = '{"result":0, "msg":"..."}'
		rcv_succ = 1
	else
		resp_s = '{"result":1, "msg":"post data is null..."}'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(resp_s)
	
	if rcv_succ == 0 then return end

    luci.sys.exec('rm /etc/url_filter_list -rf; rm /etc/firewall.user.urlfilter -rf; touch /etc/url_filter_list; touch /etc/firewall.user.urlfilter')
    local fp = io.open("/etc/url_filter_list", "a")
    local url_list = rcv_json["list"]
    local url_v
    for i, v in ipairs(url_list) do
        url_v = v["url"]
        if fp then  
            fp:write(url_v .. '\n') 
            luci.sys.exec(string.format('echo "iptables -t filter -I FORWARD 1 -m string --string %s --algo bm -j DROP" >> /etc/firewall.user.urlfilter', url_v))
        end
    end
    if fp then fp:close() end
    
    luci.sys.exec('rm /etc/firewall.user -rf; touch /etc/firewall.user')
    -- Note: blackwhitelist first ! 
    luci.sys.exec('cat /etc/firewall.user.blackwhitelist >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.fwd >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.urlfilter >> /etc/firewall.user')
    
    luci.sys.exec('/etc/init.d/firewall restart')
end


function get_forward_data()
	local curr_s
	local rv = {}
	local fd = io.open("/etc/port_forward_list", "r")
	
	if fd then
		while true do
			local ln = fd:read("*l")
			if not ln then
				break
			else
				if string.len(ln) == 0  then
				else
					local name_v, ip_v, lanport_v, wanport_v, protocol_v = string.trim(ln):match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
					rv[#rv+1] = {
						name     = name_v,
						ip       = ip_v,
						lanport  = lanport_v,
						wanport  = wanport_v,
						protocol = protocol_v
					}
				end
			end
	    end
	    fd:close()
	end
	
	if #rv == 0 then
		curr_s = '{"list":[]'
	else
		curr_s = '{"list":'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(curr_s)

	if #rv ~= 0 then
		luci.http.write_json(rv)
	end

	luci.http.write('}')
	
	return
end


function apply_forward_data()
	local cjson = require "cjson"
	local postdata = nil
	local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
	local rcv_json = nil
	local rcv_succ = 0
	local resp_s
	
	if (postdata_len > 0) then
		postdata = io.read(postdata_len)
		rcv_json = cjson.decode(postdata)
	end
	
	if (postdata ~= nil and rcv_json ~= nil) then
		resp_s = '{"result":0, "msg":"..."}'
		rcv_succ = 1
	else
		resp_s = '{"result":1, "msg":"post data is null..."}'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(resp_s)
	
	if rcv_succ == 0 then return end
	
	luci.sys.exec('rm /etc/port_forward_list -rf; rm /etc/firewall.user.fwd -rf; touch /etc/port_forward_list; touch /etc/firewall.user.fwd') 
		
    local port_fwd_list = rcv_json["list"]
    for i, v in ipairs(port_fwd_list) do
        local name_v, name_s, ip_v, lanport_v, wanport_v, protocol_v, enable_v, name_v_old, name_s_old
        name_v     = v["name"]
		ip_v       = v["ip"]
		lanport_v  = v["lanport"]
		wanport_v  = v["wanport"]
		protocol_v = v["protocol"]
    		
        luci.sys.exec(string.format('echo "%s %s %s %s %s"  >> /etc/port_forward_list', name_v, ip_v, lanport_v, wanport_v, protocol_v))
        
        if protocol_v == "tcp" or protocol_v == "TCP" then
            protocol_v = "tcp"
            luci.sys.exec(string.format('echo "iptables -t nat -A PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s" >> /etc/firewall.user.fwd', wan_ifc, protocol_v, wanport_v, ip_v, lanport_v))
        elseif protocol_v == "udp" or protocol_v == "UDP" then
            protocol_v = "udp"
            luci.sys.exec(string.format('echo "iptables -t nat -A PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s" >> /etc/firewall.user.fwd', wan_ifc, protocol_v, wanport_v, ip_v, lanport_v))
        else
            protocol_v = "tcp"
            luci.sys.exec(string.format('echo "iptables -t nat -A PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s" >> /etc/firewall.user.fwd', wan_ifc, protocol_v, wanport_v, ip_v, lanport_v))
            protocol_v = "udp"
            luci.sys.exec(string.format('echo "iptables -t nat -A PREROUTING -i %s -p %s --dport %s -j DNAT --to %s:%s" >> /etc/firewall.user.fwd', wan_ifc, protocol_v, wanport_v, ip_v, lanport_v))
	    end
    end
    
    luci.sys.exec('rm /etc/firewall.user -rf; touch /etc/firewall.user')
    -- Note: blackwhitelist first ! 
    luci.sys.exec('cat /etc/firewall.user.blackwhitelist >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.fwd >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.urlfilter >> /etc/firewall.user')
    
    luci.sys.exec('/etc/init.d/firewall restart')
end


function get_vpn_data()
    local switch_v, clientmode_v, domain_v, username_v, password_v, netmode_v, staticip_v, staticmask_v, staticgateway_v, MTU_v
    switch_v        = uci.get("internet", "pptp_l2tp", "Switch")
    clientmode_v    = uci.get("internet", "pptp_l2tp", "clientmode")
    domain_v        = uci.get("internet", "pptp_l2tp", "domain")
    username_v      = uci.get("internet", "pptp_l2tp", "username")
    password_v      = uci.get("internet", "pptp_l2tp", "password")
    netmode_v       = uci.get("internet", "pptp_l2tp", "netmode")
    staticip_v      = uci.get("internet", "pptp_l2tp", "staticip")
    staticmask_v    = uci.get("internet", "pptp_l2tp", "staticmask")
    staticgateway_v = uci.get("internet", "pptp_l2tp", "staticgateway")
    MTU_v           = uci.get("internet", "pptp_l2tp", "MTU")
    
    local resp_s = {} 
    if switch_v then
       if netmode_v == 'DHCP' then
       		resp_s = {
        		Switch = switch_v,
        		clientmode = clientmode_v,
        		domain = domain_v,
	        	username = username_v,
    	    	password = password_v,
        		netmode = netmode_v
    		}
       else
       		resp_s = {
	        	Switch = switch_v,
    	    	clientmode = clientmode_v,
        		domain = domain_v,
        		username = username_v,
	        	password = password_v,
    	    	netmode = netmode_v,
        		staticip = staticip_v,
	        	staticmask = staticmask_v,
    	    	staticgateway = staticgateway_v,
        		MTU = MTU_v
    		}
       end
    else
        resp_s = {
            Switch = 'off',
            clientmode = 'pptp',
            domain = '',
            username = '',
            password = '',
            netmode = 'DHCP'
    	}
    end
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_vpn_data()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0
    local resp_s

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end

    local switch_v, clientmode_v, domain_v, username_v, password_v, netmode_v, staticip_v, staticmask_v, staticgateway_v, MTU_v
    switch_v        = rcv_json["Switch"]
    clientmode_v    = rcv_json["clientmode"]
    domain_v        = rcv_json["domain"]
    username_v      = rcv_json["username"]
    password_v      = rcv_json["password"]
    netmode_v       = rcv_json["netmode"]
        
    luci.sys.exec('uci set internet.pptp_l2tp=vpn')
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.Switch=%s', switch_v))
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.clientmode=%s', clientmode_v))
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.domain=%s', domain_v))
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.username=%s', username_v))
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.password=%s', password_v))
    luci.sys.exec(string.format('uci set internet.pptp_l2tp.netmode=%s', netmode_v))
        
    if netmode_v == 'Static' then
		staticip_v      = rcv_json["staticip"]
		staticmask_v  	= rcv_json["staticmask"]
		staticgateway_v = rcv_json["staticgateway"]
		MTU_v   		= rcv_json["MTU"]
		if MTU_v == "0" then MTU_v = "1500" end
        
      	luci.sys.exec(string.format('uci set internet.pptp_l2tp.staticip=%s', staticip_v))
       	luci.sys.exec(string.format('uci set internet.pptp_l2tp.staticmask=%s', staticmask_v))
       	luci.sys.exec(string.format('uci set internet.pptp_l2tp.staticgateway=%s', staticgateway_v))
       	luci.sys.exec(string.format('uci set internet.pptp_l2tp.MTU=%s', MTU_v))
    end
    luci.sys.exec('uci commit internet')
        
    -- set network
    luci.sys.exec('uci del network.PPTP')
    luci.sys.exec('uci del network.L2TP')
    luci.sys.exec('uci commit network')
        
    if switch_v == 'on' then
    	if clientmode_v == 'pptp' then
    		luci.sys.exec('uci set network.PPTP=interface')
    		luci.sys.exec('uci set network.PPTP.proto=pptp')
    		luci.sys.exec(string.format('uci set network.PPTP.server=%s', domain_v))
    		luci.sys.exec(string.format('uci set network.PPTP.username=%s', username_v))
    		luci.sys.exec(string.format('uci set network.PPTP.password=%s', password_v))
    	else
    		luci.sys.exec('uci set network.L2TP=interface')
    		luci.sys.exec('uci set network.L2TP.proto=l2tp')
    		luci.sys.exec('uci set network.L2TP.ipv6=auto')
    		luci.sys.exec(string.format('uci set network.L2TP.server=%s', domain_v))
    		luci.sys.exec(string.format('uci set network.L2TP.username=%s', username_v))
    		luci.sys.exec(string.format('uci set network.L2TP.password=%s', password_v))
    	end
        	
    	if netmode_v == 'Static' then
	    	luci.sys.exec('uci set network.wan.proto=static')
	    	luci.sys.exec(string.format('uci set network.wan.ipaddr=%s', staticip_v))
	    	luci.sys.exec(string.format('uci set network.wan.netmask=%s', staticmask_v))
	    	luci.sys.exec(string.format('uci set network.wan.gateway=%s', staticgateway_v))
	    	luci.sys.exec(string.format('uci set network.wan.mtu=%s', MTU_v))
	    	luci.sys.exec('uci del network.wan.dns')
	    	luci.sys.exec('uci del network.wan.username')
	    	luci.sys.exec('uci del network.wan.password')
	    	luci.sys.exec('uci set network.lan.ifname=eth0.1')
	    	luci.sys.exec('uci set network.wan.ifname=eth0.2')
	    	luci.sys.exec('uci set network.lan.proto=static')
	    			
	    	luci.sys.exec('uci set internet.config.mode=routerstatic')
	    	luci.sys.exec(string.format('uci set internet.config.routeripaddr=%s', staticip_v))
	    	luci.sys.exec(string.format('uci set internet.config.routernetmask=%s', staticmask_v))
	    	luci.sys.exec(string.format('uci set internet.config.routergateway=%s', staticgateway_v))
	    	luci.sys.exec('uci del internet.config.routerdns1')
	    	luci.sys.exec('uci del internet.config.routerdns2')
		else
			luci.sys.exec('uci set network.wan.proto=dhcp')
	    	luci.sys.exec('uci del network.wan.ipaddr')
	    	luci.sys.exec('uci del network.wan.netmask')
	    	luci.sys.exec('uci del network.wan.gateway')
	    	luci.sys.exec('uci del network.wan.mtu')
	    	luci.sys.exec('uci del network.wan.dns')
	    	luci.sys.exec('uci del network.wan.username')
	    	luci.sys.exec('uci del network.wan.password')
	    	luci.sys.exec('uci set network.lan.ifname=eth0.1')
	    	luci.sys.exec('uci set network.wan.ifname=eth0.2')
	    	luci.sys.exec('uci set network.lan.proto=static')
	    	luci.sys.exec('uci set internet.config.mode=routerdhcp')
    	end
    end
    
    luci.sys.exec('uci commit network')	
    luci.sys.exec('uci commit internet')
    
    local idx = -1
    uci:foreach("firewall", "zone", function(s)
        idx = idx + 1
        if s.name and s.name == "wan" then
            return false
        end
    end)
    if idx ~= -1 then  
        luci.sys.exec(string.format("uci add_list firewall.@zone[%d].network='PPTP'", idx)) 
        luci.sys.exec(string.format("uci add_list firewall.@zone[%d].network='L2TP'", idx)) 
        luci.sys.exec("uci commit firewall")
    end
           
    -- restart network
    local sys = require "luci.controller.admin.system"
    sys.fork_exec("sleep 1; switch_internet_mode.sh")
            
    return  
end


function get_static_route()
	local curr_s
	local rv = {}
	local fd = io.open("/etc/static_route_list", "r")
	
	if fd then
		while true do
			local ln = fd:read("*l")
			if not ln then
				break
			else
				if string.len(ln) == 0  then
				else
					local name_v, state_v, net_v, netmask_v, gateway_v, metric_v, dev_v = string.trim(ln):match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
					if dev_v == wan_ifc then dev_v = "wan" else dev_v = "lan" end
					rv[#rv+1] = {
					    name    = name_v,
					    state   = state_v,
						net     = net_v,
						netmask = netmask_v,
						gateway = gateway_v,
						metric  = metric_v,
						dev     = dev_v
					}
				end
			end
	    end
	    fd:close()
	end
	
	if #rv == 0 then
		curr_s = '{"list":[]'
	else
		curr_s = '{"list":'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(curr_s)

	if #rv ~= 0 then
		luci.http.write_json(rv)
	end

	luci.http.write('}')
	
	return
end


function apply_static_route()
	local cjson = require "cjson"
	local postdata = nil
	local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
	local rcv_json = nil
	local rcv_succ = 0
	local resp_s
	
	if (postdata_len > 0) then
		postdata = io.read(postdata_len)
		rcv_json = cjson.decode(postdata)
	end
	
	if (postdata ~= nil and rcv_json ~= nil) then
		resp_s = '{"result":0, "msg":"..."}'
		rcv_succ = 1
	else
		resp_s = '{"result":1, "msg":"post data is null..."}'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(resp_s)
	
	if rcv_succ == 0 then return end
	
	-- delete old static route.
	local state_v, net_v, netmask_v, gateway_v, metric_v, dev_v
	local fd = io.open("/etc/static_route_list", "r")
	if fd then
		while true do
			local ln = fd:read("*l")
			if not ln then
				break
			else
				if string.len(ln) == 0  then
				else
					name_v, state_v, net_v, netmask_v, gateway_v, metric_v, dev_v = string.trim(ln):match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
					
					if state_v and state_v == "1" and net_v and netmask_v and gateway_v and metric_v and dev_v then
					    luci.sys.exec(string.format('route del -net %s netmask %s gateway %s metric %s dev %s', net_v, netmask_v, gateway_v, metric_v, dev_v))
					end
				end
			end
	    end
	    fd:close()
	end
	luci.sys.exec('rm /etc/static_route_list -rf; touch /etc/static_route_list') 
		
    local static_route_list = rcv_json["list"]
    for i, v in ipairs(static_route_list) do
        name_v    = v["name"]
        state_v   = v["state"]
        net_v     = v["net"]
		netmask_v = v["netmask"]
		gateway_v = v["gateway"]
		metric_v  = v["metric"]
		dev_v     = v["dev"]
		
		if name_v and state_v and net_v and netmask_v and gateway_v and metric_v and dev_v then
		    luci.sys.exec(string.format('echo "%s %s %s %s %s %s %s"  >> /etc/static_route_list', name_v, state_v, net_v, netmask_v, gateway_v, metric_v, dev_v))
		    if state_v == "1" then
		        if dev_v and dev_v == "wan" then dev_v = "" .. wan_ifc else dev_v = "" .. lan_ifc end
		        -- cwx test
		        local xx = string.format('route add -net %s netmask %s gateway %s metric %s dev %s', net_v, netmask_v, gateway_v, metric_v, dev_v)
		        dbg(xx)
		        
		        luci.sys.exec(string.format('route add -net %s netmask %s gateway %s metric %s dev %s', net_v, netmask_v, gateway_v, metric_v, dev_v))
		    end
		end
    end
end


function get_ddns()
    local enabled_v, status_v, service_name_v, domain_v, username_v, password_v, ddns_rv_v
    enabled_v      = uci.get("ddns", "myddns_ipv4", "enabled")
    service_name_v = uci.get("ddns", "myddns_ipv4", "service_name")
    domain_v       = uci.get("ddns", "myddns_ipv4", "domain")
    username_v     = uci.get("ddns", "myddns_ipv4", "username")
    password_v     = uci.get("ddns", "myddns_ipv4", "password")
    ddns_rv_v      = luci.sys.exec("cat /var/run/ddns/myddns_ipv4.dat | grep -E 'good|nochg'")
    if ddns_rv_v and ddns_rv_v ~= "" then status_v = 1 else status_v = 0 end
    
    local resp_s = {} 
    resp_s = {
        enabled  = enabled_v,
        status   = status_v,
        service_name = service_name_v,
        domain   = domain_v,
        username = username_v,
        password = password_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_ddns()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local enabled_v, status_v, service_name_v, domain_v, username_v, password_v, ddns_rv_v
    enabled_v = rcv_json["enabled"]
    if enabled_v == "1" then
        service_name_v = rcv_json["service_name"]
        domain_v   = rcv_json["domain"]
        username_v = rcv_json["username"]
        password_v = rcv_json["password"]

        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.enabled=%s', "1"))
        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.service_name=%s', service_name_v))
        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.domain=%s', domain_v))
        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.username=%s', username_v))
        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.password=%s', password_v))
    else
        luci.sys.exec(string.format('uci set ddns.myddns_ipv4.enabled=%s', "0"))
    end
    
    luci.sys.exec('uci commit ddns')
    luci.sys.exec('/etc/init.d/ddns stop; /etc/init.d/ddns start')
    
    return
end


function get_time()
    local timezone_v, city_v, time_v, ntp_enabled_v, ntp_server_v
    timezone_v    = string.trim(luci.sys.exec('uci get system.@system[0].timezone'))
    city_v        = string.trim(luci.sys.exec('uci get system.@system[0].city'))
    time_v        = string.trim(luci.sys.exec('date +"%Y-%m-%d %H:%M:%S"'))
    ntp_enabled_v = string.trim(luci.sys.exec('uci get system.ntp.enabled'))
    ntp_server_v  = string.trim(luci.sys.exec("uci get system.ntp.server | awk -F' ' '{print $4}'"))
    
    local resp_s = {} 
    resp_s = {
        timezone    = timezone_v,
        city        = city_v,
        time        = time_v,
        ntp_enabled = ntp_enabled_v,
        ntp_server  = ntp_server_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_time()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local timezone_v, city_v, time_v, ntp_enabled_v, ntp_server_v
    timezone_v    = rcv_json["timezone"]
    city_v        = rcv_json["city"]
    ntp_enabled_v = rcv_json["ntp_enabled"]
    luci.sys.exec(string.format('uci set system.@system[0].timezone=%s', timezone_v))
    luci.sys.exec(string.format('uci set system.@system[0].city=%s', city_v))
    luci.sys.exec(string.format('uci set system.ntp.enabled=%s', ntp_enabled_v))
    
    if ntp_enabled_v == "1" then
        local ntp_server_t
        ntp_server_t = string.trim(luci.sys.exec("uci get system.ntp.server | awk -F' ' '{print $4}'"))
        ntp_server_v = rcv_json["ntp_server"]    
        luci.sys.exec(string.format('uci del_list system.ntp.server=%s', ntp_server_t))
        luci.sys.exec(string.format('uci add_list system.ntp.server=%s', ntp_server_v))
        luci.sys.exec('uci commit system')
        
        luci.sys.exec('/etc/init.d/sysntpd restart')
    else
        luci.sys.exec('uci commit system')
        luci.sys.exec('/etc/init.d/sysntpd stop')
        
        local manual_time = rcv_json["time"]
        -- format: 'date -s "2020-11-18 17:41:00"'
        luci.sys.exec(string.format('date -s "%s"', manual_time))
    end
    
    luci.sys.exec('/etc/init.d/system restart')
    
    return
end


function get_firewall_advance()
    local dmz_enabled_v, dmz_ip_v
    local uci = require("uci").cursor()
        
    -- find "DMZ" section. 
    local i = -1
    local idx = -1
    uci:foreach("firewall", "redirect",
    function(s)
        i = i + 1
        if s.name and s.name == "DMZ" then
            idx = i
            return false
        end
    end)

    if idx >= 0 then
        dmz_enabled_v = ENABLE_ON
        dmz_ip_v = string.trim(luci.sys.exec(string.format('uci get firewall.@redirect[%d].dest_ip', idx)))
    else
        dmz_enabled_v = ENABLE_OFF
        dmz_ip_v = ""
    end 
    
    local resp_s = {} 
    resp_s = {
        dmz_enabled = dmz_enabled_v,
        dmz_ip = dmz_ip_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_firewall_advance()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"post data is null..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
       
    if rcv_succ == 0 then return end
    
    local dmz_enabled_v, dmz_ip_v
    local uci = require("uci").cursor()
    local dmz_idx = -1
    
    -- find "DMZ" section. 
    local i = -1
    uci:foreach("firewall", "redirect",
            function(s)
                  i = i + 1
                    if s.name and s.name == "DMZ" then
                        dmz_idx = i
                        return false
                    end
              end)

    dmz_enabled_v = rcv_json["dmz_enabled"]
    dmz_ip_v = rcv_json["dmz_ip"]
        
    if dmz_enabled_v == ENABLE_ON then
        -- enable DMZ function.
        local idx = -1
        if dmz_idx == -1 then
            luci.sys.exec("uci add firewall redirect")
        
            local j = -1
            uci:foreach("firewall", "redirect", function(s) j = j + 1 end)
                
            if j == -1 then idx = 0 else idx = j + 1 end    
        else
            idx = dmz_idx                      
        end  
       
        if idx >=0 then
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].name="%s"',    idx, "DMZ"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].src="%s"',     idx, "wan"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].dest_ip="%s"', idx,  dmz_ip_v))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].proto="%s"',   idx, "all"))
            luci.sys.exec(string.format('uci set firewall.@redirect[%d].dest="%s"',    idx, "lan"))
        end
    else
        -- disable DMZ function.
        if dmz_idx >= 0 then
            -- "DMZ" section is existed, delete. 
            luci.sys.exec(string.format('uci delete firewall.@redirect[%d]', dmz_idx))
        end
    end   
    
    luci.sys.exec('uci commit firewall')
    luci.sys.exec('/etc/init.d/firewall restart')
    
    return  
end


function get_firewall_rule()
	local curr_s
	local rv = {}
	local fd = io.open("/etc/blackwhitelist", "r")
	
	if fd then
		while true do
			local ln = fd:read("*l")
			if not ln then
				break
			else
				if string.len(ln) == 0  then
				else
					local name_v, mac_v, srcip_v, srcifc_v, dstip_v, dstifc_v, protocol_v, port_v = string.trim(ln):match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
					if mac_v ~= "*" then 
					    srcip_v  = ""
					    srcifc_v = ""
					    dstip_v  = ""
					    dstifc_v = ""
					    protocol_v = ""
					    port_v   = ""
					else
					    mac_v    = ""
					end

					rv[#rv+1] = {
					    name     = name_v,
					    mac      = mac_v,
					    srcip    = srcip_v,
					    srcifc   = srcifc_v,
					    dstip    = dstip_v,
					    dstifc   = dstifc_v,
					    protocol = protocol_v,
					    port     = port_v
					}
				end
			end
	    end
	    fd:close()
	end

	local mode = string.trim(luci.sys.exec("uci get misc.blackwhitelist.mode"))
	if not mode then mode = "0"	end
	
	if #rv == 0 then
		curr_s = string.format('{"mode":"%s", "list":[]', mode) 
	else
		curr_s = string.format('{"mode":"%s", "list":', mode) 
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(curr_s)

	if #rv ~= 0 then
		luci.http.write_json(rv)
	end

	luci.http.write('}')
	
	return
end


function apply_firewall_rule()
	local cjson = require "cjson"
	local postdata = nil
	local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
	local rcv_json = nil
	local rcv_succ = 0
	local resp_s
	
	if (postdata_len > 0) then
		postdata = io.read(postdata_len)
		rcv_json = cjson.decode(postdata)
	end
	
	if (postdata ~= nil and rcv_json ~= nil) then
		resp_s = '{"result":0, "msg":"..."}'
		rcv_succ = 1
	else
		resp_s = '{"result":1, "msg":"post data is null..."}'
	end
	
	luci.http.prepare_content("application/json")
	luci.http.write(resp_s)
	
	if rcv_succ == 0 then return end
	
	luci.sys.exec('rm /etc/blackwhitelist -rf; rm /etc/firewall.user.blackwhitelist -rf; touch /etc/blackwhitelist; touch /etc/firewall.user.blackwhitelist') 
		
    local blackwhitelist = rcv_json["list"]
    local mode = rcv_json["mode"]
    local k = 0
    for i, v in ipairs(blackwhitelist) do
        local name_v, mac_v, srcip_v, srcifc_v, dstip_v, dstifc_v, protocol_v, port_v
        name_v   = v["name"]
		mac_v    = v["mac"]
		if mac_v and mac_v ~= "" then
		    -- mac access control
		    srcip_v    = "*"
    		srcifc_v   = "*"
	    	dstip_v    = "*"
		    dstifc_v   = "*"
    		protocol_v = "*"
	    	port_v     = "*"
		
	        luci.sys.exec(string.format('echo "%s %s %s %s %s %s %s %s"  >> /etc/blackwhitelist', name_v, mac_v, srcip_v, srcifc_v, dstip_v, dstifc_v, protocol_v, port_v))
	        if mode == "1" then
	            -- 1: white list mode;
	            luci.sys.exec(string.format('echo "iptables -I FORWARD -m mac --mac-source %s -j ACCEPT" >> /etc/firewall.user.blackwhitelist', mac_v))
	            k = k + 1
		    elseif mode == "2" then 
		        -- 2: black list mode;
		        luci.sys.exec(string.format('echo "iptables -I FORWARD -m mac --mac-source %s -j DROP" >> /etc/firewall.user.blackwhitelist', mac_v))
		        luci.sys.exec(string.format('echo "iptables -I INPUT   -m mac --mac-source %s -j DROP" >> /etc/firewall.user.blackwhitelist', mac_v))
		    else
		        -- 0: off
		    end
		else
		    -- ip access control
		    mac_v      = "*"
		    srcip_v    = v["srcip"]
    		srcifc_v   = v["srcifc"]
	    	dstip_v    = v["dstip"]
		    dstifc_v   = v["dstifc"]
    		protocol_v = v["protocol"]
	    	port_v     = v["port"]
    		
            luci.sys.exec(string.format('echo "%s %s %s %s %s %s %s %s"  >> /etc/blackwhitelist', name_v, mac_v, srcip_v, srcifc_v, dstip_v, dstifc_v, protocol_v, port_v))
            
            if srcifc_v == "wan" then srcifc_v = "" .. wan_ifc else srcifc_v = "" .. lan_ifc end
	        if dstifc_v == "wan" then dstifc_v = "" .. wan_ifc else dstifc_v = "" .. lan_ifc end
	        
	        if mode == "1" then
	            -- 1: white list mode;
	            if protocol_v == "tcp" or protocol_v == "TCP" then
	                protocol_v = " -p tcp -m tcp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j ACCEPT" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	                k = k + 1
	            elseif protocol_v == "udp" or protocol_v == "UDP" then
	                protocol_v = " -p udp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j ACCEPT" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	                k = k + 1
	            else
	                protocol_v = " -p tcp -m tcp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j ACCEPT" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	                k = k + 1
	                protocol_v = " -p udp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j ACCEPT" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	                k = k + 1
	            end
	        elseif mode == "2" then 
		        -- 2: black list mode;
		        if protocol_v == "tcp" or protocol_v == "TCP" then
	                protocol_v = " -p tcp -m tcp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j DROP" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	            elseif protocol_v == "udp" or protocol_v == "UDP" then
	                protocol_v = " -p udp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j DROP" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	            else
	                protocol_v = " -p tcp -m tcp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j DROP" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	                protocol_v = " -p udp "
	                luci.sys.exec(string.format('echo "iptables -I FORWARD -i %s -s %s -o %s -d %s %s --dport %s -j DROP" >> /etc/firewall.user.blackwhitelist', srcifc_v, srcip_v, dstifc_v, dstip_v, protocol_v, port_v))
	            end
		    else
		        -- 0: off
		    end
		end
    end
    
    -- white list mode
    if k > 0 then
	    luci.sys.exec(string.format('echo "iptables -I FORWARD %d -j DROP" >> /etc/firewall.user.blackwhitelist', k+1))
	    luci.sys.exec('echo "iptables -I FORWARD -i lo -j ACCEPT" >> /etc/firewall.user.blackwhitelist')
        luci.sys.exec('echo "iptables -I FORWARD -m state --state RELATED,ESTABLISHED  -j ACCEPT" >> /etc/firewall.user.blackwhitelist')
	end
    
    luci.sys.exec("uci set misc.blackwhitelist.mode=" .. mode)
    luci.sys.exec("uci commit misc")
    
    luci.sys.exec('rm /etc/firewall.user -rf; touch /etc/firewall.user')
    -- Note: blackwhitelist first ! 
    luci.sys.exec('cat /etc/firewall.user.blackwhitelist >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.fwd >> /etc/firewall.user')
    luci.sys.exec('cat /etc/firewall.user.urlfilter >> /etc/firewall.user')
    
    -- firewall restart
    luci.sys.exec('/etc/init.d/firewall restart')
end


function get_acs_setting()
    local url_v, username_v, password_v, local_username_v, local_password_v, local_port_v
    url_v      = string.trim(luci.sys.exec('uci get easycwmp.@acs[0].url'))
    username_v = string.trim(luci.sys.exec('uci get easycwmp.@acs[0].username'))
    password_v = string.trim(luci.sys.exec('uci get easycwmp.@acs[0].password'))
    local_username_v = string.trim(luci.sys.exec('uci get easycwmp.@local[0].username'))
    local_password_v = string.trim(luci.sys.exec('uci get easycwmp.@local[0].password'))
    local_port_v     = string.trim(luci.sys.exec('uci get easycwmp.@local[0].port'))
    
    local resp_s = {} 
    resp_s = {
        url      = url_v,
        username = username_v,
        password = password_v,
        local_username = local_username_v,
        local_password = local_password_v, 
        local_port = local_port_v 
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end


function apply_acs_setting()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local url_v, username_v, password_v, local_username_v, local_password_v, local_port_v
    url_v      = rcv_json["url"]
    username_v = rcv_json["username"]
    password_v = rcv_json["password"]
    local_username_v = rcv_json["local_username"]
    local_password_v = rcv_json["local_password"]
    local_port_v     = rcv_json["local_port"]
    
    luci.sys.exec(string.format('uci set easycwmp.@acs[0].url="%s"', cvt_char(url_v) ))
    luci.sys.exec(string.format('uci set easycwmp.@acs[0].username="%s"', cvt_char(username_v) ))
    luci.sys.exec(string.format('uci set easycwmp.@acs[0].password="%s"', cvt_char(password_v) ))
    luci.sys.exec(string.format('uci set easycwmp.@local[0].username="%s"', cvt_char(local_username_v) ))
    luci.sys.exec(string.format('uci set easycwmp.@local[0].password="%s"', cvt_char(local_password_v) ))
    luci.sys.exec(string.format('uci set easycwmp.@local[0].port="%s"', local_port_v))
    luci.sys.exec(string.format('uci set firewall.@rule[0].dest_port="%s"', local_port_v))
    luci.sys.exec('uci commit easycwmp')
    luci.sys.exec('uci commit firewall')
    
    -- Restart firewall
    luci.sys.exec('/etc/init.d/firewall restart')
    -- Restart easycwmpd
    luci.sys.exec('sleep 1; killall easycwmpd')
    
    return
end

function set_language()
    local cjson = require "cjson"
    local postdata = nil
    local postdata_len = tonumber(os.getenv("CONTENT_LENGTH")) or 0
    local rcv_json = nil
    local rcv_succ = 0

    if (postdata_len > 0) then
        postdata = io.read(postdata_len)
        rcv_json = cjson.decode(postdata)
    end

    if (postdata ~= nil and rcv_json ~= nil) then
        resp_s = '{"result":0, "msg":"..."}'
        rcv_succ = 1
    else
        resp_s = '{"result":1, "msg":"..."}'
    end    
    
    luci.http.prepare_content("application/json")
    luci.http.write(resp_s)
    
    if rcv_succ == 0 then return end
    
    local language_v = rcv_json["language"]
    uci.set("misc", "misc", "language", language_v)
    uci.commit("misc")
    
    return
end

function get_language()
    local language_v = uci.get("misc", "misc", "language")
    local resp_s = {} 
    resp_s = {
        language = language_v
    }
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(resp_s)
    
    return
end

function currentlanguage()
    local language_v = uci.get("misc", "misc", "language")
    return language_v
end
