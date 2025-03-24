<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
function AAA(kid,pname,lid_type,lid,rid_type,rid,emode,esp,ah,psk,dh,sa_life,dpden,dpddelay,dpdtimeout,auth_method)
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
        this.auth_method= auth_method;
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

var int_val= new Array("sha1","sha2_256","md5");
var int_len= new Array(20,32,16);
//var int_val= new Array("sha1","sha2_256","sha2_384","sha2_512","md5");
//var int_len= new Array(20,32,48,64,16);
var dh_val= new Array("modp768","modp1024","modp1536");
//var enc_val= new Array("3des","none","des","aes128","aes192","aes256");
//var enc_len= new Array(24,256,8,16,24,32);
//no support none
var auto_enc_val= new Array("3des","des","aes128","aes192","aes256","aes_gcm_a-152-null","aes_ccm_a-152-null");
var enc_val= new Array("3des","des","aes128","aes192","aes256");
var enc_len= new Array(24,8,16,24,32);
//var lr_val= new Array("1","2","3","4"); // not support any rang
var lr_val= new Array("0","1");
var ike_name= new Array();
var ike_val= new Array();
var change_cancel_bt="true";
<% get_ike_name(); %>

var data = new Array();
<% get_vpnserver_setup("data"); %>

var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","AAA"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","BBB"); %>

var sidx="<% nvram_gozila_get("ipsec_selidx"); %>";
if ( sidx == "" ) sidx = "0"
if ( parseInt(sidx,10) > 0 ) sidx = parseInt(parseInt(sidx,10),10);
var back_bt = "true";
function refresh_page()
{
	alert_result(0);
	var F = document.frmipsec;
	choose_disable(F.next_page);
	F.submit_button.value = "ipsec_edit";
	F.change_action.value="gozila_cgi";
	F.submit();
}
function to_back(F)
{
	parent.document.getElementById("newpage").value = "vpn_adv.asp";
	uiDoCancel(F);
}
	
var idx = 0;

function init()
{
	var F = document.frmipsec;

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

		F.ipsec_policy_name.value = ipsec_entry[idx].pname;
		F.ipsec_policy_type.selectedIndex = parseInt(ipsec_entry[idx].ptype,10);
		F.ipsec_endpoint_type.selectedIndex = parseInt(ipsec_entry[idx].end_type,10);
		F.ipsec_endpoint_value.value = ipsec_entry[idx].end_ip;
	 	if ( ipsec_entry[idx].nsen == "1" ) 
			F.ipsec_netbios.checked = true;
		F.ipsec_local_type.selectedIndex = ipsec_entry[idx].ltype;
		F.ipsec_local_start.value = ipsec_entry[idx].lip;
		F.ipsec_local_subnet.value = ipsec_entry[idx].lmask;
		F.ipsec_remote_type.selectedIndex = ipsec_entry[idx].rtype;
		F.ipsec_remote_start.value = ipsec_entry[idx].rip;
		F.ipsec_remote_subnet.value = ipsec_entry[idx].rmask;
		if ( F.ipsec_policy_type.selectedIndex == 0 ){ //AUTO
			F.ipsec_sa_lifetime.value = ipsec_entry[idx].life_time;
			//F.ipsec_sa_type.selectedIndex = parseInt(ipsec_entry[idx].sa_type,10);
			for(var j=0; j<auto_enc_val.length; j++)
			{
				if ( ipsec_entry[idx].esp == auto_enc_val[j] ) 
				{
					F.auto_ipsec_enc.selectedIndex = j;
					break;
				}
			}
			for(var j=0; j<int_val.length; j++)
			{
				if ( ipsec_entry[idx].ah == int_val[j] ) 
				{
					F.auto_ipsec_int.selectedIndex = j;
					break;
				}
			}
			if ( ipsec_entry[idx].pfs_en == "1" ) 
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
				if (ipsec_entry[idx].ipsec_ike == ike_val[j]) 
				{
					F.ipsec_ike_policy_name.selectedIndex = j;
					break;
				}
			}
		}else{//Manual
			F.ipsec_spi_income.value = ipsec_entry[idx].spii;	
			F.ipsec_spi_outgo.value = ipsec_entry[idx].spio;
			for(var j=0; j<enc_val.length; j++)
			{
				if ( ipsec_entry[idx].mesp_type == enc_val[j] ) 
				{
					F.manual_ipsec_enc.selectedIndex = j;
					break;
				}
			}
			//if ( F.manual_ipsec_enc.selectedIndex != 1 )//none 
			//{
				F.ipsec_enc_keyin.value = ipsec_entry[idx].mesp_in;
				F.ipsec_enc_keyout.value = ipsec_entry[idx].mesp_out;
			//}	
			//sel_enc(F);
			for(var j=0; j<int_val.length; j++)
			{
				if ( ipsec_entry[idx].mah_type == int_val[j] ) 
				{
					F.manual_ipsec_int.selectedIndex = j;
				}
			}
			F.ipsec_int_keyin.value = ipsec_entry[idx].mah_in;
			F.ipsec_int_keyout.value = ipsec_entry[idx].mah_out;
		}
	}
	else
	{
		F.auto_ipsec_enc.selectedIndex = 2;
		F.auto_ipsec_int.selectedIndex = 0;
		F.manual_ipsec_enc.selectedIndex = 2;
		F.manual_ipsec_int.selectedIndex = 0;
	}
	sel_type(F);
	sel_lr_type("local");
	sel_lr_type("remote");
	chk_enpfs(F);
	sel_auto_enc(F);
	default_nv = keep_val(F,"");
}

