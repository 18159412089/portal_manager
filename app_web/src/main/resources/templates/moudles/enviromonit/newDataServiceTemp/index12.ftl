<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>均值比较分析-省数据分析-大气环境</title>

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
                        <form id="searchForm">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
									method:'get',
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
                               onclick="doCx('')">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset('')">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->

                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="jcsj"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">均值排名前三</div>
                                <div class="cell-content" id="bottomThree" style="height: 35px">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">均值排名后三</div>
                                <div class="cell-content" id="topThree" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->
                    <!-- 标题栏 -->
                    <div id="titleBar" class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">均值比较分析</h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group" class="radio-button-group style-btn-group">
                            <span id="day" class="active">日</span>
                            <span id="month">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('')">导出EXECL</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="optionBar tc">
                            <!-- 单选按钮组 -->
                            <div id="factoryBar" class="radio-button-group style-btn-group">
                                <span class="active">PM2.5</span>
                                <span>PM10</span>
                                <span>NO2</span>
                                <span>CO</span>
                                <span>O3</span>
                                <span>SO2</span>
                            </div>
                            <!-- 单选按钮组 over-->
                        </div>
                        <div id="char" class="chart-box"></div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="pm" width="190px" formatter="orderNm">排名</th>
                        <th field="monitorTime" width="190px" formatter="forTime">监测时间</th>
                        <th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区</th>
                        <th field="pointName" width="170px" formatter="Ams.tooltipFormat">监测站点</th>
                        <!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
                        <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
                        <th field="aqi" width="160px" styler="Ams.setAQIBackground">均值</th>
                        <th field="efday" width="160px" id="" formatter="Ams.tooltipFormat">有效监测天数</th>
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
        <div title="自建实时监测" style="padding:10px">
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar2">
                    <!-- 搜索栏 -->
                    <div id="searchBar2" class="searchBar">
                        <form id="searchForm2">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="regionName2"
                                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getPointListByType?pointType=2',
									method:'post',
									editable:false,
									valueField:'id',
									textField:'text',
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
                               onclick="doCx('2')">查询</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                               data-options="iconCls:'icon-arrow_refresh_small'"
                               onclick="doReset('2')">重置</a>
                        </form>
                    </div>
                    <!-- 搜索栏 over-->

                    <!-- 数据信息 -->
                    <div class="data-info-layout">
                        <div class="other">
                            <div class="inline-block">
                                <span class="control-label">监测时间：</span>
                                <span class="control-content" id="jcsj2"></span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="item col-xs-6">
                                <div class="cell-title">均值排名前三</div>
                                <div class="cell-content" id="bottomThree2" style="height: 35px">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">均值排名后三</div>
                                <div class="cell-content" id="topThree2" style="height: 35px">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- 数据信息  over-->
                    <!-- 标题栏 -->
                    <div id="titleBar2" class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">均值比较分析</h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group2" class="radio-button-group style-btn-group">
                            <span id="day" class="active">日</span>
                            <span id="month">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('2')">导出EXECL</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
                        <div class="optionBar tc">
                            <!-- 单选按钮组 -->
                            <div id="factoryBar2" class="radio-button-group style-btn-group">
                                <span class="active">PM2.5</span>
                                <span>PM10</span>
                                <span>NO2</span>
                                <span>CO</span>
                                <span>O3</span>
                                <span>SO2</span>
                            </div>
                            <!-- 单选按钮组 over-->
                        </div>
                        <div id="char2" class="chart-box"></div>
                    </div>
                    <!-- 图表栏 over-->

                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg2" class="easyui-datagrid" url="" toolbar="#toolbar2"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="pm" width="190px" formatter="orderNm">排名</th>
                        <th field="monitorTime" width="190px" formatter="forTime">监测时间</th>
                        <th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区</th>
                        <th field="pointName" width="170px" formatter="Ams.tooltipFormat">监测站点</th>
                        <!-- <th field="polluteName" width="120px" formatter="Ams.tooltipFormat">监测污染物</th>
                        <th field="avervalue" width="120px" formatter="Ams.tooltipFormat">监测值</th> -->
                        <th field="aqi" width="160px" styler="Ams.setAQIBackground">均值</th>
                        <th field="efday" width="160px" id="" formatter="Ams.tooltipFormat">有效监测天数</th>
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
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            $('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            $('#startTime2').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime2').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            doCx('');
        });
    };

    var pointCode = '';
    var flag = 'day';
    var flag2 = 'day';
    var pointType = '0';
    var url = '/enviromonit/airDayData/list';
    var url2 = '/enviromonit/airDayData/list';
    var title = '省数据分析-气省均值比较（小时）数据==>';
    var title2 = '省数据分析-气自建均值比较（小时）数据==>';
    var aqiText = '';
    var jcTime = startTime + " 00:00:00~" + endTime + " 23:59:59";
    var jcTime2 = startTime + " 00:00:00~" + endTime + " 23:59:59";

    $(function () {
        /*自建文字图表单选按钮组*/
        $("#factoryBar2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if (getTitle2() == "文字") {
                //doSearchWords();
            } else {
                doCx('2');
            }
        });
        /*省 文字秃瓢单选按钮组*/
        $("#factoryBar").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if (getTitle() == "文字") {
                //doSearchWords();
            } else {
                doCx('');
            }
        });
        /*省 单选按钮组*/
        $("#titleBar").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
        });
        /*自建单选按钮组*/
        $("#titleBar2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
        });


        /*自建单选按钮组*/
        $("#group2").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).context.id == 'day') {
                flag2 = 'day';
                url2 = '/enviromonit/airDayData/list';
                title2 = '省数据分析-气自建均值比较（日）数据==>';
                jcTime2 = startTime + "~" + endTime;
            }
            if ($(this).context.id == 'month') {
                flag2 = 'month';
                url2 = '/enviromonit/airHourData/listMonth';
                title2 = '省数据分析-气自建均值比较（月）数据==>';
                jcTime2 = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if ($(this).context.id == 'year') {
                flag2 = 'year';
                url2 = '/enviromonit/airHourData/listMonth';
                title2 = '省数据分析-气自建均值比较（年）数据==>';
                jcTime2 = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
            }
            doCx('2');
        });

        /*省单选按钮组*/
        $("#group").on("click", "span", function () {
            $(this).siblings("span").removeClass("active");
            $(this).addClass("active");
            if ($(this).context.id == 'day') {
                flag = 'day';
                url = '/enviromonit/airDayData/list';
                title = '省数据分析-气省均值比较（日）数据==>' ;
                jcTime = startTime + "~" + endTime;
            }
            if ($(this).context.id == 'month') {
                flag = 'month';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气省均值比较（月）数据==>';
                jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if ($(this).context.id == 'year') {
                flag = 'year';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气省均值比较（年）数据==>';
                jcTime = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
            }
            doCx('');
        });

        /*切换图表和文字*/
        $(".change-chart").on("click", "span", function () {
            var $target = $(this).parents(".datagrid").find(".chartBar");
            if ($(this).attr("date-select") == "chart") {
                $target.removeClass("hide");
            } else {
                $target.addClass("hide");
            }

        });
        /*数据列表与图表的切换*/
        $('#dg').datagrid({
            onBeforeLoad: function () {
                var toolbar = $(this).datagrid("options").toolbar;
                var chartHeight = $(this).datagrid("options").height - $(toolbar).height();
                $(toolbar).children(".chartBar").height(chartHeight);

            }
        });
        /*数据列表与图表的切换*/
        $('#dg2').datagrid({
            onBeforeLoad: function () {
                var toolbar = $(this).datagrid("options").toolbar;
                var chartHeight = $(this).datagrid("options").height - $(toolbar).height();
                $(toolbar).children(".chartBar").height(chartHeight);

            }
        });


        /*省 自建切换事件*/
        $("#tabs").tabs({
            onSelect: function (title, index) {
                if (index == 0) {
                    pointType = '0';
                    ssOrzj= '';
                    doCx('');
                }
                if (index == 1) {
                    pointType = '';
                    ssOrzj= '2';
                    doCx('2');
                }
            }
        });


    });

    /**
     * 查询事件
     * @param    idx  ''为省  2为自建
     */
    var startTime = '';
    var endTime = '';
    var time ='';
    var codeRegion;
    var code;
    var ssOrzj= '';
    function doCx(idx) {
       var loadIndex = layer.load(1, {
            shade: [0.1, '#fff']
        });
        startTime = $("#startTime" + idx).val().trim();
        endTime = $("#endTime" + idx).val().trim();
        if (startTime == "" || endTime == "") {
            $.messager.alert('提示', '时间区间不允许为空！');
            return;
        }
        var a = flag;
        var b = url;
        time = jcTime;
        var factory = getFactory();
        if (idx == '2') {
            a = flag2;
            b = url2;
            time = jcTime2;
            factory = getFactory2();
        }
        time = setJcsj(a);
        if (time.indexOf('defined') > -1) time = startTime + ' 00:00:00~' + endTime + ' 23:59:59';
        $('#jcsj' + idx).text(time);
       codeRegion = idx == '2' ? "" : $("#regionName" + idx).val().trim();
       code = idx == '' ? "" : $("#regionName" + idx).val().trim();
        if (Ams.isNoEmpty(startTime) && Ams.isNoEmpty(endTime)) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAirMeanEchart',
                data: {
                    codeRegion: codeRegion,
                    pointCode: code,
                    pointType: pointType,
                    startTime: startTime,
                    endTime: endTime,
                    start: a,
                    end: factory
                },
                async: true,
                success: function (result) {
                    var charts = echarts.init(document.getElementById('char' + idx));
                    setCharts(charts, '均值比较分析', result.pointName, result.aqi, result.colorList,idx);
                    var top = result.topAndBottom.topAndBottom;
                    var bottomHtml = '';
                    var text = '';
                    aqiText = '';
                    for (var i = 0; i < top.length; i++) {
                        if (i == 3) break;
                        bottomHtml += '<div class="inline-block"><div class="inline-block">'
                            + '<span>' + top[i].pointName + factory + '：</span><span class="em">'
                            + top[i].aqi + '</span></div></div>';
                        text += top[i].pointName + factory + '：' +top[i].aqi + '；';
                    }
                    $("#bottomThree" + idx).html(bottomHtml);
                    aqiText+= '均值排名前三【' + text + '】';
                    var topHtml = "";
                    for (var i = top.length - 1; i >= 0; i--) {
                        if (i == top.length - 4) break;
                        topHtml += '<div class="inline-block"><div class="inline-block">'
                            + '<span>' + top[i].pointName + factory + '：</span><span class="em">'
                            + top[i].aqi + '</span></div></div>';
                        text += top[i].pointName + factory + '：' +top[i].aqi + '；';
                    }
                    $("#topThree" + idx).html(topHtml);
                    aqiText += '均值排名后三【' + text + '】';
                    layer.close(loadIndex);
                }
            });
            //表格数据加载
            $('#dg' + idx).datagrid({
                url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAirMeanEchartPage',
                queryParams: {
                    codeRegion: codeRegion,
                    pointCode: code,
                    pointType: pointType,
                    startTime: startTime,
                    endTime: endTime,
                    flag: a,
                    end: factory,
                    start: a

                }
            });
        }

    }

    function setJcsj(flag) {
        switch (flag) {
            case 'hour':
                return startTime + " 00:00:00~" + endTime + " 23:59:59";
                break;
            case 'day':
                return startTime + "~" + endTime;
                break;
            case 'month':
                return startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
                break;
            case 'year':
                return startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
                break;
            default:
                return startTime + " 00:00:00~" + endTime + " 23:59:59";
                break;
        }
    }


    //图表数据插入
    function setCharts(charts, charTitle, xAxis, series, colorList,idx) {
        charts.clear();
        var title = idx == '' ? 'factoryBar span.active' : 'factoryBar2 span.active';
        var option = {
            /*title: {
                text: charTitle,
                left: 'center',
                textStyle: {
                    color: '#464646',
                    fontSize:'19',
                    fontWeight:'normal'
                }
            },*/
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            formatter: function (value) {
                return value.split(",")[0].split('').join('\n');
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
                    htmlStr +=$("#"+title).text()+ ': ' + params[0].value + '<br/>';
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
            xAxis: [
                {
                    type: 'category',
                    data: xAxis,
                    axisLabel: {
                        type: 'category',
                        interval: 0,
                        // rotate:60,
                        // formatter:function(value, idx) {
                        //     value = value.split(",")[0].split('');
                        //     return value;
                        // },
                        //横坐标文字竖着
                        formatter: function (value, idx) {
                            return (idx + 1) + '\n' + value.split(",")[0].split('').join('\n');
                        },
                        textStyle: {
                            fontSize: 15      //更改坐标轴文字大小
                        }
                    }
                }

            ],
            yAxis: [
                {
                    type: 'value',
                    name: $("#"+title).text(),
                    nameTextStyle: {
                        color: '#2ba4e9',
                        fontSize: '12'
                    },
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


    /**
     * 重置按钮
     */
    function doReset(idx) {
        $("#searchForm" + idx).form('clear');
        $('#startTime' + idx).datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
        $('#endTime' + idx).datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
        doCx(idx);
    }

    /**
     * 因子切换
     * @returns {*|jQuery}
     */
    function getFactory() {
        return $("#factoryBar span.active").text();
    }

    /**
     * 因子切换
     * @returns {*|jQuery}
     */
    function getFactory2() {
        return $("#factoryBar2 span.active").text();
    }


    /**
     * 图表跟表格切换
     * @returns {*|jQuery}
     */
    function getTitle() {
        return $("#titleBar span.active").text();
    }

    /**
     * 图表跟表格切换
     * @returns {*|jQuery}
     */
    function getTitle2() {
        return $("#titleBar2 span.active").text();
    }

    /**
     * 时间格式化
     * @param value
     * @returns {*|string|*}
     */
    function forTime(value) {
        return time;

    }

    /**
     * 排名
     * @param value
     * @returns {*|string|*}
     */
    function orderNm(value, row, index) {
        var options = $("#dg" + ssOrzj).datagrid("getPager").data("pagination").options;
        var curr = options.pageNumber;
        if (curr == 0) return (index + 1);
        if (index >= 10) {
            return cur + index.substr(0, 1) + '' + index.substr(1, 1);
        }else {
            if (index == 9) {
                return curr + '0' ;
            } else {
                return (curr - 1 == 0 ? '' : curr - 1) + '' + (index + 1);
            }
        }
    }

    /**
     * 导出省控数据excel
     */
    function exportExlPro(idx){

        doCx(idx);
        // var regionName = $("#regionName"+idx).val().trim();
        var startTime= $("#startTime"+idx).val().trim();
        var endTime = $("#endTime"+idx).val().trim();
        var u = url;
        var f = flag;
        var tle = title+aqiText;
        var factory = getFactory();
        if (idx==2) {
            // u = url2;
            f = flag2;
            tle = title2+aqiText;
            factory = getTitle2();
        }
        u = '/enviromonit/airPrimaryPollutant/getAirMeanEchartPage';
        aqiText = '';
        window.location.href = u + "?codeRegion=" + codeRegion + "&pointCode=" + code + "&end=" + factory+ "&end=" + factory + "&startTime=" + startTime + "&endTime=" + endTime + "&pointType="+ pointType + "&start=" + f + "&exportExl=exportExl" + "&exportTitle=" + tle;
    }


</script>
</html>