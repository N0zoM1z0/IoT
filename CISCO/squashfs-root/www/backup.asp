<html>
<head>
<title>Backup / Restore Settings</title>
<% web_include_file("filelink.asp"); %>
</head>
<style fprolloverstyle>
.BT_SEED{
 height:22px;
 width:210px;
 background-image:url("/image/BT_Normal.jpg");
 border-style:solid;
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_SEED_Hover
{
 height:22px;
 width:210px;
 background-image:url("/image/BT_Hover.jpg");
 border:1px solid #1fa0d5;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE */
}

.BT_SEED_Press{
 height:22px;
 width:210px;
 background-image:url("/image/BT_Press.jpg");
 border:1px solid #53636a;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
 _padding-bottom:0px; /* for IE*/
}

.BT_SEED_DISABLE{
 height:22px;
 width:210px;
 background-image:url("/image/BT_Disabled.jpg");
 border:1px solid #8e8e8e;
 color:#8e8e8e;
 margin-right:5px;
 padding-bottom:3px; /* for firefox */
}

</style>
<script>
<% web_include_file("base64.js"); %>
var tmptime = "<% misc_get("brs_file_time"); %>".split(";");

var result = 0;
var en_pwd = "<% nvram_get("en_pwd"); %>";
var pwd_len = "<% nvram_get("pwd_minlen"); %>";
function reload_page()
{
	top.location.href =  "<% get_http_prefix(""); %>login.asp";
	//frames['iframe1'].location.href = "<% get_http_prefix(""); %>getconnst.asp"; //always refresh iframe code
}


function regetstatus()
{
	reload_page();
        setTimeout('regetstatus()', 5000);              
}

function init(){
	if (typeof back_running!="undefined" && back_running == "1" )
	{
		setTimeout('regetstatus()',20000);
		return;
	}
/*Add by Mus*/
	choose_enable(document.getElementById("t3"));
/*Add by Mus*/
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("hidden_bg").style.display="none";
	var F = document.frmbackup;
	var cnt=0;
	for(i=0; i<3; i++)
	{
		if ( tmptime[i] == "0" ) 
		{
			choose_disable(F.selopt[i]);
			cnt++;
		}else{
			var t_data = tmptime[i].split(" ");
		        var date_data = t_data[0].split("/");
		        var time_data = t_data[1].split(":");
			if ( flg_24 == 0 ) 
			{
				document.getElementById("filetime"+i).innerHTML = spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1],t_data[2]);
			}else{
				var tmp_hour = parseInt(time_data[0],10);
				if ( t_data[2] == "PM" ) tmp_hour+=12;
				else if ( t_data[2] == "AM" && tmp_hour == 12 ) tmp_hour = "00";
				document.getElementById("filetime"+i).innerHTML = spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],tmp_hour,time_data[1]);
				
			}
		}

	}
	if ( cnt == 3 ) 
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("t3"));
	}
	choose_disable(document.getElementById("t4"));

	document.getElementById("phrase_table").style.display="none";
	if( http_power == "r")
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		choose_disable(document.getElementById("t5"));
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("fileTxtBox"));
		//document.getElementById("table_title").innerHTML = __T(mang.showpassphrase);
		//document.getElementById("tb_img").src = "image/showDis.gif";
	        //document.getElementById("phrase_table").style.display="none";
	}
	ViewTB();
}

function to_copy(F){
	clear_msg("copy_start","msg_copy");
	if ( F.copy_start.selectedIndex == F.copy_end.selectedIndex ) 
	{
		my_alert(O_VAR,"copy_start",__T(msg.invalidbackup),"0","msg_copy");
		return false;	
	}
	F.submit_button.value = "backup";
	if ( F.copy_end.selectedIndex == 0 ) 
	{
		F.submit_button.value = "backup_reboot";
		F.config_type.value = "startup";
		F.gui_action.value="Apply";
		F.cmd_type.value="copy";
		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"reboot_alert_result(1)","reboot_alert_result(0)","","yesno");	
	}else{
		F.submit_type.value="copy";
		F.change_action.value="gozila_cgi";
		parent.document.getElementById("save_bg").style.display="";
		F.submit();
	}
	
}

