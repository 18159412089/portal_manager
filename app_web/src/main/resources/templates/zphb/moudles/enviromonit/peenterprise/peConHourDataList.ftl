<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>监测数据</title>
    <#include "/header.ftl"/>
    <script src="${request.contextPath}/static/js/datagrid-bufferview.js"></script>
    <script src="${request.contextPath}/static/js/datagrid-norecordview.js"></script>
</head>
<body>
<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div data-options="region: 'west',title:'企业监测点位',split: true" style="width:16%;" >
        <div class="input-group" >
            <input type="text" class="form-control fjzx-prog-string" placeholder="企业名称" fjzx_field_name="enterpriseIdName" fjzx_field_tip_name="企业名称">
            <span class="input-group-btn">
             	   <a href="#"  id="searchbutton"  class="easyui-linkbutton btn-primary">查询</a>
               </span>
        </div>
        <ul id="peEnterpriseDataTree"></ul>
    </div>
    <div data-options="region: 'center',title:'企业监测数据',split: true" style="width:84%;">
        <div id="toolbar">
            <div id="searchBar" class="searchBar">
                <form id="searchForm">
                    <div class="inline-block">
                        <label class="textbox-label textbox-label-before" title="监测开始时间">监测开始时间</label>
                        <input id="queryMeasureStartTime" name="queryMeasureStartTime" class="easyui-datetimebox" data-options="editable:false"  style="width:280px;">
                    </div>
                    <div class="inline-block">
                        <label class="textbox-label textbox-label-before" title="监测截止时间">监测截止时间</label>
                        <input id="queryMeasureEndTime" name="queryMeasureEndTime" class="easyui-datetimebox" data-options="editable:false"  style="width:280px;">
                    </div>
                    <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                    <a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
                    <!-- <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a> -->
                </form>
            </div>
        </div>
        <div id="monitorDeviceDataContainer" class="panel-group-body" style="height: 100%;">
            <table id="monitorDeviceDataTable" class="easyui-datagrid" style="width: 100%;"></table>
        </div>
    </div>
