var BasePath = "https://140.237.73.123:9041/EpaProblemProcessing/";

var miniMonitors = new Array();
var miniMonitorData = new Array();
//巡河轨迹相关参数
var currentIndex1 = 0;
var markerObject = null;
var lushuSpeed = 1000;	//图标运行速度
var autoView = false;//自动视野调整
var handlerInterval;
var trackMap = null;
var lushuColors = ["#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000","#FF0000"];

function getPatrolList(riverName,pageNumber,pageSize){
	$.ajax({
		type : 'POST',
		url :"/enviromonit/water/nationalSurfaceWater/getPatrolPointsList",
		dataType : 'json',
		data : {
			'riverName' : riverName,
			'page': pageNumber,
			'rows': pageSize
		},
		success : function(result) {
			$("#patrolDg").datagrid("loadData", {total : result.maxSize,rows : result.data});
		},
		error: function(){
		}
	});
};

function patrolSearch(){
	getPatrolList($("#riverName").val().trim(),0,$("#patrolDg" ).datagrid("getPager" ).data("pagination" ).options.pageSize);
}

//鼠标回车事件  【巡河】
Ams.inputText_enterKeyEvent('riverName',patrolSearch);

//巡河记录列表中的双击事件
$("#patrolDg").datagrid({
    onDblClickRow: function (index, row) {
        map.setCenter(new fjzx.map.Point(row.lng,row.lat));
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/getPatrolInfo",
            async: true,
            data: {patrolId:row.id},
            success: function (result) {
                openPatrolPointDlg(row,result);
            },
            error: function () {
            },
            dataType: 'json'
        });
    }
 });

function getPatrol() {
    if ($("#patrol").hasClass('choiced')) {
    	$("#riverName").textbox('setValue', '');
        for (var i = 0; i < miniMonitors.length; i++) {
            map.removeOverlay(miniMonitors[i]);
        }
        miniMonitors = new Array();
    } else {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/getPatrolPoints",
            async: true,
            data: {},
            success: function (result) {
                var data = result.data;
                for (var i = 0; i < data.length; i++) {
                    var tempMarker;
                    tempMarker = new fjzx.map.Marker(new fjzx.map.Point(data[i].startLng, data[i].startLat), {
                        icon: patrol_icon,
                        map: map,
                        title: data[i].riverName
                    });
                    miniMonitors[i] = tempMarker;
                    map.addOverlay(tempMarker);
                    addClickEvent(tempMarker, data[i]);
                }

            },
            error: function (data) {
            },
            dataType: 'json'
        });
        
        getPatrolList($("#riverName").val().trim(),0,$("#patrolDg" ).datagrid("getPager" ).data("pagination" ).options.pageSize);
        
    }

    $('#patrolDg').datagrid('getPager').pagination({
        onSelectPage:function(pageNumber, pageSize){
            getPatrolList($("#riverName").val().trim(),pageNumber-1,pageSize);
        }
    });
    
    function addClickEvent(markerName, info) {
        //marker 点击事件
        markerName.addClick(function(e) {
            $.ajax({
                type: "post",
                url: "/enviromonit/water/nationalSurfaceWater/getPatrolInfo",
                async: true,
                data: {patrolId:info.id},
                success: function (result) {
                    openPatrolPointDlg(info,result);
                },
                error: function () {
                },
                dataType: 'json'
            });
        });
    }
}

/**
 * 巡河弹窗,点击地图标注点弹窗巡河记录相关数据
 * @param info
 * @param data
 */
