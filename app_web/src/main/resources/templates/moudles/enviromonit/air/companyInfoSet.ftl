<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>企业信息配置</title>
</head>
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<!-- datagrid -->
<div class="easyui-layout" fit=true >

    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">工地名称:</label>
                <input id="queryProjectName" name="name" style="width:280px;" value="${name!}"/>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newActach()" >新增</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editActach()">修改</a>
        <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'"
           onclick="deleteActach()">删除</a>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:90%;" toolbar="#toolbar"
           data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            pagination:true,
            pageSize:20,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="pkid" hidden></th>
            <th field="area" width="120px" formatter="Ams.tooltipFormat">所属区域</th>
            <th field="name" width="120px" formatter="Ams.tooltipFormat">工地名称</th>
            <th field="builtValue" width="120px" formatter="Ams.tooltipFormat">工地面积</th>
            <th field="address" width="120px" formatter="Ams.tooltipFormat">工地地址</th>
            <th field="longitude" width="120px" formatter="Ams.tooltipFormat">经度</th>
            <th field="latitude" width="120px">纬度</th>
            <th field="manageOrganization" width="120px">管理单位</th>
            <th field="managerPeoper" width="120px" formatter="Ams.tooltipFormat">管理单位联系人</th>
            <th field="manaerPhone" width="120px" formatter="Ams.tooltipFormat">管理单位联系电话</th>
            <th field="responOrganization" width="100px" formatter="Ams.tooltipFormat">责任单位</th>
            <th field="responPeopor" width="120px" formatter="Ams.tooltipFormat">责任单位联系人</th>
            <th field="responPhone" width="120px" formatter="Ams.tooltipFormat">责任单位联系电话</th>
            <th field="status" width="100px" formatter="Ams.tooltipFormat">自查自纠情况</th>
            <th field="remark" width="100px" formatter="Ams.tooltipFormat">备注</th>
            <th field="scale" width="100px" formatter="Ams.tooltipFormat">工地规模类型</th>
            <th field="unit" width="100px" formatter="Ams.tooltipFormat">单位</th>
            <th field="operate" width="8%" formatter ="toFilePage">图片视频上传</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="pkid" name="pkid" hidden="true"/>
        <div style="margin-bottom:10px">
            <input id="projId" name="area" data-options="validType:'maxLength[250]'" class="easyui-textbox" style="width:200px;" label="所属区域:" />
        </div>
        <div style="margin-bottom:10px">
            <input name="name" id="name" data-options="validType:'maxLength[250]'" class="easyui-textbox" label="工地名称:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="builtValue" data-options="validType:'maxLength[64]'" id="builtValue" class="easyui-textbox" label="工地面积:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="address" id="address" data-options="validType:'maxLength[250]'" class="easyui-textbox" label="工地地址:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="longitude" id="longitude" data-options="validType:'number'" class="easyui-textbox" label="经度:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="latitude" id="latitude" data-options="validType:'number'" class="easyui-textbox" label="纬度:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="manageOrganization" data-options="validType:'maxLength[250]'" id="manageOrganization" class="easyui-textbox" label="管理单位:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="managerPeoper" id="managerPeoper" data-options="validType:'maxLength[64]'" class="easyui-textbox" label="管理单位联系人:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="manaerPhone" id="manaerPhone" data-options="validType:'maxLength[64]'" class="easyui-textbox" label="管理单位联系电话:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="responOrganization" id="responOrganization" data-options="validType:'maxLength[250]'" class="easyui-textbox" label="责任单位:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="responPeopor" id="responPeopor" data-options="validType:'maxLength[64]'" class="easyui-textbox" label="责任单位联系人:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="responPhone" id="responPhone" data-options="validType:'maxLength[64]'" class="easyui-textbox" label="责任单位联系电话:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="status" id="status" data-options="validType:'maxLength[4000]'" class="easyui-textbox" label="自查自纠情况:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="remark" id="remark" class="easyui-textbox" data-options="validType:'maxLength[4000]'" label="备注:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="scale" id="scale" class="easyui-textbox" data-options="validType:'maxLength[64]'" label="工地规模类型:"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input name="unit" id="unit" class="easyui-textbox" data-options="validType:'maxLength[64]'" label="单位:"
                   style="width:100%">
        </div>

    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveActach()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<!--  视频弹窗 -->
<div id="videoDlg" class="easyui-dialog" style="width:800px;height:500px;"
     data-options="closed:true,modal:true,border:'thin',buttons:'#videoDlg-buttons'">
    <video id="video" style="withd:auto;height:99%;" controls="controls" preload>您的浏览器不支持 video 标签。</video>
</div>
<input type="hidden" id="authority" value="${authority!}">
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
     Ams.inputText_enterKeyEvent("queryProjectName", doSearch);

    $(function () {
        doSearch();
    });


    /**
     * 跳转到视频图片上传界面
     */
    function toFilePage(value,row){
        return "<div>" + Ams.setImageSee() + "<a href= '/enviromonit/airConstructionSite/fileAttachment?pid=" + $("#pid").val() + "&name=" + row.name + "' target='_blank' ass='easyui-linkbutton'>图片视频管理</a></div>";
    }

    /**
     * 新增
     * @type {string}
     */
    var url = '';

    function newActach() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增企业信息');
        url = Ams.ctxPath + '/enviromonit/airConstructionSite/saveCompanyInfo';
    }

    /**
     * 编辑
     * @type {string}
     */
    function editActach() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改企业信息');
            $('#fm').form('load', row);
            url = Ams.ctxPath + '/enviromonit/airConstructionSite/saveCompanyInfo';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    /**
     * 删除
     * @type {string}
     */
    function deleteActach() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    var loadIndex = '';
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/enviromonit/airConstructionSite/deleteCompanyInfo',
                        data: {
                            'pkid': row.pkid
                        },
                        beforeSend: function () {
                            loadIndex = layer.load(1, {
                                shade: [0.1, '#fff']
                            });
                        },
                        complete: function () {
                            layer.close(loadIndex);
                        },
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                                Ams.success('操作成功');
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

    /**
     * 保存
     * @type {string}
     */
    function saveActach() {
        $.messager.progress({title: '提示', msg: '附件保存中......', text: ''});
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
                $.messager.progress('close');
            }
        });
    }

    /**
     * 查询
     * @type {string}
     */
    function doSearch() {
        $('#dg').datagrid({
            url: "/enviromonit/airConstructionSite/list",
            queryParams: {
                name: $("#queryProjectName").val()
            }
        })
    }


    /**
     * 重置
     * @type {string}
     */
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>