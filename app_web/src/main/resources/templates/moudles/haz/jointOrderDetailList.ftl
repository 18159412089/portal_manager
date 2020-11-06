<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>联单详细信息管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="危废名称">危废名称:</label>
                       <input id="querySucheng" name="sucheng" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="危险特性">危险特性:</label>
                       <input id="queryWxtx" name="wxtx" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="容器类型">容器类型:</label>
                       <input id="queryRongqilx" name="rongqilx" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="处置方式代码">处置方式代码:</label>
                       <input id="queryCzfsName" name="czfsName" class="easyui-textbox" style="width: 200px;">
				   </div>
					 

					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newJointOrderDetail()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editJointOrderDetail()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteJointOrderDetail()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/haz/jointOrderDetail/jointOrderDetailList"
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
					<th field="sucheng" width="10%" formatter="Ams.tooltipFormat">危废名称</th>
					<th field="code" width="10%" formatter="Ams.tooltipFormat">危废代码</th>
					<th field="wxtx" width="10%" formatter="Ams.tooltipFormat">危险特性</th>
					<th field="rongqilx" width="10%" formatter="Ams.tooltipFormat">容器类型</th>
					<th field="rongqisl" width="10%" formatter="Ams.tooltipFormat">容器数量</th>
					<th field="guigexinghao" width="10%" formatter="Ams.tooltipFormat">规格型号</th>
					<th field="czfsName" width="10%" formatter="Ams.tooltipFormat">处置方式代码</th>
					<th field="danwei" width="10%" formatter="Ams.tooltipFormat">处置单位接收量</th>
				 
					<th formatter="Ams.tooltipFormat" field="czJsl" width="10%">转移量</th>
					<th formatter="Ams.tooltipFormat" field="caizhi" width="10%">材质</th>
					<th formatter="Ams.tooltipFormat" field="wxcf" width="10%">危险成分</th>
					<th formatter="Ams.tooltipFormat" field="zyl" width="10%">转移量</th>
					<th field="updatetime" width="11%" formatter="Ams.timeDateFormat">更新时间</th>
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
				<input name="guigexinghao" id="guigexinghao" class="easyui-textbox" required="true" label="容器数量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="caizhi" id="caizhi" class="easyui-textbox" required="true" label="规格型号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wxcf" id="wxcf" class="easyui-textbox" required="true" label="转移危废重量单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zyl" id="zyl" class="easyui-textbox" required="true" label="材质:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="rongqisl" id="rongqisl" class="easyui-textbox" required="true" label="容器类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sucheng" id="sucheng" class="easyui-textbox" required="true" label="危废名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wxtx" id="wxtx" class="easyui-textbox" required="true" label="危险成分:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="rongqilx" id="rongqilx" class="easyui-textbox" required="true" label="容器类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="czfsName" id="czfsName" class="easyui-textbox" required="true" label="处置方式代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zyldId" id="zyldId" class="easyui-textbox" required="true" label="转移联单id:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="czJsl" id="czJsl" class="easyui-textbox" required="true" label="转移量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetime" id="updatetime" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="code" id="code" class="easyui-textbox" required="true" label="危废代码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="danwei" id="danwei" class="easyui-textbox" required="true" label="处置单位接收量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveJointOrderDetail()" style="width: 90px">保存</a>
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
				sucheng: $("#querySucheng").val().trim(),
				wxtx: $("#queryWxtx").val().trim(),
				rongqilx: $("#queryRongqilx").val().trim(),
				czfsName: $("#queryCzfsName").val().trim(),
  			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newJointOrderDetail() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增联单详细信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/haz/jointOrderDetail/saveJointOrderDetail';
		}

		function editJointOrderDetail() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/haz/jointOrderDetail/getJointOrderDetail',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改联单详细信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/haz/jointOrderDetail/saveJointOrderDetail';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveJointOrderDetail() {
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

		function deleteJointOrderDetail() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/haz/jointOrderDetail/deleteJointOrderDetail',
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
			window.open(Ams.ctxPath + '/haz/jointOrderDetail/getListExport' +
					'?sucheng='+$("#querySucheng").val().trim()+
					'&wxtx='   +$("#queryWxtx").val().trim()+
					'&rongqilx='+$("#queryRongqilx").val().trim()+
					'&czfsName='+$("#queryCzfsName").val().trim());
		}
</script>
</body>
</html>
