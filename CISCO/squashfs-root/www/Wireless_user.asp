<html>
<head>
<script type="text/javascript" src="/md5.js"></script>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var idx=0;
var stflg="init";
var obj_id = new Array("name","pwd","cpwd","acctime");
var img_id = new Array("imgname","imgpwd","imgcpwd","imgacctime");
var div_id = new Array("divname","divpwd","divcpwd","divacctime");
var td_id = new Array("tdname","tdpwd","tdcpwd","tdacctime");
<% web_include_file("create_obj.js"); %>
var glist = new Array();
<% get_guest_list(); %>
//glist[0]=new Array('test1','505c8c8143fe8f4b8a7ad6e69236fd4c','1');
//glist[1]=new Array('test2','547cc4ebfb62b624551b6cb40517a5bd','2');
var new_glist = new Array();
for(var i=0; i<glist.length; i++)
{
	new_glist[i] = new Array(glist[i][0],"************","************",glist[i][2]);
}

function en_value(data)
{
        var pseed2="";
        var buffer1=data;
        var md5Str2="";
        var Length2 = data.length;
        if (Length2 < 10 )
        {
                buffer1 += "0";
                buffer1 += Length2;
        }else{
                buffer1 += Length2;
        }
        Length2 = Length2 +2;

        for(var p=0; p<64; p++) {
                var tempCount = p % Length2;
                pseed2 += buffer1.substring(tempCount, tempCount+1);
        }
        md5Str2 = hex_md5(pseed2);
        return md5Str2;
}

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frmwuser;
	var tmp = new Array();
	for(var i=0; i<glist.length; i++)
	{
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"')>",3);
		tmp[1] = new Array(td_id[0]+i, glist[i][0]);
		tmp[2] = new Array(td_id[1]+i, new_glist[i][1]);
		tmp[3] = new Array(td_id[2]+i, new_glist[i][1]);
		tmp[4] = new Array(td_id[3]+i, glist[i][2],2);
		tmp[5] = new Array("", "&nbsp;");
		add_row(i,tmp,"chk_",stflg,2);
		idx++;
	}
	default_nv = keep_val(F,"");
}

function to_edit(index)
{
	var F = document.frmwuser;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			var tmp = new Array();
			stflg="edit";
			tmp[0] = draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=64 name="+obj_id[0]+i+" id="+obj_id[0]+i+" onblur=chk_name('0','"+i+"') value='"+glist[i][0]+"' onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"')>",div_id[0]+i);
			tmp[1] = draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=20 type=password maxlength=64 name="+obj_id[1]+i+" id="+obj_id[1]+i+" value='"+glist[i][1]+"' onblur=chk_name('1','"+i+"') onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"')>",div_id[1]+i);
			tmp[2] = draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=20 type=password maxlength=64 name="+obj_id[2]+i+" id="+obj_id[2]+i+" value='"+glist[i][1]+"' onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') onblur=chk_name('2','"+i+"')>",div_id[2]+i);
			tmp[3] = draw_td(O_VAR,ICONLINE,img_id[3]+i,"<input size=20 maxlength=4 name="+obj_id[3]+i+" id="+obj_id[3]+i+" value='"+glist[i][2]+"' onMouseMove=showHint('"+img_id[3]+i+"','"+div_id[3]+i+"',event) onMouseOut=hideHint('"+div_id[3]+i+"') onblur=my_msg_chk_range(this.value,'"+obj_id[3]+i+"',0,1440,'"+img_id[3]+i+"','"+div_id[3]+i+"')>",div_id[3]+i);
			edit_row(td_id, tmp, i);
		}
	}
	
}
function my_msg_chk_range(val,obj_id,start,end,img_id,div_id)  
{
	if ( !msg_chk_range(val,obj_id,0,1440,10,IS_TABLE,'tmsg',img_id,div_id,0) )
	{
		if ( document.getElementById("div_msg"+div_id).innerHTML.indexOf(__T(wl.nolimit)) == -1 ) 
			document.getElementById("div_msg"+div_id).innerHTML += " ,"+__T(wl.nolimit);	
		return false;
	}
	return true;
}

function chk_before_data(index)
{
	var e1, e2;
	if ( document.getElementById(obj_id[0]+index) ){
		if ( !chk_name('0', index) ) return false;
		if ( !chk_name('1', index) ) return false;
		if ( !my_msg_chk_range(document.getElementById(obj_id[3]+index).value,obj_id[3]+index,0,1440,img_id[3]+index,div_id[3]+index) ) 
		{
			return false;
		}
		clear_table_msg("",img_id[2]+index,obj_id[2]+index,index);
		if ( document.getElementById(obj_id[1]+index).value != 
		     document.getElementById(obj_id[2]+index).value )
		{
			table_msg(img_id[2]+index,obj_id[2]+index,div_id[2]+index,index,__T(msg.pwdinvmatch));
			return false;
		}
		e1 = document.getElementById(obj_id[0]+index).value;
		for(j=0; j<idx; j++)
		{
			if ( j == index ) continue;
			if ( document.getElementById(obj_id[0]+j) != null ) 
			 	e2 = document.getElementById(obj_id[0]+j).value;
			else
			 	e2 = document.getElementById(td_id[0]+j).innerHTML;
			if ( e1 == e2 ) 
			{
				if ( document.getElementById(obj_id[0]+j) != null ) 
					table_msg(img_id[0]+j,obj_id[0]+j,div_id[0]+j,j,__T(msg.nameexist));
				if ( document.getElementById(obj_id[0]+index) != null ) 
					table_msg(img_id[0]+index,obj_id[0]+index,div_id[0]+index,index,__T(msg.nameexist));
				return false;	
			}
		}
		
	}
	return true;
}

