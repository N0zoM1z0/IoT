// Tree Menu List
<% get_web_position(); %>

var close_session = '<% get_session_status(); %>';

var disableKey = function(e){
	if( !e ) var e = window.event;
	var keycode = e.keyCode;
	if( e.which ) keycode = e.which;
	var src = e.srcElement;
	if ( e.target ) src = e.target;
	if ( 116 == keycode || 13 == keycode ) 
	{
		if ( e.preventDefault ) 
		{
			e.preventDefault();
			e.returnValue = false;
		}else if( e.keyCode ){
			e.keyCode = 0;
			e.returnValue = false;
			e.cancelBubble = true;
		}
		return false;
	} 
}

function __T(obj)
{
	return obj;
}

function __TC(obj)
{
	if ( now_lang == "FR" ) 
		return obj+" :";
	else
		return obj+":";
}

function get_url_key(flg)
{
        var NOWPATH;
	var pos=0;
	var tmp="";
	if ( typeof flg != "undefined" && flg == 1 ) 
	{
		if ( Browser == "Firefox" ) 
		{
			NOWPATH = document.location.href;
			if ( NOWPATH.indexOf(";") != -1 ) 
				tmp = NOWPATH.substring(NOWPATH.lastIndexOf(";"), NOWPATH.length);
		}
		else
		{
        		NOWPATH = document.location.pathname.substring(1,document.location.pathname.length);
			pos = NOWPATH.indexOf(";");
			if ( pos != -1 ) 
				tmp = NOWPATH.substring(pos,document.location.pathname.length);
		}
 	// For apply or gozila cgi used
 		if ( tmp.indexOf(";") != -1 ) 
		{
 			if ( document.forms[0].session_key ) 
 				document.forms[0].session_key.value = tmp.substring(tmp.indexOf("=")+1,tmp.length);
		}
 		return tmp;
 	}
 	else
 	{
 		return parent.document.getElementById("session_key").value;
 	}
}

function get_position(page,flg)
{
	var getflg=0;
	var itemcnt=0;
	if ( typeof flg == "undefined" ) flg = 0;
	for(var i=0; i<Menu.length; i++)
	{
		itemcnt=0;
		for(var j=0; j<Menu[i].length; j++)
		{
                        if ( (j!=0 && Menu[i][j-1][1] != Menu[i][j][1]) ) itemcnt++;
			if ( page == Menu[i][j][3] )
			{
				if ( Menu[i][j][2] !="" && 
                                     (typeof Menu[i][j+1][1] != 'undefined' && Menu[i][j+1][1] == Menu[i][j][1]) || 
				     ( j!=0 &&
				     (typeof Menu[i][j-1][1] != 'undefined' && Menu[i][j-1][1] == Menu[i][j][1])) )
				{
                                    if((j!=0 && (typeof Menu[i][j-1][1] != 'undefined' && Menu[i][j-1][1] != Menu[i][j][1])) || 
				       (j<Menu[i].length-1 && typeof Menu[i][j+1][1] != 'undefined' &&
					Menu[i][j+1][1] != Menu[i][j][1]) || j == Menu[i].length-1 )
					itemcnt++;
                			parent.document.getElementById("fun").contentWindow.SEL_THRMENU(i,j,itemcnt,flg);	
				}else{
                			parent.document.getElementById("fun").contentWindow.SEL_SUBMENU(i,j,flg);
					getflg = 1;
				}
			}
		}
		if ( getflg == 1 ) break;
	}
}

function get_now_url()
{
        var NOWPATH = document.location.pathname.substring(1,document.location.pathname.length);
        if ( close_session != "1" )
        {
                if ( Browser == "Firefox" )
                        NOWPATH = document.location.pathname.substring(1,document.location.pathname.length);
                else
                        NOWPATH = document.location.pathname.substring(1,document.location.pathname.indexOf(";"));
        }
        return NOWPATH;
         
}

function goto_page(page,flg)
{
	var url,tmpurl;
	var NOWPATH;
	NOWPATH = get_now_url();

	if ( page != "#" ) parent.document.getElementById("newpage").value = page;
	if ( page != "Wireless_WPS.asp" ) 
	{
		if ( parent.document.getElementById("rightframe") ) 
			parent.document.getElementById("rightframe").contentWindow.before_leave();
		if ( parent.document.getElementById("GUI_FUN").value == 0 ) return;
		if ( parent.document.getElementById("GUI_FUN").value == 1 )
			parent.document.getElementById("GUI_FUN").value = 0;
	}
	tmpurl = goto_link(page,flg);
	if ( NOWPATH.substring(0,4) == "https" && url.indexOf("https") == -1 ) 
		url = "<% get_http_prefix(""); %>" + tmpurl;
	else
		url = tmpurl;
	if ( parent.document.getElementById("GUI_LOCK").value == 0 )  
	{
		//alert("goto_page(), enter GUI LOCK = 0");
		//alert(parent.document.getElementById("rightframe").src);
		if ( parent.document.getElementById("rightframe") != 'undefined' )
	            	parent.document.getElementById("rightframe").src = url;
	}
}

function goto_link(page,gui_st)
{
	var url = "";
	var pos=0;
	var is_wps=0;
	var tmp_page;
	var session_key="";
	//alert("close_session="+close_session);
	if ( close_session != "1" ) 
	{
		if ( parent.document.getElementById("session_key") )
		{
			if ( session_key == "" ) session_key = get_url_key(); 
		}else{
			if ( session_key == "" ) session_key = get_url_key(1); 
		}
//		alert("session_key="+session_key);
		if ( session_key.indexOf("session_id") != -1 )
			url = page + session_key;
		else
			url = page + ";session_id="+ session_key;
	}
	if ( url == "" ) url = page ;
//	alert("url="+url);
	return url;

}

