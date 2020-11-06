<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>超标次数-省数据分析-水环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
    <!-- tabs 标签页 -->
    <div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
        <!-- 标签页——1 -->
        <div title="国控断面" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar1">
                    <!-- 搜索栏 -->
                    <div id="searchBar1" class="searchBar">
                        <form id="searchForm1">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>

                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                               onclick="doSearch()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset()">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->
                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="monitoringTime"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">超标次数排名前三</div>
                                <div class="cell-content" id="area1">

                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">超标次数排名后三</div>
                                <div class="cell-content" id="area2">

                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->

                    <!-- 标题栏 -->
                    <div class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">超标次数
                        <#--<span class="subtitle">监测次数：30天</span>-->
                        </h2>

                    </div>
                    <!-- 标题栏 over -->
                <#--<div class="optionBar">
                    <div class="radio-button-group style-btn-group">
                        <span class="active">月</span>
                        <span>年</span>
                    </div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
                </div>-->

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="chart-box">
                            <div id="chartId" style="width: 100%;height: 420px;"></div>
                        </div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       data-options="
                       rownumbers:false,
                       singleSelect:true,
                       striped:true,
                       autoRowHeight:false,
                       fitColumns:true,
                       fit:true,
                       pagination:true,
                       pageSize:20,
                       pageList:[20,50,100]">
                    <thead>
                    <tr>
                        <th field="num" width="10%">排名</th>
                        <th field="startEnd" width="30%">时间</th>
                        <th field="name" width="30%" align="center">地区名称</th>
                        <th field="day" width="30%" align="center">超标次数</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->
        <div title="省控断面" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar2">
                    <!-- 搜索栏 -->
                    <div id="searchBar2" class="searchBar">
                        <form id="searchForm2">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime2" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime2" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>

                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                               onclick="doSearch2()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset2()">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->
                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="monitoringTime2"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">超标次数排名前三</div>
                                <div class="cell-content" id="area12">

                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">超标次数排名后三</div>
                                <div class="cell-content" id="area22">

                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->

                    <!-- 标题栏 -->
                    <div class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">超标次数
                        <#--<span class="subtitle">监测次数：30天</span>-->
                        </h2>

                    </div>
                    <!-- 标题栏 over -->
                <#--<div class="optionBar">
                    <div class="radio-button-group style-btn-group">
                        <span class="active">月</span>
                        <span>年</span>
                    </div>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
                </div>-->

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="chart-box">
                            <div id="chartId2" style="width: 100%;height: 420px;"></div>
                        </div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
                       data-options="
                       rownumbers:false,
                       singleSelect:true,
                       striped:true,
                       autoRowHeight:false,
                       fitColumns:true,
                       fit:true,
                       pagination:true,
                       pageSize:20,
                       pageList:[20,50,100]">
                    <thead>
                    <tr>
                        <th field="num" width="10%">排名</th>
                        <th field="startEnd" width="30%">时间</th>
                        <th field="name" width="30%" align="center">地区名称</th>
                        <th field="day" width="30%" align="center">超标次数</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
        </div>

    </div>
    <!-- tabs 标签页 over -->

</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function(){

        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
        });
        /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
            var $target=$(this).parents(".datagrid").find(".chartBar");
            if($(this).attr("date-select")=="chart"){
                $target.removeClass("hide");
            }else{
                $target.addClass("hide");
            }

        });
        /*数据列表与图表的切换*/
        $('#dg1').datagrid({
            onBeforeLoad: function(){
                var toolbar=$(this).datagrid("options").toolbar;
                var chartHeight=$(this).datagrid("options").height-$(toolbar).height();
                $(toolbar).children(".chartBar").height(chartHeight);

            }
        });
        /*数据列表与图表的切换*/
        $('#dg2').datagrid({
            onBeforeLoad: function(){
                var toolbar=$(this).datagrid("options").toolbar;
                var chartHeight=$(this).datagrid("options").height-$(toolbar).height();
                $(toolbar).children(".chartBar").height(chartHeight);

            }
        });
        /**/
        $("#tabs").tabs({
            onSelect:function(title,index){
                if(index==1){
                    doSearch2();
                }
            }
        });


    });



