<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>入海河流监测数据管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div  id="searchBar" class="searchBar">
				<form id="searchForm">
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="站点编码">站点编码:</label>
                        <input id="queryPOINTCODE" name="POINTCODE" class="easyui-textbox" style="width: 170px">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
                       <input id="queryPOINTNAME" name="POINTNAME" class="easyui-textbox" style="width: 170px">
				   </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="污染物名称">污染物名称:</label>
                      <input id="queryPOLLUTENAME" name="POLLUTENAME" class="easyui-textbox" style="width: 170px">
				  </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="污染物编码">污染物编码:</label>
                       <input id="queryCodePollute" name="codePollute" class="easyui-textbox" style="width: 170px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="污染物浓度">污染物浓度:</label>
                       <input id="queryPOLLUTEVALUE" name="POLLUTEVALUE" class="easyui-textbox" style="width: 170px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiversSiteMonitorData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiversSiteMonitorData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiversSiteMonitorData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rivers/riversSiteMonitorData/riversSiteMonitorDataList"
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
					<th formatter="Ams.tooltipFormat" field="pointname" width="10%">站点名称</th>
					<th formatter="Ams.tooltipFormat" field="pollutename" width="10%">污染物名称</th>
					<th formatter="Ams.tooltipFormat" field="codePollute" width="10%">污染物编码</th>
					<th formatter="Ams.tooltipFormat" field="monitortime" width="10%">监测时间</th>
					<th formatter="Ams.tooltipFormat" field="pollutevalue" width="10%">污染物浓度</th>
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
				<input name="POLLUTENAME" id="POLLUTENAME" class="easyui-textbox" required="true" label="污染物名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codePollute" id="codePollute" class="easyui-textbox" required="true" label="污染物编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="MONITORTIME" id="MONITORTIME" class="easyui-textbox" required="true" label="监测时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POLLUTEVALUE" id="POLLUTEVALUE" class="easyui-textbox" required="true" label="污染物浓度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POINTNAME" id="POINTNAME" class="easyui-textbox" required="true" label="站点名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiversSiteMonitorData()" style="width: 90px">保存</a>
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
				POLLUTENAME: $("#queryPOLLUTENAME").val().trim(),
				codePollute: $("#queryCodePollute").val().trim(),
			 
				POLLUTEVALUE: $("#queryPOLLUTEVALUE").val().trim(),
				POINTNAME: $("#queryPOINTNAME").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiversSiteMonitorData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增入海河流监测数据');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rivers/riversSiteMonitorData/saveRiversSiteMonitorData';
		}

		function editRiversSiteMonitorData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rivers/riversSiteMonitorData/getRiversSiteMonitorData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改入海河流监测数据');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rivers/riversSiteMonitorData/saveRiversSiteMonitorData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiversSiteMonitorData() {
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

		function deleteRiversSiteMonitorData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rivers/riversSiteMonitorData/deleteRiversSiteMonitorData',
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
			POINTCODE: $("#queryPOINTCODE").val().trim(),
			window.open(Ams.ctxPath + '/rivers/riversSiteMonitorData/getListExport' +
					'?POINTCODE='+$("#queryPOINTCODE").val().trim()+
					'&POLLUTENAME='+$("#queryPOLLUTENAME").val().trim()+
					'&codePollute='+$("#queryCodePollute").val().trim()+
					'&POLLUTEVALUE='+$("#queryPOLLUTEVALUE").val().trim()+
					'&POINTNAME='+$("#queryPOINTNAME").val().trim());
		}
</script>
</body>
</html>
