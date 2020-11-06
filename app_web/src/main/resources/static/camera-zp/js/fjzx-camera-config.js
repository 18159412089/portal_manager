/*!
 * fjzx-camera-config.js
 *
 * ZhangGQ
 * 2019-09-29 18:00:00
 */

window.cameraConfig = function(){
    var that = this;

    /**
     * 基础参数配置信息
     */
    //var basePath = 'http://120.79.249.106:18081/webapi';
    var basePath = 'http://119.23.74.116:18081/webapi';
    var currentTk = '';
    var username = 'manager';
    var password = 'Admin363200';
    var reLoginTimes = 0;

    /**
     * 视频监控调用的所有API列表
     */
    var urlList = {
        login: basePath + '/login',
        preview: basePath + '/v4/preview/view', //预览
        capture: basePath + '/v4/preview/capture',  //截图
        getGroupListWithPId: basePath + '/v4/group/list',  //获取资源组织架构列表
        getGroupList: basePath + '/v4/group/list',  //搜索组织架构
        searchGroupList: basePath + '/v4/group/search',  //搜索组织架构

        getDeviceList: basePath + '/v4/device/alllist', //获取全部设备列表
        getChannelList: basePath + '/v4/channel/prechanlist', //分级获取观看列表

        getChannelAbility: basePath + '/v4/channel/ability', //获取通道能力
        ctrlPTZ: basePath + '/v4/ptz/control', //云台控制
        getAlarmHistoryList: basePath + '/v4/alarm/history', //报警历史记录
    };

    var ajaxPost = function(url, params, successCallback, errorCallback){
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
                if(res.ret != 0){
                    errorHandler(res);
                }
                if(typeof(successCallback)=='function') successCallback(res);
            },
            error: function(err){
                if(typeof(errorCallback)=='function') errorCallback(err);
            }
        });
    };
    /**
     * 根据节点类型代码获取对应类型名称
     * @param type
     * @return {string}
     */
    var getTypeName = function(type){
        var typeName = '';
        switch (type) {
            case -1:  //根节点
                typeName = '根节点';
                break;
            case 0:  //区域
                typeName = '区域';
                break;
            case 1:  //场所
                typeName = '场所';
                break;
            case 2:   //设备
                typeName = '设备';
                break;
            case 3:   //通道
                typeName = '通道';
                break;
            case 10:   //下级平台节点
                typeName = '下级平台节点';
                break;
            case 11:   //下级平台设备
                typeName = '下级平台设备';
                break;
            case 12:   //下级平台通道
                typeName = '下级平台通道';
                break;
            default:
                break;
        }
        return typeName;
    };
    /**
     * 获取部门节点列表
     * @param gid
     * @param successCallback
     * @param errorCallback
     */
    var getGroupList = function(gid, successCallback, errorCallback){
        var url = urlList.getGroupList+'?tk='+getTk();
        var param = {
            'gid': gid,
            'page_index': 1,
            'page_size': 100
        };
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('组织架构节点获取成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('组织架构节点获取失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('组织架构节点获取错误');
                console.log(res);
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 登录视频监控平台并获取token
     * @param successCallback
     * @param errorCallback
     */
    var login = function(successCallback, errorCallback){
        var url = urlList.login;
        var param = {
            "user": username,
            "password": password,
            "force": 0,
            "login_mode": 0
        };
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('登录成功');

                    currentTk = res.tk;
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('登录失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res) {
                console.log('登录错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 获取当前token，当当前token为null时调用登录接口进行登录获取
     * @return {string}
     */
    var getTk = function(){
        if(currentTk == null){
            login();
        }
        return currentTk;
    };
    /**
     * 根据父级节点ID获取对应设备子节点列表（包括了部门节点和设备节点）
     * @param gid
     * @param successCallback
     * @param errorCallback
     */
    var getDeviceList = function(gid, successCallback,errorCallback){
        var url = urlList.getDeviceList+'?tk='+getTk();
        var param = {
            "gid": gid,
            "page_index": 1,
            "page_size": 1000
        };
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('设备节点获取成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('设备节点获取失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('设备节点获取成功错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 根据父节点获取对应通道子节点列表（包括了部门节点和通道节点）
     * @param gid
     * @param condition
     * @param successCallback
     * @param errorCallback
     */
    var getChannelList = function(gid, condition, successCallback, errorCallback){
        var url = urlList.getChannelList+'?tk='+getTk();
        var param = {
            'gid': gid,
            'page_index': 1,
            'page_size': 100,
            'condition': condition
        };
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('设备通道节点获取成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('设备通道节点获取失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('设备通道节点获取错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 根据通道ID获取对应通道能力
     * @param chanid
     * @param successCallback
     * @param errorCallback
     */
    var getChannelAbility = function (chanid, successCallback, errorCallback) {
        var url = urlList.getChannelAbility+'?tk='+getTk();
        var param = {
            'chan_serial': chanid
        };
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('通道能力获取成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('通道能力获取失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('通道能力获取错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 预览视频监控
     * @param chanid
     * @param successCallback
     * @param errorCallback
     */
    var startView = function(chanid, successCallback, errorCallback){
        var url = urlList.preview + '?tk='+getTk();
        var param = {
            "chan_serial":  chanid        // 获取预览的url接口，只需要通道id一个参数
        };
        ajaxPost(url, param, function(res){
            if(res.ret==0){
                console.log('预览成功');
                if(typeof(successCallback)=='function') return successCallback(res);
            }else{
                console.log('预览失败');
                if(typeof(errorCallback)=='function') return errorCallback(res);
            }
        }, function(res){
            console.log('预览出错');
            if(typeof(errorCallback)=='function') return errorCallback(res);
        });
    };
    /**
     * 云台控制
     * @param tk string
     * @param chanid  string 通道序列号
     * @param action int 云台动作编码，0-变倍-放大，1-变倍-缩小，2-光圈-放大，3-光圈-缩小，4-调焦-近，5调焦-远，6-镜头移动上，7-镜头移动下，8-镜头移动左，9-镜头移动右，10-镜头移动上左，11-镜头移动上右，12-镜头移动下左，13-镜头移动下右，14-停止当前操作，15-设定操作速度，16-回到原点，17-设置预置点，18-调用预置点，19-删除预置点
     * @param speed int 云台速度，范围：1-10，当action=15时生效
     * @param prepoint int 预置点，范围：1-64，当action=17,18,19时生效
     * @param successCallback
     * @param errorCallback
     */
    var ctrlPTZ = function(chanid, action, speed, prepoint, successCallback, errorCallback){
        var url = urlList.ctrlPTZ+'?tk='+getTk();
        action = parseInt(action);
        var param = {
            'chan_serial': chanid,
            'action': action,
            'speed': speed,
            'prepoint': prepoint,
        };
        var actionName = getPTZActionName(action);
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('云台控制['+actionName+']成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('云台控制['+actionName+']失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('云台控制['+actionName+']错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 报警历史记录
     * @param page_index        分页索引，从1开始
     * @param page_size         分页大小
     * @param dev_serial        设备的序列号
     * @param start_ts          查询开始时间
     * @param end_ts            查询结束时间
     * @param alarm_type        查询报警类型列表(0：其他报警1：移动侦测 2：遮盖报警 3：视频丢失 4：无存储介质 5：存储失败 6：磁盘空间不足 13: 婴儿哭声报警)
     * @param sensor_type       传感器类型
     * @param successCallback   获取成功回调函数
     * @param errorCallback     获取失败回调函数
     *
     * @return {
     *  ret         int         0表示成功，小于0表示失败
     *  msg         string      错误描述
     *  page_index  int         分页索引，从1开始
     *  page_size   int         分页大小
     *  all_size    int         总记录数
     *  alarm_list  array(object(AlarmInfo))  报警记录
     * }
     */
    var getAlarmHistoryList = function(page_index,page_size,dev_serial,start_ts,end_ts,alarm_type,sensor_type,successCallback, errorCallback){
        var url = urlList.getAlarmHistoryList+'?tk='+getTk();
        var param = {
            'page_index': page_index,
            'page_size': page_size,
            'dev_serial': dev_serial,
            'start_ts': start_ts,
            'end_ts': end_ts,
            'alarm_type': alarm_type,
            'sensor_type': sensor_type,
        };
        var alarmTypeName = getAlarmTypeName(alarm_type);
        ajaxPost(
            url,
            param,
            function(res){
                if (res.ret == 0) {
                    console.log('['+alarmTypeName+']报警历史记录获取成功');
                    if(typeof(successCallback)=='function') successCallback(res);
                } else{
                    console.log('['+alarmTypeName+']报警历史记录获取失败');
                    if(typeof(errorCallback)=='function') errorCallback(res);
                }
            },
            function(res){
                console.log('['+alarmTypeName+']报警历史记录获取错误');
                if(typeof(errorCallback)=='function') errorCallback(res);
            }
        );
    };
    /**
     * 根据云台控制动作代码获取对应动作名称
     * @param action
     * @return {string}
     */
    var getPTZActionName = function(action){
        var result = '';
        switch (parseInt(action)){
            case 0:
                result = '0-变倍放大';
                break;
            case 1:
                result = '1-变倍缩小';
                break;
            case 2:
                result = '2-光圈放大';
                break;
            case 3:
                result = '3-光圈缩小';
                break;
            case 4:
                result = '4-调焦近';
                break;
            case -5:
                result = '5-调焦远';
                break;
            case 6:
                result = '6-镜头移动上';
                break;
            case 7:
                result = '7-镜头移动下';
                break;
            case 8:
                result = '8-镜头移动左';
                break;
            case 9:
                result = '9-镜头移动右';
                break;
            case 10:
                result = '10-镜头移动上左';
                break;
            case 11:
                result = '11-镜头移动上右';
                break;
            case 12:
                result = '12-镜头移动下左';
                break;
            case 13:
                result = '13-镜头移动下右';
                break;
            case 14:
                result = '14-停止当前操作';
                break;
            case 15:
                result = '15-设定操作速度';
                break;
            case 16:
                result = '16-回到原点';
                break;
            case 17:
                result = '17-设置预置点';
                break;
            case 18:
                result = '18-调用预置点';
                break;
            case 19:
                result = '19-删除预置点';
                break;
            default:
                result = action+'-无效操作';
                break;
        }
        return result;
    };
    /**
     * 根据包机类型代码获取对应类型名称
     * @param alarmType
     * @return {string}
     */
    var getAlarmTypeName = function(alarmType){
        var result = '';
        switch(alarmType){
            case 0:
                result = '其他报警';
                break;
            case 1:
                result = '移动侦测';
                break;
            case 2:
                result = '遮盖报警';
                break;
            case 3:
                result = '视频丢失';
                break;
            case 4:
                result = '无存储介质';
                break;
            case -5:
                result = '存储失败';
                break;
            case 6:
                result = '磁盘空间不足';
                break;
            case 13:
                result = '婴儿哭声报警';
                break;
            default:
                result = '无效报警类型';
                break;
        }
        return result;
    };
    /**
     * 根据错误代码获取对应错误信息
     * @param errorCode
     * @return {string}
     */
    var getErrorName = function(errorCode){
        var msg = '';
        switch (errorCode) {
            case -0:
                msg = '正常';
                break;
            case -1:
                msg = '内部错误';
                break;
            case -2:
                msg = '参数错误';
                break;
            case -3:
                msg = '未知错误';
                break;
            case -4:
                msg = '连接超时';
                break;
            case -5:
                //msg = '拒绝访问';
                msg = '连接超时';
                break;
            case -9:
                msg = '预览资源达到上限';
                break;
            case -30001:
                msg = '接口不存在';
                break;
            case -30002:
                msg = '用户不存在';
                break;
            case -30003:
                msg = '密码错误';
                break;
            case -30004:
                msg = '账号已经停用';
                break;
            case -30005:
                msg = '账号已经登录';
                break;
            case -30006:
                msg = '新旧密码不一致';
                break;
            case -30007:
                msg = '参数错误';
                break;
            case -30008:
                msg = '验证码失效';
                break;
            case -30009:
                msg = 'HTTP请求错误';
                break;
            case -30010:
                msg = '访问拒绝';
                break;
            case -30011:
                msg = '设备登录保存session登录信息失败';
                break;
            case -30012:
                msg = '设备登录msgfrom错误';
                break;
            case -30013:
                msg = '设备登录保存登录信息失败';
                break;
            default:
                msg = '无效错误码';
                break;
        }
        return msg;
    };
    /**
     * 错误代码处理器
     * @param res
     */
    var errorHandler = function(res){
        var errorCodeName = getErrorName(res.ret);
        var errorMsg = errorCodeName+'('+res.ret+')，请联系系统管理员！';

        if((res.ret==-5 || res.ret==-4) && reLoginTimes < 6){
            reLoginTimes++;
            cameraConfig.login(function(res){
                reLoginTimes = 0;
            },function(res){
            });
            errorMsg = errorCodeName+'('+res.ret+')，正在尝试重新连接，请稍后再试！';
        }else if(res.ret==-1){
            errorMsg = errorCodeName+'('+res.ret+')，可能设备已离线，请联系系统管理员！';
        }

        layer.msg(errorMsg);
    };

    return {
        basePath: basePath,
        urlList: urlList,

        login: login,
        getTk: getTk,
        getGroupList: getGroupList,
        getDeviceList: getDeviceList,
        getChannelList: getChannelList,
        getChannelAbility: getChannelAbility,
        ctrlPTZ: ctrlPTZ,
        getPTZActionName: getPTZActionName,
        startView: startView,
        getAlarmHistoryList: getAlarmHistoryList,
    };
}();
