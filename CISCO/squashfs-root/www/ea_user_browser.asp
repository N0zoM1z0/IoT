<html>
<head>
<title>User Configuration</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_user_user("browser"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="ea_user.asp";
var group_name = new Array(<% get_user_group("name"); %>);
var idx=0;
var _name = new Array(__T("Internet Explorer"),__T("Opera"),__T("Netscape Navigator"),__T("Firefox"),__T("Mozilla"));
var _val = new Array("1","2","4","8","16");
function refresh_page()
{
        alert_result(0);        
	var F = document.edit_user;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "ea_user_browser";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "ea_user.asp";
	uiDoCancel(F,"back");
}
function init()
{
	var F = document.edit_user;
	F.def_br[datalist[selidx][1]].checked = true;
	for(var i=0; i<_name.length; i++)
	{
		if ( ( parseInt(datalist[selidx][2],10) & 1<<i ) == 1<<i)  
			def_row(_name[i]);
	}
}

function def_row(b_name)	
{	
	var tmp = new Array();	
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
	tmp[1]=new Array("tdadd_type"+idx,b_name,0);
	tmp[2] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,"","",2);
	idx++;
}

function uiDoSave(F)
{
	var b=0;
	if ( !check_before_data(idx-1) ) return false;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i) != null && 
		     document.getElementById("chk_"+i).checked ) continue;
		if ( document.getElementById("add_type"+i) ) 
			b += parseInt(document.getElementById("add_type"+i).value,10);
		else{
			for(var j=0; j<_name.length; j++)
			{
				if ( document.getElementById("tdadd_type"+i).innerHTML == _name[j] ) 
				{
					b += parseInt(_val[j],10);
					break;
				}
			}
		}
	}
	F.browser.value = b;
	F.ea_user_name.value = datalist[selidx][0];
	F.submit_button.value = "ea_user";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display=""; 
}

function check_before_data(index)
{
	for(var i=0; i<idx; i++)
	{
		var a="",b="";
		if ( i == index ) continue;
		if ( document.getElementById("add_type"+i) == null )  
		{
			for(var j=0; j<_name.length; j++)
			{
				if ( _name[j] == document.getElementById("tdadd_type"+i).innerHTML ) 
				{
					a = _val[j];
					break;
				}
			}
		}
		else
			a = document.getElementById("add_type"+i).value;
		if ( document.getElementById("add_type"+index) == null) 
		{
			for(var j=0; j<_name.length; j++)
			{
				if ( _name[j] == document.getElementById("tdadd_type"+index).innerHTML ) 
				{
					b = _val[j];
					break;
				}
			}
		}
		else
			b = document.getElementById("add_type"+index).value;
		if ( a == b )
		{
			my_alert(O_GUI,INFO,__T(share.info),__T("The browser already exists."),"");
			return false;
		}
	}			
	return true;
}

function to_add()
{
	
	if ( idx >= USER_BROWSER_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,USER_BROWSER_ENTRY,__T("Defined Browsers")),"");
                return false;
        }
	if ( !check_before_data(idx-1) ) return false;
	var stflg="add";
	var F = document.edit_user;
	var tmp = new Array();
	tmp[0] = new Array("chk_add_type","<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array("tdadd_type"+idx,draw_object(O_VAR,SELBOX,"add_type"+idx,"id=add_type"+idx,_name,_val),0);
	tmp[2] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_","add","","",2);
	idx++
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

function to_del()
{
	stflg = "del";
	for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
	               		del_row(i);
	}
	choose_disable(document.getElementById("t2"));
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
<input type=hidden name=browser>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Users"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__TC("User Policy By Client Browser"));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Username"));</script>
		<script>Capture(datalist[selidx][0]);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Deny Log in from Defined Browsers"));</script>
		<input type=radio name=def_br id=def_br value=0 checked>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC("Allow Log in from Defined Browsers"));</script>
		<input type=radio name=def_br id=def_br value=1>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,30",__T("Defined Browsers"),"<input type=checkbox name=chkall id=chkall onclick=all_chk(this.form)>,"+__T("Source Address Type"),"add,del","","","","2,0");
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
