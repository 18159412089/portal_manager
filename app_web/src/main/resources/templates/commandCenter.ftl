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

    <script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
    <!-- ol -->
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
    <!-- Custom -->
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <!-- ol end -->
    <!-- 地图相关 -->

    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
    <script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
    <script src="${request.contextPath}/static/js/epaConsole.js"></script>
    <script src="${request.contextPath}/static/js/vendor/agora-rtm-sdk-0.9.3.js"></script>

    <style type="text/css">

    </style>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<div class="map-container">
    <div id="mapDiv" class="map-wrapper"></div><!-- 地图层  -->
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
            <div class="user-number">
                <div class="user-online"><span class="icon entypo-user"></span> 在线：<span id="onlineUserNum"></span>
                </div>
                <div class="user-offline"><span class="icon entypo-user"></span> 总数：<span id="allUserNum"></span></div>
                <div class="close" data-close=".map-user-container">×</div>
            </div>
            <!--人员信息 over-->
            <!--搜索框-->
            <div class="user-search">
                <div class="user-search-box">
                    <input id="user-search-input" class="map-search-input" onkeydown="keydown(event)"
                           placeholder="请输入人员姓名模糊搜索" type="text">
                    <button id="user-search-button" class="user-search-button" onclick="userRefresh()" title="搜索"
                            type="button"><span
                                class="icon fa-search"></span></button>
                    <div >
                        <audio loop id="audioPlay" src="/static/js/moudles/enviromonit/water/message.ogg" controls="controls" style="display: none"></audio>
                    </div>
                </div>
            </div>
            <!--搜索框 over-->
            <!--功能按钮-->
            <div class="user-button">
                <div class="button" id="userSearch">
                    <#--<span class="icon iconcustom icon-shaixuan1"></span>筛选-->
                </div>
                <div class="button" id="userRefresh" onclick="userRefresh()">
                    <span class="icon iconcustom icon-shuaxin1"></span>刷新
                </div>
            </div>
            <!--功能按钮 over-->
            <div class="filter-container">
                <div class="btn-group">
                    <div id="all" class="btn all active">
                        全部
                    </div>
                    <div id="line" class="btn online">
                        在线
                    </div>
                </div>
            </div>
            <!--所有人员-->
            <div id="userListDiv" class="user-list-container all"></div>
            <div id="user-pagination" class="pagination-box all ca" style="display: block;">
                <div id="page-container" class="page-container"></div>
            </div>
            <!--所有人员  over-->
            <!--在线人员  -->
            <div id="onlineListDiv" class="user-list-container online" style="display: none"></div>
            <div id="user-pagination2" class="pagination-box all ca" style="display: none;">
                <div id="page-container2" class="page-container"></div>
            </div>
            <!--在线人员  over-->
        </div>
    </div>
    <!--人员列表 over-->


