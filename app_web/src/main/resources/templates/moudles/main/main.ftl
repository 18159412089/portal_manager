<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>突出生态环境问题-大数据</title>

</head>
<!-- body -->
<body class="TV-screen-container">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudInspector.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>
<!-- Swiper CSS js -->
<link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<style type="text/css">

</style>
<!-- 头部 -->
<header class="home-inspector-header-container">
    <div class="header-logo"><h1 class="logo-text" style="letter-spacing: 3px;">漳州生态云-生态环境问题 <div class="btn-switch-tv">Web</div></h1></div>
    <div class="header-nav p-right">
        <a href="${request.contextPath}/index" target="_blank">进入系统</a>
        <div class="option-box max-option-box">
            <a href="${request.contextPath}/environment/hugeData">大气环境 </a>
            <a href="${request.contextPath}/environment/waterDataShow">水环境</a>
            <a class="select-tag">生态环境问题</a>
        </div>
            <div class="option-box min-option-box">
                <ul>
                    <li><a class="select-tag">生态环境问题   <span class="icon iconcustom"></span></a></li>
                    <li><a href="${request.contextPath}/environment/hugeData">大气环境 </a></li>
                    <li><a href="${request.contextPath}/environment/waterDataShow">水环境</a></li>
                </ul>
            </div>
    </div>
    <div class="header-other p-left">
        <span id="weatherDate">2018年5月31日</span>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云  北风1~2级</span>
        <span id="wind">多云  北风1~2级</span>
        <span id="temperature">多云  北风1~2级</span>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-inspector-container">
    <!-- 左 -->
    <div class="home-layout fl" id="home-left">
        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <a href="javascript:void(0)" target="" class="more fr summary-tag">详情</a>
                <span class="title">
				<span class="icon iconcustom icon-renwuguanli1" ></span>
				<span>尚未启动任务</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="row" id="mainNotstart">
                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->

        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <a href="javascript:void(0)" target="" class="more fr overprogress-tag">详情</a>
                <span class="title">
				<span class="icon iconcustom icon-renwuguanli1" ></span>
				<span>超过序时进度</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="row"  id="mainOverprogress">
                    </div>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->

    </div>
    <!-- 左  over-->
    <!-- 右 -->
    <div class="home-layout fr" id="home-right">
        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <a href="javascript:void(0)" target=""  class="more fr acceptance-tag">详情</a>
                <span class="title">
				<span class="icon iconcustom icon-quxiaoguanlian4" ></span>
				<span>完成销号超过30天验收</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body" id="">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="layui-tab layui-tab-inspector">
                        <ul class="layui-tab-title">
                            <li class="layui-this">县级验收</li>
                            <li onclick="getCompleteAcceptance('CITY_ACTUAL_TIME')">市级验收</li>
                            <li onclick="getCompleteAcceptance('PROFESSION_ACTUAL_TIME')">行业验收</li>
                            <li onclick="getCompleteAcceptance('PROFESSION_EXAMINE_TIME')">行业审核</li>
                        </ul>
                        <div class="layui-tab-content lzw_content">
                            <div class="layui-tab-item layui-show row" id="mainxjys">
                            </div>
                            <div class="layui-tab-item row" id="mainsjys">
                            </div>
                            <div class="layui-tab-item row" id="mainhyys">
                            </div>
                            <div class="layui-tab-item row" id="mainhysh">
                            </div>
                        </div>
                    </div>
                </div>
                <!--面板主内容 over-->

            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <a href="javascript:void(0)" target=""  class="more fr warning-tag">详情</a>
                <span class="title">
				<span class="icon iconcustom icon-fengxian1" ></span>
				<span>未完成整改的项目</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body" id="">
                <!--面板主内容-->
                <div class="box-body row" id="wwczg">
                    <div class="col-xs-12 lzw_div">
                        <div class="sub-title">
                            <span id="proName0">龙海市汽车拆解</span>
                        </div>
                        <div class="sub-title">
                            <span class="item" id="dutyPerson0">责任人：黄渤</span>
                            <span class="item" id="time0">整改时限：2019-03-06</span>
                            <div class="state executing lzw_lay">
                                <!-- <div id="status0">执行中</div> -->
                                <div id="restTime0">剩余10天</div>
                            </div>
                        </div>
                        <div class="chart-box lzw_lay" id="pictorialBarChart"></div>
                    </div>
                    <div class="col-xs-12 lzw_div">
                        <div class="sub-title">
                            <span id="proName1">龙海市汽车拆解</span>
                        </div>
                        <div class="sub-title">
                            <span class="item" id="dutyPerson1">责任人：黄渤</span>
                            <span class="item" id="time1">整改时限：2019-03-06</span>
                            <div class="state unexpired lzw_lay">
                                <!-- <div id="status1">执行中</div> -->
                                <div id="restTime1">剩余10天</div>
                            </div>
                        </div>
                        <div class="chart-box lzw_lay" id="pictorialBarChart2"></div>
                    </div>
                    <div class="col-xs-12 lzw_div">
                        <div class="sub-title">
                            <span id="proName2">龙海市汽车拆解</span>
                        </div>
                        <div class="sub-title">
                            <span class="item" id="dutyPerson2">责任人：黄渤</span>
                            <span class="item" id="time2">整改时限：2019-03-06</span>
                            <div class="state expired lzw_lay">
                                <!-- <div id="status2">执行中</div> -->
                                <div id="restTime2">剩余10天</div>
                            </div>
                        </div>
                        <div class="chart-box lzw_lay" id="pictorialBarChart3"></div>
                    </div>
                    <div class="col-xs-12 lzw_div">
                        <div class="sub-title">
                            <span id="proName2">龙海市汽车拆解</span>
                        </div>
                        <div class="sub-title">
                            <span class="item" id="dutyPerson2">责任人：黄渤</span>
                            <span class="item" id="time2">整改时限：2019-03-06</span>
                            <div class="state expired lzw_lay">
                                <!-- <div id="status2">执行中</div> -->
                                <div id="restTime2">剩余10天</div>
                            </div>
                        </div>
                        <div class="chart-box lzw_lay" id="pictorialBarChart3"></div>
                    </div>
                </div>
                <!--面板主内容 over-->

            </div>
        </div>
        <!--首页面板 over-->

    </div>
    <!-- 右  over-->
    <!-- 中 -->
    <div class="home-layout oh" id="home-center">
        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <!-- <a href="javascript:void(0)" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-huanjing1" ></span>
				<span>突出生态环境问题</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body">
                <!--面板主内容-->
                <div class="box-body" id="highlightingProblems">
                    <div class="layui-tab layui-tab-inspector">
                        <ul class="layui-tab-title">
                            <li class="layui-this">整改汇总</li>
                            <li>交账销号</li>
                        </ul>
                        <div class="layui-tab-content  lzw_content">
                            <div class="layui-tab-item layui-show row">
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">我市中央环保督察问题</div>
                                                    <div class="name" id="all">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">尚未启动任务</div>
                                                    <div class="name" id="notstart">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">未达到序时进度任务</div>
                                                    <div class="name" id="notreach">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">达到序时进度任务</div>
                                                    <div class="name" id="ontime">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">超过序时进度任务</div>
                                                    <div class="name" id="pass">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">完成整改任务</div>
                                                    <div class="name" id="over">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">完成交账销号任务</div>
                                                    <div class="name" id="sendaccount">658个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="layui-tab-item row">
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">已完成整改销号任务</div>
                                                    <div class="name" id="zgxh">0个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">已完成县级验收</div>
                                                    <div class="name" id="xjys">0个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">已完成市级验收</div>
                                                    <div class="name" id="sjys">0个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">已提交行业验收</div>
                                                    <div class="name" id="tjys">0个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item col-xs-6">
                                    <div class="home-border-panel inspector-red">
                                        <div class="home-border-panel-bg">
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
                                        <div class="home-border-panel-bg active ani">
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
                                        <div class="home-border-panel-body">
                                            <div class="target-text-box">
                                                <div class="target-text">
                                                    <div class="area">已完成行业审查</div>
                                                    <div class="name" id="wcsc">0个</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>



                </div>
                <!--面板主内容 over-->

            </div>
        </div>
        <!--首页面板 over-->


    </div>
    <!-- 中  over-->
    <div class="ca"></div>
    <!-- 日目标管理 -->
    <div class="home-layout" id="urbanDistribution">
        <!--首页面板-->
        <div class="home-inspector-panel">
            <div class="home-inspector-panel-header">
                <a href="javascript:void(0)" target=""  class="more fr city-tag">详情</a>
                <span class="title">
				<span class="icon iconcustom icon-huanjing4" ></span>
				<span>城市分布</span>
			</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-inspector-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="layui-tab layui-tab-inspector">
                        <ul class="layui-tab-title">
                            <li class="layui-this" onclick="setFlag(0)">整改汇总</li>
                            <li onclick="setFlag(1)">交账销号</li>
                        </ul>
                        <div class="layui-tab-content  lzw_content">
                            <div class="layui-tab-item layui-show ca">
                                <div class="item">
                                    <div class="basin-name-container circle-2 orange">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city0"></div>
                                                <div id="num0">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 red">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city1"></div>
                                                <div id="num1">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city2"></div>
                                                <div id="num2">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 yellow">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city3"></div>
                                                <div id="num3">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 blue">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city4"></div>
                                                <div id="num4">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 green">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city5"></div>
                                                <div id="num5">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 orange">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city6"></div>
                                                <div id="num6">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 red">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city7"></div>
                                                <div id="num7">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city8"></div>
                                                <div id="num8">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city9"></div>
                                                <div id="num9">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-tab-item ca">
                                <div class="item">
                                    <div class="basin-name-container circle-2 orange">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_0"></div>
                                                <div id="num_0">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 red">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_1"></div>
                                                <div id="num_1">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_2"></div>
                                                <div id="num_2">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 yellow">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_3"></div>
                                                <div id="num_3">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 blue">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_4"></div>
                                                <div id="num_4">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 green">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_5"></div>
                                                <div id="num_5">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 orange">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_6"></div>
                                                <div id="num_6">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 red">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_7"></div>
                                                <div id="num_7">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_8"></div>
                                                <div id="num_8">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="basin-name-container circle-2 purple">
                                        <div class="basin-bg">
                                            <div class="bg-img bg-1"></div>
                                            <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                        </div>
                                        <div class="basin-text-box">
                                            <div class="basin-text">
                                                <div class="name" id="city_9"></div>
                                                <div id="num_9">0个</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>

                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
    </div>
    <!-- 日目标管理  over-->

