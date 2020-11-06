<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>部门管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div class="easyui-layout" fit=true>
    <div id="toolbar">
	<#--<@sec.authorize access="hasAuthority('sys:dept:add')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newDept()">新增</a>
    </@sec.authorize>
	<@sec.authorize access="hasAuthority('sys:dept:edit')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editDept()">修改</a>
    </@sec.authorize>
	<@sec.authorize access="hasAuthority('sys:dept:enable')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock_open'" onclick="enableDept()">启用</a>
    </@sec.authorize>
	<@sec.authorize access="hasAuthority('sys:dept:disable')">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="disableDept()">禁用</a>
	</@sec.authorize>-->
    </div>
    <table id="tg" class="easyui-treegrid" style="width:100%;"
           url="${request.contextPath}/sys/dept/getAllTree"
           idField="id" treeField="name" toolbar="#toolbar" fit=true>
        <thead>
        <tr>
            <th field="name" width="40%">部门名称</th>
            <th field="leadernames" width="20%">部门负责人</th>
            <th field="enable" width="20%" align="left" formatter="Ams.formatEnable">是否启用</th>
            <th field="id" width="20%" align="left" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons' ">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="部门名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            	<@al.deptCommotree name="parent" id="parent" required="true" label="父部门:" labelPosition="left" multiple="false" editable="true" style="width:100%" pid="" enable="2"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="leadernames" id="leadernames" value="" hidden="true"/>
            	<@al.userCommotree name="leaderids" id="leaderids" required="false" label="部门负责人:" labelPosition="left" multiple="false" editable="true" style="width:100%" pid="" enable="2" onChange="function(newValue,oldValue) { $('#leadernames').val($('#leaderids').combotree('getText')); }"/>
        </div>
        <div style="margin-bottom:10px">
            <input id="num" name="num" class="easyui-numberspinner" data-options="min:1,max:100,increment:1" label="排序:"
                   style="width:100%"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                   style="width:100%;height:120px">
        </div>
        <!--
        <input class="easyui-unitbox" data-options="readonly:true" label="所属部门：" style="width:100%">
        -->
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveDept()" style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<div id="detail" class="easyui-dialog" style="width:600px;height:400px;"
     data-options="closed:true,border:'thin',buttons:'#detail-buttons',modal:true">
    <table id="jobAndUser" class="easyui-datagrid" style="width:100%px;height:100%"
                   data-options="
							rownumbers:true,
							autoRowHeight:false">
                <thead>
                <tr>
                    <th field="jobName" width="70%">岗位</th>
                    <th field="enable" width="30%" align="center" formatter="Ams.formatEnable">状态</th>
                </tr>
                </thead>
            </table>
</div>
<div id="detail-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#detail').dialog('close')" style="width:90px">取消</a>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    
    function formatView(value,row,index){
    	var deptId = row.id;
    	return '<div>'+Ams.setImageSee()+'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="viewDetail(\''+deptId+'\')">查看部门岗位</a></div>';
    }
    
    function viewDetail(deptId) {
    	$('#detail').dialog('open').dialog('center').dialog('setTitle', '查看岗位人员');
    	$('#jobAndUser').datagrid("options").url = Ams.ctxPath + '/sys/dept/listJobAndUser?deptId='+deptId;
    	$('#jobAndUser').datagrid("reload");
    }

    function newDept() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle','新增部门');
        var row = $('#tg').datagrid('getSelected');
        $('#parent').combotree({disabled: false});
        if (row) {
            $('#parent').combotree('setValue', row.id);
        }
        url = Ams.ctxPath + '/sys/dept/saveDept';
    }

    function editDept() {
        $('#fm').form('clear');
        var row = $('#tg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/dept/getDept',
                data: {'uuid': row.id},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改部门');
                    if (row.parentId == '') {
                        $('#parent').combotree({disabled: true});
                    } else {
                        $('#parent').combotree({disabled: false});
                    }
                    $('#fm').form('load', result);
                    url = Ams.ctxPath + '/sys/dept/saveDept';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveDept() {
        //$.messager.progress();
        $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
        $('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (result) {
                $.messager.progress('close');
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    $.messager.show({
                        title: '错误',
                        height:'100%',
                        msg: result.message
                    });
                } else {
                    $('#dlg').dialog('close');        // close the dialog
                    $('#tg').treegrid('reload');    // reload the user data
                }
            }
        });
    }

    function disableDept() {
        var row = $('#tg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认禁用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/dept/disableDept',
                        data: {'uuid': row.id},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                $.messager.show({
                                    title: '错误',
                                    height:'30%',
                                    msg: result.message
                                });
                            } else {
                                $('#tg').treegrid('reload');    // reload the user data
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

    function enableDept() {
        var row = $('#tg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认启用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/dept/enableDept',
                        data: {'uuid': row.id},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                $.messager.show({
                                    title: '错误',
                                    height:'100%',
                                    msg: result.message
                                });
                            } else {
                                $('#tg').treegrid('reload');    // reload the user data
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
</script>
</body>
</html>