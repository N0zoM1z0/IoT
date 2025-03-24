<html>
<head>
<title>Time Settings</title>
<% web_include_file("filelink.asp"); %>
<script language="JavaScript">
var ntptime = "<% nvram_get("ntp_manual_time"); %>".split(" ");
function AAA(val,name)
{
	this.name=name;
	this.val=val;
}
var timezone_arr= new Array();
timezone_arr[0] = new AAA("-12 1 0",__T(timezone.International));
timezone_arr[1] = new AAA("-11 1 0",__T(timezone.Midway));
timezone_arr[2] = new AAA("-10 1 0",__T(timezone.Hawaii));
timezone_arr[3] = new AAA("-09 1 1",__T(timezone.Alaska));
timezone_arr[4] = new AAA("-08 1 1",__T(timezone.Pacific));
timezone_arr[5] = new AAA("-07 1 0",__T(timezone.Arizona));
timezone_arr[6] = new AAA("-07 2 1",__T(timezone.Mountain));
//timezone_arr[7] = new AAA("-06 1 0",__T(timezone.Mexico));
timezone_arr[7] = new AAA("-06 1 1",__T(timezone.Mexico));
timezone_arr[8] = new AAA("-06 2 1",__T(timezone.Central));
timezone_arr[9] = new AAA("-05 1 0",__T(timezone.Indiana));
timezone_arr[10] = new AAA("-05 2 1",__T(timezone.Eastern));
timezone_arr[11] = new AAA("-04 1 0",__T(timezone.Bolivia));
timezone_arr[12] = new AAA("-04 2 1",__T(timezone.Atlantic));
timezone_arr[13] = new AAA("-04 3 0",__T(timezone.Guyana));
timezone_arr[14] = new AAA("-03.5 1 1",__T(timezone.Newfoundland));
timezone_arr[15] = new AAA("-03 2 1",__T(timezone.Brazil));
//timezone_arr[16] = new AAA("-02 1 0",__T(timezone.Mid));
timezone_arr[16] = new AAA("-02 1 1",__T(timezone.Mid));
timezone_arr[17] = new AAA("-01 1 2",__T(timezone.Azores));
timezone_arr[18] = new AAA("+00 1 0",__T(timezone.Gambia));
timezone_arr[19] = new AAA("+00 2 2",__T(timezone.England));
timezone_arr[20] = new AAA("+01 1 0",__T(timezone.Tunisia));
timezone_arr[21] = new AAA("+01 2 2",__T(timezone.France));
timezone_arr[22] = new AAA("+02 1 0",__T(timezone.South));
timezone_arr[23] = new AAA("+02 2 2",__T(timezone.Greece));
timezone_arr[24] = new AAA("+03 1 0",__T(timezone.Iraq));
timezone_arr[25] = new AAA("+04 1 0",__T(timezone.Armenia));
timezone_arr[26] = new AAA("+05 1 0",__T(timezone.Pakistan));
timezone_arr[27] = new AAA("+05.5 1 0",__T(timezone.india));
timezone_arr[28] = new AAA("+06 1 0",__T(timezone.Bangladesh));
timezone_arr[29] = new AAA("+07 1 0",__T(timezone.Thailand));
timezone_arr[30] = new AAA("+08 1 0",__T(timezone.China));
timezone_arr[31] = new AAA("+08 2 0",__T(timezone.Singapore));
timezone_arr[32] = new AAA("+09 1 0",__T(timezone.Japan));
timezone_arr[33] = new AAA("+10 1 0",__T(timezone.Guam));
timezone_arr[34] = new AAA("+10 2 4",__T(timezone.Australia));
timezone_arr[35] = new AAA("+11 1 0",__T(timezone.Solomon));
timezone_arr[36] = new AAA("+12 1 0",__T(timezone.Fiji));
timezone_arr[37] = new AAA("+12 2 4",__T(timezone.New_Zealand));
timezone_arr[38] = new AAA("+12 3 0",__T(timezone.Kwajalein));
var daylight_start = "<% nvram_get("daylight_start"); %>";
var daylight_end = "<% nvram_get("daylight_end"); %>";
var data_month_s = daylight_start.split("/");
var data_month_e = daylight_end.split("/");
//Fixed 2011/05/16 add dat by week start 
var recu_data_start = "<% nvram_get("recu_daylight_start"); %>";
var recu_data_end = "<% nvram_get("recu_daylight_end"); %>";
var recu_data_s = recu_data_start.split("/");
var recu_data_e = recu_data_end.split("/");
//Fixed 2011/05/16 add dat by week end
var s_year = 2011;
var e_year = 2037;
//Fixed 2010/10/04 Add menu daylight start
function en_daylight(F)
{
	if( F._daylight_time.checked == true ) 
	{
		DISABLE_PART(F,"start_daylight","end_daylight",0);
	}
	else
	{
		DISABLE_PART(F,"start_daylight","end_daylight",1);
		DISABLE_PART(F,"start_seldays","end_seldays",1);
		DISABLE_PART(F,"start_selrecu","end_selrecu",1);
	}

	if("<% nvram_get("dst_mode"); %>" == "")  
		F.dst_mode[0].checked = true;

	//Fixed 2011/05/16 add dat by week 
	dst_mode_sel(F);
		
}
//Fixed 2010/10/04 Add menu daylight end