function openPatrolPointDlg(info, data) {
    $('#patrolDlg').dialog('open').dialog('center').dialog('setTitle', info.riverName + '<a style="padding-left: 600px">查看更多>></a>');
    $('#positionB').html(info.startPosition);
    $('#positionE').html(info.endPosition);
    $('#timeEffect').html(Math.floor(info.duration / 3600) + "时" + Math.floor((info.duration % 3600) / 60) + "分" + info.duration % 60 + "秒");
    $('#distanceEffect').html(info.distance + '米');
    $('#belongRiver').html(info.riverName);
    $('#patrolTime').html(Ams.timeDateFormat(info.startTime));

    var riverPatrol = data.riverPatrol;
    var riverPatrolReports = data.riverPatrolReports;
    var riverPatrolReportFiles = data.riverPatrolReportFiles;
    var riverPatrolTracks = data.riverPatrolTracks;

    //显示巡河记录上报附件（随手拍）
    var riverPatrolReportMap = new HashMap();
    for(var i=0;i<riverPatrolReports.length;i++){
        var report = riverPatrolReports[i];
        riverPatrolReportMap.put(report.id, report);
    }
    showRiverPatrolReportImage(riverPatrolReportMap,riverPatrolReportFiles);

    //显示巡河轨迹
    var points = [];
    for(var i=0;i<riverPatrolTracks.length;i++){
        var latitude = riverPatrolTracks[i].lat;
        var longitude = riverPatrolTracks[i].lng;
        if(isNaN(latitude) || isNaN(longitude)){
            continue;
        }
        var localPoint =  new fjzx.map.Point(longitude,latitude);
        points.push(localPoint);
    }
    if(trackMap==null){
        initTrackMap();
    }
    //points = [[25.086750,117.012769],[25.086750,117.012769],[25.087308,117.014008],[25.086844,117.013519],[25.087308,117.014008],[25.086789,117.013117],[25.087308,117.014008],[25.087308,117.014008],[25.087308,117.014008],[25.086758,117.013700],[25.086950,117.013586],[25.086789,117.013117],[25.086789,117.013117],[25.087308,117.014008],[25.086789,117.013117],[25.086950,117.013586],[25.087333,117.013981],[25.086789,117.013117],[25.087308,117.014008],[25.086758,117.013700],[25.086758,117.013700],[25.086789,117.013117],[25.086844,117.013519],[25.086758,117.013700],[25.086942,117.013078],[25.086750,117.012769],[25.086758,117.013700],[25.087308,117.014008],[25.086789,117.013117],[25.086789,117.013117],[25.087506,117.013478],[25.087308,117.014008],[25.087506,117.013478],[25.086789,117.013117],[25.087506,117.013478],[25.087506,117.013478],[25.086789,117.013117],[25.086844,117.013519],[25.086789,117.013117],[25.087308,117.014008],[25.087308,117.014008],[25.086789,117.013117],[25.086789,117.013117],[25.086942,117.013078],[25.087308,117.014008],[25.086789,117.013117],[25.087506,117.013478],[25.087506,117.013478],[25.086789,117.013117],[25.086750,117.012769],[25.087308,117.014008],[25.087506,117.013478],[25.086758,117.013700],[25.086789,117.013117],[25.086758,117.013700],[25.086789,117.013117]];
    setTimeout(function(){
        showTrack(points);
    },1000);
}

/**
 * 随手拍缩略图列表
 * @param riverPatrolReportMap
 * @param reportFiles
 */
function showRiverPatrolReportImage(riverPatrolReportMap, reportFiles){
    var li = "";
    for(var i=0;i<reportFiles.length;i++){
        var record = reportFiles[i];
        record.fileType = record.ext;

        var fileId = '';
        //if(record.fileType == "IMAGE"){
        if(record.fileType=="bmp" || record.fileType=="png" || record.fileType=="gif" || record.fileType=="jpg" || record.fileType=="jpeg"){
            fileId = record.id;
            li += '<div class="swiper-slide thumb-img " tag="'+i+'" title="'+record.originalFileName+'" referenceId="'+record.referenceId+'">';
            li += '<div class="img" style="background-image:url('+BasePath+'showImage.download?uploadDownloadControllerId=common&fileId='+record.id+');" alt="'+record.originalFileName+'" referenceId="'+record.referenceId+'"></div>';
            li += '</div>';
        }else if(record.fileType == "VIDEO"){
            fileId = record.headId;
            li += '<div class="swiper-slide thumb-img "  onclick="toPlayVideo('+"'"+record.id+"'"+')" title="'+record.originalFileName+'" referenceId="'+record.referenceId+'">';
            li += '<div class="img video" style="background-image:url('+BasePath+'showImage.download?uploadDownloadControllerId=common&fileId='+record.headId+');" alt="'+record.originalFileName+'" referenceId="'+record.referenceId+'"></div>';
            li += '</div>';
        }else{
            fileId = "'"+record.id+"'";
            var img= imageByType(record.ext);
            li += '<div class="swiper-slide thumb-img file "  onclick="download('+"'"+record.id+"'"+')" title="'+record.originalFileName+'" referenceId="'+record.referenceId+'">';
            li += '<div class="img" style="background-image:url('+img+');" alt="'+record.originalFileName+'" referenceId="'+record.referenceId+'"></div>';
            li += '</div>';
        }
    }
    $("#riverPatrolReportFiles").empty();
    $("#riverPatrolReportFiles").html(li);

    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 4,
        spaceBetween: 20,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    $('div.thumb-img').not('[onclick]').click(function(){
        var index = $(this).attr('tag');
        var referenceId = $(this).attr("referenceId");
        var report = riverPatrolReportMap.get(referenceId);
        createFileListShow(report,reportFiles, index);
    });
};
//视频
function toPlayVideo(fieldId){
    var path = BasePath;
    path+="jointServiceBaseMapController?toPlayVideo&videoId="+fieldId;
    window.open(path);
}
//图片
var downloader = fjzx.download.createDownloader("common");
function download(fieldId){
    downloader.download({fileId: fieldId,fileName:null});
}

