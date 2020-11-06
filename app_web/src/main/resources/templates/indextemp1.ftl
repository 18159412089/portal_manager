<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="en">
<head>
    <title>实时空气质量</title>
    
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
	<!--<div class="map-wrapper" style="background: url('${request.contextPath}/static/images/map_bg.png') center;"></div> 地图层(真实添加地图时，删除style) -->
	<!-- 侧边链接 -->
	<div class="map-links-container" style="position:absolute;top:100px;left:0px;">
		<a class="item active" href="${request.contextPath}/indextemp1">实时空气质量</a>
		<a class="item" href="${request.contextPath}/indextemp2">空气质量分析</a>
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
    
    <div class="map-panel panel-top" style="position:absolute;top:100px;left:50px;width:330px;">
         <div class="map-panel-header">         	
			<span class="title">
				<span class="icon iconcustom icon-zhedie3"></span>
				AQI行政划区排行榜
			</span>
         </div>
         <div class="map-panel-body" style="height: 548px;">
         	<div class="map-panel-subtext">
         		<span class="subtext" id="time">更新时间：2019.1.17  14:00</span>
         	</div>
         	<div class="AQI-ranking-list grade-legend-text">
         		<div class="item">
         			<span class="ranking">排名</span>
         			<span class="data">AQI</span>
         			<span class="title">城市</span>
         		</div>
         		<!-- 根据不同状态 将“good” 更换 （excellent good mild moderate severe dangerous）-->
         		<ul id="city">
         			
         		</ul>
         	</div>
         </div>
    </div>
    
    <div class="map-panel panel-top" style="position:absolute;top:100px;right:18px;width:400px;">
         <div class="map-panel-header">         	
			<span class="title" id="cityName">
				<span class="icon iconcustom icon-zhedie3"></span>
				
			</span>
         </div>
         <div class="map-panel-body" style="height: 548px;">
         	<div class="map-panel-subtext">
         		<span class="title fl">AQI指数</span>
         		<span class="subtext" id="updateTime"></span>
         		<div id="AQILiquidfill" style="width:100%; height: 160px;"></div>
         		<div class="info">
					<span>对健康影响情况：空气质量令人满意，基本无空气污染</span>
					<span>建议采取的措施：各类人群可正常活动</span>
				</div>
         	</div>
         	<div class="panel-group-container" id="cityPanel" style="height: 300px;">
         		<div class="panel-group-box">
         			<div class="panel-group-top">
         				空气中主要污染物浓度：
         			</div>
         			<div class="panel-group-body">
         				<div class="AQI-info">
         					<span id="AQI"></span>
	         				<span id="PM2"></span>
	         				<span id="PM10"></span>
	         				<span id="CO"></span>
	         				<span id="No2"></span>
	         				<span id="O3"></span>
	         				<span id="So2"></span>
         				</div>         				
         			</div>
         		</div>
         		<div class="panel-group-box">
         			<div class="panel-group-top">
         				各监测站点实时数据：<span class="subtext fr">单位：μg/m3（CO为mg/m3）</span>
         			</div>
         			<div class="panel-group-body">
         				<table id="dg" class="easyui-datagrid" style="width:100%px;height:auto"
						       data-options="
										rownumbers:false,
						                striped:false,
										fitColumns:true">
						    <thead>
						    <tr>
						    
						        
						        <th field="pointName" width="100">监测点</th>
						        <th field="aqi" width="140">AQI</th>
						        <th field="status" width="100">空气质量状况</th>
						        <th field="remark" width="100">首要污染物</th>
						        <th field="PM2" width="120">PM2.5浓度</th>
						        
						        <th field="PM10" width="120">PM10浓度</th>
						        <th field="CO" width="120">Co浓度</th>
						        <th field="No2" width="120">No2浓度</th>
						        <th field="O3" width="120">O3浓度</th>
						        <th field="So2" width="120">So2浓度</th>
						        
						    </tr>
						    </thead>
						</table>	
         			</div>
         		</div>
         		
         		
         	</div>
         </div>
    </div>
    
    
    
    
    
    
    
	<!-- main over -->

