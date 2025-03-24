<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var define_backname="rac_vpn_adv.asp";
function AAA(kid,pname,emode,rep_type,rep_val,en_algo,auth_algo,dh,psk,en_dpd,dpd_delay,dpd_timeout)
{
        this.kid=kid;
        this.pname = pname;
        this.emode = emode;
        this.rep_type = rep_type;
        this.rep_val = rep_val
        this.en_algo = en_algo;
        this.auth_algo=auth_algo;
        this.dh=dh;
        this.psk=psk;
        this.en_dpd=en_dpd;
        this.dpd_delay=dpd_delay;
        this.dpd_timeout=dpd_timeout;
}

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

CHK_VALUE_AUTO=0;
single_tb="true";
var ike_idx=0;
var ike_stflg="init";
var ipsec_idx=0;
var ipsec_stflg="init";

var int_val= new Array("hmac-sha1","hmac-md5");
var auto_int_val= new Array("hmac_sha1","hmac_md5");
//var int_val= new Array("sha1","sha2_256","sha2_384","sha2_512","md5");
//var enc_val= new Array("3des","none","des","aes128","aes192","aes256");
var enc_val= new Array("3des-cbc","des-cbc","aes-cbc","aes192-cbc","aes256-cbc");
var auto_enc_val= new Array("3des","des","aes","aes192","aes256");
var encrypt_val= new Array("des","3des","aes128","aes192","aes256");
//var auth_val= new Array("md5","sha1","sha2_256","sha2_384","sha2_512");
var auth_val= new Array("md5","sha1","sha2_256");
var dh_val= new Array("modp768","modp1024","modp1536");
var encrypt_algo_name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
//var auth_algo_name= new Array(__T(mang.md5),__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"));
var auth_algo_name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
var dh_group_name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
var exchange_mode_name = new Array(__T(mang.main),__T(mang.agg));
var ptype_name = new Array(__T(mang.autop),__T(mang.manualp));
//var lr_name= new Array(__T(filter.any),__T("Single"),__T(def.range),__T("Subnet"));
//var lr_name= new Array(__T("Single"),__T("Subnet"));
var i_int_name= new Array(__T(mang.sha1),__T(mang.md5));
//var i_int_name= new Array(__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"),__T("MD5"));
//var enc_name= new Array(__T("3DES"),__T("NONE"),__T(mang.des),__T("AES-128"),__T("AES-192"),__T("AES-256"));
var enc_name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes),__T(mang.aes192),__T(mang.aes256));

var ike_td_id = new Array("iketdchk","iketdname","iketdlip","iketdrip","iketdencry","iketddh","iketdwlip","iketdwrip");
var ipsec_td_id = new Array("ipsectdchk","ipsectdname","ipsectdtype","ipsectdltype","ipsectdrtype","ipsectdint","ipsectdenc");

var ike_entry = new Array();
<% get_rac_ike_policy("all"); %>

var ipsec_entry = new Array();
<% get_rac_ipsec_policy(); %>

