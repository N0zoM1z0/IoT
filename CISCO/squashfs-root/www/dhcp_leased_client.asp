<html>
<head>
<title>DHCP Leased Clients</title>
<% web_include_file("filelink.asp"); %>
</head>

<script>
var td_id=new Array("td_hostname","td_ipaddr","td_mac");
var data = new Array();
var tmp = "<% nvram_get("vlan_group"); %>".replace(/\s*$/,"");
var vlan_group = tmp.split(" ");
<% dumpleases("data"); %>

var lan_arr = new Array();
function LAN(vlan_id,ipaddr,netmask,proto,dhcprelay_ip,start_ip,user_num,lease_time,dns1,dns2,dns3,wins)
{
        this.vlan_id = vlan_id;
        this.ipaddr = ipaddr;
        this.netmask = netmask;
        this.proto = proto;
        this.dhcprelay_ip = dhcprelay_ip;
        this.start_ip = start_ip;
        this.user_num = user_num;
        this.lease_time = lease_time;
        this.dns1=dns1;
        this.dns2=dns2;
        this.dns3=dns3;
        this.wins=wins;
}
<% get_lan_data("lan_arr"); %>
<% dhcp_static_get("all"); %>

var totalcnt=0;

function init(){
  parent.document.getElementById("save_bg").style.display="none";
  for(var i=0; i<vlan_group.length; i++)
  {
	if (typeof eval("data_"+vlan_group[i]) != 'undefined' ) 
		to_add(vlan_group[i],eval("data_"+vlan_group[i]), eval("dhcp_static_"+vlan_group[i]));
  }
  // Show information table doesn't need hint.
  //document.getElementById("tmsg").innerHTML = "";
	
}

function to_add(vid,nv_data,dhcp_data){
	var data = new Array();
	var existflg=0;
	for(var i=0; i<nv_data.length; i++)
	{
		existflg=0;
		if ( typeof dhcp_data != "undefined" ) 
		{
			for(var j=0; j<dhcp_data.length; j++)
			{
				var singleip = nv_data[i].yiaddr.split(".");
				//alert(singleip[3]+" vs "+dhcp_data[j][1]+"; "+nv_data[i].chaddr+" vs "+dhcp_data[j][2]);
				if ( singleip[3] == dhcp_data[j][1] || nv_data[i].chaddr == dhcp_data[j][2] ) 
				{
					existflg=1;
					totalcnt++;
					break;
				}
			}
		}
		data[0] = new Array(td_id[0]+vid,nv_data[i].hostname,0);
		data[1] = new Array(td_id[1]+vid,nv_data[i].yiaddr,0);
		data[2] = new Array(td_id[2]+vid,nv_data[i].chaddr,0);
		if ( existflg == 1 ) 
			data[3] = new Array(td_id[3]+vid,"<input type=checkbox id=chk_"+vid+"_"+i+" checked disabled>",0);
		else
			data[3] = new Array(td_id[3]+vid,"<input type=checkbox id=chk_"+vid+"_"+i+">",0);
		data[4] = new Array("","&nbsp;",0);
		add_row(i,data,vid,"show",2);
	}
}

function get_data(F)
{
	var tmp="";
	var sip="",desclen="";
	var nv_data;
  	for(var i=0; i<vlan_group.length; i++)
	{
		nv_data = eval("data_"+vlan_group[i]);
		if ( typeof nv_data == 'undefined' ) continue;
		for(var j=0; j<nv_data.length; j++)
		{
			if ( typeof eval("F.chk_"+vlan_group[i]+"_"+j) == 'undefined' )  
				continue;
			if ( eval("F.chk_"+vlan_group[i]+"_"+j).checked == true && 
                             eval("F.chk_"+vlan_group[i]+"_"+j).disabled== false) 
			{
				if ( tmp != "" ) tmp += ";";
				tmp+=vlan_group[i]+",";
				sip=nv_data[j].yiaddr.split(".");		
				tmp+=sip[3]+",";
				tmp+=nv_data[j].chaddr+",";
				if ( nv_data[j].hostname.length == 0 )
					tmp+="00NULL";
				else
				{
					if ( nv_data[j].hostname.length < 10 ) 
					  	desclen = "0"+nv_data[j].hostname.length;
					else 
					  	desclen = nv_data[j].hostname.length;
					tmp+=desclen+nv_data[j].hostname;
				}
				totalcnt++;
			}
		}
	}
	F.static_dhcp_statics.value=tmp;
} 

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("dhcp_leased_client.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	get_data(F);
	if ( totalcnt > STATIC_DHCP_ENTRY ) 
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,STATIC_DHCP_ENTRY,__T(lan.staticdhcp)),"");
		return false;	
	}
	F.submit_button.value="dhcp_leased_client";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=static_dhcp_statics>
<input type=hidden name=gui_action>
<input type=hidden name=wait_time value=15>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.dhcpleasedclient));</script></TR>
  <script>
  for(var i=0; i<vlan_group.length; i++)
  {
  	document.write("<TR><TD colspan=2>");
	draw_td(O_GUI,CREATE_EDIT_TABLE,"25,25,25,20",__T(lan.vlan)+vlan_group[i]+" "+__T(lan.dhcpleasedclienttb),""+__T(wan.hostname)+","+__T(share.ipaddr)+","+__T(share.macaddr)+","+__T(lan.addtostatic)+"","","","",vlan_group[i]);
  	document.write("</TD></TR>");
  } 	
  </script>
  <% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
