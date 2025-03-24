function get_cpwd_wl_security(en_pwd,key,get_type)
{
	var tmp=0;
	var nv_len = parseInt('<% nvram_get("pwd_minlen"); %>',10);
	var nv_class = parseInt('<% nvram_get("pwd_minclass"); %>',10);
	if ( en_pwd == 1 )
	{
		if ( get_type == "class" ) 
		{
			if ( key.length == 64 && nv_class > 2 ) 
				tmp = 2;
			else if ( nv_class == 0 ) 
				tmp = 1;
			else
				tmp = nv_class;
		}else if ( get_type == "len" ){
			if ( nv_len < 8 ) 
				tmp = 8;
			else
				tmp = nv_len;
		}
	}else{
		if ( get_type == "class" ) tmp = 1;
		else if ( get_type == "len" ) tmp = 8;
	}
	return tmp;
}
