<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳浦环保-年度大数据</title>
    <!-- 基础 css -->
    <#include "/zphb/common/baseCss.ftl"/>
    <!-- 自定义 css（开发开发自己加的css一定要在自定义css之前）-->
    <#include "/zphb/common/customBaseCss.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
    <!-- 主题 css -->
    <#include "/zphb/common/zpThemeCss.ftl"/>

    <style type="text/css">
        #home-left {
            width: 50%;
            margin: 0;
            float: left;
        }

        #home-right {
            width: 50%;
            float: left;
        }

        #home-air, #home-water {
        }

        #home-air .layui-tab-content {
            height: 465px;
        }

        .TV-screen-container #home-air .layui-tab-content {
            height: 473px;
        }

        #home-air .basin-name-container {
            width: 200px;
            height: 200px;
        }

        #home-water .layui-tab-content {
            height: 370px;
        }

        .home-container {
            margin: 12px;
        }

        .home-layout .home-panel {
            margin: 0 12px;
        }

        .row {
            padding: 0 15px;
        }

        .home-window-body .layui-tab-content .layui-tab-brief .layui-tab-content {
            height: 400px;
        }

        .home-window-body .layui-tab-content .layui-tab-brief .layui-tab-content .layui-tab-item {
            height: 100%;
        }

        @media (max-width: 1440px) {
            #home-air .basin-name-container {
                width: 160px;
                height: 160px;
                margin-bottom: 30px;
                margin-top: 20px;
            }

            #home-air .layui-tab-content {
                height: 444px;
            }

            .row {
                padding: 0;
            }

            .home-layout .home-panel-body > .home-panel {
                margin: 0px 15px;
            }
        }

        @media (max-width: 1365px) {
            #home-left {
                width: 100%;
                float: none;
            }

            #home-right {
                width: 100%;
                float: none;
                margin-top: 15px;
            }
        }
    </style>
    <!-- js 在底部 -->

</head>
<!-- body -->
<body class="home-bg-2 TV-screen-container">
<#include "/common/loadingDiv.ftl"/>
<!-- 头部 -->
<header class="home-header-container header-left no-background">
    <div class="header-other">
        <a class="btn-inspector2" href="${request.contextPath}/index">
            <span class="icon iconcustom icon-shouye2"></span>返回首页
        </a>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云转阴</span>
        <span id="weatherDate">周一 09月30日 (实时：28℃)</span>
    </div>
    <div class="header-logo">
        <h1 class="logo-text">
            漳浦生态环境数据汇聚平台
            <div class="btn-switch-tv">Web</div>
        </h1>
    </div>
