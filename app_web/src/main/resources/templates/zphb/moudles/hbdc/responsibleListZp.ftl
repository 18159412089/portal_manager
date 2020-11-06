<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>责任名单</title>
</head>
<body style="overflow: auto;">
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/passwordModify.ftl">
<#if authority??>
    <#include "/supervisionMenu.ftl">
<#else>
    <#include "/inputSupervisionMenu.ftl">
</#if>
<!-- datagrid -->
<div class="easyui-layout" fit=true style="padding-left:10px;padding-right:10px;">
    <div id="toolbar">
        <div style="padding:3px;" id="searchBar" hidden>
            <form id="searchForm" >
                <label class="control-label">文件名称:</label>
                <input id="queryName" name="queryName" class="easyui-textbox"  style="width:200px;">
                <a href="#" type="submit" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'" onclick="doReset()">重置</a>
            </form>
        </div>
        <form id="uplodFile" method="post" enctype="multipart/form-data">
            <a href="#" name="xlsxfile" id="importFile" class="easyui-filebox"
               data-options="accept:'application/vnd.ms-excel'"></a>
            <a href="#" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="downloadFile()">责任名单模板</a>
        </form>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           url="${request.contextPath}/environment/rectifition/getEnvironmentRecitifitionList" data-options="
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
            <th field="uuid" hidden />
            <th field="projectName" width="9%" formatter="formatOperate">项目</th>
            <th field="dutyPerson" width="9%" formatter="Ams.tooltipFormat">责任人</th>
            <th field="dutyPersonPhone" width="9%" formatter="Ams.tooltipFormat">责任人电话</th>
            <th field="dutyDepartment" width="9%" formatter="Ams.tooltipFormat">责任部门</th>
            <th field="dutyUnit" width="9%" formatter="Ams.tooltipFormat">责任单位</th>
            <th field="involvePerson" width="9%" formatter="Ams.tooltipFormat">涉及人员</th>
            <th field="involveDepartment" width="9%" formatter="Ams.tooltipFormat">涉及部门</th>
            <th field="leadPerson" width="9%" formatter="Ams.tooltipFormat">牵头人</th>
            <th field="leadUnit" width="9%" align="left" >牵头单位</th>
            <th field="matchUnit" width="9%" >配合单位</th>
            <th field="format" width="9%" align="left" formatter="formatView">操作</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->

<!-- 设置项目弹窗 -->
<div id="dlg-status" class="easyui-dialog" style="withd:600px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-status-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input name="uuid"  hidden="true"/>
        <input name="dutyPerson"  hidden="true"/>
        <input name="dutyDepartment"  hidden="true"/>
        <input name="involveDepartment"  hidden="true"/>
        <input name="dutyUnit"  hidden="true"/>
        <input name="involvePerson"  hidden="true"/>
        <input name="leadPerson"  hidden="true"/>
        <input name="leadUnit"  hidden="true"/>
        <input name="matchUnit"  hidden="true"/>
        <input name="dutyPersonPhone"  hidden="true"/>
        <div style="margin-bottom:10px">
            <input id="projectId" name="projectId" class="easyui-combobox" style="width:100%" label="项目:" data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION',
            	valueField:'id',
            	textField:'name'">
            </input>
        </div>
    </form>
</div>
<div id="dlg-status-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveStatus()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg-status').dialog('close')" style="width:90px">取消</a>
</div>

<div id="dlg_one" class="easyui-dialog" style="width:600px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons_one'">
    <form id="fm_one" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input type="hidden" name="uuid" id="uuid">

        <div style="margin-bottom:10px">
            <input id="project" name="projectId" required="true" class="easyui-combobox" style="width:100%" label="项目：" data-options="
            	required:true,
            	url:'${request.contextPath}/environment/commonRelationTable/listNotPage?code=ENVIRONMEENT_RECTIFITION_01&relation=ENVIRONMEENT_RECTIFITION',
            	valueField:'id',
            	textField:'name'">
            </input>
        </div>
        <div style="margin-bottom:10px">
            <input name="dutyPerson" class="easyui-textbox" data-options="required:true,label:'责任人:',validType:'maxLength[16]'" style="width: 200px;">
        </div>
        <div style="margin-bottom:10px">
            <input name="dutyPersonPhone" class="easyui-textbox" data-options="required:true,label:'负责人电话:',validType:'mobileAndTel'" style="width: 200px;">
        </div>
        <div style="margin-bottom:10px">
            <input name="dutyDepartment" class="easyui-textbox" data-options="required:true,label:'责任部门:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="dutyUnit" class="easyui-textbox" data-options="required:true,label:'责任单位:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="involveDepartment" class="easyui-textbox" data-options="required:true,label:'涉及部门:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="involvePerson" class="easyui-textbox" data-options="required:true,label:'涉及人员:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="leadPerson" class="easyui-textbox" data-options="required:true,label:'牵头人:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="leadUnit" class="easyui-textbox" data-options="required:true,label:'牵头单位:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
        <div style="margin-bottom:10px">
            <input name="matchUnit" class="easyui-textbox" data-options="required:true,label:'配合单位:',validType:'maxLength[16]'"  style="width: 200px; ">
        </div>
    </form>
