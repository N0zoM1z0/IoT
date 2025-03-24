<html>
<head>
<% web_include_file("filelink.asp"); %>
<script>
var EDIT_MODE = 0 ;
var cmp_arr = new Array();
<% get_vlan_list("cmp_arr"); %>

CHK_VALUE_AUTO=0;
var idx=0;
var stflg="init";
var OBJECT=1;
var TEXT=2;
var cmp_val = new Array();

var _name = new Array(__T(lan.untagged),__T(lan.tagged),__T(lan.excluded));
var _val = new Array("0","1","2");
var td_id=new Array("_vlan","_desc","_port1_","_port2_","_port3_","_port4_");
var obj_id=new Array("vid","desc","port1_","port2_","port3_","port4_");
var img_id=new Array("img_vlan","img_desc","img_port1_","img_port2_","img_port3_","img_port4_");
var div_id=new Array("div_vlan","div_desc","div_port1_","div_port2_","div_port3_","div_port4_");

var gn_enable="<% nvram_get("gn_enable"); %>";
var nv_gn_enable_0 = "<% nvram_get("gn_0_enable"); %>";
var nv_gn_enable_1 = "<% nvram_get("gn_1_enable"); %>";
var nv_gn_enable_2 = "<% nvram_get("gn_2_enable"); %>";
var nv_gn_enable_3 = "<% nvram_get("gn_3_enable"); %>";
<% wl_multi_nvram_get("wl_vlan_id"); %>

function chk_valid_desc(index)
{
	clear_table_msg("tmsg",img_id[1]+index,obj_id[1]+index,index);
 	var cmpdata = new Array();
	
	if ( document.getElementById(obj_id[1]+index) && document.getElementById(obj_id[1]+index).value==""){
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index, index,__T(msg.illegal));
                return false;	
	}
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id[1]+index).value,ZERO_NO,obj_id[1]+index);
	if ( returnmsg != "" ) 
	{
		table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index, index,returnmsg);
                return false;	
	}
        for(var i=0; i<idx; i++)
        {
                if (document.getElementById(obj_id[1]+i) == null && document.getElementById(td_id[1]+i) == null ) continue;
                if (document.getElementById(obj_id[1]+i) == null )
                        cmpdata[i] = document.getElementById(td_id[1]+i).innerHTML;
                else
                        cmpdata[i] = document.getElementById(obj_id[1]+i).value;
        }
	for(var j=0; j<cmpdata.length; j++)
        {
		clear_table_msg("tmsg",img_id[1]+j,obj_id[1]+j,j);
		if ( document.getElementById(obj_id[1]+j) ) 
			document.getElementById(obj_id[1]+j).style.display="";
                if ( j == index ) continue;
                if ( cmpdata[index] == cmpdata[j] )
                {
			if ( document.getElementById(obj_id[1]+index) ) 
				table_msg(img_id[1]+index,obj_id[1]+index,div_id[1]+index,index,__T(msg.descexist));
			if ( document.getElementById(obj_id[1]+j) ) 
				table_msg(img_id[1]+j,obj_id[1]+j,div_id[1]+j,j, __T(msg.descexist));
                        return false;
                }
	}
        return true;

}

