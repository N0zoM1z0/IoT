<html>
	<head>
	<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
	<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="/css_router.css">
	<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
	<script language="Javascript" src="/lang.js"></script>
	<script language="JavaScript" src="public.js"></script>
	<script language="JavaScript">
		var DataArray_port = new Array();
		var DataArray_ip = new Array();
		var rule_max_num_port = 5;
		var rule_max_num_ip = 8;
	
		function onPageLoad(){
			set_data();
			show_vlan_type();
		}
		
		function set_data(){
			set_checked("<!--# echo vlan_type -->", get_by_name("vlan_type"));
			
			/* set port rule data */
			set_vlan_port_list(); //set data to DataArray
			show_vlan_port_list(); //show DataArray data to table 
			
			/* set ip rule data */
			set_vlan_ip_list(); //set data to DataArray
			show_vlan_ip_list(); //show DataArray data to table 
		}
	
		/* port functions */
		function Data_port(enable, name, num, vid, priority, index){
			this.ENABLE = enable;
			this.NAME = name;
			this.NUM = num;
			this.VID = vid;
			this.PRIORITY = priority;
			this.INDEX = index;
		}

		function set_vlan_port_list(){
			var index = 0;
			for (var i = 0; i < rule_max_num_port; i++){
				var vlan_port;
				var k = i + 1;
				if(parseInt(i) < 10){
					k = "0" + i;
				}
				vlan_port = (get_by_id("vlan_rule_port_" + k).value).split("/");
				
				if (vlan_port.length > 1){
					if(vlan_port[1].length > 0){
						DataArray_port[index] = new Data_port(vlan_port[0], vlan_port[1], vlan_port[2], vlan_port[3], vlan_port[4], index);
						index++;
					}
				}
			}
			
			get_by_id("max_row_port").value = DataArray_port.length;
		}
	
		function show_vlan_port_list(){
			var vlan_rule_port_list_table = get_by_id("vlan_rule_port_list_table");
			var is_enable;
			
			/* clear_port_rule */
			clear_port_rule();
		
			/* clear list first */
			for (var i = vlan_rule_port_list_table.rows.length; i > 1; i--){
				vlan_rule_port_list_table.deleteRow(i - 1);
			}
		
			for(var i = 0; i < DataArray_port.length; i++){
				var insert_row = vlan_rule_port_list_table.insertRow(i + 1);
				
				/* set table background color */
				vlan_rule_port_list_table.rows[i + 1].style.backgroundColor = "#FFFFFF";
				
				for (var j = 0; j < 7; j++){						
					var insert_cell = insert_row.insertCell(j); // create a cell
					
					switch(j){
						case 0:
								if(parseInt(DataArray_port[i].ENABLE) == 1){
									is_enable = "checked";
								}else{
									is_enable = "";
								}
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_port_enable(" + i + ")' " + is_enable + ">";	// add data to the cell
							break;							
						case 1:
								insert_cell.className = "centered";
								insert_cell.innerHTML = DataArray_port[i].NAME;	// add data to the cell
							break;
						case 2:		
								insert_cell.className = "centered";			
								
								switch(parseInt(DataArray_port[i].NUM)){
									case 1:
										insert_cell.innerHTML = VLAN_PORT1;	// add data to the cell
									break;
									case 2:
										insert_cell.innerHTML = VLAN_PORT2;	// add data to the cell
									break;
									case 3:
										insert_cell.innerHTML = VLAN_PORT3;	// add data to the cell
									break;
									case 4:
										insert_cell.innerHTML = VLAN_PORT4;	// add data to the cell
									break;
									case 5:
										insert_cell.innerHTML = VLAN_PORT5;	// add data to the cell
									break;
								}	
							break;
						case 3:		
								insert_cell.className = "centered";			
								insert_cell.innerHTML = DataArray_port[i].VID;	// add data to the cell
							break;
						case 4:		
								insert_cell.className = "centered";			
								insert_cell.innerHTML = DataArray_port[i].PRIORITY;	// add data to the cell
							break;	
						case 5:
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<img src=\"/edit.jpg\" width=\"15\" height=\"17\" border=\"0\" alt=\"" + _edit +"\" onClick=\"edit_port_row(" + i + ")\">";	// add data to the cell
							break;
						case 6:
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<img src=\"/delete.jpg\" width=\"15\" height=\"18\" border=\"0\" alt=\"" + _delete + "\" onClick=\"del_port_row(" + i + ")\">";	// add data to the cell
							break;							
					}												
				}
			}						
		}
		
		function clear_port_rule(){
			get_by_id("vlan_rule_port_enable").checked = false;
			get_by_id("vlan_rule_port_name").value = "";
			get_by_id("vlan_rule_port_num").value = "1";
			get_by_id("vlan_rule_port_id").value = "";
			get_by_id("vlan_rule_port_priority").value = "0";
			
			get_by_id("edit_port").value = -1;
		}
	
		function set_port_enable(idx){
			var tmp_vlan_rule_port_enable = DataArray_port[idx].ENABLE;
			var tmp_vlan_rule_port_name = DataArray_port[idx].NAME;
			var tmp_vlan_rule_port_num = DataArray_port[idx].NUM;
			var tmp_vlan_rule_port_id = DataArray_port[idx].VID;
			var tmp_vlan_rule_port_priority = DataArray_port[idx].PRIORITY;
			
			if(parseInt(tmp_vlan_rule_port_enable) == 1){
				tmp_vlan_rule_port_enable = "0";
			}else{
				tmp_vlan_rule_port_enable = "1";	
			}
			
			DataArray_port[idx] = new Data_port(tmp_vlan_rule_port_enable, tmp_vlan_rule_port_name, tmp_vlan_rule_port_num, tmp_vlan_rule_port_id, tmp_vlan_rule_port_priority, idx);
		
			show_vlan_port_list();
		}
		
		function add_port_row(){
			var edit_port = parseInt(get_by_id("edit_port").value);
			var index = DataArray_port.length;
			var tmp_vlan_rule_port_enable;
			if(get_by_id("vlan_rule_port_enable").checked == true){
				tmp_vlan_rule_port_enable = "1";
			}else{
				tmp_vlan_rule_port_enable = "0";	
			}
			var tmp_vlan_rule_port_name = get_by_id("vlan_rule_port_name").value;
			var tmp_vlan_rule_port_num = get_by_id("vlan_rule_port_num").value;
			var tmp_vlan_rule_port_id = get_by_id("vlan_rule_port_id").value;
			var tmp_vlan_rule_port_priority = get_by_id("vlan_rule_port_priority").value;
			
			/* check values */
			if (edit_port == -1){ // add
				if (parseInt(DataArray_port.length) + 1 > rule_max_num_port){
					alert(VLAN_RULES_CHECK);
					return false;
				}
			}
			
			if (get_by_id("vlan_rule_port_name").value.length <= 0){
				alert(GW_SCHEDULES_NAME_INVALID);
				return false;
			}
			
			if (get_by_id("vlan_rule_port_id").value.length <= 0){
				alert(VLAN_ID_BLANK_CHECK);
				return false;
			}
			
			if (parseInt(get_by_id("vlan_rule_port_id").value) < 2 || parseInt(get_by_id("vlan_rule_port_id").value) > 4094){
				alert(VLAN_ID_VALUE_CHECK);
				return false;
			}
			
			/* update DataArray */	
			if (edit_port == -1){ // add	
				DataArray_port[index] = new Data_port(tmp_vlan_rule_port_enable, tmp_vlan_rule_port_name, tmp_vlan_rule_port_num, tmp_vlan_rule_port_id, tmp_vlan_rule_port_priority, index);
				get_by_id("max_row_port").value = index + 1;
			}else{ // modify
				DataArray_port[edit_port] = new Data_port(tmp_vlan_rule_port_enable, tmp_vlan_rule_port_name, tmp_vlan_rule_port_num, tmp_vlan_rule_port_id, tmp_vlan_rule_port_priority, edit_port);
				get_by_id("edit_port").value = -1;
			}
			
			show_vlan_port_list();
		}
		
		function edit_port_row(idx){
			if(DataArray_port[idx].ENABLE == 1){
				get_by_id("vlan_rule_port_enable").checked = true;
			}else{
				get_by_id("vlan_rule_port_enable").checked = false;
			}
			
			get_by_id("vlan_rule_port_name").value = DataArray_port[idx].NAME;
			get_by_id("vlan_rule_port_num").value = DataArray_port[idx].NUM;
			get_by_id("vlan_rule_port_id").value = DataArray_port[idx].VID;
			get_by_id("vlan_rule_port_priority").value = DataArray_port[idx].PRIORITY;
			
			get_by_id("edit_port").value = idx;
			
			change_color("vlan_rule_port_list_table", idx + 1);
		}
		
		function del_port_row(idx){
			var vlan_rule_port_list_table = get_by_id("vlan_rule_port_list_table");
			
			edit_port_row(idx);
			
			if(!confirm(YM25 + " " + DataArray_port[idx].NAME)){
				return;
			}				
			
			DataArray_port = remove_array(DataArray_port, idx); //define in public.js

			get_by_id("max_row_port").value = DataArray_port.length;
			
			show_vlan_port_list();
		}	
		/* port functions */
		
		/* ip functions */
		function Data_ip(enable, name, start, end, field, vid, priority, index){
			this.ENABLE = enable;
			this.NAME = name;
			this.START = start;
			this.END = end;
			this.FIELD = field;
			this.VID = vid;
			this.PRIORITY = priority;
			this.INDEX = index;
		}

		function set_vlan_ip_list(){
			var index = 0;
			for (var i = 0; i < rule_max_num_ip; i++){
				var vlan_ip;
				var k = i + 1;
				if(parseInt(i) < 10){
					k = "0" + i;
				}
				
				vlan_ip = (get_by_id("vlan_rule_ip_" + k).value).split("/");
				
				if (vlan_ip.length > 1){
					if(vlan_ip[1].length > 0){
						DataArray_ip[index] = new Data_ip(vlan_ip[0], vlan_ip[1], vlan_ip[2], vlan_ip[3], vlan_ip[4], vlan_ip[5], vlan_ip[6], index);
						index++;
					}
				}
			}
			
			get_by_id("max_row_ip").value = DataArray_ip.length;
		}
	
		function show_vlan_ip_list(){
			var vlan_rule_ip_list_table = get_by_id("vlan_rule_ip_list_table");
			var is_enable;
			
			/* clear_ip_rule */
			clear_ip_rule();
			
			/* clear list first */
			for (var i = vlan_rule_ip_list_table.rows.length; i > 1; i--){
				vlan_rule_ip_list_table.deleteRow(i - 1);
			}
			
			for(var i = 0; i < DataArray_ip.length; i++){
				var insert_row = vlan_rule_ip_list_table.insertRow(i + 1);
				
				/* set table background color */
				vlan_rule_ip_list_table.rows[i + 1].style.backgroundColor = "#FFFFFF";
																					
				for (var j = 0; j < 8; j++){						
					var insert_cell = insert_row.insertCell(j); // create a cell
					
					switch(j){
						case 0:
								if(parseInt(DataArray_ip[i].ENABLE) == 1){
									is_enable = "checked";
								}else{
									is_enable = "";
								}
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_ip_enable(" + i + ")' " + is_enable + ">";	// add data to the cell
							break;							
						case 1:
								insert_cell.className = "centered";
								insert_cell.innerHTML = DataArray_ip[i].NAME;	// add data to the cell
							break;
						case 2:		
								insert_cell.className = "centered";			
								insert_cell.innerHTML = DataArray_ip[i].START + "<br>" + _to + "<br>" + DataArray_ip[i].END;
								
							break;
						case 3:		
								insert_cell.className = "centered";			
								if(DataArray_ip[i].FIELD == "source"){
									insert_cell.innerHTML = _source;
								}else{
									insert_cell.innerHTML = _destination;
								}
							break;
						case 4:		
								insert_cell.className = "centered";			
								insert_cell.innerHTML = DataArray_ip[i].VID;	// add data to the cell
							break;	
						case 5:		
								insert_cell.className = "centered";			
								insert_cell.innerHTML = DataArray_ip[i].PRIORITY;	// add data to the cell
							break;	
						case 6:
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<img src=\"/edit.jpg\" width=\"15\" height=\"17\" border=\"0\" alt=\"" + _edit +"\" onClick=\"edit_ip_row(" + i + ")\">";	// add data to the cell
							break;
						case 7:
								insert_cell.className = "centered";
								insert_cell.innerHTML = "<img src=\"/delete.jpg\" width=\"15\" height=\"18\" border=\"0\" alt=\"" + _delete + "\" onClick=\"del_ip_row(" + i + ")\">";	// add data to the cell
							break;							
					}												
				}
			}						
		}
		
		function clear_ip_rule(){
			get_by_id("vlan_rule_ip_enable").checked = false;
			get_by_id("vlan_rule_ip_name").value = "";
			get_by_id("vlan_rule_ip_range_start").value = "";
			get_by_id("vlan_rule_ip_range_end").value = "";
			set_checked("source", get_by_name("vlan_rule_ip_field"));
			get_by_id("vlan_rule_ip_id").value = "";
			get_by_id("vlan_rule_ip_priority").value = "0";
			
			get_by_id("edit_ip").value = -1;
		}
	
		function set_ip_enable(idx){
			var tmp_vlan_rule_ip_enable = DataArray_ip[idx].ENABLE;
			var tmp_vlan_rule_ip_name = DataArray_ip[idx].NAME;
			var tmp_vlan_rule_ip_start = DataArray_ip[idx].START;
			var tmp_vlan_rule_ip_end = DataArray_ip[idx].END;
			var tmp_vlan_rule_ip_field = DataArray_ip[idx].FIELD;
			var tmp_vlan_rule_ip_id = DataArray_ip[idx].VID;
			var tmp_vlan_rule_ip_priority = DataArray_ip[idx].PRIORITY;
			
			if(parseInt(tmp_vlan_rule_ip_enable) == 1){
				tmp_vlan_rule_ip_enable = "0";
			}else{
				tmp_vlan_rule_ip_enable = "1";	
			}
			
			DataArray_ip[idx] = new Data_ip(tmp_vlan_rule_ip_enable, tmp_vlan_rule_ip_name, tmp_vlan_rule_ip_start, tmp_vlan_rule_ip_end, tmp_vlan_rule_ip_field, tmp_vlan_rule_ip_id, tmp_vlan_rule_ip_priority, idx);
		
			show_vlan_ip_list();
		}
		
		function add_ip_row(){
			var edit_ip = parseInt(get_by_id("edit_ip").value);
			var index = DataArray_ip.length;
			var tmp_vlan_rule_ip_enable;
			if(get_by_id("vlan_rule_ip_enable").checked == true){
				tmp_vlan_rule_ip_enable = "1";
			}else{
				tmp_vlan_rule_ip_enable = "0";	
			}
			var tmp_vlan_rule_ip_name = get_by_id("vlan_rule_ip_name").value;
			var tmp_vlan_rule_ip_start = get_by_id("vlan_rule_ip_range_start").value;
			var tmp_vlan_rule_ip_end = get_by_id("vlan_rule_ip_range_end").value;
			var tmp_vlan_rule_ip_field;
			if(get_by_name("vlan_rule_ip_field")[0].checked == true){
				tmp_vlan_rule_ip_field = "source";
			}else{
				tmp_vlan_rule_ip_field = "destination";	
			}
			var tmp_vlan_rule_ip_id = get_by_id("vlan_rule_ip_id").value;
			var tmp_vlan_rule_ip_priority = get_by_id("vlan_rule_ip_priority").value;
			
			/* check values */
			if (edit_ip == -1){ // add
				if (parseInt(DataArray_ip.length) + 1 > rule_max_num_ip){
					alert(VLAN_RULES_CHECK);
					return false;
				}
			}
			
			if (get_by_id("vlan_rule_ip_name").value.length <= 0){
				alert(GW_SCHEDULES_NAME_INVALID);
				return false;
			}
			
			if(iprange_range_check(tmp_vlan_rule_ip_start + "-" + tmp_vlan_rule_ip_end) == -1){
				return false;
			}
			
			if (get_by_id("vlan_rule_ip_id").value.length <= 0){
				alert(VLAN_ID_BLANK_CHECK);
				return false;
			}
			
			if (parseInt(get_by_id("vlan_rule_ip_id").value) < 2 || parseInt(get_by_id("vlan_rule_ip_id").value) > 4094){
				alert(VLAN_ID_VALUE_CHECK);
				return false;
			}
			
			/* update DataArray */				
			if (edit_ip == -1){			//add 
				DataArray_ip[index] = new Data_ip(tmp_vlan_rule_ip_enable, tmp_vlan_rule_ip_name, tmp_vlan_rule_ip_start, tmp_vlan_rule_ip_end, tmp_vlan_rule_ip_field, tmp_vlan_rule_ip_id, tmp_vlan_rule_ip_priority, index);
				get_by_id("max_row_ip").value = index + 1;
			}else{ //modify
				DataArray_ip[edit_ip] = new Data_ip(tmp_vlan_rule_ip_enable, tmp_vlan_rule_ip_name, tmp_vlan_rule_ip_start, tmp_vlan_rule_ip_end, tmp_vlan_rule_ip_field, tmp_vlan_rule_ip_id, tmp_vlan_rule_ip_priority, edit_ip);
				get_by_id("edit_ip").value = -1;
			}
			
			show_vlan_ip_list();
		}
		
		function edit_ip_row(idx){
			if(DataArray_ip[idx].ENABLE == 1){
				get_by_id("vlan_rule_ip_enable").checked = true;
			}else{
				get_by_id("vlan_rule_ip_enable").checked = false;
			}
			
			get_by_id("vlan_rule_ip_name").value = DataArray_ip[idx].NAME;
			get_by_id("vlan_rule_ip_range_start").value = DataArray_ip[idx].START;
			get_by_id("vlan_rule_ip_range_end").value = DataArray_ip[idx].END;
			
			set_checked(DataArray_ip[idx].FIELD, get_by_name("vlan_rule_ip_field"));
			
			get_by_id("vlan_rule_ip_id").value = DataArray_ip[idx].VID;
			
			get_by_id("vlan_rule_ip_priority").value = DataArray_ip[idx].PRIORITY;
			
			get_by_id("edit_ip").value = idx;
			
			change_color("vlan_rule_ip_list_table", idx + 1);
		}
		
		function del_ip_row(idx){
			var vlan_rule_ip_list_table = get_by_id("vlan_rule_ip_list_table");
			
			edit_ip_row(idx);
			
			if(!confirm(YM25 + " " + DataArray_ip[idx].NAME)){
				return;
			}				
			
			DataArray_ip = remove_array(DataArray_ip, idx); //define in public.js

			get_by_id("max_row_ip").value = DataArray_ip.length;
			
			show_vlan_ip_list();
		}	
		
		/* ip functions */
		
		function show_vlan_type(){
			var vlan_type = get_by_name("vlan_type");
			var vlan_port_enable;
			var vlan_ip_enable;
			
			if (vlan_type[0].checked){ //port
				vlan_port_enable = "";
				vlan_ip_enable = "none";
			}else{ //ip
				vlan_port_enable = "none";
				vlan_ip_enable = "";
			}
			
			get_by_id("vlan_rule_port").style.display = vlan_port_enable;
			get_by_id("vlan_rule_port_list").style.display = vlan_port_enable;
			get_by_id("vlan_rule_ip").style.display = vlan_ip_enable;
			get_by_id("vlan_rule_ip_list").style.display = vlan_ip_enable;
		}	
		
		function update_data(){
			var max_row_port = parseInt(get_by_id("max_row_port").value) ;
			var max_row_ip = parseInt(get_by_id("max_row_ip").value) ;
			var vlan_type = get_by_name("vlan_type");
			
			if (vlan_type[0].checked){ //port
				/* clear port column */
				for(var ii = 0; ii < rule_max_num_port; ii++){
					if (ii < 10){
						get_by_id("vlan_rule_port_0" + ii).value = "";
					}else{
						get_by_id("vlan_rule_port_" + ii).value = "";
					}
				}
				
				/* copy port data */
				for(var ii = 0; ii < max_row_port; ii++){
					if(DataArray_port[ii].NAME != ""){
						var dat = DataArray_port[ii].ENABLE +"/"+ DataArray_port[ii].NAME +"/"+ DataArray_port[ii].NUM +"/"+ DataArray_port[ii].VID +"/"+ DataArray_port[ii].PRIORITY;
											
						if (parseInt(ii) < 10){
							get_by_id("vlan_rule_port_0" + (ii).toString()).value = dat;
						}else{
							get_by_id("vlan_rule_port_" + (ii)).value = dat;
						}
					}
				}
			}else{ //ip
				/* clear ip column */
				for(var ii = 0; ii < rule_max_num_ip; ii++){
					if (ii < 10){
						get_by_id("vlan_rule_ip_0" + ii).value = "";
					}else{
						get_by_id("vlan_rule_ip_" + ii).value = "";
					}
				}
			
				/* copy ip data */
				for(var ii = 0; ii < max_row_ip; ii++){ //max_row_ip == DataArray_ip.length
					if(DataArray_ip[ii].NAME != ""){
						var dat = DataArray_ip[ii].ENABLE +"/"+ DataArray_ip[ii].NAME +"/"+ DataArray_ip[ii].START +"/"+ DataArray_ip[ii].END +"/"+ DataArray_ip[ii].FIELD +"/"+ DataArray_ip[ii].VID +"/"+ DataArray_ip[ii].PRIORITY;
											
						if (parseInt(ii) < 10){
							get_by_id("vlan_rule_ip_0" + (ii).toString()).value = dat;
						}else{
							get_by_id("vlan_rule_ip_" + (ii)).value = dat;
						}
					}
				}
			}
		
			return true;
		}
		
		function send_request(){
			if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
				return false;
			}
		
			var form = get_by_id("form1");
			form.elements["html_response_message"].value = sc_intro_sv + "<count_down>" + rb_change;
		
			if(!update_data()){
				return false;
			}
			
			disable_all_btn(true);
			send_submit("form1");
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
				<script>show_top("setup");</script>
			</tr>
		</table>
		<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
			<tr>
				<td id="sidenav_container" valign="top" width="125" align="right">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td id="sidenav_container">
								<div id="sidenav">
									<ul>
										<script>show_left("Setup", 6);</script>
									</ul>
								</div>
							</td>			
						</tr>
					</table>			
				</td>
				<td valign="top" id="maincontent_container">
					
					<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
						<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="vlan.asp">
						<!--input type="hidden" id="reboot_type" name="reboot_type" value="application"-->
						<input type="hidden" id="action" name="action" value="vlan">
				
						<input type="hidden" id="vlan_rule_port_00" name="vlan_rule_port_00" value="<!--# echo vlan_rule_port_00 -->">
						<input type="hidden" id="vlan_rule_port_01" name="vlan_rule_port_01" value="<!--# echo vlan_rule_port_01 -->">
						<input type="hidden" id="vlan_rule_port_02" name="vlan_rule_port_02" value="<!--# echo vlan_rule_port_02 -->">
						<input type="hidden" id="vlan_rule_port_03" name="vlan_rule_port_03" value="<!--# echo vlan_rule_port_03 -->">
						<input type="hidden" id="vlan_rule_port_04" name="vlan_rule_port_04" value="<!--# echo vlan_rule_port_04 -->">
						
						<input type="hidden" id="del_port" name="del_port" value="-1">
						<input type="hidden" id="edit_port" name="edit_port" value="-1">
						<input type="hidden" id="max_row_port" name="max_row_port" value="-1">
						
						<input type="hidden" id="vlan_rule_ip_00" name="vlan_rule_ip_00" value="<!--# echo vlan_rule_ip_00 -->">
						<input type="hidden" id="vlan_rule_ip_01" name="vlan_rule_ip_01" value="<!--# echo vlan_rule_ip_01 -->">
						<input type="hidden" id="vlan_rule_ip_02" name="vlan_rule_ip_02" value="<!--# echo vlan_rule_ip_02 -->">
						<input type="hidden" id="vlan_rule_ip_03" name="vlan_rule_ip_03" value="<!--# echo vlan_rule_ip_03 -->">
						<input type="hidden" id="vlan_rule_ip_04" name="vlan_rule_ip_04" value="<!--# echo vlan_rule_ip_04 -->">
						<input type="hidden" id="vlan_rule_ip_05" name="vlan_rule_ip_05" value="<!--# echo vlan_rule_ip_05 -->">
						<input type="hidden" id="vlan_rule_ip_06" name="vlan_rule_ip_06" value="<!--# echo vlan_rule_ip_06 -->">
						<input type="hidden" id="vlan_rule_ip_07" name="vlan_rule_ip_07" value="<!--# echo vlan_rule_ip_07 -->">
						
						<input type="hidden" id="del_ip" name="del_ip" value="-1">
						<input type="hidden" id="edit_ip" name="edit_ip" value="-1">
						<input type="hidden" id="max_row_ip" name="max_row_ip" value="-1">
						
				
						<div id="maincontent">
							<!-- === BEGIN MAINCONTENT === -->
							<div id="box_header"> 
								<h1><script>show_words(VLAN_SETTINGS)</script></h1>
								<script>show_words(VLAN_SETTINGS_DESC1)</script>
								<br>
								<br>
								<script>show_words(VLAN_SETTINGS_DESC2)</script>
								<br><br>
								<input id="button3" name="button3" type="button" class=button_submit value="" onClick="send_request()">
								<input id="button2" name="button2" type=reset class=button_submit value="" onclick="return page_cancel('form1', 'vlan.asp');">
								<script>check_reboot();</script>
								<script>get_by_id("button3").value = _savesettings</script>
								<script>get_by_id("button2").value = _dontsavesettings</script>
							</div>
							
							<!-- VLAN_TYPE -->
							<div class="box">
								<h2><script>show_words(VLAN_TYPE)</script> :</h2>
								<table cellSpacing=1 cellPadding=2 width=525 border=0>
									<tr>
										<td colspan="2"><p><script>show_words(VLAN_TYPE_DESC)</script> :</p></td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(VLAN_TYPE)</script> :</td>
										<td width="340">&nbsp;
											<input type="radio" id="vlan_type" name="vlan_type" value="port_base" onClick="show_vlan_type()" checked>
											<script>show_words(VLAN_TYPE_PORT_BASE);</script>
											<input type="radio" id="vlan_type" name="vlan_type" value="ip_base" onClick="show_vlan_type()" >
											<script>show_words(VLAN_TYPE_IP_BASE);</script>
										</td>
									</tr>
								</table>
							</div>
							<!-- VLAN_TYPE -->
							
							<!-- VLAN_RULE_PORT -->
							<div class="box" id="vlan_rule_port" style="display:none">
								<h2>5 - <script>show_words(VLAN_RULES)</script> :</h2>
								<table cellSpacing=1 cellPadding=2 width=525 border=0>
									<tr>
										<td class="duple"></td>
										<td width="340">&nbsp;
											<input type="checkbox" id="vlan_rule_port_enable" name="vlan_rule_port_enable" value="1" onClick="">
											<script>show_words(_enable)</script>
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(_name)</script> :</td>
										<td width="340">&nbsp;
											<input type="text" id="vlan_rule_port_name" name="vlan_rule_port_name" size="20" maxlength="30" value="">
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(_vs_port)</script> :</td>
										<td width="340">&nbsp;
											<select name="vlan_rule_port_num" id="vlan_rule_port_num" onChange="">
												<option value="1"><script>show_words(VLAN_PORT1)</script></option>
												<option value="2"><script>show_words(VLAN_PORT2)</script></option>
												<option value="3"><script>show_words(VLAN_PORT3)</script></option>
												<option value="4"><script>show_words(VLAN_PORT4)</script></option>
												<option value="5"><script>show_words(VLAN_PORT5)</script></option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(VLAN_ID)</script> :</td>
										<td width="340">&nbsp;
											<input type=text id="vlan_rule_port_id" name="vlan_rule_port_id" size="6" maxlength="4" value="">
											&nbsp;(2~4094)
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(_priority)</script> :</td>
										<td width="340">&nbsp;
											<select name="vlan_rule_port_priority" id="vlan_rule_port_priority" onChange="">
												<option value="0">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="duple">&nbsp;</td>
										<td width="340">&nbsp;
											<input type="button" id="save" name="save" value="Save" onClick="add_port_row()">&nbsp;&nbsp;
											<input type="button" id="clear" name="clear" value="Clear" onClick="clear_port_rule();">
											<script>get_by_id("save").value = _save;</script>
											<script>get_by_id("clear").value = _clear;</script>
										</td>
									</tr>
								</table>
							</div>
							<!-- VLAN_RULE_PORT -->
							
							<!-- VLAN_RULE_IP -->
							<div class="box" id="vlan_rule_ip" style="display:none">
								<h2>8 - <script>show_words(VLAN_RULES)</script> :</h2>
								<table cellSpacing=1 cellPadding=2 width=525 border=0>
									<tr>
										<td class="duple"></td>
										<td width="340">&nbsp;
											<input type="checkbox" id="vlan_rule_ip_enable" name="vlan_rule_ip_enable" value="1" onClick="">
											<script>show_words(_enable)</script>
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(_name)</script> :</td>
										<td width="340">&nbsp;
											<input type="text" id="vlan_rule_ip_name" name="vlan_rule_ip_name" size="20" maxlength="30" value="">
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(VLAN_IP_RANGE)</script> :</td>
										<td width="340">&nbsp;
											<input type=text id="vlan_rule_ip_range_start" name="vlan_rule_ip_range_start" size="20" maxlength="15" value="">
											&nbsp;<script>show_words(_to)</script>&nbsp;
											<input type=text id="vlan_rule_ip_range_end" name="vlan_rule_ip_range_end" size="20" maxlength="15" value="">
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(VLAN_IP_FIELD)</script> :</td>
										<td width="340">&nbsp;
											<input type="radio" id="vlan_rule_ip_field" name="vlan_rule_ip_field" value="source" checked>
											<script>show_words(_source);</script>
											<input type="radio" id="vlan_rule_ip_field" name="vlan_rule_ip_field" value="destination">
											<script>show_words(_destination);</script>
										</td>
									</tr>								
									<tr>
										<td class="duple"><script>show_words(VLAN_ID)</script> :</td>
										<td width="340">&nbsp;
											<input type=text id="vlan_rule_ip_id" name="vlan_rule_ip_id" size="6" maxlength="4" value="">
											&nbsp;(2~4094)
										</td>
									</tr>
									<tr>
										<td class="duple"><script>show_words(_priority)</script> :</td>
										<td width="340">&nbsp;
											<select name="vlan_rule_ip_priority" id="vlan_rule_ip_priority" onChange="">
												<option value="0">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="duple">&nbsp;</td>
										<td width="340">&nbsp;
											<input type="button" id="save" name="save" value="Save" onClick="add_ip_row()">&nbsp;&nbsp;
											<input type="button" id="clear" name="clear" value="Clear" onClick="clear_ip_rule();">
											<script>get_by_id("save").value = _save;</script>
											<script>get_by_id("clear").value = _clear;</script>
										</td>
									</tr>
								</table>
							</div>
							<!-- VLAN_RULE_IP -->
							
							<!-- VLAN_RULE_PORT_LIST -->
							<div class="box" id="vlan_rule_port_list" style="display:none">
								<h2><script>show_words(VLAN_LIST)</script> :</h2>
								<table id="vlan_rule_port_list_table" width="525" border="0" cellPadding="1" cellSpacing="1" bgcolor="#DFDFDF" bordercolor="#FFFFFF">
									<tr>
										<td><div align="center"><strong><script>show_words(_enable);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_name);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_vs_port);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(VLAN_ID);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_priority);</script></strong></div></td>
										<td width="15" valign="top">&nbsp;</td>
	                  <td width="15" valign="top">&nbsp;</td>
									</tr>
								</table>
							</div>
							<!-- VLAN_RULE_PORT_LIST -->
							
							<!-- VLAN_RULE_IP_LIST -->
							<div class="box" id="vlan_rule_ip_list" style="display:none">
								<h2><script>show_words(VLAN_LIST)</script> :</h2>
								<table id="vlan_rule_ip_list_table" width="525" border="0" cellPadding="1" cellSpacing="1" bgcolor="#DFDFDF" bordercolor="#FFFFFF">
									<tr>
										<td><div align="center"><strong><script>show_words(_enable);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_name);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_ipaddr);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(VLAN_IP_FIELD);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(VLAN_ID);</script></strong></div></td>
										<td><div align="center"><strong><script>show_words(_priority);</script></strong></div></td>
										<td width="15" valign="top">&nbsp;</td>
	                  <td width="15" valign="top">&nbsp;</td>
									</tr>
								
								</table>
							</div>
							<!-- VLAN_RULE_IP_LIST -->
							
							
							<!-- === END MAINCONTENT === -->
							<p>&nbsp;</p>
						</div>
			
					</form>
				</td>
				<td valign="top" width="150" id="sidehelp_container" align="left">
					<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
						<tr>
							<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
								<p><script></script></p>
								<p><script></script></p>
								<p class="more"><a href="support_internet.asp#Internet"><script>show_words(_more)</script>&hellip;</a></p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
			<tr>
				<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
				<td width="10">&nbsp;</td><td>&nbsp;</td>
			</tr>
		</table>
		<br>
		<div id="copyright"><script>show_words(_copyright);</script></div>
		<br>
	</body>
	<script>
		reboot_needed(left["Setup"].link[3]);
		onPageLoad();
		set_form_default_values("form1");
	</script>
</html>
