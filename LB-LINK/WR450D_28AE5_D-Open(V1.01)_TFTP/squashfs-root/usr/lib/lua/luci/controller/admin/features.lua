module("luci.controller.admin.features", package.seeall)  

local uci = require "luci.model.uci".cursor()
  
function index()  
    local page
    
    entry({"admin", "features"}, alias("admin", "features", "control"), _("features ---"), 30).index = true  
    entry({"admin", "features", "control"}, template("opsw/features"), _("features ~~"), 2)

    page = entry({"admin", "opsw", "main.html"}, alias("admin", "opsw", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "manage.html"}, alias("admin", "manage", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "setup.html"}, alias("admin", "setup", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wizard.html"}, alias("admin", "wizard", "control"), nil)
    page.leaf = true
end  



