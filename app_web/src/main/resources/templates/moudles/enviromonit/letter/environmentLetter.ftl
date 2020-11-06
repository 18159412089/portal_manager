<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en" style="padding-bottom: 136px;">
<head>
    <title>环保督察-总体情况</title>
</head>
<!-- body -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<body style="background-color: #f3f8f6;">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
<#include "/common/loadingDiv.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>-->
<#--    <#include "/supervisionMenu.ftl">-->
<#--<#else>-->
<#--    <#include "/inputSupervisionMenu.ftl">-->
<#--</#if>-->
<#include "/secondToolbar.ftl">
<style type="text/css">
    .monitor-container {
        margin: 16px 0;
    }

    .monitor-container .monitor-title {
        width: 48px;
        font-weight: normal;
    }

    .layui-input {
        display: inline;
    }

    .col-xs-12 {
        padding: 0px;
    }

    input[type="text"] {
        background-color: #f3f8f6;
        border: 1px solid #45b97c;
    }

    #pf-hd .pf-user .pf-user-photo {
        margin: 0px;
    }

    html {
        min-width: 1024px !important;
        height: inherit;
    }

    #airStandardPie > div > canvas {
        top: -54px !important;
    }

</style>
<input style="display: none;" id="authority">
<div id="myPrint" class="container"
     style="position:relative;left:0px;right:0px;bottom:0px;margin: 0 30px; overflow: hidden">

    <!-- 空气 main -->
    <div class="column-panel-table">
        <div class="column-panel-group col-xs-12">
            <div class="column-panel">
                <div class="column-panel-header">
                    <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                    <span style="position: absolute;right: 42%;padding: 8px;padding-top: 0px;">
						<font style="font-size: 180%;font-weight: bold !important;" id="title">漳州市环保信访件总体情况</font>
					</span>
                    <a id="printImg" onclick="Ams.doPrint('myPrint')" class="printing-button">
                        <span class="icon iconcustom yl_print"/></span> 打印
                    </a>
                    <a id="exportImg" onclick="Ams.exportPdfById('myPrint','漳州市环保信访件总体情况')" class="printing-button">
                        <span class="icon iconcustom icon-PDFwenjian yl_print"></span>导出PDF
                    </a>

                    <div class="article-area tc">
                        <div id="toolbar">
                            <div id="searchBar yl-searchBar">
                                <div class="searchBar-style">
                                    <input name="queryStartTime" id="queryStartTime" class="easyui-combobox"
                                           data-options="
                                        editable:false,
                                        url:'${request.contextPath}/environment/letter/getTypeList?type=lc',
                                        valueField:'lc',
                                        textField:'lc',
                                        onLoadSuccess: function (data) {
                                            if (Ams.isNoEmpty(data)&&data) {
                                               $('#queryStartTime').combobox('setValue',data[0].lc);//选择后台查出来的第一个值
                                               doSearch();
                                            }
                                        }"
                                           style="width:250px;">
                                    </input>
                                    <a class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                                       onclick="doSearch()">查询</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="column-panel-body" style="margin-top:28px; ">

                    <!-- 近三十日全市AQI -->

                    <div id="exportPic" style="overflow: hidden">

                        <div class="ztqk-left-box">
                            <div class="data-font">
                            </div>
                            <div id="airChart" class="fl" style="width:100%;min-height: 600px;"></div>
                        </div>
                        <!-- 本年优良率与上年同期对比 -->
                        <div class="ztqk-right-box">
                            <div id="airStandardPie" class="oh" style="width:100%;min-height:600px;"></div>
                            <#-- 饼图详情-->
                            <div id="airStandardInfo" class="oh" style="width:100%;min-height:600px;"></div>

                            <div id="information" class="information-text">
                                总体情况 我市中央环保督察问题24个，截至3月25日，我市应完成整改任务13个，11个达到序时进度。已完成整改13个，完成市级验收13个，完成行业审查4个。
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>


    </div>

    <!-- 空气 main over -->
</div>


