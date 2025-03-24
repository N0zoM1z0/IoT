<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css_router.css" />
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 5;
	var DataArray = new Array();
	var name_list = new Array();
	
	function Data(name, state, issuer, subject, expire, onList) 
	{
		this.Name = name;
		this.State = state;
		this.Issuer = issuer;
		this.Subject = subject;
		this.Expire = expire;
		this.OnList = onList;
	}

	function change_multicolor(table_num, row)
	{
		for (var i = 0; i < 3; i++){
			var obj = get_by_id("table" + i);
			for (var j = 1; j < obj.rows.length; j++){
				if (table_num == i && row == j){
					obj.rows[j].style.backgroundColor = "#FFFF00";
				}else{
					obj.rows[j].style.backgroundColor = "#FFFFFF";
				}
			}
		}
	}

	function set_certificate()
	{
	//CA,CA_ROOT;Issuer$ C=TW, ST=Taiwan, L=Taipei, O=CAMEO, OU=BU1, CN=Software4, E=peter_pan@cameo.com.tw;Subject$ C=TW, ST=Taiwan, L=Taipei, O=CAMEO, OU=BU1, CN=Software4, E=peter_pan@cameo.com.tw;Validity$Mar 05 04:21:04 2017-Mar 05 04:21:04 2017
		for (var i = 1; i <= rule_max_num; i++){
			var temp_certifi = (get_by_id("x509_" + i).value).split(";");
			if (temp_certifi != ""){
				var temp_certifi_data = temp_certifi[0].split(",");
				var temp_issuer = temp_certifi[1].split("$");
				var temp_subject = temp_certifi[2].split("$");
				var temp_expire = temp_certifi[3].split("$");
				if (temp_certifi.length > 1){
					DataArray[i] = new Data(temp_certifi_data[0], temp_certifi_data[1], temp_issuer[1], temp_subject[1], temp_expire[1], i);
				}
				name_list[i] = temp_certifi_data[0];
			}else{
				DataArray[i] = new Data("", "", "", "", "", i);
			}
		}
		get_by_id("x509_max").value = DataArray.length;
	}

	function edit_row(index, point, st)
	{
		get_by_id("certifi").selectedIndex = st;
		get_by_id("certifi").disabled = true;
		get_by_id("certi_name").value = DataArray[index].Name;
    		get_by_id("certi_name1").value = DataArray[index].Name;
		
		get_by_id("ca_name").style.display = "none";
		get_by_id("priv_part").style.display = "none";
		get_by_id("pub_part").style.display = "none";
		get_by_id("remote_part").style.display = "none";
		get_by_id("ca_part").style.display = "none";
		get_by_id("pki_pub_file").disabled = true;
		get_by_id("pki_priv_file").disabled = true;
		get_by_id("cert_file").disabled = true;
		get_by_id("ca_file").disabled = true;
	
		/*Local Self-Signed Certified start */
		get_by_id("self_name").style.display = "none";
		get_by_id("cu_part").style.display ="none";
		get_by_id("city_part").style.display ="none";
		get_by_id("og_part").style.display ="none";
		get_by_id("ou_part").style.display ="none";
		get_by_id("cn_part").style.display ="none";
		get_by_id("email_part").style.display ="none";
		//get_by_id("common_part1").style.display ="none";
		//get_by_id("common_part2").style.display ="none";
		//get_by_id("common_part3").style.display ="none";
		get_by_id("keylen_part").style.display ="none";
		get_by_id("validp_part").style.display ="none";
		/*Local Self-Signed Certified end */
	
		switch (get_by_id("certifi").selectedIndex){
		case 0:
			get_by_id("ca_name").style.display = "";
			get_by_id("priv_part").style.display = "";
			get_by_id("pub_part").style.display = "";
			break;
		case 1:
			get_by_id("ca_name").style.display = "";
			get_by_id("remote_part").style.display = "";
			break;
		case 2:
			get_by_id("ca_name").style.display = "";
			get_by_id("ca_part").style.display = "";
			break;
		case 3:
			get_by_id("self_name").style.display ="";
			get_by_id("cu_part").style.display ="";
			get_by_id("city_part").style.display ="";
			get_by_id("og_part").style.display ="";
			get_by_id("ou_part").style.display ="";
			get_by_id("cn_part").style.display ="";
			get_by_id("email_part").style.display ="";
			//get_by_id("common_part1").style.display ="";
			//get_by_id("common_part2").style.display ="";
			//get_by_id("common_part3").style.display ="";
			get_by_id("keylen_part").style.display ="";
			get_by_id("validp_part").style.display ="";
			break;
		}

		get_by_id("edit_row").value = index;
		change_multicolor(st, point);
	}

	function export_row(index, point, st)
	{
		 var new_top = screen.height/4;
		 var new_left = screen.width/4;
		 var ca_key = (get_by_id("txt"+index).value).split(",");
		 mywin = window.open('','','screenY='+new_top+',screenX='+new_left);
		 mywin.document.write("<body>");
		 mywin.document.write(ca_key[0]+"<hr>");
		 if (ca_key.length > 1) mywin.document.write(ca_key[1]);
		 mywin.document.write("</body>");
		 change_multicolor(st, point);
	}

	function download(index, point, st, ca_type)
	{
		document.form3.ca_idx.value = index;
		document.form3.ca_type.value = ca_type;
		send_submit("form3");
		change_multicolor(st, point);
	}

	function check_inused(idx)
	{
		var del_idx = parseInt(idx) - 1;
		var vpn_used = new Array(<!--# exec cgi /bin/ca_inused -->);
		if(vpn_used[del_idx] != "")
			return false;
		return true;
	}

	function del_row(index, point, st)
	{
		edit_row(index, point, st);
		var tb = get_by_id("table" + st); 

		if(!check_inused(index)){
			alert(adv_certi_del_msg);
		}else if(confirm(adv_certi_del_cfirm_msg1)){
			get_by_id("x509_action").value = "delete," + "x509_" + index + ",";
			send_submit("form1");
		}
	}

	function certifi_change()
	{
       		get_by_id("ca_name").style.display = "none";
       		get_by_id("priv_part").style.display = "none";
       		get_by_id("pub_part").style.display = "none";
       		get_by_id("remote_part").style.display = "none";
       		get_by_id("ca_part").style.display = "none";
		get_by_id("pki_pub_file").disabled = true;
		get_by_id("pki_priv_file").disabled = true;
		get_by_id("cert_file").disabled = true;
		get_by_id("ca_file").disabled = true;

		/*Local Self-Signed Certified start */
		get_by_id("self_name").style.display ="none";
		get_by_id("cu_part").style.display ="none";
		get_by_id("city_part").style.display ="none";
		get_by_id("og_part").style.display ="none";
		get_by_id("ou_part").style.display ="none";
		get_by_id("cn_part").style.display ="none";
		get_by_id("email_part").style.display ="none";
		//get_by_id("common_part1").style.display ="none";
		//get_by_id("common_part2").style.display ="none";
		//get_by_id("common_part3").style.display ="none";
		get_by_id("keylen_part").style.display ="none";
		get_by_id("validp_part").style.display ="none";
		/*Local Self-Signed Certified end */

		switch (get_by_id("certifi").selectedIndex){
		  case 0:
			get_by_id("ca_name").style.display = "";
			get_by_id("priv_part").style.display = "";
			get_by_id("pub_part").style.display = "";
			get_by_id("pki_pub_file").disabled = false;
			get_by_id("pki_priv_file").disabled = false;
			break;
		case 1:
			get_by_id("ca_name").style.display = "";
			get_by_id("remote_part").style.display = "";
			get_by_id("cert_file").disabled = false;
			break;
		case 2:
			get_by_id("ca_name").style.display = "";
			get_by_id("ca_part").style.display = "";
			get_by_id("ca_file").disabled = false;
			break;
		case 3:
			//location.href = "adv_certificate_self.asp";
			get_by_id("self_name").style.display ="";
			get_by_id("cu_part").style.display ="";
			get_by_id("city_part").style.display ="";
			get_by_id("og_part").style.display ="";
			get_by_id("ou_part").style.display ="";
			get_by_id("cn_part").style.display ="";
			get_by_id("email_part").style.display ="";
			//get_by_id("common_part1").style.display ="";
			//get_by_id("common_part2").style.display ="";
			//get_by_id("common_part3").style.display ="";
			get_by_id("keylen_part").style.display ="";
			get_by_id("validp_part").style.display ="";
			break;
		}
		
	}

	function check_validity(start_date, end_date)
	{
		var sys_time = "<!--# exec cgi /bin/get_time -->";
		var nNow = new Date(sys_time);

		var tmp_start = start_date.split(" ");
		var tmp_end = end_date.split(" ");
		var tmp_start_time = tmp_start[1] + " " + tmp_start[2] + ", "  + tmp_start[4] + " " + tmp_start[3];
		var tmp_end_time =  tmp_end[0] + " " + tmp_end[1] + ", "  + tmp_end[3] + " " + tmp_end[2];
		var test1 = new Date(tmp_start_time);
		var test2 = new Date(tmp_end_time);
		
		if(nNow <= test2 && nNow >= test1){
			return "<font color='#0000FF'>" + adv_certi_valid + "</font>";
		}else{
			return "<font color='#FF0000'>" + adv_certi_invalid + "</font>";
		}
	}
		
	function send_request()
	{
		var form = get_by_id("form2");
		form.elements["html_response_message"].value = sc_intro_sv;
		var x509_data, modi, certifi, max_row, is_add = true;
		var edit_row = get_by_id("edit_row").value;
		if ( get_by_id("certifi").selectedIndex == 3 ){
			get_by_id("certi_name").value = get_by_id("self_ca_name").value;
		}else{
			get_by_id("certi_name").value = get_by_id("certi_name1").value;
		}
		
		var check_name = get_by_id("certi_name").value;
		if ( check_name == ""){
			alert(TEXT034);
			return false;
		
		}else if (Find_word(check_name,'"') || Find_word(check_name,"/")) {
			alert( adv_certi_name_1 + " " + illegal_characters + "" +check_name);
			return false;
		}
		
		for(var i = 1; i <= rule_max_num; i++){
			if(i != edit_row && get_by_id("certi_name").value == name_list[i]){
				alert(adv_certi_cname_msg);
				return false;
			}
		}
		if (get_by_id("certifi").value == 0){
			certifi = ",PKI";
		}else if(get_by_id("certifi").value == 1){
			certifi = ",CERT";
		}else if(get_by_id("certifi").value == 2){
			certifi = ",CA_ROOT";
		}else if(get_by_id("certifi").value == 3){
			//certifi = ",local_self";
			document.form2.x509_action.value = "create";
			//document.form2.certi_name1.value = get_by_id("certi_name").value;
			document.form2.cu_name.value = get_by_id("cu_name").value;
			document.form2.og_name.value = get_by_id("og_name").value;
			document.form2.ou_name.value = get_by_id("ou_name").value;
			document.form2.city_name.value = get_by_id("city_name").value;
			document.form2.cn_name.value = get_by_id("cn_name").value;
			document.form2.com_email_addre.value = get_by_id("com_email_addre").value;
			document.form2.keylen.value = get_by_id("keylen").value;
			document.form2.valid_period.value = get_by_id("valid_period").value;
			send_submit("form2");
			return true;
		}
		if (edit_row == "-1"){
			var i;
			if ((get_by_id("pki_pub_file").value == "" || get_by_id("pki_priv_file").value == "") && get_by_id("certifi").value == 0){
				alert(adv_certi_both_alert);
				return false
			}else if (get_by_id("cert_file").value == "" && get_by_id("certifi").value == 1){
				alert(adv_certi_pk_alert);
				return false
			}else if (get_by_id("ca_file").value == "" && get_by_id("certifi").value == 2){
				alert(adv_certi_certi_alert);
				return false
			}
			/*else if (get_by_id("cu_name").value == "" &&	get_by_id("city_name").value == "" &&	
								get_by_id("og_name").value == "" && get_by_id("ou_name").value == "" &&
							  get_by_id("certifi").value == 3){
				alert("Please input value for thoes text.");
				return false;
			}*/
			modi = "add";
			for (i = 1; i <= rule_max_num; i++) {
				if (get_by_id("x509_" + i).value == "") 
					break;
			}

			max_row = i;
			if(max_row == rule_max_num + 1)
				is_add = false;
			else
				is_add = true;
			//max_row = parseInt(get_by_id("x509_max").value) + 1;
			if(is_add){
				get_by_id("x509_" + max_row).value = get_by_id("certi_name").value + certifi;
			}else{
				alert(adv_certi_full_msg);
				return false;
			}
		}else if (edit_row != "-1"){
			modi = "edit";
			max_row = edit_row;
			if (get_by_id("pki_pub_file").value == ""){
				get_by_id("pki_pub_file").disabled = true;
			}
			if(get_by_id("pki_priv_file").value == ""){
				get_by_id("pki_priv_file").disabled = true;
			}
			if(get_by_id("cert_file").value == ""){
				get_by_id("cert_file").disabled = true;
			}
			if(get_by_id("ca_file").value == ""){
				get_by_id("ca_file").disabled = true;
			}
			
			x509_data = (get_by_id("x509_" + max_row).value).split(";");
			get_by_id("x509_" + max_row).value = get_by_id("certi_name").value + certifi + ";" + x509_data[1] + ";" + x509_data[2] + ";" + x509_data[3];
		}
		
		if (is_add || modi == "edit")
			get_by_id("x509_action").value = modi + ",x509_" + max_row + "," + get_by_id("x509_" + max_row).value;

		if (submit_button_flag == 0){
			submit_button_flag = 1;
			send_submit("form1");
			return true;
		}else{
			return false;
		}
	}
	
	function table_header()
	{
		var arr = new Array(adv_certi_name, adv_certi_subject, adv_certi_validity, adv_certi_issuer, "");
		for (var i = 0; i < arr.length; i++)
			document.write("<td>"+arr[i]+"</td>");
	}

</script>

</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
                            <script>show_left("Advance", 11);</script>
                          </UL>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>

<input type="hidden" name="x509_1" id="x509_1" value="<!--# echo x509_1 -->">
<input type="hidden" name="x509_2" id="x509_2" value="<!--# echo x509_2 -->">
<input type="hidden" name="x509_3" id="x509_3" value="<!--# echo x509_3 -->">
<input type="hidden" name="x509_4" id="x509_4" value="<!--# echo x509_4 -->">
<input type="hidden" name="x509_5" id="x509_5" value="<!--# echo x509_5 -->">
<input type="hidden" name="x509_6" id="x509_6" value="<!--# echo x509_6 -->">
<input type="hidden" name="x509_7" id="x509_7" value="<!--# echo x509_7 -->">
<input type="hidden" name="x509_8" id="x509_8" value="<!--# echo x509_8 -->">
<input type="hidden" name="x509_9" id="x509_9" value="<!--# echo x509_9 -->">
<input type="hidden" name="x509_10" id="x509_10" value="<!--# echo x509_10 -->">
<input type="hidden" name="x509_11" id="x509_11" value="<!--# echo x509_11 -->">
<input type="hidden" name="x509_12" id="x509_12" value="<!--# echo x509_12 -->">
<input type="hidden" name="x509_13" id="x509_13" value="<!--# echo x509_13 -->">
<input type="hidden" name="x509_14" id="x509_14" value="<!--# echo x509_14 -->">
<input type="hidden" name="x509_15" id="x509_15" value="<!--# echo x509_15 -->">
<input type="hidden" name="x509_16" id="x509_16" value="<!--# echo x509_16 -->">
<input type="hidden" name="x509_17" id="x509_17" value="<!--# echo x509_17 -->">
<input type="hidden" name="x509_18" id="x509_18" value="<!--# echo x509_18 -->">
<input type="hidden" name="x509_19" id="x509_19" value="<!--# echo x509_19 -->">
<input type="hidden" name="x509_20" id="x509_20" value="<!--# echo x509_20 -->">
<input type="hidden" name="x509_21" id="x509_21" value="<!--# echo x509_21 -->">
<input type="hidden" name="x509_22" id="x509_22" value="<!--# echo x509_22 -->">
<input type="hidden" name="x509_23" id="x509_23" value="<!--# echo x509_23 -->">
<input type="hidden" name="x509_24" id="x509_24" value="<!--# echo x509_24 -->">
<input type="hidden" name="x509_max" id="x509_max">
<input type="hidden" name="edit_row" id="edit_row" value="-1">
<input type="hidden" name="del_row" id="del_row" value="-1">
<input type="hidden" name="export_row" id="export_row" value="-1">

<input type=hidden id=txt1 name=txt1 value="<!--# echo x509_ca_1 -->">
<input type=hidden id=txt2 name=txt2 value="<!--# echo x509_ca_2 -->">
<input type=hidden id=txt3 name=txt3 value="<!--# echo x509_ca_3 -->">
<input type=hidden id=txt4 name=txt4 value="<!--# echo x509_ca_4 -->">
<input type=hidden id=txt5 name=txt5 value="<!--# echo x509_ca_5 -->">
<input type=hidden id=txt6 name=txt6 value="<!--# echo x509_ca_6 -->">
<input type=hidden id=txt7 name=txt7 value="<!--# echo x509_ca_7 -->">
<input type=hidden id=txt8 name=txt8 value="<!--# echo x509_ca_8 -->">
<input type=hidden id=txt9 name=txt9 value="<!--# echo x509_ca_9 -->">
<input type=hidden id=txt10 name=txt10 value="<!--# echo x509_ca_10 -->">
<input type=hidden id=txt11 name=txt11 value="<!--# echo x509_ca_11 -->">
<input type=hidden id=txt12 name=txt12 value="<!--# echo x509_ca_12 -->">
<input type=hidden id=txt13 name=txt13 value="<!--# echo x509_ca_13 -->">
<input type=hidden id=txt14 name=txt14 value="<!--# echo x509_ca_14 -->">
<input type=hidden id=txt15 name=txt15 value="<!--# echo x509_ca_15 -->">
<input type=hidden id=txt16 name=txt16 value="<!--# echo x509_ca_16 -->">
<input type=hidden id=txt17 name=txt17 value="<!--# echo x509_ca_17 -->">
<input type=hidden id=txt18 name=txt18 value="<!--# echo x509_ca_18 -->">
<input type=hidden id=txt19 name=txt19 value="<!--# echo x509_ca_19 -->">
<input type=hidden id=txt20 name=txt20 value="<!--# echo x509_ca_20 -->">
<input type=hidden id=txt21 name=txt21 value="<!--# echo x509_ca_21 -->">
<input type=hidden id=txt22 name=txt22 value="<!--# echo x509_ca_22 -->">
<input type=hidden id=txt23 name=txt23 value="<!--# echo x509_ca_23 -->">
<input type=hidden id=txt24 name=txt24 value="<!--# echo x509_ca_24 -->">
<input type="hidden" id="certi_name" name="certi_name" value="">
<input type="hidden" id="result_timer" name="result_timer" value=10>

<td valign="top" id="maincontent_container">
<div id="maincontent">

<div id="box_header"> 
	<h1><script>show_words(adv_certi);</script> : </h1>
	    <script>show_words(adv_certi_info);</script><br><br>
        <input name="button" id="button" type="submit" class="button_submit" value="" onClick="return send_request()">
        <input name="button2" id="button2" type="button" class="button_submit" value=""  onClick="window.location.href='adv_certificate.asp'">
		<script>check_reboot();</script>
		<script>get_by_id("button").value = _savesettings;</script>
		<script>get_by_id("button2").value = _dontsavesettings;</script>
</div>

	<div class="box"> 
		<h2><script>show_words(adv_certi);</script> : </h2>
		<select id="certifi" name="certifi" size=1 onChange="certifi_change()">
			<option value="0" selected><script>show_words(adv_certi_op0);</script></option>
			<option value="1"><script>show_words(adv_certi_op1);</script></option>
			<option value="2"><script>show_words(adv_certi_op2);</script></option>
			<option value="3"><script>show_words(adv_certi_op3);</script></option>
		</select> <script>show_words(adv_certi_select_type);</script>
<form id="form1" name="form1" method=POST action="upload_certificate.cgi" enctype=multipart/form-data >
<input type="hidden" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" name="html_response_error_message" value="Invalid certificate file format">
<input type="hidden" name="html_response_return_page" value="adv_certificate.asp">
<input type="hidden" name="x509_action" id="x509_action">
<input type="hidden" id="action" name="action" value="certificate">

               <table width="525" border=0 cellPadding=1 cellSpacing=1>
                 <tr id="ca_name">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_name);</script> :</div></td>
		  <td><input type=text name="certi_name1" id="certi_name1" size="20" maxlength="16" value="<!--# echo certi_name -->">
		  </td>
                 </tr>
                 <tr id="priv_part">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_prikey);</script> :</div></td>
                  <td width="318"><input type="file" id="pki_priv_file" name="pki_priv_file" size=20></td>
                 </tr>
                 <tr id="pub_part">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_cert);</script> :</div></td>
                  <td><input type="file" id="pki_pub_file" name="pki_pub_file" size=20></td>
                 </tr>
                 <tr id="remote_part">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_cert);</script> :</div></td>
                  <td width="318"><input type="file" id="cert_file" name="cert_file" size=20></td>
                 </tr>
                 <tr id="ca_part">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_cert);</script> :</div></td>
                  <td><input type="file" id="ca_file" name="ca_file" size=20></td>
                 </tr>
