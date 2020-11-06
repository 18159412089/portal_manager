<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳浦环保一张图</title>
    <!-- 基础 css -->
    <#include "/zphb/common/baseCss.ftl"/>
    <!-- 视频监控 -->
    <link rel="stylesheet" href="${request.contextPath}/static/ztree/css/zTreeStyle/zTreeStyle.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/cameraBase.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/index.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/preview.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/video.css"/>

    <!-- 地图相关 -->
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>

    <!-- 自定义 css（开发开发自己加的css一定要在自定义css之前）-->
    <#include "/zphb/common/customBaseCss.ftl"/>
    <!-- old css -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
    <!-- 主题 css -->
    <#include "/zphb/common/zpThemeCss.ftl"/>
    <!-- js 在底部 -->
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/zphb/common/header.ftl"/>
<div id="pf-md">
    <div class="map-container">
        <div class="map-wrapper">
            <div id="mapDiv"></div>
        </div>
        <!-- 地图层  -->
        <!-- 视频列表层  -->
        <div class="map-videolist-container">
            <div id='fjzx-camera' class="map-videolist"></div>
        </div>
        <!--案件列表-->
        <div class="map-caselist-container">
            <div class="btn-collapse active" data-toggle="shown" data-target=".map-caselist-container">
                <span class="icon fa-angle-left"></span>
            </div>
            <div class="map-toolbar-container">
                <div id="switchView" class="btn-map" data-toggle="shown" data-target=".map-videolist-container">
                    <span class="toggle-vide"><span class="icon iconcustom icon-shipin4"></span>视频切换</span>
                    <span class="toggle-map"><span class="icon iconcustom icon-dingwei6"></span>地图切换</span>
                </div>
            </div>
            <div class="map-case-list-box">
                <div class="map-case-list enterpriseList">
                    <div class="map-contaminated-title">
                       <#-- <p id ="timeTile">截止2019年09月09日共排查2230个</p>-->
                    </div>
                    <div  class="searchbox-item">
                        <input id="searchPollutionEnterprise" class="easyui-searchbox" style="width:100%;line-height: 36px;height: 36px;"/>
                    </div>
                    <div class="panel-collapse-container">
                        <!--面板主内容-->
                        <ul class="panel-collapse">
                            <li class="panel-collapse-item mineListContainer">
                                <div class="panel-collapse-header collapsed">
                                    <span class="title">矿山污染源</span><span class="highlight total">0个</span>
                                </div>
                                <div class="panel-collapse-body" style="display: none;">
                                    <div id="mineList" class="datagrid-list"></div>
                                </div>
                            </li>
                            <li class="panel-collapse-item farmListContainer">
                                <#--<div class="panel-collapse-header collapsed">-->
                                <div class="panel-collapse-header collapsed">
                                    <span class="title">农业养殖污染源</span><span class="highlight total">0个</span>
                                </div>
                                <#--<div class="panel-collapse-body" style="display: none;">-->
                                <div class="panel-collapse-body" style="display: none;">
                                    <div id="farmList" class="datagrid-list"></div>
                                </div>
                            </li>
                            <li class="panel-collapse-item rubbishListContainer">
                                <#--<div class="panel-collapse-header collapsed">-->
                                <div class="panel-collapse-header collapsed">
                                    <span class="title">垃圾中转站</span><span class="highlight total">0个</span>
                                </div>
                                <#--<div class="panel-collapse-body" style="display: none;">-->
                                <div class="panel-collapse-body" style="display: none;">
                                    <div id="rubbishList" class="datagrid-list"></div>
                                </div>
                            </li>
                            <li class="panel-collapse-item DqListContainer">
                                <#--<div class="panel-collapse-header collapsed">-->
                                <div class="panel-collapse-header collapsed">
                                    <span class="title">大气污染源</span><span class="highlight total">0个</span>
                                </div>
                                <#--<div class="panel-collapse-body" style="display: none;">-->
                                <div class="panel-collapse-body" style="display: none;">
                                    <div id="DqList" class="datagrid-list"></div>
                                </div>
                            </li>
                            <li class="panel-collapse-item SListContainer">
                                <#--<div class="panel-collapse-header collapsed">-->
                                <div class="panel-collapse-header collapsed">
                                    <span class="title">水污染源</span><span class="highlight total">0个</span>
                                </div>
                                <#--<div class="panel-collapse-body" style="display: none;">-->
                                <div class="panel-collapse-body" style="display: none;">
                                    <div id="SList" class="datagrid-list"></div>
                                </div>
                            </li>
                        </ul>
                        <!--面板主内容 over-->
                    </div>
                </div>
                <div class="map-case-list cameraList hide">
                    <div class="camera-ztree-container">
                        <!--面板主内容-->
                        <ul id="treeDemo" class="ztree"></ul>
                        <!--面板主内容 over-->
                    </div>
                    <#--云台控制器-->
                    <div id="camera-control"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "/zphb/zpCameraMapPollutionDetail.ftl">
