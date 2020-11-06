<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>因子-环比-监测站因子</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<div class="easyui-layout p10">
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                <input id="pointName" class="easyui-combobox" name="pointName"  style="height: 32px; width: 140px;"  prompt="全部" data-options="
                        url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
                        method:'post',
                        editable:false,
                        valueField:'uuid',
                        textField:'name',
                        multiple:true,
                        panelHeight:'auto'">
            </div>

            <div class="inline-block">
                <label for="riverSystem" class="control-label">比较因子：</label>
                <input class="easyui-combobox" name="queryFactor" id="queryFactor" data-options="
                    onLoadSuccess: function (data) {
                                            if (data) {
                                               $('#queryFactor').combobox('setValue',data[0].key);//选择后台查出来的第一个值
                                            }
                                        },
						url:'${request.contextPath}/enviromonit/airDataService/getSixFactor',
						method:'get',
						valueField:'key',
						textField:'text',
						multiple:false,
						panelHeight:'170px'"
                       style="width:150px;height:30px;">
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">时间:</label>
                <input id="startTime" type="text" class="layui-input" style="width: 156px;height:33px;" readonly="">
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" onclick="Ams.exportPdfById('group0','因子-同比-监测站因子')"
               class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
            <div class="inline-block fr">
                <!-- 单选按钮组 -->
                <div id="dayYear" class="radio-button-group style-btn-group" style="display: none;">
                    <span class="active">日</span>
                    <span>月</span>
                </div>
                <!-- 单选按钮组 over-->
            </div>
        </form>

    </div>
    <!-- 搜索栏 over-->
    <div class="chart-group" id="group0">
        <!-- 数据信息 -->
        <!-- 数据信息over -->
        <!-- 图表栏-->
        <!-- 图表栏-->
        <div class="chartBar" id="parent0">
            <div class="chart-box" id="chart0" style="height: 400px;"></div>
        </div>
        <!-- 图表栏 over-->
    </div>

