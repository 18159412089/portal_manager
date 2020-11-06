<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>定时任务日志</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">spring bean名称:</label>
                <input id="queryBeanName" name="queryBeanName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">方法名:</label>
                <input id="queryMethodName" name="queryMethodName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">参数:</label>
                <input id="queryParamsName" name="queryParamsName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">任务状态:</label>
                <select name="queryStatus" id="queryStatus" class="easyui-combobox" data-options="editable:true" style="width:250px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="0">成功</option>
                    <option value="1">失败</option>
                </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/scheduleLog/list" data-options="
				rownumbers:false,
				singleSelect:true,
				striped:true,
				autoRowHeight:false,
                fitColumns:false,
				fit:true,
				pagination:true,
				pageSize:10,
                pageList:[10,30,50]">
        <thead data-options="frozen:true">
        <tr>
            <th field="jobId" width="300px">任务id</th>
            <th field="beanName" width="200px">spring bean名称</th>
            <th field="methodName" width="200px">方法名</th>
            <th field="params" width="200px">参数</th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th field="status" width="100px" formatter="formatterStatus" align="center">任务状态</th>
            <th field="times" width="150px">耗时(单位：毫秒)</th>
            <th field="createDate" width="200px" formatter="Ams.timeDateFormat">操作时间</th>
        </tr>
        </thead>
    </table>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;overflow:hidden;"
     data-options="closed:true,modal:true,border:'thin'">
</div>
<script>
    $.parser.onComplete = function () {
        $(" #loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function formatterStatus(value, row, index) {
        return value === 0 ?
                "<label style='background-color:#5cb85c;border:1px;solid #000'>成功</label>" :
                "<label style='background-color:#d9534f;border:1px;solid #000' title='" + row.error + "'>失败</label>";
    }


    function doSearch() {
        $('#dg').datagrid('load', {
            beanName: $("#queryBeanName").val().trim(),
            methodName: $("#queryMethodName").val().trim(),
            paramsName: $("#queryParamsName").val().trim(),
            status: $("#queryStatus").val()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
<
/body>
< /html>