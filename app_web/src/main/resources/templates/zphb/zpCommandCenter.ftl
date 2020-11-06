<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳浦云平台调度应急演练</title>

</head>
<!-- body -->
<body class="home-bg-1">
<#include "/common/loadingDiv.ftl"/>

<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"/>
<link href="https://cdn.bootcss.com/animate.css/3.7.2/animate.min.css" rel="stylesheet">

<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="https://cdn.bootcss.com/wow/1.1.2/wow.min.js"></script>
<!-- ol -->
<link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"/>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>

<!-- ol end -->
<!-- 地图相关 -->

<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<script src="${request.contextPath}/static/js/epaConsole.js"></script>
<script src="${request.contextPath}/static/js/vendor/agora-rtm-sdk-0.9.3.js"></script>
<script src="${request.contextPath}/static/js/vendor/AgoraRTCSDK-2.8.0.js"></script>

<!-- 航拍视频相关 -->
<link href="${request.contextPath}/static/css/video-js.css" rel="stylesheet">
<!-- If you'd like to support IE8 -->
<script src="${request.contextPath}/static/js/videojs-ie8.min.js"></script>

<!-- Custom -->
<link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudAir.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudEmergency.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/theme.zhangPu.old.css"/>
<style type="text/css">
    /* 底图控制器 */
    #mapDiv .basemap-toggle {
        position: absolute;
        z-index: 9;
    }
    .layui-layer-iframe{
        z-index: 999!important;
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
    .btn-inspector2{height:43px;line-height: 43px;color: #a6efc0;margin:0px 32px 6px 18px;padding:0;
        background: url("${request.contextPath}/static/images/zhangpu/btn_zp_green_bg_2_center.png");
        -webkitbackground-size:100% 100%;
        background-size:100% 100%;
        cursor: pointer;
        display: inline-block;position: relative;
    }
    .btn-inspector2:before
    ,.btn-inspector2:after{content:"";width: 16px;height: 43px;position: absolute;top:0;right: 100%;
        background: url("${request.contextPath}/static/images/zhangpu/btn_zp_green_bg_2_left.png") no-repeat;
        border: none;-webkit-border-radius:0;-moz-border-radius:0;border-radius:0;
    }
    .btn-inspector2:after{
        background-image: url("${request.contextPath}/static/images/zhangpu/btn_zp_green_bg_2_right.png");left: 100%;right:auto;
    }
    .btn-inspector2:hover{color: #fff;}
    .btn-inspector2 .icon{font-size: 1.3em;margin-right: 4px;}
    .home-air-header-container .header-nav{width: auto;right: 0px;position: absolute;top:24px;}
</style>
<!-- 头部 -->
<header class="home-air-header-container">
    <div class="header-logo">
        <h1 class="logo-text" style="letter-spacing: 3px;">
            漳浦云平台调度应急演练
            <div class="btn-switch-tv">web</div>
        </h1>
    </div>
    <div class="header-nav" >
        <a class="btn-inspector2" href="${request.contextPath}/index">
            <span class="icon iconcustom icon-shouye2"></span>返回首页
        </a>
    </div>
    <!--<div class="header-nav p-right" style="display: none;">

        <div class="atmosphere-nav">
            <ul>
                <li>
                    <a class="nav-item-a" href="#" onclick="openWorn()">
                        <span class="title">开启预警演练</span>
                        <i class="icon iconcustom drop-icon"></i>
                    </a>
                </li>
                <li>
                    <a class="nav-item-a" href="#" onclick="openEmergency()">
                        <span class="title">开启应急方案</span>
                    </a>
                </li>
            </ul>


        </div>
    </div>-->
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
        <div class="home-panel" id="personnel">
            <div class="home-panel-bg">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-bottom-left"></div>
                <div class="bg-bottom-right"></div>
            </div>
            <!--面板主内容-->
            <div  class="searchbox-item">
                <input id="ssk" class="easyui-textbox" style="width:100%;line-height: 36px;height: 36px;"/>
            </div>
            <div class="personnel-list-container" >
                <ul id="root">

                </ul>

            </div>
            <!--面板主内容 over-->
        </div>
        <!--首页面板 over-->
    </div>
    <!-- 左  over-->
    <!-- 右 -->
    <!-- 最新上报案件 -->
    <div class="home-layout fr" id="newCase" style="display: none;">
        <div class="btn-collapse" data-toggle="shown" data-target="#newCase">
            <span class="icon fa-angle-left"></span>
        </div>

        <!--首页面板-->
        <div class="home-panel">
            <div class="home-panel-bg">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-bottom-left"></div>
                <div class="bg-bottom-right"></div>
            </div>
            <div class="home-panel-body">

                <!--面板主内容-->
                <div class="time-axis-container">
                    <ul>
                        <li class="item" id="grid1">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    警报：监测点浓度升高
                                </div>
                                <div class="con">
                                    <div class="title">监测点浓度升高，请发送短信给网格员进行查看</div>
                                </div>
                            </a>
                        </li>
                        <li class="item" id="grid2">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    发送短信告知网格员
                                </div>
                                <div class="con">
                                    <div class="title">短信发送网格员成功</div>
                                </div>
                            </a>
                        </li>

                        <li class="item" id="grid3">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    查看网格员反馈视频  <#--环保应急预案 - 查看排水沟围油栏-->
                                </div>
                                <#--<div class="con">
                                    <div class="title">查看网格员反馈视频，并通过VPN查看真实视频</div>
                                </div>-->
                            </a>
                        </li>

                        <li class="item" id="grid4">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    启动环保应急预案
                                </div>
                                <div class="con">
                                    <div class="title">连线现场总指挥</div>
                                </div>
                            </a>
                        </li>
                        <li class="item" id="grid5">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                 连线应急处置一组
                                </div>
                                <div class="con">
                                    <div class="title">通过视频连线，查看总排口围油栏处置情况。</div>
                                </div>
                            </a>
                        </li>

                        <li class="item" id="grid6">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    连线应急处置二组
                                </div>
                                <div class="con">
                                    <div class="title">通过视频连线，查看事故应急池联通情况。</div>
                                </div>
                            </a>
                        </li>
                        <li class="item" id="grid7">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                    连线应急监测组
                                </div>
                                <div class="con">
                                    <div class="title">通过视频连线，查看现场应急监测情况</div>
                                </div>
                            </a>
                        </li>
                        <li class="item" id="grid8">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                   现场总指挥反馈现场应急处置结果
                                </div>
                                <div class="con">
                                    <div class="title">通过无人机航拍现场情况</div>
                                </div>
                            </a>
                        </li>
                        <li class="item" id="grid9">
                            <a href="#" class="time-axis-box">
                                <div class="step"><#--<span>今天</span>   <span>2017-12-14</span>   <span>15:20</span>-->
                                   应急事故解除
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <!--面板主内容 over-->
            </div>
        </div>
        <!--首页面板 over-->
    </div>
    <!-- 最新上报案件  over-->
    <!-- 右  over-->
    <!-- 地图 -->
    <div class="home-layout oh" id="homeMap">
        <!--首页面板-->
        <div class="home-panel-border">
            <div class="home-border-panel-bg ">
                <div class="bg-top-left"></div>
                <div class="bg-top-right"></div>
                <div class="bg-center-left-top"></div>
                <div class="bg-center-left-bottom"></div>
                <div class="bg-center-right-top"></div>
                <div class="bg-center-right-bottom"></div>
                <div class="bg-bottom-right"></div>
                <div class="bg-bottom-left"></div>
            </div>
            <div class="home-panel-body">
                <div class="home-panel-bg home-border-panel-not">
                    <div class="bg-top-left"></div>
                    <div class="bg-top-right"></div>
                    <div class="bg-bottom-left"></div>
                    <div class="bg-bottom-right"></div>
                    <!--面板主内容-->
                    <div class="map-container">
                        <div class="map-tool"></div>
                        <div class="map-wrapper" id="mapDiv">
                            <div class="basemap-toggle" style="width: 60px; height: 60px; top: 16px; right: 16px;">
                                <div class="basemap" style="width: 60px; height: 60px; z-index: 0; display: none; top: 0px;"
                                     layer-group-name="ZZ_VEC_MAP" title="矢量图层">
                                    <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-1.png" alt="">
                                </div>
                                <div class="basemap" style="width: 60px; height: 60px; z-index: 1; top: 0px;"
                                     layer-group-name="FJ_IMG_MAP" title="影像图层" selected="selected">
                                    <img style="width: 48px; height: 48px; margin: 6px 0 0 6px;" src="${request.contextPath}/static/fjzx-map/img/basemap-2.png" alt="">
                                </div>
                            </div>
                        </div><!--地图图层-->
                        <div class="animated-box">
                            <div class="run-box">
                                <img class="run-icon wow fadeInUp animated" data-wow-delay="0.3s"
                                     src="/static/images/run-icon.png">
                                <img class="border-img wow fadeInUp animated" data-wow-delay="0.5s"
                                     src="/static/images/border-icon1.png">
                            </div>
                            <div class="run-box run-box2">
                                <img class="run-icon wow fadeInUp animated" data-wow-delay="0.8s"
                                     src="/static/images/run-icon.png">
                                <img class="border-img wow fadeInUp animated" data-wow-delay="1.1s"
                                     src="/static/images/border-icon2.png">
                            </div>
                            <div class="run-box run-box3">
                                <img class="run-icon wow fadeInUp animated" data-wow-delay="1.4s"
                                     src="/static/images/run-icon.png">
                                <img class="border-img wow fadeInUp animated" data-wow-delay="1.9s"
                                     src="/static/images/border-icon3.png">
                            </div>
                            <div class="run-box run-box4">
                                <img class="border-img wow fadeInUp animated" data-wow-delay="2.2s"
                                     src="/static/images/borde-icon4.png">
                                <img class="run-icon wow fadeInUp animated" data-wow-delay="2.6s"
                                     src="/static/images/run-icon.png">
                            </div>

                        </div>
                    </div>
                    <!--面板主内容 over-->
                </div>
            </div>
        </div>
        <!--首页面板 over-->
    </div>
    <!-- 地图  over-->
    <div class="ca"></div>


</div>


<!--弹窗-->
<div id="dd" class="easyui-dialog" style="width:450px;height:950px;z-index: 1000000000000000000;"
     data-options="title:'在线视频调度',closed: true,resizable:true,modal:false,maximizable:true">
    <div class="online-video-container">
        <div class="online-video-header">
            <div class="fr">
                <div class="btn-group">
                    <#--                    <div class="btn active">-->
                    <#--                        视频-->
                    <#--                    </div>-->
                    <#--                    <div class="btn">-->
                    <#--                        路径-->
                    <#--                    </div>-->
                </div>
            </div>
            <div class="title" id="videoTitleUser"></div>
        </div>
        <div class="online-video-content">
            <div class="video-box">
                <div class="video-main-box" id="videoSelfId"></div>
                <div class="video-self-box" id="videoMainId"></div>
                <div class="video-info">
                    <span class="item"><span class="icon iconcustom icon-shipin2"></span></span>
                    <span class="item" id="videoUser"></span>
                    <span class="item">1路</span>
                    <span class="item">视频连接中……</span>
                </div>
                <div class="video-operate">
                    <div class="btn dial-up" onclick="dail_up()"><span class="icon iconcustom icon-dianhua"></span>
                    </div>
                    <div class="btn hang-up" onclick='leave("")'><span
                                class="icon iconcustom icon-guaduandianhua"></span></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--弹窗 over-->
<div>
    <audio loop id="audioPlay" src="/static/js/moudles/enviromonit/water/message.ogg" controls="controls"
           style="display: none"></audio>
</div>
<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload>您的浏览器不支持 video 标签。</video>
</div>

<!--  航拍视频弹窗 -->
<div id="aerialVideoDlg" class="easyui-dialog" style="width:800px;height:500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="my-video" class="video-js" controls preload="auto" width="795" height="450"
           poster="" data-setup="{}">
        <source id="videoSource" src="${rtmp}" type="rtmp/flv">
        <p class="vjs-no-js">播放视频需要启用 JavaScript，推荐使用支持HTML5的浏览器访问。
            To view this video please enable JavaScript, and consider upgrading to a web browser that
            <a href="https://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
        </p>
    </video>
</div>

<!--短信弹窗-->
<div class="news-show success-box" style="display: none">
    <div class="news-title">
        <span class="title"></span>
        <span class="icon iconcustom icon-shanchu3 icon-tag close-success"></span>
    </div>
    <div class="content">
        <div class="icon-part2">
            <span class="icon iconcustom icon-queren2"></span>
        </div>
        <p>短信发送成功</p>
        <span class="confirm-tag">确认</span>
    </div>
</div>
<!--短信弹窗 over-->
<style>
    .easyui-tabs-bg .tabs-header, .easyui-tabs-bg .tabs-tool {
        background: rgb(61, 75, 107);
    }
</style>
<!-- 数据分析和详细信息窗口 -->
<div id="air" class="easyui-window" title="详细和数据分析" class="easyui-dialog"
     style="width:1000px;height:600px;background:white;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="map-panel">
        <div id="tt" class="easyui-tabs easyui-tabs-bg" style="width:100%;height:552px; ">
            <div title="详情">
                <div class="panel-group-container">
                    <div class="panel-group-top">
                        <span id="cityName"></span><span class="subtext fr" id="monitrorTime"></span>
                    </div>
                    <div class="panel-group-body">
                        <div class="panel-info" id="airInfo">
                        </div>
                    </div>
                </div>
            </div>

            <div title="数据分析">
                <div class="data-analysis">
                    <div id="radioListContainer" class="radio-button-group radio-button-group1 style-list fl"
                         style="width: 100px;height:100%;">
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

<div id="peripheralAnalysis" class="easyui-window" title="周边分析" class="easyui-dialog"
     style="width:300px;height:200px;background:#FFFFFF;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <div class="easyui-layout" data-options="fit:true">

        <div data-options="region:'center'" style="padding:10px;">
            <input type="hidden" id="pointCode">
            范围：<input class="text" style="width:60%;height:32px;" id="distance">&nbsp公里
        </div>
        <div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
            <div style="margin:0 auto;">
                <input type="button" value="确定" style="width:40%;height:32px;" onclick="selectPeripheral()">
            </div>
        </div>
    </div>

</div>

<script src="${request.contextPath}/static/js/video.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/moudles/enviromonit/air/airAnalysis.js"></script>

</body>
<script type="text/javascript">
    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            getGoupList();
        });
    };
    var divpage = 1;
    var divRowsCount = 0;
    var divRowsCountSecond = 0;

    /*打开dialog*/
    function dialogOpen(target) {
        var sWidth = $(target).dialog('panel').outerWidth();
        var pWidth = $(target).dialog('panel').parent().outerWidth();
        var sHeight = $(target).dialog('panel').outerHeight();
        var pHeight = $(target).dialog('panel').parent().outerHeight();

        sWidth = sWidth < pWidth ? sWidth : pWidth - 40;
        sHeight = sHeight < pHeight ? sHeight : pHeight - 40;

        var sLeft = (pWidth - sWidth) / 2;
        var sTop = (pHeight - sHeight) / 2;
        top.$(target).dialog('open').panel('resize', {
            width: sWidth,
            height: sHeight,
            left: '65%',
            top: sTop
        });
    }

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
        //搜索框
        $('#ssk').textbox({
            prompt:'请输入名称',
            icons: [{
                iconCls:'icon iconcustom icon-shanchu3',
                handler: function(e){
                    getUserInfo();
                    $(e.data.target).textbox('clear');
                }
            },{
                iconCls:'icon iconcustom icon-chaxun1',
                handler: function(e){
                    getSearchUser($(e.data.target).textbox("getText"));
                }
            }]
        })

        function getSearchUser(SearchName) {
            var url = 'http://140.237.73.123:9025/JointServiceBase/JointServiceBaseUserInfo.service?findComponentTreeUserListForZp&_REQUEST_SOURCE=MOBILE&name=' + SearchName;
            var name = 'name';
            $.ajax({
                type: "Get",
                url: url,
                dataType: 'json',
                async:false,
                success: function (data) {
                    var list = JSON.parse(JSON.parse(data.data).list);
                    console.log(list);
                    var joinData = "";
                    var text = " ";
                    for (var i = 0; i < list.length; i++) {
                        //判断是否有下级，没有下级显示具体信息，有下级，显示下级节点信息

                        if (list[i].nodeType == 'DEPARTMENT') {
                            text += "<div class=\"personnel-children\" style=\"display: block\" >";
                            text += "    <ul>";
                            text += "        <li class=\"item\">";
                            text += "            <div class=\"personnel-parent collapsed\" onclick=\"getNextLevel('" + Ams.formatNUll(list[i].id) + "')\">";
                            text += Ams.formatNUll(list[i][name]);
                            text += "            </div>";
                            text += "<div style=\"display: none\" id='" + list[i].id + "'>";
                            text += "</div>";
                            text += "        </li>";
                            text += "    </ul>";
                            text += "</div>";
                        } else {
                            text += "<div id=\"" + list[i].id + "\" class=\"personnel-info offline-user\">";
                            text += "    <div class=\"personnel-header\">";
                            text += "        <img class=\"header-img\" src=\"/static/images/personal-head.png\">";
                            text += "    </div>";
                            text += "    <div class=\"personnel-content collasped\">";
                            text += "        <div class=\"info\">";
                            text += "            <div class=\"name fl\">" + Ams.formatNUll(list[i].name) + "</div>";
                            text += "            <div class=\"fr\">";
                            text += "                 <div onclick='sendMassageToUser(\""+Ams.formatNUll(list[i].mobilePhone)+"\",\""+Ams.formatNUll(list[i].name)+"\")' id=\"\" class=\"function\" ><span class=\"icon iconcustom icon-xinxi1\" ></span>短信</div>";
                            text += "                 <div id=\"\" class=\"function\" onclick=\"join('" + Ams.formatNUll(list[i][name]) + "','" + Ams.formatNUll(list[i].id) + "','send','" + Ams.formatNUll(list[i].positionDescription) + "')\"><span class=\"icon iconcustom icon-luyinduijiang1\"></span>连线</div>                         ";
                            text += "            </div>";
                            text += "        </div>";
                            text += "        <div class=\"address\">";
                            text += "            <span>" + Ams.formatNUll(list[i].positionDescription) + "</span>";
                            text += "        </div>";
                            text += "    </div>";
                            text += "</div> "

                            if (userIds.indexOf(list[i].id) < 0) {
                                userIds.push(list[i].id);
                            } if (allPhones.indexOf(list[i].mobilePhone) < 0) {
                                allPhones += "," + list[i].mobilePhone;
                            }
                            // 获取人员在线状态
                            getUserOnlineStatus([list[i].id]);
                        }
                    }
                    //$("#root").toggle();
                    $("#root").html(text);
                },
                error: function () {
                    layer.msg('不好意思，重新刷新试试');

                }
            });
        }

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
        $(".personnel-list-container").on("click",".personnel-parent",function(){
            var $p=$(this);
            $p.siblings(".personnel-children").slideToggle("slow",function(){
                if($(this).is(":visible")){
                    //alert("显示");
                    $p.removeClass("collapsed");
                }else{
                    //alert("隐藏");
                    $p.addClass("collapsed");
                };
            });

        });


        //打开弹窗
        //dialogOpen('#dd');
        $(".video-tag").click(function () {
            dialogOpen('#dd');
        })

    });