function chk_name(id,index)
{
	clear_table_msg("tmsg",img_id[id]+index,obj_id[id]+index,index);
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_id[id]+index).value,ZERO_NO|SPACE_NO); 
	if ( returnmsg != "" ) 
	{
		table_msg(img_id[id]+index,obj_id[id]+index,div_id[id]+index,index, returnmsg);
		return false;
	}
	return true;
}

function chk_click(index)
{
	
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,new_glist[index]);
}

function to_add()
{
	var F = document.frmwuser
	if ( idx >= GUESTNET_USER_ENTRY )
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,GUESTNET_USER_ENTRY,__T(wl.useraccount)),"");
		return false;
	} 
	if ( !chk_before_data(idx-1) ) return false;
	var tmp = new Array();
	stflg="add";
	tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=64 name="+obj_id[0]+idx+" id="+obj_id[0]+idx+" onblur=chk_name('0','"+idx+"') onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	tmp[2] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=20 type=password maxlength=64 name="+obj_id[1]+idx+" id="+obj_id[1]+idx+" onblur=chk_name('1','"+idx+"') onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx),1);
	tmp[3] = new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,img_id[2]+idx,"<input size=20 type=password maxlength=64 name="+obj_id[2]+idx+" id="+obj_id[2]+idx+" onMouseMove=showHint('"+img_id[2]+idx+"','"+div_id[2]+idx+"',event) onMouseOut=hideHint('"+div_id[2]+idx+"') onblur=chk_name('2','"+idx+"')>",div_id[2]+idx),1);
	tmp[4] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=20 maxlength=4 name="+obj_id[3]+idx+" id="+obj_id[3]+idx+" onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"') value=60 onblur=my_msg_chk_range(this.value,'"+obj_id[3]+idx+"',0,1440,'"+img_id[3]+idx+"','"+div_id[3]+idx+"')>",div_id[3]+idx),1);
	tmp[5] = new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,2);
	idx++;
}

function to_del(){
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			del_row(i);
		}
	}
}

function uiDoSave(F)
{
	var str,data="";
	var errflg = 0;
	for(var i=0; i<idx; i++)
	{
                if ( stflg == "del" )
                {
			if (document.getElementById("tr_table"+i) == null ) continue;
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
			{
				if ( data != "" ) data += ";";
				data += glist[i][1]+",";
				data += cy_speccode_decode(document.getElementById(td_id[0]+i).innerHTML).length+",";
				data += cy_speccode_decode(document.getElementById(td_id[0]+i).innerHTML);
			}
                }else{
			if ( !chk_before_data(i) ) return false;
			if ( document.getElementById(obj_id[0]+i) != null ) 
			{
				if ( data != "" ) data += ";";
				data += i+",";
				data += document.getElementById(obj_id[3]+i).value+",";
				if ( i >= glist.length || (document.getElementById(obj_id[1]+i).value != glist[i][1]) ) 
					data += en_value(document.getElementById(obj_id[1]+i).value)+",";
				else
					data += glist[i][1]+",";
				data += document.getElementById(obj_id[0]+i).value.length+",";
				data += document.getElementById(obj_id[0]+i).value;
				
			}/*else{
				data += document.getElementById(td_id[3]+i).innerHTML+",";
				data += glist[i][1]+",";
				data += document.getElementById(td_id[0]+i).innerHTML.length+",";
				data += document.getElementById(td_id[0]+i).innerHTML;
			}*/
		}
	}
	F.gn_list.value = data;
	if ( errflg == 0 ) 
	{
		F.submit_button.value = "Wireless_user";
		F.gui_action.value="Apply";
		F.stflg.value = stflg;
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
}

function chkall(F)
{
	for(var i=0; i<idx; i++)
	{
		if ( F.chk_all.checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,new_glist[i]);
		
	}
	choose_disable(document.getElementById("t3"));
 
}

function to_import(F)
{
	get_position("users.asp",0);
}

</script>
<body onload="init();">
<FORM id="frm" name=frmwuser method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=gn_list>
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.useraccount));</script></TR>
  <TR><TD colspan=2>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","t3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","t4",__T(share.del),"to_del(this.form)");
		bt_list[3] = new Array("BT","t5",__T(mang.importbt),"to_import(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20,20,20",__T(wl.useraccounttb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(share.username)+","+__T(share.password)+","+__T(share.verifypwd)+","+__T(wl.acctime),"",bt_list,"","","2,0,0,0,1");
		</script>
		
      </TD>
  </TR>
  <% web_include_file("BT.asp"); %>
</TABLE>
</form>
</div></TABLE></TD></TR>
</body></HTML>
