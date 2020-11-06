<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>AQI数据分析-省数据分析-大气环境</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
    <!-- tabs 标签页 -->
    <div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>
        <!-- 标签页——1 -->
        <div title="省实时监测" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar1">
                    <!-- 搜索栏 -->
                    <div id="searchBar1" class="searchBar">
                        <form id="searchForm1">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'post',
									editable:false,
									valueField:'uuid',
						          textField:'name',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>

                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary"
                               data-options="iconCls:'icon-search'"
                               onclick="searchChartOrText ()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset()">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->

                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="watchDayNum"></span>
                            </div>

                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名前三</div>
                                <div class="cell-content" id="frontRank" style="height: 35px">

                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名后三</div>
                                <div class="cell-content" id="leanback" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->
                    <!-- 标题栏 -->
                    <div class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div id="chartTextChange" class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">AQI数据分析</h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group" class="radio-button-group style-btn-group">
                            <span class="active" id="hour">时</span>
                            <span id="day">日</span>
                            <span id="month">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出excel</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div id="charts" class="chart-box"></div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <!-- 数据列表-->
                <table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       url="${request.contextPath}/enviromonit/airHourData/list"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="rowRank" width="190px" formatter="formatterRank">排名</th>
                        <th field="timeCount" width="190px" formatter="formatTime">监测时间</th>
                        <th field="regionName" width="190px">地区名称</th>
                        <th field="pointName" width="190px">监测站点</th>
                        <th field="aqi" width="170px" formatter="Ams.tooltipFormat">综合指数</th>
                        <th field="countday" width="170px">有效天数</th>
                        <th field="codeRegion" width="170px">地区编码</th>
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->
        <div title="自建实时监测" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar2">
                    <!-- 搜索栏 -->
                    <div id="searchBar2" class="searchBar">
                        <form id="searchForm2">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName2"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'post',
									editable:false,
									valueField:'uuid',
						          textField:'name',
									multiple:true,
									panelHeight:'350px'"
                                       style="width:200px;"/>
                            </div>
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime2" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime2" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>

                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary"
                               data-options="iconCls:'icon-search'"
                               onclick="searchChartOrText2 ()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset()">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->

                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="watchDayNum2"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名前三</div>
                                <div class="cell-content" id="frontRank2" style="height: 35px">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">AQI排名后三</div>
                                <div class="cell-content" id="leanback2" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->
                    <!-- 标题栏 -->
                    <div class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div id="chartTextChange2" class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span>文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">AQI数据分析</h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group2" class="radio-button-group style-btn-group">
                            <span class="active" id="hour2">时</span>
                            <span id="day2">日</span>
                            <span id="month2">月</span>
                            <span id="year2">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出excel</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div id="charts2" class="chart-box"></div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->
                <!-- 数据列表-->
                <table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
                       url="${request.contextPath}/enviromonit/airHourData/list"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="rowRank" width="190px" formatter="formatterRank">排名</th>
                        <th field="timeCount" width="190px" formatter="formatTime">监测时间</th>
                        <th field="regionName" width="190px">地区名称</th>
                        <th field="pointName" width="190px">监测站点</th>
                        <th field="aqi" width="170px" formatter="Ams.tooltipFormat">综合指数</th>
                        <th field="countday" width="170px">有效天数</th>
                        <th field="codeRegion" width="170px">地区编码</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——2 over-->


    </div>
    <!-- tabs 标签页 over -->