</script>
<script type="text/javascript">
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
        }
    };

    HashMap.prototype.constructor = HashMap;

    var viewNub = 7;// 大气弹窗 导航栏显示的个数
    var map = null;
    var markerMap = new HashMap();
    var questionMarker = null;  //演示点位
    //    var swiperNub = $(".swiper-wrapper .swiper-slide").length;//  大气弹窗 获取导航栏 item  的个数
    //    if(swiperNub>viewNub){
    //        $(".more-tag").show()
    //    }else{
    //        $(".more-tag").hide()
    //    }

    //大气头部 导航 点击切换样式
    // $(".atmosphere-nav li a").click(function () {
    //     $(".atmosphere-nav li a").removeClass("nav-item-select")
    //     $(this).addClass("nav-item-select")
    // })


    //小屏菜单栏
    // $(".p-right .select-tag").click(function () {
    //     if ($(".atmosphere-nav").css("height") == "70px") {
    //         $(".atmosphere-nav").css("height", "auto")
    //     } else {
    //         $(".atmosphere-nav").css("height", "70px")
    //     }
    // })
    $(function () {

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

        /*------------------------地图初始化--------------------------------*/
        var longitude = "117.6038";
        var latitude = "24.1268";
        var defaultLayerGroup = $('div.basemap-toggle').find('div[selected=selected]').attr("layer-group-name") || "FJ_IMG_MAP";
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType(defaultLayerGroup),
            zoom: 13
        });
        map.render();

        var separation = 8;// 子组件展开时的间距。
        var size = 60;
        $('div.basemap-toggle').on({
            mouseenter: function (e) {
                expand(e);
            },
            mouseleave: function (e) {
                collapse(e);
            }
        });
        $('div.basemap-toggle').find('.basemap').click(function(){
            // 已经选中则返回。
            if (!!$(this).attr("selected")) {
                return;
            }
            var layerGroupName = $(this).attr("layer-group-name");
            $(this).parent().find('div[selected=selected]').removeAttr('selected').css('z-index',0);

            // 标记选中状态。
            $(this).attr("selected", "selected");
            //$(this).css("z-index", 10000);
            $(this).animate({
                top: 0
            }, 200);
            collapse(0);
            // 显示当前底图。
            map.getLayers().forEach(function(layer,i){
                if(layer instanceof ol.layer.Group){
                    layer.getLayers().forEach(function(sublayer,j){
                        map.removeLayer(sublayer);
                    });
                }
            });
            var layerGroup = fjzx.map.source.getLayerGroupByMapType(layerGroupName);
            console.log(layerGroup);
            console.log($(this));
            map.setLayerGroup(layerGroup);
        });

        function expand() {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            // 如果已经展开，则返回。
            if (!!$domNode.attr("expand")) {
                return;
            }
            // 标记展开状态。
            $domNode.attr("expand", "expand");
            // 将控制器的高度拉伸到可以覆盖所有展开项的位置，避免越界触发鼠标移出事件。
            $domNode.css("height", (size + separation) * baseMaps.length + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行展开并显示。
                console.log(!$(baseMaps[i]).attr("selected"));
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).css("display", "block");
                    $(baseMaps[i]).animate({
                        top: "+=" + (size + separation) * count
                    }, 300, function (count) {
                        $(this).css("display", "block");
                        $(this).css("top", (size + separation) * count + "px");
                    });
                }
            }
        }

        function collapse(time) {
            var $domNode = $('div.basemap-toggle');
            var baseMaps = $domNode.children(".basemap");
            var count = 0;
            if (Object.prototype.toString.call(time) !== "[object Number]") {
                time = 200;
            }
            // 如果没有展开，则返回。
            if (!$domNode.attr("expand")) {
                return false;
            }
            // 移出展开状态标记。
            $domNode.removeAttr("expand");
            $domNode.css("height", size + "px");
            for (var i = 0; i < baseMaps.length; i++) {
                // 如果不是选中项则执行收起并隐藏。
                if (!$(baseMaps[i]).attr("selected")) {
                    count++;
                    $(baseMaps[i]).animate({
                        top: "-=0"
                    }, time, function () {
                        $(this).css("display", "none");
                        $(this).css("top", 0);
                    });
                }
            }
        }

        /*$.ajax({
            type: "Get",
            url: 'https://140.237.73.123:8094/EpaRegulatoryWarning/RegulatoryWarningMonitorDevice.service?getRegulatoryWarningMonitorDeviceListByEnterpriseId&type=WG_DE_ITEM&enterpriseId=2ApNFZiLl5dGDruj-u7itf&_REQUEST_SOURCE=MOBILE',
            dataType: 'json',
            success: function (data) {
                var list = JSON.parse(data.data).list;
                for (var i = 0; i < list.length; i++) {
                    var markerId = list[i].deviceId;
                    // var html = "<div  class='map-sign-tag cyan-sign-tag' style='top: 300px;left: 100px'  onclick='openInfo("+list[i]+")'>";
                    var html = "<div  class='map-sign-tag cyan-sign-tag' style='top: 300px;left: 100px' onclick='openInfo(\"" + list[i].deviceId + "\",\""+markerId+"\")'>"
                        + '<div class="sign-info sign-back"><span class="sign-nub">-</span><span class="sign-name">'
                        + list[i].dischargePortIdName + '</span></div></div>';

                    var point = new fjzx.map.Point(list[i].longitude, list[i].latitude);
                    var tempMarker = new fjzx.map.Marker(point, {
                        isShowIcon: false,
                        markerHtml: html,
                        map: map
                    });
                    markerMap.put(markerId, tempMarker);
                    map.addOverlay(tempMarker);

                }
            },
            error: function () {
                console.log('获取点位信息报错了');
            }
        });*/
       /* // //地图上的点位
        var pointAry = [[23.8009902, 117.6192504]];
        var pointNameAry = ["监测点"];
        //创建point
        for (var i = 0; i < pointAry.length; i++) {
            var point = new fjzx.map.Point(pointAry[i][1], pointAry[i][0]);
            var markerId = "markerId_"+i;
            var html = '<div id="markerDiv' + i + '" class="map-sign-tag cyan-sign-tag" style="top: 300px;left: 100px" onclick="openInfo(\'\',\''+markerId+'\')">'
                + '<div class="sign-info sign-back"><span class="sign-nub">-</span><span class="sign-name">'
                + pointNameAry[i] + '</span></div></div>';

            var tempMarker = new fjzx.map.Marker(point, {
                isShowIcon: false,
                markerHtml: html,
                map: map
            });
            if (i == 0) {
                questionMarker = tempMarker;
            }
            markerMap.put(markerId, tempMarker);
            map.addOverlay(tempMarker);
        }*/

        creatMarker("0", "aqi");
    });
    var mapPoint = new Array(); // 人员点数组

    /**
     * 清除点位
     */
    function clearMapPoint() {
        for (var i = 0; i < mapPoint.length; i++) {
            map.removeOverlay(mapPoint[i]);
        }
    }

    /**
     * 定位
     */
    function setPosition(longitude, latitude) {
        map.setCenter(new fjzx.map.Point(longitude, latitude));
    }

    var groupList=new Array();//组的集合
    function getUserInfo() {
        clearMapPoint();
        //var url = 'http://140.237.73.123:9025/JointServiceBase/JointServiceBaseUserInfo.service?getComponentTreeUserListForDataCenter&departmentId=3tv6x_GDVbBqcs6q2OwLlq&_REQUEST_SOURCE=MOBILE';
        var url = 'http://140.237.73.123:9025/JointServiceBase/JointServiceBaseUserInfo.service?getComponentTreeUserListForZp&_REQUEST_SOURCE=MOBILE';

        var text = "";
        var name = 'name';
        var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        text += "<ul>";
        $.ajax({
            type: "Get",
            url: url,
            dataType: 'json',
            async:false,
            success: function (data) {
                var list = JSON.parse(JSON.parse(data.data).list);
                var joinData = "";
                var text = " ";
                for (var i = 0; i < list.length; i++) {
                    // if (list[i].count != 0) {
                    //     list.push(list[i]);
                    // }
                    //根据根节点查找下一级数据
                    text += "<li class=\"item\">";
                    text += "    <div class=\"personnel-parent collapsed\" onclick=\"getNextLevel('" + Ams.formatNUll(list[i].id)+"')\">";
                    text += Ams.formatNUll(list[i][name]);
                    text += "   </div>";
                    text += "<div  style=\"display: none\" id='"+list[i].id+"' >";
                    text += "</div>";
                    text += "</li>";
                    text += "<li>";
                    /*text += "<div id='hpView' class=\"home-panel\">\n" +
                        "                    <div class=\"home-panel-bg\">\n" +
                        "                        <div class=\"bg-top-left\"></div>\n" +
                        "                        <div class=\"bg-top-right\"></div>\n" +
                        "                        <div class=\"bg-bottom-left\"></div>\n" +
                        "                        <div class=\"bg-bottom-right\"></div>\n" +
                        "                        </div>\n" +
                        "                        <div  class=\"box-bg box-btn\">\n" +
                        "                        航拍视频全景\n" +
                        "                        </div>\n" +
                        "                        </div>";*/
                    text += "</li>";
                }

                text += "</ul>";
                $("#root").html(text);

                for (var j = 0; j < groupList.length; j++) {
                   getNextLevel(groupList[j]);
                 }
                layer.close(loadIndex);
                $("#hpView").click(function () {
                    //iframe层
                    layer.open({
                        type: 2,
                        title: '航拍视频播放',
                        shadeClose: true,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['900px', '610px'],
                        offset:['200px','100px'],
                        content: '/videoDemo' //iframe的url
                    });
                    //$('#aerialVideoDlg').dialog('open').dialog('center').dialog('setTitle', '航拍视频播放');

                });
            },
            error: function () {
                layer.msg('不好意思，重新刷新试试');

            }
        });
    }

    function getGoupList() {
        var url = 'http://140.237.73.123:9025/JointServiceBase/JointServiceBaseUserInfo.service?getComponentTreeDepartmentListForDataCenterOther&departmentId=1NAICIZvh8UEviyYkdCkdq&_REQUEST_SOURCE=MOBILE';
        $.ajax({
            type: "Get",
            url: url,
            dataType: 'json',
            async:false,
            success: function (data) {
                var list = JSON.parse(JSON.parse(data.data).list);
                //去除根节点
                for (var i = 0; i < list.length; i++) {
                    if (groupList.indexOf(list[i].id) < 0) {
                        groupList.push(list[i].id);
                    }
                }
                initRtmClient();
            },
            error: function () {
                layer.msg('不好意思，重新刷新试试');

            }
        });
    }

    var userIds = []
    var num = 1 ;
    var allPhones = '';
    function getNextLevel(pid) {
        $("#" + pid).siblings(".personnel-parent").toggleClass("collapsed");

        var url = 'http://140.237.73.123:9025/JointServiceBase/JointServiceBaseUserInfo.service?getComponentTreeUserListForDataCenter&_REQUEST_SOURCE=MOBILE&departmentId=' + pid;
        var name = 'name';
        $.ajax({
            type: "Get",
            url: url,
            dataType: 'json',
            async:false,
            success: function (data) {
                var list = JSON.parse(JSON.parse(data.data).list);
                var joinData = "";
                var text = " ";
                for (var i = 0; i < list.length; i++) {
                    //判断是否有下级，没有下级显示具体信息，有下级，显示下级节点信息

                    if (list[i].nodeType == 'DEPARTMENT') {
                        text += "<div class=\"personnel-children\" style=\"display: block\" >";
                        text += "    <ul>";
                        text += "        <li class=\"item\">";
                        text += "            <div class=\"personnel-parent collapsed\" onclick=\"getNextLevel('" + Ams.formatNUll(list[i].id) + "')\">";
                        text += Ams.formatNUll(list[i][name]);
                        text += "            </div>";
                        text += "<div style=\"display: none\" id='" + list[i].id + "'>";
                        text += "</div>";
                        text += "        </li>";
                        text += "    </ul>";
                        text += "</div>";
                    } else {
                        text += "<div id=\"" + list[i].id + "\" class=\"personnel-info offline-user\">";
                        text += "    <div class=\"personnel-header\">";
                        text += "        <img class=\"header-img\" src=\"/static/images/personal-head.png\">";
                        text += "    </div>";
                        text += "    <div class=\"personnel-content collasped\">";
                        text += "        <div class=\"info\">";
                        text += "            <div class=\"name fl\">" + Ams.formatNUll(list[i].name) + "</div>";
                        text += "            <div class=\"fr\">";
                        text += "                 <div onclick='sendMassageToUser(\""+Ams.formatNUll(list[i].mobilePhone)+"\",\""+Ams.formatNUll(list[i].name)+"\")' id=\"\" class=\"function\" ><span class=\"icon iconcustom icon-xinxi1\" ></span>短信</div>";
                        text += "                 <div id=\"\" class=\"function\" onclick=\"join('" + Ams.formatNUll(list[i][name]) + "','" + Ams.formatNUll(list[i].id) + "','send','" + Ams.formatNUll(list[i].positionDescription) + "')\"><span class=\"icon iconcustom icon-luyinduijiang1\"></span>连线</div>                         ";
                        text += "            </div>";
                        text += "        </div>";
                        text += "        <div class=\"address\">";
                        text += "            <span>" + Ams.formatNUll(list[i].positionDescription) + "</span>";
                        text += "        </div>";
                        text += "    </div>";
                        text += "</div> "

                        if (userIds.indexOf(list[i].id) < 0) {
                            userIds.push(list[i].id);
                        } if (allPhones.indexOf(list[i].mobilePhone) < 0) {
                            allPhones += "," + list[i].mobilePhone;
                        }
                        // 获取人员在线状态
                        getUserOnlineStatus([list[i].id]);
                    }
                }
                $("#" + pid).toggle();
                $("#"+pid).html(text);
            },
            error: function () {
                layer.msg('不好意思，重新刷新试试');

            }
        });
    }

    function getUserOnlineStatus(userIds) {
        clientRTM.queryPeersOnlineStatus(userIds).then(function(results) {
            for (var id in results) {
                var isOnline = results[id];
                console.log(id + "  " + isOnline)
                $("#" + id).attr("class", isOnline ? "personnel-info online-user" : "personnel-info offline-user");
            }
        });
    }

    // 轮询用户在线状态
    function pollingUserOnlineStatus() {
        setInterval(function() {
            if (userIds.length > 0) {
                getUserOnlineStatus(userIds);
            }
        }, 30000)
    }

    //=====================================视频处理===========================

    /*
    if (!AgoraRTC.checkSystemRequirements()) {
    }
    */
    var clientRTC, localStream, camera, microphone, channel;

    // 初始化Client对象
    function join(name, id, sendOrReceive, gridName) {
        $("#videoTitleUser").text(name);
        $("#videoUser").text(name);
        channel = id;
        if (sendOrReceive == 'send') {
            var msg = {type: 1, fromUserName: '指挥中心', channelName: id};
            sendMsg(id, JSON.stringify(msg), function () {
                // 先发送消息给客户端，如果发送成功，即对方在线，则建立连接
                initRtcClient(name, id, sendOrReceive, gridName);
            });
        } else {
            initRtcClient(name, id, sendOrReceive, gridName);
        }
        $(".btn.dial-up").hide();
        dialogOpen('#dd');
    }

    function initRtcClient(name, id, sendOrReceive, gridName) {

        clientRTC = AgoraRTC.createClient({mode: 'live', codec: 'h264'});
        clientRTC.init(
            '${rtcProperties.appid}', // 这里填注册完后的APPID
            function () {
                clientRTC.join( // 加入频道
                    null,
                    channel, // 频道名称，可以自己定义
                    null, // 用户标识id,可以自己定义。唯一就可以
                    function (zpUid) {
                        console.log('用户id：' + zpUid + ' 加入频道成功');
                        // 创建音视频流
                        localStream = AgoraRTC.createStream({
                            streamID: zpUid,
                            audio: true,
                            video: true,
                            screen: false
                        });

                        // 初始化本地的音视频流
                        localStream.init(

                            function () {

                                console.log('获取用户媒体成功');
                                localStream.play('videoMainId'); // 显示本地视频播放<div>标签id名
                                // 发布本地音视频流
                                clientRTC.publish(localStream, function (err) {
                                    console.log('发布本地音视频流失败: ' + err);
                                    leave('发布本地音视频流失败');
                                });
                                clientRTC.on('stream-published', function (evt) {
                                    console.log('发布本地音视频流成功');
                                });
                            },
                            function (err) {
                                console.log('获取用户媒体失败', err);
                            }
                        );
                        // --------- 订阅远端音视频流 --------欢迎使用 漳州环境资源中心系统 - Powered By 厦门智慧指间股份有限公司
                        // 监听到新的视频
                        clientRTC.on('stream-added', function (evt) {
                            connectVideo = 1;
                            var stream = evt.stream;
                            console.log('有新的音视频流: ' + stream.getId());
                            clientRTC.subscribe(stream, function (err) {
                                console.log('订阅音视频流失败', err);
                                leave('订阅音视频流失败');
                            });
                        });
                        // 订阅远程视频
                        clientRTC.on('stream-subscribed', function (evt) {
                            connectVideo = 1;
                            var remoteStream = evt.stream;
                            console.log('=====订阅远程音视频流成功: remote_id = ' + remoteStream.getId() + "  local_id = " + zpUid);
                            // 显示远程视频播放<div>标签id名
                            remoteStream.play('videoSelfId');
                            layer.msg('连接成功');

                                changeColor(gridName);

                            $('#showCnet').text('实时视频中……');

                        });
                        clientRTC.on('peer-leave', function (evt) {
                            var stream = evt.stream;
                            if (stream) {
                                stream.play("videoSelfId")
                                stream.stop();
                                stream.close();
                                leave('对方已挂断');
                                console.log(evt.zpUid + " leaved from this channel");
                            }
                        });
                    },

                    function (err) {
                        console.log('加入频道失败', err);
                        //leave('加入频道失败');
                    }
                );
            },
            function (err) {
                console.log('AgoraRTC clientRTC 初始化失败', err);
                //leave('AgoraRTC clientRTC 初始化失败');
            }
        );
    }

    function leave(msg) {
        if (Ams.isNoEmpty(msg)) {
            layer.msg(msg);
        } else {
            layer.msg('通话结束');
        }

        $("#dd").dialog('close');//关闭视频后会执行关闭事件
    }

    var connectVideo = 0;
    // 关闭视频后关闭声音
    $("#dd").dialog({
        onClose: function () {
            isVideoing = false;
            console.log("======= isVideoing: " + isVideoing);
            // if (connectVideo == 1) {
            closeAudio();
            $(".btn.dial-up").hide();
            // 取消发布本地音视频流
            localStream.play('videoMainId')
            localStream.stop();
            localStream.close();
            $('#showCnet').text('视频连接中……');
            // if (clientRTM && clientRTM.connectionState == 'CONNECTED') clientRTM.logout();通讯调用需要一直存在
            clientRTC.leave(function () {
                console.log("Leavel channel successfully");
                // Ams.success('通话结束');
            }, function (err) {
                console.log("Leave channel failed");
            });
            // }
            connectVideo = 0;
        },
        onOpen: function() {
            isVideoing = true;
        }
    });

    //====================================rtm实时消息==========================================
    var clientRTM, receiveUserName, receiveChannelName, videoType;
    var audio = document.getElementById("audioPlay");

    // 是否正在通话，目前只要视频通话对话框打开就表示正在通话
    var isVideoing = false;
    //邀请或接受请求
    function initRtmClient() {
        if (clientRTM == null) {
            clientRTM = AgoraRTM.createInstance('${rtcProperties.appid}');
            clientRTM.on('ConnectionStateChanged', function (newState, reason) {//获取连接状态,监听状态的事件;
                //=>写法相当于function (newState,reason){}
                console.log('on connection state changed to ' + newState + ' reason: ' + reason);
            });
            clientRTM.login({token: null, uid: '${rtcProperties.zpUid}'}).then(function () {
                // 因为需要获取人员状态，所以需要先登录RTM服务器，然后再去获取人员列表，再调用RTM接口判断人员是否在线
                getUserInfo();
                pollingUserOnlineStatus();
            }).catch(function (err) {
                console.log('RTM 登录失败', err);
                layer.msg('RTM登录失败，请刷新试试');
            });
            clientRTM.on('MessageFromPeer', function ({text}, peerId) {
                var jsonText = JSON.parse(text);
                videoType = jsonText.type;
                receiveUserName = jsonText.fromUserName;
                if (videoType == 2) {//播放视频
                    var videoUrl = 'https://140.237.73.123:9041/EpaProblemProcessing/do.video?uploadDownloadControllerId=common&&fileId=' + jsonText.fileId + '&_REQUEST_SOURCE=MOBILE'
                    setTimeout(function () {
                        layer.msg("网格员上传视频中");
                        $("#fileVideo").show();
                        layer.confirm('<p style="color:black">' + jsonText.content + '</p>', {
                            title: receiveUserName + '网格员上报了一个新视频',
                            btn: ['前往查看', '取消'] //按钮
                        }, function () {
                            layer.closeAll('dialog');
                            $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
                            $('#video').css("width", "100%");
                            $('#video').attr({"src": videoUrl, "autoplay": "true"});
                            changeColor("查看网格员视频")//网格员上传视频查看后变成红色;
                        }, function () {
                        });

                    }, 0);
                } else {//视频通话;
                    console.log("===== 收到视频通话消息 =====")
                    if (!isVideoing) {
                        $(".btn.dial-up").show();
                        playAudio();
                        receiveChannelName = jsonText.channelName;
                        $("#videoTitleUser").text(receiveUserName);
                        $("#videoUser").text(receiveUserName);
                        changeColor("现场总指挥反馈")
                        dialogOpen('#dd');
                    } else {
                        // 如果当前正在通话，告知手机端web正在忙，即发送type为3的事件
                        var msg = {type: 3, fromUserName: '指挥中心'};
                        sendMsg(jsonText.channelName, JSON.stringify(msg));
                    }
                }

            });
        }
    }

    function sendMsg(userId, msg, successCallback, failCallback) {
        clientRTM.sendMessageToPeer(
            {text: msg}, // 符合 RtmMessage 接口的参数对象
            userId, // 远端用户 ID
        ).then(function (sendResult) {
            if (sendResult.hasPeerReceived) {
                connectVideo = 1;
                /* 远端用户收到消息的处理逻辑 */
                console.log('发送成功');
                if (typeof(successCallback) != "undefined") {
                    successCallback();
                }
            } else {
                connectVideo = 0;
                leave('对方不在线');
                console.log(typeof(failCallback))
                if (typeof(failCallback) != "undefined") {
                    failCallback();
                }
            }
        }).catch(function (err) {
            /* 发送失败的处理逻辑 */
            console.log('发送失败的处理逻辑,请重试！');
            console.log(typeof(failCallback))
            if (typeof(failCallback) != "undefined") {
                failCallback();
            }
            leave('对方不在线');
        });
        return connectVideo;
    }

    function dail_up() {
        $(".btn.dial-up").hide();
        closeAudio();
        join(receiveUserName, receiveChannelName, 'receive');
    }

    function playAudio() {
        var audioPlay = document.getElementById("audioPlay");
        audioPlay.play();
    }

    function closeAudio() {
        var audioPlay = document.getElementById("audioPlay");
        if (!audioPlay.paused)
            audioPlay.pause();
    }

    //===============变色================
    function changeColor(gridName) {
        switch (gridName) {
            case"开启预警演练"://对应警报
                startEmergency('grid1');
                return;
            case"发送短信"://发送短信告知网格员
                startEmergency('grid2');
                return;
            case"查看网格员视频"://查看网格员视频
                startEmergency('grid3');
                return;
            case"启动环保应急预案"://启动环保应急预案
                startEmergency('grid4');
                return;
            case"应急处置一组"://应急处置一组
                startEmergency('grid5');
                return
            case"应急处置二组"://应急处置二组
                startEmergency('grid6');
                return
            case"应急监测组"://连线应急监测组
                startEmergency('grid7');
                return;
            case"现场总指挥反馈"://现场总指挥反馈(手机端连接视屏请求)
                startEmergency('grid8');
                return
            case"警报解除"://应急事故解除
                startEmergency('grid9');
                return;
        }

    }

    function openWorn() {
        //layer.msg('开启预警演练成功');
        // changeColor(gridName);
    }

    function openEmergency() {
        //layer.msg('开启应急方案成功');
        changeColor('启动环保应急预案');
    }

    function startEmergency(groupId) {
        //$(".time-axis-container li").removeClass("highlight");
        $("#" + groupId).addClass("highlight");
    }

    function showView() {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        changeColor('查看网格员视频');
        $('#video').attr("src", Ams.ctxPath + '/static/js/moudles/enviromonit/water/shp.mp4');
    }

    <#--$(".atmosphere-nav li a").click(function () {-->
        <#--var tex = $(this).find("span").text();-->
        <#--switch (tex) {-->
            <#--case "开启预警演练":-->
                <#--isOver = true;-->
                <#--$(this).find("span").text("演练开始中");-->
                <#--//发送短信通知应急人员-->
                <#--var phone = allPhones.replace(",","")+",15260616872,18020654774";-->
                <#--console.log(phone);-->
                <#--//根据无人机地址判断是否为线上-->
                <#--if ("${rtmp}" == "rtmp://140.237.73.123:9011/live/1") {-->
                    <#--$.ajax({-->
                        <#--type: "POST",-->
                        <#--url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/sendMsg',-->
                        <#--dataType: 'json',-->
                        <#--data: {-->
                            <#--phones: phone,-->
                            <#--names: '应急人员',-->
                            <#--message: "即将开启预警演练，请做好准备。"-->
                        <#--},-->
                        <#--success: function (data) {-->
                            <#--layer.msg('已发送短信通知应急人员做好预警演练开启准备。')-->
                        <#--},-->
                        <#--error: function () {-->
                            <#--layer.msg('短信发送失败');-->
                        <#--}-->
        <#---->
                    <#--});-->
                <#--}-->
                <#---->
                <#--setTimeout(function () {-->
                    <#--changeColor("开启预警演练");-->
                    <#--var html = '<div id="markerDiv0" class="map-sign-tag crimson-sign-tag" style="top: 400px;left: 100px" onclick="openInfo()">'-->
                        <#--+ '<div class="sign-info sign-back"><span class="sign-nub"><i class="icon iconcustom icon-fanhui2"></i></span>'-->
                        <#--+ '<span class="sign-name">监测点1溶度升高</span></div></div>';-->
                    <#--$("#markerDiv0").html(html);-->
                    <#--openInfo();-->
                <#--}, 3 * 1000);-->
                <#--break-->
            <#--case "演练开始中":-->
                <#--$(this).find("span").text("开启预警演练");-->
                <#--layer.msg('演练结束')-->
                <#--break-->
            <#--case "开启应急方案":-->
                <#--$(this).find("span").text("警报解除");-->
                <#--layer.msg('开启应急方案');-->
                <#--break-->
            <#--case "警报解除":-->
                <#--$(this).find("span").text("开启应急方案");-->
                <#--isOver = false;-->
                <#--layer.msg('警报解除')-->
                <#--changeColor("警报解除");-->
                <#--var html = '<div id="markerDiv0" class="map-sign-tag cyan-sign-tag" style="top: 300px;left: 100px">'-->
                    <#--+ '<div class="sign-info sign-back"><span class="sign-nub">-</span><span class="sign-name">监测点</span></div></div>';-->
                <#--$("#markerDiv0").html(html);-->
                <#--openInfo("","markerId_0")-->
                <#--break-->
        <#--}-->
        <#--$(".atmosphere-nav li a").removeClass("select-tag");-->
        <#--$(this).addClass("select-tag")-->
    <#--})-->

    function openInfo(deviceId,markerId) {
        var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });

        if(markerId==null || typeof(markerId) == "undefined"){
            markerId = "markerId_0";

            var info = '<div class="exceed-box" style="width: max-content"><table>';
            info += '<tr><th><span>[二氧化硫(mg/m3)]:6.800</span></th><td><span class="font-color">超标</span></td></tr>'
            info += '<tr><th><span>[硫化氢(mg/m3)]:1.900</span></th><td><span class="font-color">超标</span></td></tr>'
            info += '<tr><td colspan="2"><span id="fsdx" onclick="sendMassage()">发送短信告知网格员</span></td></tr></table></div>';
            var infoWindow = new fjzx.map.InfoWindow({infoWindow: info});

            var marker = markerMap.get(markerId);
            map.setCenter(marker.getPosition());
            marker.openInfoWindow(infoWindow);

            layer.close(loadIndex);
            return;
        }

        /*this.getRegulotryWarningMonitorDeviceDataByDeviceId(deviceId, function(infoWindowHtml){
            var infoWindow = new fjzx.map.InfoWindow({infoWindow: infoWindowHtml});

            var marker = markerMap.get(markerId);
            map.setCenter(marker.getPosition());
            marker.openInfoWindow(infoWindow);

            layer.close(loadIndex);
        });*/
    }

    var isOver = false;
    //根据设备id远程获取站点最新一条监测数据
    function getRegulotryWarningMonitorDeviceDataByDeviceId(deviceId, callback){
        //设备ID为空时使用默认设备ID
        if(isOver && deviceId==""){
            var info = '<div class="exceed-box" style="width: max-content"><table>';
            info += '<tr><th><span>[二氧化硫(mg/m3)]:6.800</span></th><td><span class="font-color">超标</span></td></tr>';
            info += '<tr><th><span>[硫化氢(mg/m3)]:1.900</span></th><td><span class="font-color">超标</span></td></tr>';
            info += '<tr><td colspan="2"><span id="fsdx" onclick="sendMassage()">发送短信告知网格员</span></td></tr></table></div>';
            if(typeof(callback)=='function'){
                callback(info);
            }
        } else {
            if (deviceId==""){
	            deviceId = "1wJOaLOHBcg9Rtnjm6bqjG";
            }
	        /*$.ajax({
	            type: "Get",
	            url: 'https://140.237.73.123:8094/EpaRegulatoryWarning//RegulatoryWarningMonitorDeviceData.service?getRegulotryWarningMonitorDeviceDataByDeviceId&type=WG_DE_ITEM&_REQUEST_SOURCE=MOBILE&queryDeviceId='+deviceId,// + obj,暂时注释掉，目前没有数据，只有写死的有，后面需要写活的
	            dataType: 'json',
	            success: function (data) {
	                var list = JSON.parse(data.data).list;
	                var info = '<div class="exceed-box" style="width: max-content"><table>';
	                var columnNameArray;
	                var columnIdArray;
	                for (var i = 0; i < list.length; i++) {
	                    var data = list[i];
	                    columnNameArray = data.collumName.split(',');
	                    columnIdArray = data.collumId.split(',');
	                    for (var j = 0; j < columnNameArray.length; j++) {
	                        var columnName = removeSquareBrackets(columnNameArray[j]).replace("red","");
	                        var columnId = removeSquareBrackets(columnIdArray[j]);
	                        var columnVal = data[columnId].length==0 ? 0 : data[columnId];
	                        if (columnName != '') {
	                            info += '<tr><th><span>' + removeBr(columnName) + ': ' + columnVal + '</span></th><td><span style="color: #45b97c;">正常</span></td></tr>';
	                        }
	                    }
	                }
	                info += '<tr><td colspan="2"><span id="fsdx" onclick="sendMassage()">发送短信告知网格员</span></td></tr></table></div>';
	                if(typeof(callback)=='function'){
	                    callback(info);
	                }
	            },
	            error: function (e) {
	                layer.close(loadIndex);
	                console.log(e);
	                console.log('获取点位信息报错了');
	            }
	
	        });*/
        }
    }

    function removeBr(data) {
        if (Ams.isNoEmpty(removeBr))
            return data.replace("<br/>", "")
    }

    function removeSquareBrackets(data) {
        if (Ams.isNoEmpty(removeBr))
            return data.replace("[", "").replace("]", "")
    }

    function sendMassageToUser(mobilePhone, name) {
        if (!Ams.isNoEmpty(mobilePhone)) {
            layer.msg('电话号码为空，不能发送短信');
            return;
        }
        layer.prompt({title: '给' + name + '发送短信', formType: 2, value: ''},
            function (pass, index) {
                /* var phone = '15280210304';
                 if ("
                ${rtmp}" == "rtmp://140.237.73.123:9011/live/1") {
                        phone = '13906969072'; //13906969072   该号码为线上人员使用号码
                    }*/
                $.ajax({
                    type: "POST",
                    url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/sendMsg',
                    dataType: 'json',
                    data: {
                        phones: mobilePhone,
                        names: name,
                        message: pass
                    },
                    success: function (data) {
                        layer.msg('短信发送成功');
                        changeColor("发送短信");
                    },
                    error: function () {
                        layer.msg('短信发送失败');
                    }

                });
                layer.close(index);
            });
    }
    function sendMassage() {
        //询问框
        layer.confirm('<span style="color:black">监测站点溶度超标，速去查看原因，上传现场视频。</span>', {
            title:'向网格员发送短信',btn: ['确定','取消']
        },function(){
            var phone = '15280210304';
            if ("${rtmp}" == "rtmp://140.237.73.123:9011/live/1") {
                phone = '13906969072'; //13906969072   该号码为线上人员使用号码
            }
            $.ajax({
                type: "POST",
                url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/sendMsg',
                dataType: 'json',
                data: {
                    phones: phone,
                    names: '黄绿青',
                    message: "监测站点溶度超标，速去查看原因，上传现场视频。"
                },
                success: function (data) {
                    layer.msg('短信发送成功');
                    changeColor("发送短信");
                },
                error: function () {
                    layer.msg('短信发送失败');
                }

            });
        }, function(){
            
        });
        
        /* layer.prompt({title: '发送短信', formType: 2, value: '监测站点溶度超标，速去查看原因，上传现场视频。'},
            function (pass, index) {
                var phone = '15280210304';
                if ("${rtmp}" == "rtmp://140.237.73.123:9011/live/1") {
                    phone = '13906969072'; //13906969072   该号码为线上人员使用号码
                }
                $.ajax({
                    type: "POST",
                    url: Ams.ctxPath + '/enviromonit/water/userContcatInfo/sendMsg',
                    dataType: 'json',
                    data: {
                        phones: phone,
                        names: '黄绿青',
                        message: pass
                    },
                    success: function (data) {
                        layer.msg('短信发送成功');
                        changeColor("发送短信");
                    },
                    error: function () {
                        layer.msg('短信发送失败');
                    }

                });
                layer.close(index);
            }); */
    }

    //关闭短信发送成功弹窗
    $(".close-success,.confirm-tag").click(function () {
        $(".success-box").hide()
    })

    $(".box-bg").click(function () {
        //iframe层
        parent.layer.open({
            type: 2,
            title: '航拍视频播放',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['900px', '610px'],
            content: '/videoDemo' //iframe的url
        });
        //$('#aerialVideoDlg').dialog('open').dialog('center').dialog('setTitle', '航拍视频播放');
        changeColor("应急检测组人员");
    });

    var monitorPoint = new Array();  //监测站点
    function creatMarker(type, factor, pointCode) {
        //向地图上添加自定义标注
        $.ajax({
            type: 'POST',
            dataType: 'json',
            async: false,
            url: Ams.ctxPath + '/enviromonit/airMonitorPoint/getCityByType',
            data: {type: type, factor: factor, pointCode: pointCode},
            success: function (data) {

                var markes = [];
                $.each(data, function (i) {
                    if (data[i].longitude == '-' && data[i].latitude == '-') {
                        return true;
                    }
                    var marker;
                    //设置信息窗口要显示的内容
                    var color = "#b8b8b8";
                    var clas = "map-sign-tag";
                    if (data[i].color >= 0 && data[i].color <= 50) {
                        color = "#00E400";
                        clas = "map-sign-tag green-sign-tag";
                    } else if (data[i].color >= 51 && data[i].color <= 100) {
                        color = "#CFCF00";
                        clas = "map-sign-tag yellow-sign-tag";
                    } else if (data[i].color >= 101 && data[i].color <= 150) {
                        color = "#FF7E00";
                        clas = "map-sign-tag red-sign-tag";
                    } else if (data[i].color >= 151 && data[i].color <= 200) {
                        color = "#FF0000";
                        clas = "map-sign-tag violet-sign-tag";
                    } else if (data[i].color >= 201 && data[i].color <= 300) {
                        color = "#99004C";
                        clas = "map-sign-tag brown-sign-tag";
                    } else if (data[i].color >= 301 && data[i].color <= 500) {
                        color = "#7E0023";
                        clas = "map-sign-tag blue-sign-tag";
                    }
                    //创建信息窗口对象
                    var html = "";
                    if (type == 2) {
                        html = "<div class ='infowindow' style='width: 120px;text-align: center;cursor:pointer;'><div class='tdt-infowindow-content' style='width: 40px;margin-left:40px;'>" +
                            "<div style='height:100%;line-height: 25px;width:100%;text-align: center;font-weight:bold;background-color:" +
                            color + "' dataStr='" + JSON.stringify(data[i]) + "' onclick= 'show(this," + type + ");'>" + data[i].value +
                            "</div></div><div class='tdt-infowindow-tip-container'><div class='tdt-infowindow-tip'></div></div><div  >" + data[i].pointName + "</div></div>";
                    } else {
                        html = "<div class='infowindow " + clas + "' dataStr='" + JSON.stringify(data[i]) + "' onclick= 'show(this," + type + ");'><div class='sign-info'><span class='sign-nub'>" + data[i].value + "</span><span class='sign-name'>"
                            + data[i].pointName + "</span></div></div>";
                    }

                    //创建pint
                    var point = new fjzx.map.Point(data[i].longitude, data[i].latitude);
                    var myMarker = new fjzx.map.Marker(point, {
                        markerHtml: html,
                        map: map,
                        isShowIcon: false,
                    });
                    map.addOverlay(myMarker);
                    if (type == '1') {
                        cityPoint[i] = myMarker;
                    }
                    else if (type == '0') {
                        monitorPoint[i] = myMarker;
                    } else if (type == '2') {
                        builtPoint[i] = myMarker;
                    }
                    //向地图上添加信息窗口
                });
            }
        });

    }

    /*判断值是否为空*/
    function isNull(value) {
        if (value == null) {
            return '-';
        } else {
            return value;
        }
    }

</script>
</html>