function init()
{
	var temp = "";
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<ike_entry.length; i++)
	{
		var data = new Array();
		data[0] = new Array(ike_td_id[0]+ike_idx,"<input type=checkbox id=ike_chk_"+ike_idx+" onclick=ike_chk_click('"+ike_idx+"')>",3);
		data[1] = new Array(ike_td_id[1]+ike_idx,ike_entry[i].pname);
		
		data[2] = new Array(ike_td_id[2]+ike_idx,ike_entry[i].emode=="main"?exchange_mode_name[0]:exchange_mode_name[1],3);
		//data[3] = new Array(ike_td_id[6]+ike_idx,ike_entry[i].wlip);
		data[3] = new Array(ike_td_id[3]+ike_idx,ike_entry[i].rep_val);
		for(var j=0; j<encrypt_val.length; j++)
		{
			if ( ike_entry[i].en_algo == encrypt_val[j] ) 
			{
				data[4] = new Array(ike_td_id[4]+ike_idx,encrypt_algo_name[j],3);
				break;
			}
		}
		for(var j=0; j<auth_val.length; j++)
		{
			if ( ike_entry[i].auth_algo == auth_val[j] ) 
			{
				data[5] = new Array(ike_td_id[5]+ike_idx,auth_algo_name[j],3);
				break;
			}
		}
		for(var j=0; j<dh_val.length; j++)
		{
			if ( ike_entry[i].dh == dh_val[j] ) 
			{
				data[6] = new Array(ike_td_id[6]+ike_idx,dh_group_name[j],3);
				break;
			}
		}
		data[7] = new Array("","&nbsp;");
		add_row(ike_idx,data,"ike_chk_","initike","","",2);
		ike_idx++;
	}
	for(var i=0; i<ipsec_entry.length; i++)
	{
		var data = new Array();
		data[0] = new Array(ipsec_td_id[0]+ipsec_idx,"<input type=checkbox id=ipsec_chk_"+ipsec_idx+" onclick=ipsec_chk_click('"+ipsec_idx+"')>",3);
		if ( ipsec_entry[i].st != "1" ) 
			data[1] = new Array(ipsec_td_id[1]+ipsec_idx,__T(share.disabled),3);
		else
			data[1] = new Array(ipsec_td_id[1]+ipsec_idx,__T(share.enabled),3);
		data[2] = new Array(ipsec_td_id[2]+ipsec_idx,ipsec_entry[i].pname,0);
		data[3] = new Array(ipsec_td_id[3]+ipsec_idx,ptype_name[parseInt(ipsec_entry[i].ptype,10)],3);
		data[4] = new Array(ipsec_td_id[4]+ipsec_idx,ipsec_entry[i].lstart,0);
		data[5] = new Array(ipsec_td_id[5]+ipsec_idx,ipsec_entry[i].rstart,0);
		
		for(var j=0; j<int_val.length; j++)
		{
			if ( ( ipsec_entry[i].ptype == "1" && ipsec_entry[i].i_int == int_val[j] ) || 
			     ( ipsec_entry[i].ptype == "0" && ipsec_entry[i].ah == auto_int_val[j] )) 
			{
				data[6] = new Array(ipsec_td_id[6]+ipsec_idx,i_int_name[j],3);
				break;
			}
		}
		for(var j=0; j<enc_val.length; j++)
		{
			if ( ( ipsec_entry[i].ptype == "1" && ipsec_entry[i].enc == enc_val[j] ) || 
			     ( ipsec_entry[i].ptype == "0" && ipsec_entry[i].esp == auto_enc_val[j] )) 
			{
				data[7] = new Array(ipsec_td_id[7]+ipsec_idx,enc_name[j],3);
				break;
			}
		}
		data[8] = new Array("","&nbsp;");
		
		add_row(ipsec_idx,data,"ipsec_chk_","initipsec","","",2);
		ipsec_idx++;
	}
	choose_disable(document.getElementById("e4"));
	choose_disable(document.getElementById("e5"));
	
}

function ike_chk_click(index)
{
	var count=0;
	for(var i=0; i<ike_idx; i++)
	{
		if ( document.getElementById("ike_chk_"+i).checked == true ) count++;
	}
	to_check("ike_chk_",document.getElementById("ike_chk_"+index).checked,"ike_"+index,ike_idx,"add",ike_td_id,"");
	if ( count > 1 ) choose_disable(document.getElementById("t3"));
	if ( count == 0 ) choose_disable(document.getElementById("t4"));
}

