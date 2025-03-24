<html>
<head>
<title>SSl VPN Client</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist= new Array();
<% get_client(); %>

function init()
{
	var F = document.vpn_client;
	parent.document.getElementById("save_bg").style.display="none"; 
	if ( datalist[0].tunnel == '1' ) F.split_tunnel.checked = true;
	F.dns_suffix.value = datalist[0].suffix;
	F.p_dns.value = datalist[0].pdns;
	F.s_dns.value = datalist[0].sdns;
	F.addr_begin.value = datalist[0].addrs;
	F.addr_end.value = datalist[0].addre;
	F.lcp_timeout.value = datalist[0].timeout;
}

function uiDoSave(F)
{
	F.submit_button.value = "ssl_vpn_client";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display=""; 
}
</script>
<body onload="init();">
<FORM autocomplete=off id=frm method=<% get_http_method(); %> name=vpn_client action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("SSL VPN Client"));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Client IP Address Range"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Split Tunnel Support")+":");</script>
		<input type=checkbox name=split_tunnel><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("DNS Suffix (Optional)")+":");</script>
                <INPUT maxLength=127 size=20 name="dns_suffix" id="dns_suffix" value=''>
		<span id=msg_dns_suffix></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Primary DNS Server (Optional)")+":");</script>
                <INPUT maxLength=15 size=20 name="p_dns" id="p_dns" value=''>
		<span id=msg_p_dns></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Secondary DNS Server (Optional)")+":");</script>
                <INPUT maxLength=15 size=20 name="s_dns" id="s_dns" value=''>
		<span id=msg_s_dns></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Client Address Range Begin")+":");</script>
                <INPUT maxLength=15 size=20 name="addr_begin" id="addr_begin" value=''>
		<span id=msg_addr_begin></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Client Address Range End")+":");</script>
                <INPUT maxLength=15 size=20 name="addr_end" id="addr_end" value=''>
		<span id=msg_addr_end></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("LCP Timeout")+":",SPACE_DOWN,SPACE_DOWN);</script>
                <INPUT maxLength=6 size=20 name="lcp_timeout" id="lcp_timeout" value="" onblur=msg_chk_range(this.value,"lcp_timeout",LCP_TIMEOUT_START,LCP_TIMEOUT_TO,10,IS_FIELD,0,"msg_lcp_timeout")>&nbsp;<script>document.write(__T(unit.seconds)+" ("+__T(def.range)+" : "+LCP_TIMEOUT_START+" - "+LCP_TIMEOUT_TO);</script>)
		<span id=msg_lcp_timeout></span>
                </td></tr>
        </TABLE>
	<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
</TABLE>
</form>
</body></HTML>