function sel_type(F)
{
	if ( F.ipsec_policy_type.selectedIndex == 0 ) 
	{
		//choose_disable(F.ipsec_endpoint_type);
		//choose_disable(F.ipsec_endpoint_value);
		choose_enable(document.getElementById("ipsec_endpoint_type")[1]);
	        DISABLE_PART(F,"start_manual","end_manual",1);
	        DISABLE_PART(F,"start_auto","end_auto",0);
	}else{
		//choose_enable(F.ipsec_endpoint_type);
		//choose_enable(F.ipsec_endpoint_value);
		document.getElementById("ipsec_endpoint_type")[0].selected = true;
		choose_disable(document.getElementById("ipsec_endpoint_type")[1]);
		
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
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE7,MASK_OK) <= 0 )
			{
				my_alert(O_VAR,obj_id,__T(msg.ivalidipformat),"0","msg_"+obj_id);
				return false;
			}
			
		}else{
			if ( check_ipv4(document.getElementById(obj_id).value,VALID_IP_RULE7,MASK_NO) <= 0 )
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
	var returnmsg = valid_meaning_id_name(ID_NAME,document.getElementById(obj_id).value,ZERO_NO,obj_id);
	if ( returnmsg != "" ) 
	{
		my_alert(O_VAR,obj_id,returnmsg,"0","msg_"+obj_id);
		return false;
	}
	return true;
}

function my_chk_fqdn(F)
{
	clear_msg("ipsec_endpoint_value","msg_ipsec_endpoint_value");
	if ( F.ipsec_endpoint_type.selectedIndex == 1 ){ 
		if ( !chk_fqdn(F.ipsec_endpoint_value.value,"ipsec_endpoint_value") ) return false;
	}else{
		if ( check_ipv4(F.ipsec_endpoint_value.value,VALID_IP_RULE7,MASK_OK) != PASS )
		{
			my_alert(O_VAR,"ipsec_endpoint_value",__T(msg.ivalidipformat),"0","msg_ipsec_endpoint_value");
			return false;
		}
	}
	return true;
}

function before_check(F)
{
	var errflg = 0 ;
	if ( !chk_name("ipsec_policy_name") ) errflg++;
	clear_msg("ipsec_ike_policy_name","msg_ipsec_ike_policy_name");
	if ( F.ipsec_endpoint_type[F.ipsec_endpoint_type.selectedIndex].value == "1" ) 
	{
		if ( ike_entry[F.ipsec_ike_policy_name.selectedIndex].lid_type == "0" ||
		     ike_entry[F.ipsec_ike_policy_name.selectedIndex].rid_type == "0" )
		{
			my_alert(O_VAR,"ipsec_ike_policy_name",__T(vpn.notsupportmsg),"0","msg_ipsec_ike_policy_name");
			return false;
			
		}
	}
	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "0" && !chk_ip("ipsec_local_start") ) errflg++;
