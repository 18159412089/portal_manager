<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>非密封台账管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="核素名称">核素名称:</label>
                        <input id="queryHSMC" name="HSMC" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="审核人">审核人:</label>
                        <input id="querySHR" name="SHR" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="审核日期">审核日期:</label>
                        <input id="querySHRQ" name="SHRQ" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="去向">去向:</label>
                        <input id="queryQX" name="QX" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="去向审核人">去向审核人:</label>
                        <input id="queryXQSHR" name="XQSHR" class="easyui-textbox" style="width: 200px;"><br/>
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="去向审核日期">去向审核日期:</label>
                        <input id="queryQXSHRQ" name="QXSHRQ" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="字典类型">来源:</label>
                        <input id="queryLY" name="LY" class="easyui-textbox" style="width: 200px;">
					</div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="用途">用途:</label>
                        <input id="queryYT" name="YT" class="easyui-textbox" style="width: 200px;">
					</div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newRadUnseraledAccount()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editRadUnseraledAccount()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteRadUnseraledAccount()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/rad/radUnseraledAccount/radUnseraledAccountList"
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
					<th field="radEnterpriseInfo" width="10%" formatter="getEnterpriseName">辐射企业</th>
					<th formatter="Ams.tooltipFormat" field="hsmc" width="10%">核素名称</th>
					<th formatter="Ams.tooltipFormat" field="pc" width="10%">频次</th>
					<th formatter="Ams.tooltipFormat" field="hd" width="10%">活度</th>
					<th formatter="Ams.tooltipFormat" field="ly" width="10%">来源</th>
					<th formatter="Ams.tooltipFormat" field="yt" width="10%">用途</th>
					<th formatter="Ams.tooltipFormat" field="updatetimeRjwa" width="11%">更新时间</th>
					<th formatter="Ams.tooltipFormat" field="shr" width="10%">审核人</th>
					<th formatter="Ams.tooltipFormat" field="shrq" width="11%">审核日期</th>
					<th formatter="Ams.tooltipFormat" field="qx" width="10%">去向</th>
					<th formatter="Ams.tooltipFormat" field="xqshr" width="10%">去向审核人</th>
					<th formatter="Ams.tooltipFormat" field="qxshrq" width="11%">去向审核日期</th>
					<th formatter="Ams.tooltipFormat" field="bz" width="10%">备注</th>
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
				<input name="SHR" id="SHR" class="easyui-textbox" required="true" label="审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HSMC" id="HSMC" class="easyui-textbox" required="true" label="核素名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ENTERID" id="ENTERID" class="easyui-textbox" required="true" label="单位自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QX" id="QX" class="easyui-textbox" required="true" label="去向:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XQSHR" id="XQSHR" class="easyui-textbox" required="true" label="去向审核人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="HD" id="HD" class="easyui-textbox" required="true" label="活度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LY" id="LY" class="easyui-textbox" required="true" label="来源:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PKID" id="PKID" class="easyui-textbox" required="true" label="自动编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="updatetimeRjwa" id="updatetimeRjwa" class="easyui-textbox" required="true" label="更新时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SHRQ" id="SHRQ" class="easyui-textbox" required="true" label="审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QXSHRQ" id="QXSHRQ" class="easyui-textbox" required="true" label="去向审核日期:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="YT" id="YT" class="easyui-textbox" required="true" label="用途:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BZ" id="BZ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="PC" id="PC" class="easyui-textbox" required="true" label="频次:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRadUnseraledAccount()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};

		function getEnterpriseName(val,row){  
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
				HSMC: $("#queryHSMC").val().trim(),
				SHR: $("#querySHR").val().trim(),
				SHRQ: $("#querySHRQ").val().trim(),
				QX: $("#queryQX").val().trim(),
				XQSHR: $("#queryXQSHR").val().trim(),
				QXSHRQ: $("#queryQXSHRQ").val().trim(),
				LY: $("#queryLY").val().trim(),
				YT: $("#queryYT").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newRadUnseraledAccount() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增非密封台账');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/rad/radUnseraledAccount/saveRadUnseraledAccount';
		}

		function editRadUnseraledAccount() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/rad/radUnseraledAccount/getRadUnseraledAccount',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改非密封台账');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/rad/radUnseraledAccount/saveRadUnseraledAccount';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveRadUnseraledAccount() {
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

		function deleteRadUnseraledAccount() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/rad/radUnseraledAccount/deleteRadUnseraledAccount',
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
			window.open(Ams.ctxPath + '/rad/radUnseraledAccount/getListExport' +
					'?HSMC='+$("#queryHSMC").val().trim()+
					'&SHR='+$("#querySHR").val().trim()+
					'&SHRQ='+$("#querySHRQ").val().trim()+
					'&QX='+$("#queryQX").val().trim()+
					'&XQSHR='+$("#queryXQSHR").val().trim()+
					'&QXSHRQ='+$("#queryQXSHRQ").val().trim()+
					'&LY='+$("#queryLY").val().trim()+
					'&YT='+$("#queryYT").val().trim());
		}
</script>
</body>
</html>
