<html>
<head>
<title>Wireless Security</title>
<% web_include_file("filelink.asp"); %>

<script language="JavaScript">
<% web_include_file("base64.js"); %>
function DDNSWORD(xname,xvalue)
{
        this.name = xname;
        this.val = xvalue;
}
var wanip="<% show_ddns_ip(); %>";
var publicip="<% show_ddns_ip("tzo"); %>";
var td_id = new Array("td_en","td_service","td_name","td_pwd","td_host","td_ip","td_status");
var div_id = new Array("div_en","div_service","div_name","div_pwd","div_host","div_ip","div_status");
var img_id = new Array("img_en","img_service","img_name","img_pwd","img_host","img_ip","img_status");
var obj_id = new Array("en","service","username","passwd","hostname","ip","st");

var arr_ddns= new Array();
arr_ddns[0] = new DDNSWORD("dyn_good",__T(ddnsm.dyn_good));
arr_ddns[1] = new DDNSWORD("dyn_noupdate",__T(ddnsm.dyn_noupdate));
arr_ddns[2] = new DDNSWORD("dyn_nohost",__T(ddnsm.dyn_nohost));
arr_ddns[3] = new DDNSWORD("dyn_notfqdn",__T(ddnsm.dyn_notfqdn));
arr_ddns[4] = new DDNSWORD("dyn_yours",__T(ddnsm.dyn_yours));
arr_ddns[5] = new DDNSWORD("dyn_abuse",__T(ddnsm.dyn_abuse));
arr_ddns[6] = new DDNSWORD("dyn_nochg",__T(ddnsm.dyn_nochg));
arr_ddns[7] = new DDNSWORD("dyn_badauth",__T(ddnsm.dyn_badauth));
arr_ddns[8] = new DDNSWORD("dyn_badsys",__T(ddnsm.dyn_badsys));
arr_ddns[9] = new DDNSWORD("dyn_badagent",__T(ddnsm.dyn_badagent));
arr_ddns[10] = new DDNSWORD("dyn_numhost",__T(ddnsm.dyn_numhost));
arr_ddns[11] = new DDNSWORD("dyn_dnserr",__T(ddnsm.dyn_dnserr));
arr_ddns[12] = new DDNSWORD("dyn_911",__T(ddnsm.dyn_911));
arr_ddns[13] = new DDNSWORD("dyn_999",__T(ddnsm.dyn_999));
arr_ddns[14] = new DDNSWORD("dyn_donator",__T(ddnsm.dyn_donator));
arr_ddns[15] = new DDNSWORD("dyn_strange",__T(ddnsm.dyn_strange));
arr_ddns[16] = new DDNSWORD("dyn_uncode",__T(ddnsm.dyn_uncode));
arr_ddns[17] = new DDNSWORD("tzo_200",__T(ddnsm.tzo200));
arr_ddns[18] = new DDNSWORD("tzo_201",__T(ddnsm.tzo201));
arr_ddns[19] = new DDNSWORD("tzo_304",__T(ddnsm.tzo304));
arr_ddns[20] = new DDNSWORD("tzo_401",__T(ddnsm.tzo401));
arr_ddns[21] = new DDNSWORD("tzo_403",__T(ddnsm.tzo403));
arr_ddns[22] = new DDNSWORD("tzo_404",__T(ddnsm.tzo404));
arr_ddns[23] = new DDNSWORD("tzo_405",__T(ddnsm.tzo405));
arr_ddns[24] = new DDNSWORD("tzo_406",__T(ddnsm.tzo406));
arr_ddns[25] = new DDNSWORD("tzo_409",__T(ddnsm.tzo409));
arr_ddns[26] = new DDNSWORD("tzo_413",__T(ddnsm.tzo413));
arr_ddns[27] = new DDNSWORD("tzo_414",__T(ddnsm.tzo414));
arr_ddns[28] = new DDNSWORD("tzo_415",__T(ddnsm.tzo415));
arr_ddns[29] = new DDNSWORD("tzo_480",__T(ddnsm.tzo480));
arr_ddns[30] = new DDNSWORD("tzo_500",__T(ddnsm.tzo500));
arr_ddns[31] = new DDNSWORD("tzo_506",__T(ddnsm.tzo506));
arr_ddns[32] = new DDNSWORD("all_closed",__T(ddnsm.all_closed));
arr_ddns[33] = new DDNSWORD("all_resolving",__T(ddnsm.all_resolving));
arr_ddns[34] = new DDNSWORD("all_errresolv",__T(ddnsm.all_errresolv));
arr_ddns[35] = new DDNSWORD("all_connecting",__T(ddnsm.all_connecting));
arr_ddns[36] = new DDNSWORD("all_connectfail",__T(ddnsm.all_connectfail));
arr_ddns[37] = new DDNSWORD("all_disabled",__T(ddnsm.all_disabled));
arr_ddns[38] = new DDNSWORD("all_noip",__T(ddnsm.all_noip));

