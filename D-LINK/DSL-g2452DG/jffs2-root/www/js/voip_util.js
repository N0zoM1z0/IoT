var g_errorInfo = "错误信息";
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
function myTrim(str,chr){var pos=str.lastIndexOf(chr);while(pos!=-1){if(pos+chr.length==str.length){str=str.substring(0, pos);pos=str.lastIndexOf(chr);}else {pos=-1;}}return str;}
function calcSubNet(ipaddr,netmask){var ips=ipaddr.split(".");var ns=netmask.split(".");var sub="";if(ips.length!=4||ns.length!=4)return "0.0.0.0";for(var i=0;i<4;i++){sub+=ips[i]&ns[i];sub+=".";}sub=myTrim(sub,".");return sub;}
function checkNull(value){if(value==""||value==null)return false;else return true;}
function checkGenString(sz){if(checkNull(sz)==false)return -1;if(sz.match("[^0-9a-zA-Z_-]")!=null)return false;return true;}
function checkGenStringForASC(value){var length=value.length;for(var j=0;j<length;j++){var xx=value.charCodeAt(j);if(xx>0&&xx<=255){}else {return false;}}return true;}
function checkGenStringForTelNum(value){var length=value.length;for(var j=0;j<length;j++){var xx=value.charCodeAt(j);if((xx>=48&&xx<=57)||(xx==35)||(xx==42)){}else {return false;}}return true;}
function checkStrLengthRange(value,min, max){if(checkNull(value)==false){return -1;}var len=value.length;if((len<min) ||(len>max)){return -3;}return true;}
function checkInteger(str){if(str.charAt(0)=='-')str=str.substr(1);if(str.match("^[0-9]+\$"))return true;return false;}
function checkIntegerRange(value,minValue, maxValue){if(checkNull(value)==false){return -1;}if(checkInteger(value)!=true)return -2;if(value<minValue ||value>maxValue){return -3;}return true;}
function checkGenInt(str){if(checkIntegerRange(str,-2147483648,2147483647)!=true)return false;return true;}
function checkUnSingleInt(str){if(checkIntegerRange(str,0,4294967295)!=true)return false;return true;}
function checkHostName(HostName){var len=HostName.length;var firstChar=HostName.substr(0,1);var lastChar=HostName.substr(len-1,1);var leftChar="";var rightChar="";var iDotCount=0;var i=0;var preDotPos=0;var statu=checkStrLengthRange(HostName,1,256);if(statu!=true){return statu;}if(HostName.match("[^0-9a-zA-Z.-]")!=null){return false;}if(firstChar.match("[^0-9a-zA-Z]")!=null){return false;}if(lastChar.match("[^0-9a-zA-Z]")!=null){return false;}var pos=HostName.lastIndexOf(".");if(pos==-1){var str=HostName;var len=HostName.length;for(var i=0;i<len;i++){var value=str.substring(i,i+1);if(isNaN(parseInt(value))){return true;}}return false;}else {var str=HostName.substr(pos+1);var len=HostName.length-(pos+1);for(var i=0;i<len;i++){var value=str.substring(i,i+1);if(isNaN(parseInt(value))){return true;}}return false;}return true;}
function checkDomainName(domain_name){var len=domain_name.length;var firstChar=domain_name.substr(0,1);var lastChar=domain_name.substr(len-1,1);var leftChar="";var rightChar="";var iDotCount=0;var i=0;var preDotPos=0;var statu=checkStrLengthRange(domain_name, 1,64);if(statu!=true){return statu;}if(domain_name.match("[^0-9a-zA-Z.-]")!=null){return false;}if(firstChar.match("[^0-9a-zA-Z]")!=null){return false;}if(lastChar.match("[^0-9a-zA-Z]")!=null){return false;}var pos=domain_name.lastIndexOf(".");if(pos==-1){var str=domain_name;var len=domain_name.length;for(var i=0;i<len;i++){var value=str.substring(i,i+1);if(isNaN(parseInt(value))){return true;}}return false;}else {var str=domain_name.substr(pos+1);var len=domain_name.length -(pos+1);for(var i=0;i<len;i++){var value=str.substring(i,i+1);if(isNaN(parseInt(value))){return true;}}return false;}return true;}
function checkEssid(value){var statu=checkStrLengthRange(value,1,32);if(statu!=true){return statu;}var length=value.length;for(var j=0;j<length;j++){var xx=value.charCodeAt(j);if(xx>0&&xx<=255){}else {return false;}}return true;}
function checkURL(url){var statu=checkStrLengthRange(url,1,256);if(statu!=true){return statu;}if(url.match("[^0-9a-zA-Z.:;,!@%#?_/&=+*'$()-]")!=null){return false;}return true;}
function checkIpAddress(value,num){var ipaddr=value;var c=false;var re=/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;if(re.test(ipaddr)==true){var parts=ipaddr.split(".");for(var i=0;i<parts.length;i++){if(parts[i].indexOf("0")==0&&parts[i].length>1)return false;if(parseInt((parts[i]),10)>255||parseInt((parts[i]),10)<0){return false;}}if(num==2){if(parseInt(parts[0],10)==0||parseInt(parts[3],10)==0){return false;}if(parseInt(parts[0],10)==255||parseInt(parts[3],10)==255){return false;}if(parseInt(parts[0],10)>223)return false;}if(num==3){for(var i=0;i<parts.length;i++){if(parseInt((parts[i]),10)==0)break;}if(i==parts.length){if((parseInt(parts[1],10)==255)&&(parseInt(parts[2],10)==255)&&(parseInt(parts[3],10)==255)){c=true;}else {c=false;return c;}}for(var j=i;j<parts.length;j++){if(parseInt((parts[j]),10)==0)c=true;else {c=false;break;}}return c;}return true;}else {return false;}}
function checkIPV6Address(str){if(str.match("[^0-9a-fA-F:.]")!=null)return false;addrParts=str.split(':');Doublecolon=str.split('::');ipv4Parts=str.split('.');if(addrParts.length<3||addrParts.length>8){return false;}else if(Doublecolon.length==1&&ipv4Parts.length==1&&addrParts.length!=8){return false;}else if(Doublecolon.length==1&&ipv4Parts.length>1&&addrParts.length!=6){return false;}else if(Doublecolon.length>1&&ipv4Parts.length>1&&addrParts.length>6){return false;}else if(Doublecolon.length>2||str.split(':::').length>1){return false;}else {if(addrParts[0]==""&&addrParts[1]!=""){return false;}for(var i=0;i<addrParts.length;i++){if(i==addrParts.length-1&&addrParts[i]==""&&addrParts[i-1]!=""){return false;}if(addrParts[i].length>4&&addrParts[i].split('.').length<2){return false;}}}var pos=str.lastIndexOf(":");var ipv4Parts=str.split('.');if(ipv4Parts.length>1){var ipv4=str.substring(pos+1,str.length);if(true!=checkIpAddress(ipv4,"")){return false;}if("::ffff"!=str.substring(0,str.lastIndexOf(":"))){return false;}}return true;}
function checkGateway(Address){var address=Address.match("^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$");var digits;var i;if(address==null){return false;}digits=address[0].split(".");if(digits.length!=4){return false;}for(i=0;i<4;i++){if((Number(digits[i])>255)||(Number(digits[i])<0)||(Number(digits[0])>223)){return false;}}return true;}
function checkMACAddress(Addr){var c='';var i=0,j=0;if(Addr=="00:00:00:00:00:00"){return false;}var addrParts=Addr.split(':');if(addrParts.length!=6)return false;for(i=0;i<6;i++){if(addrParts[i].length!=2)return false;for(j=0;j<addrParts[i].length;j++){c=addrParts[i].toLowerCase().charAt(j);if((c>='0'&&c<='9')||(c>='a'&&c<='f'))continue;else return false;}}return true;}
function checkMaskAddress(MaskAddr){var mask=MaskAddr.match("^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$");var digits;var bMask=0;var watch=false;var i;var error=null;if(mask==null){return false;}digits=mask[0].split(".");if(digits.length!=4){return false;}for(i=0;i<4;i++){if((Number(digits[i])>255)||(Number(digits[i])<0)||(digits[i].indexOf("0")==0&&digits[i].length>1)){return false;}bMask=(bMask<<8)|Number(digits[i]);}bMask=bMask&0x0FFFFFFFF;if((bMask&0x01)==1)watch=true;for(i=0;i<32;i++){if((watch==true)&&((bMask&0x1)==0)){return false;}bMask=bMask>>1;if((bMask&0x01)==1)watch=true;}return true;}
function checkIPNet(ipaddr,netmask){var ret=checkIpAddress(ipaddr);if(ret!=true)return ret;if(netmask==null)return null;ret=checkMaskAddress(netmask);if(ret!=null)return ret;var ips=ipaddr.split(".");var subnet=calcSubNet(ipaddr,netmask);var subs=subnet.split(".");var s="";for(var i=0;i<4;i++){s+=parseInt(ips[i])^parseInt(subs[i]);s+=".";}if(s=="0.0.0.0.")return true;return false;}
function checkPort(port){var value=port;if(port=="-1")return false;else return true;}
function valIpMask(ipaddr,netmask){var ss=netmask.split(".");var mac=0;for(var i=0;i<4;i++){mac=mac<<8;mac=mac+parseInt(ss[i]);}var ip=0;var as=ipaddr.split(".");for(var i=0;i<4;i++){ip=ip<<8;ip=ip+parseInt(as[i]);}if(mac&&((ip&mac)==ip)){return false;}if(mac&&((ip&(~mac))==~mac)){return false;}return true;}
function moveErrLayer(left,top){document.getElementById("myLayer").style.left=left+"px";document.getElementById("myLayer").style.top=top+"px";}
function ShowNote(notetitle,msg){document.getElementById("errnote").innerHTML =notetitle;document.getElementById("errmsg").innerHTML =msg;document.getElementById("myLayer").style.visibility="visible";}
function ShowNoteNew(ctl,notetitle,msg){document.getElementById("errnote").innerHTML =notetitle;document.getElementById("errmsg").innerHTML =msg;document.getElementById("myLayer").style.visibility="visible";if(ctl!=null &&ctl.disabled==false){ctl.focus();}}
function ShowNoteForCom(frmid,fntid,msg){var fntmsg;var strmsg;if(document.getElementById(fntid)==null){if(fntid==null)fntmsg="";else fntmsg=fntid;}else{fntmsg=document.getElementById(fntid).innerHTML;}strmsg=fntmsg+msg;ShowNoteNew(document.getElementById(frmid),"Note",strmsg);}
function ShowError(ctl,msg){var tmpStr=g_errorInfo;if(tmpStr=="undefined"){tmpStr="Error";}document.getElementById("errnote").innerHTML =tmpStr;document.getElementById("errmsg").innerHTML =msg;document.getElementById("myLayer").style.visibility="visible";if(ctl!=null &&ctl.disabled==false){ctl.focus();}}
function ShowErrorForCom(frmid,fntid,msg){var fntmsg;var strmsg;if(document.getElementById(fntid)==null){if(fntid==null)fntmsg="";else fntmsg=fntid;}else{fntmsg=document.getElementById(fntid).innerHTML;}strmsg=fntmsg+msg;ShowError(document.getElementById(frmid),strmsg);}
function getMsgFormArray(str,arg){var errid=0;var min =0;var max=0;var param=-1;var msg="";var num=arg.length;if(num==1){errid=arg[0];}else if(num==3){errid=arg[0];min =arg[1];max=arg[2];}else if(num==2){errid=arg[0];param=arg[1];}else return null;for(var i=0;i<str.length;i++){if(typeof(str[i])=="undefined"){alert("数组初始化有误，请检查代码！i = "+i);return null;}if(errid==str[i][0]){if(min ==max&&min ==0){if(param==-1){msg=str[i][1];}else {msg=str[i][1]+param+str[i+1][1];}}else msg=str[i][1]+min +"~"+max+str[i+1][1];return msg;}}return null;}
function setTextFocusEnd(){var srcElement=event.srcElement;var textRange=srcElement.createTextRange();textRange.moveStart('character',srcElement.value.length);textRange.collapse(true);textRange.select();}
function getURL(){var ret="getpage.gch?pid=1002&nextpage=";var len=arguments.length;if(0!=(len-1)%2){ShowErrorForCom(null,null,"arguments len err of getURL!");return;}for(var i=0;i<len;i++){if(i%2==1){ret+="&"+arguments[i]+"=";}else {ret+=arguments[i];}}return ret;}
function menuURLGen(){for(var supId in meta_menu){meta_menu[supId]['URL']=getURL(meta_menu[supId]['page']);for(var midId in menu_items[supId]){menu_items[supId][midId]['URL']=getURL(menu_items[supId][midId]['page']);for(var subId in menu_subitems[supId][midId]){menu_subitems[supId][midId][subId]['URL']=getURL(menu_subitems[supId][midId][subId]['page']);}}}}
function menuURLGen_Top(){for(var supId in meta_menu){meta_menu[supId]['URL']=getURL(meta_menu[supId]['page']);}}
function menuDisp(){menuURLGen();menuUpdate();}
function ReplaceDemo(ss){var r,re;re=/ /g;r=ss.replace(re,"&nbsp;");return r;}
function openLink(pageurl){var replaceurl=ReplaceDemo(pageurl);var tag=getObj("IF_UPLOADING").value;if(tag=="1"){top.mainFrame.location.href ="#";}else {top.mainFrame.location.href =replaceurl;}}
function getMidMenuStat(supId,midId){var len=0;for(var i in menu_subitems[supId][midId]){len++;}if(0==len){return "single";}for(var subId in menu_subitems[supId][midId]){if(selectPage==menu_subitems[supId][midId][subId]['page']){return "open";}}return "closed";}
function OnMenuItemClick(supId,midId){selectPage=menu_items[supId][midId]['page'];selectSupId=supId;menuUpdate();}
function setenter(e)
{
    e = window.event?window.event:e;
    if( e == "[object]")
    {
        if (event.keyCode == 13 && event.srcElement.type == "text")
        {
            event.keyCode = 9;
        }
    }
}

