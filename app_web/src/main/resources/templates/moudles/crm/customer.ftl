<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<!-- toolbar -->
<div id="toolbar">
    <div style="padding:3px;" id="searchBar">
        <form id="searchForm">
            <input id="queryCode" class="easyui-textbox" label="客户编号:" style="width:200px;">
            <input id="queryName" class="easyui-textbox" label="客户名称:" style="width:200px;">
            <input id="queryPhone" class="easyui-textbox" label="客户电话:" style="width:200px;">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-arrow_refresh_small'"
               onclick="doReset()">重置</a>
        </form>
    </div>
    <@sec.authorize access="hasRole('ROLE_ASSETMANAGER') OR hasRole('ROLE_ADMIN')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
       onclick="newCustomer()">新增客户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"
       onclick="editCustomer()">修改客户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
       onclick="delCustomer()">删除客户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
       onclick="newAdmin()">新增系统用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"
       onclick="editAdmin()">修改系统用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
       onclick="removeAdmin()">删除系统用户</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetPwd()">重置密码</a>
    </@sec.authorize>
</div>
<!-- Customer datagrid -->
<table id="dg" class="easyui-datagrid" title="客户管理" style="width:100%px;height:auto"
       url="${request.contextPath}/crm/customer/list" toolbar="#toolbar"
       data-options="
				    rownumbers:false,
				    singleSelect:true,
				    autoRowHeight:false,
				    fit:true,
				    pagination:true,
				    pageSize:10,
                 pageList:[10,50,100]">
    <thead>
    <tr>
        <th colspan="6">客户信息</th>
        <th rowspan="2" field="admin" width="200" align="center">系统账号</th>
    </tr>
    <tr>
        <th field="code" width="200">编号</th>
        <th field="name" width="200">名称</th>
        <th field="contact" width="200">联系人</th>
        <th field="phone" width="200">联系电话</th>
        <th field="email" width="200">邮箱</th>
        <th field="address" width="300">地址</th>
    </tr>
    </thead>
</table>

<!-- Customer dialog -->
<div id="dlg" class="easyui-dialog" style="width: 400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom: 10px">
            <input name="code" class="easyui-textbox" required="true" label="客户编号:" style="width: 100%">
        </div>
        <div style="margin-bottom: 10px">
            <input name="name" class="easyui-textbox" required="true" label="客户名称:" style="width: 100%">
        </div>
        <div style="margin-bottom: 10px">
            <input name="contact" class="easyui-textbox" required="true" label="联系人:" style="width: 100%">
        </div>
        <div style="margin-bottom: 10px">
            <input name="phone" class="easyui-textbox" required="true" label="联系电话:" style="width: 100%">
        </div>
        <div style="margin-bottom: 10px">
            <input name="email" class="easyui-textbox" label="邮箱:" style="width: 100%">
        </div>
        <div style="margin-bottom: 10px">
            <input name="address" class="easyui-textbox" label="详细地址:" style="width: 100%">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCustomer()"
       style="width: 90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width: 90px">取消</a>
</div>

<!-- adminDetail -->
<div id="adminDetail" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="adminfm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <input name="logintype" id="logintype" class="easyui-textbox"/>
        <div style="margin-bottom:10px">
            <input name="loginname" id="loginname" class="easyui-textbox" required="true" label="账号:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="姓名:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="phone" class="easyui-textbox" required="true" label="电话:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="email" class="easyui-textbox" label="邮箱:" style="width:100%">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveAdmin()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#adminDetail').dialog('close')" style="width:90px">取消</a>
</div>

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
        $("#logintype").next().hide();
    };

    function newCustomer() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增客户');
        $('#fm').form('clear');
        url = Ams.ctxPath + '/crm/customer/save';
    }

    function editCustomer() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/crm/customer/get',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改客户');
                    $('#fm').form('load', result.crmCustomer);
                    url = Ams.ctxPath + '/crm/customer/save';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveCustomer() {
        $('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate')
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

    function delCustomer() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/crm/customer/del',
                        data: {
                            'uuid': row.uuid,
                            'userid': row.userid
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
            code: $("#queryCode").val().trim(),
            name: $("#queryName").val().trim(),
            phone: $("#queryPhone").val().trim()
        });
    }

    function newAdmin() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (row.userid != null && row.userid.length > 0) {
                return;
            }
            $('#adminDetail').dialog('open').dialog('center').dialog('setTitle', '新增管理员');
            $('#adminfm').form('clear');
            $('#loginname').textbox({readonly: false});
            url = Ams.ctxPath + '/crm/admin/save?customerId=' + row.uuid;
        } else {
            $.messager.alert('提示', '请选择一条要新增管理员的记录！');
        }
    }

    function editAdmin() {
        $('#adminfm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (row.userid == null || row.userid.length == 0) {
                return;
            }
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/crm/admin/get',
                data: {'uuid': row.userid},
                success: function (result) {
                    $('#adminDetail').dialog('open').dialog('center').dialog('setTitle', '修改管理员');
                    $('#adminfm').form('load', result.user);
                    $('#loginname').textbox({readonly: true});
                    url = Ams.ctxPath + '/crm/admin/save';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveAdmin() {
        $('#adminfm').form('submit', {
            url: url,
            onSubmit: function () {
                $('#logintype').textbox('setValue', 'CUSTOMER');
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#adminDetail').dialog('close');
                    $('#dg').datagrid('load');
                }
            }
        });
    }

    function removeAdmin() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (row.userid == null || row.userid.length == 0) {
                return;
            }
            $.messager.confirm("提示信息", "确认删除当前客户的管理员吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/crm/admin/remove',
                        data: {
                            'uuid': row.userid,
                            'customerId': row.uuid
                        },
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $.messager.show({
                                    title: '成功',
                                    msg: '删除客户的管理员成功'
                                });
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

    function resetPwd() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (row.userid == null || row.userid.length == 0) {
                return;
            }
            $.messager.confirm("提示信息", "确认给当前选中的记录重置密码吗？重置后密码是123456", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/crm/admin/resetPwd',
                        data: {'uuid': row.userid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $.messager.show({
                                    title: '成功',
                                    msg: '重置密码成功'
                                });
                                $('#dg').datagrid('load');
                            }
                        },
                        dataType: 'json'
                    });
                }
            });
        } else {
            $.messager.alert('提示', '请选择一条要重置密码的记录！');
        }
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>