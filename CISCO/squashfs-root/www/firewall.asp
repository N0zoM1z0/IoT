<html>
<head>
<title>Basic Setting</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
<% get_port_table("trigger,single,range,upnp"); %>

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frm_firewall;
	if ( "<% nvram_get("remote_ip_any"); %>" == "1" ) 
		dis_anyip_group(1,F);		
	else
		dis_anyip_group(0,F);		
	SelRmt(F);
	SelUPNP(F);
	var _name = new Array("java","activex","cookie","proxy");
	for(var i=0; i<_name.length; i++)
		chk_checked(_name[i]);
        if("<% nvram_get("http_from"); %>" == "wan" )
		choose_disable(F._remote_upgrade);
	
	default_nv = keep_val(F,"");
}

function dis_anyip_group(flg,F)
{
	for(var j=0; j<5; j++){
		if ( flg == 1 ) 
			choose_disable(eval("F.remote_ip_"+j));
		else
			choose_enable(eval("F.remote_ip_"+j));
	}
}

function SelIP(val,F){
	if ( val == 0 ){ // Any IP Address
		clear_msg("remote_ip_0","_anyip");
		clear_msg("remote_ip_1","_anyip");
		clear_msg("remote_ip_2","_anyip");
		clear_msg("remote_ip_3","_anyip");
		clear_msg("remote_ip_4","_anyip");
		dis_anyip_group(1,F);		
	}else
		dis_anyip_group(0,F);		
}

function valid_value(F){
	var errflg = 0 ; 
	var _name = new Array("java","activex","cookie","proxy");
	if ( F._remote_management.checked == true )
	{
		if ( !msg_chk_range(F.http_wanport.value,"http_wanport",PORT_START,PORT_TO,10,IS_FIELD,0,"_wanport") ) errflg = 1;
	}
	for(var i=0; i<_name.length; i++)
	{
	    if ( eval("F._block_"+_name[i]).checked && eval("F.block_"+_name[i]+"_manual")[1].checked) 
	    {
		if ( !msg_chk_range(eval("F.block_"+_name[i]+"_port").value,"block_"+_name[i]+"_port",PORT_START,PORT_TO,10,IS_FIELD,0,"_"+_name[i]))	errflg = 1;
	    }
	}
	if ( F._remote_management.checked == true ) 
	{ 
		if(F.remote_ip_any[1].checked == true){
			clear_msg("remote_ip_0","_anyip");
			clear_msg("remote_ip_1","_anyip");
			clear_msg("remote_ip_2","_anyip");
			clear_msg("remote_ip_3","_anyip");
			clear_msg("remote_ip_4","_anyip");
        	        if(F.remote_ip_0.value == "0" && F.remote_ip_1.value == "0" && F.remote_ip_2.value == "0" && F.remote_ip_3.value == "0" ) {
				parent.document.getElementById("obj_id").value = "_anyip";
				my_alert(O_VAR,"remote_ip",__T(msg.illegal),"5","_anyip");
				errflg=1;	
        	     }else  if(parseInt(F.remote_ip_3.value) > parseInt(F.remote_ip_4.value)) {
				parent.document.getElementById("obj_id").value = "_anyip";
				my_alert(O_VAR,"remote_ip_4",__T(msg.errstartend),"0","_anyip");
				errflg=1;	
        	     }else if ( !my_valid_m_value("IP",F,"remote_ip","",VALID_IP_RULE7,ZERO_NO,"_anyip") ) 
				errflg=1;	
		     if ( !msg_chk_range(F.remote_ip_4.value,"remote_ip_4",0,255,10,IS_FIELD,0,"_anyip") ) 
		     	errflg = 1;
	        }	
		clear_msg("remote_mgt_https_0","msg_rhttp");
		clear_msg("remote_mgt_https_1","msg_rhttp");
		//Remote access and web access does not match
	        if( (F.remote_mgt_https[0].checked && F._http_enable.checked == false) ||
        	    (F.remote_mgt_https[1].checked && F._https_enable.checked == false)) 
	        {
        	        my_alert(O_VAR,"remote_mgt_https_0",__T(msg.remoteaccconfilict),"0","msg_rhttp");
        	        my_alert(O_VAR,"remote_mgt_https_1",__T(msg.remoteaccconfilict),"0","msg_rhttp");
                	errflg=1;
	        }
	}
	if(F._http_enable.checked == false && F._https_enable.checked == false) errflg = 1;
	if ( errflg == 1 ) return false;
	return true;
	
}

