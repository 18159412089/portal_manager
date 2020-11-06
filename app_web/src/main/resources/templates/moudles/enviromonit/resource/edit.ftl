<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>资源目录管理</title>
	<#include "/header.ftl"/>
</head>
<body>
<div class="easyui-layout" fit=true>
<#include "/common/loadingDiv.ftl"/>
    <div class="optionBar">
        <div id="toolbar">
            <div class="optionBar">
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newMenu()">新增</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editMenu()">修改</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-remove'" onclick="delMenu()">删除</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportMenu()">导出</a>
            </div>
        </div>
    </div>

    <table id="tg" class="easyui-treegrid" style="width:100%;"
           url="${request.contextPath}/env/resource/getMenuTree"
           idField="id" treeField="name" toolbar="#toolbar" fit=true>
        <thead>
        <tr>
            <th field="name" width="30%">资源目录名称</th>
            <th field="icon" width="10%" formatter="iconFormat" align="center">图标</th>
            <th field="url" width="20%">url</th>
            <th field="num" width="10%" align="center">排序</th>
            <th field="remark" width="30%" formatter="Ams.tooltipFormat">备注</th>
        </tr>
        </thead>
    </table>
    <!-- 资源目录的对话框 -->
    <div id="menuDlg" class="easyui-dialog" style="width:400px"
         data-options="closed:true,modal:true,border:'thin',buttons:'#menuDlg-buttons'">
        <form id="menuFm" method="post" novalidate style="margin:0;padding:20px 50px">
            <input name="uuid" hidden="true"/>
            <input name="pid" hidden="true"/>
            <div style="margin-bottom:10px">
                <input name="name" class="easyui-textbox" required="true" label="资源目录名称:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input id="parent" name="parent" class="easyui-combotree" data-options="url:'/env/resource/getMenuTree?enable=2',
            required:true,method:'get',label:'父资源目录:',labelPosition:'left',valueField:'id',textField:'text',multiple:false"
                       style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="icon" class="easyui-textbox" label="图标:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="url" class="easyui-textbox" required="true" label="请求地址:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input id="num" name="num" class="easyui-numberspinner" data-options="min:1,max:100,increment:1"
                       label="排序:"
                       style="width:100%"/>
            </div>
            <div style="margin-bottom:10px">
                <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                       style="width:100%;height:120px">
            </div>
        </form>
    </div>
    <div id="menuDlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveMenu()"
           style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
           onclick="javascript:$('#menuDlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script>
        $.parser.onComplete = function () {
            $("#loadingDiv").fadeOut("normal", function () {
                $(this).remove();
            });
        };

        function iconFormat(value, row, index) {
            return typeof row.icon !== "undefined" ? '<label class="icon ' + row.icon + '" >&nbsp;&nbsp;&nbsp;&nbsp;</label>' :
                    '<label class="icon" ></label>';
        }

        function newMenu() {
            $('#menuDlg').dialog('open').dialog('center').dialog('setTitle', '新增资源目录');
            $('#parent').combotree({disabled: false});
            $('#menuFm').form('clear');
            url = Ams.ctxPath + '/env/resource/saveMenu';
        }

        function editMenu() {
            $('#menuFm').form('clear');
            var node = $('#tg').treegrid('getSelected');
            if (node) {
                if('0'==node.id){
                    $.messager.alert('提示', '顶级资源目录不允许修改！');
                    return;
                }
                $.ajax({
                    type: 'POST',
                    url: Ams.ctxPath + '/env/resource/getMenu',
                    data: {'uuid': node.id},
                    success: function (result) {
                        $('#menuDlg').dialog('open').dialog('center').dialog('setTitle', '修改资源目录');
                        if (node.parentId == '') {
                            $('#parent').combotree({disabled: true});
                        } else {
                            $('#parent').combotree({disabled: false});
                        }
                        $('#menuFm').form('load', result);
                        url = Ams.ctxPath + '/env/resource/saveMenu';
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
                    $.messager.alert('提示', '顶级资源目录不允许删除！');
                    return;
                }
                $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                    if (r) {
                        $.ajax({
                            type: 'POST',
                            url: Ams.ctxPath + '/env/resource/delMenu',
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
            $('#menuFm').form('submit', {
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
            });
        }

        function exportMenu() {
            window.open(Ams.ctxPath + '/env/resource/getListExport');
        }
    </script>
</body>
</html>