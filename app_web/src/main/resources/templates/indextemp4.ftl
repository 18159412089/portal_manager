<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>地表水水质实时监测</title>
    
</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<div id="pf-hd" style="position: absolute;width:100%;">
	<span class="pf-logo">
   		<img src="${request.contextPath}/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="${request.contextPath}/static/images/main/user.png" alt="">
        </div>
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
<div class="container oh" style="position:absolute;top:0px;left:0px;right:0px;bottom:0px;">
	<!-- main -->
	<div class="map-wrapper" style="background: url('${request.contextPath}/static/images/map_bg.png') center;"></div><!-- 地图层(真实添加地图时，删除style) -->
	

    <!-- 图例  -->
	<div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;">
		<div class="grade-legend">
			<div class="legend">
				<span class="item level-1"></span>Ⅰ
				<span class="item level-2"></span>Ⅱ
				<span class="item level-3"></span>Ⅲ
				<span class="item level-4"></span>Ⅳ <br/>
				<span class="item level-5"></span>Ⅴ
				<span class="item level-6"></span>Ⅵ
				<span class="item level-0"></span>劣Ⅴ
				<span class="item"></span>未知
			</div>
		</div>
	</div>  
    <!-- 图例 over -->
    
    <div class="map-panel collapsed" style="position:absolute;top:86px;left:0px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				污染指标统计
			</span>
         </div>
         <div class="map-panel-body" style="height: 232px;width:510px;">	            
         	<div id="WaterPollutionBar" style="width:510px;height: 100%;"></div>
         </div>
    </div>
    
    <div class="map-panel collapsed" style="position:absolute;top:36%;left:0px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				流域水质类别比例
			</span>
         </div>
         <div class="map-panel-body" style="height: 232px;width:572px;">	            
         	<div id="WatertypeBar" style="width:572px;height: 100%;"></div>
         </div>
    </div>
    
    <div class="map-panel collapsed" style="position:absolute;top:64%;left:0px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				指标沿程变化
			</span>
         </div>
         <div class="map-panel-body" style="height:248px;width:800px;">	            
         	<div id="WaterIndexBar" style="width:800px;height:100%;"></div>
         </div>
    </div>
    
    
    
    
    
    <div class="map-panel" style="position:absolute;top:86px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				水质类别统计
			</span>
         </div>
         <div class="map-panel-body" style="height: 600px;width:320px;">	            
         	    <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:320px;height:350px;">
			        <div title="Ⅰ类">
			    		<div class="water-type-list">
			         		<div class="item">
			         			<span>断面名称</span>
			         			<span>断面属性</span>
			         		</div>
			         		<!-- 根据不同状态 将“good” 更换 （excellent good mild moderate severe dangerous）-->
			         		<ul>
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			<li class="item">
									<span>断面1</span>
									<span>库体</span>				         			
								</li>			         			
			         			
			         		</ul>
			         	</div>
			        </div>
			        <div title="Ⅱ类">
			    		tab2
			        </div>
			        <div title="Ⅲ类">
			    		tab3
			        </div>
			        <div title="Ⅳ类">
			    		Ⅰ类
			        </div>
			        <div title="Ⅴ类">
			    		tab2
			        </div>
			        <div title="劣Ⅴ">
			    		tab3
			        </div>
			    </div>	         	
         	<div id="WatertypePie" style="height:250px;width:320px;"></div>	         	
         </div>
    </div>
    
    <div class="map-panel collapsed" style="position:absolute;bottom:18px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				漳州东溪水质指标详情
			</span>
         </div>
         <div class="map-panel-body" style="height: 264px;width:740px;">
         	<div style="height: 100%;width: 740px;">
         		<div style="float:left;">
	         		<div class="radio-button-group chart-radio">
						<span class="active">DO</span>
						<span>TOC</span>
						<span>氢离子浓度指数</span>
						<span>COD</span>
						<span>NH3N</span>
					</div>
					<div id="WaterIndexGauge" style="width: 360px;height: 210px;"></div>
	         	</div>	            
	         	<div class="panel-group-container oh" style="height: 100%;">
	       			<div class="panel-group-top">
	       				漳州东溪<span class="subtext fr">2019.1.18  14:43</span>
	       			</div>
	       			<div class="panel-group-body">
	       				<div class="panel-info">
	       					<span>经度：104.62</span>
	        				<span>纬度：28</span>
	        				<span>区县：龙海市</span>
	        				<span>断面情况：入海</span>
	        				<span>水系：浙闽河流</span>
	        				<span>河流名称：东溪</span>
	        				<span>溶解氧：10.17mg/L</span>
	        				<span>氨氮：0.15mg/L</span>
	        				<span>总有机碳：-</span>
	        				<span>高锰酸盐指数：2.29mg/L</span>
	        				<span>氢离子浓度指数：7.79</span>
	        				<span>水质类别：Ⅳ类</span>
	       				</div>         				
	       			</div>
	       		</div>
         	</div>
         	
         	
         </div>
    </div>
    
    
    
    
    
    <div class="map-filter-container" style="position:absolute;left:45%;top:88px;">
    	<div class="group-btn">
    		<div class="btn-filter active">实时</div>
    		<div class="btn-filter">周统计</div>
    		<div class="btn-filter">月统计</div>
    		<div class="btn-filter">年统计</div>
    		<div class="btn-filter"><input id="dd" type="text" class="easyui-datebox" style="height:21px;" value="2019-01-21"/></div>
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
        
        $(function(){
        	$(".map-panel-header").on("click",function(){
        		var $target=$(this).parent();
        		if($target.hasClass("collapsed")){
        			$target.removeClass("collapsed");
                	WaterPollutionBar.resize();
                	WatertypeBar.resize();
                	WaterIndexBar.resize();
        		}else{
        			$target.addClass("collapsed");
        		}
        	});
        	
        	$(".radio-button-group").on("click","span",function () {
                $(this).siblings("span").removeClass("active");
                $(this).addClass("active");

            });
        	
        	/*---------------------------------------污染指标统计-------------------------------------------*/

            var WaterPollutionBar = echarts.init(document.getElementById('WaterPollutionBar'));

            var WaterPollutionBarOption ={
                title: {
                    text: '水体污染指标统计',
                    subtext: '超标断面个数   2019.1.18 9:43:18',
                    textStyle:{
                        fontSize: 16,
                        color:'#ffffff'
    				},
                    left:'10',
    				top:'10'
                },
                textStyle: {
                    color:'#ffffff'
                },
                tooltip : {
                    trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                toolbox: {
                    show: true,
                    right: '30',
                    top: '8%',
                    iconStyle: {
                    	borderColor: '#ffffff'
                    },
                    feature: {
                        saveAsImage: {show: true}
                    }
                },
                grid: {
                    top:'80',
                    left: '10',
                    right: '30',
                    bottom: '10',
                    containLabel: true
                },
                xAxis:  {
                    type: 'category',
                    axisLabel:{
                        type:'category',
                        interval:0,
                        rotate:30,
                    },
                    data: ['氢离子','氢离子','氢离子','氢离子','氢离子','氢离子','氢离子','氢离子']
                },
                yAxis: {
                    type: 'value',
                },
                series: [
                    {
                        name: '超标断面个数',
                        type: 'bar',
                        stack: 'one',
                        barWidth:'50%',
                        itemStyle:{
                            normal:{
                                color:'#65b149',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127]
                    }

                ],
            };

            WaterPollutionBar.setOption(WaterPollutionBarOption);
        	/*---------------------------------------流域水质类别比例-------------------------------------------*/

            var WatertypeBar = echarts.init(document.getElementById('WatertypeBar'));

            var WatertypeBarOption ={
                title: {
                    text: '流域水质类别比例',
                    subtext: '2019.1.18 9:43:18',
                    textStyle:{
                        fontSize: 16,
                        color:'#ffffff'
    				},
                    left:'10',
    				top:'10'
                },
                textStyle: {
                    color:'#ffffff'
                },
                tooltip : {
                    trigger: 'axis',//trigger: 'item'
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                toolbox: {
                    show: true,
                    right: '30',
                    top: '8%',
                    iconStyle: {
                    	borderColor: '#ffffff'
                    },
                    feature: {
                        magicType: {show: true, type: ['stack', 'tiled']},
                        saveAsImage: {show: true},
                        restore: {show: true}
                    }
                },
                grid: {
                    top:'80',
                    left: '10',
                    right: '30',
                    bottom: '10',
                    containLabel: true
                },
                xAxis:  {
                    type: 'category',
                    axisLabel:{
                        type:'category',
                        interval:0,
                        rotate:30,
                    },
                    data: ['地点1','地点2','地点3','地点4','地点5','地点6','地点7','地点8','地点9','地点10','地点11']
                },
                yAxis: {
                    type: 'value'
                },
                series: [
                    {
                    	name: 'I',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#94DB99'
                            }
                        },
                        data: [220, 202, 201, 234, 290, 230, 220,200, 101, 134, 90]
                    },
                    {
                    	name: 'II',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#2AA7E9'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'III',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#F8B01D'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'IV',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#64B04E'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'V',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#FD8A54'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'VI',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#9487F1'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '劣V',
                        type: 'bar',
                        stack: 'one',
                        itemStyle:{
                            normal:{
                                color:'#c52a2b'
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    }

                ],
            };

            WatertypeBar.setOption(WatertypeBarOption);
            /*---------------------------------------指标沿程变化-------------------------------------------*/

            var WaterIndexBar = echarts.init(document.getElementById('WaterIndexBar'));

            var WaterIndexBarOption ={
                title: {
                    text: '水质指标沿程变化',
                    subtext: '2019.1.18 9:43:18   单位：μg/m3（CO为mg/m3）',
                    textStyle:{
                        fontSize: 16,
                        color:'#ffffff'
    				},
                    left:'10',
    				top:'10'
                },
                textStyle: {
                    color:'#ffffff'
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
                    top: '80',
                    iconStyle: {
                    	borderColor: '#ffffff'
                    },
                    feature: {
                        magicType: {show: true, type: ['stack', 'tiled']},
                        saveAsImage: {show: true},
                        restore: {show: true}
                    }
                },
                legend: {
                    orient: 'horizontal',
                    top: '8%',
                    right:'30',
                    textStyle:{
                    	color: '#ffffff'
                    },
                    data: ['溶解氧','高锰酸钾','总有机碳','氨氮']
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
                    data: ['项目1','项目2','项目3','项目4','项目5','项目6','项目7','项目8','项目9','项目10','项目11']
                },
                yAxis: {
                    type: 'value',
                },
                series: [
                    {
                        name: '溶解氧',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#51a1fa',
                            }
                        },
                        data: [220, 202, 201, 234, 290, 230, 220,200, 101, 134, 90]
                    },
                    {
                        name: '高锰酸钾',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#65b149',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '总有机碳',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ffbf26',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '氨氮',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ff5400',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    }

                ],
            };

            WaterIndexBar.setOption(WaterIndexBarOption);

            /*---------------------------------------水质类别-------------------------------------------*/
            var WatertypePieData=[
                {value:140, name:'一', itemStyle: {normal: {color: '#FF6263'	}}},
                {value:56,  name:'I',  itemStyle: {normal: {color: '#94DB99'}}},
                {value:88,  name:'II', itemStyle: {normal: {color: '#2AA7E9'}}},
                {value:210, name:'III',itemStyle: {normal: {color: '#F8B01D'}}},
                {value:73,  name:'IV', itemStyle: {normal: {color: '#64B04E'}}},
                {value:66,  name:'V',  itemStyle: {normal: {color: '#FD8A54'}}},
                {value:37,  name:'VI', itemStyle: {normal: {color: '#9487F1'}}},
                {value:20,  name:'劣V',itemStyle: {normal: {color: '#B8B8B8'	}}},
            ];
            var WatertypePie = echarts.init(document.getElementById('WatertypePie'));
            WatertypePieOption ={
        		title: {
                    text: '水质类别比例',
                    textStyle:{
                        fontSize: 16,
                        color:'#ffffff'
    				},
                    left:'10',
    				top:'10'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                
                series : [
                    {
                        name: '水质类别',
                        type: 'pie',
                        radius : ['12%', '70%'],
                        center: ['50%', '58%'],
                        data:WatertypePieData,
                        roseType : 'radius'
                        
                    }
                ]

            };
            WatertypePie.setOption(WatertypePieOption);
            
            /*---------------------------------------水质指标-------------------------------------------*/

            var WaterIndexGauge = echarts.init(document.getElementById('WaterIndexGauge'));
            WaterIndexGaugeOption ={
                tooltip : {
                    formatter: "{a} <br/>{b} : {c}%"
                },
                series: [
                    {
                        name: '水质指标',
                        type: 'gauge',
    					radius:'100%',
    					center: ['50%', '58%'],
    					axisLine: {            // 坐标轴线
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: [[0.1, '#0eff0b'],[0.80, '#2d9dff'],[1, '#ff510b']],
    		                    width: 3,
    		                    shadowColor : '#2d9dff',
    		                    shadowBlur: 4
    		                }
    		            },
    		            axisLabel: {            // 坐标轴小标记
    		                textStyle: {       // 属性lineStyle控制线条样式
    		                    fontWeight: 'bolder',
    		                    color: '#fff',
    		                    shadowColor : '#2d9dff',
    		                    shadowBlur: 4
    		                }
    		            },
    		            axisTick: {            // 坐标轴小标记
    		                length :15,        // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle控制线条样式
    		                    color: 'auto',
    		                    shadowColor : '#2d9dff',
    		                    shadowBlur: 4
    		                }
    		            },
    		            splitLine: {           // 分隔线
    		                length :25,         // 属性length控制线长
    		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
    		                    width:3,
    		                    color: '#fff',
    		                    shadowColor : '#2d9dff',
    		                    shadowBlur: 4
    		                }
    		            },
                        detail: {formatter:'{value}%'},
                        title : {
                        	offsetCenter: [0, '70%'],
                            textStyle: { 
                            	fontWeight: 'bolder',
                                fontSize: 20,
                                color: '#fff'
                            }
                        },
                        data: [{value: 50, name: 'DO'}]
                    }
                ]
            };
            
            WaterIndexGauge.setOption(WaterIndexGaugeOption);
            
        
        });
        $(window).resize(function() {
        	
        });
        
    </script>
    
</body>

</html>