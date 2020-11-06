var outfallMarker = new Array(); // 常规废水排口数组
var sewagePlantMarker = new Array(); // 污水处理厂数组
var selectedOutfallInfo = ""; // 已选择排口信息
var outfallChart = echarts.init(document.getElementById('outfallChart'));
var typePe = '';
/* 显示污染排口 */
function getPeMonitorPoints(peType) {
	typePe = peType;
	if(peType == "type1" && $("#sewagePlant").hasClass('choiced')){
		removeSewagePlantMarkers();
		$("#peName").textbox('setValue', '');
	} else if(peType == "other" && $("#outfall").hasClass('choiced')) {
		removeOutfallMarkers();
		$("#outfallNameQuery").textbox('setValue', '');
	} else {
		//map.centerAndZoom(new T.LngLat(117.5328, 24.5653), 9);
		$.ajax({
			type : 'POST',
			url : '/zphb/enviromonit/water/nationalSurfaceWater/getPeMonitorPoints',
			async : true,
			data : {peType : peType},
			success : function(result) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					var tempMarker;
					if(peType == "type1"){
						if(''!=data[i].cameraid&&undefined!=data[i].cameraid){
							tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
								icon : sewagePlant2_icon,
								map : map,
								title :data[i].name
							});
						 }else{
							 tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
								 	markerId : data[i].peId,
									icon : sewagePlant_icon,
									map : map
								});
						 }
						sewagePlantMarker[i] = tempMarker;
					} else {
						if(''!=data[i].cameraid&&undefined!=data[i].cameraid){
							 tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
									icon : outfall2_icon,
									map : map,
									title :data[i].name
								});
							
						}else{
							 tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
									icon : outfall_icon,
									map : map,
									title :data[i].name
								});
							}
						outfallMarker[i] = tempMarker;
					}
					map.addOverlay(tempMarker);
					var markerInfo = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color:#ffffff'>"
							+ "<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"
							+ data[i].name
							+ "</b></li><li>"
							+ data[i].address + "</li></ul>";
					//addMouseMoveEvent(markerInfo, tempMarker);
					addClickEvent(tempMarker, data[i]);
					markerMap.put(data[i].peId, tempMarker);
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
	 
		markerName.addClick(function(e) {
			selectedOutfallInfo = info;
			$('#outfallDlg').dialog('open').dialog('center').dialog('setTitle', '企业详情与分析');
			addOtherOutfall(info.peId);
			getOutfallInfo(info.peId);
			searchOutfallFactors(info.peId);
			showVideoAndPic(info);
		});
	}
}

function showVideoAndPic(info) {
	if (typePe == 'type1') {
		$("#wastewaterPlantFileInfoSet").show();
		if (!Ams.isNoEmpty(info.video)) {
			$("#out_videoBtn").hide();
		} else {
			$("#out_videoBtn").show();
			$('#out_videoBtn').attr("href", "javascript:play('" + info.video + "')");
		}

		if (!Ams.isNoEmpty(info.picture)) {
			$("#out_pdfBtn").hide();
		} else {
			$("#out_pdfBtn").show();
			$('#out_pdfBtn').attr("href", Ams.ctxPath + '/zphb/environment/waterAttachment/download/' + info.picture + '/2');
		}
	} else {
		$("#out_videoBtn").hide();
		$("#out_pdfBtn").hide();
		$("#wastewaterPlantFileInfoSet").hide();
	}
}

