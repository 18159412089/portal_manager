/*!
 * fjzx-camera.js
 *
 * ZhangGQ
 * 2019-09-29 18:00:00
 */

//包的预定义函数
function MACRO_PACKAGE_DEFINE(packageName) {
	var names = packageName.split(".");
	var currentPackage = null;
	for (var i = 0; i < names.length; i++) {
		var name = names[i];
		if (i === 0) {
			if (!this[name])
				this[name] = {};
			currentPackage = this[name];
		} else {
			if (!currentPackage[name])
				currentPackage[name] = {};
			currentPackage = currentPackage[name];
		}
	}
};

MACRO_PACKAGE_DEFINE("fjzx.camera");

fjzx.camera.Camera = function(options){
    var that = this;
    this.opts = options || {};

    this._isInit = false;
    this.elementId = this.opts.elementId;
    this._$cameraContainer = $('#'+this.opts.elementId);
    this._playerCount = this.opts.playerCount==null || typeof(this.opts.playerCount)=='undefined' ? 1 : new Number(this.opts.playerCount);
    this._playerMap = new fjzx.camera.Utils.HashMap();
    this.cameraTree = null;
    this.currentPlayer = null;
    this.currentPlayingPlayerMap = new fjzx.camera.Utils.HashMap();

    if(!$('#'+this.elementId).length || $('#'+this.elementId).length>1){
        var msg = '请检查页面上id为'+this.elementId+'的视频预览窗口容器有且只有1个';
        layer.msg(msg);
        return;
    }
    this._$playerListContainer =  $("<div class='view_container'>\
        <div class='container_rt'>\
            <div class='view_box'>\
            </div>\
        </div>\
    </div>");

    window.addEventListener("beforeunload", function(event) {
        console.log('销毁视频播放器对象');

        $.each(that._playerMap.keySet(),function(index, value){
            var playerId = value;
            var player = that._playerMap.get(playerId);

            /*var cxt=document.getElementById(playerId).getContext("2d");
            cxt.clearRect(0,0,cxt.width,cxt.height);*/
            if(player instanceof SLPlayer){
                player.stop();
            }
        });
    });
}

