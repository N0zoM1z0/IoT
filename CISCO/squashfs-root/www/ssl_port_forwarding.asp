<html>
<head>
<title>Resouorces</title>
<% web_include_file("filelink.asp"); %>
<script>
var app_idx=0, host_idx=0;
var app_obj_id=new Array("app_sip","app_num");
var app_td_id=new Array("td_app_sip","td_app_num");
var app_img_id=new Array("img_app_sip","img_app_num");
var app_div_id=new Array("div_app_sip","div_app_num");
var host_obj_id=new Array("host_sip","host_num");
var host_td_id=new Array("td_host_sip","td_host_num");
var host_img_id=new Array("img_host_sip","img_host_num");
var host_div_id=new Array("div_host_sip","div_host_num");
var app_datalist = new Array();
<% get_pf_app(); %>
var host_datalist = new Array();
<% get_pf_host(); %>
var app_stflg="init",host_stflg="init";
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.portal_layout;
	choose_disable(F.a2);
	choose_disable(F.h2);
	var var_list=new Array("app","host");
	for(var j=0; j<var_list.length; j++)
	{
		for(var i=0; i<eval(var_list[j]+"_datalist").length; i++)
		{
		var tmp = new Array();
		//tmp[0]=new Array(var_list[j]+"_tdchk_"+eval(var_list[j]+"_idx"),"<input type=checkbox onclick="+eval(var_list[j]+"_chk_click('"+app_idx+"') id=")+">",3);
		tmp[0]=new Array(var_list[j]+"_tdchk_"+eval(var_list[j]+"_idx"),"<input type=checkbox id="+var_list[j]+"_chk_"+eval(var_list[j]+"_idx")+" onclick="+var_list[j]+"_chk_click('"+eval(var_list[j]+"_idx")+"')>",3);
		tmp[1]=new Array(eval(var_list[j]+"_td_id[0]")+eval(var_list[j]+"_idx"),eval(var_list[j]+"_datalist[i][0]"),0);
		tmp[2]=new Array(eval(var_list[j]+"_td_id[1]")+eval(var_list[j]+"_idx"),eval(var_list[j]+"_datalist[i][1]"),j==0?2:0);
		tmp[3]=new Array("","",3);
		add_row(eval(var_list[j]+"_idx"),tmp,var_list[j]+"_chk_",eval(var_list[j]+"_stflg")+var_list[j],"","",3);
		if ( j==0 ) app_idx++;
		else host_idx++;
		}
	}
}

function app_chk_click(index)
{
        var count=0;
        for(var i=0; i<app_idx; i++)
        {
                if ( document.getElementById("app_chk_"+i).checked ) count++;
                
        }
        to_check("app_chk_",document.getElementById("app_chk_"+index).checked,"app"+index,app_idx,app_stflg,app_td_id,app_datalist[index]);
        choose_disable(document.getElementById("a1"));
        choose_disable(document.getElementById("a2"));
        if ( count > 0 )
                choose_enable(document.getElementById("a2"));
        if ( count == 0 ) 
                choose_enable(document.getElementById("a1"));

}

function host_chk_click(index)
{
        var count=0;
        for(var i=0; i<host_idx; i++)
        {
                if ( document.getElementById("host_chk_"+i).checked ) count++;
                
        }
        to_check("host_chk_",document.getElementById("host_chk_"+index).checked,"host"+index,host_idx,host_stflg,host_td_id,host_datalist[index]);
        choose_disable(document.getElementById("h1"));
        choose_disable(document.getElementById("h2"));
        if ( count > 0 )
                choose_enable(document.getElementById("h2"));
        if ( count == 0 ) 
                choose_enable(document.getElementById("h1"));

}

function chk_before_data(index)
{
	return true;
}
function to_host_add(F)
{
	to_add(F,"host");
}

