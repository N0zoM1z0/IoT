<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_sslvpn_policy("all"); %> 
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ssl_vpn_policies.asp";
var pf_name_list = new Array(__T("Global"),__T("Group"),__T("User"));
var pf_val_list = new Array("1","2","3");
var group_list = new Array(<% get_user_group("name"); %>);
var user_list = new Array(<% get_user_user("name"); %>);
var pt_name_list = new Array(__T("Network Resource"),__T("IP Address"),__T("IP Network"),__T("All IP Addresses"));
var pt_val_list = new Array("1","2","3","4");
var ser_name_list = new Array(__T("VPN Tunnel"),__T("Port Forwarding"),__T("All"));
var ser_val_list = new Array("1","2","3");
var res_list = new Array(<% get_res("name"); %>);
var act_name_list = new Array("Permit","Deny");
var act_val_list = new Array("1","2");
function refresh_page()
{
        alert_result(0);        
	var F = document.frmacl;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "ssl_vpn_policies_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function init()
{
	var F = document.frmacl;
	if( stflg == "edit" ) 
	{
		F.view_list.selectedIndex = parseInt(datalist[selidx].pf,10)-1;
		if ( F.view_list.selectedIndex == 1 ) 
		{
			for(var i=0; i<group_list.length; i++)
			{
				if ( group_list[i]==datalist[selidx].gp ) 
				{
					F.group.selectedIndex = i;
					break;
				}
				
			}
		}else if ( F.view_list.selectedIndex == 2 ) 
        	{
                	for(var i=0; i<user_list.length; i++)
	                {
        	                if ( user_list[i]==datalist[selidx].ur ) 
                	        {
	                                F.user.selectedIndex = i;
        	                        break;
                	        }
        	        }
	        }
		F.policy_to.selectedIndex = parseInt(datalist[selidx].pt,10)-1;
		F.policy_name.value = datalist[selidx].pname;
		if ( datalist[selidx].pt == "2" || datalist[selidx].pt == "3" ) 
			F.ipaddr.value = datalist[selidx].addr;
		if ( datalist[selidx].pt == "3" ) 
			F.masklen.value = datalist[selidx].mlen;
		if ( datalist[selidx].pt != "1" ) 
		{
			F.begin.value = datalist[selidx].portb;
			F.end.value = datalist[selidx].porte;
		}
		F.service.selectedIndex = parseInt(datalist[selidx].ser,10)-1;
		for(var i=0; i<res_list.length; i++)
		{
			if ( res_list[i] == datalist[selidx].def_res ) 
			{
				F.resources.selectedIndex = i;
				break;
			}
		}
		F.permission.selectedIndex = parseInt(datalist[selidx].action,10)-1;
		choose_disable(F.service);
	}
	Sel_list(F);
	sel_policy(F);
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ssl_vpn_policies.asp";
	uiDoCancel(F,"back");
}

function Sel_list(F)
{
	choose_disable(F.group);
	choose_disable(F.user);
	if ( F.view_list[1].selected == true ) 
		choose_enable(F.group);
	else if ( F.view_list[2].selected == true ) 
		choose_enable(F.user);
}

function sel_policy(F)
{
	choose_disable(F.ipaddr);
	choose_disable(F.masklen);
	choose_disable(F.begin);
	choose_disable(F.end);
	choose_disable(F.service);
	if ( F.policy_to[1].selected == true ) 
	{
		choose_enable(F.ipaddr);
		choose_enable(F.begin);
		choose_enable(F.end);
		choose_enable(F.service);
	}else if ( F.policy_to[2].selected == true ) 
	{
		choose_enable(F.ipaddr);
		choose_enable(F.masklen);
		choose_enable(F.begin);
		choose_enable(F.end);
		choose_enable(F.service);
	}else if ( F.policy_to[3].selected == true )
	{
		choose_enable(F.begin);
		choose_enable(F.end);
		choose_enable(F.service);
	}
}

function uiDoSave(F)
{
	choose_enable(F.service);
	F.submit_button.value = "ssl_vpn_policies";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display=""; 
	
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmacl method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("SSL VPN Policy Configuration"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Policy For"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Policy For")+":");</script>
		<script>
                        draw_object(O_GUI,SELBOX,"view_list","onChange=Sel_list(this.form)",pf_name_list,pf_val_list,"");</script>
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T("Available Groups")+":");</script>
                <script>
                        draw_object(O_GUI,SELBOX,"group","",group_list,group_list,"");</script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__T("Available Users")+":",SPACE_DOWN,SPACE_DOWN);</script>
                <script>
                        draw_object(O_GUI,SELBOX,"user","",user_list,user_list,"");</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("SSL VPN Policy"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Apply Policy To")+":");</script>
		<script>
                        draw_object(O_GUI,SELBOX,"policy_to"," onChange=sel_policy(this.form)",pt_name_list,pt_val_list,"");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Policy Name")+":");</script>
		<input size=51 name=policy_name id=policy_name>
		<span id=msg_policy_name></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("IP Address")+":");</script>
		<input size=51 name=ipaddr id=ipaddr maxlength=15>
		<span id=msg_ipaddr></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Mask Length")+":");</script>
		<input size=51 name=masklen id=masklen maxlength=2 onblur=msg_chk_range(this.value,"masklen",0,32,10,IS_FIELD,0,"msg_masklen")>
		<span id=msg_masklen></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Port Range / Port Number")+":");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Begin")+":");</script>
		<input size=51 name=begin id=begin maxlength=5 onblur=msg_chk_range(this.value,"begin",0,65535,10,IS_FIELD,0,"msg_begin")>
		<span id=msg_begin></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("End")+":");</script>
		<input size=51 name=end id=end maxlength=5 onblur=msg_chk_range(this.value,"end",0,65535,10,IS_FIELD,0,"msg_end")>
		<span id=msg_end></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Service")+":");</script>
		<script>
                        draw_object(O_GUI,SELBOX,"service","",ser_name_list,ser_val_list,"");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Defined Resources")+":");</script>
		<script>
                        draw_object(O_GUI,SELBOX,"resources","",res_list,res_list,"");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Permission")+":",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
                        draw_object(O_GUI,SELBOX,"permission","",act_name_list,act_val_list,"");</script>
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