function newwin(path){
	self.open(path,"Support","alwaysRaised,resizable,scrollbars,width=480,height=425");
}

var en_ddns="<% nvram_get("ddns_enable"); %>";
var tzo_msg="<% show_ddns_status("1"); %>";
var dyndns_msg="<% show_ddns_status("2"); %>";
var d3322_msg="<% show_ddns_status("3"); %>";
var noip_msg="<% show_ddns_status("4"); %>";

var stflg="init";
var initflg=1;
var nv_ddns_pwd_1="";
var nv_ddns_pwd_2="";
var nv_ddns_pwd_3="";
var nv_ddns_pwd_4="";
if ( <% nvram_else_match("ddns_passwd_1","","0","1"); %> ) 
        nv_ddns_pwd_1 = TMP_PASSWD;
if ( <% nvram_else_match("ddns_passwd_2","","0","1"); %> ) 
        nv_ddns_pwd_2 = TMP_PASSWD;
if ( <% nvram_else_match("ddns_passwd_3","","0","1"); %> ) 
        nv_ddns_pwd_3 = TMP_PASSWD;
if ( <% nvram_else_match("ddns_passwd_4","","0","1"); %> ) 
        nv_ddns_pwd_4 = TMP_PASSWD;
var ddns_name = new Array("TZO.com","DynDNS.com","3322.org"<% support_match("NOIP_SUPPORT","1",",'noip.com'"); %>);
var ddns_val = new Array("2","1","3"<% support_match("NOIP_SUPPORT","1",",'5'"); %>);
var en_val = new Array(__T(filter.no),__T(filter.yes));
var nv_ddns_enable_1 = "<% nvram_get("ddns_enable_1"); %>";
var nv_ddns_enable_2 = "<% nvram_get("ddns_enable_2"); %>";
var nv_ddns_enable_3 = "<% nvram_get("ddns_enable_3"); %>";
var nv_ddns_enable_4 = "<% nvram_get("ddns_enable_4"); %>";
var idx=0;
var ddns = new Array();
ddns[0] = new Array(nv_ddns_enable_1,ddns_name[0],"<% nvram_get("ddns_username_1"); %>",nv_ddns_pwd_1,"<% nvram_get("ddns_hostname_1"); %>",publicip,show_status(tzo_msg,nv_ddns_enable_1));
ddns[1] = new Array(nv_ddns_enable_2,ddns_name[1],"<% nvram_get("ddns_username_2"); %>",nv_ddns_pwd_2,"<% nvram_get("ddns_hostname_2"); %>",wanip,show_status(dyndns_msg,nv_ddns_enable_2));
ddns[2] = new Array(nv_ddns_enable_3,ddns_name[2],"<% nvram_get("ddns_username_3"); %>",nv_ddns_pwd_3,"<% nvram_get("ddns_hostname_3"); %>",wanip,show_status(d3322_msg,nv_ddns_enable_3));
ddns[3] = new Array(nv_ddns_enable_4,ddns_name[3],"<% nvram_get("ddns_username_4"); %>",nv_ddns_pwd_4,"<% nvram_get("ddns_hostname_4"); %>",wanip,show_status(noip_msg,nv_ddns_enable_4));

function reload()
{
	goto_page("ddns.asp");
}