</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            doSearch();
        });
    };

    /*单选按钮组*/
    $(".radio-button-group").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        doSearch();
    });

    $(function () {

        // window.onresize = function () {
        //     $('#airPrimaryPollutant').width('100%');
        //     airPrimaryPollutantChart.resize();
        //     $('#airPrimaryPollutant2').width('100%');
        //     airPrimaryPollutantChart2.resize();
        //     $('#airPrimaryPollutant3').width('100%');
        //     airPrimaryPollutantChart3.resize();
        // }


    });

    var date = new Date();
    var initYear = date.getFullYear();
    var curYear = date.getFullYear();
    var curMon = date.getMonth()+1;
    //时间选择
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //年选择器
        var startTime = laydate.render({
            elem: '#startTime',
            type: 'month',
            format: 'yyyy-MM',
            max: date.getFullYear(),
            value: Ams.getNowDate(30),
            showBottom: false,
            ready: function (date) {
                initYear = date.year;
            },
            done: function (text, date) {
            },
            change: function (value, date, endDate) {
                var selectYear = date.year;
                if ($(".layui-laydate").length) {
                    $("#startTime").val(value);
                    $(".layui-laydate").remove();
                }
            }
        });
    });


    var url = Ams.ctxPath + "/enviromonit/airDataService/getPassYearAnalysisAirMorePointHB";
    var idx = '';
    var startTime = initYear;

    function doSearch() {
        var time = 'YearDay';
        if (getYearDay() == '月') {
            time = '';
        }
        var curr_time = new Date();
        var point = $('#pointName').combobox('getValue');
        var factor = $('#queryFactor').combobox('getValue');
        var factorText = $('#queryFactor').combobox('getText');
        startTime = $('#startTime').val();
        if (!Ams.isNoEmpty(factor)||!Ams.isNoEmpty(startTime)) {
            layer.msg('比较因子、时间不能为空！');
            return;
        } else {
            var loadIndex = '';
            $.ajax({
                type: "post",
                url: Ams.ctxPath + "/enviromonit/airDataService/getPassYearAnalysisAirMorePointHB",
                data: {
                    polluteName: factor,
                    pointCode: getPointName(),
                    time: time,
                    year: startTime
                },
                dataType: "json",
                beforeSend: function () {
                    loadIndex = layer.load(1, {
                        shade: [0.1, '#fff']
                    });
                },
                complete: function () {
                    layer.close(loadIndex);
                },
                success: function (data) {
                    var array = $('#parent0').nextAll();
                    for (var i = 0; i < array.length; i++) {
                        array[i].remove();
                    }
                    console.log(data);
                    var pollutionAnalysis;
                    var html = '';
                    for (var j = 0; j < data.length; j++) {
                        html += '<div class="data-info-layout " id="showCompareDataId' + j + '" style="display: none;">';
                        html += '<div class="row">';
                        html += '<div class="item col-xs-4">';
                        html += '<div class="cell-title" id="title' + (j) + '"></div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>PM2.5：</span>';
                        html += '<span class="em" id="PM25_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>PM10：</span>';
                        html += '<span class="em" id="PM10_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>SO2：</span>';
                        html += '<span class="em" id="SO2_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>NO2：</span>';
                        html += '<span class="em" id="NO2_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span >O3：</span>';
                        html += '<span class="em" id="O3_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>CO：</span>';
                        html += '<span class="em" id="CO_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="item col-xs-4">';
                        html += '<div class="cell-title" id="title1' + (j) + '"></div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>PM2.5：</span>';
                        html += '<span class="em" id="PM251' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>PM10：</span>';
                        html += '<span class="em" id="PM101' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>SO2：</span>';
                        html += '<span class="em" id="SO21' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>NO2：</span>';
                        html += '<span class="em" id="NO21' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>O3：</span>';
                        html += '<span class="em" id="O31' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>CO：</span>';
                        html += '<span class="em" id="CO1' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="item col-xs-4">';
                        html += '<div class="cell-title" id="title2' + (j) + '"></div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>PM2.5：</span>';
                        html += '<span class="em up" id="PM252' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>PM10：</span>';
                        html += '<span class="em up" id="PM102' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>SO2：</span>';
                        html += '<span class="em up" id="SO22' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>NO2：</span>';
                        html += '<span class="em up" id="NO22' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>O3：</span>';
                        html += '<span class="em up" id="O32' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span >CO：</span>';
                        html += '<span class="em up" id="CO2' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';


                        html += '<div class="chartBar" id="parent' + (j) + '">';
                        html += "<div id='chart" + (j) + "' class='chart-box' style='height: 400px;'></div></div>";

                        // $("#parent"+j).after("<div class='chartBar' id='parent"+(j+1)+"'>"+
                        //     "<div id='chart"+(j+1)+"' class='chart-box' style='height: 400px;'></div></div>");

                    }
                    $("#group0 div").remove();
                    $('#group0').append(html);
                    for (var a = 0; a < data.length; a++) {
                        pollutionAnalysis = echarts.init(document.getElementById('chart' + a));
                        setEcharts(pollutionAnalysis, data[a].legend, data[a].title + '(' + factorText + ')', data[a].formatter, data[a].xAxis, data[a].series);
                    }
                },
                error: function (r) {
                    console.log(r);
                }
            });
        }
    }

    /**
     * 获取选中的因子，没选默认全部
     * @returns {string}
     */
    function getPointName() {
        var pointName = $('#pointName').combobox('getValues');
        if (!Ams.isNoEmpty(pointName)) {
            var result = "";
            var data = $('#pointName').combobox('getData');
            for (var i = 0; i < data.length; i++) {
                result += data[i].uuid + ',';
            }
            result = result.substr(0, result.length - 1);
            return result;
        }
        return pointName.toString();
    }

    /**
     * echart 显示
     */
    function setEcharts(pollutionAnalysis, legend, title, formatter, xAxis, series) {
        pollutionAnalysis.clear();
        var option = {
            title: {
                text: title,
                textStyle: {
                    fontSize: 16
                },
                left: '10',
                top: '10'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                },
                formatter: function (params) {
                    var htmlStr = '<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[0].color + ';"></span>';
                    htmlStr += params[0].seriesName.split(",")[0] + ': ' + (Ams.isNoEmpty(params[0].value) == true ? params[0].value : "-") + '<br/>';

                    if (params.length == 2) {
                        htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[1].color + ';"></span>';
                        htmlStr += params[1].seriesName.split(",")[0] + ': ' + (Ams.isNoEmpty(params[1].value) == true ? params[1].value : "-") + '<br/>';
                    }
                    htmlStr += '</div>';
                    return htmlStr;
                }

            },
            toolbox: {
                show: true,

                feature: {
                    magicType: {show: true, type: ['line', 'bar']},
                    saveAsImage: {show: true},
                    restore: {show: true}
                }
            },
            legend: {
                orient: 'horizontal',
                top: '8%',
                right: '30',
                data: legend,
                formatter: function (params) {
                    return params.split(',')[0];
                }
            },
            grid: {
                top:'50',
                left: '10',
                right: '10',
                bottom: '10',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                axisLabel: {
                    type: 'category'
                },
                data: xAxis
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: formatter
                }
            },
            series: series
        };
        pollutionAnalysis.off('click');
        pollutionAnalysis.on('click', function (params) {
            var pointCode;
            var rq;
            if (params.componentType == "xAxis") {
                pointCode = params.value.split(",")[1];
                rq = params.value.split(",")[0];
            } else {
                rq = params.name;
                pointCode = params.seriesName.split(",")[1];
                idx = params.seriesName.split(",")[2];
            }
            getCompareData(pointCode, startTime.split("-")[1]+"-"+rq);
        });
        pollutionAnalysis.setOption(option);
        // 动态显示tootip
        var faultByHourIndex = 0; //播放所在下标
        var faultByHourTime = setInterval(function() { //使得tootip每隔三秒自动显示
            pollutionAnalysis.dispatchAction({
                type: 'showTip', // 根据 tooltip 的配置项显示提示框。
                seriesIndex: 0,
                dataIndex: faultByHourIndex
            });
            faultByHourIndex++;
            // faultRateOption.series[0].data.length 是已报名纵坐标数据的长度
            if (Ams.isNoEmpty(series)&&faultByHourIndex > series[0].data.length) {
                faultByHourIndex = 0;
            } if (Ams.isNoEmpty(series)&&series.length>1&&faultByHourIndex > series[1].data.length) {
                faultByHourIndex = 0;
            }
        }, 2000);
    }

    function getCompareData(pc, rq) {

        $.ajax({
            type: "post",
            url: Ams.ctxPath + "/enviromonit/airDataService/getCompareData",
            data: {
                pointCode: pc,
                year: startTime,
                rq: rq
            },
            dataType: "json",
            beforeSend: function () {
                loadIndex = layer.load(1, {
                    shade: [0.1, '#fff']
                });
            },
            complete: function () {
                layer.close(loadIndex);
            },
            success: function (data) {
                setCompareData(data, rq);

                // $('#PM102'+idx).text(data.PM10);
                // $('#SO22'+idx).text(data.SO2);
                // $('#NO22'+idx).text(data.No2);
                // $('#CO2'+idx).text(data.CO);
                // $('#O32'+idx).text(data.O3);

            },
            error: function (r) {
                console.log(r);
            }
        });
    }

    function setCompareData(data, rq) {

        if ($('#showCompareDataId' + idx).css("display") == 'none') {//如果showCompareDataId是隐藏的
            $('#showCompareDataId' + idx).css("display", "block");//showCompareDataId的display属性设置为block（显示）
        }
        //时间标题
        if (getYearDay() == '月') {
            $('#title' + idx).text(curYear + '年' + rq + '月');
            $('#title1' + idx).text(startTime + '年' + rq + '月');
            $('#title2' + idx).text($('#title' + idx).text() + '与' + $('#title1' + idx).text() + '同比');
        } else {
            $('#title' + idx).text(curYear + '年' + curMon + '月' + rq.split("-")[1] + '日');
            $('#title1' + idx).text(startTime.split("-")[0] + '年' + rq.split("-")[0] + '月' + rq.split("-")[1] + '日');
            $('#title2' + idx).text($('#title' + idx).text() + '与' + $('#title1' + idx).text() + '同比');
        }
        // 当前年
        $('#PM25_' + idx).text(Ams.isNoEmpty(data.curPM25) == true ? data.curPM25 : '0');
        $('#PM10_' + idx).text(Ams.isNoEmpty(data.curPM10) == true ? data.curPM10 : '0');
        $('#SO2_' + idx).text(Ams.isNoEmpty(data.curSO2) == true ? data.curSO2 : '0');
        $('#NO2_' + idx).text(Ams.isNoEmpty(data.curNo2) == true ? data.curNo2 : '0');
        $('#CO_' + idx).text(Ams.isNoEmpty(data.curCO) == true ? data.curCO : '0');
        $('#O3_' + idx).text(Ams.isNoEmpty(data.curO3) == true ? data.curO3 : '0');
        // 之前年
        $('#PM251' + idx).text(Ams.isNoEmpty(data.pastPM25) == true ? data.pastPM25 : '0');
        $('#PM101' + idx).text(Ams.isNoEmpty(data.pastPM10) == true ? data.pastPM10 : '0');
        $('#SO21' + idx).text(Ams.isNoEmpty(data.pastSO2) == true ? data.pastSO2 : '0');
        $('#NO21' + idx).text(Ams.isNoEmpty(data.pastNo2) == true ? data.pastNo2 : '0');
        $('#CO1' + idx).text(Ams.isNoEmpty(data.pastCO) == true ? data.pastCO : '0');
        $('#O31' + idx).text(Ams.isNoEmpty(data.pastO3) == true ? data.pastO3 : '0');
        // 对比值
        var pm25 = Ams.isNoEmpty(data.PM25) == true ? data.PM25 : '0';
        if (pm25 < 0) {
            $('#PM252' + idx).text(pm25);
            $('#PM252' + idx).removeClass("em down");
            $('#PM252' + idx).removeClass("em up");
            $('#PM252' + idx).addClass("em down");
        } else {
            $('#PM252' + idx).text(pm25);
            $('#PM252' + idx).removeClass("em down");
            $('#PM252' + idx).removeClass("em up");
            $('#PM252' + idx).addClass("em up");
        }
        var pm10 = Ams.isNoEmpty(data.PM10) == true ? data.PM10 : '0';
        if (pm10 < 0) {
            $('#PM102' + idx).text(pm10);
            $('#PM102' + idx).removeClass("em down");
            $('#PM102' + idx).removeClass("em up");
            $('#PM102' + idx).addClass("em down");
        } else {
            $('#PM102' + idx).text(pm10);
            $('#PM102' + idx).removeClass("em down");
            $('#PM102' + idx).removeClass("em up");
            $('#PM102' + idx).addClass("em up");
        }

        var so2 = Ams.isNoEmpty(data.SO2) == true ? data.SO2 : '0';
        if (so2 < 0) {
            $('#SO22' + idx).text(so2);
            $('#SO22' + idx).removeClass("em down");
            $('#SO22' + idx).removeClass("em up");
            $('#SO22' + idx).addClass("em down");
        } else {
            $('#SO22' + idx).text(so2);
            $('#SO22' + idx).removeClass("em down");
            $('#SO22' + idx).removeClass("em up");
            $('#SO22' + idx).addClass("em up");
        }
        var no2 = Ams.isNoEmpty(data.No2) == true ? data.No2 : '0';
        if (no2 < 0) {
            $('#NO22' + idx).text(no2);
            $('#NO22' + idx).removeClass("em down");
            $('#NO22' + idx).removeClass("em up");
            $('#NO22' + idx).addClass("em down");
        } else {
            $('#NO22' + idx).text(no2);
            $('#NO22' + idx).removeClass("em down");
            $('#NO22' + idx).removeClass("em up");
            $('#NO22' + idx).addClass("em up");
        }
        var co = Ams.isNoEmpty(data.CO) == true ? data.CO : 0;
        if (co < 0) {
            $('#CO2' + idx).text(co.toFixed(1));
            $('#CO2' + idx).removeClass("em down");
            $('#CO2' + idx).removeClass("em up");
            $('#CO2' + idx).addClass("em down");
        } else {
            $('#CO2' + idx).text(co.toFixed(1));
            $('#CO2' + idx).removeClass("em down");
            $('#CO2' + idx).removeClass("em up");
            $('#CO2' + idx).addClass("em up");
        }
        var o3 = Ams.isNoEmpty(data.O3) == true ? data.O3 : '0';
        if (o3 < 0) {
            $('#O32' + idx).text(o3);
            $('#O32' + idx).removeClass("em down");
            $('#O32' + idx).removeClass("em up");
            $('#O32' + idx).addClass("em down");
        } else {
            $('#O32' + idx).text(o3);
            $('#O32' + idx).removeClass("em down");
            $('#O32' + idx).removeClass("em up");
            $('#O32' + idx).addClass("em up");
        }


    }

    /**
     * 月日切换
     * @returns {*|jQuery}
     */
    function getYearDay() {
        return $("#dayYear span.active").text();
    }
</script>
</html>