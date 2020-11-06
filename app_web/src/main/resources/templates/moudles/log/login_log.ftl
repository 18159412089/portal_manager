<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>用户管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">开始时间:</label>
                <input id="queryBegin" name="queryBegin" class="easyui-datebox" style="width:200px;">
                <label class="control-label">结束时间:</label>
                <input id="queryEnd" name="queryEnd" class="easyui-datebox" style="width:200px;">
                <label class="control-label">日志名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox" style="width:200px;">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/loginLog/list" data-options="
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
            <th field="logname" width="100px">日志名称</th>
            <th field="userName" width="150px">用户名称</th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th field="createtime" width="200px" formatter="Ams.timeDateFormat">登录时间</th>
            <th field="ip" width="200px">IP</th>
            <th field="remark" width="400px">备注</th>
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

    function doSearch() {
        $('#dg').datagrid('load', {
            beginTime: $('#queryBegin').val().trim(),
            endTime: $("#queryEnd").val().trim(),
            logName: $("#queryName").val().trim()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>