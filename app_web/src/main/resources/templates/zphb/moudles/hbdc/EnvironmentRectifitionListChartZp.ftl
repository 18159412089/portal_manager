<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="en" style="">
<head>
    <title>环保督察-整改汇总表</title>
</head>
<!-- body -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
<body style="background-color: #f3f8f6;padding: 0px 40px;">
<#include "/decorators/header.ftl"/>
<link rel="stylesheet" href="${request.contextPath}/static/css/EcologicalCloudMap.css"/>
<link rel="stylesheet" href="${request.contextPath}/static/layui/css/layui.css" media="all">
<#include "/common/loadingDiv.ftl"/>
<#include "/passwordModify.ftl">
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

</style>
<input style="display: none;" id="authority" value="${authority!}">
<div id="myPrint" class="container" style="position:relative;left:0px;right:0px;bottom:0px;margin: 0 0px; overflow: hidden">

    <!-- 空气 main -->
    <div class="column-panel-table">
        <div class="column-panel-group col-xs-12">
            <div class="column-panel">
                <div class="column-panel-header">
                    <!-- <div class="more"><a href=""><span class="icon iconcustom icon-zhedie3"></span></a></div>  -->
                    <span style="position: absolute;right: 42%;padding: 8px;padding-top: 0px;">
						<font style="font-size: 180%;font-weight: bold !important;">漳浦县环保督察整改汇总图表</font>
					</span>
                    <a id="printImg" onclick="Ams.doPrint('myPrint')" class="printing-button">
                        <span class="icon iconcustom yl_print" /></span> 打印
                    </a>
                    <a id="exportImg" onclick="Ams.exportPdfById('myPrint','漳浦县环保督察整改汇总情况')" class="printing-button">
                        <span class="icon iconcustom icon-PDFwenjian yl_print"></span>导出PDF
                    </a>

                    <#--时间布控查出所有-->
                    <div class="article-area tc" >
                        <div id="toolbar">
                            <div  id="searchBar yl-searchBar">
                                <div class="searchBar-style">
                                    <#--<label class="control-label"></label>
                                    <input id="queryStartTime" type="text" class="layui-input" style="width: 190px;height: 38px;" readonly="">
                                    <span style="color: #7b7d7d"> - </span>
                                    <input id="queryEndTime" type="text" class="layui-input" style="width: 190px;height: 38px;" readonly="" >-->
                                    <input name="queryStartTime" id="queryStartTime" class="easyui-combobox"
                                           data-options="
                                        editable:false,
                                        url:'${request.contextPath}/environment/rectifition/getNumOfRound',
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

                    <div id="exportPic" style="overflow: hidden;background-color: white;padding: 0 10px;" >
                        <div class="data-font" >
                            <span>整改汇总数据分析</span>
                        </div>
                        <div id="airChart" class="fl" style="width:100%;min-height: 580px;"></div>
                    </div>

                </div>
            </div>
        </div>


    </div>

    <!-- 空气 main over -->
    <!-- 引入底部文字提示 main -->
    <#include "/moudles/debriefing/tips-font.ftl"/>
</div>


<!-- 引入底部文字提示 main  over-->
<div id="dlg" class="easyui-dialog" style="width:850px; min-height:460px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">


    <div class="easyui-tabs easyui-tabs-bg" style="height:100%">
        <div style="padding:10px">
            <div class="easyui-layout" fit=true>
                <table id="dgDescription" class="easyui-datagrid" style="width:100%;height:100%;"
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
                        <th field="projectName" width="120px" formatter="Ams.tooltipFormat">项目名称</th>
                        <th field="describleName" width="120px" formatter="Ams.tooltipFormat">描述</th>
                        <th field="require" width="120px" formatter="Ams.tooltipFormat">整改任务具体要求</th>
                        <th field="opera" width="50px" data-options="formatter:operation">操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div style="padding:0px">
                <div  class="details-info-box" id="rectifition">
                </div>
        </div>
    </div>
</div>
<div id="dlg-buttons">
    <a href="javascript:onClick=close()" class="easyui-linkbutton c6" iconCls="icon-ok"  style="width:90px">关闭</a>