function chk_valid_vid(index)
{
	var errmsg="";
	var cmpdata = new Array();
	clear_table_msg("tmsg",img_id[0]+index,obj_id[0]+index,index);
	if (document.getElementById(obj_id[0]+index) && document.getElementById(obj_id[0]+index).value=="") 
		errmsg=spell_words(range_rule,VLAN_ID_START,VLAN_ID_TO);
	if ( errmsg == "" ) 
	{
		if ( chk_chartype(document.getElementById(obj_id[0]+index).value,DIGIT) == FAIL )
                	errmsg=spell_words(digit_rule,"VLAN ID");
                if ( chk_range(obj_id[0],document.getElementById(obj_id[0]+index).value,VLAN_ID_START,VLAN_ID_TO) == FAIL )
                        errmsg=spell_words(range_rule,VLAN_ID_START,VLAN_ID_TO);
		if ( errmsg == "")
		{
		for(var i=0; i<idx; i++)
		{
			if (document.getElementById(obj_id[0]+i) == null && document.getElementById(td_id[0]+i) == null ) continue;
			if (document.getElementById(obj_id[0]+i) == null ) 
				cmpdata[i] = document.getElementById(td_id[0]+i).innerHTML;
			else
				cmpdata[i] = document.getElementById(obj_id[0]+i).value;
		}	
		for( var k=1; k<vid_reserve.length; k++)
	        {
        		if ( parseInt(cmpdata[index],10) == vid_reserve[k] )
                	{
				errmsg=__T(msg.vidreserved);
				break;
                	}
	        }
		if ( errmsg == "" ) 
		{
			for(var j=0; j<cmpdata.length; j++)
			{
				if ( j == index ) continue;
				//if ( ((cmpdata[index] & 0xF) == cmpdata[j]))
				//{
				//	errmsg=__T(msg.invalidvid);
				//	break;
				//}
				if ( parseInt(cmpdata[index],10) == parseInt(cmpdata[j],10) ) 
				{
					errmsg=__T(msg.videxist);
					errid=j;
					break;
				}
			}
		}
		if ( parseInt(cmpdata[index],10) == "<% nvram_get("wantag_vid"); %>" ) 
			errmsg=__T(msg.videxist);
		}
	}
	if ( errmsg != "" ) 
	{
		table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,errmsg);
		return false;
	}
	return true;
}

var del_count=0;
var show_exclude_msg=-1;
var vlan_id=0;
function get_data(F)
{
	var str,data="",tmp="";
	var count=0;
	var alldata="";
	var u_vid=0;
	var errflg=0;
	var obj_vid=0;
	for(var i=0; i<5; i++)
		eval("F.vlan_"+i).value = "";

	for(var i=0; i<idx; i++)
	{
        	if (document.getElementById("tr_table"+i) == null ) continue;
		if ( stflg == "del" ) 
		{
			if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
			{
				del_count++;
				if ( F.vlan_del_group.value != "" ) F.vlan_del_group.value+=" ";
				F.vlan_del_group.value += document.getElementById(td_id[0]+i).innerHTML;
				continue;		
			}
		}
		data = "";
		if (document.getElementById(obj_id[0]+i) == null && document.getElementById(td_id[0]+i) == null) continue; 
		if (document.getElementById(obj_id[0]+i) == null ) 
			tmp = parseInt(document.getElementById(td_id[0]+i).innerHTML,10);
		else{
			if ( !chk_valid_vid(i) ) errflg=1;
			tmp = parseInt(document.getElementById(obj_id[0]+i).value,10);
		}
		data += tmp;
		vlan_id = tmp;
		var ex_cnt=0;
		for(var j=0; j<4; j++)
		{
			clear_table_msg("tmsg",img_id[2+j]+i,obj_id[2+j]+i,i);
			if ( data != "" ) data+=",";
			str = document.getElementById(obj_id[2+j]+i);
			if ( str == null )
			{
				if ( document.getElementById(td_id[2+j]+i).innerHTML == __T(lan.untagged) ) 
					tmp="0";
				else if ( document.getElementById(td_id[2+j]+i).innerHTML == __T(lan.tagged) )
					tmp = "1";
				else{
					tmp = "2";
				}
			}else{
				tmp = document.getElementById(obj_id[2+j]+i).selectedIndex;
				if ( tmp == "2" ) ex_cnt++; 
			}
			if ( tmp == "0" ) // Untagged
			{
				if ( u_vid == 0 ) obj_vid = j;
                                if ( u_vid&(2<<j+1) )
                                {
					if ( document.getElementById(img_id[2+j]+i) )
						table_msg(img_id[2+j]+i,obj_id[2+j]+i,div_id[2+j]+i,i,string_break(30,__T(msg.onlyoneuntagged)));
					else if ( document.getElementById(img_id[2+j]+obj_vid) )
					{
						table_msg(img_id[2+j]+obj_vid,obj_id[2+j]+obj_vid,div_id[2+j]+obj_vid,obj_vid,string_break(30,__T(msg.onlyoneuntagged)));
					}
                                        errflg=1;
					
                                 }
                                 u_vid=u_vid|2<<(j+1);
			}
			data += tmp;
		}
		if ( ex_cnt == 4 ) 
			show_exclude_msg = vlan_id;

		if ( data != "" ) data+=",";
		str = document.getElementById(obj_id[1]+i);
		if ( str == null ) 
		{
			tmp = cy_speccode_decode(document.getElementById(td_id[1]+i).innerHTML);	
		}else{
			if ( !chk_valid_desc(i) ) errflg = 1;
			tmp = document.getElementById(obj_id[1]+i).value;
		}
		
		data += tmp;
		if ( alldata != "" ) alldata +=";";
		alldata += data;
		eval("F.vlan_"+count).value = data;
		count++;
	}
	if ( errflg == 1 )
	{
		document.getElementById("tmsg").innerHTML = __T(share.tableerrmsg);
		return "";
	}
	return alldata;
}

