function create_title()
{
	var str = "";
	str = "<TR><TD class=CONTENT_TITLE_L colspan=2>"+__T(mang.vpnsetupwizard);
	str += "</TD></TR>";
	document.write(str);

}
function create_process_title(pass_item, sel_item)
{
	var str="",note="";
	var imgstyle="style=display:none";
	var itemstyle="ITEMS";
	str = "<TR height=30px bgolor=blue valign=top>";
	
	var name_list = new Array(__T(wz.vpnitem1),__T(wz.vpnitem2),__T(wz.vpnitem3),__T(wz.vpnitem4),__T(wz.vpnitem5),__T(wz.vpnitem6));
	for(var i=0; i<name_list.length; i++)
	{
		note="";
		imgstyle="style=display:none";
		itemstyle="ITEMS";
		if ( parseInt(sel_item,10) == (i+1) ) itemstyle = "ITEMS_SEL";
		if ( parseInt(pass_item,10) >= (i+1) ) 
		{
			imgstyle="";
			itemstyle = "ITEMS_CHK";
		}
		if ( i != 2 && i != 1) note = "nowrap";
		str += "<TD align=center><TABLE><TR><TD id=item"+(i+1)+" "+imgstyle+"><img src=../image/acknowledge.png></TD><TD class="+itemstyle+" "+note+">"+name_list[i]+"</TD></TR></TABLE></TD>"; 
	}
        str += "</TR>"
	document.write(str);
}

function create_button(bt_back,bt_next,bt_submit)
{
	var str = "";
	var back_style="", next_style="";
	str = "<TR><TD colspan=2 class=DATA_BT>";
	str += draw_object(O_VAR,BT,__T(share.back),"w1","BT",bt_back);
    	str += "&nbsp;&nbsp;";
	if ( typeof bt_submit != "undefined" && bt_submit != "")
		str += draw_object(O_VAR,BT,__T(share.submit),"w2","BT",bt_submit);
	else
		str += draw_object(O_VAR,BT,__T(share.next),"w2","BT",bt_next);
    	str += "&nbsp;&nbsp;";
	str += draw_object(O_VAR,BT,__T(share.cancel),"w3","BT","onClick=uiDoCancel(this.form)");
    	str += "</TD></TR>";
	document.write(str);
}

function HelpDialog(url,obj_height,obj_width)
{
	var propStr = "width="+obj_width+"px,height="+obj_height+"px,resizable=no,toolbar=no,menubar=no,scrollbars=no,directories=no,location=no,status=no";
	window.open(url,"_blank",propStr);
}

function cmp_data(objname)
{
	var def_tmp = parse_data(objname,1);
	var tmp = parse_data(objname);
	if ( def_tmp != tmp ) 
	{
	//	alert("objname="+objname+"\ndef_tmp="+def_tmp+"\ntmp="+tmp);
		return false;
	}
	return true;
}

function wizard_before_leave(chgval,defval,level)
{
	//alert("defval="+defval+"\nchgval="+chgval);
	if ( http_power == "r" ) return true;
	if ( defval == "def_nv" ) return true; // not yet get initial value 
	if ( defval.length != chgval.length ) return false;
	if ( defval != chgval ) return false;
        var nv_list = new Array("wan_proto","time_zone","ntp_mode","ntp_manual_time","def_hwaddr","mac_clone_enable");
        var nv_list2 = new Array("wl_ssid_0","security_mode","crypto","wpa_psk");
	var def_tmp="";
	
	if ( typeof level == "undefined" ) 
	{
		for(var i=0; i<nv_list.length; i++)
		{
			if ( !cmp_data(nv_list[i]) ) return false;
			if ( nv_list[i] == "ntp_mode" && parse_data("ntp_mode",1) == "manual" ) 
				if ( !cmp_data("ntp_manual_time") ) return false;
			def_tmp = parse_data("wan_proto",1);
			if ( nv_list[i] == "wan_proto" && def_tmp != "dhcp" && def_tmp != "static" ) 
			{
				if ( !cmp_data("ppp_username") ) return false;
				if ( !cmp_data("ppp_passwd") ) return false;
			}
			if ( nv_list[i] == "wan_proto" && def_tmp != "dhcp" ) 
			{
				if ( !cmp_data("wan_ipaddr") ) return false;
				if ( !cmp_data("wan_netmask") ) return false;
				if ( !cmp_data("wan_gateway") ) return false;
				if ( !cmp_data("wan_dns") ) return false;
			}
			if ( nv_list[i] == "wan_proto" && def_tmp == "l2tp" ) 
				if ( !cmp_data("l2tp_server_ip") ) return false;
			if ( nv_list[i] == "wan_proto" && def_tmp == "pptp" ) 
				if ( !cmp_data("pptp_server_ip") ) return false;
		}
	}else if ( level == 2 ) 
	{
		for(var i=0; i<nv_list2.length; i++)
		{
			if ( !cmp_data(nv_list2[i]) ) return false;
		}
	}
	return true;
}


