<html>
<head>
<title>Available LAN Host</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var idx=0;
var name_order=0,ip_order=0,mac_order=0,type_order=0,iface_order=0;
var nv_wan_real_ifname6 = "<% nvram_get("wan_real_ifname6"); %>";
var datalist = new Array();
<% get_lan_host_data(); %>

var associate_data = new Array();
<% get_wl_assoicate_data(); %>

var ndplist = new Array();
<% get_ipv6_ndp_table(); %>

var type_val = new Array(__T(lan.dynamic),__T(lan.sstatic)); 
var dhcp_val = new Array(__T(filter.no),__T(filter.yes));
function AAA(name,ip,mac,type,is_static,dev,ssid_name)
{
        this.name = name;
        this.ip = ip;
        this.mac = mac;
        this.type = type;
	this.is_static = is_static;
        this.dev = dev;
				this.ssid = ssid_name;
}

function ByName(a,b)
{
	if ( name_order == 0 ){ 
		name_order=1;
	        if( a.name > b.name ) return 1;//|| a.name < b.name ) return 1;
        	else if (a.name == b.name ) return 0;
	        else return -1;
	}else{
		name_order=0;
	        if( a.name < b.name ) return 1;//|| a.name < b.name ) return 1;
        	else if (a.name == b.name ) return 0;
	        else return -1;
	}
}

function ByMac(a,b)
{
	if ( mac_order == 0 ) 
	{
		mac_order=1;
        	if( a.mac > b.mac ) return 1;// ||  a.mac < b.mac ) return 1;
	        else if (a.mac == b.mac ) return 0;
        	else return -1;
	}else{
		mac_order=0;
        	if( a.mac < b.mac ) return 1;// ||  a.mac < b.mac ) return 1;
	        else if (a.mac == b.mac ) return 0;
        	else return -1;
	}
}
function ByIp(a,b)
{
	if ( ip_order == 0 ) 
	{
		ip_order=1;
	        if ( a.ip > b.ip ) return 1;
        	else if( a.ip == b.ip ) return 0 ;
	        else return -1;
	}else{
		ip_order=0;
	        if ( a.ip < b.ip ) return 1;
        	else if( a.ip == b.ip ) return 0 ;
	        else return -1;
		ip_order=0;
	}
}

function ByType(a,b)
{
	if ( type_order == 0 ) 
	{
		type_order=1;
	        if( a.type > b.type ) return 1;//|| a.type < b.type ) return 1;
        	else if (a.type == b.type ) return 0;
	        else return -1;
	}else{
		type_order=0;
	        if( a.type < b.type ) return 1;//|| a.type < b.type ) return 1;
        	else if (a.type == b.type ) return 0;
	        else return -1;
	}
}

function ByDev(a,b)
{
	if ( iface_order == 0 ) 
	{
		iface_order=1;
	        if( a.dev > b.dev ) return 1;//|| a.dev < b.dev ) return 1;
        	else if (a.dev == b.dev ) return 0;
	        else return -1;
	}else{
		iface_order=0;
	        if( a.dev > b.dev ) return 1;//|| a.dev < b.dev ) return 1;
        	else if (a.dev == b.dev ) return 0;
	        else return -1;
	}
}

function seltype(F)
{
	to_del();
	if ( F.sel_type.value == "all" )
	{
		for(var i=0; i<datalist.length; i++)
			to_add(datalist[i])
	}else if ( F.sel_type.value == "wireless" ){
		for(var i=0; i<datalist.length; i++)
		{
			if ( datalist[i].dev == "Wireless" ) 
				to_add(datalist[i])
		}
	}else if ( F.sel_type.value == "wds" ){
		for(var i=0; i<datalist.length; i++)
		{
			if ( datalist[i].dev == "WDS" ) 
				to_add(datalist[i])
		}
	}else if ( F.sel_type.value == "wired" ){
		for(var i=0; i<datalist.length; i++)
		{
			if ( datalist[i].dev == "Ethernet LAN" || datalist[i].dev == "WAN interface" ) 
				to_add(datalist[i])
		}
	}
	if( idx == 0 ) document.getElementById("_nodata").style.display="";
}

function Sortby(type,index)
{
	var tmp_type="";
	if ( idx == 0 ) return;
	if ( document.getElementById("img"+index).className == "SORT_SEL_IMG" ) 
		document.getElementById("img"+index).className = "SORT_IMG";
	else
		document.getElementById("img"+index).className = "SORT_SEL_IMG";
	
	datalist.sort(type);
	to_del();
	for(var i=0; i<datalist.length; i++)
		to_add(datalist[i])
}

