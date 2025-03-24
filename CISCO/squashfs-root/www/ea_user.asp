<html>
<head>
<title>Users</title>
<% web_include_file("filelink.asp"); %>
<script>
var stflg="init";
var idx=0;
var td_id=new Array("tdname","tdgroup","tdtype","tdauthdomain","tdst");
var obj_id=new Array("objname","objgroup","objtype","objauthdomain","objst");
var img_id=new Array("imgname","imggroup","imgtype","imgauthdomain","imgst");
var div_id=new Array("divname","divgroup","divtype","divauthdomain","divst");
var user_type = new Array("", "SSL VPN User","Administrator","Guest (Readonly)");
var auth_type=new Array("",__T("Local User Database"),__T("Radius-PAP"),__T("Radius-CHAP"),__T("Radius_MSCHAP"),__T("Radius-MSCHAPV2"),__T("NT Domain"),__T("Acive Directory"),__T("LDAP"));
var log_st=new Array(__T("Disconnected"),__T("Connected"));
var datalist = new Array();
<% get_user_user(); %>

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.user_user;
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	choose_disable(document.getElementById("e4"));
	choose_disable(document.getElementById("e5"));
	choose_disable(document.getElementById("e6"));
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,datalist[i][1],0);
		tmp[3]=new Array(td_id[2]+idx,user_type[datalist[i][2]],3);
		tmp[4]=new Array(td_id[3]+idx,auth_type[datalist[i][3]],0);
		tmp[5]=new Array(td_id[4]+idx,log_st[datalist[i][4]],3);
		tmp[6]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
	}
}

function to_add(F)
{
	if ( idx >= EA_USER_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,EA_USER_ENTRY,__T("User")),"");
                return false;
	}
	F.submit_button.value="ea_user_edit";
	F.stflg.value="add"; 
	F.change_action.value="gozila_cgi";
	F.submit();
}

function to_policy(F,type)
{
	if ( type == "ip" ) 
	{
	        F.submit_button.value="ea_user_ip";
	        F.stflg.value="edit_ip";
	}
	else if ( type == "browser" ) 
	{
		F.submit_button.value="ea_user_browser";
	        F.stflg.value="edit_browser";
	} 
	else if ( type == "log") 
	{
	        F.submit_button.value="ea_user_loginpolicy";
	        F.stflg.value="edit_loginpolicy"; 
	}
        F.change_action.value="gozila_cgi";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked ) 
                {
                        F.selidx.value = i;
                        break;
                }
        }
        F.submit();
}


function to_edit(F)
{
	F.submit_button.value="ea_user_edit";
	F.stflg.value="edit"; 
	F.change_action.value="gozila_cgi";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked ) 
                {
                        F.selidx.value = i;
                        break;
                }
        }
	F.submit();
}

function uiDoSave(F){
        F.del_user.value = "";
        if ( stflg == "del" ) 
        {
            for(var i=0; i<datalist.length; i++)
            {
                if ( document.getElementById("chk_"+i) != null && 
                     document.getElementById("chk_"+i).checked )
                {
                        if ( F.del_user.value != "" )  F.del_user.value+=",";
                        F.del_user.value+=document.getElementById(td_id[0]+i).innerHTML;
                }
            }   
        }
        F.stflg.value = "del";
        F.submit_button.value = "ea_user";
        F.gui_action.value = "Apply";
        F.submit();
	parent.document.getElementById("save_bg").style.display="";
}
function to_del(F)
{
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true )
		{
	               		del_row(i);
		}
		
	}
	
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) count++;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,datalist[index]);
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	choose_disable(document.getElementById("e4"));
	choose_disable(document.getElementById("e5"));
	choose_disable(document.getElementById("e6"));
	if ( count == 1 ) 
	{
		choose_enable(document.getElementById("e2"));
		choose_enable(document.getElementById("e3"));
		choose_enable(document.getElementById("e4"));
		choose_enable(document.getElementById("e5"));
		choose_enable(document.getElementById("e6"));
	}
	if ( count > 0 ) 
	{
		choose_enable(document.getElementById("e2"));
		choose_enable(document.getElementById("e6"));
	}
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=user_user method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=selidx>
<input type=hidden name=del_user>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Users"));</script></TR>
  <TR><TD colspan=2>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","e3",__T("Log in Policies"),"to_policy(this.form,\"log\")");
		bt_list[3] = new Array("BT","e4",__T("Policies By Browser"),"to_policy(this.form,\"browser\")");
		bt_list[4] = new Array("BT","e5",__T("Policies By IP"),"to_policy(this.form,\"ip\")");
		bt_list[5] = new Array("BT","e6",__T("Delete"),"to_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,15,15,15,20,15",__T("Users Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Username")+","+__T("Group")+","+__T("Type")+","+__T("Authentication Domain")+","+__T("Log in Status"),"",bt_list,"","","2,0,0,2,0,2");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
<input type=hidden name=all_page_end>
</div>
</form>
</body></HTML>
