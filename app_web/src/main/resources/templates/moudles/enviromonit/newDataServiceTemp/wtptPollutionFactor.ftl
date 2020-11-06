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
                        <label class="textbox-label textbox-label-before" title="单位详细名称">单位详细名称:</label>
                        <input id="yzcmc" name="dwmc"  style="width:280px;"/>
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
               url="${request.contextPath}/environment/waterImportInfoShow/getWtptPollutionFactorPageList"
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
                <th formatter="Ams.tooltipFormat" field="dwmc" width="100" align="center">单位详细名称</th>
                <th formatter="Ams.tooltipFormat" field="qx" width="100" align="center">详细地址_县(区、市、旗)</th>
                <th formatter="Ams.tooltipFormat" field="xz" width="100" align="center">详细地址_乡(镇)</th>
                <th formatter="Ams.tooltipFormat" field="jd" width="100">详细地址_街(村)、门牌号</th>
                <th formatter="Ams.tooltipFormat" field="longitude1" width="100">中心经度(度)</th>
                <th formatter="Ams.tooltipFormat" field="longitude2" width="150" align="center" >中心经度(分)</th>
                <th formatter="Ams.tooltipFormat" field="longitude3" width="100" align="center">中心经度(秒)</th>
                <th formatter="Ams.tooltipFormat" field="latitude1" width="100" align="center">中心纬度(度)</th>
                <th formatter="Ams.tooltipFormat" field="latitude2" width="100" align="center">中心纬度(分)</th>
                <th formatter="Ams.tooltipFormat" field="latitude3" width="100" align="center">中心纬度(秒)</th>
                <th formatter="Ams.tooltipFormat" field="lxr" width="100" align="center">联系人</th>
                <th formatter="Ams.tooltipFormat" field="lxdh" width="100" align="center">联系电话</th>
                <th formatter="Ams.tooltipFormat" field="snstmc" width="100" align="center">受纳水体-名称</th>
                <th formatter="Ams.tooltipFormat" field="qyyxzt" width="100" align="center">企业运行状态</th>
                <th formatter="Ams.tooltipFormat" field="csgyfs" width="100" align="center">产生工业废水</th>
                <th formatter="Ams.tooltipFormat" field="glRqlj" width="100" align="center">有锅炉/燃气轮机</th>
                <th formatter="Ams.tooltipFormat" field="gyhy" width="100" align="center">有工业炉窑</th>
                <th formatter="Ams.tooltipFormat" field="wrwmc" width="100" align="center">污染物名称</th>
                <th formatter="Ams.tooltipFormat" field="wrwcwxs" width="100" align="center">污染物产污系数</th>
                <th formatter="Ams.tooltipFormat" field="wrwcwxsCsqz" width="100" align="center">污染物产污系数中参数取值</th>
                <th formatter="Ams.tooltipFormat" field="wrwcsl" width="100" align="center">污染物产生量</th>
                <th formatter="Ams.tooltipFormat" field="wrwcslJldw" width="100" align="center">污染物产生量的计量单位</th>
                <th formatter="Ams.tooltipFormat" field="wrwpfl" width="100" align="center">污染物排放量</th>
                <th formatter="Ams.tooltipFormat" field="wrwpflJldw" width="100" align="center">污染物排放量计量单位</th>
                <th formatter="Ams.tooltipFormat" field="pwxkzzxbgpfl" width="100" align="center">排污许可证执行报告排放量</th>
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
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    Ams.inputText_enterKeyEvent("yzcmc", doSearch);
    $(function(){
        doSearch();
    });
    function doSearch() {
        $('#dg1').datagrid({
            url: "${request.contextPath}/environment/waterImportInfoShow/getWtptPollutionFactorPageList",
            queryParams: {
                dwmc:$("#yzcmc").val()
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