function to_download(F)
{
	if ( F.selopt[0].checked )
		window.location.href="<% nvram_get("model_name"); %>_startup.cfg";
	else if ( F.selopt[1].checked ) 
		window.location.href="<% nvram_get("model_name"); %>_mirror.cfg";
	else 	
		window.location.href="<% nvram_get("model_name"); %>_backup.cfg";
}

function progress()
{
	var F = document.frmbackup;
	parent.document.getElementById("save_bg").style.display="none";
	parent.document.getElementById("reboot_msg").innerHTML=__T(msg.rebootingdev);
	parent.document.getElementById("hidden_bg").style.display="";
	F.submit_button.value = "backup_reboot";
	F.gui_action.value='Restore';
        F.submit();
	
}

function to_clear(F){
	var tmp_msg = __T(msg.confirmclear);
	if ( F.selopt[0].checked )
		tmp_msg = __T(msg.startupconfirmclear);
	my_alert(O_GUI,WARNING,__T(share.info),tmp_msg,"backup_alert_result(1)","backup_alert_result(0)");
	parent.document.getElementById("a2").focus();
}

function backup_alert_result(val){
	var F = document.frmbackup;
	alert_result(0);
	if ( val == 1 ) 
	{	
		if ( F.selopt[0].checked )
		{
			parent.document.getElementById("save_bg").style.display="";
			timerID = setTimeout('progress()', "2000");
		}
		else 
		{
			F.submit_button.value = "backup";
			if ( F.selopt[1].checked ) 
				F.config_type.value = "mirror";
			else
				F.config_type.value = "backup";
			F.submit_type.value="clear";
			F.change_action.value="gozila_cgi";
			F.submit();
			parent.document.getElementById("save_bg").style.display="";
		}
	}
}

function to_backup(F){
	F.submit_button.value = "backup";
	F.submit_type.value="backup";
	F.change_action.value="gozila_cgi";
	F.submit();	
	parent.document.getElementById("save_bg").style.display="";
}

function to_upload(F){
	var len = F.file.value.length;
	var ext = new Array('.','c','f','g');
	if (F.file.value == '') {
		my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
		return false;
	}
	clear_msg("txtUploadFile","msg_file");
	var IMAGE = F.file.value.toLowerCase();
	for (var i=0; i < 4; i++)   {
		if (ext[i] != IMAGE.charAt(len-4+i)){
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
			return false;
		}
	}

	if (F.file.value != '') {
		F.action = goto_link("restore.cgi");
		F.encoding = "multipart/form-data";
		if ( F.config[0].checked )
		{
			F.submit_button.value = "backup_reboot";
			F.gui_action.value = "Apply";
			parent.document.getElementById("reboot_msg").innerHTML = __T(msg.upgrade);
			choose_disable(document.getElementById("restore_backup"));
			my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"reboot_alert_result(1)","reboot_alert_result(0)","","yesno");	
		}
		else
		{

			choose_disable(document.getElementById("restore_startup"));
			F.submit_button.value = "backup";
			parent.document.getElementById("save_bg").style.display="";
			F.submit();
		}
	}
}

function reboot_alert_result(val){
        alert_result(0);
        var F = document.frmbackup;
        if ( val == 1 ) 
        {
                parent.document.getElementById("hidden_bg").style.display="";
                F.submit();
        }
}

function sel_url(obj) {
        document.getElementById("txtUploadFile").value = getPath(obj); 
	if ( document.getElementById("txtUploadFile").value.length > 5 ) 
		choose_enable(document.getElementById("t4"));
} 

function CHK_SELOPT(idx)
{
	if( http_power == "r")return;

	if ( idx == 1 )
		choose_disable(document.getElementById("t3"));
	else
		choose_enable(document.getElementById("t3"));
}

