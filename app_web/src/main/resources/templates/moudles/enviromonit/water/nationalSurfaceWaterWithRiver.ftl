<#ftl attributes={"content_type":"text/html;charset=UTF-8"}> <#assign
sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>水环境服务</title>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudBlack.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/mainMap.css"/>
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

    <#--水系图层相关-->
    <link rel="stylesheet" href="${request.contextPath}/static/river/app.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/layer/theme/default/layer.css"/>

    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/photoswipe.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/photoswipe/4.1.3/default-skin/default-skin.min.css" rel="stylesheet">


</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>


<#--<#include "/toolbar.ftl">-->
<#include "/waterEnvironmentMenu.ftl">
<#--<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/swiper.min.css"></link>
<script src="${request.contextPath}/static/js/swiper.min.js"></script>-->



<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>

<div class="container oh"
     style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px;">
    <!-- main -->
    <div id="mapDiv" class="map-wrapper" style="position: fixed; bottom: 0;"></div>
    <!-- 地图层 -->

    <!-- 图例  -->
    <div class="map-legend-container"
         style="z-index: 998; position: absolute; bottom: 0px; left: 0px;">
        <div class="grade-legend">
            <div class="legend" style="width: 400px; color: #fff">
                <span class="item water_excellent"></span>Ⅰ <span
                    class="item water_good"></span>Ⅱ <span class="item water_mild"></span>Ⅲ
                <span class="item water_moderate"></span>Ⅳ <span
                    class="item water_severe"></span>Ⅴ <span
                    class="item water_dangerous"></span>劣Ⅴ <span class="item"></span>未知
            </div>
        </div>
    </div>

    <div class="map-panel"
         style="z-index: 998; position: absolute; top: 86px; right: 58px;">
        <div class="map-panel-header">
			<span class="title">
                   <span class="icon iconcustom icon-zhedie3"></span> 图层控制
			</span>
        </div>
        <!-- <div class="map-panel-body" style="height: 540px; width:400px;position: relative;background: none;">
             <div class="body-box" id="filterBox" style="width:330px;height:150px;margin-left:80px; border-bottom: 1px solid #fff;border-color: rgba(255,255,255,0.15);"> -->
        <div class="map-panel-body" style="height: 550px; width: 440px; position: relative; background: none;">
            <div class="body-box" id="filterBox"
                 style="width: 330px; height: 180px; margin-left: 120px; border-bottom: 1px solid #fff; border-color: rgba(255, 255, 255, 0.15);">
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
                            <div class="change-line no-choice" title="污普废水企业" id="wpfsqy"
                                 style="width: 120px" onclick="getWpfsqy()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/water/wpfsqy.png"/>污普废水企业
                            </div>
                            <div class="change-line no-choice" title="水库" id="reservoir"
                                 style="width: 100px" onclick="getReservoirPoints('reservoir')">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/reservoir.png"/>水库
                            </div>
                            <div class="change-line no-choice" title="微型水质自动站"
                                 id="miniMonitor" style="width: 120px;"
                                 onclick="getMiniMonitor()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/reservoir.png"/>微型水质自动站
                            </div>
                            <div class="change-line no-choice" title="小流域" id="basin"
                                 style="width: 100px;" onclick="getBasin()">
                                <img style="height: 20px; width: 20px; float: left"
                                     src="/static/images/min-basin.png"/>小流域
                            </div>
                            <div class="change-line no-choice" title="巡河" id="patrol"
                                 style="width: 120px;" onclick="getPatrol()">
                                <img style="height: 20px; width: 20px; float: left" src="/static/images/patrol.png"/>巡河
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tabs-content" style="width:320px;margin-left:120px; top: 180px;">
                <div class="body-box" id="mapTabs_sewagePlant"
                     url="/enviromonit/water/nationalSurfaceWater/getPeMonitorPointsList?peType=type1">                     
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="sewagePlantToolbar">
                                <div class="search-box">
                                    <input id="peName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="sewagePlantSearch()"></a>
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
                    url="/enviromonit/water/nationalSurfaceWater/getPeMonitorPointsList?peType=other">                      
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="outfallToolbar">
                                <div class="search-box">
                                    <input id="outfallNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="outfallSearch()"></a>
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
                <div class="body-box" id="mapTabs_wpfsqy" url="/enviromonit/water/nationalSurfaceWater/getWpfsqyList">                      
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="wpfsqyToolbar">
                                <div class="search-box">
                                    <input id="queryWpfsqyName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="wpfsqySearch()"></a>
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
                <div class="body-box" id="mapTabs_reservoir" url="/enviromonit/water/nationalSurfaceWater/getReservoirPointsList">                      
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="reservoirToolbar">
                                <div class="search-box">
                                    <input id="reservoirNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="reservoirSearch()"></a>
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
                <div class="body-box" id="mapTabs_miniMonitor" url="/enviromonit/water/nationalSurfaceWater/getMiniMonitorList">                        
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="miniMonitorToolbar">
                                <div class="search-box">
                                    <input id="pointNameQuery" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="miniMonitorSearch()"></a>
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
                <div class="body-box" id="mapTabs_basin" url="/enviromonit/water/nationalSurfaceWater/getBasinMonitorList">                     
                    <div class="theme-container">
                        <div class="theme-title">筛选</div>
                        <div class="theme-content">
                            <div class="search-container" id="basinToolbar">
                                <div class="search-box">
                                    <input id="monitorName" class="easyui-textbox" style="width:100%;"/>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="basinSearch()"></a>
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
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="patrolSearch()"></a>
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
            </div>
            <ul class="tabs-panel" style="top: 180px; margin-right: -120px;">
                <!-- <li class="tabs-item"><a class="tabs-inner active" data-target="#mapTabs_tabs1">污普废水企业</a></li> -->
            </ul>
        </div>
    </div>

