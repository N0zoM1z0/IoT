<html>
<head>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var define_backname="vpn_adv.asp";
function AAA(kid,pname,lid_type,lid,rid_type,rid,emode,esp,ah,psk,dh,sa_life,dpden,dpddelay,dpdtimeout)
{
	this.kid=kid;
	this.pname = pname;
	this.lid_type = lid_type;
	this.lid = lid;
	this.rid_type = rid_type;
	this.rid = rid;
	this.emode = emode;
	this.esp = esp;
	this.ah = ah;
	this.psk = psk;
	this.dh = dh;
	this.sa_life = sa_life;
	this.dpden = dpden;
	this.dpddelay = dpddelay;
	this.dpdtimeout = dpdtimeout;
}

function BBB(st,pname,vpnidx,ptype,end_type,end_ip,nsen,ltype,lip,lmask,rtype,rip,rmask,spii,spio,mesp_type,mesp_in,mesp_out,mah_type,mah_in,mah_out,life_time,esp,ah,pfs_en,pfs_group,ipsec_ike)

{
	this.st=st;
	this.pname=pname;
	this.vpnidx=vpnidx;
	this.ptype=ptype;
	this.end_type=end_type;
	this.end_ip=end_ip;
	this.nsen=nsen;
	this.ltype=ltype;
	this.lip=lip;
	this.lmask=lmask;
	this.rtype=rtype;
	this.rip=rip;
	this.rmask=rmask;
	this.spii=spii;
	this.spio=spio;
	this.mesp_type=mesp_type;
	this.mesp_in=mesp_in;
	this.mesp_out=mesp_out;
	this.mah_type=mah_type;
	this.mah_in=mah_in;
	this.mah_out=mah_out;
	this.life_time=life_time;
	this.esp=esp;
	this.ah=ah;
	this.pfs_en=pfs_en;
	this.pfs_group=pfs_group;
	this.ipsec_ike=ipsec_ike;
}

var ike = new Array();
<% get_site2site_adv_ike("ike","AAA"); %>

CHK_VALUE_AUTO=0;
single_tb="true";
var ike_idx=0;
var ike_stflg="init";
var ipsec_idx=0;
var ipsec_stflg="init";

var dh_val= new Array("modp768","modp1024","modp1536");
var dh_name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
var encrypt_val= new Array("des","3des","aes128","aes192","aes256");
var encrypt_algo_name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
var auth_val= new Array("md5","sha1","sha2_256");
var auth_algo_name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
var dh_group_name= new Array(__T(mang.group1),__T(mang.group2),__T(mang.group5));
var exchange_mode_name = new Array(__T(mang.main),__T(mang.agg));
var manual_ah_name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
var manual_ah_val= new Array("sha1","sha2_256","md5");
var manual_enc_name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
var manual_enc_val= new Array("3des","des","aes128","aes192","aes256");
var auto_enc_val= new Array("3des","des","aes128","aes192","aes256","aes_gcm_a-152-null","aes_ccm_a-152-null");
var auto_enc_name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256),__T(mang.aescgm),__T(mang.aesccm));
var auto_ah_name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
var auto_ah_val= new Array("sha1","sha2_256","md5");
var ptype_name = new Array(__T(mang.autop),__T(mang.manualp));

var ike_td_id = new Array("ikename","ike_lid","ike_rid","ike_emode","ike_esp","ike_ah","ike_dh");
var ipsec_td_id = new Array("ipsectdst","ipsectdname","ipsectdtype","ipsectdenc","ipsectdah","ipsectdlocal","ipsectdremote");

var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","AAA"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>
var vpnnatt = "<% get_vpnnatt(); %>";
var timeout = 0;

if ( "<% nvram_gozila_get("backname"); %>" != "" ) 
{
	var back_bt="true";
	var change_cancel_bt="true";
}

function to_back(F)
{
	change_cancel_bt="false";
	parent.document.getElementById("newpage").value = "<% nvram_gozila_get("backname"); %>";
	uiDoCancel(F,"back");
}

