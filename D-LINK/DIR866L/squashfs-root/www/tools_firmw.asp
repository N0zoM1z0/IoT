<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var bVer=parseInt(navigator.appVersion);
	var IE=(navigator.appName == "Microsoft Internet Explorer") ? true : false;
	function onPageLoad(){
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}
	
		if ("<!--# echo sys_lang_en -->" == "none"){
			get_by_id("lp").style.display="none";
			get_by_id("rm_lp").style.display="none";
			get_by_id("rm_lp2").style.display="none";
			get_by_id("no_lp").style.display="none";
			get_by_id("fw_lp").style.display="none";
			get_by_id("fw_lp_info").style.display="none";
		} else { 
//			var lang_region = "<!--# echo lang_region -->";
			var lang_region = "<!--# exec cgi /bin/lang key LANG -->";
			if(lang_region.length >= 2) {
				get_by_id("no_lp").style.display="none";
			} else {
				get_by_id("rm_lp").style.display="none";
				get_by_id("rm_lp2").style.display="none";
			}

			get_by_id("fw").style.display="none";
			get_by_id("fw_info").style.display="none";
		}
	}

	function send_request(){
		if (get_by_id("file").value === "") {
			alert(tf_FWF1);
			return false;
		}
		if (!confirm(tf_USSW)) {
			return false;
		}
		if (!confirm(tf_really_FWF + " \"" + get_by_id("file").value + "\"?")) {
				return false;
		}
		
		try {
			get_by_id("msg_upload").style.display = "";
			get_by_id("upgrade_button").disabled = true;
			if(submit_button_flag == 0){
				if (IE && bVer <= 6){
					document.forms.form1.submit();
				}
				submit_button_flag = 1;
				send_submit("form1");
			}
		} catch (e) {
			alert("%[.error:Error]%: " + e.message);
			get_by_id("msg_upload").style.display = "none";
			get_by_id("upgrade_button").disabled = false;
		}
		
	}
	
	function New_update_button(){
		parent.document.getElementById("check_now_result").style.display ="none";
		get_by_id("iframe_scan").src = "tools_firmw_chk.asp";

		if ("<!--# echo sys_lang_en -->" === "none")
			get_by_id("check_now_b").disabled = true;
		
		get_by_id("check_now_c").disabled = true;

		document.getElementById("check_result").innerHTML = "";
	}
	
	function download_latest_fw_lp(id_name){
		var sel;
		if(id_name == "download")
			sel = "sel_site";
		else if(id_name == "download_lp") 
			sel = "sel_site_lp";

                for (var i = 0; i < get_by_id(sel).length; i++){
                        if(get_by_id(sel).options[i].selected == true){
                                var html = get_by_id(sel).options[i].value;
			}
		}
		window.open(""+html+"");
	}
	function auto_update_latest_fw_lp(id_name){
		var sel;
		if(id_name == "auto_update_fw") {
			sel = "sel_site";
			get_by_id("update_type").value = "fw";
		} else if(id_name == "auto_update_lp") {
			sel = "sel_site_lp";
			get_by_id("update_type").value = "lp";
		}
                for (var i = 0; i < get_by_id(sel).length; i++){
                        if(get_by_id(sel).options[i].selected == true){
                                var html = get_by_id(sel).options[i].value;
				var file_site = get_by_id(sel).options[i].text
			}
		}
		get_by_id("file_link").value = html;

		var url_tmp = html.split("/");
		get_by_id("file_name").value = url_tmp[url_tmp.length-1];

		if(submit_button_flag == 0){
			if (!confirm(tf_USSW)) 
				return false;
			if (!confirm(tf_really_FWF + " \"" + file_site+ "\"?")) 
				return false;
			submit_button_flag = 1;
			send_submit("form3");
		}
	}
	
	function send_clear_LP()
	{
		if (!confirm(clear_language_pack)) {
                        return;
		}

		if (submit_button_flag == 0) {
			submit_buuton_flag = 1;
			send_submit("lp_clear");
		}
	}
	
	function send_lp_request()
	{
		if (get_by_id("lp_file").value === "") {
			alert(tr_CFLDNO);
			return false;
		}
		if (!confirm(tf_ULP)) {
			return false;
		}
		if (!confirm(ReplaceAll(tf_really_LP,"%s",get_by_id("lp_file").value))) {
				return false;
		}
		
		try {
			get_by_id("lp_msg_upload").style.display = "";
			get_by_id("btn_upgrade_lp").disabled = true;
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				send_submit("form2");
			}
		} catch (e) {
			alert("%[.error:Error]%: " + e.message);
			get_by_id("lp_msg_upload").style.display = "none";
			get_by_id("btn_upgrade_lp").disabled = false;
		}
	}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
  <tr>
    <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
    <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
   <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
   <td>&nbsp;</td>
  </tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
  <tr><td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td></tr>
