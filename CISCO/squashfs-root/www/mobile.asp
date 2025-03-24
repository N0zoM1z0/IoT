<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function MWORD(xname,xvalue)
{
        this.name = xname;
        this.value = xvalue;
}
var mobile_msg = new Array();
mobile_msg[0] = new MWORD("add", __T(share.add));
mobile_msg[1] = new MWORD("Initializing", __T(wwan.initing));
mobile_msg[2] = new MWORD("PIN code error", __T(wwan.pinerr));
mobile_msg[3] = new MWORD("SIM locked", __T(wwan.simlocked));
mobile_msg[4] = new MWORD("SIM ready", __T(wwan.simready));
mobile_msg[5] = new MWORD("SIM busy", __T(wwan.simbusy));
mobile_msg[6] = new MWORD("PIN code needed", __T(wwan.pinneed));
mobile_msg[7] = new MWORD("no SIM card", __T(wwan.nosim));
mobile_msg[8] = new MWORD("Card is locked", __T(wwan.cardlock));
mobile_msg[9] = new MWORD("Error", __T(share.errors));
mobile_msg[10] = new MWORD("Unknown",__T(wwan.unknown)); 
mobile_msg[11] = new MWORD("Searching for service...",__T(wwan.searchservice));
mobile_msg[12] = new MWORD("Connecting", __T(wwan.connecting)); 
mobile_msg[13] = new MWORD("Connected", __T(share.connected)); 
mobile_msg[14] = new MWORD("Disconnecting", __T(wwan.disconnecting));
mobile_msg[15] = new MWORD("Disconnected", __T(share.disconnected));
mobile_msg[16] = new MWORD("Deinitializing",__T(wwan.deiniting));
mobile_msg[17] = new MWORD("Deinitialized", __T(wwan.deinited));
CHK_VALUE_AUTO=0;
function manual_get_data(F)
{
	var objval="";
	var obj_name = new Array(
	"_wwan_connect_mode","wwan_idletime","_wwan_demand","_wwan_config_mode",
        "wwan_apnname","wwan_dialnum","wwan_username","wwan_passwd",
        "wwan_pincode","wwan_server_name","wwan_auth","wwan_service","wwan_simcheck","wwan_lte_type",
        "wwan_cap_enabled","wwan_cap_day","wwan_cap_bw","wwan_mail_percentage",
        "wwan_cap_percentage","_wwan_mail_cf","_wwan_mail_period","wwan_mail_interval");
	for(var i=0; i<obj_name.length; i++)
	{
		if ( objval != "" ) objval +=",";
		if ( eval("F."+obj_name[i]).type == "checkbox" )
                {
                        if ( eval("F."+obj_name[i]).checked == true ) objval+="1";
                        else objval+="0";
		}else if (typeof eval("F."+obj_name[i])[0] != "undefined" &&
                          eval("F."+obj_name[i])[0].type == "radio" )
                {
			
			for(var j=0; j<eval("F."+obj_name[i]).length; j++)
			{
	                        if ( eval("F."+obj_name[i])[j].checked == true )
				{
                         	       objval+=eval("F."+obj_name[i])[j].value;
				       break;
				}
			}
                }else
                        objval+=eval("F."+obj_name[i]).value;
	}
	return objval;
	
}
function get_data(F)
{
	var data = manual_get_data(F);
	return data;
}

var timerID=null;

function transmsg(old)
{
	var lockcmd="";
	if ( old.indexOf("Locked to") != -1 ) 
	{
		lockcmd = old.substring(10, old.length);
		return spell_words(mobile_lockto,lockcmd);
	}
	for(var i=0; i<mobile_msg.length; i++)
	{
		if ( old == mobile_msg[i].name ) 
		{
			return mobile_msg[i].value;
		}	
	}
	return old;	
}

