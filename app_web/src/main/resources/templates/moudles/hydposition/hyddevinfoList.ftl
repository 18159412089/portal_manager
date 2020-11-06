<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>水电站设备基本信息管理</title> 
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
                        <label  class="textbox-label textbox-label-before" title="流域编码">流域编码:</label>
                        <input id="queryRiverCode" name="riverCode" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="点位名称">点位名称:</label>
                       <input id="queryNAME" name="NAME" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="承建单位联系人">承建单位联系人:</label>
                       <input id="queryBUILDER" name="BUILDER" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="承建单位">承建单位:</label>
                       <input id="querySysBuilder" name="sysBuilder" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="承担部门">承担部门:</label>
                       <input id="queryChargeDept" name="chargeDept" class="easyui-textbox" style="width: 200px;"><br/>
				   </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="容量">容量:</label>
                      <input id="queryCapacity" name="capacity" class="easyui-textbox" style="width: 200px;">
				  </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="下游水库">下游水库:</label>
                      <input id="queryDownReservoir" name="downReservoir" class="easyui-textbox" style="width: 200px;">
				  </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="行政区划名称">行政区划名称:</label>
                        <input id="queryRgnName" name="rgnName" class="easyui-textbox" style="width: 200px;">
					</div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="行政区划编码">行政区划编码:</label>
                       <input id="queryRgnCode" name="rgnCode" class="easyui-textbox" style="width: 200px;">
				   </div>
                   <div class="inline-block">
                       <label  class="textbox-label textbox-label-before" title="上游水库">上游水库:</label>
                       <input id="queryUpReservoir" name="upReservoir" class="easyui-textbox" style="width: 200px;"><br/>
				   </div>
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="地址">地址:</label>
                        <input id="queryADDR" name="ADDR" class="easyui-textbox" style="width: 200px;">
					</div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="联系人">联系人:</label>
                      <input id="queryCONTACTER" name="CONTACTER" class="easyui-textbox" style="width: 200px;">
				  </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="最大蓄水位">最大蓄水位:</label>
                      <input id="queryMaxWaterLevel" name="maxWaterLevel" class="easyui-textbox" style="width: 200px;">
				  </div>
                  <div class="inline-block">
                      <label  class="textbox-label textbox-label-before" title="流域名称">流域名称:</label>
                      <input id="queryRiverName" name="riverName" class="easyui-textbox" style="width: 200px;">
				  </div>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
				</form>
			</div>
			<!-- 
			<@sec.authorize access= "hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')" > 
				<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newHyddevinfo()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editHyddevinfo()">修改</a>
				<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteHyddevinfo()">删除</a>
			</@sec.authorize>
			 -->
		</div>
		<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar" 
				url="${request.contextPath}/hydposition/hyddevinfo/hyddevinfoList"
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
					<th formatter="Ams.tooltipFormat" field="riverCode" width="10%">流域编码</th>
					<th formatter="Ams.tooltipFormat" field="riverName" width="10%">流域名称</th>
					<th formatter="Ams.tooltipFormat" field="NAME" width="10%">点位名称</th>
					<th formatter="Ams.tooltipFormat" field="normalWaterLevel" width="10%">正常蓄水位</th>
					<th formatter="Ams.tooltipFormat" field="totalCapacity" width="10%">总容量</th>
					<th formatter="Ams.tooltipFormat" field="capacity" width="10%">容量</th>
					<th formatter="Ams.tooltipFormat" field="BUILDER" width="10%">承建单位联系人</th>
					<th formatter="Ams.tooltipFormat" field="downReservoir" width="10%">下游水库</th>
					<th formatter="Ams.tooltipFormat" field="minWaterLevel" width="10%">最小蓄水位</th>
					<th formatter="Ams.tooltipFormat" field="rgnName" width="10%">行政区划名称</th>
					<th formatter="Ams.tooltipFormat" field="rgnCode" width="10%">行政区划编码</th>
					<th formatter="Ams.tooltipFormat" field="upReservoir" width="10%">上游水库</th>
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
				<input name="riverCode" id="riverCode" class="easyui-textbox" required="true" label="流域编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="normalWaterLevel" id="normalWaterLevel" class="easyui-textbox" required="true" label="正常蓄水位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="NAME" id="NAME" class="easyui-textbox" required="true" label="点位名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="totalCapacity" id="totalCapacity" class="easyui-textbox" required="true" label="总容量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="OVERVIEW" id="OVERVIEW" class="easyui-textbox" required="true" label="概况:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="BUILDER" id="BUILDER" class="easyui-textbox" required="true" label="承建单位联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="sysBuilder" id="sysBuilder" class="easyui-textbox" required="true" label="承建单位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="hydropowerId" id="hydropowerId" class="easyui-textbox" required="true" label="设备ID:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="chargeDept" id="chargeDept" class="easyui-textbox" required="true" label="承担部门:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="capacity" id="capacity" class="easyui-textbox" required="true" label="容量:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="contacterTel" id="contacterTel" class="easyui-textbox" required="true" label="联系电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="downReservoir" id="downReservoir" class="easyui-textbox" required="true" label="下游水库:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LATITUDE" id="LATITUDE" class="easyui-textbox" required="true" label="纬度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="minWaterLevel" id="minWaterLevel" class="easyui-textbox" required="true" label="最小蓄水位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="rgnName" id="rgnName" class="easyui-textbox" required="true" label="行政区划名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="rgnCode" id="rgnCode" class="easyui-textbox" required="true" label="行政区划编码:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="upReservoir" id="upReservoir" class="easyui-textbox" required="true" label="上游水库:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="builderTel" id="builderTel" class="easyui-textbox" required="true" label="承建单位电话:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="LONGITUDE" id="LONGITUDE" class="easyui-textbox" required="true" label="经度:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="ADDR" id="ADDR" class="easyui-textbox" required="true" label="地址:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="CONTACTER" id="CONTACTER" class="easyui-textbox" required="true" label="联系人:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="maxWaterLevel" id="maxWaterLevel" class="easyui-textbox" required="true" label="最大蓄水位:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
			<div style="margin-bottom: 10px">
				<input name="riverName" id="riverName" class="easyui-textbox" required="true" label="流域名称:" style="width: 100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveHyddevinfo()" style="width: 90px">保存</a>
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
				riverCode: $("#queryRiverCode").val().trim(),
				NAME: 	   $("#queryNAME").val().trim(),
				BUILDER: $("#queryBUILDER").val().trim(),
				sysBuilder: $("#querySysBuilder").val().trim(),
				chargeDept: $("#queryChargeDept").val().trim(),
				capacity: $("#queryCapacity").val().trim(),
			    downReservoir: $("#queryDownReservoir").val().trim(),
				 
				rgnName: $("#queryRgnName").val().trim(),
				rgnCode: $("#queryRgnCode").val().trim(),
				upReservoir: $("#queryUpReservoir").val().trim(),
				 
				ADDR: $("#queryADDR").val().trim(),
				CONTACTER: $("#queryCONTACTER").val().trim(),
				maxWaterLevel: $("#queryMaxWaterLevel").val().trim(),
				riverName: $("#queryRiverName").val().trim(),
			});
		}
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}

		function exportData() {
			doSearch();
			window.open(Ams.ctxPath + '/hydposition/hyddevinfo/getListExport' +
					'?riverCode='+$("#queryRiverCode").val().trim()+
					'&NAME='+$("#queryNAME").val().trim()+
					'&BUILDER='+$("#queryBUILDER").val().trim()+
					'&sysBuilder='+$("#querySysBuilder").val().trim()+
					'&chargeDept='+$("#queryChargeDept").val().trim()+
					'&capacity='+$("#queryCapacity").val().trim()+
					'&downReservoir='+$("#queryDownReservoir").val().trim()+
					'&rgnName='+$("#queryRgnName").val().trim()+
					'&rgnCode='+$("#queryRgnCode").val().trim()+
					'&upReservoir='+$("#queryUpReservoir").val().trim()+
					'&ADDR='+$("#queryADDR").val().trim()+
					'&CONTACTER='+$("#queryCONTACTER").val().trim()+
					'&maxWaterLevel='+$("#queryMaxWaterLevel").val().trim()+
					'&riverName='+$("#queryRiverName").val().trim());
		}


		function newHyddevinfo() {
			$('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增水电站设备基本信息');
			$('#fm').form('clear');
			$('#code').textbox({readonly: false});
			url = Ams.ctxPath + '/hydposition/hyddevinfo/saveHyddevinfo';
		}

		function editHyddevinfo() {
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.ajax({
					type: 'POST',
					url: Ams.ctxPath + '/hydposition/hyddevinfo/getHyddevinfo',
					data: {'uuid': row.uuid},
					success: function (result) {
						$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改水电站设备基本信息');
						$('#fm').form('load', result);
						$('#code').textbox({readonly: true});
						url = Ams.ctxPath + '/hydposition/hyddevinfo/saveHyddevinfo';
					},
				dataType: 'json'
				});
			} else {
				$.messager.alert('提示', '请选择一条要编辑的记录！');
			}
		}

		function saveHyddevinfo() {
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

		function deleteHyddevinfo() {
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				$.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
					if (r) {
						$.ajax({
							type: 'POST',
							url: Ams.ctxPath + '/hydposition/hyddevinfo/deleteHyddevinfo',
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