var TRIGGER_ERR = 1;
var SINGLE_ERR = 2;
var RANGE_ERR = 3;
var UPNP_ERR = 4;

function valid_check_port(F)
{
	if ( F._remote_management.checked == false ) return 0;
	var val = F.http_wanport.value;
	for(var i=0; i<port_trigger.length; i++)
	{
		if ( port_trigger[i][2] != "on" ) continue;
		if ( chk_range("", val, port_trigger[i][0], port_trigger[i][1], "nochg") ) 
			return TRIGGER_ERR;
	}
	for(var i=0; i<forward_single.length; i++)
	{
		if ( forward_single[i][3] != "on" || forward_single[i][2] == "udp") continue;
		if ( forward_single[i][0] == val )  
			return SINGLE_ERR;
	}
	for(var i=0; i<forward_port.length; i++)
	{
		if ( forward_port[i][3] != "on" || forward_port[i][2] == "udp") continue;
		if ( chk_range("", val, forward_port[i][0], forward_port[i][1], "nochg") ) 
			return RANGE_ERR;
	}
	for(var i=0; i<upnp_port.length; i++)
	{
		if ( upnp_port[i][3] != "on" || upnp_port[i][2] == "udp") continue;
		if ( chk_range("", val, upnp_port[i][0], upnp_port[i][1], "nochg") ) 
			return UPNP_ERR;
	}
	return 0;
}

function uiDoSave(F){
	var errflg=0, errname;
	if ( !valid_value(F) ) return false;
	errflg = valid_check_port(F);
	if ( errflg != 0 ) 
	{
		if ( errflg == TRIGGER_ERR ) 
			errname = __T(filter.portrangetrigger);
		else if ( errflg == SINGLE_ERR ) 
			errname = __T(filter.singleforward);
		else if ( errflg == RANGE_ERR ) 
			errname = __T(filter.portrangeforward);
		else if ( errflg == UPNP_ERR ) 
			errname = __T(filter.upnpforward);
		my_alert(O_VAR,"http_wanport",spell_words(errport_msg,errname),"0","_wanport");
		
		return false;
	}
	var _name = new Array("filter");/*"block_multicast");*/
	for(var i=0; i<_name.length; i++)
	{
		eval("F."+_name[i]).value = "off";
		if ( eval("F._"+_name[i]).checked == true ) 
			eval("F."+_name[i]).value = "on";
	}
	var _name = new Array("block_wan","http_enable","https_enable","multicast_pass","immediate_leave_enable","dos_protection","remote_management","remote_upgrade","block_java","block_cookie","block_activex","block_proxy","upnp_enable","upnp_config","upnp_internet_dis","sip_alg_enable");
	for(var i=0; i<_name.length; i++)
        {
                eval("F."+_name[i]).value = "0";
                if ( eval("F._"+_name[i]).checked == true )
                        eval("F."+_name[i]).value = "1";
        }
	if ( F.sip_alg_enable.value == "1" && "<% nvram_get("sip_alg_enable"); %>" == "0" ) 
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"alert_result_firewall(1)","alert_result_firewall(0)","","yesno");	
		
	}else{
		alert_result_firewall(1);
	}
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("firewall.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
		
}

function alert_result_firewall(val)
{
	var F = document.frm_firewall;
	alert_result(0);
	if ( val == 1 ) 
	{	
		var http = document.location.href.substring(0,document.location.href.indexOf(":"));
		var gui_http = F.http_enable.value;
		var gui_https = F.https_enable.value; 
		
		F.submit_button.value="firewall";

		if ( (gui_http != "<% nvram_get("http_enable"); %>") ||
	             (gui_https != "<% nvram_get("https_enable"); %>") || 
		     ( F._remote_management.checked == true && 
	               F.http_wanport.value != "<% nvram_get("http_wanport"); %>" )) 
		{
			F.submit_button.value = "firewall_kill_httpd";
		}

		if ( "<% nvram_get("remote_management"); %>" == "0" && 
		     F._remote_management.checked == true )
		{
			F.submit_button.value = "firewall_kill_httpd";
		}

		if ( F._remote_management.checked == true )
		{
		 	var getnv = "<% nvram_get("remote_mgt_https"); %>";
			if ( (getnv != "0" && F.remote_mgt_https[0].checked) || 
			     (getnv != "1" && F.remote_mgt_https[1].checked))
				F.submit_button.value = "firewall_kill_httpd";
		} 

		if ( F.sip_alg_enable.value == "1" && "<% nvram_get("sip_alg_enable"); %>" == "0" ) 
			F.submit_button.value="firewall_reboot";
		
		if ( F.submit_button.value == "firewall" ) 
			parent.document.getElementById("save_bg").style.display="";
		else
			parent.document.getElementById("hidden_bg").style.display="";
		
		F.gui_action.value="Apply";
		F.submit();
		if ( http_from == "wan" ) 
		{
			setTimeout("chk_st()", 15000);
		}	
	}
}