fjzx.camera.Camera.prototype = {
    isInit: function(){
        return this._isInit;
    },
    getElementId: function(){
        return this.elementId;
    },
    initPlayers: function(){
        var that = this;
        that._isInit = true;
        this._playerMap.removeAll();

        for(var i=0; i<Math.pow(this._playerCount,2); i++){
            this.createCameraPlayer();
        }
        that._$cameraContainer.append(this._$playerListContainer);
        //初始化视屏播放器
        $.each(this._playerMap.keySet(),function(index, value){
            var playerId = value;
            new fjzx.camera.Player(playerId).initPlayer(function(player){
                that._playerMap.put(playerId,player);
            },function(){
                that._isInit = false;
            });
        });
    },
    /**
     * 视频监控云台控制器
     */
    initPTZControl: function(elementId){
        var that = this;
        var $cameraPTZActionTemplate = $('<div class="camera-control-container">\
             <div class="control-direction-box">\
                 <div class="control-direction">\
                     <div class="camera-control-btn camera-ptz-action control-half control-left-top" action="10" title="左上">\
                         <span class="icon iconcustom icon-fanhui-dan4"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-top" action="6" title="上">\
                         <span class="icon iconcustom icon-fanhui-dan3"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-half control-right-top" action="11" title="右上">\
                         <span class="icon iconcustom icon-fanhui-dan3"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-left" action="8" title="左">\
                         <span class="icon iconcustom icon-fanhui-dan4"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action btn-camera-play" action="" title="" style="pointer-events: none;">\
                         <span class="icon iconcustom icon-bofang3" style="display: none;"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-right" action="9" title="右">\
                         <span class="icon iconcustom icon-fanhui-dan2"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-half control-left-bottom" action="12" title="左下">\
                         <span class="icon iconcustom icon-fanhui-dan1"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-bottom" action="7" title="下">\
                         <span class="icon iconcustom icon-fanhui-dan1"></span>\
                     </div>\
                     <div class="camera-control-btn camera-ptz-action control-half control-right-bottom" action="13" title="右下">\
                         <span class="icon iconcustom icon-fanhui-dan2"></span>\
                     </div>\
                 </div>\
             </div>\
             <div class="control-spinner-group">\
                 <div class="btn-control control-spinner">\
                     <div class="spinner-arrow button-before camera-ptz-action" action="0">\
                         <span class="icon iconcustom icon-tianji11"></span>\
                     </div>\
                     <div class="spinner-arrow button-after camera-ptz-action" action="1">\
                         <span class="icon iconcustom icon-jian1"></span>\
                     </div>\
                     <div class="spinner-block">变倍调节</div>\
                 </div>\
                 <div class="btn-control control-spinner">\
                     <div class="spinner-arrow button-before camera-ptz-action" action="2">\
                         <span class="icon iconcustom icon-tianji11"></span>\
                     </div>\
                     <div class="spinner-arrow button-after camera-ptz-action" action="3">\
                         <span class="icon iconcustom icon-jian1"></span>\
                     </div>\
                     <div class="spinner-block">光圈调节</div>\
                 </div>\
                 <div class="btn-control control-spinner">\
                     <div class="spinner-arrow button-before camera-ptz-action" action="4">\
                         <span class="icon iconcustom icon-tianji11"></span>\
                     </div>\
                     <div class="spinner-arrow button-after camera-ptz-action" action="5">\
                         <span class="icon iconcustom icon-jian1"></span>\
                     </div>\
                     <div class="spinner-block">焦距调节</div>\
                 </div>\
             </div>\
             <div class="control-operate-group mt20">\
                 <div class="item">\
                     <div class="camera-ptz-action" action="16">\
                         <div class="icon btn-control iconcustom icon-fanhui9"></div>\
                         <div class="title">回到原点</div>\
                     </div>\
                 </div>\
                 <div class="item">\
                     <div class="camera-ptz-action" action="17">\
                         <div class="icon btn-control iconcustom icon-shezhia1"></div>\
                         <div class="title">设置预置点</div>\
                     </div>\
                 </div>\
                 <div class="item">\
                     <div class="camera-ptz-action" action="18">\
                         <div class="icon btn-control iconcustom icon-lianjiexian"></div>\
                         <div class="title">调用预置点</div>\
                     </div>\
                 </div>\
                 <div class="item">\
                     <div class="camera-ptz-action" action="19">\
                         <div class="icon btn-control iconcustom icon-shanchu1"></div>\
                         <div class="title">删除预置点</div>\
                     </div>\
                 </div>\
                 <div class="item">\
                     <div class="cameraAlarm" >\
                         <a class="title" href="/zphb/cameraMap/zpCamera" target="_blank">\
                             <div class="icon btn-control iconcustom icon-fengxian1"></div>\
                             <div class="title">监控报警</div>\
                         </a>\
                     </div>\
                 </div>\
             </div>\
        </div>');
        $cameraPTZActionTemplate.find('.camera-ptz-action').click(function(){
            var player = that.getSelectPlayer();
            if(player==null){
                return;
            }
            if(!player._isPlaying){
                layer.msg('您选择的窗口暂无视频预览！');
                return;
            }
            var action = $(this).attr('action');
            var chanid = player.getChannelId(),
                speed = 10,
                prepoint = 1;
            cameraConfig.ctrlPTZ(chanid, action, speed, prepoint, function(res){
                //回到原点、设置预置点、调用预置点等无需马上停止
                if(action==16 || action==17 || action==18){
                    return;
                }
                action = 14;
                cameraConfig.ctrlPTZ(chanid,action,speed, prepoint);
            });
        });

        if($('#'+elementId).length!=1){
            layer.msg('一个页面有且只有一个云台控制容器');
            return;
        }
        $('#'+elementId).append($cameraPTZActionTemplate);
    },
    /**
     * 视频监控预览控制器
     */
    initWinControl: function(){
        var that = this;
        //播放器下方控制
        var viewOperateTemplate = "<div class='view_oprate'>\
            <div class='fl'><span title='全部关闭' class='view_close closse-all' style='display:none;'></span></div>\
            <div class='fr'>\
                <div class='el-dropdown view-dropdown' style='display:inline-block;'>\
                    <span title='视图' class='view el-dropdown-link el-dropdown-selfdefine ' aria-haspopup='list' aria-controls='dropdown-menu-9838' role='button' tabindex='0'></span>\
                    <ul class='el-dropdown-menu el-popper preview' x-placement='top'>\
                        <li class='el-dropdown-menu__item' player-count='1'><span class='oto'>1X1</span></li>\
                        <li class='el-dropdown-menu__item' player-count='2'><span class='twt'>2X2</span></li>\
                        <li class='el-dropdown-menu__item' player-count='3'><span class='trt'>3X3</span></li>\
                        <div class='popper__arrow'></div>\
                    </ul>\
                </div>\
                <span title='全屏' class='full global-full' is-full='false'></span>\
            </div>\
            <div></div>\
        </div>";
        this._$playerListContainer.find('.container_rt').append(viewOperateTemplate);

        //关闭所有预览
        this._$playerListContainer.find('span.view_close').click(function(){
            $.each(that._playerMap.keySet(),function (index, value) {
                var playerId = value;
                that.stopView(playerId);
            })
        });

        //视图选择样式
        this._$playerListContainer.find('.preview').hide();
        this._$playerListContainer.find('.view-dropdown .view').click(function () {
            if($(this).hasClass('active')){
                $(this).removeClass('active');
                that._$playerListContainer.find('.preview').hide();
            }else{
                $(this).addClass('active');
                that._$playerListContainer.find('.preview').show();
            }
        });
        this._$playerListContainer.find('.view-dropdown').blur(function () {
            $(this).removeClass('active');
            that._$playerListContainer.find('.preview').hide();
        });

        //选择视频预览窗口数量
        this._$playerListContainer.find('.el-dropdown-menu .el-dropdown-menu__item').click(function(){
            var playerCount = $(this).attr('player-count');
            if(!isNaN(playerCount)){
                that._$playerListContainer.find('.view-dropdown').removeClass('active');
                that._$playerListContainer.find('.preview').hide();

                that.setPlayerCount(playerCount);
            }
        });

        //播放器全屏
        this._$playerListContainer.find('span.global-full').click(function(){
            var element = $(this).parents('.container_rt').get(0);

            var isFull = fjzx.camera.Utils.isFullScreen();
            if(isFull){
                $(this).removeClass('exit_full').attr('title','全屏');
                fjzx.camera.Utils.exitFullScreen(element)
            }else{
                $(this).addClass('exit_full').attr('title','退出全屏');
                fjzx.camera.Utils.fullScreen(element);
            }
        });
        //单个预览窗口全屏
        this._$playerListContainer.find('span.view-item-full').click(function () {
            var element = $(this).parents('.view_item').get(0);

            var isFull = fjzx.camera.Utils.isFullScreen();
            if(isFull){
                $(this).removeClass('exit_full').attr('title','全屏');
                fjzx.camera.Utils.exitFullScreen(element)
            }else{
                $(this).addClass('exit_full').attr('title','退出全屏');
                fjzx.camera.Utils.fullScreen(element);
            }
        });
    },
    createCameraPlayer: function(){
        var that = this;
        var playerId = fjzx.camera.Utils.getUUID();
        var viewItemTemplate = "<div class='view_item' style='width:50%;height:50%;border-right: 2px solid rgb(204, 204, 204);border-bottom: 2px solid rgb(204, 204, 204);'>\
            <div class='view_item_box' player-id='"+playerId+"' player-index='"+this._playerMap.length()+"' player-status='nonuse' player-channel-id=''>\
                <div class='video' element-loading-background='rgb(0,0,0,0)'>\
                    <canvas id='"+playerId+"' style='background: black;width: 100%;height: 100%;' width='704' height='576'></canvas>\
                </div>\
                <div class='close1 icon iconcustom icon-shanchu3' style='display:none;'></div>\
                <div class='view_speed' style='display:none;'>65.78kb/s</div>\
                <div class='view_item_oprate'>\
                    <div class='oprate_box'>\
                        <div class='fl'>\
                            <span title='截图' class='screenshot' style='display:none;'></span>\
                            <span>\
                                <div role='tooltip' id='el-popover-2858' aria-hidden='true' class='el-popover el-popper' style='width: 60px; display: none;' tabindex='0'>\
                                    <div class='seclect_scroll labelst el-scrollbar'>\
                                        <div class='el-scrollbar__wrap' style='margin-bottom: -17px; margin-right: -17px;'>\
                                            <div class='el-scrollbar__view'>\
                                                <p style='text-align: center;'>暂无数据</p>\
                                                <div role='group' aria-label='checkbox-group' class='el-checkbox-group'></div>\
                                            </div>\
                                        </div>\
                                        <div class='el-scrollbar__bar is-horizontal'><div class='el-scrollbar__thumb' style='transform: translateX(0%);'></div></div>\
                                        <div class='el-scrollbar__bar is-vertical'><div class='el-scrollbar__thumb' style='transform: translateY(0%);'></div></div>\
                                    </div>\
                                    <div class='label_set'>\
                                        <button disabled='disabled' type='button' class='el-button el-button--primary is-disabled'><span>确 定</span></button>\
                                        <button type='button' class='el-button el-button--default'><span>取 消</span></button>\
                                    </div>\
                                </div>\
                                <span title='标签' class='label el-popover__reference' aria-describedby='el-popover-2858' tabindex='0' style='display:none;'></span>\
                            </span>\
                        </div>\
                        <span class='full fr view-item-full' title='全屏'></span>\
                    </div>\
                    <span class='oprate_name fr'>通道</span>\
                </div> \
            </div>\
        </div>";
        var $viewItemTemplate = $(viewItemTemplate);
        that._$playerListContainer.find('.view_box').append($viewItemTemplate);
        that._$playerListContainer.find('div.view_item > div[player-id='+playerId+']').click(function() {
            that._$playerListContainer.find('div.view_item_box').removeClass('cur');

            $(this).addClass('cur');
            that.currentPlayer = that._playerMap.get(playerId);
        });
        that._$playerListContainer.find('div.view_item > div[player-id='+playerId+']').find('div.close').click(function(){
            var playerId = $(this).parent().attr('player-id');
            that.stopView(playerId);
        });
        that._$playerListContainer.find('div.view_item > div[player-id='+playerId+']').find('span.screenshot').click(function(){
            console.log('截图');
            var playerId = $(this).parents('.view_item_box').attr('player-id');
            var canvas = document.getElementById(playerId);
            var imageURL = canvas.toDataURL("image/jpeg");
            console.log('imageURL：'+imageURL);

            setTimeout(function(){
                var a = document.createElement('a');
                a.download = '';
                a.href = imageURL;
                document.body.appendChild(a);
                a.click();
                a.remove();
            },1000);
        });

        that.resize();
        that._playerMap.put(playerId,{});

        return {
            playerId: playerId,
            viewItem: $viewItemTemplate
        };
    },
    //根据当前窗口数设置各个窗口宽高
    resize: function(){
        var width = 100/this._playerCount;
        this._$playerListContainer.find('.view_box > .view_item').css('width','calc('+width+'% - 0.1px)').css('height','calc('+width+'% - 0.1px)');
    },
    getSelectPlayer: function(){
        if(!this._$cameraContainer.find('.cur').length){
            layer.msg('请选择预览窗口');
            return;
        }
        var playerId = this._$cameraContainer.find('.cur').attr('player-id');
        return this._playerMap.get(playerId);
    },
    setPlayerCount: function(playerCount){
        var that = this;
        var currentPlayerCount = this._playerCount;
        this._playerCount = playerCount;

        if(currentPlayerCount == playerCount){
            return;
        }else if(currentPlayerCount < playerCount){
            var addPlayerCount = Math.pow(playerCount,2) - Math.pow(currentPlayerCount,2);
            for(var i=0;i<addPlayerCount;i++){
                that.createCameraPlayer();
            }
        }else{
            var playerId = this._playerMap.keySet();
            if(playerId.length - playerCount){
                var subPlayerIds = playerId.slice(playerCount);
                $.each(subPlayerIds, function (index, value){
                    var key = value;
                    var player = that._playerMap.get(key);
                    var $viewItem = that._$playerListContainer.find('div[player-id='+key+']').parent();
                    $viewItem.remove();
                    that.resize();
                    if(player instanceof fjzx.camera.Player){
                        player.stop();
                    }
                });
            }
        }
    },
    startView: function(options){
        var that = this;

        var opts = options || {};
        var chanid = opts.chanid;
        var name = opts.name;
        console.log('name:'+name+',chanid:'+chanid);
        cameraConfig.startView(chanid,function (res) {
            if (res.ret == 0) {
                var liveUrl = res.view_context;
                var playerId = '';
                //未选择播放窗口时默认使用第一个空闲窗口
                if(that.currentPlayer==null){
                    var $nonusePlayerList = that._$cameraContainer.find('div[player-status=nonuse]');
                    //当没有空闲播放窗口时，在最后一个窗口预览
                    if($nonusePlayerList.length>0){
                        playerId = $nonusePlayerList.eq(0).attr('player-id');
                        $nonusePlayerList.eq(0).attr('player-status','inuse')
                    }else{
                        var playerIndex = that._playerCount*that._playerCount-1;
                        playerId = that._$cameraContainer.find('div[player-index='+playerIndex+']').attr('player-id');
                    }
                    if(that._playerMap.length()<=0){
                        that.initPlayers();
                    }
                    that.currentPlayer = that._playerMap.get(playerId)
                }else{
                    playerId = that.currentPlayer.playerId;
                }
                that._$cameraContainer.find('div.view_item_box').removeClass('cur');
                that._$cameraContainer.find('div[player-id='+playerId+']').addClass('cur');
                that._$cameraContainer.find('div[player-id='+playerId+']').attr('player-channel-id', chanid);
                that._$cameraContainer.find('div[player-id='+playerId+']').find('span.oprate_name').text(name);
                that._$cameraContainer.find('div[player-id='+playerId+']').find('div.close').removeAttr('style');

                console.log('liveUrl:'+liveUrl+',chanid:'+chanid);
                if(that.currentPlayer.player==null){
                    layer.msg('预览窗口初始化失败，请重新刷新页面！');
                    return;
                }
                that.currentPlayer.start(liveUrl);
                that.currentPlayer.setChannelId(chanid);

                that.currentPlayingPlayerMap.put(playerId, that.currentPlayer);
                that.currentPlayer = null;
            } else{
                console.log(res.msg)
                layer.msg('预览失败，请确定网络是否正常！');
            }
        });
    },
    stopView: function(playerId){
        var player = this._playerMap.get(playerId);
        player.stop();

        $('#'+playerId).parents('.view_item_box').attr('player-channel-id', '');
        $('#'+playerId).parents('.view_item_box').find('span.oprate_name').text('通道');
    }
}

