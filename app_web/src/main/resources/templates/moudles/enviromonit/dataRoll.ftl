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
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
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
                    <a class="nav-item-a" href="${request.contextPath}/environment/hugeData">
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
                    <a class="nav-item-a" href="${request.contextPath}/environment/main">
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
                 <a href="/env/mainPage/main.do?type=newWaterDataService&menu=waterEnvironmentMenu&category=6&pid=d7aa1b75-6893-4091-8452-9c9a1ebf8369" target="_blank" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-shidu1"></span>
					<span>水质自动实时监测</span>
				</span>
                <span class="other" id="realTimeWt"></span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="waterMonitoringTable" class="easyui-datagrid"
                           style="height:100%"
                           data-options="
							singleSelect:true,
							fit:true,
							fitColumns:true,
							pagination:false">
                        <thead>
                        <tr>
                            <th align="center" class="ranking" field="type" formatter="orderNm" width="80">排名</th>
                            <th align="center" class="ranking" field="pointName" width="150">监测站点</th>
                            <th align="center" class="ranking" field="targetQuality" formatter="Ams.fmtByWtQuality"
                                width="100">目标水质
                            </th>
                            <th align="center" class="ranking" field="resultQuality" formatter="Ams.fmtByWtQuality"
                                width="100" styler="Ams.setFontColor">抽取水质
                            </th>
                            <th align="center" class="ranking" field="polluteName" width="150">首要污染物</th>
                        </tr>
                        </thead>
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
                <!-- <a href="javascript:void(0)" target="" class="more fr">详情</a> -->
                <span class="title">
					<span class="icon iconcustom iconduoyun"></span>
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
                <!-- <a href="javascript:void(0)" target="" class="more fr">详情</a> -->
                <span class="title">
					<span class="icon iconcustom icon-shujucaiji1"></span>
					<span>网格化事件上报实时数据</span>
				</span>
                <span class="other" id="wgTm"></span>
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
                        <table id="monitoringDetailsTable" class="easyui-datagrid"
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
                                <th align="center" field="reportTime" width="150" formatter=" Ams.timeDateFormat">上报时间
                                </th>
                                <th align="center" field="describe" width="150">描述</th>
                            </tr>
                            </thead>
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
                <a href="/camera/localCameraController/mpv?menu=applicationServiceMenu" target="_blank" class="more fr">更多</a></a>
                <#--<a href="javascript:void(0);" class="more fr" id="cameraList">列表</a>-->

                <span class="title">
					<span class="icon iconcustom icon-shipinjiankong1"></span>
					<span>视频监控</span>
				</span>
                <#--<span class="other">2019.01.01~2019.05.28</span>-->
            </div>
            <div class="home-air-panel-body">
                <div style="width: 100%;height: 400px;">
                    <div class="hide-div">
                        <div style='display:none;'>
                            userName:<select id="SelectUser" name="user" style="width:152px"></select>
                            netZone:<select id="SelectNet" name="net" style="width:152px"></select>
                        </div>
                        <div style='display:none;'>
                            预览类型：
                            <select id="PlayType" style="width:100pix">
                                <option value="0" selected="true">空闲窗口预览</option>
                                <option value="1">选中窗口预览</option>
                                <option value="2">指定窗口预览</option>
                            </select>
                            <select id="seledWndIndex" style="width:40px"></select>
                        </div>
                    </div>
                    <#include "/common/loadingDiv.ftl"/>
                    <div class="ActiveX" style="overflow:hidden;height:100%; width: 100%; background: black;color: red;text-align: center; line-height: 26;">
                        <iframe class="objIframe" style="display:none;position: absolute;z-index: 9;filter:alpha(Opacity=0);-moz-opacity:0;opacity: 0;width: 100%;height: 100%;"></iframe>
                        <object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv" style="width: 100%;height: 100%;"></object>
                    </div>
                </div>
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
            <a href="/env/mainPage/main.do?type=newAirDataService&menu=airEnvironmentMenu&category=7&pid=7c4eb149-2475-4cad-97c9-e4760938de3f" target="_blank" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-liebiao"></span>
					<span>国省控站点AQI排名</span>
				</span>
                <span class="other"></span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="provinceRankingTable" class="easyui-datagrid" url=""
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
                            <th align="center" field="pointName" width="120">监测站点</th>
                            <th align="center" field="aqi" width="80" styler="Ams.setAQIFontColor">AQI</th>
                            <th align="center" field="pollute" width="120">首要污染物</th>
                        </tr>
                        </thead>
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
            	<a href="/env/mainPage/main.do?type=newAirDataService&menu=airEnvironmentMenu&category=7&pid=7c4eb149-2475-4cad-97c9-e4760938de3f" target="_blank" class="more fr">详情</a>
                <span class="title">
					<span class="icon iconcustom icon-liebiao"></span>
					<span>区县AQI排名</span>
				</span>
                <span class="other"></span>
            </div>
            <div class="home-air-panel-body">
                <!--面板主内容-->
                <div class="home-ranking-list">
                    <!-- 数据列表-->
                    <table id="countyRankingTable" class="easyui-datagrid" url=""
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
                            <th align="center" field="pointName" width="120">区县</th>
                            <th align="center" field="aqi" width="80" styler="Ams.setAQIFontColor">AQI</th>
                            <th align="center" field="pollute" width="120">首要污染物</th>
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


    <!--  摄像头列表弹窗  开始 -->
    <div class="new-atmosphere-show video-details">
        <div class="center-box">
            <a class="atmosphere-close"><img src="${request.contextPath}/static/images/new-popup/gas-close.png"></a>
            <div class="data-info">
                <a class="return-tag ">
                    <span class="icon iconcustom"></span>
                </a>
                <h3 class="average">
                    <img src="${request.contextPath}/static/images/new-popup/gas-left-icon.png">
                    <span>详情</span>
                    <img src="${request.contextPath}/static/images/new-popup/gas-right-icon.png">
                </h3>
                <div class="title-head">
                    <div class="inline-block">
                        <label  class="textbox-label textbox-label-before" title="名称">名称:</label>
                        <input id="searchInput" name="HNNM" class="easyui-textbox" style="width: 200px;">
                    </div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary doSearch" data-options="iconCls:'icon-search'">查询</a>
                </div>
                <div class="details-table not-top">
                    <table class="layui-hide" id="video-table">
                    <#include "/common/loadingDiv.ftl"/>
                    </table>
                </div>
                <script type="text/html" id="layui-table-options">
                    <a class="layui-btn layui-btn-xs" lay-event="preview">查看</a>
                </script>
            </div>
        </div>
    </div>
    <!--  摄像头列表弹窗 结束 -->
