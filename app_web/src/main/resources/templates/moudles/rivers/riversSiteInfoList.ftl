<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>入海河流点位信息管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
                    <label class="control-label">站点编码:</label>
					<input id="queryPOINTCODE" name="POINTCODE" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">行政区编码:</label>
					<input id="queryCodeRegion" name="codeRegion" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">经度:</label>
					<input id="queryLONGITUDE" name="LONGITUDE" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">流域名称:</label>
					<input id="queryWSYSTEMNAME" name="WSYSTEMNAME" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">行政区名称:</label>
					<input id="queryREGIONNAME" name="REGIONNAME" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">流域编码:</label>
					<input id="queryCodeWsystem" name="codeWsystem" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">纬度:</label>
					<input id="queryLATITUDE" name="LATITUDE" class="easyui-textbox" style="width: 200px;">
                    <label class="control-label">站点名称:</label>
					<input id="queryPOINTNAME" name="POINTNAME" class="easyui-textbox" style="width: 200px;">
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiversSiteInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiversSiteInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiversSiteInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rivers/riversSiteInfo/riversSiteInfoList"
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
					<th formatter="Ams.tooltipFormat" field="pointcode" width="10%">站点编码</th>
					<th formatter="Ams.tooltipFormat" field="codeRegion" width="10%">行政区编码</th>
					<th formatter="Ams.tooltipFormat" field="longitude" width="10%">经度</th>
					<th formatter="Ams.tooltipFormat" field="wsystemname" width="10%">流域名称</th>
					<th formatter="Ams.tooltipFormat" field="regionname" width="10%">行政区名称</th>
					<th formatter="Ams.tooltipFormat" field="codeWsystem" width="10%">流域编码</th>
					<th formatter="Ams.tooltipFormat" field="latitude" width="10%">纬度</th>
					<th formatter="Ams.tooltipFormat" field="pointname" width="10%">站点名称</th>
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
				<input name="POINTCODE" id="POINTCODE" class="easyui-textbox" required="true" label="站点编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeRegion" id="codeRegion" class="easyui-textbox" required="true" label="行政区编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LONGITUDE" id="LONGITUDE" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WSYSTEMNAME" id="WSYSTEMNAME" class="easyui-textbox" required="true" label="流域名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="REGIONNAME" id="REGIONNAME" class="easyui-textbox" required="true" label="行政区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeWsystem" id="codeWsystem" class="easyui-textbox" required="true" label="流域编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LATITUDE" id="LATITUDE" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POINTNAME" id="POINTNAME" class="easyui-textbox" required="true" label="站点名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiversSiteInfo()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
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
				POINTCODE: $("#queryPOINTCODE").val().trim(),
				codeRegion: $("#queryCodeRegion").val().trim(),
				LONGITUDE: $("#queryLONGITUDE").val().trim(),
				WSYSTEMNAME: $("#queryWSYSTEMNAME").val().trim(),
				REGIONNAME: $("#queryREGIONNAME").val().trim(),
				codeWsystem: $("#queryCodeWsystem").val().trim(),
				LATITUDE: $("#queryLATITUDE").val().trim(),
				POINTNAME: $("#queryPOINTNAME").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiversSiteInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增入海河流点位信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rivers/riversSiteInfo/saveRiversSiteInfo';
		}

		function editRiversSiteInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rivers/riversSiteInfo/getRiversSiteInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改入海河流点位信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rivers/riversSiteInfo/saveRiversSiteInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiversSiteInfo() {
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

		function deleteRiversSiteInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rivers/riversSiteInfo/deleteRiversSiteInfo',
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

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rivers/riversSiteInfo/getListExport' +
					'?POINTCODE='+$("#queryPOINTCODE").val().trim()+
					'&codeRegion='+$("#queryCodeRegion").val().trim()+
					'&LONGITUDE='+$("#queryLONGITUDE").val().trim()+
					'&WSYSTEMNAME='+$("#queryWSYSTEMNAME").val().trim()+
					'&REGIONNAME='+$("#queryREGIONNAME").val().trim()+
					'&codeWsystem='+$("#queryCodeWsystem").val().trim()+
					'&LATITUDE='+$("#queryLATITUDE").val().trim()+
					'&POINTNAME='+$("#queryPOINTNAME").val().trim());
		}
</script>
</body>
</html>
