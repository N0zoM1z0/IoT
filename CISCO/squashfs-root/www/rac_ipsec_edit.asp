<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var int_val= new Array("hmac-sha1","hmac-md5");
var auto_int_val= new Array("hmac_sha1","hmac_md5");
var int_len= new Array(20,16);
//var int_val= new Array("sha1","sha2_256","sha2_384","sha2_512","md5");
//var int_len= new Array(20,32,48,64,16);
var dh_val= new Array("768","1024","1536");
//var enc_val= new Array("3des","none","des","aes128","aes192","aes256");
//var enc_len= new Array(24,256,8,16,24,32);
//no support none
var enc_val= new Array("3des-cbc","des-cbc","aes-cbc","aes192-cbc","aes256-cbc");
var auto_enc_val= new Array("3des","des","aes","aes192","aes256");
var enc_len= new Array(24,8,16,24,32);
//var lr_val= new Array("1","2","3","4"); // not support any rang
var lr_val= new Array("0","1");
var define_backname="rac_vpn_adv.asp";
var ike_name= new Array();
var ike_val= new Array();
var change_cancel_bt="true";
<% get_rac_ike_policy("name"); %>
function BBB(st,pname,ptype,ltype,lstart,lsubnet,rtype,rstart,rsubnet,endpoint_val,spi_income,spi_outgo,enc,enc_keyin,i_int,int_keyin,sa_life,esp,ah,en_pfs,iname,vpnidx)
{
	this.st=st;
	this.pname = pname;
	this.ptype = ptype;
	this.ltype=ltype;
	this.lstart=lstart;
	this.lsubnet=lsubnet;
	this.rtype=rtype;
	this.rstart=rstart;
	this.rsubnet=rsubnet;
	this.endpoint_val=endpoint_val;
	this.spi_income=spi_income;
	this.spi_outgo=spi_outgo;
	this.enc=enc;
	this.enc_keyin=enc_keyin;
	this.i_int=i_int;
	this.int_keyin=int_keyin;
	this.sa_life=sa_life;
	this.esp=esp;	
	this.ah=ah;
	this.en_pfs=en_pfs;
	this.iname=iname;
	this.vpnidx=vpnidx;
}
var ipsec_entry = new Array();
<% get_rac_ipsec_policy(); %>
//ipsec_entry[0]=new BBB('','test','0','0','1.1.1.1','1.1.1.1','0','2.2.2.2','','','','','','','','','28800','aes','hmac_sha1','1','1','1');

