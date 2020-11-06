<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html>
<head>
<title>空气质量日报查询</title> <#include "/header.ftl"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/progressbar.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/css/base.css" />
<link rel="stylesheet" type="text/css" href="${request.contextPath}/static/testing.css" />

<script type="text/javascript" src="${request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/echarts-3.7.0.js"></script>
<script type="text/javascript" src="${request.contextPath}/static/js/progressbar.js"></script>
<style type="text/css">
    input[readonly]{
        background-color: #fff;
    }
</style>
</head>
<body>
<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
            <div class="form-group">
                <label class="control-label">类型：</label>
                <div class="control-div">
                    <!--单选框-->
                    <label class="form-radio">
                        <input name="radioName" type="radio" value="area"/>
                        <span class="lbl">行政区</span>
                    </label>
                    <label class="form-radio">
                        <input name="radioName" type="radio" value="point"/>
                        <span class="lbl">测点</span>
                    </label>
                    <!--单选框-->
                </div>
            </div>
            <div class="form-group" id="area">
                <label class="control-label" id="lb_name">行政区：</label>
                <div class="control-div">
                    <input id="queryArea" class="easyui-combobox" name="queryArea" style="height: 32px; width: 140px;" data-options="
                        url:'${request.contextPath}/enviromonit/airMonitorPoint/getCity',
                        method:'post',
                        editable:false,
                        valueField:'uuid',
                        textField:'name',
                        multiple:false,
                        panelHeight:'auto'">
                </div>
            </div>
                <div class="form-group" id="point" style="display:none;">
                    <label class="control-label">监测站点：</label>
                    <div class="control-div">
                        <input id="queryPoint" class="easyui-combobox" name="queryPoint"  style="height: 32px; width: 140px;" data-options="
                        url:'${request.contextPath}/enviromonit/airMonitorPoint/getPonitList',
                        method:'post',
                        valueField:'id',
                        textField:'text',
                        multiple:false,
                        panelHeight:'auto'">
                    </div>
                </div>

            <div class="form-group">
                <label class="control-label">开始日期：</label>
                <div class="control-div">
                    <input id="queryStartTime" name="queryStartTime" data-options="editable:false" class="easyui-datebox"style="width: 128px; height:34px;">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label">结束日期：</label>
                <div class="control-div">
                    <input id="queryEndTime" name="queryEndTime" data-options="editable:false" class="easyui-datebox"  style="width: 128px; height:34px;">
                </div>
            </div>
            
            
            <div class="form-group">
                <div class="control-label">
                    <button class="btn btn-primary" type="submit" onclick="doSearch()"><span class="fa-search mr6"></span>查询</button>
                </div>
            </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
        data-options="
                rownumbers:true,
                singleSelect:true,
                striped:true,
                autoRowHeight:false,
                fitColumns:true,
                fit:true,
              pagination:true,
              pageSize:20,
            pageList:[10,20,50]">
        <thead>
            <tr>
                <th field="monitortime" width="50px" align="center">日期</th>
                <th field="pointName" width="80px" align="center">站点名称</th>
                <th field="aqi" width="150px" align="center">综合AQI指数</th>
                <th field="pollutant" width="50px" align="center">首要污染物</th>
                <th field="level" width="50px" align="center">空气质量级别</th>
                <th field="status" width="50px" align="center">空气质量状况</th>
            </tr>
            </thead>
    </table>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    $(function() {
            
		$("input[name=radioName]").click(function(){
		    if($(this).val()=="area"){
		        $('#area').show();
		        $('#point').hide();
		    }
		    if($(this).val()=="point"){
		        $('#area').hide();
		        $('#point').show();
		    }
		});
		
		$("input[name='radioName']").get(0).checked=true;  //初始化默认选中"行政区"单选框
		
		$('#queryArea').combobox('setValue','350600');
		$('#queryPoint').combobox('setValue','600601');
        var date = new Date();   
        $("#queryStartTime").datebox('setValue', date.getFullYear()+"-01-01");
        $("#queryEndTime").datebox('setValue', FormatDate(date.setDate(date.getDate())));
        doSearch();
       
            
    });
    
    $('#queryStartTime').datebox().datebox('calendar').calendar({
        validator: function(date){
            var now = new Date();
            var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
            return d1>=date;
        }
    });
    $('#queryEndTime').datebox().datebox('calendar').calendar({
         validator: function(date){
                var time = $('#queryStartTime').val().replace(/-/g,"/");
                var d2 = new Date(time);
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                
                return date <= d1 && date >=d2;
        }
    });
    $('#queryStartTime').datebox({
        onSelect: function (select) {
            $('#queryEndTime').datebox('setValue','');
            $('#queryEndTime').datebox().datebox('calendar').calendar({
                validator: function (date) {
                    // var startDate = $('#startDate').datebox('getValue');
                    var d1 = new Date(select);
                    var d3 = new Date();
                    return d1 <= date && date <= d3;
                }
            });
        }
    });
    
    function doSearch(){
        var pointCode ;
            
        if($("input[name=radioName]:checked").val()=="area"){
            pointCode = $("#queryArea").val();
        }
        if($("input[name=radioName]:checked").val()=="point"){
            pointCode = $("#queryPoint").val();
        }
        

        var queryStartTime = $("#queryStartTime").val();
        var queryEndTime = $("#queryEndTime").val();
        if(queryStartTime==""||queryEndTime==""){
            $.messager.alert('提示', '时间区间不允许为空！');
        }else{
            $('#dg').datagrid({
                url:'${request.contextPath}/enviromonit/airQualityAQI/list',
                queryParams: {
                    category : 'daily',
                    pointCode : pointCode,
                    startTime : $("#queryStartTime").val(),
                    endTime : $("#queryEndTime").val()
                }
            });
        }
    }
    //获取时间格式化(cutDay为往前几天，0为当天)
    function getNowDate(cutDay) {
        var d = new Date();
        var nowDateTime = d.getTime() - cutDay*60000*60*24;
        d.setTime(nowDateTime);
        var year = d.getFullYear();
        var month = d.getMonth()+1;
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var date = d.getDate();
        if (date >= 0 && date <= 9) {
            date = "0" + date;
        }
        var hours = d.getHours();
        if (hours >= 0 && hours <= 9) {
            hours = "0" + hours;
        }
        var minutes = d.getMinutes();
        if (minutes >= 0 && minutes <= 9) {
            minutes = "0" + minutes;
        }
        var seconds = d.getSeconds();
        if (seconds >= 0 && seconds <= 9) {
            seconds = "0" + seconds;
        }
        var currentdate = year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
        return currentdate;
    }
    function FormatDate(str) {
            var date = new Date(str);
            var seperator1 = "-";
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = year + seperator1 + month + seperator1 + strDate;
            return currentdate;
    }
</script>
</body>
</html>