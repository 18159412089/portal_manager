<#ftl attributes={ "content_type":"text/html;charset=UTF-8"}> <#assign
	sec=JspTaglibs[ "http://www.springframework.org/security/tags"] />
<html lang="en">
<head>
<title>水质月检测数据统计表</title>
<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

	<!-- datagrid -->
	<div class="easyui-layout" fit=true>
		<div id="toolbar">
			<div  id="searchBar" class="searchBar">
				<form id="searchForm">
					<label class="control-label">选择站点：</label>
					<input
						class="easyui-combobox" name="pointName" id="pointName"
						prompt="全部"
						data-options=" 
						url:'${request.contextPath}/enviromonit/water/wtMonthMonitor/list',
						editable:false,
						method:'get',
						valueField:'text',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
						style="width: 156px; height: 33px;"> <label
						class="control-label">选择年份：</label> <input class="easyui-combobox"
						name="queryYear" id="queryYear"
						data-options="
						url:'${request.contextPath}/enviromonit/water/wtDayData/getYearList',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'130px'"
						style="width: 100px; height: 30px;"> <a href="javascript:void(0)"
						class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'"
						onclick="doSearch()">查询</a>
				</form>
			</div>
		</div>
		<table id="dg" class="easyui-datagrid"
			style="width: 100%; height: auto;" toolbar="#toolbar"
			data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[20,50,100]">
			<thead>
				<tr>
					<th field="basinName" width="79px" formatter="Ams.tooltipFormat">断面名称</th>
					<th field="yearNumber" width="70px" formatter="Ams.tooltipFormat">年</th>
					<th field="monthNumber" width="70px" formatter="Ams.redFontFormat">月</th>
					<th field="basinName" width="140px" formatter="Ams.redFontFormat">所属流域</th>
					<th field="phValue" width="80px" formatter="Ams.redFontFormat">ph</th>
					<th field="rjyValue" width="80px" formatter="Ams.redFontFormat">溶解氧</th>
					<th field="gmsyValue" width="120px" formatter="Ams.redFontFormat">高锰酸盐指数</th>
					<th field="bodValue" width="120px" formatter="Ams.redFontFormat">五日生化需氧量</th>
					<th field="andanValue" width="120px" formatter="Ams.redFontFormat">氨氮</th>
					<th field="zlValue" width="70px" formatter="Ams.tooltipFormat">总磷</th>
					<th field="targetQuality" width="140px"
						formatter="Ams.redFontFormat">目标水质</th>
					<th field="resultQuality" width="120px"
						formatter="Ams.redFontFormat">测试水质</th>
				</tr>
			</thead>
		</table>
	</div>
	<script src="${request.contextPath}/static/layui/layui.js"
		charset="utf-8"></script>
	<script>
		$.parser.onComplete = function() {
			$("#loadingDiv").fadeOut("normal", function() {
				$(this).remove();
			});
		};
		$(function() {
			doSearch()
		})
		function doSearch() {
			var pointName = $('#pointName').combobox('getValues') + "";
			var year = $("#queryYear").val();

			$('#dg')
					.datagrid(
							{
								url : '${request.contextPath}/environment/wtQualityData/getPageList',
								queryParams : {
									pointName : $("#pointName").val().trim(),
									year : year,
								}
							});

		}

		function isNoEmpty(obj) {
			if (typeof obj == "undefined" || obj == null || obj == ""
					|| obj.length == 0) {
				return false;
			} else {
				return true;
			}
		}
		
	</script>
</body>
</html>