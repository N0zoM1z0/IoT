<html>
<head>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<script language="JavaScript">
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

var portlist = new Array();
<% get_port_st("portlist"); %>
var nowtime = new Date();
var year_name = new Array("ISRANGE","2010","2037","1");
var daylight_start = "<% nvram_get("daylight_start"); %>";;
var daylight_end = "<% nvram_get("daylight_end"); %>";;
var data_month_s = daylight_start.split("/");
var data_month_e = daylight_end.split("/");
var s_year = 2011;
var e_year = 2037;
function load_time()
{
	var F = document.wz_cfg;
	F.m_time[1].checked = true;
	sel_time_type(1);
	F.month.selectedIndex = nowtime.getMonth();
	F.day.selectedIndex = parseInt(nowtime.getDate(),10)-1;
	var selidx = parseInt(nowtime.getFullYear())-2010 -1;
	F.year.selectedIndex = selidx;
	var time=nowtime.getHours();
	if ( flg_24 == 0 ) 
	{
		if ( parseInt(time,10)>12) 
		{
			F.hour.selectedIndex = parseInt(time,10)-12;
			F.noon.selectedIndex = 1; 
		}else{
			F.noon.selectedIndex = 0; 
			F.hour.selectedIndex = parseInt(time,10);
		}
	}else{
		F.hour.selectedIndex = parseInt(time,10)-1;
	}	
	F.min.selectedIndex = parseInt(nowtime.getMinutes(),10);
        chg_month(F);
}
function init()
{
	var F = document.wz_cfg;
	var time_zone = parse_data("time_zone"); 
	if ( time_zone.length > 0 ) 
	{
		for(var i=0; i<timezone_arr.length; i++)
		{
			if ( time_zone == timezone_arr[i].val)
			{
				F._time_zone.selectedIndex = i ; 
				break;
			}
		}	
	}
	var manual_time = parse_data("ntp_mode");
        chg_month(F);
	if ( manual_time == "auto" ) 
		F.m_time[0].checked = true;
	else
		F.m_time[1].checked = true;
	if ( manual_time == "manual" ) 
	{
		var time_data = parse_data("ntp_manual_time").split(" ");
		F.month.selectedIndex = parseInt(time_data[0],10)-1;
		F.day.selectedIndex = parseInt(time_data[1],10)-1;
		F.year.value = time_data[2];
		F.min.selectedIndex = time_data[4];
		if ( flg_24 == 0 ) 
		{
			F.hour.selectedIndex = parseInt(time_data[3],10);
			if ( time_data[5] == "AM" ) 
				F.noon.selectedIndex = 0; 
			else
				F.noon.selectedIndex = 1; 
		}else{
			if ( time_data[5] == "PM" ) 
				F.hour.selectedIndex = parseInt(time_data[3],10)+12-1;
			else
				F.hour.selectedIndex = parseInt(time_data[3],10)-1;
		}
	}else
		DISABLE_PART(F,"time_start","time_end",1);

	def_nv = keep_val(F,""); 
}

function goto_back(){
//	var stype = parse_data("service_type");
	var conn_type = parse_data("wan_proto");
//	if ( (stype == "0" || stype == "1") && portlist[4] != __T(router.down) )//UP
  //              document.location.href="config_1.asp";
//	else{
		if ( conn_type == "dhcp" ) 
                	document.location.href=goto_link("config_2.asp");
		else if ( conn_type == "static" ) 	
                	document.location.href=goto_link("config_3.asp");
		else if ( conn_type == "pppoe" ) 	
			document.location.href=goto_link("config_3_pppoe.asp");
		else if ( conn_type == "pptp" ) 
			document.location.href=goto_link("config_3_pptp.asp");
		else if ( conn_type == "l2tp" )
			document.location.href=goto_link("config_3_l2tp.asp");
//	}
		
}

function goto_next(F)
{
	var mt="";
	save_data("time_zone",F._time_zone.value);
	if ( F.m_time[0].checked ) mt="auto";
	else mt="manual";
	save_data("ntp_mode",mt);
	if ( mt == "manual" ) 
	{
		if ( flg_24 == 0 ) 
		{
			var data = "";
			var _name = new Array("month","day","year","hour","min","noon"); 
                	for(var i=0; i<_name.length; i++)
	                {
        	                if ( data != "" ) 
                	                data += " "; 
	                        if ( eval("F."+_name[i]).value.length < 2 ) data += "0";
        	                data += eval("F."+_name[i]).value;
                	}
		}else{
			var data = "";
			var new_noon="AM";
			var new_hour=0;
			var _name = new Array("month","day","year","hour","min"); 
                	for(var i=0; i<_name.length; i++)
	                {
        	                if ( data != "" ) 
                	                data += " "; 
	                        if ( parseInt(eval("F."+_name[i]).value,10) < 10 ) data += "0";
				if ( _name[i] == "hour" ) 
				{
					if ( parseInt(eval("F."+_name[i]).value,10) > 12 ) 
					{
						new_hour = parseInt(eval("F."+_name[i]).value,10)-12;
						new_noon = "PM";
					}
					else
						new_hour = parseInt(eval("F."+_name[i]).value,10);
					if ( new_hour < 10 ) data+="0";
					data+=new_hour;
				}else
					data += parseInt(eval("F."+_name[i]).value,10);
                	}
        	        if ( data != "" ) data+=" "+new_noon;
			
		}	
		save_data("ntp_manual_time",data);
	}
	document.location.href=goto_link("config_5.asp");
	
}

