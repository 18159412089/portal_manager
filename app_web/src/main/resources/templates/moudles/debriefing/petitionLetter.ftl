<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>信访件边督边改</title>
    <link rel="stylesheet" href="${request.contextPath}/static/css/mainMap.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/water/basin.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
    <!-- Custom -->
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <!-- ol end -->

    <!-- 地图相关 -->
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
    <script src="${request.contextPath}/static/js/epaConsole.js"></script>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"></link>

    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/photoswipe.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/default-skin/default-skin.min.css" rel="stylesheet">

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<script src="${request.contextPath}/static/js/swiper.min.js"></script>-->

<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>

<style type="text/css">
	/* 底图控制器 */
    #mapDiv .basemap-toggle {
        position: absolute;
        z-index: 9;
    }
    .layui-layer-iframe{
        z-index: 999!important;
    }

    /* 底图控制项 */
    #mapDiv .basemap-toggle > .basemap {
        position: absolute;
        background-color: #fff;
        border: 1px solid #f0f0f0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        -webkit-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        -moz-box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        box-shadow: 0 2px 2px rgba(0, 0, 0, 0.75);
        text-align: center;
        cursor: pointer;
        margin: 0;
        padding: 0;
        font-weight: bold;
        -moz-opacity: 0.9;
        opacity: 0.9;
        -moz-user-select: none;
        -ms-user-select: none;
        -webkit-user-select: none;
        user-select: none;
    }

    #mapDiv .basemap-toggle > .basemap:hover {
        background-color: #d0d0d0;
    }

    #mapDiv .basemap-toggle > .basemap > img {
        border: 0;
        outline: 0;
        display: block;
    }

    #mapDiv .basemap-toggle > .basemap > span {
        font-size: 10px;
        display: block;
    }

    /* 底图控制项（选中时） */
    #mapDiv .basemap-toggle > .basemap[selected],
    #mapDiv .basemap-toggle > .basemap[selected]:hover {
        background-color: #fff;
        display: block;
    }
</style>
    
<div class="container oh"
     style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px;">
    <!-- main -->
    <input type="hidden" id="authority" value="${authority!}">
    <div id="mapDiv" class="map-wrapper" style="position: fixed; bottom: 0;">
        <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -170px;">
            <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                 layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-1.png" alt="">
            </div>
            <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                 layer-group-name="FJ_IMG_MAP" title="影像图层">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-2.png" alt="">
            </div>
        </div>
    </div>
    <!-- 地图层 -->

    <!-- 图例  -->
    <div class="map-legend-container "
         style="z-index: 998; position: absolute; bottom: 0px; left: 0px;">
        <div class="grade-legend">
            <div class="legend" style="width: 200px; color: #fff">
                 <img src="/static/images/envRectifitionOver.png" style="width:22px;vertical-align: middle;" >已完成&nbsp;&nbsp;&nbsp;&nbsp;<img src="/static/images/envRectifitionUnOver.png" style="width:22px;vertical-align: middle;">未完成
            </div>
        </div>
    </div>

    <div class="map-panel"
         style="z-index: 998; position: absolute; top: 86px; right: 58px;display:none">
        <div class="map-panel-header">
                <span class="title"> <span
                            class="icon iconcustom icon-zhedie3"></span> 图层控制
                </span>
        </div>
    </div>

    //右侧边栏
    <div class="map-panel" style="position:absolute;top:86px;right:58px;">
        <div class="map-panel-header">
			<span class="title">
				 <span class="icon iconcustom icon-zhedie3"></span>
				图层控制
			</span>
        </div>
        <div class="map-panel-body" style="height:500px;width:440px;position: relative;background: none;">
            <div class="body-box" id="filterBox"
                 style="width:320px;height:100px;margin-left:120px; border-bottom: 1px solid #fff;border-color: rgba(255,255,255,0.15);">
                <div class="filter-container" style="margin-bottom: 12px;">
                    <div class="filter-box">
                        <div class="filter-title">按期数</div>
                        <div class="filter-content" id="roundId">
                            <div class="change-line no-choice" title="全部" id="all">全部</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tabs-content" style="width:320px;margin-left:120px;top:86px">
                <div class="body-box" id="mapTabs_tabs1">
                    <div class="theme-container">
                        <div class="theme-title" >筛选 <a id="infoSet" class="title-link-tag"
                                                       target="_blank">点位信息配置<span class="icon iconcustom"></span></a>
                        </div>
                        <div class="theme-content">
                            <div class="search-container search-border" id="search">
                                <div class="select-box" style="margin-bottom:10px">
                                    <select name="enable" id="statusId" class="easyui-combobox alone-combobox" data-placement="全部"
                                            label="状态:" style="width:290px;margin-right: 0px!important;">
                                        <option value="0">全部</option>
                                        <option value="1">已完成</option>
                                        <option value="2">未完成</option>
                                    </select>
                                </div>
                                <div class="search-box">
                                    <input id="projname" class="easyui-textbox" prompt="请输入项目名称或者备注模糊搜索"
                                           style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="dg" class="easyui-datagrid"
                                       style="width: 100%;height:365px;" toolbar="#search"
                                       data-options="
                                rownumbers:false,
                                singleSelect:true,
                                striped:false,
                                autoRowHeight:false,
                                pagination:true,
                                pageSize:10,
                                nowrap:false">
                                    <thead>
                                    <tr>
                                        <th field="projname" width="50%" formatter="Ams.tooltipFormat">项目名称</th>
                                        <th field="remark" width="25%" formatter="Ams.tooltipFormat">备注</th>
                                        <th field="status" width="25%" formatter="formatterStatus">状态</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_tabs2" style="display: none;">
                    dlfgdflg id="map-tabs2"
                </div>
                <div class="body-box" id="mapTabs_all" style="display: none;">
                    全部 id="map-tabs1"
                </div>
            </div>
            <ul class="tabs-panel" style="top:220px;margin-right: -120px;">
            </ul>
        </div>
    </div>


