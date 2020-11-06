<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染溯源具体详情</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>

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

<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudPollution.css"/>

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

<!-- 头部 -->
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<!-- 头部 over  -->
<input id="basinName" type="hidden" value="${basinName!}">

<div class="region-content">
    <div class="map-left border-style">
        <div class="map-title">
            <h3><a href="/environment/pollutionTraceability?pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369"
                   style="text-decoration:none">
                    <i class="icon iconcustom icon-fanhui5"></i> 返回</a></h3>
        </div>
        <!--面板主内容-->
        <div class="map-container">
            <div class="map-tool"></div>
            <div class="map-wrapper" id="mapDiv">
                <div class="basemap-toggle" style="width: 60px; height: 60px; top: 16px; right: 16px;">
                    <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                         layer-group-name="ZZ_VEC_MAP" title="矢量图层" selected="selected">
                        <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="/static/fjzx-map/img/basemap-1.png" alt="">
                    </div>
                    <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                         layer-group-name="FJ_IMG_MAP" title="影像图层">
                        <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="/static/fjzx-map/img/basemap-2.png" alt="">
                    </div>
                </div>
            </div><!--地图图层-->

        </div>
        <!--面板主内容 over-->
        <!--   <div class="tagging-item">
              <div class="home-panel">

              </div>
          </div> -->
    </div>

    <div class="region-right">
        <div class="region-info">
            <div class="item border-style">
                <h3><a>国控断面 <i> <img src="${request.contextPath}/static/images/pollute/icon-img3.png"></i></a></h3>
                <div class="info-data" id="basinInfo">

                </div>
            </div>
            <div class="item border-style"><#--污水处理厂-->
                <h3><a>污水处理厂 <i> <img src="${request.contextPath}/static/images/pollute/icon-img1.png"></i></a></h3>
                <div class="info-data" id="wsclc" style="height:412px">
                    <div class="tex">
                        <a href="/indextemp24">华安县三达水务有限公司</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">长泰西区污水处理厂（长泰县三达水务有限公司）</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">漳州市西区污水处理厂</a>
                    </div>
                    <div class="tex">
                        <a href="javascript:void(0)">南靖高新污水处理厂（西部水务（漳州）有限公司）</a>
                    </div>
                </div>
            </div>
            <div class="item border-style">
                <h3><a>常规排口 <i> <img src="${request.contextPath}/static/images/pollute/icon-img2.png"></i></a></h3>
                <div class="info-data" id="cgpk" style="height:412px">
                    <div class="tex">
                        <a href="javascript:void(0)">福建立兴食品有限公司</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="chart-box">
            <h3><span></span></h3>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 blue">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span id="gkdm">4</span><#--gkdm国控断面-->
                            <#-- <div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>国控断面 </p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 green">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span id="wsclcNum">4</span>
                            <#--wsclcNum污水处理厂个数<div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>污水处理厂 </p>
            </div>
            <div class="item col-xs-4">
                <div class="basin-name-container circle-3 purple">
                    <div class="basin-bg">
                        <div class="bg-img bg-1"></div>
                        <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                    </div>
                    <div class="basin-text-box">
                        <div class="basin-text">
                            <div class="area"></div>
                            <span id="cgpkNum">9</span>
                            <#--cgpkNum常规排口个数<div class="name">北溪/龙津溪</div>-->
                        </div>
                    </div>
                </div>
                <p>常规排口 </p>
            </div>
        </div>
    </div>