</div>

<div id="mapgroup" class="_3dsy dsy-box">
    <span class="point-tag" id="Checkpoint-tag">
        <span class="icon iconcustom icon-zhedie3"></span>
        监测点</span>
    <div class="point-group">
        <a class="select-point" value="">综合水质评价</a>
        <a value="W01001">PH值</a>
        <a value="W01009">溶解氧</a>
        <a value="W01019">高锰酸盐</a>
        <a value="W21003">氨氮</a>
        <a value="W21011">总磷</a>
        <a value="W21001">总氮</a>
    </div>
</div>

<!--
<div id="monitorDlg2" class="easyui-dialog" style="width:900px;background:#ADADAD;"
 data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
<div class="map-panel">
    <div class="easyui-tabs easyui-tabs-bg" style="width:100%;height:500px;">
        <div title="详细信息" selected="true">
            <div class="panel-group-container">
                   <div class="panel-group-top"> <span id="pointName2"></span>
                   </div>
                   <div class="panel-group-body">
                       <div class="panel-info" id="pointInfo2">
                    </div>
                   </div>
               </div>
        </div>
    </div>
</div>
</div>
-->
<!--  站点信息   -->
<#include "/moudles/enviromonit/water/monitorPointAnalysis.ftl"/>
<!--   排口    -->
<#include "/moudles/enviromonit/water/outfallAnalysis.ftl"/>
<!--   水库    -->
<#include "/moudles/enviromonit/water/reservoirAnalysis.ftl"/>
<!--   小流域    -->
<#include "/moudles/enviromonit/water/basinAnalysis.ftl"/>
<!--   污普废水企业    -->
<#include "/moudles/enviromonit/water/wpfsqyAnalysis.ftl"/>

<!--   一河一策      -->
<div id="policyDlg" class="easyui-dialog"
     style="width: 800px; background: #ADADAD;"
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

