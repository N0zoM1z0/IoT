<html>
    <head>
	<title>Site Survey</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="/css_router.css">
    <script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
    <script language="JavaScript" src="public.js"></script>
    <script language="JavaScript">
    function ClickMenu(MacString,sIndex)
	{
		var ApModwList = new Array("bridge","mbridge","sta");
		var Wls_mode = parent.document.getElementById("Wls_mode");
		var RootApMacAddr = null;
		var RootSsid = null;
		var RootChannel = null;
		var SSIDString = document.getElementById("tSSID"+sIndex).title;
		var ChannelString = document.getElementById("tChannel"+sIndex).title;
		var wds_mac = new Array();

		if((Wls_mode.options[Wls_mode.selectedIndex].value != ApModwList[1])) 
		{
			RootSsid = parent.document.getElementById("show_ssid");
			RootChannel = parent.document.getElementById("wlan0_channel");

			if(RootSsid != null)
			{
				RootSsid.value = SSIDString;
			}

			if(RootChannel != null)
			{
				RootChannel.value = ChannelString;
			}
		}
		else if((Wls_mode.options[Wls_mode.selectedIndex].value == ApModwList[1]))
		{			
			for(var i=0; i<8; i++)
				wds_mac[i] = parent.document.getElementById("wds_mac"+(i+1));

			for(var i=0; i<8; i++)
			{
				if(wds_mac[i].value == MacString)
				{
					alert(si_msg_1);
					wds_mac[i].select();
					break;
				}

				if(wds_mac[i] != null && wds_mac[i].value == "")
				{
					wds_mac[i].value = MacString;
					break;
				}

				if(wds_mac[i] != null && i == 7)
				{
					alert(si_msg_2);
					break;
				}
			}
		}

	}

function remove_mac_token(MacString)
{
	var temp = MacString.split(":");
	return temp[0]+temp[1]+temp[2]+temp[3]+temp[4]+temp[5];
}

function apply_site(){
  var site = document.getElementsByName("site");
  var table1 = document.getElementById("siteTable");
	var row_data;
	var index = 0;
	for (index = 0; index < site.length; index++){
		if (site[index].checked){
			row_data = table1.rows[index+1];
		}
 
 	}
  if (row_data != undefined){
    window.opener.document.getElementById("wlan0_ssid").value = get_row_data(row_data,0);
	var show_wep =window.opener.document.getElementById("show_wep");
	var show_wpa =window.opener.document.getElementById("show_wpa");
	var wpa =window.opener.document.getElementById("wpa");
	var wpa2 =window.opener.document.getElementById("wpa2");
	var authType = window.opener.document.getElementById("authType");
	var show_wpa_psk  = window.opener.document.getElementById("show_wpa_psk");
	var encrypt_w = get_row_data(row_data,4);
	
	if (encrypt_w =="NO") {
		authType.selectedIndex =0;
		show_wep.style.display = "none";
		show_wpa.style.display = "none";
		wpa.style.display = "none";
		wpa2.style.display = "none";
		show_wpa_psk.style.display = "none";
	}else if (encrypt_w =="WEP") {
		authType.selectedIndex =1;
		show_wep.style.display = "";
		show_wpa.style.display = "none";
		wpa.style.display = "none";
		wpa2.style.display = "none";
		show_wpa_psk.style.display = "none";
	}else if (encrypt_w =="WPA-PSK"){
		authType.selectedIndex =2;	
		show_wpa.style.display = "";
		wpa.style.display = "";
		show_wpa_psk.style.display = "";
		wpa2.style.display = "none";
		show_wep.style.display = "none";
	}else{
		authType.selectedIndex =3;
		show_wpa.style.display = "";
		wpa2.style.display = "";
		show_wpa_psk.style.display = "";
		wpa.style.display = "none";
		show_wep.style.display = "none";
	}

	var  c_type =window.opener.document.getElementById("c_type");
	var cipher_w = get_row_data(row_data,5);
	if (cipher_w =="TIKP")
	c_type.selectedIndex =0;
 if (cipher_w =="AES")
	c_type.selectedIndex =1;		
 if (cipher_w =="AUTO")
	c_type.selectedIndex =2;
	//else
	//c_type=2;	
	//authType.selectedUndex =
 	//window.opener.document.getElementById("wds_remote_mac").value = remove_mac_token(get_row_data(row_data,1));  
  } 
	if (get_by_id("index").value == ""){
	  alert(si_msg_3);
	  return;
	}
	window.close();
}
	
