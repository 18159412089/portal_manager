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
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<div class="easyui-layout p10" >
    <!-- 搜索栏 -->
    <div id="searchBar1" class="searchBar">
        <form id="searchForm1">
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="地区">地区:</label>
                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName"/>
            </div>
            <div class="inline-block">
                <label class="textbox-label textbox-label-before" title="时间">时间:</label>
                <input id="startTime" name="startTime" class="easyui-datebox" style="width:156px;">
                <label class="textbox-label textbox-label-before" title="时间">—</label>
                <input id="endTime" name="endTime" class="easyui-datebox" style="width:156px;">
            </div>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" onclick="Ams.exportPdfById('group0','监测站污染物(城市)-同比')" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'">导出数据</a>
            <div class="inline-block fr">
                <!-- 单选按钮组 -->
                <div class="radio-button-group style-btn-group" id="choseDate">
                    <span class="active">日</span>
                    <span>月</span>
                    <span>年</span>
                </div>
                <!-- 单选按钮组 over-->
            </div>
        </form>

    </div>
    <!-- 搜索栏 over-->
    <div class="chart-group" id="group0">

    </div>


</div>
</body>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            $('#startTime').datebox('setValue', Ams.getNowDate_toSecond(7).substring(0, 10));
            $('#endTime').datebox('setValue', Ams.getNowDate_toSecond(0).substring(0, 10));
        });
    };

    $("#regionName").combobox({
        url: "${request.contextPath}/enviromonit/airMonitorPoint/getCity?all=1",
        valueField: 'uuid',//值字段
        textField: 'name',//显示字段
        method: 'POST',
        multiple:true,//多选
        editable: false,//不可编辑只能选择
        value: '  请选择  ',
        onLoadSuccess: function () {
            //数据加载完毕事件,选中第一个数值
            var data = $(this).combobox('getData');
            data[data.length]
            if(data.length != 0){
                $(this).combobox('select', data[0].uuid);
            }
        }
    });

    /*单选按钮组*/
    $(".radio-button-group").on("click", "span", function () {
        $(this).siblings("span").removeClass("active");
        $(this).addClass("active");
        doSearch();
    });

    $(function () {

        window.onresize = function() {
            $('#airPrimaryPollutant').width('100%');
            airPrimaryPollutantChart.resize();
            $('#airPrimaryPollutant2').width('100%');
            airPrimaryPollutantChart2.resize();
            $('#airPrimaryPollutant3').width('100%');
            airPrimaryPollutantChart3.resize();
        }


    })

    function doSearch(){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/enviromonit/airPollute/analysisPointCharts',
            data:{
                dateType : getDateType(),
                pointName : getRegionName(),
                start : getStartTime(),
                end : getEndTime(),
            },
            async:true,
            dataType: "json",
            beforeSend: function () {
                loadIndex = layer.load(1, {
                    shade: [0.1, '#fff']
                });
            },
            complete: function () {
                layer.close(loadIndex);
            },
            success: function (result) {
                console.info(result);
                if(result.length==0){
                    return;
                }
                var dateFormat = "";
                var lastDateFormat = "";
                var nowTime = result[0].pollute.nowTime.split("-");
                var lastTime = result[0].pollute.lastTime.split("-");
                if(getDateType() == "日"){
                    dateFormat = nowTime[0]+"年"+nowTime[1]+"月"+nowTime[2]+"日";
                    lastDateFormat = lastTime[0]+"年"+lastTime[1]+"月"+lastTime[2]+"日";
                }else if(getDateType() == "月"){
                    dateFormat = nowTime[0]+"年"+nowTime[1]+"月";
                    lastDateFormat = lastTime[0]+"年"+lastTime[1]+"月";
                }else if(getDateType() == "年"){
                    dateFormat = nowTime[0]+"年";
                    lastDateFormat = lastTime[0]+"年";
                }
                var html = "";
                $("#group0").html(html);
                for(var j=result.length-1;j>=0;j--){
                    var compare = '';
                    if(result[j].pollute.last != "-" && result[j].pollute.last == result[j].pollute.now){
                        if(result[j].pollute.lastVal > result[j].pollute.nowVal){
                            compare = '<span>'+result[j].pollute.last+'：</span><span class="em down">'+result[j].pollute.nowVal+'</span>';
                        }else{
                            compare = '<span>'+result[j].pollute.last+'：</span><span class="em up">'+result[j].pollute.nowVal+'</span>';
                        }
                    }else if(result[j].pollute.last == "-" && result[j].pollute.last == result[j].pollute.now){
                        compare = '<span>无首要污染物</span>';
                    }else {
                        compare = '<span>首要污染物不同，暂时无法比较</span>';
                    }
					html += '<div class="chart-group"><div class="data-info-layout "><div class="other">'+
							'<div class="inline-block"><span class="control-label">监测时间：</span>'+
							'<span class="control-content">'+dateFormat+'</span></div><div class="inline-block">'+
							'<span class="control-label">监测站点：</span><span class="control-content">'+result[j].title+'</span>'+
							'</div></div><div class="row"><div class="item col-xs-4"><div class="cell-title">'+dateFormat+'</div>'+
							'<div class="cell-content"><div class="inline-block"><span>首要污染物：'+result[j].pollute.now+'</span>'+
							'<span class="em">'+result[j].pollute.nowVal+'</span></div></div></div>'+
							'<div class="item col-xs-4"><div class="cell-title">'+lastDateFormat+'</div><div class="cell-content">'+
							'<div class="inline-block"><span>首要污染物：'+result[j].pollute.last+'</span>'+
							'<span class="em">'+result[j].pollute.lastVal+'</span></div></div></div><div class="item col-xs-4">'+
							'<div class="cell-title">'+dateFormat+'与'+lastDateFormat+'同比</div><div class="cell-content"><div class="inline-block">'+
							compare+'</div></div></div></div></div><div class="chartBar"><div class="chart-box">'+
							'<div id="charts'+j+'" style="width: 100%;height: 420px;"></div></div></div></div>';
				}
                $("#group0").html(html);
                for(var j in result){
                    var charts = echarts.init(document.getElementById('charts'+j));
                    setCharts(charts, result[j].title, result[j].xAxis, result[j].series);
                }
            }
        });
    }

    function getRegionName(){
        var regionName = $('#regionName').combobox('getValues');
        if(regionName == "all"){
            var result = "";
            var data = $('#regionName').combobox('getData');
            for(var i=0;i<data.length;i++){
                if(data[i].uuid != "all"){
                    result += data[i].uuid + ',';
                }
            }
            result = result.substr(0,result.length-1);
            return result;
        }
        return regionName.toString();
    }

    function getStartTime(){
        return $("#startTime").val();
    }

    function getEndTime(){
        return $("#endTime").val();
    }

    function getDateType(){
        var dateType = $("#choseDate span.active").text();
        if(dateType == "年"){

        }else{

        }
        return dateType;
    }

    function setCharts(pollutionAnalysis, title, xAxis, series){
        pollutionAnalysis.clear();
        var option = {
            title: {
                text: title,
                textStyle:{
                    fontSize: 16
                },
                left:'10',
                top:'10'
            },
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : ''        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            toolbox: {
                show: true,
                orient: 'vertical',
                left: '10',
                top: 'center',
                iconStyle: {
                    borderColor: '#ffffff'
                },
                feature: {
                    magicType: {show: true, type: ['line', 'bar']},
                    saveAsImage: {show: true},
                    restore: {show: true}
                }
            },
            legend: {
                orient: 'horizontal',
                top: '8%',
                right:'30',
                data: ['PM2.5','PM10','SO2','NO2','CO','O3-8h']
            },
            grid: {
                top:'80',
                left: '50',
                right: '30',
                bottom: '10',
                containLabel: true
            },
            xAxis:  {
                type: 'category',
                axisLabel:{
                    type:'category'
                },
                data: xAxis
            },
            yAxis: [{
                type: 'value',
                axisLabel:{
                    formatter:'{value}(μg/m3)'
                }
            },{
                type: 'value',
                axisLabel:{
                    formatter:'{value}(mg/m3)'
                }
            }],
            series: series
        };
        pollutionAnalysis.setOption(option);
    }
</script>
</html>