function ipsec_chk_click(index)
{
	var count=0;
	for(var i=0; i<ipsec_idx; i++)
	{
		if ( document.getElementById("ipsec_chk_"+i).checked == true ) count++;
		else{
			if ( ipsec_stflg == "endis" ) 
			{
				if ( ipsec_entry[i].st == "1" ) 
					document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.enabled);
				else
					document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.disabled);
			}
		}
	}
	to_check("ipsec_chk_",document.getElementById("ipsec_chk_"+index).checked,"ipsec_"+index,ipsec_idx,"",ipsec_td_id,"");
	
	if ( count > 0 ) 
	{
		choose_disable(document.getElementById("e1"));
		choose_enable(document.getElementById("e2"));
		choose_enable(document.getElementById("e3"));
		choose_enable(document.getElementById("e4"));
		choose_enable(document.getElementById("e5"));
	}
	if ( count > 1 )
		choose_disable(document.getElementById("e2"));
	if ( count == 0 ) 
	{
		choose_enable(document.getElementById("e1"));
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		choose_disable(document.getElementById("e4"));
		choose_disable(document.getElementById("e5"));
	}
	
	
}

function to_add_vpn(F)
{
	if ( ipsec_idx >= RAC_IPSEC_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,RAC_IPSEC_ENTRY,__T(vpn.policy)),"");
                return false;   
        } 
        var F = document.frmipsec;
        F.ipsec_selidx.value = ipsec_idx;
        F.submit_button.value = "rac_ipsec_edit";
        F.ipsec_stflg.value="add";
        F.change_action.value="gozila_cgi";
        F.submit();
}

function to_add() //IKE
{
	if ( ike_idx >= RAC_IKE_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,RAC_IKE_ENTRY,__T(vpn.ikepolicy)),"");
                return false;   
        } 
	var F = document.frmipsec;
	F.ike_selidx.value = ike_idx;
	F.submit_button.value = "rac_ike_edit";
	F.ike_stflg.value="add";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function to_del_vpn()
{
	ipsec_stflg = "del";
	var cnt=0;
	document.getElementById("tmsgipsec").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgipsec").style.display="";

	document.getElementById("page_msg_td").style.display="none";
	for(var i=0; i<ipsec_idx; i++)
	{
		if ( document.getElementById("ipsec_chk_"+i).checked == true ) 
		{
			document.getElementById("tr_tableipsec_"+i).className= "TABLECONTENT_DEL";
			cnt++;	
		}
	}	
	if ( cnt > 0 ) 
	{
		choose_disable(document.getElementById("e4"));
		choose_disable(document.getElementById("e5"));
	}
}

function to_del()//IKE
{
	ike_stflg = "del";
	var cnt = 0;
	// table message
	document.getElementById("tmsgike").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgike").style.display="";

	document.getElementById("page_msg_td").style.display="none";

	for(var i=0; i<ike_idx; i++)
	{
		if ( document.getElementById("ike_chk_"+i).checked == true ) 
		{
			document.getElementById("tr_tableike_"+i).className= "TABLECONTENT_DEL";
			cnt++;
		}
	}

	// disabled the add and edit button
	if(cnt > 0)
	{
		choose_disable(document.getElementById("t2"));
		choose_disable(document.getElementById("t3"));
	}
	
}

function to_edit()//IKE
{
        var selindex=0;
        for(var i=0; i<ike_idx; i++)
        {
                if ( document.getElementById("ike_chk_"+i).checked == true ) 
                {
                        selindex=ike_entry[i].kid;
                        break;
                }
        }
        var F = document.frmipsec;
        F.ike_selidx.value = selindex;
        F.ike_stflg.value = "edit";
        F.submit_button.value = "rac_ike_edit";
        F.change_action.value = "gozila_cgi";
        F.submit();	
}

