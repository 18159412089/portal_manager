<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>市直排查污染源</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <!-- 视频监控 -->

    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/cameraBase.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/preview.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/video.css"/>

</head>
<!-- body -->
<body class="pollution-body alone-pollution" >
<#--<#include "/secondToolbar.ftl">-->
<#include "/common/loadingDiv.ftl"/>
<style>
    #pf-hd{ height: 62px;}
    #pf-hd .pf-logo{ line-height: 62px;}
    .nav-container .nav-box >ul >li{height: 62px;}
    .nav-container .nav-box >ul .select-link a{ line-height: 62px;}
    .nav-container .nav-box >ul >li >a{line-height: 62px; }
    .nav-container .nav-menu-tag a{margin-top: 3px;}
    #pf-hd .pf-user{height: 62px;line-height: 62px; }
    #pf-hd .pf-user .pf-user-panel{ top: 62px;}
    .nav-container .nav-box{ height: 62px;}
</style>



<div id="pf-hd" style="">
    <span class="pf-logo">
        <img src="/static/images/blocks1.png" align="absmiddle"/>  漳州生态云
    </span>
    <div class="pf-user">
        <div class="pf-user-photo">
            <img src="/static/images/main/user.png" alt="">
        </div>

        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>
        <i class="iconfont xiala">&#xe607;</i>

        <div class="pf-user-panel">
            <ul class="pf-user-opt">
                <li>
                    <a href="javascript:;">
                        <i class="iconfont">&#xe60d;</i>
                        <span class="pf-opt-name">用户信息</span>
                    </a>
                </li>
                <li class="pf-modify-pwd" id="editpass">
                    <a href="#" >
                        <i class="iconfont">&#xe634;</i>
                        <span class="pf-opt-name">修改密码</span>
                    </a>
                </li>
                <li id="omDownload">
                    <a href="#" >
                        <i class="iconfont">&#xe670;</i>
                        <span class="pf-opt-name">下载操作手册</span>
                    </a>
                </li>
                <li class="pf-logout" id="loginOut">
                    <a href="#" >
                        <i class="iconfont">&#xe60e;</i>
                        <span class="pf-opt-name">退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <#--  当导航只有一级开始-->

    <div  class="nav-container">
        <div class="child-item" >
            <ul id="data">
                <li><a>网格员任务派发dffhhdfh</a></li>
                <li><a>网格员任务派发</a></li>
                <li><a>网格员任务派发</a></li>
                <li><a>网格员任务派发</a></li>
                <li><a>网格员任务派发</a></li>
                <li><a>网格员任务派发</a></li>
            </ul>
        </div>
        <div class="nav-box">
            <ul class="nav-ul-tag" id="second">
                <li class="select-link">
                    <a href="${request.contextPath}/index" target="_self">
                        <span class="title">首页</span>
                    </a>
                </li>
                <li class="active">
                    <a href="${request.contextPath}/environment/hugeData" target="_blank">
                        <span class="title">大屏展示</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/water/nationalSurfaceWater" target="_blank">
                        <span class="title">水环境</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/enviromonit/airEnvironment" target="_blank">
                        <span class="title">大气环境</span>
                    </a>

                </li>
                <li>
                    <a  href="${request.contextPath}/epa/epaMonitorMap.do?menu=applicationServiceMenu"  target="_blank">
                        <span class="title">应用服务</span>
                    </a>
                </li>
                <li>

                    <a  href="${request.contextPath}/env/mainPage/main.do?type=AQI&menu=dataServiceMenu" target="_blank">
                        <span class="title">数据服务</span>
                    </a>
                </li>
                <li>
                    <a href="#" target="_self">
                        <span class="title">近岸海域信息</span>
                    </a>
                </li>
                <li>
                    <a href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank">
                        <span class="title">网格员任务派发</span>
                    </a>
                </li>


                <li>
                    <a href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank">
                        <span class="title">网格员任务派发</span>
                    </a>
                </li>

                <li>
                    <a href="${request.contextPath}/manage" target="_blank">
                        <span class="title">系统管理</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/manage" target="_blank">
                        <span class="title">系统管理</span>
                    </a>
                </li>
                <li>
                    <a href="${request.contextPath}/manage" target="_blank">
                        <span class="title">系统管理</span>
                    </a>
                </li>


            </ul>
        </div>
        <div class="nav-menu-tag">
            <a class="nav-prev invalid-menu">
                <span class="icon iconcustom "></span>
            </a>
            <a class="nav-next">
                <span class="icon iconcustom"></span>
            </a>
        </div>
    </div>

