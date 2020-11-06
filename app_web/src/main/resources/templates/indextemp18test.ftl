<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>漳州环保决策指挥中心</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
    <#include "/decorators/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.animation.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
    <style type="text/css">
    </style>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>

<div class="map-container">
    <div class="map-wrapper"></div><!-- 地图层  -->
    <!-- 工具栏 -->
    <div class="map-app-container">
        <div class="btn-tool" data-toggle="shown" data-target=".map-user-container">
            <span class="icon iconcustom icon-renyuan2"></span>
        </div>
    </div>


    <!-- 工具栏 over -->
    <!--人员列表-->
    <div class="map-user-container show">
        <div class="map-user-box">
            <!--人员信息-->
            <@sec.authentication property="principal.name"/>
            <div class="user-number">
                <div class="user-online"><span class="icon entypo-user"></span> 在线：<span id="onlineUserNum">2</span>
                </div>
                <div class="user-offline"><span class="icon entypo-user"></span> 总数：<span id="allUserNum">2316</span>
                </div>
                <div class="close" data-close=".map-user-container">×</div>
            </div>
            <!--人员信息 over-->
            <!--搜索框-->
            <div class="user-search">
                <div class="user-search-box">
                    <input id="user-search-input" class="map-search-input" placeholder="搜索人员..." value="" type="text">
                    <button id="user-search-button" class="user-search-button" title="搜索" type="button"><span
                                class="icon fa-search"></span></button>
                </div>
            </div>
            <!--搜索框 over-->
            <!--功能按钮-->
            <div class="user-button">
                <div class="button" id="userSearch">
                    <span class="icon iconcustom icon-shaixuan1"></span>筛选
                </div>
                <div class="button" id="userRefresh">
                    <span class="icon iconcustom icon-shuaxin1"></span>刷新
                </div>
            </div>
            <!--功能按钮 over-->
            <div class="filter-container">
                <div class="btn-group">
                    <div class="btn all active">
                        全部
                    </div>
                    <div class="btn online">
                        在线
                    </div>
                </div>
            </div>
            <!--所有人员-->
            <div id="userListDiv" class="user-list-container all">

                <div class="personnel-info offline-user">
                    <div class="personnel-header">
                        <img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
                    </div>
                    <div class="personnel-content">
                        <div class="info">
                            <div class="name fl">杨博文</div>
                            <div class="fr">
                                <div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>
                            </div>
                        </div>
                        <div class="address">
                            <span>所属网络：</span><span>漳州市</span>
                        </div>
                        <div class="address">
                            <span>网络等级：</span><span>一级网格员</span>
                        </div>
                        <div class="address">
                            <span>联系方式：</span><span></span>
                        </div>
                    </div>
                </div>
                <div class="personnel-info offline-user">
                    <div class="personnel-header">
                        <img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
                    </div>
                    <div class="personnel-content">
                        <div class="info">
                            <div class="name fl">杨博文</div>
                            <div class="fr">
                                <div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>
                            </div>
                        </div>
                        <div class="address">
                            <span>所属网络：</span><span>漳州市</span>
                        </div>
                        <div class="address">
                            <span>网络等级：</span><span>一级网格员</span>
                        </div>
                        <div class="address">
                            <span>联系方式：</span><span></span>
                        </div>
                    </div>
                </div>
                <div class="personnel-info">
                    <div class="personnel-header">
                        <img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg">
                    </div>
                    <div class="personnel-content">
                        <div class="info">
                            <div class="name fl">杨博文</div>
                            <div class="fr">
                                <div id="" class="function"><span class="icon iconcustom icon-dingwei3"></span>定位</div>
                            </div>
                        </div>
                        <div class="address">
                            <span>所属网络：</span><span>漳州市</span>
                        </div>
                        <div class="address">
                            <span>网络等级：</span><span>一级网格员</span>
                        </div>
                        <div class="address">
                            <span>联系方式：</span><span></span>
                        </div>
                    </div>
                </div>

            </div>
            <div id="user-pagination" class="pagination-box all ca" style="display: block;">
                <div class="pagination" id="paginationUser">
                    <a class="prev disabled" href="javascript:;" jp-role="prev" jp-data="0">&lt;</a>
                    <a href="javascript:;" jp-role="page" jp-data="1" class="active">1</a>
                    <a href="javascript:;" jp-role="page" jp-data="2">2</a>
                    <a href="javascript:;" jp-role="page" jp-data="3">3</a>
                    <a class="next" href="javascript:;" jp-role="next" jp-data="2">&gt;</a>
                    <div class="page-num" jp-role="last" jp-data="232">
                        共
                        <div class="num">232</div>
                        页,共
                        <div class="num">2316</div>
                        条
                    </div>
                </div>
            </div>
            <!--所有人员  over-->
        </div>
    </div>
    <!--人员列表 over-->