var sidx="<% nvram_gozila_get("ipsec_selidx"); %>";
if ( sidx == "" ) sidx = "0"
if ( parseInt(sidx,10) > 0 ) sidx = parseInt(parseInt(sidx,10),10);
var back_bt = "true";
function refresh_page()
{
	alert_result(0);
	var F = document.frmipsec;
	F.submit_button.value = "rac_ipsec_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}
function to_back(F)
{
	parent.document.getElementById("newpage").value = "rac_vpn_adv.asp";
	uiDoCancel(F);
}

function init()
{
	var F = document.frmipsec;
	var idx = 0;

	sel_type(F);

	choose_disable(F.ipsec_local_subnet);
	choose_disable(F.ipsec_remote_subnet);
	choose_disable(F.ipsec_pfs_group);

	if ( F.stflg.value == "edit" ) 
	{
		for(var i=0; i<ipsec_entry.length; i++)
		{
			if(ipsec_entry[i].vpnidx == sidx)
			{
				idx = i;
				break;
			}
			else
				idx = 0;
		}
		choose_disable(F.ipsec_local_start);
		//choose_disable(F.ipsec_local_end);
		choose_disable(F.ipsec_remote_start);
		//choose_disable(F.ipsec_remote_end);

		F.rac_ipsec_policy_name.value = ipsec_entry[idx].pname;
		F.ipsec_policy_type.selectedIndex = parseInt(ipsec_entry[idx].ptype,10);
		sel_type(F);
//		F.ipsec_endpoint_type.selectedIndex = parseInt(ipsec_entry[idx].endpoint_type,10)-1;
		F.ipsec_endpoint_value.value = ipsec_entry[idx].endpoint_val;
//	 	if ( ipsec_entry[idx].netbios == "1" ) 
//			F.ipsec_netbios.checked = true;
		F.ipsec_local_type.selectedIndex = ipsec_entry[idx].ltype;
		F.ipsec_local_start.value = ipsec_entry[idx].lstart;
		if ( ipsec_entry[idx].ltype != "0" )	
			F.ipsec_local_subnet.value = ipsec_entry[idx].lsubnet;
		sel_lr_type("local");
		F.ipsec_remote_type.selectedIndex = ipsec_entry[idx].rtype;
                F.ipsec_remote_start.value = ipsec_entry[idx].rstart;
		if ( ipsec_entry[idx].rtype != "0" ) 
                        F.ipsec_remote_subnet.value = ipsec_entry[idx].rsubnet;
                sel_lr_type("remote");
		if ( F.ipsec_policy_type.selectedIndex == 0 ){ //AUTO
			F.ipsec_sa_lifetime.value = ipsec_entry[idx].sa_life;
			//F.ipsec_sa_type.selectedIndex = parseInt(ipsec_entry[idx].sa_type,10);
			for(var j=0; j<auto_enc_val.length; j++)
			{
				if ( ipsec_entry[idx].esp == auto_enc_val[j] ) 
				{
					F.auto_ipsec_enc.selectedIndex = j;
					break;
				}
			}
			for(var j=0; j<auto_int_val.length; j++)
			{
				if ( ipsec_entry[idx].ah == auto_int_val[j] ) 
				{
					F.auto_ipsec_int.selectedIndex = j;
					break;
				}
			}
			if ( ipsec_entry[idx].en_pfs == "1" ) 
			{
				F.ipsec_pfs_enable.checked = true;
				for(var i = 0; i<dh_val.length; i++)
				{
					if(ipsec_entry[idx].pfs_group == dh_val[i])
					{
						F.ipsec_pfs_group.selectedIndex = i;
						break;		
					}
				}
				
			}
			for(var j=0; j<ike_val.length; j++)
			{
				if (ipsec_entry[idx].iname == ike_val[j]) 
				{
					F.ipsec_ike_policy_name.selectedIndex = j;
					break;
				}
			}
		}else{//Manual
			F.ipsec_spi_income.value = ipsec_entry[idx].spi_income;	
			F.ipsec_spi_outgo.value = ipsec_entry[idx].spi_outgo;
			for(var j=0; j<enc_val.length; j++)
			{
				if ( ipsec_entry[idx].enc == enc_val[j] ) 
				{
					F.manual_ipsec_enc.selectedIndex = j;
					break;
				}
			}
			//if ( F.manual_ipsec_enc.selectedIndex != 1 )//none 
			//{
				F.ipsec_enc_keyin.value = ipsec_entry[idx].enc_keyin;
			//	F.ipsec_enc_keyout.value = ipsec_entry[idx].enc_keyout;
			//}	
			//sel_enc(F);
			for(var j=0; j<int_val.length; j++)
			{
				if ( ipsec_entry[idx].i_int == int_val[j] ) 
				{
					F.manual_ipsec_int.selectedIndex = j;
				}
			}
			F.ipsec_int_keyin.value = ipsec_entry[idx].int_keyin;
			//F.ipsec_int_keyout.value = ipsec_entry[idx].int_keyout;
		}
		chk_enpfs(F);

	}
	else
	{
		F.auto_ipsec_enc.selectedIndex = 2;
		F.auto_ipsec_int.selectedIndex = 0;
		F.manual_ipsec_enc.selectedIndex = 2;
		F.manual_ipsec_int.selectedIndex = 0;
	}
	default_nv = keep_val(F,"");
}

function sel_type(F)
{
	if ( F.ipsec_policy_type.selectedIndex == 0 ) 
	{
		//choose_disable(F.ipsec_endpoint_type);
		//choose_disable(F.ipsec_endpoint_value);
	        DISABLE_PART(F,"start_manual","end_manual",1);
	        DISABLE_PART(F,"start_auto","end_auto",0);
	}else{
		//choose_enable(F.ipsec_endpoint_type);
		//choose_enable(F.ipsec_endpoint_value);
	        DISABLE_PART(F,"start_manual","end_manual",0);
	        DISABLE_PART(F,"start_auto","end_auto",1);
	}
}

function chk_enpfs(F)
{
	if ( F.ipsec_pfs_enable.checked == true ) 
		choose_enable(F.ipsec_pfs_group);
	else
		choose_disable(F.ipsec_pfs_group);

}

function chk_ip(obj_id)
{
	var F = document.frmipsec;
	clear_msg(obj_id,"msg_"+obj_id);
	if ( obj_id.indexOf("subnet") != -1 ) 
	{
		if ( !valid_mask(F,obj_id,ZERO_NO,"msg_"+obj_id) ) return false;
	}else{
		if ( ( obj_id.indexOf("local")!= -1 && 
		       F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1") || 
		     ( obj_id.indexOf("remote")!= -1 && 
		       F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "1") )
		{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE3,MASK_OK) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
			
		}else{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE1,MASK_NO) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
		}
	}
	return true;
}

