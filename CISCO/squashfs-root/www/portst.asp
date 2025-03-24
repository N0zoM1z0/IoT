<% web_include_file("filelink.asp"); %>
<script>
function to_refresh(F)
{
	parent.refresh();
}
                var bt_list = new Array();
                bt_list[0] = new Array("BT","a1",__T(share.refresh),"to_refresh(this.form)");
                draw_td(O_GUI,CREATE_EDIT_TABLE,"8,15,15",__T(filter.portst),__T(share.port)+","+__T(router.mode)+","+__T(share.sts),"",bt_list,"","","1,2,2");
                var display_name="";
                var datalist = new Array();
                var tmpchk="";
                var tmp = new Array();
                <% get_port_st("datalist"); %>
                for(var i=0; i<4; i++)
                {
                        var port_0 = "<% nvram_get("port_manage_mode_0"); %>";
                        var port_1 = "<% nvram_get("port_manage_mode_1"); %>";
                        var port_2 = "<% nvram_get("port_manage_mode_2"); %>";
                        var port_3 = "<% nvram_get("port_manage_mode_3"); %>";
                        var _name = new Array(__T(router.autoneg),__T(router.half10),__T(router.full10),__T(router.half100),__T(router.full100),__T(router.half1000),__T(router.full1000));
                        var _val = new Array("0","1","2","3","4","5","6");
                        if ( datalist[i] == "100Mbps Full Duplex" ) display_name = __T(router.fullduplex);
                        else if ( datalist[i] == "100Mbps Half Duplex" ) display_name = __T(router.halfduplex);
                        else display_name = datalist[i]; 
                        tmp[0] = new Array("td_port"+i,(i+1),2);
                        tmp[1] = new Array("td_link"+i,_name[eval("port_"+i)==""?0:parseInt(eval("port_"+i),10)],3);
                        tmp[2] = new Array("td_mode"+i,display_name,3);
                        tmp[3] = new Array("","&nbsp;");
                        add_row(i,tmp,"","add",2);
                }
                document.getElementById("tmsg").style.display="none";
</script>
