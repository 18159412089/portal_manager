var reservoirMarker = new Array(); // 水库数组
var reservoirChart = echarts.init(document.getElementById('reservoirChart'));
var id ;

// 水库
function reservoirSearch() {
    $('#reservoirDg').datagrid('load', {
    	name: $("#reservoirNameQuery").val().trim()
    });
}
//鼠标回车事件  【水库】
Ams.inputText_enterKeyEvent('reservoirNameQuery',reservoirSearch);

/* 显示水库下泄 */

function getReservoirPoints(peType) {
	if(peType == "reservoir" && $("#reservoir").hasClass('choiced')) {
		$("#reservoirNameQuery").textbox('setValue', '');
		removeReservoirMarker();
	}else {
		//map.centerAndZoom(new T.LngLat(117.5328, 24.5653), 9);
		$.ajax({
			type : 'POST',
			url : '/enviromonit/water/nationalSurfaceWater/getReservoirPoints',
			async : true,
			data : {},
			success : function(result) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					var tempMarker;
					 
					tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
						icon : reservoir_icon,
						map : map,
						title :data[i].name
					});
					 
					reservoirMarker[i] = tempMarker;
				 
					
				 
				/*	var markerInfo = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color:#ffffff'>"
							+ "<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"
							+ data[i].name
							+ "</b></li><li>"
							+ data[i].address + "</li></ul>";
					addMouseMoveEvent(markerInfo, tempMarker);*/
					 
					map.addOverlay(tempMarker);
					addClickEvent(tempMarker, data[i]);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
			},
			dataType : 'json'
		});
	}

	function addMouseMoveEvent(content, markerName) {
		var markerInfoWin = "";
		markerName.addEventListener("mouseover", function(e) {
			var point = e.lnglat;
			markerInfoWin = new T.InfoWindow(content, {
				offset : new T.Point(0, -30)
			});
			map.openInfoWindow(markerInfoWin, point); // 开启信息窗口
		});
		markerName.addEventListener("mouseout", function(e) {
			map.removeOverLay(markerInfoWin); // 开启信息窗口
		});
	}

	function addClickEvent(markerName, info) {
		 //marker 点击事件
		markerName.addClick(function(e) {
			selectedOutfallInfo = info;
			$('#reservoirDlg').dialog('open').dialog('center').dialog('setTitle', '水库详情与分析');
			//addOtherOutfall(info.peId);
			getReservoirInfo(info.eqpID);
			//addReservoirFactors();
			id = info.eqpID;
			searchConDayBar();
		});
		
		
	}
}

//搜索列表中的双击时间
$("#reservoirDg").datagrid({
 	onDblClickRow: function (index, row) {
		map.setCenter(new fjzx.map.Point(row.longitude,row.latitude));
		$('#reservoirDlg').dialog('open').dialog('center').dialog('setTitle', '水库详情与分析');
		getReservoirInfo(row.eqpId);
		id = row.eqpId;
		searchConDayBar();
 	}
 });

//获取水库详细信息
function getReservoirInfo(eqpID) {
	$.ajax({
		type : 'POST',
		url : '/enviromonit/water/nationalSurfaceWater/getReservoirInfo',
		async : true,
		data : {
			eqpID : eqpID
		},
		success : function(result) {
			var data = result.data;
			document.getElementById('reservoirName').innerHTML = data.name;
			document.getElementById('reservoirInfo').innerHTML = '<span>经度：' + data.lng + '</span>'
					+'<span>纬度：' + data.lat + '</span>'+'<span>地址：' + data.address + '</span>'
					+ '<span>正常蓄水位：' + data.normal + '</span><span>最大蓄水位：' + data.max + '</span>'
					+ '<span>最小蓄水位：' + data.min + '</span>';
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}


//获取水库下泄流量的趋势图
function searchConDayBar() {
	$.ajax({
		type : "post",
		url : '/reservoir/reservoir/getConDaychart',
		async : true,
		data : {
			eqpID:id,
			days : $("#reservoirTimeList span.active").attr("value")
			//code : $("#reservoirCodeListScroll span.active").attr("value")
		},
		success : function(result) {
			setReservoirChart(result);
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}



//水库下泄流量趋势图
function setReservoirChart(result) {
	reservoirChart.clear();
	var series = result.series;
	var time = result.xAxis;
	var legend = result.legend;
	var reservoirChartOption = {
		title : {
			text :  "立方米/秒",
			textStyle : {
				fontSize : 16,
				color : '#000000'
			},
			left : '10',
			top : '10'
		},
		textStyle : {
			color : '#000000'
		},
		tooltip : {
			trigger : 'axis',
			axisPointer : { // 坐标轴指示器，坐标轴触发有效
				type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			}
		},
		toolbox : {
			show : true,
			orient : 'vertical',
			left : '10',
			top : '80',
			iconStyle : {
				borderColor : '#000000'
			},
			feature : {
				magicType : {
					show : true,
					type : [ 'bar', 'line' ]
				},
				saveAsImage : {
					show : true
				},
				restore : {
					show : true
				}
			}
		},
		legend : {
			orient : 'horizontal',
			top : '8%',
			right : '30',
			textStyle : {
				color : '#000000'
			},
			data : legend
		},
		grid : {
			top : '80',
			left : '50',
			right : '30',
			bottom : '10',
			containLabel : true
		},
		xAxis : {
			type : 'category',
			axisLabel : {
				type : 'category'
			},
			data : time
		},
		yAxis : {
			type : 'value',
		},
		series : series
	};

	reservoirChart.setOption(reservoirChartOption);

}


/*删除地图上的点*/
function removeOutfallMarkers() {
	for (var i = 0; i < outfallMarker.length; i++) {
		map.removeOverlay(outfallMarker[i]);
	}
}

function removeSewagePlantMarkers() {
	for (var i = 0; i < sewagePlantMarker.length; i++) {
		map.removeOverlay(sewagePlantMarker[i]);
	}
}

function removeReservoirMarker() {
	for (var i = 0; i < reservoirMarker.length; i++) {
	    map.removeOverlay(reservoirMarker[i]);
	}
}