function show_status(RetMsg,val)
{
        var newword="";
	var str="";
	
	if ( val == "1" ) 
	{
		if( RetMsg == "all_resolving" || RetMsg == "all_connecting" || str_replace(" ","", RetMsg) == "" ) 
		{
			setTimeout('reload();', 2000); 
		}
	}

        if( RetMsg=="" || RetMsg.length < 2)
                return "";
        else
        {
                for(var i=0; i<arr_ddns.length; i++)
                {
                        if ( RetMsg == arr_ddns[i].name)
                        {
                                newword = arr_ddns[i].val;
                                break;
                        }
                }
        }
        if ( RetMsg.indexOf("tzo") != -1 &&
             RetMsg != "tzo_200" && RetMsg != "tzo304" &&
             RetMsg != "tzo_414" && RetMsg != "ddnsm.tzo500" )
        {
                str += __T(ddnsm.others1)+"<BR>";
                if ( newword == "" ) str = RetMsg;
                else  str = newword;

                if ( RetMsg == "tzo_401" || RetMsg == "tzo_403" )
                {
                        str += " - "+__T(ddnsm.others2);
                }
                else if ( RetMsg == "tzo_405" || RetMsg == "tzo_415" || RetMsg == "tzo_480")
                        str += " - "+__T(ddnsm.others3);
        }
        else
        {
                if ( newword == "" ) str = RetMsg;
                else  str = newword;
        }
	return str;
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmddns;
	for(var i=0; i<ddns_name.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1]=new Array(td_id[0]+idx,en_val[ddns[i][0]],3);
		tmp[2]=new Array(td_id[1]+idx,ddns[i][1],0);
		tmp[3]=new Array(td_id[2]+idx,ddns[i][2],0);
		tmp[4]=new Array(td_id[3]+idx,ddns[i][3]!=""?"**********":"",0);
		tmp[5]=new Array(td_id[4]+idx,ddns[i][4],0);
		tmp[6]=new Array(td_id[5]+idx,ddns[i][5],0);
		tmp[7]=new Array(td_id[6]+idx,ddns[i][0]=="1"?ddns[i][6]:"",0);
		tmp[8]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	chg_status();
	default_nv = keep_val(F,skip_name);
}

function chk_click(index){
	var rdata = new Array();
	for(var i=0; i<ddns[index].length; i++)
	{
		if ( i == 0 ) 
			rdata[i] = en_val[ddns[index][i]]
		else if ( i == 3 && ddns[index][i] != "" ) 
			rdata[i] = "**********";
		else if ( i == 6 &&  ddns[index][0] != "1" ) 
			rdata[i] = "";
		else
			rdata[i] = ddns[index][i];
	}
        to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,rdata);
}

function chk_all()
{
	for(var i=0; i<idx; i++)	
	{
		if ( document.getElementById("chk_"+i) == null ) continue;
		if ( document.getElementById("chkall").checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,ddns[i]);
	}
	
}

function chg_status()
{
	var en_flg = 0;
	for(var i=0; i<4; i++)
	{
		if ( document.getElementById(obj_id[0]+i) ) 
		{
			if ( document.getElementById(obj_id[0]+i).checked == true ) 
				en_flg = 1;
		}else{
			if ( document.getElementById(td_id[0]+i).innerHTML == en_val[1] ) 
				en_flg = 1;
		}
	}
	if ( en_flg == 1 ) 
		choose_enable(document.getElementById("e2"));
	else
		choose_disable(document.getElementById("e2"));
}

function to_edit()
{
	stflg = "edit";	
	var F = document.frmddns;
	for(var i=0; i<idx; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var data = new Array();
			var chkflg = "";
			if ( ddns[i][0] == "1" ) chkflg = "checked";
			data[0]= draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input type=checkbox id="+obj_id[0]+i+" "+chkflg+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') onclick=chg_status()>",div_id[0]+i);
			data[1]= draw_td(O_VAR,ICONLINE,img_id[1]+i,ddns_name[i],div_id[1]+i);
			data[2]= draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=20 maxlength=32 id="+obj_id[2]+i+" value='"+ddns[i][2]+"' onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') onblur=chk_username('"+obj_id[2]+i+"','"+img_id[2]+i+"','"+div_id[2]+i+"',"+i+")>",div_id[2]+i);
			data[3]= draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input type=password size=20 maxlength=32 id="+obj_id[3]+i+" onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') value='"+ddns[i][3]+"' onblur=chk_passwd('"+obj_id[3]+i+"','"+img_id[3]+i+"','"+div_id[3]+i+"',"+i+")>",div_id[3]+i);
			data[4]= draw_td(O_VAR,ICONLINE,img_id[4]+i,"<input size=20 maxlength=32 id="+obj_id[4]+i+" onMouseMove=showHint('"+img_id[4]+i+"','"+div_id[4]+i+"',event) onMouseOut=hideHint('"+div_id[4]+i+"') value='"+ddns[i][4]+"' onblur=chk_domainname('"+obj_id[4]+i+"','"+img_id[4]+i+"','"+div_id[4]+i+"',"+i+")>",div_id[4]+i);
			data[5]= draw_td(O_VAR,ICONLINE,img_id[5]+i,ddns[i][5],div_id[5]+i);
			data[6]= draw_td(O_VAR,ICONLINE,img_id[6]+i,ddns[i][0]=="1"?ddns[i][6]:"",div_id[6]+i);
			edit_row(td_id,data,i);
		}
	}
}

