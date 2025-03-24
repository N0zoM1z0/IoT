
function  Element_init(){
	var ElementArray = ["DIV_DisplayWanInfo","WANmode","DIV_DisplayVlanInfo",
						"Table_Bridge","DIV_WirelessInfo","DIV_DisplayVoipInfo",
						"DIV_DisplayVoIPOnLan3", "DIV_DisplayVoIPOnLan4","WebPassword"];
 	for (i=0;i<ElementArray.length;i++){
		setDisplay(ElementArray[i],1);
	}
	/*setDisplay("StaticIP",0);//¿ªÆôdulanÑ¡Ïî*/
	if (getValue("INPUT_Static_IP") == 1){
		setDisplay("DIV_StaticIP",1);
	}
	else{
		setDisplay("DIV_StaticIP",0);
	}
	setValue("INPUT_VlanID_Enable",0);
}

function TM_Unifi_init(){
	setDisplay("Table_Bridge",0);
	setDisplay("VlanID_Enable",0);
	setDisplay("DIV_DisplayVlanInfo",0);
	setValue("INPUT_IPTVOnLan4",1);
}

function Maxis_Fibre_init(){
	setDisplay("Table_Bridge",0);
	setDisplay("VlanID_Enable",0);
	setDisplay("DIV_DisplayVlanInfo",0);
	setDisplay("DIV_DisplayVoIPOnLan3",0);
	setDisplay("DIV_DisplayVoIPOnLan4",0);
}

function Time_Fibre_init(){
	//setDisplay("WANmode",0);
	setDisplay("Table_Bridge",0);
	setDisplay("VlanID_Enable",0);
	setDisplay("ID_OPTION_PTM",0);
	setDisplay("DIV_DisplayVlanInfo",0);
	setDisplay("DIV_DisplayVoIPOnLan3",0);
	setDisplay("DIV_DisplayVoIPOnLan4",0);
}

function Other_Fibre_VDSL_init(){
	setDisplay("Table_Bridge",0);
	setValue("INPUT_VlanID_Enable",0);
	setDisplay("DIV_DisplayVlanInfo",0);
	setDisplay("VlanID_Enable",1);
	setDisplay("DIV_DisplayVoIPOnLan3",0);
	setDisplay("DIV_DisplayVoIPOnLan4",0);

}

function ADSL_Streamyx_init(){
	setDisplay("WANmode",0);
	setDisplay("Table_Bridge",0);
	setDisplay("VlanID_Enable",0);
	setDisplay("DIV_DisplayVlanInfo",0);
	setDisplay("DIV_DisplayVoIPOnLan3",0);
	setDisplay("DIV_DisplayVoIPOnLan4",0);
	setDisplay("DIV_DisplayVoipInfo",0);
}

function VDSL_Bridge_init(){
	setDisplay("VlanID_Enable",0);
	setDisplay("DIV_DisplayWanInfo",0);
	setDisplay("DIV_DisplayVoIPOnLan3",0);
	setDisplay("DIV_DisplayVoIPOnLan4",0);
	setDisplay("DIV_WirelessInfo",0);
}

function VLANEnable(){
    var VLANEnable = getValue('INPUT_AddVlann');
    setDisplay('DIV_DisplayEnableVLANnINfo', VLANEnable);
}


function page_1_Set(){
	var setStr="?"+getValue("providerMode");
	var ajax=Ajax.getInstance("/cgi-bin/QSPage1.cgi","providerMode="+setStr,0,function(){});
	ajax.get();
}

