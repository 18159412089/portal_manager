var construction = new Array(); // 工地
/* 添加工地上的点 */

function creatConstruction() {

	// 向地图上添加自定义标注
	$.post('/enviromonit/airConstructionSite/getConstructionInfo', {},
			function(data) {

				$.each(data, function(i) {
					var marker;
					var row = {};

					row = new fjzx.map.Marker(new fjzx.map.Point(
							data[i].longitude, data[i].latitude), {
						icon : icon16,
						map : map,
						title : data[i].name
					});
					row.id = i;
					construction.push(row);
					map.addOverlay(row);
					addClickHandler(data[i], row);
				});
			}, "json");

    /* 点击事件 */
    function addClickHandler(data, marker) {
        marker.addClick(function (e) {
            showContainer(data);
        });
    }

    /* 鼠标移动到指点地点触发 */
    function onMouseOver(m, lnglats, e) {
        var point = e.lnglat;
        var h = "<ul style='font-size:12px;border-radius:5px;list-style: none;padding: 10px;border: 1px solid;color: #ffffff;"
            + "'>"
            + "<li style='font-size: 14px;border-bottom: 1px double;color: #ffffff;'><b>"
            + lnglats[m.id].name
            + "</b>"
            + "<sub>点击可查看详情<sub></sub></sub></li><li>工地名称"
            + lnglats[m.id].name
            + "</li><li>工地规模："
            + isNull(lnglats[m.id].builtValue)
            + "</li><li>企业名称："
            + isNull(lnglats[m.id].responOrganization)
            + "</li><li>经度："
            + isNull(lnglats[m.id].longitude)
            + "</li><li>纬度："
            + isNull(lnglats[m.id].latitude) + "</li></ul>";
        markerInfoWin = new T.InfoWindow(h, {
            offset: new T.Point(0, -30),
            closeButton: false
        }); // 创建信息窗口对象
        map.openInfoWindow(markerInfoWin, point); // 开启信息窗口
    }

}

/* 在建工地窗口 */
function showContainer(data) {

    $("#containerInfo")[0].innerHTML = "<span style='width:20%;'>经度："
        + isNull(data.longitude) + "</span><a id=\"infoSet\" class=\"title-link-tag\"\n" +
        "target=\"_blank\">图片视频上传>></a><br>"
        + "<span style='width:20%;'>纬度：" + isNull(data.latitude)
        + "</span>\n" +
        "<a id=\"companyInfoSet\" class=\"title-link-tag\"\n" +
        "target=\"_blank\">企业信息配置>></a><br>" + "<span style='width:99%;'>工地名称：" + data.name
        + "</span><br>" + "<span style='width:99%;'>工地规模："
        + isNull(data.builtValue) + "</span><br>"
        + "<span style='width:99%;'>企业名称："
        + isNull(data.responOrganization) + "</span>";
    $("#containerNames").html(data.name);
    if (!Ams.isNoEmpty(data.video)) {
        $("#videoBtn").hide();
    } else {
        $("#videoBtn").show();
        $('#videoBtn').attr("href", "javascript:play('" + data.video + "')");
    }

    if (!Ams.isNoEmpty(data.picture)) {
        $("#pdfBtn").hide();
    } else {
        $("#pdfBtn").show();
        $('#pdfBtn').attr("href", Ams.ctxPath + '/environment/waterAttachment/download/' + data.picture + '/2');
    }
    $('#infoSet').attr("href", "/enviromonit/airConstructionSite/fileAttachment?pid=" + $("#pid").val() + "&name=" + data.name);
    $('#companyInfoSet').attr("href", "/enviromonit/airConstructionSite/companyInfoSet?pid=" + $("#pid").val() + "&name=" + data.name);
    $('#infoSetGlobal').attr("href", "/enviromonit/airConstructionSite/fileAttachment?pid=" + $("#pid").val());
    $('#container').window('open');
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