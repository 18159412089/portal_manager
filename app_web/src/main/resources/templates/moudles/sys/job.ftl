<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>角色管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div class="easyui-layout" fit=true>
    <div region="west" style="width:270px;" split="true" collapsible="true">
        <!-- treegride -->
        <ul id="tg" class="easyui-tree" data-options="url:'${request.contextPath}/sys/dept/getTreeByEnable'"></ul>
    </div>
    <div region="center">
        <!-- toolbar -->
        <div id="toolbar">
            <#--<@sec.authorize access="hasAuthority('sys:job:add')">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="newJob()">新增</a>
            </@sec.authorize>
            <@sec.authorize access="hasAuthority('sys:job:edit')">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editJob()">修改</a>
            </@sec.authorize>
            <@sec.authorize access="hasAuthority('sys:job:enable,sys:job:diable')">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock_open'" onclick="enableJob()">启用</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="disableJob()">禁用</a>
            </@sec.authorize>-->
            <@sec.authorize access="hasAuthority('sys:job:roleAssign')">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-large-smartart'" onclick="roleAssign()">分配角色</a>
            </@sec.authorize>
        </div>
        <!-- datagrid -->
        <table id="dg" class="easyui-datagrid" style="width:100%px;height:95%" url="${request.contextPath}/sys/job/list"
               toolbar="#toolbar"
               data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				pagination:true,
				pageSize:10,
				fit:true,
                pageList:[10,30,50]">
            <thead>
            <tr>
                <th field="name" width="15%">岗位名称</th>
                <th field="seq" width="15%">岗位编号</th>
                <th field="deptName" width="15%">隶属部门</th>
                <th field="enable" width="10%" align="center" formatter="Ams.formatEnable">状态</th>
                <th field="remark" width="30%" formatter="Ams.tooltipFormat">备注</th>
                <th field="updateDate" width="15%" formatter="formatView">操作</th>
            </tr>
            </thead>
        </table>

        <!-- dialog1 -->
        <div id="dlg1" class="easyui-dialog" style="width: 400px"
             data-options="closed:true,modal:true,border:'thin',buttons:'#dlg1-buttons'">
            <form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
                <input name="uuid" hidden="true"/>
                <div style="margin-bottom: 10px">
                    <input name="name" class="easyui-textbox" required="true" label="名称:" style="width: 100%">
                </div>
                <div style="margin-bottom: 10px">
                    <input name="seq" class="easyui-textbox" label="岗位编号:" style="width: 100%">
                </div>
                <div style="margin-bottom:10px">
	           	<@al.deptCommotree name="dept" id="dept" required="true" label="隶属部门:" labelPosition="left" multiple="false" editable="true" style="width:100%" pid="" enable="2"/>
                </div>
                <div style="margin-bottom: 10px">
                    <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                           style="width: 100%; height: 120px">
                </div>
            </form>
        </div>
        <div id="dlg1-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveJob()"
               style="width: 90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
               onclick="javascript:$('#dlg1').dialog('close')" style="width: 90px">取消</a>
        </div>
        <!-- dialog2 -->
        <div id="dlg2" class="easyui-dialog" style="width:600px;height:400px;"
             data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
            <div class="easyui-panel" style="width:100%;height:100%" style="padding:5px">
                <table id="dd" class="easyui-datagrid" style="width:100%px;height:100%"
                       url="${request.contextPath}/sys/role/listnopage" data-options="
							rownumbers:true,
							singleSelect:false,
							checkOnSelect:true,
							selectOnCheck:true,
							autoRowHeight:false,
							pagination:false,
							pageSize:10,
			                pageList:[10]">
                    <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th field="name" width="30%">名称</th>
                        <th field="remark" width="67%" formatter="Ams.tooltipFormat">备注</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div id="dlg2-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRoleAndJob()"
               style="width:90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
               onclick="cancel()" style="width:90px">取消</a>
        </div>
        <div id="detail" class="easyui-dialog" style="width:600px;height:400px;"
		     data-options="closed:true,border:'thin',buttons:'#detail-buttons',modal:true">
		    <table id="userList" class="easyui-datagrid" style="width:100%px;height:100%"
		                   data-options="
									rownumbers:true,
									autoRowHeight:false">
		                <thead>
		                <tr>
		                    <th field="userName" width="70%">人员</th>
		                    <th field="enable" width="30%" align="center" formatter="Ams.formatEnable">状态</th>
		                </tr>
		                </thead>
		            </table>
		</div>
		<div id="detail-buttons">
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
		       onclick="javascript:$('#detail').dialog('close')" style="width:90px">取消</a>
		</div>
    </div>