/* ------------------------------------- 图片附件查看开始 ------------------------------------- */
var fileListData = null;
var activeData = null;

function createFileListShow(report,list,index){
    if(list.length==0){
        $('div.no-file-list').css('display','block');
        $('div#bodyShow').css('display','none');

        $('#riverPatrolReportFileDialog').dialog('open').dialog('center').dialog('setTitle', '随手拍');
        return;
    }else{
        $('div.no-file-list').css('display','none');
        $('div#bodyShow').css('display','block');
    }

    var activeImgIndex = index?index:0;
    showImage(report,list,activeImgIndex);
    fileListData = list;
}

/**
 * 查看图片
 * @param report
 * @param list
 * @param activeImgIndex
 */
function showImage(report,list,activeImgIndex){
    activeImgIndex = activeImgIndex?activeImgIndex:0;
    var lnglat = JSON.stringify(report).length>0?'('+report.lng+','+report.lat+')':"";
    var tableData = '<table class="picDetail-table">'+
        '<tr>'+
        '<td class="table-title">上报位置:</td>'+
        '<td class="table-show" style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="'+report.position+'">'+report.position+'</td>'+
        '<td class="table-title">经纬度:</td>'+
        '<td class="table-show" style="border-right:1px solid #dddddd;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="'+lnglat+'">'+lnglat+'</td>'+
        '</tr>'+
        '<tr>'+
        '<td class="table-title">上报人:</td>'+
        '<td class="table-show" style="border-right:1px solid #dddddd;">'+report.createByName+'</td>'+
        '<td class="table-title">上报时间:</td>'+
        '<td class="table-show" style="border-right:1px solid #dddddd;">'+Ams.timeDateFormat(report.reportTime)+'</td>'+
        '</tr>'+
        '<tr>'+
        '<td class="table-title">描述:</td>'+
        '<td class="table-show" style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;width:100%;" title="'+report.description+'">'+report.description+'</td>'+
        '</tr>'
    '</table>';
    $('div.picDetail-bottom').html(tableData);

    var allImg = [];
    for(var i=0;i<list.length;i++){
        var srcStr = '';
        var videoPath = '';
        var downloadPath = BasePath+'file.download?uploadDownloadControllerId=common&fileId='+list[i].id;
        //if("IMAGE" === list[i].fileType){
        var record = list[i];
        if (record.fileType == "bmp" || record.fileType == "png" || record.fileType == "gif" || record.fileType == "jpg" || record.fileType == "jpeg"
            || record.fileType == "BMP" || record.fileType == "PNG" || record.fileType == "JPG") {
            videoPath = '';
            srcStr = BasePath+'do.clientdownload?uploadDownloadControllerId=clientFileUpload&fileId='+list[i].id;
        }else if("VIDEO" === list[i].fileType){
            videoPath = BasePath+'jointServiceBaseMapController?toPlayVideo&videoId='+list[i].id;
            srcStr = BasePath+'showImage.download?uploadDownloadControllerId=common&fileId='+list[i].headId;
        }

        allImg.push({
            //图片地址
            src:srcStr,
            //图片类型
            type:list[i].fileType,
            //视频播放地址
            path:videoPath,
            //下载地址
            downloadPath:downloadPath}
        );
    }

    $('#riverPatrolReportFileDialog').dialog('open').dialog('center').dialog('setTitle', '随手拍');
    $.openPhotoGallery(allImg, 'div.gallerys', activeImgIndex);
}
/* ------------------------------------- 图片附件查看结束 ------------------------------------- */

/* ------------------------------------- 巡河轨迹 开始 ----------------------------------- */
/**
 * 初始化轨迹地图
 * @returns {fjzx.map.Map}
 */