</div>
<script>
    var outputId = null;
    var companyName = null;
    var overArr = null ;
    companyName=decodeURIComponent(decodeURIComponent( "${enterpriseName}"));
    if(companyName !=null){
        $("input[fjzx_field_name=enterpriseIdName]").val(companyName);
        var record = {
            "outputId":"${outputId}"
        }
        outputId = "${outputId}";
    }
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
            searchEnterprise();
            showMonitorDeviceData(record);
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

    initQueryForm();
    function initQueryForm(){
        $('#queryMeasureStartTime').val(new Date().format("yyyy-MM-dd")+" 00:00:00");
        $('#queryMeasureEndTime').val(new Date().format("yyyy-MM-dd")+" 23:59:59");
    }


    function doSearch() {
        if(peEnterpriseDataTree!=null){
            var node = peEnterpriseDataTree.tree('getSelected');
            if(outputId == null || outputId =="") {

                 if (node == null || "MONITOR_POINT" != node.attributes.nodeType) {
                    $.messager.show({
                        title: '提示',
                        msg: "请选择需要调阅的企业监测点位。"
                    });
                     outputId = null;
                    return false;
                }
            }
             else{
                if(node == null){
                    node= {
                         attributes :{
                             "outputId":outputId
                         }

                    }
                }
            }
            showMonitorDeviceData(node.attributes);
        }
    }

    function doReset() {
        //$("#searchBar").find("#searchForm").form('clear');
        initQueryForm();
        doSearch();
    }
    //点击树的筛选按钮事件
    $("input[fjzx_field_name=enterpriseIdName]").bind('keyup',function(event){
        if(event.keyCode=="13") $("#searchbutton").click();
    });

    function searchEnterprise(){

        var enterpiseName =$("input[fjzx_field_name=enterpriseIdName]").val();
        companyName = enterpiseName;
        $('#peEnterpriseDataTree').tree({
            url:'${request.contextPath}/zphb/enterprise/peenterprisedata/getPeEnterpriseDatasTreeList',
            loadFilter:function(data){
                var newData = new Array();
                var datas = data[0].children;
                if(enterpiseName != null && enterpiseName !=""){
                    for(var i=0; i<datas.length; i++){
                        if(datas[i].text.search(enterpiseName)!=-1){
                            newData.push(datas[i]);
                        }
                    }
                    if(newData.length == 0 ){
                        var obj =[{
                            "attributes": "Object { nodeType:'ROOT' }",
                            "id": "1dKYkJqVx51o72hMzwo93S",
                            "state": "open",
                            "text": "企业监测点位",
                        }]
                        return obj;
                    }
                    return newData;
                }
                return data;
            }
        });

    }

    $("#searchbutton").click(function() {
         outputId = null;
         searchEnterprise();
    });

    var peEnterpriseDataTree = null;
    peEnterpriseDataTree = $('#peEnterpriseDataTree').tree({
        url:'${request.contextPath}/zphb/enterprise/peenterprisedata/getPeEnterpriseDatasTreeList',
        animate: false,//是否显示动画效果
        lines: false,//是否显示树线条
        data: null,//要加载的节点数据
        //formatter: function(node){
        //},
        onLoadSuccess:function(node,data){
            var t = $(this);
            if(data.length >0){
                $(data).each(function(index,d){
                    if(this.state == 'closed'){
                        t.tree('expandAll');
                    }
                });
                var outId = null ;

                if(outputId == null || outputId  == ""){

                    var n = $('#peEnterpriseDataTree').tree('find', data[0].id);
                    //调用选中事件
                    $('#peEnterpriseDataTree').tree('select', n.target);
                }else{
                    outId = "${outputId}";
                    var node = $('#peEnterpriseDataTree').tree('find',outId );
                    if(node != null){
                        $('#peEnterpriseDataTree').tree('select', node.target);
                    }
                }




            }

        },
        onClick: function(node){
            // $('#monitorDeviceDataTable').datagrid('loadData',{total:0,rows:[]});
            // $('#monitorDeviceDataTable').datagrid({
            // 	columns:[[]],
            // 	rownumbers:false,
            // 	pagination:false
            // });
            var nodeType = node.attributes.nodeType;
            if("MONITOR_POINT"==nodeType){
                showMonitorDeviceData(node.attributes);
            }
        }
    });




    //数据详情
    function showMonitorDeviceData(record) {
        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
        /*    var queryMeasureStartTime = "2019-09-04 22:00:00";
          var queryMeasureEndTime = "2019-09-30 22:00:00";*/
         outputId = record.outputId;
        var page = 1;
        var pageSize = 20;
        getMonitorDeviceDataTableColumnName(outputId,queryMeasureStartTime,queryMeasureEndTime,page , pageSize);

       /* setTimeout(function(){
            getMonitorDeviceDataTableColumn(outputId,queryMeasureStartTime,queryMeasureEndTime,page , pageSize);
        }, 100);*/

    }

    //初始化监测数据列表
    $('#monitorDeviceDataTable').datagrid({
        toolbar: '#toolbar'
    });
   var overStatus = null ;

    //获取监测数据列表标题
    function getMonitorDeviceDataTableColumnName(outputId,queryMeasureStartTime,queryMeasureEndTime,page, pageSize){
        //var cloumnValueList = [] ;
        var columnList = [] ;
        if (outputId == null){
            return;
        }
        $('#monitorDeviceDataTable').datagrid('loading','true');
        $.ajax({
            type : 'POST',
            url : Ams.ctxPath + '/zphb/minuteData/peconminutedata/getPollutionConMinuteDataListAndTableMetaByOutputId',
            dataType : 'json',
            data : {
                'outputId' : outputId,
                'queryMeasureStartTime' :queryMeasureStartTime,
                'queryMeasureEndTime' : queryMeasureEndTime,
                'page': page,
                'pageSize': pageSize
            },
            success : function(result) {
                //初始化监测数据列表
                if( result.maxSize != null){
                    columnNameList = result.data.clumnName;
                    if(columnNameList.length<=16){
                        fitColumns = true;
                    }
                }
                //遍历获取到的监测数据，判断相应监测值是否超标
                 overStatus =  result.data.overStatus;
                for(var i=0;i<columnNameList.length;i++){
                    var column = columnNameList[i];
                    columnNameList[i] = validateMonitorDeviceData(column);
                }

                //初始化监测数据列表
                $('#monitorDeviceDataTable').datagrid({
                    fit : true,
                    nowrap : true,
                    fitColumns : fitColumns,
                    columns : [columnNameList],
                    rownumbers : false,
                    singleSelect : true,
                    autoRowWidth : true,
                    autoRowHeight : false,
                    pagination: true,
                    pageSize : pageSize,
                    onLoadSuccess: function(data){
                    }
                } );
                $("#monitorDeviceDataTable").datagrid("loadData", {total : result.maxSize, rows : result.data.rows});
                $('#monitorDeviceDataTable').datagrid('getPager').pagination({
                    onSelectPage:function(pageNumber, pageSize){
                        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
                        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
                        getMonitorDeviceDataTableColumn(outputId,queryMeasureStartTime,queryMeasureEndTime,pageNumber , pageSize);
                    }
                });

            },
            error: function(){
            }
        });
    }

    //获取监测数据列表标题
    function getMonitorDeviceDataTableColumn(outputId,queryMeasureStartTime,queryMeasureEndTime,page, pageSize){
        if (outputId == null){
            return;
        }
        $.ajax({
            type : 'POST',
            url : Ams.ctxPath + '/zphb/minuteData/peconminutedata/getPollutionConMinuteDataListAndTableMetaByOutputId',
            dataType : 'json',
            data : {
                'outputId' : outputId,
                'queryMeasureStartTime' :queryMeasureStartTime,
                'queryMeasureEndTime' : queryMeasureEndTime,
                'page': page,
                'pageSize': pageSize
            },
            success : function(result) {
                overStatus =  result.data.overStatus;
                $("#monitorDeviceDataTable").datagrid("loadData", {total : result.maxSize, rows : result.data.rows});
            },
            error: function(){
            }
        });
    }

    //根据排口获取小时监测数据
    /*	function getPeConHourDataListByOutputId(outputId,queryMeasureStartTime,queryMeasureEndTime, page, pageSize) {
            if (outputId == null){
                return;
            }

            $.ajax({
                type : 'POST',
                url : Ams.ctxPath + '/hourData/peconhourdata/getPeConHourDataListByOutputId',
                dataType : 'json',
                data : {
                    'outputId' : outputId,
                    'queryMeasureStartTime' : $("#queryMeasureStartTime").val().trim(),
                    'queryMeasureEndTime' : $("#queryMeasureEndTime").val().trim(),
                    'page': page,
                    'pageSize': pageSize
                },
                success : function(result) {
                    $("#monitorDeviceDataTable").datagrid("loadData", {total : result.maxSize, rows : result.data});
                },
                error: function(){
                }
            });
        }*/


    //校验监测数据是否超标，超标数据背景色为红色高亮
    function validateMonitorDeviceData(column){
        //给超标数据所在单元格设置样式
        var result = "";

        if(column.field != "rowNum" && column.field != "dataTime"){

            if(overStatus != null ){
                column.styler = function(val,row,index){
                    var selectIndex = index;
                     if(overStatus[selectIndex][column.field+"overStatus"] == "true"){
                        result = 'background-color:#FF0000;';
                    }else{
                        result = 'background-color:#ffffff;';
                    }
                    return result;
                }
            }
        }
        return column;
    }

    function exportData() {
        var outputId;
        if(peEnterpriseDataTree!=null){
            var node = peEnterpriseDataTree.tree('getSelected');
            if(node==null || "MONITOR_POINT"!=node.attributes.nodeType){
                $.messager.show({
                    title: '提示',
                    msg: "请选择需要调阅的企业监测点位。"
                });
                return false;
            }
            showMonitorDeviceData(node.attributes);
            outputId = node.attributes.outputId;
        }
        var queryMeasureStartTime = $("#queryMeasureStartTime").val().trim();
        var queryMeasureEndTime = $("#queryMeasureEndTime").val().trim();
        var page = 1;
        var pageSize = 20;
        window.open(Ams.ctxPath + '/zphb/hourData/peconhourdata/export?queryMeasureStartTime='+queryMeasureStartTime+'&queryMeasureEndTime='+queryMeasureEndTime+
            '&outputId='+outputId+'&page='+page+'&pageSize='+pageSize);

    }

    //监测数据详细列表滚动条触底绑定函数
    function onMonitorDeviceDataListScroll(){
        $("#monitorDeviceDataContainer .datagrid-body").off("scroll");
        var nScrollHight = 0; //滚动距离总长(注意不是滚动条的长度)
        var nScrollTop = 0;   //滚动到的当前位置
        var nDivHight = $("#monitorDeviceDataContainer .datagrid-body").height();
        $("#monitorDeviceDataContainer .datagrid-body").on("scroll",function(){
            nScrollHight = $(this)[0].scrollHeight;
            nScrollTop = $(this)[0].scrollTop;
            var paddingBottom = parseInt($(this).css('padding-bottom') ),paddingTop = parseInt( $(this).css('padding-top') );
            if(nScrollTop + paddingBottom + paddingTop + nDivHight >= nScrollHight && !loadingFlag){
                //getPeConDayDataListByOutputId(currentOutputId,page);
                getMonitorDeviceDataTableColumn(outputId,queryMeasureStartTime,queryMeasureEndTime,page , pageSize);
            }
        });
    }

</script>
</body>
</html>