</form>
<form id="form2" name="form2" method=POST action="apply.cgi" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" name="html_response_error_message" value="Invalid certificate file format">
<input type="hidden" name="html_response_return_page" value="adv_certificate.asp">
<input type="hidden" name="x509_action" id="x509_action">
<input type="hidden" id="action" name="action" value="certificate_create">
<!--<input type="hidden" id="certi_name1" name="certi_name1" value="">-->
<input type="hidden" id="cu_name" name="cu_name" value="">
<input type="hidden" id="og_name" name="og_name" value="">
<input type="hidden" id="ou_name" name="ou_name" value="">
<input type="hidden" id="city_name" name="city_name" value="">
<input type="hidden" id="cn_name" name="cn_name" value="">
<input type="hidden" id="com_email_addre" name="com_email_addre" value="">
<input type="hidden" id="keylen" name="keylen" value="">
<input type="hidden" id="valid_period" name="valid_period" value="">
                 <tr id="self_name">
                  <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_cert_name);</script> :</div></td>
		  <td><input type=text name="self_ca_name" id="self_ca_name" size="20" maxlength="16"></td>
                 </tr>
		 <tr id="cu_part">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_cu_name);</script> :</div></td>
		    <td><input type="text" id="cu_name" name="cu_name" size="2" maxlength="2"></td>
		 </tr>
		 <tr id="city_part">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_ct_name);</script> :</div></td>
		    <td><input type="text" id="city_name" name="city_name" size="64" maxlength="64"></td>
		</tr>	
		<tr id="og_part">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_og_name);</script> :</div></td>
		    <td><input type="text" id="og_name" name="og_name" size="64" maxlength="64"></td>
		</tr>
		<tr id="ou_part">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_og_unit);</script> :</div></td>
		    <td><input type="text" id="ou_name" name="ou_name" size="64" maxlength="64"></td>
		</tr>
		<tr id="cn_part">
		     <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_com_name);</script> :</div></td>
		    <td><input type="text" id="cn_name" name="cn_name" size="64" maxlength="64"></td>
		</tr>
		<tr id="email_part">
		<td width="200" class=form_label><div align="right"><script>show_words(adv_certi_email);</script> :</div></td>
		<td><input type="text" id="com_email_addre" name="com_email_addre" size="20"></td>
		</tr>
