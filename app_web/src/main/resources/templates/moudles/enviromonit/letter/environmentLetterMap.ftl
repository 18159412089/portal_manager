<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>信访件地图分布</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
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

    <!-- 视频监控 -->
    <link rel="stylesheet" href="${request.contextPath}/static/ztree/css/zTreeStyle/zTreeStyle.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/cameraBase.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/index.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/preview.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/video.css"/>
    
    <!-- 航拍视频相关 -->
<link href="${request.contextPath}/static/css/video-js.css" rel="stylesheet">
<!-- If you'd like to support IE8 -->
<script src="${request.contextPath}/static/js/videojs-ie8.min.js"></script>
</head>
<!-- body -->
<body class="pollution-body alone-pollution" >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<style>
    /**************** 底图控制器************** */
    #mapDiv .basemap-toggle {
        position: absolute;
        z-index: 9;
    }
    .layui-layer-iframe{
        z-index: 99999!important;
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
    .fjzx-map-infoWindow a{color:#464444;}
    .fjzx-map-infoWindow-closer{
        top: -50px;
        right: 43px;
    }
    /*******************************/

</style>

<div class="map-container">
    <div class="map-wrapper" id="mapDiv">
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
    </div><!-- 地图层  -->

    <!--案件列表-->
    <div class="map-caselist-container show  map-contaminated-part">
        <div class="btn-collapse active" data-toggle="shown" data-target=".map-caselist-container">
            <span class="icon fa-angle-left"></span>
        </div>
        <div class="map-case-list-box">
            <div class="map-case-list allCaseList">
                <div class="list-title">污染类型</div>
                <div class="filter-container">
                    <div class="btn-group">
                        <div class="btn all active" data-statustype="">
                            <span>全部</span>
                        </div>
                        <div class="btn waiting " data-statustype="REGISTER">
                            <span>阶段性办结</span>
                        </div>
                        <div class="btn all " data-statustype="">
                            <span>已办结</span>
                        </div>
                        <div class="btn all " data-statustype="">
                            <span>已销号</span>
                        </div>
                    </div>
                </div>
                <div  class="searchbox-item">
                    <input class="easyui-searchbox" data-options="prompt:'请输入受理编号查询',searcher:doSearch" style="width:98%" id="searchBox">
                </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul" id="dataGrids">
                        <li class="item">
                            <div class="personnel-parent ">
                                <span> 水环境污染</span> <i id="waterTotal">0个</i>
                            </div>
                            <div class="personnel-children"  style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="water" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk" width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span> 大气环境污染</span> <i id="airTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="air" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span> 生态环境污染</span> <i id="ecologyTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="ecology" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span> 土壤环境污染</span> <i id="soilTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="soil" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>噪音污染</span> <i id="noiseTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="noise" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>海洋污染</span> <i id="seaTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="sea" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>辐射污染</span> <i id="radiateTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="radiate" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>其他污染</span> <i id="othersTotal">0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="radiate" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
                                                           data-options="
                                                                rownumbers:false,
                                                                singleSelect:true,
                                                                striped:false,
                                                                autoRowHeight:false,
                                                                pagination:true,
                                                                pageSize:5,
                                                                pageList:[5,20,30],
                                                                nowrap:false,
                                                                onLoadSuccess:function(data){
                                                                    $('#11').text(data.total);
                                                                }">
                                                        <thead>
                                                        <tr>
                                                            <th field="jbwtjbqk"width="200px" >问题</th>
                                                            <th field="bjzt" width="85px" >办结状态</th>
                                                        </tr>
                                                        </thead>
                                                    </table>
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


<!-- dialog1 -->
<div id="infoDlg" class="easyui-dialog letter-dialog" style="width:900px;height:600px;background:white;zIndex: 999"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
         <div class="easyui-tabs" >
            <div title="内容" id="content">
                <div class="panel-tex-part">
                    <span class="state-font">已销号</span>

                    <div class="row-item">
                        <div class="col-xs-6  copies" >
                            <span  class="name-tag">受理编号：</span>
                            <span  class="font-tag" id="wrylx">D2FJ201908120086</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">原始排序编码：</span>
                            <span  class="font-tag" id="wryzl">YSBM03900</span>
                        </div>
                    </div>

                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">污染类型：</span>
                            <span  class="font-tag" id="qx">大气</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">行政区域：</span>
                            <span  class="font-tag" id="xz">芗城区</span>
                        </div>
                    </div>

                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">是否属实：</span>
                            <span  class="font-tag" id="dz">部分属实</span>
                        </div>
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">轮次：</span>
                            <span  class="font-tag" >第一轮2017年</span>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">是否重点件：</span>
                            <span  class="font-tag" >是</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">是否重点件：</span>
                            <span  class="font-tag" >是</span>
                        </div>
                    </div>

                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag"> 责令整改(家次)：</span>
                            <span  class="font-tag">1</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag"> 罚款金额(万元)：</span>
                            <span  class="font-tag">0.2</span>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">重复关联件编号：</span>
                            <span  class="font-tag" >X2FJ201907280028</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">更新时间：</span>
                            <span  class="font-tag">2019-09-29</span>
                        </div>
                    </div>

                </div>
                <div class="panel-tex-part">
                    <div class="row">
                        <div class="col-xs-12 row-tex">
                            <span> 全景图片：</span>
                            <a class="but-common">整改前</a> <a class="but-common">整改前</a>  <a class="but-common">整改前</a>
                        </div>

                    </div>
                    <div class="row">
                        <div  class="col-xs-12 row-tex">
                            <span>视频监控：</span>
                            <a class="but-common video-show">视频1</a> <a class="but-common">视频3</a>  <a class="but-common">视频2</a>
                        </div>

                    </div>
                    <div class="row">
                        <div  class="col-xs-12 row-tex">
                            <span>无人机航拍：</span>
                            <a class="but-common  but-UAV"> <i class="icon iconcustom icon-wurenji2"></i>连线  </a>
                        </div>
                    </div>

                </div>
                <div class="panel-tex-part">
                    <div class="panel-tex-head">
                        <span>详细情况</span>
                    </div>
                    <div class="info-part">
                        <div class="info-content">
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下 石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                            <p><span>基本情况</span> :  石亭镇秋坑村原村长黄某琦在南山村建设洗砂场（南山村西边往天宝镇埔里村交界处），废水直排农田，散发臭气，下</p>
                        </div>
                        <div class="more-info">
                            <span> 详细 </span> <i class="icon iconcustom icon-zhedie4"></i>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-4  copies" >
                            <span  class="name-tag">牵头责任单位 :  </span>
                            <span  class="font-tag" id="wrylx">芗城生态环境局</span>
                        </div>
                        <div class="col-xs-4 copies" >
                            <span  class="name-tag"> 联络人 : </span>
                            <span  class="font-tag" id="wryzl"> 王子杰</span>
                        </div>
                        <div class="col-xs-4 copies" >
                            <span  class="name-tag">联系电话: </span>
                            <span  class="font-tag" id="wryzl">15960682273  </span>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-4  copies" >
                            <span  class="name-tag">所属网格：</span>
                            <span  class="font-tag" id="wrylx">芗城区石亭镇</span>
                        </div>
                        <div class="col-xs-4 copies" >
                            <span  class="name-tag">网格员：</span>
                            <span  class="font-tag" id="wryzl">洪利民</span>
                        </div>
                        <div class="col-xs-4 copies" >
                            <span  class="name-tag">网格员手机号码：</span>
                            <span  class="font-tag" id="wryzl">139600818588</span>
                        </div>
                    </div>
                </div>
            </div>

         </div>
    </div>
</div>
<#--图例-->
<div class="map-legend-container" style="z-index: 998; position: absolute; bottom: 0px; left: 0px; padding: 8px 24px 8px 20px;background-color: rgba(169, 164, 164, 0.38)">
    <div class="grade-legend">
        <div class="legend" style="width:auto; color: #fff">
            <img style="width: 20px;vertical-align: middle" src="${request.contextPath}/static/images/pollute/jieduanxing.png">&nbsp;阶段性办结 &nbsp;
            <img style="width: 20px;vertical-align: middle" src="${request.contextPath}/static/images/pollute/yibanjie.png">&nbsp;已办结&nbsp;
            <img style="width: 20px;vertical-align: middle" src="${request.contextPath}/static/images/pollute/yixiaohao.png">&nbsp;已销号&nbsp;
        </div>
    </div>
</div>
<#--漳浦视频监控弹窗-->
<div id="zpCameraDlg" class="easyui-dialog" style="width:900px;height:700px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <#--视频预览窗口-->
    <div id='fjzx-camera-dialog' class="map-videolist"></div>
    <div style="position: absolute;top: 0;left:auto;right: 0px;bottom:0;width: 380px;padding: 28px 10px;">
        <#--云台控制器-->
        <div id="camera-control-dialog"></div>
    </div>
</div>

<!-- dialog1 -->
<div id="uploadlg" class="easyui-dialog" style="width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#uploadlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="pkid" name="pkid" hidden="true"/>
        <input id="uuid" name="uuid" hidden="true"/>
        <input id="source" name="source" value="zz_letter" hidden/>
<#--        <div style="margin-bottom:10px">-->
<#--            <input id="projId" name="name" class="easyui-textbox"  style="width:200px;" label="工地名称:" disabled/>-->
<#--        </div>-->
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="整改前后图片:"
                   data-options="buttonText:'选择文件',accept:'image/gif,image/jp2,image/jpeg,application/pdf,image/png'"
                   style="width:100%"
                   onchange="onchange(newVal,oldVal)" id="picFile" name="picFile"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="picname" id="picnameid" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="图片名称:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="整改视频:" data-options="buttonText:'选择文件',accept:'audio/mp4, video/mp4'"
                   style="width:100%"
                   onchange="onchange(newVal,oldVal)" id="videoFile" name="videoFile"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="vedioname" id="videonameid" data-options="validType:'maxLength[255]'" class="easyui-textbox" label="视频名称:"
                   style="width:100%">
        </div>

    </form>
</div>
<div id="uploadlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveActach()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#uploadlg').dialog('close')" style="width:90px">取消</a>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:850px;height:auto;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload>您的浏览器不支持 video 标签。</video>
</div>

</body>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/moudles/enviromonit/letter/environmentLetterMap.js"></script>
<#-- 视频监控 -->
<script src="${request.contextPath}/static/ztree/js/jquery.ztree.core.js"></script>
<script src="${request.contextPath}/static/camera-zp/js/slplayer.js"></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera-config.js'></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera.js'></script>

<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    Ams.playVideo('video','videoDlg');

    /**
     * 格式化图片显示
     */
    function formatPic(value, row, index) {
        if (!Ams.isNoEmpty(row.picture)) return "-";
        return "<div>" + Ams.setImageDown() + "<a href='/environment/waterAttachment/download/" + row.picture + "/2" +
            "' class='easyui-linkbutton' target='_blank'>" + row.picname + "</a></div>";
    }

    /**
     * 视频播放
     */
    function play(mongoid) {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        $('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
    }

    /**
     * 编辑
     * @type {string}
     */
    function uploadDlg(row) {
        $('#fm').form('clear');
        if (row) {
            $('#uploadlg').dialog('open').dialog('center').dialog('setTitle', '附件信息');
            $('#fm').form('load', row);
            $("#pkid").val(row.uuid);
            $("#uuid").val(row.fileuuid);
            $("#source").val("zz_letter");
            $("#picFile").filebox({required: false});
            $('#videoFile').filebox({required: false});
            $("#picFile").filebox({prompt: row.picname});
            $('#videoFile').filebox({prompt: row.vedioname});
            url = Ams.ctxPath + '/enviromonit/airConstructionSite/save';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    $('#picFile').filebox({
        onChange: function (newValue, oldValue) {
            var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#picnameid').textbox('setValue', filename);
        }
    });
    $('#videoFile').filebox({
        onChange: function (newValue, oldValue) {
            var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#videonameid').textbox('setValue', filename);
        }
    });


    /**
     * 保存
     * @type {string}
     */
    function saveActach() {
        $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#uploadlg').dialog('close');
                    
                    realTimeUpload($('#pkid').val());
                    Ams.success('操作成功！');
                }
                $.messager.progress('close');
            }
        });
    }

    /**
     * 删除
     * @type {string}
     */
    function deleteActach(row, flag) {
        var param;
        if ("pic" == flag) {
            param = {
                'uuid': row.fileuuid,
                "pictureId": row.picture,
                "videoId": null
            };
        }else{
            param = {
                'uuid': row.fileuuid,
                "pictureId": null,
                "videoId": row.video
            };
        }
        if (row) {
            $.messager.confirm("提示信息", "确认删除吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    var loadIndex = '';
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/enviromonit/airConstructionSite/deleteByMap',
                        data: param,
                        beforeSend: function () {
                            loadIndex = layer.load(1, {
                                shade: [0.1, '#fff']
                            });
                        },
                        complete: function () {
                            layer.close(loadIndex);
                        },
                        success: function (result) {
                            realTimeUpload(row.pkid);
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                                Ams.success('操作成功');
                            }
                        },
                        error: function () {
                            $.messager.progress('close');
                            $.messager.show({
                                title: '错误',
                                msg: '删除失败！'
                            });
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    function realTimeUpload(id) {
        $.ajax({
            type: 'POST',
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            data: {'uuid': id},
            success: function (result) {
                showInfo(result.rows[0]);
            },
            dataType: 'json'
        });
    }

    var citys=['芗城区',
        '龙文区',
        '龙海市',
        '漳浦县',
        '长泰县',
        '华安县',
        '东山县',
        '平和县',
        '诏安县',
        '南靖县',
        '云霄县',
        '台商投资区',
        '招商局经济技术开发区',
        '常山华侨经济开发区',
        '漳州高新技术产业开发区',
        '古雷港经济开发区'];
    var cityPYs = ['xcq',
        'lwq',
        'lhs',
        'zpx',
        'ztx',
        'hax',
        'dsx',
        'phx',
        'zax',
        'njx',
        'yxx',
        'tstzq',
        'zsjzzkfq',
        'cshqjjkfq',
        'zzgxjscykfq',
        'glgjjkfq'];

    $(function () {
        //右边列表的缩起/展开小按钮
        $('body').on('click','[data-toggle="shown"]',function(){
            var target = $(this).attr("data-target");
            var $target = $(target);
            if($target.hasClass("show")){
                $target.removeClass("show");
                $(this).removeClass("active");
            }else {
                $target.addClass("show");
                $(this).addClass("active");
            }
        });
        var html = '';
        $('#dataGrids').html(html);
        for (var i=0;i<citys.length;i++){
            html += '<li class="item">' +
                '                            <div class="personnel-parent ">' +
                '                                <span>'+citys[i]+'</span> <i id="'+cityPYs[i]+'Total">0个</i>' +
                '                            </div>' +
                '                            <div class="personnel-children" >' +
                '                                <div class="personnel-info not-border">' +
                '                                    <div class="filter-container not-border" >' +
                '                                        <div class="filter-box">' +
                '                                            <div class="filter-content">' +
                '                                                <div class="easyui-table-light">' +
                '                                                    <table id="'+cityPYs[i]+'" class="easyui-datagrid"' +
                '                                                           style="width: 100%;height:240px;"' +
                '                                                           data-options="' +
                '                                                                rownumbers:false,' +
                '                                                                singleSelect:true,' +
                '                                                                striped:false,' +
                '                                                                autoRowHeight:false,' +
                '                                                                pagination:true,' +
                '                                                                pageSize:5,' +
                '                                                                pageList:[5,20,30],' +
                '                                                                nowrap:false,' +
                '                                                                onLoadSuccess:function(data){' +
                '                                                                    $(\'#'+cityPYs[i]+'Total\').text(data.total);' +
                '                                                                },' +
                '                                                                onClickRow: function (index, data) {' +
                '                                                                    if (data.jd != null && data.wd != null) {' +
                '                                                                       map.setCenter(new fjzx.map.Point(data.jd, data.wd));' +
                '                                                                    }' +
                '                                                                },' +
                '                                                                onDblClickRow: function (index, row) {' +
                '                                                                   showInfo(row);' +
                '                                                                }">'+
                '                                                        <thead>' +
                '                                                        <tr>' +
                '                                                            <th field="jbwtjbqk"width="200px" >问题</th>' +
                '                                                            <th field="bjzt" width="85px" >办结状态</th>' +
                '                                                        </tr>' +
                '                                                        </thead>' +
                '                                                    </table>' +
                '                                                </div>' +
                '                                            </div>' +
                '                                        </div>' +
                '                                    </div>' +
                '                                </div>' +
                '                            </div>' +
                '                        </li>'
        }
        $('#dataGrids').html(html);

        loadData2('', '');

    });

    function showInfo(info) {
        var data = info || {};
        
        var rowData = JSON.stringify(info);
        var html='';
        $('#content').html(html);
        html =  '            <div class="panel-tex-part">'
            + '            <span class="state-font">'+(data.bjzt == null?"-":data.bjzt)+'</span>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies" >'
            + '                    <span  class="name-tag">受理编号：</span>'
            + '                    <span  class="font-tag" id="wrylx">'+(data.slbh == null?"-":data.slbh)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6 copies" >'
            + '                    <span  class="name-tag">原始排序编码：</span>'
            + '                    <span  class="font-tag" id="wryzl">'+(data.yspxbm == null?"-":data.yspxbm)+'</span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag">污染类型：</span>'
            + '                    <span  class="font-tag" id="qx">'+(data.wrlx == null?"-":data.wrlx)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6 copies" >'
            + '                    <span  class="name-tag">行政区域：</span>'
            + '                    <span  class="font-tag" id="xz">'+(data.xzqy == null?"-":data.xzqy)+'</span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag">是否属实：</span>'
            + '                    <span  class="font-tag" id="dz">'+(data.sfss == null?"-":data.sfss)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag">轮次：</span>'
            + '                    <span  class="font-tag" id="jd">'+(data.lc == null?"-":data.lc)+'</span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag">验收情况：</span>'
            + '                    <span  class="font-tag" id="jd">'+(data.ysqk == null?"-":data.ysqk)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6 copies" >'
            + '                    <span  class="name-tag">是否重点件：</span>'
            + '                    <span  class="font-tag" id="wd">'+(data.sfzdj == null?"-":data.sfzdj)+'</span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag"> 责令整改(家次)：</span>'
            + '                    <span  class="font-tag" id="jd">'+(data.zlzg == null?"-":data.zlzg)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6 copies" >'
            + '                    <span  class="name-tag"> 罚款金额(万元)：</span>'
            + '                    <span  class="font-tag" id="wd">'+(data.fkje == null?"-":data.fkje)+'</span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-6  copies " >'
            + '                    <span  class="name-tag">重复关联件编号：</span>'
            + '                    <span  class="font-tag" id="jd">'+(data.sfgljbh == null?"-":data.sfgljbh)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-6 copies" >'
            + '                    <span  class="name-tag">更新时间：</span>'
            + '                    <span  class="font-tag" id="wd">'+Ams.dateFormat(data.updateDate)+'</span>'
            + '                </div>'
            + '            </div>'
            + '        </div>'
            + '        <div class="panel-tex-part">';
            if (data.dcqjdchsqk.match(RegExp(/马头山/))) {
                html += '            <div class="row">'
                + '                <div class="col-xs-12 row-tex">'
                + '                     <span> 全景图片：</span>'
                + '                     <a class="but-common" href="https://720yun.com/t/9bvknmrqg7w?scene_id=31882366" target="_blank">整改前</a>'
                + '                     <a class="but-common" href="https://720yun.com/t/4avkiw2hsdq?scene_id=34721822" target="_blank">整改后</a>'
                + '                </div>'
                + '            </div>';
            } else if (data.dcqjdchsqk.match(RegExp(/蔡坑/))) {
                html += '            <div class="row">'
                    + '                <div class="col-xs-12 row-tex">'
                    + '                     <span> 全景图片：</span>'
                    + '                     <a class="but-common" href="https://720yun.com/t/9bvknmrqg7w?scene_id=32411087" target="_blank">整改前</a>'
                    + '                     <a class="but-common" href="https://720yun.com/t/06vknb7lp7l?scene_id=32411087" target="_blank">整改中</a>'
                    + '                     <a class="but-common" href="https://720yun.com/t/1fvkiw2hspy?scene_id=32411087" target="_blank">整改后</a>'
                    + '                </div>'
                    + '            </div>';
            } else {
                html += '            <div class="row">'
                    + '                <div class="col-xs-12 row-tex">'
                    + '                     <span> 整改图片：</span>'
                if (Ams.isNoEmpty(data.picture)) {
                    html += "                     <a class='but-common' target='_blank' href='/environment/waterAttachment/download/" + data.picture + "/2'>整改前后图片</a><a title='删除图片' onClick='deleteActach("+rowData+",\"pic\")' class='delete-tag'><i class='icon iconcustom icon-shanchu1' style='cursor:pointer;color: red;font-size:24px;vertical-align: sub;'></i></a>"
               
                } else {
                    html += '                     <a class="but-common">无</a>'
                }
                html += '                     <span>&nbsp;&nbsp;&nbsp; 整改视频：</span>'
                if (Ams.isNoEmpty(data.video)) {
                    html += "                     <a class='but-common' onClick='play(\""+data.video+"\")'>整改前后视频</a> <a onClick='deleteActach("+rowData+",\"video\")' title='删除视频' class='delete-tag'><i class='icon iconcustom icon-shanchu1'  style='cursor:pointer;color: red;font-size:24px;vertical-align: sub;'> </i></a>"
                } else {
                    html += "                     <a class='but-common'>无</a>"
                }

                html += "                     <a class='title-link-tag' onClick='uploadDlg("+rowData+")'>整改图片视频上传</a>"
                    + '                </div>'
                    + '            </div>';
            }
            
            html += '            <div class="row">'
            + '                <div id="cameraChannelList" class="col-xs-12 row-tex">'
            + '                    <span>视频监控：</span>'
            + '                    <a class="but-common video-show">视频1</a> <a class="but-common">视频3</a>  <a class="but-common">视频2</a>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row">'
            + '                <div  class="col-xs-12 row-tex">'
            + '                    <span>无人机航拍：</span>'
            + '                    <a class="but-common  but-UAV" id="hpView"> <i class="icon iconcustom icon-wurenji2"></i>连线  </a>'
            + '                </div>'
            + '            </div>'
            + '        </div>'
            + '        <div class="panel-tex-part">'
            + '            <div class="panel-tex-head">'
            + '                <span>详细情况</span>'
            + '            </div>'
            + '            <div class="info-part">'
            + '               <div class="info-content">'
            + '                   <p><span>基本情况</span> :  '+(data.jbwtjbqk == null?"-":data.jbwtjbqk)+'</p>'
            + '                   <p><span>核实情况</span> :  '+(data.dcqjdchsqk == null?"-":data.dcqjdchsqk)+'</p>'
            + '                   <p><span>整改措施</span> :  '+(data.zgmbjzgcs == null?"-":data.zgmbjzgcs)+'</p>'
            + '                   <p><span>处理情况</span> :  '+(data.dcqjclqk == null?"-":data.dcqjclqk)+'</p>'
            + '                   <p><span>最新整改情况</span> :  '+(data.zxzgqk == null?"-":data.zxzgqk)+'</p>'
            + '               </div>'
            + '                <div class="more-info">'
            + '                   <span> 详细 </span> <i class="icon iconcustom icon-zhedie4"></i>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-4  copies" >'
            + '                    <span  class="name-tag">牵头责任单位 :  </span>'
            + '                    <span  class="font-tag" id="wrylx">'+(data.qtzrdw == null?"-":data.qtzrdw)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-4 copies" >'
            + '                    <span  class="name-tag"> 联络人 : </span>'
            + '                    <span  class="font-tag" id="wryzl">'+(data.llr == null?"-":data.llr)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-4 copies" >'
            + '                    <span  class="name-tag">联系电话: </span>'
            + '                    <span  class="font-tag" id="wryzl">'+(data.lxdh == null?"-":data.lxdh)+'  </span>'
            + '                </div>'
            + '            </div>'
            + '            <div class="row-item">'
            + '                <div class="col-xs-4  copies" >'
            + '                    <span  class="name-tag">所属网格：</span>'
            + '                    <span  class="font-tag" id="wrylx">'+(data.sswl == null?"-":data.sswl)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-4 copies" >'
            + '                    <span  class="name-tag">网格员：</span>'
            + '                    <span  class="font-tag" id="wryzl">'+(data.wgy == null?"-":data.wgy)+'</span>'
            + '                </div>'
            + '                <div class="col-xs-4 copies" >'
            + '                    <span  class="name-tag">网格员手机号码：</span>'
            + '                    <span  class="font-tag" id="wryzl">'+(data.wgysjhm == null?"-":data.wgysjhm)+'</span>'
            + '                </div>'
            + '            </div>'
            + '        </div>';
        $('#content').html(html);



        // 点击详情事件
        $('.info-part').on('click','.more-info',function(){
            var box = $(".info-content")
            if(box.hasClass("open")){
                box.removeClass("open");
                $(this).find("i").removeClass("icon-zhedie2");
                $(this).find("i").addClass("icon-zhedie4");
            }else {
                box.addClass("open");
                $(this).find("i").removeClass("icon-zhedie4");
                $(this).find("i").addClass("icon-zhedie2");

            }
        });

        //视频监控
        $('#cameraChannelList').empty();
        data.channelIds = "";
        if (data.dcqjdchsqk.match(RegExp(/马头山/))) {
            data.channelIds = 'M030F-A0001181108:1,M030F-A0001181108:2,M030F-A0001181108:3';
        } else if (data.dcqjdchsqk.match(RegExp(/蔡坑/))){
            data.channelIds = 'M030F-A0001181113:1,M030F-A0001181113:2,M030F-A0001181113:3';
        }
        if(data.channelIds != ""){
            var channelIds = data.channelIds.split(',');
            var channelListHtml = '<span style="font-weight:bold">视频监控：</span>';
            $.each(channelIds, function(index, value){
                var channelId = value;
                var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
                channelListHtml += '<a class="camera-channel but-common video-show" href="javascript:void(0);" target="_self" style="color: #0ab7ff;text-decoration: underline;margin-right:10px;" channel-id="'+channelId+'">'+channelName+'</a>';
                document.getElementById('cameraChannelList').innerHTML = channelListHtml;
            });
            $('#cameraChannelList').find('a.camera-channel').click(function(){
                var channelId = $(this).attr('channel-id');
                var channelName = channelId.split(':').length > 0 ? '监控'+channelId.split(':')[1] : '';
                console.log('点击了'+channelName);
                showZpCamera(channelId, channelName);
            });
        }

        $("#hpView").click(function () {
            //iframe层
            top.layer.open({
                type: 2,
                title: '航拍视频播放',
                shadeClose: true,
                shade: false,
                zIndex: 9999999,
                maxmin: true, //开启最大化最小化按钮
                area: ['900px', '610px'],
                offset:['150px','300px'],
                content: '/videoDemo' //iframe的url
            });
        });

        $('#infoDlg').dialog('open').dialog('center').dialog('setTitle', '详情');
    }

    function loadData2(bjzt, slbh){
        for(var i=0;i<citys.length;i++) {
            var total2 = 0;
            $('#'+cityPYs[i]).datagrid({
                url: '${request.contextPath}/environment/letter/allLetterlistByMap',
                queryParams: {
                    "xzqy": citys[i],
                    "slbh": slbh,
                    'bjzt': bjzt,
                    // "xzqy": areaName,
                    "lc": "第二轮（2019年）"
                },onClickRow: function (index, data) {
                    positionInfo(data.jd,data.wd,data.uuid);
                },
            });
        }
    }

    function positionInfo(jd,wd,uuid) {
        if (jd != null && wd != null) {
            map.setCenterAndZoom(new fjzx.map.Point(jd, wd),15);
            animalMarker(uuid);
        }
    }

    function loadData(bjzt, slbh){
        $('#water').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '水',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#waterTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
                positionInfo(data.jd,data.wd,data.uuid);
            },

            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });

        $('#air').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '大气',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#airTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
                positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {

                showInfo(row);
            }
        });
        $('#others').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '其他污染',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#othersTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
                positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
        // $('#othersDIV').empty();
        // $('#othersDIV').append('<table id="others" class="easyui-datagrid" style="width: 100%;height:240px;"></table>');
        // $.parser.parse($("#othersDIV"));//使用局部渲染
        // $('#others').datagrid(getParams('其他污染', slbh, bjzt,'#othersTotal'));
        // $.parser.parse($("#others"));//使用局部渲染
        $('#soil').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '土壤',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#soilTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
                positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
        $('#sea').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '海洋',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#seaTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
               positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
        $('#ecology').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '生态',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#ecologyTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
               positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
        $('#radiate').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '辐射',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#radiateTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
               positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
        $('#noise').datagrid({
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            queryParams: {
                "wrlx": '噪音',
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            onLoadSuccess:function (data) {
                $('#noiseTotal').text(data.total+"个");
            },
            onClickRow: function (index, data) {
               positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        });
    }

    function getParams(wrlx, slbh, bjzt, id){
        var params = {
            url: '${request.contextPath}/environment/letter/allLetterlistByMap',
            columns: [[
                {field: 'jbwtjbqk', title: '问题', width: '200px'},
                {field: 'bjzt', title: '办结状态', width: '85px'}
            ]],
            queryParams: {
                "wrlx": wrlx,
                "slbh": slbh,
                'bjzt': bjzt,
                "xzqy": areaName,
                "lc": "第二轮（2019年）"
            },
            pageList: [5],
            rownumbers: true,
            singleSelect: true,
            striped: false,
            autoRowHeight: false,
            pagination: true,
            pageSize: 5,
            nowrap: false,
            fitColumns: true,
            onLoadSuccess:function (data) {
                $(id).text(data.total+"个");
            },
            onClickRow: function (index, data) {
                positionInfo(data.jd,data.wd,data.uuid);
            },
            onDblClickRow: function (index, row) {
                showInfo(row);
            }
        }
        return params;
    }
    //点击marker 动画
    function animalMarker(markerId) {
        var myMarker = markerMap.get(markerId);
        var cycleObject = myMarker.cycleAnimal();
        cycleObject.startAnimal();
        cycleObject.setCycleTime(5);
    }

    $(".personnel-list-container").on("click",".personnel-parent",function(){
        var $p=$(this);
        $p.siblings(".personnel-children").slideToggle("slow",function(){
            if($(this).is(":visible")){
                $p.addClass("collapsed");
                var $tables=$p.offsetParent().find(".easyui-datagrid");
                $tables.datagrid("resize");
            }else{
                $p.removeClass("collapsed");
            };
        });
    });


    // 动态修改元素高度
    function ChangeHeight(){
        var alontVal =190;
        var listHeight =$(window).height() -$(".contaminated-personnel-ul").height();
        $(".soil-table-box").css("height", (listHeight-alontVal) + "px");
    }


    /*筛选与tabs的联动*/
    $('.no-choice').click(function () {
        var cl_n=$(this);
        var subtitle=$(this).attr("title");
        var tid=$(this).attr("id");
        if(cl_n.hasClass('choiced')){
            cl_n.removeClass('choiced');

        }else{
            cl_n.addClass('choiced');
        }
    });


    $(window).resize(function() {
        ChangeHeight()

    });

    // 动态修改元素高度
    function ChangeHeight() {
        var alontVal = 153;
        var listHeight = $(window).height() - alontVal;
        $(".contaminated-personnel-list").css("height", listHeight + "px");
    }

    function doSearch(value){

        if($('.btn-group').find(".active").find("span").text() == "全部"){
            loadData2('',value);
        }else {
            loadData2($('.btn-group').find(".active").find("span").text(),value);
        }
    }
    //btn-group
    $('.btn-group').on('click','.btn',function(){
        var $parent=$(this).parents('.btn-group');
        var $all=$parent.find(".btn");
        // alert( $(this).find("span").text())
        if($(this).find("span").text() == "全部"){
            loadData2('',$('#searchBox').val());
        }else {
            loadData2($(this).find("span").text(),$('#searchBox').val());
        }
        $all.removeClass("active");
        $(this).addClass("active");
    });


    $(document).ready(function(){

        ChangeHeight()

    })


</script>

</html>