function SelRmt(F){
	if ( F._remote_management.checked == true )  
	{
		DISABLE_PART(F,"remote_start","remote_end",0);
		if (F.remote_ip_any[0].checked == true)
		dis_anyip_group(1,F);
	}
	else
	{
		DISABLE_PART(F,"remote_start","remote_end",1);
		clear_msg("remote_ip_0","_anyip");
		clear_msg("remote_ip_1","_anyip");
		clear_msg("remote_ip_2","_anyip");
		clear_msg("remote_ip_3","_anyip");
		clear_msg("remote_ip_4","_anyip");
		clear_msg("http_wanport","_wanport");
	}
        if("<% nvram_get("http_from"); %>" == "wan" )
		choose_disable(F._remote_upgrade);
}

function chk_checked(obj_name){
	var F = document.frm_firewall;
	if ( eval("F._block_"+obj_name).checked )
	{
		choose_enable(eval("F.block_"+obj_name+"_manual")[0]);
		choose_enable(eval("F.block_"+obj_name+"_manual")[1]);
		chg_auto_manual(obj_name);
	}
	else
	{
		choose_disable(eval("F.block_"+obj_name+"_manual")[0]);
		choose_disable(eval("F.block_"+obj_name+"_manual")[1]);
		choose_disable(eval("F.block_"+obj_name+"_port"));
		clear_msg("block_"+obj_name+"_port","_"+obj_name);
	}
}

function chg_auto_manual(obj_name){
	var F = document.frm_firewall;
	if ( eval("F.block_"+obj_name+"_manual")[0].checked )
	{
		//alert("block_"+obj_name+"_port");
		//clear_msg("block_"+obj_name+"_port","_"+obj_name);
		choose_disable(eval("F.block_"+obj_name+"_port"));
		clear_msg("block_"+obj_name+"_port","_"+obj_name);
	}
	else
		choose_enable(eval("F.block_"+obj_name+"_port"));
	
}

function SelUPNP(F)
{
	if ( F._upnp_enable.checked == true ) 
	{
		choose_enable(F._upnp_config);
		choose_enable(F._upnp_internet_dis);
	}else{

		choose_disable(F._upnp_config);
		choose_disable(F._upnp_internet_dis);
	}
}

