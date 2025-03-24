<html>
<head>
<title>Basic Wireless Settings</title>
<% web_include_file("filelink.asp"); %>
<script>
var wds_enable = "<% nvram_get("wl_wds_enable"); %>";
var REPEATER=0;
var BRIDGE=1;
var wds_mode, rept_mode;
var nv_wds_mode = "<% nvram_get("wl_wds_mode"); %>"; 
if ( nv_wds_mode == "repeater" ) 
	wds_mode = REPEATER;
else if ( nv_wds_mode == "bridge") 
	wds_mode = BRIDGE;
var BY_REPT=0;
var BY_SELF=1;
var nv_rept_mode = "<% nvram_get("wl_wds_repeater_mode"); %>"; 
if ( nv_rept_mode == "signal_repeated_by_self" )
	rept_mode = BY_SELF;
else if ( nv_rept_mode == "signal_repeated_by_other" ) 
	rept_mode = BY_REPT; 
var port_num=4;
if ( ap_mode == "1" ) port_num = 1;
var pri_name = new Array("0","4096","8192","12288","16384","20480","24576","28672","32768","36864","40960","45056","49152","53248","57344","61440");
var port_add_item = new Array(spell_words(wdsrepeatermac,"1"),spell_words(wdsrepeatermac,"2"),spell_words(wdsrepeatermac,"3"),spell_words(wdsrepeatermac,"4"),__T(wl.wesreprmac),spell_words(wdsbridgemac,"1"),spell_words(wdsbridgemac,"2"),spell_words(wdsbridgemac,"3"),spell_words(wdsbridgemac,"4"));
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.rstpfrm;
	var j=1;
	var disflg="";
	var nvi=0;
	for(var i=0; i<port_num+port_add_item.length; i++)
	{
		var tmp = new Array();
		if ( i >= port_num ) 
		{
			if ( current_model_name == "RV130" ) break;
			tmp[0] = new Array("tdid"+i,port_add_item[i-port_num],2);
			if ( ap_mode == "1" ) 
				nvi=i+4;
			else
				nvi=i+1;
		}
		else
		{
			if ( ap_mode == "1" ) 
			{
	                        tmp[0] = new Array("tdid"+i,__T(wan.wan),2);
				nvi=14;
			}
			else
			{
				tmp[0] = new Array("tdid"+i,spell_words(lanandindex,j),2);
				j++;
				nvi=i+1;
			}
		}
		disflg="";
		if ( wds_enable == "0" && i >= port_num ) disflg = "disabled";
		if ( wds_enable == "1" ) 
		{
			if ( wds_mode == REPEATER ) 
			{
				if ( rept_mode == BY_REPT && i >= port_num+4 ) 
					disflg = "disabled";
				if ( ap_mode == "1" ) 
				{
					if ( rept_mode == BY_SELF && i >= port_num && i != 5 ) 
						disflg = "disabled";
				}else{
					if ( rept_mode == BY_SELF && i >= port_num && i != 8 ) 
						disflg = "disabled";
				}
			}else if ( wds_mode == BRIDGE )
			{
				if ( i >= port_num && i < port_num+5 ) 
					disflg = "disabled";
			} 
		}
		tmp[1] = new Array("tdpen"+i,"<input type=checkbox name=_rstp_port"+nvi+"_enable "+disflg+">",3);
		tmp[2] = new Array("tdedge"+i,"<input type=checkbox name=_rstp_port"+nvi+"_edge "+disflg+">",3);
		tmp[3] = new Array("tdpathcost"+i,draw_td(O_VAR,ICONLINE,"img_pathcost"+nvi,"<input size=20 maxlength=9 name=rstp_port"+nvi+"_pathcost id=rstp_port"+nvi+"_pathcost value=0 onblur=chk_valid_pathcost("+nvi+","+i+") onMouseMove=showHint('img_pathcost"+nvi+"','div_pathcost"+nvi+"',event) onMouseOut=hideHint('div_pathcost"+nvi+"') "+disflg+">","div_pathcost"+nvi),1);
		tmp[4] = new Array("","&nbsp;");
		add_row(i,tmp,"","show",2);
	}
	var nv_rstp_hellotime = "<% nvram_get("rstp_hellotime"); %>";
	if ( nv_rstp_hellotime != "" ) F.rstp_hellotime.value = nv_rstp_hellotime;
	var nv_rstp_maxage = "<% nvram_get("rstp_maxage"); %>";
	if ( nv_rstp_maxage != "" ) F.rstp_maxage.value = nv_rstp_maxage;
	var nv_rstp_fdelay = "<% nvram_get("rstp_fdelay"); %>";
	if ( nv_rstp_fdelay != "" ) F.rstp_fdelay.value = nv_rstp_fdelay;
	var nv_rstp_priority = "<% nvram_get("rstp_priority"); %>";
	if ( nv_rstp_priority != "" ){
		for(var i=0; i<pri_name.length; i++)
		{
			if ( nv_rstp_priority == pri_name[i] ) 
			{
				F.rstp_priority[i].selected = true;
				break;
			}
		}	
	}
	var nv_rstp_fversion = "<% nvram_get("rstp_fversion"); %>";
	if ( nv_rstp_fversion != "" ) F.rstp_fversion[nv_rstp_fversion].checked = true;
	//var enable_list = new Array();
	//var edge_list = new Array();
	//var pathcost_list = new Array();
	<% get_rstp_data(); %>
	
	for(var i=0; i<enable_list.length; i++)
	{
		if ( ap_mode == "1" && i == 0 )
		{
			if ( enable_list[13] != "" && enable_list[13] == "1") 
				eval("F._rstp_port14_enable").checked = true;
			if ( edge_list[13] != "" && edge_list[13] == "1") 
				eval("F._rstp_port14_edge").checked = true;
			if ( pathcost_list[13] != "" ) 
				eval("F.rstp_port14_pathcost").value = pathcost_list[12]; 
			i+=4;
		}else{ 
			
			if ( enable_list[i] != "" && enable_list[i] == "1" ) 
				eval("F._rstp_port"+(i+1)+"_enable").checked = true;
			if ( edge_list[i] != "" && edge_list[i] == "1") 
				eval("F._rstp_port"+(i+1)+"_edge").checked = true;
			if ( pathcost_list[i] != "" ) 
				eval("F.rstp_port"+(i+1)+"_pathcost").value = pathcost_list[i];
		}
	}
	default_nv = keep_val(F,"");
	
}

