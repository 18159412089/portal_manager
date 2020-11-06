<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>市直查污染源</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/yl.css"/>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"/>
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
</head>
<!-- body -->
<body class="pollution-body alone-pollution">
<#--<#include "/secondToolbar.ftl">-->
<#include "/common/loadingDiv.ftl"/>

<#include "/secondToolbar2.ftl">
<style>
    #pf-hd {
        height: 62px;
    }

    #pf-hd .pf-logo {
        line-height: 62px;
    }

    .nav-container .nav-box > ul > li {
        height: 62px;
    }

    .nav-container .nav-box > ul .select-link a {
        line-height: 62px;
    }

    .nav-container .nav-box > ul > li > a {
        line-height: 62px;
    }

    .nav-container .nav-menu-tag a {
        margin-top: 3px;
    }

    #pf-hd .pf-user {
        height: 62px;
        line-height: 62px;
    }

    #pf-hd .pf-user .pf-user-panel {
        top: 62px;
    }

    .nav-container .nav-box {
        height: 62px;
    }

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
                </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul" id="pollutionTypeList">
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>插值分析</span> <i></i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="map-describe-part">
                                    <p id="analysis">
                                        <i>截止9月0日</i>，市直各相关部门共排查填报污染源 <i>322</i>个。其中：生态环境局<i>22</i>个、
                                        住建局<i>10</i>个，城管局<i>6</i>个、水利局<i>6</i>个、农业农村局<i>6</i>个、海洋渔业局各<i>6</i>个，
                                        林业局<i>5</i>个、自然资源局<i>4</i>个、工信局<i>2</i>个，商务局<i>2</i>个、应急局<i>2</i>个，
                                        公安局<i>1</i>个、交警支队<i>1</i>个、卫健委<i>1</i>个、文旅局<i>1</i>个、交通局<i>1</i>个、
                                        厦门港港航协调中心<i>1</i>个、漳州市海事局<i>1</i>个。
                                    </p>
                                </div>
                            </div>
                        </li>


                        <li class="item">
                            <div class="personnel-parent ">
                                <span id="cgj">城管局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice " id="cgjcyqy"><span><img
                                                                src='/static/images/icon/canyinqiye.png'></span>餐饮企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="cgjdlyc"><span><img
                                                                src='/static/images/icon/daoluyangcheng.png'></span>道路扬尘(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjgjy"><span><img
                                                                src='/static/images/icon/gaojiayuanqiye.png'></span>高架源企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjltsk"><span><img
                                                                src='/static/images/icon/lutianshaokao.png'></span>露天烧烤(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjsyhd"><span><img
                                                                src='/static/images/icon/shangyehuodong.png'></span>商业活动(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjshlj"><span><img
                                                                src='/static/images/icon/shenghuolaji.png'></span>生活垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjyhyjshlj"><span><img
                                                                src='/static/images/icon/yanhaiyanjianglaji.png'></span>沿海沿江生活垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice" id="cgjztc"><span><img
                                                                src='/static/images/icon/zhatuche.png'></span>渣土车(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span id="gxj">工信局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice " id="gxjsbchygz"><span><img
                                                                src='/static/images/icon/shibancaigaizhao.png'></span> 石板材行业改造(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="gxjdlyc1"><span><img
                                                                src='/static/images/icon/daoluyangcheng.png'></span>道路扬尘(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span id="hyj">海洋局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice " id="hyjghwyz"><span><img
                                                                src="/static/images/icon/guihuawaiyangzhi.png"></span> 规划外养殖(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjyzfs"><span><img
                                                                src="/static/images/icon/yangzhifeishui.png"></span>养殖废水(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjnyzzmy"><span><img
                                                                src="/static/images/icon/nongyezhongzhi.png"></span>农业种植面源(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjrhrhpwk"><span><img
                                                                src="/static/images/icon/ruheruhaiwurang.png"></span>入河入海排污口(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjsbchygz"><span><img
                                                                src="/static/images/icon/shibancaigaizhao.png"></span>石板材行业改造(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjscyzwr"><span><img
                                                                src="/static/images/icon/shuichanyangzhiwurang.png"></span>水产养殖污染(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice " id="hyjyhyjshlj"><span><img
                                                                src="/static/images/icon/yanhaiyanjianglaji.png"></span>沿海沿江生活垃圾(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span id="lyj">林业局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/ziranbaohuqu.png"></span>
                                                    自然保护区功能区保护(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshan.png"></span> 持证矿山(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshanwenti.png"></span> 持证矿山问题(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="sswj">
                                <span>市商务局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/yangzhifeishui.png"></span> 养殖废水 (<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="syjglj">
                                <span>市应急管理局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshanwenti.png"></span> 持证矿山问题(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/binghailvyoulaji.png"></span> 滨海旅游垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/hedaowuti.png"></span> 河道问题(<i>26</i>)
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="slj">
                                <span>水利局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/bikengkuangshan.png"></span> 闭坑矿山水保(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/shengshishenghuowushui.png"></span>
                                                    城市生活污水处理厂(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshanwenti.png"></span> 持证矿山问题(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/hedaowuti.png"></span> 河道问题(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/piaofulaji.png"></span> 漂浮垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/xiangmushuibao.png"></span> 项目水保监管(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/yuanqusheshi.png"></span> 园区基础设施(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/xiaoshuidianzhan.png"></span> 小水电站(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/yangzhifeishui.png"></span> 养殖废水(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="zzswhhlyj">
                                <span>漳州市文化和旅游局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/hedaowuti.png"></span> 河道问题(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="zzszjxt">
                                <span>漳州市住建系统</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/shengshishenghuowushui.png"></span>
                                                    城市生活污水处理厂(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/shenghuolaji.png"></span> 生活垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshanwenti.png"></span> 持证矿山问题(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/ruheruhaiwurang.png"></span> 入河入海排污口(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/shenghuolaji.png"></span> 生活垃圾(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/shenghuowushui.png"></span> 生活污水(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="zzzrzyj">
                                <span>漳州市自然资源局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/feiqikuangshan.png"></span> 废弃矿山闭矿(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/chizhengkuangshanwenti.png"></span> 持证矿山问题(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                                src="/static/images/icon/feifacaikuang.png"></span> 非法采矿(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent" id="sthjj">
                                <span>生态环境局</span> <i>0个</i>
                            </div>
                            <div class="personnel-children">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border">
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/VOCs-icon.png"></span> VOCs企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/chikuangshanhuanping.png"></span> 持证矿山环评(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/feidaoluyidong.png"></span> 非道路移动源(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/gaojiayuanqiye.png"></span> 高架源企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/gongyeweixiangufei.png"></span> 工业危险废物(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/ruheruhaiwurang.png"></span> 入河入海排污口(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/sangehuafenchi.png"></span> 三格化粪池(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/sanluangwuqiye.png"></span> 散乱污企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/sheshuigongyeqiye.png"></span> 涉水工业企业(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/chikuangshanhuanping.png"></span> 石板材行业环评(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/yanhaigongyegufei.png"></span> 沿海沿江工业固废(<i>26</i>)
                                                </div>
                                                <div class="change-line no-choice "><span><img
                                                        src="/static/images/icon/yibangongyegufei.png"></span> 一般工业固废(<i>26</i>)
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>


                </div>
                <!--面板主内容 over-->
            </div>

        </div>


    </div>
</div>
<input id="name" value="${name!}" hidden>
<!-- dialog1 -->
<#include "/moudles/pollution/cityPollutionDetail.ftl">

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/preceedPointInArea.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\cityPollution.js"></script>
<script type="text/javascript" src="${request.contextPath}\static\js\moudles\pollution\detailInfo.js"></script>
</html>

