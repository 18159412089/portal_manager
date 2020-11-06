<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>均值比较分析（按城市）-省数据分析-大气环境</title>

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
                               onclick="searchChartOrText()">查询</a>
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
                                <span class="control-content" id="watchDayNum">2019年06月</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6" id="frontRank">
                                <div class="cell-title">均值排名前三</div>
                                <div class="cell-content">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙文环保局：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>金峰管委会：</span>
                                            <span class="em">19</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>科华公司：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item col-xs-6" id="leanback">
                                <div class="cell-title">均值排名后三</div>
                                <div class="cell-content">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙文环保局：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>金峰管委会：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>科华公司：</span>
                                            <span class="em">9</span>
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

                        <h2 class="title">均值比较分析（按城市）</h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group">
                            <span class="active">日</span>
                            <span>月</span>
                            <span>年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出excel</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="optionBar tc">
                            <!-- 单选按钮组 -->
                            <div class="radio-button-group style-btn-group">
                                <span class="active">SO2</span>
                                <span>NO2</span>
                                <span>O3</span>
                                <span>PM10</span>
                                <span>PM2.5</span>
                                <span>CO</span>
                            </div>
                            <!-- 单选按钮组 over-->
                        </div>
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
                        <th field="regionname" width="290px">地区</th>
                        <th field="aqi" width="170px">平均值</th>
                        <th field="countday" width="190px">有效监测天数</th>
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
        <#--<div title="自建实时监测" >
            <!-- 数据列表页面 &ndash;&gt;
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致&ndash;&gt;
                <div id="toolbar2">
                    <!-- 搜索栏 &ndash;&gt;
                    <div id="searchBar1" class="searchBar">
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
                               onclick="searchChartOrText()">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset()">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over&ndash;&gt;

                    <!-- 数据信息 &ndash;&gt;
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="watchDayNum2">2019年06月</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6" id="frontRank2">
                                <div class="cell-title">均值排名前三</div>
                                <div class="cell-content">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙文环保局：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>金峰管委会：</span>
                                            <span class="em">19</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>科华公司：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item col-xs-6" id="leanback2">
                                <div class="cell-title">均值排名后三</div>
                                <div class="cell-content">
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>龙文环保局：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>金峰管委会：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                    <div class="inline-block">
                                        <div class="inline-block">
                                            <span>科华公司：</span>
                                            <span class="em">9</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over&ndash;&gt;
                    <!-- 标题栏 &ndash;&gt;
                    <div class="titleBar tc">
                        <!-- 单选按钮组 &ndash;&gt;
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over&ndash;&gt;

                        <h2 class="title">均值比较分析（按城市）</h2>

                    </div>
                    <!-- 标题栏 over &ndash;&gt;
                    <div class="optionBar">
                        <!-- 单选按钮组 &ndash;&gt;
                        <div class="radio-button-group style-btn-group">
                            <span class="active">日</span>
                            <span>月</span>
                            <span>年</span>
                        </div>
                        <!-- 单选按钮组 over&ndash;&gt;
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExl()">导出excel</a>
                    </div>

                    <!-- 图表栏&ndash;&gt;
                    <div class="chartBar">
                        <div class="optionBar tc">
                            <!-- 单选按钮组 &ndash;&gt;
                            <div class="radio-button-group style-btn-group">
                                <span class="active">SO2</span>
                                <span>NO2</span>
                                <span>O3</span>
                                <span>PM10</span>
                                <span>PM2.5</span>
                                <span>CO</span>
                            </div>
                            <!-- 单选按钮组 over&ndash;&gt;
                        </div>
                        <div class="chart-box" id="charts2"></div>
                    </div>
                    <!-- 图表栏 over&ndash;&gt;

                </div>
                <!-- 工具栏 over&ndash;&gt;

                <!-- 数据列表&ndash;&gt;
                <table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						rownumbers:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="rowrank" width="190px" formatter="formatterRank">排名</th>
                        <th field="showTime" width="190px" formatter="formatTime">监测时间</th>
                        <th field="regionname" width="290px">地区</th>
                        <th field="aqi" width="170px">平均值</th>
                        <th field="countday" width="190px">有效监测天数</th>
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下&ndash;&gt;
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over&ndash;&gt;
            </div>
            <!-- 数据列表页面 over&ndash;&gt;
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
    $.extend($.fn.datagrid.methods, {
        setColumnTitle: function (jq, option) {
            if (option.field) {
                return jq.each(function () {
                    var $panel = $(this).datagrid("getPanel");
                    var $field = $('td[field=' + option.field + ']', $panel);
                    if ($field.length) {
                        var $span = $("span", $field).eq(0);
                        $span.html(option.text);
                    }
                });
            }
            return jq;
        }
    });
    var url = '/enviromonit/airHourData/list';
    var pointType = 0;//0省监测站点1县区2自建使用的是0和2;
    var flag = 'day';
    var flag2 = 'day';
    var chartOrText = 0;//显示图表还是显示文字
    var chartOrText2 = 0;//显示图表还是显示文字
    var pointType = 0;//显示图表还是显示文字
    var factor = "SO2";
    var
        factor2 = "SO2";
    var title1="";
    var title2="";
    var title="";
    $(function () {
        $('#startTime').datebox('setValue', getNowDate(6));
        $('#endTime').datebox('setValue', getNowDate(0));
        $('#startTime2').datebox('setValue', getNowDate(6));
        $('#endTime2').datebox('setValue', getNowDate(0));
        doSearchCharts(factor);
        getFactorDataSpanRow(pointType, "front")
        getFactorDataSpanRow(pointType, "leanback")
        /*单选按钮组*/
        $(".radio-button-group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");//同一组的兄弟元素去除样式
            if ($(this).text() == "NO2") {
                if (pointType == 0) {
                    factor = "NO2";
                }
                if (pointType == 2) {
                    factor2 = "NO2";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "SO2") {
                if (pointType == 0) {
                    factor = "SO2";
                }
                if (pointType == 2) {
                    factor2 = "SO2";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "CO") {
                if (pointType == 0) {
                    factor = "CO";
                }
                if (pointType == 2) {
                    factor2 = "CO";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "CO2") {
                if (pointType == 0) {
                    factor = "CO2";
                }
                if (pointType == 2) {
                    factor2 = "CO2";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "NO") {
                if (pointType == 0) {
                    factor = "NO";
                }
                if (pointType == 2) {
                    factor2 = "NO";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "O3") {


                if (pointType == 0) {
                    factor = "O38";
                }
                if (pointType == 2) {
                    factor2 = "O38";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "PM2.5") {


                if (pointType == 0) {
                    factor = "PM25";
                }
                if (pointType == 2) {
                    factor2 = "PM25";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            } else if ($(this).text() == "PM10") {
                if (pointType == 0) {
                    factor = "PM10";
                }
                if (pointType == 2) {
                    factor2 = "PM10";
                }
                doSearchCharts(factor);
                getFactorDataSpanRow(pointType, "front")
                getFactorDataSpanRow(pointType, "leanback")
            }
            if ($(this).text() == "日") {//判断是否是在echart中进行选择还是在文字中进行选择
                if (pointType == 0) {
                    flag = 'day';
                }
                if (pointType == 2) {
                    flag2 = 'day';
                }
                url = '/enviromonit/airDayData/list';
                searchChartOrText();
            }
            if ($(this).text() == "月") {
                if (pointType == 0) {
                    flag = 'month';
                }
                if (pointType == 2) {
                    flag2 = 'month';
                }
                url = '/enviromonit/airHourData/listMonth';
                searchChartOrText();
            }
            if ($(this).text() == "年") {
                if (pointType == 0) {
                    flag = 'year';
                }
                if (pointType == 2) {
                    flag2 = 'year';
                }
                url = '/enviromonit/airHourData/listMonth';
                searchChartOrText();
            }
            if ($(this).text() == '文字') {
                if (pointType == 0) {
                    chartOrText = 1;
                } else {
                    chartOrText2 = 1;
                }
                doSearch();
            } else if ($(this).text() == '图表') {
                if (pointType == 0) {
                    chartOrText = 0;
                } else {
                    chartOrText2 = 0;
                }
                doSearchCharts(factor);
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
                        doSearchCharts(factor);
                        getFactorDataSpanRow(pointType, "front")
                        getFactorDataSpanRow(pointType, "leanback")
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

    function doSearchCharts(factor) {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var regionNameId = "#regionName";
        var charId = "charts";
        var charTitle = "省" + factor + "实时监测";
        var searchFlag = flag;
       var newfactor=factor;
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
            regionNameId = "#regionName2";
            charId = "charts2";
            charTitle = "自建监测AQI"
            searchFlag = flag2;
            newfactor=factor2;
        }
        getFactorDataSpanRow(pointType, "front")
        getFactorDataSpanRow(pointType, "leanback")
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getFactorRegionNameEchart',
            data: {
                codeRegion: $(regionNameId).val().trim(),
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                factor: newfactor,
                timeType: searchFlag
            },
            async: true,
            success: function (result) {
                var charts = echarts.init(document.getElementById(charId));
                setCharts(charts, charTitle, result.regionName, result.factor, result.colorList, factor);
            }
        });
        if (pointType == 0) {
            if (flag == "hour")
                $("#watchDayNum").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day"){
                $("#watchDayNum").text(startTime+"~" + endTime)
            }
            if (flag =="month"){
                $("#watchDayNum").text(startTime.substr(0,7)+"~" + endTime.substr(0,7))
            }
            if (flag=="year") {
                $("#watchDayNum").text(startTime.substr(0,4)+"~" + endTime.substr(0,4))
            }
        } else {
            if (flag == "hour")
                $("#watchDayNum2").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day"){
                $("#watchDayNum2").text(startTime+"~" + endTime)
            }
            if (flag =="month"){
                $("#watchDayNum2").text(startTime.substr(0,7)+"~" + endTime.substr(0,7))
            }
            if (flag=="year") {
                $("#watchDayNum2").text(startTime.substr(0,4)+"~" + endTime.substr(0,4))
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
                    htmlStr += factor + ': ' + params[0].value + '<br/>';
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
    function getFactorDataSpanRow(pointType, sort) {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
        }
        $.ajax({
            url: "/enviromonit/airPrimaryPollutant/getFactorRegionNameRank",
            type: "POST",
            dataType: 'json',
            data: {
                sort: sort,
                startTime: startTime,
                endTime: endTime,
                pointType: pointType,
                timeType: flag,
                factor: factor
            },
            success: function (data) {
                console.log(data)
                getFactorSpanRow(data, sort);
            }
        })
    }

    function getFactorSpanRow(data, sort) {
        var newRow="";
        if (sort =="front"){
            title1 = factor.replace("PM25", "PM2.5") + '均值排名前三:'
            newRow = '<div class="cell-title">' + factor.replace("PM25", "PM2.5") + '均值排名前三</div><div class="cell-content">';
        }else{
            title2 = factor.replace("PM25", "PM2.5") + '均值排名后三:'
            newRow = '<div class="cell-title">' + factor.replace("PM25", "PM2.5") + '均值排名后三</div><div class="cell-content">';
        }
       title="";
        for (var i = 0; i < data.length; i++) {
            title+=data[i].regionname+":"+data[i].aqi;
            newRow += '<div class="inline-block"><div class="inline-block">';
            newRow += '<span> ' + data[i].regionname + ':</span>';
            newRow += '<span class="em"> ' + Ams.formatNum(data[i].aqi) + '</span>';
            newRow += '</div>';
        }
        newRow += '</div></div>';
        if (pointType == 0) {
            if (sort == "front") {
                $("#frontRank").html(newRow);
                title1+=title;
            } else {
                title2+=title;
                $("#leanback").html(newRow);
            }
        } else {
            if (sort == "front") {
                title1+=title;
                $("#frontRank2").html(newRow);
            } else {
                title2+=title;
                $("#leanback2").html(newRow);
            }
        }
    }

    function doSearch() {
        var startTime = $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var dgId = "#dg1"
        var searchFlag = flag;
        var regionNameId = "#regionName";
        var newfactor=factor;
        if (pointType == 2) {
            startTime = $("#startTime2").val().trim();
            endTime = $("#endTime2").val().trim();
            dgId = "#dg2";
            regionNameId = "#regionName2";
            searchFlag = flag2;
            newfactor = factor2;
        }
        getFactorDataSpanRow(pointType, "front")
        getFactorDataSpanRow(pointType, "leanback")
        $(dgId).datagrid({
            url: Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getFactorRegionNameText",
            queryParams: {
                codeRegion: $(regionNameId).val().trim(),
                pointType: pointType,
                startTime: startTime,
                endTime: endTime,
                factor: newfactor,
                timeType: searchFlag
            }

        });
        var titlefactor=factor;
        if(pointType==2){
            titlefactor=factor2;
        }
        $(dgId).datagrid("setColumnTitle", {field: 'aqi', text: titlefactor.replace("O38","O3").replace("PM25","PM2.5") + "平均值"})



        if (pointType == 0) {
            if (flag == "hour")
                $("#watchDayNum").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day"){
                $("#watchDayNum").text(startTime+"~" + endTime)
            }
            if (flag =="month"){
                $("#watchDayNum").text(startTime.substr(0,7)+"~" + endTime.substr(0,7))
            }
            if (flag=="year") {
                $("#watchDayNum").text(startTime.substr(0,4)+"~" + endTime.substr(0,4))
            }
        } else {
            if (flag == "hour")
                $("#watchDayNum2").text(startTime + " 00:00" + "~" + endTime + " 23:59")
            if (flag == "day"){
                $("#watchDayNum2").text(startTime+"~" + endTime)
            }
            if (flag =="month"){
                $("#watchDayNum2").text(startTime.substr(0,7)+"~" + endTime.substr(0,7))
            }
            if (flag=="year") {
                $("#watchDayNum2").text(startTime.substr(0,4)+"~" + endTime.substr(0,4))
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

    //================根据时间和poinType进行年月日选择控制
    function searchChartOrText() {
        if (pointType == 0) {
            if (chartOrText == 0) {//选择图表加载
                doSearchCharts(factor)
            } else {
                doSearch();
            }
        } else if (pointType == 2) {
            if (chartOrText2 == 0) {//选择图表加载
                doSearchCharts(factor)
            } else {
                doSearch();
            }
        }
    }

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
            return "<span title='" + $("#endTime").val().trim() + "'>" + getjsTime()+ "</span>";
    }


    /**
     * 导出省控数据excel
     */
    function exportExl(){
    	
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var u = "/enviromonit/airPrimaryPollutant/getFactorRegionNameText";
        var totalTitle=title1+";"+title2;
        var totalFactor=factor;
        var totalTimeType=flag;
        if (pointType==2){
            totalTimeType=flag2;
            totalFactor=factor2;
        }
        window.location.href = u + "?startTime=" + startTime +"&timeType="+totalTimeType+"&factor="+totalFactor+ "&endTime=" + endTime + "&start=" + flag + "&exportExl=exportExl" + "&exportTitle="+totalTitle;
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