function chg_connmode(F)
{
	sel_demand(1);
	if ( F._wwan_connect_mode[0].checked ) 
	{
		choose_enable(F._wwan_demand[0]);
		choose_enable(F._wwan_demand[1]);
		if ( F._wwan_demand[0].checked ) sel_demand(0);
	}else{
		choose_disable(F._wwan_demand[0]);
		choose_disable(F._wwan_demand[1]);
	}
}

function sel_demand(val)
{
	if ( val == 0 ) 
		choose_enable(document.getElementById("wwan_idletime"));
	else
		choose_disable(document.getElementById("wwan_idletime"));
}
var nv_cap_day = "<% nvram_get("wwan_cap_day"); %>";
function sel_cap(F) {
	var log_enable="<% nvram_get("log_enable");%>";	
	var log_email_enable="<% nvram_get("log_email_enable");%>";	
	if((log_enable == "1") && (log_email_enable == "on"))
	{
		DISABLE_PART(F, "email_start","email_end",0);
		if ( F.wwan_cap_enabled[0].checked == true ) 
			DISABLE_PART(F, "selcap_start","email_start",0);
		else
			DISABLE_PART(F, "selcap_start","email_start",1);
		
	}else{
		DISABLE_PART(F, "selcap_start","email_end",1);
		if ( F.wwan_cap_enabled[0].checked == true ) 
			DISABLE_PART(F, "selcap_start","selcap_end",0);
		
	}
}
var get_wwan_connect_mode = "<% nvram_get("wwan_connect_mode"); %>";
var wwan_demand = "<% nvram_get("wwan_demand"); %>";
var get_wwan_config_mode = "<% nvram_get("wwan_config_mode"); %>";
var _wwan_auth = "<% nvram_get("wwan_auth"); %>";
var nv_wwan_service = "<% nvram_get("wwan_service"); %>";
var nv_wwan_lte_type = "<% nvram_get("wwan_lte_type"); %>";
if ( get_wwan_connect_mode == "" ) wwan_connect_mode = "0";
if ( wwan_demand == "" ) wwan_demand = "1";
if ( get_wwan_config_mode == "" ) get_wwan_config_mode = "1";
if ( _wwan_auth == "" ) _wwan_auth = "auto";
if ( nv_wwan_service == "" ) nv_wwan_service = "umtspre";
if ( nv_wwan_lte_type == "" ) nv_wwan_lte_type = "auto";

function KEEP_PART(F,start,end)
{
        var i,starti,endi;
        var len = F.elements.length;
	var objval="";
	//alert("PART element length="+len);
        for(i=0; i<len; i++)
        {
                if(F.elements[i].name==start) starti=i;
                if(F.elements[i].name==end) endi=i;
        }
        if(starti == '' || endi == '')return true;
        for(i=starti; i<=endi; i++)
	{
		if ( objval != "" ) objval +=",";
		if ( F.elements[i].type == "checkbox" )
		{
			if ( F.elements[i].checked ) objval+="1";
			else objval+="0";
		}else if ( F.elements[i].type == "radio" )
		{
			if ( F.elements[i].checked == true )
				objval+=F.elements[i].value;
		}else
			objval+=F.elements[i].value;
	}
	return objval;
		
}
var keep_part_nv="";

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmwan;
	chg_connmode(F);
	chg_configmode(F);
	/*capacity selection +++*/
	sel_cap(F);
	/*capacity selection ---*/
	regetstatus();
	//makexmlrequest();
	//default_nv = keep_val(F,skip_name);
	default_nv = manual_get_data(F);
	keep_part_nv = KEEP_PART(F,"mode_end","email_end");
}

function chg_configmode(F)
{
	if ( F._wwan_config_mode[0].checked ) 
	{
		DISABLE_PART(F, "mode_start","mode_end", 1);			
		choose_enable(F.wwan_simcheck[0]);
		choose_enable(F.wwan_simcheck[1]);
		choose_enable(F.wwan_pincode);
		choose_enable(F.wwan_lte_type);
	}
	else
		DISABLE_PART(F, "mode_start","mode_end", 0);			
}