function chk_tzo_key(val)
{
        if(!preg_match('^[A-Za-z0-9]+$',val))
        {
                return false;
        }
        return true;    
}

function uiDoSave(F){
        if(ddns_check(F,"save") == true){
                if ( fill_ddns_value(F) ) 
                {
                        F.submit_button.value="ddns";
                        F.gui_action.value="Apply";
                        F.submit();
                        parent.document.getElementById("save_bg").style.display="";
                }
        }
}

function to_update(F)
{
        if(ddns_check(F,"update") == true){
                if ( fill_ddns_value(F) ) 
                {
                        F.change_action.value = "gozila_cgi";
                        F.submit_button.value = "ddns";
                        F.submit_type.value = "update";
                        F.gui_action.value = "Apply";
                        F.submit();
			parent.document.getElementById("save_bg").style.display="";
                }
        }
}


function chk_email(flg,val)
{
        var objname = "", msgname="";
        
        if ( flg == "tzo" )  
        {
                objname = "ddns_username_2";
                msgname = "msg_tzo_name";
        }else{
                objname = "ddns_username_5";
                msgname = "msg_noip_name";
        }
        clear_msg(objname,msgname);
        if(!my_valid_email(val,objname,msgname))
                return false;
        

        return true;
}

function chk_domainname(obj_id,img_id,div_id,index)
{
	clear_table_msg("tmsg",img_id,obj_id,index);
        if ( !check_domain(document.getElementById(obj_id).value) ) 
        {
		table_msg(img_id,obj_id,div_id,index,__T(msg.validname));
                return false;
        }
        return true;
}

function valid_defname(val)
{
        if ((val.length < 1) || (val.length > 63))
                return __T(msg.validname);
                
        if(!preg_match('^[A-Za-z0-9\\-_]+$',val))
                return __T(msg.hostnameformat1);

        if (val.charAt(0) == "-" || val.charAt(0) == "_" )
                return __T(msg.hostnameformat1);
        return "";

}

function chk_username(obj_id,img_id,div_id,index)
{
	clear_table_msg("tmsg",img_id,obj_id,index);
	var return_msg = "";
	if ( index == 0 || index == 3 ) 
	{
		if ( !valid_email(document.getElementById(obj_id).value))
		   	return_msg = __T(syslog.emailfail);
	}else{
	        return_msg = valid_defname(document.getElementById(obj_id).value);
	}
        if ( return_msg != "" )
        {
		table_msg(img_id,obj_id,div_id,index,return_msg);
                return false;
        }
        return true;
}

function chk_passwd(obj_id,img_id,div_id,index)
{
	clear_table_msg("tmsg",img_id,obj_id,index);
	var return_msg = "";
	if ( index == 0 ) 
	{
		if ( !chk_tzo_key(document.getElementById(obj_id).value) ) 
			return_msg = __T(msg.nameformat);
	}else
	        return_msg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_id).value,ZERO_NO|SPACE_OK);
        if ( return_msg != "" )
        {
		table_msg(img_id,obj_id,div_id,index,return_msg);
                return false;
        }
        return true;
}

