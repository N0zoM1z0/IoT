<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
var r_ep_name = new Array(__T(router.ipaddr),__T(vpn.fqdn));
var ltype_name = new Array(__T(router.ipaddr),__T(vpn.subnet));
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
var vpn_enc= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256),__T(mang.aescgm),__T(mang.aesccm));
var vpn_enc_val= new Array("3des","des","aes128","aes192","aes256","aes_gcm_a-152-null","aes_ccm_a-152-null");

var vpn_auth_name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
var vpn_auth_val = new Array("sha1","sha2_256","md5");

var mode_name = new Array(__T(mang.main),__T(mang.agg));
var mode_val = new Array("main","aggressive");

var auth_name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
var auth_val= new Array("md5","sha1","sha2_256");

var enc_name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
var enc_val= new Array("des","3des","aes128","aes192","aes256");

var ike = new Array();
<% get_site2site_adv_ike("ike","AAA"); %>

var ipsec = new Array();
<% get_site2site_adv_ipsec("ipsec","BBB"); %>

var selidx=ipsec.length-1;

function init()
{
	choose_disable(document.getElementById("w1"));
	choose_disable(document.getElementById("w3"));
}

function to_finish()
{
	top.location.href = goto_link("/default.asp");
	
}

function to_back()
{
	document.location.href=goto_link("complete_setup.asp");
	
}

</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=wizard_start>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
     <script>create_process_title(6,6);</script>
    <TR><TD class=DATA_TITLE2 colspan=6><script>Capture(router.summary);</script></TD></TR>
    <TR><TD colspan=6 class=DATA_TITLE>
    <TABLE>
    	<TR><TD colspan=2><script>Capture(vpn.ikepolicy);</script></TD>
	    <TD width=5%></TD><TD colspan=2><script>Capture(vpn.policy);</script></TD></TR>
	<TR><TD nowrap><script>CaptureC(vpn.exmode);</script></TD>
	    <TD><script>
			for(var i=0; i<mode_val.length; i++)
			{
			    if ( mode_val[i] == ike[selidx].emode ) 
			    {
				    document.write(mode_name[i]);
				    break;
			    }
			}
            </script></TD>
	    <TD></TD>
	    <TD nowrap><script>CaptureC(wl.profilename);</script></TD>
	    <TD><script>document.write(ipsec[selidx].pname);</script></TD></TR>
	<TR><TD nowrap><script>CaptureC(vpn.encryalg);</script></TD>
	    <TD><script>
		for(var i=0; i<enc_val.length; i++)
		{
			if ( ike[selidx].esp == enc_val[i] )
			{
				document.write(enc_name[i]);
				break;
			}
		}
	    </script></TD>
	    <TD></TD>
            <TD nowrap><script>CaptureC(vpn.remoteeptype);</script></TD>
	    <TD><script>document.write(r_ep_name[ipsec[selidx].end_type]);</script></TD></TR>
	<TR><TD nowrap><script>CaptureC(vpn.authalg);</script></TD>
	    <TD><script>
			for(var i=0; i<auth_val.length; i++)
			{
				if ( auth_val[i] == ike[selidx].ah )
				{
					document.write(auth_name[i]);
					break;
				}
			}
	    </script></TD>
	    <TD></TD>
            <TD nowrap><script>CaptureC(vpn.remoteep);</script></TD>
	    <TD><script>document.write(ipsec[selidx].end_ip);</script></TD></TR>
	<TR><TD nowrap><script>CaptureC(vpn.preskey);</script></TD>
	    <TD><script>document.write(ike[selidx].psk);</script></TD>
	    <TD></TD>
	    <TD nowrap><script>CaptureC(vpn.localidenttype);</script></TD>
	    <TD><script>document.write(ltype_name[ipsec[selidx].ltype]);</script></TD></TR>
	<TR><TD nowrap><script>CaptureC(vpn.ikesalife);</script></TD>
            <TD><script>document.write(ike[selidx].sa_life);</script></TD>
            <TD></TD>
            <TD nowrap><script>CaptureC(vpn.lip);</script></TD>
	    <TD><script>
		document.write(ipsec[selidx].lip);
		if ( ipsec[selidx].lmask != "" ) document.write("/"+ipsec[selidx].lmask);</script></TD></TR>
	<TR><TD colspan=3></TD><TD nowrap><script>CaptureC(vpn.remoteidenttype);</script></TD>
	    <TD><script>document.write(ltype_name[ipsec[selidx].rtype]);</script></TD></TR>
	<TR><TD colspan=3></TD><TD nowrap><script>CaptureC(vpn.remoteip);</script></TD>
	    <TD><script>
		document.write(ipsec[selidx].rip);
		if ( ipsec[selidx].rmask != "" ) document.write("/"+ipsec[selidx].rmask);</script></TD></TR>
	<TR><TD colspan=3></TD><TD nowrap><script>CaptureC(vpn.ipsecsatime);</script></TD>
	    <TD><script>document.write(ipsec[selidx].life_time);</script></TD></TR>
	<TR><TD colspan=3></TD><TD nowrap><script>CaptureC(vpn.encryalg);</script></TD>
	    <TD><script>
		for(var i=0; i<vpn_enc.length; i++)
		{
			if ( vpn_enc_val[i] == ipsec[selidx].esp )
			{
				document.write(vpn_enc[i]);
				break;
			}
		}
	        </script>
	    </TD></TR>
	<TR><TD colspan=3></TD><TD nowrap><script>CaptureC(vpn.authalg);</script></TD>
	    <TD><script>
			for(var i=0; i<vpn_auth_val.length; i++)
			{
				if ( vpn_auth_val[i] == ipsec[selidx].ah )
				{
					document.write(vpn_auth_name[i]);
					break;
				}
			}
	    </script></TD></TR>
    <TR><TD class=DATA_DETAIL colspan=6><script>Capture(wz.clickfinish);</script></TD></TR>
    </TABLE>
	</TD></TR> 
    </TABLE></TD></TR>
    <script>
    document.write("<TR><TD></TD><TD class=DATA_BT>");
    draw_object(O_GUI,BT,__T(share.back),"w1","BT","");
    document.write("&nbsp;&nbsp;");
    draw_object(O_GUI,BT,__T(filter.finish),"w2","BT","to_finish()");
    document.write("&nbsp;&nbsp;");
    draw_object(O_GUI,BT,__T(share.cancel),"w3","BT","");
    document.write("</TD></TR>");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
