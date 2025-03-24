function isCheckIPMaskMatch(srcip,matchip,matchmask)//check ipmask range
{
	var mask = matchmask.split('.');
	var firName = srcip.split('.');
	var secName = matchip.split('.');
	var range = 0;
	var tureflag = 0;
	for(var a=0;a<4;a++)
	{
		range = 255 - mask[a];
		if( firName[a] <= parseInt(secName[a]) + parseInt(range) && secName[a] < 255 && secName[a] >= 0 )
		{
			continue;
		}
		else
		{
			tureflag = 1;
			break;
		}	
	}
	
	if (tureflag == 0) 
		return true;
	else if(tureflag == 1)
		return false;
}

//check domain,such as www.baidu.com 
function checkDomain(domain){ 
	var regStr="^([a-zA-Z0-9-]+.){1,}(com|net|edu|miz|biz|cn|cc|th|hk|org|uk|de|jp|gov|us)$";
	var re=new RegExp(regStr); //创建正则表达式对象 
	//var re=/^([a-zA-Z0-9-]+.){1,}(com|net|edu|miz|biz|cn|cc)$/; 
	if(domain.value.length <= 0)
		return false;
	if(!re.exec(domain.value) && (domain.value.split(".")[0] != "www"))
{ //验证输入的字符串是否符合规则 
		return false; 
	}
	return true;
}
function isCheckIPV4(str,begin,end)
{
	if(!arguments[1])
	{
		begin = 0;
	}
	if(!arguments[2])
	{
		end = 255;
	}
	
	if(str.value.length <= 0)
	{
        top.AlertMsg(getStr("LK_ipnoemp"),str.id);
        return false;
    }
	var checkIP = str.value.split('.');
	
	if(checkIP.length !=4)
	{
		top.AlertMsg(getStr("LK_ipfmterr"),str.id);
		return false;
	}
	
	for(var a=0; a<4; a++)
	{				
		if(a==3)
		{
			if(checkIP[a] <= end && checkIP[a] >= begin && checkIP[a].length > 0)
			    continue;
			else
			{
				top.AlertMsg(getStr("LK_ipfmterr"),str.id);
				return false;
			}
		}
		
		if(checkIP[a] <= 255 && checkIP[a] >= 0 && checkIP[a].length > 0)
			continue;
		else
		{
			top.AlertMsg(getStr("LK_ipfmterr"),str.id);
			return false;
		}
	}	
	return true;
}

function CheckIPV4_noMsg(str,begin,end)
{
	if(!arguments[1])
	{
		begin = 0;
	}
	if(!arguments[2])
	{
		end = 255;
	}
	
	if(str.value.length <= 0)
	{
        return false;
    }
	var checkIP = str.value.split('.');
	
	if(checkIP.length !=4)
	{
		return false;
	}
	
	for(var a=0; a<4; a++)
	{				
		if(a==3)
		{
			if(checkIP[a].length > 0 && checkIP[a] <= end && checkIP[a] >= begin)
			    continue;
			else
			{
				return false;
			}
		}
		
		if(checkIP[a].length > 0 && checkIP[a] <= 255 && checkIP[a] >= 0)
			continue;
		else
		{
			return false;
		}
	}	
	return true;
}

function CheckSpecialWords(word)
{
	var iChars = "\"\\";
	
	for (var i = 0; i < word.value.length; i++)
	{
		if (iChars.indexOf(word.value.charAt(i)) != -1)
		{
			return false;
		}
	}
	return true;
}

function ErrFocus(obj) //Focus
{
    obj.focus();
    obj.select();
}
function atoi(str, num) {
    i = 1;
    if (num != 1) {
        while (i != num && str.length != 0) {
            if (str.charAt(0) == '.') {
                  i++;
            }
            str = str.substring(1);
        }
        if (i != num)
            return -1;
    }
    for (i=0; i<str.length; i++) {
        if (str.charAt(i) == '.') {
             str = str.substring(0, i);
             break;
        }
    }
    if (str.length == 0)
        return -1;
    return parseInt(str, 10);
}

function checkRange(str, num, min, max) {
    d = atoi(str, num);

    if (d <= max && d >= min)
        return true;
    return false;
}

function isAllNum(str) {
    for (var i=0; i<str.length; i++) {
        if ((str.charAt(i) >= '0' && str.charAt(i) <= '9'))
            continue;
        return 0;
    }
    return 1;
}