</div>



<div class="map-container">
    <div class="map-wrapper"></div><!-- 地图层  -->
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
                            <span>阶段性结办</span>
                        </div>
                        <div class="btn all " data-statustype="">
                            <span>已结办</span>
                        </div>
                        <div class="btn all " data-statustype="">
                            <span>已销号</span>
                        </div>
                    </div>
                </div>
               <div  class="searchbox-item">
                   <input class="easyui-searchbox" data-options="prompt:'请输入受理编号查询',searcher:doSearch" style="width:98%">
               </div>
                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul">
                        <li class="item">
                            <div class="personnel-parent ">
                              <span> 水环境污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children"  style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span> 大气环境污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span> 生态环境污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span> 土壤环境污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span>噪音污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span>海洋污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
                                <span>辐射污染</span> <i>0个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="easyui-table-light">
                                                    <table id="test2" class="easyui-datagrid"
                                                           style="width: 100%;height:240px;"
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
                                                            <th field="qymc" width="160px" >问题</th>
                                                            <th field="bjzt" width="160px" >办结状态</th>
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
<div id="infoDlg" class="easyui-dialog letter-dialog" style="width:900px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
        <div id="tt" class="easyui-tabs" >
            <div title="内容" >
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
                            <span  class="font-tag" id="jd">第一轮2017年</span>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">是否重点件：</span>
                            <span  class="font-tag" id="jd">是</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">是否重点件：</span>
                            <span  class="font-tag" id="wd">是</span>
                        </div>
                    </div>

                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag"> 责令整改(家次)：</span>
                            <span  class="font-tag" id="jd">1</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag"> 罚款金额(万元)：</span>
                            <span  class="font-tag" id="wd">0.2</span>
                        </div>
                    </div>
                    <div class="row-item">
                        <div class="col-xs-6  copies " >
                            <span  class="name-tag">重复关联件编号：</span>
                            <span  class="font-tag" id="jd">X2FJ201907280028</span>
                        </div>
                        <div class="col-xs-6 copies" >
                            <span  class="name-tag">更新时间：</span>
                            <span  class="font-tag" id="wd">2019-09-29</span>
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
                <#--            <div title="Tab2" >tab2</div>-->
                <#--            <div title="Tab3" >-->
                <#--                tab3-->
                <#--            </div>-->
            </div>

        </div>
    </div>
</div>

<#--漳浦视频监控弹窗-->
<div id="zpCameraDlg" class="easyui-dialog" style="width:900px;height:700px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
        <div id='fjzx-camera-dialog' class="map-videolist"></div>
       <div style="position: absolute;top: 0;left:auto;right: 0px;bottom:0;width: 380px;padding: 28px 10px;">
           <#--云台控制器-->
           <div id="camera-control-dialog"></div>
       </div>

</div>