<!-- 数据分析和详细信息窗口 -->
<#include "/moudles/enviromonit/air/airAnalysis.ftl"/>
<!-- 废弃排口窗口 -->
<#include "/moudles/enviromonit/air/enterpriseAnalysis.ftl"/>
<!-- 废弃排口窗口 -->
<#include "/moudles/enviromonit/air/enterpriseAnalysis.ftl"/>
</body>
<!-- 基础的js-->
<#include "/zphb/common/baseJs.ftl"/>
<!----------------------- 开发 js ---------------------->
<!-- 地图相关 -->
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<#-- 视频监控 -->
<script src="${request.contextPath}/static/ztree/js/jquery.ztree.core.js"></script>
<script src="${request.contextPath}/static/camera-zp/js/slplayer.js"></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera-config.js'></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera.js'></script>
<!-- 大气站点 -->
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/zpxAreaPolygons.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/airAnalysis.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/zphb/js/air/enterpriseAnalysis.js"></script>
<!-- 页面 js -->
<script src='${request.contextPath}/static/js/moudles/zp/zpCameraMap.js'></script>
<style>div.pagination-info{display:none}</style>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });

    };
    $(window).resize(function() {
        //初始样式
        if($(window).width()>1200){
            $(".map-caselist-container").addClass("show");
        }else {
            $(".map-caselist-container").removeClass("show");
        }
    });
    function searchTextEnterpriseName(enterpriseName){
        $('#zpPollutionLicensedMine').datagrid('load', {
            name : enterpriseName
        });
        $('#zpfarmList').datagrid('load', {
            name :enterpriseName
        });
        $('#zprubbishList').datagrid('load', {
            name :enterpriseName
        });
        $('#zpDqList').datagrid('load', {
            lx: '大气',
            qx: '漳浦县',
            mc :enterpriseName
        });
        $('#zpSList').datagrid('load', {
            lx: '水',
            qx: '漳浦县',
            mc :enterpriseName
        });
    }
    $(function () {
        //初始样式
        if($(window).width()>1200){
            $(".map-caselist-container").addClass("show");
        }else {
            $(".map-caselist-container").removeClass("show");
        }

        //多选
        $('body').on('click','.select-button',function () {
            var $target=$(this).next();
            $target.addClass('show');
            $target.on("change.selectAll",".all",function () {
                if($(this).prop("checked")){
                    $target.find('input[name='+$(this).prop("name")+']').prop("checked",true);
                }else{
                    $target.find('input[name='+$(this).prop("name")+']').prop("checked",false);
                }

            });
        });
        //搜索框
        $('#searchPollutionEnterprise').textbox({
            prompt:'请输入企业名称',
            icons: [{
                iconCls:'icon iconcustom icon-shanchu3',
                handler: function(e){
                    $(e.data.target).textbox('clear');
                    searchTextEnterpriseName($(e.data.target).textbox("getText"));
                }
            },{
                iconCls:'icon iconcustom icon-chaxun1',
                handler: function(e){
                     searchTextEnterpriseName($(e.data.target).textbox("getText"));
                }
            }],
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keyup: function (e) {
                    if (event.keyCode == 13) {
                        searchTextEnterpriseName($(e.data.target).textbox("getText"));
                    }
                }
            })
        });
        //地图与视频视图切换按钮
        $('#switchView').click(function () {
            if($(this).hasClass('active')){
                $('.enterpriseList').removeClass('hide');
                $('.cameraList').addClass('hide');
                $(".map-caselist-container .btn-collapse").removeClass('hide');
            }else{
                $('.enterpriseList').addClass('hide');
                $('.cameraList').removeClass('hide');
                $('#cameraSeach').searchbox('resize');
                $(".map-caselist-container .btn-collapse").addClass('hide');
            }
        });

        //初始化视频监控预览窗口
        var camera = new fjzx.camera.Camera({
            "elementId": "fjzx-camera",
            "playerCount": 2
        });
        //初始化预览窗口播放器
        camera.initPlayers();
        //初始化预览窗口工具
        camera.initWinControl();
        //初始化云台控制组件
        camera.initPTZControl('camera-control');

        //初始化视频监控通道树列表
        var cameraTree = new fjzx.camera.CameraTree({
            "elementId":"treeDemo",
            "onClick": function(treeNode){
                if(treeNode.nodeType=='channel'){
                    var chanid = treeNode.id;
                    var opt = {
                        chanid: chanid,
                        name: treeNode.name
                    }
                    camera.startView(opt);
                }
            }
        });
    });
</script>

</html>