//
function searchOutfallFactors(peId) {
	$.ajax({
		type : "post",
		url : '/monitorPoint/pemonitorpoint/getFactor',
		async : true,
		data : {
			peId : peId,
			outType : "1"
		},
		success : function(result) {
			addOutfallFactors(result);
			searchConHourBar();
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}

//获取排口详细信息
function getOutfallInfo(peId) {
	$.ajax({
		type : 'POST',
		url : '/zphb/enviromonit/water/nationalSurfaceWater/getOutfallInfo',
		async : true,
		data : {
			peId : peId
		},
		success : function(result) {
			console.info(result)
			var data = result.data;
			document.getElementById('outfallName').innerHTML = data.name;
			document.getElementById('outfallInfo').innerHTML = '<span>经度：' + data.lng + '</span><span>纬度：' + data.lat + '</span>' +
				'<span>日累计流量：' + result.dayData + '千立方米</span><span>月累计流量：' + result.monthData + '千立方米</span>' +
				'<span>年累计流量：' + result.yearData + '千立方米</span><br><span>地址：' + data.address + '</span>'
					+ '<span>排污口位置：' + data.pos + '</span><span>负责人：' + data.principal + '</span>'
					+ '<span>负责人电话：' + data.tel + '</span>';
			$('#wastewaterPlantFileInfoSet').attr("href", "/zphb/enviromonit/water/wastewaterPlantFileAttachment?pid=" + $("#pid").val() + "&companyName=" + data.name);
			if(''!=data.cameraid&&undefined!=data.cameraid){
				document.getElementById('cameraView').innerHTML = '<a href="'+Ams.ctxPath+'/camera/localCameraController/mpvSingle?cameraId='+data.cameraid+'" class="title-link-tag" target="_blank">视频监控</a>';
			}else{
				document.getElementById('cameraView').innerHTML = '';
			}
			if (data.name == "漳浦县赤湖众城污水处理有限公司") {
                document.getElementById('pdfView').innerHTML = '<a href="/static/zphb/js/water/CTPZ19HJ0038漳浦县赤湖众城污水处理有限公司.pdf" target="_blank">监测报告</a>';
            } else if (data.name == "漳州绿江污水处理有限公司") {
                var html = '<a href="/static/zphb/js/water/WZJCJB-C2019080103-01漳州绿江（08月废水-进口）.pdf" target="_blank">8月监测报告</a>'
                    +' &nbsp;&nbsp;&nbsp;<a href="/static/zphb/js/water/CI0204 -漳州绿江污（09月废水-总排口）.pdf" target="_blank">9月监测报告</a>';
                document.getElementById('pdfView').innerHTML = html;
            } else {
                document.getElementById('pdfView').innerHTML = '';
            }
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}

//污水处理厂
function sewagePlantSearch() {
    $('#sewagePlantDg').datagrid('load', {
    	peName: $("#peName").val().trim()
    });
}
//鼠标回车事件  【污水处理厂】
Ams.inputText_enterKeyEvent('peName',sewagePlantSearch);

// 常规排口
function outfallSearch() {
    $('#outfallDg').datagrid('load', {
    	peName: $("#outfallNameQuery").val().trim(),
    	discharge: $("#discharge").val()
    });
}
//鼠标回车事件  【常规排口】
Ams.inputText_enterKeyEvent('outfallNameQuery',outfallSearch);

//搜索列表中的双击时间
$("#sewagePlantDg,#outfallDg").datagrid({
 	onDblClickRow: function (index, row) {
		map.setCenter(new fjzx.map.Point(row.longValue,row.latValue));
		addOtherOutfall(row.peId);
		getOutfallInfo(row.peId);
		searchOutfallFactors(row.peId);
		showVideoAndPic(row);
		$('#outfallDlg').dialog('open').dialog('center').dialog('setTitle', '企业详情与分析');
 	}
 });

//搜索列表中的单击事件
$('#sewagePlantDg').datagrid({onClickRow:function(index,data){
		animalMarker(data.peId);
		map.setCenter(new fjzx.map.Point(data.longValue,data.latValue));
	}
});
$('#outfallDg').datagrid({onClickRow:function(index,data){
		animalMarker(data.peId);
		map.setCenter(new fjzx.map.Point(data.longValue,data.latValue));
	}
});
$('#wpfsqyDg').datagrid({onClickRow:function(index,data){
		animalMarker(data.qymc);
		map.setCenter(new fjzx.map.Point(data.longitude,data.latitude));
	}
});
$('#reservoirDg').datagrid({onClickRow:function(index,data){
		map.setCenter(new fjzx.map.Point(data.longitude,data.latitude));
	}
});
$('#miniMonitorDg').datagrid({onClickRow:function(index,data){
		map.setCenter(new fjzx.map.Point(data.lng,data.lat));
	}
});
$('#basinDg').datagrid({onClickRow:function(index,data){
		animalMarker(data.code,0,0);
		map.setCenter(new fjzx.map.Point(data.lng,data.lat));
	}
});
$('#patrolDg').datagrid({onClickRow:function(index,data){
		map.setCenter(new fjzx.map.Point(data.lng,data.lat));
	}
});

//获取该企业下排口的污染因子
function addOutfallFactors(result) {
	var spans = "";
	for (var i = 0; i < result.length; i++) {
		if (i == 0) {
			spans += '<span class="active" value="' + result[i][0] + '">' + result[i][1] + '</span>';
		} else {
			spans += '<span value="' + result[i][0] + '">' + result[i][1] + '</span>';
		}
	}
	$("#outfallPltCodeList").html(spans);
}

//获取企业排口的趋势图
function searchConHourBar() {
	var ids = "";
	var check_val = [];
	var obj = document.getElementsByName("cb_outfall");
	for (k in obj) {
		if (obj[k].checked)
			check_val.push(obj[k].value);
	}
	if (check_val != "")
		ids += check_val;
	$.ajax({
		type : "post",
		url : '/monitorPoint/pemonitorpoint/getConHourchart',
		async : true,
		data : {
			outputId : ids,
			outType : "1",
			hours : $("#outfallTimeList span.active").attr("value"),
			code : $("#outfallPltCodeList span.active").attr("value")
		},
		success : function(result) {
			setOutfallChart(result);
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}

//获取该企业下的其他排污口
function addOtherOutfall(peId) {
	var checkboxs = "";
	$.ajax({
		type : 'POST',
		url : '/monitorPoint/pemonitorpoint/listNoPage',
		async : false,
		data : {
			outType : 1,
			peId : peId
		},
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				///if (i == 0) {
					checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_outfall" type="checkbox" checked value="'
							+ data[i][0] + '"/><span class="lbl">' + data[i][1] + '</span></label>';
				//} else {
					//checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_outfall" type="checkbox" value="'
					//		+ data[i][0] + '"/><span class="lbl">' + data[i][1] + '</span></label>';
				//}
			}
			$("#outfallList").html(checkboxs);
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
}

//企业排口趋势图
function setOutfallChart(result) {
	outfallChart.clear();
	var series = result.series;
	var time = result.xAxis;
	var legend = result.legend;
	var outfallChartOption = {
		title : {
			text : $("#outfallPltCodeList span.active").text() + result.unit,
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

	outfallChart.setOption(outfallChartOption);

}


/*删除地图上的点*/
function removeOutfallMarkers() {
	for (var i = 0; i < outfallMarker.length; i++) {
		map.removeOverLay(outfallMarker[i]);
	}
}

function removeSewagePlantMarkers() {
	for (var i = 0; i < sewagePlantMarker.length; i++) {
		map.removeOverLay(sewagePlantMarker[i]);
	}
}


/**
 * 视频播放
 */
function play(mongoid) {
	$('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
	$('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
}

var myVideo = document.getElementById("video");//获取video对象
// 关闭视频后关闭声音
$("#videoDlg").dialog({
	onClose: function () {
		myVideo.pause();
	}
});

