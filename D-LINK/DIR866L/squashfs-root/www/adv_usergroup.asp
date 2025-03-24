<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 25;
	var gflag=0;
	var DataArray = new Array();
	var Group_ary1 = new Array();
	var Group_ary2 = new Array();
	var Group_ary3 = new Array();
	var Group_ary4 = new Array();
	var Group_ary5 = new Array();
	var Group_ary6 = new Array();	
  	var Group_ary7 = new Array();
	var Group_ary8 = new Array();
	function set_status(){
		if(get_by_name("enable_wpa_ent")[0].checked == true){
			get_by_name("radio_RADIUS")[0].disabled = true;
			get_by_name("radio_RADIUS")[1].disabled = true;
			get_by_id("primary_radius_ip").disabled = true;
			get_by_id("primary_radius_port").disabled = true;
			get_by_id("primary_radius_secret").disabled = true;
			get_by_id("backup_radius_ip").disabled = true;
			get_by_id("backup_radius_port").disabled = true;
			get_by_id("backup_radius_secret").disabled = true;
			get_by_name("enable_wpa_ent")[0].value = 1;
		}else{
			get_by_name("radio_RADIUS")[0].disabled = false;
			get_by_name("radio_RADIUS")[1].disabled = false;
			get_by_id("primary_radius_ip").disabled = false;
			get_by_id("primary_radius_port").disabled = false;
			get_by_id("primary_radius_secret").disabled = false;
			get_by_id("backup_radius_ip").disabled = false;
			get_by_id("backup_radius_port").disabled = false;
			get_by_id("backup_radius_secret").disabled = false;
			get_by_name("enable_wpa_ent")[0].value = 0;
		}
	}

	function change_server(){
		display();
		var selected = get_by_id("ext_server_mode").value;
		if (selected == "1"){
			get_by_id("moreinfo1").innerHTML=adv_ug_example1;
			get_by_id("moreinfo2").innerHTML=adv_ug_example1_info;
		}else if(selected == "2"){
			get_by_id("moreinfo1").innerHTML=adv_ug_example2;
			get_by_id("moreinfo2").innerHTML=adv_ug_example2_info;
		}
	}

	function set_radius(){
		var radius0 = get_by_id("radius0").value;
		var radius1 = get_by_id("radius1").value;
		if (radius0 != ""){
			var radius = radius0.split(",");
			get_by_id("primary_radius_ip").value = radius[0];
			get_by_id("primary_radius_port").value = radius[1];
			get_by_id("primary_radius_secret").value = radius[2];
		}
		if (radius1 != ""){
			var radius = radius1.split(",");
			get_by_id("backup_radius_ip").value = radius[0];
			get_by_id("backup_radius_port").value = radius[1];
			get_by_id("backup_radius_secret").value = radius[2];
		}
	}
	function _other_ser(){
		var server_mode = get_by_id("ext_server_mode").selectedIndex;
		if(server_mode == 1){
			var ldap = get_by_id("ldap").value;
			if(ldap != ""){
				var ldap_s = ldap.split(";");
				get_by_id("oip").value = ldap_s[0];
				get_by_id("oport").value = ldap_s[1];
				get_by_id("com_name_info").value = ldap_s[2];
				get_by_id("dist_name_info").value = ldap_s[3];
			}else{
				get_by_id("oip").value = "";
				get_by_id("oport").value = "";
				get_by_id("com_name_info").value = "";
				get_by_id("dist_name_info").value = "";
			}
		}else{
			var ad = get_by_id("ad").value;
			if(ad != ""){
				var ad_s = ad.split(";");
				get_by_id("oip").value = ad_s[0];
				get_by_id("oport").value = ad_s[1];
				get_by_id("com_name_info").value = ad_s[2];
				get_by_id("dist_name_info").value = ad_s[3];
			}else{
				get_by_id("oip").value = "";
				get_by_id("oport").value = "";
				get_by_id("com_name_info").value = "";
				get_by_id("dist_name_info").value = "";
			}
		}
	}
	function display(){
		get_by_id("group_data").style.display = "none";
		get_by_id("en_radius").style.display = "none";
		get_by_id("radius_0").style.display = "none";
		get_by_id("radius0_info").style.display = "none";
		get_by_id("radius_1").style.display = "none";
		get_by_id("radius1_info").style.display = "none";
		get_by_id("other_ser").style.display = "none";

		var server_mode = get_by_id("ext_server_mode").selectedIndex;
		if(server_mode == 0) {
			get_by_id("en_radius").style.display="";
			get_by_id("radius_0").style.display = "";
			get_by_id("radius0_info").style.display = "";
			get_by_id("radius_1").style.display = "";
			get_by_id("radius1_info").style.display = "";
			set_radius();
			if(get_by_name("enable_wpa_ent")[0].value == 1){
				get_by_name("enable_wpa_ent")[0].checked = true;	
			}else{
				get_by_name("enable_wpa_ent")[0].checked = false;
			}
		}else{
			get_by_id("other_ser").style.display = "";
			_other_ser();
		}
		set_status();
	}

	function onPageLoad(){
		change_server();
		set_form_default_values("form1");
	}

	function set_group(obj){
		var temp_group1 = (get_by_id("auth_group1").value).split("/");
		var temp_group2 = (get_by_id("auth_group2").value).split("/");
		var temp_group3 = (get_by_id("auth_group3").value).split("/");
		var temp_group4 = (get_by_id("auth_group4").value).split("/");
		var temp_group5 = (get_by_id("auth_group5").value).split("/");
		var temp_group6 = (get_by_id("auth_group6").value).split("/");
		var temp_group7 = (get_by_id("auth_group7").value).split("/");
		var temp_group8 = (get_by_id("auth_group8").value).split("/");
	
		for(var i = 0; i < 8; i++){
			var ooption = document.createElement("option");
			var t = new Array(temp_group1[0], temp_group2[0], temp_group3[0], temp_group4[0], temp_group5[0], temp_group6[0], temp_group7[0], temp_group8[0]);
			var v = new Array("1", "2", "3", "4", "5", "6", "7", "8");			
			obj.options[i] = null;
			ooption.text = t[i];
			ooption.value = v[i];				
			obj.options[i] = ooption;	
		}
	}
	
	function Clear_list(){
		for (var k = 1; k <= rule_max_num; k++){
			get_by_id("auth_user" + k).value = "";
			get_by_id("passwd" + k).value = "";
			//get_by_id("chk_passwd" + k).value = "";
		}
	}
		
	function group_edit(){
		gflag = 1;
		var i;
		var index = get_by_id("auth_group").value;
		if (get_by_id("auth_group").selectedIndex == "-1"){
			alert(adv_ug_select_msg);
			return false;
		}
		
       	get_by_id("group_set").style.display = "none";
       	get_by_id("group_data").style.display = "";
		
		Clear_list();
		
		var temp_group = (get_by_id("auth_group" + index).value).split("/");
		get_by_id("auth_type").value = temp_group[0];
		if (temp_group[0] != ""){
			for (j = 1; j < temp_group.length; j++){
				temp_user = temp_group[j].split(",");
				if (temp_user[0] != ""){
					get_by_id("auth_user" + j).value = temp_user[0];
					get_by_id("passwd" + j).value = temp_user[1];
				}
			}
		}			
	}

	function check_username(idx){
		for (var i = 1; i <= rule_max_num; i++){
			if (get_by_id("auth_user" + idx).value != ""){
				if (i != idx && (get_by_id("auth_user" + idx).value == get_by_id("auth_user" + i).value)){
					alert(get_by_id("auth_user" + idx).value + adv_ug_checkusername);
				}
			}
		}
	}
		
	function check_usr_data(){
		for (var i = 1; i <= rule_max_num; i++){
			for (var j = i+1; j <= rule_max_num; j++){
				if (get_by_id("auth_user" + i).value != ""){
					if(check_legal_name(get_by_id("auth_user" + i).value)){
						alert(adv_ug_uname + i + vpn_ipsec_character_issue);
						return false
					}
					if(check_legal_name(get_by_id("passwd" + i).value)){
						alert(adv_ug_pwd + i + vpn_ipsec_character_issue);
						return false
					}
					if (i != j && (get_by_id("auth_user" + i).value == get_by_id("auth_user" + j).value)){
						alert(get_by_id("auth_user" + i).value + adv_ug_checkusername);
						return false;
					}
				}
			}
		}
		return true;
	}
	
	function set_up_extser()
	{
		var ser_mode = get_by_id("ext_server_mode").selectedIndex;
		if(ser_mode == 0){
			set_status();
			
			get_by_id("radius0").value = get_by_id("primary_radius_ip").value + "," +get_by_id("primary_radius_port").value + "," + get_by_id("primary_radius_secret").value;
			get_by_id("radius1").value = get_by_id("backup_radius_ip").value + "," +get_by_id("backup_radius_port").value + "," + get_by_id("backup_radius_secret").value;
		}else if(ser_mode == 1){
			get_by_id("ldap").value = get_by_id("oip").value+";"+get_by_id("oport").value+";"+get_by_id("com_name_info").value+";"+get_by_id("dist_name_info").value;
		}else if(ser_mode == 2){
			get_by_id("ad").value = get_by_id("oip").value+";"+get_by_id("oport").value+";"+get_by_id("com_name_info").value+";"+get_by_id("dist_name_info").value;
		}
	}

	function set_usergroup(){
		var flag=0;
		var is_empty = true;
		var passwd, user_list = "";
		var idx = get_by_id("auth_group").value;
		for (var i = 1; i <= rule_max_num; i++) {
			var check_name = get_by_id("auth_user" + i).value;
			if ( check_name != "" ){ 

				if (Find_word(check_name,'"') || Find_word(check_name,"/")) {
                                	alert(_username + " " + i + " " + illegal_characters + " " + check_name);
					flag=1;
	                                //return false;
			
				} else if ( get_by_id("passwd" + i).value == "") {
				alert(adv_ug_checkug_msg1+ check_name + adv_ug_checkug_msg2);
				flag=1;
			}
			}
                                
		}

		for (var i = 1; i < 9; i++){
			var temp_group = (get_by_id("auth_group" + i).value).split("/");
			if (((i != idx) && (get_by_id("auth_type").value == temp_group[0])) || (get_by_id("auth_type").value == "")){
				alert(TEXT034);
				flag=1;
			}
		}
		if(check_legal_name(get_by_id("auth_type").value)){
			alert(adv_ug_legalug_msg);
			flag=1;
			//return false;
		}
		
		user_list = get_by_id("auth_type").value + "/"
		for (var i = 1; i <= rule_max_num; i++) {
			var auth_user = get_by_id("auth_user" + i).value;
	
			if (auth_user != ""){
				if(!check_usr_data()){
					flag=1;
					//return false;
				}
				passswd = get_by_id("passwd" + i).value;
				user_list += auth_user + "," + passswd + "/";
				is_empty = false;
			}
		}
		if(is_empty){
			var group_used = new Array(<!--# exec cgi /bin/group_inused -->);
			if(group_used[idx - 1] != ""){
				alert(adv_ug_beused_msg);
				flag=1;
				//return false;
			}
		}
		get_by_id("auth_group" + idx).value = user_list;
		return flag;
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(LS3)) {
			return false;
		}
		set_up_extser();
		if(gflag == 1){
			var xflag = set_usergroup();
			if(xflag == 1){
				submit_button_flag = 1;
			}
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
</script>

</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	 <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
                <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
                <td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
                <tr>
                        <td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
                </tr>
        </table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
                <tr id="topnav_container">
                        <td><img src="/short_modnum.gif" width="125" height="25"></td>
			<script>show_top("adv");</script>
                </tr>
        </table>
	 <table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
                <tr>
                        <td id="sidenav_container" valign="top" width="125" align="right">
                                <table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 12);</script>
                          </UL>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" name="action" id="action" value="user_group_edit">
<input type="hidden" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" name="html_response_return_page" value="adv_usergroup.asp">
<input type="hidden" id="auth_group1" name="auth_group1" value="<!--# echo auth_group1 -->">
<input type="hidden" id="auth_group2" name="auth_group2" value="<!--# echo auth_group2 -->">
<input type="hidden" id="auth_group3" name="auth_group3" value="<!--# echo auth_group3 -->">
<input type="hidden" id="auth_group4" name="auth_group4" value="<!--# echo auth_group4 -->">
<input type="hidden" id="auth_group5" name="auth_group5" value="<!--# echo auth_group5 -->">
<input type="hidden" id="auth_group6" name="auth_group6" value="<!--# echo auth_group6 -->">
<input type="hidden" id="auth_group7" name="auth_group7" value="<!--# echo auth_group7 -->">
<input type="hidden" id="auth_group8" name="auth_group8" value="<!--# echo auth_group8 -->">
<input type="hidden" id="radius0" name="radius0" value="<!--# echo radius0 -->">
<input type="hidden" id="radius1" name="radius1" value="<!--# echo radius1 -->">
<input type="hidden" id="ldap" name="ldap" value="<!--# echo ldap -->">
<input type="hidden" id="ad" name="ad" value="<!--# echo ad -->">

	<td valign="top" id="maincontent_container">
		   <div id="maincontent">
				    <div id="box_header"> 
						<h1><script>show_words(adv_ug);</script> : </h1>
				        <script>show_words(adv_ug_info);</script>
				        <br><br>
                        <input type="submit" name="button" id="button" class=button_submit value="" onClick="return send_request();">
                        <input type="button" name="button2" id="button2" class=button_submit value="" onClick="window.location.href='adv_usergroup.asp'">
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
	                </div>
			<div class="box"> 
			<h2><script>show_words(adv_ug_local);</script> : </h2>
                            <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
				<tr id="group_set">
				<td colspan="3" align="top"><script>show_words(adv_ug_local_db);</script> : </td><td align="left">
				<select id="auth_group" name="auth_group" size=8>
					<script>
						set_group(get_by_id("auth_group"));
					</script>
					<input type="button" id="add" name="add" value="EDIT" onClick="group_edit();">
					<script>get_by_id("add").value = _edit;</script>
				</td>
				</tr>
			    </table>
                            <table id="group_data" borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
				<tr>
					<td colspan="3"><script>show_words(adv_ug_gname);</script> :
					<input type="text" id="auth_type" name="auth_type" maxlength="32"> 
					</td>
				</tr>
				<tr>
					<td colspan="3"> 
					<input type="button"  id="clear" value="Clear the list below..." onClick="Clear_list();">
					<script>get_by_id("clear").value = awf_clearlist;</script>
					</td>
				</tr>
				<tr>
					<td width="4%">&nbsp;</td>
					<td width="48%"><script>show_words(_username);</script></td>
					<td width="48%"><script>show_words(_password);</script></td>
				</tr>
					<script>
					for(var i = 1; i <= rule_max_num; i++){
						document.write("<tr>");
						document.write("<td>" + i + ".</td>");
						document.write("<td>");
						document.write("<input type=text id=auth_user" + i + " name=auth_user" + i + " maxlength=32 onChange='check_username(" + i + ")'>");
						document.write("</td>");
						document.write("<td>");
						document.write("<input type=text id=passwd" + i + " name=passwd" + i + " maxlength=32>");
						document.write("</td>");
						document.write("</tr>");
					}
					</script>
				  </table>
			</div>
			<div class=box style="display:none">
				<h2>External User Setting : </h2>
				<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525>
				<tr rows=8><td align=right>External Server : </td>
				  <td><select id="ext_server_mode" name="ext_server_mode" onChange="change_server()">
				<option value=0 <!--# match ext_server_mode 0 selected -->>RADIUS Server</option>
				<option value=1 <!--# match ext_server_mode 1 selected -->>LDAP Server</option>
				<option value=2 <!--# match ext_server_mode 2 selected -->>Active Directory Server</option>
					</select>
				  </td>
				  <td>&nbsp;</td>
				</tr>
				<tr id=en_radius>
				<td>&nbsp;</td>
				<td><input type="checkbox" id="enable_wpa_ent" name="enable_wpa_ent" onClick="set_status()" value="<!--# echo enable_wpa_ent -->" >
				Use RADIUS settings from <U><font color=blue><a href="wireless.asp">WPA-Enterprise</a></font></U> EAP settings.
				</td>
				<td>&nbsp;</td>
				</tr>
				<tr id=radius_0>
				  <td>&nbsp;</td>
				  <td><input type="radio" id=radio_RADIUS name=radio_RADIUS value="0" <!--# match radio_RADIUS 0 checked -->>Primary RADIUS Server</td>
				  <td>&nbsp;</td>
				</tr>
				<tr id=radius0_info>
				<td>&nbsp;</td>
				<td>
				  <table borderColor=#ffffff cellSpacing=1 cellPadding=2>
																      <tr><td>&nbsp;</td>
				   <td>&nbsp;&nbsp;&nbsp;IP Address&nbsp;&nbsp;<input type="text" id="primary_radius_ip" name="primary_radius_ip"></td>
				  </tr>
				  <tr><td>&nbsp;</td>
				   <td>&nbsp;&nbsp;&nbsp;Port Number&nbsp;&nbsp;<input type="text" id="primary_radius_port" name="primary_radius_port" value="1812" ></td>
				  </tr>
				  <tr><td>&nbsp;</td>
				   <td>&nbsp;&nbsp;&nbsp;Shared Secret&nbsp;&nbsp;<input type="text" id="primary_radius_secret" name="primary_radius_secret"></td>
				</table></td>
				<td>&nbsp;</td>
				</tr>
				<tr id=radius_1>
				<td>&nbsp;</td>
				<td><input type="radio" id=radio_RADIUS name=radio_RADIUS value=1 <!--# match radio_RADIUS 1 checked -->>Backup RADIUS Server</td>
				<td>&nbsp;</td>
				</tr>
				<tr id=radius1_info><td>&nbsp;</td>
				<td>
				<table borderColor=#ffffff cellSpacing=1 cellPadding=2>
				<tr>
				<td>&nbsp;</td>
				<td>&nbsp;&nbsp;&nbsp;IP Address&nbsp;&nbsp;<input type="text" id="backup_radius_ip" name="backup_radius_ip"></td>
				</tr>
				<tr><td>&nbsp;</td>
				<td>&nbsp;&nbsp;&nbsp;Port Number&nbsp;&nbsp;<input type="text" id="backup_radius_port" name="backup_radius_port" value="1812"></td>
				</tr>
				<tr><td>&nbsp;</td>
				<td>&nbsp;&nbsp;&nbsp;Shared Secret&nbsp;&nbsp;<input type="text" id="backup_radius_secret" name="backup_radius_secret"></td>
				</tr>
				</table></td><td>&nbsp;</td>
				</tr>
				<tr id="other_ser">
				  <td>&nbsp;</td>
				  <td>
				    <table>
				      <tr>
					<td>&nbsp;</td>
					<td align=left>IP Address &nbsp;<input type=text id=oip name=oip></td>
				      </tr>
				      <tr>
					<td>&nbsp;</td>
					<td>Port Number &nbsp;<input type="text" id=oport name=oport></td>
				      </tr>
				      <tr>
					<td>&nbsp;</td>
					<td>Common Name Identifer&nbsp;<input type="text" name="com_name_info" id="com_name_info"><span id="moreinfo1"></span></td>
				     </tr>
				     <tr>
				       <td>&nbsp;</td>
				       <td>Distinguished Name&nbsp;<input type="text" name="dist_name_info" id="dist_name_info"><span id="moreinfo2"></span></td>
				    </tr>
				    </table>
				  </td>
				  <td>&nbsp;</td>
				</tr>
			</table>
			</div>
			</div>
			</td>
			</form>
			 <td valign="top" width="150" id="sidehelp_container" align="left">
			<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
			      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
			  <tbody>
			    <tr>
			       <td id=help_text><strong><script>show_words(_hints);</script>..</strong><br>
				<p class="style1"><script>show_words(adv_ug_help);</script></p>
			      </td>
			    </tr>
			  </tbody>
                          </table></td>
			</tr>
        </table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
                <tr>
                        <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
                        <td width="10">&nbsp;</td><td>&nbsp;</td>
                </tr>
        </table>
	<br>
	<div id="copyright"><script>show_words(_copyright);</script></div>
	<br>
</body>
</html>