function ViewTB()
{
	if ( document.getElementById("tb_img").src.indexOf("image/showDis") != -1 ) return;
        SHOW_HIDDEN_TABLE("table_title","phrase_table","tb_img",__T(mang.showpassphrase),__T(mang.hidepassphrase));
}

function to_save(F)
{

	if ( en_pwd == "1" && parseInt(pwd_len,10) >0 && result < 5 ) 
	{
		my_alert(O_VAR,"_backup_passphrase",__T(msg.pwdstreng),"0","msg_admin_new_pwd","down");
		return false;
	}
	
	if(F._backup_passphrase.value.length == 0) 
	{
		my_alert(O_VAR,"_backup_passphrase",__T(msg.pwdstreng),"0","msg_admin_new_pwd","down");
		return false;
	}

	if(F._backup_passphrase.value == "<% nvram_invmatch("backup_passphrase","","d6nw5v1x2pc7st9m"); %>") 
	{
		my_alert(O_VAR,"_backup_passphrase",__T(msg.pwdstreng),"0","msg_admin_new_pwd","down");
		return false;
	}

        my_alert(O_GUI,WARNING,__T(share.info),__T(mang.passphrasewarn),"pass_alert_result(1)","pass_alert_result(0)");  
}

function pass_alert_result(val)
{
	alert_result(0);
	if(val == 1)
	{
		var F = document.frmbackup;
		F.backup_passphrase.value = encode64(F._backup_passphrase.value);	
		F.change_action.value="gozila_cgi";
		F.submit_type.value="save_seed";
		F.submit();
		parent.document.getElementById("save_bg").style.display="";
	}
	
}

function to_restore(F)
{
        F.submit_type.value="restore_seed";
        F.change_action.value="gozila_cgi";
        F.submit();
        parent.document.getElementById("save_bg").style.display="";
}

