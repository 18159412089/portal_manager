<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>模型管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div id="toolbar">
    <div style="padding:3px;" id="searchBar">
        <form id="searchForm">
            <select name="categoryParam" id="categoryParam" class="easyui-combobox" data-options="editable:true"
                    label="流程分类:"
                    style="width:250px;">
                <option value="">全部分类</option>
                <option value="1">分类1</option>
                <option value="2">分类2</option>
            </select>
            <input name="nameParam" id="nameParam" class="easyui-textbox" label="模块名称:" style="width:200px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
               onclick="doReset()">重置</a>
        </form>
    </div>
    <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteFlow()" style="margin-bottom:10px;">删除</a>
</div>
<!-- datagrid -->
<table id="dg" class="easyui-datagrid" style="width:100%px;height:auto" toolbar="#toolbar"
       url="${request.contextPath}/modeler/flow/fetchList" data-options="
				rownumbers:false,
				singleSelect:true,
                striped:true,
				autoRowHeight:false,
				fitColumns:true,
                fit:true">
    <thead>
    <tr>
        <th field="processKey" width="10%">模型标识</th>
        <th field="processName" width="20%">模型名称</th>
        <th field="category" width="10%" formatter="formatCategory">流程分类</th>
        <th field="processVersion" width="10%" formatter="formatVersion">版本号</th>
        <th field="deploymentTime" width="20%" formatter="Ams.timeDateFormat">部署时间</th>
        <th field="diagramResourceName" width="20%" formatter="formatDiagramResource">流程图片</th>
        <th field="suspended" width="10%" formatter="formatSuspended">操作</th>
    </tr>
    </thead>
</table>

<script>
    var isRoot = false;
	<@sec.authorize access="hasRole('ROLE_ROOT')">
	isRoot = true;
    </@sec.authorize>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    var row;

    function formatCategory(value) {
        if ('1' == value) {
            return "分类1"
        } else if ('2' == value) {
            return "分类2"
        } else {
            return '';
        }
    }


    function formatVersion(value) {
        return 'V' + value;
    }

    function formatDiagramResource(value, row, index) {
        return '<a target="_blank" href=' + Ams.ctxPath + '"/modeler/flow/resource/read?procDefId=' + row.processId + '&resType=image">' + value + '</a>'
    }

    function formatSuspended(value, row, index) {
        var procDefId = row.processId;
        if (value) {
            return '<a href="javascript:void(0)" class="easyui-linkbutton" onClick="updateState(\'active\',\'' + procDefId + '\',' + index + ')">激活</a>';
        } else {
            return '<a href="javascript:void(0)" class="easyui-linkbutton" onClick="updateState(\'suspend\',\'' + procDefId + '\',' + index + ')">挂起</a>';
        }
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            category: $("#categoryParam").val(),
            name: $("#nameParam").val().trim()
        });
    }

    function updateState(state, procDefId, index) {
        if (!isRoot) {
            return;
        }
        $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/modeler/flow/update/' + state,
            data: {'procDefId': procDefId},
            success: function (result) {
                $.messager.progress('close');
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    doSearch();
                }
            },
            error: function () {
                $.messager.progress('close');
                Ams.error('删除失败！');
            },
            dataType: 'json'
        });
    }

    function deleteFlow() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/modeler/flow/delete',
                        data: {'deploymentId': row.deploymentId},
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                            }
                        },
                        error: function () {
                            $.messager.progress('close');
                            Ams.error('删除失败！');
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>