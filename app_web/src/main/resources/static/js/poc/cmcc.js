var g_log = "";
var g_count = 0;
var g_cmd_socket;
var g_browser_page_guid;
var g_ajax_http;

///动态加载js脚本文件
function loadScript(url) {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = url;
    document.body.appendChild(script);
}
///onLoad
function onLoad(){
    if (!("WebSocket" in window)){
        //动态加载Flash / IE6兼容JSON包
        loadScript("js/swfobject.js");
        loadScript("js/flash.js");
        if(typeof JSON == 'undefined'){
            loadScript("js/json2.js");
        }
        g_log += "Flash is already！";
    }else{
        g_log += "Websocket is already！";
    }
    //加载AJAX
    if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
        g_ajax_http=new XMLHttpRequest();
    }else{// code for IE6, IE5
        g_ajax_http=new ActiveXObject("Microsoft.XMLHTTP");
    }
    //生成网页GUID唯一标识码
    g_browser_page_guid = getUniqueId();
    showLog();
}
///创建一条Websocket连接
///返回值：socket对象
function connectWebsocket(port){
    if (!("WebSocket" in window)){
        alert("抱歉，您的浏览器不支持 WebSocket！");
        return null;
    }
    try{
        var host = ("ws://localhost:"+parseInt(port));
        var websocket = new WebSocket(host);
        websocket.onopen = function(){
            onOpen();
        }
        websocket.onmessage = function(msg){
            onMessage(msg.data);
        }
        websocket.onclose = function(event){
            onClose();
        }
        websocket.onerror = function(error){
            onError();
        }
        return websocket;
    }catch(exception){
        alert("connect websocket error.");
    }
    return null;
}
///建立Flash连接
///返回值：socket对象
function connectFlashsocket(port){
    try{
        var socket = swfobject.getObjectById('PoCFlash');
        socket.connect(port);
        return socket;
    }catch(exception){
        alert('conn flash error.');
    }
    return null;
}
///创建连接
///返回值：socket对象
function connect(port){
    if (!("WebSocket" in window)){
        return connectFlashsocket(port);
    }
    return connectWebsocket(port);
}
///断开连接
function disconnect(){
    try{
        g_cmd_socket.close();
    }catch(exception){
        alert('disconnect socket error.');
    }
}
///发送消息
function send(data){
    try{
        g_cmd_socket.send(data);
    }
    catch(exception){
        alert('send socket error.');
    }
}
///HTTP Get请求
function requestGet(get){
    var ret = "";
    try{
        g_ajax_http.open("GET","http://127.0.0.1:10086/?"+get+"&random="+getUniqueId(),false);
        g_ajax_http.send();
        ret = g_ajax_http.responseText;
    }catch (exception){
        alert('ajax get failed.');
    }
    return ret;
}

///连接成功
function onOpen(conn){
    try{
        g_cmd_socket.send(g_browser_page_guid);
    }catch(exception){
        alert('send guid error.');
    }
    g_log += (" "); g_log += (g_count++); g_log += ("# conn success.");
    showLog();
}
///消息体
function onMessage(data){
    g_log += (" "); g_log += (g_count++); g_log += ("# ");
    g_log += (data);
    showLog();
    analyzePackets(data);
}
///连接异常
function onError(error){
    alert('error');
}
///连接已断开
function onClose(close){
    alert('close');
}
///分析数据包
function analyzePackets(data){
    try{
        var obj = JSON.parse(data);
        switch(obj.type){
            //{\"type\":0,\"sessionId\":%d,\"fromWho\":\"%s\",\"contentType\":\"%s\",\"content\":\"%s\"}
            case 0: onMessagingEvent(obj.sessionId, obj.fromWho, obj.contentType, obj.content); break;
            case 1: onDialogEvent(obj.sessionId, obj.code); break;
            case 2: onInviteEvent(obj.sessionId, obj.fromWho, obj.contact); break;
            case 3: onTbcpEvent(obj.sessionId, obj.takenName, obj.code); break;
            case 4: onSubscribeEvent(obj.sessionId, obj.content); break;
            case 5: onWebsocketPreparedEvent(obj.srv);
            default: break;
        }
        //document.getElementById("sessionId").value = obj.sessionId;
    }catch(exception){
        alert('message error.');
    }
}
///产生GUID
function getUniqueId(){
    var date=new Date();
    var ss=date.getSeconds();
    var sss=date.getMilliseconds();
    var context = ss+sss+""+Math.floor(Math.random()*10)+Math.floor(Math.random()*10)+Math.floor(Math.random()*10)+
        Math.floor(Math.random()*10)+Math.floor(Math.random()*10)+Math.floor(Math.random()*10);
    return context;
}

