<html>
<head>
<title>SSL VPN Policies</title>
<% web_include_file("filelink.asp"); %>
<script>
var stflg="init";
var idx=0;
var datalist = new Array();
var pt_name_list = new Array(__T("Network Resource"),__T("IP Address"),__T("IP Network"),__T("All IP Addresses"));
var service_list = new Array(__T("VPN Tunnel"),__T("Port Forwarding"),__T("All"));
var action_list = new Array("Permit","Deny");
var td_id=new Array("tdname","tdservice","tddest","tdpermiss");
<% get_sslvpn_policy("all"); %> 
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.ssl_vpn;
	Sel_list(F);
	//get_data("1","");
}

function get_data(val,vname)
{	
	idx=0;
	for(var i=0; i<datalist.length; i++)
	{
		var desc="";
		if ( parseInt(val,10) != parseInt(datalist[i].pf,10) ) continue;
		if ( parseInt(val,10) == 2 && (vname != datalist[i].gp) ) continue;
		if ( parseInt(val,10) == 3 && (vname != datalist[i].ur) ) continue;
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i].pname,0);
		if ( parseInt(datalist[i].pt,10) == 1 ) //Resource
			tmp[2]=new Array(td_id[1]+idx,datalist[i].def_res,3);
		else
			tmp[2]=new Array(td_id[1]+idx,service_list[parseInt(datalist[i].ser,10)-1],3);
		if ( pt_name_list[parseInt(datalist[i].pt,10)-1] == __T("IP Address") )
			desc = datalist[i].addr+":"+datalist[i].portb+"-"+datalist[i].porte;
		else if ( pt_name_list[parseInt(datalist[i].pt,10)-1] == __T("IP Network") ) 
			desc = datalist[i].addr+"/"+datalist[i].mlen+":"+datalist[i].portb+"-"+datalist[i].porte;
		else if ( pt_name_list[parseInt(datalist[i].pt,10)-1] == __T("All IP Addresses") ) 
			desc = datalist[i].portb+"-"+datalist[i].porte;
		tmp[3]=new Array(td_id[2]+idx,desc,0);
		tmp[4]=new Array(td_id[3]+idx,action_list[parseInt(datalist[i].action,10)-1],3);
		tmp[5]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
	}
}

function to_del()
{
	stflg="del";
	var F = document.ssl_vpn;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
				del_row(i);
		
	}
	choose_disable(document.getElementById("t2"));
	choose_disable(document.getElementById("t3"));
	
}

function to_edit()
{
	var F = document.ssl_vpn;
	for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked ) 
                {
                        F.selidx.value = document.getElementById("list_"+i).value;
                        break;
                }
        }
	F.submit_button.value="ssl_vpn_policies_edit";
	F.stflg.value="edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function to_add()
{
	var F = document.ssl_vpn;
	if ( datalist.length >= SSL_VPN_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,SSL_VPN_ENTRY,__T("SSL VPN Policies")),"");
                return false;
	}
	F.submit_button.value="ssl_vpn_policies_edit";
	F.stflg.value="add"; 
	F.change_action.value="gozila_cgi";
	F.selidx.value = datalist.length;
	F.submit();

}

function Sel_list(F)
{
	choose_disable(F.group);
	choose_disable(F.user);
	if ( F.view_list[1].selected == true ) 
		choose_enable(F.group);	
	if ( F.view_list[2].selected == true ) 
		choose_enable(F.user);	
}

function to_display(F)
{
	for(var i=0; i<idx; i++)
		document.getElementById("_table").deleteRow(3);		
	if ( F.view_list[0].selected == true ) 
		get_data("1","");
	else if ( F.view_list[1].selected == true ) 
		get_data("2",F.group.value);
	else if ( F.view_list[2].selected == true ) 
		get_data("3",F.user.value);
	
}

function chk_click(index)
{
        var count=0;
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked ) count++;
        }
        to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,"chk_add_type",datalist[index]);
        if ( count > 0 ) 
        {
                choose_enable(document.getElementById("t4"));
                choose_disable(document.getElementById("t2"));
        }
        if ( count == 0 ) 
        {
                choose_disable(document.getElementById("t4"));
                choose_enable(document.getElementById("t2"));
        }
}

function uiDoSave(F)
{
	var del="";
	if ( stflg == "del" ) 
	{
		for(var i=0; i<idx; i++)
		{
			if ( document.getElementById("chk_"+i) != null && 
			     document.getElementById("chk_"+i).checked )
			{
				if ( del != "" ) del+=",";
				del+=document.getElementById(td_id[0]+i).innerHTML;
			}
		
		}
	}
	F.stflg.value = "del";
	F.del_policy.value = del;
	//alert(del);
	//return;
	F.submit_button.value="ssl_vpn_policies";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=ssl_vpn onSubmit="return false;" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=selidx>
<input type=hidden name=del_policy>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("SSL VPN Policies"));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T("Query"),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("View List of SSL VPN Policies for")+":");</script>
		<script>
			var vlist = new Array(__T("Global"),__T("Group"),__T("User"));
			var dlist = new Array("1","2","3");
			draw_object(O_GUI,SELBOX,"view_list","onChange=Sel_list(this.form)",vlist,dlist,"");</script>
		</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Available Groups")+":");</script>
		<script>
                        var vlist = new Array(<% get_user_group("name"); %>);
			draw_object(O_GUI,SELBOX,"group","",vlist,vlist,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Available Users")+":",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
                        var vlist = new Array(<% get_user_user("name"); %>);
			draw_object(O_GUI,SELBOX,"user","",vlist,vlist,"");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");</script>
		<script>draw_object(O_GUI,BT,__T("Display"),"e1","BT","to_display(this.form)");</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20,20,10",__T("SSL VPN Policies Table"),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T("Name")+","+__T("Service")+","+__T("Destination")+","+__T("Permission"),"add,edit,del","","","","2,0,2,0,2");
		</script>
		</TR>
		</TABLE>
		<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
</TABLE>
</div>
</form>
</body></HTML>
