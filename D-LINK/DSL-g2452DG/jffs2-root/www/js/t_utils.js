/*************************************************************
 * create an element and set it's value.
 * this function was designed to be called by submit function.
**************************************************************/
function AddElements(data_form, ElementsName, Value)
{
    var new_element = document.createElement('input');

    new_element.type = "hidden";
    new_element.name = ElementsName;
    new_element.value = Value;
    data_form.appendChild(new_element);
}

function RemoveAllChild(id)
{
    var ob = document.getElementById(id);
    var elements = new Array();   
    for(i=0; i < ob.length; i++)
        elements[elements.length] = ob[i];
    for(i=0; i < elements.length; i++)
        ob.removeChild(elements[i]);
}

/*************************************************************
 * encapsulation of getElementById.
 *
**************************************************************/
function getElementById(Id)
{
    if (document.getElementById)
    {
        return document.getElementById(Id);
    }
    else if (document.all)
    {
        // old IE
        return document.all(Id);
    }
    else if (document.layers)
    {
        // Netscape 4
        return document.layers[Id];
    }
    return null;
}

/*************************************************************
 * encapsulation getElementByName.
 *
**************************************************************/
function getElementByName(Name)
{
    if (document.getElementsByName)
    {
        var element = document.getElementsByName(Name);

        if (element.length == 0)
        {
            return null;
        }
        else if (element.length == 1)
        {
            return element[0];
        }
        return element;
    }
    return null;
}

/*************************************************************
 * get element by Id or Name.
 *
**************************************************************/
function getElement(IN)
{
     var element = getElementByName(IN);
     if (element == null)
     {
         return getElementById(IN);
     }
     return element;
}

/*************************************************************
 * getElement for short, and expand it's functionality.
 *
**************************************************************/
function $()
{
    var elements = new Array();
    
    for (var i = 0; i < arguments.length; i++)
    {
        var element = arguments[i];
        if (typeof element == "string")
        {
            element = getElement(element);
        }
        elements.push(element);
    }
    
    if (elements.length == 1 && arguments.length > 0)
    {
        return elements[0];
    }
    else
    {
        return elements;
    }
}

function getElementType(id)
{
	var node = getElement(id);
	return getNodeType(node);
}

function getNodeType(node)
{
    var type = "";

    var tag = node.tagName || node[0].tagName;
    if (tag == "INPUT")
    {
	NodeType = node.type || node[0].type;
        type = NodeType.toLowerCase();
    }
    else /* SELECT */
    {
        type = tag.toLowerCase();
    }
    return type;
}

/*************************************************************
 * set element INPUT/SELECT's value
 *
**************************************************************/
function setSelect(Id, Value)
{
    var item;
    if (null == (item = getElement(Id)))
    {
        return false;
    }

    for (var i = 0; i < item.options.length; i++)
    {
        if (item.options[i].value == Value)
        {
            item.selectedIndex = i;
            return true;
        }
    }
    return false;
}

function setText (Id, Value)
{
    var item;
    if (null == (item = getElement(Id)))
    {
        return false;
    }
    item.value = Value;
    return true;
}


function setCheck(Id, Value)
{
    var item;
    if (null == (item = getElement(Id)))
    {
        return false;
    }
    if ( Value == '1' )
    {
       item.value = 1;
       item.checked = true;
    }
    else
    {
       item.vaule = 0;
       item.checked = false;
    }
    return true;
}

function setRadio(Id, Value)
{
    var item;
    if (null == (item = getElement(Id)))
    {
        return false;
    }
    for (i=0; i<item.length; i++)
    {
        if (item[i].value == Value)
        {
            item[i].checked = true;
            return true;
        }
    }
    return false;
}

function setTd(Id, Value)
{
    var item;
    if (null == (item = getElement(Id)))
    {
        return false;
    }
    item.innerHTML = Value;
    return false;
}