function page_2_Set(){
	var S_WANmode=getValue("WAN_mode");
	var S_UserName=getValue("INPUT_UserName");
	var S_Password=getValue("INPUT_Password");
	var S_IPv6Enable=getValue("INPUT_IPv6");
	var S_StaticIPEnable=getValue("INPUT_Static_IP");
	var S_UnnumberLanIP=getValue("INPUT_UnnumberLanIP");
	var S_UnnumberPPPIP=getValue("INPUT_UnnumberPPPIP"); 
	var S_Subnet=getValue("INPUT_Subnet");
	var S_StartIP=getValue("INPUT_StartIP");
	var S_StopIP=getValue("INPUT_StopIP");
	var S_PrimaryDNS=getValue("INPUT_PrimaryDNS");
	var S_SecondaryDNS=getValue("INPUT_SecondaryDNS");
	var S_VoIPOnLan3=getValue("INPUT_VoIPOnLan3");
	var S_IPTVOnLan4=getValue("INPUT_IPTVOnLan4");
	var S_VlanID=getValue("INPUT_VlanID");
	//for VDSL_Bridge step 2
	var VLANID=new Array();
	var VLANPriority=new Array();
	var VLan1Tag=new Array();
	var VLan2Tag=new Array();
	var VLan3Tag=new Array();
	var VDSLInfo="";
	for(var i=5;i<=8;i++){
		if("" == getValue("INPUT_VLAN"+i).split('/')[0]){
			VDSLInfo+="?NULL,,";
		}else{
			VDSLInfo+="?"+getValue("INPUT_VLAN"+i).split('/')[0]
			+","+getValue("INPUT_VLAN"+i).split('/')[1]
			+",";
		}
		VDSLInfo+=getValue("INPUT_LAN2VLAN"+i)
		+","+getValue("INPUT_LAN3VLAN"+i)
		+","+getValue("INPUT_LAN4VLAN"+i);
	}
	
	var setStr="?"+S_WANmode
		+"?"+S_UserName
		+"?"+S_Password
		+"?"+S_IPv6Enable
		+"?"+S_StaticIPEnable
		+"?"+S_UnnumberLanIP
		+"?"+S_UnnumberPPPIP
		+"?"+S_Subnet
		+"?"+S_StartIP
		+"?"+S_StopIP
		+"?"+S_PrimaryDNS
		+"?"+S_SecondaryDNS
		+"?"+S_VoIPOnLan3
	  +"?"+S_IPTVOnLan4
	  +VDSLInfo
	  +"?"+S_VlanID;

	var ajax=Ajax.getInstance("/cgi-bin/QSPage2.cgi",setStr,0,function(){
	if(!validateCode())	
	    return false;
	top.ConfirmMsg(getStr('LK_RebootText'),"reboot");
		});
	ajax.get();
}
function ConfirmMsgResult(type,func)
{
	if(func=='reboot')
{
		if(type=="yes")
		{
	document.location.href="/page/management/mngt_restart.shtml";
		}
		else
		{
			return;
		}
	}
}
function page_3_Set(){
	var S_INPUT_Wireless24g=getValue("INPUT_Wireless24g");
	var S_INPUT_Wireless24gSSID=getValue("INPUT_Wireless24gSSID");
	var S_INPUT_Wireless24gPassphrase=getValue("INPUT_Wireless24gPassphrase");
	var S_Wireless5g=getValue("Wireless5g");
	var S_INPUT_Wireless5gSSID=getValue("INPUT_Wireless5gSSID");
	var S_INPUT_Wireless5gPassphrase=getValue("INPUT_Wireless5gPassphrase");
	var setStr="?"+S_INPUT_Wireless24g
		+"?"+S_INPUT_Wireless24gSSID
		+"?"+change_to_hex(S_INPUT_Wireless24gPassphrase)
		+"?"+S_Wireless5g
		+"?"+S_INPUT_Wireless5gSSID
		+"?"+change_to_hex(S_INPUT_Wireless5gPassphrase);

	var ajax=Ajax.getInstance("/cgi-bin/QSPage3.cgi",setStr,0,function(){});
	ajax.get();
}
function page_4_Set(){
	var S_INPUT_VoIP1=getValue("INPUT_VoIP1");
	var S_INPUT_VoIP1UserName=getValue("INPUT_VoIP1UserName");
	var S_INPUT_VoIP1PassWord=getValue("INPUT_VoIP1PassWord");
	var S_INPUT_VoIP2=getValue("INPUT_VoIP2");
	var S_INPUT_VoIP2UserName=getValue("INPUT_VoIP2UserName");
	var S_INPUT_VoIP2PassWord=getValue("INPUT_VoIP2PassWord");
	var setStr="?"+('1' == S_INPUT_VoIP1?"Enabled":"Disabled")
	+"?"+S_INPUT_VoIP1UserName
	+"?"+S_INPUT_VoIP1PassWord
	+"?"+('1' == S_INPUT_VoIP2?"Enabled":"Disabled")
	+"?"+S_INPUT_VoIP2UserName
	+"?"+S_INPUT_VoIP2PassWord;

	var ajax=Ajax.getInstance("/cgi-bin/QSPage4.cgi",setStr,0,function(){});
	ajax.get();
}

