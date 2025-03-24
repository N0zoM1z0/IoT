<html>
<head>
<title>Advanced Settings</title>
<% web_include_file("filelink.asp"); %>
</head>
<script>
var en_wmm=0;
<% wl_multi_nvram_get("wl_wme_bss_disable"); %>
for(var i=0; i<4; i++)
{
	if ( eval("nv_wl_wme_bss_disable_"+i) == '0' ) 
	{
		en_wmm=1;
		break;
	}
}		
var wl_net_mode = "<% nvram_get("wl_net_mode"); %>";
function create_nrate(num,F)
{
        var bw20 = new Array("6.5", "13", "19.5", "26", "39", "52", "58.5", "65", "13", "26", "39", "52", "78", "104", "117", "130");
        var bw40 = new Array("13.5", "27", "40.5", "54", "81", "108", "121.5", "135", "27", "54", "81", "108", "162", "216", "243", "270");
        var index = '<% nvram_get("wl_nmcsidx"); %>';

        //F.wl_nmcsidx[0] = new Option("Use Legacy Rate");
        //F.wl_nmcsidx[0].value = "-2";

        F.wl_nmcsidx[0] = new Option(__T(share.auto));
        F.wl_nmcsidx[0].value = "-1";
        
	//if(num == 0 || num == 20) {
	if(num == 20) {
            for(i=0;i<bw20.length;i++) {
                F.wl_nmcsidx[i+1] = new Option(bw20[i]+" "+__T(unit.mbps));
                F.wl_nmcsidx[i+1].value = i;
            }
        }
        else {
            for(i=0;i<bw40.length;i++) {
                F.wl_nmcsidx[i+1] = new Option(bw20[i]+" / "+bw40[i]+" "+__T(unit.mbps));
                F.wl_nmcsidx[i+1].value = i;
            }
        }
        if( wl_net_mode != "n-only" ){
                F.wl_nmcsidx[0].selected = true;
                choose_disable(F.wl_nmcsidx);
        }
        else
                F.wl_nmcsidx[parseInt(index)+1].selected = true;
}

function init(){
	var F = document.wireless;
	var radio = "<% nvram_get("wl_radio"); %>";
	if ( radio == "0" ) 
	{
		DISABLE_PART(F,"all_page_start","all_page_end",1);
	}else{
		default_nv = keep_val(F,skip_name);
		if(F.wl_nmcsidx) create_nrate('<% nvram_get("wl_nbw"); %>',F);
		if ( wl_net_mode == "n-only" ) 
			choose_disable(F.wl_rate);
		else 
			choose_disable(F.wl_nmcsidx);
		if ( en_wmm == 0 ) choose_disable(F._wl_wme_no_ack);
	}
	parent.document.getElementById("save_bg").style.display="none";
	default_nv = keep_val(F,"");
}

function valid_check(F){
	var errflg = 0 ;
	if ( !msg_chk_range(F.wl_bcn.value,"wl_bcn",BEACON_START,BEACON_TO,10,IS_FIELD,0,"_bcn") ) errflg = 1;
	if ( !msg_chk_range(F.wl_dtim.value,"wl_dtim",DTIM_START,DTIM_TO,10,IS_FIELD,0,"_dtim") ) errflg = 1;
	if ( !msg_chk_range(F.wl_frag.value,"wl_frag",FRAG_START,FRAG_TO,10,IS_FIELD,0,"_frag") ) errflg = 1;
	if ( !msg_chk_range(F.wl_rts.value,"wl_rts",RTS_START,RTS_TO,10,IS_FIELD,0,"_rts") ) errflg = 1;
	if ( errflg == 1 ) return false;
	return true;
}

