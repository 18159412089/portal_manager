<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>点位查询</title>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

	<!-- datagrid -->
	<div id="pf-bd" style="padding:0">
		<div class="easyui-layout" fit=true>
			<div id="toolbar">
				<div style="padding:3px;" id="searchBar">
					<form id="searchForm">
						<input id="queryCode" name="queryCode" class="easyui-textbox"
							label="点位编号:" style="width:200px;"> <input id="queryName"
							name="queryName" class="easyui-textbox" label="点位名称:"
							style="width:200px;"> <input id="queryRegion"
							name="queryRregion" class="easyui-textbox" label="所属区域:"
							style="width:200px;"> <input id="queryMNCode"
							name="queryMNCode" class="easyui-textbox" label="MN号:"
							style="width:200px;"> <input id="queryType"
							name="queryType" class="easyui-textbox" label="点位类型:"
							style="width:200px;"> <a href="javascript:void(0)"
							class="easyui-linkbutton" data-options="iconCls:'icon-search'"
							onclick="doSearch()">查询</a> <a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-arrow_refresh_small'"
							onclick="doReset()">重置</a>
					</form>
				</div>
			</div>
			<table id="dg" class="easyui-datagrid"
				style="width:100%;height:auto;" toolbar="#toolbar"
				url="${request.contextPath}/env/pollution/point/list"
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
				<thead data-options="frozen:true">
					<tr>
						<th field="code" width="120px" formatter="Ams.tooltipFormat">点位编号</th>
						<th field="name" width="200px" formatter="Ams.tooltipFormat">点位名称</th>
						<th field="region" width="120px" formatter="Ams.tooltipFormat">所属区域</th>
						<th field="envCompany" width="200px" formatter="Ams.tooltipFormat">所属企业</th>
						<th field="mn_code" width="150px" formatter="Ams.tooltipFormat">MN号</th>
						<th field="type" width="100px" formatter="Ams.tooltipFormat">点位类型</th>
						<th field="special_type" width="100px"
							formatter="Ams.tooltipFormat">特殊类型</th>
						<th field="uploadCycle" width="100px"
							formatter="Ams.tooltipFormat">上传周期</th>
						<th field="accessTime" width="150px" formatter="Ams.tooltipFormat">第一次上传数据</th>
						<th field="entrust" width="100px" formatter="Ams.tooltipFormat">是否委托运营商</th>
						<th field="operator" width="100px" formatter="Ams.tooltipFormat">运营商</th>
						<th field="enableClose" width="100px"
							formatter="Ams.tooltipFormat">是否关停</th>
						<th field="concernType" width="100px"
							formatter="Ams.tooltipFormat">关注类型</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script>
		$.parser.onComplete = function() {
			$("#loadingDiv").fadeOut("normal", function() {
				$(this).remove();
			});
		};
	
		function doSearch() {
			$('#dg').datagrid('load', {
				code : $("#queryCode").val().trim(),
				name : $("#queryName").val().trim(),
				region : $("#queryRegion").val().trim(),
				mnCode : $("#queryMNCode").val().trim(),
				type : $("#queryType").val().trim()
			});
		}
	
	
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
	</script>
</body>
</html>