<script>
<% wl_multi_nvram_get("wl_radius_ipaddr"); %>
<% wl_multi_nvram_get("wl_radius_port"); %>
<% wl_multi_nvram_get("wl_radius_key"); %>
</script>
<input type=hidden name=wl_radius_ipaddr value=4> <!-- For merge save -->
	<TR><script>draw_td(O_GUI,SUBTITLE, __T(wl.radiusserver)+":");</script>
	  <span id=_rip></span>
		<TABLE cellspacing=0 border=0><TR><TD>
	  <script>
           var def_ip = eval("nv_wl_radius_ipaddr_"+now_idx);
	   if ( def_ip == '' ) def_ip = "0.0.0.0";
	   draw_object(O_GUI,IP,"wl_radius_ipaddr",def_ip);
	   document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"192.168.1.200")); 
	  </script></TD></TR></TABLE>
	  </TD></TR>
          <TR><script>draw_td(O_GUI,SUBTITLE, __T(wl.radiusport)+":");</script>
	  <span id=_port></SPAN>
	  <TABLE cellspacing=0 border=0><TR><TD>
	  <script>
          document.write("<INPUT size=5 name=wl_radius_port id=wl_radius_port value='"+eval("nv_wl_radius_port_"+now_idx)+"' maxlength=5>");
	  document.write("&nbsp;&nbsp;"+spell_words(range_def_rule,"1","65535","1812")); 
	  </script></TD></TR></TABLE>
	  </td></TR>
          <TR><script>draw_td(O_GUI,SUBTITLE, __T(wl.sharedkey)+":");</script>
	  <span id=_key></span>
	  <TABLE cellspacing=0 border=0><TR><TD>
	  <script>
          document.write("<INPUT size=20 id=wl_radius_key name=wl_radius_key value='"+eval("nv_wl_radius_key_"+now_idx)+"' maxlength=79>");
	  </script></TD></TR></TABLE>
	  </td></TR>
