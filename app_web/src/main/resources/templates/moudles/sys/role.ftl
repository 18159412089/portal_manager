<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>角色管理</title>
	<#include "/header.ftl"/>
</head>
<body>
	<#include "/common/loadingDiv.ftl"/>
<div id="toolbar">
    <div style="padding:3px;" id="searchBar">
        <form id="searchForm">
            <label class="control-label">名称:</label>
            <input id="queryName" name="queryName" class="easyui-textbox" style="width:250px;">
            <label class="control-label">编号:</label>
            <input id="queryCode" name="queryCode" class="easyui-textbox" style="width:250px;">
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
               onclick="doSearch()">查询</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
               onclick="doReset()">重置</a>
        </form>
    </div>
    <@sec.authorize access="hasAuthority('sys:role:add')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-add'" onclick="newRole()" style="margin-bottom:10px;">新增</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:role:edit')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editRole()" style="margin-bottom:10px;">修改</a>
    </@sec.authorize>
    <@sec.authorize access="hasAuthority('sys:role:menuAssign')">
    <a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-large-smartart'" onclick="menuAssign()" style="margin:10px 10px 10px 0;">菜单配置</a>
	</@sec.authorize>
</div>
<!-- datagrid -->
<table id="dg" class="easyui-datagrid" style="width:100%px;height:auto" toolbar="#toolbar"
       url="${request.contextPath}/sys/role/list" data-options="
				rownumbers:true,
				singleSelect:true,
                striped:true,
				autoRowHeight:false,
				fitColumns:true,
                fit:true,
				pagination:true,
				pageSize:10,
                pageList:[10,30,50]">
    <thead>
    <tr>
        <th field="name" width="12%">名称</th>
        <th field="code" width="12%">编号</th>
        <th field="num" width="6%">排序</th>
        <th field="remark" width="60%" formatter="Ams.tooltipFormat">备注</th>
        <th field="updateDate" width="10%" formatter="Ams.timeDateFormat">修改时间</th>
    </tr>
    </thead>
</table>
<!-- dialog1 -->
<div id="dlg1" class="easyui-dialog" style="width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg1-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
        <input name="uuid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input name="name" class="easyui-textbox" required="true" label="名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="code" class="easyui-textbox" required="true" label="编号:"
                   data-options="events:{blur:jsToUpperCase,keyup:jsToUpperCase}"
                   prompt="例如：ROOT、ADMIN" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input id="num" name="num" class="easyui-numberspinner" data-options="min:1,max:100,increment:1" label="排序:"
                   style="width:100%"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                   style="width:100%;height:120px">
        </div>
    </form>
</div>
<div id="dlg1-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRole()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg1').dialog('close')" style="width:90px">取消</a>
</div>
<!-- dialog2 -->
<div id="dlg2" class="easyui-dialog" style="width:400px;height:400px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
    <div class="easyui-panel" style="padding:5px;height:100%">
        <ul id="tt" class="easyui-tree"
            data-options="url:'/sys/menu/getMenuTree?enable=2',method:'get',animate:true,checkbox:true,lines:true"></ul>
    </div>
</div>
<div id="dlg2-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRoleAndMenu()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg2').dialog('close')" style="width:90px">取消</a>
</div>
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function newRole() {
        $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '新增角色');
        $('#parent').combotree({disabled: false});
        $('#fm').form('clear');
        url = Ams.ctxPath + '/sys/role/saveRole';
    }

    function editRole() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/role/getRole',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '修改角色');
                    $('#fm').form('load', result);
                    url = Ams.ctxPath + '/sys/role/saveRole';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function saveRole() {
        /*$('#fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('enableValidation').form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type === 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg1').dialog('close');
                    $('#dg').datagrid('load');
                }
            }
        });*/
        if(!$('#fm').form('validate')){
            return;
        }
        $.ajax({
            type: "POST",
            dataType: "json",
            url: url,
            data: $('#fm').serialize(),
            success: function (result) {
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg1').dialog('close');        // close the dialog
                    $('#dg').datagrid('load');    // reload the user data

                }
            }
        });
    }

    function menuAssign() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/role/menuAssign',
                data: {
                    'uuid': row.uuid
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type === 'E') {
                        Ams.error(result.message);
                    } else {
                        var data = eval(result.data);
                        setCheckedData(data);
                    }
                },
                dataType: 'json'
            });
            $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '菜单配置');
        } else {
            $.messager.alert('提示', '请选择一条要分配角色的记录！');
        }
    }

    function saveRoleAndMenu() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            var checkedData = getCheckedData().toString();
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/role/saveRoleAndMenu',
                data: {
                    'uuid': row.uuid,
                    'menuIds': checkedData
                },
                success: function (result) {
                    var result = eval(result);
                    if (result.type === 'E') {
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
            $.messager.alert('提示', '请选择一条要分配角色的记录！');
        }
    }

    function getCheckedData() {
        var checkedIds = [];
        var allChild = $("#tt").tree('getChildren');
        var acl = allChild.length;
        if (acl > 0) {
            for (var i = 0; i < acl; i++) {
                if (allChild[i].checkState !== "unchecked" && '0' != allChild[i].id) {
                    checkedIds.push("'" + allChild[i].id + "'");
                }
            }
        }
        return checkedIds;
    }

    //改造原来只支持3级菜单才能正常操作的情况
    function setCheckedData(data) {
        var root = $("#tt").tree("getRoot");
        var childnodes=$("#tt").tree("getChildren",root.target);
        $("#tt").tree("uncheck", root.target);
        if (data != null) {
        	for (var i = 0; i < childnodes.length; i++) {
        		for (var j = 0; j < data.length; j++) {
                    if (childnodes[i]['id'] === data[j]['uuid']) {
                        $("#tt").tree("check", childnodes[i].target);
                        break;
                    }else{
                    	$("#tt").tree("uncheck", childnodes[i].target);
                    	continue;
                    }
                }
            }
        }
    }

    function doSearch() {
        $('#dg').datagrid('load', {
            roleName: $("#queryName").val().trim(),
            roleCode: $("#queryCode").val().trim()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>