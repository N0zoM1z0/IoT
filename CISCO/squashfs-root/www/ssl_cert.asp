<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var idxT=0, idxA=0; idxS=0;
var stflg = "init";
var status_val = new Array(__T(vpn.certnotuploaded),__T(vpn.certuploaded));
function init()
{
	parent.document.getElementById("save_bg").style.display="none";
	create_data("T_data");
	create_data("A_data");
	create_data("S_data");
//	alert("idxT="+idxT+";idxA="+idxA+";idxS="+idxS);
}

function create_data(tbname)
{
	var ename = tbname.charAt(0);
	var idx = 0;
	for(var i=0; i<eval(tbname).length; i++)
	{
		var tmp = new Array();
		tmp[0]=new Array("tdchk"+ename+"_"+idx,"<input type=checkbox id=chk"+ename+"_"+idx+" onclick=chk_click('"+ename+"','"+idx+"')>",3);
		for(j=0; j<eval(tbname)[0].length; j++)
		{
			if ( (ename == 'T') && (j == eval(tbname)[0].length-1) )
				break;
			if ( (ename == 'S') && (j == eval(tbname)[0].length-1) )
			{ 
				tmp[j+1]=new Array("td_id"+j+idx,draw_object(O_VAR,BT,__T(vpn.view),idx,"BT","to_view("+idx+")"));	
			}
			else
				tmp[j+1]=new Array("td_id"+j+idx, eval(tbname)[i][j]); 
		}
		tmp[j+1]=new Array("","&nbsp;",0);
		add_row(idx,tmp,"chk"+ename+"_","inittable"+ename,2);
		idx++;
	}
	 
	if ( ename == 'T' ) 
		idxT = idx;
	else if ( ename == 'A' ) 
		idxA = idx;
	else if ( ename == 'S' ) 
		idxS = idx;
}

function to_view(index)
{
	var F = document.frmcert;
	F.submit_button.value = "cert_data";
	F.change_action.value = "gozila_cgi";
	F.now_idx.value = index;
	F.submit();
}

function to_upload(F, type)
{
	if ( type == "active" && S_data.length == 0 )
	{
        	my_alert(O_GUI,INFO,__T(share.info),__T(vpn.gencsrmsg),"alert_result(0)");
		return;
	} 
	F.submit_button.value = "cert_upload";
	F.change_action.value = "gozila_cgi";
	F.stflg.value=type;
	F.submit();

}

function to_gen_S(F)
{
	F.submit_button.value = "gen_cert";
	F.change_action.value = "gozila_cgi";
//	F.now_idx.value = idx;
//	F.stflg.value = "add";
	F.submit();
}

function chk_click(type,index)
{
	var selcnt=0;
	var now_idx = eval("idx"+type);
	var obj_name ;
	if ( type == 'T' ) obj_name = "e1";
	else if ( type == 'A' ) obj_name = "f1";
	else if ( type == 'S' ) obj_name = "g1";
        for(var i=0; i<now_idx; i++)
        {
	        if ( document.getElementById("chk"+type+"_"+i).checked == true )
		{
                       	//document.getElementById("tr_tableT_"+i).className= "TABLECONTENT_DEL";
			choose_enable(document.getElementById(obj_name));
			selcnt++;
		}
       	}
	if ( selcnt == 0 ) choose_disable(document.getElementById(obj_name));
}

function to_delca(type, F)
{
	var now_idx = eval("idx"+type);
	for(var i=0; i<now_idx; i++)
	{
	        if ( document.getElementById("chk"+type+"_"+i).checked == true )
                       	document.getElementById("tr_tabletable"+type+"_"+i).className= "TABLECONTENT_DEL";
	}
	document.getElementById("tmsgtable"+type).innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgtable"+type).style.display="";
	
}

function get_del_data()
{
	var get_data="";
	for(var i=0; i<T_data.length; i++)
	{
        	if ( document.getElementById("tr_tabletableT_"+i).className == "TABLECONTENT_DEL" ) 
		{
			if ( get_data != "" )  get_data+=" ";
			get_data += T_data[i][T_data[0].length-1];
		}
	}
	document.getElementById("delCA_T").value = get_data;
        if ( document.getElementById("tr_tabletableA_0") != null && 
             document.getElementById("tr_tabletableA_0").className == "TABLECONTENT_DEL" ) 
		document.getElementById("delCA_A").value = 1;
	else
		choose_disable(document.getElementById("delCA_A"));
        if ( document.getElementById("tr_tabletableS_0") != null && 
	     document.getElementById("tr_tabletableS_0").className == "TABLECONTENT_DEL" ) 
		document.getElementById("delCA_S").value = 1;
	else
		choose_disable(document.getElementById("delCA_S"));
		
}