</div>

<#-- 汇总整改 弹窗开始-->
<div class="new-supervision-show max-supervision-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-close">
                返回
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 尚未启动任务 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box summary-box">
                <div class="option-box">
                    <a class="select-tag">尚未启动任务 </a>
                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="supervisio-table" style="" lay-filter="supervisio-table">

                    </table>

                    <!--分页容器-->
                    <!-- <div id="page-container" class="page-supervision">

                    </div> -->
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->
<#-- 超过序时进度 弹窗开始-->
<div class="new-supervision-show max-overprogress-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-close">
                返回
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 超过序时进度 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box summary-box">
                <div class="option-box">
                    <a class="select-tag">超过序时进度 </a>
                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="overprogress-table" style="" lay-filter="overprogress-table">

                    </table>

                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->
<#-- 完成销号 弹窗开始-->
<div class="new-supervision-show max-acceptance-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <!--<a class="return-tag return-close">
                返回
            </a>-->

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 完成销号超过30天验收 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box summary-box">
                <div class="option-box">
                    <a class="select-tag" data-type="COUNTY_ACTUAL_TIME">县级验收</a>
                    <a data-type="CITY_ACTUAL_TIME">市级验收</a>
                    <a data-type="PROFESSION_ACTUAL_TIME">行业验收</a>
                    <a data-type="PROFESSION_EXAMINE_TIME">行业审核</a>
                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg" id="acceptance-table" style="" lay-filter="acceptance-table"  lay-data="{id: 'acceptance-table'}">

                    </table>

                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->
<#--查看详情弹窗开始-->
<div class="new-supervision-show details-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-max">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 渗滤液得不到妥善处理 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--查看详情表格-->
            <div class="spacing-box look-details-box">
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="details-table">
                    </table>

                    <!--分页容器-->
                    <div id="details-container" class="page-supervision"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--汇总预警 弹窗开始-->
<div class="new-supervision-show warning-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <!--<a class="return-tag return-close">
                <span class="icon iconcustom"></span>
            </a>-->

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 汇总整改预警 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--汇总预警 -->
            <div class="list-warning">
                <div class="spacing-box spacing-list"  id="divTable">
                    <div class="details-text">
                        <h5 >sfsfs</h5>
                        <div class="part-font">
                            <div class="data-item">
                                <span >问题描述</span>
                                <span >危险废物处置能力缺口问题</span>
                            </div>
                            <div class="data-item">
                                <span >整改任务具体要求</span>
                                <span>十五、一些地方对保护区内违法养殖查处不严，清退不力，漳州市漳江口红树林国家级自然保护区核心区有养殖面积323公顷，缓冲区有239公顷，2013年以来养殖面积仍在扩大，
核心区和缓冲区分别新增养殖面积约20公顷和11公顷。对保护区内的非法养殖问题实行分类处理。</span>
                            </div>
                            <div class="data-item">
                                <span >目前进展情况及存在问题</span>
                                <span >1.针对2003年以来违规扩大养殖面积。全面拆除2003年以来新增50.70公顷的养殖池塘堤岸、管理房、闸门等设施，加强日常巡护、无人机监控等监测措施，严格监控确保整改成
效，截至目前，没有发现返养行为。 2.针对2003年以前核心区缓冲区存在的养殖池塘。完成保护区范围内涉及15个村1001户716.58公顷养殖池塘调查建档工作。</span>
                            </div>
                        </div>
                        <div class="part-date">
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">行政区划：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">所属城市：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人电话：</span>
                                <span class="control-content">18865658888</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任单位：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头单位：</span>
                                <span class="control-content">厦门智慧指间</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任部门</span>
                                <span class="control-content"></span>';
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">配合单位：</span>
                                <span class="control-content">厦门</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及人员：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">创建时间：</span>';
                                <span class="control-content">2019-06-01</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及部门：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">整改时限：</span>
                                <span class="control-content">2019-06-04</span>
                            </div>
                        </div>
                        <div class="footer-font">
                            <span>完成交账销号</span>
                        </div>
                    </div>
                </div>
                <!--分页容器-->
                <div id="warning-container" class="page-supervision"></div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#-- 整改城市分布 弹窗开始-->
