<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>污染源手动监控点位采集因子管理</title>
    <#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
					<label>点位名称：</label><select id="queryOutputId" name="outputId" class="easyui-combobox" style="width: 339px;"></select>
					<label>因子代码：</label><input id="queryPluCode" name="pluCode" class="easyui-textbox" style="width: 200px;">
					<label>因子名称：</label><input id="queryPluName" name="pluName" class="easyui-textbox" style="width: 200px;">
					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newPeFactorManual()">新增</a>
			<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editPeFactorManual()">修改</a>
			<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePeFactorManual()">删除</a>
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar"
			   url="${request.contextPath}/zphb/factormanual/PeFactorManual/peFactorManualAllList"
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
				<th field="outputName" width="20%">点位名称</th>
				<th field="pluName" width="20%">因子名称</th>
				<th field="pluCode" width="20%">因子代码</th>
				<th field="upLimit" width="20%">标准值上限</th>
				<th field="lowLimit" width="20%">标准值下限</th>
			</tr>
			</thead>
		</table>
	</div>

	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		 data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="pluEqpId" id="pluEqpId" hidden="true"/>
			<div style="margin-bottom: 10px">
				<input class="easyui-combobox"
					   name="outputId" id="outputId" label="点位名称:"
					   data-options="
						url:'${request.contextPath}/monitorPoint/pemonitorpoint/getCompnentPeMonitorPointDatasList',
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px">
				<input class="easyui-combobox"
					   name="pluName" id="pluName" label="因子名称:"
					   data-options="
						url:'${request.contextPath}/zphb/factormanual/PeFactorManual/getComponentFactorManual',
						method:'get',
						valueField:'id',
						textField:'text',
						panelHeight:'auto'
				" style="width: 100%">
			</div>
			<div style="margin-bottom: 10px;">
				<input name="pluCode" id="pluCode" class="easyui-textbox" required="true" label="因子代码:" style="width: 100%"
					   data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="upLimit" id="upLimit" class="easyui-textbox" required="true" label="标准值上限:" style="width: 100%"
					   data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="lowLimit" id="lowLimit" class="easyui-textbox" required="true" label="标准值下限:"
					   style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="unitCode" id="unitCode" class="easyui-textbox" label="单位:" style="width: 100%">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePeFactorManual()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script type="text/javascript">
		var statusFlag = "save"
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
				pluCode: $("#queryPluCode").val().trim(),
				pluName: $("#queryPluName").val().trim(),
				outputId: $("#queryOutputId").combobox('getValue')
			});
		}

		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}

		function newPeFactorManual() {
			statusFlag = "save";
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增因子');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			$('#pluCode').textbox({disabled: false});
			$('#pluName').textbox({disabled: false});
			$('#outputId').textbox({disabled: false});
			url = Ams.ctxPath + '/zphb/factormanual/PeFactorManual/savePeFactorManual';
		}

		initPointCombobox();

		//企业下拉框
		function initPointCombobox() {
			var url = "${request.contextPath}/monitorPoint/pemonitorpoint/getCompnentPeMonitorPointDatasList";
			//污染源企业
			$("#queryOutputId").combobox({
				url: url,
				valueField: "id",
				textField: "text",
				editable: true,
				panelHeight: 'auto',
				panelMaxHeight: '240',
				method: 'get',
				labelPosition: 'left',
				multiple: false,
				value: "",
				onLoadSuccess: function () {	//加载完成后选择第一项
					var val = $(this).combobox("getData");
				},
				onChange: function (newValue, oldValue) {
				}
			});
			$("#pluName").combobox({
				url: '${request.contextPath}/zphb/factormanual/PeFactorManual/getComponentFactorManual',
				valueField: "id",
				textField: "text",
				editable: true,
				panelHeight: 'auto',
				panelMaxHeight: '240',
				method: 'get',
				labelPosition: 'left',
				multiple: false,
				value: "",
				onLoadSuccess: function () {	//加载完成后选择第一项

				}
				,
				onSelect: function (item) {
					$("#pluCode").textbox('setValue', item.id);
				},
				onChange: function (newValue, oldValue) {

				}
			});
		}

		function editPeFactorManual() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			statusFlag = "edit";
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/zphb/factormanual/PeFactorManual/getPeFactorManualByPluEqpId',
					data: {'pluEqpId': row.pluEqpId},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改因子');
						$('#fm').form('load', result);
						$("#pluCode").textbox('setValue', result.pluCode);
						$('#code').textbox({readonly: true});
						$('#pluCode').textbox({disabled: true});
						$('#pluName').textbox({disabled: true});
						$('#outputId').textbox({disabled: true});
						$('#outputId').combobox('setValue', result.outputId);
						url = Ams.ctxPath + '/zphb/factormanual/PeFactorManual/savePeFactorManual';
					},
					dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePeFactorManual() {
			var outPutId = $('#outputId').combobox('getValue');
			var pluCode = $('#pluCode').val();
			if (statusFlag == 'edit') {
				savePeFactor();
			} else {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/zphb/factormanual/PeFactorManual/isSameFactor',
					data: {'outPointId': outPutId, 'pluCode': pluCode},
					success: function (result) {
						if (result) {
							$.messager.alert('提示', '不能添加重复污染物因子信息！');
						} else {

							savePeFactor();
						}
					},
					dataType: 'json'
				});
			}
		}

		function savePeFactor() {
			$("#pluName").combobox('setValue', $('#pluName').combobox('getText'));
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

		function deletePeFactorManual() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				console.log(row);
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/zphb/factormanual/PeFactorManual/deletePeFactorManualByEqpId',
							data: {'pluEqpId': row.pluEqpId},
							success: function (result) {
								console.log(result);
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
