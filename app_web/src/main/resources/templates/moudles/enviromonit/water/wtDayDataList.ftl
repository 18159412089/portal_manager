<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>在线水日监测数据</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div id="searchBar" class="searchBar">
            <form id="searchForm">
            	<div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="选择站点">选择站点：</label>
                    <input class="easyui-combobox" name="pointName" id="pointName" prompt="全部" data-options="
						url:'/enviromonit/water/wtCityPoint/getPointsList?type=2',
						editable:false,
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:true,
						panelHeight:'350px'"
                           style="width:156px;height:33px;">
				</div>
				<div class="inline-block">
                    <label  class="textbox-label textbox-label-before" title="监测时间">监测时间：</label>
                    <input id="startTime" name="startTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
				</div>
            	<div class="inline-block">
                    <span>-</span>
                    <input id="endTime" name="endTime" class="easyui-datebox" required="true" data-options="editable:false" style="width:156px;">
				</div>
                <a href="javascript:void(0)" class="easyui-linkbutton  btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
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
            <th field="monitorTime" width="140px" formatter="Ams.tooltipFormat">监测时间</th>
            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">监测站点</th>
            <th field="w01010" width="120px" formatter="Ams.redFontFormat">水温</th>
            <th field="w01001" width="120px" formatter="Ams.redFontFormat">PH值</th>
            <th field="w01009" width="120px" formatter="Ams.redFontFormat">溶解氧</th>
            <th field="w01014" width="120px" formatter="Ams.redFontFormat">电导率</th>
            <th field="w01003" width="120px" formatter="Ams.redFontFormat">浑浊度</th>
            <th field="w01019" width="120px" formatter="Ams.redFontFormat">高锰酸盐指数</th>
            <th field="w21003" width="120px" formatter="Ams.redFontFormat">氨氮（NH3-N）</th>
            <th field="w21011" width="120px" formatter="Ams.redFontFormat">总磷（以P计）</th>
            <th field="w21001" width="120px" formatter="Ams.redFontFormat">总氮（以氮计）</th>
            <th field="targetQuality" width="60px" formatter="Ams.tooltipFormat">目标水质</th>
            <th field="resultQuality" width="60px" formatter="Ams.tooltipFormat">测试水质</th>
            <th field="polluteNames" width="160px" formatter="Ams.tooltipFormat">超标污染物</th>
        </tr>
        </thead>
    </table>
</div>
<script>
	
	$(function(){
		$('#startTime').datebox('setValue',getNowDate(29).substring(0,10));
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
			 	var start = $('#startTime').val().replace(/-/g,"/");
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return d1>=date && new Date(start) <=date;
		}
    });
	
    $('#startTime').datebox({
        onSelect: function (select) {
        	$('#endTime').datebox('setValue','');
            $('#endTime').datebox().datebox('calendar').calendar({
                validator: function (date) {
                    // var startDate = $('#startDate').datebox('getValue');
                    var d1 = new Date(select);
                    var d3 = new Date();
                    return d1 <= date && date <= d3;
                }
            });
        }
    });
	

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function doSearch() {
    	var startTime= $("#startTime").val().trim();
    	var endTime = $("#endTime").val().trim();
    	if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
    		$('#dg').datagrid({
    			url: '${request.contextPath}/enviromonit/water/wtDayData/getPageList',
    		    queryParams: {
    		    	pointName: $("#pointName").val().trim(),
    	            startTime: startTime,
    	            endTime: endTime
    		    }
    		});
    	}
    	
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        $('#startTime').datebox('setValue',getNowDate(29).substring(0,10));
        $('#endTime').datebox().datebox('calendar').calendar({
            validator: function (date) {
            	var start = $('#startTime').datebox('getValue').replace(/-/g,"/");
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return d1>=date && new Date(start) <=date;
            }
        });
        $('#endTime').datebox('setValue',getNowDate(0).substring(0,10));
        doSearch();
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
    function exportData() {
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var pointName = $("#pointName").val().trim();
        if(startTime==""||endTime==""){
            $.messager.alert('提示', '时间区间不允许为空！');
            return 0;
        }
        if(isNoEmpty(startTime)&&isNoEmpty(endTime)){
            $('#dg').datagrid({
                url: '${request.contextPath}/enviromonit/water/wtDayData/getPageList',
                queryParams: {
                    pointName: pointName,
                    startTime: startTime+" 00",
                    endTime: endTime+" 23"
                }
            });
            window.open(Ams.ctxPath + '/enviromonit/water/wtDayData/export?pointName='+pointName+'&startTime='+startTime+' 00'+'&endTime='+endTime+' 23');
        }
    }
</script>
</body>
</html>