/*	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1" && 
	     (!chk_ip("ipsec_local_start") || !chk_ip("ipsec_local_end")) ) errflg++; */
	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "1" && 
	     (!chk_ip("ipsec_local_start") || !chk_ip("ipsec_local_subnet")) ) errflg++;
	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "0" && !chk_ip("ipsec_remote_start") ) errflg++;
/*	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "3" && 
	     (!chk_ip("ipsec_remote_start") || !chk_ip("ipsec_remote_end")) ) errflg++; */
	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "1" && 
	     (!chk_ip("ipsec_remote_start") || !chk_ip("ipsec_remote_subnet")) ) errflg++;
	if ( !my_chk_fqdn(F) ) errflg++;
	if ( F.ipsec_policy_type.selectedIndex == 0 ) //AUTO
	{
		if ( !chk_blank("ipsec_sa_lifetime") ) errflg++;
		if ( ! msg_chk_range(F.ipsec_sa_lifetime.value,"ipsec_sa_lifetime",30,86400,10,IS_FIELD,0,"msg_ipsec_sa_lifetime") ) 
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
		if ( F.manual_ipsec_enc.selectedIndex != 1 && 
		     ( !chk_blank("ipsec_enc_keyin") || !chk_blank("ipsec_enc_keyout")) ) errflg++;
		if ( !chk_blank("ipsec_int_keyin") ) errflg++;
		if ( !chk_blank("ipsec_int_keyout") ) errflg++;
		
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
		else */if(!my_chk_keylen(F.ipsec_enc_keyout.value,"ipsec_enc_keyout",key_len,"msg_ipsec_enc_keyout")) 
			errflg++;

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
		}

		key_len = int_len[F.manual_ipsec_int.selectedIndex];
		if(!my_chk_keylen(F.ipsec_int_keyin.value,"ipsec_int_keyin",key_len,"msg_ipsec_int_keyin")) 
			errflg++;

		if(!my_chk_keylen(F.ipsec_int_keyout.value,"ipsec_int_keyout",key_len,"msg_ipsec_int_keyout")) 
			errflg++;
	}
	if ( errflg ) return false;
	clear_msg("ipsec_policy_name","msg_ipsec_policy_name");
	clear_msg("ipsec_endpoint_value","msg_ipsec_endpoint_value");
	clear_msg("ipsec_local_start","msg_ipsec_local_start");
	clear_msg("ipsec_remote_start","msg_ipsec_remote_start");
	var lan_same=0;
	for(var i=0; i<ipsec_entry.length; i++)
        {
                if ( F.stflg.value=="edit" && i == idx ) continue;
		lan_same=0;
                //if ( F.stflg.value!="edit") 
		{
			if (ipsec_entry[i].pname == F.ipsec_policy_name.value ) 
                	{
                        	my_alert(O_VAR,"ipsec_policy_name",__T(msg.nameexist),"0","msg_ipsec_policy_name");
	                        errflg++;
        	        }
			/*
			if ( ipsec_entry[i].end_ip == F.ipsec_endpoint_value.value ) 
                	{
                        	my_alert(O_VAR,"ipsec_endpoint_value",__T(msg.ruleexist),"0","msg_ipsec_endpoint_value");
	                        errflg++;
        	        }*/
				
			if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "0" ) 
                		var tmp_local_mask = "255.255.255.255";	
			else
				var tmp_local_mask = F.ipsec_local_subnet.value;
			if ( !chk_subnet(ipsec_entry[i].lip,ipsec_entry[i].lmask,F.ipsec_local_start.value,tmp_local_mask) ) 
			{
                        	//my_alert(O_VAR,"ipsec_local_start",__T(msg.ruleexist),"0","msg_ipsec_local_start");
	                        //errflg++;
				lan_same=1;
			}
			
			if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "0" ) 
                		var tmp_remote_mask = "255.255.255.255";	
			else
				var tmp_remote_mask = F.ipsec_remote_subnet.value;
			if ( ipsec_entry[i].rmask == "" ) 
                		var now_remote_mask = "255.255.255.255";
			else
				var now_remote_mask = ipsec_entry[i].rmask;
			if ( lan_same == 1 && !chk_subnet(ipsec_entry[i].rip,now_remote_mask,F.ipsec_remote_start.value,tmp_remote_mask) ) 			      
			{
                        	my_alert(O_VAR,"ipsec_local_start",__T(msg.ruleexist),"0","msg_ipsec_local_start");
                        	my_alert(O_VAR,"ipsec_remote_start",__T(msg.ruleexist),"0","msg_ipsec_remote_start");
	                        errflg++;
			}
			if ( !chk_subnet(F.ipsec_local_start.value,tmp_local_mask,F.ipsec_remote_start.value,tmp_remote_mask) )
			{
                        	my_alert(O_VAR,"ipsec_remote_start",__T(vpn.subneterr),"0","msg_ipsec_remote_start");
				errflg++;
			}
		}
        }
	
	if ( errflg > 0 ) return false;
	return true;
		
}

