<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title> 漳州生态云</title>
    
</head>
<!-- body -->
<body style="overflow: auto;background: url('${request.contextPath}/static/images/home_bg.jpg') no-repeat center;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<div id="pf-hd" style="width:100%;height: 110px; background: url('${request.contextPath}/static/images/hearder_bg.png') no-repeat center;">
	
   <div class="pf-user" style="line-height: 86px;">
       
       <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
       <i class="iconfont xiala">&#xe607;</i>

       <div class="pf-user-panel">
           <ul class="pf-user-opt">
               <li>
                   <a href="javascript:;">
                       <i class="iconfont">&#xe60d;</i>
                       <span class="pf-opt-name">用户信息</span>
                   </a>
               </li>
               <li class="pf-modify-pwd">
                   <a href="#" id="editpass">
                       <i class="iconfont">&#xe634;</i>
                       <span class="pf-opt-name">修改密码</span>
                   </a>
               </li>
               <li class="pf-logout">
                   <a href="#" id="loginOut">
                       <i class="iconfont">&#xe60e;</i>
                       <span class="pf-opt-name">退出</span>
                   </a>
               </li>
           </ul>
       </div>
   </div>

	
</div>
<div class="container oh" style="padding: 30px;padding-top: 0px;">
	<!-------------------------空气质量指数---------------------------->
    <div class="home-layout" id="AirQualityData">
        <div class="home-panel">
        	<div class="home-panel-bg">
        		<div class="bg-top-left"></div>
        		<div class="bg-top-center"></div>
        		<div class="bg-top-right"></div>
        		<div class="bg-left-center"></div>
        		<div class="bg-center-center"></div>
        		<div class="bg-right-center"></div>
        		<div class="bg-right-bottom"></div>
        		<div class="bg-bottom-right"></div>
        		<div class="bg-bottom-center"></div>
        		<div class="bg-bottom-left"></div>
        	</div>        	
            <div class="home-panel-header">
            	<a href="#" target="" class="more fr iconcustom icon-fanhui7"></a>
				<span class="title">
					<span class="icon iconcustom icon-songfeng"></span>
					空气质量指数11111
				</span>
            </div>
            <div class="home-panel-body">
	            <div class="box-top">
	                <div class="grade-legend">
						<div class="legend">
							<span class="item excellent"></span>优
							<span class="item good"></span>良
							<span class="item mild"></span>轻度
							<span class="item moderate"></span>中度
							<span class="item severe"></span>重度
							<span class="item dangerous"></span>严重
							<span class="item"></span>暂无数据
						</div>
					</div>
	            </div>
	            <div class="fl" style="height: 224px;width:36%;">
					<table class="air-quality-daily grade-legend">
						<tbody>
							<tr>
								<td>
									<div class="quality"></div>
									<div class="info-group"><span class="tit">AQI：</span><span class="con aqi"></span></div>
									<div class="info-group"><span class="tit">首要污染物：</span><span class="con major"></span></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="oh" style="position:relative;height: 224px;padding-top: 14px;">
					<div class="data-group-container">
						<div class="data-group hide">
							<div class="group-data AQI"></div>
							<div class="group-title">AQI</div>
						</div>
						<div class="data-group">
							<div class="group-data NO2"></div>
							<div class="group-title">NO2</div>
						</div>
						<div class="data-group">
							<div class="group-data O3"></div>
							<div class="group-title">O3</div>
						</div>
						<div class="data-group">
							<div class="group-data PM10"></div>
							<div class="group-title">PM10</div>
						</div>
						<div class="data-group">
							<div class="group-data PM25"></div>
							<div class="group-title">PM2.5</div>
						</div>
						<div class="data-group">
							<div class="group-data SO2"></div>
							<div class="group-title">SO2</div>
						</div>
						<div class="data-group">
							<div class="group-data CO"></div>
							<div class="group-title">CO</div>
						</div>
					</div>
					
				</div>
            </div>
        </div>
         <!------------------------------------------AQI指数变化------------------------------------------>
        <div class="home-panel">
        	<div class="home-panel-bg">
        		<div class="bg-top-left"></div>
        		<div class="bg-top-center"></div>
        		<div class="bg-top-right"></div>
        		<div class="bg-left-center"></div>
        		<div class="bg-center-center"></div>
        		<div class="bg-right-center"></div>
        		<div class="bg-right-bottom"></div>
        		<div class="bg-bottom-right"></div>
        		<div class="bg-bottom-center"></div>
        		<div class="bg-bottom-left"></div>
        	</div>        	
            <div class="home-panel-header">
            	<a href="#" target="" class="more fr iconcustom icon-fanhui7"></a>
				<span class="title">
					<span class="icon iconcustom icon-shuju2"></span>
					AQI指数变化
				</span>
            </div>
            <div class="home-panel-body" style="height: 320px;">	            
	            <div id="airChart" style="height:290px;"></div>
            </div>
        </div>
    </div>
   
    
