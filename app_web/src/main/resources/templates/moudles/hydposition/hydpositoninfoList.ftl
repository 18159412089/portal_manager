<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水电站点位基本信息管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div id="toolbar">
			<div  id="searchBar" class="searchBar">
				<form id="searchForm">
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="点位名称">点位名称:</label>
                      <input id="queryEqpName" name="eqpName" class="easyui-textbox" style="width: 200px;">
				  </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="是否正在使用">是否正在使用:</label>
                       <input id="queryIsUsed" name="isUsed" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="更新频率">更新频率:</label>
                       <input id="queryCYC" name="CYC" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
		<!--	<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newHydpositoninfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editHydpositoninfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteHydpositoninfo()">删除</a>
			</@sec.authorize>-->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/hydposition/hydpositoninfo/hydpositoninfoList"
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
					<th formatter="Ams.tooltipFormat" field="eqpName" width="10%">点位名称</th>
					<th formatter="Ams.tooltipFormat" field="CYC" width="10%">更新频率</th>
					<th formatter="Ams.tooltipFormat" field="isUsed" width="10%">是否正在使用</th>
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
				<input name="isUsed" id="isUsed" class="easyui-textbox" required="true" label="是否正在使用:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="eqpId" id="eqpId" class="easyui-textbox" required="true" label="点位ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hydropowerId" id="hydropowerId" class="easyui-textbox" required="true" label="设备ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="eqpName" id="eqpName" class="easyui-textbox" required="true" label="点位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CYC" id="CYC" class="easyui-textbox" required="true" label="更新频率:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveHydpositoninfo()" style="width: 90px">保存</a>
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
				isUsed: $("#queryIsUsed").val().trim(),
				eqpName: $("#queryEqpName").val().trim(),
				CYC: $("#queryCYC").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/hydposition/hydpositoninfo/getListExport' +
					'?isUsed='+$("#queryIsUsed").val().trim()+
					'&eqpName='+$("#queryEqpName").val().trim()+
					'&CYC='+$("#queryCYC").val().trim());
		}

		function newHydpositoninfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水电站点位基本信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/hydposition/hydpositoninfo/saveHydpositoninfo';
		}

		function editHydpositoninfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/hydposition/hydpositoninfo/getHydpositoninfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水电站点位基本信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/hydposition/hydpositoninfo/saveHydpositoninfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveHydpositoninfo() {
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

		function deleteHydpositoninfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/hydposition/hydpositoninfo/deleteHydpositoninfo',
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
