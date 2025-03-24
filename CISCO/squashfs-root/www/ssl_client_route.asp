<html>
<head>
<title>Configured Client Routes</title>
<% web_include_file("filelink.asp"); %>
<script>
var idx=0;
var td_id=new Array("tdchk","tdip","tdmask");
var datalist = new Array();
<% get_client_routes(); %> 
var stflg="init";
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.client_route;
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')><input type=hidden id='list_"+idx+"' value='"+i+"'>",3);
		tmp[1]=new Array(td_id[0]+idx,datalist[i][0],0);
		tmp[2]=new Array(td_id[1]+idx,datalist[i][1],0);
		tmp[3]=new Array("","",3);
		add_row(idx,tmp,"chk_",stflg,"","",3);
		idx++;
		
	}
}

function chk_before_data(index)
{
	return true;
}

function to_add(F)
{
	if ( idx >= CLIENT_ROUTE_ENTRY ) 
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,CLIENT_ROUTE_ENTRY,__T("SSL CLient Routes")),"");
                return false;
	}
	stflg="add";
	if( !chk_before_data(idx-1) ) return;
	var tmp = new Array();
	tmp[0]=new Array(td_id[0]+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,"ip_img"+idx,"<input size=20 maxlength=15 id=ip"+idx+" onMouseMove=showHint('ip_img"+idx+"','ip_div"+idx+"',event) onMouseOut=hideHint('ip_div"+idx+"')>","ip_div"+idx),1);
	tmp[2]=new Array(td_id[2]+idx,draw_td(O_VAR,ICONLINE,"mask_img"+idx,"<input size=20 maxlength=15 id=mask"+idx+" onMouseMove=showHint('mask_img"+idx+"','mask_div"+idx+"',event) onMouseOut=hideHint('mask_div"+idx+"')>","mask_div"+idx),1);
	tmp[3]=new Array("","&nbsp;");
	add_row(idx,tmp,"chk_",stflg,"","",3);
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
	if ( count > 0 ) 
		choose_enable(document.getElementById("t4"));
	if ( count == 0 ) 
		choose_enable(document.getElementById("t4"));
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

function uiDoSave(F)
{
	var entry="";
	for(var i=0; i<idx; i++)
	{
		if ( stflg == "add" ) 
		{
			if ( document.getElementById("ip"+i) )
			{
				if ( entry != "" ) entry+=";";
				entry += document.getElementById("ip"+i).value+","+
                                         document.getElementById("mask"+i).value;
			} 
		}else if ( stflg == "del" ) 
		{
			if ( document.getElementById("chk_"+i) != null && 
		     	     document.getElementById("chk_"+i).checked )
			{
				if ( entry != "" ) entry+=";";
				entry += document.getElementById(td_id[0]+i).innerHTML+","+
				         document.getElementById(td_id[1]+i).innerHTML;
			}	
		}
	}
	F.croute_entry.value = entry;
	//alert("entry="+entry);
	//return;
	F.stflg.value=stflg;
	F.submit_button.value = "ssl_client_route";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display=""; 
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=client_route method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=stflg>
<input type=hidden name=croute_entry>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Configured Client Routes"));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20",__T("Configured Client Routes Table"),"<input type=checkbox name=chkall id=chkall onclick=chk_all()>,"+__T("Destination Network")+","+__T("Subnet Mask"),"add,del","","","","2,0,0");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
<input type=hidden name=all_page_end>
</div>
</form>
</body></HTML>