fjzx.camera.Player = function(playerId){
    var that = this;

    this._isPlaying = false;
    this.player = null;
    this._startCallback = null;
    this._endCallback = null;
    this._errorCallback = null;
    this._videoStartCallback = null;
    this._playTimeCallback = null;
    this._ctrlPTZCallback = null;
    this.playerId = playerId;
    this._channelId = null;
    this.module = {
        // 定义视频画布
        canvas: document.getElementById(playerId),
        // 连接服务器成功后的回调
        onStart: function (res) {
            console.log("onStart...")
            if(typeof(that._startCallback)=='function') that._startCallback(res);
        },
        //播放器结束回调
        onEnd: function (res) {
            console.log("onEnd...")
            if(typeof(that._endCallback)=='function') that._endCallback(res);
        },
        //播放器错误回调，收到此回调后代表着播放结束，不再发送onEnd回调
        onError: function (code, err) {
            console.log('error: ', code, err);
            if(typeof(that._errorCallback)=='function') that._errorCallback(res);
        },
        onVideoStart: function (res) {
            console.log('onVideoStart。。。');
            if(typeof(that._videoStartCallback)=='function') that._videoStartCallback(res);
        },
        // 回放时播放时间戳通知
        onPlayTime: function (ts) {
            if(ts==0) return;
            var date = new Date(ts * 1000);//如果date为10位不需要乘1000
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
            var D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()) + ' ';
            var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
            var m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
            var s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
            var timestamp = Y + M + D + h + m + s;
            //console.log(timestamp)
            //console.log(that.opt);
            if(typeof(that._playTimeCallback)=='function') that._playTimeCallback(ts);
        },
        isPlaying: function(){
            return this._isPlaying;
        }
    };
}

