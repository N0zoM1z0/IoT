<html>
<head>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var data = new Array();
<% get_authap_data("data","noauth"); %>
var td_id = new Array("td_mac","td_ssid","td_sec","td_encry","td_auth","td_network","td_ch");
var obj_id = new Array("mac","ssid","sec","encry","auth","network","ch");
var img_id = new Array("img_mac","img_ssid","img_sec","img_encry","img_auth","img_network","img_ch");
var div_id = new Array("div_mac","div_ssid","div_sec","div_encry","div_auth","div_network","div_ch");
var sec_val = new Array(0,1,2,3,4,5);
var sec_name = new Array(__T(wl.open),__T(wl.wep),__T(wl.wpap),__T(wl.wpae),__T(wl.wpa2p),__T(wl.wpa2e));
var network_name = new Array(__T(wl.bgn),__T(wl.bonly),__T(wl.gonly),__T(wl.nonly),__T(wl.bgmixed),__T(wl.gnmixed));
var network_val = new Array(5,0,1,2,3,4);
var _name_len=11; // +1 -> Auto
if ( country=="EU" ) 
{
	var channel_name = new Array("1","2","3","4","5","6","7","8","9","10","11","12","13");
	var channel_val = new Array("1","2","3","4","5","6","7","8","9","10","11","12","13");
}
else
{
	var channel_name = new Array("1","2","3","4","5","6","7","8","9","10","11");
	var channel_val = new Array("1","2","3","4","5","6","7","8","9","10","11");
}
//var channel_name = new Array(__T(share.auto),"2.412","2.417","2.422","2.427","2.432","2.437","2.442","2.447","2.452","2.457","2.462","2.467","2.472","2.477");
var country = "<% nvram_get("wl_country_code"); %>";
var rname;
/*
for(var i=0; i<channel_name.length; i++)
{
	if ( i > 0 )
        	channel_name[i] = channel_name[i]+" "+__T(unit.ghz);
}
if ( country=="EU" ) 
	_name_len = 13;
//var channel_val = new Array("ISRANGE",1,_name_len+1,1);
var tmp_name = new Array();
for(var i=0; i<channel_name_len; i++) 
{
	if ( now_lang != "EN" ) 
        	channel_name[i] = str_replace("\\.",",",channel_name[i]);
        if ( i == 0 ) tmp_name[i] = channel_name[i];
        else tmp_name[i] = i+"-"+channel_name[i];
}*/
var encry_name = new Array(__T(share.none),__T(wl.tkip),__T(mang.ccmp));
var encry_val = new Array(0,2,4);
var auth_name = new Array(__T(share.none),__T(wl.psk),__T(wl.radius));
var auth_val = new Array(0,2,1);
var idx=0;
var auth_stflg="initauth";
var datalist = new Array();
<% get_authap_data("datalist","auth"); %>
var authlist = new Array();
var unauthlist = new Array();
var delay_time=0;
function fill_init_value(index, arr_name, type)
{
	var new_arr_name = new Array();
	new_arr_name[index] = new Array();
	new_arr_name[index][0] = arr_name[index][0];
	new_arr_name[index][1] = cy_speccode_decode(arr_name[index][1]);
	new_arr_name[index][2] = sec_name[parseInt(eval(arr_name[index][2]),10)];
	if ( eval(arr_name[index][3]) == "2")
		new_arr_name[index][3] = encry_name[1];
	else if ( eval(arr_name[index][3]) == "4")
		new_arr_name[index][3] = encry_name[2];
	else
		new_arr_name[index][3] = encry_name[0];
	if ( eval(arr_name[index][4]) == "2")
		new_arr_name[index][4] = auth_name[1];
	else if ( eval(arr_name[index][4]) == "1")
		new_arr_name[index][4] = auth_name[2];
	else
		new_arr_name[index][4] = encry_name[0];
        for(var j=0; j<network_val.length; j++)
        {
                if ( network_val[j] == parseInt(eval(arr_name[index][5]),10) ) 
                {
			 new_arr_name[index][5] = network_name[j];
                         break;
                }
        }
	//new_arr_name[index][6] = channel_name[parseInt(eval(arr_name[index][6]),10)];
	new_arr_name[index][6] = arr_name[index][6];
	new_arr_name[index][7] = transtime(arr_name[index][7]);
	if( type == "init" ) 
		new_arr_name[index][8] = "-1";
	else
		new_arr_name[index][8] = index;
	return new_arr_name[index];
}

