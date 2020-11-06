<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>监测站AQI(城市)-环比</title>
</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout p10"  id="echartGroup" >
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">地区：</label>
                <input class="easyui-combobox" name="pointName"   id="pointName"
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
                <input type="text" class="layui-input" id="startTime" placeholder="同比年份选择">
            </div>

            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" onclick="Ams.exportPdfById('echartGroup','AQI-城市-环比')"
               class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出图片</a>
        </form>

    </div>
    <!-- 搜索栏 over-->
    <div class="chart-group">
        <!-- 图表栏 over-->
    </div>

</div>
</body>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var date = new Date();
    var initYear = date.getFullYear();
    var currentYear = date.getFullYear();
    var currentIndex;//横坐标index数据
    var currentDataShow;//标题框要显示的数据
    var searchYearDataShow;//标题框要显示的数据
    var currentPointCode;//标题框要显示的数据
    var timeType="day";//标题框要显示的数据
    var currentYearAndMonth= date.getFullYear() +"-"+PrefixZero(date.getMonth()+1, 2);//当前月时间类型
    var searchYearAndMonth= date.getFullYear() +"-"+PrefixZero(date.getMonth(), 2);//查询的时间类型;
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //年选择器
        var startTime = laydate.render({
            elem: '#startTime',
            type: 'month',
            format: 'yyyy-MM',
            max: date.getFullYear()+"-"+PrefixZero(date.getMonth(),2)+"-01",
            value:date.getFullYear()+"-"+PrefixZero(date.getMonth(), 2),
            showBottom: false,
            ready: function (date) {
                $("#startTime").val(date.year+"-"+PrefixZero(date.month, 2));
            },
            done: function (value, date, endDate) {
            },
            change: function (value, date, endDate) {
                if ($(".layui-laydate").length) {
                    $("#startTime").val(date.year+"-"+PrefixZero(date.month, 2));
                    $(".layui-laydate").remove();
                }
            }
        });
    });

    function PrefixZero(num, n) {
        return (Array(n).join(0) + num).slice(-n);
    }

    $(function () {
        getAQIEchartByPointCode();
        window.onresize = function () {
            $('#airPrimaryPollutant2').width('100%');
            airPrimaryPollutantChart2.resize();
            $('#airPrimaryPollutant').width('100%');
            airPrimaryPollutantChart.resize();
        }


    })


    function getAQIEchartByPointCode() {
        var loadIndex = '';
        var startTime;
        if (Ams.isNoEmpty($("#startTime").val())) {
            startTime=$("#startTime").val();
        }else{
            startTime=searchYearAndMonth;
        }
        $.ajax({
            url: "/enviromonit/airPrimaryPollutant/getAQIRingRadioEchart",
            type: "POST",
            dataType: 'json',
            data: {
                pointCode: getPointName(),
                searchYear:startTime,
                timeType:"countMonthDay",
                pointType:1
            },
            success: function (data) {
                $("#searchBar1").nextAll("div").remove();
                getAQIEchartHtml(data, 1)
            },
            beforeSend: function () {
                loadIndex = layer.load(1, {
                    shade: [0.1, '#fff']
                });
            },
            complete: function () {
                layer.close(loadIndex);
            },
        })
    }

    function getAQIEchartHtml(data) {
        var currentAQI;
        var searchAQI;
        for (var i = 0; i < data.length; i++) {
            if (data[i].series.length == 0) {
                continue;
            }
            currentAQI = "";
            searchAQI = "";
            for (var j = 0; j < data[i].series.length; j++) {
                if (data[i].series[j].name == currentYearAndMonth) {
                    currentAQI = data[i].series[j].data[0] == null ? "" : data[i].series[j].data[0];
                } else {
                    searchAQI = data[i].series[j].data[0] == null ? "" : data[i].series[j].data[0];
                }
            }
            var newRow = '<div class="chart-group">';
            newRow += '<div class="data-info-layout ">';
            newRow += '<div class="other">';
            newRow += '<div class="inline-block">';
            newRow += '<span class="control-label">监测时间：</span>';
            newRow += '<span class="control-content" id="jcTime' + data[i].pointCode + '"> ' + currentYearAndMonth + '</span>';
            newRow += '</div>';
            newRow += '<div class="inline-block">';
            newRow += '<span class="control-label">监测站点：</span>';
            newRow += '<span class="control-content">' + data[i].title + '</span>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '<div class="row">';
            newRow += ' <div class="item col-xs-4"> ';
            newRow += '<div class="cell-title">' + currentYearAndMonth + '-<span id="currentMonthAndDay' + data[i].pointCode + '">01</span></div>';
            newRow += '<div class="cell-content">';
            newRow += '<div class="inline-block">';
            newRow += '<div class="inline-block">';
            newRow += '<span>AQI：</span>'
            newRow += '<span class="em" id="currentAQINum' + data[i].pointCode + '">' + currentAQI + '</span>'
            newRow += ' </div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '<div class="item col-xs-4">';
            newRow += '<div class="cell-title">' + $("#startTime").val() + '-<span id="searchMonthAndDay' + data[i].pointCode + '">01</span></div>';
            newRow += '<div class="cell-content">';
            newRow += '<div class="inline-block">';
            newRow += '<div class="inline-block">';
            newRow += '<span>AQI：</span>';
            newRow += '<span class="em" id="oldAQINum' + data[i].pointCode + '">' + searchAQI + '</span>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '<div class="item col-xs-4">';
            newRow += '<div class="cell-title" >' + currentYearAndMonth + '-<span id="yearOnYear1' + data[i].pointCode + '">01</span>与' + $("#startTime").val() + '-<span id="yearOnYear2' + data[i].pointCode + '">01</span>同比</div>';
            newRow += '  <div class="cell-content">';
            newRow += '<div class="inline-block">';
            newRow += '<div class="inline-block">';
            newRow += '<span>AQI：</span>';
            if (currentAQI < searchAQI) {
                newRow += '<span class="em down" id="subAQINum' + data[i].pointCode + '">' + Math.abs(currentAQI - searchAQI) + '</span>';
            } else if (currentAQI > searchAQI) {
                newRow += '<span class="em up" id="subAQINum' + data[i].pointCode + '">' + Math.abs(currentAQI - searchAQI) + '</span>';
            } else {
                newRow += '<span class="em" id="subAQINum' + data[i].pointCode + '">' + Math.abs(currentAQI - searchAQI) + '</span>';
            }
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '</div>';
            newRow += '<div class="chartBar">';
            newRow += '<div class="chart-box">';
            newRow += '<div id="airPrimaryPollutant' + data[i].pointCode + '" style="width: 100%;height: 420px;"></div>';
            newRow += '</div>'
            newRow += '</div>'
            newRow += '</div>'
            $("#searchBar1").after(newRow);
            showAQIEchart(data[i], i);
        }
    }


    function showAQIEchart(data, index) {
        var dataseries;
        if (data.series.length == 2) {
            dataseries = [
                {
                    name: data.series[0].name + "," + data.pointCode,
                    type: 'line',
                    symbol: 'circle',
                    symbolSize: 6,
                    smooth: false,
                    itemStyle: {
                        normal: {
                            color: '#2ba4e9'
                        }
                    },
                    data: data.series[0].data
                },
                {
                    name: data.series[1].name + "," + data.pointCode,
                    type: 'line',
                    symbol: 'triangle',
                    symbolSize: 6,
                    smooth: false,
                    itemStyle: {
                        normal: {
                            color: '#ff6262'
                        }
                    },
                    data: data.series[1].data
                }
            ]
        } else if (data.series.length == 1) {
            dataseries = [
                {
                    name: data.series[0].name + "," + data.pointCode,
                    type: 'line',
                    symbol: 'circle',
                    symbolSize: 6,
                    smooth: false,
                    itemStyle: {
                        normal: {
                            color: '#2ba4e9'
                        }
                    },
                    data: data.series[0].data
                }
            ]
        }

        var airPrimaryPollutantChart2 = echarts.init(document.getElementById('airPrimaryPollutant' + data.pointCode));

        var airPrimaryPollutantOption2 = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                },
                formatter: function (params, index) {
                    currentIndex = "";//横坐标i
                    currentDataShow = "";//标题框显示数据今年的aqi值
                    searchYearDataShow = "";//标题框显示数据查找的年份的aqi值
                    for (var i=0;i<params.length;i++){
                        for (var i = 0; i < params.length; i++) {
                            currentIndex = params[i].dataIndex;
                            if (params[i].seriesName.split(",")[0] == currentYear) {
                                currentDataShow = params[i].data
                            } else {
                                searchYearDataShow = params[i].data
                            }
                        }
                    }
                    var htmlStr = '<div>';
                    htmlStr += params[0].name+ '<br/>';//x轴的名称
                    htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[0].color + ';"></span>';
                    htmlStr += params[0].seriesName.split(",")[0] + "-"+params[0].name+': ' + (Ams.isNoEmpty(params[0].value) == true ? params[0].value : "-") + '<br/>';
                    if (params.length == 2) {
                        htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:' + params[1].color + ';"></span>';
                        htmlStr += params[1].seriesName.split(',')[0] +"-"+params[1].name+ ': ' + (Ams.isNoEmpty(params[1].value) == true ? params[1].value : "-") + '<br/>';
                    }
                    htmlStr += '</div>';
                    return htmlStr;}
            },
            legend: {
                top: 7,
                data: data.legend,
                formatter: function (params) {
                    return params.split(',')[0];
                }
            },toolbox: {
                show: true,
                feature: {
                    magicType: {show: true, type: ['line', 'bar']},
                    saveAsImage: {show: true},
                    restore: {show: true}
                }
            },
            title: {
                text: data.title,
                top: 5,
                textStyle: { //设置主标题风格
                    fontSize: 14,
                    color: '#404040',
                    fontWeight: 100,
                },
            },
            grid: {
                top: '50',
                left: '10',
                right: '10',
                bottom: '10',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                data: data.xAxis,
                triggerEvent: true,
                axisLabel: {
                    formatter:function (data) {
                        var startTime;
                        if (Ams.isNoEmpty($("#startTime").val())) {
                            startTime=$("#startTime").val();
                        }else{
                            startTime=searchYearAndMonth;
                        }
                        return startTime+"-"+data;
                    }
                }
            },
            yAxis: {
                type: 'value',
                triggerEvent: true,
                axisLabel: {
                    formatter:"{value}(μg/m3)"
                }
            },
            series: dataseries
        };
        // 使用刚指定的配置项和数据显示图表。
        airPrimaryPollutantChart2.setOption(airPrimaryPollutantOption2);
        airPrimaryPollutantChart2.on('click', function (data) {
            //需要的数据有pointCode,index,startTime
            var clickPointCode = data.seriesName.split(',')[1];
            if(!Ams.isNoEmpty(searchYearDataShow)){
                searchYearDataShow="";
            }
            if(!Ams.isNoEmpty(currentDataShow)){
                currentDataShow="";
            }
            $("#oldAQINum" + clickPointCode).text(searchYearDataShow);
            $("#currentAQINum" + clickPointCode).text(currentDataShow);
            $("#yearOnYear1" + clickPointCode).html(data.name);
            $("#yearOnYear2" + clickPointCode).html(data.name);
            $("#subAQINum" + clickPointCode).removeClass();
            $("#jcTime" + clickPointCode).text(data.name);
            $("#searchMonthAndDay"+clickPointCode).text(data.name);
            $("#currentMonthAndDay"+clickPointCode).text(data.name);
            if (currentDataShow < searchYearDataShow) {
                $("#subAQINum" + clickPointCode).addClass(" em down");
            } else if (currentDataShow > searchYearDataShow) {
                $("#subAQINum" + clickPointCode).addClass("em up");
            }else{
                $("#subAQINum" + clickPointCode).addClass("em");
            }
            $("#subAQINum" + clickPointCode).html(Math.abs(currentDataShow - searchYearDataShow));
        });
    }

    /**
     * 获取选中的站点，没选默认全部
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
     * 查找Echart数据
     */
    function doSearch() {
        getAQIEchartByPointCode();
    }
</script>
</html>