<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>公司主体管理</title>
	<#include "/header.ftl"/>
</head>

<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:0;" id="searchBar">
            <form id="searchForm">
                <input id="querycode" name="code" class="easyui-textbox" label="编号:" style="width:200px;"
                       data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
                <input id="queryname" name="name" class="easyui-textbox" label="成本中心:" style="width:200px;">
                <input id="querydept" name="dept" class="easyui-textbox" label="部门名称:" style="width:200px;">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()" style="background:#1DA02B; color:#fff;">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_ROOT') OR hasRole('ROLE_ADMIN')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newCost()">新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editCost()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="deleteCost()">删除</a>
        </@sec.authorize>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/sys/finance/costList" data-options="
				rownumbers:false,
				singleSelect:true,
				striped:true,
				autoRowHeight:false,
                fitColumns:false,
				fit:true,
				pagination:true,
				pageSize:10,
                pageList:[10,30,50]">
        <thead>
        <tr>
            <th field="code" width="10%">编号</th>
            <th field="name" width="15%">成本中心</th>
            <th field="deptName" width="15%">部门名称</th>
            <th field="remark" width="60%" formatter="Ams.tooltipFormat">备注</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="code" id="code" class="easyui-textbox" required="true" label="编号:"
                   style="width:100%" data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}">
        </div>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="成本中心:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            	<@al.deptCommotree name="dept.uuid" id="deptUuid" required="true" label="部门:" labelPosition="left" multiple="false" editable="true" style="width:100%" pid="" enable="1"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                   style="width:100%;height:120px">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCost()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function formatDefault(value, row, index) {
        if (1 == value) {
            return '是';
        }
        return '否';
    }

    function newCost() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增成本中心');
        $('#fm').form('clear');
        $('#code').textbox({readonly: false});
        url = Ams.ctxPath + '/sys/finance/saveCost';
    }

    function editCost() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/finance/getCost',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改成本中心');
                    $('#fm').form('load', result);
                    $('#code').textbox({readonly: true});
                    url = Ams.ctxPath + '/sys/finance/saveCost';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveCost() {
        $('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                }
            }
        });
    }

    function deleteCost() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/finance/deleteCost',
                        data: {
                            'uuid': row.uuid
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要删除的记录！');
        }
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            name: $("#queryname").val().trim(),
            code: $("#querycode").val().trim(),
            dept: $("#querydept").val()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>