function uiDoSave(F)
{
	if ( F._wwan_connect_mode[0].checked ) F.wwan_connect_mode.value = 0;
	else F.wwan_connect_mode.value = 1;
	if ( F._wwan_demand[0].checked ) F.wwan_demand.value = 1;
	else F.wwan_demand.value = 0 ;
	if ( F._wwan_config_mode[0].checked ) F.wwan_config_mode.value = 1;
	else F.wwan_config_mode.value = 0;
	if ( F.wwan_cap_enabled[0].checked == true ) 
	{
		 if ( !_check_range(F.wwan_cap_bw.value,WWAN_CAP_BW_START,WWAN_CAP_BW_TO,"msg_wwan_cap_bw","wwan_cap_bw") ) 
			return;
	}
	if ( F._wwan_mail_percentage.checked ) 
		F.wwan_mail_percentage.value = 1;
	else
		F.wwan_mail_percentage.value = 0;

	if ( F._wwan_mail_cf.checked ) 
		F.wwan_mail_cf.value = 1;
	else
		F.wwan_mail_cf.value = 0;

	if ( F._wwan_mail_period.checked ) 
	{
		F.wwan_mail_period.value = 1;
	}
	else
		F.wwan_mail_period.value = 0;
	
	var save_keep_part_nv = KEEP_PART(F,"mode_end","email_end");
	if ( save_keep_part_nv != keep_part_nv ) 
	{
		F.submit_button.value = "mobile_chg";
		F.wait_time.value=3;
	}
	else
		F.submit_button.value = "mobile";
	F.gui_action.value = "Apply";
	clearTimeout(timerID);
	F.next_page.value = "mobile";
	F.submit();	
	parent.document.getElementById("save_bg").style.display="";
}
function alertContents()
{
	var get_cardmodel= document.getElementById("cardmodel").value;
        var tmp_cardst= document.getElementById("cardst").value;
        var get_cardst = transmsg(tmp_cardst);
        get_cardst += "&nbsp;&nbsp;";
        if ( (get_cardst.indexOf("Connected") != -1) && (get_wwan_connect_mode == "1") ) 
        	get_cardst += draw_object(O_VAR,BT,__T(share.disconnect),"s1","BT","send_act(\"disconnect\")");
        else if ( (get_cardst.indexOf("Disconnected") != -1) && (get_wwan_connect_mode == "1")) 
                get_cardst += draw_object(O_VAR,BT,__T(share.connect),"s1","BT","send_act(\"connect\")");
        document.getElementById("span_cardst").innerHTML = get_cardst;
        document.getElementById("span_cardmodel").innerHTML = get_cardmodel;
}

function regetstatus()
{
        var close_session = '<% get_session_status(); %>';
        //alert("regetstatus;close_session="+close_session);
        if ( close_session == "1" ) 
                frames['iframe1'].location.href = "<% get_http_prefix(""); %>get_card_info.asp" ; //always refresh iframe code
        else{
                frames['iframe1'].location.href = "<% get_http_prefix(""); %>"+goto_link("get_card_info.asp");//always refresh iframe code
                
        }       
	alertContents();
        timerID = setTimeout('regetstatus()', 3000);              
}

