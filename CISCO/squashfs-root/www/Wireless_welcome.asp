<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var nv_gn_profile_0 = "<% nvram_get("gn_profile_0"); %>";
var nv_gn_profile_1 = "<% nvram_get("gn_profile_1"); %>";
var nv_gn_profile_2 = "<% nvram_get("gn_profile_2"); %>";
var nv_gn_profile_3 = "<% nvram_get("gn_profile_3"); %>";
var wlist = new Array();
<% get_guest_profile("wlist"); %>
var idx=0;
var stflg = "init";
var td_id = new Array("tdname","tdurl");
function init(){
	var F = document.frmwwel;
	parent.document.getElementById("save_bg").style.display="none";
	var tmp = new Array();
	for(var i=0; i<wlist.length; i++)
	{
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"')>",3);
		tmp[1] = new Array("tdname"+i, wlist[i][0]);
		tmp[2] = new Array("tdurl"+i, wlist[i][1]);
		tmp[3] = new Array("", "&nbsp;");
		add_row(i,tmp,"chk_",stflg,2);
		idx++;
	}
	default_nv = keep_val(F,"");
}

function to_edit(index)
{
	var F = document.frmwwel;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			F.now_idx.value = i;
			break;
		}
	}
	F.submit_button.value = "Wireless_welcome_edit";
	F.change_action.value = "gozila_cgi";
	F.stflg.value = "edit";
	F.submit();
	
}

function to_add()
{
	var F = document.frmwwel;
	if ( idx >= PROFILE_MAX_ENTRY )
	{
		my_alert(O_GUI,INFO,__T(share.warnmsg),spell_words(max_rule,PROFILE_MAX_ENTRY,__T(wl.profilename)));
		return;
	} 
	F.submit_button.value = "Wireless_welcome_edit";
	F.change_action.value = "gozila_cgi";
	F.now_idx.value = idx;
	F.stflg.value = "add";
	F.submit();
}

function chk_click(index)
{
	var new_wlist = new Array();
	new_wlist[0] = wlist[index][0];	
	new_wlist[1] = wlist[index][1];	
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,new_wlist);
}

function to_del(){
	stflg = "del";
	var todel=1;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			for(var j=0; j<4; j++)
			{
				if ( eval("nv_gn_profile_"+j) == "-3" ) continue;
				if ( wlist[i][0] == eval("nv_gn_profile_"+j) ) 
				{
					my_alert(O_PAGE,WARNING,__T(wl.delguestmsg));
					todel=0;
				}
				
			}
			if ( todel == 1 ) del_row(i);
		}
	}
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("Wireless_welcome.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F)
{
	var str,data="";
	var errflg = 0;
	F.wel_del.value = "";
	for(var i=0; i<idx; i++)
	{
		if (document.getElementById("tr_table"+i) == null ) continue;
                if ( stflg == "del" )
                {
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" )
                        {
				if ( parseInt(wlist[i][17],10) > 0 ) 
				{
					document.getElementById("tdchk_"+i).innerHTML = draw_td(O_VAR,ICONLINE,"img"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"') checked onMouseMove=showHint('img"+i+"','div"+i+"',event) onMouseOut=hideHint('div"+i+"')>","div"+i);
					errflg=1;
					table_msg("img"+i,"","div"+i,i,__T(msg.rulereserved));
				}else{ 
					if ( F.wel_del.value != "" ) F.wel_del.value+=" ";
					F.wel_del.value += i;
				}
                        }
                }
	}
	if ( errflg == 0 ) 
	{
		F.submit_button.value = "Wireless_welcome";
		F.stflg.value = "del";
		F.gui_action.value = "Apply";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
		if ( http_from == "wan" ) 
		{
			setTimeout("chk_st()", 15000);
		}	
	}
}

function chkall(F)
{
	var new_wlist = new Array();
	for(var i=0; i<idx; i++)
	{
		new_wlist[0] = wlist[i][0];
		new_wlist[1] = wlist[i][1];
		if ( F.chk_all.checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,new_wlist);
		
	}
	choose_disable(document.getElementById("t3"));
 
}

function refresh_page(){
	var F = document.frmsch;
	alert_result(0);
	F.submit_button.value = "schedule_manage";
	F.change_action.value= "gozila_cgi";
	F.backname.value = "<% nvram_gozila_get("backname"); %>";
	F.submit();
}
</script>
<body onload="init();">
<FORM id="frm" name=frmwwel method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=now_idx>
<input type=hidden name=wel_del>
<input type=hidden name=stflg>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.portalprofile));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,40",__T(wl.welcometb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(wl.profilename)+","+__T(wl.redirect),"add,edit,del","","","","2,0,0,0,0");
		</script>
		
      </TD>
  </TR>
  <% web_include_file("BT.asp"); %>
</TABLE>
</form>
</div></TABLE></TD></TR>
</body></HTML>
