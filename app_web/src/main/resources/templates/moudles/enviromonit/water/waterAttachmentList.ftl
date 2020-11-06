<#ftl attributes={"content_type":"text/html;charset=UTF-8"}>
<#assign sec=JspTaglibs["http://www.springframework.org/security/tags"]/>
<html lang="en">
<head>
    <title>附件列表</title>
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
                <label class="control-label">站点名称:</label>
                <input class="easyui-combobox" name="queryPoint" value="${pointCode!}" id="queryPoint" prompt="全部"
                       data-options="
						url:'/enviromonit/water/wtCityPoint/getPointList?type=0',
						method:'get',
						editable:false,
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'350px'"
                       style="width:200px;">
                <label class="control-label">附件类型:</label>
                <select name="queryType" id="queryType" class="easyui-combobox" style="width:200px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="0">其他</option>
                    <option value="1">PDF文档</option>
                    <option value="2">图片</option>
                    <option value="3">视频</option>
                </select>
                <label class="control-label">启用/禁用:</label>
                <select name="queryEnable" id="queryEnable" class="easyui-combobox" style="width:200px;">
                    <option value="" selected="selected">全部状态</option>
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton btn-refresh" data-options="iconCls:'icon-arrow_refresh_small'"
                   onclick="doReset()">重置</a>
            </form>
        </div>
        <@sec.authorize access="hasRole('ROLE_USER') OR hasRole('ROLE_ADMIN')">
            <a href="javascript:void(0)" class="easyui-linkbutton btn-primary" data-options="iconCls:'icon-add'" onclick="newActach()">新增</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-blue" data-options="iconCls:'icon-edit'" onclick="editActach()">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton btn-red" data-options="iconCls:'icon-delete'" onclick="deleteActach()">删除</a>
        </@sec.authorize>
    </div>

    <table id="dg" class="easyui-datagrid" style="width:100%;height:auto;" toolbar="#toolbar"
           data-options="
            rownumbers:true,
            singleSelect:true,
            striped:true,
            autoRowHeight:true,
            fitColumns:true,
            fit:true,
            pagination:true,
            pageSize:20,
            pageList:[10,20,30]">
        <thead>
        <tr>
            <th field="pointName" width="120px" formatter="Ams.tooltipFormat">站点名称</th>
            <th field="type" width="120px" formatter="Ams.formatAttachType">附件类型</th>
            <th field="name" width="120px" formatter="formatView">附件</th>
            <th field="isShow" width="120px" formatter="Ams.formatEnableSave">是否在详情页中显示</th>
            <th field="enable" width="120px" formatter="Ams.formatEnable">状态</th>
            <th field="remark" width="120px" formatter="Ams.tooltipFormat">备注</th>
            <th field="updateDate" width="120px" formatter="Ams.timeDateFormat">修改时间</th>
        </tr>
        </thead>
    </table>
</div>
<!-- dialog1 -->
<div id="dlg" class="easyui-dialog" style="width:500px"
     data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
    <input value="${pointCode!}" id="pointCodeId" type="hidden">
    <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
        <input id="uuid" name="uuid" hidden="true"/>
        <input id="pointName" name="pointName" hidden="true"/>

        <div style="margin-bottom:10px">
            <input class="easyui-combobox" name="pointCode" id="pointCode" label="站点:" required="true"
                   data-options="
						url:'/enviromonit/water/wtCityPoint/getPointList?type=0',
						method:'get',
						editable:false,
						valueField:'id',
						textField:'text',
						multiple:false,
						panelHeight:'350px'"
                   style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <input class="easyui-filebox" label="上传文件:" data-options="required:true,buttonText:'选择文件',accept:''"
                   style="width:100%"
                   onchange="onchange(newVal,oldVal)" id="file" name="file"/>
        </div>
        <div style="margin-bottom:10px">
            <input name="name" id="fileNameId" class="easyui-textbox" required="true" label="附件名称:" style="width:100%">
        </div>
        <div style="margin-bottom:10px">
            <select name="type" id="typeId" class="easyui-combobox" data-options="required:true,editable:false"
                    label="附件类型:"
                    style="width:100%">
                <option value="0">其他</option>
                <option value="1">PDF文档</option>
                <option value="2">图片</option>
                <option value="3">视频</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <select name="isShow" id="isShowId" class="easyui-combobox" data-options="required:true,editable:false"
                    label="是否显示:" style="width:100%">
                <option value="1">是</option>
                <option value="0">否</option>
            </select>
        </div>
        <div style="margin-bottom:10px">
            <select name="enable" id="enableId" class="easyui-combobox" data-options="required:true,editable:false"
                    label="启用/禁用:" style="width:100%">
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </div>

        <!-- <div style="margin-bottom:10px">
        	<span><font color="red">*&nbsp;&nbsp;&nbsp;请上传 *.png、*.jpe、*.jpeg、*.jpg 格式图片</font></span>
        </div> -->
        <div style="margin-bottom:10px">
            <input name="remark" class="easyui-textbox" data-options="label:'备注:'" multiline="true"
                   style="width:100%;height:120px">
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

