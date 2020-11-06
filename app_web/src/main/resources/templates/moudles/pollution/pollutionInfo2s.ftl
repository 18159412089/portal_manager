<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染源大地图</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <#include "/secondToolbar2.ftl">
    <#include "/passwordModify.ftl">
    <#include "/common/loadingDiv.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"></link>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
    <!-- Custom -->
    <!-- ol end -->
    <!-- 地图相关 -->
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
    <script src="${request.contextPath}/static/js/epaConsole.js"></script>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <style type="text/css">
        /* 底图控制器 */
        #mapDiv .basemap-toggle {
            position: absolute;
            z-index: 9;
        }

        .layui-layer-iframe {
            z-index: 999 !important;
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
</head>
<!-- body -->
<body class="pollution-body  alone-pollution">

<div class="map-container">
    <div id="mapDiv" class="map-wrapper">
        <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -200px;">
            <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                 layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;"
                     src="${request.contextPath}/static/fjzx-map/img/basemap-1.png" alt="">
            </div>
            <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                 layer-group-name="FJ_IMG_MAP" title="影像图层">
                <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;"
                     src="${request.contextPath}/static/fjzx-map/img/basemap-2.png" alt="">
            </div>
        </div>
        <#--新增还原按钮-->
        <div class="map-reduction-box" style="z-index: 106">
            <span> <i class="icon iconcustom icon-shuaxin1"></i>还原</span>
        </div>
    </div><!-- 地图层  -->
    <!--案件列表-->
    <div class="map-caselist-container show  map-contaminated-part">
        <div class="btn-collapse active" data-toggle="shown" data-target=".map-caselist-container">
            <span class="icon fa-angle-left"></span>
        </div>
        <div class="map-case-list-box">
            <div class="map-case-list ">
                <div class="map-contaminated-title">
                    <#--                    <h3><span class="icon iconcustom icon-leibie5"></span> 图层控制</h3>-->
                    <p id="dateTime">截止2019年9月9日排查</p>
                </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul">
                        <#include "/moudles/pollution/analysisDiv.ftl">
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>水环境污染源</span>
                                <i id="countPollution"></i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content" id="pollutionData">
                                                <div class="change-line no-choice  choiced" id="wsclc">
                                                    <span><img src="${request.contextPath}/static/images/ssgyqy-icon.png"></span>
                                                    涉水工业企业(30aler)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>水质自动站</span>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice2 choiced2" id="gkdm">
                                                    <span><img src="/static/images/water.png"></span>
                                                    国控断面(123)
                                                </div>
                                                <div class="change-line no-choice2" id="miniMonitor"
                                                     onclick="getMiniMonitor()">
                                                    <span><img src="/static/images/water/water_mini_monitor.png"></span>
                                                    微型水质自动站(30)
                                                </div>

                                                <div class="change-line no-choice2" style="margin-top:10px">
                                                    <span><img src="/static/images/min-basin.png"></span>
                                                    小流域河流
                                                </div>
                                                                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                                
                        </li>
                    </ul>
                    <#include "/moudles/pollution/searchDiv.ftl">
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
    </div>
</div>

<#include "/moudles/pollution/pollutionDetail.ftl">
<!--  站点信息   -->
<#include "/moudles/enviromonit/water/monitorPointAnalysis.ftl"/>
</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\pollutionInfo2_new.js"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\enviromonit\water\policy.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/js/moudles/enviromonit/water/monitorPointAnalysis.js"></script>
</html>
<script>
    var miniMonitors = new Array();
    var miniMonitorData = new Array();

    function getMiniMonitor() {
        if ($("#miniMonitor").hasClass('choiced2')) {
            $("#miniMonitor").removeClass('choiced2');
            $("#pointNameQuery").textbox('setValue', '');
            for (var i = 0; i < miniMonitors.length; i++) {
                map.removeOverlay(miniMonitors[i]);
            }
            miniMonitors = new Array();
        } else {
            $("#miniMonitor").addClass('choiced2');

            $.ajax({
                type: "post",
                url: "/enviromonit/water/nationalSurfaceWater/listNoPage",
                async: true,
                data: {polluteCode: $("span.ant-radio-button-checked input").val(), category: "3"},
                //data : {polluteCode :  $(".point-group .select-point").attr("value"), category:"3"},
                success: function (result) {
                    var data = result.data;
                    $("#minitorNum").text(data.length);
                    $("#miniMonitor").html(' <span><img src="/static/images/water/water_mini_monitor.png"></span>微型水质自动站(' + data.length + ')');
                    for (var i = 0; i < data.length; i++) {
                        var icon = icon6;
                        var color = "#b8b8b8";
                        if (data[i].quality == "Ⅰ" || data[i].quality == "Ⅱ") {
                            icon = icon1;
                            color = "#2ba4e9";
                        } else if (data[i].quality == "Ⅲ") {
                            icon = icon2;
                            color = "#45b97c";
                        } else if (data[i].quality == "Ⅳ") {
                            icon = icon3;
                            color = "#FFFF00";
                        } else if (data[i].quality == "Ⅴ") {
                            icon = icon4;
                            color = "#f47920";
                        } else if (data[i].quality == "劣Ⅴ") {
                            icon = icon5;
                            color = "#d02032";
                        }

                        var clickDiv = null;
                        clickDiv = "<div style='width: 120px;text-align: center'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                            + "<div id='monitor_" + data[i].mn + "' style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;"
                            + "background-color:" + color + "' onclick='openPointDlg(JSON.stringify(miniMonitorData[" + i + "]))'>" + data[i].value + "</div>"
                            + "</div><p style='font-weight:bold;'>" + data[i].mnname + "</p></div>";
                        //创建pint
                        var point = new fjzx.map.Point(data[i].lng, data[i].lat);
                        //创建地图marker点
                        var myMarker = new fjzx.map.Marker(point, {
                            markerHtml: clickDiv,
                            map: map,
                            isShowIcon: false,
                            title: data[i].mnname,
                            id: data[i].mn
                        });
                        miniMonitors.push(myMarker);
                        map.addOverlay(myMarker);
                        if (miniMonitorData.length != data.length) {
                            miniMonitorData.push(data[i]);
                        }
                    }

                },
                error: function () {
                },
                dataType: 'json'
            });
        }
    };
    var pointsData = new Array(); //站点数组
    function openPointDlg(info) {
        info = JSON.parse(info);
        selectedPointInfo = info;
        searchWaterPointBar();
        addOtherPoints();
        getMnPointInfo(info);
        addMoreData();
        getWaterMonitorAttachement(info.mn);
        $('#monitorDlg').dialog('open').dialog('center').dialog('setTitle',
            '断面详情与分析');
        $("#tt").tabs('select', "详情");
        //getFactorCount();
        //}
    }

    $(function () {
        // getMiniMonitor();
        // loadRiverNum();
        loadRiver();

    })
    ///////////=================================引入js

    //创建图片对象
    //---------------国家站点图标----------//

    var icon1 = new fjzx.map.Icon(
        "/static/images/water_lv1.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );

    var icon2 = new fjzx.map.Icon(
        "/static/images/water_lv2.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );

    var icon3 = new fjzx.map.Icon(
        "/static/images/water_lv3.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );

    var icon4 = new fjzx.map.Icon( //Ⅴ
        "/static/images/water_lv4.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );

    var icon5 = new fjzx.map.Icon( //劣Ⅴ
        "/static/images/water_lv5.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );
    var icon6 = new fjzx.map.Icon( //未知
        "/static/images/water_lv6.png",
        {
            size: new fjzx.map.Size(30, 30),
            imgSize: new fjzx.map.Size(30, 30),
            anchor: new fjzx.map.Point(0, 30)
        }
    );

    //---------------省站点图标---------------//

    var icon21 = new fjzx.map.Icon( // Ⅰ类和Ⅱ类质量图标
        "/static/images/water_lv1.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var icon22 = new fjzx.map.Icon(//Ⅲ
        "/static/images/water_lv2.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var icon23 = new fjzx.map.Icon( //Ⅳ
        "/static/images/water_lv3.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var icon24 = new fjzx.map.Icon(//Ⅴ
        "/static/images/water_lv4.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var icon25 = new fjzx.map.Icon( //劣Ⅴ
        "/static/images/water_lv5.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var icon26 = new fjzx.map.Icon( //未知
        "/static/images/water_lv6.png",
        {
            size: new fjzx.map.Size(20, 20),
            imgSize: new fjzx.map.Size(20, 20),
            anchor: new fjzx.map.Point(10, 20)
        }
    );

    var outfall_icon = new fjzx.map.Icon( //排口
        "/static/images/water_outfall.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );
    var outfall2_icon = new fjzx.map.Icon( //排口
        "/static/images/water_outfall2.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );

    var sewagePlant_icon = new fjzx.map.Icon( //排口
        "/static/images/water_sewagePlant.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );
    var sewagePlant2_icon = new fjzx.map.Icon( //排口
        "/static/images/water_sewagePlant2.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );

    var patrol_icon = new fjzx.map.Icon( //巡河
        "/static/images/patrol.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );
    var reservoir_icon = new fjzx.map.Icon( //排口
        "/static/images/reservoir.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );

    var wpfsqy_icon = new fjzx.map.Icon( //水库
        "/static/images/water/wpfsqy.png", {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        });
    var water_case_icon = new fjzx.map.Icon(
        "/static/images/water_case.png",
        {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        }
    );

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function addTab(subtitle, id) {
        var $targetTabs = $(".tabs-panel");
        var $targetContent = $targetTabs.siblings(".tabs-content");
        if (!hasTabs(subtitle)) {
            var tabsId = '#mapTabs_' + id;
            var tabsHTML = '<li class="tabs-item">\
					<a class="tabs-inner active" data-target="#mapTabs_' + id + '">' + subtitle + '</a>\
				</li>';

            $targetTabs.find(".tabs-inner").removeClass('active');
            $targetContent.find(".body-box").hide();
            $targetTabs.append(tabsHTML);
            $(tabsId).show();
            $('#' + id + 'Dg').datagrid("options").url = $(tabsId).attr("url");
            $('#' + id + 'Dg').datagrid('load', {});
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

    $(".map-panel-header").on("click", function () {
        var $target = $(this).parent();
        if ($target.hasClass("collapsed")) {
            $target.removeClass("collapsed");
        } else {
            $target.addClass("collapsed");
        }
    });

    $("#timeList,#polluteCodeList").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchWaterPointBar();
    });

    $("#basin_polluteList").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchAnalysis();
    });

    $("#basin_polluteList_tb").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchAnalysis_tb();
    });

    $("#basin_polluteList_njdb").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchAnalysis_njdb();
    });

    $("#outfallTimeList,#outfallPltCodeList").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchConHourBar();
    });

    $("#reservoirTimeList").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        searchConDayBar();
    });

    /*tabs*/
    $('.tabs-panel').on('click', '.tabs-inner', function () {
        $(this).parents(".tabs-panel").find(".tabs-inner").removeClass('active');
        $(this).addClass('active');
        var target = $(this).attr("data-target");
        $(target).show();
        $(target).siblings(".body-box").hide();
    });

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay * 60000 * 60 * 24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var date = d.getDate();
        if (date >= 0 && date <= 9) {
            date = "0" + date;
        }
        var hours = d.getHours();
        if (hours >= 0 && hours <= 9) {
            hours = "0" + hours;
        }
        var minutes = d.getMinutes();
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        var seconds = d.getSeconds();
        openPointDlg
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
        return currentdate;
    }

    function addOtherPoints() {
        var checkboxs = "";
        for (var i = 0; i < pointsData.length; i++) {
            if (selectedPointInfo.mn != pointsData[i].mn) {
                checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_mnname" type="checkbox" value="'
                    + pointsData[i].mn + '"/><span class="lbl">' + pointsData[i].mnname + '</span></label>';
            }
        }
        for (var i = 0; i < miniMonitorData.length; i++) {
            if (selectedPointInfo.mn != miniMonitorData[i].mn) {
                checkboxs += '<label class="form-checkbox" style="width:150px"><input name="cb_mnname" type="checkbox" value="'
                    + miniMonitorData[i].mn + '"/><span class="lbl">' + miniMonitorData[i].mnname + '</span></label>';
            }
        }
        $("#monitorList").html(checkboxs);
    }

    //=======================================这个是赋值小河流域的数据


    var pointsData = new Array(); //站点数组
    var selectedPointInfo = ""; //已选择站点信息
    var pointInfoWins = new Array(); //地图上显示的水质监测站点
    var pointLabels = new Array(); //地图上显示的水质监测站点
    var linesAndPolygons = new Array(); //线和面
    var polygons = null;
    var fivePolygons = null;
    var polygonsMap = new HashMap();
    var xlyMap = new Array();//小河流域的地图删除事件
    function loadRiver() {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/listNoPage",
            async: true,
            data: {
                polluteCode: "",
                category: ""
            },
            success: function (result) {
                var data = result.data;
               $("#gkdm").html('<span><img src="/static/images/water.png"></span>国控断面('+data.length+')')
                var poyjSONArr = [];
                var mnArr = [];
                for (var i = 0; i < data.length; i++) {
                    var icon = icon6;
                    var color = "#b8b8b8";
                    if (data[i].quality == "Ⅰ"
                        || data[i].quality == "Ⅱ") {
                        icon = icon1;
                        color = "#2ba4e9";
                    } else if (data[i].quality == "Ⅲ") {
                        icon = icon2;
                        color = "#45b97c";
                    } else if (data[i].quality == "Ⅳ") {
                        icon = icon3;
                        color = "#FFFF00";
                    } else if (data[i].quality == "Ⅴ") {
                        icon = icon4;
                        color = "#f47920";
                    } else if (data[i].quality == "劣Ⅴ") {
                        icon = icon5;
                        color = "#d02032";
                    }
                    var clickDiv = null;
                    if (data[i].category == "0") {
                        color = "rgba(0,0,0,0)";
                        clickDiv = "<div style='width: 120px;text-align: center'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                            + "<div id='monitor_"
                            + data[i].mn
                            + "' style='border-radius: 50px;height:100%;line-height: 39px;width:100%;text-align: center;font-weight:bold;"
                            + "background-color:"
                            + color
                            + "' onclick='openPointDlg(JSON.stringify(pointsData["
                            + i
                            + "]))'>"
                            + data[i].value
                            + "</div>"
                            + "</div><p style='font-weight:bold;'>"
                            + data[i].mnname + "</p></div>";
                    }
                    if (data[i].category == "1"
                        || data[i].category == "2") {
                        clickDiv = "<div style='width: 120px;text-align: center'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                            + "<div id='monitor_"
                            + data[i].mn
                            + "' style='border-radius: 50px;height:100%;line-height: 39px;width:100%;text-align: center;font-weight:bold;"
                            + "background-color:"
                            + color
                            + "' onclick='openPointDlg(JSON.stringify(pointsData["
                            + i
                            + "]))'>"
                            + data[i].value
                            + "</div>"
                            + "</div><p style='font-weight:bold;'>"
                            + data[i].mnname + "</p></div>";
                    } else {
                        clickDiv = "<div style='width: 120px;text-align: center'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                            + "<div id='monitor_"
                            + data[i].mn
                            + "' style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;"
                            + "background-color:"
                            + color
                            + "' onclick='openPointDlg(JSON.stringify(pointsData["
                            + i
                            + "]))'>"
                            + data[i].value
                            + "</div>"
                            + "</div><p style='font-weight:bold;'>"
                            + data[i].mnname + "</p></div>";
                    }
                    if (data[i].mark == 0) {
                        clickDiv = "<p style='font-weight:bold;'>" + data[i].mnname + "</p></div>";
                    }
                    //创建point
                    var point = new fjzx.map.Point(data[i].lng,
                        data[i].lat);
                    //创建地图marker点
                    var myMarker = new fjzx.map.Marker(point, {
                        markerHtml: clickDiv,
                        map: map,
                        isShowIcon: false,
                        title: data[i].mnname,
                        id: data[i].mn
                    });
                    pointInfoWins[i] = myMarker;
                    map.addOverlay(myMarker);
                    xlyMap.push(myMarker);
                    pointsData[i] = data[i];
                    linesAndPolygons[i] = "";
                    if (data[i].polygon != "") {
                        var points = [];
                        var arr = data[i].polygon.split(',');
                        for (var j = 0; j < arr.length; j = j + 2) {
                            points.push([arr[j], arr[j + 1]]);
                        }
                        var feature = {
                            "layout": "XY",
                            "coordinates": [points],
                            "type": "Polygon",
                            "featureId": "p" + data[i].mn,
                            "pencilColor": color,
                            "pencilSize": '0'
                        };
                        poyjSONArr.push({
                            "feature": JSON.stringify(feature),
                            "name": "",
                            "id": "p_" + data[i].mn
                        });
                        mnArr.push("p_" + data[i].mn);

                        if (polygons == null) {
                            polygons = new fjzx.map.DrawGeoJSON({
                                map: map,
                                zIndex : 10000,
                                customType:'poly'
                            });
                        }
                    }
                }
                polygons.load(poyjSONArr);

            },
            error: function () {
            },
            dataType: 'json'
        });

    }

    //=========================删除小河流域
    //删除地图中的小河流域描述事件
    function clearGKMap() {
        for (var i = 0; i < xlyMap.length; i++) {
            map.removeOverlay(xlyMap[i]);
        }
    }

    //添加小河流域条数
    function loadRiverNum() {
        layPolicy(map);
    }
    $(".no-choice2").click(function () {
        var text = $(this).text();
        if (text.indexOf("微型") != -1) {
            return
        }
        if ($(this).hasClass("choiced2")) {
            if (text.indexOf("国控") != -1) {
                clearGKMap();
            } else {
                clearPolicy();
            }
            $(this).removeClass("choiced2")
        } else {
            if (text.indexOf("国控") != -1) {
                loadRiver();
            } else {
                loadRiverNum();
            }
            $(this).addClass("choiced2")

        }
    })
    //========河流点击事件
</script>