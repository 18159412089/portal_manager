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
            <form id="searchForm"><label class="control-label">开始时间:</label>
                <input id="queryBegin" name="queryBegin" class="easyui-datebox" style="width:200px;">
                <label class="control-label">结束时间:</label>
                <input id="queryEnd" name="queryEnd" class="easyui-datebox" style="width:200px;">
                <label class="control-label">日志名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox" style="width:200px;">
                <label class="control-label">日志类型:</label>
                <select name="queryType" id="queryType" class="easyui-combobox" data-options="editable:true" style="width:250px;">
                    <option value="" selected="selected">全部</option>
                    <option value="业务日志">业务日志</option>
                    <option value="异常日志">异常日志</option>
                </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/operationLog/list" data-options="
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
            <th field="logtype" width="100px">日志类型</th>
            <th field="logname" width="200px">日志名称</th>
            <th field="userName" width="150px">用户名称</th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th field="classname" width="350">类名</th>
            <th field="method" width="200px">方法名</th>
            <th field="createtime" width="200px" formatter="Ams.timeDateFormat">操作时间</th>
            <th field="message" width="400px" formatter="Ams.tooltipFormat">具体消息</th>
        </tr>
        </thead>
    </table>
</div>
<div id="dlg">

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
            logName: $("#queryName").val().trim(),
            logType: $("#queryType").val()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>