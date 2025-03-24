var tmp_lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>";
var tmp_lan_mode = new Array("","ipv4","ipv6","ipv4&v6");
var lan_mode = tmp_lan_mode[tmp_lan_ip_mode];
var CHK_LAN_IP = 1;

function chk_ipv4_subnet(chk_ip,CHK_FLG)
{
	var iface = "<% get_vlan_iface(); %>";
	var iface_data = iface.split(",");
	var lan_sub=0;
	var errmsg = "";

	if (iface == "")
	{
		var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
		var lan_mask = "<% nvram_get("lan_netmask"); %>";

		if (valid_subnet(lan_ip,lan_mask,chk_ip) ) lan_sub=1;
	}
	else
	{
		for(var i=0; i<iface_data.length; i++)
		{
			var data = iface_data[i].split(":");
			if ( errmsg != "" ) break;
			if ( (CHK_FLG & CHK_LAN_IP) && data[0] == chk_ip ) 
				errmsg = __T(msg.subnet4);
			if ( data[0] && data[1] && valid_subnet(data[0],data[1],chk_ip) ) lan_sub=1;
		}
	}
	if (errmsg == "" && lan_sub == 0 ) errmsg = __T(msg.subnet8);
	return errmsg;
}

function my_vlan_subnet_check(chk_ip,CHK_FLG){
        var iface_data = ("<% get_vlan_iface(); %>").split(",");
	var errmsg = "";
	var lan_sub=0;
	if ( lan_mode == "ipv4" )
		errmsg = chk_ipv4_subnet(chk_ip,CHK_FLG);

	else if ( lan_mode == "ipv4&v6" )
	{
		if ( check_ipv4(chk_ip,VALID_IP_RULE1) <= 0 ) 
			errmsg = chk_ipv4_subnet(chk_ip,CHK_FLG);
	}
	return errmsg;	
}
