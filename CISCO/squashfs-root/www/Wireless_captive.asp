<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var cmp_arr = new Array();
<% get_vlan_list("cmp_arr"); %>
<% wl_multi_nvram_get("wl_ssid"); %>
var nv_gn_profile_0 = "<% nvram_get("gn_profile_0"); %>";
var nv_gn_profile_1 = "<% nvram_get("gn_profile_1"); %>";
var nv_gn_profile_2 = "<% nvram_get("gn_profile_2"); %>";
var nv_gn_profile_3 = "<% nvram_get("gn_profile_3"); %>";
var nv_gn_enable_0 = "<% nvram_get("gn_0_enable"); %>";
var nv_gn_enable_1 = "<% nvram_get("gn_1_enable"); %>";
var nv_gn_enable_2 = "<% nvram_get("gn_2_enable"); %>";
var nv_gn_enable_3 = "<% nvram_get("gn_3_enable"); %>";
var _name = new Array(__T(wl.selprofile)<% get_profile("name"); %>);
var _val = new Array("-1"<% get_profile("name"); %>);

function init(){
	if ( document.getElementById("tmsg") )
                document.getElementById("tmsg").innerHTML = "";

	parent.document.getElementById("save_bg").style.display="none";
	var F = document.wireless;
	var seli = "";
	for(var j=0; j<4; j++)
	{
		seli = "";
		for(var i=0; i<_name.length; i++)
		{
			if ( eval("nv_gn_profile_"+j) == _val[i] ) 
			{
				seli = i;
				break;
			}
		}
		if ( seli == "" ) seli = "0";
		if ( eval("nv_gn_profile_"+j) == "1" ) eval("F.gn_"+j+"_enable").checked = true;
		eval("F.gn_profile_"+j).value = _val[seli];
		sel_profile(F,j);
	}
	default_nv = keep_val(F,"");
}

function sel_profile(F, index)
{
	if ( eval("F.gn_profile_"+index).value == "-1" ) 
		choose_disable(eval("F.gn_"+index+"_enable"));
	else
		choose_enable(eval("F.gn_"+index+"_enable"));
}

function uiDoSave(F)
{
	var need_chg=0, tmp="",keepflg=0;
	if ( F._gn_enable[0].checked ) F.gn_enable.value = 1;
	else F.gn_enable.value = 0;
	for(var d=0; d<4; d++)
	{
		if ( !gn_chk(d) ) return ;
		if ( document.getElementById("gn_"+d+"_enable").checked == false ) 
			continue;
		for(var i=0; i<cmp_arr.length; i++)
		{
			keepflg=0;
			if ( eval("nv_wl_vlan_id_"+d) == cmp_arr[i][0] ) 
			{
				for(var j=3; j<7; j++)
				{
					if ( cmp_arr[i][j] != "2" ) 
					{
						need_chg=1;
						keepflg=1;
					}
				}
			}
			if ( keepflg == 1 ) 
			{
				if ( tmp != "" ) tmp+= " ";
				tmp+=eval("nv_wl_vlan_id_"+d);
				keepflg = 0;
			}
		}
	}
	if ( need_chg == 1 ) 
	{
	  F.guest_vlan_id.value = tmp;
	  my_alert(O_GUI,WARNING,__T(share.info),__T(wl.portchgwarning),"guest_result(1)","guest_result(0)","","yesno");
	  return;
	}else
	  guest_result(1);
}
function guest_result(val)
{
	var F = document.wireless;
	alert_result(0);
	if ( val == 1 ) 
	{
		F.submit_button.value="Wireless_captive";
		F.gui_action.value="Apply";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
	
}

<% wl_multi_nvram_get("wl_vlan_id"); %>

function gn_chk(index)
{
	clear_table_msg("tmsg","img_en"+index,"gn_"+index+"_enable",index);
	if ( document.getElementById("gn_"+index+"_enable").checked == true && 
	     eval("nv_wl_vlan_id_"+index) == "1" )
	{
                table_msg("img_en"+index,"gn_"+index+"_enable","div_en"+index,index,__T(wl.guesterr1));     
		return false;
	}
	return true;
}
</script>
</head>
<body onload=init()>
<FORM id=frm name=wireless onSubmit="return false;" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=submit_button value="Wireless_captive">
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gn_enable>
<input type=hidden name=guest_vlan_id>
<input type=hidden name=vlan value=1>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.basicconfig));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.captive));</script>
                <script>
                        var BNWNAME, BNWSTRING;
                        BNWNAME = new Array("1","0");
                        BNWSTRING = new Array(__T(share.enable),__T(share.disable));
			draw_object(O_GUI,RADIO,"_gn_enable",BNWNAME,BNWSTRING,"<% nvram_get("gn_enable"); %>");</script>
                </script>
        	</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"30,20,10",__T(wl.instancetb),__T(wl.ssidname)+","+__T(wl.profilename)+","+__T(wl.guestnet),"","","","","0,0,2");
		var tmp = new Array();
		for(var i=0; i<SSID_COUNT; i++)
		{
			tmp[0] = new Array("tdssid"+i, eval("nv_wl_ssid_"+i));
			tmp[1] = new Array("tdpname"+i,draw_td(O_VAR,ICONLINE,"img_profile"+i, draw_object(O_VAR,SELBOX,"gn_profile_"+i," onMouseMove=showHint('img_profile"+i+"','div_profile"+i+"',event) onMouseOut=hideHint('div_profile"+i+"') onchange=sel_profile(this.form,"+i+")",_name,_val,eval("nv_gn_profile_"+i)),"div_profile"+i),3);
			var tmpflg = "";
			if ( eval("nv_gn_enable_"+i) == "1" ) tmpflg = "checked";
			tmp[2] = new Array("tdchkgn"+i,draw_td(O_VAR,ICONLINE,"img_en"+i, "<input type=checkbox id=gn_"+i+"_enable name=gn_"+i+"_enable "+tmpflg+" disabled onclick=gn_chk("+i+") onMouseMove=showHint('img_en"+i+"','div_en"+i+"',event) onMouseOut=hideHint('div_en"+i+"')>","div_en"+i),3);
			tmp[3] = new Array("","&nbsp;");
			add_row(i,tmp,"","add",2);
		}
		</script>
		</TR>
     </TABLE>
<input type=hidden name=all_page_end>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
