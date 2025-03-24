<input type=hidden name=wan_ipaddr>
<input type=hidden name=wan_netmask>
<input type=hidden name=wan_gateway>
<input type=hidden name=l2tp_server_ip>
<input type=hidden name=ppp_demand>
<input type=hidden name=ppp_mppe>
<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script>
<TR><script>draw_td(O_GUI,FUNTITLE,__T(wan.l2tpset),"colspan=2");</script></TR>
<script>
var _name=new Array(__T(share.ipaddr),__T(wan.mask),__T(share.gateway),__T(wan.l2tpserver));
var _val=new Array("_ip","_mask","_gw","_server");
var _nv_val = new Array(nv_wan_ipaddr,nv_wan_netmask,nv_wan_gateway,nv_l2tp_server_ip);
var tmp_val;
for(i=0; i<_name.length; i++)
{
	tmp_val = _val[i];
        document.write("<TR>");
        draw_td(O_GUI,SUBTITLE,_name[i]+":");
	draw_object(O_GUI,IP,tmp_val,_nv_val[i]);
	document.write("<SPAN id='msg"+_val[i]+"'></SPAN></TD></TR>");
}

<% support_invmatch("PPTP_SERVER_SUPPORT","1","/*"); %>
document.write("<TR>");
draw_td(O_GUI,SUBTITLE,__TC(share.version));
var _name = new Array("2","3");
draw_object(O_GUI,SELBOX,"l2tp_version","onChange=SEL_VER(this.form)",_name,_name,"<% nvram_get("l2tp_version"); %>");
document.write("</TD></TR>");
<% support_invmatch("PPTP_SERVER_SUPPORT","1","*/"); %>
</script>
<% support_invmatch("PPTP_SERVER_SUPPORT","1","<!--"); %>
<input type=hidden name=l2tpv3_cisco value="0">
<input type=hidden name=l2tpv3_auth value="0">
<script>
var v3_cisco = "<% nvram_get("l2tpv3_cisco"); %>";
if ( v3_cisco == "" ) v3_cisco = "0";
var v3_auth = "<% nvram_get("l2tpv3_auth"); %>";
if ( v3_auth == "" ) v3_auth = "1";
</script>
<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.cookielen));</script>
<script>
	var _name =  new Array("0","4","8");
	draw_object(O_GUI,SELBOX,"l2tpv3_cookie_len","",_name,_name,"<% nvram_get("l2tpv3_cookie_len"); %>");
</script>
</TD></TR>
<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.vendorid));</script>
<script>
	var _name= new Array(__T(wan.standard),__T(wan.cisco));
	var _val = new Array("0","9");
	draw_object(O_GUI,RADIO,"_l2tpv3_cisco",_val,_name,v3_cisco,"id=_l2tpv3_cisco onclick=CHG_CID(this.form)");</script>
</TD></TR>
<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.virtualcid));</script>
	<input size=20 maxlength=10 id=l2tpv3_cisco_vcid name=l2tpv3_cisco_vcid value="<% nvram_get("l2tpv3_cisco_vcid"); %>" onblur=msg_chk_range(this.value,'l2tpv3_cisco_vcid',VIRTUAL_CID_START,VIRTUAL_CID_TO,10,IS_FIELD,0,'msg_l2tpv3_cisco_vcid')>&nbsp;<script>document.write(spell_words(range_rule2,VIRTUAL_CID_START,VIRTUAL_CID_TO));</script><SPAN id=msg_l2tpv3_cisco_vcid></SPAN>
</TD></TR>
<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.auth));</script>
<script>
	var _name= new Array(__T(share.enable),__T(share.disable));
	var _val = new Array("1","0");
	draw_object(O_GUI,RADIO,"_l2tpv3_auth",_val,_name,v3_auth,"id=_l2tpv3_auth onclick=CHG_AUTH(this.form)");</script>

</TD></TR>
<% support_invmatch("PPTP_SERVER_SUPPORT","1","-->"); %>

