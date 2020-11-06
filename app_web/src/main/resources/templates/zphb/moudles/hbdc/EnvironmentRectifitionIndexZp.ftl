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
<#include "/zphb/moudles/hbdc/hbdcToolbar.ftl">
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
<input style="display: none;" id="authority" value="${authority!}">
<div id="myPrint" class="container" style="position:relative;left:0px;right:0px;bottom:0px;margin: 0 30px; overflow: hidden">

    <!-- 空气 main -->
    <div class="column-panel-table">
        <div class="column-panel-group col-xs-12">
            <div class="column-panel">
                <div class="column-panel-header">
                    <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                    <span style="position: absolute;right: 42%;padding: 8px;padding-top: 0px;">
						<font style="font-size: 180%;font-weight: bold !important;">漳浦县环保督察总体情况</font>
					</span>
                    <a id="printImg" onclick="Ams.doPrint('myPrint')" class="printing-button">
                        <span class="icon iconcustom yl_print" /></span> 打印
                    </a>
                    <a id="exportImg" onclick="Ams.exportPdfById('myPrint','漳浦县环保督察总体情况')" class="printing-button">
                        <span class="icon iconcustom icon-PDFwenjian yl_print"></span>导出PDF
                    </a>

                    <div class="article-area tc">
                        <div id="toolbar">
                            <div  id="searchBar yl-searchBar">
                                <div class="searchBar-style">
                                   <#-- <label class="control-label"></label>
                                    <input id="queryStartTime" type="text" class="layui-input" style="width: 190px;height: 38px;" readonly="">
                                    <span style="color: #7b7d7d"> - </span>
                                    <input id="queryEndTime" type="text" class="layui-input" style="width: 190px;height: 38px;" readonly="" >-->
                                    <input name="queryStartTime" id="queryStartTime" class="easyui-combobox"
                                            data-options="
                                        editable:false,
                                        url:'${request.contextPath}/zphb/environment/rectifition/getNumOfRound',
                                        valueField:'id',
                                        textField:'name',
                                        onLoadSuccess: function (data) {
                                            if (Ams.isNoEmpty(data)&&data) {
                                               $('#queryStartTime').combobox('setValue',data[0].id);//选择后台查出来的第一个值
                                            }
                                        }
                                        " label="" style="width:250px;">
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
                                <span>总体情况数据分析</span>
                            </div>
                            <div id="airChart" class="fl" style="width:100%;min-height: 600px;"></div>
                        </div>
                        <!-- 本年优良率与上年同期对比 -->
                        <div class="ztqk-right-box" >
                            <div class="data-font" >
                                <span>总体情况数据分析</span>
                            </div>
                            <div id="airStandardPie" class="oh" style="width:100%;min-height:600px;"></div>
                            <div id="information"  class="information-text" >总体情况 我县中央环保督察问题24个，截至3月25日，我县应完成整改任务13个，11个达到序时进度。已完成整改13个，完成市级验收13个，完成行业审查4个。
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>


    </div>

    <!-- 空气 main over -->
</div>


