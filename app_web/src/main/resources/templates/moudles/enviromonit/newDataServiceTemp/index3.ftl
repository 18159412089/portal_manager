<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>  
<html lang="ch">
<head>
    <title>省自建-水基础资料</title>

</head>
<!-- body -->
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<div class="easyui-layout" fit=true>
    <!-- tabs 标签页 -->
   <#-- <div class="easyui-tabs easyui-tab-brief" id="tabs" fit=true>-->
        <!-- 标签页——1 -->
       <#-- <div title="省考断面" style="padding:10px">-->
            <!-- 数据列表页面 -->
            <div class="easyui-layout" fit=true>
                <!-- 工具栏----id与easyui-datagrid的toolbar一致-->
                <div id="toolbar1">
                    <!-- 搜索栏 -->
                    <div id="searchBar1" class="searchBar">
                        <form id="searchForm1">
                            <div class="inline-block">
                                <label class="textbox-label textbox-label-before" title="断面名称">断面名称:</label>
                                <input class="easyui-combobox" name="regionName" value="${pointCode!}" id="regionName" prompt="全部" data-options="
									url:'/enviromonit/water/wtCityPoint/getPointList?type=3',
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
                        </form>
                    </div>

                    <!-- 搜索栏 over-->
                    <!-- 操作栏-->
                    <div class="optionBar">
                        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportData()">导出数据</a>
                    </div>
                    <!-- 操作栏 over-->
                </div>
                <!-- 工具栏 over-->

                <!-- 数据列表-->
                <table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
                       url="${request.contextPath}/environment/debriefing/list"
                       data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:10,
		                pageList:[10,50,100]">
                    <thead>
                    <tr>
                        <th field="pointCode" width="100">断面编码</th>
                        <th field="pointName" width="100">断面名称</th>
                        <th field="datatime" width="150" align="center" formatter="Ams.timeDateFormat">时间</th>
                        <th field="val1" width="100" align="center">PH</th>
                        <th field="val2" width="100" align="center">溶解氧(mg/l)</th>
                        <th field="val3" width="100" align="center">高锰酸盐指数(mg/l)</th>
                        <th field="val4" width="100" align="center">化学需氧量(mg/l)</th>
                        <th field="val5" width="100" align="center">五日生化需氧量(mg/l)</th>
                        <th field="val6" width="100" align="center">氨氮(mg/l)</th>
                        <th field="val7" width="100" align="center">总磷(mg/l)</th>
                        <th field="val8" width="100" align="center">铜(mg/l)</th>
                        <th field="val9" width="100" align="center">锌(mg/l)</th>
                        <th field="val10" width="100" align="center">氟化物(mg/l)</th>
                        <th field="val11" width="100" align="center">硒(mg/l)</th>
                        <th field="val12" width="100" align="center">砷(mg/l)</th>
                        <th field="val13" width="100" align="center">汞(mg/l)</th>
                        <th field="val14" width="100" align="center">镉(mg/l)</th>
                        <th field="val15" width="100" align="center">六价铬(mg/l)</th>
                        <th field="val16" width="100" align="center">铅(mg/l)</th>
                        <th field="val17" width="100" align="center">氰化物(mg/l)</th>
                        <th field="val18" width="100" align="center">阴离子表面活性剂(mg/l)</th>
                        <th field="val19" width="100" align="center">硫化物(mg/l)</th>
                        <#--<th field="result" width="100" align="center">结果</th>-->
                        <!-- Ams.setAQIBackground 方法里的判断条件是我乱写的  开发自行修改一下-->
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <!-- 数据列表 over-->
            </div>
            <!-- 数据列表页面 over-->
      <#--  </div>-->
        <!-- 标签页——1 over-->

        <!-- 标签页——2 -->
       <#-- <div title="国考断面" style="padding:10px">
            国考断面
        </div>-->
        <!-- 标签页——2 over-->

        <!-- 标签页——3 -->
        <#--<div title="小流域" style="padding:10px">
            小流域
        </div>-->
        <!-- 标签页——3 over-->


    <#--</div>-->
    <!-- tabs 标签页 over -->

</div>
</body>
<script src="${request.contextPath}/static/layer/layer.js"></script>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function(){
        /**/
        $("#tabs").tabs({
            onSelect:function(title,index){
                console.log(index);
            }
        });
        $('#startTime').datebox('setValue', getNowDate(30));
        $('#endTime').datebox('setValue', getNowDate(0));
        doSearch();
    });
    function doSearch() {
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        if(startTime==""||endTime==""){
            layer.msg("请按时间查询");
            return;
        }
        $('#dg1').datagrid({
            url: '${request.contextPath}/enviromonit/water/wtCityHourData/findList',
            queryParams: {
                startTime: startTime,
                endTime: endTime,
                regionName:$("#regionName").val(),
                type:2,
                category:3
            }
        });

    }
    function doReset() {
        $("#searchBar1").find("#searchForm1").form('clear');
        doSearch();
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

    //导出数据
    function exportData(){
        var startTime= $("#startTime").val().trim();
        var endTime = $("#endTime").val().trim();
        var regionName=$("#regionName").val()
        window.open("${request.contextPath}/enviromonit/water/wtCityHourData/exportData?startTime="+startTime+"&endTime="+endTime+"&regionName="+regionName+"&type=2&category=3");
    }
    
    
</script>
</html>