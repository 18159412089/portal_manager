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
    .monitor-container{margin:16px 0;}
    .monitor-container .monitor-title{width: 48px;font-weight: normal;}
    .layui-input{display: inline;}
    .col-xs-12{
        padding: 0px;
    }
    input[type="text"]{
        background-color: #f3f8f6;
        border: 1px solid #45b97c;
    }
    #pf-hd .pf-user .pf-user-photo{
        margin: 0px;
    }
    html{
        min-width: 1024px!important;
        height: inherit;
    }
    #airStandardPie >div >canvas{
        top: -54px !important;
    }

</style>
<input style="display: none;" id="authority">
<div id="myPrint" class="container">

    <!-- 空气 main -->
    <div class="column-panel-table">
        <div class="column-panel-group col-xs-12">
            <div class="column-panel">
                <div class="column-panel-header">
                    <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                    <span style="position: absolute;right: 42%;padding: 8px;padding-top: 0px;">
						<font style="font-size: 180%;font-weight: bold !important;">漳州市环保信访件总体情况</font>
					</span>
                    <a id="printImg" class="printing-button">
                        <span class="icon iconcustom yl_print" /></span> 打印
                    </a>
                    <a id="exportImg"  class="printing-button">
                        <span class="icon iconcustom icon-PDFwenjian yl_print"></span>导出PDF
                    </a>

                    <div class="article-area tc">
                        <div id="toolbar">
                            <div  id="searchBar yl-searchBar">
                                <div class="searchBar-style">
                                    <input name="queryStartTime" id="queryStartTime" class="easyui-combobox"
                                           data-options="
                                        editable:false,
                                        url:'${request.contextPath}/environment/rectifition/getNumOfRound',
                                        valueField:'id',
                                        textField:'name',"
                                        style="width:250px;">
                                    </input>
                                    <a href="#"  class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="column-panel-body" style="margin-top:28px; ">

                    <!-- 近三十日全市AQI -->

                    <div id="exportPic" style="overflow: hidden" >

                        <div class="ztqk-left-box">
                            <div class="data-font" >
                            </div>
                            <div id="airChart" class="fl" style="width:100%;min-height: 600px;"></div>
                        </div>
                        <!-- 本年优良率与上年同期对比 -->
                        <div class="ztqk-right-box" >
                            <div id="airStandardPie" class="oh" style="width:100%;min-height:600px;"></div>
                           <#-- 饼图详情-->
                            <div id="airStandardInfo" class="oh" style="width:100%;min-height:600px;display: none" ></div>

                            <div id="information"  class="information-text" >
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

    // 基于准备好的dom，初始化echarts实例
    var airChart = echarts.init(document.getElementById('airChart'));

    var dataAxis = ['漳州市', '相城区', '常山开发区', '东山县', '长泰县', '平和县', '华安县','长泰县', '平和县'];


    option = {
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'none'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        title: {
            text: '环保信访件总体情况数据分析',
        },
        legend: {
            top:"0%",
            right:"2%",
            data:['阶段性办结','已办结','已销号']
        },

        grid: {
            left: '3%',
            right: '4%',
            bottom: '0%',
            containLabel: true
        },
        xAxis: {
            data: dataAxis,
            triggerEvent: true,// x轴文字点击事件
            axisLabel:{
                type:'category',
                interval:0,
                formatter:function(value)
                {
                    return value.split(",")[0].split('').join('\n');
                },
                textStyle: {
                    fontSize : 14      //更改坐标轴文字大小
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
        series : [
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

                name:'阶段性办结',
                type:'bar',
                barWidth:'15',
                color:'#61a0a8',
                data:[320, 332, 301, 334, 390, 330, 320,400,500]
            },

            {
                name:'已办结',
                type:'bar',
                barWidth:'15',
                color:'#749f83',
                data:[150, 232, 201, 154, 190, 330, 410,500,600]
            },
            {
                name:'已销号',
                type:'bar',
                barWidth:'15',
                color:'#3fa15a',
                data:[862, 1018, 964, 1026, 1679, 1600, 1570,400,500],
                markLine : {
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

    airChart.on('click', function (params) {
        if(params.componentType == "xAxis"){
            alert("单击了"+params.value+"x轴标签");
            window.location.href = "https://localhost:8081/indextemp28";
        }else{
            alert("单击了"+params.name+"柱状图");
            window.location.href = "https://localhost:8081/indextemp28";
        }
    });

    // --------------柱状图点击事件----------------


    // Enable data zoom when user click bar.
    // airChart.on('click', function (params) {
    //     // alert(params.componentType)
    //     if(params.componentType =="series"){
    //         // 跳转详情页
    //         window.location.href = "https://localhost:8081/indextemp28";
    //
    //     }else {
    //         alert("文字点击事件触发")
    //     }
    //     console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
    //     airChart.dispatchAction({
    //         type: 'dataZoom',
    //         startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
    //         endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
    //     });
    // });










// -------------饼图----------
    var WatertypePie = echarts.init(document.getElementById('airStandardPie'));
    option2 = {
        title: {
            text: '环保信访件总体情况数据分析',
            top: "10%",
        },
        tooltip : {
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
            data: ['大气','水','生态','土壤','噪音','其他污染']
        },
        series : [
            {
                name: '大气',
                type: 'pie',
                radius : '55%',
                left:"25%",
                center: ['50%', '60%'],
                data:[
                    {value:300, name:'大气'},
                    {value:300, name:'水'},
                    {value:300, name:'生态'},
                    {value:300, name:'土壤'},
                    {value:300, name:'噪音'},
                    {value:500, name:'其他污染'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },
                        normal: {
                            //这里是重点
                            color: function(params) {
                                //注意，如果颜色太少的话，后面颜色不会自动循环，最好多定义几个颜色
                                var colorList = ['#61a0a8', '#91c7ae',  '#749f83','#e3e8a9', '#747ac3', '#bacbe8'];
                                return colorList[params.dataIndex]
                            }
                        }
                }
            }
        ]
    };
    WatertypePie.setOption(option2);


    // --------------饼图点击事件----------------
    WatertypePie.off('click');
    WatertypePie.on('click', function (params) {
        var name = params.name;
        var value = params.value;
        alert("切换图表")

        $("#airStandardPie").hide();
        $("#airStandardInfo").show();
        $("#airStandardInfo").css({width:"100%",height:"600px"});
        $(window).resize(infotypePie.resize).trigger('resize');


    });


    // -------------饼图详情切换----------
    var infotypePie = echarts.init(document.getElementById('airStandardInfo'));
    option3 = {
        title: {
            text: '环保信访件总体情况数据分析详情',
            top: "2%",
        },
        tooltip : {
            trigger: 'item',
        },
        legend: {
            orient: 'horizontal',
            left: '30%',
            top: "10%",
            bottom: 20,
            data: ['已办结','已销号办结','阶段性办结 50个']
        },
        series : [
            {
                name: '大气',
                type: 'pie',
                radius : '55%',
                left:"25%",
                center: ['50%', '50%'],
                data:[
                    {value:600, name:'已办结'},
                    {value:400, name:'已销号办结'},
                    {value:1000, name:'阶段性办结'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },

                }

            }
        ]
    };
    infotypePie.setOption(option3);

    infotypePie.off('click');
    infotypePie.on('click', function (params) {infotypePie
        var name = params.name;
        var value = params.value;
        alert("切换图表")
        $("#airStandardPie").show();
        $("#airStandardInfo").hide();
        $(window).resize(WatertypePie.resize).trigger('resize');

    });

    $(window).resize(function () {
        airChart.resize();
        WatertypePie.resize();
        infotypePie.resize();
        // var w=(document.body.offsetWidth )/3+50;
        // infotypePie.style.width=w+"px"
        // infotypePie.style.height="600px"
    });




</script>

</body>


</html>