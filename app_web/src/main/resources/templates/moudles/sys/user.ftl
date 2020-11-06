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
                <label class="control-label">登录名:</label>
                <input id="queryLogin" name="queryLogin" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">姓名:</label>
                <input id="queryName" name="queryName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">电话:</label>
                <input id="queryPhone" name="queryPhone" class="easyui-textbox" style="width:200px;">
                <label class="control-label">状态:</label>
                <select name="queryEnable" id="queryEnable" class="easyui-combobox" data-options="editable:true" style="width:250px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
                <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
    	<#--
    	<@sec.authorize access="hasAuthority('sys:role:edit')">
        <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editUser()">修改</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:user:enable')">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock_open'" onclick="enableUser()">启用</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:user:disable')">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="disableUser()">禁用</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:user:resetPwd')">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetPwd()">重置密码</a>
        </@sec.authorize>-->
        <@sec.authorize access="hasAuthority('sys:user:add')">
            <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newUser()">新增</a>
        </@sec.authorize>
    	<@sec.authorize access="hasAuthority('sys:user:assignJob')">
            <a href="#" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-large-smartart'" onclick="assignJob()">岗位分配</a>
        </@sec.authorize>
    </div>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/sys/user/list?logintype=SYSTEM" data-options="
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
            <th field="loginname" width="120px">账号</th>
            <th field="name" width="120px">姓名</th>
            <th field="sex" width="60px" formatter="Ams.formatSex">性别</th>
            <th field="deptName" width="250px" formatter="Ams.tooltipFormat">网格</th>
            <th field="jobName" width="120px" formatter="Ams.tooltipFormat">岗位编号</th>
            <th field="phone" width="120px">手机</th>
            <th field="idcard" width="130px">身份证</th>
            <th field="email" width="200px" formatter="Ams.tooltipFormat">邮箱</th>
            <th field="enable" width="100px" align="left" formatter="Ams.formatEnable">状态</th>
            <th field="updateDate" width="150px" formatter="Ams.timeDateFormat">修改时间</th>
        </tr>
        </thead>
    </table>
</div>

<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:400px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="userInfo.uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="user.loginname" id="loginname" class="easyui-textbox" required="true" label="账号:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="user.name" class="easyui-textbox" required="true" label="姓名:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="job.seq" class="easyui-textbox" required="true" label="岗位编号:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input name="job.name" class="easyui-textbox" required="true" label="岗位描述:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input id="roleUuids" name="roleUuids" class="easyui-combobox" editable="false" label="角色:" style="width:100%;" required="true"/>
        </div>
        <div style="margin-bottom:10px">
            <@al.deptSynCommotree name="userInfo.departmentId" required="true" label="网格:"/>
        </div>
        <div style="margin-bottom:10px">
            <@al.deptCommotree name="portalDepartmentId" required="false" label="部门:" enable="2"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.mobilephone" class="easyui-textbox" label="手机号码:" style="width:100%;" data-options="validType:'mobile'">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.telephone" class="easyui-textbox" label="座机号码:" style="width:100%;" data-options="validType:'tel'">
        </div>
        <div style="margin-bottom:10px">
            <select name="user.sex" class="easyui-combobox" data-options="required:true,editable:false" label="性别:" style="width:100%">
                <option value="1">男</option>
                <option value="0">女</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <input name="user.idcard" class="easyui-textbox" label="身份证:" data-options="validType:'idCode'" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="user.email" class="easyui-textbox" label="邮箱:" data-options="validType:'checkEmail'" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.highestEducation" class="easyui-textbox" label="学历:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.birthday" class="easyui-datebox" label="出生年月:" data-options="validType:'checkDate'" style="width:100%;">
        </div>
        <!--
        <div style="margin-bottom:10px">
            <input name="userInfo.inspArea" class="easyui-textbox" label="巡查区域:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.inspFreq" id="userInfoInspFreq" class="easyui-textbox" label="每月巡查频率:" style="width:100%;" data-options="validType:'number'">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.training" class="easyui-textbox" label="业务培训情况:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px">
            <input name="userInfo.checkInfo" class="easyui-textbox" label="考核奖惩记录:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px;display:none" >
            <input name="userInfo.anychatUserId" class="easyui-textbox" label="音视频账号:" style="width:100%;">
        </div>
        <div style="margin-bottom:10px;display:none">
            <input name="userInfo.supportAudioVideo" class="easyui-textbox" label="是否支持音视频:" style="width:100%;">
        </div>
        -->
        <div style="margin-bottom:10px">
            <input name="userInfo.workCode" class="easyui-textbox" label="工作牌号:" style="width:100%;">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<!-- dialog2 -->
