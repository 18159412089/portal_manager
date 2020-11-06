<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>空气站点气象小时数据管理</title> 
	<#include "/header.ftl"/>
</head>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div  id="searchBar" class="searchBar">
				<form id="searchForm">
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="字典类型">点位代码:</label>
                        <input id="queryPOTCODE" name="POTCODE" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="点位名称">点位名称:</label>
                        <input id="queryPOTNAME" name="POTNAME" class="easyui-textbox" style="width: 200px;">
					</div>
					<!-- <input id="queryCHECKTIME" name="CHECKTIME" class="easyui-datebox" data-options="editable:false" label="监测时间:" style="width:220px;"> -->
                    <!-- <label  class="textbox-label textbox-label-before" title="字典类型">所属地市:</label>
					<input id="querySAREANAME" name="SAREANAME" class="easyui-textbox" style="width: 200px;"> -->
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="区县">区县:</label>
                        <!-- <input id="queryAREANAME" name="AREANAME" class="easyui-textbox" style="width: 200px;"> -->
                        <input id="queryAREANAME" class="easyui-combobox" name="AREANAME" style="width: 200px;" data-options="
                        url:'${request.contextPath}/air/airSiteHourData/getCity',
                        method:'post',
                        editable:false,
                        valueField:'uuid',
                        textField:'name',
                        multiple:false,
                        panelHeight:'auto'">
					</div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newAirSiteHourData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editAirSiteHourData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteAirSiteHourData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/air/airSiteHourData/airSiteHourDataList"
				data-options="
					rownumbers:false,
					singleSelect:true,
					striped:true,
					autoRowHeight:false,
					fitColumns:false,
					fit:true,
					pagination:true,
					pageSize:10,
					pageList:[10,30,50]">
			<thead>
				<tr>
					<th field="potcode" width="10%">点位代码</th>
					<th field="potname" width="10%">点位名称</th>
					<!-- <th field="poscode" width="10%">行政区划</th>
					<th field="sareaname" width="10%">所属地市</th>
					<th field="areaname" width="10%">区县</th> -->
					<th field="checktime" width="10%" formatter="Ams.timeDateFormat">监测时间</th>
					<th field="winddirt" width="9%">风向</th>
					<th field="windspd" width="9%">风速(m/s)</th>
					<th field="temp" width="9%">温度(°C)</th>
					<th field="humi" width="9%">湿度(RH)</th>
					<th field="pressure" width="9%">气压(Pa)</th>
					<th field="rainfall" width="9%">降雨量(mm)</th>
					<th field="state" width="10%">状态</th>
					<th field="operate" width="8%" formatter ="formatView">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="uuid" hidden="true" /> 
			<div style="margin-bottom: 10px">
				<input name="WINDDIRT" id="WINDDIRT" class="easyui-textbox" required="true" label="风向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="AREANAME" id="AREANAME" class="easyui-textbox" required="true" label="区县:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STATE" id="STATE" class="easyui-textbox" required="true" label="状态:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="RAINFALL" id="RAINFALL" class="easyui-textbox" required="true" label="降雨量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POSCODE" id="POSCODE" class="easyui-textbox" required="true" label="点位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WINDSPD" id="WINDSPD" class="easyui-textbox" required="true" label="风速:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POTCODE" id="POTCODE" class="easyui-textbox" required="true" label="点位代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SAREANAME" id="SAREANAME" class="easyui-textbox" required="true" label="所属地市:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TEMP" id="TEMP" class="easyui-textbox" required="true" label="温度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PRESSURE" id="PRESSURE" class="easyui-textbox" required="true" label="气压:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POTNAME" id="POTNAME" class="easyui-textbox" required="true" label="点位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HUMI" id="HUMI" class="easyui-textbox" required="true" label="湿度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CHECKTIME" id="CHECKTIME" class="easyui-textbox" required="true" label="监测时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveAirSiteHourData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">点位代码</td>
		                <td class="con">
		                	<input id="POTCODE" name="POTCODE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">点位名称</td>
						<td class="con">
							<input id="POTNAME" name="POTNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">行政区划</td>
		                <td class="con">
		                	<input id="POSCODE" name="POSCODE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">监测时间</td>
						<td class="con">
							<input id="CHECKTIME_detail" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">属地市</td>
		                <td class="con">
		                	<input id="SAREANAME" name="SAREANAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">区县</td>
						<td class="con">
							<input id="AREANAME" name="AREANAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">风向</td>
		                <td class="con">
		                	<input id="WINDDIRT" name="WINDDIRT" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">风速</td>
						<td class="con">
							<input id="WINDSPD" name="WINDSPD" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">温度</td>
		                <td class="con">
		                	<input id="TEMP" name="TEMP" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">湿度</td>
						<td class="con">
							<input id="HUMI" name="HUMI" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">气压</td>
		                <td class="con">
		                	<input id="PRESSURE" name="PRESSURE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">降雨量</td>
						<td class="con">
							<input id="RAINFALL" name="RAINFALL" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">状态</td>
		                <td class="con">
		                	<input id="STATE" name="STATE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		        </tbody>
		    </table>
		</form>
	</div>
	
	<div id="dlg-detail-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-detail').dialog('close')" style="width: 90px">返回</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};
		
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		
		function doSearch() {
			$('#dg').datagrid('load', {
				POTCODE: $("#queryPOTCODE").val().trim(),
				POTNAME: $("#queryPOTNAME").val().trim(),
				/* CHECKTIME: $("#queryCHECKTIME").val().trim(), 
				SAREANAME: $("#querySAREANAME").val().trim(),*/
				AREANAME: $("#queryAREANAME").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newAirSiteHourData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增空气站点气象小时数据');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/air/airSiteHourData/saveAirSiteHourData';
		}

		function editAirSiteHourData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/air/airSiteHourData/getAirSiteHourData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改空气站点气象小时数据');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/air/airSiteHourData/saveAirSiteHourData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveAirSiteHourData() {
			$('#fm').form('submit', {
				url: url,
				onSubmit: function () {
					return $(this).form('validate');
				},
				success: function (result) {
					var result = JSON.parse(result);
					if (result.type == 'E') {
						Ams.error(result.message);
					} else {
						$('#dlg').dialog('close');
						$('#dg').datagrid('load');
					}
				}
			});
		}

		function deleteAirSiteHourData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/air/airSiteHourData/deleteAirSiteHourData',
							data: {'uuid': row.uuid},
							success: function (result) {
								var result = eval(result);
								if (result.type == 'E') {
									Ams.error(result.message);
								} else {
									$('#dg').datagrid('load');
								}
							},
							dataType: 'json'
						});
					}
				});
			} else {
				$.messager.alert('提示', '请选择一条要删除的记录！');
			}
		}
		function formatView(value,row){
			var rowId = row.potcode+"_"+row.checktime;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/air/airSiteHourData/getAirSiteHourData',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '站点气象小时数据明细');
					$('#fm-detail').form('load', result);
					$('#CHECKTIME_detail').val(Ams.dateFormat(result.CHECKTIME));
				},
			dataType: 'json'
			});
		}

		function exportData() {
			var queryPOTCODE = $("#queryPOTCODE").val().trim()
			var queryPOTNAME = $("#queryPOTNAME").val().trim()
			var queryAREANAME = $("#queryAREANAME").val().trim()
			$('#dg').datagrid('load', {
				POTCODE: $("#queryPOTCODE").val().trim(),
				POTNAME: $("#queryPOTNAME").val().trim(),
				/* CHECKTIME: $("#queryCHECKTIME").val().trim(),
				SAREANAME: $("#querySAREANAME").val().trim(),*/
				AREANAME: $("#queryAREANAME").val().trim()
			});
			window.open(Ams.ctxPath + '/air/airSiteHourData/getListExport?POTCODE='+queryPOTCODE+'&POTNAME='+queryPOTNAME+'&AREANAME='+queryAREANAME);
		}
		
</script>
</body>
</html>