function setValue(Name,Value)
{
    var node = getElement(Name);

    if( node == null)
    {
        return 'undefined';
    }

    var type = getNodeType(node);
    switch(type)
    {
        case 'select':
            setSelect(Name, Value);
            break;
    
        case 'text':
            setText(Name, Value);
            break;
    
        case 'password':
            setText(Name, Value);
            break;
    
        case 'radio':
            setRadio(Name, Value);
            break;
    
        case 'checkbox':
            setCheck(Name, Value);
            break;
    
        case 'td':
            setTd(Name, Value);
            break;
    
        default:
            break;
    }
}

function getValue(Name)
{
    var node = getElement(Name);

    if( node == null)
    {
        return 'undefined';
    }
    
    var NodeType = getNodeType(node);
    switch(NodeType)
    {
        case 'radio':
            for (i = 0; i < node.length; i++)
            {
                if (node[i].checked == true)
                    return node[i].value;
            }
            break;
        case 'checkbox':
            return (node.checked == true) ? 1 : 0;
        default: /*text, password, select*/
            return node.value;
    }
    return 'undefined';
}
/*************************************************************
 * add options for a 'SELECT' element.
 *
**************************************************************/
function createOptions(name, optionArray, valueArray)
{
    var node = $(name);
    var values = valueArray;

    node.options.length = 0;
    if (valueArray == undefined)
        values = optionValue;
    for (var i = 0; i < optionArray.length; i++)
    {
        node.options[i] = new Option(optionArray[i]);
        node.options[i].value = valueArray[i];
    }
}

/*************************************************************
 * use 0/1 to indicate a checkbox element was checked or not.
 *
**************************************************************/
function boxChecked(x)
{
    if(x.checked)
        x.value=1;
    else
        x.value=0;
}

/*************************************************************
 * Disable/Enable the element.
 *
**************************************************************/
function disableCtrl(name, bool)
{
    getElement(name).disabled = bool;
}

/* Web page manipulation functions */
function setDisplay (IM, sh)
{
    var status;
    if (sh > 0)
    {
        status = "";
    }
    else
    {
        status = "none";
    }
    getElement(IM).style.display = status;
}

function getDisplay (IM)
{
    var status;
    status = getElement(IM).style.display;
	if(status == "none"){
		return "0";
	}
	else{
		return "1";
	}
}

function setVisible(IM, sh)
{
    var status;
    if (sh > 0)
    {
        status = "visible";
    }
    else
    {
        status = "hidden"
    }
    getElement(IM).style.visibility = status;
}

function getQueryVar(name)
{
	var search = decodeURI(document.location.search);
	if (search.length <= 1)
		return "";

	search = search.substring(1);

	var kvstrs = search.split("&");
	for (var i in kvstrs) {
		var s = kvstrs[i];
		var kv = s.split("=");

		if (kv.length < 2)
			return "";

		if (kv[0] == name) {
			return kv[1];
		}
	}
	return "";
}

function getQueryInt(name)
{
	return parseInt(getQueryVar(name));
}

function IPMaskLengthToStr(num)
{
	var m = 0;
	for (var i = 32; i >= 0, num > 0; i--, num--) {
		m |= (1 << (i - 1));
	}

	var mask = "";
	for (var i = 0; i < 4; i++) {
		var v = (m >> (8 * i) & 255);
		if (i != 0) {
			mask = "." + mask;
		}
		mask = v + mask;
	}
	return mask;
}

function IPMaskStrToLength(mask)
{
	var digits = mask.split('.').reverse();

	var m = 0;
	for (var i = 0; i < 4; i++) {
		m += (parseInt(digits[i]) << (8 * i));
	}

	var i = 32;
	for (i = 32; i > 0; i--) {
		if (!(m & (1 << (i-1)))) {
			break;
		}
	}
	return (32 - i);
}

function getInstNoAtTail(path)
{
	var ary = path.match(/\d+/);
	if (ary.length < 1) {
		return null;
	}
	return ary[ary.length - 1];
}

