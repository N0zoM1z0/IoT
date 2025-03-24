<html>
<head>
<title>Session Timeout</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("encode_data.js"); %>
var now_stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx = "<% nvram_gozila_get("selidx"); %>"; 
var back_bt = "true";
var define_backname="pppoe_profile.asp";
var nv_ppp_demand = "<% nvram_get("ppp_demand"); %>";
var nv_ppp_idletime = "<% nvram_get("ppp_idletime"); %>";
var nv_ppp_service = "<% nvram_get("ppp_service"); %>";
var nv_ppp_redialperiod = "<% nvram_get("ppp_redialperiod"); %>";
if ( <% nvram_else_match("ppp_passwd","","0","1"); %> ) 
	nv_ppp_passwd = TMP_PASSWD;
var data = new Array();
<% get_pppoe_data("data"); %>
function to_back(F)
{
	parent.document.getElementById("newpage").value = "pppoe_profile.asp";
	uiDoCancel(F,"back");
}
function init(){
	var F = document.frmpppoe;
	parent.document.getElementById("save_bg").style.display="none";
	choose_disable(F.dns1);
	choose_disable(F.dns2);
	if ( now_stflg == "edit" ) 
	{
		F.pppoe_pname.value = data[selidx][0];
		F.uname.value = cy_speccode_decode(data[selidx][1]);
		F.upwd.value = data[selidx][2];
		F.pppoe_redialperiod.value = data[selidx][5];
		F.pppoe_idletime.value = data[selidx][4];
		if ( data[selidx][3] == '0' ) 
		{
			F._ppp_demand[1].checked = true;
			chg_demand(F,0);
		}
		else
		{
			F._ppp_demand[0].checked = true;
			chg_demand(F,1);
		}
		F.authtype.selectedIndex = data[selidx][6];
		F.pppoe_service.value = data[selidx][7];
		F.wan_dns_mode[parseInt(data[selidx][8],10)].selected = true;
		var dns_data = data[selidx][9].split(" ");
		F.dns1.value = dns_data[0];
		if ( dns_data.length == 2 ) F.dns2.value = dns_data[1];
		chk_seldns(data[selidx][8],F);
	}else{
		chg_demand(F,0);
		//chk_seldns("<% nvram_get("wan_dns_mode"); %>",F);
	}
	default_nv = keep_val(F,"");
	 
}

function uiDoSave(F)
{
	var errflg=0;
	if ( !chkname(F) ) errflg = 1;
	if ( !chg_demand(F,F.pppoe_demand.value) ) errflg = 1;
	if ( !chk_idpwd('uname') ) errflg = 1 ;
	if ( !chk_idpwd('upwd') ) errflg =1 ; 
	if ( errflg == 1 ) return;
	if ( (now_stflg == "edit" && F.upwd.value != TMP_PASSWD) || now_stflg == "add" )  
		F.upwd.value = encode_data(F.upwd.value); 
	if ( F.wan_dns_mode.selectedIndex == 2 ) 
	{
		if ( F.dns1.value == "" && F.dns2.value == "" ) 
		{
	               	my_alert(O_VAR,"dns1",__T(msg.notblank),"0","msg_dns1");
			return ;
		}
	}
	if ( F.dns1.value != "" && !chk_dns("dns1") ) return;
	if ( F.dns2.value != "" && !chk_dns("dns2") ) return;
	if ( F.dns1.value != "" ) 
		F.dns.value = F.dns1.value+" "+F.dns2.value;
	else
		F.dns.value = F.dns2.value;
//	choose_enable(F.pppoe_redialperiod);
//	choose_enable(F.pppoe_idletime);
	F.submit_button.value = "pppoe_profile";
	F.idx.value = selidx;
	F.stflg.value = now_stflg;
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function chkdns(F)
{
	if ( F.defdns.checked == true ) 
	{
		choose_disable(F.pridns);
		choose_disable(F.secdns);
	}else{
		choose_enable(F.pridns);
		choose_enable(F.secdns);
	}
}

function chk_conntype(F)
{
	if ( F._ppp_demand[0].checked == true ) 
		choose_disable(F.txtidletime);
	else
		choose_enable(F.txtidletime);
}

<%support_invmatch("WWAN_SUPPORT","1","/*");%>
function check_failover_setting(F,r1)
{
	var wwan_connect_failover = "<% nvram_get("wwan_connect_failover"); %>";
	var wwan_connect_recovery = "<% nvram_get("wwan_connect_recovery"); %>";
	if ( (r1 == 1) && (wwan_connect_recovery == "1") && wwan_connect_failover == "1" ) 
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(wwan.warncodmsg),"wan_alert_result()");	
		return false;
	}	
	return true;

}
function chg_demand_onclick(F,r1)
{

//	var wwan_connect_recovery = "<% nvram_get("wwan_connect_recovery"); %>";
//	if ( (r1 == 1) && (wwan_connect_recovery == "1")) 
//	{
//		my_alert(O_GUI,INFO,__T(share.info),__T(wwan.warncodmsg),"wan_alert_result()");	
//		return;
//	}	
	
	if(check_failover_setting(F,r1))
		chg_demand(F,r1);
	else
		return;

}
function wan_alert_result()
{
	var F = document.frmpppoe;
	alert_result(0);
	F._ppp_demand[1].checked = true;
}