function uiCancel()
{
    //Cancel时刷新该页面
    jslDisable("Btn_Submit","Btn_Cancel");
    document.location.reload();
}

function getmsg(id)
{
    var str=new Array();
    str[0]=new Array(101,"Please Input Valid Data");
    str[1]=new Array(134,"Plesse Input Valid IP or Domain");
    str[2]=new Array(118,"Invalid Opreation, Please check"); 
    str[3]=new Array(119,"Invalid Opreation, Please check");
    str[4]=new Array(122,"Invalid Opreation, Please check input!");
    str[5]=new Array(114,"Please  Input Valid Number");
    str[6]=new Array(116,"Please Input Valid Data");
    str[7]=new Array(117,"");
    str[8]=new Array(102,"The Length is Wrong, Please Input Again");
    str[9]=new Array(103,"");
    str[10]=new Array(108,"Please input valid IP address");
    str[11]=new Array(155,"Please input valid data");
    str[12]=new Array(156,"Please input valid data");
    str[13]=new Array(115,"Pleae Input Valid Number");
    str[14]=new Array(160,"The data can not be 0");
    str[15]=new Array(167,"System busy , Please try later");
    str[16]=new Array(131,"Please input");
    str[17]=new Array(132,"Plese Input Valid Number.");
    str[18]=new Array(202,"Please Input #, 0-9.");
    str[19]=new Array(805,"Please Input Valid Number");
    str[20]=new Array(1006,"Please Select The Operation");
    str[21]=new Array(201,"Please Input 10,20,30,40,50 or 60");
    str[22]=new Array(803,"Please Input even number in begin port!");
    str[23]=new Array(301,"Please Input valid FaxCodec,include G711A/G711U");
    str[24]=new Array(302,"Please Input valid G711A FaxPT,include 8/96-127");
    str[25]=new Array(303,"Please Input valid G711U FaxPT,include 0/96-127");
 
    return getMsgFormArray(str,arguments);
}