</div>
<script>
    $('#tg').tree({
        onClick: function (node) {
            $('#dg').datagrid({
                url: Ams.ctxPath + '/sys/job/list',
                queryParams: {deptid: node.id}
            });
        }
    });

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    
    function formatView(value,row,index){
    	var jobId = row.uuid;
    	return '<div>'+Ams.setImageSee()+'<a href="#" class="easyui-linkbutton" onClick="viewDetail(\''+jobId+'\')">查看岗位人员</a></div>';
    }
    
    function viewDetail(jobId) {
    	$('#detail').dialog('open').dialog('center').dialog('setTitle', '查看岗位人员');
    	$('#userList').datagrid("options").url = Ams.ctxPath + '/sys/job/listUser?jobId='+jobId;
    	$('#userList').datagrid("reload");
    }

    function newJob() {
        var row = $('#tg').tree('getSelected');
        $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '新增岗位');
        $('#parent').combotree({disabled: false});
        $('#fm').form('clear');
        if (row) {
            $('#dept').combotree('setValue', row.id);
        }
        url = Ams.ctxPath + '/sys/job/saveJob';
    }

    function editJob() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/job/getJob',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '修改岗位');
                    if (row.parentId == '') {
                        $('#parent').combotree({disabled: true});
                    }
                    else {
                        $('#parent').combotree({disabled: false});
                    }
                    $('#fm').form('load', result);
                    url = Ams.ctxPath + '/sys/job/saveJob';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveJob() {
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
                    $('#dlg1').dialog('close'); // close the dialog
                    $('#dg').datagrid('load'); // reload the data
                }
            }
        });
    }

    function disableJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认禁用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/job/editJobStatus',
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

    function enableJob() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认启用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/job/editJobStatus',
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

    function saveRoleAndJob() {
        var row = $('#dg').datagrid('getSelected');
        var rows = $('#dd').datagrid('getChecked');
        console.info(getRoleIds(rows));
        if (rows.length > 0) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/job/saveRoleAndJob',
                data: {
                    'uuid': row.uuid,
                    'roleIds': getRoleIds(rows)
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#dlg2').dialog('close');
                        $('#dg').datagrid('load');
                    }
                }
                ,
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请勾择至少一条要分配的角色！');
        }
    }

    function getRoleIds(rows) {
        var roleIds = '';
        for (var i = 0; i < rows.length; i++) {
            if (i == rows.length - 1) {
                roleIds += "'" + rows[i].uuid + "'";
            } else {
                roleIds += "'" + rows[i].uuid + "',";
            }
        }
        return roleIds;
    }

    function roleAssign() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                url: Ams.ctxPath + '/sys/job/roleAssign',
                type: 'POST',
                data: {'uuid': row.uuid},
                dataType: 'json',
                success: function (result) {
                    var result = eval(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        var data = eval(result.data);
                        setCheckBox(data);
                    }
                }
            });
            $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '角色配置');
        } else {
            $.messager.alert('提示', '请选择一条要分配角色的记录！');
        }
    }

    function setCheckBox(data) {
        $('#dd').datagrid('uncheckAll');
        var dd = $('#dd').datagrid('getData').rows;
        //循环遍历
        $.each(data, function (idx, val) {
            for (var i = 0; i < dd.length; i++) {
                if (dd[i].uuid == val.uuid) {
                    //选中
                    $('#dd').datagrid('checkRow', i);
                }
            }
        });
    }

    function cancel() {
        $('#dd').datagrid('clearChecked');
        $('#dlg2').dialog('close');
    }
</script>
</body>
</html>