function setWAN(abc){
	page_2_Set();
}
//submit function
function uiSubmit(){
	//var df=document.Device_Quick;
	var newPassword=getValue("INPUT_WebPassword");
	//var setStr="?"+userlevel+"?"+newPassword+"?"+SHA256(newPassword);
	var SeleteWebPassword = getValue("INPUT_SeletedWebPassword");
	if (SeleteWebPassword == 1)
	{
		if (!!checkWebPassword())
		{
			var setStr="?"+userlevel+"?"+newPassword+"?"+SHA256(newPassword);
		}
		else
		{
			return false;
		}

	}
	else
	{
		var setStr="?"+ 3 +"?"+""+"?"+"";
	}
	/*else
	{
		alert("1");
	}*/
	for(var i=0; i< WANPath.length;i++){
		if(WANPath[i].path.indexOf("InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.") != -1){
				setStr+="?"+WANPath[i].path;
				continue;
		}
		WANPath[i].path="InternetGatewayDevice.WANDevice."+WANPath[i].path.split(".")[2]+".WANConnectionDevice."+WANPath[i].path.split(".")[4]+".";
		setStr+="?"+WANPath[i].path;
	}
	for(var i=0;i<Layer2BridgArray.length;i++){
		setStr+="?"+Layer2BridgArray[i];
	}
	var ajax=Ajax.getInstance("/cgi-bin/QSPage5.cgi",setStr,0,setWAN);
	ajax.get();
	//df.submit();
}

function checkUserName() {
	var UserName = $("INPUT_UserName").value;
	if (UserName == "") {
		top.AlertMsg(getStr("LK_NameNULL"), "INPUT_UserName");
		return false;
	}
	return true;
}

function checkPassword() {
    var Password = $("INPUT_Password").value;
	if (Password == "")
	{
		top.AlertMsg(getStr("LK_PassNULL"),"INPUT_Password");
		return false;
	}
	return true;
}

function checkVlanID()
{
    var targetVlan = $('INPUT_VlanID').value;
	if(targetVlan == "")
	{
		/*
		top.AlertMsg(getStr('LK_InputVlanID'),"INPUT_VlanID");
		return false;
		*/
		return true;
	}
	else
		if(isAllNum(targetVlan)==0)
	{
		top.AlertMsg(getStr('LK_InputNum'),"INPUT_VlanID");
		return false;
	}
	else
	{
		if(targetVlan < 1 || targetVlan > 4094)
		{
			top.AlertMsg(getStr("LK_vlaniderror"),"INPUT_VlanID");
			return false;
		}
	}
	return true;
}


function checkStaticIP(){
	var IPv6 = getValue("INPUT_IPv6");
	var StaticIP = getValue("INPUT_Static_IP");
	var IDArray = ["INPUT_UnnumberLanIP","INPUT_UnnumberPPPIP","INPUT_Subnet","INPUT_StartIP",
		           "INPUT_StopIP","INPUT_PrimaryDNS","INPUT_SecondaryDNS"];
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	var matchStr = "((([0-9a-f]{1,4}:){7}([0-9a-f]{1,4}|:))|(([0-9a-f]{1,4}:){6}(:[0-9a-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9a-f]{1,4}:){5}(((:[0-9a-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9a-f]{1,4}:){4}(((:[0-9a-f]{1,4}){1,3})|((:[0-9a-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){3}(((:[0-9a-f]{1,4}){1,4})|((:[0-9a-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){2}(((:[0-9a-f]{1,4}){1,5})|((:[0-9a-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){1}(((:[0-9a-f]{1,4}){1,6})|((:[0-9a-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9a-f]{1,4}){1,7})|((:[0-9a-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";


	if (StaticIP == 1)
	{
		for (var i = 0; i < 7; i++)
		{
			if ($(IDArray[i]).value == "")
			{
				top.AlertMsg(getStr("LK_ipnoemp"), IDArray[i]);
				return false;
			}
			
			if (getValue(IDArray[i]).match(exp) == undefined )
			{
					top.AlertMsg(getStr("LK_ipfmterr"));
					return false;
			}
			
			/*if (IPv6 == 0)
			{
				if (getValue(IDArray[i]).match(exp) == undefined )
				{
					top.AlertMsg(getStr("LK_ipfmterr"));
					return false;
				}
			}
			
			{
				if (!getValue(IDArray[i]).match(matchStr))
				{
					top.AlertMsg(getStr("LK_js_ip6fmterr"));
					return false;
				}

			}*/
		}
	}
    return true;
}