</table>
<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
  <tr id="topnav_container">
    <td><img src="/short_modnum.gif" width="125" height="25"></td>
    <script>show_top("tools");</script>
  </tr>
</table>
<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
  <tr>
    <td id="sidenav_container" valign="top" width="125" align="right">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr><td id="sidenav_container">
          <div id="sidenav"><ul><script>show_left("tools", 5);</script></ul></div>
        </td></tr>
      </table>			
    </td>
    <td valign="top" id="maincontent_container">
      <div id="maincontent">				
        <div id="box_header"> 
          <h1><script>show_words(_firmwareupdate)</script></h1>
          <p><script>show_words(tf_intro_FWU1)</script>&nbsp;<!--# echo model_number -->
          <script>show_words(tf_intro_FWU2)</script></p>
          <p><script>show_words(tf_intro_FWChB)</script></p>
	  <script>
		if ("<!--# echo sys_lang_en-->" != "none") {
			var regex = /%m/gi;
			var lang_info = "<p>" + 
				tf_intro_LANGU.replace(regex, "<!--# echo model_number -->") +
				"</p>" ;
			lang_info+= "<p>"+tf_intro_LANGU1+"</p>";
			show_words(lang_info);
		}
          </script>
        </div>
        <div class="box"> 
          <h2><script>show_words(_ap_firmware_title)</script></h2>
          <table width=525 border=0 cellpadding=2 cellspacing="2">
            <!-- Firmware Version -->
	    <tr>
              <td width="40%" align="right"><strong><script>show_words(tf_CFWV);</script></strong>&nbsp;:</td>
              <td width="10%" align="left"><strong><!--# echo sys_fw_version --><!--# echox sys_region NA --></strong></td>
              



	    		<td width="10%" align="right"><strong><script>show_words(tf_CFWD)</script></strong>&nbsp;:</td>
          <td width="40%" align="left"><strong> 
                <script>
                  var fw_date = "<!--# echo sys_fw_date -->";
		  						var regex=/,/gi;
		  						show_words(fw_date.replace(regex, ""));
                </script>
	      			</strong>
	      </td>
	    </tr>
            <!-- Language Version -->
            <form id="lp_clear" name="lp_clear" method="POST" action="lp_clear.cgi" enctype="multipart/form-data">
            <input type="hidden" id="html_response_page" name="html_response_page" value="ustatus.asp">
            <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
	    <tr id="rm_lp">
              <td width="40%" align="right"><strong><script>show_words(tr_CFLV);</script></strong>&nbsp;:</td>
              <td width="10%" align="left"><strong>
                <script>
                        var version = "<!--# exec cgi /bin/lang key VERSION -->";
                        var region = "<!--# exec cgi /bin/lang key LANG -->";
                        if ((version).length != 0) {
                                var _version = version.split("b");
                                show_words(_version[0]+region);
                        }
                </script>
              </strong></td>
              <td width="20%" align="right"><strong><script>show_words(_date)</script>&nbsp;:</strong></td>
              <td width="30%" align="left"><strong><!--# exec cgi /bin/lang key DATE --></strong></td>
	    </tr>
            <!-- Remove Language Button -->
	    <tr id="rm_lp2">
              <td align="right" width="40%">
                <strong><script>
                  show_words(tr_CFLDRM);
                  /* Don't remove it. Follow D-Link Spec with */
                  if (("<!--# echo sys_lang_en -->" != "none") &&
                     ("<!--# exec cgi /bin/lang key LANG -->" != "0" && "<!--# exec cgi /bin/lang key LANG -->" != "")) {
                    show_words("(Remove Language Pack)");
                  }
                </script>:</strong>
              </td>
              <td colspan="3" align="left" width="60%">
                <input type="button" id="rm_lang" name="rm_lang" value="" onClick="send_clear_LP();">
                <script>
                /* Don't remove it. Follow D-Link Spec with */
                  if (("<!--# echo sys_lang_en -->" != "none") && 
                     ("<!--# exec cgi /bin/lang key LANG -->" != "0" && "<!--# exec cgi /bin/lang key LANG -->" != "")) {
                    get_by_id("rm_lang").value=_remove + "(Remove)";
                  } else {
                    get_by_id("rm_lang").value=_remove;
                  }
                </script>
	      </td>
	    </tr>
            <!-- No Language Pack -->
	    <tr id="no_lp">
             <td align="right" width="40%"><strong><script>show_words(tr_CFLV);</script>:<strong>
