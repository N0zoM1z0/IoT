<html>
<head>
<title>WAN Setup</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
CHK_VALUE_AUTO=0;
var idx = new Array(0,0,0);
var stflg = new Array("initwhite","initblock","initexc");
var back_bt = "true";
var change_cancel_bt="true";
var define_backname="webfilter.asp";
var pc_name = new Array(__T(share.ipaddr),__T(share.iprange));
var pc_val = new Array("1","2");
var web_name = new Array(__T(lan.domainname),__T(share.keyword));
var web_val = new Array("1","2");
var td_id = new Array(3);
td_id[0] = new Array("tdwchk_","tdwtype","tdwval");
td_id[1] = new Array("tdbchk_","tdbtype","tdbval");
td_id[2] = new Array("tdechk_","tdetype","tdeval");
var obj_id = new Array(3);
obj_id[0] = new Array("whitechk_","white_seltype","white_val");
obj_id[1] = new Array("blackchk_","black_seltype", "black_val");
obj_id[2] = new Array("excchk_", "exc_seltype", "exc_val","exc_val1");
var div_id = new Array("wdiv_","bdiv_","ediv_");
var img_id = new Array("wimg_","bimg_","eimg_");
var table_id = new Array("white","block","exc");
var start_line = new Array(0,0,0);
var end_line = new Array(5,5,5);
var count_entry = new Array(0,0,0);
var now_page = new Array(0,0,0);
var now_count = new Array(0,0,0);
var total_page = new Array(0,0,0);
var selflg = new Array(0,0,0);
var per_page = new Array("5","10","20","30");
var w_data = new Array();
var b_data = new Array();
var e_data = new Array();
var _data = new Array(3);
<% get_all_list_data(); %>
count_entry[0] = w_data.length;
count_entry[1] = b_data.length;
count_entry[2] = e_data.length;
var obj_start = new Array("wdata_start","bdata_start","edata_start");
var obj_end = new Array("wdata_end","bdata_end","edata_end");
var obj_page = new Array("wpage","bpage","epage");
function get_parm(F)
{
	now_page[0] = F.txt_w_page.value;
	now_page[1] = F.txt_b_page.value;
	now_page[2] = F.txt_e_page.value;

	now_count[0] = F.w_selcnt.value;
	now_count[1] = F.b_selcnt.value;
	now_count[2] = F.e_selcnt.value;

	for(var i=0; i<3; i++)
	{
		if ( selflg[i] == 1 )
		{ 
			now_page[i] = 1;
			selflg[i] = 0
			if ( i == 0 ) 
				F.txt_w_page.value = 1;
			else if ( i == 1 ) 
				F.txt_b_page.value = 1;
			else if ( i == 2 ) 
				F.txt_e_page.value = 1;
		}

		if ( now_page[i] == "" && now_count[i] == "" ) 
		{
			start_line[i] = 1;
			end_line[i] = 5;
			total_page[i] = parseInt(count_entry[i]/5,10)+((count_entry[i]%5)!=0?1:0);
		}else
			total_page[i] = parseInt(count_entry[i]/now_count[i],10)+((count_entry[i]%now_count[i])!=0?1:0);
		if ( now_count[i] != "" ) 
		{
			if ( now_count[i] > count_entry[i] ) 
				end_line[i] = count_entry[i];
			else
				end_line[i] = now_count[i];
			start_line[i] = 1;
		}
		
		if ( now_page[i] != "" ) 
		{
			if ( now_count[i] == "" )
			{
				now_count[i] = 5;
				total_page[i] = parseInt(count_entry[i]/now_count[i],10)+((count_entry[i]%now_count[i])!=0?1:0);
			}
			start_line[i] = (now_page[i]-1)*now_count[i]+1;	
			end_line[i] =  now_page[i]*now_count[i];
			if ( count_entry[i] < end_line[i] ) end_line[i] = count_entry[i];
		}
		document.getElementById(obj_start[i]).innerHTML = start_line[i];
		document.getElementById(obj_end[i]).innerHTML = end_line[i];
		document.getElementById(obj_page[i]).innerHTML = total_page[i];
	}
}

var f_bt = new Array("cmdfirstw","cmdfirstb","cmdfirste");
var p_bt = new Array("cmdprevw","cmdprevb","cmdpreve");
var n_bt = new Array("cmdnextw","cmdnextb","cmdnexte");
var l_bt = new Array("cmdlastw","cmdlastb","cmdlaste");

function chk_action(obj,st,j)
{
        if ( (  obj.indexOf("4") != -1 && document.getElementById(f_bt[j]).src.indexOf("image/First-D.gif")==-1 ) ||
             (  obj.indexOf("5") != -1 && document.getElementById(p_bt[j]).src.indexOf("image/Previous-D.gif")==-1 ) ||
             (  obj.indexOf("6") != -1 && document.getElementById(n_bt[j]).src.indexOf("image/Next-D.gif")==-1 ) ||
             (  obj.indexOf("7") != -1 && document.getElementById(l_bt[j]).src.indexOf("image/Last-D.gif")==-1 ))
                bt(obj,st);
        
        if ( st == "disabled" ) 
        {
                if ( obj.indexOf("4") != -1 ) document.getElementById(f_bt[j]).src = "image/First-D.gif";
                else if ( obj.indexOf("5") != -1 ) document.getElementById(p_bt[j]).src = "image/Previous-D.gif";
                else if ( obj.indexOf("6") != -1 ) document.getElementById(n_bt[j]).src = "image/Next-D.gif";
                else if ( obj.indexOf("7") != -1 ) document.getElementById(l_bt[j]).src = "image/Last-D.gif";
        }
}

var page = new Array("txt_w_page","txt_b_page","txt_e_page");

function to_prev(obj,flag,j)
{
	var F = document.frmfilter;
	var set_page;
	
	if ( eval("F."+page[j]).disabled == true ) return ;
	if ( (  obj.indexOf("4") != -1 && document.getElementById(f_bt[j]).src.indexOf("image/First-D.gif")!=-1 ) ||
	     (  obj.indexOf("5") != -1 && document.getElementById(p_bt[j]).src.indexOf("image/Previous-D.gif")!=-1 ) )
		return;
	if(flag)
		set_page = 1;
	else
		set_page = parseInt(eval("F."+page[j]).value,10)-1;

	if(set_page < 1) return;
	eval("F."+page[j]).value = set_page;
	clear_entry(j,F);
	get_parm(F);
	fill_entry(j);
}

