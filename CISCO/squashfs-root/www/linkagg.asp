<html>
<head>
<title>Port Management</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
single_tb="true";
var lag0 = "<% nvram_get("lag_0"); %>";
var lag1 = "<% nvram_get("lag_1"); %>";

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	refresh();
	default_nv = keep_val(document.frmlink,"");

}
function uiDoSave(F){
	for (var j=0; j<4; j++)
        {
                if ( document.getElementById("chk_"+j+"_0").checked==true &&
                     document.getElementById("chk_"+j+"_1").checked==true )
                {
                        my_alert(O_GUI,INFO,__T(share.info),__T(msg.linkagg_port),"alert_result(0)");
                        return;
                }  
        }
	my_alert(O_GUI,WARNING,__T(share.info),__T(msg.linkagg),"link_result(1)","link_result(0)","","yesno");
}

function link_result(ret)
{
	var F = document.frmlink;
	alert_result(0);
	if ( ret == 0 ) return;
	for(var i=0; i<2; i++)
	{
		eval("F.lag_"+i).value = "";
		for(var j=0; j<4; j++)
		{
			if ( eval("F.lag_"+i).value != "" ) eval("F.lag_"+i).value += " ";
			eval("F.lag_"+i).value += (document.getElementById("chk_"+j+"_"+i).checked==true)?'1':'0';
		}
	}
	F.submit_button.value = "linkagg";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function refresh()
{
	frames['clienttd'].location.href = goto_link("portst.asp");
	document.getElementById("clienttd").style.display="";
	
}
</script>
<body onload=init()>
<FORM autocomplete=off id="frm" name=frmlink method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=lag_0>
<input type=hidden name=lag_1>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(router.linkagg));</script></TR>
  <TR><TD colspan=2>
		<iframe frameborder=0 width=100% height=180px style="overflow:hidden;display:none" allowtransparency=true id=clienttd name=clienttd></iframe>
  </TD></TR>
  <TR><TD colspan=2>
		<script>
		var lag0_data = lag0.split(" ");
		var lag1_data = lag1.split(" ");
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"10,8,8,8,8",__T(router.linkaggtb),__T(router.linkagg)+","+spell_words(port_rule,"1")+","+spell_words(port_rule,"2")+","+spell_words(port_rule,"3")+","+spell_words(port_rule,"4"),"","","","link","2,2,2,2,2"); 
		var data = new Array();
		for(var j=0; j<2; j++)
		{
			var show = __T(mang.group0only);
			if ( j == 1 ) show = __T(mang.group1only);
			data[0] = new Array("tdlink_"+j,show,3);
			for(var i=0; i<4; i++)
			{
				var chkflg = "";
				if ( eval("lag"+j+"_data")[i] == 1 )  chkflg = "checked";
				data[1+i] = new Array("tdlp"+(1+i)+"_"+j,"<input type=checkbox name=chk_"+i+"_"+j+" id=chk_"+i+"_"+j+" "+chkflg+">",3);
			}
			//data[2] = new Array("tdlp2_"+j,"<input type=checkbox name=chk_1_"+j+" id=chk_1_"+j+">",3);
			//data[3] = new Array("tdlp3_"+j,"<input type=checkbox name=chk_2_"+j+" id=chk_2_"+j+">",3);
			//data[4] = new Array("tdlp4_"+j,"<input type=checkbox name=chk_3_"+j+" id=chk_3_"+j+">",3);
			data[5] = new Array("","&nbsp;");
			add_row(j,data,"","addlink",2);
		}	
		document.getElementById("tmsglink").style.display="none";
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