function en_fun(F)
{
	DISABLE_PART(F,"start_manual","end_manual",0);
	DISABLE_PART(F,"start_auto","end_auto",0);
	if ( F.ntp_mode[0].checked == true )
	{
		DISABLE_PART(F,"start_manual","end_manual",1);		
                choose_enable(F._daylight_time);                
		en_daylight(F);

		//if ( F.ntp_use_default_sel[0].checked == true )
		if ( F.ntp_use_default[0].checked == true )
			chk_ntp(1);
		else
			chk_ntp(0);
	}
	else
	{
		DISABLE_PART(F,"start_auto","end_auto",1);
                choose_disable(F._daylight_time);                
		DISABLE_PART(F,"start_daylight","end_daylight",1);
	}	
}

function init()
{
	var F = document.frmtime;
	parent.document.getElementById("save_bg").style.display="none";
	//SelTime("<% nvram_get("time_zone"); %>",F);
	en_fun(F);
	
	//en_daylight(F);
	chg_month(F);
	
	chg_day(F, parseInt(data_month_s[0],10),parseInt(data_month_s[1],10)-1,'s');
	chg_day(F, parseInt(data_month_e[0],10),parseInt(data_month_e[1],10)-1,'e');

	if("<% nvram_get("ntp_mode"); %>" == "manual")
		F.day[parseInt(ntptime[1],10)-1].selected = true;
	default_nv = keep_val(F,"");
	//Fixed 2010/10/04 Add menu daylight start
	if("<% nvram_get("dst_mode"); %>" == "")
		F.dst_mode[0].checked = true;
}

function valid_value(F){
	var errflg = 0 ;
	clear_msg("ntp_server","msg_ntp_ip");
	clear_msg("ntp_server2","msg_ntp2_ip");
	if ( F.ntp_mode[0].checked == true )
	{
		if ( F.ntp_use_default[1].checked == true ) 
		{
			if ( !check_ip_domain(F.ntp_server.value) ) 
			{
				my_alert(O_VAR,"ntp_server",__T(ddnsm.dyn_notfqdnip),0,"msg_ntp_ip");
				errflg = 1;
			}
			if ( F.ntp_server2.value != "" && !check_ip_domain(F.ntp_server2.value) ) 
                        {
                                my_alert(O_VAR,"ntp_server2",__T(ddnsm.dyn_notfqdnip),0,"msg_ntp2_ip");
                                errflg = 1;
                        }
			if ( F.ntp_server2.value != "" && !lan_subnet_mask(F.ntp_server2.value) ) 
                        {
                                my_alert(O_VAR,"ntp_server2",__T(msg.illegalipformat),0,"msg_ntp2_ip");
                                errflg = 1;
                        }

		}
	}
	if ( errflg == 1 ) return false;
	return true;
}

var chk_times=0;
function chk_st()
{
	chk_times+=1;
	if ( chk_times >= 2 ) 
	{
		document.location.href = goto_link("time_zone.asp");
	}else{
		frames['iframe1'].location.href = goto_link("pollingst.asp");
		setTimeout("chk_st()", 15000);
	}
}

