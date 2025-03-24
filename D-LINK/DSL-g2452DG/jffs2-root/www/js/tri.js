function printBeginContent()
{
	document.write('<table width="100%" class="MainContent"><tr><td>');
}

function printEndContent()
{
	document.write('</td></tr></table>');
}
function printApply(Func)
{
	document.write('<table style="margin-top:30;"><tr><td><img src="../../skin/_blank.gif" width="15">');
	PrintTriButton("Save",LK_Save,Func);
	document.write('</td></tr></table>');
}
function PageBack(a)
{
	document.location = a;
}
function SetContentTitle(value ,Name)
{
	if(Name)
		document.write('<table id="'+Name+'" class="TitleStyle">');
	else	
		document.write('<table class="TitleStyle">');
	document.write('<tr><td>');
	document.write(value);
	document.write('</td></tr>');
	document.write('</table>');
}
function printTriText(Name,MaxLength,Size)
{
	document.write('<input type="text" name="'+Name+'" id="'+Name+'" size="'+Size+'" maxlength="'+MaxLength+'">');
}
function printTriPassword(Name,MaxLength,Size)
{
	document.write('<input type="Password" name="'+Name+'" id="'+Name+'" size="'+Size+'" maxlength="'+MaxLength+'">');
}
function PrintTriButton(Name,Value,Fun)
{
	document.write('<input type="button" onmouseover="ChangeButtonStyle(this,\'mouseover\');" onmouseout="ChangeButtonStyle(this,\'mouseout\');" class="Tributton" id="'+Name+'" name="'+Name+'" onClick="'+Fun+'" value="'+Value+'" >');
}
function PrintTriSubmitButton(Name,Value,Fun)
{
	document.write('<input type="submit" onmouseover="ChangeButtonStyle(this,\'mouseover\');" onmouseout="ChangeButtonStyle(this,\'mouseout\');" class="Tributton" id="'+Name+'" name="'+Name+'" onClick="'+Fun+'" value="'+Value+'" >');
}
function printTriCheckBox(Name,Func)
{
	document.write('<input type="checkbox" id="'+Name+'" name="'+Name+'" onClick="'+Func+'">');
}
function ChangeButtonStyle(obj, EventType, haspath)
{
	if(EventType == 'mouseover')
	{
		obj.className = "Tributton Hover";
	}
	else if(EventType == 'mouseout')
	{
		obj.className = "Tributton";
	}
}	
function uiPageRefresh()
{
	document.location.reload();
}
function SetButtonStatus(Name, StatusType)
{
	var obj = document.getElementById(Name);
	if(StatusType == 'disabled')
	{
		obj.disabled = true;
		obj.className = "Tributton Disable";
		obj.style.visibility = "visible";
		obj.style.cursor = "default";
	}
	else
	{
		obj.disabled = false;
		obj.style.visibility = "visible";
		obj.style.cursor = "pointer";
		obj.className = "Tributton";
	}
}

var checkId;
function createValidateBlock()
{
	var codeNum = jQuery("tr[id^='BUTTON_BLOCK']").length;
	for (var i = 1; i <= codeNum; i++ )
	{
		var ValidateBlock =	'<tr>'
							+ '<td width="150">Validate code:</td>'
							+ '<td>'
							+ '<input type="text" id="INPUT_CAPTCHA' + i + '"/>&nbsp;&nbsp;'
							+ '<input type="text" unselectable="on" onselectstart="return false;" onclick="createCode(this.id)" onfocus="this.blur()" readonly="readonly" id="checkCAPTCHA' + i + '" class="unchanged" style="width: 85px; height: 27px; cursor: default;" />'
							+ '</td>'
							+ '</tr>';

		var block_id = "#BUTTON_BLOCK";
		if(i > 1)
			block_id += i;
		jQuery(block_id).before(ValidateBlock);
	}
}

function createCode() 
{ 
	var codeNum = jQuery("tr[id^='BUTTON_BLOCK']").length;
	var id;
	var codeLength = 5; //the length of the captcha code
	var checkCode;
	var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
	if(arguments.length > 0)
	{
		id = arguments[0];
		checkCode = document.getElementById(id);
		checkId = id;
	}

	for(var num = 1; num <= codeNum; num++)
	{
		if(arguments.length == 0)
			checkCode = document.getElementById("checkCAPTCHA" + num);
		else
		{
			checkCode = document.getElementById(id);
			num = codeNum;
		}

		var code = "";
		for(var i=0; i < codeLength; i++) 
		{
			var charIndex = Math.floor(Math.random()*36); 
			code +=selectChar[charIndex];
		} 
		if(checkCode) 
		{ 
			checkCode.className="code"; 
			checkCode.value = code; 
		}
	}
}

function validateCode()
{
	var inputCode;
	var code;
	return true;
	if(arguments.length == 0)
	{
		inputCode = document.getElementById("INPUT_CAPTCHA1").value;
		code = document.getElementById("checkCAPTCHA1").value;
		checkId = "checkCAPTCHA1"
	}
	else if(arguments.length == 1)
	{
		inputCode = document.getElementById("INPUT_CAPTCHA" + arguments[0]).value;
		code = document.getElementById("checkCAPTCHA" + arguments[0]).value;
		checkId = "checkCAPTCHA" + arguments[0];
	}
	if(inputCode.length <=0)
	{
		top.AlertMsg("Please Input the Validate code!");
		return false;
	}
	else if(inputCode.toLowerCase() != code.toLowerCase())
	{
		top.AlertMsg("Validate code error!");
		return false;
	}
	return true;
}
function SetTitle(title_str){
	document.title = title_str;
}
function SetCopyright(str){	
	document.getElementById('ID_Copyright').innerHTML = 'Copyright © ' + str + ' Technology Co.,LTD. 2017. All Rights Reserved.';
}
