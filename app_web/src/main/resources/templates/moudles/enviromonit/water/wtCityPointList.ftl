<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水环境城市站点管理</title> 
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
							<label class="textbox-label textbox-label-before" title="流域编码">流域编码:</label>
									<input id="queryCodeWsystem" name="queryCodeWsystem" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="流域名称">流域名称:</label>
									<input id="queryWsystemName" name="queryWsystemName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="区县">区县:</label>
									<input id="queryCodeRegion" name="queryCodeRegion" class="easyui-textbox" style="width: 200px;">
							</div>
						
						<div class="inline-block">
							<label class="textbox-label textbox-label-before" title="流域">流域:</label>
									<input id="queryRegionName" name="queryRegionName" class="easyui-textbox" style="width: 200px;">
							</div>
						
						
						
						
						
						
						
						
						
						
						
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="export1()">导出</a>
				</form>
			</div>
			<#--<@sec.authorize access= "hasAuthority('water:wtcitypoint:add')" >
				<a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newWtCityPoint()">新增</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('water:wtcitypoint:edit')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editWtCityPoint()">修改</a>
			</@sec.authorize>
			<@sec.authorize access= "hasAuthority('water:wtcitypoint:delete')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteWtCityPoint()">删除</a>
			</@sec.authorize>-->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/enviromonit/water/wtCityPoint/wtCityPointList"
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
							<th field="codeWsystem" width="10">流域编码</th>
							<th field="wsystemName" width="10">流域名称</th>
							<th field="codeRegion" width="10">区县</th>
							<th field="regionName" width="10">流域</th>
							<th field="longitude" width="10">经度</th>
							<th field="latitude" width="10">纬度</th>
							<th field="pointQuality" width="10" formatter="Ams.fmtByWtQuality">目标水质</th>
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
								<input id="pointCode" name="pointCode" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="站点名称">站点名称:</label>
								<input id="pointName" name="pointName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流域编码">流域编码:</label>
								<input id="codeWsystem" name="codeWsystem" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流域名称">流域名称:</label>
								<input id="wsystemName" name="wsystemName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="区县">区县:</label>
								<input id="codeRegion" name="codeRegion" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="流域">流域:</label>
								<input id="regionName" name="regionName" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="经度">经度:</label>
								<input id="longitude" name="longitude" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="纬度">纬度:</label>
								<input id="latitude" name="latitude" class="easyui-textbox" data-options="validType:'maxLength[255]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否湖库：0 非湖库，1湖库">是否湖库：0 非湖库，1湖库:</label>
								<input id="pointType" name="pointType" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="目标水质">目标水质:</label>
								<input id="pointQuality" name="pointQuality" class="easyui-textbox" data-options="validType:'maxLength[50]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否有效：0无效 ，1有效">是否有效：0无效 ，1有效:</label>
								<input id="status" name="status" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="备注">备注:</label>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="polygon">polygon:</label>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="lines">lines:</label>
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="类型">类型:</label>
								<input id="category" name="category" class="easyui-textbox" data-options="validType:'maxLength[30]'" style="width: 200px;">
					</div>
					<div style="margin-bottom: 10px">
						<label class="textbox-label textbox-label-before" title="是否显示">是否显示:</label>
								<input id="isview" name="isview" class="easyui-textbox" data-options="validType:'number'" style="width: 200px;">
					</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveWtCityPoint()" style="width: 90px">保存</a>
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
				codeWsystem: $("#queryCodeWsystem").val().trim(),
				wsystemName: $("#queryWsystemName").val().trim(),
				codeRegion: $("#queryCodeRegion").val().trim(),
				regionName: $("#queryRegionName").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
	        doSearch();
		}
		
		function newWtCityPoint() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水环境城市站点');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/water/wtcitypoint/saveWtCityPoint';
		}

		function editWtCityPoint() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/water/wtcitypoint/getWtCityPoint',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水环境城市站点');
						$('#fm').form('load', result.wtCityPoint);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/water/wtcitypoint/saveWtCityPoint';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveWtCityPoint() {
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

		function deleteWtCityPoint() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/water/wtcitypoint/deleteWtCityPoint',
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
        function export1(){
            var pointCode=encodeURI($("#queryPointCode").val().trim());
            var pointName=encodeURI($("#queryPointName").val().trim());
            var codeWsystem=encodeURI($("#queryCodeWsystem").val().trim());
            var wsystemName=encodeURI($("#queryWsystemName").val().trim());
            var codeRegion=encodeURI($("#queryCodeRegion").val().trim());
            var regionName=encodeURI($("#queryRegionName").val().trim());
            window.location.href = "${request.contextPath}/enviromonit/water/wtCityPoint/export" +
					"?pointCode="+pointCode+
                    "&pointName="+pointName+
                    "&codeWsystem="+codeWsystem+
                    "&wsystemName="+wsystemName+
                    "&codeRegion="+codeRegion+
                    "&regionName="+regionName

        }
</script>
</body>
</html>
