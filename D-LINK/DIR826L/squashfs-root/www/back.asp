<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	
	var redirectpage = "";
	var count = 0;
	var evt = getUrlEntry("event");
	//alert(evt);
	function gup( name ){  
		name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");  
		var regexS = "[\\?&]"+name+"=([^&#]*)";  
		var regex = new RegExp( regexS );  
		var results = regex.exec( window.location.href );  
		if( results == null )    
			return "";  
		else    
			return results[1];
	}
	
	function lan_action()
	{
		var old_ip = getUrlEntry("old_ip");
		var old_mask = getUrlEntry("old_mask");
		var new_ip = getUrlEntry("new_ip");
		var new_mask = getUrlEntry("new_mask");
		var pc_ip = getUrlEntry("pc_ip");
		
		if(old_ip == "(nill)")
			old_ip = "0.0.0.0";
		if(old_mask == "(nill)")
			old_mask = "0.0.0.0";
		if(new_ip == "(nill)")
			new_ip = "0.0.0.0";
		if(new_mask == "(nill)")
			new_mask = "0.0.0.0";
			
		var temp_old_ip_obj = new addr_obj(old_ip.split("."), "", true, false);
		var temp_old_mask_obj = new addr_obj(old_mask.split("."), "", true, false);
		var temp_new_ip_obj = new addr_obj(new_ip.split("."), "", true, false);
		var temp_new_mask_obj = new addr_obj(new_mask.split("."), "", true, false);
		var temp_pc_ip_obj = new addr_obj(pc_ip.split("."), "", true, false);

		//alert(temp_old_ip_obj.addr);
		var param={
			url: "get_set.ccp",
			arg: ""
		};
		param.arg = "ccp_act=doEvent&ccpSubEvent="+evt;
		get_config_obj(param);
		if(check_domain(temp_old_ip_obj, temp_old_mask_obj, temp_pc_ip_obj) == false) // from wan
		{
			//get_by_id("newlink").innerHTML = '<a href="lan.htm" onclick="return jump_if();"><u>Link</u></a>';
			//window.location.href = "lan.htm";
			redirect_target = "lan.asp";
		}
		else	//from lan
		{
			/*
			if(new_ip == old_ip)
			{
				//alert("same domain and use old lan ip");
			}
			else
			{
				//alert("same domain and but lan ip changed");
				//get_by_id("newlink").innerHTML = '<a href="http://'+new_ip+'"><u>Link</u></a>';
				redirect_target = "http://" + new_ip;
			}
			*/
			redirect_target = "http://" + new_ip;
		}

		count = parseInt(config_val("count_down"));
		//alert("Lan IP has been changed, please wait for "+ count +" seconds.");
		//redirectpage = "lan.htm";
	}
	
	function devModeChange()
	{
		var new_ip = getUrlEntry("new_ip");
		redirect_target = "http://" + new_ip;
	}
	
	function onPageLoad(){
		if( evt == "CCP_SUB_LAN" )
			lan_action();
		else if(evt == 'devModeChange')
			devModeChange();
	}
	function back(){
		//if(login_Info!= "w")
			//window.location.href ="lan.htm";
		//else
			//window.location.href = redirectpage;
			//window.location.href = get_by_id("html_response_return_page").value;
		//get_by_id("newlink").style.display = "";
		window.location.href = redirect_target;
	}
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;
		
		if (count == 0) {	  
			//alert("count=0");
			if( evt == "CCP_SUB_LAN" )
			{
				get_by_id("button").disabled = false;
				//back();
			}
			else if(evt == 'devModeChange'){
				get_by_id("newlink").style.display = "";
				get_by_id("button").disabled = false;
			}
				
	        return false;
	    }

		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }
	
	}
		
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tbody>
  
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;<script>show_words('TA2')</script>: <a href="http://support.dlink.com.tw/"><script>document.write(model);</script></a></td>
            <td align="right" nowrap><script>show_words('TA3')</script>: <script>document.write(hw_version);</script> &nbsp;</td>
			<td align="right" nowrap><script>show_words('sd_FWV')</script>: <script>document.write(version);</script></td>
			<td>&nbsp;</td>
          </tr>
        </table>
        <img src="wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tbody>
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>            <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <H1 align="left"><span class="style1">&nbsp;</span>
                      <!-- insert name=title -->
					  <script>show_words(sc_intro_sv)</script>
                  </H1>
                  <div align="left">
					<!--<p align="center" class="centered">Please wait <font color="#0000CC"><b><span id="timeleft"></span></b></font>&nbsp;seconds ...</p>
                    -->
					<p class="centered"><script>show_words(rb_wait)</script></p>
					<p align="center" class="centered"><script>document.write(which_lang[sc_intro_sv]);</script></p>
					<p><script>document.write(which_lang[rb_change]);</script></p>
                    
                              <p align="center"> 
							  <span id="newlink" style="display:none"></span>
                              <input name="button" id="button" type=button class=button_submit value="" onClick="back()" disabled>
                              <script>get_by_id("button").value = which_lang[_continue];</script>
                              </p>
                  </div>
              </div></td>
            </tr>
          </table>
            <p>&nbsp;</p></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
            <tr>
              <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
              <td width="10">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        </tbody></table>     </td>
    </tr>
  </tbody></table></form>
<div id="copyright"><script>show_words('_copyright');</script></div>
</div>
</BODY>
<script>
	var count = 15;
	onPageLoad();
		do_count_down();	
	
</script>
</html>
