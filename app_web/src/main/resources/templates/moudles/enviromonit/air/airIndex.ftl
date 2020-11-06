<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>大气环境</title>
	
</head>
<!-- body -->
<body style="overflow: auto;">
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl"/>
<input style="display: none;" id="pid" value="${pid!}">
<#include "/secondToolbar.ftl">
<div class="container container-top">
    <!-- 空气 main -->
    <!-- 空气 main -->
		<div class="column-panel-table">
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title"> 空气质量统计分析 </span>
					</div>
					<div class="column-panel-body">
						<div class="article-area tc yl-article-area">
							<a class="title-link-tag" href="javascript:void(0)" onclick="clickSkip2('AQI','4')" style="right: 5%;">详情</a>
							<div class="title" id="airTitle" ></div>
						</div>
						<!-- 本年优良率与上年同期对比 -->
						<div id="airStandardPie" style="width: 100%;height: 340px;"></div>
					</div>
				</div>
			</div>
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-body">
						<div class="article-area tc yl-article-area">
							<div id="information">
								<!--<p>截止12月04日，本市市空气质量优良天数<span class="highlight">312</span>，优良率<span class="highlight">95%</span>，与2016年同期相比<span class="highlight">减少10天</span>。</p>-->
							</div>
                            <a class="title-link-tag" href="javascript:void(0)" onclick="clickSkip2('AQI','5')" style="right: 5%;">详情</a>
						</div>
						<!-- 近三十日全市AQI -->
						<div id="airChart" class="oh" style="width: 100%;height: 340px;"></div>
						<div class="box-top">
							<div class="grade-legend">
								<div class="legend">
									<span class="item excellent"></span><span
										style="color: #000000">优</span> <span class="item good"></span><span
										style="color: #000000">良</span> <span class="item mild"></span><span
										style="color: #000000">轻度</span> <span class="item moderate"></span><span
										style="color: #000000">中度</span> <span class="item severe"></span><span
										style="color: #000000">重度</span> <span class="item dangerous"></span><span
										style="color: #000000">严重</span> <span class="item"></span><span
										style="color: #000000">暂无数据</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="column-panel-group  col-xs-12"><!-- col-lg-6 -->
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title"> <span class="title-time">1-6月份</span>市区大气优良比例排名情况
						</span>
						<a class="title-link-tag" href="javascript:void(0)" onclick="exportExl('0')" style="right: 5%;">导出</a>
					</div>
					<div class="column-panel-body column-table" >
						<table id="bug" class="easyui-datagrid"
							cellpadding="0" cellspacing="0"></table>
						<table id="airComplianceRateDG" class="easyui-datagrid"
							style="width: 100%; height: 150px;"
							data-options="
									rownumbers:false,
					                striped:false,
									fitColumns:true">
							<thead>
								<tr>
									<th rowspan="2" field="city" width="60">城市</th>
									<th rowspan="2" field="badDay" width="60">超标天数</th>
									<th rowspan="2" field="standard" width="60">达标比例</th>
									<th colspan="4" align="center">超标污染物/天</th>
									<th rowspan="2" field="exceedingO3" width="60">臭氧超标天数占比</th>
								</tr>
								<tr>
									<th field="PM2Day" width="30">PM2.5</th>
									<th field="PM10Day" width="30">PM10</th>
									<th field="NO2Day" width="30">NO2</th>
									<th field="O3Day" width="30">O3</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<br>
			<div class="column-panel-group col-xs-12"><!-- col-lg-6 -->
				<div class="column-panel" >
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title"> <span class="title-time">1-6月份</span>我市六项指标单项质量指数占比情况
						</span>
						<a class="title-link-tag" href="javascript:void(0)" onclick="exportExl('1')" style="right: 5%;">导出</a>
					</div>
					<div class="column-panel-body column-table" >
						<table id="zb" class="easyui-datagrid"
							style="width: 100%; height: 250px;"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th field="name" width="60"></th>
									<th field="SO2" width="60">SO2</th>
									<th field="NO2" width="60">NO2</th>
									<th field="PM10" width="60">PM10</th>
									<th field="PM25" width="60">PM2.5</th>
									<th field="O3" width="60">O3(90%)</th>
									<th field="CO" width="60">CO(95%)</th>
									<th field="total" width="60">空气质量综合指数</th>
								</tr>
							</thead>
						</table>
						<p class="text-remark">从单项质量指数分析，<span id="zb-factory">O3、PM10</span>两项污染物单项质量分数贡献率总和占比高达<span id="zb-index">47.7%</span>，直接决定我市空气质量综合指数高低。</p>
					</div>
				</div>
			</div>
			<div class="column-panel-group col-xs-12"><!-- col-lg-6 -->
				<div class="column-panel" >
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title"> <span class="title-time">1-6月份</span>我市六项指标同比变化情况
						</span>
						<a class="title-link-tag" href="javascript:void(0)" onclick="exportExl('2')" style="right: 5%;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="tb" class="easyui-datagrid"
							style="width: 100%; height: 250px;"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th field="name" width="60"></th>
									<th field="SO2" width="60">SO2</th>
									<th field="NO2" width="60">NO2</th>
									<th field="PM10" width="60">PM10</th>
									<th field="PM25" width="60">PM2.5</th>
									<th field="O3" width="60">O3(90%)</th>
									<th field="CO" width="60">CO(95%)</th>
									<th field="total" width="60">空气质量综合指数</th>
								</tr>
							</thead>
						</table>
						<p class="text-remark">
							<p class="text-remark">环境空气质量综合指数<span id="tb-aqi">4.60</span>，同比<span id="tb-index">上升6.6%</span>；
						6项主要污染物其中<span id="tb-factory">PM2.5</span> 浓度超过二级浓度限值。</p>
						</p>
					</div>
				</div>
			</div>
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title" id="SameTimeCompare"> <span
							class="title-time">1-6月份</span>漳州市11个县市区同期对比（综合指数）
						</span>
						<a class="title-link-tag" href="javascript:void(0)" onclick="exportExl('3')" style="right: 5%;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="SameTimeCompareDG" class="easyui-datagrid"
							style="width: 100%; height: 725px;"
							data-options="
									rownumbers:true,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th rowspan="2" field="name" width="120">县（市/区）</th>
									<th colspan="3" align="center">综合指数</th>
									<th colspan="3" align="center">SO2</th>
									<th colspan="3" align="center">NO2</th>
									<th colspan="3" align="center">PM10</th>
									<th colspan="3" align="center">PM2.5</th>
									<th colspan="3" align="center">CO-95%</th>
									<th colspan="3" align="center">O3-90%</th>
								</tr>
								<tr>
									<th field="totalIAQI" width="60">综合指数</th>
									<th field="totalTB" width="60">同比(%)</th>
									<th field="totalINDEX" width="60" styler="color">全市</th>
									<th field="SO2C" width="60">浓度</th>
									<th field="SO2TB" width="60">同比(%)</th>
									<th field="SO2INDEX" width="60" styler="color">全市</th>
									<th field="NO2C" width="60">浓度</th>
									<th field="NO2TB" width="60">同比(%)</th>
									<th field="NO2INDEX" width="60" styler="color">全市</th>
									<th field="PM10C" width="60">浓度</th>
									<th field="PM10TB" width="60">同比(%)</th>
									<th field="PM10INDEX" width="60" styler="color">全市</th>
									<th field="PM25C" width="60">浓度</th>
									<th field="PM25TB" width="60">同比(%)</th>
									<th field="PM25INDEX" width="60" styler="color">全市</th>
									<th field="COC" width="60">浓度</th>
									<th field="COTB" width="60">同比(%)</th>
									<th field="COINDEX" width="60" styler="color">全市</th>
									<th field="O3C" width="60">浓度</th>
									<th field="O3TB" width="60">同比(%)</th>
									<th field="O3INDEX" width="60" styler="color">全市</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
						<span class="title"> <span class="title-time">1-6月份</span>漳州市11个县市区同期对比（大气优良率）
						</span>
						<a class="title-link-tag" href="javascript:void(0)" onclick="exportExl('4')" style="right: 5%;">导出</a>
					</div>
					<div class="column-panel-body column-table">
						<table id="airQualityByYearDG" class="easyui-datagrid"
							style="width: 100%; height: 800px;"
							data-options="
					       			fitColumns:true,
									rownumbers:false,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th rowspan="3" field="pointName" align="center" width="120">县（市/区）</th>
									<th rowspan="2" colspan="3" align="center" width="120">空气质量达标率%</th>
									<th rowspan="2" colspan="2" align="center" width="120">轻度污染天数</th>
									<th colspan="8" align="center" width="120">轻度污染天数分布情况</th>
								</tr>
								<tr>
									<th colspan="2" align="center">PM2.5</th>
									<th colspan="2" align="center">PM10</th>
									<th colspan="2" align="center">NO2</th>
									<th colspan="2" align="center">O3-8h</th>
								</tr>
								<tr>
									<th field="reach" align="center" width="60">达标率</th>
									<th field="reachYear" align="center" width="60">同比</th>
									<th field="rank" align="center" width="60">全市排名</th>
									<th field="polluteDay" align="center" width="60">天数</th>
									<th field="polluteDayYear" align="center" width="60">同比</th>
									<th field="PM2Day" align="center" width="60">天数</th>
									<th field="PM2DayYear" align="center" width="60">同比</th>
									<th field="PM10Day" align="center" width="60">天数</th>
									<th field="PM10DayYear" align="center" width="60">同比</th>
									<th field="NO2Day" align="center" width="60">天数</th>
									<th field="NO2DayYear" align="center" width="60">同比</th>
									<th field="O3Day" align="center" width="60">天数</th>
									<th field="O3DayYear" align="center" width="60">同比</th>

								</tr>
							</thead>
						</table>
						<p class="text-remark">备注：2018年2月16日诏安县首要污染物为PM10和PM2.5；2017年3月18日龙文区首要污染物为NO2和PM2.5。</p>
					</div>
				</div>
			</div>
			<!--
			<div class="column-panel-group col-xs-12">
				<div class="column-panel">
					<div class="column-panel-header">
						<!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>
						<span class="title"> <span class="title-time">1-6月份</span>气候条件分析
						</span>
					</div>
					<div class="column-panel-body column-table">
						<table class="easyui-datagrid" style="width: 100%; height: 380px;"
							url="${request.contextPath}/sys/role/list"
							data-options="
									rownumbers:false,
					                striped:true,
									fitColumns:true">
							<thead>
								<tr>
									<th field="name" width="120">名称</th>
									<th field="code" width="120">编号</th>
									<th field="num" width="60">排序</th>
									<th field="remark" width="60">备注</th>
									<th field="updateDate" width="100">修改时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			-->




		</div>
   
    <!-- 空气 main over -->

