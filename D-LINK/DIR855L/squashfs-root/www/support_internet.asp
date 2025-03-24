<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
  .style6 {
  font-size: 14px;
  font-weight: bold;
  }
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="./lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="./lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
support_vpn_header_desc = replaceAll(support_vpn_header_desc, "<-- model_number -->", "<!-- echo model_number -->");
support_vpn_server_ip = replaceAll(support_vpn_server_ip,  "<-- model_number -->", "<!-- echo model_number -->");

function show_hnat(){
	if("<!--# echo hnat_enable -->" != ""){
		get_by_id("show_hnat").style.display = "";
	}else{
		get_by_id("show_hnat").style.display = "none";
	}
}

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
      <td>&nbsp;</td>
   </tr>
  </table>
  <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
    <tr>
      <td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
    </tr>
  </table>
  <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
    <tr id="topnav_container">
      <td><img src="/short_modnum.gif" width="125" height="25"></td>
      <script>show_top("help");</script>
    </tr>
  </table>
  <table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
    <tr>
      <td id="sidenav_container" valign="top" width="125" align="right">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td id="sidenav_container">
          <div id=sidenav> 
          <!-- === BEGIN SIDENAV === -->
            <ul><script>show_left("Help", 1);</script></ul>
          <!-- === END SIDENAV === -->
          </div>
          </td>			
        </tr>
      </table>			
      </td>
      <td valign="top" id="maincontent_container">
      <div id="maincontent">
      <!-- === BEGIN MAINCONTENT === -->
        <div id="box_header"> 
        <h1><script>show_words(help201a);</script></h1>
        <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td>
             <ul>
								<script>show_support("Setup");</script>
             </ul>
            </td>
          </tr>
        </table>
      </div>
      <div class="box">
      <h2><A id=Internet name=Internet><script>show_words(sa_Internet);</script></a></h2>
      <table border=0 cellspacing=0 cellpadding=0>
        <tr>
          <td>
           <DL>
           <DT><script>show_words(wwa_setupwiz);</script> 
           <DD>
				   <P><script>show_words(bi_wiz);</script></P>
				   <DT><script>show_words(int_LWlsWz);</script> 
				   <DD>
				   <P><script>show_words(bi_man);</script></P>
				   </DD>
           </DL>
	  </td>
	</tr>
      </table>
      </div>
      <div class="box">
      <h2><A id=WAN name=WAN><script>show_words(WAN);</script></A></h2>
      <table border=0 cellspacing=0 cellpadding=0>
        <tr>
          <td>
            <P><script>show_words(help254);</script></P>
            <DL>
            <DT><script>show_words(bwn_ict);</script> 
            <DD>
            <P><script>show_words(help254_ict);</script></P>
            <DL>
            <DT><script>show_words(bwn_SWM);</script> 
            <DD><script>show_words(help255);</script> 
            <SPAN class=option><script>show_words(_ipaddr);</script></SPAN>, 
            <SPAN class=option><script>show_words(help703);</script></SPAN>, 
	    <SPAN class=option><script>show_words(_gateway);</script></SPAN>, 
	    <SPAN class=option><script>show_words(_dns1);</script></SPAN>, <script>show_words(help264);</script> 
	    <SPAN class=option><script>show_words(_dns2);</script></SPAN>. <script>show_words(help258);</script>
	    <DT><script>show_words(bwn_DWM);</script> 
	    <DD><script>show_words(help259);</script> 
	    <P><SPAN class=option><script>show_words(help260);</script>: </SPAN><script>show_words(help261);</script> </P>
	    <P><SPAN class=option><script>show_words(_use_unicasting);</script>: </SPAN><script>show_words(help261a);</script> </P>
	    <!--<P><SPAN class=option><script>show_words(help262);</script>:</SPAN> <script>show_words(help263);</script> 
	    <SPAN class=option><script>show_words(bwn_BPS);</script></SPAN>, <SPAN class=option><script>show_words(bwn_BPU);
	    </script></SPAN>, <script>show_words(help257);</script> <SPAN class=option><script>show_words(bwn_BPP);</script></SPAN>. </P>
	    -->
	    <DT><script>show_words(_PPPoE);</script> 
	    <DD><script>show_words(help265);</script> <script>show_words(bw_sap);</script> 
	    <P><SPAN class=option><script>show_words(carriertype_ct_0);</script>: </SPAN><script>show_words(help265_7);</script> </P>
	    <P><SPAN class=option><script>show_words(_sdi_staticip);</script>: </SPAN><script>show_words(help265_2);</script> <SPAN class=option><script>show_words(_ipaddr);</script></SPAN>. </P>
	    <P><SPAN class=option><script>show_words(_srvname);</script>: </SPAN><script>show_words(help267);</script> </P>
	    <P><SPAN class=option><script>show_words(bwn_RM);</script>: </SPAN><script>show_words(help269);</script>: </P>
	    <UL>
	    <LI><SPAN class=option><script>show_words(bwn_RM_0);</script>: </SPAN><script>show_words(help271);</script> 
	    <LI><SPAN class=option><script>show_words(bwn_RM_1);</script>: </SPAN><script>show_words(help273);</script> 
	    <LI><SPAN class=option><script>show_words(help274);</script>: </SPAN><script>show_words(help275);</script> 
	    </LI></UL>
	    <P><SPAN class=option><script>show_words(bwn_MIT);</script>: </SPAN><script>show_words(help277);</script> </P>
	    <DT><script>show_words(_PPTP);</script>
	    <DD><script>show_words(help278);</script> <script>show_words(bw_sap);</script> 
	    <P><SPAN class=option><script>show_words(carriertype_ct_0);</script>: </SPAN><script>show_words(help265_7);</script> </P>
	    <P><SPAN class=option><script>show_words(_sdi_staticip);</script>: </SPAN><script>show_words(help265_5);</script>: 
	    <SPAN class=option><script>show_words(_PPTPip);</script></SPAN>, <SPAN class=option><script>show_words(_PPTPsubnet);</script> </SPAN>, <script>show_words(help257);</script> 
	    <SPAN class=option><script>show_words(_PPTPgw);</script></SPAN>. </P>
	    <P><SPAN class=option><script>show_words(YM108);</script>: </SPAN><script>show_words(help280);</script>. </P>
	    <P><SPAN class=option><script>show_words(bwn_RM);</script>: </SPAN><script>show_words(help282);</script>: </P>
	    <UL>
	    <LI><SPAN class=option><script>show_words(bwn_RM_0);</script>: </SPAN><script>show_words(help271);</script> 
	    <LI><SPAN class=option><script>show_words(bwn_RM_1);</script>: </SPAN><script>show_words(help273);</script> 
	    <LI><SPAN class=option><script>show_words(bwn_RM_2);</script>: </SPAN><script>show_words(help275);</script> 
	    </LI></UL>
	    <P><SPAN class=option><script>show_words(bwn_MIT);</script>: </SPAN><script>show_words(help283);</script> </P>
	    <DT><script>show_words(_L2TP);</script> 
	    <DD><script>show_words(help284);</script> <script>show_words(bw_sap);</script> 
	    <P><SPAN class=option><script>show_words(carriertype_ct_0);</script>: </SPAN><script>show_words(help265_7);</script> </P>
	    <P><SPAN class=option><script>show_words(_sdi_staticip);</script>: </SPAN><script>show_words(help265_5);</script>: 
	    <SPAN class=option><script>show_words(help284);</script></SPAN>, 
	    <SPAN class=option><script>show_words(_L2TPsubnet);</script> </SPAN>, <script>show_words(help257);</script> 
	    <SPAN class=option><script>show_words(_L2TPgw);</script></SPAN>.</P>
	    <P><SPAN class=option><script>show_words(bwn_L2TPSIPA);</script>: </SPAN><script>show_words(help280);</script>. </P>
	    <P><SPAN class=option><script>show_words(bwn_RM);</script>: </SPAN><script>show_words(help286);</script>: </P>
	    <UL>
	    <LI><SPAN class=option><script>show_words(bwn_RM_0);</script>: </SPAN><script>show_words(help271);</script> 
	    <LI><SPAN class=option><script>show_words(bwn_RM_1);</script>: </SPAN><script>show_words(help273);</script> 
	    <LI><SPAN class=option><script>show_words(bwn_RM_2);</script>: </SPAN><script>show_words(help275);</script> 
	    </LI></UL>
	    <P><SPAN class=option><script>show_words(bwn_MIT);</script>: </SPAN>T<script>show_words(help287);</script> </P></DD></DL>
	    <DT>
	    <DD>
	    <div id="show_hnat" style="display:none">	
	    	<P><span class=option><script>show_words(HNAT_HELP_TITLE);</script>:</span></P>
	    	<script>show_words(HNAT_HELP_DESC);</script><br />
	    </div>
	    <P><script>show_words(help288);</script> </P>
	    <P><SPAN class=option><script>show_words(_dns1);</script>, <script>show_words(_dns2);</script>: 
	    </SPAN><script>show_words(help290a);</script> </P>
	    <P><SPAN class=option><script>show_words(bwn_MTU);</script>:</SPAN> <script>show_words(help294);</script> </P>
	    <!--//2009/4/29 Tina add OPENDNS-->
	    <!--P><span class=option><script>show_words(_sp_title_AdvDNS);</script> :</span>
	    <script>show_words(_sp_desc1_AdvDNS);</script><br />
	    <script>show_words(_sp_desc2_AdvDNS);</script><br />
	    <script>show_words(_sp_desc3_AdvDNS);</script><br />
            <script>show_words(_sp_desc4_AdvDNS);</script><br />
            </P>
            <!--//OPENDNS-->			              
            <P><SPAN class=option><script>show_words(_macaddr);</script>:</SPAN> <script>show_words(help302);</script> <script>show_words(help304);</script> 
            </P></DD></DL>
          </td>
        </tr>
      </table>
      </div>
     <div class="box" id="wlan">
     <h2><A id=Wireless name=Wireless><script>show_words(_wirelesst);</script></a></h2>
     <table border=0 cellspacing=0 cellpadding=0>
       <tr>
         <td>
	     <P><script>show_words(help349);</script> </P>
	     <P><script>show_words(help350_a);</script> </P>
	     <DL>
	     <DT><script>show_words(bwl_EW);</script> 
	     <DD><script>show_words(help351);</script> 
	     <DT><script>show_words(bwl_NN);</script> 
	     <DD><script>show_words(help352);</script>
	     <DT><script>show_words(ebwl_AChan);</script> 
	     <DD><script>show_words(help354);</script> 
	     <DT><script>show_words(_wchannel);</script> 
	     <DD><script>show_words(help355);</script> <!-- super_G -->
	     <DT><script>show_words(bwl_Mode);</script> 
	     <DD><script>show_words(help357);</script>
	     <DT><script>show_words(bwl_CWM);</script> 
	     <DD><script>show_words(bwl_CWM_h1);</script> <script>show_words(bwl_CWM_h2);</script> 
	     	     
	     <DT><script>show_words(bwl_VS);</script> 
	     <DD><script>show_words(help353);</script> 
	     <DT><script>show_words(bws_SM);</script> 
	     <DD><script>show_words(bws_SM_h1);</script>
	     <DT><script>show_words(LS321);</script> 
	     <DD>
	     <P><script>show_words(help366);</script> </P>
	     <DIV class=help_example>
	     <DL>
	     <DT><script>show_words(help3);</script>: 
	     <DD><script>show_words(help368);</script> 
	     <DD><script>show_words(help369);</script> 
	     <DD><script>show_words(help370);</script> 
	     <DD><script>show_words(help371);</script> </DD></DL></DIV>
	     <P><script>show_words(help371_n);</script> </P>
	     <DT><script>show_words(help372);</script> 
	     <DD>
	     <P><script>show_words(help373);</script> </P>
	     <P><SPAN class=option><script>show_words(bws_WPAM);</script>: </SPAN><script>show_words(help375);</script> </P>
	     <P><SPAN class=option><script>show_words(bws_GKUI);</script>: </SPAN><script>show_words(help379);</script> </P>
	     <DT><script>show_words(_WPApersonal);</script> 
	     <DD>
	     <P><script>show_words(help380);</script> </P>
	     <P><SPAN class=option><script>show_words(LW25);</script>: </SPAN><script>show_words(help382);</script> </P>
	     <DIV class=help_example>
	     <DL>
	     <DT><script>show_words(help3);</script>: 
	     <DD><CODE><script>show_words(help383);</script></CODE> </DD></DL></DIV>
	     <DT><script>show_words(_WPAenterprise);</script> 
	     <DD>
	     <P><script>show_words(help384);</script> </P>
             <P><SPAN class=option><script>show_words(bwsAT_);</script>: </SPAN><script>show_words(help386);</script> </P>
             <P><SPAN class=option><script>show_words(help387);</script>: </SPAN><script>show_words(help388);</script> </P>
             <P><SPAN class=option><script>show_words(bws_RSP);</script>: </SPAN><script>show_words(help390);</script> </P>
             <P><SPAN class=option><script>show_words(bws_RSSs);</script>: </SPAN><script>show_words(help392);</script> </P>
             <P><SPAN class=option><script>show_words(bws_RMAA);</script>: </SPAN><script>show_words(help394);</script> </P>
             <P><SPAN class=option><script>show_words(_advanced);</script>: </SPAN></P>
  	     <DL>
             <DT><script>show_words(bws_ORAD);</script> 
             <DD><script>show_words(help397);</script> </DD>
             </DL></DD></DL>
	  </td>
	</tr>
	</table>
	</div>

	<div class="box">
	<h2><A id=Network name=Network><script>show_words(bln_title);</script></A></h2>
	<table border=0 cellspacing=0 cellpadding=0>
	<tr>
	<td>
	<DL><!-- No Bridge issue 2007.05.08 -->
	<DT><script>show_words(bln_title_Rtrset);</script> 
	<DD><script>show_words(help305);</script> <script>show_words(help305rt);</script> 
	<DL>
	<DT><script>show_words(_ipaddr);</script> 
	<DD><script>show_words(help307);</script> 
	<DT><script>show_words(help703);</script> 
	<DD><script>show_words(help309);</script> 
	<DT><script>show_words(DEVICE_NAME);</script> 
	<DD><script>show_words(DEVICE_DESC);</script>									
	<DT><script>show_words(_262);</script> 
	<DD><script>show_words(_1044);</script> <script>show_words(_1044a);</script>
	<DT><script>show_words(bln_title_DNSRly);</script> 
	<DD><script>show_words(help312dr2);</script> </DD></DL><!--  No Bridge issue 2007.05.18
					<p><script>show_words(KR73);</script></p>
	
					<dl>
	
					<dt><script>show_words(_ripaddr);</script></dt>
						<dd><script>show_words(KR74);</script> 
					<script>show_words(KR75);</script>
					<script>show_words(KR76);</script></dd>
	
					<dt><script>show_words(_subnet);</script></dt>
						<dd><script>show_words(KR77);</script></dd>
	
					<dt>Gateway</dt>
						<dd><script>show_words(KR78);</script>
							<script>show_words(KR7);</script></dd>
					<dt>
						<script>show_words(_dns1);</script>, <script>show_words(_dns2);</script></dt>
					<dd>
	<script>show_words(help290a);</script>
	</dd>
	
					</dl>
					-->
	<DT><script>show_words(bd_title_DHCPSSt);</script> 
	<DD>
	<P><script>show_words(help314);</script> </P>
	<DL>
	<DT><script>show_words(bd_EDSv);</script> 
	<DD>
	<P><script>show_words(help316);</script> </P>
	<P><script>show_words(help317);</script> </P>
	<P><script>show_words(help318);</script></P>
	<DT><script>show_words(bd_DIPAR);</script> 
	<DD><script>show_words(help319);</script> 
	<P><script>show_words(help320);</script> </P>
	<P><script>show_words(help321);</script> </P>

	<DIV class=help_example>
	<DL>
	<DT><script>show_words(help3);</script>: 
	<DD><script>show_words(help322);</script>
	<DT><script>show_words(help3);</script>: 
	<DD><script>show_words(help323);</script> </DD></DL></DIV>
	<DT><script>show_words(bd_DLT);</script> 
	<DD><script>show_words(help324);</script> 
	<DT><script>show_words(bd_DAB);</script> 
	<DD><script>show_words(help326);</script> 
	<DT><script>show_words(bd_NETBIOS);</script> 
	<DD><script>show_words(help400_b);</script> <script>show_words(help400_1);</script>
	<DT><script>show_words(bd_NETBIOS_WAN);</script> 
	<DD><script>show_words(help401_b);</script> <script>show_words(help401_1);</script> 
	
	<DT><script>show_words(bd_NETBIOS_WINS_1);</script> 
	<DD><script>show_words(help402_b);</script> <script>show_words(help402_1);</script> <script>show_words(help402_2);</script> 
	<DT><script>show_words(bd_NETBIOS_WINS_2);</script> 
	<DD><script>show_words(help403_b);</script> 
	<script>show_words(help402_2);</script> 
	<DT><script>show_words(bd_NETBIOS_SCOPE);</script> 
	<DD><script>show_words(help404_b);</script> <script>show_words(help402_2);</script> 
	<DT><script>show_words(bd_NETBIOS_REG);</script> 
	<DD><script>show_words(help405_b);</script>
	<BR><script>show_words(help405_1);</script>
	<BR><script>show_words(help405_2);</script>
	<BR><script>show_words(help405_3);</script>
	<BR><script>show_words(help405_4);</script>
	<BR><script>show_words(help402_2);</script>
	<BR>
	</DD></DL>
	<DT><A id="Static_DHCP" name="Static_DHCP"><script>show_words(help330);</script></A> 
	<DD>
	<P><script>show_words(help331);</script> </P>
	<DL>
	<DT><script>show_words(bd_CName);</script> 
	<DD>
	<P><script>show_words(help345);</script> <script>show_words(help3);</script>: <CODE><script>show_words(help346);</script></CODE>. </P>
	<DT><script>show_words(_ipaddr);</script>: 
	<DD><script>show_words(_1066);</script> 
	<DT><script>show_words(_macaddr);</script> 
	<DD>
	<P><script>show_words(help333);</script> </P>
	<P><script>show_words(help334);</script> </P>
	<P><script>show_words(help335);</script>: </P>
	<TABLE summary="">
	<TBODY>
	<TR>
	<TD width="20%"><script>show_words(help336);</script> <BR clear=none><script>show_words(help337);</script> </TD>
	<TD><script>show_words(help338);</script> </TD></TR>
	<TR>
	<TD width="20%"><script>show_words(help339);</script> <BR clear=none><script>show_words(help340);</script> </TD>
	<TD><script>show_words(help341);</script> </TD></TR>
	<TR>
	<TD width="20%"><script>show_words(help342);</script> </TD>
	<TD><script>show_words(help343);</script> </TD></TR></TBODY></TABLE></DD></DL>
	<DT><script>show_words(bd_title_list);</script> 
	<DD><script>show_words(help348);</script> 
	<DT><script>show_words(bd_title_clients);</script> 
	<DD>
	<P><script>show_words(help327);</script> </P>
	<DL>
	<DT><script>show_words(bd_Revoke);</script> 
	<DD><script>show_words(help329);</script> 
	<DT><script>show_words(bd_Reserve);</script> 
	<DD><script>show_words(help329_rsv);</script> </DD></DL></DD></DL>
	</td>
	</tr>
	</table>
	</div>

	<div class="box" id="div_usb">
	<h2><a id="USB" name="USB"><script>show_words(bln_title_usb);</script></a></h2>
	<dl>
	<dt><script>show_words(usb_network);</script></dt>
	<dd><script>show_words(usb_network_help);</script>
	<dl>
	<dt><script>show_words(_support)</script></dt>
	<dd><script>show_words(usb_network_support_help);</script></dd>
	</dl>
	</dd>
	<!--dt><script>show_words(usb_3g)</script></dt>
	<dd><script>show_words(usb_3g_help)</script>
	<dl>
	<dt><script>show_words(_support)</script></dt>
	<dd><script>show_words(usb_3g_help_support_help)</script></dd>
	</dl>
	</dd-->
	<dt><script>show_words(usb_wcn);</script></dt>
	<dd><script>show_words(usb_wcn_help);</script></dd>
	</dl>
	</div>

	<div class="box" id="div_vpn">
	<h2><a id="VPN" name="VPN"><script>show_words(vpn_setting);</script></a></h2>
	<strong><script>show_words(vpn_setting);</script><br></strong>
	<script>show_words(support_vpn_header_desc);</script><br><br>
	<script>show_words(support_vpn_ipsec_desc);</script><br><br>
	<script>show_words(vpn_ipsec_help_msg2);</script>
	<p>&#149;&nbsp;<script>show_words(vpn_ipsec_help_msg3);</script><br>
	&#149;&nbsp;<script>show_words(vpn_ipsec_help_msg4);</script></p>
	<p><script>show_words(support_vpn_ipsec_ike_desc);</script><br><br>
	<em><strong><script>show_words(_enable);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_chkbox_en);</script><br>
	<em><strong><script>show_words(_name);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_fill_name);</script><br>
	<em><strong><script>show_words(support_vpn_encrp_mode);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_tunnel);</script><br>
	<em><strong><script>show_words(vpn_ipsec_rip);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_s2s);</script><br>
	<em><strong><script>show_words(vpn_ipsec_rip_netmask);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_l2l);</script><br>
	<em><strong><script>show_words(_auth);</script></strong></em>
	<strong><em> - </em></strong><script>show_words(support_vpn_psk);</script><br>
	<br>
	<strong><script>show_words(_phase);</script> 1:</strong>
	<script>show_words(support_vpn_mode);</script><br>
	<script>show_words(support_vpn_mode_desc);</script> </p>
	<p><script>show_words(_ike_list);</script>: <br>
	<script>show_words(_cipher);</script>: <br>
	#1- Select 3DES or AES <br>
	#2- Select 3DES or AES <br>
	#3- Select 3DES or AES <br>
	#4- Select 3DES or AES <br>
	<br>
	<script>show_words(_hash);</script>: <br>
	#1- Select SHA1 or MD5 <br>
	#2- Select SHA1 or MD5 <br>
	#3- Select SHA1 or MD5 <br>
	#4- Select SHA1 or MD5 </p>
	<p><script>show_words(_ipsec_list);</script>: <br>
	<br>
	<strong><script>show_words(_phase);</script> 2:</strong>
	<script>show_words(support_vpn_pfs);</script><br>
	<script>show_words(_cipher);</script>: <br>
	#1- Select 3DES or AES <br>
	#2- Select 3DES or AES <br>
	#3- Select 3DES or AES <br>
	#4- Select 3DES or AES <br>
	<br>
	<script>show_words(_hash);</script>: <br>
	#1- Select SHA1 or MD5 <br>
	#2- Select SHA1 or MD5 <br>
	#3- Select SHA1 or MD5 <br>
	#4- Select SHA1 or MD5 <br>
	<br>
	<strong><script>show_words(vpn_settings_op2);</script></strong><br>
	<script>show_words(vpn_pptp_l2tp_help_msg1);</script><br>
	<br>
	<script>show_words(vpn_pptp_l2tp_help_msg2);</script><br><br>
	<br>
	<em><strong><script>show_words(support_vpn_en_setting);</script></strong></em> - <script>show_words(support_vpn_chkbox_en);</script> <br>
	<em><strong><script>show_words(_name);</script></strong></em> - <script>show_words(support_vpn_fill_name);</script> <br>
	<em><strong><script>show_words(_contype);</script></strong></em> - <script>show_words(support_vpn_sel_pptp_or_l2tp);</script> <br>
	<em><strong><script>show_words(vpn_pptp_l2tp_server_ip);</script></strong></em> - <script>show_words(support_vpn_server_ip);</script> <br>
	<strong><em><script>show_words(at_ReIPR);</script></em></strong> - <script>show_words(support_vpn_assign_ip);</script> <br>
	<strong><em><script>show_words(wwan_auth_label);</script></em></strong> - <script>show_words(support_vpn_auth_protocol);</script> <br>
	<em><strong><script>show_words(vpn_pptp_l2tp_mppe_encrypt_mode);</script></strong></em> - <script>show_words(support_vpn_encryption);</script><br>
	<em><strong><script>show_words(support_vpn_auth_src);</script></strong></em> - <script>show_words(_local);</script> </p>
	</div>

	<div class="box" id="div_sslvpn">
	<h2><script>show_words(vpn_sslvpn_setting);</script><a name="SSLVPN" id="SSLVPN"></a></h2>
	<table width=511 border=0 cellspacing=0 cellpadding=0>
	<tr>
	<td height=20>
	<script>show_words(vpn_ssl_help_msg1);</script>
	<br><br>
	<strong><script>show_words(vpn_ssl_certi_setting);</script></strong><br>
	<strong><script>show_words(vpn_ssl_help_msg2);</script></strong>
	<br><br>
	<em><strong><script>show_words(vpn_ssl_certi_sel);</script></strong></em> - 
	<script>show_words(vpn_ssl_support_msg);</script>
	<br><br>
	<em><strong><script>show_words(vpn_ssl_port +" "+_select);</script></strong></em> - 
	<script>show_words(vpn_ssl_support_port_msg);</script>
	<br>
	<strong><script>show_words(vpn_sslvpn_setting);</script></strong><br>
	<script>show_words(vpn_sslvpn_setting_msg);</script>
	<br><br>
	<em><strong><script>show_words(vpn_ssl_en);</script></strong></em> - 
	<script>show_words(vpn_sslvpn_checkbox);</script>
	<br><br>
	<em><strong><script>show_words(_name);</script></strong></em> - 
	<script>show_words(vpn_sslvpn_servername);</script>
	<br><br>
	<em><strong><script>show_words(_ug);</script></strong></em> - 
	<script>show_words(vpn_sslvpn_ug);</script>
	<br><br>
	<em><strong><script>show_words(vpn_ssl_access_range);</script></strong></em> -
	<script>show_words(vpn_sslvpn_acc_range);</script>
	<br><br>
	<script>show_words(vpn_sslvpn_save_config);</script></td>
	</tr>
	</table>
	</div>
		  <div class="box" id="IPV6">
		 <h2><A name=IPV6>Ipv6</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
              <td> <DL>
                  <DT>IPv6 
                  <DD><script>show_words(IPV6_TEXT76);</script> 
                    
                  <DT><script>show_words(IPV6_TEXT29);</script> 
                  <DD><script>show_words(IPV6_TEXT77);</script> 
                    <DL>
                      <DT><script>show_words(IPV6_TEXT78);</script> 
                      <DD><script>show_words(IPV6_TEXT79);</script></DD>
                    </DL>
                    <DL>
                      <DT><script>show_words(IPV6_TEXT80);</script> 
                      <DD><script>show_words(IPV6_TEXT81);</script>
					  </DD>
                    </DL>
                    <DL>
                      <DT><script>show_words(IPV6_TEXT82);</script> 
                      <DD><script>show_words(IPV6_TEXT83);</script></DD>
                    </DL>
                    <DL>
                      <DT><script>show_words(IPV6_TEXT84);</script> 
                      <DD><script>show_words(IPV6_TEXT85);</script> </DD>
                    </DL>
                   <DL>
                      <DT><script>show_words(IPV6_TEXT34);</script> 
                      <DD><script>show_words(IPV6_TEXT86);</script> 
                      </DD>
                      <DD> 
                        <P><SPAN class=option><script>show_words(carriertype_ct_0);</script>: </SPAN><script>show_words(IPV6_TEXT87);</script> </P>
                      <DD> 
                        <P><SPAN class=option><script>show_words(_sdi_staticip);</script>: </SPAN><script>show_words(IPV6_TEXT88);</script> </P>
                      <DD> 
                        <P><SPAN class=option><script>show_words(_srvname);</script>: </SPAN><script>show_words(help267);</script> </P>
                      <DD> 
                        <P><SPAN class=option><script>show_words(bwn_RM);</script>: </SPAN><script>show_words(help269);</script>: </P>
                        <UL>
                          <LI><SPAN class=option><script>show_words(bwn_RM_0);</script>: </SPAN><script>show_words(help271);</script>
                          <LI><SPAN class=option><script>show_words(bwn_RM_1);</script>: </SPAN><script>show_words(help273);</script> 
                          <LI><SPAN class=option><script>show_words(bwn_RM_2);</script>: </SPAN><script>show_words(help275);</script> </LI>
                        </UL>
                        <P><SPAN class=option><script>show_words(bwn_MIT);</script>: </SPAN>T<script>show_words(IPV6_TEXT89);</script> </P>
                      <dt>&nbsp; </dt>
                    </DL>
					<DL>
                  <DT><script>show_words(IPV6_TEXT90);</script> 
                  <DD><script>show_words(IPV6_TEXT91);</script> 
				</DL>	
                 <DL> <DT><script>show_words(IPV6_TEXT92);</script> 
                  <DD><script>show_words(IPV6_TEXT93);</script> </DD><br>
                   <DD><script>show_words(help288);</script></DD><br>
				   <DD><script>show_words(IPV6_TEXT94);</script></DD>
                  </DL>
				  <DT><script>show_words(IPV6_TEXT44);</script>
                  
                <DD><script>show_words(IPV6_TEXT95);</script></DD>
                <DT><script>show_words(_LAN);</script> <script>show_words(IPV6_TEXT48);</script> 
                  
                <DD><script>show_words(IPV6_TEXT96);</script></DD>
                <DD> 
                  <dl>
                    <DT><script>show_words(IPV6_TEXT50);</script> 
                    <DD><script>show_words(IPV6_TEXT97);</script> </DD>
                    <DD><script>show_words(IPV6_TEXT98);</script></DD>
                    <DD><script>show_words(IPV6_TEXT99);</script> 
                    <DD><script>show_words(IPV6_TEXT101);</script> </DD>
                    <DD><script>show_words(IPV6_TEXT102);</script> </DD>
                    <DT><script>show_words(IPV6_TEXT56);</script> 
                    <DD><script>show_words(IPV6_TEXT103);</script> </DD>
                  </dl>
                </DD>
				  	</td>
                    </tr>
				  </table>
				  </div>

				  <div class="box" id="plc">
				  <h2><A id=Network name=PLC>PLC Setup</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr><td>
				  <DL><DT><script>show_words(_ap_plc_info);</script><DD>
				  <P><script>show_words(_ap_plc_info_2);</script></P>
				  <DT><script>show_words(_ap_plc_info_3);</script><DD>
				  <P><script>show_words(_ap_plc_info_4);</script></P>
				  <DT><script>show_words(_password);</script><DD>
				  <P><script>show_words(_ap_plc_info_5);</script></P>
				  <DT><script>show_words(_macaddr);</script><DD>
				  <P><script>show_words(_ap_plc_info_6);</script></P>
				  <DT><script>show_words(_name);</script><DD>
				  <P><script>show_words(_ap_plc_info_7);</script></P>
				  <DT><script>show_words(_ap_plc_info_8);</script><DD>
				  <P><script>show_words(_ap_plc_info_9);</script></P>
				  <DT><script>show_words(_status);</script><DD>
				  <P><script>show_words(_ap_plc_info_10);</script></P>
				  <DT><script>show_words(_ap_plc_info_11);</script><DD>
				  <P><script>show_words(_ap_plc_info_12);</script></P>
				  </DL>
				  </td>
				  </tr>
				  </table>
				  </div>
	</div>
      </td>
    </tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
<td width="10">&nbsp;</td>
<td>&nbsp;</td>
</tr>
</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
<script>
if (check_setup("USB") == -1) {
	get_by_id("div_usb").style.display = "none";
}

if (check_setup("VPN") == -1) {
	get_by_id("div_vpn").style.display = "none";
}

if (check_setup("SSLVPN") == -1) {
	get_by_id("div_sslvpn").style.display = "none";
}

if (check_setup("Wireless") == -1) {
	get_by_id("wlan").style.display = "none";
}

if (check_setup("PLC") == -1) {
	get_by_id("plc").style.display = "none";
}
if (check_setup("ipv6") == -1) {
	get_by_id("IPV6").style.display = "none";
}
//Enable/Disable HW NAT
show_hnat();
</script>
</body>
</html>
