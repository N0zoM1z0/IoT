<html>
<head>
<title>Getting Started</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function send_act(F)
{
	my_alert(O_GUI,WARNING,__T(share.info),__T(wwan.mobilemsg),"reset_alert_result(1)","reset_alert_result(0)","","yesno");	
}

function reset_alert_result(val) {
	F=document.frmmlst;
	alert_result(0);
	if ( val == 1) 
	{
		F.submit_button.value = "status_mobile";
		F.submit_type.value = "reset_cap";
		F.change_action.value = "gozila_cgi";
		F.submit();
	}
}

function init()
{
	var cardst = "<% get_cardinfo("model","Manufacturer"); %>";
	cardst = "1";
	if ( cardst == "" ) 
	{
	 	HIDDEN_PART("TR","info_start","info_start",0);
 		HIDDEN_PART("TR","data_start","data_end",1);
	}else{
	 	HIDDEN_PART("TR","info_start","info_start",1);
 		HIDDEN_PART("TR","data_start","data_end",0);
	}
	if ( http_power == "r" ) 
		choose_disable(document.getElementById("s1"));
	setTimeout('reload();', 30000); 
}

function reload()
{
	goto_page("status_mobile.asp");
}
var usb_st="<% get_cardinfo("status"); %>";
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmmlst method=<% get_http_method(); %> action=apply.cgi style=margin:0px>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wwan.mobilenet));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR id=info_start><script>draw_td(O_GUI,SUBTITLE_M,SPACE_DOWN,SPACE_DOWN);</script>
		<script>Capture(wwan.unabledetect);</script>
		</TD></TR>
		<TR id=data_start>
		<script>
			draw_td(O_GUI,SUBTITLE,__TC(wwan.conn));
		</script>
			<% get_cardinfo("status"); %>
		</TD></TR>
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__TC(wan.interipaddr));
			if( usb_st == "Connected")
				document.write("<% nvram_get("wwan_connect_ipaddr"); %>");
			else	
				Capture(wwan.notavailable);
		</script>
		</TD></TR>
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__TC(wan.mask));
			if( usb_st == "Connected")
				document.write("<% nvram_get("wwan_connect_netmask"); %>");
			else	
				Capture(wwan.notavailable);

		</script>
		</TD></TR>
		<TR><script>
			draw_td(O_GUI,SUBTITLE,__TC(wan.defgw));
			if( usb_st == "Connected")
				document.write("<% nvram_get("wwan_connect_gateway"); %>");
			else	
				Capture(wwan.notavailable);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.connuptime));
			if( usb_st == "Connected")
				document.write("<% get_cardinfo("uptime"); %>");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.currsession));
			if( usb_st == "Connected")
			{
				var RX=0,TX=0;
				<% get_3g_session_usage(); %>
				document.write(spell_words(session_3g_rule,RX,TX));
			}
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.capstatus));
			var rxtx=0, rx=0, tx=0;
			<% get_3g_statistic(); %>
			document.write(spell_words(usage_3g_rule,rxtx,rx,tx));
			draw_object(O_GUI,BT,__T(mang.clearbt),"s1","BT","send_act(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wwan.datacardst),"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.manufacturer));</script>
		<% get_cardinfo("model","Manufacturer"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.cardmodel));</script>
		<% get_cardinfo("model","CardModel"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.cardfw));</script>
		<% get_cardinfo("model","CardFirmware"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.simst));</script>
		<% get_cardinfo("model","SIMStatus"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.imsi));</script>
		<% get_cardinfo("model","IMSI"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.carrier));</script>
		<% get_cardinfo("model","Carrier"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.servicetype));</script>
		<% get_cardinfo("model","ServiceType"); %>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.signal));</script>
		<% get_cardinfo("model","SignalStrength"); %>
		</TD></TR>
		<TR id=data_end><script>draw_td(O_GUI,SUBTITLE,__TC(wwan.cardst),SPACE_DOWN,SPACE_DOWN);</script>
		<% get_cardinfo("status"); %>
		</TD></TR>
		<script>chg_layout();</script>
		</TABLE>
		</TR>
	</TABLE>
	</TABLE>
		
      </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
