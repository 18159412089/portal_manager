<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>水环境服务</title>
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

    <#--水系图层相关-->
    <link rel="stylesheet" href="${request.contextPath}/static/river/app.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/layer/theme/default/layer.css"/>

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

        .fjzx-map-infoWindow a {
            color: #464444;
        }

        .fjzx-map-infoWindow-closer {
            top: -50px;
            right: 43px;
        }


        #gridCaseDlg {
            width: 800px;
            height: 500px;
            padding: 15px;
        }

        #gridCaseDlg table {
            width: 100%;
        }

        #gridCaseDlg tr.odd {
            background: #f0f0f0;
        }

        #gridCaseDlg .detail-info-group {
            float: left;
            width: 50%;
            padding: 8px 4px;
            color: #333333;
            overflow: hidden;
            box-sizing: border-box;
        }

        #gridCaseDlg .detail-info-group .info-title {
            color: #999999;
            width: 120px;
            text-align: right;
            float: left;
        }

        #gridCaseDlg .detail-info-group .info-con {
            margin-left: 120px;
        }

        .thumb-img {
            width: 180px;
            height: 120px;
            padding: 4px;
            margin: 5px;
            display: inline-block;
            overflow: hidden;
            position: relative;
            border: 1px solid #dddddd;
            background: #ffffff;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
        }

        .thumb-img img {
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .thumb-img .video-img {
            position: absolute;
            z-index: 100;
            top: 36px;
            left: 60px;
            width: 50px;
            height: auto;
        }

        .pagination table .l-btn {
            margin: 0 1px !important;
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

        .fjzx-map-infoWindow a {
            color: #464444;
        }

        .fjzx-map-infoWindow-closer {
            top: -50px;
            right: 43px;
        }
    </style>
</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#--<#include "/waterEnvironmentMenu.ftl">-->
<#include "/zphb/zpSecondToolbar.ftl">

<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>

<input type="hidden" id="waterPointCode" value="${waterPointCode!}"/>
<input type="hidden" id="basinCode" value="${basinCode!}"/>
<input type="hidden" id="pid" value="${pid!}"/>
<div class="container oh" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px;">
    <!-- main -->
    <input id="targetId" type="hidden" value="${target!}">
    <div id="mapDiv" class="map-wrapper" style="position: fixed; bottom: 0;">
        <div class="basemap-toggle" style="width: 60px; height: 60px; top: 100%; left: 16px;margin-top: -170px;">
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
    </div>
    <!-- 地图层 -->

    <!-- 图例  -->
    <div class="map-legend-container"
         style="z-index: 998; position: absolute; bottom: 0px;right: 0; left: 0px;">
        <div class="grade-legend">
            <div class="legend" style="width:auto; color: #fff">
                <span class="item water_excellent"></span>Ⅰ <span
                        class="item water_good"></span>Ⅱ <span class="item water_mild"></span>Ⅲ
                <span class="item water_moderate"></span>Ⅳ <span
                        class="item water_severe"></span>Ⅴ <span
                        class="item water_dangerous"></span>劣Ⅴ <span class="item"></span>未知
                <div id="mapDiv" class="legend-item-box" style="display: none">
                    <div class="legend  alone-legend">
                        <ul class="list">
                            <li class="legend-item" data-status="1" data-grade="0" selected="selected">
                           <span class="bg-status-1" style="background-color: #60e1e9;"><span>
                           </span></span><span class="title">Ⅰ</span>
                            </li>
                            <li class="legend-item" data-status="1" data-grade="1" selected="selected">
                              <span class="bg-status-1" style="background-color: #237e2b;">
                              <span></span></span><span class="title">Ⅱ</span>
                            </li>
                            <li class="legend-item" data-status="1" data-grade="2" selected="selected">
                                <span class="bg-status-1" style="background-color: #1d58f9;"><span></span></span><span
                                        class="title">Ⅲ</span></li>
                        </ul>
                    </div>
                </div>


            </div>
        </div>
    </div>

    <div class="map-panel"
         style="z-index: 998; position: absolute; top: 86px; right: 58px;">
        <div class="map-panel-header">
                <span class="title"> <span
                            class="icon iconcustom icon-zhedie3"></span> 图层控制
                </span>
        </div>
        <div class="map-panel-body" style="height: 550px; width: 400px; position: relative; background: none;">
            <div class="body-box" id="filterBox"
                 style="width: 350px; height: 180px; margin-left: 120px; border-bottom: 1px solid #fff; border-color: rgba(255, 255, 255, 0.15);">
                <div class="filter-container">
                    <div class="filter-box">
                        <div class="filter-title">点位类型</div>
                        <div class="filter-content">
                            <div class="change-line no-choice" title="污水处理厂"
                                 id="sewagePlant" style="width: 120px"
                                 onclick="getPeMonitorPoints('type1')">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water_sewagePlant.png"/>污水处理厂
                            </div>
                            <div class="change-line no-choice" title="常规排口" id="outfall"
                                 style="width: 100px" onclick="getPeMonitorPoints('other')">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water_outfall.png"/>常规排口
                            </div>
                            <div class="change-line no-choice" title="工业废水企业" id="wpfsqy"
                                 style="width: 120px" onclick="getWpfsqy()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water/wpfsqy.png"/>工业<#--污普-->废水企业
                            </div>
                            <div class="change-line no-choice" title="水库" id="reservoir"
                                 style="width: 100px;display: none;" onclick="getReservoirPoints('reservoir')">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/reservoir.png"/>水库
                            </div>
                            <div class="change-line no-choice" title="微型水质自动站"
                                 id="miniMonitor" style="width: 120px;display: none;"
                                 onclick="getMiniMonitor()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water/water_mini_monitor.png"/>微型水质自动站
                            </div>
                            <div class="change-line no-choice" title="小流域" id="basin"
                                    <#--style="width: 100px;" onclick="getBasin()">-->
                                 style="width: 100px;" onclick="getRiverBasin()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/min-basin.png"/>小流域
                            </div>
                            <div class="change-line no-choice" title="巡河" id="patrol"
                                 style="width: 120px;display: none" onclick="getPatrol()">
                                <img style="height: 20px; width: 20px; float: left" src="/static/images/patrol.png"/>巡河
                            </div>
                            <div class="change-line no-choice" title="网格事件" id="gridCase"
                                 style="width: 100px;" onclick="getWaterCase()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water-pollution.png"/>网格事件
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content" style="width:280px;margin-left:120px; top: 180px;">
                <div class="body-box" id="mapTabs_sewagePlant"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getPeMonitorPointsList?peType=type1">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="sewagePlantToolbar">
                                <div class="search-box">
                                    <input id="peName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="sewagePlantSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="sewagePlantDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#sewagePlantToolbar" url=""
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
                                        <th field="peName" width="320px" formatter="Ams.tooltipFormat">污水处理厂名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_outfall"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getPeMonitorPointsList?peType=other">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="outfallToolbar">
                                <div class="search-box">
                                    <input id="outfallNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <select name="discharge" id="discharge" class="easyui-combobox alone-combobox"
                                            data-placement="全部"
                                            label="允许排放量:" style="width:100%;">
                                        <option value="0">全部</option>
                                        <option value="1">500以下</option>
                                        <option value="2">500~2000</option>
                                        <option value="3">2000以上</option>
                                    </select>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="outfallSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="outfallDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#outfallToolbar"
                                       url=""
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
                                        <th field="peName" width="320px" formatter="Ams.tooltipFormat">常规排口名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_wpfsqy"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getWpfsqyList">
                    <div class="theme-container">
                        <div class="theme-title">筛选<a href='/zphb/enviromonit/water/wastewaterCompanySet?pid=${pid!}'
                                                      class="title-link-tag" target="_blank">废水企业信息配置>></a></div>
                        <div class="theme-content">
                            <div class="search-container" id="wpfsqyToolbar">
                                <div class="search-box">
                                    <input id="queryWpfsqyName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="wpfsqySearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="wpfsqyDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#wpfsqyToolbar"
                                       url=""
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
                                        <th field="qymc" width="320px" formatter="Ams.tooltipFormat">企业名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_reservoir"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getReservoirPointsList">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="reservoirToolbar">
                                <div class="search-box">
                                    <input id="reservoirNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="reservoirSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="reservoirDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#reservoirToolbar"
                                       url=""
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
                                        <th field="name" width="320px" formatter="Ams.tooltipFormat">水库名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_miniMonitor"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getMiniMonitorList">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="miniMonitorToolbar">
                                <div class="search-box">
                                    <input id="pointNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="miniMonitorSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="miniMonitorDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#miniMonitorToolbar"
                                       url=""
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
                                        <th field="mnname" width="320px" formatter="Ams.tooltipFormat">微型自动监测站名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_basin"
                     url="/zphb/enviromonit/water/nationalSurfaceWater/getBasinMonitorList">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="basinToolbar">
                                <div class="search-box">
                                    <input id="monitorName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="basinSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="basinDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#basinToolbar"
                                       url=""
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
                                        <th field="name" width="320px" formatter="Ams.tooltipFormat">小流域名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_patrol" url="">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="patrolToolbar">
                                <div class="search-box">
                                    <input id="riverName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                                       onclick="patrolSearch()"></a>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="patrolDg" class="easyui-datagrid"
                                       style="width: 100%;height:322px;" toolbar="#patrolToolbar"
                                       url=""
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
                                        <th field="riverName" width="320px" formatter="Ams.tooltipFormat">河流名称</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="body-box" id="mapTabs_gridCase" url="">
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="gridCaseToolbar">
                                <div class="search-box">
                                    <label class="textbox-label textbox-label-before" title="事件描述">事件描述:</label>
                                    <input id="describe" class="easyui-textbox" style="width:160px;"/>
                                    <div style="margin-top:7px;">
                                        <label class="textbox-label textbox-label-before" title="开始时间">开始时间:</label>
                                        <input id="startTime" class="easyui-datebox" style="width:160px;">
                                    </div>
                                    <div style="margin-top:7px;" class="alone-box">
                                        <label class="textbox-label textbox-label-before" title="结束时间">结束时间:</label>
                                        <input id="endTime" class="easyui-datebox" style="width:122px;font-size: 12px;">
                                        <a href="#" title="搜索" class="easyui-linkbutton"
                                           data-options="iconCls:'icon-search'" style="margin:0;width: 36px;padding: 0"
                                           onclick="getWaterCaseList()"></a>
                                    </div>
                                </div>
                            </div>
                            <div class="easyui-table-light">
                                <table id="gridCaseDg" class="easyui-datagrid" style="width: 100%;height:322px;"
                                       toolbar="#gridCaseToolbar"
                                       url="" data-options="
                                                    rownumbers:false,
                                                    singleSelect:true,
                                                    striped:false,
                                                    autoRowHeight:false,
                                                    pagination:true,
                                                    nowrap:true">
                                    <thead>
                                    <tr>
                                        <th field="describe" width="320px" formatter="Ams.tooltipFormat">事件描述</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div class="tabs-content"
                 style="width: 320px; margin-left: 80px; top: 164px;">
                <div style="display: none" class="body-box panel-group-container"
                     id="mapTabs_wpfsqy">
                    <div id="wpfsqyToolbar">
                        <div style="padding: 1px 14px;" id="outSearchBar">
                            <form id="wpfsqySearchForm">
                                <input id="queryWpfsqyName" class="easyui-textbox"
                                       style="width: 200px;">
                                <a href="#"
                                   class="easyui-linkbutton" style="float: left;" data-options="iconCls:'icon-search'"
                                   onclick="wpfsqySearch()"></a>
                            </form>
                        </div>
                    </div>



                </div>
            </div> -->
            <ul class="tabs-panel" style="top: 180px; margin-right: -120px;">
                <!-- <li class="tabs-item"><a class="tabs-inner active" data-target="#mapTabs_tabs1">污普废水企业</a></li> -->
            </ul>
        </div>
    </div>
</div>

<div id="mapgroup" class="_3dsy dsy-box" style="display:none">
        <span class="point-tag" id="Checkpoint-tag">
            <span class="icon iconcustom icon-zhedie3"></span>因子列表</span>
    <div class="point-group">
        <a class="select-point" value="">综合水质评价</a>
        <a value="W01001">PH值</a>
        <a value="W01009">溶解氧</a>
        <a value="W01019">高锰酸盐</a>
        <a value="W21003">氨氮</a>
        <a value="W21011">总磷</a>
        <a value="W21001">总氮</a>
        <#--<label-->
        <#--class="ant-radio-button-wrapper ant-radio-button-wrapper-checked"><span-->
        <#--class="ant-radio-button ant-radio-button-checked"><input-->
        <#--type="radio" class="ant-radio-button-input" value=""><span-->
        <#--class="ant-radio-button-inner"></span></span><span>综合水质评价</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W01001"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>PH值</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W01009"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>溶解氧</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W01019"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>高锰酸盐</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W21003"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>氨氮</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W21011"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>总磷</span></label> <label-->
        <#--class="ant-radio-button-wrapper"><span-->
        <#--class="ant-radio-button"><input type="radio"-->
        <#--class="ant-radio-button-input" value="W21001"><span-->
        <#--class="ant-radio-button-inner"></span></span><span>总氮</span></label>-->
    </div>
</div>

<!--  站点信息   -->
<#include "/moudles/enviromonit/water/monitorPointAnalysis.ftl"/>
<!--   排口    -->
<#include "/zphb/moudles/enviromonit/water/include/outfallAnalysis.ftl"/>
<!--   水库    -->
<#include "/moudles/enviromonit/water/reservoirAnalysis.ftl"/>
<!--   小流域    -->
<#include "/moudles/enviromonit/water/basinAnalysis.ftl"/>
<!--   污普废水企业    -->
<#include "/moudles/enviromonit/water/wpfsqyAnalysis.ftl"/>

<!-- 一河一策 -->
<div id="policyDlg" class="easyui-dialog" style="width: 800px; background: #ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width: 100%; height: 380px;">
            <div title="详细信息">
                <div class="panel-group-container">
                    <div class="panel-group-body">
                        <div class="panel-info">
                            <p style='font-size: 14px;' id="policyInfo"></p>
                        </div>
                        <div id="policyPdfView" style="padding-left: 15px; color: blue;"></div>
                    </div>
                </div>
            </div>
            <div title="污染源分析">
                <div class="data-analysis">
                    <div class="panel-info" style='font-size: 14px;'
                         id="policyAnalysis"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 小流域弹窗 没什么用 -->
<div id="xlyDlg" class="easyui-dialog" style="width: 800px; background: #ADADAD;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div class="easyui-tabs easyui-tabs-bg" style="width: 100%; height: 380px;">
            <div title="概况">
                <div class="panel-group-container">
                    <div class="panel-group-body">
                        <div class="panel-info">
                            <p style='font-size: 14px;' id="xlyInfo"></p>
                        </div>
                        <div id="xlyPdfView" style="padding-left: 15px; color: blue;"></div>
                    </div>
                </div>
            </div>
            <div title="详细信息">
                <div class="panel-group-container">
                    <div class="panel-group-body">
                        <div class="panel-info">
                            <p style='font-size: 14px;' id="xlyInfo"></p>
                        </div>
                        <div id="xlyPdfView" style="padding-left: 15px; color: blue;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 巡河弹窗 -->
<div id="patrolDlg" class="easyui-dialog" style="width:800px;height: 600px;padding: 20px 28px;"
     data-options="closed:true,modal:true,border:'thin'">
    <div style="margin-bottom:18px;color: #464646">
        <label class="control-label" style="font-size: 15px;">巡逻开始位置：</label><label id="positionB"
                                                                                    style="font-size: 15px"
                                                                                    class="control-label"></label>
    </div>
    <div style="margin-bottom:18px; color: #464646">
        <label class="control-label" style="font-size: 15px;">巡逻结束位置：</label><label id="positionE"
                                                                                    style="font-size: 15px"
                                                                                    class="control-label"></label>
    </div>
    <div style="margin-bottom:18px;color: #464646;overflow: hidden">
           <span style="width: 48%; float: left">
                <label class="control-label" style="font-size: 15px;">巡逻有效时长：</label><label id="timeEffect"
                                                                                            style="font-size: 15px"
                                                                                            class="control-label"></label>
           </span>

        <span style="width: 48%; float: left">
                 <label class="control-label" style=";font-size: 15px;">巡逻有效距离：</label><label id="distanceEffect"
                                                                                              style="font-size: 15px"
                                                                                              class="control-label"></label>
            </span>
    </div>
    <div style="margin-bottom:15px;color: #464646;overflow: hidden">
           <span style="width: 48%; float: left">
                <label class="control-label" style="font-size: 15px">所属流域：</label><label id="belongRiver"
                                                                                         style="font-size: 15px"
                                                                                         class="control-label"></label>
           </span>

        <span style="width: 48%; float: left">
                <label class="control-label" style="font-size: 15px">巡河时间：</label><label id="patrolTime"
                                                                                         style="font-size: 15px"
                                                                                         class="control-label"></label>
            </span>
    </div>

    <div style="margin-bottom:15px;color: #464646">
        <label class="control-label" style=";font-size: 15px;">随手拍：</label>
        <div style=" margin: 10px  30px 0 30px;position: relative;">
            <div class="swiper-container">
                <div class="swiper-wrapper" id="riverPatrolReportFiles">
                </div>

            </div>
            <!-- 如果需要导航按钮 -->
            <div class="swiper-button-prev"
                 style="background-image:none;left: -35px; background-color: #d4d4d4; "></div>
            <div class="swiper-button-next"
                 style="background-image:none;background-color: #d4d4d4;right: -35px; "></div>
        </div>
    </div>
    <div style="margin-bottom:18px;color: #464646">
        <div id="riverPatrolTrack" style="width: 100%;height: 300px;border: 1px solid #d7ddda;"></div>
    </div>
</div>


<!-- 附件弹窗-->
<div id="riverPatrolReportFileDialog" class="easyui-dialog" style="width:800px;height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <div class="modal-body" style="height:100%;">
        <div class="no-file-list">没有附件</div>
        <div id="bodyShow" style="height:100%;">
            <div class="gallerys" style="height:78%;"></div>
            <div class="picDetail-bottom"></div>
        </div>
    </div>
</div>

<!--  网格事件弹窗 -->
<div id="gridCaseDlg" class="easyui-dialog" data-options="closed:true,modal:true,border:'thin'">
    <table>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件编号：</div>
                    <div class="info-con" id="caseNumber"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">事件类型：</div>
                    <div class="info-con" id="caseTypeName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件来源：</div>
                    <div class="info-con" id="sourceName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">超时状态：</div>
                    <div class="info-con" id="overTimeStatusName"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">事件类型：</div>
                    <div class="info-con" id="majorTypeIdName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">事件小类：</div>
                    <div class="info-con" id="smallTypeIdName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">所属网格：</div>
                    <div class="info-con" id="departmentIdName"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">网格等级：</div>
                    <div class="info-con" id="userLevel"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group">
                    <div class="info-title">所属辖区：</div>
                    <div class="info-con" id="jurisdiction"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">状态：</div>
                    <div class="info-con" id="statusName"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group">
                    <div class="info-title">上报时间：</div>
                    <div class="info-con" id="reportFormatTime"></div>
                </div>
                <div class="detail-info-group">
                    <div class="info-title">上报人：</div>
                    <div class="info-con" id="createByName"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">事发位置：</div>
                    <div class="info-con" id="address"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">情况描述：</div>
                    <div class="info-con" id="describe"></div>
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>
                <div class="detail-info-group" style="width:100%;">
                    <div class="info-title">附件：</div>
                    <div class="info-con" id="waterCaseFiles"></div>
                </div>
            </td>
        </tr>
    </table>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width: 800px; height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd: auto; height: 99%;"
           controls="controls" preload>您的浏览器不支持 video 标签。
    </video>
</div>

<div class="list-item" style="">
    <div class="item  alone-item first-tag">
        <img src="/static/images/water/zzBasin.png"> <span>漳州流域</span>
    </div>
    <div class="item" value="0">
        <img src="/static/images/water/A350600_1001.png"> <span>鹿溪</span>
    </div>
    <div class="item" value="1">
        <img src="/static/images/water/A350600_1002.png"> <span>漳江</span>
    </div>
    <div class="item" value="2">
        <img src="/static/images/water/A350600_1003.png"><span>诏安东溪</span>
    </div>
    <div class="item" value="3">
        <img src="/static/images/water/A350600_1004.png"> <span>九龙江</span>
    </div>
    <div class="item" value="4">
        <img src="/static/images/water/A350600_1005.png"> <span>韩江(九峰溪)</span>
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
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/nationalSurfaceWater.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/water/passwordModify.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/monitorPointAnalysis.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/outfallAnalysis.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/reservoirAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/water/policy.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/basinAnalysis.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/wpfsqyAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/water/miniMonitor.js"></script>
<script type="text/javascript"
        src="${request.contextPath}/static/zphb/js/water/specialBasin.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/zpxAreaPolygons.js"></script>
<!-- 巡河相关js -->
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-ext.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-webservice.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-download.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/photoGallery/jquery.photo.gallery.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/water/patrol.js"></script>
<#-- 水系水脉相关 -->
<script type="text/javascript" src="${request.contextPath}/static/layer/layer.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/river/app-config.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/river/app.js"></script>
<!-- 网格事件js -->
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/water/waterCase.js"></script>

<script type="text/javascript">
    var markerMap = new HashMap();
    var pointsData = new Array(); //站点数组
    var selectedPointInfo = ""; //已选择站点信息
    var pointInfoWins = new Array(); //地图上显示的水质监测站点
    var pointLabels = new Array(); //地图上显示的水质监测站点
    var linesAndPolygons = new Array(); //线和面
    var polygons = null;
    var fivePolygons = null;
    var polygonsMap = new HashMap();
    $(function () {
        //=========设置表格分页==========//
        Ams.setPageDg('sewagePlantDg');
        Ams.setPageDg('outfallDg');
        Ams.setPageDg('wpfsqyDg');
        Ams.setPageDg('reservoirDg');
        Ams.setPageDg('miniMonitorDg');
        Ams.setPageDg('basinDg');
        Ams.setPageDg('patrolDg');
        //--------------------初始化地图对象-------------------------//
        var map = null;
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";

        function initMapSurfaceWater() {
            var longitude = "117.62";
            var latitude = "24.13";
            map = initMap({
                target: "mapDiv",
                center: [parseFloat(longitude), parseFloat(latitude)],
                //layers: fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
                layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
                zoom: 10.5,
                minZoom: 10.5
            });
            map.render();
            map.removeSelectInteraction();
            //加载漳浦县区域
            setZpxArea();

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
            $('div.basemap-toggle').find('.basemap').click(function () {
                // 已经选中则返回。
                if (!!$(this).attr("selected")) {
                    return;
                }
                var layerGroupName = $(this).attr("layer-group-name");
                $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index', 0);

                // 标记选中状态。
                $(this).attr("selected", "selected");
                //$(this).css("z-index", 10000);
                $(this).animate({
                    top: 0
                }, 200);
                collapse(0);
                // 显示当前底图。
                map.getLayers().forEach(function (layer, i) {
                    if (layer instanceof ol.layer.Group) {
                        layer.getLayers().forEach(function (sublayer, j) {
                            map.removeLayer(sublayer);
                        });
                    }
                });
                var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
                map.setLayerGroup(layerGroup);
                // 加载漳浦县区域
                setZpxArea();
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

        }

        initMapSurfaceWater();
        map.addLayer(fjzx.map.source.getZzRiverLayer());


        var waterPointCode = $("#waterPointCode").val();
        if (waterPointCode != "") {
            $.ajax({
                type: "post",
                url: "/zphb/enviromonit/water/nationalSurfaceWater/getListByPointCode",
                async: true,
                data: {
                    pointCode: waterPointCode
                },
                success: function (result) {
                    var data = result.data;
                    getMiniMonitor();
                    $("#miniMonitor").addClass("choiced");
                    map.setCenter(new fjzx.map.Point(parseFloat(data[0].lng), parseFloat(data[0].lat)));
                    openPointDlg(JSON.stringify(data[0]));
                    $("#miniMonitor").addClass("choiced");
                    addTab("微型水质自动站", "miniMonitor")
                },
                dataType: 'json'
            });
        }
        loadBasinData();
        //右下角缩略图点击事件
        $(".item").click(function (e) {
            var nub = $(".list-item .item").length //获取地域图片个数
            var index = $(this).index(); //获取当前索引值
            //选中项包含alone-item
            if ($(this).hasClass("alone-item")) {
                $(this).removeClass("alone-item")
                $(".list-item").css("width", "auto");
                for (var i = 0; i < 6; i++) {
                    $(".list-item .item").eq(i).show();
                }
            } else {
                for (var i = 0; i < nub; i++) {
                    if (i != index) {
                        $(".list-item .item").eq(i).hide();
                    } else {
                        $(".list-item .item").eq(i).show();
                        $(".list-item .item").eq(i).addClass("alone-item");
                    }
                }
            }
            if ($(this).hasClass("alone-item")) {
                var item_value = $(".alone-item").attr("value");
                if (item_value == null) {
                    if ($(this).hasClass("first-tag")) {
                        setSpecialBasin('');
                    }
                } else {
                    setSpecialBasin(item_value);
                }
            }
        })

        $("#Checkpoint-tag").click(function () {
            if ($('.point-group').width() <= 0) {
                $("#Checkpoint-tag").html("<span class=\"icon iconcustom icon-zhedie3\"></span> 因子列表")
                $('.point-group').animate({width: '132', opacity: '1'}, 200);
            } else {
                $("#Checkpoint-tag").html("<span class=\"icon iconcustom\"></span> 因子列表")
                $('.point-group').animate({width: '0', opacity: '0'}, 200);
            }
        })

        //监测点 点击事件
        $(".point-group").find("a").click(function () {
            $(".point-group").find("a").removeClass("select-point");
            $(this).addClass("select-point");
            setWaterMonitor();
        })

        //对比窗口
        $('body').on('click', '.select-button', function () {
            $(this).next().addClass('show');
        });
        $('body').on('click', '.btnSure', function () {
            searchWaterPointBar();
            $(this).parents(".select-panel").removeClass('show');
        });
        $('body').on('click', '.btnCancel', function () {
            $(this).parents(".select-panel").removeClass('show');
        });
        $('body').on('click', '.btnSure2', function () {
            searchConHourBar();
            $(this).parents(".select-panel").removeClass('show');
        });

        //自适应 添加scroll下拉
        $("#filterBox,#monitorListScroll,#outfallPltCodeListScroll,#outfallListScroll").mCustomScrollbar({
            theme: "light-3",
            scrollButtons: {
                enable: true
            }
        });

        //站点数据分析关闭事件
        $("#monitorDlg").dialog(
            {
                onClose: function () {
                    $(".select-panel").removeClass('show');
                    $("#polluteCodeList").children("span").removeClass(
                        "active");
                    $("#ph").addClass("active");
                    $("#timeList").children("span").removeClass(
                        "active");
                    $("#24h").addClass("active");
                }
            });

        //排口数据分析关闭事件
        $("#outfallDlg").dialog(
            {
                onClose: function () {
                    $(".select-panel").removeClass('show');
                    $("#outfallTimeList").children("span").removeClass(
                        "active");
                    $("#24hof").addClass("active");
                }
            });

        //水库数据分析关闭事件
        $("#reservoirDlg").dialog(
            {
                onClose: function () {
                    $(".select-panel").removeClass('show');
                    $("#reservoirTimeList").children("span")
                        .removeClass("active");
                    $("#30d").addClass("active");
                }
            });
        loadDeviceList();
    });


    $("input:radio").click(function (event) {
        $("label.ant-radio-button-wrapper-checked").removeClass(
            "ant-radio-button-wrapper-checked");
        $("span.ant-radio-button-checked").removeClass(
            "ant-radio-button-checked");
        $(this).parent().parent().addClass(
            "ant-radio-button-wrapper-checked");
        $(this).parent().addClass("ant-radio-button-checked");
        setWaterMonitor();
    });


    function setWaterMonitor() {
        var polluteCode = $(".point-group .select-point").attr("value");
        $.ajax({
            type: "post",
            url: "/zphb/enviromonit/water/nationalSurfaceWater/listNoPage",
            async: true,
            data: {
                polluteCode: polluteCode,
                category: "all"
            },
            success: function (result) {
                var data = result.data;
                for (var i = 0; i < data.length; i++) {
                    var color = "#b8b8b8";
                    if (data[i].quality == "Ⅰ"
                        || data[i].quality == "Ⅱ") {
                        color = "#2ba4e9";
                    } else if (data[i].quality == "Ⅲ") {
                        color = "#45b97c";
                    } else if (data[i].quality == "Ⅳ") {
                        color = "#FFFF00";
                    } else if (data[i].quality == "Ⅴ") {
                        color = "#f47920";
                    } else if (data[i].quality == "劣Ⅴ") {
                        color = "#d02032";
                    }

                    $("#monitor_" + data[i].mn).css("background", color);
                    $("#monitor_" + data[i].mn).html(data[i].value);
                    for (var j = 0; j < polygons.geoJSON.resultFeature.length; j++) {
                        if (polygons.geoJSON.resultFeature[j].getId() == "p_" + data[i].mn) {
                            polygons.geoJSON.resultFeature[j].set("color", color);
                        }
                    }
                }
            },
            error: function () {
            },
            complete: function () {
            },
            dataType: 'json'
        });

    }

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

    }

    /*显示一河一策*/
    function getPolicy() {
        if ($("#policy").hasClass('choiced')) {

            clearPolicy();
        } else {
            layPolicy(map);
        }
    }

    //点击页面中的设备检测区域下的数字进行页面跳转target目1标污水处理厂,2常规排口,3污普废水企业,4微型水质自动站,5小流域
    //从年数据表中跳转过来加载数据
    function loadDeviceList() {
        var target = $("#targetId").val();
        if (target == 1) {
            getPeMonitorPoints("type1")
            $("#sewagePlant").addClass("choiced");
            addTab("污水处理厂", "sewagePlant")
        } else if (target == 2) {
            getPeMonitorPoints("other")
            $("#outfall").addClass("choiced");
            addTab("常规排口", "outfall")
        } else if (target == 3) {
            getWpfsqy();
            $("#wpfsqy").addClass("choiced");
            addTab("工业废水企业", "wpfsqy")
        } else if (target == 4) {
            getMiniMonitor();
            $("#miniMonitor").addClass("choiced");
            addTab("微型水质自动站", "miniMonitor")
        } else if (target == 5) {
            getRiverBasin();
            $("#basin").addClass("choiced");
            addTab("小流域", "basin")
        } else if (target == 6) {
            getWaterCase();
            $("#gridCase").addClass("choiced");
            addTab("网格事件", "gridCase")
        }
    }

    //从年大屏展示数据跳转过来的现实小河流域数据
    function loadBasinData() {
        if (Ams.isNoEmpty($("#basinCode").val())) {
            $.ajax({
                type: "post",
                url: "/zphb/enviromonit/water/nationalSurfaceWater/getListByBasinCode",
                data: {
                    basinCode: $("#basinCode").val()
                },
                success: function (result) {
                    var data = result.data;
                    getRiverBasin();
                    $("#basin").addClass("choiced");
                    addTab("小流域", "basin")
                    map.setCenter(new fjzx.map.Point(parseFloat(data[0].lng), parseFloat(data[0].lat)));
                    openBasinDlg(JSON.stringify(data[0]))
                },
                dataType: 'json'
            });
        }
    }

    //右侧边栏 默认隐藏 搜索栏
    $(document).ready(function () {
        if ($(".choiced").length == 0) {
            $(".map-panel").find(".map-panel-body").css({"height": "190px", "overflow": "hidden"});
            var body_w = $('body').width();
            if (body_w < 1025) {
                $("#mCSB_1_container").css("width", "280px")
            } else {
                $("#mCSB_1_container").css("width", "auto");
            }
        }
    })

    $(window).resize(function () {
        //监听窗口变化
        var body_w = $('body').width();
        if (body_w < 1025) {
            $("#mCSB_1_container").css("width", "280px")
        } else {
            $("#mCSB_1_container").css("width", "auto");
        }
    });

    function loadGKRiver() {
        //加载国控流域
        $.ajax({
            type: "post",
            url: "/zphb/enviromonit/water/nationalSurfaceWater/listNoPage",
            data: {
                polluteCode: "",
                category: ""
            },
            success: function (result) {
                var data = result.data;

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
                            polygons = initDrawGeoLine(map, 'poly');
                            clickPloyAction(polygons);
                        }
                    }
                }
                polygons.load(poyjSONArr);
                //polygonsMap.put("p_"+data[i].mn,polygons.geoJSON.resultFeature);

            },
            error: function () {
            },
            complete: function () {
                loadDeviceList();
            },
            dataType: 'json'
        });
    }

    //点击marker 动画
    function animalMarker(markerId,x,y) {
        var myMarker = markerMap.get(markerId);
        var cycleObject = myMarker.cycleAnimal(x,y);
        cycleObject.startAnimal();
        cycleObject.setCycleTime(5);
    }
</script>
</body>
</html>