</header>
<!-- 头部 over-->
<div class="home-container">
    <div class="home-layout" id="home-left">
        <!--首页面板-->
        <div class="home-panel" id="home-air">
            <div class="home-panel-bg">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-bottom-left"></div>
                <div class="bg-bottom-right"></div>
            </div>
            <!--面板主内容-->
            <div class="home-panel-body">
                <div class="home-panel-header">大气环境</div>
                <div class="row">
                    <div class="col-xs-4" style="cursor: pointer;" onclick="airPollutionSkip(5)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-gongchang2"></span>
                            </div>
                            <div class="panel-right" >
                                <div class="name" title="工业废气企业">工业废气企业</div>
                                <div><span id="gasEnterprise">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4" style="cursor: pointer;" onclick="airPollutionSkip(5)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-paifang1"></span>
                            </div>
                            <div class="panel-right" >
                                <div class="name" title="废气排口">废气排口</div>
                                <div><span id="wasteGas">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4" style="cursor: pointer;" onclick="airPollutionSkip(6)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-GIS2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">网格事件</div>
                                <div><span>0</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="home-panel">
                    <div class="home-panel-bg"></div>
                    <div class="home-panel-header">
                        <div class="home-panel-bg"></div>
                        <a href="javascript:void(0)" class="more fr" onclick="homeDialogOpen2('#airdd')">详情</a>
                        <span class="title">
                            <span class="icon iconcustom icon-shuju3"></span>
                            <span>AQI污染因子最新数据</span>
                        </span>
                        <#--<span class="other">2019.01.01~2019.05.28</span>-->
                    </div>
                    <!--面板主内容-->
                    <div class="home-panel-body">
                        <div class="layui-tab layui-tab-zp-green">
                            <ul class="layui-tab-title">
                                <li class="layui-this">漳浦气象局</li>
                                <li>漳浦一中</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <div class="row" id="350623101">
                                        最近7日无最新数据
                                    </div>
                                </div>
                                <div class="layui-tab-item">
                                    <div class="row" id="350623102">
                                        最近7日无最新数据
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>
            </div>

            <!--面板主内容 over-->
        </div>
        <!--首页面板 over-->
    </div>
    <div class="home-layout" id="home-right">
        <!--首页面板-->
        <div class="home-panel" id="home-water">
            <div class="home-panel-bg">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-bottom-left"></div>
                <div class="bg-bottom-right"></div>
            </div>
            <!--面板主内容-->
            <div class="home-panel-body">
                <div class="home-panel-header">水环境</div>
                <div class="row">
                    <div class="col-xs-4" style="cursor:pointer;" onclick="waterPollutionSkip(3)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-gongchang1"></span>
                            </div>
                            <div class="panel-right" >
                                <div class="name">工业废水企业</div>
                                <div><span id="wpfsqy">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4"  style="cursor:pointer;" onclick="waterPollutionSkip(1)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-shuibengzhan"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">污水处理厂</div>
                                <div><span id="wsclc">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4" style="cursor:pointer;" onclick="waterPollutionSkip(5)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-jinanhaiyangdianweixinxi"></span>
                            </div>
                            <div class="panel-right" >
                                <div class="name">小流域</div>
                                <div><span id="xly">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4" style="cursor:pointer;" onclick="waterPollutionSkip(2)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-paifang2"></span>
                            </div>
                            <div class="panel-right" >
                                <div class="name">常规排口</div>
                                <div><span id="cgpk">154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4" style="cursor:pointer;" onclick="waterPollutionSkip(6)">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-GIS2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">网格事件</div>
                                <div><span>0</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="home-panel">
                    <div class="home-panel-bg"></div>
                    <div class="home-panel-header">
                        <div class="home-panel-bg"></div>
                        <a href="javascript:void(0)" target="综合水质详情" class="more fr"
                           onclick="homeDialogOpen('#waterdd')">详情</a>
                        <span class="title">
                            <span class="icon iconcustom icon-shuju3"></span>
                            <span>综合水质数据</span>
                        </span>
                        <#--<span class="other">2019.01.01~2019.05.28</span>-->
                    </div>
                    <!--面板主内容-->
                    <div class="home-panel-body">
                        <div class="layui-tab layui-tab-zp-green">
                            <ul class="layui-tab-title" id="waterBasinList">

                            </ul>
                            <div class="layui-tab-content" id="waterBasinFactory">
                                <div class="layui-tab-item layui-show">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 green">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">PH值</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 blue">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">溶解氧</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 yellow">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">高锰酸盐</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 orange">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">氨氮</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 red">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">总氮</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-3 purple">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">总磷</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-tab-item">2<br>
                                    1. 宽度足够，就不会出现右上图标；宽度不够，就会开启展开功能。
                                    <br>2. 如果你的宽度是自适应的，Tab会自动判断是否需要展开，并适用于所有风格。
                                </div>
                                <div class="layui-tab-item">3</div>
                                <div class="layui-tab-item">4</div>
                                <div class="layui-tab-item">5</div>
                                <div class="layui-tab-item">6</div>
                                <div class="layui-tab-item">7</div>
                                <div class="layui-tab-item">8</div>
                                <div class="layui-tab-item">9</div>
                            </div>
                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>

            </div>

            <!--面板主内容 over-->
        </div>
        <!--首页面板 over-->
    </div>
