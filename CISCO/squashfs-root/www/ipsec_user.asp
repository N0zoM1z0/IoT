<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
<% web_include_file("encode_data.js"); %>
var data = new Array();
<% get_ipsec_user("data"); %>
var idx=0;
var stflg = "init";
var td_id = new Array("tdname","tdpwd");
var obj_id = new Array("username","pwd");
var newdata = new Array();
for(var i=0; i<data.length; i++)
{
	newdata[i]= new Array(data[i][0],"********");
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.ipsecuser;
	var tmp = new Array();
	for(var i=0; i<data.length; i++)
	{
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"')>",3);
		tmp[1] = new Array(td_id[0]+i, newdata[i][0]);
		tmp[2] = new Array(td_id[1]+i, newdata[i][1]);
		tmp[3] = new Array("", "&nbsp;");
		add_row(i, tmp, "chk_","init", 2);
		idx++;
	}

	default_nv = keep_val(F,"");
}

function get_data(F)
{
	var tmp = "";
	for(var i=0; i<idx; i++)
	{
		 if (document.getElementById("tr_table"+i) == null ) continue;
	         if ( stflg == "del" ){
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
                        {
				if ( tmp != "" ) tmp +=",";
				tmp += data[i][2];
			}
		}
	}
	return tmp;
}

function uiDoSave(F)
{
	if ( stflg == "del" ) 
		F.ipsec_user_entry.value = get_data(F);
	else{
		if ( !before_check(F) ) 
			return false;
	}
	F.ipsec_user_idx.value = idx;
	F.gui_action.value = "Apply";
	F.stflg.value = stflg;
	F.submit_button.value="ipsec_user";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_edit()
{
	stflg = "edit";
	for(var i=0; i<idx; i++)
	{
		if( document.getElementById("chk_"+i).checked == true && document.getElementById(obj_id[0]+i) == null )
		{
	        	var tmp = new Array();
			tmp[0] = draw_td(O_VAR,ICONLINE,"img_name"+i,"<input size=20 maxlength=63 name=username"+i+" id=username"+i+" onMouseMove=showHint('img_name"+i+"','div_name"+i+"',event) onMouseOut=hideHint('div_name"+i+"') value='"+data[i][0]+"'>","div_name"+i);
			tmp[1] = draw_td(O_VAR,ICONLINE,"img_pwd"+i,"<input type=password size=20 maxlength=63 name=pwd"+i+" id=pwd"+i+" onMouseMove=showHint('img_pwd"+i+"','div_pwd"+i+"',event) onMouseOut=hideHint('div_pwd"+i+"') value='"+data[i][1]+"'>","div_pwd"+i);
			edit_row(td_id,tmp,i);	
		}
	}
}

function to_del()
{
        stflg = "del";
        var error_flg = 0 ;
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                {
                                del_row(i);
                }
        }
}

function before_check(F)
{
	var tmpa="", tmpb="";
	for(var i=0; i<idx; i++)
	{
		for(var j=i+1; j<idx; j++)
		{
			tmpa="", tmpb="";
			if ( typeof eval("F.username"+i) == "undefined" ) tmpa = document.getElementById(td_id[0]+i).innerHTML;
			else tmpa = eval("F.username"+i).value;
			if ( typeof eval("F.username"+j) == "undefined" ) tmpb = document.getElementById(td_id[0]+j).innerHTML;
			else tmpb = eval("F.username"+j).value;
			if ( tmpa == tmpb ) 
			{
				if ( typeof eval("F.username"+i) != "undefined" )
					table_msg("img_name"+i,"username"+i,"div_name"+i,i,__T(msg.nameexist));
				if ( typeof eval("F.username"+j) != "undefined" )
					table_msg("img_name"+j,"username"+j,"div_name"+j,j,__T(msg.nameexist));
				return false;
			}
		}
	}
	var tmp="";
	var newpwd = "";
	//9,username1,7,passwd1;next entry
	for(var i=0; i<idx; i++)
	{
		if ( typeof eval("F.username"+i) == "undefined" ) continue;
		if ( eval("F.username"+i).value == "" ) 
		{
			table_msg("img_name"+i,"username"+i,"div_name"+i,i,__T(msg.notblank));
			return false;
		}
		if ( eval("F.pwd"+i).value == "" ) 
		{
			table_msg("img_pwd"+i,"pwd"+i,"div_pwd"+i,i,__T(msg.notblank));
			return false;
		}
		if ( tmp != "" ) tmp+=";";	
		if ( stflg == "add" || eval("F.pwd"+i).value != data[0][1] ) newpwd = encode_data(eval("F.pwd"+i).value);
		else newpwd = eval("F.pwd"+i).value;
		if ( typeof data[i] != "undefined" ) 
			tmp += data[i][2]+","+newpwd+","+eval("F.username"+i).value.length+","+eval("F.username"+i).value;
		else
			tmp += i+","+newpwd+","+eval("F.username"+i).value.length+","+eval("F.username"+i).value;
	}
	F.ipsec_user_entry.value = tmp;	
	return true;
}

function to_add()
{
	if ( idx >= IPSEC_USER_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,IPSEC_USER_ENTRY,__T(wl.useraccount)),"");
                return false;
        }
	stflg = "add";
	var tmp = new Array();
	tmp[0] = new Array("td_chk"+idx,"<input type=checkbox name=chk_"+idx+" id=chk_"+idx+" onclick=chk_click("+idx+") disabled>",3);
	tmp[1] = new Array("td_name"+idx,draw_td(O_VAR,ICONLINE,"img_name"+idx,"<input size=20 maxlength=63 name=username"+idx+" id=username"+idx+" onMouseMove=showHint('img_name"+idx+"','div_name"+idx+"',event) onMouseOut=hideHint('div_name"+idx+"')>","div_name"+idx),3);
	tmp[2] = new Array("td_pwd"+idx,draw_td(O_VAR,ICONLINE,"img_pwd"+idx,"<input type=password size=20 maxlength=63 name=pwd"+idx+" id=pwd"+idx+" onMouseMove=showHint('img_pwd"+idx+"','div_pwd"+idx+"',event) onMouseOut=hideHint('div_pwd"+idx+"')>","div_pwd"+idx));
	tmp[3] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_","add",2);
	idx++;
}

function chk_click(index)
{
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,newdata[index]);
	
}

function chk_all()
{
        if ( stflg == "add" ){
                document.getElementById("chkall").checked = false;
                choose_disable(document.getElementById("chkall"));
                return;
        } 
        for(var i=0; i<idx; i++)        
        {
                if ( document.getElementById("chk_"+i) == null ) continue;
                if ( document.getElementById("chkall").checked == true ) 
                        document.getElementById("chk_"+i).checked = true;
                else
                        document.getElementById("chk_"+i).checked = false;
                to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,newdata[i]);
        }
}

function to_import(F)
{
	get_position("users.asp",0);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=ipsecuser method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=stflg>
<input type=hidden name=ipsec_user_idx>
<input type=hidden name=ipsec_user_entry>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.user),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","t3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","t4",__T(share.del),"to_del(this.form)");
		bt_list[3] = new Array("BT","t5",__T(mang.importbt),"to_import(this.form)");
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20",__T(wl.useraccounttb),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T(mang.username)+","+__T(share.password),"",bt_list,"","","2,0,0");
		
		</script>	
		</TD></TR>
        	</TABLE>
  </TD></TR>
  <% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