<!-- 引入底部文字提示 main -->
<#include "/moudles/debriefing/tips-font.ftl"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/html2canvas.js" charset="utf-8"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    // 基于准备好的dom，初始化echarts实例
    var airChart = echarts.init(document.getElementById('airChart'));

    var dataAxis = ['漳州市', '相城区', '常山开发区', '东山县', '长泰县', '平和县', '华安县',];


    // --------------柱状图点击事件----------------
    airChart.off('click');
    airChart.on('click', function (params) {
        var url="/environment/letter/list?pid="+ encodeURIComponent("fe3bd39d-7442-461f-8e39-e97aac9d60a4");
        if (params.componentType == "xAxis") {
            url+="&name=" + encodeURIComponent(params.value) + "&state=" + ""
                +"&lc="+$('#queryStartTime').combobox('getValue');
            window.location.href = url;
        } else {
            url +="&name=" + encodeURIComponent(params.name)
                + "&state=" + encodeURIComponent(params.seriesName)
                +"&lc="+$('#queryStartTime').combobox('getValue');
            window.location.href = url;
        }
        console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
        airChart.dispatchAction({
            type: 'dataZoom',
            startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
            endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
        });
    });

    // Enable data zoom when user click bar.
    var zoomSize = 6;
    airChart.on('click', function (params) {
        console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
        airChart.dispatchAction({
            type: 'dataZoom',
            startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
            endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
        });
    });

    var WatertypePie = echarts.init(document.getElementById('airStandardPie'));

    function doSearch() {
        getPie($('#queryStartTime').val());
        getStateNumToBar();
    }

    function getPie(lc) {
        $.ajax({
            type: "post",
            url: Ams.ctxPath + "/environment/letter/countPieWrlx",
            data: {
                lc: lc
            },
            dataType: "json",
            success: function (result) {
                setPieWrlx(result.legend, result.data);
                $("#airStandardPie").show();
                $("#airStandardInfo").hide();
                $(window).resize(WatertypePie.resize).trigger('resize');
                $('#title').text((Ams.isNoEmpty(result.qx) == true ? result.qx : '漳州市') + '环保信访件总体情况');
                var html = "截至 " + Ams.dateFormat(new Date(), "yyyy年MM月dd日")
                    + " ，" + (Ams.isNoEmpty(result.qx) == true ? result.qx : '漳州市') + " 中央信访件问题";
                for (var i = 0; i < result.legend.length; i++) {
                    html += result.legend[i] + " " + result.data[i].value + "个，";
                }
                $('#information').text(html.substr(0, html.length - 1) + "。")
            },
            error: function (r) {
                console.log(r);
            }
        });
    }

    function getPie2(lc, wrlx) {
        $.ajax({
            type: "post",
            url: Ams.ctxPath + "/environment/letter/countPieBjzt",
            data: {
                lc: lc,
                wrlx: wrlx
            },
            dataType: "json",
            success: function (result) {
                getPieBjzt(result.legend, result.data);
            },
            error: function (r) {
                console.log(r);
            }
        });
    }


    // -------------饼图----------
    function setPieWrlx(legend, data) {
        option2 = {
            title: {
                text: '环保信访件总体情况数据分析',
                top: "10%",
            },
            tooltip: {
                trigger: 'item',
            },
            legend: {
                // orient: 'vertical',
                // top: 10,
                // left: 'center',
                orient: 'horizontal',
                left: '20%',
                top: "20%",
                bottom: 20,
                data: legend
            },
            series: [
                {
                    name: '环保信访件总体情况数据分析',
                    type: 'pie',
                    radius: '55%',
                    left: "25%",
                    center: ['50%', '60%'],
                    data: data,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        WatertypePie.setOption(option2);
    }


    // --------------饼图点击事件----------------
    WatertypePie.off('click');
    WatertypePie.on('click', function (params) {
        var name = params.name;
        var value = params.value;
        getPie2($('#queryStartTime').val(), name);
        $("#airStandardPie").hide();
        $("#airStandardInfo").show();
        $(window).resize(WatertypePie.resize).trigger('resize');

    });

    // -------------饼图详情切换----------
    var infotypePie = echarts.init(document.getElementById('airStandardInfo'));

    function getPieBjzt(legend, data) {
        option3 = {
            title: {
                text: '环保信访件总体情况数据分析办结状态',
                top: "2%",
            },
            tooltip: {
                trigger: 'item',
            },
            legend: {
                orient: 'horizontal',
                left: '30%',
                top: "10%",
                bottom: 20,
                data: legend
            },
            series: [
                {
                    name: '环保信访件总体情况数据分析办结状态',
                    type: 'pie',
                    radius: '55%',
                    left: "25%",
                    center: ['50%', '50%'],
                    data: data,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        infotypePie.setOption(option3);
    }

    infotypePie.off('click');
    infotypePie.on('click', function (params) {
        var name = params.name;
        var value = params.value;
        $("#airStandardPie").show();
        $("#airStandardInfo").hide();
        $(window).resize(infotypePie.resize).trigger('resize');
    });

    $(window).resize(function () {
        airChart.resize();
        WatertypePie.resize();
        infotypePie.resize();
    });

    $(document).ready(function () {
        $("#airStandardInfo").hide()
    });

    //获取数据柱状图
    function getStateNumToBar() {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/letter/countStateNum',
            data: {
                'type': $('#queryStartTime').val()
            },
            success: function (result) {
                charShow(result.legendData, result.jdxbj, result.ybj, result.yxh, result.xList)
            },
            dataType: 'json'
        });
    }

    //柱状图显示
    function charShow(legendData, jdxbj, ybj, yxh, xList) {
        option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'none'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            title: {
                text: '环保信访件总体情况数据分析',
            },
            legend: {
                top: "0%",
                right: "2%",
                data: legendData
            },

            grid: {
                left: '3%',
                right: '4%',
                bottom: '0%',
                containLabel: true
            },
            xAxis: {
                data: xList,
                triggerEvent: true,// x轴文字点击事件
                axisLabel: {
                    type: 'category',
                    interval: 0,
                    formatter: function (value) {
                        return value.split(",")[0].split('').join('\n');
                    },
                    textStyle: {
                        fontSize: 14      //更改坐标轴文字大小
                    }
                },
            },
            yAxis: {
                axisLine: {
                    show: false
                },
                axisTick: {
                    show: false
                },
                axisLabel: {
                    textStyle: {
                        color: '#999'
                    }
                }
            },
            series: [
                {
                    // itemStyle: {
                    //     normal: {
                    //         //这里是重点
                    //         color: function(params) {
                    //             //注意，如果颜色太少的话，后面颜色不会自动循环，最好多定义几个颜色
                    //             var colorList = ['#61a0a8', '#61a0a8',  '#91c7ae','#749f83', '#ca8622'];
                    //             return colorList[params.dataIndex]
                    //         }
                    //     }
                    // },

                    name: '阶段性办结',
                    type: 'bar',
                    barWidth: '15',
                    color: '#03bbff',
                    data: jdxbj
                },

                {
                    name: '已办结',
                    type: 'bar',
                    barWidth: '15',
                    color: '#10e396',
                    data: ybj
                },
                {
                    name: '已销号',
                    type: 'bar',
                    barWidth: '15',
                    color: '#fb544c',
                    data: yxh,
                    markLine: {
                        lineStyle: {
                            normal: {
                                type: 'dashed'
                            }
                        },

                    }
                },

            ]
        };

        airChart.setOption(option);


    }
</script>

</body>


</html>