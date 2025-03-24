<html>
<head>
<title>Upgrade</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var cert_time = "<% misc_get("fw_cert_time"); %>".split(" ");
var tmpdate = cert_time[0].split("/");
var tmptime = cert_time[1].split(":");
var cm_date = "";
if ( flg_24 == 0 ) 
	cm_date = spell_words(datetime_rule,tmpdate[0],tmpdate[1],tmpdate[2],tmptime[0],tmptime[1],cert_time[2]);
else{
	var tmp_hour = parseInt(tmptime[0],10);
	if ( cert_time[2] == "PM" ) tmp_hour += 12;
	cm_date = spell_words(datetime_rule,tmpdate[0],tmpdate[1],tmpdate[2],tmp_hour,tmptime[1]);
}
function to_sel(F){
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("b1"));
		choose_disable(document.getElementById("fileTxtBox"));
	}else{
		if ( F.sel[0].checked == true )
		{
			document.getElementById("t2").value = __T(mang.generatecert);
			choose_disable(document.getElementById("upload"));
			choose_enable(document.getElementById("t2"));
			choose_disable(document.getElementById("b1"));
			choose_disable(F.file);
		}
		else
		{
			document.getElementById("t2").value = __T(mang.installcert);
			if ( document.getElementById("txtUploadFile").value != "" )
				choose_enable(document.getElementById("t2"));
			else
				choose_disable(document.getElementById("t2"));
			choose_enable(document.getElementById("b1"));
			choose_enable(document.getElementById("upload"));
			choose_enable(F.file);
		}
	}
}

function init()
{
	parent.document.getElementById("hidden_bg").style.display="none";
	var F = document.setup;
	to_sel(F);
	default_nv = keep_val(F,"");
	if ( http_power == "r" ) choose_disable(document.getElementById("t2"));
}



function sel_url(obj)
{
	document.getElementById("txtUploadFile").value = getPath(obj);
	if ( document.getElementById("txtUploadFile").value != "" )
		choose_enable(document.getElementById("t2"));
	else
		choose_disable(document.getElementById("t2"));
	
}

function uiDoCancel()
{
	document.location.href=goto_link("man_cerificate.asp");
}

function send_cert(F)
{
	var len = F.file.value.length;
        var ext = new Array('.','p','e','m');

	F.submit_button.value = "man_cerificate";
	if ( F.sel[0].checked )
	{ 
		F.gui_action.value="Apply";
		F.submit();

	}
	else{
		if (F.file.value != '') {
			var IMAGE = F.file.value.toLowerCase();
			for (var i=0; i < 4; i++)   {
				if (ext[i] != IMAGE.charAt(len-4+i)){
					my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
					return false;
				}        	
			}
			F.action = goto_link("import.cgi");
			F.encoding="multipart/form-data";
			F.submit();

		}
	}
	parent.document.getElementById("hidden_bg").style.display="";
}
</script>
<body onload="init();">
<FORM name=setup id=frm method=post action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=installca>
<input type=hidden name=wait_time value=6>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.certman));</script></TR>
  <TR><TD colspan=2>
	<TABLE class=CONTENT_GROUP cellspacing=0>
	    	<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.importorgencert),"colspan=2");</script></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>document.write(__TC(mang.certlastgenorimport)+cm_date);</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<input type=radio name=sel value=0 checked onclick=to_sel(this.form)>
		<script>Capture(mang.gennewcert);</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<input type=radio name=sel value=1 onclick=to_sel(this.form)>
		<script>Capture(mang.importcert);</script>
		</TD></TR>
	    	<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
	    	<TABLE valign=center><TR><TD style=padding-left:28px"><script>CaptureC(mang.certfile);</script></TD><TD valign=center>
		<div style="position:relative;padding-bottom:20px;">
		<input name=file id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
		<INPUT type=text id=txtUploadFile name=browser size=28 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
		<script>
                draw_object(O_GUI,BT,__T(router.browse),"b1 id=b1 style='position:absolute;left:175px;top:0px'","BT","");
		</script>
		</div>
		</TD></TR></TABLE>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>draw_object(O_GUI,BT,__T(mang.installcert),"t2","BT_L","onClick=send_cert(this.form)");</script>
        	</TD></TR>
	    	<TR><script>draw_td(O_GUI,ISHR,"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,SPACE_DOWN);</script>
		<script>
	draw_object(O_GUI,BT,__T(mang.exadmin),"t3","BT_L","onClick=window.location.href=\"<% get_ca_name("admin"); %>\"");
	draw_object(O_GUI,BT,__T(mang.exclient),"t4","BT_L","onClick=window.location.href=\"<% get_ca_name("client"); %>\"");
		</script>
        </TD></TR>
	</TABLE>
  </TD>
  </TR>
  <TR><TD colspan=2 class=BTTD> 
  <script>draw_object(O_GUI,BT,__T(share.cancel),"c3");
  if ( http_power == "r" ) 
  {
	choose_disable(document.getElementById("c3"));
	choose_disable(document.getElementById("t2"));
	choose_disable(document.getElementById("t3"));
	choose_disable(document.getElementById("t4"));
  }
  chg_layout();
  </script>
  </TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
