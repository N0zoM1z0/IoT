<html>
<head>
<title>Resouorces</title>
<% web_include_file("filelink.asp"); %>
<script>
var idx=0;
var obj_id=new Array("name","service");
var td_id=new Array("tdname","tdservice");
var img_id=new Array("imgname","imgservice");
var div_id=new Array("divname","divservice");
var datalist = new Array();
var stflg="init";
var _name = new Array(__T("VPN Tunnel"),__T("Port Forwarding"),__T("All"));
var _val = new Array("1","2","3");
var datalist = new Array();
<% get_res(); %>
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
		tmp[2]=new Array(td_id[1]+idx,_name[parseInt(datalist[i][1],10)-1],3);
		tmp[3]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,3);
		idx++;
		
	}
}

function chk_before_data(index)
{
	return true;
}

function to_add(F)
{
	if ( idx >= RESOURCES_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,RESOURCES_ENTRY,__T(vpn.portallayouts)),"");
                return false;
	}
	stflg="add"; 
	if ( !chk_before_data(idx-1) ) return false;
	var tmp= new Array();
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=127 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	tmp[2]=new Array(td_id[1]+idx,draw_object(O_VAR,SELBOX,obj_id[1]+idx+" id='"+obj_id[1]+idx+"'","",_name,_val),3);
	tmp[3]=new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,3);
	idx++;
}

function uiDoSave(F){
	var res_entry="";
	if ( stflg != "add" && stflg != "del" ) return;
	if ( stflg == "add" )
	{
		for(var i=0; i<idx; i++)
		{
			if ( res_entry!="" ) res_entry +=";";
			if ( document.getElementById(obj_id[0]+i) )
			{
				res_entry+=document.getElementById(obj_id[0]+i).value+","+document.getElementById(obj_id[1]+i).value;
			}
		}
	}else{
		for(var i=0; i<idx; i++)
		{
                	if ( document.getElementById("chk_"+i) != null && 
	                     document.getElementById("chk_"+i).checked )
			{
				if ( res_entry!="") res_entry+=",";
				res_entry += document.getElementById(td_id[0]+i).innerHTML
			}
				
		}
		
	}
	//alert(res_entry);
	F.res_entry.value = res_entry;
	F.stflg.value = stflg;
	F.submit_button.value = "resources";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";

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
        if ( count == 1 )
                choose_enable(document.getElementById("e2"));
        if ( count > 0 )
                choose_enable(document.getElementById("e3"));
        if ( count == 0 ) 
                choose_enable(document.getElementById("e1"));

}

function to_del(F)
{
        stflg = "del";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                {/*
                        if ( parseInt(datalist[i][3],10) > 0 ) 
                        {
                                document.getElementById("chk_"+i).checked = false;
                                my_alert(O_PAGE,INFO,__T("Cannot delete a Domain if it contains User(s)."),"");
                        }
                        else*/
                                del_row(i);
                }
        }
        choose_disable(document.getElementById("e1"));
        choose_disable(document.getElementById("e2"));

}

function to_addobj(F)
{
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
		{
			F.selidx.value = i ; 
			break;
		}	
	}
	F.stflg.value="edit";
	F.submit_button.value = "resources_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
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
<input type=hidden name=res_entry>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Resources"));</script></TR>
  <TR><TD colspan=2>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","e2",__T("Add Objects to Resource"),"to_addobj(this.form)");
		bt_list[2] = new Array("BT","e3",__T(share.del),"to_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20",__T("Resources Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Resource Name")+","+__T("Service"),"",bt_list,"","","2,0,2");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
		
</TABLE>
</div>
</form>
</body></HTML>
