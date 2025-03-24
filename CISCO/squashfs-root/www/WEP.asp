<script>
<% web_include_file("md5.js"); %>
<% wl_multi_nvram_get("wl_wep_bit"); %>
<% wl_multi_nvram_get("wl_passphrase"); %>
<% wl_multi_nvram_get("wl_key1"); %>
<% wl_multi_nvram_get("wl_key2"); %>
<% wl_multi_nvram_get("wl_key3"); %>
<% wl_multi_nvram_get("wl_key4"); %>
<% wl_multi_nvram_get("wl_key"); %>
function ToHex(i)
{
	h="0123456789abcdef";
	return h.charAt((i>>4)&0x0f)+h.charAt(i&0x0f);
}

function WEP_GEN(passphrase,wep_bit)
{
	var tmp = "";
	var i;
	if ( wep_bit == '64' ){
		var rand=0;
		for(i=0;i<passphrase.length;i++) rand^=(passphrase.charCodeAt(i)<<((i%4)*8));
		for (i=0;i<4;i++){
			var s = "";
			for(var j=0; j<5; j++){
				rand*=0x343fd;
				rand+=0x269ec3;
				rand&=0xffffffff;
				s+=ToHex(rand>>16);
			}
			if ( tmp != "" ) tmp += ",";
			tmp += s.toUpperCase();
		}	
	}else{
		var seed="";
		for(i=0; i<64; i++) seed += passphrase.charAt(i%passphrase.length);
		tmp = hex_md5(seed).slice(0,26).toUpperCase()+",";
		seed="";
		passphrase+="#$%";
		for(i=0; i<64; i++) seed += passphrase.charAt(i%passphrase.length);
		tmp += hex_md5(seed).slice(2,28).toUpperCase()+",";
		seed="";
		passphrase+="!@#";
		for(i=0; i<64; i++) seed += passphrase.charAt(i%passphrase.length);
		tmp += hex_md5(seed).slice(4,30).toUpperCase()+",";
		seed="";
		passphrase+="%&^";
		for(i=0; i<64; i++) seed += passphrase.charAt(i%passphrase.length);
		tmp += hex_md5(seed).slice(6,32).toUpperCase();
		
	}
	return tmp;

}
function gen_key(F){
        if (F.wl_passphrase.value == "")
        {
              parent.document.getElementById("obj_id").value = "_ph";
              my_alert(O_VAR,"wl_passphrase",__T(msg.passphnotblank),"0","_ph");
               return false;
        }

	for(var i=0; i<4; i++) eval("F.wl_key"+(i+1)).value ="";

	var tmp,key;
	var bit
	tmp = WEP_GEN(F.wl_passphrase.value, parseInt(F.wl_wep_bit.value,10));
	key = tmp.split(",");
	for(var i=0; i<4; i++)
	{
		if ( parseInt(F.wl_wep_bit.value,10) == 64 ) 
		{
			if ( F.chk_unmaskpwd.checked == true ) 
				eval("F.wl_key"+(i+1)).maxLength = 10;
			else
				eval("F.swl_key"+(i+1)).maxLength = 10;
		}
		else
		{
			if ( F.chk_unmaskpwd.checked == true ) 
				eval("F.wl_key"+(i+1)).maxLength = 26;
			else
				eval("F.swl_key"+(i+1)).maxLength = 26;
		}
		if ( F.chk_unmaskpwd.checked == true ) 
			eval("F.wl_key"+(i+1)).value = key[i];
		else
			eval("F.swl_key"+(i+1)).value = key[i];
	}
}

function chk_key(oid,sid)
{
	clear_msg(oid,sid);
	var errmsg =  valid_meaning_id_name(MEANING_NAME,document.getElementById(oid).value,ZERO_OK);
	if ( errmsg != "" ) 
	{
		my_alert(O_VAR,oid,errmsg,"0",sid);
		return false;
	}
	return true;
}

function schk_key(id)
{
	if ( F.chk_unmaskpwd.checked == true ) 
		chk_key('id_key'+id,'msg_key'+id);
	else
		chk_key('sid_key'+id,'msg_key'+id);
}

