<html>
<head>
<title>TR-069</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var ca_file=new Array();
<% get_root_ca_file();%>
<% get_root_ca_file_index();%>

var nv_cwmp_enable = "<% nvram_get("cwmp_enable"); %>";
var nv_cwmp_loopback_binding = "<% nvram_get("cwmp_loopback_binding"); %>";
var nv_cpe_periodicinform_enable = "<% nvram_get("cpe_periodicinform_enable"); %>";
var nv_cpe_port = "<% nvram_get("cpe_port"); %>";
nv_cpe_port=nv_cpe_port==""?"12345":nv_cpe_port;
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	var F = document.frm_tr069;
	Sel_status(nv_cwmp_enable==""?"0":nv_cwmp_enable,F);
	chk_binding(F);
}

function ViewCA()
{
        SHOW_HIDDEN_TABLE("view_ca_title","CA_TB","view_ca_img",__T("Show Root CA File List"),__T("Hide Root CA File List"));
}

function chk_binding(F)
{
	if ( F._cwmp_loopback_binding.checked == true ) 
	{
		document.getElementById("iface").style.display="";
	}else{
		document.getElementById("iface").style.display="none";
	}
}

function Sel_status(val,F)
{
	if ( val == "1" ) 
		DISABLE_PART(F,"tr_start","tr_end",0);
	else
		DISABLE_PART(F,"tr_start","tr_end",1);
}

function chk_url(objname)
{
	var F = document.frm_tr069
	var tmp = eval("F."+objname).value;
	var pos = tmp.lastIndexOf("\:");
	var url_port = tmp.substring(pos+1,tmp.length);
	var url_tmp = tmp.substring(0, pos);
	var url,tmp1;
	if ( url_port != "" && chk_range(objname,url_port,PORT_START,PORT_TO) == FAIL ) return false;
	if ( url_tmp.substring(0,4) == "http" ) 
	{
		 tmp1 = url_tmp.lastIndexOf("/");
		 url = url_tmp.substring(tmp1+1,url_tmp.length);
	}
	else url = url_tmp;
	if ( !check_ip_domain(url) )
	{
		my_alert(O_VAR,objname,__T("Invalid URL"),"0","msg_"+objname);
		return false;
	}
	return true;
}

function uiDoSave(F)
{
	F.cwmp_loopback_binding.value = 0 ;
        if ( F._cwmp_loopback_binding.checked == true ) 
        {
            if ( F.binding_iface[0].checked == true ) 
            	F.cwmp_loopback_binding.value = 1 ;
            else
                F.cwmp_loopback_binding.value = 2 ;
        }
	for(var i=0; i<3; i++)
	{
		if ( F._ca_enable[i].checked ) 
		{
			F.ca_enable.value = i ;
			break;
		}
	}
	//alert(F.ca_enable.value);
	//return;
	F.submit_button.value = "TR";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
	
}

function rq_download(F)
{
	F.submit_button.value = "TR";
        F.submit_type.value = "requestdownload";
        F.change_action.value = "gozila_cgi";
        F.submit();
}

function Upload_CA(F,i)
{
        var Browser = CheckBrowser();

        if(Browser == "IE")
        {
                var tmp = eval("F.ca_file"+i).value.split("\\");
                var file_name;
                for(var z=0; z<tmp.length; z++)
                {
                        if(z == tmp.length-1)
                        {
                                
                                eval("F.ca_file"+i).value=file_name = tmp[z];
                                F.CA_FileName.value = tmp[z];
                                break;
                        }
                }       
                if(file_name.length >32)
                {
                        alert("This file name is too long!!");
                        return;
                }
        }
        else
        {
                F.CA_FileName.value = eval("F.ca_file"+i).value;
                if(eval("F.ca_file"+i).value.length >32)
                {
                        alert("This file name is too long!!");
                        return;
                }
        }

        if(eval("F.ca_file"+i).value == "")
        {
                alert("This file is empty!!");
                return;
        }
        
        for(var j=0; j<4; j++)
        {
                if(i!=j)
                {
                        choose_disable(eval("F.ca_file"+j));
                }
        }       
        choose_disable(F.Upgrade0);
        choose_disable(F.Upgrade1);
        choose_disable(F.Upgrade2);
        choose_disable(F.Upgrade3);

        F.submit_button.value = "TR";
	F.action = goto_link("ca.cgi");
        F.encoding="multipart/form-data";
        F.submit();     
	parent.document.getElementById("save_bg").style.display="";
}

function to_del(num)
{
        var F=document.frm_tr069;
        F.submit_button.value="TR";
        F.change_action.value="gozila_cgi";
        F.submit_type.value="del_ca_file";
        F.remove_id.value = num;
	parent.document.getElementById("save_bg").style.display="";
        F.submit();
}


