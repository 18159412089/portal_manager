<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>企业产废贮存信息管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="贮存仓库名称">贮存仓库名称:</label>
                        <input id="queryStorageName" name="storageName" class="easyui-textbox" style="width: 200px;">
					</div>
					<div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="危废重量单位">危废重量单位:</label>
                        <input id="queryUnit" name="unit" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="企业名称">企业名称:</label>
                       <input id="queryEntname" name="entname" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="危废俗称">危废俗称:</label>
                        <input id="queryWasteName" name="wasteName" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="固废系统企业">固废系统企业:</label>
                        <input id="queryEnterpriseId" name="enterpriseId" class="easyui-textbox" style="width: 200px;"><br/>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="危废产生贮存量">危废产生贮存量:</label>
                        <input id="queryQuantity" name="quantity" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="危废八位代码">危废八位代码:</label>
                        <input id="queryCode" name="code" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="产废企业">产废企业:</label>
                        <input id="queryEnterpriseAttribute" name="enterpriseAttribute" class="easyui-textbox" style="width: 200px;">
					</div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newEnterpriseWasteInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editEnterpriseWasteInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteEnterpriseWasteInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/haz/enterpriseWasteInfo/enterpriseWasteInfoList"
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
					<th field="entname" width="15%" formatter="Ams.tooltipFormat">企业名称</th>
					<th field="code" width="10%" formatter="Ams.tooltipFormat">危废代码</th>
					<th field="wasteName" width="10%" formatter="Ams.tooltipFormat">危废俗称</th>
					<th field="storageName" width="10%" formatter="Ams.tooltipFormat">贮存仓库名称</th>
					<th field="unit" width="10%" formatter="Ams.tooltipFormat">危废重量单位</th>
					<th field="quantity" width="10%" formatter="Ams.tooltipFormat">危废产生贮存量</th>
					<th field="enterpriseAttribute" width="10%" formatter="Ams.tooltipFormat">产废企业</th>
					<th field="createdTime" width="12%" formatter="Ams.timeDateFormat">企业创建时间</th>
					<th field="updatetime" width="12%" formatter="Ams.timeDateFormat">更新时间</th>
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
				<input name="storageName" id="storageName" class="easyui-textbox" required="true" label="贮存仓库名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="unit" id="unit" class="easyui-textbox" required="true" label="危废重量单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="entname" id="entname" class="easyui-textbox" required="true" label="企业名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wasteName" id="wasteName" class="easyui-textbox" required="true" label="危废俗称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="enterpriseId" id="enterpriseId" class="easyui-textbox" required="true" label="固废系统企业id:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetime" id="updatetime" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="quantity" id="quantity" class="easyui-textbox" required="true" label="危废产生贮存量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="createdTime" id="createdTime" class="easyui-textbox" required="true" label="企业创建时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="code" id="code" class="easyui-textbox" required="true" label="危废八位代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="enterpriseAttribute" id="enterpriseAttribute" class="easyui-textbox" required="true" label="QYSX_CF 产废企业:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveEnterpriseWasteInfo()" style="width: 90px">保存</a>
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
				storageName: $("#queryStorageName").val().trim(),
				unit: $("#queryUnit").val().trim(),
				entname: $("#queryEntname").val().trim(),
				wasteName: $("#queryWasteName").val().trim(),
				enterpriseId: $("#queryEnterpriseId").val().trim(),
				 
				quantity: $("#queryQuantity").val().trim(),
			 
				code: $("#queryCode").val().trim(),
				enterpriseAttribute: $("#queryEnterpriseAttribute").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newEnterpriseWasteInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增企业产废贮存信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/haz/enterpriseWasteInfo/saveEnterpriseWasteInfo';
		}

		function editEnterpriseWasteInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/haz/enterpriseWasteInfo/getEnterpriseWasteInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改企业产废贮存信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/haz/enterpriseWasteInfo/saveEnterpriseWasteInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveEnterpriseWasteInfo() {
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

		function deleteEnterpriseWasteInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/haz/enterpriseWasteInfo/deleteEnterpriseWasteInfo',
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
			window.open(Ams.ctxPath + '/haz/enterpriseWasteInfo/getListExport' +
					'?storageName='+$("#queryStorageName").val().trim()+
					'&unit='   +$("#queryUnit").val().trim()+
					'&entname='+$("#queryEntname").val().trim()+
					'&wasteName='+$("#queryWasteName").val().trim()+
					'&enterpriseId='+$("#queryEnterpriseId").val().trim()+
					'&quantity='+$("#queryQuantity").val().trim()+
					'&code='+$("#queryCode").val().trim()+
					'&enterpriseAttribute='+$("#queryEnterpriseAttribute").val().trim());
		}
</script>
</body>
</html>
