<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>污染源大地图</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>


</head>
<!-- body -->
<body class="pollution-body alone-pollution" >
<#include "/common/loadingDiv.ftl"/>
<style>
    #pf-hd{ height: 62px;}
    #pf-hd .pf-logo{ line-height: 62px;}
    .nav-container .nav-box >ul >li{height: 62px;}
    .nav-container .nav-box >ul .select-link a{ line-height: 62px;}
    .nav-container .nav-box >ul >li >a{line-height: 62px;
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
            <div class="map-case-list ">
                <div class="map-contaminated-title">
<#--                    <h3><span class="icon iconcustom icon-leibie5"></span> 图层控制</h3>-->
                    <p>截止2019年9月9日排查 </p>
                </div>

                <div  class="searchbox-item">
                    <input class="easyui-searchbox" data-options="prompt:'请输入企业名称',searcher:doSearch" style="width:98%">
                </div>

                <!--面板主内容-->
                <div class="personnel-list-container  contaminated-personnel-list">
                    <ul class="contaminated-personnel-ul">
                        <li class="item">
                            <div class="personnel-parent ">
                                <span>插值分析</span> <i></i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="map-describe-part">
                                    <p>
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
                              <span>城管局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src='/static/images/ssgyqy-icon.png'></span>餐饮企业 (26)</div>
                                                <div class="change-line no-choice choiced"><span><img src='/static/images/air/ghxtzx-icon.png'></span>道路扬尘(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/gjyqy-icon.png'></span>高架源企业(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/air/zjj-icon.png'></span>露天烧烤(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/air/wlj-icon.png'></span>商业活动(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/air/jtj-icon.png'></span>生活垃圾(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/air/gxj-icon.png'></span>沿海沿江生活垃圾(26)</div>
                                                <div class="change-line no-choice"><span><img src='/static/images/air/sthjj-icon.png'></span>渣土车(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>工信局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src='/static/images/VOCs-icon.png'></span> 石板材行业改造(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src='/static/images/gjyqy-icon.png'></span>道路扬尘(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>海洋局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" style="display: block">
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/gyfq-icon.png"></span> 规划外养殖(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/gywxfw-icon.png"></span>养殖废水(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/air/hsj-icon.png"></span>农业种植面源(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/air/zrzyj-icon.png"></span>入河入海排污口(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/air/swj-icon.png"></span>石板材行业改造(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/air/zjj-icon.png"></span>水产养殖污染(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/gywxfw-icon.png"></span>沿海沿江生活垃圾(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/gywxfw-icon.png"></span>养殖废水(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>  林业局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 自然保护区功能区保护(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/ybgy-icon.png"></span> 持证矿山(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/ybgy-icon.png"></span> 持证矿山问题(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>市商务局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 养殖废水 (26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>市应急管理局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 持证矿山问题(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 滨海旅游垃圾(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 河道问题(26)</div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>水利局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 闭坑矿山水保(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 城市生活污水处理厂(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 持证矿山问题(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 河道问题(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 漂浮垃圾(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 项目水保监管(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 园区基础设施(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 小水电站(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 养殖废水(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>漳州市文化和旅游局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 河道问题(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>漳州市住建系统</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 城市生活污水处理厂(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 生活垃圾(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 持证矿山问题(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 入河入海排污口(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 生活垃圾(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 生活污水(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="item">
                            <div class="personnel-parent">
                                <span>漳州市自然资源局</span> <i>56个</i>
                            </div>
                            <div class="personnel-children" >
                                <div class="personnel-info not-border">
                                    <div class="filter-container not-border" >
                                        <div class="filter-box">
                                            <div class="filter-content">
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 废弃矿山闭矿(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 持证矿山问题(26)</div>
                                                <div class="change-line no-choice choiced"><span><img src="/static/images/stwry-icon.png"></span> 非法采矿(26)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>




<#--                    <div class="soil-data">-->
<#--                        <div class="soil-title"><span class="icon iconcustom icon-turang"></span>区域划分  <div class="soil-search-tex" id="showSearch">高级搜索</div></div>-->
<#--                        <div class="soil-table-box">-->
<#--                            <!--搜索框&ndash;&gt;-->
<#--                            <div class="theme-content searchInfo"  >-->
<#--                                <div class="search-container" id="search">-->
<#--                                    <div class="search-box">-->
<#--                                        <input class="easyui-textbox" style="width:100%;"/>-->
<#--                                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"></a>-->
<#--                                    </div>-->
<#--                                </div>-->
<#--                                <div class="easyui-table-light">-->
<#--                                    <table id="test2" class="easyui-datagrid"-->
<#--                                           style="width: 100%;height:272px;" toolbar="#search"-->
<#--                                           url=""-->
<#--                                           data-options="-->
<#--							            rownumbers:false,-->
<#--							            singleSelect:true,-->
<#--							            striped:false,-->
<#--							            autoRowHeight:false,-->
<#--							            pagination:true,-->
<#--							            pageSize:10,-->
<#--							            nowrap:false">-->
<#--                                        <thead>-->
<#--                                        <tr>-->
<#--                                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>-->
<#--                                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>-->
<#--                                            <th field="qymc" width="200" formatter="Ams.tooltipFormat">企业名称</th>-->
<#--                                        </tr>-->
<#--                                        </thead>-->
<#--                                    </table>-->
<#--                                </div>-->

<#--                            </div>-->
<#--                            <!--搜索框 over&ndash;&gt;-->

<#--                            <ul class="soil-table-list">-->
<#--                                <li class="item">-->
<#--                                    <div class="personnel-parent alone-personnel-parent">-->
<#--                                        <span>水环境污染源</span> <i>56个</i>-->
<#--                                    </div>-->
<#--                                    <div class="personnel-children alone-personnel-parent" >-->
<#--                                        <div class="personnel-info not-border not-padding">-->
<#--                                            <div class="personnel-parent alone-personnel-parent not-border"  >-->
<#--                                                污水处理厂 <span>22 个</span>-->
<#--                                            </div>-->
<#--                                            <div class="personnel-children alone-personnel-parent" >-->
<#--                                                <div class="personnel-info not-border">-->
<#--                                                    <div class="filter-container not-border not-padding">-->
<#--                                                        <div class="filter-box not-border">-->
<#--                                                            <div class="filter-content not-margin">-->
<#--                                                                <div class="slid-table-box">-->
<#--                                                                    <table class="easyui-datagrid"  id="tt">-->
<#--                                                                        <thead>-->
<#--                                                                        <tr>-->
<#--                                                                            <th data-options="field:'code'">Code</th>-->
<#--                                                                            <th data-options="field:'name'">Name</th>-->
<#--                                                                            <th data-options="field:'price'">Price</th>-->
<#--                                                                        </tr>-->
<#--                                                                        </thead>-->
<#--                                                                        <tbody>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>001</td><td>name1</td><td>2323</td>-->
<#--                                                                        </tr>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>002</td><td>name2</td><td>4612</td>-->
<#--                                                                        </tr>-->
<#--                                                                        </tbody>-->
<#--                                                                    </table>-->
<#--                                                                </div>-->
<#--                                                            </div>-->
<#--                                                        </div>-->
<#--                                                    </div>-->
<#--                                                </div>-->
<#--                                            </div>-->
<#--                                        </div>-->
<#--                                    </div>-->
<#--                                </li>-->
<#--                                <li class="item">-->
<#--                                    <div class="personnel-parent alone-personnel-parent">-->
<#--                                        <span>水环境污染源</span> <i>56个</i>-->
<#--                                    </div>-->
<#--                                    <div class="personnel-children alone-personnel-parent" >-->
<#--                                        <div class="personnel-info not-border">-->
<#--                                            <div class="personnel-parent alone-personnel-parent" >-->
<#--                                                污水处理厂 <span>22 个</span>-->
<#--                                            </div>-->
<#--                                            <div class="personnel-children alone-personnel-parent" >-->
<#--                                                <div class="personnel-info not-border">-->
<#--                                                    <div class="filter-container not-border not-padding">-->
<#--                                                        <div class="filter-box">-->
<#--                                                            <div class="filter-content not-margin">-->
<#--                                                                <div class="slid-table-box">-->
<#--                                                                    <table class="easyui-datagrid"  id="tt">-->
<#--                                                                        <thead>-->
<#--                                                                        <tr>-->
<#--                                                                            <th data-options="field:'code'">Code</th>-->
<#--                                                                            <th data-options="field:'name'">Name</th>-->
<#--                                                                            <th data-options="field:'price'">Price</th>-->
<#--                                                                        </tr>-->
<#--                                                                        </thead>-->
<#--                                                                        <tbody>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>001</td><td>name1</td><td>2323</td>-->
<#--                                                                        </tr>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>002</td><td>name2</td><td>4612</td>-->
<#--                                                                        </tr>-->
<#--                                                                        </tbody>-->
<#--                                                                    </table>-->
<#--                                                                </div>-->
<#--                                                            </div>-->
<#--                                                        </div>-->
<#--                                                    </div>-->
<#--                                                </div>-->
<#--                                            </div>-->
<#--                                        </div>-->
<#--                                    </div>-->
<#--                                </li>-->
<#--                                <li class="item">-->
<#--                                    <div class="personnel-parent alone-personnel-parent">-->
<#--                                        <span>水环境污染源</span> <i>56个</i>-->
<#--                                    </div>-->
<#--                                    <div class="personnel-children alone-personnel-parent" >-->
<#--                                        <div class="personnel-info not-border">-->
<#--                                            <div class="personnel-parent alone-personnel-parent" >-->
<#--                                                污水处理厂 <span>22 个</span>-->
<#--                                            </div>-->
<#--                                            <div class="personnel-children alone-personnel-parent" >-->
<#--                                                <div class="personnel-info not-border">-->
<#--                                                    <div class="filter-container not-border not-padding">-->
<#--                                                        <div class="filter-box">-->
<#--                                                            <div class="filter-content not-margin">-->
<#--                                                                <div class="slid-table-box">-->
<#--                                                                    <table class="easyui-datagrid"  id="tt">-->
<#--                                                                        <thead>-->
<#--                                                                        <tr>-->
<#--                                                                            <th data-options="field:'code'">Code</th>-->
<#--                                                                            <th data-options="field:'name'">Name</th>-->
<#--                                                                            <th data-options="field:'price'">Price</th>-->
<#--                                                                        </tr>-->
<#--                                                                        </thead>-->
<#--                                                                        <tbody>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>001</td><td>name1</td><td>2323</td>-->
<#--                                                                        </tr>-->
<#--                                                                        <tr>-->
<#--                                                                            <td>002</td><td>name2</td><td>4612</td>-->
<#--                                                                        </tr>-->
<#--                                                                        </tbody>-->
<#--                                                                    </table>-->
<#--                                                                </div>-->
<#--                                                            </div>-->
<#--                                                        </div>-->
<#--                                                    </div>-->
<#--                                                </div>-->
<#--                                            </div>-->
<#--                                        </div>-->
<#--                                    </div>-->
<#--                                </li>-->
<#--                            </ul>-->
<#--                        </div>-->
                    close-popup-tag
<#--                    </div>-->
                </div>
                <!--面板主内容 over-->
            </div>

        </div>


    </div>
</div>

<!-- dialog1 -->
<div id="infoDlg" class="easyui-dialog" style="width:900px;height:400px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="panel-group-container" style="padding: 0">
        <div id="tt" class="easyui-tabs" style="width:898px;height:450px;">
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

        //小于1366人员列表默认关闭
        var body_w = $('body').width();
        if(body_w<1200){
            var $target = $('.map-caselist-container');
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        }
    });

    $(window).resize(function() {
        //监听窗口变化，小于1366人员列表默认关闭
        var body_w = $('body').width();
        var $target = $('.map-caselist-container');
        if(body_w<1200){
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        }else{
            $target.addClass("show");
            $target.find('.btn-collapse').addClass("active");
        }
    });

    $(".personnel-list-container").on("click",".personnel-parent",function(){
        var $p=$(this);
        $("")
        $p.siblings(".personnel-children").slideToggle("slow",function(){
            if($(this).is(":visible")){
                $('#tt').datagrid();
                $p.removeClass("collapsed");
                ChangeHeight();



            }else{
                $p.addClass("collapsed");
                ChangeHeight()
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

    // 搜索框显示切换
    $("#showSearch").click(function () {
        ChangeHeight()
        if($(this).hasClass("select-Search")){
            $(this).removeClass("select-Search");
            $(this).text("高级搜索")
            $(".searchInfo").hide();
            $(".soil-table-list").show();
        }else{
            $(this).addClass("select-Search");
            $(this).text("返回")
            $(".searchInfo").show();
            $(".soil-table-list").hide();
        }

    })


    $(window).resize(function() {
        ChangeHeight()

    });


    function doSearch(value){

    }


    $(document).ready(function(){
        // $('#infoDlg').dialog('open').dialog('center').dialog('setTitle', '详情');　　
        $("#air").dialog('open').dialog('center').dialog('setTitle', '详情');
        $(".searchInfo").hide();
        })

</script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    /*头部导航翻页按钮*/
    var headHeight=62;
    $(function () {
        var pageNub = $(".nav-ul-tag").height() / headHeight;// 计算当前页数
        var page = 1;// 当前所在页码

        if(pageNub>1){
            $(".nav-menu-tag").show()
        }else {
            $(".nav-menu-tag").hide()
        }
//        getPage(3)

        //上一页
        $(".nav-prev").click(function () {
            console.log(page)
            if(page==1){
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")
            }
            if(page>1){
                console.log(page)
                page--
                if(page==1){
                    $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu");
                    $(this).addClass("invalid-menu")
                }else{
                    var Remainder = $(".nav-ul-tag").height()- (headHeight*(page))
                    $(".nav-ul-tag").animate({'margin-top':"-" +(page-1)*headHeight}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu")
                }
            }
        })


        /*下一页*/
        $(".nav-next").click(function () {
            if(page!=pageNub){
                page++
            }
            if(page==pageNub){
                var Remainder = $(".nav-ul-tag").height() -headHeight;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")

            }
            if(page<pageNub &&page!=pageNub){
                $(".nav-ul-tag").animate({'margin-top': "-" +(page-1)*headHeight}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        })

        // 设置当前页数
        function getpage(){

            if(page==pageNub){
                var Remainder = $(".nav-ul-tag").height() -headHeight;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(".nav-menu-tag .nav-next").addClass("invalid-menu")

            }
            if(page==1){
                $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu");
                $(".nav-menu-tag .nav-prev").addClass("invalid-menu")
            }
            if(page>1&&page!=pageNub){
                $(".nav-ul-tag").animate({'margin-top': "-" +(page-1)*headHeight}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        }

        //页面加载获取当前页数详情
        getpage()

        $(".a").click(function () {
            if($(this).hasClass('active')){
                // 包含active
                $(this).removeClass('active')
                // 然后移除多选操作
            }else{
                // 不包含
                $(this).addClass('active')
                // 然后添加多选操作
            }
        })
    })

function  mouseOver() {
    $(".nav-ul-tag").find("li").mouseover(function(){
        s_this  =$(this).text().trim();
        var  left =$(this).offset().left;
        $(".child-item").css("left",left+"px");
        console.info(menus)
         $.each(menus, function (j, o) {
            if(s_this == o.name){
                 var three = "";
                  $.each(o.children, function (i, n) {
                     three += '<li><a href="'+ n.url +'" target="_blank"><i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a></li>';
                 });
                  console.info(three)
                 $("#data").html(three);
              }
          });
        $(".child-item").fadeIn(600);;
    });
}
</script>

<script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script>

</script>


</html>









<#--
<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>汇报页-水环境</title>
</head>
<!-- body -->
<#--<body >-->
<#--<#include "/common/loadingDiv.ftl"/>-->
<#--<#include "/decorators/header.ftl"/>-->
<#--<div id="pf-hd" style="position: absolute;width:100%;min-width: 1340px;">-->
<#--    <span class="pf-logo">-->
<#--        <img src="/static/images/blocks1.png" align="absmiddle"/>  漳州生态云-->
<#--    </span>-->
<#--    <div class="pf-user">-->
<#--        <div class="pf-user-photo">-->
<#--            <img src="/static/images/main/user.png" alt="">-->
<#--        </div>-->
<#--        <h4 class="pf-user-name ellipsis">欢迎 <@sec.authentication property="principal.name"/></h4>-->
<#--        <i class="iconfont xiala">&#xe607;</i>-->

<#--        <div class="pf-user-panel">-->
<#--            <ul class="pf-user-opt">-->
<#--                <li>-->
<#--                    <a href="javascript:;">-->
<#--                        <i class="iconfont">&#xe60d;</i>-->
<#--                        <span class="pf-opt-name">用户信息</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li class="pf-modify-pwd" id="editpass">-->
<#--                    <a href="#" >-->
<#--                        <i class="iconfont">&#xe634;</i>-->
<#--                        <span class="pf-opt-name">修改密码</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li id="omDownload">-->
<#--                    <a href="#" >-->
<#--                        <i class="iconfont">&#xe670;</i>-->
<#--                        <span class="pf-opt-name">下载操作手册</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li class="pf-logout" id="loginOut">-->
<#--                    <a href="#" >-->
<#--                        <i class="iconfont">&#xe60e;</i>-->
<#--                        <span class="pf-opt-name">退出</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--            </ul>-->
<#--        </div>-->
<#--    </div>-->
<#--    &lt;#&ndash;  当导航只有一级开始&ndash;&gt;-->

<#--    <div  class="nav-container">-->
<#--        <div class="child-item" >-->
<#--            <ul id="data">-->
<#--                <li><a>网格员任务派发dffhhdfh</a></li>-->
<#--                <li><a>网格员任务派发</a></li>-->
<#--                <li><a>网格员任务派发</a></li>-->
<#--                <li><a>网格员任务派发</a></li>-->
<#--                <li><a>网格员任务派发</a></li>-->
<#--                <li><a>网格员任务派发</a></li>-->
<#--            </ul>-->
<#--        </div>-->
<#--        <div class="nav-box">-->
<#--            <ul class="nav-ul-tag" id="second">-->
<#--                <li class="select-link">-->
<#--                    <a href="${request.contextPath}/index" target="_self">-->
<#--                        <i class="icon iconcustom icon-shouye1"></i>-->
<#--                        <span class="title">首页</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li class="active">-->
<#--                    <a href="${request.contextPath}/environment/hugeData" target="_blank">-->
<#--                        <i class="icon iconcustom icon-daping1"></i>-->
<#--                        <span class="title">大屏展示</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="${request.contextPath}/enviromonit/water/nationalSurfaceWater" target="_blank">-->
<#--                        <i class="icon iconcustom icon-shidu1"></i>-->
<#--                        <span class="title">水环境</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="${request.contextPath}/enviromonit/airEnvironment" target="_blank">-->
<#--                        <i class="icon iconcustom icon-huanjing2"></i>-->
<#--                        <span class="title">大气环境</span>-->
<#--                    </a>-->

<#--                </li>-->
<#--                <li>-->
<#--                    <a  href="${request.contextPath}/epa/epaMonitorMap.do?menu=applicationServiceMenu"  target="_blank">-->
<#--                        <i class="icon iconcustom icon-leibie2"></i>-->
<#--                        <span class="title">应用服务</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->

<#--                    <a  href="${request.contextPath}/env/mainPage/main.do?type=AQI&menu=dataServiceMenu" target="_blank">-->
<#--                        <i class="icon iconcustom icon-huanjing3"></i>-->
<#--                        <span class="title">数据服务</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="#" target="_self">-->
<#--                        <i class="icon iconcustom icon-jinanhaiyangdianweixinxi"></i>-->
<#--                        <span class="title">近岸海域信息</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank">-->
<#--                        <i class="icon iconcustom icon-huanjing2"></i>-->
<#--                        <span class="title">网格员任务派发</span>-->
<#--                    </a>-->
<#--                </li>-->


<#--                <li>-->
<#--                    <a href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank">-->
<#--                        <i class="icon iconcustom icon-huanjing2"></i>-->
<#--                        <span class="title">网格员任务派发</span>-->
<#--                    </a>-->
<#--                </li>-->

<#--                    <a href="${request.contextPath}/manage" target="_blank">-->
<#--                        <i class="icon iconcustom icon-leibie2"></i>-->
<#--                        <span class="title">系统管理</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="${request.contextPath}/manage" target="_blank">-->
<#--                        <i class="icon iconcustom icon-leibie2"></i>-->
<#--                        <span class="title">系统管理</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="${request.contextPath}/manage" target="_blank">-->
<#--                        <i class="icon iconcustom icon-leibie2"></i>-->
<#--                        <span class="title">系统管理</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="${request.contextPath}/manage" target="_blank">-->
<#--                        <i class="icon iconcustom icon-leibie2"></i>-->
<#--                        <span class="title">系统管理</span>-->
<#--                    </a>-->
<#--                </li>-->


<#--            </ul>-->
<#--        </div>-->
<#--        <div class="nav-menu-tag">-->
<#--            <a class="nav-prev invalid-menu">-->
<#--                <span class="icon iconcustom "></span>-->
<#--            </a>-->
<#--            <a class="nav-next">-->
<#--                <span class="icon iconcustom"></span>-->
<#--            </a>-->
<#--        </div>-->
<#--    </div>-->

<#--</div>-->
<#--<script>-->

<#--    var menus = "";-->

<#--    $(function() {-->
<#--        // 二级菜单事件-->
<#--        var s_this ;-->




<#--        $.ajax({-->
<#--            type: 'POST',-->
<#--            dataType : 'json',-->
<#--            url: '/sys/menu/getFrontSecondAndChileMenu',-->
<#--            data : {-->
<#--                pids : "8cc443b5-53d2-4db0-b2f7-f0901df961ea"//$("#pid").val()-->
<#--            },-->
<#--            // beforeSend: ajaxLoading,-->
<#--            success: function(data){-->
<#--                console.info(data);-->
<#--                menus = data;-->
<#--                var second = "";-->
<#--                $.each(data, function (i, o) {-->
<#--                    second += '<li><a href="'+ o.url +'" target="_blank"><i class="icon iconcustom '+ o.icon +'"></i>' +-->
<#--                        '                        <span class="title">'+ o.name +'</span></a></li>';-->
<#--                });-->

<#--                $(".nav-ul-tag").find("li").mouseout(function(){-->
<#--                    $(".child-item").fadeOut(400);-->
<#--                });-->


<#--                $(".child-item").mouseover(function(){-->
<#--                    $(this).show()-->
<#--                    s_this.addClass("select-link")-->
<#--                });-->

<#--                $(".child-item").mouseout(function(){-->
<#--                    $(this).hide()-->
<#--                    s_this.removeClass("select-link")-->
<#--                });-->

<#--               $("#second").html(second);-->
<#--                mouseOver();-->
<#--            }-->
<#--        });-->
<#--    });-->

<#--</script>-->

<#--<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>-->
<#--
<script type="text/javascript">

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    /*头部导航翻页按钮*/
    $(function () {
        var pageNub = $(".nav-ul-tag").height() / 70;// 计算当前页数
        var page = 1;// 当前所在页码

        if(pageNub>1){
            $(".nav-menu-tag").show()
        }else {
            $(".nav-menu-tag").hide()
        }
//        getPage(3)

        //上一页
        $(".nav-prev").click(function () {
            console.log(page)
            if(page==1){
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")
            }
            if(page>1){
                console.log(page)
                page--
                if(page==1){
                    $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu");
                    $(this).addClass("invalid-menu")
                }else{
                    var Remainder = $(".nav-ul-tag").height()- (70*(page))
                    $(".nav-ul-tag").animate({'margin-top':"-" +(page-1)*70}, 250);
                    $(".nav-menu-tag a").removeClass("invalid-menu")
                }
            }
        })


        /*下一页*/
        $(".nav-next").click(function () {
            if(page!=pageNub){
                page++
            }
            if(page==pageNub){
                var Remainder = $(".nav-ul-tag").height() -70;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(this).addClass("invalid-menu")

            }
            if(page<pageNub &&page!=pageNub){
                $(".nav-ul-tag").animate({'margin-top': "-" +(page-1)*70}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        })

        // 设置当前页数
        function getpage(){

            if(page==pageNub){
                var Remainder = $(".nav-ul-tag").height() -70;
                $(".nav-ul-tag").animate({'margin-top': "-" + Remainder}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
                $(".nav-menu-tag .nav-next").addClass("invalid-menu")

            }
            if(page==1){
                $(".nav-ul-tag").animate({'margin-top': "0"}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu");
                $(".nav-menu-tag .nav-prev").addClass("invalid-menu")
            }
            if(page>1&&page!=pageNub){
                $(".nav-ul-tag").animate({'margin-top': "-" +(page-1)*70}, 250);
                $(".nav-menu-tag a").removeClass("invalid-menu")
            }
        }

        //页面加载获取当前页数
        getpage()

        $(".a").click(function () {
            if($(this).hasClass('active')){
                // 包含active
                $(this).removeClass('active')
                // 然后移除多选操作
            }else{
                // 不包含
                $(this).addClass('active')
                // 然后添加多选操作
            }
        })
    })

function  mouseOver() {
    $(".nav-ul-tag").find("li").mouseover(function(){
        s_this  =$(this).text().trim();
        var  left =$(this).offset().left;
        $(".child-item").css("left",left+"px");
        console.info(menus)
         $.each(menus, function (j, o) {
            if(s_this == o.name){
                 var three = "";
                  $.each(o.children, function (i, n) {
                     three += '<li><a href="'+ n.url +'" target="_blank"><i class="icon iconcustom '+ n.icon +'"></i><span class="title">'+ n.name +'</span></a></li>';
                 });
                  console.info(three)
                 $("#data").html(three);
              }
          });
        $(".child-item").fadeIn(600);;
    });
}
</script>
-->

<#--</body>-->

<#--</html>&ndash;&gt;-->