</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/policy.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/js/moudles/enviromonit/water/specialBasin.js"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    var basinDatas = new Array(); // 流域数据数组
    var basinPoints = new Array(); // 流域站点数组(重新定位的时候需要清楚掉)
    var basinRiver = new Array();//流域中的河流
    var companyAndPlantPoint = new Array(); // 常规排口,污水处理厂数组
    var envRectifition_icon;
    var fivePolygons = null;
    
    $(function () {
        
        /*地图初始化*/
        var longitude = "117.65";
        var latitude = "24.52";
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        envRectifition_icon = new fjzx.map.Icon("/static/images/min-basin.png", {
            size: new fjzx.map.Size(25, 25),
            imgSize: new fjzx.map.Size(25, 25),
            anchor: new fjzx.map.Point(12, 25)
        });
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
            zoom: 10
        });
        map.render();
        map.removeSelectInteraction();
        //getBasin();
        // getReservoirPoints();
        
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
        
        loadRiverByBasinName();
        showRiverDetail($('#basinName').val(),1);
        getBasinInfo($('#basinName').val());
    });

    function getBasin() {
        $.ajax({
            type: "post",
            url: "/enviromonit/water/nationalSurfaceWater/getBasinMonitor",
            async: true,
            success: function (result) {
                var data = result.data;
                var geoJSONArr = [];
                for (var i = 0; i < data.length; i++) {
                    basinDatas[i] = data[i];

                    var color = "#2ba4e9";
                    var clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                        + "<div style='border-radius: 15px;height:20px;line-height: 25px;width:20px;text-align: center;font-weight:bold;"
                        + "background-color:" + color + "' onclick=''> </div>"
                        + "</div><p style='font-weight:bold;'>" + data[i].name + "</p></div>";
                    //创建pint
                    var point = new fjzx.map.Point(data[i].lng, data[i].lat);
                    //创建地图marker点 
                    var myMarker = new fjzx.map.Marker(point, {
                        // markerHtml: clickDiv,
                        icon: envRectifition_icon,
                        map: map,
                        isShowIcon: false,
                        title: data[i].name,
                        id: data[i].mn
                    });
                    map.addOverlay(myMarker);
                    basinPoints[i] = myMarker;

                }
            },
            error: function () {
            },
            dataType: 'json'
        });
    }

    var reservoir_icon;

    function getReservoirPoints() {
        $.ajax({
            type: 'POST',
            url: '/enviromonit/water/nationalSurfaceWater/getReservoirPoints',
            async: true,
            data: {},
            success: function (result) {
                var data = result.data;
                for (var i = 0; i < data.length; i++) {
                    var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(data[i].lng, data[i].lat), {
                        icon: reservoir_icon,
                        map: map,
                        title: data[i].name
                    });
                    map.addOverlay(tempMarker);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
            },
            dataType: 'json'
        });
    }

    //    $(function () {
    //        /*---------------------------------------漳州市周统计-------------------------------------------*/
    //
    //        var dataPieCharts = echarts.init(document.getElementById('dataPieCharts'));
    //
    //        var dataPieChartsOption= {
    //            title : {
    //                text: '国控断面',
    //                x:'center',
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //            },
    //
    //            legend: {
    //                orient: 'horizontal',
    //                top:240,
    //                left: 'center',
    //                data: ['西溪200个','北溪300个','南溪500个'],
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //
    //
    //            },
    //            series : [
    //                {
    //                    name: '访问来源',
    //                    type: 'pie',
    //                    radius : '62%',
    //                    center: ['50%', '46%'],
    //                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
    //                    data:[
    //                        {value:200, name:'西溪200个'},
    //                        {value:300, name:'北溪300个'},
    //                        {value:500, name:'南溪500个'},
    //                    ],
    //                    itemStyle: {
    //                        emphasis: {
    //                            shadowBlur: 10,
    //                            shadowOffsetX: 0,
    //                            shadowColor: 'rgba(0, 0, 0, 0.5)'
    //                        }
    //                    }
    //                }
    //            ]
    //        };
    //        dataPieCharts.setOption(dataPieChartsOption);
    //
    //
    //        var dataPieCharts2 = echarts.init(document.getElementById('dataPieCharts2'));
    //        var dataPieChartsOption2= {
    //            title : {
    //                text: '国控断面',
    //                x:'center',
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //            },
    //            legend: {
    //                orient: 'horizontal',
    //                top:240,
    //                left: 'center',
    //                data: ['西溪200个','北溪300个','南溪500个'],
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //
    //
    //            },
    //            series : [
    //                {
    //                    name: '访问来源',
    //                    type: 'pie',
    //                    radius : '62%',
    //                    center: ['50%', '46%'],
    //                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
    //                    data:[
    //                        {value:200, name:'西溪200个'},
    //                        {value:300, name:'北溪300个'},
    //                        {value:500, name:'南溪500个'},
    //                    ],
    //                    itemStyle: {
    //                        emphasis: {
    //                            shadowBlur: 10,
    //                            shadowOffsetX: 0,
    //                            shadowColor: 'rgba(0, 0, 0, 0.5)'
    //                        }
    //                    }
    //                }
    //            ]
    //        };
    //        dataPieCharts2.setOption(dataPieChartsOption2);
    //
    //        var dataPieCharts3 = echarts.init(document.getElementById('dataPieCharts3'));
    //        var dataPieChartsOption3= {
    //            title : {
    //                text: '国控断面',
    //                x:'center',
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //            },
    //            legend: {
    //                orient: 'horizontal',
    //                top:240,
    //                left: 'center',
    //                data: ['西溪200个','北溪300个','南溪500个'],
    //                textStyle: { //图例文字的样式
    //                    color: '#fff',
    //                    fontSize: 13
    //                },
    //
    //
    //            },
    //            series : [
    //                {
    //                    name: '访问来源',
    //                    type: 'pie',
    //                    radius : '62%',
    //                    center: ['50%', '46%'],
    //                    color: [ '#fe8a57', '#ffa800','#37A2DA'],
    //                    data:[
    //                        {value:200, name:'西溪200个'},
    //                        {value:300, name:'北溪300个'},
    //                        {value:500, name:'南溪500个'},
    //                    ],
    //                    itemStyle: {
    //                        emphasis: {
    //                            shadowBlur: 10,
    //                            shadowOffsetX: 0,
    //                            shadowColor: 'rgba(0, 0, 0, 0.5)'
    //                        }
    //                    }
    //                }
    //            ]
    //        };
    //        dataPieCharts3.setOption(dataPieChartsOption3);
    //
    //        window.onresize = function () {
    //            dataPieCharts.resize();
    //            dataPieCharts2.resize();
    //            dataPieCharts3.resize();
    //        }
    //    });
    //通过流域获取小河流域信息
    function loadRiverByBasinName() {
        $.ajax({
            url: '/environment/pollutionTraceability/getBasinInfoByBasin',
            data: {'basinNameOrRiver': $('#basinName').val()},
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var color = "#2ba4e9";
                    var clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                        + "<img src='${request.contextPath}/static/images/min-basin.png' title='"+data[i].monitorName+"' style='width:25px'  onclick='showRiverDetail(\"" + data[i].river + "\",2)'>"
                        + "</div><p style='font-weight:bold;'>" + data[i].river + "</p></div>";
                    //创建pint
                    basinRiver[i] = data[i];
                    var point = new fjzx.map.Point(data[i].longitude, data[i].latitude);
                    //创建地图marker点
                    var myMarker = new fjzx.map.Marker(point, {
                        markerHtml: clickDiv,
                        map: map,
                        isShowIcon: false,
                        title: data[i].river,
                        id: data[i].uuid
                    });
                    map.addOverlay(myMarker);
                    basinPoints[i];
                }
            }

        })
    }

    function showRiverDetail(dataRiver,index) {
        $.ajax({
            url: '/environment/pollutionTraceability/findPlantAndOuterList',
            data: {'riverName': dataRiver},
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data.type == 'E') {
                    Ams.error(data.message);
                } else {
                    if (data.wsclc.length == 0) {
                        layer.msg("暂无污水处理厂")
                    }
                    if (data.cgpk.length == 0) {
                        layer.msg("暂无常规排口")
                    }
                    getWSCLC(data.wsclc);
                    getCGPK(data.cgpk);
                    if (index != 1) {
                        clearMapPoint();
                        loadMapWSCLC(data.wsclc);
                        loadMapCGPK(data.cgpk)
                    }
                }
            }
        })
    }

    //污水处理厂数据拼装
    function getWSCLC(wsclc) {
        var row = "";
        var length = wsclc.length
        for (var i = 0; i < length; i++) {
            row += '<div class="tex">';
            row += '<a href="/indextemp24">' + wsclc[i].wsclc + '</a>';
            row += '</div>';
        }
        $("#wsclcNum").text(length);

        if (length == 0) {
            $("#wsclcNum").text("无");
        }
        $("#wsclc").empty();
        $("#wsclc").append(row);
    }


    //常规排口拼装
    function getCGPK(cgpk) {
        var row = "";
        var length = cgpk.length;
        for (var i = 0; i < length; i++) {
            row += '<div class="tex">';
            row += '<a href="/indextemp24">' + cgpk[i].cgpk + '</a>';
            row += '</div>';
        }
        $("#cgpkNum").text(length)
        if (length == 0) {
            $("#cgpkNum").text("无")
        }

        $("#cgpk").empty();
        $("#cgpk").append(row);
    }

    //获取流域中的数据显示国控断面有多少个
    function getBasinInfo(basinName) {
        var row = "";
        switch (basinName) {
            case "九龙江":
                row += '  <div class="tex">' +
                    '     <a href="javascript:void(0)" onclick=\'skipToThirdDetail(this)\'>浦南水文站</a>' +
                    ' </div>' +
                    ' <div class="tex">' +
                    '     <a href="javascript:void(0)" onclick=\'skipToThirdDetail(this)\'>长泰洛宾</a>' +
                    ' </div>' +
                    ' <div class="tex">' +
                    '     <a href="javascript:void(0)" onclick=\'skipToThirdDetail(this)\'>上板</a>' +
                    ' </div>' +
                    ' <div class="tex">' +
                    '     <a href="javascript:void(0)" onclick=\'skipToThirdDetail(this)\'>南靖靖城桥</a>' +
                    ' </div>';
                setSpecialBasin('3');
                break;
            case "鹿溪":
                ;$("#gkdm").text("无");
                setSpecialBasin('0');
                break;
            case "漳江":
                row += '  <div class="tex">' +
                    '     <a href="/environment/pollutionTraceability/thirdDetail?name=云霄高塘渡口">云霄高塘渡口</a>' +
                    ' </div>';
                $("#gkdm").text("1");
                setSpecialBasin('1');

                break
            case "诏安东溪":
                row += '  <div class="tex">' +
                    '     <a href="/environment/pollutionTraceability/thirdDetail?name=诏安澳子头">诏安澳子头</a>' +
                    ' </div>';
                $("#gkdm").text("无");
                setSpecialBasin('2');
                break;
            case "韩江(九峰溪)":
                $("#gkdm").text("无");
                setSpecialBasin('4');
                break;
        }
        $("#basinInfo").empty();
        $("#basinInfo").append(row);
    }

    /**
     * 清除点位
     */
    function clearMapPoint() {
        for (var i = 0; i < companyAndPlantPoint.length; i++) {
            map.removeOverlay(companyAndPlantPoint[i]);
        }
    }

    //架在你常规排口和
    //污水处理厂数
    function loadMapCGPK(cgpk) {
        var length = cgpk.length;
        for (var i = 0; i < length; i++) {
            var clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                + "<img src='${request.contextPath}/static/images/water_outfall.png' style='width:25px'>"
                + "</div><p style='font-weight:bold;'>" + cgpk[i].cgpk + "</p></div>";
            var point = new fjzx.map.Point(cgpk[i].lng, cgpk[i].lat);
            //创建地图marker点
            var myMarker = new fjzx.map.Marker(point, {
                markerHtml: clickDiv,
                map: map,
                isShowIcon: false,
                title: cgpk[i].cgpk,
                id: cgpk[i].cgpk
            });
            map.addOverlay(myMarker);
            //创建pint
            companyAndPlantPoint.push(myMarker);
        }
    }

    function loadMapWSCLC(wsclc) {
        var length = wsclc.length
        for (var i = 0; i < length; i++) {
            var clickDiv = "<div style='width: 120px;text-align: center;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>"
                + "<img src='/static/images/water_sewagePlant.png' style='width:25px'>"
                + "</div><p style='font-weight:bold;'>" + wsclc[i].wsclc + "</p></div>";
            var point = new fjzx.map.Point(wsclc[i].lng, wsclc[i].lat);
            //创建地图marker点
            var myMarker = new fjzx.map.Marker(point, {
                markerHtml: clickDiv,
                map: map,
                isShowIcon: false,
                title: wsclc[i].wsclc,
                id: wsclc[i].wsclc
            });
            map.addOverlay(myMarker);
            //创建pint
            companyAndPlantPoint.push(myMarker);
        }
    }
    function skipToThirdDetail(thisname) {//跳转至第三个详情页面
        window.location.href='/environment/pollutionTraceability/thirdDetail?name='+encodeURIComponent($(thisname).text())

        
    }

</script>
</html>