<!--   小流域弹窗  没什么用      -->
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
<!--  巡河弹窗 -->
<div id="patrolDlg" class="easyui-dialog" style="width:800px;height: 600px;padding: 20px 28px;"
     data-options="closed:true,modal:true,border:'thin'">
    <div style="margin-bottom:18px;color: #464646">
        <label class="control-label" style="font-size: 15px;">巡逻开始位置：</label><label id="positionB" style="font-size: 15px" class="control-label"></label>
    </div>
    <div style="margin-bottom:18px; color: #464646">
        <label class="control-label" style="font-size: 15px;">巡逻结束位置：</label><label id="positionE" style="font-size: 15px" class="control-label"></label>
    </div>
    <div style="margin-bottom:18px;color: #464646;overflow: hidden">
       <span  style="width: 48%; float: left">
            <label class="control-label" style="font-size: 15px;">巡逻有效时长：</label><label id="timeEffect" style="font-size: 15px" class="control-label"></label>
       </span>

        <span style="width: 48%; float: left">
             <label class="control-label" style=";font-size: 15px;">巡逻有效距离：</label><label id="distanceEffect" style="font-size: 15px" class="control-label"></label>
        </span>
    </div>
    <div style="margin-bottom:15px;color: #464646;overflow: hidden">
       <span style="width: 48%; float: left">
            <label class="control-label" style="font-size: 15px">所属流域：</label><label id="belongRiver" style="font-size: 15px" class="control-label"></label>
       </span>

        <span style="width: 48%; float: left">
            <label class="control-label" style="font-size: 15px">巡河时间：</label><label id="patrolTime" style="font-size: 15px" class="control-label"></label>
        </span>
    </div>

    <div style="margin-bottom:15px;color: #464646">
        <label class="control-label" style=";font-size: 15px;">随手拍：</label>
        <div style=" margin: 10px  30px 0 30px;position: relative;">
            <div class="swiper-container" >
                <div class="swiper-wrapper" id="riverPatrolReportFiles">
                </div>

            </div>
            <!-- 如果需要导航按钮 -->
            <div class="swiper-button-prev" style="background-image:none;left: -35px; background-color: #d4d4d4; "></div>
            <div class="swiper-button-next" style="background-image:none;background-color: #d4d4d4;right: -35px; "></div>
        </div>
    </div>
    <div style="margin-bottom:18px;color: #464646">
        <div id="riverPatrolTrack" style="width: 100%;height: 300px;border: 1px solid #d7ddda;"></div>
    </div>
</div>

<!-- 附件弹窗-->
<div id="riverPatrolReportFileDialog" class="easyui-dialog"
     style="width: 800px; height: 500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'"
<div class="modal-body" style="height:600px;max-height:none;">
    <div class="no-file-list">没有附件</div>
    <div id="bodyShow">
        <div class="gallerys" style="height:78%;"></div>
        <div class="picDetail-bottom"></div>
    </div>
</div>
</div>

