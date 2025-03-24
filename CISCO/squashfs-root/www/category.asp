<html>
<head>
<title>Session Timeout</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var back_bt = "true";
var define_backname="webfilter.asp";
function to_back(F)
{
	parent.document.getElementById("newpage").value = "webfilter.asp";
	uiDoCancel(F,"back");
}
function data(id,nv_val,def_nv,group,item,desc)
{
	this.id = id;
	this.nv_val = nv_val;
	this.def_nv = def_nv;
	this.group = group;
	this.item = item;
	this.desc = desc;
} 
var cate_list = new Array();
cate_list[0] = new data(11,"<% nvram_get("wf_cate_11"); %>","<% nvram_default_get("wf_cate_11"); %>",__T(category.adultmature), __T(category.adultmature_title1), __T(category.adultmature_help1));
cate_list[1] = new data(18,"<% nvram_get("wf_cate_18"); %>","<% nvram_default_get("wf_cate_18"); %>",__T(category.adultmature), __T(category.adultmature_title2), __T(category.adultmature_help2));
cate_list[2] = new data(27,"<% nvram_get("wf_cate_27"); %>","<% nvram_default_get("wf_cate_27"); %>",__T(category.adultmature), __T(category.adultmature_title3), __T(category.adultmature_help3));
cate_list[3] = new data(62,"<% nvram_get("wf_cate_62"); %>","<% nvram_default_get("wf_cate_62"); %>",__T(category.adultmature), __T(category.adultmature_title4), __T(category.adultmature_help4));
cate_list[4] = new data(19,"<% nvram_get("wf_cate_19"); %>","<% nvram_default_get("wf_cate_19"); %>",__T(category.adultmature), __T(category.adultmature_title5), __T(category.adultmature_help5));
cate_list[5] = new data(43,"<% nvram_get("wf_cate_43"); %>","<% nvram_default_get("wf_cate_43"); %>",__T(category.adultmature), __T(category.adultmature_title6), __T(category.adultmature_help6));
cate_list[6] = new data(6,"<% nvram_get("wf_cate_6"); %>","<% nvram_default_get("wf_cate_6"); %>",__T(category.businessinv), __T(category.businessinv_title1), __T(category.businessinv_help1));
cate_list[7] = new data(4,"<% nvram_get("wf_cate_4"); %>","<% nvram_default_get("wf_cate_4"); %>",__T(category.businessinv), __T(category.businessinv_title2), __T(category.businessinv_help2));
cate_list[8] = new data(5,"<% nvram_get("wf_cate_5"); %>","<% nvram_default_get("wf_cate_5"); %>",__T(category.businessinv), __T(category.businessinv_title3), __T(category.businessinv_help3));
cate_list[9] = new data(2,"<% nvram_get("wf_cate_2"); %>","<% nvram_default_get("wf_cate_2"); %>",__T(category.businessinv), __T(category.businessinv_title4), __T(category.businessinv_help4));
cate_list[10] = new data(3,"<% nvram_get("wf_cate_3"); %>","<% nvram_default_get("wf_cate_3"); %>",__T(category.businessinv), __T(category.businessinv_title5), __T(category.businessinv_help5));
cate_list[11] = new data(23,"<% nvram_get("wf_cate_23"); %>","<% nvram_default_get("wf_cate_23"); %>",__T(category.businessinv), __T(category.businessinv_title6), __T(category.businessinv_help6));
cate_list[12] = new data(63,"<% nvram_get("wf_cate_63"); %>","<% nvram_default_get("wf_cate_63"); %>",__T(category.businessinv), __T(category.businessinv_title7), __T(category.businessinv_help7));
cate_list[13] = new data(1,"<% nvram_get("wf_cate_1"); %>","<% nvram_default_get("wf_cate_1"); %>",__T(category.businessinv), __T(category.businessinv_title8), __T(category.businessinv_help8));
cate_list[14] = new data(29,"<% nvram_get("wf_cate_29"); %>","<% nvram_default_get("wf_cate_29"); %>",__T(category.businessinv), __T(category.businessinv_title9), __T(category.businessinv_help9));
cate_list[15] = new data(7,"<% nvram_get("wf_cate_7"); %>","<% nvram_default_get("wf_cate_7"); %>",__T(category.businessinv), __T(category.businessinv_title10), __T(category.businessinv_help10));
cate_list[16] = new data(16,"<% nvram_get("wf_cate_16"); %>","<% nvram_default_get("wf_cate_16"); %>",__T(category.businessinv), __T(category.businessinv_title11), __T(category.businessinv_help11));
cate_list[17] = new data(17,"<% nvram_get("wf_cate_17"); %>","<% nvram_default_get("wf_cate_17"); %>",__T(category.businessinv), __T(category.businessinv_title12), __T(category.businessinv_help12));
cate_list[18] = new data(52,"<% nvram_get("wf_cate_52"); %>","<% nvram_default_get("wf_cate_52"); %>",__T(category.businessinv), __T(category.businessinv_title13), __T(category.businessinv_help13));
cate_list[19] = new data(21,"<% nvram_get("wf_cate_21"); %>","<% nvram_default_get("wf_cate_21"); %>",__T(category.entertainment), __T(category.entertainment_title1), __T(category.entertainment_help1));
cate_list[20] = new data(79,"<% nvram_get("wf_cate_79"); %>","<% nvram_default_get("wf_cate_79"); %>",__T(category.entertainment), __T(category.entertainment_title2), __T(category.entertainment_help2));
cate_list[21] = new data(34,"<% nvram_get("wf_cate_34"); %>","<% nvram_default_get("wf_cate_34"); %>",__T(category.entertainment), __T(category.entertainment_title3), __T(category.entertainment_help3));
cate_list[22] = new data(12,"<% nvram_get("wf_cate_12"); %>","<% nvram_default_get("wf_cate_12"); %>",__T(category.entertainment), __T(category.entertainment_title4), __T(category.entertainment_help4));
cate_list[23] = new data(38,"<% nvram_get("wf_cate_38"); %>","<% nvram_default_get("wf_cate_38"); %>",__T(category.entertainment), __T(category.entertainment_title5), __T(category.entertainment_help5));
cate_list[24] = new data(60,"<% nvram_get("wf_cate_60"); %>","<% nvram_default_get("wf_cate_60"); %>",__T(category.entertainment), __T(category.entertainment_title6), __T(category.entertainment_help6));
cate_list[25] = new data(80,"<% nvram_get("wf_cate_80"); %>","<% nvram_default_get("wf_cate_80"); %>",__T(category.entertainment), __T(category.entertainment_title7), __T(category.entertainment_help7));
cate_list[26] = new data(42,"<% nvram_get("wf_cate_42"); %>","<% nvram_default_get("wf_cate_42"); %>",__T(category.entertainment), __T(category.entertainment_title8), __T(category.entertainment_help8));
cate_list[27] = new data(9,"<% nvram_get("wf_cate_9"); %>","<% nvram_default_get("wf_cate_9"); %>",__T(category.entertainment), __T(category.entertainment_title9), __T(category.entertainment_help9));
cate_list[28] = new data(68,"<% nvram_get("wf_cate_68"); %>","<% nvram_default_get("wf_cate_68"); %>",__T(category.illegalqst), __T(category.illegalqst_title1), __T(category.illegalqst_help1));
cate_list[29] = new data(10,"<% nvram_get("wf_cate_10"); %>","<% nvram_default_get("wf_cate_10"); %>",__T(category.illegalqst), __T(category.illegalqst_title2), __T(category.illegalqst_help2));
cate_list[30] = new data(76,"<% nvram_get("wf_cate_76"); %>","<% nvram_default_get("wf_cate_76"); %>",__T(category.illegalqst), __T(category.illegalqst_title3), __T(category.illegalqst_help3));
cate_list[31] = new data(53,"<% nvram_get("wf_cate_53"); %>","<% nvram_default_get("wf_cate_53"); %>",__T(category.illegalqst), __T(category.illegalqst_title4), __T(category.illegalqst_help4));
cate_list[32] = new data(8,"<% nvram_get("wf_cate_8"); %>","<% nvram_default_get("wf_cate_8"); %>",__T(category.illegalqst), __T(category.illegalqst_title5), __T(category.illegalqst_help5));
cate_list[33] = new data(54,"<% nvram_get("wf_cate_54"); %>","<% nvram_default_get("wf_cate_54"); %>",__T(category.illegalqst), __T(category.illegalqst_title6), __T(category.illegalqst_help6));
cate_list[34] = new data(46,"<% nvram_get("wf_cate_46"); %>","<% nvram_default_get("wf_cate_46"); %>",__T(category.illegalqst), __T(category.illegalqst_title7), __T(category.illegalqst_help7));
cate_list[35] = new data(64,"<% nvram_get("wf_cate_64"); %>","<% nvram_default_get("wf_cate_64"); %>",__T(category.illegalqst), __T(category.illegalqst_title8), __T(category.illegalqst_help8));
cate_list[36] = new data(32,"<% nvram_get("wf_cate_32"); %>","<% nvram_default_get("wf_cate_32"); %>",__T(category.illegalqst), __T(category.illegalqst_title9), __T(category.illegalqst_help9));
cate_list[37] = new data(37,"<% nvram_get("wf_cate_37"); %>","<% nvram_default_get("wf_cate_37"); %>",__T(category.illegalqst), __T(category.illegalqst_title10), __T(category.illegalqst_help10));
cate_list[38] = new data(31,"<% nvram_get("wf_cate_31"); %>","<% nvram_default_get("wf_cate_31"); %>",__T(category.illegalqst), __T(category.illegalqst_title11), __T(category.illegalqst_help11));
cate_list[39] = new data(44,"<% nvram_get("wf_cate_44"); %>","<% nvram_default_get("wf_cate_44"); %>",__T(category.illegalqst), __T(category.illegalqst_title12), __T(category.illegalqst_help12));
cate_list[40] = new data(48,"<% nvram_get("wf_cate_48"); %>","<% nvram_default_get("wf_cate_48"); %>",__T(category.illegalqst), __T(category.illegalqst_title13), __T(category.illegalqst_help13));
cate_list[41] = new data(36,"<% nvram_get("wf_cate_36"); %>","<% nvram_default_get("wf_cate_36"); %>",__T(category.illegalqst), __T(category.illegalqst_title14), __T(category.illegalqst_help14));
cate_list[42] = new data(66,"<% nvram_get("wf_cate_66"); %>","<% nvram_default_get("wf_cate_66"); %>",__T(category.itres), __T(category.itres_title1), __T(category.itres_help1));
cate_list[43] = new data(47,"<% nvram_get("wf_cate_47"); %>","<% nvram_default_get("wf_cate_47"); %>",__T(category.itres), __T(category.itres_title2), __T(category.itres_help2));
cate_list[44] = new data(30,"<% nvram_get("wf_cate_30"); %>","<% nvram_default_get("wf_cate_30"); %>",__T(category.itres), __T(category.itres_title3), __T(category.itres_help3));
cate_list[45] = new data(25,"<% nvram_get("wf_cate_25"); %>","<% nvram_default_get("wf_cate_25"); %>",__T(category.itres), __T(category.itres_title4), __T(category.itres_help4));
cate_list[46] = new data(55,"<% nvram_get("wf_cate_55"); %>","<% nvram_default_get("wf_cate_55"); %>",__T(category.itres), __T(category.itres_title5), __T(category.itres_help5));
cate_list[47] = new data(82,"<% nvram_get("wf_cate_82"); %>","<% nvram_default_get("wf_cate_82"); %>",__T(category.itres), __T(category.itres_title6), __T(category.itres_help6));
cate_list[48] = new data(40,"<% nvram_get("wf_cate_40"); %>","<% nvram_default_get("wf_cate_40"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title1), __T(category.lifestylecul_help1));
cate_list[49] = new data(83,"<% nvram_get("wf_cate_83"); %>","<% nvram_default_get("wf_cate_83"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title2), __T(category.lifestylecul_help2));
cate_list[50] = new data(61,"<% nvram_get("wf_cate_61"); %>","<% nvram_default_get("wf_cate_61"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title3), __T(category.lifestylecul_help3));
cate_list[51] = new data(69,"<% nvram_get("wf_cate_69"); %>","<% nvram_default_get("wf_cate_69"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title4), __T(category.lifestylecul_help4));
cate_list[52] = new data(26,"<% nvram_get("wf_cate_26"); %>","<% nvram_default_get("wf_cate_26"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title5), __T(category.lifestylecul_help5));
cate_list[53] = new data(45,"<% nvram_get("wf_cate_45"); %>","<% nvram_default_get("wf_cate_45"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title6), __T(category.lifestylecul_help6));
cate_list[54] = new data(24,"<% nvram_get("wf_cate_24"); %>","<% nvram_default_get("wf_cate_24"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title7), __T(category.lifestylecul_help7));
cate_list[55] = new data(13,"<% nvram_get("wf_cate_13"); %>","<% nvram_default_get("wf_cate_13"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title8), __T(category.lifestylecul_help8));
cate_list[56] = new data(81,"<% nvram_get("wf_cate_81"); %>","<% nvram_default_get("wf_cate_81"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title9), __T(category.lifestylecul_help9));
cate_list[57] = new data(41,"<% nvram_get("wf_cate_41"); %>","<% nvram_default_get("wf_cate_41"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title10), __T(category.lifestylecul_help10));
cate_list[58] = new data(22,"<% nvram_get("wf_cate_22"); %>","<% nvram_default_get("wf_cate_22"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title11), __T(category.lifestylecul_help11));
cate_list[59] = new data(35,"<% nvram_get("wf_cate_35"); %>","<% nvram_default_get("wf_cate_35"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title12), __T(category.lifestylecul_help12));
cate_list[60] = new data(20,"<% nvram_get("wf_cate_20"); %>","<% nvram_default_get("wf_cate_20"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title13), __T(category.lifestylecul_help13));
cate_list[61] = new data(14,"<% nvram_get("wf_cate_14"); %>","<% nvram_default_get("wf_cate_14"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title14), __T(category.lifestylecul_help14));
cate_list[62] = new data(39,"<% nvram_get("wf_cate_39"); %>","<% nvram_default_get("wf_cate_39"); %>",__T(category.lifestylecul), __T(category.lifestylecul_title15), __T(category.lifestylecul_help15));
cate_list[63] = new data(65,"<% nvram_get("wf_cate_65"); %>","<% nvram_default_get("wf_cate_65"); %>",__T(category.other), __T(category.other_title1), __T(category.other_help1));
cate_list[64] = new data(74,"<% nvram_get("wf_cate_74"); %>","<% nvram_default_get("wf_cate_74"); %>",__T(category.other), __T(category.other_title2), __T(category.other_help2));
cate_list[65] = new data(78,"<% nvram_get("wf_cate_78"); %>","<% nvram_default_get("wf_cate_78"); %>",__T(category.other), __T(category.other_title3), __T(category.other_help3));
cate_list[66] = new data(51,"<% nvram_get("wf_cate_51"); %>","<% nvram_default_get("wf_cate_51"); %>",__T(category.other), __T(category.other_title4), __T(category.other_help4));
cate_list[67] = new data(75,"<% nvram_get("wf_cate_75"); %>","<% nvram_default_get("wf_cate_75"); %>",__T(category.other), __T(category.other_title5), __T(category.other_help5));
cate_list[68] = new data(50,"<% nvram_get("wf_cate_50"); %>","<% nvram_default_get("wf_cate_50"); %>",__T(category.other), __T(category.other_title6), __T(category.other_help6));
cate_list[69] = new data(67,"<% nvram_get("wf_cate_67"); %>","<% nvram_default_get("wf_cate_67"); %>",__T(category.security), __T(category.security_title1), __T(category.security_help1));
cate_list[70] = new data(15,"<% nvram_get("wf_cate_15"); %>","<% nvram_default_get("wf_cate_15"); %>",__T(category.security), __T(category.security_title2), __T(category.security_help2));
cate_list[71] = new data(33,"<% nvram_get("wf_cate_33"); %>","<% nvram_default_get("wf_cate_33"); %>",__T(category.security), __T(category.security_title3), __T(category.security_help3));
cate_list[72] = new data(49,"<% nvram_get("wf_cate_49"); %>","<% nvram_default_get("wf_cate_49"); %>",__T(category.security), __T(category.security_title4), __T(category.security_help4));
cate_list[73] = new data(56,"<% nvram_get("wf_cate_56"); %>","<% nvram_default_get("wf_cate_56"); %>",__T(category.security), __T(category.security_title5), __T(category.security_help5));
cate_list[74] = new data(73,"<% nvram_get("wf_cate_73"); %>","<% nvram_default_get("wf_cate_73"); %>",__T(category.security), __T(category.security_title6), __T(category.security_help6));
cate_list[75] = new data(57,"<% nvram_get("wf_cate_57"); %>","<% nvram_default_get("wf_cate_57"); %>",__T(category.security), __T(category.security_title7), __T(category.security_help7));
cate_list[76] = new data(58,"<% nvram_get("wf_cate_58"); %>","<% nvram_default_get("wf_cate_58"); %>",__T(category.security), __T(category.security_title8), __T(category.security_help8));
cate_list[77] = new data(71,"<% nvram_get("wf_cate_71"); %>","<% nvram_default_get("wf_cate_71"); %>",__T(category.security), __T(category.security_title9), __T(category.security_help9));
cate_list[78] = new data(59,"<% nvram_get("wf_cate_59"); %>","<% nvram_default_get("wf_cate_59"); %>",__T(category.security), __T(category.security_title10), __T(category.security_help10));
cate_list[79] = new data(28,"<% nvram_get("wf_cate_28"); %>","<% nvram_default_get("wf_cate_28"); %>",__T(category.security), __T(category.security_title11), __T(category.security_help11));

var cnt = new Array(8);
var tmp=0, num=0;
var curr_item=0;
for(var i=0; i<cate_list.length; i++)
{
	num++;
        if ( i == cate_list.length-1 || cate_list[i].group != cate_list[i+1].group ) 
        {
        	cnt[tmp] = num;
                tmp++;
                num=0;
        }
}


function init(){
	parent.document.getElementById("save_bg").style.display="none";
	var nv_level = "<% nvram_get("wf_policy_level"); %>";
	var F = document.frmtimeout;
	for(var i=0; i<4; i++)
	{
		if ( F.wf_policy_level[i].value == nv_level ) 
		{
			F.wf_policy_level[i].checked = true;
			set_data(i,0); 
			break;
		}
	}
	default_nv = keep_val(F,"");
}

function show_item(id_name, tmp)
{
	if ( document.getElementById(id_name).style.display == "none")
	{
		document.getElementById(id_name).style.display="";
		document.getElementById("img"+tmp).src = "image/drawerTriangleOpen.gif";
		
	}
	else
	{
		document.getElementById(id_name).style.display="none";
		document.getElementById("img"+tmp).src = "image/drawerTriangleCollapsed.gif";
	}
		
}

function to_sel_all(item, flg)
{
	var tmp = 0;
	for(var i=0; i<cate_list.length; i++)
	{
		if ( cate_list[i+1] && cate_list[i] && (i==0 || cate_list[i].group != cate_list[i+1].group) ) 
		{
			if ( i == cate_list.length-1 || cate_list[i].group != cate_list[i+1].group ) tmp++;
			if ( item == tmp ) 
			{
				var startj = (i==0?j=i:j=i+1);
				var endj = (i==0?0:1);
				var selcnt = 0;
				for(j=startj; j<cnt[tmp]+i+endj; j++)
				{
					if ( flg == 1 ) 
						document.getElementById("chk"+cate_list[j].id).checked = true;
					else
						document.getElementById("chk"+cate_list[j].id).checked = false;
				}
			}
		}
	}
}

function set_data(item,restore_flg)
{
	curr_item = item;
	tmp=0;
	for(var i=0; i<cate_list.length; i++)
	{
		if ( cate_list[i+1] && cate_list[i] && (i==0 || cate_list[i].group != cate_list[i+1].group) ) 
		{
			if ( i == cate_list.length-1 || cate_list[i].group != cate_list[i+1].group ) tmp++;
			var startj = (i==0?j=i:j=i+1);
			var endj = (i==0?0:1);
			var selcnt = 0;
			for(j=startj; j<cnt[tmp]+i+endj; j++)
			{
				var nv_item = cate_list[j].nv_val.charAt(item);
				if ( restore_flg == 1 ) nv_item = cate_list[j].def_nv.charAt(item);
				if ( nv_item == '1' ) 
				{
					document.getElementById("chk"+cate_list[j].id).checked = true;
					selcnt++;
				}
				else
					document.getElementById("chk"+cate_list[j].id).checked = false;
				
			}
			if ( selcnt == cnt[tmp] ) 
				document.getElementById("chkimg"+tmp).src = "image/checked_all.gif";
			else if ( selcnt > 0 ) 
				document.getElementById("chkimg"+tmp).src = "image/checked_partial.gif";
			else 
				document.getElementById("chkimg"+tmp).src = "image/checked_none.gif";
		}
	}
	
}

function get_data(F)
{
	var selcate=0;
	for(var k=0; k<4; k++)
	{
		if ( F.wf_policy_level[k].checked == true ) selcate = k;
	}
	var tmplist = "";
	for(var i=0; i<cate_list.length; i++)
	{
		var tmpnv = "";
		for(var j=0; j<4; j++)
		{
			if ( j == selcate ) 
				tmpnv += document.getElementById("chk"+cate_list[i].id).checked == true?'1':'0';
			else
				tmpnv  += cate_list[i].nv_val.charAt(j);
		}
		if ( tmplist != "" ) tmplist += ";";
		tmplist += cate_list[i].id+","+tmpnv;
	}
	return tmplist;
}

function uiDoSave(F)
{
	F.wf_cate.value = get_data(F);
	//alert(F.wf_cate.value);
	F.submit_button.value = "category";
	F.gui_action.value = "Apply";
	F.submit();
	parent.document.getElementById("save_bg").style.display="";
}

function click_mchk(selidx)
{
	var imgsrc = document.getElementById("chkimg"+selidx).src;
	if ( imgsrc.indexOf("image/checked_all.gif") != -1 ) 
	{
		document.getElementById("chkimg"+selidx).src = "image/checked_none.gif";
		to_sel_all(selidx,0);
	}
	else  
	{
		document.getElementById("chkimg"+selidx).src = "image/checked_all.gif";
		to_sel_all(selidx,1);
	}
}

function to_restore()
{
	set_data(curr_item,1);
}

function chg_main_st(selidx,sip,eip)
{
	var total_cnt=0, selcnt=0;
	for(var i=sip; i<eip; i++)
	{
		if ( document.getElementById("chk"+cate_list[i].id).checked == true ) selcnt++;
		total_cnt++;
	}
	if( total_cnt == selcnt ) 
		document.getElementById("chkimg"+selidx).src = "image/checked_all.gif";
	else if ( selcnt == 0 ) 
		document.getElementById("chkimg"+selidx).src = "image/checked_none.gif";
	else
		document.getElementById("chkimg"+selidx).src = "image/checked_partial.gif";
}
</script>
<body onload="init();">
<FORM autocomplete=off id="frm" name=frmtimeout method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=backname>
<input type=hidden name=wf_cate>
<div class=content_layer id=divcontent>
<iframe id=loadstatus height=0 width=0 name=iframe1 frameborder=0 scrolling=no style=display:none></iframe>
<TABLE class=CONTENT_TABLE>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(filter.webfilter),"colspan=2");</script></TR>
  <TR><TD colspan=2>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(filter.categories));</script></TR>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR>
                	<TD valign=top width=100px style="padding-right:10px;"><TABLE>
                <TR><TD><input type=radio name=wf_policy_level value=high checked onclick=set_data(0,0)><script>Capture(def.high);</script></TD></TR>
                <TR><TD><input type=radio name=wf_policy_level value=medium onclick=set_data(1,0)><script>Capture(def.medium);</script></TD></TR>
                <TR><TD><input type=radio name=wf_policy_level value=low onclick=set_data(2,0)><script>Capture(def.low);</script></TD></TR>
                <TR><TD><input type=radio name=wf_policy_level value=custom onclick=set_data(3,0)><script>Capture(wwan.custom);</script></TD></TR>
			</TABLE></TD>
                	<TD valign=top><TABLE>
		<script>
			tmp=0;
			for(var i=0; i<cate_list.length; i++)
			{
			
				if ( cate_list[i+1] && cate_list[i] && (i==0 || cate_list[i].group != cate_list[i+1].group) ) 
				{
					if ( i == cate_list.length-1 || cate_list[i].group != cate_list[i+1].group ) tmp++;
					document.write("<TR><TD><TABLE>");
					document.write("<TR><TD align=left width=220px><TABLE><TR><TD><img id='chkimg"+tmp+"' src='image/checked_none.gif' style='padding-right:10px' onclick=click_mchk("+tmp+")></TD><TD>"+cate_list[i+1].group+"("+cnt[tmp]+")</TD>");
					document.write("<TD style='padding-left:5px' align=left><img id='img"+tmp+"' src=image/drawerTriangleCollapsed.gif width=15px height=27px onclick=show_item('subitem"+tmp+"','"+tmp+"')></TD></TR></TABLE></TD><TD></TD></TR>");
					document.write("<TR style='display:none' id='subitem"+tmp+"'><TD colspan=3 width=100%><TABLE>");
					var startj = (i==0?j=i:j=i+1);
					var endj = (i==0?0:1);
					for(j=startj; j<cnt[tmp]+i+endj; j++)
					{
						document.write("<TR><TD style='padding-left:20px;' width=200px nowrap><input type=checkbox name='chk"+cate_list[j].id+"' id='chk"+cate_list[j].id+"' onclick=chg_main_st("+tmp+","+startj+","+parseInt(parseInt(cnt[tmp],10)+i+parseInt(endj,10),10)+")>"+cate_list[j].item+"</TD>");
						document.write("<TD style='padding-left:10px'>"+cate_list[j].desc+"</TD></TR>");
					}
					document.write("</TABLE></TD></TR>");
					document.write("<TR id='hr2"+tmp+"'><TD colspan=2><HR size=1 class=ISHR></TD><TD></TD></TR>");
					document.write("</TABLE></TD></TR>");
				}
			}
		</script>
			</TABLE></TD>
                </TR>
</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2");</script>
		<script>
		draw_object(O_GUI,BT,__T(filter.restorecate),"r1","BT","to_restore(this.form)");
		</script>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_M,"colspan=2",SPACE_DOWN,SPACE_DOWN);</script></TD></TR>
		</TABLE>
  </TD></TR>
		<% web_include_file("BT.asp"); %>
</TABLE>
</div>
</form>
<!--Start of Connect Successful div --> 
</body></HTML>
