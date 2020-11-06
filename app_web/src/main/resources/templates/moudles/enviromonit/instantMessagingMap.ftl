<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>漳州市生态云-即时互动</title>
	<#include "/header.ftl"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/custom.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/video.play.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloud.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/providers.css"/>
    <!-- ol -->
	<link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
	<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
	<!-- Custom -->
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
	<!-- ol end -->
   	<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
   	<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
	<!-- 地图相关 -->
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
	<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
	<script src="${request.contextPath}/static/js/epaConsole.js"></script>
    <!-- 对讲相关 -->
    <script type="text/javascript" src="${request.contextPath}/static/js/poc/loadxml.js"></script>
    <script type="text/javascript" src="${request.contextPath}/static/js/poc/cmcc.js"></script>
    <style>
		#pf-hd {
		    height: 70px;
		    position: relative;
		    z-index: 2;
		    background: url('images/main/top_bottombg.png?1464006836') left bottom repeat-x;
		        background-color: rgba(0, 0, 0, 0);
		    background-color: #268AEA;
		}
		#pf-hd .pf-logo {
		    float: left;
		    padding: 0 15px;
		    height: 100%;
		    min-width: 230px;
		    border-right: 1px solid #2078cb;
		    line-height: 70px;
		    color: #ffffff;
		    font-size: 24px;
		}
		#pf-hd .pf-logo img {
		    vertical-align: middle;
		    margin-left: -10px;
		}
		.ztree li a{color:#fff;}
	</style>
</head>

<body onload="onLoad()">
<#include "/common/loadingDiv.ftl"/>
<div id="pf-hd">
    <span class="pf-logo">
        <img src="/static/images/blocks1.png" align="absmiddle">  漳州生态云-即时互动
    </span>
</div>
<div id="accept-call-prompt-container" class="call-prompt-container">
    <div class="call-prompt-bg"></div>
    <div class="call-prompt-box">
        <div class="call-name"></div>
        <div class="call-info">正在呼叫……</div>
        <div class="call-btn-group">
            <div id="btn-accept-danger" class="btn-block btn-danger"><span class="icon iconcustom icon-guaduandianhua"></span></div>
            <div id="btn-accept-success" class="btn-block btn-success"><span class="icon iconcustom icon-dianhua"></span></div>
        </div>
    </div>
</div>
<div id="call-prompt-container" class="call-prompt-container">
    <div class="call-prompt-bg"></div>
    <div class="call-prompt-box">
        <div class="call-name"></div>
        <div class="call-info">正在呼叫……</div>
        <div class="call-btn-group">
            <div id="btn-danger" class="btn-block btn-danger"><span class="icon iconcustom icon-guaduandianhua"></span></div>
        </div>
    </div>
</div>
<div class="container" style="position: absolute;top:70px;bottom: 0px;left:0px;right: 0px;">
    <div class="tabs-container">
    <div class="tabs-head filter-marker-container style-tabs">
        <div class="other hide">
            <!-- 其他 -->
        </div>
        <div class="header-tab btn-group">
            <div id ="organization" class="btn grid-all tab-list active" data-target="#organization-tasks">
                <span class="icon fa-screenshot"></span><span>组织成员</span>
            </div>
            <div id="channel" class="btn task tab-list" data-target="#channel-task">
                <span class="icon iconcustom icon-renwuguanli1"></span><span>频道会话</span>
            </div>
            <div id ="video" class="btn report tab-list" data-target="#video-task">
                <span class="icon iconcustom icon-huanjing1"></span><span>实时视频</span>
            </div>
        </div>
    </div>
    <div class="tabs-content">
        <div class="box-body" id="organization-tasks">
            <div class="backstage-left-collapse-container">
                <div class="left-box" style="background: #fff;">
                    <div class="btn-collapse"><span class="icon fa-angle-right"></span></div>

                    <div class="zTree-list-container">
                        <div class="section-top ca">
                            <div class="fr btn-collapse"><span class="icon fa-double-angle-left"></span></div>
                        </div>
                        <ul id="organizationTree" class="easyui-tree"></ul>
                    </div>
                </div>
                <div class="content-box"  style="background: none;">
                    <div class="map-container"  style="background: none;">
                        <!--人员-->
                        <!--人员列表-->
                        <div class="map-user-container show">
                            <div class="map-user-box">
                                <div class="user-number">
                                    <div class="user-online">&nbsp;</div>
                                    <div class="user-offline"></div>
                                    <div class="close"  data-close=".map-user-container">&times;</div>
                                </div>
                                <div class="user-search">
                                    <div class="user-search-box">
                                        <input id="user-search-input" class="map-search-input"  placeholder="搜索人员..." value="" type="text"/>
                                        <button id="user-search-button" class="user-search-button" title="搜索" type="button"><span class="icon fa-search"></span></button>
                                    </div>
                                </div>

                                <!--列表-->
                                <div id="user-list" class="user-list-container" style="top:76px;">
                                </div>
                                <!--列表 over-->
                                <#--<div id="user-pagination" class="pagination-box ca">
                                    <div class="pagination m10"><span class="current prev"> < </span><span class="current">1</span>
                                        <a href="javascript:void(0)">2</a>
                                        <a href="javascript:void(0)">3</a>
                                        <a href="javascript:void(0)">5</a>
                                        <a href="javascript:void(0)" class="next"> > </a>
                                        <div class="page-input">
                                            <input maxlength="10" class="page-text" type="text"/>
                                            <input class="btn select-page-btn" value="跳转" type="button"/>
                                        </div>
                                    </div>
                                </div>-->
                            </div>

                        </div>
                        <!--人员列表 over-->
                        <!--人员 over-->

                    </div>
                </div>
            </div>
        </div>
        <div class="box-body" id="channel-task" style="display:none;">
            <div class="backstage-left-collapse-container">
                <div class="left-box">
                <div class="btn-collapse"><span class="icon fa-angle-right"></span></div>
                <!--人员列表-->
                <div class="map-user-box">
                    <div class="user-tabs">
                        <div class="btn-group">
                            <div class="btn tab-list active" data-target="#user-channel">
                                频道
                            </div>
                            <div class="btn tab-list" data-target="#user-group">
                                会话
                            </div>
                        </div>
                    </div>
                    <div class="user-search">
                        <div class="user-search-box">
                            <input id="user-search-input" class="map-search-input"  placeholder="搜索..." value="" type="text"/>
                            <button id="user-search-button" class="user-search-button" title="搜索" type="button"><span class="icon fa-search"></span></button>
                        </div>
                    </div>
                    <!--列表-->
                    <div class="user-list-container" style="top: 90px;bottom: 0;">
                        <div class="box-body" id="user-channel">
                        </div>
                        <div class="box-body" id="user-group" style="display: none;">
                        </div>


                    </div>
                    <!--列表 over-->
                </div>
                <!--人员列表 over-->
            </div>
                <div class="content-box" style="background: none;">
                <div class="map-container" style="background: none;">
                    <div class="map-wrapper" style="background: none;"></div><!--地图层-->
                    <!--人员-->
                    <div class="map-list-container">
                        <div class="btn-collapse" data-toggle="shown" data-target=".map-list-container">
                            <span class="icon fa-angle-right"></span>
                        </div>
                        <div class="map-list-wrapper">
                            <div class="map-user-box">
                                <div class="user-number">
                                    <div class="user-name"></div>
                                    <div class="user-btn-group">
                                        <div class="btn-mini">
                                            <span class="icon iconcustom icon-tianjia1"></span>
                                            添加
                                        </div>
                                        <div class="btn-mini btn-success">
                                            <span class="icon iconcustom icon-fanhui4"></span>
                                            下载
                                        </div>
                                    </div>
                                    <div class="close icon iconcustom icon-shezhia1"></div>
                                </div>
                                <div class="user-content" style="position: absolute;top: 71px;bottom: 160px;left: 0;right: 0;">
                                    <div>
                                    </div>
                                </div>
                                <div class="user-bottom">
                                    <div class="user-tool">
                                        <div class="tool-top tr">
                                            <span class="">键盘</span>
                                            <div class="btn-group">
                                                <label class="form-switch">
                                                    <input id="checkkeyboard" name="switch" value="" type="checkbox" checked="checked"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </div>
                                            <span class="">语音</span>
                                        </div>
                                        <div class="tool-content" id="voice">
                                            <div id="prompt" class="tool-info"></div>
                                            <div class="tc">
                                                <div  class="btn-voice"></div>
                                            </div>
                                        </div>
                                        <div class="tool-content tc hide" id="keyboard">
                                            <input id="" name="" class="easyui-textbox" multiline="true" style="width:280px;height:80px">
                                            <div class="user-btn-group">
                                                <div class="btn-mini" style="width: 76%;">
                                                    <span class="icon iconcustom icon-shangchuan2"></span>
                                                    发送
                                                </div>
                                                <div class="btn-mini btn-success">
                                                    <span class="icon iconcustom icon-tupian1"></span>
                                                    图片
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--人员 over-->
                </div>
            </div>
            </div>
        </div>
        <div class="map-wrapper">
            <div id="allMap" class="map-wrapper" style="height:100%"></div><!--地图层-->
            <!--左侧工具栏-->
            <div class="map-tool-container">
                <ul>
                    <li>
                        <div id="btn_ranging"  class="btn-map-tool"  data-dropdown=".btn_ranging" data-parent=".map-toolbar-container"><span class="icon iconcustom  icon-ceju"></span>测距</div>
                    </li>
                </ul>
                <div class="map-toolbar-container">
                    <!--地图切换-->
                    <ul class="btn-group" id="switcherLayer">
                        <li class="btn task" layer_group="GLOBAL_IMG_MAP">
                            <span class="icon fa-globe"></span><span>卫星图层</span>
                        </li>
                        <li class="btn report active" layer_group="GLOBAL_VEC_MAP">
                            <span class="icon fa-road"></span><span>矢量图层</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="box-body" id="video-task" style="display:none;">
            <div id="altContent" style="display:none;">
                <p><a href="http://www.adobe.com/go/getflashplayer">Get Adobe Flash player</a></p>
            </div>
            <INPUT size="50" style="display:none;" id="MRL1" value="rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov"
                   onkeypress="if (event.keyCode == 13) document.getElementById('play_button').click()"/>
            <button id="play_button1" style="display: none" onclick="getByID('plugin_inst_1').play(getByID('MRL1').value)">play</button>
            <div class="video-play-container">
                <div class="video-play-box">
                    <object style="width:100%;height:100%;" id="plugin_inst_1" type="application/x-chimera-plugin">
                        <param name="autoplay" value="true" />
                        <param name="mrl" value="" />
                    </object>
                </div><!-- 视频层 -->
                <div class="video-play-bottom">
                    <div class="video-play-info">
                        <div class="fl"></div>
                        <div class="fr play-opt">
                            <a href=""><span class="icon iconcustom icon-quanping2"></span></a>
                            <a href=""><span class="icon iconcustom icon-shuaxin1"></span></a>
                        </div>
                        <div class="tc play-info">
                            <span class="icon iconcustom icon-shipin2"></span>
                            <span></span>
                            <span></span>
                            <span>实时视频中……</span>
                        </div>
                    </div>
                    <div class="video-play-tool">
                        <div class="fl" style="margin: 32px 14px;">
                            <div class="btn-border">
                                <span>网格员</span><span></span>
                            </div>
                        </div>
                        <div class="fr play-opt" style="margin: 24px 14px;">
                            <a href=""><span class="icon iconcustom icon-kaisuo"></span></a>
                            <a href=""><span class="icon iconcustom icon-diannaojieping"></span></a>
                            <a href=""><span class="icon iconcustom icon-shoujijieping"></span></a>
                            <a href=""><span class="icon iconcustom icon-shujudaochu1"></span></a>
                        </div>
                        <div class="tc play-content">
                            <span></span>
                            <span id="closeVideo" class="video-hangup icon iconcustom icon-guaduandianhua"></span>
                            <span id="talk" class="video-talkback icon-loudspeaker"></span>
                            <span class="video-state">空闲中</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</div>
<!-- main over -->
 <script>
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };
        $('.tab-list').click(function () {
            $(this).siblings('.tab-list').removeClass('active');
            $(this).addClass('active');
            var target=$(this).attr("data-target");
            $(target).show();
            $(target).siblings(".box-body").hide();
        });
        //显示隐藏 data-toggle="shown"
        $('body').on('click','[data-toggle="shown"]',function(){
            var target=$(this).attr("data-target");
            var $target=$(target);
            if($target.hasClass("show")){
                $target.removeClass("show");
                $(this).removeClass("active");
            }else {
                $target.addClass("show");
                $(this).addClass("active");
            }
        });

        /* 对讲通话相关开始 */
        $("#accept-call-prompt-container").hide();
        $("#call-prompt-container").hide();
        $(".map-user-container").removeClass("show");
        $(".map-list-container").removeClass("show");
        var plaintextPassword = "${plaintextPassword}";//密码
        var dispatchAccount = "${dispatchAccount}";//账号
        var callAccount = "${callAccount}";//拨打账号
        var callSessionId;//存储sessionId
        var isVideoPlay = false;//判断视频是否关闭
        var isTalk = false;
        var channelList;
        var conversationList;
        var conversationUidList;
        $(function(){
            identifyAccount();
            setTimeout(
                function(){
                    pocConnect();
                },500
            )
            setTimeout(
                function(){
                    pocLogin(dispatchAccount,plaintextPassword);
                },1000
            )
        });
        function getCallAccount(){
            if(callAccount!=""){
                callSessionId = pocCallOne(callAccount);
                tabChannel();
                pocCallConnectingTab(callAccount);
            }
        }

        function identifyAccount(){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/identifyAccount',
                success: function (data) {
                    setTimeout(
                        function(){
                            getSession(data)
                        },500
                    )
                }
            });
        }
        function getSession(ServiceCode){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getSession',
                data: {"ServiceCode":ServiceCode},
                success: function (data) {
                    setTimeout(
                        function(){
                            getOrganizationListTree(data);
                            getChannelList();
                            getConversationList();
                            getCallAccount();
                        },500
                    )
                }
            });
        }
        function getChannelList(){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getChannelList',
                success: function (data) {
                    channelList = JSON.parse(data).Channels;
                    showChannelList(channelList);
                }
            });
        }
        function getConversationList(){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getConversationList',
                success: function (data) {
                    conversationList = JSON.parse(data).Conversations;
                    showConversationList(conversationList);
                }
            });
        }
        function getConversationUserList(conversationId){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getConversationUserList',
                data: {"conversationId":conversationId},
                success: function (data) {
                    conversationUidList = getAcceptCallId(dispatchAccount,JSON.parse(data).Members);
                }
            });
        }
        function getOrganizationListTree(SessionId){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getOrganizationListTree',
                data: {"SessionId":SessionId},
                success: function (data) {
                    $('#organizationTree').tree({
                        data: JSON.parse(data),
                        valueField:'id',textField:'text',animate:true,
                        onClick: function(node){
                            getOrganizationUserListByOrgId(node.id);
                        }

                    });
                }
            });
        }
        function getOrganizationUserListByOrgId(orgId){
            $.ajax({
                type: 'POST',
                url:  '${request.contextPath}/epa/instantMessagingMap/getOrganizationUserListByOrgId',
                data: {"OrgId":orgId},
                success: function (data) {
                    if(!$(".map-user-container").hasClass("show")){
                        $(".map-user-container").addClass("show");
                    }
                    showUserList(JSON.parse(data).Users);
                }
            });
        }
        function showUserList(users){
            var htmlStr = "";
            for(var i=0;i<users.length;i++) {
                var record = users[i];
                htmlStr += '<div class="personnel-info busyness-user">\n' +
                    '                                <div class="personnel-header">\n' +
                    '                                    <img class="header-img" src="${request.contextPath}/static/images/personal-head.jpg"/>\n' +
                    '                                </div>\n' +
                    '                                <div class="personnel-content">\n' +
                    '                                    <div class="info">\n' +
                    '                                        <div class="name fl">'+record.Name+'</div>\n' +
                    '                                        <div class="fr">\n' +
                    '                                            <div onclick="pocCall(this)" data-id="'+record.Uid+'" data-name="'+record.Name+'" class="function"><span class="icon fa-screenshot"></span></div>\n' +
                    '                                            <div id="" class="function"><span class="icon fa-folder-open"></span></div>\n' +
                    '                                            <div id="" class="function"><span class="icon fa-location-arrow"></span></div>\n' +
                    '                                        </div>\n' +
                    '                                   </div>\n' +
                    '                                   <div class="address">\n' +
                    '                                       <span class="icon iconcustom icon-dianhua"></span><span>'+record.Name+'</span>\n' +
                    '                                   </div>' +
                    '                                </div>\n' +
                    '                            </div>';
            }
            $("#user-list").html(htmlStr);
        }
        function showChannelList(channels){
            var htmlStr = "";
            htmlStr += '<ul class="personnel-list">';
            for(var i=0;i<channels.length;i++) {
                var record = channels[i];
                /*htmlStr += '<div class="personnel-info busyness-user" data-id="'+record.Id+'" data-name="'+record.Name +'" onclick="pocChannelMessageTab(this)">\n' +
                                '<div class="personnel-content">\n' +
                                    '<div class="info">\n'+
                                        '<div class="name fl">'+record.Name+'</div>\n' +
                                        '<div class="fr">\n' +
                                            '<div class="function"><span class="icon fa-angle-right"></span></div>\n' +
                                        '</div>\n' +
                                    '</div>\n' +
                                 '</div>\n' +
                            '</div>';*/
                htmlStr += '<li class="personnel-list-li">' +
                                '<div class="personnel-list-package collapsed" data-target=".personnel-list-1-2" ' +
                                    'data-id="'+record.Id+'" data-name="'+record.Name +'" onclick="pocChannelMessageTab(this)">\n' +
                                    '<div class="personnel-switch"><span class="icon fa-caret-down"></span></div>\n' +
                                    '<div class="personnel-text">'+record.Name+'</div>\n' +
                                '</div>' +
                            '</li>';

            }
            htmlStr += '</li>';
            $("#user-channel").html(htmlStr);
        }
        function showConversationList(conversations){
            var htmlStr = "";
            for(var i=0;i<conversations.length;i++) {
                var record = conversations[i];
                htmlStr += '<div class="personnel-info busyness-user" data-id="'+record.Id+'" data-name="'+record.Name +'" onclick="pocConversationMessageTab(this)">\n' +
                                '<div class="personnel-content">\n' +
                                    '<div class="info">\n'+
                                        '<div class="name fl">'+record.Name+'</div>\n' +
                                        '<div class="fr">\n' +
                                            '<div class="function"><span class="icon fa-angle-right"></span></div>\n' +
                                        '</div>\n' +
                                    '</div>\n' +
                                '</div>\n' +
                            '</div>';
            }
            $("#user-group").html(htmlStr);
        }

        //btn-voice点击事件
        $('.btn-voice').click(function () {
            pocCallConnectBtn(connectStatus);
        });
        //关闭视频
        $('#closeVideo').click(function () {
            getByID("plugin_inst_1").stop();
            isVideoPlay = false;
            tabChannel();
            promptDialog('实时视频已经关闭！');
        });
        //呼叫对讲,释放和关闭
        $('#talk').click(function () {
            if(!isTalk){
                pocRequestTalk();
                isTalk = true;
            }else{
                pocReleaseTalk();
                isTalk = false;
            }
        });
        /* 对讲通话相关结束 */

        /* 地图相关开始 */
        var map = null ;
        function initMapForEpa(){
            var longitude = "117.65";
            var latitude = "24.52";
            /* var longitude = "117.0184615516";
         var latitude = "25.0779528413";	 */
            map =initMap({
                target: "allMap",
                center: [parseFloat(longitude),parseFloat(latitude)],
                layers: [fjzx.map.source.getGlobalVecLayerGroup()]
            });
            map.render();
        }
        initMapForEpa();
        //测距代码
        var myDis = new fjzx.map.MeasureTool(
            {map: map,measureType: "line"},
            function(){	//开始绘画回调
            },
            function(){	//结束绘画回调
                if($("div#btn_ranging").hasClass("active")){
                    $("div#btn_ranging").removeClass("active");
                }
            });
        $("[data-dropdown]").click(function() {

            var $t = $(this);
            if($t.attr("data-dropdown") == '.btn_ranging'){
                myDis.open();
            }
            if($t.attr("data-dropdown") != '.btn_mark_point'){
                if(myMakeMark != null){
                    map.removeOverlay(myMakeMark);
                    myMakeMark = null;
                }
            }

            var target = $($t.attr("data-dropdown"));
            if ($t.hasClass("active")) {
                $t.removeClass("active");
                target.removeClass("show");
            } else {
                $("[data-dropdown]").removeClass("active");
                $(".map-tool-box").removeClass("show");
                $t.addClass("active");
                target.addClass("show");
            }
            if (!$(".map-tool-box").is(".show")) {
                $(".map-toolbar-container").css("bottom", "auto");
            }
        });
        $("[data-close]").on('click',function(){
            var $t=$(this);
            var $target=$($t.attr("data-close"));
            if($target.hasClass("show")){
                $target.removeClass("show");
            }else{
                $target.addClass("show");
            }
        });
        /* 地图相关结束 */
 </script>
</body>
</html>