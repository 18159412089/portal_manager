<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>超标天数-环比</title>
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

            <div  style="display: none" >
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
            <a href="javascript:void(0)" onclick="Ams.exportPdfById('group0','优良天数-环比-监测站因子')"
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


    var url = Ams.ctxPath + "/enviromonit/airPrimaryPollutant/getCompareDataByMonth";
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
                    flag: 'excess',
                    pointCode: getPointName(),
                    time: startTime
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
                    var j = 0;
                    for (var a in data) {
                        if (Ams.isNoEmpty(a) && data[a].length > 0) {
                            html += '<div class="data-info-layout " id="showCompareDataId' + j + '">';
                            html += '<div class="row">';
                            html += '<div class="item col-xs-4">';
                            var past = data[a][0].year + '-' + data[a][0].month;
                            html += '<div class="cell-title" id="title' + (j) + '">' + past+'</div>';
                            html += '<div class="cell-content">';
                            html += '<div class="inline-block">';
                            var dayName = '超标天数：';
                            html += '<span>'+ dayName+'</span>';
                            html += '<span class="em" id="ex1_' + (j) + '">'+data[a][0].days+'</span>';
                            html += '</div>';
                            html += '<div class="inline-block">';
                            html += '<span></span>';
                            html += '<span class="em" id="gd1_' + (j) + '"></span>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="item col-xs-4">';
                            html += '<div class="cell-title" id="title1' + (j) + '">'+Ams.getNowDate(0)+'</div>';
                            html += '<div class="cell-content">';
                            html += '<div class="inline-block">';
                            html += '<span>'+ dayName+'</span>';
                            var cur = data[a].length > 1 ? data[a][1].days : 0;
                            html += '<span class="em" id="ex2_' + (j) + '">'+cur+'</span>';
                            html += '</div>';
                            html += '<div class="inline-block">';
                            html += '<span></span>';
                            html += '<span class="em" id="gd2_' + (j) + '"></span>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="item col-xs-4">';
                            html += '<div class="cell-title" id="title2' + (j) + '">' + Ams.getNowDate(0)+ '与' + past + '环比</div>';
                            html += '<div class="cell-content">';
                            html += '<div class="inline-block">';
                            html += '<span>'+dayName+'</span>';
                            var up =   cur - data[a][0].days;
                            var c = 'em up';
                            if (up > 0) {
                                c = 'em up';
                            }else{
                                c = 'em down';
                            }
                            html += '<span class="'+c+'" id="ex' + (j) + '">'+up+'</span>';
                            html += '</div>';
                            html += '<div class="inline-block">';
                            html += '<span></span>';
                            // html += '<span class="em up" id="gd' + (j) + '"></span>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';


                            html += '<div class="chartBar" id="parent' + (j) + '">';
                            html += "<div id='chart" + (j) + "' class='chart-box' style='height: 400px;'></div></div>";
                        }
                        // $("#parent"+j).after("<div class='chartBar' id='parent"+(j+1)+"'>"+
                        //     "<div id='chart"+(j+1)+"' class='chart-box' style='height: 400px;'></div></div>");

                        j++;
                    }
                    $("#group0 div").remove();
                    $('#group0').append(html);
                    var a = 0 ;
                    for (var obj in data) {
                        if (Ams.isNoEmpty(obj) && data[obj].length > 0) {
                            pollutionAnalysis = echarts.init(document.getElementById('chart' + a));
                            var days = data[obj].length > 1 ? data[obj][1].days : 0;
                            var time = data[obj].length > 1 ? data[obj][1].year+'-'+data[obj][1].month : Ams.getNowDate(0);
                            var timeArr = new Array();
                            timeArr.push(data[obj][0].year + '-' + data[obj][0].month);
                            timeArr.push(time);
                            setCharts(pollutionAnalysis,data[obj][0].pointName,timeArr, data[obj][0].days, days);
                        }
                        a++;
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
    function setCharts(charts, charTitle, name, excellentDays, goodDays) {
        charts.clear();
        var option = {
            title: {
                text: charTitle,
                left: 'center',
                textStyle: {
                    color: '#464646',
                    fontSize:'19',
                    fontWeight:'normal'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                //bottom: '3%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: ''
                }
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
                    data: name,
                    axisLabel: {
                        type: 'category',
                        interval: 0,
                        textStyle: {
                            fontSize: 15      //更改坐标轴文字大小
                        }
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: '超标天数',
                    nameTextStyle: {
                        color: '#2ba4e9',
                        fontSize: '12'
                    },
                    nameGap:10
                }
            ],
            series: [
                {
                    name: '',
                    type: 'bar',
                    data: [excellentDays, goodDays],//excellentDays,
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
                }]
        };
        charts.setOption(option);
        var faultByHourIndex = 0; //播放所在下标
        var faultByHourTime = setInterval(function() { //使得tootip每隔三秒自动显示
            charts.dispatchAction({
                type: 'showTip', // 根据 tooltip 的配置项显示提示框。
                seriesIndex: 0,
                dataIndex: faultByHourIndex
            });
            faultByHourIndex++;
            // faultRateOption.series[0].data.length 是已报名纵坐标数据的长度
            if (faultByHourIndex >= 2) {
                faultByHourIndex = 0;
            }
        }, 2000);
    }

</script>
</html>