function chk_blank(obj_id)
{
	var F = document.frmipsec;
	clear_msg(obj_id,"msg_"+obj_id);
	if ( document.getElementById(obj_id).value == "" ) 
	{
		my_alert(O_VAR,obj_id,__T(msg.notblank),"0","msg_"+obj_id);
		return false;
	}	
	return true;
}

function chk_spi(obj_id)
{
	var F = document.frmipsec;
	var spi_value=0;
	var temp_spi=0;

	clear_msg(obj_id,"msg_"+obj_id);

	if ( !chk_blank(obj_id) || document.getElementById(obj_id).value == "0x" ) 
	{
		my_alert(O_VAR,obj_id,__T(msg.notblank),"0","msg_"+obj_id);
		return false;
	}
	spi_value = document.getElementById(obj_id).value;
	if(spi_value.charAt(0) != "0" || spi_value.charAt(1) != "x")
	{
		my_alert(O_VAR,obj_id,__T(msg.illegal),"0","msg_"+obj_id);
		return false;
	}
	temp_spi = spi_value.substring(2,spi_value.length);

	if(temp_spi.search(/^[A-Fa-f0-9]/i) == -1)
	{
		my_alert(O_VAR,obj_id,__T(msg.illegal),"0","msg_"+obj_id);
		return false;
	}

	return true;
}

function chk_keylen(val,max_len,th)
{
	var val_len = val.length;
	if ( val_len != parseInt(max_len,10)) return FAIL;
	return PASS;
	
}

function my_chk_keylen(obj_val,obj_id,max_len,span_id,th){
	clear_msg(obj_id,span_id);
	if ( th == "undefined " ) th = 10;
	if ( chk_keylen(obj_val,max_len,th) == FAIL ) 
	{
		parent.document.getElementById("obj_id").value = span_id;
		//my_alert(O_VAR,obj_id,__T("Invalid length ")+obj_val.length+__T(", need to input key len ")+max_len,"0",span_id);
		my_alert(O_VAR,obj_id,spell_words(ipsec_key_rule,max_len),"0",span_id);
		return false;
	}
	return true;
}
function chk_name(obj_id)
{
	var returnmsg = valid_meaning_id_name(MEANING_NAME,document.getElementById(obj_id).value,ZERO_NO|SPACE_NO);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,obj_id,returnmsg,"0","msg_"+obj_id);
		return false;
	}
	if ( chk_chartype(document.getElementById(obj_id).value,ISCHAR) == FAIL ) 
	{
		my_alert(O_VAR,obj_id,__T(msg.hostnameformat1),"0","msg_"+obj_id);
		return false;
	}
	return true;
}