function uiDoSave(F)
{
	clear_all_msg();
	if ( !get_data(F) ) return false;
	if ( stflg == "del" && del_count == 0 ) return false;
	if ( show_exclude_msg != -1 ) 
     		my_alert(O_GUI,WARNING,__T(share.info),spell_words(vlan_ex_rule,show_exclude_msg),"vlan_alert_result(1)","vlan_alert_result(0)","","yesno");
	else if ( stflg == "del" && del_count > 0 ) 
	{
        	my_alert(O_GUI,WARNING,__T(share.info),__T(msg.delvlan),"vlan_alert_result(1)","vlan_alert_result(0)","","yesno");
	}
	else
		vlan_alert_result(1);
}

function vlan_alert_result(val){
	var F = document.sdhcp;
	alert_result(0);
	var rstp_port1_enable = "<% nvram_get("rstp_port1_enable"); %>"; 
	var rstp_port2_enable = "<% nvram_get("rstp_port2_enable"); %>"; 
	var rstp_port3_enable = "<% nvram_get("rstp_port3_enable"); %>"; 
	var rstp_port4_enable = "<% nvram_get("rstp_port4_enable"); %>"; 
	var rstp_port1_edge = "<% nvram_get("rstp_port1_edge"); %>"; 
	var rstp_port2_edge = "<% nvram_get("rstp_port2_edge"); %>"; 
	var rstp_port3_edge = "<% nvram_get("rstp_port3_edge"); %>"; 
	var rstp_port4_edge = "<% nvram_get("rstp_port4_edge"); %>"; 
	if ( val == 1 ) 
	{
		F.gui_action.value = "Apply";
		F.submit_button.value = "vlan_membership";
		F.submit();
		var waitflg=0;
                for(var i=1; i<=4; i++)
                {
                        if ( eval("rstp_port"+i+"_enable") == "1" && eval("rstp_port"+i+"_edge") == "0" ) 
                        {
                                window.parent.savebg_init();
                                parent.document.getElementById("save_time_bg").style.display="";
                                waitflg = 1;
                	        break;
        	        }
                }
                //if( waitflg == 0 ) 	
			parent.document.getElementById("hidden_bg").style.display="";
	}
}

function chk_before_data(index)
{
	errflg=0;
	if ( document.getElementById(obj_id[2]+index) ) 
	{
		if ( !chk_valid_desc(index) ) errflg = 1;
		if ( !chk_valid_vid(index) ) errflg = 1;
	}
	if ( errflg == 1 ) return false;
	return true;
}