function chk_subnet(I,N1,G,N2)
{
	var IP = new Array(4);
	var NM = new Array(4);
	var GW = new Array(4);
	var NM2 = new Array(4);
	var tmp1 =0 ,tmp2 =0;

	IP = I.split(".");
	NM = N1.split(".");
	GW = G.split(".");
	NM2 = N2.split(".");

	for(var i=0;i<4;i++){
		tmp1 = IP[i] & NM[i];
		tmp2 = GW[i] & NM2[i];
		if( tmp1 != tmp2 )
		{
			return true;
		}
		
	}
	return false;
}

var reboot_flg = "<% get_reboot_flag("vpn"); %>";
var reboot_by_no_ccm_gcm, module_exist_flag;
<% get_reboot_flag("vpn_sec"); %>

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

	choose_enable(F.ipsec_policy_name);

	if ( F.ipsec_local_type[F.ipsec_local_type.selectedIndex].value == "0" ){ 
		choose_enable(F.ipsec_local_subnet);
		F.ipsec_local_subnet.value = "255.255.255.255";
	}
	if ( F.ipsec_remote_type[F.ipsec_remote_type.selectedIndex].value == "0" ){ 
		choose_enable(F.ipsec_remote_subnet);
		F.ipsec_remote_subnet.value = "255.255.255.255";
	}
	/*
	if ( typeof data[0][7] != "undefined" && data[0][7] != "" ) 
	{
		if ( data[0][8] == "" ) data[0][8] = "255.255.255.255";
		if ( !chk_subnet(data[0][7],data[0][8], F.ipsec_local_start.value, F.ipsec_local_subnet.value) )
		{
                       	my_alert(O_VAR,"ipsec_local_start",__T(msg.ruleexist),"0","msg_ipsec_local_start");
		        return false;
		}
	}*/
	
	F.gui_action.value = "Apply";

	if ( ipsec_entry[idx] && ipsec_entry[idx].st == "1" )
	{
		if ( reboot_flg == "1" ) 
			F.submit_button.value="vpn_adv_reboot";
		else
			F.submit_button.value="vpn_adv";
	}
	else
		F.submit_button.value="vpn_adv_refresh";
	if ( ipsec_entry[idx] && ipsec_entry[idx].st == "1" && 
             F.submit_button.value != "vpn_adv_reboot" ) 
	{
		if ( F.ipsec_policy_type[0].selected == true ) //AUTO
		{
			if ( F.auto_ipsec_enc.value == "aes_gcm_a-152-null" || 
	                     F.auto_ipsec_enc.value == "aes_ccm_a-152-null" ) 
			{
				if ( module_exist_flag == "1" ) 
					F.submit_button.value="vpn_adv_reboot";
			}
		}
		if ( F.ipsec_int.value == "sha2_256" ) 
		{
			if ( module_exist_flag == "1" ) 
				F.submit_button.value="vpn_adv_reboot";
		}	 
			
	}
	if ( F.submit_button.value == "vpn_adv_reboot" ) 
	{
	  	my_alert(O_GUI,WARNING,__T(share.info),__T(msg.rebootmsg),"vpn_alert_result(1)","vpn_alert_result(0)","","yesno");
	}else{
		vpn_alert_result(1);
	}
}

