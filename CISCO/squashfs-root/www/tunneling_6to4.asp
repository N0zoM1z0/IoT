<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var nv_6to4_mode = "<% nvram_get("ipv6_6to4_mode"); %>";
var nv_wan_proto = "<% nvram_get("wan_ipv6_proto"); %>";
var nv_6to4en = "<% nvram_get("lan_ipv6_6to4en"); %>";
var nv_64_autoen = "<% nvram_get("ipv6_6to4_autoen"); %>";
var nv_64_remoteip = "<% nvram_get("ipv6_6to4_remoteip"); %>";
var nv_6rd_mode = "<% nvram_get("ipv6_6rd_mode"); %>";
var nv_4to6en = "<% nvram_get("ipv6_4to6en"); %>";
var nv_46_localip = "<% nvram_get("ipv6_4to6_localip"); %>";
var nv_46_remoteip = "<% nvram_get("ipv6_4to6_remoteip"); %>";
var nv_lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>";
var nv_wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>";
//var nv_46_prefixlen = "<% nvram_get("ipv6_4to6_prefixlen"); %>";
var EN_6TO4=0;
var EN_4TO6=0;
function init(){
	var F = document.setup;
	parent.document.getElementById("save_bg").style.display="none";
	init_tunnel(F);
	F.ipv6_6to4_autoen.value=nv_64_autoen;
	F.ipv6_6to4_remoteip.value=nv_64_remoteip;
	default_nv = keep_val(F,"");
}

function valid_domain(obj_id,span_id)
{
	var F = document.setup;
	var errmsg="";
	clear_msg(obj_id,span_id);
	if ( !check_ip_domain(document.getElementById(obj_id).value) ) 
	{
		my_alert(O_VAR,obj_id,__T(msg.validname),"0",span_id);
		return false;
	}
	return true;
}

function chk_6to4(F)
{
	var errflg = 0 ;
	if ( F._lan_ipv6_6to4en.checked == false ) return true;
	if ( !msg_chk_range(F.ipv6_6rd_prefix_len.value,"ipv6_6rd_prefix_len",1,64,10,IS_FIELD,0,"msg_6rd_prefixlen") ) errflg++;
	if ( !msg_chk_range(F.ipv6_6rd_v4mask_len.value,"ipv6_6rd_v4mask_len",IPV6_V4MASK_LEN_START,IPV6_V4MASK_LEN_TO,10,IS_FIELD,0,"msg_v4masklen") ) errflg++;
	if ( !chk_ipv6_format(F,"ipv6_6rd_prefix","msg_6rd_prefix")) errflg++;
	if ( !valid_domain("ipv6_6rd_relay","msg_6rd_relay")) errflg++;
	if ( errflg > 0 ) return false;
	return true;
	
}

function chk_4to6(F)
{
	var errflg = 0 ;
	if ( !chk_ipv6_format(F,"ipv6_4to6_localip","msg_4to6_lip")) errflg++;
	if ( !chk_ipv6_format(F,"ipv6_4to6_remoteip","msg_4to6_rip")) errflg++;
	if ( errflg > 0 ) return false;
	return true;
	
}
function update_val(F)
{
	var tmp_ip="";
	document.getElementById("msg_ip").innerHTML = "";
	if ( !my_valid_m_value("IP",F,"ip","",VALID_IP_RULE7,ZERO_NO,"msg_ip")) 
	{
		return false;
	}
	for(var i=0; i<4; i++)
	{
		if ( tmp_ip != "" ) 
			tmp_ip +=".";
		if ( eval("F.ip_"+i).value == "" ) 
			tmp_ip += "0";
		else
			tmp_ip += eval("F.ip_"+i).value;
	}

	F.ipv6_6to4_remoteip.value=tmp_ip;
	return true;
}

