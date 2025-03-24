<html>
<head>
<title>Port Management</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
single_tb="true";
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(document.setup,"");

}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 4 ) 
	{
		document.location.href = goto_link("port_management.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 5000);
	}
}

function uiDoSave(F){
	for(var i=0; i<5; i++)
	{
		if ( ap_mode == 1 && i != 4 ) continue;
		if ( eval("F.en_"+i).checked == true )
			eval("F.port_manage_enable_"+i).value = 1;
		else
			eval("F.port_manage_enable_"+i).value = 0;
		if ( eval("F.jumbo_"+i).checked == true )
			eval("F.port_manage_jumbo_frame_"+i).value = 1;
		else
			eval("F.port_manage_jumbo_frame_"+i).value = 0;
		if ( eval("F.fc_"+i).checked == true )
			eval("F.port_manage_fc_"+i).value = 1;
		else
			eval("F.port_manage_fc_"+i).value = 0;
	}	
	F.submit_button.value = "port_management";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	setTimeout("chk_st()", 5000);
}
</script>
<body onload=init()>
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=port_manage_enable_0>
<input type=hidden name=port_manage_enable_1>
<input type=hidden name=port_manage_enable_2>
<input type=hidden name=port_manage_enable_3>
<input type=hidden name=port_manage_enable_4>
<input type=hidden name=port_manage_jumbo_frame_0>
<input type=hidden name=port_manage_jumbo_frame_1>
<input type=hidden name=port_manage_jumbo_frame_2>
<input type=hidden name=port_manage_jumbo_frame_3>
<input type=hidden name=port_manage_jumbo_frame_4>
<input type=hidden name=port_manage_fc_0>
<input type=hidden name=port_manage_fc_1>
<input type=hidden name=port_manage_fc_2>
<input type=hidden name=port_manage_fc_3>
<input type=hidden name=port_manage_fc_4>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.portmang));</script></TR>
  <TR><TD colspan=2>
		<script>
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"8,15,8,15,10,10",__T(router.portmangsettb),__T(share.port)+","+__T(router.link)+","+__T(share.enable)+","+__T(router.mode)+","+__T(router.jumboframe)+","+__T(router.flowcontrol),"","","","","1,0,2,2,2,2");
		var display_name="";
		var datalist = new Array();
		var tmpchk="";
		var tmp = new Array();
		<% get_port_st("datalist"); %>
		if ( ap_mode == "1" ) 
		{
			var nv_en_4 = "<% nvram_get("port_manage_enable_4"); %>";
			var port_4 = "<% nvram_get("port_manage_mode_4"); %>";
			var nv_jumbo_4 = "<% nvram_get("port_manage_jumbo_frame_4"); %>";
			var nv_fc_4 = "<% nvram_get("port_manage_fc_4"); %>";
			display_name = datalist[4]; 
			tmp[0] = new Array("td_port",__T(wan.wan),2);
			tmp[1] = new Array("td_link",display_name);
			if (( nv_en_4 == "1" ) || (nv_en_4 == ""))tmpchk = "checked";
			tmp[2] = new Array("td_en","<input type=checkbox name=en_4 "+tmpchk+">",3);
			var _name = new Array(__T(router.autoneg),__T(router.half10),__T(router.full10),__T(router.half100),__T(router.full100),__T(router.half1000),__T(router.full1000));
			var _val = new Array("0","1","2","3","4","5","6");
			tmp[3] = new Array("td_mode",draw_object(O_VAR,SELBOX,"port_manage_mode_4",port_4,_name,_val,port_4),3);
			tmpchk = "";
			if ( nv_jumbo_4 == "1" ) tmpchk = "checked";
			tmp[4] = new Array("td_jumbo","<input type=checkbox name=jumbo_4 "+tmpchk+">",3);
			tmpchk = "";
			if ( nv_fc_4 == "1" ) tmpchk = "checked";
			tmp[5] = new Array("td_fc","<input type=checkbox name=fc_4 "+tmpchk+">",3);
			tmp[6] = new Array("","&nbsp;");
			add_row(0,tmp,"","add",2);
		  
		}else{
	  	  for(var i=0; i<5; i++)
		  {
			var port_0 = "<% nvram_get("port_manage_mode_0"); %>";
			var port_1 = "<% nvram_get("port_manage_mode_1"); %>";
			var port_2 = "<% nvram_get("port_manage_mode_2"); %>";
			var port_3 = "<% nvram_get("port_manage_mode_3"); %>";
			var port_4 = "<% nvram_get("port_manage_mode_4"); %>";
			var nv_en_0 = "<% nvram_get("port_manage_enable_0"); %>";
			var nv_en_1 = "<% nvram_get("port_manage_enable_1"); %>";
			var nv_en_2 = "<% nvram_get("port_manage_enable_2"); %>";
			var nv_en_3 = "<% nvram_get("port_manage_enable_3"); %>";
			var nv_en_4 = "<% nvram_get("port_manage_enable_4"); %>";
			var nv_jumbo_0 = "<% nvram_get("port_manage_jumbo_frame_0"); %>";
			var nv_jumbo_1 = "<% nvram_get("port_manage_jumbo_frame_1"); %>";
			var nv_jumbo_2 = "<% nvram_get("port_manage_jumbo_frame_2"); %>";
			var nv_jumbo_3 = "<% nvram_get("port_manage_jumbo_frame_3"); %>";
			var nv_jumbo_4 = "<% nvram_get("port_manage_jumbo_frame_4"); %>";
			var nv_fc_0 = "<% nvram_get("port_manage_fc_0"); %>";
			var nv_fc_1 = "<% nvram_get("port_manage_fc_1"); %>";
			var nv_fc_2 = "<% nvram_get("port_manage_fc_2"); %>";
			var nv_fc_3 = "<% nvram_get("port_manage_fc_3"); %>";
			var nv_fc_4 = "<% nvram_get("port_manage_fc_4"); %>";
			if ( datalist[i] == "100Mbps Full Duplex" ) display_name = __T(router.fullduplex);
			else if ( datalist[i] == "100Mbps Half Duplex" ) display_name = __T(router.halfduplex);
			else display_name = datalist[i]; 
			if ( i == 4 ) 
				tmp[0] = new Array("td_port"+i,__T(wan.wan),2);
			else
				tmp[0] = new Array("td_port"+i,(i+1),2);
			tmp[1] = new Array("td_link"+i,display_name);
			tmpchk = "";
			if (( eval("nv_en_"+i) == "1" ) || ( eval("nv_en_"+i) == "" ))tmpchk = "checked";
			tmp[2] = new Array("td_en"+i,"<input type=checkbox name=en_"+i+" "+tmpchk+">",3);
			var _name = new Array(__T(router.autoneg),__T(router.half10),__T(router.full10),__T(router.half100),__T(router.full100),__T(router.half1000),__T(router.full1000));
			var _val = new Array("0","1","2","3","4","5","6");
			tmp[3] = new Array("td_mode"+i,draw_object(O_VAR,SELBOX,"port_manage_mode_"+i,"",_name,_val,eval("port_"+i)),3);
			tmpchk = "";
			if ( eval("nv_jumbo_"+i) == "1" ) tmpchk = "checked";
			tmp[4] = new Array("td_jumbo"+i,"<input type=checkbox name=jumbo_"+i+" "+tmpchk+">",3);
			tmpchk = "";
			if ( eval("nv_fc_"+i) == "1" ) tmpchk = "checked";
			tmp[5] = new Array("td_fc"+i,"<input type=checkbox name=fc_"+i+" "+tmpchk+">",3);
			tmp[6] = new Array("","&nbsp;");
			add_row(i,tmp,"","add",2);
                  }
		}
		if ( document.getElementById("tmsg") )
			document.getElementById("tmsg").innerHTML = "";
	</script>
	<% web_include_file("BT.asp"); %>
	<script>document.write("</TABLE></td></tr>");</script>
		</TABLE>
		
      </TD>
  </TR>
</TABLE>
	
</form>
</div></TABLE></TD></TR>
</body></HTML>