</script>
</head>
<body onLoad="init();">
<FORM autocomplete=off id=frm action=apply.cgi name="frm_tr069" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=ca_enable>
<input type=hidden name=remove_id>
<input type=hidden name=cwmp_loopback_binding>
<input type=hidden name=CA_FileName>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T("TR-069"));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Status")+":");</script>
		<script>
		var _name = new Array(__T(share.enabled),__T(share.disabled));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"cwmp_enable",_val,_name,nv_cwmp_enable==""?"0":nv_cwmp_enable,"onClick=Sel_status(this.value,this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=tr_start>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("ACS URL")+":");</script>
		<input name=acs_url id=acs_url size=20 maxlength=63 value='<% nvram_get("acs_url"); %>' onblur=chk_url("acs_url")>
		<span id=msg_acs_url></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("ACS Username")+":");</script>
		<input name=acs_username id=acs_username size=20 maxlength=63 value='<% nvram_get("acs_username"); %>'>
		<span id=msg_acs_username></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("ACS Password")+":");</script>
		<input type=password name=acs_password id=acs_password size=20 maxlength=63 value="<% nvram_get("acs_password"); %>">
		<span id=msg_acs_password></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Connection Request Port")+":");</script>
		<script>
		document.write("<input name=cpe_port id=cpe_port size=20 maxlength=5 onblur=msg_chk_range(this.value,\"cpe_port\",PORT_START,PORT_TO,10,IS_FIELD,0,\"msg_cpe_port\") value="+nv_cpe_port+">");
		</script>
		<span id=msg_cpe_port></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Connection Request Username")+":");</script>
		<input name=cpe_username id=cpe_username size=20 maxlength=63 value='<% nvram_get("cpe_username"); %>'>
		<span id=msg_cpe_username></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Connection Request Password")+":");</script>
		<input type=password name=cpe_password id=cpe_password size=20 maxlength=63 value="<% nvram_get("cpe_password"); %>">
		<span id=msg_cpe_password></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Periodic Inform Enable")+":");</script>
		<script>
		var _name = new Array(__T(share.enabled),__T(share.disabled));
		var _val = new Array("1","0");
		draw_object(O_GUI,RADIO,"cpe_periodicinform_enable",_val,_name,nv_cpe_periodicinform_enable==""?"1":nv_cpe_periodicinform_enable,"onClick=Sel_cpe_period(this.value,this.form)");
		</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Periodic Inform Interval")+":");</script>
		<input name=cpe_periodicinform_interval id=cpe_periodicinform_interval size=20 maxlength=5 onblur=msg_chk_range(this.value,"cpe_periodicinform_interval",PERIODIC_INTERVAL_START,PERIODIC_INTERVAL_TO,10,IS_FIELD,0,"msg_cpe_periodicinform_interval") value='<% nvram_get("cpe_periodicinform_interval"); %>'>
		<span id=msg_cpe_periodicinform_interval></span>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Binding with Loopback interface")+":");</script>
		<script>
		var chkflg = nv_cwmp_loopback_binding==''?'checked':'';
		document.write("<input type=checkbox name=_cwmp_loopback_binding id=_cwmp_loopback_binding onclick=chk_binding(this.form) "+chkflg+"><BR>");
		</script>
		<span id=iface style="display:none">
		<script>
		var _name = new Array(__T("Interface 1"),__T("Interface 2"));
		var _val = new Array("1","2");
		draw_object(O_GUI,RADIO,"binding_iface",_val,_name,nv_cwmp_loopback_binding==""?'1':nv_cwmp_loopback_binding,"");
		</script>	
		</span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Rquest Download")+":");</script>
		<script>
		draw_object(O_GUI,BT,__T("Apply"),"t1","BT","rq_download(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T("Provisioning Code")+":");</script>
		<input name=acs_provosioncode id=acs_provosioncode size=20 maxlength=64>
		<span id=msg_cpe_password></span>
		</td></tr>
		<input type=hidden name=tr_end>
		<tr><SCRIPT>draw_td(O_GUI,ISHR,"colspan=2");</SCRIPT></tr>
		<tr><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_object(O_GUI,TABLE_BT,"view_ca_img","ViewCA()","view_ca_title",__T("Show Root CA File List"));
		</script>
		</TD></TR>
		<tr id=CA_TB style=display:none><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
                <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
		<col width=100px><col width=50px><col width=400px>
		<TR><TD colspan=4 class=TABLETITLE><script>Capture("Root CA File List");</script></TR>
		<script>
			document.write("<TR>");
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST_C,__T("Enable"));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE_C,__T("No."));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T("File Name"));
                        draw_td(O_GUI,TABLETD_SINGLE_LINE,__T("Edit"));
		        document.write("</tr>");
			var f_cnt=0;
			for(var i=0; i<3; i++)
			{
                                if( f_cnt%2 ==0 ) tstyle = "TABLECONTENT_S";
                                else tstyle = "TABLECONTENT_D";
				var chkflg = ca_index==i?"checked":"";
                                document.write("<tr class="+tstyle+" id='tr_table"+i+"'>");
                                document.write("<TD class='TABLECONTENT_TD_MID'>");
				document.write("<input type=radio name=_ca_enable id=_ca_enable value="+i+" "+chkflg+">");
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD_MID'>"+(i+1));
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>");
				if ( ca_file[i]!="")
					document.write(ca_file[i]);
				document.write("</TD>");
                                document.write("<TD class='TABLECONTENT_TD'>");
				document.write("<input type=file name=ca_file"+i+" id=ca_file"+i+" size=15>&nbsp;&nbsp;");
				if ( ca_file[i]!="" )
				//document.write("<img style='cursor:pointer' src='image/alert_critical.png' title='Delete' onclick=to_del("+i+")>&nbsp;&nbsp;");
				document.write("<input type=button name=button1 id='t7' value=\"Delete\" class=BT class=BT onMouseover=bt('t7','move') onMouseout=bt('t7','out') onMousedown=bt('t7','down') onclick=to_del("+(i+1)+")>");
				document.write("<input onclick=Upload_CA(this.form,"+i+") type=button name=button2 id='t6' value=\"Upload_CA\" class=BT onMouseover=bt('t6','move') onMouseout=bt('t6','out') onMousedown=bt('t6','down')>");
				
				document.write("</TD>");
			}
		</script>
		</TABLE>
		</TD></TR>
		<tr><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script></TD></TR>
		
        </TABLE>
<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
