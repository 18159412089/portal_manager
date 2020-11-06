<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>矿山管理管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
					<input id="queryWrylx" name="wrylx" class="easyui-textbox" label="污染源类型:" style="width: 200px;">
					<input id="queryWryzl" name="wryzl" class="easyui-textbox" label="污染源种类:" style="width: 200px;">
					<input id="queryMc" name="mc" class="easyui-textbox" label="名称:" style="width: 200px;">
					<input id="queryCzwt" name="czwt" class="easyui-textbox" label="存在问题:" style="width: 200px;">
					<input id="queryZgcs" name="zgcs" class="easyui-textbox" label="整改措施:" style="width: 200px;">
					<input id="queryZlxm" name="zlxm" class="easyui-textbox" label="治理项目:" style="width: 200px;">
					<br>
					<input id="queryXz" name="xz" class="easyui-textbox" label="乡镇:" style="width: 200px;">
					<input id="queryDz" name="dz" class="easyui-textbox" label="地址:" style="width: 200px;">
					<input id="queryBz" name="bz" class="easyui-textbox" label="备注:" style="width: 200px;">
					<#--<input id="queryJd" name="jd" class="easyui-textbox" label="经度:" style="width: 200px;">
					<input id="queryWd" name="wd" class="easyui-textbox" label="纬度:" style="width: 200px;">-->
					<input id="queryEpCode" name="epCode" class="easyui-textbox" label="企业编码:" style="width: 200px;">
					<input id="queryChannelIds" name="channelIds" class="easyui-textbox" label="监控通道ID:" style="width: 200px;">
					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<#--<input id="querySeqno" name="seqno" class="easyui-textbox" label="序号:" style="width: 200px;">-->
					<br>
					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newZpLicensedMine()">新增</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editZpLicensedMine()">修改</a>
					<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteZpLicensedMine()">删除</a>

				</form>
			</div>
			<#--<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" >
				<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editZpLicensedMine()">修改</a>
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteZpLicensedMine()">删除</a>
			</@sec.authorize>-->

		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/zphb/mine/zpLicensedMine/zpLicensedMineList"
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
					<th field="seqno" width="10%">序号</th>
					<th field="wrylx" width="10%">污染源类型</th>
					<th field="wryzl" width="10%">污染源种类</th>
					<th field="mc" width="10%">名称</th>
					<th field="czwt" width="10%">存在问题</th>
					<th field="zgcs" width="10%">整改措施</th>
					<th field="zlxm" width="10%">治理项目</th>
					<th field="xz" width="10%">乡镇</th>
					<th field="dz" width="10%">地址</th>
					<th field="bz" width="10%">备注</th>
					<th field="jd" width="10%">经度</th>
					<th field="wd" width="10%">纬度</th>
					<th field="epCode" width="10%">企业编码</th>
					<th field="channelIds" width="10%">监控通道ID</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="id" id="id" hidden/>
			<div style="margin-bottom: 10px">
				<input name="wrylx" id="wrylx" class="easyui-textbox" required="true" label="污染源类型:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wryzl" id="wryzl" class="easyui-textbox" required="true" label="污染源种类:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="mc" id="mc" class="easyui-textbox" required="true" label="名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="czwt" id="czwt" class="easyui-textbox" required="true" label="存在问题:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zgcs" id="zgcs" class="easyui-textbox" required="true" label="整改措施:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="zlxm" id="zlxm" class="easyui-textbox" required="true" label="治理项目:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="xz" id="xz" class="easyui-textbox" required="true" label="乡镇:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="dz" id="dz" class="easyui-textbox" required="true" label="地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="bz" id="bz" class="easyui-textbox" required="true" label="备注:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="jd" id="jd" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="wd" id="wd" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="epCode" id="epCode" class="easyui-textbox" required="true" label="企业编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="channelIds" id="channelIds" class="easyui-textbox" required="true" label="监控通道ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="seqno" id="seqno" class="easyui-textbox" required="true" label="序号:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveZpLicensedMine()" style="width: 90px">保存</a>
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
				wrylx: $("#queryWrylx").val().trim(),
				wryzl: $("#queryWryzl").val().trim(),
				mc: $("#queryMc").val().trim(),
				czwt: $("#queryCzwt").val().trim(),
				zgcs: $("#queryZgcs").val().trim(),
				zlxm: $("#queryZlxm").val().trim(),
				xz: $("#queryXz").val().trim(),
				dz: $("#queryDz").val().trim(),
				bz: $("#queryBz").val().trim(),
				epCode: $("#queryEpCode").val().trim(),
				channelIds: $("#queryChannelIds").val().trim()
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newZpLicensedMine() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增矿山管理');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/zphb/mine/zpLicensedMine/saveZpLicensedMine';
		}

		function editZpLicensedMine() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/zphb/mine/zpLicensedMine/getZpLicensedMine',
					data: {'id': row.id},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改矿山管理');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/zphb/mine/zpLicensedMine/saveZpLicensedMine';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveZpLicensedMine() {
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

		function deleteZpLicensedMine() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/zphb/mine/zpLicensedMine/deleteZpLicensedMine',
							data: {'id': row.id},
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