fjzx.camera.Player.prototype  = {
     initPlayer: function(successCallback,errorCallback){
        var that = this;
        // 创建播放器对像
        // 此方法只适用于支持H5的游览器，不支持IE系统
        SLPlayer(this.module).then(function (player) {
            that.player = player;
            console.log("实例成功")
            if(typeof(successCallback)=='function'){
                successCallback(that);
            }
        });
    },
    getPlayerId: function(){
        return this.playerId;
    },
    setPlyaerId: function(playerId){
        this.playerId = playerId;
    },
    getChannelId: function(){
        return this._channelId;
    },
    setChannelId: function(channelId){
        this._channelId = channelId;
    },
    setOnStartCallback: function(callback){
        this._startCallback = callback;
    },
    setOnEndCallback: function(callback){
        this._endCallback = callback;
    },
    setOnErrorCallback: function(callback){
        this._errorCallback = callback;
    },
    setVideoStartCallback: function(callback){
        this._videoStartCallback = callback;
    },
    setOnPlayTimeCallback: function(callback){
        this._playTimeCallback = callback;
    },
    start: function(liveUrl,callback){
        if(this.playing){
            this.stop();
        }
        if(this.player instanceof SLPlayer){
            this.player.start(liveUrl);
            this._isPlaying = true;
        }else{
            layer.msg('视频播放器错误，预览失败');
        }

        if(typeof(callback)=='function') this._videoStartCallback = callback;
    },
    stop: function(callback){
        if(this.player instanceof SLPlayer){
            this.player.stop();
        }else{
            layer.msg('视频播放器错误，停止预览失败');
        }
        this._isPlaying = false;

        if(typeof(callback)=='function') this._endCallback = callback;
    },
    /**
     * /控制云台
     * @param action int, 动作，详见后面的动作列表
     * @param speed int, 速度
     * @param duration int, 持续时间，目前不生效
     * @param prepoint 要设置的预置点
     */
    ctrlPTZ: function(action, speed, duration, prepoint){
        //this.player.ctrlPTZ(action, speed, duration, prepoint);
        cameraConfig.ctrlPTZ(action,speed, duration, prepoint);
    },
    /**
     * 查询回放记录的天概要索引
     * @param year int, 年份，例如 2018
     * @param month  int, 月份， 例如 10
     * @param zone int 时区，例如 8 表示中国东8区
     * @param fn function(code, data)查询结果回调函数,code: int 查询成功为0，非0表示查询失败,data:array(object) 结果数组, 包含 “year, month, day”三个字段
     */
    queryDay: function(year, month, zone, fn){
        this.player.queryDay(year, month, zone, fn);
    },
    /**
     * 查询回放记录的24小时索引
     * @param year int 年份 例如 2018
     * @param month  int 月份 例如 10
     * @param day int 日期 例如 11
     * @param fn function(code, data) 查询结果回调函数,code： int 查询成功为0，非0表示查询失败,data：array(object) 结果数组，包含  s_year, s_month, s_day, s_hour, s_minute, s_second, e_year, e_month, e_day, e_hour, e_minute, e_second 字段
     */
    queryTime: function(year, month, day, fn){
        this.player.queryTime(year, month, day, fn);
    },
    /**
     * 控制回放起点
     * @param ctrl  int 控制类型, 1播放; 0停止;2暂停; 3继续
     * @param year int 年份
     * @param month int 月份
     * @param day  int 日
     * @param hour int 小时
     * @param minute int 分钟
     * @param second int 秒数
     */
    ctrlPlayback: function(ctrl, year, month, day, hour, minute, second){
        this.player.ctrlPlayback(ctrl, year, month, day, hour, minute, second);
    }
}

