<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>部门管理</title>
</head>
<body style="overflow: auto;">
    <#include "/common/loadingDiv.ftl"/>
    <#include "/decorators/header.ftl"/>
    <#include "/passwordModify.ftl">
    <#include "/secondToolbar.ftl">
    <style>
        .datagrid-toolbar .textbox-label{
            width: auto!important;
        }
        #allUserTb >div{
            display: inline-block;
        }


        .panel.window.panel-htop .panel-header{
            width: 100% !important;
            border-right: 1px solid #cacaca !important;
        }
        .datagrid .datagrid-wrap .datagrid-view div[class^="datagrid-view"]{
            border-right: 1px solid #cacaca;
        }

    </style>
<!-- datagrid -->
<div class="easyui-layout" fit=true style="padding-left:10px;padding-right: 10px">
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">部门名称:</label>
                <input id="queryDeptName" name="queryDeptName" class="easyui-textbox"  style="width:200px;">
                <label class="control-label">部门类型:</label>
               	<@al.menuCommobox name="queryCategory" id="queryCategory" labelPosition="left" style="width:200px" type="JobScheduleDepartmentEnum" onChange=""/>
                <a href="javascript:void(0)" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-add'" onclick="addDept()">新建部门</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editDept()">部门修改</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="deleteDept()">删除部门</a>
        	<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-lock_open'" onclick="enableDept()">启用</a>
    		<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-lock'" onclick="disableDept()">禁用</a>
        </@sec.authorize>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
               url="${request.contextPath}/jobSchedule/jobScheduleDepartment/list" data-options="
            queryParams : '',
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:10,
            pageList:[10,20,50]">
            <thead>
            <tr>
                <th field="name" width="120px" formatter="Ams.tooltipFormat">部门名称</th>
            <th field="category" width="120px" formatter="deptCategoryFormat">部门类型</th>
            <th field="enable" width="120px" formatter="Ams.formatEnable">状态</th>
                <th field="userName" width="200px" formatter="Ams.tooltipFormat">使用人员</th>
                <th field="uuid" width="20%" align="left" formatter="formatView">操作</th>
            </tr>
            </thead>
        </table>
</div>
<!-- 新建部门  dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="uuid" name="uuid" hidden="true"/>
        <#-- <input id="userAccount" name="userAccount" hidden="true"/> -->
        <div style="margin-bottom:10px">
        	<label class="control-label">部门名称：</label>
            <input id="name" name="name" class="easyui-textbox" data-options="required:true" style="width: 100%;">
        </div>
        <div style="margin-bottom:10px">
        	<@al.menuCommobox name="category" id="category" label="部门类型:" labelPosition="left" required="true" style="width:200px" type="JobScheduleDepartmentEnum" onChange=""/>
        </div>
        <#-- <div style="margin-bottom:10px">
            <input id="dlg_selectedUsers" name="dlg_selectedUsers" class="easyui-textbox" multiline="true" data-options="label:'使用人员：'" style="width:100%;height:150px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onClick="addUser()">添加使用人员</a>
        </div> -->
    </form>
</div>

<!-- 人员维护  dlg2 -->
<div id="dlg2" class="easyui-dialog easyui-layout" style="height:600px;width: 1100px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
    <div id="allUserTb" style="padding:5px;height:auto">
		<#-- <@al.deptCommotree name="tbDeptName" id="tbDeptName" required="false" label="部门:" labelPosition="left" multiple="false" editable="true" style="width:250px;" pid="" enable="1"/>
        <br/> -->
        <input id="queryLogin" name="queryLogin" class="easyui-textbox" label="登录名:" style="width:200px;">
        <div style="height:10px;"></div>
		<input id="queryUserName" name="queryUserName" class="easyui-textbox" label="姓名:" style="width:200px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doUserSearch()">查询</a>
    </div>
    <div id="checkJobTb" style="padding:5px;height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
           onclick="rightGridClear()">清空</a>
    </div>
    <div class="easyui-layout" fit=true>
        <div data-options="region:'west',split:true,collapsible:false" style="width:500px;">
	        <table id="leftGrid" class="easyui-datagrid" title="所有用户列表" style="width:500px;" toolbar="#allUserTb"
	           url="${request.contextPath}/sys/user/list?logintype=SYSTEM" data-options="
	            rownumbers:true,
	            singleSelect:false,
	            striped:true,
	            autoRowHeight:true,
	            fitColumns:true,
	            fit:true,
				idField:'uuid',
	            pagination:true,
	            pageSize:10,
	            pageList:[10]">
				<thead>
		    		<tr>
			    		<th data-options="field:'ck',checkbox:true"></th>
			            <th field="loginname" width="150px">账号</th>
			            <th field="name" width="120px">姓名</th>
			            <th field="deptName" width="200px" formatter="Ams.tooltipFormat">部门</th>
			        </tr>
		    	</thead>
		    </table>
        </div>
        <div data-options="region:'center'" style="padding-top:220px;padding-left:12px;">
            <a href="javascript:void(0)" class="easyui-linkbutton c1" style="width:60px; margin-bottom:20px;"
               data-options="iconCls:'icon-redo'"
               onclick="leftToRight()"></a>
        </div>
        <div data-options="region:'east',split:true,collapsible:false" style="width:500px;height:auto">
            <table id="rightGrid" class="easyui-datagrid" title="已选择用户列表"
                   style="width: 493px" data-options="
              				border:false,
                            rownumbers:true,
                            singleSelect:false,
                            toolbar:'#checkJobTb',
                            checkOnSelect:true,
                            selectOnCheck:true">
                <thead>
                <tr>
                    <th field="loginname" width="35%">账号</th>
                    <th field="name" width="45%">姓名</th>
                    <#--<th field="deptName" width="30%">部门</th>-->
                    <th field="operate" width="20%" formatter="delFormat">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveDept()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>