function uiDoSave(F){
	/*6to4 Setting*/
	if ( EN_6TO4 ) 
	{
		if(F._lan_ipv6_6to4en.checked == true)
		{
			F.lan_ipv6_6to4en.value="1";
			if(F._ipv6_6to4_autoen.checked)
				F.ipv6_6to4_autoen.value="1";
			else 
			{
				F.ipv6_6to4_autoen.value="0";
				if(!update_val(F))
					return;
			}
		}
		else 
			F.lan_ipv6_6to4en.value="0";
		if( F._64tunnel_modes[0].selected ) 
		{
			F.ipv6_6to4_mode.value="6to4";
			//F.submit_type.value = "6to4";
		}		
		else if( F._64tunnel_modes[1].selected )  /*seleted 6rd*/
		{
			F.ipv6_6to4_mode.value="6rd";
			//F.submit_type.value = "6rd";
			if( F._6rd_modes[0].checked==true )
				F.ipv6_6rd_mode.value="0";
			else /*6rd manual mode*/
			{
				if ( !chk_6to4(F) ) return;
				if ( !valid_ipv6_prefix(F.ipv6_6rd_prefix.value,F.ipv6_6rd_prefix_len.value) ) 
				{
					my_alert(O_VAR,"ipv6_6rd_prefix",__T(msg.validprefix),0,"msg_6rd_prefix");
					return;	
				}
				if ( (32-parseInt(F.ipv6_6rd_v4mask_len.value,10))+parseInt(F.ipv6_6rd_prefix_len.value,10) > 64 ) 
				{
			                my_alert(O_VAR,"ipv6_6rd_v4mask_len",__T(ipv6.tunnelmsg),"0","msg_v4masklen");
			                my_alert(O_VAR,"ipv6_6rd_prefix_len",__T(ipv6.tunnelmsg),"0","msg_6rd_prefixlen");
					return;	
				}
				F.ipv6_6rd_mode.value="1";
				F.ipv6_6rd_prefix.value = full_ipv6(F.ipv6_6rd_prefix.value);
			}
		}else{
			F.ipv6_6to4_mode.value="isatap";
			if ( !valid_ipv6_prefix(F.ipv6_isatap_prefix.value,F.ipv6_isatap_prefix_len.value) ) 
			{
				my_alert(O_VAR,"ipv6_isatap_prefix",__T(msg.validprefix),0,"msg_6rd_prefixo");
				return;	
			}

		}
	}else //_ipv6_4to6en
		F.lan_ipv6_6to4en.value="0";

	/*4to6 Setting*/
	if ( EN_4TO6 ) 
	{
		if ( !chk_4to6(F) ) return;
		//F.submit_type.value = "4to6";
		if(F._ipv6_4to6en.checked == true)
		{
			F.ipv6_4to6en.value="1";
		}
		else {
			F.ipv6_4to6en.value="0";
		}
	}
	F.submit_type.value = "tunnelv6";
	F.submit_button.value = "tunneling_6to4";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";

}

function init_tunnel(F)
{
	DISABLE_PART(F,"_64tunnel_start","_64tunnel_end", 1);
	DISABLE_PART(F,"_46_start","_46_end", 1);
	//6 to 4 Tunneling is for IP Mode:[LAN:IPv6,WAN:IPv4] and [LAN:IPv4+IPv6,WAN:IPv4]
	if ( (nv_lan_ip_mode == "2" && nv_wan_ip_mode == "1") || 
	     (nv_lan_ip_mode == "3" && nv_wan_ip_mode == "1") )
	{
		EN_6TO4=1;
		choose_enable(F._lan_ipv6_6to4en);
		chg_64_en(F);
	} //4 to 6 Tunneling is only for IP Mode: [LAN:IPv4,WAN:IPv6]
	else if ( nv_lan_ip_mode == "1" && nv_wan_ip_mode == "2" )
	{
		EN_4TO6=1;
		choose_enable(F._ipv6_4to6en);
		change_46_en(F);
	}
	
}

