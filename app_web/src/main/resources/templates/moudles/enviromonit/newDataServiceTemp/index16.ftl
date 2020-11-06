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
                    <div id="searchBar" class="searchBar">
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
                                <div class="cell-title">优天数排名前三</div>
                                <div class="cell-content" id="bottomThree">
                                </div>
                            </div>
                            <div class="item col-xs-6">
                                <div class="cell-title">优天数排名后三</div>
                                <div class="cell-content" id="topThree">
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

                        <h2 class="title">优良天数比例<span class="subtitle" id="jcts">监测天数：</span></h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group" class="radio-button-group style-btn-group">
                            <span id="month" class="active">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('')">导出EXECL</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
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
                        <th field="regionName" width="170px" formatter="Ams.tooltipFormat">地区名称</th>
                        <th field="efday" width="160px" id="" formatter="Ams.tooltipFormat">有效监测天数</th>
                        <th field="excellent" width="120px" formatter="Ams.tooltipFormat">优天数</th>
                        <th field="good" width="120px" formatter="Ams.tooltipFormat">良天数</th>
                        <th field="mild" width="120px" formatter="Ams.tooltipFormat">轻度污染天数</th>
                        <th field="moderate" width="120px" formatter="Ams.tooltipFormat">中度污染天数</th>
                        <th field="severe" width="120px" formatter="Ams.tooltipFormat">重度以上污染天数</th>
                    </tr>
                    </thead>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
        </div>
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->

        <!-- 标签页——2 over-->


    </div>
    <!-- tabs 标签页 over -->
    <div style="display: none;">
        <div title="自建实时监测"  style="display: none;padding:10px">
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
                                <div class="cell-content" id="bottomThree2">
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
                            <div class="item col-xs-6">
                                <div class="cell-title">均值排名后三</div>
                                <div class="cell-content" id="topThree2">
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
                    <div id="titleBar2" class="titleBar tc">
                        <!-- 单选按钮组 -->
                        <div class="radio-button-group style-btn-group change-chart fr">
                            <span class="active" date-select="chart">图表</span>
                            <span date-select="text">文字</span>
                        </div>
                        <!-- 单选按钮组 over-->

                        <h2 class="title">优良天数比例<span class="subtitle">监测天数：30天</span></h2>

                    </div>
                    <!-- 标题栏 over -->
                    <div class="optionBar">
                        <!-- 单选按钮组 -->
                        <div id="group2" class="radio-button-group style-btn-group">
                            <span id="month" class="active">月</span>
                            <span id="year">年</span>
                        </div>
                        <!-- 单选按钮组 over-->
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue"
                           data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportExlPro('2')">导出EXECL</a>
                    </div>

                    <!-- 图表栏-->
                    <div class="chartBar">
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
        </div></div>
