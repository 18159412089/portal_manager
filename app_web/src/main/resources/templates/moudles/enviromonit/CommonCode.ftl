<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>公共代码</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">代码:</label>
                <input id="queryCode" name="queryCode" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox"  style="width:200px;">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
<#--        <@sec.authorize access="hasAuthority('sys:commoncode:add')">-->
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newCommonCode()">新增</a>
<#--        </@sec.authorize>-->
<#--        <@sec.authorize access="hasAuthority('sys:commoncode:edit')">-->
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editCommonCode()">修改</a>
<#--        </@sec.authorize>-->
<#--        <@sec.authorize access="hasAuthority('sys:commoncode:delete')">-->
            <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="delCommonCode()">删除</a>
<#--        </@sec.authorize>-->
    </div>
    <table id="tg" class="easyui-treegrid" style="width:100%;"
           url="${request.contextPath}/enviromonit/commonCode/getAllTree"
           idField="id" treeField="name" toolbar="#toolbar" fit=true>
        <thead>
        <tr>
            <th field="name" width="40%">名称</th>
            <th field="code" width="20%">代码</th>
        </tr>
        </thead>
    </table>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="id" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <@al.CommonCodetree name="parentId" id="parentId" required="true" label="父级:" labelPosition="left" multiple="false" editable="true" style="width:100%"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="code" class="easyui-textbox" required="true" label="名称:" style="width:100%">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCommonCode()" style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    function saveCommonCode() {
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                    if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#tg').treegrid('load');
                }
            }
        });
    }

    function delCommonCode() {
        $('#fm').form('clear');
        var row = $('#tg').treegrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/enviromonit/commonCode/del',
                data: {'id': row.id},
                success: function (result) {
                    // var result = JSON.parse(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $.messager.alert('提示', "删除成功");
                        $('#tg').treegrid('load');
                    }
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    function editCommonCode() {
        $('#fm').form('clear');
        var row = $('#tg').treegrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/enviromonit/commonCode/get',
                data: {'id': row.id},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改公共代码');
                    $('#fm').form('load', result);
                    url = Ams.ctxPath + '/enviromonit/commonCode/save';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function newCommonCode() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增公共代码');
        $('#fm').form('clear');
        url = Ams.ctxPath + '/enviromonit/commonCode/save';
    }

    function doSearch() {
        $('#tg').treegrid('reload', {
            name: $("#queryName").val().trim(),
            code: $("#queryCode").val().trim()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }

</script>
</body>
</html>