function uiDoSave(F)
{
	get_del_data();
	F.submit_button.value = "ssl_cert";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function export_cert(flg)
{
	if ( flg == 0 ) //ADMIN
	{
		if ( S_data.length > 0 ) 
		{
			window.location.href="<% get_ca_name("admin"); %>";
			return;
		}
	}else{
		if ( A_data.length > 0 ) 
		{
			window.location.href="<% get_ca_name("client"); %>";
			return;
		}
	}
        my_alert(O_GUI,INFO,__T(share.info),__T(msg.nofiledw),"alert_result(0)");
	
}
var T_data = new Array();
<% get_trusted_data(); %>
//T_data[0] = new Array("CN=rv130","CN=rv130","Jan 1 16:14:27 2020 GMT");
//T_data[1] = new Array("CN=CBT","CN=CBT","Jan 9 19:40:48 2020 GMT");

var A_data = new Array();
<% get_active_data(); %>
//A_data[0] = new Array("", "CN=rv180","c9:ff:ef:ab:bc:5c:9d:e6","CN=rv130","Jan 1 16:38:18 2020 GMT");

var S_data = new Array();
<% get_self_data(); %>
//S_data[0] = new Array("test3","Active Self Certificate Uploaded","");
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmcert" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=stflg>
<input type=hidden name=now_idx>
<input type=hidden name=delCA_T id=delCA_T>
<input type=hidden name=delCA_A id=delCA_A>
<input type=hidden name=delCA_S id=delCA_S>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.sslcert));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		var bt_list_T = new Array();
		bt_list_T[0] = new Array("BT","e1",__T(share.del),"to_delca(\"T\",this.form)");
		bt_list_T[1] = new Array("BT","e2",__T(wl.upload),"to_upload(this.form,\"trust\")");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,15,20",__T(vpn.trustcert),"<input type=checkbox name=chk_all_T id=chk_all_T onclick=chkallT(this.form)>,"+__T(vpn.caid)+","+__T(vpn.issuername)+","+__T(vpn.expirytime),"",bt_list_T,"","tableT","2,0,0,0");
		var bt_list_A = new Array();
		bt_list_A[0] = new Array("BT","f1",__T(share.del),"to_delca(\"A\",this.form)");
		bt_list_A[1] = new Array("BT","f2",__T(wl.upload),"to_upload(this.form,\"active\")");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,15,20,10,15",__T(vpn.activecert),"<input type=checkbox name=chk_all_A id=chk_all_A onclick=chkallA(this.form)>,"+__T(filter.sname)+","+__T(vpn.subjectname)+","+__T(router.serialnum)+","+__T(vpn.issuername)+","+__T(vpn.expirytime),"",bt_list_A,"","tableA","2,0,0,0,0,0");
		
		var bt_list_S = new Array();
		bt_list_S[0] = new Array("BT","g1",__T(share.del),"to_delca(\"S\",this.form)");
		bt_list_S[1] = new Array("BT","g2",__T(mang.generatecert),"to_gen_S(this.form)");
		bt_list_S[2] = new Array("BT","g2",__T(mang.exadmin),"onClick=export_cert(0)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,25,10",__T(vpn.selfcert),"<input type=checkbox name=chk_all_S id=chk_all_S onclick=chkallS(this.form)>,"+__T(filter.sname)+","+__T(share.sts)+","+__T(vpn.view),"",bt_list_S,"","tableS","2,0,0,0");

		choose_disable(document.getElementById("e1"));
		choose_disable(document.getElementById("f1"));
		choose_disable(document.getElementById("g1"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(mang.exportcert));</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.downloadroutercert),SPACE_DOWN,SPACE_DOWN);</script>
		<script>draw_object(O_GUI,BT,__T(mang.exclient),"t2","BT_L","onClick=export_cert(1)");</script>
		</TD></TR>
	</TABLE>
      </TD>
  </TR>
<% web_include_file("BT.asp"); %>
  <!--TR><TD colspan=2>
	<script>draw_object(O_GUI,BT,__T(vpn.ipsecst),"t1","BT","goto_status()");</script>
  </TD></TR-->
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
