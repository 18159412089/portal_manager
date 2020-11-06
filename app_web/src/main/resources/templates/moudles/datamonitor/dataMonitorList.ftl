<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>数据监控管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div id="searchBar" class="searchBar">
				<form id="searchForm">
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="业务名称">业务名称:</label>
                       <input id="queryServiceName" name="serviceName" class="easyui-textbox"  style="width: 200px;">
				   </div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="表名称">表名称:</label>
                        <input id="queryTableName" name="tableName" class="easyui-textbox"  style="width: 200px;">
					</div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="来源科室">来源科室:</label>
                        <input id="querySourceDept" name="sourceDept" class="easyui-textbox"  style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="来源系统">来源系统:</label>
                       <input id="querySourceSystem" name="sourceSystem" class="easyui-textbox"  style="width: 200px;">
				   </div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="集成方式">集成方式:</label>
                        <input id="queryIntegratiornWay" name="integratiornWay" class="easyui-textbox"  style="width: 200px;">
					</div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="更新频率">更新频率:</label>
                        <input id="queryUpdateFreq" name="updateFreq" class="easyui-textbox"  style="width: 200px;"><br/>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="数据类型">数据类型:</label>
                        <input id="queryDataType" name="dataType" class="easyui-textbox"  style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="省">省:</label>
                        <input id="queryProvince" name="province" class="easyui-textbox"  style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="市">市:</label>
                       <input id="queryCity" name="city" class="easyui-textbox"  style="width: 200px;">
				   </div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="县">县:</label>
                        <input id="queryCounty" name="county" class="easyui-textbox"  style="width: 200px;">
					</div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="备注">备注:</label>
                        <input id="queryRemark" name="remark" class="easyui-textbox"  style="width: 200px;">
					</div>





					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<div class="optionBar">
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" >
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newDataMonitor()">新增</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editDataMonitor()">修改</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteDataMonitor()">删除</a>
			</@sec.authorize>
			</div>


		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/dataMonitor/DataMonitor/dataMonitorList"
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
					<th field="serviceName" width="10%">业务名称</th>
					<th field="tableName" width="10%">表名称</th>
					<th field="sourceDept" width="10%">来源科室</th>
					<th field="sourceSystem" width="10%">来源系统</th>
					<th field="integratiornWay" width="10%"> 集成方式</th>
					<th field="updateFreq" width="5%">更新频率</th>
					<th field="dataType" width="10%">数据类型</th>
					<th field="province" width="5%">省</th>
					<th field="city" width="5%">市</th>
					<th field="county" width="5%">县</th>
					<th field="remark" width="20%">备注</th>
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
                <input name="serviceName" id="serviceName" class="easyui-textbox" required="true" label="业务名称:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="tableName" id="tableName" class="easyui-textbox" required="true" label="表名称:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="sourceDept" id="sourceDept" class="easyui-textbox" required="true" label="来源科室:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="sourceSystem" id="sourceSystem" class="easyui-textbox" required="true" label="来源系统:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="integratiornWay" id="integratiornWay" class="easyui-textbox" required="true" label=" 集成方式:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="updateFreq" id="updateFreq" class="easyui-textbox" required="true" label="更新频率:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="dataType" id="dataType" class="easyui-textbox" required="true" label="数据类型:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="province" id="province" class="easyui-textbox" required="true" label="省:"
                       style="width: 100%" data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="city" id="city" class="easyui-textbox" required="true" label="市:" style="width: 100%"
                       data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="county" id="county" class="easyui-textbox" required="true" label="县:" style="width: 100%"
                       data-options="">
			</div>
			<div style="margin-bottom: 10px">
                <input name="remark" id="remark" class="easyui-textbox" required="true" label="备注:" style="width: 100%"
                       data-options="">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveDataMonitor()" style="width: 90px">保存</a>
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
				serviceName: $("#queryServiceName").val().trim(),
				tableName: $("#queryTableName").val().trim().toUpperCase(),
				sourceDept: $("#querySourceDept").val().trim(),
				sourceSystem: $("#querySourceSystem").val().trim(),
				integratiornWay: $("#queryIntegratiornWay").val().trim(),
				updateFreq: $("#queryUpdateFreq").val().trim(),
				dataType: $("#queryDataType").val().trim(),
				province: $("#queryProvince").val().trim(),
				city: $("#queryCity").val().trim(),
				county: $("#queryCounty").val().trim(),
				remark: $("#queryRemark").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newDataMonitor() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增数据监控');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/dataMonitor/DataMonitor/saveDataMonitor';
		}

		function editDataMonitor() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/dataMonitor/DataMonitor/getDataMonitor',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改数据监控');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/dataMonitor/DataMonitor/saveDataMonitor';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveDataMonitor() {
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

		function deleteDataMonitor() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/dataMonitor/DataMonitor/deleteDataMonitor',
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
</script>
</body>
</html>