function to_edit_vpn(F)
{
	var selindex=0;
	for(var i=0; i<ipsec_idx; i++)
	{
		if ( document.getElementById("ipsec_chk_"+i).checked == true ) 
		{
                        selindex=ipsec_entry[i].vpnidx;
			break;
		}
	}
	F.ipsec_selidx.value = selindex;
	F.ipsec_stflg.value="edit";
	F.submit_button.value="rac_ipsec_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function uiDoSave(F)
{
	var ike_selidx = "";
	var ipsec_selidx = "";
	var check_en = 0;
	var count=0;

	if ( ike_stflg == "del" ) 
	{
		for(var i=0; i<ike_idx; i++)
		{
			if ( document.getElementById("tr_tableike_"+i).className == "TABLECONTENT_DEL")
			{
				for(j=0; j<ipsec_idx; j++)
				{
					if ( (parseInt(ipsec_entry[j].ipsec_ike,10)-1) == i ) 
					{
                				my_alert(O_PAGE,INFO,__T(vpn.delikemsg),"");
						return false;
					}
				}
				if ( ike_selidx != "" ) ike_selidx+=",";
				ike_selidx+=ike_entry[i].kid;
			}	
		}
	}
	if ( ipsec_stflg == "del" ) 
	{
		for(var i=0; i<ipsec_idx; i++)
		{
			if ( document.getElementById("tr_tableipsec_"+i).className == "TABLECONTENT_DEL")
			{
				if(ipsec_entry[i].st == 1)
				{
                			my_alert(O_PAGE,INFO,__T(vpn.delipsecmsg),"");
					return false;	
				}
				if ( ipsec_selidx != "" ) ipsec_selidx+=",";
				ipsec_selidx+=ipsec_entry[i].vpnidx;
			}	
		}
	}
	if ( ipsec_stflg == "endis" ) 
	{
		for(var i=0; i<ipsec_idx; i++)
		{
			if ( ipsec_selidx != "" ) ipsec_selidx+=",";
			ipsec_selidx+=ipsec_entry[i].vpnidx+":";

			if ( document.getElementById(ipsec_td_id[1]+i).innerHTML == __T(share.enabled) ) 
			{
				/*if(check_en == 1)
				{
                			my_alert(O_PAGE,INFO,spell_words(max_rule,1,__T(filter.policy)),"");
					return;
				}*/
				ipsec_selidx+="1";
				check_en = 1;
			}
			else
				ipsec_selidx+="0";

		}
	}
	var enflg=0;
	F.ipsec_stflg.value =  ipsec_stflg;
	F.ike_stflg.value =  ike_stflg;
	if ( ike_stflg == "del" ) 
	{
		F.ike_selidx.value = ike_selidx;
		F.submit_type.value="delete";
		enflg++;
	}
	if ( ipsec_stflg == "del" )
	{ 
		F.ipsec_selidx.value = ipsec_selidx;
		F.submit_type.value="delete";
		enflg++;
	}
	if ( ipsec_stflg == "endis" ) 
	{
		F.ipsec_selidx.value = ipsec_selidx;
		F.submit_type.value="endis";
		enflg++;
	}
	if ( enflg > 0 ) 
	{
		F.submit_button.value = "rac_vpn_adv";
		F.change_action.value="gozila_cgi";
	       	F.submit();	
		parent.document.getElementById("save_bg").style.display="";
	}
	
}

function chkallike(F)
{
	var count=0;
	for(var i=0; i<ike_idx; i++)
	{
		if ( F.chk_all_ike.checked == true ) 
		{
			document.getElementById("ike_chk_"+i).checked = true;
			count++;
		}else
			document.getElementById("ike_chk_"+i).checked = false;
		var data = new Array();
		data[0] = ike_entry[i].pname;
		data[1] = exchange_mode_name[ike_entry[i].emode];
		data[2] = ike_entry[i].lid;
		data[3] = ike_entry[i].rid;
		data[4] = encrypt_algo_name[ike_entry[i].encrypt];
		data[5] = auth_algo_name[ike_entry[i].auth];
		data[6] = dh_group_name[ike_entry[i].dh];
		to_check("ike_chk_",document.getElementById("ike_chk_"+i).checked,"ike_"+i,ike_idx,ike_stflg,ike_td_id,data);
	}
	choose_disable(document.getElementById("t2"));
	if ( count > 1 ) 
		choose_disable(document.getElementById("t3"));
	if ( count == 0 ) 
		choose_enable(document.getElementById("t2"));
	else
		choose_enable(document.getElementById("t4"));
}

function chkallipsec(F)
{
	var count=0;
	for(var i=0; i<ipsec_idx; i++)
	{
		if ( F.chk_all_ipsec.checked == true ) 
		{
			document.getElementById("ipsec_chk_"+i).checked = true;
			count++;
		}else{
			if ( ipsec_stflg == "endis" )
			{
				if ( ipsec_entry[i].st == "1" ) 
					document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.enabled);
				else
					document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.disabled);
			}
		
			document.getElementById("ipsec_chk_"+i).checked = false;
		}
		to_check("ipsec_chk_",document.getElementById("ipsec_chk_"+i).checked,"ipsec_"+i,ipsec_idx,"",ipsec_td_id,"");
			
	}
	choose_disable(document.getElementById("e1"));
	if ( count > 1 ) 
		choose_disable(document.getElementById("e2"));
	if ( count == 0 ) 
	{
		choose_enable(document.getElementById("e1"));
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		choose_disable(document.getElementById("e4"));
		choose_disable(document.getElementById("e5"));
	}
	else
	{
		choose_enable(document.getElementById("e3"));
		choose_enable(document.getElementById("e4"));
		choose_enable(document.getElementById("e5"));
	}
}

