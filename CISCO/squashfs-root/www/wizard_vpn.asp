<% web_include_file("filelink.asp"); %>
<script>
var ike_entry = new Array();
<% get_site2site_adv_ike("ike_entry","Array"); %>

var ipsec_entry = new Array();
<% get_site2site_adv_ipsec("ipsec_entry","Array"); %>

function vpn_alert_result()
{
	var getting_start = "<% nvram_get("getting_start"); %>";
	alert_result(0);
	parent.document.getElementById("wizard_bg").style.display="none";
	if ( getting_start == "1" ) 
	{
		get_position("getstart.asp",0);
	}else{
		get_position("dashboard.asp",0);
	}
}

function before_leave(){
//For Changed without save alert message
	parent.document.getElementById("GUI_FUN").value = 1 ;
}
//	parent.frames["wizard"].location.href = goto_link("wizard_vpn/index.asp");
	parent.frames["wizard"].location.href = goto_link("wizard_vpn/index.asp");
	parent.document.getElementById("wizard_bg").style.display="";
	if ( ipsec_entry.length == IPSEC_ENTRY || ike_entry.length == IKE_ENTRY ) 
	{
                my_alert(O_GUI,INFO,__T(share.info),__T("The VPN Setup Wizard will be terminated because IKE or VPN Policy Table is already full."),"vpn_alert_result(0)");
	}
</script>