function to_next(obj,flag,j)
{
        var F = document.frmfilter;
        var set_page;

	if ( eval("F."+page[j]).disabled == true ) return ;
         
        if( (  obj.indexOf("6") != -1 && document.getElementById(n_bt[j]).src.indexOf("image/Next-D.gif")!=-1 ) ||
            (  obj.indexOf("7") != -1 && document.getElementById(l_bt[j]).src.indexOf("image/Last-D.gif")!=-1 ))
                return;
        
        if(flag)
                set_page = total_page[j];
        else
                set_page = parseInt(eval("F."+page[j]).value,10)+1;
        if(set_page > total_page[j]) return;
	eval("F."+page[j]).value = set_page;
	clear_entry(j,F);
	get_parm(F);
	fill_entry(j);
}

function to_page(j)
{
        var F = document.frmfilter;
	var set_page = parseInt(eval("F."+page[j]).value,10);
        
        if((set_page < 1) || (set_page > total_page[j]))
                return;
	
	clear_entry(j,F);
	get_parm(F);
	fill_entry(j);

}

function to_page_enter(e,j)
{
        if(window.event)
        {
                e = event;
                e.which = e.keyCode;
        }
        else if(!e.which)
                e.which = e.keyCode;

        //var key = e.which;
        if(e.which == 13) //enter
                to_page(j);
}

function create_pagesel(id,j)
{
	var pagesel = "<TABLE><TR><TD class=BT_SMALL id="+id+"4 onMouseover=chk_action('"+id+"4','move','"+j+"') onMouseout=chk_action('"+id+"4','out','"+j+"') onMousedown=chk_action('"+id+"4','down','"+j+"') onclick='to_prev(\""+id+"4\",1,\""+j+"\")'><img src=image/First.gif id=cmdfirst"+id+"></TD>";
	pagesel+="<TD class=BT_SMALL id="+id+"5 onMouseover=chk_action('"+id+"5','move','"+j+"') onMouseout=chk_action('"+id+"5','out','"+j+"') onMousedown=chk_action('"+id+"5','down','"+j+"') onclick='to_prev(\""+id+"5\",0,\""+j+"\")'><img src=image/Previous.gif id=cmdprev"+id+"></TD><TD nowrap>";
	pagesel+=__T(share.page)+"&nbsp;<input size=3 id="+id+"8 name=txt_"+id+"_page onBlur='to_page("+j+")' onKeyDown='to_page_enter(event,"+j+")' value=1>&nbsp;"+__T(share.of)+"&nbsp;<SPAN id="+id+"page></TD>";
	pagesel+="<TD class=BT_SMALL id="+id+"6 onMouseover=chk_action('"+id+"6','move','"+j+"') onMouseout=chk_action('"+id+"6','out','"+j+"') onMousedown=chk_action('"+id+"6','down','"+j+"') onclick='to_next(\""+id+"6\",0,\""+j+"\")'><img src=image/Next.gif id=cmdnext"+id+"></TD>";
	pagesel+="<TD class=BT_SMALL id="+id+"7 onMouseover=chk_action('"+id+"7','move','"+j+"') onMouseout=chk_action('"+id+"7','out','"+j+"') onMousedown=chk_action('"+id+"7','down','"+j+"') onclick='to_next(\""+id+"7\",1,\""+j+"\")'><img src=image/Last.gif id=cmdlast"+id+"></TD></TR></TABLE>";
	return pagesel;
}

function to_back(F)
{
	parent.document.getElementById("newpage").value = "webfilter.asp";
	uiDoCancel(F,"back");
}

function refresh_page()
{
	alert_result(0);
	var F = document.frmfilter;
	F.submit_button.value = "except";
	F.change_action.value="gozila_cgi";
	F.submit();
}
function fill_data(d_type)
{
	_data[d_type] = new Array(count_entry[d_type]);
	for(var i=0; i<count_entry[d_type]; i++)
	{
		_data[d_type][i]= new Array(3);
                _data[d_type][i][0] = "<input type=checkbox id="+obj_id[d_type][0]+i+" onclick=chk_click('"+i+"','"+d_type+"')>";
		if ( d_type == 0 )
		{
			_data[d_type][i][1] = web_name[w_data[i][0]-1];
			_data[d_type][i][2] = w_data[i][1];
		}else if ( d_type == 1 ) 
		{
			_data[d_type][i][1] = web_name[b_data[i][0]-1];
			_data[d_type][i][2] = b_data[i][1];
		}
		else
		{
			_data[d_type][i][1] = pc_name[e_data[i][0]-1];
			_data[d_type][i][2] = e_data[i][1];
		}
	}
}

function fill_entry(j)
{
	idx[j] = 0;
	//alert(start_line[j]+"-"+end_line[j]);
        for(var i=start_line[j]-1; i<end_line[j]; i++)
        { 
        	if ( i == count_entry[j] ) break;
                var def = new Array();
                def[0] = new Array(td_id[j][0]+idx[j],_data[j][i][0],3);
                def[1] = new Array(td_id[j][1]+idx[j],_data[j][i][1],3);
                def[2] = new Array(td_id[j][2]+idx[j],_data[j][i][2],0);
                def[3] = new Array("","&nbsp;");
                add_row(idx[j],def,obj_id[j][0],stflg[j],2);
                idx[j]++;
        }
}

function init(){
	var F = document.frmfilter;
	var index="";
	var sel=0;
	var data="", tmp=""; 
	parent.document.getElementById("save_bg").style.display="none";
	get_parm(F);
	for(var j=0; j<3; j++)
	{
                fill_data(j);
		fill_entry(j);
	}
	default_nv = get_data(F);
}

function sel_exctype(index,F)
{
	var obj="";
	var maxlen="";
	if (  eval("F."+obj_id[2][1]+index).value == "1" ) 
	{
		maxlen = "39";
		obj = draw_td(O_VAR,ICONLINE,img_id[2]+index,"<input size=51 maxlength="+maxlen+" id="+obj_id[2][2]+index+" onBlur='' onMouseMove=showHint('"+img_id[2]+index+"','"+div_id[2]+index+"',event) onMouseOut=hideHint('"+div_id[2]+index+"')>",div_id[2]+index);

	}else if ( eval("F."+obj_id[2][1]+index).value == "2" ) //IP Range
	{
		obj = draw_td(O_VAR,ICONLINE,img_id[2]+index,"<input size=51 maxlength=39 id="+obj_id[2][2]+index+" onBlur='' onMouseMove=showHint('"+img_id[2]+index+"','"+div_id[2]+index+"',event) onMouseOut=hideHint('"+div_id[2]+index+"')> ~ <input size=51 maxlength=39 id="+obj_id[2][3]+index+" onBlur='' onMouseMove=showHint('"+img_id[2]+index+"','"+div_id[2]+index+"',event) onMouseOut=hideHint('"+div_id[2]+index+"')>",div_id[2]+index);
	}
	document.getElementById(td_id[2][2]+index).innerHTML = obj;
}