function init()
{
	var rv130_vpn_running = "<% get_reboot_flag("vpn_running"); %>";	
	var reboot_by_no_ccm_gcm, module_exist_flag;
	<% get_reboot_flag("vpn_sec"); %>
	document.getElementById("vpn_running").value = rv130_vpn_running;
	document.getElementById("module_exist_flag").value = module_exist_flag;
	//alert("rv130_vpn_running="+rv130_vpn_running+";\nmodule_exist_flg="+module_exist_flag);
	var F = document.frmipsec;
	if ( "<% get_reboot_flag("vpn_running"); %>" == "0"  ) 
	{
		init_ready();
		return;
	}
	parent.document.getElementById("save_bg").style.display="";
	get_status();

}

function get_status()
{
	var F = document.frmipsec;
	document.getElementById("newwin").src = goto_link("check_status.asp");
	if ( F.vpn_running.value ==0 || timeout == 15000 ) 
	{
		init_ready();
		return;
	}
	timeout+=5000;
	setTimeout("get_status()", 5000);
}

function init_ready()
{
	var F = document.frmipsec;
	var temp = "";
	parent.document.getElementById("save_bg").style.display="none";
	for(var i=0; i<ike.length; i++)
	{
		var data = new Array();
		data[0] = new Array("td_ikechk"+ike_idx,"<input type=checkbox id=ike_chk_"+ike_idx+" onclick=ike_chk_click('"+ike_idx+"')>",3);
		data[1] = new Array(ike_td_id[0]+ike_idx,ike[i].pname);
		if ( ike[i].lid_type == "0" )
			data[2] = new Array(ike_td_id[1]+ike_idx, __T(vpn.localwanip1));
		else
			data[2] = new Array(ike_td_id[1]+ike_idx, ike[i].lid);
		if ( ike[i].rid_type == "0" )
			data[3] = new Array(ike_td_id[2]+ike_idx, __T(vpn.remotewanip1));
		else
			data[3] = new Array(ike_td_id[2]+ike_idx, ike[i].rid);
		if ( ike[i].emode == "main" ) 
			data[4] = new Array(ike_td_id[3]+ike_idx,exchange_mode_name[0],3);
		else
			data[4] = new Array(ike_td_id[3]+ike_idx,exchange_mode_name[1],3);
		for(var k=0; k<encrypt_val.length; k++)
		{
			if ( ike[i].esp == encrypt_val[k] ) 
				break;
		}
		data[5] = new Array(ike_td_id[4]+ike_idx,encrypt_algo_name[k],3);
		for(var k=0; k<auth_val.length; k++)
		{
			if ( ike[i].ah == auth_val[k] ) 
				break;
		}
		data[6] = new Array(ike_td_id[5]+ike_idx,auth_algo_name[k],3);
		for(var k=0; k<dh_val.length; k++)
		{
			if ( ike[i].dh == dh_val[k] ) 
				break;
		}
		data[7] = new Array(ike_td_id[5]+ike_idx,dh_name[k],3);
		data[8] = new Array("","&nbsp;");
		add_row(ike_idx,data,"ike_chk_","initike",2);
		ike_idx++;
	}
	for(var i=0; i<ipsec_entry.length; i++)
	{
		var data = new Array();
		data[0] = new Array("tdipsecchk"+ipsec_idx,"<input type=checkbox id=ipsec_chk_"+ipsec_idx+" onclick=ipsec_chk_click('"+ipsec_idx+"')>",3);
		var vpnst=__T(share.disabled);
		if ( ipsec_entry[i].st == "1" ) vpnst = __T(share.enabled);
		data[1] = new Array(ipsec_td_id[0]+ipsec_idx,vpnst,3);
		data[2] = new Array(ipsec_td_id[1]+ipsec_idx,ipsec_entry[i].pname,0);
		data[3] = new Array(ipsec_td_id[2]+ipsec_idx,ptype_name[parseInt(ipsec_entry[i].ptype,10)],0);
		if ( ipsec_entry[i].ptype == "0" ) //AUTO
		{
			var encid=0;
			for(var k=0; k<auto_enc_val.length; k++){
				if ( auto_enc_val[k] == ipsec_entry[i].esp ) 
				{
					encid=k;	
					break;
				}
			}
			data[4] = new Array(ipsec_td_id[3]+ipsec_idx,auto_enc_name[encid],3);
			var ahid=0;
			for(var k=0; k<auto_ah_val.length; k++)
			{
				if ( auto_ah_val[k] == ipsec_entry[i].ah ) 
				{
					ahid=k;
					break;
				}
			}
			data[5] = new Array(ipsec_td_id[4]+ipsec_idx,auto_ah_name[ahid],3);
		}else{	//MANUAL
			var encid=0;
			for(var k=0; k<manual_enc_val.length; k++){
				if ( manual_enc_val[k] == ipsec_entry[i].mesp_type ) 
				{
					encid=k;	
					break;
				}
			}
			data[4] = new Array(ipsec_td_id[3]+ipsec_idx,manual_enc_name[encid],3);
			var ahid=0;
			for(var k=0; k<manual_ah_val.length; k++)
			{
				if ( manual_ah_val[k] == ipsec_entry[i].mah_type ) 
				{
					ahid=k;
					break;
				}
			}
			data[5] = new Array(ipsec_td_id[4]+ipsec_idx,manual_ah_name[ahid],3);
		}
		
		if ( ipsec_entry[i].ltype == "1" ) 
			data[6] = new Array(ipsec_td_id[5]+ipsec_idx,ipsec_entry[i].lip+"/"+ipsec_entry[i].lmask,0);
		else
			data[6] = new Array(ipsec_td_id[5]+ipsec_idx,ipsec_entry[i].lip,0);
		if ( ipsec_entry[i].rtype == "1" ) 
			data[7] = new Array(ipsec_td_id[6]+ipsec_idx,ipsec_entry[i].rip+"/"+ipsec_entry[i].rmask,0);
		else
			data[7] = new Array(ipsec_td_id[6]+ipsec_idx,ipsec_entry[i].rip,0);
		data[8] = new Array("","&nbsp;");
		
		add_row(ipsec_idx,data,"ipsec_chk_","initipsec",2);
		ipsec_idx++;
	}
	choose_disable(document.getElementById("e4"));
	choose_disable(document.getElementById("e5"));
	choose_disable(F.next_page);
	
}

