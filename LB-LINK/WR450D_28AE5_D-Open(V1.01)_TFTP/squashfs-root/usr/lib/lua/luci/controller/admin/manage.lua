module("luci.controller.admin.manage", package.seeall)  

local uci = require "luci.model.uci".cursor()
  
function index()  
    local page
    
    entry({"admin", "manage"}, alias("admin", "manage", "control"), _("manage ---"), 30).index = true  
    entry({"admin", "manage", "control"}, template("opsw/manage"), _("manage ~~"), 2)

    page = entry({"admin", "opsw", "main.html"}, alias("admin", "opsw", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "setup.html"}, alias("admin", "setup", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wizard.html"}, alias("admin", "wizard", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "features.html"}, alias("admin", "features", "control"), nil)
    page.leaf = true
end  