</div>   
<script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script>
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
        	
        	$("#cityPanel").mCustomScrollbar({
        		theme:"light-3",
        		scrollButtons:{
        			enable:true
				}
        	});
        	
        });
        $(window).resize(function() {
        	
        });
        
        
        /*---------------------------------------AQI指数 -水球------------------------------------------*/
        function test(data,color,text){
        	 var AQILiquidfill = echarts.init(document.getElementById('AQILiquidfill'));
            var AQILiquidfillOption = {        		
                series: {
                    name: 'AQI指数',
                    type: 'liquidFill',
    				center:['50%', '45%'],
                    data: [data],
                    radius: '76%',
                    color: [color],
                    itemStyle: {
                        opacity: 1,
                        shadowBlur: 0
                    },emphasis: {
                        itemStyle: {
                            opacity: 0.9
                        }
                    },
                    label: {
                        color: '#000000',
                        formatter: function(param) {
                        	var str='{p|'+ param.value*100 + '}\n{t|'+text+'}';
                            return str;
                        },
                        rich: {
                            p: {
                                fontSize: 36
                            },
                            t: {
                                fontSize: 14
                            }
                        },
                        fontWeight:'normal'
                    },
                    backgroundStyle: {
                        color: '#fff',
                        shadowColor: 'rgba(0,0,0,0.2)',
                        shadowBlur: 6,
                        shadowOffsetX: 6,
                        shadowOffsetY: 6
                    },
                    outline: {
                        show: false                        
                    }

                }
            };
            AQILiquidfill.setOption(AQILiquidfillOption);
        	
        }
        /*---------------------------------------------------根据排名上的城市，定位到地图上的位置、显示城市信息-------------------------------------*/
        function updateMap(longitude,latitude,pointCode,monitrorTime,color){
            map.centerAndZoom(new T.LngLat(longitude,latitude), 10);
        	fun(pointCode,monitrorTime);
        }
        /*加载行政区排行榜*/
		$.post('${request.contextPath}/enviromonit/airHourData/city',{},function(data){
				<!-- 根据不同状态 将“good” 更换 （excellent good mild moderate severe dangerous）-->
				var listHtml=''; 
				var j = 0;
				$.each(data,function(i){ 
					//alert(data[i].pointName)
					var color;
					var text;
					if(data[i].color=='1'){
						color ='excellent';
						text ='';
					}else if(data[i].color=='2'){
						color ='good';
					}else if(data[i].color=='3'){
						color ='mild';
					}else if(data[i].color=='4'){
						color ='moderate';
					}else if(data[i].color=='5'){
						color ='severe';
					}else if(data[i].color=='6'){
						color ='dangerous';
					}
					var s = "aa";
					listHtml +="<li class='item' onclick='updateMap("+data[i].longitude+","+data[i].latitude+","+data[i].pointCode+",\""+data[0].monitrorTime+"\""+",\""+color+"\")'><span class='ranking'><span>"+(i+1)+"</span></span>";
					listHtml +="<span class='data'><span class='"+color+"'>"+data[i].aqi+"</span></span>"
					listHtml +="<span class='title'>"+data[i].regionName+"</span>"
				}); 
				$("#time").html("更新时间:"+data[0].monitrorTime);
				$("#city").html(listHtml); 
				
				fun('350600',data[0].monitrorTime);
				
			 $(function(){
            //初始化地图对象
            map = new T.Map("mapDiv");
            //设置显示地图的中心点和级别
            map.centerAndZoom(new T.LngLat(117.65,24.52), 10);
            map.setStyle('indigo');
           
            
            //创建图片对象
            var icon1 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv1.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon2 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv2.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon3 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv3.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon4 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv4.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon5 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv5.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            var icon6 = new T.Icon({
                iconUrl: "${request.contextPath}/static/images/water_lv6.png",
                iconSize: new T.Point(25, 25),
                iconAnchor: new T.Point(10, 25)
            });
            //向地图上添加自定义标注
            $.post('${request.contextPath}/enviromonit/airMonitorPoint/getCityByType',{},function(data){
            	$.each(data,function(i){
            		var marker
            		if(data[i].color=='1'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon1});
					}else if(data[i].color=='2'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon2});
					}else if(data[i].color=='3'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon3});
					}else if(data[i].color=='4'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon4});
					}else if(data[i].color=='5'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon5});
					}else if(data[i].color=='6'){
						marker = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon6});
					}
            		map.addOverLay(marker);
            		addClickHandler(data[i].pointCode,marker);
            	});
				
			},"json");
        
			var sContent =
			"<div><div></div></div>"
			"<div style='margin:0px;'>" +
			"<div style='margin:10px 10px; '>" +
			"<img style='float:left;margin:0px 10px' src='http://lbs.tianditu.gov.cn/images/logo.png' width='101' height='49' title='天安门'/>" +
			"<div style='margin:10px 0px 10px 120px;'>电话 : (010)88187700 <br>地址：北京市顺义区机场东路国门商务区地理信息产业园2号楼天地图大厦" +
			"</div>" +
			"<input  id='keyWord' value='机场' type='text' style='border: 1px solid #cccccc;width: 180px;height: 20px;line-height: 20px;padding-left: 10px;display: block;float: left;'>" +
			"<input style='margin-left:195px;  width: 80px;height: 24px; text-align: center; background: #5596de;color: #FFF;border: none;display: block;cursor: pointer;' type='button' value='周边搜索'  onClick=\"localsearch.searchNearby(document.getElementById('keyWord').value,marker.getLngLat(),radius)\">" +
			"</div>" +
			"</div>";
            function addClickHandler(pointCode,marker){
                marker.addEventListener("click",function(e){
                    openInfo(pointCode,e)}
                );
            }
            function openInfo(pointCode,e){
               
                //var point = e.lnglat;
                //marker = new T.Marker(point);// 创建标注
                //var markerInfoWin = new T.InfoWindow(content,{offset:new T.Point(0,-30)}); // 创建信息窗口对象
                //map.openInfoWindow(markerInfoWin,point); //开启信息窗口
                fun(pointCode,data[0].monitrorTime);
            }
		});
		},"json");
        
      
        /*------------------------------------------------------根据城市id查找该城市下的站点信息-------------------------------------------------*/
        function fun(pointCode,monitrorTime){
        	$.post('${request.contextPath}/enviromonit/airHourData/cityStatus',{'pointCode':pointCode,'updateTime':monitrorTime},function(data){
					var colors;
					//alert(data[0].color);
					var text;
					$("#AQI").html("AQI："+data[0].AQI);
					$("#PM2").html("PM2.5："+data[0].PM2);
					$("#PM10").html("PM10："+data[0].PM10);
					$("#CO").html("CO："+data[0].CO);
					$("#No2").html("No2："+data[0].No2);
					$("#O3").html("O3："+data[0].O3);
					$("#So2").html("So2："+data[0].So2);
					$("#cityName").html(data[0].city);
					$("#updateTime").html("更新时间:"+data[0].time);
					if(data[0].color=='1'){
						colors ='#2ba4e9';
						text = '一级（优）';
					}else if(data[0].color=='2'){
						colors ='#a4e0a7';
						text = '二级（良）';
					}else if(data[0].color=='3'){
						colors ='#ffbf26';
						text = '三级（轻度）';
					}else if(data[0].color=='4'){
						colors ='#fe8a57';
						text = '四级（中度）';
					}else if(data[0].color=='5'){
						colors ='#ff6262';
						text = '五级（重度）';
					}else if(data[0].color=='6'){
						colors ='#d02032';
						text = '六级（严重）';
					}
					test(data[0].AQI/100,colors,text);
					$('#dg').datagrid('loadData',{total:0,rows:[]})
					
					$('#dg').datagrid({   
					    url:'${request.contextPath}/enviromonit/airHourData/pointStatus?pointCode='+data[0].pointCode+'&updateTime='+data[0].time  
					}); 
			},"json");
        }
    </script>
    
</body>

</html>