function check_pwd(obj_val,id)
{
	clear_msg("_backup_passphrase","msg_admin_new_pwd");
	removed_pwd_result(id);	
	document.getElementById("pwdtb"+id).style.display="none";
	if ( (en_pwd == "1") && (pwd_len >= 1) ) 
	{
		var pwd_class = "<% nvram_get("pwd_minclass"); %>";
		result = count_pwd(obj_val,pwd_len,pwd_class);
		if ( result > 0 ) 
			document.getElementById("pwdtb"+id).style.display="";
	
		show_pwd_result(result,id);
	}
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmbackup method=<% get_http_method(); %> action=apply.cgi>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<input type=hidden name=submit_button value=backup>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=config_type>
<input type=hidden name=cmd_type>
<input type=hidden name=backup_passphrase>
<input type=hidden name=restore_startup id=restore_startup>
<input type=hidden name=restore_backup id=restore_backup>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.bkrestoreset));</script></TR>
  <TR><TD colspan=2>
	<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t2",__T(mang.downloadbt),"to_download(this.form)");
		bt_list[1] = new Array("BT","t3",__T(mang.clearbt),"to_clear(this.form)");
   		draw_td(O_GUI,CREATE_EDIT_TABLE,"8,20,20",__T(mang.configdownloadclear),__T(share.sel)+","+__T(mang.config)+","+__T(logemail.schtime),"",bt_list,"","","2,0,0");
		var dataname = new Array(__T(mang.startupconfig),__T(mang.mirrorconfig),__T(mang.backupconfig));
		var optval = new Array("0","1","2");
		var chkflg="";
		var tmp = new Array();
		for(var i=0; i<dataname.length; i++)
		{
			chkflg = "";
			if( i == 0 ) chkflg = "checked";
			tmp[0] = new Array("tdsel"+i,"<input type=radio value="+optval[i]+" name=selopt "+chkflg+" onclick=CHK_SELOPT("+i+")>",3);
			tmp[1] = new Array("tdcname"+i,dataname[i]);
			tmp[2] = new Array("filetime"+i,"");
			tmp[3] = new Array("","&nbsp;");
			add_row(i,tmp,"","add",2);
		}
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.configupload));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.configupload));</script>
		<input type=radio name=config value=0 checked> <script>Capture(mang.startupconfig)</script>
		<input type=radio name=config value=1> <script>Capture(mang.backupconfig)</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.selupfile));</script>
		<div style="position:relative">
                <input name=file id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<script>
		document.write("<INPUT type=text id=txtUploadFile name=browser size=");
		if ( Browser == "IE" ) document.write("28");
		else document.write("20");
		document.write(" style=\"position:absolute;background-color:#cecaca;margin:0; height:20px\">");
		</script>
		<span id=msg_file style="position:absolute;left:250px"></span>
                <script>
		if ( Browser == "IE" ) 
		{
	                draw_object(O_GUI,BT,__T(router.browse),"t6 id=t6 style='position:absolute;left:175px;top:0px'","BT","");
		}
		else
		{
	                draw_object(O_GUI,BT,__T(router.browse),"t6 id=t6 style='position:absolute;left:140px;top:0px'","BT","");
		}
		</script>
                </div>
		</TD></TR>
		<TR><TD colspan=2>&nbsp;</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<script>
		draw_object(O_GUI,BT,__T(mang.starttoupload),"t4","BT_L","to_upload(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.configcopy));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.copy));</script>
		<script>
			var name_list = new Array(__T(mang.startupconfig),__T(mang.backupconfig),__T(mang.mirrorconfig));
			var val_list = new Array("startup","backup","mirror");
			draw_object(O_GUI,SELBOX,"copy_start","id=copy_start",name_list,val_list);
			document.write(" "+__T(share.copyto)+" ");
			var name_list1 = new Array(__T(mang.startupconfig),__T(mang.backupconfig));
			var val_list1 = new Array("startup","backup");
			draw_object(O_GUI,SELBOX,"copy_end","id=copy_end",name_list1,val_list1);
		</script>
		<span id=msg_copy></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
                <script>
                draw_object(O_GUI,BT,__T(mang.starttocopy),"t5","BT_L","to_copy(this.form)");
                </script>
                </TD></TR>

		<!-- passphrase start -->
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2 "+SPACE_DOWN);</script>
		<script>draw_object(O_GUI,TABLE_BT,"tb_img","ViewTB()","table_title",__T(mang.showpassphrase));	</script>
		<TR id=phrase_table><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>

		<TABLE cellspacing=0 width=100%>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.advset),"");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"");Capture(mang.passphrase);</script></TD></TR>
		</TABLE>

		<TABLE style=table-layout:auto cellspacing=0 width=60%>
		<TR><TD colspan=3 style=padding-left:5px><SPAN id=msg_admin_new_pwd></SPAN></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"width=60px");</script>
		<input type=password size=20 maxlength=64 name=_backup_passphrase id=_backup_passphrase onKeyUp=check_pwd(this.value,"_admin") onblur=check_pwd(this.value,"_admin") value='<% nvram_invmatch("backup_passphrase","","d6nw5v1x2pc7st9m"); %>'>
		</TD>
		<TD width=70px><script>draw_td(O_GUI,PWDLINE,"_admin");</script>
		</TR>

		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=3 "+SPACE_DOWN);</script>
                <script>
		draw_object(O_GUI,BT,__T(mang.save),"t7","BT","to_save(this.form)");
		draw_object(O_GUI,BT,__T(mang.restoreseed),"t8","BT_SEED","to_restore(this.form)");
		if ( http_power == "r" ) 
		{
			choose_disable(document.getElementById("t7"));
			choose_disable(document.getElementById("t8"));
		}
		</script>
		</TD></TR>
		</TABLE>

		</TD></TR></TD></TR>
		<!-- passphrase end -->
	
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.configcopy));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
                <script>
                draw_object(O_GUI,BT,__T(mang.starttobackup),"t6","BT_L","to_backup(this.form)");
                </script>
                </TD></TR-->
		<script> 
		chg_layout();
		if ( document.getElementById("tmsg") )
                	document.getElementById("tmsg").innerHTML = "";
		</script>		
        </TD></TR>
	</TABLE>
  </TD>
  </TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
