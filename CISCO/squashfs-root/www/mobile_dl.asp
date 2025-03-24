<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var dldataname=new Array();
var dldatavidpid=new Array();
var chklist = new Array();
<% get_3g_usb_list("dl","buildin_num"); %>;
var buildindataname=new Array();
var buildindatavidpid=new Array();
<% aget_3g_usb_list("static","buildin_num"); %>;
var stflg = "init";
var td_id = new Array("dname");
var idx=0;
var inused_dongle = "<% nvram_get("wwan_vid"); %>"+"_"+"<% nvram_get("wwan_pid"); %>";
function pri_alert_result(val)
{
	var F = document.frmdl;
	alert_result(0);
	if ( val == 1 ) 
	{		
		if (F.file.value != '') {
			F.action = goto_link("importusb.cgi");
			F.encoding = "multipart/form-data";
			F.submit();
		}

		parent.document.getElementById("hidden_bg").style.display="";

	}
}

function to_import(F)
{      
	var len = F.file.value.length;
	var ext = new Array('.','e','n','c');
	var i=0;
	var IMAGE = F.file.value.toLowerCase();
	var pos=F.file.value.lastIndexOf("\\");

	if( parseInt(dl_cnt) >= 5 )
	{
		my_alert(O_GUI,INFO,__T(share.info),__T(wwandl.overflowmsg));	
		return;
	}
	if ( pos == -1 ) pos = F.file.value.lastIndexOf("/");
	fname=F.file.value.substring(pos+1,F.file.value.length);
	/*The file name extension must be ".enc"*/
	for (i=0; i < 4; i++)   {
		if (ext[i] != IMAGE.charAt(len-4+i)){
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
			return false;
		}
	}
	
	/*The file name must be "XXXX_XXXX.bin" ++++++++++++*/
	/*
	len=fname.length;
	if(len !=13 || fname.charAt(4) != "_")
	{
		my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
		return false;
	}
	*/
	//var vid=fname.split("_"); /*vid[0]="XXXX", vid[1]="XXXX.enc"*/
	//var pid=vid[1].split("."); /*pid[0]="XXXX", pid[1]="enc"*/
	/*
	if(!chk_xdigit(vid[0]) || !chk_xdigit(pid[0]))
	{
		my_alert(O_GUI,ERROR,__T(share.errmsg),__T(fwupgrade.wrimage));	
		return false;
	}
	*/
	/*The file name must be "XXXX:XXXX.enc" ------------*/

	/*This file cannot be the same with uploaded dynamic modules +++*/
	/*var modulename= vid[0]+"_"+pid[0];
	for (i=0; i< dldatavidpid.length; i++)
	{
		if( modulename == dldatavidpid[i] )	
		{
			my_alert(O_GUI,WARNING,__T(share.info),__T(wwandl.msgmoduleexist),"pri_alert_result(1)","pri_alert_result(0)","","yesno");	
			return false;
		}
	}
	for (i=0; i< buildindatavidpid.length; i++)
	{
		if( modulename == buildindatavidpid[i] )	
		{
			my_alert(O_GUI,ERROR,__T(share.errmsg),__T(wwandl.msgexist));	
			return false;
		}
	}
	*/
	/*This file cannot be the same with uploaded dynamic modules ---*/


	if (F.file.value != '') {
		F.action = goto_link("importusb.cgi");
		F.encoding = "multipart/form-data";
		F.submit();
	}

	parent.document.getElementById("hidden_bg").style.display="";
}
function sel_url(obj)
{
	document.getElementById("txtUploadFile").value = getPath(obj);
	if ( document.getElementById("txtUploadFile").value != "" )
		choose_enable(document.getElementById("t2"));
	else
		choose_disable(document.getElementById("t2"));
	if ( http_power == "r" ) 
		choose_disable(document.getElementById("t2"));
}
function chk_click(index){
	var chkitem=0;
	if ( dldatavidpid[index] == inused_dongle)
	{
		my_alert(O_GUI,INFO,__T(share.info),dldataname[index]+__T(wwandl.nodel));	
		document.getElementById("chk_"+index).checked = false;
		return;
	}

	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
			chkitem++;
	}
	to_check("chk_",document.getElementById("chk_"+index).checked,index,idx,stflg,td_id,chklist[index]);
	if ( chkitem > 1 ) 
		choose_disable(document.getElementById("t3"));
	if ( http_power == "r" ) 
		choose_disable(document.getElementById("t3"));
}

