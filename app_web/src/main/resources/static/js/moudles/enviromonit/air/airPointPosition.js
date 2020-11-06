var map = new T.Map("mapDiv");  //初始化地图对象
var markerInfoWin = new T.InfoWindow("11",{offset:new T.Point(0,-30)});
var cityPoint = new Array(); //城市站点
var monitorPoint = new Array();  //监测站点
var newTime; //最新数据的时间
var size ; //地图放大的大小
var icon1 = new T.Icon({
    iconUrl: "/static/images/air/city_1.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon2 = new T.Icon({
    iconUrl: "/static/images/air/city_2.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon3 = new T.Icon({
    iconUrl: "/static/images/air/city_3.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon4 = new T.Icon({
    iconUrl: "/static/images/air/city_4.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon5 = new T.Icon({
    iconUrl: "/static/images/air/city_5.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon6 = new T.Icon({
    iconUrl: "/static/images/air/city_6.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon7 = new T.Icon({
    iconUrl: "/static/images/air/city_7.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});

//创建监测站点图片对象
var icon8 = new T.Icon({
    iconUrl: "/static/images/air/point_1.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon9 = new T.Icon({
    iconUrl: "/static/images/air/point_2.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon10 = new T.Icon({
    iconUrl: "/static/images/air/point_3.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon11 = new T.Icon({
    iconUrl: "/static/images/air/point_4.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon12 = new T.Icon({
    iconUrl: "/static/images/air/point_5.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon13 = new T.Icon({
    iconUrl: "/static/images/air/point_6.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});
var icon14 = new T.Icon({
    iconUrl: "/static/images/air/point_7.png",
    iconSize: new T.Point(25, 25),
    iconAnchor: new T.Point(10, 25)
});

$(function(){
	/*地图监听事件 删除和添加地图上的点*/
	 map.addEventListener('zoomend', function () {
	    	if(map.getZoom()<11 && size != map.getZoom()){
				if(size < 11 ) {
					size = map.getZoom();
					
					return 0;
				}
				size = map.getZoom();
				remove(monitorPoint);
				creatMarker("1");
				
			}else if(map.getZoom()>=11 && size != map.getZoom() ){
				if(size >=11) {
					size = map.getZoom();
					map.removeOverLay(markerInfoWin);
					return 0;
				}
				size = map.getZoom();
				remove(cityPoint);
				creatMarker("0");
			}
	 })
});


/*添加地图上的点并设置显示内容*/
function creatMarker(type){
	//向地图上添加自定义标注
    $.post( Ams.ctxPath+'/enviromonit/airMonitorPoint/getCityByType?type='+type,{},function(data){
    	var markes = [];
    	$.each(data,function(i){
    		var marker;
    		var row = {};
    			if(type == '1'){
    				if(data[i].color < 0){
					row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon7});
					add(row,data[i],'#b8b8b8');
					}else if(data[i].color <=50){
            			row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon1});
            			add(row,data[i],'#00E400');
					}else if(data[i].color <= 100){
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon2});
						add(row,data[i],'#FFFF00');
					}else if(data[i].color <= 150){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon3});
						add(row,data[i],'#FF7E00');
					}else if(data[i].color <= 200){
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon4});
						add(row,data[i],'#FF0000');
					}else if(data[i].color <= 300){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon5});
						add(row,data[i],'#99004C');
					}else if(data[i].color <= 500){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon6});
						add(row,data[i],'#7E0023');
					}
					cityPoint.push(row);
				}
				else if(type == '0'){
				
					if(data[i].color < 0){
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon14});
						add(row,data[i],'#b8b8b8');
					}else if(data[i].color <=50){
            			row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon8});
            			add(row,data[i],'#00E400');
					}else if(data[i].color <= 100){
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon9});
						add(row,data[i],'#FFFF00');
					}else if(data[i].color <= 150){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon10});
						add(row,data[i],'#FF7E00');
					}else if(data[i].color <= 200){
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon11});
						add(row,data[i],'#FF0000');
					}else if(data[i].color <= 300){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon12});
						add(row,data[i],'#99004C');
					}else if(data[i].color <= 500){
						
						row = new T.Marker(new T.LngLat(data[i].longitude ,data[i].latitude), {icon: icon13});
						add(row,data[i],'#7E0023');
					}
					monitorPoint.push(row);
				}
				row.id = i;
				//markes.push(row)
    			map.addOverLay(row);
    			if(type == 1 && sign == 1){
    				addClickHandler(data[i].pointCode,row);
    			}
    			if(sign ==2){
    				addClickHandler(data[i].pointCode,data[i].pointType,row);
    			}
    	});
    	
		if(type == '1'){
			addTEvent(cityPoint,cityPoint,onMouseOver)
		}else if(type == '0'){
			addTEvent(monitorPoint,monitorPoint,onMouseOver)
		}
	},"json");

	
    
    /*添加点位各种信息 regionName*/
    function add(row,data,colors){
    	row.color = colors;
		row.name = data.pointName;
		row.monitrorTime = data.monitrorTime;
		row.longitude = data.longitude;
		row.aqi = data.aqi;
		row.latitude = data.latitude;
		row.pointType = data.pointType;
		row.CO = data.CO;
		row.No2 = data.No2;
		row.PM10 = data.PM10;
		row.PM2 = data.PM2;
		row.So2 = data.So2;
		row.O3 = data.O3;
    }
    /*为每个maker 加载mouseover与mouseout事件 */
    function addTEvent(iconMakers,lnglats,eventFn){
		var arrLen = lnglats.length;
		var i,eventFn = eventFn || onMouseOver;
		for (var i = 0;  i<arrLen; i++) {
			iconMakers[i].id=i;
			// 绑定事件
			(function() {
				var m = iconMakers[i];
			
				m.addEventListener( "mouseover",function(e) {
		               timer = setTimeout(mover, 100);//setTimeout不能带参数，所以用下面的方法处理。
		               function mover() {
		               	eventFn(m,lnglats,e);
		               }
		           });
				m.addEventListener("mouseout", onClose);
			})();
		}
	}
	
	/*鼠标移动到指点地点触发*/
	function onMouseOver(m,lnglats,e) {
		var type = "" ;
		if(lnglats[m.id].pointType=='1'){
			type ="城市:";
		}
		else{
			type ="站点：";
		}
		
		var point = e.lnglat;
		var h = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color:"+lnglats[m.id].color+"'>"+
		"<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"+lnglats[m.id].name+"</b>"+
		"<sub>点击可查看详情<sub></sub></sub></li><li>"+type+lnglats[m.id].name+
		"</li><li>更新时间："+lnglats[m.id].monitrorTime+
		"</li><li>AQI："+lnglats[m.id].aqi+
		"</li><li>PM2.5："+isNull(lnglats[m.id].PM2)+
		"</li><li>PM10："+isNull(lnglats[m.id].PM10)+
		"</li><li>CO："+isNull(lnglats[m.id].CO)+
		"</li><li>No2："+isNull(lnglats[m.id].No2)+
		"</li><li>O3："+isNull(lnglats[m.id].O3)+
		"</li><li>So2："+isNull(lnglats[m.id].So2)+"</li></ul>"; 
    	markerInfoWin = new T.InfoWindow(h,{offset:new T.Point(0,-30)}); // 创建信息窗口对象
        map.openInfoWindow(markerInfoWin,point); //开启信息窗口
    }
   
}

/*关闭定时器*/
function onClose() {
	clearTimeout(timer);//关闭定时器。
	map.removeOverLay(markerInfoWin);//移除信息窗口。
}


/*删除地图上的点*/
function remove(marker){
	for (var i =0 ; i < marker.length; i++) { //倒序删除避免长度发生变化
			map.removeOverLay(marker[i]);
	}
}