function init()
{
	if (typeof init_page != "undefined" && init_page == 1 )
	{
		
		if ( "<% nvram_get("rogue_ap_enable"); %>" == "1" ) 
		{
			parent.document.getElementById("save_bg").style.display="";
			parent.document.getElementById("upload_msg").innerHTML = __T(wan.detecting);
			setTimeout("reload();", 12000);	
			return;
		}
	}
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("upload_msg").innerHTML = __T(msg.upload);
	document.getElementById("tmsg").style.display="none";
	var F = document.frm_authap;
	for(var i=0; i<datalist.length; i++)
	{
		authlist[i] = new Array;
		authlist[i] = fill_init_value(i,datalist,"init");
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=authchk_"+idx+" onclick=chk_click('"+idx+"')>",3);
		tmp[1] = new Array(td_id[0]+idx, authlist[i][0],3);
		tmp[2] = new Array(td_id[1]+idx, authlist[i][1]);
		tmp[3] = new Array(td_id[2]+idx, authlist[i][2],3);
		tmp[4] = new Array(td_id[3]+idx, authlist[i][3],3);
		tmp[5] = new Array(td_id[4]+idx, authlist[i][4],3);
		tmp[6] = new Array(td_id[5]+idx, authlist[i][5],3);
		tmp[7] = new Array(td_id[6]+idx, authlist[i][6],3);
		tmp[8] = new Array("","&nbsp;");
		add_row(idx,tmp,"authchk_","initauth",2);
		idx++;
		
	}
	chk_existed_list(F);
	if ( data.length == 0 ) 
	{
		choose_disable(document.getElementById("chk_de_all"));
		choose_disable(document.getElementById("a1"));
	}	
	delay_time = 1000*F.fresh_rate[F.fresh_rate.selectedIndex].value;
	if ( delay_time > 0 ) 
		timerID = setTimeout('reload();', delay_time);
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("e1"));
		choose_disable(document.getElementById("e2"));
	}
	default_nv = keep_val(F,"");

}

function reload(){
	goto_page("authap.asp");
}

function disable_all_chk()
{
	choose_disable(document.getElementById("chkall"));
	for(var i=0; i<idx; i++)
	{
		choose_disable(document.getElementById("authchk_"+i));
	}
}

function add_auth_data(index)
{
	if ( idx >= AUTHAP_ENTRY ) 
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,AUTHAP_ENTRY,__T(wl.authaps)),"");
		return false;	
	}
	var tmp = new Array();
	auth_stflg = "autoauth";
	authlist[idx] = new Array;
	authlist[idx] = fill_init_value(index, data, "autoadd");
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=authchk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx, unauthlist[index][0],3);
	tmp[2] = new Array(td_id[1]+idx, unauthlist[index][1]);
	tmp[3] = new Array(td_id[2]+idx, unauthlist[index][2],3);
	tmp[4] = new Array(td_id[3]+idx, unauthlist[index][3],3);
	tmp[5] = new Array(td_id[4]+idx, unauthlist[index][4],3);
	tmp[6] = new Array(td_id[5]+idx, unauthlist[index][5],3);
	tmp[7] = new Array(td_id[6]+idx, unauthlist[index][6],3);
	tmp[8] = new Array("","&nbsp;");
	add_row(idx,tmp,"authchk_","initauth",2);
	idx++;
	choose_disable(document.getElementById("t2"));
	disable_all_chk();
	
	
}

