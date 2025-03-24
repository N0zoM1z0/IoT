<html>
<head>
<title>Wireless MAC Filter</title>
<% update_current_selected_ssid(); %>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var back_bt = "true";
var change_cancel_bt="true";
<% wl_multi_nvram_get("wl_ssid"); %>
<% wl_multi_nvram_get("wl_macfilter_allow"); %>
<% wl_multi_nvram_get("wl_maclist"); %>
<% wl_multi_nvram_get("wl_macfilter_enable"); %>
var now_idx = "<% nvram_gozila_get("wl_vap_idx"); %>";
if ( now_idx == "" ) now_idx = "0";
var row_cnt=parseInt(WL_MAC_ENTRY/3,10);
if ( WL_MAC_ENTRY%3 != 0 ) row_cnt+=1;
var client_info = new Array();
var err=0;
<% get_mac_table(); %>
function AAA(name,ip,mac,status)
{
	this.name = name;
        this.ip = ip;
        this.mac = mac;
        this.status = status;
}
<% close_wireless_active_table("all_table"); %>

function refresh_page()
{
	alert_result(0);
	var F = document.frmmac;
	F.submit_button.value = "Wireless_MAC";
	F.change_action.value = "gozila_cgi";
	F.next_page.value = "Wireless_MAC.asp";
	F.submit();
}

function to_back(F){
	parent.document.getElementById("newpage").value = "Wireless_Manual.asp";
	uiDoCancel(F,"back");
}

function init(){
	var idx;
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmmac;
        document.getElementById("WL_MAC").style.display="none";
	en_filter(F);
	default_nv = keep_val(F,"");
}

function ViewFilter(){
        SHOW_HIDDEN_TABLE("table_title","WL_MAC","tb_img",__T(wl.showlist),__T(wl.hidelist));
}

function clear_mac_msg(){
	var tmpi=0;
	for(var j=0; j<row_cnt; j++)
	{
		for(i=0; i<3; i++)
		{
			tmpi=(i*j+i);
			clear_table_msg("tmsg","i"+tmpi,"m"+tmpi,j);
		}
	}
}

function valid_value(F){
	var cnt=0;
	var errflg = 0 ;
	var errmsg="";
	clear_mac_msg();
	for(var i=0; i<WL_MAC_ENTRY; i++)
	{
		if ( eval("F.m"+i).value != "" ) 
		{
			errmsg = valid_macs_all(eval("F.m"+i).value);
			if ( errmsg != "" ) 
			{
				table_msg("img_id"+i,"m"+i,"div_id"+i,i,errmsg);
				errflg = 1;	
			}
			cnt++;
		}
	}
	if ( cnt == 0  && F._macfilter_enable.checked == true ) 
	{
		table_msg("img_id0","m0","div_id0","0",__T(msg.mac8));
		return false;
	}
	if ( errflg == 1 ) return false;
	F.wl_macfilter_list.value = WL_MAC_ENTRY;
	return true;
}

