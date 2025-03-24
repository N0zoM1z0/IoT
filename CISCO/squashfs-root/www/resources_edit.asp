<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
<% get_res("all"); %>
var stflg = "<% nvram_gozila_get("stflg"); %>"; 
var selidx ="<% nvram_gozila_get("selidx"); %>";
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="resources.asp";
var ser_name = new Array(__T("VPN Tunnel"),__T("Port Forwarding"),__T("All"));
var obj_name_type = new Array(__T("IP Address"),__T("IP Network"));
var obj_val_type = new Array("1","2");
var idx=0;
var td_id = new Array("tdname","tdser","tdtype","tdaddr","tdmlen","tdbegin","tdend");
var obj_id = new Array("objname","objser","objtype","objaddr","objmlen","objbegin","objend");
var img_id = new Array("imgname","imgser","imgtype","imgaddr","imgmlen","imgbegin","imgend");
var div_id = new Array("divname","divser","divtype","divaddr","divmlen","divbegin","divend");
function refresh_page()
{
        alert_result(0);        
        var F = document.edit_res;
        F.selidx.value = selidx;
        F.stflg.value = stflg;
        F.submit_button.value = "resources_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	if (typeof  eval("objlist"+selidx) == undefined ) return;
	var olist = eval("objlist"+selidx);
	for(var i=0; i<olist.length; i++)
	{
		var tmp=new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[selidx][0],0);
		tmp[2]=new Array(td_id[1]+idx,ser_name[parseInt(datalist[selidx][1],10)-1],3);
		tmp[3]=new Array(td_id[2]+idx,obj_name_type[parseInt(olist[i][0],10)-1],3);
		tmp[4]=new Array(td_id[3]+idx,olist[i][1],0);
		if ( olist[i][0] == "1" ) 
			tmp[5]=new Array(td_id[4]+idx,"",2);
		else
			tmp[5]=new Array(td_id[4]+idx,olist[i][2],2);
		tmp[6]=new Array(td_id[5]+idx,olist[i][3],2);
		tmp[7]=new Array(td_id[6]+idx,olist[i][4],2);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
	}
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "resources.asp";
	uiDoCancel(F,"back");
}

function uiDoSave(F)
{
	var obj="";
	F.objname.value = datalist[selidx][0];
	F.objser.value = datalist[selidx][1];
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL") continue;
		if ( obj != "" ) obj+=";";
		if ( document.getElementById(obj_id[2]+i) )
		{
			obj+=document.getElementById(td_id[0]+i).innerHTML+",";
			for(var j=0; j<ser_name.length; j++)
			{
				if ( ser_name[j] == document.getElementById(td_id[1]+i).innerHTML ) 
				{
					obj+=(j+1)+",";
					break;
				}
			}
			obj+=document.getElementById(obj_id[2]+i).value+",";
			obj+=document.getElementById(obj_id[3]+i).value+",";
			if ( document.getElementById(obj_id[4]+i).value == "" ) 
				obj+="32,";
			else
				obj+=document.getElementById(obj_id[4]+i).value+",";
			obj+=document.getElementById(obj_id[5]+i).value+",";
			obj+=document.getElementById(obj_id[6]+i).value;
		}else{
			obj+=document.getElementById(td_id[0]+i).innerHTML+",";
                        for(var j=0; j<ser_name.length; j++)
                        {
                                if ( ser_name[j] == document.getElementById(td_id[1]+i).innerHTML ) 
                                {
                                        obj+=(j+1)+",";
                                        break;
                                }
                        }
			for(var j=0; j<obj_name_type.length; j++)
			{
				if ( obj_name_type[j] == document.getElementById(td_id[2]+i).innerHTML ) 
				{
					obj+=obj_val_type[j]+",";
					break;
				}
			}
                        obj+=document.getElementById(td_id[3]+i).innerHTML+",";
                        if ( document.getElementById(td_id[4]+i).innerHTML == "" ) 
                                obj+="32,";
                        else
                                obj+=document.getElementById(td_id[4]+i).innerHTML+",";
                        obj+=document.getElementById(td_id[5]+i).innerHTML+",";
                        obj+=document.getElementById(td_id[6]+i).innerHTML;
		}
		
	}
	F.resobj_entry.value = obj;
	//alert(obj);
	//return;
	F.submit_button.value = "resources";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function chg_type(index)
{
	if ( document.getElementById(obj_id[2]+index).selectedIndex == 0 ) //IP address
		choose_disable( document.getElementById(obj_id[4]+index));
	else
		choose_enable( document.getElementById(obj_id[4]+index));
}

