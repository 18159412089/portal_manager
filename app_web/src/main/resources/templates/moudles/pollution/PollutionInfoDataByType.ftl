<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>污染源信息配置</title>
</head>
<body>
<#include "/common/loadingDiv.ftl"/>
<#include "/decorators/header.ftl"/>
<#include "/secondToolbar.ftl">
<#include "/passwordModify.ftl">
<!-- datagrid -->
<input type="hidden" id="pageType" value="${type}">
<div class="easyui-layout" fit=true >

    <div id="toolbar">
        <div style="padding:3px;" id="searchBar">
            <form id="searchForm">
                <label class="control-label">名称:</label>
                <input id="queryProjectName" name="mc" style="width:280px;" value="${name!}"/>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'"
                   onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <form id="uplodFile" method="post" enctype="multipart/form-data">
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-add'" onclick="newInfo()" >新增</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editInfo()">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'"
                onclick="deleteInfo()">删除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-save'" onclick="downloadFile()">导入模板下载</a>
            <a href="javascript:void(0)" name="xlsxfile" id="importFile" class="easyui-filebox btn-purple" data-options="accept:'application/vnd.ms-excel'"></a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-orange" data-options="iconCls:'icon-redo'" onclick="exportData()">导出</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="setPhone()" >编辑联系方式</a>
        </form>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:90%;" toolbar="#toolbar"
           data-options="
            rownumbers:true,
            singleSelect:true,
            striped:false,
            autoRowHeight:true,
            fitColumns:true,
            fit:false,
            pagination:true,
            pageSize:10,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="qx" >区县</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="wrylx" >污染源类型</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="wryzl" >污染源种类</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="mc" >名称</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="czwt" >存在问题</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="zgcs" >整改措施</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="zlxm" >治理项目</th>
            <th colspan="3" align="center" >完成目标</th>
            <th colspan="2" align="center" >属地责任</th>
            <th colspan="4" align="center" >部门责任</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="xz" >乡镇</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="dz" >地址</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="jd" >经度</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="wd" >纬度</th>
            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="bz" >备注</th>
<#--            <th width="60" rowspan="2" formatter="Ams.tooltipFormat" field="entryDepartment" >录入部门</th>-->
<#--            <th width="60" rowspan="2" formatter="formataudit" field="auditState" >数据审核状态</th>-->
<#--            <th width="60" rowspan="2" formatter="formatSatate" field="dataState" >数据有效状态</th>-->
        </tr>
        <tr>
            <th width="60" formatter="Ams.tooltipFormat" field="wcmb201912" >2019年12月底</th>
            <th width="60" formatter="Ams.tooltipFormat" field="wcmb202006" >2020年6月底</th>
            <th width="60" formatter="Ams.tooltipFormat" field="wcmb202012" >2020年12月底</th>
            <th width="60" formatter="Ams.tooltipFormat" field="sdzrZrdw" >责任单位</th>
            <th width="60" formatter="Ams.tooltipFormat" field="sdzrdwZrrlxfs" >责任人及联系方式</th>
            <th width="60" formatter="Ams.tooltipFormat" field="bmzrZrdw" >责任单位</th>
            <th width="60" formatter="Ams.tooltipFormat" field="bmzrdwZrrlxfs" >责任人及联系方式</th>
            <th width="60" formatter="Ams.tooltipFormat" field="bmzrPhzrdw" >配合责任单位</th>
            <th width="60" formatter="Ams.tooltipFormat" field="phzrdwZrrlxfs" >责任人及联系方式</th>
        </tr>
        </thead>
    </table>
</div>