<%support_invmatch("WWAN_SUPPORT","1","*/");%>

function chg_demand(F,r1)
{
	clear_msg("ppp_redialperiod","_ppp_redialperiod");
	clear_msg("pppoe_idletime","_ppp_idletime");
	if ( r1 == 0 ){
		choose_disable(F.pppoe_idletime);
		choose_enable(F.pppoe_redialperiod);
		F.pppoe_demand.value=0;
                return valid_ppp_redial(F.pppoe_redialperiod,"ppp_redialperiod","_ppp_redialperiod")

	}else{
		choose_enable(F.pppoe_idletime);
		choose_disable(F.pppoe_redialperiod);
<%support_invmatch("WWAN_SUPPORT","1","/*");%>
		if(!check_failover_setting(F,r1))
			F.ppp_demand.value=0;
		else
<%support_invmatch("WWAN_SUPPORT","1","*/");%>
		F.pppoe_demand.value=1;
		return valid_ppp_idletime(F.pppoe_idletime,"pppoe_idletime","_ppp_idletime")
	}
}

function valid_ppp_idletime(obj,obj_id,span_id){ 

	if(!msg_chk_range(obj.value,obj_id,PPP_IDLETIME_START,PPP_IDLETIME_TO,10,IS_FIELD,0,span_id))
		return false;
	return true;
}

function valid_ppp_redial(obj,obj_id,span_id){
	//clear_msg(ppp_idletime,span_id);
	if(!msg_chk_range(obj.value,obj_id,PPP_REDIALPERIOD_START,PPP_REDIALPERIOD_TO,10,IS_FIELD,0,span_id))
		return false;
	return true;
}

function chkname(F)
{
	clear_msg("pppoe_pname","msg_pname");
        var returnmsg = valid_meaning_id_name(ID_NAME,F.pppoe_pname.value,ZERO_NO,"pppoe_pname");
	if ( returnmsg!= "" ) 
	{
                my_alert(O_VAR,"pppoe_pname",returnmsg,"0","msg_pname");
		return false;
	}
	for(var i=0; i<data.length; i++)
	{
		if ( i == selidx ) continue;
		if ( F.pppoe_pname.value == data[i][0] ) 
		{
                	my_alert(O_VAR,"pppoe_pname",__T(msg.nameexist),"0","msg_pname");
			return false;
		}
	}
	return true;
}

function chk_idpwd(obj_name){
	var F = document.frmpppoe;
	document.getElementById(obj_name).style.backgroundColor="";
	document.getElementById("msg_"+obj_name).innerHTML = "";
	var return_msg = valid_meaning_id_name(MEANING_NAME,eval("F."+obj_name).value,ZERO_NO|SPACE_NO);
        if ( obj_name == "uname" ) 
	{
		if ( return_msg!= "" || eval("F."+obj_name).value.indexOf("'") != -1 || 
                     eval("F."+obj_name).value.indexOf("\"") != -1) 
		{
                        my_alert(O_VAR,"uname",__T(msg.middlespacequote),"0","msg_uname");
			return false;
		}
	}else{ 
		if ( return_msg != "" ) 
		{
                        my_alert(O_VAR,"upwd",return_msg,"0","msg_upwd");
	                return false;
		}
        }
	return true;
}

