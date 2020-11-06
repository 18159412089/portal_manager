<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水利厅水文站点管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div id="searchBar" class="searchBar">
				<form id="searchForm">
					<!-- <input id="queryRKSJ" name="RKSJ" class="easyui-textbox" label="入库时间:" style="width: 200px;"> -->
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="测站编码">测站编码:</label>
                      <input id="querySTCD" name="STCD" class="easyui-textbox" style="width: 200px;">
				  </div>
					<!-- <input id="queryUpdatetimeRjwa" name="updatetimeRjwa" class="easyui-textbox" label="更新时间:" style="width: 200px;">
					<input id="queryYMDHM" name="YMDHM" class="easyui-textbox" label="时间:" style="width: 200px;"> -->
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newWtcdRainfallData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editWtcdRainfallData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteWtcdRainfallData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/wtcd/wtcdRainfallData/wtcdRainfallDataList"
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
					<th formatter="Ams.tooltipFormat" field="stcd" width="10%">测站编码</th>
					<th field="wtcdSiteInfo" width="10%" formatter="getStnm">测站名称</th>
					<th formatter="Ams.tooltipFormat" field="dtrn" width="10%">雨量 米</th>
					<th field="ymdhm" width="20%" formatter="Ams.timeDateFormat">时间</th>
					<th field="rksj" width="20%" formatter="Ams.timeDateFormat">入库时间</th>
					<th formatter="Ams.tooltipFormat" field="updatetimeRjwa" width="20%">更新时间</th>
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
				<input name="RKSJ" id="RKSJ" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="STCD" id="STCD" class="easyui-textbox" required="true" label="测站编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DTRN" id="DTRN" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YMDHM" id="YMDHM" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveWtcdRainfallData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};

		function getStnm(val,row){  
		    if(val) return val.stnm;  
		    else return "";  
		}  
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		
		function doSearch() {
			$('#dg').datagrid('load', {
				/* RKSJ: $("#queryRKSJ").val().trim(), */
				STCD: $("#querySTCD").val().trim(),
				/* updatetimeRjwa: $("#queryUpdatetimeRjwa").val().trim(),
				YMDHM: $("#queryYMDHM").val().trim(), */
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newWtcdRainfallData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水利厅水文站点');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/wtcd/wtcdRainfallData/saveWtcdRainfallData';
		}

		function editWtcdRainfallData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/wtcd/wtcdRainfallData/getWtcdRainfallData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水利厅水文站点');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/wtcd/wtcdRainfallData/saveWtcdRainfallData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveWtcdRainfallData() {
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

		function deleteWtcdRainfallData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/wtcd/wtcdRainfallData/deleteWtcdRainfallData',
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
			window.open(Ams.ctxPath + '/wtcd/wtcdRainfallData/getListExport' +
					'?STCD='+$("#querySTCD").val().trim());
		}
</script>
</body>
</html>
