<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>水环境-大数据</title>

</head>
<!-- body -->
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudWater.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>
<script src="${request.contextPath}/static/js/indextemp10.js"></script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<style type="text/css">
    .col-xs-2{ width:19.666667%; }
</style>
<!-- 头部 -->
<header class="home-water-header-container">
    <div class="header-logo"><h1 class="logo-text" style="letter-spacing: 3px;"> 漳州生态云</h1></div>
    <div class="header-nav p-right">
        <ul class="water-nav">
            <li class="nav-item">
                <a class="nav-item-a" href="${request.contextPath}/environment/hugeData">
                    <span class="title">大气环境</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-item-a nav-item-select" >
                    <span class="title">水环境</span>
                </a>
            </li>
        </ul>
    </div>
    <div class="header-other p-left">
        <span id="weatherDate">2018年5月31日</span>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云  北风1~2级</span>
        <span id="wind">多云  北风1~2级</span>
        <span id="temperature">多云  北风1~2级</span>
        <a href="${request.contextPath}/index" target="_blank">进入系统</a>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-water-container">

    <!-- 监控情况 -->
    <div class="home-layout" id="monitoringDetails">
        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-shipinjiankong1" ></span>
				<span>设备检测区域</span>
			</span>
                <span id="timeId" class="other"></span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-content row">
                    <div class="grid-info col-xs-2">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-shuiku1"></span>
                        </div>
                        <div class="panel-right">
                            <div>污水处理厂</div>
                            <div><span id="wsclc"></span></div>
                        </div>
                    </div>
                    <div class="grid-info col-xs-2">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-paifang2"></span>
                        </div>
                        <div class="panel-right">
                            <div>常规口</div>
                            <div><span id="cgk"></span></div>
                        </div>
                    </div>
                    <div class="grid-info col-xs-2">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-qiyexinxi3"></span>
                        </div>
                        <div class="panel-right">
                            <div>污普废水企业</div>
                            <div><span id="wpfsqy"></span></div>
                        </div>
                    </div>
                    <div class="grid-info col-xs-2">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-shuiba"></span>
                        </div>
                        <div class="panel-right">
                            <div>微型水质自动站</div>
                            <div><span id="wxszzdz"></span></div>
                        </div>
                    </div>
                    <div class="grid-info col-xs-2">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-shuiku2"></span>
                        </div>
                        <div class="panel-right">
                            <div >小流域</div>
                            <div><span id="xly"></span></div>
                        </div>
                    </div>
                <#--<div class="grid-info col-xs-2">-->
                <#--<div class="panel-left ani duration05">-->
                <#--<span class="icon iconcustom icon-shuibengzhan"></span>-->
                <#--</div>-->
                <#--<div class="panel-right">-->
                <#--<div>湖库</div>-->
                <#--<div><span>14</span></div>-->
                <#--</div>-->
                <#--</div>-->
                </div>

                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
    </div>
    <!-- 监控情况  over-->

    <!-- 左 -->
    <div class="home-layout fl" id="home-left">
        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>国考断面年目标管理</span>
			</span>
                <span class="other" id="timeId2">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <a href="#" target="" class="more fr water-open" id="gkdmxqid">详情</a>
                        <span class="title">
						 <span>未达标断面</span>
					</span>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="basin-name-container circle-1 red">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="gkwdbdm1">南靖上洋</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="basin-name-container circle-1 yellow">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="gkwdbdm2">南靖上洋</div>
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

        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>省考断面年目标管理</span>
			</span>
                <span class="other" id="timeId3">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <a href="#" target="" class="more fr" id="skdmxqid">详情</a>
                        <span class="title">
						<span id="skmcid">省考断面Ⅰ～Ⅲ类水质比例达90%以上</span>
					</span>
                    </div>
                    <div class="sub-title">未达标断面</div>
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-2 orange">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="skwdbdm1">南靖上洋</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-2 red">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="skwdbdm2">南靖上洋</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-2 purple">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="skwdbdm3">南靖上洋</div>
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
    <!-- 左  over-->
    <!-- 右 -->
    <div class="home-layout fr" id="home-right">
        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>小流域断面目标管理</span>
			</span>
                <span class="other" id="timeId6">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <a href="#" target="" class="more fr water-open" id="riverDataDetail">详情</a>
                        <span class="title">
						<span id="riverTargetReachTo">小流域断面Ⅰ～Ⅲ类水质比例达58.4%以上</span>
					</span>
                    </div>
                    <div class="sub-title">影响达标流域</div>
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-3 yellow">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="notReachRiver1">南靖上洋</div>
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
                                        <div class="area"></div>
                                        <div class="name" id="notReachRiver2">南靖上洋</div>
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
                                        <div class="area"></div>
                                        <div class="name" id="notReachRiver3">南靖上洋</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--面板主内容 over-->

                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <a href="#" target="" class="more fr water-open" id="riverDataDetail2">详情</a>
                        <span class="title">
						<span>小流域不升反降流域</span>
					</span>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-3 red">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="reduceRiver1">南靖上洋</div>
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
                                        <div class="area"></div>
                                        <div class="name" id="reduceRiver2">南靖上洋</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-4">
                            <div class="basin-name-container circle-3 green">
                                <div class="basin-bg">
                                    <div class="bg-img bg-1"></div>
                                    <div class="bg-img bg-2 ani ani-clockwiseRotate linear infinite duration5"></div>
                                </div>
                                <div class="basin-text-box">
                                    <div class="basin-text">
                                        <div class="area"></div>
                                        <div class="name" id="reduceRiver3">南靖上洋</div>
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
    <!-- 右  over-->
    <!-- 中 -->
    <div class="home-layout oh" id="home-center">
        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-baobiaotongji2" ></span>
				<span>考核目标</span>
			</span>
                <span class="other" id="timeId4">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <!-- <a href="#" target="" class="more fr">详情</a> -->
                        <span class="title">
						<span>国考断面</span>
					</span>
                        <span class="right-font  alone-font" id="gkdb">未达标</span>
                    </div>
                    <div class="sub-title" id="gkdmmbbl">目标：国考断面Ⅰ～Ⅲ类水质达到比例</div>
                    <div class="chart-box" id="pictorialBarChart"></div>
                    <div class="sub-title" id="gkdmwcbl">完成情况：国考断面Ⅰ～Ⅲ类水质达到比例</div>
                    <div class="chart-box" id="pictorialBarChart2"></div>
                </div>
                <!--面板主内容 over-->

                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <!-- <a href="#" target="" class="more fr">详情</a> -->
                        <span class="title">
						<span>省考断面</span>
					</span>
                        <span class="right-font  alone-font" id="skdb">未达标</span>
                    </div>
                    <div class="sub-title" id="skdmmbbl">目标：省考断面Ⅰ～Ⅲ类水质达到比例</div>
                    <div class="chart-box" id="pictorialBarChart3"></div>
                    <div class="sub-title" id="skdmwcbl">完成情况：省考断面Ⅰ～Ⅲ类水质达到比例</div>
                    <div class="chart-box" id="pictorialBarChart4"></div>
                </div>
                <!--面板主内容 over-->

                <!--面板主内容-->
                <div class="box-body">
                    <div class="box-top">
                        <!-- <a href="#" target="" class="more fr">详情</a> -->
                        <span class="title">
						<span>小流域</span>
					</span>
                    </div>
                    <div class="layui-form">
                        <div class="layui-inline">
                            <select name="" lay-verify="">
                                <option value="">小流域考核断面Ⅰ～Ⅲ类水质比例达76.4%以上</option>
                                <option value="0">北京</option>
                                <option value="1">上海</option>
                                <option value="2">广州</option>
                                <option value="3">深圳</option>
                                <option value="4">杭州</option>
                            </select>
                        </div>
                    </div>
                    <div class="sub-title">
                        <span class="completed">已完成</span>
                        <span><span class="em">目标：</span>小流域考核断面Ⅰ～Ⅲ类水质达到比例87.5%</span>
                    </div>
                    <div class="chart-box" id="pictorialBarChart5"></div>
                    <div class="sub-title">
                        <span><span class="em">完成情况：</span>自建站点考核断面Ⅰ～Ⅲ类水质比例达58.4%以上</span>
                    </div>
                    <div class="chart-box" id="pictorialBarChart6"></div>
                </div>

            </div>
        </div>
        <!--首页面板 over-->


    </div>
    <!-- 中  over-->
    <div class="ca"></div>
    <!-- 日目标管理 -->
    <div class="home-layout" id="targetManage">
        <!--首页面板-->
        <div class="home-water-panel">
            <div class="home-water-panel-header">
                <!-- <a href="#" target="" class="more fr iconcustom icon-fanhui7"></a> -->
                <span class="title">
				<span class="icon iconcustom icon-shijianguanli2" ></span>
				<span>日目标管理</span>
			</span>
                <span class="other" id="timeId5">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-water-panel-body">
                <!--面板主内容-->
                <div class="box-body target-manage-list" id="rglid">

                    <div class="home-water-option">
                        <a class="select-tag " id="rglgkid">国控断面</a>  <a id="rglskid">省控断面</a>  <a id="rglzjid">自建断面</a>  <a id="rglriver">小流域断面</a>
                    </div>

                    <div class="item">
                        <div class="home-border-panel water-blue">
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
                                        <div class="area" id="rmbmcid1">平和县</div>
                                        <div class="name" id="csdjid1">Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-blue">
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
                                        <div class="area" id="rmbmcid2">平和县</div>
                                        <div class="name" id="csdjid2" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-green">
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
                                        <div class="area" id="rmbmcid3">平和县</div>
                                        <div class="name" id="csdjid3" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-yellow">
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
                                        <div class="area" id="rmbmcid4">平和县</div>
                                        <div class="name" id="csdjid4" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-orange">
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
                                        <div class="area" id="rmbmcid5">平和县</div>
                                        <div class="name" id="csdjid5" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-red">
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
                                        <div class="area" id="rmbmcid6">平和县</div>
                                        <div class="name" id="csdjid6" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-gray">
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
                                        <div class="area" id="rmbmcid7">平和县</div>
                                        <div class="name" id="csdjid7" >Ⅰ</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="home-border-panel water-yellow">
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
                                        <div class="area" id="rmbmcid8">平和县</div>
                                        <div class="name" id="csdjid8" >Ⅰ</div>
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