<!-- 
		<tr id="common_part1" style="display:none">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_com_name);</script> :</div></td>
		    <td><input type="radio" id="radio_com" name="radio_com" value="0"><script>show_words(adv_certi_hostip);</script>
		    <input type="text" id="com_ip" name="com_ip" size="20">
	  	</tr>
		<tr id="common_part2" style="display:none">
		    <td>&nbsp;</td>
		    <td><input type="radio" id="radio_com" name="radio_com" value="1"><script>show_words(adv_certi_host_dname);</script>
		    <input type="text" id="com_domain_name" name="com_domain_name" size="20" >
		 </td>
		</tr>
		<tr id="common_part3"><td></td>
		 <td><input type="radio" id="radio_com" name="radio_com" value="2"><script>show_words(adv_certi_email);</script>
		     <input type="text" id="com_email_addre" name="com_email_addre" size="20" >
		 </td>
		</tr>
-->
		<tr id="keylen_part">
		 <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_klen);</script> :</div></td>
		 <td><select id="keylen" name="keylen">
			 <option value=512 >512-bit</option>
			 <option value=768 >768-bit</option>
			 <option value=1024 >1024-bit</option>
<!--
			 <option value=1526 >1526-bit</option>
			 <option value=2048 >2048-bit</option>
-->
		     </select>
		     (RSA)
		 </td>
		</tr>
		<tr id="validp_part">
		    <td width="200" class=form_label><div align="right"><script>show_words(adv_certi_vperid);</script> :</div></td>
		    <td><select id="valid_period" name="valid_period">
				<option value=365 >1 Years</option>
				<option value=730 >2 Years</option>
				<option value=1095 >3 Years</option>
				<option value=1460 >4 Years</option>
				<option value=1825 >5 Years</option>
			</select>
		    </td>
		</tr>
	</table>
       </div>
