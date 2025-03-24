<html>
<head>
<title>VPN Portal Layouts</title>
<% web_include_file("filelink.asp"); %>
<script>
var stflg="init";
var idx=0;
var td_id=new Array("tdname","tdauth_type","tdlayout_name");
var auth_type=new Array("",__T("Local User Database"),__T("Radius-PAP"),__T("Radius-CHAP"),__T("Radius_MSCHAP"),__T("Radius-MSCHAPV2"),__T("NT Domain"),__T("Acive Directory"),__T("LDAP"));
var datalist = new Array();
//datalist[0] = new Array("SSLVPN*","1","SSLVPN");
<% get_user_domain(); %>
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.portal_layout;
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,auth_type[datalist[i][1]],3);
		tmp[3]=new Array(td_id[2]+idx,datalist[i][2],0);
		tmp[4]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
		
	}
}

function to_add()
{
	var F = document.user_domain;
	if ( idx >= EA_DOMAIN_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,EA_DOMAIN_ENTRY,__T("Domains")),"");
                return false;
	}
	F.submit_button.value="ea_domain_edit";
	F.stflg.value="add"; 
	F.change_action.value="gozila_cgi";
	F.selidx.value = datalist.length;
	F.submit();
}

function to_edit()
{
	var F = document.user_domain;
	F.submit_button.value="ea_domain_edit";
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
	F.del_domain.value = "";
	if ( stflg == "del" ) 
	{
	    for(var i=0; i<datalist.length; i++)
            {
		if ( document.getElementById("chk_"+i) != null && 
		     document.getElementById("chk_"+i).checked )
		{
               		if ( F.del_domain.value != "" )  F.del_domain.value+=",";
                       	F.del_domain.value+=document.getElementById(td_id[0]+i).innerHTML;
		}
	    }	
	}
	F.stflg.value = "del";
	F.submit_button.value = "ea_domain";
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
				my_alert(O_PAGE,INFO,__T("Cannot delete a Domain if it contains User(s)."),"");
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
<FORM autocomplete=off id=frm name=user_domain method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=selidx>
<input type=hidden name=del_domain>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Domains"));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20,20",__T("Domains Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Domain Name")+","+__T("Authentication Type")+","+__T("Portal Layout Name"),"add,edit,del","","","","2,0,2,0");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
<input type=hidden name=all_page_end>
</div>
</form>
</body></HTML>