function to_edit()
{
	auth_stflg = "editauth";
	var F = document.frm_authap;
	for(var i=0; i<idx; i++){
		if( document.getElementById("authchk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			var tmp = new Array();
			tmp[0]= draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=17 id="+obj_id[0]+i+" onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value='"+datalist[i][0]+"' disabled>",div_id[0]+i);
			tmp[1]= draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=20 maxlength=32 id="+obj_id[1]+i+" onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value='"+cy_speccode_decode(datalist[i][1])+"' disabled>",div_id[1]+i);
			tmp[2] = draw_td(O_VAR,ICONLINE,img_id[2]+i,draw_object(O_VAR,SELBOX,obj_id[2]+i," onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"')",sec_name,sec_val,datalist[i][2]),div_id[2]+i);
			tmp[3] = draw_td(O_VAR,ICONLINE,img_id[3]+i,draw_object(O_VAR,SELBOX,obj_id[3]+i," onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"')",encry_name,encry_val,datalist[i][3]),div_id[3]+i);
			tmp[4] = draw_td(O_VAR,ICONLINE,img_id[4]+i,draw_object(O_VAR,SELBOX,obj_id[4]+i," onMouseMove=showHint('"+img_id[4]+i+"','"+div_id[4]+i+"',event) onMouseOut=hideHint('"+div_id[4]+i+"')",auth_name,auth_val,datalist[i][4]),div_id[4]+i);
			tmp[5] = draw_td(O_VAR,ICONLINE,img_id[5]+i,draw_object(O_VAR,SELBOX,obj_id[5]+i," onMouseMove=showHint('"+img_id[5]+i+"','"+div_id[5]+i+"',event) onMouseOut=hideHint('"+div_id[5]+i+"')",network_name,network_val,datalist[i][5]),div_id[4]+i);
			tmp[6] = draw_td(O_VAR,ICONLINE,img_id[6]+i,draw_object(O_VAR,SELBOX,obj_id[6]+i," onMouseMove=showHint('"+img_id[6]+i+"','"+div_id[6]+i+"',event) onMouseOut=hideHint('"+div_id[6]+i+"')",channel_name,channel_val,datalist[i][6]),div_id[4]+i);
	        	edit_row(td_id,tmp,i);
			
		}
	}
}

function chk_click(index){
        to_check("authchk_",document.getElementById("authchk_"+index).checked,index,idx,auth_stflg,td_id,authlist[index]);
}


function to_add()
{
	if ( idx >= AUTHAP_ENTRY ) 
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,AUTHAP_ENTRY,__T(wl.authaps)),"");
		return false;	
	}
	if ( !chk_before_data(idx-1) ) return false;
	var F = document.frm_authap;
	auth_stflg="addauth";
	var tmp = new Array();
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=authchk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=17 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	tmp[2]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=20 maxlength=32 id="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx),1);
	tmp[3]=new Array(td_id[2]+idx,draw_object(O_VAR,SELBOX,obj_id[2]+idx+" id='"+obj_id[2]+idx+"'","",sec_name,sec_val),3);
	tmp[4]=new Array(td_id[3]+idx,draw_object(O_VAR,SELBOX,obj_id[3]+idx+" id='"+obj_id[3]+idx+"'","",encry_name,encry_val),3);
	tmp[5]=new Array(td_id[4]+idx,draw_object(O_VAR,SELBOX,obj_id[4]+idx+" id='"+obj_id[4]+idx+"'","",auth_name,auth_val),3);
	tmp[6]=new Array(td_id[5]+idx,draw_object(O_VAR,SELBOX,obj_id[5]+idx+" id='"+obj_id[5]+idx+"'","",network_name,network_val),3);
	tmp[7]=new Array(td_id[6]+idx,draw_object(O_VAR,SELBOX,obj_id[6]+idx+" id='"+obj_id[6]+idx+"'","",channel_name,channel_val),3);
	tmp[8] = new Array("","&nbsp;");
	add_row(idx,tmp,"authchk_","addauth",2);
	idx++;
}

function chk_before_data(flg)
{
	if ( document.getElementById(obj_id[0]+flg) )
	{
		var errflg=0;
		var errmac = valid_macs_all(document.getElementById(obj_id[0]+flg).value);	
		if ( errmac != "" ){
			table_msg(img_id[0]+flg,obj_id[0]+flg,div_id[0]+flg,flg,errmac);
			errflg++;
		}
		var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_id[1]+flg).value,ZERO_NO);
		if ( returnmsg != "" ) 
		{
	               table_msg(img_id[1]+flg,obj_id[1]+flg,div_id[1]+flg,flg,returnmsg);     
		       errflg++;
		}
		if ( errflg != 0 ) return false;
	}
	var ssid_a, mac_a, ssid_b, mac_b, objsel;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById(obj_id[0]+i) ) 
		{
			mac_a = mac12to17(document.getElementById(obj_id[0]+i).value);
			ssid_a = document.getElementById(obj_id[1]+i).value;
			objsel=i;
		}else{
			mac_a = mac12to17(document.getElementById(td_id[0]+i).innerHTML);
			ssid_a = document.getElementById(td_id[1]+i).innerHTML;
		}
		for(j=i+1; j<idx; j++)
		{
			if ( document.getElementById(obj_id[0]+j) ){ 
				mac_b = mac12to17(document.getElementById(obj_id[0]+j).value);
				ssid_b = document.getElementById(obj_id[1]+j).value;
				objsel=j;
			}else{
				mac_b = mac12to17(document.getElementById(td_id[0]+j).innerHTML);
				ssid_b = document.getElementById(td_id[1]+j).innerHTML;
			}
			//alert("mac_a="+mac_a+";mac_b="+mac_b+";ssid_a="+ssid_a+";ssid_b="+ssid_b);
			if ( mac_a == mac_b && ssid_a == ssid_b ) 
			{
	               		table_msg(img_id[0]+objsel,obj_id[0]+objsel,div_id[0]+objsel,objsel,__T(msg.valueexist));                   	              table_msg(img_id[1]+objsel,obj_id[1]+objsel,div_id[1]+objsel,objsel,__T(msg.valueexist));     			    	    return false;
			}
		}
	}

	return true;
}

