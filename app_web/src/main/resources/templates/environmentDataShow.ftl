<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>实时动态数据-大数据</title>

</head>
<!-- body -->
<body class="">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudAir.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudData.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/new-water.css"/>


<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>

<style type="text/css">

</style>
<!-- 头部 -->
<header class="home-air-header-container">
    <div class="header-logo">
        <h1 class="logo-text" style="letter-spacing: 3px;">
            实时动态数据
            <div class="btn-switch-tv">TV</div>
        </h1>
    </div>
    <div class="header-nav p-right">
        <a href="${request.contextPath}/index" class="open-link-tag" target="_blank">进入系统</a>
        <div class="atmosphere-nav">
            <ul>
                <li>
                    <a class="nav-item-a select-tag">
                        <span class="title">大气环境</span>
                        <i class="icon iconcustom drop-icon"></i>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="${request.contextPath}/environment/waterDataShow">
                        <span class="title">水环境</span>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="${request.contextPath}/main">
                        <span class="title">生态环境问题</span>
                    </a>
                </li>
            </ul>



        </div>
    </div>
    <div class="header-other p-left">
        <span id="weatherDate">2018年9月20日</span>
        <span class="icon iconcustom icon-zhire" id="weatherIcon"></span>
        <span id="weather">多云  北风1~2级</span>
        <span id="wind">多云  北风1~2级</span>
        <span id="temperature">多云  北风1~2级</span>
    </div>
</header>
<!-- 头部 over  -->