function uiDoSave(F){
	F.ntp_server.value = parseIP(F.ntp_server.value);
	F.ntp_server2.value = parseIP(F.ntp_server2.value);
	if ( !valid_value(F) ) return;
	/*if ( F._daylight_time.checked == true ) 
	        F.daylight_time.value = "1"; 
        else
                F.daylight_time.value = "0"; */
	if ( F.ntp_mode[0].checked == true )
	{
		F.ntp_mode.value = "auto";
		if ( F.ntp_use_default[0].checked == true ) 
			F.ntp_use_default.value = "1";
		else
			F.ntp_use_default.value = "0";
	}
	else
	{
		F.ntp_mode.value = "manual";
		if ( flg_24 == 0 ) 
		{
			var _name = new Array("month","day","year","hour","minute","noon"); 
			for(var i=0; i<_name.length; i++)
			{
				if ( F.ntp_manual_time.value != "" ) 
					F.ntp_manual_time.value += " "; 
				if ( eval("F."+_name[i]).value.length < 2 ) F.ntp_manual_time.value += "0";
				F.ntp_manual_time.value += eval("F."+_name[i]).value;
			}
		}else{
			var _name = new Array("month","day","year","hour","minute"); 
			var noon="AM";
			for(var i=0; i<_name.length; i++)
			{
				if ( F.ntp_manual_time.value != "" ) 
					F.ntp_manual_time.value += " "; 
				if ( _name[i] == "hour" ) 
				{
					var new_hour = 0;
					if ( (parseInt(eval("F."+_name[i]).value,10) > 12) )  
					{
						noon = "PM";
						new_hour = parseInt(eval("F."+_name[i]).value,10)-12;
					}else{
						if ( (parseInt(eval("F."+_name[i]).value,10) == 0) ) 
							new_hour = 12;
						else
							new_hour = eval("F."+_name[i]).value;
					}
					if ( parseInt(new_hour,10) < 10 ) 
						F.ntp_manual_time.value += "0";
					F.ntp_manual_time.value += new_hour;
				}else{
					if ( eval("F."+_name[i]).value.length < 2 ) F.ntp_manual_time.value += "0";
					F.ntp_manual_time.value += eval("F."+_name[i]).value;
				}
			}
			if ( F.ntp_manual_time.value != "" ) 
                                        F.ntp_manual_time.value += " "+noon;
				
		}
	}
	F.time_zone.value = timezone_arr[F._time_zone.selectedIndex].val;

	//Fixed 2011/05/16 add dat by week
	dst_fun(F);
	if( F._daylight_time.checked == true ) 
	       	F.daylight_enable.value = "1"; 
	else
	        F.daylight_enable.value = "0"; 
        F.daylight_time.value = "0";
	F.wait_time.value="5";
	if ( F._time_backup_period.checked == true ) 
		F.time_backup_period.value = "1";
	else
		F.time_backup_period.value = "0";

	F.submit_button.value="time_zone";
	F.gui_action.value="Apply";
	F.submit();	
	if ( http_from == "wan" ) 
	{
		setTimeout("chk_st()", 15000);
	}	
	parent.document.getElementById("save_bg").style.display="";
}

function SelTime(str,F)
{
	var Arr = new Array();
	Arr = str.split(' ');
	//Fixed 2010/12/13 for daylight day disable
	/*if (  Arr[2] == 0 ){
                choose_disable(F._daylight_time);
                F._daylight_time.checked = false;
                F.daylight_time.value = "0";
		//Fixed 2010/10/05
		DISABLE_PART(F,"start_daylight","end_daylight",1);
	}else
	{
                choose_enable(F._daylight_time);                
		//Fixed 2010/12/13 for daylight day disable
                //F._daylight_time.checked = true;
                //F.daylight_time.value = "1";

		//Fixed 2010/10/05
		//DISABLE_PART(F,"start_daylight","end_daylight",0);

                F._daylight_time.checked = false;
                F.daylight_time.value = "0";

		en_daylight(F);
	}*/
}

function chk_ntp(val){
	var F = document.frmtime;
	if ( val == 0 ){
		choose_disable(F.ntp_use_default_sel);
		choose_enable(F.ntp_server);
		choose_enable(F.ntp_server2);
	}else{
		choose_enable(F.ntp_use_default_sel);
		choose_disable(F.ntp_server);
		choose_disable(F.ntp_server2);
	}
}

var t_year,t_month,t_day;
function chg_month(F)
{
	t_year = F.year.selectedIndex + s_year;
	t_month = F.month.selectedIndex + 1;
	t_day = F.day.selectedIndex + 1;

	if (t_month == 2)	
	{
		if ((t_year % 400 == 0) || (t_year % 4 == 0) && (t_year % 100 != 0))
		{
			F.day.length = 29;
			createOption(F, F.day.length);
		}
		else
		{
			F.day.length = 28;		    
			createOption(F, F.day.length);
		}
	}
	else if ((t_month == 1)||(t_month == 3)||(t_month == 5)||(t_month == 7)||
		(t_month == 8)||(t_month == 10)||(t_month == 12))
	{
		F.day.length = 31;
		createOption(F, F.day.length);
	}
	else
	{
		F.day.length = 30;
		createOption(F, F.day.length);
	}

}
function createOption(F,n)
{
  	for(var i=0; i<n; i++)
	{
		if ( i == date_data[1]-1 )
		{
			if (i<9)
				F.day.options[i]=new Option("0"+(i+1),"0"+(i+1),true,'selected');
			else
				F.day.options[i]=new Option(i+1,i+1,true,'selected');
		}else{
			if (i<9)
				F.day.options[i]=new Option("0"+(i+1),"0"+(i+1),false);
			else
				F.day.options[i]=new Option(i+1,i+1,false);
		}
	}
}

