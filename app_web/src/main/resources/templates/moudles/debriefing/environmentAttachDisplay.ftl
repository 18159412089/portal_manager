<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<head>
    <title>一本账-总体情况</title>
    <link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css"  media="all">
</head>
<body >
<#include "/decorators/header.ftl"/>
<#include "/common/loadingDiv.ftl"/>
<#include "/passwordModify.ftl">
<#--<#if authority??>
    <#include "/accountMenu.ftl">
<#else>
    <#include "/inputAccountMenu.ftl">
</#if>-->
<#include "/secondToolbar.ftl">
<style type="text/css">
    .layui-input{
        display: inline;
        border-radius:4px !important;
        border:1px solid #cfcfcf;
        width: 131px !important;
        height: 35px;
    }
    html{
        min-width: 1024px!important;
    }
    .easyui-layout{
        height: auto!important;
    }
    .panel-fit, .panel-fit body{
        overflow: auto!important;
        background-color: #f3f8f6;
    }


</style>
<!-- datagrid -->
<input style="display: none;" id="authority" value="${authority!}">
<div class="easyui-layout" fit=true style="padding:0px 30px 60px 30px;width: 100%" id="myPrint">
    <div id="toolbar" >
        <div  class="ybz-title">
            <a id="printImg" onclick="Ams.doPrint('myPrint')" class="printing-button" >
                <span  class="icon iconcustom yl_print" /></span> 打印
            </a>
            <div class="ybz-title-box" >漳州市八闽快讯(一本账)总体情况</div>
        </div>
        <form>
            <div class="input-content yl-input-content" style="position: relative;">
                <input id="startTime" type="text" class="layui-input" style="width: 170px !important; height: 33px;border: 1px solid #45b97c;
    background-color: #f3f8f6;" readonly="">
                <span>-</span>
                <input id="endTime" type="text" class="layui-input" style="width: 170px !important; height: 33px;border: 1px solid #45b97c;
    background-color: #f3f8f6;" readonly="">
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
            </div>
        </form>
    </div>
    <div class="ybz-left-box">
        <div class="data-font">
            <span>总体情况数据分析</span>
        </div>
        <div id="chart" style="height:750px;width:100%;"></div>
    </div>
    <div class="ybz-right-box">
        <div class="data-font">
            <span>总体情况数据分析</span>
        </div>
        <div id="pie" style="height:750px;width:100%;"></div>
        <div id="message" class="information-text" ></div>
    </div>
    <!-- 引入底部文字提示 main -->
<#include "/moudles/debriefing/tips-font.ftl"/>
</div>
<div id="dlg" class="easyui-dialog" style="width:800px; height:600px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <div id="toolbar1" >
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label" id="name">文件名称：</label>
                <input type="text" id="standingBookName" name="standingBookName" class="easyui-textbox" style="width:156px;">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearchFile()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
            </form>
        </div>
    </div>

    <table id="dgAttachment" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar1"
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
            <th field="fileName" width="120px" data-options="formatter:newFile">文件名称</th>
            <th field="opera" width="50px" data-options="formatter:operation">操作</th>
        </tr>
        </thead>
    </table>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="$('#dlg').dialog('close')"
       style="width:90px">关闭</a>