function sel_time_type(val)
{
	var F = document.wz_cfg;
	if ( val == 0 ) 
		DISABLE_PART(F,"time_start","time_end",1);
	else
		DISABLE_PART(F,"time_start","time_end",0);
}

function uiDoCancel(F)
{
        change_nv = keep_val(F,"");
        if ( !wizard_before_leave(change_nv,def_nv) ) 
                my_alert(O_GUI,WARNING,__T(share.warnmsg),__T(logemail.warnmsg),"alert_result_GUI(1)","alert_result_GUI(0)","wizard","yesno");
        else 
                alert_result_GUI(1);
}

function alert_result_GUI(val)
{
	alert_result(0);
	if ( val == 1 ) 
	{
		var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
		go_page(aging_time,"<% nvram_get("getting_start"); %>");
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
                if ( i == date_data[1]-1 ){
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

</script>
</head>
<BODY onload=init()>
<FORM autocomplete=off id=frm action=apply.cgi name="wz_cfg" method=<% get_http_method(); %>>
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
     <script>create_process_title(2,3);</script>
    <TR><TD class=DATA_TITLE2 colspan=4><script>Capture(wz.setdatetime);</script></TD></TR>
    <TR><TD colspan=4 valign=top>
    <TABLE><TR><TD valign=top class=DATA_ITEM>
    <script>Capture(wz.settimezone);</script>
    </TD></TR>
    <TR><TD valign=top class=DATA_ITEM>
    <TABLE>
           <TR><TD style=padding-left:40px><script>Capture(wz.timezone);</script></TD>
           <TD>
	   <script>
                var _name = new Array();
                var _val = new Array();
                for(var i=0; i<timezone_arr.length; i++)
                {
                        _name[i] = timezone_arr[i].name;
                        _val[i] = timezone_arr[i].val;
                }
                draw_object(O_GUI,SELBOX,"_time_zone","",_name,_val,"");
           </script>
	   </TD></TR>
	   <TR><TD colspan=2 style="padding-top:5px;padding-left:35px">
           <Input type=radio checked name=m_time value=0 onclick=sel_time_type(0)><script>Capture(wz.entimesyn);</script>
	   </TD></TR>
	   <TR><TD colspan=2 style="padding-left:35px">
           <Input type=radio name=m_time value=1 onclick=sel_time_type(1)><script>document.write(spell_words(wz_settime_rule,"<a href=javascript:load_time()>"+__T(wz.here)+"</a>"));</script></TD></TR>
	   <TR><TD colspan=2 style="padding-left:40px">
	   <input type=hidden name=time_start>
           <SPAN style=padding-left:20px><script>Capture(def.syear);</script>:
	    <script>

            var current_time = "<% misc_get("get_current_time"); %>";
            var t_data = current_time.split(" "); 
            var date_data = t_data[0].split("/");
            var time_data = t_data[1].split(":");

            var ntptime = "<% nvram_get("ntp_manual_time"); %>".split(" ");
            var _name = new Array("ISRANGE",s_year,e_year,"1");
	    draw_object(O_GUI,SELBOX,"year"," id=year onChange=chg_month(this.form)",_name,_name,ntptime[2]);
	    </script>
		&nbsp;&nbsp;<script>Capture(def.smonth);</script>:
	    <script>
	    var _name = new Array("ISRANGE","1","12","1",2);
	    draw_object(O_GUI,SELBOX,"month"," id=month onChange=chg_month(this.form)",_name,_name,ntptime[0]);
	    </script>
	    &nbsp;&nbsp;<script>Capture(def.sday);</script>:
            <script>
	    //var _name = new Array("ISRANGE","1","31","1");
            draw_object(O_GUI,SELBOX,"day"," id=day",_name,_name,ntptime[1]);
	    </script>
	   </SPAN>
	   </TD></TR>
	   <TR><TD colspan=2 style="padding-left:40px">
           <SPAN style="padding-left:20px;padding-top:5px;padding-right:10px"><script>Capture(def.stime);</script>:
	   <script>
		var hour_name12 = new Array("12","01","02","03","04","05","06","07","08","09","10","11");
		var hour_val12 = new Array("00","01","02","03","04","05","06","07","08","09","10","11");
		var hour_name24 = new Array("ISRANGE","1","24","1",2);
		if ( flg_24 == 1 )  
	                draw_object(O_GUI,SELBOX,"hour","",hour_name24,hour_name24);
		else
	                draw_object(O_GUI,SELBOX,"hour","",hour_name12,hour_val12);
		
	   </script>
           :
	   <script>
	   var _name = new Array("ISRANGE","0","59","1",2);
           draw_object(O_GUI,SELBOX,"min","",_name,_name);
	   document.write("&nbsp;&nbsp;");
	   var noon_name = new Array(__T(mang.am),__T(mang.pm));
	   var noon_val = new Array("AM","PM");
	   if ( flg_24 == 0 ) 
		   draw_object(O_GUI,SELBOX,"noon","",noon_name,noon_val);
	   </script>
	   <input type=hidden name=time_end>
           </TD></TR>
    </TABLE>
    </TD></TR>
    </TABLE></TD></TR>
    <TR><TD class=DATA_SHOWTOP colspan=4><script>Capture(wz.clicknext1);</script></TD></TR> 
    </TABLE></TD></TR>
    <script>create_button("goto_back()","goto_next(this.form)");
    </script>
</TD></TR>
</TABLE>
<script>
chg_layout();
</script>
</div>
</form>
</body></HTML>
