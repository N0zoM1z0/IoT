module("luci.controller.admin.wizard", package.seeall)  

local uci = require "luci.model.uci".cursor()
  
function index()  
    local page
    
    page = entry({"admin", "wizard"}, alias("admin", "wizard", "control"), _("wizard ---"), 30)
    page = entry({"admin", "wizard", "control"}, template("opsw/wizard"), _("wizard ~~"), 2)
    page.leaf = true

    page = entry({"admin", "opsw", "main.html"}, alias("admin", "opsw", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "manage.html"}, alias("admin", "manage", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "setup.html"}, alias("admin", "setup", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "features.html"}, alias("admin", "features", "control"), nil)
    page.leaf = true
end  