<!-------------------------水质类别分布---------------------------->
    <div class="home-layout fr" id="WaterQualityPie">
        <div class="home-panel">
        	<div class="home-panel-bg">
        		<div class="bg-top-left"></div>
        		<div class="bg-top-center"></div>
        		<div class="bg-top-right"></div>
        		<div class="bg-left-center"></div>
        		<div class="bg-center-center"></div>
        		<div class="bg-right-center"></div>
        		<div class="bg-right-bottom"></div>
        		<div class="bg-bottom-right"></div>
        		<div class="bg-bottom-center"></div>
        		<div class="bg-bottom-left"></div>
        	</div>        	
            <div class="home-panel-header">
            	<a href="#" target="" class="more fr iconcustom icon-fanhui7"></a>
				<span class="title">
					<span class="icon iconcustom icon-shidu1"></span>
					水质类别分布
				</span>
            </div>
            <div class="home-panel-body">
	            <div id="waterQualityType" style="height:250px;"></div>
            </div>
        </div>
        <!-------------------------水质达标率---------------------------->
        <div class="home-panel">
        	<div class="home-panel-bg">
        		<div class="bg-top-left"></div>
        		<div class="bg-top-center"></div>
        		<div class="bg-top-right"></div>
        		<div class="bg-left-center"></div>
        		<div class="bg-center-center"></div>
        		<div class="bg-right-center"></div>
        		<div class="bg-right-bottom"></div>
        		<div class="bg-bottom-right"></div>
        		<div class="bg-bottom-center"></div>
        		<div class="bg-bottom-left"></div>
        	</div>        	
            <div class="home-panel-header">
            	<a href="#" target="" class="more fr iconcustom icon-fanhui7"></a>
				<span class="title">
					<span class="icon iconcustom icon-peixun1"></span>
					水质达标率
				</span>
            </div>
            <div class="home-panel-body" style="height: 320px;">	            
	            <div id="waterQualityRate" style="height:250px;"></div>
            </div>
        </div>
        
    </div>
    <div class="home-layout oh" id="homeMapData" style="float:none;">
    	<div id="hotIndexMap" style="height:540px;"></div>
    	<div class="total-data-container">
    		<div class="title">累计数据</div>
    		<div class="num"><span>3</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span></div>
    		<div class="percent">
				<div class="num"><span>91</span>%</div>
				<div>已完成</div>
			</div>    	
    	</div>
    	<div class="task-data-container">
    		<div class="task-data">
	    		<div class="title">污染源企业</div>
	    		<div class="num" style="color: #fed000;"><span>3</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span></div>    		
	    	</div>
	    	<div class="task-data">
	    		<div class="title">排污口</div>
	    		<div class="num" style="color: #41b135;"><span>3</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span></div>    		
	    	</div>
	    	<div class="task-data">
	    		<div class="title">报警数据</div>
	    		<div class="num" style="color: #f35945;"><span>3</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span></div>    		
	    	</div>
	    	<div class="task-data">
	    		<div class="title">监控点</div>
	    		<div class="num" style="color: #00a2ff;"><span>3</span><span>0</span><span class="symbol">,</span><span>0</span><span>0</span><span>0</span></div>    		
	    	</div>
    	</div>
    	
    	    
    </div>
    
<!-- main over -->