</div>
<!--  大气详情弹窗 -->
<div id="airdd" class="home-window window-green" style="width: 1400px;height: 700px;">
    <div class="home-window-bg">
        <div class="bg-top-left"></div>
        <div class="bg-top-center"></div>
        <div class="bg-top-right"></div>
        <div class="bg-center-left"></div>
        <div class="bg-center-center"></div>
        <div class="bg-center-right"></div>
        <div class="bg-bottom-right"></div>
        <div class="bg-bottom-center"></div>
        <div class="bg-bottom-left"></div>
    </div>
    <div class="home-window-header">
        <a href="#" target="" class="close">
            <span class="icon iconcustom icon-shanchu3"></span>
        </a>
        <span class="title">
            <span class="icon iconcustom icon-shuju3"></span>
            <span>大气环境详情</span>
        </span>
    </div>
    <div class="home-window-body">
        <div class="layui-tab layui-tab-zp-green">
            <ul class="layui-tab-title">
                <li class="layui-this">漳浦气象局</li>
                <li>漳浦一中</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <div class="layui-tab layui-tab-brief">
                        <ul class="layui-tab-title">
                            <li class="layui-this">详细</li>
                            <li>数据分析</li>
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <div class="panel-group-container">
                                    <div class="panel-group-top">
                                        <span id="pointName">漳浦气象局</span>
                                    </div>
                                    <div class="panel-group-body">
                                        <div class="panel-info" id="pointInfo1">
                                            <span>经度：117.6038</span><span>纬度：24.1268</span><span>控制级别：省控</span><span>AQI：-</span><span>更新时间：-</span>
                                        </div>
                                        <div class="panel-table">
                                            <table class="table-info alone-table pdfview-table" id="pointTableInfo1">
                                                <tbody>
                                                <tr>
                                                    <td class="tit">因子名称</td>
                                                    <td class="tit">数值</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-tab-item">
                                <div class="data-analysis">
                                    <div id="radioList1" class="radio-button-group style-list fl"
                                         style="width: 160px;height:100%;">
                                        <span class="active" timeData="aqi">AQI</span>
                                        <span timeData="A21004">NO2</span>
                                        <span timeData="A21026">SO2</span>
                                        <span timeData="A34002">PM10</span>
                                        <span timeData="A34004">PM2.5</span>
                                        <span timeData="A05024">O3</span>
                                        <span timeData="A21005">CO</span>
                                    </div>
                                    <div class="oh data-analysis-content">
                                        <div id="option1" class="radio-button-group">
                                            <span class="active" timedata="24h">24小时</span>
                                            <span timedata="30d" class="">30天</span>
                                            <span timedata="1y" class="">1年</span>
                                        </div>
                                        <div id="AirtypeBar1" style="height: 360px;width:900px;margin: 0 auto;"></div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <div class="layui-tab layui-tab-brief">
                        <ul class="layui-tab-title">
                            <li class="layui-this">详细</li>
                            <li>数据分析</li>
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <div class="panel-group-container">
                                    <div class="panel-group-top">
                                        <span id="pointName">漳浦一中</span>
                                    </div>
                                    <div class="panel-group-body">
                                        <div class="panel-info" id="pointInfo2"><span>经度：117.61755</span><span>纬度：24.110472</span><span>控制级别：省控</span><span>AQI：-</span><span>更新时间：-</span>
                                        </div>
                                        <div class="panel-table">
                                            <table class="table-info alone-table pdfview-table" id="pointTableInfo2">
                                                <tbody>
                                                <tr>
                                                    <td class="tit">因子名称</td>
                                                    <td class="tit">数值</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-tab-item">
                                <div class="data-analysis">
                                    <div id="radioList2" class="radio-button-group style-list fl"
                                         style="width: 160px;height:100%;">
                                        <span class="active" timeData="aqi">AQI</span>
                                        <span timeData="A21004">NO2</span>
                                        <span timeData="A21026">SO2</span>
                                        <span timeData="A34002">PM10</span>
                                        <span timeData="A34004">PM2.5</span>
                                        <span timeData="A05024">O3</span>
                                        <span timeData="A21005">CO</span>
                                    </div>
                                    <div class="oh data-analysis-content">
                                        <div id="option2" class="radio-button-group">
                                            <span class="active" timedata="24h">24小时</span>
                                            <span timedata="30d" class="">30天</span>
                                            <span timedata="1y" class="">1年</span>
                                        </div>
                                        <div id="AirtypeBar2" style="height: 360px;width:900px;margin: 0 auto;"></div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--弹窗 over-->
<!--弹窗-->
<div id="waterdd" class="home-window window-green" style="width: 1400px;height: 700px;">
    <div class="home-window-bg">
        <div class="bg-top-left"></div>
        <div class="bg-top-center"></div>
        <div class="bg-top-right"></div>
        <div class="bg-center-left"></div>
        <div class="bg-center-center"></div>
        <div class="bg-center-right"></div>
        <div class="bg-bottom-right"></div>
        <div class="bg-bottom-center"></div>
        <div class="bg-bottom-left"></div>
    </div>
    <div class="home-window-header">
        <a href="#" target="" class="close">
            <span class="icon iconcustom icon-shanchu3"></span>
        </a>
        <span class="title">
            <span class="icon iconcustom icon-shuju3"></span>
            <span>水环境详情</span>
        </span>
    </div>
    <div class="home-window-body">
        <div class="layui-tab layui-tab-zp-green">
            <ul class="layui-tab-title" id="waterDetailDialog1">
                <li class="layui-this">漳浦气象局</li>
                <li>漳浦一中</li>
            </ul>
            <div class="layui-tab-content" id="waterDetailDialog2">
                <div class="layui-tab-item layui-show">
                    <div class="layui-tab layui-tab-brief">
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <div class="panel-group-container">
                                    <div class="panel-group-top">
                                        <span id="pointName">南靖上洋</span>
                                    </div>
                                    <div class="panel-group-body">
                                        <div class="panel-info" id="pointInfo"><span>经度：117.11369</span><span>纬度：24.74764</span><span>流域：九龙江(大雁石溪、北溪)</span><span>控制级别：省控</span><span>目标水质：Ⅲ </span><span
                                                    style="color:black">综合水质评价：-</span></div>
                                        <div class="panel-table">
                                            <table class="table-info alone-table pdfview-table" id="pointTableInfo">
                                                <tbody>
                                                <tr>
                                                    <td class="tit">因子名称</td>
                                                    <td class="tit">数值</td>
                                                    <td class="tit">级别</td>
                                                </tr>
                                                <tr>
                                                    <td>-名称</td>
                                                    <td>--数值</td>
                                                    <td>--级别</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!--弹窗 over-->
