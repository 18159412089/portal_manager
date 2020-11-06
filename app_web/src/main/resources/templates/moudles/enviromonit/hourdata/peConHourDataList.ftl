<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>自动监控小时浓度数据管理</title> 
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
							<label class="textbox-label textbox-label-before" title="企业ID">企业ID:</label>
									<select id="queryPeId" name="queryPeId" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="点位ID">点位ID:</label>
									<select id="queryOutputId" name="queryOutputId" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="监测时间">监测时间:</label>
									<input id="queryMeasureTime" name="queryMeasureTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
							</div>
						
						
						
						
						
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="点位类型">点位类型:</label>
									<select id="queryOutfallType" name="queryOutfallType" class="easyui-combobox" data-options="panelMaxHeight:'240',editable:true,panelHeight:'auto'"
				                        style="width:200px;">
					                    <option value="" selected="selected">全部状态</option>
					                    <option value="1">启用</option>
					                    <option value="0">禁用</option>
					                </select>
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="是否监测">是否监测:</label>
									<input id="queryIsMeasure" name="queryIsMeasure" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						
						
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
				</form>
			</div>
			<@sec.authorize access= "hasAuthority('hourData:peconhourdata:add')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newPeConHourData()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('hourData:peconhourdata:edit')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editPeConHourData()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('hourData:peconhourdata:delete')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deletePeConHourData()">删除</a>
			</@sec.authorize>
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/hourData/peconhourdata/peConHourDataList"
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
							<th field="peId" width="10">企业ID</th>
							<th field="outputId" width="10">点位ID</th>
							<th field="measureTime" width="10">监测时间</th>
							<th field="pluCode" width="10">因子代码</th>
							<th field="chromaMin" width="10">浓度最小值</th>
							<th field="chromaAvg" width="10">浓度均值</th>
							<th field="chromaMax" width="10">浓度最大值</th>
							<th field="outputAvg" width="10">排放量</th>
							<th field="outfallType" width="10">点位类型</th>
							<th field="isMeasure" width="10">是否监测</th>
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
						<label class="textbox-label textbox-label-before" title="企业ID">企业ID:</label>
								<select id="peId" name="peId" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="点位ID">点位ID:</label>
								<select id="outputId" name="outputId" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="监测时间">监测时间:</label>
							<input id="measureTime" name="measureTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="因子代码">因子代码:</label>
								<select id="pluCode" name="pluCode" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="浓度最小值">浓度最小值:</label>
								<input id="chromaMin" name="chromaMin" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="浓度均值">浓度均值:</label>
								<input id="chromaAvg" name="chromaAvg" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="浓度最大值">浓度最大值:</label>
								<input id="chromaMax" name="chromaMax" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="排放量">排放量:</label>
								<input id="outputAvg" name="outputAvg" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="点位类型">点位类型:</label>
								<select id="outfallType" name="outfallType" class="easyui-combobox" data-options="editable:true,panelHeight:'auto',panelMaxHeight:'240'"
			                        style="width:200px;">
				                    <option value="" selected="selected">全部状态</option>
				                    <option value="1">启用</option>
				                    <option value="0">禁用</option>
				                </select>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否监测">是否监测:</label>
								<input id="isMeasure" name="isMeasure" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="数据条数">数据条数:</label>
								<input id="dataCount" name="dataCount" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="人工认定">人工认定:</label>
								<input id="personalIdentification" name="personalIdentification" class="easyui-textbox" data-options="validType:'maxLength[10]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="备注">备注:</label>
								<input id="remark" name="remark" class="easyui-textbox" data-options="validType:'maxLength[500]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="报表类型">报表类型:</label>
								<input id="reportType" name="reportType" class="easyui-textbox" data-options="validType:'maxLength[1]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="更新时间">更新时间:</label>
							<input id="updateTime" name="updateTime" class="easyui-datebox" data-options="validType:'checkDate'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePeConHourData()" style="width: 90px">保存</a>
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
				peId: $("#queryPeId").val(),
				outputId: $("#queryOutputId").val(),
				measureTime: $("#queryMeasureTime").val(),
				outfallType: $("#queryOutfallType").val(),
				isMeasure: $("#queryIsMeasure").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newPeConHourData() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增自动监控小时浓度数据');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/hourData/peconhourdata/savePeConHourData';
		}

		function editPeConHourData() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/hourData/peconhourdata/getPeConHourData',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改自动监控小时浓度数据');
						$('#fm').form('load', result.peConHourData);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/hourData/peconhourdata/savePeConHourData';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function savePeConHourData() {
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

		function deletePeConHourData() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/hourData/peconhourdata/deletePeConHourData',
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