<div id="assignJobDlg" class="easyui-dialog easyui-layout" title="可分配岗位" style="height:600px;width: 1000px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#assignJobDlg-buttons'">
    <div id="allJobTb" style="padding:5px;height:auto">
        <@al.deptCommotree name="tbDeptName" id="tbDeptName" required="false" label="部门:" labelPosition="left" multiple="false" editable="true" style="width:250px;" pid="" enable="1"/>
        <br/>
        <div style="height:10px;"></div>
        <input id="tbJob" name="tbJob" class="easyui-textbox" label="岗位名称:" style="width:250px;">
        <a href="#" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
           onclick="tbSearch()">查询</a>
    </div>
    <div id="checkJobTb" style="padding:5px;height:auto">
        <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-search'"
           onclick="checkJobTbClear()">清空</a>
    </div>
    <div class="easyui-layout" fit=true>
        <div data-options="region:'west',split:true,collapsible:false" style="width:460px;">
            <table id="leftGrid" class="easyui-datagrid" title="所有岗位列表"
                   style="width: 460px" data-options="
               				border:false,
                            rownumbers:true,
                            singleSelect:false,
                            checkOnSelect:true,
                            selectOnCheck:true,
                            toolbar:'#allJobTb',
                            pagination:true,
                            pageSize:10,
                            fit:true,
                            pageList:[10],
                            displayMsg: ''">
                <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true" width="10%"></th>
                    <th field="name" width="30%">岗位名称</th>
                    <th field="seq" width="25%">岗位编号</th>
                    <th field="deptName" width="42%">隶属部门</th>
                </tr>
                </thead>
            </table>
        </div>
        <div data-options="region:'center'" style="padding-top:220px;padding-left:12px;">
            <a href="#" class="easyui-linkbutton c1 btn-sky-blue" style="width:60px; margin-bottom:20px;"
               data-options="iconCls:'icon-redo'"
               onclick="leftToRight()"></a>
        </div>
        <div data-options="region:'east',split:true,collapsible:false" style="width:460px;height:auto">
            <table id="rightGrid" class="easyui-datagrid" title="已选择岗位列表"
                   style="width: 450px" data-options="
              				border:false,
                            rownumbers:true,
                            singleSelect:false,
                            toolbar:'#checkJobTb',
                            checkOnSelect:true,
                            selectOnCheck:true,">
                <thead>
                <tr>
                    <th field="name" width="30%">岗位名称</th>
                    <th field="seq" width="25%">岗位编号</th>
                    <th field="deptName" width="30%">隶属部门</th>
                    <th field="operate" width="15%" formatter="delFormat">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<div id="assignJobDlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUserAndJob()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#assignJobDlg').dialog('close')" style="width:90px">取消</a>
</div>