function to_add(F,tbname)
{
	var img_id = eval(tbname+"_img_id");
	var obj_id = eval(tbname+"_obj_id");
	var div_id = eval(tbname+"_div_id");
	var td_id = eval(tbname+"_td_id");
	var idx = eval(tbname+"_idx");
	var ENTRY = eval("SSL_"+tbname.toUpperCase()+"_ENTRY");
	if ( idx >= ENTRY ) 
	{
		if ( tbname == "app" ) 
                	my_alert(O_PAGE,INFO,spell_words(max_rule,ENTRY,__T("Applications")),"");
		else
                	my_alert(O_PAGE,INFO,spell_words(max_rule,ENTRY,__T("Host Names")),"");
                return false;
	}
	if ( tbname == "app" ) app_stflg="addapp";
	else host_stflg="addhost";
	if ( !chk_before_data(idx-1) ) return false;
	var tmp = new Array();
	tmp[0] = new Array("tdchk_"+idx, "<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"') disabled>",3);
	tmp[1] = new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,img_id[0]+idx,"<input size=20 maxlength=15 id="+obj_id[0]+idx+" onMouseMove=showHint('"+img_id[0]+idx+"','"+div_id[0]+idx+"',event) onMouseOut=hideHint('"+div_id[0]+idx+"')>",div_id[0]+idx),1);
	if ( tbname == "app" ) 
	{
	tmp[2] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=10 maxlength=5 id="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx,"","align=right"),3);
	}else{
	tmp[2] = new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,img_id[1]+idx,"<input size=20 maxlength=127 id="+obj_id[1]+idx+" onMouseMove=showHint('"+img_id[1]+idx+"','"+div_id[1]+idx+"',event) onMouseOut=hideHint('"+div_id[1]+idx+"')>",div_id[1]+idx),1);
	}
	tmp[3] = new Array("","&nbsp;");
	add_row(idx,tmp,tbname+"_chk_",eval(tbname+"_stflg"),"","",3);
	if ( tbname == "app" ) app_idx++;
	else host_idx++;
	
}
function to_app_add(F)
{
	to_add(F,"app");
}

function ato_app_add(F)
{
	if ( idx > SSL_APP_ENTRY )
	{
                my_alert(O_PAGE,INFO,spell_words(max_rule,SSL_APP_ENTRY,__T(vpn.portallayouts)),"");
                return false;
	}
	app_stflg="add"; 
	if ( !chk_before_data(app_idx-1) ) return false;
	var tmp= new Array();
	tmp[0]=new Array("tdchk_"+app_idx,"<input type=checkbox id=chk_"+app_idx+" onclick=chk_click('"+app_idx+"') disabled>",3);
	tmp[1]=new Array(td_id[0]+idx,draw_td(O_VAR,ICONLINE,app_img_id[0]+idx,"<input size=20 maxlength=15 id="+app_obj_id[0]+app_idx+" onMouseMove=showHint('"+app_img_id[0]+app_idx+"','"+app_div_id[0]+app_idx+"',event) onMouseOut=hideHint('"+app_div_id[0]+app_idx+"')>",app_div_id[0]+app_idx),1);
	tmp[2]=new Array(td_id[1]+idx,draw_td(O_VAR,ICONLINE,app_img_id[1]+idx,"<input size=20 maxlength=5 id="+app_obj_id[1]+app_idx+" onMouseMove=showHint('"+app_img_id[1]+app_idx+"','"+app_div_id[1]+app_idx+"',event) onMouseOut=hideHint('"+app_div_id[1]+app_idx+"')>",app_div_id[1]+app_idx),1);
	tmp[3]=new Array("","&nbsp;");
	add_row(app_idx,tmp,"appchk_",app_stflg,"","",2);
	app_idx++;
}

function chk_click(index)
{
	var count=0;
	//for(var i=0; i<idx; i++)
}