function chg_day(F, d_month, d_day, option)
{
	var countday = new Array(31,31,29,31,30,31,30,31,31,30,31,30,31);
	if((d_month <= 0) || (d_month > 12))
		d_month = 1;
	if(option == 's')
	{
  		for(var i=0; i< countday[d_month]; i++)
		{
			F.day_s.options.length = countday[d_month];
			F.day_s.options[i].value = i+ 1;
			if ( i < 9 ) 
				F.day_s.options[i].text = "0"+(i+1);
			else
				F.day_s.options[i].text = i+ 1;
		}
		//d_day = parseInt(data_month_s[1],10)-1;
		F.day_s.selectedIndex = (d_day < F.day_s.options.length) ? d_day : 0;
	}
	else
	{
  		for(var i=0; i< countday[d_month]; i++)
		{
			F.day_e.options.length = countday[d_month];
			if ( i < 9 ) 
				F.day_e.options[i].text = "0"+(i+1);
			else
				F.day_e.options[i].text = i+1;
			F.day_e.options[i].value = i+ 1;
		}
		//d_day = parseInt(data_month_e[1],10)-1;
		F.day_e.selectedIndex = (d_day < F.day_e.options.length) ? d_day : 0;
	}
}

//Fixed 2011/05/16 add dat by week start 
function dst_mode_sel(F)
{
	DISABLE_PART(F,"start_seldays","end_seldays",1);
	DISABLE_PART(F,"start_selrecu","end_selrecu",1);
	if ( F._daylight_time.checked == true ) 
	{
		if ( F.dst_mode[0].checked == true)
		{
			DISABLE_PART(F,"start_seldays","end_seldays",0);
			DISABLE_PART(F,"start_selrecu","end_selrecu",1);
		}
		else
		{
			DISABLE_PART(F,"start_seldays","end_seldays",1);
			DISABLE_PART(F,"start_selrecu","end_selrecu",0);
		}
	}

}

function get_time_val_24(h,m)
{
	var dst_noon = "/AM";
	var tmp = "";
	if ( (parseInt(h,10) > 12) && (parseInt(h,10) < 24) )
	     dst_noon = "/PM";
	if ( parseInt(h,10) == 24 ) 
	     tmp = 0 ;
	else if ( parseInt(h,10) > 12 ) 
	     tmp = parseInt(h,10)-12;
	else
	     tmp = parseInt(h,10);
	return tmp+'/'+(m<9?"0":"")+m+dst_noon;	
}

