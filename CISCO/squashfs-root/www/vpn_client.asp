<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
<% web_include_file("base64.js"); %>
var EDIT_MODE = 0 ;
var datalist = new Array();
<% get_vpn_account_data(); %>
var new_datalist = new Array();
var proto_name = new Array(<% support_match("PPTP_SERVER_SUPPORT","1","__T(wan.pptp),"); %>__T(vpn.quickvpn));
var idx=0;
var stflg="init";
var td_id = new Array("tden","tduser","tdpwd");
var alert_flg = "";

function to_del()
{
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
                                del_row(i);
	}
}

function to_edit(){
	stflg = "edit";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked && document.getElementById("user"+i) == null ) 
		{	
			var data = new Array();
			var chkflg = "";
			if ( datalist[i][0] == "1" ) chkflg = "checked";
			data[0] = "<input type=checkbox name=en_chk"+i+" id=en_chk"+i+" "+chkflg+">";
			data[1] = draw_td(O_VAR,ICONLINE,"img_user"+i,"<input size=15 maxlength=64 id=user"+i+" name=user"+i+" onMouseMove=showHint('img_user"+i+"','div_user"+i+"',event) onMouseOut=hideHint('div_user"+i+"') value="+datalist[i][1]+">","div_user"+i);
			data[2] = draw_td(O_VAR,ICONLINE,"img_pwd"+i,"<input type=password size=15 maxlength=64 id=pwd"+i+" name=pwd"+i+" onMouseMove=showHint('img_pwd"+i+"','div_pwd"+i+"',event) onMouseOut=hideHint('div_pwd"+i+"') value="+decode64(datalist[i][2])+">","div_pwd"+i);
			chkflg = "";
			if ( datalist[i][4] == "0" ) chkflg = "disabled";
			else if ( datalist[i][3] == "1" ) chkflg = "checked";
			edit_row(td_id,data,i);
		}
	}
}

function chk_before_data(index)
{
	var errflg = 0;
	if ( document.getElementById("user"+index) ) 
	{
		clear_table_msg("tmsg","img_user"+index,"user"+index,index);
		clear_table_msg("tmsg","img_pwd"+index,"pwd"+index,index);
		if ( !chk_name_pwd("user"+index,"img_user"+index,"div_user"+index,index) ) errflg = 1;
		if ( !chk_name_pwd("pwd"+index,"img_pwd"+index,"div_pwd"+index,index) ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
        return true;
}

function chk_click(index)
{
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,new_datalist[index]);
	
}

function chk_name_pwd(obj_name,img_name,div_name,index)
{
	clear_table_msg("tmsg",img_name,obj_name,index);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_name).value,ZERO_NO|SPACE_NO);
	if ( returnmsg != "" ) 
	{
		table_msg(img_name,obj_name,div_name,index,returnmsg);
		return false;	
	}
	return true;
}

function to_add(){
	if ( idx >= VPN_PPTP_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,VPN_PPTP_ENTRY,__T(vpn.vpnclient)),"");
                return false;
        }
	if ( !chk_before_data(idx-1) ) return false;
	stflg="add";
	var tmp = new Array();
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array("tdno_"+idx,(idx+1),2);
	tmp[2]=new Array(td_id[0]+idx,"<input type=checkbox name=en_chk"+idx+" id=en_chk"+idx+">",3);
	tmp[3]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,"img_user"+idx,"<input size=15 maxlength=64 id=user"+idx+" name=user"+idx+" onMouseMove=showHint('img_user"+idx+"','div_user"+idx+"',event) onMouseOut=hideHint('div_user"+idx+"') onblur=chk_name_pwd('user"+idx+"','img_user"+idx+"','div_user"+idx+"',"+idx+")>","div_user"+idx),1);
	tmp[4]=new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,"img_pwd"+idx,"<input type=password size=15 maxlength=64 id=pwd"+idx+" name=pwd"+idx+" onMouseMove=showHint('img_pwd"+idx+"','div_pwd"+idx+"',event) onMouseOut=hideHint('div_pwd"+idx+"') onblur=chk_name_pwd('pwd"+idx+"','img_pwd"+idx+"','div_pwd"+idx+"',"+idx+")>","div_pwd"+idx),1);
	tmp[5] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function reload_page()
{               
        top.location.href =  "<% get_http_prefix(""); %>default.asp";
}               
                