<div class="new-supervision-show city-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <#--<a class="return-tag return-close">-->
            <#--<span class="icon iconcustom"></span>-->
            <#--</a>-->

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 整改城市分布 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>
            <!--汇总整改表格-->
            <div class="spacing-box city-box">
                <div class="option-box" id="citys">

                </div>
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="city-table" style="" lay-filter="city-table" >
                    </table>

                    <!--分页容器-->
                    <!-- <div id="city-container" class="page-supervision">

                    </div> -->
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--城市详情弹窗开始-->
<div class="new-supervision-show details-city-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-city">
                <span class="icon iconcustom"></span>
            </a>

            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 城市详情 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--查看详情表格-->
            <div class="spacing-box look-city-box">
                <div class="table-box">
                    <table lay-even lay-skin="line" lay-size="lg"   id="details-city-table">
                    </table>

                    <!--分页容器-->
                    <div id="details-container-city" class="page-supervision"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<#--弹窗结束 -->
<#--汇总预警 弹窗开始-->
<div class="new-supervision-show notstart-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-notstart">
                <span class="icon iconcustom"></span>
            </a>
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 详情查看 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--汇总预警 -->
            <div class="list-warning">
                <div class="spacing-box spacing-list"  id="divTable">
                    <div class="details-text" id="notstart-detail">
                        <h5 >sfsfs</h5>
                        <div class="part-font">
                            <div class="data-item">
                                <span >问题描述</span>
                                <span >危险废物处置能力缺口问题</span>
                            </div>
                            <div class="data-item">
                                <span >整改任务具体要求</span>
                                <span>十五、一些地方对保护区内违法养殖查处不严，清退不力，漳州市漳江口红树林国家级自然保护区核心区有养殖面积323公顷，缓冲区有239公顷，2013年以来养殖面积仍在扩大，
核心区和缓冲区分别新增养殖面积约20公顷和11公顷。对保护区内的非法养殖问题实行分类处理。</span>
                            </div>
                            <div class="data-item">
                                <span >目前进展情况及存在问题</span>
                                <span >1.针对2003年以来违规扩大养殖面积。全面拆除2003年以来新增50.70公顷的养殖池塘堤岸、管理房、闸门等设施，加强日常巡护、无人机监控等监测措施，严格监控确保整改成
效，截至目前，没有发现返养行为。 2.针对2003年以前核心区缓冲区存在的养殖池塘。完成保护区范围内涉及15个村1001户716.58公顷养殖池塘调查建档工作。</span>
                            </div>
                        </div>
                        <div class="part-date">
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">行政区划：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">所属城市：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人电话：</span>
                                <span class="control-content">18865658888</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任单位：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头单位：</span>
                                <span class="control-content">厦门智慧指间</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任部门</span>
                                <span class="control-content"></span>';
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">配合单位：</span>
                                <span class="control-content">厦门</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及人员：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">创建时间：</span>';
                                <span class="control-content">2019-06-01</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及部门：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">整改时限：</span>
                                <span class="control-content">2019-06-04</span>
                            </div>
                        </div>
                        <div class="footer-font">
                            <span>完成交账销号</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->

<#--汇总预警 弹窗开始-->
<div class="new-supervision-show city-distribution-show">
    <div class="center-box">
        <a class="supervision-close"><img src="${request.contextPath}/static/images/new-popup/supervision-close.png"></a>
        <div class="data-info">
            <a class="return-tag return-close">
                <span class="icon iconcustom"></span>
            </a>
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/supervision-right.png">
                <span> 城市分布 </span>
                <img src="${request.contextPath}/static/images/new-popup/supervision-left.png">
            </h3>

            <!--汇总预警 -->
            <div class="list-warning">
                <div class="spacing-box spacing-list"  id="divTable">
                    <div class="details-text" id="notstart-detail">
                        <h5 >sfsfs</h5>
                        <div class="part-font">
                            <div class="data-item">
                                <span >问题描述</span>
                                <span >危险废物处置能力缺口问题</span>
                            </div>
                            <div class="data-item">
                                <span >整改任务具体要求</span>
                                <span>十五、一些地方对保护区内违法养殖查处不严，清退不力，漳州市漳江口红树林国家级自然保护区核心区有养殖面积323公顷，缓冲区有239公顷，2013年以来养殖面积仍在扩大，
核心区和缓冲区分别新增养殖面积约20公顷和11公顷。对保护区内的非法养殖问题实行分类处理。</span>
                            </div>
                            <div class="data-item">
                                <span >目前进展情况及存在问题</span>
                                <span >1.针对2003年以来违规扩大养殖面积。全面拆除2003年以来新增50.70公顷的养殖池塘堤岸、管理房、闸门等设施，加强日常巡护、无人机监控等监测措施，严格监控确保整改成
效，截至目前，没有发现返养行为。 2.针对2003年以前核心区缓冲区存在的养殖池塘。完成保护区范围内涉及15个村1001户716.58公顷养殖池塘调查建档工作。</span>
                            </div>
                        </div>
                        <div class="part-date">
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">行政区划：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">所属城市：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任人电话：</span>
                                <span class="control-content">18865658888</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头人：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任单位：</span>
                                <span class="control-content">厦门智慧指间科技有限公司</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">牵头单位：</span>
                                <span class="control-content">厦门智慧指间</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">责任部门</span>
                                <span class="control-content"></span>';
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">配合单位：</span>
                                <span class="control-content">厦门</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及人员：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">创建时间：</span>';
                                <span class="control-content">2019-06-01</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">涉及部门：</span>
                                <span class="control-content">陈炳科</span>
                            </div>
                            <div class="data-group layui-col-xs3">
                                <span class="control-label">整改时限：</span>
                                <span class="control-content">2019-06-04</span>
                            </div>
                        </div>
                        <div class="footer-font">
                            <span>完成交账销号</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<#--弹窗结束 -->