function ike_chk_click(index)
{
	var count=0;
	for(var i=0; i<ike_idx; i++)
	{
		if ( document.getElementById("ike_chk_"+i).checked == true ) count++;
	}
	to_check("ike_chk_",document.getElementById("ike_chk_"+index).checked,index,ike_idx,"addike",ike_td_id,"");
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
					document.getElementById(ipsec_td_id[0]+i).innerHTML = __T(share.enabled);
				else
					document.getElementById(ipsec_td_id[0]+i).innerHTML = __T(share.disabled);
			}
		}
	}
	to_check("ipsec_chk_",document.getElementById("ipsec_chk_"+index).checked,index,ipsec_idx,"initipsec",ipsec_td_id,"");
	
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
	if ( ipsec_idx >= IPSEC_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,IPSEC_ENTRY,__T(vpn.policy)),"");
                return false;   
        } 
        var F = document.frmipsec;
        F.ipsec_selidx.value = ipsec_idx;
        F.submit_button.value = "ipsec_edit";
        F.ipsec_stflg.value="add";
        F.change_action.value="gozila_cgi";
        F.submit();
}

function to_add() //IKE
{
	if ( ike_idx >= IKE_ENTRY )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,IKE_ENTRY,__T(vpn.ikepolicy)),"");
                return false;   
        } 
	var F = document.frmipsec;
	F.ike_selidx.value = ike_idx;
	F.submit_button.value = "ike_edit";
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
                        selindex=ike[i].kid;
                        break;
                }
        }
        var F = document.frmipsec;
        F.ike_selidx.value = selindex;
        F.ike_stflg.value = "edit";
        F.submit_button.value = "ike_edit";
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
	F.submit_button.value="ipsec_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}