function CHK_VALID(F)
{
	var errflg=0;
	var en="",edge="";
	var cnt=0;
	if ( !msg_chk_range(F.rstp_hellotime.value,"rstp_hellotime",1,10,10,IS_FIELD,0,"msg_hellotime")) errflg=1;
	if ( !msg_chk_range(F.rstp_maxage.value,"rstp_maxage",6,40,10,IS_FIELD,0,"msg_maxage")) errflg=1;
	if ( !msg_chk_range(F.rstp_fdelay.value,"rstp_fdelay",4,30,10,IS_FIELD,0,"msg_fdelay")) errflg=1;
	if ( errflg == 0 ) 
	{
		var hellotime = parseInt(F.rstp_hellotime.value, 10);
		var maxage = parseInt(F.rstp_maxage.value, 10);
		var fdelay = parseInt(F.rstp_fdelay.value, 10);
		if ( 2*(fdelay-1) < maxage ) 
		{
			my_alert(O_VAR,"rstp_maxage",__T(lan.rsptmsg1),0,"msg_maxage");
			errflg = 1; 
		} 
		if ( maxage < 2*(hellotime+1) ) 
		{
			my_alert(O_VAR,"rstp_maxage",__T(lan.rsptmsg2),0,"msg_maxage");
			errflg = 1; 
		}
	}
	for(var i=1; i<=14; i++)
	{
		if ( !chk_valid_pathcost(i,cnt)) errflg=1;

		if ( en != "" ) en+=" ";
		if ( eval("F._rstp_port"+i+"_enable") )
		{
			if ( eval("F._rstp_port"+i+"_enable").checked == true ) en+="1";
			else en+="0";
		}else{ 
			en+="NULL";
			cnt++;
		}
		
		if ( edge != "" ) edge+=" ";
		if ( eval("F._rstp_port"+i+"_edge") )
		{
			if ( eval("F._rstp_port"+i+"_edge").checked == true ) edge+="1";
			else edge+="0";
		}else edge+="NULL";
			
	}
	if ( errflg == 1 ) return false;
	F.rstp_port_enable.value = en;
	F.rstp_port_edge.value = edge;
	return true;
}

