<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script>
<TR><script>draw_td(O_GUI,FUNTITLE,__T(wan.sipset),"colspan=2");</script></TR>
<input type=hidden name=wan_ipaddr>
<input type=hidden name=wan_netmask>
<input type=hidden name=wan_gateway>
<input type=hidden name=wan_dns>
<script>
if ( nv_wan_dns == "" ) nv_wan_dns="0.0.0.0 0.0.0.0";
var _name=new Array(__TC(wan.interipaddr),__TC(wan.mask),__TC(wan.defgw),__TC(lan.dnssource),__TC(spell_words(static_dns_rule,"1")),__TC(spell_words(static_dns_rule,"2")));
var _val=new Array("_ip","_mask","_gw","wan_static_dns_mode","_dns1","_dns2");
if ( ap_mode == "1" ) 
	var _nv_wan_dns = nv_ap_wan_dns.split(" ");
else
	var _nv_wan_dns = nv_wan_dns.split(" ");
var _nv_val = new Array(nv_wan_ipaddr,nv_wan_netmask,nv_wan_gateway,"",_nv_wan_dns[0],_nv_wan_dns[1]);
var tmp_dns_mode="<% nvram_get("wan_static_dns_mode"); %>";
if ( ap_mode == "1" ) 
{
	var _nv_val = new Array(nv_ap_wan_ipaddr,nv_ap_wan_netmask,nv_ap_wan_gateway,"",_nv_wan_dns[0],_nv_wan_dns[1]);
	tmp_dns_mode = "<% nvram_get("ap_wan_static_dns_mode"); %>";
}
var hint_val = new Array(spell_words(hint_rule,"192.168.100.100"),spell_words(hint_rule,"255.255.255.0"),spell_words(hint_rule,"192.168.100.1"),"",spell_words(hint_rule,"1.2.3.4"),"");
for(var i=0; i<_name.length; i++)
{
	var tmp_val = _val[i];
	document.write("<TR>");
	draw_td(O_GUI,SUBTITLE,_name[i]);
	if ( _val[i] == "wan_static_dns_mode" ) 
	{
		var dns_name = new Array(__T(lan.useopendns),__T(lan.usethesedns));
		var dns_val = new Array(1,2);
		draw_object(O_GUI,SELBOX,"wan_static_dns_mode","onChange=SelDNS(this.form.wan_static_dns_mode.value,this.form)",dns_name,dns_val,tmp_dns_mode);
		
	}else{
		draw_object(O_GUI,IP,tmp_val,_nv_val[i]);
		if ( hint_val[i] != "" )
			document.write("&nbsp;&nbsp;"+hint_val[i]);
		document.write("<SPAN id='msg"+_val[i]+"'></SPAN>");
	}
	document.write("</TD></TR>");
}
</script>