</div>
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
    function getDecription(pointCode,pointName){
        f= 1;
        $('#dlg').dialog('open').dialog('center');
        $('#dlg').dialog('setTitle', pointName);
        $(".tabs-header li").eq(0).click();
        $(".tabs-header .tabs-wrap").hide();
        $('#dgDescription').datagrid({
            url:"${request.contextPath}/environment/rectifition/listNew?areaCode="+pointCode+"&startTime="+startTime+"&endTime="+startTime,
            onLoadSuccess:function(data){
                //$('#dlg').dialog('setTitle', pointName);
            }
        });

    }

    //获取描述的详情
    function showDescribe(id){
        $(".tabs-header li").eq(1).click();
        $("#dlg-buttons a").text("返回");
        var url = Ams.ctxPath + '/environment/rectifition/getDetail?id='+id
        $.ajax({
            type : 'POST',
            url : url,
            success : function(data) {
                rowTable(data);

            },
            dataType : 'json'
        });
        flag = 1;
    }
    function rowTable(data) {
        var newRow = "";
        var dataVal=data.rows[0];
        var rowData=JSON.stringify(dataVal);
        newRow += '<div class="details-text ">';
        newRow += '<h5 >'+dataVal.projectName;
        newRow+='</h5>';newRow += '<div class="part-font ca">';
        newRow += '<div class="data-group layui-col-xs12">';
        newRow += '<span class="control-label">问题描述：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.describleName)==false?"":dataVal.describleName) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs12">';
        newRow += '<span class="control-label">整改任务具体要求：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.require)==false?"":dataVal.require) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs12">';
        newRow += '<span class="control-label">目前进展情况及存在问题：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.question)==false?"":dataVal.question) +'</span>';
        newRow += '</div>';
        newRow += '</div>';
        newRow += '<div class="part-date">';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">行政区划：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.areaName)==false?"":dataVal.areaName) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">所属城市：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.cityName)==false?"":dataVal.cityName) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">责任人：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPerson)==false?"":dataVal.dutyPerson) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">责任人电话：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyPersonPhone)==false?"":dataVal.dutyPersonPhone) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">牵头人：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadPerson)==false?"":dataVal.leadPerson) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">责任单位：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.dutyUnit)==false?"":dataVal.dutyUnit) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">牵头单位：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.leadUnit)==false?"":dataVal.leadUnit) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">责任部门：</span>';
        newRow += '<span class="control-content"><a href="#" class="easyui-linkbutton" onClick="show(\''+dataVal.dutyDepartment+'\')">'+(Ams.isNoEmpty(dataVal.dutyDepartment)==false?"":dataVal.dutyDepartment) +'</a></span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">配合单位：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">配合单位：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.matchUnit)==false?"":dataVal.matchUnit) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">涉及人员：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involvePerson)==false?"":dataVal.involvePerson) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">创建时间：</span>';
        newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.createTime) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">涉及部门：</span>';
        newRow += '<span class="control-content">'+(Ams.isNoEmpty(dataVal.involveDepartment)==false?"":dataVal.involveDepartment) +'</span>';
        newRow += '</div>';
        newRow += '<div class="data-group layui-col-xs4">';
        newRow += '<span class="control-label">整改时限：</span>';
        newRow += '<span class="control-content">'+Ams.stdDateFormat(dataVal.timelimit) +'</span>';
        newRow += '</div>';
        newRow += '</div>';
        newRow += '<div class="footer-font color-tag1">';
        newRow += '<span>'+formatStatus(dataVal.status)+'</span>';
        newRow += '</div>';
        newRow += '</div>';
        $("#rectifition").html(newRow);
    }

    /**
     * 字段格式化
     */
    function formatStatus(status){
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
            /*$('#queryStartTime').val(getNowDate(30));
            $('#queryEndTime').val(getNowDate(0));*/
            doSearch();
        });

    };
    var nameValue = "";
    var airChart = echarts.init(document.getElementById('airChart'));

    $(window).resize(function () {
        $('#airChart').width('100%');
        airChart.resize();
    });
    var startTime ='2019';
    var endTime ='2019';
    function doSearch(){
        startTime = $('#queryStartTime').combobox('getValue');
        endTime = startTime;
        /*if (!Ams.isNoEmpty(endTime)||!Ams.isNoEmpty(startTime)){
            Ams.alert('提示信息', '时间区间不能为空！');
            return;
        }
        if (startTime > endTime) {
            Ams.alert('提示信息', '起始时间不能大于结束时间！');
            return;
        }*/
        getdata(startTime,endTime);
    }

    function getdata(startTime,endTime){
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/environment/rectifition/getProjectCountByCity',
            async:true,
            data : {
                startTime:startTime,
                endTime:endTime
            },
            success: function (data) {
                var pointName= [];
                var projectCount = [];
                $.each(data,function(i){
                    pointName.push(data[i].pointName+','+data[i].pointCode);
                    var str = {
                        value:data[i].count,
                        tooltip:
                            {
                                formatter : data[i].pointCode
                            }
                    };
                    projectCount.push(str);
                });
                setDataCharts(pointName,projectCount);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                airChart.hideLoading();
            },
            dataType: 'json'
        });
    }

    function setDataCharts(pointName, projectCount){
        var dataChartsOption ={
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : ''        // 默认为直线，可选为：'line' | 'shadow'  设置‘’去除倒影
                },
                formatter: function (params) {
                    var htmlStr ='<div>';
                    htmlStr += params[0].name.split(",")[0] + '<br/>';//x轴的名称
                    htmlStr += '<span style="margin-right:5px;display:inline-block;width:10px;height:10px;border-radius:5px;background-color:'+params[0].color+';"></span>';
                    htmlStr += params[0].seriesName+': '+params[0].value+'<br/>';
                    htmlStr += '</div>';
                    return htmlStr;
                }

            },
            legend: {
                data:['项目数量']
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    //dataView : {show: true, readOnly: false},
                    dataView : {show: true, title: '数据视图',readOnly: true,lang:['','关闭'],optionToContent:function(opt){
                            var axisData = opt.xAxis[0].data;
                            var series = opt.series;
                            var table = '<table class="dataViewTable" border="1px" align="center"><tr class="dataViewTr">'
                                + '<td class="dataViewHead" width="150px">所属城市</td>'
                                + '<td class="dataViewHead" width="150px">项目数量</td>'
                                + '</tr>';
                            for (var i = 0, l = axisData.length; i < l; i++) {
                                table += '<tr class="dataViewTr">'
                                    + '<td class="dataViewTd">' + axisData[i].split(",")[0] + '</td>'
                                    + '<td class="dataViewTd">' + series[0].data[i].value + '</td>'
                                    + '</tr>';
                            }
                            table += '</tbody></table>';
                            return table;

                        }},
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}

                }
            },
            grid: {
                left : '1%',
                right : '1%',
                containLabel : true
            },
            calculable : true,
            xAxis : [
                {   data:  pointName,
                    type : 'category',
                    triggerEvent: true,
                    axisLabel : {
                        interval : 0,
                        formatter:function(value)
                        {
                            return value.split(",")[0];
                        }
                    }
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    name : '项目数量',
                    minInterval : 1,//纵坐标整数
                    boundaryGap : [ 0, 0.1 ]
                }
            ],
            series : [
                {
                    name : '项目数量',
                    type : 'bar',
                    barWidth: '20%',
                    barMaxWidth:30,
                    barMinWidth:30,
                    data :  projectCount
                }
            ]
        };
        airChart.off('click');
        airChart.on('click', function (params) {
            var pointCode;
            var pointName
            if (params.componentType == "xAxis") {
                pointCode = params.value.split(",")[1];
                pointName = params.value.split(",")[0];
            } else {
                pointCode = params.data.tooltip.formatter;
                pointName = params.name.split(",")[0];
            }
            getDecription(pointCode, pointName);
        });
        airChart.setOption(dataChartsOption);
    }

    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        return d.getFullYear();
    }
</script>

</body>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>

</html>