<div class="home-air-container">
    <!-- 左 -->
    <div class="home-layout fl" id="home-left">
        <!--首页面板-->
        <div class="home-air-panel" id="waterMonitoring">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-shidu1" ></span>
					<span>水质自动实时监测</span>
				</span>
                <span class="other">实时：2019.7.13  10:00</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="waterMonitoringTable" class="easyui-datagrid" url=""
                           style="height:100%"
                           data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
                        <thead>
                        <tr>
                            <th align="center" field="type" width="80">排名</th>
                            <th align="center" field="value" width="150">监测站点</th>
                            <th align="center" field="AQI" width="100">目标水质</th>
                            <th align="center" field="AQI2" width="100">抽取水质</th>
                            <th align="center" field="AQI3" width="150">首要污染物</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">2</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">3</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">4</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">5</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">6</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">7</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">8</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">9</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">10</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">11</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">12</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">13</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>
                        <tr>
                            <td><span class="ranking">1</span></td>
                            <td>南靖靖城桥</td>
                            <td>5</td>
                            <td>5</td>
                            <td>5</td>
                        </tr>

                        </tbody>
                    </table>
                    <!-- 数据列表 over-->
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-air-panel" id="todayWeather">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom iconduoyun" ></span>
					<span>今日天气</span>
				</span>
                <span class="other" id="wTime">7:30更新</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="box-body">
                    <div class="sub-title">
                        <span id="wAddre">10:00</span>
                    </div>
                    <div class="weather-mian">
                        <span class="icon iconcustom icon-wenduji2"></span>
                        <span><span class="em" id="wTemp">26</span>℃</span>
                    </div>
                    <ul class="weather-info-list">
                        <li class="item">
                            <span class="icon iconcustom icon-shidu1"></span>
                            <span class="text">相对湿度</span>
                            <span class="text" id="humidity">71</span>%
                        </li>
                        <li class="item">
                            <span class="icon iconcustom icon-songfeng"></span>
                            <span class="text wWind">东南风</span>
                            <span class="text">2级</span>
                        </li>
                        <!-- <li class="item">
                            <span class="icon iconcustom icon-huanjing1"></span>
                            <span class="text">50</span>
                            <span class="text">优</span>
                        </li> -->
                    </ul>
                </div>
                <div class="box-body">
                    <div class="sub-title">
                        <span>今日</span>白天
                    </div>
                    <div class="weather-mian">
                        <!-- <span class="icon iconcustom iconxiaoyu"></span> -->
                        <img id="wDayP" style="width:84px;height:84px;"/>
                    </div>
                    <div class="weather-temperature">
                        <span id="wDayTemp">34</span>℃
                    </div>
                    <ul class="weather-info-list" style="margin-top:45px">
                        <li class="item">
                            <div class="icon iconcustom icon-songfeng"></div>
                            <div class="text wWind">东南风</div>
                            <div class="text">2级</div>
                        </li>
                        <!-- <li class="item">
                            <div class="icon iconcustom icon-zhire"></div>
                            <div class="text">日出</div>
                            <div class="text">05:27</span>
                        </li> -->
                    </ul>
                </div>
                <div class="box-body">
                    <div class="sub-title">
                        <span>今日</span>夜间
                    </div>
                    <div class="weather-mian">
                        <!-- <span class="icon iconcustom iconxiaoyu"></span>
                        <div>小雨</div> -->
                        <img id="wNightP" style="width:84px;height:84px;"/>
                    </div>
                    <div class="weather-temperature">
                        <span id="wNightTemp">24</span>℃
                    </div>
                    <ul class="weather-info-list" style="margin-top:45px">
                        <li class="item">
                            <div class="icon iconcustom icon-songfeng"></div>
                            <div class="text wWind">东南风</div>
                            <div class="text">2级</div>
                        </li>
                        <!-- <li class="item">
                            <div class="icon iconcustom icon-zhire"></div>
                            <div class="text">日落</div>
                            <div class="text">19:01</span>
                        </li> -->
                    </ul>
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
        <div class="home-air-panel" id="monitoringDetails">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-shujucaiji1" ></span>
					<span>网格化事件上报实时数据</span>
				</span>
                <span class="other">实时：2019.7.13  10:00</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="box-content row">
                    <div class="grid-info">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-renyuan2"></span>
                        </div>
                        <div class="panel-right">
                            <div>网格化人员</div>
                            <div><span id="userNum">154</span></div>
                        </div>
                    </div>
                    <div class="grid-info">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-renwuguanli2"></span>
                        </div>
                        <div class="panel-right">
                            <div>事件数量</div>

                            <div><span title="68001,367" id="countThingNum">6800万</span></div>
                        </div>
                    </div>
                    <div class="grid-info">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-jibenxinxi2"></span>
                        </div>

                        <div class="panel-right">
                            <div>已处理事件</div>
                            <div><span id="handledThings">650</span></div>
                        </div>
                    </div>
                    <div class="grid-info">
                        <div class="panel-left ani duration05">
                            <span class="icon iconcustom icon-renwu2"></span>
                        </div>
                        <div class="panel-right">
                            <div>待处理事件</div>
                            <div><span id="waitHandleThings">154</span></div>
                        </div>
                    </div>
                </div>
                <div class="data-table-box">
                    <div class="home-ranking-list">
                        <!-- 数据列表-->
                        <table id="monitoringDetailsTable" class="easyui-datagrid" url="/gridRemote/service/getCommonlyCaseList"
                               style="height:100%"
                               data-options="
								singleSelect:true,
								fit:true,
								fitColumns:true,
								pagination:false">
                            <thead>
                            <tr>
                                <th align="center" field="sourceName" width="80">事件来源</th>
                                <th align="center" field="majorTypeIdName" width="150">事件类型</th>
                                <th align="center" field="departmentIdName" width="100">所属网格</th>
                                <th align="center" field="address" width="100">事发位置</th>
                                <th align="center" field="reportTime" width="150" formatter=" Ams.timeDateFormat">上报时间</th>
                                <th align="center" field="describe" width="150">描述</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">2</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">3</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">4</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">5</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">6</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">7</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">8</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">9</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">10</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">11</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">12</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">13</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td><span class="ranking">1</span></td>
                                <td>南靖靖城桥</td>
                                <td>5</td>
                                <td>5</td>
                                <td>5</td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- 数据列表 over-->
                    </div>
                </div>
                <!--面板主内容 over-->
            </div>

        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-air-panel" id="videoSurveillance">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-shipinjiankong1" ></span>
					<span>视频监控</span>
				</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="video-box">

                </div>
                <div class="video-box">

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
        <div class="home-air-panel" id="provinceRanking">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-liebiao" ></span>
					<span>国省控站点AQI排名</span>
				</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="provinceRankingTable" class="easyui-datagrid" url="/enviromonit/airHourData/rankingOrderByAQI?pointType=0"
                           style="height:100%"
                           data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
                        <thead>
                        <tr>
                            <th align="center" field="num" width="80" formatter="numStyle">排名</th>
                            <th align="center" field="monitrorTime" width="150">监测时间</th>
                            <th align="center" field="pointName" width="100">监测站点</th>
                            <th align="center" field="aqi" width="100">AQI</th>
                            <th align="center" field="pollute" width="150">首要污染物</th>
                        </tr>
                        </thead>
                        <tbody id="provinceRankingTable_data">
                        </tbody>
                    </table>
                    <!-- 数据列表 over-->
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
        <!--首页面板-->
        <div class="home-air-panel" id="countyRanking">
            <div class="home-air-panel-header">
                <a href="#" target="" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-liebiao" ></span>
					<span>区县AQI排名</span>
				</span>
                <span class="other">2019.01.01~2019.05.28</span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="countyRankingTable" class="easyui-datagrid" url="/enviromonit/airHourData/rankingOrderByAQI?pointType=1"
                           style="height:100%"
                           data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
                        <thead>
                        <tr>
                            <th align="center" field="num" width="80" formatter="numStyle">排名</th>
                            <th align="center" field="monitrorTime" width="150">监测时间</th>
                            <th align="center" field="pointName" width="100">区县</th>
                            <th align="center" field="aqi" width="100">AQI</th>
                            <th align="center" field="pollute" width="150">首要污染物</th>
                        </tr>
                        </thead>
                    </table>
                    <!-- 数据列表 over-->
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->

    </div>
    <!-- 中  over-->
    <div class="ca"></div>


