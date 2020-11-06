<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>危废转移车辆信息管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="车辆方向">车辆方向:</label>
                       <input id="queryDirection" name="direction" class="easyui-textbox" style="width: 150px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆所属公司">车辆所属公司:</label>
                        <input id="queryCompany" name="company" class="easyui-textbox" style="width: 150px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="车辆所在位置描述">车辆所在位置描述:</label>
                       <input id="queryLocation" name="location" class="easyui-textbox" style="width: 150px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="车牌号">车牌号:</label>
                       <input id="queryVno" name="vno" class="easyui-textbox" style="width: 150px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="GPS信息ID">GPS信息ID:</label>
                       <input id="queryMomId" name="momId" class="easyui-textbox" style="width: 150px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆行驶速度">车辆行驶速度:</label>
                        <input id="querySpeed" name="speed" class="easyui-textbox" style="width: 150px;"><br/>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车牌颜色">车牌颜色:</label>
                        <input id="queryVcolor" name="vcolor" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆状态">车辆状态:</label>
                        <input id="queryStatus" name="status" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆位置纬度">车辆位置纬度:</label>
                        <input id="queryY" name="y" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆位置经度">车辆位置经度:</label>
                        <input id="queryX" name="x" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="车辆类型">车辆类型:</label>
                        <input id="queryType" name="type" class="easyui-textbox"style="width: 150px;">
					</div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newTransferCarinfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editTransferCarinfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteTransferCarinfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/haz/transferCarinfo/transferCarinfoList"
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
					<th formatter="Ams.tooltipFormat" field="vno" width="10%">车牌号</th>
					<th formatter="Ams.tooltipFormat" field="company" width="10%">车辆所属公司</th>
					<th formatter="Ams.tooltipFormat" field="direction" width="10%">车辆方向</th>
					<th formatter="Ams.tooltipFormat" field="location" width="10%">车辆所在位置描述</th>
					<th formatter="Ams.tooltipFormat" field="speed" width="10%">车辆行驶速度</th>
					<th formatter="Ams.tooltipFormat" field="vcolor" width="10%">车牌颜色</th>
					<th formatter="Ams.tooltipFormat" field="status" width="10%">车辆状态</th>
					<th formatter="Ams.tooltipFormat" field="y" width="10%">车辆位置纬度</th>
					<th formatter="Ams.tooltipFormat" field="x" width="10%">车辆位置经度</th>
					<th formatter="Ams.tooltipFormat" field="type" width="10%">车辆类型</th>
					<th field="time" width="11%" formatter="Ams.timeDateFormat">GPS时间</th>
					<th field="updatetimeRjwa" width="11%" formatter="Ams.timeDateFormat">更新时间</th>
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
				<input name="direction" id="direction" class="easyui-textbox" required="true" label="车辆方向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="company" id="company" class="easyui-textbox" required="true" label="车辆所属公司:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="location" id="location" class="easyui-textbox" required="true" label="车辆所在位置描述:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="time" id="time" class="easyui-textbox" required="true" label="GPS时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="vno" id="vno" class="easyui-textbox" required="true" label="车牌号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="momId" id="momId" class="easyui-textbox" required="true" label="GPS信息ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="speed" id="speed" class="easyui-textbox" required="true" label="车辆行驶速度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="vcolor" id="vcolor" class="easyui-textbox" required="true" label="车牌颜色:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="status" id="status" class="easyui-textbox" required="true" label="车辆状态:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="y" id="y" class="easyui-textbox" required="true" label="车辆位置纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="x" id="x" class="easyui-textbox" required="true" label="车辆位置经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="type" id="type" class="easyui-textbox" required="true" label="车辆类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveTransferCarinfo()" style="width: 90px">保存</a>
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
				direction: $("#queryDirection").val().trim(),
				company: $("#queryCompany").val().trim(),
				location: $("#queryLocation").val().trim(),
			 
				vno: $("#queryVno").val().trim(),
				momId: $("#queryMomId").val().trim(),
			 
				speed: $("#querySpeed").val().trim(),
				vcolor: $("#queryVcolor").val().trim(),
				status: $("#queryStatus").val().trim(),
				y: $("#queryY").val().trim(),
				x: $("#queryX").val().trim(),
				type: $("#queryType").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newTransferCarinfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增危废转移车辆信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/haz/transferCarinfo/saveTransferCarinfo';
		}

		function editTransferCarinfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/haz/transferCarinfo/getTransferCarinfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改危废转移车辆信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/haz/transferCarinfo/saveTransferCarinfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveTransferCarinfo() {
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

		function deleteTransferCarinfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/haz/transferCarinfo/deleteTransferCarinfo',
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
			window.open(Ams.ctxPath + '/haz/transferCarinfo/getListExport' +
					'?direction='+$("#queryDirection").val().trim()+
					'&company='   +$("#queryCompany").val().trim()+
					'&location='+$("#queryLocation").val().trim()+
					'&vno='+$("#queryVno").val().trim()+
					'&momId='+$("#queryMomId").val().trim()+
					'&speed='+$("#querySpeed").val().trim()+
					'&vcolor='+$("#queryVcolor").val().trim()+
					'&status='+$("#queryStatus").val().trim()+
					'&y='+$("#queryY").val().trim()+
					'&x='+$("#queryX").val().trim()+
					'&type='+$("#queryType").val().trim());
		}
</script>
</body>
</html>
