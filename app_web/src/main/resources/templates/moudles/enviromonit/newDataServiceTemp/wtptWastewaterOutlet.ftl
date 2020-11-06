<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<!DOCTYPE html>
<html lang="ch">
<head>
    <title>畜禽养殖</title>

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
                        <label class="textbox-label textbox-label-before" title="排污口名称">排污口名称:</label>
                        <input id="yzcmc" name="pwkmc"  style="width:280px;"/>
                    </div>

                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                       onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                       onclick="doReset()">重置</a>
                </form>
            </div>

            <!-- 搜索栏 over-->
            <!-- 操作栏-->
            <#-- <div class="optionBar">
                 <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'iconcustom icon-shujudaochu1'" onclick="exportData()">导出数据</a>
             </div>-->
            <!-- 操作栏 over-->
        </div>
        <!-- 工具栏 over-->

        <!-- 数据列表-->
        <table id="dg1" class="easyui-datagrid" url="" toolbar="#toolbar1"
               url="${request.contextPath}/environment/waterImportInfoShow/getWtptWastewaterOutletPageList"
               data-options="
						singleSelect:true,
						autoRowHeight:false,
						fit:true,
						pagination:true,
						pageSize:14,
						rownumbers:true,
		                pageList:[14,50,100]">
            <thead>
            <tr>
                <th formatter="Ams.tooltipFormat" field="pwkmc"  width="300" align="left">排污口名称</th>
                <th formatter="Ams.tooltipFormat" field="longitude1"  width="120" align="left">企业地理经度(度)</th>
                <th formatter="Ams.tooltipFormat" field="longitude2"  width="120" align="left">企业地理经度(分)</th>
                <th formatter="Ams.tooltipFormat" field="longitude3"  width="120" align="left">企业地理经度(秒)</th>
                <th formatter="Ams.tooltipFormat" field="latitude1"  width="120">企业地理纬度(度)</th>
                <th formatter="Ams.tooltipFormat" field="latitude2"  width="120">企业地理纬度(分)</th>
                <th formatter="Ams.tooltipFormat" field="latitude3"  width="150" align="left" >企业地理纬度(秒)</th>
                <th formatter="Ams.tooltipFormat" field="pwklx"  width="120" align="left">排污口类型(其他)</th>
                <th formatter="Ams.tooltipFormat" field="rhfs"  width="220" align="left">入河(海)方式</th>
                <th formatter="Ams.tooltipFormat" field="snstmc"  width="250" align="left">受纳水体名称</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
        <!-- 数据列表 over-->
    </div>
</div>
</body>
<script src="${request.contextPath}/static/layer/layer.js"></script>
<script>
    Ams.inputText_enterKeyEvent("yzcmc", doSearch);
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function(){
        doSearch();
    });
    function doSearch() {
        $('#dg1').datagrid({
            url: "${request.contextPath}/environment/waterImportInfoShow/getWtptWastewaterOutletPageList",
            queryParams: {
                pwkmc:$("#yzcmc").val()
            }
        });

    }
    function doReset() {
        $("#searchBar1").find("#searchForm1").form('clear');
        doSearch();
    }

    //导出数据
    function exportData(){
        <#--var startTime= $("#startTime").val().trim();-->
        <#--var endTime = $("#endTime").val().trim();-->
        <#--var regionName=$("#regionName").val()-->
        <#--window.open("${request.contextPath}/enviromonit/water/wtCityHourData/exportData?startTime="+startTime+"&endTime="+endTime+"&regionName="+regionName+"&type=2&category=3");-->
    }


</script>
</html>