function num_cnt(val)
{
	if ( parseInt(val.length,10) < 10 ) 
	{
		return "0"+val.length;
	}	
	return val.length;
}

function get_value(F)
{
	var tmp="";
	for(var j=0; j<idx; j++)
	{
		if ( auth_stflg == "delauth")
		{
                        if ( document.getElementById("tr_tableauth_"+j).className == "TABLECONTENT_DEL" )
			{
				if ( tmp != "" ) tmp+=";";
				for(var i=0; i<obj_id.length; i++)
				{
					if ( i>0 ) tmp+=",";
					tmp += num_cnt(datalist[j][i])+datalist[j][i];
				}
			}
		}
		else if ( auth_stflg == "autoauth")
		{
			if ( tmp != "" ) tmp+=";";
			for(var k=0; k<7; k++)
			{
				if ( k>0 ) tmp+=",";
				if ( authlist[j][8] == "-1" ) 
					tmp+= num_cnt(datalist[j][k])+datalist[j][k];
				else
					tmp += num_cnt(data[authlist[j][8]][k])+data[authlist[j][8]][k];
			}
		}
		else if ( document.getElementById(obj_id[1]+j) )
		{
			if ( tmp != "" ) tmp+=";";
			for(var i=0; i<obj_id.length; i++)
			{
				if ( i>0 ) tmp+=",";
				tmp += num_cnt(document.getElementById(obj_id[i]+j).value)+document.getElementById(obj_id[i]+j).value;
			}
		}
	}
	return tmp;

}

function to_del()
{
	auth_stflg = "delauth";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("authchk_"+i).checked == true ) 
			del_row("auth_"+i);
		
	}

}

function transtime(sys_time)
{
	var day="",hours="",mins="",secs="";
	day = parseInt(sys_time/(24*60*60),10);
	var tmp = sys_time%(24*60*60);
	hours = parseInt(tmp/(60*60),10);
	tmp = tmp%(60*60);
	mins = parseInt(tmp/60,10);
	secs = parseInt(tmp%60,10);
	return spell_words(datetime1_rule,day,hours,mins,secs);
	
}

