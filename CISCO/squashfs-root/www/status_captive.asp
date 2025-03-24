<html>
<head>
<title>VPN Status</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var td_id=new Array("td_name","td_ssid","td_ip","td_mac","td_ver","td_time","td_bt");
var ver_name = new Array(__T(wl.guest),__T(vpn.local));
var guestlist = new Array();
<% guest_info("all"); %>

var idx=0;
var stflg="init";

function init(){
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<guestlist.length; i++)
	{
		var dt = guestlist[i][5].split(":");
		var tmp = new Array();
		tmp[0]=new Array(td_id[0]+idx,guestlist[i][0],0);
		tmp[1]=new Array(td_id[1]+idx,guestlist[i][1],0);

		tmp[2]=new Array(td_id[2]+idx,guestlist[i][2],0);
		tmp[3]=new Array(td_id[3]+idx,guestlist[i][3],0);
		tmp[4]=new Array(td_id[4]+idx,ver_name[guestlist[i][4]],3);
//		tmp[5]=new Array(td_id[5]+idx,spell_words(datetime2_rule,dt[0],dt[1],dt[2],dt[3],dt[4],dt[5]),0);
		tmp[5]=new Array(td_id[5]+idx,guestlist[i][5],0);
		tmp[6]=new Array(td_id[6]+idx,draw_object(O_VAR,BT,__T(share.disconnect),"d"+idx,"BT","disable_rule("+idx+")"));	
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	setTimeout('show_leasetime()', 1000); //Every Minutes
		
}

function disable_rule(index)
{
	var F = document.gnetst;
	F.cip.value = guestlist[index][2];
	F.cmac.value = guestlist[index][3];
	F.submit_button.value = "status_captive.asp";
	F.submit();
	
}

function show_leasetime()
{
	var flg=0;
	for(var i=0; i<guestlist.length; i++)
	{
		if ( guestlist[i][5] == "0" ) 
		{
			document.getElementById("td_time"+i).innerHTML = __T(logemail.authnone); 
			continue;
		}
		if ( document.getElementById("td_time"+i).innerHTML == "00:00:00" ) continue;
		var time = document.getElementById("td_time"+i).innerHTML;
		var tmptime = time.split(":"); 
		var tmphr, tmpmin, tmpsec, tmpmin2;
		var mintime = (parseInt(tmptime[0],10)*3600+parseInt(tmptime[1],10)*60+parseInt(tmptime[2],10))-1;
		//alert("time=["+time+"], mintime=["+mintime+"]");
		time = parseInt(parseInt(mintime,10)/3600,10);
		if ( time < 10 ) tmphr = "0"+time;
		else tmphr = time;
		tmpmin2 = parseInt(parseInt(mintime,10)%3600,10);
		time = parseInt(tmpmin2/60,10);
		if ( time < 10 ) tmpmin = "0"+time;
		else tmpmin = time;
		time = parseInt(tmpmin2%60,10);
		if ( time < 10 ) tmpsec = "0"+time;
		else tmpsec = time;
		document.getElementById("td_time"+i).innerHTML = tmphr+":"+tmpmin+":"+tmpsec;
		if ( mintime > 0 ) 
			flg = 1;
		/*
		else
		{
			//show_alert(__T(msg.sessiontimeout),"timeout");
			//document.getElementById("g1").className = "BT_DISABLE";
			//document.getElementById("g1").disabled = true;
	
		}*/
	}
	if ( flg == 1 )  
		setTimeout('show_leasetime()', 1000); //Every Minutes
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=gnetst method=<% get_http_method(); %> action=guest_logout.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=vpn_del_id>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=del_type>
<input type=hidden name=cip>
<input type=hidden name=cmac>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.captivest));</script></TR>
  <TR><TD colspan=2>
		<script>
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"20,15,15,15,10,10",__T(wl.captiveuserst),__T(mang.username)+","+__T(wl.ssid)+","+__T(router.ipaddr)+","+__T(share.macaddr)+","+__T(wl.verif)+","+__T(wl.timeleft),"","","","","0,0,0,0,2,0");
		chg_layout();
		</script>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