function chg_64_en(F)
{
	if ( F._lan_ipv6_6to4en.checked ) 
	{
		choose_enable(F._64tunnel_modes);
		change64(F);
	}else{
		choose_disable(F._64tunnel_modes);
		choose_disable(F._6rd_modes[0]);
                choose_disable(F._6rd_modes[1]);
                DISABLE_PART(F,"_6rd_start","_64tunnel_end",1);
	}
}

function change64(F) {
        if( F._64tunnel_modes[0].selected ) {
                choose_disable(F._6rd_modes[0]);
                choose_disable(F._6rd_modes[1]);
                DISABLE_PART(F,"_6rd_start","_64tunnel_end",1);
		DISABLE_PART(F, "_6to4_start","_6to4_end", 0);
		DISABLE_PART(F, "_isatap_start","_isatap_end", 1);
		change64_autoen(F);
        }               
        else if( F._64tunnel_modes[1].selected ) {
                choose_enable(F._6rd_modes[0]);
                choose_enable(F._6rd_modes[1]);
		DISABLE_PART(F, "_6to4_start","_6to4_end", 1);
		DISABLE_PART(F, "_isatap_start","_isatap_end", 1);
                change6rd(F);
        }else{
                choose_disable(F._6rd_modes[0]);
                choose_disable(F._6rd_modes[1]);
                DISABLE_PART(F,"_6rd_start","_64tunnel_end",1);
		DISABLE_PART(F, "_6to4_start","_6to4_end", 1);
		DISABLE_PART(F, "_isatap_start","_isatap_end", 0);
	}
}  

function change64_autoen(F) {
	var nvip = "<% nvram_get("ipv6_6to4_remoteip"); %>".split(".");
	if(F._ipv6_6to4_autoen.checked) {
		DISABLE_PART(F, "_6to4_remote","_6to4_end", 1);
		F.ip_0.value = "192";
		F.ip_1.value = "88";
		F.ip_2.value = "99";
		F.ip_3.value = "1";
	}
	else
	{
		DISABLE_PART(F, "_6to4_remote","_6to4_end", 0);
		if ( nvip.length == 4 ) 
		{
			F.ip_0.value = nvip[0];
	                F.ip_1.value = nvip[1];
        	        F.ip_2.value = nvip[2];
                	F.ip_3.value = nvip[3];
		}
	}
}

function change_46_en(F)
{
	if ( F._ipv6_4to6en.checked == true ) 
	{
		choose_enable(F.ipv6_4to6_localip);
		choose_enable(F.ipv6_4to6_remoteip);
	}else{
		choose_disable(F.ipv6_4to6_localip);
		choose_disable(F.ipv6_4to6_remoteip);
	}
}

function change6rd(F){
	
	if( F._6rd_modes[0].checked ) {
		DISABLE_PART(F,"_6rd_start","_isatap_start",1);
	}
	else {
		DISABLE_PART(F,"_6rd_start","_isatap_start",0);
	}
}

function chk_ipv6_format(F,obj,span_id)
{
	clear_msg(obj,span_id);
	var errmsg = "";
	errmsg =  valid_ipv6(eval("F."+obj).value);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,obj,errmsg,0,span_id);	
		return false;
	}
	return true;
	
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=lan_ipv6_6to4en>
<input type=hidden name=ipv6_6to4_autoen>
<input type=hidden name=ipv6_6to4_remoteip>
<input type=hidden name=ipv6_6to4_mode>	<!--6to4, 6rd-->
<input type=hidden name=ipv6_6rd_mode value="<% nvram_get("ipv6_6rd_mode"); %>"> <!--0(auto), 1(manual)-->
<!--input type=hidden name=ipv6_6rd_prefix> 
<input type=hidden name=ipv6_6rd_prefix_len> 
<input type=hidden name=ipv6_6rd_relay> 
<input type=hidden name=ipv6_6rd_v4mask_len--> 

