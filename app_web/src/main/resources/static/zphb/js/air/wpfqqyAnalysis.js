var wpfsqyMarkers = new Array(); // 流域站点数组
// 污普废气企业
var markerMap = new HashMap();
function wpfqqySearch() {
    $('#wpfqqyDg').datagrid('load', {
    	qymc: $("#wpfqqyName").val().trim()
    });
}

//鼠标回车事件  【污普废气企业】
Ams.inputText_enterKeyEvent('wpfqqyName',wpfqqySearch);

function getWpfqqy() {
	if ($("#wpfqqy").hasClass('choiced')) {
		$("#wpfqqyName").textbox('setValue', '');
		remove(wpfsqyMarkers);
	} else {
		$.ajax({
			type : "post",
			url : "/zphb/enviromonit/airEnvironment/getPolluteAirData",
			async : true,
			success : function(result) {
				var data = result.data;
				console.log(data);
				for (var i = 0; i < data.length; i++) {
					var tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].lng, data[i].lat), {
						icon : waste_gas,
						map : map,
						title :data[i].name
	       			});	
					wpfsqyMarkers[i] = tempMarker;
					map.addOverlay(tempMarker);
					var markerInfo = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color:#ffffff'>"
							+ "<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"
							+ data[i].name+ "</b></li><li>"+ data[i].address + "</li></ul>";
					addMouseMoveEvent(markerInfo, tempMarker);
					addClickEvent(tempMarker, data[i]);


						markerMap.put(data[i].name, tempMarker);
						console.log(markerMap);

				}
			},
			error : function() {
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
			getWpfqqyInfo(info);
			$('#wpfqDg').dialog('open').dialog('center').dialog('setTitle', '企业详情');
		});
	}
}

function getWpfqqyInfo(info){
	
	$.ajax({
		type : 'POST',
		url : '/enviromonit/airEnvironment/getPolluteAirDataDetail',
		async : true,
		data : {qymc : info.name},
		success : function(result) {
			var data = result.data;
			document.getElementById('wpfsqyName').innerHTML = info.name;
			document.getElementById('wpfsqyInfo').innerHTML = '<span>经度：' + info.lng + '</span>'
					+ '<span>纬度：' + info.lat + '</span><span>地级市：' + data[0].ds + '</span>'
					+ '<span>区县：' + data[0].qx + '</span><span>地址：' + info.address + '</span>'
					+ '<span></span><span>联系人：' + data[0].lxr + '</span>'
					+ '<span>联系人电话：' + data[0].lxdh + '</span>';
			var tableHtml = "<tr><td class='tit'>因子名称</td><td class='tit'>数值</td></tr>";
			for(var i=0; i<data.length; i++){
				tableHtml += "<tr><td class='tit'>" + data[i].wrw + "</td>"
				+ "<td class='con'>" + data[i].pfl + "</td></tr>";
			}
			document.getElementById('wpfsqyTableInfo').innerHTML = tableHtml;
		},
		error : function(jqXHR, textStatus, errorThrown) {
		},
		dataType : 'json'
	});
	
}

function clearWpfsqyMarkers() {
	for (var i = 0; i < wpfsqyMarkers.length; i++) {
		map.removeOverLay(wpfsqyMarkers[i]);
	}
}
