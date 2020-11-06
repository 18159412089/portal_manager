<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>监测站AQI</title>
</head>
<!-- body -->
<body >
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout p10" >
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
									multiple:true,
									panelHeight:'350px'"
                       style="width:200px;"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="监测站点">监测站点：</label>
                <input class="easyui-combobox" name="pointName" value="${pointCode!}" id="pointName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=2',
									method:'get',
									editable:false,
									valueField:'id',
									textField:'text',
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
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出数据</a>
        </form>

    </div>
    <!-- 搜索栏 over-->

    <div class="chart-group">
        <!-- 数据信息 -->
        <div class="data-info-layout ">
            <div class="other">
                <div class="inline-block">
                    <span class="control-label">监测时间：</span>
                    <span class="control-content">2019年06月 </span>
                </div>
                <div class="inline-block">
                    <span class="control-label">监测站点：</span>
                    <span class="control-content">九湖</span>
                </div>
            </div>
            <div class="row">
                <div class="item col-xs-4">
                    <div class="cell-title">2019年06月01日</div>
                    <div class="cell-content">
                        <div class="inline-block">
                            <span>污染物PH：</span>
                            <span class="em">45</span>
                        </div>
                        <div class="inline-block">
                            <span>氨氮：</span>
                            <span class="em">58</span>
                        </div>
                    </div>
                </div>
                <div class="item col-xs-4">
                    <div class="cell-title">2019年06月01日</div>
                    <div class="cell-content">
                        <div class="inline-block">
                            <span>污染物PH：</span>
                            <span class="em">98</span>
                        </div>
                        <div class="inline-block">
                            <span>氨氮：</span>
                            <span class="em">58</span>
                        </div>
                    </div>
                </div>
                <div class="item col-xs-4">
                    <div class="cell-title">2019年06月01日</div>
                    <div class="cell-content">
                        <div class="inline-block">
                            <span>PH：</span>
                            <span class="em down">98</span>
                        </div>
                        <div class="inline-block">
                            <span>氨氮：</span>
                            <span class="em up">58</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 数据信息over -->
        <!-- 图表栏-->
        <div class="chartBar">
            <div class="chart-box">
                <div id="airPrimaryPollutant" style="width: 100%;height: 420px;"></div>
            </div>
        </div>
    </div>

</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function () {

        // 基于准备好的dom，初始化echarts实例
        var airPrimaryPollutantChart = echarts.init(document.getElementById('airPrimaryPollutant'));
        var airPrimaryPollutantOption= {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : ''        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                top:7,
                data: ['NO2','PM10','PM2.5','O3','CO','SO2']
            },
            title: {
                text: '九湖',
                top:5,
                textStyle:{ //设置主标题风格
                    fontSize: 14,
                    color:'#404040',
                    fontWeight:100,
                },
            },


            grid: {
                top:'50',
                left: '10',
                right: '10',
                bottom: '10',
                containLabel: true
            },
            xAxis:  {
                type: 'category',
                data: ['2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00','2019-5-3  8:00']

            },
            yAxis: {
                type: 'value',
                splitNumber:12,
                min: 0,
                max: 30
            },

            series: [
                {
                    name:'NO2',
                    type:'line',
                    symbol: 'circle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {

                            color: '#2ba4e9'
                        }
                    },
                    data:[3,9,4,2,4,5,7,8,9,9,10,6]
                },
                {
                    name:'PM10',
                    type:'line',
                    symbol: 'triangle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#ff6262'
                        }
                    },
                    data:[5,6,7,7,6,9,12,2,3,6,4,4]
                }
                ,
                {
                    name:'PM2.5',
                    type:'line',
                    symbol: 'star',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#fe8a57'
                        }
                    },
                    data:[3,4,5,6,2,6,8,9,7,10,6,5]
                }
                ,
                {
                    name:'CO',
                    type:'line',
                    symbol: 'star',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#ffbf26'
                        }
                    },
                    data:[10,5,9,6,11,8,13,14,9,6,3,3]
                }
                ,
                {
                    name:'O3',
                    type:'line',
                    symbol: 'diamond',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#9587f1'
                        }
                    },
                    data:[1,2,5,6,8,4,2,7,9,8,2,2]
                }
                ,
                {
                    name:'SO2',
                    type:'line',
                    symbol: 'triangle',
                    symbolSize:6,
                    smooth:false,
                    itemStyle:{
                        normal: {
                            color: '#3fa15a'
                        }
                    },
                    data:[5,7,8,10,11,2,8,6,9,3,6,10]
                }

            ]

        };
        // 使用刚指定的配置项和数据显示图表。
        airPrimaryPollutantChart.setOption(airPrimaryPollutantOption);

        window.onresize = function() {
            $('#airPrimaryPollutant').width('100%');
            airPrimaryPollutantChart.resize();
        }


    })


</script>
</html>