function before_check(F)
{
	var errflg = 0 ;
	if ( !chk_name("rac_ipsec_policy_name") ) errflg++;
	if ( !chk_ip("ipsec_local_start") ) errflg++;
	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1" )
	     if ( !chk_ip("ipsec_local_subnet") ) errflg++;
	if ( !chk_ip("ipsec_remote_start") ) errflg++;
	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "1" )
	     if ( !chk_ip("ipsec_remote_subnet") ) errflg++;
	if ( F.ipsec_policy_type.selectedIndex == 0 ) //AUTO
	{
		if ( !chk_blank("ipsec_sa_lifetime") ) errflg++;
		if ( !msg_chk_range(F.ipsec_sa_lifetime.value,"ipsec_sa_lifetime",30,86400,10,IS_FIELD,0,"msg_ipsec_sa_lifetime") ) 
			errflg++;
		if(F.ipsec_ike_policy_name.selectedIndex < 0) 
		{
			my_alert(O_VAR,"ipsec_ike_policy_name",__T(vpn.ipsecikemsg),"0","msg_ipsec_ike_policy_name");
			errflg++;
		}
	}
	else //Manual
	{
		var key_type = F.manual_ipsec_enc.selectedIndex;
		var key_val = "";
		clear_msg("ipsec_enc_keyin","msg_ipsec_enc_keyin");
		clear_msg("ipsec_enc_keyout","msg_ipsec_enc_keyout");
		//if ( !chk_ip("ipsec_endpoint_value") ) errflg++;
		if ( !chk_spi("ipsec_spi_income") || F.ipsec_spi_income.value == "0x" ) errflg++;
		if ( !chk_spi("ipsec_spi_outgo") || F.ipsec_spi_outgo.value == "0x" ) errflg++;
		if ( !chk_blank("ipsec_enc_keyin") ) errflg++;
		if ( !chk_blank("ipsec_int_keyin") ) errflg++;
		if ( !chk_fqdn(F,"ipsec_endpoint_value","ipsec_endpoint_type") ) errflg++;
		
		key_len = enc_len[F.manual_ipsec_enc.selectedIndex];
		/* for none
		if(key_type == 1) 
		{
			//clear_msg("ipsec_enc_keyin","msg_ipsec_enc_keyin");
			key_val = F.ipsec_enc_keyin.value;
			if((key_val.length <= 0) || (key_val.length > key_len))
			{
				my_alert(O_VAR,"ipsec_enc_keyin",spell_words(range_rule,0,key_len),"0","msg_ipsec_enc_keyin");
				errflg++;
			}
		}
		else */if(!my_chk_keylen(F.ipsec_enc_keyin.value,"ipsec_enc_keyin",key_len,"msg_ipsec_enc_keyin")) 
			errflg++;
		/* for none
		if(key_type == 1) 
		{
			//clear_msg("ipsec_enc_keyout","msg_ipsec_enc_keyout");
			key_val = F.ipsec_enc_keyin.value;
			if((key_val.length <= 0) || (key_val.length > key_len))
			{
				my_alert(O_VAR,"ipsec_enc_keyin",spell_words(range_rule,0,key_len),"0","msg_ipsec_enc_keyin");
				errflg++;
			}
		}
		else */
		//	if(!my_chk_keylen(F.ipsec_enc_keyout.value,"ipsec_enc_keyout",key_len,"msg_ipsec_enc_keyout")) 
		//	errflg++;
		/*
		if(key_type == 0) //3des
		{
			for(var i = 0; i<2; i++) //check 3des key rule
			{
				if(i == 0)
					key_val = F.ipsec_enc_keyin.value;
				else
					key_val = F.ipsec_enc_keyout.value;

				var k1 = key_val.substring(0,7);
				var k2 = key_val.substring(8,15);
				var k3 = key_val.substring(16,24);
					
				if((k1 == k2) || (k2 == k3))
				{
					//clear_msg("ipsec_enc_keyin","msg_ipsec_enc_keyin");
					if(i == 0)
						my_alert(O_VAR,"ipsec_enc_keyin",__T(vpn.ipsecmsg1),"0","msg_ipsec_enc_keyin");
					else
						my_alert(O_VAR,"ipsec_enc_keyout",__T(vpn.ipsecmsg2),"0","msg_ipsec_enc_keyout");
					errflg++;
				} 	
			}
		}*/

		key_len = int_len[F.manual_ipsec_int.selectedIndex];
		if(!my_chk_keylen(F.ipsec_int_keyin.value,"ipsec_int_keyin",key_len,"msg_ipsec_int_keyin")) 
			errflg++;

	//	if(!my_chk_keylen(F.ipsec_int_keyout.value,"ipsec_int_keyout",key_len,"msg_ipsec_int_keyout")) 
	//		errflg++;
	}
	for(var i=0; i<ipsec_entry.length; i++)
        {
                if ( F.stflg.value=="edit" && i == sidx ) continue;
                if ((F.stflg.value!="edit") && (ipsec_entry[i].pname == F.rac_ipsec_policy_name.value ) )
                {
                        my_alert(O_VAR,"rac_ipsec_policy_name",__T(msg.nameexist),"0","msg_rac_ipsec_policy_name");
                        errflg++;
                }
        }
	
	if ( errflg > 0 ) return false;
	return true;
		
}

