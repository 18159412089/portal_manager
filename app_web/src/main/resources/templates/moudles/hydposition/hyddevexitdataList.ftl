<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水电站设备出口管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="状态">状态:</label>
                       <input id="querySTATUS" name="STATUS" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="出口名称">出口名称:</label>
                        <input id="queryOutputName" name="outputName" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="出口编码">出口编码:</label>
                        <input id="queryOutputCode" name="outputCode" class="easyui-textbox" style="width: 200px;">
					</div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newHyddevexitdata()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editHyddevexitdata()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteHyddevexitdata()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/hydposition/hyddevexitdata/hyddevexitdataList"
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
					<th field="hydpositoninfo" width="10%" formatter="getEqpName">站点名称</th>
					<th formatter="Ams.tooltipFormat" field="outputName" width="10%">出口名称</th>
					<th formatter="Ams.tooltipFormat" field="outputCode" width="10%">出口编码</th>
					<th formatter="Ams.tooltipFormat" field="minFlow" width="10%">环评要求最小下泄流量(立方米/秒)</th>
					<th formatter="Ams.tooltipFormat" field="STATUS" width="10%">状态</th>
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
				<input name="minFlow" id="minFlow" class="easyui-textbox" required="true" label="环评要求最小下泄流量(立方米/秒):" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="eqpId" id="eqpId" class="easyui-textbox" required="true" label="点位ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="outputId" id="outputId" class="easyui-textbox" required="true" label="出口ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hydropowerId" id="hydropowerId" class="easyui-textbox" required="true" label="设备ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STATUS" id="STATUS" class="easyui-textbox" required="true" label="状态:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="outputName" id="outputName" class="easyui-textbox" required="true" label="出口名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="outputCode" id="outputCode" class="easyui-textbox" required="true" label="出口编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveHyddevexitdata()" style="width: 90px">保存</a>
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
		 
		function getEqpName(val,row){  
		    if(val) return val.eqpName;  
		    else return "";  
		}  
		
		function doSearch() {
			$('#dg').datagrid('load', {
			 
				STATUS: $("#querySTATUS").val().trim(),
				outputName: $("#queryOutputName").val().trim(),
				outputCode: $("#queryOutputCode").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}


		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/hydposition/hyddevexitdata/getListExport' +
					'?STATUS='+$("#querySTATUS").val().trim()+
					'&outputName='+$("#queryOutputName").val().trim()+
					'&outputCode='+$("#queryOutputCode").val().trim());
		}
		
		function newHyddevexitdata() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水电站设备出口');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/hydposition/hyddevexitdata/saveHyddevexitdata';
		}

		function editHyddevexitdata() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/hydposition/hyddevexitdata/getHyddevexitdata',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水电站设备出口');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/hydposition/hyddevexitdata/saveHyddevexitdata';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveHyddevexitdata() {
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

		function deleteHyddevexitdata() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/hydposition/hyddevexitdata/deleteHyddevexitdata',
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