function uiDoSave(F){
	if ( err == 1 ) return false;
	if ( !valid_value(F) ) return false;
	F.wl_macfilter_enable.value = 0;
	if ( F._macfilter_enable.checked == true ) 
		F.wl_macfilter_enable.value = 1;
	
	F.submit_button.value = "Wireless_MAC";
	F.gui_action.value="Apply";
	F.next_page.value = "Wireless_Manual";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_add(){
	var F=document.frmmac;
	var errflg = 0 ;
	var mac_list = "";
	var count=0;
	for(var i=0; i<WL_MAC_ENTRY; i++)
	{
		if ( eval("F.m"+i).value == "" ) continue;
		if ( mac_list != "" ) mac_list += " ";
		mac_list += eval("F.m"+i).value;
		count++;
	}
	if ( count >= WL_MAC_ENTRY ) 
	{
		my_alert(O_GUI,ERROR,__T(share.errmsg),spell_words(max_rule,WL_MAC_ENTRY,__T(wl.macaddrs)));
		return false; 
	}
	for(var j=0; j<client_info.length; j++)
	{
		if ( eval("F.on"+j).checked == true ) 
		{
			errflg = 0;
			for(var i=0; i<WL_MAC_ENTRY; i++)
			{
				if ( eval("F.m"+i).value == "" ) continue;
				if ( str_replace(":","",client_info[j].mac) == eval("F.m"+i).value ) 
				{
					errflg = 1 ;
					break;
				}
			}
			if ( errflg == 0 )
			{
				eval("F.m"+count).value = str_replace(":","",client_info[j].mac);
				count++;
			}
		}
	}
	
}

function en_filter(F){
	if ( F._macfilter_enable.checked == true ) 
		DISABLE_PART(F,"hidden_start","hidden_end",0);	
	else
		DISABLE_PART(F,"hidden_start","hidden_end",1);	
}
function chk_mac(index){
	var F = document.frmmac;
	var errmsg=""
        var cmpdata = new Array();
	if ( eval("F.m"+index).value == "" ) return true;
	clear_table_msg("tmsg","img_id"+index,"m"+index,index);
	for(var i=0; i<WL_MAC_ENTRY; i++)
        {
                if (document.getElementById("m"+i) == null && document.getElementById("td_id"+i) == null ) continue;
                if (document.getElementById("m"+i) == null )
                        cmpdata[i] = document.getElementById("div_id"+i).innerHTML;
                else
                        cmpdata[i] = document.getElementById("m"+i).value;
        }

        for(var j=0; j<cmpdata.length; j++)
        {
                if ( document.getElementById("m"+j) )
                        document.getElementById("m"+j).style.display="";
                if ( j == index ) continue;
                if ( cmpdata[index] == cmpdata[j] )
                {
                        table_msg("img_id"+index,"m"+index,"div_id"+index,index%11,__T(msg.macexist));
			err = 1;
                        return false;
                }
        }

	errmsg = valid_macs_all(eval("F.m"+index).value);
	if ( errmsg != ""){
		table_msg("img_id"+index,"m"+index,"div_id"+index,index%11,errmsg);
		return false;
	}	
	err = 0;
	return true;
}
</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm method=<% get_http_method(); %> name=frmmac action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=next_page>
<input type=hidden name=wl_macfilter_enable>
<input type=hidden name=wl_macfilter_list>
<input type=hidden name=nvset_cgi value="wireless">
<input type=hidden name=wl_vap_idx value="<% nvram_gozila_get("wl_vap_idx"); %>">
<input type=hidden name=basic_idx value="<% nvram_gozila_get("basic_idx"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(wl.mactitle));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.ssid));
		document.write(eval("nv_wl_ssid_"+now_idx));
		</script>
		</td></tr>			
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.mactitle));</script>
		<script>
		chkflg = "";
		if ( eval("nv_wl_macfilter_enable_"+now_idx) == '1' ) chkflg = "checked"; 
		document.write("<input type=checkbox name=_macfilter_enable "+chkflg+" onClick=en_filter(this.form)>");
		 Capture(share.enable);</script>
		</td></tr>	
		<input type=hidden name=hidden_start>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.conncontrol));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
			var NAME = new Array(__T(wl.prevent)+"<BR>",__T(wl.permit));
			var VAL = new Array("0","1");
			draw_object(O_GUI,RADIO,"wl_macfilter_allow",VAL,NAME,eval("nv_wl_macfilter_allow_"+now_idx));
		</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_object(O_GUI,TABLE_BT,"tb_img","ViewFilter()","table_title",__T(wl.showlist));
		document.write("<INPUT type=hidden value=0 name=login_status>");
		</script>
		</td></tr>					
		<TR id=WL_MAC><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(wl.addtomac),"to_add()");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,20,20,20,20",__T(wl.clientlist),__T(wl.cname)+","+__T(share.ipaddr)+","+__T(share.macaddr)+","+__T(share.sts)+","+__T(wl.savetolist),"",bt_list,"","clist","0,0,2,2,2");
 	        var wl_maclist = eval("nv_wl_maclist_"+now_idx);
                var macs = new Array();
                macs = wl_maclist.split(' ');
                var check = "";
		var data = new Array();
                for(var i=0;;i++)
	        {
                        if(client_info.length == i) break;		
			if(client_info[i].status == "online")
	                        client_info[i].status = __T(share.connected);
                        else if (client_info[i].status == "offline")
                                client_info[i].status = __T(share.disconnected);
                        check = "";
                        for(var j=0 ; j<macs.length ; j++)
                        {
 	                       if(macs[j] == client_info[i].mac)
                               {
        	                       check = "checked";
                                       break;
                               }
                        }
			data[0] = new Array("td_cname"+i,client_info[i].name);
			data[1] = new Array("td_cip"+i,client_info[i].ip);
			data[2] = new Array("td_cmac"+i,client_info[i].mac,3);
			data[3] = new Array("td_cmac"+i,client_info[i].status,3);
			data[4] = new Array("td_chk"+i,"<INPUT type=checkbox value="+client_info[i].mac+" name=on"+i+" id=on"+i+" "+check+">",3);
			add_row(i,data,"","addclist",2);
		}
                </script>
	        </TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"6,27,6,27,7,27",__T(wl.mactb),__T(share.no)+","+__T(share.macaddr)+","+__T(share.no)+","+__T(share.macaddr)+","+__T(share.no)+","+__T(share.macaddr),"","","","","2,0,2,0,2,0");
		var item,showitem="",obj_val="";
		var tmp = new Array();
		var new_data = eval("nv_wl_maclist_"+now_idx);
		var datalist = new_data.split(" ");
		for(var i=0; i<row_cnt; i++)
		{
			var k=0;
			for(j=0; j<3; j++)
			{
				item = parseInt(i+(row_cnt*j),10); 
				showitem = (parseInt(item,10)+1);
				if ( showitem < 10 ) showitem = "0"+showitem;
				obj_val="";
				if ( datalist.length > item ) 
					obj_val = datalist[item];
				if ( item >= WL_MAC_ENTRY )
				{
					tmp[0+k]=new Array("tdno_"+item, "&nbsp;", 3);
					tmp[1+k]=new Array("tdmac_"+item, "&nbsp;", 3);
				}else{
					tmp[0+k]=new Array("tdno_"+item, showitem, 3);
					tmp[1+k] = new Array("tdmac_"+item,draw_td(O_VAR,ICONLINE,"img_id"+item,"<input size=17 maxlength=17 name=m"+item+" id=m"+item+" value='"+obj_val+"' onblur=chk_mac('"+item+"') onMouseMove=showHint('img_id"+item+"','div_id"+item+"',event) onMouseOut=hideHint('div_id"+item+"') tabindex="+showitem+" >","div_id"+item));
				}
				k+=2;
			}
			add_row(i,tmp,"","add",2);
		}
		if ( document.getElementById("tmsg") )
			document.getElementById("tmsg").innerHTML = "";
		</script>
		</TD></TR>
		<input type=hidden name=hidden_end>
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
