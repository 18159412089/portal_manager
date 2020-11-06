<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/> 
<html lang="en">
<head>
    <title>菜单管理</title>
	<#include "/header.ftl"/>
	<link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/demo.css">
    <link rel="stylesheet" href="${request.contextPath}/static/plugin/jquery-easyui/themes/fonts/iconfont.css">
</head>
<body>
<div class="easyui-layout" fit=true>
<#include "/common/loadingDiv.ftl"/>
    <div id="toolbar">
    	<@sec.authorize access="hasAuthority('sys:menu:add')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-sky-blue" data-options="iconCls:'icon-add'" onclick="newMenu()">新增</a>
        </@sec.authorize>
        <@sec.authorize access="hasAuthority('sys:menu:edit')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-edit'" onclick="editMenu()">修改</a>
        </@sec.authorize>
        <@sec.authorize access="hasAuthority('sys:menu:delete')">
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delMenu()">删除</a>
        </@sec.authorize>
    </div>
    <table id="tg" class="easyui-treegrid" style="width:100%;"
           url="${request.contextPath}/sys/menu/getMenuTree"
           idField="id" treeField="name" toolbar="#toolbar" fit=true>
        <thead>
        <tr>
            <th field="name" width="30%">菜单名称</th>
            <th field="icon" width="10%" formatter="iconSpanFormat" align="center">图标</th>
            <th field="url" width="13%">url</th>
            <th field="type" width="5%" formatter="Ams.formatMenuType" align="center">类型</th>
            <th field="permission" width="12%" align="center">权限标识</th>
            <th field="num" width="10%" align="center">排序</th>
            <th field="remark" width="20%" formatter="Ams.tooltipFormat">备注</th>
        </tr>
        </thead>
    </table>
    <!-- 菜单的对话框 -->
    <div id="menuDlg" class="easyui-dialog" style="width:420px"
         data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
        <form id="menuFm" method="post" novalidate style="margin:0;padding:10px 5px">
            <input name="uuid" hidden="true"/>
            <input name="pid" hidden="true"/>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="菜单名称">菜单名称:</label>
                <input name="name" class="easyui-textbox" required="true" style="width:200px">
            </div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="父菜单">父菜单:</label>
                <input id="parent" name="parent" class="easyui-combotree" data-options="url:'${request.contextPath}/sys/menu/getMenuTree?enable=2',
            required:true,method:'get',labelPosition:'left',valueField:'id',textField:'text',multiple:false"
                       style="width:100%">
            </div>
            <div style="margin-bottom: 10px">
				<label class="textbox-label textbox-label-before" title="菜单类型">菜单类型:</label>
				<select id="type" name="type" class="easyui-combobox" data-options="required:true,panelHeight:'auto'"
                         style="width:200px">
                     <option value="1">菜单</option>
                     <option value="0">权限</option>
                 </select>
			</div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="图标">图标:</label>
                <input name="icon" id="icon" class="easyui-textbox" style="width:200px">
            </div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="请求地址">请求地址:</label>
                <input name="url" class="easyui-textbox" style="width:200px">
            </div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="权限标识">权限标识:</label>
                <input name="permission" class="easyui-textbox" data-options="prompt:'sys:dept:add,sys:dept:edit'" style="width:200px">
            </div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="排序">排序:</label>
                <input id="num" name="num" class="easyui-numberspinner" data-options="min:1,max:100,increment:1"
                       required="true" style="width:200px"/>
            </div>
            <div style="margin-bottom:10px">
            	<label class="textbox-label textbox-label-before" title="备注">备注:</label>
                <input name="remark" class="easyui-textbox" multiline="true"
                       style="width:200px;height:120px">
            </div>
        </form>
    </div>
    <div id="menuDlg-buttons" style="padding-right: 42px;">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveMenu()"
           style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#menuDlg').dialog('close')" style="width:90px;">取消</a>
    </div>
    <!-- 菜单图标库的对话框 -->
     <div id="iconDlg" class="easyui-dialog" style="width:80%;height:80%;"
         data-options="closed:true,modal:true,border:'thin'">
         <#include "icon.ftl"/>
    </div>
    <script>
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };
        $(function(){
            $("input",$("#icon").next("span")).click(function(){
            	$('#iconDlg').dialog('open').dialog('center').dialog('setTitle', '请选择图标');
            }); 
            $("#icons li").click(function(){
 	    		$("#icon").textbox('setValue',$(this).find('.code').text());
 	    		$("#iconDlg").dialog('close');
 	    	}); 
        })
       
        
        function iconFormat(value, row, index) {
            return typeof row.icon !== "undefined" ? '<label class="icon ' + row.icon + '" >&nbsp;&nbsp;&nbsp;&nbsp;</label>' :
                    '<label class="icon" ></label>';
        }

        function iconSpanFormat(value, row, index) {
            return typeof row.icon == "undefined" ||row.icon == ""  ? '' :'<span class="iconfont" >'+row.icon+'</span>';
        }
        
        function newMenu() {
            $('#menuDlg').dialog('open').dialog('center').dialog('setTitle', '新增菜单');
            $('#parent').combotree({disabled: false});
            $('#menuFm').form('clear');
            url = Ams.ctxPath + '/sys/menu/saveMenu';
        }

        function editMenu() {
            $('#menuFm').form('clear');
            var node = $('#tg').treegrid('getSelected');
            if (node) {
            	if('0'==node.id){
            		$.messager.alert('提示', '顶级菜单不允许修改！');
            		return;
            	}
                $.ajax({
                    type: 'POST',
                    url: Ams.ctxPath + '/sys/menu/getMenu',
                    data: {'uuid': node.id},
                    success: function (result) {
                        $('#menuDlg').dialog('open').dialog('center').dialog('setTitle', '修改菜单');
                        if (node.parentId == '') {
                            $('#parent').combotree({disabled: true});
                        } else {
                            $('#parent').combotree({disabled: false});
                        }
                        console.log(result);
                        $('#menuFm').form('load', result);
                        url = Ams.ctxPath + '/sys/menu/saveMenu';
                    },
                    dataType: 'json'
                });
            } else {
                $.messager.alert('提示', '请选择一条要编辑的记录！');
            }
        }

        function delMenu() {
            var node = $('#tg').treegrid('getSelected');
            if (node) {
            	if('0'==node.id){
            		$.messager.alert('提示', '顶级菜单不允许删除！');
            		return;
            	}
                $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                    if (r) {
                        $.ajax({
                            type: 'POST',
                            url: Ams.ctxPath + '/sys/menu/delMenu',
                            data: {'uuid': node.id},
                            success: function (result) {
                                var result = eval(result);
                                if (result.type == 'E') {
                                    Ams.error(result.message);
                                } else {
                                    $('#tg').treegrid('reload');
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

        function saveMenu() {
            /*$('#menuFm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    var result = JSON.parse(result);
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#menuDlg').dialog('close');
                        $('#tg').treegrid('reload');
                    }
                }
            });*/

            if(!$('#menuFm').form('validate')){
                return;
            }
            $.ajax({
                type: "POST",
                dataType: "json",
                url: url,
                data: $('#menuFm').serialize(),
                success: function (result) {
                    if (result.type == 'E') {
                        Ams.error(result.message);
                    } else {
                        $('#menuDlg').dialog('close');
                        $('#tg').treegrid('reload');
                    }
                }
            });
        }
    </script>
</body>
</html>