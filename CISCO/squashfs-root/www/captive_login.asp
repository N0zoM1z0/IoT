<html>
<head>
<title>Login Page</title>
<!--[if lt IE 7.]>
<script defer type="text/javascript" asrc="/pngfix.js"></script>
<![endif]-->
<% no_cache(); %>
<META http-equiv=Content-Type content="text/html"; charset=UTF-8>
<% js_link("guest"); %>
<style fprolloverstyle>
A:link { COLOR:#FFFFFF; }
A:visited { COLOR:#0088C2; text-decoration:none;}
A:hover { COLOR:#0088C2; text-decoration:none;}

BODY{
  margin:0px;
  overflow:hidden;
  background-repeat:no-repeat;
  background-color:#407BB3;
}

TABLE
{
  border:0px;
  padding:0px;
  border-collapse:collapse;
}

.GCOLOR{
	color:green;
}

BODY,TD,P,INPUT{
  font-size:12px;
  color:#ffffff;
  font-family:Arial;
  vertical-align:top;
}

textarea{
  font-size:12px;
  font-family:Arial;
}

INPUT{
  color:#000000;
}

.MAINTABLE{
	height:100%;
	width:100%;
}

.APPNAME{
  font-size:22px;
}

.VER
{
  font-size:11px;  
  height:73px;
}
.REMNAME{
  vertical-align:middle;
  font-size:11px; 
}
.copyright
{
  font-size:12px;
}
.LOGINIMG
{
  vertical-align:center;
  padding-right:20px;
}

.BT{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Normal.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
}

.BT_Hover
{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Hover.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
}

.BT_Press{
 height:22px;
 width:80px;
 background-image:url("/image/BT_Press.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
}

.BT_AUTO{
 height:22px;
 width:auto;
 background-image:url("/image/BT_Normal.jpg");
 border-style:solid;
 border:1px solid #53636a;
 margin-right:5px;
 amargin-left:9px;
 padding-right:9px;
 padding-left:9px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_AUTO_Hover{
 height:22px;
 width:auto;
 background-image:url("/image/BT_Hover.jpg");
 border-style:solid;
 border:1px solid #53636a;
 margin-right:5px;
 amargin-left:9px;
 padding-right:9px;
 padding-left:9px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_AUTO_Press{
 height:22px;
 width:auto;
 background-image:url("/image/BT_Press.jpg");
 border-style:solid;
 border:1px solid #53636a;
 margin-right:5px;
 amargin-left:9px;
 padding-right:9px;
 padding-left:9px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.LOGIN
{
  padding-top:20px;
  vertical-align:top;
  text-align:left;
  apadding-bottom:30px;

}


.IDPWD{
  padding-right:8px;
  padding-bottom:10px;
}

.IDPWD_TOP{
  padding-right:8px;
  padding-bottom:10px;
}

.ERRPWD
{
  color:red;
  font-size:14px;
  font-family:Arial;
  vertical-align:bottom;
  text-align:right;
}

.ERRMSG_TD
{
  padding:5px;
  background-image:url("/image/ToolbarMain.png");
  color:#FF0000
}

.ERRIMG_TD
{
  height:12px;
  background-image:url("/image/ContextMessageArrow_DownT.gif");
  background-repeat:no-repeat;
}

.INFO_TD{
   height:100%;
   width:500px;
   background-image:url("/image/ToolbarMain.png");
}

.INFO_MSG{
  padding:10px;
  width:32px;
  height:32px;
}

.INFO_MSG1{
  font-size:12px;
  color:#000000;
  vertical-align:middle;
  text-align:left;
}



</style>
<script language=javascript>
<% web_include_file("md5.js"); %>
//0: GUEST 1: LOCAL
var verif = "<% get_verif(); %>";

var lan_arr = new Array();
function LAN(vlan_id,ipaddr,netmask,proto,dhcprelay_ip,start_ip,user_num,lease_time,dns1,dns2,dns3,wins)
{
        this.vlan_id = vlan_id;
        this.ipaddr = ipaddr;
        this.netmask = netmask;
        this.proto = proto;
        this.dhcprelay_ip = dhcprelay_ip;
        this.start_ip = start_ip;
        this.user_num = user_num;
        this.lease_time = lease_time;
        this.dns1=dns1;
        this.dns2=dns2;
        this.dns3=dns3;
        this.wins=wins;
}
<% get_lan_data("lan_arr"); %>

function valid_subnet(I,N,G)
{
	var IP = new Array(4);
	var NM = new Array(4);
	var GW = new Array(4);
	
	IP = I.split(".");
	NM = N.split(".");
	GW = G.split(".");
	for(i=0;i<4;i++){
		if((IP[i] & NM[i]) != (GW[i] & NM[i])){
			return false;
		}
	}
	return true;
}

function lan_subnet_ip(ipaddr)
{
	for(var j=0; j<lan_arr.length; j++)
        {
        	if ( valid_subnet(ipaddr,lan_arr[j].netmask,lan_arr[j].ipaddr) )
			return j;
        }
	return "";
}

<% wl_multi_nvram_get("wl_vlan_id"); %>
var nv_gn_profile_0 = "<% nvram_get("gn_profile_0"); %>";
var nv_gn_profile_1 = "<% nvram_get("gn_profile_1"); %>";
var nv_gn_profile_2 = "<% nvram_get("gn_profile_2"); %>";
var nv_gn_profile_3 = "<% nvram_get("gn_profile_3"); %>";
if ( parent.document.getElementById("gn_profile_name") ) 
{
	var selidx = parent.document.getElementById("gn_profile_name").value;
	verif = parent.document.getElementById("gn_verif").value;
	//alert("find object - selidx="+selidx);
}

function en_value(data)
{
        var pseed2="";
        var buffer1=data;
        var md5Str2="";
        var Length2 = data.length;
        if (Length2 < 10 )
        {
                buffer1 += "0";
                buffer1 += Length2;
        }else{
                buffer1 += Length2;
        }
        Length2 = Length2 +2;
	
        for(var p=0; p<64; p++) {
                var tempCount = p % Length2;
                pseed2 += buffer1.substring(tempCount, tempCount+1);
        }
        md5Str2 = hex_md5(pseed2);

    	return md5Str2;
}

var preview_flg = 0;
if(window.top != window.self) { //Preview
	preview_flg=1;
}

function to_login()
{
	if ( document.getElementById("st_bt").style.display=="none" ) 
	{
		document.getElementById("tdmsg").style.display="none";
		document.getElementById("log").style.display="";
		before_submit();
	}
}

//var guest = "<% nvram_get("guestpwd"); %>";

var glist = new Array();
<% get_guest_list(); %>
var err1, err2, en_dec;
if ( preview_flg == 0 ) 
{
	en_dec = "<% client_gnet_get("gn_declaration_enable"); %>";
	err1 = "<% client_gnet_get("gn_error_1_title"); %>";
	err2 = "<% client_gnet_get("gn_error_2_title"); %>";
}else{
	en_dec = parent.document.getElementById("gn_en_dec").value;
	err1 = parent.document.getElementById("gn_err1").value;
	err2 = parent.document.getElementById("gn_err2").value;
}

function before_submit()
{
  var F = document.login;
  var flg = "";
  var en_pwd = en_value(F.pwd.value);
  for(var i=0; i<glist.length; i++)
  {
	  if ( glist[i][1] == en_pwd ) 
		flg = "guest";
  }
  document.getElementById("ifmsg").style.display="none";
  if ( verif == "1" && flg == "" )
  {
	document.getElementById("msg_td").innerHTML = err1 ; 
	document.getElementById("tdmsg").style.display="";
  	document.getElementById("log").style.display="none";
	return false;
  }
  if ( en_dec == "1" && document.getElementById("chk").checked == false ) 
  {
	document.getElementById("msg_td").innerHTML = __T(wl.policymsg); 
	document.getElementById("tdmsg").style.display="";
  	document.getElementById("log").style.display="none";
	return false;
  }
  if ( preview_flg == 0 )
  {
	F.submit_button.value = "captive_login";
  	F.pwd.value = en_pwd;
  	F.submit();
  }

}

function CheckBrowser(){
	var cb = "UnKnow";
	if ( window.ActiveXObject ) 
		cb = "IE" ; 
	else if ( navigator.userAgent.toLowerCase().indexOf("firefox") != -1 )
		cb = "Firefox";
	else if ( navigator.userAgent.toLowerCase().indexOf("opera") != -1 ) 
		cb = "Opera";
	else if ( navigator.userAgent.toLowerCase().indexOf("safari") != -1 ) 
		cb = "Safari";
	else if ( (typeof document.implementation != "undefined") && (typeof document.implementation.createDocument != "undefined") && (typeof HTMLDocument != "undefined" ))
		cb = "Mozila";
	return cb;
}

var Browser = CheckBrowser();
function get_url_key(flg)
{
        var NOWPATH;
        var pos=0;
        var tmp="";
        if ( typeof flg != "undefined" && flg == 1 ) 
        {
                if ( Browser == "Firefox" ) 
                {
                        NOWPATH = document.location.href;
                        if ( NOWPATH.indexOf(";") != -1 ) 
                                tmp = NOWPATH.substring(NOWPATH.lastIndexOf(";"), NOWPATH.length);
                }
                else
                {
                        NOWPATH = document.location.pathname.substring(1,document.location.pathname.length);
                        pos = NOWPATH.indexOf(";");
                        if ( pos != -1 )
                                tmp = NOWPATH.substring(pos,document.location.pathname.length);
                }
                return tmp;
        }
}


function HIDDEN_PART(tagname,start,end,flag)
{
        var i,starti,endi;
        var obj = document.getElementsByTagName(tagname);
        var len = obj.length;
        for(i=0; i<len; i++)
        {
                if( obj[i].id.indexOf(start)!=-1) starti = i;
                if( obj[i].id.indexOf(end)!=-1) endi = i;
        }
        if( starti == undefined ) return true;
        if( endi == undefined) endi = starti;
        for(i=starti; i<=endi; i++)
        {
                if(flag==0)
                        document.getElementsByTagName(tagname)[i].style.display="";
                else
                        document.getElementsByTagName(tagname)[i].style.display="none";
        }
}

function getPath(path)
{
        if ( path )
        {
                var x = path.lastIndexOf('\\');
                if ( x>=0 ) /// windows-based path
                        return path.substr(x+1);
                x = path.lastIndexOf('/');
                if ( x>=0 ) //Unix-based path
                        return path.substr(x+1);
                return path;
        }
	return "";
}


function init()
{
  var ip1 = '<% nvram_get("auth_ip"); %>';
  var ip2 = '<% nvram_get("http_client_ip"); %>';
  var auth_st = '<% nvram_get("auth_st"); %>';
  var keep_url_VLANID_IP4ADDR;  // EMIly note : this value is for redirect URL used, Case1: Redirect Enable Case2: Redirect Disable, this value is only for Redirect Disable?
  var bg_url="", logo_url="";
  if ( preview_flg == 0 ) 
  {
	bg_url = getPath("<% client_gnet_get("gn_bg"); %>");
	logo_url = getPath("<% client_gnet_get("gn_logo"); %>");
  }else{
	if ( parent.document.getElementById("gn_bg").value != "" ) 
		bg_url = getPath(parent.document.getElementById("gn_bg").value);
	if ( parent.document.getElementById("gn_logo").value != "" ) 
		logo_url = getPath(parent.document.getElementById("gn_logo").value);
  }
	
 
  if ( typeof guest_auth_pass != "undefined" ) 
  {
	about_win = self.open("guest.asp",'aboutTable','toolbar=no,memubar=no,resizable=no,scrollbars=no,directories=no,status=no,location=no,width=200,height=200',"_blank");
	this.close();
		
  }
  
  if ( typeof redirect_flg != "undefined" ) 
  {
	about_win = self.open("captive_login.asp",'aboutTable','',"_blank");
	this.close();
  }
  
  document.login.user.focus();

		
  if (typeof login_st != "undefined") 
  {
 	if ( login_st && login_st == 3 ) // ADMIN Alreay login 
	{
		HIDDEN_PART("TR","login_start","login_end",1);
		document.getElementById("st_bt").style.display="";
	  	document.getElementById("tdmsg").style.display="";
        }
  }
  if ( (typeof user_aging != "undefined" && user_aging == 1) ||
       (typeof login_st != "undefined" && (login_st == 3 || login_st == 2) ) ||
       (typeof drop_user != "undefined" && drop_user == 1 ) ||
       ( typeof timeout_user != "undefined" && timeout_user == 1 ) )
	document.getElementById("ifmsg").style.display="";
  if ( verif == "1" ) 
  {
     	document.getElementById("pwd_tr").style.display=""; 
  }
//  if ( data[selidx][15] == "0" ) 
//	document.getElementById("chk").disabled = true;
  if ( bg_url != "" ) 
	document.bg_img.src = "/image/gn/"+bg_url;
  if ( logo_url != "" ) 
	document.logo_img.src = "/image/gn/"+logo_url;
}

function to_continue(F)
{
	F.submit_button.value="login";
	F.submit_type.value="continue";
	F.gui_action.value="gozila_cgi";
	F.submit();
}

function to_cancel(F)
{
	F.submit_button.value="login";
	F.submit_type.value="logout";
	F.change_action.value="gozila_cgi";
	F.action = get_url("apply.cgi");
	F.submit();
}

function get_url(nowurl)
{
	var session_id = "<% nvram_get("tmp_auth_key"); %>";
	return nowurl+";session_id="+session_id;
}

function chk_keypress(e)
{
	var keycode = (window.event)? event.keyCode:e.which;
	if ( keycode == 13 ) 
	{
		to_login();
		if ( window.event )
		{
			window.event.returnValue = null;
			event.keyCode=0;
		}else
			e.preventDefault();
		return false;
	}
}

function __T(obj)
{
	return obj;
}

function Capture(obj)
{
	document.write(obj);
}

function Sel_Lang(F)
{
	var err_lang = "<% nvram_get("lang_err"); %>";
	if ( err_lang == "1" ) 
	{
  		document.getElementById("ifmsg").style.display="";
		document.getElementById("tdmsg").style.display="none";
		document.getElementById("infomsg").innerHTML = spell_words(lang_rule,"<% get_lang_ver("supoprt_lang_version"); %>");
  		document.getElementById("log").style.display="none";
		F.sel_lang[0].selected = true;
	}else{
        	F.submit_button.value = "default";
	        F.change_action.value = "gozila_cgi";
        	F.submit_type.value = "set_lang";
		//F.action = "setlang.cgi";
	        F.submit();
	}
}

function CHG_PART(Tagname, start, end)
{
        var obj = document.getElementsByTagName("TD");
	var len = obj.length;
        for(i=0; i<len; i++)
        {
		if( obj[i].id.indexOf(start)!=-1) starti = i; 
		if( obj[i].id.indexOf(end)!=-1) endi = i; 
        }
	
}

function my_cy_speccode_decode(string) 
{
	string = string.toString();
	string = string.replace(/&#92;/g, '\\');
	string = string.replace(/&#39;/g, '\'');
	string = string.replace(/&#38;/g, '&');
	string = string.replace(/&#60;/g, '<');
	string = string.replace(/&lt;/g, '<');
	string = string.replace(/&#62;/g, '>');
	string = string.replace(/&gt;/g, '>');
	string = string.replace(/&#34;/g, '"');
	string = string.replace(/&semi;/g, ':');
	string = string.replace(/&nbsp;/g, ' ');
	string = string.replace(/&amp;/g, '&');
	string = string.replace(/<BR>/g, '\r\n');
	return string;
} 
//document.getElementById("tdtitle").className="GCOLOR";//data[selidx][4]; 
</script>
<body id=welbody onload=init()> 
<FORM id=frm name=login method=<% get_http_method(); %> action="guestnetwork.cgi" onKeyDown=chk_keypress(event) autocomplete=off>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=wait_time value=0>
<input type=hidden name=change_action>

<input type=hidden name=enc value=1>
     <div id=bg style="position:relative;z-index:0;background-color:#407BB3;">
     <img name=bg_img id=bg_img src='/image/small_bg.jpg' width=100% style="position:absolute; z-index:-1">
     <TABLE cellspacing=0 aclass=MAINTABLE>
       <TR height=30% style='padding-top:20px;'>
       <TD id=login_start>&nbsp;</TD>
  	  <TD colspan=4 style='padding-top:150px;padding-left:200px;padding-bottom:20px;'>
  		<TABLE cellspacing=0 class=INFO_TD id=ifmsg style=display:none>
		<tr><td class=INFO_MSG><img src='/image/Status_information_icon.png'>	                     
		<TD class=INFO_MSG1 id=info_msg>
		<script>
		var infomsg="";
		if (typeof login_st != "undefined" || typeof drop_user != "undefined" || typeof timeout_user != "undefined") 
		{
			if (typeof user_aging != "undefined" && user_aging == 1)
				infomag = __T(msg.loginguestmsg);
	                else if (typeof login_st != "undefined" && (login_st == 3 || login_st == 2) )
			{
				if ( login_st == 3 ) 
					infomsg = err2;
				else
					infomsg = __T(msg.adminlogined1);
			}
			else if ( typeof drop_user != "undefined" && drop_user == 1 ) 
				infomsg = __T(msg.droplogin);
			else if ( typeof timeout_user != "undefined" && timeout_user == 1 ) 
				infomsg = __T(mang.sessiontimeout);

			if ( infomsg != "" ) 
			{
			//	document.write("<tr><td class=INFO_MSG><img src='/image/Status_information_icon.png'></TD>");	                       	      document.write("<TD class=INFO_MSG1 id=infomsg>"+infomsg);
				document.write(infomsg);	
			}
		}
                </script>
		</TD></TR>
		</TABLE>
	  </TD>
	</TR>
  	<TR>
  	<TD width=100px>&nbsp;</TD>
  	<TD rowspan=1>
		<table width=100% cellspacing=0>
		<TR><TD rowspan=2 width=100px>
			<img name=logo_img id=logo_img src='/image/cisco_logo_about.png'></TD>
		    <TD NOWRAP><script>
		    if ( preview_flg == 0 ) 
			 document.write("<% client_gnet_get("gn_company_title"); %>");
		    else
			 document.write(parent.document.getElementById("gn_company").value);
                    </script></TD>
                </TR>
		<TR><TD class=APPNAME NOWRAP>
                <script>
		    if ( preview_flg == 0 ) 
			 document.write("<% client_gnet_get("gn_welcome_title"); %>");
		    else
			 document.write(parent.document.getElementById("gn_welcome").value);
		</script></TD></TR>
		</TABLE>
	        	
  	<!--TD class=APPNAME NOWRAP><script>Capture(router.guestacc);</script></TD-->
	<TD style='width:250px; padding-left:40px;'>&nbsp;</TD>
  	<TD class=LOGIN>
  		<TABLE cellspacing=0 valign=top>
			<TR id=msg>
			<TD></TD>
			<TD class=ERRPWD height=50px colspan=2 id=tdmsg style=display:none>
				<TABLE cellspacing=0>
                                <tr><td class=ERRMSG_TD id=msg_td>
                                <script>
				if (typeof logtime != "undefined" && logtime>0 )
                                {
                                        document.write(err1);
                                }
				
				if (typeof login_st != "undefined") 
				{
					if ( login_st && login_st == 3 ) 
					{
                        	                document.write(err2);
					}
				}
                                </script>
                                </TD></TR><TR><TD class=ERRIMG_TD>&nbsp;</TD></TR>
                        </TABLE>
			</TD>
			</TR>
			<TR style=display:none id=st_bt><TD></TD>
			<TD>
			<script>
			document.write("<input type=button value="+__T(share.cont)+" class=BT id=t1 onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\" onclick=to_continue(this.form)>&nbsp;<input type=button value="+__T(share.cancel)+" class=BT id=t2 onMouseover=\"this.className='BT_Hover'\" onMouseout=\"this.className='BT'\" onMousedown=\"this.className='BT_Press'\" onclick=to_cancel(this.form)>");
			</script>
			</TD></TR>
				
  			<TR><TD class=IDPWD_TOP>
			<script>
				if ( preview_flg == 0 ) 
					document.write("<% client_gnet_get("gn_username_title"); %>");
				else
					document.write(parent.document.getElementById("gn_uname").value);
			</script>:</TD><TD>
			<script>
			document.write("<input type=input name=user value='' size=26 style=width:163 maxlength=64>");
			//document.write("<input type=input name=user value='"+admin_name+"' size=26 style=width:163>");
			</script>
			</TD><TD></TD></TR>
  			<TR id=pwd_tr style=display:none><TD class=IDPWD>
			<script>
				if ( preview_flg == 0 ) 
					document.write("<% client_gnet_get("gn_password_title"); %>");
				else
					document.write(parent.document.getElementById("gn_upwd").value);
			</script>:</TD><TD><input type=password name=pwd size=26 maxlength=64 style=width:163></TD><TD></TD></TR>
  			<!--TR><TD class=IDPWD><script>Capture(router.lang);</script>:</TD><TD>
			<select style="width:163" name=sel_lang onChange=Sel_Lang(this.form)>
				<script>
				// Get the all language string
				//__T(lang.en), __T(lang.de), __T(lang.sp), __T(lang.it), __T(lang.fr), __T(lang.pt);
				<% onload_lang(); %>
				var selidx="";
				var nowlang = "<% nvram_get("language"); %>";
				for(var i=0; i<_name.length; i++)
				{
					selidx = "";
					if ( nowlang == _val[i] ) selidx = "selected";
					document.write("<option value="+_val[i]+" "+selidx+">"+_name[i]+"</option>");
				}
				</script>
			</select>
			</TD><TD></TD></TR-->
			<TR id=login_end><TD></TD><TD>
			<script>
			document.write("<input type=button value='");
			if ( preview_flg == 0 ) 
				document.write("<% client_gnet_get("gn_login_title"); %>");
			else
				document.write(parent.document.getElementById("gn_login").value);
			document.write("' class=BT_AUTO id=t1 onMouseover=\"this.className='BT_AUTO_Hover'\" onMouseout=\"this.className='BT_AUTO'\" onMousedown=\"this.className='BT_AUTO_Press'\" onclick=to_login()>");
			</script>
			&nbsp;<img id=log src=image/login_progress.gif class=LOGINIMG style="display:none">
			</TD></TD></TR> 
  		</TABLE>
  	  </TD><TD width=100px height=50px>&nbsp;</TD>
  </TR>
<TR><TD>&nbsp;</TD><TD colspan=2 valign=top height=120px>
<script>
	if ( en_dec == "1" )
	{ 
	document.write("<textarea id=txtarea cols=60 rows=5 readonly>");
	if ( preview_flg == 0 ) 
		document.write(my_cy_speccode_decode("<% client_gnet_get("gn_declaration"); %>"));
	else
		document.write(parent.document.getElementById("dec").value);
	document.write("</textarea><BR>");
	document.write("<input type=checkbox id=chk name=chk>");
	if ( preview_flg == 0 ) 
		document.write("<% client_gnet_get("gn_agree_title"); %>");
	else
		document.write(parent.document.getElementById("gn_agree").value);
	document.write("</TD></TR>");
	}
</script>
<TR><TD></TD>
	<TD colspan=4 class=copyright id="login_end">
		<script>
		if ( preview_flg == 0 ) 
			document.write("<% client_gnet_get("gn_copyright_title"); %>");
		else
			document.write(parent.document.getElementById("gn_copyright").value);
		</script>
	</TD>
	<script> // CHANGED FONT COLOR
		var obj = document.getElementsByTagName("TD");
		var len = obj.length;
        	var i,starti,endi;
		var fcolor;
		if ( preview_flg == 0 ) 
			fcolor = "<% client_gnet_get("gn_font_color"); %>";
		else
			fcolor = parent.document.getElementById("gn_fcolor").value;
        	for(i=0; i<len; i++)
       		{
                	if( obj[i].id.indexOf("login_start")!=-1) starti = i; 
	                if( obj[i].id.indexOf("login_end")!=-1) endi = i; 
        	}
		if( endi == undefined) endi = starti;
        	for(i=starti; i<=endi; i++)
		{
			document.getElementsByTagName("TD")[i].style.color=fcolor;
		}
	</script>
</TR>
</TABLE>
</FORM>
</body>
</html>