<!-- dialog1 -->
<div id="infoDlg2" class="easyui-dialog" style="width:900px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
        <div id="tt" class="easyui-tabs" style="width:898px;height:550px;">
            <div title="Tab1" >
                <div class="panel-group-container" >
                    <div class="panel-group-top"><span id="">南靖上洋</span>
                        <span class="fr" id="">
                                  <span  class="name-tag">纬度：</span>
                                  <span  class="font-tag" id="wd">4646</span>

                                  <span  class="name-tag">经度：</span>
                                 <span  class="font-tag" id="jd">11111</span>
                    </span>
                    </div>
                    <div class="panel-group-body">
                        <div class="panel-tex-part">
                            <div class="panel-tex-head">
                                <span>企业详情</span>
                               <a class="right-link-tag">查看一企一档</a>
                            </div>
                            <div class="row-item">
                                <div class="col-xs-6  copies" >
                                    <span  class="name-tag">污染源类型：</span>
                                    <span  class="font-tag" id="wrylx">大气交付伙食费水立方空间是开发商</span>
                                </div>
                                <div class="col-xs-6 copies" >
                                    <span  class="name-tag">污染源类型：</span>
                                    <span  class="font-tag" id="wryzl">大气交付伙食费水立方空间是开发商</span>
                                </div>
                            </div>

                            <div class="row-item">
                                <div class="col-xs-6  copies " >
                                    <span  class="name-tag">区县：</span>
                                    <span  class="font-tag" id="qx">大气交付伙食费水立方空间是开发商</span>
                                </div>
                                <div class="col-xs-6 copies" >
                                    <span  class="name-tag">乡镇：</span>
                                    <span  class="font-tag" id="xz">大气交付伙食费水立方空间是开发商</span>
                                </div>
                            </div>

                            <div class="row-item">
                                <div class="col-xs-6  copies " >
                                    <span  class="name-tag">地址：</span>
                                    <span  class="font-tag" id="dz">大气交付伙食费水立方空间是开发商</span>
                                </div>
                            </div>

                            <div class="row-item">
                                <div class="col-xs-6  copies " >
                                    <span  class="name-tag">经度：</span>
                                    <span  class="font-tag" id="jd">大气交付伙食费水立方空间是开发商</span>
                                </div>
                                <div class="col-xs-6 copies" >
                                    <span  class="name-tag">纬度：</span>
                                    <span  class="font-tag" id="wd">大气交付伙食费水立方空间是开发商</span>
                                </div>
                            </div>
                        </div>

                        <div class="panel-tex-part">
                            <div class="panel-tex-head">
                                <span>企业详情</span>
                            </div>
                            <div class="existence-bug-box">
                                <i class="icon iconcustom icon-fengxian4"></i> <span>存在问题：未办理环评手续</span>
                            </div>
                            <div class="row">
                                <span class="col-xs-12">存在问题：未办理环评手续</span>
                            </div>
                            <div class="row">
                                <span  class="col-xs-12">整改措施：明确分类处置措施并完成整治。</span>
                            </div>
                            <div class="row">
                                <span  class="col-xs-12">治理项目：“散乱污”工业企业污染专项整治</span>
                            </div>

                            <!--面板主内容-->
                            <div class="speed-info-title">完成目标</div>
                            <div class="speed-info-part">
                                <div class="time-axis-container">
                                    <ul>
                                        <li class="item highlight">
                                            <div href="" class="time-axis-box">
                                                <div class="step">
                                                    <span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>
                                                    <span class="button-tag fr" >已完成</span>
                                                </div>
                                                <div class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                    自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                            </div>
                                        </li>
                                        <li class="item highlight">
                                            <div href="" class="time-axis-box">
                                                <div class="step"><span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>
                                                    <span class="button-tag fr red" >未完成</span>
                                                </div>
                                                <div class="tex">关于召开全市2017年及2018年国控重点企业自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工…关于召开全市2017年及2018年国控重点企业
                                                    自行监测及信息工关于召开全市2017年及2018年国控重点企业自行监测及信息工</div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!--面板主内容 over-->

                        </div>

                        <div class="sewage-info-table">


                        </div>

                        <div class="panel-tex-part">
                            <div class="panel-tex-head">
                                <span>企业详情</span>
                            </div>
                            <div class="row-item">
                                <div class="col-xs-4  copies" >
                                    <span  class="name-tag">属地责任单位：</span>
                                    <span  class="font-tag" id="wrylx">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">责任人：</span>
                                    <span  class="font-tag" id="wryzl">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">联系方式：</span>
                                    <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                            </div>

                            <div class="row-item">
                                <div class="col-xs-4  copies" >
                                    <span  class="name-tag">属地责任单位：</span>
                                    <span  class="font-tag" id="wrylx">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">责任人：</span>
                                    <span  class="font-tag" id="wryzl">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">联系方式：</span>
                                    <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                            </div>
                            <div class="row-item">
                                <div class="col-xs-4  copies" >
                                    <span  class="name-tag">属地责任单位：</span>
                                    <span  class="font-tag" id="wrylx">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">责任人：</span>
                                    <span  class="font-tag" id="wryzl">龙山镇</span>
                                </div>
                                <div class="col-xs-4 copies" >
                                    <span  class="name-tag">联系方式：</span>
                                    <span  class="font-tag" id="wryzl">XXXXXXXX  <a class="sewage-send-tag"> <i class="icon iconcustom icon-xinxi2"></i></a></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <#--            <div title="Tab2" >tab2</div>-->
                <#--            <div title="Tab3" >-->
                <#--                tab3-->
                <#--            </div>-->
            </div>
            <div title="Tab2" >
                <div class="panel-group-container" >
                    <div class="speed-info-title">治理项目 “散乱污”</div>
                    <div class="speed-info-part"  style="padding: 15px;">
                        <div class="time-axis-container">
                            <ul>
                                <li class="item highlight">
                                    <div class="time-axis-part">
                                        <div class="time-axis-head">
                                            <span>上传时间：2019年9月20日16时10分</span>
                                            <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                            <a class="fr common-upload-tag" >
                                                <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                        </div>
                                        <div class="time-axis-content">
                                            <div class="img-box">

                                            </div>
                                        </div>
                                        <p>描述：</p>
                                        <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                    </div>
                                </li>
                                <li class="item highlight">
                                    <div class="time-axis-part">
                                        <div class="time-axis-head">
                                            <span>上传时间：2019年9月20日16时10分</span>
                                            <a class="delete-tag"><i class="icon iconcustom icon-shanchu1"></i> 刪除</a>
                                            <a class="fr common-upload-tag" >
                                                <i class="icon iconcustom icon-shangchuan2"></i> 上傳附件</a>
                                        </div>
                                        <div class="time-axis-content">
                                            <div class="img-box">

                                            </div>
                                        </div>
                                        <p>描述：</p>
                                        <p>锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批锅炉超低排放改造上报集团审批</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<!-- dialog3 -->
