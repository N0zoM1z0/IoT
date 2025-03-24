<html>
<head>
<title>User Configuration</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_user("ip"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ea_user.asp";
var group_name = new Array(<% get_user_group("name"); %>);
var idx=0;
var td_id=new Array("tdchk","tdaddrtype","tdip","tdmask");
var img_id=new Array("imgchk","imgaddrtype","imgip","imgmask");
var div_id=new Array("divchk","divaddrtype","divip","divmask");
var obj_id=new Array("objchk","objaddrtype","objip","objmask");
var _name = new Array(__T("IP Address"),__T("Defined Address Configuration"));
var _val = new Array("1","2");
function refresh_page()
{
        alert_result(0);        
	var F = document.edit_user;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "ea_user_ip";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ea_user.asp";
	uiDoCancel(F,"back");
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

function init()
{
	var F = document.edit_user;
	F.def_addr[datalist[selidx][1]].checked = true;
	var objname = eval("addrlist_"+selidx);
	for(var i=0; i<objname.length; i++)
	{
		var tmp = new Array();
        	tmp[0]=new Array(td_id[0]+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
        	tmp[1]=new Array(td_id[1]+idx,_name[parseInt(objname[i][0],10)-1],3);
        	tmp[2]=new Array(td_id[2]+idx,objname[i][1],0);
        	tmp[3]=new Array(td_id[3]+idx,objname[i][2],2);
		tmp[4]=new Array("","&nbsp;");
		add_row(idx,tmp,"chk_","init","","",2);
		idx++
				
	}
}

function uiDoSave(F)
{
	var addrlist="";	
	for(var i=0; i<idx; i++)
	{
                if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) continue;
		if ( addrlist != "" ) addrlist+=";";
		if ( document.getElementById(obj_id[0]+i) )
		{
			addrlist+=document.getElementById(obj_id[1]+i).value+",";
			addrlist+=document.getElementById(obj_id[2]+i).value+",";
			addrlist+=document.getElementById(obj_id[3]+i).value;
		}else{
			for(var j=0; j<_name.length; j++)
			{
				if ( document.getElementById(td_id[1]+i).innerHTML == _name[j] )
				{
					addrlist += _val[j]+",";
				}
			} 
			addrlist+=document.getElementById(td_id[2]+i).innerHTML+",";
			addrlist+=document.getElementById(td_id[3]+i).innerHTML;
		} 
	}
	//alert(addrlist);
	F.ea_user_name.value = datalist[selidx][0];
	F.addrlist.value = addrlist; 
	F.submit_button.value = "ea_user";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display=""; 
}

function sel_type(F,index)
{
	if ( document.getElementById(obj_id[1]+index).SelectedIndex == 0 ) 
	{
		document.getElementById(obj_id[3]+index).value="32";
		choose_disable(document.getElementById(obj_id[3]+index));
	}else
		choose_enable(document.getElementById(obj_id[3]+index));
}

function to_add()
{
	if ( idx >= USER_ADDRESS_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,USER_BROWSER_ENTRY,__T("Defined Address")),"");
                return false;
        }
	var F = document.edit_user;
	var tmp = new Array();
	tmp[0] = new Array(td_id[0]+idx,"<input type=checkbox id="+obj_id[0]+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[1]+idx,draw_object(O_VAR,SELBOX,obj_id[1]+idx,"id="+obj_id[1]+idx+" onChange=sel_type(this.form,"+idx+")",_name,_val),0);
	tmp[2] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=51 maxlength=39 id="+obj_id[2]+idx+" onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"')>",div_id[2]+idx),1);
	tmp[3] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=10 maxlength=2 id="+obj_id[3]+idx+" onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"') value='32' disabled>",div_id[3]+idx,"","align=right"),1);
	tmp[4] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_","add","","",3);
	idx++
}

function to_del()
{
        stflg = "del";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                {
                                del_row(i);
                }
        }
        choose_disable(document.getElementById("t2"));
        choose_disable(document.getElementById("t3"));

}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_user method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=ea_user_name>
<input type=hidden name=addrlist>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Users"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__TC("User Policy By Source IP Address"));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Username"));</script>
		<script>Capture(datalist[selidx][0]);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Deny Log in from Defined Addresses"));</script>
		<input type=radio name=def_addr id=def_addr value=0 checked>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Allow Log in from Defined Addresses"));</script>
		<input type=radio name=def_addr id=def_addr value=1>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,30,20,15",__T("Defined Addresses"),"<input type=checkbox name=chkall id=chkall onclick=all_chk(this.form)>,"+__T("Source Address Type")+","+__T("Network Address / IP address")+","+__T("Mask Length"),"add,del","","","","2,2,0,1");
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