</div>   
 <script>
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };

        /*图表*/
        var airChart,waterQualityTypeChart,waterQualityRateChart;
        
        $(function(){
        	$.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/indexPage/curAirQuantity',
                async:true,
                success: function (result) {
                    //$('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改用户');
                   var data = result.data;
                   $('.oh .AQI').html(data.quantity);
                   $('.oh .NO2').html(data.NO2);
                   $('.oh .O3').html(data.O3);
                   $('.oh .PM10').html(data.PM10);
                   $('.oh .PM25').html(data.PM25);
                   $('.oh .SO2').html(data.SO2);
                   $('.oh .CO').html(data.CO);
                   $('.fl .quality').html(data.quantityText);
                   $('.fl .aqi').html(data.quantity);
                   $('.fl .major').html(data.major);
                   $('.fl .quality').addClass(data.quantityColor);
                },
                error: function (jqXHR, textStatus, errorThrown) {
		            
		        },
                dataType: 'json'
            });
        
        
        	/*---------------------------------------空气质量数据-------------------------------------------*/
            airChart = echarts.init(document.getElementById('airChart'));
            airChartBaroption = {
            	title: {
			        text: '过去30天AQI情况',
			        left:'center',
			        textStyle: {
						color: '#fff',
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
                            result += item.axisValue + "</br>" +item.marker + " " + item.data.name + " : " + item.value +"</br>";
                        });
                        //console.log(params);
                    	return result;
                    }
                },
                legend: {
                    show:false,
                },
                toolbox: {
                    show: true,
                    feature: {
                        magicType: {type: ['line', 'bar']},
                        restore: {}
                    },
                    right: '5%',
                    iconStyle: {
                        borderColor: '#fff'
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
                        	color: '#fff'
                        }
                    }
                    
                },
                yAxis :{
                    type : 'value',
                    axisLine:{
                    	lineStyle:{
                        	color: '#fff'
                        }
                    },
                    splitLine:{
                    	lineStyle:{
                    		opacity:0.5
                    	}
                    }
                },                
                textStyle:{
                	color: '#fff'
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
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/indexPage/airQuantityForLastMonth',
                async:true,
                success: function (result) {
                   airChart.hideLoading();
                   var data = result.data;
                   $('.tc').html(data.text);
                   airChart.setOption({        //加载数据图表
                        xAxis: {
                            data: data.names
                        },
                        series: [{
                            data: data.nums
                        }]
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
		            airChart.hideLoading();
		        },
                dataType: 'json'
            });
            
            /*---------------------------------------水质类别分布-------------------------------------------*/
			// 基于准备好的dom，初始化echarts实例
			waterQualityTypeChart = echarts.init(document.getElementById('waterQualityType'));
			var waterQualityTypeOption = {
				title: {
					text: '',
					left: 'center',
					top: 10,
					textStyle: {
						color: '#fff',
						fontSize:'14',
						fontWeight:'normal'
					}
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					right: '30',
					top: 'center',
					orient: 'vertical',
					itemWidth:18,
					itemHeight:12,
					textStyle:{
						color:"#fff",
						fontSize:14
					},
					data: ['Ⅰ','Ⅱ','Ⅲ','Ⅳ','劣Ⅴ']
				},
				series : [
					{
						name: '水质类别分布',
						type: 'pie',
						roseType: 'angle',
						radius : '60%',
						center: ['40%', '50%'],
						data:[],
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			waterQualityTypeChart.setOption(waterQualityTypeOption);
			waterQualityTypeChart.showLoading();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/indexPage/waterQuantityForCategory',
                async:true,
                success: function (result) {
                   waterQualityTypeChart.hideLoading();
                   var data = result.data;
                   waterQualityTypeChart.setOption({        //加载数据图表
                   		title: {
                   			text: data.title
                   		},
                        series: [{
                            data: data.data
                        }]
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
		            waterQualityTypeChart.hideLoading();
		        },
                dataType: 'json'
            });

			/*---------------------------------------水质达标率-------------------------------------------*/
			// 基于准备好的dom，初始化echarts实例
			waterQualityRateChart = echarts.init(document.getElementById('waterQualityRate'));
			var waterQualityRateOption = {
				title: {
					text: '',
					left: 'center',
					top: 10,
					textStyle: {
						color: '#fff',
						fontSize:'14',
						fontWeight:'normal'
					}
				},
				tooltip : {
					formatter: "{a} <br/>{b} : {c}%"
				},
				series: [
					{
						name: '水质达标率',
						type: 'gauge',
						center: ['50%', '62%'],
						radius: '90%',
						axisLine: {            // 坐标轴线
							lineStyle: {       // 属性lineStyle控制线条样式
								width: 22,
								color:[[0.2, '#ffbf26'], [0.8, '#83d587'], [1, '#2ba4e9']]
							}
						},
						axisTick: {            // 坐标轴小标记
							length: 8,        // 属性length控制线长
							lineStyle: {       // 属性lineStyle控制线条样式
								color: '#ffffff'
							}
						},
						splitLine: {           // 分隔线
							length: 12,         // 属性length控制线长
							lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
								color: '#ffffff'
							}
						},
						axisLabel: {		//坐标轴文字
							color:'#fff',
							distance:15
						},
						pointer:{	// 仪表盘指针
							length:'70%',
							width:4
						},
						itemStyle:{// 仪表盘指针样式
							normal:{
								color:'#fff'
							}
						},
						detail: {formatter:'{value}%'},
						title:{
							color:'#fff'
						},
						data:[]
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			waterQualityRateChart.setOption(waterQualityRateOption);
			waterQualityRateChart.showLoading();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/env/indexPage/waterQuantityForRate',
                async:true,
                success: function (result) {
                   waterQualityRateChart.hideLoading();
                   var data = result.data;
                   waterQualityRateChart.setOption({        //加载数据图表
                   		title: {
                   			text: data.title
                   		},
                        series: [{
                            data: data.data
                        }]
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
		            waterQualityRateChart.hideLoading();
		        },
                dataType: 'json'
            });

            /*---------------------------------------地图-热点指数----------------------------------*/
            var hotIndexMap = echarts.init(document.getElementById('hotIndexMap'));
            var hotIndexMapOption={
                tooltip: {
                    trigger: 'item',
                        formatter: function(param) {
                            return param.name + '<br/>'
                                + param.marker + param.value;
                        },
                },
                /* visualMap: {
    				type: 'piecewise',
    				min: 800,
    				max: 50000,
    				text:['高','低'],
    				realtime: false,
    				calculable: false,
    				right:'20',
    				inRange: {
    					color: ['#51a1fa','#65b149','#ffbf26','#ff5400','#d13430']
    				},
                    splitNumber:5,
                    pieces: [                          //自定义每一段的范围，以及每一段的文字，以及每一段的特别的样式
                        {min: 50000},                     // 不指定 max，表示 max 为无限大（Infinity）。
                        {min: 35000, max: 50000},
                        {min: 20000, max: 35000},
                        {min: 800, max: 20000},
                        {max: 800}                        // 不指定 min，表示 min 为无限大（-Infinity）。
                    ],
                    itemWidth: 20,
                    itemHeight: 18,
                    itemGap:5,                          //每两个图元之间的间隔距离，单位为px

                }, */
                series: [
                    {
                        name: '地图-热点指数',
                        type: 'map',
                        mapType: 'fuJian', // 自定义扩展图表类型
                        aspectScale:1,
    					zoom:1.2,
    					label: {
    		                normal: {
    		                    show: true,
    		                    textStyle: {
    		                        color: '#fff'
    		                    }
    		                },
    		                emphasis: {
    		                    textStyle: {
    		                        color: '#fff'
    		                    }
    		                }
    		            },
    					itemStyle: {
    		                normal: {
    		                    borderColor: 'rgba(147, 235, 248, 1)',
    		                    borderWidth: 1,
    		                    areaColor: {
    		                        type: 'radial',
    		                        x: 0.5,
    		                        y: 0.5,
    		                        r: 0.8,
    		                        colorStops: [{
    		                            offset: 0, 
    		                            color: 'rgba(147, 235, 248, 0)' // 0% 处的颜色
    		                        }, {
    		                            offset: 1, 
    		                            color: 'rgba(147, 235, 248, .2)' // 100% 处的颜色
    		                        }],
    		                        globalCoord: false // 缺省为 false
    		                    },
    		                    shadowColor: 'rgba(128, 217, 248, 1)',
    		                    // shadowColor: 'rgba(255, 255, 255, 1)',
    		                    shadowOffsetX: -2,
    		                    shadowOffsetY: 2,
    		                    shadowBlur: 10
    		                },
    		                emphasis: {
    		                    areaColor: '#389BB7',
    		                    borderWidth: 0
    		                }
    		            },
                        data:[
                            {name: '云霄县', value: 20057.34},
                            {name: '长泰县', value: 15477.48},
                            {name: '东山县', value: 31686.1},
                            {name: '华安县', value: 6992.6},
                            {name: '龙海市', value: 445.49},
                            {name: '龙文区', value: 40689.64},
                            {name: '南靖县', value: 57659.78},
                            {name: '平和县', value: 6992.6},
                            {name: '漳浦县', value: 445.49},
                            {name: '诏安县', value: 40689.64},
                            {name: '芗城区', value: 40689.64}
                        ]
                    }
                ]
            };

            hotIndexMap.showLoading();
            $.get('${request.contextPath}/static/js/350600.json', function (geoJson) {
                hotIndexMap.hideLoading();
                echarts.registerMap('fuJian', geoJson);
            	hotIndexMap.setOption(hotIndexMapOption);
            });
            
            hotIndexMap.resize();
            airChart.resize();
        	waterQualityTypeChart.resize();
        	waterQualityRateChart.resize();
        });
        $(window).resize(function() {
        	hotIndexMap.resize();
        	airChart.resize();
        	waterQualityTypeChart.resize();
        	waterQualityRateChart.resize();
        });
        
    </script>

</body>

</html>