function uiDoSave(F)
{
	var ike_selidx = "";
	var ipsec_selidx = "";
	var reboot_flg = 0;
	var check_en = 0;
	var count=0;

	//if (ipsec_stflg == "init") ipsec_stflg = "endis";

	if ( ike_stflg == "del" ) 
	{
		for(var i=0; i<ike_idx; i++)
		{
			if ( document.getElementById("tr_tableike_"+i).className == "TABLECONTENT_DEL")
			{
				for(j=0; j<ipsec_idx; j++)
				{
					if ( (parseInt(ipsec_entry[j].ipsec_ike,10)) == ike_entry[i].kid ) 
					{
                				my_alert(O_PAGE,INFO,__T(vpn.delikemsg),"");
						return false;
					}
				}
				if ( ike_selidx != "" ) ike_selidx+=",";
				ike_selidx+=ike[i].kid;
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
				if ( ipsec_entry[i].st == "1" ) reboot_flg=1;
			}	
		}
	}
	//alert("!!!ipsec_stflg="+ipsec_stflg);	
	if ( ipsec_stflg == "endis" ) 
	{
		for(var i=0; i<ipsec_idx; i++)
		{
			if ( ipsec_selidx != "" ) ipsec_selidx+=",";
			ipsec_selidx+=ipsec_entry[i].vpnidx+":";
			if ( document.getElementById(ipsec_td_id[0]+i).innerHTML == __T(share.enabled) ) 
			{
				ipsec_selidx+="1";
				if ( ipsec_entry[i].ptype == "0" ) 
				{
					if ( ipsec_entry[i].esp == "aes_gcm_a-152-null" || 
					     ipsec_entry[i].esp == "aes_ccm_a-152-null" ||
				             ipsec_entry[i].ah == "sha2_256" )
						check_en = 1;
				}else{
					if ( ipsec_entry[i].mah_type == "sha2_256" ) 
						check_en = 1;	
				}	
			}
			else
				ipsec_selidx+="0";

		}
	}
	//alert("check_en="+check_en);
	var enflg=0;
	F.ipsec_stflg.value = ipsec_stflg;
	F.ike_stflg.value = ike_stflg;
	if ( ike_stflg == "del" ) 
	{
		F.ike_selidx.value = ike_selidx;
		F.submit_type.value="delete";
		enflg++;
	}
	if ( ipsec_stflg == "del" )
	{ 
		F.ipsec_selidx.value = ipsec_selidx;
		if( reboot_flg == 1 ) 
			F.submit_type.value="delete_reboot";
		else
			F.submit_type.value="delete";
		enflg++;
	}
	if ( ipsec_stflg == "endis" ) 
	{
		F.ipsec_selidx.value = ipsec_selidx;
		F.submit_type.value="endis";
		enflg++;
	}
	if ( F._vpnnat.checked == true ) F.vpnnat.value = "1";
	else F.vpnnat.value = "0";
	//if ( ipsec_stflg == "init" && ipsec_entry.length > 0 ) 
	if ( ipsec_stflg == "init" && ike_stflg == "init" ) 
	{
		F.ipsec_selidx.value = "";
		F.submit_type.value="endis";
		enflg++;
	}
//alert("ipsec_stflg="+ipsec_stflg+";ike_stflg="+ike_stflg);
	if ( enflg > 0 ) 
	{
//		alert("module_exist_flag="+document.getElementById("module_exist_flag").value);
		if ( check_en == 1 && document.getElementById("module_exist_flag").value == 1 ) 
		{
			if ( ipsec_stflg == "endis" || ipsec_stflg == "del" ) 
			{
				if ( ipsec_stflg == "endis" ) 
					F.submit_button.value = "vpn_adv_reboot";
				else
					F.submit_button.value = "vpn_adv_del_reboot";
				F.gui_action.value = "Apply";
		  		my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"vpn_alert_result(1)","vpn_alert_result(0)","","yesno");
			}
		}
		else
		{
			F.submit_button.value = "vpn_adv";
			F.change_action.value="gozila_cgi";
			vpn_alert_result(1);
		}
	}
}