<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:990px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <table class="table insp-table">
            <input id="pkid" name="uuid" hidden="true"/>
            <tbody class="form-table">
            <tr>
                <td class="title tr">区县</td>
                <td class="con">
                    <input class="easyui-combobox" name="qx" value="${pointCode!}" id="regionName"
                            data-options="
									url:'${request.contextPath}/env/pollution2/getAllPollutionCity',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">污染源种类</td>
                <td class="con">
                    <input class="easyui-combobox" name="wryzl" value="${pointCode!}" id="regionName"
                           data-options="
									url:'${request.contextPath}/env/pollution2/data/getType?flag=wryzl&tblName=POLLUTION_INFO_DATA',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td class="title tr">污染源类型</td>
                <td class="con">
                    <input class="easyui-combobox" name="wrylx" value="${pointCode!}" id="regionName"
                           data-options="
									url:'${request.contextPath}/env/pollution2/data/getType?flag=wrylx&tblName=POLLUTION_INFO_DATA',
									method:'post',
									editable:false,
									valueField:'name',
						            textField:'name',
									multiple:false,
									panelHeight:'350px'"
                           style="width:200px;"/>
                </td>
                <td class="title tr">名称</td>
                <td class="con">
                    <input name="mc" data-options="validType:'maxLength[2550]'" id="builtValue" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
             <tr>
                <td class="title tr">存在问题</td>
                <td class="con">
                    <input name="czwt" id="address" data-options="validType:'maxLength[2550]'" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">整改措施</td>
                <td class="con">
                    <input name="zgcs" id="longitude" data-options="validType:'maxLength[2550]'" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
             <tr>
                <td class="title tr">治理项目</td>
                <td class="con">
                    <input name="zlxm" id="latitude" data-options="validType:'maxLength[2550]'" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">完成目标_2019年12月底</td>
                <td class="con">
                    <input name="wcmb201912" data-options="validType:'maxLength[1000]'" id="manageOrganization" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">完成目标_2020年6月底</td>
                <td class="con">
                    <input name="wcmb202006" id="managerPeoper" data-options="validType:'maxLength[1000]'" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">完成目标_2020年12月底</td>
                <td class="con">
                    <input name="wcmb202012" id="manaerPhone" data-options="validType:'maxLength[1000]'" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
             <tr>
                <td class="title tr">属地责任_责任单位</td>
                <td class="con">
                    <input name="sdzrZrdw" id="responOrganization" data-options="validType:'maxLength[250]'" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">属地责任_责任人及联系方式</td>
                <td class="con">
                    <input name="sdzrdwZrrlxfs" id="responPeopor" data-options="validType:'maxLength[255]'" prompt="例：张三138*****,王五139****" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">部门责任_责任单位</td>
                <td class="con">
                    <input name="bmzrZrdw" id="responPhone" data-options="validType:'maxLength[255]'" class="easyui-textbox"
                           style="width:100%">
                </td>
                <td class="title tr">部门责任_责任人及联系方式</td>
                <td class="con">
                    <input name="bmzrdwZrrlxfs" id="status" data-options="validType:'maxLength[255]'" prompt="例：张三138*****,王五139****" class="easyui-textbox"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">部门责任_配合责任单位</td>
                <td class="con">
                    <input name="bmzrPhzrdw" id="remark" class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%"> </td>
                <td class="title tr">部门责任_配合责任人及联系方式</td>
                <td class="con">
                    <input name="phzrdwZrrlxfs" id="scale" class="easyui-textbox" prompt="例：张三138*****,王五139****" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
            </tr>
            <tr>
                <td class="title tr">乡镇</td>
                <td class="con">
                    <input name="xz"  class="easyui-textbox" data-options="validType:'maxLength[1000]'"
                           style="width:100%"> </td>
                <td class="title tr">地址</td>
                <td class="con">
                    <input name="dz"  class="easyui-textbox" data-options="validType:'maxLength[1000]'"
                           style="width:100%">
                </td>
            </tr>
             <tr>
                <td class="title tr">经度</td>
                <td class="con">
                    <input name="jd"  class="easyui-textbox" prompt="例：117.58944" data-options="validType:'number'"
                           style="width:100%"> </td>
                <td class="title tr">纬度</td>
                <td class="con">
                    <input name="wd"  class="easyui-textbox" prompt="例：24.695" data-options="validType:'number'"
                           style="width:100%">
                </td>
            </tr>
             <tr>
                <td class="title tr">备注</td>
                <td class="con">
                    <input name="bz"  class="easyui-textbox" data-options="validType:'maxLength[255]'"
                           style="width:100%">
                </td>
<#--                 <td class="title tr">录入部门</td>-->
<#--                 <td class="con">-->
<#--                     <input name="entryDepartment" class="easyui-textbox" data-options="validType:'maxLength[255]'"-->
<#--                            style="width:100%" required>-->
<#--                 </td>-->
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="dlg-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveInfo()"
       style="width:90px">保存</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="$('#dlg').dialog('close')" style="width:90px">取消</a>
</div>

