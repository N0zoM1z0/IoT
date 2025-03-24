function before_leave()
{
	if ( http_power == "r" || default_nv=="default_nv" ) 
	{
		alert_result_GUI(1);
		return;
	}
	parent.document.getElementById("GUI_FUN").value = 0;
	parent.document.getElementById("GUI_LOCK").value = 0; 
        var F = document.forms[0];
	if ( CHK_VALUE_AUTO ) 
		change_nv= keep_val(F,skip_name);
	else
		change_nv = get_data(F);
	//alert("default_nv="+default_nv+"\nchange_nv="+change_nv);
	chk_change(default_nv,change_nv);
	if ( parent.document.getElementById("GUI_LOCK").value == 1 )
	{
        	if (typeof arguments[0] != "undefined" && arguments[0] == "cancel" ) 
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1,1)","alert_result_GUI(0)","","yesno");	
		else
			my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","","yesno");	
	}
	else
		alert_result_GUI(1);
}

function alert_result_GUI(val)
{
        var F = document.forms[0];
	var tmp="",tmp2="",tmpfile="";
        tmp = parent.frames['content_area'].location.href;
        tmp2 = tmp.substring(tmp.lastIndexOf("/")+1,tmp.length-tmp.lastIndexOf("/"));
        tmpfile = tmp2.substring(0,tmp2.indexOf(";"));
        alert_result(0);
	if ( val == 1 ) 
	{
      		if (typeof arguments[1] != "undefined" && arguments[1] == 1 ){
		        //get_position(tmpfile,1);

		//	parent.document.getElementById("newpage").value = tmpfile; Fixed bug33101:After Save/Factory default, Cancel button will failed. ( Redirect to blank page)
//			alert(parent.document.getElementById("newpage").value);
		 	document.location.href = goto_link(parent.document.getElementById("newpage").value);
		}else{
			if ( change_cancel_bt == "true" && define_backname != "")  
			{
				var fname = parent.document.getElementById("newpage").value.split(".");
				//alert("fname="+fname);
				F.submit_button.value = fname[0];
				F.backname.value = define_backname;
				F.change_action.value = "gozila_cgi";
				F.submit();
			}else{			
				//alert("3.newpage="+parent.document.getElementById("newpage").value);
		        	//get_position(parent.document.getElementById("newpage").value,1); - made IPv6 cannot expend.
		 		document.location.href = goto_link(parent.document.getElementById("newpage").value);
			}
		}
	}
	else{
		if ( define_backname!= "" ) 
			get_position(define_backname,1);
		else if ( parent.document.getElementById("newpage").value != "" ) 
		        get_position(parent.document.getElementById("newpage").value,1);
	}
}

//CANCEL BUTTON FUNCTION 
function uiDoCancel(F){
	//before_leave();
	//Fixed bug-25952: Try to modify new VLAN100 and click the cancel button , DUT will
        //show broken page.
	if (typeof arguments[1] != "undefined" && arguments[1] == "back" )
		before_leave();
	else
		before_leave("cancel");
}