<script type="text/javascript">
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    $(function () {
        var pager = $('#leftGrid').datagrid().datagrid('getPager');
        pager.pagination({showPageInfo: false});

        $('#roleUuids').combobox({
            url: '${request.contextPath}/sys/role/roleList',
            method: 'post',
            valueField: 'uuid',//绑定字段ID
            textField: 'name',
            panelHeight: 'auto',//自适应
            multiple: true,
            panelMaxHeight:'240',
            formatter: function (row) {
                var opts = $(this).combobox('options');
                return '<input type="checkbox" class="combobox-checkbox" id="' + row[opts.valueField] + '">' + row[opts.textField]
            },
            onShowPanel: function () {
                var opts = $(this).combobox('options');
                var target = this;
                var values = $(target).combobox('getValues');
                $.map(values, function (value) {
                    var el = opts.finder.getEl(target, value);
                    el.find('input.combobox-checkbox')._propAttr('checked', true);
                })
            },
            onLoadSuccess: function () {
                var opts = $(this).combobox('options');
                var target = this;
                var values = $(target).combobox('getValues');
                $.map(values, function (value) {
                    var el = opts.finder.getEl(target, value);
                    el.find('input.combobox-checkbox')._propAttr('checked', true);
                })
            },
            onSelect: function (row) {
                var opts = $(this).combobox('options');
                var el = opts.finder.getEl(this, row[opts.valueField]);
                el.find('input.combobox-checkbox')._propAttr('checked', true);
            },
            onUnselect: function (row) {
                var opts = $(this).combobox('options');
                var el = opts.finder.getEl(this, row[opts.valueField]);
                el.find('input.combobox-checkbox')._propAttr('checked', false);
            }
        });
    });

    function delFormat(value, row, index) {
        return '<a href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-remove\'" onclick="jobRemove(' + index + ')">删除</a>'
    }

    function newUser() {
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增用户');
        $('#fm').form('clear');
        $('#loginname').textbox({readonly: false});
        //url = Ams.ctxPath + '/sys/user/saveUser';
        url = Ams.ctxPath + '/sys/user/saveUserRelateInfo';
    }

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

    function saveUser() {
        if(!$('#fm').form('validate')){
            return;
        }

        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: $('#fm').serialize(),
            success: function (result) {
                console.log(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    Ams.info('创建成功！');
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                }
            }
        });
    }

    function disableUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认禁用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/editUserStatus',
                        data: {
                            'uuid': row.uuid,
                            'enable': 0,
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
            $.messager.alert('提示', '请选择一条要禁用的记录！');
        }
    }

    function enableUser() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            if (1 == row.enable) {
                $.messager.alert('提示', '已经是启用状态！');
                return;
            }
            $.messager.confirm("提示信息", "确认启用当前选中的记录吗?", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/editUserStatus',
                        data: {
                            'uuid': row.uuid,
                            'enable': 1,
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
            $.messager.alert('提示', '请选择一条要启用的记录！');
        }
    }

    function resetPwd() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认重置当前选中的用户密码为 : 123456 吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/user/resetPwd',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $.messager.show({
                                    title: '成功',
                                    msg: '重置密码成功！'
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

    function assignJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            loadRightGrid(row);
            $('#leftGrid').datagrid("options").url = Ams.ctxPath + '/sys/job/userNotAssignList?enable=1&userId='+row.uuid;
            tbSearch();
            $('#assignJobDlg').dialog('open').dialog('center').dialog('setTitle', '分配岗位');
        } else {
            $.messager.alert('提示', '请选择一条要分配岗位的记录！');
        }
    }

    function loadRightGrid(row) {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/sys/user/assignJob',
            data: {
                'uuid': row.uuid
            },
            success: function (result) {
                var result = eval(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    var data = eval(result.data);
                    $('#rightGrid').datagrid('loadData', {total: data.length, rows: data});
                }
            },
            dataType: 'json'
        });
    }

    function saveUserAndJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            var checkedData = getCheckedData().toString();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/user/saveUserAndJob',
                data: {
                    'uuid': row.uuid,
                    'jobIds': checkedData
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#assignJobDlg').dialog('close');
                        $('#dg').datagrid('load');
                    }
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要分配岗位的记录！');
        }
    }

    function getCheckedData() {
        var rows = $('#rightGrid').datagrid('selectAll').datagrid('getSelections');
        var roleIds = '';
        for (var i = 0; i < rows.length; i++) {
            if (i == rows.length - 1) {
                roleIds += rows[i].uuid;
            } else {
                roleIds += rows[i].uuid + ",";
            }
        }
        return roleIds;
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            loginname: $("#queryLogin").val().trim(),
            name: $("#queryName").val().trim(),
            phone: $("#queryPhone").val().trim(),
            enable: $("#queryEnable").val()
        });
    }

    function tbSearch() {
        $('#leftGrid').datagrid('load', {
            userid: $('#dg').datagrid('getSelected').uuid,
            jobName: $("#tbJob").val(),
            deptid: $("#tbDeptName").val(),
        });
    }

    function checkJobTbClear() {
        $('#rightGrid').datagrid('loadData', {total: 0, rows: []});
    }

    function jobRemove(index) {
        $('#rightGrid').datagrid('deleteRow', index);
        var rows = $('#rightGrid').datagrid("getRows");
        $('#rightGrid').datagrid("loadData", rows);
    }

    function leftToRight() {
        var selected = $('#leftGrid').datagrid("getSelections");
        var haveSelected = $('#rightGrid').datagrid("selectAll").datagrid("getSelections");
        for (var i = 0; i < selected.length; i++) {
            for (var j = 0; j < haveSelected.length; j++) {
                if (selected[i].uuid === haveSelected[j].uuid) {
                    var rowIndex = $('#rightGrid').datagrid('getRowIndex', haveSelected[j]);
                    $('#rightGrid').datagrid('deleteRow', rowIndex);
                    break;
                }
            }
            //把选择的数据添加到右侧grid
            $('#rightGrid').datagrid('appendRow', selected[i]);
        }
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>