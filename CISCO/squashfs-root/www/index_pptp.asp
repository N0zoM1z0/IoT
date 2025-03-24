<input type=hidden name=wan_ipaddr>
<input type=hidden name=wan_netmask>
<input type=hidden name=wan_gateway>
<input type=hidden name=pptp_server_ip>
<input type=hidden name=ppp_demand>
<input type=hidden name=ppp_mppe>
<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script>
<TR><script>draw_td(O_GUI,FUNTITLE,__T(wan.pptpset),"colspan=2");</script></TR>
<script>
var _name=new Array(__TC(share.ipaddr),__TC(wan.mask),__TC(wan.defgw),__TC(wan.pptpserver));
var _val=new Array("_ip","_mask","_gw","_server");
var _nv_val = new Array(nv_wan_ipaddr,nv_wan_netmask,nv_wan_gateway,nv_pptp_server_ip);
var hint_val = new Array(spell_words(hint_rule,"192.168.100.100"),spell_words(hint_rule,"255.255.255.0"),spell_words(hint_rule,"192.168.100.1"),spell_words(hint_rule,"192.168.100.1"))
var tmp_val;
for(i=0; i<_name.length; i++)
{
	tmp_val = _val[i];
        document.write("<TR>");
        draw_td(O_GUI,SUBTITLE,_name[i]);
	draw_object(O_GUI,IP,tmp_val,_nv_val[i]);
	document.write("&nbsp;&nbsp;"+hint_val[i]);
	document.write("<SPAN id='msg"+_val[i]+"'></SPAN></TD></TR>");
}
</script>
