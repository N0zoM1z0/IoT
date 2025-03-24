<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var idx=0;
var stflg="init";
var auth_type = new Array(__T(wan.autonegotiation),__T(wan.pap),__T(wan.chap),__T(wan.mschap),__T(wan.mschap2));
var td_id = new Array("td_uname","td_upwd","td_auth","td_use"); 
var data = new Array();
var inused = "<% nvram_get("pppoe_select_profile"); %>";
<% get_pppoe_data("data"); %>
function to_add()
{
	if ( idx >= PPPOE_ENTRY )
	{
		my_alert(O_PAGE,INFO,spell_words(max_rule,PPPOE_ENTRY,__T(wan.pppoeps)),"");
		return false;	
	}	
	var F = document.frmpppoe;
	F.selidx.value = idx;
	F.stflg.value = "add";
	F.submit_button.value = "pppoe_profile_edit";
	F.change_action.value = "gozila_cgi";
	F.submit();
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

function get_data(F)
{
	var data = "";
	for(var i=0; i<idx; i++)
	{
		 if (document.getElementById("tr_table"+i) == null ) continue;
	         if ( stflg == "del" ){
                        if ( document.getElementById("tr_table"+i).className == "TABLECONTENT_DEL" ) 
                        {
				if ( data != "" ) data +=",";
				data += i;
			}
		}
	}
	return data;
}

function uiDoSave(F)
{
	F.pppoe_del.value = get_data(F);
	F.submit_button.value = "pppoe_profile";
	F.gui_action.value = "Apply";
	F.stflg.value=stflg;
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function to_edit(){
	stflg = "edit";
	var F = document.frmpppoe;
	var selindex=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			selindex=i;
			break;
		}
	}
	F.selidx.value = selindex;
	F.stflg.value = "edit";
	F.submit_button.value = "pppoe_profile_edit";
	F.change_action.value = "gozila_cgi";
	F.submit();
}

function chk_click(index)
{
	var count=0;
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) count++;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,data[index]);
	if ( count > 1 ) choose_disable(document.getElementById("t3"));
	if ( count == 0 ) choose_disable(document.getElementById("t4"));
		
}

function init(){
	var F = document.frmpppoe;
	parent.document.getElementById("save_bg").style.display="none";
	var tmp = new Array();
	var disflg = "";
	for (var i=0; i<data.length; i++)
	{
		disflg = "";
		if ( parseInt(inused,10) == i ) disflg = "disabled";
		tmp[0]=new Array("tdchk_"+i,"<input type=checkbox id=chk_"+i+" onclick=chk_click('"+i+"') "+disflg+">",3);
		tmp[1] = new Array(td_id[0]+i, data[i][0]);
		tmp[2] = new Array(td_id[1]+i, cy_speccode_decode(data[i][1]));
		tmp[3] = new Array(td_id[2]+i, auth_type[data[i][6]]);
		tmp[4] = new Array(td_id[3]+i, (parseInt(inused,10)==i)?__T(filter.yes):__T(filter.no),3);
		tmp[5] = new Array("", "&nbsp;");
		add_row(i, tmp, "chk_","init", 2);
		idx++;
	}
}

function prefix_ip(F){
	var str;
	for(var i=0; i<lan_arr.length; i++)
        {
                if ( lan_arr[i].vlan_id == F.vlan_id.value )
                {
                        str = (lan_arr[i].ipaddr).split(".");
                        break;
                }
        }
	return str[0]+" . "+str[1]+" . "+str[2]+" . ";
}

function chkall(F)
{
	var cnt=0;
	for(var i=0; i<idx; i++){
		if ( document.getElementById("chk_"+i) == null ) continue;
		if ( document.getElementById("chk_all").checked == true )
		{
                        document.getElementById("chk_"+i).checked = true;
			cnt++;
		}
                else
                        document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,data[i]);
	}	
	if ( cnt > 1 ) choose_disable(document.getElementById("t3"));
	if ( count == 0 ) choose_disable(document.getElementById("t4"));
}

</script>
</head>
<body onload=init()>
<FORM autocomplete=off id=frm name=frmpppoe method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name="selidx">
<input type=hidden name="stflg">
<input type=hidden name="pppoe_del">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wan.pppoeps));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		disflg = "";
		if ( inused != "" ) disflg = "disabled";
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,25,25,25,15",__T(wan.ptb),"<input type=checkbox name=chk_all id=chk_all onclick=chkall() "+disflg+">,"+__T(wan.pname)+","+__T(mang.username)+","+__T(wan.authtype)+","+__T(wan.inuse),"add,edit,del","","","","2,0,0,0,2");
		</script>
		</TR>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