function vpn_alert_result(val)
{
	alert_result(0);
	var F = document.frmipsec;
	if ( val == 1 ) 
	{
		F.submit();
		if ( F.submit_button.value == "vpn_adv_reboot" ) 
			parent.document.getElementById("hidden_bg").style.display="";
		else
			parent.document.getElementById("save_bg").style.display="";
	}
}

function sel_lr_type(tname)
{
	var F = document.frmipsec;
	clear_msg("ipsec_"+tname+"_start","msg_ipsec_"+tname+"_start");
	clear_msg("ipsec_"+tname+"_subnet","msg_ipsec_"+tname+"_subnet");

	if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "0" ) //Single
	{
		choose_enable(eval("F.ipsec_"+tname+"_start"));
		choose_disable(eval("F.ipsec_"+tname+"_subnet"));
		eval("F.ipsec_"+tname+"_subnet").value = "";
	}else if ( eval("F.ipsec_"+tname+"_type")[eval("F.ipsec_"+tname+"_type").selectedIndex].value == "1" ) //Subnet
	{
		choose_enable(eval("F.ipsec_"+tname+"_start"));
		choose_enable(eval("F.ipsec_"+tname+"_subnet"));
	}

}

function to_view(F)
{
	choose_disable(F.next_page);	
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

function sel_auto_enc(F)
{
	if ( F.auto_ipsec_enc.value == "aes_gcm_a-152-null" ||
	     F.auto_ipsec_enc.value == "aes_ccm_a-152-null" )
		choose_disable(F.auto_ipsec_int);
	else
		choose_enable(F.auto_ipsec_int);
}

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
<input type=hidden name=next_page value="vpn_adv">
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN,__T(vpn.ipsecpolicy),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.editvpnconfig),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ipsecname));</script>
		<input name=ipsec_policy_name id=ipsec_policy_name size=20 maxlength=32 onblur=chk_name("ipsec_policy_name")>
		<span id=msg_ipsec_policy_name></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ptype));</script>
		<script>
		var _name = new Array(__T(mang.autop),__T(mang.manualp));
		var _val = new Array("0","1");
		draw_object(O_GUI,SELBOX,"ipsec_policy_type","id=ipsec_policy_type onchange=sel_type(this.form)",_name,_val);
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.remoteep));</script>
		<script>
                var _name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
                var _val = new Array("0","1");
                draw_object(O_GUI,SELBOX,"ipsec_endpoint_type","id=ipsec_endpoint_type",_name,_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"");</script>
		<input name=ipsec_endpoint_value id=ipsec_endpoint_value size=20 maxlength=255 onblur=my_chk_fqdn(this.form)>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com"));</script>
		<span id=msg_ipsec_endpoint_value></span>
		</TD></TR>	
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.netbiosen));</script>
		<input type=checkbox name=ipsec_netbios id=ipsec_netbios>
		</TD></TR>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.localtraffic),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.lip));</script>
		<script>
	        //var _name= new Array(__T(filter.any),__T(def.range),__T("Single"),__T("Subnet"));
	        var _name= new Array(__T(vpn.single),__T(vpn.subnet)); ;
		draw_object(O_GUI,SELBOX,"ipsec_local_type","id=ipsec_local_type onchange=sel_lr_type('local')",_name,lr_val);
		</script>
		</TD></TR>
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.startaddr)+":");</script-->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
		<input name=ipsec_local_start id=ipsec_local_start size=20 maxlength=15 onblur=chk_ip("ipsec_local_start");cal_submask(this.from,"ipsec_local_start","ipsec_local_subnet",document.frmipsec.ipsec_local_type[document.frmipsec.ipsec_local_type.selectedIndex].value);>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
		<span id=msg_ipsec_local_start></span>
		</TD></TR>	
		<!--TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.endaddr)+":");</script>
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
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.startaddr)+":");</script-->
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(router.ipaddr));</script>
                <input name=ipsec_remote_start id=ipsec_remote_start size=20 maxlength=15 onblur=chk_ip("ipsec_remote_start");cal_submask(this.from,"ipsec_remote_start","ipsec_remote_subnet",document.frmipsec.ipsec_remote_type[document.frmipsec.ipsec_remote_type.selectedIndex].value);>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4"));</script>
                <span id=msg_ipsec_remote_start></span>
                </TD></TR>
                <!--TR><script>draw_td(O_GUI,SUBTITLE,__T(ipv6.endaddr)+":");</script>
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
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.spiincom));</script>
                <input name=ipsec_spi_income id=ipsec_spi_income size=20 maxlength=6 value="0x">
                <span id=msg_ipsec_spi_income></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.spioutgoing));</script>
                <input name=ipsec_spi_outgo id=ipsec_spi_outgo size=20 maxlength=6 value="0x">
                <span id=msg_ipsec_spi_outgo></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.mencryalg));</script>
                <script>
                //var _name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256),__T(mang.aescgm),__T(mang.aesccm));
                var _name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
                draw_object(O_GUI,SELBOX,"manual_ipsec_enc","id=manual_ipsec_enc ",_name,enc_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyin));</script>
                <input name=ipsec_enc_keyin id=ipsec_enc_keyin size=20 maxlength=64>
                <span id=msg_ipsec_enc_keyin></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyout));</script>
                <input name=ipsec_enc_keyout id=ipsec_enc_keyout size=20 maxlength=64>
                <span id=msg_ipsec_enc_keyout></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.mintegrityalg));</script>
                <script>
                var _name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
                //var _name= new Array(__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"),__T("MD5"));
                draw_object(O_GUI,SELBOX,"manual_ipsec_int","id=manual_ipsec_int",_name,int_val);
                </script>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyin));</script>
                <input name=ipsec_int_keyin id=ipsec_int_keyin size=20 maxlength=64>
                <span id=msg_ipsec_int_keyin></span>
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.keyout));</script>
                <input name=ipsec_int_keyout id=ipsec_int_keyout size=20 maxlength=64>
                <span id=msg_ipsec_int_keyout></span>
                </TD></TR>
		<input type=hidden name=end_manual> 
		<input type=hidden name=start_auto> 
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(vpn.autopp),"colspan=2");</script></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.ipsecsatime));</script>
                <input name=ipsec_sa_lifetime id=ipsec_sa_lifetime size=20 value=3600 maxlength=5 onblur=msg_chk_range(this.value,"ipsec_sa_lifetime",30,86400,10,IS_FIELD,0,"msg_ipsec_sa_lifetime")> <script>Capture(unit.seconds);</script><script>document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"30","86400","3600"));</script>
                <span id=msg_ipsec_sa_lifetime></span>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.encryalg));</script>
                <script>
                //var _name= new Array(__T("3DES"),__T(logemail.authnone),__T(mang.des),__T("AES-128"),__T("AES-192"),__T("AES-256"),__T("AES-CCM"),__T("AES_GCM"));
                var _name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256),__T(mang.aescgm),__T(mang.aesccm));
                draw_object(O_GUI,SELBOX,"auto_ipsec_enc","id=auto_ipsec_enc onchange=sel_auto_enc(this.form)",_name,auto_enc_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.integrityalg));</script>
                <script>
                //var _name= new Array(__T("SHA-1"),__T("SHA2-256"),__T("SHA2-384"),__T("SHA2-512"),__T("MD5"));
                var _name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
                draw_object(O_GUI,SELBOX,"auto_ipsec_int","id=auto_ipsec_int",_name,int_val);
                </script>
                </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.pfskeygroup));</script>
		<input type=checkbox name=ipsec_pfs_enable id=ipsec_pfs_enable onclick=chk_enpfs(this.form)> <script>Capture(share.enable)</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(vpn.dhgroup));</script>
                <script>
                var _name= new Array(__T(vpn.dhgroup1),__T(vpn.dhgroup2),__T(vpn.dhgroup5));
                draw_object(O_GUI,SELBOX,"ipsec_pfs_group","id=ipsec_pfs_group",_name,dh_val);
                </script>
                </TD></TR>
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