function ischeckMAC(str){
    var patrn = /[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}:[A-Fa-f0-9]{2}/;
    var address=str.value;
    if (address.length <= 0) {
        top.AlertMsg(getStr("LK_macnoempty"),str.id);
        return false;
    }else if (!patrn.exec(address)) {
        top.AlertMsg(getStr("LK_macfmterr"),str.id);
        return false;
    } 
    return true; 
}
function checkIpv6(str, flag) {
    var matchStr = "((([0-9a-f]{1,4}:){7}([0-9a-f]{1,4}|:))|(([0-9a-f]{1,4}:){6}(:[0-9a-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9a-f]{1,4}:){5}(((:[0-9a-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9a-f]{1,4}:){4}(((:[0-9a-f]{1,4}){1,3})|((:[0-9a-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){3}(((:[0-9a-f]{1,4}){1,4})|((:[0-9a-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){2}(((:[0-9a-f]{1,4}){1,5})|((:[0-9a-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9a-f]{1,4}:){1}(((:[0-9a-f]{1,4}){1,6})|((:[0-9a-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9a-f]{1,4}){1,7})|((:[0-9a-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";
    var ipv6 =str.value;
    var ret = ipv6.match(matchStr);
    if (ret) {
        return true;
    } else {
       if(!flag)
           alert(getStr("LK_js_ip6fmterr"));
       ErrFocus(str);
       return false;
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
function isMacValid(mac, full_range)
{
    mac += "";
    if (!mac.match(/^([0-9a-fA-F]{2}[:-]?){5}[0-9a-fA-F]{2}$/)) {
        return false;
    }
    mac = mac.replace (/[:-]/g, '');
    if (!full_range && (mac.match(/^0{12}$/) || mac.match(/^[fF]{12}$/))) {
        return false;
    }
    return true;
}
function isVlanValid(vlan)
{
	if (vlan >= 0 && vlan <= 4095)
		return true;
	return false;
}
function isIPv6AddrValid(s)
{
	var vip64=/^([\da-fA-F]{1,4}:){6}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^::([\da-fA-F]{1,4}:){0,4}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:):([\da-fA-F]{1,4}:){0,3}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){2}:([\da-fA-F]{1,4}:){0,2}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){3}:([\da-fA-F]{1,4}:){0,1}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){4}:((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){7}[\da-fA-F]{1,4}$|^:((:[\da-fA-F]{1,4}){1,6}|:)$|^[\da-fA-F]{1,4}:((:[\da-fA-F]{1,4}){1,5}|:)$|^([\da-fA-F]{1,4}:){2}((:[\da-fA-F]{1,4}){1,4}|:)$|^([\da-fA-F]{1,4}:){3}((:[\da-fA-F]{1,4}){1,3}|:)$|^([\da-fA-F]{1,4}:){4}((:[\da-fA-F]{1,4}){1,2}|:)$|^([\da-fA-F]{1,4}:){5}:([\da-fA-F]{1,4})?$|^([\da-fA-F]{1,4}:){6}:$/;
	//
	var patrn = vip64;// /^([\da-fA-F]{1,4}:){7}[\da-fA-F]{1,4}$/;
	//alert(patrn)
	if (!patrn.exec(s)) {
		top.AlertMsg(getStr("LK_ip6fmterr"));		
		return false;
	}
	return true;
}
function isIPv6Valid(str) {    
    var patrn=/^([\da-fA-F]{1,4}:){6}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^::([\da-fA-F]{1,4}:){0,4}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:):([\da-fA-F]{1,4}:){0,3}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){2}:([\da-fA-F]{1,4}:){0,2}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){3}:([\da-fA-F]{1,4}:){0,1}((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){4}:((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$|^([\da-fA-F]{1,4}:){7}[\da-fA-F]{1,4}$|^:((:[\da-fA-F]{1,4}){1,6}|:)$|^[\da-fA-F]{1,4}:((:[\da-fA-F]{1,4}){1,5}|:)$|^([\da-fA-F]{1,4}:){2}((:[\da-fA-F]{1,4}){1,4}|:)$|^([\da-fA-F]{1,4}:){3}((:[\da-fA-F]{1,4}){1,3}|:)$|^([\da-fA-F]{1,4}:){4}((:[\da-fA-F]{1,4}){1,2}|:)$|^([\da-fA-F]{1,4}:){5}:([\da-fA-F]{1,4})?$|^([\da-fA-F]{1,4}:){6}:$/;
    var address=str.value;
    if (address.length <= 0){
        top.AlertMsg(getStr("LK_ipnoemp"),str.id);
        return false;
    }else if (!patrn.exec(address)) {
		top.AlertMsg(getStr("LK_ip6fmterr"),str.id);
        return false;
    }
    return true;
}

function isIPAddrValid(address)
{
    var i = 0;

    if ( address == '0.0.0.0' ||
         address == '255.255.255.255' )
       return false;

    addrParts = address.split('.');
    if ( addrParts.length != 4 )
        return false;

    for (i = 0; i < 4; i++)
    {
        if (isNaN(addrParts[i]) || addrParts[i] == "")
            return false;
        if (addrParts[i].indexOf(" ") != -1)
            return false;
        num = parseInt(addrParts[i]);
        if(i ==0 )
        {
            if(num <0 || num > 223)
                return false;
        }
        else
        {
       	    if ( num < 0 || num > 255 )
                return false;
        }
    }
    return true;
}

function isIPMaskValid(mask)
{
    var subMask = mask;

    if ((!checkRange(subMask, 1, 0, 255)) ||(!checkRange(subMask, 2, 0, 255)) ||
                (!checkRange(subMask, 3, 0, 255)) || (!checkRange(subMask, 4, 0, 255)))
    {
        return false;
    }
    return true;
}

function CheckPrefix(Prefix,type){
	var IpAddress1 = Prefix.split(':');
	var IpAddress3 = Prefix;
	if ( 1 == type && '' == IpAddress3)
		return true;
	if ( true != isGlobalIpv6Address(IpAddress3) )
		return false;
	return true;
}
function isGlobalIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);
    
    if ((tempAddress == '')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0000')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0001')
        || (tempAddress.substring(0, 3) == 'fe8')
        || (tempAddress.substring(0, 3) == 'fe9')
        || (tempAddress.substring(0, 3) == 'fea')
        || (tempAddress.substring(0, 3) == 'feb')
        || (tempAddress.substring(0, 2) == 'ff'))
    {
        return false;
    }
    
    return true;
}
function getFullIpv6Address(address)
{
    var c = '';
    var i = 0, j = 0, k = 0, n = 0;
    var startAddress = new Array();
    var endAddress = new Array();
    var finalAddress = '';
    var startNum = 0;
    var endNum = 0;
    var lowerAddress;
    var totalNum = 0;

    lowerAddress = address.toLowerCase();
    var addrParts = lowerAddress.split('::');
    if (addrParts.length == 2)
    {
        if (addrParts[0] != '')
        {
            startAddress = ParseIpv6Array(addrParts[0]);
            if (startAddress.length == 0)
            {
                return '';
            }
        }
        if (addrParts[1] != '')
        {
            endAddress = ParseIpv6Array(addrParts[1]);
            if (endAddress.length == 0)
            {
               return '';
            }
        }

        if (startAddress.length +  endAddress.length >= 8)
        {
            return '';
        }
    }
    else if (addrParts.length == 1)
    {
        startAddress = ParseIpv6Array(addrParts[0]);
        if (startAddress.length != 8)
        {
            return '';
        }
    }
    else
    {
        return '';
    }

    for (i = 0; i < startAddress.length; i++)
    {
        finalAddress += startAddress[i];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8 - endAddress.length; i++)
    {
        finalAddress += '0000';
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8; i++)
    {
        finalAddress += endAddress[i - (8 - endAddress.length)];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    return finalAddress;
    
}
function ParseIpv6Array(str)
{
    var Num;
    var i,j;
    var finalAddrArray = new Array();
    var falseAddrArray = new Array();
    
    var addrArray = str.split(':');
    Num = addrArray.length;
    if (Num > 8)
    {
        return falseAddrArray;
    }

    for (i = 0; i < Num; i++)
    {
        if ((addrArray[i].length > 4) 
            || (addrArray[i].length < 1))
        {
            return falseAddrArray;
        }
        for (j = 0; j < addrArray[i].length; j++)
        {
            if ((addrArray[i].charAt(j) < '0')
                || (addrArray[i].charAt(j) > 'f')
                || ((addrArray[i].charAt(j) > '9') && 
                (addrArray[i].charAt(j) < 'a')))
            {
                return falseAddrArray;
            }
        }
        finalAddrArray[i] = '';
        for (j = 0; j < (4 - addrArray[i].length); j++)
        {
            finalAddrArray[i] += '0';
        }
        finalAddrArray[i] += addrArray[i];
    }

    return finalAddrArray;
}
function checkURLValid(str){
	var url =str.value;
	var urlValid = url.match(/^http:|https:\/\/.+\..+/i);
	if (urlValid == null){
		top.AlertMsg(getStr("LK_url"),str.id);
		return false;       
	}
	return true;
}
