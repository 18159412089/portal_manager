<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>优良天数-同比-监测站因子</title>
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
                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName"
                       prompt="全部" data-options="
									url:'${request.contextPath}/enviromonit/airMonitorPoint/getPonitList',
									method:'post',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>

            <div class="inline-block">
                <select name="status" id="status" class="easyui-combobox" data-options="required:true" label="优良:"
                        style="width:100%">
                    <option value="excellent" selected>优天数</option>
                    <option value="good">良天数</option>
                </select>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">时间:</label>
                <input id="startTime" type="text" class="layui-input" style="width: 156px;height:33px;" readonly="">
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" onclick="Ams.exportPdfById('group0','因子-同比-监测站因子')"
               class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
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
    //时间选择
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //年选择器
        var startTime = laydate.render({
            elem: '#startTime',
            type: 'year',
            format: 'yyyy',
            max: date.getFullYear(),
            value: date.getFullYear() - 1,
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


    var url = Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getPassYearExcellentAnalysisAirMorePoint";
    var idx = '';
    var startTime = initYear;
    var factor;
    function doSearch() {
        var curr_time = new Date();
        factor = $('#status').combobox('getValue');
        startTime = $('#startTime').val();
        factor = factor == '优天数' ? 'excellent' : factor;
        if (!Ams.isNoEmpty(factor)||!Ams.isNoEmpty(startTime)) {
            layer.msg('优良天数、时间不能为空！');
            return;
        } else {
            var loadIndex = '';
            $.ajax({
                type: "post",
                url: url,
                data: {
                    polluteName: factor,
                    pointCode: getPointName(),
                    time: '',
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
                        html += '<span>优天数：</span>';
                        html += '<span class="em" id="ex1_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>良天数：</span>';
                        html += '<span class="em" id="gd1_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="item col-xs-4">';
                        html += '<div class="cell-title" id="title1' + (j) + '"></div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>优天数：</span>';
                        html += '<span class="em" id="ex2_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>良天数：</span>';
                        html += '<span class="em" id="gd2_' + (j) + '">0</span>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="item col-xs-4">';
                        html += '<div class="cell-title" id="title2' + (j) + '"></div>';
                        html += '<div class="cell-content">';
                        html += '<div class="inline-block">';
                        html += '<span>优天数：</span>';
                        html += '<span class="em up" id="ex' + (j) + '">0</span>';
                        html += '</div>';
                        html += '<div class="inline-block">';
                        html += '<span>良天数：</span>';
                        html += '<span class="em up" id="gd' + (j) + '">0</span>';
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
                        setEcharts(pollutionAnalysis, data[a].legend, data[a].title + '(' + (factor == 'good' ? '良天数' : '优天数') + ')', data[a].formatter, data[a].xAxis, data[a].series);
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
                result += data[i].id + ',';
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
            getCompareData(pointCode, rq);
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
            if (faultByHourIndex > series[0].data.length) {
                faultByHourIndex = 0;
            }if (faultByHourIndex > series[1].data.length) {
                faultByHourIndex = 0;
            }
        }, 2000);
    }

    function getCompareData(pc, rq) {

        $.ajax({
            type: "post",
            url: Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getCompareData",
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
        $('#title' + idx).text(curYear + '年' + rq + '月');
        $('#title1' + idx).text(startTime + '年' + rq + '月');
        $('#title2' + idx).text($('#title' + idx).text() + '与' + $('#title1' + idx).text() + '同比');
        // 当前年
        $('#ex1_' + idx).text(Ams.isNoEmpty(data.curEx) == true ? data.curEx : '0');
        $('#gd1_' + idx).text(Ams.isNoEmpty(data.curGd) == true ? data.curGd : '0');
        // 之前年
        $('#ex2_' + idx).text(Ams.isNoEmpty(data.pastEx) == true ? data.pastEx : '0');
        $('#gd2_' + idx).text(Ams.isNoEmpty(data.pastGd) == true ? data.pastGd : '0');
        // 对比值
        var ex = Ams.isNoEmpty(data.ex) == true ? data.ex : '0';
        if (ex < 0) {
            $('#ex' + idx).text(ex);
            $('#ex' + idx).removeClass("em down");
            $('#ex' + idx).removeClass("em up");
            $('#ex' + idx).addClass("em down");
        } else {
            $('#ex' + idx).text(ex);
            $('#ex' + idx).removeClass("em down");
            $('#ex' + idx).removeClass("em up");
            $('#ex' + idx).addClass("em up");
        }
        var gd = Ams.isNoEmpty(data.gd) == true ? data.gd : '0';
        if (gd < 0) {
            $('#gd' + idx).text(gd);
            $('#gd' + idx).removeClass("em down");
            $('#gd' + idx).removeClass("em up");
            $('#gd' + idx).addClass("em down");
        } else {
            $('#gd' + idx).text(gd);
            $('#gd' + idx).removeClass("em down");
            $('#gd' + idx).removeClass("em up");
            $('#gd' + idx).addClass("em up");
        }

    }
</script>
</html>