function uiPageRefresh()
{
	document.location.reload();
}

function isUndefined(ele)
{
	if (typeof(ele) == "undefined")
		return true;
	return false;
}

function isDefined(ele)
{
	return !isUndefined(ele);
}

function isIPv4Addr(addr) {
	return (addr != null && addr.indexOf(".") != -1);
}

function isIPv6Addr(addr) {
	return (addr != null && addr.indexOf(":") != -1);
}

function change_ascii_to_str(ascii)
{
    var str = "";
    var temp = "";

    //alert("ascii length is :" + ascii.length);
    for (i = 0; i < ascii.length; i = i + 2)
    {
        temp = ascii.substr(i, 2);
        //alert("temp is " + temp);
        str += "" + String.fromCharCode(parseInt(parseInt(temp, 16).toString(10)));
        //alert("str is " + str);
    }
    return str;
}

function change_to_hex(str)
{
    var dec_num = 0;
    var hex_num = 0;
    var sum = "";

    for (i = 0; i < str.length; i++)
    {
        dec_num = str.charCodeAt(i);
        hex_num = dec_num.toString(16);
        sum = sum + "" + hex_num;
    }

    return sum;
}

function isBridgedConn(conntype)
{
    if (conntype == 'PPPoE_Bridged' || conntype == 'IP_Bridged')
        return true;
    else
        return false;
}

function AlertFocus(value)
{
	$(value).focus();
	$(value).select();
}

function isINTERNETService(serviceList)
{
   if (serviceList.indexOf("INTERNET") > -1)
       return true;
   return false;
}

function isTR069Service(serviceList)
{
   if (serviceList.indexOf("TR069") > -1)
       return true;
   return false;
}

function isVOIPService(serviceList)
{
   if (serviceList.indexOf("VOIP") > -1)
       return true;
   return false;
}

function setSelectedfile(value)
{
	var filename=value;
	jQuery('#FILE_NAME').html(filename.substring(filename.lastIndexOf('\\')+1));
}

/*-----------------------------------------------
* GetCurrentFileName
* 描述： html文件中获取自己的名称
* 入参： 无
* 返回： 当前html文件的名称, 比如basic_lanipv4config.shtml
------------------------------------------------*/
function GetCurrentFileName()
{
    var pathArray = location.href.split("/");
    var curFileName = pathArray.slice(pathArray.length-1, pathArray.length).toString(String); //获取当前文件名
    return curFileName;
}


/*-----------------------------------------------
* IsExistedFunction
* 描述： 判断函数是否存在
* 入参： 函数名称
* 返回： 存在-返回true   不存在-返回false
------------------------------------------------*/
function IsExistedFunction(funcName) 
{
    try 
    {
        if (typeof(eval(funcName)) == "function") 
        {
            return true;
        }
    } catch(e) {}
    return false;
}

/*----------------------------------------------
 * encode64
 * 描述： base64加密
 * 入参：密码明文
 * 返回：加密值
 *------------------------------------------- */
function encode_passwd(input){var keyStr="ABCDEFGHIJKLMNOP"+"QRSTUVWXYZabcdef"+"ghijklmnopqrstuv"+"wxyz0123456789+/"+"=";input =escape(input);var output="";var chr1,chr2,chr3="";var enc1,enc2,enc3,enc4="";var i=0;do{chr1=input.charCodeAt(i++);chr2=input.charCodeAt(i++);chr3=input.charCodeAt(i++);enc1=chr1>>2;enc2=((chr1&3)<<4)|(chr2>>4);enc3=((chr2&15)<<2)|(chr3>>6);enc4=chr3&63;if(isNaN(chr2)){enc3=enc4=64;}else if(isNaN(chr3)){enc4=64;}output=output+keyStr.charAt(enc1)+keyStr.charAt(enc2)+keyStr.charAt(enc3)+keyStr.charAt(enc4);chr1=chr2=chr3="";enc1=enc2=enc3=enc4="";}while(i<input.length);return output;}
