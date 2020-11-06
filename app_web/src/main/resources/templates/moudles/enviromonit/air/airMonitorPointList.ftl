<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>空气环境监测站点管理</title> 
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
							<label class="textbox-label textbox-label-before" title="站点编码">站点编码:</label>
									<input id="queryPointCode" name="queryPointCode" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
									<input id="queryPointName" name="queryPointName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="站点级别">站点级别:</label>
									<input id="queryCodeAirlevel" name="queryCodeAirlevel" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="行政区代码">行政区代码:</label>
									<input id="queryCodeRegion" name="queryCodeRegion" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="行政区名称">行政区名称:</label>
									<input id="queryRegionName" name="queryRegionName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="年份">年份:</label>
									<input id="queryYearNumber" name="queryYearNumber" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="export1()">导出</a>
				</form>
			</div>
			<#--<@sec.authorize access= "hasAuthority('air:airmonitorpoint:add')" >
				<a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newAirMonitorPoint()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('air:airmonitorpoint:edit')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editAirMonitorPoint()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('air:airmonitorpoint:delete')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteAirMonitorPoint()">删除</a>
			</@sec.authorize>-->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/enviromonit/airMonitorPoint/airMonitorPointList"
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
							<th field="pointCode" width="10">站点编码</th>
							<th field="pointName" width="10">站点名称</th>
							<th field="pointType" width="10">站点类型</th>
							<th field="codeAirLevel" width="10">站点级别</th>
							<th field="codeRegion" width="10">行政区代码</th>
							<th field="regionName" width="10">行政区名称</th>
							<th field="yearNumber" width="10">年份</th>
							<th field="longitude" width="10">经度</th>
							<th field="latitude" width="10">纬度</th>
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
						<label class="textbox-label textbox-label-before" title="站点编码">站点编码:</label>
								<input id="pointCode" name="pointCode" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
								<input id="pointName" name="pointName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="站点类型：1城市 0定位">站点类型：1城市 0定位:</label>
								<input id="pointType" name="pointType" class="easyui-textbox" data-options="validType:'maxLength[10]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="站点地址">站点地址:</label>
								<input id="pointAddress" name="pointAddress" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="站点级别">站点级别:</label>
								<input id="codeAirlevel" name="codeAirlevel" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="行政区代码">行政区代码:</label>
								<input id="codeRegion" name="codeRegion" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="行政区名称">行政区名称:</label>
								<input id="regionName" name="regionName" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="年份">年份:</label>
								<input id="yearNumber" name="yearNumber" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="经度">经度:</label>
								<input id="longitude" name="longitude" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="纬度">纬度:</label>
								<input id="latitude" name="latitude" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="父节点">父节点:</label>
								<input id="parent" name="parent" class="easyui-textbox" data-options="validType:'maxLength[100]'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveAirMonitorPoint()" style="width: 90px">保存</a>
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
                pointCode: $("#queryPointCode").val().trim(),
                pointName: $("#queryPointName").val().trim(),
                codeAirLevel: $("#queryCodeAirlevel").val().trim(),
                codeRegion: $("#queryCodeRegion").val().trim(),
                regionName: $("#queryRegionName").val().trim(),
                yearNumber: $("#queryYearNumber").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newAirMonitorPoint() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增空气环境监测站点');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/air/airmonitorpoint/saveAirMonitorPoint';
		}

		function editAirMonitorPoint() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/air/airmonitorpoint/getAirMonitorPoint',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改空气环境监测站点');
						$('#fm').form('load', result.airMonitorPoint);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/air/airmonitorpoint/saveAirMonitorPoint';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveAirMonitorPoint() {
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

		function deleteAirMonitorPoint() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/air/airmonitorpoint/deleteAirMonitorPoint',
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
        function export1(){
            var pointCode=encodeURI($("#queryPointCode").val().trim());
            var pointName=encodeURI($("#queryPointName").val().trim());
            var codeAirLevel=encodeURI($("#queryCodeAirlevel").val().trim());
            var codeRegion=encodeURI($("#queryCodeRegion").val().trim());
            var regionName=encodeURI($("#queryRegionName").val().trim());
            var yearNumber=encodeURI($("#queryYearNumber").val().trim());
            window.location.href = "${request.contextPath}/enviromonit/airMonitorPoint/export" +
                    "?pointCode="+pointCode+
                    "&pointName="+pointName+
                    "&codeAirLevel="+codeAirLevel+
                    "&codeRegion="+codeRegion+
                    "&regionName="+regionName+
                    "&yearNumber="+yearNumber
        }
</script>
</body>
</html>