</div>
</body>
<script>
    var url = '/enviromonit/airHourData/list';
    var pointType = 0;//0省监测站点1县区2自建使用的是0和2;
    var flag = 'hour';
    var flag2 = 'hour';
    var chartOrText = 0;//显示图表还是显示文字
    var chartOrText2 = 0;//显示图表还是显示文字
    var title;
    var title1;
    var title2;
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    $(function () {
        $('#startTime').datebox('setValue', getNowDate(6));
        $('#endTime').datebox('setValue', getNowDate(0));
        getAQIRank(0, "front");//AQI排名前三的数据;
        getAQIRank(0, "leanback")//AQI排名后三的数据;
        doSearchCharts();

        /*单选按钮组*/
        $("#chartTextChange").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).text() == '文字') {
                chartOrText = 1;
                doSearch();
            } else if ($(this).text() == '图表') {
                chartOrText = 0;
                doSearchCharts();
            }
        });
        /*时日月单选按钮组*/
        $("#group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).context.id == 'hour') {
                flag = 'hour';
                url = '/enviromonit/airHourData/list';
                getAQIRank(0, "front");//AQI排名前三的数据;
                getAQIRank(0, "leanback")//AQI排名后三的数据;
            }
            if ($(this).context.id == 'day') {
                flag = 'day';
                url = '/enviromonit/airDayData/list';
                getAQIRank(0, "front");//AQI排名前三的数据;
                getAQIRank(0, "leanback")//AQI排名后三的数据;
            }
            if ($(this).context.id == 'month') {
                flag = 'month';
                url = '/enviromonit/airHourData/listMonth';
                getAQIRank(0, "front");//AQI排名前三的数据;
                getAQIRank(0, "leanback")//AQI排名后三的数据;
            }
            if ($(this).context.id == 'year') {
                flag = 'year';
                url = '/enviromonit/airHourData/listMonth';
                getAQIRank(0, "front");//AQI排名前三的数据;
                getAQIRank(0, "leanback")//AQI排名后三的数据;
            }
            if (chartOrText == 0) {
                doSearchCharts();
            } else {
                doSearch();
            }
        });
        $(".change-chart").on("click", "span", function () {
            console.log($(this).attr("date-select"));
            var $target = $(this).parents(".datagrid").find(".chartBar");
            if ($(this).attr("date-select") == "chart") {
                $target.removeClass("hide");
            } else {
                $target.addClass("hide");
            }

        });
        /*数据列表与图表的切换*/
        $('#dg1').datagrid({
            onBeforeLoad: function () {
                var toolbar = $(this).datagrid("options").toolbar;
                var chartHeight = $(this).datagrid("options").height - $(toolbar).height();
                $(toolbar).children(".chartBar").height(chartHeight);
            }
        });

        /*
        *0为省控
        * 2为自建
        * */
        $("#tabs").tabs(
            {
                onSelect: function (title, index) {
                    if (index == 0) {//省控
                        pointType = 0;
                    }
                    if (index == 1) {//自建
                        pointType = 2;
                        doSearchCharts();//点击自建加载一次
                        $('#dg2').datagrid({
                            onBeforeLoad: function () {
                                var toolbar = $(this).datagrid("options").toolbar;
                                var chartHeight = $(this).datagrid("options").height - $(toolbar).height();
                                $(toolbar).children(".chartBar").height(chartHeight);
                            }
                        });
                    }
                }
            });
    });

    function getAQIRank(pointType, sort) {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var targetFlag=flag;
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
            targetFlag=flag2;
        }
        $.ajax({
            url: "/enviromonit/airPrimaryPollutant/getAQIDataRank",
            type: "POST",
            dataType: 'json',
            data: {
                "sort": sort,
                "startTime": startTime,
                "endTime": endTime,
                "pointType": pointType,
                timeType:targetFlag
            },
            success: function (data) {
                getAQISpanRow(data, sort);
            }
        })
    }

    function getAQISpanRow(data, sort) {
        var newRow = "";
        title = "";
        for (var i = 0; i < data.length; i++) {
            if (i == 3) {
                break;
            }
            title += data[i].pointName + ":" + data[i].aqi;
            newRow += '<div class="inline-block"><div class="inline-block">';
            newRow += '<span> ' + data[i].pointName + ':</span>';
            newRow += '<span class="em"> ' + Ams.formatNum(data[i].aqi) + '</span>';
            newRow += '</div>';
            newRow += '<div class="inline-block"><span>首污:</span>';
            newRow += '<span class="em"> ' + (data[i].major).replace("pm25", "pm2.5") + '</span></div></div>';
        }
        if (pointType == 0) {
            if (sort == "front") {
                $("#frontRank").html(newRow);
                $("#frontRank2").html(newRow);
                title1 = title;
            } else {
                $("#leanback").html(newRow);
                $("#leanback2").html(newRow);
                title2 = title;
            }
        } else {
            if (sort == "front") {
                title1 = title;
                $("#frontRank2").html(newRow);
            } else {
                $("#leanback2").html(newRow);
                title2 = title;
            }
        }
    }

    function jcsjFormat(value) {
        if (flag == 'hour') {
            return Ams.timeDateFormat(value);
        }
        if (flag == 'day') {
            return Ams.stdDateFormat(value);
        }
        if (flag == 'month') {
            return Ams.dateMonthFormat(value);
        }
        if (flag == 'year') {
            return Ams.dateYearFormat(value);
        }
    }

    function doSearch() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var dgId = "#dg1"
        var regionNameId = "#regionName";
        var totalFlag = flag;
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
            dgId = "#dg2"
            regionNameId = "#regionName2"
            totalFlag = flag2;
            getAQIRank(2, "front");//AQI排名前三的数据;
            getAQIRank(2, "leanback")//AQI排名后三的数据;
        }else{
            getAQIRank(0, "front");//AQI排名前三的数据;
            getAQIRank(0, "leanback")//AQI排名后三的数据;
        }
        $(dgId).datagrid({
            url: Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getAQIText",
            queryParams: {
                codeRegion: $(regionNameId).val().trim(),
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                timeType: flag
            }
        });
        if (pointType == 0) {
            if (flag == "hour")
                $("#watchDayNum").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchDayNum").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchDayNum").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchDayNum").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        } else {
            if (flag2 == "hour")
                $("#watchDayNum2").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag2 == "day") {
                $("#watchDayNum2").text(startTime + "~" + endTime)
            }
            if (flag2 == "month") {
                $("#watchDayNum2").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag2 == "year") {
                $("#watchDayNum2").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        }
    }

    function doSearchCharts() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var regionNameId = "#regionName";
        var charId = "charts";
        var totalFlag = flag;
        var charTitle = "省AQI实时监测";
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
            regionNameId = "#regionName2";
            charId = "charts2";
            charTitle = "自建监测AQI"
            totalFlag = flag2;
            getAQIRank(2, "front");//AQI排名前三的数据;
            getAQIRank(2, "leanback")//AQI排名后三的数据;
        }else{
            getAQIRank(0, "front");//AQI排名前三的数据;
            getAQIRank(0, "leanback")//AQI排名后三的数据;
        }
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAQIEchart',
            data: {
                codeRegion: $(regionNameId).val().trim(),
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                timeType: totalFlag
            },
            success: function (result) {
                var charts = echarts.init(document.getElementById(charId));
                setCharts(charts, charTitle, result.pointName, result.aqi, result.colorList);
            }
        });
        if (pointType == 0) {
            if (flag == "hour")
                $("#watchDayNum").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchDayNum").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchDayNum").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchDayNum").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        } else {
            if (flag2 == "hour")
                $("#watchDayNum2").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag2 == "day") {
                $("#watchDayNum2").text(startTime + "~" + endTime)
            }
            if (flag2 == "month") {
                $("#watchDayNum2").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag2 == "year") {
                $("#watchDayNum2").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        }
    }

    //图表数据插入
    function setCharts(charts, title, xAxis, series, colorList) {
        charts.clear();
        var option = {
            title: {
                text: title
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: ''        // 默认为直线，可选为：'line' | 'shadow'  设置‘’去除倒影
                },
                formatter: function (params) {
                    var htmlStr = '<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[0].color + ';"></span>';
                    htmlStr += params[0].seriesName + ': ' + params[0].value + '<br/>';
                    htmlStr += '</div>';
                    return htmlStr;
                }

            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}

                }
            },
            formatter: function (value) {
                return value.split(",")[0].split('').join('\n');
            },
            xAxis: [
                {
                    type: 'category',
                    data: xAxis,
                    axisLabel: {
                        type: 'category',
                        interval: 0,
                        formatter: function (value, index) {//格式化文本标签
                            return (index + 1) + '\n' + value.split(",")[0].split('').join('\n');
                        },
                        textStyle: {
                            fontSize: 15      //更改坐标轴文字大小
                        }
                    }
                }

            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [{
                name: "AQI",
                type: "bar",
                data: series,
                itemStyle: {
                    normal: {
                        label: {
                            show: true, //开启显示
                            position: 'top', //在上方显示
                            textStyle: { //数值样式
                                color: 'black',
                                fontSize: 16
                            }
                        }, color: function (params) {
                            return colorList[params.dataIndex];
                        }
                    }
                },
            }]
        };
        charts.setOption(option);
    }

    function searchChartOrText() {
        if (chartOrText == 0) {
            doSearchCharts();
        } else if (chartOrText == 1) {
            doSearch();
        }


    }

    function searchChartOrText2() {
        if (chartOrText2 == 0) {
            doSearchCharts();
        } else if (chartOrText2 == 1) {
            doSearch();
        }
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

    //自建监测数据处理

    $(function () {
        $('#startTime2').datebox('setValue', getNowDate(6));
        $('#endTime2').datebox('setValue', getNowDate(0));
        /*单选按钮组*/
        $("#chartTextChange2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).text() == '文字') {
                chartOrText2 = 1;
                doSearch();
            } else if ($(this).text() == '图表') {
                chartOrText2 = 0;
                doSearchCharts();
            }
        });
        /*时日月单选按钮组*/
        $("#group2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            pointType = 2;//0省监测站点1县区2自建使用的是0和2;
            if ($(this).context.id == 'hour2') {
                flag2 = 'hour';
                url = '/enviromonit/airHourData/list';
            }
            if ($(this).context.id == 'day2') {
                flag2 = 'day';
                url = '/enviromonit/airDayData/list';
            }
            if ($(this).context.id == 'month2') {
                flag2 = 'month';
                url = '/enviromonit/airHourData/listMonth';

            }
            if ($(this).context.id == 'year2') {
                flag2 = 'year';
                url = '/enviromonit/airHourData/listMonth';
            }
            if (chartOrText2 == 0) {
                doSearchCharts();
            } else {
                doSearch();
            }
        });
    });

    /**
     * 重置按钮
     */
    function doReset() {
        if (pointType == 0) {
            $("#searchForm1").form('clear');
        } else {
            $("#searchForm2").form('clear');
        }
        searchChartOrText();
    }

    //====表格排名显示
    function formatterRank(val, row, index) {
        return "<span title='" + index + 1 + "'>" + (index + 1) + "</span>";
    }//====表格排名显示
    function formatTime(val, row, index) {
        return "<span>" + getjsTime() + "</span>";
    }

    /**
     * 导出省控数据excel
     */
    function exportExl() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var u = "/enviromonit/airPrimaryPollutant/getAQIText";
        var totalTitle = title1 + ";" + title2;
        var totalTimeType = flag;
        var regionNameId = "#regionName";
        if (pointType == 2) {
            regionNameId = "#regionName2";
            totalTimeType = flag2;
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim()
        }
        window.location.href = u + "?startTime=" + startTime + "&codeRegion=" + $(regionNameId).val().trim() + "&timeType=" + totalTimeType + "&endTime=" + endTime + "&start=" + flag + "&exportExl=exportExl" + "&exportTitle=" + totalTitle;
    }

    function getjsTime() {
        var jcTime = "";
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        if (pointType == 0) {
            if (flag == "hour")
                jcTime = startTime + " 00:00" + "~" + endTime + " 23:59";
            if (flag == "day") {
                jcTime = startTime + "~" + endTime
            }
            if (flag == "month") {
                jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if (flag == "year") {
                jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
            }
        } else {
            if (flag2 == "hour")
                jcTime = startTime + " 00:00" + "~" + endTime + " 23:59";
            if (flag2 == "day") {
                jcTime = startTime + "~" + endTime;
            }
            if (flag2 == "month") {
                jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7)
            }
            if (flag2 == "year") {
                jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4)
            }
        }
        return jcTime;
    }
</script>
</html>