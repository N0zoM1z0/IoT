
<html>
<head>
<% no_cache(); %>
<% js_link(); %>
<script type="text/javascript" src="/position.js"></script>
<script type="text/javascript" src="/common.js"></script>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script>
var submit_button = '<% nvram_get("submit_button"); %>';
var submit_button2 = new Array();
var submit_button2 = submit_button.split('.');
var wait_time = '<% webs_get("wait_time"); %>';
var action_service="<% nvram_get("action_service"); %>";
var chk_action="<% nvram_get("chk_action"); %>";
var session_key="<% nvram_get("session_key"); %>";
var url_flag=0,status=0;
var page;
function init()
{
	setTimeout('autoreturn()',1000);
}
function autoreturn()
{
	/* modify by tina 070629 */
	
	var login_file = new Array("upgrade","reboot","lan_reboot","change_password","Backup_Restore","Factory_Defaults","Check_ID","backup_reboot","wan_reboot","vpn_adv_reboot","vpn_adv_del_reboot");
	var default_file = new Array("vlan_membership","firewall_kill_httpd","firewall","lan","lan_ipv6","ssl_cert");
	if ( submit_button == "" ) 
	{
		//alert("1.<% get_http_prefix(""); %>default.asp");
		top.location.href = "<% get_http_prefix(""); %>default.asp";
		return;
	}
	for(var i=0; i<login_file.length; i++)
	{
		if ( submit_button == login_file[i] ) 
		{
			//alert("2.<% get_http_prefix(""); %>default.asp");
			top.location.href =  "<% get_http_prefix(""); %>default.asp";
			return;
		}
	}
	
	for(var i=0; i<default_file.length; i++)
	{
		if ( submit_button == default_file[i] ) 
		{
			//alert("3.<% get_http_prefix(""); %>default.asp;session_id="+session_key);
			top.location.href = "<% get_http_prefix(""); %>default.asp;session_id="+session_key;
			return;
		}
		
	}
	
	top.frames("rightframe").location.href = submit_button+".asp;session_id="+session_key;
}
</script>
<BODY onload=init()>
<FORM name=frmst method=<% get_http_method(); %> action=apply.cgi>
</BODY>
</HTML>
