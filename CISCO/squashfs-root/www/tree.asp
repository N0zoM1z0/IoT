<HTML>
<LINK href="style.css" type=text/css rel=stylesheet>
<% no_cache(); %>
<% js_link(0); %>
<!--[if lt IE 7.]>
<script defer type="text/javascript" src="/pngfix.js"></script>
<![endif]-->
<script type="text/javascript" src="/position.js"></script>
<script type="text/javascript" src="/common.js"></script>
<LINK href="imgfix.css" type=text/css rel=stylesheet>
<script>
var http_power='<% nvram_get("http_power"); %>';
var i,j,k;
var submenu="",level3_cnt=0,level3_start=0,tmp_cnt=0;
var L1="topmenu";
var L1_IMG="topimg";
var L2_IMG="subimg";
var L2_LINK="sublink";
var L3_LINK="thrlink";
//var L2="l2menu_";
var L2="l2tr_"; // l2tr_0
var L3="l3tr_"; // l3_tr_0_0_0
var TOPMENU_IMG_URL='image/drawerTriangleCollapsedT.gif'; 
var TOPMENU_IMG_SEL_URL='image/drawerTriangleOpen_Selected.png';
var SECMENU_IMG_URL='image/drawerTriangleCollapsedT.gif';
var SECMENU_IMG_SEL_URL='image/drawerTriangleOpenT.gif';
var TOPMENU_BT_NORMAL='TOPMENU';
var TOPMENU_BT_HOVER='TOPMENU_HOVER';
var TOPMENU_BT_SEL='TOPMENU_SEL';
var SECMENU_NORMAL='L2_MENU';
var SECMENU_NORMAL_TOP='L2_MENU_TOP';
var THRMENU_NORMAL='L3_MENU';
var SECMENU_SEL='L2_MENU_SEL';
var SECLINK_SEL='FUN_LINK_SEL';
var SECLINK_NORMAL='fun';
var _TOP_SEL_IDX="";
var _SUB_SEL_IDX="";
var _TOP_SEL_ST="none";
var _SUB_SEL_ST="none";
var model_name = "<% nvram_get("model_name"); %>"
var SKU="<% nvram_get("sysinfo_pid"); %>";
var WL_mode = 1;
if ( model_name == "RV130" ) WL_mode = 0; 
function MENU_CHG(obj,type)
{
	var style = document.getElementById(L1+obj).className;
	if ( style == TOPMENU_BT_SEL ) return;
	document.getElementById(L1+obj).className = type;
}

var RECOVERY = 0;
var TOPSEL = 1;
var SUBSEL = 2;
var THESEL = 3;
var Browser = CheckBrowser();
function CheckBrowser(){
        var cb = "UnKnow";
        if ( window.ActiveXObject )
                cb = "IE" ; 
        else if ( navigator.userAgent.toLowerCase().indexOf("firefox") != -1 )
                cb = "Firefox";
        else if ( (typeof document.implementation != "undefined") && (typeof document.implementation.createDocument != "undefined") && (typeof HTMLDocument != "undefined" ))
                cb = "Mozila";
        else if ( navigator.userAgent.toLowerCase().indexOf("opera") != -1 ) 
                cb = "Opera";
        else if ( navigator.userAgent.toLowerCase().indexOf("safari") != -1 ) 
                cb = "Safari";
        return cb;
}

