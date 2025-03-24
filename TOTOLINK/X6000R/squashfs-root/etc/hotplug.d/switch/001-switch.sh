if [ "$PORT" = "5" ]; then
	datconf -f /tmp/cste/temp_status set ui_effect_now 1
	if      [ "UP" = "$ACTION" ];then
		lktos_reload wan_port_up
	fi
fi