<input type="hidden" id="authority" value="${authority!}">
<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    Ams.inputText_enterKeyEvent("queryProjectName", doSearch);

    var pageType = $('#pageType').val();//alert("${type}")


    $(function () {
        if(pageType == "county"){

        }
        doSearch();
    });


    /**
     * 格式化列  --审核
     */
    function formataudit(value, row) {
        if (value == "0") {
            return "<span style='color:green'>已审核</span>"
        } else if (value == "1"){
            return "<span style='color:red'>未审核</span>"
        }else {
            return "<span >-</span>";
        }
    }

    /**
     * 格式化列  --数据有效性
     */
    function formatSatate(value, row) {
        if (value == "0") {
            return "<span style='color:green'>有效</span>"
        } else if (value == "1") {
            return "<span style='color:red'>无效</span>";
        } else {
            return "<span >-</span>";
        }
    }

    /**
     * 新增
     * @type {string}
     */
    var url = '';

    function newInfo() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增污染源信息');
        url = Ams.ctxPath + '/env/pollution2/data/saveInfo';
    }

    /**
     * 编辑
     * @type {string}
     */
    function editInfo() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改污染源信息');
            $('#fm').form('load', row);
            url = Ams.ctxPath + '/env/pollution2/data/saveInfo';
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    /**
     * 删除
     * @type {string}
     */
    function deleteInfo() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    var loadIndex = '';
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/env/pollution2/data/deleteInfo',
                        data: {
                            'pkid': row.uuid
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
    function saveInfo() {
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
                    $.messager.alert('错误提示', result.message);
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
     * 导入
     **/
    $('#importFile').filebox({
        buttonText: '批量导入',
        buttonAlign: 'center',
        buttonIcon: 'iconcustom icon-xiazai1',
        clear:true ,
        onChange: function (newVal,oldVal) {
            var suffix = newVal.substring(newVal.lastIndexOf('.') + 1, newVal.length);
            if (suffix != 'xls' && suffix !='xlsx') {
                Ams.error('只能导入后缀为xls或xlsx的文件');
                return;
            }
            $.messager.confirm("提示信息", "确认导入文件：<br/>"+newVal+"？", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '数据导入中......', text: ''});
                    $('#uplodFile').form('submit', {
                        url: Ams.ctxPath + "/env/pollution2/data/importFile",
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
                                $.messager.confirm("提示信息",result.message);
                            } else {
                                Ams.success(result.message);
                            }
                            $("#filebox_file_id_2").val('');
                            $.messager.progress('close');
                            doSearch();
                        }
                    });
                } else {
                    $("#filebox_file_id_2").val('');
                }
            });
        }
    })
    //导入模板下载
    function downloadFile(){
        var $eleForm = $("<form method='get'></form>");
        $eleForm.attr("action","${request.contextPath}/static/js/moudles/pollution/templates/污染源数据录入模板.xls");
        $(document.body).append($eleForm);
        //提交表单，实现下载
        $eleForm.submit();
    }

    function exportData() {
        window.open(Ams.ctxPath + '/env/pollution2/data/${type}/getInfoPage?export=yes&mc='+$("#queryProjectName").val());
    }

    /**
     * 查询
     * @type {string}
     */
    function doSearch() {
        $('#dg').datagrid({
            url: "/env/pollution2/data/${type}/getInfoPage",
            queryParams: {
                mc: $("#queryProjectName").val(),

            },onDblClickRow: function (index, row) {
                editInfo();
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
    
    /**
     * 设置电话号码
     */
    function setPhone() {
        var title = '多个号码格式：138*****,181*****';
        var currentUserUuid = "";
        var currentUserPhone = "";
        $.ajax({
            type : "POST",
            url : Ams.ctxPath + '/env/pollution/getUserInfo',
            dataType : 'json',
            success : function(result) {
                currentUserUuid = result.user.uuid;
                currentUserPhone = result.user.phone;
                layer.prompt({
                    title : title,
                    formType : 2,
                    value : currentUserPhone
                }, function(pass, index) {
                    var phs = pass.replace(/，/g, ",").split(",");
                    for (var i = 0; i < phs.length; i++) {
                        if (!Ams.isNoEmpty(phs[i])
                                || !/^(?:13\d|15\d|17\d|18\d)-?\d{5}(\d{3}|\*{3})$/
                                        .test(phs[i])) {
                            layer.msg('手机号码为空或手机号码格式不正确');
                            return;
                        }
                    }
                    layer.close(index);
                    $.ajax({
                        type : "POST",
                        url : Ams.ctxPath + '/env/pollution/setPhone',
                        dataType : 'json',
                        data : {
                            phone : pass,
                            uuid : currentUserUuid
                        },
                        success : function() {
                            layer.msg('操作成功');
                            $('#telTable').datagrid('reload');
                        },
                        error : function() {
                            layer.msg('保存失败');
                            $('#telTable').datagrid('reload');
                        }

                    });
                });
            }
        });
    }
</script>
</body>
</html>