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
    <div region="west" style="width:40%;" split="true" collapsible="true">
        <div id="toolbar1">
            <!-- option button -->
            <div id="searchBar1" class="searchBar">
                <form id="searchForm1">
                	<div class="inline-block">
						<label class="textbox-label textbox-label-before" title="字典类型">字典类型:</label>
	                	<input id="queryType" name="queryType" class="easyui-textbox" style="width:200px;">
	                </div>
                	<div class="inline-block">
						<label class="textbox-label textbox-label-before" title="字典名称">字典名称:</label>
	                	<input id="queryValue" name="queryValue" class="easyui-textbox" style="width:200px;">
	                </div>
                    <div class="inline-block">
						<label class="textbox-label textbox-label-before" title="状态">状态:</label>
		                <select name="queryEnable" id="queryEnable" class="easyui-combobox" data-options="editable:true" style="width:200px;">
		                    <option value="" selected="selected">全部状态</option>
		                    <option value="1">启用</option>
		                    <option value="0">禁用</option>
		                </select>
		            </div>                    
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                       onclick="doSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                       onclick="doReset()">重置</a>
                </form>
            </div>
             <div class="optionBar">
	    		<@sec.authorize access="hasAuthority('sys:dict:add')">
	        	<a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newParentDict()">新增</a>
	        	</@sec.authorize>
	    		<@sec.authorize access="hasAuthority('sys:dict:edit')">
	        	<a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editParentDict()">修改</a>
	        	</@sec.authorize>
	    		<@sec.authorize access="hasAuthority('sys:dict:delete')"> 
	        	<a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delDict()">删除</a>
	        	</@sec.authorize>	
	        </div>
        </div>
        <!-- datagride -->
        <table id="dg1" class="easyui-datagrid" title="字典管理" style="width:100%px;height:auto"
               url="${request.contextPath}/sys/dict/list?pid=''" toolbar="#toolbar1"
               data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				fit:true,
				pagination:true,
				pageSize:10,
                pageList:[10,50,100]">
            <thead>
            <tr>
                <th field="type" width="40%">字典类型</th>
                <th field="value" width="40%">字典名称</th>
                <th field="enable" width="20%" align="center" formatter="Ams.formatEnable">状态</th>
            </tr>
            </thead>
        </table>
    </div>
    <div region="center">
        <div id="toolbar2">
            <!-- option button -->
            <div id="searchBar2" class="searchBar">
                <form id="searchForm2">
                	<div class="inline-block">
						<label class="textbox-label textbox-label-before" title="字典键值">字典键值:</label>
	                	<input id="queryChildType" name="queryChildType" class="easyui-textbox" style="width:180px;">
	                </div>
                	<div class="inline-block">
						<label class="textbox-label textbox-label-before" title="字典标签">字典标签:</label>
	                	<input id="queryChildValue" name="queryChildValue" class="easyui-textbox" style="width:180px;">
	                </div>
                    <div class="inline-block">
						<label class="textbox-label textbox-label-before" title="状态">状态:</label>
		                <select name="queryChildEnable" id="queryChildEnable" class="easyui-combobox" data-options="editable:true" style="width:180px;">
		                    <option value="" selected="selected">全部状态</option>
		                    <option value="1">启用</option>
		                    <option value="0">禁用</option>
		                </select>
		            </div>                     
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                       onclick="doChildSearch()">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                       onclick="doChildReset()">重置</a>
                </form>
            </div>
            <div class="optionBar">
		    	<@sec.authorize access="hasAuthority('sys:dict:add')"> 
		        <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newChildDict()">新增</a>
		        </@sec.authorize>
		    	<@sec.authorize access="hasAuthority('sys:dict:edit')"> 
		        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editChildDict()">修改</a>
		    	</@sec.authorize>
		    	<@sec.authorize access="hasAuthority('sys:dict:delete')"> 
		        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delChildDict()">删除</a>
		    	</@sec.authorize>
        	</div>
        </div>
        <!-- datagrid -->
        <table id="dg2" class="easyui-datagrid" title="字典数据" style="width:100%px;" toolbar="#toolbar2"
               data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				fit:true,
				pagination:true,
				pageSize:10,
                pageList:[10,50,100]">
            <thead>
            <tr>
                <th field="type" width="30%">字典键值</th>
                <th field="value" width="30%">字典标签</th>
                <th field="num" width="20%" align="center">排序</th>
                <th field="enable" width="20%" align="center" formatter="Ams.formatEnable">状态</th>
            </tr>
            </thead>
        </table>

        <!-- dialog1 -->
        <div id="dlg1" class="easyui-dialog" style="width: 400px"
             data-options="closed:true,modal:true,border:'thin',buttons:'#dlg1-buttons'">
            <form id="fm" method="post" novalidate style="margin: 0; padding: 20px 50px">
                <input name="uuid" hidden="true"/>
                <div style="margin-bottom:10px">
                    <input name="type" class="easyui-textbox" required="true" label="字典类型:" style="width: 100%">
                </div>
                <div style="margin-bottom:10px">
                    <input name="value" class="easyui-textbox" required="true" label="字典名称:" style="width: 100%">
                </div>
                <div style="margin-bottom:10px">
                    <select name="enable" class="easyui-combobox" data-options="required:true" label="是否启用:"
                            style="width: 100%">
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <div style="margin-bottom:10px">
                    <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                           style="width: 100%; height: 120px">
                </div>
            </form>
        </div>
        <div id="dlg1-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveDict()"
               style="width: 90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
               onclick="$('#dlg1').dialog('close')" style="width: 90px">取消</a>
        </div>
        <!-- dialog3 -->
        <div id="dlg3" class="easyui-dialog" style="width: 400px"
             data-options="closed:true,modal:true,border:'thin',buttons:'#dlg3-buttons'">
            <form id="fm" method="post" novalidate style="margin: 0; padding: 20px 20px">
                <input name="uuid" hidden="true"/>
                <input id="pid" name="pid" hidden="true"/>
                <div style="margin-bottom: 10px">
                    <input id="pname" name="pname" class="easyui-textbox" required="true" label="字典类型:"
                           style="width: 100%" readonly="readonly">
                </div>
                <div style="margin-bottom: 10px">
                    <input name="type" class="easyui-textbox" required="true" label="字典键值:" style="width: 100%">
                </div>
                <div style="margin-bottom: 10px">
                    <input name="value" class="easyui-textbox" required="true" label="字典标签:" style="width: 100%">
                </div>
                <div style="margin-bottom: 10px">
                    <input id="num" name="num" class="easyui-numberspinner" data-options="min:1,max:100,increment:1"
                           label="排序:" style="width: 100%"/>
                </div>
                <div style="margin-bottom: 10px">
                    <select name="enable" class="easyui-combobox" data-options="required:true" label="是否启用:"
                            style="width: 100%">
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <div style="margin-bottom: 10px">
                    <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                           style="width: 100%; height: 120px">
                </div>
            </form>
        </div>
        <div id="dlg3-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveChildDict()"
               style="width: 90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
               onclick="$('#dlg3').dialog('close')" style="width: 90px">取消</a>
        </div>
    </div>