<script>
    $.parser.onComplete = function () {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    };
    var myVideo = document.getElementById("video");//获取video对象
    // 关闭视频后关闭声音
    $("#videoDlg").dialog({
        onClose: function () {
            myVideo.pause();
        }
    });
    $(function () {
        doSearch();
    });

    function formatView(value, row, index) {
        var mongoid = row.mongoid;
        if (row.type == 3) {
            return "<div>" + Ams.setImageDown() + "<a href='javascript:onClick=play(\"" + row.mongoid + "\")' class='easyui-linkbutton'>" + row.name + "</a></div>";
        } else {
            return "<div>" + Ams.setImageDown() + "<a href='/environment/waterAttachment/download/" + row.mongoid + "/" + row.type
                + "' class='easyui-linkbutton' target='_blank'>" + row.name + "</a></div>";
        }
    }

    function play(mongoid) {
        $('#videoDlg').dialog('open').dialog('center').dialog('setTitle', '视频播放');
        //$('#video').attr("src", Ams.ctxPath+'/static/111.mp4');
        $('#video').attr("src", Ams.ctxPath + '/environment/waterAttachment/download/' + mongoid + '/3');
    }

    function newActach() {
        $('#fm').form('clear');
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增附件');
        $('#isShowId').combobox('setValue', '1');
        $('#enableId').combobox('setValue', '1');
        $('#pointCode').combobox('readonly', false);
        if (Ams.isNoEmpty($('#queryPoint').combobox('getValue'))) {
            $('#pointCode').combobox('setValue', $('#queryPoint').combobox('getValue'));
        }
        $("#file").filebox({required: true});
        url = Ams.ctxPath + '/environment/waterAttachment/save';
    }

    //判断文件类型赋值
    $('#file').filebox({
        onChange: function (newValue, oldValue) {
            var suffix = newValue.substring(newValue.lastIndexOf('.') + 1, newValue.length);
            var filename = newValue.substring(0, newValue.lastIndexOf('.'));
            $('#fileNameId').textbox('setValue', filename);
            if (suffix == 'pdf') {
                $('#typeId').combobox('setValue', '1');
            } else if (suffix == 'mp4' || suffix == 'mp3') {
                $('#typeId').combobox('setValue', '3');
            } else if (suffix == 'png' || suffix == 'jpg' || suffix == 'gif' || suffix == 'bmp') {
                $('#typeId').combobox('setValue', '2');
            } else {
                $('#typeId').combobox('setValue', '0');
            }
        }
    });


    function editActach() {
        $('#fm').form('clear');
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.ajax({
                type: 'POST',
                url: Ams.ctxPath + '/environment/waterAttachment/get',
                data: {'uuid': row.uuid},
                success: function (result) {
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改附件信息');
                    $('#fm').form('load', result.result);
                    $('#pointCode').combobox('readonly', true);
                    $("#file").filebox({required: false});
                    $('#file').filebox({prompt: row.name});
                    url = Ams.ctxPath + '/environment/waterAttachment/save';
                },
                dataType: 'json'
            });
        } else {
            $.messager.alert('提示', '请选择一条要编辑的记录！');
        }
    }

    function deleteActach() {
        var row = $('#dg').datagrid('getSelected');
        if (row) {
            $.messager.confirm("提示信息", "确认删除当前选中的记录吗", function (r) {
                if (r) {
                    $.messager.progress({title: '提示', msg: '请求执行中......', text: ''});
                    $.ajax({
                        type: 'POST',
                        url: Ams.ctxPath + '/environment/waterAttachment/delete',
                        data: {'uuid': row.uuid, "mongoid": row.mongoid},
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

    function saveActach() {
        $("#pointName").val($("#pointCode").combobox('getText'));
        var loadIndex = '';
        $('#fm').form('submit', {
            url: url,
            iframe: false,
            onSubmit: function () {
                if (!$(this).form('validate')) {
                    Ams.wornMsg('请先填写必填项！');
                }else{
                    loadIndex = layer.load(1, {
                        shade: [0.1, '#fff']
                    });
                }
                return $(this).form('validate');

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
                layer.close(loadIndex);
            }
        });
    }

    function doSearch() {
        var enableVal = $("#queryEnable").combobox('getValue');
        var typeVal = $("#queryType").combobox('getValue');
        if ($("#queryEnable").combobox('getValue') == '全部状态') {
            enableVal = '';
        }
        if ($("#queryType").combobox('getValue') == '全部状态') {
            typeVal = '';
        }
        $('#dg').datagrid({
            url: "/environment/waterAttachment/list",
            queryParams: {
                pointCode: $("#queryPoint").val(),
                enable: enableVal,
                type: typeVal,
            }
        })
    }

    function doReset() {
        $("#searchBar").find("#searchForm").form('clear');
        doSearch();
    }
</script>
</body>
</html>