function send_act(act)
{
	var F = document.frmwan;
	clearTimeout(timerID);
	F.submit_button.value = "mobile";
	F.submit_type.value = "chg_action";
	F.change_action.value="gozila_cgi";
	F.chg_card_st.value = act;
	F.next_page.value = "mobile.asp";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function _check_range(obj_val,start,to,span_id,obj_id)
{
	clear_msg(obj_id,span_id);
	if ( obj_val == "" ) 
	{
		parent.document.getElementById("obj_id").value = span_id;
		my_alert(O_VAR,obj_id,__T(msg.notblank),"0",span_id);
		return false;
		
	}
	if ( chk_range(obj_id,obj_val,start,to) == FAIL ) 
	{
		parent.document.getElementById("obj_id").value = span_id;
		my_alert(O_VAR,obj_id,spell_words(range_rule2,start,to),"0",span_id);
		return false;
	}
	return true;
}

function chg_simcheck(F)
{
	if ( F.wwan_simcheck[0].checked == true ) 
	{
		choose_enable(F.wwan_pincode);
	}
	else
		choose_disable(F.wwan_pincode);
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmwan method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=submit_type>
<input type=hidden name=wwan_connect_mode>
<input type=hidden name=wwan_demand>
<input type=hidden name=wwan_config_mode>
<input type=hidden name=chg_card_st>
<input type=hidden name=next_page value="mobile">
<input type=hidden id=cardst name=cardst>
<input type=hidden id=cardmodel name=cardmodel>
<input type=hidden name=wait_time value=15>
<input type=hidden name=wwan_mail_percentage value="<%nvram_get("wwan_mail_percentage");%>">
<input type=hidden name=wwan_mail_cf value="<%nvram_get("wwan_mail_cf");%>">
<input type=hidden name=wwan_mail_period value="<%nvram_get("wwan_mail_period");%>">
<iframe id=statuspage height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wwan.mobilenet),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wwan.globalsetting),"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.connectmode));</script>
		<script>
		var _name = new Array(__T(share.auto),__T(share.manual));
		var _val = new Array("0","1");
		draw_object(O_GUI,RADIO,"_wwan_connect_mode",_val,_name,get_wwan_connect_mode," onclick='chg_connmode(this.form)'");</script>
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
		var selflg = "";
		if ( wwan_demand == "1" ) selflg = "checked";
		document.write("<input type=radio "+selflg+" name=_wwan_demand value=1 onclick=sel_demand(0)>"+spell_words(connect_on_demand_rule,"<input id=wwan_idletime size=5 maxlength=4 name=wwan_idletime value='<% nvram_get("wwan_idletime"); %>'>")+" &nbsp;&nbsp; "+spell_words(range_def_rule,"1","9999","5"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
		var selflg = "";
		if ( wwan_demand == "0" ) selflg = "checked";
		document.write("<input type=radio "+selflg+" name=_wwan_demand value=0 onclick=sel_demand(1)>"+__T(wwan.keepalive));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.cardst));</script>
		<SPAN id=span_cardst></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wwan.setmobilenet),"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.configmode),"","");
		var _name = new Array(__T(share.auto),__T(share.manual));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"_wwan_config_mode",_val,_name,get_wwan_config_mode," onclick=chg_configmode(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=mode_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.cardmode));</script>
		<SPAN id=span_cardmodel></SPAN>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.apn));</script>
		<input size=26 name=wwan_apnname value="<% nvram_get("wwan_apnname"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.dialnum));</script>
		<input size=26 name=wwan_dialnum value="<% nvram_get("wwan_dialnum"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.username));</script>
		<input size=26 name=wwan_username value="<% nvram_get("wwan_username"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.password));</script>
		<input size=26 name=wwan_passwd type=password value="<% nvram_get("wwan_passwd"); %>">
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.simcheck));</script>
		<script>
			var _val = new Array("1","0");
			var _name = new Array(__T(share.enable),__T(share.disable));
			draw_object(O_GUI,RADIO,"wwan_simcheck",_val,_name,"<% nvram_get("wwan_simcheck"); %>","onclick=chg_simcheck(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=mode_end>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.simpin));</script>
		<input size=26 name=wwan_pincode type=password value="<% nvram_get("wwan_pincode"); %>">
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.servername));</script>
		<input size=26 name=wwan_server_name value="<% nvram_get("wwan_server_name"); %>">
		</TD></TR>


		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.auth));</script>
		<script>
		var _name = new Array(__T(share.auto),__T(wan.pap),__T(wan.chap));
		var _val = new Array("auto","pap","chap");
		draw_object(O_GUI,SELBOX,"wwan_auth","",_name,_val,_wwan_auth);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.servicetype));</script>
		<script>
		var _name = new Array(__T(wwan.umtspre),__T(wwan.umtsonly),__T(wwan.gprsonly));
		var _val = new Array("umtspre","umts_only","gprs_only");
		draw_object(O_GUI,SELBOX,"wwan_service","",_name,_val, nv_wwan_service);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.lteservice),SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		var _name = new Array(__T(share.auto),__T(wwan.only4g),__T(wwan.only3g));
		var _val = new Array("auto","4g_only","3g_only");
		draw_object(O_GUI,SELBOX,"wwan_lte_type","",_name,_val, nv_wwan_lte_type);
		</script>
		</TD></TR>


		<!--start capacity-->
			<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
			<TR><script>draw_td(O_GUI,FUNTITLE,__T(wwan.cap),"colspan=2;");</script></TR>
			</TD></TR>
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.caprec));</script>
			<script>
			var _name = new Array(__T(share.enable),__T(share.disable));
			var _val = new Array("1","0");
			draw_object(O_GUI,RADIO,"wwan_cap_enabled",_val,_name,"<% nvram_get("wwan_cap_enabled"); %>"," onclick='sel_cap(this.form)'");
			</script>
			</TD></TR>
			<input type=hidden name=selcap_start>
			<!--time selection start-->
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.capsday));</script>
			<script>
				var _dayname = new Array("ISRANGE","1","31","1",2);
				draw_object(O_GUI,SELBOX,"wwan_cap_day","",_dayname,_dayname,"<% nvram_get("wwan_cap_day");%>");
			</script>
			</TD></TR>
			<!--time selection end-->
			<!--monthly bandwidth cap start -->
			<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.capmax));</script>
			<input size=5 maxlength=4 name=wwan_cap_bw id=wwan_cap_bw value="<% nvram_get("wwan_cap_bw"); %>" onblur=_check_range(this.value,WWAN_CAP_BW_START,WWAN_CAP_BW_TO,"msg_wwan_cap_bw","wwan_cap_bw")>
			<script>document.write("("+__T(logemail.schunit)+":&nbsp;"+__T(unit.MB)+")");</script>
			<SPAN id=msg_wwan_cap_bw></SPAN>
			</TD></TR>
			<!--monthly bandwidth cap end -->
		<!--end capacity-->
		<!--Email Setting Start-->
			<input type=hidden name=selcap_end>
			<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TD></TR>
			<TR><script>draw_td(O_GUI,FUNTITLE,__T(wwan.mail),"colspan=2");</script></TD></TR>
			<!--Email Check Box 1-->
			<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
			<input type=checkbox name=_wwan_mail_percentage <% nvram_match("wwan_mail_percentage","1","checked"); %>>
			<script>
				var _name = new Array("50","60","70","80","90","100");
				var _val = new Array("50","60","70","80","90","100");
				document.write(spell_words(send_mail_3g,draw_object(O_VAR,SELBOX,"wwan_cap_percentage","",_name,_val,"<% nvram_get("wwan_cap_percentage"); %>")));
			</script>
			<SPAN id=span_mailmsg1></SPAN>
			</TD></TR>
			<input type=hidden name=email_start>
			<!--Email Check Box 2-->
			<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
			<input type=checkbox name=_wwan_mail_cf <%nvram_match("wwan_mail_cf","1","checked");%>>
			<script>document.write(__T(wwan.mailmsg2));</script>
			</TD></TR>
			<!--Email Check Box 3-->
			<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
			<input type=checkbox name=_wwan_mail_period <% nvram_match("wwan_mail_period","1","checked"); %>>
			<script>
				var _name = new Array("30","60","120","240","480","960");
				var _val = new Array("30","60","120","240","480","960");
				document.write(spell_words(send_mail_3g2, draw_object(O_VAR,SELBOX,"wwan_mail_interval","",_name,_val,"<% nvram_get("wwan_mail_interval"); %>")));
			</script>
			<SPAN id=msg_interval></SPAN>
			</TD></TR>
			<input type=hidden name=email_end>
		<!--Email Setting End-->

        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