function chk_seldns(num,F)
{
	choose_disable(F.dns1);
	choose_disable(F.dns2);
	//F.dns1.value = "";
	//F.dns2.value = "";

  if ( num == 0 )
  {
    F.dns1.value = "";
    F.dns2.value = "";
  }
  if ( num == 1 )
  {
		F.dns1.value = "208.67.222.222";
		F.dns2.value = "208.67.220.220"; 
	}
	if ( num == 2 ) 
	{
		choose_enable(F.dns1);
		choose_enable(F.dns2);
		var dns_data = data[selidx][9].split(" ");
		F.dns1.value = dns_data[0];
		if ( dns_data.length == 2 )
      F.dns2.value = dns_data[1];
	}
}

function chk_dns(objname)
{
	clear_msg(objname,"msg_"+objname);
	var errmsg="";
	var F = document.frmpppoe;		
	if ( check_ipv4(eval("F."+objname).value, VALID_IP_RULE7) != PASS )
	{
        	my_alert(O_VAR,objname,__T(msg.ivalidipformat),"0","msg_"+objname);
		return false;
	} 
	return true;
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmpppoe method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=idx>
<input type=hidden name=pppoe_demand>
<input type=hidden name=dns>
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.pppoeps),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.pname));</script>
		<input size=30 maxlength=32 name=pppoe_pname id=pppoe_pname onblur=chkname(this.form)>
		<span id=msg_pname></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.username));</script>
		<input size=30 name=uname id=uname maxlength=63 onblur=chk_idpwd("uname")>
		<span id=msg_uname></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.password));</script>
		<input type=password size=30 name=upwd id=upwd maxlength=63 onblur=chk_idpwd("upwd")>
		<span id=msg_upwd></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.dnssource));
		var _name = new Array(__T(lan.getdnsisp),__T(lan.useopendns),__T(lan.usethesedns));
		var _val = new Array(0,1,2);
		draw_object(O_GUI,SELBOX,"wan_dns_mode","onChange=chk_seldns(this.form.wan_dns_mode.selectedIndex,this.form)",_name,_val,"0");
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.pridns));</script>
		<input size=20 name=dns1 id=dns1 onblur=chk_dns("dns1")><SPAN id=msg_dns1></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.secdns));</script>
		<input size=20 name=dns2 id=dns2 onblur=chk_dns("dns2")><SPAN id=msg_dns2></SPAN></TD></TR>
		<TR>
		<script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
			var selflg1="",selflg2="";
			if ( nv_ppp_demand == 1 ) selflg1="checked";
			else selflg2="checked";
			document.write("<input type=radio "+selflg1+" name=_ppp_demand value=1 onClick=chg_demand_onclick(this.form,1)>"+spell_words(connect_on_demand_rule,"<input id=pppoe_idletime size=5 maxlength=4 name=pppoe_idletime value="+nv_ppp_idletime+" onblur=valid_ppp_idletime(this,\"pppoe_idletime\",\"_ppp_idletime\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"1","9999","5"));
			document.write("<SPAN id=_ppp_idletime></SPAN></TD></TR>");
			document.write("<TR>");
			draw_td(O_GUI,SUBTITLE_M,"colspan=2");
			document.write("<input type=radio "+selflg2+" name=_ppp_demand value=0 onClick=chg_demand_onclick(this.form,0)>"+spell_words(keep_alive_rule,"<input id=pppoe_redialperiod size=5 maxlength=3 name=pppoe_redialperiod value="+nv_ppp_redialperiod+" onblur=valid_ppp_redial(this,\"pppoe_redialperiod\",\"_ppp_redialperiod\")>")+"&nbsp;&nbsp;"+spell_words(range_def_rule,"20","180","30"));
			document.write("<SPAN id=_ppp_redialperiod></SPAN></TD></TR>");
		</script>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.authtype));
                var _name = new Array(__T(wan.autonegotiation),__T(wan.pap),__T(wan.chap),__T(wan.mschap),__T(wan.mschap2));
                var _val = new Array("0","1","2","3","4");
                draw_object(O_GUI,SELBOX,"authtype","",_name,_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.servicename),SPACE_DOWN,SPACE_DOWN);
                document.write("<input type=text size=20 maxlength=63 name='pppoe_service' id='pppoe_service' value='"+nv_ppp_service+"'>");                        
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
