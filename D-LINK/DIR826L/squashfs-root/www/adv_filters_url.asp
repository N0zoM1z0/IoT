<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
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

var param = {
	url: 	"get_set.ccp",
	arg: 	"ccp_act=get&num_inst=4"+
			"&oid_1=IGD_WANDevice_i_URLFilter_&inst_1=11100"+
			"&oid_2=IGD_WANDevice_i_URLFilter_URLAllowList_i_&inst_2=11100"+
			"&oid_3=IGD_WANDevice_i_URLFilter_URLDenyList_i_&inst_3=11100"+
			"&oid_4=IGD_&inst_4=10000"
};
get_config_obj(param);
var dev_mode = config_val("igd_DeviceMode_");

var allowUrlCnt	= (config_val("urlFilter_URLAllowNumberOfEntries_")? config_val("urlFilter_URLAllowNumberOfEntries_"): "0");
var denyUrlCnt	= (config_val("urlFilter_URLDenyNumberOfEntries_")? config_val("urlFilter_URLDenyNumberOfEntries_"): "0");

var array_allow_enable = config_str_multi("urlFilterAllowList_Enable_");
var array_deny_enable = config_str_multi("urlFilterDenyList_Enable_");

var array_allow_list = config_str_multi("urlFilterAllowList_ManagedURL_");
var array_deny_list = config_str_multi("urlFilterDenyList_ManagedURL_");

var array_allow_name = config_str_multi("urlFilterAllowList_Name_");
var array_deny_name = config_str_multi("urlFilterDenyList_Name_");

//var array_rul_list = config_str_multi("urlFilterList_ManagedURL_");

var submit_button_flag = 0;
var rule_max_num = 40;
function onPageLoad(){
	if(config_val("urlFilter_Action_"))
		get_by_id("url_domain_filter_type").selectedIndex = config_val("urlFilter_Action_");
	
	fill_list_field();

	var login_who= login_Info;
	if(login_who!= "w" || dev_mode == "1"){
		DisableEnableForm(form1,true);	
	}
}
	
function send_request(){
	if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange))) {
		return false;
	}
	// 驗證畫面中的text field是否有重複的資料
	for (var i = 0; i < rule_max_num; i++){
		var temp_url = get_by_id("url_" + i).value;
		temp_url = temp_url.toLowerCase();

		if (temp_url != ""){
			if(temp_url.indexOf("http://") != -1){
				temp_url = temp_url.substring("http://".length);
			}
			if(temp_url.lastIndexOf("/")  != -1){
				temp_url = temp_url.substring(0, temp_url.lastIndexOf("/"));
			}

			for (var j = i+1; j < rule_max_num; j++)
			{
				hid_temp_url = get_by_id("url_" + j).value;
				hid_temp_url = hid_temp_url.toLowerCase();
				if (hid_temp_url != ""){
					if(hid_temp_url.indexOf("http://") != -1){
						hid_temp_url = hid_temp_url.substring("http://".length);
					}
					if(hid_temp_url.lastIndexOf("/")  != -1){
						hid_temp_url = hid_temp_url.substring(0, hid_temp_url.lastIndexOf("/"));
					}
				}
				if (temp_url == hid_temp_url){
					//alert("此網頁位址 "+ temp_url +"已經存在.");	//awf_alert_5
					alert(addstr(get_words('awf_alert_5'), temp_url));
					return false;
				}
			}
		}
	}
		
// 驗證畫面中的資料狀態：新增(NEW)、修改(MTN)、刪除(DEL)、不需修改(QRY)；
	var count = 0;
		
	for (var i = 0; i < rule_max_num; i++){
		var tmp_url = get_by_id("url_" + i).value;
		var pos = tmp_url.indexOf("http://");  
		var pos1 = tmp_url.indexOf("https://");  
		var lpos = tmp_url.lastIndexOf("/"); 

		var strGet_url = "";
		if(pos != -1){     
   			if(lpos < 7){
				strGet_url = tmp_url.substring(pos+7);
				//alert("http://"+strGet_url);
			}else{	    
		    	strGet_url = tmp_url.substring(pos+7,lpos);  
		    }
    	}else{
    		if(pos1 != -1){ 
				//alert("?定的URL?效");
				alert(get_words(GW_URL_INVALID));
				return false;
    		}else{
		    	if(lpos != -1){
					strGet_url = tmp_url.substring(0,lpos);
					//alert(strGet_url);
				}else{	    
			    	strGet_url = tmp_url; 
			    }
			}
		}

		count++;			
	}

// 依據上面的hid_type_filter_xx變數，來判斷此欄位目前需要作何處理：NEW新增一筆新的URL、MTN修改現有的URL、DEL刪除現有的URL、QRY什麼都不做

	if(submit_button_flag == 0){
		submit_button_flag = 1;
		copy_data_to_cgi_struct();
	}
}
	
