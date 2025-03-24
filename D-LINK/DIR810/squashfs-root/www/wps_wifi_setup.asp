<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var from = getUrlEntry('from');
	
	var	param = {
		url: "get_set.ccp",
		arg: 'ccp_act=get&num_inst=1'+
				'&oid_1=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_1=11110'
	};	
	get_config_obj(param);
	
	var wps_enable = (config_val("wpsCfg_Enable_")? config_val("wpsCfg_Enable_"): "0");
	
	function onPageLoad(){
		//get_lang();
		//var wps_enable = "<% CmoGetCfg("wps_enable","none"); %>";
		if(wps_enable == "1"){
			get_by_id("wps_enable").style.display = "";
			get_by_id("wps_disable").style.display = "none";
		}else{
			get_by_id("wps_enable").style.display = "none";
			get_by_id("wps_disable").style.display = "";
		}
	}
	function send_request(){
		if(dev_info.login_info != "w"){
			window.location.href ="user_page.asp";
			return false;
		}else{
			if(!get_by_name("config_method_radio")[0].checked && !get_by_name("config_method_radio")[1].checked){
				alert("Please choose configuration mode!!");
			return false;
			}
			var path = get_checked_value(get_by_name("config_method_radio"));
			
			if(from == 'adv')
				path += "?from=adv";
				
			//window.location.href = get_checked_value(get_by_name("config_method_radio"));
			window.location.href = path;		
		}
	}
	
	function cancelOnClick()
	{
		if(from == 'adv')
			window.location.href = "adv_wps_setting.asp";
		else
			window.location.href = "wizard_wireless.asp";
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
	<tr>
		<td>
		<form id="form1" name="form1" method="post">
		<input type="hidden" name="reboot_type" value="none">
			<table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
				<tr>
				  <td bgcolor="#FFFFFF">
				  <div align="center">
					<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
					  <tr>
						<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
						<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
						<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
						<td>&nbsp;</td>
					  </tr>
					</table>
					<img src="wlan_masthead.gif" width="836" height="92" align="middle">
					  <br>
				  </div>
					<table width="650" border="0" align="center"><br>
						<tr>
						  <td>
						  <div id="wps_enable" class="box" style="display:none">

							<h2 align="left"><script>show_words(wps_KR35)</script></h2>
                      <p class="box_msg"><script>show_words(wps_KR37)</script></p>
                      <P> <b>
                        <script>show_words(KR50)</script>
                        </b>
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="do_wps.asp" checked >
                        <LABEL for=config_method_radio_auto><b> </b></LABEL>
                        <script>show_words(wps_KR51)</script>
							</P>
                      <P> <b>
                        <script>show_words(bwn_RM_2)</script>
                        </b>
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="wizard_add_wlan_device.asp">
                        <LABEL for=config_method_radio_2><b> </b></LABEL>
                        <script>show_words(wps_KR42)</script>
							</P>
					<p align="center">
                       <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                      <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onClick=window.location.href="wizard_wireless.asp">
                      <script>get_by_id("next_b").value = get_words('_next');</script>
					  <script>get_by_id("cancel_b").value = get_words('_cancel');</script>
							</p>
						  </div>
						  <p></p>
						  <div id="wps_disable" class="box" style="display:none">
							<h1 align="left"><script>show_words('LW13')</script></h1>
							<p>&nbsp;</p>
							<p><script>show_words('_wz_disWPS')</script></p>
							<p>&nbsp;</p>
							<p align="center">
								<input type="button" class="button_submit" name="btn_next" id="btn_next" value="" onClick="window.location.href='adv_wps_setting.asp'">
								<script>$("#btn_next").val(get_words('_yes'));</script>
								<input type="button" class="button_submit" name="btn_cancel" id="btn_cancel" value="" onClick="window.location.href='wizard_wireless.asp'">
								<script>$("#btn_cancel").val(get_words('_no'));</script>
							</p>
						  </div>
						  </td>
						</tr>

					</table></form>
				  </td>
				</tr>
				<tr>
				  <td bgcolor="#FFFFFF">
					  <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
						<tr>
						  <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
						  <td width="10">&nbsp;</td>
						  <td>&nbsp;</td>
						  <td>&nbsp;</td>
						</tr>
					  </table>
				  </td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
</html>
