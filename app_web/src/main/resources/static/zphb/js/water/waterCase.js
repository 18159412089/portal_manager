"use strict";

//线上环境需要改成正式环境
var BasePath = "https://140.237.73.123:9041/EpaProblemProcessing/";
//var BasePath = "https://localhost:8080/EpaProblemProcessing/";

var caseMonitors = new Array();
var waterCaseFiles = new Array();

//判断并设置列表高度
function isExitDom() {
    setTimeout(function () {
        var winHeight = $(window).height();
        var $tuceng = $('div.map-panel-body');
        var top = $tuceng.offset().top;
        var divHeight = winHeight - top - 130;

        var len = $('ul.tabs-panel li.tabs-item a[data-target="#mapTabs_gridCase"].active').length;
        if (len >= 1) {
            $tuceng.css('height', divHeight);
        } else {
            $tuceng.css('height', '550px');
        }

        var gridCaseHeight = divHeight - ($tuceng.children(":first").height());
        var panel = gridCaseHeight - 50;
        $('div#mapTabs_gridCase div.theme-content div.datagrid-wrap.panel-body.panel-body-noheader').height(panel);
        var titleHeight = $('div#gridCaseToolbar').outerHeight(true);
        var tableDivHeight = panel - titleHeight - 76;
        $('div#gridCaseToolbar').next().height(tableDivHeight);
        var $view2 = $('div#gridCaseToolbar').next().find('table#gridCaseDg').prev();
        $view2.find('div.datagrid-body').height(tableDivHeight - ($view2.find('div.datagrid-header').outerHeight(true)));
    }, 20);
}

//图层点击事件
$('div.change-line.no-choice').click(function () {
    isExitDom();
});

//便签条点击事件
$('ul.tabs-panel').on('click', 'li.tabs-item a', function () {
    isExitDom();
});

//数据填充
function fillData(table, info) {
    $(table).find('div[id]').each(function () {
        var key = $(this).attr('id');
        $(this).text(info[key]);
    });
}

//获取附件并弹窗显示
function getFilesAndShow(caseId) {
    $.ajax({
        type: "POST",
        url: "/zphb/enviromonit/water/nationalSurfaceWater/getCaseFiles",
        async: true,
        dataType: 'json',
        data: {caseId: caseId},
        success: function (data) {
            var filesStr = '';
            if (data.message == "success") {
                var list = data.list;
                waterCaseFiles = list;
                for (var i = 0; i < list.length; i++) {
                    var record = list[i];
                    var fileId = record.id;
                    var temp = '';
                    if (record.fileType == "IMAGE") {
                        temp = '<div tag="' + i + '" title="' + record.originalFileName + '" class="thumb-img"><img src="' + BasePath + 'showImage.download?uploadDownloadControllerId=common&fileId=' + fileId + '"></div>';
                    } else if (record.fileType == "VIDEO") {
                        fileId = record.headId;
                        temp = '<div title="' + record.originalFileName + '" onclick="toPlayVideo(' + "'" + record.id + "'" + ')" class="thumb-img"><img src="' + BasePath + 'showImage.download?uploadDownloadControllerId=common&fileId=' + fileId + '"><img class="video-img" src="/static/images/icon_play.png"></div>';
                    } else {
                        temp = '<div title="' + record.originalFileName + '" onclick="download(' + "'" + record.id + "'" + ')" class="thumb-img"><img src="/static/images/file-documents.png"></div>';
                    }
                    filesStr += temp;
                }
            } else {
                waterCaseFiles = new Array();
            }
            $('div#waterCaseFiles').html(filesStr);
        },
        error: function () {}
    });
    $('#gridCaseDlg').dialog('open').dialog('center').dialog('setTitle', '事件详情');
}

//地图添加点位
function addCaseClickEvent(markerName, info) {
    //marker点击事件
    markerName.addClick(function () {
        //填充数据
        fillData($('#gridCaseDlg table'), info);
        //获取附件
        getFilesAndShow(info.id);
    });
}