/**************************************************
 *       消息回调接口
 *
 ***************************************************/

function onWebsocketPreparedEvent(){
    g_log += (" "); g_log += (g_count++); g_log += ("# onWebsocketPreparedEvent");
    showLog();
}

///服务器消息推送回调
function onMessagingEvent(sessionId, fromWho, contentType, content){
    g_log += (" "); g_log += (g_count++); g_log += ("# onMessagingEvent");
    if(contentType=='message/video+xml'){
        var xml=decode64(content);
        var bankDoc = parseXML(xml);
        var action=$(bankDoc).find('action').text();
        if(action==1){
            videoDialog(sessionId, content);
        }else{
            if(isVideoPlay){
                getByID("plugin_inst_1").stop();
                isVideoPlay = false;
                tabChannel();
                setTimeout(function () {
                        promptDialog('实时视频已经关闭！');
                },500);
            }
        }
    }
    showLog();
}

///服务器Dialog消息
/*
//dialog
#define PROTOCOL_TYPE_LOGGING_IN                            101       //正在登录
#define PROTOCOL_TYPE_LOGIN_OK                              102       //已登录
#define PROTOCOL_TYPE_LOGIN_TERMINATING                     103       //正在登出
#define PROTOCOL_TYPE_LOGIN_TERMINATED                      104       //已登出
//call
#define PROTOCOL_TYPE_CALL_DIALING                         201       //正在呼叫
#define PROTOCOL_TYPE_CALL_ONLINE                          202       //呼叫已建立
#define PROTOCOL_TYPE_CALL_HANGINGUP                       203       //正在挂断
#define PROTOCOL_TYPE_CALL_ENDED                           204       //已挂断
*/
function onDialogEvent(sessionId, code){
    if(sessionId==callSessionId && code == 204){
        pocCallConnectText("","（已断开）","点击按钮进行连接");
        connectStatus = "idle";
    }
    g_log += (" "); g_log += (g_count++); g_log += ("# onDialogEvent");
    showLog();
}
///服务器onInviteEvent消息（新来电）
function onInviteEvent(sessionId, fromWho, contact){

    //acceptCallDialog(sessionId,fromWho);
    pocAcceptCall(sessionId,fromWho);
    g_log += (" "); g_log += (g_count++); g_log += ("# onInviteEvent");
    showLog();
}
///服务器onTbcpEvent消息
/*
//tbcp
#define PROTOCOL_TYPE_TBCP_GRANTED                          301       //被授权
#define PROTOCOL_TYPE_TBCP_TAKEN                            302       //别人正在讲话
#define PROTOCOL_TYPE_TBCP_RELEASE                          303       //用户已释放当前授权
#define PROTOCOL_TYPE_TBCP_IDLE                             304       //用户处于空闲状态
#define PROTOCOL_TYPE_TBCP_DENY                             305       //用户讲话请求被拒绝
#define PROTOCOL_TYPE_TBCP_REVOKE                           306       //被剥夺说话权
#define PROTOCOL_TYPE_TBCP_CMD                              307       //收到一条命令
*/
function onTbcpEvent(sessionId, takenName, code){
    g_log += (" "); g_log += (g_count++); g_log += ("# onTbcpEvent");
    showLog();
}
///服务器onSubscribeEvent消息
function onSubscribeEvent(sessionId, content){
    pocCallConnectText("","（已连接）","点击对讲");
    connectStatus = "connect";
    g_log += (" "); g_log += (g_count++); g_log += ("# onSubscribeEvent");
    showLog();
}