function parse_data(keyword,flg)
{
	if ( typeof flg != "undefined" ) 
		var save_value = parent.document.getElementById("def_wizard_var").value;
	else
		var save_value = parent.document.getElementById("wizard_var").value;
	if (  save_value.length == 0 ) return "";
	else{
		var idx = save_value.indexOf(keyword);
		var newdata = "";
		if ( idx == -1 ) return ""; // Cannot find data
		if ( keyword == save_value.substring(idx,keyword.length+idx))
		{
			newdata = save_value.substring(idx,keyword.length+idx+3);
			var tmpdata = newdata.split("=");
			var len = parseInt(tmpdata[1],10);
			newdata = save_value.substring(idx,keyword.length+idx+3+1+len);
			tmpdata = newdata.split(":");
			return tmpdata[1];
		}
		
	}
}

function save_data(objname,objval,flg)
{
	var data = parent.document.getElementById("wizard_var").value;
	var tmpcnt=0;
	var data2="";
	var idx = data.indexOf(objname);
	var initflg=0;
	if ( typeof flg != "undefined" ) initflg =1;
	if ( objval.length < 10 )  tmpcnt="0"+objval.length;
	else tmpcnt=objval.length;
	if ( data.length = 0 || idx == -1 ) 
	{
		parent.document.getElementById("wizard_var").value += objname+"="+tmpcnt+":"+objval;
		if ( initflg == 1 ) parent.document.getElementById("def_wizard_var").value += objname+"="+tmpcnt+":"+objval;
	}else{
		if ( objname == data.substring(idx,objname.length+idx))
                {
                        newdata = data.substring(idx,data.length+idx+3);
                        var tmpdata = newdata.split("=");
                        var len = parseInt(tmpdata[1],10);
                        newdata = data.substring(idx,objname.length+idx+3+1+len);
                }
		if ( idx > 0 ) 
		{
			data2 = data.substring(0,idx);
			data2 += data.substring(idx+newdata.length,data.length+idx);
		}else{
			data2 = data.substring(idx+newdata.length,data.length+idx);
		}
		data2 += objname+"="+tmpcnt+":"+objval;
				
		parent.document.getElementById("wizard_var").value = data2;
		if ( initflg == 1 )  parent.document.getElementById("def_wizard_var").value = data2;
	}
}

function go_page(aging_time,getting_start)
{
	if( parseInt(aging_time,10) == 1)
	{
		parent.frames['fun'].location.href = goto_link("/change_password_tree.asp");
		parent.frames['content_area'].location.href = goto_link("/change_password.asp");
	}
	if ( parent.frames['content_area'].location.href.indexOf("wizard.asp")!=-1 )
	{
		top.location.href = goto_link("/default.asp");
		/*
		if ( getting_start ) 
		{
			get_position("getstart.asp",1);
		}else{
			get_position("dashboard.asp",1);
		}*/
	}
	parent.document.getElementById("wizard_bg").style.display="none";
	
}

function w_valid_ip(type,obj,rule,span_id,flag,direct){
	var tmp_range = rule.split(".");
	var ip_range = "";
	var errflg=0;
	var wan_ip="";
	var m = new Array(4);
	for(var i=0; i<4; i++)
	{
		m[i]="0";
		if ( document.getElementById(obj+"_"+i).value != "" ) 
			m[i] = document.getElementById(obj+"_"+i).value;
		if ( i > 0 ) wan_ip+=".";
		wan_ip+=m[i];
	
	}
	if( m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0" ){
		if ( (flag & ZERO_OK)) return true;
	}
	w_clear_alert(span_id,4,obj);
	
	//check valid IP range
	for(var i=0; i<4; i++)
	{
		//clear message 
		errflg=0;
		ip_range = tmp_range[i].split("-");
		
		if ( !chk_range(obj+"_"+i,document.getElementById(obj+"_"+i).value,ip_range[0],ip_range[1],10) ) errflg=1;

		if ( errflg ) 
		{
		 	w_set_alert(span_id,0,obj+"_"+i,spell_words(range_rule,ip_range[0],ip_range[1]),direct);
			return false;	
		}
	}
	var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
	
	if ( obj!="gw" && lan_ip == wan_ip ) 
	{
		 w_set_alert(span_id,4,obj,__T(msg.subnet3),direct);
		 return false;
	}
	return true;
}