</div>

<div id="monitorDlg" class="easyui-dialog" style="width:800px;background:#ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
            <div title="详情" selected="true">
                <div class="panel-group-container">
                    <div class="panel-group-top"><span id="projectName"></span>
                    </div>
                    <div class="panel-group-body">
                        <div class="panel-info">
                            <p style='font-size: 14px;' id="projectInfo"></p>
                        </div>
                        <div class="bnt-part">
                            <a class="l-btn btn-primary" href="" id="pdfBtn" target='_blank'>整改前后对比</a>
                            <a class="l-btn btn-primary" href="" id="videoBtn">整改视频</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 附件弹窗-->
<div id="riverPatrolReportFileDialog" class="easyui-dialog"
     style="width: 800px; height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <div class="modal-body" style="height:600px;max-height:none;">
        <div class="no-file-list">没有附件</div>
        <div id="bodyShow">
            <div class="gallerys" style="height:78%;"></div>
            <div class="picDetail-bottom"></div>
        </div>
    </div>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width: 800px; height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd: auto; height: 99%;"
           controls="controls" preload>您的浏览器不支持 video 标签。
    </video>
</div>

</div>

<script src="https://cdn.bootcss.com/photoswipe/4.1.3/photoswipe.min.js"></script>
<script src="https://cdn.bootcss.com/photoswipe/4.1.3/photoswipe-ui-default.min.js"></script>

<script>
    //获取到相册的dom
    var pswpElement = document.querySelectorAll('.pswp')[0];
    //图片数组
    var items = [];

    //这是点击图片后触发的事件， 需要传递一个参数:打开相册后播放的第一张图在数组中的索引
    function onPlay(index) {
        var options = {
            index: index // 当前播放的图片索引
        };
        //创建相册对象
        var gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, items, options);
        //相册初始化，这句执行完之后相册就打开了。
        gallery.init();

    }
</script>

<!-- 修改用户密码窗口 -->
<#include "/passwordModify.ftl"/>

<!-- <script type="text/javascript" src="http://api.tianditu.gov.cn/api?v=4.0&tk=7ca2bb2feccc647effa30f35238a1fe3"></script> -->
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<!-- 巡河相关js -->
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-ext.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-webservice.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-download.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/photoGallery/jquery.photo.gallery.js"></script>