</form>
	<div class="box"> 
	  <h2><script>show_words(adv_certi_local_id);</script></h2>
	  <script>set_certificate();</script>
	  <table id="table0" width="525" border=0 cellPadding=1 cellSpacing=1>                
	  <tr>
	  <script>table_header();</script>
	  </tr>
	  <script>	
		var idx = 1;
		for(i = 1; i < DataArray.length; i++){
			if (DataArray[i].Name != "" && DataArray[i].State == "PKI"){
				var temp_time = (DataArray[i].Expire).split("-");
				var tmp_valid = check_validity(temp_time[0], temp_time[1]);
				document.write("<tr><td width='15%'><font size='-6'>" + DataArray[i].Name + "</font></td>");
				var subject_data = (DataArray[i].Subject).split(",");
				document.write("<td width='30%'><font size='-6'>" + subject_data[0] + " , " +subject_data[1] + "<br/> " + subject_data[2]+ " , " +subject_data[3] + "<br/>" + subject_data[4] + " ,<br/>" + subject_data[5] + "</font></td>");
				document.write("<td width='25%'><font size='-6'>" + temp_time[0] + " - <br>" + temp_time[1] + "<br>" + tmp_valid + "</font></td>");
				var issuer_data = (DataArray[i].Issuer).split(",");
				document.write("<td width='30%'><font size='-6'>" + issuer_data[0] + " , " +issuer_data[1] + "<br/>" +issuer_data[2] + " , " +issuer_data[3] + "<br/>" + issuer_data[4] + " ,<br/>" + issuer_data[5]+ "</font></td>");
				document.write("<td><a href=\"javascript:edit_row("+ DataArray[i].OnList + ", " + idx + ", 0)\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a><br/><a href=\"javascript:del_row("+ DataArray[i].OnList + ", " + idx +", 0)\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a><br/><a href=\"javascript:export_row("+ DataArray[i].OnList + ", " + idx + ", 0)\"><img src=\"/Export_icon.gif\" border=\"0\" alt=\"export\"></a><br/><a href=\"javascript:download("+ DataArray[i].OnList + ", " + idx + ", 0, 'public')\"><img src=\"/Export_icon.gif\" border=\"0\" alt=\"export\"></a><br><a href=\"javascript:download("+ DataArray[i].OnList + ", " + idx + ", 0, 'private')\"><img src=\"/Export_icon.gif\" border=\"0\" alt=\"export\"></a></td></tr>");
				idx++;
			}
		}
	 </script>
	</table>  
	</div>
	<div class="box"> 
	  <h2><script>show_words(adv_certi_remote);</script> </h2>
	  <table id="table1" width="525" border=0 cellPadding=1 cellSpacing=1>                
	  <tr>
	  <script>table_header();</script>
	  </tr>
	 <script>	
		//set_certificate();
		var idx = 1;
		for(i = 1; i < DataArray.length; i++){
			if (DataArray[i].Name != "" && DataArray[i].State == "CERT"){
				var temp_time = (DataArray[i].Expire).split("-");
				var tmp_valid = check_validity(temp_time[0], temp_time[1]);
                                document.write("<tr><td width='15%'><font size='-6'>" + DataArray[i].Name + "</font></td>");
                                var subject_data = (DataArray[i].Subject).split(",");
                                document.write("<td width='30%'><font size='-6'>" + subject_data[0] + "," +subject_data[1] + "," + subject_data[2]+ "<br />" +subject_data[3] + "," +subject_data[4] + "<br/>" + subject_data[5] + "</font></td>");
                                document.write("<td width='25%'><font size='-6'>" + temp_time[0] + " - <br>" + temp_time[1] + "<br>" + tmp_valid + "</font></td>");
                                var issuer_data = (DataArray[i].Issuer).split(",");
                                document.write("<td width='30%'><font size='-6'>" + issuer_data[0] + "," +issuer_data[1] + "," + issuer_data[2] + "<br />" +issuer_data[3] + "," +issuer_data[4] + "<br/>" +issuer_data[5]+ "</font></td>");
                                document.write("<td><a href=\"javascript:edit_row("+ DataArray[i].OnList + ", " + idx + ", 1)\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a><a href=\"javascript:del_row("+ DataArray[i].OnList + ", " + idx +", 1)\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a><a href=\"javascript:export_row("+ DataArray[i].OnList + ", " + idx + ", 1)\"><img src=\"/Export_icon.gif\" border=\"0\" alt=\"export\"></a></td></tr>");
                                idx++;
			}
		}
	</script>
	</table>  
	</div>
	<div class="box"> 
	  <h2><script>show_words(adv_certi_ca);</script></h2>
	  <table id="table2" width="525" border=0 cellPadding=1 cellSpacing=1>                
	  <tr>
	  <script>table_header();</script>
	  </tr>
	  <script>	
		//set_certificate();
		var idx = 1;
		for(i = 1; i < DataArray.length; i++){
			if (DataArray[i].Name != "" && DataArray[i].State == "CA_ROOT"){
				var temp_time = (DataArray[i].Expire).split("-");
				var tmp_valid = check_validity(temp_time[0], temp_time[1]);
                                document.write("<tr><td width='15%'><font size='-6'>" + DataArray[i].Name + "</font></td>");
                                var subject_data = (DataArray[i].Subject).split(",");
				document.write("<td width='30%'><font size='-6'>" + subject_data[0] + "," +subject_data[1] +","+ subject_data[2]+ "<br />" +subject_data[3] + "," +subject_data[4] + "<br/>" + subject_data[5] + "</font></td>");
				document.write("<td width='25%'><font size='-6'>" + temp_time[0] + " - <br>" + temp_time[1] + "<br>" + tmp_valid + "</font></td>");
				var issuer_data = (DataArray[i].Issuer).split(",");
				document.write("<td width='30%'><font size='-6'>" + issuer_data[0] + "," + issuer_data[1] +","+ issuer_data[2] + "<br />" +issuer_data[3] + "," +issuer_data[4] + "<br/>"+issuer_data[5]+ "</font></td>");
                                document.write("<td><a href=\"javascript:edit_row("+ DataArray[i].OnList + ", " + idx + ", 2)\"><img src=\"/edit.jpg\" border=\"0\" alt=\"" + _edit +"\"></a><a href=\"javascript:del_row("+ DataArray[i].OnList + ", " + idx +", 2)\"><img src=\"/delete.jpg\"  border=\"0\" alt=\"" + _delete + "\"></a><a href=\"javascript:export_row("+ DataArray[i].OnList + ", " + idx + ", 2)\"><img src=\"/Export_icon.gif\" border=\"0\" alt=\"export\"></a></td></tr>");
                                idx++;
			}
		}
	</script>
	</table>  
	</div>
	</div>
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>..</strong>
					  		<br><br>
                          <span class="style1"><script>show_words(adv_certi_help_msg1);</script></span></p>
                      	  <p class="style1"><script>show_words(adv_certi_help_msg2);</script></p>
                      	  <p class="style1"><script>show_words(adv_certi_help_msg3);</script></p>
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
	<form id="form3" name="form3" method="GET" action="save_certificate.cgi">
	<input type="hidden" id="ca_idx" name="ca_idx" value="">
	<input type="hidden" id="ca_type" name="ca_type" value="">
	</form>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
<script>
	reboot_needed(left["Advance"].link[11]);
	certifi_change();
</script>
</body>
</html>