function get_exc_type(index)
{
	var seltype = "";
	if ( document.getElementById(obj_id[2][1]+index) ){
		seltype = document.getElementById(obj_id[2][1]+index).value;
	}else{
		seltype = e_data[index][0];
		//alert("e_data["+index+"]="+e_data[index][0]);
                //if ( tmp == pc_name[0] ) seltype = "1";
                //else if ( tmp == pc_name[1] ) seltype = "2";
	}
	return seltype;
}

function get_exc_val(index)
{
	var seltype = get_exc_type(index);
	var tmp="";
	if ( document.getElementById(obj_id[2][1]+index) ){
		tmp = parseIP(document.getElementById(obj_id[2][2]+index).value);
		if ( seltype == "2" ) 
			tmp += "~"+parseIP(document.getElementById(obj_id[2][3]+index).value);
	}
	else{
		//tmp = parseIP(document.getElementById(td_id[2][2]+index).innerHTML).toUpperCase();
		tmp = e_data[index][1];
	}
	return tmp;
}

function get_exc_iptype(index)
{
	var F = document.frmfilter;
	var tmptype="",tmptype2="";
	var seltype = parseInt(get_exc_type(index),10);
	var errmsg="",errflg=0;
	var pptpd_enable = "<% nvram_get("pptpd_enable"); %>";
	var tmp = "<% nvram_get("pptpd_remoteip"); %>"; //pptpd_remoteip=10.0.0.10-19
	var pptpd_remoteip = "";
	if ( tmp != "" ) 
		pptpd_remoteip = tmp.split("-");
	if ( document.getElementById(obj_id[2][1]+index) ){
		if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
			errmsg = valid_ipmode_check(F,obj_id[2][2]+index,LANSUBNET_OK,"IPv6");
		else{
			if ( pptpd_enable == "1" && typeof pptpd_remoteip[0] != "undefined" )  
			{
				if ( valid_subnet(document.getElementById(obj_id[2][2]+index).value,"255.255.255.0",pptpd_remoteip[0]) == true ) 
				{
					if ( chk_range(obj_id[2][2]+index,document.getElementById(obj_id[2][2]+index).value.split(".")[3],pptpd_remoteip[0].split(".")[3],pptpd_remoteip[1],10) == FAIL ) 
                                                errmsg = __T(filter.subnet8);
				}else
					errmsg = valid_ipmode_check(F,obj_id[2][2]+index,LANSUBNET_OK);
					
			}else	
				errmsg = valid_ipmode_check(F,obj_id[2][2]+index,LANSUBNET_OK);
		}
		if ( !errmsg ){ 
			if ( test_ipv6(document.getElementById(obj_id[2][2]+index).value) ) tmptype = "ipv6";
			else if ( check_ipv4(document.getElementById(obj_id[2][2]+index).value,VALID_IP_RULE1) == PASS  ) tmptype = "ipv4";
		}else{
			create_tbmsg(index,errmsg);
			return "err";
		}
		if ( seltype > 1 ) 
		{
			errmsg = "";
			if ( "<% nvram_get("lan_ip_mode"); %>" == "2" )
				errmsg = valid_ipmode_check(F,obj_id[2][3]+index,LANSUBNET_OK,"IPv6");
			else{
				if ( pptpd_enable == "1" && typeof pptpd_remoteip[0] != "undefined" )  
	                        {
                                	if ( valid_subnet(document.getElementById(obj_id[2][3]+index).value,"255.255.255.0",pptpd_remoteip[0]) == true ) 
                                	{
                                        	if ( chk_range(obj_id[2][3]+index,document.getElementById(obj_id[2][3]+index).value.split(".")[3],pptpd_remoteip[0].split(".")[3],pptpd_remoteip[1],10) == FAIL ) 
                                                	errmsg = __T(filter.subnet8);
	                                }else
        	                                errmsg = valid_ipmode_check(F,obj_id[2][3]+index,LANSUBNET_OK);
                	                        
                        	}else
					errmsg = valid_ipmode_check(F,obj_id[2][3]+index,LANSUBNET_OK);
			}
			if ( !errmsg ) 
			{
				if ( test_ipv6(document.getElementById(obj_id[2][3]+index).value) ) tmptype2 = "ipv6";
				else if ( check_ipv4(document.getElementById(obj_id[2][3]+index).value,VALID_IP_RULE1) == PASS ) tmptype2 = "ipv4";
			}else{
				create_tbmsg(index,errmsg);
				errflg=1;
				return "err";
			}
			if ( tmptype2 == "" ) 
			{
				create_tbmsg(index,__T(msg.ivalidipformat));
				errflg=1;
			}
			if ( tmptype != tmptype2 ) 
			{
				create_tbmsg(index,__T(msg.ivalidipformat));
				errflg=1;
			}
			if ( tmptype == "ipv4" ) 
			{
				var s = document.getElementById(obj_id[2][2]+index).value.split(".");
				var e = document.getElementById(obj_id[2][3]+index).value.split(".");
				if ( parseInt(s[3],10) > parseInt(e[3],10) )
				{
					create_tbmsg(index,__T(msg.ipchk));
					errflg=1;
				}
			}
		}
	}else{
		if ( seltype == "2" ) 
		{
			var tmp = e_data[index][1].split("~");
			var tmpip = tmp[0];
		}
		else
			var tmpip = e_data[index][1];
		if ( test_ipv6(tmpip)) tmptype = "ipv6";
		else if ( check_ipv4(tmpip,VALID_IP_RULE1) == PASS) tmptype = "ipv4";
	}
	if ( errflg == 1 ) return "err";
	return tmptype;
}

function create_tbmsg(i,msg)
{
	var seltype = parseInt(get_exc_type(i),10);
	if ( document.getElementById(obj_id[2][1]+i) != null )
	{
		table_msg(img_id[2]+i,obj_id[2][2]+i,div_id[2]+i,table_id[2]+"_"+i,msg);
		if ( seltype > 4 ) 
			table_msg(img_id[2]+i,obj_id[2][3]+i,div_id[2]+i,table_id[2]+"_"+i,msg);
	}
	
}

