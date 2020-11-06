<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>手工监测水质站点管理</title> 
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div  id="toolbar">
			<div style="padding: 3px;" id="searchBar">
				<form id="searchForm">
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="断面编码">断面编码:</label>
									<input id="querySectionCode" name="querySectionCode" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="断面名称">断面名称:</label>
									<input id="querySectionName" name="querySectionName" class="easyui-textbox" style="width: 200px;">
							</div>

						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="断面类型">断面类型:</label>
									<input id="queryCategory" name="queryCategory" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="目标水质">目标水质:</label>
									<input id="queryTargetQuality" name="queryTargetQuality" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<#--<@sec.authorize access= "hasAuthority('water:wtsectionpoint:add')" >
				<a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newWtSectionPoint()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('water:wtsectionpoint:edit')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editWtSectionPoint()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('water:wtsectionpoint:delete')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteWtSectionPoint()">删除</a>
			</@sec.authorize>-->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/enviromonit/water/wtSectionPoint/wtSectionPointList"
				data-options="
					rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:true,
		            fitColumns:true,
		            fit:true,
		            pagination:true,
		            pageSize:10,
		            pageList:[10,30,50]">
			<thead>
				<tr>
							<th field="pointCode" width="10">断面编码</th>
							<th field="pointName" width="10">断面名称</th>
					        <th field="category" width="10" formatter="Ams.fmtSectionType">断面类型</th>
							<th field="targetQuality" width="10" formatter="Ams.fmtByWtQuality">目标水质</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- dialog1 -->
	<div id="dlg" class="easyui-dialog" style="width: 420px"
		data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		<form id="fm" method="post" novalidate >
			<input name="uuid" hidden="true" /> 
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="断面编码">断面编码:</label>
								<input id="sectionCode" name="sectionCode" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="断面名称">断面名称:</label>
								<input id="sectionName" name="sectionName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="断面类型(1:国控，2省控，3其他)">断面类型(1:国控，2省控，3其他):</label>
								<input id="category" name="category" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="目标水质">目标水质:</label>
								<input id="targetQuality" name="targetQuality" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="状态">状态:</label>
								<input id="status" name="status" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否以奖促治项目">是否以奖促治项目:</label>
								<input id="isPromoting" name="isPromoting" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否党政目标责任书项目">是否党政目标责任书项目:</label>
								<input id="isTargetProject" name="isTargetProject" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveWtSectionPoint()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
	</div>

	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
			$(this).remove();
			});
		};
		
	    $(function () {
	        var dgPager = $('#dg').datagrid().datagrid('getPager');
	        dgPager.pagination({
	        	layout:[ 'list','sep', 'first', 'prev', 'links', 'next', 'last', 'manual'],
	        	links:8
	        });
	        
	    });
		function formatDefault(value, row, index) {
			if (1 == value) {
				return '是';
			}
			return '否';
		}
		
		function doSearch() {
			if(!$('#searchForm').form('validate')){
                return;
            }
			$('#dg').datagrid('load', {
                pointCode: $("#querySectionCode").val().trim(),
                pointName: $("#querySectionName").val().trim(),
                category: $("#queryCategory").val().trim(),
                targetQuality: $("#queryTargetQuality").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newWtSectionPoint() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增手工监测水质站点');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/water/wtsectionpoint/saveWtSectionPoint';
		}

		function editWtSectionPoint() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/water/wtsectionpoint/getWtSectionPoint',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改手工监测水质站点');
						$('#fm').form('load', result.wtSectionPoint);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/water/wtsectionpoint/saveWtSectionPoint';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveWtSectionPoint() {
            if(!$('#fm').form('validate')){
                return;
            }
            $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
            $.ajax({
                type: "POST",
                dataType: "json",
                url: url,
                data: $('#fm').serialize(),
                success: function (result) {
                	$.messager.progress('close');
                    if (result.type == 'E') {
                        $.messager.show({
                            title: '错误',
                            msg: result.message
                        });
                    } else {
                        $('#dlg').dialog('close');
                        $('#dg').datagrid('load');
                    }
                }
            });
        }

		function deleteWtSectionPoint() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/water/wtsectionpoint/deleteWtSectionPoint',
							data: {'uuid': row.uuid},
							success: function (result) {
								var result = eval(result);
								if (result.type == 'E') {
									$.messager.show({
										title: '错误',
										msg: result.message
									});
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
        /*导出*/
        function exportData(){
            var pointCode=encodeURI($("#querySectionCode").val().trim());
            var pointName=encodeURI($("#querySectionName").val().trim());
            var category=encodeURI($("#queryCategory").val().trim());
            var targetQuality=encodeURI($("#queryTargetQuality").val().trim());
            window.location.href = "${request.contextPath}/enviromonit/water/wtSectionPoint/export" +
                    "?pointCode="+pointCode+
                    "&pointName="+pointName+
                    "&category="+category+
                    "&targetQuality="+targetQuality
        }
</script>
</body>
</html>