</body>

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    layui.use(['element'], function(){
        var element = layui.element;
    });
    var placeHolderStyle = {
        normal: {
            color: '#f2f2f2'
        },
        emphasis: {
            color: '#f2f2f2'
        }
    };
    var labelSetting = {
        normal: {
            show: false
        }
    };
    var fullBgBar = {
        name:"full_bg",
        type: 'pictorialBar',
        itemStyle: {
            normal: {
                color: '#fff',
                opacity:0.15
            }
        },
        barWidth:'100%',
        symbol: 'rect',
        symbolSize: [2,'100%'],
        symbolMargin:'150%',
        symbolRepeat: true,
        silent: true,
        barGap: '-100%', // Make series be overlap
        data: [100],
        zlevel:-1

    };
    var pictorialBarGrid={
        top:'10',
        left: '20',
        right: '100',
        bottom: '10',
        containLabel: true
    };
    var pictorialBarYAxis={
        data: ['reindeer'],
        inverse: true,
        axisLine: {show: false},
        axisTick: {show: false},
        axisLabel:{show: false},
        axisPointer: {show: false}
    };
    var pictorialBarXAxis={
        splitLine: {show: false},
        axisLabel: {show: false},
        axisTick: {show: false},
        axisLine: {show: false}
    };


    $(function () {
        /*---------------------------------天气--------------------------------------------------*/
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/getWeather',
            async:true,
            success: function (data) {
                var result = eval('(' + data + ')');
                var weather = result.results[0].weather_data[0];
                if(weather.date!=null){
                    $('#weatherDate').html(weather.date);
                }else{
                    $('#weatherDate').html("-");
                }
                if(weather.wind!=null){
                    $('#wind').html(weather.wind);
                }else{
                    $('#wind').html("-");
                }
                if(weather.weather!=null){
                    $('#weather').html(weather.weather);
                    $('#weatherIcon').removeClass();
                    $('#weatherIcon').addClass(Ams.weatherIcon(weather.weather));
                }else{
                    $('#weather').html("-");
                }
                if(weather.temperature!=null){
                    $('#temperature').html(weather.temperature);
                }else{
                    $('#temperature').html("-");
                }
            }
        });


        /*---------------------------------------考核目标-------------------------------------------*/
        var pictorialBarChart = echarts.init(document.getElementById('pictorialBarChart'));
        var pictorialBarOption ={
            grid: pictorialBarGrid,
            yAxis: pictorialBarYAxis,
            xAxis: pictorialBarXAxis,
            series: [
                {
                    name: '国考断面-目标',
                    type: 'pictorialBar',
                    barGap: 0,
                    label:labelSetting,
                    barWidth:'100%',
                    symbol: 'rect',
                    symbolSize: [2,'100%'],
                    symbolMargin:'150%',
                    symbolRepeat: true,
                    itemStyle:{
                        normal:{
                            color:'#61f651',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar


            ],
        };
        pictorialBarChart.setOption(pictorialBarOption);

        var pictorialBarChart2 = echarts.init(document.getElementById('pictorialBarChart2'));
        var pictorialBarOption2 ={
            grid: pictorialBarGrid,
            yAxis: pictorialBarYAxis,
            xAxis: pictorialBarXAxis,
            series: [
                {
                    name: '国考断面-目标',
                    type: 'pictorialBar',
                    barGap: 0,
                    label:labelSetting,
                    barWidth:'100%',
                    symbol: 'rect',
                    symbolSize: [2,'100%'],
                    symbolMargin:'150%',
                    symbolRepeat: true,
                    itemStyle:{
                        normal:{
                            color:'#ffbf26',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar


            ],
        };
        pictorialBarChart2.setOption(pictorialBarOption2);

        var pictorialBarChart3 = echarts.init(document.getElementById('pictorialBarChart3'));
        var pictorialBarOption3 ={
            grid: pictorialBarGrid,
            yAxis: pictorialBarYAxis,
            xAxis: pictorialBarXAxis,
            series: [
                {
                    name: '国考断面-目标',
                    type: 'pictorialBar',
                    barGap: 0,
                    label:labelSetting,
                    barWidth:'100%',
                    symbol: 'rect',
                    symbolSize: [2,'100%'],
                    symbolMargin:'150%',
                    symbolRepeat: true,
                    itemStyle:{
                        normal:{
                            color:'#fe8a57',
                        }
                    },
                    data: [ 85.5]
                },fullBgBar


            ],
        };
        pictorialBarChart3.setOption(pictorialBarOption3);




    });

</script>
<script type="text/javascript">
    var flag_city = 0;

    //整改汇总各类数量
    function getEnvironmentalProblemsNum(){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/getCount",
            async : true,
            data: {num:2},
            dataType: "json",
            success: function(data){
                $("#all").text((Ams.isNoEmpty(data.size)==false?"0":data.size)+"个");
                $("#notstart").text((Ams.isNoEmpty(data.NOTSTART)==false?"0":data.NOTSTART)+"个");
                $("#notreach").text((Ams.isNoEmpty(data.NOTREACH)==false?"0":data.NOTREACH)+"个");
                $("#over").text((Ams.isNoEmpty(data.OVER)==false?"0":data.OVER)+"个");
                $("#sendaccount").text((Ams.isNoEmpty(data.SENDACCOUNT)==false?"0":data.SENDACCOUNT)+"个");
                $("#pass").text((Ams.isNoEmpty(data.PASS)==false?"0":data.PASS)+"个");
                $("#ontime").text((Ams.isNoEmpty(data.ONTIME)==false?"0":data.ONTIME)+"个");
            },
            error: function(r){console.log(r);}
        });

    }
    //交账销号各类数量
    function getDescriptNum(){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/envCancellationAccount/getDescript",
            async : true,
            data: {},
            dataType: "json",
            success: function(data){
                $("#zgxh").text((Ams.isNoEmpty(data.num)==false?"0":data.num)+"个");
                $("#xjys").text((Ams.isNoEmpty(data.num1)==false?"0":data.num1)+"个");
                $("#sjys").text((Ams.isNoEmpty(data.num2)==false?"0":data.num2)+"个");
                $("#tjys").text((Ams.isNoEmpty(data.num3)==false?"0":data.num3)+"个");
                $("#wcsc").text((Ams.isNoEmpty(data.num4)==false?"0":data.num4)+"个");
            },
            error: function(r){console.log(r);}
        });

    }
    //城市分布——整改汇总
    function getProjectCountByCity(){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/getProjectCountByCity",
            async : true,
            data: {num:2},
            dataType: "json",
            success: function(data){
                
                for(var i = 0;i<data.result.length;i++){
                    var city = data.result[i].pointName;
                    var num = data.result[i].count;
                    $("#city"+i).text(city);
                    $("#num"+i).text(num+"个");
                }

            },
            error: function(r){console.log(r);}
        });

    }
    //城市分布——交账销号
    function getAccountProjectCountByCity(){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/getProjectCountByCity?status=SENDACCOUNT&num=2",
            async : true,
            data: {},
            dataType: "json",
            success: function(data){

                for(var i = 0;i<data.result.length;i++){
                    var city = data.result[i].pointName;
                    var num = data.result[i].count;
                    $("#city_"+i).text(city);
                    $("#num_"+i).text(num+"个");
                }

            },
            error: function(r){console.log(r);}
        });

    }
    function getTaskNotStarted(){
	    var colors = ['green','blue','yellow'];
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/listNew?status=NOTSTART",
            async : true,
            data: {},
            dataType: "json",
            success: function(data){
                var list = data.rows;
                var newRow = "";
                var length = list.length;
                if (length == 0) {
            		newRow += '<div class="col-xs-12">';
	                newRow += '<div class="basin-name-container circle-3 gray">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">无</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                $("#mainNotstart").empty();
	                $("#mainNotstart").append(newRow);
                    return;
                }
                if(length>3){
                	length=3;
                }
                var colxs='col-xs-4';
                if(length==1)colxs='col-xs-12';
                if(length==2)colxs='col-xs-6';
                if(length==3)colxs='col-xs-4';
                for(var i = 0;i<length;i++){
	                newRow += '<div class="'+colxs+'">';
	                newRow += '<div class="basin-name-container circle-1 '+colors[i]+'">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">'+list[i].projectName+'</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
                }
                $("#mainNotstart").empty();
                $("#mainNotstart").append(newRow);
            },
            error: function(r){console.log(r);}
        });
    }
    function getOverChronologicalProgress(){
    	var colors = ['red','orange','purple'];
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/listNew?status=PASS",
            async : true,
            data: {num:2},
            dataType: "json",
            success: function(data){
                var list = data.rows;
                var newRow = "";
                var length = list.length;
                if (length == 0) {
            		newRow += '<div class="col-xs-12">';
	                newRow += '<div class="basin-name-container circle-3 gray">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">无</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                $("#mainOverprogress").empty();
	                $("#mainOverprogress").append(newRow);
                    return;
                }
                if(length>3){
                	length=3;
                }
                var colxs='col-xs-4';
                if(length==1)colxs='col-xs-12';
                if(length==2)colxs='col-xs-6';
                if(length==3)colxs='col-xs-4';
                for(var i = 0;i<length;i++){
	                newRow += '<div class="'+colxs+'">';
	                newRow += '<div class="basin-name-container circle-1 '+colors[i]+'">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">'+list[i].projectName+'</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
                }
                $("#mainOverprogress").empty();
                $("#mainOverprogress").append(newRow);
            },
            error: function(r){console.log(r);}
        });
    }
    function getCompleteAcceptance(type){
    	var colors = ['blue','orange','purple'];
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/rectifition/getCancelNumberTimeoutData?type="+type,
            async : true,
            data: {},
            dataType: "json",
            success: function(data){
            	var newRow = "";
            	var length = data.length;
            	if (length == 0) {
            		newRow += '<div class="col-xs-12">';
	                newRow += '<div class="basin-name-container circle-3 gray">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">无</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                if(type=="CITY_ACTUAL_TIME"){
	                    $("#mainsjys").empty();
	                    $("#mainsjys").append(newRow);
	                }else if(type=="PROFESSION_ACTUAL_TIME"){
	                    $("#mainhyys").empty();
	                    $("#mainhyys").append(newRow);
	                }else if(type=="PROFESSION_EXAMINE_TIME"){
	                    $("#mainhysh").empty();
	                    $("#mainhysh").append(newRow);
	                }else{
	                	$("#mainxjys").empty();
	                    $("#mainxjys").append(newRow);
	                }
                    return;
                }
                if(length>3){
                	length=3;
                }

                var colxs='col-xs-4';
                if(length==1)colxs='col-xs-12';
                if(length==2)colxs='col-xs-6';
                if(length==3)colxs='col-xs-4';
                for(var i = 0;i<length;i++){
	                newRow += '<div class="'+colxs+'">';
	                newRow += '<div class="basin-name-container circle-3 '+colors[i]+'">';
	                newRow += '<div class="basin-bg"><div class="bg-img bg-1"></div>';
	                newRow += '<div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>';
	                newRow += '</div>';
	                newRow += '<div class="basin-text-box"><div class="basin-text">';
	                newRow += '<div class="name">'+data[i].projectName+'</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
	                newRow += '</div>';
                }
                if(type=="CITY_ACTUAL_TIME"){
                    $("#mainsjys").empty();
                    $("#mainsjys").append(newRow);
                }else if(type=="PROFESSION_ACTUAL_TIME"){
                    $("#mainhyys").empty();
                    $("#mainhyys").append(newRow);
                }else if(type=="PROFESSION_EXAMINE_TIME"){
                    $("#mainhysh").empty();
                    $("#mainhysh").append(newRow);
                }else{
                	$("#mainxjys").empty();
                    $("#mainxjys").append(newRow);
                }
            },
            error: function(r){console.log(r);}
        });
    }

    function getWarningRectificationTop() {
        $.ajax({
            type: "post",
            url: Ams.ctxPath + "/environment/rectifition/wornList",
            async: true,
            data: {
                status: "spzs",
                num:2
            },
            dataType: "json",
            success: function (data) {
                var list = data.rows;
                var h = '';
                var cla;
                var length = list.length;
                for (var i = 0; i < length; i++) {
                    if (i == 4) break;
                    var dutyPerson = list[i].dutyPerson;
                    var status = list[i].status;
                    var timeLimit = Ams.dateFormat(list[i].timelimit, 'yyyy-MM-dd HH:mm:ss');
                    var dutyPerson = Ams.isNoEmpty(list[i].dutyPerson) == false ? "无" : list[i].dutyPerson;
                    h += '<div class="col-xs-12 lzw_div">';
                    h += '<div class="sub-title">';
                    h += '<span >' + list[i].projectName + '</span>';
                    h += '</div>';
                    h += '<div class="sub-title">';
                    h += '<span class="item" >责任人：' + dutyPerson + '     </span>';
                    h += '<span class="item" >整改时限：' + timeLimit + '</span>';
                    h += '<div class="state expired lzw_lay">';
                    h += '<div ></div>';
                    h += '</div>';
                    h += '</div>';
                    h += '<div class="chart-box lzw_lay"></div>';
                    h += '</div>';
                }
                $("#wwczg div").remove();
                $('#wwczg').append(h);
            },
            error: function (r) {
                console.log(r);
            }
        });
    }


    $(function(){
        $('.other').text(Ams.nowDayOrFirstDayOfYear('0', '.') + '~' + Ams.nowDayOrFirstDayOfYear('1', '.'));
        getEnvironmentalProblemsNum();
        getDescriptNum();
        getProjectCountByCity();
        getTaskNotStarted();
        getOverChronologicalProgress();
        getAccountProjectCountByCity();
        getWarningRectificationTop();
        getCompleteAcceptance("COUNTY_ACTUAL_TIME");
        $('#dg').datagrid('hideColumn','operate');
    });

    function timeFn(d1) {
        var dateBegin = new Date(d1.replace(/-/g, "/"));//将-转化为/，使用new Date
        var dateEnd = new Date();//获取当前时间
        var dateDiff = dateBegin.getTime()-dateEnd.getTime();//时间差的毫秒数
        var dayDiff;
        if(dateDiff<0){
        	dateDiff = Math.abs(dateDiff);
        	dayDiff = Math.floor(dateDiff / (24 * 3600 * 1000));//计算出相差天数
        	var leave1=dateDiff%(24*3600*1000)    //计算天数后剩余的毫秒数
            var hours=Math.floor(leave1/(3600*1000))//计算出小时数
            return "超期"+dayDiff+"天 "+hours+"小时 ";
        }else{
            dayDiff = Math.floor(dateDiff / (24 * 3600 * 1000));//计算出相差天数
            var leave1=dateDiff%(24*3600*1000)    //计算天数后剩余的毫秒数
            var hours=Math.floor(leave1/(3600*1000))//计算出小时数
            return "剩余"+dayDiff+"天 "+hours+"小时 ";
        }
    }
    function setFlag(flag){
        flag_city = flag;
    }
