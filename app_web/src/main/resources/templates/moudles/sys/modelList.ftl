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
    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newModel()">新增</a>
    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editModel()">修改</a>
    <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteModel()">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tab_go'" onclick="deployModel()">部署</a>
</div>
<!-- datagrid -->
<table id="dg" class="easyui-datagrid" style="width:100%px;height:auto" toolbar="#toolbar"
       url="${request.contextPath}/modeler/model/fetchList" data-options="
				rownumbers:false,
				singleSelect:true,
                striped:true,
				autoRowHeight:false,
				fitColumns:true,
                fit:true">
    <thead>
    <tr>
        <th field="key" width="20%">模型标识</th>
        <th field="name" width="20%">模型名称</th>
        <th field="category" width="10%" formatter="formatCategory">流程分类</th>
        <th field="version" width="10%" formatter="formatVersion">版本号</th>
        <th field="createTime" width="20%" formatter="Ams.timeDateFormat">创建时间</th>
        <th field="lastUpdateTime" width="20%" formatter="Ams.timeDateFormat">最后更新时间</th>
    </tr>
    </thead>
</table>
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <div style="margin-bottom:10px">
            <select name="category" class="easyui-combobox" data-options="required:true,editable:true" label="流程分类:"
                    style="width:100%">
                <option value="1">分类1</option>
                <option value="2">分类2</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="模块名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="identification" class="easyui-textbox" required="true" label="模块标识:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'模块描述:'" multiline="true"
                   style="width:100%;height:120px">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="createModel()"
       style="width:90px">创建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

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

    var win = null;

    function doSearch() {
        $('#dg').datagrid('load', {
            category: $("#categoryParam").val(),
            name: $("#nameParam").val().trim()
        });
    }

    function deployModel() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认部署当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/modeler/' + row.id + '/deployment',
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $.messager.show({
                                    title: '提醒',
                                    msg: '部署成功！'
                                });
                            }
                        },
                        error: function () {
                            $.messager.progress('close');
                            $.messager.show({
                                title: '错误',
                                msg: '部署失败！'
                            });
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要部署的记录！');
        }
    }

    function deleteModel() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/modeler/model/delete',
                        data: {'id': row.id},
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
                            $.messager.show({
                                title: '错误',
                                msg: '删除失败！'
                            });
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    function editModel() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            win = window.open(Ams.ctxPath + "/static/modeler.html?modelId=" + row.id, "createModel");
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function newModel() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增模型');
    }

    function createModel() {
        $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
        $('#fm').form('submit', {
            url: Ams.ctxPath + '/modeler/create',
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            async: false,
            success: function (result) {
                $.messager.progress('close');
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');        // close the dialog
                    win = window.open(Ams.ctxPath + "/static/modeler.html?modelId=" + result.message, "createModel");
                    doSearch();
                }
            }
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>