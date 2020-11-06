${r"<#ftl"} attributes={"content_type":"text/html;charset=UTF-8"}>
${r"<#assign sec=JspTaglibs["}"http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>${functionName}管理</title> 
	${r"<#include"} "/header.ftl"/>
</head>
<body>
	${r"<#include"} "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div style="padding: 3px;" id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
					<#list columnList as c> 
					<#if c.isNotBaseField>
					<input id="query${c.javaField?cap_first }" name="${c.javaField}" class="easyui-textbox" label="${c.comments}:" style="width: 200px;">
					</#if>
					</#list> 
					<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<!-- 
			${r"<@sec.authorize" } access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="new${ClassName}()">新增</a>
				<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="edit${ClassName}()">修改</a>
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delete${ClassName}()">删除</a>
			${r"</@sec.authorize>" }
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${r"${request.contextPath}"}/${urlPrefix}/${className}List"
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
				<#list columnList as c>
					<#if c.isNotBaseField>
					<th field="${c.javaField }" width="10%">${c.comments }</th>
					</#if>
				</#list>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
			<input name="uuid" hidden="true" /> 
			<#list columnList as c>
			<#if c.isNotBaseField>
			<div style="margin-bottom: 10px">
				<input name="${c.javaField }" id="${c.javaField }" class="easyui-textbox" required="true" label="${c.comments }:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			</#if>
			</#list>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save${ClassName}()" style="width: 90px">保存</a>
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
				<#list columnList as c>
				<#if c.isNotBaseField>
				${c.javaField}: $("#query${c.javaField?cap_first }").val().trim(),
				</#if>
				</#list>
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function new${ClassName}() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增${functionName}');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/${urlPrefix}/save${ClassName}';
		}

		function edit${ClassName}() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/${urlPrefix}/get${ClassName}',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改${functionName}');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/${urlPrefix}/save${ClassName}';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function save${ClassName}() {
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

		function delete${ClassName}() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/${urlPrefix}/delete${ClassName}',
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
</script>
</body>
</html>
