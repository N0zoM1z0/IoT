<html>
<head>
<title>VPN Portal Layouts</title>
<% web_include_file("filelink.asp"); %>
<script>
var stflg="init";
var idx=0;
var td_id=new Array("tdname","tdcount","tdurl");
var datalist = new Array();
<% get_portal_layout(); %>
//datalist[0]=new Array("SSLVPN*","1","https://192.168.1.1/portal/SSLVPN");
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.portal_layout;
	choose_disable(F.e2);
	choose_disable(F.e3);
	choose_disable(F.e4);
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,datalist[i][1],2);
		tmp[3]=new Array(td_id[2]+idx,datalist[i][2],0);
		tmp[4]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
		
	}
}

function to_add(F)
{
	if ( idx >= PORTAL_LAYOUT_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,PORTAL_LAYOUT_ENTRY,__T(vpn.portallayouts)),"");
                return false;
	}
	F.submit_button.value="portal_layouts_edit";
	F.stflg.value="add"; 
	F.change_action.value="gozila_cgi";
	F.selidx.value = datalist.length;
	F.submit();
}

function to_edit(F)
{
	F.submit_button.value="portal_layouts_edit";
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

function to_setdf(F)
{
	stflg="def";
	document.getElementById("tmsg").innerHTML = __T(msg.tablemsg1);
	document.getElementById("tmsg").style.display="";
	for(var i=0; i<datalist.length; i++)
        {
                if ( document.getElementById("chk_"+i) != null && 
                     document.getElementById("chk_"+i).checked )
                {
                        F.portal_def.value=document.getElementById(td_id[0]+i).innerHTML;
			break;
                }
        }
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e4"));

}

function uiDoSave(F){
	F.del_list.value = "";
	if ( stflg == "del" ) 
	{
	    for(var i=0; i<datalist.length; i++)
            {
		if ( document.getElementById("chk_"+i) != null && 
		     document.getElementById("chk_"+i).checked )
		{
               		if ( F.del_list.value != "" )  F.del_list.value+=",";
                       	F.del_list.value+=document.getElementById(td_id[0]+i).innerHTML;
		}
	    }
	    choose_disable(F.portal_def);
	    F.stflg.value = "del";
	}else 
		choose_disable(F.del_list);
	//alert(F.portal_def.value);
	//return;
	F.submit_button.value = "portal_layouts";
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
			if ( parseInt(datalist[i][1],10) > 0 ) 
			{
				document.getElementById("chk_"+i).checked = false;
				my_alert(O_PAGE,INFO,__T(vpn.portallayoutmsg),"");
							
			}else
				del_row(i);
		}
	}
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked ) count++;
		
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,datalist[index]);
	choose_disable(document.getElementById("e1"));
	choose_disable(document.getElementById("e2"));
	choose_disable(document.getElementById("e3"));
	choose_disable(document.getElementById("e4"));
	if ( count == 1 ) 
	{
		choose_enable(document.getElementById("e2"));
		choose_enable(document.getElementById("e3"));
	}
	if ( count > 0 )
		choose_enable(document.getElementById("e4"));
	if ( count == 0 ) 
		choose_enable(document.getElementById("e1"));
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=portal_layout method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=selidx>
<input type=hidden name=del_list>
<input type=hidden name=portal_def>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.portallayouts));</script></TR>
  <TR><TD colspan=2>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","e3",__T(vpn.setdf),"to_setdf(this.form)");
		bt_list[3] = new Array("BT","e4",__T(share.del),"to_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,10,30",__T(vpn.layouttb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(vpn.layoutname)+","+__T(vpn.usecount)+","+__T(vpn.portalurl),"",bt_list,"","","2,0,1,0");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
<input type=hidden name=all_page_end>
</div>
</form>
</body></HTML>