<!--  巡河弹窗 -->
<#--<div id="patrolDlg" class="show-basin-box" >
    <div class="center-wrap">
        <div class="title-haed">
             <span id="titleId"> 九龙江流域 </span>
             <a class="close-tag"></a>
        </div>
        <div class="info-box">
            <div class="text-row">
                <label class="control-label">巡逻开始位置：</label>
                <label id="positionB" class="control-label"> 福建省厦门市思明区软件园二期35号</label>
            </div>
            <div class="text-row">
                <label class="control-label">巡逻结束位置：</label>
                <label id="positionE" class="control-label">1小时0分钟0秒</label>
            </div>
            <div class="text-row">
       <span>
            <label class="control-label">巡逻有效时长：</label>
            <label id="timeEffect" class="control-label">1小时0分钟0秒</label>
       </span>
                <span>
             <label class="control-label">巡逻有效距离：</label>
             <label id="distanceEffect"  class="control-label">1小时0分钟0秒</label>
        </span>
            </div>
            <div class="text-row">
       <span>
           <label class="control-label">所属流域：</label>
           <label id="belongRiver" class="control-label">1小时0分钟0秒</label>
       </span>
                <span>
                 <label class="control-label">巡河时间：</label>
                 <label id="patrolTime" class="control-label">1小时0分钟0秒</label>
        </span>
            </div>
            <h5 ><span>随手拍：</span></h5>

            <div class="swiper-img-box">
       &lt;#&ndash;         <div class="switch-tag">
                    <a></a>
                </div>
                <div class="switch-tag">
                    <a></a>
                </div>&ndash;&gt;
                <div class="swiper-container swiper-container-initialized swiper-container-horizontal" style="width: 84%;margin: 0 48px;box-sizing: border-box; display: inline-block;position: initial">
                    <div id="ssp" class="swiper-wrapper"></div>
                    <div class="swiper-button-prev" style="height: 90px;width: 34px;margin-top: -55px;background-size: 14px 30px;left: 0; top: 55px; background-color: #a2dcbd;background-image: none"></div><!--左箭头。如果放置在swiper-container外面，需要自定义样式。&ndash;&gt;
                    <div class="swiper-button-next" style="height: 90px;width: 34px;margin-top: -55px;background-size: 14px 30px;right: 0;top: 55px; background-color: #a2dcbd;background-image: none"></div><!--右箭头。如果放置在swiper-container外面，需要自定义样式。&ndash;&gt;

            </div>

        </div>
            <p><a>查看更多</a></p>


    </div>
        <!-- 查看大图-begin &ndash;&gt;
        <div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="pswp__bg" style="opacity: .8 !important;"></div>
            <div class="pswp__scroll-wrap">
                <div class="pswp__container">
                    <div class="pswp__item"></div>


                    <div class="pswp__item"></div>
                    <div class="pswp__item"></div>
                </div>
                <div class="pswp__ui pswp__ui--hidden">

                    <div class="pswp__top-bar">

                        <div class="pswp__counter"></div>

                        <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                        <!-- <button class="pswp__button pswp__button--share" title="Share"></button> &ndash;&gt;

                        <!-- <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                        <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button> &ndash;&gt;

                        <div class="pswp__preloader">
                            <div class="pswp__preloader__icn">
                                <div class="pswp__preloader__cut">
                                    <div class="pswp__preloader__donut"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                        <div class="pswp__share-tooltip"></div>
                    </div>

                    <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
                    </button>

                    <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
                    </button>

                    <div class="pswp__caption">
                        <div class="pswp__caption__center"></div>
                    </div>

                </div>

            </div>

        </div>
        <!-- 查看大图-end &ndash;&gt;