function checkIpv6Prefix(str) {
    var len = parseInt(str.value);
    if (isNaN(len) || len < 0 || len > 128) {
       top.Alert(getStr("LK_ip6prefix"),str.id);
       return false;
    }
    return true;
}



function checkWireless24gInfo() {
	var Wireless24g = getValue("INPUT_Wireless24g");
    var SSID = $("INPUT_Wireless24gSSID").value;
	var Passphrase = $("INPUT_Wireless24gPassphrase").value;
	if (SSID == "" && Wireless24g == 1)
	{
		top.AlertMsg(getStr("LK_net_ssidempty"),"INPUT_Wireless24gSSID");
		return false;
	}
	else if (Passphrase == "" && Wireless24g == 1)
	{
		top.AlertMsg(getStr("LK_PassNULL"),"INPUT_Wireless24gPassphrase");
		return false;
	}
	return true;
}

function checkWireless5gInfo() {
	var Wireless5g = getValue("Wireless5g");
    var SSID = $("INPUT_Wireless5gSSID").value;
	var Passphrase = $("INPUT_Wireless5gPassphrase").value;
	if (SSID == "" && Wireless5g == 1)
	{
		top.AlertMsg(getStr("LK_net_ssidempty"),"INPUT_Wireless5gSSID");
		return false;
	}
	else if (Passphrase == "" && Wireless5g == 1) {
		top.AlertMsg(getStr("LK_PassNULL"), "INPUT_Wireless5gPassphrase");
		return false;
	}
	return true;
}


function checkDisplayVoIP1Info() {
	var VoIP1 = getValue("INPUT_VoIP1");
    var UserName = $("INPUT_VoIP1UserName").value;
	var PassWord = $("INPUT_VoIP1PassWord").value;
	if (UserName == "" && VoIP1 == "1")
	{
		top.AlertMsg(getStr("LK_userNameEmpty"),"INPUT_VoIP1UserName");
		return false;
	}
	else if (PassWord == "" && VoIP1 == "1")
	{
		top.AlertMsg(getStr("LK_PassNULL"),"INPUT_VoIP1PassWord");
		return false;
	}
	return true;
}

function checkDisplayVoIP2Info() {
	var VoIP2 = getValue("INPUT_VoIP2");
    var UserName = $("INPUT_VoIP2UserName").value;
	var PassWord = $("INPUT_VoIP2PassWord").value;
	if (UserName == "" && VoIP2 == "1")
	{
		top.AlertMsg(getStr("LK_userNameEmpty"),"INPUT_VoIP2UserName");
		return false;
	}
	else if (PassWord == "" && VoIP2 == "1") {
		top.AlertMsg(getStr("LK_PassNULL"), "INPUT_VoIP2PassWord");
		return false;
	}
	return true;
}

function checkWebPassword() {
	var WebPassword = $("INPUT_WebPassword").value;
	if (WebPassword == "") {
		top.AlertMsg(getStr("LK_PassNULL"), "INPUT_WebPassword");
		return false;
	}
	return true;
}

function StaticIP(){
	var StaticIP = getValue('INPUT_Static_IP');
	setDisplay('DIV_StaticIP', StaticIP);
}

function setModeDefaultValue(){
	var modeType = getValue("providerMode");
	var VOIP1 = getValue("INPUT_VoIP1");
	var DNS1 = "1.9.1.9";
	var DNS2 = "202.188.0.133";
	setValue("INPUT_PrimaryDNS",DNS1);
	setValue("INPUT_SecondaryDNS",DNS2);
	setValue("WAN_mode","PTM");

	setValue("INPUT_Password","");
	setValue("INPUT_Wireless24gPassphrase","");
	setValue("INPUT_Wireless5gPassphrase","");
	setValue("INPUT_VoIP1PassWord","");
	setValue("INPUT_VoIP2PassWord","");

	setValue("INPUT_VoIP1",0);

	if (modeType == "TM_Unifi")
	{
		setValue("INPUT_UserName","");
		if (VOIP1 != 1)
		{
			setValue("INPUT_VoIP1",1);
		}
	}
	else if (modeType == "ADSL_Streamyx")
	{
		setValue("INPUT_UserName","@streamyx");
	}
	else if (modeType == "Maxis_Fibre")
	{
		setValue("INPUT_UserName","username@maxishome.com");
	}
	else if (modeType == "Other_Fibre_VDSL")
	{
		setValue("INPUT_UserName","pppoe@ccs");
		setValue("INPUT_VlanID",500);
	}
	else if (modeType == "Time_Fibre")
	{
		setValue("WAN_mode","ETH");
		setValue("INPUT_UserName","usernamE@timebb");
	}
	/*else if (modeType == "VDSL_Bridge")
	{

	}*/
	return true;
}

