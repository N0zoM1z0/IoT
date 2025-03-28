--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.admin.index", package.seeall)

function index()
  -- get the current enduser name, the enduser name and password can be modified.
	function get_enduser_name()
    local def_enduser_name = 'user'
   --local enduser_name = string.trim(luci.sys.exec("cat /etc/enduser_nm"))
    local ln = string.trim(luci.sys.exec("cat /etc/passwd | grep '500:500'"))
    local enduser_name = ln:match("^(%S-):(.*)")
    if enduser_name and enduser_name ~= "" then
      return enduser_name
    else
      return def_enduser_name
    end    
  end
	
	local root = node()
	if not root.target then
		root.target = alias("admin")
		root.index = true
	end

	local page   = node("admin")
	page.target  = template("opsw/main")
	-- page.target  = firstchild()
	page.title   = _("Administration")
	page.order   = 10
	page.sysauth = {"CMCCAdmin", get_enduser_name()} 
	page.sysauth_authenticator = "htmlauth"
	page.ucidata = true
	page.index = true

	-- Empty services menu to be populated by addons
	entry({"admin", "services"}, firstchild(), _("Services"), 40).index = true

	entry({"admin", "logout"}, call("action_logout"), _("Logout"), 90)
end

function action_logout()
	local dsp = require "luci.dispatcher"
	local sauth = require "luci.sauth"
	if dsp.context.authsession then
		sauth.kill(dsp.context.authsession)
		dsp.context.urltoken.stok = nil
	end

	luci.http.header("Set-Cookie", "sysauth=; path=" .. dsp.build_url())
	luci.http.redirect(luci.dispatcher.build_url())
end
