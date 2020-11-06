<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>地表水断面采测分离水质评价结果</title>
	<#include "/header.ftl"/>
	<link rel="stylesheet" href="/static/layui/css/layui.css"  media="all">
	<style type="text/css">
		.layui-input{
			display: inline;
		}
	</style>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
            	<label class="control-label">选择年月：</label>
            	<input id="yearMonth" type="text" class="layui-input" style="height:35px;width:156px;" readonly="">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
            <!-- <div style="width: 100%;text-align: center;">标题</div> -->
        </div>
    </div>
    
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           data-options="
            rownumbers:false,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            rownumbers:true">
        <thead>
        <tr>
            <th rowspan="2" field="pointName" width="140px" formatter="Ams.tooltipFormat" align="center">断面名称</th>
            <th rowspan="2" field="pointQuality" width="120px" formatter="Ams.tooltipFormat" align="center">国水十条考核目标</th>
            <th colspan="3" width="120px" formatter="Ams.tooltipFormat" align="center">采测分离水质类别</th>
            <th colspan="2" width="120px" formatter="Ams.tooltipFormat" align="center">采测分离超标情况</th>
        </tr>
        <tr>
            <th field="thisMonth" width="120px" formatter="Ams.tooltipFormat">本期</th>
            <th field="lastYear" width="120px" formatter="Ams.tooltipFormat">上年同期</th>
            <th field="lastMonth" width="120px" formatter="Ams.tooltipFormat">上月</th>
            <th field="polluteName1" width="120px" formatter="Ams.tooltipFormat">III类超标项目</th>
            <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">国水十条考核目标超标项目</th>
        </tr>
        </thead>
    </table>
</div>
<script src="/static/layui/layui.js" charset="utf-8"></script>
<script>
	

layui.use('laydate', function(){
	var laydate = layui.laydate;	
	var date=new Date();
	var year = date.getFullYear();
	var initYear = year;
	//年月选择器
	var yearMonth = laydate.render({
		elem: '#yearMonth',
		type: 'month',
		format: 'yyyy-MM',
		value: getNowDate(0),
		max:getNowDate(0),
		showBottom: false,
		ready: function(date){
			initYear=date.year;
		},
		change: function(value, date, endDate){
			var selectYear = date.year; 
			var differ = selectYear-initYear; 
			if (differ == 0) { 
				if($(".layui-laydate").length){ 
					$("#yearMonth").val(value); 
					$(".layui-laydate").remove(); 
				} 
			} 
			initYear = selectYear;
	  	}
	});
	
	window.doReset = function(){
		$("#yearMonth").val(getNowDate(0));
        doSearch();
    }
	
});
	
	$(function(){
		
	});

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            doSearch();
        });
    };

    function doSearch() {
    	var yearMonth= $("#yearMonth").val();
    	if(isNoEmpty(yearMonth)){
    		$('#dg').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtCityHourData/getMonthDataQuality',
    		    queryParams: {
    		    	yearMonth: yearMonth
    		    }
    		});
    	}
    }

	function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
	
	function getNowDate(cutDay) {
		var d = new Date();
		var nowDateTime = d.getTime() - cutDay*60000*60*24;
		d.setTime(nowDateTime);
		var year = d.getFullYear();
		var month = d.getMonth()+1;
		if(month<10){
			month="0"+month;
		}
		var currentdate = year+"-"+month;
	    return currentdate;
	}
</script>
</body>
</html>