function copy_data_to_cgi_struct()
{
	var act = get_by_id("url_domain_filter_type").value;
	get_by_id("urlFilter_Action_").value = get_by_id("url_domain_filter_type").selectedIndex;
	var total_cnt = 0;
	var ruleContent = "";
	ruleContent += "&urlFilter_Action_1.1.1.0.0=" + get_by_id("url_domain_filter_type").selectedIndex;

	for(var i=0; i<rule_max_num; i++)
	{	
		//var strVal = get_by_id("url_domain_filter_"+kk).value;
		var strVal = get_by_id("url_"+i).value.toLowerCase();
		//var chkVal = get_checked_value(get_by_id("chk_"+i));
		var chkVal = "0";
		
		var nameVal = get_by_id("name_"+i).value.toLowerCase();
		
		if(strVal == "")
			continue;
		
		total_cnt ++;
		chkVal = "1";
		if(act == 'list_allow')
		{
			ruleContent += ("&urlFilterAllowList_ManagedURL_1.1.1."+(total_cnt)+".0=")+strVal;
			ruleContent += ("&urlFilterAllowList_Enable_1.1.1."+(total_cnt)+".0=")+chkVal;
			ruleContent += ("&urlFilterAllowList_Name_1.1.1."+(total_cnt)+".0=")+nameVal;
		}
		else
		{
			ruleContent += ("&urlFilterDenyList_ManagedURL_1.1.1."+(total_cnt)+".0=")+strVal;
			ruleContent += ("&urlFilterDenyList_Enable_1.1.1."+(total_cnt)+".0=")+chkVal;
			ruleContent += ("&urlFilterDenyList_Name_1.1.1."+(total_cnt)+".0=")+nameVal;
		}
	}
		
	var delCnt = 0;
	if(act == 'list_allow'){
		delCnt = ((allowUrlCnt > total_cnt)? (allowUrlCnt - total_cnt):0);
					
		if(delCnt > 0)
		{
			var delContent = "";
			delContent += "&num_inst="+delCnt;
			
			for(var i= allowUrlCnt; (i > total_cnt) && (delCnt>0); i--, delCnt--)
			{
				delContent += "&oid_"+delCnt+"=IGD_WANDevice_i_URLFilter_URLAllowList_i_&inst_"+delCnt+"=1.1.1."+i+".0";
			}

			var paramDel = {
				url: "get_set.ccp",
				arg: "ccp_act=del" + delContent
			};

			get_config_obj(paramDel);
		}
	}
	else{
		delCnt = ((denyUrlCnt > total_cnt)? (denyUrlCnt - total_cnt):0);
	
		if(delCnt > 0)
		{
			var delContent = "";
			delContent += "&num_inst="+delCnt;
			
			for(var i=denyUrlCnt; (i > total_cnt) && (delCnt>0); i--, delCnt--)
			{
				delContent += "&oid_"+delCnt+"=IGD_WANDevice_i_URLFilter_URLDenyList_i_&inst_"+delCnt+"=1.1.1."+i+".0";
			}

			var paramDel = {
				url: "get_set.ccp",
				arg: "ccp_act=del" + delContent
			};

			get_config_obj(paramDel);
		}
	}
		
	var paramSubmit = {
		url: "get_set.ccp",
		arg: "ccp_act=set&ccpSubEvent=CCP_SUB_URLFILTER&nextPage=adv_filters_url.asp" + ruleContent
	};

	get_config_obj(paramSubmit);
}
	
function check_date(){
	var is_change = false;
	//var check_domain_type = "<% CmoGetCfg("url_domain_filter_type","none"); %>";
	var check_domain_type = "";
	if (get_by_id("url_domain_filter_type").value != check_domain_type){
		is_change = true;
	}else if(!is_change){
		for(i=0;i<rule_max_num;i++){
			var kk = i;
			if(i<10){
				kk = "0"+i;
			}
			if(get_by_id("url_domain_filter_"+ kk).value != get_by_id("url_"+ i).value){
				is_change = true;
				break;
			}
			
		}
	}
	if(is_change){
		if (!confirm(get_words(up_jt_1)+"\n"+get_words(up_jt_2)+"\n"+get_words(up_jt_3))){
			return false;
		}
	}
	location.href="tools_schedules.asp";
}

function clear_list_URL(){
	for (var i = 0; i < rule_max_num; i++) {
		get_by_id("url_"+ i).value = "";
		get_by_id("name_"+ i).value = "";
		get_by_id("chk_"+ i).checked = false;
	}
}
	
