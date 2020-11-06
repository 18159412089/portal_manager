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
        <div class="map-reduction-box" style="z-index: 100">
            <span> <i class="icon iconcustom icon-shuaxin1"></i>还原</span>
        </div>
        <div class="map-gridline-box" style="z-index: 100">
            <span>网格线 </span>
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
                            <div class="personnel-parent">
                                <span>大气环境污染源</span>
                                <i id="countPollutionARINum">56个</i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced " id="gyfsqy">
                                                    <span><img src="${request.contextPath}/static/images/VOCs-icon.png"></span>
                                                    VOCs企业(26)
                                                </div>
                                                <div class="change-line no-choice  choiced" id="wxszzdz">
                                                    <span><img src="${request.contextPath}/static/images/gjyqy-icon.png"></span>
                                                    高架源企业(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="xly">
                                                    <span><img src="${request.contextPath}/static/images/slwqy-icon.png"></span>
                                                    散乱污企业(26)
                                                </div>
                                                <div class="change-line no-choice choiced" id="fdlydy">
                                                    <span><img src="${request.contextPath}/static/images/slwqy-icon.png"></span>
                                                    非道路移动源(26)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>空气监测站点</span>
                                <i>50个</i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice2" id="monitor" onclick="getMonitor()">
                                                    <span><img src="/static/images/icon/shengshishenghuowushui.png"></span>
                                                    空气监测站(<i>37</i>)
                                                </div>
                                                <div class="change-line no-choice2" id="miniMonitor" onclick="getMiniMonitor()">
                                                    <span><img src="/static/images/air/miniMonitor.png"></span>
                                                    微型监测站(13)
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

<div id="air"  title="详细和数据分析"  class="easyui-dialog" style="width:1000px;height:600px;"
                                                        data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:552px;">
            <div title="详情">
                <div class="panel-group-container">
                    <div class="panel-group-top">
                        <span id="cityName">hfhdfhdfhd</span><span class="subtext fr" id="monitrorTime"></span>
                    </div>
                    <div class="panel-group-body" >
                        <div class="panel-info" id="airInfo">
                            sfdsfsfsfsf
                        </div>
                    </div>
                </div>
            </div>

            <div title="数据分析">
                <div class="data-analysis">
                    <div id="radioListContainer" class="radio-button-group radio-button-group1 style-list fl" style="width: 100px;height:100%;">
                        <div id="radioList">
                        </div>
                    </div>
                    <div class="oh data-analysis-content">
                        <div class="radio-button-group radio-button-group2 " id="option">

                        </div>
                        <div id="AirtypeBar" style="height: 400px;width:850px;"></div>
                        <div class="selectBox-container">
                            <div class="select-button">
                                <span>对比 </span>
                            </div>
                            <div class="select-panel">
                                <div id="selectGropContainer" style="height:104px;">
                                    <div id="selectGrop">
                                    </div>
                                    <!--复选框 over-->
                                </div>
                                <div class="tr">
                                    <button type="button" class="btnSure btn-blue l-btn">确定</button>
                                    <button type="button" class="cancel btn-blue l-btn">取消</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\pollutionInfo2_new.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/airAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/pollution/gridline.js"></script>

<script>
    $(function () {
        getMonitor();
        $("#monitor").addClass('choiced2');


        /*地图监听事件 删除和添加地图上的点*/
        map.on('moveend', function (e) {
            //var factor = $("span.ant-radio-button-checked input").val();
            // var factor = $(".point-group .select-point").attr("value");
            // if(f == 1){
            //     if(map.getView().getZoom()<10.5 && size != map.getView().getZoom()){
            //         if(size < 10.5 ) {
            //             size = map.getView().getZoom();
            //             return 0;
            //         }
            //         remove(labelArray);
            //         size = map.getView().getZoom();
            //
            //         remove(monitorPoint);
            //         creatMarker("1",factor);
            //         ranking("1","1");
            //         f=0;
            //     }
            // }
            // 没点击排名的时候，地图放大和缩小就显示对应的城市站点或者监测站点（所有）
            if(f == 0) {
                if($('#monitor').hasClass('choiced2')){

                    initView(map,"aqi")
                }
            }
        })

        //网格线
        $(".map-gridline-box").click(function () {
            if ($(".map-gridline-box").hasClass("map-gridline-select")) {
                $(".map-gridline-box").removeClass("map-gridline-select");
                clearGridlines();
            } else {
                $(".map-gridline-box").addClass("map-gridline-select");
                setGridlines();
            }

        });
        
    });

    function getMiniMonitor(){
        if ($("#miniMonitor").hasClass('choiced2')) {
            $("#miniMonitor").removeClass('choiced2');
            $("#pointName").textbox('setValue', '');
            remove(builtPoint);
        } else {
            $("#miniMonitor").addClass('choiced2');
            //creatMarker("2",$("span.ant-radio-button-checked input").val());
            creatMarker("2", "aqi");
        }
    }

    function getMonitor(){
        if ($("#monitor").hasClass('choiced2')) {
            $("#monitor").removeClass('choiced2');
            remove(cityPoint);
            remove(monitorPoint);
        } else {
            $("#monitor").addClass('choiced2');
            if(map.getView().getZoom()<=10.5){
                creatMarker("1", "aqi");
            }else{
                creatMarker("0", "aqi");
            }

        }
    }
    /*删除地图上的点*/
    function remove(marker){
        for (var i =0 ; i < marker.length; i++) { //倒序删除避免长度发生变化
            map.removeOverlay(marker[i]);
        }
    }
    /*判断值是否为空*/
    function isNull(value){
        if(value == null){
            return '-';
        }else{
            return value;
        }
    }
</script>
<script type="text/javascript">
    var labelArray = new Array(); //文本数组
    var f=0;
    var size = 0 ; // 当前地图大小
    var code;  // 城市站点编号
    $(window).resize(function () {

    });

    //监测点 点击事件
    $(".point-group") .find("a").click(function () {
        $(".point-group").find("a").removeClass("select-point");
        $(this).addClass("select-point");
        var factor = $(".point-group .select-point").attr("value");
        if(f == 1){
            creatAir("0",factor,code);
        }
        // 没点击排名的时候，地图放大和缩小就显示对应的城市站点或者监测站点（所有）\
        if(f == 0) {
            if(map.getView().getZoom()<11 ){
                creatAir("1",factor);
            }else if(map.getView().getZoom()>=11 ){
                creatAir("0",factor);
            }
        }
        if($("#miniMonitor").hasClass('choiced')){
            creatAir("2",factor);
        }
    })

    function ajaxLoading(){
        $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:(($(document.body).outerWidth(true) - 190) / 2),top:($(window).height()- 100) / 2,width:"200px",height:"50px" });
    }
    function ajaxLoadEnd(){
        $(".datagrid-mask-msg").remove();
    }

    function initView(map,factor){
        if(map.getView().getZoom()<=10.5 && size != map.getView().getZoom()){
            if(size == 0 ) {
                size = map.getView().getZoom();
                return 0;
            }
            if(size<=10.5){
                size = map.getView().getZoom();
                return 0;
            }
            remove(labelArray);
            size = map.getView().getZoom();
            remove(monitorPoint);
            creatMarker("1",factor);
            ranking("1","1");//第一个值是站点类型 第二个是站点级别


        }else if(map.getView().getZoom()>10.5 && size != map.getView().getZoom()){
            if(size >10.5 ) {
                size = map.getView().getZoom();
                //map.removeOverLay(markerInfoWin);
                return 0;
            }
            remove(labelArray);
            size = map.getView().getZoom();
            remove(cityPoint);
            creatMarker("0",factor);
            ranking("0","0");
        }
    }
</script>
</html>
