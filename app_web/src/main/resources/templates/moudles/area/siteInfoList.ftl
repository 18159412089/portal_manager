<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>近岸海域点位信息管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="行政区">行政区:</label>
                        <input id="queryXZQH" name="XZQH" class="easyui-textbox" style="width: 200px;">
					</div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="国控点位编码">国控点位编码:</label>
                      <input id="queryGKBM" name="GKBM" class="easyui-textbox" style="width: 190px;">
				  </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="省控点位编码">省控点位编码:</label>
                        <input id="querySKBM" name="SKBM" class="easyui-textbox" style="width: 190px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="海湾">海湾:</label>
                       <input id="queryGW" name="GW" class="easyui-textbox" style="width: 190px;">
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="状态">状态:</label>
                        <input id="queryZT" name="ZT" class="easyui-textbox" style="width: 190px;">
					</div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newSiteInfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editSiteInfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteSiteInfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/area/siteInfo/siteInfoList"
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
					<th formatter="Ams.tooltipFormat" field="gkbm" width="10%">国控点位编码</th>
					<th formatter="Ams.tooltipFormat" field="skbm" width="10%">省控点位编码</th>
					<th formatter="Ams.tooltipFormat" field="xzqh" width="10%">行政区</th>
					<th formatter="Ams.tooltipFormat" field="gw" width="10%">海湾</th>
					<th field="gxsj" width="11%" formatter="Ams.timeDateFormat">更新时间</th>
					<th formatter="Ams.tooltipFormat" field="nf" width="10%">年份</th>
			 		<th formatter="Ams.tooltipFormat" field="wd" width="10%">纬度</th>
					<th formatter="Ams.tooltipFormat" field="jd" width="10%">经度</th>
					<th formatter="Ams.tooltipFormat" field="zt" width="10%">状态</th>
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
				<input name="GXSJ" id="GXSJ" class="easyui-textbox" required="true" label="年份:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="NF" id="NF" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="XZQH" id="XZQH" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="KDMC" id="KDMC" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="WD" id="WD" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="JD" id="JD" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GKBM" id="GKBM" class="easyui-textbox" required="true" label="国控点位编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="SKBM" id="SKBM" class="easyui-textbox" required="true" label="省控点位编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="GW" id="GW" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ZT" id="ZT" class="easyui-textbox" required="true" label=":" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveSiteInfo()" style="width: 90px">保存</a>
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
			 
				XZQH: $("#queryXZQH").val().trim(),
				 
				 
				GKBM: $("#queryGKBM").val().trim(),
				SKBM: $("#querySKBM").val().trim(),
				GW: $("#queryGW").val().trim(),
				ZT: $("#queryZT").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
		
		function newSiteInfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增近岸海域点位信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/area/siteInfo/saveSiteInfo';
		}

		function editSiteInfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/area/siteInfo/getSiteInfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改近岸海域点位信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/area/siteInfo/saveSiteInfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveSiteInfo() {
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

		function deleteSiteInfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/area/siteInfo/deleteSiteInfo',
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
			window.open(Ams.ctxPath + '/area/siteInfo/getListExport' +
					'?XZQH='+$("#queryXZQH").val().trim()+
					'&GKBM='+$("#queryGKBM").val().trim()+
					'&SKBM='+$("#querySKBM").val().trim()+
					'&GW='+$("#queryGW").val().trim()+
					'&ZT='+$("#queryZT").val().trim());
		}
</script>
</body>
</html>
