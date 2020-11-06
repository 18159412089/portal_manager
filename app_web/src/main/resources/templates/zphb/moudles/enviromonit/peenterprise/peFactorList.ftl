<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>污染源自动监控点位采集因子管理</title> 
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
							<label class="textbox-label textbox-label-before" title="因子代码">因子代码:</label>
									<input id="queryPluCode" name="queryPluCode" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="水气类型">水气类型:</label>
									<input id="queryPluType" name="queryPluType" class="easyui-textbox" style="width: 200px;" data-options="validType:'number'">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="量程上限">量程上限:</label>
									<input id="queryUpLimit" name="queryUpLimit" class="easyui-textbox" style="width: 200px;" data-options="validType:'number'">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="量程下限">量程下限:</label>
									<input id="queryLowLimit" name="queryLowLimit" class="easyui-textbox" style="width: 200px;" data-options="validType:'number'">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否启用">是否启用:</label>
									<input id="queryIsUsed" name="queryIsUsed" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="点位ID">点位ID:</label>
									<input id="queryOutputId" name="queryOutputId" class="easyui-textbox" style="width: 200px;" data-options="validType:'number'">
							</div>
						
						
						
						
						
						
						
						
						
						
						
						
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a> 
					<a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<@sec.authorize access= "hasAuthority('factor:pefactor:add')" > 
				<a href="#" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newPeFactor()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('factor:pefactor:edit')" > 
				<a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editPeFactor()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('factor:pefactor:delete')" > 
				<a href="#" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePeFactor()">删除</a>
			</@sec.authorize>
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/factor/pefactor/peFactorList"
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
							<th field="pluCode" width="10">因子代码</th>
							<th field="pluType" width="10">水气类型</th>
							<th field="upLimit" width="10">量程上限</th>
							<th field="lowLimit" width="10">量程下限</th>
							<th field="stdValue" width="10">标准值上限</th>
							<th field="unitCode" width="10">单位</th>
							<th field="outputId" width="10">点位ID</th>
							<th field="accuracy" width="10">精度</th>
							<th field="amplitude" width="10">振幅</th>
							<th field="convert" width="10">折算浓度</th>
							<th field="stdMinValue" width="10">标准值下限</th>
							<th field="stdDayValue" width="10">日标准值上限</th>
							<th field="stdDayMinValue" width="10">日标准值下限</th>
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
						<label class="textbox-label textbox-label-before" title="主键">主键:</label>
								<input id="pluEqpId" name="pluEqpId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="因子代码">因子代码:</label>
								<input id="pluCode" name="pluCode" class="easyui-textbox" data-options="validType:'maxLength[30]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="水气类型">水气类型:</label>
								<input id="pluType" name="pluType" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="量程上限">量程上限:</label>
								<input id="upLimit" name="upLimit" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="量程下限">量程下限:</label>
								<input id="lowLimit" name="lowLimit" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否启用">是否启用:</label>
								<input id="isUsed" name="isUsed" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="标准值上限">标准值上限:</label>
								<input id="stdValue" name="stdValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="单位">单位:</label>
								<input id="unitCode" name="unitCode" class="easyui-textbox" data-options="validType:'maxLength[20]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="因子名称">因子名称:</label>
								<input id="pluName" name="pluName" class="easyui-textbox" data-options="validType:'maxLength[30]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="点位ID">点位ID:</label>
								<input id="outputId" name="outputId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="精度">精度:</label>
								<input id="accuracy" name="accuracy" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="振幅">振幅:</label>
								<input id="amplitude" name="amplitude" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="折算浓度">折算浓度:</label>
								<input id="convert" name="convert" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="极大值">极大值:</label>
								<input id="maxValue" name="maxValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="极小值">极小值:</label>
								<input id="minValue" name="minValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="删除状态">删除状态:</label>
								<input id="status" name="status" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="考核限值">考核限值:</label>
								<input id="testLimit" name="testLimit" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="设备ID">设备ID:</label>
								<input id="deviceId" name="deviceId" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="标准值下限">标准值下限:</label>
								<input id="stdMinValue" name="stdMinValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="日标准值上限">日标准值上限:</label>
								<input id="stdDayValue" name="stdDayValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="日标准值下限">日标准值下限:</label>
								<input id="stdDayMinValue" name="stdDayMinValue" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePeFactor()" style="width: 90px">保存</a>
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
				pluCode: $("#queryPluCode").val().trim(),
				pluType: $("#queryPluType").val().trim(),
				upLimit: $("#queryUpLimit").val().trim(),
				lowLimit: $("#queryLowLimit").val().trim(),
				isUsed: $("#queryIsUsed").val().trim(),
				outputId: $("#queryOutputId").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newPeFactor() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增污染源自动监控点位采集因子');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/factor/pefactor/savePeFactor';
		}

		function editPeFactor() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/factor/pefactor/getPeFactor',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改污染源自动监控点位采集因子');
						$('#fm').form('load', result.peFactor);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/factor/pefactor/savePeFactor';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePeFactor() {
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
                        Ams.error(result.message);
                    } else {
                        $('#dlg').dialog('close');
                        $('#dg').datagrid('load');
                    }
                }
            });
        }

		function deletePeFactor() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/factor/pefactor/deletePeFactor',
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