fjzx.camera.Utils = {
    ajaxPost: function(url, params, successCallback, errorCallback){
        $.ajax({
            url:url,
            method:"POST",
            headers: {
                "Accept":"application/json",
                "Content-Type":"application/json"
            },
            data:JSON.stringify(params),
            traditional: true,
            success: function(res){
                if(typeof(successCallback)=='function') successCallback(res);
            },
            error: function(err){
                if(typeof(errorCallback)=='function') errorCallback(err);
            }
        });
    },
    HashMap: function(){
        this.map = {};
        var that = this;
        return {
            put : function(key, value) {
                that.map[key] = value;
            },
            get : function(key) {
                if (that.map.hasOwnProperty(key)) {
                    return that.map[key];
                }
                return null;
            },
            remove : function(key) {
                if (that.map.hasOwnProperty(key)) {
                    return delete that.map[key];
                }
                return false;
            },
            removeAll : function() {
                that.map = {};
            },
            keySet : function() {
                var _keys = [];
                for ( var i in that.map) {
                    _keys.push(i);
                }
                return _keys;
            },
            length : function(){
                var  length=0;
                for ( var i in that.map) {
                    length++;
                }
                return length;
            }
        };
    },
    getUUID: function() {
		var s = [];
		var hexDigits = "0123456789ABCDEF";
		for (var i = 0; i < 32; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[12] = "4";
		s[16] = hexDigits.substr((s[16] & 0x3) | 0x8, 1);
		var uuid = s.join("");
		return uuid;
	},
    fullScreen: function(element) {
        if (element.requestFullscreen) {
            element.requestFullscreen();
        } else if (element.msRequestFullscreen) {
            element.msRequestFullscreen();
        } else if (element.mozRequestFullScreen) {
            element.mozRequestFullScreen();
        } else if (element.webkitRequestFullscreen) {
            element.webkitRequestFullscreen();
        }
    },
    exitFullScreen: function(element) {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
        }
    },
    isFullScreen: function(){
        var isFull = false;
        if(document.fullscreenEnabled || document.msFullscreenEnabled){
            isFull = window.fullScreen || document.webkitIsFullScreen;
            if(isFull == undefined){
                isFull = false;
            }
        }
        return isFull;
    }
}