<div id="infoDlg3" class="easyui-dialog" style="width:900px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 10px">
        <div class="panel-table">
            <h5 class="panel-info-head">
                <span class="name-tag">污染源一企一档企业信息明细</span>
                <span class="time-tag">最新更新时间：2018/10/20</span>
            </h5>
            <table class="alone-table table-info-tag " >
                <tbody>
                <tr>
                    <td >企业名称</td>
                    <td ><span class="column-font"> fhdksfhdksfhdksfhskfhskfhksfhskjfhsfsfsfs</span></td>
                    <td>企业类型</td>
                    <td> <span class="column-font"> 带起</span></td>
                </tr>
                <tr>
                    <td>所属行业</td>
                    <td ><span class="column-font"></span></td>
                    <td >登记注册类型</td>
                    <td><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td>企业地址</td>
                    <td><span class="column-font"></span></td>
                    <td>法人代码</td>
                    <td><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td>法人代表姓名</td>
                    <td> <span class="column-font"></span></td>
                    <td>电话</td>
                    <td><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >关注程度</td>
                    <td ><span class="column-font"></span></td>
                    <td >开业时间（投产日期）</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >隶属关系</td>
                    <td ><span class="column-font"></span></td>
                    <td > 单位资质</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td>行政区名称</td>
                    <td><span class="column-font"></span></td>
                    <td>行政区代码</td>
                    <td><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >污染源编码</td>
                    <td ><span class="column-font"></span></td>
                    <td > 标准污染源名称</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >污染源监管类型</td>
                    <td ><span class="column-font"></span></td>
                    <td > 所属流域</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >污染源环保部门</td>
                    <td ><span class="column-font"></span></td>
                    <td > 环保联人</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >环保联系人电话</td>
                    <td ><span class="column-font"></span></td>
                    <td >环保联系人手机</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >污染源责任人</td>
                    <td ><span class="column-font"></span></td>
                    <td > 专职环保人员数</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                <tr>
                    <td >经度</td>
                    <td ><span class="column-font"></span></td>
                    <td > 纬度</td>
                    <td ><span class="column-font"></span></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- dialog4 -->
