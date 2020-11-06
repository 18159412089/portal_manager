<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
		"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>区域对比分析</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/css/progressbar.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/css/base.css" />
<link rel="stylesheet" type="text/css"
	href="${request.contextPath}/static/testing.css" />

<script type="text/javascript"
	src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript"
	src="${request.contextPath}/static/js/progressbar.js"></script>
<style type="text/css">
	input[readonly]{
		background-color: #fff;
	}
</style>
</head>
<body ondragstart="return false"
	style="padding:20px;background:#ffffff;">

	<div class="data-details-container">
		
		<div class="data-details-search">
			
			<div class="form-group">
				<label class="control-label">日期：</label>
				<div class="control-div">
					<input id="queryDate" name="queryDate" data-options="editable:false" class="easyui-datebox" style="width: 128px; height:34px;">
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

		<div class="data-details-chart">
			<div id="regionalCorrelation" style="height:380px;width:100%;"></div>
		</div>
		<div class="easyui-layout" fit=true style="margin-top:20px">
			<table id="dg" class="easyui-datagrid"
				style="width:100%;height:auto;" toolbar="#toolbar"
				data-options="
		            rownumbers:false,
		            singleSelect:true,
		            striped:true,
		            autoRowHeight:false,
		            fitColumns:true,
		            fit:true,
		            pagination:false,
		            pageSize:10,
		            pageList:[10,30,50]">
				<thead>
					<th field="pointCity" width="100px">行政区</th>
					<th field="aqi" width="100px">AQI</th>
					<th field="lastDayAqi" width="100px">前一天AQI</th>
					<th field="days" width="100px">本年优良天数</th>
					<th field="ratio" width="100px">本年优良率(%)</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>
	<script type="text/javascript">
	$(function() {
		
		
		var date = new Date();
		$("#queryDate").datebox('setValue', FormatDate(date.setDate(date.getDate())));
		
		doSearch();
	});
	
    
    $('#queryDate').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return d1>=date;
		}
	});
	
	
	function doSearch(){
		var queryDate = $('#queryDate').val();
		
		/*---------------------------------------各地区AQI对比分析表格-------------------------------------------*/
		$('#dg').datagrid({
			url: '${request.contextPath}/enviromonit/airQualityArea/list',
		    queryParams: {
		      	category : 'daily',
				startTime: queryDate
		    }
		});
		/*---------------------------------------各地区AQI对比分析-------------------------------------------*/
		// 基于准备好的dom，初始化echarts实例
		$.ajax({
			type : 'POST',
			url : '${request.contextPath}/enviromonit/airQualityArea/getRegionalCorrelation',
			async : true,
			data: {
				category : 'daily',
				startTime : queryDate
			},
			success : function(result) {
				var data=result.data;
				var title = queryDate + " 各地区AQI对比分析图";
				var regionalCorrelationChart=echarts.init(document.getElementById('regionalCorrelation'));
				setRegionalCorrelationChartData(title,regionalCorrelationChart,data.names,data.text,data.aqi,data.rate);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				$.messager.alert('提示', '各地区AQI对比分析图，暂无数据！');
			},
			dataType : 'json'
		});
		
		
	}
	
	function setRegionalCorrelationChartData(title,regionalCorrelationChart,names,text,aqi,rate){
		regionalCorrelationChart.clear();
		option={
			title : {
				text : title,
				left : 'center',
				top : 20,
				textStyle : {
					color : '#464646',
					fontSize : '14',
					fontWeight : 'normal'
				}
			},
			tooltip : {
				trigger : 'axis'
			},
			toolbox : {
				show : false
			},
			legend : {
				top : 50,
				data : names
			},
			grid : {
				top : '25%',
				left : '3%',
				right : '4%',
				bottom : '10%',
				containLabel : true
			},
			xAxis : {
				type : 'category',
				data : text
			},
			yAxis : {
				type : 'value',
				nameTextStyle : {
					color : '#2ba4e9',
					fontSize : '12'
				},
				nameGap : 10
			},
			series : [
				{
					name : 'AQI',
					type : 'bar',
					barWidth : '36',
					itemStyle : {
						normal : {
							color : '#2da5e9'
						}
					},
					data : aqi
				}, {
					name : '本年优良率',
					type : 'line',
					symbol : 'triangle',
					symbolSize : 8,
					smooth : true,
					itemStyle : {
						normal : {
							color : '#95db99'
						}
					},
					data : rate
				}
			]
		}
		// 使用刚指定的配置项和数据显示图表。
		regionalCorrelationChart.setOption(option,true);
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