<!--  水弹窗  开始 -->
<div class="new-water-show max-water-box">
    <div class="center-box">
        <a class="water-close"><img src="${request.contextPath}/static/images/new-popup/water-close-icon_03.png"></a>
        <div class="data-info">
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/left-icon.png">
                <span id="dmxqbtid"> 国控断面详情 </span>
                <img src="${request.contextPath}/static/images/new-popup/right-icon.png">
            </h3>
            <div class="option-box">
                <a class="select-tag" id="dbdmid">达标断面 </a>
                <a id="wdbdmid">未达标断面 </a>
            </div>
            <div class="option-list">
            <#--<a class="select-tag">龙岩(2)</a>  <a>龙岩(2)</a>  <a>龙岩(2)</a>  <a>龙岩(2)</a>-->
            </div>
            <div class="list-data" id="pjhtml">
                <div class="item">
                    <h5>
                        <span id="gkxq1">南溪浮宫桥</span>
                        <a >详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span id="mb1">目标：III</span>
                            <span id="cs1">2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/drop-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item" id="one11">
                                <span>1月</span>
                                <span id="one1"></span>
                            </div>
                            <div class="month-item" id="two11">
                                <span>2月</span>
                                <span id="two1"></span>
                            </div>
                            <div class="month-item "  id="thr11">
                                <span>3月</span>
                                <span id="thr1"></span>
                            </div>
                            <div class="month-item " id="thr1">
                                <span >4月</span>
                                <span id="four1"></span>
                            </div>
                            <div class="month-item " id="thr1">
                                <span >5月</span>
                                <span id="five1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>6月</span>
                                <span id="six1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>7月</span>
                                <span id="seven1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>8月</span>
                                <span id="eight1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>9月</span>
                                <span id="nine1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>10月</span>
                                <span  id="ten1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>11月</span>
                                <span  id="elv1"></span>
                            </div>
                            <div class="month-item" id="thr1">
                                <span>12月</span>
                                <span  id="twe1"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span id="gkxq2">南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span id="mb2">目标：III</span>
                            <span id="cs2">2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/rise-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item" id="one22">
                                <span>1月</span>
                                <span id="one2"></span>
                            </div>
                            <div class="month-item" id="two22">
                                <span>2月</span>
                                <span id="two2"></span>
                            </div>
                            <div class="month-item " id="thr22">
                                <span>3月</span>
                                <span id="thr2"></span>
                            </div>
                            <div class="month-item " id="four22">
                                <span >4月</span>
                                <span id="four2"></span>
                            </div>
                            <div class="month-item " id="five22">
                                <span >5月</span>
                                <span id="five2"></span>
                            </div>
                            <div class="month-item" id="six22">
                                <span>6月</span>
                                <span id="six2"></span>
                            </div>
                            <div class="month-item" id="seven22">
                                <span>7月</span>
                                <span id="seven2"></span>
                            </div>
                            <div class="month-item" id="eight22">
                                <span>8月</span>
                                <span id="eight2"></span>
                            </div>
                            <div class="month-item" id="nine22">
                                <span>9月</span>
                                <span id="nine2"></span>
                            </div>
                            <div class="month-item" id="ten22">
                                <span>10月</span>
                                <span  id="ten2"></span>
                            </div>
                            <div class="month-item" id="elv22">
                                <span>11月</span>
                                <span  id="elv2"></span>
                            </div>
                            <div class="month-item" id="twe22">
                                <span>12月</span>
                                <span id="twe2"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span id="gkxq3">南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span id="mb3">目标：III</span>
                            <span id="cs3">2019年均值：III</span>
                            <span>同比：5%  <img src="${request.contextPath}/static/images/new-popup/rise-icon.png"></span>
                        </div>
                        <div class="month-data">
                            <div class="month-item" id="one33">
                                <span>1月</span>
                                <span id="one3"></span>
                            </div>
                            <div class="month-item" id="two33">
                                <span>2月</span>
                                <span id="two3"></span>
                            </div>
                            <div class="month-item " id="thr33">
                                <span>3月</span>
                                <span id="thr3"></span>
                            </div>
                            <div class="month-item " id="four33">
                                <span >4月</span>
                                <span id="four3"></span>
                            </div>
                            <div class="month-item " id="five33">
                                <span >5月</span>
                                <span id="five3"></span>
                            </div>
                            <div class="month-item" id="six33">
                                <span>6月</span>
                                <span id="six3"></span>
                            </div>
                            <div class="month-item" id="seven33">
                                <span>7月</span>
                                <span id="seven3"></span>
                            </div>
                            <div class="month-item" id="eight33">
                                <span>8月</span>
                                <span id="eight3"></span>
                            </div>
                            <div class="month-item" id="nine33">
                                <span>9月</span>
                                <span id="nine3"></span>
                            </div>
                            <div class="month-item" id="ten33">
                                <span>10月</span>
                                <span  id="ten3"></span>
                            </div>
                            <div class="month-item" id="elv33">
                                <span>11月</span>
                                <span  id="elv3"></span>
                            </div>
                            <div class="month-item" id="twe33">
                                <span>12月</span>
                                <span  id="twe3"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span id="gkxq4">南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag" id="thr44">
                            <span id="mb4">目标：</span>
                            <span id="cs4">2019年均值：</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data" id="one44">
                            <div class="month-item">
                                <span>1月</span>
                                <span id="one4"></span>
                            </div>
                            <div class="month-item" id="two44">
                                <span>2月</span>
                                <span id="two4"></span>
                            </div>
                            <div class="month-item " id="thr44">
                                <span>3月</span>
                                <span id="thr4"></span>
                            </div>
                            <div class="month-item " id="four44">
                                <span >4月</span>
                                <span id="four4"></span>
                            </div>
                            <div class="month-item " id="five44">
                                <span >5月</span>
                                <span id="five4"></span>
                            </div>
                            <div class="month-item" id="six44">
                                <span>6月</span>
                                <span id="six4"></span>
                            </div>
                            <div class="month-item" id="seven44">
                                <span>7月</span>
                                <span id="seven4"></span>
                            </div>
                            <div class="month-item" id="eight44">
                                <span>8月</span>
                                <span id="eight4"></span>
                            </div>
                            <div class="month-item" id="nine44">
                                <span>9月</span>
                                <span id="nine4"></span>
                            </div>
                            <div class="month-item" id="ten44">
                                <span>10月</span>
                                <span  id="ten4"></span>
                            </div>
                            <div class="month-item" id="elv44">
                                <span>11月</span>
                                <span  id="elv4"></span>
                            </div>
                            <div class="month-item" id="twe44">
                                <span>12月</span>
                                <span  id="twe4"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5>
                        <span id="gkxq5">南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span id="mb5">目标：</span>
                            <span id="cs5">2019年均值：</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data">
                            <div class="month-item" id="one55">
                                <span>1月</span>
                                <span id="one5"></span>
                            </div>
                            <div class="month-item" id="two55">
                                <span>2月</span>
                                <span id="two5"></span>
                            </div>
                            <div class="month-item " id="thr55">
                                <span>3月</span>
                                <span id="thr5"></span>
                            </div>
                            <div class="month-item " id="four55">
                                <span >4月</span>
                                <span id="four5"></span>
                            </div>
                            <div class="month-item " id="five55">
                                <span >5月</span>
                                <span id="five5"></span>
                            </div>
                            <div class="month-item" id="six55">
                                <span>6月</span>
                                <span id="six5"></span>
                            </div>
                            <div class="month-item" id="seven55">
                                <span>7月</span>
                                <span id="seven5"></span>
                            </div>
                            <div class="month-item" id="eight55">
                                <span>8月</span>
                                <span id="eight5"></span>
                            </div>
                            <div class="month-item" id="nine55">
                                <span>9月</span>
                                <span id="nine5"></span>
                            </div>
                            <div class="month-item" id="ten55">
                                <span>10月</span>
                                <span  id="ten5"></span>
                            </div>
                            <div class="month-item" id="elv55">
                                <span>11月</span>
                                <span id="elv5"></span>
                            </div>
                            <div class="month-item" id="twe55">
                                <span >12月</span>
                                <span id="twe5"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <h5 id="gkxq6">
                        <span>南溪浮宫桥</span>
                        <a>详情</a>
                    </h5>
                    <div class="item-info">
                        <div class="average-tag">
                            <span id="mb6">目标：</span>
                            <span id="cs6">2019年均值：</span>
                            <span>同比：5%</span>
                        </div>
                        <div class="month-data">
                            <div class="month-item" id="one66">
                                <span>1月</span>
                                <span id="one6"></span>
                            </div>
                            <div class="month-item" id="two66">
                                <span>2月</span>
                                <span id="two6"></span>
                            </div>
                            <div class="month-item " id="thr66">
                                <span>3月</span>
                                <span id="thr6"></span>
                            </div>
                            <div class="month-item " id="four66">
                                <span >4月</span>
                                <span id="four6"></span>
                            </div>
                            <div class="month-item " id="five66" >
                                <span >5月</span>
                                <span id="five6"></span>
                            </div>
                            <div class="month-item" id="six66">
                                <span>6月</span>
                                <span id="six6"></span>
                            </div>
                            <div class="month-item" id="seven66">
                                <span>7月</span>
                                <span id="seven6"></span>
                            </div>
                            <div class="month-item" id="eight66">
                                <span>8月</span>
                                <span id="eight6"></span>
                            </div>
                            <div class="month-item" id="nine66">
                                <span>9月</span>
                                <span id="nine6"></span>
                            </div>
                            <div class="month-item" id="ten66">
                                <span >10月</span>
                                <span id="ten6"></span>
                            </div>
                            <div class="month-item" id="elv66">
                                <span >11月</span>
                                <span id="elv6"></span>
                            </div>
                            <div class="month-item" id="twe66">
                                <span >12月</span>
                                <span id="twe6"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--  水弹窗 结束 -->

