<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
		"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>优良变化天数</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/progressbar.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/base.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/testing.css" />

<script type="text/javascript" src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>
<style type="text/css">
	input[readonly]{
		background-color: #fff;
	}
</style>
</head>
<body ondragstart="return false" style="background:#ffffff;">

	<div class="data-details-container">
		<div class="data-details-search">
			<div class="form-group">
				<label class="control-label">行政区：</label>
				<div class="control-div">
					<input id="queryArea" class="easyui-combobox"  name="queryArea" style="height: 32px; width: 140px;" 
			        	data-options="
			        		url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
			        		method:'post',
			        		editable:false,
			        		valueField:'uuid',
			        		textField:'name',
			        		multiple:false,
			        		panelHeight:'auto'">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label">开始日期：</label>
				<div class="control-div">
					<input id="queryStartTime" name="queryStartTime" data-options="editable:false" class="easyui-datebox"style="width: 128px; height:34px;">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label">结束日期：</label>
				<div class="control-div">
					<input id="queryEndTime" name="queryEndTime" data-options="editable:false" class="easyui-datebox"  style="width: 128px; height:34px;">
				</div>
			</div>
			
			<div class="form-group">
				<label class="control-label">对比年数：</label>
				<div class="control-div">
					<select class="form-control" style="width:50px;" name="yearNum" id="yearNum">
						<option value="2" selected="selected">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary" type="submit" onclick="doSearch()"><span class="fa-search mr6"></span>查询</button>
				</div>
			</div>
		</div>

		<div class="data-details-chart">
			<div id="historyAirQuality" style="height:320px;width:100%;"></div>
		</div>
		<div class="easyui-layout" fit=true style="margin-top:20px">
		<table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           		data-options="
		            rownumbers:true,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:false,
		            fitColumns:true,
		            fit:true,
		            pagination:true,
		            pageSize:10,
		            pageList:[10,30,50]">
	        	<thead>
		        <tr>
		        	<th field="year" width="50px" align="center">年度</th>
		        	<th field="adArea" width="80px" align="center">行政区</th>
		        	<th field="timeRange" width="150px" align="center">时间范围</th>
		        	<th field="efDays" width="50px" align="center">有效监测天数</th>
		        	<th field="eclDays" width="50px" align="center">优天数</th>
		        	<th field="goodDays" width="50px" align="center">良天数</th>
		        	<th field="ratio" width="50px" align="center">优良天数比例</th>
		        	<th field="lowerDays" width="50px" align="center">劣于二级天数</th>
		        	<th field="aqi300" width="50px" align="center">AQI > 300 天数</th>
		        </tr>
		        </thead>
	    	</table>
		</div>


	</div>
<script type="text/javascript">
	$(function() {
		var date=new Date();

		$('#queryArea').combobox('setValue','350600');
		$("#queryStartTime").datebox('setValue', date.getFullYear()+"-01-01");
		$("#queryEndTime").datebox('setValue', FormatDate(date.setDate(date.getDate())));
		
		
		doSearch();
	});
	$('#queryStartTime').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return d1>=date;
		}
	});
	$('#queryEndTime').datebox().datebox('calendar').calendar({
		 validator: function(date){
		 		var time = $('#queryStartTime').val().replace(/-/g,"/");
				var d2 = new Date(time);
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				
				return date <= d1 && date >=d2;
		}
    });
    $('#queryStartTime').datebox({
        onSelect: function (select) {
        	$('#queryEndTime').datebox('setValue','');
            $('#queryEndTime').datebox().datebox('calendar').calendar({
                validator: function (date) {
                    // var startDate = $('#startDate').datebox('getValue');
                    var d1 = new Date(select);
                    var d2 = new Date(select.getFullYear(),'11','31');
                    var d3 = new Date();
                    return d1 <= date && date <= d2 && date <= d3;
                }
            });
        }
    });
	
	function doSearch(){
		var pointCode = $('#queryArea').val();
		var queryStartTime = $("#queryStartTime").val();
		var queryEndTime = $("#queryEndTime").val();
		if(queryStartTime==""||queryEndTime==""){
			$.messager.alert('提示', '时间区间不允许为空！');
		}else if (queryStartTime.slice(0,4) != queryEndTime.slice(0,4)){
			$.messager.alert('提示', '时间区间须同一年度！');
		}else{
			/*---------------------------------------该地区各级别天数历年对比-------------------------------------------*/
			$.ajax({
				type : 'POST',
				url : '${request.contextPath}/enviromonit/airQuality/getAllLevelsDays',
				async : true,
				data:{
					category : "daily",
					pointCode : pointCode,
					startTime : queryStartTime,
					endTime : queryEndTime,
					yearNum : $("#yearNum").val()
				},
				success : function(result) {
					var historyAirQualityChart = echarts.init(document.getElementById('historyAirQuality'));
					setHistoryAirQualityChartData(historyAirQualityChart, result.years, result.series);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$.messager.alert('提示', '本地区各级别天数历年对比，暂无数据！');
				},
				dataType : 'json'
			});
			
			$('#dg').datagrid({
			    url:'${request.contextPath}/enviromonit/airQuality/list',
			    queryParams: {
			    	category : 'daily',
			    	pointCode : $('#queryArea').val(),
			    	startTime : $("#queryStartTime").val(),
			    	endTime : $("#queryEndTime").val(),
			    	yearNum : $('#yearNum').val()
	           	}
			});
		}
		
		
	}
	
	function setHistoryAirQualityChartData(historyAirQualityChart, years, series){
		historyAirQualityChart.clear();
		// 基于准备好的dom，初始化echarts实例
		var option = {
				title: {
					text: '本地区各级别天数历年对比',
					left: 'center',
					top: 20,
					textStyle: {
						color: '#464646',
						fontSize:'14',
						fontWeight:'normal'
					}
				},
				tooltip: {
					trigger: 'axis'
				},
				toolbox: {
					show: false
				},
				legend: {
					top: 50,
					data:['优天数', '良天数', '劣于二级天数']
				},
				grid: {
					top:'25%',
					left: '3%',
					right: '4%',
					bottom: '10%',
					containLabel:true
				},
				xAxis:  {
					type: 'category',
					boundaryGap:false,
					data: years

				},
				yAxis: {
					type: 'value',
					name:'天',
					nameTextStyle: {
						color: '#2ba4e9',
						fontSize: '12'
					},
					nameGap:10
				},
				series:series
			};
		//使用刚指定的配置项和数据显示图表。
		historyAirQualityChart.setOption(option,true);
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
	function FormatDate(str) {
			var date = new Date(str);
	        var seperator1 = "-";
	        var year = date.getFullYear();
	        var month = date.getMonth() + 1;
	        var strDate = date.getDate();
	        if (month >= 1 && month <= 9) {
	            month = "0" + month;
	        }
	        if (strDate >= 0 && strDate <= 9) {
	            strDate = "0" + strDate;
	        }
	        var currentdate = year + seperator1 + month + seperator1 + strDate;
	        return currentdate;
	}
</script>
</body>
</html>