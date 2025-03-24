<script>
	var rv130_vpn_running = "<% get_reboot_flag("vpn_running"); %>";	
	var reboot_by_no_ccm_gcm, module_exist_flag;
	<% get_reboot_flag("vpn_sec"); %>
	document.write("rv130_vpn_running="+rv130_vpn_running+";\nmodule_exist_flg="+module_exist_flag);
	parent.document.getElementById("vpn_running").value = rv130_vpn_running;
	parent.document.getElementById("module_exist_flag").value = module_exist_flag;
</script>