/**************************************************
 *       Js接口
 *
 ***************************************************/

///登陆
function login(host, port, realm, impi, password){//const char* host, const int port, const char* realm,
    //const char * impi, const char * password
    try{
        var get = "op=login&guid="+g_browser_page_guid+"&host="+host+"&port="+port+"&realm="+realm+"&impi="+impi+"&password="+password;
        return requestGet(get);
    }catch(exception){
        alert("login error.");
    }
}
///退出登录
function logout(){
    try{
        var get = "op=logout&guid="+g_browser_page_guid;
        return requestGet(get);
    }catch(exception){
        alert("logout error.");
    }
}
///单呼
//返回值：Sip sessionId
function callOne(oneUri){//const char* oneUri
    try{
        var get = "op=callOne&guid="+g_browser_page_guid+"&oneUri="+oneUri;
        return requestGet(get);
    }catch(exception){
        alert("callOne error.");
    }
}
///临时呼叫（勾选多人）
//返回值：Sip sessionId
function callAdhoc(adhocUri){//const char* adhocUri
    try{
        var get = "op=callAdhoc&guid="+g_browser_page_guid+"&adhocUri="+adhocUri;
        return requestGet(get);
    }catch(exception){
        alert("callAdhoc error.");
    }
}
///组呼
//返回值：Sip sessionId
function callGroup(groupUri){//const char* groupUri
    try{
        var base = new Base64();
        var groupUri = base.encode(groupUri);
        var get = "op=callGroup&guid="+g_browser_page_guid+"&groupUri="+groupUri;
        return requestGet(get);
    }catch(exception){
        alert("callGroup error.");
    }
}
///挂断单个
function hangUp(sessionId){//const int sessionId
    try{
        var get = "op=hangUp&guid="+g_browser_page_guid+"&sessionId="+sessionId;
        return requestGet(get);
    }catch(exception){
        alert("hangUp error.");
    }
}
///挂断全部
function hangUpAll(){
    try{
        var get = "op=hangUpAll&guid="+g_browser_page_guid;
        return requestGet(get);
    }catch(exception){
        alert("hangUpAll error.");
    }
}
///请求话权
function requestTalk(sessionId){//const int sessionId
    try{
        var get = "op=requestTalk&guid="+g_browser_page_guid+"&sessionId="+sessionId;
        return requestGet(get);
    }catch(exception){
        alert("requestTalk error.");
    }
}
///释放话权
function releaseTalk(sessionId){//const int sessionId
    try{
        var get = "op=releaseTalk&guid="+g_browser_page_guid+"&sessionId="+sessionId;
        return requestGet(get);
    }catch(exception){
        alert("releaseTalk error.");
    }
}
///接听新来电
//注：onInviteEvent回调接口推送来电消息，包括sessionId等
function acceptCall(sessionId){//const int sessionId
    try{
        var get = "op=acceptCall&guid="+g_browser_page_guid+"&sessionId="+sessionId;
        return requestGet(get);
    }catch(exception){
        alert("acceptCall error.");
    }
}

/**************************************************
 *       日志处理
 *
 ***************************************************/
///显示日志
function showLog(){
    g_log+="\r\n";
    console.log(g_log);
    //document.getElementById("log").innerText = (g_log);
}
///多线程显示日志
function aysnLog(){
    console.log(g_log);
    //document.getElementById("log").innerText = (g_log);
}
///清空日志
function clearLog(){
    g_log = "";
    //document.getElementById("log").innerText = (g_log);
}