<!--  水弹窗详情  开始 -->
<div class="new-water-show  details-water" >
    <div class="center-box">
        <a class="water-detail-close"><img src="${request.contextPath}/static/images/new-popup/water-close-icon_03.png"></a>
        <div class="data-info">
            <h3 class="average">
                <img src="${request.contextPath}/static/images/new-popup/left-icon.png">
                <span id="detail_pointName"> 市区龙文区 - 县前直街详情 </span>
                <img src="${request.contextPath}/static/images/new-popup/right-icon.png">
            </h3>
            </h3>
            <table class="layui-hide" id="water-table"></table>
        </div>
    </div>
</div>
<!--  水弹窗 结束 -->


</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
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
            show: true,
            position: 'left',
            offset: [-10, 0],
            textStyle: {
                fontSize: 16,
                color:'auto'
            },formatter:'{c}%'
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
        left: '80',
        right: '20',
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
    var pictorialBarChart;
    var pictorialBarChart2;
    var pictorialBarChart3;
    var pictorialBarChart4;
    function whichAnimationEvent(el){
        var t;
        var animations = {
            'animation':'animationend',
            'OAnimation':'oAnimationEnd',
            'MozAnimation':'animationend',
            'WebkitAnimation':'webkitAnimationEnd',
            'MsAnimation':'msAnimationEnd'
        }
        for(t in animations){
            if( el.style[t] !== undefined ){
                return animations[t];
            }
        }
    }
    $(function () {
        /*--------------------定时动画--------------------------*/
        $("#targetManage .ani").each(function(index){
            var $t=$(this);
            var el=$t.get(0);
            var animationEvent=whichAnimationEvent(el);
            animationEvent && el.addEventListener(animationEvent, function() {
                $t.removeClass("ani-flash1");
            });
            setTimeout(function(){
                $t.addClass("ani-flash1");
            },1000*index);
            var myVar=setInterval(function(){
                setTimeout(function(){
                    $t.addClass("ani-flash1");
                },1000*index);
            },8000);
        });
        $("#monitoringDetails .ani").each(function(index){
            var $t=$(this);
            var el=$t.get(0);
            var animationEvent=whichAnimationEvent(el);
            animationEvent && el.addEventListener(animationEvent, function() {
                $t.removeClass("ani-extrusion");
            });
            setTimeout(function(){
                $t.addClass("ani-extrusion");
            },1000*index);
            var myVar=setInterval(function(){
                setTimeout(function(){
                    $t.addClass("ani-extrusion");
                },1000*index);
            },6000);
        });
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
        pictorialBarChart = echarts.init(document.getElementById('pictorialBarChart'));

        pictorialBarChart2 = echarts.init(document.getElementById('pictorialBarChart2'));


        pictorialBarChart3 = echarts.init(document.getElementById('pictorialBarChart3'));


        pictorialBarChart4 = echarts.init(document.getElementById('pictorialBarChart4'));


    });
    function setPictorialBarChart(a){
        var pictorialBarOption = {
            grid: pictorialBarGrid,
            yAxis: pictorialBarYAxis,
            xAxis: pictorialBarXAxis,
            series: [
                {
                    name: '国考断面-目标',
                    type: 'pictorialBar',
                    barGap: 0,
                    label: labelSetting,
                    barWidth: '100%',
                    symbol: 'rect',
                    symbolSize: [2, '100%'],
                    symbolMargin: '150%',
                    symbolRepeat: true,
                    itemStyle: {
                        normal: {
                            color: '#61f651',
                        }
                    },
                    data: a
                }, fullBgBar


            ],
        };
        pictorialBarChart.setOption(pictorialBarOption);
    }
    function setPictorialBarChart2(a){
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
                    data: a
                },fullBgBar


            ],
        };
        pictorialBarChart2.setOption(pictorialBarOption2);
    }
    function setPictorialBarChart3(a){
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
                            color:'#00b3eb',
                        }
                    },
                    data: a
                },fullBgBar


            ],
        };
        pictorialBarChart3.setOption(pictorialBarOption3);
    }
    function setPictorialBarChart4(a){
        var pictorialBarOption4 ={
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
                    data: a
                },fullBgBar


            ],
        };
        pictorialBarChart4.setOption(pictorialBarOption4);
    }

