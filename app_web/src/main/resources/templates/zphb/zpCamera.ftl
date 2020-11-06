<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>漳浦视频监控</title>
	<#include "/header.ftl"/>
    <!-- 视频监控 -->
    <link rel="stylesheet" href="${request.contextPath}/static/ztree/css/zTreeStyle/zTreeStyle.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/cameraBase.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/index.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/preview.css"/>
    <link rel="stylesheet" href="${request.contextPath}/static/camera-zp/css/video.css"/>

    <!-- 地图相关 -->
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/static/fjzx-map/css/fjzx-map-ui.css"></link>
    <link rel="stylesheet" href="${request.contextPath}/static/css/tiandi-map/ol.css"></link>
</head>
<body>
    <#include "/common/loadingDiv.ftl"/>
<!-- datagrid -->
<div class="easyui-layout" fit=true>
<#--左侧设备树-->
    <div data-options="region: 'west',title:'视频监控列表',split: true" style="width:18%;">
        <div class="input-group" style="display: none;">
            <input type="text" class="form-control fjzx-prog-string" placeholder="名称" fjzx_field_name="cameraConditionn" fjzx_field_tip_name="名称">
            <span class="input-group-btn">
                   <a href="#" id="searchbutton" class="easyui-linkbutton btn-primary">查询</a>
                </span>
        </div>
        <ul id="zpCameraTree" class="ztree"></ul>
    </div>
<#--右侧数据-->
    <div data-options="region: 'center',title:'报警日志',split: true" style="width:85%;">
        <div id="toolbar">
            <div id="searchBar" class="searchBar">
                <form id="searchForm">
                    <div class="inline-block">
                        <label class="textbox-label textbox-label-before" title="截止时间">报警类型:</label>
                        <#--<select id="alarmType" class="easyui-combobox" name="alarmType" style="width:200px;">
                            <option value="1">移动侦测</option>
                            <option value="2">遮盖报警</option>
                            <option value="3">视频丢失</option>
                            <option value="4">无存储介质</option>
                            <option value="5">存储失败</option>
                            <option value="6">磁盘空间不足</option>
                            <option value="13">婴儿哭声报警</option>
                            <option value="0">其他报警</option>
                        </select>-->
                        <input id="alarmType" name="alarmType" value="1" />
                    </div>
                    <div class="inline-block">
                        <label class="textbox-label textbox-label-before" title="开始时间">开始时间:</label>
                        <input id="queryStartTime" name="queryMeasureStartTime" class="easyui-datetimebox" data-options="editable:false"style="width:280px;">
                    </div>
                    <div class="inline-block">
                        <label class="textbox-label textbox-label-before" title="截止时间">截止时间:</label>
                        <input id="queryEndTime" name="queryMeasureEndTime" class="easyui-datetimebox" data-options="editable:false"  style="width:280px;">
                    </div>
                    <a id="searchAlarmList" href="#" class="easyui-linkbutton  btn-primary" data-options="iconCls:'icon-search'">查询</a>
                    <!-- <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a> -->
                    <#--<a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>-->
                </form>
            </div>
        </div>
        <div id="cameraAlarmHistoryContainer" class="panel-group-body" style="height: 100%;">
            <table id="cameraAlarmHistoryTable" class="easyui-datagrid" style="width: 100%;"></table>
        </div>
    </div>
