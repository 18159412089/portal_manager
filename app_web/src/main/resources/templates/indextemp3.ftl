<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>空气来源分析</title>
    
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
	<!-- 侧边链接 -->
	<div class="map-links-container" style="position:absolute;top:100px;left:0px;">
		<a class="item" href="${request.contextPath}/enviromonit/airHourData">实时空气质量</a>
		<a class="item" href="${request.contextPath}/enviromonit/airDayData">空气质量分析</a>
		<a class="item active" href="${request.contextPath}/indextemp3">空气来源分析</a>
	</div>  
    <!-- 侧边链接 over -->
    <!-- 图例  -->
	<div class="map-legend-container" style="position:absolute;bottom:0px;left:0px;">
		<div class="title">
			<div class="item">优</div>
			<div class="item">良</div>
			<div class="item">轻度</div>
			<div class="item">中度</div>
			<div class="item">重度</div>
			<div class="item">严重</div>
		</div>
		<div class="grade-legend">
			<div class="item excellent"></div>
			<div class="item good"></div>
			<div class="item mild"></div>
			<div class="item moderate"></div>
			<div class="item severe"></div>
			<div class="item dangerous"></div>
		</div>
		<div class="num">
			<div class="item">0</div>
			<div class="item">50</div>
			<div class="item">100</div>
			<div class="item">150</div>
			<div class="item">200</div>
			<div class="item">300</div>
			<div class="item">500</div>
		</div>
	</div>  
    <!-- 图例 over -->
    
    
    <div class="map-panel" style="position:absolute;bottom:300px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				空气质量来源分析
			</span>
         </div>
         <div class="map-panel-body" style="height: 320px;width:360px;">	            
         	<div id="airFromRadar" style="width:360px;height: 100%;"></div>         	
         </div>
    </div>
    <div id="ktd" class="easyui-draggable"
         data-options="handle:'.map-panel-header',
            onBeforeDrag:function(e){
                e.data.target.style.right='auto';
		}"
         style="position:absolute;top:80px;left:58px;">
        <div class="map-panel panel-left collapsed">
            <div class="map-panel-header">
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				测试
			</span>
            </div>
            <div class="map-panel-body" style="height: 120px;width:360px;">
                <div style="width:360px;">
                    测试测试测试测试测试测试测试
                </div>
            </div>
        </div>
    </div>

    
    <div class="map-panel" style="position:absolute;bottom:18px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				空气质量来源分析
			</span>
         </div>
         <div class="map-panel-body" style="height: 264px;width:960px;">	            
         	<div id="allSitesBar" style="width:960px;height: 100%;"></div>
         </div>
    </div>
    
    
    
    
    
    <div class="map-filter-container" style="position:absolute;left:45%;top:88px;">
    	<div class="group-btn">
    		<div class="btn-filter active">周统计</div>
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
        		}else{
        			$target.addClass("collapsed");
        		}
        	});
        
        	
        	/*---------------------------------------漳州市周统计-------------------------------------------*/
            var airFromRadar = echarts.init(document.getElementById('airFromRadar'));
            var airFromRadarOption = {
                title: {
                    text: '漳州市周统计',
                    textStyle:{
                        fontSize: 16,
                        color: '#fff',
                        fontWeight: 'normal'
                    },
                    top:'10',
                    left:'10'
                },
                tooltip: {
                	show: true,
                	trigger: 'item'
                },
                textStyle: {
                    color:'#ffffff'
                },
                radar: {
                    indicator: [
                        {text: '生物质燃烧', max: 100},
                        {text: '扬尘', max: 100},
                        {text: '工业', max: 100},
                        {text: '燃煤', max: 100},
                        {text: '餐饮', max: 100},
                        {text: '尾气', max: 100}
                    ],
                    center: ['50%','55%'],
                    radius: 100,
                    splitArea: {
                        areaStyle: {
                            color: 'rgba(255, 255, 255, 0)'
                        }
                    },
                    axisLine: {
                        lineStyle: {
                            color: 'rgba(255, 255, 255, 0.5)'
                        }
                    },
                    splitLine: {
                        lineStyle: {
                            color: 'rgba(255, 255, 255, 0.5)'
                        }
                    }
                },
                series: {
                   type: 'radar',                    
                   itemStyle: {
                       normal: {
                           color: '#F9713C'
                       }
                   },
                   areaStyle: {
                       normal: {
                    	   type: 'default',
                           opacity: 0.7
                       }
                   },
                   data: [
                       {
                           value: [60,73,85,40,20,73],
                           name: '漳州市周统计'
                       }
                   ]
               },
            };
            airFromRadar.setOption(airFromRadarOption);
            
            /*---------------------------------------所有站点实时-------------------------------------------*/

            var allSitesBar = echarts.init(document.getElementById('allSitesBar'));

            var allSitesBarOption ={
                title: {
                    text: '所有站点实时',
                    subtext: '单位：μg/m3（CO为mg/m3）',
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
                    textStyle:{
                    	color: '#ffffff'
                    },
                    data: ['生物质燃烧','餐饮','尾气','燃煤','工业','二次','其他']
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
                    data: ['站点1','站点2','站点3','站点4','站点5','站点6','站点7','站点8','站点9','站点10','站点11']
                },
                yAxis: {
                    type: 'value',
                },
                series: [
                    {
                        name: '生物质燃烧',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#51a1fa',
                            }
                        },
                        data: [220, 202, 201, 234, 290, 230, 220,200, 101, 134, 90]
                    },
                    {
                        name: '餐饮',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#65b149',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '尾气',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ffbf26',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '燃煤',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ff5400',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '工业',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#d13430',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '二次',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#5d30d1',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: '其他',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#0065fc',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    }

                ],
            };

            allSitesBar.setOption(allSitesBarOption);

            
            
            
        
        });
        $(window).resize(function() {
        	
        });
        
    </script>
    
</body>

</html>