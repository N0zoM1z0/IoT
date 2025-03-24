<html>
<head>
<% web_include_file("wizard_vpn/wizard_filelink.asp"); %>
<script language="JavaScript">
var mode_name = new Array(__T(mang.main),__T(mang.agg));
var mode_val = new Array("main","aggressive");
var enc_name= new Array(__T(mang.des),__T(mang.des3),__T(mang.aes128),__T(mang.aes192),__T(mang.aes256));
var enc_val= new Array("des","3des","aes128","aes192","aes256");
var auth_name= new Array(__T(mang.md5),__T(mang.sha1),__T(mang.sha2));
var auth_val= new Array("md5","sha1","sha2_256");

function init()
{
/*
	choose_disable(document.getElementById("w1"));
	choose_disable(document.getElementById("w2"));
	var F = document.wz_welcome;
	setTimeout('get_status()', 2000);		
	def_nv = keep_val(F,""); 
*/
	
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
	document.location.href=goto_link("trans.asp");
}

function valid_value(F)
{
	if ( !my_chk_range("lifetime",30,86400,"msg_lifetime") ) return false;
	if ( !chk_psk(F) ) return false;
	return true;
}

function goto_next(F)
{
	if ( !valid_value(F) ) return;
	save_data("ike_mode", F.ike_exchange_mode.value);
	save_data("ike_enc", F.ike_encrypt_algo.value);
	save_data("ike_auth", F.ike_auth_algo.value);
	save_data("ike_psk", F.ike_psk.value);
	save_data("ike_lifetime", F.lifetime.value);
	set_nv(F);
	F.submit_button.value = "wizard_vpn/complete_setup";
        F.submit();
	choose_disable(document.getElementById("w1"));
	choose_disable(document.getElementById("w2"));
	choose_disable(document.getElementById("w3"));
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

function chk_psk(F)
{
        w_clear_alert("msg_psk",0,"ike_psk");
	/*
        if ( chk_chartype(document.getElementById("ike_psk").value,ISCHAR) == FAIL ) 
        {
                w_set_alert("msg_psk",0,"ike_psk",__T(msg.hostnameformat1),"down");
                return false;   
        }*/

        if ( F.ike_psk.value.length < 8 ) 
        {
                w_set_alert("msg_psk",0,"ike_psk",__T(vpn.errkeymsg),"down");
                return false;
        }
        return true;
}

function set_nv(F)
{
	var nv_list = new Array("ipsec_name","ipsec_remote_etype","ipsec_remote_endpoint","local_type",
				"local_ip","local_mask","remote_type","remote_ip","remote_mask","ipsec_lifetime",
				"enc_type","auth_type","ike_mode","ike_enc","ike_auth","ike_psk","ike_lifetime");
        for(var i=0; i<nv_list.length; i++)
	{
                var tmp = parse_data(nv_list[i]);
                if ( tmp != "" ) 
                	eval("F.w"+nv_list[i]).value = tmp;      
	
	}
}


</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_welcome" method=<% get_http_method(); %>>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=wizard_start>
<input type=hidden name=wipsec_name>
<input type=hidden name=wipsec_remote_etype>
<input type=hidden name=wipsec_remote_endpoint>
<input type=hidden name=wlocal_type>
<input type=hidden name=wlocal_ip>
<input type=hidden name=wlocal_mask>
<input type=hidden name=wremote_type>
<input type=hidden name=wremote_ip>
<input type=hidden name=wremote_mask>
<input type=hidden name=wipsec_lifetime>
<input type=hidden name=wenc_type>
<input type=hidden name=wauth_type>
<input type=hidden name=wike_mode>
<input type=hidden name=wike_enc>
<input type=hidden name=wike_auth>
<input type=hidden name=wike_psk>
<input type=hidden name=wike_lifetime>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE cellspacing=0>
    <script>create_title();</script>
    <TR><TD colspan=2 class=LAYER_STYLE>
    <TABLE class=CONTENT_DATA id=tb>
    	 <script>create_process_title(4,5);</script>
	 <TR><TD class=DATA_TITLE colspan=6><script>Capture(vpn.ikepolicy);</script></TD></TR>
    	 <TR><TD colspan=6 valign=top>
    	 <TABLE><!--TR><TD valign=top class=DATA_ITEM><script>Capture(vpn.ikesa);</script></TD></TR-->
    	 	<TR><TD valign=top class=DATA_ITEM2>
	 <TABLE><TR><TD><script>Capture(vpn.exmode);</script>:</TD><TD>
		<script>
		draw_object(O_GUI,SELBOX,"ike_exchange_mode","",mode_name,mode_val);
		</script>
		</TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE>
    	 <TABLE><!--TR><TD valign=top class=DATA_ITEM><script>Capture(vpn.ikesa);</script></TD></TR-->
    	 	<TR><TD valign=top class=DATA_ITEM2>
	 <TABLE><TR><TD><script>Capture(vpn.encryalg);</script>:</TD><TD>
		<script>
		draw_object(O_GUI,SELBOX,"ike_encrypt_algo","id=ike_encrypt_algo ",enc_name,enc_val);
		</script>
		</TD></TR>
		<TR><TD><script>Capture(vpn.authalg);</script>:</TD><TD>
		<script>
                draw_object(O_GUI,SELBOX,"ike_auth_algo","id=ike_auth_algo ",auth_name,auth_val);
		</script>
		</TD></TR>
		<TR><TD><script>CaptureC(vpn.preskey);</script></TD>
		<TD><span id=msg_psk></span><BR><input size=32 name=ike_psk id=ike_psk maxlength=49 onblur=chk_psk(this.form)></TD></TR>
		<TR><TD><script>CaptureC(vpn.satime);</script></TD><TD><input size=32 maxlength=5 name=lifetime id=lifetime onblur=my_chk_range("lifetime",30,86400,"msg_lifetime")><span id=msg_lifetime></span></TD></TR>
	 </TD></TR></TABLE></TD></TR></TABLE>
	 </TD></TR>
         <TR><TD class=DATA_SHOWTOP colspan=6>
	<script>
	if ( http_power == "r" ) 
		Capture(wz.clicknext1);
	else
    		Capture(wz.clicksubmit1);
	</script></TD></TR> 
    </TABLE></TD></TR>
    <script>
    	if ( http_power == "r" )
		create_button("onClick=document.location.href=goto_link(\"trans.asp\")","onClick=document.location.href=goto_link(\"complete_setup.asp\")","");
	else 
		create_button("goto_prev(this.form)","","goto_next(this.form)");
		
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