function vpn_alert_result(val)
{
	alert_result(0);
	var F = document.frmipsec;
	if ( val == 1 ) 
	{
		if ( F.submit_button.value == "vpn_adv_reboot" || 
 		     F.submit_button.value == "vpn_adv_del_reboot" ) 
		{
			parent.document.getElementById("hidden_bg").style.display="";
		}
		else
		{
			parent.document.getElementById("save_bg").style.display="";
		}
	       	F.submit();	
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
		to_check("ike_chk_",document.getElementById("ike_chk_"+i).checked,i,ike_idx,ike_stflg+"ike",ike_td_id,data);
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
		to_check("ipsec_chk_",document.getElementById("ipsec_chk_"+i).checked,i,ipsec_idx,"initipsec",ipsec_td_id,"");
			
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
				document.getElementById(ipsec_td_id[0]+i).innerHTML = __T(share.enabled);
			else
				document.getElementById(ipsec_td_id[0]+i).innerHTML = __T(share.disabled);
			cnt++;
		}
	}
	if ( cnt > 0 ) choose_disable(document.getElementById("e3"));
}

function goto_status()
{
	change_cancel_bt="true";
	get_position("status_sitetosite.asp",1);
	goto_page("status_sitetosite.asp");
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
<input type=hidden name=ipsec_enable> 
<input type=hidden name=backname>
<input type=hidden name=vpnnat>
<input type=hidden name=next_page>
<input type=hidden id=module_exist_flag>
<input type=hidden id=vpn_running value=1>
<iframe id=newwin height=0 width=0 name=iframe1 frameborder=0 scrolling=no astyle=display:none></iframe>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(vpn.ipsecpolicy));</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.nattrav));
		var chkflg="";
		if ( vpnnatt == "1" ) chkflg="checked";
		document.write("<input type=checkbox id=_vpnnat name=_vpnnat "+chkflg+">"+__T(share.enable));</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.configsum),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.numdeftun));</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.numentun));</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.numcontun));</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.nummaxtun));</script>
		</TD></TR-->
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,10,10,10,15,15,10",__T(vpn.iketb),"<input type=checkbox name=chk_all_ike id=chk_all_ike onclick=chkallike(this.form)>,"+__T(filter.sname)+","+__T(vpn.localid)+","+__T(vpn.remoteid)+","+__T(vpn.exmode)+","+__T(vpn.encryalg)+","+__T(vpn.authalg)+","+__T(vpn.dhgroup),"add,edit,del","","","ike","2,0,0,0,2,2,2,2");
		// For firefox disaled
		choose_disable(document.getElementById("t3"));
		choose_disable(document.getElementById("t4"));
		
		var bt_list = new Array();
		bt_list[0] = new Array("BT","e1",__T(share.addrow),"to_add_vpn(this.form)");
		bt_list[1] = new Array("BT","e2",__T(share.edit),"to_edit_vpn(this.form)");
		bt_list[2] = new Array("BT","e4",__T(share.enable),"to_endis_vpn(this.form,\"en\")");
		bt_list[3] = new Array("BT","e5",__T(share.disable),"to_endis_vpn(this.form,\"dis\")");
		bt_list[4] = new Array("BT","e3",__T(share.del),"to_del_vpn(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,10,15,10,15,15,10,10",__T(vpn.vpntb),"<input type=checkbox name=chk_all_ipsec id=chk_all_ipsec onclick=chkallipsec(this.form)>,"+__T(share.sts)+","+__T(share.name)+","+__T(vpn.ptype)+","+__T(vpn.encryalg)+","+__T(vpn.authalg)+","+__T(vpn.local)+","+__T(vpn.remote),"",bt_list,"","ipsec","2,2,0,0,2,2,0,0");
		// For firefox disaled
		choose_disable(document.getElementById("e2"));
		choose_disable(document.getElementById("e3"));
		</script>
		</TD></TR>
	</TABLE>
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