function initTrackMap(){
    var defaultLongitude = parseFloat("117.65");
    var defaultLatitude = parseFloat("24.52");
    var zoom = 23;
    trackMap = new fjzx.map.Map({
        center : new fjzx.map.Point(defaultLongitude,defaultLatitude),
        zoom: zoom,
        layers : fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
        target: 'riverPatrolTrack'
    });
    //trackMap.enableScrollWheelZoom(); //启用滚轮放大缩小
    trackMap.addEventListener("click",function(){

    });
    //地图缩放控件
    var zoomSlider = new ol.control.ZoomSlider()
    trackMap.addControl(zoomSlider);

    return trackMap;
}

/**
 * 绘制轨迹
 * @param points
 */
function showTrack(points){
    trackMap.clearOverlays();
    var lushuSpeedChange = 1000;
    if(lushuSpeedChange != ""){
        lushuSpeed = lushuSpeedChange;
    }
    if(points.length<=0){
        return;
    }
    var startIcon  = new fjzx.map.Icon('/static/images/markers_start.png', new fjzx.map.Size(24, 32), {anchor: new fjzx.map.Size(15, 15)});
    var endIcon  = new fjzx.map.Icon('/static/images/markers_end.png', new fjzx.map.Size(24, 32), {anchor: new fjzx.map.Size(15, 15)});
    var startMarker = new fjzx.map.Marker(points[0], {
        icon: startIcon
    });
    var endMarker = new fjzx.map.Marker(points[points.length-1], {
        icon: endIcon
    });
    trackMap.addOverlay(startMarker); //添加LABEL
    trackMap.addOverlay(endMarker); //添加LABEL
    //trackMap.setCenterAndZoom(points[0], 23); // 初始化地图,设置中心点坐标和地图级别。

    clearInterval(handlerInterval);
    handlerInterval = setInterval(function(){
        //获取初始轨迹点
        if(currentIndex1>0){
            //起点和终点坐标
            var startPoint = points[currentIndex1-1];
            var endPoint = points[currentIndex1];
            var color = lushuColors[Math.floor(Math.random()*10)];//画线颜色
            drawPolyLine(startPoint,endPoint,color);//画线,设备画线
            //trackMap.setCenter(endPoint)
        }else{
            //初始化地图轨迹中心点，中心点为第一个轨迹点位置
            var beginPoint = points[0];
            trackMap.setCenter(beginPoint);
        }
        currentIndex1++;
        if(currentIndex1>=points.length){
            currentIndex1=0;
            clearInterval(handlerInterval);
        }
    },lushuSpeed);
}

/**
 * 两点之间画线
 * @param startPoint
 * @param endPoint
 * @param color
 */
function drawPolyLine(startPoint,endPoint,color){
    var iconMap  = new fjzx.map.Icon('/static/images/markers_user.png', new fjzx.map.Size(24, 32), {anchor: new fjzx.map.Size(15, 15)});
    if (markerObject != null) {
        trackMap.removeOverlay(markerObject);//移除原来的坐标
    }
    var marker = null;
    marker = new fjzx.map.Marker(endPoint, {
        icon: iconMap
    });
    markerObject=marker;
    trackMap.addOverlay(marker); //添加LABEL
    var polyline = new fjzx.map.Polyline([
            startPoint,//起始点的经纬度
            endPoint //终止点的经纬度
        ], {
            strokeColor : color,//设置颜色
            strokeWeight : 5, //宽度
            strokeOpacity : 1//透明度
        }
    );
    //如果开启了视野调整,则设置地图中心坐标点为轨迹终止点
    if(autoView){
        trackMap.setCenter(endPoint);
    }
    trackMap.addOverlay(polyline);
}

/*-----------------------------------巡河轨迹 结束--------------------------------------------*/

/**
 * 根据附件类型获取相应默认缩略图
 * @param type
 * @returns {string}
 */
function imageByType(type){
    var img;
    if(type =="txt"){
        img = "/static/images/file_type_txt.png"
    }else if(type =="doc" || type == "docx"){
        img = "/static/images/file_type_doc.png"
    }else if(type =="xls" || type == "xlsx"){
        img = "/static/images/file_type_xls.png"
    }else if(type =="rar" || type == "zip" || type == "rars"){
        img = "/static/images/file_type_rar.png"
    }else if(type =="ppt" || type == "pptx"){
        img = "/static/images/file_type_ppt.png"
    }else if(type =="mp4"||type =="AVI"||type =="WAV"){
        img = "/static/images/file_type_video.png"
    }
    else{
        img = "/static/images/file_type_txt.png"
    }
    return img;
}
