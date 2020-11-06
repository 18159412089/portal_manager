<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>海河流水质评价结果管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="站点编码">站点编码:</label>
                        <input id="queryPOINTCODE" name="POINTCODE" class="easyui-textbox" style="width: 100px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
                        <input id="queryPOINTNAME" name="POINTNAME" class="easyui-textbox" style="width: 150px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="流域编码">流域编码:</label>
                       <input id="queryWATERCODE" name="WATERCODE" class="easyui-textbox" style="width: 100px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="流域名称">流域名称:</label>
                        <input id="queryWATERNAME" name="WATERNAME" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行政区编码">行政区编码:</label>
                        <input id="queryCodeRegion" name="codeRegion" class="easyui-textbox" style="width: 150px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行政区名称">行政区名称:</label>
                        <input id="queryREGIONNAME" name="REGIONNAME" class="easyui-textbox" style="width: 150px;">
					</div>
				
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRiversEvaluateData()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRiversEvaluateData()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRiversEvaluateData()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rivers/riversEvaluateData/riversEvaluateDataList"
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
					<th field="pointcode" width="10%">站点编码</th>
					<th field="pointname" width="10%">站点名称</th>
					<th field="watercode" width="10%">流域编码</th>
					<th field="watername" width="10%">流域名称</th>
					<th field="codeRegion" width="10%">行政区编码</th>
					<th field="regionname" width="10%">行政区名称</th>
					<th field="taskwaters" width="10%">流量</th>
					<th field="primpollute" width="10%">污染源</th>
					<th field="yearnumber" width="5%">年</th>
					<th field="monthnumber" width="5%">月</th>
					<th field="operate" width="8%" formatter ="formatView">操作</th>
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
				<input name="POINTCODE" id="POINTCODE" class="easyui-textbox" required="true" label="站点编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeWaterqualityleveltarget" id="codeWaterqualityleveltarget" class="easyui-textbox" required="true" label="水质目标编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeWaterqualitylevel" id="codeWaterqualitylevel" class="easyui-textbox" required="true" label="水质现状编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YEARNUMBER" id="YEARNUMBER" class="easyui-textbox" required="true" label="年:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="REGIONNAME" id="REGIONNAME" class="easyui-textbox" required="true" label="行政区名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PRIMPOLLUTE" id="PRIMPOLLUTE" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="TASKWATERS" id="TASKWATERS" class="easyui-textbox" required="true" label="流量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WATERNAME" id="WATERNAME" class="easyui-textbox" required="true" label="流域名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WATERQUALITYLEVELNAME" id="WATERQUALITYLEVELNAME" class="easyui-textbox" required="true" label="水质现状:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="codeRegion" id="codeRegion" class="easyui-textbox" required="true" label="行政区编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WATERCODE" id="WATERCODE" class="easyui-textbox" required="true" label="流域编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="MONTHNUMBER" id="MONTHNUMBER" class="easyui-textbox" required="true" label="月:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WATERQUALITYLEVELTARGETNAME" id="WATERQUALITYLEVELTARGETNAME" class="easyui-textbox" required="true" label="水质目标:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="POINTNAME" id="POINTNAME" class="easyui-textbox" required="true" label="站点名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRiversEvaluateData()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<div id="dlg-detail" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-detail-buttons',maximized:true">
		<form id="fm-detail" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
			<table class="table insp-table">
		        <tbody class="form-table">
		        	<tr>
		                <td class="title tr">站点编码</td>
		                <td class="con">
		                	<input id="POINTCODE" name="POINTCODE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">站点名称</td>
						<td class="con">
							<input id="POINTNAME" name="POINTNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">流域编码</td>
		                <td class="con">
		                	<input id="WATERCODE" name="WATERCODE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">流域名称</td>
						<td class="con">
							<input id="WATERNAME" name="WATERNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr><tr>
		                <td class="title tr">流量</td>
		                <td class="con">
		                	<input id="TASKWATERS" name="TASKWATERS" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">污染源</td>
						<td class="con">
							<input id="PRIMPOLLUTE" name="PRIMPOLLUTE" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		       		<tr>
		                <td class="title tr">水质目标编码</td>
		                <td class="con">
		                	<input id="codeWaterqualityleveltarget" name="codeWaterqualityleveltarget" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水质目标</td>
						<td class="con">
							<input id="WATERQUALITYLEVELTARGETNAME" name="WATERQUALITYLEVELTARGETNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">水质现状编码</td>
		                <td class="con">
		                	<input id="codeWaterqualitylevel" name="codeWaterqualitylevel" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">水质现状</td>
						<td class="con">
							<input id="WATERQUALITYLEVELNAME" name="WATERQUALITYLEVELNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">行政区名称</td>
		                <td class="con">
		                	<input id="REGIONNAME" name="REGIONNAME" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
						<td class="title tr">行政区编码</td>
						<td class="con">
							<input id="codeRegion" name="codeRegion" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		            <tr>
		                <td class="title tr">年</td>
		                <td class="con">
		                	<input id="YEARNUMBER" name="YEARNUMBER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		                <td class="title tr">月</td>
		                <td class="con">
		                	<input id="MONTHNUMBER" name="MONTHNUMBER" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 188px;" readonly="readonly">
						</td>
		            </tr>
		        </tbody>
		    </table>
		</form>
	</div>
	
	<div id="dlg-detail-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg-detail').dialog('close')" style="width: 90px">返回</a>
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
				POINTCODE: $("#queryPOINTCODE").val().trim(),
		        REGIONNAME: $("#queryREGIONNAME").val().trim(),
				WATERNAME: $("#queryWATERNAME").val().trim(),
				codeRegion: $("#queryCodeRegion").val().trim(),
				WATERCODE: $("#queryWATERCODE").val().trim(),
				POINTNAME: $("#queryPOINTNAME").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRiversEvaluateData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增海河流水质评价结果');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rivers/riversEvaluateData/saveRiversEvaluateData';
		}

		function editRiversEvaluateData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rivers/riversEvaluateData/getRiversEvaluateData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改入海河流水质评价结果');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rivers/riversEvaluateData/saveRiversEvaluateData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRiversEvaluateData() {
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

		function deleteRiversEvaluateData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rivers/riversEvaluateData/deleteRiversEvaluateData',
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
		

		function formatView(value,row){
			var rowId = row.pointcode+"_"+row.yearnumber+"_"+row.monthnumber;
			return "<div>"+Ams.setImageSee()+"<a href='#' class='easyui-linkbutton' onClick=\"setting('"+rowId+"')\">详情查看</a></div>";
	   	}
		function setting(rowId) {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/rivers/riversEvaluateData/getRiversEvaluateData',
				data: {'uuid': rowId},
				success: function (result) {
					$('#dlg-detail').dialog('open').dialog('center').dialog('setTitle', '入海河流水质评价结果明细');
					$('#fm-detail').form('load', result);
				},
			dataType: 'json'
			});
		}
		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/rivers/riversEvaluateData/getListExport' +
					'?POINTCODE='+$("#queryPOINTCODE").val().trim()+
					'&REGIONNAME='+$("#queryREGIONNAME").val().trim()+
					'&WATERNAME='+$("#queryWATERNAME").val().trim()+
					'&codeRegion='+$("#queryCodeRegion").val().trim()+
					'&WATERCODE='+$("#queryWATERCODE").val().trim()+
					'&POINTNAME='+$("#queryPOINTNAME").val().trim());
		}
</script>
</body>
</html>