<!-- 引入底部文字提示 main  over-->
<div id="dlg" class="easyui-dialog" style="width:800px; min-height:280px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">


    <div class="easyui-tabs easyui-tabs-bg" style="height:110%">
        <div style="padding:10px">
            <div class="easyui-layout" fit=true>
                <table id="dgDescription" class="easyui-datagrid" style="width:100%;height:auto;"
                       data-options="
			            rownumbers:true,
			            singleSelect:true,
			            striped:true,
			            autoRowHeight:true,
			            fitColumns:true,
			            fit:true,
			            pagination:true,
			            pageSize:10,
			            pageList:[10,20,50]">
                    <thead>
                    <tr>
                        <th field="name" width="120px" formatter="Ams.tooltipFormat">描述</th>
                        <th field="opera" width="50px" data-options="formatter:operation">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div style="padding:10px">
            <div class="easyui-layout" fit=true>
                <table id="dgDetail" class="easyui-datagrid" style="width:100%;"
                       data-options="
			            rownumbers:true,
			            singleSelect:true,
			            striped:true,
			            autoRowHeight:true,
			            fitColumns:true,
			            fit:true,
			            pagination:true,
			            pageSize:10,
			            pageList:[10,20,50]">
                    <thead>
                    <tr>
                        <th field="require" width="100px" Resizable=false formatter="Ams.tooltipFormat">任务具体整改要求 </th>
                        <th field="question" width="100px" Resizable=false formatter="Ams.tooltipFormat">目前进展情况及存在问题</th>
                        <th field="status" width="50px" Resizable=false formatter="formatStatus">完成情况 </th>
                    </tr>
                    </thead>
                </table>

            </div>
        </div>
        <div style="padding:10px">
            <div class="easyui-layout" fit=true>
                <table id="dgDescriptionAll" class="easyui-datagrid" style="width:100%;height:auto;"
                       data-options="
			            rownumbers:true,
			            singleSelect:true,
			            striped:true,
			            autoRowHeight:true,
			            fitColumns:true,
			            fit:true,
			            pagination:true,
			            pageSize:10,
			            pageList:[10,20,50]">
                    <thead>
                    <tr>
                        <th field="name" width="80px" formatter="Ams.tooltipFormat">项目</th>
                        <th field="describe" width="80px" formatter="Ams.tooltipFormat">描述</th>
                        <th field="opera" width="50px" data-options="formatter:operation">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>
<div id="dlg-buttons">
    <a href="javascript:onClick=close()" class="easyui-linkbutton c6" iconCls="icon-ok"  style="width:90px">关闭</a>