</div>

<div id="dlg-buttons_one">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg_one').dialog('close')" style="width:90px">取消</a>
</div>
</body>
</html>


<script>

    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    /**
     * 设置项目
     * @param value
     * @param row
     * @param index
     * @returns {*}
     */
    function formatOperate(value,row,index){
        if (Ams.isNoEmpty(value)){
            return value;
        }else{
            return "<div>"+Ams.setImageSet()+"<a href='#' class='easyui-linkbutton' onClick=\"ChangeStatus('"+index+"')\">设置项目</a>";
        }
    }

    /**
     * 操作栏
     * @param value
     * @param row
     * @param index
     * @returns {*}
     */
    function formatView(value,row,index){
        return "<div>"+Ams.setImageEdit()+"<a href='#' class='easyui-linkbutton' onclick='edit("+index+")'>编辑</a>"
                +"&emsp;"+Ams.setImageDelete()+"<a href='#' class='easyui-linkbutton' onclick='del("+index+")'>删除</a></div> ";
    }
    /**
     * 长度验证
     */
    $.extend($.fn.validatebox.defaults.rules, {
        maxLength: {
            validator: function (value, param) {
                return value.length <= param[0]&&value.trim().length > 0;
            },
            message: '请输入有效字符串，长度不能超过{0}个字符.'
        }
    });

    /**
     * 编辑保存
     */
    function save(){
        $('#dlg_one #fm_one').form('submit', {
            url:  Ams.ctxPath + '/environment/rectifition/saveDutyUser',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg_one').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success(result.message);
                }
            }
        });
    }

    /**
     * 点击设置项目弹窗
     */
    function ChangeStatus(index) {
        $('#dg').datagrid('selectRow',index);// 关键在这里
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $('#fm').form('clear');
            $('#fm').form('load', row);
            $('#dlg-status').dialog('open').dialog('center').dialog('setTitle', '设置项目');
        }

    }

    /**
     * 点击编辑弹窗
     */
    function edit(index) {
        $('#dg').datagrid('selectRow',index);// 关键在这里
        var row = $('#dg').datagrid('getSelected');
        if (row){
            $('#dlg_one').dialog('open').dialog('center').dialog('setTitle', '修改信息');
            $('#fm_one').form('clear');
            $('#fm_one').form('load', row);
        }

    }

    /**
     * 设置项目保存
     */
    function saveStatus() {
        $('#dlg-status #fm').form('submit', {
            url: Ams.ctxPath + '/environment/rectifition/saveDutyUser',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                var result = JSON.parse(result);
                if (result.type == 'E') {
                    Ams.error(result.message);
                } else {
                    $('#dlg-status').dialog('close');
                    $('#dg').datagrid('load');
                    Ams.success('操作成功！');
                }
            }
        });
    }



    /**
     * 导入模板下载
     */
    function downloadFile(){
        var $eleForm = $("<form method='get'></form>");
        $eleForm.attr("action",Ams.ctxPath+"/static/js/moudles/enviromonit/water/责任名单模板.xls");
        $(document.body).append($eleForm);
        //提交表单，实现下载
        $eleForm.submit();
    }

    /**
     * 导入责任名单
     */
    $('#importFile').filebox({
        buttonText: 'Excel导入',
        buttonAlign: 'center',
        buttonIcon: 'icon-redo',
        clear:true ,
        onChange: function (newVal, oldVal) {
            var suffix = newVal.substring(newVal.lastIndexOf('.') + 1, newVal.length);
            if (suffix != 'xls' && suffix != 'xlsx') {
                Ams.error('只能导入后缀为xls或xlsx的文件');
                return;
            }
            $.messager.confirm("提示信息", "确认导入文件：<br/>" + newVal + "？", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '文件导入中......', text: ''});
                    $('#uplodFile').form('submit', {
                        url: Ams.ctxPath + "/environment/rectifition/importFile",
                        onSubmit: function () {
                            return $(this).form('validate');
                        },
                        success: function (result) {
                            $("#filebox_file_id_2").val('');
                            var result = JSON.parse(result);
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                                Ams.success(result.message);
                            }
                        }
                    });
                } else {
                    $("#filebox_file_id_2").val('');
                }
            });
        }
    });
    /**
     * 删除
     */
    function del(index) {
        $('#dg').datagrid('selectRow',index);// 关键在这里
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/rectifition/deleteDutyUser',
                        data: {'uuid': row.uuid},
                        success: function (result) {
                            $.messager.progress('close');
                            if (result.type == 'E') {
                                Ams.error(result.message);
                            } else {
                                doSearch();
                                Ams.success('操作成功！');
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
        $('#dg').datagrid('load');
    }
    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }

</script>