</div>
</body>
<#-- &lt;#&ndash;监控视频相关JS Start &ndash;&gt;-->
<script type="text/javascript" src="${request.contextPath}/static/camera/md5.js"></script>
<script src="${request.contextPath}/static/camera/zTree/js/jquery.ztree.all-3.5.min.js"></script>
<script src ="${request.contextPath}/static/camera/localMpv.js"></script>
<#-- 选择窗口时间 &ndash;&gt;-->
<script language="javascript" for="spv" event="MPV_FireWndSelected(lWndId, cameraUuid)"></script>
<script language="javascript" for="spv" event="MPV_FirePreviewResult(lWndId, lPreviewResult)"></script>
<script language="javascript" for="spv" event="MPV_FireSnapShot(lWndId,lpPicName,lpCameraUUID,lPicResult)"></script>
<script language="javascript" for="spv" event="MPV_FireFullScreen(lFullScreen)"></script>
<#--监控视频相关JS End -->

<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/ranking.js"></script>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    /*********视频预览相关代码 Start********/
    //hashmap 用来存储 对象
    function HashMap() {
        this.map = {};
    }
    HashMap.prototype = {
        put : function(key, value) {
            this.map[key] = value;
        },
        get : function(key) {
            if (this.map.hasOwnProperty(key)) {
                return this.map[key];
            }
            return null;
        },
        remove : function(key) {
            if (this.map.hasOwnProperty(key)) {
                return delete this.map[key];
            }
            return false;
        },
        removeAll : function() {
            this.map = {};
        },
        keySet : function() {
            var _keys = [];
            for ( var i in this.map) {
                _keys.push(i);
            }
            return _keys;
        },
        containKey: function(key){
            var res = false;
            for ( var i in this.map) {
                if(key === i){
                    res = true;
                }
            }
            return res;
        }
    };

    CameraListDialog = function($container){
        var that = this;
        this.container = $container;
        $container.find(".atmosphere-close").click(function () {
            $(".objIframe").hide();
            $(".video-details").css("display","none")
        });
        $container.find('.doSearch').click(function(){
            that.doSearch();
        });
        layui.use([ 'laypage', 'table'], function(){
            var laypage = layui.laypage //分页
                    ,table = layui.table //表格
            table.render({
                elem: '#video-table'
                ,height: 420
                ,title: '用户表'
                ,data: []
                ,page: true
                ,loading: true
                ,cols: [[
                    {field:'seqNo', title: '序号', width: 50}
                    ,{field:'name', title: '名称', width: 500}
                    ,{field:'pName', title: '站点名称', width: 500}
                    ,{fixed: 'right', title:'操作', toolbar: '#layui-table-options'}
                ]]
            });
            table.on('tool(video-table)',function(obj){
                if('preview'===obj.event){
                    console.log(obj);
                }
            });
        });
    }
    CameraListDialog.prototype = {
        openDialog: function(){
            var that = this;
            $(".objIframe").show();
            $(".video-details").css("display","flex");
            getCameraList("",function(res){
                that.showCameraList(res);
                $("#loadingDiv").fadeOut("normal", function () {
                    $(this).remove();
                });
            });
        },
        doSearch: function(){
            var that = this;
            var searchInput = that.container.find('input#searchInput').val();
            getCameraList(searchInput,function(res){
                that.showCameraList(res);
            });
        },
        getCameraMap: function(cameraList){
            var cameraMap = new HashMap();
            cameraList.forEach(function(value,index){
                cameraMap.put(value.id, value);
            });
            return cameraMap;
        },
        closeDialog: function(){
            $(".atmosphere-close").click();
        },
        showCameraList: function(res, callback){
            var tableData = [];
            var cameraList = res.cameraList;
            var cameraAllList = res.cameraAllList;
            var cameraMap = this.getCameraMap(cameraAllList);
            cameraList.forEach(function(camera, index){
                var iconSkin = camera.iconSkin;
                var id = camera.id;
                var name = camera.name;
                var nodeType = camera.nodeType;
                var pId = camera.pId;
                var pNode = cameraMap.containKey(pId) ? cameraMap.get(pId) : null;
                var pIdName = pNode!=null ? pNode.name : name;

                var camera = {
                    seqNo: index+1,
                    name: name,
                    pName: pIdName
                };
                tableData.push(camera);
            });
            layui.table.reload('video-table',{
                data: tableData
            });
            if(typeof(callback)=='function'){
                callback();
            }
        }
    };

    /**
     * 暂时使用延迟播放方式解决异步问题，以后还需要利用回调函数的方式进行优化
     */
    var cameraListDialog = new CameraListDialog($('.video-details'));
    setTimeout(function () {
        getCameraList("",function(res){
            var cameraList = res.cameraList;
            //判断播放控件是否初始成功
            if(!initSpvxRes){
                console.log('播放控件初始化失败，请确保已安装插件并使用IE浏览器打开！');
                $("div.ActiveX")
                        .html('播放控件初始化失败，请确保已<a href="https://140.237.73.123:8088/zz-sso-server-web/sso/downloadCenter" target="_blank" style="">安装插件</a>并使用 IE10+ 浏览器打开！');
                return;
            }

            cameraPreview(cameraList);
            //之后每隔10分钟执行一次
            setInterval(function(){
                cameraPreview(cameraList);
            },1000*60*10);
        });
    }, 10000);
    //初始化摄像头列表弹窗
    
    //视频监控预览
    function cameraPreview(cameraList){
        for(var i = 0; i < 4; i++){
            if(cameraList.length<i){
                break;
            }
            var index = randomNum(0,cameraList.length);
            var camera = cameraList[index];

            var playType = 2;//0 空闲窗口播放，1 选中窗口播放，2 指定窗口播放
            var windowIndex = i;//指定要播放的窗口（playType为2时才有效）
            startPreview(camera.id, playType, windowIndex);
        }
    }
    //获取后台视频监控列表
    function getCameraList(searchInput, callback) {
        $.ajax({
            type: "POST",
            url: Ams.ctxPath + "/camera/localCameraController/getCameraList",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                searchInput: searchInput
            }),
            success: function (data) {
                var res = {
                    cameraList: [],
                    cameraAllList: []
                };
                data.forEach(function (value, index) {
                    //nodeType为3的节点数据才是监控摄像头
                    if ('3' == value.nodeType) {
                        res.cameraList.push(value);
                    }
                    res.cameraAllList.push(value);
                });
                if(typeof(callback)=='function'){
                    callback(res);
                }
            }
        });
    }
    //生成从minNum到maxNum的随机数
    function randomNum(minNum,maxNum){
        switch(arguments.length){
            case 1:
                return parseInt(Math.random()*minNum+1,10);
                break;
            case 2:
                return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10);
                break;
            default:
                return 0;
                break;
        }
    }
    // 详情弹窗
    $("#cameraList").click(function () {
        cameraListDialog.openDialog();
    });

    /*********视频预览相关代码 End********/

    setInterval(interval, 1000*60*10);

    function interval(){
        rankingPoint();
        rankingCity();
        weather();
        rankingWater();//水质监测
        rankingMonitoringDetailsTable();//网格化人员情况
        console.info(1)
    }

    function whichAnimationEvent(el) {
        var t;
        var animations = {
            'animation': 'animationend',
            'OAnimation': 'oAnimationEnd',
            'MozAnimation': 'animationend',
            'WebkitAnimation': 'webkitAnimationEnd',
            'MsAnimation': 'msAnimationEnd'
        }
        for (t in animations) {
            if (el.style[t] !== undefined) {
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
        $(".btn-switch-tv").click(function () {
            var text = $(this).text();
            if (text === "TV") {
                $("body").removeClass("TV-screen-container");
                $(this).text("Web");

            } else {
                $("body").addClass("TV-screen-container");
                $(this).text("TV");
            }

        });
        rankingPoint();//站点aqi排序
        rankingCity();//城市aqi排序
        rankingWater();//水质监测
        rankingMonitoringDetailsTable();//网格化人员情况
        weather();
    });

</script>

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
    $(".p-right .select-tag").click(function () {
        if ($(".atmosphere-nav").css("height") == "70px") {
            $(".atmosphere-nav").css("height", "auto")
        } else {
            $(".atmosphere-nav").css("height", "70px")
        }
    })
    $(function () {
        /*---------------------------------天气--------------------------------------------------*/
        getAllUserNum();//获取网格化人员数量
        getcommontNum();//获取事件数量(事件总数,已处理是事件,未处理事件)
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

    /**
     * 排名
     * @param value
     * @returns {*|string|*}
     */
    function orderNm(value, row, index) {
        return "<span class='ranking' title='" + (index + 1) + "'>" + (index + 1) + "</span>";

    }
</script>
</html>