function uiDoSave(F)
{
	if ( !before_check(F) ) return false;
	if ( F.ipsec_policy_type.selectedIndex == 0 ) 
		F.ipsec_enc.value = F.auto_ipsec_enc[F.auto_ipsec_enc.selectedIndex].value;
	else
		F.ipsec_enc.value = F.manual_ipsec_enc[F.manual_ipsec_enc.selectedIndex].value;
	if ( F.ipsec_policy_type.selectedIndex == 0 ) 
		F.ipsec_int.value = F.auto_ipsec_int[F.auto_ipsec_int.selectedIndex].value;
	else
		F.ipsec_int.value = F.manual_ipsec_int[F.manual_ipsec_int.selectedIndex].value;
	choose_enable(F.rac_ipsec_policy_name);
	/*
	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1" ){ 
		choose_enable(F.ipsec_local_subnet);
		F.ipsec_local_subnet.value = "255.255.255.255";
	}
	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "1" ){ 
		choose_enable(F.ipsec_remote_subnet);
		F.ipsec_remote_subnet.value = "255.255.255.255";
	}*/
	F.gui_action.value = "Apply";
	F.submit_button.value="rac_vpn_adv";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function sel_lr_type(tname)
{
	var F = document.frmipsec;
	clear_msg("ipsec_"+tname+"_start","msg_ipsec_"+tname+"_start");
	//clear_msg("ipsec_"+tname+"_end","msg_ipsec_"+tname+"_end");
	clear_msg("ipsec_"+tname+"_subnet","msg_ipsec_"+tname+"_subnet");
/*
	if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "1" ) //Any
	{
		choose_disable(eval("F.ipsec_"+tname+"_start"));
		choose_disable(eval("F.ipsec_"+tname+"_end"));
		choose_disable(eval("F.ipsec_"+tname+"_subnet"));
	}else 
*/
	if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "0" ) //Single
	{
		choose_enable(eval("F.ipsec_"+tname+"_start"));
		//choose_disable(eval("F.ipsec_"+tname+"_end"));
		choose_disable(eval("F.ipsec_"+tname+"_subnet"));
		eval("F.ipsec_"+tname+"_subnet").value = "";
	}
/*
	else if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "3" ) //Range
	{
		choose_enable(eval("F.ipsec_"+tname+"_start"));
		choose_enable(eval("F.ipsec_"+tname+"_end"));
		choose_disable(eval("F.ipsec_"+tname+"_subnet"));
	}
*/
	else if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "1" ) //Subnet
	{
		choose_enable(eval("F.ipsec_"+tname+"_start"));
		//choose_disable(eval("F.ipsec_"+tname+"_end"));
		choose_enable(eval("F.ipsec_"+tname+"_subnet"));
	}

}