<div id="infoDlg4" class="easyui-dialog" style="width:900px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
     <div id="tt" class="easyui-tabs" style="width:898px;height:550px;">
        <div title="废气监测" >
            <#-- 自动监控小时-->
            <div id="tt2" class="easyui-tabs alone-easyui-tabs" style="width:898px;">

                <div title="自动监控小时" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">排口名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">污染物：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>

                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期"> &nbsp;&nbsp;监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>

                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                    <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                    <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                    <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                    <th data-options="field:'code5'" width="14.3%">检测值</th>
                                    <th data-options="field:'code6'" width="14.3%">单位</th>
                                    <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

                <#-- 监督性监测-->
                <div title="监督性监测" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>


                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:400px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                    <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                    <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                    <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                    <th data-options="field:'code5'" width="14.3%">检测值</th>
                                    <th data-options="field:'code6'" width="14.3%">单位</th>
                                    <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

                <#-- 自行监测-->
                <div title="自行监测" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto; vertical-align: middle" title="监测类型">监测类型：</label>
                                    <div class="inline-radio-box">
                                        <input  type="radio"> <label>自行监测</label>   <input  type="radio"> <label>手工监测</label>
                                    </div>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">&nbsp;&nbsp;&nbsp;项目名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="10%">监测日期</th>
                                    <th data-options="field:'code1'" width="10%">监测状态</th>
                                    <th data-options="field:'code2'" width="10%">监测日期</th>
                                    <th data-options="field:'code3'" width="10%">项目名称</th>
                                    <th data-options="field:'code4'" width="10%">是否停产</th>
                                    <th data-options="field:'code5'" width="10%">监测值</th>
                                    <th data-options="field:'code6'" width="10%">限值</th>
                                    <th data-options="field:'code7'" width="10%">是否达标</th>
                                    <th data-options="field:'code7'" width="10%">超标倍数</th>
                                    <th data-options="field:'code7'" width="10%">备注</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

               <#-- 自动监控日-->
                <div title="自动监控日" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="排口名称">排口名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="污染物">污染物：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期：</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>

                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="16.7%">排口名称</th>
                                    <th data-options="field:'code2'" width="16.7%">监测时间</th>
                                    <th data-options="field:'code3'" width="16.7%">污染物</th>
                                    <th data-options="field:'code4'" width="16.7%">监测值</th>
                                    <th data-options="field:'code5'" width="16.7%">标准值</th>
                                    <th data-options="field:'code6'" width="16.7%">是否超标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div title="废水监测" >
            <div id="tt2" class="easyui-tabs alone-easyui-tabs" style="width:898px;">

                <div title="自动监控小时" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">排口名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">污染物：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>

                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期"> &nbsp;&nbsp;监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>

                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                    <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                    <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                    <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                    <th data-options="field:'code5'" width="14.3%">检测值</th>
                                    <th data-options="field:'code6'" width="14.3%">单位</th>
                                    <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

                <#-- 监督性监测-->
                <div title="监督性监测" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>


                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:400px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="14.3%">监测日期</th>
                                    <th data-options="field:'code2'" width="14.3%">监测点名称</th>
                                    <th data-options="field:'code3'" width="14.3%">监测点状态</th>
                                    <th data-options="field:'code4'" width="14.3%">项目名称</th>
                                    <th data-options="field:'code5'" width="14.3%">检测值</th>
                                    <th data-options="field:'code6'" width="14.3%">单位</th>
                                    <th data-options="field:'code7'" width="14.3%">是否达标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

                <#-- 自行监测-->
                <div title="自行监测" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">监测点名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto; vertical-align: middle" title="监测类型">监测类型：</label>
                                    <div class="inline-radio-box">
                                        <input  type="radio"> <label>自行监测</label>   <input  type="radio"> <label>手工监测</label>
                                    </div>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="监测点名称">&nbsp;&nbsp;&nbsp;项目名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期:</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="10%">监测日期</th>
                                    <th data-options="field:'code1'" width="10%">监测状态</th>
                                    <th data-options="field:'code2'" width="10%">监测日期</th>
                                    <th data-options="field:'code3'" width="10%">项目名称</th>
                                    <th data-options="field:'code4'" width="10%">是否停产</th>
                                    <th data-options="field:'code5'" width="10%">监测值</th>
                                    <th data-options="field:'code6'" width="10%">限值</th>
                                    <th data-options="field:'code7'" width="10%">是否达标</th>
                                    <th data-options="field:'code7'" width="10%">超标倍数</th>
                                    <th data-options="field:'code7'" width="10%">备注</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>

                <#-- 自动监控日-->
                <div title="自动监控日" >
                    <div class="panel-group-container" style="padding:10px 10px 0 10px">
                        <div id="searchBar1" class="searchBar">
                            <form id="searchForm1">
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="排口名称">排口名称：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto" title="污染物">污染物：</label>
                                    <input class="easyui-combobox" name="pointName"  id="pointName" prompt="全部" data-options="
									url:'',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                                           style="width:100px;"/>
                                </div>
                                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                   onclick="doSearch()">查询</a>
                                <div class="inline-block">
                                    <label class="textbox-label textbox-label-before" style="min-width: auto"  title="监测日期">监测日期：</label>
                                    <input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
                                </div>

                            </form>
                        </div>
                    </div>
                    <div class="panel-group-container">
                        <div class="easyui-table-light">
                            <table  class="easyui-datagrid"
                                    style="width: 100%;height:370px;" toolbar="#search"
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
                                    <th data-options="field:'code1'" width="16.7%">排口名称</th>
                                    <th data-options="field:'code2'" width="16.7%">监测时间</th>
                                    <th data-options="field:'code3'" width="16.7%">污染物</th>
                                    <th data-options="field:'code4'" width="16.7%">监测值</th>
                                    <th data-options="field:'code5'" width="16.7%">标准值</th>
                                    <th data-options="field:'code6'" width="16.7%">是否超标</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<#-- 视频监控 -->
