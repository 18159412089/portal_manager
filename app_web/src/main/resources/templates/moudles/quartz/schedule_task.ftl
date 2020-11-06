<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>定时任务</title>
	<#include "/header.ftl"/>
    <style type="text/css">
        input {
            background-color: expression((this.readOnly && this.readOnly == true)? "#efefef":"");
        }

        input[readonly] {
            background-color: #efefef;
        }
    </style>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>

<!-- datagrid -->
<div class="easyui-layout" fit=true>
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <input id="queryBeanName" name="queryBeanName" class="easyui-textbox" label="bean名称:"
                       style="width:200px;">
                <select name="queryStatus" id="queryStatus" class="easyui-combobox" data-options="editable:true"
                        label="任务状态:"
                        style="width:250px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="0">正常</option>
                    <option value="1">暂停</option>
                </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
            <#if hasQuartz=='Y'>
            <a href="http://cron.qqe2.com/" target="_blank" style="float:right"><strong>在线Cron表达式生成器</strong></a>
            </#if>
        </div>
        <#if hasQuartz=='Y'>
    	<@sec.authorize access="hasAuthority('sys:schedule:save')">
        <a href=" #" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addTask()">新增</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:schedule:edit')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="updateTask()">修改</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:schedule:delete')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="removeTask()">删除</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:schedule:pause')">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="pause()">暂停</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:schedule:resume')">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resume()">恢复</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:schedule:runOne')">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="runOnce()">立即执行</a>
        </@sec.authorize>
        </#if>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/schedule/list" data-options="
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
            <th field="beanName" width="200px">spring bean名称</th>
            <th field="methodName" width="200px">方法名</th>
            <th field="params" width="200px">参数</th>
            <th field="cronExpression" width="200px">cron表达式</th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th field="status" width="100px" formatter="formatterStatus">任务状态</th>
            <th field="startTime" width="150px" formatter="Ams.timeDateFormat">开始时间</th>
            <th field="prevFireTime" width="150px" formatter="Ams.timeDateFormat">上一次执行时间</th>
            <th field="nextFireTime" width="150px" formatter="Ams.timeDateFormat">下一次执行时间</th>
            <th field="triggerType" width="100px">trigger类型</th>
            <th field="remark" width="300px">备注</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog -->
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="beanName" class="easyui-textbox" required="true" label="bean名称:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="methodName" class="easyui-textbox" required="true" label="方法名:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="params" class="easyui-textbox" label="参数:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input id="cronExpression" name="cronExpression" class="easyui-textbox" required="true" label="cron表达式:"
                   readonly="true" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <select name="status" class="easyui-combobox" data-options="required:true,editable:true" label="任务状态:"
                    style="width:100%">
                <option value="0">正常</option>
                <option value="1">暂停</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" label="备注:" style="width:100%">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveTask()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<!-- cron表达式弹出框 -->
<div id="cronDlg" class="easyui-dialog" style="width:660px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#cronDlg-buttons'">
    <iframe id="cronFrame" src="${request.contextPath}/static/cron-quartz/index.html?ctx=${request.contextPath}"
            style="width:660px;height:530px;border:0"></iframe>
    <script type="text/javascript">
        $('#cronFrame').load(function () {
            var win = $(this)[0].contentWindow;
            win.$('#cron').val($('#cronExpression').textbox('getValue'));
            win.$("input[name^='v_'],#cron").change(function () {
                $('#cronExpression').textbox('setValue', win.$('#cron').val());
            });
            win.$('#btnFan').click();
        });
    </script>
</div>
<div id="cronDlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok"
       onclick="$('#cronDlg').dialog('close')" style="width:90px">确定</a>
</div>

<script>
    $(function () {
        $("#cronExpression").textbox('textbox').bind("click", function () {
            $('#cronDlg').dialog('open').dialog('center').dialog('setTitle', '设置定时周期');
            // $('#cronFrame').load(function () {
            // 	debugger;
            //     var win = $(this)[0].contentWindow;
            //     win.$('#cron').val($('#cronExpression').textbox('getValue'));
            //     win.$("input[name^='v_'],#cron").change(function () {
            //         debugger;
            //         $('#cronExpression').textbox('setValue', win.$('#cron').val());
            //     });
            //     win.$('#btnFan').click();
            // });
        });
    });

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function formatterStatus(value, row, index) {
        return value === 0 ?
                "<label style='background-color:#00BFFF;border:1px;solid #000'>正常</label>" :
                "<label style='background-color:#FFD700;border:1px;solid #000'>暂停</label>";
    }

    function addTask() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增定时任务');
        $('#fm').form('clear');
        url = Ams.ctxPath + '/schedule/saveTask';
    }

    function updateTask() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/schedule/info/' + row.uuid,
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改定时任务');
                    $('#fm').form('load', result.schedule);
                    url = Ams.ctxPath + '/schedule/updateTask';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveTask() {
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

    function removeTask() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/schedule/removeTask',
                        data: {
                            'jobId': row.uuid,
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

    function pause() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认暂停当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/schedule/pause',
                        data: {
                            'jobIds': row.uuid,
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
            $.messager.alert('提示', '请选择一条要暂停的记录！');
        }
    }

    function resume() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认恢复当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/schedule/resume',
                        data: {'jobIds': row.uuid},
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
            $.messager.alert('提示', '请选择一条要恢复的记录！');
        }
    }

    function runOnce() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认立即执行当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/schedule/runOnce',
                        data: {'jobIds': row.uuid},
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
            $.messager.alert('提示', '请选择一条要立即执行的记录！');
        }
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            beanName: $("#queryBeanName").val().trim(),
            status: $("#queryStatus").val()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>