function to_add()
{
	if ( idx >= VLAN_ENTRY )
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,VLAN_ENTRY,__T(lan.vlans)),"");
		return false;	
	}
	stflg="add";
	if ( !chk_before_data(idx-1) ) return false;
	var tmp= new Array();
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,fun_create_obj("ID",idx),div_id[0]+idx,"","align=right"),2);
	tmp[2]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,fun_create_obj("DESC",idx),div_id[1]+idx,"","align=left"),1);
	for(var j=0; j<4; j++)
	{
		tmp[3+j]=new Array(td_id[2+j]+idx,draw_td(O_VAR,ICONLINE,img_id[2+j]+idx,fun_create_obj("PORT",idx,j,"1"),div_id[2+j]+idx,"","align=center"),3);
	}
	tmp[3+j]=new Array("","&nbsp;",0);
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function init()
{
	parent.document.getElementById("hidden_bg").style.display="none";
	var tmp = new Array();
	if ( ap_mode == "0" ) 
	{
	for(var i=0; i<cmp_arr.length; i++)
	{
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"')>",3);
		tmp[1]=new Array(td_id[0]+i,cmp_arr[i][0],2);
		if ( i == 0 ) 
			tmp[2]=new Array(td_id[1]+i,__T(def.words)); 
		else
			tmp[2]=new Array(td_id[1]+i,cmp_arr[i][1],0);
		var j=0;
		for(j=0; j<4; j++)
			tmp[3+j]=new Array(td_id[2+j]+i,_name[cmp_arr[i][2+j]],3);
		tmp[3+j]=new Array("","&nbsp;",0);
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	}
	//For change without save 
	default_nv = get_data(document.sdhcp);
	parent.document.getElementById("save_bg").style.display="none";
}

function VLAN_USED(cmp_id)
{
	for(var i=0; i<4; i++)
	{
		//alert(cmp_id+";"+eval("nv_wl_vlan_id_"+i));
		if ( cmp_id == eval("nv_wl_vlan_id_"+i) ) 
			return true;
	}
	if ( cmp_id == "<% nvram_get("wantag_vid"); %>" ) 
	{
		return true;
	}
	return false;
}

function to_del()
{
	stflg="del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			if ( i == 0 ){
				my_alert(O_PAGE,WARNING,__T(msg.deldef));
				break;
			}
			if ( VLAN_USED(cmp_arr[i][0]) ){
				my_alert(O_PAGE,WARNING,__T(wl.delvidmsg));
				return;
			}
			if ( IS_GUEST(cmp_arr[i][0]) ){
				my_alert(O_PAGE,WARNING,__T(lan.msgdelguest));
				return;
			}
			else
				del_row(i,0);
		}
	}
}
function clear_all_msg(){
	document.getElementById("page_msg_td").style.display="none";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById(obj_id[1]+i) != null ) 
			document.getElementById(obj_id[1]+i).style.backgroundColor ="";
		if ( document.getElementById(obj_id[0]+i) != null ) 
			document.getElementById(obj_id[0]+i).style.backgroundColor ="";
		for(var j=0; j<4; j++)
		{
			if ( document.getElementById(obj_id[2+j]+i) != null ) 
				document.getElementById(obj_id[2+j]+i).style.backgroundColor ="";
		}
	}
}

function fun_create_obj()
{
	var args = new Array;
	for(var i=0; i<4; i++)
	{
		args[i] = arguments[i];
		args[i] = typeof(args[i])!='undefined'?args[i]:'';
	}
	if ( args[0] == "ID" ) 
	{
		return "<input size=3 id="+obj_id[0]+args[1]+" onBlur=chk_valid_vid('"+args[1]+"') onMouseMove=showHint('"+img_id[0]+args[1]+"','"+div_id[0]+args[1]+"',event) onMouseOut=hideHint('"+div_id[0]+args[1]+"') value='"+args[2]+"'>";
	}
	else if ( args[0] == "DESC" ){
		return "<input size=20 id="+obj_id[1]+args[1]+" onBlur=chk_valid_desc('"+args[1]+"') maxlength="+VLANNAME_MAX_LEN+" onMouseMove=showHint('"+img_id[1]+args[1]+"','"+div_id[1]+args[1]+"',event) onMouseOut=hideHint('"+div_id[1]+args[1]+"') value='"+args[2]+"'>";
	}
	else if ( args[0] == "PORT" )
	{
		return draw_object(O_VAR,SELBOX,obj_id[2+parseInt(args[2],10)]+args[1],"onChange=clear_all_msg() onMouseMove=showHint('"+img_id[2+parseInt(args[2],10)]+args[1]+"','"+div_id[2+parseInt(args[2],10)]+args[1]+"',event) onMouseOut=hideHint('"+div_id[2+parseInt(args[2],10)]+args[1]+"') id="+obj_id[2+parseInt(args[2],10)]+args[1],_name,_val,args[3]);
	}
}