function setWanDefaultValue(){
	var modeType = getValue("providerMode");
	var WanMode = $("WAN_mode").value;
		if (modeType == "TM_Unifi")
		{	
				setValue("INPUT_UserName","");
		}
		else if (modeType == "Maxis_Fibre")
		{
			if (WanMode == "PTM")
			{
				setValue("INPUT_UserName","username@maxishome.com");
			}
			else if (WanMode == "ETH")
			{
				setValue("INPUT_UserName","username@maxishome.net");
			}
		}
		else if (modeType == "Other_Fibre_VDSL")
		{
			if (WanMode == "PTM")
			{
				setValue("INPUT_UserName","pppoe@ccs");
			}
			else if (WanMode == "ETH")
			{
				setValue("INPUT_UserName","");
			}
		}
		else if (modeType == "Time_Fibre")
		{
				setValue("INPUT_UserName","username@timebb");
		}
	return true;
}

function setElementDefaultValue(){
	var modeType = getValue("providerMode");
	var WanMode = $("WAN_mode").value;
	var VOIP1 = "@ims.tm.com.my";
	var VOIP2 = "@homesip.maxis.com.my";
	if (modeType == "TM_Unifi")
	{
			setValue("INPUT_VoIP1UserName", VOIP1);
			setValue("INPUT_VoIP2UserName", VOIP1);
	}
	else if (modeType == "Maxis_Fibre")
	{
		if (WanMode == "PTM" || WanMode == "ETH")
		{
			setValue("INPUT_VoIP1UserName", "");
			setValue("INPUT_VoIP2UserName", "");
		}
	}
	else if (modeType == "Other_Fibre_VDSL")
	{
		if (WanMode == "PTM")
		{
			setValue("INPUT_VoIP1UserName", VOIP1);
			setValue("INPUT_VoIP2UserName", VOIP1);
		}
		else if (WanMode == "ETH")
		{
			setValue("INPUT_VoIP1UserName", VOIP2);
			setValue("INPUT_VoIP2UserName", VOIP2);
		}
	}
	else if (modeType == "Time_Fibre")
	{
		if (WanMode == "PTM")
		{
			setValue("INPUT_VoIP1UserName", VOIP1);
			setValue("INPUT_VoIP2UserName", VOIP1);
		}
		else if (WanMode == "ETH")
		{
			setValue("INPUT_VoIP1UserName", VOIP2);
			setValue("INPUT_VoIP2UserName", VOIP2);
		}
	}
	else if (modeType == "VDSL_Bridge")
	{
			setValue("INPUT_VoIP1UserName", VOIP1);
			setValue("INPUT_VoIP2UserName", VOIP1);
	}
/*	else if (modeType == "ADSL_Streamyx")
	{

	}*/
	return true;
}

function CheckEditValue()
{
	for (var i = 5 ; i < 9 ; i++)
	{
		var VLANIndex = 0;
		var index = 0;
		var tempIndex = 0;
		tempIndex = "INPUT_VLAN" + i;
		VLANIndex = $(tempIndex).value;
		index = VLANIndex.indexOf('/');
		if (VLANIndex != "" && index > 0)
		{
			var sub = VLANIndex.substring(0,index);
			if (sub < 1 || sub > 4094 || sub == "")
			{
				top.AlertMsg(getStr("LK_vlaniderror"),tempIndex);
				return false;
			}
			var sub1 = VLANIndex.substring(index+1);
			if (sub1 < 0 || sub1 > 7 || sub1 == "")
			{
				top.AlertMsg(getStr("LK_Priorityerror"), tempIndex);
				return false;
			}
		}
		else if(VLANIndex != "" && index <= 0 ){
			top.AlertMsg(getStr("LK_Editerror"), tempIndex);
			return false;
		}
		else if(VLANIndex=="")
				return true;
	}	
	return true;
}