function SEL_MENU(ST,l2sel,l3sel)
{
  var showlink=false;
  for(i=0; i<Menu.length; i++)
  {
	if ( document.getElementById(L1+i) ) 
	{
	    	if ( ST == RECOVERY ) 
			document.getElementById(L1+i).className = TOPMENU_BT_NORMAL;
		else 
    		{
			if ( i == l2sel ) 
				document.getElementById(L1+i).className = TOPMENU_BT_SEL;
		}
	}else
		continue;

    	if ( Menu[i].length > 1 ) 
    	{
		if ( ST == RECOVERY )
		{ 
			document.getElementById(L2+i).style.display="none";
			document.getElementById(L1_IMG+i).src = TOPMENU_IMG_URL;
		}
		else if ( ST != RECOVERY ) 
		{
			if ( i == l2sel ) 
			{
				document.getElementById(L1_IMG+i).src = TOPMENU_IMG_SEL_URL;
				document.getElementById(L2+i).style.display="";
			}
		}
		submenu="",level3_cnt=0,level3_start=0,tmp_cnt=0;
		var tmp_j=0;
		for(j=0; j<Menu[i].length; j++)
		{
		  if ( ST == RECOVERY )
			LINK_CHG(0,L2_LINK+i+"_"+j);
		  if ( (j == Menu[i].length-1) || (submenu != Menu[i][j][1]) )
          	  {
	            	if ( level3_cnt > 0 )
		        {
	      			tmp_cnt=0;
		 	        if ( level3_start!=0 ) tmp_cnt = level3_start+level3_cnt;
		   	        else tmp_cnt = level3_cnt;
	  		        if ((level3_start!=0) && (j == Menu[i].length-1)) tmp_cnt++;
		                for(k=level3_start; k<=tmp_cnt; k++)
		  	        {
				        if ( ST == RECOVERY )
					{
					  LINK_CHG(0,L3_LINK+i+"_"+tmp_j+"_"+k);
					  if ( document.getElementById(L2_IMG+i+"_"+tmp_j) ) 
						  document.getElementById(L2_IMG+i+"_"+tmp_j).src = SECMENU_IMG_URL;
					  if ( document.getElementById(L3+i+"_"+tmp_j+"_"+k) != null ) 
					  	document.getElementById(L3+i+"_"+tmp_j+"_"+k).style.display="none";
					}else if ( ST == SUBSEL || ST == THESEL ) 
					{
						if ( Menu[l2sel][l3sel][1] == Menu[i][tmp_j][1] )
						  	document.getElementById(L2_IMG+i+"_"+tmp_j).src = SECMENU_IMG_SEL_URL;
						if ( document.getElementById(L3+l2sel+"_"+l3sel+"_"+k) != null )
							document.getElementById(L3+l2sel+"_"+l3sel+"_"+k).style.display="";
					}
					if ( ST == SUBSEL ) 
					{
						if ( showlink == false  ) 
						{
						 	LINK_CHG(1,L3_LINK+l2sel+"_"+l3sel+"_"+l3sel);
							showlink = true;
						}
					}
				}
              			level3_cnt=0;
	    	  	}
          	  }
	  	  if ( submenu != Menu[i][j][1] ) 
		  {
			tmp_j = j ; 
	    		level3_start=j;
	          }
		  else if ( submenu != "" && submenu == Menu[i][j][1] ) 
	   		level3_cnt++;
		  submenu = Menu[i][j][1];
            }
            submenu = Menu[i][0][0];
	}
    }
}

