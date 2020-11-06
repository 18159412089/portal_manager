<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>风险源基本信息管理</title> 
	<#include "/header.ftl"/>
	<script type="text/javascript" src="${request.contextPath}/static/js/macarons.js"></script>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<div class="home-panel">
		<div class="home-panel-body">
			<div id="airChart" style="height:500px;"></div>
		</div>
	</div>
	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
				$(this).remove();
			});
		};
		var airChart;
		airChart = echarts.init(document.getElementById('airChart'),'macarons');
		airChartBarOption = {
			title : {
				text: '风险源信息统计'
			},
			tooltip : {
				trigger: 'axis',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend: {
				data:['风险源数量','风险单元数量']
			},
			toolbox: {
				show : true,
				feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			grid: {
				left: '5%',
				right: '5%',
				containLabel: true
			},
			calculable : true,
			xAxis : [
				{
					type : 'category',
					axisLabel: {
						interval:0
					}
				}
			],
			yAxis : [
				{
					type : 'value',
					name : '风险源数量'
				},
				{
					type : 'value',
					name : '风险单元数量'
				}
			],
			series : [
				{
					name:'风险源数量',
					type:'bar',
					data:[]
				},{
					name : '风险单元数量',
					type : 'line',
					yAxisIndex : 1,
					data : []
				}
			]
		};
		airChart.setOption(airChartBarOption);
		airChart.showLoading();
		getRiskStatistics();
		function getRiskStatistics() {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/risk/riskBaseStatistics/getRiskStatistics',
				success: function (data) {
					airChart.hideLoading();

					var fkRegionName= [];
					var fkRegionCount = [];
					var riskUnitCount = [];
					$.each(data,function(i){
						fkRegionName.push(data[i].fkRegionName);
						fkRegionCount.push(data[i].fkRegionCount);
						riskUnitCount.push(data[i].riskUnitCount);
					});
					var max = calMax([fkRegionCount,riskUnitCount]);
					console.log(max);
					airChart.setOption({        //加载数据图表
						xAxis: [{
							data:  fkRegionName
						}],
						yAxis : [{
							type : 'value',
							min: 0,
							max: max,        // 计算最大值
							interval: Math.ceil(max / 5),   //  平均分为5份
						},{
							type : 'value',
							min: 0,
							max: max,        // 计算最大值
							interval: Math.ceil(max / 5),   //  平均分为5份
						}],
						series: [{

							data: fkRegionCount,
							label: {
								normal: {
									show: true,
									position: 'top'
								}
							},
							itemStyle: {
								normal: {
									// 随机显示
									color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}
								},
							},
						},{
							data: riskUnitCount
						}]
					});
				},
				dataType: 'json'
			});
		}
		//计算最大值
		function calMax(arr) {
			var max = 0;
			arr.forEach(function(el, index, arr){
				el.forEach(function(el1, index, e1){
					if (!(el1 === undefined || el1 === '')) {
						console.log("e："+el1);
						if ( Number(max) <  Number(el1)) {
							console.log("max："+max);
							max = el1;
						}
						console.log("a："+max);
					}
				})
			})
			var maxint = Math.ceil(max / 9.5);//不让最高的值超过最上面的刻度
			var maxval = maxint * 10;//让显示的刻度是整数
			return maxval;
		}

		//计算最小值
		function calMin(arr) {
			var min = 0;
			arr.forEach(function(el, index, arr){
				el.forEach(function(el1, index, e1){
					if (!(el1 === undefined || el1 === '')) {
						if ( Number(min) >  Number(el1)) {
							min = el1;
						}
					}
				})
			})
			var minint = Math.floor(min / 10);
			var minval = minint * 10;//让显示的刻度是整数
			return minval;
		}
</script>
</body>
</html>