function uiDoSave(F)
{
	if ( !CHK_VALID(F))return false;
	F.submit_button.value="RSTP";
	F.submit();
	var tmp = parseInt(parseInt(F.rstp_fdelay.value,10)*2/5,10);
	var waittime = (tmp+2)*5;
	
	for(var i=1; i<=14; i++)
	{
		if (  eval("F._rstp_port"+i+"_enable") ) 
		{
			if ( eval("F._rstp_port"+i+"_enable").checked == true && eval("F._rstp_port"+i+"_edge").checked == false ) 
			{
				window.parent.savebg_init();
				parent.document.getElementById("save_time_bg").style.display="";
				return;
			}
		}
	}
	parent.document.getElementById("save_bg").style.display="";
}

function chk_valid_pathcost(index,cnt)
{
	if ( document.getElementById("rstp_port"+index+"_pathcost") ) 
	{
		if ( !msg_chk_range(document.getElementById("rstp_port"+index+"_pathcost").value,"rstp_port"+index+"_pathcost",0,200000000,10,IS_TABLE,"tmsg","img_pathcost"+index,"div_pathcost"+index,cnt) ) 
			return false;
	}
	return true;
}
</script>
</head>
<body onload=init() onresize=chgwin()>
<FORM autocomplete=off id=frm name=rstpfrm method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=submit_type>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=rstp_port_enable value=1>
<input type=hidden name=rstp_port_edge>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.rstp));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.systempri));</script>
		<script>
			draw_object(O_GUI,SELBOX,"rstp_priority","",pri_name,pri_name,"32768");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.hellotime));</script>
		<input size=10 maxlength=2 value=2 name=rstp_hellotime id=rstp_hellotime onblur=msg_chk_range(this.value,"rstp_hellotime",1,10,10,IS_FIELD,0,"msg_hellotime")>
		<script>document.write(__T(unit.seconds)+"&nbsp;&nbsp;"+spell_words(range_def_rule,"1","10","2")); </script>
		<span id=msg_hellotime></span>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.maxage));</script>
		<input size=10 maxlength=2 value=20 name=rstp_maxage id=rstp_maxage onblur=msg_chk_range(this.value,"rstp_maxage",6,40,10,IS_FIELD,0,"msg_maxage")>
		<script>document.write(__T(unit.seconds)+"&nbsp;&nbsp;"+spell_words(range_def_rule,"6","40","20")); </script>
		<span id=msg_maxage></span>
        	</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(lan.forwarddelay));</script>
		<input size=10 maxlength=2 value=15 name=rstp_fdelay id=rstp_fdelay onblur=msg_chk_range(this.value,"rstp_fdelay",4,30,10,IS_FIELD,0,"msg_fdelay")>
		<script>document.write(__T(unit.seconds)+"&nbsp;&nbsp;"+spell_words(range_def_rule,"4","30","15")); </script>
		<span id=msg_fdelay></span>
        	</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(lan.forcever));
		var _name = new Array(__T(def.normal),__T(lan.compatile));
		var _val = new Array("0","1");
		draw_object(O_GUI,RADIO,"rstp_fversion",_val,_name,"0");</script>
		</script>
	        </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,20,20,25",__T(lan.settingtb),""+__T(share.port)+","+__T(lan.protoen)+","+__T(lan.edge)+","+__T(lan.pathcost)+"","","","","","1,2,2,0");
		</script>
     </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
