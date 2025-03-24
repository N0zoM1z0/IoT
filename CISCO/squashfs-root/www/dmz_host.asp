<html>
<head>
<title>DMZ Host</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
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
function init(){
	var F = document.frmdmz;
	chk_dmz();
	chg_vid(F);
	default_nv = keep_val(F,"");
	parent.document.getElementById("save_bg").style.display="none";
}

function chk_dmz(){
	var F = document.frmdmz;
	if ( F._dmz_enable.checked == false ){
		choose_disable(F.dmz_ipaddr);
		choose_disable(F.dmz_vid);
	}else{
		choose_enable(F.dmz_ipaddr);
		choose_enable(F.dmz_vid);
	}
}

function valid_dmz(F){
	if ( F._dmz_enable.checked )
        {
                F.dmz_enable.value=1;
                if ( !msg_chk_range(F.dmz_ipaddr.value,"dmz_ipaddr",1,254,10,IS_FIELD,0,"msg_dmz"))
                return false;
                if ( F.dmz_ipaddr.value == "<% get_single_ip("lan_ipaddr","3"); %>" )
                {
                        parent.document.getElementById("obj_id").value = "msg_dmz";
                        my_alert(O_VAR,"dmz_ipaddr",__T(msg.subnet4),"0","msg_dmz");
                        return false;
                }
        }
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("dmz_host.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F){
	if ( !valid_dmz(F) )return;
	F.dmz_enable.value=0;
	if ( F._dmz_enable.checked ) 
		F.dmz_enable.value=1;
	F.dmz_ipaddr.value = parseInt(F.dmz_ipaddr.value, 10);
	F.submit_button.value="dmz_host";
	F.gui_action.value="Apply";
	F.submit();
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}

function chg_vid(F)
{
	for(var i=0; i<lan_arr.length; i++)
	{
		if ( F.dmz_vid[F.dmz_vid.selectedIndex].value == lan_arr[i].vlan_id ) 
		{
			var str = (lan_arr[i].ipaddr).split(".");
			document.getElementById("subnet").innerHTML = str[0]+" . "+str[1]+" . "+str[2]+" . ";
			break;
		}
	}
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmdmz method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=dmz_enable>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.dmzhost),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T(lan.dmzhostconfig),"colspan=2");</script></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(lan.dmz));</script>
		<input type=checkbox name=_dmz_enable <% nvram_match("dmz_enable","1","checked"); %> onclick=chk_dmz()> <script>Capture(share.enable);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.vlan));</script>
                <script>
                var tmp = "<% nvram_get("vlan_group"); %>".replace(/\s*$/,"");
                var _name = tmp.split(" ");
                draw_object(O_GUI,SELBOX,"dmz_vid","onChange=chg_vid(this.form)",_name,_name,"<% nvram_get("dmz_vid"); %>");</script>
                </TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.hostip),SPACE_DOWN, SPACE_DOWN);</script>
		<span id=subnet><% prefix_ip_get("lan_ipaddr",1); %></span> <input size=3 maxlength=3 name=dmz_ipaddr id=dmz_ipaddr value="<% nvram_get("dmz_ipaddr"); %>" onblur=valid_dmz(this.form)>
		<SPAN id=msg_dmz></SPAN>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