</div>




</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    /*---简单循环滚动---*/
    function loopScroll($obj,offset,speed){
        $obj.animate({scrollTop:offset},speed,'linear',function(){
            $obj.scrollTop(0);
        });
    }
    function loopScrollOdj(objname,speed,delay) {
        var obj,offset;
        delay=delay?delay:0;
        this.obj = obj = $("#"+objname+" .home-ranking-list .datagrid-body");
        this.objC = this.obj.children(".datagrid-btable");
        this.offset = offset = this.objC.height()-this.obj.height()+delay;
        this.speed = speed = speed*$("#"+objname+"Table").datagrid("getData").total;
        this.lFunction = function(){
            loopScroll(this.obj,this.offset,this.speed);
        }
        this.lFunction();
        this.Scroll=self.setInterval(function(){
            loopScroll(obj,offset,speed)
        },this.speed);
        this.clearScroll=function(){
            clearInterval(this.Scroll);
        };
    }



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
    //console.log(whichAnimationEvent());
    /* var animationEvent = whichAnimationEvent(el);
    animationEvent && e.addEventListener(animationEvent, function() {
    	console.log('Animation 完成!  原生JavaScript回调执行!');
    }); */
    $(function () {
        /*切换大屏*/
        $(".btn-switch-tv").click(function(){
            var text=$(this).text();
            if(text==="TV"){
                $("body").removeClass("TV-screen-container");
                $(this).text("Web");

            }else{
                $("body").addClass("TV-screen-container");
                $(this).text("TV");
            }

        });
        /*简单循环滚动-开始*/
        var loopScrollOdj1 = new loopScrollOdj("waterMonitoring",1000,40);
        var loopScrollOdj3 = new loopScrollOdj("provinceRanking",1000,40);
        var loopScrollOdj4 = new loopScrollOdj("countyRanking",1000,40);
        var loopScrollOdj2 = new loopScrollOdj("monitoringDetails",1000,40);

        /*--------------------定时动画--------------------------*/
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
            },4000);
        });
    });

</script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/ranking.js"></script>
<script type="text/javascript">

    var viewNub = 7;// 大气弹窗 导航栏显示的个数
    //    var swiperNub = $(".swiper-wrapper .swiper-slide").length;//  大气弹窗 获取导航栏 item  的个数
    //    if(swiperNub>viewNub){
    //        $(".more-tag").show()
    //    }else{
    //        $(".more-tag").hide()
    //    }

    //大气头部 导航 点击切换样式
    $(".atmosphere-nav li a").click(function () {
        $(".atmosphere-nav li a").removeClass("nav-item-select")
        $(this).addClass("nav-item-select")
    })


    //小屏菜单栏
    $(".p-right .select-tag").click(function(){
        if( $(".atmosphere-nav").css("height")=="70px"){
            $(".atmosphere-nav").css("height","auto")
        }else{
            $(".atmosphere-nav").css("height","70px")
        }
    })
    $(function () {
        getAllUserNum();//获取网格化人员数量
        getcommontNum();//获取事件数量(事件总数,已处理是事件,未处理事件)
    /*    rankingPoint();
        rankingCity();*/
        weather();
        /*---------------------------------天气--------------------------------------------------*/
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/hugeData/getWeather',
            async: true,
            success: function (data) {
                var result = eval('(' + data + ')');
                var weather = result.results[0].weather_data[0];
                if (weather.date != null) {
                    $('#weatherDate').html(weather.date);
                } else {
                    $('#weatherDate').html("-");
                }
                if (weather.wind != null) {
                    $('#wind').html(weather.wind);
                } else {
                    $('#wind').html("-");
                }
                if (weather.weather != null) {
                    $('#weather').html(weather.weather);
                    $('#weatherIcon').removeClass();
                    $('#weatherIcon').addClass(Ams.weatherIcon(weather.weather));
                } else {
                    $('#weather').html("-");
                }
                if (weather.temperature != null) {
                    $('#temperature').html(weather.temperature);
                } else {
                    $('#temperature').html("-");
                }
            }
        });
    })


    //获取网格人员总数
    function getAllUserNum() {
        $.ajax({
            url: "/gridRemote/service/getAllUserNum",
            type: "POST",
            dataType: 'json',
            success: function (data) {
                $("#userNum").text(data.userAllNum)
            }
        })
    }

    function getcommontNum() {
        $.ajax({
            url: "/gridRemote/service/getCommonlyCaseNum",
            type: "POST",
            dataType: 'json',
            success: function (data) {
                $("#waitHandleThings").text(data.registerCommonlyCaseNum)//未处理事件
                $("#countThingNum").text(data.commonlyCaseNum);//事件总数已处理事件加上未处理事件;
                $("#handledThings").text(data.commonlyCaseNum - data.registerCommonlyCaseNum);//已处理事件
            }
        })
    }

</script>
</html>