function w_set_alert(span_id,obj_cnt,obj,msg,direct)
{
	document.getElementById(span_id).className="ERRMSG";
	if ( msg.length > 0 )
	{
		if ( typeof direct != "undefined" && direct == "down" ) 
		{
			document.getElementById(span_id).innerHTML = "<img src=../image/iconDownArrowRed.gif style='padding-right:5px'>"+msg+"<BR>";
		}else{
		        document.getElementById(span_id).innerHTML="<img src=../image/ContextMessageArrow_LeftT.gif style='padding-right:5px;height:16px'>"+msg;	
		}
	}
	if ( obj_cnt == 0 ) 
		document.getElementById(obj).style.backgroundColor="#ffff99";
	else{
		for(var i=0; i<obj_cnt; i++)
			document.getElementById(obj+"_"+i).style.backgroundColor="#ffff99";
	}
}
function w_clear_alert(span_id,obj_cnt,obj)
{
	document.getElementById(span_id).className="";
	document.getElementById(span_id).innerHTML="";
	if ( obj_cnt == 0 ) 
		document.getElementById(obj).style.backgroundColor="";
	else{
		for(var i=0; i<obj_cnt; i++)
			document.getElementById(obj+"_"+i).style.backgroundColor="";
	}

}

function w_valid_mask(obj,flag,span_id,direct)
{
	var match0 = -1;
	var match1 = -1;
	var tmp_range = VALID_IP_RULE2.split(".");
	var ip_range = "";
	var errflg=0;
	var m = new Array(4);
	w_clear_alert(span_id,0,obj);
	
	m = document.getElementById(obj).value.split(".");
	for(var i=0; i<4; i++)
	{
		ip_range = tmp_range[i].split("-");
		if ( !chk_range(obj,m[i],ip_range[0],ip_range[1],10) )
			errflg=1;
	}
	if( m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0" ){
		if ( flag & ZERO_NO ) errflg=1;		
		else if ( flag & ZERO_OK ) return true;
	}
	if(m[0] == "255" && m[1] == "255" && m[2] == "255" && m[3] == "255"){
		if ( flag & BCST_NO )
			errflg = 1;
		else if ( flag & BCST_OK ) return true;
	}
	if ( errflg == 0 ) 
	{
		for(i=3;i>=0;i--){
        	        for(j=1;j<=8;j++){
                	        if((m[i] % 2) == 0)   match0 = (3-i)*8 + j;
                        	else if(((m[i] % 2) == 1) && match1 == -1)   match1 = (3-i)*8 + j;
	                        m[i] = Math.floor(m[i] / 2);
        	        }
	        }
        	if(match0 > match1)errflg=1;
	}
	if ( errflg == 1 )
	{
		//w_set_alert(span_id,4,obj,__T(msg.maskillegal),direct);
		return false;
	}
	return true;
		
}

function pptp_l2tp_valid(F)
{
        var errflg=0;
        var tmp_ip, tmp_mask;
        var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
        w_clear_alert("msg_accname",0,"accname");
        w_clear_alert("msg_pwd",0,"pwd");
	
        if ( F.accname.value == "" ) 
        {
                errflg=1;
                w_set_alert("msg_accname",0,"accname",__T(msg.notblank),"down");        
        }
        if ( F.pwd.value == "" )
        {
                errflg=1;
                w_set_alert("msg_pwd",0,"pwd",__T(msg.notblank),"down");        
        }else{
		if ( F.pwd.value != F.cf_pwd.value ) 
		{
                	errflg=1;
	                w_set_alert("msg_pwd",0,"pwd",__T(wz.cmppwdnotmatch),"down");        
		}
	}
        if ( !w_valid_ip("IP","ip",VALID_IP_RULE1,"msg_ip",ZERO_NO,"down") ) errflg=1;
        if ( !w_valid_ip("IP","gw",VALID_IP_RULE1,"msg_gw",ZERO_NO,"down") )errflg=1;
        if ( !w_valid_ip("IP","sip",VALID_IP_RULE1,"msg_sip",ZERO_NO,"down") ) errflg=1;
        if ( !w_valid_mask("mask",ZERO_NO|BCST_NO,"msg_mask","down"))errflg=1;
        if ( errflg == 0 ) 
        {
                for(var i=0; i<4; i++)
                {
                        if ( i > 0 ) tmp_ip+=".";
                        tmp_ip+=document.getElementById("ip_"+i).value;
                        if ( i > 0 ) tmp_mask+=".";
                        tmp_mask+=document.getElementById("mask_"+i).value;
                }       
                if ( valid_subnet(tmp_ip,tmp_mask,lan_ip) )
                {
                        w_set_alert("msg_ip",4,"ip",__T(msg.subnet1),"down");  
                        errflg=1;
                } 
                if ( errflg==0 && !valid_ip_gw(F,"F.ip","F.mask","F.gw") ){ 
                        w_set_alert("msg_ip",4,"ip",__T(msg.subnet2),"down");       
                        w_set_alert("msg_gw",4,"gw","");        
//                      w_set_alert("msg_gw",4,"gw",__T(msg.subnet2));  
                        errflg=1;
                }       
           }
           if ( errflg == 1 ) return false;
           return true;
}