<input type=hidden name=ipv6_4to6en value="<% nvram_get("ipv6_4to6en"); %>">

<input type=hidden name=ipv6_4to6_remoteip-->
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(ipv6.tunneling),"colspan=2");</script></TR>
  <TR><TD colspan=2>
	<TABLE class=CONTENT_GROUP cellspacing=0>
		<input type=hidden name=_64tunnel_start>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.tunnel6to4),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.tunnel6to4));</script>
		<input type=checkbox id=_lan_ipv6_6to4en name=_lan_ipv6_6to4en <% nvram_match("lan_ipv6_6to4en","1","checked"); %> onClick=chg_64_en(this.form)><script>Capture(share.enable)</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"");</script>
		<script>
		var _name=new Array(__T(router.type6to4),__T(ipv6.tunnel6rd2),__T(ipv6.isatap));
		var _val=new Array("16to4","6rd","isatap");
		draw_object(O_GUI,SELBOX,"_64tunnel_modes","onclick=change64(this.form)",_name,_val,"<% nvram_get("ipv6_6to4_mode"); %>","onclick=change64(this.form)");
		</script>
		</TD></TR>

		<!--6to4 start-->
		<input type=hidden name=_6to4_start>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.autotunnel));</script>
		<input type=checkbox id=_ipv6_6to4_autoen name=_ipv6_6to4_autoen <% nvram_match("ipv6_6to4_autoen","1","checked"); %> onClick=change64_autoen(this.form)><script>Capture(share.enable)</script></TD></TR>
		<input type=hidden name=_6to4_remote>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.tunnel64_remote_ip));</script>
		<script>draw_object(O_GUI,IP,"ip","<% nvram_get("ipv6_6to4_remoteip"); %>");</script>
		<SPAN id=msg_ip></SPAN>
		</TD></TR>
		<input type=hidden name=_6to4_end>
		<!--6to4 end-->

		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.tunnel6rd));</script>
		<script>
		var _name=new Array(__T(share.auto),__T(share.manual));
		var _val=new Array("0","1");
		draw_object(O_GUI,RADIO,"_6rd_modes",_val,_name,"<% nvram_get("ipv6_6rd_mode"); %>","onclick=change6rd(this.form)");
		</script>
		</TD></TR>
			<!-- 6rd info manual-->
			<input type=hidden name=_6rd_start>
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefix));</script>
			<input size=51 maxlength=39 id=ipv6_6rd_prefix name=ipv6_6rd_prefix value="<% nvram_get("ipv6_6rd_prefix"); %>" onblur=chk_ipv6_format(this.form,"ipv6_6rd_prefix","msg_6rd_prefix")>
			<SPAN id=msg_6rd_prefix></SPAN>
			</TD></TR> 
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefixlen));</script>
			<input size=10 maxlength=2 id=ipv6_6rd_prefix_len name=ipv6_6rd_prefix_len value="<% nvram_get("ipv6_6rd_prefix_len"); %>" onblur=msg_chk_range(this.value,"ipv6_6rd_prefix_len",1,64,10,IS_FIELD,0,"msg_6rd_prefixlen")> <script>document.write(spell_words(range_rule2,"1","64"));</script>
			<SPAN id=msg_6rd_prefixlen></SPAN>
			</TD>
			</TR> 
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.tunnel6rd_br));</script>
			<input size=30 id=ipv6_6rd_relay name=ipv6_6rd_relay value="<% nvram_get("ipv6_6rd_relay"); %>" onblur=valid_domain("ipv6_6rd_relay","msg_6rd_relay")>
			<SPAN id="msg_6rd_relay"></SPAN>
			</TD></TR> 
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.tunnel6rd_v4masklen));</script>
			<input size=30 maxlenght=2 id=ipv6_6rd_v4mask_len name=ipv6_6rd_v4mask_len value="<% nvram_get("ipv6_6rd_v4mask_len"); %>" onblur=msg_chk_range(this.value,"ipv6_6rd_v4mask_len",IPV6_V4MASK_LEN_START,IPV6_V4MASK_LEN_TO,10,IS_FIELD,0,"msg_v4masklen")> <script>document.write(spell_words(range_rule2,IPV6_V4MASK_LEN_START,IPV6_V4MASK_LEN_TO));</script>
			<SPAN id=msg_v4masklen></SPAN>
			</TD></TR> 
		<input type=hidden name=_64tunnel_end> <!-- 6to4 tunnel mode end-->	
			<input type=hidden name=_isatap_start> <!-- ISATAP tunnel mode end-->	
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.isataptunnel));</script>
			</TD></TR>
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefix));</script>
			<input size=51 maxlength=39 id=ipv6_isatap_prefix name=ipv6_isatap_prefix value="<% nvram_get("ipv6_isatap_prefix"); %>" onblur=chk_ipv6_format(this.form,"ipv6_isatap_prefix","msg_isatap_prefix")>
			<SPAN id=msg_isatap_prefix></SPAN>
			</TD></TR> 
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.prefixlen));</script>
			<input size=10 maxlength=2 id=ipv6_isatap_prefix_len name=ipv6_isatap_prefix_len value="<% nvram_get("ipv6_isatap_prefix_len"); %>" onblur=msg_chk_range(this.value,"ipv6_isatap_prefix_len",1,64,10,IS_FIELD,0,"msg_isatap_prefixlen")> <script>document.write(spell_words(range_rule2,"1","64"));</script>
			<SPAN id=msg_6rd_prefixlen></SPAN>
			</TD>
			<input type=hidden name=_isatap_end> <!-- ISATAP tunnel mode end-->	
			<input type=hidden name=_64tunnel_end> <!-- 6to4 tunnel mode end-->	
			<!--6rd info manual end-->
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(ipv6.tunnel46),"colspan=2");</script></TR>
		<input type=hidden name=_46_start> <!-- 6to4 tunnel mode end-->	
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(ipv6.tunnel46));</script> <!-- 4to6 start -->
			<input id=chb_4to6 type=checkbox name=_ipv6_4to6en 
				<% nvram_match("ipv6_4to6en","1","checked");%> onClick=change_46_en(this.form)> 
			<script>Capture(share.enable);</script>
		</TD></TR> <!-- 4to6 end --> 
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.tunnel46_localip));</script><!--4to6 localip start-->
			<script>
			document.write("<input size=51 id=ipv6_4to6_localip name=ipv6_4to6_localip value='"+full_ipv6("<% nvram_get("ipv6_4to6_localip"); %>")+"' onblur=chk_ipv6_format(this.form,\"ipv6_4to6_localip\",\"msg_4to6_lip\")>");
			</script>
			<SPAN id=msg_4to6_lip></SPAN>
			</TD></TR> <!--4to6 localip end -->
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.tunnel46_remoteip),SPACE_DOWN,SPACE_DOWN);</script><!--4to6 remoteip start-->
			<script>
			document.write("<input size=51 id=ipv6_4to6_remoteip name=ipv6_4to6_remoteip value='"+full_ipv6("<% nvram_get("ipv6_4to6_remoteip"); %>")+"' onblur=chk_ipv6_format(this.form,\"ipv6_4to6_remoteip\",\"msg_4to6_rip\")>");
			</script>
			<SPAN id=msg_4to6_rip></SPAN>
			</TD></TR> <!--4to6 remoteip end -->
			<!-- TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.prefixlen)+":");</script>
			<input size=10 maxlength=3 id=_46_prefixlen name=_46_prefixlen>
			</TD></TR--> <!--4to6 prefix len end -->
		<input type=hidden name=_46_end> <!-- 6to4 tunnel mode end-->	



        </TABLE>
		<% web_include_file("BT.asp"); %>
	</TD>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