function uiDoSave(F){
	if ( auth_stflg != "delauth" ) 
	{
		if ( !chk_before_data(idx-1) ) return false;
	}
	F.auth_ap.value = get_value(F);
	F.stflg.value = auth_stflg;
	F.submit_button.value="authap";
	F.gui_action.value="Apply";
	//alert(F.auth_ap.value);
	//return;
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function chk_existed_list(F)
{
	for(var i=0; i<data.length; i++)
	{
		for(var j=0; j<datalist.length; j++)
		{
			if ( data[i][0] == datalist[j][0] )
			{
				eval("F.chk_de_"+i).checked = true;
				break;
			}
		}
	}
}

function to_auth(F)
{
	var is_existed = 0;
	for(var i=0; i<data.length; i++)
	{
		if ( eval("F.chk_de_"+i).checked == true ) 
		{
			is_existed = 0;
			for(var j=0; j<idx; j++)
			{
				if ( authlist[j][0] == data[i][0] )
				{
					is_existed = 1;
					break;
				}
			}
			if ( is_existed == 0 ) 
				add_auth_data(i);
		}
	}
}

function sel_url(obj)
{
        document.getElementById("txtUploadFile").value = getPath(obj);
	if ( document.getElementById("txtUploadFile").value.length > 5 ) 
		choose_enable(document.getElementById("e1"));
	if ( http_power == "r" ) 
		choose_disable(document.getElementById("e1"));

}


function to_import(F)
{
	var IMAGE = F.importrogueap.value.toLowerCase();
        var len = F.importrogueap.value.length;
        var ext = new Array('.','c','s','v');
	F.submit_button.value = "authap";	
	for (var i=0; i < 4; i++)   {
 		if (ext[i] != IMAGE.charAt(len-4+i)){
                	 my_alert(O_VAR,"txtUploadFile",__T(msg.invalidftype),"0","msg_file");
                         return false;
	        }
        }
	F.action = goto_link("import.cgi");
    	F.encoding="multipart/form-data";
	if ( F.import_type[0].checked == true ) choose_disable(F.import_merge); 
	if ( F.import_type.value == "0" ) //MARGE
	{
		if ( idx >= AUTHAP_ENTRY ) 
		{
			my_alert(O_PAGE,INFO,spell_words(max_rule,AUTHAP_ENTRY,__T(wl.authaps)),"");
			return false;	
		}
	}
        F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
function chk_all_unauth(F)
{
	for(var i=0; i<data.length; i++)
	{
		if ( F.chk_de_all.checked == true ) 
			eval("F.chk_de_"+i).checked = true;
		else
			eval("F.chk_de_"+i).checked = false;
	}
}

function chk_all(F)
{
        for (var i=0; i<idx; i++)
	{
		if ( F.chkall.checked == true ) 
			eval("F.authchk_"+i).checked = true;
		else
			eval("F.authchk_"+i).checked = false;
        	to_check("authchk_",document.getElementById("authchk_"+i).checked,i,idx,auth_stflg,td_id,authlist[i]);
	}
}

function to_download(F)
{
	window.location.href="Authorized_AP_Template.csv";
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_authap" method=<% get_http_method(); %>>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=import_merge>
<input type=hidden name=auth_ap>
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<input type=hidden name=all_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.rogueap));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.freshrate));</script>
                <script>
                var _name = new Array(__T(share.nofresh),spell_words(sec_rule,"15"),spell_words(sec_rule,"30"),spell_words(sec_rule,"60"));
                var _val = new Array("0","15","30","60");
                draw_object(O_GUI,SELBOX,"fresh_rate","",_name,_val,"<% nvram_get("fresh_rate_auth"); %>");
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.detectrogue));
		var _name=new Array(__T(share.on),__T(share.off));
		var _val=new Array("1","0");
		draw_object(O_GUI,RADIO,"rogue_ap_enable",_val,_name,"<% nvram_get("rogue_ap_enable"); %>");
		</script>
		</TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
		var bt_list = new Array();
		bt_list[0] = new Array("BT","a1",__T(wl.authorize),"to_auth(this.form)");
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"3,15,20,8,8,10,15,8",__T(wl.detectroguetb),"<input type=checkbox name=chk_de_all id=chk_de_all onclick=chk_all_unauth(this.form)>,"+__T(share.macaddr)+","+__T(wl.ssid)+","+__T(wl.security)+","+__T(wl.encryption)+","+__T(wan.auth)+","+__T(wl.networkmode)+","+__T(wl.ch),"",bt_list,"","","2,2,0,2,2,2,2,2","","");
		var tmp = new Array();
		var tmplist = new Array();
		for(var i=0; i<data.length; i++)
		{
			var k=0;
			unauthlist[i] = new Array();
			unauthlist[i] = fill_init_value(i,data);
			/*
			tmp[k++] = new Array("tdachk"+i,"<input type=checkbox id=chk_de_"+i+">");
			tmp[k++] = new Array("tdamac"+i,data[i][0],3);
			tmp[k++] = new Array("tdassid"+i,data[i][1]);
			tmp[k++] = new Array("tdasecurity"+i,sec_name[parseInt(data[i][2],10)],3);
			if ( data[i][3] == "2")
				tmp[k++] = new Array("tdaencry"+i,encry_name[0],3);
			else if ( data[i][3] == "4")
				tmp[k++] = new Array("tdaencry"+i,encry_name[1],3);
			else
				tmp[k++] = new Array("tdaencry"+i,__T(logemail.authnone),3);
			if ( data[i][4] == "2")
				tmp[k++] = new Array("tdaauth"+i,auth_name[0],3);
			else if ( data[i][4] == "1")
				tmp[k++] = new Array("tdaauth"+i,auth_name[1],3);
			else
				tmp[k++] = new Array("tdaauth"+i,__T(logemail.authnone),3);
			var flg=0;
		        for(var j=0; j<network_val.length; j++)
		        {
                		if ( network_val == parseInt(data[i][5],10) ) 
		                {
		                         flg = j;
                		         break;
		                }
		        }
			tmp[k++] = new Array("tdanet"+i,network_name[flg],3);
			tmp[k++] = new Array("tdachan"+i,channel_name[parseInt(data[i][6],10)],3);
			tmp[k++] = new Array("tdatime"+i,transtime(data[i][7]));*/
			tmp[k++] = new Array("tdachk"+i, "<input type=checkbox id=chk_de_"+i+">");
			tmp[k++] = new Array("tdamac"+i,unauthlist[i][0],3);
			tmp[k++] = new Array("tdassid"+i,unauthlist[i][1]);
			tmp[k++] = new Array("tdasecurity"+i,unauthlist[i][2],3);
			tmp[k++] = new Array("tdaencry"+i,unauthlist[i][3],3);
			tmp[k++] = new Array("tdaauth"+i,unauthlist[i][4],3);
			tmp[k++] = new Array("tdanet"+i,unauthlist[i][5],3);
			tmp[k++] = new Array("tdachan"+i,unauthlist[i][6],3);
			tmp[k++] = new Array("","&nbsp;");
			//tmp[k++] = new Array("tdatime"+i,unauthlist[i][7],3);
			add_row(i,tmp,"chk_","add",2);
		}