</div>
<script>
    $("#dg1").datagrid({
        onClickRow: function (rowIndex, rowData) {
            $('#dg2').datagrid("options").url = Ams.ctxPath + '/sys/dict/clildlist';
            $('#dg2').datagrid("options").queryParams = {pid: rowData.uuid};
            $('#dg2').datagrid('load');
        }
    });

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };

    function newParentDict() {
        $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '新增字典');
        $('#parent').combotree({disabled: false});
        $('#dlg1 #fm').form('clear');
        url = Ams.ctxPath + '/sys/dict/saveDict';
    }

    function newChildDict() {
        var row = $('#dg1').datagrid('getSelected');
        if (row) {
            $('#dlg3').dialog('open').dialog('center').dialog('setTitle', '新增字典数据');
            $('#parent').combotree({disabled: false});
            $('#dlg3 #fm').form('clear');
            $('#pname').textbox('setValue', row.type);
            $('#pid').val(row.uuid);
            url = Ams.ctxPath + '/sys/dict/saveChildDict';
        } else {
            $.messager.alert('提示', '请选择一条字典记录！');
        }
    }

    function editParentDict() {
        $('#dlg1 #fm').form('clear');
        var row = $('#dg1').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/dict/getDict',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg1').dialog('open').dialog('center').dialog('setTitle', '修改字典');
                    if (row.parentId == '') {
                        $('#parent').combotree({disabled: true});
                    }
                    else {
                        $('#parent').combotree({disabled: false});
                    }
                    $('#dlg1 #fm').form('load', result);
                    url = Ams.ctxPath + '/sys/dict/saveDict';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function editChildDict() {
        $('#dlg3 #fm').form('clear');
        var row = $('#dg2').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/sys/dict/getDict',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg3').dialog('open').dialog('center').dialog('setTitle', '修改字典数据');
                    if (row.parentId == '') {
                        $('#parent').combotree({disabled: true});
                    }
                    else {
                        $('#parent').combotree({disabled: false});
                    }
                    $('#dlg3 #fm').form('load', result);
                    url = Ams.ctxPath + '/sys/dict/saveChildDict';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function delDict() {
        var row = $('#dg1').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/dict/delDict',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg1').datagrid('load'); // reload the data
                                $('#dg2').datagrid('load');
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

    function delChildDict() {
        var row = $('#dg2').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/sys/dict/delDict',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            var result = eval(result);
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                $('#dg2').datagrid('load'); // reload the data
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

    function saveDict() {
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
                    $('#dg1').datagrid('load'); // reload the data
                }
            }
        });
    }

    function saveChildDict() {
        $('#dlg3 #fm').form('submit', {
            url: url,
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg3').dialog('close'); // close the dialog
                    $('#dg2').datagrid('load'); // reload the data
                }
            }
        });
    }

    function doSearch() {
        $('#dg1').datagrid('load', {
            type: $("#queryType").val(),
            value: $("#queryValue").val(),
            enable: $("#queryEnable").val()
        });
    }

    function doChildSearch() {
        var row = $('#dg1').datagrid('getSelected');
        if (row) {
            $('#dg2').datagrid('load', {
                pid: row.uuid,
                type: $("#queryChildType").val(),
                value: $("#queryChildValue").val(),
                num: $("#queryChildNum").val(),
                enable: $("#queryChildEnable").val()
            });
        } else {
            $.messager.alert('提示', '请选择一条要查询的字典记录！');
        }
    }

    function doReset() {
        $("#searchBar1").find("#searchForm1").form('clear');
        doSearch();
    }

    function doChildReset() {
        $("#searchBar2").find("#searchForm2").form('clear');
        doChildSearch();
    }
</script>
</body>
</html>