</script>
<script>

    $(".spacing-box .option-box").on("click","a",function () {
        $(this).parent().find("a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })
    $(".header-nav .min-option-box").on("click","a",function () {
        $(".header-nav .min-option-box a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })
    $(".header-nav .max-option-box").on("click","a",function () {
        $(".header-nav .max-option-box a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })

    $(".supervision-close").click(function () {
        $(".new-supervision-show").hide()
    })

    layui.use(['layer','laypage','table'], function(){
        var layer = layui.layer
            ,laypage= layui.laypage
            ,table = layui.table;
        $(".option-box").on("click","a",function () {
			var type = $(this).attr("data-type");
        	table.reload('acceptance-table', {
        		  url: '/environment/rectifition/getCancelNumberTimeoutData1'
        		  ,where: {'type':type} //设定异步数据接口的额外参数
        		  //,height: 300
        		});

        })

        /**
         * 数据表格
         */
        table.render({
            elem: '#supervisio-table'
            ,theme: '#ff6666'
            ,loading:false
            ,cols: [[
                {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'describleName',width:'40%', title: '描述',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }
            ,page:{
                theme: '#642121'
                ,layout: [ 'prev', 'page', 'next']
                ,first: false
                ,last: false
                ,prev: '上一页'
                ,next: '下一页'
            }  //开启分页
            ,url: '/environment/rectifition/listNew1?status=NOTSTART&num=2'

        });

        //监听工具条
        table.on('tool(supervisio-table)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                $(".notstart-show").css("display","flex");
                $(".max-supervision-show").hide()
                table.resize("details-table")

                var newRow = "";
                dataVal=data;
                var rowData=JSON.stringify(dataVal);
                newRow += '<div class="details-text">';
                newRow += '<h5 >'+dataVal.projectName+'</h5>';
                newRow += '<div class="part-font">';
                newRow += '<div class="data-item"><span >问题描述</span><span >'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName)+'</span></div>';
                newRow += '<div class="data-item"><span >整改任务具体要求</span><span>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require)+'</span></div>';
                newRow += '<div class="data-item"><span >目前进展情况及存在问题</span><span>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question)+'</span></div>';
                newRow += '</div>';
                newRow += '<div class="part-date">';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">行政区划：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">所属城市：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人电话：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">牵头人：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">牵头单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任单位：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">配合单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">更新时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及人员：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">整改时限：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">销号时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';

                newRow += '</div>';
                newRow += '</div>';
                $("#notstart-detail").empty();
                $("#notstart-detail").append(newRow);

            }
        });
        /**
         * 数据表格
         */
        table.render({
            elem: '#overprogress-table'
            ,theme: '#ff6666'
            ,loading:false
            ,cols: [[
                {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'describleName',width:'40%', title: '描述',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }
            ,page:{
                theme: '#642121'
                ,layout: [ 'prev', 'page', 'next']
                ,first: false
                ,last: false
                ,prev: '上一页'
                ,next: '下一页'

            }  //开启分页
            ,url: '/environment/rectifition/listNew1?status=PASS&num=2'
        });

        //监听工具条
        table.on('tool(overprogress-table)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                $(".notstart-show").css("display","flex");
                $(".max-supervision-show").hide()
                table.resize("details-table")

                var newRow = "";
                dataVal=data;
                var rowData=JSON.stringify(dataVal);
                newRow += '<div class="details-text">';
                newRow += '<h5 >'+dataVal.projectName+'</h5>';
                newRow += '<div class="part-font">';
                newRow += '<div class="data-item"><span >问题描述</span><span >'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName)+'</span></div>';
                newRow += '<div class="data-item"><span >整改任务具体要求</span><span>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require)+'</span></div>';
                newRow += '<div class="data-item"><span >目前进展情况及存在问题</span><span>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question)+'</span></div>';
                newRow += '</div>';
                newRow += '<div class="part-date">';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">行政区划：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">所属城市：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人电话：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">牵头人：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">牵头单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任单位：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">配合单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">更新时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及人员：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">整改时限：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">销号时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';

                newRow += '</div>';
                newRow += '</div>';
                $("#notstart-detail").empty();
                $("#notstart-detail").append(newRow);

            }
        });
        /**
         * 数据表格
         */
        /* table.render({
            elem: '#acceptance-table'
            ,theme: '#ff6666'
            ,cols: [[
                {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'schedule',width:'20%', title: '状态',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                   // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ]],
                done: function (res, curr, count) {
                    $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
                }
             ,page:{
                    theme: '#642121'
                    ,layout: [ 'prev', 'page', 'next']
                    ,first: false
                    ,last: false
                    ,prev: '上一页'
                    ,next: '下一页'
                }  //开启分页
                ,url: '/environment/rectifition/getCancelNumberTimeoutData1?type=COUNTY_ACTUAL_TIME'
            }); */
        /**
         * 详情数据
         */
        table.render({
            elem: '#details-table'
            ,theme: '#ff6666'
            ,loading:false
            ,cols: [[
                {field:'id',width:'40%', title: '任务具体整改要求',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id',width:'40%', title: '目前进展情况及存在问题',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id', title: '完成情况',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 《生活垃圾填埋场污染控制标准》规定，2011年7月起生活垃圾填埋场应自行处理渗滤液并满足达标排放要求。标准实施后，福建省在“十二五”相关规划中提出要求，但落实和监管不够到位。督察发现，全省县级及以上地区的53个垃圾填埋场中，8个未建设渗滤液处置设施，16个渗滤液超标排放。"
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "

            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, ],
        });

        /**
         * 城市详情
         */
        table.render({
            elem: '#details-city-table'
            ,theme: '#ff6666'
            ,loading:false
            ,cols: [[
                {field:'id',width:'40%', title: '任务具体整改要求',style:'background-color: #220404; color: #ffeeee;'}
                ,{field:'id',width:'40%', title: '目前进展情况及存在问题',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ,{field:'id', title: '完成情况',style:'background-color: #220404; color: #ffeeee;text-align: center'}
            ]],
            done: function (res, curr, count) {
                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
            }

            ,data: [{
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 《生活垃圾填埋场污染控制标准》规定，2011年7月起生活垃圾填埋场应自行处理渗滤液并满足达标排放要求。标准实施后，福建省在“十二五”相关规划中提出要求，但落实和监管不够到位。督察发现，全省县级及以上地区的53个垃圾填埋场中，8个未建设渗滤液处置设施，16个渗滤液超标排放。"
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "

            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, {
                "id": "二十六、大量垃圾渗滤液得不到有效处置。国家 "
            }, ],
        });

        /**
         * 城市表格
         */
        /*  table.render({
        		 elem: '#city-table'
                 ,theme: '#ff6666'
	            ,cols: [[
	                {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
	                ,{field:'describleName',width:'40%', title: '描述',style:'background-color: #220404; color: #ffeeee;text-align: center'}
	               // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
		    ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作'}
		            ]],
		            done: function (res, curr, count) {
		                $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
		            }
		         ,page:{
		             theme: '#642121'
		    ,layout: [ 'prev', 'page', 'next']
		    ,first: false
		    ,last: false
		    ,prev: '上一页'
		    ,next: '下一页'

		            }  //开启分页
		            ,url: '/environment/rectifition/listNew1'
		        });

			  //监听工具条
			  table.on('tool(city-table)', function(obj){
				  var data = obj.data;
				  if(obj.event === 'detail'){
				   	layer.msg('ID：'+ data.uuid + ' 的查看操作');
				  }
			  }); */

        /**
         * 分页栏
         */
        laypage.render({
            elem: 'page-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 详情分页栏
         */
        laypage.render({
            elem: 'details-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 预警分页栏
         */

        /**
         * 城市分页栏
         */
        laypage.render({
            elem: 'page-details-city', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 城市详情分页栏
         */
        laypage.render({
            elem: 'details-container-city', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        /**
         * 预警分页栏
         */
        laypage.render({
            elem: 'warning-container', //注意，这里的 test1 是 ID，不用加 # 号
            count: 50,//数据总数，从服务端得到
            theme:'#642121 '
        });

        //汇总整改弹窗
        $(".summary-tag").click(function (event) {
            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            $(".max-supervision-show").css("display","flex")
            table.resize("supervisio-table")
        })

        //超时
        $(".overprogress-tag").click(function (event) {
            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            $(".max-overprogress-show").css("display","flex")
            table.resize("overprogress-table")
        })

        //完成销号
        $(".acceptance-tag").click(function (event) {
            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            queryAcceptance("COUNTY_ACTUAL_TIME");

            $(".max-acceptance-show").css("display","flex");
            table.resize("acceptance-table");
        })

        //查看详情弹窗
        $(".look-tag").click(function () {
            $(".warning-show").css("display","flex");
            $(".max-supervision-show").hide()
            table.resize("details-table")
        })

        // 预警弹窗
        $(".warning-tag").click(function (event) {
            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            $(".warning-show").css("display","flex");
            getDataShow();
        })
        var divpage=1;
        var divRowsCount=0;
        var divRowsCountSecond=0;
        /**
         * 主界面拼接表格
         */
        function rowTable(data) {
            var newRow = "";
            var dataVal='';
            var colorTime='';
            var colorClass='';
            var nowTime=new Date().getTime();
            divRowsCount=data.total;
            var  overTal = 0 ;
            for (var i = 0; i<data.rows.length;i++) {
                dataVal=data.rows[i];
                var warningTime=dataVal.wornTime;
                if (i==0) $('#warnTime').val(warningTime);
                if(Ams.isNoEmpty(warningTime)){
                    warningTime=warningTime*86400000;//一天的时间戳;
                }



                var rowData=JSON.stringify(dataVal);

                newRow += '<div class="details-text">';
                newRow += '<h5 >'+dataVal.projectName+'</h5>';
                newRow += '<div class="part-font">';
                newRow += '<div class="data-item"><span >问题描述</span><span >'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName)+'</span></div>';
                newRow += '<div class="data-item"><span >整改任务具体要求</span><span>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require)+'</span></div>';
                newRow += '<div class="data-item"><span >目前进展情况及存在问题</span><span>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question)+'</span></div>';
                newRow += '</div>';
                newRow += '<div class="part-date">';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">行政区划：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">所属城市：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">责任人电话：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">牵头人：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">牵头单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任单位：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">配合单位：</span>';
                newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">责任部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">更新时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及人员：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson)+'</span></div>';
                // newRow += '<div class="data-group layui-col-xs3">';
                // newRow += '<span class="control-label">涉及部门：</span>';
                // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">整改时限：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';
                newRow += '<div class="data-group layui-col-xs3">';
                newRow += '<span class="control-label">销号时间：</span>';
                newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';

                newRow += '</div>';
                newRow += '<div class="footer-font"><span>'+Ams.formatStatus(dataVal.status)+'</span></div>';
                newRow += '</div>';
            }
            $("#divTable div").remove();
            $("#divTable").append(newRow);
            if(divRowsCount!=divRowsCountSecond){
                getLayTable(divRowsCount);
            }

        }

        /**
         * 全部跟整改时间延期
         */
        function getDataShow() {
            var param={
                "page":divpage,
                "rows":10,
                "name" : '',
                "limit" :'',
                "status" : '',
                "dutyDepartment" : '',
                "areaCode" : '',
                "cityCode" : '',
                 "status":'spzs',
                'num':'2'
            }
            $.ajax({
                type : 'POST',
                url:  Ams.ctxPath + "/environment/rectifition/wornList",
                data : param,
                success : function(data) {
                    //$.messager.progress('close');
                    rowTable(data);
                },
                dataType : 'json'
            });

        }

        // 城市分布弹窗
        $(".city-tag").click(function (event) {
            var url = Ams.ctxPath + "/environment/rectifition/getProjectCountByCity?num=2";
            var status = "";
            if(flag_city == 1){
                status = "SENDACCOUNT";
                url = Ams.ctxPath + "/environment/rectifition/getProjectCountByCity?num=2&status=SENDACCOUNT";
            }
            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            $(".city-show").css("display","flex");
            table.resize("city-table");
            $("#citys").empty();
            var newRow1 = "";
            $.ajax({
                type: "post",
                url:  url,
                async : true,
                data: {},
                dataType: "json",
                success: function(data){
                    
                    for(var i = 0;i<data.result.length;i++){
                        var city = data.result[i].pointName;
                        var code = data.result[i].pointCode;
                        var num = data.result[i].count;
                        if(i == 0){
                            newRow1 += '<a class="select-tag" id="'+code+'" onclick="queryByCity(\''+code+'\',\''+status+'\')">'+city+'('+num+')</a>';
                        }else{
                            newRow1 += '<a id="'+code+'" onclick="queryByCity(\''+code+'\',\''+status+'\')">'+city+'('+num+')</a>';
                        }
                    }
                    $("#citys").append(newRow1);
                    queryByCity(data.result[0].pointCode,status);
                },
                error: function(r){console.log(r);}
            });

        })

        // 城市弹窗详情
        $(".look-city").click(function () {
            $(".details-city-show").css("display","flex");
            $(".city-show").css("display","none")
            table.resize("details-city-table")
        })

        $(".return-city").click(function () {
            $(".details-city-show").css("display","none");
            $(".city-show").css("display","flex")
        })

        $(".return-notstart").click(function () {
            $(".notstart-show").css("display","none");
            $(".max-overprogress-show").css("display","flex")
        })

        // 返回按钮
        $(".return-close").click(function () {
            $(".new-supervision-show").css("display","none")
        })



        $(".return-max").click(function () {
            $(".details-show").css("display","none")
            $(".max-supervision-show").css("display","flex")
        })


        /**
         * 分页栏
         */
        function getLayTable(count){
            layui.use('laypage', function(){
                var laypage = layui.laypage;
                //执行一个laypage实例
                laypage.render({
                    elem: 'warning-container', //注意，这里的 test1 是 ID，不用加 # 号
                    count: count,//数据总数，从服务端得到
                    theme:'#642121',
                    jump:function(object,first){
                        divpage=object.curr;
                        divRowsCountSecond=count;
                        if(!first){
                            getDataShow();
                        }

                    }
                });
            });
        }
    });


    function queryAcceptance(type){
        layui.use(['table'], function(){
            var table = layui.table;
            /**
             * 数据表格
             */
            table.render({
                elem: '#acceptance-table'
                ,theme: '#ff6666'
                ,loading:false
                ,cols: [[
                    {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
                    ,{field:'schedule',width:'20%', title: '状态',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                    // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                    ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ]],
                done: function (res, curr, count) {
                    $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
                }
                ,page:{
                    theme: '#642121'
                    ,layout: [ 'prev', 'page', 'next']
                    ,first: false
                    ,last: false
                    ,prev: '上一页'
                    ,next: '下一页'
                }  //开启分页
                ,url: '/environment/rectifition/getCancelNumberTimeoutData1?type='+type
            });

            //监听工具条
            table.on('tool(acceptance-table)', function(obj){
                var data = obj.data;
                $(".notstart-show").css("display","flex");
                $(".max-supervision-show").hide()
                table.resize("details-table")
                var id = data.projectId;
                $.ajax({
                    type: "post",
                    url:  Ams.ctxPath + "/environment/rectifition/getProjectDetail?id="+id,
                    async : true,
                    data: {},
                    dataType: "json",
                    success: function(datas){
                        var record = datas.rows;
                        if(record.length>0){
                            var newRow = "";
                            dataVal=record[0];
                            var rowData=JSON.stringify(dataVal);
                            newRow += '<div class="details-text">';
                            newRow += '<h5 >'+dataVal.projectName+'</h5>';
                            newRow += '<div class="part-font">';
                            newRow += '<div class="data-item"><span >问题描述</span><span >'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName)+'</span></div>';
                            newRow += '<div class="data-item"><span >整改任务具体要求</span><span>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require)+'</span></div>';
                            newRow += '<div class="data-item"><span >目前进展情况及存在问题</span><span>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question)+'</span></div>';
                            newRow += '</div>';
                            newRow += '<div class="part-date">';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">行政区划：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">所属城市：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">责任人：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">责任人电话：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone)+'</span></div>';
                            // newRow += '<div class="data-group layui-col-xs3">';
                            // newRow += '<span class="control-label">牵头人：</span>';
                            // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">牵头单位：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                           // newRow += '<div class="data-group layui-col-xs3">';
                           // newRow += '<span class="control-label">责任单位：</span>';
                           // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">配合单位：</span>';
                            newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit)+'</span></div>';
                            //newRow += '<div class="data-group layui-col-xs3">';
                            //newRow += '<span class="control-label">责任部门：</span>';
                            //newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">更新时间：</span>';
                            newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime)+'</span></div>';
                           // newRow += '<div class="data-group layui-col-xs3">';
                            //newRow += '<span class="control-label">涉及人员：</span>';
                           // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson)+'</span></div>';
                            //newRow += '<div class="data-group layui-col-xs3">';
                            //newRow += '<span class="control-label">涉及部门：</span>';
                           // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">整改时限：</span>';
                            newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';
                            newRow += '<div class="data-group layui-col-xs3">';
                            newRow += '<span class="control-label">销号时间：</span>';
                            newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';

                            newRow += '</div>';
                            newRow += '</div>';
                            $("#notstart-detail").empty();
                            $("#notstart-detail").append(newRow);
                        }
                    },
                    error: function(r){console.log(r);}
                });
            });
        });
    }

    function queryByCity(cityCode,status){
        
        var url = '/environment/rectifition/listNew1?num=2&cityCode='+cityCode;
        if(flag_city == 1){
            url = '/environment/rectifition/listNew1?num=2&cityCode='+cityCode + '&status=' + status;
        }
        layui.use(['table'], function(){
            var table = layui.table;
            /**
             * 城市表格
             */
            table.render({
                elem: '#city-table'
                ,theme: '#ff6666'
                ,loading:false
                ,cols: [[
                    {field:'projectName', title: '名称',style:'background-color: #220404; color: #ffeeee;'}
                    ,{field:'describleName',width:'40%', title: '描述',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                    // ,{field:'id3',width:'20%', title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                    ,{fixed: 'right', width: 160, align: 'center', toolbar: '#tbToolBar',title: '操作',style:'background-color: #220404; color: #ffeeee;text-align: center'}
                ]],
                done: function (res, curr, count) {
                    $('tr').css({'background-color': '#340303', 'color': '#ffeeee'});
                }
                ,page:{
                    theme: '#642121'
                    ,layout: [ 'prev', 'page', 'next']
                    ,first: false
                    ,last: false
                    ,prev: '上一页'
                    ,next: '下一页'

                }  //开启分页
                ,url: url
            });

            //监听工具条
            table.on('tool(city-table)', function(obj){
                var data = obj.data;
                if(obj.event === 'detail'){
                    $(".notstart-show").css("display","flex");
                    $(".max-supervision-show").hide()
                    table.resize("details-table")

                    var newRow = "";
                    dataVal=data;
                    var rowData=JSON.stringify(dataVal);
                    newRow += '<div class="details-text">';
                    newRow += '<h5 >'+dataVal.projectName+'</h5>';
                    newRow += '<div class="part-font">';
                    newRow += '<div class="data-item"><span >问题描述</span><span >'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName)+'</span></div>';
                    newRow += '<div class="data-item"><span >整改任务具体要求</span><span>'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require)+'</span></div>';
                    newRow += '<div class="data-item"><span >目前进展情况及存在问题</span><span>'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question)+'</span></div>';
                    newRow += '</div>';
                    newRow += '<div class="part-date">';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">行政区划：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">所属城市：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">责任人：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">责任人电话：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone)+'</span></div>';
                    // newRow += '<div class="data-group layui-col-xs3">';
                    // newRow += '<span class="control-label">牵头人：</span>';
                    // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">牵头单位：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit)+'</span></div>';
                    // newRow += '<div class="data-group layui-col-xs3">';
                    // newRow += '<span class="control-label">责任单位：</span>';
                    // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">配合单位：</span>';
                    newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit)+'</span></div>';
                    // newRow += '<div class="data-group layui-col-xs3">';
                    // newRow += '<span class="control-label">责任部门：</span>';
                    // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">更新时间：</span>';
                    newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime)+'</span></div>';
                    // newRow += '<div class="data-group layui-col-xs3">';
                    // newRow += '<span class="control-label">涉及人员：</span>';
                    // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson)+'</span></div>';
                    // newRow += '<div class="data-group layui-col-xs3">';
                    // newRow += '<span class="control-label">涉及部门：</span>';
                    // newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">整改时限：</span>';
                    newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';
                    newRow += '<div class="data-group layui-col-xs3">';
                    newRow += '<span class="control-label">销号时间：</span>';
                    newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit)+'</span></div>';

                    newRow += '</div>';
                    newRow += '</div>';
                    $("#notstart-detail").empty();
                    $("#notstart-detail").append(newRow);

                }
            });
        });
    }
    /**
     * 字段格式化
     */
    function formatStatus(status){
        if(status=="OVER"){
            return "完成整改";
        }else if(status=="ONTIME"){
            return "达到序时进度";
        }else if(status=="PASS"){
            return "超过序时进度";
        }else if(status=="NOTSTART"){
            return "尚未启动";
        }else if(status=="NOTREACH"){
            return "未达到序时进度";
        }else if(status=="SENDACCOUNT"){
            return "完成交账销号";
        }else{
            return "";
        }
    }


    /*切换大屏*/
    $(".btn-switch-tv").click(function(){
        var text=$(this).text();
        if(text==="Web"){
            $("body").removeClass("TV-screen-container");
            $(this).text("TV");

        }else{
            $("body").addClass("TV-screen-container");
            $(this).text("Web");
        }
    });

    //小屏菜单栏
    $(".min-option-box .select-tag").click(function(){
        if( $(".min-option-box").css("height")=="46px"){
            $(".min-option-box").css("height","auto")
        }else{
            $(".min-option-box").css("height","46px")
        }
    })
</script>
<script type="text/html" id="tbToolBar">
    <a class='look-city' lay-event="detail"><span class="icon iconcustom look-icon"></span>查看</a>
</script>
</html>