<script>

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            //$('#infoSet').attr("href", "/enviromonit/distributeMap/distributeMapInfo?pid=" + $("#pid").val() + "&authority=1");
            doSearch();
        });
    };
    var mapPoint = new Array(); // 流域站点数组
    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });

    function doSearch() {
        /* $('#dg').datagrid({
            url: "/enviromonit/distributeMap/getListPage",
            queryParams: {
                projectName: $("#projname").val(),
                num: num.join(","),
                statusName:statusName

            }
        }) */
    }

    Ams.inputText_enterKeyEvent('projname', doSearch);

    var envRectifition_icon = new fjzx.map.Icon("/static/images/envRectifitionOver.png", {
        size: new fjzx.map.Size(25, 25),
        imgSize: new fjzx.map.Size(25, 25),
        anchor: new fjzx.map.Point(12, 25)
    });
    var envRectifition2_icon = new fjzx.map.Icon("/static/images/envRectifitionUnOver.png", {
        size: new fjzx.map.Size(25, 25),
        imgSize: new fjzx.map.Size(25, 25),
        anchor: new fjzx.map.Point(12, 25)
    });

    var remark = '';
    var num = new Array();
    var statusName = '';
    $(function () {
        $('#statusId').combobox({
            onSelect:function(record){
                statusName = record.value;
                doSearch();
                trace();
            }
        });
        var authority=$("#authority").val();
        if(authority=='1'){
            $("#infoSet").hide();
        }
        var map = null;
        var longitude = "117.65";
        var latitude = "24.52";
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
            zoom: 12
        });
        map.render();
      //--------------------切换卫星图层开始------------------//
        var separation = 8;// 子组件展开时的间距。
        var size = 60;
        $('div.basemap-toggle').on({
            mouseenter: function (e) {
                expand(e);
            },
            mouseleave: function (e) {
                collapse(e);
            }
        });
        $('div.basemap-toggle').find('.basemap').click(function(){
            // 已经选中则返回。
            if (!!$(this).attr("selected")) {
                return;
            }
            var layerGroupName = $(this).attr("layer-group-name");
            $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index',0);

            // 标记选中状态。
            $(this).attr("selected", "selected");
            //$(this).css("z-index", 10000);
            $(this).animate({
                top: 0
            }, 200);
            collapse(0);
            // 显示当前底图。
            map.getLayers().forEach(function(layer,i){
                if(layer instanceof ol.layer.Group){
                    layer.getLayers().forEach(function(sublayer,j){
                        map.removeLayer(sublayer);
                    });
                }
            });
            var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
            console.log(layerGroup);
            console.log($(this));
            map.setLayerGroup(layerGroup);
        });

        function expand() {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            // 如果已经展开，则返回。
            if (!!$domNode.attr("expand")) {
                return;
            }
            // 标记展开状态。
            $domNode.attr("expand", "expand");
            // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
            $domNode.css("height", (size + separation) * baseMaps.length + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行展开并显示。
                console.log(!$(baseMaps[i]).attr("selected"));
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).css("display", "block");
                    $(baseMaps[i]).animate({
                        top: "+=" + (size + separation) * count
                    }, 300, function (count) {
                        $(this).css("display", "block");
                        $(this).css("top", (size + separation) * count + "px");
                    });
                }
            }
        }

        function collapse(time) {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            if (Object.prototype.toString.call(time) !== "[object Number]") {
                time = 200;
            }
            // 如果没有展开，则返回。
            if (!$domNode.attr("expand")) {
                return false;
            }
            // 移出展开状态标记。
            $domNode.removeAttr("expand");
            $domNode.css("height", size + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行收起并隐藏。
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).animate({
                        top: "-=0"
                    }, time, function () {
                        $(this).css("display", "none");
                        $(this).css("top", 0);
                    });
                }
            }
        }
      //--------------------切换卫星图层结束------------------//
      
        var loadIndex = '';
        //getEnvironmentProjectRoundInfo();
        trace();
    });

    //--------------------初始化地图对象-------------------------//


    /**
     * 描点
     */
    function trace() {
        /* clearMapPoint();
        $.ajax({
            type: 'POST',
            url: '/enviromonit/distributeMap',
            data: {num: num.join(","),statusName:statusName},
            async: true,
            beforeSend: function () {
                loadIndex = layer.load(1, {
                    shade: [0.1, '#fff']
                });
            },
            complete: function () {
                layer.close(loadIndex);
            },
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    if (Ams.isNoEmpty(data[i].remark)) {
                        remark = '(' + data[i].remark + ')';
                    }
                    var tempMarker;
                    if (data[i].status == "SENDACCOUNT") {
                        tempMarker = new fjzx.map.Marker(new fjzx.map.Point(data[i].longitude, data[i].latitude), {
                            icon: envRectifition_icon,
                            map: map,
                            title: data[i].projname + remark
                        });
                    } else {
                        tempMarker = new fjzx.map.Marker(new fjzx.map.Point(data[i].longitude, data[i].latitude), {
                            icon: envRectifition2_icon,
                            map: map,
                            title: data[i].projname + remark
                        });
                    }
                    mapPoint.push(tempMarker);
                    map.addOverlay(tempMarker);
                    addClickEvent(tempMarker, data[i]);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            },
            dataType: 'json'
        }); */
    }

    function addMouseMoveEvent(content, markerName) {
        var markerInfoWin = "";
        markerName.addEventListener("mouseover", function (e) {
            var point = e.lnglat;
            markerInfoWin = new T.InfoWindow(content, {
                offset: new T.Point(0, -30)
            });
            map.openInfoWindow(markerInfoWin, point); // 开启信息窗口
        });
        markerName.addEventListener("mouseout", function (e) {
            map.removeOverLay(markerInfoWin); // 开启信息窗口
        });
    }

    function addClickEvent(markerName, info) {
        markerName.addClick(function (e) {
            showDetail(info);
        });
    }

    //自适应 添加scroll下拉
    $("#filterBox,#monitorListScroll,#outfallPltCodeListScroll,#outfallListScroll").mCustomScrollbar({
        theme: "light-3",
        scrollButtons: {
            enable: true
        }
    });


    /**
     * 展示详情
     */
    function showDetail(info) {
        remark = '';
        var status="未完成";
        if (Ams.isNoEmpty(info.remark)) {
            remark = '(' + info.remark + ')';
        }
        if(info.status == "SENDACCOUNT"){
            status="已完成 "
        }
        document.getElementById('projectName').innerHTML = info.projname + remark+"--"+status;
        document.getElementById('projectInfo').innerHTML = info.disgribe;
        if (info.video == null || info.video == undefined) {
            $("#videoBtn").hide();
        } else {
            $("#videoBtn").show();
            $('#videoBtn').attr("href", "javascript:play('" + info.video + "')");
        }

        if (info.picture == null || info.picture == undefined) {
            $("#pdfBtn").hide();
        } else {
            $("#pdfBtn").show();
            $('#pdfBtn').attr("href", Ams.ctxPath + '/environment/waterAttachment/download/' + info.picture + '/2');
        }
        $('#monitorDlg').dialog('open').dialog('center').dialog('setTitle', '整改进展');
    }

    /**
     * 视频播放
     */
    function play(mongoid) {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
    }


    $(".map-panel-header").on("click", function () {
        var $target = $(this).parent();
        if ($target.hasClass("collapsed")) {
            $target.removeClass("collapsed");
            WaterPollutionBar.resize();
            WatertypeBar.resize();
            WaterIndexBar.resize();
        } else {
            $target.addClass("collapsed");
        }
    });

    /*对比*/
    $('body').on('click', '.btnSure', function () {
        $(this).parents(".select-panel").removeClass('show');
    });
    $('body').on('click', '.select-button', function () {
        $(this).next().addClass('show');
    });
    /*tabs*/
    $('.tabs-panel').on('click', '.tabs-inner', function () {
        $(this).parents(".tabs-panel").find(".tabs-inner").removeClass('active');
        $(this).addClass('active');
        var target = $(this).attr("data-target");
        $(target).show();
        $(target).siblings(".body-box").hide();
    });
    /*筛选与tabs的联动*/
    $('.filter-content').on('click', '.no-choice', function () {
        var cl_n = $(this);
        var subtitle = $(this).attr("title");
        var tid = $(this).attr("id");

        if (cl_n.hasClass('choiced')) {
            cl_n.removeClass('choiced');
//            tabClose(tid);
        } else {
            cl_n.addClass('choiced');
//            addTab(subtitle, tid);
        }
//       console.log( cl_n.parent().find(".change-line").length)

        var nub = cl_n.parent().find(".change-line").length;
        num = [];
        for (var i = 0; i < nub; i++) {
            if (cl_n.parent().find(".change-line").eq(i).is(".choiced")) {
                num.push(cl_n.parent().find(".change-line").eq(i).attr("id"))
            }
        }
        doSearch();
        trace();
    });


    /*tabs*/
    function addTab(subtitle, id) {
        var $targetTabs = $(".tabs-panel");
        var $targetContent = $targetTabs.siblings(".tabs-content");

        if (!hasTabs(subtitle)) {
            var tabsId = '#mapTabs_' + id;
            var tabsHTML = '<li class="tabs-item">\
					<a class="tabs-inner active" data-target="#mapTabs_' + id + '">' + subtitle + '</a>\
				</li>';

            if (!id) {
                id = "un";
                var tabsContentHTML = '<div class="body-box" id="mapTabs_undefined"></div>';

            }

            $targetTabs.find(".tabs-inner").removeClass('active');
            $targetContent.find(".body-box").hide();
            $targetTabs.append(tabsHTML);
            $targetContent.append(tabsContentHTML);
            $(tabsId).show();
            console.log(id);
        }
    }

    function tabClose(id) {
        var $targetTabs = $(".tabs-panel");
        var $targetContent = $targetTabs.siblings(".map-panel-body");
        var tabsId = '#mapTabs_' + id;
        $("[data-target='" + tabsId + "']").remove();
        $(tabsId).hide();
        selectTab($targetTabs.find(".tabs-inner").length - 1);
    }

    function selectTab(index) {
        var $targetTabs = $(".tabs-panel");
        $targetTabs.find(".tabs-inner").eq(index).trigger("click");
    }

    function hasTabs(title) {
        $(".tabs-panel").find(".tabs-inner").each(function () {
            if ($(this).text() === title) {
                return true;
            }
        });
    }

    /*tabs over*/
    function getEnvironmentProjectRoundInfo() {//获取环保督察项目轮数信息
        $.ajax({
            url: Ams.ctxPath + '/enviromonit/distributeMap/getRoundList',
            data: {},
            type: 'POST',
            success: function (result) {
                var newRow = "";
                for (var i = 0; i < result.length; i++) {
                    if (!Ams.isNoEmpty(result[i].num)) {
                        continue;
                    }
                    newRow += '<div class="change-line no-choice" title="第' + result[i].num + '轮" id="' + result[i].num + '">第' + result[i].num + '轮</div> ';
                }
                $("#roundId").html(newRow);
            },
            dataType: 'json'
        });
    }

    /**
     * 双击 单击地图定位
     */
    $('#dg').datagrid({
        onClickRow: function (index, data) {
            map.setCenter(new fjzx.map.Point(data.longitude, data.latitude));
        }, onDblClickRow: function (index, row) {
            map.setCenter(new fjzx.map.Point(row.longitude, row.latitude));
            showDetail(row);
        }
    });

    /**
     * 清除点位
     */
    function clearMapPoint() {
        for (var i = 0; i < mapPoint.length; i++) {
            map.removeOverlay(mapPoint[i]);
        }
    }

    function formatterStatus(value,row,index){
        if(value== "SENDACCOUNT"){
            return "<span style='color:green'>已完成</span>"
        }else{
            return "<span style='color:red'>未完成</span>"
        }
    }

</script>

</body>
</html>