<html>
<head>
<% web_include_file("wizard_vpn/wizard_filelink.asp"); %>
<script language="JavaScript">
var enc_name= new Array(__T(mang.des3),__T(mang.des),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256),__T(mang.aescgm),__T(mang.aesccm));
var enc_val= new Array("3des","des","aes128","aes192","aes256","aes_gcm_a-152-null","aes_ccm_a-152-null");
                
var auth_name= new Array(__T(mang.sha1),__T(mang.sha2),__T(mang.md5));
var auth_val = new Array("sha1","sha2_256","md5");

function init()
{
	var F = document.wz_welcome;  
	F.lifetime.value = parse_data("ipsec_lifetime");
	var enc = parse_data("enc_type"); 
	for(var i=0; i<enc_val.length; i++)
	{
		if( enc == enc_val[i] ) 
		{
			F.enc_type[i].selected = true 
			break;
		}
	}
	var auth = parse_data("auth_type");
	for(var i=0; i<auth_val.length; i++)
	{
		if ( auth == auth_val[i] )
		{
			F.auth_type[i].selected = true;
			break;
		}
	}
	
}
function uiDoCancel(F)
{
        my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
		top.location.href = goto_link("/default.asp");
}

function goto_prev(F)
{
	document.location.href=goto_link("lr_network.asp");
}

function goto_next(F)
{
	if ( !my_chk_range("lifetime",30,86400,"msg_lifetime") ) return;
	save_data("ipsec_lifetime", F.lifetime.value);
	save_data("enc_type",F.enc_type.value);
	save_data("auth_type",F.auth_type.value);
	document.location.href=goto_link("ike.asp");
}

function my_chk_range(obj_id,start,end,span_id)
{
	w_clear_alert("msg_lifetime",0,"lifetime");
	if ( !chk_range(obj_id,document.getElementById(obj_id).value,start,end,10) ) 
	{
		w_set_alert(span_id,0,obj_id,spell_words(range_rule,start,end));
		return false;
	}
	return true;
}
</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
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
    	 <script>create_process_title(3,4);</script>
	 <TR><TD class=DATA_TITLE colspan=6><script>Capture("Transfrom Policy");</script></TD></TR>
    	 <TR><TD colspan=6 valign=top>
    	 <TABLE>
	 <TR><TD valign=top class=DATA_ITEM><script>CaptureC(vpn.autopp);</script></TD></TR>
	 <TR><TD valign=top class=DATA_ITEM>
	 <TABLE><TR><TD><script>CaptureC(vpn.ipsecsatime);</script></TD><TD><input size=20 maxlength=5 id=lifetime name=lifetime onblur=my_chk_range("lifetime",30,86400,"msg_lifetime")><span id=msg_lifetime></span></TD></TR>
		<TR><TD><script>CaptureC(vpn.encryalg);</script></TD><TD>
		<script>
		draw_object(O_GUI,SELBOX,"enc_type","",enc_name,enc_val,"");
		</script>
		</TD></TR>
		<TR><TD><script>Capture(vpn.authalg);</script>:</TD>
		<TD><script>
		draw_object(O_GUI,SELBOX,"auth_type","",auth_name,auth_val,"");
		</script></TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE></TD></TR>
	 </TD></TR>
         <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>
	create_button("goto_prev(this.form)","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