function chk_http(F)
{
	clear_msg("_http_enable","msg_http");
	clear_msg("_https_enable","msg_http");
	if(F._http_enable.checked == false && F._https_enable.checked == false)
	{
		my_alert(O_VAR,"_http_enable",__T(msg.selweb),"0","msg_http");
		return false;	
	}
	if(F._http_enable.checked == true && F._https_enable.checked == false)
	{
		my_alert(O_GUI,WARNING,__T(syslog.event_warn),__T(msg.encryptionmsg),"firewall_alert_result(1)","firewall_alert_result(0)","","yesno");	
		return true;
	}
	return true;
}
function firewall_alert_result(val)
{
	alert_result(0);
	if ( val == 0 )
	{
		var F = document.frm_firewall;
		F._http_enable.checked = false;
		F._https_enable.checked = true;
		
	} 
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_firewall" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=filter>
<input type=hidden name=block_wan>
<input type=hidden name=block_java>
<input type=hidden name=block_cookie>
<input type=hidden name=block_activex>
<input type=hidden name=block_proxy>
<input type=hidden name=http_enable>
<input type=hidden name=https_enable>
<input type=hidden name=multicast_pass>
<input type=hidden name=dos_protection>
<input type=hidden name=remote_management>
<input type=hidden name=remote_upgrade>
<input type=hidden name=upnp_enable>
<input type=hidden name=upnp_config>
<input type=hidden name=upnp_internet_dis>
<input type=hidden name=immediate_leave_enable>
<input type=hidden name=wait_time value=5>
<input type=hidden name=sip_alg_enable>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.basicset));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.ipspoof));</script>
		<input type=checkbox name=_filter <% nvram_match("filter","on","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.dos));</script>
		<input type=checkbox name=_dos_protection <% nvram_match("dos_protection","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.blockwanping));</script>
		<input type=checkbox name=_block_wan <% nvram_match("block_wan","1","checked"); %>><script>Capture(share.enable);</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.lanvpnweb));</script>
		<INPUT type=checkbox value=1 id=_http_enable name=_http_enable <% nvram_match("http_enable","1","checked"); %> onClick=chk_http(this.form)><SPAN class=RADIO><script>Capture(filter.HTTP);</script></SPAN><INPUT type=checkbox value=1 name=_https_enable id=_https_enable <% nvram_match("https_enable","1","checked"); %> onClick=chk_http(this.form)><SPAN class=RADIO><script>Capture(filter.HTTPS);</script></SPAN>
		<SPAN id=msg_http></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.remotemang));</script>
		<input type=checkbox name=_remote_management <% nvram_match("remote_management","1","checked"); %> onClick=SelRmt(this.form)><script>Capture(share.enable)</script></TD></TR>
		<input type=hidden name=remote_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.remoteacc));</script>
		<INPUT type=radio value=0 id=remote_mgt_https_0 name=remote_mgt_https <% nvram_match("remote_mgt_https","0","checked"); %>><script>Capture(filter.HTTP);</script></B><SPAN class=RADIO><INPUT type=radio value=1 id=remote_mgt_https_1 name=remote_mgt_https <% nvram_match("remote_mgt_https","1","checked"); %>><script>Capture(filter.HTTPS);</script></SPAN>
		<SPAN id=msg_rhttp></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.remoteupgrade));</script>
		<input type=checkbox name=_remote_upgrade <% nvram_match("remote_upgrade","1","checked"); %>><script>Capture(share.enable)</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(filter.allremoteip));</script>
		<INPUT type=radio value=1 name=remote_ip_any <% nvram_match("remote_ip_any","1","checked"); %> OnClick=SelIP(0,this.form)><script>Capture(filter.anyipaddr)</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"");</script>
            <INPUT type=radio value=0 name=remote_ip_any <% nvram_invmatch("remote_ip_any","1","checked"); %> OnClick=SelIP(1,this.form)>
            <INPUT class=num maxLength=3 onBlur=msg_chk_range(this.value,"remote_ip_0",1,223,10,IS_FIELD,0,"_anyip") size=3 value='<% get_single_ip("remote_ip","0"); %>' name="remote_ip_0" id="remote_ip_0"> .
            <INPUT class=num maxLength=3 onBlur=msg_chk_range(this.value,"remote_ip_1",0,255,10,IS_FIELD,0,"_anyip") size=3 value='<% get_single_ip("remote_ip","1"); %>' name="remote_ip_1" id="remote_ip_1"> .
            <INPUT class=num maxLength=3 onBlur=msg_chk_range(this.value,"remote_ip_2",0,255,10,IS_FIELD,0,"_anyip") size=3 value='<% get_single_ip("remote_ip","2"); %>' name="remote_ip_2" id="remote_ip_2"> .
            <INPUT class=num maxLength=3 onBlur=msg_chk_range(this.value,"remote_ip_3",0,255,10,IS_FIELD,0,"_anyip") size=3 value='<% get_single_ip("remote_ip","3"); %>' name="remote_ip_3" id="remote_ip_3">&nbsp;-&nbsp;
	    <INPUT class=num maxLength=3 onBlur=msg_chk_range(this.value,"remote_ip_4",0,255,10,IS_FIELD,0,"_anyip") size=3 value='<% nvram_list("remote_ip", "1"); %>' name="remote_ip_4" id="remote_ip_4">
	    <span id=_anyip></span>
          </TD>
        </TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(filter.remotemanport));</script>
		<INPUT class=num maxLength=5 size=5 value='<% nvram_get("http_wanport"); %>' onblur='msg_chk_range(this.value,"http_wanport",PORT_START,PORT_TO,10,IS_FIELD,0,"_wanport")' name="http_wanport", id=http_wanport>
		<script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"1","65535","443"));</script>
		<span id=_wanport></span>
		</TD></TR>
		<input type=hidden name=remote_end>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.multicastpt));</script>
		<input type=checkbox name=_multicast_pass <% nvram_match("multicast_pass","1","checked"); %> ><script>Capture(share.enable);</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.ipv4leave));
		var disflg = "";
		var lan_mode = "<% nvram_get("lan_ip_mode"); %>";
		if ( lan_mode == "1" ) disflg = "disabled";
		document.write("<input type=checkbox name=_immediate_leave_enable <% nvram_match("immediate_leave_enable","1","checked"); %> "+disflg+">"+__T(share.enable));</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.sipalg));
		document.write("<input type=checkbox name=_sip_alg_enable <% nvram_match("sip_alg_enable","1","checked"); %> >"+__T(share.enable));</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.upnp));</script>
		<input type=checkbox name=_upnp_enable <% nvram_match("upnp_enable","1","checked"); %> onclick=SelUPNP(this.form)><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.allowuserconfig));</script>
		<input type=checkbox name=_upnp_config <% nvram_match("upnp_config","1","checked"); %>><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(filter.allowusertodis));</script>
		<input type=checkbox name=_upnp_internet_dis <% nvram_match("upnp_internet_dis","1","checked"); %> ><script>Capture(share.enable);</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<script>
		var tmp = "";
		var opt = new Array('java','cookie','activex','proxy');
		var hint = new Array("_java","_cookie","_activex","_proxy");
		var title_name = new Array(__TC(filter.blockjava),__TC(filter.blockcookies),__TC(filter.blockactivex),__TC(filter.acctoproxy));
		var chk_name = new Array("_block_java","_block_cookie","_block_activex","_block_proxy");
		var sel_name = new Array("block_java_manual","block_cookie_manual","block_activex_manual","block_proxy_manual");
		var txt_name = new Array("block_java_port","block_cookie_port","block_activex_port","block_proxy_port");
		var nv_chk_val = new Array("<% nvram_get("block_java"); %>","<% nvram_get("block_cookie"); %>","<% nvram_get("block_activex"); %>","<% nvram_get("block_proxy"); %>");
		var nv_sel_val = new Array("<% nvram_get("block_java_manual"); %>","<% nvram_get("block_cookie_manual"); %>","<% nvram_get("block_activex_manual"); %>","<% nvram_get("block_proxy_manual"); %>");
		var nv_txt_val = new Array("<% nvram_get("block_java_port"); %>","<% nvram_get("block_cookie_port"); %>","<% nvram_get("block_activex_port"); %>","<% nvram_get("block_proxy_port"); %>");
		for(var i=0; i<title_name.length; i++)
		{
			document.write("<TR>");
			if ( i == title_name.length -1 ) 
				draw_td(O_GUI,SUBTITLE_NOSHIFT,title_name[i],"style=padding-left:10px;padding-bottom:10px",SPACE_DOWN);
			else
				draw_td(O_GUI,SUBTITLE_NOSHIFT,title_name[i],"style=padding-left:10px;");
				
			tmp = "";
			if ( nv_chk_val[i] == "1" ) tmp = "checked";
			document.write("<input type=checkbox name="+chk_name[i]+" onclick=chk_checked('"+opt[i]+"') "+tmp+">");
			var _val = new Array("0","1");
			var _name = new Array(__T(share.auto),__T(share.manual));
			var nv_val = nv_sel_val[i];
			if ( nv_val == "" ) nv_val = "0";
			draw_object(O_GUI,RADIO,sel_name[i],_val,_name,nv_val,"onclick=chg_auto_manual('"+opt[i]+"');");
			document.write("&nbsp;&nbsp;"+__T(share.port)+": <input maxlength=5 size=10 id="+txt_name[i]+" name="+txt_name[i]+" onblur='msg_chk_range(this.value,\""+txt_name[i]+"\",PORT_START,PORT_TO,10,IS_FIELD,0,\""+hint[i]+"\")' value="+nv_txt_val[i]+"><span id="+hint[i]+"></span>");
			document.write("<TD></TR>");
		}
		</script>
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