function dst_fun(F)
{
	var dst_time = "";
	var dst_noon = "";
	var tmp;
	//set by day
	if ( flg_24 == 0 )
	{
		dst_noon = '/'+ (F.noon_s.selectedIndex == 0 ? "AM" : "PM");
		dst_time = F.hour_s[F.hour_s.selectedIndex].value+'/'+(F.minute_s.selectedIndex < 9 ? "0" : "")+F.minute_s.selectedIndex+dst_noon;
	}
	else{
		dst_time = get_time_val_24(F.hour_s[F.hour_s.selectedIndex].value,F.minute_s[F.minute_s.selectedIndex].value);
				
	}
	F.daylight_start.value = (F.month_s.selectedIndex+1) +'/'+ (F.day_s.selectedIndex+1)+'/'+dst_time; 

	if ( flg_24 == 0 )
	{
		dst_noon = '/'+ (F.noon_e.selectedIndex==0 ? "AM" : "PM");
		dst_time = F.hour_e[F.hour_e.selectedIndex].value+'/'+(F.minute_e.selectedIndex < 9 ? "0" : "")+F.minute_e.selectedIndex+dst_noon;
	}else{
		dst_time = get_time_val_24(F.hour_e[F.hour_e.selectedIndex].value,F.minute_e[F.minute_e.selectedIndex].value);
	}
	F.daylight_end.value = (F.month_e.selectedIndex+1) +'/'+ (F.day_e.selectedIndex+1)+'/'+dst_time; 
	//set by weekofday
	if ( flg_24 == 0 )
	{
		dst_noon = '/'+ (F.recu_noon_s.selectedIndex==0 ? "AM" : "PM");
		dst_time = F.recu_hour_s[F.recu_hour_s.selectedIndex].value+'/'+(F.recu_minute_s.selectedIndex < 9 ? "0" : "")+F.recu_minute_s.selectedIndex+dst_noon;
	}else{
		dst_time = get_time_val_24(F.recu_hour_s[F.recu_hour_s.selectedIndex].value,
					   F.recu_minute_s[F.recu_minute_s.selectedIndex].value);
	}
	F.recu_daylight_start.value = (F.recu_month_s.selectedIndex+1)+'/'+ (F.recu_week_s.selectedIndex+1)+'/'+ (F.recu_day_s[F.recu_day_s.selectedIndex].value)+'/'+dst_time; 

	if ( flg_24 == 0 )
	{
		dst_noon = '/'+ (F.recu_noon_e.selectedIndex==0 ? "AM" : "PM");
		dst_time = F.recu_hour_e[F.recu_hour_e.selectedIndex].value+'/'+(F.recu_minute_e.selectedIndex < 9 ? "0" : "")+F.recu_minute_e.selectedIndex+dst_noon;
	}else{
		dst_time = get_time_val_24(F.recu_hour_e[F.recu_hour_e.selectedIndex].value,
					   F.recu_minute_e[F.recu_minute_e.selectedIndex].value);
	}
	F.recu_daylight_end.value = (F.recu_month_e.selectedIndex+1)+'/'+ (F.recu_week_e.selectedIndex+1)+'/'+ (F.recu_day_e[F.recu_day_e.selectedIndex].value)+'/'+dst_time; 
}
//Fixed 2011/05/16 add dat by week end
</script>
</head>
<body onload="init();">
<FORM autocomplete=off id=frm name=frmtime method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=daylight_time value=0>
<input type=hidden name=daylight_enable value=0>
<input type=hidden name=ntp_manual_time>
<input type=hidden name=time_zone>
<!-- Fixed 2010/10/05 add menu daylight start -->
<input type=hidden name=daylight_start>
<input type=hidden name=daylight_end>
<input type=hidden name=wait_time>
<!-- Fixed 2010/10/05 add menu daylight end --> 
<!-- Fixed 2011/05/16 add dat by week start --> 
<input type=hidden name=recu_daylight_start>
<input type=hidden name=recu_daylight_end>
<!-- Fixed 2011/05/16 add dat by week end --> 
<input type=hidden name=time_backup_period>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(mang.timesetting));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.currenttime));</script>
		<B><script>
		var current_time = "<% misc_get("get_current_time"); %>";
	        var t_data = current_time.split(" "); 
        	var date_data = t_data[0].split("/");
	        var time_data = t_data[1].split(":");
		if ( flg_24 == 1 ) 
		{
			if ( t_data[2] == "PM" ) 
				time_data[0] = parseInt(time_data[0],10)+12;
			if ( time_data[0] == 24 ) time_data[0] = 0;
			
	        	document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1]));
		}else{ 
	        	document.write(spell_words(datetime_rule,date_data[0],date_data[1],date_data[2],time_data[0],time_data[1],t_data[2]));
		}
		</script></B>
		</td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__T(wl.dateandtime));</script>
		<script>
		var _name = new Array();
		var _val = new Array();
		for(i=0; i<timezone_arr.length; i++)
		{
			_name[i] = timezone_arr[i].name;
			_val[i] = timezone_arr[i].val;
		}
		draw_object(O_GUI,SELBOX,"_time_zone","onChange=SelTime(this.value,this.form)",_name,_val,"<% nvram_get("time_zone"); %>");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.adjusttime))</script>

		<!-- Fixed 2010/10/05 add menu daylight start --> 
		<INPUT type=checkbox name="_daylight_time" onclick=en_daylight(this.form) <% nvram_match("daylight_enable","1","checked"); %> >
		</TD></TR>
		<input type=hidden name=start_daylight>
		<!-- Fixed 2010/10/05 add menu daylight end --> 
		<!-- Fixed 2011/05/16 add dat by week start -->
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.timesavemode))</script>
		<script>
			var _name = new Array(__T(mang.bydate),__T(mang.recurring));
			var _val = new Array("0","1");
			draw_object(O_GUI,RADIO,"dst_mode",_val,_name,"<% nvram_get("dst_mode"); %>","onClick=dst_mode_sel(this.form)");
		</script>
                </TD></TR>
		<!-- Fixed 2011/05/16 add dat by week end -->
		<input type=hidden name=start_seldays>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.sfrom));</script>
		<script>
		document.write(__T(def.smonth)+":&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","12","1",2);
		draw_object(O_GUI,SELBOX,"month_s"," id=month_s onChange=chg_day(this.form,this.value,0,'s')",_name,_name,data_month_s[0]);
		document.write("&nbsp;&nbsp;");
		document.write(__T(def.sday)+":&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","31","1",2);
		draw_object(O_GUI,SELBOX,"day_s"," id=day_s",_name,_name,data_month_s[1]);
		document.write("&nbsp;&nbsp;");
		</script>
		<!--/TD-->
		<!-- Fixed 2011/05/16 add dat by week start -->
		<!--TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__T(def.stime)+":");</script-->
		<script>
		document.write(__T(def.stime)+":&nbsp;&nbsp;");
		var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val_12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name_24 = new Array("ISRANGE","0","23","1",2);
		if ( flg_24 == 1 )
		{ 
			var hour_24="";
			if ( data_month_s[2] != "" ){
				if ( data_month_s[4] == "PM" ) hour_24 = parseInt(data_month_s[2],10)+12
				else hour_24 = data_month_s[2];
				if ( data_month_s[4] == "AM" && hour_24 == 0 ) 
					hour_24 = 24;
			}
			draw_object(O_GUI,SELBOX,"hour_s","",hour_name_24,hour_name_24,hour_24);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute_s","",_name,_name,data_month_s[3]);
		}
		else		
		{
			if ( typeof data_month_s[2] != 'undefined' ) 
			{
				var hour_12 = data_month_s[2];
				if ( hour_12.length < 2 ) hour_12 = "0"+ hour_12
			}
			else
				var hour_12 = 12;
			draw_object(O_GUI,SELBOX,"hour_s","",hour_name_12,hour_val_12,hour_12);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute_s","",_name,_name,data_month_s[3]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("AM","PM");
			draw_object(O_GUI,SELBOX,"noon_s","",_name,_val,data_month_s[4]);
		}
		</script>
		<span id=msg_daylight_s></span>
		</TD></TR>	
		<!-- Fixed 2011/05/16 add dat by week end -->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.sto));</script>
		<script>
		document.write(__T(def.smonth)+":&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","12","1",2);
		draw_object(O_GUI,SELBOX,"month_e"," id=month_e onChange=chg_day(this.form,this.value,0,'e')",_name,_name,data_month_e[0]);
		document.write("&nbsp;&nbsp;");
		document.write(__T(def.sday)+":&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","31","1",2);
		draw_object(O_GUI,SELBOX,"day_e"," id=day_e",_name,_name,data_month_e[1]);
		document.write("&nbsp;&nbsp;");
		</script>
		<!--/TD></TR-->
		<!-- Fixed 2011/05/16 add dat by week start -->
		<!--<script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"",SPACE_DOWN,SPACE_DOWN)</script>-->
		<script>
		document.write(__T(def.stime)+":&nbsp;&nbsp;");
		var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val_12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name_24 = new Array("ISRANGE","0","23","1",2);
		if ( flg_24 == 1 )
		{ 
			var hour_24="";
			if ( data_month_e[2] != "" ){
				if ( data_month_e[4] == "PM" ) hour_24 = parseInt(data_month_e[2],10)+12
				else hour_24 = data_month_e[2];
				if ( data_month_e[4] == "AM" && hour_24 == 0 ) 
					hour_24 = 24;
			}
			draw_object(O_GUI,SELBOX,"hour_e","",hour_name_24,hour_name_24,hour_24);
			document.write("&nbsp;:&nbsp;");
			if ( typeof data_month_e[3] != 'undefined' ) 
			{
				var min_24=data_month_e[3];
				if ( min_24.length < 2 ) min_24 = "0"+min_24;
			}else
				var min_24=0;
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute_e","",_name,_name,min_24);
		}
		else	
		{
			if ( typeof data_month_e[2] != 'undefined' ) 
			{
				var hour_12=data_month_e[2];
				if ( hour_12.length < 2 ) hour_12 = "0"+hour_12;
			}else
				var hour_12 = 12;
			draw_object(O_GUI,SELBOX,"hour_e","",hour_name_12,hour_val_12,hour_12);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute_e","",_name,_name,data_month_e[3]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("AM","PM");
			draw_object(O_GUI,SELBOX,"noon_e","",_name,_val,data_month_e[4]);
		}
		</script>
		<span id=msg_daylight_e></span>
		</TD></TR>	
		<input type=hidden name=end_seldays>

		<input type=hidden name=start_selrecu>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.sfrom));</script>
		<script>
		document.write(__T(def.smonth)+":&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","12","1",2);
		draw_object(O_GUI,SELBOX,"recu_month_s"," id=recu_month_s onChange=chg_day(this.form,this.value,0,'s')",_name,_name,recu_data_s[0]);
		document.write("&nbsp;&nbsp;");
		document.write(__T(mang.week)+":&nbsp;&nbsp;");
	        var _name= new Array(__T(mang.st1),__T(mang.nd2),__T(mang.rd3),__T(mang.th4),__T(mang.th5),__T(mang.th6));
		var _val = new Array("ISRANGE","1","6","1",2);
		var week = parseInt(recu_data_s[1],10)-1;
		draw_object(O_GUI,SELBOX,"recu_week_s"," id=recu_week_s",_name,_val,week);
		document.write("&nbsp;&nbsp;");
		document.write(__TC(def.sday)+"&nbsp;&nbsp;");
	        var _name= new Array(__T(logemail.schsun),__T(logemail.schmon),__T(logemail.schtue),__T(logemail.schwed),__T(logemail.schthur),__T(logemail.schfri),__T(logemail.schsatur));
	        var _val= new Array("7","1","2","3","4","5","6");
		draw_object(O_GUI,SELBOX,"recu_day_s"," id=recu_day_s",_name,_val,recu_data_s[2]);
		
		//<script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"",SPACE_DOWN,SPACE_DOWN)</script>
		<script>
		document.write(__T(def.stime)+":&nbsp;&nbsp;");
		var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val_12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name_24 = new Array("ISRANGE","0","23","1",2);
		if ( flg_24 == 1 )
		{ 
			var hour_24="";
			if ( recu_data_s[3] != "" ){
				if ( recu_data_s[5] == "PM" ) hour_24 = parseInt(recu_data_s[3],10)+12
				else hour_24 = recu_data_s[3];
				if ( recu_data_s[5] == "AM" && recu_data_s[3] == 0 ) 
					hour_24 = 24;
			}
			draw_object(O_GUI,SELBOX,"recu_hour_s","",hour_name_24,hour_name_24,hour_24);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"recu_minute_s","",_name,_name,recu_data_s[4]);
		}
		else		
		{
			if ( typeof recu_data_s[3] != 'undefined' ) 
			{
				var hour_12 = recu_data_s[3];
				if ( hour_12.length < 2 ) hour_12 = "0"+hour_12;
			}else
				var hour_12 = 12;
			draw_object(O_GUI,SELBOX,"recu_hour_s","",hour_name_12,hour_val_12,hour_12);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"recu_minute_s","",_name,_name,recu_data_s[4]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("AM","PM");
			draw_object(O_GUI,SELBOX,"recu_noon_s","",_name,_val,recu_data_s[5]);
		}
		</script>
		<span id=recu_msg_daylight_s></span>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(share.sto));</script>
		<script>
		document.write(__TC(def.smonth)+"&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","12","1",2);
		draw_object(O_GUI,SELBOX,"recu_month_e"," id=recu_month_e onChange=chg_day(this.form,this.value,0,'s')",_name,_name,recu_data_e[0]);
		document.write("&nbsp;&nbsp;");
		document.write(__TC(mang.week)+"&nbsp;&nbsp;");
	        var _name= new Array(__T(mang.st1),__T(mang.nd2),__T(mang.rd3),__T(mang.th4),__T(mang.th5),__T(mang.th6));
		var _val = new Array("ISRANGE","1","6","1",2);
		var week = parseInt(recu_data_e[1],10)-1;
		draw_object(O_GUI,SELBOX,"recu_week_e"," id=recu_week_e",_name,_val,week);
		document.write("&nbsp;&nbsp;");
		document.write(__TC(def.sday)+"&nbsp;&nbsp;");
	        var _name= new Array(__T(logemail.schsun),__T(logemail.schmon),__T(logemail.schtue),__T(logemail.schwed),__T(logemail.schthur),__T(logemail.schfri),__T(logemail.schsatur));
	        var _val= new Array("7","1","2","3","4","5","6");
		draw_object(O_GUI,SELBOX,"recu_day_e"," id=recu_day_e",_name,_val,recu_data_e[2]);
		
		//<script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"",SPACE_DOWN,SPACE_DOWN)</script>
		<script>
		document.write(__T(def.stime)+":&nbsp;&nbsp;");
		var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val_12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name_24 = new Array("ISRANGE","0","23","1",2);
		if ( flg_24 == 1 )
		{ 
			var hour_24="";
			if ( recu_data_e[3] != "" ){
				if ( recu_data_e[5] == "PM" ) hour_24 = parseInt(recu_data_e[3],10)+12
				else hour_24 = recu_data_e[3];
				if ( recu_data_e[5] == "AM" && recu_data_e[3] == 0 ) 
					hour_24 = 24;
			}
			draw_object(O_GUI,SELBOX,"recu_hour_e","",hour_name_24,hour_name_24,hour_24);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"recu_minute_e","",_name,_name,recu_data_e[4]);
		}
		else		
		{				  
			if ( typeof recu_data_e[3] != 'undefined' ) 
			{
				var hour_12 = recu_data_e[3];
				if ( hour_12.length < 2 ) hour_12 = "0"+hour_12;
			}else
				var hour_12 = 12;
			draw_object(O_GUI,SELBOX,"recu_hour_e","",hour_name_12,hour_val_12,hour_12);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"recu_minute_e","",_name,_name,recu_data_e[4]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("AM","PM");
			draw_object(O_GUI,SELBOX,"recu_noon_e","",_name,_val,recu_data_e[5]);
		}
		</script>
		<span id=recu_msg_daylight_e></span>
		</TD></TR>
		<input type=hidden name=end_selrecu>
		<!-- Fixed 2011/05/16 add dat by week end -->
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.timesaveoffset));</script>
		<script>
		var _offset = new Array("+60","+45","+30","-30","-45","-60");
		draw_object(O_GUI,SELBOX,"daylight_offset","",_offset,_offset,"<% nvram_get("daylight_offset"); %>");
		document.write("&nbsp;"+__T(unit.minutes));
		</script>
		</TD></TR>
		<input type=hidden name=end_daylight>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.setdateandtime))</script>
		<script>
			var _name = new Array(__T(share.auto),__T(share.manual));
			var _val = new Array("auto","manual");
			draw_object(O_GUI,RADIO,"ntp_mode",_val,_name,"<% nvram_get("ntp_mode"); %>","onClick=en_fun(this.form)");
		</script>
                </TD></TR>
		<input type=hidden name=start_auto>
                <TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(mang.ntpserver))</script>
                <INPUT type=radio value=1 name="ntp_use_default" <% nvram_match("ntp_use_default","1","checked"); %> onClick=chk_ntp(1)>&nbsp;<script>Capture(mang.usedefault);</script>&nbsp;
                <!-- script>
                var _name = new Array("time-a.timefreq.bldrdoc.gov","time-b.timefreq.bldrdoc.gov","time-c.timefreq.bldrdoc.gov");
                var _val = new Array("0","1","2");
                draw_object(O_GUI,SELBOX,"ntp_use_default_sel","",_name,_val,"<% nvram_get("ntp_use_default_sel"); %>");
                </script-->
                </TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"")</script>
                <INPUT type=radio value=0 name="ntp_use_default" <% nvram_match("ntp_use_default","0","checked"); %> onClick=chk_ntp(0)>&nbsp;<script>Capture(mang.userdefinedntp);</script>
		</TD</TR>
                <TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"")</script>
		<span style=padding-left:25px>
                1. <input size=20 name=ntp_server id=ntp_server value=<% nvram_get("ntp_server"); %>>
		<script>document.write("&nbsp;&nbsp;"+spell_words(hint_rule,"1.2.3.4 "+__T(share.or)+" abc.com"));</script></span>
		<span id=msg_ntp_ip></span>
		</TD></TR>
                <TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,"")</script>
		<span style=padding-left:25px>
                2. <input size=20 name=ntp_server2 id=ntp_server2 value=<% nvram_get("ntp_server2"); %>>
		</span>
		<span id=msg_ntp2_ip></span>
		</TD></TR>
                </TD></TR>
		<input type=hidden name=end_auto>
		<input type=hidden name=start_manual>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.enterdateandtime))</script>
		<script>