function regetstatus()
{
        reload_page();
        setTimeout('regetstatus()', 5000);              
}

function init_pptp(F){
	var pptp_server = "<% nvram_get("pptpd_localip"); %>";
	var pptp_client = "<% nvram_get("pptpd_remoteip"); %>";
	var tmp = "", tmp2="";
	if ( pptp_server != "" ) 
	{
		tmp = pptp_server.split(".");
		for(var i=0; i<4; i++)
			eval("F.pptp_server_"+i).value = tmp[i];
	}
	if ( pptp_client != "" ) 
	{
		tmp = pptp_client.split(".");
		tmp2 = tmp[3].split("-");
		for(var i=0; i<4; i++)
		{
			if ( i == 3 ) 
			{
				eval("F.pptp_client_"+i).value = tmp2[0];
				eval("F.pptp_client_"+(i+1)).value = tmp2[1];
			}else
				eval("F.pptp_client_"+i).value = tmp[i];
		}
		
	}

}

function init(){
	if (typeof reboot_running != "undefined" &&  reboot_running == '1' ) 
	{
		parent.document.getElementById('reboot_msg').innerHTML = __T(msg.rebootingdev);	
		setTimeout('regetstatus()',20000);
		return;
	}
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("hidden_bg").style.display="none";
	var F = document.vpnclient;
	init_pptp(F);
	pptp_st(F);
	for(var i=0; i<datalist.length; i++)
	{
		var tmp=new Array();
		new_datalist[i] = new Array();	
		new_datalist[i][0] = datalist[i][0]=="1"?__T(filter.yes):__T(filter.no);
		new_datalist[i][1] = datalist[i][1];
		new_datalist[i][2] = "********";

		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array("tdno_"+idx,(i+1),2);
		tmp[2]=new Array(td_id[0]+idx,new_datalist[i][0],3);
		tmp[3]=new Array(td_id[1]+idx,new_datalist[i][1],0);
		tmp[4]=new Array(td_id[2]+idx,new_datalist[i][2],0);
		tmp[5] = new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	choose_disable(document.getElementById("pptp_client_4"));
	choose_disable(document.getElementById("e1"));
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("fileTxtBox"));
	}
	default_nv = keep_val(F,"");
}

function pptp_st(F)
{
        if ( F.en_pptp.checked == false )
                DISABLE_PART(F,"pptp_start","pptp_end",1);
        else
                DISABLE_PART(F,"pptp_start","pptp_end",0);
	choose_disable(document.getElementById("pptp_client_4"));

}