fjzx.camera.CameraTree = function(options){
    this.opts = options || {};

    this.cameraTree = null;
    this._elementId = this.opts.elementId;
    this._onClickCallback = this.opts.onClick;
    //需要显示数据类型：设备列表（device），通道列表（channel)
    this._dataType = this.opts.dataType==null || typeof(this.opts.dataType)=='undefined' ? 'channel' : this.opts.dataType;
    this._condition = this.opts.condition == null || typeof(this.opts.condition)=='undefined' ? '' : this.opts.condition;

    var that = this;

    this._treeSetting = {
        view: {
            dblClickExpand: true
        },
        callback: {
            onCollapse: function(event, treeId, treeNode){
            },
            beforeExpand: function(treeId, treeNode){
                var id  = treeNode.id;
                var type = treeNode.type;
                return true;
            },
            onExpand: function(event,treeId,treeNode){
                var id  = treeNode.id;

                if(!treeNode.children.length){
                    switch (that._dataType){
                    case 'device': //设备列表
                        cameraConfig.getDeviceList(id,function(res){
                            that.addChildrenNodes(treeNode,res);
                        },function(res){

                        });
                        break;
                    default: //默认获取通道列表
                        cameraConfig.getChannelList(id,that._condition,function(res){
                            that.addChildrenNodes(treeNode,res);
                        },function(res){

                        });
                        break;
                    }
                }
            },
            onClick: function(event,treeId,treeNode, clickFlag){
                that._onClickCallback(treeNode);
            }
        }
    };
    this.cameraTree = $.fn.zTree.init($('#'+this._elementId), this._treeSetting);

    //首先登陆获取tk
    cameraConfig.login(function(res){
        that.load();
    },function(res){
        console.log(res);
    });
}