</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		//年月选择器
		var date=new Date();
		var year = date.getFullYear();
		var initYear = year;
		var endYear = year;
		
		var startTime = laydate.render({
			elem: '#queryStartTime',
			type: 'month',
			format: 'yyyy-M',
			max: getNowDate(0)+"-1",
			value: year+"-1",
			showBottom: false,
			ready: function(date){
				initYear=date.year;
			},
			change: function(value, date, endDate){
				var selectYear = date.year; 
				var differ = selectYear-initYear; 
				if (differ == 0) { 
					if($(".layui-laydate").length){ 
						$("#queryStartTime").val(value); 
						$(".layui-laydate").remove(); 
						$("#queryEndTime").val("");
					} 
				} 
				initYear = selectYear;
				if($("#queryStartTime").val()==value){
					var d2 = new Date();
					endTime.config.max = {
						year: date.year,
						month: date.year<d2.getFullYear()?11:d2.getMonth(),
						date: date.date
					};
					endTime.config.min = {
							year: date.year,
							month: date.month-1,
							date: date.date
					}
				}
		  	}
		});
		//年月选择器
		var endTime = laydate.render({
			elem: '#queryEndTime',
			type: 'month',
			format: 'yyyy-M',
			value: date,
			max: getNowDate(0)+"-1",
			min: year+"-1-1",
			showBottom: false,
			ready: function(date){
				endYear=date.year;
			},
			change: function(value, date, endDate){
				var selectYear = date.year; 
				var differ = selectYear-endYear; 
				if (differ == 0) { 
					if($(".layui-laydate").length){ 
						$("#queryEndTime").val(value); 
						$(".layui-laydate").remove(); 
					} 
				} 
				endYear = selectYear;
		  	}
		});
		
	});
		
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            doSearch();
        });
        
    };
    
    var placeHolderStyle = {
	    normal: {
	        color: '#f2f2f2'
	    },
	    emphasis: {
	        color: '#f2f2f2'
	    }
	};
    
	var airStandardPie = echarts.init(document.getElementById('airStandardPie'));
	var airChart = echarts.init(document.getElementById('airChart'));
    $(function () {
    	/*---------------------------------------空气-------------------------------------------*/
    	setAirChartBaroption();
    	setAirStandardPieOption();
    });
    
    $(window).resize(function () {

    });
	
	function exportExl(type){
		var date=new Date;
		var year=date.getFullYear(); 
		var month=date.getMonth()+1;
		var startTime = year+"-01";
		var endTime = year+"-"+month;
		if(type == "0"){
			window.location.href = "${request.contextPath}/environment/airComplianceRate/list?export=yes&startTime="+startTime+"&endTime="+endTime;
		} else if(type == "1"){
			window.location.href = "${request.contextPath}/environment/debrief/getSixFactoryQualityZB?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "2"){
			window.location.href = "${request.contextPath}/environment/debrief/getSixFactoryQualityTB?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "3"){
			window.location.href = "${request.contextPath}/environment/debrief/getCompareCounty?export=yes&startTime="+startTime+"&endTime="+endTime;
		}else if(type == "4"){
			window.location.href = "${request.contextPath}/environment/AirQualityByYear/getAirYearOnYearAnalysis?export=yes&startTime="+startTime+"&endTime="+endTime;
		}
	}
	
	function doSearch(){
		var date=new Date;
		var year=date.getFullYear(); 
		var month=date.getMonth()+1;
		var startTime = year+"-01";
		var endTime = year+"-"+month;
		
		$('.title-time').html(startTime+" ~ "+endTime);
		$('#zb').datagrid({
			url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityZB',
			queryParams:{
				startTime:startTime,
				endTime:endTime
			}
		});
		$.ajax({
			type: 'POST',
            url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityZBRemark',
            async:true,
            data:{
            	startTime:startTime,
            	endTime:endTime
            },
            success: function (data) {
            	$("#zb-factory").val(data.one+"、"+data.two);
            	$("#zb-index").html(data.value);
            }
		});
		$.ajax({
			type: 'POST',
			url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTB',
			async:true,
			data:{
				startTime:startTime,
				endTime:endTime
			},
			success: function (data) {

				console.info(data);
				data.pop()
				$("#tb").datagrid("loadData", data);

			}
		});
		// $('#tb').datagrid({
		//     url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTB',
		//     queryParams:{
		//     	startTime:startTime,
		//     	endTime:endTime
		//     },
		// 	onLoadSuccess:function(data){
		//     	console.info(data);
		// 	}
		// });
		$.ajax({
			type: 'POST',
            url: Ams.ctxPath + '/environment/debrief/getSixFactoryQualityTBRemark',
            async:true,
            data:{
            	startTime:startTime,
            	endTime:endTime
            },
            success: function (data) {
            	$("#tb-aqi").html(data.aqi);
            	$("#tb-index").html(data.value);
            	$("#tb-factory").html(data.factory);
            }
		});
		$('#SameTimeCompareDG').datagrid({   
		    url: Ams.ctxPath + '/environment/debrief/getCompareCounty',
		    queryParams:{
		    	startTime:startTime,
		    	endTime:endTime
		    }
		});
		$('#airQualityByYearDG').datagrid({   
		    url: Ams.ctxPath + '/environment/AirQualityByYear/getAirYearOnYearAnalysis',
		    queryParams:{
		    	startTime:startTime,
		    	endTime:endTime
		    }
		});
		$('#airComplianceRateDG').datagrid({   
		    url: Ams.ctxPath + '/environment/airComplianceRate/list',
		    queryParams:{
		    	startTime:startTime,
		    	endTime:endTime
		    }
		});
		getAirQualityStatistics(startTime,endTime);
		getAirChartBaroption();
	}
	
	/*---------------------------------------空气质量数据-------------------------------------------*/	
	function getAirChartBaroption(){
		$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airDayData/airQuantityForLastMonth',
            async:true,
            success: function (data) {
	            airChart.hideLoading();
	            var xAxis = data.xAxis;
	            var now = data.data;
	            var value = now[0].data;
	            var aqi = [];
	            var color = [];
				$.each(value,function(i){ 
					
					if(value[i] == null){
						color.push('#b8b8b8');
						aqi.push("-");
					}else if(value[i] >= 0 && value[i]<=50){
						color.push('#00E400');
						aqi.push(value[i]);
					}else if(value[i] <= 100){
						color.push('#FFFF00');
						aqi.push(value[i]);
					}else if(value[i] <= 150){
						color.push('#FF7E00');
						aqi.push(value[i]);
					}else if(value[i] <= 200){
						color.push('#FF0000');
						aqi.push(value[i]);
					}else if(value[i] <= 300){
						color.push('#99004C');
						aqi.push(value[i]);
					}else if(value[i] <= 500){
						color.push('#7E0023');
						aqi.push(value[i]);
					}
				});
               airChart.setOption({        //加载数据图表
                    xAxis:xAxis,
                     yAxis : [{
				            type : 'value'
				        }],
                     series: [{
                        data: aqi,
                        type: 'bar',
						 right:'0',
				        itemStyle: {
				            normal: {
				                // 定制显示（按顺序）
				                color: function(params) { 
				                    var colorList = color; 
				                    return colorList[params.dataIndex] 
				                }
				            },
				        },
                    }]
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
	            airChart.hideLoading();
	        },
            dataType: 'json'
        });
	}
	
	
	function getAirQualityStatistics(startTime,endTime){
    	
    	$.ajax({
			type: 'POST',
			url: Ams.ctxPath + '/environment/AirQualityStatistics/list',
			data:{startTime:startTime,endTime:endTime},
			async:true,
			success: function (result) {
                airStandardPie.hideLoading();
                   var last = result.lastArray;
                   var now = result.now;
                   var info = result.info;
                   airStandardPie.setOption({        //加载数据图表
                color:["#FF4040","#33ff33"],
                legend: {
	       	    	orient: 'vertical',
	                top: '40',
	                left:'14',
					right:'0',
	       	        data:[last[0].name,now[0].name]
	       	    },
                    series: [{
       	            name:last[0].name,
       	            type:'pie',
       	            radius: [100, 118],
       	         	center: ['50%', '56%'],
       	         	hoverAnimation: false,
       	            clockWise: false,
       	            startAngle: 90,
       	            data:[
       	                {value:last[0].maxValue, name:last[0].name,label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14,}, itemStyle: {normal: {color:'#FF4040'}}},
       	                {value:last[0].minValue, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
       	            ]},{
       	            name:now[0].name,
       	           	type:'pie',
       	            radius: [60, 86],
       	         	center: ['50%', '56%'],
       	         	hoverAnimation: false,
       	            clockWise: false,
       	            startAngle: 90,
       	            data:[
       	                {value:now[0].maxValue, name:now[0].name,label: {formatter: '{b}：{d}%',backgroundColor: '#fff',fontSize: 14}, itemStyle: {normal: {color:'#33ff33'}}},
       	                {value:now[0].minValue, name:'', itemStyle: placeHolderStyle,tooltip: {show: false},labelLine: {show: false}}
       	            ]}
       	            ]});
       	            var html ="<p>截止"+info[0].time+"，本市市空气质量优良天数<span class='highlight'>"+info[0].day
       	            +"</span>，优良率<span class='highlight'>"+info[0].rate+"</span>，与"+info[0].lastYear
       	            +"年同期相比<span class='highlight'>"+info[0].info+"</span>。</p>"
       	            
       	             $("#information").html(html);
       	             $("#airTitle").html(info[0].nowYear+"年空气质量现状")
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	airStandardPie.clear();
                	$.messager.alert('提示', '本年优良率与去年同期对比，暂无数据！');
                	
		        },
                dataType: 'json'
        });
    }
	/*---------------------------------------空气质量数据-------------------------------------------*/
    function setAirChartBaroption(){
    	airChartBaroption = {
   	    	title: {
   		        text: '过去30天AQI情况',
   		        left:'center',
   		        textStyle: {
   					color: '#000000',
   					fontSize:'14',
   					fontWeight:'normal'
   				}
   		    },              
   	        tooltip : {
   	            trigger: 'axis',
   	            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
   	                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
   	            },
   	            formatter:function(params) {
   	            	var result = '';
   	                params.forEach(function (item) {
   	                    result += item.axisValue + "</br>" +item.marker + " " + "AQI指数" + " : " + item.value +"</br>";
   	                });
   	            	return result;
   	            }
   	        },
   	        legend: {
   	            show:false,
   	        },
   	        toolbox: {
   	            show: true,
   	            feature: {
   	                magicType: {type: [ 'bar']},
   	                restore: {}
   	            },
   	            right: '5%',
   	            iconStyle: {
   	                borderColor: '#000000'
   	            }
   	        },                
   	        grid: {
   	            top:'35',
   	            left: '3%',
   	            right: '5%',
   	            bottom: '35',
   	            containLabel: true
   	        },
   	        xAxis : {
   	            type : 'category',
   				axisLine:{
   					lineStyle:{
   						color: '#000000'
   					}
   				}
   	            
   	        },
   	        yAxis :{
   	            type : 'value',
   	            axisLine:{
   	            	lineStyle:{
   	                	color: '#000000'
   	                }
   	            },
   	            splitLine:{
   	            	lineStyle:{
   	            		opacity:0.5
   	            	}
   	            }
   	        },                
   	        textStyle:{
   	        	color: '#000000'
   	        },
   	        series : [
   	            {
   	                name:'AQI指数',
   	                type:'bar',
   	                barWidth: '60%',
   	                data:[],
   	            }
   	        ]

   	    };
   	    airChart.setOption(airChartBaroption);
   	    airChart.showLoading();
	}
	function setAirStandardPieOption(){
		var airStandardPieOption ={
	       		title: {
			        text: '本年优良率与上年同期对比',
	                top: '10',
			        left:'center',
			        textStyle: {
						fontSize:'16',
						fontWeight:'normal'
					}
			    },        
	       	    tooltip: {
	       	        trigger: 'item',
	       	        formatter: "{a} <br/>{b}: {d}%"
	       	    }
	       	};
	        airStandardPie.setOption(airStandardPieOption);
	        //airStandardPie.showLoading();
	}
    	
    
	//获取时间格式化(cutDay为往前几天，0为当天)
	function getNowDate(cutDay) {
		var d = new Date();
		var nowDateTime = d.getTime() - cutDay*60000*60*24;
		d.setTime(nowDateTime);
		var year = d.getFullYear();
		var month = d.getMonth()+1;
		var date = d.getDate();
		var currentdate = year+"-"+month;
	    return currentdate;
	}
	
	function clickSkip2(type,category){ 
		window.open('/env/mainPage/main2.do?pid=423700b7-ea65-4327-8917-150b954ce349&type='+type+'&category='+category);
	}
    
	function color(value, row, index) {
		return 'background-color:#FFFF00;color:#ffffff'
	}
</script>

</body>

</html>