var httpd_restart=false;
function vpn_valid_name(F)
{
	var errflg=0;
	var pptpd_name_arr = new Array();
	var vpn_name_arr = new Array();
	var vpn_count=0;
	var pptpd_count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("user"+i) )
		{
			clear_table_msg("tmsg","img_user"+i,"user"+i,i);
			clear_table_msg("tmsg","img_pwd"+i,"pwd"+i,i);
				pptpd_name_arr[pptpd_count] = new Array();
                                pptpd_name_arr[pptpd_count][0] = i;
                                pptpd_name_arr[pptpd_count][1] = document.getElementById("user"+i).value;
				pptpd_name_arr[pptpd_count][2] = "user";
                                pptpd_count++;
		}else{
			pptpd_name_arr[pptpd_count] = new Array();
                        pptpd_name_arr[pptpd_count][0] = i;
                        pptpd_name_arr[pptpd_count][1] = document.getElementById("tduser"+i).innerHTML;
                        pptpd_name_arr[pptpd_count][2] = "tduser";
                        pptpd_count++;
		}
	}
	var tmp_arr;
	var tmp_count;
	for(var k=0; k<2; k++)
	{
		if ( k == 0 ){ 
			tmp_count = vpn_count;
			tmp_arr = vpn_name_arr;
		}else{
			tmp_count = pptpd_count;
			tmp_arr = pptpd_name_arr;
		}
		//for(var i=0; i<tmp_count; i++)
		//{
		//	clear_table_msg("tmsg","img_user"+tmp_arr[i][0],"user"+tmp_arr[i][0],tmp_arr[i][0]);
		//}
		for(var i=0; i<tmp_count; i++)
		{
			for(var j=i+1; j<tmp_count; j++)
			{
				if ( tmp_arr[i][1] == tmp_arr[j][1] ) 
				{
					if ( tmp_arr[i][2] == "user" )
						table_msg("img_user"+tmp_arr[i][0],"user"+tmp_arr[i][0],"div_user"+tmp_arr[i][0],tmp_arr[i][0],__T(msg.nameexist));
					if ( tmp_arr[j][2] == "user" )
						table_msg("img_user"+tmp_arr[j][0],"user"+tmp_arr[j][0],"div_user"+tmp_arr[j][0],tmp_arr[j][0],__T(msg.nameexist));
					errflg = 1;
				}else{
				}
			}
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}



function valid_value(F)
{
	var errflg = 0;
        if ( F.en_pptp.checked )
	{
		if ( check_ipv4(get_full_ip(F,"pptp_server"),VALID_IP_RULE4) <= 0 &&
		     check_ipv4(get_full_ip(F,"pptp_server"),VALID_IP_RULE5) <= 0 &&
		     check_ipv4(get_full_ip(F,"pptp_server"),VALID_IP_RULE6) <= 0) 
		{
			my_alert(O_VAR,"pptp_server",__T(msg.privip),4,"msg_server");
			errflg = 1;	
		}
		if ( check_ipv4(get_full_ip(F,"pptp_client"),VALID_IP_RULE4) <= 0 &&
		     check_ipv4(get_full_ip(F,"pptp_client"),VALID_IP_RULE5) <= 0 &&
		     check_ipv4(get_full_ip(F,"pptp_client"),VALID_IP_RULE6) <= 0) 
		{
			my_alert(O_VAR,"pptp_client",__T(msg.privip),4,"msg_client");
			errflg = 1;	
		}
	}
	if ( !vpn_valid_name(F) ) return false;
	var pptpd_idx=0, vpn_idx=0;
	F.vpn_account.value="";
	F.pptpd_account.value="";
	var tmp = "",len="";
	for(var i=0; i<idx; i++)
	{
		if ( stflg == "del" ) 
		{
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
				continue;
		}
		tmp="";
		if ( document.getElementById("user"+i) )
		{
			if ( !chk_before_data(i) ) return false;
			tmp=encode64(document.getElementById("pwd"+i).value)+",";
                        tmp+="0,";
                        tmp+=document.getElementById("en_chk"+i).checked?"1":"0";
			tmp+=",";
			if ( document.getElementById("user"+i).value.length < 10 ) 
				len = "0"+document.getElementById("user"+i).value.length;
			else
				len = document.getElementById("user"+i).value.length;
			tmp+=len;
                        tmp+=document.getElementById("user"+i).value;
			if ( F.pptpd_account.value != "" ) F.pptpd_account.value+=";";
			F.pptpd_account.value+=tmp;
			pptpd_idx++;
		}else{
			tmp=datalist[i][2]+",";
			tmp+="0,";
                        tmp+=document.getElementById("tden"+i).innerHTML==__T(filter.yes)?"1":"0";
			tmp+=",";
			
			if ( document.getElementById("tduser"+i).innerHTML.length < 10 ) 
				len = "0"+document.getElementById("tduser"+i).innerHTML.length;
			else
				len = document.getElementById("tduser"+i).innerHTML.length;
			tmp+=len;
                        tmp+=document.getElementById("tduser"+i).innerHTML;
			if ( datalist[i][4] == "1" ) 
			{
				if ( F.vpn_account.value != "" ) F.vpn_account.value+=";";
				F.vpn_account.value+=tmp;
				vpn_idx++;
			}
			else
			{
				if ( F.pptpd_account.value != "" ) F.pptpd_account.value+=";";
                                F.pptpd_account.value+=tmp;
				pptpd_idx++;
			}
		}
	}
	//alert("vpn_account="+F.vpn_account.value+";pptpd_account="+F.pptpd_account.value);
	if ( pptpd_idx > VPN_PPTP_ENTRY ) 
	{
                my_alert(O_GUI,INFO,__T(share.info),spell_words(max_rule,VPN_PPTP_ENTRY,__T(router.pptpvpnclient)),"");
		errflg=1;
	}
	if ( errflg ) return false;
	return true;
}

function chk_default_ip(F)
{
        vlan1_ip = "<% nvram_get("lan_ipaddr_1"); %>";
	//alert("vlan_ip="+vlan1_ip+";idx="+idx);
	//alert("alert_flg="+alert_flg);
        if ( idx > 0 || alert_flg == "change_ip" ) //add new entry
        {
                if ( vlan1_ip.substring(0,10) == "192.168.1." )
                        F.change_lan_ip.value=1;
                else
                        F.change_lan_ip.value=0;
        }
	//alert("change_lan_ip="+F.change_lan_ip.value);
        if ( F.change_lan_ip.value == 1 ) return true;
	else if ( F.change_lan_ip.value == 0 ) 
		vpnclient_alert_result(1);
        return false;
}

function uiDoSave(F)
{
	alert_flg = "save";
	if ( !valid_value(F) ) return false;
	if ( !enter_client_ip(F,F.pptp_client_3.value))return false;
	var sip="";
	for(var i=0; i<4; i++)
	{
		if ( sip != "" ) sip +=".";
		sip += eval("F.pptp_server_"+i).value;
	}
	var cip="";
	for(var i=0; i<4; i++)
	{
		if ( cip != "" ) cip +=".";
		cip += eval("F.pptp_client_"+i).value;
	}
	if ( !valid_subnet(sip,"255.255.255.0",cip))
	{
		my_alert(O_VAR,"pptp_client",__T(msg.subnet9),"4","msg_client");
		return false;	
	}
	F.pptpd_enable.value=0;
	if ( F.en_pptp.checked == true ) 
	{
		F.pptpd_enable.value=1;
	}else{
		init_pptp(F);
	}
	F.mppe_disable.value=1;
	if ( F.is_mppe_enable.checked == true ) F.mppe_disable.value=0;
	F.pptpd_localip.value = "";
	for(var i=0; i<4; i++)
	{	
		if ( F.pptpd_localip.value != "" ) F.pptpd_localip.value+=".";
		F.pptpd_localip.value += eval("F.pptp_server_"+i).value;
	}
	F.pptpd_remoteip.value = "";
	for(var i=0; i<5; i++)
	{
		if ( i < 4 && F.pptpd_remoteip.value != "" ) F.pptpd_remoteip.value+=".";
		else if ( i == 4 ) F.pptpd_remoteip.value+="-";
		F.pptpd_remoteip.value+=eval("F.pptp_client_"+i).value;
	}
	if ( stflg == "add" && idx > 0 ) 
	{
		if ( chk_default_ip(F) == true )
		{
                	my_alert(O_GUI,WARNING,__T(share.info),__T(msg.chgdefip),"vpnclient_alert_result(1)","vpnclient_alert_result(2)","vpnclient_alert_result(0)","pptp");
		}
	}else
		vpnclient_alert_result(1);
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("vpn_client.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function vpnclient_alert_result(val){
        var F = document.vpnclient;
        alert_result(0);
	if( http_power == "r") return;
	if ( alert_flg == "import" ) 
	{
		choose_disable(F.change_lan_ip);
        	if ( val == 1 ) 
	        {
			alert_flg = "change_ip";
			if ( chk_default_ip(F) == true )
	                {
                	        my_alert(O_GUI,WARNING,__T(share.info),__T(msg.chgdefip),"vpnclient_alert_result(1)","vpnclient_alert_result(2)","vpnclient_alert_result(0)","pptp");
				choose_enable(F.change_lan_ip);
        	        }
			return;
		}
	}else if ( alert_flg == "change_ip" ) 
	{
		var IMAGE = F.importvpnclient.value.toLowerCase();
                var len = F.importvpnclient.value.length;
                var ext = new Array('.','c','s','v');
		F.submit_button.value = "vpn_client";	
		if ( val > 0 ) 
		{
			if ( val == 1 )  F.change_lan_ip.value = 0;
	                for (var i=0; i < 4; i++)   {
        	                if (ext[i] != IMAGE.charAt(len-4+i)){
                	                my_alert(O_VAR,"txtUploadFile",__T(fwupgrade.wrimage),"0","msg_file");
                        	        return false;
	                        }
        	        }       
	                F.action = goto_link("import.cgi");
        	        F.encoding="multipart/form-data";
                	F.submit();
			if ( F.change_lan_ip.disabled == true ) 
		                parent.document.getElementById("save_bg").style.display="";
			else
		                parent.document.getElementById("hidden_bg").style.display="";

	        }
		return;
	}else{
		
	        if ( val > 0 )
        	{
			if ( val == 2 )  F.change_lan_ip.value = 0;
			//F.change_lan_ip.value=0;
			//alert("change_lan_ip="+F.change_lan_ip.value);
			if ( F.change_lan_ip.value == 1 ) 
			{
				F.submit_button.value="vpn_client_reboot";
				parent.document.getElementById("save_bg").style.display="none";
			        parent.document.getElementById("reboot_msg").innerHTML=__T(msg.rebootingdev);
			        parent.document.getElementById("hidden_bg").style.display="";
			}
			else
			{
				//if ( httpd_restart == true ) 
				//{
				//	F.submit_button.value = "vpn_client_httpd";
			        //	parent.document.getElementById("hidden_bg").style.display="";
				//}else{
					
					F.submit_button.value="vpn_client";
					if ( http_from == "wan" ) 
					{
						setTimeout("chk_st()", 15000);
					}	
					parent.document.getElementById("save_bg").style.display="";
				//}
			}
			F.submit();
		}
	}
}

function enter_client_ip(F,val)
{
	var obj_s="";
	var obj_c="";
	if ( !msg_chk_range(val,"pptp_client_3",1,255,10,IS_FIELD,0,"msg_client") )return;
	F.pptp_client_4.value = parseInt(val)+10-1;
	clear_msg("pptp_client_4","msg_client");
	if ( parseInt(val)+10-1 >= 255 )
	{
		my_alert(O_VAR,"pptp_client_4",spell_words(range_rule,"1","255"),"0","msg_client") 
		return false;
	}
	for(var i=0; i<3; i++)
	{	
		if (obj_s != "") obj_s = obj_s + ".";
		obj_s += eval("F.pptp_server_"+i).value;
	}
	for(var i=0; i<3; i++)
	{
		if (obj_c != "") obj_c += ".";
		obj_c+=eval("F.pptp_client_"+i).value;
	}
	for (var i=0; i<5; i++)
	{
		if ((obj_s == obj_c) && ( eval("F.pptp_server_3").value == parseInt(eval("F.pptp_client_3").value) + i))
		{
        	        my_alert(O_VAR,"pptp_server",__T(msg.invalidip3),4,"msg_server");
                	return false;
		}
	}	
	F.pptp_client_4.value = parseInt(val)+10-1;
	choose_disable(document.getElementById("pptp_client_4"));
	return true;
}

function to_import(F)
{
	clear_msg("txtUploadFile","msg_file");
		
	if (F.importvpnclient.value != '') 
	{
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.importmsg1),"vpnclient_alert_result(1)","vpnclient_alert_result(0)","","yesno");
		alert_flg = "import";
	}
}
		
