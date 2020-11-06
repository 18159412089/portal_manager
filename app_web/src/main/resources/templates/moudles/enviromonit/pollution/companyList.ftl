<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>污染源</title>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div id="pf-bd" style="padding:10 10 10 10px;">
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <input id="queryName" name="queryName" class="easyui-textbox" label="企业名称:" style="width:200px;">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_USER')">
        <a href="/env/pollution/point/pointList.do" class="easyui-linkbutton" data-options="iconCls:'icon-search'" target="_blank">点位查询</a>
        <a href="/env/pollution/point/dataread.do" class="easyui-linkbutton" data-options="iconCls:'icon-search'" target="_blank">数据调阅</a>
        </@sec.authorize>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/env/pollution/list" data-options="
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
            <th field="name" width="200px" formatter="Ams.tooltipFormat">企业名称</th>
            <th field="code" width="120px" formatter="Ams.tooltipFormat">组织机构代码</th>
            <th field="uscCode" width="200px" formatter="Ams.tooltipFormat">社会统一信用代码</th>
            <th field="region" width="120px">所属区域</th>
            <th field="basin" width="120px">所属流域</th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th field="category" width="120px">行业类型</th>
            <th field="focusPoint" width="120px">污染源重点</th>
            <th field="wquantity" width="120px">废水点位数</th>
            <th field="aquantity" width="120px">废气点位数</th>
            <th field="enabled" width="120px">是否关停</th>
            <th field="corporation" width="120px">法人</th>
            <th field="contactor" width="120px">平台联系人</th>
            <th field="address" width="200px" formatter="Ams.tooltipFormat">企业地址</th>
        </tr>
        </thead>
    </table>
</div>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function editUser() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/user/getUser',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改用户');
                    $('#fm').form('load', result.user);
                    $('#loginname').textbox({readonly: true});
                    url = Ams.ctxPath + '/sys/user/saveUser';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            name: $("#queryName").val().trim()
        });
    }


    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>