function ddns_check(F,I)
{
	var errflg = 0;
	for(var i=0; i<4; i++)
	{
		if ( document.getElementById(obj_id[0]+i) )
		{
			if ( document.getElementById(obj_id[0]+i).checked == false &&
			     document.getElementById(obj_id[2]+i).value == "" && 
			     document.getElementById(obj_id[3]+i).value == "" &&
			     document.getElementById(obj_id[4]+i).value == "" )
				continue;
			if ( !chk_username(obj_id[2]+i,img_id[2]+i,div_id[2]+i,i) ) errflg=1;
			if ( !chk_passwd(obj_id[3]+i,img_id[3]+i,div_id[3]+i,i) ) errflg=1;
			if ( !chk_domainname(obj_id[4]+i,img_id[4]+i,div_id[4]+i,i) ) errflg=1;
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

function fill_ddns_value(F) 
{
	var name_list = new Array("ddns_enable", "ddns_passwd", "ddns_username", "ddns_hostname");
	var val_list = new Array(0,3,2,4);
	for(var i=0; i<4; i++)
	{
		for(var j=0; j<name_list.length; j++)
		{
		if ( document.getElementById(obj_id[0]+i) )
		{
			if ( j == 0 ) 
			{
				if ( document.getElementById(obj_id[val_list[j]]+i).checked == true ) 
					eval("F."+name_list[j]+"_"+(i+1)).value = 1; 
				else
					eval("F."+name_list[j]+"_"+(i+1)).value = 0; 
			}else{
			//	alert("i="+i+"j="+j+";"+document.getElementById(obj_id[val_list[j]]+i).value);
				if ( name_list[j] == "ddns_passwd" && 
				     document.getElementById(obj_id[val_list[j]]+i).value != "" ) 
				{
					eval("F."+name_list[j]+"_"+(i+1)).value = encode64(document.getElementById(obj_id[val_list[j]]+i).value);
				}
				else
					eval("F."+name_list[j]+"_"+(i+1)).value = document.getElementById(obj_id[val_list[j]]+i).value;
			}
			//alert("i="+i+"j="+j+";"+document.getElementById(obj_id[val_list[j]]+i).value);
		}/*
		else{
			if ( j == 0 ) 
			{
				if ( document.getElementById(td_id[val_list[j]]+i).innerHTML == __T(filter.yes) ) 
					eval("F."+name_list[j]+"_"+(i+1)).value = 1; 
				else
					eval("F."+name_list[j]+"_"+(i+1)).value = 0; 
			}else{
				if ( name_list[j] == "ddns_passwd" ) 
					eval("F."+name_list[j]+"_"+(i+1)).value = encode64(document.getElementById(td_id[val_list[j]]+i).innerHTML);
				else
					eval("F."+name_list[j]+"_"+(i+1)).value = document.getElementById(td_id[val_list[j]]+i).innerHTML;
			}
		//	alert(">>i="+i+"j="+j+";"+document.getElementById(td_id[val_list[j]]+i).innerHTML);
		}*/
		}
	}
	return true;
}
</script>
</head>
<body onload="init();">
<FORM autocomplete=off id=frm name=frmddns method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ddns_update_interval>
<input type=hidden name=ddns_passwd_1>
<input type=hidden name=ddns_passwd_2>
<input type=hidden name=ddns_passwd_3>
<input type=hidden name=ddns_passwd_4>
<input type=hidden name=ddns_enable_1>
<input type=hidden name=ddns_enable_2>
<input type=hidden name=ddns_enable_3>
<input type=hidden name=ddns_enable_4>
<input type=hidden name=ddns_username_1>
<input type=hidden name=ddns_username_2>
<input type=hidden name=ddns_username_3>
<input type=hidden name=ddns_username_4>
<input type=hidden name=ddns_hostname_1>
<input type=hidden name=ddns_hostname_2>
<input type=hidden name=ddns_hostname_3>
<input type=hidden name=ddns_hostname_4>

<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.ddns),"colspan=2");</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wan.forceupdate));</script>
		<script>
                var _name = new Array(__T(mang.never),__T(logemail.schweek),__T(mang.semimonthly),__T(mang.monthly));
                var _val = new Array("no","1w","hm","1m");
                draw_object(O_GUI,SELBOX,"ddns_update_interval","",_name,_val,"<% nvram_get("ddns_update_interval"); %>");
                </script>	
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.edit),"to_edit(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.testconfig),"to_update(this.form)");
		
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,5,10,15,15,15,15,15",__T(wan.ddnsservicetb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(share.enable)+","+__T(filter.servicename)+","+__T(mang.usernameoremail)+","+__T(share.password)+","+__T(wan.hostdomainname)+","+__T(wan.interipaddr)+","+__T(share.sts)+"","",bt_list,"","","2,2,0,0,0,0,0,0");
		</script>
		</TR>
		
        </TABLE>
	<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