function to_add()
{
	if ( idx >= EA_RESOBJ_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,EA_RESOBJ_ENTRY,__T("Resources")),"");
                return false;
	}
	var tmp=new Array();
	tmp[0] = new Array("tdchk_"+idx, "<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx,datalist[selidx][0],0);
	tmp[2] = new Array(td_id[1]+idx,ser_name[parseInt(datalist[selidx][1],10)-1],3);
        tmp[3] = new Array(td_id[2]+idx,draw_object(O_VAR,SELBOX,obj_id[2]+idx,"id="+obj_id[2]+idx+" onchange=chg_type("+idx+")",obj_name_type,obj_val_type),3);
	tmp[4] = new Array(td_id[3]+idx,draw_td(O_VAR,ICONLINE,img_id[3]+idx,"<input size=20 maxlength=64 id="+obj_id[3]+idx+" onMouseMove=showHint('"+img_id[3]+idx+"','"+div_id[3]+idx+"',event) onMouseOut=hideHint('"+div_id[3]+idx+"')>",div_id[3]+idx,""),2);
	tmp[5] = new Array(td_id[4]+idx,draw_td(O_VAR,ICONLINE,img_id[4]+idx,"<input disabled size=5 maxlength=2 id="+obj_id[4]+idx+" onMouseMove=showHint('"+img_id[4]+idx+"','"+div_id[4]+idx+"',event) onMouseOut=hideHint('"+div_id[4]+idx+"')>",div_id[4]+idx,"","align=right"),2);
	tmp[6] = new Array(td_id[5]+idx,draw_td(O_VAR,ICONLINE,img_id[5]+idx,"<input size=5 maxlength=5 id="+obj_id[5]+idx+" onMouseMove=showHint('"+img_id[5]+idx+"','"+div_id[5]+idx+"',event) onMouseOut=hideHint('"+div_id[5]+idx+"')>",div_id[5]+idx,"","align=right"),2);
	tmp[7] = new Array(td_id[6]+idx,draw_td(O_VAR,ICONLINE,img_id[6]+idx,"<input size=5 maxlength=5 id="+obj_id[6]+idx+" onMouseMove=showHint('"+img_id[6]+idx+"','"+div_id[6]+idx+"',event) onMouseOut=hideHint('"+div_id[6]+idx+"')>",div_id[6]+idx,"","align=right"),2);
        add_row(idx,tmp,"chk_","add","","",3);
        idx++;
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
        choose_disable(document.getElementById("t4"));
	if ( count == 0 ) 
        	choose_enable(document.getElementById("t2"));
	if ( count > 0 ) 
        	choose_enable(document.getElementById("t4"));
		
}

function to_del(F)
{
        stflg = "del";
        for(var i=0; i<idx; i++)
        {
                if ( document.getElementById("chk_"+i).checked == true )
                                del_row(i);
        }
}



</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=edit_res method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=objname>
<input type=hidden name=objser>
<input type=hidden name=resobj_entry>
<input type=hidden name=selidx value="<% nvram_gozila_get("selidx"); %>">
<input type=hidden name=backname>
<input type=hidden name=stflg value="<% nvram_gozila_get("stflg"); %>">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T("Resource Configuration"),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,10,15,20,15,15,15",__T("Resource Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Name")+","+__T("Service")+","+__T("Object Type")+","+__T("Object Address")+","+__T("Mask Length")+","+__T("Port Begin")+","+__T("Port End"),"add,del","","","","2,0,2,2,0,1,1,1");
		
		</script>
  </TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
