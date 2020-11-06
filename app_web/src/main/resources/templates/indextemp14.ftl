<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳州生态云-首页</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologyPlatform.css"/>
<style type="text/css">

</style>
<!-- 头部 -->
<header class="home-air-header-container">
    <div class="header-logo">
        <h1 class="logo-text" >
            漳州生态云平台
        </h1>
    </div>
</header>
<!-- 头部 over  -->
<div class="container">
    <div class="item-box">
        <a class="item" href="${request.contextPath}/enviromonit/water/nationalSurfaceWater" target="_blank"
           title="展示水环境环境监测情况和环评情况。提供水质评价查询、常规监测数据查询及断面档案管理功能。"
        >
           <div class="info-top">
               <img src="${request.contextPath}/static/images/air/img-icon1.png">
               <span>水环境</span>
           </div>
          <div class="tex">
              <p>展示水环境环境监测情况和环评情况。提供水质评价查询、常规监测数据查询及断面档案管理功能。</p>
          </div>
        </a>
        <a class="item" href="${request.contextPath}/enviromonit/airEnvironment" target="_blank"
           title="收集和整理相关大气数据信息，提供气科部门进行分析和决策，防范各类气安全风险。"
        >
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon2.png">
                <span>大气环境</span>
            </div>
            <div class="tex">
                <p>收集和整理相关大气数据信息，提供气科部门进行分析和决策，防范各类气安全风险。</p>
            </div>
        </a>
        <a class="item" href="${request.contextPath}/environment/rectifition/show?authority=1" target="_blank"
           title="出生态问题统一监管，环保督查任务进度，环境问题整治情况，污染项目整改情况，各环保部门验收情况。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon3.png">
                <span>突出生态环境问题</span>
            </div>
            <div class="tex">
                <p>出生态问题统一监管，环保督查任务进度，环境问题整治情况，污染项目整改情况，各环保部门验收情况。</p>
            </div>
        </a>
        <a class="item" href="${request.contextPath}/environment/hugeData" target="_blank"
        title="展示监测区域总体水、空气质量指数；地图细化展示子区域总体水、气质量数据；状态栏展示七大应用层：水环境、大气环境、应用服务、数据服务、目标责任、系统管理和网格化。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon4.png">
                <span>年数据大屏</span>
            </div>
            <div class="tex">
                <p>展示监测区域总体水、空气质量指数；地图细化展示子区域总体水、气质量数据；状态栏展示七大应用层：水环境、大气环境、应用服务、数据服务、目标责任、系统管理和网格化。</p>
            </div>
        </a>
    </div>
    <div class="item-box">
        <a class="item" href="${request.contextPath}/epa/epaMonitorMap.do?menu=applicationServiceMenu" target="_blank"
        title="运用各种技术实现污染源监测、核与辐射监测数据分析，支持关键字检索；另外还有视频监控、流域监控、数据监控进行全方位监控。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon5.png">
                <span>应用服务</span>
            </div>
           <div class="tex">
               <p>运用各种技术实现污染源监测、核与辐射监测数据分析，支持关键字检索；另外还有视频监控、流域监控、数据监控进行全方位监控。</p>
           </div>
        </a>
        <a class="item" href="${request.contextPath}/env/mainPage/main.do?type=newDataServiceData" target="_blank"
        title="该模块提供了对数据管理维护、数据服务管理、数据集成交换、数据集成现状维护，对资源统计的数据进行查询、维护公共代码管理等。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon6.png">
                <span>数据服务</span>
            </div>
           <div class="tex">
               <p>该模块提供了对数据管理维护、数据服务管理、数据集成交换、数据集成现状维护，对资源统计的数据进行查询、维护公共代码管理等。</p>
           </div>
        </a>
        <a class="item" href="${request.contextPath}/environment/attach/environmentAttachDisplay?authority=1" target="_blank"
        title="提交环境问题治理情况，进行数据统计及汇总表。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon7.png">
                <span>八闽快讯一本账</span>
            </div>
           <div class="tex">
               <p>提交环境问题治理情况，进行数据统计及汇总表。</p>
           </div>
        </a>
    </div>
    <div class="item-box">
        <a class="item" href="${request.contextPath}/jobSchedule/cliqueBuild" target="_blank" title="党建目标责任制">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon8.png">
                <span>党政工作</span>
            </div>
            <div class="tex">
                <p>党建目标责任制。</p>
            </div>

        </a>
        <a class="item" href="${request.contextPath}/enter/mainPage/main.do?type=ENTER&menu=dataServiceMenu" target="_blank"
        title="可实现关键字查询和组合查询，实现企业信息的展示，展示企业污染源概况、污染排放数据、数据详情、污染源动态流程管理图、
                   监督性监测数据和自动监控数据等信息。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon9.png">
                <span>一企一档</span>
            </div>
           <div class="tex">
               <p>可实现关键字查询和组合查询，实现企业信息的展示，展示企业污染源概况、污染排放数据、数据详情、污染源动态流程管理图、
                   监督性监测数据和自动监控数据等信息。</p>
           </div>
        </a>
        <a class="item" href="https://140.237.73.123:8088/Epa/mainController?index" target="_blank"
        title="可实现环境监管全覆盖、责任到人的网格监管模式，极大优化落实环境监管责任，提升环境监管水平。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon10.png">
                <span>网格化</span>
            </div>
            <div class="tex">
                <p>可实现环境监管全覆盖、责任到人的网格监管模式，极大优化落实环境监管责任，提升环境监管水平。</p>
            </div>
        </a>
        <a class="item" href="${request.contextPath}/manage" target="_blank"
        title="系统管理子菜单，分权限管理登录；登陆日志与操作日志；监控管理人员以及环境执法监督，定时任务提醒。">
            <div class="info-top">
                <img src="${request.contextPath}/static/images/air/img-icon11.png">
                <span>系统管理</span>
            </div>
          <div class="tex">
              <p>系统管理子菜单，分权限管理登录；登陆日志与操作日志；监控管理人员以及环境执法监督，定时任务提醒。</p>
          </div>
        </a>
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


</script>
</html>