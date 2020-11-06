var wpfsqyMarkers = new Array(); // 流域站点数组
function getWpfsqy() {
	if ($("#wpfsqy").hasClass('choiced')) {
		clearWpfsqyMarkers();
		$("#queryWpfsqyName").textbox('setValue', '');
		$("#mapTabs_wpfsqy").css('display','none');
		$('#mapTabs_wpfsqy').css('pointer-events','none');
	} else {
		$('#mapTabs_wpfsqy').css('display','block');
		$('#mapTabs_wpfsqy').css('pointer-events','auto');
		$('#wpfsqyDg').datagrid({url:'/enviromonit/water/nationalSurfaceWater/getWpfsqyList'});
		$("#wpfsqyDg").datagrid('getPager').pagination({
            showPageList:false,
            showRefresh:false,
            layout:['first','prev','links','next','last'],
            links:3
          });
		$.ajax({
			type : "post",
			url : "/enviromonit/water/nationalSurfaceWater/getPolluteWaterData",
			async : true,
			success : function(result) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					var tempMarker = new fjzx.map.Marker( new fjzx.map.Point(data[i].longitude, data[i].latitude), {
						icon : wpfsqy_icon,
						map : map,
						title :data[i].qymc
					});
					wpfsqyMarkers[i] = tempMarker;
					map.addOverlay(tempMarker);
					addClickEvent(tempMarker, data[i]);
				}
			},
			error : function() {
			},
			dataType : 'json'
		});
	}

	function addClickEvent(markerName, info) {
		markerName.addClick( function(e) {
			getWpfsqyInfo(info);
			$('#wpfsqyDlg').dialog('open').dialog('center').dialog('setTitle', '企业详情');
		});
	}
}

function getWpfsqyInfo(info){
	if (!Ams.isNoEmpty(info.video)) {
		$("#videoBtn").hide();
	} else {
		$("#videoBtn").show();
		$('#videoBtn').attr("href", "javascript:play('" + info.video + "')");
	}

	if (!Ams.isNoEmpty(info.picture)) {
		$("#pdfBtn").hide();
	} else {
		$("#pdfBtn").show();
		$('#pdfBtn').attr("href", Ams.ctxPath + '/environment/waterAttachment/download/' + info.picture + '/2');
	}
	$('#wastewaterCompanyFileInfoSet').attr("href", "/enviromonit/water/wastewaterFileAttachment?pid=" + $("#pid").val() + "&companyName=" + encodeURIComponent(info.qymc));
	$('#wastewaterCompanyInfoSet').attr("href", "/enviromonit/water/wastewaterCompanySet?pid=" + $("#pid").val() + "&qymc=" + encodeURIComponent(info.qymc));
	$.ajax({
		type : 'POST',
		url : '/enviromonit/water/nationalSurfaceWater/getPolluteWaterDataDetail',
		async : true,
		data : {qymc : info.qymc},
		success : function(result) {
			var data = result.data;
			document.getElementById('wpfsqyName').innerHTML = info.qymc;
			document.getElementById('wpfsqyInfo').innerHTML = '<span>经度：' + info.longitude + '</span>'
					+ '<span>纬度：' + info.latitude + '</span><span>地级市：' + data[0].ds + '</span>'
					+ '<span>区县：' + data[0].qx + '</span><span>地址：' + data[0].address + '</span>'
					+ '<span></span><span>联系人：' + data[0].lxr + '</span>'
					+ '<span>联系人电话：' + data[0].lxdh + '</span>';
            if(''!=data.cameraid&&undefined!=data.cameraid){
                document.getElementById('cameraViewBtn').innerHTML = '<a href="'+Ams.ctxPath+'/camera/localCameraController/mpvSingle?cameraId='+data.cameraid+'" class="title-link-tag" target="_blank">视频监控</a>';
            }else{
                document.getElementById('cameraViewBtn').innerHTML = '';
            }
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

// 污普废水
function wpfsqySearch() {
    $('#wpfsqyDg').datagrid('load', {
        name: $("#queryWpfsqyName").val().trim()
    });
}
//鼠标回车事件  【污普废水】
Ams.inputText_enterKeyEvent('queryWpfsqyName',wpfsqySearch);

$("#wpfsqyDg").datagrid({
 	onDblClickRow: function (index, row) {
		map.setCenter(new fjzx.map.Point(row.longitude,row.latitude));
		getWpfsqyInfo(row);
		$('#wpfsqyDlg').dialog('open').dialog('center').dialog('setTitle', '企业详情');
 		
 	}
 });

function clearWpfsqyMarkers() {
	for (var i = 0; i < wpfsqyMarkers.length; i++) {
		map.removeOverlay(wpfsqyMarkers[i]);
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