<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>产品及辅料基本信息管理</title> 
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
                       <label  class="textbox-label textbox-label-before" title="产品名称">产品名称:</label>
                       <input id="queryPRODUCTSNAME" name="PRODUCTSNAME" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="CAS号">CAS号:</label>
                        <input id="queryCAS" name="CAS" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="原辅料名称">原辅料名称:</label>
                       <input id="queryMATERIALSNAME" name="MATERIALSNAME" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="运输方式">运输方式：</label>
                       <input id="queryFkTransportmode" name="fkTransportmode" class="easyui-textbox" style="width: 200px;">
				   </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiskProductAccessData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiskProductAccessData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiskProductAccessData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/risk/riskProductAccessData/riskProductAccessDataList"
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
					<th formatter="Ams.tooltipFormat" field="productsname" width="10%">产品名称</th>
					<th field="riskBaseInfo" width="15%" formatter="getEnterName">企业名称</th>
					 
					<th formatter="Ams.tooltipFormat" field="actuallyproduce" width="10%">实际年生产量（吨）</th>
					<th formatter="Ams.tooltipFormat" field="designcapacity" width="10%">设计年产量（吨）</th>
					<th formatter="Ams.tooltipFormat" field="cas" width="10%">CAS号</th>
				 
					<th formatter="Ams.tooltipFormat" field="materialsname" width="10%">原辅料名称</th>
					<th formatter="Ams.tooltipFormat" field="submittedtime" width="10%">申请时间</th>
					<th formatter="Ams.tooltipFormat" field="fkTransportmode" width="10%">运输方式</th>
					<th field="updatetime" width="11%" formatter="Ams.timeDateFormat">更新时间</th>
					<th formatter="Ams.tooltipFormat" field="consumption" width="10%">原辅料年贮存量（吨）</th>
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
				<input name="PRODUCTSNAME" id="PRODUCTSNAME" class="easyui-textbox" required="true" label="产品名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GUID" id="GUID" class="easyui-textbox" required="true" label="企业GUID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ACTUALLYPRODUCE" id="ACTUALLYPRODUCE" class="easyui-textbox" required="true" label="实际年生产量（吨）：该产品上一年实际年产量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="DESIGNCAPACITY" id="DESIGNCAPACITY" class="easyui-textbox" required="true" label="设计年产量（吨）:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CAS" id="CAS" class="easyui-textbox" required="true" label="CAS号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ID" id="ID" class="easyui-textbox" required="true" label="唯一标识:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="MATERIALSNAME" id="MATERIALSNAME" class="easyui-textbox" required="true" label="原辅料名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SUBMITTEDTIME" id="SUBMITTEDTIME" class="easyui-textbox" required="true" label="申请时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="fkTransportmode" id="fkTransportmode" class="easyui-textbox" required="true" label="运输方式：铁路运输；公路运输；水上运输；航空运输；管道运输:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="UPDATETIME" id="UPDATETIME" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CONSUMPTION" id="CONSUMPTION" class="easyui-textbox" required="true" label="原辅料年贮存量（吨）：该原辅料上一年实际年贮存量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiskProductAccessData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};
		function getEnterName(val,row){  
		    if(val) return val.entername;  
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
				PRODUCTSNAME: $("#queryPRODUCTSNAME").val().trim(),
			 
			 
				CAS: $("#queryCAS").val().trim(),
				MATERIALSNAME: $("#queryMATERIALSNAME").val().trim(),
				fkTransportmode: $("#queryFkTransportmode").val().trim(),
			 
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiskProductAccessData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增产品及辅料基本信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/risk/riskProductAccessData/saveRiskProductAccessData';
		}

		function editRiskProductAccessData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/risk/riskProductAccessData/getRiskProductAccessData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改产品及辅料基本信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/risk/riskProductAccessData/saveRiskProductAccessData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiskProductAccessData() {
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

		function deleteRiskProductAccessData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/risk/riskProductAccessData/deleteRiskProductAccessData',
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
			window.open(Ams.ctxPath + '/risk/riskProductAccessData/getListExport' +
					'?PRODUCTSNAME='+$("#queryPRODUCTSNAME").val().trim()+
					'&CAS='+$("#queryCAS").val().trim()+
					'&MATERIALSNAME='+$("#queryMATERIALSNAME").val().trim()+
					'&fkTransportmode='+$("#queryFkTransportmode").val().trim());
		}
</script>
</body>
</html>