</script>

<!--  弹窗  js -->
<script>

    //水环境弹窗
    $(".water-open").click(function () {
        $(".max-water-box").css("display","flex")
    })
    //水环境弹窗隐藏
    $(".water-close").click(function () {
        $(".max-water-box").css("display","none")
    })
    //水环境详情弹窗
    $(".details-open").click(function () {
        $(".details-water").css("display","flex")
    })
    //水环境详情弹窗隐藏
    $(".water-detail-close").click(function () {
        $(".details-water").css("display","none")
    })



    //水环境头部 日目标管理 点击切换样式
    $(".home-water-option a").click(function () {
        $(".home-water-option a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })
    //水环境头部 导航 点击切换样式
    $(".water-nav li a").click(function () {
        $(".water-nav li a").removeClass("nav-item-select")
        $(this).addClass("nav-item-select")
    })

    // 大气弹窗 导航栏点击切换样式
    $(".option-box a").click(function () {
        $(".option-box a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })

    // 大气弹窗 二级导航点击切换样式
    $(".option-list a").click(function () {
        $(".option-list a").removeClass("select-tag")
        $(this).addClass("select-tag")
    })

    // 大气弹窗关闭
    $(".atmosphere-close").click(function () {
        $(".new-atmosphere-show").css("display","none")
    })

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function () {
        //setTime('timeId');
        setTime('timeId2');
        setTime('timeId3');
        setTime('timeId4');
        setTime('timeId5');
        setTime('timeId6');
        doSearch();
    });

    function setTime(id) {
        $('#'+id).text(Ams.nowDayOrFirstDayOfYear('0', '.') + '~' + Ams.nowDayOrFirstDayOfYear('1', '.'));
    }
    var global;
    var year = new Date().getFullYear();
    //查询
    function doSearch() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/water/wtCityHourData/getGkSkShowData',
            data: {'year': 2019},
            success: function (result) {
                global = result;
                var total = new Array(result.total);
                //设备检测区域下的汇总
                $('#wsclc').text(total[0][0][0]);
                $('#cgk').text(total[0][0][1]);
                $('#wpfsqy').text(total[0][0][2]);
                $('#wxszzdz').text(total[0][0][3]);
                $('#xly').text(total[0][0][4]);
                var a = subStr(Number(result.assinMap.mbgkbl).toFixed(3) * 100 + '');
                var b = subStr(Number(result.assinMap.wcgkbl).toFixed(3)*100+'');
                var c = subStr(Number(result.assinMap.mbskbl).toFixed(3)*100+'');
                var d = subStr(Number(result.assinMap.wcskbl).toFixed(3)*100+'');
                //考核目标
                $('#gkdmmbbl').text('目标：国考断面Ⅰ～Ⅲ类水质达到比例'+a+'%');
                $('#gkdmwcbl').text('完成情况：国考断面Ⅰ～Ⅲ类水质达到比例'+b+'%');
                $('#skdmmbbl').text('目标：省考断面Ⅰ～Ⅲ类水质达到比例'+c+'%');
                $('#skdmwcbl').text('完成情况：省考断面Ⅰ～Ⅲ类水质达到比例'+d+'%');
                $('#skmcid').text('省考断面Ⅰ～Ⅲ类水质比例达'+d+'%以上');

                //达标 未达标
                if (result.assinMap.gkStatus == '达标') {
                    $("#gkdb").removeClass("alone-font");
                }else{
                    $("#gkdb").addClass("alone-font");
                }if (result.assinMap.skStatus == '达标') {
                    $("#skdb").removeClass("alone-font");
                }else{
                    $("#skdb").addClass("alone-font");
                }
                $('#gkdb').text(result.assinMap.gkStatus);
                $('#skdb').text(result.assinMap.skStatus);

                //比例赋值
                setPictorialBarChart(new Array(a));
                setPictorialBarChart2(new Array(b));
                setPictorialBarChart3(new Array(c));
                setPictorialBarChart4(new Array(d));

                //国考断面未达标
                var array = new Array(result.assinMap.wdbdmGk);
                array[0].length>=1?$('#gkwdbdm1').text(array[0][0].sectionName):$('#gkwdbdm1').text('暂无数据');
                array[0].length>=2?$('#gkwdbdm2').text(array[0][1].sectionName):$('#gkwdbdm2').text('暂无数据');
                //省考考断面未达标
                var array = new Array(result.assinMap.wdbdmSk);
                array[0].length>=1?$('#skwdbdm1').text(array[0][0].sectionName):$('#skwdbdm1').text('暂无数据');
                array[0].length>=2?$('#skwdbdm2').text(array[0][1].sectionName):$('#skwdbdm2').text('暂无数据');
                array[0].length>=3?$('#skwdbdm3').text(array[0][2].sectionName):$('#skwdbdm3').text('暂无数据');

                //var wdbGk = result.assinMap.dmxqwdbGk;
                //国考断面详情

                //日管理
                var yearDataQualityGk = result.assinMap.yearDataQualityGk;
                setRglData(yearDataQualityGk);
                console.log(result);
            },
            error: function () {
                Ams.error('数据获取失败！');
            },
            dataType: 'json'
        });
    }

    /**
     *  为断面详情赋值
     */
    function setData(dataMap) {
        var html ="";
        for(var key in dataMap){
            var a = dataMap[key];
            html+="<div class='item'>";
            html +="<h5>";
            html +="<span>"+a.sectionName+"</span>";
            html +="<a onclick=\"DetailList4Month('"+a.sectionCode+"','"+a.sectionName+"')\" >详情</a>";
            html +="</h5>";
            html +="<div class='item-info'>";
            html +="<div class='average-tag'>";
            html +="<span>目标："+Ams.fmtByWtQuality(a.targetQuality)+"</span>";
            html +="<span>"+year+"年均值："+Ams.fmtByWtQuality(a.averageQuality)+"</span>";
            html +="<span>同比：5%  <img src='${request.contextPath}/static/images/new-popup/drop-icon.png'/></span>";
            html +="</div><div class='month-data'>";
            for(var i = 1; i<=12;i++){
                var q =   'resultQuality'+i;
                var element = a[q];
                var z = Ams.isNoEmpty(element)==true?Ams.fmtByWtQuality(element):'-';
                html += "<div class='"+Ams.formatBgclByWtQuality(Ams.fmtByWtQuality(element))+"'>";
                html += "<span>"+i+"月</span>";
                html += "<span>"+z+"</span>";
                html += "</div>";
            }
            html +="</div></div></div>";
        }
        $("#pjhtml div").remove();
        $('#pjhtml').append(html);
    }

    function DetailList4Month(pointCode,pn) {
        var flag;
        if ($('#dmxqbtid').text().indexOf('国') > -1) {
            flag = '1';
        }if ($('#dmxqbtid').text().indexOf('省') > -1) {
            flag = '2';
        }
        $('#detail_pointName').text(pn+'详情');
        setTableData(pointCode,flag);
        /*$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/water/wtCityHourData/getDetailList4Month',
            data: {
                'pointCode': pointCode,
                'flag':flag
            },
            success: function (result) {

            },
            error: function () {
                Ams.error('数据获取失败！');
            },
            dataType: 'json'
        });*/

    }

    /**
     *  为断面详情赋值
     */
    function setRglData(dataRglMap) {
        var h = "";
        for (var key in dataRglMap) {
            var a = dataRglMap[key];
            h += '<div class="item">';
            h += '<div class="home-border-panel water-blue">';
            h += '<div class="home-border-panel-bg">';
            h += '<div class="bg-top-left"></div>';
            h += '<div class="bg-top-center"></div>';
            h += '<div class="bg-top-right"></div>';
            h += '<div class="bg-center-left"></div>';
            h += '<div class="bg-center-center"></div>';
            h += '<div class="bg-center-right"></div>';
            h += '<div class="bg-bottom-right"></div>';
            h += '<div class="bg-bottom-center"></div>';
            h += '<div class="bg-bottom-left"></div>';
            h += '</div>';
            h += '<div class="home-border-panel-body">';
            h += '<div class="target-text-box">';
            h += '<div class="target-text">';
            h += '<div class="area" >' + a[0] + '</div>';
            h += '<div class="name" >' + Ams.fmtByWtQuality(a[2]) + '</div>';
            h += '</div>';
            h += '</div>';
            h += '</div>';
            h += '</div>';
            h += '</div>';
        }
        $("#rglid div:gt(1)").remove();
        $('#rglid').append(h);
    }


    /**
     *  国考断面详情点击
     */
    $('#gkdmxqid').click(function () {
        $('#dmxqbtid').text('国控断面详情');
        var dbGk = global.assinMap.dmxqdbGk;
        setData(dbGk);
        $(".max-water-box").css("display", "flex");

    });

    /**
     *  省考断面详情点击
     */
    $('#skdmxqid').click(function () {
        $('#dmxqbtid').text('省控断面详情');
        var dbSk = global.assinMap.dmxqdbSk;
        setData(dbSk);
        $(".max-water-box").css("display", "flex");

    });

    /**
     *  日目标管理自建断面点击
     */
    $('#rglzjid').click(function () {
        var yearDataQualityZJ = global.assinMap.yearDataQualityZJ;
        setRglData(yearDataQualityZJ);

    });
    /**
     *  日目标管理省考断面点击
     */
    $('#rglskid').click(function () {
        var yearDataQualitySk = global.assinMap.yearDataQualitySk;
        setRglData(yearDataQualitySk);

    });

    /**
     *  日目标管理国考断面点击
     */
    $('#rglgkid').click(function () {
        var yearDataQualityGk = global.assinMap.yearDataQualityGk;
        setRglData(yearDataQualityGk);
    });

    /**
     *  达标断面点击
     */
    $('#dbdmid').click(function () {
        if ($('#dmxqbtid').text().indexOf('国') > -1) {
            var dbGk = global.assinMap.dmxqdbGk;
            setData(dbGk);
        }
        if($('#dmxqbtid').text().indexOf('省')>-1){
            $('#dmxqbtid').text('省控断面详情');
            var dbSk = global.assinMap.dmxqdbSk;
            setData(dbSk);
        }
        if($('#dmxqbtid').text().indexOf('影响达标')>-1){
            //达标的水质
            reachRequstQuality();
        }
        if($('#dmxqbtid').text().indexOf('不升反降')>-1){
            //达标的水质
            getReachRiverData();
        }
    });

    /**
     *  未达标断面点击
     */
    $('#wdbdmid').click(function () {
        if ($('#dmxqbtid').text().indexOf('国') > -1) {
            var wdbGk = global.assinMap.dmxqwdbGk;
            setData(wdbGk);
        }
        if($('#dmxqbtid').text().indexOf('省')>-1){
            $('#dmxqbtid').text('省控断面详情');
            var wdbSk = global.assinMap.dmxqwdbSk;
            setData(wdbSk);
        }
        if($('#dmxqbtid').text().indexOf('影响达标')>-1){
            //影响达标的水质


            affectReachRequstQuality();
        }
        if($('#dmxqbtid').text().indexOf('不升反降')>-1){
            //不升反降的水质

            getReduceRiverData();
        }
    });



    function subStr(s){
        return  s.length > 4 ? s.substr(0, 4) : s;
    }


    function setTableData(pc,flag){
        $(".details-water").css("display", "flex");
        layui.use(['layer','element','table'], function(){ //添加layui模块：弹出层、tab选项卡、数据表格
            var layer = layui.layer
                    ,element = layui.element
                    ,table = layui.table;
            //数据表格
            table.render({
                elem: '#water-table'
                ,theme: '#31882d'
                ,url:Ams.ctxPath + '/enviromonit/water/wtCityHourData/getDetailList4Month'
                ,where : {
                    'pointCode' : pc,
                    'flag': flag
                }
                ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: [ 'prev', 'page', 'next'] //自定义分页布局
                    //,curr: 5 //设定初始在第 5 页
                    //,count:20//数据总数
                    ,limit:12 //每页显示的条数
                    ,groups: 5 //只显示 5 个连续页码
                    ,first: false //不显示首页
                    ,last: false //不显示尾页
                    ,count: 100 //总页数
                    ,theme: '#31882d'
                    //,skip: true //开启跳页
                    ,jump: function(obj, first){
                        if(!first){
                            layer.msg('第'+ obj.curr +'页', {offset: 'b'});
                        }
                    }
                }
                ,cols: [[
                    {field:'yearMonth', width:'10%', title: '监测时间',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'pointName', width:'10%', title: '监测站点',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'pointQuality', width:'10%', title: '目标水质',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'jcsz', width:'10%', title: '检测水质',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'W01001', width:'10%', title: 'PH',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'W01009', width:'10%', title: '溶解氧',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'W01019', width:'10%', title: '高锰酸盐指数',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'W21003', width:'10%', title: '氨氮',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                    ,{field:'W21011', width:'10%', title: '总磷',style:'background: rgb(1, 20, 5,0.5); color: #edfbed;'}
                ]],
                done: function (res, curr, count) {
                    $('tr').css({'background-color': '#08260b', 'color': '#fff'});
                }

                //,data:[]
            });
        });
    }

    /**
     * 不升反降流域
     * 获取的是不升反降的上升的或者持平的数据
     */
    $("#riverDataDetail2").click(function(){
        $('#dbdmid').addClass("select-tag");
        $('#wdbdmid').removeClass("select-tag");
        $('#dbdmid').text("达标流域")
        $('#wdbdmid').text("未达标流域")
        getReachRiverData();
    })
    /**
     * 点击详情获取的是达标的水质
     */
    $("#riverDataDetail").click(function(){
        $('#dbdmid').addClass("select-tag");
        $('#dbdmid').text("达标流域")
        $('#wdbdmid').text("未达标流域")
        $('#wdbdmid').removeClass("select-tag");
        reachRequstQuality();
    })
    $("#rglriver").click(function(){
        getYearRiverData();
    })

</script>

</html>