</div>
<!--弹窗-->
<div id="dd" class="easyui-dialog" title="My Dialog" style="width:900px;height:600px;"
     data-options="title:'在线视频调度',closed: true,resizable:true,modal:true,maximizable:true">
    <div class="online-video-container">
        <div class="online-video-header">
            <div class="fr">
                <div class="btn-group">
                    <div class="btn active">
                        视频
                    </div>
                    <div class="btn">
                        路径
                    </div>
                </div>
            </div>
            <div class="title">刘荣斌</div>
        </div>
        <div class="online-video-content">
            <div class="video-box">
                <div class="video-main-box"></div>
                <div class="video-self-box"></div>
                <div class="video-info">
                    <span class="item"><span class="icon iconcustom icon-shipin2"></span></span>
                    <span class="item">刘炳荣</span>
                    <span class="item">1路</span>
                    <span class="item">实时视频中……</span>
                </div>
                <div class="video-operate">
                    <div class="btn dial-up"><span class="icon iconcustom icon-dianhua"></span></div>
                    <div class="btn hang-up"><span class="icon iconcustom icon-guaduandianhua"></span></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/vendor/AgoraRTCSDK-2.8.0.js"></script>
<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

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

        $(target).dialog('open').panel('resize', {
            width: sWidth,
            height: sHeight,
            left: sLeft,
            top: sTop
        });
    }

    $(function () {
        //右边列表的缩起/展开小按钮
        $('body').on('click', '[data-toggle="shown"]', function () {
            var target = $(this).attr("data-target");
            var $target = $(target);
            if ($target.hasClass("show")) {
                $target.removeClass("show");
                $(this).removeClass("active");
            } else {
                $target.addClass("show");
                $(this).addClass("active");
            }
        });
        //人员列表框的关闭按钮，即缩起人员列表框
        $("[data-close]").on('click', function () {
            var $t = $(this);
            var $target = $($t.attr("data-close"));
            if ($target.hasClass("show")) {
                $target.removeClass("show");
            } else {
                $target.addClass("show");
            }
        });
        //小于1366人员列表默认关闭
        var body_w = $('body').width();
        if (body_w < 1366) {
            $('.map-user-container').removeClass('show');
        }
        if (body_w < 1200) {
            var $target = $('.map-caselist-container');
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        }

        //人员列表记录点击效果
        $('.user-list-container').on('click', '.personnel-info', function () {
            $(this).siblings(".personnel-info").removeClass("active");
            $(this).addClass("active");
        });


        //打开弹窗
        dialogOpen('#dd');


    });
    $(window).resize(function () {
        //监听窗口变化，小于1366人员列表默认关闭
        var body_w = $('body').width();
        if (body_w < 1366) {
            $('.map-user-container').removeClass('show');
        } else {
            $('.map-user-container').addClass('show');
        }

        var $target = $('.map-caselist-container');
        if (body_w < 1200) {
            $target.removeClass("show");
            $target.find('.btn-collapse').removeClass("active");
        } else {
            $target.addClass("show");
            $target.find('.btn-collapse').addClass("active");
        }
    });


    //=====================================视频处理===========================

    if (!AgoraRTC.checkSystemRequirements()) {
        alert("Your browser does not support WebRTC!");
    }

    /* select Log type */
    // AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.NONE);
    // AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.ERROR);
    // AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.WARNING);
    // AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.INFO);
    // AgoraRTC.Logger.setLogLevel(AgoraRTC.Logger.DEBUG);

    /* simulated data to proof setLogLevel() */
    AgoraRTC.Logger.error('this is error');
    AgoraRTC.Logger.warning('this is warning');
    AgoraRTC.Logger.info('this is info');
    AgoraRTC.Logger.debug('this is debug');

    var client, localStream, camera, microphone;

    var audioSelect = document.querySelector('select#audioSource');
    var videoSelect = document.querySelector('select#videoSource');

    function join(channel) {//channel是一个频道编号唯一标识
        document.getElementById("join").disabled = true;
        document.getElementById("video").disabled = true;
        var channel_key = null;

        console.log("Init AgoraRTC client with App ID: " + appId.value);
        client = AgoraRTC.createClient({mode: 'live'});
        client.init('e5d4ef4f8b7043328ed38159cffd3ee9', function () {
            console.log("AgoraRTC client initialized");
            client.join(null, 'test', channel, function (uid) {
                console.log("User " + uid + " join channel successfully");
                //然后调用app数据获取app数据返回点击添加


                camera = videoSource.value;
                microphone = audioSource.value;
                localStream = AgoraRTC.createStream({
                    streamID: uid,
                    audio: true,
                    cameraId: camera,
                    microphoneId: microphone,
                    video: document.getElementById("video").checked,
                    screen: false
                });
                //localStream = AgoraRTC.createStream({streamID: uid, audio: false, cameraId: camera, microphoneId: microphone, video: false, screen: true, extensionId: 'minllpmhdgpndnkomcoccfekfegnlikg'});
                localStream.setVideoProfile('720p_3');
                // The user has granted access to the camera and mic.
                localStream.on("accessAllowed", function () {
                    console.log("accessAllowed");
                });

                // The user has denied access to the camera and mic.
                localStream.on("accessDenied", function () {
                    console.log("accessDenied");
                });

                localStream.init(function () {
                    console.log("getUserMedia successfully");
                    localStream.play('video-main-box');

                    client.publish(localStream, function (err) {
                        console.log("Publish local stream error: " + err);
                    });

                    client.on('stream-published', function (evt) {
                        console.log("Publish local stream successfully");
                    });
                }, function (err) {
                    console.log("getUserMedia failed", err);
                });
            }, function (err) {
                console.log("Join channel failed", err);
            });
        }, function (err) {
            console.log("AgoraRTC client init failed", err);
        });

        channelKey = "";
        client.on('error', function (err) {
            console.log("Got error msg:", err.reason);
            if (err.reason === 'DYNAMIC_KEY_TIMEOUT') {
                client.renewChannelKey(channelKey, function () {
                    console.log("Renew channel key successfully");
                }, function (err) {
                    console.log("Renew channel key failed: ", err);
                });
            }
        });


        client.on('stream-added', function (evt) {
            var stream = evt.stream;
            console.log("New stream added: " + stream.getId());
            console.log("Subscribe ", stream);
            client.subscribe(stream, function (err) {
                console.log("Subscribe stream failed", err);
            });
        });
        client.on('stream-subscribed', function(evt) {
            console.log('订阅远程音视频流成功: ' + remoteStream.getId());
        });
        client.on('stream-subscribed', function (evt) {

            console.log("Subscribe remote stream successfully: " + stream.getId());
            if ($('div.video-main-box #agora_remote' + stream.getId()).length === 0) {
                $('div.video-main-box').append('<div id="agora_remote' + stream.getId() + '" style="float:left; width:810px;height:607px;display:inline-block;"></div>');
            }
            stream.play('.video-self-box' + stream.getId());
        });

        client.on('stream-removed', function (evt) {
            var stream = evt.stream;
            stream.stop();
            $('#agora_remote' + stream.getId()).remove();
            console.log("Remote stream is removed " + stream.getId());
        });

        client.on('peer-leave', function (evt) {
            var stream = evt.stream;
            if (stream) {
                stream.stop();
                $('#agora_remote' + stream.getId()).remove();
                console.log(evt.uid + " leaved from this channel");
            }
        });
    }

    function leave() {
        document.getElementById("leave").disabled = true;
        client.leave(function () {
            console.log("Leavel channel successfully");
        }, function (err) {
            console.log("Leave channel failed");
        });
    }

    function publish() {
        document.getElementById("publish").disabled = true;
        document.getElementById("unpublish").disabled = false;
        client.publish(localStream, function (err) {
            console.log("Publish local stream error: " + err);
        });
    }

    function unpublish() {
        document.getElementById("publish").disabled = false;
        document.getElementById("unpublish").disabled = true;
        client.unpublish(localStream, function (err) {
            console.log("Unpublish local stream failed" + err);
        });
    }

    function getDevices() {
        AgoraRTC.getDevices(function (devices) {
            for (var i = 0; i !== devices.length; ++i) {
                var device = devices[i];
                var option = document.createElement('option');
                option.value = device.deviceId;
                if (device.kind === 'audioinput') {
                    option.text = device.label || 'microphone ' + (audioSelect.length + 1);
                    audioSelect.appendChild(option);
                } else if (device.kind === 'videoinput') {
                    option.text = device.label || 'camera ' + (videoSelect.length + 1);
                    videoSelect.appendChild(option);
                } else {
                    console.log('Some other kind of source/device: ', device);
                }
            }
        });
    }

    //audioSelect.onchange = getDevices;
    //videoSelect.onchange = getDevices;
    getDevices();


</script>

</html>