function to_view(F)
{	
	var F = document.frmipsec;
        F.ike_selidx.value = F.ipsec_ike_policy_name[F.ipsec_ike_policy_name.selectedIndex].value;
        F.ike_stflg.value = "edit";
        F.submit_button.value = "ike_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();		
}
/*
function sel_enc(F)
{
	if ( F.manual_ipsec_enc.selectedIndex == 1 ) 
	{
		choose_disable(F.ipsec_enc_keyin);
		choose_disable(F.ipsec_enc_keyout);
	}else{
		choose_enable(F.ipsec_enc_keyin);
		choose_enable(F.ipsec_enc_keyout);
	}
	
}
*/

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmipsec method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ipsec_enc>
<input type=hidden name=ipsec_int>
<input type=hidden name=backname value="<% nvram_gozila_get("backname"); %>">
<input type=hidden name=stflg value="<% nvram_gozila_get("ipsec_stflg"); %>">
<input type=hidden name=selidx value="<% nvram_gozila_get("ipsec_selidx"); %>">
<input type=hidden name=ipsec_stflg value="<% nvram_gozila_get("ipsec_stflg"); %>">
<input type=hidden name=ipsec_selidx value="<% nvram_gozila_get("ipsec_selidx"); %>">
<input type=hidden name=ike_stflg>
<input type=hidden name=ike_selidx>
<input type=hidden name=ipsec_endpoint_type value="1">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.ipsecpolicy),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.editvpnconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(filter.policyname));</script>
		<input name=rac_ipsec_policy_name id=rac_ipsec_policy_name size=20 maxlength=32 onblur=chk_blank("rac_ipsec_policy_name")>
		<span id=msg_rac_ipsec_policy_name></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ptype));</script>
		<script>
		var _name = new Array(__T(mang.autop),__T(mang.manualp));
		var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"ipsec_policy_type","id=ipsec_policy_type onchange=sel_type(this.form)",_name,_val);
		</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteep));</script>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
                var _val = new Array("1","2");
                draw_object(O_GUI,SELBOX,"ipsec_endpoint_type","id=ipsec_endpoint_type",_name,_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input name=ipsec_endpoint_value id=ipsec_endpoint_value size=20 maxlength=255 onblur=chk_fqdn(this.form,"ipsec_endpoint_value","ipsec_endpoint_type")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com"));</script>
		<span id=msg_ipsec_endpoint_value></span>
		</TD></TR-->	
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC("NETBIOS"));</script>
		<input type=checkbox name=ipsec_netbios id=ipsec_netbios> <script>Capture(share.enable)</script>
		</TD></TR-->
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.localtraffic),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.lip));</script>
		<script>
	        //var _name= new Array(__T(filter.any),__T(def.range),__T("Single"),__T("Subnet"));
	        var _name= new Array(__T(vpn.single),__T(vpn.subnet)); ;
		draw_object(O_GUI,SELBOX,"ipsec_local_type","id=ipsec_local_type onchange=sel_lr_type('local')",_name,lr_val);
		</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.startaddr));</script-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
		<input name=ipsec_local_start id=ipsec_local_start size=20 maxlength=15 onblur=chk_ip("ipsec_local_start");cal_submask(this.from,"ipsec_local_start","ipsec_local_subnet",document.frmipsec.ipsec_local_type[document.frmipsec.ipsec_local_type.selectedIndex].value);>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
		<span id=msg_ipsec_local_start></span>
		</TD></TR>	
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.endaddr));</script>
		<input name=ipsec_local_end id=ipsec_local_end size=20 maxlength=15 onblur=chk_ip("ipsec_local_end")>
		<span id=msg_ipsec_local_end></span>
		</TD></TR-->	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.mask));</script>
		<input name=ipsec_local_subnet id=ipsec_local_subnet size=20 maxlength=15 onblur=chk_ip("ipsec_local_subnet")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));</script>
		<span id=msg_ipsec_local_subnet></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.remotetraffic),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteip));</script>
                <script>
	        //var _name= new Array(__T(filter.any),__T(def.range),__T("Single"),__T("Subnet"));
	        var _name= new Array(__T(vpn.single),__T(vpn.subnet)); ;
                draw_object(O_GUI,SELBOX,"ipsec_remote_type","id=ipsec_remote_type onchange=sel_lr_type('remote')",_name,lr_val);
                </script>
                </TD></TR>
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.startaddr));</script-->
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
                <input name=ipsec_remote_start id=ipsec_remote_start size=20 maxlength=15 onblur=chk_ip("ipsec_remote_start");cal_submask(this.from,"ipsec_remote_start","ipsec_remote_subnet",document.frmipsec.ipsec_remote_type[document.frmipsec.ipsec_remote_type.selectedIndex].value);>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
                <span id=msg_ipsec_remote_start></span>
                </TD></TR>
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(ipv6.endaddr));</script>
                <input name=ipsec_remote_end id=ipsec_remote_end size=20 maxlength=15 onblur=chk_ip("ipsec_remote_end")>
                <span id=msg_ipsec_remote_end></span>
                </TD></TR-->      
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(wan.mask));</script>
                <input name=ipsec_remote_subnet id=ipsec_remote_subnet size=20 maxlength=15 onblur=chk_ip("ipsec_remote_subnet")>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"255.255.255.0"));</script>
                <span id=msg_ipsec_remote_subnet></span>
                </TD></TR>
		<input type=hidden name=start_manual> 
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.manualpolicy),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteep));</script>
		<input name=ipsec_endpoint_value id=ipsec_endpoint_value size=20 maxlength=255>
		<span id=msg_ipsec_endpoint_value></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.spiincom));</script>
                <input name=ipsec_spi_income id=ipsec_spi_income size=20 maxlength=6 value="0x">
                <span id=msg_ipsec_spi_income></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.spioutgoing));</script>
                <input name=ipsec_spi_outgo id=ipsec_spi_outgo size=20 maxlength=6 value="0x">
                <span id=msg_ipsec_spi_outgo></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
                <script>
                var _name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes),__T(mang.aes192),__T(mang.aes256));
                //draw_object(O_GUI,SELBOX,"manual_ipsec_enc","id=manual_ipsec_enc onchange=sel_enc(this.form) ",_name,enc_val);
                draw_object(O_GUI,SELBOX,"manual_ipsec_enc","id=manual_ipsec_enc ",_name,enc_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.key));</script>
                <input name=ipsec_enc_keyin id=ipsec_enc_keyin size=20 maxlength=64>
                <span id=msg_ipsec_enc_keyin></span>
                </TD></TR>
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyout));</script>
                <input name=ipsec_enc_keyout id=ipsec_enc_keyout size=20 maxlength=64>
                <span id=msg_ipsec_enc_keyout></span>
                </TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.integrityalg));</script>
                <script>
                var int_name= new Array(__T(mang.sha1),__T(mang.md5));
                //var _name= new Array(__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"),__T("MD5"));
                draw_object(O_GUI,SELBOX,"manual_ipsec_int","id=manual_ipsec_int",int_name,int_val);
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.key));</script>
                <input name=ipsec_int_keyin id=ipsec_int_keyin size=20 maxlength=64>
                <span id=msg_ipsec_int_keyin></span>
                </TD></TR>
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyout));</script>
                <input name=ipsec_int_keyout id=ipsec_int_keyout size=20 maxlength=64>
                <span id=msg_ipsec_int_keyout></span>
                </TD></TR-->
		<input type=hidden name=end_manual> 
		<input type=hidden name=start_auto> 
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.autopp),"colspan=2");</script></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.satime));</script>
                <input name=ipsec_sa_lifetime id=ipsec_sa_lifetime size=20 value=28800 maxlength=5 onblur=msg_chk_range(this.value,"ipsec_sa_lifetime",30,86400,10,IS_FIELD,0,"msg_ipsec_sa_lifetime")> <script>Capture(unit.seconds);</script><script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"30","86400","28800"));</script>
                <span id=msg_ipsec_sa_lifetime></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
                <script>
                //var _name= new Array(__T("3DES"),__T(logemail.authnone),__T(mang.des),__T("AES-128"),__T("AES-192"),__T("AES-256"),__T("AES-CCM"),__T("AES_GCM"));
                var _name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes),__T(mang.aes192),__T(mang.aes256));
                draw_object(O_GUI,SELBOX,"auto_ipsec_enc","id=auto_ipsec_enc ",_name,auto_enc_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.integrityalg));</script>
                <script>
                //var _name= new Array(__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"),__T("MD5"));
                var _name= new Array(__T(mang.sha1),__T(mang.md5));
                draw_object(O_GUI,SELBOX,"auto_ipsec_int","id=auto_ipsec_int",_name,auto_int_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.pfskeygroup));</script>
		<input type=checkbox name=ipsec_pfs_enable id=ipsec_pfs_enable onclick=chk_enpfs(this.form)> <script>Capture(share.enable)</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
                <script>
                var _name= new Array(__T(vpn.dhgroup1),__T(vpn.dhgroup2),__T(vpn.dhgroup5));
                draw_object(O_GUI,SELBOX,"ipsec_pfs_group","id=ipsec_pfs_group",_name,dh_val);
                </script>
                </TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.selikepolicy));</script>
                <script>
                draw_object(O_GUI,SELBOX,"ipsec_ike_policy_name","id=ipsec_ike_policy_name",ike_name,ike_val);
                </script>
                <span id=msg_ipsec_ike_policy_name></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"",SPACE_DOWN,SPACE_DOWN);</script>
		<script>
		draw_object(O_GUI,BT,__T(vpn.view),"a1","BT","to_view(this.form)");
		</script>
		</TD></TR>
		<input type=hidden name=end_auto> 
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
