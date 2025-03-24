<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var back_bt = "true";
function to_back(F)
{
	parent.document.getElementById("newpage").value = "vpn_basic.asp";
	uiDoCancel(F);
}

</script>
<body>
<FORM autocomplete=off id="frm" name=frmvpnview method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">

<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.basicvpnsetup),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.bvpndfike),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.exmode));</script>
		<script>Capture(mang.main);</script>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.localwanid));</script>
		<script>Capture(vpn.localwanip);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remotewanid));</script>
		<script>Capture(vpn.remotewanip);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
		<script>Capture(mang.aes128);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authalg));</script>
		<script>Capture(mang.md5);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.authmethod));</script>
		<script>Capture(vpn.preskey);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.diffgroup));</script>
		<script>Capture(mang.group2);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.satime));</script>
		<script>Capture("8 "+__T(mang.hours));</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.bvpndfvpn),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
		<script>Capture(mang.aes128);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.integrityalg));</script>
		<script>Capture(mang.md5);</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.satime));</script>
		<script>Capture("1 "+__T(mang.hours));</script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.pfskeygroup),SPACE_DOWN,SPACE_DOWN);</script>
		<script>Capture(vpn.dhgroup2);</script>
                </TD></TR>
        </TABLE>
	<!-- BT start -->
	<TR>
		<TD colspan=2 id=BTTD class=BTTD>
		<script>
			if ( single_tb == "true" ) document.getElementById("BTTD").className = "";
			// Adject the content width for Firefox and IE.
			chg_layout();
			// RE-BUILD GUI object value for compare
			function before_leave()
			{
				if ( http_power == "r" || default_nv=="default_nv" ) 
				{
					alert_result_GUI(1);
					return;
				}
				parent.document.getElementById("GUI_FUN").value = 0;
				parent.document.getElementById("GUI_LOCK").value = 0; 
			        var F = document.forms[0];
				if ( CHK_VALUE_AUTO ) 
					change_nv= keep_val(F,skip_name);
				else
					change_nv = get_data(F);
				//alert("default_nv="+default_nv+"\nchange_nv="+change_nv);
				chk_change(default_nv,change_nv);
				if ( parent.document.getElementById("GUI_LOCK").value == 1 )
				{
        	        		if (typeof arguments[0] != "undefined" && arguments[0] == "cancel" ) 
						my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1,1)","alert_result_GUI(0)","","yesno");	
					else
						my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","","yesno");	
				}
				else
					alert_result_GUI(1);
			}

			function alert_result_GUI(val)
			{
			        var F = document.forms[0];
				var tmp="",tmp2="",tmpfile="";
	                        tmp = parent.frames['content_area'].location.href;
        	                tmp2 = tmp.substring(tmp.lastIndexOf("/")+1,tmp.length-tmp.lastIndexOf("/"));
                	        tmpfile = tmp2.substring(0,tmp2.indexOf(";"));
				alert_result(0);
				if ( val == 1 ) 
				{
        	        		if (typeof arguments[1] != "undefined" && arguments[1] == 1 ){
					        get_position(tmpfile,1);
						parent.document.getElementById("newpage").value = tmpfile;
						window.location.reload();
					}else{
						if ( change_cancel_bt == "true" && define_backname != "")  
						{
							var fname = parent.document.getElementById("newpage").value.split(".");
							F.submit_button.value = fname[0];
							F.backname.value = define_backname;
							F.change_action.value = "gozila_cgi";
							F.submit();
						}else{			
							//alert("3.newpage="+parent.document.getElementById("newpage").value);
					        	//get_position(parent.document.getElementById("newpage").value,1); - made IPv6 cannot expend.
			            			document.location.href = goto_link(parent.document.getElementById("newpage").value);
						}
					}
				}
				else{
					if ( define_backname!= "" ) 
						get_position(define_backname,1);
					else if ( parent.document.getElementById("newpage").value != "" ) 
					        get_position(parent.document.getElementById("newpage").value,1);
				}
			}
	
			//CANCEL BUTTON FUNCTION 
			function uiDoCancel(F){
					//before_leave();
					//Fixed bug-25952: Try to modify new VLAN100 and click the cancel button , DUT will
        	                        //show broken page.
                			if (typeof arguments[1] != "undefined" && arguments[1] == "back" )
						before_leave();
					else
						before_leave("cancel");
			}

			if ( back_bt == "true" ) 
				draw_object(O_GUI,BT,__T(share.back),"c4","BT","to_back(this.form)");

		if(("<% nvram_match("aging_time_true","1","1"); %>" == "1") && (get_url_filename(1) != 1))
		{
			//if("<% nvram_match("http_power","rw","1"); %>" == "1")
			if("<% nvram_match("http_power","rw","1"); %>" == "1")
				url = "default.asp";
			else
				url = "login.asp";
	
			top.location.href = url;
		}
	
		var wps_result = "<% nvram_get("wps_result"); %>";
		if ( wps_result == "3" || wps_result == "4" ) 
			get_position("Wireless_WPS.asp");
	
		// initial mode , edit and delete button is gray out
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
	
		function define_cancel(F)
		{
			if ( http_power == "r" || default_nv == "default_nv" )
        		        refresh_page();
			else	
				valid_before_leave(F);
		}	

		function valid_before_leave(F)
		{
			parent.document.getElementById("GUI_FUN").value = 0;
			parent.document.getElementById("GUI_LOCK").value = 0; 
			if ( CHK_VALUE_AUTO ) 
				change_nv= keep_val(F,skip_name);
			else
				change_nv = get_data(F);
			chk_change(default_nv,change_nv);
			if ( parent.document.getElementById("GUI_LOCK").value == 1 )
			{
				my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"refresh_page()","alert_result(0)","","yesno");	
			}else{
				refresh_page();
			}
		}

		</script>
		</TD>
	</TR>

	<!-- BT end -->
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