function sel_url(obj)
{
        document.getElementById("txtUploadFile").value = getPath(obj);
	if ( document.getElementById("txtUploadFile").value.length > 5 ) 
		choose_enable(document.getElementById("e1"));

}

function chk_all()
{
        if ( stflg == "add" ){
                document.getElementById("chkall").checked = false;
                choose_disable(document.getElementById("chkall"));
                return;
        } 
        for(var i=0; i<idx; i++)        
        {
                if ( document.getElementById("chk_"+i) == null ) continue;
                if ( document.getElementById("chkall").checked == true ) 
                        document.getElementById("chk_"+i).checked = true;
                else
                        document.getElementById("chk_"+i).checked = false;
                to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,new_datalist[i]);
        }
}

function to_import(F)
{
	get_position("users.asp",0);
}

</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=vpnclient method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=pptpd_enable>
<input type=hidden name=pptpd_localip>
<input type=hidden name=pptpd_remoteip>
<input type=hidden name=pptpd_account>
<input type=hidden name=vpn_pptpd_account value=1>
<input type=hidden name=vpn_account>
<input type=hidden name=change_lan_ip value=0>
<input type=hidden name=netbios_enable>
<input type=hidden name=mppe_disable>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.pptpserver));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP>
		<% support_invmatch("PPTP_SERVER_SUPPORT","1","<!--"); %>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.pptpconfig));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.pptpserver));</script>
		<input type=checkbox name=en_pptp <% nvram_match("pptpd_enable","1","checked"); %> onclick=pptp_st(this.form)> 
		<script>Capture(share.enable);</script>
		</TD></TR>
		<input type=hidden name=pptp_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ippptpserver));</script>
                <input size=3 maxlength=3 name=pptp_server_0 id=pptp_server_0 value=10 onblur=msg_chk_range(this.value,"pptp_server_0",1,192,10,IS_FIELD,0,"msg_server")> . 
		<input size=3 maxlength=3 name=pptp_server_1 id=pptp_server_1 value=10 onblur=msg_chk_range(this.value,"pptp_server_1",0,168,10,IS_FIELD,0,"msg_server")> . 
		<input size=3 maxlength=3 name=pptp_server_2 id=pptp_server_2 value=10 onblur=msg_chk_range(this.value,"pptp_server_2",0,255,10,IS_FIELD,0,"msg_server")> . 
		<input size=3 maxlength=3 name=pptp_server_3 id=pptp_server_3 value=10 onblur=msg_chk_range(this.value,"pptp_server_3",1,255,10,IS_FIELD,0,"msg_server")> 
		<span id=msg_server></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ippptpclient));</script>
                <input size=3 maxlength=3 value=10 name=pptp_client_0 id=pptp_client_0 onblur=msg_chk_range(this.value,"pptp_client_0",1,192,10,IS_FIELD,0,"msg_client")> . 
		<input size=3 maxlength=3 value=10 name=pptp_client_1 id=pptp_client_1 onblur=msg_chk_range(this.value,"pptp_client_1",0,168,10,IS_FIELD,0,"msg_client")> . 
		<input size=3 maxlength=3 value=10 name=pptp_client_2 id=pptp_client_2 onblur=msg_chk_range(this.value,"pptp_client_2",0,255,10,IS_FIELD,0,"msg_client")> . 
		<input size=3 maxlength=3 value=10 name=pptp_client_3 id=pptp_client_3 onblur=enter_client_ip(this.form,this.value)>&nbsp;-&nbsp;	 
		<input size=3 value=19 name=pptp_client_4 id=pptp_client_4 readonly disabled>
		<span id=msg_client></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.mppeencry));</script>
                <input type=checkbox name=is_mppe_enable <% nvram_else_match("mppe_disable","1","","checked");%>>
		<script>Capture(share.enable);</script>
                </TD></TR>
		<input type=hidden name=pptp_end>
                <% support_invmatch("PPTP_SERVER_SUPPORT","1","-->"); %>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","t3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","t4",__T(share.del),"to_del(this.form)");
		bt_list[3] = new Array("BT","t5",__T(mang.importbt),"to_import(this.form)");
		
		draw_td(O_GUI,CREATE_EDIT_TABLE,"7,5,8,18,18",__T(vpn.pptptb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(share.no)+","+__T(share.enable)+","+__T(share.username)+","+__T(share.password),"",bt_list,"","","2,1,2,0,0");
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.importsetting),""," valign=top");</script>
		<div style="position:relative;">
		<input name=importvpnclient id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<INPUT type=text id=txtUploadFile name=browser size=28 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
		<span id=msg_file style="position:absolute;left:250px"></span>
                <script>
                draw_object(O_GUI,BT,__T(router.browse),"e2 id=e2 style='position:absolute;left:175px;top:0px'","BT","");
		</script>
		</div>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>Capture(mang.importmsg);</script></TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN, SPACE_DOWN);</script>
                <script>
                draw_object(O_GUI,BT,__T(mang.importbt),"e1","BT","to_import(this.form)");
		if ( http_power == "r" ) choose_disable(document.getElementById("t1"));
		</script></TD></TR-->
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