fjzx.camera.CameraTree.prototype = {
    getChildrenNodes: function(pId, type, successCallback, errorCallback){
        var that = this;
        cameraConfig.getGroupList(pId, successCallback, errorCallback);
        cameraConfig.getChannelList(pId, successCallback, errorCallback);
    },
    getCameraZTree: function(){
        return this.cameraTree;
    },
    addChildrenNodes: function(pNode,res){
        var that = this;

        var nodeList = [];
        console.log('---------------------addChildrenNodes');
        if(res.root_node!=null && typeof(res.root_node)!='undefined'){
            nodeList = nodeList.concat(res.root_node);
        }
        if(res.child_node!=null && typeof(res.child_node)!='undefined'){
            nodeList = nodeList.concat(res.child_node);
        }
        $.each(nodeList, function(index,item,array){
            var gtype = typeof(item.gtype)=='undefined' ? 100 : item.gtype; //-1:根节点,2:设备,3:通道
            var node = {
                'nodeType':'dept',
                'isParent': false,
                'open': false
            };

            if(gtype==-1){
                //根节点
                node = {
                    'pid':null,
                    'id': item.gid,
                    'name': item.gname,
                    //'iconSkin':'home01',
                    'icon':'/static/camera-zp/images/home.png',
                    'nodeType':'dept',
                    'isParent': true,
                    'open': false,

                    'children_len': item.children_len,
                    'gid': item.gid,
                    'gname': item.gname,
                    'gtype': item.gtype,
                    'has_sub_node': item.has_sub_node
                }
                if(item.has_sub_node){
                    node.children = [];
                };
            }else if(gtype==2){
                //设备节点
                node = {
                    "pid": pNode.id,
                    "id": item.dev_id,
                    "name": item.dev_name,
                    'icon': item.is_online ? '/static/camera-zp/images/chan_online.png' : '/static/camera-zp/images/chan_offline.png',
                    'nodeType':'device',

                    "gname": item.gname,
                    "gtype": item.gtype,
                    "children_len": item.children_len,
                    "has_sub_node": item.has_sub_node,
                    "dev_id": item.dev_id,
                    "dev_name": item.dev_name,
                    "dev_type": item.dev_type,
                    "chan_num": item.chan_num,
                    "is_online": item.is_online,
                }

                if(item.has_sub_node){
                    node.isParent = true;
                    node.open = false;
                    node.children = [];
                };
            }else if(gtype==3){
                //通道节点
                node = {
                    "pid": pNode.id,
                    "id": item.chan_id,
                    "name": item.chan_name,
                    'icon': item.is_online ? '/static/camera-zp/images/chan_online.png' : '/static/camera-zp/images/chan_offline.png',
                    'nodeType':'channel',

                    "gtype": item.gtype,
                    "children_len": item.children_len,
                    "has_sub_node": item.has_sub_node,
                    "is_sub_platform": item.is_sub_platform,
                    "protocol_type": item.protocol_type,
                    "chan_id": item.chan_id,
                    "chan_name": item.chan_name,
                    "chan_index": item.chan_index,
                    "chan_ability": item.chan_ability,
                    "is_online": typeof(item.is_online)=='undefined' ? 0 : item.is_online,
                    "dev_id": item.dev_id,
                    "dev_name": item.dev_name,
                    "create_time": item.create_time,
                    "update_time": item.update_time,
                }
            }else if(gtype==100){
                //其他节点
                node = {
                    'pid':pNode.id,
                    'id': item.gid,
                    'name': item.gname,
                    'nodeType':'dept',

                    'children_len': item.children_len,
                    'gid': item.gid,
                    'gname': item.gname,
                    'gtype': item.gtype,
                    'has_sub_node': item.has_sub_node,
                    'is_sub_platform':item.is_sub_platform
                }
                if(item.has_sub_node){
                    node.isParent = true;
                    node.open = false;
                    node.children = [];
                };
            }else{
                //其他节点
                node = {
                    "pid": pNode.id,
                    "id": item.gid,
                    "name": item.gname,
                    'nodeType':'other',

                    "gid": item.gid,
                    "gname": item.gname,
                    "children_len": item.children_len,
                    "has_sub_node": item.has_sub_node,
                    "is_sub_platform": item.is_sub_platform,
                    "protocol_type": item.protocol_type,
                }
                if(item.has_sub_node){
                    node.children = [];
                };
            }
            that.cameraTree.addNodes(pNode,node);
        });
    },
    setCondition: function(condition){
        this._condition = condition;
    },
    reload: function(){
        //先销毁树，再初始化
        this.cameraTree.destroy();
        this.cameraTree = $.fn.zTree.init($('#'+this.cameraTreeContainer), this._treeSetting);
        //加载数据
        this.load();
    },
    load: function(){
        var that = this;
        //开始获取组织机构列表
        cameraConfig.getGroupList(that._condition, function(res){
            if(res.ret==0){
                that.addChildrenNodes(null, res);
            }
        },function (res) {
            console.log(res);
        });
    }
}