function uiDoSave(F)
{
	if ( !valid_check(F) ) return false;
	F.wl_frameburst.value = "off";
	if ( F._frameburst.checked == true ) 
		F.wl_frameburst.value = "on";
	F.wl_wme_no_ack.value = "off";
	if ( F._wl_wme_no_ack.checked == true ) 
		F.wl_wme_no_ack.value = "on";
	if ( F.wl_gmode_protection[0].checked ) 
	F.wl_nmode_protection.value = F.wl_gmode_protection[0].value;
	else
	F.wl_nmode_protection.value = F.wl_gmode_protection[1].value;
	F.submit_button.value = "Wireless_Advanced";
	F.gui_action.value = "Apply";
	F.submit();	
	parent.document.getElementById("save_bg").style.display="";
}
</script>
<body onload="init();">
<FORM autocomplete=off id=frm method=<% get_http_method(); %> name=wireless action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=submit_type>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name=nvset_cgi value=wireless>
<input type=hidden name=wl_frameburst>
<input type=hidden name=wl_wme_no_ack>
<input type=hidden name=wl_nmode_protection>
<div class=content_layer id=divcontent>
<input type=hidden name=all_page_start>
<TABLE class=CONTENT_TABLE cellspacing=0>
  <TR><script>draw_td(O_GUI,MAINFUN, __T(wl.advset));</script></TR>
  <TR><TD colspan=2 class=NOSPACE>
		<TABLE class=CONTENT_GROUP cellspacing=0>
		<TR><script>draw_td(O_GUI,FUNTITLE,__T(wl.advtitle),"colspan=2");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.frameburst));</script>
		<input type=checkbox name=_frameburst <% nvram_match("wl_frameburst", "on", "checked");%>> <script>Capture(share.enable);</script> 

		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.wmm));</script>
                <input type=checkbox name=_wl_wme_no_ack <% nvram_match("wl_wme_no_ack", "on", "checked");%>> <script>Capture(share.enable);</script>
                </td></tr>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.basicrate));</script>
                <script>
                        var NAME = new Array("12","default","all");
                        var STRING = new Array("1-2 "+__T(unit.mbps),__T(def.words),__T(share.all));
			draw_object(O_GUI,SELBOX,"wl_rateset","",STRING,NAME,"<% nvram_get("wl_rateset");%>");
                </script>
               </TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.transrate));</script>
		<script>
                var arr24g = new Array("0","1000000","2000000","5500000","6000000","9000000","11000000","12000000",
                                       "18000000","24000000","36000000","48000000","54000000");
                var val24g = new Array(__T(share.auto),"1","2","5.5","6","9","11","12","18","24","36","48","54");
		for(i=0; i<val24g.length; i++)
		{
			if ( i > 0 ) 
			val24g[i] += " "+__T(unit.mbps);
		}
		draw_object(O_GUI,SELBOX,"wl_rate","",val24g,arr24g,"<% nvram_get("wl_rate");%>");
          </script>
		</td></tr>					
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.ntransrate));</script>
      	    	<SELECT name="wl_nmcsidx" > 
		<!-- Create from javascript -->
		</SELECT>
		</TD></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE_NOSHIFT,__TC(wl.cts));</script>
                <script>
                        var data = new Array("off","auto");
                        var vlist = new Array(__T(share.disabled),__T(share.auto));
                        var selflg = "";
                        var nvgmode = "<% nvram_sif_get("gmode_protection"); %>";
			draw_object(O_GUI,RADIO,"wl_gmode_protection",data,vlist,"<% nvram_get("wl_gmode_protection"); %>");</script>
			
                </script>
                </SELECT>
                </td></tr>
		<TR><script>draw_td(O_GUI,ISHR,"colspan=2;");</script></TR>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.beacon));</script>
                <INPUT maxLength=4 size=5 value='<% nvram_get("wl_bcn"); %>' id="wl_bcn" name="wl_bcn" onblur=msg_chk_range(this.value,"wl_bcn",BEACON_START,BEACON_TO,10,IS_FIELD,0,"_bcn")>&nbsp;<script>document.write(__T(unit.milliseconds)+" "+spell_words(range_def_rule,BEACON_START,BEACON_TO,100));</script>
		<span id=_bcn></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.dtim));</script>
                <INPUT maxLength=3 size=5 name="wl_dtim" id="wl_dtim" value='<% nvram_get("wl_dtim"); %>' onblur=msg_chk_range(this.value,"wl_dtim",DTIM_START,DTIM_TO,10,IS_FIELD,0,"_dtim")>&nbsp;<script>document.write(spell_words(range_def_rule,DTIM_START,DTIM_TO,1));</script>
		<span id=_dtim></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.fragment));</script>
                <INPUT maxLength=4 size=5 name="wl_frag" id="wl_frag" value="<% nvram_get("wl_frag"); %>" onblur=msg_chk_range(this.value,"wl_frag",FRAG_START,FRAG_TO,10,IS_FIELD,0,"_frag")>&nbsp;<script>document.write(spell_words(range_def_rule,FRAG_START,FRAG_TO,2346));</script>
		<span id=_frag></span>
                </td></tr>
		<TR><script>draw_td(O_GUI,SUBTITLE,__TC(wl.rts),"style=padding-bottom:10px","style=padding-bottom:10px");</script>
                <INPUT maxLength=4 size=5 name="wl_rts" id="wl_rts" value="<% nvram_get("wl_rts"); %>" onblur=msg_chk_range(this.value,"wl_rts",RTS_START,RTS_TO,10,IS_FIELD,0,"_rts")>&nbsp;<script>document.write(spell_words(range_def_rule,RTS_START,RTS_TO,2347));</script>
		<span id=_rts></span>
                </td></tr>
		
        </TABLE>
	<% web_include_file("BT.asp"); %>
<input type=hidden name=all_page_end>
</TABLE>
</form>
</body></HTML>
