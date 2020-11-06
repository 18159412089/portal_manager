<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>海洋与渔业点位信息管理</title> 
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
                      <label  class="textbox-label textbox-label-before" title="站点编号">站点编号:</label>
                      <input id="queryZdbh" name="zdbh" class="easyui-textbox" style="width: 200px;">
				  </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="原站点编号">原站点编号:</label>
                       <input id="queryYzdbh" name="yzdbh" class="easyui-textbox" style="width: 200px;">
				   </div>
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
                    <input id="queryZdmc" name="zdmc" class="easyui-textbox" style="width: 200px;">
				</div>
                <div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="行政区划名称">行政区划名称:</label>
                    <input id="queryXzqhmc" name="xzqhmc" class="easyui-textbox" style="width: 200px;">
				</div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newSeaSiteInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editSeaSiteInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteSeaSiteInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/sea/seaSiteInfo/seaSiteInfoList"
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
					<th formatter="Ams.tooltipFormat" field="zdbh" width="10%">站点编号</th>
					<th formatter="Ams.tooltipFormat" field="yzdbh" width="10%">原站点编号</th>
					<th formatter="Ams.tooltipFormat" field="zdmc" width="10%">站点名称</th>
					<th formatter="Ams.tooltipFormat" field="jd" width="10%">经度</th>
					<th formatter="Ams.tooltipFormat" field="wd" width="10%">纬度</th>
					<th formatter="Ams.tooltipFormat" field="xzqhbm" width="10%">行政区划代码</th>
					<th formatter="Ams.tooltipFormat" field="xzqhmc" width="10%">行政区划名称</th>
					<th formatter="Ams.tooltipFormat" field="jcpc" width="10%">监测频次</th>
					<th field="updatetimeRjwa" width="11%">更新时间</th>
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
				<input name="ZDBH" id="ZDBH" class="easyui-textbox" required="true" label="站点编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YZDBH" id="YZDBH" class="easyui-textbox" required="true" label="原站点编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZDMC" id="ZDMC" class="easyui-textbox" required="true" label="站点名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JD" id="JD" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WD" id="WD" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XZQHBM" id="XZQHBM" class="easyui-textbox" required="true" label="行政区划代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XZQHMC" id="XZQHMC" class="easyui-textbox" required="true" label="行政区划名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JCPC" id="JCPC" class="easyui-textbox" required="true" label="监测频次:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveSeaSiteInfo()" style="width: 90px">保存</a>
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
				zdbh: $("#queryZdbh").val().trim(),
				yzdbh: $("#queryYzdbh").val().trim(),
				zdmc: $("#queryZdmc").val().trim(),
				xzqhmc: $("#queryXzqhmc").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newSeaSiteInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增海洋与渔业点位信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/sea/seaSiteInfo/saveSeaSiteInfo';
		}

		function editSeaSiteInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/sea/seaSiteInfo/getSeaSiteInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改海洋与渔业点位信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/sea/seaSiteInfo/saveSeaSiteInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveSeaSiteInfo() {
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

		function deleteSeaSiteInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/sea/seaSiteInfo/deleteSeaSiteInfo',
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
			window.open(Ams.ctxPath + '/sea/seaSiteInfo/getListExport' +
					'?zdbh='+$("#queryZdbh").val().trim()+
					'&yzdbh='   +$("#queryYzdbh").val().trim()+
					'&zdmc='+$("#queryZdmc").val().trim()+
					'&xzqhmc='+$("#queryXzqhmc").val().trim());
		}
</script>
</body>
</html>