function to_del(){
	var tbody = document.getElementById("_table").getElementsByTagName("TBODY")[0];
	for(var i=0; i<idx; i++)
	{
		if (document.getElementById("tr_table"+i) != 'undefined')
			tbody.removeChild(document.getElementById("tr_table"+i));
	}
	idx=0;
}


function to_add(list)
{
	document.getElementById("_nodata").style.display="none";
	var tbody = document.getElementById("_table").getElementsByTagName("TBODY")[0];
	var row = document.createElement("tr");
        row.setAttribute("id","tr_table"+idx);
	if (idx%2 == 0){
                row.setAttribute("class", "TABLECONTENT_S");
                row.setAttribute("className", "TABLECONTENT_S");
        }else{
                row.setAttribute("class", "TABLECONTENT_D");
                row.setAttribute("className", "TABLECONTENT_D");
        }
	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_name"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = list.name;
        row.appendChild(tdArray);

	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_ip"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = list.ip;
        row.appendChild(tdArray);

	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_mac"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = list.mac;
        row.appendChild(tdArray);
	
	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_type"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD_MID");
        tdArray.setAttribute("className","TABLECONTENT_TD_MID");
        tdArray.innerHTML = type_val[list.type];
        row.appendChild(tdArray);
	
	tdArray = document.createElement("td");
        tdArray.setAttribute("id","is_static"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD_MID");
        tdArray.setAttribute("className","TABLECONTENT_TD_MID");
        tdArray.innerHTML = dhcp_val[list.is_static];
        row.appendChild(tdArray);


	tdArray = document.createElement("td");
        tdArray.setAttribute("id","td_dev"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD_MID");
        tdArray.setAttribute("className","TABLECONTENT_TD_MID");
	var tmpstr="";
	if ( list.dev == "Wireless" ) tmpstr = __T(wl.wl); 
	else if ( list.dev == "Ethernet LAN" || list.dev == "WAN interface" ) tmpstr = __T(lan.wired);
	else tmpstr = list.dev;
        tdArray.innerHTML = tmpstr;
        row.appendChild(tdArray);

	tdArray = document.createElement("td");
tdArray.setAttribute("id","td_ssid"+idx);
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
//        tdArray.innerHTML = "&nbsp;";
tdArray.innerHTML = list.ssid;
        row.appendChild(tdArray);

	tdArray = document.createElement("td");
        tdArray.setAttribute("class","TABLECONTENT_TD");
        tdArray.setAttribute("className","TABLECONTENT_TD");
        tdArray.innerHTML = "&nbsp;";
        row.appendChild(tdArray);

        tbody.appendChild(row);
        idx++;
}

var nv_lan_ip_mode = "<% nvram_get("lan_ip_mode"); %>";
var nv_wan_ip_mode = "<% nvram_get("wan_ip_mode"); %>";

function init(){
	if ( nv_lan_ip_mode == "1" && nv_wan_ip_mode == "1" ) 
		document.getElementById("ipv6ndp").style.display="none";
	if ( nv_lan_ip_mode == "2" && nv_wan_ip_mode == "2" ) 
		document.getElementById("ipv4ndp").style.display="none";
//		document.getElementById("ipv4ndp").style.display="";
	for(var i=0; i<datalist.length; i++)
		to_add(datalist[i])
}

</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<script>
</script>
<div class=content_layer id=divcontent>
<TABLE class=CONTENT_TABLE>

  <TR><script>draw_td(O_GUI,MAINFUN, __T(lan.connectdev));</script></TR>

  <TR>
    <TD colspan=2 id=ipv4ndp>
    <script>
	    var filter_str = "";
	    if ( current_model_name == "RV130W" ) 
	    {
	  	  var _name = new Array(__T(share.all),__T(wl.wl),__T(lan.wired),__T(wl.wds));
	  	  var _val = new Array("all","wireless","wired","wds");
	  	  var filter_str=spell_words(filter_rule,__T(lan.ifacetype))+draw_object(O_VAR,SELBOX,"sel_type","onChange=seltype(this.form)",_name,_val);
	    }
	  	draw_td(O_GUI,CREATE_EDIT_TABLE,"20,15,15,10,15,10,10",__T(lan.ipv4arptb),__T(share.name)+","+__T(share.ipaddr)+","+__T(share.macaddr)+","+__T(share.stype)+","+__T(lan.staticdhcp)+","+__T(share.iface)+","+__T(wl.ssid),"","",filter_str,"","0,0,0,2,2,2,0,0");
    </script>
    </TD>
  </TR>

  <TR>
    <TD colspan=2 id=ipv6ndp>
      <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
        <col width=200px><col width=200px>
          <TR><TD colspan=4 class=TABLETITLE><script>Capture(lan.ipv6ndptb);</script></TD></TR>
          <script>
	          document.write("<TR height=20px>");
            draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(share.ipaddr));
            draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.macaddr));
            draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(share.iface));
            draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
            document.write("</TR>");

		        var f_cnt=0;
       			var tstyle = "TABLECONTENT_S";
       			if ( ndplist.length == 0 )
       			{
              document.write("<tr class="+tstyle+" id='d"+i+"'>");
              document.write("<TD class='TABLECONTENT_TD' colspan=3>"+__T(msg.nodata)+"</TD>");
       			}

            for(var i=0; i<ndplist.length; i++)
            {
              if( f_cnt%2 ==0 )
                tstyle = "TABLECONTENT_S";
              else
                tstyle = "TABLECONTENT_D";
              document.write("<tr class="+tstyle+" id='d"+i+"'>");
              document.write("<TD class='TABLECONTENT_TD'>"+full_ipv6(ndplist[i][0])+"</TD>");
              document.write("<TD class='TABLECONTENT_TD'>"+ndplist[i][1]+"</TD>");
              document.write("<TD class='TABLECONTENT_TD'>");

/*
              if ( ndplist[i][2] == "br0")
                document.write(__T(lan.vlan)+"1");
              else if ( ndplist[i][2] == "vlan2")
                document.write(__T(wan.wan));
              else
                document.write(str_replace("br",__T(lan.vlan),ndplist[i][2]));
*/
              if ( ndplist[i][2] == nv_wan_real_ifname6)
                document.write(__T(wan.wan));
							else
                document.write(__T(lan.lan));

              document.write("</TD>");
              document.write("<TD class='TABLECONTENT_TD'>&nbsp;</TD>");
              document.write("</tr>");
            }
            // For firefox layout
            chg_layout("divcontent","content_layer_f","content_layer");
          </script>
      </TABLE>
    </TD>
  </TR>

