<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>联单转移联单信息管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="联单编号">联单编号:</label>
                        <input id="queryLDBH" name="LDBH" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="司机">司机:</label>
                       <input id="queryCHUCHANG" name="CHUCHANG" class="easyui-textbox" style="width: 200px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="联单状态">联单状态：</label>
                        <input id="queryLDZT" name="LDZT" class="easyui-textbox" style="width: 200px;">
					</div>
			
					<#--<div class="optionBar">-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
						<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
					<#--</div>-->
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newJointOrderInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editJointOrderInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteJointOrderInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/haz/jointOrderInfo/jointOrderInfoList"
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
					<th formatter="Ams.tooltipFormat" field="ldbh" width="10%">联单编号</th>
					<th formatter="Ams.tooltipFormat" field="chuchang" width="10%">出厂</th>
					<th field="ccsj" width="11%" formatter="Ams.timeDateFormat">出厂时间</th>
					<th formatter="Ams.tooltipFormat" field="confirmremark" width="10%">创建备注</th>
					<th formatter="Ams.tooltipFormat" field="ldzt" width="10%">联单状态：</th>
					<th formatter="Ams.tooltipFormat" field="ysqydriver" width="10%" >司机</th>
					<th field="qrcjsj" width="11%" >确认创建时间</th>
					<th field="qrsj" width="11%" formatter="Ams.timeDateFormat">确认时间</th>
					<th formatter="Ams.tooltipFormat" field="qrcjremark" width="11%">确认备注</th>
					<th field="cjsj" width="11%" formatter="Ams.timeDateFormat">创建时间</th>
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
				<input name="CHUCHANG" id="CHUCHANG" class="easyui-textbox" required="true" label="司机:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CCSJ" id="CCSJ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="confirmRemark" id="confirmRemark" class="easyui-textbox" required="true" label="确认接收时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LDZT" id="LDZT" class="easyui-textbox" required="true" label="联单状态：a 新建待处置确认，1 创建成功，2 已出厂，c 接收量不一致协商解决产废企业确认，3 已确认签收，5 已退回:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ysqyDriver" id="ysqyDriver" class="easyui-textbox" required="true" label="出厂时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QRCJSJ" id="QRCJSJ" class="easyui-textbox" required="true" label="创建时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zyldId" id="zyldId" class="easyui-textbox" required="true" label="转移联单id:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ID" id="ID" class="easyui-textbox" required="true" label="系统企业id:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="QRSJ" id="QRSJ" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="qrcjRemark" id="qrcjRemark" class="easyui-textbox" required="true" label="确认时间:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CJSJ" id="CJSJ" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="UPDATETIME" id="UPDATETIME" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LDBH" id="LDBH" class="easyui-textbox" required="true" label="联单编号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveJointOrderInfo()" style="width: 90px">保存</a>
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
				chuchang: $("#queryCHUCHANG").val().trim(),
				ldzt: $("#queryLDZT").val().trim(),
			    
			    ldbh: $("#queryLDBH").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newJointOrderInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增联单转移联单信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/haz/jointOrderInfo/saveJointOrderInfo';
		}

		function editJointOrderInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/haz/jointOrderInfo/getJointOrderInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改联单转移联单信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/haz/jointOrderInfo/saveJointOrderInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveJointOrderInfo() {
			$('#fm').form('submit', {
				url: url,
				onSubmit: function () {
					return $(this).form('validate');
				},
				success: function (result) {
					var result = JSON.parse(result);
					if (result.type == 'E') {
                        Ams.success(result.message);
					} else {
						$('#dlg').dialog('close');
						$('#dg').datagrid('load');
					}
				}
			});
		}

		function deleteJointOrderInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/haz/jointOrderInfo/deleteJointOrderInfo',
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
			window.open(Ams.ctxPath + '/haz/jointOrderInfo/getListExport' +
					'?chuchang='+$("#queryCHUCHANG").val().trim()+
					'&ldzt='   +$("#queryLDZT").val().trim()+
					'&ldbh='+$("#queryLDBH").val().trim());
		}
</script>
</body>
</html>