<script src="${request.contextPath}/static/camera-zp/js/slplayer.js"></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera.js'></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

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

    });


    $(".personnel-list-container").on("click",".personnel-parent",function(){
        var $p=$(this);
        $p.siblings(".personnel-children").slideToggle("slow",function(){
            if($(this).is(":visible")){
                $p.addClass("collapsed");
                var $tables=$p.offsetParent().find(".easyui-datagrid");
                $tables.datagrid("resize").datagrid("resize");
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


    // 点击详情事件
    $('.info-part').on('click','.more-info',function(){
        var box = $(".info-content")
        if(box.hasClass("open")){
            box.removeClass("open");
        }else {
            box.addClass("open");
        }
    });

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

    }
    //btn-group
    $('.btn-group').on('click','.btn',function(){
        var $parent=$(this).parents('.btn-group');
        var $all=$parent.find(".btn");
       alert( $(this).find("span").text())
        $all.removeClass("active");
        $(this).addClass("active");
    });

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

    $(document).ready(function(){
         ChangeHeight()
        $('#infoDlg4').dialog('open').dialog('center').dialog('setTitle', '一企一档详情');

        $(".right-link-tag").on("click", function () {
            debugger
            $('#infoDlg3').dialog('open').dialog('center').dialog('setTitle', '企业信息明细');
        })
        })



    /**
     * 单个视频监控弹窗
     * @param info
     */
    var camera = new fjzx.camera.Camera({
        "elementId": "fjzx-camera-dialog",
        "playerCount": 1
    });
    camera.initPlayers();
    camera.initWinControl();
    camera.initPTZControl('fjzx-camera-dialog');//云台控制

    $(".camera-control-container").css({width: "50%", position: "absolute", right: "0", zIndex: "99"})
    $(".view_container").css({position:  "absolute",width: "50%"})

    // 视屏监控弹窗
     $(".video-show").click(function () {
         $('#zpCameraDlg').dialog('open').dialog('center').dialog('setTitle', '视屏监控');　　
     })

    


</script>

</html>