var kiptype="";
function chk_exc_before_data(index)
{
	// 1:IP, 2:IP Ragne
	var errflg=0;
	var seltype_a="",seltype_b="";
	var val_a="",val_b="";
	var iptype_a="",iptype_b="";
	if ( index < 0 ) return true;
	if ( document.getElementById(obj_id[2][1]+index) ){
		clear_table_msg("tmsg"+table_id[2],img_id[2]+index,obj_id[2][1]+index,table_id[2]+"_"+index);
		if (  document.getElementById(obj_id[2][2]+index).value == "" ) 
		{
			table_msg(img_id[2]+index,obj_id[2][2]+index,div_id[2]+index,table_id[2]+"_"+index,__T(msg.notblank));
			errflg = 1 ; 
		}
		if (  document.getElementById(obj_id[2][1]+index).value == "2" ) 
		{
			clear_table_msg("tmsg"+table_id[2],img_id[2]+index,obj_id[2][3]+index,table_id[2]+"_"+index);
			if (  document.getElementById(obj_id[2][3]+index) == "" ){ 
		                table_msg(img_id[2]+index,obj_id[2][3]+index,div_id[2]+index,table_id[2]+"_"+index,__T(msg.notblank));
		        	errflg = 1 ; 
                        }
		}	
	}
	if ( errflg == 1 ) return false;
	seltype_b = get_exc_type(index);
	val_b = get_exc_val(index);
	iptype_b = get_exc_iptype(index);
	//alert(seltype_b+","+val_b+","+iptype_b);
	for(var i=0; i<count_entry[2]; i++)
	{
		if ( i==index ) continue;
		if ( document.getElementById(obj_id[2][1]+i) != null )
			clear_table_msg("tmsg"+table_id[2],img_id[2]+i,div_id[2]+i,table_id[2]+"_"+i);
		seltype_a = get_exc_type(i);
		val_a = get_exc_val(i);
		iptype_a = get_exc_iptype(i);
		//alert("iptype_b="+iptype_b+";iptype_a="+iptype_a+";val_a="+val_a+";val_b="+val_b);
		if ( iptype_a != "err" && iptype_b != "err" && ( seltype_a == seltype_b ) && ( val_a == val_b ) && (val_a != "" || val_b != "")) 
		{
			create_tbmsg(i,__T(msg.ipexist));
			create_tbmsg(index,__T(msg.ipexist));
			errflg=1;
		}
		if ( iptype_b != "mac" || iptype_a != "mac" ) 
		{
			if ( iptype_a == "" || iptype_b == "" || 
			     ( iptype_b != "mac" && iptype_a != "mac" && 
                               iptype_a !="err" && iptype_b != "err" && (iptype_a != iptype_b)))
			{
				if ( iptype_b != "mac") 
					create_tbmsg(index,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
				if ( iptype_a != "mac" ) 
					create_tbmsg(i,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
				errflg = 1;
			}
		}
	}
	if ( iptype_a =="err" || iptype_b =="err" || errflg == 1 ) return false; 
	if ( idx[2] == 1 ){
		if ( iptype_b != "ipv4" && iptype_b != "ipv6" &&
		     iptype_b != "mac" && iptype_a != "mac" ) 
		{
			create_tbmsg(index,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
			create_tbmsg(i,__T(msg.ivalidipformat)); //IP type should be the same as IPv4 or IPv6
			errflg = 1;
			return false;
		}
	} 
	return true;
}

function to_edit()//pc_edit
{
	stflg[2] = "editexc";
	disable_showing_page(2);
	document.getElementById("tmsgexc").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgexc").style.display="";
	choose_disable(document.getElementById("a2"));
	choose_disable(document.getElementById("a4"));
	for(var i=0; i<idx[2]; i++)
	{
		if( document.getElementById(obj_id[2][0]+i).checked == true && document.getElementById(obj_id[2][1]+i) == null )
		{
			var data = new Array();
			data[0]="<input type=checkbox id="+obj_id[2][0]+i+" onclick=chk_click('"+i+"','2') checked>";
			for(var j=0; j<pc_name.length; j++)
			{
				if ( document.getElementById(td_id[2][1]+i).innerHTML == pc_name[j] ) 
				{
					data[1]=draw_object(O_VAR,SELBOX,obj_id[2][1]+i,"id="+obj_id[2][1]+i+" onChange=sel_exctype("+i+",this.form)", pc_name,pc_val,pc_val[j]);	
					break;
				}
			}
			var val = document.getElementById(td_id[2][2]+i).innerHTML;
			if ( document.getElementById(td_id[2][1]+i).innerHTML == __T(share.iprange) )
			{
				tmpval = val.split("~");
				data[2]=draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=51 maxlength=39 id="+obj_id[2][2]+i+" onBlur=chk_exc_before_data('"+i+"') onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+tmpval[0]+"> ~ <input size=51 maxlength=39 id="+obj_id[2][3]+i+" onBlur='' onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+tmpval[1]+">",div_id[2]+i);
			}else{
				data[2]=draw_td(O_VAR,ICONLINE,img_id[2]+i,"<input size=51 maxlength=39 id="+obj_id[2][2]+i+" onBlur=chk_exc_before_data('"+i+"') onMouseMove=showHint('"+img_id[2]+i+"','"+div_id[2]+i+"',event) onMouseOut=hideHint('"+div_id[2]+i+"') value="+val+">",div_id[2]+i);
			}
	        	edit_row(td_id[2],data,i);
		}
			
	}
}
function to_add() //pc_add
{
	var F = document.frmfilter;
        var keep_idx = get_real_idx(2);
	if ( keep_idx >= EXCULSION_ENTRY  )
        {
                my_alert(O_PAGE,INFO,spell_words(max_rule,EXCULSION_ENTRY,__T(filter.exclist)),"");
                return false;
        }
	if ( stflg[2].indexOf("add") == -1 && keep_idx > 0 )
	{
                goto_last_page(2,F);
	}
        else
                add_new_row(2,F);

/*
	if ( !chk_exc_before_data(idx_exc-1) ) return;	
	var tmp = new Array();
	tmp[0]=new Array("tdexcchk"+idx_exc,"<input type=checkbox id=excchk_"+idx_exc+" onclick=exc_chk_click('"+idx_exc+"') disabled>",3);
	tmp[1]=new Array(exc_td_id[0]+idx_exc,draw_object(O_VAR,SELBOX,"exc_seltype"+idx_exc,"id=exc_seltype"+idx_exc+" onChange=sel_exctype("+idx_exc+",this.form)",pc_name,pc_val),3);
	tmp[2]=new Array(exc_td_id[1]+idx_exc,draw_td(O_VAR,ICONLINE,"excval_img"+idx_exc,"<input size=51 maxlength=39 id=exc_val"+idx_exc+" onBlur=chk_exc_before_data('"+idx_exc+"') onMouseMove=showHint('excval_img"+idx_exc+"','excval_div"+idx_exc+"',event) onMouseOut=hideHint('excval_div"+idx_exc+"')>","excval_div"+idx_exc),1);
	tmp[3]=new Array("","&nbsp;");
	add_row(idx_exc,tmp,"excchk_","addexc",2);
	idx_exc++;
*/
}
function chk_list_before_data(index,j){
	//1:URL, 2:Keyword
	var errflg = "";	
	if ( document.getElementById(obj_id[j][1]+index) == null ) return true; 
	var type= document.getElementById(obj_id[j][1]+index).value;
	var obj = document.getElementById(obj_id[j][2]+index);
	clear_table_msg("tmsg"+table_id[j],img_id[j]+index,obj_id[j][2]+index,table_id[j]+"_"+index);
	if ( obj.value == "" ) 
	{
		table_msg(img_id[j]+index,obj_id[j][2]+index,div_id[j]+index,table_id[j]+"_"+index,__T(msg.notblank));
		errflg = 1 ; 
	}else{
		if ( type == "1" ) 
		{
			if ( !check_domain(obj.value) ) 
			{
				table_msg(img_id[j]+index,obj_id[j][2]+index,div_id[j]+index,table_id[j]+"_"+index,__T(msg.validname));
		                errflg = 1 ;
				return false;
			}
			
		}
	}
	if ( errflg == 1 ) return false;
	return true;
}
function white_chk_click(index)
{
//	if ( web_disflg == 1 ) return;
	var count=0;
	to_check("whitechk_",document.getElementById("whitechk_"+index).checked,index,idx_white,white_stflg,white_td_id,white_data[index]);
	for(var i=0; i<idx_white; i++){
		if ( document.getElementById("whitechk_"+i).checked == true ) count++; 
	}
	if ( count > 0 ) 
	{
		choose_disable(document.getElementById("t5"));
		choose_enable(document.getElementById("t6"));
		choose_enable(document.getElementById("t7"));
	}else{
		choose_enable(document.getElementById("t5"));
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("t7"));
	}
}

function exc_all_chk(F)
{
	var count=0;
	for(var i=0; i<idx[2]; i++)
	{
		if ( F.exc_chkall.checked == true ) 
		{
			document.getElementById("excchk_"+i).checked = true;
			count++;
		}
		else
			document.getElementById("excchk_"+i).checked = false;
		to_check("excchk_",document.getElementById("excchk_"+i).checked,i,idx[2],stflg[2],td_id[2],_data[2][i]);
	}
	if ( count > 0 ){
                choose_disable(document.getElementById("a2"));
                choose_enable(document.getElementById("a4"));
                choose_enable(document.getElementById("a3"));
        }else{
                choose_enable(document.getElementById("a2"));
                choose_disable(document.getElementById("a3"));
                choose_disable(document.getElementById("a4"));
        }
}

function white_all_chk(F)
{
	var count=0;
        for(var i=0; i<idx[0]; i++)
        {
                if ( F.white_chkall.checked == true )
		{
                        document.getElementById("whitechk_"+i).checked = true;
			count++;
		}
                else
                        document.getElementById("whitechk_"+i).checked = false;
                to_check("whitechk_",document.getElementById("whitechk_"+i).checked,i,idx[0],stflg[0],td_id[0],_data[0][i]);
        }
	if ( count > 0 ){
                choose_disable(document.getElementById("t5"));
                choose_enable(document.getElementById("t6"));
                choose_enable(document.getElementById("t7"));
        }else{
                choose_enable(document.getElementById("t5"));
                choose_disable(document.getElementById("t6"));
                choose_disable(document.getElementById("t7"));
        }
}

function block_all_chk(F)
{
        var count=0;
        for(var i=0; i<idx[1]; i++)
        {
                if ( F.block_chkall.checked == true )
                {
                        document.getElementById("blackchk_"+i).checked = true;
                        count++;
                }
                else
                        document.getElementById("blackchk_"+i).checked = false;
                to_check("blackchk_",document.getElementById("blackchk_"+i).checked,i,idx[1],stflg[1],td_id[1],_data[1][i]);
        }
        if ( count > 0 ){
                choose_disable(document.getElementById("t8"));
                choose_enable(document.getElementById("t9"));
                choose_enable(document.getElementById("t10"));
        }else{
                choose_enable(document.getElementById("t8"));
                choose_disable(document.getElementById("t9"));
                choose_disable(document.getElementById("t10"));
        }
}

function exc_chk_click(index)
{
	var count=0;
	to_check("excchk_",document.getElementById("excchk_"+index).checked,index,idx_exc,exc_stflg,exc_td_id,exc_data[index]);
	for(var i=0; i<idx_exc; i++){
                if ( document.getElementById("excchk_"+i).checked == true ) count++;
        }
	if ( count > 0 ){
		choose_disable(document.getElementById("a2"));
		choose_enable(document.getElementById("a3"));
		choose_enable(document.getElementById("a4"));
	}else{
		choose_enable(document.getElementById("a2"));
		choose_disable(document.getElementById("a3"));
		choose_disable(document.getElementById("a4"));
	}
}

function to_edit_white(F){
	disable_showing_page(0);
	stflg[0] = "editwhite";
	document.getElementById("tmsgwhite").innerHTML = __T(msg.tablemsg); 
        document.getElementById("tmsgwhite").style.display="";
        choose_disable(document.getElementById("t5"));
        choose_disable(document.getElementById("t6"));
	for(var i=0; i<idx[0]; i++){
		if( document.getElementById(obj_id[0][0]+i).checked == true && document.getElementById(obj_id[0][1]+i) == null )
		{
			var data = new Array();
			data[0]="<input type=checkbox id="+obj_id[0][0]+i+" onclick=chk_click('"+i+"','0') checked>";
			for(var j=0; j<web_name.length; j++)
			{
				if ( document.getElementById(td_id[0][1]+i).innerHTML == web_name[j] ) 
				{
					data[1]=draw_object(O_VAR,SELBOX,obj_id[0][1]+i,"id="+obj_id[0][1]+i,web_name,web_val,web_val[j]);
					break;
				}
			}
			data[2]=draw_td(O_VAR,ICONLINE,img_id[0]+i,"<input size=20 maxlength=64 id="+obj_id[0][2]+i+" onBlur=chk_list_before_data("+i+",'0') onMouseMove=showHint('"+img_id[0]+i+"','"+div_id[0]+i+"',event) onMouseOut=hideHint('"+div_id[0]+i+"') value="+document.getElementById(td_id[0][2]+i).innerHTML+">",div_id[0]+i);
	        	edit_row(td_id[0],data,i);
		}
	}
}

function to_edit_block(F){
	disable_showing_page(1);
        stflg[1] = "editblock";
        document.getElementById("tmsgblock").innerHTML = __T(msg.tablemsg); 
        document.getElementById("tmsgblock").style.display="";
        choose_disable(document.getElementById("t8"));
        choose_disable(document.getElementById("t10"));
        for(var i=0; i<idx[1]; i++){
                if( document.getElementById(obj_id[1][0]+i).checked == true && document.getElementById(obj_id[1][1]+i) == null )
                {
                        var data = new Array();
                        data[0]="<input type=checkbox id="+obj_id[1][0]+i+" onclick=chk_click('"+i+"','1') checked>";
                        for(var j=0; j<web_name.length; j++)
                        {
                                if ( document.getElementById(td_id[1][1]+i).innerHTML == web_name[j] ) 
                                {
                                        data[1]=draw_object(O_VAR,SELBOX,obj_id[1][1]+i,"id="+obj_id[1][1]+i,web_name,web_val,web_val[j]);
                                        break;
                                }
                        }
			data[2]=draw_td(O_VAR,ICONLINE,img_id[1]+i,"<input size=20 maxlength=64 id="+obj_id[1][2]+i+" onBlur=chk_list_before_data("+i+",'0') onMouseMove=showHint('"+img_id[1]+i+"','"+div_id[1]+i+"',event) onMouseOut=hideHint('"+div_id[1]+i+"') value="+document.getElementById(td_id[1][2]+i).innerHTML+">",div_id[1]+i);
                        edit_row(td_id[1],data,i);
                }
        }
}

function to_add_block(F)
{
	var keep_idx = get_real_idx(1);
	if ( keep_idx >= BLACK_ENTRY  )
	{
               	my_alert(O_PAGE,INFO,spell_words(max_rule,BLACK_ENTRY,__T(filter.blacklist)),"");
	        return false;
	}
	if ( stflg[1].indexOf("add") == -1 && keep_idx > 0 ) 
		goto_last_page(1,F);
	else
		add_new_row(1,F);
}

function get_real_idx(j)
{
	var cnt = count_entry[j];
	for(var i=0; i<WHITE_ENTRY; i++)
	{
		if ( document.getElementById(obj_id[j][1]+i) != null ) cnt++;
	}
	return cnt;
}

function to_add_white(F)
{
	var keep_idx = get_real_idx(0);
	if ( keep_idx >= WHITE_ENTRY  )
	{
               	my_alert(O_PAGE,INFO,spell_words(max_rule,WHITE_ENTRY,__T(filter.whitelist)),"");
	        return false;
	}
	if ( stflg[0].indexOf("add") == -1 && keep_idx > 0 ) 
		goto_last_page(0,F);
	else
		add_new_row(0,F);
}

function clear_entry(j,F)
{
	if ( count_entry[j] != 0 ) 
	{
		var delcnt = end_line[j]-start_line[j]+1;
		if ( delcnt > count_entry[j] ) delcnt = count_entry[j];
		//alert("delcnt="+delcnt);
		for(var i=0; i<delcnt; i++)
			document.getElementById("_table"+table_id[j]).deleteRow(2);
		
		//if ( end_line[j] != count_entry[j] ) 
		//{
		//	start_line[j] = (total_page[j]-1)*now_count[j]+1;
		//	end_line[j] = (total_page[j]*now_count[j])>count_entry[j]?count_entry[j]:(total_page[j]*now_count[j]);
		//	fill_entry(j);
		//}else
			idx[j] = 0; 	
	}
}

function goto_last_page(j,F)
{
	if ( now_count[j] <= count_entry[j] ) 
	{
		if ( count_entry[j]%now_count[j]==0 ) 
			clear_entry(j,F);
		else
			to_next("7",1,j);
	}
	add_new_row(j,F);
}

function chk_click(index,j)
{
	var button_list = new Array(3);
	button_list[0] = new Array("t5","t7","t6");
	button_list[1] = new Array("t8","t9","t10");
	button_list[2] = new Array("a2","a3","a4");

	var count=0;
	to_check(obj_id[j][0],document.getElementById(obj_id[j][0]+index).checked,index,idx[j],stflg[j],td_id[j],_data[j][index]);
	for(var i=0; i<idx[j]; i++){
                if ( document.getElementById(obj_id[j][0]+i).checked == true ) count++;
        }
	if ( count > 0 ){
		choose_disable(document.getElementById(button_list[j][0]));
		choose_enable(document.getElementById(button_list[j][1]));
		choose_enable(document.getElementById(button_list[j][2]));
	}else{
		choose_enable(document.getElementById(button_list[j][0]));
		choose_disable(document.getElementById(button_list[j][1]));
		choose_disable(document.getElementById(button_list[j][2]));
	}
	
}

function add_new_row(j, F)
{
	disable_showing_page(j);
        if ( j == 0 ) 
                stflg[0] = "addwhite";
        else if ( j == 1 ) 
                stflg[1] = "addblock";
        else if ( j == 2 ) 
                stflg[2] = "addexc";
	if ( j == 2 ){ 
		if ( !chk_exc_before_data(idx[j]-1)) return
	}else{
		if ( !chk_list_before_data(idx[j]-1,j)) return
	}
	var tmp = new Array();
	tmp[0]=new Array(td_id[j][0]+idx[j],"<input type=checkbox id="+obj_id[j][0]+idx[j]+" onclick=chk_click('"+idx[j]+"','"+j+"') disabled>",3);
	if ( j == 2 ) 
	{
	        tmp[1]=new Array(td_id[j][1]+idx[j],draw_object(O_VAR,SELBOX,obj_id[j][1]+idx[j],"onChange=sel_exctype("+idx[j]+",this.form) id="+obj_id[j][1]+idx[j],pc_name,pc_val),3);
		tmp[2]=new Array(td_id[j][2]+idx[j],draw_td(O_VAR,ICONLINE,img_id[j]+idx[j],"<input size=51 maxlength=39 id="+obj_id[j][2]+idx[j]+" onBlur=chk_exc_before_data('"+idx[j]+"') onMouseMove=showHint('"+img_id[j]+idx[j]+"','"+div_id[j]+idx[j]+"',event) onMouseOut=hideHint('"+div_id[j]+idx[j]+"')>",div_id[j]+idx[j]),1);
	}else{
	        tmp[1]=new Array(td_id[j][1]+idx[j],draw_object(O_VAR,SELBOX,obj_id[j][1]+idx[j],"id="+obj_id[j][1]+idx[j],web_name,web_val),3);
        	tmp[2]=new Array(td_id[j][2]+idx[j],draw_td(O_VAR,ICONLINE,img_id[j]+idx[j],"<input size=20 maxlength=64 id="+obj_id[j][2]+idx[j]+" onBlur=chk_list_before_data("+idx[j]+",'"+j+"') onMouseMove=showHint('"+img_id[j]+idx[j]+"','"+div_id[j]+idx[j]+"',event) onMouseOut=hideHint('"+div_id[j]+idx[j]+"')>",div_id[j]+idx[j]),1);
	}
	tmp[3]=new Array("","&nbsp;");
        add_row(idx[j],tmp,obj_id[j][0],stflg[j],2);
        idx[j]++;
}

function disable_showing_page(j)
{
	var F = document.frmfilter;
	if ( j == 0 ){
		choose_disable(F.w_selcnt);
		choose_disable(F.txt_w_page);
	}else if ( j == 1 ){
		choose_disable(F.b_selcnt);
		choose_disable(F.txt_b_page);
	}else{
		choose_disable(F.e_selcnt);
		choose_disable(F.txt_e_page);
	}
}

function chk_white_black_value(F)
{
	var typea,typeb,vala,valb;
	for(var i=0; i<idx[0]; i++) //WHITE
	{
		if ( document.getElementById(obj_id[0][1]+i) ) 
		{
			typea = document.getElementById(obj_id[0][1]+i).value;
			vala = document.getElementById(obj_id[0][2]+i).value;
		}else{
			if ( document.getElementById("tdwtype"+i).innerHTML == __T(lan.domainname) ) 
				typea = "1";
			else 
				typea = "2";
			vala = document.getElementById("tdwval"+i).innerHTML;
		}
		for(var j=0; j<idx[1]; j++) //BLACK
		{
			if ( document.getElementById(obj_id[1][1]+j) ) 
			{
				typeb = document.getElementById(obj_id[1][1]+j).value;
				valb = document.getElementById(obj_id[1][2]+j).value;
			}else{
				if ( document.getElementById("tdbtype"+j).innerHTML == __T(lan.domainname) ) 
					typeb = "1";
				else 
					typeb = "2";
				valb = document.getElementById("tdbval"+j).innerHTML;
			}
			//alert("typea="+typea+";typeb="+typeb+";vala="+vala+";valb="+valb);			
			if ( typea == typeb && vala == valb ) 
			{
				if ( document.getElementById(obj_id[1][1]+j) ) 
					table_msg(img_id[1]+j,obj_id[1][2]+j,div_id[1]+j,table_id[1]+"_"+j,__T(filter.whiteblackmsg));
				if ( document.getElementById(obj_id[0][1]+i) )
					table_msg(img_id[0]+i,obj_id[0][2]+i,div_id[0]+i,table_id[0]+"_"+i,__T(filter.whiteblackmsg));
				return false;
			}
			
		}
	}
	return true;
}

function get_list_data(F,j)
{
	var tmp = "", allval="";
	var count=0;
	if ( j == 0 ) 
	{
		F.wf_white_list.value = "";
		F.white_stflg.value = stflg[0];
	}else{ 
		F.wf_block_list.value = "";
		F.block_stflg.value = stflg[1];
	}

	for(var i=0; i<WHITE_ENTRY; i++)
	{
		if ( stflg[j].indexOf("del") != -1 ) 
		{
                       	if ( document.getElementById("tr_table"+table_id[j]+"_"+i) == null ) continue;
                       	if ( document.getElementById("tr_table"+table_id[j]+"_"+i).className == "TABLECONTENT_DEL")
			{
				var real_idx = parseInt(now_count[j],10)*(parseInt(now_page[j],10)-1)+i+1;
				if ( allval != "" ) allval += " ";
				allval += real_idx;	
			}
		}else{
			if ( document.getElementById(obj_id[j][1]+i) != null ) 
			{
				if ( !chk_list_before_data(i,j)) return false;
				tmp = "";
				if ( stflg[j].indexOf("edit") != -1 ) 
				{
					var real_idx = parseInt(now_count[j],10)*(parseInt(now_page[0],10)-1)+i+1;
					tmp+=real_idx+",";
				}
				tmp+=document.getElementById(obj_id[j][1]+i).value+","
				tmp+=document.getElementById(obj_id[j][2]+i).value.length+",";
				tmp+=document.getElementById(obj_id[j][2]+i).value;
				tmp+=";"
//				if ( allval != "" ) allval += ";";
				allval += tmp;
			}
		}
	}
	//alert(allval);
	if ( j == 0 ) 
		F.wf_white_list.value = allval;
	else 
		F.wf_block_list.value = allval;
	return true;
	
}

function to_del_white(){
        stflg[0] = "delwhite";
        // table message
        document.getElementById("tmsgwhite").innerHTML = __T(msg.tablemsg);
        document.getElementById("tmsgwhite").style.display="";
        // disabled the add and edit button
        choose_disable(document.getElementById("t5"));
        for(var i=0; i<idx[0]; i++)
        {
                if ( document.getElementById(obj_id[0][0]+i).checked == true )
                        document.getElementById("tr_tablewhite_"+i).className= "TABLECONTENT_DEL";
        }
}

function to_del_block(){
        stflg[1] = "delblock";
	disable_showing_page(1);
        // table message
        document.getElementById("tmsgblock").innerHTML = __T(msg.tablemsg);
        document.getElementById("tmsgblock").style.display="";
        // disabled the add and edit button
        choose_disable(document.getElementById("t8"));
        for(var i=0; i<idx[1]; i++)
        {
                if ( document.getElementById(obj_id[1][0]+i).checked == true )
                        document.getElementById("tr_tableblock_"+i).className= "TABLECONTENT_DEL";
        }
}

function to_del(){
	stflg[2] = "delexc";
	disable_showing_page(2);
	// table message
	document.getElementById("tmsgexc").innerHTML = __T(msg.tablemsg); 
	document.getElementById("tmsgexc").style.display="";
	for(var i=0; i<idx[2]; i++)
	{
		if ( document.getElementById(obj_id[2][0]+i).checked == true ) 
			document.getElementById("tr_tableexc_"+i).className= "TABLECONTENT_DEL";
	}
	// disabled the add and edit button
	//alert(document.getElementById("a3").className);
	choose_disable(document.getElementById("a2"));
	choose_disable(document.getElementById("a3"));
}
function get_exc_data(F,j)
{
	var tmp = "";
	var count=0;
	var allval = "";
	F.wf_exclude_list.value = "";
        F.exc_stflg.value = stflg[2];

        for(var i=0; i<WHITE_ENTRY; i++)
        {
                if ( stflg[j].indexOf("del") != -1 ) 
                {
                        if ( document.getElementById("tr_table"+table_id[j]+"_"+i) == null ) continue;
                        if ( document.getElementById("tr_table"+table_id[j]+"_"+i).className == "TABLECONTENT_DEL")
                        {
                                var real_idx = parseInt(now_count[j],10)*(parseInt(now_page[j],10)-1)+i+1;
                                if ( allval != "" ) allval += " ";
                                allval += real_idx;     
                        }
                }else{
                        if ( document.getElementById(obj_id[j][1]+i) != null ) 
                        {
                                if ( !chk_exc_before_data(i)) return false;
                                tmp = "";
                                if ( stflg[j].indexOf("edit") != -1 ) 
                                {
                                        var real_idx = parseInt(now_count[j],10)*(parseInt(now_page[0],10)-1)+i+1;
                                        tmp+=real_idx+",";
                                }
                                tmp+=document.getElementById(obj_id[j][1]+i).value+","
                                tmp+=document.getElementById(obj_id[j][2]+i).value.length+",";
                                tmp+=document.getElementById(obj_id[j][2]+i).value;
				if ( document.getElementById(obj_id[j][1]+i).value == "2" ) 
				{
	                                tmp+=","+document.getElementById(obj_id[j][3]+i).value.length+",";
        	                        tmp+=document.getElementById(obj_id[j][3]+i).value;
				}
				tmp+=";";
                                //if ( allval != "" ) allval += ";";
                                allval += tmp;
                        }
                }
        }
        //alert(allval);

        F.wf_exclude_list.value = allval;
	return true;
}
function uiDoSave(F){
	if ( !chk_white_black_value(F) ) return false;
	if ( !get_list_data(F,0) || !get_list_data(F,1) || !get_exc_data(F,2) ) return false;
	F.submit_button.value = "except";
	F.gui_action.value="Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function get_data(F)
{
	get_list_data(F,0);
	get_list_data(F,1);
	get_exc_data(F,2);
	var data = F.wf_white_list.value + F.wf_block_list.value + F.wf_exclude_list.value;
	return data;
}

function select_count(val,F,j)
{
	selflg[j]=1;
	clear_entry(j,F);
	get_parm(F);
	fill_entry(j);
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmfilter method=<% get_http_method(); %> action=apply.cgi onKeyDown="if (event.keyCode==13){return false}">
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=backname>
<input type=hidden name=wf value=1>
<input type=hidden name=wf_white_list>
<input type=hidden name=wf_block_list>
<input type=hidden name=wf_exclude_list>
<input type=hidden name=white_stflg>
<input type=hidden name=block_stflg>
<input type=hidden name=exc_stflg>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.webfilter),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>	
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t5",__T(share.addrow),"to_add_white(this.form)");
		bt_list[1] = new Array("BT","t7",__T(share.edit),"to_edit_white(this.form)");
		bt_list[2] = new Array("BT","t6",__T(share.del),"to_del_white(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,70",__T(filter.whitelist),"<input type=checkbox name=white_chkall id=white_chkall onclick=white_all_chk(this.form)>,"+__T(share.stype)+","+__T(share.svalue),"",bt_list,"","white","2,2,0",__T(share.showing)+"&nbsp;<SPAN id=wdata_start> "+start_line[0]+" </SPAN> - <SPAN id=wdata_end> "+end_line[0]+" </SPAN> "+__T(share.of)+" "+count_entry[0]+"&nbsp;&nbsp;"+draw_object(O_VAR,SELBOX,"w_selcnt","onChange=select_count(this.form.w_selcnt.selectedIndex,this.form,0)",per_page,per_page)+"&nbsp;&nbsp;"+__T(share.perpage),create_pagesel("w",0));
		choose_disable(document.getElementById("t6"));
		choose_disable(document.getElementById("t7"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>	
		var bt_list = new Array();
		bt_list[0] = new Array("BT","t8",__T(share.addrow),"to_add_block(this.form)");
		bt_list[1] = new Array("BT","t9",__T(share.edit),"to_edit_block(this.form)");
		bt_list[2] = new Array("BT","t10",__T(share.del),"to_del_block(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,70",__T(filter.blacklist),"<input type=checkbox name=block_chkall id=block_chkall onclick=block_all_chk(this.form)>,"+__T(share.stype)+","+__T(share.svalue),"",bt_list,"","block","2,2,0",__T(share.showing)+"&nbsp;<SPAN id=bdata_start> "+start_line[1]+" </SPAN> - <SPAN id=bdata_end> "+end_line[1]+" </SPAN> "+__T(share.of)+" "+count_entry[1]+"&nbsp;&nbsp;"+draw_object(O_VAR,SELBOX,"b_selcnt","onChange=select_count(this.form.b_selcnt.selectedIndex,this.form,1)",per_page,per_page)+"&nbsp;&nbsp;"+__T(share.perpage),create_pagesel("b",1));
		choose_disable(document.getElementById("t9"));
		choose_disable(document.getElementById("t10"));
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>	
		<script>		
		var bt_list = new Array();
		bt_list[0] = new Array("BT","a2",__T(share.addrow),"to_add(this.form)");
		bt_list[1] = new Array("BT","a3",__T(share.edit),"to_edit(this.form)");
		bt_list[2] = new Array("BT","a4",__T(share.del),"to_del(this.form)");
		draw_td(O_GUI,CREATE_EDIT_TABLE,"5,20,70",__T(filter.exclist),"<input type=checkbox name=exc_chkall id=exc_chkall onclick=exc_all_chk(this.form)>,"+__T(share.stype)+","+__T(share.svalue),"",bt_list,"","exc","2,2,0",__T(share.showing)+"&nbsp;<SPAN id=edata_start> "+start_line[2]+" </SPAN> - <SPAN id=edata_end> "+end_line[2]+" </SPAN> "+__T(share.of)+" "+count_entry[2]+"&nbsp;&nbsp;"+draw_object(O_VAR,SELBOX,"e_selcnt","onChange=select_count(this.form.e_selcnt.selectedIndex,this.form,2)",per_page,per_page)+"&nbsp;&nbsp;"+__T(share.perpage),create_pagesel("e",2));
		choose_disable(document.getElementById("a3"));
		choose_disable(document.getElementById("a4"));
		</script>
		</TD></TR>
        </TABLE>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
