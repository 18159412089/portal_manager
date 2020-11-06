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
        #home-left{width: 50%;margin:0;float: left;}
        #home-right{width: 50%; float: left;}
        #home-air,#home-water{}
        #home-air .layui-tab-content {height: 465px;}
        .TV-screen-container  #home-air .layui-tab-content{height: 473px;}
        #home-air .basin-name-container {
            width: 200px;
            height: 200px;
        }
        #home-water .layui-tab-content{height: 370px;}
        .home-container{margin: 12px;}
        .home-layout .home-panel{margin: 0 12px;}
        .row {padding: 0 15px;}
        .home-window-body .layui-tab-content .layui-tab-brief .layui-tab-content{
            height: 400px;
        }
        .home-window-body .layui-tab-content .layui-tab-brief .layui-tab-content .layui-tab-item{
            height: 100%;
        }
        @media (max-width: 1440px) {
            #home-air .basin-name-container {
                width: 160px;
                height: 160px;
                margin-bottom: 30px;
                margin-top: 20px;
            }
            #home-air .layui-tab-content{height: 444px;}
            .row {padding: 0;}
            .home-layout .home-panel-body > .home-panel {margin: 0px 15px;}
        }
        @media (max-width: 1365px) {
            #home-left{width: 100%;float: none;}
            #home-right{width: 100%;float: none;margin-top: 15px; }
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
        <a class="btn-inspector2" href="">
            <span class="icon iconcustom icon-shouye2"></span>返回首页
        </a>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云转阴</span>
        <span id="weatherDate">周一 09月30日 (实时：28℃)</span>
    </div>
    <div class="header-logo">
        <h1 class="logo-text">
            漳浦生态环境数据汇聚平台
            <div class="btn-switch-tv">TV</div>
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
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-gongchang2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name" title="工业废气企业">工业废气企业</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-paifang1"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name" title="废气排口">废气排口</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-GIS2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">网格事件</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="home-panel">
                    <div class="home-panel-bg"></div>
                    <div class="home-panel-header">
                        <div class="home-panel-bg"></div>
                        <a href="#" target="" class="more fr">详情</a>
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
                                    <div class="row" id="">
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 green">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">二氧化氮</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 blue">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">臭氧</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 yellow">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">PM10</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 orange">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">PM2.5</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 red">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">二氧化硫</div>
                                                        <div class="value">23</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="basin-name-container circle-1 purple">
                                                <div class="basin-bg">
                                                    <div class="bg-img bg-1"></div>
                                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                                </div>
                                                <div class="basin-text-box">
                                                    <div class="basin-text">
                                                        <div class="name">一氧化碳</div>
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
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-gongchang1"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">工业废水企业</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-shuibengzhan"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">污水处理厂</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-jinanhaiyangdianweixinxi"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">小流域</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-paifang2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">常规排口</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="grid-info">
                            <div class="home-panel-bg"></div>
                            <div class="panel-left">
                                <span class="icon iconcustom icon-GIS2"></span>
                            </div>
                            <div class="panel-right">
                                <div class="name">网格事件</div>
                                <div><span>154</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="home-panel">
                    <div class="home-panel-bg"></div>
                    <div class="home-panel-header">
                        <div class="home-panel-bg"></div>
                        <a href="#" target="" class="more fr">详情</a>
                        <span class="title">
                            <span class="icon iconcustom icon-shuju3"></span>
                            <span>综合水质数据</span>
                        </span>
                    <#--<span class="other">2019.01.01~2019.05.28</span>-->
                    </div>
                    <!--面板主内容-->
                    <div class="home-panel-body">
                        <div class="layui-tab layui-tab-zp-green">
                            <ul class="layui-tab-title">
                                <li class="layui-this">龙岭溪口</li>
                                <li>双溪口桥</li>
                                <li>棕口桥</li>
                                <li>蒲野桥</li>
                                <li>漳浦一中</li>
                                <li>漳浦一中</li>
                                <li>漳浦一中</li>
                                <li>漳浦一中</li>
                                <li>漳浦一中</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <div class="row" id="">
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
<!--弹窗-->
<div id="dd" class="home-window window-green" style="width: 1400px;height: 700px;">
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
            <#--<span class="icon iconcustom icon-shuju3"></span>-->
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
                        <div class="layui-tab-content" >
                            <div class="layui-tab-item layui-show">
                                <div class="panel-group-container">
                                    <div class="panel-group-top">
                                        <span id="pointName">南靖上洋</span>
                                    </div>
                                    <div class="panel-group-body">
                                        <div class="panel-info" id="pointInfo"><span>经度：117.11369</span><span>纬度：24.74764</span><span>流域：九龙江(大雁石溪、北溪)</span><span>控制级别：省控</span><span>目标水质：Ⅲ </span><span style="color:black">综合水质评价：-</span></div>
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
                            <div class="layui-tab-item">
                                <div class="data-analysis">
                                    <div id="polluteCodeList" class="radio-button-group style-list fl" style="width: 160px;height:100%;">
                                        <span id="ph" class="active" value="W01009" unit="(mg/L)">溶解氧</span>
                                        <span value="W01019" unit="(mg/L)">高锰酸盐</span>
                                        <span value="W21003" unit="(mg/L)">氨氮</span>
                                        <span value="W21011" unit="(mg/L)">总磷</span>
                                    </div>
                                    <div class="oh data-analysis-content">
                                        <div id="timeList" class="radio-button-group">
                                            <span id="24h" class="" value="24">最近24小时</span>
                                            <span value="72" class="active">最近72小时</span>
                                        </div>
                                        <div id="waterPointBar" style="height: 360px;"></div>
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
            </div>
        </div>
    </div>
</div>
<!--弹窗 over-->
</body>
<!-- 基础的js-->
<#include "/zphb/common/baseJs.ftl"/>
<!--开发 js-->


<!-- 页面 js -->
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    $(function () {
        layer.open({
            title: '在线调试'
            ,content: '可以填写任意的layer代码'
        });
        /*切换大屏*/
        $(".btn-switch-tv").click(function(){
            var text=$(this).text();
            if(text==="TV"){
                $("body").addClass("TV-screen-container");
                $(this).text("Web");

            }else{
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
        homeDialogOpen('#dd');
    });
    $(window).resize(function() {

    });
</script>

</html>
