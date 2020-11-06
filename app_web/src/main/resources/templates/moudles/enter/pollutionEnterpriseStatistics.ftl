<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
<title>污染源统计管理</title>
	<#include "/header.ftl"/>
	<script type="text/javascript" src="${request.contextPath}/static/js/macarons.js"></script>
</head>
<body>
	<#include "/common/loadingDiv.ftl" />
	<div class="home-panel">
		<div id="statisticsByCodeEntertype" style="height:350px;"></div>
		<div id="statisticsByCodeRegion" style="height:350px;top: 40px;"></div>
		<div class="easyui-layout" fit=true style="margin-top: 50px">
			<table id="dg" class="easyui-datagrid" tyle="width: 100%; height: auto;" toolbar="#toolbar"

				   data-options="
							rownumbers:false,
							singleSelect:true,
							striped:true,
							autoRowHeight:false,
							fitColumns:false,
							fit:true,
							pagination:true,
							pageSize:15 ,
							pageList:[15]">
				<thead>
				<tr>
					<th field="codeRegionName" width="10%">行政区名称</th>
					<th field="codeRegionCount" width="10%">污染源总数</th>
					<th field="corpCodeCount" width="10%">匹配工商法人数量</th>
					<th field="tertiaryIndustryCount" width="10%">第三产业</th>
					<th field="smallEnterpriseCount" width="10%">小型企业</th>
					<th field="livestockBreedingCount" width="10%">畜禽养殖业</th>
					<th field="sewagePlantCount" width="10%">污水处理厂</th>
					<th field="generalIndustryCount" width="10%">一般工业企业</th>
					<th field="buildingOperationsCount" width="10%">建筑施工</th>
					<th field="otherCount" width="10%">其他</th>
				</tr>
				</thead>
			</table>
		</div>
	</div>
	<script>
		$.parser.onComplete = function () {
			$("#loadingDiv").fadeOut("normal", function () {
				$(this).remove();
			});
		};

      //客服端分页
		fillData();
        function fillData() {
			$.ajax({
				type: 'POST',
				url:"${request.contextPath}/enter/pollutionEnterpriseStatistics/getPollutionEnterpriseAllStatisticsListByCodeRegion",
				success: function (data) {
					$('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData',data);
				},
				dataType: 'json'
			});

		}
      function pagerFilter(data){
			if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
				data = {
					total: data.length,
					rows: data
				}
			}
			var dg = $(this);
			var opts = dg.datagrid('options');
			var pager = dg.datagrid('getPager');
			pager.pagination({
				onSelectPage:function(pageNum, pageSize){
					opts.pageNumber = pageNum;
					opts.pageSize = pageSize;
					pager.pagination('refresh',{
						pageNumber:pageNum,
						pageSize:pageSize
					});
					dg.datagrid('loadData',data);
				}
			});
			if (!data.originalRows){
				data.originalRows = (data.rows);
			}
			var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
			var end = start + parseInt(opts.pageSize);
			data.rows = (data.originalRows.slice(start, end));
			return data;
		}



		var statisticsByCodeRegion;
		statisticsByCodeRegion = echarts.init(document.getElementById('statisticsByCodeRegion'),'macarons');
		statisticsByCodeRegionBarOption = {
			title : {
				text: '污染源数量统计'
			},
			tooltip : {
				trigger: 'axis',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend: {
				data:['污染源数量','匹配工商法人数量']
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
				left : '1%',
				right : '1%',
				containLabel : true
			},
			calculable : true,
			xAxis : [
				{
					type : 'category',
					axisLabel : {
						interval : 0,
						rotate:20
					}
				}
			],
			yAxis : [
				{
					type : 'value',
					name : '污染源数量'
				},
				{
					type : 'value',
					name : '已匹配数量'
				}
			],
			series : [
				{
					name : '污染源数量',
					type : 'bar',
					data : []
				},{
					name : '匹配工商法人数量',
					type : 'line',
					yAxisIndex : 1,
					data : []
				}
			]
		};
		statisticsByCodeRegion.setOption(statisticsByCodeRegionBarOption);
		statisticsByCodeRegion.showLoading();
		getPollutionEnterpriseStatisticsByCodeRegion();
		function getPollutionEnterpriseStatisticsByCodeRegion() {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/enter/pollutionEnterpriseStatistics/getPollutionEnterpriseStatisticsByCodeRegion',
				success: function (data) {
					statisticsByCodeRegion.hideLoading();

					var codeRegionName= [];
					var codeRegionCount = [];
					var corpCodeCount = [];
					$.each(data,function(i){
						codeRegionName.push(data[i].codeRegionName);
						codeRegionCount.push(data[i].codeRegionCount);
						corpCodeCount.push(data[i].corpCodeCount);
					});
					var max = calMax([codeRegionCount, corpCodeCount]);
					statisticsByCodeRegion.setOption({//加载数据图表
						xAxis: [{
							data:  codeRegionName
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
						}

						],
						series: [{

							data: codeRegionCount,
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
								}
							}
						},{
							data: corpCodeCount
						}]
					});
				},
				dataType: 'json'
			});
		}

		var statisticsByCodeEntertype;
		statisticsByCodeEntertype = echarts.init(document.getElementById('statisticsByCodeEntertype'),'macarons');
		statisticsByCodeEntertypeBarOption = {
			title : {
				text: '污染源类型比例',
				x:'center'
			},
			tooltip : {
				trigger: 'item',
				formatter: "{a} <br/>{b} : {c} ({d}%)"
			},
			legend: {
				x : 'center',
				y : 'bottom',
				data : []
			},
			toolbox: {
				show : true,
				feature : {
					mark : {show: true},
					dataView : {show: true, readOnly: false},
					magicType : {
						show: true,
						type: ['pie', 'funnel'],
						option: {
							funnel: {
								x: '25%',
								width: '50%',
								funnelAlign: 'left'
							}
						}
					},
					restore : {show: true},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			series : [
				{
					name:'污染源类型比例',
					type:'pie',
					radius : '55%',
					center: ['50%', '50%'],
					data : []
				}
			]
		};
		statisticsByCodeEntertype.setOption(statisticsByCodeEntertypeBarOption);
		statisticsByCodeEntertype.showLoading();
		getPollutionEnterpriseStatisticsByCodeEntertype();
		function getPollutionEnterpriseStatisticsByCodeEntertype() {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/enter/pollutionEnterpriseStatistics/getPollutionEnterpriseStatisticsByCodeEntertype',
				success: function (data) {
					statisticsByCodeEntertype.hideLoading();

					var codeEntertypeName= [];
					var codeEntertypeSeries = [];
					$.each(data,function(i){
						codeEntertypeName.push(data[i].codeEntertypeName);
						var json = {};
						json.value = data[i].codeEntertypeCount;
						json.name = data[i].codeEntertypeName;
						codeEntertypeSeries.push(json);
					});
					statisticsByCodeEntertype.setOption({
						//加载数据图表
						legend: {
							data : codeEntertypeName
						},
						series : [{
							data : codeEntertypeSeries
						}]
					});
				},
				dataType: 'json'
			});
		}

		//getPollutionEnterpriseAllStatisticsByCodeRegion();
		function getPollutionEnterpriseAllStatisticsByCodeRegion() {
			$.ajax({
				type: 'POST',
				url: Ams.ctxPath + '/enter/pollutionEnterpriseStatistics/getPollutionEnterpriseAllStatisticsByCodeRegion',
				success: function (data) {
					console.log(data);
				},
				dataType: 'json'
			});
		}

		//计算最大值
		function calMax(arr) {
			var max = 0;
			arr.forEach(function(el, index, arr) {
				el.forEach(function(el1, index, el) {
					if (!(el1 === undefined || el1 === '')) {
                        if ( Number(max) <  Number(el1)) {
							max = el1;
						}
					}
				});
			});
			var maxint = Math.ceil(max / 9.5);//不让最高的值超过最上面的刻度
			var maxval = maxint * 10;//让显示的刻度是整数
			return maxval;
		}

		//计算最小值
		function calMin(arr) {
			var min = 0;
			arr.forEach(function(el, index, arr) {
				el.forEach(function(el1, index, el) {
					if (!(el1 === undefined || el1 === '')) {
						if ( Number(min) >  Number(el1)) {
							min = el1;
						}
					}
				});
			});
			var minint = Math.floor(min / 10);
			var minval = minint * 10;//让显示的刻度是整数
			return minval;
		}

</script>
</body>
</html>