</div>
<!--弹窗-->
<div id="dd" class="easyui-dialog" title="My Dialog" style="width:450px;height:1000px;"
     data-options="title:'在线视频调度',closed: true,resizable:true,modal:true,maximizable:true">
    <div class="online-video-container">
        <div class="online-video-header">
            <div class="fr">
                <div class="btn-group">
                    视频
                    <div class="btn active">
                    </div>
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
                    <span class="item" id="showCnet">视频连接中……</span>
                </div>
                <div class="video-operate">
                     <div class="btn dial-up" onclick="dail_up()"><span class="icon iconcustom icon-dianhua"></span></div>
                    <div class="btn hang-up" onclick='leave("")'"><span
                                class="icon iconcustom icon-guaduandianhua"></span></div>
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
            getAll(url_all, 'allUserNum');
            getAll(url_online, 'onlineUserNum');
            //all
            getUserInfo(url_all);

        });
    };
    var url_all = 'https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getAllUserListForPortal&queryName=&page=1&_REQUEST_SOURCE=MOBILE';
    var url_online = 'https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getUserListOnlineForPortal&queryName= &page=1&_REQUEST_SOURCE=MOBILE';
    var flag = '0';
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

        $(target).dialog('open').panel('resize', {
            width: sWidth,
            height: sHeight,
            left: sLeft,
            top: sTop
        });
    }

    $(function () {

        var longitude = "117.6292504";
        var latitude = "23.7999902";
        var map = null;
        map = initMap({
            target: "mapDiv",
            center: [parseFloat(longitude), parseFloat(latitude)],
            layers: fjzx.map.source.getLayerGroupByMapType("ZZ_VEC_MAP"),
            zoom: 12
        });
        map.render();
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
        //人员列表状态按钮
        $('.map-user-box .btn-group').on('click', '.btn', function () {
            $(".map-user-container .user-list-container").hide();
            $(".map-user-container .pagination-box").hide();
            if ($(this).hasClass("all")) {
                //全部
                $(".map-user-container .user-list-container.all").show();
                $(".map-user-container .pagination-box.all").show();
                $('#all').removeClass("active");
                $('#line').removeClass("active");
                $('#all').addClass('active');
                $("#user-pagination").css('display', 'block');
                $("#user-pagination2").css('display', 'none');
                divpage = 1;
                flag = '0';
                userRefresh();
            }
            if ($(this).hasClass("online")) {
                //在线
                $(".map-user-container .user-list-container.online").show();
                $(".map-user-container .pagination-box.online").show();
                $('#all').removeClass("active");
                $('#line').removeClass("active");
                $('#line').addClass('active');
                $("#user-pagination").css('display', 'none');
                $("#user-pagination2").css('display', 'block');
                flag = '1';
                divpage = 1;
                userRefresh();
            }
        });
        getRtmSample();
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
    $('#user-search-button').click(function () {

    });

    /*================map begin====================*/
    var user_icon = new fjzx.map.Icon("/static/fjzx-map/img/map_markers_person2.png", {
        size: new fjzx.map.Size(25, 25),
        imgSize: new fjzx.map.Size(25, 25),
        anchor: new fjzx.map.Point(12, 25)
    });
    var user_icon2 = new fjzx.map.Icon("/static/fjzx-map/img/map_markers_person1.png", {
        size: new fjzx.map.Size(25, 25),
        imgSize: new fjzx.map.Size(25, 25),
        anchor: new fjzx.map.Point(12, 25)
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

    /*==========map end============*/

    function keydown(event) {
        if (event.keyCode == 13) {
            userRefresh();
        }

    }

    function getInfo() {
        var name = $('#user-search-input').val();
        if ("0" == flag) {
            getUserInfo('https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getAllUserListForPortal&queryName=' + name + '&page=1&_REQUEST_SOURCE=MOBILE');
        } else {
            getUserInfo('https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getUserListOnlineForPortal&queryName=' + name + ' &page=1&_REQUEST_SOURCE=MOBILE');

        }
    }

    function getUserInfo(url) {
        clearMapPoint();
        var text = "";
        var name = 'name';
        var div = 'userListDiv';
        var offLine = 'personnel-info offline-user';
        var icon = user_icon2;
        if (flag == '1') {
            name = 'userName';
            div = 'onlineListDiv';
            offLine = 'personnel-info';
            icon = user_icon
        }
        var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        $.ajax({
            type: "Get",
            url: url,
            dataType: 'json',
            success: function (data) {
                var list = JSON.parse(data.data).list;
                divRowsCount = JSON.parse(data.data).sizeInfo.maxSize;
                var joinData = "";
                for (var i = 0; i < list.length; i++) {
                    if ("0" == flag && list[i].isOnline == 'ONLINE') {
                        offLine = 'personnel-info';
                        icon = user_icon;
                    }
                    joinData = JSON.stringify(list[i]);
                    text += "<div class= '" + offLine + "' onclick=\"setPosition('" + list[i].longitude + "','" + list[i].latitude + "')\">";
                    text += "	<div class=\"personnel-header\">";
                    text += "		<img class=\"header-img\" src=\"${request.contextPath}/static/images/personal-head.jpg\">";
                    text += "	</div>";
                    text += "	<div class=\"personnel-content\">";
                    text += "		<div class=\"info\">";
                    text += "			<div class=\"name fl\">" + Ams.formatNUll(list[i][name]) + "</div>";
                    text += "			<div class=\"fr\">";
                    text += "			   <div id=\"\" class=\"function video-tag\" onclick=\"join('" + Ams.formatNUll(list[i][name]) + "','" + Ams.formatNUll(list[i].id) + "','send')\"><span class=\"icon iconcustom icon-shipin2\"></span>视频</div>";
                    text += "				<div id=\"\" class=\"function\" onclick=\"setPosition('" + list[i].longitude + "','" + list[i].latitude + "')\"><span class=\"icon iconcustom icon-dingwei3\" onclick=\"setPosition('" + list[i].longitude + "','" + list[i].latitude + "')\"></span>定位</div>";
                    text += "			</div>";
                    text += "		</div>";
                    text += "		<div class=\"address\">";
                    text += "			<span>所属网络：</span><span>" + Ams.formatNUll(list[i].departmentIdFullName) + "</span>";
                    text += "		</div>";
                    text += "		<div class=\"address\">";
                    text += "			<span>网络等级：</span><span>" + Ams.formatNUll(list[i].userLevel) + "</span>";
                    text += "		</div>";
                    text += "		<div class=\"address\">";
                    text += "			<span>联系方式：</span><span>" + Ams.formatNUll(list[i].mobilePhone) + "</span>";
                    text += "		</div>";
                    text += "	</div>";
                    text += "</div>";

                    var tempMarker = new fjzx.map.Marker(new fjzx.map.Point(list[i].longitude, list[i].latitude), {
                        icon: icon,
                        map: map,
                        title: Ams.formatNUll(list[i][name])
                    });
                    mapPoint.push(tempMarker);
                    map.addOverlay(tempMarker);
                }
                $("#" + div).html(text);
                if (divRowsCount != divRowsCountSecond) {
                    getLayTable(divRowsCount);
                }
                layer.close(loadIndex);
            },
            error: function () {
                Ams.error('不好意思，重新刷新试试');
            }
        });
    }

    function getAll(url, textId) {
        var text = "";
        var name = 'name';
        $.ajax({
            type: "Get",
            url: url,
            dataType: 'json',
            success: function (data) {
                $('#' + textId).text(JSON.parse(data.data).sizeInfo.maxSize);
                $('#' + textId).text(JSON.parse(data.data).sizeInfo.maxSize);
            },
            error: function () {
                Ams.error('不好意思，重新刷新试试');
            }


        });
    }

    /**
     * 分页栏
     */
    function getLayTable(count) {
        var name = $('#user-search-input').val();
        var elem = flag == '0' ? 'page-container' : 'page-container2';
        layui.use('laypage', function () {
            var laypage = layui.laypage;
            //执行一个laypage实例
            laypage.render({
                elem: elem, //注意，这里的 test1 是 ID，不用加 # 号
                count: count,//数据总数，从服务端得到
                theme: '#45b97c',
                first: false,
                last: false,
                groups: 3,
                jump: function (object, first) {
                    divpage = object.curr;
                    divRowsCountSecond = count;

                    if (!first) {
                        window.location.href = '#';
                        userRefresh();
                    }

                }
            });
        });
    }


    function userRefresh() {
        getAll(url_all, 'allUserNum');
        getAll(url_online, 'onlineUserNum');
        var name = $('#user-search-input').val();
        var url = 'https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getAllUserListForPortal&queryName=' + name + '&page=' + divpage + '&_REQUEST_SOURCE=MOBILE';
        if (flag == "1") {
            url = 'https://140.237.73.123:8092/JointServiceBase/JointServiceBaseUserInfo.service?getUserListOnlineForPortal&queryName=' + name + ' &page=' + divpage + '&_REQUEST_SOURCE=MOBILE';
        }
        getUserInfo(url);
    }

    //=====================================视频处理===========================

  /*  if (!AgoraRTC.checkSystemRequirements()) {
    }*/
    var clientRTC, localStream, camera, microphone,channel;
    // 初始化Client对象
    function join(name, id,sendOrReceive) {
        clientRTC = AgoraRTC.createClient({mode: 'live', codec: 'h264'});
        $("#videoTitleUser").text(name);
        $("#videoUser").text(name);
        channel = id;
        clientRTC.init(
            '${rtcProperties.appid}', // 这里填注册完后的APPID
            function () {
                clientRTC.join( // 加入频道
                    null,
                    channel, // 频道名称，可以自己定义
                   null, // 用户标识id,可以自己定义。唯一就可以
                    function (uid) {
                        console.log('用户id：' + uid + ' 加入频道成功');
                        // 创建音视频流
                        localStream = AgoraRTC.createStream({
                            streamID: uid,
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
                                    getRtmSample();
                                });
                            },
                            function (err) {
                                console.log('获取用户媒体失败', err);
                                getRtmSample();
                            }
                        );
                        // --------- 订阅远端音视频流 --------欢迎使用 漳州环境资源中心系统 - Powered By 厦门智慧指间股份有限公司
                        // 监听到新的视频
                        clientRTC.on('stream-added', function (evt) {
                            var stream = evt.stream;
                            console.log('有新的音视频流: ' + stream.getId());
                            clientRTC.subscribe(stream, function (err) {
                                console.log('订阅音视频流失败', err);
                                leave('订阅音视频流失败');
                            });
                        });
                        // 订阅远程视频
                        clientRTC.on('stream-subscribed', function (evt) {
                            var remoteStream = evt.stream;
                            console.log('订阅远程音视频流成功: ' + remoteStream.getId());
                            // 显示远程视频播放<div>标签id名
                            remoteStream.play('videoSelfId');
                            Ams.success('连接成功');
                            $('#showCnet').text('实时视频中……');

                        });
                        clientRTC.on('peer-leave', function (evt) {
                            var stream = evt.stream;
                            if (stream) {
                                stream.stop();
                                stream.close();
                                leave('对方已挂断');
                                console.log(evt.uid + " leaved from this channel");
                            }
                        });
                    },

                    function (err) {
                        console.log('加入频道失败', err);
                        leave('加入频道失败');
                    }
                );
            },
            function (err) {
                console.log('AgoraRTC clientRTC 初始化失败', err);
                leave('AgoraRTC clientRTC 初始化失败');
            }
        );
        if(sendOrReceive=='send'){
                 sendMsg();
        }
        dialogOpen('#dd');
    }

    function leave(msg) {

        $("#dd").dialog('close');//关闭视频后会执行关闭事件
        if (Ams.isNoEmpty(msg)) {
            Ams.success(msg);
        } else {
            Ams.success('通话结束');
        }
    }

    // 关闭视频后关闭声音
    $("#dd").dialog({
        onClose: function () {
            closeAudio();
            $(".btn.dial-up").hide();
            // 取消发布本地音视频流
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
        }
    });

    //====================================rtm实时消息==========================================
    var clientRTM,receiveUserName,receiveChannelName;
    var audio = document.getElementById("audioPlay");
    //邀请或接受请求
    function getRtmSample() {
        clientRTM = AgoraRTM.createInstance('${rtcProperties.appid}');
        clientRTM.on('ConnectionStateChanged', function (newState, reason) {//获取连接状态,监听状态的事件;
            //=>写法相当于function (newState,reason){}
            console.log('on connection state changed to ' + newState + ' reason: ' + reason);
        });
        clientRTM.login({token: null, uid: '${rtcProperties.uid}'}).then(function () {
        }).catch(function (err) {
            console.log('RTM 登录失败', err);
            Ams.error('RTM登录失败，请刷新试试');
        });
        clientRTM.on('MessageFromPeer', function ({text}, peerId) {
            $(".btn.dial-up").show();
            playAudio();
            dialogOpen('#dd');

            var jsonText=  JSON.parse(text);
            receiveUserName = jsonText.fromUserName;
            receiveChannelName= jsonText.channelName;
        });
    }

    function sendMsg() {
        clientRTM.sendMessageToPeer(
            {text: "{'fromUserName': '指挥中心', 'channelName':" + channel + "}"}, // 符合 RtmMessage 接口的参数对象
            channel, // 远端用户 ID
        ).then(function (sendResult) {
            if (sendResult.hasPeerReceived) {
                /* 远端用户收到消息的处理逻辑 */
            } else {
                /* 服务器已接收、但远端用户不可达的处理逻辑 */
                leave('对方不在线');
            }
        }).catch(function (err) {
            /* 发送失败的处理逻辑 */
            console.log('发送失败的处理逻辑,请重试！');
        });
    }

    function dail_up(){
        $(".btn.dial-up").hide();
        closeAudio();
        join(receiveUserName, receiveChannelName, 'receive');
    }

    function playAudio() {
        var audioPlay=document.getElementById("audioPlay");
        audioPlay.play();
    }
    function closeAudio() {
        var audioPlay=document.getElementById("audioPlay");
        if (!audioPlay.paused)
            audioPlay.pause();
    }
</script>

</html>