function schg_wepbit(id)
{
	//document.getElementById("id_key"+id).value  = document.getElementById("sid_key"+id).value;
	//chg_wepbit(id);
}

function Sel_unmaskpwd(F)
{
	for(var i=1; i<=4; i++)
	{
		if ( F.chk_unmaskpwd.checked == true ) 
		{	
			document.getElementById("id_key"+i).value = document.getElementById("sid_key"+i).value
			document.getElementById("id_key"+i).style.display="";
			document.getElementById("sid_key"+i).style.display="none";
		}else{
			document.getElementById("sid_key"+i).value = document.getElementById("id_key"+i).value
			document.getElementById("id_key"+i).style.display="none";
			document.getElementById("sid_key"+i).style.display="";
		}
	}
}
</script>		
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.encryption));
			var datalist = new Array("64","128");
			var vlist = new Array(__T(wl.hex_10),__T(wl.hex_26));
			draw_object(O_GUI,SELBOX,"wl_wep_bit","onChange=chg_wepbit(1)",vlist,datalist,eval("nv_wl_wep_bit_"+now_idx));
                </script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.passphrase));</script>
		<script>document.write("<INPUT maxLength=16 id=wl_passphrase value='"+eval("nv_wl_passphrase_"+now_idx)+"' name=wl_passphrase>");
		</script>&nbsp;&nbsp;&nbsp;
		<script>document.write("<INPUT type=hidden value=Null name=generateButton><INPUT type=button class=BT_L id=e3 onMouseover=bt(\"e3\",\"move\") onMouseout=bt(\"e3\",\"out\") onMousedown=bt(\"e3\",\"down\")  onclick=gen_key(this.form) name=wepGenerate value="+__T(wl.generate)+">");
		</script>
		<span id=_ph></span>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,spell_words(key_rule,"1")+":");</script>
		<script>
		document.write("<INPUT type=password size=35 name=swl_key1 id=sid_key1 maxlength=10 value='"+eval("nv_wl_key1_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('sid_key1','msg_key1')>");
		document.write("<INPUT style='display:none' size=35 name=wl_key1 id=id_key1 maxlength=10 value='"+eval("nv_wl_key1_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key1','msg_key1')><SPAN id=msg_key1></SPAN>");
		</script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,spell_words(key_rule,"2")+":");</script>
                <script>
                document.write("<INPUT type=password size=35 name=swl_key2 id=sid_key2 maxlength=10 value='"+eval("nv_wl_key2_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key2','msg_key2')>");
                document.write("<INPUT style='display:none' size=35 name=wl_key2 id=id_key2 maxlength=10 value='"+eval("nv_wl_key2_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key2','msg_key2')><SPAN id=msg_key2></SPAN>");
                </script>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,spell_words(key_rule,"3")+":");</script>
                <script>
		document.write("<INPUT type=password size=35 name=swl_key3 id=sid_key3 maxlength=10 value='"+eval("nv_wl_key3_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key3','msg_key3')>");
		document.write("<INPUT style='display:none' size=35 name=wl_key3 id=id_key3 maxlength=10 value='"+eval("nv_wl_key3_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key3','msg_key3')><SPAN id=msg_key3></SPAN>");
                </script>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,spell_words(key_rule,"4")+":");</script>
                <script>
		document.write("<INPUT type=password size=35 name=swl_key4 id=sid_key4 maxlength=10 value='"+eval("nv_wl_key4_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key4','msg_key4')>");
		document.write("<INPUT style='display:none' size=35 name=wl_key4 id=id_key4 maxlength=10 value='"+eval("nv_wl_key4_"+now_idx)+"' onKeyPress=chg_wepbit(0) onblur=chk_key('id_key4','msg_key4')><SPAN id=msg_key4></SPAN>");
                </script>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.txkey),"style=padding-bottom:10px","style=padding-bottom:10px");</script>
		<script>
			var val= new Array("ISRANGE","1","4","1");
			draw_object(O_GUI,SELBOX,"wl_key","",val,val,eval("nv_wl_key_"+now_idx));
		</script>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.unmaskpwd));</script>
		<input type=checkbox name=chk_unmaskpwd onClick=Sel_unmaskpwd(this.form)>
		</TD></TR>