function to_endis_vpn(F,flg)
{
	ipsec_stflg = "endis";
	document.getElementById("tmsgipsec").innerHTML = __T(msg.tablemsg1); 
	document.getElementById("tmsgipsec").style.display="";
	var cnt=0;
	
	for(var i=0; i<ipsec_idx; i++)
	{
		if ( document.getElementById("ipsec_chk_"+i).checked == true ) 
		{
			if ( flg == "en" ) 
				document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.enabled);
			else
				document.getElementById(ipsec_td_id[1]+i).innerHTML = __T(share.disabled);
			cnt++;
		}
	}
	if ( cnt > 0 ) choose_disable(document.getElementById("e3"));
}

function goto_status()
{
	change_cancel_bt="true";
	get_position("rac_vpn_adv.asp",1);
	goto_page("status_ipsec.asp");
}


</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name="frmipsec" method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=ike_selidx> 
<input type=hidden name=ike_stflg> 
<input type=hidden name=ipsec_selidx> 
<input type=hidden name=ipsec_stflg> 
<input type=hidden name=backname>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.ipsecpolicy));</script></TR>
  <TR><TD colspan=2>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,5,15,15,15,15",__T(vpn.iketb),"<input type=checkbox name=chk_all_ike id=chk_all_ike onclick=chkallike(this.form)>,"+__T(filter.sname)+","+__T(router.mode)+","+__T(vpn.remote)+","+__T(wl.encryption)+","+__T(wan.auth)+","+__T(vpn.dh),"add,edit,del","","","ike","2,0,2,0,2,2,2");
		// For firefox disaled
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		</script>
      </TD>
  </TR>
  <TR><TD colspan=2>
		<script>
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add_vpn(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.edit),"to_edit_vpn(this.form)");
		bt_list[2] = new Array("BT","e4",__T(share.enable),"to_endis_vpn(this.form,\"en\")");
		bt_list[3] = new Array("BT","e5",__T(share.disable),"to_endis_vpn(this.form,\"dis\")");
		bt_list[4] = new Array("BT","e3",__T(share.del),"to_del_vpn(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,15,10,15,15,10,10",__T(vpn.vpntb),"<input type=checkbox name=chk_all_ipsec id=chk_all_ipsec onclick=chkallipsec(this.form)>,"+__T(share.sts)+","+__T(filter.sname)+","+__T(share.stype)+","+__T(vpn.local)+","+__T(vpn.remote)+","+__T(wan.auth)+","+__T(wl.encryption),"",bt_list,"","ipsec","2,2,0,2,0,0,2,2");
		// For firefox disaled
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		</script>
      </TD>
  </TR>
<% web_include_file("BT.asp"); %>
  <TR><TD colspan=2>
	<script>draw_object(O_GUI,BT,__T(vpn.ipsecst),"t1","BT","goto_status()");</script>
  </TD></TR>
</TABLE>
</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