</div>-->

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width: 800px; height: 500px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
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
            index:index // 当前播放的图片索引
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
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/nationalSurfaceWater.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/passwordModify.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/monitorPointAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/outfallAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/reservoirAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/policy.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/basinAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/wpfsqyAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/miniMonitor.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/specialBasin.js"></script>
<!-- 巡河相关js -->
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-ext.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-webservice.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/fjzx-jquery-download.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/photoGallery/jquery.photo.gallery.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/water/patrol.js"></script>
<#-- 水系水脉相关 -->
<script type="text/javascript" src="${request.contextPath}/static/layer/layer.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/river/app-config.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/river/app.js"></script>
<script>
    var pointsData = new Array(); //站点数组
    var selectedPointInfo = ""; //已选择站点信息
    var pointInfoWins = new Array(); //地图上显示的水质监测站点
    var pointLabels = new Array(); //地图上显示的水质监测站点
    var linesAndPolygons = new Array(); //线和面
    var polygons = null;
    var polygonsMap = new HashMap();
    var sBasin = "";
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

        function initMapSurfaceWater() {
            var longitude = "117.65";
            var latitude = "24.52";
            map = initMap({
                target: "mapDiv",
                center: [parseFloat(longitude), parseFloat(latitude)],
                layers: fjzx.map.source.getLayerGroupByMapType("ZZ_RIVER_MAP"),//使用与水系图层相匹配的行政区划底图（该底图颜色单一，避免影响水系图层的显示）
                zoom: 10
            });
            map.render();

            //引入水系图层
            new fjzx.map.river.app(window, jQuery, ol, layer,map);
        }

        initMapSurfaceWater();
        /*
        var config = {
                request:"GetTile",
                service:"WMTS",
                version: "1.0.0",	//请求服务的版本
                layers: "zzvec",
                transparent: true,	//输出图像背景是否透明
                styles: "default",			//每个请求图层的用","分隔的描述样式
                format: "image/png",	//输出图像的类型
                srs: "EPSG:4326",
                TileMatrixSet:"WholeWorld_CRS_84"
        };
        var wmsLayer = new T.TileLayer.WMS("http://140.237.73.123:9058/stifs/maps.do?service=WMTS", config);
        map.addLayer(wmsLayer);
         */
        map.addLayer(fjzx.map.source.getZzRiverLayer());
        $
                .ajax({
                    type: "post",
                    url: "/enviromonit/water/nationalSurfaceWater/listNoPage",
                    async: true,
                    data: {
                        polluteCode: "",
                        category: ""
                    },
                    success: function (result) {
                        var data = result.data;
                        //加入5条特殊流域
                        data.push.apply(data, data2);

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

                            //var marker = new T.Marker(new T.LngLat(data[i].lng, data[i].lat), {icon : icon});
                            //map.addOverLay(marker);
                            //创建信息窗口对象
                            /* var infoWin = new T.InfoWindow(
                                    "<div style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;"
                                    +"background-color:"+color+"' onclick='openPointDlg(JSON.stringify(pointsData["+i+"]))'>"+data[i].value+"</div>"
                                ,{closeButton:false,minWidth:30})
                            infoWin.setLngLat(new T.LngLat(data[i].lng, data[i].lat));
                            //向地图上添加信息窗口
                            map.addOverLay(infoWin); */
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
                            if(data[i].mark == 0){
                                clickDiv ="<p style='font-weight:bold;'>"+ data[i].mnname + "</p></div>";
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
                            /* if(data[i].lines != ""){
                                var points=[];
                                var arr = data[i].lines.split(',');
                                for(var j=0;j<arr.length;j=j+2){
                                    var arr2 = arr[j].split(',');
                                    points.push(new T.LngLat(arr2[0],arr2[1]));
                                }
                                //创建线对象
                                var line = new T.Polyline(points,{color: color});
                                //向地图上添加线
                                map.addOverLay(line);
                                linesAndPolygons[i] = line;
                            }   */
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
                                    clickAction(polygons);
                                }

                            }
                        }
                        polygons.load(poyjSONArr);
                        //polygonsMap.put("p_"+data[i].mn,polygons.geoJSON.resultFeature);
                    },
                    error: function () {
                    },
                    dataType: 'json'
                });
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
            var i = $(".alone-item").attr("value");
            if (i == null) {
                if (sBasin != "") {
                    if ($(this).hasClass("first-tag")) {
                        data2[sBasin].mark = 0;
                        setSpecialBasin(sBasin);
                    }
                }
            } else {
                sBasin = i;
                data2[i].mark = 1;
                setSpecialBasin(i);
            }
        })

        $("#Checkpoint-tag").click(function () {
            if ($('.point-group').width() <= 0)
            {
                $("#Checkpoint-tag").html("<span class=\"icon iconcustom icon-zhedie3\"></span> 监测点")
                $('.point-group').animate({width: '132',opacity:'1'}, 200);
            }
            else
            {
               $("#Checkpoint-tag").html("<span class=\"icon iconcustom\"></span> 监测点")
                $('.point-group').animate({width: '0',opacity:'0'}, 200);
            }

        })


        //监测点 点击事件
        $(".point-group") .find("a").click(function () {
            $(".point-group").find("a").removeClass("select-point")
            $(this).addClass("select-point")
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
        $(
                "#filterBox,#monitorListScroll,#outfallPltCodeListScroll,#outfallListScroll")
                .mCustomScrollbar({
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

    });
    $("input:radio").click(
            function (event) {
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
        var polluteCode = $("span.ant-radio-button-checked input").val();
        $
                .ajax({
                    type: "post",
                    url: "/enviromonit/water/nationalSurfaceWater/listNoPage",
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

                            $("#monitor_" + data[i].mn).css("background",
                                    color);
                            $("#monitor_" + data[i].mn).html(data[i].value);
                            for (var j = 0; j < polygons.geoJSON.resultFeature.length; j++) {
                                if (polygons.geoJSON.resultFeature[j]
                                                .getId() == "p_" + data[i].mn) {
                                    polygons.geoJSON.resultFeature[j].set(
                                            "color", color);
                                }
                            }

                            //if(polygonsMap.get("p_"+data[i].mn)!=null){
                            //	polygonsMap.get("p_"+data[i].mn).set("color",color);
                            //}
                        }
                    },
                    error: function () {
                    },
                    dataType: 'json'
                });

    }

    function openPointDlg(info) {

        info = JSON.parse(info)
        selectedPointInfo = info;
        //if(info.category == 3){
        //	getMnPointInfo2(info);
        //	$('#monitorDlg2').dialog('open').dialog('center').dialog('setTitle','断面详情');
        //}else{
        searchWaterPointBar();
        addOtherPoints();
        getMnPointInfo(info);
        addMoreData();
        $('#monitorDlg').dialog('open').dialog('center').dialog('setTitle',
                '断面详情与分析');
        //getFactorCount();
        //}
    }

    //巡河弹窗
    /*function openPatrolPointDlg(info, ids) {
        $('#patrolDlg').show();
        $('#titleId').html(info.riverName);
        $('#positionB').html(info.startPosition);
        $('#positionE').html(info.endPosition);
        $('#timeEffect').html(Math.floor(info.duration / 3600) + "时" + Math.floor((info.duration % 3600) / 60) + "分" + info.duration % 60 + "秒");
        $('#distanceEffect').html(info.distance + '米');
        $('#belongRiver').html(info.riverName);
        $('#patrolTime').html(Ams.timeDateFormat(info.startTime));
        var html = '';
        var div = document.getElementById('ssp');
        for (var i = 0; i < ids.length; i++) {
            var imgArray = {
                src: 'https://140.237.73.123:9041/EpaProblemProcessing/do.clientdownload?uploadDownloadControllerId=clientFileUpload&fileId=' + ids[i].id ,
                w: 600,
                h: 400
            }
            items.push(imgArray);
            html+= '<div class="swiper-slide swiper-slide-next stop-swiping" >'+
                    '<a style="display: inline-block; width: 100%;height: 92px;background-color: #EFEFEF;border-radius: 5px;margin-right: 10px">'+
                    '<img onclick="onPlay('+i+')" src="https://140.237.73.123:9041/EpaProblemProcessing/do.clientdownload?uploadDownloadControllerId=clientFileUpload&fileId=' + ids[i].id + '"  style="width: 100%;height: 100%" >'+
                    '</a>'+
                    '</div>'
        }

        div.innerHTML = html;
        var swiper = new Swiper('.swiper-container', {
            slidesPerView: 3.5,
            spaceBetween: 10,
            freenode:true,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
                noSwiping : true,
                noSwipingClass : 'stop-swiping',
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    }*/


    /*function policySearch() {
        $('#policyDg').datagrid('load', {
            name: $("#queryPolicyName").val().trim()
        });
    }*/
    /*显示一河一策*/
    function getPolicy() {
        if ($("#policy").hasClass('choiced')) {
            //map.centerAndZoom(new T.LngLat(117.5328, 24.5653), 9);
            //$("#queryPolicyName").textbox('setValue', '');
            clearPolicy();
        } else {
            //map.centerAndZoom(new T.LngLat(117.62272, 24.5441), 12);
            layPolicy(map);
        }

    }

    //  排口窗口双击事件
    /*$("#outfallDg").datagrid({
        onDblClickRow: function (index, row) {
            if(row.longValue != null && row.latValue != null) {
                map.centerAndZoom(new T.LngLat(row.longValue,row.latValue), 15 );
            } else {
                $('#outfallDlg').dialog('open').dialog('center').dialog('setTitle','企业详情与分析');
                selectedOutfallInfo = row;
                searchOutfallFactors(row.peId);
                addOtherOutfall(row.peId);
                getOutfallInfo(row.peId);
            }

        }
    });*/

    //流域窗口双击事件
    /*$("#policyDg").datagrid({
        onDblClickRow: function (index, row) {
            $("#policyInfo").html(row.remark);
            $("#policyAnalysis").html(row.analysis);
            $('#policyDlg').dialog('open').dialog('center').dialog('setTitle','河流详情与分析');
        }
    });
     */
</script>



</body>

</html>