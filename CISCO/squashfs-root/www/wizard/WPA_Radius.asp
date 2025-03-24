		<TR><script>draw_td(O_GUI,SUBTITLE,__T(wl.encryption)+":");
		    var data, words, selflg,c_mode;
		     
			if( s_mode == "wpa_enterprise") 
			{
				data = new Array("tkip+aes","aes");
				words= new Array(__T(wl.tkipaes1),__T(mang.aes));
				c_mode = eval("nv_wl_crypto_"+now_idx);
				draw_object(O_GUI,SELBOX,"wl_crypto","",words,data,c_mode);
			}
			else if (s_mode == "wpa2_enterprise")
			{	// wpa2_enterprise
				Capture(mang.aes);
			}else{
				Capture(wl.tkipaes);
			}
		</script>
		</td></tr>					
		<% web_include_file("wizard/Radius.asp"); %>