</script>
<script src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script src="${request.contextPath}/static/layer/layer.js"></script>
<script>
    $(function () {
        $('#startTime').datebox('setValue', getNowDate(365));
        $('#endTime').datebox('setValue', getNowDate(0));
        $('#startTime2').datebox('setValue', getNowDate(365));
        $('#endTime2').datebox('setValue', getNowDate(0));
        doSearch();
    })
    //国控
    function doSearch() {
        var startTime=$("#startTime").val();
        var endTime=$("#endTime").val();
        if(startTime==""||endTime==""){
            layer.msg("请按时间查询");
            return;
        }
        $.ajax({
            type : "GET",
            url : "${request.contextPath}/environment/waterExceeding/daysRatio",
            async : false,
            dataType : "json",
            data : {
                "start":startTime,
                "end":endTime,
                "category":1
            },
            success : function(data) {
                if(data[0].length==0){
                    layer.msg("国控断面暂无数据");
                    return;
                }
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('chartId'));
                // 指定图表的配置项和数据
                option = {
                    // title : {
                    //     text: '超标次数'
                    // },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['超标次数']
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            mark : {show: true},
                            dataView : {show: true, readOnly: false},
                            magicType : {show: true, type: ['line', 'bar']},
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    calculable : true,
                    xAxis : [
                        {
                            type : 'category',
                            boundaryGap : false,
                            data : data[0]
                        }
                    ],
                    yAxis :{},
                    series : [
                        {
                            name:'超标次数',
                            type:'line',
                            data:data[1]
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
                var result=data[2];
                $("#monitoringTime").html(result[0].startEnd);
                $("#dg1").datagrid("loadData",result);
                var size=result.length;
                var areaContent1="";
                for(var i = 0; i <= size-1; i++){
                    if(i<=2){
                        areaContent1+="<div class='inline-block'><div class='inline-block'><span>"+result[i].name+"</span><span class='em'>"+result[i].day+"次</span></div></div>"
                    }
                }
                $("#area1").html(areaContent1);
                var areaContent2="";
                for(var j = size-1; j >=size-3; j--){
                    if(j>=0){
                        areaContent2+="<div class='inline-block'><div class='inline-block'><span>"+result[j].name+"</span><span class='em'>"+result[j].day+"次</span></div></div>"
                    }
                }
                $("#area2").html(areaContent2);
            }
        });
    }
    //省控
    function doSearch2() {
        var startTime=$("#startTime2").val();
        var endTime=$("#endTime2").val();
        if(startTime==""||endTime==""){
            layer.msg("请按时间查询");
            return;
        }
        $.ajax({
            type : "GET",
            url : "${request.contextPath}/environment/waterExceeding/daysRatio",
            async : false,
            dataType : "json",
            data : {
                "start":startTime,
                "end":endTime,
                "category":2
            },
            success : function(data) {
                if(data[0].length==0){
                    layer.msg("省控断面暂无数据");
                    return;
                }
                // 基于准备好的dom，初始化echarts实例
                var myChart = echarts.init(document.getElementById('chartId2'));
                // 指定图表的配置项和数据
                option = {
                    // title : {
                    //     text: '超标次数'
                    // },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['超标次数']
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            mark : {show: true},
                            dataView : {show: true, readOnly: false},
                            magicType : {show: true, type: ['line', 'bar']},
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    calculable : true,
                    xAxis : [
                        {
                            type : 'category',
                            boundaryGap : false,
                            data : data[0]
                        }
                    ],
                    yAxis :{},
                    series : [
                        {
                            name:'超标次数',
                            type:'line',
                            data:data[1]
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
                var result=data[2];
                $("#monitoringTime2").html(result[0].startEnd);
                $("#dg2").datagrid("loadData",result);
                var size=result.length;
                var areaContent1="";
                for(var i = 0; i <= size-1; i++){
                    if(i<=2){
                        areaContent1+="<div class='inline-block'><div class='inline-block'><span>"+result[i].name+"</span><span class='em'>"+result[i].day+"次</span></div></div>"
                    }
                }
                $("#area12").html(areaContent1);
                var areaContent2="";
                for(var j = size-1; j >=size-3; j--){
                    if(j>=0){
                        areaContent2+="<div class='inline-block'><div class='inline-block'><span>"+result[j].name+"</span><span class='em'>"+result[j].day+"次</span></div></div>"
                    }
                }
                $("#area22").html(areaContent2);
            }
        });
    }
    //国控
    function doReset() {
        $("#searchBar1").find("#searchForm1").form('reset');
    }
    //省控
    function doReset2() {
        $("#searchBar2").find("#searchForm2").form('reset');
    }
    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay * 60000 * 60 * 24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var date = d.getDate();
        if (date >= 0 && date <= 9) {
            date = "0" + date;
        }
        var hours = d.getHours();
        if (hours >= 0 && hours <= 9) {
            hours = "0" + hours;
        }
        var minutes = d.getMinutes();
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        var seconds = d.getSeconds();
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
        return currentdate;
    }
</script>
</html>