</div>
<script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
<script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
<!-- 地图相关 -->
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/ol.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/maps.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/tiandi-map/service.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-utils.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map.js"></script>
<script src="${request.contextPath}/static/fjzx-map/js/fjzx-map-source.js"></script>
<#-- 视频监控 -->
<script src="${request.contextPath}/static/ztree/js/jquery.ztree.core.js"></script>
<script src="${request.contextPath}/static/camera-zp/js/slplayer.js"></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera-config.js'></script>
<script src='${request.contextPath}/static/camera-zp/js/fjzx-camera.js'></script>
<script>
    //=========页面工具============
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    Date.prototype.format = function(format){
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "H+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(format)){
            format=format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        }
        for(var k in o){
            if(new RegExp("("+ k +")").test(format)){
                format = format.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            }
        }
        return format;
    };
    function getTimeFromDate(dateStr){
        var date= dateStr.replace(new RegExp("-","gm"),"/");
        var dateM = (new Date(date)).getTime(); //得到毫秒数
        return dateM;
    }
    //=========页面工具============


    //初始化时间
    initQueryForm();
    function initQueryForm(){
        $('#queryStartTime').val(new Date().format("yyyy-MM-dd")+" 00:00:00");
        $('#queryEndTime').val(new Date().format("yyyy-MM-dd")+" 23:59:59");
        $('#alarmType').combobox({
            url:'combobox_data.json',
            valueField:'type',
            textField:'typeName',
            data:[
                {"type":1, "typeName":"移动侦测"},
                {"type":2, "typeName":"遮盖报警"},
                {"type":3, "typeName":"视频丢失"},
                {"type":4, "typeName":"无存储介质"},
                {"type":5, "typeName":"存储失败"},
                {"type":6, "typeName":"磁盘空间不足"},
                {"type":13, "typeName":"婴儿哭声报警"},
                {"type":0, "typeName":"其他报警"},
            ]
        });
    }
    var pageNumber = 1;
    var pageSize = 10;

    //初始化视频监控列表树
    var zpCameraTree = new fjzx.camera.CameraTree({
        "elementId":"zpCameraTree",
        "dataType": "device",
        "onClick": function(treeNode){
            if(treeNode.nodeType=='device'){
                var devId = treeNode.dev_id;
                var queryStartTime = getTimeFromDate($('#queryStartTime').val());
                var queryEndTime = getTimeFromDate($('#queryEndTime').val());
                var alarmType = parseInt($("#alarmType").combobox("getValue"));
                getAlarmHistoryList(devId,queryStartTime,queryEndTime,alarmType, pageNumber,pageSize);
            }
        }
    });

    //==================报警列表初始化 Start=========================
    $('#cameraAlarmHistoryTable').datagrid({
        fit : true,
        nowrap : true,
        fitColumns : false,
        //view : bufferview,
        rownumbers : true,
        singleSelect : true,
        autoRowWidth : true,
        autoRowHeight : false,
        pagination: true,
        toolbar: '#toolbar',
        loading: true,
        columns : [[
            {field:'chan_serial',title:'通道序列号',width:100},
            {field:'dp_name',title:'设备-通道',width:100},
            {field:'alarm_type',title:'报警类型',width:100},
            {field:'alarm_image',title:'报警截图',width:100},
            {field:'alarm_video',title:'报警视频',width:100},
            {field:'chan_no_list',title:'关联通道列表',width:100},
            {field:'sensor_type',title:'传感器类型',width:100},
            {field:'sensor_addr',title:'传感器地址',width:100},
            {field:'context',title:'报警内容',width:100},
            {field:'alarm_time',title:'报警时间',width:100}
        ]],
        onLoadSuccess: function(data){
            if (data.total==0) {
                var body = $(this).data().datagrid.dc.body2;
                body.find('table tbody').append('<tr><td colspan="50" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
            }
        }
    });
    $('#cameraAlarmHistoryTable').datagrid('getPager').pagination({
        onSelectPage:function(pageNumber, pageSize){
            var devId = getSelectedDeviceId();
            var queryStartTime = getTimeFromDate($('#queryStartTime').val());
            var queryEndTime = getTimeFromDate($('#queryEndTime').val());
            var alarmType = parseInt($("#alarmType").combobox("getValue"));

            getAlarmHistoryList(devId,queryStartTime,queryEndTime,alarmType, pageNumber,pageSize);
        }
    });
    //==================报警列表初始化 End=========================

    /**
     * 根据查询条件获取监控设备报警记录
     * @param devId
     * @param queryStartTime
     * @param queryEndTime
     * @param alarmType
     * @param pageNumber
     * @param pageSize
     * @return {boolean}
     */
    function getAlarmHistoryList(devId,queryStartTime,queryEndTime,alarmType, pageNumber,pageSize){
        var sensor_type = 1;

        if(devId==null){
            $("#cameraAlarmHistoryTable").datagrid("loadData", {total: 0, rows: []});
            $('#cameraAlarmHistoryTable').datagrid('loaded');
            return false;
        }

        cameraConfig.getAlarmHistoryList(pageNumber,pageSize,devId,queryStartTime,queryEndTime,alarmType,sensor_type,function(res){
            console.log(res);
            //初始化监测数据列表
            $('#cameraAlarmHistoryTable').datagrid({
                pageSize : pageSize,
            });
            var maxSize = 0;
            var columnValueList = [];
            if(res.all_size != null){
                maxSize = res.all_size;
                columnValueList = res.alarm_list;
            }
            $("#cameraAlarmHistoryTable").datagrid("loadData", {total: maxSize, rows: columnValueList});
            $('#cameraAlarmHistoryTable').datagrid('loaded');
        }, function(err){

        });
    }

    /**
     * 监听报警记录列表查询按钮
     */
    $("#searchAlarmList").click(function(){
        cameraZTree = zpCameraTree.getCameraZTree();
        var selectNodes = cameraZTree.getSelectedNodes();
        if(!selectNodes.length){
            layer.msg('请选择需要查看报警记录的监控设备！');
            return false;
        }
        var node = selectNodes[0];
        if(node.nodeType!='device'){
            layer.msg('请选择监控设备节点！');
            return false;
        }
        var devId = getSelectedDeviceId();
        var queryStartTime = getTimeFromDate($('#queryStartTime').val());
        var queryEndTime = getTimeFromDate($('#queryEndTime').val());
        console.log($("#alarmType").combobox("getValue"));
        var alarmType = parseInt($("#alarmType").combobox("getValue"));
        getAlarmHistoryList(devId,queryStartTime,queryEndTime,alarmType, pageNumber,pageSize);
    });

    /**
     * 获取左侧设备树当前选中设备ID
     * @return {*}
     */
    function getSelectedDeviceId(){
        cameraZTree = zpCameraTree.getCameraZTree();
        var selectNodes = cameraZTree.getSelectedNodes();
        if(selectNodes.length <= 0){
            layer.msg('请选择需要查看报警记录的监控设备！');
            return null;
        }
        var node = selectNodes[0];
        if(node.nodeType!='device'){
            layer.msg('请选择监控设备节点！');
            return null;
        }
        var devId = node.dev_id;
        return devId;
    }
</script>
</body>
</html>