</td>
             <td colspan=3 align="left" width="60%"><strong><script>show_words(tr_CFLDNO);</script><strong>
</td>
            </tr>
            </form>
	    <!-- Check Firmware and Single Language -->
	    <tr id="fw">
              <td colspan=4 align="left">
                <strong>
                <script>show_words(tf_COLF)</script>:
                <input type="button" id="check_now_b" name="check_now_b" class=button_submit value="" onClick="New_update_button();">
                <script>get_by_id("check_now_b").value = tf_CKN;</script>
                </strong>
              </td>
	    </tr>
            <!-- Check Firmware and Language Version of Multi Language -->
	    <tr id="fw_lp">
              <td colspan=4 align="left">
                <strong>
                <script>show_words(tf_COLFL)</script>:
                <input type="button" id="check_now_c" name="check_now_c" class=button_submit value="" onClick="New_update_button();">
                <script>get_by_id("check_now_c").value = tf_CKN;</script>
                </strong>
              </td>
            </tr>
            <tr>
              <td colspan=4 align="left"><strong><div id="check_result"></div></strong></td>
	    </tr>
	  </table>
       </div>
       <div id="check_now_result" name="check_now_result" class="box" style="display:none"> 
         <h2 id="fw_info"><script>show_words(tf_FWCheckInf);</script></h2>
         <h2 id="fw_lp_info"><script>show_words(tf_FWLPCheckInf);</script></h2>
         <table width=525 height=57 border=0 cellpadding=2 cellspacing="2">
           <tr id="fw_up_1">
             <td width="35%"><div align="right"><script>show_words(tf_LFWV)</script>&nbsp;</div></td>
             <td width="65%" height=10 colspan=2><div align="left" id="latest_version"></div></td>
           </tr>
           <tr id="fw_up_2">
             <td width="35%"><div align="right"><script>show_words(tf_LFWD)</script> &nbsp;</div></td>
             <td width="65%" height=10 colspan=2><div align="left" id="latest_date"></div></td>
           </tr>
           <tr id="fw_up_3">
             <td width="35%"><div align="right"><script>show_words(tf_ADS)</script> &nbsp;</div></td>
             <td width="65%" height=10 colspan=2>
               <select id="sel_site" name="sel_site" onChange=""></select></td>
           </tr>
           <tr id="fw_up_4">
             <td width="35%"></td>
             <td width="65%" colspan="3" height="21">
               <input type="button" name="download"  id="download" value="Download" onClick="download_latest_fw_lp(this.id);">
               <script>get_by_id("download").value = help501;</script>
	    </td>
           </tr>
         <tr id="lp_up_1">
           <td width="35%"><div align="right"><script>show_words(tf_LLPV)</script>&nbsp;</div></td>
           <td width="65%" height=10 colspan=2><div align="left" id="latest_version_lp"></div></td>
         </tr>
         <tr id="lp_up_2">
           <td width="35%"><div align="right"><script>show_words(tf_LLPD)</script> &nbsp;</div></td>
           <td width="65%" height=10 colspan=2>
           <div align="left" id="latest_date_lp"></div></td>
         </tr>
         <tr id="lp_up_3">
           <td width="35%"><div align="right"><script>show_words(tf_ADS)</script> &nbsp;</div></td>
           <td width="65%" height=10 colspan=2><select id="sel_site_lp" name="sel_site_lp" onChange=""></select></td>
         </tr>
         <tr id="lp_up_4">
           <td width="35%"></td>
           <td width="65%" colspan="3" height="21">
             <input type="button" name="download_lp"  id="download_lp" value="Download_lp" onClick="download_latest_fw_lp(this.id);">
             <script>get_by_id("download_lp").value = help501;</script>
               <!--input type="button" name="auto_update_lp"  id="auto_update_lp" value="Auto Update" onClick="auto_update_latest_fw_lp(this.id);">
	       <script>get_by_id("auto_update_lp").value = auto_update_TEXT00;</script-->
           </td>
         </tr>
         <tr id="lp_up_5">
           <td colspan=3>
             <p></p><p></p>
             <p class="box_alert">
             <strong><script>show_words(_note)</script>:</strong>
             <script>show_words(tf_msg_LPugRest)</script>
             </p>
           </td>
         </tr>
       </table>
       </div>
       <form id="form1" name="form1" method=POST action="update_firmw.cgi" enctype="multipart/form-data">
         <input type="hidden" id="html_response_page" name="html_response_page" value="ustatus.asp">
         <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
         <div class="box"> 
         <h2><script>show_words(tf_FWUg)</script></h2>
         <table width=525 border=0 cellpadding=2 cellspacing="2">
           <tr>
             <td colspan=3>
             <p class="box_alert">
             <strong><script>show_words(_note)</script>:</strong>
             <script>show_words(tf_msg_FWUgReset)</script>
             </p>
             <p class="box_msg">
             <script>show_words(tf_msg_wired)</script>
             </p>
             </td>
           </tr>
           <tr>
             <td align=right class="duple"></td>
             <td height="59" colspan=2>
               <input type=file id=file name=file size="30"><br>
               <input type=button id="upgrade_button" name="upgrade_button" class="button_submit" value="" onClick="send_request()">
               <script>get_by_id("upgrade_button").value = tf_Upload</script>
             </td>
           </tr>
           <tr id="msg_upload" style="display:none" class="msg_inprogress">
             <td align=right class="duple"></td>
             <td colspan=2><script>show_words(tf_msg_Upping)</script></td>
           </tr>
         </table>
         </div>
       </form>
       <form id="form2" name="form2" method="POST" enctype="multipart/form-data" action="upload_lang.cgi">
       <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
       <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
       <div class="box" id="lp"> 
         <h2><script>show_words(tf_LAUg)</script></h2>
         <table width=525 border=0 cellpadding=2 cellspacing="2">
           <tr align="center">
             <td>
               <strong><script>show_words(tf_Upload);</script> :</strong>
               <input type="file" id="lp_file" name="lp_file" size="30">
               <input type="button" id="btn_upgrade_lp" name="btn_upgrade_lp" class="button_submit" value="" onClick="send_lp_request()">
               <script>get_by_id("btn_upgrade_lp").value = tf_Upload;</script>
             </td>
           </tr>
           <tr id="lp_msg_upload" style="display:none" class="msg_inprogress">
             <td align=right class="duple"></td>
             <td colspan=2><script>show_words(tf_msg_Upping)</script></td>
           </tr>
         </table>
       </div>
       </form>
       <form id="form3" name="form3" method=POST action="apply.cgi">
        <input type="hidden" id="html_response_page" name="html_response_page" value="auto_ustatus.asp">
        <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
        <input type="hidden" id="file_link" name="file_link" value="">
        <input type="hidden" id="file_name" name="file_name" value="">
        <input type="hidden" id="update_type" name="update_type" value="">
        <input type="hidden" id="action" name="action" value="download_fw_lp">
       </form>
       <div id="update_new_result" name="update_new_result"> 
       <table width=90% border=0 cellpadding=2 cellspacing="2">
       <tr>
         <td height=0 align="center">
         <IFRAME id="iframe_scan" name="iframe_scan" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no"></IFRAME>
         </td>
       </tr>
       </table>
       </div>
     </div>
   </td>
   <td valign="top" width="150" id="sidehelp_container" align="left">
     <table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
     <tr>
       <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
       <p><script>show_words(ZM17)</script></p>
       <p class="more"><a href="support_tools.asp#Firmware" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
       </td>
     </tr>
     </table>
    </td>
  </tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
  <tr>
    <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
    <td width="10">&nbsp;</td><td>&nbsp;</td>
  </tr>
</table>
<br><div id="copyright"><script>show_words(_copyright);</script></div><br>
</body>
<script>
  onPageLoad();
</script>
</body>
</html>
