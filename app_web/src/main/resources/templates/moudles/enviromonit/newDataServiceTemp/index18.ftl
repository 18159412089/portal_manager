<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>超标天数比例-省数据分析-大气环境</title>

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
                                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
                                <label>-</label>
                                <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
                            </div>

                            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary"
                               data-options="iconCls:'icon-search'"
                               onclick="dosearchChartOrText()">查询</a>
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
                                <span class="control-content" id="watchTime">2019年06月</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">超标天数排名前三</div>
                                <div class="cell-content" id="frontRank">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>漳州市：</span>
                                            <span class="em">9</span>天
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙海市：</span>
                                            <span class="em">19</span>天
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙海市：</span>
                                            <span class="em">9</span>天
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">超标天数排名后三</div>
                                <div class="cell-content" id="leanback">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙海市：</span>
                                            <span class="em">9</span>天
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙海市：</span>
                                            <span class="em">9</span>天
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙海市：</span>
                                            <span class="em">9</span>天
                                        </div>
                                    </div>
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

                        <h2 class="title">超标天数比例<span class="subtitle" id="watchDayNum">监测天数：30天</span></h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group">
                            <span class="active">月</span>
                            <span>年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出Excel</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="chart-box" id="charts"></div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="rowrank" width="190px" formatter="formatterRank">排名</th>
                        <th field="showTime" width="190px" formatter="formatTime">监测时间</th>
                        <th field="regionName" width="100">地区名称</th>
                        <th field="countday" width="100">有效监测天数</th>
                        <th field="count" width="100">超标天数</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->
        <#--   <div title="自建实时监测" style="padding:10px">
               自建实时监测
           </div>-->
        <!-- 标签页——2 over-->


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
    var pointType = 0;
    var flag = "month";
    var chartOrText = 0;
    var chartRequest = 0;
    var textRequest = 0;
    var title = "";
    var title2 = "";
    $(function () {
        $('#startTime').datebox('setValue', getNowDate(200));
        $('#endTime').datebox('setValue', getNowDate(0));
        getAQIExcessDataSpanRow(pointType, "front")
        getAQIExcessDataSpanRow(pointType, "leanback")
        doSearchCharts();
        countWatchTime();
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            if ($(this).text() == "月") {
                flag = "month";
                if (chartOrText == 0) {
                    doSearchCharts();
                } else {
                    doSearch()
                }
                countWatchTime();
            }
            if ($(this).text() == "年") {
                flag = "year";
                if (chartOrText == 0) {
                    doSearchCharts();
                } else {
                    doSearch()
                }
                countWatchTime();
            }
            if ($(this).text() == "图表") {
                chartOrText = 0;
                if (chartRequest == 0) {
                    doSearchCharts()
                    chartRequest = 1;
                }

            }
            if ($(this).text() == "文字") {
                chartOrText = 1;
                if (textRequest == 0) {
                    doSearch()
                    textRequest = 1;
                }

            }
            $(this).addClass("active");

        });
        /*切换图表和文字*/
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

        /**/
        $("#tabs").tabs({
            onSelect: function (title, index) {
                console.log(index);
            }
        });


    });

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

    //获取各因子的首三位和后三位的平均值;===============================================================================
    function getAQIExcessDataSpanRow(pointType, sort) {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        $.ajax({
            url: "/enviromonit/airPrimaryPollutant/getAQIExcessRank",
            type: "POST",
            dataType: 'json',
            data: {
                sort: sort,
                startTime: startTime,
                endTime: endTime,
                pointType: pointType,
                timeType: flag,
            },
            success: function (data) {
                console.log(data)
                getAQIExcessSpanRow(data, sort);
            }
        })
    }

    function getAQIExcessSpanRow(data, sort) {
        var newRow = '';
        var title1 = "";
        for (var i = 0; i < data.length; i++) {
            title1 += data[i].regionName;
            title1 += data[i].count;
            newRow += '<div class="inline-block"><div class="inline-block">';
            newRow += '<span> ' + data[i].regionName + ':</span>';
            newRow += '<span class="em"> ' + Ams.formatNum(data[i].count) + '</span>';
            newRow += '</div>';
        }
        if (pointType == 0) {
            if (sort == "front") {
                title = "超标天数排名前三:" + title1;
                $("#frontRank").empty()
                $("#frontRank").append(newRow);
            } else {
                title2 = "超标天数排名后三:" + title1;
                $("#leanback").empty();
                $("#leanback").append(newRow);
            }
        }

    }

    function doSearchCharts() {
        var charId = "charts";
        var charTitle = "省AQI超标天数";
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        if (pointType == 0) {
            if (flag == "hour")
                $("#watchTime").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchTime").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchTime").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchTime").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        } else {
            if (flag == "hour")
                $("#watchTime").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchTime").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchTime").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchTime").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        }
        countWatchTime();
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAQIExcessEchart',
            data: {
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                timeType: flag
            },
            async: true,
            success: function (result) {
                var charts = echarts.init(document.getElementById(charId));
                setCharts(charts, charTitle, result.regionName, result.count, result.colorList);
            }
        });

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
                    htmlStr +=   '超标天数: ' + params[0].value + '天<br/>';
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
                        // rotate:60,
                        // formatter:function(value) {
                        //     value=value.split(",")[0];
                        //     return value;
                        // },
                        //横坐标文字竖着
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

    function doSearch() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var dgId = "#dg1"
        $(dgId).datagrid({
            url: Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getAQIExcessText",
            queryParams: {
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                timeType: flag
            }
        });
        if (pointType == 0) {
            if (flag == "hour")
                $("#watchTime").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchTime").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchTime").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchTime").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        } else {
            if (flag == "hour")
                $("#watchTime").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day") {
                $("#watchTime").text(startTime + "~" + endTime)
            }
            if (flag == "month") {
                $("#watchTime").text(startTime.substr(0, 7) + "~" + endTime.substr(0, 7))
            }
            if (flag == "year") {
                $("#watchTime").text(startTime.substr(0, 4) + "~" + endTime.substr(0, 4))
            }
        }
        countWatchTime();
    }

    function dosearchChartOrText() {
        doSearchCharts();
        doSearch();
        getAQIExcessDataSpanRow(pointType, "front");
        getAQIExcessDataSpanRow(pointType, "leanback");
    }

    /**
     * 重置按钮
     */
    function doReset() {
        $("#searchForm1").form('clear');
        searchChartOrText();
    }

    //====表格排名显示
    function formatterRank(val, row, index) {
        return "<span title='" + index + 1 + "'>" + (index + 1) + "</span>";
    }//====表格排名显示
    function formatTime(val, row, index) {
        return "<span title='" + $("#endTime").val().trim() + "'>" + getjsTime() + "</span>";
    }

    /**
     * 导出省控数据excel
     */
    function exportExl() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var u = "/enviromonit/airPrimaryPollutant/getAQIExcessText";
        var totalTitle = title + title2;
        window.location.href = u + "?startTime=" + startTime + "&endTime=" + endTime + "&start=" + flag + "&exportExl=exportExl" + "&exportTitle=" + totalTitle;
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
    function countWatchTime(){
        var watchTime=getjsTime().split("~");
        if(watchTime[0].length<=4){
            $("#watchDayNum").text("   监测天数：" + (Math.abs(Ams.datedifference(watchTime[0], watchTime[1]-1)) + 1) + '天');
        }else{
            $("#watchDayNum").text("   监测天数：" + (Math.abs(Ams.datedifference(watchTime[0], watchTime[1])) + 1) + '天');
        }
    }
</script>
</html>