//		var ntptime = "<% nvram_get("ntp_manual_time"); %>".split(" ");
		//var _name = new Array("month","day","year","hour","minute","sec"); 
		document.write(__TC(def.syear)+"&nbsp;&nbsp;");
		var _name = new Array("ISRANGE",s_year,e_year,"1");
		  draw_object(O_GUI,SELBOX,"year"," id=year onChange=chg_month(this.form)",_name,_name,ntptime[2]);
		document.write("<SPAN class=SPACE8>");
		document.write(__TC(def.smonth)+"&nbsp;&nbsp;");
		var _name = new Array("ISRANGE","1","12","1",2);
		draw_object(O_GUI,SELBOX,"month"," id=month onChange=chg_month(this.form)",_name,_name,ntptime[0]);
		document.write("</SPAN>");
		document.write("<SPAN class=SPACE8>");
		document.write(__TC(def.sday)+"&nbsp;&nbsp;");
	        var _name = new Array("ISRANGE","1","31","1",2); 
		draw_object(O_GUI,SELBOX,"day"," id=day",_name,_name,ntptime[1]);
		document.write("</SPAN>");
		</script></TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,"")</script>
		<script>
		document.write(__TC(def.stime)+"&nbsp;&nbsp;");
		var hour_name_12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val_12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name_24 = new Array("ISRANGE","0","23","1",2);
		if ( flg_24 == 1 )
		{ 
			var hour_24="";
			if ( ntptime[3] != "" ){
				if ( ntptime[5] == "PM" ) hour_24 = parseInt(ntptime[3],10)+12
				else hour_24 = ntptime[3];
				if ( ntptime[5] == "AM" && hour_24 == 12 ) hour_24 = 24;
			}
			draw_object(O_GUI,SELBOX,"hour","",hour_name_24,hour_name_24,hour_24);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute","",_name,_name,ntptime[4]);
		}
		else		
		{
			draw_object(O_GUI,SELBOX,"hour","",hour_name_12,hour_val_12,ntptime[3]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array("ISRANGE","0","59","1",2);
			draw_object(O_GUI,SELBOX,"minute","",_name,_name,ntptime[4]);
			document.write("&nbsp;:&nbsp;");
			var _name = new Array(__T(mang.am),__T(mang.pm));
			var _val = new Array("AM","PM");
			draw_object(O_GUI,SELBOX,"noon","",_name,_val,ntptime[5]);
		}
		</script></TD></TR>	
		<input type=hidden name=end_manual>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(mang.backuptimeperiod),SPACE_DOWN,SPACE_DOWN)</script>
		<input type=checkbox name=_time_backup_period <% nvram_match("time_backup_period", "1", "checked");%>> <script>Capture(share.enable);</script>
                </TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
</body></HTML>
