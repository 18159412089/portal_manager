	var point = new Array(); //城市站点
	var localsearch;
	var icon1 = new T.Icon({
	    iconUrl: "http://api.tianditu.gov.cn/v4.0/image/marker-icon.png",
	    iconSize: new T.Point(26, 40),
	    iconAnchor: new T.Point(13, 40)
	});
	// 地图初始化
	 function init() {
            map = new T.Map("mapDiv");
            map.centerAndZoom(new T.LngLat(117.64349, 24.51925), 9);
            var cp = new T.CoordinatePickup(map, {callback: getLngLat})
            cp.addEvent();
           
            //创建对象 
    		geocoder = new T.Geocoder();
    }
	init();
	// 获取经纬度、创建对应的点。
    function getLngLat(lnglat) {
    	remove(point);
    	var lng = lnglat.lng.toFixed(6);
    	var lat = lnglat.lat.toFixed(6)
        $("#lng").val(lng);
        $("#lat").val(lat);
        var market = new T.Marker(new T.LngLat(lng ,lat), {icon: icon1});
        point.push(market);
        map.addOverLay(market);
            
    }
    //确定按钮
	function ok(){
		$("#longitude_").textbox('setValue',$('#lng').val());
		$("#latitude_").textbox('setValue',$('#lat').val());
    	$('#map').dialog('close');
	}
	// 打开地图取点窗口
	function openMap(){
		remove(point);
    	var lng = $("#longitude_").textbox('getValue');
    	var lat = $("#latitude_").textbox('getValue');
      if(lng !=""&& lat != ""){
      	var market = new T.Marker(new T.LngLat(lng ,lat), {icon: icon1});
      	point.push(market);
        map.addOverLay(market);
        $("#lng").val(lng);
        $("#lat").val(lat);
      }
     
		$('#map').window('open');
	}
    
    /*删除地图上的点*/
    function remove(marker){
    	for (var i =0 ; i < marker.length; i++) { //倒序删除避免长度发生变化
    			map.removeOverLay(marker[i]);
    	}
    }
    
    function searchResult(result)
	{	
    	
		if(result.getStatus() == 0){
			remove(point);
			map.panTo(result.getLocationPoint(), 13);
			//创建标注对象
	        var marker = new T.Marker(result.getLocationPoint());
	        var lng = result.getLocationPoint().lng;
	    	var lat = result.getLocationPoint().lat;
	        $("#lng").val(lng);
	        $("#lat").val(lat);
	        //向地图上添加标注
	        point.push(marker);
	        map.addOverLay(marker);
		}else{
			$("#lng").val("");
	        $("#lat").val("");
			alert(result.getMsg());
		}
		
	}
	
	function search(){
		map.clearOverLays();
		geocoder.getPoint(document.getElementById("searchPoint").value, searchResult);
	}    