function IS_GUEST(cmp_id)
{
	if ( GUESTNET_SUPPORT == 0 ) return false; 
	for(var j=0; j<4; j++)
	{
		if ( eval("nv_gn_enable_"+j) == "1" ) 
		{
			if ( cmp_id == eval("nv_wl_vlan_id_"+j) ) 
				return true;
		}	
	}
	return false;
	
}

function to_edit(){
	stflg="edit";
	var edit_able=1;	
	for(var i=0; i<idx; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[1]+i) == null )
		{
			if ( IS_GUEST(cmp_arr[i][0]) ){
				my_alert(O_PAGE,WARNING,__T(lan.msgdelguest));
				return;
			}
			var data = new Array();
			edit_able=1;	
			for(var k=0; k<4; k++)
			{
				if ( i == 0 || eval("nv_wl_vlan_id_"+k) == cmp_arr[i][0] ) 
				{
					edit_able=0;
					break;
				}
			}
			if ( edit_able == 1 ) 
			{
				data[0] = draw_td(O_VAR,ICONLINE,img_id[0]+i,fun_create_obj("ID",i,cmp_arr[i][0]),div_id[0]+i);
				data[1] = draw_td(O_VAR,ICONLINE,img_id[1]+i,fun_create_obj("DESC",i,cmp_arr[i][1]),div_id[1]+i);
			}
			for(var j=0; j<4; j++)
			{
				data[2+j] = draw_td(O_VAR,ICONLINE,img_id[2+j]+i,fun_create_obj("PORT",i,j,cmp_arr[i][2+j]),div_id[2+j]+i);
			}
			edit_row(td_id,data,i);
		}
	}
}

function chk_click(index){
	var nv_arr = new Array();
	for(var i=0; i<cmp_arr[index].length; i++)
	{
		if ( i < 2 ) 
			nv_arr[i] = cmp_arr[index][i];
		else
			nv_arr[i] = _name[cmp_arr[index][i]];
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,nv_arr);
}

</script>
</head>
<body onload="init();">
<FORM autocomplete=off id=frm name=sdhcp method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=chgflg>
<input type=hidden name=vlan_del_group>
<input type=hidden name=vlan value=1> <!--For Save VLAN Entry-->
<input type=hidden name=vlan_0> <!--For Save VLAN Entry-->
<input type=hidden name=vlan_1> <!--For Save VLAN Entry-->
<input type=hidden name=vlan_2> <!--For Save VLAN Entry-->
<input type=hidden name=vlan_3> <!--For Save VLAN Entry-->
<input type=hidden name=vlan_4> <!--For Save VLAN Entry-->
<SPAN id=create_obj></SPAN>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.vlanmembership));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T(lan.vlans));</script></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		document.write(__T(lan.vlanmsg1)+"<BR>"+__T(lan.vlanmsg2)+" "+spell_words(vlan_range_rule,VLAN_ID_START,VLAN_ID_TO));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		/*if ( ap_mode == "1" )
		{
			draw_td(O_GUI,CREATE_EDIT_TABLE,"7,10,20,20",__T(lan.vlansettb),""+__T(share.sel)+","+__T(lan.vlanid)+","+__T(lan.vlandesc)+","+__T(mang.wanport)+"","add,edit,del","","","","2,1,0,2,2,2,2");
		}else{*/
			draw_td(O_GUI,CREATE_EDIT_TABLE,"7,10,20,15,15,15,15",__T(lan.vlansettb),""+__T(share.sel)+","+__T(lan.vlanid)+","+__T(lan.vlandesc)+","+spell_words(port_rule,1)+","+spell_words(port_rule,2)+","+spell_words(port_rule,3)+","+spell_words(port_rule,4)+"","add,edit,del","","","","2,1,0,2,2,2,2");
		//}
		</script>
		</TR>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