function SEL_TOPMENU(obj_idx,flg)
{
	SEL_MENU(RECOVERY,0,0);
	if ( _TOP_SEL_ST == "none" || _TOP_SEL_ST == "open" || _TOP_SEL_IDX != obj_idx)
	{
		//top.window.document.title=Menu[obj_idx][0][1];
		if ( current_model_name == "RV130W" ) 	
			top.window.document.title=__T(router.appname);
		else
			top.window.document.title=__T(router.rv130_appname);
		//SEL_MENU(RECOVERY,0,0);
		SEL_MENU(TOPSEL,obj_idx,0);
		if ( Menu[obj_idx][0][3]!='#' && flg == 0)
		{
		    	if ( http_power == "rw" || Menu[obj_idx][0][PAGE_POWER] == 0 )
			{
			        parent.document.getElementById("now_help").value = Menu[obj_idx][0][PAGE_HELP];	
   		    	        parent.document.getElementById("now_page").value = Menu[obj_idx][0][PAGE_NAME];	
				if ( ap_mode == "0" ) 
	   		    	        parent.document.getElementById("now_ipmode").value = Menu[obj_idx][0][PAGE_IPMODE];	
				goto_page(Menu[obj_idx][0][PAGE_NAME]);
			}
		}
		LINK_CHG(1,L2_LINK+obj_idx+"_0");
	}
	if ( _TOP_SEL_IDX != obj_idx )  _TOP_SEL_ST = "close";
	else if ( _TOP_SEL_ST == "close" ) _TOP_SEL_ST = "open";
	else _TOP_SEL_ST = "close";
	_TOP_SEL_IDX=obj_idx;
}
function LINK_CHG(SEL,tmp_obj)
{
        var obj = document.getElementById(tmp_obj);
	if ( obj != null ) 
	{
		if ( SEL ) 
			obj.className = SECLINK_SEL;
		else
			obj.className = "";
	}
}
function SEL_SUBMENU(idx1,idx2,flg)
{
	//alert("idx1="+idx1+" ;idx2="+idx2+" ;flg="+flg);
	SEL_MENU(RECOVERY,0,0);
	var idx_arr = _SUB_SEL_IDX.split(",");
	if ( _SUB_SEL_ST == "none" || _SUB_SEL_ST == "open" || (idx_arr[0] != idx1) || (idx_arr[1]!=idx2) ) 
	{
		SEL_MENU(SUBSEL,idx1,idx2);
		if ( Menu[idx1][idx2][2] != '' )
	            document.getElementById(L2_IMG+idx1+"_"+idx2).src = SECMENU_IMG_SEL_URL;
		else
		    LINK_CHG(1,L2_LINK+idx1+"_"+idx2);
		if ( current_model_name == "RV130W" ) 	
			top.window.document.title=__T(router.appname);
		else
			top.window.document.title=__T(router.rv130_appname);
		//top.window.document.title=__T(router.appname);
		//top.window.document.title=Menu[idx1][idx2][1];
			
        	if ( Menu[idx1][idx2][3] != "#" && flg == 0 )
		{
		    if ( http_power == "rw" || Menu[idx1][idx2][PAGE_POWER] == 0 )
		    {
			    parent.document.getElementById("now_help").value = Menu[idx1][idx2][PAGE_HELP];	
		    	    parent.document.getElementById("now_page").value = Menu[idx1][idx2][PAGE_NAME];	
			    if ( ap_mode == "0" ) 
			    	parent.document.getElementById("now_ipmode").value = Menu[idx1][idx2][PAGE_IPMODE];	
		            goto_page(Menu[idx1][idx2][PAGE_NAME]);
		    }
		}
	}else
		SEL_MENU(TOPSEL,idx1,flg);
	_SUB_SEL_IDX = idx1+","+idx2;
	if ( (idx_arr[0] != idx1) || (idx_arr[1]!=idx2) ) _SUB_SEL_ST = "close";
	else if ( _SUB_SEL_ST == "close" ) _SUB_SEL_ST = "open";
	else _SUB_SEL_ST = "close";
	
}

function SEL_THRMENU(idx1,idx2,idx3,flg){
	//alert("idx1="+idx1+" ;idx2="+idx2+" ;idx3="+idx3+" ;flg="+flg);
	SEL_MENU(RECOVERY,0,0);
	SEL_MENU(THESEL,idx1,idx3);
	if ( current_model_name == "RV130W" ) 	
		top.window.document.title=__T(router.appname);
	else
		top.window.document.title=__T(router.rv130_appname);
		
	//top.window.document.title=__T(router.appname);
	//top.window.document.title=Menu[idx1][idx2][2];
        if ( Menu[idx1][idx2][3] != "#" && flg == 0)
	{
	    if ( http_power == "rw" || Menu[idx1][idx2][PAGE_POWER] == 0 )
	    {
		parent.document.getElementById("now_help").value = Menu[idx1][idx2][PAGE_HELP];	
		parent.document.getElementById("now_page").value = Menu[idx1][idx2][PAGE_NAME];	
		if ( ap_mode != "1" ) 
   			parent.document.getElementById("now_ipmode").value = Menu[idx1][idx2][PAGE_IPMODE];	
            	goto_page(Menu[idx1][idx2][PAGE_NAME]);
	    }
	}
	LINK_CHG(1,L3_LINK+idx1+"_"+idx3+"_"+idx2);
	LINK_CHG(0,L2_LINK+idx1+"_"+idx3);
}