function uiDoSave(F)
{
	var pf_entry="";
	for(var i=0; i<app_idx; i++)
	{
		if ( app_stflg == "addapp" ) 
		{
			if ( document.getElementById(app_obj_id[0]+i) )
			{
				if ( pf_entry != "" ) pf_entry+=";";
				pf_entry+=document.getElementById(app_obj_id[0]+i).value+","+document.getElementById(app_obj_id[1]+i).value;
			}
		}else if ( app_stflg == "delapp" ){
                       	if ( document.getElementById("app_chk_"+i) != null && 
	                     document.getElementById("app_chk_"+i).checked )
			{
				if ( pf_entry != "" ) pf_entry+=";";
				pf_entry+=document.getElementById(app_td_id[0]+i).innerHTML+","+document.getElementById(app_td_id[1]+i).innerHTML;
			}
		}
	}
	F.app_pf_entry.value=pf_entry;
	pf_entry="";
	for(var i=0; i<host_idx; i++)
	{
		if ( host_stflg == "addhost" ) 
		{
			if ( document.getElementById(host_obj_id[0]+i) )
			{
				if ( pf_entry != "" ) pf_entry+=";";
				pf_entry+=document.getElementById(host_obj_id[0]+i).value+","+document.getElementById(host_obj_id[1]+i).value;
			}
		}else if ( host_stflg == "delhost" ) 
                {
                        if ( document.getElementById("host_chk_"+i) != null && 
                             document.getElementById("host_chk_"+i).checked )
                        {
				if ( pf_entry != "" ) pf_entry+=";";
				pf_entry+=document.getElementById(host_td_id[0]+i).innerHTML+","+document.getElementById(host_td_id[1]+i).innerHTML;
                        }
                                
                }   		
	}
	F.app_stflg.value = app_stflg;
	F.host_stflg.value = host_stflg;
	F.host_pf_entry.value = pf_entry;
	//alert("app_pf_entry="+F.app_pf_entry.value+"\nF.host_pf_entry ="+F.host_pf_entry.value);
	//return;
	F.submit_button.value = "ssl_port_forwarding";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";

}

function to_app_del(F)
{
        app_stflg = "delapp";
        for(var i=0; i<app_idx; i++)
        {
                if ( document.getElementById("app_chk_"+i).checked == true )
                        document.getElementById("tr_tableapp"+i).className= "TABLECONTENT_DEL";
        }
        choose_disable(document.getElementById("a1"));
        
} 


function to_host_del(F)
{
	host_stflg = "delhost";
        for(var i=0; i<host_idx; i++)
        {
                if ( document.getElementById("host_chk_"+i).checked == true )
                        document.getElementById("tr_tablehost"+i).className= "TABLECONTENT_DEL";
	}
        choose_disable(document.getElementById("h1"));
	
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=portal_layout method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=app_stflg>
<input type=hidden name=host_stflg>
<input type=hidden name=selidx>
<input type=hidden name=app_pf_entry>
<input type=hidden name=host_pf_entry>
<input type=hidden name=pf_entry value=1>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("Port Forwarding"));</script></TR>
  <TR><TD colspan=2>
		<script>
		var app_bt_list = new Array();
		app_bt_list[0] = new Array("BT","a1",__T(share.addrow),"to_app_add(this.form)");
		app_bt_list[1] = new Array("BT","a2",__T(share.del),"to_app_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20",__T("Configured Applications for Port Forwarding Table"),"<input type=checkbox name=app_chkall id=app_chkall onclick=app_chk_all()>,"+__T("Local Server IP Address")+","+__T("TCP Port Number"),"",app_bt_list,"","app","2,0,1");
		var host_bt_list = new Array();
		host_bt_list[0] = new Array("BT","h1",__T(share.addrow),"to_host_add(this.form)");
		host_bt_list[1] = new Array("BT","h2",__T(share.del),"to_host_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,20",__T("Configured Host Names for Port Forwarding Table"),"<input type=checkbox name=host_chkall id=host_chkall onclick=host_chk_all()>,"+__T("Local Server IP Address")+","+__T("Fully Qualified Domain Name"),"",host_bt_list,"","host","2,0,0");
		</script>
		</TD></TR>
		<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
</TABLE>
</div>
</form>
</body></HTML>