function chkall(F)
{
	for(var i=0; i<idx; i++)
	{
		if ( dldatavidpid[i] == inused_dongle)
		{
			my_alert(O_GUI,INFO,__T(share.info),dldataname[i]+__T(wwandl.nodel));	
			document.getElementById("chk_all").checked = false;
			return;
		}
	}

	for(var i=0; i<idx; i++)
	{
		if ( F.chk_all.checked == true ) 
			document.getElementById("chk_"+i).checked = true;
		else
			document.getElementById("chk_"+i).checked = false;
		to_check("chk_",document.getElementById("chk_"+i).checked,i,idx,stflg,td_id,chklist[i]);
		
	}
	choose_disable(document.getElementById("t3"));
 
}
function to_del(){
	stflg = "del";
	for(var i=0; i<idx; i++)
	{
		if ( document.getElementById("chk_"+i).checked == true ) 
		{
			del_row(i);
		}
	}
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "mobile_dl.asp";
	uiDoCancel(F,"back");
}

function uiDoSave(F)
{
	var str,data="";
	
	F.wwandl_dellist.value="";
	
	for(var i=0; i<idx; i++)
	{
		if (document.getElementById("chk_"+i).checked == false ) continue;
		if ( stflg == "del" )
		{
			if ( F.wwandl_dellist.value != "" ) F.wwandl_dellist.value+=" ";
			F.wwandl_dellist.value += dldatavidpid[i];
		}
	}
	F.stflg.value = stflg;
	F.submit_button.value = "mobile_dl";
	F.submit_type.value = "wwandl_del";
	F.change_action.value = "gozila_cgi";
	F.submit();
	parent.document.getElementById("hidden_bg").style.display="";
}

function init(){
	parent.document.getElementById("hidden_bg").style.display="none";
	choose_disable(document.getElementById("t2"));
	
	for(var i=0; i<dldataname.length; i++)
	{
		
		var tmp = new Array();
		tmp[0]=new Array("tdchk_"+idx,"<input type=checkbox id=chk_"+idx+" onclick=chk_click('"+idx+"')>");
		tmp[1]=new Array(td_id[0]+idx,dldataname[i]);
		chklist[i] = dldataname[i];
		add_row(idx,tmp,"chk_",stflg,2);
		idx++;
	}
	if ( http_power == "r" ) 
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("t3"));
	}

}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmdl method=post action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=importusb value="">
<input type=hidden name=fname>
<input type=hidden name=stflg>
<input type=hidden name=wwandl_dellist>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wwandl.usbupdate));</script></TR>
  <TR><TD colspan=2> <!--1 tr start-->
		<TABLE class=CONTENT_GROUP cellspacing=8>
			<TR><TD>
				<script>
				draw_td(O_GUI,CREATE_EDIT_TABLE,"5,90",__T(wwandl.dllist),"<input type=checkbox name=chk_all id=chk_all onclick=chkall(this.form)>,"+__T(wwandl.dlname)+"","del","","","","");
				</script>
			</TD></TR>
			<TR><TD><TABLE cellspacing=0> 
				<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.selupfile),""," valign=top");</script>
					<div style="position:relative;">
					<input name=file id=fileTxtBox type=file size=30 style="opacity:0;filter:alpha(opacity:0);z-index:2;position:absolute;" onChange=sel_url(this)>
					<INPUT name=browser type=text id=txtUploadFile size=28 style="position:absolute;background-color:#cecaca;margin:0; height:20px">
					<span id=msg_file style="position:absolute;left:250px"></span>
					<script>
					draw_object(O_GUI,BT,__T(router.browse),"b1 id=b1 style='position:absolute;left:175px;top:0px'","BT","");
					</script>
					</div>
				</TD></TR>
				<TR><script>draw_td(O_GUI,SUBTITLE_M,SPACE_DOWN);
					draw_object(O_GUI,BT,__T(mang.importbt),"t2","BT_L","onClick=to_import(this.form)");
					if ( http_power == "r" ) choose_disable(document.getElementById("t2"));
				    </script>
				</TD></TR></TABLE>
			</TD></TR>
		</TABLE>
  </TD></TR> <!--1 tr end-->
<% web_include_file("BT.asp"); %>
</TABLE>
</FORM>
</div></TABLE></TD></TR>
<!--Start of Connect Successful div --> 
</body></HTML>
