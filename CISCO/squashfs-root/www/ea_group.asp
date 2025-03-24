<html>
<head>
<title>Groups</title>
<% web_include_file("filelink.asp"); %>
<script>
var stflg="init";
var idx=0;
var td_id=new Array("tdname","tddomain","tdidle_time");
var obj_id=new Array("objname","objdomain","objidle_time");
var img_id=new Array("imgname","imgdomain","imgidle_time");
var div_id=new Array("divname","divdomain","dividle_time");
var user_type = new Array(__T("SSL VPN User"),__T("Administrator"),__T("Guest (Readonly)"));
var domain_name = new Array(<% get_user_domain("name"); %>);
var auth_type=new Array("",__T("Local User Database"),__T("Radius-PAP"),__T("Radius-CHAP"),__T("Radius_MSCHAP"),__T("Radius-MSCHAPV2"),__T("NT Domain"),__T("Acive Directory"),__T("LDAP"));
var datalist = new Array();
<% get_user_group("summary"); %>

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.user_group;
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,auth_type[datalist[i][1]],0);
		tmp[3]=new Array(td_id[2]+idx,datalist[i][2],2);
		tmp[4]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
	}
}

function to_add()
{
	var F = document.user_group;
	if ( idx >= EA_GROUP_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,EA_GROUP_ENTRY,__T("Group")),"");
                return false;
	}
	stflg = "add";
	var tmp = new Array();
	tmp[0] = new Array("tdchk_"+idx, "<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=32 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	
        tmp[2] = new Array(td_id[1]+idx,draw_object(O_VAR,SELBOX,obj_id[1]+idx,"id="+obj_id[1]+idx,domain_name,domain_name),1);
	tmp[3] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=20 maxlength=3 id="+obj_id[2]+idx+" onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"')>",div_id[2]+idx,"","align=right"),2);
	tmp[4]=new Array("","&nbsp;");
        add_row(idx,tmp,"chk_","add","","",3);
        idx++;
}

function to_edit()
{
	var F = document.user_group;
	stflg = "edit";
	F.submit_button.value="ea_group_edit";
	F.stflg.value="edit"
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
	F.group_entry.value = "";
	if ( stflg == "del" ) 
	{
	    for(var i=0; i<datalist.length; i++)
            {
		if ( document.getElementById("chk_"+i) != null && 
		     document.getElementById("chk_"+i).checked )
		{
               		if ( F.group_entry.value != "" )  F.group_entry.value+=",";
                       	F.group_entry.value+=document.getElementById(td_id[0]+i).innerHTML;
		}
	    }	
	}else if ( stflg == "add" ) 
	{
		F.group_entry.value = "";
	    	for(var i=0; i<idx; i++)
		{
			if( document.getElementById(obj_id[1]+i) != null )
			{
				if ( F.group_entry.value != "" ) 
					F.group_entry.value += ";";
				for(var j=0; j<3; j++)
				{
					if (j>0)
						F.group_entry.value += ",";
					F.group_entry.value += document.getElementById(obj_id[j]+i).value;
				}
			}
		}
	}
	F.stflg.value = stflg;
	F.submit_button.value = "ea_group";
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
        		if ( parseInt(datalist[i][3],10) > 0 ) 
			{
				document.getElementById("chk_"+i).checked = false;
				my_alert(O_PAGE,INFO,__T("Group cannot be deleted if it contains User(s)."),"");
			}
			else
	               		del_row(i);
		}
	}
	choose_disable(document.getElementById("t2"));
	choose_disable(document.getElementById("t3"));
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) count++;
		
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,datalist[index]);
	choose_disable(document.getElementById("t2"));
	choose_disable(document.getElementById("t3"));
	choose_disable(document.getElementById("t4"));
	if ( count == 1 ) 
		choose_enable(document.getElementById("t3"));
	if ( count > 0 )
		choose_enable(document.getElementById("t4"));
	if ( count == 0 ) 
		choose_enable(document.getElementById("t2"));
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=user_group method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=selidx>
<input type=hidden name=group_entry>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Groups"));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20,20",__T("Groups Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Group Name")+","+__T("Domain")+","+__T("Idle Timeout"),"add,edit,del","","","","2,0,0,1");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
<input type=hidden name=all_page_end>
</div>
</form>
</body></HTML>