//Bsae64编解码
function Base64() {

    // private property
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    // public method for encoding
    this.encode = function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length) {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }
            output = output +
                _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
                _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }

    // public method for decoding
    this.decode = function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length) {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }

    // private method for UTF-8 encoding
    _utf8_encode = function (string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }
        return utftext;
    }

    // private method for UTF-8 decoding
    _utf8_decode = function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while ( i < utftext.length ) {
            c = utftext.charCodeAt(i);
            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            } else if((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i+1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            } else {
                c2 = utftext.charCodeAt(i+1);
                c3 = utftext.charCodeAt(i+2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}
/**************************************************
 *
 *
 ***************************************************/
function getByID(id) {
    return document.getElementById(id);
}
//1.连接
function pocConnect(){
    g_cmd_socket = connect(10087);
}
//2.断开TCP
function pocDisconnect(){
    disconnect();
}
//3.登陆
function pocLogin(dispatchAccount,plaintextPassword){
    //使用真实账号和密码
    var ret = login("112.33.0.130", 6060, "4gpoc.com", dispatchAccount,plaintextPassword);
}
//5.单呼
function pocCallOne(uid){
    var oneUri = "sip:"+uid+"@4gpoc.com"
    var sessionId = callOne(oneUri);
    g_log += (" "); g_log += (g_count++); g_log += ("# callOne sessionId="); g_log += sessionId;
    showLog();
    return sessionId;
}
//5.临时呼叫（勾选多人）
function pocCallAdhoc(conversationUidList){
    var sessionId;
    var adhocUri = "";
        for (var i=0;conversationUidList.length>i;i++){
            adhocUri = "sip:"+conversationUidList[i]+"@4gpoc.com,"+adhocUri;
            //sip:103910002@4gpoc.com,sip:103910003@4gpoc.com
    }
    adhocUri = adhocUri.substr(0, adhocUri.length - 1);
    sessionId = callAdhoc(adhocUri);
    return sessionId;
}
//挂断单个
function pocHangUp(sessionId){
    hangUp(sessionId);
}
//挂断全部
function pocHangUpAll(){
    hangUpAll();
}
//组呼
function pocCallGroup(groupId,dispatchAccount){
    var groupUri = "sip:"+groupId+"&"+dispatchAccount+"@4gpoc.com";
    var sessionId = callGroup(groupUri);
    g_log += (" "); g_log += (g_count++); g_log += ("# callGroup sessionId="); g_log += sessionId;
    showLog();
    return sessionId;
}
//点击频道列表显示通话tab
function pocChannelMessageTab(record){
    pocCallConnectShow();
    var groupId = $(record).attr("data-id");
    var name = $(record).attr("data-name");
    pocCallConnectText(name,"","点击对讲");
    connectStatus = "channel";
    $(".btn-voice").attr("data-id",$(record).attr("data-id"));
    callSessionId = pocCallGroup(groupId,dispatchAccount);
}
//点击会话列表显示通话tab
function pocConversationMessageTab(record){
    pocCallConnectShow();
    var conversationId = $(record).attr("data-id");
    var name = $(record).attr("data-name");
    pocCallConnectText(name,"（已断开）","点击按钮进行连接");
    connectStatus = "idle";
    getConversationUserList(conversationId);
    //$(".btn-voice").attr("data-id",$(record).attr("data-id"));
}
//点击接听显示通话tab
function pocCallConnectTab(fromWho){
    pocCallConnectShow();
    pocCallConnectText(fromWho,"（已连接）","点击对讲");
    connectStatus = "connect";
}
//连接中显示通话tab
function pocCallConnectingTab(fromWho){
    pocCallConnectShow();
    pocCallConnectText(fromWho,"（连接中）","连接中..");
    connectStatus = "connecting";
}
function pocCallConnectShow() {
    if(!$(".map-list-container").hasClass("show")){
        $(".map-list-container").addClass("show");
        $(".btn-collapse").addClass("active");
    }
}
function pocCallConnectText(fromWho,statusStr,text) {
    if(fromWho == ""){
        $("#status").html(statusStr);
    }else{
        var htmlStr = '<span>'+fromWho+'</span><span id="status">'+statusStr+'</span>';
        $(".user-name").html(htmlStr);
    }
    $("#prompt").html(text);
}
//点击人员呼叫
function pocCall(record){
    var uid = $(record).attr("data-id");
    var name = $(record).attr("data-name");
    callDialog(uid,name);
}
//请求话权
function pocRequestTalk(){
    $("#talk").addClass('active');
    requestTalk(callSessionId);
}
//释放话权
function pocReleaseTalk(){
    $("#talk").removeClass('active');
    releaseTalk(callSessionId);
}
//切换至组织成员列表
function tabOrganization(){
    $("#organization").siblings('.tab-list').removeClass('active');
    $("#organization").addClass('active');
    var target=$("#organization").attr("data-target");
    $(target).show();
    $(target).siblings(".box-body").hide();
}
//切换至频道会话列表
function tabChannel(){
    $("#channel").siblings('.tab-list').removeClass('active');
    $("#channel").addClass('active');
    var target=$("#channel").attr("data-target");
    $(target).show();
    $(target).siblings(".box-body").hide();
}
//切换至实时视频
function tabVideo(){
    $("#video").siblings('.tab-list').removeClass('active');
    $("#video").addClass('active');
    var target=$("#video").attr("data-target");
    $(target).show();
    $(target).siblings(".box-body").hide();
}
//提示框
function callDialog(uid,name){
    $.messager.confirm('提示', '确定呼叫'+name+'?', function(r){
        if (r){
            callAccount = "18250206576";
            callSessionId = pocCallOne(callAccount);
            tabChannel();
            pocCallConnectingTab(name);
        }
    });
}
function acceptCallDialog(sessionId,fromWho){
    $.messager.confirm('提示', fromWho+'正在呼叫，是否接听?', function(r){
        if (r){
            tabChannel();
            pocCallConnectTab(fromWho);
            acceptCall(sessionId);
            callSessionId = sessionId;
        }else{
            pocHangUp(sessionId);
        }
    });
}
function pocAcceptCall(sessionId,fromWho){
    $("#accept-call-prompt-container").show();
    $("#accept-call-prompt-container.call-name").html(fromWho);
    $("#btn-accept-danger").click(function() {
        pocHangUp(sessionId);
        $("#accept-call-prompt-container").hide();
    });
    $("#btn-accept-success").click(function() {
        tabChannel();
        pocCallConnectTab(fromWho);
        acceptCall(sessionId);
        callSessionId = sessionId;
        $("#accept-call-prompt-container").hide();
    });
}
function videoDialog(sessionId,content){
    $.messager.confirm('提示', sessionId+'实时视频申请是否播放?', function(r){
        if (r){
            tabVideo();
            getRstpUrl(content);
        }
    });
}
function promptDialog(msg){
    $.messager.alert('提示', msg);
}

function getAcceptCallId(uid,chatArr) {
    var Uids = new Array();;
    for (var j = 0, l = chatArr.length; j < l; j++) {
        if (chatArr[j].Uid != uid) {
            Uids.push(chatArr[j].Uid);
        }
    }
    return Uids;
}
var connectStatus = "idle";//空闲：idle 频道：channel 会话连接：connect
function pocCallConnectBtn(connectStatus) {
    switch (connectStatus) {
       case "idle":
           if(conversationUidList!=null && conversationUidList.length>1){
               callSessionId = pocCallAdhoc(conversationUidList);
               pocCallConnectText("","（连接中）","连接中..");
               connectStatus = "connecting";
           }else if(conversationUidList!=null && conversationUidList.length>0){
               callSessionId = pocCallOne(conversationUidList[0]);
               pocCallConnectText("","（连接中）","连接中..");
               connectStatus = "connecting";
           }else{
               callSessionId = pocCallOne(callAccount);
               pocCallConnectText("","（连接中）","连接中..");
               connectStatus = "connecting";
           }
           break;
        case "connect":
            if(!isTalk){
                requestTalk(callSessionId);
                $("#prompt").html("对讲中...");
                isTalk = true;
            }else{
                releaseTalk(callSessionId);
                $("#prompt").html("点击对讲");
                isTalk = false;
            }
            break;
        case "channel":
            if(!isTalk){
                requestTalk(callSessionId);
                $("#prompt").html("对讲中...");
                isTalk = true;
            }else{
                releaseTalk(callSessionId);
                $("#prompt").html("点击对讲");
                isTalk = false;
            }
            break;
        case "connecting":
            pocHangUp(callSessionId);
            pocCallConnectText("","（已断开）","点击按钮进行连接");
            connectStatus = "idle";
            break;
    }
}
