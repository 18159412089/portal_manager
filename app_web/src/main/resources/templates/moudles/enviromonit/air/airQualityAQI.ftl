<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<html>
<head>
<title>AQI指数分析</title> <#include "/header.ftl"/>
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
<style type="text/css">
	input[readonly]{
		background-color: #fff;
	}
</style>
</head>
<body>
	<!-- 
	<div class="current-location-container">
		<span class="location">
			<span class="icon fa-home"></span>当前位置：
			<a href="">空气质量日报分析</a>  >
			<span>AQI指数变化分析</span>
		</span>
		<div class="btn btn-empty r"><span class="icon fa-reply"></span> 返回</div>
	</div>
	-->
	<div class="data-details-container">
		
		<div class="data-details-search">
			<div class="form-group">
				<label class="control-label">类型：</label>
				<div class="control-div">
					<!--单选框-->
					<label class="form-radio">
						<input name="radioName" type="radio" value="area"/>
						<span class="lbl">行政区</span>
					</label>
					<label class="form-radio">
						<input name="radioName" type="radio" value="point"/>
						<span class="lbl">测点</span>
					</label>
					<!--单选框-->
				</div>
			</div>
			<div class="form-group" id="area">
				<label class="control-label" id="lb_name">行政区：</label>
				<div class="control-div">
					<input id="queryArea" class="easyui-combobox" name="queryArea" style="height: 32px; width: 140px;" data-options="
						url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
						method:'post',
						editable:false,
						valueField:'uuid',
						textField:'name',
						multiple:false,
						panelHeight:'auto'">
				</div>
			</div>
				<div class="form-group" id="point" style="display:none;">
					<label class="control-label">监测站点：</label>
					<div class="control-div">
						<input id="queryPoint" class="easyui-combobox" name="queryPoint"  style="height: 32px; width: 140px;" data-options="
						url:'${request.contextPath}/enviromonit/airMonitorPoint/getPonitList',
						method:'post',
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'auto'">
					</div>
				</div>

				<div class="form-group">
					<label class="control-label">日期：</label>
					<div class="control-div">
						<input id="queryTime" name="queryTime" data-options="editable:false" class="easyui-datebox" style="width: 128px; height:34px;">
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

		<div class="data-details-chart grade-legend">
			<div id="airQualityDaily" class="oh"
				style="height:320px;width:50%;display:inline-block;">
				<div style="font-size:16px;margin-top:20px;">
					<label class="control-label" id="lb_title"></label>空气质量日报
				</div>
				<div class="fl" style="height:236px;width:180px;margin:20px;">
					<table class="air-quality-daily grade-legend">
						<tbody>
							<tr>
								<td>
									<div class="quality" style="color:black"></div>
									<div class="info-group">
										<span class="tit">AQI：</span><span class="con aqi"></span>
									</div>
									<div class="info-group">
										<span class="tit">首要污染物：</span><span class="con major"></span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="oh" style="position:relative;height:236px;">
					<table class="air-quality-daily" style="width:90%;margin:0 auto;">
						<tr>
							<td>
								<div class="tr">单位：μg/m3</div>
								<table class="table-info">
									<tr>
										<td class="tit">二氧化硫</td>
										<td class="con SO2" id="SO2"></td>
										<td class="tit">二氧化氮</td>
										<td class="con NO2" id="NO2">28</td>
									</tr>
									<tr>
										<td class="tit">一氧化碳</td>
										<td class="con CO" id="CO"></td>
										<td class="tit">臭氧</td>
										<td class="con O3" id="O3"></td>
									</tr>
									<tr>
										<td class="tit">PM2.5</td>
										<td class="con PM25" id="PM25"></td>
										<td class="tit">PM10</td>
										<td class="con PM10" id="PM10"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="airQuality"
				style="height:320px;width:40%;display:inline-block;"></div>
		</div>
		<div class="data-details-chart">
			<div id="aqiIndex" style="width:100%;height:380px;"></div>
		</div>

	</div>
	<script type="text/javascript">
		var className ;
		$(function() {
			
			$("input[name=radioName]").click(function(){
				if($(this).val()=="area"){
					$('#area').show();
					$('#point').hide();
				}
				if($(this).val()=="point"){
					$('#area').hide();
					$('#point').show();
				}
			});
			
			$("input[name='radioName']").get(0).checked=true;  //初始化默认选中"行政区"单选框
			
			$('#queryArea').combobox('setValue','350600');
			$('#queryPoint').combobox('setValue','600601');
			
			var date = new Date();
			$("#queryTime").datebox('setValue', FormatDate(date.setDate(date.getDate())));
			
			doSearch();
		});
		$('#queryTime').datebox().datebox('calendar').calendar({
			validator: function(date){
				var now = new Date();
				var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return d1>=date;
			}
		});
		function doSearch() {
		
			var pointCode;
			var time = $("#queryTime").val();
			
			if($("input[name=radioName]:checked").val()=="area"){
				pointCode = $("#queryArea").val();
			}
			if($("input[name=radioName]:checked").val()=="point"){
				pointCode = $("#queryPoint").val();
			}
			
			$.ajax({
				type : 'POST',
				url : '${request.contextPath}/enviromonit/airQualityAQI/curAirQuantity',
				data:{
					pointCode:pointCode,
					time : time
				},
				async : true,
				success : function(result) {
					var data = result.data;
					$('#lb_title').text(data.title);
					$('.oh .NO2').html(data.NO2);
					$('.oh .O3').html(data.O3);
					$('.oh .PM10').html(data.PM10);
					$('.oh .PM25').html(data.PM25);
					$('.oh .SO2').html(data.SO2);
					$('.oh .CO').html(data.CO);
					$('.fl .quality').removeClass(className);
					$('.fl .quality').addClass(data.quantityColor);
					className = data.quantityColor;
					$('.fl .quality').html(data.quantityText);
					$('.fl .aqi').html(data.aqi);
					$('.fl .major').html(data.pollutant);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$('#lb_title').text("");
					$('.oh .NO2').html("");
					$('.oh .O3').html("");
					$('.oh .PM10').html("");
					$('.oh .PM25').html("");
					$('.oh .SO2').html("");
					$('.oh .CO').html("");
					$('.fl .quality').removeClass(className);
					$('.fl .quality').addClass("item");
					className = "item";
					$('.fl .quality').html("-");
					$('.fl .aqi').html("");
					$('.fl .major').html("");
					$.messager.alert('提示', $("#queryTime").val()+'日报，暂无数据！');
				},
				dataType : 'json'
			});
			
			/*---------------------------------------本年本地区空气质量状况统计图-------------------------------------------*/
			var startTime = time.substring(0,4)+"-01-01";
			$.ajax({
				type : "post",
				url : "${request.contextPath}/enviromonit/airQualityAQI/getAirQualityChart",
				async : true,
				data:{
					category : "daily",
					pointCode:pointCode,
					startTime : startTime,
					endTime : time
				},
				success : function(result) {
					var airQualityChart = echarts.init(document.getElementById('airQuality'));
					setAirQualityYearChartData(airQualityChart, result.data);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$.messager.alert('提示', '本年本地区空气质量状况统计图，暂无数据！');
					setAirQualityYearChartData(airQualityChart, null);
				},
				dataType : 'json'
			});
			
			/*---------------------------------------近30日全市AQI指数变化-------------------------------------------*/
			var endDate = new Date(queryTime);
			$.ajax({
				type : 'POST',
				url : '${request.contextPath}/enviromonit/airQualityAQI/airQuantityForLastMonth',
				async : true,
				data:{
					category : "daily",
					pointCode:pointCode,
					startTime : getBeforeDate(time),
					endTime : time
				},
				success : function(result) {
					var aqiIndexChart = echarts.init(document.getElementById('aqiIndex'));
					setAqiIndexChartData(aqiIndexChart,result.xAxis,result.series);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					$.messager.alert('提示', '近30日AQI指数变化趋势图，暂无数据！');
				},
				dataType : 'json'
			});
		}
	
		function setAqiIndexChartData(aqiIndexChart, time, series){
			aqiIndexChart.clear();
			// 基于准备好的dom，初始化echarts实例
			option = {
			    title: {
			        text: '近30日AQI指数变化趋势图',
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
			    xAxis: {
			        type: 'category',
					boundaryGap : false,
			        data: time
			    },
			    yAxis: {
			        type: 'value',
			        name:'μg/m3',
			        nameTextStyle: {
			        	color: '#2ba4e9',
			        	fontSize: '12'
			        },
			        nameGap:10
			    },
			    series: series
			};
			// 使用刚指定的配置项和数据显示图表。
			aqiIndexChart.setOption(option,true);
		}
		
		function setAirQualityYearChartData(airQualityChart, value){
			airQualityChart.clear();
			// 基于准备好的dom，初始化echarts实例
			var option = {
					title: {
				        text: '本年度空气质量状况统计',
				        left: 'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        top: 35,
				        left: 'right',
				        data: ['优', '良','轻度污染','中度污染','重度污染','严重污染']
				    },
				    series : [
				        {
				            type: 'pie',
				            radius : '65%',
				            center : ['50%', '60%'],
				            selectedMode : 'single',
				            data : value,
				            itemStyle : {
				                emphasis : {
				                    shadowBlur : 10,
				                    shadowOffsetX : 0,
				                    shadowColor : 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};
			// 使用刚指定的配置项和数据显示图表。
			airQualityChart.setOption(option,true);
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
	    function getBeforeDate(datt){
		
		  datt = datt.split('-');
		  var newDate = new Date(datt[0], datt[1] - 1, datt[2]);
		  var befminuts = newDate.getTime() - 1000 * 60 * 60 * 24 * parseInt(30);//计算前几天用减，计算后几天用加，最后一个就是多少天的数量 n为向前或者向后天数
		  var beforeDat = new Date;
		  beforeDat.setTime(befminuts);
		  var befMonth = beforeDat.getMonth() + 1;
		  var mon = befMonth >= 10 ? befMonth : '0' + befMonth;
		  var befDate = beforeDat.getDate();
		  var da = befDate >= 10 ? befDate : '0' + befDate;
		  var newDate = beforeDat.getFullYear() + '-' + mon + '-' + da;
		  return newDate
		}
	</script>
</body>
</html>
