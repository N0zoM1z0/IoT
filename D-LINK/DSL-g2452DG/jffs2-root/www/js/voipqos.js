function getObj(id){return(document.getElementById(id));}
function jslSetValue(src,dst){var ss=document.getElementById(dst).value;document.getElementById(src).value=ss;}
function jslSetValue_ext(src,dst,flag,num){var ss=document.getElementById(dst).value;if(flag=='*'){ss=ss*num}else if(flag=='/'){ss=ss/num}document.getElementById(src).value=ss;}
function setValue(id,value){document.getElementById(id).value=value;}
function getValue(id){return(document.getElementById(id).value);}
function getDisabled(id){return(document.getElementById(id).disabled);}
function getDisplay(id){if(document.getElementById(id).style.display=="none")return false;else return true;}
function getChecked(id){return(document.getElementById(id).checked);}
function setChecked(id,value){document.getElementById(id).checked=value;}
function jslDiDisplay(id){var i;var num=jslDiDisplay.arguments.length;if(num==0)return;for(i=0;i<num;i++){document.getElementById(arguments[i]).style.display="none";}}
function jslEnDisplay(id){var i;var num=jslEnDisplay.arguments.length;if(num==0)return;for(i=0;i<num;i++)document.getElementById(arguments[i]).style.display="";}
function jslDisable(id){var i;var num=jslDisable.arguments.length;if(num==0)return;for(i=0;i<num;i++){document.getElementById(arguments[i]).disabled=true;}}
function jslEnable(id){var i=0;var num=jslEnable.arguments.length;if(num==0)return;for(i=0;i<num;i++)document.getElementById(arguments[i]).disabled=false;}
function jslViewToPostCheckBox(PostId,ViewId){if(document.getElementById(ViewId).checked)document.getElementById(PostId).value="1";else document.getElementById(PostId).value="0";}
function jslPostToViewCheckBox(ViewId,PostId){if(document.getElementById(PostId).value=="1")document.getElementById(ViewId).checked=true;else document.getElementById(ViewId).checked=false;}
function jslGetRadioValue(radioObject){if(radioObject){if(radioObject.length){for(var i=0;i<radioObject.length;i++){if(radioObject[i].checked){return radioObject[i].value;}}}else if(radioObject.checked){return radioObject.value;}}return -1;}
function jslSetRadioValue(radioObject,value){if(radioObject){if(radioObject.length){for(var i=0;i<radioObject.length;i++){if(radioObject[i].value==value){radioObject[i].checked=true;return true;}}}else if(radioObject.value==value){radioObject.checked=true;}}return false;}
function jslDoShowComboBox(viewid,postid){var i;var selector=document.getElementById(viewid);var value=document.getElementById(postid).value;if(selector==null)return;for(i=0;i<selector.length;i++){if(selector.options[i].value==value){selector.selectedIndex=i;return;}}selector.selectedIndex=-1;}
function RmZero(str){while(str.indexOf("0")==0&&str.length>1){str=str.substr(1);}return str;}
function IpRmZero(IpAddrValue){var IpAddr=IpAddrValue;var addrParts=IpAddr.split('.');IpAddr="";for(var i=0;i<4;i++){addrParts[i]=RmZero(addrParts[i]);IpAddr=addrParts.join(".");}return IpAddr;}
function ReSetIpRmZero(ID){var num=ReSetIpRmZero.arguments.length;var re=/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;var obj;if(num==0)return;for(i=0;i<num;i++){obj=document.getElementById(arguments[i]);if(obj!=null &&obj.value!=""&&obj.value!=null ){if(re.test(obj.value)!=true){return false;}obj.value=IpRmZero(obj.value);}}}
function ReSetValueRmZero(ID){var num=ReSetValueRmZero.arguments.length;var obj;if(num==0)return;for(i=0;i<num;i++){obj=document.getElementById(arguments[i]);if(obj!=null &&obj.value!=null &&obj.value!=""){if(obj.value.length>10){return false;}obj.value=RmZero(obj.value);}}}
function Transfer_meaning(id,value){document.getElementById(id).value=value;}
function HiddenParaInit(arr){var val;var obj;for(var i=0;i<arr.length;i++){val=arr[i];obj=getObj("Frm_"+val);if(obj!=null){jslDisable("Frm_"+val);}arr[i]="NULL";setValue(val,"NULL");}}
function HiddenMultiInstParaInit(arr,index){var val;var obj;for(var i=0;i<arr.length;i++){val=arr[i];obj=getObj("Frm_"+val);if(obj!=null){jslDisable("Frm_"+val);}setValue(val+index, "NULL");}}
function setNULLToSepPort(Port,Val){var portvalue=Port;if(portvalue==""){portvalue=Val;}return portvalue;}
function getSepPortToNULL(Port,Val){var portvalue=Port;if(portvalue==Val){portvalue="";}return portvalue;}
function setNULLToPort(Port){var portvalue=Port;if(portvalue==""){portvalue="-1";}return portvalue;}
function getPortToNULL(Port){var portvalue=Port;if(portvalue=="-1"){portvalue="";}return portvalue;}
function setNULLToMAC(MAC){var macaddr=MAC;if(macaddr==""){macaddr="00:00:00:00:00:00";}return macaddr;}
function getMACToNULL(MAC){var macaddr=MAC;if(macaddr=="00:00:00:00:00:00"){macaddr="";}return macaddr;}
function setNULLToIP(IP){var ipvalue=IP;if(ipvalue==""){ipvalue="0.0.0.0";}return ipvalue;}
function getIPToNULL(IP){var ipvalue=IP;if(ipvalue=="0.0.0.0"){ipvalue="";}return ipvalue;}
function encode64(input){var keyStr="ABCDEFGHIJKLMNOP"+"QRSTUVWXYZabcdef"+"ghijklmnopqrstuv"+"wxyz0123456789+/"+"=";input =escape(input);var output="";var chr1,chr2,chr3="";var enc1,enc2,enc3,enc4="";var i=0;do{chr1=input.charCodeAt(i++);chr2=input.charCodeAt(i++);chr3=input.charCodeAt(i++);enc1=chr1>>2;enc2=((chr1&3)<<4)|(chr2>>4);enc3=((chr2&15)<<2)|(chr3>>6);enc4=chr3&63;if(isNaN(chr2)){enc3=enc4=64;}else if(isNaN(chr3)){enc4=64;}output=output+keyStr.charAt(enc1)+keyStr.charAt(enc2)+keyStr.charAt(enc3)+keyStr.charAt(enc4);chr1=chr2=chr3="";enc1=enc2=enc3=enc4="";}while(i<input.length);return output;}
function decode64(input){var output="";var chr1,chr2,chr3="";var enc1,enc2,enc3,enc4="";var i=0;var base64test=/[^A-Za-z0-9\+\/\=]/g;var keyStr="ABCDEFGHIJKLMNOP"+"QRSTUVWXYZabcdef"+"ghijklmnopqrstuv"+"wxyz0123456789+/"+"=";if(base64test.exec(input)) {alert("There were invalid base64 characters in the input text.\n"+"Valid base64 characters are A-Z, a-z, 0-9, '+', '/', and '='\n"+"Expect errors in decoding.");}input =input.replace(/[^A-Za-z0-9\+\/\=]/g, "");do{enc1=keyStr.indexOf(input.charAt(i++));enc2=keyStr.indexOf(input.charAt(i++));enc3=keyStr.indexOf(input.charAt(i++));enc4=keyStr.indexOf(input.charAt(i++));chr1=(enc1<<2)|(enc2>>4);chr2=((enc2&15)<<4)|(enc3>>2);chr3=((enc3&3)<<6)|enc4;output=output+String.fromCharCode(chr1);if(enc3!=64){output=output+String.fromCharCode(chr2);}if(enc4!=64){output=output+String.fromCharCode(chr3);}chr1=chr2=chr3="";enc1=enc2=enc3=enc4="";}while(i<input.length);return unescape(output);}
function trimLSpaces(str){return str.replace(/(^\s*)/g,"");}
function trimRSpaces(str){return str.replace(/(\s*$)/g,"");}
function trimLRSpaces(str){return str.replace(/(^\s*)|(\s*$)/g,"");}
function trimAllSpaces(str){for(var i=0;i<str.length;i++){if(str.charAt(i)==" "){str=str.substring(0, i)+str.substring(i+1, str.length);i--;}}return str;}