<div id="dlg2-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUsers()"
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

    function doSearch() {
        $('#dg').datagrid('load', {
            name : $("#queryDeptName").val(),
            category : $("#queryCategory").val()
        });
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
    
    function doUserSearch(){
		$('#leftGrid').datagrid('load', {
			loginname: $("#queryLogin").val().trim(),
			name : $("#queryUserName").val()
		});
    }
    
    function addDept() {
    	$('#dlg #fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增部门');
        $('#category').combobox('readonly',false);
        url = Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/saveDept';
    }
    
    <#-- function addUser(){
        $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '新增使用人员');
    } -->
    
    function saveUsers(){
    	var row = $('#dg').datagrid('getSelected');
    	if (row) {
            var ids = '';
			var names = '';
			var rows = $('#rightGrid').datagrid('selectAll').datagrid('getSelections');
	        for (var i = 0; i < rows.length; i++) {
	            if (i == rows.length - 1) {
	                ids += rows[i].uuid;
	                names += rows[i].name;
	            } else {
	                ids += rows[i].uuid + ";";
	                names += rows[i].name + ";";
	            }
	        }
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/saveUser',
                data: {
                    'uuid': row.uuid,
                    'userName': names,
                    'userId': ids
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
            $.messager.alert('提示', '请选择一条要分配用户的部门！');
        }
	    $('#dlg2').dialog('close');
    }
    
    function saveDept() {
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
                    $('#dg').datagrid('load');
                }
            }
        });
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
    
    function loadRightGrid(rowid) {
        $.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/getSelectedUsers',
            data: {
                'uuid': rowid
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
    
    function formatView(value,row,index){
    	var rowid = row.uuid;
    	var ids = row.userId;
    	return '<div>'+Ams.setImageSee()+'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="viewDetail(\''+rowid+'\',\''+ids+'\')">查看部门使用人员</a></div>';
    }
    
    function deptCategoryFormat(value,row,index){
    	if(value == "VEHICLE"){
    		return "车辆污染";
    	} else if(value == "DMBZRZ") {
    		return "党建目标责任制";
    	} else {
    		return "";
    	}
    }
    
    function viewDetail(rowid, ids) {
		$("#leftGrid").datagrid("clearSelections");
		$('#leftGrid').datagrid('load', {
			loginname: $("#queryLogin").val().trim(),
			name : $("#queryUserName").val()
		});
		<#-- $('#leftGrid').datagrid({onLoadSuccess : function(data){
			if (data) {
                $.each(data.rows, function (index, item) {
                    if (ids.indexOf(item.uuid) > -1) {
                        $('#leftGrid').datagrid('selectRow', index);
                    }
                });
            }
		}}); -->
        $('#dlg2').dialog('open').dialog('center').dialog('setTitle', '修改部门使用人员');
    	//$('#leftGrid').datagrid("reload");
    	loadRightGrid(rowid);
    }
    
    function delFormat(value, row, index) {
        return '<div>'+Ams.setImageDelete()+'<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:\'icon-remove\'" onclick="userRemove(' + index + ')">删除</a></div>'
    }
    
    function userRemove(index) {
        $('#rightGrid').datagrid('deleteRow', index);
        var rows = $('#rightGrid').datagrid("getRows");
        $('#rightGrid').datagrid("loadData", rows);
    }
    
    function rightGridClear() {
        $('#rightGrid').datagrid('loadData', {total: 0, rows: []});
    }
    
    function deleteDept() {
    	var row = $('#dg').datagrid('getSelected');
    	 if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
    	$.ajax({
            type: 'POST',
            url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/deleteDept',
            data: {
                'uuid': row.uuid
            },
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
    function editDept() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/getDept',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改部门');
                    $('#fm').form('load', result.data);
                    $('#category').combobox('readonly',true);
                    url = Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/saveDept';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }
    
    function disableDept() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认禁用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/disableDept',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                $.messager.show({
                                    title: '错误',
                                    height:'100%',
                                    msg: result.message
                                });
                            } else {
                                $('#dg').datagrid('reload');
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
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认启用当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/jobSchedule/jobScheduleDepartment/enableDept',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                $.messager.show({
                                    title: '错误',
                                    height:'100%',
                                    msg: result.message
                                });
                            } else {
                                $('#dg').datagrid('reload');
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