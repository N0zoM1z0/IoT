<html>
<head>
<title>VPN Status</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var datalist = new Array();
//datalist[0] = new Array("192.168.88.66","willer","Tue Oct  6 23:06:34 2015");
<% dump_vpn_status(); %>

var ampm_name = new Array("AM","PM");
var ampm_val = new Array(__T(mang.am),__T(mang.pm));
var idx=0;
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<datalist.length; i++)
	{
		var tmp = new Array();
		tmp[0] = new Array("tdusername"+i, datalist[i][1]);
		tmp[1] = new Array("tdip"+i, datalist[i][0]);
		if ( flg_24 == 1 ) 
			tmp[2] = new Array("tddate"+i, datalist[i][2]);
		else{
			var tmpdata = str_replace("  ", " ",datalist[i][2]);
			var data = tmpdata.split(" ");
			var timedata = data[3].split(":");
			var newdata = data[0]+" "+data[1]+" "+data[2]+" "; 
			if ( parseInt(timedata[0],10) == 0 ) newdata += "12:"+timedata[1]+":"+timedata[2]+" "+__T(mang.am);
			else if ( parseInt(timedata[0],10) == 12 ) newdata += "12:"+timedata[1]+":"+timedata[2]+" "+__T(mang.pm);
			else if ( parseInt(timedata[0],10) > 12 ){
				newdata += ((parseInt(timedata[0],10)-12)<10?"0":"")+(parseInt(timedata[0],10)-12)+":"+timedata[1]+":"+timedata[2]+" "+__T(mang.pm);
			}else{
				newdata += (parseInt(timedata[0],10)<10?"0":"")+parseInt(timedata[0],10)+":"+timedata[1]+":"+timedata[2]+" "+__T(mang.am);
				
			}
			newdata += " "+data[4];
			tmp[2] = new Array("tddate"+i, newdata);
		}
		tmp[3]=new Array("","&nbsp;");
		add_row(idx,tmp,"","init",2);
		idx++;
		
	}
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=vpnst method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=vpn_del_id>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=del_type>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.vpnser));</script></TR>
  <TR><TD colspan=2>
		<script>
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,20,20",__T(vpn.serconnst),__T(share.username)+","+__T(router.ipaddr)+","+__T(vpn.conntime),"","","","","0,0,0");
		chg_layout();
		</script>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