</div>
<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;" data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload >您的浏览器不支持 video 标签。</video>
</div>
<script src="${request.contextPath}/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script>
    var chart = echarts.init(document.getElementById('chart'));
    var pie = echarts.init(document.getElementById('pie'));
    var myVideo = document.getElementById("video");

    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //年月选择器
        var date=new Date();
        var year = date.getFullYear();
        var initYear = year;
        var endYear = year;

        var startTime = laydate.render({
            elem: '#startTime',
            type: 'month',
            format: 'yyyy-MM',
            max: getNowDate(0)+"-01",
            showBottom: false,
            ready: function(date){
                initYear=date.year;
            },
            change: function(value, date, endDate){
                var selectYear = date.year;
                var differ = selectYear-initYear;
                if (differ == 0) {
                    if($(".layui-laydate").length){
                        $("#startTime").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                initYear = selectYear;
                if($("#startTime").val()==value){
                    var d2 = new Date();
                    endTime.config.max = {
                        year: d2.getFullYear(),
                        month: d2.getMonth(),
                        date: date.date
                    };
                    endTime.config.min = {
                        year: date.year,
                        month: date.month-1,
                        date: date.date
                    }
                }
            }
        });
        //年月选择器
        var endTime = laydate.render({
            elem: '#endTime',
            type: 'month',
            format: 'yyyy-MM',
            value: date,
            max: getNowDate(0)+"-01",
            min: getNowDate(30)+"-01",
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
                            month: date.month-1,
                            date: date.date
                        }
                        $("#endTime").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                endYear = selectYear;
            }
        });

    });

    $(function(){
        $('#startTime').val(getNowDate(30));
        $('#endTime').val(getNowDate(0));
        doSearch();
    });


  
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearchFile();
    }


    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    // 操作
    function operation(val, row, index) {
        var html ="<div>";
        var name = row.fileName;
        name = name.substring(name.lastIndexOf('.')+1,name.length);
        if(name == 'mp4'){
            html += Ams.setImageSee()+"<a href='javascript:onClick=play(\""+row.mongoid+"\")' class='easyui-linkbutton'>查看</a>&emsp;"
        }else if(name == 'pdf'||name == 'png'||name == 'jpg'){
            html += Ams.setImageSee()+"<a href='/debrief/StandingBook/browse/"+row.mongoid
                    + "' class='easyui-linkbutton' target='_blank'>查看</a>&emsp;";
        }
        html += Ams.setImageDown()+"<a href='/debrief/StandingBook/download/"+row.mongoid
                + "' class='easyui-linkbutton' target='_blank'>下载</a></div>";
        return html;
    }

    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });

    // 播放
    function play(mongoid){
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
        $('#video').attr("src", Ams.ctxPath+'/debrief/StandingBook/browse/'+mongoid);
    }
    function newFile(val, row, index) {
        var name = row.fileName;
        var html = "";
        name = name.substring(name.lastIndexOf('.')+1,name.length);
        html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/white.png">'+ row.fileName+'<div>';
        if ('pdf'==name){
            html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/pdf.png">'+ row.fileName+'<div>';
        }else if('word'==name){
            html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/word.png">'+ row.fileName+'<div>';
        }else if('xls'==name ||'xlsx'==name){
            html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/xls.png">'+ row.fileName+'<div>';
        }else if('png'==name ||'jpg'==name){
            html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/png.png">'+ row.fileName+'<div>';
        }else if('mp4'==name ||'mp3'==name){
            html ='<div><img width="18px" heigth="18px" style="vertical-align:-4px;margin:0 3px 0px 5px;" src="/static/images/attachment/mp4.png">'+ row.fileName+'<div>';
        }
        return html
    }
    function doSearchFile(){
        $('#dgAttachment').datagrid('load', {
            name : $("#standingBookName").val(),
        });
    }
    function doSearch() {
        var startTime = $('#startTime').val();
        var endTime = $('#endTime').val();
        if (!Ams.isNoEmpty(startTime)||!Ams.isNoEmpty(endTime)) {
            Ams.alert('提示信息', '时间区间不能为空！');
            return;
        }if (startTime > endTime) {
            Ams.alert('提示信息', '结束时间不能大于起始时间！');
            return;
        }

        $.ajax({
            type: "post",
            url:  Ams.ctxPath + "/environment/attach/getChartList",
            async : true,
            data: {
                startTime: startTime,
                endTime: endTime
            },
            dataType: "json",
            success: function(data){
                setEcharts(chart,data.name,data.array1,data.array2,data.array3);
                setpieData(pie,data.pieName,data.pieData);
                var sum1=0;
                var sum2=0;
                var sum3=0;
                for(var i=0;i<data.name.length;i++){
                    var temp = data.name[i].split(",");
                    sum1+=Number(temp[2]);
                    sum2+=Number(temp[3]);
                    sum3+=Number(temp[4]);
                }
                var month = endTime.split("-")[1] != "10"?endTime.split("-")[1].replace("0",""):endTime.split("-")[1]
                var html="截至"+endTime.split("-")[0]+"年"+month+"月";
                html+="，《八闽快讯》（专报件）共通报突出环境问题 "+data.sum+" 个（上期 "
                        +data.lastSum+" 个，本期新增 "+(data.sum-data.lastSum)+" 个），已完成整改 "
                        +sum1+" 个，继续整改 "+sum2+" 个，未达到序时进度 "+sum3+" 个。";
                $("#message").html(html);
            },
            error: function(r){console.log(r);}
        });
    }

    function setpieData(pie,name,data){
        pie.clear();
        pieOption ={
            tooltip : {
                trigger: 'item',
                formatter: function(value){
                    return value.name.split(",")[0]+value.name.split("：")[1];
                }

                //"{a} <br/>{b}"
            },
            color:['#76b7cb', '#6cc1ac', '#cca073'],
            legend: {
                orient: 'horizontal',
                top: '0',
                left:'20',
                data: name,
                formatter: function (name) {
                    return name.split(",")[0]+"："+name.split("：")[1];
                }
            },
            series : [
                {
                    name: '统计',
                    type: 'pie',
                    radius : [0, '50%'],
                    center: ['50%', '55%'],
                    data: data,

                    label: {
                        show: true,
                        normal : {
                            formatter: function (value) {
                                return value.name.split(",")[0]+value.name.split("：")[1];
                            }
                        }
                    },
                    itemStyle : {
                        normal : {
                            label : {
                                show: true,
                                position : 'outer'
                            },
                            labelLine : {
                                show : true,
                                length:1
                            }
                            /*,color:function(params) {
                                //自定义颜色
                                var colorList = [
                                    '#6FC250', '#00FF00', '#FFFF00', '#FF8C00', '#FF0000', '#FE8463',
                                ];
                                return colorList[params.dataIndex]
                            }*/
                        }
                    },
                    animationType: 'scale',
                    animationEasing: 'elasticOut',
                    animationDelay: function (idx) {
                        return Math.random() * 200;
                    }
                    /* roseType : 'radius' */

                }
            ]

        };
        pie.off('click');
        pie.on('click', function (params) {
            var name = params.name.split(",")[1].split("：")[0];
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '查看（'+params.name.split(",")[0]+'）文件');
            $('#dgAttachment').datagrid({

                url:"${request.contextPath}/debrief/StandingBook/attachmentList?relationTableId="+name,
            });
        });
        pie.setOption(pieOption);
    }

    var labelOption = {
        normal: {
            show: true,

            formatter:function(value)
            {
                var i=0;
                if(value.seriesName=="完成整改"){
                    i=Number(2);
                }else if(value.seriesName=="继续整改"){
                    i=Number(3);
                }else if(value.seriesName=="未达到序时进度"){
                    i=Number(4);
                }
                value = value.seriesName.split("").join("\n")+"\n"+value.name.split(",")[i]+"\n个";
                return value;
            },
            fontSize: 14,
            color:'#ffffff',
            rich: {
                name: {
                    textBorderColor: '#000000'
                }
            }
        }
    };
    window.onresize = function() {
        $('#pie').width('100%');
        $('#chart').width('100%');
        pie.resize();
        chart.resize();
    }
    function setEcharts(chart,name,array1,array2,array3){
        chart.clear();
        var option = {
            title: {
                text: "",
                textStyle:{
                    fontSize: 16
                },
                left:'50%',
                top:'5%'
            },
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : ''        // 默认为直线，可选为：'line' | 'shadow'
                },
                formatter: function (params) {
                    var htmlStr ='<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    for(var i=0;i<params.length;i++){
                        var j = 0;
                        if(params[i].seriesName=="完成整改"){
                            j=Number(2);
                        }else if(params[i].seriesName=="继续整改"){
                            j=Number(3);
                        }else if(params[i].seriesName=="未达到序时进度"){
                            j=Number(4);
                        }

                        htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:'+params[i].color+';"></span>';
                        htmlStr += params[i].seriesName + '：'+params[i].name.split(",")[j] + '<br/>';
                    }
                    htmlStr += '</div>';
                    return htmlStr;
                }
            },
            toolbox: {
                show: true,
                orient: 'vertical',
                left: '50',
                top: 'center',
                iconStyle: {
                    borderColor: '#ffffff'
                },
                feature: {
                    magicType: {show: true, type: ['bar']},
                    saveAsImage: {show: true},
                    restore: {show: true}
                }
            },
            legend:{
                right:'80',
                data:['完成整改', '继续整改', '未达到序时进度']
            },
            grid: {
                top:'80',
                left: '80',
                right: '80',
                bottom: '40',
                containLabel: true
            },
            xAxis:  {
                type: 'category',
                axisLabel:{
                    type:'category',
                    interval:0,
                    rotate:20,
                    formatter:function(value)
                    {
                        value=value.split(",")[0];
                        return value;
                    },
                    textStyle: {
                        fontSize : 15      //更改坐标轴文字大小
                    }
                },
                data:name
            },
            color:['#51A1FA','#FFBF26','#65B149'],
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: function (v) {
                        if(v==3){
                            return "完成整改";
                        }
                        else if(v==2){
                            return "继续整改";
                        }
                        else if(v==1){
                            return "未达到序时进度";
                        }
                    },
                    textStyle: {
                        fontSize : 15      //更改坐标轴文字大小
                    }
                }
            },
            series:[
                {
                    name: '完成整改',
                    type: 'bar',
                    barMaxWidth:30,
                    barMinWidth:30,
                    label:labelOption,
                    data: array1
                },
                {
                    name: '继续整改',
                    type: 'bar',
                    barMaxWidth:30,
                    barMinWidth:30,
                    label:labelOption,
                    data: array2
                },
                {
                    name: '未达到序时进度',
                    type: 'bar',
                    barMaxWidth:30,
                    barMinWidth:30,
                    label:labelOption,
                    data: array3
                }
            ]
        };
        chart.off('click');
        chart.on('click', function (params) {
            var name = params.name.split(",")[1];
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '查看（'+params.name.split(",")[0]+'）文件');
            $('#dgAttachment').datagrid({

                url:"${request.contextPath}/debrief/StandingBook/attachmentList?relationTableId="+name,
            });
        });
        chart.setOption(option);
    }

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth()+1;
        var date = d.getDate();
        if(month>=0 && month<=9){
            month="0"+month;
        }
        var currentdate = year+"-"+month;
        return currentdate;
    }
</script>
</body>
</html>