//		document.getElementById("tmsg").style.display="none";
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"3,15,15,8,8,10,15,8",__T(wl.authaptb),"<input type=checkbox id=chkall name=chkall onclick=chk_all(this.form)>,"+__T(share.macaddr)+","+__T(wl.ssid)+","+__T(wl.security)+","+__T(wl.encryption)+","+__T(wan.auth)+","+__T(wl.networkmode)+","+__T(wl.ch)+"","add,edit,del","","","auth","2,2,0,2,2,2,2,2");
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.importlist));</script></TR>   
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.importbt));
		var _name=new Array(__T(mang.replace),__T(mang.merge));
		var _val=new Array("1","0");
		draw_object(O_GUI,RADIO,"import_type",_val,_name,"1");
		</script>
		</TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.localfilep));</script>
		<div style="position:relative;">
		<input name=importrogueap id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<script>
			document.write("<INPUT type=text id=txtUploadFile name=browser size=");
			if ( Browser == "IE" ) document.write("28");
			else document.write("20");
			document.write(" style=\"position:absolute;background-color:#cecaca;margin:0; height:20px\">");
		</script>
		<span id=msg_file style="position:absolute;left:250px"></span>
                <script>
		if ( Browser == "IE" ) 
		{
	                draw_object(O_GUI,BT,__T(router.browse),"t6 id=t6 style='position:absolute;left:175px;top:0px'","BT","");
		}
		else
		{
	                draw_object(O_GUI,BT,__T(router.browse),"t6 id=t6 style='position:absolute;left:140px;top:0px'","BT","");
		}
		</script>
		</div>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>&nbsp;</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");
                draw_object(O_GUI,BT,__T(mang.importbt),"e1","BT","to_import(this.form)");
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.downloadauthap),SPACE_DOWN,SPACE_DOWN);
                	draw_object(O_GUI,BT,__T(mang.downloadlink),"e2","BT","to_download(this.form)");
		</script>
		</TD></TR>
        </TABLE>
<% web_include_file("BT.asp"); %>
<input type=hidden name=all_end>
</TABLE>
</div>
</form>
</body></HTML>
