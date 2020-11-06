<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>空气日监测数据</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div  id="searchBar" class="searchBar">
            <form id="searchForm">
                <!-- <input id="queryMonitorTime" name="queryMonitorTime" class="easyui-datebox" data-options="editable:false" label="监测时间:" style="width:220px;"> -->
               <div class="inline-block">
                   <label  class="textbox-label textbox-label-before" title="监测站点">监测站点:</label>
                   <input id="queryPointName" name="queryPointName" class="easyui-textbox" style="width:200px;">
               </div>
               <div class="inline-block">
                   <label  class="textbox-label textbox-label-before" title="监测时间">监测时间：</label>
                   <input id="startTime" name="startTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
               </div>
               <div class="inline-block">
                   <span>-</span>
                   <input id="endTime" name="endTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
               </div>
                <!-- <input id="queryPolluteName" name="queryPolluteName" class="easyui-textbox" label="监测污染物:" style="width:200px;"> -->
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
            </form>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
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
            <th field="monitorTime" width="120px" formatter="Ams.timeDateFormat">监测时间</th>
            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">监测站点</th>
            <!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
            <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
            <th field="aqi" width="120px" formatter="Ams.tooltipFormat">AQI</th>
            <th field="pm25" width="120px" formatter="Ams.tooltipFormat">PM2.5(μg/m3)</th>
            <th field="pm10" width="120px" formatter="Ams.tooltipFormat">PM10(μg/m3)</th>
            <th field="so2" width="120px" formatter="Ams.tooltipFormat">SO2(μg/m3)</th>
            <th field="no2" width="120px" formatter="Ams.tooltipFormat">NO2(μg/m3)</th>
            <th field="o3" width="120px" formatter="Ams.tooltipFormat">O3(μg/m3)</th>
            <th field="co" width="120px" formatter="Ams.tooltipFormat">CO(mg/m3)</th>
        </tr>
        </thead>
    </table>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    
    $(function(){
		$('#startTime').datebox('setValue',getNowDate(6).substring(0,10));
		$('#endTime').datebox('setValue',getNowDate(0).substring(0,10));
		doSearch();
	});
	
	$('#startTime').datebox().datebox('calendar').calendar({
        validator: function(date){
            var now = new Date();
            var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
            return d1>=date;
        }
    });
    $('#endTime').datebox().datebox('calendar').calendar({
         validator: function(date){
                var time = $('#startTime').val().replace(/-/g,"/");
                var d2 = new Date(time);
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                
                return date <= d1 && date >=d2;
        }
    });
    $('#startTime').datebox({
        onSelect: function (select) {
            $('#endTime').datebox('setValue','');
            $('#endTime').datebox().datebox('calendar').calendar({
                validator: function (date) {
                    var d1 = new Date(select);
                    var d3 = new Date();
                    return d1 <= date  && date <= d3;
                }
            });
        }
    });

    function doSearch() {
    	var startTime= $("#startTime").val().trim();
    	var endTime = $("#endTime").val().trim();
    	if(startTime==""||endTime==""){
            $.messager.alert('提示', '时间区间不允许为空！');
            return 0;
        }
    	if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
    		$('#dg').datagrid({
    			url: '${request.contextPath}/enviromonit/airDayData/list',
    		    queryParams: {
    		    	pointName: $("#queryPointName").val().trim(),
    	            startTime: startTime,
    	            endTime: endTime
    		    }
    		});
    	}
        $(".pagination-num").css({width:"73px"})
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        $('#startTime').datebox('setValue',getNowDate(6).substring(0,10));
        $('#endTime').datebox('setValue',getNowDate(0).substring(0,10));
        doSearch();
    }

    function exportData() {
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var queryPointName = $("#queryPointName").val().trim();
        if(startTime==""||endTime==""){
            $.messager.alert('提示', '时间区间不允许为空！');
            return 0;
        }
        if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
            $('#dg').datagrid({
                url: '${request.contextPath}/enviromonit/airDayData/list',
                queryParams: {
                    pointName: queryPointName,
                    startTime: startTime+" 00",
                    endTime: endTime+" 23"
                }
            });
            window.open(Ams.ctxPath + '/enviromonit/airDayData/getListExport?pointName='+queryPointName+'&startTime='+startTime+' 00'+'&endTime='+endTime+' 23');
        }
    }
    
  //获取时间格式化(cutDay为往前几天，0为当天)
	function getNowDate(cutDay) {
		var d = new Date();
		var nowDateTime = d.getTime() - cutDay*60000*60*24;
		d.setTime(nowDateTime);
		var year = d.getFullYear();
		var month = d.getMonth()+1;
		if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
		var date = d.getDate();
	    if (date >= 0 && date <= 9) {
	        date = "0" + date;
	    }
		var hours = d.getHours();
		if (hours >= 0 && hours <= 9) {
	        hours = "0" + hours;
	    }
		var minutes = d.getMinutes();
		if (minutes >= 0 && minutes <= 9) {
	        minutes = "0" + minutes;
	    }
		var seconds = d.getSeconds();
		if (seconds >= 0 && seconds <= 9) {
	        seconds = "0" + seconds;
	    }
		var currentdate = year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
	    return currentdate;
	}
  
	function isNoEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == "" || obj.length == 0){
	        return false;
	    }else{
	        return true;
	    }
	}
</script>
</body>
</html>