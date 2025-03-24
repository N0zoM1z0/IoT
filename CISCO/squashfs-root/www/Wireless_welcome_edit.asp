<html>
<head>
<title>Advanced Settings</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var now_idx = "<% nvram_gozila_get("now_idx"); %>";
var stflg = "<% nvram_gozila_get("stflg"); %>";
var font_name = new Array(__T(wl.white),__T(wz.red),__T(wz.green),__T(wl.gray),__T(wl.blue),__T(wl.magenta),__T(wl.cyan),__T(wl.block));
var font_val = new Array("white","red","green","gray","blue","magenta","cyan","#000000");
var wlist = new Array();
<% get_guest_profile("wlist"); %>
<% get_upload_file(); %>
function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.wireless;
	if ( stflg == "add" ) 
	{
		F.en_autoredir[1].checked = true;
		F._gnet_dec[1].checked = true;
	}
	en_url(F);
	sel_dec(F);
	default_nv = keep_val(F,"");
}

function chk_name(F)
{
	clear_msg("gnet_pname","msg_gnet_pname");
        var returnmsg = valid_meaning_id_name(ID_NAME,F.gnet_pname.value,ZERO_NO,"gnet_pname");
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,"gnet_pname",returnmsg,"0","msg_gnet_pname");
		return false;
	}
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("Wireless_welcome.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}


function uiDoSave(F)
{
	if ( F._gnet_dec[0].checked == true ) 
		F.gnet_dec.value = "1";
	else
		F.gnet_dec.value = "0";
	if ( !chk_name(F) ) return false;
	if ( !msg_chk_range(F.stime.value,'stime',0,1440,10,IS_FIELD,0,'msg_stime') ) return false;
	if ( F.en_autoredir[0].checked == true && F.gnet_url.value == "" ) 
	{
		my_alert(O_VAR,"gnet_url",__T(msg.notblank),"0","msg_gnet_url");
		return false;
	}
	choose_enable(F.gnet_url);	
	F.gnet_copyright.value = F.gnet_copyright.value.replace(/©/g,'&copy;')
	F.bg_name.value = document.getElementById("tdfname_0").innerHTML;
	F.logo_name.value = document.getElementById("tdfname_1").innerHTML;
	F.submit_button.value = "Wireless_welcome";
	F.gui_action.value = "Apply";
	F.now_idx.value = now_idx;
	F.submit();	
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
		
}

function en_url(F)
{
	if ( F.en_autoredir[0].checked == true ) 
		choose_enable(F.gnet_url);
	else
		choose_disable(F.gnet_url);
}

function sel_dec(F)
{
	if ( F._gnet_dec[0].checked == true ) 
	{
		choose_enable(F.txt_dec);
		choose_enable(F.gnet_atitle);
	}
	else
	{
		choose_disable(F.txt_dec);
		choose_disable(F.gnet_atitle);
	}
}

function to_delfile(index)
{
	var F = document.wireless;
	F.now_idx.value = now_idx;
	F.stflg.value = stflg;
	F.remove_id.value = parseInt(index)+1;
	F.change_action.value = "gozila_cgi";
	F.submit_button.value="Wireless_welcome_edit";
	F.submit_type.value="del_upload";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
}

function to_upload(index)
{
	var F = document.wireless;
	// 0 = BG, 1=LOGO
	var obj = eval("F.uploadfile"+index);
	F.now_idx.value = now_idx;
	F.stflg.value = stflg;
	F.gnet_copyright.value = F.gnet_copyright.value.replace(/©/g,'&copy;')
	if ( document.getElementById("tdfname_0").innerHTML != "" ) 
		F.bg_name.value = document.getElementById("tdfname_0").innerHTML;
	if ( document.getElementById("tdfname_1").innerHTML != "" ) 
		F.logo_name.value = document.getElementById("tdfname_1").innerHTML;
	var len = obj.value.length;
	var ext;
	// ALLOW GIF, JPG, PNG	
        if ( obj.value != ''){
		ext = obj.value.split(".");
		if ( (index == "0" && ext[1].toUpperCase() != "JPG") ||  
		     (index == "1" && ext[1].toUpperCase() != "GIF"))
		{
			table_msg("img"+index,"uploadfile"+index,"div"+index,index,__T(msg.invalidftype));	
			return false;
		}
		choose_enable(F.gnet_url);	
		choose_enable(F.txt_dec);
		F.action = goto_link("upload.cgi");
        	F.submit_button.value = "Wireless_welcome_edit";
                F.encoding = "multipart/form-data";
		F.gui_action.value = "Apply";
        	F.submit();
		parent.document.getElementById("save_bg").style.display="";
		if ( http_from == "wan" ) 
		{
			setTimeout("chk_st()", 15000);
		}	
	} 
}

function callNewLine(e,obj)
{
	var keycode = (window.event)? event.keyCode:e.which;
	if ( keycode == 13 ) 
	{
		obj.value+="\r\n";
		return false;
	}
}

function CheckMaxlength(obj)
{
	if ( obj ) 
	{
		var maxlen = parseInt(obj.getAttribute("maxlength"),10);
		var curlen = obj.value.length;
		if ( curlen > maxlen ) 
		{
			obj.value = obj.value.substring(0,maxlen);
		}
	}
	
}
</script>
<body onload="init();">
<FORM autocomplete=off id=frm method=<% get_http_method(); %> name=wireless action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=gnet_dec>
<input type=hidden name=now_idx id=now_idx value="<% nvram_gozila_get("now_idx"); %>">
<input type=hidden name=stflg id=stflg value="<% nvram_gozila_get("stflg"); %>">
<input type=hidden name=remove_id>
<input type=hidden name=bg_name>
<input type=hidden name=logo_name>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.portalprofile));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.welsetting),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.profilename));</script>
                <INPUT maxLength=32 size=32 name="gnet_pname" id="gnet_pname" onblur=chk_name(this.form) value="<% gnet_get("gn_profile_name"); %>">
		<span id=msg_gnet_pname></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.verif));</script>
                <script>
                        var _name = new Array(__T(wl.guest),__T(vpn.local));
                        var _val = new Array("0","1");
			draw_object(O_GUI,SELBOX,"gnet_verif","",_name,_val,"<% gnet_get("gn_verification"); %>");
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.autoredurl));</script>
		<script>
		var _name = new Array(__T(share.enable),__T(share.disable));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"en_autoredir",_val,_name,"<% gnet_get("gn_redirect_url_enable"); %>","onclick=en_url(this.form)");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.redirect));</script>
                <INPUT maxLength=256 size=32 name="gnet_url" id="gnet_url" value='<% gnet_get("gn_redirect_url"); %>'>
		<span id=msg_gnet_url></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.sessiontimeout));</script>
                <INPUT maxLength=256 size=32 name="stime" id="stime" value='<% gnet_get("gn_session_time"); %>' onblur=msg_chk_range(this.value,'stime',0,1440,10,IS_FIELD,0,'msg_stime')>&nbsp;
		<script>document.write(__T(unit.minutes)+" "+spell_words(range_def_rule2, "0", "1440", "0", "0"));</script>
		<span id=msg_stime></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.fontcolor));</script>
		<script>
		for ( var i=0; i<font_val.length; i++)
		{
			font_val[i] = font_val[i]+"' style=background-color:"+font_val[i];
		}
		var get_fcolor = "<% gnet_get("gn_font_color"); %>";
		draw_object(O_GUI,SELBOX,"gnet_fcolor","",font_name,font_val,get_fcolor+"' style=background-color:"+get_fcolor);
          </script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.companyname));</script>
                <INPUT maxLength=32 size=32 name="gnet_ctitle" id="gnet_ctitle" value='<% gnet_get("gn_company_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.welcomemsg));</script>
                <INPUT maxLength=64 size=32 name="gnet_wtitle" id="gnet_wtitle" value='<% gnet_get("gn_welcome_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.userfield));</script>
                <INPUT maxLength=32 size=32 name="gnet_utitle" id="gnet_utitle" value='<% gnet_get("gn_username_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.pwdfield));</script>
                <INPUT maxLength=32 size=32 name="gnet_ptitle" id="gnet_ptitle" value='<% gnet_get("gn_password_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.loginbt));</script>
                <INPUT maxLength=32 size=32 name="gnet_loginbt" id="gnet_loginbt" value='<% gnet_get("gn_login_title"); %>'>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.agreetitle));</script>
                <INPUT maxLength=256 size=76 name="_gnet_atitle" id="_gnet_atitle" value='Check here to indicate that you have read and accepted the Acceptance Use Policy'>
		</TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.copyright));</script>
                <INPUT maxLength=256 size=76 name="gnet_copyright" id="gnet_copyright" value='<% gnet_get("gn_copyright_title");%>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.err1));</script>
                <INPUT maxLength=256 size=76 name="gnet_err1" id="gnet_err1" value='<% gnet_get("gn_error_1_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.err2));</script>
                <INPUT maxLength=256 size=76 name="gnet_err2" id="gnet_err2" value='<% gnet_get("gn_error_2_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.declaration));</script>
		<script>
		var _name = new Array(__T(share.enable),__T(share.disable));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"_gnet_dec",_val,_name,"<% gnet_get("gn_declaration_enable"); %>","onclick=sel_dec(this.form)");</script>
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.agreetitle));</script>
                <INPUT maxLength=256 size=76 name="gnet_atitle" id="gnet_atitle" value='<% gnet_get("gn_agree_title"); %>'>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.acceptpolicy),"valign=top");</script>
	        <textarea cols=64 rows=3 maxlength=1024  onkeydown=callNewLine(event,this) name=txt_dec id=txt_dec onkeyup="return CheckMaxlength(this)"><% gnet_get("gn_declaration"); %></textarea>		      
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"8,8,15,61,8",__T(wl.uploadfiles),__T(wl.item)+","+__T(share.sts)+","+__T(wl.filename)+","+__T(wl.selimg)+",&nbsp;","","","","","0,2,0,0,2");
		var tmp=new Array();
		var item_name = new Array(__T(wl.bg),__T(wl.logo));
		var note = new Array("*.jpg, "+spell_words(maxsize, "128")," *.gif, "+spell_words(maxsize, "10"));
		var tmp_fname = new Array(<% gnet_get("gn_bgname"); %>,<% gnet_get("gn_logoname"); %>);
		for(var i=0; i<2; i++)
		{
			tmp[0] = new Array("tditem"+i,item_name[i]);
			if ( tmp_fname[i] == "" ) 
				tmp[1] = new Array("tdst_"+i,__T(def.words),3);
			else
				tmp[1] = new Array("tdst_"+i,__T(wl.customize),3);
			tmp[2] = new Array("tdfname_"+i,tmp_fname[i]);
			tmp[3] = new Array("st_"+i,draw_td(O_VAR,ICONLINE,"img"+i,"<input type=file size=40 name=uploadfile"+i+" id=uploadfile"+i+" onMouseMove=showHint('img"+i+"','div"+i+"',event) onMouseOut=hideHint('div"+i+"')> ( "+note[i]+" )","div"+i));
			tmp[4] = new Array("bt_"+i,draw_object(O_VAR,BT,__T(wl.upload),"e"+i,"BT","to_upload("+i+")")+"&nbsp;&nbsp;"+draw_object(O_VAR,BT,__T(share.del),"f"+i,"BT","to_delfile("+i+")"),3);
			add_row(i,tmp,"","add",2);
			if ( tmp_fname[i] == "" )
				document.getElementById("f"+i).style.display="none";
		}
		document.getElementById("tmsg").style.display="none";		
		</script>
		</TD></TR>	
        </TABLE>
	<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
</TABLE>
</form>
</body></HTML>
