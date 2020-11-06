<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
<title>点位查询</title><#include "/header.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/testing.css">

<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/upload/webuploader.css">
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/font.css" />
<link rel="stylesheet" href="${request.contextPath}/static/iconfont/iconfont.css" />
<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/common.ui.css" />
<script src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script src="${request.contextPath}/static/upload/webuploader.js"></script>
<script src='${request.contextPath}/static/js/fileUpload.js'></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>

<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css" />
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

	<!-- datagrid -->
		<div class="easyui-layout" fit=true>
			<div id="toolbar">
				<div style="padding:3px;" id="searchBar">
					<form id="searchForm">
						<div class="form-group">
							<select name="queryType" id="queryType"
								class="easyui-combobox" data-options="editable:false"
								label="数据类型:" style="width:220px;">
								<option value="分钟" selected="selected">分钟数据</option>
								<option value="小时">小时数据</option>
								<option value="day">天数据</option>
								<option value="month">月数据</option>
							</select>
							<label class="control-label">时间范围：</label>
								<input id="startTime" name="startTime" class="easyui-datebox" data-options="value:'Today'"
									style="width: 150px;">
								<input id="endTime" name="endTime" class="easyui-datebox" data-options="value:'Today'"
									style="width: 150px;">
							<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
							<a href="${request.contextPath}/env/pollution/TestData/getData?pointuuid=${pointUuid}" class="easyui-linkbutton" data-options="iconCls:'icon-add'">折线</a>
							<!-- 	<a href="${request.contextPath}/env/pollution/TestData/getTrend?point=${pointUuid}&test_type=分钟&startTime=&endTime=" class="easyui-linkbutton"
							 data-options="iconCls:'icon-add'">折线</a> -->
							<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
								data-options="iconCls:'icon-arrow_refresh_small'"
								onclick="doReset()">重置</a> -->
						</div>
					</form>
				</div>
			</div>
			
			<table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/env/pollution/TestData/list?pointUuid=${pointUuid!}" data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:false,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:10,
            pageList:[10,30,50]"></table>
            <div class="data-details-container">
				<div class="data-details-chart" >
					<div id="waterQualityRate" style="height: 420px; width: 80%; display: inline-block;"></div>
				</div>
			</div>
		</div>
	<script>
	    $.parser.onComplete = function () {
	        $("#loadingDiv").fadeOut("normal", function () {
	            $(this).remove();
	        });
	    };
		var columnArr = [];
		var columns = JSON.parse('${columns}');
		for(var i in columns) {
			if(columns[i].hasOwnProperty("formatter") ){
				columns[i]['formatter']=valueFormat;
			}
		}
		columnArr.push(columns);
		var limit = JSON.parse('${limit}');
		$('#dg').datagrid({
			columns : columnArr
		});
		
		function valueFormat(value, row, index) {
	        if (undefined == value || '' == value) {
	            return "";
	        } else {
	        	for(var i in limit){
	        		if(value == row[limit[i].field]){
	        			if(limit[i].max!='' && limit[i].max<row[limit[i].field]) {
	        			return "<span title='" + value + "' style='color:#F00'>" + value + "</span>";
	        			} else if (limit[i].min!='' && limit[i].min>row[limit[i].field]){
	        				return "<span title='" + value + "' style='color:#F00'>" + value + "</span>";
	        			}else{
	        				return "<span title='" + value + "' >" + value + "</span>";
	        			}
	        		}
	        	}
	        }
	        
	    }
	
		function doSearch() {
			$('#dg').datagrid('load', {
				test_type : $("#queryType").val().trim(),
				startTime : $("#startTime").val().trim(),
				endTime : $("#endTime").val().trim()
			});
		}
	
	
		function doReset() {
			$("#searchBar").find("#searchForm").form('clear');
			doSearch();
		}
	</script>
</body>
</html>