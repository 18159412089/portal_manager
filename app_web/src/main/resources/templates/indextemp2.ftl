<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>空气质量分析</title>
    
</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
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
	<div id="mapDiv" class="map-wrapper" style="position:fixed;bottom:0;"></div><!-- 地图层 -->
	<!-- 侧边链接 -->
	<div class="map-links-container" style="position:absolute;top:100px;left:0px;">
		<a class="item" href="${request.contextPath}/indextemp1">实时空气质量</a>
		<a class="item active" href="${request.contextPath}/indextemp2">空气质量分析</a>
		<a class="item" href="${request.contextPath}/indextemp3">空气来源分析</a>
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
    
    <div class="map-panel panel-top" style="position:absolute;top:100px;left:60px;width:490px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				空气质量日历
			</span>
         </div>
         <div class="map-panel-body" style="height: 740px;">	            
         	<div class="panel-calendar-container">
         	
         	
         		<div class="tc panel-textbox">
	         		
					
         		</div>
         		<div class="tc panel-textbox">
        			<div class="control-div">
						<label class="control-label">区/县</label>
						<input id="county" class="easyui-combobox" name="county" style="height: 32px; width: 140px;" data-options="
							url:'/enviromonit/airMonitorPoint/getCity',
							method:'post',
							valueField:'uuid',
							textField:'name',
							multiple:false,
							panelHeight:'auto'">
							
						<input id="monthText" type="text"  class="easyui"style="height: 32px; width: 140px;" readonly="">
					</div>
         			
         		</div>
         		<div class="calendar-wrapper" id="calendar">
         		
         		</div>
         		
         		<div class="calendar-wrapper">
         			<table >
         				<thead>
         					<tr>
         						<th>日</th>
         						<th>一</th>
         						<th>二</th>
         						<th>三</th>
         						<th>四</th>
         						<th>五</th>
         						<th>六</th>
         					</tr>
         				</thead>
         				<tbody>
         					
         				</tbody>
         			</table>
         		</div>
         		<div class="air-AQI-container">
         			<div class="air-AQI-box" id="color">
         				<div id="quality"></div>
         				<div><span id="AQI"></span></div>
         			</div>
         			<div class="air-AQI-details">         				
         				<div class="air-AQI-top">
         					<div class="time fr" id="time"></div>
         					<div class="title" id="city"></div>
         				</div>
         				<div class="AQI-info">
	         				<span id="PM2"></span>
	         				<span id="PM10"></span>
	         				<span id="CO"></span>
	         				<span id="No2"></span>
	         				<span id="O3"></span>
	         				<span id="So2"></span>
         				</div>
         			</div>
         			
         		</div>
         	</div>
         </div>
    </div>
    
    <div class="map-panel panel-left collapsed" style="position:absolute;bottom:96px;left:50px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				空气质量指标
			</span>
         </div>
         <div class="map-panel-body" style="height: 264px;width:960px;">	            
         	<div id="allSitesBar" style="width:960px;height: 100%;"></div>
         </div>
    </div>
    
    <div class="map-panel" style="position:absolute;top:88px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				空气质量分析
			</span>
         </div>
         <div class="map-panel-body" style="height: 500px;width:330px;">	            
         	<div class="AQI-info-box" style="width:330px;">
         		<div class="title">AQI周平均值</div>
         		<div class="data grade-legend-text"><span class="num good">90</span><span>良</span></div><!-- 根据不同状态 将“good” 更换 （excellent good mild moderate severe dangerous）-->
         		<div class="text">除少数对某些污染物特别容易过敏的人群外，其他人群可以正常进行室外活动</div>         		
         	</div>
         	<div class="AQI-info-list grade-legend-text">
         		<ul id="AQIInfoList" style="width:330px;height:100%;">
         			<li class="item">优：<span class="excellent">0</span>天</li>
         			<li class="item">良：<span class="good">0</span>天</li>
         			<li class="item">轻度污染：<span class="mild">0</span>天</li>
         			<li class="item">中度污染：<span class="moderate">0</span>天</li>
         			<li class="item">重度污染：<span class="severe">0</span>天</li>
         			<li class="item">严重污染：<span class="dangerous">0</span>天</li>
         			<li class="item">AQI最低值：<span class="good">0</span></li>
         			<li class="item">AQI最高值：<span class="dangerous">0</span></li>
         			<li class="item">PM2.5最低值：<span class="good">0</span></li>
         			<li class="item">PM2.5最高值：<span class="dangerous">0</span></li>
         			<li class="item">SO2最低值：<span class="good">0</span></li>
         			<li class="item">SO2最高值：<span class="dangerous">0</span></li>
         			<li class="item">NO2最低值：<span class="good">0</span></li>
         			<li class="item">NO2最高值：<span class="dangerous">0</span></li>
         			<li class="item">CO最低值：<span class="good">0</span></li>
         			<li class="item">CO最高值：<span class="dangerous">0</span></li>
         			<li class="item">CO2最低值：<span class="good">0</span></li>
         			<li class="item">CO2最高值：<span class="dangerous">0</span></li>         		
         		</ul>
         	</div>
         </div>
    </div>
    
    <div class="map-panel" style="position:absolute;bottom:18px;right:58px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				达标率
			</span>
         </div>
         <div class="map-panel-body" style="height: 270px;width:330px;">	            
         	<div id="standardPie" style="width:330px;height: 100%;"></div>
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
<script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
 <script>
 		$('#county').val('350600');
 		
 		layui.use('laydate', function(){
			var laydate = layui.laydate;
			//年月选择器
			laydate.render({
				elem: '#monthText',
				type: 'month',
				value: new Date(),
				btns: ['confirm'],
				done: function(text,date){
					search($('#county').val(),text);
				}
			});
		});
		
		$('#county').combobox({
			onChange: function(){
	   	    	var county = $("#county").val();
	       		search(county,$('#monthText').val());
	   	    }
	   	});
		
 		
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
        
        	$("#AQIInfoList").mCustomScrollbar({
        		theme:"light-3",
        		scrollButtons:{
        			enable:true
				}
        	});
            /*---------------------------------------漳州市周统计-------------------------------------------*/

            var allSitesBar = echarts.init(document.getElementById('allSitesBar'));

            var allSitesBarOption ={
                title: {
                    text: '漳州市周统计',
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
                    trigger: 'item',
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
                    data: ['AQI','PM2.5','PM10','SO2','NO2','CO','CO2']
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
                    data: ['芗城区','芗城区','芗城区','芗城区','芗城区','芗城区','芗城区','芗城区','芗城区','芗城区','芗城区']
                },
                yAxis: {
                    type: 'value',
                },
                series: [
                    {
                        name: 'AQI',
                        type: 'line',
                        symbol: 'circle',
                        symbolSize: 8,
                        itemStyle:{
                            normal:{
                                color:'#ff8400',
                            }
                        },
                        data: [220, 202, 201, 234, 290, 230, 220,200, 101, 134, 90]
                    },
                    {
                        name: 'PM2.5',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#51a1fa',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'PM10',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#65b149',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'SO2',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ffbf26',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'NO2',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#ff5400',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'CO',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#d13430',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    },
                    {
                        name: 'CO2',
                        type: 'bar',
                        itemStyle:{
                            normal:{
                                color:'#5d30d1',
                            }
                        },
                        data: [120, 132, 101, 134, 90, 130, 110,127, 201, 234, 290]
                    }

                ],
            };

            allSitesBar.setOption(allSitesBarOption);
            /*---------------------------------------漳州市周统计 达标率-------------------------------------------*/

            var standardPie = echarts.init(document.getElementById('standardPie'));

            var standardPieOption ={
        		title: {
                    text: '漳州市周统计',
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
           	    tooltip: {
           	        trigger: 'item',
           	        formatter: "{a} <br/>{b}: {c} ({d}%)"
           	    },
           	    legend: {
           	    	orient: 'horizontal',
                    top: '10',
                    right:'30',
                    textStyle:{
                    	color: '#ffffff'
                    },
           	        data:['达标','未达标']
           	    },
           	    series: [
           	        {
           	            name:'周统计',
           	            type:'pie',
           	            selectedMode: 'single',
           	            radius: [0, '45%'],
           	            center: ['50%', '56%'],
           	            label: {
           	                normal: {
           	                	show: false
           	                }
           	            },
           	            labelLine: {
           	                normal: {
           	                    show: false
           	                }
           	            },
           	            data:[
	           	            {value:140, name:'优', itemStyle: {normal: {color: '#00a2ff'	}}},
	           	            {value:56,  name:'良',  itemStyle: {normal: {color: '#7bed80'}}},
	           	            {value:88,  name:'轻度', itemStyle: {normal: {color: '#ffd200'}}},
	           	            {value:210, name:'中度',itemStyle: {normal: {color: '#ff7c35'}}},
	           	            {value:73,  name:'重度', itemStyle: {normal: {color: '#ff6262'}}},
	           	            {value:66,  name:'严重',  itemStyle: {normal: {color: '#d02032'}}}
           	            ]
           	        },
           	        {
           	            name:'达标率',
           	            type:'pie',
           	            radius: ['52%', '70%'],
           	         	center: ['50%', '56%'],
           	            data:[
           	                {value:196, name:'达标', itemStyle: {normal: {color: '#51a1fa'	}}},
           	                {value:437, name:'未达标', itemStyle: {normal: {color: '#d13430'	}}}
           	            ]
           	        }
           	    ]
           	};

            standardPie.setOption(standardPieOption);
            
            
            
        
        });
        $(window).resize(function() {
        	
        });
        /*--------------------------------------加载地图初始化-------------------------------------------*/
		$.post('${request.contextPath}/enviromonit/airHourData/city',{},function(data){
				
			 $(function(){
            //初始化地图对象
            map = new T.Map("mapDiv");
            //设置显示地图的中心点和级别
            map.centerAndZoom(new T.LngLat(117.65,24.52), 10);
            map.setStyle('indigo');
           
            
            //创建图片对象
            var icon1 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv2.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon2 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv3.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon3 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv4.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon4 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv5.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon5 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv6.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon6 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv7.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            //向地图上添加自定义标注
            $.post('${request.contextPath}/enviromonit/airMonitorPoint/getCityByType',{},function(data){
            	$.each(data,function(i){
            		var marker
            		var colors;
            		if(data[i].color=='1'){
            			colors ='#00E400';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon1});
					}else if(data[i].color=='2'){
						colors ='#FFFF00';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon2});
					}else if(data[i].color=='3'){
						colors ='#FF7E00';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon3});
					}else if(data[i].color=='4'){
						colors ='#FF0000';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon4});
					}else if(data[i].color=='5'){
						colors ='#99004C';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon5});
					}else if(data[i].color=='6'){
						colors ='#7E0023';
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon6});
					}
            		map.addOverLay(marker);
            		var sContent =
					"<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color:"+colors+"'>"+
					"<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"+data[i].regionName+"</b>"+
					"<sub>点击可查看详情<sub></sub></sub></li><li>城市："+data[i].regionName+
					"</li><li>更新时间："+data[i].monitrorTime+
					"</li><li>纬度："+data[i].longitude+
					"</li><li>AQI："+data[i].aqi+
					"</li><li>经度："+data[i].latitude+"</li></ul>"
            		addClickHandler(data[i].pointCode,sContent,marker);
            	});
				
			},"json");
        
			
            function addClickHandler(pointCode,content,marker){
                marker.addEventListener("click",function(e){
                    openInfo(pointCode,content,e)}
                );
            }
            function openInfo(pointCode,content,e){
               
                var point = e.lnglat;
                marker = new T.Marker(point);// 创建标注
                var markerInfoWin = new T.InfoWindow(content,{offset:new T.Point(0,-30)}); // 创建信息窗口对象
                map.openInfoWindow(markerInfoWin,point); //开启信息窗口
                //fun(pointCode,data[0].monitrorTime);
            }
		});
		},"json");
    </script>
    <script>
    	/*--------------------------加载日历-------------------------*/
    	$(function (){
			var today = new Date();
			var _year = today.getFullYear();
			var _month = today.getMonth() + 1;
			var _day = today.getDate();
			var firstDay = getFirstDay(_year,_month);
	    	var code ='350600';
	    	var day;
	    	var month ;
	    	if(_day<10){
	    		day="0"+_day;
	    	}
	    	if(_month<10){
	    		month="0"+_month;
	    	}
	    	var time = _year+"-"+month;
			cityMonth(code,time,firstDay);
			getCity(code,time+"-"+day);
		
		});
    	
		/*判断是否是闰年*/
		function runNian(_year) {
		    if(_year%400 === 0 || (_year%4 === 0 && _year%100 !== 0) ) {
		        return true;
		    }
		    else { return false; }
		}
		/*判断某年某月的第一天是星期几*/
		function getFirstDay(_year,_month) {
		    var allDay = 0, y = _year-1, i = 1;
		    allDay = y + Math.floor(y/4) - Math.floor(y/100) + Math.floor(y/400) + 1;
		    for ( ; i<_month; i++) {
		        switch (i) {
		            case 1: allDay += 31; break;
		            case 2: 
		                if(runNian(_year)) { allDay += 29; }
		                else { allDay += 28; }
		                break;
		            case 3: allDay += 31; break;
		            case 4: allDay += 30; break;
		            case 5: allDay += 31; break;
		            case 6: allDay += 30; break;
		            case 7: allDay += 31; break;
		            case 8: allDay += 31; break;
		            case 9: allDay += 30; break;
		            case 10: allDay += 31; break;
		            case 11: allDay += 30; break;
		            case 12: allDay += 31; break;
		        }
		    }
		    return allDay%7;
		}
		/*----------------------获取城市某天的空气信息----------------*/
		function getCity(pointCode,time){
			$.ajax({
		    url:"/enviromonit/airDayData/getCity",
		    type:"post",
		    dataType : 'json', 
		    data:{
		         pointCode:pointCode,
		         time:time
		    },
		    datatype:'json',
		    success:function(data){
		    		if(data[0].AQI <0 ){
		    			$("#AQI").html("AQI：-");
		    		}else{
						$("#AQI").html("AQI："+data[0].AQI);
					}
					$("#PM2").html("PM2.5："+data[0].PM2);
					$("#PM10").html("PM10："+data[0].PM10);
					$("#CO").html("CO："+data[0].CO);
					$("#No2").html("No2："+data[0].No2);
					$("#O3").html("O3："+data[0].O38);
					$("#So2").html("So2："+data[0].So2);
					$("#city").html(data[0].city);
					$("#time").html(data[0].time);
					if(data[0].AQI < 0 ){
					$("#quality").html("-");
						$("#color").attr("class","air-AQI-box not_data");
						$("#quality").html("空气质量：-");
					}else if( data[0].AQI <= 50){
						$("#quality").html("空气质量：优");
						$("#color").attr("class","air-AQI-box excellent");
					}else if(data[0].AQI <= 100){
						$("#quality").html("空气质量：良");
						$("#color").attr("class","air-AQI-box good");
					}else if(data[0].AQI <= 150){
						$("#quality").html("空气质量：轻度污染");
						$("#color").attr("class","air-AQI-box mild");
					}else if(data[0].AQI <= 200){
						$("#quality").html("空气质量：中度污染");
						$("#color").attr("class","air-AQI-box moderate");
					}else if(data[0].AQI <= 300){
						$("#quality").html("空气质量：重度污染");
						$("#color").attr("class","air-AQI-box severe");
					}else if(data[0].AQI <= 500){
						$("#quality").html("空气质量：严重污染");
						$("#color").attr("class","air-AQI-box dangerous");
					}
				}
			})
		}
    </script>
    
    <script>
    	/*查询某月的某个城市一个月的时间*/
    	function search(code,time){
    		var arr = time.split("-");
			var firstDay = getFirstDay(arr[0],arr[1]);
    		$('table tbody').html('');
			cityMonth(code,time,firstDay);
			getCity(code,time+"-01");
    	}
    	/*----------------------------------日历显示----------------------*/
    	function cityMonth(code,time,firstDay){
    		$('table tbody').html('');
			$.ajax({
			    url:"/enviromonit/airDayData/getCityByMonth",
			    type:"post",
			    dataType : 'json', 
			    data:{
			         pointCode:code,
				         date:time
			    },
			    datatype:'json',
			    success:function(data){
			    	var html="<tr>";
			    	//满7换一行
			    	var j = 1;
			    	for (i=1; i<=firstDay; i++) {
				        html += "<td></td>";
				        j++;
				    }
				    
					$.each(data,function(i){
						
						html += "<td> <div class='item pre-m "+
						data[i].color+"' onclick='getCity("+data[i].pointCode+",\""+data[i].time+"\");'> <div class='date'>"+
						data[i].day+"</div><div class='other'>"+
						data[i].polluteName+"</div></div></td>";
						if(j == 7){
							html +="</tr>"
							var $tr = $(html);
							var $table = $('table tbody');
							$table.append($tr);
							j = 1;
							html = "<tr>";
							return ;
						}
						j++;
					 	firstDay = (firstDay+1)%7;	
					});
					if(firstDay!==0) {
				        for (i=firstDay; i<7; i++) {
				            html += "<td></td>";
				        }
					}
					html +="</tr>"
					var $tr = $(html);
					var $table = $('table tbody');
					$table.append($tr);
				
				}
				
			});
    	}
    	
    </script>
    
</body>

</html>