</body>
<!-- 基础的js-->
<#include "/zphb/common/baseJs.ftl"/>
<!--开发 js-->

<#-- 气相关的js -->
<script type="text/javascript" src="/static/zphb/js/datashow/air.js"></script>
<!-- 页面 js -->
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    layui.use('element', function () {
        var $ = layui.jquery
            , element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

    });

    $(function () {

        homeDialogInit('#airdd');

        /*切换大屏*/
        $(".btn-switch-tv").click(function () {
            var text = $(this).text();
            if (text === "TV") {
                $("body").addClass("TV-screen-container");
                $(this).text("Web");

            } else {
                $("body").removeClass("TV-screen-container");
                $(this).text("TV");
            }

        });
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            //doSearch();
        });
        //弹出框
        //;
        pollutionCount()//水环境数据处理
        waterBaisinList();//水环境数据小河流域列表
        waterPollutionClick()//小河流域跳转事件
        airPollutionClick()//大气环境跳转事件
    });
    $(window).resize(function () {

    });

    function waterBaisinList() {
        $.ajax({
            type: 'POST',
            data: {'year': year},
            url: Ams.ctxPath + '/zphb/dataShow/waterBasinList',
            success: function (result) {
                var liList = "";
                var waterBasinFactory = "";
                var waterDailog = "";
                var waterDailog2 = "";
                $("#waterBasinFactory").empty();
                var resultColor = "";

                for (var i = 0; i < result.length; i++) {
                    waterBasinFactory = "";
                    //ph值
                    if (i == 0) {
                        liList += '<li class="layui-this">' + result[i].basinName + '</li>';
                        waterDailog += '<li class="layui-this">' + result[i].basinName + '</li>';
                        waterBasinFactory += '<div class="layui-tab-item layui-show" ><div class="row" >';
                        waterDailog2 += '<div class="layui-tab-item layui-show" >';
                    } else {
                        waterDailog += '<li>' + result[i].basinName + '</li>';
                        liList += '<li>' + result[i].basinName + '</li>';
                        waterBasinFactory += '<div class="layui-tab-item " ><div class="row" >'
                        waterDailog2 += '<div class="layui-tab-item " >'
                    }
                    if ((result[i].result == "Ⅳ" || result[i].result == "Ⅴ" || result[i].result == "劣Ⅴ")) {
                        resultColor = "red";
                    }
                    //==================ph值
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">PH值</div><div class="value">' + result[i].ph + '</div>';
                    waterBasinFactory += '</div></div></div></div>';
                    //=======溶解氧===================
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">溶解氧</div><div class="value">' + result[i].rjy + '</div>';
                    waterBasinFactory += '</div></div> </div></div>';
                    //=============高锰酸盐==================
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">高锰酸盐</div><div class="value">' + result[i].gmsy + '</div>';
                    waterBasinFactory += '</div></div> </div></div>';
                    //==================氨氮=======================================
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">氨氮</div><div class="value">' + result[i].andan + '</div>';
                    waterBasinFactory += '</div></div></div></div>';
                    //===========================五日生化需氧量==============
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">五日生化需氧量</div><div class="value">' + result[i].wrshxyl + '</div>';
                    waterBasinFactory += '</div></div></div></div>';
                    //=========================总磷=============================
                    waterBasinFactory += '<div class="col-xs-4"><div class="basin-name-container circle-3 green"><div class="basin-bg"><div class="bg-img bg-1"></div>';
                    waterBasinFactory += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div></div>';
                    waterBasinFactory += '<div class="basin-text-box"><div class="basin-text"><div class="name">总磷</div><div class="value">' + result[i].zl + '</div>';
                    waterBasinFactory += '</div></div></div></div>';
                    waterBasinFactory += '</div></div>';
                    //================水环境弹窗数据展示===============
                    waterDailog2 += '<div class="layui-tab-item layui-show">';
                    waterDailog2 += '<div class="layui-tab layui-tab-brief">';
                    waterDailog2 += ' <div class="layui-tab-content" >';
                    waterDailog2 += '<div class="panel-group-container">';
                    waterDailog2 += '<div class="panel-group-top">';
                    waterDailog2 += '<span id="pointName">' + result[i].basinName + '</span>';
                    waterDailog2 += '</div><div class="panel-group-body">';
                    waterDailog2 += '<div class="panel-info" id="pointInfo' + i + '"><span>经度:' + result[i].lng + '</span><span>纬度:' + result[i].lat + '</span>';
                    waterDailog2 += '<span>目标水质:' + result[i].targetresult + ' <font style="color:' + resultColor + '"> &nbsp;&nbsp;&nbsp;&nbsp;综合水质评价:' + result[i].result + '</font></span></div>';
                    waterDailog2 += '<div class="panel-table">';
                    waterDailog2 += '<table class="table-info alone-table pdfview-table" id="pointTableInfo' + i + '">';
                    waterDailog2 += '<tbody><tr>';
                    waterDailog2 += '<td class="tit">因子名称</td>';
                    waterDailog2 += '<td class="tit">数值</td>';
                    waterDailog2 += ' <td class="tit">级别</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>PH</td>';
                    waterDailog2 += '<td>' + result[i].ph + '</td>';
                    waterDailog2 += '<td>' + result[i].phlevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>溶解氧</td>';
                    waterDailog2 += '<td>' + result[i].rjy + '</td>';
                    waterDailog2 += '<td>' + result[i].rjylevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>高猛酸盐</td>';
                    waterDailog2 += '<td>' + result[i].gmsy + '</td>';
                    waterDailog2 += '<td>' + result[i].gmsylevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>氨氮</td>';
                    waterDailog2 += '<td>' + result[i].andan + '</td>';
                    waterDailog2 += '<td>' + result[i].andanlevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>五日生化需氧量</td>';
                    waterDailog2 += '<td>' + result[i].wrshxyl + '</td>';
                    waterDailog2 += '<td>' + result[i].wrshxyllevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '<tr>';
                    waterDailog2 += '<td>总磷</td>';
                    waterDailog2 += '<td>' + result[i].zl + '</td>';
                    waterDailog2 += '<td>' + result[i].zllevel + '</td>';
                    waterDailog2 += '</tr>';
                    waterDailog2 += '</tbody></table></div></div></div></div></div></div></div></div>';
                    $("#waterBasinFactory").append(waterBasinFactory);
                }
                $("#waterBasinList").html(liList);
                $("#waterDetailDialog1").html(waterDailog);
                $("#waterDetailDialog2").html(waterDailog2);
                layui.element.init();

            },
            error: function () {
                Ams.error('数据获取失败！');
            },
            dataType: 'json'
        });
    }

    //===================================获取小河流域,污水处理厂等总数==============================
    var year = new Date().getFullYear();

    function pollutionCount() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/zphb/dataShow/getGkSkShowData',
            data: {'year': year},
            success: function (result) {
                //监控情况统计 【污水处理厂】【常规口】【污普废水企业】【小流域】
                var total = new Array(result.total);
                //设备检测区域下的汇总
                $('#wsclc').text(total[0][0][0]);
                $('#cgpk').text(total[0][0][1]);
                $('#wpfsqy').text(total[0][0][2]);
                $('#xly').text(total[0][0][3]);
            },
            error: function () {
                Ams.error('数据获取失败！');
            },
            dataType: 'json'
        });
    }

    //点击页面中的污水处理厂等总数进行页面跳转
    /*
     * @Param pid:
 * @Param target:目标比如污水处理厂等
 * @Param basinCode://流域名称
 * @Param waterPointCode://站点名称
 * @Param modelAndView://
     */
    function waterPollutionSkip(target) {
        window.open("/zphb/enviromonit/water/nationalSurfaceWater?pid=1&target=" + target)
    }
    function airPollutionSkip(target) {
        window.open("/zphb/enviromonit/airEnvironment?pid=2&target=" + target)
    }

    function waterPollutionClick() {

    }
    function airPollutionClick(){

    }


</script>

</html>
