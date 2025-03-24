module("luci.controller.admin.setup", package.seeall)  

local uci = require "luci.model.uci".cursor()
  
function index()  
    local page
    
    entry({"admin", "setup"}, alias("admin", "setup", "control"), _("setup ---"), 30).index = true  
    entry({"admin", "setup", "control"}, template("opsw/setup"), _("setup ~~"), 2)

    page = entry({"admin", "opsw", "main.html"}, alias("admin", "opsw", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "manage.html"}, alias("admin", "manage", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "wizard.html"}, alias("admin", "wizard", "control"), nil)
    page.leaf = true
    page = entry({"admin", "opsw", "features.html"}, alias("admin", "features", "control"), nil)
    page.leaf = true
end  