<!--AP mode connected-->
<TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>

  <TR><TD colspan=4 id=assoicatedp>
  <TABLE class=CONTENT_GROUP cellspacing=0 width=100%>
  <col width=200px><col width=200px>
  <TR><TD colspan=4 class=TABLETITLE><script>Capture(lan.wlassoicatetb);</script></TD></TR>

  <script>
	  document.write("<TR height=20px>");
    draw_td(O_GUI,TABLETD_SINGLE_LINE_FIRST,__T(share.macaddr));
    draw_td(O_GUI,TABLETD_SINGLE_LINE,__T(wl.ssid));
    draw_td(O_GUI,TABLETD_TAIL,"","&nbsp;");
    document.write("</TR>");

    var s_cnt=0;
    var sstyle = "TABLECONTENT_S";
    if ( associate_data.length == 0 )
    {
      document.write("<tr class="+sstyle+" id='d"+i+"'>");
      document.write("<TD class='TABLECONTENT_TD' colspan=3>"+__T(msg.nodata)+"</TD>");
    }

    for(var i=0; i<associate_data.length; i++)
    {
      if( s_cnt%2 ==0 )
        sstyle = "TABLECONTENT_S";
      else
        sstyle = "TABLECONTENT_D";
      document.write("<tr class="+sstyle+" id='d"+i+"'>");
      document.write("<TD class='TABLECONTENT_TD'>"+associate_data[i][0]+"</TD>");
      document.write("<TD class='TABLECONTENT_TD'>"+associate_data[i][1]+"</TD>");
      document.write("<TD class='TABLECONTENT_TD'>&nbsp;</TD>");
      document.write("</tr>");
    }
    // For firefox layout
    chg_layout("divcontent","content_layer_f","content_layer");
  </script>
  </TABLE>
  </TD>
  </TR>
  <!--TR><TD colspan=2 align=right><Script>Capture(msg.tbsortable);</script></TD></TR-->

</div>
</form>
</div></TABLE></TD></TR>
</body></HTML>