function fill_list_field()
{
	clear_list_URL();
	if(get_by_id("url_domain_filter_type").value == 'list_allow')
	{
		//alert(allowUrlCnt);
		for(var i=0; i<allowUrlCnt; i++)
		{
			get_by_id("url_"+ i).value = array_allow_list[i];
			get_by_id("chk_"+ i).checked = parseInt(array_allow_enable[i]);
			get_by_id("name_"+ i).value = array_allow_name[i];
			//get_by_id("url_domain_filter_" + k).value = array_allow_list[i];
		}
	}
	else
	{
		//alert(denyUrlCnt);
		for(var i=0; i<denyUrlCnt; i++)
		{
			get_by_id("url_"+ i).value = array_deny_list[i];
			get_by_id("chk_"+ i).checked = parseInt(array_deny_enable[i]);
			get_by_id("name_"+ i).value = array_deny_name[i];
			//get_by_id("url_domain_filter_" + k).value = array_deny_list[i];
		}
	}
}
	
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
        </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                            <ul>
							<LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(_websfilter)</script></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                        </div>
             </td>
                </tr>
                </table></td>
                <form id="form1" name="form1" method="post" action="get_set.ccp">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_url.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  
          <div id=box_header> 
            <h1> 
              <script>show_words(_websfilter)</script>
            </h1>

            <p>
              <script>show_words(dlink_awf_intro_WF)</script>
            <p>
				<input name="apply" id="apply" type="button" class=button_submit value="" onClick="send_request()">
				<input name="cancel" id="cancel" type=button class=button_submit value="" onclick="page_cancel('form1', 'adv_filters_url.asp');">
				<script>get_by_id("apply").value = get_words(_savesettings);</script>
				<script>get_by_id("cancel").value = get_words(_dontsavesettings);</script>
				
            </div>
                  
          <div class=box> 
            <h2>40 &ndash; 
              <script>show_words(awf_title_WSFR)</script>
            </h2>
                    <table cellSpacing=1 cellPadding=2 width=500 border=0>
                        <tr>

                <td>
                  <script>show_words(dlink_wf_intro)</script>
                </td>
                        </tr>
                        <tr>
                          <td>
                          <select id="url_domain_filter_type" name="url_domain_filter_type">
                              <!--option value="disable">Turn Parental Control OFF</option-->
                              <option value="list_deny"><script>show_words(dlink_wf_op_0)</script></option>
                              <option value="list_allow"><script>show_words(dlink_wf_op_1)</script></option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <br>
                            <script>document.write('<input type="button" class=button_submit value="'+get_words(awf_clearlist)+'" onclick="clear_list_URL()">')</script> 
                          </td>
                        </tr>
                    </table>
                    <br>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=0>
                        <tr align=center>
                          <td width="100%" colspan="2"><b><script>show_words(aa_WebSite_Domain)</script></b></td>
                        </tr>
                        <tr align=center>
                          <td colspan="2"></td>
                        </tr>
                        <script>
						for(var i=0 ; i<rule_max_num ; i++){
							document.write("<tr align=center>");
							document.write("<td><span style=\"display:none\"><input type=checkbox id=chk_"+ i +" value=1></span><input id=\"url_" + i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>");
							document.write('<input type=hidden id=name_'+ i +' value=\"\">');
							document.write("<td><span style=\"display:none\"><input type=checkbox id=chk_"+ ++i +" value=1></span><input id=\"url_" + i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>");
							document.write('<input type=hidden id=name_'+ i +' value=\"\">');
							document.write("</tr>");
						}
					  </script>
                    </table>
                  </div>
              </div>
            </td>
        </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table width="125" border=0 cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>
          <td id=help_text><strong>
           <script>show_words(_hints)</script>&hellip;</strong>
         <p><script>show_words(dlink_hhwf_intro)</script></p>
         <p><script>show_words(hhwf_xref)</script></p>
         <p class="more"><a href="support_adv.asp#Web_Filter" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
	
	<form id="form2" action="get_set.ccp">
		<input type="hidden" name="ccp_act" value="set">
		<input type="hidden" name="ccpSubEvent" value="CCP_SUB_URLFILTER">
		<input type="hidden" name="nextPage" value="adv_filters_url.asp">	
		<input type="hidden" id="urlFilter_Action_" name="urlFilter_Action_1.1.1.0.0" value="">
		<script>
			for(var i=0; i<rule_max_num; i++)
			{
				document.write("<input type=\"hidden\" id=\"urlFilterList_ManagedURL_"+(i+1)+"\" name=\"urlFilterList_ManagedURL_1.1.1."+(i+1)+".0\" value=\"\">");
			}
		</script>
	</form>
	
<br>
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
	//set_virtual_server();
	set_form_default_values("form1");
</script>
</html>