function select_site(which_row){
	get_by_id("index").value = which_row;
	//change_color("siteTable", which_row+1);
}
		</script>
    </head>
    <body bgcolor="#757575" topmargin="1" leftmargin="0" rightmargin="0">

<form id="form1" name="form1" method="post" action="sitesurvey.cgi">
				<table width=838 height="100" border=0 align=center cellpadding=0 cellspacing=0>
				<tr>
				<td bgcolor="#FFFFFF"><table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
				  <tr>
					<td width="100%"><script>show_words(TA2);</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
					<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
				  </tr>
				</table>
				  <div align="center"><img src="/wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
				</tr>
							  <tr> 
								<td height="10" bgcolor="#CCCCCC" align="center">
						<input type="hidden" id="index" name="index" value="">
						<input type="hidden" name="html_response_page" value="sitesurvey.asp">
						<input type="hidden" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
						<input type="hidden" name="scan_list_table" id="scan_list_table" value="<!--# echo wireless_ap_scan_list -->">
						<input type="hidden" name="asp_temp_36"  id="asp_temp_36" value="<!--# echo asp_temp_36","ascii -->">
							      <table id="siteTable" width="700">
								  <tr bgcolor="#b7dcfb">
	  						   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(help699);</script></font></td>
	   						   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(_bss);</script></font></td>
						   	   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(_channel);</script></font></td>
							   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(_security);</script></font></td>
							   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(_encrypt);</script></font></td>
							   <td align="center"><font face=Arial size="2" color="#333333"><script>show_words(_cipher);</script></font></td>
							   <td align="center"><font face=Arial size="2" color="#333333">&nbsp;</font></td>
										</b>
											<script>
											var temp_scan_list = get_by_id("scan_list_table").value.split(",");
											var wlan_mode = "<!--# echo wlan0_radio_mode -->";
											for(var tsl_i=0 ; tsl_i < temp_scan_list.length ; tsl_i++)
											{ 
											var temp_entry = temp_scan_list[tsl_i].split("/");
											if(temp_entry.length > 1)
											{
											/* ignore station with error channel in 24G */
											if(wlan_mode == 0 && temp_entry[2] > 13){
											 continue;
											/* ignore station with error channel in 5G */  
											}else if(wlan_mode == 1 && (temp_entry[2] > 165 || temp_entry[2] < 36)){
											   continue;
											 }  
											
											var tans_lt = ReplaceAll(hex_to_a(temp_entry[1]),'<','&lt;');
											var tans_gt  = ReplaceAll(tans_lt,'>','&gt;');
											var tans_sp  = ReplaceAll(tans_gt,' ','&nbsp;');
											if(temp_entry[3]=="on")
											 temp_entry[3]="Yes"
											else if(temp_entry[3]=="off")
											 temp_entry[3]="No"		 	
											document.write("<tr align=left bgcolor=\"#C0C0C0\"><td>"+tans_sp+"</td>");
											document.write("<td align=left bgcolor=\"#C0C0C0\">"+temp_entry[0]+"</td>");
											document.write("<td align=center bgcolor=\"#C0C0C0\">"+temp_entry[2]+"</td>");
											document.write("<td align=center bgcolor=\"#C0C0C0\">"+temp_entry[3]+"</td>");
											document.write("<td align=center bgcolor=\"#C0C0C0\">"+temp_entry[4]+"</td>");
											document.write("<td align=center bgcolor=\"#C0C0C0\">"+temp_entry[5]+"</td>");
											document.write("<td align=center bgcolor=\"#C0C0C0\"><input type=radio id=site name=site onClick=select_site("+i+");></td></tr>");
											
											}
											}
											</script>
								   </table>
								</td>
							   </tr>
							   
							<tr> 
								<td bgcolor="#CCCCCC" height="10" align="center">
									 <input name="Apply" type="button" class="ButtonSmall" onClick="apply_site()" value="Connect">
									 <input name="button" type="button" class="ButtonSmall" onClick="window.close()" value="Exit">
								</td>
							</tr>
				<tr>
				<td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
				  <tr>
					<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
					<td width="10">&nbsp;</td>
					<td>&nbsp;</td>
				<td>&nbsp;</td>
				  </tr>
				</table></td>
				</tr>
					</table><br>
				<div align="center"><script>show_words(_copyright);</script></div>
 </form>
    </body>
</html>