$('div#waterCaseFiles').on('click', 'div.thumb-img:not([onclick])', function () {
    var index = $(this).attr('tag');
    $('div.no-file-list').css('display', 'none');
    $('div#bodyShow').css('display', 'block');

    var list = waterCaseFiles;
    var allImg = [];
    for (var i = 0; i < list.length; i++) {
        var srcStr = '';
        var videoPath = '';
        var downloadPath = BasePath + 'file.download?uploadDownloadControllerId=common&fileId=' + list[i].id;
        if("IMAGE" === list[i].fileType) {
            videoPath = '';
            srcStr = BasePath + 'do.clientdownload?uploadDownloadControllerId=clientFileUpload&fileId=' + list[i].id;
        }else if("VIDEO" === list[i].fileType) {
            videoPath = BasePath + 'jointServiceBaseMapController?toPlayVideo&videoId=' + list[i].id;
            srcStr = BasePath + 'showImage.download?uploadDownloadControllerId=common&fileId=' + list[i].headId;
        }else{
            videoPath = '';
            srcStr = '/static/images/file-documents.png';
        }

        allImg.push({
            //图片地址
            src: srcStr,
            //图片类型
            type: list[i].fileType,
            //视频播放地址
            path: videoPath,
            //下载地址
            downloadPath: downloadPath
        });
    }

    $('#riverPatrolReportFileDialog').dialog('open').dialog('center').dialog('setTitle', '附件');
    $('div.gallerys').css('height', '100%');
    $.openPhotoGallery(allImg, 'div.gallerys', index);
});

//获取事件列表数据并显示地图点位
function getWaterCaseList(pageSize, pageNumber) {
    clearOverlay();
    var des = $('div#gridCaseToolbar input#describe').val();
    var startTime = $('div#gridCaseToolbar input#startTime').val();
    var endTime = $('div#gridCaseToolbar input#endTime').val();
    pageSize = (pageSize)?pageSize:10;
    pageNumber = (pageNumber)?(pageNumber-1):0;

    $.ajax({
        type: "POST",
        url: "/zphb/enviromonit/water/nationalSurfaceWater/getWaterCaseList",
        async: true,
        dataType: 'json',
        data: {
            des: des,
            startTime: startTime,
            endTime: endTime,
            rows: pageSize,
            page: pageNumber
        },
        success: function (result) {
            $("#gridCaseDg").datagrid("loadData", {total: result.maxSize, rows: result.data});
            var pager = $('#gridCaseDg').datagrid('getPager');
            pager.pagination({
                pageList: [10,20,30,50],
                layout:['list','first','prev','manual','next','last'],
                onSelectPage:function(pNumber, pSize){
                    getWaterCaseList(pSize, pNumber);
                },
                onChangePageSize:function(pSize){
                    //此处不处理，会自动调用onSelectPage回调
                }
            });
            setTimeout(function(){
                //麻烦的高度计算，省事一点就让前端去调
                var all = $('#mapTabs_gridCase div.theme-content').height();
                var toolbar = $('#mapTabs_gridCase #gridCaseToolbar').outerHeight(true);
                var pagination = $('#mapTabs_gridCase div.datagrid-pager.pagination').outerHeight(true);
                $('#mapTabs_gridCase #gridCaseToolbar').next().height(all-toolbar-pagination);
                $('#mapTabs_gridCase div.datagrid-body').height(all-toolbar-pagination-40);
            }, 70);

            //添加地图overlay
            var dataList = result.data;
            for (var i = 0; i < dataList.length; i++) {
                var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(dataList[i].longitude, dataList[i].latitude), {
                    icon: water_case_icon,
                    map: map,
                    title: dataList[i].describe
                });
                caseMonitors[i] = tempMarker;
                map.addOverlay(tempMarker);
                addCaseClickEvent(tempMarker, dataList[i]);
            }
        },
        error: function (error) {}
    });
}

//删除地图上的覆盖点
function clearOverlay() {
    for (var i=0;i<caseMonitors.length;i++) {
        map.removeOverlay(caseMonitors[i]);
    }
    caseMonitors = new Array();
}

//列表中的单击事件
$("#gridCaseDg").datagrid({
    onClickRow: function(index, row){
        fillData($('#gridCaseDlg table'), row);
        map.setCenter(new fjzx.map.Point(row.longitude, row.latitude));
        setTimeout(function(){
            getFilesAndShow(row.id);
        }, 500);
    }
});

//图层点击事件
function getWaterCase() {
    if ($("#gridCase").hasClass('choiced')) {
        $('div#mapTabs_gridCase #gridCaseToolbar input[id]').val('');
        clearOverlay();
    } else {
        getWaterCaseList();
    }
}