</div>
<!-- 引入底部文字提示 main -->
<#include "/moudles/debriefing/tips-font.ftl"/>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/js/html2canvas.js" charset="utf-8"></script>
<script type="text/javascript">
    // 1代表点击了柱状图或圆饼图 2表示点击了表格中的查看按钮。
    var flag = 0;
    // 1代表点击的是柱状图 2代表点击的是圆饼图
    var f = 0;
    function operation(val, row, index) {
        var id = row.uuid;
        var html = "<div>"+Ams.setImageSee()+"<a href='javascript:onClick=showDescribe(\""+id+"\")' class='easyui-linkbutton'>查看</a></div>"
        return html
    }
    //点击柱状图或者横轴项目名称打开窗口
    function getDecription(id,name,status){
        f= 1;
        $('#dlg').dialog('open').dialog('center');
        $(".tabs-header li").eq(0).click();
        $(".tabs-header .tabs-wrap").hide();
        $('#dgDescription').datagrid({
            url:"${request.contextPath}/zphb/environment/rectifition/getDecription?id="+id+"&status="+status+"&startTime="+startTime+"&endTime="+startTime,
            onLoadSuccess:function(data){
//            	var data = $('#dgDescription').datagrid('getData');
                $('#dlg').dialog('setTitle', name);
            }
        });

    }
    //点击饼图打开窗口
    function getDecriptionAll(name,value){
        f = 2;
        $('#dlg').dialog('open').dialog('center').dialog('setTitle',name+" "+value+" 个 ");
        $(".tabs-header li").eq(2).click();
        $(".tabs-header .tabs-wrap").hide();
        $('#dgDescriptionAll').datagrid({
            url:"${request.contextPath}/zphb/environment/rectifition/getDecriptionAll?status="+name+"&startTime="+startTime+"&endTime="+startTime,
        });
    }

    //获取描述的详情
    function showDescribe(id){
        $(".tabs-header li").eq(1).click();
        $('#dgDetail').datagrid({
            url:"${request.contextPath}/zphb/environment/rectifition/getDetail?id="+id,
        });
        $("#dlg-buttons a").text("返回");
        flag = 1;
    }

    function close(){
        if(flag == 1 ){
            if(f==2){
                $(".tabs-header li").eq(2).click();
                $("#dlg-buttons a").text("关闭");
                flag = 0;
            }else if(f==1){
                $(".tabs-header li").eq(0).click();
                $("#dlg-buttons a").text("关闭");
                flag = 0;
            }

        }else if(flag == 0){
            $('#dlg').dialog('close');
        }
    }

    /*layui.use('laydate', function(){
        var laydate = layui.laydate;
        //年月选择器
        var date=new Date();
        var year = date.getFullYear();
        var initYear = year;
        var endYear = year;

        var startTime = laydate.render({
            elem: '#queryStartTime',
            type: 'year',
            format: 'yyyy',
            max: date.getFullYear(),
            showBottom: false,
            ready: function(date){
                initYear=date.year;
            },
            change: function(value, date, endDate){
                var selectYear = date.year;
                var differ = selectYear-initYear;
                if (differ == 0) {
                    if($(".layui-laydate").length){
                        $("#queryStartTime").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                initYear = selectYear;
                if(startTime==value){
                    endTime.config.min = {
                        year: date.year,
                        date: date.date
                    }
                }
            }
        });
        //年月选择器
        var endTime = laydate.render({
            elem: '#queryEndTime',
            type: 'year',
            format: 'yyyy',
            value: date,
            min: getNowDate(),
            showBottom: false,
            ready: function(date){
                endYear=date.year;
            },
            change: function(value, date, endDate){
                var selectYear = date.year;
                var differ = selectYear-endYear;
                if (differ == 0) {
                    if($(".layui-laydate").length){
                        startTime.config.max = {
                            year: date.year,
                            date: date.date
                        }
                        $("#queryEndTime").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                endYear = selectYear;
            }
        });

    });*/

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
            /*var d = new Date();
            $('#queryStartTime').val(d.getFullYear());
            $('#queryEndTime').val(d.getFullYear());*/
            doSearch();
        });

    };

    var placeHolderStyle = {
        normal: {
            color: '#f2f2f2'
        },
        emphasis: {
            color: '#f2f2f2'
        }
    };

    var nameValue = "";
    var labelOption = {
        normal: {
            show: true,
            formatter:function(value)
            {
                if(value.name.indexOf(",")>-1){
                    nameValue = value.name;
                }
                var i=0;
                if(value.seriesName=="未达到序时进度"){
                    i=Number(1);
                }else if(value.seriesName=="达到序时进度"){
                    i=Number(2);
                }else if(value.seriesName=="超过序时进度"){
                    i=Number(3);
                } else if(value.seriesName=="完成整改"){
                    i=Number(4);
                } else if(value.seriesName=="完成交账销号"){
                    i=Number(5);
                }
                var temp=nameValue.split(",")[i];
                if(temp){
                    return value.seriesName.split("").join("\n") + "\n"+temp +"\n个";
                }
            },
            fontSize: 13,
            color:'white',
            rich: {
                name: {
                    textBorderColor: '#000000'
                }
            }
        }
    };

    var airChart = echarts.init(document.getElementById('airChart'));
    var WatertypePie = echarts.init(document.getElementById('airStandardPie'));

    $(window).resize(function () {
        $('#airChart').width('100%');
        $('#airStandardPie').width('100%');
        airChart.resize();
        WatertypePie.resize();
    });

    var startTime ='2019';
    var endTime ='2019';
    function doSearch(){
        startTime = $('#queryStartTime').combobox('getValue');
        endTime = startTime;
        /*if (!Ams.isNoEmpty(endTime)||!Ams.isNoEmpty(startTime)){
            Ams.alert('提示信息', '时间区间不能为空！');
            return;
        }*/
        getAirQualityStatistics(startTime,endTime);
        getdata(startTime,endTime);
    }

    function getdata(startTime,endTime){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/zphb/environment/rectifition/getEcharts',
            async:true,
            data : {
                startTime:startTime,
                endTime:endTime
            },
            success: function (data) {
                var remark = "截至 "+endTime.split("-")[0]+" 年，"+" 我县中央环保督察问题，"
                    + "尚未启动任务 "+data.ns+" 个，"
                    + "未达到序时进度任务 "+data.nr+" 个，"
                    + "达到序时进度任务 "+data.ot+" 个，"
                    + "超过序时进度任务 "+data.ps+" 个，"
                    + "完成整改任务 "+data.ov+" 个，"
                    + " 完成交账销号任务 "+data.sa+" 个。";
                $("#information").html(remark);
                setDataCharts(data.xAxisData, data.seriesData.split(','));
            },
            error: function (jqXHR, textStatus, errorThrown) {
                airChart.hideLoading();
            },
            dataType: 'json'
        });
    }

    function getAirQualityStatistics(startTime,endTime){
        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/zphb/environment/rectifition/getPieEcharts",
            async:true,
            data : {
                startTime:startTime,
                endTime:endTime
            },
            dataType: "json",
            success: function(data){
                setWatertypePieData(data.legend,data.series);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                airChart.hideLoading();
            }
        });
    }

    function setDataCharts(xAxisData, seriesData){
        var endPercent = (6 / xAxisData.length) * 100;
        var dataChartsOption ={
            //title : {
            //    text: '某站点用户访问来源',
            //    subtext: '纯属虚构',
            //    x:'center'
            //},

            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: ''
                },
                formatter: function (params) {
                    var htmlStr ='<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    for(var i=0;i<params.length;i++){
                        /* var j = 0;
                        *if(params[i].seriesName=="未达到序时进度"){
                             j=Number(1);
                         }else if(params[i].seriesName=="达到序时进度"){
                             j=Number(2);
                         }else if(params[i].seriesName=="超过序时进度"){
                             j=Number(3);
                         } else if(params[i].seriesName=="完成整改"){
                             j=Number(4);
                         } else if(params[i].seriesName=="完成交账销号"){
                             j=Number(5);
                         }*/
                        var text ;
                        var s = Number(params[i].data);
                        switch(s){
                            case 0:text="尚未启动";
                                break;
                            case 1:text="未达到序时进度";
                                break;
                            case 2:text="达到序时进度";
                                break;
                            case 3:text="超过序时进度";
                                break;
                            case 4:text="完成整改";
                                break;
                            case 5:text="完成交账销号";
                                break;
                        }
                        htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:'+params[i].color+';"></span>';
                        htmlStr += text + '<br/>';
                    }
                    htmlStr += '</div>';
                    return htmlStr;
                }
            },
            grid: {

                left: '3%',
                right: '4%',
                bottom: '3%',
                top: '4%',
                containLabel: true
            },
            dataZoom: [//给x轴设置滚动条
                {
                    start:0,//默认为0
                    end: endPercent,
                    type: 'slider',
                    show: true,
                    xAxisIndex: [0],
                    handleSize: 0,//滑动条的 左右2个滑动条的大小
                    height: 8,//组件高度
                    left: 50, //左边的距离
                    right: 40,//右边的距离
                    bottom: 26,//右边的距离
                    handleColor: '#ddd',//h滑动图标的颜色
                    handleStyle: {
                        borderColor: "#cacaca",
                        borderWidth: "1",
                        shadowBlur: 2,
                        background: "#ddd",
                        shadowColor: "#ddd",
                    },
                },
                //下面这个属性是里面拖到
                {
                    type: 'inside',
                    show: true,
                    xAxisIndex: [0],
                    start: 0,//默认为1
                    end: 50
                },
            ],
            xAxis : [
                {
                    type : 'category',
                    data : xAxisData,
                    triggerEvent: true,
                    //data : ['微矿库整改', '东山森林公园', '垃圾渗滤液', '微矿库整改'],
                    axisLabel:{
                        type:'category',
                        interval:0,
                        rotate:-45,
                        // formatter:function(value) {
                        //     value=value.split(",")[0];
                        //     return value;
                        // },
                        //横坐标文字竖着
                        // formatter:function(value)
                        // {
                        //     return value.split(",")[0].split('').join('\n');
                        // },
                        // textStyle: {
                        //     fontSize : 15      //更改坐标轴文字大小
                        // }
                    },
                    axisTick: {
                        alignWithLabel: false
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    splitNumber: 4,
                    max:5,
                    axisLabel:{
                        formatter:function(value){
                            var text = value;
                            switch(value){
                                case 0:text="尚未启动";
                                    break;
                                case 1:text="未达到序时进度";
                                    break;
                                case 2:text="达到序时进度";
                                    break;
                                case 3:text="超过序时进度";
                                    break;
                                case 4:text="完成整改";
                                    break;
                                case 5:text="完成交账销号";
                                    break;
                            }
                            return text;
                        },
                        textStyle: {
                            fontSize : 15      //更改坐标轴文字大小
                        }
                    }
                }
            ],
            series : [
                {
                    name: {
                        normal: {
                            formatter: function (params) {
                                var status = Number(params.value);
                                if (status == 0 ) {
                                    return "尚未启动";
                                } else if (status == 1) {
                                    return "未达到序时进度";
                                }else if (status == 2 ) {
                                    return "达到序时进度";
                                }else if (status == 3) {
                                    return "超过序时进度";
                                }else if (status == 4 ) {
                                    return "完成整改";
                                }else if (status == 5 ) {
                                    return "完成交账销号";
                                }
                            }

                        }
                    },
                    type:'bar',
                    barWidth: '20%',
                    barMaxWidth:30,
                    barMinWidth:30,
                    stack: 'one',
                    color: ['#65B149'],
                    //label: labelOption,
                    data:seriesData,
                    itemStyle: {
                        normal: {
                            color: function (params) {
                                var status = Number(params.value);
                                if (status == 0 ) {
                                    return "#99a3af";
                                } else if (status == 1) {
                                    return "#884FA9";
                                }else if (status == 2 ) {
                                    return "#ffbf26";
                                }else if (status == 3) {
                                    return "#f05040";
                                }else if (status == 4 ) {
                                    return "#51a1fa";
                                }else if (status == 5 ) {
                                    return "#65b149";
                                }
                            }

                        }
                    }

                }
            ]
        };
        airChart.off('click');
        airChart.on('click', function (params) {
            var id ;
            var name;
            var st;
            if(params.componentType == "xAxis"){
                id = params.value.split(",")[1];
                name = params.value.split(",")[0];
                getDecription(id, name, st);
            }else {
                id = params.name.split(",")[1];
                name = params.name.split(",")[0];
                //st = params.seriesName;
                getDecription(id, name, st);
            }
        });
        airChart.setOption(dataChartsOption);
    }

    function setWatertypePieData(legend,series){
        WatertypePie.clear();
        WatertypePieOption ={
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: legend,
            series : [
                {
                    name:'完成情况',
                    type: 'pie',
                    radius : [0, '45%'],
                    center: ['50%', '60%'],
                    data:series,
                    label: {
                        formatter: '{b}:\n{c} 个',
                        textStyle : {
                            fontSize : 14    //文字的字体大小
                        },

                    }
                    /* roseType : 'radius' */

                }
            ]

        };
        WatertypePie.off('click');
        WatertypePie.on('click', function (params) {
            var name = params.name;
            var value = params.value;
            getDecriptionAll(name,value);
        });
        WatertypePie.setOption(WatertypePieOption);
    }

    function color(value, row, index) {
        return 'background-color:#FFFF00;color:#ffffff'
    }

    function getLastDay(year,month) {
        var lastDay= new Date(year,month,0);
        return lastDay.getDate();
    }

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth()+1;
        var date = d.getDate();
        var currentdate = year+"-"+month;
        return currentdate;
    }

    function formatStatus(value,row,index){
        var status = row.status;
        if(status=="OVER"){
            return "完成整改";
        }else if(status=="ONTIME"){
            return "达到序时进度";
        }else if(status=="PASS"){
            return "超过序时进度";
        }else if(status=="NOTSTART"){
            return "尚未启动";
        }else if(status=="NOTREACH"){
            return "未达到序时进度";
        }else if(status=="SENDACCOUNT"){
            return "完成交账销号";
        }else{
            return "";
        }
    }
</script>

</body>


</html>