</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            $('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            $('#startTime2').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            $('#endTime2').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
            doCx('');
        });
    };

    var pointCode = '';
    var flag = 'month';
    var flag2 = 'month';
    var pointType = '0';
    var url = '/enviromonit/airDayData/list';
    var url2 = '/enviromonit/airDayData/list';
    var title = '省数据分析-气优良天数比例（天）数据==>';
    var title2 = '省数据分析-气优良天数比例（天）数据==>';
    var aqiText = '';
    var jcTime = startTime + "~" + endTime;
    var jcTime2 = startTime + "~" + endTime;

    $(function () {
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
            if ($(this).context.id == 'month') {
                flag = 'month';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气优良天数比例（月）数据==>';
                jcTime = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
            }
            if ($(this).context.id == 'year') {
                flag = 'year';
                url = '/enviromonit/airHourData/listMonth';
                title = '省数据分析-气优良天数比例（年）数据==>';
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
                    doCx('');
                }
                if (index == 1) {
                    pointType = '0';
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
    var time = '';

    function doCx(idx) {
        startTime = $("#startTime" + idx).val().trim();
        endTime = $("#endTime" + idx).val().trim();
        $('#jcts').text('  监测天数：' + (Number(Ams.datedifference(startTime, endTime)) + 1) + '天');
        if (startTime == "" || endTime == "") {
            $.messager.alert('提示', '时间区间不允许为空！');
            return;
        }
        var a = flag;
        var b = url;

        if (idx == '2') {
            a = flag2;
            b = url2;
            time = jcTime2;
        }
        if (a=="year") {
            $('#jcts').text('  监测天数：' + (Number(Ams.datedifference(startTime.substr(0, 4) + "-01-01", endTime.substr(0, 4) + "-12-31")) + 1) + '天');
            time = startTime.substr(0, 4) + "~" + endTime.substr(0, 4);
        }else{
            time = startTime.substr(0, 7) + "~" + endTime.substr(0, 7);
        }

        if (time.indexOf('defined') > -1) time = startTime + '~' + endTime ;
        $('#jcsj' + idx).text(time);

        if (Ams.isNoEmpty(startTime) && Ams.isNoEmpty(endTime)) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAirExcellentGoodEchart',
                data: {
                    codeRegion: $("#regionName" + idx).val().trim(),
                    pointType: pointType,
                    startTime: startTime,
                    endTime: endTime,
                    start: a
                },
                async: true,
                success: function (result) {
                    var charts = echarts.init(document.getElementById('char' + idx));
                    var name = result.arrExName;
                    var excellentDays = result.ex;
                    setCharts(charts, '优良天数比例', name, excellentDays, result.go);
                    var bottomHtml = '';
                    var text = '';
                    aqiText = '';
                    for (var i = 0; i < name.length; i++) {
                    	if (i == 3) break;
                    	bottomHtml += '<div class="inline-block"><div class="inline-block">'
                    			+ '<span>' + name[i]+ '：</span><span class="em">'
                    			+ excellentDays[i] + '天</span></div></div>';
                    	text += name[i]+ '：' +excellentDays[i] + '天；';
                    }
                    $("#bottomThree" + idx).html(bottomHtml);
                    aqiText+= '均值排名前三【' + text + '】';
                    var topHtml = "";
                    for (var i = name.length - 1; i >= 0; i--) {
                    	if (i == name.length - 4) break;
                    	topHtml += '<div class="inline-block"><div class="inline-block">'
                            + '<span>' + name[i]+ '：</span><span class="em">'
                            + excellentDays[i] + '天</span></div></div>';
                        text += name[i]+ '：' +excellentDays[i] + '天；';
                    }
                    $("#topThree" + idx).html(topHtml);
                    aqiText += '均值排名后三【' + text + '】';
                }
            });
            //表格数据加载
            $('#dg' + idx).datagrid({
                url: Ams.ctxPath + '/enviromonit/airPrimaryPollutant/getAirExcellentGoodPage',
                queryParams: {
                    codeRegion: $("#regionName" + idx).val().trim(),
                    pointType: pointType,
                    startTime: startTime,
                    endTime: endTime,
                    start: a

                }
            });
        }

    }

    //图表数据插入
    function setCharts(charts, charTitle, name, excellentDays, goodDays) {
        charts.clear();
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
                //bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['优天数', '良天数'],
                top: 25
            },
            toolbox: {
                show: true,
                feature: {
                    mark: {show: true},
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    data: name
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name:'天',
                    nameTextStyle: {
                        color: '#2ba4e9',
                        fontSize: '12'
                    },
                    nameGap:10
                }
            ],
            series: [
                {
                    name: '优天数',
                    type: 'bar',
                    data: excellentDays,
                    itemStyle: {
                        normal: {
                            label: {
                                show: true, //开启显示
                                position: 'top', //在上方显示
                                textStyle: { //数值样式
                                    color: 'black',
                                    fontSize: 16
                                }
                            }
                        }
                    },
                    label: {
                        normal: {
                            formatter: '{c}天'
                        }
                    }
                    // ,markPoint : {
                    // 	data : [
                    // 		{type : 'max', name: '最大值'},
                    // 		{type : 'min', name: '最小值'}
                    // 	]
                    // },
                    // markLine : {
                    // 	data : [
                    // 		{type : 'average', name: '平均值'}
                    // 	]
                    // }
                },
                {
                    name: '良天数',
                    type: 'bar',
                    data: goodDays,
                    itemStyle: {
                        normal: {
                            label: {
                                show: true, //开启显示
                                position: 'top', //在上方显示
                                textStyle: { //数值样式
                                    color: 'black',
                                    fontSize: 16
                                }
                            }
                        }
                    },
                    label: {
                        normal: {
                            formatter: '{c}天'
                        }
                    }
                }
            ]
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
        return index + 1;

    }

    /**
     * 导出省控数据excel
     */
    function exportExlPro(idx) {

        doCx(idx);
        var regionName = $("#regionName" + idx).val().trim();
        var startTime = $("#startTime" + idx).val().trim();
        var endTime = $("#endTime" + idx).val().trim();
        var u = url;
        var f = flag;
        var tle = title + aqiText;
        if (idx == 2) {
            // u = url2;
            f = flag2;
            tle = title2 + aqiText;
        }
        u = '/enviromonit/airPrimaryPollutant/getAirExcellentGoodPage';
        aqiText = '';
        window.location.href = u + "?codeRegion=" + regionName + "&startTime=" + startTime + "&endTime=" + endTime + "&pointType=" + pointType + "&start=" + f + "&exportExl=exportExl" + "&exportTitle=" + tle;
    }


</script>
</html>