function init()
{
	var is_up = "<% nvram_get("getting_start"); %>";
	var aging_time = "<% nvram_match("aging_time_true","1","1"); %>";
	if ( http_power == "rw" && aging_time == "1" )//&& (get_url_filename(1) == 1))
		get_position("change_password_tree.asp");
	if ( parent.document.getElementById("gui_changed_page") != null )
	{
		get_position(parent.document.getElementById("gui_changed_page").value,1);
		parent.document.getElementById("gui_changed_page").value = "";
	}
	else if( parent.document.getElementById("close_ipv6").value != "" ){
		//focus on IP Mode
		SEL_SUBMENU(2,11,1);
	}
	else 
	{
		if ( is_up == "1" ) 
			SEL_TOPMENU(0,1);
		else
			SEL_TOPMENU(1,1);
	}
}

document.onkeydown=disableKey;

</script>
<BODY onload=init()>
<FORM name=frmtree id=frm >
<script>
		/* tree */
		document.write("<table cellspacing=0 width=100% style='position:relative'>");
		var img="", row_style="";
		submenu="",level3_cnt=0,level3_start=0,tmp_cnt=0;
		var j_idx=0;
		var l3cnt=0;
		for(i=0; i<Menu.length; i++)
		{
			row_style = TOPMENU_BT_NORMAL;
			var overstyle = "TOPMENU_HOVER";
			var outstyle = "TOPMENU";
			if ( Browser == "IE" && navigator.appVersion.indexOf("MSIE 8.0") != -1 ) 
			{
				overstyle = "TOPMENU_HOVER_IE8";
				outstyle = "TOPMENU_IE8";
				row_style = outstyle;
			}
			if ( Menu[i][0][0] == __T(wl.wl) && WL_mode == 0 ) continue;
			if ( SKU != "RV130-WB-K9-NA" && 
			     SKU != "RV130-WB-K9-G5" && 
				 SKU != "RV130W-WB-A-K9-NA" && 
				 SKU != "RV130W-WB-E-K9-G5" ) 
			{
				if ( Menu[i][0][0] == __T(filter.webfilter) ) continue;
					
			}
			document.write("<TR class="+row_style+" id=topmenu"+i+" onMouseover='MENU_CHG(\""+i+"\",\""+overstyle+"\")' onMouseout='MENU_CHG(\""+i+"\",\""+outstyle+"\")' onMousedown='SEL_TOPMENU(\""+i+"\",0)'><TD>");
			if ( Menu[i].length > 1 ) 
				document.write("<img src='"+TOPMENU_IMG_URL+"' class=TOPMENU_IMG id=topimg"+i+"><span style='padding-left:3px'>");
			else
				document.write("<span style='padding-left:15px'>");
			document.write(Menu[i][0][0]+"</SPNA></TD></TR>");
			if ( (Menu[i][0][1] != '') && (submenu != Menu[i][0][0]) )
			{
				document.write("<TR><TD><TABLE border=0 cellspacing=0 width=100% id='l2tr_"+i+"' style=display:none>");
			}
                        level3_start=0;
			level3_cnt=0;
			var tmp_j=0;
			for(j=0; j<Menu[i].length; j++)
			{
				//Create Level 3
				if ( (j == Menu[i].length-1) || (submenu != Menu[i][j][1])  )
                                {
                                        if ( level3_cnt > 0 )
                                        {
						tmp_cnt=0;
						if ( level3_start!=0 ) tmp_cnt = level3_start+level3_cnt;
						else tmp_cnt = level3_cnt;
						if ((level3_start!=0) && (j == Menu[i].length-1)) tmp_cnt++;
                                                for(k=level3_start; k<=tmp_cnt; k++)
						{
							row_style=THRMENU_NORMAL;
							//alert(Menu[i][k][2]+";create id=l3tr_"+i+"_"+level3_start+"_"+k);
							//if ( i == 8 ) 
							//alert("l3tr_"+i+"_"+tmp_j+"_"+k);
							var link_name = Menu[i][k][2];

							if ( Menu[i][k][3] == "#" ) link_name +="(TBD)";
                                                       	document.write("<TR style='display:none' id='"+L3+i+"_"+tmp_j+"_"+k+"' class="+row_style+"><TD><a class="+SECLINK_NORMAL+" href=# onclick=SEL_THRMENU('"+i+"','"+k+"','"+tmp_j+"',0)><span id="+L3_LINK+i+"_"+tmp_j+"_"+k+">"+link_name+"</a></TD></TR>");
                                        	}
                                        	//level3_start=j;
	                                        level3_cnt=0;
					}
                                }
				// Create Level 2
				if ( Menu[i][j][1]!="" && submenu != Menu[i][j][1] ) 
				{
					//var ipsec_support="1";
					//ipsec_support = "<% support_invmatch("IPSEC_SUPPORT","1","0"); %>";
					/*
					if ( SKU == "RV130-WB-K9-NA" || SKU == "RV130-WB-K9-G5" || SKU == "RV130W-WB-A-K9-NA" || SKU == "RV130W-WB-E-K9-G5" ) 
					{
						if ( Menu[i][j][1] == __T(filter.IAP) || Menu[i][j][1] == __T(filter.accessrules) ) continue;
					}*/
					if ( ( "<% nvram_get("lan_ip_mode"); %>" == "1" ) &&  
					     ( "<% nvram_get("wan_ip_mode"); %>" == "1" ) &&
                                             ( Menu[i][j][1] == __T(ipv6.ipv6) ) )
						continue;
					if (  WL_mode == 0 )
					{
						if ( Menu[i][j][PAGE_NAME] == "status_wireless.asp" ||
						     Menu[i][j][PAGE_NAME] == "status_captive.asp" ) continue;
					}
					//if ( ipsec_support == "0" && Menu[i][j][3] == "vpn_adv.asp" ) continue;
					row_style = SECMENU_NORMAL;
					if ( j == 0 ) row_style = SECMENU_NORMAL_TOP;
					document.write('<TR class='+row_style+'><TD>');
					if ( Menu[i][j][2] != '' )  
						document.write("<img id=subimg"+i+"_"+j+" src='"+SECMENU_IMG_URL+"' class=L2_IMG onclick=SEL_SUBMENU('"+i+"','"+j+"',0)><span style='padding-left:3px'>");
					else
					{
						document.write("<span style='padding-left:12px'></span>");
					}
					var link_name2 = Menu[i][j][1];
					if ( Menu[i][j][3] == "#" && Menu[i][j][2] == "" ) link_name2 += "(TBD)";
					document.write("<a href=# class=fun onclick=SEL_SUBMENU('"+i+"','"+j+"',0)><span id="+L2_LINK+i+"_"+j+">"+link_name2+"</span></a></TD></TR>");
					tmp_j = j ; 
                                        level3_start=j;
				}
				else if ( submenu != "" && submenu == Menu[i][j][1] ) 
					level3_cnt++;
				submenu = Menu[i][j][1];
			}
			if ( (Menu[i][0][1] != '') && (submenu != Menu[i][0][0]) )
				document.write("</TABLE>");
			submenu = Menu[i][0][0];
		}
		document.write("</table></TD><TR>");

</script>
</form>
</body></HTML>
