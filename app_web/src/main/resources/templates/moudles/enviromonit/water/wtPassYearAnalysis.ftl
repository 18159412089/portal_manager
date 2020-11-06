<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> 
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>站点污染物往年同比</title> <#include "/header.ftl"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/testing.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/progressbar.css" />
	<link rel="stylesheet" type="text/css"
		href="${request.contextPath}/static/css/base.css" />
	
	<script type="text/javascript"
		src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript"
		src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
	<script type="text/javascript"
		src="${request.contextPath}/static/js/progressbar.js"></script>
</head>
<!-- body -->
<body ondragstart="return false" style="background: #ffffff;">
	<div class="data-details-container">
		<div class="data-details-search">
			<div class="form-group">
				<label for="riverSystem" class="control-label">选择站点：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryPoint" id="queryPoint" data-options="
						url:'${request.contextPath}/enviromonit/water/wtCityPoint/getPointsList?type=2',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'350px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label for="riverSystem" class="control-label">比较因子：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryFactor" id="queryFactor" data-options="
						url:'${request.contextPath}/enviromonit/water/wtHourData/getPollutes',
						method:'get',
						valueField:'key',
						textField:'text',
						multiple:false,
						panelHeight:'170px'"
						style="width:150px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label for="riverSystem" class="control-label">比较年份：</label>
				<div class="control-div">
					<input class="easyui-combobox" name="queryYear" id="queryYear" data-options="
						url:'${request.contextPath}/enviromonit/water/wtDayData/getYearList',
						method:'get',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'130px'"
						style="width:100px;height:30px;">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">时间步长：</label>
				<div class="control-div">
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="Day" checked/>
						<span class="lbl">天</span>
					</label>
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="Week"/>
						<span class="lbl">周</span>
					</label>
					<label class="form-radio">
						<input name="queryTimeUnit" type="radio" value="Month"/>
						<span class="lbl">月</span>
					</label>
				</div>
			</div>
			<div class="form-group">
				<div class="control-label">
					<button class="btn btn-primary" type="submit" onclick="doSearch()">
						<span class="fa-search mr6"></span>查询
					</button>
				</div>
			</div>
		</div>
		<div class="data-details-chart" id="parent0">
			<div id="pollutionAnalysis0" style="height: 350px;width:100%; display: inline-block;"></div>
		</div>
	</div>

	<script type="text/javascript">
	
		$.parser.onComplete = function () {
		    $("#loadingDiv").fadeOut("normal", function () {
		        $(this).remove();
		    });
		};
	
		$(function() {
			
		});
		function doSearch(){
			var type = $('input[name="queryTimeUnit"]:checked').val();
			var point = $('#queryPoint').combobox('getValue');
			var pollutes = $('#queryFactor').combobox('getValue');
			var year = $('#queryYear').combobox('getValue');
			if(point == "" || point == null || point == undefined){
				$.messager.alert('提示', '请选择查询站点！');
			}else if(pollutes == "" || pollutes == null || pollutes == undefined){
				$.messager.alert('提示', '请选择查询因子！');
			}else if(year == "" || year == null || year == undefined){
				$.messager.alert('提示', '请选择比较年份！');
			}else{
				$.ajax({
					type: "post",
					url:  Ams.ctxPath + "/enviromonit/water/wt"+type+"Data/getPassYearAnalysis",
					data : {
						pollutes:pollutes, 
						pointCode:point,
						startTime:year
					},
					dataType: "json",
					success: function(data){
						var pollutionAnalysis = echarts.init(document.getElementById('pollutionAnalysis0'));
						setEcharts(pollutionAnalysis, data.legend, data.title, data.formatter, data.xAxis, data.series);
					},
					error: function(r){console.log(r);}
				});
			}
		}
		
		function setEcharts(pollutionAnalysis, legend, title, formatter, xAxis, series){
			pollutionAnalysis.clear();
    		var option = {
                    title: {
                        text: title,
                        textStyle:{
                            fontSize: 16
        				},
                        left:'10',
        				top:'10'
                    },
                    tooltip : {
                        trigger: 'axis',
                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    toolbox: {
                        show: true,
                        orient: 'vertical',
                        left: '10',
                        top: 'center',
                        iconStyle: {
                        	borderColor: '#ffffff'
                        },
                        feature: {
                            magicType: {show: true, type: ['line', 'bar']},
                            saveAsImage: {show: true},
                            restore: {show: true}
                        }
                    },
                    legend: {
                        orient: 'horizontal',
                        top: '8%',
                        right:'30',                        
                        data: legend
                    },
                    grid: {
                        top:'80',
                        left: '50',
                        right: '30',
                        bottom: '10',
                        containLabel: true
                    },
                    xAxis:  {
                        type: 'category',
                        axisLabel:{
                            type:'category'
                        },
                        data: xAxis
                    },
                    yAxis: {
                        type: 'value',
                        axisLabel:{
                            formatter: formatter
                        }
                    },
                    series: series
                };
    		pollutionAnalysis.setOption(option);
    	}
	</script>
</body>
</html>
